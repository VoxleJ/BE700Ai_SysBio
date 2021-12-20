%% BE700 HW2 Part 2 Perceptron Algorithm on Synthetic Data
clear all
close all

%% 0. Generating Synthetic Data and Hyperplanes

%Generate a random 2/3/10 Hyperplane
%for this we need 2/3/10 randomly generated values to plug into B1 * X1 +
%B2 * X2... BN * XN
%leaving intercept as 0 for each hyperplane

B = zeros(10,1);
for i = 1:10
B(i) = rand(1);
end

%Generate a random 1000 x 10 dataset (n x p)
% select either p = 2, 3, or 10 (depending on hyperplane dimension)
% select either n = 10,20,50,100,200,1000; depending on part

syntheticdata = rand(1000,10)-0.5;


%classify data using 2,3 and 10 D hyperplane

%2D-first two columns
data2d = syntheticdata(:,1:2);

for i = 1:1000
    output2d(i) = sign(B(1)*data2d(i,1) + B(2)*data2d(i,2));
end
z2 = output2d == -1;
output2d(z2) = 0;
output2d = output2d';

%3D
data3d = syntheticdata(:,1:3);
for i = 1:1000
    output3d(i) = sign(B(1)*data3d(i,1) + B(2)*data3d(i,2) + B(3)*data3d(i,3));
end
z3 = output3d == -1;
output3d(z3) = 0;
output3d = output3d';

%10D

data10d = syntheticdata(:,1:10);

for i = 1:1000
    output10d(i) = sign(B(1)*data10d(i,1) + B(2)*data10d(i,2) + B(3)*data10d(i,3)+...
        B(1)*data10d(i,4) + B(5)*data10d(i,5) + B(6)*data10d(i,6)+...
        B(7)*data10d(i,7) + B(8)*data10d(i,8) + B(9)*data10d(i,9)+...
        B(10)*data10d(i,10));
end
z10 = output10d == -1;
output10d(z10) = 0;
output10d = output10d';

%Testing Set
TestingSet = rand(100,10)-0.5;

for i = 1:100
    TestingSet_Class2d(i) = sign(B(1)*TestingSet(i,1) + B(2)*TestingSet(i,2));
end
% z11 = TestingSet_Class2d == -1;
% TestingSet_Class2d(z11) = 0;
% TestingSet_Class2d = TestingSet_Class2d';

for i = 1:100
    TestingSet_Class3d(i) = sign(B(1)*TestingSet(i,1) + B(2)*TestingSet(i,2)...
        + B(3)*TestingSet(i,3));
end
% z12 = TestingSet_Class3d == -1;
% TestingSet_Class3d(z12) = 0;
% TestingSet_Class3d = TestingSet_Class3d';


for i = 1:100
    TestingSet_Class10d(i) = sign(B(1)*TestingSet(i,1) + B(2)*TestingSet(i,2) + B(3)*TestingSet(i,3)+...
        B(1)*TestingSet(i,4) + B(5)*TestingSet(i,5) + B(6)*TestingSet(i,6)+...
        B(7)*TestingSet(i,7) + B(8)*TestingSet(i,8) + B(9)*TestingSet(i,9)+...
        B(10)*TestingSet(i,10));
end
% z13 = TestingSet_Class10d == -1;
% TestingSet_Class10d(z13) = 0;
% TestingSet_Class10d = TestingSet_Class10d';



%% 1. Perceptron Training/Testing 10D

%Perceptron Steps
%1. Initialize weights to a small initial value
%2. a. Calculate output for each input from the set
%   b. Update weight using w(t) + learning rate*(realout -
%   predictedout)*input value
%3. Repeat until some error target or k iterations


%10D Class
fprintf('10 Dimenstions\n\n')
learning_rate = 0.5;
class_out = output10d;
w = zeros(10,1);
valin = data10d;
%n = 10
for k = 1:100
     PredictedOutput_10d_n10 = zeros(10,1);
     for j = 1:10
          y = valin(j,1)*w(1,1) + valin(j,2)*w(2,1) + valin(j,3)*w(3,1)+...
               valin(j,4)*w(4,1) + valin(j,5)*w(5,1) + valin(j,6)*w(6,1)+...
               valin(j,7)*w(7,1) + valin(j,8)*w(8,1) + valin(j,9)*w(9,1)+...
               valin(j,10)*w(10,1);
           %using a relu like activation function to scale values to 0 or
            %1
            if y < 0 
                PredictedOutput_10d_n10(j) = 0;
            else
                PredictedOutput_10d_n10(j) = 1;
            end
            
            diff = class_out(j) - PredictedOutput_10d_n10(j);
             
            w(1,1) = w(1,1)+learning_rate*valin(j,1)*diff;
         	w(2,1) = w(2,1)+learning_rate*valin(j,2)*diff;
            w(3,1) = w(3,1)+learning_rate*valin(j,3)*diff;
            w(4,1) = w(4,1)+learning_rate*valin(j,4)*diff;
            w(5,1) = w(5,1)+learning_rate*valin(j,5)*diff;
            w(6,1) = w(6,1)+learning_rate*valin(j,6)*diff;
            w(7,1) = w(7,1)+learning_rate*valin(j,7)*diff;
            w(8,1) = w(8,1)+learning_rate*valin(j,8)*diff;
            w(9,1) = w(9,1)+learning_rate*valin(j,9)*diff;
            w(10,1) = w(10,1)+learning_rate*valin(j,10)*diff;
     end
end


bsb = PredictedOutput_10d_n10 == class_out(1:10);
correct = sum(bsb == 1, 'all');
ACC = correct/length(PredictedOutput_10d_n10);
fprintf('The Accuracy after 100 iterations for 10D, N=10 is %0.4f\n',ACC)



%Testing 100 for n=10
for i = 1:100
    test_output10d_n10(i) = sign(w(1)*TestingSet(i,1) + w(2)*TestingSet(i,2) + w(3)*TestingSet(i,3)+...
        w(1)*TestingSet(i,4) + w(5)*TestingSet(i,5) + w(6)*TestingSet(i,6)+...
        w(7)*TestingSet(i,7) + w(8)*TestingSet(i,8) + w(9)*TestingSet(i,9)+...
        w(10)*TestingSet(i,10));
end

b3b = test_output10d_n10 == TestingSet_Class10d;
correct2 = sum(b3b == 1, 'all');
ACC2 = correct2/100;
fprintf('The Accuracy after 100 iterations for 10D, N=10 on the testing set of N=100 is %0.4f\n\n',ACC2)

w = zeros(10,1);

%n = 20
for k = 1:100
     PredictedOutput_10d_n20 = zeros(20,1);
     for j = 1:20
          y = valin(j,1)*w(1,1) + valin(j,2)*w(2,1) + valin(j,3)*w(3,1)+...
               valin(j,4)*w(4,1) + valin(j,5)*w(5,1) + valin(j,6)*w(6,1)+...
               valin(j,7)*w(7,1) + valin(j,8)*w(8,1) + valin(j,9)*w(9,1)+...
               valin(j,10)*w(10,1);
           %using a relu like activation function to scale values to 0 or
            %1
            if y < 0 
                PredictedOutput_10d_n20(j) = 0;
            else
                PredictedOutput_10d_n20(j) = 1;
            end
            
            diff = class_out(j) - PredictedOutput_10d_n20(j);
             
            w(1,1) = w(1,1)+learning_rate*valin(j,1)*diff;
         	w(2,1) = w(2,1)+learning_rate*valin(j,2)*diff;
            w(3,1) = w(3,1)+learning_rate*valin(j,3)*diff;
            w(4,1) = w(4,1)+learning_rate*valin(j,4)*diff;
            w(5,1) = w(5,1)+learning_rate*valin(j,5)*diff;
            w(6,1) = w(6,1)+learning_rate*valin(j,6)*diff;
            w(7,1) = w(7,1)+learning_rate*valin(j,7)*diff;
            w(8,1) = w(8,1)+learning_rate*valin(j,8)*diff;
            w(9,1) = w(9,1)+learning_rate*valin(j,9)*diff;
            w(10,1) = w(10,1)+learning_rate*valin(j,10)*diff;
     end
end

bsb2 = PredictedOutput_10d_n20 == class_out(1:20);
correct3 = sum(bsb2 == 1, 'all');
ACC3 = correct3/length(PredictedOutput_10d_n20);
fprintf('The Accuracy after 100 iterations for 10D, N=20 is %0.4f\n',ACC3)

%testing 100 for n = 20
for i = 1:100
    test_output10d_n20(i) = sign(w(1)*TestingSet(i,1) + w(2)*TestingSet(i,2) + w(3)*TestingSet(i,3)+...
        w(1)*TestingSet(i,4) + w(5)*TestingSet(i,5) + w(6)*TestingSet(i,6)+...
        w(7)*TestingSet(i,7) + w(8)*TestingSet(i,8) + w(9)*TestingSet(i,9)+...
        w(10)*TestingSet(i,10));
end

b4b = test_output10d_n20 == TestingSet_Class10d;
correct4 = sum(b4b == 1, 'all');
ACC2 = correct4/100;
fprintf('The Accuracy after 100 iterations for 10D, N=20 on the testing set of N=100 is %0.4f\n\n',ACC2)

w = zeros(10,1);

%n = 50
for k = 1:100
     PredictedOutput_10d_n50 = zeros(50,1);
     for j = 1:50
          y = valin(j,1)*w(1,1) + valin(j,2)*w(2,1) + valin(j,3)*w(3,1)+...
               valin(j,4)*w(4,1) + valin(j,5)*w(5,1) + valin(j,6)*w(6,1)+...
               valin(j,7)*w(7,1) + valin(j,8)*w(8,1) + valin(j,9)*w(9,1)+...
               valin(j,10)*w(10,1);
           %using a relu like activation function to scale values to 0 or
            %1
            if y < 0 
                PredictedOutput_10d_n50(j) = 0;
            else
                PredictedOutput_10d_n50(j) = 1;
            end
            
            diff = class_out(j) - PredictedOutput_10d_n50(j);
             
            w(1,1) = w(1,1)+learning_rate*valin(j,1)*diff;
         	w(2,1) = w(2,1)+learning_rate*valin(j,2)*diff;
            w(3,1) = w(3,1)+learning_rate*valin(j,3)*diff;
            w(4,1) = w(4,1)+learning_rate*valin(j,4)*diff;
            w(5,1) = w(5,1)+learning_rate*valin(j,5)*diff;
            w(6,1) = w(6,1)+learning_rate*valin(j,6)*diff;
            w(7,1) = w(7,1)+learning_rate*valin(j,7)*diff;
            w(8,1) = w(8,1)+learning_rate*valin(j,8)*diff;
            w(9,1) = w(9,1)+learning_rate*valin(j,9)*diff;
            w(10,1) = w(10,1)+learning_rate*valin(j,10)*diff;
     end
end

bsb2 = PredictedOutput_10d_n50 == class_out(1:50);
correct3 = sum(bsb2 == 1, 'all');
ACC3 = correct3/length(PredictedOutput_10d_n50);
fprintf('The Accuracy after 100 iterations for 10D, N=50 is %0.4f\n',ACC3)

%testing 100 for n = 50
for i = 1:100
    test_output10d_n50(i) = sign(w(1)*TestingSet(i,1) + w(2)*TestingSet(i,2) + w(3)*TestingSet(i,3)+...
        w(1)*TestingSet(i,4) + w(5)*TestingSet(i,5) + w(6)*TestingSet(i,6)+...
        w(7)*TestingSet(i,7) + w(8)*TestingSet(i,8) + w(9)*TestingSet(i,9)+...
        w(10)*TestingSet(i,10));
end

b4b = test_output10d_n50 == TestingSet_Class10d;
correct4 = sum(b4b == 1, 'all');
ACC2 = correct4/100;
fprintf('The Accuracy after 100 iterations for 10D, N=50 on the testing set of N=100 is %0.4f\n\n',ACC2)

w = zeros(10,1);

%n = 100
for k = 1:100
     PredictedOutput_10d_n100 = zeros(100,1);
     for j = 1:100
          y = valin(j,1)*w(1,1) + valin(j,2)*w(2,1) + valin(j,3)*w(3,1)+...
               valin(j,4)*w(4,1) + valin(j,5)*w(5,1) + valin(j,6)*w(6,1)+...
               valin(j,7)*w(7,1) + valin(j,8)*w(8,1) + valin(j,9)*w(9,1)+...
               valin(j,10)*w(10,1);
           %using a relu like activation function to scale values to 0 or
            %1
            if y < 0 
                PredictedOutput_10d_n100(j) = 0;
            else
                PredictedOutput_10d_n100(j) = 1;
            end
            
            diff = class_out(j) - PredictedOutput_10d_n100(j);
             
            w(1,1) = w(1,1)+learning_rate*valin(j,1)*diff;
         	w(2,1) = w(2,1)+learning_rate*valin(j,2)*diff;
            w(3,1) = w(3,1)+learning_rate*valin(j,3)*diff;
            w(4,1) = w(4,1)+learning_rate*valin(j,4)*diff;
            w(5,1) = w(5,1)+learning_rate*valin(j,5)*diff;
            w(6,1) = w(6,1)+learning_rate*valin(j,6)*diff;
            w(7,1) = w(7,1)+learning_rate*valin(j,7)*diff;
            w(8,1) = w(8,1)+learning_rate*valin(j,8)*diff;
            w(9,1) = w(9,1)+learning_rate*valin(j,9)*diff;
            w(10,1) = w(10,1)+learning_rate*valin(j,10)*diff;
     end
end

bsb2 = PredictedOutput_10d_n100 == class_out(1:100);
correct3 = sum(bsb2 == 1, 'all');
ACC3 = correct3/length(PredictedOutput_10d_n100);
fprintf('The Accuracy after 100 iterations for 10D, N=100 is %0.4f\n',ACC3)

%testing 100 for n = 100
for i = 1:100
    test_output10d_n100(i) = sign(w(1)*TestingSet(i,1) + w(2)*TestingSet(i,2) + w(3)*TestingSet(i,3)+...
        w(1)*TestingSet(i,4) + w(5)*TestingSet(i,5) + w(6)*TestingSet(i,6)+...
        w(7)*TestingSet(i,7) + w(8)*TestingSet(i,8) + w(9)*TestingSet(i,9)+...
        w(10)*TestingSet(i,10));
end

b4b = test_output10d_n100 == TestingSet_Class10d;
correct4 = sum(b4b == 1, 'all');
ACC2 = correct4/100;
fprintf('The Accuracy after 100 iterations for 10D, N=100 on the testing set of N=100 is %0.4f\n\n',ACC2)


w = zeros(10,1);

%n = 200
for k = 1:100
     PredictedOutput_10d_n200 = zeros(200,1);
     for j = 1:200
          y = valin(j,1)*w(1,1) + valin(j,2)*w(2,1) + valin(j,3)*w(3,1)+...
               valin(j,4)*w(4,1) + valin(j,5)*w(5,1) + valin(j,6)*w(6,1)+...
               valin(j,7)*w(7,1) + valin(j,8)*w(8,1) + valin(j,9)*w(9,1)+...
               valin(j,10)*w(10,1);
           %using a relu like activation function to scale values to 0 or
            %1
            if y < 0 
                PredictedOutput_10d_n200(j) = 0;
            else
                PredictedOutput_10d_n200(j) = 1;
            end
            
            diff = class_out(j) - PredictedOutput_10d_n200(j);
             
            w(1,1) = w(1,1)+learning_rate*valin(j,1)*diff;
         	w(2,1) = w(2,1)+learning_rate*valin(j,2)*diff;
            w(3,1) = w(3,1)+learning_rate*valin(j,3)*diff;
            w(4,1) = w(4,1)+learning_rate*valin(j,4)*diff;
            w(5,1) = w(5,1)+learning_rate*valin(j,5)*diff;
            w(6,1) = w(6,1)+learning_rate*valin(j,6)*diff;
            w(7,1) = w(7,1)+learning_rate*valin(j,7)*diff;
            w(8,1) = w(8,1)+learning_rate*valin(j,8)*diff;
            w(9,1) = w(9,1)+learning_rate*valin(j,9)*diff;
            w(10,1) = w(10,1)+learning_rate*valin(j,10)*diff;
     end
end

bsb2 = PredictedOutput_10d_n200 == class_out(1:200);
correct3 = sum(bsb2 == 1, 'all');
ACC3 = correct3/length(PredictedOutput_10d_n200);
fprintf('The Accuracy after 100 iterations for 10D, N=200 is %0.4f\n',ACC3)

%testing 100 for n = 100
for i = 1:100
    test_output10d_n200(i) = sign(w(1)*TestingSet(i,1) + w(2)*TestingSet(i,2) + w(3)*TestingSet(i,3)+...
        w(1)*TestingSet(i,4) + w(5)*TestingSet(i,5) + w(6)*TestingSet(i,6)+...
        w(7)*TestingSet(i,7) + w(8)*TestingSet(i,8) + w(9)*TestingSet(i,9)+...
        w(10)*TestingSet(i,10));
end

b4b = test_output10d_n200 == TestingSet_Class10d;
correct4 = sum(b4b == 1, 'all');
ACC2 = correct4/100;
fprintf('The Accuracy after 100 iterations for 10D, N=200 on the testing set of N=100 is %0.4f\n\n',ACC2)


w = zeros(10,1);

%n = 500
for k = 1:150
     PredictedOutput_10d_n500 = zeros(500,1);
     for j = 1:500
          y = valin(j,1)*w(1,1) + valin(j,2)*w(2,1) + valin(j,3)*w(3,1)+...
               valin(j,4)*w(4,1) + valin(j,5)*w(5,1) + valin(j,6)*w(6,1)+...
               valin(j,7)*w(7,1) + valin(j,8)*w(8,1) + valin(j,9)*w(9,1)+...
               valin(j,10)*w(10,1);
           %using a relu like activation function to scale values to 0 or
            %1
            if y < 0 
                PredictedOutput_10d_n500(j) = 0;
            else
                PredictedOutput_10d_n500(j) = 1;
            end
            
            diff = class_out(j) - PredictedOutput_10d_n500(j);
             
            w(1,1) = w(1,1)+learning_rate*valin(j,1)*diff;
         	w(2,1) = w(2,1)+learning_rate*valin(j,2)*diff;
            w(3,1) = w(3,1)+learning_rate*valin(j,3)*diff;
            w(4,1) = w(4,1)+learning_rate*valin(j,4)*diff;
            w(5,1) = w(5,1)+learning_rate*valin(j,5)*diff;
            w(6,1) = w(6,1)+learning_rate*valin(j,6)*diff;
            w(7,1) = w(7,1)+learning_rate*valin(j,7)*diff;
            w(8,1) = w(8,1)+learning_rate*valin(j,8)*diff;
            w(9,1) = w(9,1)+learning_rate*valin(j,9)*diff;
            w(10,1) = w(10,1)+learning_rate*valin(j,10)*diff;
     end
end

bsb2 = PredictedOutput_10d_n500 == class_out(1:500);
correct3 = sum(bsb2 == 1, 'all');
ACC3 = correct3/length(PredictedOutput_10d_n500);
fprintf('The Accuracy after 150 iterations for 10D, N=500 is %0.4f\n',ACC3)

%testing 100 for n = 100
for i = 1:100
    test_output10d_n500(i) = sign(w(1)*TestingSet(i,1) + w(2)*TestingSet(i,2) + w(3)*TestingSet(i,3)+...
        w(1)*TestingSet(i,4) + w(5)*TestingSet(i,5) + w(6)*TestingSet(i,6)+...
        w(7)*TestingSet(i,7) + w(8)*TestingSet(i,8) + w(9)*TestingSet(i,9)+...
        w(10)*TestingSet(i,10));
end

b4b = test_output10d_n500 == TestingSet_Class10d;
correct4 = sum(b4b == 1, 'all');
ACC2 = correct4/100;
fprintf('The Accuracy after 150 iterations for 10D, N=500 on the testing set of N=100 is %0.4f\n\n',ACC2)


w = zeros(10,1);

%n = 1000
for k = 1:200
     PredictedOutput_10d_n500 = zeros(1000,1);
     for j = 1:1000
          y = valin(j,1)*w(1,1) + valin(j,2)*w(2,1) + valin(j,3)*w(3,1)+...
               valin(j,4)*w(4,1) + valin(j,5)*w(5,1) + valin(j,6)*w(6,1)+...
               valin(j,7)*w(7,1) + valin(j,8)*w(8,1) + valin(j,9)*w(9,1)+...
               valin(j,10)*w(10,1);
           %using a relu like activation function to scale values to 0 or
            %1
            if y < 0 
                PredictedOutput_10d_n1000(j) = 0;
            else
                PredictedOutput_10d_n1000(j) = 1;
            end
            
            diff = class_out(j) - PredictedOutput_10d_n1000(j);
             
            w(1,1) = w(1,1)+learning_rate*valin(j,1)*diff;
         	w(2,1) = w(2,1)+learning_rate*valin(j,2)*diff;
            w(3,1) = w(3,1)+learning_rate*valin(j,3)*diff;
            w(4,1) = w(4,1)+learning_rate*valin(j,4)*diff;
            w(5,1) = w(5,1)+learning_rate*valin(j,5)*diff;
            w(6,1) = w(6,1)+learning_rate*valin(j,6)*diff;
            w(7,1) = w(7,1)+learning_rate*valin(j,7)*diff;
            w(8,1) = w(8,1)+learning_rate*valin(j,8)*diff;
            w(9,1) = w(9,1)+learning_rate*valin(j,9)*diff;
            w(10,1) = w(10,1)+learning_rate*valin(j,10)*diff;
     end
end

bsb2 = PredictedOutput_10d_n1000 == class_out;
correct3 = sum(bsb2 == 1, 'all');
ACC3 = correct3/length(PredictedOutput_10d_n1000);
fprintf('The Accuracy after 200 iterations for 10D, N=1000 is %0.4f\n',ACC3)

%testing 100 for n = 100
for i = 1:100
    test_output10d_n1000(i) = sign(w(1)*TestingSet(i,1) + w(2)*TestingSet(i,2) + w(3)*TestingSet(i,3)+...
        w(1)*TestingSet(i,4) + w(5)*TestingSet(i,5) + w(6)*TestingSet(i,6)+...
        w(7)*TestingSet(i,7) + w(8)*TestingSet(i,8) + w(9)*TestingSet(i,9)+...
        w(10)*TestingSet(i,10));
end

b4b = test_output10d_n1000 == TestingSet_Class10d;
correct4 = sum(b4b == 1, 'all');
ACC2 = correct4/100;
fprintf('The Accuracy after 200 iterations for 10D, N=1000 on the testing set of N=100 is %0.4f\n\n',ACC2)

%% 2. Perceptron Training/Testing 3D

%3D Class
fprintf('3 Dimenstions\n\n')
learning_rate = 0.5;
class_out = output3d;
valin = data3d;

w = zeros(3,1);
%n = 10
for k = 1:100
     PredictedOutput_3d_n10 = zeros(10,1);
     for j = 1:10
          y = valin(j,1)*w(1,1) + valin(j,2)*w(2,1) + valin(j,3)*w(3,1);
               
           %using a relu like activation function to scale values to 0 or
            %1
            if y < 0 
                PredictedOutput_3d_n10(j) = 0;
            else
                PredictedOutput_3d_n10(j) = 1;
            end
            
            diff = class_out(j) - PredictedOutput_3d_n10(j);
             
            w(1,1) = w(1,1)+learning_rate*valin(j,1)*diff;
         	w(2,1) = w(2,1)+learning_rate*valin(j,2)*diff;
            w(3,1) = w(3,1)+learning_rate*valin(j,3)*diff;
      
     end
end


bsb = PredictedOutput_3d_n10 == class_out(1:10);
correct = sum(bsb == 1, 'all');
ACC = correct/length(PredictedOutput_3d_n10);
fprintf('The Accuracy after 100 iterations for 3D, N=10 is %0.4f\n',ACC)



%Testing 100 for n=10
for i = 1:100
    test_output3d_n10(i) = sign(w(1)*TestingSet(i,1) + w(2)*TestingSet(i,2) + w(3)*TestingSet(i,3));
end

b3b = test_output3d_n10 == TestingSet_Class3d;
correct2 = sum(b3b == 1, 'all');
ACC2 = correct2/100;
fprintf('The Accuracy after 100 iterations for 3D, N=10 on the testing set of N=100 is %0.4f\n\n',ACC2)

w = zeros(3,1);
%n = 20
for k = 1:100
     PredictedOutput_3d_n20 = zeros(20,1);
     for j = 1:20
          y = valin(j,1)*w(1,1) + valin(j,2)*w(2,1) + valin(j,3)*w(3,1);
               
           %using a relu like activation function to scale values to 0 or
            %1
            if y < 0 
                PredictedOutput_3d_n20(j) = 0;
            else
                PredictedOutput_3d_n20(j) = 1;
            end
            
            diff = class_out(j) - PredictedOutput_3d_n20(j);
             
            w(1,1) = w(1,1)+learning_rate*valin(j,1)*diff;
         	w(2,1) = w(2,1)+learning_rate*valin(j,2)*diff;
            w(3,1) = w(3,1)+learning_rate*valin(j,3)*diff;
      
     end
end


bsb = PredictedOutput_3d_n20 == class_out(1:20);
correct = sum(bsb == 1, 'all');
ACC = correct/length(PredictedOutput_3d_n20);
fprintf('The Accuracy after 100 iterations for 3D, N=20 is %0.4f\n',ACC)



%Testing 100 for n=20
for i = 1:100
    test_output3d_n20(i) = sign(w(1)*TestingSet(i,1) + w(2)*TestingSet(i,2) + w(3)*TestingSet(i,3));
end

b3b = test_output3d_n20 == TestingSet_Class3d;
correct2 = sum(b3b == 1, 'all');
ACC2 = correct2/100;
fprintf('The Accuracy after 100 iterations for 3D, N=20 on the testing set of N=100 is %0.4f\n\n',ACC2)


w = zeros(3,1);
%n = 50
for k = 1:100
     PredictedOutput_3d_n50 = zeros(10,1);
     for j = 1:50
          y = valin(j,1)*w(1,1) + valin(j,2)*w(2,1) + valin(j,3)*w(3,1);
               
           %using a relu like activation function to scale values to 0 or
            %1
            if y < 0 
                PredictedOutput_3d_n50(j) = 0;
            else
                PredictedOutput_3d_n50(j) = 1;
            end
            
            diff = class_out(j) - PredictedOutput_3d_n50(j);
             
            w(1,1) = w(1,1)+learning_rate*valin(j,1)*diff;
         	w(2,1) = w(2,1)+learning_rate*valin(j,2)*diff;
            w(3,1) = w(3,1)+learning_rate*valin(j,3)*diff;
      
     end
end


bsb = PredictedOutput_3d_n50 == class_out(1:50);
correct = sum(bsb == 1, 'all');
ACC = correct/length(PredictedOutput_3d_n50);
fprintf('The Accuracy after 100 iterations for 3D, N=50 is %0.4f\n',ACC)



%Testing 100 for n=50
for i = 1:100
    test_output3d_n50(i) = sign(w(1)*TestingSet(i,1) + w(2)*TestingSet(i,2) + w(3)*TestingSet(i,3));
end

b3b = test_output3d_n50 == TestingSet_Class3d;
correct2 = sum(b3b == 1, 'all');
ACC2 = correct2/100;
fprintf('The Accuracy after 100 iterations for 3D, N=50 on the testing set of N=100 is %0.4f\n\n',ACC2)


w = zeros(3,1);
%n = 100
for k = 1:100
     PredictedOutput_3d_n100 = zeros(100,1);
     for j = 1:100
          y = valin(j,1)*w(1,1) + valin(j,2)*w(2,1) + valin(j,3)*w(3,1);
               
           %using a relu like activation function to scale values to 0 or
            %1
            if y < 0 
                PredictedOutput_3d_n100(j) = 0;
            else
                PredictedOutput_3d_n100(j) = 1;
            end
            
            diff = class_out(j) - PredictedOutput_3d_n100(j);
             
            w(1,1) = w(1,1)+learning_rate*valin(j,1)*diff;
         	w(2,1) = w(2,1)+learning_rate*valin(j,2)*diff;
            w(3,1) = w(3,1)+learning_rate*valin(j,3)*diff;
      
     end
end


bsb = PredictedOutput_3d_n100 == class_out(1:100);
correct = sum(bsb == 1, 'all');
ACC = correct/length(PredictedOutput_3d_n100);
fprintf('The Accuracy after 100 iterations for 3D, N=100 is %0.4f\n',ACC)



%Testing 100 for n=10
for i = 1:100
    test_output3d_n100(i) = sign(w(1)*TestingSet(i,1) + w(2)*TestingSet(i,2) + w(3)*TestingSet(i,3));
end

b3b = test_output3d_n100 == TestingSet_Class3d;
correct2 = sum(b3b == 1, 'all');
ACC2 = correct2/100;
fprintf('The Accuracy after 100 iterations for 3D, N=100 on the testing set of N=100 is %0.4f\n\n',ACC2)


w = zeros(3,1);
%n = 200
for k = 1:100
     PredictedOutput_3d_n200 = zeros(200,1);
     for j = 1:200
          y = valin(j,1)*w(1,1) + valin(j,2)*w(2,1) + valin(j,3)*w(3,1);
               
           %using a relu like activation function to scale values to 0 or
            %1
            if y < 0 
                PredictedOutput_3d_n200(j) = 0;
            else
                PredictedOutput_3d_n200(j) = 1;
            end
            
            diff = class_out(j) - PredictedOutput_3d_n200(j);
             
            w(1,1) = w(1,1)+learning_rate*valin(j,1)*diff;
         	w(2,1) = w(2,1)+learning_rate*valin(j,2)*diff;
            w(3,1) = w(3,1)+learning_rate*valin(j,3)*diff;
      
     end
end


bsb = PredictedOutput_3d_n200 == class_out(1:200);
correct = sum(bsb == 1, 'all');
ACC = correct/length(PredictedOutput_3d_n200);
fprintf('The Accuracy after 100 iterations for 3D, N=200 is %0.4f\n',ACC)



%Testing 100 for n=200
for i = 1:100
    test_output3d_n200(i) = sign(w(1)*TestingSet(i,1) + w(2)*TestingSet(i,2) + w(3)*TestingSet(i,3));
end

b3b = test_output3d_n200 == TestingSet_Class3d;
correct2 = sum(b3b == 1, 'all');
ACC2 = correct2/100;
fprintf('The Accuracy after 100 iterations for 3D, N=200 on the testing set of N=100 is %0.4f\n\n',ACC2)


w = zeros(3,1);
%n = 1000
for k = 1:100
     PredictedOutput_3d_n1000 = zeros(1000,1);
     for j = 1:1000
          y = valin(j,1)*w(1,1) + valin(j,2)*w(2,1) + valin(j,3)*w(3,1);
               
           %using a relu like activation function to scale values to 0 or
            %1
            if y < 0 
                PredictedOutput_3d_n1000(j) = 0;
            else
                PredictedOutput_3d_n1000(j) = 1;
            end
            
            diff = class_out(j) - PredictedOutput_3d_n1000(j);
             
            w(1,1) = w(1,1)+learning_rate*valin(j,1)*diff;
         	w(2,1) = w(2,1)+learning_rate*valin(j,2)*diff;
            w(3,1) = w(3,1)+learning_rate*valin(j,3)*diff;
      
     end
end


bsb = PredictedOutput_3d_n1000 == class_out(1:1000);
correct = sum(bsb == 1, 'all');
ACC = correct/length(PredictedOutput_3d_n1000);
fprintf('The Accuracy after 100 iterations for 3D, N=1000 is %0.4f\n',ACC)



%Testing 100 for n=10
for i = 1:100
    test_output3d_n1000(i) = sign(w(1)*TestingSet(i,1) + w(2)*TestingSet(i,2) + w(3)*TestingSet(i,3));
end

b3b = test_output3d_n1000 == TestingSet_Class3d;
correct2 = sum(b3b == 1, 'all');
ACC2 = correct2/100;
fprintf('The Accuracy after 100 iterations for 3D, N=1000 on the testing set of N=100 is %0.4f\n\n',ACC2)


%% 3. Perceptron Training/Testing 2D


%3D Class
fprintf('2 Dimenstions\n\n')
learning_rate = 0.5;
class_out = output2d;
valin = data2d;

w = zeros(2,1);
%n = 10
for k = 1:100
     PredictedOutput_2d_n10 = zeros(10,1);
     for j = 1:10
          y = valin(j,1)*w(1,1) + valin(j,2)*w(2,1);
               
           %using a relu like activation function to scale values to 0 or
            %1
            if y < 0 
                PredictedOutput_2d_n10(j) = 0;
            else
                PredictedOutput_2d_n10(j) = 1;
            end
            
            diff = class_out(j) - PredictedOutput_2d_n10(j);
             
            w(1,1) = w(1,1)+learning_rate*valin(j,1)*diff;
         	w(2,1) = w(2,1)+learning_rate*valin(j,2)*diff;
            
      
     end
end


bsb = PredictedOutput_2d_n10 == class_out(1:10);
correct = sum(bsb == 1, 'all');
ACC = correct/length(PredictedOutput_2d_n10);
fprintf('The Accuracy after 100 iterations for 2D, N=10 is %0.4f\n',ACC)



%Testing 100 for n=10
for i = 1:100
    test_output2d_n10(i) = sign(w(1)*TestingSet(i,1) + w(2)*TestingSet(i,2));
end

b3b = test_output2d_n10 == TestingSet_Class2d;
correct2 = sum(b3b == 1, 'all');
ACC2 = correct2/100;
fprintf('The Accuracy after 100 iterations for 2D, N=10 on the testing set of N=100 is %0.4f\n\n',ACC2)


w = zeros(2,1);
%n = 20
for k = 1:100
     PredictedOutput_2d_n20 = zeros(20,1);
     for j = 1:20
          y = valin(j,1)*w(1,1) + valin(j,2)*w(2,1);
               
           %using a relu like activation function to scale values to 0 or
            %1
            if y < 0 
                PredictedOutput_2d_n20(j) = 0;
            else
                PredictedOutput_2d_n20(j) = 1;
            end
            
            diff = class_out(j) - PredictedOutput_2d_n20(j);
             
            w(1,1) = w(1,1)+learning_rate*valin(j,1)*diff;
         	w(2,1) = w(2,1)+learning_rate*valin(j,2)*diff;
            
      
     end
end


bsb = PredictedOutput_2d_n20 == class_out(1:20);
correct = sum(bsb == 1, 'all');
ACC = correct/length(PredictedOutput_2d_n20);
fprintf('The Accuracy after 100 iterations for 2D, N=20 is %0.4f\n',ACC)



%Testing 100 for n=20
for i = 1:100
    test_output2d_n20(i) = sign(w(1)*TestingSet(i,1) + w(2)*TestingSet(i,2));
end

b3b = test_output2d_n20 == TestingSet_Class2d;
correct2 = sum(b3b == 1, 'all');
ACC2 = correct2/100;
fprintf('The Accuracy after 100 iterations for 2D, N=20 on the testing set of N=100 is %0.4f\n\n',ACC2)


w = zeros(2,1);
%n = 50
for k = 1:100
     PredictedOutput_2d_n50 = zeros(50,1);
     for j = 1:50
          y = valin(j,1)*w(1,1) + valin(j,2)*w(2,1);
               
           %using a relu like activation function to scale values to 0 or
            %1
            if y < 0 
                PredictedOutput_2d_n50(j) = 0;
            else
                PredictedOutput_2d_n50(j) = 1;
            end
            
            diff = class_out(j) - PredictedOutput_2d_n50(j);
             
            w(1,1) = w(1,1)+learning_rate*valin(j,1)*diff;
         	w(2,1) = w(2,1)+learning_rate*valin(j,2)*diff;
            
      
     end
end


bsb = PredictedOutput_2d_n50 == class_out(1:50);
correct = sum(bsb == 1, 'all');
ACC = correct/length(PredictedOutput_2d_n50);
fprintf('The Accuracy after 100 iterations for 2D, N=50 is %0.4f\n',ACC)



%Testing 100 for n=10
for i = 1:100
    test_output2d_n50(i) = sign(w(1)*TestingSet(i,1) + w(2)*TestingSet(i,2));
end

b3b = test_output2d_n50 == TestingSet_Class2d;
correct2 = sum(b3b == 1, 'all');
ACC2 = correct2/100;
fprintf('The Accuracy after 100 iterations for 2D, N=50 on the testing set of N=100 is %0.4f\n\n',ACC2)



w = zeros(2,1);
%n = 100
for k = 1:100
     PredictedOutput_2d_n100 = zeros(100,1);
     for j = 1:100
          y = valin(j,1)*w(1,1) + valin(j,2)*w(2,1);
               
           %using a relu like activation function to scale values to 0 or
            %1
            if y < 0 
                PredictedOutput_2d_n100(j) = 0;
            else
                PredictedOutput_2d_n100(j) = 1;
            end
            
            diff = class_out(j) - PredictedOutput_2d_n100(j);
             
            w(1,1) = w(1,1)+learning_rate*valin(j,1)*diff;
         	w(2,1) = w(2,1)+learning_rate*valin(j,2)*diff;
            
      
     end
end


bsb = PredictedOutput_2d_n100 == class_out(1:100);
correct = sum(bsb == 1, 'all');
ACC = correct/length(PredictedOutput_2d_n100);
fprintf('The Accuracy after 100 iterations for 2D, N=100 is %0.4f\n',ACC)



%Testing 100 for n=100
for i = 1:100
    test_output2d_n100(i) = sign(w(1)*TestingSet(i,1) + w(2)*TestingSet(i,2));
end

b3b = test_output2d_n100 == TestingSet_Class2d;
correct2 = sum(b3b == 1, 'all');
ACC2 = correct2/100;
fprintf('The Accuracy after 100 iterations for 2D, N=100 on the testing set of N=100 is %0.4f\n\n',ACC2)



w = zeros(2,1);
%n = 200
for k = 1:100
     PredictedOutput_2d_n200 = zeros(200,1);
     for j = 1:200
          y = valin(j,1)*w(1,1) + valin(j,2)*w(2,1);
               
           %using a relu like activation function to scale values to 0 or
            %1
            if y < 0 
                PredictedOutput_2d_n200(j) = 0;
            else
                PredictedOutput_2d_n200(j) = 1;
            end
            
            diff = class_out(j) - PredictedOutput_2d_n200(j);
             
            w(1,1) = w(1,1)+learning_rate*valin(j,1)*diff;
         	w(2,1) = w(2,1)+learning_rate*valin(j,2)*diff;
            
      
     end
end


bsb = PredictedOutput_2d_n200 == class_out(1:200);
correct = sum(bsb == 1, 'all');
ACC = correct/length(PredictedOutput_2d_n200);
fprintf('The Accuracy after 100 iterations for 2D, N=200 is %0.4f\n',ACC)



%Testing 100 for n=200
for i = 1:100
    test_output2d_n200(i) = sign(w(1)*TestingSet(i,1) + w(2)*TestingSet(i,2));
end

b3b = test_output2d_n200 == TestingSet_Class2d;
correct2 = sum(b3b == 1, 'all');
ACC2 = correct2/100;
fprintf('The Accuracy after 100 iterations for 2D, N=200 on the testing set of N=100 is %0.4f\n\n',ACC2)



w = zeros(2,1);
%n = 1000
for k = 1:100
     PredictedOutput_2d_n1000 = zeros(1000,1);
     for j = 1:1000
          y = valin(j,1)*w(1,1) + valin(j,2)*w(2,1);
               
           %using a relu like activation function to scale values to 0 or
            %1
            if y < 0 
                PredictedOutput_2d_n1000(j) = 0;
            else
                PredictedOutput_2d_n1000(j) = 1;
            end
            
            diff = class_out(j) - PredictedOutput_2d_n1000(j);
             
            w(1,1) = w(1,1)+learning_rate*valin(j,1)*diff;
         	w(2,1) = w(2,1)+learning_rate*valin(j,2)*diff;
            
      
     end
end


bsb = PredictedOutput_2d_n1000 == class_out(1:1000);
correct = sum(bsb == 1, 'all');
ACC = correct/length(PredictedOutput_2d_n1000);
fprintf('The Accuracy after 100 iterations for 2D, N=1000 is %0.4f\n',ACC)



%Testing 100 for n=10
for i = 1:100
    test_output2d_n1000(i) = sign(w(1)*TestingSet(i,1) + w(2)*TestingSet(i,2));
end


b3b = test_output2d_n1000 == TestingSet_Class2d;
correct2 = sum(b3b == 1, 'all');
ACC2 = correct2/100;
fprintf('The Accuracy after 100 iterations for 2D, N=1000 on the testing set of N=100 is %0.4f\n\n',ACC2)

