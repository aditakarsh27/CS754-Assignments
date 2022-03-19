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
I1 = iradon(meas1, angles, 'spline', 'Ram-Lak');
imshow(I1);
imwrite(I1, 'a50.png');
title('Slice 50- Filtered Backprojection with Ram-Lak filter');
I2 = iradon(meas2, angles, 'spline', 'Ram-Lak');
figure();
imshow(I2);
imwrite(I2, 'a51.png');
title('Slice 51- Filtered Backprojection with Ram-Lak filter');

%% (b) independent CS-based reconstruction
y1 = meas1(:);
m = size(y1,1);
n = size(slice1(:), 1);
lambda = 0.1;
rel_tol = 1e-6;
quiet = true;
A = A3b();
At = At3b();
[beta, status] = l1_ls(A, At, m, n, y1, lambda, rel_tol, quiet);
rec1 = idct2(reshape(beta, 217, 217));
figure();
imshow(rec1);

%%
close all;

