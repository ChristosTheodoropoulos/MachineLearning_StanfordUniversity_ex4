function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
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
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));


% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

% Computation of h, output layer

X = [ones(m, 1) X];

a1 = X;

z2 = a1 * Theta1';
a2 = sigmoid(z2);

m2 = size(a2, 1);
a2 = [ones(m2,1) a2];

z3 = a2 * Theta2';
a3 = sigmoid(z3);
h = a3;

% Format of table y to compute correctly the cost function

y_recode = zeros(input_layer_size,num_labels);

for i = 1:m
	if (y(i) == 10)
		y_recode(i,num_labels) = 1;
		for j = 1:num_labels
			if (j!=num_labels)
				y_recode(i,j) = 0;
			end
		end
	elseif (y(i) == 1)
		y_recode(i,1) = 1;
		for j = 2:num_labels
				y_recode(i,j) = 0;
		end
	elseif (y(i) == 2)
		y_recode(i,2) = 1;
		for j = 1:num_labels
			if (j!=2)
				y_recode(i,j) = 0;
			end
		end
	elseif (y(i) == 3)
		y_recode(i,3) = 1;
		for j = 1:num_labels
			if (j!=3)
				y_recode(i,j) = 0;
			end
		end
	elseif (y(i) == 4)
		y_recode(i,4) = 1;
		for j = 1:num_labels
			if (j!=4)
				y_recode(i,j) = 0;
			end
		end
	elseif (y(i) == 5)
		y_recode(i,5) = 1;
		for j = 1:num_labels
			if (j!=5)
				y_recode(i,j) = 0;
			end
		end
	elseif (y(i) == 6)
		y_recode(i,6) = 1;
		for j = 1:num_labels
			if (j!=6)
				y_recode(i,j) = 0;
			end
		end
	elseif (y(i) == 7)
		y_recode(i,7) = 1;
		for j = 1:num_labels
			if (j!=7)
				y_recode(i,j) = 0;
			end
		end
	elseif (y(i) == 8)
		y_recode(i,8) = 1;
		for j = 1:num_labels
			if (j!=8)
				y_recode(i,j) = 0;
			end
		end
	else (y(i) == 9)
		y_recode(i,9) = 1;
		for j = 1:num_labels
			if (j!=9)
				y_recode(i,j) = 0;
			end
		end
	end
end	


% Computation of cost function J

for i = 1:m
	for k = 1:num_labels
		J = J + ((-y_recode(i,k)*(log(h(i,k)))) - ((1-y_recode(i,k))*log(1-h(i,k))));
	end
end

J = J/m;	% with no regularization

sum1 = 0;
 
for j = 1:hidden_layer_size
	for k = 2:(input_layer_size + 1)	% dont iclude bias
		sum1 = sum1 + Theta1(j,k)^2;
	end
end

sum2 = 0;

for j = 1:num_labels
	for k = 2:(hidden_layer_size + 1)	% dont iclude bias
		sum2 = sum2 + Theta2(j,k)^2;
	end
end

J = J + (lambda/(2*m))*(sum1 + sum2);	% with regularization


% Implement the backpropagation

bigdelta1 = zeros(size(Theta1));
bigdelta2 = zeros(size(Theta2));

for t = 1:m
	% STEP1
	a1 = X(t,:);	% 1x401
	z2 = a1*Theta1';			% Theta1 --> 25x401, z2 --> 1x25
	a2 = sigmoid(z2);			% a2 --> 1x25
	m2 = size(a2, 1);
	a2 = [ones(m2,1) a2];		% a2 --> 1x26
	z3 = a2*Theta2';			% Theta2 --> 10x26, z3 --> 1x10
	a3 = sigmoid(z3);			% a3 --> 1x10
	
	% STEP2
	for j = 1:num_labels
		delta3(j) = a3(j) - y_recode(t,j);	%delta3 --> 1x10
	end

	% STEP3
	delta2 = (delta3 * Theta2) .* (a2.*(1-a2));		% delta2 --> 1x26

	% STEP4
	delta2 = delta2(2:end);		% delta2 --> 1x25
	%a1 = a1(1:end);				% a1 --> 1x400
	bigdelta1 = bigdelta1 + delta2'*a1;		% bigdelta1 --> 25x401
	bigdelta2 = bigdelta2 + delta3'*a2;		% bigdelta2 --> 10X26
end


% STEP5 
Theta1_grad = bigdelta1/m;		% 25x401		
Theta2_grad = bigdelta2/m;		% 10x26


% Adding regularization to gradient 

for i = 1:size(Theta1,1)
	for j = 2:size(Theta1,2)	% dont include first column (bias terms)
		Theta1_grad(i,j) = Theta1_grad(i,j) + (lambda/m)*Theta1(i,j);
	end
end

for i = 1:size(Theta2,1)
	for j = 2:size(Theta2,2)	% dont include first column (bias terms)
		Theta2_grad(i,j) = Theta2_grad(i,j) + (lambda/m)*Theta2(i,j);
	end
end

% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
