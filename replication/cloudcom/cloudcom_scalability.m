format longG

a_web = 2000;
a_internal = 100;
r = 0.6;
e_clean = 1;
e_crypt = 0.01;

fprintf("%s;%s;%s;\n","#attributes","optimization","time");

% White zone (data on the web, clean)
age = Attribute("age","low",a_web,r,e_clean);

% Yellow zone (data hard to find)
pregnancies = Attribute("pregnancies","high",a_internal,r,e_clean);
blood_pressure = Attribute("pressure","normal",a_internal,r,e_clean);
thickness = Attribute("tickness","low",a_internal,r,e_clean);
bmi = Attribute("bmi","normal",a_internal,r,e_clean);

% Red zone (diabetes related information)
glucose = Attribute("glucose","high",a_internal,r,e_crypt);
insulin = Attribute("insulin","high",a_internal,r,e_crypt);
pedigree = Attribute("pedigree","high",a_internal,r,e_crypt);
diabetes = Attribute("diabetes","high",a_internal,r,e_crypt);

attributes = [pregnancies, blood_pressure, glucose, thickness, insulin, bmi, pedigree, age, diabetes];

for i = 1:10
	for mod = ["nozero","none"]
		s = System("majority");
		for a = attributes(1:i)
			s = s.addAttribute(a);
		end
		delta_time = tic;
    	severity = s.evaluate(mod);
		interval = toc(delta_time);
    	fprintf("%d;%s;%f;\n",i,mod,interval);
	end
end

