%OSVDPSNR
close all
clear all
clc

%reading and converting the image
I1=imread('balloons_ms_02.png');I2=imread('balloons_ms_05.png');
I3=imread('balloons_ms_07.png');I4=imread('balloons_ms_12.png');
I5=imread('balloons_ms_15.png');I6=imread('balloons_ms_20.png');
I7=imread('balloons_ms_28.png');
Z=zeros(512);
IR=[Z -I1 -I2 -I3 I4 I5 I6 I7;I1 Z -I3 I2 -I5 I4 I7 -I6;I2 I3 Z -I1 I6 -I7 I4 I5;I3 -I2 I1 Z -I7 I6 -I5 I4;I4 I5 I6 I7 Z -I1 -I2 -I3;I5 -I4 I7 -I6 I1 Z I3 -I2;I6 -I7 -I4 I5 I2 -I3 Z I1;I7 I6 -I5 -I4 I3 I2 -I1 Z];

d=input('inter the noise variance:');
delta=(d/3900);
I1=imnoise(I1,'gaussian',0,delta);I2=imnoise(I2,'gaussian',0,delta);I3=imnoise(I3,'gaussian',0,delta);I4=imnoise(I4,'gaussian',0,delta);I5=imnoise(I5,'gaussian',0,delta);
I6=imnoise(I6,'gaussian',0,delta);I7=imnoise(I7,'gaussian',0,delta);
I1=double(I1);I2=double(I2);I3=double(I3);I4=double(I4);I5=double(I5);I6=double(I6);I7=double(I7);

FR=[Z -I1 -I2 -I3 I4 I5 I6 I7;I1 Z -I3 I2 -I5 I4 I7 -I6;I2 I3 Z -I1 I6 -I7 I4 I5;I3 -I2 I1 Z -I7 I6 -I5 I4;I4 I5 I6 I7 Z -I1 -I2 -I3;I5 -I4 I7 -I6 I1 Z I3 -I2;I6 -I7 -I4 I5 I2 -I3 Z I1;I7 I6 -I5 -I4 I3 I2 -I1 Z];

% number of singular values
N=10*8;

% decomposing the image using singular value decomposition
[U,S,V]=svd(FR);
% store the singular values in a temporary var
C = S;
%discard the diagonal values not required for compression
C(N+1:end,:)=0;C(:,N+1:end)=0;
% Construct an Image using the selected singular values
newFR=U*C*V';

[peaksnr, snr] = psnr(uint16(IR),uint16(newFR));
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);

