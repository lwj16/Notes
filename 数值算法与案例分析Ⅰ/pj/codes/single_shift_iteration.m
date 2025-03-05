function [A, Q] = single_shift_iteration(A, l, r, mu, Q)
    [A, Q] = Initial_Givens(A, l, r, mu, Q);
    [A, Q] = Givens_rotation(A, l, r, Q);
end

function [A, Q] = Initial_Givens(A, l, r, mu, Q)
    [n, ~] = size(A);
    c = (A(l, l) - mu) / sqrt((A(l, l) - mu)^2 + A(l+1, l)^2);
    s = A(l+1, l) / sqrt((A(l, l) - mu)^2 + A(l+1, l)^2);
    T = [c, s; -s, c];
    
    A(l:l+1, l:n) = T * A(l:l+1, l:n);
    A(1:min(l+2, r), l:l+1) = A(1:min(l+2, r), l:l+1) * T';
    Q(l:l+1, :) = T * Q(l:l+1, :);
end

function [A, Q] = Givens_rotation(A, l, r, Q)
    [n, ~] = size(A);
    for i = l:r-2
        c = A(i+1, i) / sqrt(A(i+1, i)^2 + A(i+2, i)^2);
        s = A(i+2, i) / sqrt(A(i+1, i)^2 + A(i+2, i)^2);
        T = [c, s; -s, c];
    
        A(i+1:i+2, i:n) = T * A(i+1:i+2, i:n);
        A(1:min(i+3, r), i+1:i+2) = A(1:min(i+3, r), i+1:i+2) * T';
        Q(i+1:i+2, :) = T * Q(i+1:i+2, :);
    end
end