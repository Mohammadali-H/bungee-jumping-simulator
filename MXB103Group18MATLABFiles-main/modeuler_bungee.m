function [t, y, v, h] = modeuler_bungee(dydt, dvdt, a, b, alphay, alphav, n)
h = (b - a)/(n - 1); 
t = a:h:b;

y = zeros(size(t));
v = zeros(size(t));

y(1) = alphay;    % Initial height
v(1) = alphav;    % Initial velocity
for i = 1:(n - 1)
    yk1 = h*dydt(v(i),y(i)); %solving for yk1

    vk1 = h*dvdt(v(i),y(i)); %solving for vk1 
    %(we need both yk1 and vk1 to find the next step (aka. yk2 and vk2) as v and y depend on each other)

    yk2 = h*dydt(v(i) + vk1,y(i)+yk1); %solving for yk2
    %here vk1 is the same as h and yk1 is the same as k1 in the prac for
    %refrence

    vk2 = h*dvdt(v(i) + vk1,y(i)+yk1); %solving for vk2
    %here vk1 is the same as h and yk1 is the same as k1 in the prac for
    %refrence

    y(i+1) = y(i) + 0.5*(yk1 + yk2);  % filling y array for each time interval
    v(i+1) = v(i) + 0.5*(vk1 + vk2);  % filling v array for each time interval
end
end
