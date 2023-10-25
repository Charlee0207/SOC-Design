module AXI4Lite_handler
#(  localparam pADDR_WIDTH = 12,
    parameter pDATA_WIDTH = 32,
    parameter Tape_Num    = 11
)(
    // AXI4-Lite Write Transaction (coef[Tape_Num-1:0](0x20-0x4B), len(0x10-13), ap_start(0x00))
    output  reg                      awready,   // M <- S
    output  reg                      wready,    // M <- S
    input   wire                     awvalid,   // M -> S
    input   wire [(pADDR_WIDTH-1):0] awaddr,    // M -> S
    input   wire                     wvalid,    // M -> S
    input   wire [(pDATA_WIDTH-1):0] wdata,     // M -> S
    // AXI4-Lite Read Transaction (coef[Tape_Num-1:0](0x20-0x4B), ap_start(0x00), ap_done(0x01), ap_idle(0x02))
    output  reg                      arready,   // M <- S
    input   wire                     rready,    // M -> S
    input   wire                     arvalid,   // M -> S
    input   wire [(pADDR_WIDTH-1):0] araddr,    // M -> S
    output  reg                      rvalid,    // M <- S
    output  reg  [(pDATA_WIDTH-1):0] rdata,     // M <- S
    

    input   wire                     axis_clk,
    input   wire                     axis_rst_n,

    output reg ap_start_active,     // use semophore to controll ap_start
    output reg ap_done_read,        // use semophore to indicate ap_done was read
    input wire ap_start, ap_done, ap_idle,

    output wire[(pDATA_WIDTH-1):0] bram_Di,
    input wire [(pDATA_WIDTH-1):0] bram_Do,
    output reg [3:0] bram_A,     // bram has only 11 32-bit storage
    output reg bram_WE,
    output reg [1:0] bram_sel
);
begin

`include "parameter.vh"

    localparam NONE = 2'b00;
    localparam TAP  = 2'b10;
    localparam DATA = 2'b11;

    reg read_flag, write_flag;

    assign bram_Di = (bram_WE) ? wdata : 0;

    // AXI4-Lite handler begin
    /*
        1.  This handler would first response to the write request,
            if read/write requests are simultaneous 
        2.  awready/arready signals are actually flag,
            which is depend on whether the w/r status is
    */
    always@(posedge axis_clk) begin
        if(!axis_rst_n) begin
            awready <= 0;
            wready <= 0;
            write_flag <= 0;

            arready <= 0;
            rvalid <= 0;
            rdata <= 0;
            read_flag <= 0;

            bram_A <= 0;
            // bram_Di <= 0;
            bram_WE <= 0;
            bram_sel <= NONE;

            ap_done_read <= 0;
            ap_start_active <= 0;
        end
        else begin
            //***Handling write address channel***
            // Check awvalid and write status, and assert awready
            if(awvalid && !write_flag) begin    
                awready <= 1;
                wready <= 0;
                write_flag <= 1;
                case(awaddr)
                    12'h00: begin                // ap_start
                        ap_start_active <= 1;
                        bram_WE <= 0;
                        bram_sel <= NONE;
                        bram_A <= 0;
                    end
                    12'h10: begin                // length
                        ap_start_active <= 0;
                        bram_WE <= 0;
                        bram_sel <= DATA;
                        bram_A <= 0;
                    end
                    12'h20, 12'h24, 12'h28, 12'h2C, 
                    12'h30, 12'h34, 12'h38, 12'h3C, 
                    12'h40, 12'h44, 12'h48: begin// coef
                        ap_start_active <= 0;
                        bram_WE <= 0;
                        bram_sel <= TAP;
                        bram_A <= ((awaddr[5:0]-6'h20)>>2);
                    end
                    default: begin
                        ap_start_active <= 0;
                        bram_WE <= 0;
                        bram_sel <= bram_sel;
                        bram_A <= bram_A;
                    end
                endcase
            end
            // Deassert awready and assert wready
            else if(awvalid && awready && write_flag) begin
                ap_start_active <= 0;
                awready <= 0;
                wready <= 1;
                write_flag <= 1;
                bram_WE <= 1;
                bram_sel <= bram_sel;
                bram_A <= bram_A;
                // bram_Di <= wdata;
            end
            //***Handling write data channel***
            // master hasn't assertted wvalid yet
            else if(wready && !wvalid && write_flag) begin
                ap_start_active <= 0;
                awready <= 0;
                wready <= 1;
                write_flag <= 1;
                bram_WE <= 1;
                bram_sel <= bram_sel;
                bram_A <= bram_A;
                // bram_Di <= wdata;
            end
            // master assert wvalid, transmit data and deassert wready and write flag
            else if(wready && wvalid && write_flag) begin
                ap_start_active <= 0;
                awready <= 0;
                wready <= 0;
                write_flag <= 0;
                bram_WE <= 0;
                bram_sel <= NONE;
                bram_A <= 0;
                // bram_Di <= 0;
            end
            // Write transaction failed, reset all bit
            else begin
                ap_start_active <= 0;
                awready <= 0;
                wready <= 0;
                write_flag <= 0;
                // bram_WE <= 0;
                // bram_sel <= NONE;
                // bram_A <= 0;
                // bram_Di <= 0;
            end

            //=========================================================

            //***Handling read address channel***
            // Check arvalid and read/write status, and assert arready
            if(arvalid && !read_flag && !write_flag) begin    
                arready <= 1;
                rvalid <= 0;
                read_flag <= 1;
                case(araddr)
                    12'h00: begin                // ap_start
                        rdata <= {29'b0, ap_idle, ap_done, ap_start}; 
                        ap_done_read <= 1;
                        bram_sel <= NONE;
                        bram_A <= 0;
                    end
                    12'h10: begin               // length
                        rdata <= 0; // wait for bram transaction later 
                        ap_done_read <= 0;
                        bram_sel <= DATA;
                        bram_A <= 0;
                    end
                    12'h20, 12'h24, 12'h28, 12'h2C, 
                    12'h30, 12'h34, 12'h38, 12'h3C, 
                    12'h40, 12'h44, 12'h48: begin// coef
                        rdata <= 0; // wait for bram transaction later 
                        ap_done_read <= 0;
                        bram_sel <= TAP;
                        bram_A <= ((araddr[5:0]-6'h20)>>2);
                    end
                    default: begin
                        rdata <= 0;  
                        ap_done_read <= 0;
                        bram_sel <= NONE;
                        bram_A <= 0;
                    end
                endcase
            end
            // Deassert arready, and select rdata
            else if(arvalid && arready && read_flag && !write_flag) begin
                arready <= 0;
                rvalid <= 0;
                read_flag <= 1;
                rdata <= rdata; 
                ap_done_read <= ap_done_read;
                bram_sel <= bram_sel;
                bram_A <= bram_A;
            end
            //***Handling read data channel***
            // slave hasn't read yet
            else if(rready && !rvalid && read_flag && !write_flag) begin
                arready <= 0;
                rvalid <= 1;
                rdata <= (bram_sel==NONE)   ? rdata
                                            : bram_Do;
                read_flag <= 1;
                ap_done_read <= 0;
                bram_sel <= bram_sel;
                bram_A <= bram_A;
            end
            // slave assert rvalid, transmit data and deassert rvalid and read flag
            else if(rready && rvalid && read_flag && !write_flag) begin
                arready <= 0;
                rvalid <= 0;
                rdata <= rdata;
                read_flag <= 0;
                ap_done_read <= 0; 
                bram_sel <= NONE;
                bram_A <= 0;
            end
            // Read transaction failed, reset all bit
            else begin
                arready <= 0;
                rvalid <= 0;
                // rdata <= rdata;
                read_flag <= 0;
                // ap_done_read <= 0; 
                // bram_sel <= bram_sel;
                // bram_A <= bram_A;
            end
        end
    end
    // AXI4-Lite handler end

end
endmodule