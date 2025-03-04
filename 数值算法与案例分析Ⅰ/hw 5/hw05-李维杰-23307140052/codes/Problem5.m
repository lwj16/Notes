A = [2 1 ;
    3 1 ;
    4 1 ;
    5 1 ;
    6 1 ;
    7 1 ];
y = [log(2);log(3);log(4);log(5);log(6);log(7)];

A_p = pinv(A); % 求 A 的伪逆

x = A_p * y; 

disp(x);

% 创建x的范围
p = linspace(1, 8, 70);  % 从1到8生成70个点
q = x(1)*p + x(2);  % 计算拟合直线

% 绘制函数图像
figure; % 创建新图形窗口
plot(p, q, 'b-', 'LineWidth', 1);  % 绘制拟合直线的图像
hold on; % 保持当前图形，以便添加散点

% 添加散点
x_points = [2, 3, 4, 5, 6, 7];  % 散点的x坐标
y_points = log(x_points);  % 计算散点的y坐标
scatter(x_points, y_points, 20, 'r', 'filled');  % 绘制散点

% 添加标签和标题
xlabel('x');
ylabel('y');
title('Plot of y = kx+t approximately passes through the data set');
legend('y = kx+t', 'data set');

% 显示网格
grid on;
hold off; % 释放图形