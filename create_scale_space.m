function scale_space = create_scale_space(im_in, sigma)

    [rows cols] = size(im_in);
    
    % Allocate space to store all images in scale space
    scale_space = zeros(length(sigma), rows, cols);
    
    % Create all the Laplacian of Gaussian images
    for i=1:length(sigma)
                
        % Create a Gaussian with the given sigma
        %gaussian = create_gaussian(et(i));
        % Take the laplacian of the kernel
        %lap_gauss = del2(gaussian);
        
        % Construct the laplacian of gaussian for a given kernel size and sigma
        n = ceil(sigma(i)*3)*2+1;
        lap_gauss = fspecial('log', n, sigma(i));
        %lap_gauss = fspecial('gaussian', n, sigma(i));
        
        % Convolve the kernel with the image
        convolved = conv2(double(im_in).*(sigma(i)^2), double(lap_gauss), 'same');
        
        % Store the image in our scale space array
        scale_space(i,:,:) = convolved;

    end

end