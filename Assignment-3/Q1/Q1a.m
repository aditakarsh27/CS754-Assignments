x = double(imread("barbara256.png"));
n = 2*randn(size(x));
y = x+n;
U = kron(dctmtx(8)', dctmtx(8)');
A = U;
alpha = max(eig(A'*A))+0.1;
counts = zeros(size(x));
x_new = zeros(size(x));
for i=1:1:256-7
    for j=1:1:256-7
        y_patch = y(i:i+7, j:j+7);
        y_patch = y_patch(:);
        lambda = 1/(2*alpha);
        theta = zeros(64, 1);
        theta_old = zeros(64, 1);
        error = 0.005;
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
imwrite(rescale(x_new),"1a_rec.png");
imwrite(rescale(y),"1a_noisy.png");
montage([rescale(y), rescale(x_new), rescale(x)]);
title('Noisy Image, Reconstructed Image, Original Image')
rmse = norm(x-x_new, 'fro')/norm(x, 'fro');
disp("rmse = " + rmse);