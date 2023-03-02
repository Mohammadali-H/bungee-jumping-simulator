function T = root_discrete (X, x)
% Uses the bisection method to find the index of the four points of the array X around the point x
% Inputs
% - X: an array of numbers
% - x: a constant.
% Outputs
% - T: an array of four indicies from X that are are around x.
a = 1;
b = length(X);

if X(b) > X(a) && X(b) > x && X(a) < x

    while (b - a) ~= 1
          c = ceil((b + a)/2);
          if X(c) > x
             b = c;
          else
             a = c;
          end
    end
    T = [a - 1,a,b,b + 1];

elseif X(a) > X(b) && X(a) > x && X(b) < x
    while (b - a) ~= 1
          c = ceil((b + a)/2);
          if X(c) > x
             a = c;
          else
             b = c;
          end
    end
    T = [a - 1,a,b,b + 1];
else 
    T = [nan,nan,nan,nan];
end
