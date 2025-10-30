function plotData( ...
    X, ...
    YGroundTruth, ...
    YFitted, ...
    showMeanLine, ...
    titleText, ...
    legendItems, ...
    xlabelText, ...
    ylabelText, ...
    outputFile ...
)
    % --- Plot ---
    figure
 
    % Plot data points and label plot
    scatter(X, YGroundTruth, "filled");
    grid on
    
    % Plot mean line if requested
    if showMeanLine
        hold on
        meanVal = mean(YGroundTruth);
        yline(meanVal, '-r');
    end
    
    % Check if fitted values exist
    if ~isnan(YFitted)
        % Plot fitted values of model if indicated
        n_fitted_lines = size(YFitted, 2);
        for i = 1:n_fitted_lines
            hold on
            plot(X, YFitted(:, i));
        end
    end
    
    % Set labels
    xlabel(xlabelText);
    ylabel(ylabelText);
    
    % Title
    title(titleText);
    
    % Legend
    legend(legendItems, 'Location', 'best');
    
    % Save plot to PNG file
    saveas(gcf, outputFile);
end