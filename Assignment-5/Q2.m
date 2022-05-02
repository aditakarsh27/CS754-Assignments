U = randn( 128, 128 );  % random iid ~N(0,1)
U = orth( U.' ).'; % orthogonal rows

m = [40, 50, 64, 80, 100, 120];

alpha = 0;      %decay factor for eigenvalues
lamb = zeros(128,1);
for i=1:128
    lamb(i) = (i^(-alpha));
end
Sigma_x = U*diag(lamb)*U';
zero_mean = zeros(128,1);
num = 10;
all_rmses = zeros(length(m),1);
 for i = 1:length(m)
     rmse = 0;
     for j = 1:num
         x = (mvnrnd(zero_mean, Sigma_x, 1))';  %Multivariate normal vector with mean and covariance
         phi = sqrt(1/m(i)) * randn(m(i), 128);
         x_cap = phi*x;
         sigma = 0.01 * mean(abs(x_cap));
         y = x_cap + sigma*randn(m(i),1);
         x_map = (phi' * phi/sigma^2 + inv(Sigma_x)) \ ((phi' * y)/sigma^2);
         rmse = rmse + norm(x_map-x)/sqrt(128);
     end
     rmse = rmse/num;
     all_rmses(i) = rmse;
 end
 
plot(m, all_rmses, '-o'); 
ylabel('RMSE');
xlabel('m');
title('RMSE vs m for alpha = 0');
saveas(gcf,'alpha0.png');
 %% alpha = 3
 
U = randn( 128, 128 );  % random iid ~N(0,1)
U = orth( U.' ).'; % orthogonal rows

m = [40, 50, 64, 80, 100, 120];

alpha = 3;  %decay factor for eigenvalues
lamb = zeros(128,1);
for i=1:128
    lamb(i) = (i^(-alpha));
end
Sigma_x = U*diag(lamb)*U';
zero_mean = zeros(128,1);
num = 10;
all_rmses = zeros(length(m),1);
 for i = 1:length(m)
     rmse = 0;
     for j = 1:num
         x = (mvnrnd(zero_mean, Sigma_x, 1))';  %Multivariate normal vector with mean and covariance
         phi = sqrt(1/m(i)) * randn(m(i), 128);
         x_cap = phi*x;
         sigma = 0.01 * mean(abs(x_cap));
         y = x_cap + sigma*randn(m(i),1);
         x_map = (phi' * phi/sigma^2 + inv(Sigma_x)) \ ((phi' * y)/sigma^2);
         rmse = rmse + norm(x_map-x)/sqrt(128);
     end
     rmse = rmse/num;
     all_rmses(i) = rmse;
 end
 
plot(m, all_rmses, '-o'); 
title('RMSE vs m for alpha = 3');
ylabel('RMSE');
xlabel('m');
saveas(gcf,'alpha3.png');