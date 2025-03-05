n = 12;
c = x;
s = y;
M = eye(n);
for i = 1:n
    M(i, mod(i, n) + 1) = 1;
end
M = M / 2;

theta_x = rand()*2*pi;
theta_y = rand()*2*pi;

x = cos(theta_x) * c + sin(theta_x) * s;
y = cos(theta_y) * c + sin(theta_y) * s;

max_iter = 10;

figure;
axis equal;
axis([-0.5 0.5 -0.5 0.5]);
hold on;

for k = 1:max_iter
    [x, y] = normalize_average(x, y, M);
    if mod(k, 2) == 0
        paint(x, y, 'r');
    else
        paint(x, y, 'b');
    end
end

function paint(x, y, color)
    scatter(x, y, 10, color, 'filled'); 
end