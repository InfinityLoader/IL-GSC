/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_objpoints.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 351 ms
 * Timestamp: 10/27/2023 12:21:07 AM
*******************************************************************/

//Function Number: 1
init()
{
	precacheshader("objpoint_default");
	level.var_C2C1 = [];
	level.var_C2C2 = [];
	if(level.splitscreen)
	{
		level.var_C2C4 = 15;
	}
	else
	{
		level.var_C2C4 = 8;
	}

	level.var_C2C0 = 0.75;
	level.var_C2C3 = 1;
}

//Function Number: 2
func_4A23(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = func_801E(param_00);
	if(isdefined(var_06))
	{
		func_51BC(var_06);
	}

	if(!isdefined(param_03))
	{
		param_03 = "objpoint_default";
	}

	if(!isdefined(param_05))
	{
		param_05 = 1;
	}

	if(param_02 != "all")
	{
		var_06 = newteamhudelem(param_02);
	}
	else
	{
		var_06 = newhudelem();
	}

	var_06.name = param_00;
	var_06.x = param_01[0];
	var_06.y = param_01[1];
	var_06.var_3A6 = param_01[2];
	var_06.team = param_02;
	var_06.var_9DFC = 0;
	var_06.var_9F51 = 1;
	var_06 setshader(param_03,level.var_C2C4,level.var_C2C4);
	var_06 setwaypoint(1,0);
	if(isdefined(param_04))
	{
		var_06.alpha = param_04;
	}
	else
	{
		var_06.alpha = level.var_C2C0;
	}

	var_06.var_2897 = var_06.alpha;
	var_06.index = level.var_C2C1.size;
	level.var_C2C2[param_00] = var_06;
	level.var_C2C1[level.var_C2C1.size] = param_00;
	return var_06;
}

//Function Number: 3
func_51BC(param_00)
{
	if(level.var_C2C2.size == 1)
	{
		level.var_C2C2 = [];
		level.var_C2C1 = [];
		param_00 destroy();
		return;
	}

	var_01 = param_00.index;
	var_02 = level.var_C2C1.size - 1;
	var_03 = func_801D(var_02);
	level.var_C2C1[var_01] = var_03.name;
	var_03.index = var_01;
	level.var_C2C1[var_02] = undefined;
	level.var_C2C2[param_00.name] = undefined;
	param_00 destroy();
}

//Function Number: 4
func_12EE3(param_00)
{
	if(self.x != param_00[0])
	{
		self.x = param_00[0];
	}

	if(self.y != param_00[1])
	{
		self.y = param_00[1];
	}

	if(self.var_3A6 != param_00[2])
	{
		self.var_3A6 = param_00[2];
	}
}

//Function Number: 5
func_F7CA(param_00,param_01)
{
	var_02 = func_801E(param_00);
	var_02 func_12EE3(param_01);
}

//Function Number: 6
func_801E(param_00)
{
	if(isdefined(level.var_C2C2[param_00]))
	{
		return level.var_C2C2[param_00];
	}

	return undefined;
}

//Function Number: 7
func_801D(param_00)
{
	if(isdefined(level.var_C2C1[param_00]))
	{
		return level.var_C2C2[level.var_C2C1[param_00]];
	}

	return undefined;
}

//Function Number: 8
func_10D9B()
{
	self endon("stop_flashing_thread");
	if(self.var_9DFC)
	{
		return;
	}

	self.var_9DFC = 1;
	while(self.var_9DFC)
	{
		self fadeovertime(0.75);
		self.alpha = 0.35 * self.var_2897;
		wait(0.75);
		self fadeovertime(0.75);
		self.alpha = self.var_2897;
		wait(0.75);
	}

	self.alpha = self.var_2897;
}

//Function Number: 9
func_11070()
{
	if(!self.var_9DFC)
	{
		return;
	}

	self.var_9DFC = 0;
}