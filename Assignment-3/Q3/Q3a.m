addpath('./l1_ls_matlab');
slice1 = rescale(imread("slice_50.png"));
slice2 = rescale(imread("slice_51.png"));
slice1 = padarray(slice1, [36, 0], 0, 'post'); %Square
slice2 = padarray(slice2, [36, 0], 0, 'post'); 

% Create Measurements uniformly
angles = 0:10:170;
meas1 = radon(slice1, angles);
meas2 = radon(slice2, angles);

%% (a) Ram-Lak 
Ia1 = iradon(meas1, angles, 'spline', 'Ram-Lak');
imshow(Ia1);
imwrite(Ia1, 'a50.png');
title('Slice 50- Filtered Backprojection with Ram-Lak filter');
Ia2 = iradon(meas2, angles, 'spline', 'Ram-Lak');
figure();
imshow(Ia2);
imwrite(Ia2, 'a51.png');
title('Slice 51- Filtered Backprojection with Ram-Lak filter');

%% (b) independent CS-based reconstruction
y1 = meas1(:);
y2 = meas2(:);
m = size(y1,1);
n = size(slice1(:), 1);
lambda = 0.01;
rel_tol = 1e-5;
quiet = true;
A = A3b();
At = At3b();
[beta, status] = l1_ls(A, At, m, n, y1, lambda, rel_tol, quiet);
Ib1 = idct2(reshape(beta, 217, 217));
figure();
imshow(Ib1);
title('Slice 50- Independent CS');
imwrite(Ib1, 'b50.png');
[beta, status] = l1_ls(A, At, m, n, y2, lambda, rel_tol, quiet);
Ib2 = idct2(reshape(beta, 217, 217));
figure();
imshow(Ib2);
title('Slice 51- Independent CS');
imwrite(Ib2, 'b51.png');
%% (c) dependent CS-based reconstruction
y1 = meas1(:);
angles2 = 0:10:175;
meas2 = radon(slice2, angles2);
y2 = meas2(:);
ytot = [y1; y2];


m = size(ytot,1);
n = size(slice1(:), 1) + size(slice2(:), 1);
lambda = 0.1;
rel_tol = 1e-2;
quiet = true;
A = A3c();
At = At3c();
[beta, status] = l1_ls(A, At, m, n, ytot, lambda, rel_tol, quiet);
beta1 = beta(1:n/2);
delta_beta = beta(n/2+1:end);
beta2 = beta1 + delta_beta;
Ic1 = idct2(reshape(beta1, 217, 217));
figure();
imshow(Ic1);
title('Slice 50- Dependent CS');
imwrite(Ic1, 'c50.png');

Ic2 = idct2(reshape(beta2, 217, 217));
figure();
imshow(Ic2);
title('Slice 51- Dependent CS');
imwrite(Ic2, 'c51.png');

