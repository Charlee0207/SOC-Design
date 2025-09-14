# SOC-Design

###### NTHU SoC Design Group 8, EECS24 109020014 李承澔
This is the study log about SOC design course.

## Lab1

[Spec](./Lab1/112-1%20SoC%20Design%20Laboratory%20(NTHU)%20Lab1.pdf)<br>
[Workbook](./Lab1/Workbook-Lab1.pdf)<br>
[Report](./Lab1/report.md)<br>
[Cource Repo](https://github.com/bol-edu/course-lab_1)<br>

In this lab, we delve into the FPGA High-Level Synthesis (HLS) flow.

Our objective is to design a multiplier with `2 inputs` and `1 output`, subsequently exporting it to RTL IP. This will then be deployed on the PYNQ-Z2 MPSoC PL side. The PYNQ Arm core will run a Python program that invokes the multiplier IP to compute the result.

We will then assess both its performance and utilization.

---

## Lab2

[Spec](./Lab2/112-1%20SoC%20Design%20Laboratory%20(NTHU)%20Lab2.pdf)<br>
[Workbook](./Lab2/2022.1-Workbook-Lab2.pdf)<br>
[Report](./Lab2/report.md)<br>
[Cource Repo](https://github.com/bol-edu/course-lab_2)<br>

In this lab, we try to utilize MAXI(AXI-M) and Stream(AXI-S) protocal to transfer data between PS and PL side.

The PYNQ Arm core will run a Python program that invokes the FIR IP to compute the result.

We will then assess both its performance and utilization.

---

## Lab3

[Spec](./Lab3/112-1%20SoC%20Design%20Laboratory%20(NTHU)%20Lab3.pdf)<br>
[Report](./Lab3/report.md)<br>
[Cource Repo](https://github.com/bol-edu/caravel-soc_fpga-lab/tree/main/lab-fir)<br>

In this lab, we try to implement a Finite Impulse Response (FIR) engine in Verilog. The FIR design is constrained to have 11 taps, and it must use only one adder and one multiplier.

And we want to decrease the FF utilization and critical path delay as possible.

---

## Lab4-1

[Spec](./Lab4-1/112-1-SoC-Design-Laboratory-Lab4-1.pdf)<br>
[Report](./Lab4-1/report.md)<br>
[Cource Repo](https://github.com/bol-edu/caravel-soc_fpga-lab/tree/main/lab-exmem_fir)<br>

This lab focuses on implementing an FIR firmware C code based on [caravel-SOC project](https://github.com/bol-edu/caravel-soc_fpga). We will compile and link the firmware to a specific address, which is corresponding to the user project address spcase.
Finally, we will run the `caravel-SOC` testbench to load the firmware assembly code and launch the RISC-V core to do the FIR computation.

---

## Lab4-2

[Spec](./Lab4-2/Lab4-2-caravel-fir.pdf)<br>
[Report](./Lab4-2/report.md)<br>
[Cource Repo](https://github.com/bol-edu/caravel-soc_fpga-lab/tree/main/lab-caravel_fir)<br>

In this lab, we try to combine lab3 and lab4-1. That is, we will place the FIR verilog HW accelerator into caravel-SOC user project space, and launched by firmware code.

We will then assess both its performance, and the system bottleneck

---

## Lab5

[Spec](./Lab5/lab5-caravel%20FPGA.pdf)<br>
[Report](./Lab5/report.md)<br>
[Cource Repo](https://github.com/bol-edu/caravel-soc_fpga-lab/tree/main/labi)<br>

In last lab, the HW accelerator and firmware have been integrated into caravel SOC and passed the testbench. 
In this lab, we will try to place `gcd`, `counter` HW design into caravel SOC, which utilize logic analyzer and wishbone to communicate with outerand pack them into Vivado project.
Later, we will upload the Vivado project bitstream into PYNQ board and launch HW design in PL side by jupyter notebook.

---

## Lab6

[Spec](./Lab6/Lab6-wlos-baseline_workbook.pdf)<br>
[Report](./Lab6/report.md)<br>
[Cource Repo](https://github.com/bol-edu/caravel-soc_fpga-lab/tree/main/lab-wlos_baseline)<br>


In this lab, we will try to implement UART function and try to optmize workload.

We may try to add some FIFO to reduce the UART latency and increase the throughput. And we will try to use interrupt to notice CPU, reduce the CPU time of polling UART result.

---
