function x = Gauss_Elimination_without_pivoting(n, A, b)
    x = zeros(n, 1);  
    eps = 1e-7;

    % 行交换
    function Swap(p, q)
        temp_row = A(p, :);
        A(p, :) = A(q, :);
        A(q, :) = temp_row;
        temp_b = b(p);
        b(p) = b(q);
        b(q) = temp_b;
    end

    % 高斯消元
    for i = 1:n-1
        t = i;
        while abs(A(t, i)) < eps && t <= n
            t = t + 1;
        end
        if t > n
            return; % 如果没有解，则直接返回
        end
        if t > i
            Swap(i, t);
        end
        for j = i+1:n
            A(j, i+1:n) = A(j, i+1:n) - A(j, i) / A(i, i) * A(i, i+1:n);
            b(j) = b(j) - A(j, i) / A(i, i) * b(i);
        end
    end

    % 回带求解
    for i = n:-1:1
        if abs(A(i, i)) < eps
            return; % 如果没有解，则直接返回
        end
        x(i) = b(i) / A(i, i);
        for j = i+1:n
            x(i) = x(i) - A(i, j) / A(i, i) * x(j);
        end
    end
end