/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\vip.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 322 ms
 * Timestamp: 10/27/2023 2:13:37 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(getdvar("mapname") == "mp_background")
	{
		return;
	}

	maps\mp\gametypes\_globallogic::init();
	maps\mp\gametypes\_callbacksetup::setupcallbacks();
	maps\mp\gametypes\_globallogic::setupcallbacks();
	maps\mp\_utility::registerroundswitchdvar(level.gametype,0,0,9);
	maps\mp\_utility::registertimelimitdvar(level.gametype,10,0,1440);
	maps\mp\_utility::registerscorelimitdvar(level.gametype,500,0,5000);
	maps\mp\_utility::registerroundlimitdvar(level.gametype,1,0,10);
	maps\mp\_utility::registerwinlimitdvar(level.gametype,1,0,10);
	maps\mp\_utility::registerroundswitchdvar(level.gametype,3,0,30);
	maps\mp\_utility::registernumlivesdvar(level.gametype,1,0,10);
	maps\mp\_utility::registerwatchdvarint("halftime",0);
	level.teambased = 1;
	level.objectivebased = 1;
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onspawnplayer = ::onspawnplayer;
	level.onnormaldeath = ::onnormaldeath;
	level.onplayerkilled = ::onplayerkilled;
	level.ondeadevent = ::ondeadevent;
	game["dialog"]["gametype"] = "VIP";
}

//Function Number: 2
onprecachegametype()
{
	precacheshader("compass_waypoint_captureneutral");
	precacheshader("compass_waypoint_capture");
	precacheshader("compass_waypoint_defend");
	precacheshader("waypoint_captureneutral");
	precacheshader("waypoint_capture");
	precacheshader("waypoint_defend");
	precachestring(&"MP_ELIMINATED_VIP");
	precachestring(&"MP_DEFENDED_VIP");
	precachestring(&"SPLASHES_VIP");
	game["flagmodels"] = [];
	game["flagmodels"]["neutral"] = "prop_flag_neutral";
	game["flagmodels"]["allies"] = maps\mp\gametypes\_teams::getteamflagmodel("allies");
	game["flagmodels"]["axis"] = maps\mp\gametypes\_teams::getteamflagmodel("axis");
	precachemodel(game["flagmodels"]["neutral"]);
	precachemodel(game["flagmodels"]["allies"]);
	precachemodel(game["flagmodels"]["axis"]);
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

	maps\mp\_utility::setobjectivetext("allies",&"OBJECTIVES_VIP");
	maps\mp\_utility::setobjectivetext("axis",&"OBJECTIVES_VIP");
	if(level.splitscreen)
	{
		maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_VIP");
		maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_VIP");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_VIP_SCORE");
		maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_VIP_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_VIP_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_VIP_HINT");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_tdm_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_tdm_spawn_axis_start");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies","mp_tdm_spawn");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis","mp_tdm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	var_02[0] = "vip";
	maps\mp\gametypes\_gameobjects::main(var_7B);
	thread func_3A69();
}

//Function Number: 4
func_3A69()
{
	level endon("game_end");
	level endon("waitSkipped");
	thread extractionzone();
	thread func_3A78();
	maps\mp\_utility::gameflagwait("prematch_done");
	maps\mp\_utility::gameflagwait("graceperiod_done");
	self notify("graceComplete");
	thread func_3A7B();
}

//Function Number: 5
func_3A78()
{
	self endon("graceComplete");
	for(;;)
	{
		if(level.players.size > 2)
		{
			break;
		}

		wait 0.5;
	}

	self notify("waitSkipped");
	thread func_3A7B();
}

//Function Number: 6
getspawnpoint()
{
	var_00 = self.pers["team"];
	if(game["switchedsides"])
	{
		var_00 = maps\mp\_utility::getotherteam(var_00);
	}

	if(level.ingraceperiod)
	{
		var_01 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_tdm_spawn_" + var_00 + "_start");
		var_02 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(var_01);
	}
	else
	{
		var_01 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_02);
		var_02 = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(var_02);
	}

	return var_02;
}

//Function Number: 7
onspawnplayer()
{
	self.isvip = 0;
	self.usingobj = undefined;
	level notify("spawned_player");
}

//Function Number: 8
onnormaldeath(param_00,param_01,param_02)
{
	var_03 = maps\mp\gametypes\_rank::getscoreinfovalue("kill");
	param_01 lib_036E::func_2B88(param_01.pers["team"],var_03);
	var_04 = param_00.team;
	if(isdefined(param_00.isvip) && param_00.isvip)
	{
		level thread func_3A7A(game["attackers"],&"MP_ELIMINATED_VIP");
		param_01.finalkill = 1;
	}
}

//Function Number: 9
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	thread func_3959();
}

//Function Number: 10
ontimelimit()
{
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
		var_00 = "axis";
	}
	else
	{
		var_00 = "allies";
	}

	thread maps\mp\gametypes\_gamelogic::endgame(var_00,game["strings"]["time_limit_reached"]);
}

//Function Number: 11
func_3959()
{
	wait 0.05;
	var_00 = 0;
	if(!level.alivecount[game["attackers"]])
	{
		level.spectateoverride[game["attackers"]].allowenemyspectate = 1;
		var_00 = 1;
	}

	if(!level.alivecount[game["defenders"]])
	{
		level.spectateoverride[game["defenders"]].allowenemyspectate = 1;
		var_00 = 1;
	}

	if(var_00)
	{
		maps\mp\gametypes\_spectating::updatespectatesettings();
	}
}

//Function Number: 12
ondeadevent(param_00)
{
	if(param_00 == game["attackers"])
	{
		level thread func_3A7A(game["defenders"],game["strings"][game["attackers"] + "_eliminated"]);
		return;
	}

	if(param_00 == game["defenders"])
	{
		level thread func_3A7A(game["attackers"],game["strings"][game["defenders"] + "_eliminated"]);
	}
}

//Function Number: 13
func_3A7A(param_00,param_01)
{
	thread maps\mp\gametypes\_gamelogic::endgame(param_00,param_01);
}

//Function Number: 14
func_3A7B()
{
	var_00 = [];
	var_01 = 0;
	for(;;)
	{
		if(level.players.size >= 2)
		{
			break;
		}

		if(var_01 >= 100)
		{
			iprintlnbold("Game mode only playable with 2 or more players");
			wait 2;
			maps\mp\gametypes\_callbacksetup::abortlevel();
		}

		var_01++;
		wait 0.1;
	}

	foreach(var_03 in level.players)
	{
		if(var_03.team == game["defenders"])
		{
			var_00[var_00.size] = var_03;
		}
	}

	var_05 = randomintrange(0,var_00.size);
	var_06 = var_00[var_05];
	if(!isalive(var_06) && !issubstr(var_06.guid,"bot"))
	{
		var_06 func_3A81();
	}

	func_3A7C(var_06);
}

//Function Number: 15
func_3A7C(param_00)
{
	param_00 takeallweapons();
	param_00 maps\mp\_utility::_clearperks();
	param_00.isvip = 1;
	param_00 giveweapon("deserteagle_fmj_mp");
	param_00 givestartammo("deserteagle_fmj_mp");
	param_00 giveweapon("riotshield_mp");
	param_00 switchtoweapon("riotshield_mp");
	param_00 maps\mp\_utility::giveperk("specialty_armorvest",0);
	param_00 maps\mp\_utility::giveperk("specialty_finalstand",0);
	param_00 iprintlnbold("You Are the VIP");
}

//Function Number: 16
extractionzone()
{
	var_00 = getentarray("extraction_vip","targetname");
	if(!isdefined(var_00))
	{
		maps\mp\gametypes\_callbacksetup::abortlevel();
		return;
	}
	else
	{
		level.extractionzone = var_00;
	}

	var_01 = level.extractionzone[0];
	if(isdefined(var_01.target))
	{
		var_02[0] = getent(var_01.target,"targetname");
	}
	else
	{
		var_00[0] = spawn("script_model",var_02.origin);
		var_02[0].angles = var_01.angles;
	}

	var_00 = maps\mp\gametypes\_gameobjects::createuseobject(game["defenders"],var_01,var_02,(0,0,100));
	var_00 maps\mp\gametypes\_gameobjects::allowuse("friendly");
	var_00 maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	var_00 maps\mp\gametypes\_gameobjects::setusetext(&"MP_CALLING_EXTRACTION");
	var_00 maps\mp\gametypes\_gameobjects::setusetime(0);
	var_00.onuse = ::onuse;
	var_00.oncantuse = ::oncantuse;
	var_03 = var_01.origin + (0,0,32);
	var_04 = var_01.origin + (0,0,-32);
	var_05 = bullettrace(var_03,var_04,0,undefined);
	var_06 = maps\mp\gametypes\_teams::getteamflagfx(game["defenders"]);
	var_07 = loadfx(var_06);
	var_08 = vectortoangles(var_05["normal"]);
	var_09 = anglestoforward(var_08);
	var_0A = anglestoright(var_08);
	thread spawnfxdelay(var_07,var_05["position"],var_09,var_0A,0.5);
	var_00 maps\mp\gametypes\_gameobjects::set2dicon("friendly","compass_waypoint_defend");
	var_00 maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_defend");
	var_00 maps\mp\gametypes\_gameobjects::setvisibleteam("friendly");
	level.extractionzone = var_00;
}

//Function Number: 17
func_3A7E()
{
	foreach(var_01 in level.players)
	{
		if(!var_01.isvip)
		{
			self.trigger disableplayeruse(var_01);
		}
	}
}

//Function Number: 18
onuse(param_00)
{
	if(!isdefined(param_00.isvip) || !param_00.isvip)
	{
		return;
	}

	iprintlnbold("Extraction on its way");
	func_3A7F(param_00);
}

//Function Number: 19
func_3A7F(param_00)
{
	param_00 endon("death");
	level endon("game_end");
	level.extractiontime = 45;
	maps\mp\gametypes\_gamelogic::pausetimer();
	level.timelimitoverride = 1;
	setgameendtime(int(gettime() + level.extractiontime * 1000));
	wait level.extractiontime;
	level thread func_3A7A(game["defenders"],&"MP_DEFENDED_VIP");
}

//Function Number: 20
onenduse(param_00,param_01,param_02)
{
}

//Function Number: 21
oncantuse(param_00)
{
}

//Function Number: 22
spawnfxdelay(param_00,param_01,param_02,param_03,param_04)
{
	wait param_04;
	var_05 = spawnfx(param_00,param_01,param_02,param_03);
	triggerfx(var_05);
}

//Function Number: 23
func_3A81()
{
	self endon("death");
	self endon("disconnect");
	self endon("spawned");
	if(self.hasspawned)
	{
		return;
	}

	if(!maps\mp\_utility::isvalidclass(self.pers["class"]))
	{
		self.pers["class"] = "CLASS_CUSTOM1";
		self.class = self.pers["class"];
	}

	maps\mp\_utility::closemenus();
	thread maps\mp\gametypes\_playerlogic::spawnclient();
}