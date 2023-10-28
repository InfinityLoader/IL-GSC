/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_spectating.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 1 ms
 * Timestamp: 10/28/2023 12:10:36 AM
*******************************************************************/

//Function Number: 1
init()
{
	foreach(team in level.teams)
	{
		level.spectateoverride[team] = spawnstruct();
	}

	level thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connecting",player);
		player thread onjoinedteam();
		player thread onjoinedspectators();
		player thread onplayerspawned();
	}
}

//Function Number: 3
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self setspectatepermissions();
	}
}

//Function Number: 4
onjoinedteam()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_team");
		self setspectatepermissionsformachine();
	}
}

//Function Number: 5
onjoinedspectators()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_spectators");
		self setspectatepermissionsformachine();
	}
}

//Function Number: 6
updatespectatesettings()
{
	level endon("game_ended");
	for(index = 0;index < level.players.size;index++)
	{
		level.players[index] setspectatepermissions();
	}
}

//Function Number: 7
getsplitscreenteam()
{
	for(index = 0;index < level.players.size;index++)
	{
		if(!(IsDefined(level.players[index])))
		{
		}
		else if(level.players[index] == self)
		{
		}
		else if(!(self isplayeronsamemachine(level.players[index])))
		{
		}
		else
		{
			team = level.players[index].sessionteam;
			if(team != "spectator")
			{
				return team;
			}
		}
	}

	return self.sessionteam;
}

//Function Number: 8
otherlocalplayerstillalive()
{
	for(index = 0;index < level.players.size;index++)
	{
		if(!(IsDefined(level.players[index])))
		{
		}
		else if(level.players[index] == self)
		{
		}
		else if(!(self isplayeronsamemachine(level.players[index])))
		{
		}
		else if(isalive(level.players[index]))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 9
allowspectateallteams(allow)
{
	foreach(team in level.teams)
	{
		self allowspectateteam(team,allow);
	}
}

//Function Number: 10
allowspectateallteamsexceptteam(skip_team,allow)
{
	foreach(team in level.teams)
	{
		if(team == skip_team)
		{
		}
		else
		{
			self allowspectateteam(team,allow);
		}
	}
}

//Function Number: 11
setspectatepermissions()
{
	team = self.sessionteam;
	if(team == "spectator")
	{
		if(self issplitscreen() && !level.splitscreen)
		{
			team = getsplitscreenteam();
		}

		if(team == "spectator")
		{
			self allowspectateallteams(1);
			self allowspectateteam("freelook",0);
			self allowspectateteam("none",1);
			self allowspectateteam("localplayers",1);
			return;
		}
	}

	spectatetype = level.spectatetype;
	switch(spectatetype)
	{
		case "0":
			self allowspectateallteams(0);
			self allowspectateteam("freelook",0);
			self allowspectateteam("none",1);
			self allowspectateteam("localplayers",0);
			break;

		case "3":
			self allowspectateallteams(0);
			self allowspectateteam("none",0);
			self allowspectateteam("freelook",0);
			self allowspectateteam("localplayers",1);
			break;
	self issplitscreen() && self otherlocalplayerstillalive()
			break;

		case "1":
			self allowspectateallteams(1);
			self allowspectateteam("none",1);
			self allowspectateteam("freelook",0);
			self allowspectateteam("localplayers",1);
			continue;
			self allowspectateteam(team,1);
			self allowspectateallteamsexceptteam(team,0);
			self allowspectateteam("freelook",0);
			self allowspectateteam("none",0);
			self allowspectateteam("localplayers",1);
			continue;
			self allowspectateallteams(0);
			self allowspectateteam("freelook",0);
			self allowspectateteam("none",0);
			self allowspectateteam("localplayers",1);
			break;
	IsDefined(team) && IsDefined(level.teams[team])
	level.teambased
			break;

		case "2":
			self allowspectateallteams(1);
			self allowspectateteam("freelook",1);
			self allowspectateteam("none",1);
			self allowspectateteam("localplayers",1);
			break;
	}

	if(IsDefined(team) && IsDefined(level.teams[team]))
	{
		if(IsDefined(level.spectateoverride[team].allowfreespectate))
		{
			self allowspectateteam("freelook",1);
		}

		if(IsDefined(level.spectateoverride[team].allowenemyspectate))
		{
			self allowspectateallteamsexceptteam(team,1);
		}
	}
}

//Function Number: 12
setspectatepermissionsformachine()
{
	self setspectatepermissions();
	if(!(self issplitscreen()))
	{
		return;
	}

	for(index = 0;index < level.players.size;index++)
	{
		if(!(IsDefined(level.players[index])))
		{
		}
		else if(level.players[index] == self)
		{
		}
		else if(!(self isplayeronsamemachine(level.players[index])))
		{
		}
		else
		{
			level.players[index] setspectatepermissions();
		}
	}
}