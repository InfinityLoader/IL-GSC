/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_deathicons.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

init()
{
	if(!level.teambased)
	{
		return;
	}

	precacheshader("headicon_dead");
	level thread onplayerconnect();
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		player.selfdeathicons = [];
	}
}

updatedeathiconsenabled()
{
}

adddeathicon(entity, param_AE2, team, timeout)
{
	if(!level.teambased)
	{
		return;
	}

	iconorg = entity.origin;
	param_AE2 endon("spawned_player");
	param_AE2 endon("disconnect");
	wait 0.05;
	maps\mp\_utility::waittillslowprocessallowed();
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

	newdeathicon = newteamhudelem(team);
	newdeathicon.x = iconorg[0];
	newdeathicon.y = iconorg[1];
	newdeathicon.z = iconorg[2] + 54;
	newdeathicon.alpha = 0.61;
	newdeathicon.archived = 1;
	if(level.splitscreen)
	{
		newdeathicon setshader("headicon_dead", 14, 14);
	}
	else
	{
		newdeathicon setshader("headicon_dead", 7, 7);
	}

	newdeathicon setwaypoint(1, 0);
	self.lastdeathicon = newdeathicon;
	newdeathicon thread destroyslowly(timeout);
}

destroyslowly(timeout)
{
	self endon("death");
	wait timeout;
	self fadeovertime(1);
	self.alpha = 0;
	wait 1;
	self destroy();
}