% put hazy images into the file "haze image"
% run this script
% check results in the file "results"
clear
close all

%% prepare
path(path,strcat(pwd,'\Tools GCO\matlab')); 
path(path,strcat(pwd,'\functions - graphcut'));
path(path,strcat(pwd,'\haze image'))           
loadfile = dir(strcat(pwd,'\haze image'));     
savefile = strcat(pwd,'\results');        
image_num = length(loadfile);

%% process
for i = 1:image_num
    fileName = loadfile(i).name;
    [~,name,suffix] = fileparts(fileName);
    if strcmpi(suffix,'.jpg') || strcmpi(suffix,'.bmp') || strcmpi(suffix,'.png')
        
        % dehaze
        I = im2double(imread(fileName));
        I = imresize(I,[480 640]);
        fprintf([fileName,'\n']);
        
        [J, T, A, Cache] = EnergyMinimization(I); %<---- if you are trying to check
        % our results on dataset, give the GT atomospheric color [1,1,1].
        
        % save
        imwrite(J,[savefile,'\',name,'_J_our.bmp']);
        imwrite(ind2rgb(gray2ind(T,255),jet(255)),[savefile,'\',name,'_T_our.bmp']);
    end
end