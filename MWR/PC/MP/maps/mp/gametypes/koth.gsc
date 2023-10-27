/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\koth.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 31
 * Decompile Time: 668 ms
 * Timestamp: 10/27/2023 2:38:19 AM
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
	level.classicgamemode = 1;
	level.doprematch = 1;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onspawnplayer = ::onspawnplayer;
	level.onplayerkilled = ::onplayerkilled;
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	level.hqautodestroytime = getdvarint("scr_koth_autodestroytime",60);
	level.hqspawntime = getdvarint("scr_koth_spawntime",0);
	level.capturetime = getdvarint("scr_koth_captureTime",20);
	level.destroytime = getdvarint("scr_koth_destroyTime",10);
	level.delayplayer = getdvarint("scr_koth_delayPlayer",0);
	level.spawndelay = level.hqautodestroytime;
	level.hqclassicmode = getdvarint("scr_koth_classicMode",1);
	level.captureinsteadofdestroy = !level.hqclassicmode;
	level.iconoffset = (0,0,32);
	level.timerdisplay = [];
	level.onrespawndelay = ::getrespawndelay;
	game["dialog"]["gametype"] = "headquarters";
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::setcommonrulesfrommatchrulesdata();
	setdynamicdvar("scr_koth_autodestroytime",getmatchrulesdata("hqData","HQLifetime"));
	setdynamicdvar("scr_koth_spawntime",getmatchrulesdata("hqData","HQActivateDelay"));
	setdynamicdvar("scr_koth_classicMode",getmatchrulesdata("hqData","HQClassicMode"));
	setdynamicdvar("scr_koth_roundswitch",1);
	maps\mp\_utility::registerroundswitchdvar("koth",1,0,9);
	setdynamicdvar("scr_koth_roundlimit",1);
	maps\mp\_utility::registerroundlimitdvar("koth",1);
	setdynamicdvar("scr_koth_winlimit",1);
	maps\mp\_utility::registerwinlimitdvar("koth",1);
	setdynamicdvar("scr_koth_halftime",0);
	maps\mp\_utility::registerhalftimedvar("koth",0);
	setdynamicdvar("scr_koth_capturetime",20);
	setdynamicdvar("scr_koth_destroytime",10);
	setdynamicdvar("scr_koth_delayPlayer",0);
	setdynamicdvar("scr_koth_spawnDelay",60);
}

//Function Number: 3
updateobjectivehintmessages(param_00,param_01)
{
	game["strings"]["objective_hint_allies"] = level.objectivehint[param_00].str;
	game["strings"]["objective_hint_axis"] = level.objectivehint[param_01].str;
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
getrespawndelay()
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

		if(level.spawndelay == 0)
		{
			return undefined;
		}

		var_01 = level.hqdestroytime - gettime() / 1000;
		var_01 = var_01 + 1;
		if(level.spawndelay >= level.hqautodestroytime)
		{
			if(level.hqclassicmode)
			{
				maps\mp\_utility::setlowermessage("hq_respawn",&"MP_WAITING_FOR_HQ",undefined,10);
			}
			else
			{
				maps\mp\_utility::setlowermessage("hq_respawn",&"MP_WAITING_FOR_HQ_CAPTURE",undefined,10);
			}

			self setclientomnvar("ui_hide_spawn_timer",1);
		}

		if(!isalive(self))
		{
			self.forcespawnnearteammates = 1;
		}

		if(level.delayplayer)
		{
			return min(level.spawndelay,var_01);
		}

		self.respawntimerstarttime = undefined;
		return int(var_01) % level.spawndelay;
	}
}

//Function Number: 5
hintstruct(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.str = param_00;
	var_02.index = param_01;
	return var_02;
}

//Function Number: 6
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

	level.objectivehint["prepare"] = hintstruct(&"MP_CONTROL_HQ",0);
	level.objectivehint["capture"] = hintstruct(&"MP_CAPTURE_HQ",1);
	level.objectivehint["destroy"] = hintstruct(&"MP_DESTROY_HQ",2);
	level.objectivehint["defend"] = hintstruct(&"MP_DEFEND_HQ",3);
	if(!level.hqclassicmode)
	{
		level.objectivehint["destroy"] = level.objectivehint["capture"];
	}

	if(level.hqspawntime)
	{
		updateobjectivehintmessages("prepare","prepare");
	}
	else
	{
		updateobjectivehintmessages("capture","capture");
	}

	setclientnamemode("auto_change");
	initspawns();
	var_00[0] = "hq";
	maps\mp\gametypes\_gameobjects::main(var_00);
	thread setupradios();
	thread hqmainloop();
	thread maps\mp\gametypes\_spectating::allowallyteamspectating();
}

//Function Number: 7
initspawns()
{
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
	}
}

//Function Number: 8
timerdisplayshow(param_00,param_01,param_02)
{
	if(isdefined(param_01))
	{
		level.timerdisplay["allies"] = param_01;
	}

	if(isdefined(param_02))
	{
		level.timerdisplay["axis"] = param_02;
	}

	if(isdefined(param_00))
	{
		setomnvar("ui_bomb_timer_endtime",param_00);
	}

	foreach(var_04 in level.players)
	{
		var_04 timerdisplaytoplayer();
	}
}

//Function Number: 9
timerdisplayhide()
{
	level.timerdisplay["allies"] = undefined;
	level.timerdisplay["axis"] = undefined;
	setomnvar("ui_bomb_timer_endtime",0);
	foreach(var_01 in level.players)
	{
		var_01 timerdisplaytoplayer();
	}
}

//Function Number: 10
timerdisplaytoplayer()
{
	var_00 = level.timerdisplay[self.team];
	if(!isdefined(var_00))
	{
		var_00 = "none";
	}

	var_01["none"] = 0;
	var_01["spawning"] = 1;
	var_01["despawning"] = 2;
	var_01["reinforcements"] = 3;
	var_02 = var_01[var_00];
	self setclientomnvar("ui_hud_message_index",var_02);
}

//Function Number: 11
hqmainloop()
{
	level endon("game_ended");
	level.hqrevealtime = -100000;
	maps\mp\_utility::gameflagwait("prematch_done");
	wait(5);
	thread hidetimerdisplayongameend();
	var_00 = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(var_00,"invisible",(0,0,0));
	for(;;)
	{
		var_01 = pickradiotospawn();
		var_01 makeradioactive();
		maps\mp\_utility::playsoundonplayers("mp_suitcase_pickup");
		maps\mp\_utility::leaderdialog("hq_located");
		var_02 = var_01.gameobject;
		level.radioobject = var_02;
		var_02 makeradiovisible();
		var_01.visible = 1;
		level.hqrevealtime = gettime();
		if(level.hqspawntime)
		{
			var_03 = maps\mp\gametypes\_objpoints::createteamobjpoint("objpoint_next_hq",var_01.origin + level.iconoffset,"all","waypoint_targetneutral");
			var_03 setwaypoint(1,1);
			objective_position(var_00,var_01.trigorigin);
			objective_icon(var_00,"waypoint_targetneutral");
			objective_state(var_00,"active");
			updateobjectivehintmessages("prepare","prepare");
			timerdisplayshow(gettime() + 1000 * level.hqspawntime,"spawning","spawning");
			wait(level.hqspawntime);
			maps\mp\gametypes\_objpoints::deleteobjpoint(var_03);
			objective_state(var_00,"invisible");
		}

		timerdisplayhide();
		waittillframeend;
		maps\mp\_utility::leaderdialog("hq_online");
		updateobjectivehintmessages("capture","capture");
		maps\mp\_utility::playsoundonplayers("mp_killstreak_radar");
		var_02 maps\mp\gametypes\_gameobjects::allowuse("any");
		var_02 maps\mp\gametypes\_gameobjects::setusetime(level.capturetime);
		var_02 maps\mp\gametypes\_gameobjects::setusetext(&"MP_CAPTURING_HQ");
		var_02 updateicons();
		var_02 maps\mp\gametypes\_gameobjects::setvisibleteam("any");
		var_02.onuse = ::onradiocapture;
		var_02.onbeginuse = ::onbeginuse;
		var_02.onenduse = ::onenduse;
		var_02.onnumtouchingchanged = ::onnumtouchingchanged;
		var_02.nousebar = 1;
		var_02.contesteduiprogress = 1;
		var_02.id = "kothZone";
		level waittill("hq_captured");
		var_04 = var_02 maps\mp\gametypes\_gameobjects::getownerteam();
		var_05 = maps\mp\_utility::getotherteam(var_04);
		if(level.hqautodestroytime)
		{
			thread destroyhqaftertime(level.hqautodestroytime);
		}
		else
		{
			level.hqdestroyedbytimer = 0;
		}

		for(;;)
		{
			var_04 = var_02 maps\mp\gametypes\_gameobjects::getownerteam();
			var_05 = maps\mp\_utility::getotherteam(var_04);
			if(var_04 == "allies")
			{
				updateobjectivehintmessages("defend","destroy");
			}
			else
			{
				updateobjectivehintmessages("destroy","defend");
			}

			var_02 maps\mp\gametypes\_gameobjects::allowuse("enemy");
			var_02 updateicons();
			if(level.hqclassicmode)
			{
				var_02 maps\mp\gametypes\_gameobjects::setusetext(&"MP_DESTROYING_HQ");
			}

			var_02.onuse = ::onradiodestroy;
			if(level.hqautodestroytime)
			{
				var_06 = "despawning";
				if(level.hqclassicmode)
				{
					var_06 = "reinforcements";
				}

				var_07 = "despawning";
				if(var_04 == "allies")
				{
					timerdisplayshow(level.hqdestroytime,var_06,var_07);
				}
				else
				{
					timerdisplayshow(level.hqdestroytime,var_07,var_06);
				}
			}

			level waittill("hq_destroyed");
			timerdisplayhide();
			if(level.hqclassicmode || level.hqdestroyedbytimer)
			{
				break;
			}

			thread forcespawnteam(var_04);
			var_02 maps\mp\gametypes\_gameobjects::setownerteam(maps\mp\_utility::getotherteam(var_04));
		}

		level notify("hq_reset");
		var_02 maps\mp\gametypes\_gameobjects::allowuse("none");
		var_02 maps\mp\gametypes\_gameobjects::setownerteam("neutral");
		var_02 makeradioinvisible();
		var_01.visible = 0;
		var_01 makeradioinactive();
		level.radioobject = undefined;
		thread forcespawnteam(var_04);
		wait(6);
	}
}

//Function Number: 12
updateicons()
{
	if(!isdefined(self.trigger))
	{
		return;
	}

	var_00 = "waypoint_captureneutral";
	var_01 = "waypoint_captureneutral";
	var_02 = "waypoint_captureneutral";
	if(self.numtouching["axis"] && self.numtouching["allies"])
	{
		var_00 = "waypoint_contested";
		var_01 = "waypoint_contested";
		var_02 = "waypoint_contested";
	}
	else if(self.ownerteam == "neutral")
	{
		if(self.numtouching["axis"] || self.numtouching["allies"])
		{
			var_00 = "waypoint_losing";
			var_01 = "waypoint_taking";
			if(self.numtouching["allies"])
			{
				var_02 = "waypoint_esports_koth_taking_blue";
			}
			else
			{
				var_02 = "waypoint_esports_koth_taking_red";
			}
		}
		else
		{
			var_00 = "waypoint_captureneutral";
			var_01 = "waypoint_captureneutral";
			var_02 = "waypoint_captureneutral";
		}
	}
	else if(self.numtouching[maps\mp\_utility::getotherteam(self.ownerteam)])
	{
		var_00 = "waypoint_losing";
		var_01 = "waypoint_taking";
		if(self.ownerteam == "allies")
		{
			var_02 = "waypoint_esports_koth_losing_blue";
		}
		else
		{
			var_02 = "waypoint_esports_koth_losing_red";
		}
	}
	else
	{
		var_00 = "waypoint_defend";
		var_01 = "waypoint_capture";
		if(self.ownerteam == "allies")
		{
			var_02 = "waypoint_esports_koth_taken_blue";
		}
		else
		{
			var_02 = "waypoint_esports_koth_taken_red";
		}
	}

	maps\mp\gametypes\_gameobjects::set2dicon("friendly",var_00);
	maps\mp\gametypes\_gameobjects::set3dicon("friendly",var_00);
	maps\mp\gametypes\_gameobjects::set2dicon("enemy",var_01);
	maps\mp\gametypes\_gameobjects::set3dicon("enemy",var_01);
	maps\mp\_utility::setmlgicons(self,var_02);
}

//Function Number: 13
hidetimerdisplayongameend(param_00)
{
	level waittill("game_ended");
	timerdisplayhide();
}

//Function Number: 14
forcespawnteam(param_00)
{
	foreach(var_02 in level.players)
	{
		if(var_02.pers["team"] == param_00)
		{
			var_02 maps\mp\_utility::clearlowermessage("hq_respawn");
			if(!isalive(var_02))
			{
				var_02.forcespawnnearteammates = 1;
			}

			var_02 notify("force_spawn");
		}
	}
}

//Function Number: 15
onbeginuse(param_00)
{
	updateicons();
}

//Function Number: 16
onenduse(param_00,param_01,param_02)
{
	updateicons();
}

//Function Number: 17
onnumtouchingchanged(param_00,param_01,param_02)
{
	updateicons();
}

//Function Number: 18
onradiocapture(param_00)
{
	var_01 = param_00.pers["team"];
	foreach(var_03 in self.touchlist[var_01])
	{
		var_04 = var_03.player;
		var_04 maps\mp\_events::hqcaptureevent();
	}

	var_06 = maps\mp\gametypes\_gameobjects::getownerteam();
	maps\mp\gametypes\_gameobjects::setownerteam(var_01);
	if(level.hqclassicmode)
	{
		maps\mp\gametypes\_gameobjects::setusetime(level.destroytime);
	}

	var_07 = "axis";
	if(var_01 == "axis")
	{
		var_07 = "allies";
	}

	maps\mp\_utility::leaderdialog("hq_secured",var_01);
	maps\mp\_utility::leaderdialog("hq_enemy_captured",var_07);
	thread maps\mp\_utility::playsoundonplayers("h1_mp_war_objective_taken",var_01);
	thread maps\mp\_utility::playsoundonplayers("h1_mp_war_objective_lost",var_07);
	level thread awardhqpoints(var_01);
	param_00 notify("objective","captured");
	level notify("hq_captured");
}

//Function Number: 19
onradiodestroy(param_00)
{
	var_01 = param_00.pers["team"];
	var_02 = "axis";
	if(var_01 == "axis")
	{
		var_02 = "allies";
	}

	foreach(var_04 in self.touchlist[var_01])
	{
		var_05 = var_04.player;
		if(!level.hqclassicmode)
		{
			var_05 maps\mp\_events::hqcaptureevent();
			continue;
		}

		var_05 maps\mp\_events::hqdestroyevent();
	}

	if(!level.hqclassicmode)
	{
		maps\mp\_utility::leaderdialog("hq_secured",var_01);
		maps\mp\_utility::leaderdialog("hq_enemy_captured",var_02);
	}
	else
	{
		maps\mp\_utility::leaderdialog("hq_secured",var_01);
		maps\mp\_utility::leaderdialog("hq_enemy_destroyed",var_02);
	}

	thread maps\mp\_utility::playsoundonplayers("h1_mp_war_objective_taken",var_01);
	thread maps\mp\_utility::playsoundonplayers("h1_mp_war_objective_lost",var_02);
	level notify("hq_destroyed");
	if(!level.hqclassicmode)
	{
		level thread awardhqpoints(var_01);
	}
}

//Function Number: 20
destroyhqaftertime(param_00)
{
	level endon("game_ended");
	level endon("hq_reset");
	level.hqdestroytime = gettime() + param_00 * 1000;
	level.hqdestroyedbytimer = 0;
	wait(param_00);
	level.hqdestroyedbytimer = 1;
	maps\mp\_utility::leaderdialog("hq_offline");
	level notify("hq_destroyed");
}

//Function Number: 21
awardhqpoints(param_00)
{
	level endon("game_ended");
	level endon("hq_destroyed");
	level notify("awardHQPointsRunning");
	level endon("awardHQPointsRunning");
	var_01 = 12;
	var_02 = 5;
	var_03 = 5;
	var_04 = 5;
	var_05 = 5;
	var_06 = 0;
	while(!level.gameended)
	{
		maps\mp\gametypes\_gamescores::giveteamscoreforobjective(param_00,var_04);
		var_06++;
		wait(var_05);
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	}
}

//Function Number: 22
getspawnpoint()
{
	var_00 = undefined;
	if(isdefined(level.radioobject))
	{
		var_01 = level.radioobject maps\mp\gametypes\_gameobjects::getownerteam();
		if(maps\mp\gametypes\_legacyspawnlogic::uselegacyspawning())
		{
			if(self.pers["team"] == var_01)
			{
				var_00 = maps\mp\gametypes\_legacyspawnlogic::getspawnpoint_nearteam(level.spawn_all,level.radioobject.nearspawns);
			}
			else if(level.spawndelay >= level.hqautodestroytime && gettime() > level.hqrevealtime + 10000)
			{
				var_00 = maps\mp\gametypes\_legacyspawnlogic::getspawnpoint_nearteam(level.spawn_all);
			}
			else
			{
				var_00 = maps\mp\gametypes\_legacyspawnlogic::getspawnpoint_nearteam(level.spawn_all,level.radioobject.outerspawns);
			}
		}
		else if(self.pers["team"] == var_01)
		{
			var_02 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(level.radioobject.nearspawns);
			var_03 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(level.spawn_all);
			if(var_02 == var_03)
			{
				var_00 = var_02;
			}
			else
			{
				var_00 = var_03;
			}
		}
		else
		{
			var_02 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(level.radioobject.outerspawns);
			var_03 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(level.spawn_all);
			if(var_02 == var_03)
			{
				var_00 = var_02;
			}
			else
			{
				var_00 = var_03;
			}
		}
	}

	if(!isdefined(var_00))
	{
		var_00 = maps\mp\gametypes\_spawnscoring::getspawnpoint_awayfromenemies(level.spawn_all);
	}

	return var_00;
}

//Function Number: 23
onspawnplayer()
{
	maps\mp\_utility::clearlowermessage("hq_respawn");
	self.forcespawnnearteammates = undefined;
	timerdisplaytoplayer();
	self setclientomnvar("ui_hide_spawn_timer",0);
}

//Function Number: 24
setupradios()
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
		var_05 makeradioinvisible();
		var_05.visible = 0;
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

//Function Number: 25
makeradiovisible()
{
	maps\mp\gametypes\_gameobjects::setmodelvisibility(1);
	for(var_00 = 0;var_00 < self.visuals.size;var_00++)
	{
		if(self.visuals[var_00].classname == "script_brushmodel")
		{
			self.visuals[var_00] disconnectpaths();
		}
	}
}

//Function Number: 26
makeradioinvisible()
{
	maps\mp\gametypes\_gameobjects::setmodelvisibility(0);
	for(var_00 = 0;var_00 < self.visuals.size;var_00++)
	{
		if(self.visuals[var_00].classname == "script_brushmodel")
		{
			self.visuals[var_00] connectpaths();
		}
	}
}

//Function Number: 27
makeradioactive()
{
	self.gameobject = maps\mp\gametypes\_gameobjects::createuseobject("neutral",self.trig,self.visuals,self.origin - self.trigorigin + level.iconoffset);
	self.gameobject makeradioinvisible();
	self.visible = 0;
	self.trig.useobj = self.gameobject;
	setupnearbyspawns();
}

//Function Number: 28
makeradioinactive()
{
	self.gameobject maps\mp\gametypes\_gameobjects::deleteuseobject();
	self.gameobject = undefined;
}

//Function Number: 29
setupnearbyspawns()
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

//Function Number: 30
pickradiotospawn()
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

//Function Number: 31
onplayerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = self;
	if(!isplayer(param_01))
	{
		return;
	}

	if(maps\mp\gametypes\_damage::isfriendlyfire(var_0A,param_01))
	{
		return;
	}

	if(param_01 == var_0A)
	{
		return;
	}

	if(isdefined(param_04) && maps\mp\_utility::iskillstreakweapon(param_04))
	{
		return;
	}

	if(!isdefined(level.radioobject))
	{
		return;
	}

	var_0B = level.radioobject maps\mp\gametypes\_gameobjects::getclaimteam();
	if(param_01 istouching(level.radioobject.trigger))
	{
		if(var_0B == param_01.team && !level.radioobject.stalemate)
		{
			param_01 thread maps\mp\_events::killwhilecapture(var_0A,param_09);
			return;
		}
	}

	var_0C = level.radioobject maps\mp\gametypes\_gameobjects::getownerteam();
	if(var_0A istouching(level.radioobject.trigger))
	{
		if(var_0C == param_01.team)
		{
			param_01 thread maps\mp\_events::defendobjectiveevent(var_0A,param_09);
		}
	}
}