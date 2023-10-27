/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_deathicons.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 98 ms
 * Timestamp: 10/27/2023 1:18:04 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	if(!level.teambased)
	{
		return;
	}

	precacheshader("headicon_dead");
	level thread func_595D();
}

//Function Number: 2
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.selfdeathicons = [];
	}
}

//Function Number: 3
func_86E2()
{
}

//Function Number: 4
adddeathicon(param_00,param_01,param_02,param_03)
{
	if(!level.teambased)
	{
	}

	var_04 = param_00.origin;
	param_01 endon("spawned_player");
	param_01 endon("disconnect");
	wait(0.05);
	maps\mp\_utility::func_8BC1();
	if(getdvar("ui_hud_showdeathicons") == "0")
	{
	}

	if(level.hardcoremode)
	{
	}

	if(isdefined(self.lastdeathicon))
	{
		self.lastdeathicon destroy();
	}

	var_05 = newteamhudelem(param_02);
	var_05.x = var_04[0];
	var_05.y = var_04[1];
	var_05.z = var_04[2] + 54;
	var_05.alpha = 0.61;
	var_05.archived = 0;
	var_05.showinkillcam = 0;
	if(level.splitscreen)
	{
		var_05 setshader("headicon_dead",14,14);
	}
	else
	{
		var_05 setshader("headicon_dead",7,7);
	}

	var_05 setwaypoint(0);
	self.lastdeathicon = var_05;
	var_05 thread destroyslowly(param_03);
}

//Function Number: 5
destroyslowly(param_00)
{
	self endon("death");
	wait(param_00);
	self fadeovertime(1);
	self.alpha = 0;
	wait(1);
	self destroy();
}