function ideal = idealFun(n)
switch n
    case 1
        ideal = @(t) - 2*exp(-t) - 3*exp(-t/6) + 5;
    case 2
        ideal = @(t) exp( - t/5)*cos(t)+exp( - t/5)*sin(t);
    case 3
        ideal = @(t) cos(t);
    case 4
        ideal = @(t) exp(2*t)*( - 10*cos(4*t) - 7.5*sin(4*t));
    case 5
        ideal = @(t) 1.75*exp(6*t) +0.25*exp(2*t);
end
