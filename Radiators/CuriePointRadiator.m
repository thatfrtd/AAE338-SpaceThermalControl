classdef CuriePointRadiator < Radiator
    %CURIEPOINTRADIATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % Inherited Properties
        Name = "Curie Point"
        coolant_name
        coolant_density % [kg / m3] have a database where properties can be looked up by coolant name?
        emissivity % [] make dependent on temperature?
        flow_rate % [kg / s]

        % Class Properties
        particle_diameter (1, 1) double % [m]
        number_density (1, 1) double % [1 / m3]
        curie_point (1, 1) double % [K]
    end
    
    methods
        function obj = CuriePointRadiator(Name, coolant_name, coolant_density, emissivity, flow_rate, particle_diameter, number_density, curie_point)
            %CURIEPOINTRADIATOR Construct an instance of this class
            %   Detailed explanation goes here
            if nargin > 0
                if ~isempty(Name) obj.Name = Name; end
                obj.coolant_name = coolant_name;
                obj.coolant_density = coolant_density;
                obj.emissivity = emissivity;
                obj.flow_rate = flow_rate;
                obj.particle_diameter = particle_diameter;
                obj.number_density = number_density;
                obj.curie_point = curie_point;
            end
        end
        
        function mass = mass_for_required_Qdot(obj, required_Qdot)
            %mass_for_required_Qdot Summary of this method goes here
            %   Detailed explanation goes here
            mass = 3;
        end

        function power = power_for_required_Qdot(obj, required_Qdot)
            %power_for_required_Qdot Summary of this method goes here
            %   Detailed explanation goes here
            power = 3;
        end
        
        function size = size_for_required_Qdot(obj, required_Qdot)
            %size_for_required_Qdot Summary of this method goes here
            %   Detailed explanation goes here
            size = 3;
        end

    end

    methods(Static)
        function radiators = CreateRadiators(parameters)
            %RADIATORS Create multiple radiators using a table
            %of parameters.
            radiators = createArray([size(parameters, 1), 1], "CuriePointRadiator");
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

