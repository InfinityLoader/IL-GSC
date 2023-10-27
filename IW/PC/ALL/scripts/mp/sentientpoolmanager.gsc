/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\sentientpoolmanager.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 245 ms
 * Timestamp: 10/27/2023 12:22:36 AM
*******************************************************************/

//Function Number: 1
init()
{
	function_004E("Tactical_Static");
	function_004E("Lethal_Static");
	function_004E("Lethal_Moving");
	function_004E("Killstreak_Air");
	function_004E("Killstreak_Ground");
	function_01B2("Killstreak_Ground","Killstreak_Ground");
	function_01B2("Killstreak_Air","Killstreak_Ground");
	function_01B2("Killstreak_Air","Killstreak_Air");
	function_01B2("Killstreak_Ground","Killstreak_Air");
	level.sentientpools = [];
	level.sentientpools[level.sentientpools.size] = "Tactical_Static";
	level.sentientpools[level.sentientpools.size] = "Lethal_Static";
	level.sentientpools[level.sentientpools.size] = "Lethal_Moving";
	level.sentientpools[level.sentientpools.size] = "Killstreak_Air";
	level.sentientpools[level.sentientpools.size] = "Killstreak_Ground";
	level.activesentients = [];
	for(var_00 = 0;var_00 < level.sentientpools.size;var_00++)
	{
		level.activesentients[level.sentientpools[var_00]] = [];
	}

	level.activesentientcount = 0;
}

//Function Number: 2
registersentient(param_00,param_01,param_02,param_03)
{
	var_04 = -1;
	for(var_05 = 0;var_05 < level.sentientpools.size;var_05++)
	{
		if(level.sentientpools[var_05] == param_00)
		{
			var_04 = var_05;
			break;
		}
	}

	if(var_04 == -1)
	{
		return;
	}

	if(isdefined(self.sentientpool))
	{
		return;
	}

	if(level.activesentientcount == 24)
	{
		var_06 = level removebestsentient(var_04 + 1);
		if(!var_06)
		{
			return;
		}
	}

	self.sentientpool = param_00;
	self.sentientaddedtime = gettime();
	self.sentientpoolindex = self getentitynumber();
	if(!isagent(self))
	{
		self method_81F1(param_01.team);
	}

	self method_834E(param_00);
	if(scripts\mp\_utility::func_9FB3(param_02))
	{
		self method_81F0();
	}

	level.activesentients[param_00][self.sentientpoolindex] = self;
	level.activesentientcount++;
	thread monitorsentient(param_03);
}

//Function Number: 3
monitorsentient(param_00)
{
	level endon("game_ended");
	var_01 = self.sentientpool;
	var_02 = self.sentientpoolindex;
	if(isdefined(param_00))
	{
		scripts\common\utility::waittill_any_3("death","remove_sentient",param_00);
	}
	else
	{
		scripts\common\utility::waittill_either("death","remove_sentient");
	}

	unregistersentient(var_01,var_02);
}

//Function Number: 4
removebestsentient(param_00)
{
	var_01 = undefined;
	for(var_02 = 0;var_02 < param_00;var_02++)
	{
		var_01 = getbestsentientfrompool(level.sentientpools[var_02]);
		if(isdefined(var_01))
		{
			break;
		}
	}

	if(!isdefined(var_01))
	{
		return 0;
	}

	var_01 unregistersentient(var_01.sentientpool,var_01.sentientpoolindex);
	return 1;
}

//Function Number: 5
getbestsentientfrompool(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	foreach(var_04 in level.activesentients[param_00])
	{
		if(var_02 == undefined || var_04.sentientaddedtime < var_02)
		{
			var_02 = var_04.sentientaddedtime;
			var_01 = var_04;
		}
	}

	return var_01;
}

//Function Number: 6
unregistersentient(param_00,param_01)
{
	if(!isdefined(param_00) || !isdefined(param_01))
	{
		return;
	}

	level.activesentients[param_00][param_01] = undefined;
	level.activesentientcount--;
	if(isdefined(self))
	{
		self.sentientpool = undefined;
		self.sentientpoolindex = undefined;
		if(!isagent(self))
		{
			self method_80F7();
		}
	}
}