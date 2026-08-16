/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\dm.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
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
	level.onstartgametype = ::UnknownLocalCall;
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

}

getspawnpoint()
{
	spawnpoints = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(self.pers["team"]);
	spawnpoint = maps\mp\gametypes\_spawnlogic::getspawnpoint_dm(spawnpoints);
	return spawnpoint;
}