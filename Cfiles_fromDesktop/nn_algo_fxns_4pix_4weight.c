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
	int fileIndex = 0;
    short temp = 0;
    short readin = 0;
    int counter = 3;
    int sdramIndex = 0;
//*************************
	finalW1 = fopen("finalW1L1rounded.txt", "r");

    // for all 156800 weights (784 values * 200 1st layer nodes)
	for(fileIndex = 0; fileIndex < 156800; fileIndex++){
        
        // read in a short
        fscanf(finalW1, "%hd", &readin); 

        // concatinate, shift, and build number for compressed values
        readin = readin & 0x000F;
        temp += (readin << (counter*4));

        // if 4 numbers are compressed
        if (counter == 0){
            
            // put number into sdram 
            ((short*)sdram_ptr)[W1_2BASE  + sdramIndex] = temp;

            // reset values for next number
            sdramIndex++;
            temp = 0;
            counter = 3;
        }     
        else{counter--;}
	}// for

	fclose(finalW1);
}// void readWeightsL1(void * sdram_ptr)

//****************************************************************************************** readImg
void readImg(void * sdram_ptr){
	FILE *images;
	int fileIndex = 0;
    short rounded = 0;
    short temp = 0;
    float readin = 0;
    int counter = 3;
    int sdramIndex = 0;
//*************************
	images = fopen("testData.txt", "r"); 

    // for 10,000 images, each 784 pixels
	for(fileIndex = 0; fileIndex < 7840000; fileIndex++){
      
        // read in a float
        fscanf(images, "%f", &(readin));

        // round, concatinate, shift, and build number for compressed values      
        readin += 0.5;
        rounded = (short)readin;
        rounded = rounded & 0x000F;
        temp += (rounded << (counter*4)); 

        if (counter == 0){
            // put number into sdram 
            ((short*)sdram_ptr)[IMG_BASE2 + sdramIndex] = temp;
            
            // reset values for next number
            rounded = 0;
            temp = 0;
            counter = 3;
            sdramIndex++;
        }     
        else{counter--;}
    }// for

    fclose(images);
}// void readImg(void * sdram_ptr)
//####################################################################################################### 
/*
    - uses fscanf to read from file and directly transfer short number to sdram
    - read-in file fxns below are not compressed        
*/
//****************************************************************************************** readBiasL1
void readBiasL1(void * sdram_ptr){
	FILE *finalB1;
	int index = 0;
//*************************
	finalB1 = fopen("finalB1L1rounded.txt", "r");
	for(index = 0; index < 200; index++)
        {fscanf(finalB1, "%hd", &( ((short*)sdram_ptr)[BIAS_BASE1 + index]) );}
	fclose(finalB1);
}// void readBiasL1(void * sdram_ptr)
//****************************************************************************************** readWeightsL2
void readWeightsL2(void * sdram_ptr){
	FILE *finalW2;
	int index = 0;
//*************************
	finalW2 = fopen("finalW1L2round_4compress.txt", "r");
	for(index = 0; index < 40000; index++)
        {fscanf(finalW2, "%hd", &( ((short*)sdram_ptr)[WEIGHT_BASE2 + index]) );}
	fclose(finalW2);
}// void readWeightsL2(void * sdram_ptr)
//****************************************************************************************** readBiasL2
void readBiasL2(void * sdram_ptr){
	FILE *finalB2;
	int index = 0;
//*************************
	finalB2 = fopen("finalB1L2rounded.txt", "r"); 
	for(index = 0; index < 200; index++)
        {fscanf(finalB2, "%hd", &( ((short*)sdram_ptr)[BIAS_BASE2 + index]) );}
	fclose(finalB2);
}// void readBiasL2(void * sdram_ptr)
//****************************************************************************************** readWeightsLF
void readWeightsLF(void * sdram_ptr){
	FILE *finalST;
	int index = 0;
//*************************
	finalST = fopen("finalSoftmaxThetaroundedTimes100.txt", "r");
	for(index = 0; index < 2000; index++)
        {fscanf(finalST, "%hd", &( ((short*)sdram_ptr)[WEIGHT_BASEF + index]) );}
	fclose(finalST);
}// void readWeightsLF(void * sdram_ptr)
//****************************************************************************************** readTestLabels
void readTestLabels(void * sdram_ptr){
	FILE *finalLabel;
	int index = 0;
//*************************
	finalLabel = fopen("testLabels.txt", "r");
	for(index = 0; index < 10000; index++)
        {fscanf(finalLabel, "%hd", &( ((short*)sdram_ptr)[TESTLABEL_BASE + index] ));}
	fclose(finalLabel);
}// void readTestLabels(void * sdram_ptr)
//########################################################################################## no compression
void readWeightsL1_orig(void * sdram_ptr){
	FILE *RW1;
	int index;
//*************************
	RW1 = fopen("finalW1L1rounded.txt", "r");
	for(index = 0; index < 156800; index++){
		fscanf(RW1, "%hd", &( ((short*)sdram_ptr)[W1_2BASE + index] ));
	}
	fclose(RW1);
}
//******************************************************************************************
void readImg_orig(void * sdram_ptr){
	FILE *Img;
	int index = 0;
    float readin = 0;
//*************************
	Img = fopen("testData.txt", "r");
	for(index = 0; index < 7840000; index++){
        fscanf(Img, "%f", &(readin));
        readin += 0.5;
        ((short*)sdram_ptr)[IMG_BASE2 + index] = (short)readin;
	}
	fclose(Img);
}
//########################################################################################################
//****************************************************************************************** pseudoSigmoid
short pseudoSigmoid(short value){
    if (value > 0)  {return 1;}   
    else            {return 0;}
}
//****************************************************************************************** sigmoid
float sigmoid (float value){
    return (1.0/ ( 1.0 + exp(-value) ));
}
//#######################################################################################################
//****************************************************************************************** lay1calc
void lay1calc (void * sdram_ptr, int * x, void * done_ptr, void * ready_ptr){
    int currNode;
    short ValL1, B, XW;
//*************************
    // run FPGA accelerator
    *((int *)ready_ptr) = 1;
    while(*((int *)done_ptr) == 0){}
    *((int *)ready_ptr) = 0;

    // for nodes of 1st layer, add bias, psuedoSigmoid, and store result into sdram
    for (currNode = 0; currNode < 200; currNode++){
        B = ((short*)sdram_ptr)[BIAS_BASE1 + currNode];
        XW =((short*)sdram_ptr)[XW_BASE1 + currNode]; 
        ValL1 = B + XW;
        ((short*)sdram_ptr)[LAY1_BASE + currNode] = pseudoSigmoid(ValL1);
    }// for currNode
    
    return;
}// void lay1calc (void * sdram_ptr, int * x, void * done_ptr, void * ready_ptr)
//****************************************************************************************** lay2calc
void lay2calc (void * sdram_ptr){
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
}// void lay2calc (void * sdram_ptr)
//****************************************************************************************** layFcalc
int layFcalc (void * sdram_ptr){
    int currNode, prevNode, maxIndex;
    short ValLF, X, W;
    float ValLF_f, ValMax,ValGot;
//*************************
    ValMax = 0;
    ValGot = 0;
    maxIndex = 0;
//*************************
    // for every node in the final layer
    for (currNode = 0; currNode < 10; currNode++){
        ValLF = 0;
        
        // for every node in the 2nd layer
        for(prevNode = 0; prevNode < 200; prevNode++){
            X = ((short*)sdram_ptr)[LAY2_BASE + prevNode];
            W = ((short*)sdram_ptr)[WEIGHT_BASEF + (200*currNode) + prevNode];
            ValLF +=  (X * W);
        }// for prevNode

        // prepare short for float sigmoid
        ValLF_f = (float)ValLF;
        ValLF_f = ValLF_f/100;

        // find probability for node at given index
        ValGot = sigmoid(ValLF_f);

        // compare probability to current max prob and replace if necessary        
        if (ValGot > ValMax){
          ValMax = ValGot;
          maxIndex = currNode + 1;
        }
    }// for currNode

    return maxIndex;
}// int layFcalc (void * sdram_ptr)
//****************************************************************************************** NNalgo
int NNalgo(void * sdram_ptr, int * x, void * done_ptr, void * ready_ptr){
    lay1calc(sdram_ptr, x,done_ptr,ready_ptr);
    lay2calc(sdram_ptr);
    return layFcalc(sdram_ptr);
}// int NNalgo(void * sdram_ptr, int * x, void * done_ptr, void * ready_ptr)
























