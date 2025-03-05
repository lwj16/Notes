n = 1000;
A = rand(n);
A = (A + A') / 2;
dis = zeros(200, 1);
iter = zeros(200, 1);

    V = eye(n);
    D = A;
    k = 1;
    while true
        max_val = 0;
        p = -1;
        q = -1;
        for i = 1:n-1
            for j =i+1:n
                if abs(A(i,j)) > abs(max_val)  % 找到更大的非对角元素
                    max_val = D(i,j);
                    p = i;
                    q = j;
                end
            end
        end
        
        if D(p, q) < 1e-6
            break;
        end
        
        if D(p, p) == D(q, q)
            theta = pi / 4;
        else
            theta = 0.5 * atan(2 * D(p, q) / (D(p, p) - D(q, q)));
        end
        
        P = eye(n);
        P(p, p) = cos(theta);
        P(q, q) = cos(theta);
        P(p, q) = -sin(theta);
        P(q, p) = sin(theta);
        
        D = P' * D * P;
        V = V * P;
        
        k = k + 1;
        iter(k) = k;
        dis(k) = norm(D - diag(diag(D)), 'fro');
    end

figure;
semilogy(iter, dis, 's-', 'DisplayName', 'Jacobi', 'LineWidth', 1);

xlabel('Iteration Steps');
ylabel('Distance from the Diag');
grid on;