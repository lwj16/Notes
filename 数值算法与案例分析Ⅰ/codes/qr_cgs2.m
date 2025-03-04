function [Q, R] = qr_cgs2(A)
    % 获取矩阵 A 的大小
    [m, n] = size(A);
    
    % 初始化 Q 矩阵和 R 矩阵
    Q = zeros(m, n);
    R = zeros(n, n);
    
    % 进行 CGS 算法的 QR 分解
    for j = 1:n
        % Q 预设为 A
        Q(:, j) = A(:, j);
        
        % 正交化
        for i = 1:j-1
            R(i, j) = Q(:, i)' * A(:, j);
            Q(:, j) = Q(:, j) - R(i, j) * Q(:, i);
        end

        % 重正交化
        for i = 1:j-1
            R(i, j) = Q(:, i)' * Q(:, j);  % 计算重正交化投影系数
            Q(:, j) = Q(:, j) - R(i, j) * Q(:, i);  % 重正交化
        end
        
        % 归一化
        R(j, j) = norm(Q(:, j));
        if R(j, j) > 1e-7
            Q(:, j) = Q(:, j) / R(j, j);  % 单位化
        end
    end
end