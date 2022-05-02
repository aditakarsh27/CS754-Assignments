clc;
% clear;
load('mnist1.mat');
%% Setting up p×n matrix - X
zero_labels = (test.labels==0);
X = test.images(:,:,zero_labels);
X_3D = X;
m = 98;
s = 147;
num_samples = 10;
sigma_hat = estimator(num_samples, m, s, X_3D);


p = size(X,1)*size(X,2);
n = size(X,3);
X = reshape(X, [p  n]);

mu = mean(X, 2);
X = X - mu;

% figure(); imshow(reshape(mu, [28 28]));
% title('sample mean image');




%% Comparing eigenvalues from estimator 
img = X(:,8);
figure(); imshow(reshape(img + mu, [28 28]));
title('sample image from dataset');

[U1, S, V1] = svd(X);
% figure(); imshow(reshape(U1(:,2) + mu, [28 28]));
% title('First eigenvector of sample covariance matrix');

[V2,D] = eig(sigma_hat);
[d, ind] = sort(diag(D), 'descend');
V2 = V2(:, ind);
% figure(); imshow(reshape(V2(:,2) + mu, [28 28]));
% title('First eigenvector of estimated covariance matrix');

k = 10;
Uk = U1(:,1:k);         
alpha = (Uk.')*img;      
reconstructed_true = reshape((Uk * alpha) + mu, 28,28);
figure(); imshow(reconstructed_true);
imwrite(reconstructed_true, 'true_10.png');
title('chosen image reconstructed from top 10 eigenvectors of sample covariance matrix');

Vk = V2(:,1:k);         
beta = (Vk.')*img;      
reconstructed_approx = reshape((Vk * beta) + mu, 28,28);
figure(); imshow(reconstructed_approx);
imwrite(reconstructed_approx, 'est_10.png');
title('chosen image reconstructed from top 10 eigenvectors of estimated covariance matrix');

k = 50;
Uk = U1(:,1:k);         
alpha = (Uk.')*img;      
reconstructed_true = reshape((Uk * alpha) + mu, 28,28);
figure(); imshow(reconstructed_true);
imwrite(reconstructed_true, 'true_50.png');
title('chosen image reconstructed from top 50 eigenvectors of sample covariance matrix');

Vk = V2(:,1:k);         
beta = (Vk.')*img;      
reconstructed_approx = reshape((Vk * beta) + mu, 28,28);
figure(); imshow(reconstructed_approx);
imwrite(reconstructed_approx, 'est_50.png');
title('chosen image reconstructed from top 50 eigenvectors of estimated covariance matrix');

C_n = cov(X');
disp('RMSE:');
disp(norm(C_n-sigma_hat)/norm(C_n));


%% Graph for variation in number of samples
iters = [10 20 50 100 500 1000];
mses = zeros(size(iters,2));
for i = 1:size(iters,2)
    sigma_hat = estimator(iters(i), m, s, X_3D);
    mses(i) = norm(C_n-sigma_hat)/norm(C_n);
end

%%
plot(iters, mses);
xlabel('Number of samples');
ylabel('Relative MSE');
title('Variation of MSE with number of samples');

%% Graph for variation in gamma
s_vals = [980 490 327 245 196 163];
mses_s = zeros(size(s_vals,2));
for i = 1:size(s_vals,2)
    sigma_hat = estimator(100, m, s_vals(i), X_3D);
    mses_s(i) = norm(C_n-sigma_hat)/norm(C_n);
end

%%
plot(m./s_vals, mses);
xlabel('Compression factor');
ylabel('Relative MSE');
title('Variation of MSE with compression factor');






