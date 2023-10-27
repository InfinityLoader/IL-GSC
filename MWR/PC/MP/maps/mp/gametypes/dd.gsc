/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\dd.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 30
 * Decompile Time: 523 ms
 * Timestamp: 10/27/2023 2:38:08 AM
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
	if(isusingmatchrulesdata())
	{
		level.initializematchrules = ::initializematchrules;
		[[ level.initializematchrules ]]();
		level thread maps\mp\_utility::reinitializematchrulesonmigration();
	}
	else
	{
		maps\mp\_utility::registerroundswitchdvar(level.gametype,1,0,9);
		maps\mp\_utility::registertimelimitdvar(level.gametype,3);
		maps\mp\_utility::registerscorelimitdvar(level.gametype,0);
		maps\mp\_utility::registerroundlimitdvar(level.gametype,3);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,2);
		maps\mp\_utility::registernumlivesdvar(level.gametype,0);
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	maps\mp\_utility::setovertimelimitdvar(3);
	level.objectivebased = 1;
	level.teambased = 1;
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onspawnplayer = ::onspawnplayer;
	level.ondeadevent = ::ondeadevent;
	level.ontimelimit = ::ontimelimit;
	level.onnormaldeath = ::onnormaldeath;
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	level.dd = 1;
	level.bombsplanted = 0;
	level.ddbombmodel = [] setbombtimerdvar();
	setuibombtimer("_a",0);
	setuibombtimer("_b",0);
	game["dialog"]["gametype"] = "dmo_intro";
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::setcommonrulesfrommatchrulesdata();
	var_00 = getmatchrulesdata("demData","roundLength");
	setdynamicdvar("scr_dd_timelimit",var_00);
	maps\mp\_utility::registertimelimitdvar("dd",var_00);
	var_01 = getmatchrulesdata("demData","roundSwitch");
	setdynamicdvar("scr_dd_roundswitch",var_01);
	maps\mp\_utility::registerroundswitchdvar("dd",var_01,0,9);
	setdynamicdvar("scr_dd_bombtimer",getmatchrulesdata("demData","bombTimer"));
	setdynamicdvar("scr_dd_planttime",getmatchrulesdata("demData","plantTime"));
	setdynamicdvar("scr_dd_defusetime",getmatchrulesdata("demData","defuseTime"));
	setdynamicdvar("scr_dd_silentplant",getmatchrulesdata("demData","silentPlant"));
	level.ddtimetoadd = getmatchrulesdata("demData","extraTime");
	setdynamicdvar("scr_dd_addtime",level.ddtimetoadd);
	setdynamicdvar("scr_dd_roundlimit",3);
	maps\mp\_utility::registerroundlimitdvar("dd",3);
	setdynamicdvar("scr_dd_winlimit",2);
	maps\mp\_utility::registerwinlimitdvar("dd",2);
	setdynamicdvar("scr_dd_halftime",0);
	maps\mp\_utility::registerhalftimedvar("dd",0);
}

//Function Number: 3
onprecachegametype()
{
	maps\mp\gametypes\common_bomb_gameobject::onprecachegametype();
}

//Function Number: 4
onstartgametype()
{
	if(game["roundsPlayed"] == 2)
	{
		game["status"] = "overtime";
	}

	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	if(game["switchedsides"])
	{
		var_00 = game["attackers"];
		var_01 = game["defenders"];
		game["attackers"] = var_01;
		game["defenders"] = var_00;
	}

	level.usestartspawns = 1;
	setclientnamemode("manual_change");
	if(maps\mp\_utility::inovertime())
	{
		game["dialog"]["defense_obj"] = "obj_destroy";
	}

	maps\mp\gametypes\common_bomb_gameobject::loadbombfx();
	maps\mp\_utility::setobjectivetext(game["attackers"],&"OBJECTIVES_DD_ATTACKER");
	maps\mp\_utility::setobjectivetext(game["defenders"],&"OBJECTIVES_DD_DEFENDER");
	if(level.splitscreen)
	{
		maps\mp\_utility::setobjectivescoretext(game["attackers"],&"OBJECTIVES_DD_ATTACKER");
		maps\mp\_utility::setobjectivescoretext(game["defenders"],&"OBJECTIVES_DD_DEFENDER");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext(game["attackers"],&"OBJECTIVES_DD_ATTACKER_SCORE");
		maps\mp\_utility::setobjectivescoretext(game["defenders"],&"OBJECTIVES_DD_DEFENDER_SCORE");
	}

	if(maps\mp\_utility::inovertime())
	{
		maps\mp\_utility::setobjectivehinttext(game["attackers"],&"OBJECTIVES_DD_OVERTIME_HINT");
		maps\mp\_utility::setobjectivehinttext(game["defenders"],&"OBJECTIVES_DD_OVERTIME_HINT");
	}
	else
	{
		maps\mp\_utility::setobjectivehinttext(game["attackers"],&"OBJECTIVES_DD_ATTACKER_HINT");
		maps\mp\_utility::setobjectivehinttext(game["defenders"],&"OBJECTIVES_DD_DEFENDER_HINT");
	}

	initspawns();
	thread updategametypedvars();
	thread waittoprocess();
	var_02 = maps\mp\_utility::getwatcheddvar("winlimit");
	var_03[0] = "dd";
	var_03[1] = "dd_bombzone";
	var_03[2] = "blocker";
	maps\mp\gametypes\_gameobjects::main(var_03);
	thread bombs();
}

//Function Number: 5
initspawns()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addspawnpoints(game["defenders"],"mp_dd_spawn");
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_dd_spawn_defender_start");
	maps\mp\gametypes\_spawnlogic::addspawnpoints(game["attackers"],"mp_dd_spawn");
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_dd_spawn_attacker_start");
	level.spawn_defenders = [];
	level.spawn_defenders_a = [];
	level.spawn_defenders_a = [];
	level.spawn_defenders_b = [];
	level.spawn_defenders_b = [];
	level.spawn_attackers = [];
	level.spawn_attackers_a = [];
	level.spawn_attackers_a = [];
	level.spawn_attackers_b = [];
	level.spawn_attackers_b = [];
	var_00 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dd_spawn");
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
			case "defender":
				break;

			case "defender_a":
				break;

			case "defender_b":
				break;

			case "attacker":
				break;

			case "attacker_a":
				break;

			case "attacker_b":
				break;

			default:
				break;
		}
	}
}

//Function Number: 6
spawnpointerror(param_00)
{
}

//Function Number: 7
waittoprocess()
{
	level endon("game_end");
	for(;;)
	{
		if(level.ingraceperiod == 0)
		{
			break;
		}

		wait(0.05);
	}

	level.usestartspawns = 0;
}

//Function Number: 8
getspawnpoint()
{
	var_00 = self.pers["team"];
	if(level.usestartspawns)
	{
		if(var_00 == game["attackers"])
		{
			var_01 = maps\mp\gametypes\_spawnlogic::getrandomstartspawn("mp_dd_spawn_attacker_start");
		}
		else
		{
			var_01 = maps\mp\gametypes\_spawnlogic::getrandomstartspawn("mp_dd_spawn_defender_start");
		}
	}
	else if(var_01 == game["attackers"])
	{
		if(maps\mp\_utility::inovertime())
		{
			var_02 = level.spawn_attackers;
		}
		else if(!level.aplanted && !level.bplanted)
		{
			var_02 = level.spawn_attackers;
		}
		else if(level.aplanted && !level.bplanted)
		{
			var_02 = level.spawn_attackers_a;
		}
		else if(level.bplanted && !level.aplanted)
		{
			var_02 = level.spawn_attackers_b;
		}
		else
		{
			var_02 = level.spawn_attackers;
		}

		var_01 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(var_02);
	}
	else
	{
		if(maps\mp\_utility::inovertime())
		{
			var_02 = level.spawn_defenders;
		}
		else if(!level.aplanted && !level.bplanted)
		{
			var_02 = level.spawn_defenders;
		}
		else if(level.aplanted && !level.bplanted)
		{
			var_02 = level.spawn_defenders_a;
		}
		else if(level.bplanted && !level.aplanted)
		{
			var_02 = level.spawn_defenders_b;
		}
		else
		{
			var_02 = level.spawn_defenders;
		}

		var_01 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(var_02);
	}

	return var_01;
}

//Function Number: 9
onspawnplayer()
{
	if(maps\mp\_utility::inovertime() || self.pers["team"] == game["attackers"])
	{
		self.isplanting = 0;
		self.isdefusing = 0;
		self.isbombcarrier = 1;
	}
	else
	{
		self.isplanting = 0;
		self.isdefusing = 0;
		self.isbombcarrier = 0;
	}

	self setclientomnvar("ui_carrying_bomb",self.isbombcarrier);
	maps\mp\_utility::setextrascore0(0);
	if(isdefined(self.pers["plants"]))
	{
		maps\mp\_utility::setextrascore0(self.pers["plants"]);
	}

	maps\mp\_utility::setextrascore1(0);
	if(isdefined(self.pers["defuses"]))
	{
		maps\mp\_utility::setextrascore1(self.pers["defuses"]);
	}

	level notify("spawned_player");
}

//Function Number: 10
dd_endgame(param_00,param_01)
{
	if(param_00 == "tie")
	{
		level.finalkillcam_winner = "none";
	}
	else
	{
		level.finalkillcam_winner = param_00;
	}

	thread maps\mp\gametypes\_gamelogic::endgame(param_00,param_01);
}

//Function Number: 11
ondeadevent(param_00)
{
	if(level.bombexploded || level.bombdefused)
	{
		return;
	}

	if(param_00 == "all")
	{
		if(level.bombplanted)
		{
			dd_endgame(game["attackers"],game["end_reason"][game["defenders"] + "_eliminated"]);
			return;
		}

		dd_endgame(game["defenders"],game["end_reason"][game["attackers"] + "_eliminated"]);
		return;
	}

	if(param_00 == game["attackers"])
	{
		if(level.bombplanted)
		{
			return;
		}

		level thread dd_endgame(game["defenders"],game["end_reason"][game["attackers"] + "_eliminated"]);
		return;
	}

	if(param_00 == game["defenders"])
	{
		level thread dd_endgame(game["attackers"],game["end_reason"][game["defenders"] + "_eliminated"]);
		return;
	}
}

//Function Number: 12
onnormaldeath(param_00,param_01,param_02)
{
	var_03 = maps\mp\gametypes\_rank::getscoreinfovalue("kill");
	var_04 = param_00.team;
	if(game["state"] == "postgame" && param_00.team == game["defenders"] || !level.bombplanted)
	{
		param_01.finalkill = 1;
	}

	if(param_00.isplanting || param_00.isdefusing)
	{
		param_01 thread maps\mp\_events::defendobjectiveevent(param_00,param_02);
		if(param_00.isplanting)
		{
			param_01 maps\mp\gametypes\_misions::processchallenge("ch_" + level.gametype + "_interrupt");
		}

		if(param_00.isdefusing)
		{
			param_01 maps\mp\gametypes\_misions::processchallenge("ch_" + level.gametype + "_protector");
		}
	}
}

//Function Number: 13
ontimelimit()
{
	if(maps\mp\_utility::inovertime())
	{
		dd_endgame("tie",game["end_reason"]["time_limit_reached"]);
		return;
	}

	dd_endgame(game["defenders"],game["end_reason"]["time_limit_reached"]);
}

//Function Number: 14
updategametypedvars()
{
	level.planttime = maps\mp\_utility::dvarfloatvalue("planttime",5,0,20);
	level.defusetime = maps\mp\_utility::dvarfloatvalue("defusetime",5,0,20);
	level.bombtimer = maps\mp\_utility::dvarintvalue("bombtimer",45,1,300);
	level.ddtimetoadd = maps\mp\_utility::dvarfloatvalue("addtime",2,0,5);
	level.silentplant = maps\mp\_utility::dvarintvalue("silentplant",0,0,1);
}

//Function Number: 15
verifybombzones(param_00)
{
	var_01 = "";
	if(param_00.size != 3)
	{
		var_02 = 0;
		var_03 = 0;
		var_04 = 0;
		foreach(var_06 in param_00)
		{
			if(issubstr(tolower(var_06.script_label),"a"))
			{
				var_02 = 1;
				continue;
			}

			if(issubstr(tolower(var_06.script_label),"b"))
			{
				var_03 = 1;
				continue;
			}

			if(issubstr(tolower(var_06.script_label),"c"))
			{
				var_04 = 1;
			}
		}

		if(!var_02)
		{
			var_01 = var_01 + " A ";
		}

		if(!var_03)
		{
			var_01 = var_01 + " B ";
		}

		if(!var_04)
		{
			var_01 = var_01 + " C ";
		}
	}

	if(var_01 != "")
	{
	}
}

//Function Number: 16
bombs()
{
	waittillframeend;
	level.bombplanted = 0;
	level.bombdefused = 0;
	level.bombexploded = 0;
	level.bombzones = [];
	var_00 = getentarray("dd_bombzone","targetname");
	verifybombzones(var_00);
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = var_00[var_01];
		var_03 = getentarray(var_02.target,"targetname");
		var_04 = getent(var_03[0].target,"targetname");
		var_05 = var_02.script_label;
		var_06 = getent("dd_bombzone_clip" + var_05,"targetname");
		if(maps\mp\_utility::inovertime())
		{
			if(var_05 == "_a" || var_05 == "_b")
			{
				var_02 delete();
				var_03[0] delete();
				var_04 delete();
				var_06 delete();
				continue;
			}

			var_02.script_label = "_a";
			var_07 = maps\mp\gametypes\common_bomb_gameobject::createbombzoneobject("neutral","any","any",var_02,level.ddbomb,0);
			maps\mp\_utility::setmlgicons(var_07,"waypoint_targetneutral");
		}
		else
		{
			if(var_05 == "_c")
			{
				var_02 delete();
				var_03[0] delete();
				var_04 delete();
				var_06 delete();
				continue;
			}

			var_07 = maps\mp\gametypes\common_bomb_gameobject::createbombzoneobject(game["defenders"],"enemy","any",var_02,level.ddbomb,1);
			if(game["defenders"] == "allies")
			{
				maps\mp\_utility::setmlgicons(var_07,"waypoint_esports_sab_target_axis");
			}
			else
			{
				maps\mp\_utility::setmlgicons(var_07,"waypoint_esports_sab_target_allies");
			}
		}

		var_07.onbeginuse = ::onbeginuse;
		var_07.onenduse = ::onenduse;
		var_07.onuse = ::onuseobject;
		var_07.oncantuse = ::oncantuse;
		level.bombzones[level.bombzones.size] = var_07;
	}
}

//Function Number: 17
onuseobject(param_00)
{
	var_01 = param_00.pers["team"];
	var_02 = level.otherteam[var_01];
	if((maps\mp\_utility::inovertime() && self.bombplantedon == 0) || !maps\mp\_utility::inovertime() && !maps\mp\gametypes\_gameobjects::isfriendlyteam(param_00.pers["team"]))
	{
		param_00 maps\mp\gametypes\common_bomb_gameobject::onplayerplantbomb(0,var_01,var_02);
		if(game["defenders"] == "allies")
		{
			maps\mp\_utility::setmlgicons(self,"waypoint_esports_sab_planted_axis");
		}
		else
		{
			maps\mp\_utility::setmlgicons(self,"waypoint_esports_sab_planted_allies");
		}

		level thread bombplanted(self,param_00);
		return;
	}

	param_00 maps\mp\gametypes\common_bomb_gameobject::onplayerdefusebomb("defuse",var_01,var_02);
	if(game["defenders"] == "allies")
	{
		maps\mp\_utility::setmlgicons(self,"waypoint_esports_sab_target_axis");
	}
	else
	{
		maps\mp\_utility::setmlgicons(self,"waypoint_esports_sab_target_allies");
	}

	level thread bombdefused(self);
}

//Function Number: 18
onbeginuse(param_00)
{
	if((maps\mp\_utility::inovertime() && self.bombplantedon == 1) || !maps\mp\_utility::inovertime() && maps\mp\gametypes\_gameobjects::isfriendlyteam(param_00.pers["team"]))
	{
		var_01 = param_00 getclosestbombmodel();
		maps\mp\gametypes\common_bomb_gameobject::onbegindefusebomb(param_00,var_01);
		return;
	}

	maps\mp\gametypes\common_bomb_gameobject::onbeginplantbomb(param_00);
}

//Function Number: 19
getclosestbombmodel()
{
	var_00 = 9000000;
	var_01 = undefined;
	if(isdefined(level.ddbombmodel))
	{
		foreach(var_03 in level.ddbombmodel)
		{
			if(!isdefined(var_03))
			{
				continue;
			}

			var_04 = distancesquared(self.origin,var_03.origin);
			if(var_04 < var_00)
			{
				var_00 = var_04;
				var_01 = var_03;
			}
		}
	}

	return var_01;
}

//Function Number: 20
onenduse(param_00,param_01,param_02)
{
	var_03 = isdefined(param_01) && param_01.isdefusing && !param_02;
	maps\mp\gametypes\common_bomb_gameobject::onendusebomb(param_01,var_03);
}

//Function Number: 21
oncantuse(param_00)
{
	param_00 iprintlnbold(&"MP_BOMBSITE_IN_USE");
}

//Function Number: 22
onreset()
{
}

//Function Number: 23
bombplanted(param_00,param_01)
{
	param_00 endon("defused");
	level.bombsplanted = level.bombsplanted + 1;
	var_02 = param_01.team;
	setbombtimerdvar();
	level.bombplanted = 1;
	if(param_00.label == "_a")
	{
		level.aplanted = 1;
	}
	else
	{
		level.bplanted = 1;
	}

	dropbombmodel(param_01,param_00.label);
	if(maps\mp\_utility::inovertime())
	{
		param_00 maps\mp\gametypes\_gameobjects::setownerteam(level.otherteam[param_01.team]);
	}

	param_00 maps\mp\gametypes\common_bomb_gameobject::setupzonefordefusing(!maps\mp\_utility::inovertime());
	param_00 maps\mp\gametypes\common_bomb_gameobject::onbombplanted(level.ddbombmodel[param_00.label].origin + (0,0,1));
	param_00 bombtimerwait(param_00);
	maps\mp\_utility::setmlgicons(param_00,undefined);
	param_00.tickingobject maps\mp\gametypes\common_bomb_gameobject::stoptickingsound();
	level.bombsplanted = level.bombsplanted - 1;
	if(param_00.label == "_a")
	{
		level.aplanted = 0;
	}
	else
	{
		level.bplanted = 0;
	}

	param_00 restarttimer();
	param_00 setbombtimerdvar();
	setuibombtimer(param_00.label,0);
	if(level.gameended)
	{
		return;
	}

	level notify("bomb_exploded" + param_00.label);
	level.bombexploded = level.bombexploded + 1;
	var_03 = param_00.curorigin;
	level.ddbombmodel[param_00.label] delete();
	param_00 maps\mp\gametypes\common_bomb_gameobject::onbombexploded(var_03,200,param_01);
	param_00 maps\mp\gametypes\_gameobjects::disableobject();
	var_04 = 0;
	if(!maps\mp\_utility::inovertime() && level.bombexploded < 2 && level.ddtimetoadd > 0)
	{
		var_05 = maps\mp\_utility::gettimelimit();
		if(var_05 > 0)
		{
			maps\mp\_utility::setoverridewatchdvar("timelimit",maps\mp\_utility::getwatcheddvar("timelimit") + level.ddtimetoadd);
			foreach(var_07 in level.players)
			{
				var_07 thread maps\mp\gametypes\_hud_message::splashnotify("time_added");
			}

			var_04 = 1;
		}
	}

	var_09 = maps\mp\_utility::inovertime() || level.bombexploded > 1;
	if(var_09)
	{
		setgameendtime(0);
		level.timelimitoverride = 1;
	}

	wait(2);
	if(var_09)
	{
		dd_endgame(var_02,game["end_reason"]["target_destroyed"]);
		return;
	}

	if(var_04)
	{
		level thread maps\mp\_utility::teamplayercardsplash("callout_time_added",param_01);
	}
}

//Function Number: 24
setbombtimerdvar()
{
	if(level.bombsplanted == 1)
	{
		setomnvar("ui_bomb_timer",2);
		return;
	}

	if(level.bombsplanted == 2)
	{
		setomnvar("ui_bomb_timer",3);
		return;
	}

	setomnvar("ui_bomb_timer",0);
}

//Function Number: 25
dropbombmodel(param_00,param_01)
{
	var_02 = bullettrace(param_00.origin + (0,0,20),param_00.origin - (0,0,2000),0,param_00);
	var_03 = randomfloat(360);
	var_04 = (cos(var_03),sin(var_03),0);
	var_04 = vectornormalize(var_04 - var_02["normal"] * vectordot(var_04,var_02["normal"]));
	var_05 = vectortoangles(var_04);
	level.ddbombmodel[param_01] = spawn("script_model",var_02["position"]);
	level.ddbombmodel[param_01].angles = var_05;
	level.ddbombmodel[param_01] setmodel("wpn_h1_briefcase_bomb_npc");
}

//Function Number: 26
restarttimer()
{
	if(level.bombsplanted <= 0)
	{
		maps\mp\gametypes\_gamelogic::resumetimer();
		level.timepaused = gettime() - level.timepausestart;
		level.timelimitoverride = 0;
	}
}

//Function Number: 27
bombtimerwait(param_00)
{
	level endon("game_ended");
	level endon("bomb_defused" + param_00.label);
	if(maps\mp\_utility::inovertime())
	{
		param_00.waittime = level.bombtimer;
	}
	else
	{
		param_00.waittime = level.bombtimer;
	}

	level thread update_ui_timers(param_00);
	while(param_00.waittime >= 0)
	{
		param_00.waittime--;
		if(param_00.waittime >= 0)
		{
			wait(1);
		}

		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	}
}

//Function Number: 28
update_ui_timers(param_00)
{
	level endon("game_ended");
	level endon("disconnect");
	level endon("bomb_defused" + param_00.label);
	level endon("bomb_exploded" + param_00.label);
	var_01 = param_00.waittime * 1000 + gettime();
	setuibombtimer(param_00.label,var_01);
	level waittill("host_migration_begin");
	var_02 = maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	if(var_02 > 0)
	{
		setuibombtimer(param_00.label,var_01 + var_02);
	}
}

//Function Number: 29
bombdefused(param_00)
{
	param_00.bombplantedon = 0;
	param_00 notify("defused");
	param_00.tickingobject maps\mp\gametypes\common_bomb_gameobject::stoptickingsound();
	level.bombsplanted = level.bombsplanted - 1;
	param_00 restarttimer();
	setbombtimerdvar();
	setuibombtimer(param_00.label,0);
	level notify("bomb_defused" + param_00.label);
	level.ddbombmodel[param_00.label] delete();
	if(maps\mp\_utility::inovertime())
	{
		param_00 maps\mp\gametypes\_gameobjects::setownerteam("neutral");
		param_00 maps\mp\gametypes\common_bomb_gameobject::resetbombzone(level.ddbomb,"any","any",0);
		return;
	}

	param_00 maps\mp\gametypes\common_bomb_gameobject::resetbombzone(level.ddbomb,"enemy","any",1);
}

//Function Number: 30
setuibombtimer(param_00,param_01)
{
	if(param_00 == "_a")
	{
		setomnvar("ui_bomb_timer_endtime",param_01);
		return;
	}

	setomnvar("ui_bomb_timer_endtime_2",param_01);
}