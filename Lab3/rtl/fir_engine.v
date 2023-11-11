module fir_engine
#(  parameter pADDR_WIDTH = 12,
    parameter pDATA_WIDTH = 32,
    parameter Tape_Num    = 11
)
(
    input wire [(pDATA_WIDTH-1):0] tap_Do,
    input wire [(pDATA_WIDTH-1):0] data_Do,
    output reg [3:0] tap_A,
    output reg [3:0] data_A,
    input wire [(pDATA_WIDTH-1):0] X_new_in,
    output wire[(pDATA_WIDTH-1):0] Y_new_out,

    input wire [3:0] data_index,
    output reg fir_done,

    input wire [2:0] FSM_cur_state,

    input wire axis_clk,
    input wire axis_rst_n
);
begin

`include "parameter.vh"

    // reg [(pDATA_WIDTH-1):0] shift;  
    reg [(pDATA_WIDTH-1):0] accumulation;

    reg [3:0] cycle_counter;
    reg bram_valid;
    reg bram_filled;

    assign Y_new_out = accumulation;

    always@(posedge axis_clk) begin
        if(!axis_rst_n)
            bram_filled <= 0;
        else if(FSM_cur_state==IDLE)
            bram_filled <= 0;
        else if(data_index=='d10)
            bram_filled <= 1;
        else 
            bram_filled <= bram_filled;
    end

    always@(posedge axis_clk) begin
        if(!axis_rst_n)
            bram_valid <= 0;
        else if(FSM_cur_state==IDLE)
            bram_valid <= 0;
        else if(bram_filled)
            bram_valid <= 1;
        else if(tap_A<data_index)
            bram_valid <= 1;
        else 
            bram_valid <= 0;
    end

    // cycle_counter sequential block
    // only using cycle_counter is easier then create a new FSM
    always@(posedge axis_clk) begin
        if(!axis_rst_n)
            cycle_counter <= 0;
        else begin
            if(FSM_cur_state==FIR_COMP) 
                cycle_counter <= cycle_counter + 1;
            else
                cycle_counter <= 0;
        end
    end

    // fir engine block, and handles fir_done signal
    always@(posedge axis_clk) begin
        if(!axis_rst_n) begin
            tap_A <= 0;
            data_A <= 0;
            fir_done <= 0;
            // shift <= 0;
            accumulation <= accumulation;  
        end    
        else if(FSM_cur_state==IDLE)begin
            tap_A <= 0;
            data_A <= 0;
            fir_done <= 0;
            // shift <= 0;
            accumulation <= accumulation;   
        end    
        else if(FSM_cur_state==FIR_COMP)begin
            case(cycle_counter)
            'd0: begin
                tap_A <= 0;
                data_A <= data_index;
                fir_done <= 0;

                // shift <= 0;  
                accumulation <= accumulation;   
                // reverse the last Y_new_out result
                // the AXI-Stream out module may have not transferred done yet 
            end

            'd1: begin
                tap_A <= tap_A + 1;
                // we use read pointer to indicate where's the newest data in bram
                // we should maintain accessing bram in range
                data_A <= (data_A=='d1) ? 'd10 : data_A-1;
                fir_done <= 0;
                
                // shift <= 0;
                accumulation <= accumulation;   
            end

            // the coefficient in bram should be readable
            // do first computation of fir using new in X data and coefficient in bram
            'd2: begin  
                tap_A <= tap_A + 1;
                data_A <= (data_A=='d1) ? 'd10 : data_A-1;
                fir_done <= 0;  

                // shift <= tap_Do * X_new_in;
                // accumulation <= 0;   
                accumulation <= tap_Do * X_new_in;   
            end

            // the coefficient and X data in bram should be readable
            // do regular computation of fir using X data and coefficient in bram
            'd3, 'd4, 'd5, 'd6, 'd7,
            'd8, 'd9, 'd10,'d11: begin
                tap_A <= tap_A + 1;
                data_A <= (data_A=='d1) ? 'd10 : data_A-1;
                fir_done <= 0;

                // shift <= (bram_valid) ? tap_Do * data_Do : 0;
                // accumulation <= accumulation + shift;  
                accumulation <= (bram_valid) ? accumulation + tap_Do*data_Do : accumulation;   
            end  

            // assert fir_done signal and reset other addr
            'd12: begin
                tap_A <= 0;
                data_A <= 0;
                fir_done <= 1;

                // shift <= 0;
                // accumulation <= accumulation + shift;  
            end  

            // deassert fir_done signal and reset other addr
            'd13: begin
                tap_A <= 0;
                data_A <= 0;
                fir_done <= 0;

                // shift <= 0;
                accumulation <= accumulation;   
            end  
            default: begin
                tap_A <= 0;
                data_A <= 0;
                fir_done <= 0;

                // shift <= 0;
                accumulation <= accumulation; 
            end  
            endcase
        end
    end
end 
endmodule