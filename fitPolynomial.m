function Py = fitPolynomial(X, Y, orders)
% Fits a set of polynomials to values Y across domain X.
% Each value in orders corresponds to a polynomial fitting.
% Returns the values of each fitted polynomial along domain X.
    n_orders = length(orders);
    Py = zeros(length(X), n_orders);
    for i = 1:n_orders
        p = polyfit(X, Y, orders(i));
        Py(:, i) = polyval(p, X);
    end
end