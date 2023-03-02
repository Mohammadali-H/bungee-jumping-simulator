function [distance] = numerical_integration(v,h)
% Numerically integrates v using Simpsons method
% Inputs
% - v: an array of the velocity of the jumper over time.
% - h: the time step/a constant that is equal to the time interval between each component of v.
% Outputs
% - distance traveled by jumper
n = length(v);
distance = h*(abs(v(1)) + abs(v(n)))/3;%as we are not finding displacement, the sign of the v components doesnt matter and thus their aboslute values are used.
condition = 1;

for i = 2:n-1
    distance = distance + h*abs(v(i))*(3+condition)/3;
    condition = condition*-1;
end
