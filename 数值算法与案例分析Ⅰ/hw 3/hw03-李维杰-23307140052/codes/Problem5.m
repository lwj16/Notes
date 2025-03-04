format long;
A = zeros(100);
b = zeros(100, 1);

[A,b] = case_1();
x_11 = zeros(100, 1);
x_12 = zeros(100, 1);
x_11 = gaussian_elimination_partial_pivoting(A, b);
x_12 = Gauss_Elimination_without_pivoting(100, A, b);
d_11 = max(abs(x_11(1:100)-1));
d_12 = max(abs(x_12(1:100)-1));

[A,b] = case_2();
x_21 = zeros(100, 1);
x_22 = zeros(100, 1);
x_21 = gaussian_elimination_partial_pivoting(A, b);
x_22 = Gauss_Elimination_without_pivoting(100, A, b);
d_21 = max(abs(x_21(1:100)-1));
d_22 = max(abs(x_22(1:100)-1));

function [A,b] = case_1()
    A = zeros(100);
    b = zeros(100, 1);
    for i = 1:100
        if i > 1
            A(i, i - 1) = 6;
        end
        A(i, i) = 8;
        if i < 100
            A(i, i + 1) = 1;
        end
    end
    b(1) = 9;
    b(100) = 14;
    for j = 2:99
        b(j) = 15;
    end
end

function [A,b] = case_2()
    A = zeros(100);
    b = zeros(100, 1);
    for i = 1:100
        if i > 1
            A(i, i - 1) = 8;
        end
        A(i, i) = 6;
        if i < 100
            A(i, i + 1) = 1;
        end
    end
    b(1) = 7;
    b(100) = 14;
    for j = 2:99
        b(j) = 15;
    end
end

function x = gaussian_elimination_partial_pivoting(A, b)
    % 高斯消元法求解线性方程组 Ax = b
    % 输入：A - 系数矩阵, b - 右侧向量
    % 输出：x - 解向量

    % 获取矩阵A的规模
    [n, m] = size(A);
    
    % 将b与A合并为增广矩阵
    AugmentedMatrix = [A, b];
    
    % 前向消元
    for i = 1:n
        % 找到主元素并进行行交换
        [~, maxIndex] = max(abs(AugmentedMatrix(i:n, i)));
        maxIndex = maxIndex + i - 1;
        if maxIndex ~= i
            AugmentedMatrix([i, maxIndex], :) = AugmentedMatrix([maxIndex, i], :);
        end
        
        % 消元过程
        for j = i+1:n
            factor = AugmentedMatrix(j, i) / AugmentedMatrix(i, i);
            AugmentedMatrix(j, :) = AugmentedMatrix(j, :) - factor * AugmentedMatrix(i, :);
        end
    end
    
    % 回代过程
    x = zeros(n, 1);
    for i = n:-1:1
        % 执行回代
        x(i) = (AugmentedMatrix(i, end) - AugmentedMatrix(i, 1:n) * x) / AugmentedMatrix(i, i);
    end
end

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