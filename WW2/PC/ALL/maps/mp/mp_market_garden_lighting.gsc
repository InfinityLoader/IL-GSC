/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_market_garden_lighting.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 45 ms
 * Timestamp: 10/27/2023 3:15:47 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	setdvar("r_sunshadowscale",1);
	if(level.var_1D4 && getdvar("2695") != "true")
	{
		xbox_optimizations();
	}
}

//Function Number: 2
xbox_optimizations()
{
	setdvar("5153",0);
	setdvar("5156",1);
	setdvar("r_sunshadowscale",0.7);
}