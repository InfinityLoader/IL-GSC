/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_raid_superweapon.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 64 ms
 * Timestamp: 10/27/2023 3:12:11 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	level.var_5A61["raid_superweapon"] = ::tryusesuperweapon;
	level.var_5A7D["teslagunmtx_mp"] = "flamethrower";
}

//Function Number: 2
tryusesuperweapon(param_00)
{
	var_01 = tryusesuperweaponinternal();
	return var_01;
}

//Function Number: 3
tryusesuperweaponinternal()
{
	if(maps\mp\_utility::func_57A0(self))
	{
		maps\mp\_matchdata::func_5E9A("raid_superweapon",self.var_116);
		return 1;
	}

	return 0;
}