/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\war.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	if(getdvar("mapname") == "mp_background")
	{
		return;
	}

	maps\mp\gametypes\_globallogic::init();
	maps\mp\gametypes\_callbacksetup::setupcallbacks();
	maps\mp\gametypes\_globallogic::setupcallbacks();
	maps\mp\_utility::registerroundswitchdvar(level.gametype, 0, 0, 9);
	maps\mp\_utility::registertimelimitdvar(level.gametype, 10, 0, 1440);
	maps\mp\_utility::registerscorelimitdvar(level.gametype, 500, 0, 5000);
	maps\mp\_utility::registerroundlimitdvar(level.gametype, 1, 0, 10);
	maps\mp\_utility::registerwinlimitdvar(level.gametype, 1, 0, 10);
	maps\mp\_utility::registerroundswitchdvar(level.gametype, 3, 0, 30);
	maps\mp\_utility::registernumlivesdvar(level.gametype, 0, 0, 10);
	maps\mp\_utility::registerhalftimedvar(level.gametype, 0, 0, 1);
	level.teambased = 1;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onnormaldeath = ::onnormaldeath;
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

onstartgametype()
{
	setclientnamemode("auto_change");
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	if(game["switchedsides"])
	{
		oldattackers = game["attackers"];
		olddefenders = game["defenders"];
		game["attackers"] = olddefenders;
		game["defenders"] = oldattackers;
	}

	maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_WAR");
	maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_WAR");
	if(level.splitscreen)
	{
		maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_WAR");
		maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_WAR");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_WAR_SCORE");
		maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_WAR_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies", &"OBJECTIVES_WAR_HINT");
	maps\mp\_utility::setobjectivehinttext("axis", &"OBJECTIVES_WAR_HINT");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_tdm_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_tdm_spawn_axis_start");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies", "mp_tdm_spawn");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis", "mp_tdm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
	setmapcenter(level.mapcenter);
	allowed[0] = level.gametype;
	allowed[1] = "airdrop_pallet";
	maps\mp\gametypes\_gameobjects::main(allowed);
}

getspawnpoint()
{
	spawnteam = self.pers["team"];
	if(game["switchedsides"])
	{
		spawnteam = maps\mp\_utility::getotherteam(spawnteam);
	}

	if(level.ingraceperiod)
	{
		spawnpoints = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_tdm_spawn_" + spawnteam + "_start");
		spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(spawnpoints);
	}
	else
	{
		spawnpoints = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(spawnteam);
		spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(spawnpoints);
	}

	return spawnpoint;
}

onnormaldeath(victim, attacker, lifeid)
{
	score = maps\mp\gametypes\_rank::getscoreinfovalue("kill");
	attacker maps\mp\gametypes\_gamescore::giveteamscoreforobjective(attacker.pers["team"], score);
	if(game["state"] == "postgame" && game["teamScores"][attacker.team] > game["teamScores"][level.otherteam[attacker.team]])
	{
		attacker.finalkill = 1;
		return;
	}
}

ontimelimit()
{
	if(game["status"] == "overtime")
	{
		winner = "forfeit";
	}
	else if(game["teamScores"]["allies"] == game["teamScores"]["axis"])
	{
		winner = "overtime";
	}
	else if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
	{
		winner = "axis";
	}
	else
	{
		winner = "allies";
	}

	thread maps\mp\gametypes\_gamelogic::endgame(winner, game["strings"]["time_limit_reached"]);
}