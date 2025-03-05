% 定义矩阵 A
A = [1, 1, 1, 1, 1; 
     1, 2, 3, 4, 5; 
     1, 3, 6, 10, 15; 
     1, 4, 10, 19, 31; 
     1, 5, 15, 31, 53];

% 计算伪逆 A^+
A_pseudo_inverse = pinv(A);

% 计算对称矩阵 X
X = (A_pseudo_inverse + A_pseudo_inverse') / 2;

% 显示结果
disp('对称矩阵 X:');
disp(X);

% 验证 AXA = A
check1 = A * X * A;
disp('验证 AXA = A:');
disp(check1);

% 验证 XAX = X
check2 = X * A * X;
disp('验证 XAX = X:');
disp(check2);