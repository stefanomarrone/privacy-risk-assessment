format longG

a_web = 2000;
a_internals = logspace(0,3,6);
r = 0.6;
e_clean = 1;
e_crypt = 0.01;
fprintf("%s;%s;\n","accessibility","severity");

for a_internal = a_internals
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

	attributes = [pregnancies, blood_pressure, glucose, insulin, pedigree, age, diabetes];
	s = System("majority");
	for a = attributes
		s = s.addAttribute(a);
	end
    severity = s.evaluate("nozero");
    fprintf("%d;%f;\n",a_internal,severity);
end

