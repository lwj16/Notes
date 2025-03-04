function H = Givens_QR_iteration(H)
    [n, n] = size(H);
    for i = 1:n-1
        G = eye(n);
        if i == 1
            c = H(1, 1) / sqrt(H(1, 1)^2 + H(2, 1)^2);
            s = H(2, 1) / sqrt(H(1, 1)^2 + H(2, 1)^2);
        else
            s = H(i+1, i-1) / sqrt(H(i+1, i-1)^2 + H(i, i-1)^2);
            c = H(i, i-1) / sqrt(H(i+1, i-1)^2 + H(i, i-1)^2);
        end

        G(i, i) = c;
        G(i+1, i+1) = c;
        G(i, i+1) = s;
        G(i+1, i) = -s;

        H = G * H;
        H = H * G';
    end
end