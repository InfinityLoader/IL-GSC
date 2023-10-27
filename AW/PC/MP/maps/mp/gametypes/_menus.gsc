/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/gametypes/_menus.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 345 ms
 * Timestamp: 10/27/2023 1:50:37 AM
*******************************************************************/

//Function Number: 1
init()
{
	if(!isdefined(game["gamestarted"]))
	{
		game["menu_team"] = "team_marinesopfor";
		if(level.multiteambased)
		{
			game["menu_team"] = "team_mt_options";
		}

		game["menu_class"] = "class";
		game["menu_class_allies"] = "class_marines";
		game["menu_class_axis"] = "class_opfor";
		game["menu_changeclass_allies"] = "changeclass_marines";
		game["menu_changeclass_axis"] = "changeclass_opfor";
		if(level.multiteambased)
		{
			for(var_00 = 0;var_00 < level.teamnamelist.size;var_00++)
			{
				var_01 = "menu_class_" + level.teamnamelist[var_00];
				var_02 = "menu_changeclass_" + level.teamnamelist[var_00];
				game[var_01] = game["menu_class_allies"];
				game[var_02] = "changeclass_marines";
			}
		}

		game["menu_changeclass"] = "changeclass";
		if(level.console)
		{
			game["menu_controls"] = "ingame_controls";
			if(level.splitscreen)
			{
				if(level.multiteambased)
				{
					for(var_00 = 0;var_00 < level.teamnamelist.size;var_00++)
					{
						var_01 = "menu_class_" + level.teamnamelist[var_00];
						var_02 = "menu_changeclass_" + level.teamnamelist[var_00];
						game[var_01] = game[var_01] + "_splitscreen";
						game[var_02] = game[var_02] + "_splitscreen";
					}
				}

				game["menu_team"] = game["menu_team"] + "_splitscreen";
				game["menu_class_allies"] = game["menu_class_allies"] + "_splitscreen";
				game["menu_class_axis"] = game["menu_class_axis"] + "_splitscreen";
				game["menu_changeclass_allies"] = game["menu_changeclass_allies"] + "_splitscreen";
				game["menu_changeclass_axis"] = game["menu_changeclass_axis"] + "_splitscreen";
				game["menu_controls"] = game["menu_controls"] + "_splitscreen";
				game["menu_changeclass_defaults_splitscreen"] = "changeclass_splitscreen_defaults";
				game["menu_changeclass_custom_splitscreen"] = "changeclass_splitscreen_custom";
			}
		}

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
		var_00 thread watchforclasschange();
		var_00 thread watchforteamchange();
		var_00 thread watchforleavegame();
		var_00 thread connectedmenus();
	}
}

//Function Number: 3
connectedmenus()
{
}

//Function Number: 4
getclasschoice(param_00)
{
	if(param_00 <= 100)
	{
		if(maps\mp\_utility::practiceroundgame())
		{
			param_00 = "practice" + param_00;
		}
		else
		{
			param_00 = "custom" + param_00;
		}
	}
	else if(param_00 <= 200)
	{
		param_00 = param_00 - 101;
		param_00 = "class" + param_00;
	}
	else if(param_00 <= 206)
	{
		param_00 = param_00 - 200;
		param_00 = "axis_recipe" + param_00;
	}
	else
	{
		param_00 = param_00 - 206;
		param_00 = "allies_recipe" + param_00;
	}

	return param_00;
}

//Function Number: 5
watchforclasschange()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 != "class_select")
		{
			continue;
		}

		if(maps\mp\_utility::ismlgsplitscreen() && self ismlgspectator() && !maps\mp\_utility::invirtuallobby())
		{
			self setclientomnvar("ui_options_menu",0);
			continue;
		}

		if(!istestclient(self) && !isai(self))
		{
			if("" + var_01 != "callback")
			{
				self setclientomnvar("ui_loadout_selected",var_01);
			}
		}

		if(isdefined(self.waitingtoselectclass) && self.waitingtoselectclass)
		{
			continue;
		}

		if(!maps\mp\_utility::allowclasschoice())
		{
			continue;
		}

		self setclientomnvar("ui_options_menu",0);
		if("" + var_01 != "callback")
		{
			if(isbot(self) || istestclient(self))
			{
				self.pers["class"] = var_01;
				self.class = var_01;
				maps\mp\gametypes\_class::clearcopycatloadout();
			}
			else
			{
				var_02 = var_01 + 1;
				var_02 = getclasschoice(var_02);
				if(!isdefined(self.pers["class"]) || var_02 == self.pers["class"])
				{
					continue;
				}

				self.pers["class"] = var_02;
				self.class = var_02;
				maps\mp\gametypes\_class::clearcopycatloadout();
				thread menugiveclass();
			}

			continue;
		}

		menuclass("callback");
	}
}

//Function Number: 6
watchforleavegame()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 != "end_game")
		{
			continue;
		}

		level thread maps\mp\gametypes\_gamelogic::forceend();
	}
}

//Function Number: 7
watchforteamchange()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 != "team_select")
		{
			continue;
		}

		if(maps\mp\_utility::matchmakinggame() && !getdvarint("force_ranking"))
		{
			continue;
		}

		if(var_01 != 3)
		{
			thread showloadoutmenu();
		}

		if(var_01 == 3)
		{
			self setclientomnvar("ui_options_menu",0);
			self setclientomnvar("ui_spectator_selected",1);
			self setclientomnvar("ui_loadout_selected",-1);
			self.spectating_actively = 1;
			if(maps\mp\_utility::ismlgsplitscreen())
			{
				self setmlgspectator(1);
				self setclientomnvar("ui_use_mlg_hud",1);
				thread maps\mp\gametypes\_spectating::setspectatepermissions();
			}
		}
		else
		{
			self setclientomnvar("ui_spectator_selected",-1);
			self.spectating_actively = 0;
			if(maps\mp\_utility::ismlgsplitscreen())
			{
				self setmlgspectator(0);
				self setclientomnvar("ui_use_mlg_hud",0);
			}
		}

		self setclientomnvar("ui_team_selected",var_01);
		if(var_01 == 0)
		{
			var_01 = "axis";
		}
		else if(var_01 == 1)
		{
			var_01 = "allies";
		}
		else if(var_01 == 2)
		{
			var_01 = "random";
		}
		else
		{
			var_01 = "spectator";
		}

		if(isdefined(self.pers["team"]) && var_01 == self.pers["team"])
		{
			self notify("selected_same_team");
			continue;
		}

		self setclientomnvar("ui_loadout_selected",-1);
		if(var_01 == "axis")
		{
			thread setteam("axis");
			continue;
		}

		if(var_01 == "allies")
		{
			thread setteam("allies");
			continue;
		}

		if(var_01 == "random")
		{
			self thread [[ level.autoassign ]]();
			continue;
		}

		if(var_01 == "spectator")
		{
			thread setspectator();
		}
	}
}

//Function Number: 8
showloadoutmenu()
{
	self endon("disconnect");
	level endon("game_ended");
	common_scripts\utility::waittill_any("joined_team","selected_same_team");
	self setclientomnvar("ui_options_menu",2);
}

//Function Number: 9
autoassign()
{
	if(maps\mp\_utility::iscoop())
	{
		thread setteam("allies");
		self.sessionteam = "allies";
		return;
	}

	if(!isdefined(self.team))
	{
		if(self ismlgspectator() && !maps\mp\_utility::invirtuallobby())
		{
			thread setspectator();
		}
		else if(level.teamcount["axis"] < level.teamcount["allies"])
		{
			thread setteam("axis");
		}
		else if(level.teamcount["allies"] < level.teamcount["axis"])
		{
			thread setteam("allies");
		}
		else if(getteamscore("allies") > getteamscore("axis"))
		{
			thread setteam("axis");
		}
		else
		{
			thread setteam("allies");
		}

		return;
	}

	if(self ismlgspectator() && !maps\mp\_utility::invirtuallobby())
	{
		thread setspectator();
		return;
	}

	if(level.teamcount["axis"] < level.teamcount["allies"] && self.team != "axis")
	{
		thread setteam("axis");
		return;
	}

	if(level.teamcount["allies"] < level.teamcount["axis"] && self.team != "allies")
	{
		thread setteam("allies");
		return;
	}

	if(level.teamcount["allies"] == level.teamcount["axis"])
	{
		if(getteamscore("allies") > getteamscore("axis") && self.team != "axis")
		{
			thread setteam("axis");
			return;
		}

		if(self.team != "allies")
		{
			thread setteam("allies");
			return;
		}

		return;
	}
}

//Function Number: 10
setteam(param_00)
{
	self endon("disconnect");
	if(!isai(self) && level.teambased && !maps\mp\gametypes\_teams::getjointeampermissions(param_00))
	{
		return;
	}

	if(level.ingraceperiod && !self.hasdonecombat)
	{
		self.hasspawned = 0;
	}

	if(self.sessionstate == "playing")
	{
		self.switching_teams = 1;
		self.joining_team = param_00;
		self.leaving_team = self.pers["team"];
	}

	addtoteam(param_00);
	if(self.sessionstate == "playing")
	{
		self suicide();
	}

	waitforclassselect();
	endrespawnnotify();
	if(self.sessionstate == "spectator")
	{
		if(game["state"] == "postgame")
		{
			return;
		}

		if(game["state"] == "playing" && !maps\mp\_utility::isinkillcam())
		{
			if(isdefined(self.waitingtospawnamortize) && self.waitingtospawnamortize)
			{
				return;
			}

			maps\mp\gametypes\_playerlogic::spawnclient();
		}

		thread maps\mp\gametypes\_spectating::setspectatepermissions();
	}
}

//Function Number: 11
setspectator()
{
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

	self notify("becameSpectator");
	addtoteam("spectator");
	self.pers["class"] = undefined;
	self.class = undefined;
	thread maps\mp\gametypes\_playerlogic::spawnspectator();
}

//Function Number: 12
handleclasschoicedisallowed()
{
	if(!isai(self) && maps\mp\_utility::showgenericmenuonmatchstart())
	{
		thread maps\mp\gametypes\_playerlogic::setuioptionsmenu(3);
		for(;;)
		{
			self waittill("luinotifyserver",var_00,var_01);
			if(var_00 == "class_select")
			{
				break;
			}
		}
	}

	self notify("notWaitingToSelectClass");
	self.waitingtoselectclass = 0;
	bypassclasschoice();
}

//Function Number: 13
waitforclassselect()
{
	self endon("disconnect");
	level endon("game_ended");
	self.waitingtoselectclass = 1;
	if(maps\mp\_utility::allowclasschoice())
	{
		for(;;)
		{
			self waittill("luinotifyserver",var_00,var_01);
			if(var_00 == "class_select")
			{
				break;
			}
		}

		if("" + var_01 != "callback")
		{
			if(isbot(self) || istestclient(self))
			{
				self.pers["class"] = var_01;
				self.class = var_01;
				maps\mp\gametypes\_class::clearcopycatloadout();
			}
			else
			{
				var_01 = var_01 + 1;
				self.pers["class"] = getclasschoice(var_01);
				self.class = getclasschoice(var_01);
				maps\mp\gametypes\_class::clearcopycatloadout();
			}

			self notify("notWaitingToSelectClass");
			self.waitingtoselectclass = 0;
			return;
		}

		self notify("notWaitingToSelectClass");
		self.waitingtoselectclass = 0;
		menuclass("callback");
		return;
	}

	handleclasschoicedisallowed();
}

//Function Number: 14
beginclasschoice(param_00)
{
	var_01 = self.pers["team"];
	if(maps\mp\_utility::allowclasschoice())
	{
		thread maps\mp\gametypes\_playerlogic::setuioptionsmenu(2);
		if(!self ismlgspectator() || maps\mp\_utility::invirtuallobby())
		{
			waitforclassselect();
		}

		endrespawnnotify();
		if(self.sessionstate == "spectator")
		{
			if(game["state"] == "postgame")
			{
				return;
			}

			if(game["state"] == "playing" && !maps\mp\_utility::isinkillcam())
			{
				if(isdefined(self.waitingtospawnamortize) && self.waitingtospawnamortize)
				{
					return;
				}

				thread maps\mp\gametypes\_playerlogic::spawnclient();
			}

			thread maps\mp\gametypes\_spectating::setspectatepermissions();
		}

		self.connecttime = gettime();
		return;
	}

	thread bypassclasschoice();
}

//Function Number: 15
bypassclasschoice()
{
	maps\mp\gametypes\_class::clearcopycatloadout();
	self.selectedclass = 1;
	self.class = "class0";
	if(isdefined(level.bypassclasschoicefunc))
	{
		self [[ level.bypassclasschoicefunc ]]();
	}
}

//Function Number: 16
beginteamchoice()
{
	thread maps\mp\gametypes\_playerlogic::setuioptionsmenu(1);
}

//Function Number: 17
showmainmenuforteam()
{
	var_00 = self.pers["team"];
	self openpopupmenu(game["menu_class_" + var_00]);
}

//Function Number: 18
menuspectator()
{
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
	maps\mp\gametypes\_class::clearcopycatloadout();
	thread maps\mp\gametypes\_playerlogic::spawnspectator();
}

//Function Number: 19
watchhasdonecombat()
{
	if(!self.hasdonecombat)
	{
		self endon("death");
		self endon("disconnect");
		self endon("streamClassWeaponsComplete");
		level endon("game_ended");
		self waittill("hasDoneCombat");
		self notify("endStreamClassWeapons");
		self iprintlnbold(game["strings"]["change_class_cancel"]);
		wait(2);
		self iprintlnbold(game["strings"]["change_class"]);
	}
}

//Function Number: 20
menugiveclass()
{
	if(level.ingraceperiod && !self.hasdonecombat)
	{
		thread maps\mp\gametypes\_playerlogic::streamclassweapons(1);
		if(self.classweaponswait)
		{
			self endon("death");
			self endon("disconnect");
			level endon("game_ended");
			self endon("endStreamClassWeapons");
			thread watchhasdonecombat();
			self iprintlnbold(game["strings"]["change_class_wait"]);
			self waittill("streamClassWeaponsComplete");
			self iprintlnbold("");
			self onlystreamactiveweapon(0);
		}

		maps\mp\gametypes\_class::setclass(self.pers["class"]);
		self.tag_stowed_back = undefined;
		self.tag_stowed_hip = undefined;
		maps\mp\gametypes\_class::giveloadout(self.pers["team"],self.pers["class"]);
		if(!isdefined(self.spawnplayergivingloadout))
		{
			maps\mp\gametypes\_class::applyloadout();
		}

		if(maps\mp\_utility::_hasperk("specialty_moreminimap"))
		{
			setomnvar("ui_minimap_extend_grace_period",1);
			return;
		}

		setomnvar("ui_minimap_extend_grace_period",0);
		return;
	}

	maps\mp\gametypes\_playerlogic::streamclassweapons();
	self iprintlnbold(game["strings"]["change_class"]);
}

//Function Number: 21
menuclass(param_00)
{
	var_01 = self.pers["team"];
	var_02 = maps\mp\gametypes\_class::getclasschoice(param_00);
	var_03 = maps\mp\gametypes\_class::getweaponchoice(param_00);
	if(var_02 == "restricted")
	{
		beginclasschoice();
		return;
	}

	if(isdefined(self.pers["class"]) && self.pers["class"] == var_02 && isdefined(self.pers["primary"]) && self.pers["primary"] == var_03)
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

		self.pers["class"] = var_02;
		self.class = var_02;
		maps\mp\gametypes\_class::clearcopycatloadout();
		self.pers["primary"] = var_03;
		if(game["state"] == "postgame")
		{
			return;
		}

		thread menugiveclass();
	}
	else
	{
		if(isdefined(self.pers["lastClass"]) && isdefined(self.pers["class"]))
		{
			self.pers["lastClass"] = self.pers["class"];
			self.lastclass = self.pers["lastClass"];
		}

		self.pers["class"] = var_02;
		self.class = var_02;
		maps\mp\gametypes\_class::clearcopycatloadout();
		self.pers["primary"] = var_03;
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

//Function Number: 22
addtoteam(param_00,param_01,param_02)
{
	if(isdefined(self.team))
	{
		maps\mp\gametypes\_playerlogic::removefromteamcount();
		if(isdefined(param_02) && param_02)
		{
			maps\mp\gametypes\_playerlogic::decrementalivecount(self.team);
		}
	}

	self.pers["team"] = param_00;
	self.team = param_00;
	if(!getdvarint("party_playersCoop",0) && !maps\mp\_utility::matchmakinggame() || isbot(self) || istestclient(self) || !maps\mp\_utility::allowteamchoice() || getdvarint("force_ranking"))
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
		if(isdefined(param_02) && param_02)
		{
			maps\mp\gametypes\_playerlogic::incrementalivecount(self.team);
		}
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
		level notify("joined_team",self);
		return;
	}

	self notify("joined_team");
	level notify("joined_team",self);
}

//Function Number: 23
endrespawnnotify()
{
	self.waitingtospawn = 0;
	self notify("end_respawn");
}