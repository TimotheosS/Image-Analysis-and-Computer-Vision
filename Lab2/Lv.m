function pixels = Lv(inpic, shape)

    if (nargin < 2)
        shape = 'same';
    end
    
    dymask = [1 2 1;0 0 0;-1 -2 -1];
    dxmask = dymask';

    Lx = filter2(dxmask, inpic, shape);
    Ly = filter2(dymask, inpic, shape);
    
    pixels = sqrt(Lx.^2 + Ly.^2);