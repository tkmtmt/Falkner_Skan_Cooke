% éQçl:Tuncer Cebeciíò,Stability and Transition:Theory and Application,pp78-80

function dx = FSeq_Pos(eta,x,m)
    % x = [x(1);x(2);x(3)] = [f;df;ddf] = [f;u;v];
    % dx = [dx(1);dx(2);dx(3)] = [df;ddf;dddf] = [u;v;w];
    % X = [F;U;V];
    % dX = [U;V;W];

    f = x(1);
    u = x(2);
    v = x(3);
    w = -(m+1)/2*f*v - m*(1-u^2);   % (4A.3)

    F = x(4);
    U = x(5);
    V = x(6);
    W = -(m+1)/2*(f*V+F*v) + 2*m*u*U;   % (4A.8)
    dx=[u;v;w; U;V;W];
end