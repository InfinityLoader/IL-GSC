/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\gtnw.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 21
 * Decompile Time: 296 ms
 * Timestamp: 10/27/2023 2:26:12 AM
*******************************************************************/

//Function Number: 1
main()
{
	maps\mp\gametypes\_globallogic::init();
	maps\mp\gametypes\_callbacksetup::setupcallbacks();
	maps\mp\gametypes\_globallogic::setupcallbacks();
	maps\mp\_utility::func_3315(level.gametype,3,0,1440);
	maps\mp\_utility::registerscorelimitdvar(level.gametype,101,0,10000);
	maps\mp\_utility::func_3312(level.gametype,1,0,30);
	maps\mp\_utility::registerwinlimitdvar(level.gametype,1,0,10);
	maps\mp\_utility::func_330E(level.gametype,0,0,30);
	maps\mp\_utility::func_3317(level.gametype,0,0,10);
	maps\mp\_utility::registerhalftimedvar(level.gametype,0,0,1);
	level.teambased = 1;
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.ondeadevent = ::ondeadevent;
	level.initgametypeawards = ::initgametypeawards;
	level.ontimelimit = ::ontimelimit;
	level.onnormaldeath = ::onnormaldeath;
	level.gtnw = 1;
	game["dialog"]["gametype"] = "gtw";
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
	else if(getdvarint("scr_" + level.gametype + "_promode"))
	{
		game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
	}

	game["dialog"]["offense_obj"] = "obj_destroy";
	game["dialog"]["defense_obj"] = "obj_defend";
	level thread onplayerconnect();
}

//Function Number: 2
func_35AC(param_00,param_01)
{
	thread maps\mp\gametypes\_gamelogic::endgame(param_00,param_01);
}

//Function Number: 3
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_01 = var_00 maps\mp\gametypes\_hud_util::createprimaryprogressbar();
		var_02 = var_00 maps\mp\gametypes\_hud_util::createprimaryprogressbartext();
		var_02 settext(&"MP_CAPTURING_NUKE");
		var_01.usetime = 100;
		var_00.usebar = var_01;
		var_00.usebar maps\mp\gametypes\_hud_util::hideelem();
		var_00.usebartext = var_02;
		var_00.usebartext maps\mp\gametypes\_hud_util::hideelem();
	}
}

//Function Number: 4
onstartgametype()
{
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	if(!isdefined(game["original_defenders"]))
	{
		game["original_defenders"] = game["defenders"];
	}

	if(game["switchedsides"])
	{
		var_00 = game["attackers"];
		var_01 = game["defenders"];
		game["attackers"] = var_01;
		game["defenders"] = var_00;
	}

	setclientnamemode("auto_change");
	if(level.splitscreen)
	{
		maps\mp\_utility::func_3306(game["attackers"],&"OBJECTIVES_GTNW");
		maps\mp\_utility::func_3306(game["defenders"],&"OBJECTIVES_GTNW");
	}
	else
	{
		maps\mp\_utility::func_3306(game["attackers"],&"OBJECTIVES_GTNW_SCORE");
		maps\mp\_utility::func_3306(game["defenders"],&"OBJECTIVES_GTNW_SCORE");
	}

	maps\mp\_utility::func_3305(game["attackers"],&"OBJECTIVES_GTNW");
	maps\mp\_utility::func_3305(game["defenders"],&"OBJECTIVES_GTNW");
	maps\mp\_utility::setobjectivehinttext(game["attackers"],&"OBJECTIVES_GTNW_HINT");
	maps\mp\_utility::setobjectivehinttext(game["defenders"],&"OBJECTIVES_GTNW_HINT");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_ctf_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_ctf_spawn_axis_start");
	maps\mp\gametypes\_spawnlogic::func_2FD0("allies","mp_ctf_spawn_allies");
	maps\mp\gametypes\_spawnlogic::func_2FD0("axis","mp_ctf_spawn_axis");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::func_2FCD(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	maps\mp\gametypes\_rank::registerscoreinfo("kill",50);
	maps\mp\gametypes\_rank::registerscoreinfo("headshot",100);
	maps\mp\gametypes\_rank::registerscoreinfo("assist",20);
	maps\mp\gametypes\_rank::registerscoreinfo("capture",500);
	var_02[0] = "airdrop_pallet";
	maps\mp\gametypes\_gameobjects::main(var_41);
	thread setupnukesite();
}

//Function Number: 5
onprecachegametype()
{
	precacheshader("waypoint_defend");
	precacheshader("waypoint_target");
	precacheshader("waypoint_capture");
	precacheshader("compass_waypoint_target");
	precacheshader("compass_waypoint_defend");
	precacheshader("compass_waypoint_capture");
	precachestring(&"MP_CAPTURING_NUKE");
}

//Function Number: 6
setupnukesite()
{
	level.laststatus["allies"] = 0;
	level.laststatus["axis"] = 0;
	var_00 = getent("gtnw_zone","targetname");
	var_01 = [];
	var_02 = maps\mp\gametypes\_gameobjects::func_29E7("neutral",var_00,var_01,(0,0,100));
	var_02 maps\mp\gametypes\_gameobjects::set2dicon("friendly","compass_waypoint_defend");
	var_02 maps\mp\gametypes\_gameobjects::func_2A25("friendly","waypoint_defend");
	var_02 maps\mp\gametypes\_gameobjects::set2dicon("enemy","compass_waypoint_captureneutral");
	var_02 maps\mp\gametypes\_gameobjects::func_2A25("enemy","waypoint_captureneutral");
	var_02 maps\mp\gametypes\_gameobjects::allowuse("enemy");
	var_02.nousebar = 1;
	var_02 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	var_02.onbeginuse = ::onbeginuse;
	var_02.onenduse = ::onenduse;
	level.nukesite = var_02;
	var_02 thread scorecounter();
}

//Function Number: 7
getspawnpoint()
{
	if(self.team == "axis")
	{
		var_00 = game["attackers"];
	}
	else
	{
		var_00 = game["defenders"];
	}

	if(level.ingraceperiod)
	{
		var_01 = getentarray("mp_ctf_spawn_" + var_00 + "_start","classname");
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
func_3084(param_00,param_01,param_02,param_03,param_04)
{
	wait param_04;
	var_05 = spawnfx(param_00,param_01,param_02,param_03);
	triggerfx(var_05);
}

//Function Number: 9
ondeadevent(param_00)
{
	if((isdefined(level.nukeincoming) && level.nukeincoming) || isdefined(level.nukedetonated) && level.nukedetonated)
	{
		return;
	}

	if(param_00 == game["attackers"])
	{
		maps\mp\gametypes\_gamescore::giveteamscoreforobjective(param_00,1);
		level thread func_35AC(game["defenders"],game["strings"][game["attackers"] + "_eliminated"]);
		return;
	}

	if(param_00 == game["defenders"])
	{
		maps\mp\gametypes\_gamescore::giveteamscoreforobjective(param_00,1);
		level thread func_35AC(game["attackers"],game["strings"][game["defenders"] + "_eliminated"]);
	}
}

//Function Number: 10
initgametypeawards()
{
}

//Function Number: 11
ontimelimit()
{
	if(game["teamScores"]["allies"] == game["teamScores"]["axis"])
	{
		level thread func_34AE();
		return;
	}

	if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
	{
		thread maps\mp\gametypes\_gamelogic::endgame("axis",game["strings"]["time_limit_reached"]);
		return;
	}

	if(game["teamScores"]["axis"] < game["teamScores"]["allies"])
	{
		thread maps\mp\gametypes\_gamelogic::endgame("allies",game["strings"]["time_limit_reached"]);
		return;
	}
}

//Function Number: 12
func_34AE(param_00)
{
	level endon("game_ended");
	level.inovertime = 1;
	level thread disablespawning(5);
	level.endgametime = 120;
	param_00 = level.endgametime;
	foreach(var_02 in level.players)
	{
		var_02 thread maps\mp\gametypes\_hud_message::func_2892("gtnw_overtime");
	}

	maps\mp\gametypes\_gamelogic::pausetimer();
	level.timelimitoverride = 1;
	setgameendtime(int(gettime() + level.endgametime * 1000));
	maps\mp\gametypes\_hostmigration::waitlongdurationwithgameendtimeupdate(param_00);
	if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
	{
		thread maps\mp\gametypes\_gamelogic::endgame("axis",game["strings"]["time_limit_reached"]);
		return;
	}

	if(game["teamScores"]["axis"] < game["teamScores"]["allies"])
	{
		thread maps\mp\gametypes\_gamelogic::endgame("allies",game["strings"]["time_limit_reached"]);
		return;
	}

	thread maps\mp\gametypes\_gamelogic::endgame("tie",game["strings"]["time_limit_reached"]);
}

//Function Number: 13
disablespawning(param_00)
{
	level endon("game_ended");
	wait 5;
	level.disablespawning = 1;
}

//Function Number: 14
onbeginuse(param_00)
{
	param_00.usebar maps\mp\gametypes\_hud_util::func_26BD();
	param_00.usebartext maps\mp\gametypes\_hud_util::func_26BD();
}

//Function Number: 15
onenduse(param_00,param_01,param_02)
{
	param_01.usebar maps\mp\gametypes\_hud_util::hideelem();
	param_01.usebartext maps\mp\gametypes\_hud_util::hideelem();
}

//Function Number: 16
scorecounter()
{
	level endon("game_ended");
	self endon("stop_counting");
	for(;;)
	{
		if(!self.touchlist["axis"].size && !self.touchlist["allies"].size)
		{
			setdvar("ui_danger_team","none");
			maps\mp\gametypes\_gameobjects::set2dicon("enemy","compass_waypoint_captureneutral");
			maps\mp\gametypes\_gameobjects::func_2A25("enemy","waypoint_captureneutral");
			maps\mp\gametypes\_gameobjects::setownerteam("none");
			func_35B5();
			wait 1;
			continue;
		}

		maps\mp\gametypes\_gameobjects::set2dicon("friendly","compass_waypoint_defend");
		maps\mp\gametypes\_gameobjects::func_2A25("friendly","waypoint_defend");
		maps\mp\gametypes\_gameobjects::set2dicon("enemy","compass_waypoint_capture");
		maps\mp\gametypes\_gameobjects::func_2A25("enemy","waypoint_capture");
		if(self.touchlist["axis"].size > self.touchlist["allies"].size)
		{
			if(maps\mp\gametypes\_gamescore::func_26EE("axis") < 100)
			{
				maps\mp\gametypes\_gamescore::giveteamscoreforobjective("axis",1);
			}

			thread func_35B4("axis");
			setdvar("ui_danger_team","allies");
			maps\mp\gametypes\_gameobjects::setownerteam("axis");
			if(maps\mp\gametypes\_gamescore::func_26EE("axis") >= 100)
			{
				maps\mp\gametypes\_gameobjects::allowuse("none");
				func_35B3("axis");
				self notify("stop_counting");
			}
		}
		else if(self.touchlist["axis"].size < self.touchlist["allies"].size)
		{
			if(maps\mp\gametypes\_gamescore::func_26EE("allies") < 100)
			{
				maps\mp\gametypes\_gamescore::giveteamscoreforobjective("allies",1);
			}

			thread func_35B4("allies");
			setdvar("ui_danger_team","axis");
			maps\mp\gametypes\_gameobjects::setownerteam("allies");
			if(maps\mp\gametypes\_gamescore::func_26EE("allies") >= 100)
			{
				maps\mp\gametypes\_gameobjects::allowuse("none");
				func_35B3("allies");
				self notify("stop_counting");
			}
		}
		else
		{
			maps\mp\gametypes\_gameobjects::set2dicon("enemy","compass_waypoint_captureneutral");
			maps\mp\gametypes\_gameobjects::func_2A25("enemy","waypoint_captureneutral");
			maps\mp\gametypes\_gameobjects::setownerteam("none");
			setdvar("ui_danger_team","contested");
		}

		func_35B5();
		wait 1;
	}
}

//Function Number: 17
func_35B3(param_00)
{
	func_346E(self.touchlist[param_00]);
	maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	maps\mp\gametypes\_gameobjects::allowuse("none");
	var_01 = 99999999;
	var_02 = undefined;
	foreach(var_04 in level.players)
	{
		if(!isdefined(var_04))
		{
			continue;
		}

		var_04.usebar maps\mp\gametypes\_hud_util::hideelem();
		var_04.usebartext maps\mp\gametypes\_hud_util::hideelem();
		if(var_04.team != param_00)
		{
			continue;
		}

		if(!isdefined(self.touchlist[param_00][var_04.guid]))
		{
			continue;
		}

		var_05 = self.touchlist[param_00][var_04.guid].starttime;
		if(var_05 < var_01)
		{
			var_02 = var_04;
			var_01 = var_05;
		}
	}

	var_02 maps\mp\killstreaks\_nuke::tryusenuke(1);
}

//Function Number: 18
func_346E(param_00)
{
	level endon("game_ended");
	wait 0.05;
	maps\mp\_utility::waittillslowprocessallowed();
	var_01 = getarraykeys(param_00);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = param_00[var_01[var_02]].player;
		var_03 thread maps\mp\gametypes\_hud_message::func_2892("captured_nuke",maps\mp\gametypes\_rank::getscoreinfovalue("capture"));
		var_03 thread [[ level.onxpevent ]]("capture");
		maps\mp\gametypes\_gamescore::func_26D3("capture",var_03);
	}
}

//Function Number: 19
func_35B4(param_00)
{
	var_01 = getteamscore(param_00);
	foreach(var_03 in level.players)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		if(var_03.team != param_00)
		{
			continue;
		}

		if(!isdefined(self.touchlist[param_00][var_03.guid]))
		{
			continue;
		}

		var_03.usebar maps\mp\gametypes\_hud_util::updatebar(var_01 / 100,0);
	}
}

//Function Number: 20
func_35B5()
{
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		if(!isdefined(self.touchlist["axis"][var_01.guid]) && !isdefined(self.touchlist["allies"][var_01.guid]))
		{
			var_01.usebar maps\mp\gametypes\_hud_util::hideelem();
			var_01.usebartext maps\mp\gametypes\_hud_util::hideelem();
		}

		if(isdefined(self.touchlist["axis"][var_01.guid]) || isdefined(self.touchlist["allies"][var_01.guid]))
		{
			var_01.usebar maps\mp\gametypes\_hud_util::func_26BD();
			var_01.usebartext maps\mp\gametypes\_hud_util::func_26BD();
		}
	}
}

//Function Number: 21
onnormaldeath(param_00,param_01,param_02)
{
	if(!isdefined(level.inovertime) || !level.inovertime)
	{
		return;
	}

	var_03 = param_00.team;
	if(game["state"] == "postgame")
	{
		param_01.finalkill = 1;
	}
}