function sigma_hat = estimator(num_samples, m, s, X)

% Setting up p×n matrix - X
p = size(X,1)*size(X,2);
n = size(X,3);
X = reshape(X, [p  n]);

mu = mean(X, 2);
X = X - mu;
%Generate random p×m projection matrices
K = s-3;
sigma_hat = zeros(p,p);
for num = 1:num_samples
    R = binornd(1, 1/s, n,p,m);
    pos = binornd(1, 0.5, n,p,m);
    pos(pos==0) = -1;
    R = R.*pos;
    %Get projectections, Y m×n and Xhat p×n
    Y = zeros(m,n);
    X_hat = zeros(p,n);
    for i=1:n
        Ri = reshape(R(i,:,:), [p m]);
        Y(:,i) = Ri.' * X(:,i);
        X_hat(:,i) = Ri * Y(:,i);
    end
    %Estimate Covariance, Σ p×p
    C_hat = s^2/((m + m^2)*(n-1)) * (X_hat * X_hat.');

    a1 = K/(m+K+1);
    a2 = (m+1)/((m+1+K)*(m+1+K+p));
    I_pp = eye(p,p);
    diag_C_hat = I_pp.*C_hat;

    sigma_hat_i = C_hat - a1*diag_C_hat - a2*trace(C_hat)*I_pp;
    sigma_hat = sigma_hat + sigma_hat_i;
end
sigma_hat = sigma_hat/num_samples;
end