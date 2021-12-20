%% BE700 HW4 Networks

clear all
close all

%% Cancer Data Spearman, Network, Degree Distribution

%Spearman
cancer_data = readtable('HW1_data.csv');
candata = table2array(cancer_data(:,1:30));

for i = 1:30
    for j = 1:30
        [rho, pval] = corr(candata(:, i), candata(:,j), 'Type', 'Spearman');
        rho_tot(i,j) = rho;
        pval_tot(i,j) = pval;
    end    
end 

% heatmap(rho_tot);
rho_tot2 = rho_tot;


for ii = 1:30
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
for jz = 1:30
    for iz = 1:30
    
        if rho_tot2(iz,jz) > 0.79
            rhot_tot3(iz,jz) = 1;
        else
            rhot_tot3(iz,jz) = 0;
        end
    end
end

% corr spear 0.5
for jz = 1:30
    for iz = 1:30
    
        if rho_tot2(iz,jz) > 0.5
            rhot_tot4(iz,jz) = 1;
        else
            rhot_tot4(iz,jz) = 0;
        end
    end
end

% corr spear 0.25
for jz = 1:30
    for iz = 1:30
    
        if rho_tot2(iz,jz) > 0.25
            rhot_tot5(iz,jz) = 1;
        else
            rhot_tot5(iz,jz) = 0;
        end
    end
end

% generating graphs

graph_cancer_spearman_79 = graph(rhot_tot3);
d79 = degree(graph_cancer_spearman_79);
graph_cancer_spearman_50 = graph(rhot_tot4);
d50 = degree(graph_cancer_spearman_50);
graph_cancer_spearman_25 = graph(rhot_tot5);
d25 = degree(graph_cancer_spearman_25);

f1 = figure;
plot(graph_cancer_spearman_79)

f15 = figure;
h = histogram(d79);

f2 = figure;
plot(graph_cancer_spearman_50)

f25 = figure;
h2 = histogram(d50);

f3 = figure;
plot(graph_cancer_spearman_25)

f35 = figure;
h3 = histogram(d25);

%% Cancer Data Pearson, Network, Degree Distribution

for i = 1:30
    for j = 1:30
        [rho, pval] = corr(candata(:, i), candata(:,j), 'Type', 'Pearson');
        rho_tot(i,j) = rho;
        pval_tot(i,j) = pval;
    end    
end 

% heatmap(rho_tot);
rho_tot2 = rho_tot;


for ii = 1:30
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
for jz = 1:30
    for iz = 1:30
    
        if rho_tot2(iz,jz) > 0.79
            rhot_tot3(iz,jz) = 1;
        else
            rhot_tot3(iz,jz) = 0;
        end
    end
end

% corr spear 0.5
for jz = 1:30
    for iz = 1:30
    
        if rho_tot2(iz,jz) > 0.5
            rhot_tot4(iz,jz) = 1;
        else
            rhot_tot4(iz,jz) = 0;
        end
    end
end

% corr spear 0.25
for jz = 1:30
    for iz = 1:30
    
        if rho_tot2(iz,jz) > 0.25
            rhot_tot5(iz,jz) = 1;
        else
            rhot_tot5(iz,jz) = 0;
        end
    end
end

% generating graphs

graph_cancer_p_79 = graph(rhot_tot3);
d79 = degree(graph_cancer_p_79);
graph_cancer_p_50 = graph(rhot_tot4);
d50 = degree(graph_cancer_p_50);
graph_cancer_p_25 = graph(rhot_tot5);
d25 = degree(graph_cancer_p_25);

f4 = figure;
plot(graph_cancer_p_79)

f45 = figure;
h4 = histogram(d79);

f5 = figure;
plot(graph_cancer_p_50)

f55 = figure;
h5 = histogram(d50);

f6 = figure;
plot(graph_cancer_p_25)

f65 = figure;
h6 = histogram(d25);

% FolderName = "D:\BE700Ai\HW4\Figures";   
% FigList = findobj(allchild(0), 'flat', 'Type', 'figure');
% for iFig = 1:length(FigList)
%   FigHandle = FigList(iFig);
%   FigName   = num2str(get(FigHandle, 'Number'));
%   set(0, 'CurrentFigure', FigHandle);
%   savefig(fullfile(FolderName, [FigName '.fig']));
% end