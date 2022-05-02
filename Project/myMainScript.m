clc;
% clear;
load('mnist1.mat');
%% Setting up p×n matrix - X
digit = 0;
zero_labels = (test.labels==digit);
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

%% Comparing eigenvalues from estimator 
img = X(:,8);
img2D = reshape(img + mu, [28 28]);
imwrite(img2D, 'original.png');
figure(); imshow(img2D);
title('sample image from dataset');

%% Image Reconstruction
[U1, S, V1] = svd(X);

[V2,D] = eig(sigma_hat);
[d, ind] = sort(diag(D), 'descend');
V2 = V2(:, ind);

k = 10;
Uk = U1(:,1:k);         
alpha = (Uk.')*img;      
reconstructed_true = reshape((Uk * alpha) + mu, 28,28);
figure(); imshow(reconstructed_true);
imwrite(reconstructed_true, 'true_10.png');
title('chosen image reconstructed from top 10 eigenvectors of sample covariance matrix');
rmse = norm(img2D-reconstructed_true)/norm(img2D);
disp('RMSE for 10 true eigenvectors :');
disp(rmse);

Vk = V2(:,1:k);         
beta = (Vk.')*img;      
reconstructed_approx = reshape((Vk * beta) + mu, 28,28);
figure(); imshow(reconstructed_approx);
imwrite(reconstructed_approx, 'est_10.png');
title('chosen image reconstructed from top 10 eigenvectors of estimated covariance matrix');
rmse = norm(img2D-reconstructed_approx)/norm(img2D);
disp('RMSE for 10 estimated eigenvectors :');
disp(rmse);



k = 50;
Uk = U1(:,1:k);         
alpha = (Uk.')*img;      
reconstructed_true = reshape((Uk * alpha) + mu, 28,28);
figure(); imshow(reconstructed_true);
imwrite(reconstructed_true, 'true_50.png');
title('chosen image reconstructed from top 50 eigenvectors of sample covariance matrix');
rmse = norm(img2D-reconstructed_true)/norm(img2D);
disp('RMSE for 50 true eigenvectors :');
disp(rmse);

Vk = V2(:,1:k);         
beta = (Vk.')*img;      
reconstructed_approx = reshape((Vk * beta) + mu, 28,28);
figure(); imshow(reconstructed_approx);
imwrite(reconstructed_approx, 'est_50.png');
title('chosen image reconstructed from top 50 eigenvectors of estimated covariance matrix');
rmse = norm(img2D-reconstructed_approx)/norm(img2D);
disp('RMSE for 50 estimated eigenvectors :');
disp(rmse);

C_n = cov(X');
disp('RMSE of covariance matrix :');
disp(norm(C_n-sigma_hat)/norm(C_n));


%% Graph for variation in number of samples
iters = [10 20 50 100 500 1000];
mses = zeros(size(iters,2),1);
for i = 1:size(iters,2)
    sigma_hat = estimator(iters(i), m, s, X_3D);
    mses(i) = norm(C_n-sigma_hat)/norm(C_n);
end

%% Plotting
plot(iters, mses(:,1), '-o');
xlabel('Number of samples');
ylabel('Relative MSE');
title('Variation of Relative MSE with number of samples');

%% Graph for variation in gamma
s_vals = [980 490 327 245 196 163];
mses_s = zeros(size(s_vals,2),1);
for i = 1:size(s_vals,2)
    sigma_hat = estimator(1, m, s_vals(i), X_3D);
    mses_s(i) = norm(C_n-sigma_hat)/norm(C_n);
end

%% Plotting
plot(m./s_vals, mses_s, '-o');
xlabel('Compression factor');
ylabel('Relative MSE');
title('Variation of Relative MSE with compression factor');






