function [ label ] = alphaExpansion( I, label_num )

    %% prepare
    I = im2double(I);
    [m,n,~] = size(I);
    pixel_num = m*n;
    big_num = 100000;
    
    %% form data cost matrix
    B = get_scaleDown(get_dx(I,1),label_num);
    Matrix_DataCost = get_dataMatrix(B,label_num,strel('disk',25));
    %% form smooth cost matrix
    Matrix_SmoothCost = zeros([label_num,label_num]);
    for i = 1 : label_num - 1
        Matrix_SmoothCost = Matrix_SmoothCost + diag(repmat(i,[1,i]),label_num-i);
    end
    Matrix_SmoothCost = Matrix_SmoothCost + Matrix_SmoothCost';
    Matrix_SmoothCost = Matrix_SmoothCost + diag(repmat(label_num,[1,label_num]),0);
    Matrix_SmoothCost = label_num - Matrix_SmoothCost;
    
    %% form weight matrix
    Matrix_Neighbors = get_neighborsMatrix_Space(get_dx(I,1),big_num);
    %% alpha-expansion
    h = GCO_Create(pixel_num,label_num);
    GCO_SetDataCost(h,int32(100*big_num*Matrix_DataCost));
    GCO_SetSmoothCost(h,int32(Matrix_SmoothCost));
    GCO_SetNeighbors(h,round(100000*Matrix_Neighbors./max(max(Matrix_Neighbors))));
    t1=clock;
    GCO_Expansion(h);
    t2=clock;
    fprintf('Graph cut takes %0.2f seconds (set-up time is not included)\n',etime(t2,t1));
    label = GCO_GetLabeling(h);
    label = double(reshape(label,[m,n]));
%     [~, D, ~] =GCO_ComputeEnergy(h);
    GCO_Delete(h); 

%     if D~=0
%          error('\n error occur! data term is violated!\n pls check the weight of data term and smoothness term');
%     end

end

