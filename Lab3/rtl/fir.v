//`include "AXI4Lite_handler.v"
//`include "length_handler.v"
//`include "fir_engine.v"
//`include "AXI4Stream_handler.v"

module fir 
#(  parameter pADDR_WIDTH = 12,
    parameter pDATA_WIDTH = 32,
    parameter Tape_Num    = 11
)
(
    // AXI4-Lite Write Transaction (coef[Tape_Num-1:0](0x20-0x4B), len(0x10-13), ap_start(0x00))
    output  wire                     awready,   
    output  wire                     wready,    
    input   wire                     awvalid,   
    input   wire [(pADDR_WIDTH-1):0] awaddr,    
    input   wire                     wvalid,    
    input   wire [(pDATA_WIDTH-1):0] wdata,     
    // AXI4-Lite Read Transaction (ap_start(0x00), ap_done(0x01), ap_idle(0x02))
    output  wire                     arready,   
    input   wire                     rready,    
    input   wire                     arvalid,   
    input   wire [(pADDR_WIDTH-1):0] araddr,    
    output  wire                     rvalid,    
    output  wire [(pDATA_WIDTH-1):0] rdata,     
    // AXI4-Stream slave (receive X[n])
    input   wire                     ss_tvalid, 
    input   wire [(pDATA_WIDTH-1):0] ss_tdata, 
    input   wire                     ss_tlast, 
    output  wire                     ss_tready, 
    // AXI4-Stream master (transmit Y[n])
    input   wire                     sm_tready, 
    output  wire                     sm_tvalid, 
    output  wire [(pDATA_WIDTH-1):0] sm_tdata, 
    output  wire                     sm_tlast, 
    
    // bram for tap RAM
    output  wire [3:0]               tap_WE,
    output  wire                     tap_EN,
    output  wire [(pDATA_WIDTH-1):0] tap_Di,
    output  wire [(pADDR_WIDTH-1):0] tap_A,
    input   wire [(pDATA_WIDTH-1):0] tap_Do,

    // bram for data RAM
    output  wire [3:0]               data_WE,
    output  wire                     data_EN,
    output  wire [(pDATA_WIDTH-1):0] data_Di,
    output  wire [(pADDR_WIDTH-1):0] data_A,
    input   wire [(pDATA_WIDTH-1):0] data_Do,

    input   wire                     axis_clk,
    input   wire                     axis_rst_n




    ,
    output wire [2:0] FSM_cur_state_wire, 
    output wire fir_done_wire, ss_done_wire, sm_done_wire, length_done_wire, last_wire,
    output wire ap_start_wire, ap_done_wire, ap_idle_wire,

    output wire [(pDATA_WIDTH-1):0] Y,
    output wire [(pDATA_WIDTH-1):0] X,
    output wire [3:0] data_index_wire,
    output wire [3:0] fir_data_A_wire
);
begin
    





    
`include "parameter.vh"

    //==================== FSM block start ====================
    // parameter IDLE = 3'b000;
    // parameter CHECK_LEN = 3'b001
    // parameter STREAM_IN = 3'b010;
    // parameter FIR_COMP = 3'b011;
    // parameter STREAM_OUT = 3'b100;
    // parameter DONE = 3'b101;

    reg [2:0] FSM_cur_state;
    reg [2:0] FSM_next_state;

    wire fir_done, ss_done, sm_done, length_done, last;

    reg ap_start, ap_done, ap_idle;
    wire ap_start_active, ap_done_read;

    wire [(pDATA_WIDTH-1):0] Y_new_out_wire;

    // FSM sequential block
    always@(posedge axis_clk)begin
        if(!axis_rst_n) FSM_cur_state <= IDLE;
        else FSM_cur_state <= FSM_next_state;
    end
    // FSM combinational block
    always@(*)begin
    case(FSM_cur_state)

        IDLE: begin
            if(ap_start) FSM_next_state = CHECK_LEN;
            else FSM_next_state = FSM_cur_state;
        end
        
        // update the data length, it will sub length by one
        CHECK_LEN: begin
            if(length_done) FSM_next_state = STREAM_IN;
            else FSM_next_state = FSM_cur_state;
        end
        // axis slave receive new X data, until ss_done is asserted
        STREAM_IN: begin
            if(ss_done) FSM_next_state = FIR_COMP;
            else FSM_next_state = FSM_cur_state;
        end
        
        // fir engine do the computation, until fir_done is asserted
        FIR_COMP: begin
            if(fir_done) FSM_next_state = STREAM_OUT;
            else FSM_next_state = FSM_cur_state;
        end

        // axis master transmit new accumulation Y data, until sm_done is assereted
        STREAM_OUT: begin
            if(sm_done) FSM_next_state = DONE;
            else FSM_next_state = FSM_cur_state;
        end

        // check whether continue fir or goto idle
        DONE: begin
            if(last) FSM_next_state = IDLE;
            else FSM_next_state = CHECK_LEN;
        end

        default: begin
            FSM_next_state = FSM_cur_state;
        end  

    endcase
    end
    //====================  FSM block end  ====================

    //==================== update X block start ==================== 
    reg [(pADDR_WIDTH-1):0] X_new_in_reg;
    wire [(pADDR_WIDTH-1):0] X_new_in_wire;
    always@(posedge axis_clk) begin
        if(!axis_rst_n) X_new_in_reg <= 0;
        else X_new_in_reg <= X_new_in_wire;
    end
    //====================  update X block end  ==================== 
    
    //==================== update data index block start ==================== 
    reg [3:0] data_index;
    always@(posedge axis_clk) begin
        if(!axis_rst_n)
            data_index <= 'd1;
        else begin
            if(FSM_cur_state==IDLE)
                data_index <= 'd1;
            else if(FSM_next_state==CHECK_LEN && FSM_cur_state==DONE)
                data_index <= (data_index=='d10) ? 'd1 : data_index + 1;
            else 
                data_index <= data_index;
        end        
    end
    //====================  update data index block end  ====================

    //==================== memory controller block start ====================
    
    // update ap_start at posedge clk
    always@(posedge axis_clk) begin
        if(!axis_rst_n) 
            ap_start <= 0;
        else if(FSM_cur_state==IDLE && FSM_next_state==IDLE) 
            ap_start <= ap_start_active;
        else if(FSM_cur_state==IDLE && FSM_next_state==CHECK_LEN)
            ap_start <= 0;
    end
    // update ap_done
    always@(posedge axis_clk) begin
        if(!axis_rst_n) 
            ap_done <= 0;
        // deassert ap_done when ap_done was read
        // else if(ap_done_read)   
        //     ap_done <= 0;
        // assert ap_done when finished process and transection
        else if(FSM_next_state==DONE && last) 
            ap_done <= 1;
        else     
            ap_done <= ap_done;
    end
    // update ap_idle
    always@(posedge axis_clk) begin
        if(!axis_rst_n) 
            ap_idle <= 1;
        else if(ap_start) 
            ap_idle <= 0;
        // assert ap_idle when fir finished last processing
        else if(FSM_next_state==STREAM_OUT && last)
            ap_idle <= 1;
        else 
            ap_idle <= ap_idle;
    end

    // manage bram access using conditional assignment

    // ports of axilite
    wire                        axilite_bram_WE;
    wire [(pDATA_WIDTH-1):0]    axilite_bram_Di;
    wire [(pDATA_WIDTH-1):0]    axilite_bram_Do;
    wire [3:0]                  axilite_bram_A;     // bram has only 11 32-bit storage
    wire [1:0]                  axilite_bram_sel;
    // ports of axis
    wire                        axis_data_WE;
    wire [(pDATA_WIDTH-1):0]    axis_data_Di;
    // ports of length
    wire                        len_data_WE;
    wire [(pDATA_WIDTH-1):0]    len_data_Di;
    wire [(pDATA_WIDTH-1):0]    len_data_Do;
    // ports of fir
    wire [(pDATA_WIDTH-1):0]    fir_tap_Do;
    wire [(pDATA_WIDTH-1):0]    fir_data_Do;
    wire [3:0]                  fir_tap_A;
    wire [3:0]                  fir_data_A;



    // bram for tap RAM
    assign tap_WE =  (FSM_cur_state==IDLE && axilite_bram_sel==2'b10) 
                    ?{axilite_bram_WE, axilite_bram_WE, axilite_bram_WE, axilite_bram_WE} 
                    :4'b0000;   

    assign tap_EN =  (FSM_cur_state==IDLE)      ? 1  
                    :(FSM_cur_state==CHECK_LEN) ? 0
                    :(FSM_cur_state==STREAM_IN) ? 0
                    :(FSM_cur_state==FIR_COMP)  ? 1
                    :(FSM_cur_state==STREAM_OUT)? 0
                    :(FSM_cur_state==DONE)      ? 0 
                    :0;
    assign tap_Di =  (FSM_cur_state==IDLE && axilite_bram_sel==2'b10) ? axilite_bram_Di
                    :(FSM_cur_state==CHECK_LEN) ? 0
                    :(FSM_cur_state==STREAM_IN) ? 0
                    :(FSM_cur_state==FIR_COMP)  ? 0
                    :(FSM_cur_state==STREAM_OUT)? 0
                    :(FSM_cur_state==DONE)      ? 0
                    :0;
    assign tap_A  =  (FSM_cur_state==IDLE && axilite_bram_sel==2'b10) ? {6'b0, axilite_bram_A, 2'b0}
                    :(FSM_cur_state==CHECK_LEN) ? 0
                    :(FSM_cur_state==STREAM_IN) ? 0
                    :(FSM_cur_state==FIR_COMP)  ? {6'b0, fir_tap_A, 2'b0}
                    :(FSM_cur_state==STREAM_OUT)? 0
                    :(FSM_cur_state==DONE)      ? 0
                    :0;
    assign fir_tap_Do=(FSM_cur_state==FIR_COMP) ? tap_Do
                                                : 0;


    // bram for data RAM
    assign data_WE = (FSM_cur_state==IDLE && axilite_bram_sel==2'b11) ? {axilite_bram_WE, axilite_bram_WE, axilite_bram_WE, axilite_bram_WE} 
                    :(FSM_cur_state==CHECK_LEN) ? {len_data_WE, len_data_WE, len_data_WE, len_data_WE}
                    :(FSM_cur_state==STREAM_IN) ? {axis_data_WE, axis_data_WE, axis_data_WE, axis_data_WE}
                    :4'b0000;

    assign data_EN = (FSM_cur_state==IDLE)      ? 1  
                    :(FSM_cur_state==CHECK_LEN) ? 1
                    :(FSM_cur_state==STREAM_IN) ? 1
                    :(FSM_cur_state==FIR_COMP)  ? 1
                    :(FSM_cur_state==STREAM_OUT)? 0
                    :(FSM_cur_state==DONE)      ? 0 
                    :0;
    assign data_Di = (FSM_cur_state==IDLE && axilite_bram_sel==2'b11) ? axilite_bram_Di
                    :(FSM_cur_state==CHECK_LEN) ? len_data_Di
                    :(FSM_cur_state==STREAM_IN) ? ss_tdata
                    :(FSM_cur_state==FIR_COMP)  ? 0
                    :(FSM_cur_state==STREAM_OUT)? 0
                    :(FSM_cur_state==DONE)      ? 0
                    :0;
    assign data_A =  (FSM_cur_state==IDLE && axilite_bram_sel==2'b11) ? {6'b0, axilite_bram_A, 2'b0}
                    :(FSM_cur_state==CHECK_LEN) ? 12'd0
                    :(FSM_cur_state==STREAM_IN) ? {6'b0, data_index, 2'b0}
                    :(FSM_cur_state==FIR_COMP)  ? {6'b0, fir_data_A, 2'b0}
                    :(FSM_cur_state==STREAM_OUT)? 0
                    :(FSM_cur_state==DONE)      ? 0
                    :0;

    assign len_data_Do=(FSM_cur_state==CHECK_LEN)   ? data_Do
                                                    : 0;
    assign fir_data_Do=(FSM_cur_state==FIR_COMP)    ? data_Do
                                                    : 0;

    assign axilite_bram_Do = (FSM_cur_state==IDLE)  ? 
                                                         (axilite_bram_sel==2'b10) ? tap_Do
                                                        :(axilite_bram_sel==2'b11) ? data_Do 
                                                        : 0
                                                    : 0;
    //====================  memory controller block end  ====================

    //==================== connecting block start ====================
    AXI4Lite_handler u_AXILITE(
            .awready(awready),
            .wready(wready),
            .awvalid(awvalid),
            .awaddr(awaddr),
            .wvalid(wvalid),
            .wdata(wdata),

            .arready(arready),
            .rready(rready),
            .arvalid(arvalid),
            .araddr(araddr),
            .rvalid(rvalid),
            .rdata(rdata),

            .axis_clk(axis_clk),
            .axis_rst_n(axis_rst_n),

            .ap_start_active(ap_start_active),
            .ap_done_read(ap_done_read),
            .ap_start(ap_start),
            .ap_done(ap_done),
            .ap_idle(ap_idle),

            .bram_Di(axilite_bram_Di),
            .bram_Do(axilite_bram_Do),
            .bram_A(axilite_bram_A),
            .bram_WE(axilite_bram_WE),
            .bram_sel(axilite_bram_sel)
    );

    length_handler u_LENGTH(
            .data_Di(len_data_Di),
            .data_Do(len_data_Do),
            .data_WE(len_data_WE),

            .axis_clk(axis_clk),
            .axis_rst_n(axis_rst_n),

            .FSM_cur_state(FSM_cur_state),
            .length_done(length_done),
            .last(last)
    );

    fir_engine u_FIR(
            .tap_Do(fir_tap_Do),
            .data_Do(fir_data_Do),
            .tap_A(fir_tap_A),
            .data_A(fir_data_A),

            .axis_clk(axis_clk),
            .axis_rst_n(axis_rst_n),

            .FSM_cur_state(FSM_cur_state),
            .fir_done(fir_done),
            .data_index(data_index),
            .X_new_in(ss_tdata),
            .Y_new_out(Y_new_out_wire)
    );


    AXI4Stream_handler u_AXIS(
            .ss_tvalid(ss_tvalid),
            .ss_tdata(ss_tdata),
            .ss_tlast(ss_tlast),
            .ss_tready(ss_tready),

            .sm_tready(sm_tready),
            .sm_tvalid(sm_tvalid),
            .sm_tdata(sm_tdata),
            .sm_tlast(sm_tlast),

            .axis_clk(axis_clk),
            .axis_rst_n(axis_rst_n),

            .FSM_cur_state(FSM_cur_state),
            .ss_done(ss_done),
            .sm_done(sm_done),
            // .X_new_in(X_new_in_wire),
            .Y_new_out(Y_new_out_wire),

            .data_WE(axis_data_WE)
            // .data_Di(axis_data_Di)
    );




    //====================  connecting block end  ====================
    







assign FSM_cur_state_wire = FSM_cur_state;
assign fir_done_wire = fir_done;
assign ss_done_wire  = ss_done;
assign sm_done_wire = sm_done;
assign length_done_wire = length_done;
assign last_wire = last;
assign ap_start_wire = ap_start;
assign ap_done_wire = ap_done;
assign ap_idle_wire = ap_idle;
assign Y = Y_new_out_wire;
assign X = X_new_in_reg;
assign data_index_wire = data_index;
assign fir_data_A_wire = fir_data_A;








end
endmodule 