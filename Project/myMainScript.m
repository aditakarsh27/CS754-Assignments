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
figure(); imshow(reshape(X(:,1) + mu, [28 28]));
title('sample image from dataset');
figure(); imshow(reshape(mu, [28 28]));
title('sample mean image');



%% Comparing eigenvalues from estimator 
% [U, S, V] = svd(X);
% figure(); imshow(reshape(U(:,1) + mu, [28 28]));
% title('First eigenvector of sample covariance matrix');
% 
% [V,D] = eig(sigma_hat);
% [D, ind] = sort(D);
% U = U(:, ind);
% figure(); imshow(reshape(V(:,1) + mu, [28 28]));
% title('First eigenvector of estimated covariance matrix');

C_n = cov(X');
display(norm(C_n-sigma_hat)/norm(C_n));






