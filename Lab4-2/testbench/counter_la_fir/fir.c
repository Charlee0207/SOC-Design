#include "fir.h"

void __attribute__ ( ( section ( ".mprjram" ) ) ) initfir() {
	//initial your fir

	// Program coef.
	for(int i=0; i<N; i++){
		( (*(volatile int*)(USR_FIR_tap + 0x04*i)) ) = taps[i];
	}
	// Program length
	reg_FIR_len = DATA_LEN;

	reg_fir_x = 0;
	reg_fir_y = 0;
	output[0] = 0;
}


int* __attribute__ ( ( section ( ".mprjram" ) ) ) fir(){
	// initialize fir (data_length, taps, ... etc)
	initfir();

	// If ap_idle!=1 (ap_idle[2:2]!=1), we polling until ap_idle==1
	while((reg_FIR_ap_ctrl&0x04) != 0x04);
	// Use bitwise or to program ap_start
	reg_FIR_ap_ctrl = reg_FIR_ap_ctrl | 1;


	//write down your fir
	for(int register i=0;i<DATA_LEN;i=i+1){
		reg_fir_x = i;
	
		// Polling until the fir can receive data	
		while((reg_FIR_ap_ctrl&0x10) != 0x10);
		reg_FIR_X_in = reg_fir_x;


		// Polling until the fir has transfer data	
		while((reg_FIR_ap_ctrl&0x20) != 0x20);
		reg_fir_y = reg_FIR_Y_out;

	}
	output[0] = reg_fir_y;
	return output;
}