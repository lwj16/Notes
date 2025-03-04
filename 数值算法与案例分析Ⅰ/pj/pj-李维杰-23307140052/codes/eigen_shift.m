function [isreal, eig_1, eig_2] = eigen_shift(A)
    delta = trace(A)^2 - 4 * det(A);
    if trace(A)^2 < 4 * det(A)
        isreal = 0;
    else
        isreal = 1;
    end
    eig_1 = (trace(A) + sqrt(delta)) / 2;
    eig_2 = (trace(A) - sqrt(delta)) / 2;
end