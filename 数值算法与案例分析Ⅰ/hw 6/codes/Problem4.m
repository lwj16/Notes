format long;
rng(24);

x = zeros(20, 1);
n = 30;

y_cgs2 = zeros(20, 1);
y_mgs2 = zeros(20, 1);
y_cgs = zeros(20, 1);
y_mgs = zeros(20, 1);

for i = 0:19
    x(i+1) = i+1;

    A = rand(1000, 1000);
    b = rand(1000, 1);

    [Q, H] = arnoldi_cgs(A, b, n);
    y_cgs(i+1) = norm(Q'*Q - eye(size(Q'*Q)), 'fro');

    [Q, H] = arnoldi_cgs2(A, b, n);
    y_cgs2(i+1) = norm(Q'*Q - eye(size(Q'*Q)), 'fro');

    [Q, H] = arnoldi_mgs(A, b, n);
    y_mgs(i+1) = norm(Q'*Q - eye(size(Q'*Q)), 'fro');

    [Q, H] = arnoldi_mgs2(A, b, n);
    y_mgs2(i+1) = norm(Q'*Q - eye(size(Q'*Q)), 'fro');
    
end

% 绘制正交性误差
figure;
semilogy(x, y_cgs2, 'o-', 'DisplayName', 'CGS2 Arnoldi', 'LineWidth', 1);
hold on;
semilogy(x, y_mgs2, 's-', 'DisplayName', 'MGS2 Arnoldi', 'LineWidth', 1);
semilogy(x, y_cgs, 'd-', 'DisplayName', 'CGS Arnoldi', 'LineWidth', 1);
semilogy(x, y_mgs, '^-', 'DisplayName', 'MGS Arnoldi', 'LineWidth', 1);
xlabel('Case');
ylabel('Orthogonality Error');
title('Orthogonality Errors for Arnoldi Methods');
legend('show');
grid on;