function [paremeters_of_water_touch,lowestpoint] = findwatercontact(kk,l,height)
% Find all the lowest points for all pairs of l and kk values
% Inputs
% - kk: Elastisity of the rope
% - l: Length of the rope
% - height: The height of the jumper
% This output is called 'lowestpoint'.
% Using the lowest point of kk and l pairs,
% the lagrange function, the discreet_root function and the continuous root function,
% the l and kk pairs for which water touch occurs are estimated (this output is called 'paremeters_of_water_touch')
paremeters_of_water_touch = zeros(2,length(kk));
paremeters_of_water_touch(1,:) = kk;

lowestpoint = findlowestpoint(kk,l,height);
[a,b] = size(lowestpoint);
lowestpointzero = zeros(a,4);

for i = 1:a
    lowestpoint_1 = excludeNaN(lowestpoint(i,:));
    lowestpointzero(i,:) = root_discrete(lowestpoint_1,0);
    c = lowestpointzero(i,:);
    paremeters_of_water_touch(2,i) = root_continuous(10000,0.000000000001,l,lowestpoint_1,0,c);
end
