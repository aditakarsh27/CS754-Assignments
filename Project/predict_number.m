function prediction = predict_number(image, bases, means)
    mean_shifted = image - means;
    errors = zeros(10,0);
    for i=0:9
        basis = reshape(bases(i+1,:,:), [size(bases,2) size(bases,3)]);
        alpha = basis.'*mean_shifted(:,i+1);      
        reconstructed = basis*alpha + means(:,i+1);
        errors(i+1) =  norm(image - reconstructed, 2);
    end
    [~,index] = min(errors);
    prediction = index-1;
end