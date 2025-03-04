function [Q, A] = Householder_Hessenberg(A)
    [n, n] = size(A);
    Q = eye(n);
    for i = 1:n-2
        x = A(1+i:n, i);
        e = zeros(n - i, 1);
        e(1) = sign(x(1)) * norm(x, 2);
        w = x + e;
        w = w / norm(w, 2);
        H = (eye(n - i) - 2 * (w * w'));
        
        A(i+1:n, i:n) = H * A(i+1:n, i:n);
        A(1:n, i+1:n) = A(1:n, i+1:n) * H';
        Q(i+1:n, 1:n) = H * Q(i+1:n, 1:n);
    end
    Q = Q';
end