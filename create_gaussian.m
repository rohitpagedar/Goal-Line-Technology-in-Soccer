
%
function im_out = create_gaussian(sigma)

    % The size of the kernal
    n = ceil(sigma*3)*2+1;
    % Allocate space for the output
    im_out = zeros(n);
    
    % Use the same sigma for x and y
    sigma_x = sigma;
    sigma_y = sigma;
    
    % This Gaussian is not rotated
    theta = 0;
   
    % Compute coefficients
    a = (cos(theta)^2 / (2*sigma_x^2)) + (sin(theta)^2 / (2*sigma_y^2));
    b = (-sin(2*theta) / (4*sigma_x^2)) + (sin(2*theta) / (4*sigma_y^2));
    c = (cos(theta)^2 / (2*sigma_y^2)) + (sin(theta)^2 / (2*sigma_x^2));
          
    % These are the array indices
    i=1;
    j=1;
    
    % Loop over size
    for u=linspace(-n/2,n/2,n)
        
        % Loop over size
        for v=linspace(-n/2,n/2,n)
       
            % Compute the Gaussian at this location
            im_out(i,j) = exp(-(a*u^2 + 2*b*u*v + c*v^2));
            
            % Increment the j index
            j=j+1;
            
        end
        
        % Reset the j index
        j=1;
        % Increment the i index
        i=i+1;
        
    end

end