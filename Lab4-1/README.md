# SOC-Design Lab4-1 FIR


###### NTHU SoC Design Group 8

## How to use

```
cd ./testbench/counter_la_fir
./run_sim
```

## Firmware code
1. `fir.h`
   
Define the taps numbers and input data

![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/3b45357e-9fd1-4278-960b-b374d0830e41)

2.  `fir.c`
   i.   `void initfir()`

This is to reset the input and output buffers before doing fir conputing.
![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/885e1b29-b3ab-4eba-82a9-b45ce0f1aea3)

   ii.  `Int* fir()`

 Using a for loop to compute the fir and save the result to “outputsignal”.
 Return the pointer of the “outputsignal”.
    
 ![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/36a5dc5f-496e-4552-b51e-22d951b6aad5)

## Interface between BRAM and wishbone

1. To make sure the mprjram is selected ,where `wbs_adr_i[31:20]` is from `12’h380 (12’b0011_1000_0000)` to `12’h384 (12’b0011_1000_0100)` ,
we assign a signal Sel as wbs_adr_i[31:23] is 9’h070 (9’b001110000) to determine whether the wishbone address is in the range.

2. clock (`clk`) of the BRAM and reset (`rst`) are assigned to the ones from wishbone (`wb_clk_i` and `wb_rst_i`)
3. enble (`EN0`) of the BRAM is assigned to `wbs_cyc_i && wbs_stb_i && Sel`
4. write enable (`WE0`) is assigned to `wbs_sel_i & {4{wbs_we_i}}`
5. DataIn(`write data`) is assigned to `wbs_dat_i`
6. Address(`A0`) is assigned to `Sel ? (wbs_adr_i & 32'h003FFFFF) : 32’b0`, using a mask to make the bram size smaller.
7. We used a simple 4 bits counter and a “ready” signal to control the desired delay time from enable to `wbs_ack_o`.
   
![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/5e78b378-96eb-41ff-a9b5-7c4340c08335)
  
9. DataOut(read data) is connected to `wbs_data_o` for output.
10. BRAM size parameter N = 9.

![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/a8a03db4-6501-4128-8686-6f21b261b604)

## Waveforms

1. The communications between CPU and BRAM is shown below:

![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/74db26c1-3537-4d26-930e-e4c62ba305fb)

2. FIR results can be checked from the checkbits of the testbench.

![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/1e2dd66f-a7b5-41ce-92fe-15638526b0a9)

## Synthesis report
### RTL Component
![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/ab4232fe-1b35-4dc6-a483-65d48591f7df)

### Slice Logic
![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/ed958345-c6c4-4316-8168-ca7af4788d34)


### Memory
![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/858b62f9-ce3a-4a17-9d10-0e35ec23133d)







