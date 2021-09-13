% DD2423
% Lab 2
% .m script for Exercise 6: Hough Transformations
% Author : Timotheos Souroulla
% ID : 950726-T510

clear all; close all; clc;

%% Question 8

testimage1 = triangle128;
smalltest1 = binsubsample(testimage1);
nlines_t = 6;

testimage2 = houghtest256;
smalltest2 = binsubsample(binsubsample(testimage2));
nlines_tr = 10;

tools = few256;
tools = binsubsample(binsubsample(tools));

phone = phonecalc256;
phone = binsubsample(binsubsample(phone));

house = godthem256;
% house = binsubsample(binsubsample(house));

%Declare input params to houghedgeline
thresh = 20;

nrho = 400;
ntheta = 360;
verbose = 0;
increment = ones(nrho,ntheta);

%Call houghedgeline
[linepar0, acc0] = houghedgeline(smalltest1, 3, thresh, nrho, ntheta, nlines_t, verbose,increment);
[linepar1, acc1] = houghedgeline(testimage2, 3, thresh, nrho, ntheta, nlines_tr, verbose,increment);
[linepar2, acc2] = houghedgeline(tools, 2, thresh, nrho, ntheta, 20, verbose,increment);
[linepar3, acc3] = houghedgeline(phone, 3, thresh, nrho, ntheta, 17, verbose,increment);
[linepar4, acc4] = houghedgeline(house, 12, 20, nrho, ntheta, 15, verbose,increment);

%% Question 9

house = godthem256;

thresh = 20;
scale = 12;

nlines = 15;
verbose = 0;

% Same Theta and Distance

tic
no_rho = 360;
no_theta = 360;

increment = ones(no_rho,no_theta);

[linepar, acc] = houghedgeline(house, scale, thresh, no_rho, no_theta, nlines, verbose,increment);
disp('Same Theta and Distance')
toc

% High Distande low Theta

tic

no_rho = 1000;
no_theta = 300;
increment = ones(no_rho,no_theta);
[linepar, acc] = houghedgeline(house, scale, thresh, no_rho, no_theta, nlines, verbose,increment);

disp('Low Theta and High Distance')
toc

% Low Distance high Theta

tic
no_rho = 300;
no_theta = 1000;
increment = ones(no_rho,no_theta);
[linepar, acc] = houghedgeline(house, scale, thresh, no_rho, no_theta, nlines, verbose,increment);

disp('High Theta and Low Distance')
toc

%% Question 10

tools = few256;

dy = [1 2 1;0 0 0;-1 -2 -1];
dx = dy'; 

dxtools = conv2(tools,dx,'valid');
dytools = conv2(tools,dy,'valid');

gradmagntools = sqrt(dxtools.^2 + dytools.^2);

% moFun(:,:) = (log(gradmagntools).^2);  % The monotonically increasing function
moFun(:,:) = exp(gradmagntools);

thresh = 20;

nrho =254;
ntheta = 254;
verbose = 0;

[linepar, acc] = houghedgeline(tools, 2, thresh, nrho, ntheta, 20, verbose,moFun);
