/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 324.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 4 ms
 * Timestamp: 10/27/2023 2:23:06 AM
*******************************************************************/

//Function Number: 1
func_1E55(param_00)
{
	self setmodel(param_00[randomint(param_00.size)]);
}

//Function Number: 2
func_1E56(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		precachemodel(param_00[var_01]);
	}
}

//Function Number: 3
func_1E57(param_00,param_01)
{
	if(!isdefined(level.var_1E58))
	{
		level.var_1E58 = [];
	}

	if(!isdefined(level.var_1E58[param_00]))
	{
		level.var_1E58[param_00] = randomint(param_01.size);
	}

	var_02 = level.var_1E58[param_00] + 1 % param_01.size;
	if(isdefined(self.script_char_index))
	{
		var_02 = self.script_char_index % param_01.size;
	}

	level.var_1E58[param_00] = var_02;
	self attach(param_01[var_02],"",1);
	self.var_1E5A = param_01[var_02];
}

//Function Number: 4
func_1E5B(param_00,param_01)
{
	if(!isdefined(level.var_1E5C))
	{
		level.var_1E5C = [];
	}

	if(!isdefined(level.var_1E5C[param_00]))
	{
		level.var_1E5C[param_00] = randomint(param_01.size);
	}

	var_02 = level.var_1E5C[param_00] + 1 % param_01.size;
	level.var_1E5C[param_00] = var_02;
	self attach(param_01[var_02]);
	self.hatmodel = param_01[var_02];
}

//Function Number: 5
func_1E5D()
{
	self detachall();
	var_00 = self.var_1E5E;
	if(!isdefined(var_00))
	{
		return;
	}

	self.var_1E5E = "none";
	self [[ level.var_1E5F ]](var_00);
}

//Function Number: 6
func_1E60()
{
	var_00["gunHand"] = self.var_1E5E;
	if(isdefined(self.name))
	{
	}
	else
	{
	}

	var_01 = self getattachsize();
	for(var_02 = 0;var_02 < var_01;var_02++ = var_7B["name"])
	{
		var_7B["attach"][var_02]["model"] = self getattachmodelname(var_02);
		var_7B["attach"][var_02]["tag"] = self getattachtagname(var_02);
	}

	return var_7B;
}

//Function Number: 7
func_1E62(param_00)
{
	self detachall();
	self.var_1E5E = param_00["gunHand"];
	self.var_1E61 = param_00["gunInHand"];
	self setmodel(param_00["model"]);
	self.hatmodel = param_00["hatModel"];
	if(isdefined(param_00["name"]))
	{
		self.name = param_00["name"];
	}
	else
	{
	}

	var_01 = param_00["attach"];
	var_02 = var_01.size;
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		self attach(var_01[var_03]["model"],var_01[var_03]["tag"]);
	}
}

//Function Number: 8
precache(param_00)
{
	if(isdefined(param_00["name"]))
	{
	}
	else
	{
	}

	precachemodel(param_00["model"]);
	var_01 = param_00["attach"];
	var_02 = var_01.size;
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		precachemodel(var_01[var_03]["model"]);
	}
}

//Function Number: 9
func_1E63(param_00)
{
	var_01 = strtok(self.classname,"_");
	if(!common_scripts\utility::issp())
	{
		if(isdefined(self.pers["modelIndex"]) && self.pers["modelIndex"] < param_00)
		{
			return self.pers["modelIndex"];
		}

		var_02 = randomint(param_00);
		self.pers["modelIndex"] = var_02;
		return var_02;
	}
	else if(var_02.size <= 2)
	{
		return randomint(var_01);
	}

	var_03 = "auto";
	var_02 = undefined;
	var_04 = var_01[2];
	if(isdefined(self.script_char_index))
	{
		var_03 = self.script_char_index;
	}

	if(isdefined(self.script_char_group))
	{
		var_05 = "grouped";
		var_02 = "group_" + self.script_char_group;
	}

	if(!isdefined(level.var_1E65))
	{
		level.var_1E65 = [];
	}

	if(!isdefined(level.var_1E65[var_04]))
	{
		level.var_1E65[var_04] = [];
	}

	if(!isdefined(level.var_1E65[var_04][var_02]))
	{
		func_1E67(var_04,var_02,param_00);
	}

	if(!isdefined(var_03))
	{
		var_03 = func_1E66(var_04,var_02);
		if(!isdefined(var_03))
		{
			var_03 = randomint(5000);
		}
	}

	while(var_03 >= param_00)
	{
		var_03 = var_03 - param_00;
	}

	level.var_1E65[var_04][var_02][var_03]++;
	return var_03;
}

//Function Number: 10
func_1E66(param_00,param_01)
{
	var_02 = [];
	var_03 = level.var_1E65[param_00][param_01][0];
	var_02[0] = 0;
	for(var_04 = 1;var_04 < level.var_1E65[param_00][param_01].size;var_04++)
	{
		if(level.var_1E65[param_00][param_01][var_04] > var_03)
		{
			continue;
		}

		if(level.var_1E65[param_00][param_01][var_04] < var_03)
		{
			var_02 = [];
			var_03 = level.var_1E65[param_00][param_01][var_04];
		}

		var_02[var_02.size] = var_04;
	}

	return random(var_02);
}

//Function Number: 11
func_1E67(param_00,param_01,param_02)
{
	for(var_03 = 0;var_03 < param_02;var_03++)
	{
		level.var_1E65[param_00][param_01][var_03] = 0;
	}
}

//Function Number: 12
func_1E68(param_00)
{
	return randomint(param_00);
}

//Function Number: 13
random(param_00)
{
	return param_00[randomint(param_00.size)];
}