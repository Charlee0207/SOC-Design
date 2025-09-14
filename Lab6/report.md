# SOC-Design Lab6: WorkLoad Optimize

###### [github link](https://github.com/Charlee0207/SOC-Design/tree/main/Lab6)

###### [report link](https://hackmd.io/1dL70Ic2SNuRGwOoNR3ecQ)

###### NTHU SoC Design Group 8, EECS24 109020014 李承澔

## Brief introduction
In this lab, we will try to implement UART function and try to optmize workload.

We may try to add some FIFO to reduce the UART latency and increase the throughput. And we will try to use interrupt to notice CPU, reduce the CPU time of polling UART result.

## How to use
### Simulation WLOS firmware
```sh
cd ./lab-wlos_baseline/testbench/lab6_uart
source run_clean
source run_sim
```

### Generate HEX for PYNQ
Note the [discussion](https://github.com/bol-edu/HLS-SOC-Discussions/discussions/175), we add some for loops to observe the results in Jupyter Notebook
```sh
cd ./lab-wlos_baseline/testbench/lab6
source run_clean
source run_sim_j
```

### Synthesis and Implentmentation

```sh
cd ./lab-wlos_baseline/vivado
source run_vivado
```


## Block Diagram
![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/fdb837d1-6438-4667-b664-d7fc8272281e)


## Utilization
|![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/ddd413f6-7245-462c-8790-01403f604116)|
|---|
|![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/c85041d1-23dc-4b4a-8f02-6eb59c20b3a4)|
|![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/420a1580-8640-42af-b103-b18fd715f85b)|

## Timing
![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/2b7e42a3-5ab8-4480-83a6-a86e647bc3f1)

## Simulation
|![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/07e3b7cb-7391-481c-8313-127a001e7b84)|
|---|
|![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/2607b5b3-5bb4-47c5-a34e-3df0b353b59b)|

## Block Usage
### read_romcode
This block is to copy the data in PS side into BRAM or write the data from BRAM to PS side
In each transaction, we have different bus to send the different base address.

For example, PS side set the port _BUS_0 just to send data to PL side, another transaction is vice versa.

### spiflash
spi slave only support read command and its mmio address is `0x03` owing to return the data from BRAM to Caravel
SPI protocal consist of `MOSI` `MISO` `SCK` `SS` and the transaction is serial transmiting from lsb to msb and the slave side also.

### UART
* UART Control
  This block consists of Rx Control - This block samples received data with respect to generated baud rate and writes it to Receive Data FIFO.

* Tx Control
  This block reads data from Transmit Data FIFO and sends it out on the UART Tx interface.

* Interrupt Control
  The AXI UART Lite core provides interrupt enable/disable control.
  If interrupts are enabled, a rising-edge sensitive interrupt is generated when the receive FIFO becomes non-empty or when the transmit FIFO becomes empty

### How UART Work
This time we use ISR routine inside the firmware code to generate interrupt signal to CPU just for receive data for uart.

We use `uart.h` to define the register to configure uart reg
* caravel_uart_tx is connected to axi_lite_uart_rx
* caravel_uart_rx is coneected to axi_lire_uart_tx
* PS site write data to uart_lite and caravel will use the data by using uart port
  
If caravel_soc wanna send data to PS side, it will trigger a interupt to axi interrupt controller, and controller will tell the irq inside PS side that there is a data inside axi_lite and then PS side read the data putting it into buffer.

### Result Screenshot
Note that we add some for loops at firmware code of `main_for_jupy.c` (use run_sim_j to generate the hex file) 
to make sure that each checkbits can be read at the notebook demo

![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/30ada6e5-e2bc-4769-ab62-85768906ce68)
![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/0c2c4af0-0b83-4456-acfc-c727d8a227bc)

To evaluate a character loop back time, we then adjust the uart_rxtx function to report the timing
![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/a854f4fe-6b86-46e8-80f3-e329c1b270e8)
![image](https://github.com/Charlee0207/SOC-Design/assets/85032763/c8073d6b-a1f1-41bc-9fc5-8f63693b5660)

## Review
In this lab, we have learned how to use caravel soc in real FPGA to deploy a platform and its detail. In lab, writing a robust firmware code is essential because the firmware code can drastically affect the performance. 

It is also a good practice to have experience like how to use wishbone but in IP mode as protocol to transfer data to user project and use mprj pin to deliver result which is from fir back to RISC CPU. 
UART is a big challenge in this lab because we have to make sure we put the correct code into right place in the waveform we can observe that uart is accept data at first and send it to Tx port later on. 

In order to decrease the latency for uart.
We may try to add an additional buffer to it and then use interrupt as a way to not to disturb CPU.



