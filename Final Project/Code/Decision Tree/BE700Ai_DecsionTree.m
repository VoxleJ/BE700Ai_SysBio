close all
clear all


load('humandatawithphenonolabel.mat');
diabdata = HumanDatawithPhenonolabels';


% diabdata(:,54685) = log(diabdata(:,54685));
for i = 1:54675
    diabdata(:,i) = log2(diabdata(:,i));
end



x = diabdata(:,54678); %ground truth class FH

%Insulin Sensitivity
% x = diabdata(:,54685);
% for i = 1:50
%     if x(i) > 4.1
%         x(i) = 1;
%     else
%         x(i) = 0;
%     end
% end
num_i = 10; % number of iterations to run decision tree model
M = (length(x)/100) * 70; % Ratio = 70% (training data)
diabdata_nophen = diabdata(:,1:54675);

maxAUC = 0;
maxACC = 0;
jklo = 0;

while maxAUC < 0.85
    for a = 1:num_i
        b1_tmpVec = randperm(size(x,1)); %random selection of values

        b1_x_train{a} = diabdata_nophen(b1_tmpVec(1:M),:);
        b1_y_train{a} = x(b1_tmpVec(1:M));

        b1_x_test{a} = diabdata_nophen(b1_tmpVec(M+1:end),:);

        b1_y_test{a} = x(b1_tmpVec(M+1:end));


   % Fit data to decision tree algorithm

        b1_model{a} = fitctree(b1_x_train{a} , b1_y_train{a});
        [~ , b1_y_prob{a}] = predict(b1_model{a}, b1_x_test{a});
        [~ , b1_y_pred{a}] = max(b1_y_prob{a}');

% Generate post-processing metrics

% AUC Score

        [b1_X{a} , b1_Y{a}, ~ , b1_AUC{a}] = ...
             perfcurve(b1_y_test{a} , b1_y_prob{a}(:,1) , 1);

        b1_y_test_array = double(b1_y_test{a});

% Model Accuracy , Error Rate , Sensitivity , Specificity

        b1_cp = classperf(b1_y_test_array);
        b1_cp = classperf(b1_cp , b1_y_pred{a});

        b1_modelAccuracy{a} = b1_cp.CorrectRate; % Accuracy
        b1_modelError{a} = b1_cp.ErrorRate; % Error Rate
        b1_modelSensitivity{a} = b1_cp.Sensitivity; % Sensitivity
        b1_modelSpecificity{a} = b1_cp.Specificity; % Specificity 
    end
%% Displaying Metrics
        b1_AUC_mean = mean(cell2mat(b1_AUC));
        b1_accuracy_mean = mean(cell2mat(b1_modelAccuracy));
        b1_error_mean = mean(cell2mat(b1_modelError));
        b1_sensitivity_mean = mean(cell2mat(b1_modelSensitivity));
        b1_specificity_mean = mean(cell2mat(b1_modelSpecificity));

        diary DecTreeBE700_human_FH085.txt
        diary on
        fprintf('Decision Tree Model 1 Average AUC = %0.3f\n' , b1_AUC_mean); 
        fprintf('Decision Tree Model 1 Average Accuracy = %0.3f\n' , b1_accuracy_mean);
        fprintf('Decision Tree Model 1 Average Error Rate = %0.3f\n' , b1_error_mean); 
        fprintf('Decision Tree Model 1 Average Sensitivity = %0.3f\n' , b1_sensitivity_mean);
        fprintf('Decision Tree Model 1 Average Specificity = %0.3f\n' , b1_specificity_mean);
        
        fprintf('\n\n')
        fprintf(' Best Values \n')

        b1MA_mat = cell2mat(b1_modelAccuracy);
        maxACC = max(b1MA_mat);
        maxloc = find(b1MA_mat == maxACC);
        %limit AUC
        b1MA_mat = cell2mat(b1_AUC);
        maxAUC = max(b1MA_mat);
        maxloc = find(b1MA_mat == maxAUC);
% 
        fprintf('\n')
        fprintf(' Best AUC: %0.3f\n ' , b1_AUC{1,maxloc})
        fprintf('Best ACC: %0.3f\n ' , b1_modelAccuracy{1,maxloc})
        fprintf('Best Error: %0.3f\n ' , b1_modelError{1,maxloc})
        fprintf('Best Sensitivity: %0.3f\n ' , b1_modelSensitivity{1,maxloc})
        fprintf('Best Specificity: %0.3f\n ' , b1_modelSpecificity{1,maxloc})
    
   

        for i = 1:length(maxloc)
            view(b1_model{1,maxloc(i)});
%         b1_model{1,maxloc(i)};

        end
    
        jklo = jklo + 1;


        completedataarray_AUC(jklo) = b1_AUC{1,maxloc};
        completedataarray_ACC(jklo) = b1_modelAccuracy{1,maxloc};
        completedataarray_ERR(jklo) = b1_modelError{1,maxloc};
        completedataarray_SENS(jklo) = b1_modelSensitivity{1,maxloc};
        completedataarray_SPEC(jklo) = b1_modelSpecificity{1,maxloc};
        completedataarray_TREE{jklo} = b1_model{1,maxloc(i)};
    
        if jklo == 1000
            break;
        end
end

fprintf('\n')

disp('Average Values of All Trees');

fprintf('Average AUC: %0.4f\n', mean(completedataarray_AUC))
fprintf('Average Accuracy: %0.4f\n', mean(completedataarray_ACC))
fprintf('Average Error: %0.4f\n', mean(completedataarray_ERR))
fprintf('Average Sensitivity: %0.4f\n', mean(completedataarray_SENS))
fprintf('Average Specificity: %0.4f\n', mean(completedataarray_SPEC))

fprintf('\n')

disp('Max AUC or Accuracy and Their Corresponding Trees/Values')

fprintf('\n')

fprintf('Max AUC: %0.4f\n', max(completedataarray_AUC))
maxAUC1500 = max(completedataarray_AUC);
maxloc1500 = find(completedataarray_AUC == maxAUC1500);
fprintf('ACC corresponding to Max AUC: %f\n', completedataarray_ACC(maxloc1500))
fprintf('ERR corresponding to Max AUC: %f\n', completedataarray_ERR(maxloc1500))
fprintf('SENS corresponding to Max AUC: %f\n', completedataarray_SENS(maxloc1500))
fprintf('SPEC corresponding to Max AUC: %f\n', completedataarray_SPEC(maxloc1500))

if length(maxloc1500) > 1 
    view(completedataarray_TREE{1,maxloc1500(1)})
else
    view(completedataarray_TREE{1,maxloc1500})
end


fprintf('\n')


fprintf('Max ACC: %0.4f\n', max(completedataarray_ACC))
maxACC1500 = max(completedataarray_ACC);
ACCmaxloc1500 = find(completedataarray_ACC == maxACC1500);
fprintf('AUC corresponding to Max ACC: %f\n', completedataarray_ACC(ACCmaxloc1500(1)))
fprintf('ERR corresponding to Max ACC: %f\n', completedataarray_ERR(ACCmaxloc1500(1)))
fprintf('SENS corresponding to Max ACC: %f\n', completedataarray_SENS(ACCmaxloc1500(1)))
fprintf('SPEC corresponding to Max ACC: %f\n', completedataarray_SPEC(ACCmaxloc1500(1)))
if length(ACCmaxloc1500) > 1 
    view(completedataarray_TREE{1,ACCmaxloc1500(1)})
else
    view(completedataarray_TREE{1,ACCmaxloc1500})
end


diary off
