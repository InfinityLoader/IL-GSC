/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_heavyarmor.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 374 ms
 * Timestamp: 10/27/2023 12:20:31 AM
*******************************************************************/

//Function Number: 1
func_17CE(param_00)
{
	var_01 = self.var_8CFC;
	if(!isdefined(self.struct))
	{
		var_01 = spawnstruct(self.var_8CFC);
		var_01.player = self;
		var_01.var_9118 = 0;
		self.var_8CFC = var_01;
		var_01.var_9118 = var_01.var_9118 + param_00;
		self notify("heavyArmor_added");
		return;
	}

	var_01.var_9118 = var_01.var_9118 + param_00;
}

//Function Number: 2
func_111AB(param_00)
{
	var_01 = self.var_8CFC;
	if(scripts\mp\_utility::func_9FB3(var_01.var_9344))
	{
		return;
	}

	if(var_01.var_9118 > 0)
	{
		var_01.var_9118 = max(0,var_01.var_9118 - param_00);
		scripts\mp\_missions::func_D991("ch_heavy_armor_absorb",param_00);
		if(var_01.var_9118 <= 0)
		{
			thread func_8CFD();
		}
	}
}

//Function Number: 3
func_E12B()
{
	self notify("heavyArmor_removed");
	self.var_8CFC = undefined;
}

//Function Number: 4
func_8D07(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(param_02 <= 0 && param_03 <= 0)
	{
		return [0,param_02,param_03];
	}

	if(param_04 == "MOD_SUICIDE")
	{
		return [0,param_02,param_03];
	}

	if(isdefined(param_01) && param_01.classname == "trigger_hurt" || param_01.classname == "worldspawn")
	{
		return [0,param_02,param_03];
	}

	if(!param_00 func_8BFA())
	{
		return [0,param_02,param_03];
	}

	if(scripts\mp\_utility::func_9D6E(param_05))
	{
		return [0,param_02,param_03];
	}

	if(param_00 func_8BFB())
	{
		return [1,1,0];
	}

	var_0B = param_00 func_7EF8();
	var_0C = func_8D01(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
	var_0D = param_02 * var_0C;
	var_0E = param_03 * var_0C;
	var_0F = var_0D + var_0E;
	if(!param_0A)
	{
		param_00 func_111AB(var_0F);
	}

	if(param_00 func_8BFB())
	{
		return [var_0B,1,0];
	}

	return [param_02 + param_03,1,0];
}

//Function Number: 5
func_7EF8()
{
	if(!func_8BFA())
	{
		return 0;
	}

	return self.var_8CFC.var_9118;
}

//Function Number: 6
func_8BFA()
{
	return isdefined(self.var_8CFC) && self.var_8CFC.var_9118 > 0 || scripts\mp\_utility::func_9FB3(self.var_8CFC.var_9B30);
}

//Function Number: 7
func_8BFB()
{
	return isdefined(self.var_8CFC) && scripts\mp\_utility::func_9FB3(self.var_8CFC.var_9B30);
}

//Function Number: 8
func_8CFD()
{
	self endon("disconnect");
	self endon("heavyArmor_removed");
	if(!scripts\mp\_utility::func_9D46())
	{
		self.var_8CFC.var_9B30 = 1;
	}

	self notify("heavyArmor_broken");
	waittillframeend;
	thread func_E12B();
}

//Function Number: 9
func_8D01(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	var_0B = [];
	if(scripts\mp\_utility::func_9F8D(param_04))
	{
		var_0B[var_0B.size] = 1.33;
	}

	if(function_0107(param_04))
	{
		var_0B[var_0B.size] = 1.5;
	}

	if(param_04 == "MOD_MELEE")
	{
		var_0B[var_0B.size] = 1.5;
	}

	if(scripts\mp\_utility::func_9E27(param_05,param_08,param_04,param_01))
	{
		var_0B[var_0B.size] = 1.5;
	}

	var_0C = 1;
	foreach(var_0E in var_0B)
	{
		if(var_0E > var_0C)
		{
			var_0E = var_0C;
		}
	}

	return var_0C;
}