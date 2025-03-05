% 设置随机种子以确保结果可重复
rng(42);

% 定义自变量的维度和观测数据的数量
n = 5;  % 自变量维度
m = 10; % 观测数据数量

% 生成自变量矩阵 A
A = rand(m, n);

% 让 A 的最后一列是前两列的线性组合（亏秩）
A(:, 3) = 0.5 * A(:, 1) + 0.5 * A(:, 2);

% 生成真实参数向量 beta
beta = rand(n, 1);

% 生成误差项
noise = normrnd(0, 0.1, [m, 1]); % 正态分布的噪声

% 生成观测值 b
b = A * beta + noise;

x_lr = low_rank_least_squares_problem(A, b);

A_p = pinv(A); % 求 A 的伪逆
x_fr = A_p * b;

b_lr = A * x_lr;
b_fr = A * x_fr;

delta_lr = norm(b_lr - b) 
delta_fr = norm(b_fr - b)