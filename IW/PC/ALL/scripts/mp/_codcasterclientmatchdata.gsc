/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_codcasterclientmatchdata.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 930 ms
 * Timestamp: 10/27/2023 12:14:53 AM
*******************************************************************/

//Function Number: 1
func_10036()
{
	return getdvarint("com_codcasterEnabled",0) == 1 && getdvarint("systemlink");
}

//Function Number: 2
func_38C6(param_00)
{
	if(isagent(param_00))
	{
		return 0;
	}

	return param_00.var_41F0 < level.var_B4B0;
}

//Function Number: 3
func_499E(param_00)
{
	var_01 = [];
	foreach(var_03 in level.var_4333.var_D38C)
	{
		var_01[var_03[0]] = var_03[1];
	}

	return var_01;
}

//Function Number: 4
func_E159(param_00)
{
	level endon("game_ended");
	param_00 waittill("disconnect");
	if(!isdefined(level.var_4333.players[param_00.var_41F0]))
	{
		return;
	}

	level.var_4333.players[param_00.var_41F0] = undefined;
}

//Function Number: 5
func_3DFC(param_00)
{
	if(!isdefined(level.var_4333.players[param_00.var_41F0]))
	{
		var_01 = func_499E(param_00);
		level.var_4333.players[param_00.var_41F0] = var_01;
		thread func_E159(param_00);
	}
}

//Function Number: 6
init()
{
	function_0310("map",level.script);
	var_00 = spawnstruct();
	var_00.var_D38C = [["damageDone",0],["longestKillstreak",0],["shutdowns",0],["gametypePoints",0]];
	var_00.players = [];
	level.var_4333 = var_00;
}

//Function Number: 7
func_F6B2(param_00)
{
	foreach(var_02 in level.var_4333.var_D38C)
	{
		function_0310("players",param_00.var_4334,var_02[0],level.var_4333.players[param_00.var_41F0][var_02[0]]);
	}

	function_0310("players",param_00.var_4334,"username",param_00.name);
}

//Function Number: 8
func_F22C()
{
	var_00 = 0;
	foreach(var_02 in level.players)
	{
		func_3DFC(var_02);
		var_02.var_4334 = var_00;
		func_F6B2(var_02);
		var_00++;
	}

	function_0312();
}

//Function Number: 9
func_F695(param_00,param_01,param_02)
{
	if(!func_38C6(param_00))
	{
		return;
	}

	func_3DFC(param_00);
	var_03 = level.var_4333.players[param_00.var_41F0];
	if(!isdefined(var_03) || !isdefined(var_03[param_01]))
	{
		return;
	}

	level.var_4333.players[param_00.var_41F0][param_01] = param_02;
}

//Function Number: 10
func_7E39(param_00,param_01)
{
	if(!func_38C6(param_00))
	{
		return;
	}

	func_3DFC(param_00);
	var_02 = level.var_4333.players[param_00.var_41F0];
	if(!isdefined(var_02) || !isdefined(var_02[param_01]))
	{
		return;
	}

	return var_02[param_01];
}