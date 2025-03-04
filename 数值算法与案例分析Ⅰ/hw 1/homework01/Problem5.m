x = zeros(1000, 1);
T = zeros(1000, 1);

% 计算每个 i 的 log(x) 和 log(T)
for i = 25:1000
    [A, b] = rand_generate(i);
    tStart = tic; % 记录开始时间
    Gauss_Elimination(i, A, b);
    x(i) = log(i);
    T(i) = log(toc(tStart)); % 计算经过的时间并存储在T(i)中
end

% 绘制 log(x) 与 log(T) 的关系图
figure;
plot(x(25:1000), T(25:1000));
xlabel('log(n)');
ylabel('log(T)');
title('Execution time of solving Ax=b by Gauss Elimination');
grid on;

function [A,b] = rand_generate(n)
    rng('shuffle');
    A = rand(n);
    b = rand(n, 1);
    while det(A) == 0
        A = rand(n);
    end
end

function Gauss_Elimination(n, A, b)
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
