% DD2423
% Lab 1
% .m script for Exercise 3: Smoothing
% Author : Timotheos Souroulla
% ID : 950726-T510

clear all; clc; close all;

%% Smoothing of noisy data (Questions 17 & 18)

office = office256;

add = gaussnoise(office, 16);
sap = sapnoise(office, 0.1, 255);

figure();
subplot(1,3,1)
showgrey(office256)
title('Original Image')

subplot(1,3,2)
showgrey(add)
title('Gaussian Noise')

subplot(1,3,3)
showgrey(sap)
title('Salt and pepper')
%%
add_smoothed = discgaussfft(add,4);

figure
subplot(1,2,1)
showgrey(add_smoothed)
title('Smoothed Gaussian noise')

subplot(1,2,2)
showgrey(add)
title('Gaussian Noise')

%%
sap_restored = medfilt(sap,5);

figure()
subplot(1,2,1)
showgrey(sap_restored)
title('Restored Image')

subplot(1,2,2)
showgrey(sap)
title('Salt and Pepper noise')
%%

id_restored = ideal(add,1/6,'l');

figure('Name',sprintf('%d',i))
subplot(1,2,1)
showgrey(id_restored)
title('Restored Image')

subplot(1,2,2)
showgrey(add)
title('Gaussian Noise')

%% Smoothing and Subsampling (Questions 19 & 20)

img = phonecalc256;
smoothimg = img;

img1 = phonecalc256;
N=5;
figure

for i=1:N
    if i>1 % generate subsampled versions
        img = rawsubsample(img);
        v = 128/var(img(:))
%         smoothimg = gaussfft(img,v);
        smoothimg = ideal(img,var(img(:))); %discgaussfft(img,1/var(img(:)));% <call_your_filter_here>(smoothimg, <params>);
        smoothimg = rawsubsample(smoothimg);
    end

    subplot(2, N, i)
    showgrey(img)
    title(sprintf('Subsampled %d',i))

    subplot(2, N, i+N)
    showgrey(smoothimg)    
    title(sprintf('Low-Pass filter'))
end



