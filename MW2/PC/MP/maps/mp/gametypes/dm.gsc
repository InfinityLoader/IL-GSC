/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\dm.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	maps\mp\gametypes\_globallogic::init();
	maps\mp\gametypes\_callbacksetup::setupcallbacks();
	maps\mp\gametypes\_globallogic::setupcallbacks();
	maps\mp\_utility::registertimelimitdvar(level.gametype, 10, 0, 1440);
	maps\mp\_utility::registerscorelimitdvar(level.gametype, 1000, 0, 5000);
	maps\mp\_utility::registerwinlimitdvar(level.gametype, 1, 0, 5000);
	maps\mp\_utility::registerroundlimitdvar(level.gametype, 1, 0, 10);
	maps\mp\_utility::registernumlivesdvar(level.gametype, 0, 0, 10);
	maps\mp\_utility::registerhalftimedvar(level.gametype, 0, 0, 1);
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
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

onstartgametype()
{
	setclientnamemode("auto_change");
	maps\mp\_utility::setobjectivetext("allies", &"OBJECTIVES_DM");
	maps\mp\_utility::setobjectivetext("axis", &"OBJECTIVES_DM");
	if(level.splitscreen)
	{
		maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_DM");
		maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_DM");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext("allies", &"OBJECTIVES_DM_SCORE");
		maps\mp\_utility::setobjectivescoretext("axis", &"OBJECTIVES_DM_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies", &"OBJECTIVES_DM_HINT");
	maps\mp\_utility::setobjectivehinttext("axis", &"OBJECTIVES_DM_HINT");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies", "mp_dm_spawn");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis", "mp_dm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins, level.spawnmaxs);
	setmapcenter(level.mapcenter);
	allowed[0] = "dm";
	maps\mp\gametypes\_gameobjects::main(allowed);
	maps\mp\gametypes\_rank::registerscoreinfo("kill", 50);
	maps\mp\gametypes\_rank::registerscoreinfo("headshot", 50);
	maps\mp\gametypes\_rank::registerscoreinfo("assist", 10);
	maps\mp\gametypes\_rank::registerscoreinfo("suicide", 0);
	maps\mp\gametypes\_rank::registerscoreinfo("teamkill", 0);
	level.quickmessagetoall = 1;
}

getspawnpoint()
{
	spawnpoints = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(self.pers["team"]);
	spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_dm(spawnpoints);
	return spawnpoint;
}