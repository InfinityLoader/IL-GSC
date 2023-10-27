/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\sd.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 35
 * Decompile Time: 540 ms
 * Timestamp: 10/27/2023 2:13:34 AM
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
		level thread maps\mp\_utility::reinitializematchrulesonmigration();
	}
	else
	{
		maps\mp\_utility::registerroundswitchdvar(level.gametype,3,0,9);
		maps\mp\_utility::registertimelimitdvar(level.gametype,2.5);
		maps\mp\_utility::registerscorelimitdvar(level.gametype,1);
		maps\mp\_utility::registerroundlimitdvar(level.gametype,0);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,4);
		maps\mp\_utility::registernumlivesdvar(level.gametype,1);
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	level.objectivebased = 1;
	level.teambased = 1;
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onspawnplayer = ::onspawnplayer;
	level.onplayerkilled = ::onplayerkilled;
	level.ondeadevent = ::ondeadevent;
	level.ononeleftevent = ::ononeleftevent;
	level.ontimelimit = ::ontimelimit;
	level.onnormaldeath = ::onnormaldeath;
	level.initgametypeawards = ::initgametypeawards;
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	game["dialog"]["gametype"] = "searchdestroy";
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

	game["dialog"]["offense_obj"] = "obj_destroy";
	game["dialog"]["defense_obj"] = "obj_defend";
	makedvarserverinfo("ui_bomb_timer_endtime",-1);
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::setcommonrulesfrommatchrulesdata();
	var_00 = getmatchrulesdata("sdData","roundLength");
	setdynamicdvar("scr_sd_timelimit",var_00);
	maps\mp\_utility::registertimelimitdvar("sd",var_00);
	var_01 = getmatchrulesdata("sdData","roundSwitch");
	setdynamicdvar("scr_sd_roundswitch",var_01);
	maps\mp\_utility::registerroundswitchdvar("sd",var_01,0,9);
	var_02 = getmatchrulesdata("commonOption","scoreLimit");
	setdynamicdvar("scr_sd_winlimit",var_02);
	maps\mp\_utility::registerwinlimitdvar("sd",var_02);
	setdynamicdvar("scr_sd_bombtimer",getmatchrulesdata("sdData","bombTimer"));
	setdynamicdvar("scr_sd_planttime",getmatchrulesdata("sdData","plantTime"));
	setdynamicdvar("scr_sd_defusetime",getmatchrulesdata("sdData","defuseTime"));
	setdynamicdvar("scr_sd_multibomb",getmatchrulesdata("sdData","multiBomb"));
	setdynamicdvar("scr_sd_roundlimit",0);
	maps\mp\_utility::registerroundlimitdvar("sd",0);
	setdynamicdvar("scr_sd_scorelimit",1);
	maps\mp\_utility::registerscorelimitdvar("sd",1);
	setdynamicdvar("scr_sd_halftime",0);
	maps\mp\_utility::registerhalftimedvar("sd",0);
	setdynamicdvar("scr_sd_promode",0);
}

//Function Number: 3
onprecachegametype()
{
	game["bomb_dropped_sound"] = "mp_war_objective_lost";
	game["bomb_recovered_sound"] = "mp_war_objective_taken";
	precacheshader("waypoint_bomb");
	precacheshader("hud_suitcase_bomb");
	precacheshader("waypoint_target");
	precacheshader("waypoint_target_a");
	precacheshader("waypoint_target_b");
	precacheshader("waypoint_defend");
	precacheshader("waypoint_defend_a");
	precacheshader("waypoint_defend_b");
	precacheshader("waypoint_defuse");
	precacheshader("waypoint_defuse_a");
	precacheshader("waypoint_defuse_b");
	precacheshader("waypoint_escort");
	precachestring(&"MP_EXPLOSIVES_RECOVERED_BY");
	precachestring(&"MP_EXPLOSIVES_DROPPED_BY");
	precachestring(&"MP_EXPLOSIVES_PLANTED_BY");
	precachestring(&"MP_EXPLOSIVES_DEFUSED_BY");
	precachestring(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
	precachestring(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
	precachestring(&"MP_CANT_PLANT_WITHOUT_BOMB");
	precachestring(&"MP_PLANTING_EXPLOSIVE");
	precachestring(&"MP_DEFUSING_EXPLOSIVE");
}

//Function Number: 4
onstartgametype()
{
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

	setclientnamemode("manual_change");
	game["strings"]["target_destroyed"] = &"MP_TARGET_DESTROYED";
	game["strings"]["bomb_defused"] = &"MP_BOMB_DEFUSED";
	precachestring(game["strings"]["target_destroyed"]);
	precachestring(game["strings"]["bomb_defused"]);
	level._effect["bombexplosion"] = loadfx("explosions/tanker_explosion");
	maps\mp\_utility::setobjectivetext(game["attackers"],&"OBJECTIVES_SD_ATTACKER");
	maps\mp\_utility::setobjectivetext(game["defenders"],&"OBJECTIVES_SD_DEFENDER");
	if(level.splitscreen)
	{
		maps\mp\_utility::setobjectivescoretext(game["attackers"],&"OBJECTIVES_SD_ATTACKER");
		maps\mp\_utility::setobjectivescoretext(game["defenders"],&"OBJECTIVES_SD_DEFENDER");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext(game["attackers"],&"OBJECTIVES_SD_ATTACKER_SCORE");
		maps\mp\_utility::setobjectivescoretext(game["defenders"],&"OBJECTIVES_SD_DEFENDER_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext(game["attackers"],&"OBJECTIVES_SD_ATTACKER_HINT");
	maps\mp\_utility::setobjectivehinttext(game["defenders"],&"OBJECTIVES_SD_DEFENDER_HINT");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_sd_spawn_attacker");
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_sd_spawn_defender");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	var_02[0] = "sd";
	maps\mp\gametypes\_gameobjects::main(var_7B);
	maps\mp\gametypes\_rank::registerscoreinfo("win",2);
	maps\mp\gametypes\_rank::registerscoreinfo("loss",1);
	maps\mp\gametypes\_rank::registerscoreinfo("tie",1.5);
	maps\mp\gametypes\_rank::registerscoreinfo("kill",50);
	maps\mp\gametypes\_rank::registerscoreinfo("headshot",50);
	maps\mp\gametypes\_rank::registerscoreinfo("assist",20);
	maps\mp\gametypes\_rank::registerscoreinfo("plant",100);
	maps\mp\gametypes\_rank::registerscoreinfo("defuse",100);
	thread updategametypedvars();
	func_3972();
	thread func_3962();
}

//Function Number: 5
getspawnpoint()
{
	if(self.pers["team"] == game["attackers"])
	{
		var_00 = "mp_sd_spawn_attacker";
	}
	else
	{
		var_00 = "mp_sd_spawn_defender";
	}

	var_01 = maps\mp\gametypes\_spawnlogic::getspawnpointarray(var_00);
	var_02 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(var_01);
	return var_02;
}

//Function Number: 6
onspawnplayer()
{
	self.isplanting = 0;
	self.isdefusing = 0;
	self.isbombcarrier = 0;
	if(level.multibomb && !isdefined(self.carryicon) && self.pers["team"] == game["attackers"] && !level.bombplanted)
	{
		if(level.splitscreen)
		{
			self.carryicon = maps\mp\gametypes\_hud_util::createicon("hud_suitcase_bomb",33,33);
			self.carryicon maps\mp\gametypes\_hud_util::setpoint("BOTTOM RIGHT","BOTTOM RIGHT",-50,-78);
			self.carryicon.alpha = 0.75;
		}
		else
		{
			self.carryicon = maps\mp\gametypes\_hud_util::createicon("hud_suitcase_bomb",50,50);
			self.carryicon maps\mp\gametypes\_hud_util::setpoint("BOTTOM RIGHT","BOTTOM RIGHT",-50,-65);
			self.carryicon.alpha = 0.75;
		}

		self.carryicon.hidewheninmenu = 1;
		thread hidecarryiconongameend();
	}

	level notify("spawned_player");
}

//Function Number: 7
hidecarryiconongameend()
{
	self endon("disconnect");
	level waittill("game_ended");
	if(isdefined(self.carryicon))
	{
		self.carryicon.alpha = 0;
	}
}

//Function Number: 8
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	thread func_3959();
}

//Function Number: 9
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

//Function Number: 10
func_395A(param_00,param_01)
{
	level.finalkillcam_winner = param_00;
	if(param_01 == game["strings"]["target_destroyed"] || param_01 == game["strings"]["bomb_defused"])
	{
		var_02 = 1;
		foreach(var_04 in level.bombzones)
		{
			if(isdefined(level.finalkillcam_killcamentityindex[param_00]) && level.finalkillcam_killcamentityindex[param_00] == var_04.killcamentnum)
			{
				var_02 = 0;
				break;
			}
		}

		if(var_02)
		{
			maps\mp\gametypes\_damage::erasefinalkillcam();
		}
	}

	thread maps\mp\gametypes\_gamelogic::endgame(param_00,param_01);
}

//Function Number: 11
ondeadevent(param_00)
{
	if(level.bombexploded || level.bombdefused)
	{
		return;
	}

	if(param_00 == "all")
	{
		if(level.bombplanted)
		{
			func_395A(game["attackers"],game["strings"][game["defenders"] + "_eliminated"]);
			return;
		}

		func_395A(game["defenders"],game["strings"][game["attackers"] + "_eliminated"]);
		return;
	}

	if(param_00 == game["attackers"])
	{
		if(level.bombplanted)
		{
			return;
		}

		level thread func_395A(game["defenders"],game["strings"][game["attackers"] + "_eliminated"]);
		return;
	}

	if(param_00 == game["defenders"])
	{
		level thread func_395A(game["attackers"],game["strings"][game["defenders"] + "_eliminated"]);
		return;
	}
}

//Function Number: 12
ononeleftevent(param_00)
{
	if(level.bombexploded || level.bombdefused)
	{
		return;
	}

	var_01 = maps\mp\_utility::getlastlivingplayer(param_00);
	var_01 thread givelastonteamwarning();
}

//Function Number: 13
onnormaldeath(param_00,param_01,param_02)
{
	var_03 = maps\mp\gametypes\_rank::getscoreinfovalue("kill");
	var_04 = param_00.team;
	if(game["state"] == "postgame" && param_00.team == game["defenders"] || !level.bombplanted)
	{
		param_01.finalkill = 1;
	}

	if(param_00.isplanting)
	{
		thread maps\mp\_matchdata::logkillevent(param_02,"planting");
		param_01 maps\mp\_utility::incpersstat("defends",1);
		param_01 maps\mp\gametypes\_persistance::statsetchild("round","defends",param_01.pers["defends"]);
	}
	else if(param_00.isbombcarrier)
	{
		param_01 maps\mp\_utility::incplayerstat("bombcarrierkills",1);
		thread maps\mp\_matchdata::logkillevent(param_02,"carrying");
	}
	else if(param_00.isdefusing)
	{
		thread maps\mp\_matchdata::logkillevent(param_02,"defusing");
		param_01 maps\mp\_utility::incpersstat("defends",1);
		param_01 maps\mp\gametypes\_persistance::statsetchild("round","defends",param_01.pers["defends"]);
	}

	if(param_01.isbombcarrier)
	{
		param_01 maps\mp\_utility::incplayerstat("killsasbombcarrier",1);
	}
}

//Function Number: 14
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
	maps\mp\gametypes\_missions::lastmansd();
}

//Function Number: 15
ontimelimit()
{
	func_395A(game["defenders"],game["strings"]["time_limit_reached"]);
}

//Function Number: 16
updategametypedvars()
{
	level.planttime = maps\mp\_utility::dvarfloatvalue("planttime",5,0,20);
	level.defusetime = maps\mp\_utility::dvarfloatvalue("defusetime",5,0,20);
	level.bombtimer = maps\mp\_utility::dvarfloatvalue("bombtimer",45,1,300);
	level.multibomb = maps\mp\_utility::dvarintvalue("multibomb",0,0,1);
}

//Function Number: 17
func_3960(param_00)
{
	var_01 = [];
	var_02 = getentarray("script_brushmodel","classname");
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04.script_gameobjectname) && var_04.script_gameobjectname == "bombzone")
		{
			foreach(var_06 in param_00)
			{
				if(distance(var_04.origin,var_06.origin) < 100 && issubstr(tolower(var_06.script_label),"c"))
				{
					var_06.relatedbrushmodel = var_04;
					var_01[var_01.size] = var_06;
					break;
				}
			}
		}
	}

	foreach(var_0A in var_01)
	{
		var_0A.relatedbrushmodel delete();
		var_0B = getentarray(var_0A.target,"targetname");
		foreach(var_0D in var_0B)
		{
			var_0D delete();
		}

		var_0A delete();
	}

	return common_scripts\utility::array_removeundefined(param_00);
}

//Function Number: 18
func_3962()
{
	level.bombplanted = 0;
	level.bombdefused = 0;
	level.bombexploded = 0;
	var_00 = getent("sd_bomb_pickup_trig","targetname");
	if(!isdefined(var_00))
	{
		common_scripts\utility::error("No sd_bomb_pickup_trig trigger found in map.");
		return;
	}

	var_01[0] = getent("sd_bomb","targetname");
	if(!isdefined(var_01[0]))
	{
		common_scripts\utility::error("No sd_bomb script_model found in map.");
		return;
	}

	precachemodel("prop_suitcase_bomb");
	var_01[0] setmodel("prop_suitcase_bomb");
	if(!level.multibomb)
	{
		level.sdbomb = maps\mp\gametypes\_gameobjects::createcarryobject(game["attackers"],var_00,var_01,(0,0,32));
		level.sdbomb maps\mp\gametypes\_gameobjects::allowcarry("friendly");
		level.sdbomb maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_bomb");
		level.sdbomb maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_bomb");
		level.sdbomb maps\mp\gametypes\_gameobjects::setvisibleteam("friendly");
		level.sdbomb maps\mp\gametypes\_gameobjects::setcarryicon("hud_suitcase_bomb");
		level.sdbomb.allowweapons = 1;
		level.sdbomb.onpickup = ::onpickup;
		level.sdbomb.ondrop = ::ondrop;
	}
	else
	{
		var_00 delete();
		var_01[0] delete();
	}

	level.bombzones = [];
	var_02 = getentarray("bombzone","targetname");
	var_02 = func_3960(var_02);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_00 = var_02[var_03];
		var_01 = getentarray(var_02[var_03].target,"targetname");
		var_04 = maps\mp\gametypes\_gameobjects::createuseobject(game["defenders"],var_00,var_01,(0,0,64));
		var_04 maps\mp\gametypes\_gameobjects::allowuse("enemy");
		var_04 maps\mp\gametypes\_gameobjects::setusetime(level.planttime);
		var_04 maps\mp\gametypes\_gameobjects::setusetext(&"MP_PLANTING_EXPLOSIVE");
		var_04 maps\mp\gametypes\_gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_PLANT_EXPLOSIVES");
		if(!level.multibomb)
		{
			var_04 maps\mp\gametypes\_gameobjects::setkeyobject(level.sdbomb);
		}

		var_05 = var_04 maps\mp\gametypes\_gameobjects::getlabel();
		var_04.label = var_05;
		var_04 maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_defend" + var_05);
		var_04 maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_defend" + var_05);
		var_04 maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_target" + var_05);
		var_04 maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_target" + var_05);
		var_04 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
		var_04.onbeginuse = ::onbeginuse;
		var_04.onenduse = ::onenduse;
		var_04.onuse = ::func_3969;
		var_04.oncantuse = ::oncantuse;
		var_04.useweapon = "briefcase_bomb_mp";
		for(var_06 = 0;var_06 < var_01.size;var_06++)
		{
			if(isdefined(var_01[var_06].script_exploder))
			{
				var_04.exploderindex = var_01[var_06].script_exploder;
				var_01[var_06] thread func_3967(var_04);
				break;
			}
		}

		level.bombzones[level.bombzones.size] = var_04;
		var_04.bombdefusetrig = getent(var_01[0].target,"targetname");
		var_04.bombdefusetrig.origin = var_04.bombdefusetrig.origin + (0,0,-10000);
		var_04.bombdefusetrig.label = var_05;
	}

	for(var_03 = 0;var_03 < level.bombzones.size;var_03++)
	{
		var_07 = [];
		for(var_08 = 0;var_08 < level.bombzones.size;var_08++)
		{
			if(var_08 != var_03)
			{
				var_07[var_07.size] = level.bombzones[var_08];
			}
		}

		level.bombzones[var_03].otherbombzones = var_07;
	}
}

//Function Number: 19
func_3967(param_00)
{
	var_01 = spawn("script_origin",self.origin);
	var_01.angles = self.angles;
	var_01 rotateyaw(-45,0.05);
	wait 0.05;
	var_02 = self.origin + (0,0,5);
	var_03 = self.origin + anglestoforward(var_01.angles) * 100 + (0,0,128);
	var_04 = bullettrace(var_02,var_03,0,self);
	self.killcament = spawn("script_model",var_04["position"]);
	self.killcament setscriptmoverkillcam("explosive");
	param_00.killcamentnum = self.killcament getentitynumber();
	var_01 delete();
}

//Function Number: 20
onbeginuse(param_00)
{
	if(maps\mp\gametypes\_gameobjects::isfriendlyteam(param_00.pers["team"]))
	{
		param_00 playsound("mp_bomb_defuse");
		param_00.isdefusing = 1;
		if(isdefined(level.sdbombmodel))
		{
			level.sdbombmodel hide();
			return;
		}

		return;
	}

	param_00.isplanting = 1;
	if(level.multibomb)
	{
		for(var_01 = 0;var_01 < self.otherbombzones.size;var_01++)
		{
			self.otherbombzones[var_01] maps\mp\gametypes\_gameobjects::allowuse("none");
			self.otherbombzones[var_01] maps\mp\gametypes\_gameobjects::setvisibleteam("friendly");
		}
	}
}

//Function Number: 21
onenduse(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		return;
	}

	if(isalive(param_01))
	{
		param_01.isdefusing = 0;
		param_01.isplanting = 0;
	}

	if(maps\mp\gametypes\_gameobjects::isfriendlyteam(param_01.pers["team"]))
	{
		if(isdefined(level.sdbombmodel) && !param_02)
		{
			level.sdbombmodel show();
			return;
		}

		return;
	}

	if(level.multibomb && !param_02)
	{
		for(var_03 = 0;var_03 < self.otherbombzones.size;var_03++)
		{
			self.otherbombzones[var_03] maps\mp\gametypes\_gameobjects::allowuse("enemy");
			self.otherbombzones[var_03] maps\mp\gametypes\_gameobjects::setvisibleteam("any");
		}
	}
}

//Function Number: 22
oncantuse(param_00)
{
	param_00 iprintlnbold(&"MP_CANT_PLANT_WITHOUT_BOMB");
}

//Function Number: 23
func_3969(param_00)
{
	if(!maps\mp\gametypes\_gameobjects::isfriendlyteam(param_00.pers["team"]))
	{
		level thread bombplanted(self,param_00);
		for(var_01 = 0;var_01 < level.bombzones.size;var_01++)
		{
			if(level.bombzones[var_01] == self)
			{
				continue;
			}

			level.bombzones[var_01] maps\mp\gametypes\_gameobjects::disableobject();
		}

		param_00 playsound("mp_bomb_plant");
		param_00 notify("bomb_planted");
		param_00 notify("objective","plant");
		param_00 maps\mp\_utility::incpersstat("plants",1);
		param_00 maps\mp\gametypes\_persistance::statsetchild("round","plants",param_00.pers["plants"]);
		if(isdefined(level.sd_loadout) && isdefined(level.sd_loadout[param_00.team]))
		{
			param_00 thread func_396D();
		}

		maps\mp\_utility::leaderdialog("bomb_planted");
		level thread maps\mp\_utility::teamplayercardsplash("callout_bombplanted",param_00);
		level.bombowner = param_00;
		param_00 thread maps\mp\gametypes\_hud_message::splashnotify("plant",maps\mp\gametypes\_rank::getscoreinfovalue("plant"));
		param_00 thread maps\mp\gametypes\_rank::giverankxp("plant");
		param_00.bombplantedtime = gettime();
		lib_036E::func_2B7B("plant",param_00);
		param_00 thread maps\mp\_matchdata::loggameevent("plant",param_00.origin);
	}
}

//Function Number: 24
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

	self.pers["gamemodeLoadout"] = level.sd_loadout[self.team];
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

//Function Number: 25
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

//Function Number: 26
func_396E(param_00)
{
	param_00 notify("bomb_defused");
	param_00 notify("objective","defuse");
	level thread bombdefused();
	maps\mp\gametypes\_gameobjects::disableobject();
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
}

//Function Number: 27
ondrop(param_00)
{
	maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_bomb");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_bomb");
	maps\mp\_utility::playsoundonplayers(game["bomb_dropped_sound"],game["attackers"]);
}

//Function Number: 28
onpickup(param_00)
{
	param_00.isbombcarrier = 1;
	param_00 maps\mp\_utility::incplayerstat("bombscarried",1);
	param_00 thread maps\mp\_matchdata::loggameevent("pickup",param_00.origin);
	maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_escort");
	maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_escort");
	if(isdefined(level.sd_loadout) && isdefined(level.sd_loadout[param_00.team]))
	{
		param_00 thread func_396C();
	}

	if(!level.bombdefused)
	{
		maps\mp\_utility::teamplayercardsplash("callout_bombtaken",param_00,param_00.team);
		maps\mp\_utility::leaderdialog("bomb_taken",param_00.pers["team"]);
	}

	maps\mp\_utility::playsoundonplayers(game["bomb_recovered_sound"],game["attackers"]);
}

//Function Number: 29
onreset()
{
}

//Function Number: 30
bombplanted(param_00,param_01)
{
	maps\mp\gametypes\_gamelogic::pausetimer();
	level.bombplanted = 1;
	param_00.visuals[0] thread maps\mp\gametypes\_gamelogic::playtickingsound();
	level.tickingobject = param_00.visuals[0];
	level.timelimitoverride = 1;
	setgameendtime(int(gettime() + level.bombtimer * 1000));
	setdvar("ui_bomb_timer",1);
	if(!level.multibomb)
	{
		level.sdbomb maps\mp\gametypes\_gameobjects::allowcarry("none");
		level.sdbomb maps\mp\gametypes\_gameobjects::setvisibleteam("none");
		level.sdbomb maps\mp\gametypes\_gameobjects::setdropped();
		level.sdbombmodel = level.sdbomb.visuals[0];
	}
	else
	{
		for(var_02 = 0;var_02 < level.players.size;var_02++)
		{
			if(isdefined(level.players[var_02].carryicon))
			{
				level.players[var_02].carryicon maps\mp\gametypes\_hud_util::destroyelem();
			}
		}

		var_03 = bullettrace(param_01.origin + (0,0,20),param_01.origin - (0,0,2000),0,param_01);
		var_04 = randomfloat(360);
		var_05 = (cos(var_04),sin(var_04),0);
		var_05 = vectornormalize(var_05 - var_03["normal"] * vectordot(var_05,var_03["normal"]));
		var_06 = vectortoangles(var_05);
		level.sdbombmodel = spawn("script_model",var_03["position"]);
		level.sdbombmodel.angles = var_06;
		level.sdbombmodel setmodel("prop_suitcase_bomb");
	}

	param_00 maps\mp\gametypes\_gameobjects::allowuse("none");
	param_00 maps\mp\gametypes\_gameobjects::setvisibleteam("none");
	var_07 = param_00 maps\mp\gametypes\_gameobjects::getlabel();
	var_08 = param_00.bombdefusetrig;
	var_08.origin = level.sdbombmodel.origin;
	var_09 = [];
	var_0A = maps\mp\gametypes\_gameobjects::createuseobject(game["defenders"],var_08,var_09,(0,0,32));
	var_0A maps\mp\gametypes\_gameobjects::allowuse("friendly");
	var_0A maps\mp\gametypes\_gameobjects::setusetime(level.defusetime);
	var_0A maps\mp\gametypes\_gameobjects::setusetext(&"MP_DEFUSING_EXPLOSIVE");
	var_0A maps\mp\gametypes\_gameobjects::setusehinttext(&"PLATFORM_HOLD_TO_DEFUSE_EXPLOSIVES");
	var_0A maps\mp\gametypes\_gameobjects::setvisibleteam("any");
	var_0A maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_defuse" + var_07);
	var_0A maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_defend" + var_07);
	var_0A maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_defuse" + var_07);
	var_0A maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_defend" + var_07);
	var_0A.label = var_07;
	var_0A.onbeginuse = ::onbeginuse;
	var_0A.onenduse = ::onenduse;
	var_0A.onuse = ::func_396E;
	var_0A.useweapon = "briefcase_bomb_defuse_mp";
	func_3970();
	setdvar("ui_bomb_timer",0);
	param_00.visuals[0] maps\mp\gametypes\_gamelogic::stoptickingsound();
	if(level.gameended || level.bombdefused)
	{
		return;
	}

	level.bombexploded = 1;
	var_0B = level.sdbombmodel.origin;
	level.sdbombmodel hide();
	if(isdefined(param_01))
	{
		param_00.visuals[0] radiusdamage(var_0B,512,200,20,param_01,"MOD_EXPLOSIVE","bomb_site_mp");
		param_01 maps\mp\_utility::incpersstat("destructions",1);
		param_01 maps\mp\gametypes\_persistance::statsetchild("round","destructions",param_01.pers["destructions"]);
	}
	else
	{
		param_00.visuals[0] radiusdamage(var_0B,512,200,20,undefined,"MOD_EXPLOSIVE","bomb_site_mp");
	}

	var_0C = randomfloat(360);
	var_0D = spawnfx(level._effect["bombexplosion"],var_0B + (0,0,50),(0,0,1),(cos(var_0C),sin(var_0C),0));
	triggerfx(var_0D);
	playrumbleonposition("grenade_rumble",var_0B);
	earthquake(0.75,2,var_0B,2000);
	thread maps\mp\_utility::playsoundinspace("exp_suitcase_bomb_main",var_0B);
	if(isdefined(param_00.exploderindex))
	{
		common_scripts\utility::exploder(param_00.exploderindex);
	}

	for(var_02 = 0;var_02 < level.bombzones.size;var_02++)
	{
		level.bombzones[var_02] maps\mp\gametypes\_gameobjects::disableobject();
	}

	var_0A maps\mp\gametypes\_gameobjects::disableobject();
	setgameendtime(0);
	wait 3;
	func_395A(game["attackers"],game["strings"]["target_destroyed"]);
}

//Function Number: 31
func_3970()
{
	level endon("game_ended");
	level endon("bomb_defused");
	var_00 = level.bombtimer * 1000 + gettime();
	setdvar("ui_bomb_timer_endtime",var_00);
	level thread func_3971(var_00);
	maps\mp\gametypes\_hostmigration::waitlongdurationwithgameendtimeupdate(level.bombtimer);
}

//Function Number: 32
func_3971(param_00)
{
	level endon("game_ended");
	level endon("bomb_defused");
	level endon("game_ended");
	level endon("disconnect");
	level waittill("host_migration_begin");
	var_01 = maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	if(var_01 > 0)
	{
		setdvar("ui_bomb_timer_endtime",param_00 + var_01);
	}
}

//Function Number: 33
bombdefused()
{
	level.tickingobject maps\mp\gametypes\_gamelogic::stoptickingsound();
	level.bombdefused = 1;
	setdvar("ui_bomb_timer",0);
	level notify("bomb_defused");
	wait 1.5;
	setgameendtime(0);
	func_395A(game["defenders"],game["strings"]["bomb_defused"]);
}

//Function Number: 34
initgametypeawards()
{
	maps\mp\_awards::initstataward("targetsdestroyed",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("bombsplanted",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("bombsdefused",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("bombcarrierkills",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("bombscarried",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("killsasbombcarrier",0,::maps\mp\_awards::highestwins);
}

//Function Number: 35
func_3972()
{
	if(isusingmatchrulesdata() && getmatchrulesdata("defaultClasses","axis",5,"class","inUse"))
	{
		level.sd_loadout[game["attackers"]] = maps\mp\_utility::getmatchrulesspecialclass("axis",5);
	}
}