
function fis = visibility_fuzzy_reasoner(attribute_name,criticality_level)
    fis = mamfis("Name",attribute_name);
    fis = visibility_mf(fis);
    if strcmp(criticality_level,"high") == 1
        fis = visibility_high_rules(fis);
    elseif strcmp(criticality_level,"normal") == 1
        fis = visibility_normal_rules(fis);
    else
        fis = visibility_low_rules(fis);
    end
end

function out_fis = visibility_high_rules(in_fis)
    rules = [1 1 1 1 0.1 1;
            1 -1 1 2 0.1 1;
            1 1 -1 2 0.1 1;
            -1 1 1 2 0.1 1;
            3 0 0 3 0.5 1;
            0 3 0 3 0.5 1;
            0 0 3 3 0.5 1;
            3 3 3 4 0.9 1;
            4 4 4 4 1 2;];
    out_fis = addRule(in_fis,rules);
end

function out_fis = visibility_normal_rules(in_fis)
    rules = [1 1 1 1 1 1;
            1 -1 1 2 1 1;
            1 1 -1 2 1 1;
            -1 1 1 2 1 1;
            3 0 0 3 1 1;
            0 3 0 3 1 1;
            0 0 3 3 1 1;
            3 3 3 4 1 1;
            4 4 4 4 1 2;];
    out_fis = addRule(in_fis,rules);    
end

function out_fis = visibility_low_rules(in_fis)
    rules = [1 1 1 1 1 1;
            1 -1 1 2 1 1;
            1 1 -1 2 1 1;
            -1 1 1 2 1 1;
            3 0 0 3 0.9 1;
            0 3 0 3 0.9 1;
            0 0 3 3 0.9 1;
            3 3 3 4 0.5 1;
            4 4 4 4 0.1 2;];
    out_fis = addRule(in_fis,rules);
end

function out_fis = visibility_mf(in_fis)
    out_fis = addInput(in_fis,[0 2000],"Name","accessibility");
    out_fis = addMF(out_fis,"accessibility","linzmf",[1 2],"Name","low");
    out_fis = addMF(out_fis,"accessibility","trimf",[1 10 100],"Name","medium");
    out_fis = addMF(out_fis,"accessibility","trimf",[10 100 1000],"Name","high");
    out_fis = addMF(out_fis,"accessibility","linsmf",[500 1000],"Name","very high");
    out_fis = addInput(out_fis,[0 1],"Name","reliability");
    out_fis = addMF(out_fis,"reliability","linzmf",[0.1 0.2],"Name","low");
    out_fis = addMF(out_fis,"reliability","trimf",[.1 0.35 0.6],"Name","medium");
    out_fis = addMF(out_fis,"reliability","trimf",[0.4 0.65 0.9],"Name","high");
    out_fis = addMF(out_fis,"reliability","linsmf",[0.8 0.9],"Name","very high");
    out_fis = addInput(out_fis,[0 1],"Name","extractability");
    out_fis = addMF(out_fis,"extractability","linzmf",[0.1 0.2],"Name","low");
    out_fis = addMF(out_fis,"extractability","trimf",[.1 0.3 0.5],"Name","medium");
    out_fis = addMF(out_fis,"extractability","trimf",[0.5 0.7 0.9],"Name","high");
    out_fis = addMF(out_fis,"extractability","linsmf",[0.8 0.9],"Name","very high");
    out_fis = addOutput(out_fis,[0 1],"Name","visibility");
    out_fis = addMF(out_fis,"visibility","linzmf",[0.1 0.2],"Name","low");
    out_fis = addMF(out_fis,"visibility","trimf",[.1 0.3 0.5],"Name","medium");
    out_fis = addMF(out_fis,"visibility","trimf",[0.5 0.7 0.9],"Name","high");
    out_fis = addMF(out_fis,"visibility","linsmf",[0.8 0.9],"Name","very high");
end