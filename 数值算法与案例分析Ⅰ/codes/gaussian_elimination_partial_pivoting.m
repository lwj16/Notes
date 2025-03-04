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