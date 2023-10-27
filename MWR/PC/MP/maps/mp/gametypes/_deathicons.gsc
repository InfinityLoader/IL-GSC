/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_deathicons.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 83 ms
 * Timestamp: 10/27/2023 2:41:15 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!level.teambased)
	{
		return;
	}

	precacheshader("headicon_dead");
	level thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.selfdeathicons = [];
	}
}

//Function Number: 3
updatedeathiconsenabled()
{
}

//Function Number: 4
adddeathicon(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!level.teambased)
	{
		return;
	}

	if(isdefined(param_04) && isplayer(param_04) && param_04 maps\mp\_utility::_hasperk("specialty_silentkill"))
	{
		return;
	}

	var_06 = param_00.origin;
	param_01 endon("spawned_player");
	param_01 endon("disconnect");
	if(!param_05)
	{
		wait(0.05);
		maps\mp\_utility::waittillslowprocessallowed();
	}

	if(getdvar("ui_hud_showdeathicons") == "0")
	{
		return;
	}

	if(level.hardcoremode)
	{
		return;
	}

	if(isdefined(self.lastdeathicon))
	{
		self.lastdeathicon destroy();
	}

	var_07 = newteamhudelem(param_02);
	var_07.x = var_06[0];
	var_07.y = var_06[1];
	var_07.z = var_06[2] + 54;
	var_07.alpha = 0.61;
	var_07.archived = 1;
	if(level.splitscreen)
	{
		var_07 setshader("headicon_dead",14,14);
	}
	else
	{
		var_07 setshader("headicon_dead",7,7);
	}

	var_07 setwaypoint(0);
	self.lastdeathicon = var_07;
	var_07 thread destroyslowly(param_03);
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