function [A, eigvals] = QR_iteration(A, max_iter)
    for i = 1:max_iter
        [Q, R] = qr(A);
        A = R * Q;
    end
    eigvals = diag(A);
end