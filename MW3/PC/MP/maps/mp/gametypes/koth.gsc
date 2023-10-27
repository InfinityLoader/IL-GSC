/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\koth.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 352 ms
 * Timestamp: 10/27/2023 2:13:20 AM
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
	level.doprematch = 1;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onspawnplayer = ::onspawnplayer;
	level.onplayerkilled = ::onplayerkilled;
	level.initgametypeawards = ::initgametypeawards;
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	precacheshader("waypoint_captureneutral");
	precacheshader("waypoint_capture");
	precacheshader("waypoint_defend");
	precacheshader("waypoint_targetneutral");
	precacheshader("waypoint_captureneutral");
	precacheshader("waypoint_capture");
	precacheshader("waypoint_defend");
	precachestring(&"MP_WAITING_FOR_HQ");
	if(getdvar("koth_autodestroytime") == "")
	{
		setdvar("koth_autodestroytime","60");
	}

	level.hqautodestroytime = getdvarint("koth_autodestroytime");
	if(getdvar("koth_spawntime") == "")
	{
		setdvar("koth_spawntime","0");
	}

	level.hqspawntime = getdvarint("koth_spawntime");
	if(getdvar("koth_kothmode") == "")
	{
		setdvar("koth_kothmode","1");
	}

	level.kothmode = getdvarint("koth_kothmode");
	if(getdvar("koth_captureTime") == "")
	{
		setdvar("koth_captureTime","20");
	}

	level.capturetime = getdvarint("koth_captureTime");
	if(getdvar("koth_destroyTime") == "")
	{
		setdvar("koth_destroyTime","10");
	}

	level.destroytime = getdvarint("koth_destroyTime");
	if(getdvar("koth_delayPlayer") == "")
	{
		setdvar("koth_delayPlayer",1);
	}

	level.delayplayer = getdvarint("koth_delayPlayer");
	if(getdvar("koth_spawnDelay") == "")
	{
		setdvar("koth_spawnDelay",0);
	}

	level.spawndelay = getdvarint("koth_spawnDelay");
	if(getdvar("koth_extraDelay") == "")
	{
		setdvar("koth_extraDelay",0);
	}

	level.extradelay = getdvarint("koth_extraDelay");
	setdvarifuninitialized("koth_proMode",0);
	level.promode = getdvarint("koth_proMode");
	level.iconoffset = (0,0,32);
	level.onrespawndelay = ::func_3995;
	game["dialog"]["gametype"] = "headquarters";
	if(getdvarint("g_hardcore"))
	{
		if(getmapcustom("allieschar") == "us_army")
		{
			game["dialog"]["allies_gametype"] = "hc_hq";
		}

		if(getmapcustom("axischar") == "us_army")
		{
			game["dialog"]["axis_gametype"] = "hc_hq";
		}

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
	maps\mp\_utility::setcommonrulesfrommatchrulesdata();
	setdynamicdvar("koth_autodestroytime",getmatchrulesdata("hqData","HQLifetime"));
	setdynamicdvar("koth_spawntime",getmatchrulesdata("hqData","HQActivateDelay"));
	setdynamicdvar("scr_koth_roundswitch",1);
	maps\mp\_utility::registerroundswitchdvar("koth",1,0,9);
	setdynamicdvar("scr_koth_roundlimit",1);
	maps\mp\_utility::registerroundlimitdvar("koth",1);
	setdynamicdvar("scr_koth_winlimit",1);
	maps\mp\_utility::registerwinlimitdvar("koth",1);
	setdynamicdvar("scr_koth_halftime",0);
	maps\mp\_utility::registerhalftimedvar("koth",0);
	setdynamicdvar("koth_kothmode",0);
	setdynamicdvar("koth_capturetime",20);
	setdynamicdvar("koth_destroytime",10);
	setdynamicdvar("koth_delayPlayer",0);
	setdynamicdvar("koth_spawnDelay",60);
	setdynamicdvar("koth_extraDelay",0);
	setdynamicdvar("koth_proMode",0);
	setdynamicdvar("scr_koth_promode",0);
}

//Function Number: 3
func_3994(param_00,param_01)
{
	game["strings"]["objective_hint_allies"] = param_00;
	game["strings"]["objective_hint_axis"] = param_01;
	for(var_02 = 0;var_02 < level.players.size;var_02++)
	{
		var_03 = level.players[var_02];
		if(isdefined(var_03.pers["team"]) && var_03.pers["team"] != "spectator")
		{
			var_04 = maps\mp\_utility::getobjectivehinttext(var_03.pers["team"]);
			var_03 thread maps\mp\gametypes\_hud_message::hintmessage(var_04);
		}
	}
}

//Function Number: 4
func_3995()
{
	maps\mp\_utility::clearlowermessage("hq_respawn");
	if(!isdefined(level.radioobject))
	{
		return undefined;
	}

	var_00 = level.radioobject maps\mp\gametypes\_gameobjects::getownerteam();
	if(self.pers["team"] == var_00)
	{
		if(!isdefined(level.hqdestroytime))
		{
			return undefined;
		}

		if(!level.spawndelay)
		{
			return undefined;
		}

		var_01 = level.hqdestroytime - gettime() / 1000;
		var_01 = var_01 + level.extradelay + 1;
		if(level.spawndelay >= level.hqautodestroytime)
		{
			maps\mp\_utility::setlowermessage("hq_respawn",&"MP_WAITING_FOR_HQ",undefined,10);
		}

		if(!isalive(self))
		{
			self.forcespawnnearteammates = 1;
		}

		if(level.delayplayer)
		{
			return min(level.spawndelay,var_01);
		}

		return int(var_01) % level.spawndelay;
	}
}

//Function Number: 5
onstartgametype()
{
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

	level.objectivehintpreparehq = &"MP_CONTROL_HQ";
	level.objectivehintcapturehq = &"MP_CAPTURE_HQ";
	level.objectivehintdestroyhq = &"MP_DESTROY_HQ";
	level.objectivehintdefendhq = &"MP_DEFEND_HQ";
	precachestring(level.objectivehintpreparehq);
	precachestring(level.objectivehintcapturehq);
	precachestring(level.objectivehintdestroyhq);
	precachestring(level.objectivehintdefendhq);
	if(level.kothmode)
	{
		level.objectivehintdestroyhq = level.objectivehintcapturehq;
	}

	if(level.hqspawntime)
	{
		func_3994(level.objectivehintpreparehq,level.objectivehintpreparehq);
	}
	else
	{
		func_3994(level.objectivehintcapturehq,level.objectivehintcapturehq);
	}

	setclientnamemode("auto_change");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies","mp_tdm_spawn");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis","mp_tdm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	level.spawn_all = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_tdm_spawn");
	if(!level.spawn_all.size)
	{
		maps\mp\gametypes\_callbacksetup::abortlevel();
		return;
	}

	var_00[0] = "hq";
	maps\mp\gametypes\_gameobjects::main(var_00);
	thread func_39AA();
	maps\mp\gametypes\_rank::registerscoreinfo("kill",50);
	maps\mp\gametypes\_rank::registerscoreinfo("headshot",50);
	maps\mp\gametypes\_rank::registerscoreinfo("assist",10);
	maps\mp\gametypes\_rank::registerscoreinfo("defend",10);
	maps\mp\gametypes\_rank::registerscoreinfo("assault",10);
	maps\mp\gametypes\_rank::registerscoreinfo("capture",250);
	thread func_399C();
}

//Function Number: 6
func_399C()
{
	level endon("game_ended");
	level.hqrevealtime = -100000;
	var_00 = &"MP_HQ_AVAILABLE_IN";
	if(level.kothmode)
	{
		var_01 = &"MP_HQ_DESPAWN_IN";
		var_02 = &"MP_HQ_DESPAWN_IN";
	}
	else if(!level.splitscreen)
	{
		var_01 = &"MP_HQ_REINFORCEMENTS_IN";
		var_02 = &"MP_HQ_DESPAWN_IN";
	}
	else
	{
		var_01 = &"MP_HQ_REINFORCEMENTS_IN_SPLITSCREEN";
		var_02 = &"MP_HQ_DESPAWN_IN";
	}

	precachestring(var_00);
	precachestring(var_01);
	precachestring(var_02);
	precachestring(&"MP_CAPTURING_HQ");
	precachestring(&"MP_DESTROYING_HQ");
	maps\mp\_utility::gameflagwait("prematch_done");
	wait 5;
	var_03 = [];
	var_7B["allies"] maps\mp\gametypes\_hud_util::setpoint("TOP LEFT","TOP LEFT",125,2);
	var_7B["allies"].label = var_01;
	var_7B["allies"].alpha = 0;
	var_7B["allies"].archived = 0;
	var_7B["allies"].hidewheninmenu = 1;
	var_7B["axis"] maps\mp\gametypes\_hud_util::setpoint("TOP LEFT","TOP LEFT",125,2);
	var_7B["axis"].label = var_01;
	var_7B["axis"].alpha = 0;
	var_7B["axis"].archived = 0;
	var_7B["axis"].hidewheninmenu = 1;
	level.timerdisplay = var_7B;
	thread func_39A2(var_7B["allies"]);
	thread func_39A2(var_7B["axis"]);
	var_04 = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(var_04,"invisible",(0,0,0));
	for(;;)
	{
		var_05 = func_39B3();
		var_05 func_39AF();
		maps\mp\_utility::playsoundonplayers("mp_suitcase_pickup");
		maps\mp\_utility::leaderdialog("hq_located");
		var_06 = var_05.gameobject;
		level.radioobject = var_06;
		var_06 maps\mp\gametypes\_gameobjects::setmodelvisibility(1);
		level.hqrevealtime = gettime();
		if(level.hqspawntime)
		{
			var_07 = maps\mp\gametypes\_objpoints::createteamobjpoint("objpoint_next_hq",var_05.origin + level.iconoffset,"all","waypoint_targetneutral");
			var_07 setwaypoint(1,1);
			objective_position(var_04,var_05.trigorigin);
			objective_icon(var_04,"waypoint_targetneutral");
			objective_state(var_04,"active");
			func_3994(level.objectivehintpreparehq,level.objectivehintpreparehq);
			var_7B["allies"].label = var_01;
			var_7B["allies"] settimer(level.hqspawntime);
			var_7B["allies"].alpha = 1;
			var_7B["axis"].label = var_01;
			var_7B["axis"] settimer(level.hqspawntime);
			var_7B["axis"].alpha = 1;
			wait level.hqspawntime;
			maps\mp\gametypes\_objpoints::deleteobjpoint(var_07);
			objective_state(var_04,"invisible");
			maps\mp\_utility::leaderdialog("hq_online");
		}

		var_7B["allies"].alpha = 0;
		var_7B["axis"].alpha = 0;
		waittillframeend;
		maps\mp\_utility::leaderdialog("obj_capture");
		func_3994(level.objectivehintcapturehq,level.objectivehintcapturehq);
		maps\mp\_utility::playsoundonplayers("mp_killstreak_radar");
		var_06 maps\mp\gametypes\_gameobjects::allowuse("any");
		var_06 maps\mp\gametypes\_gameobjects::setusetime(level.capturetime);
		var_06 maps\mp\gametypes\_gameobjects::setusetext(&"MP_CAPTURING_HQ");
		var_06 maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_captureneutral");
		var_06 maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_captureneutral");
		var_06 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
		var_06.onuse = ::func_39A4;
		var_06.onbeginuse = ::onbeginuse;
		var_06.onenduse = ::onenduse;
		level waittill(maps\mp\gametypes\_hud_util::createservertimer("objective",1.4,"allies"),var_7B["allies"],maps\mp\gametypes\_hud_util::createservertimer("objective",1.4,"axis"),var_7B["axis"],"hq_captured");
		var_08 = var_06 maps\mp\gametypes\_gameobjects::getownerteam();
		var_09 = maps\mp\_utility::getotherteam(var_08);
		if(level.hqautodestroytime)
		{
			thread func_39A6(level.hqautodestroytime);
			var_7B[var_08] settimer(level.hqautodestroytime + level.extradelay);
			var_7B[var_09] settimer(level.hqautodestroytime);
		}
		else
		{
			level.hqdestroyedbytimer = 0;
		}

		for(;;)
		{
			var_08 = var_06 maps\mp\gametypes\_gameobjects::getownerteam();
			var_09 = maps\mp\_utility::getotherteam(var_08);
			if(var_08 == "allies")
			{
				func_3994(level.objectivehintdefendhq,level.objectivehintdestroyhq);
			}
			else
			{
				func_3994(level.objectivehintdestroyhq,level.objectivehintdefendhq);
			}

			var_06 maps\mp\gametypes\_gameobjects::allowuse("enemy");
			var_06 maps\mp\gametypes\_gameobjects::set2dicon("friendly","waypoint_defend");
			var_06 maps\mp\gametypes\_gameobjects::set3dicon("friendly","waypoint_defend");
			var_06 maps\mp\gametypes\_gameobjects::set2dicon("enemy","waypoint_capture");
			var_06 maps\mp\gametypes\_gameobjects::set3dicon("enemy","waypoint_capture");
			if(!level.kothmode)
			{
				var_06 maps\mp\gametypes\_gameobjects::setusetext(&"MP_DESTROYING_HQ");
			}

			var_06.onuse = ::func_39A5;
			if(level.hqautodestroytime)
			{
				var_7B[var_08].label = var_02;
				var_7B[var_08].alpha = 1;
				var_7B[var_09].label = var_03;
				var_7B[var_09].alpha = 1;
			}

			level waittill("hq_destroyed");
			var_7B[var_09].alpha = 0;
			if(!level.kothmode || level.hqdestroyedbytimer)
			{
				break;
			}

			thread func_39A3(var_08);
			var_06 maps\mp\gametypes\_gameobjects::setownerteam(maps\mp\_utility::getotherteam(var_08));
		}

		level notify("hq_reset");
		var_06 maps\mp\gametypes\_gameobjects::allowuse("none");
		var_06 maps\mp\gametypes\_gameobjects::setownerteam("neutral");
		var_06 maps\mp\gametypes\_gameobjects::setmodelvisibility(0);
		var_05 func_39B0();
		level.radioobject = undefined;
		thread func_39A3(var_08,level.extradelay);
		wait level.extradelay;
		wait max(1,6 - level.extradelay);
	}
}

//Function Number: 7
func_39A2(param_00)
{
	level waittill("game_ended");
	param_00.alpha = 0;
}

//Function Number: 8
func_39A3(param_00,param_01)
{
	if(param_01)
	{
		foreach(var_03 in level.players)
		{
			if(isalive(var_03))
			{
				continue;
			}

			if(var_03.pers["team"] == param_00)
			{
				var_03 maps\mp\_utility::setlowermessage("hq_respawn",game["strings"]["waiting_to_spawn"]);
			}
		}

		wait param_01;
	}

	level.timerdisplay[param_00].alpha = 0;
	foreach(var_03 in level.players)
	{
		if(var_03.pers["team"] == param_00)
		{
			var_03 maps\mp\_utility::clearlowermessage("hq_respawn");
			if(!isalive(var_03))
			{
				var_03.forcespawnnearteammates = 1;
			}

			var_03 notify("force_spawn");
		}
	}
}

//Function Number: 9
onbeginuse(param_00)
{
	var_01 = maps\mp\gametypes\_gameobjects::getownerteam();
	if(var_01 == "neutral")
	{
		self.objpoints[param_00.pers["team"]] thread maps\mp\gametypes\_objpoints::startflashing();
		return;
	}

	self.objpoints["allies"] thread maps\mp\gametypes\_objpoints::startflashing();
	self.objpoints["axis"] thread maps\mp\gametypes\_objpoints::startflashing();
}

//Function Number: 10
onenduse(param_00,param_01,param_02)
{
	self.objpoints["allies"] thread maps\mp\gametypes\_objpoints::stopflashing();
	self.objpoints["axis"] thread maps\mp\gametypes\_objpoints::stopflashing();
}

//Function Number: 11
func_39A4(param_00)
{
	var_01 = param_00.pers["team"];
	param_00 thread [[ level.onxpevent ]]("capture");
	lib_036E::func_2B7B("capture",param_00);
	foreach(var_03 in self.touchlist[var_01])
	{
		var_04 = var_03.player;
		var_04 maps\mp\_utility::incplayerstat("hqscaptured",1);
		var_04 maps\mp\_utility::incpersstat("captures",1);
		var_04 maps\mp\gametypes\_persistance::statsetchild("round","captures",param_00.pers["captures"]);
	}

	param_00 thread maps\mp\_matchdata::loggameevent("capture",param_00.origin);
	var_06 = maps\mp\gametypes\_gameobjects::getownerteam();
	maps\mp\gametypes\_gameobjects::setownerteam(var_01);
	if(!level.kothmode)
	{
		maps\mp\gametypes\_gameobjects::setusetime(level.destroytime);
	}

	var_07 = "axis";
	if(var_01 == "axis")
	{
		var_07 = "allies";
	}

	maps\mp\_utility::teamplayercardsplash("callout_capturedhq",param_00);
	maps\mp\_utility::leaderdialog("hq_secured",var_01);
	maps\mp\_utility::leaderdialog("hq_enemy_captured",var_07);
	thread maps\mp\_utility::playsoundonplayers("mp_war_objective_taken",var_01);
	thread maps\mp\_utility::playsoundonplayers("mp_war_objective_lost",var_07);
	level thread func_39A7(var_01);
	param_00 notify("objective","captured");
	level notify("hq_captured");
}

//Function Number: 12
func_39A5(param_00)
{
	var_01 = param_00.pers["team"];
	var_02 = "axis";
	if(var_01 == "axis")
	{
		var_02 = "allies";
	}

	param_00 thread [[ level.onxpevent ]]("capture");
	lib_036E::func_2B7B("capture",param_00);
	foreach(var_04 in self.touchlist[var_01])
	{
		var_05 = var_04.player;
		var_05 maps\mp\_utility::incplayerstat("hqsdestroyed",1);
		var_05 maps\mp\_utility::incpersstat("destructions",1);
		var_05 maps\mp\gametypes\_persistance::statsetchild("round","destructions",param_00.pers["destructions"]);
	}

	param_00 thread maps\mp\_matchdata::loggameevent("destroy",param_00.origin);
	if(level.kothmode)
	{
		maps\mp\_utility::teamplayercardsplash("callout_capturedhq",param_00);
		maps\mp\_utility::leaderdialog("hq_secured",var_01);
		maps\mp\_utility::leaderdialog("hq_enemy_captured",var_02);
	}
	else
	{
		maps\mp\_utility::teamplayercardsplash("callout_destroyedhq",param_00);
		maps\mp\_utility::leaderdialog("hq_secured",var_01);
		maps\mp\_utility::leaderdialog("hq_enemy_destroyed",var_02);
	}

	thread maps\mp\_utility::playsoundonplayers("mp_war_objective_taken",var_01);
	thread maps\mp\_utility::playsoundonplayers("mp_war_objective_lost",var_02);
	level notify("hq_destroyed");
	if(level.kothmode)
	{
		level thread func_39A7(var_01);
	}
}

//Function Number: 13
func_39A6(param_00)
{
	level endon("game_ended");
	level endon("hq_reset");
	level.hqdestroytime = gettime() + param_00 * 1000;
	level.hqdestroyedbytimer = 0;
	wait param_00;
	level.hqdestroyedbytimer = 1;
	maps\mp\_utility::leaderdialog("hq_offline");
	level notify("hq_destroyed");
}

//Function Number: 14
func_39A7(param_00)
{
	level endon("game_ended");
	level endon("hq_destroyed");
	level notify("awardHQPointsRunning");
	level endon("awardHQPointsRunning");
	var_01 = 12;
	var_02 = 5;
	var_03 = 5;
	var_04 = 10;
	if(level.promode)
	{
		var_05 = int(level.hqautodestroytime / var_01);
	}
	else
	{
		var_05 = 5;
	}

	var_06 = 0;
	while(!level.gameended)
	{
		if(level.promode && level.hqautodestroytime)
		{
			lib_036E::func_2B88(param_00,int(var_04 * var_06 + 1));
		}
		else
		{
			lib_036E::func_2B88(param_00,var_04);
		}

		for(var_07 = 0;var_07 < level.players.size;var_07++)
		{
			var_08 = level.players[var_07];
			if(var_08.pers["team"] == param_00)
			{
				if(level.promode)
				{
					if(level.hqautodestroytime)
					{
						var_08 thread maps\mp\gametypes\_rank::giverankxp("defend",int(var_02 + var_03 * var_06));
					}
					else
					{
						var_08 thread maps\mp\gametypes\_rank::giverankxp("defend",int(var_02 + var_03));
					}
				}
				else
				{
					var_08 thread maps\mp\gametypes\_rank::giverankxp("defend");
				}

				if(isalive(var_08))
				{
					lib_036E::func_2B7B("defend",var_08);
				}
			}
		}

		var_06++;
		wait var_05;
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	}
}

//Function Number: 15
getspawnpoint()
{
	var_00 = undefined;
	if(isdefined(level.radioobject))
	{
		var_01 = level.radioobject maps\mp\gametypes\_gameobjects::getownerteam();
		if(self.pers["team"] == var_01)
		{
			var_00 = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(level.spawn_all,level.radioobject.nearspawns);
		}
		else
		{
			var_00 = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(level.spawn_all,level.radioobject.outerspawns);
		}
	}

	if(!isdefined(var_00))
	{
		var_00 = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(level.spawn_all);
	}

	return var_00;
}

//Function Number: 16
onspawnplayer()
{
	maps\mp\_utility::clearlowermessage("hq_respawn");
	self.forcespawnnearteammates = undefined;
}

//Function Number: 17
func_39AA()
{
	var_00 = [];
	var_01 = getentarray("hq_hardpoint","targetname");
	if(var_01.size < 2)
	{
		var_00[var_00.size] = "There are not at least 2 entities with targetname \"radio\";
	}

	var_02 = getentarray("radiotrigger","targetname");
	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		var_04 = 0;
		var_05 = var_01[var_03];
		var_05.trig = undefined;
		for(var_06 = 0;var_06 < var_02.size;var_06++)
		{
			if(var_05 istouching(var_02[var_06]))
			{
				if(isdefined(var_05.trig))
				{
					var_00[var_00.size] = "Radio at " + var_05.origin + " is touching more than one \"radiotrigger\" trigger";
					var_04 = 1;
					break;
				}

				var_05.trig = var_02[var_06];
				break;
			}
		}

		if(!isdefined(var_05.trig))
		{
			if(!var_04)
			{
				var_00[var_00.size] = "Radio at " + var_05.origin + " is not inside any \"radiotrigger\" trigger";
				continue;
			}
		}

		var_05.trigorigin = var_05.trig.origin;
		var_07 = [];
		var_07[0] = var_05;
		var_08 = getentarray(var_05.target,"targetname");
		for(var_06 = 0;var_06 < var_08.size;var_06++)
		{
			var_07[var_07.size] = var_08[var_06];
		}

		var_05.visuals = var_07;
		var_05 maps\mp\gametypes\_gameobjects::setmodelvisibility(0);
	}

	if(var_00.size > 0)
	{
		for(var_03 = 0;var_03 < var_00.size;var_03++)
		{
		}

		common_scripts\utility::error("Map errors. See above");
		maps\mp\gametypes\_callbacksetup::abortlevel();
		return;
	}

	level.radios = var_01;
	level.prevradio = undefined;
	level.prevradio2 = undefined;
	return 1;
}

//Function Number: 18
func_39AF()
{
	self.gameobject = maps\mp\gametypes\_gameobjects::createuseobject("neutral",self.trig,self.visuals,self.origin - self.trigorigin + level.iconoffset);
	self.gameobject maps\mp\gametypes\_gameobjects::setmodelvisibility(0);
	self.trig.useobj = self.gameobject;
	func_39B1();
}

//Function Number: 19
func_39B0()
{
	self.gameobject maps\mp\gametypes\_gameobjects::deleteuseobject();
	self.gameobject = undefined;
}

//Function Number: 20
func_39B1()
{
	var_00 = level.spawn_all;
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
	var_06 = var_00.size / 3;
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(var_01 <= var_06 || var_00[var_01].distsq <= 490000)
		{
			var_04[var_04.size] = var_00[var_01];
		}

		if(var_01 > var_06 || var_00[var_01].distsq > 1000000)
		{
			if(var_05.size < 10 || var_00[var_01].distsq < 2250000)
			{
				var_05[var_05.size] = var_00[var_01];
			}
		}
	}

	self.gameobject.nearspawns = var_04;
	self.gameobject.outerspawns = var_05;
}

//Function Number: 21
func_39B3()
{
	var_00 = [];
	var_01 = [];
	foreach(var_03 in level.players)
	{
		if(var_03.team == "spectator")
		{
			continue;
		}

		if(!isalive(var_03))
		{
			continue;
		}

		var_03.dist = 0;
		if(var_03.team == "allies")
		{
			var_00[var_00.size] = var_03;
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	if(!var_00.size || !var_01.size)
	{
		var_05 = level.radios[randomint(level.radios.size)];
		while(isdefined(level.prevradio) && var_05 == level.prevradio)
		{
			var_05 = level.radios[randomint(level.radios.size)];
		}

		level.prevradio2 = level.prevradio;
		level.prevradio = var_05;
		return var_05;
	}

	for(var_06 = 0;var_06 < var_01.size;var_06++)
	{
		for(var_07 = var_06 + 1;var_07 < var_01.size;var_07++)
		{
			var_08 = distancesquared(var_01[var_06].origin,var_01[var_07].origin);
			var_01[var_06].dist = var_01[var_06].dist + var_08;
			var_01[var_07].dist = var_01[var_07].dist + var_08;
		}
	}

	for(var_06 = 0;var_06 < var_02.size;var_06++)
	{
		for(var_07 = var_06 + 1;var_07 < var_02.size;var_07++)
		{
			var_08 = distancesquared(var_02[var_06].origin,var_02[var_07].origin);
			var_02[var_06].dist = var_02[var_06].dist + var_08;
			var_02[var_07].dist = var_02[var_07].dist + var_08;
		}
	}

	var_09 = var_01[0];
	foreach(var_04 in var_01)
	{
		if(var_04.dist < var_09.dist)
		{
			var_09 = var_04;
		}
	}

	var_0C["allies"] = var_09.origin;
	var_09 = var_02[0];
	foreach(var_04 in var_02)
	{
		if(var_04.dist < var_09.dist)
		{
			var_09 = var_04;
		}
	}

	var_0C["axis"] = var_02[0].origin;
	var_0F = undefined;
	var_10 = undefined;
	var_06 = 0;
	while(var_05 < level.radios.size)
	{
		var_10 = level.radios[var_05];
		var_11 = abs(distance(var_10.origin,var_0B["allies"]) - distance(var_10.origin,var_0B["axis"]));
		if(isdefined(level.prevradio) && var_10 == level.prevradio)
		{
			continue;
		}

		if(isdefined(level.prevradio2) && var_10 == level.prevradio2)
		{
			if(level.radios.size > 2)
			{
				continue;
			}
			else
			{
				var_11 = var_11 + 512;
			}
		}

		if(!isdefined(var_0F) || var_11 < var_0F)
		{
			var_0F = var_11;
			var_0E = var_10;
		}

		var_05++;
	}

	level.prevradio2 = level.prevradio;
	level.prevradio = var_0E;
	return var_0E;
}

//Function Number: 22
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isplayer(param_01) || !self.touchtriggers.size && !param_01.touchtriggers.size || param_01.pers["team"] == self.pers["team"])
	{
		return;
	}

	if(self.touchtriggers.size)
	{
		foreach(var_0B in self.touchtriggers)
		{
			if(!isdefined(var_0B.useobj))
			{
				continue;
			}

			var_0C = var_0B.useobj.ownerteam;
			var_0D = self.pers["team"];
			if(var_0C == "neutral")
			{
				continue;
			}

			var_0D = self.pers["team"];
			if(var_0D == var_0C)
			{
				param_01 thread [[ level.onxpevent ]]("assault");
				lib_036E::func_2B7B("assault",param_01);
				thread maps\mp\_matchdata::logkillevent(param_09,"defending");
				continue;
			}

			param_01 thread [[ level.onxpevent ]]("defend");
			lib_036E::func_2B7B("defend",param_01);
			param_01 maps\mp\_utility::incpersstat("defends",1);
			param_01 maps\mp\gametypes\_persistance::statsetchild("round","defends",param_01.pers["defends"]);
			thread maps\mp\_matchdata::logkillevent(param_09,"assaulting");
		}
	}

	if(param_01.touchtriggers.size)
	{
		foreach(var_0B in param_01.touchtriggers)
		{
			if(!isdefined(var_0B.useobj))
			{
				continue;
			}

			var_0C = var_0B.useobj.ownerteam;
			var_0D = param_01.pers["team"];
			if(var_0C == "neutral")
			{
				var_0D = param_01.pers["team"];
			}

			if(var_0D == var_0C)
			{
				param_01 thread [[ level.onxpevent ]]("defend");
				lib_036E::func_2B7B("defend",param_01);
				thread maps\mp\_matchdata::logkillevent(param_09,"assaulting");
				continue;
			}

			param_01 thread [[ level.onxpevent ]]("assault");
			lib_036E::func_2B7B("assault",param_01);
			thread maps\mp\_matchdata::logkillevent(param_09,"defending");
		}
	}
}

//Function Number: 23
initgametypeawards()
{
	maps\mp\_awards::initstataward("hqsdestroyed",0,::maps\mp\_awards::highestwins);
	maps\mp\_awards::initstataward("hqscaptured",0,::maps\mp\_awards::highestwins);
}