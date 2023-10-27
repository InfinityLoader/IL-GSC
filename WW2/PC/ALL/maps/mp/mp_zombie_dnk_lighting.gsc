/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_zombie_dnk_lighting.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 59 ms
 * Timestamp: 10/27/2023 3:18:49 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	func_84F8();
	if(level.var_1D4 && getdvar("2695") != "true")
	{
		xbox_optimizations();
	}
}

//Function Number: 2
func_84F8()
{
	setdvar("2973",0);
	setdvar("2664",1);
	setdvar("5153",1);
}

//Function Number: 3
xbox_optimizations()
{
	setdvar("5153",0);
}