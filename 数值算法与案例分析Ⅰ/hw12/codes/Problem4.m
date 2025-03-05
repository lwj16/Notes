A = [20, 0; 0, 1];
b = [0; 0];
x0 = [1; 5];
standard_x = A\b;

[x, iter] = SD(A, b, x0, 10);

figure;
plot(x(1, :), x(2, :), '-o', 'LineWidth', 1, 'MarkerSize', 2); % 绘制路径
hold on;

% 绘制目标解 x_true
plot(standard_x(1), standard_x(2), 'rx', 'MarkerSize', 10, 'LineWidth', 2);

% 设置图形属性
xlabel('x_1');
ylabel('x_2');
title('Convergence Path of x_k in 2D');
legend('Convergence Path', 'True Solution');
grid on;
axis equal;
hold off;