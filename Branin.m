function out = Branin(x)

out = ( x(2) - 5*x(1)^2/(4*pi^2) + 5*x(1)/pi - 6 )^2 ...
    + 10 * ( 1 - 1/(8*pi) ) * cos( x(1) ) + 10;

end