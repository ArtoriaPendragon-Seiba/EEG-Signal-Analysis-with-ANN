clear ; close all; clc
input_layer_size  = 24;  % 24 Input 
hidden_layer_size = 1000;   % 12 hidden units
num_labels = 5;          % 10 labels, from 1 to 5   
load('P.mat');
load('Tz_o_n_f_s.mat');
[T val] = find(T5==1);
S = [P',T];
b=randperm(500);
S = S(b,:);
Xtrain = S(1:400,1:24);
Xval = S(401:end,1:24);
Ytrain = S(1:400,25);
Yval = S(401:end,25);
options = optimset('MaxIter', 300);
initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];
lambda = 0;
checkNNGradients;
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, Xtrain, Ytrain, lambda);
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));
predV = predict(Theta1, Theta2, Xval);
pred = predict(Theta1, Theta2, Xtrain);
fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == Ytrain)) * 100);
fprintf('\nValidation Set Accuracy: %f\n', mean(double(predV == Yval)) * 100);