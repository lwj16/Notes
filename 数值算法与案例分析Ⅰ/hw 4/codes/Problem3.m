format long;
A_1 = [2 + 3i, 1, 0, 0, 0; 
     1, 4 - 1i, 1, 0, 0; 
     0, 1, 3 + 2i, 1, 0; 
     0, 0, 1, 5, 1 - 1i; 
     0, 0, 0, 1, 6 + 1i];

A_2 = [1+0i, 0.999+0.001i, 0.999+0.002i, 0.999+0.003i, 0.999+0.004i;
     0.999+0.001i, 1+0i, 0.999+0.005i, 0.999+0.006i, 0.999+0.007i;
     0.999+0.002i, 0.999+0.005i, 1+0i, 0.999+0.008i, 0.999+0.009i;
     0.999+0.003i, 0.999+0.006i, 0.999+0.008i, 1+0i, 0.999+0.010i;
     0.999+0.004i, 0.999+0.007i, 0.999+0.009i, 0.999+0.010i, 1+0i];

k_A_1 = norm(A_1, 'fro') * norm(inv(A_1), 'fro')
k_A_2 = norm(A_2, 'fro') * norm(inv(A_2), 'fro')

[Q, R, loss_cho_1, obj_cho_1] = qr_cholesky(A_1);
[Q, R, loss_hou_1, obj_hou_1] = qr_householder(A_1);
[Q, R, loss_cho_2, obj_cho_2] = qr_cholesky(A_2);
[Q, R, loss_hou_2, obj_hou_2] = qr_householder(A_2);

% 显示结果
disp('Cholesky QR 正交性损失（良态）:');
disp(loss_cho_1);
disp('Cholesky QR 正交性损失（病态）:');
disp(loss_cho_2);

disp('Householder QR 正交性损失（良态）:');
disp(loss_hou_1);
disp('Householder QR 正交性损失（病态）:');
disp(loss_hou_2);