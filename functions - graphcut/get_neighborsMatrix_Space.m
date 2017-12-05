% 4-connected
function nM_space = get_neighborsMatrix_Space( B, big_num )
    if nargin<2
        big_num = 100000;
    end
    pixel_num = size(B,1)*size(B,2);
    nMSpaceVectors = cget_spaceEuDis(B);
    nMSpaceVectors(~any(nMSpaceVectors,2),:) = [];
    similarity = 1./nMSpaceVectors(:,3);
    similarity(similarity>big_num)=big_num;
    fullV = [nMSpaceVectors(:,1:2),similarity;pixel_num,pixel_num,0];
    nM_space = sparse(fullV(:,1),fullV(:,2),fullV(:,3));
end

