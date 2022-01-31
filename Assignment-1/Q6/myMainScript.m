%% (a)
addpath("./MMread");
cars = mmread('./data/cars.avi');
for i=1:length(cars.frames)
    cars.frames(i).cdata = rgb2gray(cars.frames(i).cdata);
end
T = 3;
H = cars.height;
W = cars.width;
frames = zeros(H, W, T);
for t=1:T
    frames(:,:,t) = cars.frames(i).cdata;
end