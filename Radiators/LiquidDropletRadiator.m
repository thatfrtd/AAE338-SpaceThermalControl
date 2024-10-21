classdef LiquidDropletRadiator < Radiator
    %LIQUIDDROPLETRADIATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Inherited Properties
        Name = "Liquid Droplet"
        coolant_name
        coolant_density % [kg / m3] have a database where properties can be looked up by coolant name?
        emissivity % [] make dependent on temperature?
        flow_rate % [kg / s]

        % Class Properties
        droplet_velocity (1, 1) double % [m / s]
    end
    
    methods
        function obj = LiquidDropletRadiator(Name, coolant_name, coolant_density, emissivity, flow_rate, droplet_velocity)
            %LIQUIDDROPLETRADIATOR Construct an instance of this class
            %   Detailed explanation goes here
            if nargin > 0
                if ~isempty(Name) obj.Name = Name; end
                obj.coolant_name = coolant_name;
                obj.coolant_density = coolant_density;
                obj.emissivity = emissivity;
                obj.flow_rate = flow_rate;
                obj.droplet_velocity = droplet_velocity;
            end
        end

        function mass = mass_for_required_Qdot(obj, required_Qdot)
            %mass_for_required_Qdot Summary of this method goes here
            %   Detailed explanation goes here
            mass = 2 * required_Qdot / 500;
        end

        function power = power_for_required_Qdot(obj, required_Qdot)
            %power_for_required_Qdot Summary of this method goes here
            %   Detailed explanation goes here
            power = 2;
        end
        
        function size = size_for_required_Qdot(obj, required_Qdot)
            %size_for_required_Qdot Summary of this method goes here
            %   Detailed explanation goes here
            size = 2;
        end

    end

    methods(Static)
        function radiators = CreateRadiators(parameters)
            %RADIATORS Create multiple radiators using a table
            %of parameters.
            radiators = createArray([size(parameters, 1), 1], "LiquidDropletRadiator");
            for r = 1:size(parameters, 1)
                for p = 1:size(parameters, 2)
                    name = string(parameters.Properties.VariableNames(p));
                    
                    radiators(r).(name) = parameters(r, :).(name);
                end
                radiators(r).Name = sprintf("%s with %s", radiators(r).Name, radiators(r).coolant_name);
            end
        end
    end
end

