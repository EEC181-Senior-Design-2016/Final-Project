#define HW_REGS_BASE  		0xc0000000  
#define HW_REGS_BASE_LW  	0xfc000000
#define HW_REGS_SPAN  		0x04000000
#define HW_REGS_MASK  		HW_REGS_SPAN - 1
#define ALT_LWFPGASLVS_OFST 0xff200000
#define MICROSECONDS		50000
//*******************************************
#define DONE_BASE               0xa0
#define READY_BASE              0xb0
#define DONE_BASE2               0x80
#define READY_BASE2              0x90
#define SDRAM_BASE		0x00

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <time.h>
#include <sys/mman.h>
#include <ctype.h>
#include <math.h>
#include <string.h>
#include "nn_algo_fxns.h"
//########################################################################################## MAIN FXN
int main() {
//************************ PTRS TO ADDRS
	void *virtual_base, *virtual_base_lw;
	int fd;
    void * sdram_ptr, * done_ptr, * ready_ptr, * done_ptr2, * ready_ptr2;
    int Correct, maxIndex, x; 
    int i;

//************************ DEBUG IF NOT MEM NOT AVAIL
  if((fd = open ("/dev/mem",  (O_RDWR | O_SYNC))) == -1) {
    printf( "ERROR: could not open \"/dev/mem\"...\n");
    return( 1 );
  }
//************************ MAPS PTRS TO MEMORY ADDRS
  virtual_base = mmap(NULL, HW_REGS_SPAN, (PROT_READ|PROT_WRITE), MAP_SHARED, fd, HW_REGS_BASE);

  if( virtual_base == MAP_FAILED ) {
    printf( "ERROR: mmap() failed...\n" ); 
    close( fd );
    return( 1 );
  }
  sdram_ptr = virtual_base + ((unsigned long)(HW_REGS_BASE + SDRAM_BASE) & (unsigned long)(HW_REGS_MASK));
  virtual_base_lw = mmap(NULL, HW_REGS_SPAN, (PROT_READ|PROT_WRITE), MAP_SHARED, fd, HW_REGS_BASE_LW);

  if( virtual_base == MAP_FAILED ) {
    printf( "ERROR: mmap() failed...\n" ); 
    close( fd );
    return( 1 );
  }

  done_ptr = virtual_base_lw + ((unsigned long)(ALT_LWFPGASLVS_OFST + DONE_BASE) & (unsigned long)(HW_REGS_MASK));
  ready_ptr = virtual_base_lw + ((unsigned long)(ALT_LWFPGASLVS_OFST + READY_BASE) & (unsigned long)(HW_REGS_MASK));
  done_ptr2 = virtual_base_lw + ((unsigned long)(ALT_LWFPGASLVS_OFST + DONE_BASE2) & (unsigned long)(HW_REGS_MASK));
  ready_ptr2 = virtual_base_lw + ((unsigned long)(ALT_LWFPGASLVS_OFST + READY_BASE2) & (unsigned long)(HW_REGS_MASK));

//########################################################################################## READ FILES AND STORE IN SDRAM 
/*
  for (i = 0; i < 8079049; i++){
    ((short*)sdram_ptr)[i] = 0;
  }
*/
  readWeightsL1(sdram_ptr);
  readBiasL1(sdram_ptr);
  readWeightsL2(sdram_ptr);
  readBiasL2(sdram_ptr);
  readWeightsLF(sdram_ptr);
  readTestLabels(sdram_ptr);
  
  for (i = 0; i < 400; i++){
    readImg(sdram_ptr, i);
  }


  printf("DONE READING\n");

//########################################################################################## NN ALGOR
//####### TIMER STUFF BEGIN
	
    clock_t begin, end;
	float time_spent;

    time_spent = 0;


  Correct = 0;
  maxIndex = 0;
  x = 0;
  i = 0;

  for (x = 0; x < 400; x++){ // 100
    begin = clock(); 

    // start algo
    maxIndex = NNalgo(sdram_ptr,&x,done_ptr,ready_ptr,done_ptr2,ready_ptr2);
    
    // check if returned index = actual number
    if (maxIndex == ((short*)sdram_ptr)[TESTLABEL_BASE + x]) {Correct++;}

	end = clock();
    time_spent += ((float)(end - begin) / CLOCKS_PER_SEC);

    // replace current img area w/ next image
    for (i = 0; i < 196; i++){ // 784
        ((short*)sdram_ptr)[IMG_BASE2 + i] = ((short*)sdram_ptr)[IMG_BASE2 + (196 * (x+1)) + i];
    }
  }// for

    printf("Time spent = %f_secs \n", time_spent);
  //####### TIMER STUFF END
  printf("Num of Correct = %d\n",Correct);

//########################################################################################## CLOSE MAPPED ADDRS
  if ( munmap( virtual_base, HW_REGS_SPAN) != 0 ) {
    printf( "ERROR: munmap() failed...\n" );
    close( fd );
    return( 1 );
  }
  if ( munmap( virtual_base_lw, HW_REGS_SPAN) != 0 ) {
    printf( "ERROR: munmap() failed...\n" );
    close( fd );
    return( 1 );
  }

//##########################################################################################  
  close( fd );
  return( 0 );
}// main
//##########################################################################################  
//##########################################################################################  extra code 
/*

//####### TIMER STUFF BEGIN
//	clock_t begin, end;
//	float time_spent;

//    time_spent = 0;
//    begin = clock(); 


//	end = clock();
//    time_spent += (float)(end - begin) / CLOCKS_PER_SEC;

//    for (i = 0; i < 784; i++){
//        ((short*)sdram_ptr)[IMG_BASE2 + i] = ((short*)sdram_ptr)[IMG_BASE2 + (784 * x) + i];
//    }

//	printf("Time spent = %f_secs \n", time_spent);
  //####### TIMER STUFF END



*/

