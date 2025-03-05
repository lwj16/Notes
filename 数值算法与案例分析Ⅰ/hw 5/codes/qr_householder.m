function [Q, R] = qr_householder(A)
    % 获取矩阵 A 的大小
    [m, n] = size(A);
    
    % 初始化 Q 矩阵和 R 矩阵
    R = A;
    Q = eye(m);  % 初始化 Q 为单位矩阵
    
    % 进行 Householder 变换
    for k = 1:n
        % 计算 x 和 v
        x = R(k:m, k);  % 取 R 的第 k 列从第 k 行到第 m 行
        e1 = zeros(length(x), 1);
        e1(1) = 1;  % 创建一个标准基向量
        
        % 计算 Householder 向量 v
        v = sign(x(1)) * norm(x) * e1 + x;
        v = v / norm(v);  % 归一化 v
        
        % 更新 R 矩阵
        R(k:m, k:n) = R(k:m, k:n) - 2 * v * (v' * R(k:m, k:n));
        
        % 更新 Q 矩阵
        Q_k = eye(m);  % 创建单位矩阵
        Q_k(k:m, k:m) = eye(length(v)) - 2 * (v * v');  % Householder 反射矩阵
        Q = Q * Q_k;  % 更新 Q
    end
end