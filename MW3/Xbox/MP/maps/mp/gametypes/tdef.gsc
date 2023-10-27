/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\tdef.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 23
 * Decompile Time: 354 ms
 * Timestamp: 10/27/2023 2:26:26 AM
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
	if(isusingmatchrulesdata())
	{
		level.initializematchrules = ::initializematchrules;
		[[ level.initializematchrules ]]();
		level thread maps\mp\_utility::func_810A();
	}
	else
	{
		maps\mp\_utility::func_330E(level.gametype,0,0,9);
		maps\mp\_utility::func_3315(level.gametype,10);
		maps\mp\_utility::registerscorelimitdvar(level.gametype,7500);
		maps\mp\_utility::func_3312(level.gametype,1);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,1);
		maps\mp\_utility::func_3317(level.gametype,0);
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
		level.matchrules_enemyflagradar = 1;
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	func_34B3();
	level.teambased = 1;
	level.initgametypeawards = ::initgametypeawards;
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onnormaldeath = ::onnormaldeath;
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::func_2D57;
	}

	precacheshader("waypoint_targetneutral");
	game["dialog"]["gametype"] = "team_def";
	if(getdvarint("g_hardcore"))
	{
		game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
	}

	game["strings"]["overtime_hint"] = &"MP_FIRST_BLOOD";
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::func_334C();
	level.matchrules_enemyflagradar = getmatchrulesdata("tdefData","enemyFlagRadar");
	setdynamicdvar("scr_tdef_roundswitch",0);
	maps\mp\_utility::func_330E("tdef",0,0,9);
	setdynamicdvar("scr_tdef_roundlimit",1);
	maps\mp\_utility::func_3312("tdef",1);
	setdynamicdvar("scr_tdef_winlimit",1);
	maps\mp\_utility::registerwinlimitdvar("tdef",1);
	setdynamicdvar("scr_tdef_halftime",0);
	maps\mp\_utility::registerhalftimedvar("tdef",0);
	setdynamicdvar("scr_tdef_promode",0);
}

//Function Number: 3
onprecachegametype()
{
	precachestring(&"MP_NEUTRAL_FLAG_CAPTURED_BY");
	precachestring(&"MP_NEUTRAL_FLAG_DROPPED_BY");
	precachestring(&"MP_GRABBING_FLAG");
	precachestring(&"OBJECTIVES_TDEF_ATTACKER_HINT");
	precachestring(&"OBJECTIVES_TDEF_DEFENDER_HINT");
	precachestring(&"OBJECTIVES_TDEF");
	precachestring(&"OBJECTIVES_TDEF_SCORE");
	precachestring(&"OBJECTIVES_TDEF_HINT");
}

//Function Number: 4
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

	maps\mp\_utility::func_3305("allies",&"OBJECTIVES_TDEF");
	maps\mp\_utility::func_3305("axis",&"OBJECTIVES_TDEF");
	if(level.splitscreen)
	{
		maps\mp\_utility::func_3306("allies",&"OBJECTIVES_TDEF");
		maps\mp\_utility::func_3306("axis",&"OBJECTIVES_TDEF");
	}
	else
	{
		maps\mp\_utility::func_3306("allies",&"OBJECTIVES_TDEF_SCORE");
		maps\mp\_utility::func_3306("axis",&"OBJECTIVES_TDEF_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_TDEF_ATTACKER_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_TDEF_ATTACKER_HINT");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_tdm_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_tdm_spawn_axis_start");
	maps\mp\gametypes\_spawnlogic::func_2FD0("allies","mp_tdm_spawn");
	maps\mp\gametypes\_spawnlogic::func_2FD0("axis","mp_tdm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::func_2FCD(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	maps\mp\gametypes\_rank::registerscoreinfo("firstblood",200);
	maps\mp\gametypes\_rank::registerscoreinfo("kill",50);
	maps\mp\gametypes\_rank::registerscoreinfo("kill_bonus",50);
	maps\mp\gametypes\_rank::registerscoreinfo("capture",100);
	maps\mp\gametypes\_rank::registerscoreinfo("kill_carrier",50);
	maps\mp\gametypes\_rank::registerscoreinfo("team_assist",20);
	var_02[0] = level.gametype;
	maps\mp\gametypes\_gameobjects::main(var_41);
	func_3538();
}

//Function Number: 5
func_3538()
{
	level.icon2d["allies"] = maps\mp\gametypes\_teams::func_2776("allies");
	level.icon2d["axis"] = maps\mp\gametypes\_teams::func_2776("axis");
	precacheshader(level.icon2d["axis"]);
	precacheshader(level.icon2d["allies"]);
	level.carryflag["allies"] = maps\mp\gametypes\_teams::func_2775("allies");
	level.carryflag["axis"] = maps\mp\gametypes\_teams::func_2775("axis");
	level.carryflag["neutral"] = "prop_flag_neutral";
	precachemodel(level.carryflag["allies"]);
	precachemodel(level.carryflag["axis"]);
	precachemodel(level.carryflag["neutral"]);
	level.iconescort3d = "waypoint_defend";
	level.iconescort2d = "waypoint_defend";
	precacheshader(level.iconescort3d);
	precacheshader(level.iconescort2d);
	level.iconkill3d = "waypoint_kill";
	level.iconkill2d = "waypoint_kill";
	precacheshader(level.iconkill3d);
	precacheshader(level.iconkill2d);
	level.iconcaptureflag3d = "waypoint_capture_flag";
	level.iconcaptureflag2d = "waypoint_capture_flag";
	precacheshader(level.iconcaptureflag3d);
	precacheshader(level.iconcaptureflag2d);
	precacheshader("waypoint_flag_friendly");
	precacheshader("waypoint_flag_enemy");
	level.gameflag = undefined;
}

//Function Number: 6
onnormaldeath(param_00,param_01,param_02)
{
	var_03 = maps\mp\gametypes\_rank::getscoreinfovalue("kill");
	if(isdefined(level.gameflag) && level.gameflag maps\mp\gametypes\_gameobjects::func_2A15() == param_01.pers["team"])
	{
		if(isdefined(param_01.carryflag))
		{
			param_01 maps\mp\_utility::incplayerstat("killsasflagcarrier",1);
		}
		else
		{
			level.gameflag.carrier thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_TEAM_ASSIST");
			maps\mp\gametypes\_gamescore::func_26D3("team_assist",level.gameflag.carrier,param_00,1);
			level.gameflag.carrier thread maps\mp\gametypes\_rank::func_2AB3("team_assist");
		}

		param_01 thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_X2_BONUS");
		maps\mp\gametypes\_gamescore::func_26D3("kill_bonus",param_01,param_00,1);
		param_01 thread maps\mp\gametypes\_rank::func_2AB3("kill_bonus");
		var_03 = var_03 * 2;
	}
	else if(!isdefined(level.gameflag) && cancreateflagatvictimorigin(param_00))
	{
		level.gameflag = createflag(param_00);
		var_03 = var_03 + maps\mp\gametypes\_rank::getscoreinfovalue("firstblood");
		maps\mp\gametypes\_gamescore::func_26D3("firstblood",param_01,param_00,1);
	}
	else if(isdefined(param_00.carryflag))
	{
		var_04 = maps\mp\gametypes\_rank::getscoreinfovalue("kill_carrier");
		thread maps\mp\_utility::teamplayercardsplash("callout_killflagcarrier",param_01);
		param_01 thread maps\mp\gametypes\_hud_message::func_2892("flag_carrier_killed",var_04);
		maps\mp\gametypes\_gamescore::func_26D3("kill_carrier",param_01,param_00,1);
		param_01 maps\mp\_utility::incplayerstat("flagcarrierkills",1);
		param_01 thread [[ level.onxpevent ]]("kill_carrier");
		param_01 notify("objective","kill_carrier");
		param_01 thread maps\mp\_matchdata::loggameevent("kill_carrier",param_01.origin);
		var_03 = var_03 + var_04;
	}

	param_01 maps\mp\gametypes\_gamescore::giveteamscoreforobjective(param_01.pers["team"],var_03);
	if(game["state"] == "postgame" && game["teamScores"][param_01.team] > game["teamScores"][level.otherteam[param_01.team]])
	{
		param_01.finalkill = 1;
	}
}

//Function Number: 7
ondrop(param_00)
{
	if(isdefined(param_00) && isdefined(param_00.tdef_flagtime))
	{
		var_01 = int(gettime() - param_00.tdef_flagtime);
		param_00 maps\mp\_utility::incplayerstat("holdingteamdefenderflag",var_01);
		if(var_01 / 100 / 60 < 1)
		{
			var_02 = 0;
		}
		else
		{
			var_02 = int(var_02 / 100 / 60);
		}

		param_00 maps\mp\_utility::func_26FB("destructions",var_02);
		param_00 maps\mp\gametypes\_persistence::func_26D8("round","destructions",param_00.pers["destructions"]);
		param_00.tdef_flagtime = undefined;
		param_00 notify("dropped_flag");
	}

	var_03 = maps\mp\gametypes\_gameobjects::func_2A15();
	var_04 = level.otherteam[var_03];
	if(isdefined(self.portable_radar))
	{
		level maps\mp\gametypes\_portable_radar::deleteportableradar(self.portable_radar);
		self.portable_radar = undefined;
	}

	self.currentcarrier = undefined;
	maps\mp\gametypes\_gameobjects::setownerteam("neutral");
	maps\mp\gametypes\_gameobjects::allowcarry("any");
	maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.iconcaptureflag2d);
	maps\mp\gametypes\_gameobjects::func_2A25("friendly",level.iconcaptureflag3d);
	maps\mp\gametypes\_gameobjects::set2dicon("enemy",level.iconcaptureflag2d);
	maps\mp\gametypes\_gameobjects::func_2A25("enemy",level.iconcaptureflag3d);
	if(isdefined(param_00))
	{
		if(isdefined(param_00.carryflag))
		{
			param_00 func_34F0();
		}

		maps\mp\_utility::func_32F9(var_03,var_04,&"MP_NEUTRAL_FLAG_DROPPED_BY",&"MP_NEUTRAL_FLAG_DROPPED_BY","mp_war_objective_lost","mp_war_objective_lost",param_00);
	}
	else
	{
		maps\mp\_utility::func_2D68("mp_war_objective_lost",var_03);
		maps\mp\_utility::func_2D68("mp_war_objective_lost",var_04);
	}

	maps\mp\_utility::func_26E5("dropped_flag",var_03,"status");
	maps\mp\_utility::func_26E5("enemy_dropped_flag",var_04,"status");
}

//Function Number: 8
onpickup(param_00)
{
	self notify("picked_up");
	param_00.tdef_flagtime = gettime();
	param_00 thread watchforendgame();
	var_01 = maps\mp\gametypes\_rank::getscoreinfovalue("capture");
	var_02 = param_00.pers["team"];
	var_03 = level.otherteam[var_02];
	if(isdefined(level.tdef_loadouts) && isdefined(level.tdef_loadouts[var_02]))
	{
		param_00 thread applyflagcarrierclass();
	}
	else
	{
		param_00 func_34EF();
	}

	self.currentcarrier = param_00;
	param_00.carryicon setshader(level.icon2d[var_02],param_00.carryicon.width,param_00.carryicon.height);
	maps\mp\gametypes\_gameobjects::setownerteam(var_02);
	maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.iconescort2d);
	maps\mp\gametypes\_gameobjects::func_2A25("friendly",level.iconescort2d);
	maps\mp\gametypes\_gameobjects::set2dicon("enemy",level.iconkill3d);
	maps\mp\gametypes\_gameobjects::func_2A25("enemy",level.iconkill3d);
	maps\mp\_utility::func_26E5("got_flag",var_02,"status");
	maps\mp\_utility::func_26E5("enemy_got_flag",var_03,"status");
	thread maps\mp\_utility::teamplayercardsplash("callout_flagcapture",param_00);
	param_00 thread maps\mp\gametypes\_hud_message::func_2892("flag_capture",var_01);
	maps\mp\gametypes\_gamescore::func_26D3("capture",param_00,undefined,1);
	param_00 thread [[ level.onxpevent ]]("capture");
	param_00 maps\mp\_utility::incplayerstat("flagscaptured",1);
	param_00 notify("objective","captured");
	param_00 thread maps\mp\_matchdata::loggameevent("capture",param_00.origin);
	maps\mp\_utility::func_32F9(var_02,var_03,&"MP_NEUTRAL_FLAG_CAPTURED_BY",&"MP_NEUTRAL_FLAG_CAPTURED_BY","mp_obj_captured","mp_enemy_obj_captured",param_00);
	if(self.currentteam == var_03)
	{
		param_00 maps\mp\gametypes\_gamescore::giveteamscoreforobjective(var_02,var_01);
	}

	self.currentteam = var_02;
	if(level.matchrules_enemyflagradar)
	{
		thread flagattachradar(var_03);
	}
}

//Function Number: 9
applyflagcarrierclass()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(isdefined(self.iscarrying) && self.iscarrying == 1)
	{
		self notify("force_cancel_placement");
		wait 0.05;
	}

	while(self ismantling())
	{
		wait 0.05;
	}

	while(!self isonground())
	{
		wait 0.05;
	}

	if(maps\mp\_utility::isjuggernaut())
	{
		self notify("lost_juggernaut");
		wait 0.05;
	}

	self.pers["gamemodeLoadout"] = level.tdef_loadouts[self.team];
	if(isdefined(self.setspawnpoint))
	{
		maps\mp\perks\_perkfunctions::func_2A63(self.setspawnpoint);
	}

	var_00 = spawn("script_model",self.origin);
	var_00.angles = self.angles;
	var_00.playerspawnpos = self.origin;
	var_00.notti = 1;
	self.setspawnpoint = var_00;
	self.gamemode_chosenclass = self.class;
	self.pers["class"] = "gamemode";
	self.pers["lastClass"] = "gamemode";
	self.class = "gamemode";
	self.lastclass = "gamemode";
	thread waitattachflag();
	self notify("faux_spawn");
	self.gameobject_fauxspawn = 1;
	self.faux_spawn_stance = self getstance();
	thread maps\mp\gametypes\_playerlogic::func_2B25(1);
}

//Function Number: 10
waitattachflag()
{
	level endon("game_ende");
	self endon("disconnect");
	self endon("death");
	self waittill("spawned_player");
	func_34EF();
}

//Function Number: 11
watchforendgame()
{
	self endon("dropped_flag");
	self endon("disconnect");
	level waittill("game_ended");
	if(isdefined(self))
	{
		if(isdefined(self.tdef_flagtime))
		{
			var_00 = int(gettime() - self.tdef_flagtime);
			maps\mp\_utility::incplayerstat("holdingteamdefenderflag",var_00);
			if(var_00 / 100 / 60 < 1)
			{
				var_01 = 0;
			}
			else
			{
				var_01 = int(var_01 / 100 / 60);
			}

			maps\mp\_utility::func_26FB("destructions",var_01);
			maps\mp\gametypes\_persistence::func_26D8("round","destructions",self.pers["destructions"]);
		}
	}
}

//Function Number: 12
cancreateflagatvictimorigin(param_00)
{
	var_01 = getentarray("minefield","targetname");
	var_02 = getentarray("trigger_hurt","classname");
	var_03 = getentarray("radiation","targetname");
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		if(param_00 istouching(var_03[var_04]))
		{
			return 0;
		}
	}

	for(var_04 = 0;var_04 < var_01.size;var_04++)
	{
		if(param_00 istouching(var_01[var_04]))
		{
			return 0;
		}
	}

	for(var_04 = 0;var_04 < var_02.size;var_04++)
	{
		if(param_00 istouching(var_02[var_04]))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 13
createflag(param_00)
{
	var_01[0] = spawn("script_model",param_00.origin);
	var_01[0] setmodel(level.carryflag["neutral"]);
	var_02 = spawn("trigger_radius",param_00.origin,0,96,72);
	var_03 = maps\mp\gametypes\_gameobjects::func_29A8("neutral",var_02,var_01,(0,0,85));
	var_03 maps\mp\gametypes\_gameobjects::func_2A18("friendly",0.5);
	var_03 maps\mp\gametypes\_gameobjects::func_2A18("enemy",0.5);
	var_03 maps\mp\gametypes\_gameobjects::setteamusetext("enemy",&"MP_GRABBING_FLAG");
	var_03 maps\mp\gametypes\_gameobjects::setteamusetext("friendly",&"MP_GRABBING_FLAG");
	var_03 maps\mp\gametypes\_gameobjects::allowcarry("any");
	var_03 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	var_03 maps\mp\gametypes\_gameobjects::set2dicon("enemy",level.iconcaptureflag2d);
	var_03 maps\mp\gametypes\_gameobjects::func_2A25("enemy",level.iconcaptureflag3d);
	var_03 maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.iconcaptureflag2d);
	var_03 maps\mp\gametypes\_gameobjects::func_2A25("friendly",level.iconcaptureflag3d);
	var_03 maps\mp\gametypes\_gameobjects::setcarryicon(level.icon2d["axis"]);
	var_03.allowweapons = 1;
	var_03.onpickup = ::onpickup;
	var_03.onpickupfailed = ::onpickup;
	var_03.ondrop = ::ondrop;
	var_03.oldradius = 96;
	var_03.currentteam = "none";
	var_03.requireslos = 1;
	level.favorclosespawnent = var_03.trigger;
	level.favorclosespawnscalar = 3;
	var_03 thread updatebaseposition();
	return var_03;
}

//Function Number: 14
updatebaseposition()
{
	level endon("game_ended");
	for(;;)
	{
		if(isdefined(self.safeorigin))
		{
			self.baseorigin = self.safeorigin;
			self.trigger.baseorigin = self.safeorigin;
			self.visuals[0].baseorigin = self.safeorigin;
		}

		wait 0.05;
	}
}

//Function Number: 15
func_34EF()
{
	self attach(level.carryflag[self.pers["team"]],"J_spine4",1);
	self.carryflag = level.carryflag[self.pers["team"]];
	level.favorclosespawnent = self;
}

//Function Number: 16
func_34F0()
{
	self detach(self.carryflag,"J_spine4");
	self.carryflag = undefined;
	level.favorclosespawnent = level.gameflag.trigger;
}

//Function Number: 17
flagattachradar(param_00)
{
	level endon("game_ended");
	self endon("dropped");
	var_01 = getflagradarowner(param_00);
	var_02 = spawn("script_model",self.currentcarrier.origin);
	var_02.team = param_00;
	var_02.owner = var_01;
	var_02 makeportableradar(var_01);
	self.portable_radar = var_02;
	thread flagradarmover();
	thread func_3543();
}

//Function Number: 18
getflagradarowner(param_00)
{
	level endon("game_ended");
	self endon("dropped");
	for(;;)
	{
		foreach(var_02 in level.players)
		{
			if(isalive(var_02) && var_02.pers["team"] == param_00)
			{
				return var_02;
			}
		}

		wait 0.05;
	}
}

//Function Number: 19
flagradarmover()
{
	level endon("game_ended");
	self endon("dropped");
	self.portable_radar endon("death");
	for(;;)
	{
		self.portable_radar moveto(self.currentcarrier.origin,0.05);
		wait 0.05;
	}
}

//Function Number: 20
func_3543()
{
	level endon("game_ended");
	self endon("dropped");
	var_00 = self.portable_radar.team;
	self.portable_radar.owner common_scripts\utility::waittill_any("disconnect","joined_team","joined_spectators");
	level maps\mp\gametypes\_portable_radar::deleteportableradar(self.portable_radar);
	self.portable_radar = undefined;
	flagattachradar(var_00);
}

//Function Number: 21
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
		var_02 = maps\mp\gametypes\_spawnlogic::func_2FE6(var_02);
	}

	return var_02;
}

//Function Number: 22
initgametypeawards()
{
	maps\mp\_awards::func_2D85("flagscaptured",0,::maps\mp\_awards::func_2DA7);
	maps\mp\_awards::func_2D85("flagcarrierkills",0,::maps\mp\_awards::func_2DA7);
	maps\mp\_awards::func_2D85("killsasflagcarrier",0,::maps\mp\_awards::func_2DA7);
}

//Function Number: 23
func_34B3()
{
	if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses","axis",5,"class","inUse"))
	{
		level.tdef_loadouts["axis"] = maps\mp\_utility::func_334E("axis",5);
	}

	if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses","allies",5,"class","inUse"))
	{
		level.tdef_loadouts["allies"] = maps\mp\_utility::func_334E("allies",5);
	}
}