clear ; close all; clc
tic;
input_layer_size  = 30;  % 30 Input 
hidden_layer1_size = 4000;   % 4000 hidden layer 1 units
hidden_layer2_size = 200;    % 100 hidden layer 2 units
num_labels = 5;          % 5 labels, from 1 to 5   
load('P.mat');
load('Tz_o_n_f_s.mat');
[T val] = find(T5==1); % 1 ==   F (seizure-free same hemisphere)
                       % 2 ==   N (seizure-fre opposite hemisphere)
                       % 3 ==   O (healthy people with eyes closed)
                       % 4 ==   S (ictal activity)
                       % 5 ==   Z (healthy people with eyes open)
S = [P',T];
b=randperm(500);
S = S(b,:);
Xtrain = S(1:400,1:30);
Xval = S(401:end,1:30);
Ytrain = S(1:400,31);
Yval = S(401:end,31);
options = optimset('MaxIter', 400);

TotalTrainingAccuracy = zeros(10,1);
TotalValidationAccuracy = zeros(10,1);

%for i = 1:10

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer1_size);
initial_Theta2 = randInitializeWeights(hidden_layer1_size, hidden_layer2_size);
initial_Theta3 = randInitializeWeights(hidden_layer2_size, num_labels);

initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:) ; initial_Theta3(:)];
lambda = 1.5;
%checkNNGradients;
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer1_size, ...
                                   hidden_layer2_size, ...
                                   num_labels, Xtrain, Ytrain, lambda);
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);
Theta1 = reshape(nn_params(1:hidden_layer1_size * (input_layer_size + 1)), ...
                 hidden_layer1_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer1_size * (input_layer_size + 1))): ...
                ((hidden_layer1_size * (input_layer_size + 1)) + (hidden_layer2_size * (hidden_layer1_size + 1)))), ...
                hidden_layer2_size , (hidden_layer1_size + 1));

Theta3 = reshape(nn_params((1 + (hidden_layer1_size * (input_layer_size + 1))+ hidden_layer2_size * (hidden_layer1_size + 1)) : end), ...
                num_labels, (hidden_layer2_size +1));
            
predV = predict(Theta1, Theta2, Theta3, Xval);
pred = predict(Theta1, Theta2, Theta3, Xtrain);

%TotalTrainingAccuracy(i) = mean(double(pred == Ytrain)) * 100;
%TotalValidationAccuracy(i) = mean(double(predV == Yval)) * 100;
fprintf('\nTraining Set Accuracy with lambda equals to %f: %f\n', lambda , mean(double(pred == Ytrain)) * 100);
fprintf('\nValidation Set Accuracy with lambda equals to %f: %f\n', lambda , mean(double(predV == Yval)) * 100);
%end
%fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == Ytrain)) * 100);
%fprintf('\nValidation Set Accuracy: %f\n', mean(double(predV == Yval)) * 100);
fprintf('\nMean Training Set Accuracy: %f\n', mean(TotalTrainingAccuracy) );
fprintf('\nMean Validation Set Accuracy: %f\n', mean(TotalValidationAccuracy));
fprintf('\nthe training process takes %f second\n',toc);
