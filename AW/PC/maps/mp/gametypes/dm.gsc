/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\dm.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 146 ms
 * Timestamp: 4/22/2024 2:10:45 AM
*******************************************************************/

//Function Number: 1
main()
{
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
		maps\mp\_utility::registertimelimitdvar(level.gametype,10);
		maps\mp\_utility::registerscorelimitdvar(level.gametype,30);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,1);
		maps\mp\_utility::registerroundlimitdvar(level.gametype,1);
		maps\mp\_utility::registernumlivesdvar(level.gametype,0);
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
		maps\mp\_utility::registerscorelimitdvar(level.gametype,30);
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onnormaldeath = ::onnormaldeath;
	level.onplayerscore = ::onplayerscore;
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	setteammode("ffa");
	game["dialog"]["gametype"] = "ffa_intro";
	game["dialog"]["defense_obj"] = "gbl_start";
	game["dialog"]["offense_obj"] = "gbl_start";
	if(getdvarint("g_hardcore"))
	{
		game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
	}

	if(maps\mp\_utility::isgrapplinghookgamemode())
	{
		game["dialog"]["gametype"] = "grap_" + game["dialog"]["gametype"];
	}
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::setcommonrulesfrommatchrulesdata(1);
	setdynamicdvar("scr_dm_winlimit",1);
	maps\mp\_utility::registerwinlimitdvar("dm",1);
	setdynamicdvar("scr_dm_roundlimit",1);
	maps\mp\_utility::registerroundlimitdvar("dm",1);
	setdynamicdvar("scr_dm_halftime",0);
	maps\mp\_utility::registerhalftimedvar("dm",0);
}

//Function Number: 3
onstartgametype()
{
	setclientnamemode("auto_change");
	maps\mp\_utility::setobjectivetext("allies",&"OBJECTIVES_DM");
	maps\mp\_utility::setobjectivetext("axis",&"OBJECTIVES_DM");
	if(level.splitscreen)
	{
		maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_DM");
		maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_DM");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_DM_SCORE");
		maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_DM_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_DM_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_DM_HINT");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	level.spawn_name = "mp_dm_spawn";
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies",level.spawn_name);
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis",level.spawn_name);
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	var_00[0] = "dm";
	maps\mp\gametypes\_gameobjects::main(var_00);
	level.quickmessagetoall = 1;
}

//Function Number: 4
getstartspawnpoints(param_00)
{
	if(!isdefined(level.dmstartspawnpoints))
	{
		level.dmstartspawnpoints = [];
	}

	if(!isdefined(level.dmstartspawnpoints[param_00]))
	{
		var_01 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(param_00);
		level.dmstartspawnpoints[param_00] = [];
		foreach(var_03 in var_01)
		{
			if(isdefined(var_03.script_noteworthy) && var_03.script_noteworthy == "start_spawn")
			{
				level.dmstartspawnpoints[param_00][level.dmstartspawnpoints[param_00].size] = var_03;
			}
		}
	}

	if(level.dmstartspawnpoints[param_00].size >= level.players.size)
	{
		return level.dmstartspawnpoints[param_00];
	}

	return maps\mp\gametypes\_spawnlogic::getteamspawnpoints(param_00);
}

//Function Number: 5
getspawnpoint()
{
	if(level.ingraceperiod)
	{
		var_00 = getstartspawnpoints(self.team);
		var_01 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(var_00);
	}
	else
	{
		var_00 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(self.team);
		var_01 = maps\mp\gametypes\_spawnscoring::getspawnpoint_freeforall(var_01);
	}

	maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(var_01);
	return var_01;
}

//Function Number: 6
onnormaldeath(param_00,param_01,param_02)
{
	var_03 = 0;
	foreach(var_05 in level.players)
	{
		if(isdefined(var_05.score) && var_05.score > var_03)
		{
			var_03 = var_05.score;
		}
	}

	if(game["state"] == "postgame" && param_01.score >= var_03)
	{
		param_01.finalkill = 1;
	}
}

//Function Number: 7
onplayerscore(param_00,param_01,param_02)
{
	if(issoringevent(param_00))
	{
		var_03 = maps\mp\gametypes\_rank::getscoreinfovalue(param_00);
		param_01 maps\mp\_utility::setextrascore0(param_01.extrascore0 + var_03);
		param_01 maps\mp\gametypes\_gamescore::updatescorestatsffa(param_01,var_03);
		return 1;
	}

	return 0;
}

//Function Number: 8
issoringevent(param_00)
{
	switch(param_00)
	{
		case "map_killstreak_kill":
		case "airdrop_kill":
		case "airdrop_trap_kill":
		case "goliath_kill":
		case "assault_drone_kill":
		case "strafing_run_kill":
		case "sentry_gun_kill":
		case "missile_strike_kill":
		case "paladin_kill":
		case "warbird_kill":
		case "vulcan_kill":
		case "kill":
			return 1;
	}

	return 0;
}