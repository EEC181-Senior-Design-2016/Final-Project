#define HW_REGS_BASE  		0xc0000000  
#define HW_REGS_BASE_LW  	0xfc000000
#define HW_REGS_SPAN  		0x04000000
#define HW_REGS_MASK  		HW_REGS_SPAN - 1
#define ALT_LWFPGASLVS_OFST 0xff200000
#define MICROSECONDS		50000
//*******************************************
#define LED_BASE		0xa0
#define SW_BASE			0xb0
#define DONE_BASE               0x90
#define READY_BASE              0xa0
#define WARNING_BASE            0x80
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
    void * sdram_ptr; 
//, * done_ptr, * ready_ptr;
    int Correct, maxIndex, x; 
    int testLabelsArr[10000];
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

//########################################################################################## READ FILES AND STORE IN SDRAM 

  //readWeightsL1(sdram_ptr);
  readBiasL1(sdram_ptr);
  readWeightsL2(sdram_ptr);
  readBiasL2(sdram_ptr);
  readWeightsLF(sdram_ptr);
  readTestLabels(testLabelsArr);
  
  readImg_orig(sdram_ptr);
  readWeightsL1_orig(sdram_ptr);

/*
  printf("\n");

  for (i = 0; i < 784; i++){
    printf("%hd ",((short*)sdram_ptr)[W1_2BASE + 784*3 + i]);
  }
  printf("\n");
*/

//########################################################################################## NN ALGOR

  Correct = 0;
  maxIndex = 0;

  for (x = 0; x < 100; x++){
    maxIndex = NNalgo(sdram_ptr,&x);

    if (maxIndex == testLabelsArr[x]) {Correct++;}

  }// read 100 images

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
  printf("\nImage\n");

  for (i = 0; i < 49; i++){
    printf("%.4X ",((unsigned short*)sdram_ptr)[i]);
  }
  printf("\nW1\n");

  for (i = 49; i < 249; i++){
    printf("%.4X ",((unsigned short*)sdram_ptr)[i]);
  }
  printf("\nB1\n");

  for (i = 39449; i < 39649; i++){
    printf("%hd ",((short*)sdram_ptr)[i]);
  }
  printf("\nW2\n");

  for (i = 39849; i < 40049; i++){
    printf("%hd ",((short*)sdram_ptr)[i]);
  }

  printf("\nB2\n");

  for (i = 79849; i < 80049; i++){
    printf("%hd ",((short*)sdram_ptr)[i]);
  }
  
    printf("\nWF\n");

  for (i = 80249; i < 82249; i++){
    printf("%hd ",((short*)sdram_ptr)[i]);
  }
  printf("\n");


  for (i = 0; i < 10000; i++){
    printf("%d ",testLabelsArr[i]);
  }
  printf("\n");


  for (i = 82249; i < 83033; i++){
    printf("%hd ",((short*)sdram_ptr)[i]);
  }
  printf("\n");


  for (i = 7922249; i < 7922449; i++){
    printf("%hd ",((short*)sdram_ptr)[i]);
  }
  printf("\n");

//####### TIMER STUFF BEGIN
	clock_t begin, end;
	float time_spent;

    begin = clock(); 
	end = clock();
	time_spent = (float)(end - begin) / CLOCKS_PER_SEC;
	printf("Time spent = %f_secs \n", time_spent);
//####### TIMER STUFF END
*/

