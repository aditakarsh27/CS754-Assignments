clc;
% clear;
load('mnist1.mat');
%% Setting up p×n matrix - X
eigenbases_true = zeros(10,p,10);
eigenbases_approx = zeros(10,p,10);
means = zeros(28*28,10);
for i=0:9
    labels = (test.labels==i);
    X = test.images(:,:,labels);
    m = 98;
    s = 147;
    num_samples = 5;

    sigma_hat = estimator(num_samples, m, s, X);

    p = size(X,1)*size(X,2);
    n = size(X,3);
    X = reshape(X, [p  n]);

    mu = mean(X, 2);
    X = X - mu;
    means(:, i+1) = mu;
    
    [U1, S, V1] = svd(X);

    [V2,D] = eig(sigma_hat);
    [d, ind] = sort(diag(D), 'descend');
    V2 = V2(:, ind);
      
    eigenbases_true(i+1,:,:) = U1(:,1:10);
    eigenbases_approx(i+1,:,:) = V2(:,1:10);
    figure(); imshow(reshape(V2(:,1) + mu, [28 28]));
end
%%
n = 10000;
Xtest = training.images(:,:,1:n);
Xtest = reshape(Xtest, [p  n]);
TestLabels = training.labels(1:n);
TestPredictions = zeros(n,1);
for i=1:n
    TestPredictions(i,1) = predict_number(Xtest(:,i), eigenbases_approx, means);
end
Test_accuracy = sum(TestLabels==TestPredictions,'all')/size(TestPredictions,1);
disp ('Accuracy %:');
disp(Test_accuracy*100);