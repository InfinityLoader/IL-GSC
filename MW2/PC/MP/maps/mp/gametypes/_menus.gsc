/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_menus.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

init()
{
	if(!isdefined(game["gamestarted"]))
	{
		game["menu_team"] = "team_marinesopfor";
		game["menu_class_allies"] = "class_marines";
		game["menu_changeclass_allies"] = "changeclass_marines";
		game["menu_initteam_allies"] = "initteam_marines";
		game["menu_class_axis"] = "class_opfor";
		game["menu_changeclass_axis"] = "changeclass_opfor";
		game["menu_initteam_axis"] = "initteam_opfor";
		game["menu_class"] = "class";
		game["menu_changeclass"] = "changeclass";
		game["menu_onemanarmy"] = "onemanarmy";
		game["menu_controls"] = "ingame_controls";
		if(!level.console)
		{
			game["menu_muteplayer"] = "muteplayer";
			precachemenu(game["menu_muteplayer"]);
		}
		else
		{
			game["menu_leavegame"] = "popup_leavegame";
			if(level.splitscreen)
			{
				game["menu_team"] = game["menu_team"] + "_splitscreen";
				game["menu_class_allies"] = game["menu_class_allies"] + "_splitscreen";
				game["menu_changeclass_allies"] = game["menu_changeclass_allies"] + "_splitscreen";
				game["menu_class_axis"] = game["menu_class_axis"] + "_splitscreen";
				game["menu_changeclass_axis"] = game["menu_changeclass_axis"] + "_splitscreen";
				game["menu_class"] = game["menu_class"] + "_splitscreen";
				game["menu_controls"] = game["menu_controls"] + "_splitscreen";
				game["menu_leavegame"] = game["menu_leavegame"] + "_splitscreen";
				game["menu_onemanarmy"] = game["menu_onemanarmy"] + "_splitscreen";
				game["menu_changeclass_defaults_splitscreen"] = "changeclass_defaults_splitscreen";
				game["menu_changeclass_custom_splitscreen"] = "changeclass_custom_splitscreen";
				game["menu_onemanarmy_defaults_splitscreen"] = "onemanarmy_defaults_splitscreen";
				game["menu_onemanarmy_custom_splitscreen"] = "onemanarmy_custom_splitscreen";
				precachemenu(game["menu_changeclass_defaults_splitscreen"]);
				precachemenu(game["menu_changeclass_custom_splitscreen"]);
				precachemenu(game["menu_onemanarmy_defaults_splitscreen"]);
				precachemenu(game["menu_onemanarmy_custom_splitscreen"]);
			}

			precachemenu(game["menu_controls"]);
			precachemenu(game["menu_leavegame"]);
		}

		precachemenu("scoreboard");
		precachemenu(game["menu_team"]);
		precachemenu(game["menu_class_allies"]);
		precachemenu(game["menu_changeclass_allies"]);
		precachemenu(game["menu_initteam_allies"]);
		precachemenu(game["menu_class_axis"]);
		precachemenu(game["menu_changeclass_axis"]);
		precachemenu(game["menu_class"]);
		precachemenu(game["menu_changeclass"]);
		precachemenu(game["menu_initteam_axis"]);
		precachemenu(game["menu_onemanarmy"]);
		precachestring(&"MP_HOST_ENDED_GAME");
		precachestring(&"MP_HOST_ENDGAME_RESPONSE");
	}

	level thread onplayerconnect();
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		player thread onmenuresponse();
	}
}

isoptionsmenu(menu)
{
	if(menu == game["menu_changeclass"])
	{
		return 1;
	}

	if(menu == game["menu_team"])
	{
		return 1;
	}

	if(menu == game["menu_controls"])
	{
		return 1;
	}

	if(issubstr(menu, "pc_options"))
	{
		return 1;
	}

	return 0;
}

onmenuresponse()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("menuresponse", menu, response);
		if(response == "back")
		{
			self closepopupmenu();
			self closeingamemenu();
			if(isoptionsmenu(menu))
			{
				if(self.pers["team"] == "allies")
				{
					self openpopupmenu(game["menu_class_allies"]);
				}

				if(self.pers["team"] == "axis")
				{
					self openpopupmenu(game["menu_class_axis"]);
				}
			}

			continue;
		}

		if(response == "changeteam")
		{
			self closepopupmenu();
			self closeingamemenu();
			self openpopupmenu(game["menu_team"]);
		}

		if(response == "changeclass_marines")
		{
			self closepopupmenu();
			self closeingamemenu();
			self openpopupmenu(game["menu_changeclass_allies"]);
			continue;
		}

		if(response == "changeclass_opfor")
		{
			self closepopupmenu();
			self closeingamemenu();
			self openpopupmenu(game["menu_changeclass_axis"]);
			continue;
		}

		if(response == "changeclass_marines_splitscreen")
		{
			self openpopupmenu("changeclass_marines_splitscreen");
		}

		if(response == "changeclass_opfor_splitscreen")
		{
			self openpopupmenu("changeclass_opfor_splitscreen");
		}

		if(response == "endgame")
		{
			if(level.splitscreen)
			{
				print3d();
				if(!level.gameended)
				{
					level thread maps\mp\gametypes\_gamelogic::forceend();
				}
			}

			continue;
		}

		if(response == "endround")
		{
			if(!level.gameended)
			{
				level thread maps\mp\gametypes\_gamelogic::forceend();
			}
			else
			{
				self closepopupmenu();
				self closeingamemenu();
				self iprintln(&"MP_HOST_ENDGAME_RESPONSE");
			}

			continue;
		}

		if(menu == game["menu_team"])
		{
			switch(response)
			{
				case "allies":
					self [[ level.allies ]]();
					break;
	
				case "axis":
					self [[ level.axis ]]();
					break;
	
				case "autoassign":
					self [[ level.autoassign ]]();
					break;
	
				case "spectator":
					self [[ level.spectator ]]();
					break;
			}

			continue;
		}

		if(menu == game["menu_changeclass"] || isdefined(game["menu_changeclass_defaults_splitscreen"]) && menu == game["menu_changeclass_defaults_splitscreen"] || isdefined(game["menu_changeclass_custom_splitscreen"]) && menu == game["menu_changeclass_custom_splitscreen"])
		{
			self closepopupmenu();
			self closeingamemenu();
			self.selectedclass = 1;
			self [[ level.class ]](response);
			continue;
		}

		if(!level.console)
		{
			if(menu == game["menu_quickcommands"])
			{
				maps\mp\gametypes\_quickmessages::quickcommands(response);
				continue;
			}

			if(menu == game["menu_quickstatements"])
			{
				maps\mp\gametypes\_quickmessages::quickstatements(response);
				continue;
			}

			if(menu == game["menu_quickresponses"])
			{
				maps\mp\gametypes\_quickmessages::quickresponses(response);
			}
		}
	}
}

getteamassignment()
{
	teams[0] = "allies";
	teams[1] = "axis";
	if(!level.teambased)
	{
		return teams[randomint(2)];
	}

	if(self.sessionteam != "none" && self.sessionteam != "spectator" && self.sessionstate != "playing" && self.sessionstate != "dead")
	{
		assignment = self.sessionteam;
	}
	else
	{
		playercounts = maps\mp\gametypes\_teams::countplayers();
		if(playercounts["allies"] == playercounts["axis"])
		{
			if(getteamscore("allies") == getteamscore("axis"))
			{
				assignment = teams[randomint(2)];
			}
			else if(getteamscore("allies") < getteamscore("axis"))
			{
				assignment = "allies";
			}
			else
			{
				assignment = "axis";
			}
		}
		else if(playercounts["allies"] < playercounts["axis"])
		{
			assignment = "allies";
		}
		else
		{
			assignment = "axis";
		}
	}

	return assignment;
}

menuautoassign()
{
	maps\mp\_utility::closemenus();
	assignment = getteamassignment();
	if(isdefined(self.pers["team"]) && self.sessionstate == "playing" || self.sessionstate == "dead")
	{
		if(assignment == self.pers["team"])
		{
			beginclasschoice();
			return;
		}

		self.switching_teams = 1;
		self.joining_team = assignment;
		self.leaving_team = self.pers["team"];
		self suicide();
	}

	addtoteam(assignment);
	self.pers["class"] = undefined;
	self.class = undefined;
	if(!isalive(self))
	{
		self.statusicon = "hud_status_dead";
	}

	self notify("end_respawn");
	beginclasschoice();
}

beginclasschoice(forcenewchoice)
{
	team = self.pers["team"];
	self openpopupmenu(game["menu_changeclass_" + team]);
	if(!isalive(self))
	{
		thread maps\mp\gametypes\_playerlogic::predictabouttospawnplayerovertime(0.1);
		return;
	}
}

beginteamchoice()
{
	self openpopupmenu(game["menu_team"]);
}

showmainmenuforteam()
{
	team = self.pers["team"];
	self openpopupmenu(game["menu_class_" + team]);
}

menuallies()
{
	maps\mp\_utility::closemenus();
	if(self.pers["team"] != "allies")
	{
		if(level.teambased && !maps\mp\gametypes\_teams::getjointeampermissions("allies"))
		{
			self openpopupmenu(game["menu_team"]);
			return;
		}

		if(level.ingraceperiod && !self.hasdonecombat)
		{
			self.hasspawned = 0;
		}

		if(self.sessionstate == "playing")
		{
			self.switching_teams = 1;
			self.joining_team = "allies";
			self.leaving_team = self.pers["team"];
			self suicide();
		}

		addtoteam("allies");
		self.pers["class"] = undefined;
		self.class = undefined;
		self notify("end_respawn");
	}

	beginclasschoice();
}

menuaxis()
{
	maps\mp\_utility::closemenus();
	if(self.pers["team"] != "axis")
	{
		if(level.teambased && !maps\mp\gametypes\_teams::getjointeampermissions("axis"))
		{
			self openpopupmenu(game["menu_team"]);
			return;
		}

		if(level.ingraceperiod && !self.hasdonecombat)
		{
			self.hasspawned = 0;
		}

		if(self.sessionstate == "playing")
		{
			self.switching_teams = 1;
			self.joining_team = "axis";
			self.leaving_team = self.pers["team"];
			self suicide();
		}

		addtoteam("axis");
		self.pers["class"] = undefined;
		self.class = undefined;
		self notify("end_respawn");
	}

	beginclasschoice();
}

menuspectator()
{
	maps\mp\_utility::closemenus();
	if(isdefined(self.pers["team"]) && self.pers["team"] == "spectator")
	{
		return;
	}

	if(isalive(self))
	{
		self.switching_teams = 1;
		self.joining_team = "spectator";
		self.leaving_team = self.pers["team"];
		self suicide();
	}

	addtoteam("spectator");
	self.pers["class"] = undefined;
	self.class = undefined;
	thread maps\mp\gametypes\_playerlogic::spawnspectator();
}

menuclass(response)
{
	maps\mp\_utility::closemenus();
	if(response == "demolitions_mp,0" && self getplayerdata("featureNew", "demolitions"))
	{
		self setplayerdata("featureNew", "demolitions", 0);
	}

	if(response == "sniper_mp,0" && self getplayerdata("featureNew", "sniper"))
	{
		self setplayerdata("featureNew", "sniper", 0);
	}

	if(!isdefined(self.pers["team"]) || self.pers["team"] != "allies" && self.pers["team"] != "axis")
	{
		return;
	}

	class = maps\mp\gametypes\_class::getclasschoice(response);
	primary = maps\mp\gametypes\_class::getweaponchoice(response);
	if(class == "restricted")
	{
		beginclasschoice();
		return;
	}

	if(isdefined(self.pers["class"]) && self.pers["class"] == class && isdefined(self.pers["primary"]) && self.pers["primary"] == primary)
	{
		return;
	}

	if(self.sessionstate == "playing")
	{
		self.pers["class"] = class;
		self.class = class;
		self.pers["primary"] = primary;
		if(game["state"] == "postgame")
		{
			return;
		}

		if(level.ingraceperiod && !self.hasdonecombat)
		{
			maps\mp\gametypes\_class::setclass(self.pers["class"]);
			self.tag_stowed_back = undefined;
			self.tag_stowed_hip = undefined;
			maps\mp\gametypes\_class::giveloadout(self.pers["team"], self.pers["class"]);
		}
		else
		{
			self iprintlnbold(game["strings"]["change_class"]);
		}
	}
	else
	{
		self.pers["class"] = class;
		self.class = class;
		self.pers["primary"] = primary;
		if(game["state"] == "postgame")
		{
			return;
		}

		if(game["state"] == "playing" && !maps\mp\_utility::isinkillcam())
		{
			thread maps\mp\gametypes\_playerlogic::spawnclient();
		}
	}

	thread maps\mp\gametypes\_spectating::setspectatepermissions();
}

addtoteam(team, firstconnect)
{
	if(isdefined(self.team))
	{
		maps\mp\gametypes\_playerlogic::removefromteamcount();
	}

	self.pers["team"] = team;
	self.team = team;
	if(!maps\mp\_utility::matchmakinggame() || isdefined(self.pers["isBot"]))
	{
		if(level.teambased)
		{
			self.sessionteam = team;
		}
		else if(team == "spectator")
		{
			self.sessionteam = "spectator";
		}
		else
		{
			self.sessionteam = "none";
		}
	}

	if(game["state"] != "postgame")
	{
		maps\mp\gametypes\_playerlogic::addtoteamcount();
	}

	maps\mp\_utility::updateobjectivetext();
	if(isdefined(firstconnect) && firstconnect)
	{
		waittillframeend;
	}

	maps\mp\_utility::updatemainmenu();
	if(team == "spectator")
	{
		self notify("joined_spectators");
		level notify("joined_team");
		return;
	}

	self notify("joined_team");
	level notify("joined_team");
}