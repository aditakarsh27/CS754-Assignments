addpath('./l1_ls_matlab');
rng(0,'twister');

%% Generating data
x = zeros(500,1);
ind = randperm(500,18);
for i = ind
    x(i) = 1000*rand;
end
m = 200;
n = 500;
phi = randi([0 1],m,n);
phi(phi==0)=-1;  % Bernoulli matrix with +1,-1
sigma = 0.0005*sum(abs(phi*x))/m;


lambdas = [5e-4, 1e-4, 5e-3, 1e-3, 0.01, 0.05, 0.1, 0.5, 1, 2, 5];
g = 1;
x_est = zeros(500,11);  %For storing all different measurements

V = randperm(200,20);   %Validation set
R = setdiff(1:200,V);
rel_tol = 1e-5;
y = phi*x + sigma*randn(m,1); % measurement with noise
quiet = true;
y_R = y(R);
y_V = y(V);
phi_R = phi(R,:);
phi_V = phi(V,:);
VE = zeros(11,1);
E = zeros(11,1);
%% Trying for different lambdas
for lambda = lambdas
    [x_est(:,g),status] = l1_ls(phi_R,y_R,lambda,rel_tol,quiet);
    VE(g) = sum((y_V-phi_V*x_est(:,g)).^2)/20;
    E(g) = norm(x_est(:,g)-x, 'fro')/norm(x, 'fro');
    g = g+1;
    display(status);  
end

%% Plots
figure;
plot(log(lambdas),VE, '-o');
title("Validation error vs lambdas");
xlabel('lambdas') 
ylabel('Validation error') 

figure;
plot(log(lambdas),E, '-o');
title("RMS error vs lambdas");
xlabel('lambdas') 
ylabel('RMSE') 
