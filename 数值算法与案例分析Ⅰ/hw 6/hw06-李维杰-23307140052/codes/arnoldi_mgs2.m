function [Q, H] = arnoldi_mgs2(A, b, n)
    % n 是迭代次数

    % 初始化 Q 矩阵和 R 矩阵
    Q = zeros(size(A, 1), n);
    H = zeros(n+1, n);
    Q(:, 1) = b / norm(b, 2);

    for j = 1:n
        % 更新下一个初始矩阵列向量
        b = A * Q(:, j);

        % 正交化
        for i = 1:j
            H(i, j) = b' * Q(:, i); % 计算 H(i,j)
            b = b - H(i, j) * Q(:, i); % 正交化
        end

        % 重正交化
        for i = 1:j
            H(i, j) = b' * Q(:, i); % 计算 H(i,j)
            b = b - H(i, j) * Q(:, i); % 正交化
        end

        H(j+1, j) = norm(b, 2);
        if H(j+1, j) < 1e-6
            return;
        end
        Q(:, j+1) = b / H(j+1, j);
    end
end