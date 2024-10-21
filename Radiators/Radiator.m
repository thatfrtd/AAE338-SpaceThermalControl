classdef Radiator < matlab.mixin.Heterogeneous
    %RADIATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(Abstract)
        Name string
        coolant_name string
        coolant_density (1, 1) double % [kg / m3] have a database where properties can be looked up by coolant name?
        emissivity (1, 1) double % [] make dependent on temperature?
        flow_rate (1, 1) double % [kg / s]
        % Add other important properties here and copy them to the subclasses
    end
    
   methods(Sealed)
        % This section is for methods that call the abstract methods of
        % arrays of subclasses.
        function masses = evaluate_mass_for_required_Qdot(aryIn, required_Qdot)
        
            n = numel(aryIn);
            masses = zeros([numel(aryIn), numel(required_Qdot)]);
        
            for c = 1:n
                masses(c, :) = mass_for_required_Qdot(aryIn(c), required_Qdot);
            end
        end

        function powers = evaluate_power_for_required_Qdot(aryIn, required_Qdot)
        
            n = numel(aryIn);
            powers = zeros([numel(aryIn), numel(required_Qdot)]);
        
            for c = 1:n
                powers(c, :) = power_for_required_Qdot(aryIn(c), required_Qdot);
            end
        end

        function sizes = evaluate_size_for_required_Qdot(aryIn, required_Qdot)
        
            n = numel(aryIn);
            sizes = zeros([numel(aryIn), numel(required_Qdot)]);
        
            for c = 1:n
                sizes(c, :) = size_for_required_Qdot(aryIn(c), required_Qdot);
            end
        end
    end

    methods(Abstract)
        % Abstract methods that every subclass must implement
        radiators = CreateRadiators(parameters)
        
        mass = mass_for_required_Qdot(obj, required_Qdot)
        power = power_for_required_Qdot(obj, required_Qdot)
        size = size_for_required_Qdot(obj, required_Qdot)
    end
end



