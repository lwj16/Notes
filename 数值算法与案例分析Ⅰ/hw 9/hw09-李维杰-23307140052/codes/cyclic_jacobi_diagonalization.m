function [V, D, iter] = cyclic_jacobi_diagonalization(A)
    [n, ~] = size(A);
    V = eye(n);
    D = A;
    iter = 0;
    
    while true
        for p = 1:n-1
            for q = p+1:n
                if abs(D(p, q)) > 1e-6
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
                end
            end
        end
        
        iter = iter + 1;
        
        f = 0;
        for i = 1:n-1
            for j =i+1:n
                if abs(D(i,j)) > 1e-6
                    f = 1;
                    break;
                end
            end
        end
        if f == 0
            break;
        end
    end
end