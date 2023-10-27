/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\infect.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 222 ms
 * Timestamp: 10/27/2023 2:13:18 AM
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
		level thread maps\mp\_utility::reinitializematchrulesonmigration();
	}
	else
	{
		maps\mp\_utility::registertimelimitdvar(level.gametype,10);
		maps\mp\_utility::setoverridewatchdvar("scorelimit",0);
		maps\mp\_utility::registerroundlimitdvar(level.gametype,1);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,1);
		maps\mp\_utility::registernumlivesdvar(level.gametype,0);
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
		level.matchrules_numinitialinfected = 1;
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	func_3989();
	level.teambased = 1;
	level.doprematch = 1;
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.onspawnplayer = ::onspawnplayer;
	level.getspawnpoint = ::getspawnpoint;
	level.onplayerkilled = ::onplayerkilled;
	level.ondeadevent = ::ondeadevent;
	level.ontimelimit = ::ontimelimit;
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::setcommonrulesfrommatchrulesdata();
	level.matchrules_numinitialinfected = getmatchrulesdata("infectData","numInitialInfected");
	var_00 = maps\mp\_utility::getwatcheddvar("numlives");
	if(var_00)
	{
		setdynamicdvar("scr_" + level.gametype + "_numLives",var_00 + 1);
		maps\mp\_utility::registernumlivesdvar(level.gametype,var_00 + 1);
	}

	maps\mp\_utility::setoverridewatchdvar("scorelimit",0);
	setdynamicdvar("scr_infect_roundswitch",0);
	maps\mp\_utility::registerroundswitchdvar("infect",0,0,9);
	setdynamicdvar("scr_infect_roundlimit",1);
	maps\mp\_utility::registerroundlimitdvar("infect",1);
	setdynamicdvar("scr_infect_winlimit",1);
	maps\mp\_utility::registerwinlimitdvar("infect",1);
	setdynamicdvar("scr_infect_halftime",0);
	maps\mp\_utility::registerhalftimedvar("infect",0);
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
	maps\mp\_utility::setobjectivetext("allies",&"OBJECTIVES_INFECT");
	maps\mp\_utility::setobjectivetext("axis",&"OBJECTIVES_INFECT");
	if(level.splitscreen)
	{
		maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_INFECT");
		maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_INFECT");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_INFECT_SCORE");
		maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_INFECT_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_INFECT_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_INFECT_HINT");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies","mp_tdm_spawn");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis","mp_tdm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	var_00 = [];
	maps\mp\gametypes\_gameobjects::main(var_00);
	maps\mp\gametypes\_rank::registerscoreinfo("final_rogue",200);
	maps\mp\gametypes\_rank::registerscoreinfo("draft_rogue",100);
	maps\mp\gametypes\_rank::registerscoreinfo("survivor",100);
	level.quickmessagetoall = 1;
	level.blockweapondrops = 1;
	level.infect_timerdisplay = maps\mp\gametypes\_hud_util::createservertimer("objective",1.4);
	level.infect_timerdisplay maps\mp\gametypes\_hud_util::setpoint("TOPLEFT","TOPLEFT",115,5);
	level.infect_timerdisplay.label = &"MP_DRAFT_STARTS_IN";
	level.infect_timerdisplay.alpha = 0;
	level.infect_timerdisplay.archived = 0;
	level.infect_timerdisplay.hidewheninmenu = 1;
	level.infect_chosefirstinfected = 0;
	level.infect_choosingfirstinfected = 0;
	level.infect_teamscores["axis"] = 0;
	level.infect_teamscores["allies"] = 0;
	level thread onplayerconnect();
	level thread onplayereliminated();
}

//Function Number: 5
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.infect_firstspawn = 1;
		var_00 thread ondisconnect();
	}
}

//Function Number: 6
onspawnplayer()
{
	func_3A2B();
	if(!level.infect_choosingfirstinfected)
	{
		level.infect_choosingfirstinfected = 1;
		level thread func_3A28();
	}

	if(isdefined(self.isinitialinfected))
	{
		self.pers["gamemodeLoadout"] = level.infect_loadouts["axis_initial"];
	}
	else
	{
		self.pers["gamemodeLoadout"] = level.infect_loadouts[self.pers["team"]];
	}

	if(self.infect_firstactualspawn)
	{
		self.infect_firstactualspawn = 0;
		level.infect_teamscores["allies"]++;
		func_3A2B();
	}

	level notify("spawned_player");
}

//Function Number: 7
getspawnpoint()
{
	if(self.infect_firstspawn)
	{
		self.infect_firstspawn = 0;
		self.infect_firstactualspawn = 1;
		self.pers["class"] = "gamemode";
		self.pers["lastClass"] = "";
		self.class = self.pers["class"];
		self.lastclass = self.pers["lastClass"];
		maps\mp\gametypes\_menus::addtoteam("allies",1);
	}

	if(level.ingraceperiod)
	{
		var_00 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_tdm_spawn");
		var_01 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(var_00);
	}
	else
	{
		var_00 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(self.pers["team"]);
		var_01 = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(var_01);
	}

	return var_01;
}

//Function Number: 8
func_3A28()
{
	level endon("game_ended");
	maps\mp\_utility::gameflagwait("prematch_done");
	level.infect_timerdisplay.label = &"MP_DRAFT_STARTS_IN";
	level.infect_timerdisplay settimer(8);
	level.infect_timerdisplay.alpha = 1;
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(8);
	level.infect_timerdisplay.alpha = 0;
	var_00 = level.players[randomint(level.players.size)];
	var_00.infect_isbeingchosen = 1;
	var_00 endon("disconnect");
	while(!maps\mp\_utility::isreallyalive(var_00) || var_00 maps\mp\_utility::isusingremote())
	{
		wait 0.05;
	}

	if(isdefined(var_00.iscarrying) && var_00.iscarrying == 1)
	{
		var_00 notify("force_cancel_placement");
		wait 0.05;
	}

	if(var_00 maps\mp\_utility::isjuggernaut())
	{
		var_00 notify("lost_juggernaut");
		wait 0.05;
	}

	var_00 maps\mp\gametypes\_playerlogic::removefromalivecount();
	var_00 maps\mp\gametypes\_menus::addtoteam("axis");
	level.infect_chosefirstinfected = 1;
	var_00.infect_isbeingchosen = undefined;
	var_00.isinitialinfected = 1;
	level.infect_teamscores["allies"]--;
	level.infect_teamscores["axis"]++;
	func_3A2B();
	var_01 = maps\mp\_utility::getwatcheddvar("numlives");
	if(var_01 && var_00.pers["lives"])
	{
		var_00.pers["lives"]--;
	}

	var_00 maps\mp\gametypes\_playerlogic::addtoalivecount();
	var_00.pers["gamemodeLoadout"] = level.infect_loadouts["axis_initial"];
	var_02 = spawn("script_model",var_00.origin);
	var_02.angles = var_00.angles;
	var_02.playerspawnpos = var_00.origin;
	var_02.notti = 1;
	var_00.setspawnpoint = var_02;
	var_00 notify("faux_spawn");
	var_00.faux_spawn_stance = var_00 getstance();
	var_00 thread maps\mp\gametypes\_playerlogic::spawnplayer(1);
	thread maps\mp\_utility::teamplayercardsplash("callout_first_mercenary",var_00);
	maps\mp\_utility::playsoundonplayers("mp_enemy_obj_captured");
}

//Function Number: 9
func_3A2A()
{
	level endon("game_ended");
	self.isinitialinfected = undefined;
	if(isdefined(self.iscarrying) && self.iscarrying == 1)
	{
		self notify("force_cancel_placement");
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
	var_00 = spawn("script_model",self.origin);
	var_00.angles = self.angles;
	var_00.playerspawnpos = self.origin;
	var_00.notti = 1;
	self.setspawnpoint = var_00;
	self notify("faux_spawn");
	self.faux_spawn_stance = self getstance();
	thread maps\mp\gametypes\_playerlogic::spawnplayer(1);
}

//Function Number: 10
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(param_01) && isplayer(param_01) && param_01 != self && self.team == "allies" && self.team != param_01.team)
	{
		self.addtoteam = "axis";
		level.infect_teamscores["allies"]--;
		level.infect_teamscores["axis"]++;
		func_3A2B();
		if(isdefined(param_01.isinitialinfected))
		{
			param_01 thread func_3A2A();
		}

		param_01 thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_DRAFTED");
		lib_036E::func_2B7B("draft_rogue",param_01,self,1);
		param_01 thread maps\mp\gametypes\_rank::giverankxp("draft_rogue");
		if(level.infect_teamscores["allies"] > 1)
		{
			maps\mp\_utility::playsoundonplayers("mp_enemy_obj_captured","allies");
			maps\mp\_utility::playsoundonplayers("mp_war_objective_taken","axis");
			thread maps\mp\_utility::teamplayercardsplash("callout_got_drafted",self,"allies");
			thread maps\mp\_utility::teamplayercardsplash("callout_drafted_rogue",param_01,"axis");
			foreach(var_0B in level.players)
			{
				if(var_0B.team == "allies" && var_0B != self)
				{
					var_0B thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_SURVIVOR");
					lib_036E::func_2B7B("survivor",var_0B,undefined,1);
					var_0B thread maps\mp\gametypes\_rank::giverankxp("survivor");
				}
			}
		}

		if(level.infect_teamscores["allies"] == 1)
		{
			maps\mp\_utility::playsoundonplayers("mp_obj_captured");
			foreach(var_0B in level.players)
			{
				if(var_0B.team == "allies" && var_0B != self)
				{
					var_0B thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_FINAL_ROGUE");
					lib_036E::func_2B7B("final_rogue",var_0B,undefined,1);
					var_0B thread maps\mp\gametypes\_rank::giverankxp("final_rogue");
					thread maps\mp\_utility::teamplayercardsplash("callout_final_rogue",var_0B);
					break;
				}
			}

			return;
		}

		if(level.infect_teamscores["allies"] == 0)
		{
			level.finalkillcam_winner = "axis";
			level thread maps\mp\gametypes\_gamelogic::endgame("axis",game["strings"]["allies_eliminated"]);
			return;
		}
	}
}

//Function Number: 11
ondisconnect()
{
	level endon("game_ended");
	self endon("eliminated");
	self waittill("disconnect");
	if(self.team == "spectator")
	{
		return;
	}

	level.infect_teamscores[self.team]--;
	func_3A2B();
	if(isdefined(self.infect_isbeingchosen) || level.infect_chosefirstinfected)
	{
		if(level.infect_teamscores["allies"] == 0)
		{
			level.finalkillcam_winner = "axis";
			level thread maps\mp\gametypes\_gamelogic::endgame("axis",game["strings"]["allies_eliminated"]);
			return;
		}

		if(level.infect_teamscores["axis"] == 0)
		{
			if(level.infect_teamscores["allies"] > 1)
			{
				level.infect_chosefirstinfected = 0;
				level thread func_3A28();
				return;
			}

			level.finalkillcam_winner = "allies";
			level thread maps\mp\gametypes\_gamelogic::endgame("allies",game["strings"]["allies_eliminated"]);
			return;
		}
	}
}

//Function Number: 12
onplayereliminated()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("player_eliminated",var_00);
		var_00 notify("eliminated");
		level.infect_teamscores[var_00.team]--;
		func_3A2B();
		if(level.infect_teamscores["allies"] == 0)
		{
			level.finalkillcam_winner = "axis";
			level thread maps\mp\gametypes\_gamelogic::endgame("axis",game["strings"]["allies_eliminated"]);
			continue;
		}

		if(level.infect_teamscores["axis"] == 0)
		{
			level.finalkillcam_winner = "allies";
			level thread maps\mp\gametypes\_gamelogic::endgame("allies",game["strings"]["axis_eliminated"]);
		}
	}
}

//Function Number: 13
ondeadevent(param_00)
{
}

//Function Number: 14
ontimelimit()
{
	level.finalkillcam_winner = "allies";
	level thread maps\mp\gametypes\_gamelogic::endgame("allies",game["strings"]["time_limit_reached"]);
}

//Function Number: 15
func_3A2B()
{
	game["teamScores"]["axis"] = level.infect_teamscores["axis"];
	setteamscore("axis",level.infect_teamscores["axis"]);
	game["teamScores"]["allies"] = level.infect_teamscores["allies"];
	setteamscore("allies",level.infect_teamscores["allies"]);
}

//Function Number: 16
func_3989()
{
	if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses","axis",0,"class","inUse"))
	{
		level.infect_loadouts["axis"] = maps\mp\_utility::getmatchrulesspecialclass("axis",0);
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
		level.infect_loadouts["axis_initial"] = maps\mp\_utility::getmatchrulesspecialclass("axis",5);
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
		level.infect_loadouts["allies"] = maps\mp\_utility::getmatchrulesspecialclass("allies",0);
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