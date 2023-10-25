module length_handler
#(  parameter pADDR_WIDTH = 12,
    parameter pDATA_WIDTH = 32,
    parameter Tape_Num    = 11
)
(
    // bram for data RAM
    output  wire [(pDATA_WIDTH-1):0] data_Di,
    input   wire [(pDATA_WIDTH-1):0] data_Do,
    output  reg                      data_WE,

    input   wire [2:0]               FSM_cur_state,
    output  reg                      length_done,
    output  reg                      last,

    input   wire                     axis_clk,
    input   wire                     axis_rst_n
);
begin

`include "parameter.vh"


assign data_Di = data_Do - 1;

reg [(pADDR_WIDTH-1):0] addr;
reg [1:0] cycle_counter;

always@(posedge axis_clk) begin
    if(!axis_rst_n) 
        cycle_counter <= 0;
    else if(FSM_cur_state==CHECK_LEN)
        cycle_counter <= cycle_counter + 1;
    else 
        cycle_counter <= 0;
end

always@(posedge axis_clk) begin
    if(!axis_rst_n) begin
        addr <= 0;
        data_WE <= 0;
        length_done <= 0;
        last <= 0;
    end
    else if(FSM_cur_state==IDLE) begin
        addr <= 0;
        data_WE <= 0;
        length_done <= 0;
        last <= 0;
    end
    else if(FSM_cur_state==CHECK_LEN) begin
        case(cycle_counter)
            'd0: begin
                addr <= 0;
                data_WE <= 0;
                length_done <= 0;
                last <= last;
            end
            'd1: begin
                addr <= 0;
                data_WE <= 1;
                length_done <= 0;
                last <= last;
            end
            'd2: begin
                addr <= 0;
                data_WE <= 0;
                length_done <= 1;
                last <= (data_Do==1) ? 1 : 0;   // the last one to be process, we should assert last
            end
            'd3: begin
                addr <= 0;
                data_WE <= 0;
                length_done <= 0;
                last <= last;
            end
            default: begin
                addr <= 0;
                data_WE <= 0;
                length_done <= 0;
                last <= last;
            end
        endcase
    end
    else begin
        addr <= 0;
        data_WE <= 0;
        length_done <= 0;
        last <= last;
    end
end

end
endmodule