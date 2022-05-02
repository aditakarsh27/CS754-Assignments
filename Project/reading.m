clc;
% clear;
% load('mnist1.mat');
%% Setting up p×n matrix - X
zero_labels = (training.labels==0);
X = training.images(:,:,zero_labels);
p = size(X,1)*size(X,2);
n = size(X,3);
X = reshape(X, [p  n]);

image(reshape(X(:,36), [28 28])*255);
%% Generate random p×m projection matrices
m = 40;
s = 100;
R = binornd(1, 1/s, n,p,m);
pos = binornd(1,0.5, n,p,m);
pos(pos==0)= -1;
R = R.*p;
%% Get projectections, Y m×n and Xhat p×n
Y = zeros(m,n);
Xhat = zeros(p,n);
for i=1:n
    Ri = reshape(R(i,:,:), [p m]);
    Y(:,i) = Ri.' * X(:,i);
    Xhat(:,i) = Ri * Y(:,i);
end
%% Estimate Covariance, Σ p×p








