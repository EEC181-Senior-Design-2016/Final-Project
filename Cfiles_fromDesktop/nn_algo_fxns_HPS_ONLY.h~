#ifndef NN_ALGO_FXNS_H_
#define NN_ALGO_FXNS_H_
//*******************************************
#define IMG_BASE        0
//*********************
#define WEIGHT_BASE1    49
#define XW_BASE1        39249
#define BIAS_BASE1      39449
#define LAY1_BASE       39649
//*********************
#define WEIGHT_BASE2    39849
#define BIAS_BASE2      79849
#define LAY2_BASE       80049
//*********************
#define WEIGHT_BASEF    80249
//****
#define IMG_BASE2       82249
#define W1_2BASE        7922249
#define TESTLABEL_BASE  8079049
//*********************
#define COMPRESS_W1 3
#define COMPRESS_PIX 15
// *******************************************
// ******************************************
void readWeightsL1(void * sdram_ptr);
void readBiasL1(void * sdram_ptr);
// ******************************************
void readWeightsL2(void * sdram_ptr);
void readBiasL2(void * sdram_ptr);
// ******************************************
void readWeightsLF(void * sdram_ptr);
// ******************************************
void readTestLabels(void * sdram_ptr);
void readImg(void * sdram_ptr);
// ******************************************
void readWeightsL1_orig(void * sdram_ptr);
void readImg_orig(void * sdram_ptr);
// ******************************************

short pseudoSigmoid(short value);
float sigmoid (float value);
void lay1calc (void * sdram_ptr, int * x, void * done_ptr, void * ready_ptr);
void lay2calc (void * sdram_ptr);
int layFcalc (void * sdram_ptr);

int NNalgo(void * sdram_ptr, int * x, void * done_ptr, void * ready_ptr);

#endif
