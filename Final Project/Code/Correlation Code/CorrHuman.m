clear all 
close all


% data = textread('HumanDatawithPheno_nolabels.csv');

% A = table2array(data);
tic

load('humandatawithphenonolabel.mat');
load('humandatagenelist.mat');


diabdata = HumanDatawithPhenonolabels';

diabdata(:,54685) = log(diabdata(:,54685));
for i = 1:54675
    diabdata(:,i) = log2(diabdata(:,i));
end


% gender
for i = 1:54686
    [rho, pval] = corr(diabdata(:, i), diabdata(:,54676), 'Type', 'Pearson');
    rho_tot(i) = rho;
    pval_tot(i) = pval;
end
% age
for i = 1:54686
    [rho, pval] = corr(diabdata(:, i), diabdata(:,54677), 'Type', 'Pearson');
    rho_tot1(i) = rho;
    pval_tot1(i) = pval;
end
% FH
for i = 1:54686
    [rho, pval] = corr(diabdata(:, i), diabdata(:,54678), 'Type', 'Pearson');
    rho_tot2(i) = rho;
    pval_tot2(i) = pval;
end
% BMI
for i = 1:54686
    [rho, pval] = corr(diabdata(:, i), diabdata(:,54679), 'Type', 'Pearson');
    rho_tot3(i) = rho;
    pval_tot3(i) = pval;
end
% Fast gluc
for i = 1:54686
    [rho, pval] = corr(diabdata(:, i), diabdata(:,54680), 'Type', 'Pearson');
    rho_tot4(i) = rho;
    pval_tot4(i) = pval;
end
% 2hour gluc
for i = 1:54686
    [rho, pval] = corr(diabdata(:, i), diabdata(:,54681), 'Type', 'Pearson');
    rho_tot5(i) = rho;
    pval_tot5(i) = pval;
end
% hemo a1c
for i = 1:54686
    [rho, pval] = corr(diabdata(:, i), diabdata(:,54682), 'Type', 'Pearson');
    rho_tot6(i) = rho;
    pval_tot6(i) = pval;
end
% fast gluc (iv0gavg)
for i = 1:54686
    [rho, pval] = corr(diabdata(:, i), diabdata(:,54683), 'Type', 'Pearson');
    rho_tot7(i) = rho;
    pval_tot7(i) = pval;
end
% fast ins (iv0inavg)
for i = 1:54686
    [rho, pval] = corr(diabdata(:, i), diabdata(:,54684), 'Type', 'Pearson');
    rho_tot8(i) = rho;
    pval_tot8(i) = pval;
end

% si
for i = 1:54686
    [rho, pval] = corr(diabdata(:, i), diabdata(:,54685), 'Type', 'Pearson');
    rho_tot9(i) = rho;
    pval_tot9(i) = pval;
end

% waisthip
for i = 1:54686
    [rho, pval] = corr(diabdata(:, i), diabdata(:,54686), 'Type', 'Pearson');
    rho_tot10(i) = rho;
    pval_tot10(i) = pval;
end


% max(rho_tot)
% max(rho_tot1)
% max(rho_tot2)
% max(rho_tot3)
% max(rho_tot4)
% max(rho_tot5)
% max(rho_tot6)
% max(rho_tot7)
% max(rho_tot8)
% max(rho_tot9)
% max(rho_tot10)

% Correlation coefficients whose magnitude are between 0.9 and 1.0 indicate 
% variables which can be considered very highly correlated. Correlation coefficients 
% whose magnitude are between 0.7 and 0.9 indicate variables which can be considered 
% highly correlated. Correlation coefficients whose magnitude are between 0.3 and 0.7 
% indicate variables which can be considered moderately correlated.

% gender
idx = find(abs(rho_tot)>0.3);
val = rho_tot(idx)';
genelist = humandatagenelist(idx);
totgender = [genelist val];
% age
idx1 = find(abs(rho_tot1)>0.3);
val1 = rho_tot1(idx1)';
genelist1 = humandatagenelist(idx1);
totage = [genelist1 val1];
% FH
idx2 = find(abs(rho_tot2)>0.3);
val2 = rho_tot2(idx2)';
genelist2 = humandatagenelist(idx2);
totFH = [genelist2 val2];
% BMI
idx3 = find(abs(rho_tot3)>0.3);
val3 = rho_tot3(idx3)';
genelist3 = humandatagenelist(idx3);
totbmi = [genelist3 val3];
% Fast gluc
idx4 = find(abs(rho_tot4)>0.3);
val4 = rho_tot4(idx4)';
genelist4 = humandatagenelist(idx4);
totfastgluc = [genelist4 val4];
% 2hour gluc
idx5 = find(abs(rho_tot5)>0.3);
val5 = rho_tot5(idx5)';
genelist5 = humandatagenelist(idx5);
tot2hourgluc = [genelist5 val5];
% hemo a1c
idx6 = find(abs(rho_tot6)>0.3);
val6 = rho_tot6(idx6)';
genelist6 = humandatagenelist(idx6);
tothemoa1c = [genelist6 val6];
% fast gluc (iv0gavg)
idx7 = find(abs(rho_tot7)>0.3);
val7 = rho_tot7(idx7)';
genelist7 = humandatagenelist(idx7);
totfastgluc_iv0 = [genelist7 val7];
% fast ins (iv0inavg)
idx8 = find(abs(rho_tot8)>0.3);
val8 = rho_tot8(idx8)';
genelist8 = humandatagenelist(idx8);
totfastins_iv0 = [genelist8 val8];
% si
idx9 = find(abs(rho_tot9)>0.3);
val9 = rho_tot9(idx9)';
genelist9 = humandatagenelist(idx9);
totlogsi = [genelist9 val9];
% waisthip
idx10 = find(abs(rho_tot10)>0.3);
val10 = rho_tot10(idx10)';
genelist10 = humandatagenelist(idx10);
totwaist = [genelist10 val10];




toc