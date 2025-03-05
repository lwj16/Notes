function [Q, R] = qr_cgs(A)
    % 获取矩阵 A 的大小
    [m, n] = size(A);
    
    % 初始化 Q 矩阵和 R 矩阵
    Q = zeros(m, n);
    R = zeros(n, n);
    
    % 进行 CGS 算法的 QR 分解
    for j = 1:n
        % Q 预设为 A
        Q(:, j) = A(:, j);
        
        % 计算 R 的第 j 行
        for i = 1:j-1
            R(i, j) = Q(:, i)' * A(:, j);
            Q(:, j) = Q(:, j) - R(i, j) * Q(:, i);
        end
        
        % 计算 R 的对角元素
        R(j, j) = norm(Q(:, j), 2);
        
        % 归一化 Q 的第 j 列
        if R(j, j) > 1e-7
            Q(:, j) = Q(:, j) / R(j, j);
        end
    end
end