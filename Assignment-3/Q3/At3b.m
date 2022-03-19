classdef At3b
   methods
       function obj = At3b()
       end
       function res = mtimes(A, y)
                y = reshape(y, 309, 18);
                angles = 0:10:170;
                beta = iradon(y, angles, 'spline', 'Ram-Lak', 1, 217);
                res = dct2(beta);
                res = res(:);
       end
   end
end