/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_playercards.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 100 ms
 * Timestamp: 10/27/2023 12:21:12 AM
*******************************************************************/

//Function Number: 1
init()
{
	level thread func_C56E();
}

//Function Number: 2
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(!isai(var_00))
		{
			var_00.var_240 = var_00 getplayerdata(level.var_AEA6,"squadMembers","patch");
			var_00.var_241 = var_00 getplayerdata(level.var_AEA6,"squadMembers","patchbacking");
			var_00.var_23F = var_00 getplayerdata(level.var_AEA6,"squadMembers","background");
		}
	}
}