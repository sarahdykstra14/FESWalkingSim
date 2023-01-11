function [normalize_PE_force] = force_length_parallel(lm)
%%%% TASK 1

% Input Parameters
% lm: normalized length of muscle (contractile element)

% Output
% normalized force produced by parallel elastic element

% WRITE YOUR CODE HERE
normalize_PE_force = 3.*(lm-1).^(2)./(lm-0.4);
    for m = 1:length(lm)
        if lm(m) < 1
            normalize_PE_force(m) = 0;
        end
    end
end