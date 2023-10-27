/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_menus.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 1101 ms
 * Timestamp: 10/27/2023 12:20:53 AM
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

		if(scripts\mp\_utility::func_2DD9())
		{
			level.var_6D8F = "class_commander_" + level.gametype;
			game["menu_class"] = level.var_6D8F;
			game["menu_class_allies"] = level.var_6D8F;
			game["menu_class_axis"] = level.var_6D8F;
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
			}
		}

		precachestring(&"MP_HOST_ENDED_GAME");
		precachestring(&"MP_HOST_ENDGAME_RESPONSE");
	}

	level thread func_C56E();
	level thread watchforbootmoviecomplete();
	level thread setintrocamnetworkmodel();
}

//Function Number: 2
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_13A32();
		var_00 thread func_13A72();
		var_00 thread func_13A4A();
		var_00 thread func_13A67();
	}
}

//Function Number: 3
setintrocamnetworkmodel()
{
	function_031D(1);
	level waittill("prematch_over");
	function_031D(0);
}

//Function Number: 4
watchforbootmoviecomplete()
{
	self endon("disconnect");
	level endon("game_ended");
	var_00 = 0;
	for(;;)
	{
		level waittill("rigBootFinished");
		var_00++;
		if(level.var_4533 <= var_00)
		{
			level notify("allRigsBooted");
			break;
		}
	}
}

//Function Number: 5
func_7E2A(param_00)
{
	var_01 = undefined;
	if(param_00 > 100)
	{
		var_02 = param_00 - 100;
		var_01 = "default" + var_02;
	}
	else
	{
		var_01 = "custom" + param_00;
	}

	return var_01;
}

//Function Number: 6
func_D848(param_00)
{
	var_01 = spawnstruct();
	scripts\mp\_playerlogic::func_806C(var_01,param_00);
	scripts\mp\_playerlogic::func_AEAD(var_01);
}

//Function Number: 7
func_13A32()
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

		if(isdefined(self.var_136FE) && self.var_136FE)
		{
			continue;
		}

		if(!scripts\mp\_utility::func_1C7D() || scripts\mp\_utility::func_10125())
		{
			continue;
		}

		if("" + var_01 != "callback")
		{
			if(isdefined(self.pers["isBot"]) && self.pers["isBot"])
			{
				self.pers["class"] = var_01;
				self.var_4004 = var_01;
			}
			else
			{
				var_03 = var_01 + 1;
				var_03 = func_7E2A(var_03);
				if(!isdefined(self.pers["class"]) || var_03 == self.pers["class"])
				{
					continue;
				}

				self.pers["class"] = var_03;
				self.var_4004 = var_03;
				func_D848(var_03);
				if(scripts\mp\_class::func_FFBB())
				{
					scripts\mp\_class::func_837A();
				}
				else if(isalive(self))
				{
					self iprintlnbold(game["strings"]["change_class"]);
				}
			}

			continue;
		}

		func_B670("callback");
	}
}

//Function Number: 8
func_13A4A()
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

		level thread scripts\mp\_gamelogic::func_72BE(var_01);
	}
}

//Function Number: 9
func_13A72()
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

		if(scripts\mp\_utility::func_B3EC())
		{
			continue;
		}

		var_02 = 0;
		if(var_01 >= 3)
		{
			var_02 = 1;
		}

		if(var_02)
		{
			self setclientomnvar("ui_spectator_selected",1);
			self setclientomnvar("ui_loadout_selected",-1);
			self.var_1097B = 1;
		}
		else
		{
			self setclientomnvar("ui_spectator_selected",-1);
			self.var_1097B = 0;
		}

		var_03 = self ismlgspectator();
		var_04 = !var_03 && isdefined(self.team) && self.team == "spectator";
		var_05 = (var_03 && var_01 == 3) || var_04 && var_01 == 4;
		if(var_01 == 4)
		{
			var_01 = 3;
			self method_830E(1);
		}
		else
		{
			self method_830E(0);
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

		if(!var_05 && isdefined(self.pers["team"]) && var_01 == self.pers["team"])
		{
			continue;
		}

		self setclientomnvar("ui_loadout_selected",-1);
		thread func_AFDB(var_01);
		if(var_01 == "axis")
		{
			thread func_F876("axis");
			continue;
		}

		if(var_01 == "allies")
		{
			thread func_F876("allies");
			continue;
		}

		if(var_01 == "random")
		{
			thread func_2642();
			continue;
		}

		if(var_01 == "spectator")
		{
			thread func_F859(var_05);
		}
	}
}

//Function Number: 10
func_2642()
{
	if(level.gametype == "infect")
	{
		thread func_F876("allies");
		return;
	}

	if(function_0280() && isdefined(self.var_2EAC))
	{
		thread func_F876(self.var_2EAC);
		return;
	}

	if(!isdefined(self.team))
	{
		if(self ismlgspectator())
		{
			thread func_F859();
		}
		else if(level.var_115C6["axis"] < level.var_115C6["allies"])
		{
			thread func_F876("axis");
		}
		else if(level.var_115C6["allies"] < level.var_115C6["axis"])
		{
			thread func_F876("allies");
		}
		else if(getteamscore("allies") > getteamscore("axis"))
		{
			thread func_F876("axis");
		}
		else
		{
			thread func_F876("allies");
		}

		return;
	}

	if(self ismlgspectator())
	{
		thread func_F859();
		return;
	}

	if(level.var_115C6["axis"] < level.var_115C6["allies"] && self.team != "axis")
	{
		thread func_F876("axis");
		return;
	}

	if(level.var_115C6["allies"] < level.var_115C6["axis"] && self.team != "allies")
	{
		thread func_F876("allies");
		return;
	}

	if(level.var_115C6["allies"] == level.var_115C6["axis"])
	{
		if(getteamscore("allies") > getteamscore("axis") && self.team != "axis")
		{
			thread func_F876("axis");
			return;
		}

		if(self.team != "allies")
		{
			thread func_F876("allies");
			return;
		}

		return;
	}
}

//Function Number: 11
func_F876(param_00)
{
	self endon("disconnect");
	if(!isai(self) && level.teambased && !scripts\mp\_teams::func_7F24(param_00) && !scripts\mp\_utility::func_AEB6())
	{
		return;
	}

	if(level.ingraceperiod && !self.var_8BE9)
	{
		self.var_8C2A = 0;
		self.pers["lives"] = scripts\mp\_utility::func_7ECE();
	}

	if(self.sessionstate == "playing")
	{
		self.var_11377 = 1;
		self.var_A49E = param_00;
		self.var_AB33 = self.pers["team"];
	}

	func_185F(param_00);
	if(scripts\mp\_utility::func_9F13())
	{
		self method_859D(1);
	}

	if(self.sessionstate == "playing")
	{
		self suicide();
	}

	func_136B1();
	func_637D();
	if(self.sessionstate == "spectator")
	{
		if(game["state"] == "postgame")
		{
			return;
		}

		if(game["state"] == "playing" && !scripts\mp\_utility::func_9E4A())
		{
			if(isdefined(self.var_13700) && self.var_13700)
			{
				return;
			}

			thread scripts\mp\_playerlogic::func_1083A();
		}

		thread scripts\mp\_spectating::func_F857();
	}

	self notify("okToSpawn");
}

//Function Number: 12
func_F859(param_00)
{
	if((!isdefined(param_00) || !param_00) && isdefined(self.pers["team"]) && self.pers["team"] == "spectator")
	{
		return;
	}

	if(isalive(self))
	{
		self.var_11377 = 1;
		self.var_A49E = "spectator";
		self.var_AB33 = self.pers["team"];
		self suicide();
	}

	self notify("becameSpectator");
	func_185F("spectator");
	self.pers["class"] = undefined;
	self.var_4004 = undefined;
	thread scripts\mp\_playerlogic::func_10911();
}

//Function Number: 13
func_136B1()
{
	self endon("disconnect");
	level endon("game_ended");
	self.var_136FE = 1;
	for(;;)
	{
		if(scripts\mp\_utility::func_1C7D() || scripts\mp\_utility::func_10125() && !isai(self))
		{
			if(!self ismlgspectator())
			{
				scripts\mp\_utility::setlowermessage("spawn_info",game["strings"]["must_select_loadout_to_spawn"],undefined,undefined,undefined,undefined,undefined,undefined,1);
			}

			self waittill("luinotifyserver",var_00,var_01);
		}
		else
		{
			func_3327();
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
				self.var_4004 = var_01;
			}
			else
			{
				var_01 = var_01 + 1;
				self.pers["class"] = func_7E2A(var_01);
				self.var_4004 = func_7E2A(var_01);
			}

			self.var_136FE = 0;
		}
		else
		{
			self.var_136FE = 0;
			func_B670("callback");
		}

		break;
	}
}

//Function Number: 14
func_2A61(param_00)
{
	var_01 = self.pers["team"];
	if(scripts\mp\_utility::func_1C7D() || scripts\mp\_utility::func_10125() && !isai(self))
	{
		self setclientomnvar("ui_options_menu",2);
		if(!self ismlgspectator())
		{
			func_136B1();
		}

		func_637D();
		if(self.sessionstate == "spectator")
		{
			if(game["state"] == "postgame")
			{
				return;
			}

			if(game["state"] == "playing" && !scripts\mp\_utility::func_9E4A())
			{
				if(isdefined(self.var_13700) && self.var_13700)
				{
					return;
				}

				thread scripts\mp\_playerlogic::func_1083A();
			}

			thread scripts\mp\_spectating::func_F857();
		}

		self.var_4539 = gettime();
		self notify("okToSpawn");
	}
	else
	{
		thread func_3327();
	}

	if(!isalive(self))
	{
		thread scripts\mp\_playerlogic::func_D81E(0.1);
	}
}

//Function Number: 15
func_3327()
{
	self.var_F1BA = 1;
	self.var_136FE = 0;
	if(!isbot(self) && scripts\mp\_utility::func_DCD5())
	{
		if(level.gametype == "infect" || isdefined(level.var_204B) && level.var_204B > 0)
		{
			scripts\mp\_utility::setlowermessage("spawn_info",game["strings"]["press_to_spawn"],undefined,undefined,undefined,undefined,undefined,undefined,1);
			self notifyonplayercommand("pressToSpawn","+usereload");
			self notifyonplayercommand("pressToSpawn","+activate");
			self waittill("pressToSpawn");
		}
	}

	if(isdefined(level.var_3328))
	{
		var_00 = self [[ level.var_3328 ]]();
		self.var_4004 = var_00;
		return;
	}

	self.var_4004 = "class0";
}

//Function Number: 16
func_2A7A()
{
	self setclientomnvar("ui_options_menu",1);
}

//Function Number: 17
func_B678()
{
	if(isdefined(self.pers["team"]) && self.pers["team"] == "spectator")
	{
		return;
	}

	if(isalive(self))
	{
		self.var_11377 = 1;
		self.var_A49E = "spectator";
		self.var_AB33 = self.pers["team"];
		self suicide();
	}

	func_185F("spectator");
	self.pers["class"] = undefined;
	self.var_4004 = undefined;
	thread scripts\mp\_playerlogic::func_10911();
}

//Function Number: 18
func_B670(param_00)
{
	var_01 = self.pers["team"];
	var_02 = scripts\mp\_class::func_7E2A(param_00);
	var_03 = scripts\mp\_class::func_821E(param_00);
	if(var_02 == "restricted")
	{
		func_2A61();
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
			self.var_A95C = self.pers["lastClass"];
		}

		self.pers["class"] = var_02;
		self.var_4004 = var_02;
		self.pers["primary"] = var_03;
		if(game["state"] == "postgame")
		{
			return;
		}

		if(level.ingraceperiod && !self.var_8BE9)
		{
			scripts\mp\_class::func_F691(self.pers["class"]);
			self.var_322 = undefined;
			self.var_113E7 = undefined;
			scripts\mp\_class::func_8379(self.pers["team"],self.pers["class"]);
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
			self.var_A95C = self.pers["lastClass"];
		}

		self.pers["class"] = var_02;
		self.var_4004 = var_02;
		self.pers["primary"] = var_03;
		if(game["state"] == "postgame")
		{
			return;
		}

		if(game["state"] == "playing" && !scripts\mp\_utility::func_9E4A())
		{
			thread scripts\mp\_playerlogic::func_1083A();
		}
	}

	thread scripts\mp\_spectating::func_F857();
}

//Function Number: 19
func_185F(param_00,param_01,param_02)
{
	if(isdefined(self.team))
	{
		scripts\mp\_playerlogic::func_E11D();
		if(isdefined(param_02) && param_02)
		{
			scripts\mp\_playerlogic::func_4FBD(self.team);
		}
	}

	if(isdefined(self.pers["team"]) && self.pers["team"] != "" && self.pers["team"] != "spectator")
	{
		self.pers["last_team"] = self.pers["team"];
	}

	self.pers["team"] = param_00;
	self.team = param_00;
	if((!scripts\mp\_utility::func_B3EC() || isdefined(self.pers["isBot"]) || !scripts\mp\_utility::func_1CAD()) && !function_0303())
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
		scripts\mp\_playerlogic::func_1860();
		if(isdefined(param_02) && param_02)
		{
			scripts\mp\_playerlogic::func_93F8(self.team);
		}
	}

	if(function_0303())
	{
		setmatchdata("players",self.var_41F0,"team",param_00);
	}

	scripts\mp\_utility::func_12EDC();
	if(isdefined(param_01) && param_01)
	{
		waittillframeend;
	}

	scripts\mp\_utility::func_12EC8();
	if(param_00 == "spectator")
	{
		self notify("joined_spectators");
		level notify("joined_team",self);
		return;
	}

	self notify("joined_team");
	level notify("joined_team",self);
}

//Function Number: 20
func_637D()
{
	self.var_136FF = 0;
	self notify("end_respawn");
}

//Function Number: 21
func_AFDB(param_00)
{
	if(getdvarint("scr_playtest",0) == 0)
	{
		return;
	}

	if(param_00 != "random")
	{
		iprintlnbold("" + self.name + " did not select auto-assign");
	}
}

//Function Number: 22
func_13A67()
{
	thread func_13A69();
	thread func_13A6A();
	thread func_13A6B();
}

//Function Number: 23
func_13A69()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "rig_selected")
		{
			self.var_E535 = spawnstruct();
			self.var_E535.var_26A = var_01;
		}
	}
}

//Function Number: 24
func_13A6A()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "super_selected")
		{
			if(isdefined(self.var_E535))
			{
				self.var_E535.var_11261 = var_01;
				continue;
			}
		}
	}
}

//Function Number: 25
func_13A6B()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "trait_selected")
		{
			if(isdefined(self.var_E535))
			{
				self.var_E535.var_11B2D = var_01;
				if(isdefined(self.var_E535.var_26A) && isdefined(self.var_E535.var_11261))
				{
					var_02 = level.var_2128[self.var_E535.var_26A];
					var_03 = level.var_11264[self.var_E535.var_11261];
					var_04 = level.var_CA5E[self.var_E535.var_11B2D];
					scripts\mp\_class::func_3C53(var_02,var_03,var_04);
				}
				else
				{
				}

				continue;
			}
		}
	}
}