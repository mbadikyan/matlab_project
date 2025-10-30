function X_hat = hpRidge(Y, lambdas)
% Returns the trend component X_hat from the observed time series
% Y that minimizes the penalized least squares problem from the 
% first page of this paper:
% https://www.jstage.jst.go.jp/article/jjss/45/2/45_121/_pdf

% lambda is a hyperparameter that controls the severity of the
% ridge penalty term. Low values of lambda can lead to overfitting.
    
    % First row of second order difference matrix D is 
    % [1, -2, 1, 0, ..., 0]
    % Second row is [0, 1, -2, 1, 0, ..., 0], etc.
    T = length(Y);
    D = zeros(T-3, T);
    n_lambdas = length(lambdas);

    % Assign tridiagonal values of D
    for i = 1:(T-2)
        D(i, i) = 1;
        D(i, i+1) = -2;
        D(i, i+2) = 1;
    end

    % Compute the extracted trend as column vector
    %  from equation 1.1 in the paper.
    % Attach each column vector into matrix X_hat
    X_hat = zeros(length(Y), n_lambdas);
    for i=1:n_lambdas
        X_hat(:, i) = inv(eye(T) + lambdas(i)*(D.'*D)) * Y;
    end
end
 