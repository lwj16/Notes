function x = low_rank_least_squares_problem(A,b)
   [m, n] = size(A);
   Q = zeros(m, n);
   R = zeros(n, n);
   target = zeros(n, 1);
   R_size = n;

   for i = 1:n
       % 列选主元
       tmp = norm(A(:, i), 2);
       target(i) = i;
       for j = i+1:n
           if norm(A(:, j), 2) > tmp
               tmp = norm(A(:, j), 2);
               target(i) = j;
           end
       end
       if target(i) ~= i
            A(:, [i, target(i)]) = A(:, [target(i), i]);
            R(:, [i, target(i)]) = R(:, [target(i), i]);
       end

        % mgs
        Q(:, i) = A(:, i);

        for j = 1:i-1
            R(j, i) = Q(:, i)' * Q(:, j);
            Q(:, i) = Q(:, i) - R(j, i) * Q(:, j);
        end
        
        R(i, i) = norm(Q(:, i), 2);
        if R(i, i) > 1e-7
            Q(:, i) = Q(:, i) / R(i, i);
        end
   end

   Q_T = Q';
   x_v = R(1:R_size, 1:R_size) \ (Q_T(1:R_size, :) * b);
    
   x = zeros(n, 1);
   x(1:R_size) = x_v(1:R_size);
   for i = R_size:-1:1
       if target(i) ~= i
           x([i, target(i)]) = x([target(i), i]);
       end
   end
end