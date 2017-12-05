function dM = get_dataMatrix( B, labelNum, SE )
    if nargin < 3
        mask_r = ceil(0.05*min(size(B,1),size(B,2)));
        SE = strel('disk',mask_r);
    end
    bias = getneighbors(SE);
    dM = 1 - cget_dataMatrix(B,labelNum,bias);
end

