function [x_new, y_new] = normalize_average(x, y, M)
    x_new = M * x;
    y_new = M * y;
    x_new = x_new / norm(x_new, 2);
    y_new = y_new / norm(y_new, 2);
end