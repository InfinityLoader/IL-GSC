/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\dom.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 31
 * Decompile Time: 439 ms
 * Timestamp: 10/27/2023 2:26:09 AM
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
		level thread maps\mp\_utility::func_810A();
	}
	else
	{
		maps\mp\_utility::func_3315(level.gametype,30);
		maps\mp\_utility::registerscorelimitdvar(level.gametype,300);
		maps\mp\_utility::func_3312(level.gametype,1);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,1);
		maps\mp\_utility::func_3317(level.gametype,0);
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	level.teambased = 1;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onplayerkilled = ::onplayerkilled;
	level.onprecachegametype = ::onprecachegametype;
	level.initgametypeawards = ::initgametypeawards;
	level.onspawnplayer = ::onspawnplayer;
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::func_2D57;
	}

	game["dialog"]["gametype"] = "domination";
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

	game["dialog"]["offense_obj"] = "capture_objs";
	game["dialog"]["defense_obj"] = "capture_objs";
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::func_334C();
	setdynamicdvar("scr_dom_roundlimit",1);
	maps\mp\_utility::func_3312("dom",1);
	setdynamicdvar("scr_dom_winlimit",1);
	maps\mp\_utility::registerwinlimitdvar("dom",1);
	setdynamicdvar("scr_dom_halftime",0);
	maps\mp\_utility::registerhalftimedvar("dom",0);
	setdynamicdvar("scr_dom_promode",0);
}

//Function Number: 3
onprecachegametype()
{
	precacheshader("waypoint_captureneutral");
	precacheshader("waypoint_capture");
	precacheshader("waypoint_defend");
	precacheshader("waypoint_captureneutral_a");
	precacheshader("waypoint_capture_a");
	precacheshader("waypoint_defend_a");
	precacheshader("waypoint_captureneutral_b");
	precacheshader("waypoint_capture_b");
	precacheshader("waypoint_defend_b");
	precacheshader("waypoint_captureneutral_c");
	precacheshader("waypoint_capture_c");
	precacheshader("waypoint_defend_c");
	precacheshader("waypoint_captureneutral");
	precacheshader("waypoint_capture");
	precacheshader("waypoint_defend");
	precacheshader("waypoint_captureneutral_a");
	precacheshader("waypoint_capture_a");
	precacheshader("waypoint_defend_a");
	precacheshader("waypoint_captureneutral_b");
	precacheshader("waypoint_capture_b");
	precacheshader("waypoint_defend_b");
	precacheshader("waypoint_captureneutral_c");
	precacheshader("waypoint_capture_c");
	precacheshader("waypoint_defend_c");
}

//Function Number: 4
onstartgametype()
{
	maps\mp\_utility::func_3305("allies",&"OBJECTIVES_DOM");
	maps\mp\_utility::func_3305("axis",&"OBJECTIVES_DOM");
	if(level.splitscreen)
	{
		maps\mp\_utility::func_3306("allies",&"OBJECTIVES_DOM");
		maps\mp\_utility::func_3306("axis",&"OBJECTIVES_DOM");
	}
	else
	{
		maps\mp\_utility::func_3306("allies",&"OBJECTIVES_DOM_SCORE");
		maps\mp\_utility::func_3306("axis",&"OBJECTIVES_DOM_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_DOM_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_DOM_HINT");
	setclientnamemode("auto_change");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_dom_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_dom_spawn_axis_start");
	maps\mp\gametypes\_spawnlogic::func_2FD0("allies","mp_dom_spawn");
	maps\mp\gametypes\_spawnlogic::func_2FD0("axis","mp_dom_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::func_2FCD(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	level.spawn_all = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dom_spawn");
	level.spawn_axis_start = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dom_spawn_axis_start");
	level.spawn_allies_start = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dom_spawn_allies_start");
	level.startpos["allies"] = level.spawn_allies_start[0].origin;
	level.startpos["axis"] = level.spawn_axis_start[0].origin;
	level.flagbasefxid["allies"] = loadfx(maps\mp\gametypes\_teams::func_2777("allies"));
	level.flagbasefxid["axis"] = loadfx(maps\mp\gametypes\_teams::func_2777("axis"));
	var_00[0] = "dom";
	maps\mp\gametypes\_gameobjects::main(var_00);
	maps\mp\gametypes\_rank::registerscoreinfo("kill",50);
	maps\mp\gametypes\_rank::registerscoreinfo("headshot",50);
	maps\mp\gametypes\_rank::registerscoreinfo("assist",10);
	maps\mp\gametypes\_rank::registerscoreinfo("capture",150);
	maps\mp\gametypes\_rank::registerscoreinfo("defend",50);
	maps\mp\gametypes\_rank::registerscoreinfo("defend_assist",10);
	maps\mp\gametypes\_rank::registerscoreinfo("assault",50);
	maps\mp\gametypes\_rank::registerscoreinfo("assault_assist",10);
	thread domflags();
	thread func_3471();
}

//Function Number: 5
getspawnpoint()
{
	var_00 = undefined;
	if(!level.usestartspawns)
	{
		var_01 = 0;
		var_02 = 0;
		var_03 = self.pers["team"];
		var_04 = maps\mp\_utility::getotherteam(var_03);
		for(var_05 = 0;var_05 < level.flags.size;var_05++)
		{
			var_06 = level.flags[var_05] func_3474();
			if(var_06 == var_03)
			{
				var_01++;
				continue;
			}

			if(var_06 == var_04)
			{
				var_02++;
			}
		}

		if(var_01 == level.flags.size)
		{
			var_07 = level.bestspawnflag[maps\mp\_utility::getotherteam(self.pers["team"])];
			var_00 = maps\mp\gametypes\_spawnlogic::func_2FE6(level.spawn_all,func_3477(var_07));
		}
		else if(var_01 > 0)
		{
			var_00 = maps\mp\gametypes\_spawnlogic::func_2FE6(level.spawn_all,getboundaryflagspawns(var_03));
		}
		else
		{
			var_08 = undefined;
			if(var_02 > 0 && var_02 < level.flags.size)
			{
				var_08 = getunownedflagneareststart(var_03);
			}

			if(!isdefined(var_08))
			{
				var_08 = level.bestspawnflag[self.pers["team"]];
			}

			level.bestspawnflag[self.pers["team"]] = var_08;
			var_00 = maps\mp\gametypes\_spawnlogic::func_2FE6(level.spawn_all,var_08.nearbyspawns);
		}
	}

	if(!isdefined(var_00))
	{
		if(self.pers["team"] == "axis")
		{
			var_00 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(level.spawn_axis_start);
		}
		else
		{
			var_00 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(level.spawn_allies_start);
		}
	}

	return var_00;
}

//Function Number: 6
domflags()
{
	level.laststatus["allies"] = 0;
	level.laststatus["axis"] = 0;
	game["flagmodels"] = [];
	game["flagmodels"]["neutral"] = "prop_flag_neutral";
	game["flagmodels"]["allies"] = maps\mp\gametypes\_teams::func_2774("allies");
	game["flagmodels"]["axis"] = maps\mp\gametypes\_teams::func_2774("axis");
	precachemodel(game["flagmodels"]["neutral"]);
	precachemodel(game["flagmodels"]["allies"]);
	precachemodel(game["flagmodels"]["axis"]);
	precachestring(&"MP_SECURING_POSITION");
	var_00 = getentarray("flag_primary","targetname");
	var_01 = getentarray("flag_secondary","targetname");
	if(var_00.size + var_01.size < 2)
	{
		maps\mp\gametypes\_callbacksetup::abortlevel();
		return;
	}

	level.flags = [];
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		level.flags[level.flags.size] = var_00[var_02];
	}

	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		level.flags[level.flags.size] = var_01[var_02];
	}

	level.domflags = [];
	for(var_02 = 0;var_02 < level.flags.size;var_02++)
	{
		var_03 = level.flags[var_02];
		if(isdefined(var_03.target))
		{
			var_04[0] = getent(var_03.target,"targetname");
		}
		else
		{
			var_04[0] = spawn("script_model",var_03.origin);
			var_04[0].angles = var_03.angles;
		}

		var_04[0] setmodel(game["flagmodels"]["neutral"]);
		var_05 = maps\mp\gametypes\_gameobjects::func_29E7("neutral",var_03,var_04,(0,0,100));
		var_05 maps\mp\gametypes\_gameobjects::allowuse("enemy");
		var_05 maps\mp\gametypes\_gameobjects::setusetime(10);
		var_05 maps\mp\gametypes\_gameobjects::setusetext(&"MP_SECURING_POSITION");
		var_06 = var_05 maps\mp\gametypes\_gameobjects::getlabel();
		var_05.label = var_06;
		var_05 maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_defend" + var_06);
		var_05 maps\mp\gametypes\_gameobjects::func_2A25("friendly","waypoint_defend" + var_06);
		var_05 maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_captureneutral" + var_06);
		var_05 maps\mp\gametypes\_gameobjects::func_2A25("enemy","waypoint_captureneutral" + var_06);
		var_05 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
		var_05.onuse = ::onuse;
		var_05.onbeginuse = ::onbeginuse;
		var_05.onuseupdate = ::onuseupdate;
		var_05.onenduse = ::onenduse;
		var_07 = var_04[0].origin + (0,0,32);
		var_08 = var_04[0].origin + (0,0,-32);
		var_09 = bullettrace(var_07,var_08,0,undefined);
		var_0A = vectortoangles(var_09["normal"]);
		var_05.baseeffectforward = anglestoforward(var_0A);
		var_05.baseeffectright = anglestoright(var_0A);
		var_05.baseeffectpos = var_09["position"];
		level.flags[var_02].useobj = var_05;
		level.flags[var_02].adjflags = [];
		level.flags[var_02].nearbyspawns = [];
		var_05.levelflag = level.flags[var_02];
		level.domflags[level.domflags.size] = var_05;
	}

	level.bestspawnflag = [];
	level.bestspawnflag["allies"] = getunownedflagneareststart("allies",undefined);
	level.bestspawnflag["axis"] = getunownedflagneareststart("axis",level.bestspawnflag["allies"]);
	flagsetup();
}

//Function Number: 7
getunownedflagneareststart(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	for(var_04 = 0;var_04 < level.flags.size;var_04++)
	{
		var_05 = level.flags[var_04];
		if(var_05 func_3474() != "neutral")
		{
			continue;
		}

		var_06 = distancesquared(var_05.origin,level.startpos[param_00]);
		if((!isdefined(param_01) || var_05 != param_01) && !isdefined(var_02) || var_06 < var_03)
		{
			var_03 = var_06;
			var_02 = var_05;
		}
	}

	return var_02;
}

//Function Number: 8
onbeginuse(param_00)
{
	var_01 = maps\mp\gametypes\_gameobjects::func_2A15();
	self.didstatusnotify = 0;
	if(var_01 == "neutral")
	{
		statusdialog("securing" + self.label,param_00.pers["team"]);
		self.objpoints[param_00.pers["team"]] thread maps\mp\gametypes\_objpoints::startflashing();
		return;
	}

	if(var_01 == "allies")
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

//Function Number: 9
onuseupdate(param_00,param_01,param_02)
{
	if(param_01 > 0.05 && param_02 && !self.didstatusnotify)
	{
		var_03 = maps\mp\gametypes\_gameobjects::func_2A15();
		if(var_03 == "neutral")
		{
			statusdialog("securing" + self.label,param_00);
		}
		else
		{
			statusdialog("losing" + self.label,var_03);
			statusdialog("securing" + self.label,param_00);
		}

		self.didstatusnotify = 1;
	}
}

//Function Number: 10
statusdialog(param_00,param_01,param_02)
{
	var_03 = gettime();
	if(gettime() < level.laststatus[param_01] + 5000 && !isdefined(param_02) || !param_02)
	{
		return;
	}

	thread func_346F(param_00,param_01);
	level.laststatus[param_01] = gettime();
}

//Function Number: 11
onenduse(param_00,param_01,param_02)
{
	self.objpoints["allies"] thread maps\mp\gametypes\_objpoints::stopflashing();
	self.objpoints["axis"] thread maps\mp\gametypes\_objpoints::stopflashing();
}

//Function Number: 12
resetflagbaseeffect()
{
	if(isdefined(self.baseeffect))
	{
		self.baseeffect delete();
	}

	var_00 = maps\mp\gametypes\_gameobjects::func_2A15();
	if(var_00 != "axis" && var_00 != "allies")
	{
		return;
	}

	var_01 = level.flagbasefxid[var_00];
	self.baseeffect = spawnfx(var_01,self.baseeffectpos,self.baseeffectforward,self.baseeffectright);
	triggerfx(self.baseeffect);
}

//Function Number: 13
onuse(param_00)
{
	var_01 = param_00.pers["team"];
	var_02 = maps\mp\gametypes\_gameobjects::func_2A15();
	var_03 = maps\mp\gametypes\_gameobjects::getlabel();
	self.capturetime = gettime();
	maps\mp\gametypes\_gameobjects::setownerteam(var_01);
	maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_capture" + var_03);
	maps\mp\gametypes\_gameobjects::func_2A25("enemy","waypoint_capture" + var_03);
	self.visuals[0] setmodel(game["flagmodels"][var_01]);
	resetflagbaseeffect();
	level.usestartspawns = 0;
	if(var_02 == "neutral")
	{
		var_04 = maps\mp\_utility::getotherteam(var_01);
		thread maps\mp\_utility::func_32F9(var_01,var_04,undefined,undefined,"mp_war_objective_taken",undefined,param_00);
		statusdialog("secured" + self.label,var_01,1);
		statusdialog("enemy_has" + self.label,var_04,1);
	}
	else
	{
		thread maps\mp\_utility::func_32F9(var_01,var_02,undefined,undefined,"mp_war_objective_taken","mp_war_objective_lost",param_00);
		if(getteamflagcount(var_01) == level.flags.size)
		{
			statusdialog("secure_all",var_01);
			statusdialog("lost_all",var_02);
		}
		else
		{
			statusdialog("secured" + self.label,var_01,1);
			statusdialog("lost" + self.label,var_02,1);
		}

		level.bestspawnflag[var_02] = self.levelflag;
	}

	param_00 notify("objective","captured");
	thread func_346E(self.touchlist[var_01]);
}

//Function Number: 14
func_346E(param_00)
{
	level endon("game_ended");
	var_01 = getarraykeys(param_00);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = param_00[var_01[var_02]].player;
		var_03 thread maps\mp\gametypes\_hud_message::func_2892("capture",maps\mp\gametypes\_rank::getscoreinfovalue("capture"));
		var_03 thread func_347C();
		var_03 thread maps\mp\gametypes\_rank::func_2AB3("capture",maps\mp\gametypes\_rank::getscoreinfovalue("capture") * var_03 getcapxpscale());
		maps\mp\gametypes\_gamescore::func_26D3("capture",var_03);
		var_03 maps\mp\_utility::incplayerstat("pointscaptured",1);
		var_03 maps\mp\_utility::func_26FB("captures",1);
		var_03 maps\mp\gametypes\_persistence::func_26D8("round","captures",var_03.pers["captures"]);
		if(var_03 != self)
		{
			var_03 notify("objective","assistedCapture");
		}
	}

	var_03 = maps\mp\gametypes\_gameobjects::func_29F0();
	level thread maps\mp\_utility::teamplayercardsplash("callout_securedposition" + self.label,var_03);
	var_03 thread maps\mp\_matchdata::loggameevent("capture",var_03.origin);
}

//Function Number: 15
func_346F(param_00,param_01)
{
	level endon("game_ended");
	wait 0.1;
	maps\mp\_utility::waittillslowprocessallowed();
	maps\mp\_utility::func_26E5(param_00,param_01);
}

//Function Number: 16
func_3470(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	wait 0.1;
	maps\mp\_utility::waittillslowprocessallowed();
	maps\mp\_utility::leaderdialogbothteams(param_00,param_01,param_02,param_03);
}

//Function Number: 17
func_3471()
{
	level endon("game_ended");
	while(!level.gameended)
	{
		var_00 = func_3472();
		if(var_00.size)
		{
			for(var_01 = 1;var_01 < var_00.size;var_01++)
			{
				var_02 = var_00[var_01];
				var_03 = gettime() - var_02.capturetime;
				for(var_04 = var_01 - 1;var_04 >= 0 && var_03 > gettime() - var_00[var_04].capturetime;var_04--)
				{
					var_00[var_04 + 1] = var_00[var_04];
				}

				var_00[var_04 + 1] = var_02;
			}

			foreach(var_02 in var_00)
			{
				var_06 = var_02 maps\mp\gametypes\_gameobjects::func_2A15();
				maps\mp\gametypes\_gamescore::giveteamscoreforobjective(var_06,1);
			}
		}

		if(((maps\mp\_utility::gettimepassed() / 1000 > 120 && var_00.size < 2) || maps\mp\_utility::gettimepassed() / 1000 > 300 && var_00.size < 3) && maps\mp\_utility::matchmakinggame())
		{
			level.finalkillcam_winner = "none";
			thread maps\mp\gametypes\_gamelogic::endgame("none",game["strings"]["time_limit_reached"]);
			return;
		}

		wait 5;
		maps\mp\gametypes\_hostmigration::func_273E();
	}
}

//Function Number: 18
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isplayer(param_01) || param_01.pers["team"] == self.pers["team"])
	{
		return;
	}

	var_0A = 0;
	var_0B = 0;
	var_0C = self;
	foreach(var_0E in var_0C.touchtriggers)
	{
		if(var_0E != level.flags[0] && var_0E != level.flags[1] && var_0E != level.flags[2])
		{
			continue;
		}

		var_0F = var_0E.useobj.ownerteam;
		var_10 = var_0C.pers["team"];
		if(var_0F == "neutral")
		{
			continue;
		}

		if(var_10 == var_0F)
		{
			var_0A = 1;
			param_01 thread maps\mp\gametypes\_hud_message::func_2892("assault",maps\mp\gametypes\_rank::getscoreinfovalue("assault"));
			param_01 thread maps\mp\gametypes\_rank::func_2AB3("assault");
			maps\mp\gametypes\_gamescore::func_26D3("assault",param_01);
			thread maps\mp\_matchdata::func_28B4(param_09,"defending");
			continue;
		}

		var_0B = 1;
		param_01 thread maps\mp\gametypes\_hud_message::func_2892("defend",maps\mp\gametypes\_rank::getscoreinfovalue("defend"));
		param_01 thread maps\mp\gametypes\_rank::func_2AB3("defend");
		maps\mp\gametypes\_gamescore::func_26D3("defend",param_01);
		param_01 maps\mp\_utility::func_26FB("defends",1);
		param_01 maps\mp\gametypes\_persistence::func_26D8("round","defends",param_01.pers["defends"]);
		thread maps\mp\_matchdata::func_28B4(param_09,"assaulting");
	}

	foreach(var_0E in param_01.touchtriggers)
	{
		if(var_0E != level.flags[0] && var_0E != level.flags[1] && var_0E != level.flags[2])
		{
			continue;
		}

		var_0F = var_0E.useobj.ownerteam;
		var_13 = param_01.pers["team"];
		if(var_0F == "neutral")
		{
			continue;
		}

		if(var_13 != var_0F)
		{
			if(!var_0A)
			{
				param_01 thread maps\mp\gametypes\_hud_message::func_2892("assault",maps\mp\gametypes\_rank::getscoreinfovalue("assault"));
			}

			param_01 thread maps\mp\gametypes\_rank::func_2AB3("assault");
			maps\mp\gametypes\_gamescore::func_26D3("assault",param_01);
			thread maps\mp\_matchdata::func_28B4(param_09,"defending");
		}
	}

	foreach(var_0E in level.flags)
	{
		var_0F = var_0E.useobj.ownerteam;
		var_13 = param_01.pers["team"];
		var_16 = distancesquared(var_0E.origin,var_0C.origin);
		var_17 = 90000;
		if(var_13 == var_0F && var_16 < var_17)
		{
			if(!var_0B)
			{
				param_01 thread maps\mp\gametypes\_hud_message::func_2892("defend",maps\mp\gametypes\_rank::getscoreinfovalue("defend"));
			}

			param_01 thread maps\mp\gametypes\_rank::func_2AB3("defend");
			maps\mp\gametypes\_gamescore::func_26D3("defend",param_01);
			thread maps\mp\_matchdata::func_28B4(param_09,"assaulting");
		}
	}
}

//Function Number: 19
func_3472()
{
	var_00 = [];
	foreach(var_02 in level.domflags)
	{
		if(var_02 maps\mp\gametypes\_gameobjects::func_2A15() != "neutral" && isdefined(var_02.capturetime))
		{
			var_00[var_00.size] = var_02;
		}
	}

	return var_00;
}

//Function Number: 20
getteamflagcount(param_00)
{
	var_01 = 0;
	for(var_02 = 0;var_02 < level.flags.size;var_02++)
	{
		if(level.domflags[var_02] maps\mp\gametypes\_gameobjects::func_2A15() == param_00)
		{
			var_01++;
		}
	}

	return var_01;
}

//Function Number: 21
func_3474()
{
	return self.useobj maps\mp\gametypes\_gameobjects::func_2A15();
}

//Function Number: 22
func_3475()
{
	var_00 = [];
	for(var_01 = 0;var_01 < level.flags.size;var_01++)
	{
		for(var_02 = 0;var_02 < level.flags[var_01].adjflags.size;var_02++)
		{
			if(level.flags[var_01].useobj maps\mp\gametypes\_gameobjects::func_2A15() != level.flags[var_01].adjflags[var_02].useobj maps\mp\gametypes\_gameobjects::func_2A15())
			{
				var_00[var_00.size] = level.flags[var_01];
				break;
			}
		}
	}

	return var_00;
}

//Function Number: 23
getboundaryflagspawns(param_00)
{
	var_01 = [];
	var_02 = func_3475();
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(isdefined(param_00) && var_02[var_03] func_3474() != param_00)
		{
			continue;
		}

		for(var_04 = 0;var_04 < var_02[var_03].nearbyspawns.size;var_04++)
		{
			var_01[var_01.size] = var_02[var_03].nearbyspawns[var_04];
		}
	}

	return var_01;
}

//Function Number: 24
func_3477(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < level.flags.size;var_02++)
	{
		var_03 = level.flags[var_02];
		if(var_03 == param_00)
		{
			continue;
		}

		var_04 = 0;
		for(var_05 = 0;var_05 < var_03.adjflags.size;var_05++)
		{
			if(var_03.adjflags[var_05] == param_00)
			{
				var_04 = 1;
				break;
			}
		}

		if(!var_04)
		{
			continue;
		}

		for(var_05 = 0;var_05 < var_03.nearbyspawns.size;var_05++)
		{
			var_01[var_01.size] = var_03.nearbyspawns[var_05];
		}
	}

	return var_01;
}

//Function Number: 25
func_3478(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < level.flags.size;var_02++)
	{
		if(level.flags[var_02] func_3474() == param_00)
		{
			for(var_03 = 0;var_03 < level.flags[var_02].nearbyspawns.size;var_03++)
			{
				var_01[var_01.size] = level.flags[var_02].nearbyspawns[var_03];
			}

			continue;
		}

		for(var_04 = 0;var_04 < level.flags[var_02].adjflags.size;var_04++)
		{
			if(level.flags[var_02].adjflags[var_04] func_3474() == param_00)
			{
				for(var_03 = 0;var_03 < level.flags[var_02].nearbyspawns.size;var_03++)
				{
					var_01[var_01.size] = level.flags[var_02].nearbyspawns[var_03];
				}

				break;
			}
		}
	}

	return var_01;
}

//Function Number: 26
getownedflagspawns(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < level.flags.size;var_02++)
	{
		if(level.flags[var_02] func_3474() == param_00)
		{
			for(var_03 = 0;var_03 < level.flags[var_02].nearbyspawns.size;var_03++)
			{
				var_01[var_01.size] = level.flags[var_02].nearbyspawns[var_03];
			}
		}
	}

	return var_01;
}

//Function Number: 27
flagsetup()
{
	var_00 = [];
	var_01 = [];
	var_02 = getentarray("flag_descriptor","targetname");
	var_03 = level.flags;
	for(var_04 = 0;var_04 < level.domflags.size;var_04++)
	{
		var_05 = undefined;
		var_06 = undefined;
		for(var_07 = 0;var_07 < var_02.size;var_07++)
		{
			var_08 = distance(var_03[var_04].origin,var_02[var_07].origin);
			if(!isdefined(var_05) || var_08 < var_05)
			{
				var_05 = var_08;
				var_06 = var_02[var_07];
			}
		}

		if(!isdefined(var_06))
		{
			var_00[var_00.size] = "there is no flag_descriptor in the map! see explanation in dom.gsc";
			break;
		}

		if(isdefined(var_06.flag))
		{
			var_00[var_00.size] = "flag_descriptor with script_linkname \" + var_06.script_linkname + "\" is nearby more than one flag; is there a unique descriptor near each flag?";
			continue;
		}

		var_03[var_04].descriptor = var_06;
		var_06.flag = var_03[var_04];
		var_01[var_06.script_linkname] = var_06;
	}

	if(var_00.size == 0)
	{
		for(var_04 = 0;var_04 < var_03.size;var_04++)
		{
			if(isdefined(var_03[var_04].descriptor.script_linkto))
			{
				var_09 = strtok(var_03[var_04].descriptor.script_linkto," ");
			}
			else
			{
				var_09 = [];
			}

			for(var_07 = 0;var_07 < var_09.size;var_07++)
			{
				var_0A = var_01[var_09[var_07]];
				if(!isdefined(var_0A) || var_0A.targetname != "flag_descriptor")
				{
					var_00[var_00.size] = "flag_descriptor with script_linkname \" + var_03[var_04].descriptor.script_linkname + "\" linked to \" + var_09[var_07] + "\" which does not exist as a script_linkname of any other entity with a targetname of flag_descriptor (or, if it does, that flag_descriptor has not been assigned to a flag)";
					continue;
				}

				var_0B = var_0A.flag;
				if(var_0B == var_03[var_04])
				{
					var_00[var_00.size] = "flag_descriptor with script_linkname \" + var_03[var_04].descriptor.script_linkname + "\" linked to itself";
					continue;
				}

				var_03[var_04].adjflags[var_03[var_04].adjflags.size] = var_0B;
			}
		}
	}

	var_0C = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dom_spawn");
	for(var_04 = 0;var_04 < var_0C.size;var_04++)
	{
		if(isdefined(var_0C[var_04].script_linkto))
		{
			var_0D = var_01[var_0C[var_04].script_linkto];
			if(!isdefined(var_0D) || var_0D.targetname != "flag_descriptor")
			{
				var_00[var_00.size] = "Spawnpoint at " + var_0C[var_04].origin + "\" linked to \" + var_0C[var_04].script_linkto + "\" which does not exist as a script_linkname of any entity with a targetname of flag_descriptor (or, if it does, that flag_descriptor has not been assigned to a flag)";
				continue;
			}

			var_0E = var_0D.flag;
		}
		else
		{
			var_0E = undefined;
			var_0F = undefined;
			for(var_07 = 0;var_07 < var_03.size;var_07++)
			{
				var_08 = distancesquared(var_03[var_07].origin,var_0C[var_04].origin);
				if(!isdefined(var_0E) || var_08 < var_0F)
				{
					var_0E = var_03[var_07];
					var_0F = var_08;
				}
			}
		}

		var_0E.nearbyspawns[var_0E.nearbyspawns.size] = var_0C[var_04];
	}

	if(var_00.size > 0)
	{
		for(var_04 = 0;var_04 < var_00.size;var_04++)
		{
		}

		common_scripts\utility::error("Map errors. See above");
		maps\mp\gametypes\_callbacksetup::abortlevel();
	}
}

//Function Number: 28
initgametypeawards()
{
	maps\mp\_awards::func_2D85("pointscaptured",0,::maps\mp\_awards::func_2DA7);
}

//Function Number: 29
onspawnplayer()
{
}

//Function Number: 30
func_347C()
{
	if(!isdefined(self.cpm))
	{
		self.numcaps = 0;
		self.cpm = 0;
	}

	self.numcaps++;
	if(maps\mp\_utility::getminutespassed() < 1)
	{
		return;
	}

	self.cpm = self.numcaps / maps\mp\_utility::getminutespassed();
}

//Function Number: 31
getcapxpscale()
{
	if(self.cpm < 4)
	{
		return 1;
	}

	return 0.25;
}