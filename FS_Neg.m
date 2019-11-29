function [ETA,F,DF,DDF,DELTA,THETA,H,m] = FS_Neg(eta,s,m0)

    eps = 1e-12;

    n = 1;      % iteration var.
    nmax = 30;  % maximum iterations

    m = m0;
    while n <= nmax
%         fprintf('computing Falkner_Skan_Flow : m = %5.4f , s = %5.4f , n = %2d\n',m,s,n);
        x0 = [0;0;s; 0;0;0];     % initial condition

         [ETA,X] = ode45(@FSeq_Neg,eta,x0,[],m);

        f = X(:,1);    % f
        u = X(:,2);    % df
        v = X(:,3);    % ddf
        r = X(:,5);    % dr/dm = dphi/dm

        phi = u(end)-1;
        dphi = r(end);
        m = m - phi/dphi;
        
        F = f;
        DF = u;
        DDF = v;
        DELTA = trapz(eta,1-u);
        THETA = trapz(eta,u.*(1-u));
        H = DELTA/THETA;
        
        if abs(phi/dphi) < eps
            break
        end
        n = n+1;
    end
    if n>nmax
        disp('FS_Neg.m‚ªŽû‘©‚µ‚Ä‚¢‚Ü‚¹‚ñ');
    end
end