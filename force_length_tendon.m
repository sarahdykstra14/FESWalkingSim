function [normalize_tendon_tension] = force_length_tendon(lt)
%%%% TASK 1

% Input Parameters
% lt: normalized length of tendon (series elastic element)

% Output
% normalized tension produced by tendon

% WRITE YOUR CODE HERE
normalize_tendon_tension = 10.*(lt-1)+240.*((lt-1).^2);
    for m = 1:length(lt)
        if lt(m) < 1
            normalize_tendon_tension(m) = 0;
        end
    end
end