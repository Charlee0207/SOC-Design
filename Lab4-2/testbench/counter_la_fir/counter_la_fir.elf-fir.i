# 0 "fir.c"
# 1 "/home/chngh/Desktop/SOC_design/Lab4/lab4-2/lab-caravel_fir/testbench/counter_la_fir//"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "fir.c"
# 1 "fir.h" 1






int taps[11] = {0,-10,-9,23,56,63,56,23,-9,-10,0};
int reg_fir_x;
int reg_fir_y;
int output[1];
# 2 "fir.c" 2

void __attribute__ ( ( section ( ".mprjram" ) ) ) initfir() {



 for(int i=0; i<11; i++){
  ( (*(volatile int*)(0x30000020 + 0x04*i)) ) = taps[i];
 }

 (*(volatile int*)0x30000010) = 64;

 reg_fir_x = 0;
 reg_fir_y = 0;
 output[0] = 0;
}


int* __attribute__ ( ( section ( ".mprjram" ) ) ) fir(){

 initfir();


 while(((*(volatile int*)0x30000000)&0x04) != 0x04);

 (*(volatile int*)0x30000000) = (*(volatile int*)0x30000000) | 1;



 for(int register i=0;i<64;i=i+1){
  reg_fir_x = i;


  while(((*(volatile int*)0x30000000)&0x10) != 0x10);
  (*(volatile int*)0x30000080) = reg_fir_x;



  while(((*(volatile int*)0x30000000)&0x20) != 0x20);
  reg_fir_y = (*(volatile int*)0x30000084);

 }
 output[0] = reg_fir_y;
 return output;
}
