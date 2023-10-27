/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_menus.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 439 ms
 * Timestamp: 10/27/2023 1:18:40 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	if(!isdefined(game["gamestarted"]))
	{
		game["menu_team"] = "team_marinesopfor";
		if(level.multiteambased)
		{
			game["menu_team"] = "team_mt_options";
		}

		if(maps\mp\_utility::bot_is_fireteam_mode())
		{
			level.fireteam_menu = "class_commander_" + level.gametype;
			game["menu_class"] = level.fireteam_menu;
			game["menu_class_allies"] = level.fireteam_menu;
			game["menu_class_axis"] = level.fireteam_menu;
		}
		else
		{
			game["menu_class"] = "class";
			game["menu_class_allies"] = "class_marines";
			game["menu_class_axis"] = "class_opfor";
		}

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
				precachemenu(game["menu_changeclass_defaults_splitscreen"]);
				precachemenu(game["menu_changeclass_custom_splitscreen"]);
			}

			precachemenu(game["menu_controls"]);
		}

		precachemenu(game["menu_team"]);
		precachemenu(game["menu_class_allies"]);
		precachemenu(game["menu_class_axis"]);
		precachemenu(game["menu_changeclass"]);
		precachemenu(game["menu_changeclass_allies"]);
		precachemenu(game["menu_changeclass_axis"]);
		precachemenu(game["menu_class"]);
		precachestring(&"MP_HOST_ENDED_GAME");
		precachestring(&"MP_HOST_ENDGAME_RESPONSE");
	}

	level thread func_595D();
}

//Function Number: 2
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_8CE6();
		var_00 thread func_8CF0();
		var_00 thread func_8CEA();
		var_00 thread func_1EBB();
	}
}

//Function Number: 3
func_1EBB()
{
}

//Function Number: 4
func_3A54(param_00)
{
	if(param_00 > 10)
	{
		if(param_00 > 10 && param_00 < 17)
		{
			param_00 = param_00 - 10;
			param_00 = "axis_recipe" + param_00;
		}
		else if(param_00 > 16 && param_00 < 23)
		{
			param_00 = param_00 - 16;
			param_00 = "allies_recipe" + param_00;
		}
	}
	else
	{
		param_00 = "custom" + param_00;
	}

	return param_00;
}

//Function Number: 5
func_8CE6()
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

		if(getdvarint("systemlink") && getdvarint("xblive_competitionmatch") && self ismlgspectator())
		{
			self setclientomnvar("ui_options_menu",0);
			continue;
		}

		var_02 = isai(self) || issubstr(self.name,"tcBot");
		if(!var_02)
		{
			if(!isai(self) && "" + var_01 != "callback")
			{
				self setclientomnvar("ui_loadout_selected",var_01);
			}
		}

		if(isdefined(self.waitingtoselectclass) && self.waitingtoselectclass)
		{
			continue;
		}

		if(!maps\mp\_utility::allowclasschoice() || maps\mp\_utility::showfakeloadout())
		{
			continue;
		}

		if("" + var_01 != "callback")
		{
			if(isdefined(self.pers["isBot"]) && self.pers["isBot"])
			{
				self.pers["class"] = var_01;
				self.class = var_01;
			}
			else
			{
				var_03 = var_01 + 1;
				var_03 = func_3A54(var_03);
				if(!isdefined(self.pers["class"]) || var_03 == self.pers["class"])
				{
					continue;
				}

				self.pers["class"] = var_03;
				self.class = var_03;
				if(level.ingraceperiod && !self.hasdonecombat)
				{
					maps\mp\gametypes\_class::func_7003(self.pers["class"]);
					self.tag_stowed_back = undefined;
					self.tag_stowed_hip = undefined;
					maps\mp\gametypes\_class::giveloadout(self.pers["team"],self.pers["class"]);
				}
				else if(isalive(self))
				{
					self iprintlnbold(game["strings"]["change_class"]);
				}
			}

			continue;
		}

		func_51CF("callback");
	}
}

//Function Number: 6
func_8CEA()
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

		if(maps\mp\_utility::func_47BB())
		{
			[[ level.forceendgame_alien ]]();
			continue;
		}

		level thread maps\mp\gametypes\_gamelogic::func_34D1(var_01);
	}
}

//Function Number: 7
func_8CF0()
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

		if(maps\mp\_utility::func_50C1())
		{
			continue;
		}

		if(var_01 != 3)
		{
			thread showloadoutmenu();
		}

		if(var_01 == 3)
		{
			self setclientomnvar("ui_spectator_selected",1);
			self setclientomnvar("ui_loadout_selected",-1);
			self.spectating_actively = 1;
			if(getdvarint("systemlink") && getdvarint("xblive_competitionmatch"))
			{
				self setmlgspectator(1);
				self.pers["mlgSpectator"] = 1;
				thread maps\mp\gametypes\_spectating::func_9452(1);
				thread maps\mp\gametypes\_spectating::func_70D0();
				self setclientomnvar("ui_options_menu",2);
			}
		}
		else
		{
			self setclientomnvar("ui_spectator_selected",-1);
			self.spectating_actively = 0;
			if(getdvarint("systemlink") && getdvarint("xblive_competitionmatch"))
			{
				self setmlgspectator(0);
				self.pers["mlgSpectator"] = 0;
				thread maps\mp\gametypes\_spectating::func_9452(0);
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
			thread func_70DF("axis");
			continue;
		}

		if(var_01 == "allies")
		{
			thread func_70DF("allies");
			continue;
		}

		if(var_01 == "random")
		{
			thread autoassign();
			continue;
		}

		if(var_01 == "spectator")
		{
			thread func_70D1();
		}
	}
}

//Function Number: 8
showloadoutmenu()
{
	self endon("disconnect");
	level endon("game_ended");
	common_scripts\utility::func_8B2A("joined_team","selected_same_team");
	self setclientomnvar("ui_options_menu",2);
}

//Function Number: 9
autoassign()
{
	if(maps\mp\_utility::func_47BB() || level.gametype == "infect")
	{
		thread func_70DF("allies");
	}

	if((getdvarint("squad_match") == 1 || getdvarint("squad_vs_squad") == 1 || getdvarint("squad_use_hosts_squad") == 1) && isdefined(self.bot_team))
	{
		thread func_70DF(self.bot_team);
	}

	if(!isdefined(self.team))
	{
		if(self ismlgspectator())
		{
			thread func_70D1();
		}
		else if(level.teamcount["axis"] < level.teamcount["allies"])
		{
			thread func_70DF("axis");
		}
		else if(level.teamcount["allies"] < level.teamcount["axis"])
		{
			thread func_70DF("allies");
		}
		else if(getteamscore("allies") > getteamscore("axis"))
		{
			thread func_70DF("axis");
		}
		else
		{
			thread func_70DF("allies");
		}
	}

	if(self ismlgspectator())
	{
		thread func_70D1();
	}

	if(level.teamcount["axis"] < level.teamcount["allies"] && self.team != "axis")
	{
		thread func_70DF("axis");
	}

	if(level.teamcount["allies"] < level.teamcount["axis"] && self.team != "allies")
	{
		thread func_70DF("allies");
	}

	if(level.teamcount["allies"] == level.teamcount["axis"])
	{
		if(getteamscore("allies") > getteamscore("axis") && self.team != "axis")
		{
			thread func_70DF("axis");
		}

		if(self.team != "allies")
		{
			thread func_70DF("allies");
		}
	}
}

//Function Number: 10
func_70DF(param_00)
{
	self endon("disconnect");
	if(!isai(self) && level.teambased && !maps\mp\gametypes\_teams::func_3AE0(param_00))
	{
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
		}

		if(game["state"] == "playing" && !maps\mp\_utility::func_48E2())
		{
			if(isdefined(self.waitingtospawnamortize) && self.waitingtospawnamortize)
			{
			}

			thread maps\mp\gametypes\_playerlogic::func_7866();
		}

		thread maps\mp\gametypes\_spectating::func_70D0();
	}

	self notify("okToSpawn");
}

//Function Number: 11
func_70D1()
{
	if(isdefined(self.pers["team"]) && self.pers["team"] == "spectator")
	{
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
waitforclassselect()
{
	self endon("disconnect");
	level endon("game_ended");
	self.waitingtoselectclass = 1;
	for(;;)
	{
		if(maps\mp\_utility::allowclasschoice() || maps\mp\_utility::showfakeloadout() && !isai(self))
		{
			self waittill("luinotifyserver",var_00,var_01);
		}
		else
		{
			bypassclasschoice();
			break;
		}

		if(var_00 != "class_select")
		{
			continue;
		}

		if(self.team == "spectator")
		{
			continue;
		}

		if("" + var_01 != "callback")
		{
			if(isdefined(self.pers["isBot"]) && self.pers["isBot"])
			{
				self.pers["class"] = var_01;
				self.class = var_01;
			}
			else
			{
				var_01 = var_01 + 1;
				self.pers["class"] = func_3A54(var_01);
				self.class = func_3A54(var_01);
			}

			self.waitingtoselectclass = 0;
		}
		else
		{
			self.waitingtoselectclass = 0;
			func_51CF("callback");
		}

		break;
	}
}

//Function Number: 13
beginclasschoice(param_00)
{
	var_01 = self.pers["team"];
	if(maps\mp\_utility::allowclasschoice() || maps\mp\_utility::showfakeloadout() && !isai(self))
	{
		self setclientomnvar("ui_options_menu",2);
		if(!self ismlgspectator())
		{
			waitforclassselect();
		}

		endrespawnnotify();
		if(self.sessionstate == "spectator")
		{
			if(game["state"] == "postgame")
			{
			}

			if(game["state"] == "playing" && !maps\mp\_utility::func_48E2())
			{
				if(isdefined(self.waitingtospawnamortize) && self.waitingtospawnamortize)
				{
				}

				thread maps\mp\gametypes\_playerlogic::func_7866();
			}

			thread maps\mp\gametypes\_spectating::func_70D0();
		}

		self.connecttime = gettime();
		self notify("okToSpawn");
	}
	else
	{
		thread bypassclasschoice();
	}

	if(!isalive(self))
	{
		thread maps\mp\gametypes\_playerlogic::func_611F(0.1);
	}
}

//Function Number: 14
bypassclasschoice()
{
	self.selectedclass = 1;
	self.waitingtoselectclass = 0;
	if(isdefined(level.bypassclasschoicefunc))
	{
		var_00 = self [[ level.bypassclasschoicefunc ]]();
		self.class = var_00;
	}

	self.class = "class0";
}

//Function Number: 15
beginteamchoice()
{
	self setclientomnvar("ui_options_menu",1);
}

//Function Number: 16
showmainmenuforteam()
{
	var_00 = self.pers["team"];
	self openpopupmenu(game["menu_class_" + var_00]);
}

//Function Number: 17
menuspectator()
{
	if(isdefined(self.pers["team"]) && self.pers["team"] == "spectator")
	{
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

//Function Number: 18
func_51CF(param_00)
{
	if(param_00 == "demolitions_mp,0" && self getrankedplayerdata("featureNew","demolitions"))
	{
		self setrankedplayerdata("featureNew","demolitions",0);
	}

	if(param_00 == "sniper_mp,0" && self getrankedplayerdata("featureNew","sniper"))
	{
		self setrankedplayerdata("featureNew","sniper",0);
	}

	var_01 = self.pers["team"];
	var_02 = maps\mp\gametypes\_class::func_3A54(param_00);
	var_03 = maps\mp\gametypes\_class::getweaponchoice(param_00);
	if(var_02 == "restricted")
	{
		beginclasschoice();
	}

	if(isdefined(self.pers["class"]) && self.pers["class"] == var_02 && isdefined(self.pers["primary"]) && self.pers["primary"] == var_03)
	{
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
		self.pers["primary"] = var_03;
		if(game["state"] == "postgame")
		{
		}

		if(level.ingraceperiod && !self.hasdonecombat)
		{
			maps\mp\gametypes\_class::func_7003(self.pers["class"]);
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

		self.pers["class"] = var_02;
		self.class = var_02;
		self.pers["primary"] = var_03;
		if(game["state"] == "postgame")
		{
		}

		if(game["state"] == "playing" && !maps\mp\_utility::func_48E2())
		{
			thread maps\mp\gametypes\_playerlogic::func_7866();
		}
	}

	thread maps\mp\gametypes\_spectating::func_70D0();
}

//Function Number: 19
update_wargame_after_migration()
{
	foreach(var_01 in level.players)
	{
		if(!isai(var_01) && var_01 ishost())
		{
			level.wargame_client = var_01;
		}
	}
}

//Function Number: 20
addtoteam(param_00,param_01,param_02)
{
	if(isdefined(self.team))
	{
		maps\mp\gametypes\_playerlogic::func_6596();
		if(isdefined(param_02) && param_02)
		{
			maps\mp\gametypes\_playerlogic::decrementalivecount(self.team);
		}
	}

	self.pers["team"] = param_00;
	self.team = param_00;
	if(getdvar("squad_vs_squad") == "1")
	{
		if(!isai(self))
		{
			if(param_00 == "allies")
			{
				if(!isdefined(level.squad_vs_squad_allies_client))
				{
					level.squad_vs_squad_allies_client = self;
				}
			}
			else if(param_00 == "axis")
			{
				if(!isdefined(level.squad_vs_squad_axis_client))
				{
					level.squad_vs_squad_axis_client = self;
				}
			}
		}
	}

	if(getdvar("squad_match") == "1")
	{
		if(!isai(self) && self ishost())
		{
			if(!isdefined(level.squad_match_client))
			{
				level.squad_match_client = self;
			}
		}
	}

	if(getdvar("squad_use_hosts_squad") == "1")
	{
		if(!isai(self) && self ishost())
		{
			if(!isdefined(level.wargame_client))
			{
				level.wargame_client = self;
			}
		}
	}

	if(!maps\mp\_utility::func_50C1() || isdefined(self.pers["isBot"]) || !maps\mp\_utility::allowteamchoice())
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

	maps\mp\_utility::func_86FF();
	if(param_00 == "spectator")
	{
		self notify("joined_spectators");
		level notify("joined_team",self);
	}

	self notify("joined_team");
	level notify("joined_team",self);
}

//Function Number: 21
endrespawnnotify()
{
	self.waitingtospawn = 0;
	self notify("end_respawn");
}