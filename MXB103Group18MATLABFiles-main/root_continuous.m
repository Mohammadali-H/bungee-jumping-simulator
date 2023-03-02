function T = root_continuous (max_iter, accuracy, t, y, D, R)
% Find the root by interpolating four points around the root with the
% Lagrange method and bisection.
% Inputs
% - max_iter: maximum number of iteration
% - accuracy: tolerance for which to accept the root
% - y: an array of values of the dependent veriable.
% - D: the location of the root (i.e, we are solving for t when y-D=0, or y=D).
% - R: array of the four points of y that are around D.
% Output
% - T: t value for when y=D.
if isnan(R(1))
    T = nan;
else

a = t(R(length(R)/2));
b = t(R(1 + length(R)/2));
i = 0;

if y(R(1 + length(R)/2)) > y(R(length(R)/2))
    while i < max_iter && (b - a) > accuracy
        c = lagrange(t(R), y(R), (a + b)/2);
        if c > D
            b = ( a + b)/2;
        else
            a = (a + b)/2;
        end
        i = i + 1;
    end

elseif y(R(1 + length(R)/2)) < y(R(length(R)/2))
    while i < max_iter && (b - a) > accuracy
          c = lagrange(t(R), y(R), (a + b)/2);
          if c > D
             a = (a + b)/2;
          else
             b = (a + b)/2;
          end
          i = i + 1;
    end
end

T = (a + b)/2;
end
