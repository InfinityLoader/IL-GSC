/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\war.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 130 ms
 * Timestamp: 10/27/2023 1:20:04 AM
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
		maps\mp\_utility::func_6473(level.gametype,0,0,9);
		maps\mp\_utility::func_6476(level.gametype,10);
		maps\mp\_utility::func_6475(level.gametype,75);
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
	level.onnormaldeath = ::onnormaldeath;
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	game["dialog"]["gametype"] = "tm_death";
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

	game["strings"]["overtime_hint"] = &"MP_FIRST_BLOOD";
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::func_700A();
	setdynamicdvar("scr_war_roundswitch",0);
	maps\mp\_utility::func_6473("war",0,0,9);
	setdynamicdvar("scr_war_roundlimit",1);
	maps\mp\_utility::func_6472("war",1);
	setdynamicdvar("scr_war_winlimit",1);
	maps\mp\_utility::func_647C("war",1);
	setdynamicdvar("scr_war_halftime",0);
	maps\mp\_utility::func_646A("war",0);
	setdynamicdvar("scr_war_promode",0);
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

	maps\mp\_utility::func_7084("allies",&"OBJECTIVES_WAR");
	maps\mp\_utility::func_7084("axis",&"OBJECTIVES_WAR");
	if(level.splitscreen)
	{
		maps\mp\_utility::func_7083("allies",&"OBJECTIVES_WAR");
		maps\mp\_utility::func_7083("axis",&"OBJECTIVES_WAR");
	}
	else
	{
		maps\mp\_utility::func_7083("allies",&"OBJECTIVES_WAR_SCORE");
		maps\mp\_utility::func_7083("axis",&"OBJECTIVES_WAR_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_WAR_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_WAR_HINT");
	initspawns();
	var_02[0] = level.gametype;
	maps\mp\gametypes\_gameobjects::func_4FDD(var_02);
}

//Function Number: 4
initspawns()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies","mp_tdm_spawn");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis","mp_tdm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
}

//Function Number: 5
getspawnpoint()
{
	var_00 = self.pers["team"];
	if(game["switchedsides"])
	{
		var_00 = maps\mp\_utility::getotherteam(var_00);
	}

	if(maps\mp\gametypes\_spawnlogic::func_948D())
	{
		var_01 = maps\mp\gametypes\_spawnlogic::func_3BF6("mp_tdm_spawn_" + var_00 + "_start");
		var_02 = maps\mp\gametypes\_spawnlogic::func_3BF5(var_01);
	}
	else
	{
		var_01 = maps\mp\gametypes\_spawnlogic::func_3C41(var_02);
		var_02 = maps\mp\gametypes\_spawnscoring::func_3BF1(var_02);
	}

	return var_02;
}

//Function Number: 6
onnormaldeath(param_00,param_01,param_02)
{
	var_03 = maps\mp\gametypes\_rank::func_3BE0("score_increment");
	level maps\mp\gametypes\_gamescore::giveteamscoreforobjective(param_01.pers["team"],var_03);
	if(game["state"] == "postgame" && game["teamScores"][param_01.team] > game["teamScores"][level.otherteam[param_01.team]])
	{
		param_01.finalkill = 1;
	}
}

//Function Number: 7
ontimelimit()
{
	level.finalkillcam_winner = "none";
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
		level.finalkillcam_winner = "axis";
		var_00 = "axis";
	}
	else
	{
		level.finalkillcam_winner = "allies";
		var_00 = "allies";
	}

	thread maps\mp\gametypes\_gamelogic::endgame(var_00,game["end_reason"]["time_limit_reached"]);
}