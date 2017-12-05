%% map image I (0-1) to Id (1-num), or inverse
function Id = get_scaleDown( I, num, inverse )
    if nargin<3
        inverse = 0;
    end
    if nargin<2
        num = 32;
    end
    I = im2double(I);
    if inverse == 0
        Id = round((num-1)*I)+1;    
    else
        Id = (I-1)/(num-1); 
    end
end

