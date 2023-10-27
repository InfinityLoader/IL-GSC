/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3414.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 0 ms
 * Timestamp: 10/27/2023 12:27:08 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!isdefined(game["clientMatchDataDef"]))
	{
		game["clientMatchDataDef"] = "mp/zombieclientmatchdata.ddl";
		function_01A9(game["clientMatchDataDef"]);
		setclientmatchdata("map",level.script);
	}

	level.var_B48C = 50;
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
func_AFD5()
{
	var_00 = function_0080("deathCount");
	if(!func_38C6(self) || !func_38C7(var_00))
	{
	}
}