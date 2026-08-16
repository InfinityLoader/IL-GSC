/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_spectating.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

init()
{
	level.spectateoverride["allies"] = spawnstruct();
	level.spectateoverride["axis"] = spawnstruct();
	level thread onplayerconnect();
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		player thread onjoinedteam();
		player thread onjoinedspectators();
		player thread onspectatingclient();
	}
}

onjoinedteam()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_team");
		setspectatepermissions();
	}
}

onjoinedspectators()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_spectators");
		setspectatepermissions();
	}
}

onspectatingclient()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spectating_cycle");
		spectatedplayer = self getspectatingplayer();
		if(isdefined(spectatedplayer))
		{
			self setcarddisplayslot(spectatedplayer, 6);
		}
	}
}

updatespectatesettings()
{
	level endon("game_ended");
	for(index = 0;index < level.players.size;index++)
	{
		level.players[index] setspectatepermissions();
	}
}

getotherteam(team)
{
	if(team == "axis")
	{
		return "allies";
	}

	if(team == "allies")
	{
		return "axis";
	}

	return "none";
}

setspectatepermissions()
{
	team = self.sessionteam;
	if(level.gameended && gettime() - level.gameendtime >= 2000)
	{
		self allowspectateteam("allies", 0);
		self allowspectateteam("axis", 0);
		self allowspectateteam("freelook", 0);
		self allowspectateteam("none", 1);
		return;
	}

	spectatetype = maps\mp\gametypes\_tweakables::gettweakablevalue("game", "spectatetype");
	switch(spectatetype)
	{
		case 0:
			self allowspectateteam("allies", 0);
			self allowspectateteam("axis", 0);
			self allowspectateteam("freelook", 0);
			self allowspectateteam("none", 0);
			break;

		case 1:
			if(!level.teambased)
			{
				self allowspectateteam("allies", 1);
				self allowspectateteam("axis", 1);
				self allowspectateteam("none", 1);
				self allowspectateteam("freelook", 0);
			}
			else if(isdefined(team) && team == "allies" || team == "axis")
			{
				self allowspectateteam(team, 1);
				self allowspectateteam(getotherteam(team), 0);
				self allowspectateteam("freelook", 0);
				self allowspectateteam("none", 0);
			}
			else
			{
				self allowspectateteam("allies", 0);
				self allowspectateteam("axis", 0);
				self allowspectateteam("freelook", 0);
				self allowspectateteam("none", 0);
			}
			break;

		case 2:
			self allowspectateteam("allies", 1);
			self allowspectateteam("axis", 1);
			self allowspectateteam("freelook", 1);
			self allowspectateteam("none", 1);
			break;
	}

	if(isdefined(team) && team == "axis" || team == "allies")
	{
		if(isdefined(level.spectateoverride[team].allowfreespectate))
		{
			self allowspectateteam("freelook", 1);
		}

		if(isdefined(level.spectateoverride[team].allowenemyspectate))
		{
			self allowspectateteam(getotherteam(team), 1);
			return;
		}

		return;
	}
}