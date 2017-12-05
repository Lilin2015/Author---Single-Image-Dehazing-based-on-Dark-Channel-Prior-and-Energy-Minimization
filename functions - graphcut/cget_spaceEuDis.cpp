#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "mex.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	// input
    double* pB = mxGetPr(prhs[0]);
    // input size
    int m  = mxGetM(prhs[0]);
    int n  = mxGetN(prhs[0]);
    // output
    int num = 4*m*n;
    mwSize dims[2] = { num, 3 };
    plhs[0] = mxCreateNumericArray(2, dims, mxDOUBLE_CLASS, mxREAL);
    double* pV = mxGetPr(plhs[0]);
    
    // calc
    int pointer = 0;
    int num2 = 2*num;
    for(int im=0;im<m;++im)
    {
        for(int in=0;in<n;++in)
        {
            int pixel_idx = in*m+im;
            int pi_down = in*m+im+1;
            int pi_right = (in+1)*m+im;
            int pi_bottomright = (in+1)*m+im+1;
            if(im<m-1)
            {
                pV[pointer] = pixel_idx+1;
                pV[pointer+num] = pi_down+1;
                pV[pointer+num2] = pow(pB[pixel_idx] - pB[pi_down],2);
                ++pointer;
            }
            if(in<n-1)
            {
                pV[pointer] = pixel_idx+1;
                pV[pointer+num] = pi_right+1;
                pV[pointer+num2] = pow(pB[pixel_idx] - pB[pi_right],2);
                ++pointer;
            }
        }// column loop
    }//row loop
}
