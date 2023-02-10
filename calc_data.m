function [y]=calc_data(input_data)
% clc;
% close all;
% clear all;
% clearvars;
% filename='04043m.mat';
% Ann_mat2=my_new_code(filename);
% load (filename);
% input=val(1,1:9205000);
% input_data=buffer(input(1,:),2500,500)';
 g1=1;
% s=0;
for s=1:size(input_data,1)

ecg1=input_data(s,:);

n1=10;
%% wavelet try1
% wname='db4';
% [LoD,HiD,LoR,HiR] = wfilters(wname); 
% [wpc10,wpc11] = dwt(ecg_filt,LoD,HiD);
% [wpc20,wpc21] = dwt(wpc10,LoD,HiD);
% [wpc30,wpc31] = dwt(wpc20,LoD,HiD);
% [wpc40,wpc41] = dwt(wpc30,LoD,HiD);
% [wpc50,wpc51] = dwt(wpc40,LoD,HiD);
% [wpc52,wpc53] = dwt(wpc41,LoD,HiD);
%  wpcnew1=wpc51(1,1:80);
%  wpcnew2=wpc52(1,1:80);
%  len1=length(wpcnew1);
%  len2=length(wpcnew2);
%  B51_n1=norm_mtx(wpcnew1,len1,n1);
%  B52_n1=norm_mtx(wpcnew2,len2,n1);



%% wavelet try 2
% cof=cwt(ecg_filt,5,'coif1');
% wpt=wpdec(cof,5,'db4');
% wpc1 = wpcoef(wpt,32);
% wpc2 = wpcoef(wpt,33);
% wpcnew1=wpc1(1,1:80);
% wpcnew2=wpc2(1,1:80);
% len1=length(wpcnew1);
% len2=length(wpcnew2);
% B51_n1=norm_mtx(wpcnew1,len1,n1);
% B52_n1=norm_mtx(wpcnew2,len2,n1);

%% wavelet try 3
% wname='db4';
% [LoD,HiD,LoR,HiR] = wfilters(wname);
% wpc10=waveletlow(ecg_filt,LoD);
% wpc20=waveletlow(wpc10,LoD);
% wpc30=waveletlow(wpc20,LoD);
% wpc40=waveletlow(wpc30,LoD);
% wpc41=wavelethigh(wpc30,HiD);
% wpc51=wavelethigh(wpc40,HiD);
% wpc52=waveletlow(wpc41,LoD);
% wpcnew1=wpc51(1,1:90);
% wpcnew2=wpc52(1,1:90);
% len1=length(wpcnew1);
% len2=length(wpcnew2);
% B51_n1=norm_mtx(wpc51,len1,n1);
% B52_n1=norm_mtx(wpc52,len2,n1); 

%% Wavelet try 4
wpt = wpdec(ecg1,5,'db4');
wpc1 = wpcoef(wpt,32);
wpc2 = wpcoef(wpt,33);
m1=floor(length(wpc1)/n1);
m2=floor(length(wpc2)/n1);
wpcnew1=wpc1(1,1:m1*n1);
wpcnew2=wpc2(1,1:m2*n1);
len1=length(wpcnew1);
len2=length(wpcnew2);
B51_n1=norm_mtx1(wpcnew1,len1,n1);
B52_n1=norm_mtx1(wpcnew2,len2,n1);

%% Normalization

B51_norm=B51_n1.*(B51_n1>0);
B52_norm=B52_n1.*(B52_n1>0);

% 
 %upper matrix
 a=0;
 for p=1:1:n1
     for q=p:n1
     a=a+1;
     B51_up(a,1)=B51_norm(p,q); 
     end
 end
 b=0;
 for p=1:1:n1
     for q=p:n1
      b=b+1;
      B52_up(b,1)=B52_norm(p,q);
     end
 end
 B51_up=round(B51_up,2);
 B52_up=round(B52_up,2);
 
%  figure;
%  histogram(B51_up(:),'BinWidth',0.005);
%  figure;
%  histogram(B52_up(:),'BinWidth',0.005);

%% Feature extraction Band51

B51_uniq = unique(B51_up);
B51_out = [B51_uniq,histc(B51_up(:),B51_uniq)];
% 
% 
WB51=0;
for k=1:1:length(B51_uniq)
WB51=(B51_out(k,1)*B51_out(k,2))+WB51;    
end

Ann_mat(g1,1)=WB51/sum(wpc1.^2);

HB51=0;
for k=1:1:length(B51_uniq)
    HB51=(1).*(B51_out(k,2)/length(B51_up))*log(B51_out(k,2)/length(B51_up))+HB51;
end

Ann_mat(g1,3)=(HB51/sum(wpc1.^2));%.*sum(ecg1(1,:).^2);
%% Feature extraction Band52

B52_uniq = unique(B52_up);
B52_out = [B52_uniq,histc(B52_up(:),B52_uniq)];

WB52=0;
for k=1:1:length(B52_uniq)
WB52=(B52_out(k,1)*B52_out(k,2))+WB52; 
end

Ann_mat(g1,2)=WB52/sum(wpc2.^2);

HB52=0;
for k=1:1:length(B52_uniq)
    HB52=(1).*(B52_out(k,2)/length(B52_up))*log(B52_out(k,2)/length(B52_up))+HB52;
end

Ann_mat(g1,4)=(HB52/sum(wpc2.^2));%.*sum(ecg1(1,:).^2);

feat=Ann_mat.*sum(ecg1(1,:).^2);

g1=g1+1;

end
data=log(abs(feat));

y=data;


