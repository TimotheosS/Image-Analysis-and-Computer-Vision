function[f] = gaussfft(pic, t)

sz1 = size(pic,1);
sz2 = size(pic,2);

f = fspecial('Gaussian',[sz1 sz2],t);

f_fourier = (fft2(f));
img_fourier = (fft2(pic));
    
final_fourier = (img_fourier .* f_fourier);

final = fftshift(ifft2(final_fourier));

f = final;
