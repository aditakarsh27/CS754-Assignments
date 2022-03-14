x = double(imread("barbara256.png"));
x = padarray(x,[7, 7],0,"post");
phi = randn(32, 64);
U = kron(dctmtx(8)', dctmtx(8)');
A = phi*U;
alpha = max(eig(A'*A))+5;
counts = zeros(size(x));
x_new = zeros(size(x));
y = zeros(size(x));
for i=1:1:256
    for j=1:1:256
        y_patch = x(i:i+7, j:j+7);
        y_patch = phi*y_patch(:);
        lambda = 1/(2*alpha);
        theta = zeros(64, 1);
        theta_old = zeros(64, 1);
        error = 0.05;
        theta_diff = 1 + error;
        while theta_diff > error
            theta_old = theta;
            y_thr = theta + (1/alpha)*A'*(y_patch-A*theta);
            for l=1:length(y_thr)
                if y_thr(l) >= lambda
                    theta(l) = y_thr(l) - lambda;
                elseif y_thr(l) <= -lambda
                    theta(l) = y_thr(l) + lambda;
                else
                    theta(l) = 0;
                end
            end
            theta_diff = norm(theta - theta_old);
        end
        patch = U*theta;
        patch = reshape(patch, 8, 8);
        x_new(i:i+7, j:j+7) = x_new(i:i+7, j:j+7) + patch;
        counts(i:i+7, j:j+7) = counts(i:i+7, j:j+7) + 1;
    end
end
x_new = x_new./counts;
x_new = x_new(1:256,1:256);
x = x(1:256,1:256);
%%
imwrite(rescale(x_new),"2b_rec.png");
montage([rescale(x_new), rescale(x)]);
title('Reconstructed Image, Original Image')
rmse = norm(x-x_new, 'fro')/norm(x, 'fro');
disp("rmse = " + rmse);