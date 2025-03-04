n = 100;
dx = 1/(n - 1);
dy = 1/(n - 1);

u = zeros(n, n);

for i = 1:n
    u(i, 1) = sin(pi * (i - 1) * dx);
end

[x, res] = CG(u(:), @left_mulA, [], 1e-5, 300);
    
% 可视化求解结果
vis_solution(n, x);
    
% 可视化收敛历史
vis_conv_his(n, res);

function [x, res] = CG(b, A, x0, eps, miter)
    n = length(b);
    if isempty(x0)
        x = zeros(n, 1);
    else
        x = x0;
    end
    r = b - A(x);
    
    k = 0;
    beta = 0;
    p = zeros(n, 1);
    res = norm(r);
    res_history = res;
    
    while res > eps && k < miter
        p = r + beta * p;
        w = A(p);
        alpha = (r' * r) / (p' * w);
        x = x + alpha * p;
        lr = r;
        r = r - alpha * w;
        beta = (r' * r) / (lr' * lr);
        
        k = k + 1;
        fprintf('迭代次数 %d\n', k);
        
        res = norm(r);
        res_history = [res_history; res];
    end
    
    res = res_history;
end

function w = left_mulA(v)
    n = sqrt(length(v));
    w = zeros(size(v)); 
    
    for i = 1:n
        for j = 1:n
            k = (i-1) * n + j;
            w(k) = 4 * v(k);
            
            if i > 1
                w(k) = w(k) - v(k - n); % 上邻居
            else
                w(k) = w(k) - sin(pi * (j-1) / (n - 1));
            end
            
            if i < n
                w(k) = w(k) - v(k + n); % 下邻居
            end
            
            if j > 1
                w(k) = w(k) - v(k - 1); % 左邻居
            end
            
            % 右边界处理
            if j < n
                w(k) = w(k) - v(k + 1); % 右邻居
            end
            
            w(k) = w(k) / 4;
        end
    end
end

function vis_solution(n, x)
    % 可视化求解结果
    % 将解向量 x 转换为二维矩阵
    x_2d = reshape(x, [n, n]);
    
    % 使用 imagesc 函数显示解的热图
    imagesc(x_2d);
    colorbar; % 显示颜色条
    title('iteration = 300');
    xlabel('x');
    ylabel('y');
    saveas(gcf, 'Problem3_6.png');
end

function vis_conv_his(n, res)
    figure;
    semilogy(1:length(res), res, 'DisplayName', 'CG');
    title(['收敛历史, n = ' num2str(n)]);
    xlabel('迭代次数');
    ylabel('残差的2范数');
    legend show;
    saveas(gcf, 'Convergence_Histroy.png');
end