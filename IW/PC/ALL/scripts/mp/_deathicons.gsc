/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_deathicons.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 302 ms
 * Timestamp: 10/27/2023 12:15:06 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!level.teambased)
	{
		return;
	}

	level thread func_C56E();
}

//Function Number: 2
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.var_F1E9 = [];
	}
}

//Function Number: 3
func_12E86()
{
}

//Function Number: 4
func_17C1(param_00,param_01,param_02,param_03)
{
	if(!level.teambased)
	{
		return;
	}

	var_04 = param_00.origin;
	param_01 endon("spawned_player");
	param_01 endon("disconnect");
	wait(0.05);
	scripts\mp\_utility::func_13842();
	if(getdvar("ui_hud_showdeathicons") == "0")
	{
		return;
	}

	if(level.var_8B38)
	{
		return;
	}

	if(isdefined(self.var_A971))
	{
		self.var_A971 destroy();
	}

	var_05 = newteamhudelem(param_02);
	var_05.x = var_04[0];
	var_05.y = var_04[1];
	var_05.var_3A6 = var_04[2] + 54;
	var_05.alpha = 0.61;
	var_05.archived = 0;
	var_05.showinkillcam = 0;
	if(level.splitscreen)
	{
		var_05 setshader("hud_icon_death",14,14);
	}
	else
	{
		var_05 setshader("hud_icon_death",7,7);
	}

	var_05 setwaypoint(0);
	self.var_A971 = var_05;
	var_05 thread func_5323(param_03);
}

//Function Number: 5
func_5323(param_00)
{
	self endon("death");
	wait(param_00);
	self fadeovertime(1);
	self.alpha = 0;
	wait(1);
	self destroy();
}