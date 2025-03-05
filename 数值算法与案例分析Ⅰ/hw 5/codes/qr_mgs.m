function [Q, R] = qr_mgs(A)
    % 获取矩阵 A 的大小
    [m, n] = size(A);
    
    % 初始化 Q 矩阵和 R 矩阵
    Q = zeros(m, n);
    R = zeros(n, n);

    % 进行 MGS 处理
    for i = 1:n
        % Q 预设为 A
        Q(:, i) = A(:, i);
    end

    for i = 1:n      
        % 计算 R(i,i) 的值
        R(i, i) = norm(Q(:, i), 2);

        % 归一化 Q 的第 i 行
        if R(i, i) > 1e-7
            Q(:, i) = Q(:, i) / R(i, i);
        end

        % 对之后的列进行正交化
        for j = i+1:n
            R(i, j) = Q(:, i)' * Q(:, j); % 计算 R(i,j)
            Q(:, j) = Q(:, j) - R(i, j) * Q(:, i); % 正交化
        end
    end
end