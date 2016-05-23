#define HW_REGS_BASE  		0xfc000000
#define HW_REGS_SPAN  		0x04000000
#define HW_REGS_MASK  		HW_REGS_SPAN - 1
#define ALT_LWFPGASLVS_OFST  	0xff200000
#define MICROSECONDS		50000
#define LED_BASE		0x80
#define SW_BASE			0x90

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <time.h>
#include <sys/mman.h>
//#include <math.h>

int main() {
// PTRS TO ADDRS
  void *virtual_base;
//  void *sdram;
  int fd;
  void * sw_ptr, * led_ptr;
    unsigned int shiftingVal = 1;
    unsigned int maskVal = 0x200;
    unsigned int currVal = 0;
    unsigned int shiftIndex = 0;

// DEBUG IF NOT MEM NOT AVAIL
  if((fd = open ("/dev/mem",  (O_RDWR | O_SYNC))) == -1) {
    printf( "ERROR: could not open \"/dev/mem\"...\n");
    return( 1 );
  }


// MAPS VB TO A MEMORY ADDR
  virtual_base = mmap(NULL, HW_REGS_SPAN, (PROT_READ|PROT_WRITE), MAP_SHARED, fd, HW_REGS_BASE);
  if( virtual_base == MAP_FAILED ) {
    printf( "ERROR: mmap() failed...\n" );
    close( fd );
    return( 1 );
  }

// MAPS OTHER PTRS TO MEM ADDRS

//  sdram = virtual_base + ((unsigned long)(HW_REGS_BASE + 0x) & (unsigned long)(HW_REGS_MASK));
  led_ptr = virtual_base + ((unsigned long)(ALT_LWFPGASLVS_OFST + LED_BASE) & (unsigned long)(HW_REGS_MASK));
  sw_ptr = virtual_base + ((unsigned long)(ALT_LWFPGASLVS_OFST + SW_BASE) & (unsigned long)(HW_REGS_MASK));
  
// #################################################
//  *((unsigned int*) led_ptr) = 10;   sets leds to 10

while(1){
    shiftingVal = 1;
    maskVal = 0x200;
    currVal = 0;
    shiftIndex = 0;
    for (shiftIndex = 0; shiftIndex < 10; shiftIndex++){
        currVal = shiftingVal;
        *((unsigned int*) led_ptr) = currVal;
        shiftingVal = shiftingVal << 1;
        usleep(MICROSECONDS);
    }// for shiftIndex
    
    shiftingVal = 1;
    while (currVal < 0x3FF){
        
        currVal = maskVal + shiftingVal;
        *((unsigned int*) led_ptr) = currVal;
        usleep(MICROSECONDS);
        
        if ((shiftingVal << 1) & (maskVal)){
            maskVal = (maskVal >> 1) + 0x200;
            shiftingVal = 1;
        }
        else{
            shiftingVal = shiftingVal << 1;
        }
    }
    usleep(MICROSECONDS * 10);
}//while (1)
// #################################################
// ERROR CHECK
  if ( munmap( virtual_base, HW_REGS_SPAN) != 0 ) {
    printf( "ERROR: munmap() failed...\n" );
    close( fd );
    return( 1 );
  }

// CLOSE WHEN ALL SUCCESSFUL AND DONE
  close( fd );
  return( 0 );
}
