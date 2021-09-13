% DD2423
% Lab 1
% .m script for Exercise 2: Gaussian Smoothing Filters
% Author : Timotheos Souroulla
% ID : 950726-T510

clear all; clc; close all;

%% Spatial discretization and spatial convolution:

sz = 5;
s = [0.1 0.3 1.0 10.0 100.0];
img = phonecalc256;

figure('Name','Convolution in Spatial Domain');
subplot(2,3,1)
showgrey(img)
title('Original Image')


for i = 1:size(s,2)
    f = fspecial('Gaussian',[sz sz],s(i));
    final = conv2(img,f);
    
    subplot(2,3,i + 1)
    showgrey(final)
    title(sprintf('Variance: %f',s(i)))
end

%% Spatial discretization and convolution via FFT


s = [0.1 0.3 1.0 10.0 100.0];
img = phonecalc128;
sz1 = size(image,1);

figure('Name','Multiplication in Fourier Domain');
subplot(2,3,1)
showgrey(img)
title('Original image')
    
for i = 1:size(s,2)
    f = fspecial('Gaussian',[sz1 sz1],s(i));
   
    final = gaussfft(img,s(i)); 
    
    psf = gaussfft(deltafcn(128,128), s(i));
    v = variance(psf)
    
    subplot(2,3,i + 1)
    showgrey((final))
    title(sprintf('Variance: %f',s(i)))
    
end