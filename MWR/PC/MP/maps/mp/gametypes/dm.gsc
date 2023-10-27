/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\dm.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 125 ms
 * Timestamp: 10/27/2023 2:38:09 AM
*******************************************************************/

//Function Number: 1
main()
{
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

	level.classicgamemode = 1;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onnormaldeath = ::onnormaldeath;
	level.onplayerscore = ::onplayerscore;
	if(getdvarint("party_maxPlayers",18) == 2)
	{
		level.xpgamemodescale = 2;
	}

	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	setteammode("ffa");
	game["dialog"]["gametype"] = "freeforall";
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
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies","mp_dm_spawn");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis","mp_dm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	var_00[0] = "dm";
	maps\mp\gametypes\_gameobjects::main(var_00);
	level.quickmessagetoall = 1;
}

//Function Number: 4
getspawnpoint()
{
	if(level.ingraceperiod)
	{
		var_00 = maps\mp\gametypes\_spawnlogic::getstartspawnffa(self.team);
	}
	else
	{
		var_01 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(self.team);
		var_00 = maps\mp\gametypes\_spawnscoring::getspawnpoint_freeforall(var_01);
	}

	maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(var_00);
	return var_00;
}

//Function Number: 5
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

//Function Number: 6
onplayerscore(param_00,param_01,param_02)
{
	var_03 = maps\mp\gametypes\_rank::getscoreinfovalue(param_00);
	param_01 maps\mp\_utility::setextrascore0(param_01.extrascore0 + var_03);
	param_01 maps\mp\gametypes\_gamescores::updatescorestatsffa(param_01,var_03);
	if(isscoringevent(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 7
isscoringevent(param_00)
{
	switch(param_00)
	{
		case "helicopter_mp_kill":
		case "airstrike_mp_kill":
		case "kill":
			break;
	}
}