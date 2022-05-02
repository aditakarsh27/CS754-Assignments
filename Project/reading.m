clc;
clear;
load('mnist1.mat');
%% Setting up p×n matrix - X
zero_labels = (training.labels==0);
X = training.images(:,:,zero_labels);
p = size(X,1)*size(X,2);
n = size(X,3);
X = reshape(X, [p  n]);

mu = mean(X, 2);
X = X - mu;

figure(); imshow(reshape(X(:,1) + mu, [28 28]));
title('sample image from dataset');
figure(); imshow(reshape(mu, [28 28]));
title('sample mean image');
%% Generate random p×m projection matrices
m = 40;
s = 60;
k = s-3;
R = binornd(1, 1/s, n,p,m);
pos = binornd(1, 0.5, n,p,m);
pos(pos==0) = -1;
R = R.*pos;
%% Get projectections, Y m×n and Xhat p×n
Y = zeros(m,n);
X_hat = zeros(p,n);
for i=1:n
    Ri = reshape(R(i,:,:), [p m]);
    Y(:,i) = Ri.' * X(:,i);
    X_hat(:,i) = Ri * Y(:,i);
end
%% Estimate Covariance, Σ p×p
C_hat = s^2/((m + m^2)*n) * (X_hat * X_hat.');

a1 = k/(m+k+1);
a2 = (m+1)/((m+1+k)*(m+1+k+p));
I_pp = eye(p,p);
diag_C_hat = I_pp.*C_hat;

sigma_hat = C_hat - a1*diag_C_hat - a2*trace(C_hat)*I_pp;
%% Comparing eigenvalues
[U1, S, V1] = svd(X);
figure(); imshow(reshape(U1(:,1) + mu, [28 28]));
title('First eigenvector of sample covariance matrix');

[V2,D] = eig(sigma_hat);
[d, ind] = sort(diag(D), 'descend');
V2 = V2(:, ind);
figure(); imshow(reshape(V2(:,1) + mu, [28 28]));
title('First eigenvector of estimated covariance matrix');

% Uk = U(:,1:K(i));         
% alpha = (Uk.')*im1;      
% im2 = (Uk * alpha) + mu;
% im3 = reshape(im2,112,92);
% figure(); imshow(im3/255);







