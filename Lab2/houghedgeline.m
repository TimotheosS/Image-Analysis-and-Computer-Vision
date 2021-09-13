function [linepar,acc] = houghedgeline(pic, scale, gradmagnthreshold, nrho, ntheta, nlines, verbose,increment)

curves = extractedge(pic, scale, gradmagnthreshold, 'same');
mgn = Lv(pic, 'same');

[linepar, acc] = houghline(curves, mgn, nrho, ntheta, gradmagnthreshold, nlines, verbose,increment);

if verbose == 0
    figure
    subplot(1,2,2)
    overlaycurves(pic, linepar);
    axis([1 size(pic, 2) 1 size(pic, 1)]);                        
    title('Image')

    subplot(1,2,1)
    showgrey(binsepsmoothiter(acc, 0.5, 1))
    title('Hough transform, smoothed')
end

end