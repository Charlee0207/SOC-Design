#ifndef __FIR_H__
#define __FIR_H__

#define N  11
#define DATA_LEN 64

int taps[N] = {0,-10,-9,23,56,63,56,23,-9,-10,0};
int reg_fir_x;
int reg_fir_y;
int output[1];



#define USR_FIR_ap_ctrl	    0x30000000
#define USR_FIR_len			0x30000010
#define USR_FIR_tap			0x30000020
#define USR_FIR_X_in		0x30000080
#define USR_FIR_Y_out		0x30000084

#define reg_FIR_ap_ctrl		(*(volatile int*)USR_FIR_ap_ctrl)
#define reg_FIR_len			(*(volatile int*)USR_FIR_len)
#define reg_FIR_X_in		(*(volatile int*)USR_FIR_X_in)
#define reg_FIR_Y_out		(*(volatile int*)USR_FIR_Y_out)



#endif