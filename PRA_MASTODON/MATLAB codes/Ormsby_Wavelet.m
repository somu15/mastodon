function [t,A] = Ormsby_Wavelet(f1, f2, f3, f4, ts, F)


t = 0:0.001:2;

% C1 = (pi*f4)^2/(pi*f4-pi*f3)*sinc(pi*f4*t).^2;
% 
% C2 = (pi*f3)^2/(pi*f4-pi*f3)*sinc(pi*f3*t).^2;
% 
% C3 = (pi*f2)^2/(pi*f2-pi*f1)*sinc(pi*f2*t).^2;
% 
% C4 = (pi*f1)^2/(pi*f2-pi*f1)*sinc(pi*f1*t).^2;
% 
% 
% A = (C1-C2)-(C3-C4);
% A = F*A;

C1 = pi*f4^2/(f4-f3)*sinc(pi*f4*(t-ts)).^2;
C2 = pi*f3^2/(f4-f3)*sinc(pi*f3*(t-ts)).^2;
C3 = pi*f2^2/(f2-f1)*sinc(pi*f2*(t-ts)).^2;
C4 = pi*f1^2/(f2-f1)*sinc(pi*f1*(t-ts)).^2;

A = (C1-C2)-(C3-C4);
A = F*A;

end