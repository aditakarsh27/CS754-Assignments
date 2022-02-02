function F = get_recons(E, C, p, eps)
    psi = kron(dctmtx(p)', dctmtx(p)');
    H = size(C,1);
    W = size(C,2);
    T = size(C,3);
    F = zeros(H, W, T);
    F_count = zeros(H, W, T);
    
 
    for i = 1:(H-p+1)
        for j = 1:(W-p+1)
            yk = reshape(E(i:i+p-1,j:j+p-1), [p^2,1]);
            Ak = zeros(p^2, T*p^2);
            for t = 1:T
                phikt = diag(reshape(C(i:i+p-1,j:j+p-1,t), [p^2,1]));
                Ak(:, 1+(t-1)*p^2:t*p^2) = phikt * psi;
            end
            thetak = OMP(yk, Ak, eps);
            for t = 1:T
                fkt = psi*thetak(1+(t-1)*p^2:t*p^2);
                fkt = reshape(fkt, [p,p]);
                F(i:i+p-1, j:j+p-1,t) = F(i:i+p-1, j:j+p-1,t) + fkt;
                F_count(i:i+p-1, j:j+p-1,t) = F_count(i:i+p-1, j:j+p-1,t) + ones(p, p); 
            end
        end
    end
    F = F ./ F_count;
end