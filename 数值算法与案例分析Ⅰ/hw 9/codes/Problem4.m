rng(42);

% 生成矩阵 A
n = 6; % 矩阵大小
d = [2; 3; 4; 5; 6; 7];
z = rand(n, 1); % 非零向量
A = diag(d) + z * z';

eig_val = eig(A);

f_lambda = @(lambda) 1 - sum(z.^2 ./ (lambda - d));

lambda_range = linspace(min(d)-1, max(d)+1, 10000);
f_val = f_lambda(lambda_range);

% 绘制图表
figure;
plot(lambda_range, f_val, 'b-', 'LineWidth', 1);
hold on;
plot(eig_val, zeros(size(eig_val)), 'ro', 'MarkerSize', 1.5, 'LineWidth', 1.5);

xlim([min(d)-1, max(d)+1])
ylim([-20, 20])

xlabel('λ');
ylabel('f(λ)');
title('Function f(λ) and Eigenvalues of Matrix A');
legend('f(λ)', 'Eigenvalues');
grid on;
hold off;