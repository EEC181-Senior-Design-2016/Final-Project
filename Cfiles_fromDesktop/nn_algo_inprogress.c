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
//****************************************************************************************** readWeightsL1
void readWeightsL1(void * sdram_ptr){

	FILE *finalW1;
	int indexW1 = 0;
    short temp = 0;
    short readin = 0;
    int counter = 3;
    int w1Index = 0;
//*************************
	finalW1 = fopen("finalW1L1rounded.txt", "r");

	for(indexW1 = 0; indexW1 < 156800; indexW1++){
        fscanf(finalW1, "%hd", &readin); 
        temp += (readin & 0x000F) << (counter*4); 
        if (counter == 0){
            ((short*)sdram_ptr)[W1_2BASE + w1Index] = temp;
            w1Index++;
            temp = 0;
            counter = 3;
        }     
        else{counter--;}
	}
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

/*
	FILE *finalW2;
	int index = 0;
//*************************
	finalW2 = fopen("finalW1L2rounded.txt", "r");
	for(index = 0; index < 40000; index++)
        {fscanf(finalW2, "%hd", &( ((short*)sdram_ptr)[WEIGHT_BASE2 + index]) );}
	fclose(finalW2);
*/
    FILE *finalW2;
	int fileIndex = 0;
    short temp = 0;
    short readin = 0;
    int counter = 3;
    int sdramIndex = 0;
//*************************
	finalW2 = fopen("finalW1L2round_4compress.txt", "r"); 

    // for all 40000 weights (200 values * 200 2nd layer nodes)
	for(fileIndex = 0; fileIndex < 40000; fileIndex++){
        
        // read in a short
        fscanf(finalW2, "%hd", &readin); 

        // concatinate, shift, and build number for compressed values
        readin = readin & 0x000F;
        temp += (readin << (counter*4));

        // if 4 numbers are compressed
        if (counter == 0){
            
            // put number into sdram 
            ((short*)sdram_ptr)[WEIGHT_BASE2  + sdramIndex] = temp;
            //printf("%.4hx ", ((short*)sdram_ptr)[WEIGHT_BASE2  + sdramIndex] );
 

            // reset values for next number
            sdramIndex++;
            temp = 0;
            counter = 3;
        }     
        else{counter--;}
	}// for
//printf("\n");

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

	finalST = fopen("finalSoftmaxThetaroundedTimes100.txt", "r");
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

void readTestLabels(void * sdram_ptr){
	FILE *finalLabel;
	int indexLabel = 0;

	finalLabel = fopen("testLabels.txt", "r");
	for(indexLabel = 0; indexLabel < 10000; indexLabel++){
		fscanf(finalLabel, "%hd", &( ((short*)sdram_ptr)[TESTLABEL_BASE + indexLabel] )); 
    }
	fclose(finalLabel);
}
//******************************************************************************************
//******************************************************************************************
void readWeightsL1_orig(void * sdram_ptr){
	FILE *RW1;
	int indexRW1;


	RW1 = fopen("finalW1L1rounded.txt", "r");
	for(indexRW1 = 0; indexRW1 < 156800; indexRW1++){
		fscanf(RW1, "%hd", &( ((short*)sdram_ptr)[W1_2BASE + indexRW1] ));
	}
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
void lay1calc (void * sdram_ptr, int * x, void * done_ptr, void * ready_ptr){
    int currNode, prevNode;
    short ValL1, X, W, B;

    short temp = 0;
    short readin = 0;
    int counter = 3;
    int sdramIndex = 0;

    ValL1 = 0;
/*    
    *((int *)ready_ptr) = 1;
    while(*((int *)done_ptr) == 0){}
    *((int *)ready_ptr) = 0;
*/
    for (currNode = 0; currNode < 200; currNode++){
        ValL1 = 0;

        for(prevNode = 0; prevNode < 784; prevNode++){
            X = ((short*)sdram_ptr)[IMG_BASE2 + (784 * (*x)) + prevNode];
            W = ((short*)sdram_ptr)[W1_2BASE + (784 * (currNode)) + prevNode];
            ValL1 += (X * W);         
        }// for prevNode
        //printf("%hd ", ValL1);

        B = ((short*)sdram_ptr)[BIAS_BASE1 + currNode];
        ValL1 = B + ValL1; //((short*)sdram_ptr)[XW_BASE1 + currNode]; 
        ((short*)sdram_ptr)[LAY1_BASE + currNode] = pseudoSigmoid(ValL1);
        
/*
//*** compression combined        
        readin =  pseudoSigmoid(ValL1);
        
        // concatinate, shift, and build number for compressed values
        readin = readin & 0x000F;
        temp += (readin << (counter*4));

        // if 4 numbers are compressed
        if (counter == 0){
            
            // put number into sdram 
            ((short*)sdram_ptr)[LAY1_COMPR_BASE + sdramIndex] = temp;
            //printf("%.4hx ", ((short*)sdram_ptr)[LAY1_COMPR_BASE + sdramIndex] );
            // reset values for next number
            sdramIndex++;
            temp = 0;
            counter = 3;
        }     
        else{counter--;}
*/
    }// for currNode
    return;
}
//****************************************************************************************** lay1compress
void lay1compress (void *sdram_ptr){
	int fileIndex = 0;
    short temp = 0;
    short readin = 0;
    int counter = 3;
    int sdramIndex = 0;
//*************************
    // for 200 layer 1 values
	for(fileIndex = 0; fileIndex < 200; fileIndex++){
        
        // read in a short
        readin = ((short*)sdram_ptr)[LAY1_BASE + fileIndex]; 

        // concatinate, shift, and build number for compressed values
        readin = readin & 0x000F;
        temp += (readin << (counter*4));

        // if 4 numbers are compressed
        if (counter == 0){
            
            // put number into sdram 
            ((short*)sdram_ptr)[LAY1_COMPR_BASE + sdramIndex] = temp;
            //printf("%.4hx ", ((short*)sdram_ptr)[LAY1_COMPR_BASE + sdramIndex] );
            // reset values for next number
            sdramIndex++;
            temp = 0;
            counter = 3;
        }     
        else{counter--;}
	}// for
}// void lay1compress (void *sdram_ptr)
//****************************************************************************************** lay2calc
void lay2calc (void * sdram_ptr, void * done_ptr, void * ready_ptr){
/*    
    int currNode, prevNode;
    short ValL2, X, W;
//*************************
    // for every node in the 2nd layer
    for (currNode = 0; currNode < 200; currNode++){
        ValL2 = 0;
        
        // for every node in the 1st layer
        for(prevNode = 0; prevNode < 200; prevNode++){
            X = ((short*)sdram_ptr)[LAY1_BASE + prevNode];
            W = ((short*)sdram_ptr)[WEIGHT_BASE2 + (200* (currNode)) + prevNode];
            ValL2 += (X * W);
        }// for prevNode

        // add bias
        ValL2 += ((short*)sdram_ptr)[BIAS_BASE2 + currNode];
    
        // psuedoSigmoid and store in sdram
        ((short*)sdram_ptr)[LAY2_BASE + currNode] = pseudoSigmoid(ValL2);

    }// for currNode
 
    return;
*/
    int currNode;
    short ValL2, B, XW;
//*************************
    // run FPGA accelerator
    *((int *)ready_ptr) = 1;
    while(*((int *)done_ptr) == 0){}
    *((int *)ready_ptr) = 0;

    // for nodes of 2nd layer, add bias, psuedoSigmoid, and store result into sdram
    for (currNode = 0; currNode < 200; currNode++){
        B = ((short*)sdram_ptr)[BIAS_BASE2 + currNode];
        XW =((short*)sdram_ptr)[XW_BASE2 + currNode];
        //printf("%hd ", XW);
        ValL2 = B + XW;
        ((short*)sdram_ptr)[LAY2_BASE + currNode] = pseudoSigmoid(ValL2);
    }// for currNode
    //printf("\n");
    return;



}// void lay2calc (void * sdram_ptr)
//****************************************************************************************** layFcalc
int layFcalc (void * sdram_ptr){
    int currNode, prevNode, maxIndex;
    short ValLF;
    float ValLF_f, ValMax,ValGot;

    ValLF = 0;
    ValMax = 0;
    ValGot = 0;
    maxIndex = 0;

    for (currNode = 0; currNode < 10; currNode++){
        ValLF = 0;
        for(prevNode = 0; prevNode < 200; prevNode++){
            ValLF += ((short*)sdram_ptr)[LAY2_BASE + prevNode] * ( ((short*)sdram_ptr)[WEIGHT_BASEF + (200*currNode) + prevNode] );
        }// for prevNode

       ValLF_f = (float)ValLF;
       ValLF_f = ValLF_f/100;

       ValGot = sigmoid(ValLF_f);
       if (ValGot > ValMax){
         ValMax = ValGot;
         maxIndex = currNode + 1;
       }

    }// for currNode

    return maxIndex;
}

int NNalgo(void * sdram_ptr, int * x, void * done_ptr, void * ready_ptr){
    lay1calc(sdram_ptr, x,done_ptr,ready_ptr);
    lay1compress (sdram_ptr);
    lay2calc(sdram_ptr,done_ptr,ready_ptr);
    return layFcalc(sdram_ptr);
}



