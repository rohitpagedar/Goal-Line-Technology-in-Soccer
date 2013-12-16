%
% Creates x and y coordinates for a circle.
% 
% inputs:  
% -------
% a - the x location of the center of the circle
% b - the y location of the center of the circle
% radius - the radius of the circle
%
% outputs:  
% --------
% [x y] - arrays of x and y points 
%
function [x y] = create_circle(a, b, radius)

    % How many samples we are going to take on the circle
    samples = linspace(0,2*pi,250);
    % Calculate the x points
    x = radius.*cos(samples) + a;
    % Calculate the y points
    y = radius.*sin(samples) + b;                  
    
end