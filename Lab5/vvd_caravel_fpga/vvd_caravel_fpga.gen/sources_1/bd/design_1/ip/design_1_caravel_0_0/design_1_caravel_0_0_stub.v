// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Sat Nov 25 02:02:27 2023
// Host        : chngh running 64-bit Ubuntu 22.04.3 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/chngh/Desktop/SOC_design/Lab5/vvd_caravel_fpga/vvd_caravel_fpga.gen/sources_1/bd/design_1/ip/design_1_caravel_0_0/design_1_caravel_0_0_stub.v
// Design      : design_1_caravel_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "caravel,Vivado 2023.1" *)
module design_1_caravel_0_0(gpio, mprj_i, mprj_o, mprj_en, clock, resetb, 
  flash_csb, flash_clk, flash_io0, flash_io1)
/* synthesis syn_black_box black_box_pad_pin="gpio,mprj_i[37:0],mprj_o[37:0],mprj_en[37:0],resetb,flash_csb,flash_clk,flash_io0,flash_io1" */
/* synthesis syn_force_seq_prim="clock" */;
  inout gpio;
  input [37:0]mprj_i;
  output [37:0]mprj_o;
  output [37:0]mprj_en;
  input clock /* synthesis syn_isclock = 1 */;
  input resetb;
  output flash_csb;
  output flash_clk;
  output flash_io0;
  input flash_io1;
endmodule
