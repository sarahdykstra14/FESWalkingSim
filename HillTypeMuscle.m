classdef HillTypeMuscle
    % Damped Hill-type muscle model adapted from Millard et al. (2013). The
    % dynamic model is defined in terms of normalized length and velocity.
    % To model a particular muscle, scale factors are needed for force, CE
    % length, and SE length.
    
    properties
        resting_length_muscle  {mustBeNumeric}
        resting_length_tendon  {mustBeNumeric}
        f0M  {mustBeNumeric}
    end
    
    methods
        
        function obj = HillTypeMuscle(f0M_, resting_length_muscle_, resting_length_tendon_)
            if nargin == 3
                obj.resting_length_muscle = resting_length_muscle_;
                obj.resting_length_tendon = resting_length_tendon_;
                obj.f0M = f0M_;
            end
        end
        
        function normalized_tendon_length = norm_tendon_length(obj, muscle_tendon_length, normalized_muscle_length)
            % Input Parameters
            % (1) muscle_tendon_length: non-normalized length of the full muscle-tendon
            % complex (typically found from joint angles and musculoskeletal geometry).
            % (2) normalized_muscle_length: normalized length of the contractile element
            % (the state variable of the muscle model)
            % (3) resting_length_muscle: actual length (m) of muscle (CE) that corresponds to
            % normalized length of 1
            % (4) resting_length_tendon: actual length of tendon (m) that corresponds to
            % normalized length of 1
            
            % Output
            % normalized length of the tendon
            
            normalized_tendon_length = ...
                (muscle_tendon_length - obj.resting_length_muscle * normalized_muscle_length) / obj.resting_length_tendon;
        end
        
        function muscle_tension = get_force(obj, total_length, norm_muscle_length)
            % Inputs
            % total_length: muscle-tendon length (m)
            % norm_muscle_length: normalized length of muscle (the state variable)
            
            % Output
            % muscle tension (N)
            
            muscle_tension = obj.f0M * ...
                force_length_tendon(obj.norm_tendon_length(total_length, norm_muscle_length));
        end

    end
    
end