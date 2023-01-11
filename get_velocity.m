function [root] = get_velocity(a, lm, lt)

% Input Parameters
% a: activation (between 0 and 1)
% lm: normalized length of muscle (contractile element)
%  lt: normalized length of tendon (series elastic element)

% Output
% root: normalized lengthening velocity of muscle (contractile element)

% damping coefficient (see damped model in Millard et al.)
beta = 0.1;

% WRITE CODE HERE TO CALCULATE VELOCITY
    function velocity = model(vm) 
        velocity = a.*force_length_muscle(lm).*force_velocity_muscle(vm)+force_length_parallel(lm)+beta.*vm-force_length_tendon(lt);
    end
root = fzero(@model, 0);
end






