/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\vlobby.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 123 ms
 * Timestamp: 10/27/2023 1:43:26 AM
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
	level.rankedmatch = 0;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onspawnplayer = ::onspawnplayer;
	maps\mp\_utility::registernumlivesdvar(level.gametype,0);
	maps\mp\_utility::registertimelimitdvar(level.gametype,0);
	maps\mp\_utility::registerscorelimitdvar(level.gametype,1);
	maps\mp\_utility::registerhalftimedvar(level.gametype,0);
	level.classold = level.class;
	level.class = ::menuclass;
	game["menu_team"] = "main";
	game["menu_class_allies"] = "main";
	game["menu_class_axis"] = "main";
	game["menu_changeclass_allies"] = "main";
	game["menu_changeclass_axis"] = "main";
	game["menu_changeclass"] = "menu_cac_assault";
	game["allies"] = "sentinel_vl";
	game["axis"] = "atlas";
}

//Function Number: 2
menuclass(param_00)
{
	level.ingraceperiod = 1;
	self.hasdonecombat = 0;
	[[ level.classold ]](param_00);
}

//Function Number: 3
onstartgametype()
{
	setclientnamemode("auto_change");
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	maps\mp\_utility::setobjectivetext("allies",&"OBJECTIVES_WAR");
	maps\mp\_utility::setobjectivetext("axis",&"OBJECTIVES_WAR");
	maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_WAR");
	maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_WAR");
	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_WAR");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_WAR");
	init_spawns();
	var_00[0] = level.gametype;
	maps\mp\gametypes\_gameobjects::main(var_00);
	level.prematchperiod = 0;
	level.prematchperiodend = 0;
}

//Function Number: 4
init_spawns()
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
getspawnpoint(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 0;
		for(var_01 = 0;var_01 < level.players.size;var_01++)
		{
			if(level.players[var_01] == self)
			{
				param_00 = var_01;
				break;
			}
		}
	}

	var_02 = getentarray("player_pos","targetname");
	var_03 = undefined;
	foreach(var_03 in var_02)
	{
		if(var_03.script_noteworthy == "" + param_00)
		{
			break;
		}
	}

	if(!isdefined(var_03))
	{
		var_03 = var_02[0];
	}

	self.avatar_spawnpoint = var_03;
	return var_03;
}

//Function Number: 6
onspawnplayer()
{
	if(isdefined(level.vl_onspawnplayer))
	{
		self [[ level.vl_onspawnplayer ]]();
	}
}