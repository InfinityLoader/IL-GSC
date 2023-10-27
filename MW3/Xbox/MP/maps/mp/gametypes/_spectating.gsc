/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_spectating.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 8
 * Decompile Time: 124 ms
 * Timestamp: 10/27/2023 2:25:53 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.spectateoverride["allies"] = spawnstruct();
	level.spectateoverride["axis"] = spawnstruct();
	level thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_2747();
		var_00 thread func_2748();
		var_00 thread func_2A87();
	}
}

//Function Number: 3
func_2747()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_team");
		setspectatepermissions();
	}
}

//Function Number: 4
func_2748()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("joined_spectators");
		setspectatepermissions();
	}
}

//Function Number: 5
func_2A87()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spectating_cycle");
		var_00 = self getspectatingplayer();
		if(isdefined(var_00))
		{
			self setcarddisplayslot(var_00,6);
		}
	}
}

//Function Number: 6
updatespectatesettings()
{
	level endon("game_ended");
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		level.players[var_00] setspectatepermissions();
	}
}

//Function Number: 7
getotherteam(param_00)
{
	if(param_00 == "axis")
	{
		return "allies";
	}

	if(param_00 == "allies")
	{
		return "axis";
	}

	return "none";
}

//Function Number: 8
setspectatepermissions()
{
	var_00 = self.sessionteam;
	if(level.gameended && gettime() - level.gameendtime >= 2000)
	{
		self allowspectateteam("allies",0);
		self allowspectateteam("axis",0);
		self allowspectateteam("freelook",0);
		self allowspectateteam("none",1);
		return;
	}

	var_01 = maps\mp\gametypes\_tweakables::func_270D("game","spectatetype");
	switch(var_01)
	{
		case 0:
			self allowspectateteam("allies",0);
			self allowspectateteam("axis",0);
			self allowspectateteam("freelook",0);
			self allowspectateteam("none",0);
			break;

		case 1:
			if(!level.teambased)
			{
				self allowspectateteam("allies",1);
				self allowspectateteam("axis",1);
				self allowspectateteam("none",1);
				self allowspectateteam("freelook",0);
			}
			else if(isdefined(var_00) && var_00 == "allies" || var_00 == "axis")
			{
				self allowspectateteam(var_00,1);
				self allowspectateteam(getotherteam(var_00),0);
				self allowspectateteam("freelook",0);
				self allowspectateteam("none",0);
			}
			else
			{
				self allowspectateteam("allies",0);
				self allowspectateteam("axis",0);
				self allowspectateteam("freelook",0);
				self allowspectateteam("none",0);
			}
			break;

		case 2:
			self allowspectateteam("allies",1);
			self allowspectateteam("axis",1);
			self allowspectateteam("freelook",1);
			self allowspectateteam("none",1);
			break;
	}

	if(isdefined(var_00) && var_00 == "axis" || var_00 == "allies")
	{
		if(isdefined(level.spectateoverride[var_00].allowfreespectate))
		{
			self allowspectateteam("freelook",1);
		}

		if(isdefined(level.spectateoverride[var_00].allowenemyspectate))
		{
			self allowspectateteam(getotherteam(var_00),1);
		}
	}
}