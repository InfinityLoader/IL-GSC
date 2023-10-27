/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\dom.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 39
 * Decompile Time: 716 ms
 * Timestamp: 10/27/2023 1:43:12 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(getdvar("mapname") == "mp_background")
	{
		return;
	}

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
		maps\mp\_utility::registertimelimitdvar(level.gametype,30);
		maps\mp\_utility::registerscorelimitdvar(level.gametype,300);
		maps\mp\_utility::registerroundlimitdvar(level.gametype,1);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,1);
		maps\mp\_utility::registernumlivesdvar(level.gametype,0);
		maps\mp\_utility::registerhalftimedvar(level.gametype,1);
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	level.teambased = 1;
	level.allowneutral = 0;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onplayerkilled = ::onplayerkilled;
	level.onspawnplayer = ::onspawnplayer;
	level.domroundstarttime = gettime();
	level.allowboostingabovetriggerradius = 1;
	level.domcapturetime = maps\mp\_utility::getfloatproperty("scr_dom_capture_time",10);
	level.threecaptime["axis"]["time"] = 0;
	level.threecaptime["axis"]["awarded"] = 0;
	level.threecaptime["allies"]["time"] = 0;
	level.threecaptime["allies"]["awarded"] = 0;
	level.alliescapturing = [];
	level.axiscapturing = [];
	level.dom = spawnstruct();
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	game["dialog"]["gametype"] = "dom_intro";
	if(getdvarint("g_hardcore"))
	{
		game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
	}

	game["dialog"]["offense_obj"] = "dom_start";
	game["dialog"]["defense_obj"] = "dom_start";
	if(maps\mp\_utility::isgrapplinghookgamemode())
	{
		game["dialog"]["gametype"] = "grap_" + game["dialog"]["gametype"];
	}
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::setcommonrulesfrommatchrulesdata();
	setdynamicdvar("scr_dom_roundlimit",1);
	maps\mp\_utility::registerroundlimitdvar("dom",1);
	setdynamicdvar("scr_dom_winlimit",1);
	maps\mp\_utility::registerwinlimitdvar("dom",1);
	setdynamicdvar("scr_dom_halftime",1);
	maps\mp\_utility::registerhalftimedvar("dom",1);
	setdynamicdvar("scr_dom_capture_time",getmatchrulesdata("domData","captureTime"));
	setdynamicdvar("scr_dom_allowNeutral",getmatchrulesdata("domData","allowNeutral"));
	setdynamicdvar("scr_dom_halftimeswitchsides",getmatchrulesdata("domData","halfTimeSwitchSides"));
}

//Function Number: 3
onstartgametype()
{
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

	if(game["status"] == "halftime")
	{
		setomnvar("ui_current_round",2);
	}
	else if(game["status"] == "overtime")
	{
		setomnvar("ui_current_round",3);
	}
	else if(game["status"] == "overtime_halftime")
	{
		setomnvar("ui_current_round",4);
	}

	maps\mp\_utility::setobjectivetext("allies",&"OBJECTIVES_DOM");
	maps\mp\_utility::setobjectivetext("axis",&"OBJECTIVES_DOM");
	if(level.splitscreen)
	{
		maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_DOM");
		maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_DOM");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_DOM_SCORE");
		maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_DOM_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_DOM_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_DOM_HINT");
	setclientnamemode("auto_change");
	initspawns();
	precacheflags();
	var_02[0] = "dom";
	maps\mp\gametypes\_gameobjects::main(var_02);
	setomnvar("ui_mlg_game_mode_status_1",0);
	setomnvar("ui_mlg_game_mode_status_2",0);
	setomnvar("ui_mlg_game_mode_status_3",0);
	level thread domflags();
	level thread updatedomscores();
	level thread updatemlgobjectives();
	level thread updatescoreboarddom();
	level.halftime_switch_sides = maps\mp\_utility::dvarintvalue("halftimeswitchsides",1,0,1);
	level.allowneutral = maps\mp\_utility::dvarintvalue("allowNeutral",0,0,1);
}

//Function Number: 4
updatescoreboarddom()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread updatecaptues();
		var_00 thread updatedefends();
	}
}

//Function Number: 5
updatecaptues()
{
	waittillframeend;
	maps\mp\_utility::setextrascore0(self.pers["captures"]);
}

//Function Number: 6
updatedefends()
{
	waittillframeend;
	maps\mp\_utility::setextrascore1(self.pers["defends"]);
}

//Function Number: 7
updatemlgobjectives()
{
	level endon("game_ended");
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			var_01.objective = 0;
			foreach(var_03 in level.domflags)
			{
				if(var_01 istouching(var_03.levelflag))
				{
					if(var_03.numtouching["axis"] * var_03.numtouching["allies"] > 0)
					{
						var_01.objective = 1;
					}
					else if(var_03.ownerteam == "neutral")
					{
						if(var_01.team == "allies")
						{
							var_01.objective = 2;
						}
						else
						{
							var_01.objective = 3;
						}
					}
					else if(var_03.ownerteam == "allies")
					{
						if(var_01.team == "allies")
						{
							var_01.objective = 4;
						}
						else
						{
							var_01.objective = 5;
						}
					}
					else if(var_03.ownerteam == "axis")
					{
						if(var_01.team == "axis")
						{
							var_01.objective = 6;
						}
						else
						{
							var_01.objective = 7;
						}
					}

					if(var_01.objective > 0)
					{
						if(var_03.label == "_b")
						{
							var_01.objective = var_01.objective + 7;
							continue;
						}

						if(var_03.label == "_c")
						{
							var_01.objective = var_01.objective + 14;
						}
					}
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 8
precacheflags()
{
	game["neutral"] = "neutral";
	level.flagbasemodel = "flag_holo_base_ground";
	level.flagfxid["sentinel"]["friendly"] = loadfx("vfx/unique/vfx_flag_project_sentinel_friendly");
	level.flagfxid["sentinel"]["enemy"] = loadfx("vfx/unique/vfx_flag_project_sentinel_enemy");
	level.flagfxid["atlas"]["friendly"] = loadfx("vfx/unique/vfx_flag_project_atlas_friendly");
	level.flagfxid["atlas"]["enemy"] = loadfx("vfx/unique/vfx_flag_project_atlas_enemy");
	level.flagfxid["neutral"]["friendly"] = loadfx("vfx/unique/vfx_flag_project_neutral");
	level.flagfxid["neutral"]["enemy"] = loadfx("vfx/unique/vfx_flag_project_neutral");
	level.boarderfxid["sentinel"]["friendly"] = loadfx("vfx/unique/vfx_marker_dom");
	level.boarderfxid["sentinel"]["enemy"] = loadfx("vfx/unique/vfx_marker_dom_red");
	level.boarderfxid["atlas"]["friendly"] = loadfx("vfx/unique/vfx_marker_dom");
	level.boarderfxid["atlas"]["enemy"] = loadfx("vfx/unique/vfx_marker_dom_red");
	level.boarderfxid["neutral"]["friendly"] = loadfx("vfx/unique/vfx_marker_dom_white");
	level.boarderfxid["neutral"]["enemy"] = loadfx("vfx/unique/vfx_marker_dom_white");
}

//Function Number: 9
initspawns()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_dom_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_dom_spawn_axis_start");
	level.spawn_name = "mp_dom_spawn";
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies",level.spawn_name);
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis",level.spawn_name);
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
}

//Function Number: 10
getspawnpoint()
{
	var_00 = self.pers["team"];
	if(level.usestartspawns && level.ingraceperiod)
	{
		if(game["switchedsides"])
		{
			var_00 = maps\mp\_utility::getotherteam(var_00);
		}

		var_01 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dom_spawn_" + var_00 + "_start");
		var_02 = maps\mp\gametypes\_spawnlogic::getspawnpoint_startspawn(var_01);
	}
	else
	{
		var_03 = getteamdompoints(var_02);
		var_04 = maps\mp\_utility::getotherteam(var_00);
		var_05 = getteamdompoints(var_04);
		var_06 = getprefereddompoints(var_03,var_05);
		var_01 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_00);
		var_02 = maps\mp\gametypes\_spawnscoring::getspawnpoint_domination(var_01,var_06);
	}

	maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(var_02);
	return var_02;
}

//Function Number: 11
getteamdompoints(param_00)
{
	var_01 = [];
	foreach(var_03 in level.domflags)
	{
		if(var_03.ownerteam == param_00)
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 12
getprefereddompoints(param_00,param_01)
{
	var_02 = [];
	var_02[0] = 0;
	var_02[1] = 0;
	var_02[2] = 0;
	var_03 = self.pers["team"];
	if(param_00.size == level.domflags.size)
	{
		var_04 = var_03;
		var_05 = level.bestspawnflag[var_03];
		var_02[var_05.useobj.dompointnumber] = 1;
		return var_02;
	}

	if(var_02.size == 1 && var_03.size == 2)
	{
		var_06 = maps\mp\_utility::getotherteam(self.team);
		var_07 = maps\mp\gametypes\_gamescore::_getteamscore(var_06) - maps\mp\gametypes\_gamescore::_getteamscore(self.team);
		if(var_07 > 25)
		{
			var_08 = gettimesincedompointcapture(var_02[0]);
			var_09 = gettimesincedompointcapture(var_03[0]);
			var_0A = gettimesincedompointcapture(var_03[1]);
			if(var_08 > 80000 && var_09 > 80000 && var_0A > 80000)
			{
				return var_04;
			}
		}
	}

	if(var_02.size > 0)
	{
		foreach(var_0C in var_02)
		{
			var_04[var_0C.dompointnumber] = 1;
		}

		return var_04;
	}
	else
	{
		var_04 = var_0D;
		var_06 = maps\mp\_utility::getotherteam(var_0D);
		var_05 = level.bestspawnflag[var_0D];
		if(var_04.size > 0 && var_04.size < level.domflags.size)
		{
			var_06 = getunownedflagneareststart(var_0C,undefined,0);
			level.bestspawnflag[var_0C] = var_06;
		}

		if(var_06 == level.bestspawnflag[var_0D])
		{
			var_06 = getunownedflagneareststart(var_0C,level.bestspawnflag[var_0D],1);
			level.bestspawnflag[var_0C] = var_06;
		}

		var_05[var_06.useobj.dompointnumber] = 1;
		return var_05;
	}

	return var_0D;
}

//Function Number: 13
gettimesincedompointcapture(param_00)
{
	return gettime() - param_00.capturetime;
}

//Function Number: 14
domflags()
{
	level.laststatus["allies"] = 0;
	level.laststatus["axis"] = 0;
	var_00 = getentarray("flag_primary","targetname");
	var_01 = getentarray("flag_primary_augmented","targetname");
	if(var_00.size < 2)
	{
		return;
	}

	if(maps\mp\_utility::isaugmentedgamemode())
	{
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			var_03 = var_01[var_02].script_label;
			for(var_04 = 0;var_04 < var_00.size;var_04++)
			{
				if(var_00[var_04].script_label == var_03)
				{
					var_00[var_04] delete();
					break;
				}
			}
		}
	}
	else
	{
		for(var_05 = 0;var_05 < var_01.size;var_05++)
		{
			var_01[var_05] delete();
		}
	}

	level.flags = [];
	level.flags = common_scripts\utility::array_combine(var_00,var_01);
	level.domflags = [];
	for(var_05 = 0;var_05 < level.flags.size;var_05++)
	{
		var_06 = level.flags[var_05];
		if(isdefined(var_06.target))
		{
			var_07[0] = getent(var_06.target,"targetname");
		}
		else
		{
			var_07[0] = spawn("script_model",var_06.origin);
			var_07[0].angles = var_06.angles;
		}

		var_07[0] setmodel(level.flagbasemodel);
		var_08 = maps\mp\gametypes\_gameobjects::createuseobject("neutral",var_06,var_07,(0,0,100));
		var_08 maps\mp\gametypes\_gameobjects::allowuse("enemy");
		var_08 maps\mp\gametypes\_gameobjects::setusetime(level.domcapturetime);
		var_08 maps\mp\gametypes\_gameobjects::setusetext(&"MP_SECURING_POSITION");
		var_09 = var_08 maps\mp\gametypes\_gameobjects::getlabel();
		var_08.label = var_09;
		var_08 maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_defend" + var_09);
		var_08 maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_defend" + var_09);
		var_08 maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_captureneutral" + var_09);
		var_08 maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_captureneutral" + var_09);
		var_08 maps\mp\gametypes\_gameobjects::set2dicon("mlg","waypoint_esports_dom_white" + var_09);
		var_08 maps\mp\gametypes\_gameobjects::set3dicon("mlg","waypoint_esports_dom_white" + var_09);
		var_08 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
		var_08.onuse = ::onuse;
		var_08.onbeginuse = ::onbeginuse;
		var_08.onuseupdate = ::onuseupdate;
		var_08.onenduse = ::onenduse;
		var_08.nousebar = 1;
		var_08.id = "domFlag";
		var_08.has_been_captured = 0;
		var_08.firstcapture = 1;
		var_0A = var_07[0].origin + (0,0,32);
		var_0B = var_07[0].origin + (0,0,-32);
		var_0C = bullettrace(var_0A,var_0B,0,var_07[0]);
		var_0D = vectortoangles(var_0C["normal"]);
		var_08.baseeffectforward = anglestoforward(var_0D);
		var_08.baseeffectright = anglestoright(var_0D);
		var_08.baseeffectpos = var_0C["position"];
		var_07[0].origin = var_0C["position"];
		var_08 thread updatevisuals(1);
		level.flags[var_05].useobj = var_08;
		var_08.levelflag = level.flags[var_05];
		level.domflags[level.domflags.size] = var_08;
	}

	var_0E = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dom_spawn_axis_start");
	var_0F = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_dom_spawn_allies_start");
	level.startpos["allies"] = var_0F[0].origin;
	level.startpos["axis"] = var_0E[0].origin;
	level.bestspawnflag = [];
	level.bestspawnflag["allies"] = getunownedflagneareststart("allies",undefined,0);
	level.bestspawnflag["axis"] = getunownedflagneareststart("axis",level.bestspawnflag["allies"],0);
	flagsetup();
}

//Function Number: 15
getunownedflagneareststart(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = undefined;
	for(var_05 = 0;var_05 < level.flags.size;var_05++)
	{
		var_06 = level.flags[var_05];
		if(!param_02 && var_06 getflagteam() != "neutral")
		{
			continue;
		}

		var_07 = distancesquared(var_06.origin,level.startpos[param_00]);
		if((!isdefined(param_01) || var_06 != param_01) && !isdefined(var_03) || var_07 < var_04)
		{
			var_04 = var_07;
			var_03 = var_06;
		}
	}

	return var_03;
}

//Function Number: 16
onbeginuse(param_00)
{
	var_01 = maps\mp\gametypes\_gameobjects::getownerteam();
	self.didstatusnotify = 0;
	maps\mp\gametypes\_gameobjects::setusetime(level.domcapturetime);
	if(var_01 == "neutral")
	{
		statusdialog("securing" + self.label,param_00.team);
		if(self.firstcapture || self.curprogress == 0)
		{
			maps\mp\gametypes\_gameobjects::setusetime(level.domcapturetime / 2);
		}

		return;
	}

	if(var_01 == "allies")
	{
		level.alliescapturing[level.alliescapturing.size] = self.label;
		var_02 = "axis";
		return;
	}

	level.axiscapturing[level.axiscapturing.size] = self.label;
	var_02 = "allies";
}

//Function Number: 17
onuseupdate(param_00,param_01,param_02)
{
	var_03 = maps\mp\gametypes\_gameobjects::getownerteam();
	if(param_01 > 0.05 && param_02 && !self.didstatusnotify)
	{
		if(var_03 == "neutral")
		{
			statusdialog("securing" + self.label,param_00);
			self.prevownerteam = maps\mp\_utility::getotherteam(param_00);
			if(param_00 == "allies")
			{
				maps\mp\gametypes\_gameobjects::set2dicon("mlg","waypoint_esports_dom_blue_taking" + self.label);
				maps\mp\gametypes\_gameobjects::set3dicon("mlg","waypoint_esports_dom_blue_taking" + self.label);
			}
			else
			{
				maps\mp\gametypes\_gameobjects::set2dicon("mlg","waypoint_esports_dom_red_taking" + self.label);
				maps\mp\gametypes\_gameobjects::set3dicon("mlg","waypoint_esports_dom_red_taking" + self.label);
			}
		}
		else
		{
			statusdialog("losing" + self.label,var_03,1);
			statusdialog("securing" + self.label,param_00);
			if(var_03 == "allies")
			{
				maps\mp\gametypes\_gameobjects::set2dicon("mlg","waypoint_esports_dom_blue_losing" + self.label);
				maps\mp\gametypes\_gameobjects::set3dicon("mlg","waypoint_esports_dom_blue_losing" + self.label);
			}
			else
			{
				maps\mp\gametypes\_gameobjects::set2dicon("mlg","waypoint_esports_dom_red_losing" + self.label);
				maps\mp\gametypes\_gameobjects::set3dicon("mlg","waypoint_esports_dom_red_losing" + self.label);
			}
		}

		maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_taking" + self.label);
		maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_taking" + self.label);
		maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_losing" + self.label);
		maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_losing" + self.label);
		self.didstatusnotify = 1;
		return;
	}

	if(level.allowneutral && param_01 > 0.49 && param_02 && self.didstatusnotify && var_03 != "neutral")
	{
		maps\mp\gametypes\_gameobjects::setownerteam("neutral");
		updatevisuals();
		statusdialog("lost" + self.label,var_03,1);
		level thread maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_lrg",param_00);
		level thread maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_lrg",var_03);
		updateuiflagomnvars(self.label,"neutral");
		thread giveflagneutralizexp(self.touchlist[param_00]);
	}
}

//Function Number: 18
statusdialog(param_00,param_01,param_02)
{
	var_03 = gettime();
	if(gettime() < level.laststatus[param_01] + 5000 && !isdefined(param_02) || !param_02)
	{
		return;
	}

	thread delayedleaderdialog(param_00,param_01);
	level.laststatus[param_01] = gettime();
}

//Function Number: 19
onenduse(param_00,param_01,param_02)
{
	if(isplayer(param_01))
	{
		param_01 setclientomnvar("ui_capture_icon",0);
	}

	var_03 = maps\mp\gametypes\_gameobjects::getownerteam();
	if(var_03 != "neutral")
	{
		maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_capture" + self.label);
		maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_capture" + self.label);
		maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_defend" + self.label);
		maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_defend" + self.label);
		if(var_03 == "allies")
		{
			maps\mp\gametypes\_gameobjects::set2dicon("mlg","waypoint_esports_dom_blue" + self.label);
			maps\mp\gametypes\_gameobjects::set3dicon("mlg","waypoint_esports_dom_blue" + self.label);
		}
		else
		{
			maps\mp\gametypes\_gameobjects::set2dicon("mlg","waypoint_esports_dom_red" + self.label);
			maps\mp\gametypes\_gameobjects::set3dicon("mlg","waypoint_esports_dom_red" + self.label);
		}
	}
	else
	{
		maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_captureneutral" + self.label);
		maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_captureneutral" + self.label);
		maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_captureneutral" + self.label);
		maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_captureneutral" + self.label);
		maps\mp\gametypes\_gameobjects::set2dicon("mlg","waypoint_esports_dom_white" + self.label);
		maps\mp\gametypes\_gameobjects::set3dicon("mlg","waypoint_esports_dom_white" + self.label);
	}

	if(param_00 == "allies")
	{
		common_scripts\utility::array_remove(level.alliescapturing,self.label);
		return;
	}

	common_scripts\utility::array_remove(level.alliescapturing,self.label);
}

//Function Number: 20
updatevisuals(param_00)
{
	if(isdefined(param_00) && param_00)
	{
		waittillframeend;
	}

	if(!isremovedentity(self.visuals[0]))
	{
		var_01 = self.visuals[0];
		friendlyenemyeffects(var_01.origin,anglestoup(var_01.angles));
	}
}

//Function Number: 21
friendlyenemyeffects(param_00,param_01)
{
	var_02 = self.ownerteam;
	var_03 = level.flagfxid[game[var_02]]["friendly"];
	var_04 = level.boarderfxid[game[var_02]]["friendly"];
	var_05 = level.flagfxid[game[var_02]]["enemy"];
	var_06 = level.boarderfxid[game[var_02]]["enemy"];
	friendlyenemyeffectsstop();
	self.friendlyflagfxid = maps\mp\_utility::spawnfxshowtoteam(var_03,var_02,param_00,param_01);
	self.friendlyboarderfxid = maps\mp\_utility::spawnfxshowtoteam(var_04,var_02,param_00,param_01);
	self.enemyflagfxid = maps\mp\_utility::spawnfxshowtoteam(var_05,maps\mp\_utility::getotherteam(var_02),param_00,param_01);
	self.enemyboarderfxid = maps\mp\_utility::spawnfxshowtoteam(var_06,maps\mp\_utility::getotherteam(var_02),param_00,param_01);
}

//Function Number: 22
friendlyenemyeffectsstop()
{
	if(isdefined(self.friendlyflagfxid))
	{
		self.friendlyflagfxid delete();
	}

	if(isdefined(self.friendlyboarderfxid))
	{
		self.friendlyboarderfxid delete();
	}

	if(isdefined(self.enemyflagfxid))
	{
		self.enemyflagfxid delete();
	}

	if(isdefined(self.enemyboarderfxid))
	{
		self.enemyboarderfxid delete();
	}
}

//Function Number: 23
updateuiflagomnvars(param_00,param_01)
{
	var_02 = "ui_mlg_game_mode_status_1";
	if(param_00 == "_b")
	{
		var_02 = "ui_mlg_game_mode_status_2";
	}

	if(param_00 == "_c")
	{
		var_02 = "ui_mlg_game_mode_status_3";
	}

	if(param_01 == "allies")
	{
		setomnvar(var_02,-1);
		return;
	}

	if(param_01 == "axis")
	{
		setomnvar(var_02,1);
		return;
	}

	setomnvar(var_02,0);
}

//Function Number: 24
onuse(param_00)
{
	var_01 = param_00.team;
	var_02 = maps\mp\gametypes\_gameobjects::getownerteam();
	var_03 = maps\mp\gametypes\_gameobjects::getlabel();
	var_04 = 0;
	if(self.firstcapture && var_03 == "_b")
	{
		var_04 = 1;
	}

	self.capturetime = gettime();
	self.firstcapture = 0;
	self.has_been_captured = 1;
	if(isdefined(self.ownedtheentiregame))
	{
		self.ownedtheentireround = 0;
	}
	else
	{
		self.ownedtheentireround = 1;
	}

	maps\mp\gametypes\_gameobjects::setownerteam(var_01);
	maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_capture" + var_03);
	maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_capture" + var_03);
	maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_defend" + self.label);
	maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_defend" + self.label);
	if(var_01 == "allies")
	{
		maps\mp\gametypes\_gameobjects::set2dicon("mlg","waypoint_esports_dom_blue" + self.label);
		maps\mp\gametypes\_gameobjects::set3dicon("mlg","waypoint_esports_dom_blue" + self.label);
	}
	else
	{
		maps\mp\gametypes\_gameobjects::set2dicon("mlg","waypoint_esports_dom_red" + self.label);
		maps\mp\gametypes\_gameobjects::set3dicon("mlg","waypoint_esports_dom_red" + self.label);
	}

	updatevisuals();
	level.usestartspawns = 0;
	if(var_02 == "neutral")
	{
		var_05 = maps\mp\_utility::getotherteam(var_01);
		statusdialog("secured" + self.label,var_01,1);
		statusdialog("enemy_has" + self.label,var_05,1);
		level thread maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_lrg",var_01);
	}
	else
	{
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

		level thread maps\mp\_utility::playsoundonplayers("mp_obj_notify_pos_lrg",var_01);
		level thread maps\mp\_utility::playsoundonplayers("mp_obj_notify_neg_lrg",var_02);
		level.bestspawnflag[var_02] = self.levelflag;
	}

	updateuiflagomnvars(self.label,var_01);
	param_00 thread maps\mp\_audio::snd_play_team_splash("mp_obj_notify_pos_lrg","mp_obj_notify_neg_lrg");
	thread giveflagcapturexp(self.touchlist[var_01],var_04);
}

//Function Number: 25
giveflagcapturexp(param_00,param_01)
{
	level endon("game_ended");
	var_02 = maps\mp\gametypes\_gameobjects::getearliestclaimplayer();
	if(isdefined(var_02.owner))
	{
		var_02 = var_02.owner;
	}

	if(isplayer(var_02))
	{
		level thread maps\mp\_utility::teamplayercardsplash("callout_securedposition" + self.label,var_02);
	}

	var_03 = getarraykeys(param_00);
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_02 = param_00[var_03[var_04]].player;
		if(isdefined(var_02.owner))
		{
			var_02 = var_02.owner;
		}

		if(!isplayer(var_02))
		{
			continue;
		}

		var_02 thread maps\mp\_events::domcaptureevent(param_01);
		var_02 thread updatecpm();
		wait(0.05);
	}
}

//Function Number: 26
giveflagneutralizexp(param_00)
{
	level endon("game_ended");
	var_01 = maps\mp\gametypes\_gameobjects::getearliestclaimplayer();
	if(isdefined(var_01.owner))
	{
		var_01 = var_01.owner;
	}

	if(isplayer(var_01))
	{
		level thread maps\mp\_utility::teamplayercardsplash("callout_neutralized_position" + self.label,var_01);
	}

	var_02 = getarraykeys(param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_01 = param_00[var_02[var_03]].player;
		if(isdefined(var_01.owner))
		{
			var_01 = var_01.owner;
		}

		if(!isplayer(var_01))
		{
			continue;
		}

		var_01 thread maps\mp\_events::domneutralizeevent();
		wait(0.05);
	}
}

//Function Number: 27
delayedleaderdialog(param_00,param_01)
{
	level endon("game_ended");
	wait(0.1);
	maps\mp\_utility::waittillslowprocessallowed();
	maps\mp\_utility::leaderdialog(param_00,param_01);
}

//Function Number: 28
delayedleaderdialogbothteams(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	wait(0.1);
	maps\mp\_utility::waittillslowprocessallowed();
	maps\mp\_utility::leaderdialogbothteams(param_00,param_01,param_02,param_03);
}

//Function Number: 29
updatedomscores()
{
	level endon("game_ended");
	while(!level.gameended)
	{
		var_00 = getowneddomflags();
		if(var_00.size)
		{
			var_01 = undefined;
			var_02 = undefined;
			foreach(var_04 in var_00)
			{
				var_05 = var_04 maps\mp\gametypes\_gameobjects::getownerteam();
				maps\mp\gametypes\_gamescore::giveteamscoreforobjective(var_05,1);
				if(!isdefined(var_01) || var_01 < var_04.capturetime)
				{
					var_01 = var_04.capturetime;
				}

				if(!isdefined(var_02))
				{
					var_02 = var_05;
				}

				if(var_02 != var_05)
				{
					var_02 = "none";
				}
			}

			if(var_00.size == 3 && var_02 != "none" && level.players.size > 5)
			{
				level.threecaptime[var_02]["time"] = gettime() - var_01;
				level.threecaptime[maps\mp\_utility::getotherteam(var_02)]["time"] = 0;
				if(level.threecaptime[var_02]["time"] > 60000 && level.threecaptime["axis"]["awarded"] == 0)
				{
					level.threecaptime["axis"]["awarded"] = 1;
					foreach(var_08 in level.players)
					{
						if(var_08.team != var_02)
						{
							continue;
						}

						var_08 maps\mp\gametypes\_missions::processchallenge("ch_dom_tripcap");
					}
				}
			}
			else
			{
				level.threecaptime["axis"]["time"] = 0;
				level.threecaptime["allies"]["time"] = 0;
			}
		}

		var_0A = 0;
		var_0B = 0;
		var_0C = 0;
		foreach(var_0E in level.domflags)
		{
			if(var_0E.label == "_a")
			{
				if(var_0E.has_been_captured == 1)
				{
					var_0B = 1;
				}

				continue;
			}

			if(var_0E.label == "_c")
			{
				if(var_0E.has_been_captured == 1)
				{
					var_0C = 1;
				}
			}
		}

		if(var_0B == 1 || var_0C == 1)
		{
			var_0A = 1;
		}

		if(maps\mp\_utility::matchmakinggame() && !level.allowneutral && !var_0A && getdomroundtimepassed() > 120000 && !getdvarint("force_ranking"))
		{
			level.finalkillcam_winner = "none";
			thread maps\mp\gametypes\_gamelogic::endgame("none",game["end_reason"]["time_limit_reached"]);
			return;
		}

		wait(5);
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	}
}

//Function Number: 30
getdomroundtimepassed()
{
	return gettime() - level.domroundstarttime;
}

//Function Number: 31
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isplayer(param_01))
	{
		return;
	}

	if(maps\mp\gametypes\_damage::isfriendlyfire(self,param_01))
	{
		return;
	}

	if(param_01 == self)
	{
		return;
	}

	if(isdefined(param_04) && maps\mp\_utility::iskillstreakweapon(param_04))
	{
		return;
	}

	var_0A = 0;
	var_0B = self;
	foreach(var_0D in param_01.touchtriggers)
	{
		if(var_0D != level.flags[0] && var_0D != level.flags[1] && var_0D != level.flags[2])
		{
			continue;
		}

		var_0E = var_0D.useobj.ownerteam;
		if(param_01.team != var_0E)
		{
			param_01 thread maps\mp\_events::killwhilecapture(var_0B,param_09);
			var_0A = 1;
		}
	}

	var_10 = 90000;
	foreach(var_0D in level.flags)
	{
		var_0E = var_0D.useobj.ownerteam;
		var_12 = distancesquared(var_0D.origin,var_0B.origin);
		var_13 = distancesquared(var_0D.origin,param_01.origin);
		if(var_0E == param_01.team)
		{
			if(var_12 < var_10 || var_13 < var_10)
			{
				param_01 thread maps\mp\_events::defendobjectiveevent(var_0B,param_09);
				param_01 maps\mp\_utility::setextrascore1(param_01.pers["defends"]);
			}
		}

		if(var_0A)
		{
			break;
		}

		if(var_0E == var_0B.team)
		{
			if(var_13 < var_10 || var_12 < var_10)
			{
				param_01 thread maps\mp\_events::assaultobjectiveevent(self,param_09);
			}
		}
	}
}

//Function Number: 32
getowneddomflags()
{
	var_00 = [];
	foreach(var_02 in level.domflags)
	{
		if(var_02 maps\mp\gametypes\_gameobjects::getownerteam() != "neutral" && isdefined(var_02.capturetime))
		{
			var_00[var_00.size] = var_02;
		}
	}

	return var_00;
}

//Function Number: 33
getteamflagcount(param_00)
{
	var_01 = 0;
	for(var_02 = 0;var_02 < level.flags.size;var_02++)
	{
		if(level.domflags[var_02] maps\mp\gametypes\_gameobjects::getownerteam() == param_00)
		{
			var_01++;
		}
	}

	return var_01;
}

//Function Number: 34
getflagteam()
{
	return self.useobj maps\mp\gametypes\_gameobjects::getownerteam();
}

//Function Number: 35
flagsetup()
{
	var_00 = level.domflags;
	var_02 = getfirstarraykey(var_00);
	if(isdefined(var_02))
	{
		var_01 = var_00[var_02];
		switch(var_01.label)
		{
			case "_a":
				break;

			case "_b":
				break;

			case "_c":
				break;
		}
	}
}

//Function Number: 36
getnearestflagpoint(param_00)
{
	var_01 = maps\mp\gametypes\_spawnlogic::ispathdataavailable();
	var_02 = undefined;
	var_03 = undefined;
	foreach(var_05 in level.domflags)
	{
		var_06 = undefined;
		if(var_01)
		{
			var_06 = getpathdist(param_00.origin,var_05.levelflag.origin,999999);
		}

		if(!isdefined(var_06) || var_06 == -1)
		{
			var_06 = distancesquared(var_05.levelflag.origin,param_00.origin);
		}

		if(!isdefined(var_02) || var_06 < var_03)
		{
			var_02 = var_05;
			var_03 = var_06;
		}
	}

	return var_02.levelflag;
}

//Function Number: 37
onspawnplayer()
{
}

//Function Number: 38
updatecpm()
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

//Function Number: 39
getcapxpscale()
{
	if(self.cpm < 4)
	{
		return 1;
	}

	return 0.25;
}