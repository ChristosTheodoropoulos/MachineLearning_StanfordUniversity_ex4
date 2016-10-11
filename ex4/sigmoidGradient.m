function g = sigmoidGradient(z)
%SIGMOIDGRADIENT returns the gradient of the sigmoid function
%evaluated at z
%   g = SIGMOIDGRADIENT(z) computes the gradient of the sigmoid function
%   evaluated at z. This should work regardless if z is a matrix or a
%   vector. In particular, if z is a vector or matrix, you should return
%   the gradient for each element.

g = zeros(size(z));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the gradient of the sigmoid function evaluated at
%               each value of z (z can be a matrix, vector or scalar).


s1 = size(z,1);
s2 = size(z,2);

if (s1 == 1 && s2 ==1)
	g = sigmoid(z)*(1 - sigmoid(z));
else
	for i = 1:s1
		for j = 1:s2
			g(i,j) = sigmoid(z(i,j))*(1 - sigmoid(z(i,j)));
		end
	end
end












% =============================================================




end
