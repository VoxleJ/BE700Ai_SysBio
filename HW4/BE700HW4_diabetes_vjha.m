%% BE700 HW4 Networks - Diabetes

clear all
close all

%% Diabetes Data Spearman, Network, Degree Distribution

% diabetes_data = readtable('BE700_human_expression.csv');
% t2 = rows2vars(diabetes_data);
% Tnew = t2;
% 
% Tnew([1],:) = [];
% Tnew(:,[1]) = [];
% head(Tnew)
% 
% diabdata = table2array(t2(:,2:22190));
load('new_expressiondata.mat')

diabdata = BE700humanexpression';

%for this assignment i only chose to look at 500

for i = 1:500
    for j = 1:500
        [rho, pval] = corr(diabdata(:, i), diabdata(:,j), 'Type', 'Spearman');
        rho_tot(i,j) = rho;
        pval_tot(i,j) = pval;
    end
    
    if mod(i,1000) == 0
        print(i)
    end
end 

rho_tot2 = rho_tot;


for ii = 1:500
    rho_tot2(ii,ii) = 0;
end

I = rho_tot2>0.79; %significant correlation
[r, c]  = find(I);
rc = [r c];

I2 = rho_tot2>0.5; %expanding threshold
[r2, c2]  = find(I2);
rc2 = [r2 c2];

I3 = rho_tot2>0.25; %expanding threshold
[r3, c3]  = find(I3);
rc3 = [r3 c3];

% corr spear 0.79
for jz = 1:500
    for iz = 1:500
    
        if rho_tot2(iz,jz) > 0.79
            rhot_tot3(iz,jz) = 1;
        else
            rhot_tot3(iz,jz) = 0;
        end
    end
end

% corr spear 0.5
for jz = 1:500
    for iz = 1:500
    
        if rho_tot2(iz,jz) > 0.5
            rhot_tot4(iz,jz) = 1;
        else
            rhot_tot4(iz,jz) = 0;
        end
    end
end

% corr spear 0.25
for jz = 1:500
    for iz = 1:500
    
        if rho_tot2(iz,jz) > 0.25
            rhot_tot5(iz,jz) = 1;
        else
            rhot_tot5(iz,jz) = 0;
        end
    end
end

% generating graphs

graph_diab_spearman_79 = graph(rhot_tot3);
d79 = degree(graph_diab_spearman_79);
graph_diab_spearman_50 = graph(rhot_tot4);
d50 = degree(graph_diab_spearman_50);
graph_diab_spearman_25 = graph(rhot_tot5);
d25 = degree(graph_diab_spearman_25);

f1 = figure;
plot(graph_diab_spearman_79)

f15 = figure;
h = histogram(d79);

f2 = figure;
plot(graph_diab_spearman_50)

f25 = figure;
h2 = histogram(d50);

f3 = figure;
plot(graph_diab_spearman_25)

f35 = figure;
h3 = histogram(d25);

%% Diabetes pearson

for i = 1:500
    for j = 1:500
        [rho, pval] = corr(diabdata(:, i), diabdata(:,j), 'Type', 'Pearson');
        rho_tot(i,j) = rho;
        pval_tot(i,j) = pval;
    end    
end 

% heatmap(rho_tot);
rho_tot2 = rho_tot;


for ii = 1:500
    rho_tot2(ii,ii) = 0;
end

I = rho_tot2>0.79; %significant correlation
[r, c]  = find(I);
rc = [r c];

I2 = rho_tot2>0.5; %expanding threshold
[r2, c2]  = find(I2);
rc2 = [r2 c2];

I3 = rho_tot2>0.25; %expanding threshold
[r3, c3]  = find(I3);
rc3 = [r3 c3];

% corr spear 0.79
for jz = 1:500
    for iz = 1:500
    
        if rho_tot2(iz,jz) > 0.79
            rhot_tot3(iz,jz) = 1;
        else
            rhot_tot3(iz,jz) = 0;
        end
    end
end

% corr spear 0.5
for jz = 1:500
    for iz = 1:500
    
        if rho_tot2(iz,jz) > 0.5
            rhot_tot4(iz,jz) = 1;
        else
            rhot_tot4(iz,jz) = 0;
        end
    end
end

% corr spear 0.25
for jz = 1:500
    for iz = 1:500
    
        if rho_tot2(iz,jz) > 0.25
            rhot_tot5(iz,jz) = 1;
        else
            rhot_tot5(iz,jz) = 0;
        end
    end
end

% generating graphs

graph_diab_p_79 = graph(rhot_tot3);
d79 = degree(graph_diab_p_79);
graph_diab_p_50 = graph(rhot_tot4);
d50 = degree(graph_diab_p_50);
graph_diab_p_25 = graph(rhot_tot5);
d25 = degree(graph_diab_p_25);

f4 = figure;
plot(graph_diab_p_79)

f45 = figure;
h4 = histogram(d79);

f5 = figure;
plot(graph_diab_p_50)

f55 = figure;
h5 = histogram(d50);

f6 = figure;
plot(graph_diab_p_25)

f65 = figure;
h6 = histogram(d25);


% FolderName = "D:\BE700Ai\HW4\Diab2";   
% FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
% for iFig = 1:length(FigList)
%   FigHandle = FigList(iFig);
%   FigName   = num2str(get(FigHandle, 'Number'));
%   set(0, 'CurrentFigure', FigHandle);
%   savefig(fullfile(FolderName, [FigName '.fig']));
% end