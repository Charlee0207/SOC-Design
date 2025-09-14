# SOC-Design Lab2

###### NTHU EECS24 109020014 李承澔

This report discusses performance of FIR filter using MAXI and Stream interfaces. The kernel is executed on the PYNQ-Z2 board.

## Brief introduction
In this lab, we try to utilize MAXI(AXI-M) and Stream(AXI-S) protocal to transfer data between PS and PL side.

The PYNQ Arm core will run a Python program that invokes the FIR IP to compute the result.

We will then assess both its performance and utilization.


# Lab2-1 FIRN11_MAXI


## Screen Dump

### C-Simulation pass
![](https://hackmd.io/_uploads/BJl529cep.png)

### Synthesis Report
![](https://hackmd.io/_uploads/BkUJac9l6.png)


### cosimulation pass
![](https://hackmd.io/_uploads/r1hraqqga.png)


### Jupyter Notebook execution results
|![](https://hackmd.io/_uploads/SkFaT9qe6.png)|![](https://hackmd.io/_uploads/Hk2Apq9eT.png)|
|---|---|

# Lab2-2 FIRN11_stream


## Screen Dump

### C-Simulation pass
![](https://hackmd.io/_uploads/SJTeGscxa.png)


### Synthesis Report
![](https://hackmd.io/_uploads/B1bOXs9x6.png)



### cosimulation pass
![](https://hackmd.io/_uploads/HyH5Xocla.png)



### Jupyter Notebook execution results
|![](https://hackmd.io/_uploads/By6Sq0cg6.png)|![](https://hackmd.io/_uploads/SJTw90qep.png)|
|---|---|


# Observation

* `AXI-M` employs memory-mapped IO to interface with general memory addresses, incorporating memory components such as BRAM and FF. On the other hand, `AXI-S` provides a means to transition from a memory map to a stream, and in doing so, it doesn't utilize BRAM and consumes fewer resources.

* `AXI-M` facilitates both read and write operations. In the `AXI-S` block, two DMA IPs are integrated to serve these operations, respectively.

* In this lab, IO access appears to be more segregated. In this lab, `AXI-S` doesn't get an opportunity to transmit data in a continuous flow. Consequently, in this particular scenario, the `AXI-M` implementation proves faster as per the execution results displayed in the two Jupyter Notebook screenshots.



