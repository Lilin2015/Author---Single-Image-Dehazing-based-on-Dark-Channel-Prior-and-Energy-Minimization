clear
close all

%% file
path(path,strcat(pwd,'\Tools GCO\matlab')); 
path(path,strcat(pwd,'\functions - graphcut'));
% <----- the pack of graph cut algorithm.
% <----- if you want to apply the package or our code, plz read "GCO_README.TXT"

%% input
imName = '2.bmp';        % <---- your image name
I = im2double(imread(imName));
I = imresize(I,[480 640]);I(I>1)=1;I(I<0)=0;
%% dehaze
[J, T, A, Cache] = EnergyMinimization(I); % <--- if you are trying to check
% our results on dataset, give the GT atomospheric color [1,1,1] as the second param.

%% display
figure;imshow(I);
figure;imshow(T);colormap(jet);axis off;
figure;imshow(J);