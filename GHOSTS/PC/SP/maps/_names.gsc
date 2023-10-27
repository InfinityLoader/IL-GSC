/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_names.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 242 ms
 * Timestamp: 10/27/2023 1:24:59 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
}

//Function Number: 2
func_7193()
{
	if(isdefined(level.names))
	{
	}

	var_00 = [];
	var_00[var_00.size] = "american";
	var_00[var_00.size] = "seal";
	var_00[var_00.size] = "taskforce";
	var_00[var_00.size] = "secretservice";
	var_00[var_00.size] = "british";
	var_00[var_00.size] = "arab";
	var_00[var_00.size] = "russian";
	var_00[var_00.size] = "multilingual";
	var_00[var_00.size] = "portuguese";
	var_00[var_00.size] = "shadowcompany";
	var_00[var_00.size] = "delta";
	var_00[var_00.size] = "french";
	var_00[var_00.size] = "african";
	var_00[var_00.size] = "czech";
	var_00[var_00.size] = "czech_surnames";
	var_00[var_00.size] = "pmc";
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		level.names[var_00[var_01]] = [];
	}

	add_name("american","Smith");
	add_name("american","Johnson");
	add_name("american","Williams");
	add_name("american","Jones");
	add_name("american","Brown");
	add_name("american","Davis");
	add_name("american","Miller");
	add_name("american","Wilson");
	add_name("american","Moore");
	add_name("american","Taylor");
	add_name("american","Anderson");
	add_name("american","Thomas");
	add_name("american","Jackson");
	add_name("american","White");
	add_name("american","Harris");
	add_name("american","Martin");
	add_name("american","Garcia");
	add_name("american","Martinez");
	add_name("american","Robinson");
	add_name("american","Clark");
	add_name("american","Rodriguez");
	add_name("american","Lewis");
	add_name("american","Lee");
	add_name("american","Hall");
	add_name("american","Allen");
	add_name("american","Young");
	add_name("american","Hernandez");
	add_name("american","King");
	add_name("seal","Angel");
	add_name("seal","Apex");
	add_name("seal","Bearcat");
	add_name("seal","Bishop");
	add_name("seal","Boomer");
	add_name("seal","Boxer");
	add_name("seal","Canine");
	add_name("seal","Chemist");
	add_name("seal","Chemo");
	add_name("seal","Cherub");
	add_name("seal","Chino");
	add_name("seal","Coffin");
	add_name("seal","Coma");
	add_name("seal","Cyclops");
	add_name("seal","Cypher");
	add_name("seal","Doc");
	add_name("seal","Druid");
	add_name("seal","Exxon");
	add_name("seal","Gator");
	add_name("seal","Hannibal");
	add_name("seal","Hazard");
	add_name("seal","Hitman");
	add_name("seal","Jayhawk");
	add_name("seal","Jester");
	add_name("seal","Justice");
	add_name("seal","Klepto");
	add_name("seal","Kojak");
	add_name("seal","Langley");
	add_name("seal","Neptune");
	add_name("seal","Mamba");
	add_name("seal","Midnight");
	add_name("seal","Neon");
	add_name("seal","Nomad");
	add_name("seal","Ogre");
	add_name("seal","Ozone");
	add_name("seal","Patron");
	add_name("seal","Pharaoh");
	add_name("seal","Pieces");
	add_name("seal","Poet");
	add_name("seal","Preacher");
	add_name("seal","Reaper");
	add_name("seal","Redcell");
	add_name("seal","Roadie");
	add_name("seal","Robot");
	add_name("seal","Rocket");
	add_name("seal","Rooster");
	add_name("seal","Sparrow");
	add_name("seal","Taco");
	add_name("seal","Thumper");
	add_name("seal","Trojan");
	add_name("seal","Twister");
	add_name("seal","Undertone");
	add_name("seal","Utah");
	add_name("seal","Whiskey");
	add_name("seal","Worm");
	add_name("seal","Yankee");
	add_name("seal","Zero");
	func_1F40("taskforce","seal");
	func_1F40("delta","seal");
	add_name("secretservice","Smith");
	add_name("secretservice","Jones");
	add_name("british","Abbot");
	add_name("british","Adams");
	add_name("british","Bartlett");
	add_name("british","Boyd");
	add_name("russian","Sasha Ivanov");
	add_name("russian","Aleksei Vyshinskiy");
	add_name("russian","Boris Ryzhkov");
	add_name("russian","Dima Tikhonov");
	add_name("russian","Oleg Kosygin");
	add_name("arab","Abdulaziz");
	add_name("arab","Abdullah");
	add_name("arab","Ali");
	add_name("portuguese","Carlitos");
	add_name("portuguese","Antonio");
	add_name("portuguese","Gervasio");
	add_name("portuguese","Lois");
	add_name("portuguese","Xesus");
	add_name("shadowcompany","Lestat");
	add_name("shadowcompany","Nosferatu");
	add_name("shadowcompany","Lecter");
	add_name("multilingual","Kugelschreiber");
	add_name("multilingual","Flughafen");
	add_name("french","Astor");
	add_name("french","Beliveau");
	add_name("african","Sulaiman");
	add_name("african","Camara");
	add_name("african","Mustapha");
	add_name("african","Abubakarr");
	add_name("czech","Andrej");
	add_name("czech","Anton");
	add_name("czech_surnames","Blumel");
	add_name("czech_surnames","Maly");
	add_name("czech_surnames","Pospisil");
	func_1F40("pmc","czech_surnames");
	func_459E();
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		func_6552(var_00[var_01]);
		func_6339(var_00[var_01]);
		level.var_5571[var_00[var_01]] = 0;
	}
}

//Function Number: 3
func_1F40(param_00,param_01)
{
	level.names[param_00] = level.names[param_01];
}

//Function Number: 4
add_name(param_00,param_01)
{
	level.names[param_00][level.names[param_00].size] = param_01;
}

//Function Number: 5
func_6542(param_00,param_01)
{
	level.names[param_00] = common_scripts\utility::array_remove(level.names[param_00],param_01);
}

//Function Number: 6
func_459E()
{
	var_00 = [];
	var_01 = getspawnerarray();
	var_02 = getaiarray();
	foreach(var_04 in var_01)
	{
		if(isdefined(var_04.var_6BD8) && var_04.var_6BD8 != "none")
		{
			var_05 = func_567C(var_04.var_6BD8);
			var_00[var_00.size] = var_05;
		}
	}

	foreach(var_08 in var_02)
	{
		if(isdefined(var_08.var_6BD8) && var_08.var_6BD8 != "none")
		{
			var_05 = func_567C(var_08.var_6BD8);
			var_00[var_00.size] = var_05;
		}
	}

	level.var_6BD9 = var_00;
}

//Function Number: 7
func_567C(param_00)
{
	var_01 = strtok(param_00," ");
	if(var_01.size > 1)
	{
		param_00 = var_01[1];
	}

	return param_00;
}

//Function Number: 8
func_6552(param_00)
{
	foreach(var_02 in level.var_6BD9)
	{
		foreach(var_04 in level.names[param_00])
		{
			if(var_02 == var_04)
			{
				func_6542(param_00,var_04);
			}
		}
	}
}

//Function Number: 9
func_6339(param_00)
{
	var_01 = level.names[param_00].size;
	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		var_03 = randomint(var_01);
		var_04 = level.names[param_00][var_02];
		level.names[param_00][var_02] = level.names[param_00][var_03];
		level.names[param_00][var_03] = var_04;
	}
}

//Function Number: 10
get_name(param_00)
{
	if(isdefined(self.team) && self.team == "neutral")
	{
	}

	if(isdefined(self.var_6BD8))
	{
		if(self.var_6BD8 == "none")
		{
		}

		self.name = self.var_6BD8;
		getrankfromname(self.name);
		self notify("set name and rank");
	}

	func_390B(self.voice);
	self notify("set name and rank");
}

//Function Number: 11
func_390B(param_00)
{
	level.var_5571[param_00] = level.var_5571[param_00] + 1 % level.names[param_00].size;
	var_01 = level.names[param_00][level.var_5571[param_00]];
	var_02 = randomint(10);
	if(func_5579(param_00))
	{
		var_03 = param_00 + "_surnames";
		level.var_5571[var_03] = level.var_5571[var_03] + 1 % level.names[var_03].size;
		var_01 = var_01 + " " + level.names[var_03][level.var_5571[var_03]];
	}

	if(func_5578(param_00))
	{
		var_04 = var_01;
		self.airank = "private";
	}
	else if(var_01 == "secretservice")
	{
		var_04 = "Agent " + var_02;
		self.airank = "private";
	}
	else if(var_04 > 5)
	{
		var_04 = "Pvt. " + var_02;
		self.airank = "private";
	}
	else if(var_04 > 2)
	{
		var_04 = "Cpl. " + var_02;
		self.airank = "private";
	}
	else
	{
		var_04 = "Sgt. " + var_02;
		self.airank = "sergeant";
	}

	if(isai(self) && self isbadguy())
	{
		self.ainame = var_04;
	}

	self.name = var_04;
}

//Function Number: 12
getrankfromname(param_00)
{
	if(!isdefined(param_00))
	{
		self.airank = "private";
	}

	var_01 = strtok(param_00," ");
	var_02 = var_01[0];
	switch(var_02)
	{
		case "Pvt.":
			self.airank = "private";
			break;

		case "Pfc.":
			self.airank = "private";
			break;

		case "Agent":
			self.airank = "private";
			break;

		case "Cpl.":
			self.airank = "corporal";
			break;

		case "Sgt.":
			self.airank = "sergeant";
			break;

		case "Lt.":
			self.airank = "lieutenant";
			break;

		case "Cpt.":
			self.airank = "captain";
			break;

		default:
			self.airank = "private";
			break;
	}
}

//Function Number: 13
func_5578(param_00)
{
	switch(param_00)
	{
		case "czech":
		case "delta":
		case "taskforce":
		case "seal":
			return 1;
	}

	return 0;
}

//Function Number: 14
func_5579(param_00)
{
	return isdefined(level.names[param_00 + "_surnames"]);
}