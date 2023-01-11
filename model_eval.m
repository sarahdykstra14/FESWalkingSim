function [Output] = model_eval(function_type, input, ridge_coeff)

% Do not alter this function.

switch function_type
    case 'Sigmoid'
        fun = @(x, mu, sigma) 1./(1+exp(-(x-mu)./sigma));
        X = [];
        for i = -1:0.2:-0.1
            X = [X fun(input, i, 0.15)];
        end
        
    case 'Gaussian'
        
end

Output = ridge_coeff(1) + X*ridge_coeff(2:end);
end