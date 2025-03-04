function [x, err] = GMRES(A, b, x0, n)
    err = ones(n, 1);
    Q = zeros(length(b), n);
    H = zeros(n+1, n);

    r = b - A * x0;
    Q(:, 1) = r / norm(r, 2);
    e = zeros(n+1, 1);
    e(1) = norm(r, 2);
        
    for i = 1:n
        w = A * Q(:, i);
        for j = 1:i
            H(j, i) = Q(:, j)' * w;
            w = w - H(j, i) * Q(:, j);
        end

        H(i+1, i) = norm(w, 2);
        if H(i+1, i) < 1e-6
            break;
        end
        Q(:, i+1) = w / H(i+1, i);

        y = H(1:i+1, 1:i) \ e(1:i+1);
        x = x0 + Q(:, 1:i) * y;
        err(i) = norm(b - A * x, 2) / e(1);
        if err(i) < 1e-6
            break;
        end
    end
    y = H(1:i+1, 1:i) \ e(1:i+1);
    x = x0 + Q(:, 1:i) * y;
    err(i) = norm(b - A * x, 2) / e(1);
end