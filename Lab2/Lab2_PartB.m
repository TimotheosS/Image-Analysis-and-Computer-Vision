% DD2423
% Lab 2
% .m script for Exercise 3-5: Difference Operators and extraction of Edges
% Author : Timotheos Souroulla
% ID : 950726-T510

clear all; close all; clc;

%% Questions 4-6
house = godthem256;

scale = [0.0001 1 4 16 64];

figure();
subplot(2,3,1)
showgrey(house)
title('Original Image')


for i=1:size(scale,2)
    subplot(2,3,i+1)
    contour(Lvv(discgaussfft(house, scale(i)), 'same'), [0 0])
    axis('image')
    axis('ij')
    title(sprintf('Scale: %f',scale(i)));
end

tools = few256;

figure();
subplot(2,3,1)
showgrey(tools)
title('Original Image')

for i=1:size(scale,2)
    subplot(2,3,i+1)
    showgrey(Lvvv(discgaussfft(tools, scale(i)), 'same') < 0)
    title(sprintf('Scale: %f',scale(i)));
end

%% Question 7

house = godthem256;
tools = few256;

scale = 4.0;
thresh = [20 30];

    for j = 1:size(thresh,2)
       house_curves = extractedge(house,scale,thresh(j),'same');
       tools_curves = extractedge(tools,scale,thresh(j),'same');

       figure();
       subplot(1,2,1)
       overlaycurves(house, house_curves)
       title(sprintf('Threshold: %d',thresh(j)))

       subplot(1,2,2)
       overlaycurves(tools, tools_curves)
       title(sprintf('Scale: %d',scale))
    end
