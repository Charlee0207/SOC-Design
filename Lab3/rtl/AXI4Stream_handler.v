module AXI4Stream_handler
#(  parameter pADDR_WIDTH = 12,
    parameter pDATA_WIDTH = 32,
    parameter Tape_Num    = 11
)
(
    // AXI4-Stream slave (receive X[n])
    input   wire                     ss_tvalid, 
    input   wire [(pDATA_WIDTH-1):0] ss_tdata, 
    input   wire                     ss_tlast, 
    output  reg                      ss_tready, 
    // AXI4-Stream master (transmit Y[n])
    input   wire                     sm_tready, 
    output  reg                      sm_tvalid, 
    output  wire [(pDATA_WIDTH-1):0] sm_tdata, 
    output  reg                      sm_tlast, 

    input   wire [2:0]               FSM_cur_state,
    output  wire                     ss_done,
    output  reg                      sm_done,
    output  wire [(pDATA_WIDTH-1):0] X_new_in,
    input   wire [(pDATA_WIDTH-1):0] Y_new_out,

    output  reg                      data_WE,
    output  wire                     data_Di,

    input   wire                     axis_clk,
    input   wire                     axis_rst_n

);
begin

`include "parameter.vh"

    assign X_new_in = ss_tdata;
    assign data_Di = ss_tdata;
    assign ss_done = ss_tready;
    assign sm_tdata = Y_new_out;

    //***Handling slave channel***
    always@(posedge axis_clk) begin
        if(!axis_rst_n) begin
            ss_tready <= 0;
            data_WE <= 0;
        end
        else if(FSM_cur_state==STREAM_IN) begin
            if(!ss_tvalid && !ss_tready && !data_WE) begin
                ss_tready <= 0;
                data_WE <= 0;
            end
            else if(ss_tvalid && !ss_tready && !data_WE) begin
                ss_tready <= 0;
                data_WE <= 1;
            end
            else if(ss_tvalid && !ss_tready && data_WE) begin
                ss_tready <= 1;
                data_WE <= 0;
            end
            else begin
                ss_tready <= 0;
                data_WE <= 0;
            end
        end
        else begin
            ss_tready <= 0;
            data_WE <= 0;
        end
    end

    //***Handling master channel***
    always@(posedge axis_clk) begin
        if(!axis_rst_n) begin
            sm_tvalid <= 0;
            sm_tlast <= 0;
            sm_done <= 0;
        end
        else if(FSM_cur_state==STREAM_OUT) begin
            if(!sm_tvalid && !sm_done) begin
                sm_tvalid <= 1;
                sm_tlast <= 0;
                sm_done <= 0;
            end
            else if(!sm_tvalid && sm_done) begin
                sm_tvalid <= 0;
                sm_tlast <= 0;
                sm_done <= 0;
            end
            else if(sm_tvalid && !sm_tready) begin
                sm_tvalid <= 1;
                sm_tlast <= 1;
                sm_done <= 0;
            end
            else if(sm_tvalid && sm_tready) begin
                sm_tvalid <= 0;
                sm_tlast <= 0;
                sm_done <= 1;
            end
            else begin
                sm_tvalid <= 0;
                sm_tlast <= 0;
                sm_done <= 0;
            end
        end
        else begin
                sm_tvalid <= 0;
                sm_tlast <= 0;
                sm_done <= 0;
        end
    end

end
endmodule