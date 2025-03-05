A = rand(1000, 1000);
[eigen_lambda, eigen_x, k, loss] = power_method(A, A(:, 1));


figure;
semilogy(k, loss, 'o-', 'DisplayName', 'power methold', 'LineWidth', 1);
xlabel('convergence time'); % x 轴标签
ylabel('deviation from the standard value |x - eigenvector|'); % y 轴标签
title('convergence history'); % 图像标题
legend('show');
grid on;