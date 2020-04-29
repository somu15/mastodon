clear all
clc

%% 1D solution with domain x = [0, 1] and IC: f(x) = sin(x)-cos(x); g(x) = 0

clear all
clc
N = 10000;

t = 0.01:0.0025:10;
result = zeros(1,length(t));

for ii = 1:100
   
    result = result + fx(ii) * cos(ii*pi*t) * sin(ii*pi*0.5);
    
end

plot(t, result)

function [alpha] = fx(n)

alpha = 2*quadgk(@(x) ((sin(pi*x)+sin(3*pi*x)+sin(5*pi*x)+sin(7*pi*x)+sin(9*pi*x)).*sin(n*pi*x)), 0, 1);

end
