% éQçl:Tuncer Cebeciíò,Stability and Transition:Theory and Application,pp78-81

function dx = FSeq_Neg(eta,x,m)
    % x = [x(1);x(2);x(3)] = [f;df;ddf] = [f;u;v];
    % dx = [dx(1);dx(2);dx(3)] = [df;ddf;dddf] = [u;v;w];
    % X = [p;r;q];
    % dX = [r;q;dq];
    
    f = x(1);
    u = x(2);
    v = x(3);
    w = -(m+1)/2*f*v - m*(1-u^2);   % (4A.3)
    
    p = x(4);
    r = x(5);
    q = x(6);
    dq = -((f*v)/2 + (m+1)/2*(p*v+f*q) + 1 - u^2 -2*m*u*r); % (4A.13c)
    dx=[u;v;w; r;q;dq];
end