n = 5;
cnt = zeros(20, 1);
err = zeros(20, 1);

for i = 1:20
    D = diag(rand(1, n));
    S = rand(n);
    diag_sum = sum(abs(S), 2);
    S = S + diag(diag_sum);
    A = S \ D * S;

    ex_result = scaling_squaring(A);
    sd_result = expm(A);

    cnt(i) = i;
    err(i) = norm(ex_result - sd_result, 'fro');
end

figure;
bar(cnt, err, 'FaceColor', [0.2, 0.6, 1], 'EdgeColor', 'black', 'LineWidth', 1);
xlabel('矩阵序号'); % x 轴标签
ylabel('算法准确性'); % y 轴标签
grid on; % 显示网格