clear all
close all

fid = fopen('DecTreeBE700_human_si3.txt');
s = textscan(fid, '%s');
fclose(fid);

str = s{:};

[ii,jj,kk] = unique(str);
freq = hist(kk, (1:numel(jj))')';
out = [ii num2cell(freq)];
% 
% for i = 1:length(ii)
%     