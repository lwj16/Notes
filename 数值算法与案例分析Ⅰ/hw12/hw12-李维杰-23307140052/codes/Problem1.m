n = 1000;

density = 0.01;  % 非零元素的密度，1%的非零元素
A_asym = sprand(n, n, density);
A_sym = (A_asym + A_asym') / 2;
b = randn(n, 1);
x_sym_standard = gmres(A_sym, b);
x_asym_standard = gmres(A_asym, b);

x0 = zeros(n, 1);

[x_sym, res_sym] = GMRES(A_sym, b, x0, 500);
[x_asym, res_asym] = GMRES(A_asym, b, x0, 500);

figure;

subplot(1, 2, 1);
semilogy(res_sym, 'LineWidth', 2);
title('Symmetric Matrix');
xlabel('Iteration');
ylabel('Relative Residual Norm');
grid on;

subplot(1, 2, 2);
semilogy(res_asym, 'LineWidth', 2);
title('Asymmetric Matrix');
xlabel('Iteration');
ylabel('Relative Residual Norm');
grid on;