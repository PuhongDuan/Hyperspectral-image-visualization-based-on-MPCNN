clear
clc
close all
%% load original image
load PaviaU.mat % change your data
img=double(img);
%% Visible bands that can be set automatically
a1=49;a2=65;% Red wavelength range
b1=24;b2=42;% Green wavelength range
c1=6;c2=21; % Blue wavelength range
%% MPCNN Visualization
[result,source]=MPCNN_VIS(img,a1,a2,b1,b2,c1,c2);
figure;imshow(source)
title('Original image')
figure;imshow(result)
title('Visualization result')