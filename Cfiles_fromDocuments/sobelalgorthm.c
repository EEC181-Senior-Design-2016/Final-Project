#define IMG_HEIGHT 512
#define IMG_WIDTH 512

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <time.h>

int main(){
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
//######################################################################## FILE INPUT READING

	// creates file ptr for input
	FILE *greyscltext;
	FILE *outputtext;
	
	// opens input file for reading
	greyscltext = fopen("lenna_decompressed.txt", "r");
	begin = clock();
	// reads numbers and stores into 
	for(i = 0; i < IMG_HEIGHT; i++){
    	for(j = 0; j < IMG_WIDTH; j++){
		fscanf(greyscltext, "%d", &greysclmatrix[i][j]);
	}}// double for (inputs row major)

	// closes input file
	fclose(greyscltext);

//######################################################################## PRINT GREYSCALE MATRIX
	//i=-1;
	//j=-1;
/*

	// reads matrix
	for(i = 0; i < IMG_HEIGHT; i++){
    	for(j = 0; j < IMG_WIDTH; j++){
		printf("%d ", greysclmatrix[i][j]);
	}
		printf("\n");
	}// 
*/
//######################################################################## EDGE DETECTION ALGO

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
			//printf("%d %d", row, col);
		} //for col
	} //for row

//######################################################################## WRITE TO OUTPUT FILE
	end = clock();
	time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
	printf("%f\n", time_spent);

	outputtext = fopen("edge_detect.txt", "w+");

	for(i = 0; i < IMG_HEIGHT; i++){
    	for(j = 0; j < IMG_WIDTH; j++){

		fprintf(outputtext,"%d", outputmatrix[i][j]);

		if	(j == IMG_WIDTH-1)	{fprintf(outputtext,"\n");}
		else				{fprintf(outputtext," ");}


	}}// double for
	fclose(outputtext);
	
//########################################################################
	return 0;


} //main
