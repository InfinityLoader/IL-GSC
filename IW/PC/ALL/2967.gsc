/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2967.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 2 ms
 * Timestamp: 10/27/2023 12:26:00 AM
*******************************************************************/

//Function Number: 1
func_ACCE(param_00,param_01)
{
	var_02 = strtok(param_00," ");
	scripts\common\utility::func_22A1(var_02,::func_ACCF,param_01);
}

//Function Number: 2
func_8695(param_00,param_01,param_02)
{
	if(!isdefined(level.var_131A0.var_116CE.var_13209))
	{
		level.var_131A0.var_116CE.var_13209 = [];
	}

	if(!isdefined(level.var_131A0.var_116CE.var_13209[param_00]))
	{
		level.var_131A0.var_116CE.var_13209[param_00] = [];
	}

	if(!isdefined(level.var_131A0.var_116CE.var_13209[param_00][param_02]))
	{
		level.var_131A0.var_116CE.var_13209[param_00][param_02] = [];
	}

	foreach(var_04 in level.var_131A0.var_116CE.var_13209[param_00][param_02])
	{
		if(param_01 == var_04)
		{
			return;
		}
	}

	level.var_131A0.var_116CE.var_13209[param_00][param_02][level.var_131A0.var_116CE.var_13209[param_00][param_02].size] = param_01;
}

//Function Number: 3
func_ACCA()
{
	level notify("new_lights_delayfxforframe");
	level endon("new_lights_delayfxforframe");
	if(!isdefined(level.var_7624))
	{
		level.var_7624 = 0;
	}

	level.var_7624 = level.var_7624 + randomfloatrange(0.2,0.4);
	if(level.var_7624 > 2)
	{
		level.var_7624 = 0;
	}

	wait(0.05);
	level.var_7624 = undefined;
}

//Function Number: 4
func_A5F2(param_00)
{
	func_ACCD("all",param_00);
}

//Function Number: 5
func_ACCD(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		param_01 = param_02;
	}
	else if(!isdefined(param_01))
	{
		param_01 = self.classname;
	}

	if(!isdefined(param_00))
	{
		param_00 = "all";
	}

	if(!isdefined(self.var_ACC9))
	{
		return;
	}

	if(!isdefined(level.var_131A0.var_116CE.var_13209[param_01][param_00]))
	{
		return;
	}

	var_03 = level.var_131A0.var_116CE.var_13209[param_01][param_00];
	var_04 = 0;
	var_05 = 2;
	if(isdefined(self.var_B4AE))
	{
		var_05 = self.var_B4AE;
	}

	foreach(var_07 in var_03)
	{
		var_08 = level.var_131A0.var_116CE.var_13208[param_01][var_07];
		if(scripts\sp\_utility::func_8C32(self.model,var_08.var_2DD))
		{
			stopfxontag(var_08.var_5FDF,self,var_08.var_2DD);
		}

		var_04++;
		if(var_04 >= var_05)
		{
			var_04 = 0;
			wait(0.05);
		}

		if(!isdefined(self))
		{
			return;
		}

		self.var_ACC9[var_07] = undefined;
	}
}

//Function Number: 6
func_ACCF(param_00,param_01)
{
	level.var_A9AE = gettime();
	if(!isdefined(param_00))
	{
		param_00 = "all";
	}

	if(!isdefined(param_01))
	{
		param_01 = self.classname;
	}

	if(!isdefined(level.var_131A0.var_116CE.var_13209))
	{
		return;
	}

	if(!isdefined(level.var_131A0.var_116CE.var_13209[param_01]) || !isdefined(level.var_131A0.var_116CE.var_13209[param_01][param_00]))
	{
		return;
	}

	thread func_ACCA();
	if(!isdefined(self.var_ACC9))
	{
		self.var_ACC9 = [];
	}

	var_02 = level.var_131A0.var_116CE.var_13209[param_01][param_00];
	var_03 = 0;
	var_04 = [];
	foreach(var_06 in var_02)
	{
		if(isdefined(self.var_ACC9[var_06]))
		{
			continue;
		}

		var_07 = level.var_131A0.var_116CE.var_13208[param_01][var_06];
		if(isdefined(var_07.var_50AE))
		{
			var_08 = var_07.var_50AE;
		}
		else
		{
			var_08 = 0;
		}

		var_08 = var_08 + level.var_7624;
		while(isdefined(var_04["" + var_08]))
		{
			var_08 = var_08 + 0.05;
		}

		var_04["" + var_08] = 1;
		self endon("death");
		childthread scripts\common\utility::func_C0AB(::playfxontag,var_08,var_07.var_5FDF,self,var_07.var_2DD);
		self.var_ACC9[var_06] = 1;
		if(!isdefined(self))
		{
			break;
		}
	}

	level.var_7624 = 0;
}

//Function Number: 7
func_ACCC(param_00,param_01,param_02)
{
	var_03 = strtok(param_00," ",param_01);
	scripts\common\utility::func_22A1(var_03,::func_ACCD,param_01,param_02);
}

//Function Number: 8
func_12BE2()
{
	if(!isdefined(self.var_8BB8))
	{
		return;
	}

	while(isdefined(self.var_ACC9) && self.var_ACC9.size)
	{
		wait(0.05);
	}
}