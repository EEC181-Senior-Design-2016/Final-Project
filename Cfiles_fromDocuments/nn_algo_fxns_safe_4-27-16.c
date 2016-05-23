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
//########################################################################################## 
//****************************************************************************************** readWeightsL1
void readWeightsL1(void * sdram_ptr){

	FILE *finalW1;
	int indexW1 = 0;
    short temp = 0;
    short readin = 0;
    int counter = COMPRESS_W1;
    int w1Index = 0;
//*************************
	finalW1 = fopen("finalW1L1rounded.txt", "r");

	for(indexW1 = 0; indexW1 < 156800; indexW1++){
        fscanf(finalW1, "%hd", &readin); 
        //if(w1Index < 200) {printf("%.1X",(unsigned short*)readin);}
        //if(w1Index < 200 && (indexW1+1)%4 == 0) {printf(" ");}
        temp += (readin & 0x000F) << (counter*4); 
        if (counter == 0){
            ((short*)sdram_ptr)[WEIGHT_BASE1 + w1Index] = temp;
            w1Index++;
            temp = 0;
            counter = COMPRESS_W1;
        }     
        else{counter--;}
	}
    //printf("\nDone\n");
	fclose(finalW1);
}
//****************************************************************************************** readBiasL1
void readBiasL1(void * sdram_ptr){

	FILE *finalB1;
	int indexB1 = 0;

	finalB1 = fopen("finalB1L1rounded.txt", "r");
	for(indexB1 = 0; indexB1 < 200; indexB1++){
		fscanf(finalB1, "%hd", &( ((short*)sdram_ptr)[BIAS_BASE1 + indexB1]) );
	}
	fclose(finalB1);
}
//****************************************************************************************** readWeightsL2
void readWeightsL2(void * sdram_ptr){

	FILE *finalW2;
	int indexW2 = 0;

	finalW2 = fopen("finalW1L2rounded.txt", "r");
	for(indexW2 = 0; indexW2 < 40000; indexW2++){
		fscanf(finalW2, "%hd", &( ((short*)sdram_ptr)[WEIGHT_BASE2 + indexW2]) );
	}
	fclose(finalW2);
}

//****************************************************************************************** readBiasL2
void readBiasL2(void * sdram_ptr){
	FILE *finalB2;
	int indexB2 = 0;

	finalB2 = fopen("finalB1L2rounded.txt", "r"); 
	for(indexB2 = 0; indexB2 < 200; indexB2++){
		fscanf(finalB2, "%hd", &( ((short*)sdram_ptr)[BIAS_BASE2 + indexB2]) );
	}
	fclose(finalB2);
}
//****************************************************************************************** readWeightsLF
void readWeightsLF(void * sdram_ptr){
	FILE *finalST;
	int indexST = 0;

	finalST = fopen("finalSoftmaxThetarounded.txt", "r");
	for(indexST = 0; indexST < 2000; indexST++){
		fscanf(finalST, "%hd", &( ((short*)sdram_ptr)[WEIGHT_BASEF + indexST]) );
	}
	fclose(finalST);
}
//****************************************************************************************** readImg
void readImg(void * sdram_ptr){
	FILE *images100;
	int index100 = 0;
    unsigned short temp = 0;
    unsigned short result = 0;
    float readin = 0;
    int counter = 15;
    int pixIndex = 0;
    int numPixels = 784; 

	images100 = fopen("testData.txt", "r"); 
//*************************
	for(index100 = 0; index100 < numPixels; index100++){
      fscanf(images100, "%f", &(readin));
      readin += 0.5;
      temp = (unsigned short)readin;
      //printf("%hd", temp);
      //if (index100 !=0 && (index100+1)%16 == 0){printf("\n");}
      result += (temp << counter);

      if (counter == 0){
        ((unsigned short*)sdram_ptr)[pixIndex] = (result & 0x0FFFF);
        result = 0;
        counter = 15;
        pixIndex++;
      }     
      else{counter--;}
	}
   	
    fclose(images100);
}
//****************************************************************************************** readTestLabels

void readTestLabels(int * testLabelsArr){
	FILE *finalLabel;
	int indexLabel = 0;

	finalLabel = fopen("testLabels.txt", "r");
	for(indexLabel = 0; indexLabel < 10000; indexLabel++){
		fscanf(finalLabel, "%d", &( testLabelsArr[indexLabel]) ); 
    }
	fclose(finalLabel);
}
//******************************************************************************************
//******************************************************************************************
void readWeightsL1_orig(void * sdram_ptr){
	FILE *RW1;
	int indexRW1;
    short temp;

	RW1 = fopen("finalW1L1rounded.txt", "r");
	for(indexRW1 = 0; indexRW1 < 156800; indexRW1++){
		fscanf(RW1, "%hd", &(temp) );
        //if (indexRW1 < 7840 && (indexRW1+1)%784 == 0) {printf("\n");}
        //if (indexRW1 < 7840) {printf("%hd ", temp);}
        ((short*)sdram_ptr)[W1_2BASE + indexRW1] = temp;
	}
printf("\n\nDONE\n");
	fclose(RW1);
}
//******************************************************************************************
void readImg_orig(void * sdram_ptr){
	FILE *Img;
	int indexImg = 0;
    float readin = 0;

	Img = fopen("testData.txt", "r");
	for(indexImg = 0; indexImg < 7840000; indexImg++){
        fscanf(Img, "%f", &(readin));
        readin += 0.5;
        ((short*)sdram_ptr)[IMG_BASE2 + indexImg] = (short)readin;
	}
	fclose(Img);
}
//########################################################################################## Layer Fxns
short pseudoSigmoid(short value){
    if (value > 0)
        return 1;
    else
        return 0;
}

float sigmoid (float value){
    return (1.0/ ( 1.0 + exp(-value) ));
}

//########################################################################################## 
//****************************************************************************************** lay1calc
void lay1calc (void * sdram_ptr, int * x){
    int currNode, prevNode;
    short ValL1, X, W, B;

    ValL1 = 0;
    for (currNode = 0; currNode < 200; currNode++){
        ValL1 = 0;
        for(prevNode = 0; prevNode < 784; prevNode++){
            X = ((short*)sdram_ptr)[IMG_BASE2 + (784 * (*x)) + prevNode];
            //printf("%hd: ", X);
            W = ((short*)sdram_ptr)[W1_2BASE + (784 * (currNode)) + prevNode];
            //printf("%hd ", W);
            ValL1 += (X * W);
        }// for prevNode
        //printf("\n");
        B = ((short*)sdram_ptr)[BIAS_BASE1 + currNode];
        ValL1 += B; 
        //printf("%hd ", B);
        ((short*)sdram_ptr)[LAY1_BASE + currNode] = pseudoSigmoid(ValL1);

    }// for currNode
    return;
}

//****************************************************************************************** lay2calc
void lay2calc (void * sdram_ptr){
    int currNode, prevNode;
    short ValL2;

    ValL2 = 0;

    for (currNode = 0; currNode < 200; currNode++){
        ValL2 = 0;
        for(prevNode = 0; prevNode < 200; prevNode++){
            ValL2 += ((short*)sdram_ptr)[LAY1_BASE + prevNode] * ((short*)sdram_ptr)[WEIGHT_BASE2 + (200* (currNode)) + prevNode];
        }// for prevNode
        ValL2 += ((short*)sdram_ptr)[BIAS_BASE2 + currNode];
    
        ((short*)sdram_ptr)[LAY2_BASE + currNode] = pseudoSigmoid(ValL2);

    }// for currNode
    return;
}
//****************************************************************************************** layFcalc
int layFcalc (void * sdram_ptr){
    int currNode, prevNode, maxIndex;
    short ValLF,ValMax,ValGot;

    ValLF = 0;
    ValMax = 0;
    ValGot = 0;
    maxIndex = 0;

    for (currNode = 0; currNode < 10; currNode++){
        ValLF = 0;
        for(prevNode = 0; prevNode < 200; prevNode++){
            ValLF += ((short*)sdram_ptr)[LAY2_BASE + prevNode] * ( ((short*)sdram_ptr)[WEIGHT_BASEF + (200*currNode) + prevNode] );
        }// for prevNode

       ValGot = sigmoid((float)ValLF);
       if (ValGot > ValMax){
         ValMax = ValGot;
         maxIndex = currNode + 1;
       }

    }// for currNode

    return maxIndex;
}

int NNalgo(void * sdram_ptr, int * x){
    //int i;

    //readImg(sdram_ptr);
    lay1calc(sdram_ptr, x);

    //for (i = 39649; i < 39849; i++)    {printf("%hd ",((short*)sdram_ptr)[i]);}
    lay2calc(sdram_ptr);
    return layFcalc(sdram_ptr);
    //return 0;
}



