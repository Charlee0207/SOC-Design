// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype wire
/*
 *-------------------------------------------------------------
 *
 * user_proj_example
 *
 * This is an example of a (trivially simple) user project,
 * showing how the user project can connect to the logic
 * analyzer, the wishbone bus, and the I/O pads.
 *
 * This project generates an integer count, which is output
 * on the user area GPIO pads (digital output only).  The
 * wishbone connection allows the project to be controlled
 * (start and stop) from the management SoC program.
 *
 * See the testbenches in directory "mprj_counter" for the
 * example programs that drive this user project.  The three
 * testbenches are "io_ports", "la_test1", and "la_test2".
 *
 *-------------------------------------------------------------
 */

module user_proj_example #(
    parameter BITS = 32,
    parameter DELAYS=10
)(
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [37:0] io_in,
    output [37:0] io_out,
    output [37:0] io_oeb,

    // IRQ
    output [2:0] irq
);
    wire clk;
    wire rst;

    

    wire [37:0] io_in;
    wire [37:0] io_out;
    wire [37:0] io_oeb;


    assign irq = 3'b000;	// Unused

    wire [31:0] DataIn;
    wire [31:0] DataOut;
    wire [3:0] WE0;
    wire EN0;
    wire [31:0] A0;
    wire Sel;
    reg ready;
    reg [3:0] cnt;


    assign io_out = DataOut;
    assign io_oeb = {(37){rst}};
    
    assign clk = (~la_oenb[64]) ? la_data_in[64]: wb_clk_i;
    assign rst = (~la_oenb[65]) ? la_data_in[65]: wb_rst_i;

    assign Sel = wbs_adr_i[31:23] == 9'h070 ;
    assign EN0 = wbs_cyc_i && wbs_stb_i && Sel;
    assign WE0 = wbs_sel_i & {4{wbs_we_i}}; 
    assign wbs_dat_o = DataOut;
    assign DataIn = wbs_dat_i;
    assign wbs_ack_o = ready;

    always @(posedge clk) begin
        if (rst ) begin
            ready <= 0;
        end else if (EN0 && !ready) begin
            ready <= 0;
            if (cnt == DELAYS) begin    
                cnt <= 4'b0;
                ready <= 1'b1;
            end else cnt <= cnt + 1;
        end else begin 
            cnt <= 0;
            ready <= 0;
        end
    end

    //assign A0 = (wbs_adr_i >= 32'h38000000) && (wbs_adr_i <= 32'h38400000) ? (wbs_adr_i & 32'h003FFFFF) : 32'b0;
    assign A0 = Sel ? (wbs_adr_i & 32'h003FFFFF) : 32'b0;
    

    bram user_bram (
        .CLK(clk),
        .WE0(WE0),
        .EN0(EN0),
        .Di0(DataIn),
        .Do0(DataOut),
        .A0(A0)
    );

endmodule



`default_nettype wire
