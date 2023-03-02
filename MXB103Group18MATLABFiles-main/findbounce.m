function B = findbounce(y)
% Find the turning points or "bounces" of a set of data
condition = sign(y(2) - y(1)); % Get the initial gradient of the dataset
j = 1;
for i = 1:length(y)-1
    % Check if the sign of the gradient has changed
    if sign(y(i + 1) - y(i)) ~= condition
        % If so, the location of the turning point is saved in B
        B(j) = i + 1;
        j = j + 1;
        %The new sign of the gradient is saved in condition.
        condition = sign(y(i + 1) - y(i)); 
    end
end
