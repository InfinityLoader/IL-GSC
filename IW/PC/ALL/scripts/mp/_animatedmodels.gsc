/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_animatedmodels.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 170 ms
 * Timestamp: 10/27/2023 12:14:25 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(!isdefined(level.var_1F04))
	{
		level.var_1F04 = [];
	}

	var_00 = getarraykeys(level.var_1F04);
	foreach(var_02 in var_00)
	{
		var_03 = getarraykeys(level.var_1F04[var_02]);
		foreach(var_05 in var_03)
		{
			precachempanim(level.var_1F04[var_02][var_05]);
		}
	}

	waittillframeend;
	level.var_94FE = [];
	var_08 = getentarray("animated_model","targetname");
	scripts\common\utility::func_22D3(var_08,::func_1F9C,0.05);
	level.var_94FE = undefined;
}

//Function Number: 2
func_1F9C()
{
	if(isdefined(self.var_1FA2))
	{
		var_00 = self.var_1FA2;
	}
	else
	{
		var_01 = getarraykeys(level.var_1F04[self.model]);
		var_02 = var_01[randomint(var_01.size)];
		var_00 = level.var_1F04[self.model][var_02];
	}

	self scriptmodelplayanim(var_00);
	self willneverchange();
}