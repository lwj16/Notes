n = 200;
A = hilb(n);
execution_time = zeros(2, 1);

tic;
[eigen_value, eigen_vector, k, loss_inverse] = inverse_iteration(A, A(:, 1));
execution_time(1) = toc;

tic;
[eigen_value, eigen_vector, k, loss_Rayleigh] = Rayleigh_quotient_iteration(A, A(:, 1));
execution_time(2) = toc;

figure;
subplot(2, 1, 1);
semilogy(k, loss_Rayleigh, 's-', 'DisplayName', 'Rayleigh quotient iteration', 'LineWidth', 1);
hold on;
semilogy(k, loss_inverse, 'o-', 'DisplayName', 'inverse iteration', 'LineWidth', 1);
xlabel('convergence time'); % x 轴标签
ylabel('deviation from the standard value |x - eigenvector|'); % y 轴标签
title('convergence history'); % 图像标题
legend('show');

subplot(2, 1, 2);
T = bar([execution_time], 'grouped');
T.FaceColor = 'flat';
T.CData(1, :) = [1, 0, 0];
T.CData(2, :) = [0, 0, 1];
title('算法耗时比较');
xticklabels({'inverse_iteration', 'Rayleigh quotient iteration'})
ylabel('耗时');
grid on; % 显示网格