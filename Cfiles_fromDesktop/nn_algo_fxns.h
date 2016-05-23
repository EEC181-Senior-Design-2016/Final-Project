#ifndef NN_ALGO_FXNS_H_
#define NN_ALGO_FXNS_H_
//*******************************************
#define LAY1_COMPR_BASE        0 // will be in use for 50 compressed values (200 / 4)
//*********************
#define XW_BASE2        50   // will be used for 200 values (expected 200 values from here for bias addition)
#define XW_BASE1        39249 // in use (all)
#define BIAS_BASE1      39449 // in use (all)
#define LAY1_BASE       39649 // in use (all)
//*********************
#define WEIGHT_BASE2    39849 // will be used with compression (40000)
#define BIAS_BASE2      79849 // in use (all)
#define LAY2_BASE       80049 // in use (all)
//*********************
#define WEIGHT_BASEF    80249 // in use (all)
//****
#define IMG_BASE2       82249 // in use (196000)
#define W1_2BASE        7922249 // in use (39200)
#define TESTLABEL_BASE  8079049 // in use (all)
//*********************
// 200 in layer 1 -> compress by 4 -> 50
// 200 output from FPGA in XW for layer 2
// = 250 new indices
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

void lay1compress (void *sdram_ptr);
void lay2calc (void * sdram_ptr, void * done_ptr, void * ready_ptr);

int layFcalc (void * sdram_ptr);

int NNalgo(void * sdram_ptr, int * x, void * done_ptr, void * ready_ptr, void * done_ptr2, void * ready_ptr2);

#endif
