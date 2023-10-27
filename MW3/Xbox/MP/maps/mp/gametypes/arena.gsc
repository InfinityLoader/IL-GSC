/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\arena.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 25
 * Decompile Time: 384 ms
 * Timestamp: 10/27/2023 2:26:02 AM
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
	maps\mp\_utility::func_330E(level.gametype,0,0,9);
	maps\mp\_utility::func_3315(level.gametype,10,0,1440);
	maps\mp\_utility::registerscorelimitdvar(level.gametype,500,0,5000);
	maps\mp\_utility::func_3312(level.gametype,1,0,10);
	maps\mp\_utility::registerwinlimitdvar(level.gametype,1,0,10);
	maps\mp\_utility::func_330E(level.gametype,3,0,30);
	maps\mp\_utility::func_3317(level.gametype,0,0,10);
	maps\mp\_utility::registerhalftimedvar(level.gametype,0,0,1);
	level.teambased = 1;
	level.objectivebased = 1;
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onspawnplayer = ::onspawnplayer;
	level.onnormaldeath = ::onnormaldeath;
	level.onplayerkilled = ::onplayerkilled;
	level.ondeadevent = ::ondeadevent;
	game["dialog"]["gametype"] = "arena";
	if(getdvarint("g_hardcore"))
	{
		game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
	}
	else if(getdvarint("camera_thirdPerson"))
	{
		game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
	}
	else if(getdvarint("scr_diehard"))
	{
		game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
	}

	game["strings"]["overtime_hint"] = &"MP_FIRST_BLOOD";
}

//Function Number: 2
onprecachegametype()
{
	precacheshader("compass_waypoint_captureneutral");
	precacheshader("compass_waypoint_capture");
	precacheshader("compass_waypoint_defend");
	precacheshader("waypoint_captureneutral");
	precacheshader("waypoint_capture");
	precacheshader("waypoint_defend");
}

//Function Number: 3
onstartgametype()
{
	setclientnamemode("auto_change");
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

	maps\mp\_utility::func_3305("allies",&"OBJECTIVES_ARENA");
	maps\mp\_utility::func_3305("axis",&"OBJECTIVES_ARENA");
	if(level.splitscreen)
	{
		maps\mp\_utility::func_3306("allies",&"OBJECTIVES_ARENA");
		maps\mp\_utility::func_3306("axis",&"OBJECTIVES_ARENA");
	}
	else
	{
		maps\mp\_utility::func_3306("allies",&"OBJECTIVES_ARENA_SCORE");
		maps\mp\_utility::func_3306("axis",&"OBJECTIVES_ARENA_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_ARENA_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_ARENA_HINT");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_tdm_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_tdm_spawn_axis_start");
	maps\mp\gametypes\_spawnlogic::func_2FD0("allies","mp_tdm_spawn");
	maps\mp\gametypes\_spawnlogic::func_2FD0("axis","mp_tdm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::func_2FCD(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	var_02[0] = "dom";
	maps\mp\gametypes\_rank::registerscoreinfo("capture",200);
	maps\mp\gametypes\_gameobjects::main(var_41);
	precacheflag();
	thread func_3583();
	thread arenatimeflagwaiter();
}

//Function Number: 4
precacheflag()
{
	game["flagmodels"] = [];
	game["flagmodels"]["neutral"] = "prop_flag_neutral";
	game["flagmodels"]["allies"] = maps\mp\gametypes\_teams::func_2774("allies");
	game["flagmodels"]["axis"] = maps\mp\gametypes\_teams::func_2774("axis");
	precachemodel(game["flagmodels"]["neutral"]);
	precachemodel(game["flagmodels"]["allies"]);
	precachemodel(game["flagmodels"]["axis"]);
	precachestring(&"MP_CAPTURING_FLAG");
	precachestring(&"MP_LOSING_FLAG");
	precachestring(&"MP_DOM_YOUR_FLAG_WAS_CAPTURED");
	precachestring(&"MP_DOM_ENEMY_FLAG_CAPTURED");
	precachestring(&"MP_DOM_NEUTRAL_FLAG_CAPTURED");
	precachestring(&"MP_ENEMY_FLAG_CAPTURED_BY");
	precachestring(&"MP_NEUTRAL_FLAG_CAPTURED_BY");
	precachestring(&"MP_FRIENDLY_FLAG_CAPTURED_BY");
}

//Function Number: 5
arenatimeflagwaiter()
{
	level endon("down_to_one");
	level endon("game_end");
	for(;;)
	{
		var_00 = maps\mp\gametypes\_gamelogic::func_2F0C();
		if(var_00 < -4536)
		{
			break;
		}

		wait 1;
	}

	level notify("arena_flag_time");
	thread arenaflag();
}

//Function Number: 6
func_3583()
{
	level endon("game_end");
	level endon("arena_flag_time");
	for(;;)
	{
		if(level.ingraceperiod == 0)
		{
			break;
		}

		wait 0.05;
	}

	for(;;)
	{
		if(getteamplayersalive("axis") == 1)
		{
			thread arenaflag();
			level notify("down_to_one");
			break;
		}

		if(getteamplayersalive("allies") == 1)
		{
			thread arenaflag();
			level notify("down_to_one");
			break;
		}

		wait 1;
	}
}

//Function Number: 7
getspawnpoint()
{
	var_00 = self.pers["team"];
	if(game["switchedsides"])
	{
		var_00 = maps\mp\_utility::getotherteam(var_00);
	}

	if(level.ingraceperiod)
	{
		var_01 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_tdm_spawn_" + var_00 + "_start");
		var_02 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(var_01);
	}
	else
	{
		var_01 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_02);
		var_02 = maps\mp\gametypes\_spawnlogic::func_2FE6(var_02);
	}

	return var_02;
}

//Function Number: 8
onspawnplayer()
{
	self.usingobj = undefined;
	level notify("spawned_player");
}

//Function Number: 9
onnormaldeath(param_00,param_01,param_02)
{
	var_03 = maps\mp\gametypes\_rank::getscoreinfovalue("kill");
	param_01 maps\mp\gametypes\_gamescore::giveteamscoreforobjective(param_01.pers["team"],var_03);
	var_04 = param_00.team;
	if(game["state"] == "postgame")
	{
		param_01.finalkill = 1;
	}
}

//Function Number: 10
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	thread checkallowspectating();
}

//Function Number: 11
ontimelimit()
{
	if(game["status"] == "overtime")
	{
		var_00 = "forfeit";
	}
	else if(game["teamScores"]["allies"] == game["teamScores"]["axis"])
	{
		var_00 = "overtime";
	}
	else if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
	{
		var_00 = "axis";
	}
	else
	{
		var_00 = "allies";
	}

	thread maps\mp\gametypes\_gamelogic::endgame(var_00,game["strings"]["time_limit_reached"]);
}

//Function Number: 12
checkallowspectating()
{
	wait 0.05;
	var_00 = 0;
	if(!level.alivecount[game["attackers"]])
	{
		level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
		var_00 = 1;
	}

	if(!level.alivecount[game["defenders"]])
	{
		level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
		var_00 = 1;
	}

	if(var_00)
	{
		maps\mp\gametypes\_spectating::updatespectatesettings();
	}
}

//Function Number: 13
arenaflag()
{
	level.laststatus["allies"] = 0;
	level.laststatus["axis"] = 0;
	var_00 = getentarray("flag_arena","targetname");
	var_01 = getentarray("flag_primary","targetname");
	var_02 = getentarray("flag_secondary","targetname");
	if(!isdefined(var_00[0]))
	{
		if(var_01.size + var_02.size < 1)
		{
			maps\mp\gametypes\_callbacksetup::abortlevel();
			return;
		}

		func_3585(var_01,var_02);
	}
	else
	{
		level.arenaflag = var_00[0];
	}

	var_03 = level.arenaflag;
	if(isdefined(var_03.target))
	{
		var_04[0] = getent(var_03.target,"targetname");
	}
	else
	{
		var_00[0] = spawn("script_model",var_04.origin);
		var_04[0].angles = var_03.angles;
	}

	var_04[0] setmodel(game["flagmodels"]["neutral"]);
	var_00 = maps\mp\gametypes\_gameobjects::func_29E7("neutral",var_03,var_04,(0,0,100));
	var_00 maps\mp\gametypes\_gameobjects::allowuse("enemy");
	var_00 maps\mp\gametypes\_gameobjects::setusetime(20);
	var_00 maps\mp\gametypes\_gameobjects::setusetext(&"MP_CAPTURING_FLAG");
	var_05 = var_00 maps\mp\gametypes\_gameobjects::getlabel();
	var_00.label = var_05;
	var_00 maps\mp\gametypes\_gameobjects::set2dicon("friendly","compass_waypoint_defend");
	var_00 maps\mp\gametypes\_gameobjects::func_2A25("friendly","waypoint_defend");
	var_00 maps\mp\gametypes\_gameobjects::set2dicon("enemy","compass_waypoint_captureneutral");
	var_00 maps\mp\gametypes\_gameobjects::func_2A25("enemy","waypoint_captureneutral");
	var_00 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	var_00.onuse = ::onuse;
	var_00.onbeginuse = ::onbeginuse;
	var_00.onuseupdate = ::onuseupdate;
	var_00.onenduse = ::onenduse;
	var_00.isarena = 1;
	iprintlnbold("Arena flag spawned");
	level.arenaflag playsound("flag_spawned");
	var_06 = var_04[0].origin + (0,0,32);
	var_07 = var_04[0].origin + (0,0,-32);
	var_08 = bullettrace(var_06,var_07,0,undefined);
	var_09 = vectortoangles(var_08["normal"]);
	var_00.baseeffectforward = anglestoforward(var_09);
	var_00.baseeffectright = anglestoright(var_09);
	var_00.baseeffectpos = var_08["position"];
	var_00.levelflag = level.arenaflag;
	level.arenaflag = var_00;
}

//Function Number: 14
func_3585(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_03 = param_00[var_02].script_label;
		if(var_03 != "_b")
		{
			param_00[var_02] delete();
			continue;
		}

		level.arenaflag = param_00[var_02];
		return;
	}
}

//Function Number: 15
ondeadevent(param_00)
{
	if(param_00 == game["attackers"])
	{
		level thread func_3586(game["defenders"],game["strings"][game["attackers"] + "_eliminated"]);
		return;
	}

	if(param_00 == game["defenders"])
	{
		level thread func_3586(game["attackers"],game["strings"][game["defenders"] + "_eliminated"]);
	}
}

//Function Number: 16
func_3586(param_00,param_01)
{
	thread maps\mp\gametypes\_gamelogic::endgame(param_00,param_01);
}

//Function Number: 17
func_346E(param_00)
{
	level endon("game_ended");
	wait 0.05;
	maps\mp\_utility::waittillslowprocessallowed();
	var_01 = getarraykeys(param_00);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = param_00[var_01[var_02]].player;
		var_03 thread [[ level.onxpevent ]]("capture");
		maps\mp\gametypes\_gamescore::func_26D3("capture",var_03);
		var_03 thread maps\mp\_matchdata::loggameevent("capture",var_03.origin);
	}
}

//Function Number: 18
onuse(param_00)
{
	var_01 = param_00.pers["team"];
	var_02 = maps\mp\gametypes\_gameobjects::func_2A15();
	var_03 = maps\mp\gametypes\_gameobjects::getlabel();
	self.capturetime = gettime();
	maps\mp\gametypes\_gameobjects::setownerteam(var_01);
	maps\mp\gametypes\_gameobjects::set2dicon("enemy","compass_waypoint_capture");
	maps\mp\gametypes\_gameobjects::func_2A25("enemy","waypoint_capture");
	self.visuals[0] setmodel(game["flagmodels"][var_01]);
	if(var_02 == "neutral")
	{
		var_04 = maps\mp\_utility::getotherteam(var_01);
		thread maps\mp\_utility::func_32F9(var_01,var_04,&"MP_NEUTRAL_FLAG_CAPTURED_BY",&"MP_NEUTRAL_FLAG_CAPTURED_BY","mp_war_objective_taken",undefined,param_00);
		statusdialog("captured_a",var_01);
		statusdialog("enemy_has_a",var_04);
	}
	else
	{
		thread maps\mp\_utility::func_32F9(var_01,var_02,&"MP_ENEMY_FLAG_CAPTURED_BY",&"MP_FRIENDLY_FLAG_CAPTURED_BY","mp_war_objective_taken","mp_war_objective_lost",param_00);
	}

	thread func_346E(self.touchlist[var_01]);
	param_00 notify("objective","captured");
	thread flagcaptured(var_01,&"MP_DOM_NEUTRAL_FLAG_CAPTURED");
}

//Function Number: 19
onbeginuse(param_00)
{
	var_01 = maps\mp\gametypes\_gameobjects::func_2A15();
	self.didstatusnotify = 0;
	if(var_01 == "neutral")
	{
		var_02 = maps\mp\_utility::getotherteam(param_00.pers["team"]);
		statusdialog("securing",param_00.pers["team"]);
		self.objpoints[param_00.pers["team"]] thread maps\mp\gametypes\_objpoints::startflashing();
		statusdialog("enemy_taking",var_02);
		return;
	}

	if(var_02 == "allies")
	{
		var_02 = "axis";
	}
	else
	{
		var_02 = "allies";
	}

	self.objpoints["allies"] thread maps\mp\gametypes\_objpoints::startflashing();
	self.objpoints["axis"] thread maps\mp\gametypes\_objpoints::startflashing();
}

//Function Number: 20
onuseupdate(param_00,param_01,param_02)
{
	if(param_01 > 0.05 && param_02 && !self.didstatusnotify)
	{
		var_03 = maps\mp\_utility::getotherteam(param_00);
		statusdialog("losing_a",var_03);
		statusdialog("securing_a",param_00);
		self.didstatusnotify = 1;
	}
}

//Function Number: 21
onenduse(param_00,param_01,param_02)
{
	self.objpoints["allies"] thread maps\mp\gametypes\_objpoints::stopflashing();
	self.objpoints["axis"] thread maps\mp\gametypes\_objpoints::stopflashing();
}

//Function Number: 22
statusdialog(param_00,param_01)
{
	var_02 = gettime();
	if(gettime() < level.laststatus[param_01] + 6000)
	{
		return;
	}

	thread func_346F(param_00,param_01);
	level.laststatus[param_01] = gettime();
}

//Function Number: 23
func_346F(param_00,param_01)
{
	level endon("game_ended");
	wait 0.1;
	maps\mp\_utility::waittillslowprocessallowed();
	maps\mp\_utility::func_26E5(param_00,param_01);
}

//Function Number: 24
func_3470(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	wait 0.1;
	maps\mp\_utility::waittillslowprocessallowed();
	maps\mp\_utility::leaderdialogbothteams(param_00,param_01,param_02,param_03);
}

//Function Number: 25
flagcaptured(param_00,param_01)
{
	maps\mp\gametypes\_gamelogic::endgame(param_00,param_01);
}