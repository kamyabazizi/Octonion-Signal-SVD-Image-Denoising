%svd PSNR
close all
clear all
clc
im=imread('fake_and_real_peppers_RGB.bmp');
%reading and converting the image
I1=imread('fake_and_real_peppers_ms_02.png');I2=imread('fake_and_real_peppers_ms_05.png');
I3=imread('fake_and_real_peppers_ms_07.png');I4=imread('fake_and_real_peppers_ms_12.png');
I5=imread('fake_and_real_peppers_ms_15.png');I6=imread('fake_and_real_peppers_ms_20.png');
I7=imread('fake_and_real_peppers_ms_28.png');
R=1.5*I7;G=0.5*I4+0.5*I5+0.5*I6;B=0.5*I1+0.5*I2+0.5*I3;
I=cat(3,R,G,B);

Temp= double(I) / 255;
v = var(Temp(:));
d=input('inter the variance=');
delta=(d/3900);
%delta=double(delta);
M1=double(imnoise(I1,'gaussian',0,delta));M2=double(imnoise(I2,'gaussian',0,delta));M3=double(imnoise(I3,'gaussian',0,delta));
M4=double(imnoise(I4,'gaussian',0,delta));M5=double(imnoise(I5,'gaussian',0,delta));M6=double(imnoise(I6,'gaussian',0,delta));
M7=double(imnoise(I7,'gaussian',0,delta));
N1=uint16(imnoise(I1,'gaussian',0,delta));N2=uint16(imnoise(I2,'gaussian',0,delta));N3=uint16(imnoise(I3,'gaussian',0,delta));
N4=uint16(imnoise(I4,'gaussian',0,delta));N5=uint16(imnoise(I5,'gaussian',0,delta));N6=uint16(imnoise(I6,'gaussian',0,delta));
N7=uint16(imnoise(I7,'gaussian',0,delta));
R1=1.5*N7;G1=0.5*N4+0.5*N5+0.5*N6;B1=0.5*N1+0.5*N2+0.5*N3;
H1=cat(3,(R1),(G1),(B1));
figure;imshow(uint16(I));
figure;imshow(uint16(H1));

%SVD with 10 number of singular value
N=10;
[U1,S1,V1]=svd(M1);[U2,S2,V2]=svd(M2);[U3,S3,V3]=svd(M3);[U4,S4,V4]=svd(M4);
[U5,S5,V5]=svd(M5);[U6,S6,V6]=svd(M6);[U7,S7,V7]=svd(M7);
% store the singular values in a temporary var
C1 = S1;C2 = S2;C3 = S3;C4 = S4;C5 = S5;C6 = S6;C7 = S7;
%discard the diagonal values not required for compression
C1(N+1:end,:)=0;C1(:,N+1:end)=0;C2(N+1:end,:)=0;C2(:,N+1:end)=0;
C3(N+1:end,:)=0;C3(:,N+1:end)=0;C4(N+1:end,:)=0;C4(:,N+1:end)=0;
C5(N+1:end,:)=0;C5(:,N+1:end)=0;C6(N+1:end,:)=0;C6(:,N+1:end)=0;
C7(N+1:end,:)=0;C7(:,N+1:end)=0;

% Construct an Image using the selected singular values
D1=U1*C1*V1';D2=U2*C2*V2';D3=U3*C3*V3';D4=U4*C4*V4';D5=U5*C5*V5';D6=U6*C6*V6';D7=U7*C7*V7';
R2=1.5*uint16(D7);G2=0.5*uint16(D4)+0.5*uint16(D5)+0.5*uint16(D6);B2=0.5*uint16(D1)+0.5*uint16(D2)+0.5*uint16(D3);
%FRD=[Z -D1 -D2 -D3 D4 D5 D6 D7;D1 Z -D3 D2 -D5 D4 D7 -D6;D2 D3 Z -D1 D6 -D7 D4 D5;D3 -D2 D1 Z -D7 D6 -D5 D4;D4 D5 D6 D7 Z -D1 -D2 -D3;D5 -D4 D7 -D6 D1 Z D3 -D2;D6 -D7 -D4 D5 D2 -D3 Z D1;D7 D6 -D5 -D4 D3 D2 -D1 Z];
H2=cat(3,uint16(R2),uint16(G2),uint16(B2));
%H2=uint16(H2)-uint16(TI);
figure;imshow(uint16(H2));

[peaksnr, snr] = psnr(uint16(H1), uint16(H2));
fprintf('\n The Peak-SNR value is %0.4f', peaksnr);