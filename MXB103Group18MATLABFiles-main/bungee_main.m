clear
constants

a = 0; 
b = 60;
alphay = 0; 
alphav = 0;
n = 5000;
C = c/m;
K = k/m;
dydt = @(v,y) v;
dvdt = @(v,y) g - C*abs(v)*v - max(0,K*(y-L));

[t, y, v, h] = modeuler_bungee(dydt, dvdt, a, b, alphay, alphav, n);

tiledlayout(2,2,"TileSpacing","compact")

% Checkpoint 1
ax1 = nexttile;
plot(ax1,t,y)
ylabel(ax1,'Displacement (m)') 
xlabel(ax1,'Time (sec)')
title(ax1,'Displacement of Jumper Over Time')
msgbox(['Q1: number of bounces is ' sprintf('%.0f',ceil(length(findbounce(y))/2))]);

% Checkpoint 2
ax2 = nexttile;
plot(ax2,t,v)
ylabel(ax2,'Velocity (m/s)')
xlabel(ax2,'Time (sec)')
title(ax2,'Velocity of Jumper Over Time')
ax2.YLim = [-25 25];
vbounce=findbounce(v);
msgbox(['Q2: maximum speed reached ' sprintf('%.6f',v(vbounce(1))) ' m/s']);

% Checkpoint 3
[acc,gracc] = acceleration_bungee(v,h);
accbounce=findbounce(gracc);
msgbox(['Q3: maximum acceleration reached ' sprintf('%.6f',gracc(accbounce(1))) ' G''s']);
ax3 = nexttile;
plot(t,gracc)
ylabel(ax3,{'Acceleration (g)'})
xlabel(ax3,'Time (sec)')
title(ax3,{'Amount of g''s ' ...
    'Experienced by Jumper'} )
ax3.YLim = [-2 2];

% Checkpoint 4
distance = numerical_integration(v,h);
msgbox(['Q4: Total distance travelled by jumper: ' sprintf('%.6f',distance) 'm']);

% Checkpoint 5
% findbounce: Finds the turning points of the array y 
% First turning point used as the bound as we are solving for the first instance of y=H-D (due to the bounces, y=H-D occurs multiple times after first bounce)
% root_dicrete: Finds the four points around y=H-D
% root_continuous: Uses four points found in root_discrete to interpolate a polynomial which is then used to pinpoint the time of y=H-D.
bounce = (findbounce(y));
R = root_discrete(y(1:bounce(1)),H-D);
time_ofD=root_continuous(100000,0.00000000001,t,y,H-D,R); %time when y=D
distance_ofD=lagrange(t(R),y(R),root_continuous(10000,0.00000000001,t,y,H-D,R)); % y when y=D
msgbox(['Q5: At time ' sprintf('%.6f',time_ofD) ' seconds, the jumpers will have fallen ' sprintf('%.6f',distance_ofD) ' meters']);

% Checkpoint 6
kk=18:1:77; % k: Values that are assessed. Changing can result in errors. Intervals can be changed in exchange for run time
l=0:1:50; % l: Values that are assessed
[parameter,lowestpoint]=findwatercontact(kk,l,1.75);
% lowestpoint: Shows lowest point reached for each l and kk pair. Parameter is table of l and kk values for which water touch occurs
% If the max acceleration reached by pair of l and kk values passes 2Gs, the output will be replaced with NaN
% Other functions used in water contact are made compatible with NaN inputs
ax4 = nexttile;
plot(parameter(1,:),parameter(2,:))
title(ax4,{'Values of K and L for '...
'Which Water Contact Happens'...
})
ylabel(ax4,"L - Length of Unstretched Rope (m)")
xlabel(ax4,'K - Spring Constant (N/m)')

ybounces = findbounce(y);

msgbox(['Q6: The jumper falls ' sprintf('%.6f', y(ybounces(1))) ' meters and reaches ' sprintf('%.6f', -y(ybounces(1))+H+1.75) ' meters above water level']);

% uncomment to export graphics for LaTeX
exportgraphics(ax1,'displacement-graph.eps')
exportgraphics(ax2,'velocity-graph.eps')
exportgraphics(ax3,'acceleration-graph.eps')
exportgraphics(ax4,'water-contact-graph.eps')
