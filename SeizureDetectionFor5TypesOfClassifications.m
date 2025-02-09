clear ; close all; clc
tic;
input_layer_size  = 30;  % 30 Input 
hidden_layer1_size = 4000;   % 4000 hidden layer 1 units
hidden_layer2_size = 200;    % 200 hidden layer 2 units
num_labels = 2;          % 5 labels, from 1 to 2   
load('P.mat');
load('Tz_o_n_f_s.mat');
[T val] = find(T5==1); 
T(T ~= 4) = 1;         % 1 ==   Z, F, N, O  (NO seizure)
T(T == 4) = 2;         % 2 ==   S (ictal activity)
S = [P',T];
b=randperm(500);
S = S(b,:);
Xtrain = S(1:400,1:30);
Xval = S(401:end,1:30);
Ytrain = S(1:400,31);
Yval = S(401:end,31);
options = optimset('MaxIter', 350);

tb = toc;

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer1_size);
initial_Theta2 = randInitializeWeights(hidden_layer1_size, hidden_layer2_size);
initial_Theta3 = randInitializeWeights(hidden_layer2_size, num_labels);

initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:) ; initial_Theta3(:)];


ts = toc;
lambda = 0.56;

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


fprintf('\nTraining Set Accuracy(ZFNO_S): %f\n', mean(double(pred == Ytrain)) * 100);
fprintf('\nValidation Set Accuracy(ZFNO_S): %f\n', mean(double(predV == Yval)) * 100);
[macroF1, microF1] = F1score(predV,Yval);
fprintf('\nmacroF1 score is %f, microF1 score is %f', macroF1,microF1);
save('ZFNO_S_MODEL');


%------------------------------------------------------------------------------

clear ; 
tic;
input_layer_size  = 30;  % 30 Input 
hidden_layer1_size = 4000;   % 4000 hidden layer 1 units
hidden_layer2_size = 200;    % 200 hidden layer 2 units
num_labels = 5;          % 5 labels, from 1 to 2   
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

tb = toc;

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer1_size);
initial_Theta2 = randInitializeWeights(hidden_layer1_size, hidden_layer2_size);
initial_Theta3 = randInitializeWeights(hidden_layer2_size, num_labels);

initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:) ; initial_Theta3(:)];


ts = toc;
lambda = 1.65;

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


fprintf('\nTraining Set Accuracy(5CLASSES): %f\n', mean(double(pred == Ytrain)) * 100);
fprintf('\nValidation Set Accuracy(5CLASSES): %f\n', mean(double(predV == Yval)) * 100);
save('5classes_model');
[macroF1, microF1] = F1score(predV,Yval);
fprintf('\nmacroF1 score is %f, microF1 score is %f', macroF1,microF1);
%------------------------------------------------------------------------------

clear ; 
tic;
input_layer_size  = 30;  % 30 Input 
hidden_layer1_size = 4000;   % 4000 hidden layer 1 units
hidden_layer2_size = 200;    % 200 hidden layer 2 units
num_labels = 3;          % 5 labels, from 1 to 2   
load('P.mat');
load('Tz_o_n_f_s.mat');
[T val] = find(T5==1); % 1 ==   F (seizure-free same hemisphere)
                       % 2 ==   N (seizure-free opposite hemisphere)
                       % 3 ==   O (healthy people with eyes closed)
                       % 4 ==   S (ictal activity)
                       % 5 ==   Z (healthy people with eyes open)
T(T == 1 | T == 2) = 1;         % 1 ==   F, N  (seizure-free patients)
T(T == 3 | T == 5) = 2;         % 2 ==   O,Z (healthy people)
T(T == 4) = 3;                   % 3 == S (ictal activity)
S = [P',T];
b=randperm(500);
S = S(b,:);
Xtrain = S(1:400,1:30);
Xval = S(401:end,1:30);
Ytrain = S(1:400,31);
Yval = S(401:end,31);
options = optimset('MaxIter', 350);

tb = toc;

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer1_size);
initial_Theta2 = randInitializeWeights(hidden_layer1_size, hidden_layer2_size);
initial_Theta3 = randInitializeWeights(hidden_layer2_size, num_labels);

initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:) ; initial_Theta3(:)];


ts = toc;
lambda = 0.7;

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


fprintf('\nTraining Set Accuracy(FNOZS): %f\n', mean(double(pred == Ytrain)) * 100);
fprintf('\nValidation Set Accuracy(FNOZS): %f\n', mean(double(predV == Yval)) * 100);
save('FN_OZ_S_MODEL');
[macroF1, microF1] = F1score(predV,Yval);
fprintf('\nmacroF1 score is %f, microF1 score is %f', macroF1,microF1);
%------------------------------------------------------------------------------

clear ; 
tic;
input_layer_size  = 30;  % 30 Input 
hidden_layer1_size = 4000;   % 4000 hidden layer 1 units
hidden_layer2_size = 200;    % 200 hidden layer 2 units
num_labels = 2;          % 2 labels, from 1 to 2   
load('P.mat');
load('Tz_o_n_f_s.mat');
[T val] = find(T5==1); % 1 ==   F (seizure-free same hemisphere)
                       % 2 ==   N (seizure-free opposite hemisphere)
                       % 3 ==   O (healthy people with eyes closed)
                       % 4 ==   S (ictal activity)
                       % 5 ==   Z (healthy people with eyes open)
T(T ~= 4 & T ~= 5) = 0;
T(T == 5) = 1;         % 1 ==   Z (healthy people)
T(T == 4) = 2;                   % 2 == S (ictal activity)
S = [P',T];
x = find(S(:,31)==0);
S(x,:) = [];
b=randperm(200);
S = S(b,:);
Xtrain = S(1:160,1:30);
Xval = S(161:end,1:30);
Ytrain = S(1:160,31);
Yval = S(161:end,31);
options = optimset('MaxIter', 350);

tb = toc;

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer1_size);
initial_Theta2 = randInitializeWeights(hidden_layer1_size, hidden_layer2_size);
initial_Theta3 = randInitializeWeights(hidden_layer2_size, num_labels);

initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:) ; initial_Theta3(:)];


ts = toc;
lambda = 1.1;

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


fprintf('\nTraining Set Accuracy(ZS): %f\n', mean(double(pred == Ytrain)) * 100);
fprintf('\nValidation Set Accuracy(ZS): %f\n', mean(double(predV == Yval)) * 100);
[macroF1, microF1] = F1score(predV,Yval);
fprintf('\nmacroF1 score is %f, microF1 score is %f', macroF1,microF1);
save('Z_S_MODEL');

%------------------------------------------------------------------------------

clear ; 
tic;
input_layer_size  = 30;  % 30 Input 
hidden_layer1_size = 4000;   % 4000 hidden layer 1 units
hidden_layer2_size = 200;    % 200 hidden layer 2 units
num_labels = 3;          % 2 labels, from 1 to 2   
load('P.mat');
load('Tz_o_n_f_s.mat');
[T val] = find(T5==1); % 1 ==   F (seizure-free same hemisphere)
                       % 2 ==   N (seizure-free opposite hemisphere)
                       % 3 ==   O (healthy people with eyes closed)
                       % 4 ==   S (ictal activity)
                       % 5 ==   Z (healthy people with eyes open)
T(T == 3 | T == 2) = 0;
T(T == 5) = 1;         % 1 ==   Z (healthy people)
T(T == 1) = 2;         % 2 ==   F (seizure-free same hemisphere)
T(T == 4) = 3;         % 3 == S (ictal activity)

S = [P',T];
x = find(S(:,31)==0);
S(x,:) = [];
b=randperm(300);
S = S(b,:);
Xtrain = S(1:240,1:30);
Xval = S(241:end,1:30);
Ytrain = S(1:240,31);
Yval = S(241:end,31);
options = optimset('MaxIter', 350);

tb = toc;

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer1_size);
initial_Theta2 = randInitializeWeights(hidden_layer1_size, hidden_layer2_size);
initial_Theta3 = randInitializeWeights(hidden_layer2_size, num_labels);

initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:) ; initial_Theta3(:)];


ts = toc;
lambda = 0.8;

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


fprintf('\nTraining Set Accuracy(ZFS): %f\n', mean(double(pred == Ytrain)) * 100);
fprintf('\nValidation Set Accuracy(ZFS): %f\n', mean(double(predV == Yval)) * 100);
save('Z_F_S_MODEL1');
[macroF1, microF1] = F1score(predV,Yval);
fprintf('\nmacroF1 score is %f, microF1 score is %f', macroF1,microF1);