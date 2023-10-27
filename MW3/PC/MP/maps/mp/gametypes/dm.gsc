/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\dm.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 71 ms
 * Timestamp: 10/27/2023 2:13:12 AM
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
		maps\mp\_utility::registerscorelimitdvar(level.gametype,1000);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,1);
		maps\mp\_utility::registerroundlimitdvar(level.gametype,1);
		maps\mp\_utility::registernumlivesdvar(level.gametype,0);
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onnormaldeath = ::onnormaldeath;
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	game["dialog"]["gametype"] = "freeforall";
	if(getdvarint("g_hardcore"))
	{
		game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
		return;
	}

	if(getdvarint("camera_thirdPerson"))
	{
		game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
		return;
	}

	if(getdvarint("scr_diehard"))
	{
		game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
		return;
	}

	if(getdvarint("scr_" + level.gametype + "_promode"))
	{
		game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
		return;
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
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies","mp_dm_spawn");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis","mp_dm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	var_00[0] = "dm";
	maps\mp\gametypes\_gameobjects::main(var_00);
	maps\mp\gametypes\_rank::registerscoreinfo("kill",50);
	maps\mp\gametypes\_rank::registerscoreinfo("headshot",50);
	maps\mp\gametypes\_rank::registerscoreinfo("assist",10);
	maps\mp\gametypes\_rank::registerscoreinfo("suicide",0);
	maps\mp\gametypes\_rank::registerscoreinfo("teamkill",0);
	level.quickmessagetoall = 1;
}

//Function Number: 4
getspawnpoint()
{
	var_00 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(self.pers["team"]);
	var_01 = maps\mp\gametypes\_spawnlogic::getspawnpoint_dm(var_00);
	return var_01;
}

//Function Number: 5
onnormaldeath(param_00,param_01,param_02)
{
	var_03 = maps\mp\gametypes\_rank::getscoreinfovalue("kill");
	var_04 = 0;
	foreach(var_06 in level.players)
	{
		if(isdefined(var_06.score) && var_06.score > var_04)
		{
			var_04 = var_06.score;
		}
	}

	if(game["state"] == "postgame" && param_01.score >= var_04)
	{
		param_01.finalkill = 1;
	}
}