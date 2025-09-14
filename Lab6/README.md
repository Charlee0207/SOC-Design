# SOC-Design Lab6

[Spec](./Lab6-wlos-baseline_workbook.pdf)<br>
[Report](./report.md)<br>
[Cource Repo](https://github.com/bol-edu/caravel-soc_fpga-lab/tree/main/lab-wlos_baseline)<br>


In this lab, we will try to implement UART function and try to optmize workload.

We may try to add some FIFO to reduce the UART latency and increase the throughput. And we will try to use interrupt to notice CPU, reduce the CPU time of polling UART result.