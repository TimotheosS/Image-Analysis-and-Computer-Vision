function pixels = Lvv(inpic, shape)
    if (nargin < 2)
        shape = 'same';
    end
    
    dx = [0 0 0 0 0;0 0 0 0 0;0 -0.5 0 0.5 0;0 0 0 0 0;0 0 0 0 0];
    dy = dx';
    
    dxx = [0 0 0 0 0;0 0 0 0 0;0 1 -2 1 0;0 0 0 0 0;0 0 0 0 0];
    dyy = dxx';
    
    dxy = conv2(dx, dy, shape);

    Lx = filter2(dx, inpic, shape);
    Ly = filter2(dy, inpic, shape);
    Lxx = filter2(dxx,inpic,shape);
    Lyy = filter2(dyy,inpic,shape);
    Lxy = filter2(dxy,inpic,shape);
    
    pixels = ((Lx.^2).*Lxx + 2*Lx.*Lxy.*Ly + (Ly.^2).*Lyy);
    
end