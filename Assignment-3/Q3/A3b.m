classdef A3b
   methods
       function obj = A3b()
       end
       function res = mtimes(A, x)
                x = reshape(x, 217, 217);
                beta = idct2(x);
                angles = 0:10:170;
                res = radon(beta, angles);
                res = res(:);
       end
   end
end