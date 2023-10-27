/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_clientmatchdata.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 247 ms
 * Timestamp: 10/27/2023 12:14:52 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!isdefined(game["clientMatchDataDef"]))
	{
		game["clientMatchDataDef"] = "mp/clientmatchdata.ddl";
		function_01A9(game["clientMatchDataDef"]);
		setclientmatchdata("map",level.script);
	}

	level.var_B48C = 200;
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
func_38C7(param_00)
{
	return param_00 < level.var_B48C;
}

//Function Number: 4
func_AFD5(param_00)
{
	var_01 = function_0080("deathCount");
	if(!func_38C6(self) || !func_38C7(var_01))
	{
		return;
	}

	if(isplayer(param_00) && func_38C6(param_00))
	{
		self method_81E9(var_01,self.var_41F0,param_00,param_00.var_41F0);
		return;
	}

	self method_81E9(var_01,self.var_41F0,undefined,undefined);
}