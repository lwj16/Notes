function [A, Q] = double_shift_iteration(A, l, r, m_real, m_norm, Q) % m_real 是两倍的实部
    [A, Q] = Initial_Householder(A, l, r, m_real, m_norm, Q);
    [A, Q] = Householder_reflection(A, l, r, Q);
    [A, Q] = Givens_rotation(A, l, r, Q);
end

function [A, Q] = Initial_Householder(A, l, r, m_real, m_norm, Q)
    [n, ~] = size(A);
    p = zeros(3, 1);
    p(1) = A(l, l)^2 + A(l, l+1) * A(l+1, l) - m_real * A(l, l) + m_norm;
    p(2) = A(l+1, l) * (A(l, l) + A(l+1, l+1) - m_real);
    p(3) = A(l+1, l) * A(l+2, l+1);
    
     e = zeros(3, 1);
     e(1) = sign(p(1)) * norm(p, 2);
     w = p + e;
     w = - w / norm(w, 2);
   
    A(l:l+2, l:n) = A(l:l+2, l:n) - 2 * w * (w' * A(l:l+2, l:n));
    A(1:min(l+3, r), l:l+2) = A(1:min(l+3, r), l:l+2) - 2 * (A(1:min(l+3, r), l:l+2) * w) * w';
    Q(l:l+2, :) = Q(l:l+2, :) - 2 * w * (w' * Q(l:l+2, :));
end

function [A, Q] = Householder_reflection(A, l, r, Q)
    [n, ~] = size(A);
    for i = l:r-3
        x = A(i+1:i+3, i);
        e = zeros(3, 1);
        e(1) = sign(x(1)) * norm(x, 2);
        w = x + e;
        w = w / norm(w, 2);
        
        A(i+1:i+3, i:n) = A(i+1:i+3, i:n) - 2 * w * (w' * A(i+1:i+3, i:n));
        A(1:min(i+4, r), i+1:i+3) = A(1:min(i+4, r), i+1:i+3) -  2 * (A(1:min(i+4, r), i+1:i+3) * w) * w';
        Q(i+1:i+3, :) = Q(i+1:i+3, :) - 2 * w * (w' * Q(i+1:i+3, :));
    end
end

function [A, Q] = Givens_rotation(A, l, r, Q)
    [n, ~] = size(A);
    c = A(r-1, r-2) / sqrt(A(r-1, r-2)^2 + A(r, r-2)^2);
    s = A(r, r-2) / sqrt(A(r-1, r-2)^2 + A(r, r-2)^2);
    T = [c, s; -s, c];
    
    A(r-1:r, r-2:n) = T * A(r-1:r, r-2:n);
    A(1:r, r-1:r) = A(1:r, r-1:r) * T';
    Q(r-1:r, :) = T * Q(r-1:r, :);
end