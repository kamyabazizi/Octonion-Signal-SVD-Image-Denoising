close all
clear all
clc

%reading and converting the image
I1=(imread('flowers_ms_02.png'));I2=(imread('flowers_ms_05.png'));I3=(imread('flowers_ms_07.png'));
M1=(imread('flowers_ms_07.png'));M2=(imread('flowers_ms_12.png'));M3=(imread('flowers_ms_15.png'));

d=20;
delta=(d/2000);
I1=imnoise(I1,'gaussian',0,delta);I2=imnoise(I2,'gaussian',0,delta);I3=imnoise(I3,'gaussian',0,delta);%I4=imnoise(I4,'gaussian');I5=imnoise(I5,'gaussian');I6=imnoise(I6,'gaussian');I7=imnoise(I7,'gaussian');
I1=double(I1);I2=double(I2);I3=double(I3);%I4=double(I4);I5=double(I5);I6=double(I6);I7=double(I7);

M1=imnoise(M1,'gaussian',0,delta);M2=imnoise(M2,'gaussian',0,delta);M3=imnoise(M3,'gaussian',0,delta);%I4=imnoise(I4,'gaussian');I5=imnoise(I5,'gaussian');I6=imnoise(I6,'gaussian');I7=imnoise(I7,'gaussian');
M1=double(M1);M2=double(M2);M3=double(M3);%I4=double(I4);I5=double(I5);I6=double(I6);I7=double(I7);


Z=zeros(512);
FRI=[Z -I1 -I2 -I3 Z Z Z Z;I1 Z -I3 I2 Z Z Z Z;I2 I3 Z -I1 Z Z Z Z;I3 -I2 I1 Z Z Z Z Z;Z Z Z Z Z -I1 -I2 -I3;Z Z Z Z I1 Z I3 -I2;Z Z Z Z I2 -I3 Z I1;Z Z Z Z I3 I2 -I1 Z];

FRM=[Z -M1 -M2 -M3 Z Z Z Z;M1 Z -M3 M2 Z Z Z Z;M2 M3 Z -M1 Z Z Z Z;M3 -M2 M1 Z Z Z Z Z;Z Z Z Z Z -M1 -M2 -M3;Z Z Z Z M1 Z M3 -M2;Z Z Z Z M2 -M3 Z M1;Z Z Z Z M3 M2 -M1 Z];

% number of singular values
N1=2*8;N2=5*8;N3=10*8;N4=15*8;N5=20*8;N6=200*8;
% decomposing the image using singular value decomposition
[UI,SI,VI]=svd(FRI);
[UM,SM,VM]=svd(FRM);
% store the singular values in a temporary var
C1 = SI;C2 = SI;C3 = SI;C4 = SI;C5 = SI;C6 = SI;
L1 = SM;L2 = SM;L3 = SM;L4 = SM;L5 = SM;L6 = SM;
%discard the diagonal values not required for compression
C1(N1+1:end,:)=0;C1(:,N1+1:end)=0;C2(N2+1:end,:)=0;C2(:,N2+1:end)=0;
C3(N3+1:end,:)=0;C3(:,N3+1:end)=0;C4(N4+1:end,:)=0;C4(:,N4+1:end)=0;
C5(N5+1:end,:)=0;C5(:,N5+1:end)=0;C6(N6+1:end,:)=0;C6(:,N6+1:end)=0;

L1(N1+1:end,:)=0;L1(:,N1+1:end)=0;L2(N2+1:end,:)=0;L2(:,N2+1:end)=0;
L3(N3+1:end,:)=0;L3(:,N3+1:end)=0;L4(N4+1:end,:)=0;L4(:,N4+1:end)=0;
L5(N5+1:end,:)=0;L5(:,N5+1:end)=0;L6(N6+1:end,:)=0;L6(:,N6+1:end)=0;
% Construct an Image using the selected singular values
newFRI1=UI*C1*VI';newFRI2=UI*C2*VI';newFRI3=UI*C3*VI';newFRI4=UI*C4*VI';newFRI5=UI*C5*VI';newFRI6=UI*C6*VI';
newFRM1=UM*L1*VM';newFRM2=UM*L2*VM';newFRM3=UM*L3*VM';newFRM4=UM*L4*VM';newFRM5=UM*L5*VM';newFRM6=UM*L6*VM';

RI1=-newFRI1(1:512,513:1025);GI1=-newFRI1(1:512,1026:1538);BI1=-newFRI1(1:512,1539:2051);HI1=cat(3,RI1,GI1,BI1);
RI2=-newFRI2(1:512,513:1025);GI2=-newFRI2(1:512,1026:1538);BI2=-newFRI2(1:512,1539:2051);HI2=cat(3,RI2,GI2,BI2);
RI3=-newFRI3(1:512,513:1025);GI3=-newFRI3(1:512,1026:1538);BI3=-newFRI3(1:512,1539:2051);HI3=cat(3,RI3,GI3,BI3);
RI4=-newFRI4(1:512,513:1025);GI4=-newFRI4(1:512,1026:1538);BI4=-newFRI4(1:512,1539:2051);HI4=cat(3,RI4,GI4,BI4);
RI5=-newFRI5(1:512,513:1025);GI5=-newFRI5(1:512,1026:1538);BI5=-newFRI5(1:512,1539:2051);HI5=cat(3,RI5,GI5,BI5);
RI6=-newFRI6(1:512,513:1025);GI6=-newFRI6(1:512,1026:1538);BI6=-newFRI6(1:512,1539:2051);HI6=cat(3,RI6,GI6,BI6);

RM1=-newFRM1(1:512,513:1025);GM1=-newFRM1(1:512,1026:1538);BM1=-newFRM1(1:512,1539:2051);HM1=cat(3,RM1,GM1,BM1);
RM2=-newFRM2(1:512,513:1025);GM2=-newFRM2(1:512,1026:1538);BM2=-newFRM2(1:512,1539:2051);HM2=cat(3,RM2,GM2,BM2);
RM3=-newFRM3(1:512,513:1025);GM3=-newFRM3(1:512,1026:1538);BM3=-newFRM3(1:512,1539:2051);HM3=cat(3,RM3,GM3,BM3);
RM4=-newFRM4(1:512,513:1025);GM4=-newFRM4(1:512,1026:1538);BM4=-newFRM4(1:512,1539:2051);HM4=cat(3,RM4,GM4,BM4);
RM5=-newFRM5(1:512,513:1025);GM5=-newFRM5(1:512,1026:1538);BM5=-newFRM5(1:512,1539:2051);HM5=cat(3,RM5,GM5,BM5);
RM6=-newFRM6(1:512,513:1025);GM6=-newFRM6(1:512,1026:1538);BM6=-newFRM6(1:512,1539:2051);HM6=cat(3,RM6,GM6,BM6);

imwrite(uint16(HI1), sprintf('b1.png'));imwrite(uint16(HI2), sprintf('c1.png'));imwrite(uint16(HI3), sprintf('d1.png'));
imwrite(uint16(HI4), sprintf('e1.png'));imwrite(uint16(HI5), sprintf('f1.png'));imwrite(uint16(HI6), sprintf('g1.png'));

imwrite(uint16(HM1), sprintf('i1.png'));imwrite(uint16(HM2), sprintf('j1.png'));imwrite(uint16(HM3), sprintf('k1.png'));
imwrite(uint16(HM4), sprintf('l1.png'));imwrite(uint16(HM5), sprintf('m1.png'));imwrite(uint16(HM6), sprintf('n1.png'));
