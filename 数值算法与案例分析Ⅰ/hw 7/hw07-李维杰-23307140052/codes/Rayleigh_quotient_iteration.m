function [eigen_vector, eigen_value, k, loss] = Rayleigh_quotient_iteration(A, x)
    % 计算特征值和特征向量
    [standard_vectors, standard_values] = eig(A);
    standard_values = diag(standard_values);

    % 找到最接近 1 的特征值及其对应的特征向量
    [~, index] = min(abs(standard_values - 1)); % 找到最小差值的索引
    standard_value = standard_values(index); % 最接近的特征值
    standard_vector = standard_vectors(:, index); % 对应的特征向量
    
    k = zeros(20, 1);
    loss = zeros(20, 1);

    x = x / norm(x);
    lambda = 1;
    for i = 1:20
        P = (A - lambda * eye(size(A))) \ x;
        x = P / norm(P);
        lambda = (x' * A * x) / norm(x)^2;
        k(i) = i;
        loss(i) = min(norm(x - standard_vector), norm(x + standard_vector));
    end

    eigen_vector = x;
    eigen_value = (x' * A * x) / norm(x)^2;
end