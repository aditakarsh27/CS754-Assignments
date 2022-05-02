clc;
% clear;
load('mnist1.mat');
%% Setting up p×n matrix - X
zero_labels = (test.labels==0);
X = test.images(:,:,zero_labels);
m = 40;
s = 60;
num_samples = 100;

sigma_hat = estimator(num_samples, m, s, X);

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
display('RMSE:');
display(norm(C_n-sigma_hat)/norm(C_n));






