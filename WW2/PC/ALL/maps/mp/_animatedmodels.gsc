/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_animatedmodels.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 32 ms
 * Timestamp: 10/27/2023 3:20:58 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	if(!isdefined(level.var_E2F))
	{
		level.var_E2F = [];
	}

	var_00 = getarraykeys(level.var_E2F);
	foreach(var_02 in var_00)
	{
		var_03 = getarraykeys(level.var_E2F[var_02]);
		foreach(var_05 in var_03)
		{
			precachempanim(level.var_E2F[var_02][var_05]);
		}
	}

	waittillframeend;
	level.var_515E = [];
	var_08 = getentarray("animated_model","targetname");
	common_scripts\utility::func_FB2(var_08,::func_0E9F);
	level.var_515E = undefined;
}

//Function Number: 2
func_0E9F()
{
	if(isdefined(self.var_EA4))
	{
		var_00 = self.var_EA4;
	}
	else
	{
		var_01 = getarraykeys(level.var_E2F[self.var_106]);
		var_02 = var_01[randomint(var_01.size)];
		var_00 = level.var_E2F[self.var_106][var_02];
	}

	self scriptmodelplayanim(var_00);
	self method_80D4();
}