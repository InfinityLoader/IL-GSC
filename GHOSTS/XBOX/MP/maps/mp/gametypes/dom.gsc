/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\dom.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 38
 * Decompile Time: 705 ms
 * Timestamp: 10/27/2023 1:29:06 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(getdvar("mapname") == "mp_background")
	{
		return;
	}

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
		maps\mp\_utility::func_6476(level.gametype,30);
		maps\mp\_utility::func_6475(level.gametype,300);
		maps\mp\_utility::func_6472(level.gametype,1);
		maps\mp\_utility::func_647C(level.gametype,1);
		maps\mp\_utility::func_6470(level.gametype,0);
		maps\mp\_utility::func_646A(level.gametype,0);
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	level.teambased = 1;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onplayerkilled = ::onplayerkilled;
	level.initgametypeawards = ::initgametypeawards;
	level.var_5976 = ::func_5976;
	level.lastcaptime = gettime();
	level.alliescapturing = [];
	level.axiscapturing = [];
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
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
	thread func_595D();
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::func_700A();
	if(getdvarint("scr_playlist_type",0) == 1 || maps\mp\_utility::func_92AB())
	{
		setdynamicdvar("scr_dom_roundswitch",1);
		maps\mp\_utility::func_6473("dom",1,0,1);
		setdynamicdvar("scr_dom_roundlimit",2);
		maps\mp\_utility::func_6472("dom",2);
		setdynamicdvar("scr_dom_winlimit",0);
		maps\mp\_utility::func_647C("dom",0);
	}
	else
	{
		setdynamicdvar("scr_dom_roundlimit",1);
		maps\mp\_utility::func_6472("dom",1);
		setdynamicdvar("scr_dom_winlimit",1);
		maps\mp\_utility::func_647C("dom",1);
	}

	setdynamicdvar("scr_dom_halftime",0);
	maps\mp\_utility::func_646A("dom",0);
	setdynamicdvar("scr_dom_promode",0);
}

//Function Number: 3
onstartgametype()
{
	maps\mp\_utility::func_7084("allies",&"OBJECTIVES_DOM");
	maps\mp\_utility::func_7084("axis",&"OBJECTIVES_DOM");
	if(level.splitscreen)
	{
		maps\mp\_utility::func_7083("allies",&"OBJECTIVES_DOM");
		maps\mp\_utility::func_7083("axis",&"OBJECTIVES_DOM");
	}
	else
	{
		maps\mp\_utility::func_7083("allies",&"OBJECTIVES_DOM_SCORE");
		maps\mp\_utility::func_7083("axis",&"OBJECTIVES_DOM_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_DOM_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_DOM_HINT");
	setclientnamemode("auto_change");
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	level.flagbasefxid["neutral"] = loadfx("vfx/gameplay/mp/core/vfx_marker_base_grey");
	level.flagbasefxid["friendly"] = loadfx("vfx/gameplay/mp/core/vfx_marker_base_cyan");
	level.flagbasefxid["enemy"] = loadfx("vfx/gameplay/mp/core/vfx_marker_base_orange");
	initspawns();
	var_00[0] = "dom";
	maps\mp\gametypes\_gameobjects::func_4FDD(var_00);
	thread domflags();
	thread func_86E4();
}

//Function Number: 4
initspawns()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_dom_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_dom_spawn_axis_start");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies","mp_dom_spawn");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis","mp_dom_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
}

//Function Number: 5
getspawnpoint()
{
	var_00 = self.pers["team"];
	var_01 = maps\mp\_utility::getotherteam(var_00);
	if(level.usestartspawns)
	{
		if(game["switchedsides"])
		{
			var_02 = maps\mp\gametypes\_spawnlogic::func_3BF6("mp_dom_spawn_" + var_01 + "_start");
			var_03 = maps\mp\gametypes\_spawnlogic::func_3BF5(var_02);
		}
		else
		{
			var_02 = maps\mp\gametypes\_spawnlogic::func_3BF6("mp_dom_spawn_" + var_02 + "_start");
			var_03 = maps\mp\gametypes\_spawnlogic::func_3BF5(var_03);
		}
	}
	else
	{
		var_04 = func_3C30(var_02);
		var_05 = maps\mp\_utility::getotherteam(var_00);
		var_06 = func_3C30(var_05);
		var_07 = func_3B85(var_04,var_06);
		var_02 = maps\mp\gametypes\_spawnlogic::func_3C41(var_00);
		var_03 = maps\mp\gametypes\_spawnscoring::getspawnpoint_domination(var_02,var_07);
	}

	return var_03;
}

//Function Number: 6
func_3C30(param_00)
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

//Function Number: 7
func_3B85(param_00,param_01)
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

	if(var_02.size == 1 && var_03.size == 2 && !maps\mp\_utility::isanymlgmatch())
	{
		var_06 = maps\mp\_utility::getotherteam(self.team);
		var_07 = maps\mp\gametypes\_gamescore::func_6A3(var_06) - maps\mp\gametypes\_gamescore::func_6A3(self.team);
		if(var_07 > 15)
		{
			var_08 = gettimesincedompointcapture(var_02[0]);
			var_09 = gettimesincedompointcapture(var_03[0]);
			var_0A = gettimesincedompointcapture(var_03[1]);
			if(var_08 > -25536 && var_09 > -25536 && var_0A > -25536)
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

	if(var_05.size == 0)
	{
		var_04 = var_0D;
		var_05 = level.bestspawnflag[var_0D];
		if(var_04.size > 0 && var_04.size < level.domflags.size)
		{
			var_0D = func_3C5D(var_0C);
			level.bestspawnflag[var_0C] = var_0D;
		}

		var_05[var_0D.useobj.dompointnumber] = 1;
		return var_05;
	}

	return var_0C;
}

//Function Number: 8
gettimesincedompointcapture(param_00)
{
	return gettime() - param_00.capturetime;
}

//Function Number: 9
domflags()
{
	level.laststatus["allies"] = 0;
	level.laststatus["axis"] = 0;
	game["flagmodels"] = [];
	game["flagmodels"]["neutral"] = "prop_flag_neutral";
	game["flagmodels"]["allies"] = maps\mp\gametypes\_teams::getteamflagmodel("allies");
	game["flagmodels"]["axis"] = maps\mp\gametypes\_teams::getteamflagmodel("axis");
	var_00 = getentarray("flag_primary","targetname");
	var_01 = getentarray("flag_secondary","targetname");
	if(var_00.size + var_01.size < 2)
	{
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

		var_05 = maps\mp\gametypes\_gameobjects::func_212D("neutral",var_03,var_04,(0,0,100));
		var_05 maps\mp\gametypes\_gameobjects::allowuse("enemy");
		var_05 maps\mp\gametypes\_gameobjects::func_720E(10);
		var_05 maps\mp\gametypes\_gameobjects::func_720D(&"MP_SECURING_POSITION");
		var_06 = var_05 maps\mp\gametypes\_gameobjects::func_3B06();
		var_05.label = var_06;
		var_05 maps\mp\gametypes\_gameobjects::func_6E14("friendly","waypoint_defend" + var_06);
		var_05 maps\mp\gametypes\_gameobjects::func_6E15("friendly","waypoint_defend" + var_06);
		var_05 maps\mp\gametypes\_gameobjects::func_6E14("enemy","waypoint_captureneutral" + var_06);
		var_05 maps\mp\gametypes\_gameobjects::func_6E15("enemy","waypoint_captureneutral" + var_06);
		var_05 maps\mp\gametypes\_gameobjects::func_7212("any");
		var_05.onuse = ::onuse;
		var_05.onbeginuse = ::onbeginuse;
		var_05.onuseupdate = ::onuseupdate;
		var_05.onenduse = ::onenduse;
		var_05.nousebar = 1;
		var_05.id = "domFlag";
		var_05.firstcapture = 1;
		var_07 = var_04[0].origin + (0,0,32);
		var_08 = var_04[0].origin + (0,0,-32);
		var_09 = bullettrace(var_07,var_08,0,undefined);
		var_05.baseeffectpos = var_09["position"];
		var_0A = vectortoangles(var_09["normal"]);
		var_05.baseeffectforward = anglestoforward(var_0A);
		var_05 thread func_7035();
		level.flags[var_02].useobj = var_05;
		var_05.levelflag = level.flags[var_02];
		level.domflags[level.domflags.size] = var_05;
	}

	var_0B = maps\mp\gametypes\_spawnlogic::func_3BF6("mp_dom_spawn_axis_start");
	var_0C = maps\mp\gametypes\_spawnlogic::func_3BF6("mp_dom_spawn_allies_start");
	level.startpos["allies"] = var_0C[0].origin;
	level.startpos["axis"] = var_0B[0].origin;
	level.bestspawnflag = [];
	level.bestspawnflag["allies"] = func_3C5D("allies",undefined);
	level.bestspawnflag["axis"] = func_3C5D("axis",level.bestspawnflag["allies"]);
	func_33A8();
}

//Function Number: 10
func_3C5D(param_00,param_01)
{
	var_02 = undefined;
	var_03 = undefined;
	for(var_04 = 0;var_04 < level.flags.size;var_04++)
	{
		var_05 = level.flags[var_04];
		if(var_05 func_3AAB() != "neutral")
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

//Function Number: 11
onbeginuse(param_00)
{
	var_01 = maps\mp\gametypes\_gameobjects::func_3B78();
	self.didstatusnotify = 0;
	if(var_01 == "neutral")
	{
		func_7B2B("securing" + self.label,param_00.team);
		if(!self.firstcapture)
		{
			if(self.curprogress == 0)
			{
				maps\mp\gametypes\_gameobjects::func_720E(5);
			}
		}
	}

	maps\mp\gametypes\_gameobjects::func_720E(10);
	if(var_01 == "allies")
	{
		level.alliescapturing[level.alliescapturing.size] = self.label;
		var_02 = "axis";
	}

	level.axiscapturing[level.axiscapturing.size] = self.label;
	var_02 = "allies";
}

//Function Number: 12
onuseupdate(param_00,param_01,param_02)
{
	var_03 = maps\mp\gametypes\_gameobjects::func_3B78();
	if(param_01 > 0.05 && param_02 && !self.didstatusnotify)
	{
		if(var_03 == "neutral")
		{
			func_7B2B("securing" + self.label,param_00);
			self.prevownerteam = maps\mp\_utility::getotherteam(param_00);
		}
		else
		{
			func_7B2B("losing" + self.label,var_03,1);
			func_7B2B("securing" + self.label,param_00);
		}

		maps\mp\gametypes\_gameobjects::func_6E14("enemy","waypoint_taking" + self.label);
		maps\mp\gametypes\_gameobjects::func_6E15("enemy","waypoint_taking" + self.label);
		maps\mp\gametypes\_gameobjects::func_6E14("friendly","waypoint_losing" + self.label);
		maps\mp\gametypes\_gameobjects::func_6E15("friendly","waypoint_losing" + self.label);
		self.didstatusnotify = 1;
	}

	if(param_01 > 0.49 && param_02 && self.didstatusnotify && var_03 != "neutral")
	{
		thread func_7035();
		func_7B2B("lost" + self.label,var_03,1);
		maps\mp\_utility::func_6045("mp_dom_flag_lost",var_03);
		level.lastcaptime = gettime();
		thread giveflagassistedcapturepoints(self.touchlist[param_00]);
	}
}

//Function Number: 13
giveflagassistedcapturepoints(param_00)
{
	level endon("game_ended");
	var_01 = getarraykeys(param_00);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = param_00[var_01[var_02]].player;
		if(!isdefined(var_03))
		{
			continue;
		}

		if(isdefined(var_03.owner))
		{
			var_03 = var_03.owner;
		}

		if(!isplayer(var_03))
		{
			continue;
		}

		var_03 maps\mp\_events::giveobjectivepointstreaks();
		wait(0.05);
	}
}

//Function Number: 14
func_7B2B(param_00,param_01,param_02)
{
	var_03 = gettime();
	if(gettime() < level.laststatus[param_01] + 5000 && !isdefined(param_02) || !param_02)
	{
	}

	thread func_2526(param_00,param_01);
	level.laststatus[param_01] = gettime();
}

//Function Number: 15
onenduse(param_00,param_01,param_02)
{
	if(isplayer(param_01))
	{
		param_01 setclientomnvar("ui_dom_securing",0);
		param_01.ui_dom_securing = undefined;
	}

	var_03 = maps\mp\gametypes\_gameobjects::func_3B78();
	if(var_03 != "neutral")
	{
		maps\mp\gametypes\_gameobjects::func_6E14("enemy","waypoint_capture" + self.label);
		maps\mp\gametypes\_gameobjects::func_6E15("enemy","waypoint_capture" + self.label);
		maps\mp\gametypes\_gameobjects::func_6E14("friendly","waypoint_defend" + self.label);
		maps\mp\gametypes\_gameobjects::func_6E15("friendly","waypoint_defend" + self.label);
	}
	else
	{
		maps\mp\gametypes\_gameobjects::func_6E14("enemy","waypoint_captureneutral" + self.label);
		maps\mp\gametypes\_gameobjects::func_6E15("enemy","waypoint_captureneutral" + self.label);
		maps\mp\gametypes\_gameobjects::func_6E14("friendly","waypoint_captureneutral" + self.label);
		maps\mp\gametypes\_gameobjects::func_6E15("friendly","waypoint_captureneutral" + self.label);
	}

	if(param_00 == "allies")
	{
		common_scripts\utility::array_remove(level.alliescapturing,self.label);
	}

	common_scripts\utility::array_remove(level.axiscapturing,self.label);
}

//Function Number: 16
func_660A()
{
	var_00 = maps\mp\gametypes\_gameobjects::func_3B78();
	if(var_00 == "neutral")
	{
		func_6005();
	}

	foreach(var_02 in level.players)
	{
		showcapturedbaseeffecttoplayer(var_00,var_02);
	}
}

//Function Number: 17
onuse(param_00)
{
	var_01 = param_00.team;
	var_02 = maps\mp\gametypes\_gameobjects::func_3B78();
	self.capturetime = gettime();
	self.firstcapture = 0;
	func_7034(var_01);
	level.usestartspawns = 0;
	if(var_02 == "neutral")
	{
		var_03 = maps\mp\_utility::getotherteam(var_01);
		thread maps\mp\_utility::func_61A1(var_01,var_03,undefined,undefined,"mp_dom_flag_captured",undefined,param_00);
		if(func_3C33(var_01) < level.flags.size)
		{
			func_7B2B("secured" + self.label,var_01,1);
			func_7B2B("enemy_has" + self.label,var_03,1);
		}
		else
		{
			func_7B2B("secure_all",var_01);
			func_7B2B("lost_all",var_03);
			foreach(var_05 in level.players)
			{
				if(var_05.team == var_01)
				{
					var_05 maps\mp\gametypes\_missions::func_61CE("ch_domdom");
				}
			}
		}
	}

	param_00 maps\mp\_events::giveobjectivepointstreaks();
	thread giveflagcapturexp(self.touchlist[var_01]);
}

//Function Number: 18
giveflagcapturexp(param_00)
{
	level endon("game_ended");
	var_01 = maps\mp\gametypes\_gameobjects::getearliestclaimplayer();
	if(isdefined(var_01.owner))
	{
		var_01 = var_01.owner;
	}

	level.lastcaptime = gettime();
	if(isplayer(var_01))
	{
		level thread maps\mp\_utility::func_7FA0("callout_securedposition" + self.label,var_01);
		var_01 thread maps\mp\_matchdata::loggameevent("capture",var_01.origin);
	}

	var_02 = getarraykeys(param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = param_00[var_02[var_03]].player;
		if(isdefined(var_04.owner))
		{
			var_04 = var_04.owner;
		}

		if(!isplayer(var_04))
		{
			continue;
		}

		var_04 thread maps\mp\gametypes\_hud_message::func_794C("capture",maps\mp\gametypes\_rank::func_3BE0("capture"));
		var_04 thread func_86DF();
		var_04 thread maps\mp\gametypes\_rank::giverankxp("capture",maps\mp\gametypes\_rank::func_3BE0("capture") * var_04 getcapxpscale());
		maps\mp\gametypes\_gamescore::func_3D00("capture",var_04);
		var_04 maps\mp\_utility::func_447B("pointscaptured",1);
		var_04 maps\mp\_utility::func_4479("captures",1);
		var_04 maps\mp\gametypes\_persistence::func_7B28("round","captures",var_04.pers["captures"]);
		var_04 maps\mp\gametypes\_missions::func_61CE("ch_domcap");
		var_04 maps\mp\_utility::setextrascore0(var_04.pers["captures"]);
		if(var_04 != var_01)
		{
			var_04 maps\mp\_events::giveobjectivepointstreaks();
		}

		wait(0.05);
	}
}

//Function Number: 19
func_2526(param_00,param_01)
{
	level endon("game_ended");
	wait(0.1);
	maps\mp\_utility::func_8BC1();
	maps\mp\_utility::func_4D30(param_00,param_01);
}

//Function Number: 20
func_86E4()
{
	level endon("game_ended");
	while(!level.gameended)
	{
		var_00 = func_3B77();
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
				var_06 = var_02 maps\mp\gametypes\_gameobjects::func_3B78();
				maps\mp\gametypes\_gamescore::giveteamscoreforobjective(var_06,1);
			}
		}

		var_08 = gettime() - level.lastcaptime;
		if(maps\mp\_utility::func_50C1() && var_00.size < 2 && var_08 > 120000)
		{
			level.finalkillcam_winner = "none";
			thread maps\mp\gametypes\_gamelogic::endgame("none",game["end_reason"]["time_limit_reached"]);
		}

		wait(5);
		maps\mp\gametypes\_hostmigration::func_8BBA();
	}
}

//Function Number: 21
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isplayer(param_01) || param_01.team == self.team)
	{
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
		var_10 = var_0C.team;
		if(var_0F == "neutral")
		{
			continue;
		}

		if(var_10 == var_0F)
		{
			var_0A = 1;
			param_01 thread maps\mp\gametypes\_hud_message::func_794C("assault",maps\mp\gametypes\_rank::func_3BE0("assault"));
			param_01 thread maps\mp\gametypes\_rank::giverankxp("assault");
			maps\mp\gametypes\_gamescore::func_3D00("assault",param_01);
			thread maps\mp\_matchdata::func_4F1A(param_09,"defending");
			continue;
		}

		var_0B = 1;
		param_01 thread maps\mp\gametypes\_hud_message::func_794C("defend",maps\mp\gametypes\_rank::func_3BE0("defend"));
		param_01 thread maps\mp\gametypes\_rank::giverankxp("defend");
		maps\mp\gametypes\_gamescore::func_3D00("defend",param_01);
		param_01 maps\mp\_utility::func_4479("defends",1);
		param_01 maps\mp\gametypes\_persistence::func_7B28("round","defends",param_01.pers["defends"]);
		param_01 maps\mp\gametypes\_missions::func_61CE("ch_domprotector");
		thread maps\mp\_matchdata::func_4F1A(param_09,"assaulting");
	}

	foreach(var_0E in param_01.touchtriggers)
	{
		if(var_0E != level.flags[0] && var_0E != level.flags[1] && var_0E != level.flags[2])
		{
			continue;
		}

		var_0F = var_0E.useobj.ownerteam;
		var_13 = param_01.team;
		if(var_0F == "neutral")
		{
			continue;
		}

		if(var_13 != var_0F)
		{
			if(!var_0A)
			{
				param_01 thread maps\mp\gametypes\_hud_message::func_794C("assault",maps\mp\gametypes\_rank::func_3BE0("assault"));
			}

			param_01 thread maps\mp\gametypes\_rank::giverankxp("assault");
			maps\mp\gametypes\_gamescore::func_3D00("assault",param_01);
			thread maps\mp\_matchdata::func_4F1A(param_09,"defending");
		}
	}

	foreach(var_0E in level.flags)
	{
		var_0F = var_0E.useobj.ownerteam;
		var_13 = param_01.team;
		var_16 = distancesquared(var_0E.origin,var_0C.origin);
		var_17 = 90000;
		if(var_13 == var_0F && var_16 < var_17)
		{
			if(!var_0B)
			{
				param_01 thread maps\mp\gametypes\_hud_message::func_794C("defend",maps\mp\gametypes\_rank::func_3BE0("defend"));
			}

			param_01 thread maps\mp\gametypes\_rank::giverankxp("defend");
			maps\mp\gametypes\_gamescore::func_3D00("defend",param_01);
			param_01 maps\mp\_utility::func_4479("defends",1);
			param_01 maps\mp\gametypes\_persistence::func_7B28("round","defends",param_01.pers["defends"]);
			thread maps\mp\_matchdata::func_4F1A(param_09,"assaulting");
		}
	}
}

//Function Number: 22
func_3B77()
{
	var_00 = [];
	foreach(var_02 in level.domflags)
	{
		if(var_02 maps\mp\gametypes\_gameobjects::func_3B78() != "neutral" && isdefined(var_02.capturetime))
		{
			var_00[var_00.size] = var_02;
		}
	}

	return var_00;
}

//Function Number: 23
func_3C33(param_00)
{
	var_01 = 0;
	for(var_02 = 0;var_02 < level.flags.size;var_02++)
	{
		if(level.domflags[var_02] maps\mp\gametypes\_gameobjects::func_3B78() == param_00)
		{
			var_01++;
		}
	}

	return var_01;
}

//Function Number: 24
func_3AAB()
{
	return self.useobj maps\mp\gametypes\_gameobjects::func_3B78();
}

//Function Number: 25
func_33A8()
{
	foreach(var_01 in level.domflags)
	{
		switch(var_01.label)
		{
			case "_a":
				var_01.dompointnumber = 0;
				break;

			case "_b":
				var_01.dompointnumber = 1;
				break;

			case "_c":
				var_01.dompointnumber = 2;
				break;
		}
	}

	var_03 = maps\mp\gametypes\_spawnlogic::func_3BF6("mp_dom_spawn");
	foreach(var_05 in var_03)
	{
		var_05.dompointa = 0;
		var_05.dompointb = 0;
		var_05.dompointc = 0;
		var_05.nearflagpoint = func_3B3A(var_05);
		switch(var_05.nearflagpoint.useobj.dompointnumber)
		{
			case 0:
				var_05.dompointa = 1;
				break;

			case 1:
				var_05.dompointb = 1;
				break;

			case 2:
				var_05.dompointc = 1;
				break;
		}
	}
}

//Function Number: 26
func_3B3A(param_00)
{
	var_01 = maps\mp\gametypes\_spawnlogic::func_4928();
	var_02 = undefined;
	var_03 = undefined;
	foreach(var_05 in level.domflags)
	{
		var_06 = undefined;
		if(var_01)
		{
			var_06 = badplace_global(param_00.origin,var_05.levelflag.origin,999999);
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

//Function Number: 27
initgametypeawards()
{
	maps\mp\_awards::func_4652("pointscaptured",0,::maps\mp\_awards::highestwins);
}

//Function Number: 28
func_5976()
{
	maps\mp\_utility::setextrascore0(0);
	if(isdefined(self.pers["captures"]))
	{
		maps\mp\_utility::setextrascore0(self.pers["captures"]);
	}
}

//Function Number: 29
func_86DF()
{
	if(!isdefined(self.cpm))
	{
		self.numcaps = 0;
		self.cpm = 0;
	}

	self.numcaps++;
	if(maps\mp\_utility::func_3B2E() < 1)
	{
	}

	self.cpm = self.numcaps / maps\mp\_utility::func_3B2E();
}

//Function Number: 30
getcapxpscale()
{
	if(self.cpm < 4)
	{
		return 1;
	}

	return 0.25;
}

//Function Number: 31
func_7035()
{
	self notify("flag_neutral");
	maps\mp\gametypes\_gameobjects::func_708D("neutral");
	self.visuals[0] setmodel(game["flagmodels"]["neutral"]);
	foreach(var_01 in level.players)
	{
		var_02 = var_01._domflageffect[self.label];
		if(isdefined(var_02))
		{
			var_02 delete();
		}
	}

	func_6005();
}

//Function Number: 32
func_6005()
{
	if(isdefined(self.neutralflagfx))
	{
		self.neutralflagfx delete();
	}

	self.neutralflagfx = spawnfx(level.flagbasefxid["neutral"],self.baseeffectpos,self.baseeffectforward);
	triggerfx(self.neutralflagfx);
}

//Function Number: 33
func_7034(param_00)
{
	var_01 = maps\mp\gametypes\_gameobjects::func_3B06();
	maps\mp\gametypes\_gameobjects::func_708D(param_00);
	maps\mp\gametypes\_gameobjects::func_6E14("enemy","waypoint_capture" + var_01);
	maps\mp\gametypes\_gameobjects::func_6E15("enemy","waypoint_capture" + var_01);
	maps\mp\gametypes\_gameobjects::func_6E14("friendly","waypoint_defend" + self.label);
	maps\mp\gametypes\_gameobjects::func_6E15("friendly","waypoint_defend" + self.label);
	self.visuals[0] setmodel(game["flagmodels"][param_00]);
	self.neutralflagfx delete();
	foreach(var_03 in level.players)
	{
		showcapturedbaseeffecttoplayer(param_00,var_03);
	}

	thread baseeffectswaitforjoined();
}

//Function Number: 34
showcapturedbaseeffecttoplayer(param_00,param_01)
{
	if(isdefined(param_01._domflageffect[self.label]))
	{
		param_01._domflageffect[self.label] delete();
	}

	var_02 = undefined;
	var_03 = param_01.team;
	var_04 = param_01 setmlgcameradefaults();
	if(var_04)
	{
		var_03 = param_01 setmlgspectator();
	}
	else if(var_03 == "spectator")
	{
		var_03 = "allies";
	}

	if(var_03 == param_00)
	{
		var_02 = botgetteamlimit(level.flagbasefxid["friendly"],self.baseeffectpos,param_01,self.baseeffectforward);
	}
	else
	{
		var_02 = botgetteamlimit(level.flagbasefxid["enemy"],self.baseeffectpos,param_01,self.baseeffectforward);
	}

	param_01._domflageffect[self.label] = var_02;
	triggerfx(var_02);
}

//Function Number: 35
baseeffectswaitforjoined()
{
	level endon("game_ended");
	self endon("flag_neutral");
	for(;;)
	{
		level waittill("joined_team",var_00);
		if(isdefined(var_00._domflageffect[self.label]))
		{
			var_00._domflageffect[self.label] delete();
			var_00._domflageffect[self.label] = undefined;
		}

		if(var_00.team != "spectator")
		{
			showcapturedbaseeffecttoplayer(self.ownerteam,var_00);
		}
	}
}

//Function Number: 36
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00._domflageffect = [];
		var_00 thread func_5918();
		var_00 thread func_93EA();
	}
}

//Function Number: 37
func_5918()
{
	self waittill("disconnect");
	foreach(var_01 in self._domflageffect)
	{
		if(isdefined(var_01))
		{
			var_01 delete();
		}
	}
}

//Function Number: 38
func_93EA()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("luinotifyserver",var_00,var_01);
		if(var_00 == "mlg_view_change")
		{
			foreach(var_03 in level.domflags)
			{
				if(var_03.ownerteam != "neutral")
				{
					var_03 showcapturedbaseeffecttoplayer(var_03.ownerteam,self);
				}
			}
		}
	}
}