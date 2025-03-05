function A = generate_cond_number_matrices(rows, cols, cond_number)
    % 生成指定条件数的复矩阵 A
    % m: 行数
    % n: 列数
    % cond_number: 指定的条件数

    % 生成一个随机的 m x n 的复矩阵
    % 先生成实部和虚部
    real_part = randn(rows, cols); % 生成随机实数
    imag_part = randn(rows, cols); % 生成随机虚数
    A_random = real_part + 1i * imag_part; % 合并成复数矩阵

    % 进行奇异值分解
    [U, ~, V] = svd(A_random, 'econ'); % 计算SVD，使用经济形式
    
    % 获取原始矩阵的奇异值
    s = diag(rand(cols, 1)); % 生成 n 个随机的奇异值
    s(1) = 1; % 设定第一个奇异值为 1
    s(end) = cond_number; % 设置最后一个奇异值为指定的条件数
    
    % 生成新的奇异值数组
    singular_values = linspace(1, cond_number, cols); % 从1到条件数生成 n 个奇异值
    
    % 生成新的对角矩阵 S
    S = diag(singular_values);
    
    % 生成新的矩阵 A
    A = U * S * V';
end