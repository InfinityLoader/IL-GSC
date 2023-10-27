/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\infect.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 32
 * Decompile Time: 583 ms
 * Timestamp: 10/27/2023 1:29:18 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	maps\mp\gametypes\_globallogic::func_44DF();
	maps\mp\gametypes\_callbacksetup::func_71F0();
	maps\mp\gametypes\_globallogic::func_71F0();
	if(isusingmatchrulesdata())
	{
		level.initializematchrules = ::initializematchrules;
		[[ level.initializematchrules ]]();
		level thread maps\mp\_utility::func_647E();
	}
	else
	{
		maps\mp\_utility::func_6476(level.gametype,10);
		maps\mp\_utility::func_708B("scorelimit",0);
		maps\mp\_utility::func_6472(level.gametype,1);
		maps\mp\_utility::func_647C(level.gametype,1);
		maps\mp\_utility::func_6470(level.gametype,0);
		maps\mp\_utility::func_646A(level.gametype,0);
		level.matchrules_numinitialinfected = 1;
		level.matchrules_damagemultiplier = 0;
	}

	func_70CF();
	level.teambased = 1;
	level.supportintel = 0;
	level.disableforfeit = 1;
	level.nobuddyspawns = 1;
	level.onstartgametype = ::onstartgametype;
	level.var_5976 = ::func_5976;
	level.getspawnpoint = ::getspawnpoint;
	level.onplayerkilled = ::onplayerkilled;
	level.ondeadevent = ::ondeadevent;
	level.ontimelimit = ::ontimelimit;
	level.bypassclasschoicefunc = ::alwaysgamemodeclass;
	if(level.matchrules_damagemultiplier)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	game["dialog"]["gametype"] = "infected";
	if(getdvarint("g_hardcore"))
	{
		game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
	}

	game["dialog"]["offense_obj"] = "infct_hint";
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::func_700A();
	level.matchrules_numinitialinfected = getmatchrulesdata("infectData","numInitialInfected");
	setdynamicdvar("scr_" + level.gametype + "_numLives",0);
	maps\mp\_utility::func_6470(level.gametype,0);
	maps\mp\_utility::func_708B("scorelimit",0);
	setdynamicdvar("scr_infect_roundswitch",0);
	maps\mp\_utility::func_6473("infect",0,0,9);
	setdynamicdvar("scr_infect_roundlimit",1);
	maps\mp\_utility::func_6472("infect",1);
	setdynamicdvar("scr_infect_winlimit",1);
	maps\mp\_utility::func_647C("infect",1);
	setdynamicdvar("scr_infect_halftime",0);
	maps\mp\_utility::func_646A("infect",0);
	setdynamicdvar("scr_infect_playerrespawndelay",0);
	setdynamicdvar("scr_infect_waverespawndelay",0);
	setdynamicdvar("scr_player_forcerespawn",1);
	setdynamicdvar("scr_team_fftype",0);
	setdynamicdvar("scr_infect_promode",0);
}

//Function Number: 3
onstartgametype()
{
	setclientnamemode("auto_change");
	maps\mp\_utility::func_7084("allies",&"OBJECTIVES_INFECT");
	maps\mp\_utility::func_7084("axis",&"OBJECTIVES_INFECT");
	if(level.splitscreen)
	{
		maps\mp\_utility::func_7083("allies",&"OBJECTIVES_INFECT");
		maps\mp\_utility::func_7083("axis",&"OBJECTIVES_INFECT");
	}
	else
	{
		maps\mp\_utility::func_7083("allies",&"OBJECTIVES_INFECT_SCORE");
		maps\mp\_utility::func_7083("axis",&"OBJECTIVES_INFECT_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_INFECT_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_INFECT_HINT");
	initspawns();
	var_00[0] = level.gametype;
	maps\mp\gametypes\_gameobjects::func_4FDD(var_00);
	level.quickmessagetoall = 1;
	level.blockweapondrops = 1;
	level.infect_allowsuicide = 0;
	level.infect_chosefirstinfected = 0;
	level.infect_choosingfirstinfected = 0;
	level.infect_awardedfinalsurvivor = 0;
	level.infect_countdowninprogress = 0;
	level.infect_teamscores["axis"] = 0;
	level.infect_teamscores["allies"] = 0;
	level.infect_players = [];
	level thread func_595D();
	level thread func_3704();
}

//Function Number: 4
func_3704()
{
	level endon("game_ended");
	setdynamicdvar("scr_infect_timelimit",0);
	for(;;)
	{
		level waittill("update_game_time",var_00);
		if(!isdefined(var_00))
		{
			var_00 = maps\mp\_utility::func_3C4B() + 1500 / -5536 + 2;
		}

		setdynamicdvar("scr_infect_timelimit",var_00);
		level thread watchhostmigration(var_00);
	}
}

//Function Number: 5
watchhostmigration(param_00)
{
	level notify("watchHostMigration");
	level endon("watchHostMigration");
	level endon("game_ended");
	level waittill("host_migration_begin");
	setdynamicdvar("scr_infect_timelimit",0);
	waittillframeend;
	setdynamicdvar("scr_infect_timelimit",0);
	level waittill("host_migration_end");
	level notify("update_game_time",param_00);
}

//Function Number: 6
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.gamemodefirstspawn = 1;
		var_00.gamemodejoinedatstart = 1;
		var_00.infectedrejoined = 0;
		if(maps\mp\_utility::func_36F1("prematch_done"))
		{
			var_00.gamemodejoinedatstart = 0;
			if(isdefined(level.infect_chosefirstinfected) && level.infect_chosefirstinfected)
			{
				var_00.survivalstarttime = gettime();
			}
		}

		if(isdefined(level.infect_players[var_00.name]))
		{
			var_00.infectedrejoined = 1;
		}

		var_00 thread func_53CE();
	}
}

//Function Number: 7
initspawns()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies","mp_tdm_spawn");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis","mp_tdm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
}

//Function Number: 8
alwaysgamemodeclass()
{
	return "gamemode";
}

//Function Number: 9
getspawnpoint()
{
	if(self.gamemodefirstspawn)
	{
		self.gamemodefirstspawn = 0;
		self.pers["class"] = "gamemode";
		self.pers["lastClass"] = "";
		self.class = self.pers["class"];
		self.lastclass = self.pers["lastClass"];
		var_00 = "allies";
		if(self.infectedrejoined)
		{
			var_00 = "axis";
		}

		lib_05D5::addtoteam(var_00,1);
		thread func_537E();
	}

	if(level.ingraceperiod)
	{
		var_01 = maps\mp\gametypes\_spawnlogic::func_3BF6("mp_tdm_spawn");
		var_02 = maps\mp\gametypes\_spawnlogic::func_3BF2(var_01);
	}
	else
	{
		var_01 = maps\mp\gametypes\_spawnlogic::func_3C41(self.pers["team"]);
		var_02 = maps\mp\gametypes\_spawnscoring::func_3BF1(var_02);
	}

	return var_02;
}

//Function Number: 10
func_5976()
{
	self.teamchangedthisframe = undefined;
	self.infect_spawnpos = self.origin;
	updateteamscores();
	if(!level.infect_choosingfirstinfected)
	{
		level.infect_choosingfirstinfected = 1;
		level thread func_1BF3();
	}

	if(self.infectedrejoined)
	{
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
				var_01 thread func_7058();
			}
		}

		if(level.infect_teamscores["axis"] == 1)
		{
			self.isinitialinfected = 1;
		}

		func_4656(1);
	}

	if(isdefined(self.isinitialinfected))
	{
		self.pers["gamemodeLoadout"] = level.infect_loadouts["axis_initial"];
		self.infected_class = "axis_initial";
	}
	else
	{
		self.pers["gamemodeLoadout"] = level.infect_loadouts[self.pers["team"]];
		self.infected_class = self.pers["team"];
	}

	thread func_5975();
	level notify("spawned_player");
}

//Function Number: 11
spawnwithplayersecondary()
{
	var_00 = self getweaponslistprimaries();
	var_01 = self getcurrentprimaryweapon();
	if(var_00.size > 1)
	{
		if(var_01 == "iw6_knifeonly_mp")
		{
			foreach(var_03 in var_00)
			{
				if(var_03 != var_01)
				{
					self setspawnweapon(var_03);
				}
			}
		}
	}
}

//Function Number: 12
setdefaultammoclip(param_00)
{
	var_01 = 1;
	if(isdefined(self.isinitialinfected))
	{
		if(maps\mp\_utility::isusingdefaultclass(param_00,1))
		{
			var_01 = 0;
		}
	}
	else if(maps\mp\_utility::isusingdefaultclass(param_00,0))
	{
		var_01 = 0;
	}

	return var_01;
}

//Function Number: 13
func_5975()
{
	self endon("death");
	self endon("disconnect");
	self waittill("giveLoadout");
	self.last_infected_class = self.infected_class;
	if(self.pers["team"] == "allies")
	{
		spawnwithplayersecondary();
		if(setdefaultammoclip("allies"))
		{
			self setweaponammoclip("proximity_explosive_mp",1);
			self setweaponammoclip("concussion_grenade_mp",1);
		}
	}
	else if(self.pers["team"] == "axis")
	{
		thread func_7056();
		self setmovespeedscale(1.2);
		if(setdefaultammoclip("axis"))
		{
			self setweaponammoclip("throwingknife_mp",1);
		}

		thread func_7055();
	}

	self.faux_spawn_infected = undefined;
}

//Function Number: 14
func_7055()
{
	self setmodel("mp_body_infected_a");
	if(isdefined(self.headmodel))
	{
		self detach(self.headmodel,"");
		self.headmodel = undefined;
	}

	self attach("head_mp_infected","",1);
	self.headmodel = "head_mp_infected";
	self setviewmodel("viewhands_gs_hostage");
	self setclothtype("cloth");
}

//Function Number: 15
func_7056()
{
	if(isdefined(self.isinitialinfected))
	{
		if(!isdefined(self.showninfected) || !self.showninfected)
		{
			thread maps\mp\gametypes\_rank::func_8E6E("first_infected");
			self.showninfected = 1;
		}
	}

	if(isdefined(self.changingtoregularinfected))
	{
		self.changingtoregularinfected = undefined;
		if(isdefined(self.changingtoregularinfectedbykill))
		{
			self.changingtoregularinfectedbykill = undefined;
			thread maps\mp\gametypes\_rank::func_8E6E("firstblood");
			maps\mp\gametypes\_gamescore::func_3D00("first_infected",self);
			thread maps\mp\gametypes\_rank::giverankxp("first_infected");
		}
	}

	if(!isdefined(self.showninfected) || !self.showninfected)
	{
		thread maps\mp\gametypes\_rank::func_8E6E("got_infected");
		self.showninfected = 1;
	}
}

//Function Number: 16
func_1BF3()
{
	level endon("game_ended");
	level endon("infect_stopCountdown");
	level.infect_allowsuicide = 0;
	maps\mp\_utility::gameflagwait("prematch_done");
	level.infect_countdowninprogress = 1;
	maps\mp\gametypes\_hostmigration::func_8B0D(1);
	setomnvar("ui_match_start_text","first_infected_in");
	var_00 = 15;
	while(var_00 > 0 && !level.gameended)
	{
		setomnvar("ui_match_start_countdown",var_00);
		var_00--;
		maps\mp\gametypes\_hostmigration::func_8B0D(1);
	}

	setomnvar("ui_match_start_countdown",0);
	level.infect_countdowninprogress = 0;
	var_01 = [];
	foreach(var_03 in level.players)
	{
		if(maps\mp\_utility::func_50C1() && level.players.size > 1 && var_03 ishost())
		{
			continue;
		}

		if(var_03.team == "spectator")
		{
			continue;
		}

		if(!var_03.hasspawned)
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	var_05 = var_01[randomint(var_01.size)];
	var_05 setfirstinfected(1);
	foreach(var_03 in level.players)
	{
		if(var_03 == var_05)
		{
			continue;
		}

		var_03.survivalstarttime = gettime();
	}
}

//Function Number: 17
setfirstinfected(param_00)
{
	self endon("disconnect");
	if(param_00)
	{
		self.infect_isbeingchosen = 1;
	}

	while(!maps\mp\_utility::func_4945(self) || maps\mp\_utility::func_4995())
	{
		wait(0.05);
	}

	if(isdefined(self.iscarrying) && self.iscarrying == 1)
	{
		self notify("force_cancel_placement");
		wait(0.05);
	}

	while(self ismantling())
	{
		wait(0.05);
	}

	while(!self isonground() && !self isonladder())
	{
		wait(0.05);
	}

	if(maps\mp\_utility::isjuggernaut())
	{
		self notify("lost_juggernaut");
		wait(0.05);
	}

	while(!isalive(self))
	{
		common_scripts\utility::func_8AFE();
	}

	if(param_00)
	{
		lib_05D5::addtoteam("axis",undefined,1);
		thread func_537E();
		level.infect_chosefirstinfected = 1;
		self.infect_isbeingchosen = undefined;
		level notify("update_game_time");
		updateteamscores();
		level.infect_allowsuicide = 1;
	}

	self.isinitialinfected = 1;
	self.pers["gamemodeLoadout"] = level.infect_loadouts["axis_initial"];
	if(isdefined(self.setspawnpoint))
	{
		maps\mp\perks\_perkfunctions::deleteti(self.setspawnpoint);
	}

	var_01 = spawn("script_model",self.origin);
	var_01.angles = self.angles;
	var_01.playerspawnpos = self.origin;
	var_01.notti = 1;
	self.setspawnpoint = var_01;
	self notify("faux_spawn");
	self.faux_spawn_stance = self getstance();
	self.faux_spawn_infected = 1;
	thread maps\mp\gametypes\_playerlogic::spawnplayer(1);
	if(param_00)
	{
		level.infect_players[self.name] = 1;
	}

	foreach(var_03 in level.players)
	{
		var_03 thread maps\mp\gametypes\_hud_message::func_794C("first_infected");
	}

	level thread maps\mp\_utility::func_7FA0("callout_first_infected",self);
	maps\mp\_utility::func_6045("mp_enemy_obj_captured");
	func_4656(1);
}

//Function Number: 18
func_7058(param_00,param_01)
{
	level endon("game_ended");
	self.isinitialinfected = undefined;
	self.changingtoregularinfected = 1;
	if(isdefined(param_00))
	{
		self.changingtoregularinfectedbykill = 1;
	}

	while(!maps\mp\_utility::func_4945(self))
	{
		wait(0.05);
	}

	if(isdefined(self.iscarrying) && self.iscarrying == 1)
	{
		self notify("force_cancel_placement");
		wait(0.05);
	}

	while(self ismantling())
	{
		wait(0.05);
	}

	while(!self isonground())
	{
		wait(0.05);
	}

	if(maps\mp\_utility::isjuggernaut())
	{
		self notify("lost_juggernaut");
		wait(0.05);
	}

	if(isdefined(param_01) && param_01 == "MOD_MELEE")
	{
		wait(1.2);
	}

	while(!maps\mp\_utility::func_4945(self))
	{
		wait(0.05);
	}

	self.pers["gamemodeLoadout"] = level.infect_loadouts["axis"];
	if(isdefined(self.setspawnpoint))
	{
		maps\mp\perks\_perkfunctions::deleteti(self.setspawnpoint);
	}

	var_02 = spawn("script_model",self.origin);
	var_02.angles = self.angles;
	var_02.playerspawnpos = self.origin;
	var_02.notti = 1;
	self.setspawnpoint = var_02;
	self notify("faux_spawn");
	self.faux_spawn_stance = self getstance();
	self.faux_spawn_infected = 1;
	thread maps\mp\gametypes\_playerlogic::spawnplayer(1);
}

//Function Number: 19
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

	if(isplayer(param_01) && param_01.team == "allies" && param_01 != self)
	{
		param_01.pers["killsAsSurvivor"]++;
		param_01 maps\mp\gametypes\_persistence::func_7B28("round","killsAsSurvivor",param_01.pers["killsAsSurvivor"]);
	}
	else if(isplayer(param_01) && param_01.team == "axis" && param_01 != self)
	{
		param_01.pers["killsAsInfected"]++;
		param_01 maps\mp\gametypes\_persistence::func_7B28("round","killsAsInfected",param_01.pers["killsAsInfected"]);
	}

	if(var_0A)
	{
		self.teamchangedthisframe = 1;
		lib_05D5::addtoteam("axis");
		thread func_537E();
		level notify("update_game_time");
		updateteamscores();
		level.infect_players[self.name] = 1;
		if(var_0B)
		{
			if(level.infect_teamscores["axis"] > 1)
			{
				foreach(var_0D in level.players)
				{
					if(isdefined(var_0D.isinitialinfected))
					{
						var_0D thread func_7058();
					}
				}
			}
		}
		else if(isdefined(param_01.isinitialinfected))
		{
			param_01 thread func_7058(1,param_03);
		}
		else
		{
			param_01 thread maps\mp\gametypes\_rank::func_8E6E("infected_survivor");
			maps\mp\gametypes\_gamescore::func_3D00("infected_survivor",param_01,self,1);
			param_01 thread maps\mp\gametypes\_rank::giverankxp("infected_survivor");
		}

		if(level.infect_teamscores["allies"] > 1)
		{
			maps\mp\_utility::func_6045("mp_enemy_obj_captured","allies");
			maps\mp\_utility::func_6045("mp_war_objective_taken","axis");
			thread maps\mp\_utility::func_7FA0("callout_got_infected",self,"allies");
			if(!var_0B)
			{
				thread maps\mp\_utility::func_7FA0("callout_infected",param_01,"axis");
				foreach(var_0D in level.players)
				{
					if(!maps\mp\_utility::func_4945(var_0D) || self.sessionstate == "spectator")
					{
						continue;
					}

					if(var_0D.team == "allies" && var_0D != self && distance(var_0D.infect_spawnpos,var_0D.origin) > 32)
					{
						var_0D thread maps\mp\gametypes\_rank::func_8E6E("survivor");
						maps\mp\gametypes\_gamescore::func_3D00("survivor",var_0D,undefined,1);
						var_0D thread maps\mp\gametypes\_rank::giverankxp("survivor");
					}
				}
			}
		}
		else if(level.infect_teamscores["allies"] == 1)
		{
			onfinalsurvivor();
		}
		else if(level.infect_teamscores["allies"] == 0)
		{
			func_597B();
		}

		func_70D9(1);
	}
}

//Function Number: 20
onfinalsurvivor()
{
	maps\mp\_utility::func_6045("mp_obj_captured");
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		if(var_01.team == "allies")
		{
			var_01 thread maps\mp\gametypes\_rank::func_8E6E("final_survivor");
			if(!level.infect_awardedfinalsurvivor)
			{
				if(var_01.gamemodejoinedatstart && isdefined(var_01.infect_spawnpos) && distance(var_01.infect_spawnpos,var_01.origin) > 32)
				{
					maps\mp\gametypes\_gamescore::func_3D00("final_survivor",var_01,undefined,1);
					var_01 thread maps\mp\gametypes\_rank::giverankxp("final_survivor");
				}

				level.infect_awardedfinalsurvivor = 1;
			}

			thread maps\mp\_utility::func_7FA0("callout_final_survivor",var_01);
			if(!var_01 maps\mp\_utility::isjuggernaut())
			{
				level thread func_3258(var_01);
			}

			break;
		}
	}
}

//Function Number: 21
func_3258(param_00)
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
		wait(4);
		if(var_01)
		{
			setteamradar("axis",0);
			var_01 = 0;
		}

		wait(6);
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

//Function Number: 22
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
			wait(0.05);
			setteamradar("axis",0);
			break;
		}

		wait(0.05);
	}
}

//Function Number: 23
func_537E()
{
	level endon("game_ended");
	self endon("eliminated");
	self notify("infect_monitor_disconnect");
	self endon("infect_monitor_disconnect");
	var_00 = self.team;
	if(!isdefined(var_00) && isdefined(self.bot_team))
	{
		var_00 = self.bot_team;
	}

	self waittill("disconnect");
	updateteamscores();
	if(isdefined(self.infect_isbeingchosen) || level.infect_chosefirstinfected)
	{
		if(level.infect_teamscores["axis"] && level.infect_teamscores["allies"])
		{
			if(var_00 == "allies" && level.infect_teamscores["allies"] == 1)
			{
				onfinalsurvivor();
			}
			else if(var_00 == "axis" && level.infect_teamscores["axis"] == 1)
			{
				foreach(var_02 in level.players)
				{
					if(var_02 != self && var_02.team == "axis")
					{
						var_02 setfirstinfected(0);
					}
				}
			}
		}
		else if(level.infect_teamscores["allies"] == 0)
		{
			func_597B();
		}
		else if(level.infect_teamscores["axis"] == 0)
		{
			if(level.infect_teamscores["allies"] == 1)
			{
				level.finalkillcam_winner = "allies";
				level thread maps\mp\gametypes\_gamelogic::endgame("allies",game["end_reason"]["axis_eliminated"]);
			}
			else if(level.infect_teamscores["allies"] > 1)
			{
				level.infect_chosefirstinfected = 0;
				level thread func_1BF3();
			}
		}
	}
	else if(level.infect_countdowninprogress && level.infect_teamscores["allies"] == 0 && level.infect_teamscores["axis"] == 0)
	{
		level notify("infect_stopCountdown");
		level.infect_choosingfirstinfected = 0;
		setomnvar("ui_match_start_countdown",0);
	}

	self.isinitialinfected = undefined;
}

//Function Number: 24
ondeadevent(param_00)
{
}

//Function Number: 25
ontimelimit()
{
	level.finalkillcam_winner = "allies";
	level thread maps\mp\gametypes\_gamelogic::endgame("allies",game["end_reason"]["time_limit_reached"]);
}

//Function Number: 26
func_597B()
{
	level.finalkillcam_winner = "axis";
	level thread maps\mp\gametypes\_gamelogic::endgame("axis",game["end_reason"]["allies_eliminated"]);
}

//Function Number: 27
func_3C3F(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.players)
	{
		if(var_03.sessionstate == "spectator" && !var_03.spectatekillcam)
		{
			continue;
		}

		if(var_03.team == param_00)
		{
			var_01++;
		}
	}

	return var_01;
}

//Function Number: 28
updateteamscores()
{
	level.infect_teamscores["allies"] = func_3C3F("allies");
	game["teamScores"]["allies"] = level.infect_teamscores["allies"];
	setteamscore("allies",level.infect_teamscores["allies"]);
	level.infect_teamscores["axis"] = func_3C3F("axis");
	game["teamScores"]["axis"] = level.infect_teamscores["axis"];
	setteamscore("axis",level.infect_teamscores["axis"]);
}

//Function Number: 29
func_70CF()
{
	if(maps\mp\_utility::isusingdefaultclass("allies",0))
	{
		level.infect_loadouts["allies"] = maps\mp\_utility::func_3B24("allies",0);
	}
	else
	{
		level.infect_loadouts["allies"]["loadoutPrimary"] = "iw6_maul";
		level.infect_loadouts["allies"]["loadoutPrimaryAttachment"] = "none";
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
		level.infect_loadouts["allies"]["loadoutEquipment"] = "proximity_explosive_mp";
		level.infect_loadouts["allies"]["loadoutOffhand"] = "concussion_grenade_mp";
		level.infect_loadouts["allies"]["loadoutStreakType"] = "assault";
		level.infect_loadouts["allies"]["loadoutKillstreak1"] = "none";
		level.infect_loadouts["allies"]["loadoutKillstreak2"] = "none";
		level.infect_loadouts["allies"]["loadoutKillstreak3"] = "none";
		level.infect_loadouts["allies"]["loadoutJuggernaut"] = 0;
		level.infect_loadouts["allies"]["loadoutPerks"] = ["specialty_scavenger","specialty_quickdraw","specialty_quieter"];
	}

	if(maps\mp\_utility::isusingdefaultclass("axis",1))
	{
		level.infect_loadouts["axis_initial"] = maps\mp\_utility::func_3B24("axis",1);
		level.infect_loadouts["axis_initial"]["loadoutStreakType"] = "assault";
		level.infect_loadouts["axis_initial"]["loadoutKillstreak1"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutKillstreak2"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutKillstreak3"] = "none";
	}
	else
	{
		level.infect_loadouts["axis_initial"]["loadoutPrimary"] = "iw6_m9a1";
		level.infect_loadouts["axis_initial"]["loadoutPrimaryAttachment"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutPrimaryAttachment2"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutPrimaryBuff"] = "specialty_bling";
		level.infect_loadouts["axis_initial"]["loadoutPrimaryCamo"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutPrimaryReticle"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutSecondary"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutSecondaryAttachment"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutSecondaryAttachment2"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutSecondaryBuff"] = "specialty_null";
		level.infect_loadouts["axis_initial"]["loadoutSecondaryCamo"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutSecondaryReticle"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutEquipment"] = "throwingknife_mp";
		level.infect_loadouts["axis_initial"]["loadoutOffhand"] = "specialty_tacticalinsertion";
		level.infect_loadouts["axis_initial"]["loadoutStreakType"] = "assault";
		level.infect_loadouts["axis_initial"]["loadoutKillstreak1"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutKillstreak2"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutKillstreak3"] = "none";
		level.infect_loadouts["axis_initial"]["loadoutJuggernaut"] = 0;
		level.infect_loadouts["axis_initial"]["loadoutPerks"] = ["specialty_longersprint","specialty_quickdraw","specialty_quieter","specialty_falldamage","specialty_bulletaccuracy"];
	}

	if(maps\mp\_utility::isusingdefaultclass("axis",0))
	{
		level.infect_loadouts["axis"] = maps\mp\_utility::func_3B24("axis",0);
		level.infect_loadouts["axis"]["loadoutStreakType"] = "assault";
		level.infect_loadouts["axis"]["loadoutKillstreak1"] = "none";
		level.infect_loadouts["axis"]["loadoutKillstreak2"] = "none";
		level.infect_loadouts["axis"]["loadoutKillstreak3"] = "none";
	}

	level.infect_loadouts["axis"]["loadoutPrimary"] = "iw6_knifeonly";
	level.infect_loadouts["axis"]["loadoutPrimaryAttachment"] = "none";
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
	level.infect_loadouts["axis"]["loadoutOffhand"] = "specialty_tacticalinsertion";
	level.infect_loadouts["axis"]["loadoutStreakType"] = "assault";
	level.infect_loadouts["axis"]["loadoutKillstreak1"] = "none";
	level.infect_loadouts["axis"]["loadoutKillstreak2"] = "none";
	level.infect_loadouts["axis"]["loadoutKillstreak3"] = "none";
	level.infect_loadouts["axis"]["loadoutJuggernaut"] = 0;
	level.infect_loadouts["axis"]["loadoutPerks"] = ["specialty_longersprint","specialty_quickdraw","specialty_quieter","specialty_falldamage"];
}

//Function Number: 30
func_53CE()
{
	self endon("death");
	self endon("disconnect");
	self endon("infected");
	level endon("game_ended");
	for(;;)
	{
		if(!level.infect_chosefirstinfected || !isdefined(self.survivalstarttime) || !isalive(self))
		{
			wait(0.05);
			continue;
		}

		func_70D9(0);
		wait(1);
	}
}

//Function Number: 31
func_4656(param_00)
{
	maps\mp\_utility::setextrascore0(0);
	if(isdefined(param_00) && param_00)
	{
		self notify("infected");
		self.extrascore1 = 1;
	}
}

//Function Number: 32
func_70D9(param_00)
{
	if(!isdefined(self.survivalstarttime))
	{
		self.survivalstarttime = self.var_78C4;
	}

	var_01 = castint(gettime() - self.survivalstarttime / 1000);
	if(var_01 > 999)
	{
		var_01 = 999;
	}

	maps\mp\_utility::setextrascore0(var_01);
	if(isdefined(param_00) && param_00)
	{
		self notify("infected");
		self.extrascore1 = 1;
	}
}