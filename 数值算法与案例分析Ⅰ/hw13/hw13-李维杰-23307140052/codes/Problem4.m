n = 4000;
N = n;
m = 50;
shape = [n, n];

coords = randperm(n * n, N);       % 随机选择N个非零元素的索引
[i, j] = ind2sub(shape, coords);  % 将线性索引转为矩阵索引
values = rand(1, N);               % 随机生成N个非零值
A_sparse = sparse(i, j, values, n, n);  % 构造稀疏矩阵
A_sparse = A_sparse + A_sparse';   % 保证矩阵对称


[V, mdiag, sdiag] = lanczos(A_sparse, m);

% 可视化Lanczos向量的正交性
vis_ortho(V);

% 可视化Ritz值的收敛性
vis_ritz(A_sparse);

function [V, mdiag, sdiag] = lanczos(A, m)    
    n = size(A, 1);
    q0 = rand(n, 1);
    q0 = q0 / norm(q0);
    
    V = zeros(n, m + 1);
    V(:, 1) = q0;
    
    mdiag = zeros(m, 1);  % 存储对角线元素
    sdiag = zeros(m, 1);  % 存储次对角线元素
    
    for j = 1:m
        if j > 1
            V(:, j + 1) = A * V(:, j) - sdiag(j - 1) * V(:, j - 1);  % 计算新的向量
        else
            V(:, j + 1) = A * V(:, j);  % 对第一个向量的处理
        end
        
        mdiag(j) = V(:, j + 1)' * V(:, j);  % 计算对角线元素
        V(:, j + 1) = V(:, j + 1) - mdiag(j) * V(:, j);  % 正交化
        
        sdiag(j) = norm(V(:, j + 1));  % 计算次对角线元素
        
        if sdiag(j) < 1e-6
            V = V(:, 1:j);
            mdiag = mdiag(1:j);
            sdiag = sdiag(1:j);
            return;
        end
        V(:, j + 1) = V(:, j + 1) / sdiag(j);
    end
end

function vis_ortho(V)    
    m = size(V, 2);
    ortholoss = zeros(m - 1, 1);
    
    for i = 2:m
        v = V(:, 1:i);
        ortholoss(i - 1) = norm(v' * v - eye(i));
    end
    
    figure;
    plot(2:m, ortholoss);  % 绘制正交性损失的图像
    title('Lanczos向量的正交性');
    xlabel('Lanczos向量数量');
    ylabel('正交性损失');
    saveas(gcf, 'Problem4_Ortho.jpg');
end

function vis_ritz(A)    
    mls = 1:12;  % 设置迭代次数范围
    data = [];    % 存储结果
    
    for m = mls
        [V, mdiag, sdiag] = lanczos(A, m);
        
        % 计算Ritz值，方法是求解三对角矩阵的特征值
        try
            T = diag(mdiag) + diag(sdiag(1:end-1), 1) + diag(sdiag(1:end-1), -1);  % 构造三对角矩阵
            eigs = eig(T);  % 计算特征值
        catch
            continue;
        end
        
        for i = 1:m
            data = [data; m, eigs(i)];  % 存储结果
        end
    end
    
    figure;
    scatter(data(:, 1), data(:, 2), 30, 'filled');  % 绘制Ritz值收敛图
    title('Ritz值的收敛性, n = 4000');
    xlabel('迭代次数 m');
    ylabel('Ritz值');
    saveas(gcf, 'Problem4_Ritz.jpg');
end