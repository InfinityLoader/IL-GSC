/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_zombie_descent_lighting.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 152 ms
 * Timestamp: 10/27/2023 3:18:24 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	func_84F8();
}

//Function Number: 2
xbox_optimizations()
{
	setdvar("1578",0);
	setdvar("5156",0);
	setdvar("3158",0.7);
	setdvar("2225",4);
	setdvar("sm_spotDynamics",4);
}

//Function Number: 3
lightningrodlights()
{
	var_00 = function_021F("lightningrodlights","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("lightpart","on");
	}
}

//Function Number: 4
bossintrolightson()
{
	var_00 = function_021F("boss_intro_lgt","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("lightpart","on");
	}
}

//Function Number: 5
bossintrolightsoff()
{
	var_00 = function_021F("boss_intro_lgt","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("lightpart","off");
	}
}

//Function Number: 6
bossarenalightsoff()
{
	var_00 = function_021F("boss_arena_lgt","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("lightpart","off");
	}
}

//Function Number: 7
bossarenalightson()
{
	var_00 = function_021F("boss_arena_lgt","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setscriptablepartstate("lightpart","on");
	}
}

//Function Number: 8
func_84F8()
{
	setdvar("2973",0);
	setdvar("2664",1);
}

//Function Number: 9
func_6B82()
{
	var_00 = self;
	var_00 endon("disconnect");
	wait(15);
	var_00 method_8483("mp_zombie_descent_moonravengreen");
	wait(5);
	var_00 method_8483("");
}