
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <time.h>

int main(void)
{
  volatile unsigned char * fpga_sdram = (unsigned char *) 0xC0000000;
  volatile unsigned int * done_signal = (unsigned int *) 0xFF200080;
  volatile unsigned int * ready_signal = (unsigned int *) 0xFF200090;

  int i = 0; 
  int random_num = 0;
  unsigned char* chip_addr;
  unsigned int * done;
  unsigned int * ready;
  
  chip_addr = fpga_sdram;
  ready = ready_signal;
  done = done_signal;
  
  srand(time(NULL));

    for (i = 0; i<262144; i++){
        random_num = i % 255;//rand() % 255;
        *chip_addr = (unsigned char) random_num;
        chip_addr++;
    }// for
    
    *ready = 1;
    
    while (*done_signal == 0){}
    
    *ready = 0;

  return 0;

}// main

