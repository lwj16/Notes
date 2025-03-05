function [A, Q] = Householder_Hessenberg(A)
    [n, ~] = size(A);
    Q = eye(n);
    for i = 1:n-2
        x = A(1+i:n, i);
        e = zeros(n - i, 1);
        e(1) = sign(x(1)) * norm(x, 2);
        w = x + e;
        w = w / norm(w, 2);
        
        A(i+1:n, i:n) = A(i+1:n, i:n) - 2 * w * (w' * A(i+1:n, i:n));
        A(:, i+1:n) = A(:, i+1:n) - 2 * (A(:, i+1:n) * w) * w';
        Q(i+1:n, :) = Q(i+1:n, :) - 2 * w * (w' * Q(i+1:n, :));
    end
end