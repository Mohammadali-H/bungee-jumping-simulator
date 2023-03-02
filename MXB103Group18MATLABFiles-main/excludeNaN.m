function B = excludeNaN(y)
% Removes 'nan' components of an array 'y' amd returns that array without its 'nan' componants in the array 'B'.
f = isnan(y);
B=zeros(1,abs(sum(f-1)));
j = 1;
for i = 1:length(y)
    if f(i) == 0
    B(j) = y(i);
    j = j + 1;
    end
end
