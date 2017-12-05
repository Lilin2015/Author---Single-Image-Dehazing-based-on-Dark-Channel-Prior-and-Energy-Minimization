#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "mex.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	// input
    double* pB = mxGetPr(prhs[0]);
    int scale = mxGetScalar(prhs[1]);
    double* pBias = mxGetPr(prhs[2]);
    // input size
    int m  = mxGetM(prhs[0]);
    int n  = mxGetN(prhs[0]);
    int b  = mxGetM(prhs[2]);
    // output
    int num = m*n;
    mwSize dims[2] = { scale, num };
    plhs[0] = mxCreateNumericArray(2, dims, mxDOUBLE_CLASS, mxREAL);
    double* pM = mxGetPr(plhs[0]);
    
    // calc
    for(int im=0;im<m;++im)
    {
        for(int in=0;in<n;++in)
        {
            int pixel_idx = in*m+im;
            int pixel_ub = pB[im+in*m];
            for(int ib=0;ib<b;++ib)
            {
                int bias_m = im+pBias[ib];
                int bias_n = in+pBias[ib+b];
                if(bias_m>0&&bias_m<m&&bias_n>0&&bias_n<n)
                {
                    int label_idx = pB[bias_m+bias_n*m];
                    if(label_idx<=pixel_ub)
                        pM[pixel_idx*scale+label_idx-1] = 1;
                }
            }//bias loop
        }// column loop
    }//row loop
    
}
