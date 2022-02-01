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
    imwrite(cars.frames(t).cdata(end-119:end,end-239:end), ['./images/cars_frame',int2str(t),'.png']);
end

%% (b)

C = randi([0,1], H, W, T);
E = sum(C .* F, 3);

sigma = 2;
N = normrnd(0, sigma, H, W);
E_noisy = E + N;
imshow(rescale(E_noisy));
title("Coded Snapshot");
imwrite(rescale(E_noisy), './images/coded_snap.png');

%% 