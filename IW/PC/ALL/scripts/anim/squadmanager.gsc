/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\squadmanager.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 1086 ms
 * Timestamp: 10/27/2023 12:01:04 AM
*******************************************************************/

//Function Number: 1
func_9763()
{
	if(isdefined(level.var_10AE6) && level.var_10AE6)
	{
		return;
	}

	anim.var_10AE0 = [];
	anim.var_10AE1 = [];
	anim.var_10AF9 = [];
	anim.var_10AE5 = [];
	anim.var_10AF2 = 0;
	anim.var_10AE6 = 1;
}

//Function Number: 2
func_4A1B(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.var_10AEE = param_00;
	level.var_10AF9[param_00] = var_02;
	var_02.team = func_8151(param_01);
	var_02.var_101E8 = 0;
	var_02.origin = undefined;
	var_02.var_143 = undefined;
	var_02.var_10C = undefined;
	var_02.var_9E40 = 0;
	var_02.var_B65C = 0;
	var_02.var_B661 = [];
	var_02.var_C35C = [];
	var_02.var_C35A = 0;
	var_02.var_10AE9 = [];
	var_02.var_B659 = [];
	var_02.var_B65A = [];
	var_02.var_B65F = [];
	var_02.var_B660 = [];
	var_02.var_10AFD = [];
	var_02.var_10AFE = [];
	var_02.var_10AE4 = level.var_10AE5.size;
	level.var_10AE5[level.var_10AE5.size] = var_02;
	var_02 func_12F25();
	level notify("squad created " + param_00);
	anim notify("squad created " + param_00);
	for(var_03 = 0;var_03 < level.var_10AE0.size;var_03++)
	{
		var_04 = level.var_10AE0[var_03];
		var_02 thread [[ var_04 ]]();
	}

	for(var_03 = 0;var_03 < level.var_10AE5.size;var_03++)
	{
		level.var_10AE5[var_03] func_12F25();
	}

	var_02 thread func_10AFC();
	var_02 thread func_C35D();
	var_02 thread func_12ECE();
	return var_02;
}

//Function Number: 3
func_51D2(param_00)
{
	if(param_00 == "axis" || param_00 == "team3" || param_00 == "allies" || param_00 == "jackal_allies" || param_00 == "jackal_axis")
	{
		return;
	}

	var_01 = level.var_10AF9[param_00].var_10AE4;
	var_02 = level.var_10AF9[param_00];
	var_02 notify("squad_deleting");
	while(var_02.var_B661.size)
	{
		var_02.var_B661[0] func_185C(var_02.var_B661[0].team);
	}

	level.var_10AE5[var_01] = level.var_10AE5[level.var_10AE5.size - 1];
	level.var_10AE5[var_01].var_10AE4 = var_01;
	level.var_10AE5[level.var_10AE5.size - 1] = undefined;
	level.var_10AF9[param_00] = undefined;
	anim notify("squad deleted " + param_00);
	for(var_03 = 0;var_03 < level.var_10AE5.size;var_03++)
	{
		level.var_10AE5[var_03] func_12F25();
	}
}

//Function Number: 4
func_1811(param_00)
{
	if(!isdefined(param_00))
	{
		if(isdefined(self.var_EEC4))
		{
			param_00 = self.var_EEC4;
		}
		else
		{
			param_00 = self.team;
		}
	}

	if(!isdefined(level.var_10AF9[param_00]))
	{
		anim func_4A1B(param_00,self);
	}

	var_01 = level.var_10AF9[param_00];
	var_02 = 0;
	if(isdefined(var_01.var_B661))
	{
		foreach(var_04 in var_01.var_B661)
		{
			if(var_04 != level.player)
			{
				continue;
			}
			else
			{
				var_02 = 1;
				break;
			}
		}

		if(!var_02)
		{
			var_01.var_B661[var_01.var_B661.size] = self;
		}
	}

	self.var_10AC8 = var_01;
}

//Function Number: 5
func_D362()
{
	var_00 = getentarray("player","classname")[0];
	lib_0E4E::func_D313();
	if(scripts\common\utility::func_D11B())
	{
		anim.player = level.var_D127;
		if(!isdefined(level.player.team))
		{
			level.player.team = "allies";
		}

		level.var_68AD["threat"]["self"] = 11000;
		level.var_68AD["threat"]["squad"] = 7000;
		level.var_29BE = squared(9999999);
		level.var_29BD = squared(9999999);
		anim.var_115EE = 300000;
		anim.var_6BB2 = 9999999;
		anim.var_6BB8 = 2;
		anim.var_6BB7 = 5;
		anim.var_6BB6 = 0.5;
		anim.var_6BB5 = 3;
		level.player func_1811("jackal_allies");
		for(var_01 = 0;var_01 < level.var_10AE5.size;var_01++)
		{
			level.var_10AE5[var_01].var_B661 = scripts\common\utility::func_22BC(level.var_10AE5[var_01].var_B661);
			level.var_10AE5[var_01] func_12F25();
		}

		lib_0E4E::func_96F1();
		while(scripts\common\utility::func_D11B())
		{
			wait(0.05);
		}
	}
	else
	{
		anim.player = var_01;
		if(!isdefined(level.player.team))
		{
			level.player.team = "allies";
		}

		lib_0E4E::func_D313();
		level.var_68AD["threat"]["self"] = 9000;
		level.var_68AD["threat"]["squad"] = 5000;
		level.var_29BE = squared(5000);
		level.var_29BD = squared(3000);
		anim.var_115EE = 120000;
		anim.var_6BB2 = 620;
		anim.var_6BB8 = 12;
		anim.var_6BB7 = 24;
		anim.var_6BB6 = 2;
		anim.var_6BB5 = 5;
		level.player func_1811("allies");
		for(var_01 = 0;var_01 < level.var_10AE5.size;var_01++)
		{
			level.var_10AE5[var_01].var_B661 = scripts\common\utility::func_22BC(level.var_10AE5[var_01].var_B661);
			level.var_10AE5[var_01] func_12F25();
		}

		lib_0E4E::func_96F1();
		while(!scripts\common\utility::func_D11B())
		{
			wait(0.05);
		}
	}

	for(;;)
	{
		if(scripts\common\utility::func_D11B())
		{
			var_02 = [];
			foreach(var_04 in level.var_10AF9["allies"].var_B661)
			{
				if(var_04 != level.player)
				{
					var_02[var_02.size] = var_04;
				}
			}

			level.var_10AF9["allies"].var_B661 = var_02;
			anim.player = level.var_D127;
			if(!isdefined(level.player.team))
			{
				level.player.team = "allies";
			}

			lib_0E4E::func_D313();
			level.var_68AD["threat"]["self"] = 11000;
			level.var_68AD["threat"]["squad"] = 7000;
			level.var_29BE = squared(9999999);
			level.var_29BD = squared(9999999);
			anim.var_115EE = 300000;
			anim.var_6BB2 = 9999999;
			anim.var_6BB8 = 2;
			anim.var_6BB7 = 5;
			anim.var_6BB6 = 0.5;
			anim.var_6BB5 = 3;
			level.player func_1811("jackal_allies");
			for(var_01 = 0;var_01 < level.var_10AE5.size;var_01++)
			{
				level.var_10AE5[var_01].var_B661 = scripts\common\utility::func_22BC(level.var_10AE5[var_01].var_B661);
				level.var_10AE5[var_01] func_12F25();
			}

			lib_0E4E::func_96F1();
			while(scripts\common\utility::func_D11B())
			{
				wait(0.05);
			}

			continue;
		}

		var_02 = [];
		foreach(var_04 in level.var_10AF9["allies"].var_B661)
		{
			if(!isdefined(level.var_D127) || isdefined(level.var_D127) && var_04 != level.var_D127)
			{
				var_02[var_02.size] = var_04;
			}
		}

		level.var_10AF9["allies"].var_B661 = var_02;
		anim.player = var_00;
		if(!isdefined(level.player.team))
		{
			level.player.team = "allies";
		}

		lib_0E4E::func_D313();
		level.var_68AD["threat"]["self"] = 9000;
		level.var_68AD["threat"]["squad"] = 5000;
		level.var_29BE = squared(5000);
		level.var_29BD = squared(3000);
		anim.var_115EE = 120000;
		anim.var_6BB2 = 620;
		anim.var_6BB8 = 12;
		anim.var_6BB7 = 24;
		anim.var_6BB6 = 2;
		anim.var_6BB5 = 5;
		level.player func_1811("allies");
		for(var_01 = 0;var_01 < level.var_10AE5.size;var_01++)
		{
			level.var_10AE5[var_01].var_B661 = scripts\common\utility::func_22BC(level.var_10AE5[var_01].var_B661);
			level.var_10AE5[var_01] func_12F25();
		}

		lib_0E4E::func_96F1();
		while(!scripts\common\utility::func_D11B())
		{
			wait(0.05);
		}
	}
}

//Function Number: 6
func_8151(param_00)
{
	var_01 = "allies";
	if(isdefined(level.var_116CC) && level.var_116CC == "phparade")
	{
		param_00.team = "allies";
	}

	if(param_00.team == "axis" || param_00.team == "neutral" || param_00.team == "team3")
	{
		var_01 = param_00.team;
	}

	return var_01;
}

//Function Number: 7
func_185C(param_00)
{
	if(!isdefined(param_00))
	{
		if(isdefined(self.var_EEC4))
		{
			param_00 = self.var_EEC4;
		}
		else
		{
			param_00 = self.team;
		}

		if(isdefined(self.var_29B8) && self.var_29B8)
		{
			param_00 = "jackal_" + self.var_EEDE;
		}
	}

	if(!isdefined(level.var_10AF9[param_00]))
	{
		anim func_4A1B(param_00,self);
	}

	var_01 = level.var_10AF9[param_00];
	if(isdefined(self.var_10AC8))
	{
		if(self.var_10AC8 == var_01)
		{
			return;
		}
		else
		{
			func_E11A();
		}
	}

	self.var_A980 = 0;
	self.var_440E = 0;
	self.var_10DFF = gettime();
	self.var_10AC8 = var_01;
	self.var_10AED = var_01.var_B661.size;
	var_01.var_B661[self.var_10AED] = self;
	var_01.var_B65C = var_01.var_B661.size;
	if(isdefined(level.var_AE64))
	{
		if(self.team == "allies" && scripts\anim\battlechatter::func_9EC2())
		{
			func_1804();
		}
	}

	foreach(var_03 in self.var_10AC8.var_B659)
	{
		self thread [[ var_03 ]](self.var_10AC8.var_10AEE);
	}

	thread func_B65D();
}

//Function Number: 8
func_E11A()
{
	var_00 = self.var_10AC8;
	var_01 = -1;
	if(isdefined(self))
	{
		var_01 = self.var_10AED;
	}
	else
	{
		for(var_02 = 0;var_02 < var_00.var_B661.size;var_02++)
		{
			if(var_00.var_B661[var_02] == self)
			{
				var_01 = var_02;
			}
		}
	}

	if(var_01 != var_00.var_B661.size - 1)
	{
		var_03 = var_00.var_B661[var_00.var_B661.size - 1];
		var_00.var_B661[var_01] = var_03;
		if(isdefined(var_03))
		{
			var_03.var_10AED = var_01;
		}
	}

	var_00.var_B661[var_00.var_B661.size - 1] = undefined;
	var_00.var_B65C = var_00.var_B661.size;
	if(isdefined(self.var_10AF0))
	{
		func_E142();
	}

	foreach(var_05 in self.var_10AC8.var_B65F)
	{
		self thread [[ var_05 ]](var_00.var_10AEE);
	}

	if(var_00.var_B65C == 0)
	{
		func_51D2(var_00.var_10AEE);
	}

	if(isdefined(self))
	{
		self.var_10AC8 = undefined;
		self.var_10AED = undefined;
		self notify("removed from squad");
	}
}

//Function Number: 9
func_1804()
{
	var_00 = self.var_10AC8;
	if(isdefined(self.var_10AF0))
	{
		return;
	}

	self.var_10AF0 = var_00.var_C35C.size;
	var_00.var_C35C[self.var_10AF0] = self;
	var_00.var_C35A = var_00.var_C35C.size;
}

//Function Number: 10
func_E142()
{
	var_00 = self.var_10AC8;
	var_01 = -1;
	if(isdefined(self))
	{
		var_01 = self.var_10AF0;
	}
	else
	{
		for(var_02 = 0;var_02 < var_00.var_C35C.size;var_02++)
		{
			if(var_00.var_C35C[var_02] == self)
			{
				var_01 = var_02;
			}
		}
	}

	if(var_01 != var_00.var_C35C.size - 1)
	{
		var_03 = var_00.var_C35C[var_00.var_C35C.size - 1];
		var_00.var_C35C[var_01] = var_03;
		if(isdefined(var_03))
		{
			var_03.var_10AF0 = var_01;
		}
	}

	var_00.var_C35C[var_00.var_C35C.size - 1] = undefined;
	var_00.var_C35A = var_00.var_C35C.size;
	if(isdefined(self))
	{
		self.var_10AF0 = undefined;
	}
}

//Function Number: 11
func_C35D()
{
	if(!isdefined(level.var_AE64))
	{
		anim waittill("loadout complete");
	}

	for(var_00 = 0;var_00 < self.var_B661.size;var_00++)
	{
		if(self.var_B661[var_00] scripts\anim\battlechatter::func_9EC2())
		{
			self.var_B661[var_00] func_1804();
		}
	}
}

//Function Number: 12
func_10AFC()
{
	anim endon("squad deleted " + self.var_10AEE);
	for(;;)
	{
		func_12E59();
		wait(0.1);
	}
}

//Function Number: 13
func_B65D()
{
	self endon("removed from squad");
	self waittill("death",var_00);
	if(isdefined(self))
	{
		self.var_4F = var_00;
	}

	func_E11A();
}

//Function Number: 14
func_12E77()
{
	self.var_9E40 = 0;
	for(var_00 = 0;var_00 < level.var_10AE5.size;var_00++)
	{
		self.var_10AE9[level.var_10AE5[var_00].var_10AEE].var_9E42 = 0;
	}

	for(var_00 = 0;var_00 < self.var_B661.size;var_00++)
	{
		if(isdefined(self.var_B661[var_00]))
		{
			if(isdefined(self.var_B661[var_00].var_10C) && isdefined(self.var_B661[var_00].var_10C.var_10AC8) && self.var_B661[var_00].var_440E > 0)
			{
				self.var_10AE9[self.var_B661[var_00].var_10C.var_10AC8.var_10AEE].var_9E42 = 1;
			}
		}
	}
}

//Function Number: 15
func_12E59()
{
	var_00 = (0,0,0);
	var_01 = (0,0,0);
	var_02 = 0;
	var_03 = undefined;
	var_04 = 0;
	func_12E77();
	var_05 = !isdefined(self.var_10C);
	if(!var_05)
	{
		self.var_143 = vectornormalize(self.var_10C.origin - self.origin);
	}

	foreach(var_07 in self.var_B661)
	{
		if(!isalive(var_07))
		{
			continue;
		}

		var_02++;
		var_00 = var_00 + var_07.origin;
		if(var_05)
		{
			var_01 = var_01 + anglestoforward(var_07.angles);
		}

		if(isdefined(var_07.var_10C) && isdefined(var_07.var_10C.var_10AC8))
		{
			if(!isdefined(var_03))
			{
				var_03 = var_07.var_10C.var_10AC8;
				continue;
			}

			if(var_07.var_10C.var_10AC8.var_B65C > var_03.var_B65C)
			{
				var_03 = var_07.var_10C.var_10AC8;
			}
		}
	}

	if(var_02)
	{
		self.origin = var_00 / var_02;
		if(var_05)
		{
			self.var_143 = var_01 / var_02;
		}
	}
	else
	{
		self.origin = var_00;
		if(var_05)
		{
			self.var_143 = var_01;
		}
	}

	self.var_9E40 = var_04;
	self.var_10C = var_03;
}

//Function Number: 16
func_12F25()
{
	for(var_00 = 0;var_00 < level.var_10AE5.size;var_00++)
	{
		if(!isdefined(self.var_10AE9[level.var_10AE5[var_00].var_10AEE]))
		{
			self.var_10AE9[level.var_10AE5[var_00].var_10AEE] = spawnstruct();
			self.var_10AE9[level.var_10AE5[var_00].var_10AEE].var_9E42 = 0;
		}

		foreach(var_02 in self.var_10AFD)
		{
			self thread [[ var_02 ]](level.var_10AE5[var_00].var_10AEE);
		}
	}
}

//Function Number: 17
func_D909(param_00,param_01,param_02,param_03)
{
	self endon("death");
	if(!isdefined(param_02))
	{
		param_02 = (0,0,0);
	}

	if(!isdefined(param_03))
	{
		param_03 = (1,0,0);
	}

	for(var_04 = 0;var_04 < param_01 * 2;var_04++)
	{
		if(!isalive(self))
		{
			return;
		}

		var_05 = self method_815B() + (0,0,10) + param_02;
		wait(0.05);
	}
}

//Function Number: 18
func_1B0E(param_00)
{
	switch(param_00)
	{
		case "combat":
		case "stop":
		case "move":
		case "death":
			self.var_1491.var_10E19 = param_00;
			break;

		case "grenadecower":
		case "pain":
			break;

		case "stalingrad_cover_crouch":
		case "cover_wide_right":
		case "cover_wide_left":
		case "concealment_stand":
		case "concealment_prone":
		case "concealment_crouch":
		case "cover_prone":
		case "cover_stand":
		case "cover_left":
		case "cover_right":
		case "cover_crouch":
			self.var_1491.var_10E19 = "cover";
			break;

		case "l33t truckride combat":
		case "aim":
			self.var_1491.var_10E19 = "combat";
			break;
	}
}

//Function Number: 19
func_12ECE()
{
	anim endon("squad deleted " + self.var_10AEE);
	var_00 = 0.05;
	for(;;)
	{
		foreach(var_02 in self.var_B661)
		{
			if(!isalive(var_02) || var_02 == level.player)
			{
				continue;
			}

			var_02 func_1B0F(var_00);
			var_02 func_1B10(var_00);
		}

		wait(var_00);
	}
}

//Function Number: 20
func_1B0F(param_00)
{
	if(!isdefined(self.var_440E))
	{
		return;
	}

	if(isdefined(self.var_1B2))
	{
		if(self.var_440E < 0)
		{
			self.var_440E = param_00;
		}
		else
		{
			self.var_440E = self.var_440E + param_00;
		}

		self.var_A980 = gettime();
		return;
	}
	else if((isdefined(self.var_3136) && self.var_3136) || isdefined(self.var_238F) && self.var_238F != "jackal" && self method_81C0())
	{
		self.var_440E = self.var_440E + param_00;
		return;
	}

	if(self.var_440E > 0)
	{
		self.var_440E = 0 - param_00;
		return;
	}

	self.var_440E = self.var_440E - param_00;
}

//Function Number: 21
func_1B10(param_00)
{
	if(!isdefined(self.var_112CA))
	{
		return;
	}

	if((isdefined(self.var_3136) && self.var_3136) || isdefined(self.var_238F) && self.var_238F != "jackal" && self method_81C0())
	{
		if(self.var_112CA < 0)
		{
			self.var_112CA = param_00;
		}
		else
		{
			self.var_112CA = self.var_112CA + param_00;
		}

		return;
	}

	if(self.var_112CA > 0)
	{
		self.var_112CA = 0 - param_00;
		return;
	}

	self.var_112CA = self.var_112CA - param_00;
}