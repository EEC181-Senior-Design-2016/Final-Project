#define HW_REGS_BASE  		0xc0000000  //0xfc000000 for lightweight master (leds and switches)
#define HW_REGS_SPAN  		0x04000000
#define HW_REGS_MASK  		HW_REGS_SPAN - 1
#define ALT_LWFPGASLVS_OFST  	0xff200000
#define MICROSECONDS		50000
#define LED_BASE		0x80
#define SW_BASE			0x90
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
	void *virtual_base;
	int fd;
	void * sdram_ptr, * sw_ptr, * led_ptr;
//#########################
	int row, col, i, j, sumx, sumy;
	int greysclmatrix[IMG_HEIGHT][IMG_WIDTH];
	int outputmatrix[IMG_HEIGHT][IMG_WIDTH];
	clock_t begin, end;
	double time_spent;

	int Gx[3][3];
	Gx[0][0] = -1;
	Gx[1][0] = -2;
	Gx[2][0] = -1;
	Gx[0][1] = 0;
	Gx[1][1] = 0;
	Gx[2][1] = 0;
	Gx[0][2] = 1;
	Gx[1][2] = 2;
	Gx[2][2] = 1;

	int Gy[3][3];
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

//######################################################################## MAPS OTHER PTRS TO MEM ADDRS

  sdram_ptr = virtual_base + ((unsigned long)(HW_REGS_BASE + SDRAM_BASE) & (unsigned long)(HW_REGS_MASK));
  led_ptr = virtual_base + ((unsigned long)(ALT_LWFPGASLVS_OFST + LED_BASE) & (unsigned long)(HW_REGS_MASK));
  sw_ptr = virtual_base + ((unsigned long)(ALT_LWFPGASLVS_OFST + SW_BASE) & (unsigned long)(HW_REGS_MASK));
  

//######################################################################## READ FROM ORIGINAL IMAGE AND STORE IN SDRAM

	// creates file ptr for input
	FILE *greyscltext;
	int index = 0;
	int sdfilesize = 0;
	
	// opens input file for reading
	greyscltext = fopen("lenna_decompressed.txt", "r");

//####### TIMER STUFF BEGIN
	begin = clock();
//####### TIMER STUFF END

	// reads numbers and stores into 
	for(i = 0; i < IMG_HEIGHT; i++){
    	for(j = 0; j < IMG_WIDTH; j++){
		fscanf(greyscltext, "%d", &( ((int*)sdram_ptr)[index]) );
		index++;
	}}// double for (inputs row major)

	sdfilesize = index;

	// closes input file
	fclose(greyscltext);



//######################################################################## WRITE FROM SDRAM (ORIGINAL IMAGE DATA)

	
	index = 0;

	// reads numbers and stores into 
	for(i = 0; i < IMG_HEIGHT; i++){
    	for(j = 0; j < IMG_WIDTH; j++){
		greysclmatrix[i][j] = ((int*)sdram_ptr)[index];
		index++;
	}}// double for (inputs row major)

//######################################################################## DO ALGO ED AND STORE TO OUTPUT MATRIX TO BE WRITTEN

	index = 0;
	memset(outputmatrix, 0, sizeof(outputmatrix[0][0]) * (IMG_HEIGHT) * (IMG_WIDTH));

	for(row = 1; row < IMG_HEIGHT-1; row++) {
	for(col = 1; col < IMG_WIDTH-1; col++){
			sumx = 0;
			sumy = 0;
			
			for(i = 1; i <= 3; i++){
			for(j = 1; j <= 3; j++){
//sum = sum of (9 cells times conv values in 3x3 matrix), difference in intensity horizontally 
					sumx = sumx + greysclmatrix[row+(i-2)][col+(j-2)] * Gx[i-1][j-1]; 
					sumy = sumy + greysclmatrix[row+(i-2)][col+(j-2)] * Gy[i-1][j-1];
					
			} //for iterating vertically then horizontally
			} //for iterating horizontally then veritcally
			outputmatrix[row][col] = (abs(sumx) + abs(sumy)) >> 3;
			
		} //for col
	} //for row

//######################################################################## WRITE OUTPUT MATRIX TO SDRAM 
	index = 0;

	for(i = 0; i < IMG_HEIGHT; i++){
    	for(j = 0; j < IMG_WIDTH; j++){
		((int*)sdram_ptr)[sdfilesize + index] = outputmatrix[i][j];
		index++;
	}}

//####### TIMER STUFF BEGIN
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

		fprintf(outputtext,"%d", ((int*)sdram_ptr)[sdfilesize + index]);

		if	(j == IMG_WIDTH-1)	{fprintf(outputtext,"\n");}
		else				{fprintf(outputtext," ");}
		index++;

	}}// double for
	
	fclose(outputtext);



//######################################################################## ERROR CHECK
  if ( munmap( virtual_base, HW_REGS_SPAN) != 0 ) {
    printf( "ERROR: munmap() failed...\n" );
    close( fd );
    return( 1 );
  }

//######################################################################## CLOSE WHEN ALL SUCCESSFUL AND DONE
  close( fd );
  return( 0 );
}
