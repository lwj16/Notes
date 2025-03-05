n = 100;
dx = 1/(n - 1);
dy = 1/(n - 1);

u = zeros(n, n);

for j = 1:n
    u(1, j) = 0;
    u(n, j) = 0;
end
for i = 1:n
    u(i, n) = 0;
    u(i, 1) = sin(pi * (i - 1) * dx);
end

tol = 1e-6;
err_J = zeros(20000, 1);
k_J = zeros(20000, 1);

iter = 1;
while iter == 1 || err_J(iter-1) >= tol
    u_old = u;
    for i = 2:n - 1
        for j = 2:n - 1
            u(i, j) = (u_old(i + 1, j) + u_old(i - 1, j) + u_old(i, j + 1) + u_old(i, j - 1)) / 4;
        end
    end
    err_J(iter) = norm(u - u_old, 'inf');
    k_J(iter) = iter;
    iter = iter + 1;
 %   if mod(iter, 20) == 0
        % 可视化
 %       figure;
 %       [X, Y] = meshgrid(0:dx:1, 0:dy:1);
 %       surf(X, Y, u);
 %   end
end

u = zeros(n, n);

for j = 1:n
    u(1, j) = 0;
    u(n, j) = 0;
end
for i = 1:n
    u(i, n) = 0;
    u(i, 1) = sin(pi * (i - 1) * dx);
end

tol = 1e-6;
err_G = zeros(20000, 1);
k_G = zeros(20000, 1);

iter = 1;
while iter == 1 || err_G(iter-1) >= tol
    u_old = u;
    for i = 2:n - 1
        for j = 2:n - 1
            u(i, j) = (u_old(i + 1, j) + u(i - 1, j) + u_old(i, j + 1) + u(i, j - 1)) / 4;
        end
    end
    err_G(iter) = norm(u - u_old, 'inf');
    k_G(iter) = iter;
    iter = iter + 1;
end

figure
semilogy(k_J, err_J, '-', 'DisplayName', 'Jacobi', 'LineWidth', 1);
hold on;
semilogy(k_G, err_G, '-', 'DisplayName', 'Gauss-Seidel', 'LineWidth', 1);
xlabel('Iteration'); % x 轴标签
ylabel('Error'); % y 轴标签
legend('show');
grid on; % 显示网格