function [linepar,acc] = houghline(curves, magnitude, nrho, ntheta, threshold, nlines, verbose,increment)
    % Check if input appear to be valid
    if(nargin < 7)
        error( 'Wrong # of arguments.');
    end
    
    % Allocate accumulator space
    acc_tmp = zeros(nrho, ntheta);

    % Define a coordinate system in the accumulator space (angle and distance)
    angle = linspace(-pi/2, pi/2, ntheta);
    dist = sqrt(size(magnitude, 1).^2 + size(magnitude, 2).^2);
    rhoy = linspace(-dist, dist, nrho);
    
    % From pixelplotcurves Example
    insize = size(curves, 2);
    ttrypointer = 1;
    numcurves = 0;
    
    % Loop over all the input curves
    while ttrypointer < insize
        
        % From pixelplotcurves Example
        polylength = curves(2, ttrypointer);
        ttrypointer = ttrypointer + 1;
        numcurves = numcurves + 1;
        
        % For each point on each curve
        for curveidx = 1:polylength
            
            % From pixelplotcurves Example
            x = curves(2, ttrypointer);
            y = curves(1, ttrypointer);
            ttrypointer = ttrypointer + 1;

            % Keep value from magnitude image
            magn_xy = abs(magnitude(round(x), round(y)));
            
            % Check if valid point with respect to threshold
            if magn_xy > threshold

                %Loop over a set of theta vals - rotate around point
                for theta_index = 1:ntheta
                    % Compute rho for each theta value
                    rho_val = x*cos(angle(theta_index)) + y*sin(angle(theta_index));

                    %Compute index values in the accumulator space
                    rho_index = find(rhoy < rho_val, 1, 'last');

                    %Update the accumulator
                    acc_tmp(rho_index, theta_index) = acc_tmp(rho_index, theta_index) + increment(rho_index, theta_index);
                end
            end
        end
    end
        
    % Extract local maxima from the accumulator and sort them
    % As given in the lab descriptions
    [pos,value] = locmax8(acc_tmp);
    [dummy,indexvector] = sort(value);
    nmaxima = size(value, 1);

    % Compute a line for each one of the strongest responses in the accumulator
    for index = 1:nlines + 1
        rho_index = pos(indexvector(nmaxima - index + 1), 1);
        theta_index = pos(indexvector(nmaxima - index + 1), 2);
        
        rho = rhoy(rho_index);
        theta = angle(theta_index);
        linepar(:,index) = [rho; theta];

        x0 = 0;
        y0 = (rho - x0 * cos(theta))./sin(theta);
        dx = dist.^2;
        dy = (rho - dx * cos(theta))./sin(theta);
        
        % Overlay these curves on the gradient magnitude image
        %Given in lab description - visualizing results
        outcurves(1, 4*(index-1) + 1) = 0;          
        outcurves(2, 4*(index-1) + 1) = 3;
        outcurves(2, 4*(index-1) + 2) = x0 - dx;
        outcurves(1, 4*(index-1) + 2) = y0 - dy;
        outcurves(2, 4*(index-1) + 3) = x0;
        outcurves(1, 4*(index-1) + 3) = y0;
        outcurves(2, 4*(index-1) + 4) = x0+dx;
        outcurves(1, 4*(index-1) + 4) = y0+dy;
    end

    %Return the output data
    linepar = outcurves;
    acc = acc_tmp;
end