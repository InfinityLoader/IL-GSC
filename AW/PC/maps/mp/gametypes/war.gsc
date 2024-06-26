/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\war.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 121 ms
 * Timestamp: 4/22/2024 2:11:11 AM
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
		maps\mp\_utility::registerroundswitchdvar(level.gametype,0,0,9);
		maps\mp\_utility::registertimelimitdvar(level.gametype,10);
		maps\mp\_utility::registerscorelimitdvar(level.gametype,75);
		maps\mp\_utility::registerroundlimitdvar(level.gametype,1);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,1);
		maps\mp\_utility::registernumlivesdvar(level.gametype,0);
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
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

	game["dialog"]["gametype"] = "tdm_intro";
	if(getdvarint("g_hardcore"))
	{
		game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
	}

	game["dialog"]["defense_obj"] = "gbl_start";
	game["dialog"]["offense_obj"] = "gbl_start";
	if(maps\mp\_utility::isaugmentedgamemode())
	{
		game["dialog"]["defense_obj"] = "tdm_start";
		game["dialog"]["offense_obj"] = "tdm_start";
	}

	game["strings"]["overtime_hint"] = &"MP_FIRST_BLOOD";
	if(level.practiceround)
	{
		game["dialog"]["gametype"] = "ptr_welcome";
		game["dialog"]["ptr_new_best"] = "ptr_new_best";
		game["dialog"]["ptr_assist"] = "ptr_assist";
		game["dialog"]["ptr_headshot"] = "ptr_headshot";
		game["dialog"]["ptr_greatshot"] = "ptr_greatshot";
	}

	if(maps\mp\_utility::isgrapplinghookgamemode())
	{
		game["dialog"]["gametype"] = "grap_" + game["dialog"]["gametype"];
	}
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::setcommonrulesfrommatchrulesdata();
	setdynamicdvar("scr_war_roundswitch",0);
	maps\mp\_utility::registerroundswitchdvar("war",0,0,9);
	setdynamicdvar("scr_war_roundlimit",1);
	maps\mp\_utility::registerroundlimitdvar("war",1);
	setdynamicdvar("scr_war_winlimit",1);
	maps\mp\_utility::registerwinlimitdvar("war",1);
	setdynamicdvar("scr_war_halftime",0);
	maps\mp\_utility::registerhalftimedvar("war",0);
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
	initspawns();
	var_02[0] = level.gametype;
	maps\mp\gametypes\_gameobjects::main(var_02);
}

//Function Number: 4
initspawns()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
	level.spawn_name = "mp_tdm_spawn";
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies",level.spawn_name);
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis",level.spawn_name);
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

	if(level.usestartspawns && level.ingraceperiod)
	{
		var_01 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_tdm_spawn_" + var_00 + "_start");
		var_02 = maps\mp\gametypes\_spawnlogic::getspawnpoint_startspawn(var_01);
	}
	else
	{
		var_01 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_02);
		var_02 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(var_02,var_01);
	}

	maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(var_02);
	return var_02;
}

//Function Number: 6
onnormaldeath(param_00,param_01,param_02)
{
	level maps\mp\gametypes\_gamescore::giveteamscoreforobjective(param_01.pers["team"],1);
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

	if(maps\mp\_utility::practiceroundgame())
	{
		var_00 = "none";
	}

	thread maps\mp\gametypes\_gamelogic::endgame(var_00,game["end_reason"]["time_limit_reached"]);
}