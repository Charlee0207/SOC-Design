// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Sat Nov 25 02:02:27 2023
// Host        : chngh running 64-bit Ubuntu 22.04.3 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_spiflash_0_0_stub.v
// Design      : design_1_spiflash_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "spiflash,Vivado 2023.1" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(ap_clk, ap_rst, romcode_Addr_A, romcode_EN_A, 
  romcode_WEN_A, romcode_Din_A, romcode_Dout_A, romcode_Clk_A, romcode_Rst_A, csb, spiclk, io0, 
  io1)
/* synthesis syn_black_box black_box_pad_pin="ap_clk,ap_rst,romcode_Addr_A[31:0],romcode_EN_A,romcode_WEN_A[3:0],romcode_Din_A[31:0],romcode_Dout_A[31:0],romcode_Clk_A,romcode_Rst_A,csb,io0[0:0],io1" */
/* synthesis syn_force_seq_prim="spiclk" */;
  input ap_clk;
  input ap_rst;
  output [31:0]romcode_Addr_A;
  output romcode_EN_A;
  output [3:0]romcode_WEN_A;
  output [31:0]romcode_Din_A;
  input [31:0]romcode_Dout_A;
  output romcode_Clk_A;
  output romcode_Rst_A;
  input csb;
  input spiclk /* synthesis syn_isclock = 1 */;
  input [0:0]io0;
  output io1;
endmodule