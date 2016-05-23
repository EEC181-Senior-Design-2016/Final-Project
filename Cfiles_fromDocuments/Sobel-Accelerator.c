#define HW_REGS_BASE  		0xc0000000  
#define HW_REGS_BASE_LW  	0xfc000000
#define HW_REGS_SPAN  		0x04000000
#define HW_REGS_MASK  		HW_REGS_SPAN - 1
#define ALT_LWFPGASLVS_OFST  	0xff200000
#define MICROSECONDS		50000
#define LED_BASE		0xa0
#define SW_BASE			0xb0
#define DONE_BASE               0x90
#define READY_BASE              0xa0
#define WARNING_BASE            0x80
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
	void * sdram_ptr, * done_ptr, * ready_ptr; //, * warning_ptr; //* sw_ptr, * led_ptr,
//#########################
	int i, j;
	clock_t begin, end;
	double time_spent;


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
  //led_ptr = virtual_base_lw + ((unsigned long)(ALT_LWFPGASLVS_OFST + LED_BASE) & (unsigned long)(HW_REGS_MASK));
  //sw_ptr = virtual_base_lw + ((unsigned long)(ALT_LWFPGASLVS_OFST + SW_BASE) & (unsigned long)(HW_REGS_MASK));
  done_ptr = virtual_base_lw + ((unsigned long)(ALT_LWFPGASLVS_OFST + DONE_BASE) & (unsigned long)(HW_REGS_MASK));
  ready_ptr = virtual_base_lw + ((unsigned long)(ALT_LWFPGASLVS_OFST + READY_BASE) & (unsigned long)(HW_REGS_MASK));
 // warning_ptr = virtual_base_lw + ((unsigned long)(ALT_LWFPGASLVS_OFST + WARNING_BASE) & (unsigned long)(HW_REGS_MASK));

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

     for(i = 0; i < IMG_HEIGHT; i++){
    	for(j = 0; j < IMG_WIDTH; j++){

		((unsigned char*)sdram_ptr)[index] = 1;
		index++;

	}}// double for

	// closes input file
	fclose(greyscltext);

	index = 0;

//####### TIMER STUFF BEGIN
	begin = clock();
//####### TIMER STUFF END

        *((int *)ready_ptr) = 1;

        while(*((int *)done_ptr) == 0) // && *((int *)warning_ptr) == 0)
        {}
        
        //if(*((int *)warning_ptr) == 1){printf("warning");        }
        *((int *)ready_ptr) = 0;

//######################################################################## WRITE FROM SDRAM (ORIGINAL IMAGE DATA)
/*
	
	index = 0;

	// reads numbers and stores into 
	for(i = 0; i < IMG_HEIGHT; i++){
    	for(j = 0; j < IMG_WIDTH; j++){
		((int*)sdram_ptr)[sdfilesize + index] = 0;
		index++;
	}}// double for (inputs row major)
*/


//####### TIMER STUFF 
	end = clock();
	time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
	printf("%f\n", time_spent);
//####### TIMER STUFF END
/*
	// reads matrix
	for(i = 0; i < IMG_HEIGHT; i++){
    	for(j = 0; j < IMG_WIDTH; j++){
		printf("%d ", outputmatrix[i][j]);
	}
		printf("\n");
	}// 
((int*)sdram_ptr)[sdfilesize + index] = (abs(sumx) + abs(sumy)) >> 3;
			index++;
*/

//######################################################################## READ FROM SDRAM (RESULT IMAGE DATA) AND WRITE TO FILE

	FILE *outputtext;
	outputtext = fopen("sdram_edge_detect.txt", "w+");

	index = 0;
	
	for(i = 0; i < IMG_HEIGHT; i++){
    	for(j = 0; j < IMG_WIDTH; j++){

		fprintf(outputtext,"%hhu", ((unsigned char*)sdram_ptr)[sdfilesize + index]); //sdfilesize
		if	(j == IMG_WIDTH-1)	{fprintf(outputtext,"\n");}
		else				{fprintf(outputtext," ");}
		index++;

	}}// double for
	
	fclose(outputtext);



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
  //close( fd );
  return( 0 );
}
