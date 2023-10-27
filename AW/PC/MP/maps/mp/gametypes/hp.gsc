/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\hp.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 40
 * Decompile Time: 716 ms
 * Timestamp: 10/27/2023 1:43:16 AM
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
	if(isusingmatchrulesdata())
	{
		level.initializematchrules = ::initializematchrules;
		[[ level.initializematchrules ]]();
		level thread maps\mp\_utility::reinitializematchrulesonmigration();
	}
	else
	{
		maps\mp\_utility::registertimelimitdvar(level.gametype,30);
		maps\mp\_utility::registerscorelimitdvar(level.gametype,300);
		maps\mp\_utility::registerroundlimitdvar(level.gametype,1);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,1);
		maps\mp\_utility::registernumlivesdvar(level.gametype,0);
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	level.teambased = 1;
	level.randomzonespawn = maps\mp\_utility::getintproperty("scr_hp_radom_selection",0);
	level.hpstarttime = 0;
	level.zoneduration = 60;
	level.initialzonedelay = maps\mp\_utility::getintproperty("scr_hp_zone_delay",0);
	level.playercapturelpm = 6;
	level.scoreperplayer = 0;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onplayerkilled = ::onplayerkilled;
	level.onprecachegametype = ::onprecachegametype;
	game["dialog"]["gametype"] = "hpt_intro";
	if(getdvarint("g_hardcore"))
	{
		game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
	}

	game["objective_active"] = "mp_hp_new_hardpoint_active";
	game["objective_gained_sound"] = "mp_obj_notify_pos_sml";
	game["objective_lost_sound"] = "mp_obj_notify_neg_sml";
	game["objective_contested_sound"] = "mp_obj_notify_neg_sml";
	if(maps\mp\_utility::isgrapplinghookgamemode())
	{
		game["dialog"]["gametype"] = "grap_" + game["dialog"]["gametype"];
	}

	level.lastdialogtime = 0;
	level.zonespawnqueue = [];
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::setcommonrulesfrommatchrulesdata();
	maps\mp\_utility::registerroundlimitdvar(level.gametype,1);
	maps\mp\_utility::registerwinlimitdvar(level.gametype,1);
	maps\mp\_utility::registerhalftimedvar(level.gametype,0);
	setdynamicdvar("scr_hp_radom_selection",getmatchrulesdata("hpData","randomZones"));
	setdynamicdvar("scr_hp_zone_delay",getmatchrulesdata("hpData","initDelay"));
}

//Function Number: 3
onprecachegametype()
{
	level.objectivehintpreparezone = &"MP_CONTROL_KOTH";
	level.objectivehintcapturezone = &"MP_CAPTURE_KOTH";
	level.objectivehintdefendhq = &"MP_DEFEND_KOTH";
	level.iconneutral3d = "waypoint_captureneutral";
	level.iconneutral2d = "waypoint_captureneutral";
	level.iconcapture3d = "waypoint_capture";
	level.iconcapture2d = "waypoint_capture";
	level.icondefend3d = "waypoint_defend";
	level.icondefend2d = "waypoint_defend";
	level.iconcontested3d = "waypoint_contested";
	level.iconcontested2d = "waypoint_contested";
	level.iconneutralspectator = "waypoint_esports_hardpoint_white";
	level.iconbluespectator = "waypoint_esports_hardpoint_blue";
	level.iconredspectator = "waypoint_esports_hardpoint_red";
	level.iconcontestedspectator = "waypoint_contested";
	level.zonespawninginstr = &"MP_KOTH_AVAILABLE_IN";
	level.zonedestroyedinenemystr = &"MP_KOTH_MOVING_IN";
}

//Function Number: 4
updateobjectivehintmessages(param_00,param_01)
{
	game["strings"]["objective_hint_allies"] = param_00;
	game["strings"]["objective_hint_axis"] = param_01;
}

//Function Number: 5
updateobjectivehintmessage(param_00)
{
	updateobjectivehintmessages(param_00,param_00);
}

//Function Number: 6
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

	maps\mp\_utility::setobjectivetext("allies",&"OBJECTIVES_KOTH");
	maps\mp\_utility::setobjectivetext("axis",&"OBJECTIVES_KOTH");
	if(level.splitscreen)
	{
		maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_KOTH");
		maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_KOTH");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_KOTH_SCORE");
		maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_KOTH_SCORE");
	}

	if(level.initialzonedelay)
	{
		updateobjectivehintmessage(level.objectivehintpreparezone);
	}
	else
	{
		updateobjectivehintmessage(level.objectivehintcapturezone);
	}

	setclientnamemode("auto_change");
	initspawns();
	var_02[0] = "hp";
	maps\mp\gametypes\_gameobjects::main(var_02);
	setomnvar("ui_mlg_game_mode_status_1",0);
	setomnvar("ui_mlg_game_mode_status_2",0);
	level thread onplayerconnect();
	level thread setupzones();
	level thread hardpointmainloop();
}

//Function Number: 7
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.gameobjecthudindex = 0;
		var_00.objective = 0;
		var_00.touchtriggers = [];
	}
}

//Function Number: 8
initspawns()
{
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_hp_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_hp_spawn_axis_start");
	level.spawn_name = "mp_hp_spawn";
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies",level.spawn_name);
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis",level.spawn_name);
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
}

//Function Number: 9
getspawnpoint()
{
	var_00 = self.pers["team"];
	if(game["switchedsides"])
	{
		var_00 = maps\mp\_utility::getotherteam(var_00);
	}

	if(level.usestartspawns && level.ingraceperiod)
	{
		var_01 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_hp_spawn_" + var_00 + "_start");
		var_02 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(var_01);
	}
	else
	{
		var_01 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(var_02);
		var_02 = maps\mp\gametypes\_spawnscoring::getspawnpoint_hardpoint(var_02);
	}

	maps\mp\gametypes\_spawnlogic::recon_set_spawnpoint(var_02);
	return var_02;
}

//Function Number: 10
hpupdateuserate()
{
	level.zone.gameobject maps\mp\gametypes\_gameobjects::updateuserate_internal();
	setomnvar("ui_mlg_game_mode_status_1",level.zone.gameobject.numtouching["allies"]);
	setomnvar("ui_mlg_game_mode_status_2",level.zone.gameobject.numtouching["axis"]);
}

//Function Number: 11
spawn_next_zone()
{
	if(level.randomzonespawn)
	{
		level.zone = getnextzonefromqueue();
	}
	else
	{
		level.zone = getnextzone();
	}

	setneutralicons();
}

//Function Number: 12
hpcaptureloop()
{
	level endon("game_ended");
	level endon("zone_moved");
	level.hpstarttime = gettime();
	for(;;)
	{
		level.zone.gameobject maps\mp\gametypes\_gameobjects::allowuse("any");
		level.zone.gameobject maps\mp\gametypes\_gameobjects::setusetime(0);
		level.zone.gameobject maps\mp\gametypes\_gameobjects::setusetext(&"MP_CAPTURING_OBJECTIVE");
		level.zone.gameobject maps\mp\gametypes\_gameobjects::setvisibleteam("any");
		level.zone.gameobject maps\mp\gametypes\_gameobjects::setmodelvisibility(1);
		level.zone.gameobject maps\mp\gametypes\_gameobjects::mustmaintainclaim(0);
		level.zone.gameobject maps\mp\gametypes\_gameobjects::cancontestclaim(1);
		level.zone.gameobject.onuse = ::onzonecapture;
		var_00 = level common_scripts\utility::waittill_any_return("zone_captured","zone_destroyed");
		if(var_00 == "zone_destroyed")
		{
			continue;
		}

		var_01 = level.zone.gameobject maps\mp\gametypes\_gameobjects::getownerteam();
		if(var_01 == "allies")
		{
			updateobjectivehintmessages(level.objectivehintdefendhq,level.objectivehintcapturezone);
		}
		else if(var_01 == "axis")
		{
			updateobjectivehintmessages(level.objectivehintcapturezone,level.objectivehintdefendhq);
		}
		else
		{
			updateobjectivehintmessages(level.objectivehintcapturezone,level.objectivehintcapturezone);
		}

		level.zone.gameobject maps\mp\gametypes\_gameobjects::allowuse("none");
		level.zone.gameobject.onuse = undefined;
		level.zone.gameobject.onunoccupied = ::onzoneunoccupied;
		level.zone.gameobject.oncontested = ::onzonecontested;
		level.zone.gameobject.onuncontested = ::onzoneuncontested;
		level waittill("zone_destroyed",var_02);
		thread forcespawnteam(var_01);
		if(isdefined(var_02))
		{
			level.zone.gameobject maps\mp\gametypes\_gameobjects::setownerteam(var_02);
			continue;
		}

		level.zone.gameobject maps\mp\gametypes\_gameobjects::setownerteam("none");
	}
}

//Function Number: 13
updategameobjecthudindex()
{
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			var_02 = var_01;
			if(var_01.team == "spectator" || var_01.sessionstate == "spectator")
			{
				var_02 = var_01 getspectatingplayer();
			}

			if(!maps\mp\_utility::isreallyalive(var_02))
			{
				var_01 setgameobjecthudindex(var_01,0);
				continue;
			}

			if(var_02.touchtriggers.size == 0)
			{
				var_01 setgameobjecthudindex(var_01,0);
				continue;
			}

			foreach(var_04 in var_02.touchtriggers)
			{
				if(var_04 == level.zone.gameobject.trigger)
				{
					var_01 setgameobjecthudindex(var_01,1);
					break;
				}

				var_01 setgameobjecthudindex(var_01,0);
			}
		}

		wait(0.05);
	}
}

//Function Number: 14
setgameobjecthudindex(param_00,param_01)
{
	var_02 = 0;
	if(param_01)
	{
		var_02 = 1;
		if(isdefined(level.zone.gameobject.iscontested) && level.zone.gameobject.iscontested)
		{
			var_02 = 2;
		}
	}

	if(var_02 != param_00.gameobjecthudindex)
	{
		param_00 setclientomnvar("ui_hardpoint",var_02);
		param_00.gameobjecthudindex = var_02;
		param_00.objective = var_02;
	}
}

//Function Number: 15
hardpointmainloop()
{
	level endon("game_ended");
	level.zonerevealtime = -100000;
	level.zone = getfirstzone();
	maps\mp\_utility::gameflagwait("prematch_done");
	level childthread updategameobjecthudindex();
	for(;;)
	{
		maps\mp\_utility::playsoundonplayers("mp_suitcase_pickup");
		maps\mp\_utility::flushgroupdialog("gamemode_objective");
		level.zone.gameobject maps\mp\gametypes\_gameobjects::setmodelvisibility(1);
		level.zone.gameobject.onupdateuserate = ::hpupdateuserate;
		level.zonerevealtime = gettime();
		if(level.initialzonedelay)
		{
			setwaitingicons(level.zone);
			level.zone.gameobject maps\mp\gametypes\_gameobjects::setvisibleteam("any");
			updateobjectivehintmessage(level.objectivehintpreparezone);
			setomnvar("ui_hardpoint_timer",gettime() + 1000 * level.initialzonedelay);
			wait(level.initialzonedelay);
		}

		waittillframeend;
		setneutralicons(level.zone);
		maps\mp\_utility::leaderdialog("hp_online",undefined,"gamemode_objective");
		updateobjectivehintmessage(level.objectivehintcapturezone);
		level thread maps\mp\_utility::playsoundonplayers(game["objective_active"]);
		level.zone.gameobject maps\mp\gametypes\_gameobjects::enableobject();
		level.zone.gameobject.capturecount = 0;
		if(level.zoneduration)
		{
			thread movezoneaftertime(level.zoneduration);
			setomnvar("ui_hardpoint_timer",gettime() + 1000 * level.zoneduration);
		}
		else
		{
			level.zonedestroyedbytimer = 0;
		}

		hpcaptureloop();
		var_00 = level.zone.gameobject maps\mp\gametypes\_gameobjects::getownerteam();
		level.zone.gameobject.lastcaptureteam = undefined;
		level.zone.gameobject maps\mp\gametypes\_gameobjects::disableobject();
		level.zone.gameobject maps\mp\gametypes\_gameobjects::allowuse("none");
		level.zone.gameobject maps\mp\gametypes\_gameobjects::setownerteam("neutral");
		level.zone.gameobject maps\mp\gametypes\_gameobjects::setmodelvisibility(0);
		level.zone.gameobject maps\mp\gametypes\_gameobjects::mustmaintainclaim(0);
		level.zone.gameobject maps\mp\gametypes\_gameobjects::set2dicon("mlg",undefined);
		level.zone.gameobject maps\mp\gametypes\_gameobjects::set3dicon("mlg",undefined);
		level notify("zone_reset");
		if(isdefined(level.hp_pause_for_dynamic_event) && level.hp_pause_for_dynamic_event == 1)
		{
			level waittill("ready_for_next_hp_zone");
		}

		spawn_next_zone();
		wait(0.5);
		thread forcespawnteam(var_00);
		wait(0.5);
	}
}

//Function Number: 16
forcespawnteam(param_00)
{
	var_01 = level.players;
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_01[var_02];
		if(!isdefined(var_03))
		{
			continue;
		}

		if(var_03.pers["team"] == param_00)
		{
			var_03 notify("force_spawn");
			wait(0.1);
		}
	}
}

//Function Number: 17
onzonecapture(param_00)
{
	var_01 = param_00.pers["team"];
	var_02 = maps\mp\_utility::getotherteam(var_01);
	var_03 = gettime();
	param_00 logstring("zone captured");
	level.zone.gameobject.iscontested = 0;
	level.usestartspawns = 0;
	setteamicons(var_01);
	if(!isdefined(self.lastcaptureteam) || self.lastcaptureteam != var_01)
	{
		var_04 = [];
		var_05 = getarraykeys(self.touchlist[var_01]);
		for(var_06 = 0;var_06 < var_05.size;var_06++)
		{
			var_04[var_05[var_06]] = self.touchlist[var_01][var_05[var_06]];
		}

		level thread give_capture_credit(var_04,var_03,var_01,self.lastcaptureteam);
		level thread maps\mp\_utility::leaderdialog("hp_secured",var_01,"gamemode_objective");
		level thread maps\mp\_utility::leaderdialog("hp_lost",var_02,"gamemode_objective");
	}

	level thread maps\mp\_utility::playsoundonplayers(game["objective_gained_sound"],var_01);
	level thread maps\mp\_utility::playsoundonplayers(game["objective_lost_sound"],var_02);
	level.hpcapteam = var_01;
	maps\mp\gametypes\_gameobjects::setownerteam(var_01);
	if(isdefined(self.lastcaptureteam) && self.lastcaptureteam != var_01)
	{
		for(var_07 = 0;var_07 < level.players.size;var_07++)
		{
			param_00 = level.players[var_07];
			if(param_00.pers["team"] == var_01)
			{
				if(param_00.lastkilltime + 500 > gettime())
				{
					param_00 maps\mp\gametypes\_missions::processchallenge("ch_hp_killedLastContester");
				}
			}
		}
	}

	level thread awardcapturepoints(var_01,self.lastcaptureteam);
	self.capturecount++;
	self.lastcaptureteam = var_01;
	maps\mp\gametypes\_gameobjects::mustmaintainclaim(1);
	level notify("zone_captured");
	level notify("zone_captured" + var_01);
}

//Function Number: 18
give_capture_credit(param_00,param_01,param_02,param_03)
{
	var_04 = getarraykeys(param_00);
	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		var_06 = param_00[var_04[var_05]].player;
		var_06 updatecapsperminute(param_03);
		if(!isscoreboosting(var_06))
		{
			var_06 maps\mp\gametypes\_missions::processchallenge("ch_hp_capturedObjective");
			if(level.hpstarttime + 500 > param_01)
			{
				var_06 maps\mp\gametypes\_missions::processchallenge("ch_hp_immediateCapture");
			}

			var_06 thread maps\mp\_events::securehardpointevent();
		}
		else
		{
		}

		wait(0.05);
	}
}

//Function Number: 19
onzoneunoccupied()
{
	level notify("zone_destroyed");
	level.hpcapteam = "neutral";
	level.zone.gameobject.iscontested = 0;
	if(self.numtouching["axis"] == 0 && self.numtouching["allies"] == 0)
	{
		level.zone.gameobject.wasleftunoccupied = 1;
		setneutralicons();
	}
}

//Function Number: 20
onzonecontested()
{
	var_00 = level.zone.gameobject maps\mp\gametypes\_gameobjects::getownerteam();
	level.zone.gameobject.wascontested = 1;
	level.zone.gameobject.iscontested = 1;
	setcontestedicons();
	level thread maps\mp\_utility::playsoundonplayers(game["objective_contested_sound"]);
	maps\mp\_utility::leaderdialog("hp_contested",undefined,"gamemode_objective");
}

//Function Number: 21
onzoneuncontested(param_00)
{
	level.zone.gameobject.iscontested = 0;
	setteamicons(param_00);
	level.zone.gameobject maps\mp\gametypes\_gameobjects::setclaimteam(param_00);
}

//Function Number: 22
setneutralicons(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = level.zone;
	}

	param_00.gameobject maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.iconneutral2d);
	param_00.gameobject maps\mp\gametypes\_gameobjects::set3dicon("friendly",level.iconneutral3d);
	param_00.gameobject maps\mp\gametypes\_gameobjects::set2dicon("enemy",level.iconneutral2d);
	param_00.gameobject maps\mp\gametypes\_gameobjects::set3dicon("enemy",level.iconneutral3d);
	param_00.gameobject maps\mp\gametypes\_gameobjects::set2dicon("mlg",level.iconneutralspectator);
	param_00.gameobject maps\mp\gametypes\_gameobjects::set3dicon("mlg",level.iconneutralspectator);
}

//Function Number: 23
setwaitingicons(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = level.zone;
	}

	var_01 = "waypoint_waitfor_flag_neutral";
	param_00.gameobject maps\mp\gametypes\_gameobjects::set2dicon("friendly",var_01);
	param_00.gameobject maps\mp\gametypes\_gameobjects::set3dicon("friendly",var_01);
	param_00.gameobject maps\mp\gametypes\_gameobjects::set2dicon("enemy",var_01);
	param_00.gameobject maps\mp\gametypes\_gameobjects::set3dicon("enemy",var_01);
	param_00.gameobject maps\mp\gametypes\_gameobjects::set2dicon("mlg",var_01);
	param_00.gameobject maps\mp\gametypes\_gameobjects::set3dicon("mlg",var_01);
}

//Function Number: 24
setcontestedicons()
{
	level.zone.gameobject maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.iconcontested2d);
	level.zone.gameobject maps\mp\gametypes\_gameobjects::set3dicon("friendly",level.iconcontested3d);
	level.zone.gameobject maps\mp\gametypes\_gameobjects::set2dicon("enemy",level.iconcontested2d);
	level.zone.gameobject maps\mp\gametypes\_gameobjects::set3dicon("enemy",level.iconcontested3d);
	level.zone.gameobject maps\mp\gametypes\_gameobjects::set2dicon("mlg",level.iconcontestedspectator);
	level.zone.gameobject maps\mp\gametypes\_gameobjects::set3dicon("mlg",level.iconcontestedspectator);
}

//Function Number: 25
setteamicons(param_00)
{
	level.zone.gameobject maps\mp\gametypes\_gameobjects::set2dicon("friendly",level.icondefend2d);
	level.zone.gameobject maps\mp\gametypes\_gameobjects::set3dicon("friendly",level.icondefend3d);
	level.zone.gameobject maps\mp\gametypes\_gameobjects::set2dicon("enemy",level.iconcapture2d);
	level.zone.gameobject maps\mp\gametypes\_gameobjects::set3dicon("enemy",level.iconcapture3d);
	if(param_00 == "allies")
	{
		level.zone.gameobject maps\mp\gametypes\_gameobjects::set2dicon("mlg",level.iconbluespectator);
		level.zone.gameobject maps\mp\gametypes\_gameobjects::set3dicon("mlg",level.iconbluespectator);
		return;
	}

	level.zone.gameobject maps\mp\gametypes\_gameobjects::set2dicon("mlg",level.iconredspectator);
	level.zone.gameobject maps\mp\gametypes\_gameobjects::set3dicon("mlg",level.iconredspectator);
}

//Function Number: 26
movezoneaftertime(param_00)
{
	level endon("game_ended");
	level endon("zone_reset");
	level.zonemovetime = gettime() + param_00 * 1000;
	level.zonedestroyedbytimer = 0;
	wait(param_00);
	if(!isdefined(level.zone.gameobject.wascontested) || level.zone.gameobject.wascontested == 0)
	{
		if(!isdefined(level.zone.gameobject.wasleftunoccupied) || level.zone.gameobject.wasleftunoccupied == 0)
		{
			var_01 = level.zone.gameobject maps\mp\gametypes\_gameobjects::getownerteam();
			foreach(var_03 in level.players)
			{
				if(var_03.pers["team"] == var_01)
				{
					var_03 maps\mp\gametypes\_missions::processchallenge("ch_hp_controlZoneEntirely");
				}
			}
		}
	}

	level.zonedestroyedbytimer = 1;
	level notify("zone_moved");
}

//Function Number: 27
awardcapturepoints(param_00,param_01)
{
	level endon("game_ended");
	level endon("zone_destroyed");
	level endon("zone_reset");
	level endon("zone_moved");
	level notify("awardCapturePointsRunning");
	level endon("awardCapturePointsRunning");
	var_02 = 1;
	var_03 = 1;
	while(!level.gameended)
	{
		wait(var_02);
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
		if(!level.zone.gameobject.iscontested)
		{
			if(level.scoreperplayer)
			{
				var_03 = level.zone.gameobject.numtouching[param_00];
			}

			maps\mp\gametypes\_gamescore::giveteamscoreforobjective(param_00,var_03);
		}
	}
}

//Function Number: 28
comparezoneindexes(param_00,param_01)
{
	var_02 = param_00.script_index;
	var_03 = param_01.script_index;
	if(!isdefined(var_02) && !isdefined(var_03))
	{
		return 0;
	}

	if(!isdefined(var_02) && isdefined(var_03))
	{
		return 1;
	}

	if(isdefined(var_02) && !isdefined(var_03))
	{
		return 0;
	}

	if(var_02 > var_03)
	{
		return 1;
	}

	return 0;
}

//Function Number: 29
getzonearray(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	if(!isdefined(var_01))
	{
		return undefined;
	}

	var_02 = 1;
	for(var_03 = var_01.size;var_02;var_03--)
	{
		var_02 = 0;
		for(var_04 = 0;var_04 < var_03 - 1;var_04++)
		{
			if(comparezoneindexes(var_01[var_04],var_01[var_04 + 1]))
			{
				var_05 = var_01[var_04];
				var_01[var_04] = var_01[var_04 + 1];
				var_01[var_04 + 1] = var_05;
				var_02 = 1;
			}
		}
	}

	return var_01;
}

//Function Number: 30
setupzones()
{
	var_00 = getzonearray("hp_zone_center");
	var_01 = getentarray("hp_zone_trigger","targetname");
	level.zones = matchzonestotriggers(var_00,var_01);
	var_02 = getzonearray("hp_zone_center_augmented");
	var_03 = getentarray("hp_zone_trigger_augmented","targetname");
	if(isdefined(var_02) && isdefined(var_03))
	{
		var_02 = matchzonestotriggers(var_02,var_03);
		if(maps\mp\_utility::isaugmentedgamemode())
		{
			foreach(var_05 in var_02)
			{
				for(var_06 = 0;var_06 < level.zones.size;var_06++)
				{
					if(level.zones[var_06].script_index == var_05.script_index)
					{
						level.zones[var_06] = var_05;
					}
				}
			}
		}
	}

	level.all_hp_zones = level.zones;
	return 1;
}

//Function Number: 31
matchzonestotriggers(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_03 = 0;
		var_04 = param_00[var_02];
		var_04.trig = undefined;
		for(var_05 = 0;var_05 < param_01.size;var_05++)
		{
			if(var_04 istouching(param_01[var_05]))
			{
				if(isdefined(var_04.trig))
				{
					var_03 = 1;
					break;
				}

				var_04.trig = param_01[var_05];
				break;
			}
		}

		if(!isdefined(var_04.trig))
		{
			if(!var_03)
			{
				continue;
			}
		}

		var_04.trigorigin = var_04.trig.origin;
		var_06 = [];
		var_06[0] = var_04;
		if(isdefined(var_04.target))
		{
			var_07 = getentarray(var_04.target,"targetname");
			for(var_05 = 0;var_05 < var_07.size;var_05++)
			{
				var_06[var_06.size] = var_07[var_05];
			}
		}

		var_04.gameobject = maps\mp\gametypes\_gameobjects::createuseobject("neutral",var_04.trig,var_06,(0,0,0));
		var_04.gameobject maps\mp\gametypes\_gameobjects::disableobject();
		setneutralicons(var_04);
		var_04.gameobject maps\mp\gametypes\_gameobjects::set2dicon("mlg",undefined);
		var_04.gameobject maps\mp\gametypes\_gameobjects::set3dicon("mlg",undefined);
		var_04.gameobject maps\mp\gametypes\_gameobjects::setmodelvisibility(0);
		var_04.trig.useobj = var_04.gameobject;
		var_04.gameobject.objpoints["allies"] sethidetrigger(var_04.trig);
		var_04.gameobject.objpoints["axis"] sethidetrigger(var_04.trig);
		var_04.gameobject.objpoints["mlg"] sethidetrigger(var_04.trig);
		var_04 setupnearbyspawns();
	}

	return param_00;
}

//Function Number: 32
setupnearbyspawns()
{
	var_00 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_hp_spawn");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01].distsq = distancesquared(var_00[var_01].origin,self.origin);
	}

	for(var_01 = 1;var_01 < var_00.size;var_01++)
	{
		var_02 = var_00[var_01];
		for(var_03 = var_01 - 1;var_03 >= 0 && var_02.distsq < var_00[var_03].distsq;var_03--)
		{
			var_00[var_03 + 1] = var_00[var_03];
		}

		var_00[var_03 + 1] = var_02;
	}

	var_04 = [];
	var_05 = [];
	var_06 = [];
	var_07 = [];
	var_08 = var_00.size / 3;
	for(var_01 = 0;var_01 <= var_08;var_01++)
	{
		var_04[var_04.size] = var_00[var_01];
	}

	while(var_01 < var_00.size)
	{
		var_07[var_07.size] = var_00[var_01];
		if(var_01 <= var_08 * 2)
		{
			var_05[var_05.size] = var_00[var_01];
			continue;
		}

		var_06[var_06.size] = var_00[var_01];
		var_01++;
	}

	self.gameobject.nearspawns = var_04;
	self.gameobject.midspawns = var_05;
	self.gameobject.farspawns = var_06;
	self.gameobject.outerspawns = var_07;
}

//Function Number: 33
getfirstzone()
{
	var_00 = level.zones[0];
	level.prevzoneindex = 0;
	return var_00;
}

//Function Number: 34
getnextzone()
{
	var_00 = level.prevzoneindex + 1 % level.zones.size;
	var_01 = level.zones[var_00];
	level.prevzoneindex = var_00;
	return var_01;
}

//Function Number: 35
shufflezones()
{
	level.zonespawnqueue = common_scripts\utility::array_randomize(level.zones);
	if(level.zone == level.zonespawnqueue[0])
	{
		level.zonespawnqueue = maps\mp\_utility::swap(level.zonespawnqueue,0,randomintrange(1,level.zonespawnqueue.size));
	}
}

//Function Number: 36
getnextzonefromqueue()
{
	if(level.zonespawnqueue.size == 0)
	{
		shufflezones();
	}

	var_00 = level.zonespawnqueue[0];
	var_01 = [];
	for(var_02 = 1;var_02 < level.zonespawnqueue.size;var_02++)
	{
		var_01[var_02 - 1] = level.zonespawnqueue[var_02];
	}

	level.zonespawnqueue = var_01;
	return var_00;
}

//Function Number: 37
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isplayer(param_01))
	{
		return;
	}

	if(maps\mp\gametypes\_damage::isfriendlyfire(self,param_01))
	{
		return;
	}

	if(param_01 == self)
	{
		return;
	}

	if(!isdefined(level.zone))
	{
		return;
	}

	var_0A = level.zone.gameobject.ownerteam;
	if(!isdefined(var_0A) || var_0A == "neutral")
	{
		return;
	}

	if(isdefined(param_04) && maps\mp\_utility::iskillstreakweapon(param_04))
	{
		return;
	}

	var_0B = 0;
	if(!level.zone.gameobject.iscontested && param_01 istouching(level.zone.trig))
	{
		var_0B = 1;
		param_01 thread maps\mp\_events::killwhilecapture(self,param_09);
	}

	if(self istouching(level.zone.trig))
	{
		param_01.lastkilltime = gettime();
		if(var_0B)
		{
			return;
		}

		if(self.team == var_0A)
		{
			param_01 thread maps\mp\_events::assaultobjectiveevent(self,param_09);
			return;
		}

		param_01 maps\mp\gametypes\_missions::processchallenge("ch_hp_zoneDefense");
		param_01 thread maps\mp\_events::defendobjectiveevent(self,param_09);
		param_01 maps\mp\_utility::setextrascore1(param_01.pers["defends"]);
	}
}

//Function Number: 38
onendgame(param_00)
{
	for(var_01 = 0;var_01 < level.zones.size;var_01++)
	{
		level.zones[var_01].gameobject maps\mp\gametypes\_gameobjects::allowuse("none");
	}
}

//Function Number: 39
updatecapsperminute(param_00)
{
	if(!isdefined(self.capsperminute))
	{
		self.numcaps = 0;
		self.capsperminute = 0;
	}

	if(!isdefined(param_00) || param_00 == "neutral")
	{
		return;
	}

	self.numcaps++;
	var_01 = maps\mp\_utility::gettimepassed() / 60000;
	if(isplayer(self) && isdefined(self.timeplayed["total"]))
	{
		var_01 = self.timeplayed["total"] / 60;
	}

	self.capsperminute = self.numcaps / var_01;
	if(self.capsperminute > self.numcaps)
	{
		self.capsperminute = self.numcaps;
	}
}

//Function Number: 40
isscoreboosting(param_00)
{
	if(!level.rankedmatch)
	{
		return 0;
	}

	if(param_00.capsperminute > level.playercapturelpm)
	{
		return 1;
	}

	return 0;
}