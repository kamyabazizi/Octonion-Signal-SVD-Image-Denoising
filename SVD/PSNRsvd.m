clear all;clc;
imdata = imread('a2.png');
ref = rgb2gray(imdata);
imcomp = imread('d2.png');
refcomp = rgb2gray(imcomp);
[peaksnr, snr] = psnr(ref, refcomp);
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);