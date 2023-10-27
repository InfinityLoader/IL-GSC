/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\dm.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 7
 * Decompile Time: 156 ms
 * Timestamp: 10/27/2023 1:29:04 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
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
		maps\mp\_utility::func_6476(level.gametype,10);
		maps\mp\_utility::func_6475(level.gametype,30);
		maps\mp\_utility::func_647C(level.gametype,1);
		maps\mp\_utility::func_6472(level.gametype,1);
		maps\mp\_utility::func_6470(level.gametype,0);
		maps\mp\_utility::func_646A(level.gametype,0);
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.var_5976 = ::func_5976;
	level.onnormaldeath = ::onnormaldeath;
	level.onplayerscore = ::onplayerscore;
	level.assists_disabled = 1;
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	setteammode("ffa");
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
	maps\mp\_utility::func_700A(1);
	setdynamicdvar("scr_dm_winlimit",1);
	maps\mp\_utility::func_647C("dm",1);
	setdynamicdvar("scr_dm_roundlimit",1);
	maps\mp\_utility::func_6472("dm",1);
	setdynamicdvar("scr_dm_halftime",0);
	maps\mp\_utility::func_646A("dm",0);
}

//Function Number: 3
onstartgametype()
{
	setclientnamemode("auto_change");
	maps\mp\_utility::func_7084("allies",&"OBJECTIVES_DM");
	maps\mp\_utility::func_7084("axis",&"OBJECTIVES_DM");
	if(level.splitscreen)
	{
		maps\mp\_utility::func_7083("allies",&"OBJECTIVES_DM");
		maps\mp\_utility::func_7083("axis",&"OBJECTIVES_DM");
	}
	else
	{
		maps\mp\_utility::func_7083("allies",&"OBJECTIVES_DM_SCORE");
		maps\mp\_utility::func_7083("axis",&"OBJECTIVES_DM_SCORE");
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
	maps\mp\gametypes\_gameobjects::func_4FDD(var_00);
	level.quickmessagetoall = 1;
}

//Function Number: 4
getspawnpoint()
{
	var_00 = maps\mp\gametypes\_spawnlogic::func_3C41(self.team);
	if(level.ingraceperiod)
	{
		var_01 = maps\mp\gametypes\_spawnscoring::func_91F9(var_00);
	}
	else
	{
		var_01 = maps\mp\gametypes\_spawnscoring::func_3BF0(var_01);
	}

	return var_01;
}

//Function Number: 5
func_5976()
{
	level notify("spawned_player");
	if(!isdefined(self.eventvalue))
	{
		self.eventvalue = maps\mp\gametypes\_rank::func_3BE0("kill");
		maps\mp\_utility::setextrascore0(self.eventvalue);
	}
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
	param_01.assists = param_01 maps\mp\_utility::func_3B8D("longestStreak");
	if(param_00 == "kill")
	{
		var_03 = maps\mp\gametypes\_rank::func_3BE0("score_increment");
		return var_03;
	}

	return 0;
}