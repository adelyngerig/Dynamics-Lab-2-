function [v_mod] = LCSMODEL(r, d, l, theta, w)
    % Derivation of angle beta with respect to distance d and angle theta
    beta = asind((d - r * sind(theta)) / l);
    
    % Velocity model calculation
    v_mod = (-r .* sind(theta) .* w) - (r .* tand(beta) .* cosd(theta));
end
