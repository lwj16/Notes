size = zeros(50, 1);
iter_1 = zeros(50, 1);
iter_2 = zeros(50, 1);

for n = 3:50
    tmp_1 = zeros(5, 1);
    tmp_2 = zeros(5, 1);
    for i = 1:50
        A = rand(n);
        A = (A + A') / 2;
        [V, D, tmp_1(i)] = jacobi_diagonalization(A);
        [V, D, tmp_2(i)] = cyclic_jacobi_diagonalization(A);
    end
    size(n) = n;
    iter_1(n) = norm(tmp_1, 1) / 50;
    iter_2(n) = norm(tmp_2, 1) / 50;
end

figure;
semilogy(size, iter_1, 's-', 'DisplayName', 'Jacobi', 'LineWidth', 1);
hold on;
semilogy(size, iter_2, 'd-', 'DisplayName', 'cyclic Jacobi', 'LineWidth', 1);

xlabel('Size of Matrix');
ylabel('Iteration Steps');
legend show;
grid on;