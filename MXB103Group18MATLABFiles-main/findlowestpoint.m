function [B] = findlowestpoint(k,l,height)
% Finds the lowest point of the jump. 
% the acceleration array of each kk and l pair are determind, and the first maximum local maximum acceleration is found through by feeding the acceleration array to findbounce and using its first output.
% If the acceleration is under 2Gs, the output will be the lowest point of the jump, otherwise it will be 'nan'.
% Inputs
% - k: Elastisity of the rope
% - l: Length of the rope
% - height: The height of the jumper
% Outpus
% - B: Lowest point, if acceleration exceeds 2Gs, output will be 'nan'.
B = zeros(length(k),length(l));
a = 0; 
b = 60;
alphay = 0; 
alphav = 0;
H = 74; % m, Height of jump point
c = 0.9; % kg/m, Drag coefficient
m = 80; % kg, Mass of jumper
g = 9.8; % m/s^2, Gravitational acceleration
n = 5000;
C = c/m;
for i = 1:length(k)
    K = k(i)/m;
    for j = 1:length(l)
        L = l(j);
        dydt = @(v,y) v;
        dvdt = @(v,y) g - C*abs(v)*v - max(0,K*(y - L));
        [t, y, v, h] = modeuler_bungee(dydt, dvdt, a, b, alphay, alphav, n);
        [acc,gracc] = acceleration_bungee(v,h);
        fg = findbounce(gracc);
        if abs(gracc(fg(1))) <= 2
           fy = findbounce(y);
           B(i,j) = H - height - y(fy(1));
        else 
           B(i,j) = NaN;
        end
     end
end
end
