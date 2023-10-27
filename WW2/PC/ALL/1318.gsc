/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1318.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 3:25:11 AM
*******************************************************************/

//Function Number: 1
func_52F6()
{
	func_5306();
}

//Function Number: 2
func_73DD()
{
	self setclientomnvar("ui_streak_overlay_state",1);
}

//Function Number: 3
func_73D5()
{
	self setclientomnvar("ui_streak_overlay_state",0);
}

//Function Number: 4
func_745C()
{
	self setclientomnvar("ui_streak_overlay_state",7);
}

//Function Number: 5
func_8A61(param_00,param_01,param_02)
{
	self endon("missile_strike_complete");
	if(isdefined(level.var_6F9D) && isdefined(level.var_6F9D["dofScripting"]))
	{
		self method_84B5();
	}

	wait(param_00);
	if(isdefined(param_01))
	{
		self method_8483(param_01,0);
	}

	if(isdefined(param_02))
	{
		self lightsetforplayer(param_02);
	}

	self useaeriallods(1);
}

//Function Number: 6
func_7D04(param_00)
{
	if(isdefined(level.var_6F9D) && isdefined(level.var_6F9D["dofScripting"]))
	{
		self method_84B4(level.var_6F9D["dofScripting"]);
	}

	self method_8483("",param_00);
	self lightsetforplayer("");
	self useaeriallods(0);
}

//Function Number: 7
func_A232(param_00)
{
	var_01 = getentarray("scorestreakclosed","targetname");
	if(var_01.size > 0)
	{
		foreach(var_03 in var_01)
		{
			var_03 enableportalgroup(!param_00,self);
		}
	}

	var_05 = getentarray("scorestreakopen","targetname");
	if(var_05.size > 0)
	{
		foreach(var_03 in var_05)
		{
			var_03 enableportalgroup(param_00,self);
		}
	}
}

//Function Number: 8
func_5306()
{
	level.var_80B4 = [];
	setdvarifuninitialized("scr_scorestreakDangerDebug",0);
}

//Function Number: 9
func_280E(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.var_116 = param_00;
	var_04.var_3E3E = anglestoforward((0,param_01,0));
	var_04.var_944C = param_02;
	var_04.var_1A7 = param_03;
	level.var_80B4[level.var_80B4.size] = var_04;
}

//Function Number: 10
func_5FCB(param_00,param_01)
{
	wait(level.var_80B5[param_01]);
	var_06 = 0;
	var_07 = [];
	for(var_08 = 0;var_08 < level.var_80B4.size;var_08++)
	{
		if(!var_06 && level.var_80B4[var_08].var_116 == param_00)
		{
			var_06 = 1;
			continue;
		}

		var_07[var_07.size] = level.var_80B4[var_08];
	}

	level.var_80B4 = var_07;
}

//Function Number: 11
func_4675(param_00)
{
	var_01 = 0;
	for(var_02 = 0;var_02 < level.var_80B4.size;var_02++)
	{
		var_03 = level.var_80B4[var_02].var_116;
		var_04 = level.var_80B4[var_02].var_3E3E;
		var_05 = level.var_80B4[var_02].var_944C;
		var_01 = var_01 + func_4684(param_00,var_03,var_04,var_05);
	}

	return var_01;
}

//Function Number: 12
func_4684(param_00,param_01,param_02,param_03)
{
	if(level.var_80B6[param_03] != 0)
	{
		var_04 = param_01 + level.var_80B6[param_03] * level.var_80B7[param_03] * param_02;
		var_05 = param_00 - var_04;
		var_05 = (var_05[0],var_05[1],0);
		var_06 = vectordot(var_05,param_02) * param_02;
		var_07 = var_05 - var_06;
		var_08 = var_07 + var_06 / level.var_80B9[param_03];
	}
	else
	{
		var_08 = param_01 - param_02;
		var_08 = (var_08[0],var_08[1],0);
	}

	var_09 = lengthsquared(var_08);
	if(var_09 > level.var_80B7[param_03] * level.var_80B7[param_03])
	{
		return 0;
	}

	if(var_09 < level.var_80B8[param_03] * level.var_80B8[param_03])
	{
		return 1;
	}

	var_0A = sqrt(var_09);
	var_0B = var_0A - level.var_80B8[param_03] / level.var_80B7[param_03] - level.var_80B8[param_03];
	return 1 - var_0B;
}