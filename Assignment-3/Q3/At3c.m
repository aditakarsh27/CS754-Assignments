classdef At3c
   methods
       function obj = At3c()
       end
       function res = mtimes(A, y)
                len = length(y);
                y1 = y(1:len/2);
                delta_y = y(len/2 + 1:end);
                y1 = reshape(y1, 309, 18);
                delta_y = reshape(delta_y, 309, 18);
                angles = 0:10:170;
                angles2 = 0:10:175;
                beta1 = iradon(y1, angles, 'spline', 'Ram-Lak', 1, 217);
                delta_beta = iradon(delta_y, angles2, 'spline', 'Ram-Lak', 1, 217);
                res1 = dct2(beta1);
                res2 = dct2(delta_beta);
                res = [res1(:) + res2(:); res2(:)];
       end
   end
end