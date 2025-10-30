function cosNoiseData(outputFile)
% Generates a 50 point sequence as daily values for a cosine
% function with a 60 day period and amplitude 1. 
% Additionally adds random noise with standard deviation 1 to the data.

    % Generate daily values in radians, 
    % where one day equals pi/30 radians.
    % This corresponds to a 60 day period.
    X = 1:50;
    X_radians = (pi / 30) * X;

    % Take the cosine of X_radians and add 
    % noise from standard normal distribution.
    Y = cos(X_radians) + randn(1, 50);

    % Combine X and Y as columns in a matrix
    % and save it as a CSV.
    out_matrix = array2table( ...
        [X(:), Y(:)], 'VariableNames', {'date', 'value'} ...
    );
    writetable(out_matrix, outputFile);
end