err = zeros(10, 1);
cnt = zeros(10, 1);
for t = 1:10
    a = rand(1, 1) * 100;
    b = rand(1, 1) * 100;
    c = rand(1, 1) * 100;

    A = zeros(2, 2);
    A(1, 1) = a;
    A(1, 2) = c;
    A(2, 2) = b;

    A_t = zeros(2, 2);
    A_t(1, 1) = b;
    A_t(1, 2) = c;
    A_t(2, 2) = a;

    C = c / sqrt((b-a)^2 + c^2);
    S = (b-a) / sqrt((b-a)^2 + c^2);

    Q = zeros(2, 2);
    Q(1, 1) = C;
    Q(1, 2) = -S;
    Q(2, 1) = S;
    Q(2, 2) = C;
    
    cnt(t) = t;
    err(t) = norm(Q' * A * Q - A_t, 'fro');
end

figure;
bar(cnt, err, 'FaceColor', [0.2, 0.6, 1], 'EdgeColor', 'black', 'LineWidth', 1);
xlabel('Count'); % x 轴标签
ylabel('Error'); % y 轴标签
legend('Error', 'Location', 'Best'); % 将图例名称改为 "Error"
grid on; % 显示网格