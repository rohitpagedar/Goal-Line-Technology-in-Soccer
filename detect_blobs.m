
function blobs = detect_blobs(im_in, threshold, t, padding)

    
    if (nargin() < 4)
        padding = [10 10];
    end
    if (nargin() < 3)
        t = 1.0:0.1:3.0;
    end
    if (nargin() < 2)
        threshold = 0.35;
    end
    
    

    
    % Convert input to double
    im_in = double(im_in)./255.0;
    
    % Padd the image with whitespace
    pad_x = 10;
    pad_y = 10;
    im_in = pad_image(im_in, padding(1), padding(2), 1.0);
    
    [rows cols] = size(im_in);
    
    % Create a log sampling scale space
    et = exp(t);
    
    % Create our scale space
    all_ims = create_scale_space(im_in, et);
    
    blobs = {};
    
    % Now find centers of blobs
    for i=1:length(et)
        
        for j=1:rows
            
            for k=1:cols
            
                if ((is_maximum(all_ims, i, j, k)) && (all_ims(i,j,k) >= threshold))
                    
                    blobs{end+1} = [j-padding(1) k-padding(2) et(i) all_ims(i,j,k)];
                    
                end
                
            end
            
        end
        
    end

end