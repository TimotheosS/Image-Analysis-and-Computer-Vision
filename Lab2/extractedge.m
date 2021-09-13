function edgecurves = extractedge(inpic, scale, threshold, shape)

    if (nargin < 4)
        shape = 'same';
    end
    
    smoothed = discgaussfft(inpic, scale);

    Lv_init = Lv(smoothed, shape);

    Lvv_t = Lvv(smoothed, shape);
    Lvvv_t = Lvvv(smoothed, shape);

    %Masks
    Lv_mask = (Lv_init > threshold) - 0.5;
    Lvvv_mask = (Lvvv_t < 0) - 0.5;

    %Look at when crossing zero
    edgecurves = zerocrosscurves(Lvv_t, Lvvv_mask);
    edgecurves = thresholdcurves(edgecurves, Lv_mask);

end