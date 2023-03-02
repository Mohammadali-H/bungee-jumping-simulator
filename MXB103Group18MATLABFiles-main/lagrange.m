function T = lagrange(X, Y, x)
% The Lagrange method of data interpolation.
% Inputs
% - X: an array of values of the independent variable.
% - Y: an array of the dependent variable coresponding to X. 
% - x: a constant. the independent variable that is being assessed to find its coresponding dependent variable.
% Outputs
% - T: the dependant variable that coresponds to x
    if length(X) ~= length(Y)
        error('two arrays must equal in length.');
    end

S = ones(1,length(X));

for j = 1:length(Y)
    XX = X;
    XX(j:end - 1) = XX(j + 1:end);

    for i = 1:length(X) - 1

        S(j) = S(j)*(x - XX(i))/(X(j) - XX(i));%This is the bulk of the code. The rest is there to make this work.

    end
    
    S(j) = S(j)*Y(j);
    
end

T = sum(S);

end
