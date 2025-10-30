function main(dataFile, configFile, outputFile)
    % --- Read Data ---
    dataTbl = readtable(dataFile);
    configTbl = readtable(configFile, 'Delimiter', ',');
    
    % Extract data columns
    dates = dataTbl{:,1};
    values = dataTbl{:,2};
    
    % Parse configuration parameters
    % Initialize flags
    showMeanLine = strcmp(configTbl{1,2}, 'yes');
    modelType = configTbl{2,2};
    modelParamsstr = split(configTbl{2,3}, '_');
    modelParams = str2double(modelParamsstr);
    xlabel = configTbl{3,2};
    ylabel = configTbl{4,2};
    legendItems = ["Data"];

    % Fit polynomial or HP Ridge model
    % Based on value of modelType
    % Otherwise raise exception and quit.
    if strcmp(modelType, 'poly')
        Py = fitPolynomial(dates, values, modelParams);
        title = "Polynomial Fit";
        paramType = "Order";
        legendFormat = '%s %d';
    elseif strcmp(modelType, 'hp_ridge')
        Py = hpRidge(values, modelParams);
        title = "Ridge Regression with HP Filter";
        paramType = "Lambda";
        legendFormat = '%s %f';
    else
        Py = NaN;
        title = "";
    end

    % Construct legend
    if showMeanLine
        legendItems = [legendItems, "Mean Line"];
    end
    if ~isnan(Py)
        for i=1:length(modelParams)
            label = sprintf(legendFormat, paramType, modelParams(i));
            legendItems = [legendItems, label];
        end
    end

    % Plot Data
    plotData(...
        dates, ...
        values, ...
        Py, ...
        showMeanLine, ...
        title, ...
        legendItems, ...
        xlabel, ...
        ylabel, ...
        outputFile ...
    );
end