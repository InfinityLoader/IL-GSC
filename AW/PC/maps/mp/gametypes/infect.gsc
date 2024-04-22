/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\infect.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 35
 * Decompile Time: 545 ms
 * Timestamp: 4/22/2024 2:11:05 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\mp\gametypes\_globallogic::init();
	lib_0540::setupcallbacks();
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
	}

	setdynamicdvar("scr_game_high_jump",1);
	setdynamicdvar("jump_slowdownEnable",0);
	setspecialloadouts();
	level.teambased = 1;
	level.doprematch = 1;
	level.disableforfeit = 1;
	level.nobuddyspawns = 1;
	level.onstartgametype = ::onstartgametype;
	level.onspawnplayer = ::onspawnplayer;
	level.getspawnpoint = ::getspawnpoint;
	level.onplayerkilled = ::onplayerkilled;
	level.ondeadevent = ::ondeadevent;
	level.ontimelimit = ::ontimelimit;
	level.autoassign = ::infectautoassign;
	level.bypassclasschoicefunc = ::infectedclass;
	if(level.matchrules_damagemultiplier)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	game["dialog"]["gametype"] = "inf_intro";
	if(getdvarint("g_hardcore"))
	{
		game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
	}

	game["dialog"]["offense_obj"] = "inf_survive";
	game["dialog"]["defense_obj"] = "inf_survive";
	game["dialog"]["first_infected"] = "inf_patientzero";
	game["dialog"]["time_extended"] = "inf_extratime";
	game["dialog"]["lone_survivor"] = "inf_lonesurvivor";
	game["dialog"]["been_infected"] = "inf_been_infected";
	if(maps\mp\_utility::isgrapplinghookgamemode())
	{
		game["dialog"]["gametype"] = "grap_" + game["dialog"]["gametype"];
	}
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::setcommonrulesfrommatchrulesdata();
	level.matchrules_numinitialinfected = getmatchrulesdata("infectData","numInitialInfected");
	setdynamicdvar("scr_" + level.gametype + "_numLives",0);
	maps\mp\_utility::registernumlivesdvar(level.gametype,0);
	maps\mp\_utility::setoverridewatchdvar("scorelimit",0);
	setdynamicdvar("scr_infect_roundswitch",0);
	maps\mp\_utility::registerroundswitchdvar("infect",0,0,9);
	setdynamicdvar("scr_infect_roundlimit",1);
	maps\mp\_utility::registerroundlimitdvar("infect",1);
	setdynamicdvar("scr_infect_winlimit",1);
	maps\mp\_utility::registerwinlimitdvar("infect",1);
	setdynamicdvar("scr_infect_halftime",0);
	maps\mp\_utility::registerhalftimedvar("infect",0);
	setdynamicdvar("scr_infect_playerrespawndelay",0);
	setdynamicdvar("scr_infect_waverespawndelay",0);
	setdynamicdvar("scr_player_forcerespawn",1);
	setdynamicdvar("scr_team_fftype",0);
	setdynamicdvar("scr_game_hardpoints",0);
}

//Function Number: 3
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
	initspawns();
	var_00[0] = level.gametype;
	maps\mp\gametypes\_gameobjects::main(var_00);
	level.quickmessagetoall = 1;
	level.blockweapondrops = 1;
	level.infect_allowsuicide = 0;
	level.infect_chosefirstinfected = 0;
	level.infect_choosingfirstinfected = 0;
	level.infect_countdowninprogress = 0;
	level.infect_teamscores["axis"] = 0;
	level.infect_teamscores["allies"] = 0;
	level.infect_players = [];
	level thread onplayerconnect();
	level thread gametimer();
}

//Function Number: 4
gametimer()
{
	level endon("game_ended");
	setdynamicdvar("scr_infect_timelimit",0);
	var_00 = 0;
	for(;;)
	{
		level waittill("update_game_time",var_01);
		if(!isdefined(var_01))
		{
			var_01 = maps\mp\_utility::gettimepassed() + 1500 / 60000 + 2;
		}

		setdynamicdvar("scr_infect_timelimit",var_01);
		level thread watchhostmigration(var_01);
		if(var_00)
		{
			level thread maps\mp\_utility::leaderdialogbothteams("time_extended","axis","time_extended","allies","status");
		}

		var_00 = 1;
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
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.infectedrejoined = 0;
		var_00.killsasinfected = 0;
		if(maps\mp\_utility::gameflag("prematch_done"))
		{
			if(isdefined(level.infect_chosefirstinfected) && level.infect_chosefirstinfected)
			{
				var_00.survivalstarttime = gettime();
			}
		}

		if(isdefined(level.infect_players[var_00.name]))
		{
			var_00.infectedrejoined = 1;
		}

		var_00 thread monitorsurvivaltime();
	}
}

//Function Number: 7
initspawns()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	level.spawn_name = "mp_tdm_spawn";
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies",level.spawn_name);
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis",level.spawn_name);
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
}

//Function Number: 8
infectautoassign()
{
	var_00 = "allies";
	if(self.infectedrejoined)
	{
		var_00 = "axis";
	}

	thread maps\mp\gametypes\_menus::setteam(var_00);
}

//Function Number: 9
getspawnpoint()
{
	if(level.ingraceperiod)
	{
		var_00 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_tdm_spawn");
		var_01 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(var_00);
	}
	else
	{
		var_00 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(self.pers["team"]);
		var_01 = maps\mp\gametypes\_spawnscoring::getspawnpoint_nearteam(var_01);
	}

	maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(var_01);
	return var_01;
}

//Function Number: 10
infectedclass()
{
	self.pers["class"] = "gamemode";
	self.pers["lastClass"] = "";
	self.pers["gamemodeLoadout"] = level.infect_loadouts[self.pers["team"]];
	self.class = self.pers["class"];
	self.lastclass = self.pers["lastClass"];
	preloadweapons();
}

//Function Number: 11
preloadweapons()
{
	var_00 = [];
	foreach(var_02 in level.infect_loadouts)
	{
		if(isdefined(var_02["loadoutPrimary"]) && var_02["loadoutPrimary"] != "iw5_combatknife" && var_02["loadoutPrimary"] != "none")
		{
			var_00[var_00.size] = var_02["loadoutPrimary"];
		}

		if(isdefined(var_02["loadoutSecondary"]) && var_02["loadoutSecondary"] != "iw5_combatknife" && var_02["loadoutSecondary"] != "none")
		{
			var_00[var_00.size] = var_02["loadoutSecondary"];
		}
	}

	if(var_00.size > 0)
	{
		self loadweapons(var_00);
	}
}

//Function Number: 12
onspawnplayer()
{
	if(isdefined(self.teamchangedthisframe))
	{
		self.pers["gamemodeLoadout"] = level.infect_loadouts[self.pers["team"]];
		maps\mp\gametypes\_class::giveloadout(self.team,self.class);
		thread monitordisconnect();
	}

	self.teamchangedthisframe = undefined;
	preloadweapons();
	updateteamscores();
	if(!level.infect_choosingfirstinfected)
	{
		level.infect_choosingfirstinfected = 1;
		level thread choosefirstinfected();
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
				var_01 thread setinitialtonormalinfected();
			}
		}

		if(level.infect_teamscores["axis"] == 1)
		{
			self.isinitialinfected = 1;
		}

		clearsurvivaltime();
	}

	if(isdefined(self.isinitialinfected))
	{
		self.pers["gamemodeLoadout"] = level.infect_loadouts["axis_initial"];
		maps\mp\gametypes\_class::giveloadout(self.team,self.class);
	}

	thread onspawnfinished();
	level notify("spawned_player");
}

//Function Number: 13
onspawnfinished()
{
	self endon("death");
	self endon("disconnect");
	self waittill("applyLoadout");
	updateloadouts();
}

//Function Number: 14
updateloadouts()
{
	if(self.pers["team"] == "allies")
	{
		maps\mp\_utility::giveperk("specialty_extended_battery",0);
	}

	if(self.pers["team"] == "axis")
	{
		thread setinfectedmsg();
		thread setinfectedmodels();
		self setmovespeedscale(1.2);
	}
}

//Function Number: 15
setinfectedmodels()
{
	self detachall();
	self setmodel("kva_hazmat_body_infected_mp");
	self attach("kva_hazmat_head_infected");
	self setviewmodel("vm_kva_hazmat_infected");
	self setclothtype("cloth");
}

//Function Number: 16
setinfectedmsg()
{
	if(!isdefined(self.showninfected) || !self.showninfected)
	{
		thread maps\mp\_events::gotinfectedevent();
		self playsoundtoplayer("mp_inf_got_infected",self);
		maps\mp\_utility::leaderdialogonplayer("been_infected","status");
		self.showninfected = 1;
	}
}

//Function Number: 17
choosefirstinfected()
{
	level endon("game_ended");
	level endon("infect_stopCountdown");
	level.infect_allowsuicide = 0;
	maps\mp\_utility::gameflagwait("prematch_done");
	level.infect_countdowninprogress = 1;
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1);
	var_00 = 15;
	setomnvar("ui_match_countdown_title",7);
	setomnvar("ui_match_countdown_toggle",1);
	while(var_00 > 0 && !level.gameended)
	{
		var_00--;
		setomnvar("ui_match_countdown",var_00 + 1);
		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1);
	}

	setomnvar("ui_match_countdown",1);
	setomnvar("ui_match_countdown_title",0);
	setomnvar("ui_match_countdown_toggle",0);
	level.infect_countdowninprogress = 0;
	var_01 = [];
	var_02 = undefined;
	foreach(var_04 in level.players)
	{
		if(maps\mp\_utility::matchmakinggame() && level.players.size > 1 && var_04 ishost())
		{
			var_02 = var_04;
			continue;
		}

		if(var_04.team == "spectator")
		{
			continue;
		}

		if(!var_04.hasspawned)
		{
			continue;
		}

		var_01[var_01.size] = var_04;
	}

	if(!var_01.size && isdefined(var_02))
	{
		var_01[var_01.size] = var_02;
	}

	var_06 = var_01[randomint(var_01.size)];
	var_06 setfirstinfected(1);
	foreach(var_04 in level.players)
	{
		if(var_04 == var_06)
		{
			continue;
		}

		var_04.survivalstarttime = gettime();
	}
}

//Function Number: 18
prepareforclasschange()
{
	while(!maps\mp\_utility::isreallyalive(self) || maps\mp\_utility::isusingremote())
	{
		wait(0.05);
	}

	if(isdefined(self.iscarrying) && self.iscarrying == 1)
	{
		self notify("force_cancel_placement");
		wait(0.05);
	}

	while(self ismeleeing())
	{
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

	maps\mp\_exo_ping::stop_exo_ping();
	maps\mp\_extrahealth::stopextrahealth();
	maps\mp\_adrenaline::stopadrenaline();
	maps\mp\_exo_cloak::active_cloaking_disable();
	maps\mp\_exo_mute::stop_exo_mute();
	maps\mp\_exo_repulsor::stop_repulsor();
	wait(0.05);
	while(!maps\mp\_utility::isreallyalive(self))
	{
		wait(0.05);
	}
}

//Function Number: 19
setfirstinfected(param_00)
{
	self endon("disconnect");
	prepareforclasschange();
	if(param_00)
	{
		self.infect_isbeingchosen = 1;
		maps\mp\gametypes\_menus::addtoteam("axis",undefined,1);
		thread monitordisconnect();
		level.infect_chosefirstinfected = 1;
		self.infect_isbeingchosen = undefined;
		level notify("update_game_time");
		updateteamscores();
		level.infect_allowsuicide = 1;
		level.infect_players[self.name] = 1;
	}

	self.isinitialinfected = 1;
	self.showninfected = 1;
	self notify("faux_spawn");
	self.pers["gamemodeLoadout"] = level.infect_loadouts["axis_initial"];
	maps\mp\gametypes\_class::giveandapplyloadout(self.team,"gamemode");
	updateloadouts();
	thread maps\mp\_events::firstinfectedevent();
	self playsoundtoplayer("mp_inf_got_infected",self);
	maps\mp\_utility::leaderdialogonplayer("first_infected","status");
	clearsurvivaltime();
	refillbattery();
}

//Function Number: 20
setinitialtonormalinfected()
{
	level endon("game_ended");
	self.isinitialinfected = undefined;
	prepareforclasschange();
	self notify("faux_spawn");
	self.pers["gamemodeLoadout"] = level.infect_loadouts["axis"];
	thread onspawnfinished();
	maps\mp\gametypes\_class::giveandapplyloadout(self.team,"gamemode");
	refillbattery();
}

//Function Number: 21
refillbattery()
{
	var_00 = self getweaponslistoffhands();
	foreach(var_02 in var_00)
	{
		self batteryfullrecharge(var_02);
	}
}

//Function Number: 22
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isdefined(param_01))
	{
		return;
	}

	if(self.team == "axis" && isplayer(param_01) && param_01.team == "allies" && maps\mp\_utility::ismeleemod(param_03))
	{
		param_01 maps\mp\gametypes\_missions::processchallenge("ch_infect_tooclose");
	}

	if(self.team == "axis")
	{
		return;
	}

	var_0A = param_01 == self || !isplayer(param_01);
	if(var_0A && !level.infect_allowsuicide)
	{
		return;
	}

	level notify("update_game_time");
	self notify("delete_explosive_drones");
	self.teamchangedthisframe = 1;
	maps\mp\gametypes\_menus::addtoteam("axis");
	setsurvivaltime(1);
	updateteamscores();
	maps\mp\_utility::playsoundonplayers("mp_enemy_obj_captured","allies");
	maps\mp\_utility::playsoundonplayers("mp_war_objective_taken","axis");
	level.infect_players[self.name] = 1;
	level thread maps\mp\_utility::teamplayercardsplash("callout_got_infected",self,"allies");
	if(!var_0A)
	{
		param_01 thread maps\mp\_events::infectedsurvivorevent();
		param_01 playsoundtoplayer("mp_inf_infection_kill",param_01);
		param_01.killsasinfected++;
		if(param_01.killsasinfected == 3)
		{
			param_01 thread maps\mp\_events::plagueevent();
			param_01.killsasinfected = 0;
		}
	}

	if(level.infect_teamscores["axis"] == 2)
	{
		foreach(var_0C in level.players)
		{
			if(isdefined(var_0C.isinitialinfected))
			{
				var_0C thread setinitialtonormalinfected();
			}
		}
	}

	if(level.infect_teamscores["allies"] == 0)
	{
		onsurvivorseliminated();
		return;
	}

	if(level.infect_teamscores["allies"] == 1)
	{
		onfinalsurvivor();
	}
}

//Function Number: 23
onfinalsurvivor()
{
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		if(var_01.team != "allies")
		{
			continue;
		}

		if(isdefined(var_01.awardedfinalsurvivor))
		{
			continue;
		}

		var_01.awardedfinalsurvivor = 1;
		var_01 thread maps\mp\_events::finalsurvivorevent();
		var_01 thread maps\mp\_utility::leaderdialogonplayer("lone_survivor","status");
		level thread finalsurvivoruav(var_01);
		break;
	}
}

//Function Number: 24
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

//Function Number: 25
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

//Function Number: 26
monitordisconnect()
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
			onsurvivorseliminated();
		}
		else if(level.infect_teamscores["axis"] == 0)
		{
			if(level.infect_teamscores["allies"] == 1)
			{
				level.finalkillcam_winner = "allies";
				level thread maps\mp\gametypes\_gamelogic::endgame("allies",game["end_reason"]["infected_eliminated"]);
			}
			else if(level.infect_teamscores["allies"] > 1)
			{
				level.infect_chosefirstinfected = 0;
				level thread choosefirstinfected();
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

//Function Number: 27
ondeadevent(param_00)
{
}

//Function Number: 28
ontimelimit()
{
	level.finalkillcam_winner = "allies";
	level thread maps\mp\gametypes\_gamelogic::endgame("allies",game["end_reason"]["time_limit_reached"]);
}

//Function Number: 29
onsurvivorseliminated()
{
	level.finalkillcam_winner = "axis";
	level thread maps\mp\gametypes\_gamelogic::endgame("axis",game["end_reason"]["survivors_eliminated"]);
}

//Function Number: 30
getteamsize(param_00)
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

//Function Number: 31
updateteamscores()
{
	level.infect_teamscores["allies"] = getteamsize("allies");
	game["teamScores"]["allies"] = level.infect_teamscores["allies"];
	setteamscore("allies",level.infect_teamscores["allies"]);
	level.infect_teamscores["axis"] = getteamsize("axis");
	game["teamScores"]["axis"] = level.infect_teamscores["axis"];
	setteamscore("axis",level.infect_teamscores["axis"]);
}

//Function Number: 32
setspecialloadouts()
{
	if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses","allies",0,"class","inUse"))
	{
		level.infect_loadouts["allies"] = maps\mp\_utility::getmatchrulesspecialclass("allies",0);
	}
	else if(level.rankedmatch)
	{
		level.infect_loadouts["allies"] = maps\mp\gametypes\_class::getemptyloadout();
		var_00 = [];
		var_00[0] = "iw5_maul";
		var_00[1] = "iw5_uts19";
		var_00[2] = "iw5_m182spr";
		var_00[3] = "iw5_arx160";
		var_00[4] = "iw5_hmr9";
		var_00[5] = "iw5_sn6";
		var_00[6] = "iw5_em1";
		var_00[7] = "iw5_epm3";
		level.infect_loadouts["allies"]["loadoutPrimary"] = var_00[randomint(var_00.size)];
		level.infect_loadouts["allies"]["loadoutPerks"][4] = "specialty_class_scavenger";
		level.infect_loadouts["allies"]["loadoutEquipment"] = "explosive_drone_mp";
		level.infect_loadouts["allies"]["loadoutEquipmentExtra"] = 1;
		level.infect_loadouts["allies"]["loadoutOffhand"] = "exoshield_equipment_mp";
	}
	else
	{
		level.infect_loadouts["allies"] = maps\mp\gametypes\_class::getemptyloadout();
		level.infect_loadouts["allies"]["loadoutPrimary"] = "iw5_maul";
		level.infect_loadouts["allies"]["loadoutPerks"][4] = "specialty_class_scavenger";
		level.infect_loadouts["allies"]["loadoutEquipment"] = "explosive_drone_mp";
		level.infect_loadouts["allies"]["loadoutEquipmentExtra"] = 1;
		level.infect_loadouts["allies"]["loadoutOffhand"] = "exoshield_equipment_mp";
	}

	if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses","axis",1,"class","inUse"))
	{
		level.infect_loadouts["axis_initial"] = maps\mp\_utility::getmatchrulesspecialclass("axis",1);
	}
	else
	{
		level.infect_loadouts["axis_initial"] = maps\mp\gametypes\_class::getemptyloadout();
		level.infect_loadouts["axis_initial"]["loadoutPrimary"] = "iw5_rw1";
		level.infect_loadouts["axis_initial"]["loadoutEquipment"] = "exoknife_mp";
		level.infect_loadouts["axis_initial"]["loadoutOffhand"] = "s1_tactical_insertion_device_mp";
		level.infect_loadouts["axis_initial"]["loadoutWildcards"] = "specialty_wildcard_duallethals";
	}

	if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses","axis",0,"class","inUse"))
	{
		level.infect_loadouts["axis"] = maps\mp\_utility::getmatchrulesspecialclass("axis",0);
		return;
	}

	level.infect_loadouts["axis"] = maps\mp\gametypes\_class::getemptyloadout();
	level.infect_loadouts["axis"]["loadoutPrimary"] = "iw5_combatknife";
	level.infect_loadouts["axis"]["loadoutEquipment"] = "exoknife_mp";
	level.infect_loadouts["axis"]["loadoutOffhand"] = "s1_tactical_insertion_device_mp";
	level.infect_loadouts["axis"]["loadoutWildcards"] = "specialty_wildcard_duallethals";
}

//Function Number: 33
monitorsurvivaltime()
{
	self endon("death");
	self endon("disconnect");
	self endon("infected");
	level endon("game_ended");
	var_00 = 0;
	for(;;)
	{
		if(!level.infect_chosefirstinfected || !isdefined(self.survivalstarttime) || !isalive(self))
		{
			wait(0.05);
			continue;
		}

		setsurvivaltime(0);
		var_00++;
		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1);
		if(var_00 == 30)
		{
			thread maps\mp\_events::survivorevent();
			var_00 = 0;
		}
	}
}

//Function Number: 34
clearsurvivaltime()
{
	maps\mp\_utility::setextrascore0(0);
	self notify("infected");
	maps\mp\_utility::setextrascore1(1);
}

//Function Number: 35
setsurvivaltime(param_00)
{
	if(!isdefined(self.survivalstarttime))
	{
		self.survivalstarttime = self.spawntime;
	}

	var_01 = int(gettime() - self.survivalstarttime / 1000);
	if(var_01 > 999)
	{
		var_01 = 999;
	}

	maps\mp\_utility::setextrascore0(var_01);
	if(isdefined(param_00) && param_00)
	{
		self notify("infected");
		maps\mp\_utility::setextrascore1(1);
	}
}