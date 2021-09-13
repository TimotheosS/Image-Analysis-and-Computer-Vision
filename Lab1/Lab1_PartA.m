% DD2423
% Lab 1
% .m script for Exercise 1: Fourier Transforms
% Author : Timotheos Souroulla
% ID : 950726-T510

clear all; clc; close all;

%% Fourier Part (Questions 1-6)

p = [5,9,17,17,5,125,5,1];
q = [9,5,9,121,1,1,1,5];
sz = 128;

for i = 1:size(p,2)
    fftwave(p(i),q(i),sz);
end


%% Linearity (Questions 7-9)

F = [ zeros(56, 128); ones(16, 128); zeros(56, 128)];
G = F';
H = F + 2 * G;

Fhat = fft2(F);
Ghat = fft2(G);
Hhat = fft2(H);

figure()
subplot(4,2,1)
showgrey(F)
title('F')

subplot(4,2,3)
showgrey(G);
title('G')

subplot(4,2,5)
showgrey(H);
title('H')

subplot(4,2,2)
showgrey(log(1 + abs(Fhat)))
title('Power spectra of F')

subplot(4,2,4)
showgrey(log(1 + abs(Ghat)))
title('Power spectra of G')

subplot(4,2,6)
showgrey(log(1 +abs(Hhat)))
title('Power spectra of H')

subplot(4,1,4)
showgrey(log(1 + abs(fftshift(Hhat))))
title('Shifted Power spectra of H')


%% Multiplication (Question 10)

F = [ zeros(56, 128); ones(16, 128); zeros(56, 128)];
G = F';

figure();
subplot(2,1,1)
showgrey(F .* G);
title('F * G')

subplot(2,1,2)
showfs(fft2(F .* G));
title('Spectrum of F * G')


%% Scaling (Question 11)

F = [zeros(60, 128); ones(8, 128); zeros(60, 128)] .* [zeros(128, 48) ones(128, 32) zeros(128, 48)];

figure();
subplot(2,1,1);
showgrey(F);
title('F')

subplot(2,1,2);
showfs(fft2(F))
title('Spectrum of F')

%% Rotation (Question 12)

alpha = [30,60];

F = [zeros(60, 128); ones(8, 128); zeros(60, 128)] .* [zeros(128, 48) ones(128, 32) zeros(128, 48)];

for i = 1:size(alpha,2)
    G = rot(F, alpha(i));

    figure();
    subplot(2,2,1);
    showgrey(F);
    title('F')

    subplot(2,2,2)
    showgrey(G)
    title(sprintf('G, rotated by %d',alpha(i)))

    Ghat = fft2(G);
    Hhat = rot(fftshift(Ghat),-alpha(i));

    subplot(2,2,3);
    showgrey(log(1 + abs(Hhat)))
    title('Spectrum of F')

    subplot(2,2,4);
    showfs(Ghat)
    title('Spectrum of G')
end

%% Fourier Phase and Magnitude (Question 13)

img = phonecalc128;
img1 = few128;
img2 = nallo128;

thresh = [0.100 0.3 1.0 10.0 100.0];

for i = 1:size(thresh,2)
    figure('Name',sprintf('Threshold level: %f',thresh(i)))
    subplot(3,2,1)
    showgrey(pow2image(img,thresh(i)))
    title('phonecalc128')

    subplot(3,2,3)
    showgrey(pow2image(img1,thresh(i)))
    title('few128')

    subplot(3,2,5)
    showgrey(pow2image(img2,thresh(i)))
    title('nallo128')

    subplot(3,2,2)
    showgrey(randphaseimage(img))
    title('phonecalc128-Phase')

    subplot(3,2,4)
    showgrey(randphaseimage(img1))
    title('few128-Phase')

    subplot(3,2,6)
    showgrey(randphaseimage(img2))
    title('nallo128-Phase')
end



