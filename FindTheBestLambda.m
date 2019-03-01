function BestLambda = FindTheBestLambda(IPLU,hlu1,hlu2,nml,Xtrain,Ytrain,Xval,Yval)
%FINDTHEBESTLAMBDA Summary of this function goes here
%   Detailed explanation goes here

options = optimset('MaxIter', 300);
TotalTrainingAccuracy = zeros(20,1);
TotalValidationAccuracy = zeros(20,1);

initial_Theta1 = randInitializeWeights(IPLU, hlu1);
initial_Theta2 = randInitializeWeights(hlu1, hlu2);
initial_Theta3 = randInitializeWeights(hlu2, nml);

for i = 1:20
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:) ; initial_Theta3(:)];


lambda = 0.1 * i;
costFunction = @(p) nnCostFunction(p, ...
                                   IPLU, ...
                                   hlu1, ...
                                   hlu2, ...
                                   nml, Xtrain, Ytrain, lambda);
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);
Theta1 = reshape(nn_params(1:hlu1 * (IPLU + 1)), ...
                 hlu1, (IPLU + 1));

Theta2 = reshape(nn_params((1 + (hlu1 * (IPLU + 1))): ...
                ((hlu1 * (IPLU + 1)) + (hlu2 * (hlu1 + 1)))), ...
                hlu2 , (hlu1 + 1));

Theta3 = reshape(nn_params((1 + (hlu1 * (IPLU + 1))+ hlu2 * (hlu1 + 1)) : end), ...
                nml, (hlu2 +1));
            
predV = predict(Theta1, Theta2, Theta3, Xval);
pred = predict(Theta1, Theta2, Theta3, Xtrain);

TotalTrainingAccuracy(i) = mean(double(pred == Ytrain)) * 100;
TotalValidationAccuracy(i) = mean(double(predV == Yval)) * 100;
end
[val, p] = max((TotalValidationAccuracy + TotalTrainingAccuracy)./2);
BestLambda = p * 0.1; 
end

