classdef System
    properties
        attributes(1,:) Attribute;
        %composition(1,1) string {mustBeMember(composition,{'majority','weighted','conservative'})} 
        composition(1,1) string; 
    end

    methods
        function obj = System(c)
            obj.composition = c;
        end

        function obj = addAttribute(obj,a)
            obj.attributes = horzcat([obj.attributes],a);
        end

        function obj = clear(obj)
            obj.attributes = [];
        end

        function names = getNames(obj)
            names = [];
            for a = obj.attributes
                names = horzcat(names,[a.name]);
            end
        end

        function severity = evaluate(obj, optimization_mode)
            nms = obj.getNames();
            len = length(nms);
            visibilities = [];            
            for a = obj.attributes
                v = a.evaluate();
                visibilities = [visibilities, v];
            end
            fis = severity_fuzzy_reasoner(len,obj.composition,optimization_mode);
            severity = evalfis(fis,visibilities);
        end
    end
end
