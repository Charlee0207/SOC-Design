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

//`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_project_wrapper
 *
 * This wrapper enumerates all of the pins available to the
 * user for the user project.
 *
 * An example user project is provided in this wrapper.  The
 * example should be removed and replaced with the actual
 * user project.
 *
 *-------------------------------------------------------------
 */
`define MPRJ_IO_PADS_1 19	/* number of user GPIO pads on user1 side */
`define MPRJ_IO_PADS_2 19	/* number of user GPIO pads on user2 side */
`define MPRJ_IO_PADS (`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2)

module user_project_wrapper #(
    parameter BITS = 32
) (
`ifdef USE_POWER_PINS
    inout vdda1,	// User area 1 3.3V supply
    inout vdda2,	// User area 2 3.3V supply
    inout vssa1,	// User area 1 analog ground
    inout vssa2,	// User area 2 analog ground
    inout vccd1,	// User area 1 1.8V supply
    inout vccd2,	// User area 2 1.8v supply
    inout vssd1,	// User area 1 digital ground
    inout vssd2,	// User area 2 digital ground
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
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
    inout [`MPRJ_IO_PADS-10:0] analog_io,

    // Independent clock (on independent integer divider)
    input   user_clock2,

    // User maskable interrupt signals
    output [2:0] user_irq
);

/*--------------------------------------*/
/* User project is instantiated  here   */
/*--------------------------------------*/

wire wbs_stb_i_exmemFIR, wbs_stb_i_WBAXI;
wire wbs_cyc_i_exmemFIR, wbs_cyc_i_WBAXI;
wire wbs_we_i_exmemFIR, wbs_we_i_WBAXI;
wire [3:0] wbs_sel_i_exmemFIR, wbs_sel_i_WBAXI;
wire [31:0] wbs_dat_i_exmemFIR, wbs_dat_i_WBAXI;
wire [31:0] wbs_adr_i_exmemFIR, wbs_adr_i_WBAXI;
wire wbs_ack_o_exmemFIR, wbs_ack_o_WBAXI;
wire [31:0] wbs_dat_o_exmemFIR, wbs_dat_o_WBAXI;

wire exmemFIR_sel, WBAXI_sel;

assign exmemFIR_sel    = (wbs_adr_i[31:24]==8'h38);
assign WBAXI_sel       = (wbs_adr_i[31:24]==8'h30);


assign wbs_stb_i_exmemFIR = wbs_stb_i && exmemFIR_sel;
assign wbs_cyc_i_exmemFIR = wbs_cyc_i && exmemFIR_sel;
assign wbs_we_i_exmemFIR = wbs_we_i && exmemFIR_sel;
assign wbs_sel_i_exmemFIR = wbs_sel_i & {4{exmemFIR_sel}};
assign wbs_dat_i_exmemFIR = wbs_dat_i & {32{exmemFIR_sel}};

assign wbs_adr_i_exmemFIR = wbs_adr_i & {32{exmemFIR_sel}};
assign wbs_adr_i_WBAXI = wbs_adr_i & {32{WBAXI_sel}};

assign wbs_stb_i_WBAXI = wbs_stb_i && WBAXI_sel;
assign wbs_cyc_i_WBAXI = wbs_cyc_i && WBAXI_sel;
assign wbs_we_i_WBAXI = wbs_we_i && WBAXI_sel;
assign wbs_sel_i_WBAXI = wbs_sel_i && WBAXI_sel;
assign wbs_dat_i_WBAXI = wbs_dat_i & {32{WBAXI_sel}};


assign wbs_ack_o =  (exmemFIR_sel)  ? wbs_ack_o_exmemFIR
                    :(WBAXI_sel)    ? wbs_ack_o_WBAXI
                    :                 1'b0;
assign wbs_dat_o =  (exmemFIR_sel)  ? wbs_dat_o_exmemFIR
                    :(WBAXI_sel)    ? wbs_dat_o_WBAXI
                    :                 32'h0;

user_proj_example mprj (
`ifdef USE_POWER_PINS
	.vccd1(vccd1),	// User area 1 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
`endif

    .wb_clk_i(wb_clk_i),
    .wb_rst_i(wb_rst_i),

    // MGMT SoC Wishbone Slave

    .wbs_cyc_i(wbs_cyc_i_exmemFIR),
    .wbs_stb_i(wbs_stb_i_exmemFIR),
    .wbs_we_i(wbs_we_i_exmemFIR),
    .wbs_sel_i(wbs_sel_i_exmemFIR),
    .wbs_adr_i(wbs_adr_i_exmemFIR),
    .wbs_dat_i(wbs_dat_i_exmemFIR),
    .wbs_ack_o(wbs_ack_o_exmemFIR),
    .wbs_dat_o(wbs_dat_o_exmemFIR),

    // Logic Analyzer

    .la_data_in(la_data_in),
    .la_data_out(la_data_out),
    .la_oenb (la_oenb),

    // IO Pads

    .io_in (io_in),
    .io_out(io_out),
    .io_oeb(io_oeb),

    // IRQ
    .irq(user_irq)
);

wb2axi fir (
`ifdef USE_POWER_PINS
	.vccd1(vccd1),	// User area 1 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
`endif

    .wb_clk_i(wb_clk_i),
    .wb_rst_i(wb_rst_i),

    // MGMT SoC Wishbone Slave

    .wb_cyc_i(wbs_cyc_i_WBAXI),
    .wb_stb_i(wbs_stb_i_WBAXI),
    .wb_we_i(wbs_we_i_WBAXI),
    // .wbs_sel_i(wbs_sel_i_WBAXI),
    .wb_adr_i(wbs_adr_i_WBAXI[11:0]),
    .wb_dat_i(wbs_dat_i_WBAXI),
    .wb_ack_o(wbs_ack_o_WBAXI),
    .wb_dat_o(wbs_dat_o_WBAXI)
);

endmodule	// user_project_wrapper

`default_nettype wire
