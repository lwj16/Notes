function [Q, R, loss_cho, obj] = qr_cholesky(A)
    % 计算 A^* A
    A_star_A = A' * A;
    
    % 进行 Cholesky 分解
    L = cholesky(A_star_A);
    
    % 计算 R
    R = L';
    
    % 初始化 Q
    [m, n] = size(A);
    B = zeros(n);
    B = A';
    Q = zeros(m, n);
    
    % 计算 Q
    for j = 1:n
        % 解 L*y = A'*(:, j)
        aj = B(:, j);  % 使用 A' 的列索引
        y = L \ aj;
        
        % 归一化
        Q(:, j) = y / norm(y);
    end
    
    % 计算损失
    obj = zeros(n);
    obj = Q' * Q - eye(n);
    loss_cho = norm(obj, 'fro');
end

function L = cholesky(A)    
    % 获取矩阵大小
    n = size(A, 1);
    L = zeros(n);  % 初始化下三角矩阵

    for i = 1:n
        % 计算 L_{ii}
        sum1 = sum(L(i, 1:i-1).^2);
        L(i,i) = sqrt(A(i,i) - sum1);
        
        for j = i+1:n
            % 计算 L_{ji}
            sum2 = sum(L(j, 1:i-1) .* L(i, 1:i-1));
            L(j,i) = (A(j,i) - sum2) / L(i,i);
        end
    end
end