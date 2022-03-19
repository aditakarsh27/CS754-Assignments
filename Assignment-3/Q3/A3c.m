classdef A3c
   methods
       function obj = A3c()
       end
       function res = mtimes(A, x)
            len = length(x);
            x1 = x(1:len/2);
            delta_x = x(len/2+1:end);
            delta_x = reshape(delta_x, 217, 217);
            x1 = reshape(x1, 217, 217);
            beta = idct2(x1);
            delta_beta = idct2(delta_x);
            angles = 0:10:170;
            angles2 = 0:10:175;
            res1 = radon(beta, angles);
            res2 = radon(beta, angles2);
            res3 = radon(delta_beta, angles2);
            res = [res1(:); res2(:) + res3(:);];
       end
   end
end