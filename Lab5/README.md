# SOC-Design Lab5

[Spec](./lab5-caravel%20FPGA.pdf)<br>
[Report](./report.md)<br>
[Cource Repo](https://github.com/bol-edu/caravel-soc_fpga-lab/tree/main/labi)<br>

In last lab, the HW accelerator and firmware have been integrated into caravel SOC and passed the testbench. 
In this lab, we will try to place `gcd`, `counter` HW design into caravel SOC, which utilize logic analyzer and wishbone to communicate with outerand pack them into Vivado project.
Later, we will upload the Vivado project bitstream into PYNQ board and launch HW design in PL side by jupyter notebook.