// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.1 (lin64) Build 3865809 Sun May  7 15:04:56 MDT 2023
// Date        : Sat Nov 25 02:02:35 2023
// Host        : chngh running 64-bit Ubuntu 22.04.3 LTS
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_blk_mem_gen_0_0_sim_netlist.v
// Design      : design_1_blk_mem_gen_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_1_blk_mem_gen_0_0,blk_mem_gen_v8_4_6,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "blk_mem_gen_v8_4_6,Vivado 2023.1" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (clka,
    rsta,
    ena,
    wea,
    addra,
    dina,
    douta,
    clkb,
    rstb,
    enb,
    web,
    addrb,
    dinb,
    doutb,
    rsta_busy,
    rstb_busy);
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTA, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE BRAM_CTRL, READ_WRITE_MODE READ_WRITE, READ_LATENCY 1" *) input clka;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA RST" *) input rsta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA EN" *) input ena;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA WE" *) input [3:0]wea;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA ADDR" *) input [31:0]addra;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DIN" *) input [31:0]dina;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTA DOUT" *) output [31:0]douta;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME BRAM_PORTB, MEM_SIZE 8192, MEM_WIDTH 32, MEM_ECC NONE, MASTER_TYPE BRAM_CTRL, READ_WRITE_MODE READ_WRITE, READ_LATENCY 1" *) input clkb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB RST" *) input rstb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB EN" *) input enb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB WE" *) input [3:0]web;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB ADDR" *) input [31:0]addrb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DIN" *) input [31:0]dinb;
  (* x_interface_info = "xilinx.com:interface:bram:1.0 BRAM_PORTB DOUT" *) output [31:0]doutb;
  output rsta_busy;
  output rstb_busy;

  wire [31:0]addra;
  wire [31:0]addrb;
  wire clka;
  wire clkb;
  wire [31:0]dina;
  wire [31:0]dinb;
  wire [31:0]douta;
  wire [31:0]doutb;
  wire ena;
  wire enb;
  wire rsta;
  wire rsta_busy;
  wire rstb;
  wire rstb_busy;
  wire [3:0]wea;
  wire [3:0]web;
  wire NLW_U0_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_arready_UNCONNECTED;
  wire NLW_U0_s_axi_awready_UNCONNECTED;
  wire NLW_U0_s_axi_bvalid_UNCONNECTED;
  wire NLW_U0_s_axi_dbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_rlast_UNCONNECTED;
  wire NLW_U0_s_axi_rvalid_UNCONNECTED;
  wire NLW_U0_s_axi_sbiterr_UNCONNECTED;
  wire NLW_U0_s_axi_wready_UNCONNECTED;
  wire NLW_U0_sbiterr_UNCONNECTED;
  wire [31:0]NLW_U0_rdaddrecc_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_bid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_bresp_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdaddrecc_UNCONNECTED;
  wire [31:0]NLW_U0_s_axi_rdata_UNCONNECTED;
  wire [3:0]NLW_U0_s_axi_rid_UNCONNECTED;
  wire [1:0]NLW_U0_s_axi_rresp_UNCONNECTED;

  (* C_ADDRA_WIDTH = "32" *) 
  (* C_ADDRB_WIDTH = "32" *) 
  (* C_ALGORITHM = "1" *) 
  (* C_AXI_ID_WIDTH = "4" *) 
  (* C_AXI_SLAVE_TYPE = "0" *) 
  (* C_AXI_TYPE = "1" *) 
  (* C_BYTE_SIZE = "8" *) 
  (* C_COMMON_CLK = "0" *) 
  (* C_COUNT_18K_BRAM = "0" *) 
  (* C_COUNT_36K_BRAM = "2" *) 
  (* C_CTRL_ECC_ALGO = "NONE" *) 
  (* C_DEFAULT_DATA = "0" *) 
  (* C_DISABLE_WARN_BHV_COLL = "0" *) 
  (* C_DISABLE_WARN_BHV_RANGE = "0" *) 
  (* C_ELABORATION_DIR = "./" *) 
  (* C_ENABLE_32BIT_ADDRESS = "1" *) 
  (* C_EN_DEEPSLEEP_PIN = "0" *) 
  (* C_EN_ECC_PIPE = "0" *) 
  (* C_EN_RDADDRA_CHG = "0" *) 
  (* C_EN_RDADDRB_CHG = "0" *) 
  (* C_EN_SAFETY_CKT = "1" *) 
  (* C_EN_SHUTDOWN_PIN = "0" *) 
  (* C_EN_SLEEP_PIN = "0" *) 
  (* C_EST_POWER_SUMMARY = "Estimated Power for IP     :     10.7492 mW" *) 
  (* C_FAMILY = "zynq" *) 
  (* C_HAS_AXI_ID = "0" *) 
  (* C_HAS_ENA = "1" *) 
  (* C_HAS_ENB = "1" *) 
  (* C_HAS_INJECTERR = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MEM_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_A = "0" *) 
  (* C_HAS_MUX_OUTPUT_REGS_B = "0" *) 
  (* C_HAS_REGCEA = "0" *) 
  (* C_HAS_REGCEB = "0" *) 
  (* C_HAS_RSTA = "1" *) 
  (* C_HAS_RSTB = "1" *) 
  (* C_HAS_SOFTECC_INPUT_REGS_A = "0" *) 
  (* C_HAS_SOFTECC_OUTPUT_REGS_B = "0" *) 
  (* C_INITA_VAL = "0" *) 
  (* C_INITB_VAL = "0" *) 
  (* C_INIT_FILE = "NONE" *) 
  (* C_INIT_FILE_NAME = "no_coe_file_loaded" *) 
  (* C_INTERFACE_TYPE = "0" *) 
  (* C_LOAD_INIT_FILE = "0" *) 
  (* C_MEM_TYPE = "2" *) 
  (* C_MUX_PIPELINE_STAGES = "0" *) 
  (* C_PRIM_TYPE = "1" *) 
  (* C_READ_DEPTH_A = "2048" *) 
  (* C_READ_DEPTH_B = "2048" *) 
  (* C_READ_LATENCY_A = "1" *) 
  (* C_READ_LATENCY_B = "1" *) 
  (* C_READ_WIDTH_A = "32" *) 
  (* C_READ_WIDTH_B = "32" *) 
  (* C_RSTRAM_A = "0" *) 
  (* C_RSTRAM_B = "0" *) 
  (* C_RST_PRIORITY_A = "CE" *) 
  (* C_RST_PRIORITY_B = "CE" *) 
  (* C_SIM_COLLISION_CHECK = "ALL" *) 
  (* C_USE_BRAM_BLOCK = "1" *) 
  (* C_USE_BYTE_WEA = "1" *) 
  (* C_USE_BYTE_WEB = "1" *) 
  (* C_USE_DEFAULT_DATA = "0" *) 
  (* C_USE_ECC = "0" *) 
  (* C_USE_SOFTECC = "0" *) 
  (* C_USE_URAM = "0" *) 
  (* C_WEA_WIDTH = "4" *) 
  (* C_WEB_WIDTH = "4" *) 
  (* C_WRITE_DEPTH_A = "2048" *) 
  (* C_WRITE_DEPTH_B = "2048" *) 
  (* C_WRITE_MODE_A = "WRITE_FIRST" *) 
  (* C_WRITE_MODE_B = "WRITE_FIRST" *) 
  (* C_WRITE_WIDTH_A = "32" *) 
  (* C_WRITE_WIDTH_B = "32" *) 
  (* C_XDEVICEFAMILY = "zynq" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_blk_mem_gen_v8_4_6 U0
       (.addra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,addra[12:2],1'b0,1'b0}),
        .addrb({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,addrb[12:2],1'b0,1'b0}),
        .clka(clka),
        .clkb(clkb),
        .dbiterr(NLW_U0_dbiterr_UNCONNECTED),
        .deepsleep(1'b0),
        .dina(dina),
        .dinb(dinb),
        .douta(douta),
        .doutb(doutb),
        .eccpipece(1'b0),
        .ena(ena),
        .enb(enb),
        .injectdbiterr(1'b0),
        .injectsbiterr(1'b0),
        .rdaddrecc(NLW_U0_rdaddrecc_UNCONNECTED[31:0]),
        .regcea(1'b0),
        .regceb(1'b0),
        .rsta(rsta),
        .rsta_busy(rsta_busy),
        .rstb(rstb),
        .rstb_busy(rstb_busy),
        .s_aclk(1'b0),
        .s_aresetn(1'b0),
        .s_axi_araddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arburst({1'b0,1'b0}),
        .s_axi_arid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_arready(NLW_U0_s_axi_arready_UNCONNECTED),
        .s_axi_arsize({1'b0,1'b0,1'b0}),
        .s_axi_arvalid(1'b0),
        .s_axi_awaddr({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awburst({1'b0,1'b0}),
        .s_axi_awid({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awlen({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_awready(NLW_U0_s_axi_awready_UNCONNECTED),
        .s_axi_awsize({1'b0,1'b0,1'b0}),
        .s_axi_awvalid(1'b0),
        .s_axi_bid(NLW_U0_s_axi_bid_UNCONNECTED[3:0]),
        .s_axi_bready(1'b0),
        .s_axi_bresp(NLW_U0_s_axi_bresp_UNCONNECTED[1:0]),
        .s_axi_bvalid(NLW_U0_s_axi_bvalid_UNCONNECTED),
        .s_axi_dbiterr(NLW_U0_s_axi_dbiterr_UNCONNECTED),
        .s_axi_injectdbiterr(1'b0),
        .s_axi_injectsbiterr(1'b0),
        .s_axi_rdaddrecc(NLW_U0_s_axi_rdaddrecc_UNCONNECTED[31:0]),
        .s_axi_rdata(NLW_U0_s_axi_rdata_UNCONNECTED[31:0]),
        .s_axi_rid(NLW_U0_s_axi_rid_UNCONNECTED[3:0]),
        .s_axi_rlast(NLW_U0_s_axi_rlast_UNCONNECTED),
        .s_axi_rready(1'b0),
        .s_axi_rresp(NLW_U0_s_axi_rresp_UNCONNECTED[1:0]),
        .s_axi_rvalid(NLW_U0_s_axi_rvalid_UNCONNECTED),
        .s_axi_sbiterr(NLW_U0_s_axi_sbiterr_UNCONNECTED),
        .s_axi_wdata({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wlast(1'b0),
        .s_axi_wready(NLW_U0_s_axi_wready_UNCONNECTED),
        .s_axi_wstrb({1'b0,1'b0,1'b0,1'b0}),
        .s_axi_wvalid(1'b0),
        .sbiterr(NLW_U0_sbiterr_UNCONNECTED),
        .shutdown(1'b0),
        .sleep(1'b0),
        .wea(wea),
        .web(web));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2023.1"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
aMT3usC6uizzcwnzOCX4OsS16Ob+YxFcsGovFpFklbnaIaD1S0lVdxenTwHPp6ByIEi+ehwr6Rgg
z/3AlTheI5NFTM8ihiMA18/wmUxI7EbaftJACA1LykUKCuj5myy0T+DACuv3sGYIZS38TZTZnnBC
FGAlvTZmRWs+JzneH3o=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
lR9ZerhYSAb39nzEkeYvhnwEs5t9y/+yTDf8KuoUtR1BGeHZq8pA/YxtjzQLtaOW1R1IQUb0FtSI
e3CYAb7WHYbIjcpw3vKHvW1SqcGn9CMGa556CYKmD2oF12Kow8xRaFvMSBUVxX7HsHxNWnRd+PU1
+C0YayU2KFIY/7Yl6cZ5luAzhw/6SW3PFYUIyyqWy5MCIXweHOwQR2IpQEdlDur5nluN7i7BeB+i
fxwwHh8TU/g7T4mhZFkiTuBKdLAtQOjxWxzqTMxgcuAjlTylY16FgMFOASdvvSbqBZJjbxMdVloU
rYjS8O/8rWktv8GXcaIdBJ2BRj01q7jsChsbwA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
Qvl63GHz9mq2xOB7elt/vAQ7URLGdD1Lkcz7f3Wtw31dwjjjbP62Ny/Jr6OmBIheWlgejx38qxAT
TrHiiEyjKmGcnPn1Tn2n+cH4RAxCbOFnCI9n6+YsYMTe9JkplGhGGr39SkFgJz0I2IKpPsuqTjCj
rhf49TAryNMQeRpREJA=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
MA+9Ro+dh339m0iZrkKbqTKN8gQ5xkxN/SPCfhkOn+5jjgCTS5IOKLHil+HsZDjX333ebxnornwG
MOBxyEdFfLM8SA+bs2r41J/j0af2VVMmCM3hOh8JmZxB4X9Jg/glegNCbvwzqxMbOQNEy+zt7j5t
TFVD82RtPFmYVVYZZyll/WvAA+0aVpyjzLCIM1GznFky0RWLv65Wp4MJJnNRRrtG3muMznVO/u2s
tACsJ9jzv9M0IlMYjYH9BixhG6cZX02I4LEXXaPkhdOINlMMhsbArXtc9NphzmS4bY1/1yF1D6YD
EKLyS2Sr3HDl0O/lefN+jvfG8iKuVl55PNNrVQ==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
wpMTg7STjFkUDhOqdNPa0FHXTnHQgKmhvqDv+rRVBvMiQ8O7u8oj7ibITq3o+jugJsMJ60B410gQ
JFTcqCJKYmYJvqi8rPLLOYDmFG6ZLP/Ixr3n62IyIaCeDltBahi3yV009QN0X+iuzuFCL+Y7g9ff
IvAgyBly+Z3Itv2H9EJMZPMl17Sa7IkgjmWqzVXIKNMKn0iDVYsQw6ZgzQDYQ8N8IvTIEggU3/lh
6Nf0hV0ev3qOv/2P+4w0U766Ux3yLuzPJSI7bKm3/ip9NjhOytxOiKKqVXhKG8dzbbuS5u3EE/eq
q6YxkL7gpvNltVqqBnJB6vHSyWrD6+MqsCtR9A==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2022_10", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Q7Q4SSp70lxFryaopuic9VVP/Ire0pSsPEIMYdURBAczC7ShkuYeV02U7L3BlAiyBE4vBKcwYSQd
cWiaj8sVP7q4kxoRHKxLV1R5PIO6l4DsLWE2E+1MLyUPME0w5KTular/oX8EPCJ5n/8VCtW7x4Vf
dpeyki1/IAPJkAyi3zVZKHzgKhEwnZaZZtZYuMWoPZMt4V38sAcE42Raf+7yfFWG5HO74JY6iEnW
gJeRk58K+avB/XLF2/j2RQZfjTYizrprT2tUMBK6e7DRWZZtk8AOcsMhUikev44IFGNbNXjP8BXC
0J3y3P7pCFT6l+saU83nRwi/H25fSA34diJtNw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
a/8ooC+s+6nfvfa1+oBhsvYWLJjFgp83DI1kNyOi5Am+ugPbGRmgGZudfyo6yw6Yd5gGbLm5aToQ
5G4cGF5HaXD5TU6A0ZZFMTIbzFLE76JMjjIxX8JcaJIZpSmrXqlru8l5gDINUEAmwUY3mRQnjcGJ
0Z+kMRH8iAEF+gEviPiFZSBbJeOPqivIS217kimQJX3BeNbNPQTP+GUidcRywpGMh5avxtA0kDRO
F9SoCSyTm9hr2v9hsK1IUAYQLb7n2/R+z5YNKNzt1oN4qgJH1wZfdI8if2K8+ohyOdnxrrgJOWdj
cOqr7cGqEOYfBMTIQeHVZzb7NGWVN+9B8XSUaQ==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
FLPvOUNRWNW2GU+FEGmt2XWthOT5bY/31DRbol2cUmEGNF6b2XzpCosNKGx/o2n6sQvGP39KRFCs
nJu0ihe2dUGee9nEZZUcpwPjnEfXVI3yJaRVYy8iL+rm59lXq0jX4sjAPieDvv8shgAnoXLTZGlq
K+2c1JhaHt+nFi27TDrYar/+P8nP1MhocOS7BjzCvSs0foEXj92/qD+71Sm/LqGr8cjlH2qTJJ8B
ynxoH6iT+bksVA2VbtPT9o6h1kJ/zwP4wcsL9l+qSlJhd4GI11JPux26DlNyIi41WmufQcfiT0PB
r6O9+0E9lV9ODwKdjaxfZRK29rjKeq2yr0jWhMV38XKKqHAJli7MIypGRXcCo+u89H87KgYt+ebw
s3foIqCe0JKR57WzI8VD6XdNtOL8eBxK539oemx4vkE0cGYECZKYru6A2hPeZOYDD5eyWSUlQl1R
EciK49WM8HnssyRVcmE6di6bISMbVi0TZG/v98bz+9UZa8DtqMVYH0tz

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
fphquQOeFuqByo36Gh2C1zEC1J6u9swSMbMzsKldIvLm+SZ6/hr/N8KJ/G2vBABzX6UtbVuP1ZXx
AxdftP4Aqis1B3Bs6989aQG9eo0SOHA7r6aFLtFb3qoD5Pvqw4aVNU4z4EtTpFpn/jCWD21lKROf
q5X32HRfFq1jwqod+9vIbUNRRzz5y9VHvXfacZlxDazSPmcCF4hxB1KqWqT44KmYVkDedgkgnYgb
ZGidHnTb3W7C8tSqC9ac4kNJCL429QndtddweESJNlpX+65pt9Irok9pkOodwoj0QScswOIFjhBZ
/GrzZLQcFWiD3gXRU4DazzxQnGdRH4qEIRWziw==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
1lUYYHPCt1BUJOvcBbgMU2GSQiqfxItz4ntieMaenjrtsE9SLwaU6xB0tBl8Atw5yP/RRNww1kX/
9uZbTz5He3r9mPVt+mGxB4N3f9BbCrQRb4USVPgKO/+vWUfMQERGklScy0+fz75WuxH74CjRUoDI
8iyssb2cUNnfDe13jIoI8gM1w4w/Pkxkmb6Mef53QMxacHAWEZeytcH3fuL/adO263D8P90U3XJv
vBXJmbjkRVi9qzjBzfMxuOy2KbZaZgR3BLzaffIfFnMwg/Rb8sGls5pQsZv5jL2wk3+Bj3OXBYdd
pDyjGoalJBzObKzd/t15kNHwY4FXYFcZLQPncw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
YRmSEzaa2WFVvMH1BwWc1TIUpVbzSEIP0VbI6n0sEgct/X4PiTfMQmK1jBVCaISIzwBxscKQwZOt
mb/nmINGg6I7ih39LSbBMtx6cdCUiyaLkPeRbqfyPpKhvnUIFmdKVvTd1dYzxeOeuDnhSVaBaAcN
3lngSg7lIbmhLIGjC29yQrBTiLArbVZi6IRGronMK51e3UrYa6GspsznhiuRcXjEb4bHKrJ2CM5Z
BUwA+E9949sQgyOagFZbLVle2ESbwBaoxcAPn2gxfRHlT0leqyLgUGDZLsfArzGzw9BTGzyEG2TR
XOrKFNYRfMXMrnGsBM7acIelY4LdAMgsKgDH/A==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 59856)
`pragma protect data_block
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
q/ld0UeS
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
