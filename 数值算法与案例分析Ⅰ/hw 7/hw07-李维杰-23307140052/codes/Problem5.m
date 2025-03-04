n = 10; % 矩阵的大小
diagonal_entries = randperm(10, n); % 生成 n 个不重复的对角线元素
A = triu(diag(diagonal_entries) + rand(n)); % 生成上三角矩阵

eigenvector = zeros(10, 10);
eigenvalue = zeros(10, 1);

for i = 1:10
    eigenvalue(i) = A(i, i);
    eigenvector(i, i) = 1;
    for j = i-1:-1:1
        for k = j+1:i
            eigenvector(j, i) = eigenvector(j, i) + A(j, k) * eigenvector(k, i);
        end
        eigenvector(j, i) = eigenvector(j, i) / (eigenvalue(i) - eigenvalue(j));
    end
    eigenvector(:, i) = eigenvector(:, i) / norm(eigenvector(:, i));
end

[standard_vectors, standard_values] = eig(A);
standard_values = diag(standard_values);

% 可视化特征值
figure;
subplot(2, 1, 1);
bar([eigenvalue, standard_values], 'grouped');
title('特征值比较');
xlabel('索引');
ylabel('特征值');
legend('自定义特征值', '标准特征值');
grid on;

% 可视化特征向量
subplot(2, 1, 2);
hold on;
% 计算特征向量差的模长
vector_differences = eigenvector - standard_vectors;
magnitude_differences = vecnorm(vector_differences, 2, 1); % 计算每一列的模长

% 可视化模长差异
bar(magnitude_differences);
title('特征向量差异2范数');
xlabel('索引');
ylabel('2范数');
xticks(1:1:10);
grid on;