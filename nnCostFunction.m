function [J, grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer1_size, ...
                                   hidden_layer2_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer1_size * (input_layer_size + 1)), ...
                 hidden_layer1_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer1_size * (input_layer_size + 1))): ...
                ((hidden_layer1_size * (input_layer_size + 1)) + (hidden_layer2_size * (hidden_layer1_size + 1)))), ...
                hidden_layer2_size , (hidden_layer1_size + 1));

Theta3 = reshape(nn_params((1 + (hidden_layer1_size * (input_layer_size + 1))+ hidden_layer2_size * (hidden_layer1_size + 1)) : end), ...
                num_labels, (hidden_layer2_size +1));
            
m = size(X, 1);
         
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));
Theta3_grad = zeros(size(Theta3));

a1 = [ones(m,1),X];
z2 = a1 * Theta1';
a2 = sigmoid(z2);
a2 = [ones(size(a2,1),1),a2];
z3 = a2 * Theta2';
a3 = sigmoid(z3);
a3 = [ones(size(a3,1),1),a3];
z4 = a3 * Theta3';
a4 = sigmoid(z4);

yVec = zeros(m,num_labels);
for i = 1:m
    yVec(i,y(i)) = 1;
end

    J = sum(sum(-yVec .* log(a4)) - sum((1-yVec).* log(1 - a4)))/m;

    Theta1r = Theta1(:,2:end);
    Theta2r = Theta2(:,2:end);
    Theta3r = Theta3(:,2:end);
    regulation = (sum(sum(Theta1r.^2)) + sum(sum(Theta2r.^2)) +sum(sum(Theta3r.^2))) * lambda / (2 * m);

    J = J + regulation;

for i = 1:m
    a1 = [1,X(i,:)];
    a1 = a1';
    z2 = Theta1 * a1;
    a2 = [1;sigmoid(z2)];
    z3 = Theta2 * a2;
    a3 = [1;sigmoid(z3)];
    z4 = Theta3 * a3;
    a4 = sigmoid(z4);
    
    yk = zeros(num_labels,1);
    yk(y(i)) = 1;
    %yk = ([1:num_labels]==y(i))';
    delta4 = a4 - yk;
    delta3 = (Theta3' * delta4) .* [1; sigmoidGradient(z3)];
    delta3 = delta3(2:end);
    delta2 = (Theta2' * delta3) .* [1; sigmoidGradient(z2)];
    delta2 = delta2(2:end);
    Theta1_grad = Theta1_grad + delta2 * a1';
    Theta2_grad = Theta2_grad + delta3 * a2';
    Theta3_grad = Theta3_grad + delta4 * a3';
end
    Theta1_grad = Theta1_grad / m + lambda * [zeros(size(Theta1,1),1), Theta1(:,2:end)]/m;
    Theta2_grad = Theta2_grad / m + lambda * [zeros(size(Theta2,1),1), Theta2(:,2:end)]/m;
    Theta3_grad = Theta3_grad / m + lambda * [zeros(size(Theta3,1),1), Theta3(:,2:end)]/m;

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:) ; Theta3_grad(:)];



end
