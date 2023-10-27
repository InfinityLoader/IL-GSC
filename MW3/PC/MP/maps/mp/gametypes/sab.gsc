/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\sab.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 37
 * Decompile Time: 3341 ms
 * Timestamp: 10/27/2023 2:13:32 AM
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
	level.teambased = 1;
	if(isusingmatchrulesdata())
	{
		level.initializematchrules = ::initializematchrules;
		[[ level.initializematchrules ]]();
		level thread maps\mp\_utility::reinitializematchrulesonmigration();
	}
	else
	{
		maps\mp\_utility::registerroundswitchdvar(level.gametype,0,0,9);
		maps\mp\_utility::registertimelimitdvar(level.gametype,10);
		maps\mp\_utility::registerscorelimitdvar(level.gametype,0);
		maps\mp\_utility::registerroundlimitdvar(level.gametype,1);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,1);
		maps\mp\_utility::registernumlivesdvar(level.gametype,0);
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	maps\mp\_utility::setovertimelimitdvar(2);
	func_3989();
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onspawnplayer = ::onspawnplayer;
	level.ononeleftevent = ::ononeleftevent;
	level.ontimelimit = ::ontimelimit;
	level.onnormaldeath = ::onnormaldeath;
	level.initgametypeawards = ::initgametypeawards;
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	game["dialog"]["gametype"] = "sabotage";
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

	game["dialog"]["offense_obj"] = "capture_obj";
	game["dialog"]["defense_obj"] = "capture_obj";
	var_00 = getent("sab_bomb_defuse_allies","targetname");
	if(isdefined(var_00))
	{
		var_00 delete();
	}

	var_00 = getent("sab_bomb_defuse_axis","targetname");
	if(isdefined(var_00))
	{
		var_00 delete();
	}

	makedvarserverinfo("ui_bomb_timer_endtime",-1);
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::setcommonrulesfrommatchrulesdata();
	setdynamicdvar("scr_sab_bombtimer",getmatchrulesdata("sabData","bombTimer"));
	setdynamicdvar("scr_sab_planttime",getmatchrulesdata("sabData","plantTime"));
	setdynamicdvar("scr_sab_defusetime",getmatchrulesdata("sabData","defuseTime"));
	setdynamicdvar("scr_sab_hotpotato",getmatchrulesdata("sabData","sharedBombTimer"));
	setdynamicdvar("scr_sab_roundswitch",1);
	maps\mp\_utility::registerroundswitchdvar("sab",1,0,9);
	setdynamicdvar("scr_sab_roundlimit",1);
	maps\mp\_utility::registerroundlimitdvar("sab",1);
	setdynamicdvar("scr_sab_winlimit",1);
	maps\mp\_utility::registerwinlimitdvar("sab",1);
	setdynamicdvar("scr_sab_halftime",0);
	maps\mp\_utility::registerhalftimedvar("sab",0);
	setdynamicdvar("scr_sab_promode",0);
}

//Function Number: 3
onprecachegametype()
{
	game["bomb_dropped_sound"] = "mp_war_objective_lost";
	game["bomb_recovered_sound"] = "mp_war_objective_taken";
	precacheshader("waypoint_bomb");
	precacheshader("waypoint_kill");
	precacheshader("waypoint_bomb_enemy");
	precacheshader("waypoint_defend");
	precacheshader("waypoint_defuse");
	precacheshader("waypoint_target");
	precacheshader("waypoint_escort");
	precacheshader("waypoint_bomb");
	precacheshader("waypoint_defend");
	precacheshader("waypoint_defuse");
	precacheshader("waypoint_target");
	precacheshader("hud_suitcase_bomb");
	precachestring(&"MP_EXPLOSIVES_RECOVERED_BY");
	precachestring(&"MP_EXPLOSIVES_DROPPED_BY");
	precachestring(&"MP_EXPLOSIVES_PLANTED_BY");
	precachestring(&"MP_EXPLOSIVES_DEFUSED_BY");
	precachestring(&"MP_YOU_HAVE_RECOVERED_THE_BOMB");
	precachestring(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
	precachestring(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
	precachestring(&"MP_PLANTING_EXPLOSIVE");
	precachestring(&"MP_DEFUSING_EXPLOSIVE");
	precachestring(&"MP_TARGET_DESTROYED");
	precachestring(&"MP_NO_RESPAWN");
	precachestring(&"MP_TIE_BREAKER");
	precachestring(&"MP_NO_RESPAWN");
	precachestring(&"MP_SUDDEN_DEATH");
}

//Function Number: 4
onstartgametype()
{
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	setclientnamemode("auto_change");
	game["strings"]["target_destroyed"] = &"MP_TARGET_DESTROYED";
	game["strings"]["target_defended"] = &"MP_TARGET_DEDEFEND";
	maps\mp\_utility::setobjectivetext("allies",&"OBJECTIVES_SAB");
	maps\mp\_utility::setobjectivetext("axis",&"OBJECTIVES_SAB");
	if(level.splitscreen)
	{
		maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_SAB");
		maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_SAB");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_SAB_SCORE");
		maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_SAB_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_SAB_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_SAB_HINT");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_sab_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_sab_spawn_axis_start");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies","mp_sab_spawn_allies");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis","mp_sab_spawn_axis");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies","mp_sab_spawn_allies_planted",1);
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis","mp_sab_spawn_axis_planted",1);
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	level.spawn_axis = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_sab_spawn_axis");
	level.spawn_axis_planted = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_sab_spawn_axis_planted");
	level.spawn_axis_planted = common_scripts\utility::array_combine(level.spawn_axis_planted,level.spawn_axis);
	level.spawn_allies = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_sab_spawn_allies");
	level.spawn_allies_planted = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_sab_spawn_allies_planted");
	level.spawn_allies_planted = common_scripts\utility::array_combine(level.spawn_allies_planted,level.spawn_allies);
	level.spawn_axis_start = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_sab_spawn_axis_start");
	level.spawn_allies_start = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_sab_spawn_allies_start");
	maps\mp\gametypes\_rank::registerscoreinfo("plant",200);
	maps\mp\gametypes\_rank::registerscoreinfo("destroy",1000);
	maps\mp\gametypes\_rank::registerscoreinfo("defuse",150);
	var_00[0] = "sab";
	maps\mp\gametypes\_gameobjects::main(var_00);
	thread updategametypedvars();
	thread func_397C();
}

//Function Number: 5
getspawnpoint()
{
	var_00 = self.pers["team"];
	if(game["switchedsides"])
	{
		var_00 = maps\mp\_utility::getotherteam(var_00);
	}

	if(level.usestartspawns)
	{
		if(var_00 == "axis")
		{
			var_01 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(level.spawn_axis_start);
		}
		else
		{
			var_01 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(level.spawn_allies_start);
		}
	}
	else if(isdefined(level.bombplanted) && level.bombplanted && isdefined(level.bombowner) && var_01 == level.bombowner.team)
	{
		if(var_01 == "axis")
		{
			var_01 = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(level.spawn_axis_planted);
		}
		else
		{
			var_01 = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(level.spawn_allies_planted);
		}
	}
	else if(var_01 == "axis")
	{
		var_01 = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(level.spawn_axis);
	}
	else
	{
		var_01 = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(level.spawn_allies);
	}

	return var_01;
}

//Function Number: 6
onspawnplayer()
{
	self.isplanting = 0;
	self.isdefusing = 0;
	self.isbombcarrier = 0;
	if(maps\mp\_utility::inovertime() && !isdefined(self.otspawned))
	{
		thread func_3979();
	}
}

//Function Number: 7
func_3979()
{
	self endon("disconnect");
	wait 0.25;
	thread maps\mp\gametypes\_hud_message::splashnotify("sudden_death");
	self.otspawned = 1;
}

//Function Number: 8
updategametypedvars()
{
	level.planttime = maps\mp\_utility::dvarfloatvalue("planttime",5,0,20);
	level.defusetime = maps\mp\_utility::dvarfloatvalue("defusetime",5,0,20);
	level.bombtimer = maps\mp\_utility::dvarfloatvalue("bombtimer",45,1,300);
	level.hotpotato = maps\mp\_utility::dvarintvalue("hotpotato",1,0,1);
	level.scoremode = maps\mp\_utility::getwatcheddvar("scorelimit");
}

//Function Number: 9
func_397C()
{
	level.bombplanted = 0;
	level.bombexploded = 0;
	level._effect["bombexplosion"] = loadfx("explosions/tanker_explosion");
	var_00 = getent("sab_bomb_pickup_trig","targetname");
	if(!isdefined(var_00))
	{
		common_scripts\utility::error("No sab_bomb_pickup_trig trigger found in map.");
		return;
	}

	var_01[0] = getent("sab_bomb","targetname");
	if(!isdefined(var_01[0]))
	{
		common_scripts\utility::error("No sab_bomb script_model found in map.");
		return;
	}

	precachemodel("prop_suitcase_bomb");
	var_01[0] setmodel("prop_suitcase_bomb");
	level.sabbomb = maps\mp\gametypes\_gameobjects::createcarryobject("neutral",var_00,var_01,(0,0,32));
	level.sabbomb maps\mp\gametypes\_gameobjects::allowcarry("any");
	level.sabbomb maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_bomb");
	level.sabbomb maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_bomb");
	level.sabbomb maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_bomb");
	level.sabbomb maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_bomb");
	level.sabbomb maps\mp\gametypes\_gameobjects::setcarryicon("hud_suitcase_bomb");
	level.sabbomb maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	level.sabbomb.objidpingenemy = 1;
	level.sabbomb.onpickup = ::onpickup;
	level.sabbomb.ondrop = ::ondrop;
	level.sabbomb.allowweapons = 1;
	level.sabbomb.objpoints["allies"].archived = 1;
	level.sabbomb.objpoints["axis"].archived = 1;
	level.sabbomb.autoresettime = 60;
	if(!isdefined(getent("sab_bomb_axis","targetname")))
	{
		common_scripts\utility::error("No sab_bomb_axis trigger found in map.");
		return;
	}

	if(!isdefined(getent("sab_bomb_allies","targetname")))
	{
		common_scripts\utility::error("No sab_bomb_allies trigger found in map.");
		return;
	}

	if(game["switchedsides"])
	{
		level.bombzones["allies"] = func_3982("allies",getent("sab_bomb_axis","targetname"));
		level.bombzones["axis"] = func_3982("axis",getent("sab_bomb_allies","targetname"));
	}
	else
	{
		level.bombzones["allies"] = func_3982("allies",getent("sab_bomb_allies","targetname"));
		level.bombzones["axis"] = func_3982("axis",getent("sab_bomb_axis","targetname"));
	}

	if(level.scoremode)
	{
		level thread func_3980();
	}

	if(maps\mp\_utility::inovertime())
	{
		level thread func_3984();
	}
}

//Function Number: 10
func_397E()
{
	if(distance2d(self.origin,level.bombzones["allies"].trigger.origin) < distance2d(self.origin,level.bombzones["axis"].trigger.origin))
	{
		return "allies";
	}

	return "axis";
}

//Function Number: 11
func_397F(param_00)
{
	return distance2d(self.origin,level.bombzones[param_00].trigger.origin);
}

//Function Number: 12
func_3980()
{
	level.bombdistance = distance2d(getent("sab_bomb_axis","targetname") getorigin(),getent("sab_bomb_allies","targetname") getorigin());
	var_00 = level.bombdistance / 2 - 384;
	var_01 = level.sabbomb.trigger;
	if(var_00 > var_01 func_397F("allies") || var_00 > var_01 func_397F("axis"))
	{
		var_00 = var_01 func_397F(var_01 func_397E()) - 128;
	}

	var_02 = "";
	for(;;)
	{
		if(isdefined(level.sabbomb.carrier))
		{
			var_01 = level.sabbomb.carrier;
		}
		else
		{
			var_01 = level.sabbomb.trigger;
		}

		var_03 = var_02;
		var_02 = "none";
		if(var_01 func_397F("allies") < var_00)
		{
			var_02 = level.bombzones["allies"] maps\mp\gametypes\_gameobjects::getownerteam();
		}
		else if(var_01 func_397F("axis") < var_00)
		{
			var_02 = level.bombzones["axis"] maps\mp\gametypes\_gameobjects::getownerteam();
		}
		else if(var_01 func_397F("allies") > level.bombdistance && var_01 func_397E() != "allies")
		{
			var_02 = level.bombzones["axis"] maps\mp\gametypes\_gameobjects::getownerteam();
		}
		else if(var_01 func_397F("axis") > level.bombdistance && var_01 func_397E() != "axis")
		{
			var_02 = level.bombzones["allies"] maps\mp\gametypes\_gameobjects::getownerteam();
		}

		if(var_02 != "none")
		{
			if(!level.bombplanted || !maps\mp\_utility::getwatcheddvar("scorelimit") || level.bombplanted && lib_036E::func_2B96(level.otherteam[var_02]) < maps\mp\_utility::getwatcheddvar("scorelimit") - 1)
			{
				lib_036E::func_2B8F(level.otherteam[var_02],lib_036E::func_2B96(level.otherteam[var_02]) + 1);
				lib_036E::func_2B93(level.otherteam[var_02]);
			}
		}

		if(var_02 != var_03 && !level.bombexploded)
		{
			setdvar("ui_danger_team",var_02);
		}

		wait 2.5;
	}
}

//Function Number: 13
func_3982(param_00,param_01)
{
	var_02 = getentarray(param_01.target,"targetname");
	var_03 = maps\mp\gametypes\_gameobjects::createuseobject(param_00,param_01,var_02,(0,0,64));
	var_03 func_3987();
	var_03.onuse = ::onuse;
	var_03.onbeginuse = ::onbeginuse;
	var_03.onenduse = ::onenduse;
	var_03.oncantuse = ::oncantuse;
	var_03.useweapon = "briefcase_bomb_mp";
	for(var_04 = 0;var_04 < var_02.size;var_04++)
	{
		if(isdefined(var_02[var_04].script_exploder))
		{
			var_03.exploderindex = var_02[var_04].script_exploder;
			var_02[var_04] thread func_3967();
			break;
		}
	}

	return var_03;
}

//Function Number: 14
func_3967()
{
	var_00 = spawn("script_origin",self.origin);
	var_00.angles = self.angles;
	var_00 rotateyaw(-45,0.05);
	wait 0.05;
	var_01 = self.origin + (0,0,5);
	var_02 = self.origin + anglestoforward(var_00.angles) * 100 + (0,0,128);
	var_03 = bullettrace(var_01,var_02,0,self);
	self.killcament = spawn("script_model",var_03["position"]);
	self.killcament setscriptmoverkillcam("explosive");
	var_00 delete();
}

//Function Number: 15
onbeginuse(param_00)
{
	if(!maps\mp\gametypes\_gameobjects::isfriendlyteam(param_00.pers["team"]))
	{
		param_00.isplanting = 1;
		return;
	}

	param_00.isdefusing = 1;
}

//Function Number: 16
onenduse(param_00,param_01,param_02)
{
	if(!isalive(param_01))
	{
		return;
	}

	param_01.isplanting = 0;
	param_01.isdefusing = 0;
}

//Function Number: 17
onpickup(param_00)
{
	level notify("bomb_picked_up");
	self.autoresettime = 60;
	level.usestartspawns = 0;
	var_01 = param_00.pers["team"];
	if(var_01 == "allies")
	{
		var_02 = "axis";
	}
	else
	{
		var_02 = "allies";
	}

	param_00 playlocalsound("mp_suitcase_pickup");
	param_00 maps\mp\_utility::leaderdialogonplayer("obj_destroy","bomb");
	var_03[0] = param_00;
	maps\mp\_utility::leaderdialog("bomb_taken",var_01,"bomb",var_03);
	if(!level.splitscreen)
	{
		maps\mp\_utility::leaderdialog("bomb_lost",var_02,"bomb");
		maps\mp\_utility::leaderdialog("obj_defend",var_02,"bomb");
	}

	param_00.isbombcarrier = 1;
	if(isdefined(level.sab_loadouts) && isdefined(level.sab_loadouts[var_01]))
	{
		param_00 thread func_396C();
	}

	if(var_01 == maps\mp\gametypes\_gameobjects::getownerteam())
	{
		maps\mp\_utility::playsoundonplayers(game["bomb_recovered_sound"],var_01);
	}
	else
	{
		maps\mp\_utility::playsoundonplayers(game["bomb_recovered_sound"]);
	}

	maps\mp\gametypes\_gameobjects::setownerteam(var_01);
	maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_target");
	maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_kill");
	maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_escort");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_escort");
	level.bombzones[var_01] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	level.bombzones[var_02] maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	param_00 maps\mp\_utility::incplayerstat("bombscarried",1);
	param_00 thread maps\mp\_matchdata::loggameevent("pickup",param_00.origin);
}

//Function Number: 18
ondrop(param_00)
{
	if(level.bombplanted)
	{
		return;
	}

	if(isdefined(param_00))
	{
		maps\mp\_utility::printonteamarg(&"MP_EXPLOSIVES_DROPPED_BY",maps\mp\gametypes\_gameobjects::getownerteam(),param_00);
	}

	maps\mp\_utility::playsoundonplayers(game["bomb_dropped_sound"],maps\mp\gametypes\_gameobjects::getownerteam());
	thread func_3983(0);
}

//Function Number: 19
func_3983(param_00)
{
	level endon("bomb_picked_up");
	wait param_00;
	if(isdefined(self.carrier))
	{
		return;
	}

	if(maps\mp\gametypes\_gameobjects::getownerteam() == "allies")
	{
		var_01 = "axis";
	}
	else
	{
		var_01 = "allies";
	}

	maps\mp\_utility::playsoundonplayers(game["bomb_dropped_sound"],var_01);
	maps\mp\gametypes\_gameobjects::setownerteam("neutral");
	maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_bomb");
	maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_bomb");
	maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_bomb");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_bomb");
	level.bombzones["allies"] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	level.bombzones["axis"] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
}

//Function Number: 20
onuse(param_00)
{
	var_01 = param_00.pers["team"];
	var_02 = level.otherteam[var_01];
	if(!maps\mp\gametypes\_gameobjects::isfriendlyteam(param_00.pers["team"]))
	{
		param_00 notify("bomb_planted");
		param_00 notify("objective","plant");
		param_00 playsound("mp_bomb_plant");
		level thread maps\mp\_utility::teamplayercardsplash("callout_bombplanted",param_00);
		maps\mp\_utility::leaderdialog("bomb_planted");
		param_00 thread maps\mp\gametypes\_hud_message::splashnotify("plant",maps\mp\gametypes\_rank::getscoreinfovalue("plant"));
		param_00 thread maps\mp\gametypes\_rank::giverankxp("plant");
		lib_036E::func_2B7B("plant",param_00);
		param_00 maps\mp\_utility::incplayerstat("bombsplanted",1);
		param_00 thread maps\mp\_matchdata::loggameevent("plant",param_00.origin);
		param_00.bombplantedtime = gettime();
		param_00 maps\mp\_utility::incpersstat("plants",1);
		param_00 maps\mp\gametypes\_persistance::statsetchild("round","plants",param_00.pers["plants"]);
		level thread bombplanted(self,param_00.pers["team"]);
		level.bombowner = param_00;
		if(isdefined(level.sab_loadouts) && isdefined(level.sab_loadouts[var_01]))
		{
			param_00 thread func_396D();
		}

		level.sabbomb.autoresettime = undefined;
		level.sabbomb maps\mp\gametypes\_gameobjects::allowcarry("none");
		level.sabbomb maps\mp\gametypes\_gameobjects::setvisibleteam("none");
		level.sabbomb maps\mp\gametypes\_gameobjects::setdropped();
		self.useweapon = "briefcase_bomb_defuse_mp";
		func_3988();
		return;
	}

	param_00 notify("bomb_defused");
	param_00 notify("objective","defuse");
	maps\mp\_utility::leaderdialog("bomb_defused");
	level thread maps\mp\_utility::teamplayercardsplash("callout_bombdefused",param_00);
	if(isdefined(level.bombowner) && level.bombowner.bombplantedtime + 3000 + level.defusetime * 1000 > gettime() && maps\mp\_utility::isreallyalive(level.bombowner))
	{
		param_00 thread maps\mp\gametypes\_hud_message::splashnotify("ninja_defuse",maps\mp\gametypes\_rank::getscoreinfovalue("defuse"));
	}
	else
	{
		param_00 thread maps\mp\gametypes\_hud_message::splashnotify("defuse",maps\mp\gametypes\_rank::getscoreinfovalue("defuse"));
	}

	param_00 thread maps\mp\gametypes\_rank::giverankxp("defuse");
	lib_036E::func_2B7B("defuse",param_00);
	param_00 maps\mp\_utility::incpersstat("defuses",1);
	param_00 maps\mp\gametypes\_persistance::statsetchild("round","defuses",param_00.pers["defuses"]);
	param_00 thread maps\mp\_matchdata::loggameevent("defuse",param_00.origin);
	if(maps\mp\_utility::inovertime())
	{
		level.finalkillcam_winner = var_01;
		thread maps\mp\gametypes\_gamelogic::endgame(var_01,game["strings"]["target_destroyed"]);
		return;
	}

	level thread bombdefused(self);
	func_3987();
	level.sabbomb maps\mp\gametypes\_gameobjects::allowcarry("any");
	level.sabbomb maps\mp\gametypes\_gameobjects::setpickedup(param_00);
}

//Function Number: 21
func_396C()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(isdefined(self.iscarrying) && self.iscarrying == 1)
	{
		self notify("force_cancel_placement");
		wait 0.05;
	}

	if(maps\mp\_utility::isjuggernaut())
	{
		self notify("lost_juggernaut");
		wait 0.05;
	}

	self.pers["gamemodeLoadout"] = level.sab_loadouts[self.team];
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
	self notify("faux_spawn");
	self.gameobject_fauxspawn = 1;
	self.faux_spawn_stance = self getstance();
	thread maps\mp\gametypes\_playerlogic::spawnplayer(1);
}

//Function Number: 22
func_396D()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(isdefined(self.iscarrying) && self.iscarrying == 1)
	{
		self notify("force_cancel_placement");
		wait 0.05;
	}

	if(maps\mp\_utility::isjuggernaut())
	{
		self notify("lost_juggernaut");
		wait 0.05;
	}

	self.pers["gamemodeLoadout"] = undefined;
	var_00 = spawn("script_model",self.origin);
	var_00.angles = self.angles;
	var_00.playerspawnpos = self.origin;
	var_00.notti = 1;
	self.setspawnpoint = var_00;
	self notify("faux_spawn");
	self.faux_spawn_stance = self getstance();
	thread maps\mp\gametypes\_playerlogic::spawnplayer(1);
}

//Function Number: 23
oncantuse(param_00)
{
	param_00 iprintlnbold(&"MP_CANT_PLANT_WITHOUT_BOMB");
}

//Function Number: 24
bombplanted(param_00,param_01)
{
	level endon("overtime");
	maps\mp\gametypes\_gamelogic::pausetimer();
	level.bombplanted = 1;
	level.timelimitoverride = 1;
	level.scorelimitoverride = 1;
	setdvar("ui_bomb_timer",1);
	setgameendtime(int(gettime() + level.bombtimer * 1000));
	param_00.visuals[0] thread maps\mp\gametypes\_gamelogic::playtickingsound();
	var_02 = gettime();
	func_3970();
	setdvar("ui_bomb_timer",0);
	param_00.visuals[0] maps\mp\gametypes\_gamelogic::stoptickingsound();
	if(!level.bombplanted)
	{
		if(level.hotpotato)
		{
			var_03 = gettime() - var_02 / 1000;
			level.bombtimer = level.bombtimer - var_03;
		}

		return;
	}

	var_04 = level.sabbomb.visuals[0].origin;
	level.bombexploded = 1;
	setdvar("ui_danger_team","BombExploded");
	if(isdefined(level.bombowner))
	{
		param_00.visuals[0] radiusdamage(var_04,512,200,20,level.bombowner,"MOD_EXPLOSIVE","bomb_site_mp");
		level.bombowner maps\mp\_utility::incpersstat("destructions",1);
		level.bombowner maps\mp\gametypes\_persistance::statsetchild("round","destructions",level.bombowner.pers["destructions"]);
	}
	else
	{
		param_00.visuals[0] radiusdamage(var_04,512,200,20,undefined,"MOD_EXPLOSIVE","bomb_site_mp");
	}

	var_05 = randomfloat(360);
	var_06 = spawnfx(level._effect["bombexplosion"],var_04 + (0,0,50),(0,0,1),(cos(var_05),sin(var_05),0));
	triggerfx(var_06);
	playrumbleonposition("grenade_rumble",var_04);
	earthquake(0.75,2,var_04,2000);
	thread maps\mp\_utility::playsoundinspace("exp_suitcase_bomb_main",var_04);
	if(isdefined(param_00.exploderindex))
	{
		common_scripts\utility::exploder(param_00.exploderindex);
	}

	level.sabbomb maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	level.bombzones["allies"] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	level.bombzones["axis"] maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	setgameendtime(0);
	level.scorelimitoverride = 1;
	if(level.scoremode)
	{
		lib_036E::func_2B8F(param_01,int(max(maps\mp\_utility::getwatcheddvar("scorelimit"),lib_036E::func_2B96(level.otherteam[param_01]) + 1)));
	}
	else
	{
		lib_036E::func_2B8F(param_01,1);
	}

	lib_036E::func_2B93(param_01);
	if(isdefined(level.bombowner))
	{
		level.bombowner thread maps\mp\gametypes\_rank::giverankxp("destroy");
		lib_036E::func_2B7B("destroy",level.bombowner);
		level thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_objective",level.bombowner);
	}

	wait 3;
	level.finalkillcam_winner = param_01;
	thread maps\mp\gametypes\_gamelogic::endgame(param_01,game["strings"]["target_destroyed"]);
}

//Function Number: 25
func_3970()
{
	level endon("bomb_defused");
	level endon("overtime_ended");
	var_00 = level.bombtimer * 1000 + gettime();
	setdvar("ui_bomb_timer_endtime",var_00);
	level thread func_3971(var_00);
	maps\mp\gametypes\_hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

//Function Number: 26
func_3971(param_00)
{
	level endon("bomb_defused");
	level endon("overtime_ended");
	level endon("game_ended");
	level endon("disconnect");
	level waittill("host_migration_begin");
	var_01 = maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	if(var_01 > 0)
	{
		setdvar("ui_bomb_timer_endtime",param_00 + var_01);
	}
}

//Function Number: 27
givelastonteamwarning()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	maps\mp\_utility::waittillrecoveredhealth(3);
	var_00 = maps\mp\_utility::getotherteam(self.pers["team"]);
	level thread maps\mp\_utility::teamplayercardsplash("callout_lastteammemberalive",self,self.pers["team"]);
	level thread maps\mp\_utility::teamplayercardsplash("callout_lastenemyalive",self,var_00);
	level notify("last_alive",self);
}

//Function Number: 28
ontimelimit()
{
	if(level.bombexploded)
	{
		return;
	}

	if(game["teamScores"]["axis"] > game["teamScores"]["allies"])
	{
		level.finalkillcam_winner = "axis";
		thread maps\mp\gametypes\_gamelogic::endgame("axis",game["strings"]["time_limit_reached"]);
		return;
	}

	if(game["teamScores"]["axis"] < game["teamScores"]["allies"])
	{
		level.finalkillcam_winner = "allies";
		thread maps\mp\gametypes\_gamelogic::endgame("allies",game["strings"]["time_limit_reached"]);
		return;
	}

	if(game["teamScores"]["axis"] == game["teamScores"]["allies"])
	{
		level.finalkillcam_winner = "none";
		if(maps\mp\_utility::inovertime())
		{
			thread maps\mp\gametypes\_gamelogic::endgame("tie",game["strings"]["time_limit_reached"]);
			return;
		}

		thread maps\mp\gametypes\_gamelogic::endgame("overtime",game["strings"]["time_limit_reached"]);
		return;
	}
}

//Function Number: 29
func_3984(param_00)
{
	level endon("game_ended");
	level.inovertime = 1;
	wait 5;
	level.disablespawning = 1;
}

//Function Number: 30
func_3985()
{
	level endon("game_ended");
	if(common_scripts\utility::cointoss())
	{
		level.dangerteam = "allies";
	}
	else
	{
		level.dangerteam = "axis";
	}

	for(;;)
	{
		if(isdefined(level.sabbomb.carrier))
		{
			var_00 = level.sabbomb.carrier;
		}
		else
		{
			var_00 = level.sabbomb.visuals[0];
		}

		if(distance(var_00.origin,level.bombzones[maps\mp\_utility::getotherteam(level.dangerteam)].visuals[0].origin) < distance(var_00.origin,level.bombzones[level.dangerteam].visuals[0].origin))
		{
			level.dangerteam = maps\mp\_utility::getotherteam(level.dangerteam);
		}

		wait 0.05;
	}
}

//Function Number: 31
func_3987()
{
	maps\mp\gametypes\_gameobjects::allowuse("enemy");
	maps\mp\gametypes\_gameobjects::setusetime(level.planttime);
	maps\mp\gametypes\_gameobjects::setusetext(&"MP_PLANTING_EXPLOSIVE");
	maps\mp\gametypes\_gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
	maps\mp\gametypes\_gameobjects::setkeyobject(level.sabbomb);
	maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_defend");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_defend");
	maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_target");
	maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_target");
	maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	self.useweapon = "briefcase_bomb_mp";
}

//Function Number: 32
func_3988()
{
	maps\mp\gametypes\_gameobjects::allowuse("friendly");
	maps\mp\gametypes\_gameobjects::setusetime(level.defusetime);
	maps\mp\gametypes\_gameobjects::setusetext(&"MP_DEFUSING_EXPLOSIVE");
	maps\mp\gametypes\_gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
	maps\mp\gametypes\_gameobjects::setkeyobject(undefined);
	maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_defuse");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_defuse");
	maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_defend");
	maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_defend");
	maps\mp\gametypes\_gameobjects::setvisibleteam("any");
}

//Function Number: 33
bombdefused(param_00)
{
	setdvar("ui_bomb_timer",0);
	maps\mp\gametypes\_gamelogic::resumetimer();
	level.bombplanted = 0;
	level.timelimitoverride = 0;
	level.scorelimitoverride = 0;
	level notify("bomb_defused");
}

//Function Number: 34
ononeleftevent(param_00)
{
	if(level.bombexploded)
	{
		return;
	}

	var_01 = maps\mp\_utility::getlastlivingplayer(param_00);
	var_01 thread givelastonteamwarning();
}

//Function Number: 35
//Function Number: 36
initgametypeawards()
{
	maps\mp\_awards::initstataward("targetsdestroyed",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("bombsplanted",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("bombsdefused",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("bombcarrierkills",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("bombscarried",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("killsasbombcarrier",0,::maps\mp\_awards::highestwins);
}

//Function Number: 37
func_3989()
{
	if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses","axis",5,"class","inUse"))
	{
		level.sab_loadouts["axis"] = maps\mp\_utility::getmatchrulesspecialclass("axis",5);
	}

	if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses","allies",5,"class","inUse"))
	{
		level.sab_loadouts["allies"] = maps\mp\_utility::getmatchrulesspecialclass("allies",5);
	}
}