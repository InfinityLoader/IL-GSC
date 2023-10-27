/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\jugg.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 17
 * Decompile Time: 255 ms
 * Timestamp: 10/27/2023 2:26:15 AM
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
		maps\mp\_utility::func_3312(level.gametype,1);
		maps\mp\_utility::registerscorelimitdvar(level.gametype,10);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,1);
		maps\mp\_utility::func_3317(level.gametype,0);
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
		level.matchrules_respawnnewjugg = 0;
		level.matchrules_showjuggradaricon = 1;
		level.matchrules_showjuggworldicon = 0;
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	func_34B3();
	level.teambased = 1;
	level.doprematch = 1;
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onspawnplayer = ::onspawnplayer;
	level.onplayerkilled = ::onplayerkilled;
	level.ontimelimit = ::ontimelimit;
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::func_2D57;
	}
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::func_334C();
	level.matchrules_respawnnewjugg = getmatchrulesdata("juggData","respawnNewJugg");
	level.matchrules_showjuggradaricon = getmatchrulesdata("juggData","showJuggRadarIcon");
	level.matchrules_showjuggworldicon = getmatchrulesdata("juggData","showJuggWorldIcon");
	setdynamicdvar("scr_jugg_roundswitch",0);
	maps\mp\_utility::func_330E("jugg",0,0,9);
	setdynamicdvar("scr_jugg_roundlimit",1);
	maps\mp\_utility::func_3312("jugg",1);
	setdynamicdvar("scr_jugg_winlimit",1);
	maps\mp\_utility::registerwinlimitdvar("jugg",1);
	setdynamicdvar("scr_jugg_halftime",0);
	maps\mp\_utility::registerhalftimedvar("jugg",0);
	setdynamicdvar("scr_jugg_playerrespawndelay",0);
	setdynamicdvar("scr_jugg_waverespawndelay",0);
	setdynamicdvar("scr_player_forcerespawn",1);
	setdynamicdvar("scr_team_fftype",0);
	setdynamicdvar("scr_jugg_promode",0);
}

//Function Number: 3
onprecachegametype()
{
	precachestring(&"MP_JUGG_NEXT_JUGG_IN");
	precacheshader("waypoint_kill");
}

//Function Number: 4
onstartgametype()
{
	setclientnamemode("auto_change");
	maps\mp\_utility::func_3305("allies",&"OBJECTIVES_JUGG");
	maps\mp\_utility::func_3305("axis",&"OBJECTIVES_JUGG");
	if(level.splitscreen)
	{
		maps\mp\_utility::func_3306("allies",&"OBJECTIVES_JUGG");
		maps\mp\_utility::func_3306("axis",&"OBJECTIVES_JUGG");
	}
	else
	{
		maps\mp\_utility::func_3306("allies",&"OBJECTIVES_JUGG_SCORE");
		maps\mp\_utility::func_3306("axis",&"OBJECTIVES_JUGG_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_JUGG_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_JUGG_HINT");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::func_2FD0("allies","mp_tdm_spawn");
	maps\mp\gametypes\_spawnlogic::func_2FD0("axis","mp_tdm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::func_2FCD(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	maps\mp\gametypes\_rank::registerscoreinfo("got_juggernaut",250);
	maps\mp\gametypes\_rank::registerscoreinfo("kill_as_juggernaut",50);
	var_00 = [];
	maps\mp\gametypes\_gameobjects::main(var_00);
	level.quickmessagetoall = 1;
	level.blockweapondrops = 1;
	level.jugg_juggernaut = undefined;
	level.jugg_choosingjugg = 0;
	level thread onplayerconnect();
	level.jugg_timerdisplay = maps\mp\gametypes\_hud_util::createservertimer("objective",1.4);
	level.jugg_timerdisplay maps\mp\gametypes\_hud_util::setpoint("TOPLEFT","TOPLEFT",115,5);
	level.jugg_timerdisplay.label = &"MP_JUGG_NEXT_JUGG_IN";
	level.jugg_timerdisplay.alpha = 0;
	level.jugg_timerdisplay.archived = 0;
	level.jugg_timerdisplay.hidewheninmenu = 1;
	thread func_34CC(level.jugg_timerdisplay);
	level.killstreakrewards = 0;
}

//Function Number: 5
func_355D()
{
	level endon("game_ended");
	level notify("chooseInitialJugg");
	level endon("chooseInitialJugg");
	maps\mp\_utility::func_274B("prematch_done");
	level.jugg_timerdisplay.label = &"MP_JUGG_NEXT_JUGG_IN";
	level.jugg_timerdisplay settimer(8);
	level.jugg_timerdisplay.alpha = 1;
	maps\mp\gametypes\_hostmigration::func_2740(8);
	level.jugg_timerdisplay.alpha = 0;
	while(!level.players.size)
	{
		wait 1;
	}

	func_3562(level.players[randomint(level.players.size)],undefined,1);
}

//Function Number: 6
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.jugg_juggscore = 0;
		var_00.jugg_firstspawn = 1;
		var_00 thread func_29A7();
	}
}

//Function Number: 7
func_29A7()
{
	level endon("game_ended");
	self waittill("disconnect");
	func_3564();
}

//Function Number: 8
onspawnplayer()
{
	if(!level.jugg_choosingjugg)
	{
		level.jugg_choosingjugg = 1;
		level thread func_355D();
	}

	self.pers["gamemodeLoadout"] = level.jugg_loadouts[self.pers["team"]];
	level notify("spawned_player");
}

//Function Number: 9
getspawnpoint()
{
	if(self.jugg_firstspawn)
	{
		self.jugg_firstspawn = 0;
		self.pers["class"] = "gamemode";
		self.pers["lastClass"] = "";
		self.class = self.pers["class"];
		self.lastclass = self.pers["lastClass"];
		maps\mp\gametypes\_menus::func_2AF3("axis",1);
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

//Function Number: 10
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(param_01) && isplayer(param_01) && param_01 != self)
	{
		if(isdefined(level.jugg_juggernaut) && level.jugg_juggernaut == self)
		{
			if(level.matchrules_showjuggworldicon)
			{
				self.jugg_headicon destroy();
			}

			func_3562(param_01,self);
			return;
		}

		if(isdefined(level.jugg_juggernaut) && level.jugg_juggernaut == param_01)
		{
			param_01.jugg_juggscore++;
			param_01 maps\mp\gametypes\_gamescore::giveteamscoreforobjective(param_01.pers["team"],1);
			param_01 thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_JUGGERNAUT_KILL");
			maps\mp\gametypes\_gamescore::func_26D3("kill_as_juggernaut",param_01,self,1);
			param_01 thread maps\mp\gametypes\_rank::func_2AB3("kill_as_juggernaut");
			return;
		}

		return;
	}

	if(isdefined(level.jugg_juggernaut) && level.jugg_juggernaut == self)
	{
		self.var_2AF3 = "axis";
		maps\mp\_utility::func_2D68("mp_enemy_obj_captured");
		level.jugg_juggernaut = undefined;
		level thread func_355D();
	}
}

//Function Number: 11
func_3562(param_00,param_01,param_02)
{
	if(isdefined(param_01))
	{
		param_01.var_2AF3 = "axis";
	}

	if(isdefined(level.jugg_juggernaut))
	{
		maps\mp\_utility::func_2D68("mp_enemy_obj_captured");
		level.jugg_juggernaut = undefined;
	}
	else
	{
		maps\mp\_utility::func_2D68("mp_obj_captured");
	}

	param_00 endon("disconnect");
	param_00 thread func_822C();
	while(!isalive(param_00))
	{
		wait 0.05;
	}

	while(param_00 ismantling())
	{
		wait 0.05;
	}

	while(!param_00 isonground())
	{
		wait 0.05;
	}

	if(param_00 maps\mp\_utility::isjuggernaut())
	{
		param_00 notify("lost_juggernaut");
		wait 0.05;
	}

	param_00 maps\mp\gametypes\_menus::func_2AF3("allies");
	level.jugg_juggernaut = param_00;
	func_3564();
	if(isdefined(param_02))
	{
		param_00 thread func_3563(1);
		return;
	}

	param_00 thread func_3563();
}

//Function Number: 12
func_3563(param_00)
{
	self.pers["gamemodeLoadout"] = level.jugg_loadouts[self.pers["team"]];
	if(level.matchrules_respawnnewjugg)
	{
		self notify("faux_spawn");
		self.faux_spawn_stance = self getstance();
		thread maps\mp\gametypes\_playerlogic::func_2B25(1);
	}
	else
	{
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

	if(level.matchrules_showjuggworldicon)
	{
		self.jugg_headicon = maps\mp\_entityheadicons::func_277C(level.otherteam[self.team],"waypoint_kill",(0,0,85),24,24,undefined,undefined,undefined,1,undefined,0);
	}

	if(!isdefined(param_00))
	{
		var_02 = maps\mp\gametypes\_rank::getscoreinfovalue("got_juggernaut");
		thread maps\mp\gametypes\_hud_message::func_2892("got_juggernaut",var_02);
		maps\mp\gametypes\_gamescore::func_26D3("got_juggernaut",self,undefined,1);
		thread maps\mp\gametypes\_rank::func_2AB3("got_juggernaut");
	}

	level thread maps\mp\_utility::teamplayercardsplash("callout_new_juggernaut",self,level.otherteam[self.team]);
}

//Function Number: 13
func_3564()
{
	if(isdefined(level.jugg_juggernaut))
	{
		game["teamScores"]["allies"] = level.jugg_juggernaut.jugg_juggscore;
		setteamscore("allies",level.jugg_juggernaut.jugg_juggscore);
	}
	else
	{
		game["teamScores"]["allies"] = 0;
		setteamscore("allies",0);
	}

	game["teamScores"]["axis"] = 0;
	setteamscore("axis",0);
}

//Function Number: 14
func_822C()
{
	level endon("game_ended");
	self endon("death");
	self waittill("disconnect");
	level thread func_355D();
}

//Function Number: 15
ontimelimit()
{
	level.finalkillcam_winner = "axis";
	level thread maps\mp\gametypes\_gamelogic::endgame("axis",game["strings"]["time_limit_reached"]);
}

//Function Number: 16
func_34CC(param_00)
{
	level waittill("game_ended");
	param_00.alpha = 0;
}

//Function Number: 17
func_34B3()
{
	if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses","axis",0,"class","inUse"))
	{
		level.jugg_loadouts["axis"] = maps\mp\_utility::func_334E("axis",0);
		level.jugg_loadouts["axis"]["loadoutJuggernaut"] = 0;
	}
	else
	{
		level.jugg_loadouts["axis"]["loadoutPrimary"] = "iw5_usas12";
		level.jugg_loadouts["axis"]["loadoutPrimaryAttachment"] = "none";
		level.jugg_loadouts["axis"]["loadoutPrimaryAttachment2"] = "none";
		level.jugg_loadouts["axis"]["loadoutPrimaryBuff"] = "specialty_longerrange";
		level.jugg_loadouts["axis"]["loadoutPrimaryCamo"] = "none";
		level.jugg_loadouts["axis"]["loadoutPrimaryReticle"] = "none";
		level.jugg_loadouts["axis"]["loadoutSecondary"] = "iw5_44magnum";
		level.jugg_loadouts["axis"]["loadoutSecondaryAttachment"] = "none";
		level.jugg_loadouts["axis"]["loadoutSecondaryAttachment2"] = "none";
		level.jugg_loadouts["axis"]["loadoutSecondaryBuff"] = "specialty_null";
		level.jugg_loadouts["axis"]["loadoutSecondaryCamo"] = "none";
		level.jugg_loadouts["axis"]["loadoutSecondaryReticle"] = "none";
		level.jugg_loadouts["axis"]["loadoutEquipment"] = "claymore_mp";
		level.jugg_loadouts["axis"]["loadoutOffhand"] = "flash_grenade_mp";
		level.jugg_loadouts["axis"]["loadoutPerk1"] = "specialty_longersprint";
		level.jugg_loadouts["axis"]["loadoutPerk2"] = "specialty_quickdraw";
		level.jugg_loadouts["axis"]["loadoutPerk3"] = "specialty_bulletaccuracy";
		level.jugg_loadouts["axis"]["loadoutDeathstreak"] = "specialty_grenadepulldeath";
		level.jugg_loadouts["axis"]["loadoutJuggernaut"] = 0;
	}

	if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses","allies",5,"class","inUse"))
	{
		level.jugg_loadouts["allies"] = maps\mp\_utility::func_334E("allies",5);
		level.jugg_loadouts["allies"]["loadoutJuggernaut"] = 1;
		return;
	}

	level.jugg_loadouts["allies"]["loadoutPrimary"] = "iw5_scar";
	level.jugg_loadouts["allies"]["loadoutPrimaryAttachment"] = "none";
	level.jugg_loadouts["allies"]["loadoutPrimaryAttachment2"] = "none";
	level.jugg_loadouts["allies"]["loadoutPrimaryBuff"] = "specialty_bulletpenetration";
	level.jugg_loadouts["allies"]["loadoutPrimaryCamo"] = "none";
	level.jugg_loadouts["allies"]["loadoutPrimaryReticle"] = "none";
	level.jugg_loadouts["allies"]["loadoutSecondary"] = "rpg";
	level.jugg_loadouts["allies"]["loadoutSecondaryAttachment"] = "none";
	level.jugg_loadouts["allies"]["loadoutSecondaryAttachment2"] = "none";
	level.jugg_loadouts["allies"]["loadoutSecondaryBuff"] = "specialty_null";
	level.jugg_loadouts["allies"]["loadoutSecondaryCamo"] = "none";
	level.jugg_loadouts["allies"]["loadoutSecondaryReticle"] = "none";
	level.jugg_loadouts["allies"]["loadoutEquipment"] = "frag_grenade_mp";
	level.jugg_loadouts["allies"]["loadoutOffhand"] = "smoke_grenade_mp";
	level.jugg_loadouts["allies"]["loadoutPerk1"] = "specialty_scavenger";
	level.jugg_loadouts["allies"]["loadoutPerk2"] = "_specialty_blastshield";
	level.jugg_loadouts["allies"]["loadoutPerk3"] = "specialty_bulletaccuracy";
	level.jugg_loadouts["allies"]["loadoutDeathstreak"] = "specialty_null";
	level.jugg_loadouts["allies"]["loadoutJuggernaut"] = 1;
}