# WorkLoad Optimize SOC (WLOS) Baseline

### Simulation WLOS firmware
```sh
cd ./lab-wlos_baseline/testbench/lab6_uart
source run_clean
source run_sim
```

### Generate HEX for PYNQ
Note the discussion by https://github.com/bol-edu/HLS-SOC-Discussions/discussions/175, we add some for loops to observe the results in Jupyter Notebook
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


