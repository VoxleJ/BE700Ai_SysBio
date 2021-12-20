%% BE700 HW2 Plots

close all
clear all

Perf2D = readmatrix('HW2_2dResults.csv');
Perf3D = readmatrix('HW2_3dResults.csv');
Perf10D = readmatrix('HW2_10dResults.csv');

n = [10 20 50 100 200 1000];

plot(n',Perf2D)
title('Accuracy of Testing Data vs Number of Trained Inputs for 2 Dimensions')
xlabel('Number of Points')
ylabel('Accuracy of Testing Data')
legend('Location','southeast')


figure;
plot(n', Perf3D)
title('Accuracy of Testing Data vs Number of Trained Inputs for 3 Dimensions')
xlabel('Number of Points')
ylabel('Accuracy of Testing Data')
legend('Location','southeast')


figure;
plot(n', Perf10D)
title('Accuracy of Testing Data vs Number of Trained Inputs for 10 Dimensions')
xlabel('Number of Points')
ylabel('Accuracy of Testing Data')
legend('Location','southeast')
