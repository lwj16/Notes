function [x, iter] = SD(A, b,  x0, maxiter)
    x = zeros(2, maxiter + 1);
    x(:, 1) = x0;
    for iter = 1:maxiter
        r = b - A * x(:, iter);
        alpha = (r' * r) / (r' * A * r);
        x(:, iter + 1) = x(:, iter) + alpha * r;
    end
end