function [force_velocity_scale_factor] = force_velocity_muscle(vm)

% Input Parameters
% vm: muscle (contractile element) velocity)

% Output
% force-velocity scale factor

if size(vm, 2) > size(vm, 1)
    vm = vm';
end
global force_velocity_regression
force_velocity_scale_factor = model_eval('Sigmoid', vm, force_velocity_regression);
end