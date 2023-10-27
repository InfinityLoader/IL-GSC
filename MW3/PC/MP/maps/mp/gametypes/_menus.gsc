/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_menus.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 229 ms
 * Timestamp: 10/27/2023 2:12:38 AM
*******************************************************************/

//Function Number: 1
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
				game["menu_changeclass_defaults_splitscreen"] = "changeclass_splitscreen_defaults";
				game["menu_changeclass_custom_splitscreen"] = "changeclass_splitscreen_custom";
				precachemenu(game["menu_changeclass_defaults_splitscreen"]);
				precachemenu(game["menu_changeclass_custom_splitscreen"]);
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
		precachestring(&"MP_HOST_ENDED_GAME");
		precachestring(&"MP_HOST_ENDGAME_RESPONSE");
	}

	level thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onmenuresponse();
	}
}

//Function Number: 3
isoptionsmenu(param_00)
{
	if(param_00 == game["menu_changeclass"])
	{
		return 1;
	}

	if(param_00 == game["menu_team"])
	{
		return 1;
	}

	if(param_00 == game["menu_controls"])
	{
		return 1;
	}

	if(issubstr(param_00,"pc_options"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 4
onmenuresponse()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("menuresponse",var_00,var_01);
		if(var_01 == "back")
		{
			self closepopupmenu();
			self closeingamemenu();
			if(isoptionsmenu(var_00))
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

		if(var_01 == "changeteam")
		{
			self closepopupmenu();
			self closeingamemenu();
			self openpopupmenu(game["menu_team"]);
		}

		if(var_01 == "changeclass_marines")
		{
			self closepopupmenu();
			self closeingamemenu();
			self openpopupmenu(game["menu_changeclass_allies"]);
			continue;
		}

		if(var_01 == "changeclass_opfor")
		{
			self closepopupmenu();
			self closeingamemenu();
			self openpopupmenu(game["menu_changeclass_axis"]);
			continue;
		}

		if(var_01 == "changeclass_marines_splitscreen")
		{
			self openpopupmenu("changeclass_marines_splitscreen");
		}

		if(var_01 == "changeclass_opfor_splitscreen")
		{
			self openpopupmenu("changeclass_opfor_splitscreen");
		}

		if(var_01 == "endgame")
		{
			if(level.splitscreen)
			{
				endparty();
				if(!level.gameended)
				{
					level thread maps\mp\gametypes\_gamelogic::forceend();
				}
			}

			continue;
		}

		if(var_01 == "endround")
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

		if(var_00 == game["menu_team"])
		{
			switch(var_01)
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

		if(var_00 == game["menu_changeclass"] || isdefined(game["menu_changeclass_defaults_splitscreen"]) && var_00 == game["menu_changeclass_defaults_splitscreen"] || isdefined(game["menu_changeclass_custom_splitscreen"]) && var_00 == game["menu_changeclass_custom_splitscreen"])
		{
			self closepopupmenu();
			self closeingamemenu();
			self.selectedclass = 1;
			self [[ level.class ]](var_01);
			continue;
		}

		if(!level.console)
		{
			if(var_00 == game["menu_quickcommands"])
			{
				maps\mp\gametypes\_quickmessages::quickcommands(var_01);
				continue;
			}

			if(var_00 == game["menu_quickstatements"])
			{
				maps\mp\gametypes\_quickmessages::quickstatements(var_01);
				continue;
			}

			if(var_00 == game["menu_quickresponses"])
			{
				maps\mp\gametypes\_quickmessages::quickresponses(var_01);
			}
		}
	}
}

//Function Number: 5
getteamassignment()
{
	var_00[0] = "allies";
	if(!level.teambased)
	{
		return var_7B[randomint(2)];
	}

	if(self.sessionteam != "none" && self.sessionteam != "spectator" && self.sessionstate != "playing" && self.sessionstate != "dead")
	{
		var_01 = self.sessionteam;
	}
	else
	{
		var_02 = maps\mp\gametypes\_teams::countplayers();
		if(var_02["allies"] == var_02["axis"])
		{
			if(getteamscore("allies") == getteamscore("axis"))
			{
				var_01 = var_7B[randomint(2)];
			}
			else if(getteamscore("allies") < getteamscore("axis"))
			{
				var_01 = "allies";
			}
			else
			{
				var_01 = "axis";
			}
		}
		else if(var_02["allies"] < var_02["axis"])
		{
			var_01 = "allies";
		}
		else
		{
			var_01 = "axis";
		}
	}

	return var_01;
}

//Function Number: 6
menuautoassign()
{
	maps\mp\_utility::closemenus();
	var_00 = getteamassignment();
	if(isdefined(self.pers["team"]) && self.sessionstate == "playing" || self.sessionstate == "dead")
	{
		if(var_00 == self.pers["team"])
		{
			beginclasschoice();
			return;
		}
		else
		{
			self.switching_teams = 1;
			self.joining_team = var_00;
			self.leaving_team = self.pers["team"];
			self suicide();
		}
	}

	addtoteam(var_00);
	self.pers["class"] = undefined;
	self.class = undefined;
	if(!isalive(self))
	{
		self.statusicon = "hud_status_dead";
	}

	self notify("end_respawn");
	beginclasschoice();
}

//Function Number: 7
beginclasschoice(param_00)
{
	var_01 = self.pers["team"];
	if(maps\mp\_utility::allowclasschoice())
	{
		self openpopupmenu(game["menu_changeclass_" + var_01]);
	}
	else
	{
		thread bypassclasschoice();
	}

	if(!isalive(self))
	{
		thread maps\mp\gametypes\_playerlogic::predictabouttospawnplayerovertime(0.1);
	}
}

//Function Number: 8
bypassclasschoice()
{
	self.selectedclass = 1;
	self [[ level.class ]]("class0");
}

//Function Number: 9
beginteamchoice()
{
	self openpopupmenu(game["menu_team"]);
}

//Function Number: 10
showmainmenuforteam()
{
	var_00 = self.pers["team"];
	self openpopupmenu(game["menu_class_" + var_00]);
}

//Function Number: 11
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

//Function Number: 12
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

//Function Number: 13
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

//Function Number: 14
menuclass(param_00)
{
	maps\mp\_utility::closemenus();
	if(param_00 == "demolitions_mp,0" && self getplayerdata("featureNew","demolitions"))
	{
		self setplayerdata("featureNew","demolitions",0);
	}

	if(param_00 == "sniper_mp,0" && self getplayerdata("featureNew","sniper"))
	{
		self setplayerdata("featureNew","sniper",0);
	}

	if(!isdefined(self.pers["team"]) || self.pers["team"] != "allies" && self.pers["team"] != "axis")
	{
		return;
	}

	var_01 = maps\mp\gametypes\_class::getclasschoice(param_00);
	var_02 = maps\mp\gametypes\_class::getweaponchoice(param_00);
	if(var_01 == "restricted")
	{
		beginclasschoice();
		return;
	}

	if(isdefined(self.pers["class"]) && self.pers["class"] == var_01 && isdefined(self.pers["primary"]) && self.pers["primary"] == var_02)
	{
		return;
	}

	if(self.sessionstate == "playing")
	{
		if(isdefined(self.pers["lastClass"]) && isdefined(self.pers["class"]))
		{
			self.pers["lastClass"] = self.pers["class"];
			self.lastclass = self.pers["lastClass"];
		}

		self.pers["class"] = var_01;
		self.class = var_01;
		self.pers["primary"] = var_02;
		if(game["state"] == "postgame")
		{
			return;
		}

		if(level.ingraceperiod && !self.hasdonecombat)
		{
			maps\mp\gametypes\_class::setclass(self.pers["class"]);
			self.tag_stowed_back = undefined;
			self.tag_stowed_hip = undefined;
			maps\mp\gametypes\_class::giveloadout(self.pers["team"],self.pers["class"]);
		}
		else
		{
			self iprintlnbold(game["strings"]["change_class"]);
		}
	}
	else
	{
		if(isdefined(self.pers["lastClass"]) && isdefined(self.pers["class"]))
		{
			self.pers["lastClass"] = self.pers["class"];
			self.lastclass = self.pers["lastClass"];
		}

		self.pers["class"] = var_01;
		self.class = var_01;
		self.pers["primary"] = var_02;
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

//Function Number: 15
addtoteam(param_00,param_01)
{
	if(isdefined(self.team))
	{
		maps\mp\gametypes\_playerlogic::removefromteamcount();
	}

	self.pers["team"] = param_00;
	self.team = param_00;
	if(!maps\mp\_utility::matchmakinggame() || isdefined(self.pers["isBot"]) || !maps\mp\_utility::allowteamchoice())
	{
		if(level.teambased)
		{
			self.sessionteam = param_00;
		}
		else if(param_00 == "spectator")
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
	if(isdefined(param_01) && param_01)
	{
		waittillframeend;
	}

	maps\mp\_utility::updatemainmenu();
	if(param_00 == "spectator")
	{
		self notify("joined_spectators");
		level notify("joined_team");
		return;
	}

	self notify("joined_team");
	level notify("joined_team");
}