function [eigen_lambda, eigen_x, k, loss]= power_method(A, x)
    standard_lambda = max(eig(A));
    standard_x = null(A - standard_lambda * eye(size(A)));
    standard_x = standard_x / norm(standard_x);
    k = zeros(20, 1);
    loss = zeros(20, 1);
    x = x / norm(x);
    for i = 1:20
        x = A * x;
        x = x / norm(x);
        k(i) = i;
        loss(i) = min(norm(x - standard_x), norm(x + standard_x));
    end
    eigen_x = x;
    eigen_lambda = (x' * A * x) / norm(x)^2;
end