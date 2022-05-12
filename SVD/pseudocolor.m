close all
clear all
clc
%Original noisy pseudo color images (band 2, 5 and 7) a1&a2
X1=imread('flowers_ms_02.png');
X2=imread('flowers_ms_05.png');
X3=imread('flowers_ms_07.png');
X = cat(3, X1, X2, X3);
%add a gaussian noise to image
d=20;
delta=(d/2000);
Y = imnoise(X,'gaussian',0,delta);

figure
imshow(Y);
imwrite(Y, sprintf('a2.png'));
%end
%Original noisy pseudo color images (band 7, 12 and 15) h1&h2
M1=imread('flowers_ms_07.png');
M2=imread('flowers_ms_12.png');
M3=imread('flowers_ms_15.png');
M = cat(3, M1, M2, M3);
%add a gaussian noise to image
N = imnoise(M,'gaussian',0,delta);

figure
imshow(N);
imwrite(N, sprintf('h2.png'))
%end