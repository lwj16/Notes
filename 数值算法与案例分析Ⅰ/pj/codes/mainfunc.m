err_or = zeros(2500, 1);
err_A = zeros(2500, 1);
iter_step = zeros(2500, 1);
Time = zeros(2500, 1);
Size_M = zeros(2500, 1);

for n = 2500:1:2500
    tic;
    M = rand(n);
    A = zeros(n);
    Q = zeros(n);
    l = 1;
    r = n;

    [A, Q] = Householder_Hessenberg(M);
    while r > l
        while (r > l) && (abs(A(r, r-1)) < 1e-6 * (abs(A(r, r)) + abs(A(r-1, r-1))))
            A(r, r-1) = 0;
            r = r - 1;
        end
        while (r > l + 1) && (abs(A(r-1, r-2)) < 1e-6 * (abs(A(r-1, r-1)) + abs(A(r-2, r-2))))
            A(r-1, r-2) = 0;
            r = r - 2;
        end
        while (r > l) && (abs(A(l+1, l)) < 1e-6 * (abs(A(l, l)) + abs(A(l+1, l+1))))
            A(l+1, l) = 0;
            l = l + 1;
        end
        while (r > l + 1) && (abs(A(l+2, l+1)) < 1e-6 * (abs(A(l+1, l+1)) + abs(A(l+2, l+2))))
            A(l+2, l+1) = 0;
            l = l + 2;
        end
        if r == l
            break;
        end

        [isreal, eig_1, eig_2] = eigen_shift(A(r-1:r, r-1:r));
        if isreal == 1
            if abs(eig_1 - A(r, r)) < abs(eig_2 - A(r ,r))
                min_eig = eig_1;
            else
                min_eig = eig_2;
            end
            [A, Q] = single_shift_iteration(A, l, r, min_eig, Q);
        else
            if r > l + 1
                [A, Q] = double_shift_iteration(A, l, r, eig_1 + eig_2, eig_1 * eig_2, Q);
            else
                break;
            end
        end
        iter_step(n) = iter_step(n) + 1;
    end
    Time(n) = toc;
    err_or(n) = norm(Q' * Q - eye(n), 'fro');
    err_A(n) = norm(Q' * A * Q - M, 'fro') / norm(A, 'fro');
    Size_M(n) = n;
end


% 绘制耗时对比图
figure;
hold on;

% 计算n^3理论曲线
n_values = Size_M(Size_M > 0);  % 去除0的元素
theory_time = n_values.^3 / max(n_values.^3);  % 理论时间（归一化为最大值）
Time = Time(Time > 0);
Time = (Time - min(Time)) / (max(Time) - min(Time));

% 绘制实验数据
semilogy(log(n_values), log(Time), 'DisplayName', 'execution time', 'LineWidth', 1);
% 绘制理论O(n^3)曲线
semilogy(log(n_values),log(theory_time), '--', 'DisplayName', 'Standard O(n^3)', 'LineWidth', 1.5);

xlabel('log(Size of Matrix)');
ylabel('log(execution time)');
legend('show');
grid on;  % 显示网格

% 绘制正交性误差
figure;
semilogy(Size_M, err_or, 'DisplayName', '$| Q^T Q - I |_F$', 'LineWidth', 1);
hold on;
semilogy(Size_M, err_A, 'DisplayName', '$\frac{| Q^T A Q - M |_F}{| A |_F}$', 'LineWidth', 1);
xlabel('Size of Matrix');
legend('show', 'Interpreter', 'latex');
grid on;

% 绘制迭代次数
figure;
semilogy(Size_M, iter_step, 'LineWidth', 1);
xlabel('Size of Matrix');
ylabel('iteration steps');
legend('off');
grid on;

% 获取最终的A矩阵
final_A = A; final_A(1, 1) = A(1, 1) / 100;

for i = 1:2500
    final_A(i, i) = final_A(i, i) / 100;
    if i ~= 2500
        final_A(i+1, i) = final_A(i+1, i) / 100;
    end
    if i ~= 1
        final_A(i-1, i) = final_A(i-1, i) / 100;
    end
end

% 绘制矩阵A的热力图，帮助验证是否为拟上三角矩阵
figure;
colormap([1 1 1; jet(255)]);
imagesc(final_A);  % 显示矩阵的热力图
colorbar;  % 添加色条，便于观察值的大小
title('Heatmap of Final Matrix A');
xlabel('Column index');
ylabel('Row index');
axis equal;  % 确保矩阵显示为正方形
grid on;