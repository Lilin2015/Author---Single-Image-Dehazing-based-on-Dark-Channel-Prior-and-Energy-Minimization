function [ J ] = dehaze( I, T, A)  
    A_rep = repmat(reshape(A,[1,1,3]),size(I,1),size(I,2));
    J = ( I - A_rep )./repmat(T,[1,1,size(I,3)])+A_rep;
end

