% This is the main file for data preparation 
% data_train is the matrix consisting features
% target1 is the matrix consisting targets


clc;
close all;
clear all;
clearvars;

%% for data preparation 
% Read the data
load('N_AF_Exp_data_180_seg_10_second.mat');

% Use function 
Ann_mat_AF=calc_data(AF_seg);
Ann_mat_N=calc_data(N_seg);

data_train=[Ann_mat_N;Ann_mat_AF];
target1=[zeros(size(Ann_mat_AF,1),1),ones(size(Ann_mat_AF,1),1);ones(size(Ann_mat_AF,1),1),zeros(size(Ann_mat_AF,1),1)];

%% For Kruskalwallis test
% for i=1:size(Ann_mat_AF,1)
%   Ann_krw(i,1)=Ann_mat_AF(i,1);
%   Ann_krw(i,2)=Ann_mat_N(i,1);
% 
% 
% end
% boxplot(Ann_krw,'labels',{'AF','NSR'})
% title('HB in Band 51')
