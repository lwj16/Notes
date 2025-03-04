format long;

x = zeros(11, 1);

y_cholesky = zeros(11, 1);
y_householder = zeros(11, 1);
y_cgs = zeros(11, 1);
y_mgs = zeros(11, 1);

z_cholesky = zeros(11, 1);
z_householder = zeros(11, 1);
z_cgs = zeros(11, 1);
z_mgs = zeros(11, 1);

for i = 0:10
    cond_num = 10^i;
    A = generate_cond_number_matrices(2000, 100, cond_num);
    x(i+1) = cond(A);

    [Q, R] = qr_cholesky(A);
    y_cholesky(i+1) = norm(Q'*Q - eye(size(Q'*Q)), 'fro');
    z_cholesky(i+1) = norm(A - Q*R, 'fro');

    [Q, R] = qr_householder(A);
    y_householder(i+1) = norm(Q'*Q - eye(size(Q'*Q)), 'fro');
    z_householder(i+1) = norm(A - Q*R, 'fro');

    [Q, R] = qr_cgs(A);
    y_cgs(i+1) = norm(Q'*Q - eye(size(Q'*Q)), 'fro');
    z_cgs(i+1) = norm(A - Q*R, 'fro');

    [Q, R] = qr_mgs(A);
    y_mgs(i+1) = norm(Q'*Q - eye(size(Q'*Q)), 'fro');
    z_mgs(i+1) = norm(A - Q*R, 'fro');
end 

% 计算条件数的以10为底的对数
log_cond_nums = log10(x); 

% 绘制正交性误差
figure;
subplot(2, 1, 1); % 创建上半部分图形
semilogy(log_cond_nums, y_cholesky, 'o-', 'DisplayName', 'Cholesky QR', 'LineWidth', 1);
hold on;
semilogy(log_cond_nums, y_householder, 's-', 'DisplayName', 'Householder QR', 'LineWidth', 1);
semilogy(log_cond_nums, y_cgs, 'd-', 'DisplayName', 'CGS QR', 'LineWidth', 1);
semilogy(log_cond_nums, y_mgs, '^-', 'DisplayName', 'MGS QR', 'LineWidth', 1);
xlabel('log_{10}(Condition Number)');
ylabel('Orthogonality Error (Log Scale)');
title('Orthogonality Errors for QR Methods');
legend('show');
grid on;

% 绘制重构误差
subplot(2, 1, 2); % 创建下半部分图形
semilogy(log_cond_nums, z_cholesky, 'o-', 'DisplayName', 'Cholesky QR', 'LineWidth', 1);
hold on;
semilogy(log_cond_nums, z_householder, 's-', 'DisplayName', 'Householder QR', 'LineWidth', 1);
semilogy(log_cond_nums, z_cgs, 'd-', 'DisplayName', 'CGS QR', 'LineWidth', 1);
semilogy(log_cond_nums, z_mgs, '^-', 'DisplayName', 'MGS QR', 'LineWidth', 1);
xlabel('log_{10}(Condition Number)');
ylabel('Reconstruction Error (Log Scale)');
title('Reconstruction Errors for QR Methods');
legend('show');
grid on;