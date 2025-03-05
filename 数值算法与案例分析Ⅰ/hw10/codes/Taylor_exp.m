function Taylor_A = Taylor_exp(A, opt)
    [n, ~] = size(A);
    tem = A;
    Taylor_A = eye(n);
    for i = 1:opt
        Taylor_A = Taylor_A + tem;
        tem = tem * A / (i+1);
    end
end