load('mnist.mat');
%%
X_test = double(mnist{2,1}');
X_label = double(mnist{2,2});
X_0 = X_test(X_label==0);
%%
p = 784;
n = size(X_0,2);
m = 400;
s = 10;
R = binornd(1, 1/s, n,p,m);
pos = binornd(1,0.5, n,p,m);
pos(pos==0)= -1;
R = R.*p;