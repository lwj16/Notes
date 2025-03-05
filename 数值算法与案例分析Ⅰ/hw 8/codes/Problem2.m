n = 5;
A = randn(n);
for i = 2:n
    for j = 1:i-2
        A(i,j) = 0;
    end
end

 A(:, n) = rand() * A(:, n-1);

 A(4, 3) = 0;

A = Givens_QR_iteration(A);

disp(A);