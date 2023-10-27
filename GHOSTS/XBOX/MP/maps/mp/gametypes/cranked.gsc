/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\cranked.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 21
 * Decompile Time: 380 ms
 * Timestamp: 10/27/2023 1:29:03 AM
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
		maps\mp\_utility::func_6475(level.gametype,100);
		maps\mp\_utility::func_6472(level.gametype,1);
		maps\mp\_utility::func_647C(level.gametype,1);
		maps\mp\_utility::func_6470(level.gametype,0);
		maps\mp\_utility::func_646A(level.gametype,0);
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	level.teambased = getdvarint("scr_cranked_teambased",1) == 1;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onnormaldeath = ::onnormaldeath;
	level.onsuicidedeath = ::onsuicidedeath;
	level.onteamchangedeath = ::onteamchangedeath;
	if(!level.teambased)
	{
		level.onplayerscore = ::onplayerscore;
		setdvar("scr_cranked_scorelimit",getdvarint("scr_cranked_scorelimit_ffa",60));
		setteammode("ffa");
	}

	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	game["dialog"]["gametype"] = "cranked";
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

	game["dialog"]["offense_obj"] = "crnk_hint";
	game["dialog"]["begin_cranked"] = "crnk_cranked";
	game["dialog"]["five_seconds_left"] = "crnk_det";
	game["strings"]["overtime_hint"] = &"MP_FIRST_BLOOD";
	level thread func_595D();
}

//Function Number: 2
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawned();
	}
}

//Function Number: 3
onplayerspawned()
{
	self endon("disconnect");
	self waittill("spawned_player");
}

//Function Number: 4
initializematchrules()
{
	maps\mp\_utility::func_700A();
	setdynamicdvar("scr_cranked_roundswitch",0);
	maps\mp\_utility::func_6473("cranked",0,0,9);
	setdynamicdvar("scr_cranked_roundlimit",1);
	maps\mp\_utility::func_6472("cranked",1);
	setdynamicdvar("scr_cranked_winlimit",1);
	maps\mp\_utility::func_647C("cranked",1);
	setdynamicdvar("scr_cranked_halftime",0);
	maps\mp\_utility::func_646A("cranked",0);
	setdynamicdvar("scr_cranked_promode",0);
}

//Function Number: 5
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

	var_02 = &"OBJECTIVES_WAR";
	var_03 = &"OBJECTIVES_WAR_SCORE";
	var_04 = &"OBJECTIVES_WAR_HINT";
	if(!level.teambased)
	{
		var_02 = &"OBJECTIVES_DM";
		var_03 = &"OBJECTIVES_DM_SCORE";
		var_04 = &"OBJECTIVES_DM_HINT";
	}

	maps\mp\_utility::func_7084("allies",var_02);
	maps\mp\_utility::func_7084("axis",var_02);
	if(level.splitscreen)
	{
		maps\mp\_utility::func_7083("allies",var_02);
		maps\mp\_utility::func_7083("axis",var_02);
	}
	else
	{
		maps\mp\_utility::func_7083("allies",var_03);
		maps\mp\_utility::func_7083("axis",var_03);
	}

	maps\mp\_utility::setobjectivehinttext("allies",var_04);
	maps\mp\_utility::setobjectivehinttext("axis",var_04);
	initspawns();
	cranked();
	var_05[0] = level.gametype;
	maps\mp\gametypes\_gameobjects::func_4FDD(var_05);
}

//Function Number: 6
initspawns()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	if(level.teambased)
	{
		maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
		maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
		maps\mp\gametypes\_spawnlogic::addspawnpoints("allies","mp_tdm_spawn");
		maps\mp\gametypes\_spawnlogic::addspawnpoints("axis","mp_tdm_spawn");
	}
	else
	{
		maps\mp\gametypes\_spawnlogic::addspawnpoints("allies","mp_dm_spawn");
		maps\mp\gametypes\_spawnlogic::addspawnpoints("axis","mp_dm_spawn");
	}

	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
}

//Function Number: 7
getspawnpoint()
{
	if(level.teambased)
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
			var_01 = maps\mp\gametypes\_spawnlogic::func_3C41(var_00);
			var_02 = maps\mp\gametypes\_spawnscoring::func_3BF1(var_01);
		}
	}
	else
	{
		var_01 = maps\mp\gametypes\_spawnlogic::func_3C41(self.team);
		if(level.ingraceperiod)
		{
			var_02 = maps\mp\gametypes\_spawnlogic::func_3BF2(var_02);
		}
		else
		{
			var_02 = maps\mp\gametypes\_spawnscoring::func_3BF0(var_02);
		}
	}

	return var_02;
}

//Function Number: 8
onnormaldeath(param_00,param_01,param_02)
{
	if(isdefined(param_00.cranked) && param_01 maps\mp\_utility::isenemy(param_00))
	{
		param_01 maps\mp\gametypes\_missions::func_61CE("ch_cranky");
	}

	param_00 func_9068();
	var_03 = maps\mp\gametypes\_rank::func_3BE0("score_increment");
	if(isdefined(param_01.cranked))
	{
		if(param_01.cranked_end_time - gettime() <= 1000)
		{
			param_01 maps\mp\gametypes\_missions::func_61CE("ch_cranked_reset");
		}

		var_03 = var_03 * 2;
		var_04 = "kill_cranked";
		param_01 thread onkill(var_04);
		param_01.pers["killChains"]++;
		param_01 maps\mp\gametypes\_persistence::func_7B28("round","killChains",param_01.pers["killChains"]);
	}
	else if(maps\mp\_utility::func_4945(param_01))
	{
		param_01 func_5012("begin_cranked");
	}

	if(isdefined(param_00.attackers) && !isdefined(level.assists_disabled))
	{
		foreach(var_06 in param_00.attackers)
		{
			if(!isdefined(maps\mp\_utility::_validateattacker(var_06)))
			{
				continue;
			}

			if(var_06 == param_01)
			{
				continue;
			}

			if(param_00 == var_06)
			{
				continue;
			}

			if(!isdefined(var_06.cranked))
			{
				continue;
			}

			var_06 thread func_58F4("assist_cranked");
		}
	}

	if(level.teambased)
	{
		level maps\mp\gametypes\_gamescore::giveteamscoreforobjective(param_01.pers["team"],var_03);
		if(game["state"] == "postgame" && game["teamScores"][param_01.team] > game["teamScores"][level.otherteam[param_01.team]])
		{
			param_01.finalkill = 1;
		}
	}

	var_08 = 0;
	foreach(var_06 in level.players)
	{
		if(isdefined(var_06.score) && var_06.score > var_08)
		{
			var_08 = var_06.score;
		}
	}

	if(game["state"] == "postgame" && param_01.score >= var_08)
	{
		param_01.finalkill = 1;
	}
}

//Function Number: 9
onsuicidedeath(param_00)
{
	param_00 func_9068();
}

//Function Number: 10
onteamchangedeath(param_00)
{
	param_00 func_9068();
}

//Function Number: 11
func_9068()
{
	self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds",0);
	self.cranked = undefined;
	self.cranked_end_time = undefined;
}

//Function Number: 12
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

//Function Number: 13
onplayerscore(param_00,param_01,param_02)
{
	if(param_00 == "kill")
	{
		var_03 = maps\mp\gametypes\_rank::func_3BE0("score_increment");
		if(isdefined(param_01.cranked))
		{
			var_03 = var_03 * 2;
		}

		return var_03;
	}

	return 0;
}

//Function Number: 14
cranked()
{
	level.crankedbombtimer = 30;
}

//Function Number: 15
func_5012(param_00)
{
	maps\mp\_utility::func_4D35(param_00);
	thread maps\mp\gametypes\_rank::func_8E6E(param_00);
	func_700D("kill");
	self.cranked = 1;
	maps\mp\_utility::func_3CFB("specialty_fastreload",0);
	maps\mp\_utility::func_3CFB("specialty_quickdraw",0);
	maps\mp\_utility::func_3CFB("specialty_fastoffhand",0);
	maps\mp\_utility::func_3CFB("specialty_fastsprintrecovery",0);
	maps\mp\_utility::func_3CFB("specialty_marathon",0);
	maps\mp\_utility::func_3CFB("specialty_quickswap",0);
	maps\mp\_utility::func_3CFB("specialty_stalker",0);
	self.movespeedscaler = 1.2;
	maps\mp\gametypes\_weapons::func_8707();
}

//Function Number: 16
onkill(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	while(!isdefined(self.pers))
	{
		wait(0.05);
	}

	thread maps\mp\gametypes\_rank::func_8E6E(param_00);
	maps\mp\gametypes\_gamescore::func_3D00(param_00,self,undefined,1);
	thread maps\mp\gametypes\_rank::giverankxp(param_00);
	func_700D("kill");
}

//Function Number: 17
func_58F4(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	thread maps\mp\gametypes\_rank::func_8E6E(param_00);
	func_700D("assist");
}

//Function Number: 18
func_8CCB(param_00)
{
	self notify("watchBombTimer");
	self endon("watchBombTimer");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_01 = 5;
	maps\mp\gametypes\_hostmigration::func_8B0C(param_00 - var_01 - 1);
	maps\mp\_utility::func_4D35("five_seconds_left");
	maps\mp\gametypes\_hostmigration::func_8B0C(1);
	self setclientomnvar("ui_cranked_bomb_timer_final_seconds",1);
	while(var_01 > 0)
	{
		self playsoundtoplayer("mp_cranked_countdown",self);
		maps\mp\gametypes\_hostmigration::func_8B0C(1);
		var_01--;
	}

	if(isdefined(self) && maps\mp\_utility::func_4945(self))
	{
		self playsound("grenade_explode_metal");
		playfx(level.mine_explode,self.origin + (0,0,32));
		maps\mp\_utility::_suicide();
		self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds",0);
	}
}

//Function Number: 19
func_700D(param_00)
{
	var_01 = level.crankedbombtimer;
	if(param_00 == "assist")
	{
		var_01 = castint(min(self.cranked_end_time - gettime() / 1000 + level.crankedbombtimer * 0.5,level.crankedbombtimer));
	}

	var_02 = var_01 * 1000 + gettime();
	self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds",var_02);
	self.cranked_end_time = var_02;
	thread func_9594();
	thread func_8CCB(var_01);
	thread func_8CE1();
}

//Function Number: 20
func_9594()
{
	self notify("watchCrankedHostMigration");
	self endon("watchCrankedHostMigration");
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	level waittill("host_migration_begin");
	var_00 = maps\mp\gametypes\_hostmigration::func_8BBA();
	if(self.cranked_end_time + var_00 < 5)
	{
		self setclientomnvar("ui_cranked_bomb_timer_final_seconds",1);
	}

	if(var_00 > 0)
	{
		self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds",self.cranked_end_time + var_00);
	}

	self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds",self.cranked_end_time);
}

//Function Number: 21
func_8CE1()
{
	self notify("watchEndGame");
	self endon("watchEndGame");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		if(game["state"] == "postgame" || level.gameended)
		{
			self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds",0);
			break;
		}

		wait(0.1);
	}
}