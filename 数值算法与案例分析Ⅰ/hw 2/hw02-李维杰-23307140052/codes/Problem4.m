T_1 = zeros(1000, 1);
T_2 = zeros(1000, 1);
% 计算每个 i 的 log(x) 和 log(T)
for i = 25:1000
    [A, b] = rand_generate(i);
    tStart = tic; % 记录开始时间
    Gauss_Elimination_all(i, A, b);
    x(i) = log(i);
    T_1(i) = log(toc(tStart)); % 计算经过的时间并存储在T_1(i)中
end

for i = 25:1000
    [A, b] = rand_generate(i);
    tStart = tic; % 记录开始时间
    Gauss_Elimination_part(i, A, b);
    x(i) = log(i);
    T_2(i) = log(toc(tStart)); % 计算经过的时间并存储在T_2(i)中
end

% 绘制 log(x) 与 log(T) 的关系图
figure;
plot(x(25:1000), T_1(25:1000), 'r', 'LineWidth', 0.1); % 绘制第一条曲线（红色）
hold on; % 保持当前图形
plot(x(25:1000), T_2(25:1000), 'b', 'LineWidth', 0.1); % 绘制第二条曲线（蓝色虚线）
xlabel('ln(n)');
ylabel('ln(T)');
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

function Gauss_Elimination_all(n, A, b)
    x = zeros(n, 1); 
    eps = 1e-7;

    % 行交换
    function Swap_row(p, q)
        temp_row = A(p, :);
        A(p, :) = A(q, :);
        A(q, :) = temp_row;
        temp_b = b(p);
        b(p) = b(q);
        b(q) = temp_b;
    end
    % 列交换
    function Swap_column(p, q)
        temp_column = A(:, p);
        A(:, p) = A(:, q);
        A(:, q) = temp_column;
    end
    %查找最大元素位置(p,q)
    function [p,q]=search(k)
        temp_max = 0;
        p = k ; q = k;
        for i = k : n
            for j = k : n
                if A(i ,j) > temp_max
                    temp_max = A(i ,j);
                    p = i ; q = j;
                end
            end
        end
    end

    % 高斯消元
    for i = 1:n-1
        [p,q]=search(i);
        Swap_row(i,p);
        Swap_column(i,q);
        if A(i,i) == 0
            return;
        else
            for j = i+1:n
                A(j, i+1:n) = A(j, i+1:n) - A(j, i) / A(i, i) * A(i, i+1:n);
                b(j) = b(j) - A(j, i) / A(i, i) * b(i);
            end
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

function Gauss_Elimination_part(n, A, b)
    x = zeros(n, 1); 
    eps = 1e-7;

    % 行交换
    function Swap_row(p, q)
        temp_row = A(p, :);
        A(p, :) = A(q, :);
        A(q, :) = temp_row;
        temp_b = b(p);
        b(p) = b(q);
        b(q) = temp_b;
    end
    %查找最大元素位置(p,q)
    function r = search(k)
        r = k;
        temp_max = 0;
        for i = k : n
            if A(i ,k) > temp_max
                temp_max = A(i ,k);
                r = i;
            end
        end
    end

    % 高斯消元
    for i = 1:n-1
        r = search(i);
        Swap_row(i,r);
        if A(i,i) == 0
            return;
        else
            for j = i+1:n
                A(j, i+1:n) = A(j, i+1:n) - A(j, i) / A(i, i) * A(i, i+1:n);
                b(j) = b(j) - A(j, i) / A(i, i) * b(i);
            end
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
