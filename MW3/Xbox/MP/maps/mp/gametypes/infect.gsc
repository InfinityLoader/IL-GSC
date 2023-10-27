/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\infect.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 25
 * Decompile Time: 386 ms
 * Timestamp: 10/27/2023 2:26:14 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\mp\gametypes\_globallogic::init();
	maps\mp\gametypes\_callbacksetup::setupcallbacks();
	maps\mp\gametypes\_globallogic::setupcallbacks();
	if(isusingmatchrulesdata())
	{
		level.initializematchrules = ::initializematchrules;
		[[ level.initializematchrules ]]();
		level thread maps\mp\_utility::func_810A();
	}
	else
	{
		maps\mp\_utility::func_3315(level.gametype,10);
		maps\mp\_utility::setoverridewatchdvar("scorelimit",0);
		maps\mp\_utility::func_3312(level.gametype,1);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,1);
		maps\mp\_utility::func_3317(level.gametype,0);
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
		level.matchrules_numinitialinfected = 1;
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	func_34B3();
	level.teambased = 1;
	level.doprematch = 1;
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.onspawnplayer = ::onspawnplayer;
	level.getspawnpoint = ::getspawnpoint;
	level.onplayerkilled = ::onplayerkilled;
	level.ondeadevent = ::ondeadevent;
	level.ontimelimit = ::ontimelimit;
	level.infect_perks = [];
	level.infect_perks[level.infect_perks.size] = "specialty_longersprint";
	level.infect_perks[level.infect_perks.size] = "specialty_fastreload";
	level.infect_perks[level.infect_perks.size] = "specialty_scavenger";
	level.infect_perks[level.infect_perks.size] = "specialty_blindeye";
	level.infect_perks[level.infect_perks.size] = "specialty_paint";
	level.infect_perks[level.infect_perks.size] = "specialty_hardline";
	level.infect_perks[level.infect_perks.size] = "specialty_coldblooded";
	level.infect_perks[level.infect_perks.size] = "specialty_quickdraw";
	level.infect_perks[level.infect_perks.size] = "_specialty_blastshield";
	level.infect_perks[level.infect_perks.size] = "specialty_detectexplosive";
	level.infect_perks[level.infect_perks.size] = "specialty_autospot";
	level.infect_perks[level.infect_perks.size] = "specialty_bulletaccuracy";
	level.infect_perks[level.infect_perks.size] = "specialty_quieter";
	level.infect_perks[level.infect_perks.size] = "specialty_stalker";
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::func_2D57;
	}
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::func_334C();
	level.matchrules_numinitialinfected = getmatchrulesdata("infectData","numInitialInfected");
	setdynamicdvar("scr_" + level.gametype + "_numLives",0);
	maps\mp\_utility::func_3317(level.gametype,0);
	maps\mp\_utility::setoverridewatchdvar("scorelimit",0);
	setdynamicdvar("scr_infect_roundswitch",0);
	maps\mp\_utility::func_330E("infect",0,0,9);
	setdynamicdvar("scr_infect_roundlimit",1);
	maps\mp\_utility::func_3312("infect",1);
	setdynamicdvar("scr_infect_winlimit",1);
	maps\mp\_utility::registerwinlimitdvar("infect",1);
	setdynamicdvar("scr_infect_halftime",0);
	maps\mp\_utility::registerhalftimedvar("infect",0);
	setdynamicdvar("scr_infect_playerrespawndelay",0);
	setdynamicdvar("scr_infect_waverespawndelay",0);
	setdynamicdvar("scr_player_forcerespawn",1);
	setdynamicdvar("scr_team_fftype",0);
	setdynamicdvar("scr_infect_promode",0);
}

//Function Number: 3
onprecachegametype()
{
	precachestring(&"MP_CONSCRIPTION_STARTS_IN");
}

//Function Number: 4
onstartgametype()
{
	setclientnamemode("auto_change");
	maps\mp\_utility::func_3305("allies",&"OBJECTIVES_INFECT");
	maps\mp\_utility::func_3305("axis",&"OBJECTIVES_INFECT");
	if(level.splitscreen)
	{
		maps\mp\_utility::func_3306("allies",&"OBJECTIVES_INFECT");
		maps\mp\_utility::func_3306("axis",&"OBJECTIVES_INFECT");
	}
	else
	{
		maps\mp\_utility::func_3306("allies",&"OBJECTIVES_INFECT_SCORE");
		maps\mp\_utility::func_3306("axis",&"OBJECTIVES_INFECT_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_INFECT_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_INFECT_HINT");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::func_2FD0("allies","mp_tdm_spawn");
	maps\mp\gametypes\_spawnlogic::func_2FD0("axis","mp_tdm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::func_2FCD(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	var_00 = [];
	maps\mp\gametypes\_gameobjects::main(var_00);
	if(maps\mp\_utility::matchmakinggame())
	{
		maps\mp\gametypes\_equipment::createkilltriggers();
	}

	maps\mp\gametypes\_rank::registerscoreinfo("firstblood",0);
	maps\mp\gametypes\_rank::registerscoreinfo("first_draft",350);
	maps\mp\gametypes\_rank::registerscoreinfo("final_rogue",200);
	maps\mp\gametypes\_rank::registerscoreinfo("kill",50);
	maps\mp\gametypes\_rank::registerscoreinfo("draft_rogue",200);
	maps\mp\gametypes\_rank::registerscoreinfo("survivor",50);
	level.quickmessagetoall = 1;
	level.blockweapondrops = 1;
	level.infect_allowsuicide = 0;
	level.infect_timerdisplay = maps\mp\gametypes\_hud_util::createservertimer("objective",1.4);
	level.infect_timerdisplay maps\mp\gametypes\_hud_util::setpoint("TOPLEFT","TOPLEFT",115,5);
	level.infect_timerdisplay.label = &"MP_DRAFT_STARTS_IN";
	level.infect_timerdisplay.alpha = 0;
	level.infect_timerdisplay.archived = 0;
	level.infect_timerdisplay.hidewheninmenu = 1;
	level.infect_chosefirstinfected = 0;
	level.infect_choosingfirstinfected = 0;
	level.infect_awardedfinalsurvivor = 0;
	level.infect_teamscores["axis"] = 0;
	level.infect_teamscores["allies"] = 0;
	level.infect_players = [];
	level thread onplayerconnect();
	level thread watchinfectforfeit();
}

//Function Number: 5
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.infect_firstspawn = 1;
		if(maps\mp\_utility::gameflag("prematch_done"))
		{
			var_00.infect_joinedatstart = 0;
		}
		else
		{
			var_00.infect_joinedatstart = 1;
		}

		if(isdefined(level.infect_players[var_00.name]))
		{
			var_00.infect_rejoined = 1;
		}
	}
}

//Function Number: 6
getspawnpoint()
{
	if(self.infect_firstspawn)
	{
		self.infect_firstspawn = 0;
		self.pers["class"] = "gamemode";
		self.pers["lastClass"] = "";
		self.class = self.pers["class"];
		self.lastclass = self.pers["lastClass"];
		if(isdefined(self.infect_rejoined))
		{
			maps\mp\gametypes\_menus::func_2AF3("axis",1);
		}
		else
		{
			maps\mp\gametypes\_menus::func_2AF3("allies",1);
		}

		thread func_29A7();
	}

	if(level.ingraceperiod)
	{
		var_00 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_tdm_spawn");
		var_01 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(var_00);
	}
	else
	{
		var_00 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(self.pers["team"]);
		var_01 = maps\mp\gametypes\_spawnlogic::func_2FE6(var_01);
	}

	return var_01;
}

//Function Number: 7
onspawnplayer()
{
	self.teamchangedthisframe = undefined;
	self.infect_spawnpos = self.origin;
	func_3555();
	if(!level.infect_choosingfirstinfected)
	{
		level.infect_choosingfirstinfected = 1;
		level thread choosefirstinfected();
	}

	if(isdefined(self.infect_rejoined))
	{
		self.infect_rejoined = undefined;
		if(!level.infect_allowsuicide)
		{
			level notify("infect_stopCountdown");
			level.infect_chosefirstinfected = 1;
			level.infect_allowsuicide = 1;
			foreach(var_01 in level.players)
			{
				if(isdefined(var_01.infect_isbeingchosen))
				{
					var_01.infect_isbeingchosen = undefined;
				}
			}
		}

		foreach(var_01 in level.players)
		{
			if(isdefined(var_01.isinitialinfected))
			{
				var_01 thread setinitialtonormalinfected();
			}
		}

		if(level.infect_teamscores["axis"] == 1)
		{
			self.isinitialinfected = 1;
		}
	}

	if(isdefined(self.isinitialinfected))
	{
		self.pers["gamemodeLoadout"] = level.infect_loadouts["axis_initial"];
	}
	else
	{
		self.pers["gamemodeLoadout"] = level.infect_loadouts[self.pers["team"]];
	}

	thread onspawnfinished();
	level notify("spawned_player");
}

//Function Number: 8
onspawnfinished()
{
	self endon("death");
	self endon("disconnect");
	self waittill("spawned_player");
	if(self.pers["team"] == "axis")
	{
		thread setinfectedmsg();
	}

	wait 0.05;
	if(self.pers["team"] == "axis")
	{
		maps\mp\killstreaks\_killstreaks::func_2DD6();
	}

	if(maps\mp\_utility::matchmakinggame())
	{
		foreach(var_01 in level.infect_perks)
		{
			if(maps\mp\_utility::func_27AF(var_01))
			{
				var_02 = tablelookup("mp/perktable.csv",1,var_01,8);
				if(!maps\mp\_utility::func_27AF(var_02))
				{
					maps\mp\_utility::giveperk(var_02,0);
				}
			}
		}

		if(self.pers["team"] == "allies")
		{
			if(!maps\mp\_utility::func_27AF("specialty_scavenger"))
			{
				maps\mp\_utility::giveperk("specialty_scavenger",0);
				var_02 = tablelookup("mp/perktable.csv",1,"specialty_scavenger",8);
				if(!maps\mp\_utility::func_27AF(var_02))
				{
					maps\mp\_utility::giveperk(var_02,0);
					return;
				}

				return;
			}

			return;
		}

		if(self.pers["team"] == "axis")
		{
			if(isdefined(self.isinitialinfected) && !maps\mp\_utility::func_27AF("specialty_longersprint"))
			{
				maps\mp\_utility::giveperk("specialty_longersprint",0);
				var_02 = tablelookup("mp/perktable.csv",1,"specialty_longersprint",8);
				if(!maps\mp\_utility::func_27AF(var_02))
				{
					maps\mp\_utility::giveperk(var_02,0);
				}
			}

			if(!maps\mp\_utility::func_27AF("specialty_falldamage"))
			{
				maps\mp\_utility::giveperk("specialty_falldamage",0);
			}

			if(maps\mp\_utility::func_27AF("specialty_longersprint"))
			{
				maps\mp\_utility::giveperk("specialty_lightweight",0);
				self setmovespeedscale(1.2);
				return;
			}

			return;
		}
	}
}

//Function Number: 9
setinfectedmsg()
{
	if(isdefined(self.isinitialinfected))
	{
		thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_FIRST_MERCENARY",(1,0,0),0.3);
		return;
	}

	if(isdefined(self.changingtoregularinfected))
	{
		self.changingtoregularinfected = undefined;
		if(isdefined(self.changingtoregularinfectedbykill))
		{
			self.changingtoregularinfectedbykill = undefined;
			thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_FIRSTBLOOD");
			maps\mp\gametypes\_gamescore::func_26D3("first_draft",self);
			thread maps\mp\gametypes\_rank::func_2AB3("first_draft");
			return;
		}

		return;
	}

	thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_DRAFTED",(1,0,0),0.3);
}

//Function Number: 10
choosefirstinfected()
{
	level endon("game_ended");
	level endon("infect_stopCountdown");
	level.infect_allowsuicide = 0;
	maps\mp\_utility::func_274B("prematch_done");
	level.infect_timerdisplay.label = &"MP_DRAFT_STARTS_IN";
	level.infect_timerdisplay settimer(8);
	level.infect_timerdisplay.alpha = 1;
	maps\mp\gametypes\_hostmigration::func_2740(8);
	level.infect_timerdisplay.alpha = 0;
	level.players[randomint(level.players.size)] setfirstinfected(1);
}

//Function Number: 11
setfirstinfected(param_00)
{
	self endon("disconnect");
	if(param_00)
	{
		self.infect_isbeingchosen = 1;
	}

	while(!maps\mp\_utility::isreallyalive(self) || maps\mp\_utility::isusingremote())
	{
		wait 0.05;
	}

	if(isdefined(self.iscarrying) && self.iscarrying == 1)
	{
		self notify("force_cancel_placement");
		wait 0.05;
	}

	while(self ismantling())
	{
		wait 0.05;
	}

	while(!self isonground() && !self isonladder())
	{
		wait 0.05;
	}

	if(maps\mp\_utility::isjuggernaut())
	{
		self notify("lost_juggernaut");
		wait 0.05;
	}

	if(param_00)
	{
		maps\mp\gametypes\_menus::func_2AF3("axis");
		level.infect_chosefirstinfected = 1;
		self.infect_isbeingchosen = undefined;
		func_3555();
		level.infect_allowsuicide = 1;
	}

	self.isinitialinfected = 1;
	self.pers["gamemodeLoadout"] = level.infect_loadouts["axis_initial"];
	if(isdefined(self.setspawnpoint))
	{
		maps\mp\perks\_perkfunctions::func_2A63(self.setspawnpoint);
	}

	var_01 = spawn("script_model",self.origin);
	var_01.angles = self.angles;
	var_01.playerspawnpos = self.origin;
	var_01.notti = 1;
	self.setspawnpoint = var_01;
	self notify("faux_spawn");
	self.faux_spawn_stance = self getstance();
	thread maps\mp\gametypes\_playerlogic::func_2B25(1);
	if(param_00)
	{
		level.infect_players[self.name] = 1;
	}

	thread maps\mp\_utility::teamplayercardsplash("callout_first_mercenary",self);
	maps\mp\_utility::func_2D68("mp_enemy_obj_captured");
}

//Function Number: 12
setinitialtonormalinfected(param_00)
{
	level endon("game_ended");
	self.isinitialinfected = undefined;
	self.changingtoregularinfected = 1;
	if(isdefined(param_00))
	{
		self.changingtoregularinfectedbykill = 1;
	}

	while(!maps\mp\_utility::isreallyalive(self))
	{
		wait 0.05;
	}

	if(isdefined(self.iscarrying) && self.iscarrying == 1)
	{
		self notify("force_cancel_placement");
		wait 0.05;
	}

	while(self ismantling())
	{
		wait 0.05;
	}

	while(!self isonground())
	{
		wait 0.05;
	}

	if(maps\mp\_utility::isjuggernaut())
	{
		self notify("lost_juggernaut");
		wait 0.05;
	}

	while(!maps\mp\_utility::isreallyalive(self))
	{
		wait 0.05;
	}

	self.pers["gamemodeLoadout"] = level.infect_loadouts["axis"];
	if(isdefined(self.setspawnpoint))
	{
		maps\mp\perks\_perkfunctions::func_2A63(self.setspawnpoint);
	}

	var_01 = spawn("script_model",self.origin);
	var_01.angles = self.angles;
	var_01.playerspawnpos = self.origin;
	var_01.notti = 1;
	self.setspawnpoint = var_01;
	self notify("faux_spawn");
	self.faux_spawn_stance = self getstance();
	thread maps\mp\gametypes\_playerlogic::func_2B25(1);
}

//Function Number: 13
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = 0;
	var_0B = 0;
	if(self.team == "allies" && isdefined(param_01))
	{
		if(isplayer(param_01) && param_01 != self)
		{
			var_0A = 1;
		}
		else if(level.infect_allowsuicide && param_01 == self || !isplayer(param_01))
		{
			var_0A = 1;
			var_0B = 1;
		}
	}

	if(var_0A)
	{
		self.teamchangedthisframe = 1;
		maps\mp\gametypes\_menus::func_2AF3("axis");
		func_3555();
		level.infect_players[self.name] = 1;
		if(var_0B)
		{
			if(level.infect_teamscores["axis"] > 1)
			{
				foreach(var_0D in level.players)
				{
					if(isdefined(var_0D.isinitialinfected))
					{
						var_0D thread setinitialtonormalinfected();
					}
				}
			}
		}
		else if(isdefined(param_01.isinitialinfected))
		{
			param_01 thread setinitialtonormalinfected(1);
		}
		else
		{
			param_01 thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_DRAFTED");
			maps\mp\gametypes\_gamescore::func_26D3("draft_rogue",param_01,self,1);
			param_01 thread maps\mp\gametypes\_rank::func_2AB3("draft_rogue");
		}

		if(level.infect_teamscores["allies"] > 1)
		{
			maps\mp\_utility::func_2D68("mp_enemy_obj_captured","allies");
			maps\mp\_utility::func_2D68("mp_war_objective_taken","axis");
			thread maps\mp\_utility::teamplayercardsplash("callout_got_drafted",self,"allies");
			if(!var_0B)
			{
				thread maps\mp\_utility::teamplayercardsplash("callout_drafted_rogue",param_01,"axis");
				foreach(var_0D in level.players)
				{
					if(var_0D.team == "allies" && var_0D != self && distance(var_0D.infect_spawnpos,var_0D.origin) > 32)
					{
						var_0D thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_SURVIVOR");
						maps\mp\gametypes\_gamescore::func_26D3("survivor",var_0D,undefined,1);
						var_0D thread maps\mp\gametypes\_rank::func_2AB3("survivor");
					}
				}

				return;
			}

			return;
		}

		if(level.infect_teamscores["allies"] == 1)
		{
			onfinalsurvivor();
			return;
		}

		if(level.infect_teamscores["allies"] == 0)
		{
			onsurvivorseliminated();
			return;
		}

		return;
	}
}

//Function Number: 14
onfinalsurvivor()
{
	maps\mp\_utility::func_2D68("mp_obj_captured");
	foreach(var_01 in level.players)
	{
		if(var_01.team == "allies")
		{
			var_01 thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_FINAL_ROGUE");
			if(!level.infect_awardedfinalsurvivor)
			{
				if(var_01.infect_joinedatstart && distance(var_01.infect_spawnpos,var_01.origin) > 32)
				{
					maps\mp\gametypes\_gamescore::func_26D3("final_rogue",var_01,undefined,1);
					var_01 thread maps\mp\gametypes\_rank::func_2AB3("final_rogue");
				}

				level.infect_awardedfinalsurvivor = 1;
			}

			thread maps\mp\_utility::teamplayercardsplash("callout_final_rogue",var_01);
			if(maps\mp\_utility::matchmakinggame() && !var_01 maps\mp\_utility::isjuggernaut())
			{
				level thread finalsurvivoruav(var_01);
			}

			break;
		}
	}
}

//Function Number: 15
finalsurvivoruav(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("eliminated");
	level endon("infect_lateJoiner");
	level thread enduavonlatejoiner(param_00);
	var_01 = 0;
	level.radarmode["axis"] = "normal_radar";
	foreach(var_03 in level.players)
	{
		if(var_03.team == "axis")
		{
			var_03.radarmode = "normal_radar";
		}
	}

	setteamradarstrength("axis",1);
	for(;;)
	{
		var_05 = param_00.origin;
		wait 4;
		if(var_01)
		{
			setteamradar("axis",0);
			var_01 = 0;
		}

		wait 6;
		if(distance(var_05,param_00.origin) < 200)
		{
			setteamradar("axis",1);
			var_01 = 1;
			foreach(var_03 in level.players)
			{
				var_03 playlocalsound("recondrone_tag");
			}
		}
	}
}

//Function Number: 16
enduavonlatejoiner(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("eliminated");
	for(;;)
	{
		if(level.infect_teamscores["allies"] > 1)
		{
			level notify("infect_lateJoiner");
			wait 0.05;
			setteamradar("axis",0);
			break;
		}

		wait 0.05;
	}
}

//Function Number: 17
func_29A7()
{
	level endon("game_ended");
	self endon("eliminated");
	self waittill("disconnect");
	func_3555();
	if(isdefined(self.infect_isbeingchosen) || level.infect_chosefirstinfected)
	{
		if(level.infect_teamscores["axis"] && level.infect_teamscores["allies"])
		{
			if(self.team == "allies" && level.infect_teamscores["allies"] == 1)
			{
				onfinalsurvivor();
			}
			else if(self.team == "axis" && level.infect_teamscores["axis"] == 1)
			{
				foreach(var_01 in level.players)
				{
					if(var_01 != self && var_01.team == "axis")
					{
						var_01 setfirstinfected(0);
					}
				}
			}
		}
		else if(level.infect_teamscores["allies"] == 0)
		{
			onsurvivorseliminated();
		}
		else if(level.infect_teamscores["axis"] == 0)
		{
			if(level.infect_teamscores["allies"] == 1)
			{
				level.finalkillcam_winner = "allies";
				level thread maps\mp\gametypes\_gamelogic::endgame("allies",game["strings"]["axis_eliminated"]);
			}
			else if(level.infect_teamscores["allies"] > 1)
			{
				level.infect_chosefirstinfected = 0;
				level thread choosefirstinfected();
			}
		}
	}

	self.isinitialinfected = undefined;
}

//Function Number: 18
watchinfectforfeit()
{
	level endon("game_ended");
	level.forfeitinprogress = 1;
	for(;;)
	{
		if(!isdefined(level.forfeitinprogress))
		{
			level.forfeitinprogress = 1;
		}

		wait 0.05;
	}
}

//Function Number: 19
ondeadevent(param_00)
{
}

//Function Number: 20
ontimelimit()
{
	level.finalkillcam_winner = "allies";
	level thread maps\mp\gametypes\_gamelogic::endgame("allies",game["strings"]["time_limit_reached"]);
}

//Function Number: 21
onsurvivorseliminated()
{
	level.finalkillcam_winner = "axis";
	level thread maps\mp\gametypes\_gamelogic::endgame("axis",game["strings"]["allies_eliminated"]);
}

//Function Number: 22
getnumaxis()
{
	var_00 = 0;
	foreach(var_02 in level.players)
	{
		if(isdefined(var_02.team) && var_02.team == "axis")
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 23
getnumallies()
{
	var_00 = 0;
	foreach(var_02 in level.players)
	{
		if(isdefined(var_02.team) && var_02.team == "allies")
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 24
func_3555()
{
	level.infect_teamscores["axis"] = getnumaxis();
	level.infect_teamscores["allies"] = getnumallies();
	game["teamScores"]["axis"] = level.infect_teamscores["axis"];
	setteamscore("axis",level.infect_teamscores["axis"]);
	game["teamScores"]["allies"] = level.infect_teamscores["allies"];
	setteamscore("allies",level.infect_teamscores["allies"]);
}

//Function Number: 25
func_34B3()
{
	if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses","axis",0,"class","inUse"))
	{
		level.infect_loadouts["axis"] = maps\mp\_utility::func_334E("axis",0);
		level.infect_loadouts["axis"]["loadoutStreakType"] = "assault";
		level.infect_loadouts["axis"]["loadoutKillstreak1"] = "none";
		level.infect_loadouts["axis"]["loadoutKillstreak2"] = "none";
		level.infect_loadouts["axis"]["loadoutKillstreak3"] = "none";
	}
	else
	{
		level.infect_loadouts["axis"]["loadoutPrimary"] = "iw5_fmg9";
		level.infect_loadouts["axis"]["loadoutPrimaryAttachment"] = "reflex";
		level.infect_loadouts["axis"]["loadoutPrimaryAttachment2"] = "none";
		level.infect_loadouts["axis"]["loadoutPrimaryBuff"] = "specialty_null";
		level.infect_loadouts["axis"]["loadoutPrimaryCamo"] = "none";
		level.infect_loadouts["axis"]["loadoutPrimaryReticle"] = "none";
		level.infect_loadouts["axis"]["loadoutSecondary"] = "none";
		level.infect_loadouts["axis"]["loadoutSecondaryAttachment"] = "none";
		level.infect_loadouts["axis"]["loadoutSecondaryAttachment2"] = "none";
		level.infect_loadouts["axis"]["loadoutSecondaryBuff"] = "specialty_null";
		level.infect_loadouts["axis"]["loadoutSecondaryCamo"] = "none";
		level.infect_loadouts["axis"]["loadoutSecondaryReticle"] = "none";
		level.infect_loadouts["axis"]["loadoutEquipment"] = "throwingknife_mp";
		level.infect_loadouts["axis"]["loadoutOffhand"] = "none";
		level.infect_loadouts["axis"]["loadoutPerk1"] = "specialty_longersprint";
		level.infect_loadouts["axis"]["loadoutPerk2"] = "specialty_quickdraw";
		level.infect_loadouts["axis"]["loadoutPerk3"] = "specialty_quieter";
		level.infect_loadouts["axis"]["loadoutStreakType"] = "assault";
		level.infect_loadouts["axis"]["loadoutKillstreak1"] = "none";
		level.infect_loadouts["axis"]["loadoutKillstreak2"] = "none";
		level.infect_loadouts["axis"]["loadoutKillstreak3"] = "none";
		level.infect_loadouts["axis"]["loadoutDeathstreak"] = "specialty_grenadepulldeath";
		level.infect_loadouts["axis"]["loadoutJuggernaut"] = 0;
	}

	if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses","axis",5,"class","inUse"))
	{
		level.infect_loadouts["axis_initial"] = maps\mp\_utility::func_334E("axis",5);
		level.infect_loadouts["axis_initial"]["loadoutStreakType"] = "assault";
		level.infect_loadouts["axis_initial"]["loadoutKillstreak1"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutKillstreak2"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutKillstreak3"] = "none";
	}
	else
	{
		level.infect_loadouts["axis_initial"]["loadoutPrimary"] = "iw5_scar";
		level.infect_loadouts["axis_initial"]["loadoutPrimaryAttachment"] = "reflex";
		level.infect_loadouts["axis_initial"]["loadoutPrimaryAttachment2"] = "xmags";
		level.infect_loadouts["axis_initial"]["loadoutPrimaryBuff"] = "specialty_bling";
		level.infect_loadouts["axis_initial"]["loadoutPrimaryCamo"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutPrimaryReticle"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutSecondary"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutSecondaryAttachment"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutSecondaryAttachment2"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutSecondaryBuff"] = "specialty_null";
		level.infect_loadouts["axis_initial"]["loadoutSecondaryCamo"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutSecondaryReticle"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutEquipment"] = "specialty_null";
		level.infect_loadouts["axis_initial"]["loadoutOffhand"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutPerk1"] = "specialty_longersprint";
		level.infect_loadouts["axis_initial"]["loadoutPerk2"] = "specialty_quickdraw";
		level.infect_loadouts["axis_initial"]["loadoutPerk3"] = "specialty_bulletaccuracy";
		level.infect_loadouts["axis_initial"]["loadoutStreakType"] = "assault";
		level.infect_loadouts["axis_initial"]["loadoutKillstreak1"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutKillstreak2"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutKillstreak3"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutDeathstreak"] = "specialty_grenadepulldeath";
		level.infect_loadouts["axis_initial"]["loadoutJuggernaut"] = 0;
	}

	if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses","allies",0,"class","inUse"))
	{
		level.infect_loadouts["allies"] = maps\mp\_utility::func_334E("allies",0);
		return;
	}

	level.infect_loadouts["allies"]["loadoutPrimary"] = "iw5_spas12";
	level.infect_loadouts["allies"]["loadoutPrimaryAttachment"] = "silencer03";
	level.infect_loadouts["allies"]["loadoutPrimaryAttachment2"] = "none";
	level.infect_loadouts["allies"]["loadoutPrimaryBuff"] = "specialty_longerrange";
	level.infect_loadouts["allies"]["loadoutPrimaryCamo"] = "none";
	level.infect_loadouts["allies"]["loadoutPrimaryReticle"] = "none";
	level.infect_loadouts["allies"]["loadoutSecondary"] = "none";
	level.infect_loadouts["allies"]["loadoutSecondaryAttachment"] = "none";
	level.infect_loadouts["allies"]["loadoutSecondaryAttachment2"] = "none";
	level.infect_loadouts["allies"]["loadoutSecondaryBuff"] = "specialty_null";
	level.infect_loadouts["allies"]["loadoutSecondaryCamo"] = "none";
	level.infect_loadouts["allies"]["loadoutSecondaryReticle"] = "none";
	level.infect_loadouts["allies"]["loadoutEquipment"] = "claymore_mp";
	level.infect_loadouts["allies"]["loadoutOffhand"] = "flash_grenade_mp";
	level.infect_loadouts["allies"]["loadoutPerk1"] = "specialty_scavenger";
	level.infect_loadouts["allies"]["loadoutPerk2"] = "specialty_quickdraw";
	level.infect_loadouts["allies"]["loadoutPerk3"] = "specialty_quieter";
	level.infect_loadouts["allies"]["loadoutDeathstreak"] = "specialty_null";
	level.infect_loadouts["allies"]["loadoutJuggernaut"] = 0;
}