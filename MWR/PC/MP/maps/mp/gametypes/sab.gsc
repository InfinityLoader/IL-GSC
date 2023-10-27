/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\sab.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 34
 * Decompile Time: 599 ms
 * Timestamp: 10/27/2023 2:38:21 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(getdvar("mapname") == "mp_background")
	{
		return;
	}

	maps\mp\gametypes\_globallogic::init();
	maps\mp\gametypes\_callbacksetup::setupcallbacks();
	maps\mp\gametypes\_globallogic::setupcallbacks();
	level.objectivebased = 1;
	level.teambased = 1;
	if(isusingmatchrulesdata())
	{
		level.initializematchrules = ::initializematchrules;
		[[ level.initializematchrules ]]();
		level thread maps\mp\_utility::reinitializematchrulesonmigration();
	}
	else
	{
		maps\mp\_utility::registerroundswitchdvar(level.gametype,0,0,9);
		maps\mp\_utility::registertimelimitdvar(level.gametype,10);
		maps\mp\_utility::registerscorelimitdvar(level.gametype,0);
		maps\mp\_utility::registerroundlimitdvar(level.gametype,0);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,1);
		maps\mp\_utility::registernumlivesdvar(level.gametype,0);
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
		setdynamicdvar("scr_killcount_persists",0);
	}

	maps\mp\_utility::setcarrierloadouts();
	level.classicgamemode = 1;
	if(!intiebreaker())
	{
		level.onprecachegametype = ::onprecachegametype;
		level.onstartgametype = ::onstartgametype;
		level.getspawnpoint = ::getspawnpoint;
		level.onspawnplayer = ::onspawnplayer;
		level.ononeleftevent = ::ononeleftevent;
		level.ontimelimit = ::ontimelimit;
		level.ondeadevent = ::ondeadevent;
		level.onnormaldeath = ::onnormaldeath;
		level.overridewasonlyround = ::wasonlyroundsab;
		game["dialog"]["gametype"] = "sabotage";
		game["dialog"]["offense_obj"] = "capture_objs";
		game["dialog"]["defense_obj"] = "capture_objs";
	}
	else
	{
		level.onstartgametype = ::onstartgametype;
		level.getspawnpoint = ::getspawnpoint;
		level.onspawnplayer = ::onspawnplayer;
		game["dialog"]["gametype"] = "sabotage";
		game["dialog"]["offense_obj"] = "boost";
		game["dialog"]["defense_obj"] = "boost";
		maps\mp\_utility::setoverridewatchdvar("numlives",1);
		maps\mp\_utility::setoverridewatchdvar("timeLimit",0);
	}

	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	var_00 = getent("sab_bomb_defuse_allies","targetname");
	if(isdefined(var_00))
	{
		var_00 delete();
	}

	var_00 = getent("sab_bomb_defuse_axis","targetname");
	if(isdefined(var_00))
	{
		var_00 delete();
	}

	setomnvar("ui_bomb_timer_endtime",0);
}

//Function Number: 2
wasonlyroundsab()
{
	if(maps\mp\_utility::getwatcheddvar("roundlimit") == 0 && maps\mp\_utility::getwatcheddvar("winlimit") == 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 3
intiebreaker()
{
	return maps\mp\_utility::is_true(game["tiebreaker"]);
}

//Function Number: 4
initializematchrules()
{
	maps\mp\_utility::setcommonrulesfrommatchrulesdata();
	setdynamicdvar("scr_sab_bombtimer",getmatchrulesdata("sabData","bombTimer"));
	setdynamicdvar("scr_sab_planttime",getmatchrulesdata("sabData","plantTime"));
	setdynamicdvar("scr_sab_defusetime",getmatchrulesdata("sabData","defuseTime"));
	setdynamicdvar("scr_sab_hotpotato",getmatchrulesdata("sabData","sharedBombTimer"));
	setdynamicdvar("scr_sab_silentplant",getmatchrulesdata("sabData","silentPlant"));
	var_00 = getmatchrulesdata("sabData","roundSwitch");
	setdynamicdvar("scr_sab_roundswitch",var_00);
	maps\mp\_utility::registerroundswitchdvar("sab",var_00,0,9);
	setdynamicdvar("scr_sab_roundlimit",0);
	maps\mp\_utility::registerroundlimitdvar("sab",0);
	var_01 = getmatchrulesdata("commonOption","scoreLimit");
	setdynamicdvar("scr_sab_winlimit",var_01);
	maps\mp\_utility::registerwinlimitdvar("sab",var_01);
	setdynamicdvar("scr_sab_halftime",0);
	maps\mp\_utility::registerhalftimedvar("sab",0);
}

//Function Number: 5
onprecachegametype()
{
	maps\mp\gametypes\common_bomb_gameobject::onprecachegametype();
}

//Function Number: 6
onstartgametype()
{
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	setclientnamemode("auto_change");
	if(!intiebreaker())
	{
		maps\mp\_utility::setobjectivetext("allies",&"OBJECTIVES_SAB");
		maps\mp\_utility::setobjectivetext("axis",&"OBJECTIVES_SAB");
		if(level.splitscreen)
		{
			maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_SAB");
			maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_SAB");
		}
		else
		{
			maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_SAB_SCORE");
			maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_SAB_SCORE");
		}

		maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_SAB_HINT");
		maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_SAB_HINT");
	}
	else
	{
		maps\mp\_utility::setobjectivetext("allies",&"OBJECTIVES_WAR");
		maps\mp\_utility::setobjectivetext("axis",&"OBJECTIVES_WAR");
		if(level.splitscreen)
		{
			maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_WAR");
			maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_WAR");
		}
		else
		{
			maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_WAR_SCORE");
			maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_WAR_SCORE");
		}

		maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_WAR_HINT");
		maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_WAR_HINT");
	}

	initspawns();
	if(intiebreaker())
	{
		setdvar("bg_compassShowEnemies",1);
		var_00[0] = "war";
		maps\mp\gametypes\_gameobjects::main(var_00);
		return;
	}

	var_00[0] = "sab";
	maps\mp\gametypes\_gameobjects::main(var_00);
	thread updategametypedvars();
	thread sabotage();
	thread maps\mp\gametypes\_spectating::allowallyteamspectating();
}

//Function Number: 7
initspawns()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_sab_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_sab_spawn_axis_start");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies","mp_sab_spawn");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis","mp_sab_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	level.spawn_axis = [];
	level.spawn_axis_planted = [];
	level.spawn_axis_planted = [];
	level.spawn_axis_planted = [];
	level.spawn_allies = [];
	level.spawn_allies_planted = [];
	level.spawn_allies_planted = [];
	level.spawn_allies_planted = [];
	var_00 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_sab_spawn");
	var_01 = var_00;
	var_03 = getfirstarraykey(var_01);
	if(isdefined(var_03))
	{
		var_02 = var_01[var_03];
		if(!isdefined(var_02.script_noteworthy))
		{
			spawnpointerror(var_02);
			continue;
		}

		switch(var_02.script_noteworthy)
		{
			case "axis":
				break;

			case "axis_planted":
				break;

			case "allies":
				break;

			case "allies_planted":
				break;

			default:
				break;
		}
	}
}

//Function Number: 8
spawnpointerror(param_00)
{
}

//Function Number: 9
getspawnpoint()
{
	var_00 = self.pers["team"];
	if(game["switchedsides"])
	{
		var_00 = maps\mp\_utility::getotherteam(var_00);
	}

	if(level.usestartspawns)
	{
		var_01 = maps\mp\gametypes\_spawnlogic::getrandomstartspawn("mp_sab_spawn_" + var_00 + "_start");
	}
	else if(isdefined(level.bombplanted) && level.bombplanted && isdefined(level.bombowner) && var_01 == level.bombowner.team)
	{
		if(var_01 == "axis")
		{
			var_01 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(level.spawn_axis_planted);
		}
		else
		{
			var_01 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(level.spawn_allies_planted);
		}
	}
	else if(var_01 == "axis")
	{
		var_01 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(level.spawn_axis);
	}
	else
	{
		var_01 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(level.spawn_allies);
	}

	return var_01;
}

//Function Number: 10
onspawnplayer()
{
	self.isplanting = 0;
	self.isdefusing = 0;
	self.isbombcarrier = 0;
	self setclientomnvar("ui_carrying_bomb",self.isbombcarrier);
	if(intiebreaker())
	{
		thread setplayersuddendeathvalues();
	}
}

//Function Number: 11
updategametypedvars()
{
	level.planttime = maps\mp\_utility::dvarfloatvalue("planttime",5,0,20);
	level.defusetime = maps\mp\_utility::dvarfloatvalue("defusetime",5,0,20);
	level.bombtimer = maps\mp\_utility::dvarfloatvalue("bombtimer",45,1,300);
	level.hotpotato = maps\mp\_utility::dvarintvalue("hotpotato",1,0,1);
	level.silentplant = maps\mp\_utility::dvarintvalue("silentplant",0,0,1);
}

//Function Number: 12
sabotage()
{
	level.bombplanted = 0;
	level.bombexploded = 0;
	maps\mp\gametypes\common_bomb_gameobject::loadbombfx();
	var_00 = getent("sab_bomb_pickup_trig","targetname");
	if(!isdefined(var_00))
	{
		common_scripts\utility::error("No sab_bomb_pickup_trig trigger found in map.");
		return;
	}

	var_01 = maps\mp\gametypes\common_bomb_gameobject::getcarrybombvisuals("sab_bomb");
	if(!isdefined(var_01))
	{
		common_scripts\utility::error("No sab_bomb script_model found in map.");
		return;
	}

	level.sabbomb = maps\mp\gametypes\common_bomb_gameobject::createbombcarryobject("neutral","any",var_00,var_01);
	thread maps\mp\_utility::streamcarrierweaponstoplayers(level.sabbomb,["allies","axis"],::shouldstreamcarrierclasstoplayer);
	level.sabbomb.objidpingenemy = 1;
	level.sabbomb.onpickup = ::onpickup;
	level.sabbomb.ondrop = ::ondrop;
	level.sabbomb.objpoints["allies"].archived = 1;
	level.sabbomb.objpoints["axis"].archived = 1;
	level.sabbomb.autoresettime = 60;
	maps\mp\_utility::setmlgicons(level.sabbomb,"waypoint_bomb");
	if(!isdefined(getent("sab_bomb_axis","targetname")))
	{
		common_scripts\utility::error("No sab_bomb_axis trigger found in map.");
		return;
	}

	if(!isdefined(getent("sab_bomb_allies","targetname")))
	{
		common_scripts\utility::error("No sab_bomb_allies trigger found in map.");
		return;
	}

	if(game["switchedsides"])
	{
		level.bombzones["allies"] = createbombzone("allies",getent("sab_bomb_axis","targetname"));
		level.bombzones["axis"] = createbombzone("axis",getent("sab_bomb_allies","targetname"));
		return;
	}

	level.bombzones["allies"] = createbombzone("allies",getent("sab_bomb_allies","targetname"));
	level.bombzones["axis"] = createbombzone("axis",getent("sab_bomb_axis","targetname"));
}

//Function Number: 13
shouldstreamcarrierclasstoplayer(param_00,param_01)
{
	if(param_01.team == param_00 maps\mp\gametypes\_gameobjects::getownerteam())
	{
		return 0;
	}

	return 1;
}

//Function Number: 14
createbombzone(param_00,param_01)
{
	var_02 = getentarray(param_01.target,"targetname");
	var_03 = maps\mp\gametypes\common_bomb_gameobject::createbombzoneobject(param_00,"enemy","none",param_01,level.sabbomb,0);
	maps\mp\_utility::setmlgicons(var_03,"waypoint_esports_sab_target" + var_03.label);
	var_03.onuse = ::onuse;
	var_03.onbeginuse = ::onbeginuse;
	var_03.onenduse = ::onenduse;
	var_03.oncantuse = ::oncantuse;
	return var_03;
}

//Function Number: 15
onbeginuse(param_00)
{
	if(!maps\mp\gametypes\_gameobjects::isfriendlyteam(param_00.pers["team"]))
	{
		maps\mp\gametypes\common_bomb_gameobject::onbeginplantbomb(param_00);
		return;
	}

	maps\mp\gametypes\common_bomb_gameobject::onbegindefusebomb(param_00,level.sabbombmodel);
}

//Function Number: 16
onenduse(param_00,param_01,param_02)
{
	var_03 = isdefined(param_01) && param_01.isdefusing;
	maps\mp\gametypes\common_bomb_gameobject::onendusebomb(param_01,var_03);
}

//Function Number: 17
onpickup(param_00)
{
	self.autoresettime = 60;
	level.usestartspawns = 0;
	var_01 = param_00.pers["team"];
	if(var_01 == "allies")
	{
		var_02 = "axis";
	}
	else
	{
		var_02 = "allies";
	}

	var_03 = undefined;
	if(var_01 == maps\mp\gametypes\_gameobjects::getownerteam())
	{
		var_03 = var_01;
	}

	maps\mp\gametypes\common_bomb_gameobject::oncarrybombpickup(param_00,var_03);
	param_00 maps\mp\_utility::leaderdialogonplayer("obj_destroy","bomb");
	var_04[0] = param_00;
	maps\mp\_utility::leaderdialog("bomb_taken",var_01,"bomb",var_04);
	if(!level.splitscreen)
	{
		maps\mp\_utility::leaderdialog("bomb_lost",var_02,"bomb");
		maps\mp\_utility::leaderdialog("obj_defend",var_02,"bomb");
	}

	if(isdefined(level.carrierloadouts) && isdefined(level.carrierloadouts[var_01]))
	{
		param_00 thread maps\mp\_utility::applycarrierclass();
	}

	maps\mp\gametypes\_gameobjects::setownerteam(var_01);
	maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_target");
	maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_kill");
	maps\mp\_utility::setmlgicons(self,"waypoint_bomb");
	level.bombzones[var_01] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	level.bombzones[var_02] maps\mp\gametypes\_gameobjects::setvisibleteam("any");
}

//Function Number: 18
ondrop(param_00)
{
	if(!level.bombplanted)
	{
		var_01 = maps\mp\gametypes\_gameobjects::getownerteam();
		maps\mp\gametypes\common_bomb_gameobject::oncarrybombdrop(var_01,level.otherteam[var_01]);
		maps\mp\gametypes\_gameobjects::setownerteam("neutral");
		maps\mp\gametypes\_gameobjects::setvisibleteam("any");
		maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_bomb");
		maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_bomb");
		maps\mp\_utility::setmlgicons(self,"waypoint_bomb");
		level.bombzones["allies"] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
		level.bombzones["axis"] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	}
}

//Function Number: 19
onuse(param_00)
{
	var_01 = param_00.pers["team"];
	var_02 = level.otherteam[var_01];
	if(!maps\mp\gametypes\_gameobjects::isfriendlyteam(param_00.pers["team"]))
	{
		param_00 maps\mp\gametypes\common_bomb_gameobject::onplayerplantbomb(1,var_01,var_02);
		var_03 = maps\mp\gametypes\_gameobjects::getlabel();
		maps\mp\_utility::setmlgicons(self,"waypoint_esports_sab_planted" + var_03);
		level thread bombplanted(self,param_00);
		if(isdefined(level.carrierloadouts) && isdefined(level.carrierloadouts[var_01]))
		{
			param_00 thread maps\mp\_utility::removecarrierclass();
			return;
		}

		return;
	}

	param_00 maps\mp\gametypes\common_bomb_gameobject::onplayerdefusebomb(getdefusetype(param_00),var_01,var_02);
	level thread bombdefused(self,param_00,var_01);
}

//Function Number: 20
getdefusetype(param_00)
{
	var_01 = "defuse";
	if(isdefined(level.bombowner) && level.bombowner.bombplantedtime + 3000 + level.defusetime * 1000 > gettime() && maps\mp\_utility::isreallyalive(level.bombowner))
	{
		var_01 = "ninja_defuse";
	}

	return var_01;
}

//Function Number: 21
oncantuse(param_00)
{
	param_00 iprintlnbold(&"MP_CANT_PLANT_WITHOUT_BOMB");
}

//Function Number: 22
bombplanted(param_00,param_01)
{
	level endon("overtime");
	level.bombplanted = 1;
	var_02 = param_01.pers["team"];
	param_00 maps\mp\gametypes\common_bomb_gameobject::setupzonefordefusing(0);
	level.bombplantedby = var_02;
	level.sabbomb.autoresettime = undefined;
	level.sabbomb maps\mp\gametypes\_gameobjects::allowcarry("none");
	level.sabbomb maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	maps\mp\_utility::setmlgicons(level.sabbomb,undefined);
	level.sabbomb maps\mp\gametypes\_gameobjects::setdropped();
	level.sabbombmodel = level.sabbomb.visuals[0];
	setomnvar("ui_bomb_timer",1);
	level.defuseendtime = int(gettime() + level.bombtimer * 1000);
	setgameendtime(level.defuseendtime);
	param_00 maps\mp\gametypes\common_bomb_gameobject::onbombplanted(level.sabbombmodel.origin + (0,0,1));
	var_03 = param_00 maps\mp\gametypes\_gameobjects::getlabel();
	if(var_03 == "_allies")
	{
		setomnvar("ui_mlg_game_mode_status_1",1);
	}
	else if(var_03 == "_axis")
	{
		setomnvar("ui_mlg_game_mode_status_1",2);
	}

	bombtimerwait();
	setomnvar("ui_bomb_timer",0);
	setomnvar("ui_bomb_timer_endtime",0);
	param_00.tickingobject maps\mp\gametypes\common_bomb_gameobject::stoptickingsound();
	if(level.gameended)
	{
		return;
	}

	if(!level.bombplanted && level.hotpotato)
	{
		var_04 = gettime() - level.timepausestart / 1000;
		level.bombtimer = level.bombtimer - var_04;
	}

	if(!level.bombplanted)
	{
		return;
	}

	var_05 = level.sabbomb.visuals[0].origin;
	level.bombexploded = 1;
	setdvar("ui_danger_team","BombExploded");
	setomnvar("ui_mlg_game_mode_status_1",0);
	param_00 maps\mp\gametypes\common_bomb_gameobject::onbombexploded(var_05,200,param_01);
	level.sabbomb maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	level.bombzones["allies"] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	level.bombzones["axis"] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	param_00 maps\mp\gametypes\_gameobjects::disableobject();
	if(level.gameended)
	{
		return;
	}

	setgameendtime(0);
	maps\mp\gametypes\_gamescores::_setteamscore(var_02,1);
	maps\mp\gametypes\_gamescores::updateteamscore(var_02);
	wait(3);
	level.finalkillcam_winner = var_02;
	thread maps\mp\gametypes\_gamelogic::endgame(var_02,game["end_reason"]["target_destroyed"]);
}

//Function Number: 23
bombtimerwait()
{
	level endon("bomb_defused");
	level endon("overtime_ended");
	level endon("game_ended");
	var_00 = int(level.bombtimer * 1000 + gettime());
	setomnvar("ui_bomb_timer_endtime",var_00);
	level thread handlehostmigration(var_00);
	maps\mp\gametypes\_hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

//Function Number: 24
handlehostmigration(param_00)
{
	level endon("bomb_defused");
	level endon("overtime_ended");
	level endon("game_ended");
	level endon("disconnect");
	level waittill("host_migration_begin");
	var_01 = maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	if(var_01 > 0)
	{
		setomnvar("ui_bomb_timer_endtime",param_00 + var_01);
	}
}

//Function Number: 25
givelastonteamwarning()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	maps\mp\_utility::waittillrecoveredhealth(3);
	var_00 = maps\mp\_utility::getotherteam(self.pers["team"]);
	level thread maps\mp\_utility::teamplayercardsplash("callout_lastteammemberalive",self,self.pers["team"]);
	level thread maps\mp\_utility::teamplayercardsplash("callout_lastenemyalive",self,var_00);
	level notify("last_alive",self);
}

//Function Number: 26
ontimelimit()
{
	if(maps\mp\_utility::is_true(level.insuddendeath))
	{
		return;
	}

	thread suddendeaththread();
}

//Function Number: 27
suddendeaththread()
{
	level endon("game_ended");
	level.timelimitoverride = 1;
	level.insuddendeath = 1;
	for(var_00 = 0;var_00 < level.players.size;var_00++)
	{
		level.players[var_00] thread sabforcerespawn();
		level.players[var_00] thread setplayersuddendeathvalues();
	}

	setdvar("bg_compassShowEnemies",1);
	maps\mp\_utility::setoverridewatchdvar("numlives",1);
	level.sabsuddendeathtime = 90;
	var_01 = 0;
	while(var_01 < level.sabsuddendeathtime)
	{
		if(!level.bombplanted)
		{
			var_01 = var_01 + 1;
			setgameendtime(gettime() + level.sabsuddendeathtime - var_01 * 1000);
		}

		wait(1);
	}

	level.finalkillcam_winner = "none";
	thread maps\mp\gametypes\_gamelogic::endgame("tie",game["end_reason"]["tie"]);
}

//Function Number: 28
sabforcerespawn()
{
	self endon("spawned_player");
	self endon("spawn");
	self endon("disconnect");
	if(!self.hasspawned)
	{
		return;
	}

	self notify("force_spawn");
	wait(0.05);
	if(self.sessionstate != "playing" || self.health <= 0)
	{
		while(self.health <= 0)
		{
			self notify("force_spawn");
			if(maps\mp\_utility::isinkillcam())
			{
				self.cancelkillcam = 1;
				maps\mp\_utility::clearkillcamstate();
				continue;
			}

			if(self.sessionstate == "spectator" && !self.waitingtospawn && !maps\mp\_utility::is_true(self.waitingtospawnamortize))
			{
				thread sabwaitandspawnclient();
			}

			wait(0.25);
		}
	}
}

//Function Number: 29
sabwaitandspawnclient()
{
	self endon("disconnect");
	self.waitingtospawn = 1;
	maps\mp\gametypes\_playerlogic::waitandspawnclient();
	if(isdefined(self))
	{
		self.waitingtospawn = 0;
	}
}

//Function Number: 30
setplayersuddendeathvalues()
{
	self endon("disconnect");
	self setclientdvars("cg_deadChatWithDead",1,"cg_deadChatWithTeam",0,"cg_deadHearTeamLiving",0,"cg_deadHearAllLiving",0,"cg_everyoneHearsEveryone",0);
	maps\mp\_utility::gameflagwait("prematch_done");
	while(self.sessionstate != "playing" || self.health <= 0)
	{
		wait(0.05);
	}

	thread maps\mp\gametypes\_hud_message::splashnotify("sab_overtime");
}

//Function Number: 31
ondeadevent(param_00)
{
	level.finalkillcam_winner = "none";
	if(level.bombexploded)
	{
		return;
	}

	if(param_00 == "all")
	{
		if(level.bombplanted)
		{
			level.finalkillcam_winner = level.bombplantedby;
			maps\mp\gametypes\_gamescores::_setteamscore(level.bombplantedby,1);
			maps\mp\gametypes\_gamescores::updateteamscore(level.bombplantedby);
			thread maps\mp\gametypes\_gamelogic::endgame(level.bombplantedby,game["end_reason"][level.bombplantedby + "_mission_accomplished"]);
			return;
		}

		thread maps\mp\gametypes\_gamelogic::endgame("tie",game["end_reason"]["tie"]);
		return;
	}

	if(level.bombplanted)
	{
		if(param_00 == level.bombplantedby)
		{
			level.plantingteamdead = 1;
			return;
		}

		level.finalkillcam_winner = level.bombplantedby;
		maps\mp\gametypes\_gamescores::_setteamscore(level.bombplantedby,1);
		maps\mp\gametypes\_gamescores::updateteamscore(level.bombplantedby);
		thread maps\mp\gametypes\_gamelogic::endgame(level.bombplantedby,game["end_reason"][level.otherteam[level.bombplantedby] + "_eliminated"]);
		return;
	}

	level.finalkillcam_winner = level.otherteam[param_00];
	maps\mp\gametypes\_gamescores::_setteamscore(level.otherteam[param_00],1);
	maps\mp\gametypes\_gamescores::updateteamscore(level.otherteam[param_00]);
	thread maps\mp\gametypes\_gamelogic::endgame(level.otherteam[param_00],game["end_reason"][param_00 + "_eliminated"]);
}

//Function Number: 32
bombdefused(param_00,param_01,param_02)
{
	param_00.bombplantedon = 0;
	if(maps\mp\_utility::is_true(level.insuddendeath) && isdefined(level.plantingteamdead))
	{
		maps\mp\gametypes\_gamescores::_setteamscore(param_02,1);
		maps\mp\gametypes\_gamescores::updateteamscore(param_02);
		level.finalkillcam_winner = param_02;
		thread maps\mp\gametypes\_gamelogic::endgame(param_02,game["end_reason"]["bomb_defused"]);
		return;
	}

	setomnvar("ui_bomb_timer",0);
	setomnvar("ui_bomb_timer_endtime",0);
	maps\mp\gametypes\_gamelogic::resumetimer();
	level.bombplanted = 0;
	if(!maps\mp\_utility::is_true(level.insuddendeath))
	{
		level.timelimitoverride = 0;
	}

	level notify("bomb_defused");
	param_00 maps\mp\gametypes\common_bomb_gameobject::resetbombzone(level.sabbomb,"enemy","none",0);
	maps\mp\_utility::setmlgicons(param_00,"waypoint_esports_sab_target" + param_00.label);
	level.sabbomb maps\mp\gametypes\_gameobjects::allowcarry("any");
	level.sabbomb maps\mp\gametypes\_gameobjects::setpickedup(param_01);
}

//Function Number: 33
ononeleftevent(param_00)
{
	if(level.bombexploded)
	{
		return;
	}

	var_01 = maps\mp\_utility::getlastlivingplayer(param_00);
	var_01 thread givelastonteamwarning();
}

//Function Number: 34
onnormaldeath(param_00,param_01,param_02)
{
	if(param_00.isplanting)
	{
		thread maps\mp\_matchdata::logkillevent(param_02,"planting");
		param_01 thread maps\mp\_events::defendobjectiveevent(param_00,param_02);
		return;
	}

	if(param_00.isbombcarrier)
	{
		thread maps\mp\_matchdata::logkillevent(param_02,"carrying");
		return;
	}

	if(param_00.isdefusing)
	{
		thread maps\mp\_matchdata::logkillevent(param_02,"defusing");
		param_01 thread maps\mp\_events::defendobjectiveevent(param_00,param_02);
		return;
	}
}