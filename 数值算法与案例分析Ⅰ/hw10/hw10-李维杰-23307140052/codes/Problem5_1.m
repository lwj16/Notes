n = 12;
x = randn(n, 1);
y = randn(n, 1);
x = x - sum(x) / n;
y = y - sum(y) / n;
x = x / norm(x);
y = y / norm(y);
M = eye(n);
for i = 1:n
    M(i, mod(i, n) + 1) = 1;
end
M = M / 2;

paint(x, y, 'b');

max_iter = 200;

for k = 1:max_iter
    [x, y] = normalize_average(x, y, M);
    if k == 18
        paint(x, y, 'b');
    end
end

paint(x, y, 'b');

function paint(x, y, color)
    figure;
    axis equal;
    axis([-1 1 -1 1]);
    hold on;

    n = length(x);
    x(n+1) = x(1);
    y(n+1) = y(1);
    plot(x, y, color, 'LineWidth', 1);
    scatter(x, y, 10, 'r', 'filled');
    hold off;
end