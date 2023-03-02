function [acc,gracc] = acceleration_bungee(v,h)
% Calculates the differential equation of v using the second order central difference method. 
% v: The dataset of the function which is being derived
% h: The time interval by which the components of v are seperated
% acc: The slope of the v (i.e, an array of the acceleration values)
% gracc: The gravatational acceleration (same as acc, just divided by 9.81)
gravity = 9.81;

acc = zeros([1,length(v)]);
acc(1) = (v(2) - v(1))/h; % Find acceleration at the beginning of the fall. The method requires the 
                          %  velocity one step before and one step after the point assessed, which cant be done here 
acc(end) = (v(end) - v(end - 1))/h; % Find acceleration at the end of the fall for ditto

for i = 2:length(v) - 1
    acc(i) = (v(i + 1) - v(i - 1))/(2*h); % Cycle through v values to find their rate of change
end

gracc = acc./gravity;
end
