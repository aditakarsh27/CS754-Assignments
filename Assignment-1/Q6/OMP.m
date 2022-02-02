function theta = OMP(y, A, eps)
    r = y;
    theta = zeros(size(A, 2), 1);
    T = [];
    A = normc(A);
    while (norm(r) > eps)
        [~, j] = max(abs(r' * A));
        T = [T j];
        A_T = A(:, T);
        theta(T) = pinv(A_T) * y;
        r = y - A_T * theta(T);
    end
end