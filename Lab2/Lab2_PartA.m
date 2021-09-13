% DD2423
% Lab 2
% .m script for Exercise 1-2: Difference Operators
% Author : Timotheos Souroulla
% ID : 950726-T510

clear all; close all; clc;

%% Question 1

img = few256;

dy = [1 2 1;0 0 0;-1 -2 -1];
dx = dy'; 

dxtools = conv2(img,dx,'valid');
dytools = conv2(img,dy,'valid');

figure()
subplot(1,3,1)
showgrey(img)
title('Original Image')

subplot(1,3,2)
showgrey(dxtools)
title('Dx Operation')

subplot(1,3,3)
showgrey(dytools)
title('Dy operation')

%% Questions 2-3
% Thresholding on few 256
% 60 for thresholding looks great

img = few256;

gradmagntools = sqrt(dxtools.^2 + dytools.^2);

threshold = 10;

figure()
subplot(2,4,1)
showgrey(img)
title('Original Image')

for i = 1:7
    subplot(2,4,i+1)
    showgrey((gradmagntools - threshold) > 0)
    title(sprintf('Threshold = %d',threshold))
    threshold = threshold + 10;
end

%% Thresholding for godthem256
% 10 for thresholding looks great

image = godthem256;
img = discgaussfft(image,0.5);
threshold = 10;
figure()
subplot(2,4,1)
showgrey(img)
title('Original Image')

for i = 1:7
    
    thresh = sqrt(Lv(img,'valid'));

    subplot(2,4,i + 1)
    showgrey((thresh - threshold) > 0)
    title(sprintf('Threshold = %d',threshold))
    threshold = threshold + 10;
    
end