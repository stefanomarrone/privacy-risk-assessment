
function fis = severity_fuzzy_reasoner(att_number, composition, optimization_mode)
    fis = mamfis("Name","Severity");
    fis = severity_mf(att_number,fis);
    left_rules = generate_rules(att_number);
    full_rules = generate_weights(left_rules,composition);
    full_rules = optimize(full_rules,optimization_mode);
    fis = update_model(full_rules, fis);
end

function rules = generate_weights(left, policy)
    ruleset_size = size(left,1);
    if strcmp(policy,"majority") == 1
        func = @(line) (generate_weights_majority(line));
    elseif strcmp(policy,"weighted") == 1
        func = @(line) (generate_weights_weighted(line));
    elseif strcmp(policy,"conservative") == 1
        func = @(line) (generate_weights_conservative(line));
    elseif strcmp(policy,"optimistic") == 1
        func = @(line) (generate_weights_optimistic(line));
    end
    rules = [];
    for k = 1:ruleset_size
        line = left(k,:);
        weight = func(line);
        rules = horzcat(rules, weight);
    end
    % transposition and addition
    rules = rules';
    rules = horzcat(left, rules);
    rules = horzcat(rules, ones(ruleset_size,1));
end

function left = generate_rules(n)
    left = [];
    base = [1 2 3 4];
    for index = 0:n
        out_repeating = 4 .^ index;
        in_repeating = 4 .^ (n - index);
        line = repelem(base,in_repeating);
        line = repmat(line,1,out_repeating);
        left = vertcat(left, line);
    end
    left = left';
end

function upper = upper_support_extraction(row)
    len = size(row);
    len = len(2);
    upper = row(1,1:len-1);
end

function lower = lower_support_extraction(row)
    lower = row(end);
end

function w = generate_weights_majority(line)
    w = 0;
    antecedents = upper_support_extraction(line);
    consequence = lower_support_extraction(line);
    mode_number = mode(antecedents);
    counter_mode = numel(find(antecedents==mode_number));
    counter_consequence = numel(find(antecedents==consequence));
    if counter_mode == counter_consequence
        w = 1;
    end
end

function w = generate_weights_weighted(line)
    antecedents = upper_support_extraction(line);
    consequence = lower_support_extraction(line);
    counter_consequence = numel(find(antecedents==consequence));
    w = counter_consequence / length(line);
end

function w = generate_weights_conservative(line)
    w = 0;
    antecedents = upper_support_extraction(line);
    consequence = lower_support_extraction(line);
    max_value = max(antecedents);
    if max_value == consequence
        w = 1;
    end
end

function w = generate_weights_optimistic(line)
    w = 0;
    antecedents = upper_support_extraction(line);
    consequence = lower_support_extraction(line);
    min_value = min(antecedents);
    if min_value == consequence
        w = 1;
    end
end

%TODO: more optimization modes to come. Now you can remove just zero-weighted lines with "nozero"
function out_rules = optimize(in_rules, mode)
    rows = size(in_rules);
    rows = rows(1);
	out_rules = [];
	if strcmp(mode,"nozero") == 1
	    for i = 1:rows
	        r = in_rules(i,:);
	        if r(length(r)-1) > 0
	            out_rules = vertcat(out_rules,r);
	        end
	    end
	else
		out_rules = in_rules;
	end
end

function out_fis = update_model(full_rules, in_fis)
	out_fis = addRule(in_fis,full_rules);
end


function out_fis = severity_mf(n,in_fis)
    out_fis = in_fis;
    for index = 0:n-1
        label = "visibility_" + string(index);
        out_fis = addInput(out_fis,[0 1],"Name",label);
        out_fis = addMF(out_fis,label,"linzmf",[0.1 0.2],"Name","low");
        out_fis = addMF(out_fis,label,"trimf",[.1 0.3 0.5],"Name","medium");
        out_fis = addMF(out_fis,label,"trimf",[0.5 0.7 0.9],"Name","high");
        out_fis = addMF(out_fis,label,"linsmf",[0.8 0.9],"Name","very high");
    end
    price = 100000;
    label = "severity";
    out_fis = addOutput(out_fis,[0 price],"Name",label);
    out_fis = addMF(out_fis,label,"linzmf",price.*[0.1 0.2],"Name","low");
    out_fis = addMF(out_fis,label,"trimf",price.*[.1 0.3 0.5],"Name","medium");
    out_fis = addMF(out_fis,label,"trimf",price.*[0.5 0.7 0.9],"Name","high");
    out_fis = addMF(out_fis,label,"linsmf",price.*[0.8 0.9],"Name","very high");
end

