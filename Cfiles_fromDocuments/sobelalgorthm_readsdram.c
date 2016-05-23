#define HW_REGS_BASE  		0xc0000000  
#define HW_REGS_BASE_LW  	0xfc000000
#define HW_REGS_SPAN  		0x04000000
#define HW_REGS_MASK  		HW_REGS_SPAN - 1
#define ALT_LWFPGASLVS_OFST  	0xff200000
#define MICROSECONDS		50000
#define LED_BASE		0xa0
#define SW_BASE			0xb0
#define DONE_BASE               0x80
#define READY_BASE              0x90
#define SDRAM_BASE		0x00
#define IMG_HEIGHT 512
#define IMG_WIDTH 512

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <time.h>
#include <sys/mman.h>
#include <ctype.h>
#include <math.h>
#include <string.h>

int main() {
//######################################################################## PTRS TO ADDRS
	void *virtual_base, *virtual_base_lw;
	int fd;
	void * sdram_ptr, * sw_ptr, * led_ptr, * done_ptr, * ready_ptr;
//#########################
	int row, col, i, j, sumx, sumy;
	unsigned char greysclmatrix[IMG_HEIGHT][IMG_WIDTH];
	unsigned char outputmatrix[IMG_HEIGHT][IMG_WIDTH];
	clock_t begin, end;
	double time_spent;

	unsigned char Gx[3][3];
	Gx[0][0] = -1;
	Gx[1][0] = -2;
	Gx[2][0] = -1;
	Gx[0][1] = 0;
	Gx[1][1] = 0;
	Gx[2][1] = 0;
	Gx[0][2] = 1;
	Gx[1][2] = 2;
	Gx[2][2] = 1;

	unsigned char Gy[3][3];
	Gy[0][0] = 1;
	Gy[1][0] = 0;
	Gy[2][0] = -1;
	Gy[0][1] = 2;
	Gy[1][1] = 0;
	Gy[2][1] = -2;
	Gy[0][2] = 1;
	Gy[1][2] = 0;
	Gy[2][2] = -1;


//######################################################################## DEBUG IF NOT MEM NOT AVAIL
  if((fd = open ("/dev/mem",  (O_RDWR | O_SYNC))) == -1) {
    printf( "ERROR: could not open \"/dev/mem\"...\n");
    return( 1 );
  }


//######################################################################## MAPS VB TO A MEMORY ADDR
  virtual_base = mmap(NULL, HW_REGS_SPAN, (PROT_READ|PROT_WRITE), MAP_SHARED, fd, HW_REGS_BASE);
  if( virtual_base == MAP_FAILED ) {
    printf( "ERROR: mmap() failed...\n" ); 
    close( fd );
    return( 1 );
  }
  sdram_ptr = virtual_base + ((unsigned long)(HW_REGS_BASE + SDRAM_BASE) & (unsigned long)(HW_REGS_MASK));
//######################################################################## MAPS OTHER PTRS TO MEM ADDRS
  virtual_base_lw = mmap(NULL, HW_REGS_SPAN, (PROT_READ|PROT_WRITE), MAP_SHARED, fd, HW_REGS_BASE_LW);
  if( virtual_base == MAP_FAILED ) {
    printf( "ERROR: mmap() failed...\n" ); 
    close( fd );
    return( 1 );
  }
  led_ptr = virtual_base_lw + ((unsigned long)(ALT_LWFPGASLVS_OFST + LED_BASE) & (unsigned long)(HW_REGS_MASK));
  sw_ptr = virtual_base_lw + ((unsigned long)(ALT_LWFPGASLVS_OFST + SW_BASE) & (unsigned long)(HW_REGS_MASK));
  done_ptr = virtual_base_lw + ((unsigned long)(ALT_LWFPGASLVS_OFST + DONE_BASE) & (unsigned long)(HW_REGS_MASK));
  ready_ptr = virtual_base_lw + ((unsigned long)(ALT_LWFPGASLVS_OFST + READY_BASE) & (unsigned long)(HW_REGS_MASK));
//######################################################################## READ FROM ORIGINAL IMAGE AND STORE IN SDRAM

	// creates file ptr for input
	FILE *greyscltext;
	int index = 0;
	int sdfilesize = 0;
	
	// opens input file for reading
	greyscltext = fopen("lenna_decompressed.txt", "r");



	// reads numbers and stores into 
	for(i = 0; i < IMG_HEIGHT; i++){
    	for(j = 0; j < IMG_WIDTH; j++){
		fscanf(greyscltext, "%hhu", &( ((unsigned char*)sdram_ptr)[index]) );
		index++;
	}}// double for (inputs row major)

	sdfilesize = index;

	// closes input file
	fclose(greyscltext);

	index = 0;
//######################################################################## READ FROM SDRAM (RESULT IMAGE DATA) AND WRITE TO FILE

    
	//FILE *outputtext;
	//outputtext = fopen("sdram_edge_detect.txt", "w+");

	index = 0;
	
	for(i = 0; i < IMG_HEIGHT; i++){
    	for(j = 0; j < IMG_WIDTH; j++){
        printf("HERE\n");
         printf("%hhu", ((unsigned char*)sdram_ptr)[sdfilesize + index]);
		//fprintf(outputtext,"%hhu", ((unsigned char*)sdram_ptr)[sdfilesize + index]);
		if	(j == IMG_WIDTH-1)	{printf("\n");}
		else				{printf(" ");}
		index++;

	}}// double for
	
	//fclose(outputtext);



//######################################################################## CLOSE MAPPED ADDRS
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

//######################################################################## CLOSE WHEN ALL SUCCESSFUL AND DONE
  close( fd );
  return( 0 );
}
