max_iter = 25;

for idx = 1:2
    n = idx * 3;
    A = zeros(idx);
    for i = 1:n-1
        A(i+1, i) = 1;
    end
    A(1, n) = 1;
    A_n = QR_iteration(A, max_iter);
    A_f = francis_double_swift(A, max_iter);
end