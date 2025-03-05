function A = scaling_squaring(A)
    normA = norm(A, 'fro');
    if normA < 1
        A = Taylor_exp(A, 8);
    else
        j = floor(log2(normA));
        A = (Taylor_exp(A / 2^j, 8))^(2^j);     
    end
end