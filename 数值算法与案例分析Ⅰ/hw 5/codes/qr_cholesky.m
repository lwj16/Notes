function [Q, R] = qr_cholesky(A)
    [m, n] = size(A);

   % 计算 A^T * A
    ATA = A' * A;

    % 进行 Cholesky 分解
    R = chol(ATA);  % R 是上三角矩阵

    % 初始化 Q 矩阵
    Q = zeros(m, n);

    % 计算 Q 矩阵
    for j = 1:n
        % 计算 Q 的列向量
        v = A(:, j);
        for i = 1:j-1
            % 计算投影
            v = v - (Q(:, i)' * A(:, j)) * Q(:, i);
        end
        % 归一化得到 Q 的列
        Q(:, j) = v / norm(v);
    end

    % 计算 R 矩阵
    R = Q' * A;
end