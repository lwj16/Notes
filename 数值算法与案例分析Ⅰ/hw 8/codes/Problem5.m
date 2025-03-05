err_H_1 = zeros(100, 1);
err_H_2 = zeros(100, 1);
err_A_1 = zeros(100, 1);
err_A_2 = zeros(100, 1);
k = zeros(100, 1);

for idx = 1:100
    n = idx * 5;
    k(idx) = n;
    A = rand(n) * 100;
    e = zeros(n, 1);
    e(1) = 1; % 取e1以适配Householder-QR分解中Q阵的第一列

    [Q_H, H_H] = Householder_Hessenberg(A);
    [Q_A, H_A] = arnoldi_mgs(A, e, n);

    err_H_1(idx) = norm(Q_H' * A * Q_H - H_H, 'fro');
    err_A_1(idx) = norm(Q_A' * A * Q_A - H_A(1:n, 1:n), 'fro');
    err_H_2(idx) = norm(Q_H' * Q_H - eye(n), 'fro');
    err_A_2(idx) = norm(Q_A' * Q_A - eye(n), 'fro');
end

% 绘制误差
figure;
subplot(2, 1, 1);
semilogy(k, err_H_1, 's-', 'DisplayName', 'Householder', 'LineWidth', 1);
hold on;
semilogy(k, err_A_1, 'o-', 'DisplayName', 'Arnoldi', 'LineWidth', 1);
xlabel('Size Of Matrix'); % x 轴标签
ylabel('Hessenberg Reduction Error'); % y 轴标签
legend('show');

subplot(2, 1, 2);
semilogy(k, err_H_2, 's-', 'DisplayName', 'Householder', 'LineWidth', 1);
hold on;
semilogy(k, err_A_2, 'o-', 'DisplayName', 'Arnoldi', 'LineWidth', 1);
xlabel('Size Of Matrix'); % x 轴标签
ylabel('Orthogonality Error'); % y 轴标签
legend('show');
grid on; % 显示网格