classdef Attribute
    properties
        name(1,1) string;
        %crit(1,1) char {mustBeMember(crit,{'high','normal','low'})};
        crit(1,1) string;
        access(1,1); %constraint to add
        reliab(1,1); %constraint to add
        extract(1,1); % constraint to add
    end

    methods
        function obj = Attribute(n,c,a,r,e)
            obj.name = n;
            obj.crit = c;
            obj.access = a;
            obj.reliab = r;
            obj.extract = e;
        end

        function visibility = evaluate(obj)
            fis = visibility_fuzzy_reasoner(obj.name,obj.crit);
            params = [obj.access, obj.reliab, obj.extract];
            visibility = evalfis(fis,params);
        end
    end
end