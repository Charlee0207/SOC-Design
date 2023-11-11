# SOC-Design Lab1

###### NTHU EECS24 109020014 李承澔

This report discusses the execution of an HLS multiplication kernel on the PYNQ-Z2 board.

## Brief introduction
In this lab, we delve into the FPGA High-Level Synthesis (HLS) flow.

Our objective is to design a multiplier with `2 inputs` and `1 output`, subsequently exporting it to RTL IP. This will then be deployed on the PYNQ-Z2 MPSoC PL side. The PYNQ Arm core will run a Python program that invokes the multiplier IP to compute the result.

We will then assess both its performance and utilization.


## Observed & Learned

```python
from __future__ import print_function

import sys, os

sys.path.append('/home/xilinx')
os.environ['XILINX_XRT'] = '/usr'
from pynq import Overlay

if __name__ == "__main__":
    print("Entry:", sys.argv[0])
    print("System argument(s):", len(sys.argv))

    print("Start of \"" + sys.argv[0] + "\"")

    ol = Overlay("/home/xilinx/jupyter_notebooks/Multip2Num.bit")
    regIP = ol.multip_2num_0
    
    for i in range(9):
        print("============================")
        for j in range(9):
            regIP.write(0x10, i + 1)
            regIP.write(0x18, j + 1)
            Res = regIP.read(0x20)
            print(str(i + 1) + " * " + str(j + 1) + " = " + str(Res))
    print("============================")
    print("Exit process")
```
In the `Multip2Num.ipynb` file, the Python program employs an API to invoke the kernel function, specifying addresses for input placement and result retrieval. Precisely, the host writes two int values at addresses `0x10 `and `0x18`, and fetches the result from `0x20`.

This behavior can be further confirmed by examining the waveform:
![](https://hackmd.io/_uploads/Bk8uyquJp.png)
Here, the `s_axi_controlAWADDR` value alternates between `10` and `18`, while `s_axi_controlARADDR` is set at `20`.


---
From this lab, I've gained an insightful introduction to the FPGA HLS kernel design flow and learned to interpret the associated performance and utilization reports. Furthermore, I've deepened my understanding of the data transfer protocols at both block and port levels.




## Screen Dump

### Performance
![](https://hackmd.io/_uploads/SkKb5u_1a.png)
> Synthesis Report

![](https://hackmd.io/_uploads/SkyS5O_yp.png)
> Co-Simulation Report

### Utilization
![](https://hackmd.io/_uploads/HJR8qO_Ja.png)
> Synthesis Report

### Interface
![](https://hackmd.io/_uploads/BkRYcuOy6.png)
> Synthesis Report

### Co-simulation transcript/waveform

![](https://hackmd.io/_uploads/HyCIs_Oka.png)
> Design Waveform: Block and Port level signal

![](https://hackmd.io/_uploads/Sk3i2ddka.png)
> Testbench Waveform
### Jupyter Notebook execution results
|![](https://hackmd.io/_uploads/H1NS_ddkT.png)||
|---|---|
![](https://hackmd.io/_uploads/H1ESuOdka.png)|![](https://hackmd.io/_uploads/SkVH__uyp.png)|






