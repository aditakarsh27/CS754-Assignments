%% (a)
addpath("./MMread");
cars = mmread('./data/cars.avi');
for i=1:length(cars.frames)
    cars.frames(i).cdata = rgb2gray(cars.frames(i).cdata);
end
T = 3;
H = 120;
W = 240;
F = zeros(H, W, T);
for t=1:T
    F(:,:,t) = cars.frames(t).cdata(end-119:end,end-239:end);
    imwrite(cars.frames(t).cdata(end-119:end,end-239:end), ['./images/cars_frame', int2str(t), '.png']);
end

%% (b)

C = randi([0,1], H, W, T);
E = sum(C .* F, 3);

sigma = 2;
rng('default'); % For reproducibility
N = normrnd(0, sigma, H, W);
E_noisy = E + N;
imshow(rescale(E_noisy));
title("Coded Snapshot");
imwrite(rescale(E_noisy), './images/coded_snap.png');

%(c) In report

%% (d), (e)
p = 8;
eps = 25;
F_re = get_recons(E_noisy, C, p, eps);
%% 
for t=1:T
    imwrite([rescale(F_re(:,:,t)) rescale(F(:,:,t))], ['./images/cars_T3re', int2str(t), '.png']);
    figure;
    imshow([rescale(F_re(:,:,t)) rescale(F(:,:,t))]);
    title("t = " + int2str(t) + " of 3");
end
rmse = mean((F_re - F).^2,'all') / mean(F.^2, 'all');
disp("T = 3 RMSE");
disp(rmse);


%% (f)
T = 5;
F = zeros(H, W, T);
for t=1:T
    F(:,:,t) = cars.frames(t).cdata(end-119:end,end-239:end);
    imwrite(cars.frames(t).cdata(end-119:end,end-239:end), ['./images/cars_frame', int2str(t), '.png']);
end
C = randi([0,1], H, W, T);
E = sum(C .* F, 3);
rng('default'); % For reproducibility
N = normrnd(0, sigma, H, W);
E_noisy = E + N;
imshow(rescale(E_noisy));
title("Coded Snapshot");
imwrite(rescale(E_noisy), './images/coded_snap2.png');
F_re = get_recons(E_noisy, C, p, eps);
for t=1:T
    imwrite([rescale(F_re(:,:,t)) rescale(F(:,:,t))], ['./images/cars_T5re', int2str(t), '.png']);
    figure;
    imshow([rescale(F_re(:,:,t)) rescale(F(:,:,t))]);
    title("t = " + int2str(t) + " of 5");
end
rmse = mean((F_re - F).^2,'all') / mean(F.^2, 'all');
disp("T = 5 RMSE");
disp(rmse);

T = 7;
F = zeros(H, W, T);
for t=1:T
    F(:,:,t) = cars.frames(t).cdata(end-119:end,end-239:end);
    imwrite(cars.frames(t).cdata(end-119:end,end-239:end), ['./images/cars_frame', int2str(t), '.png']);
end
C = randi([0,1], H, W, T);
E = sum(C .* F, 3);
rng('default'); % For reproducibility
N = normrnd(0, sigma, H, W);
E_noisy = E + N;
imshow(rescale(E_noisy));
title("Coded Snapshot");
imwrite(rescale(E_noisy), './images/coded_snap3.png');
F_re = get_recons(E_noisy, C, p, eps);
for t=1:T
    imwrite([rescale(F_re(:,:,t)) rescale(F(:,:,t))], ['./images/cars_T7re', int2str(t), '.png']);
    figure;
    imshow([rescale(F_re(:,:,t)) rescale(F(:,:,t))]);
    title("t = " + int2str(t) + " of 7");
end
rmse = mean((F_re - F).^2,'all') / mean(F.^2, 'all');
disp("T = 7 RMSE");
disp(rmse);

%% (h)
flame = mmread('./data/flame.avi');
for i=1:length(flame.frames)
    flame.frames(i).cdata = rgb2gray(flame.frames(i).cdata);
end
T = 5;
H = flame.height;
W = flame.width;
F = zeros(H, W, T);
offset = 30;

for t=1:T
    F(:,:,t) = flame.frames(t).cdata();
    imwrite(flame.frames(t).cdata(), ['./images/flame_frame', int2str(t), '.png']);
end
for t=1:T
    F(:,:,t) = flame.frames(offset+t).cdata;
end
C = randi([0,1], H, W, T);
E = sum(C .* F, 3);
rng('default'); % For reproducibility
N = normrnd(0, sigma, H, W);
E_noisy = E + N;
imshow(rescale(E_noisy));
title("Coded Snapshot");
imwrite(rescale(E_noisy), './images/coded_snap4.png');
F_re = get_recons(E_noisy, C, p, eps);
for t=1:T
    imwrite([rescale(F_re(:,:,t)) rescale(F(:,:,t))], ['./images/flame_re', int2str(t), '.png']);
    figure;
    imshow([rescale(F_re(:,:,t)) rescale(F(:,:,t))]);
    title("t = " + int2str(t) + " of 5");
end
rmse = mean((F_re - F).^2,'all') / mean(F.^2, 'all');
disp("T = 5 flame RMSE");
disp(rmse);

