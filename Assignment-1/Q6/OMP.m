function theta = OMP(y, A, eps)
    r = y;
    theta = zeros(size(A, 2), 1);
    T = [];
    A = normc(A);
    i = 0;
    while (norm(r) > eps && i < size(A, 2))
        [~, j] = max(abs(r' * A));
        T = [T j];
        A_T = A(:, T);
        theta(T) = pinv(A_T) * y;
        r = y - A_T * theta(T);
        i = i + 1;
    end
end