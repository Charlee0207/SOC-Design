#include "fir.h"

void __attribute__ ( ( section ( ".mprjram" ) ) ) initfir() {
	for (int i = 0; i < N; i++) {
        inputbuffer[i] = inputsignal[i]; 
    }
	for (int i = 0; i < N; i++) {
        outputsignal[i] = 0; 
    }
}

int* __attribute__ ( ( section ( ".mprjram" ) ) ) fir(){
	initfir();
	for (int i = 0; i < N; i++) {		
		for (int j = 0; j < N; j++) {
			if (i-j >= 0) {
				outputsignal[i] += inputbuffer[i-j] * taps[j];
			}
		}
	}
	return outputsignal;
}
		