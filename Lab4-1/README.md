# SOC-Design Lab4-1

[Spec](./112-1-SoC-Design-Laboratory-Lab4-1.pdf)<br>
[Report](./report.md)<br>
[Cource Repo](https://github.com/bol-edu/caravel-soc_fpga-lab/tree/main/lab-exmem_fir)<br>

This lab focuses on implementing an FIR firmware C code based on [caravel-SOC project](https://github.com/bol-edu/caravel-soc_fpga). We will compile and link the firmware to a specific address, which is corresponding to the user project address spcase.
Finally, we will run the `caravel-SOC` testbench to load the firmware assembly code and launch the RISC-V core to do the FIR computation.