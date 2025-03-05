format long;

x = zeros(17, 1);

y_cgs2 = zeros(17, 1);
y_mgs2 = zeros(17, 1);
y_cgs = zeros(17, 1);
y_mgs = zeros(17, 1);

for i = 0:16
    cond_num = 10^i;
    A = generate_cond_number_matrices(2000, 100, cond_num);
    x(i+1) = cond(A);

    [Q, R] = qr_cgs(A);
    y_cgs(i+1) = norm(Q'*Q - eye(size(Q'*Q)), 'fro');

    [Q, R] = qr_cgs2(A);
    y_cgs2(i+1) = norm(Q'*Q - eye(size(Q'*Q)), 'fro');

    [Q, R] = qr_mgs(A);
    y_mgs(i+1) = norm(Q'*Q - eye(size(Q'*Q)), 'fro');

    [Q, R] = qr_mgs2(A);
    y_mgs2(i+1) = norm(Q'*Q - eye(size(Q'*Q)), 'fro');
    
end

% 计算条件数的以10为底的对数
log_cond_nums = log10(x); 

% 绘制正交性误差
figure;
semilogy(log_cond_nums, y_cgs2, 'o-', 'DisplayName', 'CGS2 QR', 'LineWidth', 1);
hold on;
semilogy(log_cond_nums, y_mgs2, 's-', 'DisplayName', 'MGS2 QR', 'LineWidth', 1);
semilogy(log_cond_nums, y_cgs, 'd-', 'DisplayName', 'CGS QR', 'LineWidth', 1);
semilogy(log_cond_nums, y_mgs, '^-', 'DisplayName', 'MGS QR', 'LineWidth', 1);
xlabel('log_{10}(Condition Number)');
ylabel('Orthogonality Error (Log Scale)');
title('Orthogonality Errors for QR Methods');
legend('show');
grid on;