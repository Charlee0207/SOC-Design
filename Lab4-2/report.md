# SOC-Design Lab4-2: FIR HW Design and Firmware

###### [github link](https://github.com/Charlee0207/SOC-Design/tree/main/Lab4-2)

###### [report link](https://hackmd.io/hVM9OsonQmqcCYmGOUGGtg)

###### NTHU SoC Design Group 8, EECS24 109020014 李承澔

## Brief introduction
In this lab, we try to combine lab3 and lab4-1. That is, we will place the FIR verilog HW accelerator into caravel-SOC user project space, and launched by firmware code.

We will then assess both its performance, and the system bottleneck

## How to use
```
cd ~/testbench/counter_la_fir
source run_clean
source run_sim
```

## Block Diagram
![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/a327a270-e11e-4dba-90f3-2b15e9bc7ec8)


## Handshaking between firmware and design
1. Outputs start with Mark (A5) on mprj[23:16] to notify Testbench to
2. start latencytimer 
3. RISC-V sends X[n] to FIR
4. RISC-V receives Y[n] from FIR
5. When transfer finish, write final Y and EndMark to record the latency
6. Testbench will finally check correctness by checking mprj[31:24], and print out the latency

## Interface Protocol
The interface between firmware and user project is through wishbone. 

The Wishbone protocol also defines a number of controlsignals, which are used to coordinate the data transfer between the
bus master and the bus slave. 
Signals include: `Address`, `Write`, `Data`, `Clock`.

And the functionality of testbench is combined them together to a simulation unit so that we can utilize caravel platform to transfer data and control signals.

## FIR Theoretical Throughputdata and Actually Throughput
#### Data rate :
In the design the output is `3467us` - `3441us` = `26us` per output ,
which means that in every output of fir design 26us generate an output.

#### Throughput:
The definition of throughput is total workload in every time unit.

Therefore, from perspective of output `692us`-`324us`=`368us` having 3 outputs. 
`3/368us` is equal to `0.00833*10^9` = `8.33*10^6` which is the throughput.

## Improve the Performance
In this project, especially in firmware, have significant effect on caravel soc.

Instead of define function outside the main function writing the function 
ex. input output into fir function can greatly reduce the latency.

## Simulation Log
![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/e893aeca-de69-4a25-9375-6a8388db6008)


## Utilization


| ![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/70234fa8-1c55-46ed-a472-09d4a81e20d9)| 
| -------- | 
| ![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/1374589c-e1e0-4db0-be2e-23f6a592f08c) | 
| ![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/0661399a-122c-4c96-a539-fa48c583e68d) |


## Timing
![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/f81253c3-3de7-42e5-8ec7-ae6748221532)


## Waveform
In this design we have 3 sets of data transfer to the fir design and
every set have 64 data added into design

3 set of data
![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/7d520e2d-1b2d-4d0a-82af-4a3b8d993418)


zoom out of the picture above
![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/6e09de98-dbd7-4ef0-8cec-47da96a97ea2)


`tap_ram` and `data_ram` waveform, the data
is accurately write into the ram that we defined
![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/ddf22db2-7121-43a2-b447-455b268564fc)


Wishbone to AXI
![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/c835e35a-0e66-4f23-9a21-23ea084b48f9)



## Review
In this lab, we have learned how to use caravel soc to deploy a platform and its detail.

In lab, writing a robust firmware code is essential because the firmware code can drastically affect the performance. It is also a good practice to have experience like how to use wishbone as protocol to transfer data to user project and use mprj pin to deliver result which is from fir back to RISC CPU.

Although this time we have not yet used logic analyzer that connect to CPU to transfer. I will try to use it next time as a challenge.

