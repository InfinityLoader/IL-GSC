/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\code\character.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 753 ms
 * Timestamp: 10/27/2023 12:03:06 AM
*******************************************************************/

//Function Number: 1
func_F7A1(param_00)
{
	self setmodel(param_00[randomint(param_00.size)]);
}

//Function Number: 2
func_D811(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		precachemodel(param_00[var_01]);
	}
}

//Function Number: 3
func_2483(param_00,param_01)
{
	if(!isdefined(level.var_3CAF))
	{
		level.var_3CAF = [];
	}

	if(!isdefined(level.var_3CAF[param_00]))
	{
		level.var_3CAF[param_00] = randomint(param_01.size);
	}

	var_02 = level.var_3CAF[param_00] + 1 % param_01.size;
	if(isdefined(self.var_ED2A))
	{
		var_02 = self.var_ED2A % param_01.size;
	}

	level.var_3CAF[param_00] = var_02;
	self attach(param_01[var_02],"",1);
	self.var_8C98 = param_01[var_02];
}

//Function Number: 4
func_2482(param_00,param_01)
{
	if(!isdefined(level.var_3CAE))
	{
		level.var_3CAE = [];
	}

	if(!isdefined(level.var_3CAE[param_00]))
	{
		level.var_3CAE[param_00] = randomint(param_01.size);
	}

	var_02 = level.var_3CAE[param_00] + 1 % param_01.size;
	level.var_3CAE[param_00] = var_02;
	self attach(param_01[var_02]);
	self.var_8C43 = param_01[var_02];
}

//Function Number: 5
func_BEFC()
{
	self detachall();
	var_00 = self.var_1ED5;
	if(!isdefined(var_00))
	{
		return;
	}

	self.var_1ED5 = "none";
	self [[ level.var_DB38 ]](var_00);
}

//Function Number: 6
func_EB53()
{
	var_00["gunHand"] = self.var_1ED5;
	var_00["gunInHand"] = self.var_1ED6;
	var_00["model"] = self.model;
	var_00["hatModel"] = self.var_8C43;
	if(isdefined(self.name))
	{
		var_00["name"] = self.name;
	}
	else
	{
	}

	var_01 = self method_8108();
	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		var_00["attach"][var_02]["model"] = self method_8106(var_02);
		var_00["attach"][var_02]["tag"] = self method_8109(var_02);
	}

	return var_00;
}

//Function Number: 7
func_ADA6(param_00)
{
	self detachall();
	self.var_1ED5 = param_00["gunHand"];
	self.var_1ED6 = param_00["gunInHand"];
	self setmodel(param_00["model"]);
	self.var_8C43 = param_00["hatModel"];
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
func_7BE5(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = strtok(self.classname,"_");
	if(!scripts\common\utility::issp())
	{
		if(isdefined(self.pers["modelIndex"]) && self.pers["modelIndex"] < param_00)
		{
			return self.pers["modelIndex"];
		}

		var_03 = randomint(param_00);
		self.pers["modelIndex"] = var_03;
		return var_03;
	}
	else if(var_04.size <= 2)
	{
		return randomint(param_00);
	}

	var_05 = "auto";
	if(isdefined(self.var_ED2A))
	{
		var_03 = self.var_ED2A;
	}
	else if(isdefined(param_01))
	{
		var_03 = func_7BF5(param_01);
	}

	if(isdefined(self.var_ED29))
	{
		var_05 = "group_" + self.var_ED29;
	}

	if(!isdefined(level.var_3CB1))
	{
		level.var_3CB1 = [];
	}

	if(!isdefined(level.var_3CB1[var_05]))
	{
		level.var_3CB1[var_05] = [];
	}

	if(!isdefined(var_03))
	{
		var_03 = func_7A7C(param_02,var_05);
		if(!isdefined(var_03))
		{
			var_03 = randomint(param_02.size);
		}
	}

	if(!isdefined(level.var_3CB1[var_05][param_02[var_03]]))
	{
		level.var_3CB1[var_05][param_02[var_03]] = 0;
	}

	level.var_3CB1[var_05][param_02[var_03]]++;
	return var_03;
}

//Function Number: 10
func_7A7C(param_00,param_01)
{
	var_02 = [];
	var_03 = 999999;
	var_02[0] = 0;
	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		if(!isdefined(level.var_3CB1[param_01][param_00[var_04]]))
		{
			level.var_3CB1[param_01][param_00[var_04]] = 0;
		}

		var_05 = level.var_3CB1[param_01][param_00[var_04]];
		if(var_05 > var_03)
		{
			continue;
		}

		if(var_05 < var_03)
		{
			var_02 = [];
			var_03 = var_05;
		}

		var_02[var_02.size] = var_04;
	}

	return random(var_02);
}

//Function Number: 11
func_984D(param_00,param_01,param_02)
{
	for(var_03 = 0;var_03 < param_02;var_03++)
	{
		level.var_3CB1[param_00][param_01][var_03] = 0;
	}
}

//Function Number: 12
func_7BF3(param_00)
{
	return randomint(param_00);
}

//Function Number: 13
random(param_00)
{
	return param_00[randomint(param_00.size)];
}

//Function Number: 14
func_7BF5(param_00)
{
	var_01 = randomfloat(1);
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		if(var_01 < param_00[var_02])
		{
			return var_02;
		}
	}

	return 0;
}