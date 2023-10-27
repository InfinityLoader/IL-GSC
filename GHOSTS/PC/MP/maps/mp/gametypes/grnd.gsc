/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\grnd.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 24
 * Decompile Time: 447 ms
 * Timestamp: 10/27/2023 1:19:37 AM
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
		maps\mp\_utility::func_6475(level.gametype,7500);
		maps\mp\_utility::func_6472(level.gametype,1);
		maps\mp\_utility::func_647C(level.gametype,1);
		maps\mp\_utility::func_6470(level.gametype,0);
		maps\mp\_utility::func_646A(level.gametype,0);
		level.matchrules_droptime = 15;
		level.matchrules_zoneswitchtime = 60;
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
		setdvar("scr_game_hardpoints",0);
	}

	level.teambased = 1;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.var_5976 = ::func_5976;
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	level.grnd_fx["smoke"] = loadfx("smoke/airdrop_flare_mp_effect_now");
	level.grnd_fx["flare"] = loadfx("smoke/signal_smoke_airdrop");
	level.grnd_targetfxid = loadfx("vfx/gameplay/mp/core/vfx_marker_base_cyan");
	level.dangermaxradius["drop_zone"] = 1200;
	level.dangerminradius["drop_zone"] = 1190;
	level.dangerforwardpush["drop_zone"] = 0;
	level.dangerovalscale["drop_zone"] = 1;
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::func_700A();
	level.matchrules_droptime = getmatchrulesdata("grndData","dropTime");
	level.matchrules_zoneswitchtime = 60 * getmatchrulesdata("grndData","zoneSwitchTime");
	if(level.matchrules_zoneswitchtime < 60)
	{
		level.matchrules_zoneswitchtime = 60;
	}

	setdynamicdvar("scr_grnd_roundswitch",0);
	maps\mp\_utility::func_6473("grnd",0,0,9);
	setdynamicdvar("scr_grnd_roundlimit",1);
	maps\mp\_utility::func_6472("grnd",1);
	setdynamicdvar("scr_grnd_winlimit",1);
	maps\mp\_utility::func_647C("grnd",1);
	setdynamicdvar("scr_grnd_halftime",0);
	maps\mp\_utility::func_646A("grnd",0);
	setdynamicdvar("scr_grnd_promode",0);
}

//Function Number: 3
onstartgametype()
{
	setclientnamemode("auto_change");
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	maps\mp\_utility::func_7084("allies",&"OBJECTIVES_GRND");
	maps\mp\_utility::func_7084("axis",&"OBJECTIVES_GRND");
	if(level.splitscreen)
	{
		maps\mp\_utility::func_7083("allies",&"OBJECTIVES_GRND");
		maps\mp\_utility::func_7083("axis",&"OBJECTIVES_GRND");
	}
	else
	{
		maps\mp\_utility::func_7083("allies",&"OBJECTIVES_GRND_SCORE");
		maps\mp\_utility::func_7083("axis",&"OBJECTIVES_GRND_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_DOM_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_DOM_HINT");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_tdm_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::addstartspawnpoints("mp_tdm_spawn_axis_start");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies","mp_tdm_spawn");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis","mp_tdm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	var_00 = getentarray("flag_primary","targetname");
	var_01 = sortbydistance(var_00,level.mapcenter);
	var_02 = var_01[0];
	level.grnd_centerloc = level.mapcenter;
	maps\mp\gametypes\_rank::registerscoreinfo("kill",50);
	maps\mp\gametypes\_rank::registerscoreinfo("zone_kill",100);
	maps\mp\gametypes\_rank::registerscoreinfo("zone_tick",20);
	var_03[0] = level.gametype;
	var_03[1] = "tdm";
	maps\mp\gametypes\_gameobjects::func_4FDD(var_03);
	level.grnd_hud["timerDisplay"] = maps\mp\gametypes\_hud_util::createservertimer("objective",1.4);
	level.grnd_hud["timerDisplay"].label = &"MP_NEXT_DROP_ZONE_IN";
	level.grnd_hud["timerDisplay"] maps\mp\gametypes\_hud_util::func_70A4("BOTTOMCENTER","BOTTOMCENTER",0,-28);
	level.grnd_hud["timerDisplay"].alpha = 0;
	level.grnd_hud["timerDisplay"].archived = 0;
	level.grnd_hud["timerDisplay"].hidewheninmenu = 1;
	level.grnd_hud["timerDisplay"].hidewhenindemo = 1;
	thread hidehudelementongameend(level.grnd_hud["timerDisplay"]);
	createzones();
	initzones();
	initfirstzone();
}

//Function Number: 4
initfirstzone()
{
	level.zonescycling = 0;
	level.firstzoneactive = 0;
	var_00 = 999999;
	var_01 = 0;
	if(tolower(getdvar("mapname")) == "mp_shipment_ns")
	{
		var_02 = (1.6,63,192);
	}
	else
	{
		for(var_03 = 0;var_03 < level.grnd_zones.size;var_03++)
		{
			var_04 = level.grnd_zones[var_03];
			var_05 = distance2d(level.grnd_centerloc,var_04.origin);
			if(var_05 < var_00)
			{
				var_00 = var_05;
				var_01 = var_03;
			}
		}

		level.grnd_initialindex = var_01;
		var_02 = level.grnd_zones[var_01].origin;
	}

	level.grnd_initialpos = var_02;
	level.grnd_zone = spawn("script_model",var_02);
	level.grnd_zone.origin = var_02;
	level.grnd_zone.angles = (90,0,0);
	level.grnd_zone setmodel("weapon_us_smoke_grenade_burnt2");
	var_06 = spawn("script_model",level.grnd_zone.origin);
	var_06 setmodel("tag_origin");
	var_06.angles = vectortoangles((0,0,1));
	var_06 linkto(level.grnd_zone);
	level.grnd_zone.ringvfx = var_06;
	level.grnd_dangercenter = spawnstruct();
	level.grnd_dangercenter.origin = var_02;
	level.grnd_dangercenter.forward = anglestoforward((0,0,0));
	level.grnd_dangercenter.streakname = "drop_zone";
	level.favorclosespawnent = level.grnd_zone;
}

//Function Number: 5
initzones()
{
	level.grnd_zones = [];
	if(getdvar("mapname") == "mp_strikezone")
	{
		if(isdefined(level.teleport_zone_current) && level.teleport_zone_current == "start")
		{
			for(var_00 = 0;var_00 < level.grnd_dropzones1.size;var_00++)
			{
				var_01 = level.grnd_dropzones1[var_00].origin;
				level.grnd_zones[var_00] = spawn("script_origin",var_01);
				level.grnd_zones[var_00].origin = var_01;
				wait(0.05);
			}
		}

		for(var_00 = 0;var_00 < level.grnd_dropzones2.size;var_00++)
		{
			var_01 = level.grnd_dropzones2[var_00].origin;
			level.grnd_zones[var_00] = spawn("script_origin",var_01);
			level.grnd_zones[var_00].origin = var_01;
			wait(0.05);
		}
	}

	for(var_00 = 0;var_00 < level.grnd_dropzones.size;var_00++)
	{
		var_01 = level.grnd_dropzones[var_00].origin;
		level.grnd_zones[var_00] = spawn("script_origin",var_01);
		level.grnd_zones[var_00].origin = var_01;
		wait(0.05);
	}
}

//Function Number: 6
getspawnpoint()
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
		var_01 = maps\mp\gametypes\_spawnlogic::func_3C41(var_02);
		var_03 = sortbydistance(var_02,level.favorclosespawnent.origin);
		var_04 = [];
		for(var_05 = 0;var_05 < var_03.size;var_05++)
		{
			var_04[var_05] = var_03[var_05];
			if(common_scripts\utility::func_27FE(var_04[var_05].origin,level.favorclosespawnent.origin) > 589824 && var_05 > 5)
			{
				break;
			}
		}

		var_02 = maps\mp\gametypes\_spawnscoring::getspawnpoint_dz(var_01,var_04);
	}

	return var_02;
}

//Function Number: 7
func_5976()
{
	if(!isdefined(self.ingrindzone))
	{
		if(isagent(self))
		{
		}

		level thread setplayermessages(self);
		if(!level.zonescycling)
		{
			level.zonescycling = 1;
			level thread cyclezones();
			level thread locationstatus();
			level thread locationscoring();
		}

		thread func_8B0F();
	}

	level notify("spawned_player");
}

//Function Number: 8
func_8B0F()
{
	level endon("game_ended");
	self endon("disconnect");
	maps\mp\_utility::gameflagwait("prematch_done");
	wait(0.5);
	if(!isdefined(self.grnd_fx_playing))
	{
		playfxontagforclients(level.grnd_fx["smoke"],level.grnd_zone,"tag_fx",self);
		self.grnd_fx_playing = 1;
	}
}

//Function Number: 9
createhudinfo(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = maps\mp\gametypes\_hud_util::createfontstring(param_01,param_02);
	var_07 settext(param_05);
	if(level.splitscreen)
	{
		var_07 maps\mp\gametypes\_hud_util::func_70A4("TOPLEFT","TOPLEFT",param_03 - 35,param_04 - 5);
	}
	else
	{
		var_07 maps\mp\gametypes\_hud_util::func_70A4("TOPLEFT","TOPLEFT",param_03,param_04);
	}

	var_07.alpha = 1;
	var_07.color = param_06;
	var_07.glowcolor = param_06;
	var_07.archived = 0;
	var_07.hidewheninmenu = 1;
	thread hidehudelementongameend(var_07);
	self.grnd_hud[param_00] = var_07;
}

//Function Number: 10
setplayermessages(param_00)
{
	level endon("game_ended");
	maps\mp\_utility::gameflagwait("prematch_done");
	if(!isdefined(param_00))
	{
	}

	param_00.ingrindzonepoints = 0;
	param_00.grndheadicon = level.grnd_zone maps\mp\_entityheadicons::setheadicon(param_00,"waypoint_captureneutral_b",(0,0,0),14,14,undefined,undefined,undefined,1,undefined,0);
	param_00.grndobjid = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(param_00.grndobjid,"invisible",(0,0,0));
	objective_player(param_00.grndobjid,param_00 getentitynumber());
	objective_onentity(param_00.grndobjid,level.grnd_zone);
	objective_icon(param_00.grndobjid,"waypoint_captureneutral_b");
	objective_state(param_00.grndobjid,"active");
	if(param_00 isingrindzone())
	{
		param_00.ingrindzone = 1;
		param_00.grndheadicon.alpha = 0;
	}
	else
	{
		param_00.ingrindzone = 0;
		param_00.grndheadicon.alpha = 0.85;
	}

	param_00.grnd_wasspectator = 0;
	if(param_00.team == "spectator")
	{
		param_00.ingrindzone = 0;
		param_00.ingrindzonepoints = 0;
		param_00.grndheadicon.alpha = 0;
		param_00.grnd_hud["axisScore"].alpha = 0;
		param_00.grnd_hud["axisText"].alpha = 0;
		param_00.grnd_hud["alliesScore"].alpha = 0;
		param_00.grnd_hud["alliesText"].alpha = 0;
		param_00.grnd_wasspectator = 1;
	}

	if(!isai(param_00))
	{
		param_00 thread grndtracking();
	}
}

//Function Number: 11
getnextzone()
{
	var_00 = undefined;
	var_01 = undefined;
	var_02 = 99999999;
	var_03 = 0;
	if(isdefined(level.teleport_zone_current) && level.teleport_zone_current == "start")
	{
		var_04 = sortbydistance(level.grnd_dropzones1,level.grnd_zone.origin);
	}
	else if(isdefined(level.teleport_zone_current) && level.teleport_zone_current != "start")
	{
		if(!isdefined(level.grnd_dropzones2) || !level.grnd_dropzones2.size)
		{
			level initzones();
		}

		var_04 = sortbydistance(level.grnd_dropzones2,level.grnd_zone.origin);
	}
	else
	{
		var_04 = sortbydistance(level.grnd_zones,level.grnd_zone.origin);
	}

	var_00 = var_04[randomintrange(1,var_04.size)].origin;
	return var_00;
}

//Function Number: 12
cyclezones()
{
	level notify("cycleZones");
	level endon("cycleZones");
	level endon("game_ended");
	maps\mp\_utility::gameflagwait("prematch_done");
	for(;;)
	{
		var_00 = undefined;
		if(!level.firstzoneactive)
		{
			level.firstzoneactive = 1;
			var_00 = level.grnd_zone.origin;
		}
		else
		{
			var_00 = getnextzone();
			stopfxontag(level.grnd_fx["smoke"],level.grnd_zone,"tag_fx");
			wait(0.05);
		}

		var_01 = var_00 + (0,0,30);
		var_02 = var_00 + (0,0,-1000);
		var_03 = bullettrace(var_01,var_02,0,level.grnd_zone);
		level.grnd_zone.origin = var_03["position"] + (0,0,1);
		var_04 = var_03["entity"];
		if(isdefined(var_04))
		{
			for(var_05 = var_04 getlinkedparent();isdefined(var_05);var_05 = var_04 getlinkedparent())
			{
				var_04 = var_05;
			}
		}

		if(isdefined(var_04))
		{
			level.grnd_zone linkto(var_04);
		}
		else if(level.grnd_zone islinked())
		{
			level.grnd_zone unlink();
		}

		level.alliesweightorg = level.grnd_zone.origin;
		level.axisweightorg = level.grnd_zone.origin;
		level.grnd_dangercenter.origin = level.grnd_zone.origin;
		thread spawnregionvfx(level.grnd_zone.ringvfx,var_03["position"],vectortoangles(var_03["normal"]),0.5);
		wait(0.05);
		playfxontag(level.grnd_fx["smoke"],level.grnd_zone,"tag_fx");
		foreach(var_07 in level.players)
		{
			var_07.grnd_fx_playing = 1;
		}

		if(level.matchrules_droptime)
		{
			level thread randomdrops();
		}

		level.grnd_hud["timerDisplay"].label = &"MP_NEXT_DROP_ZONE_IN";
		level.grnd_hud["timerDisplay"] settimer(level.matchrules_zoneswitchtime);
		level.grnd_hud["timerDisplay"].alpha = 1;
		maps\mp\gametypes\_hostmigration::func_8B0D(level.matchrules_zoneswitchtime);
		level.grnd_hud["timerDisplay"].alpha = 0;
		maps\mp\_utility::func_6045("mp_dropzone_obj_new");
		foreach(var_07 in level.players)
		{
			if(isai(var_07))
			{
				var_07 thread maps/mp/bots/_bots_gametype_grnd::bot_grnd_think();
			}
		}
	}
}

//Function Number: 13
func_78A3(param_00,param_01,param_02,param_03)
{
	if(isdefined(level.grnd_targetfx))
	{
		level.grnd_targetfx delete();
	}

	wait(param_03);
	level.grnd_targetfx = spawnfx(level.grnd_targetfxid,param_00,param_01,param_02);
	triggerfx(level.grnd_targetfx);
}

//Function Number: 14
spawnregionvfx(param_00,param_01,param_02,param_03)
{
	stopfxontag(level.grnd_targetfxid,param_00,"tag_origin");
	wait(param_03);
	param_00.origin = param_01;
	param_00.angles = param_02;
	playfxontag(level.grnd_targetfxid,param_00,"tag_origin");
}

//Function Number: 15
grndtracking()
{
	self endon("disconnect");
	level endon("game_ended");
	if(!isdefined(self.team))
	{
	}

	for(;;)
	{
		if(!isdefined(self.grnd_wasspectator))
		{
			self.grnd_wasspectator = 0;
		}

		if(!self.grnd_wasspectator && self.pers["team"] == "spectator")
		{
			self.ingrindzone = 0;
			self.ingrindzonepoints = 0;
			self.grndheadicon.alpha = 0;
			self.grnd_wasspectator = 1;
		}
		else if(self.team != "spectator")
		{
			if((self.grnd_wasspectator || !self.ingrindzone) && isingrindzone())
			{
				self.ingrindzone = 1;
				self.ingrindzonepoints = 0;
				self iprintlnbold(&"OBJECTIVES_GRND_CONFIRM");
				self.grndheadicon.alpha = 0;
			}
			else if((self.grnd_wasspectator || self.ingrindzone) && !isingrindzone())
			{
				self.ingrindzone = 0;
				self.ingrindzonepoints = 0;
				self iprintlnbold(&"OBJECTIVES_GRND_HINT");
				self.grndheadicon.alpha = 0.85;
			}

			self.grnd_wasspectator = 0;
		}

		wait(0.05);
	}
}

//Function Number: 16
locationstatus()
{
	level endon("game_ended");
	level.grnd_numplayers["axis"] = 0;
	level.grnd_numplayers["allies"] = 0;
	maps\mp\_utility::gameflagwait("prematch_done");
	for(;;)
	{
		level.grnd_numplayers["axis"] = 0;
		level.grnd_numplayers["allies"] = 0;
		foreach(var_01 in level.players)
		{
			if(isdefined(var_01.ingrindzone) && maps\mp\_utility::func_4945(var_01) && var_01.pers["team"] != "spectator" && var_01 isingrindzone())
			{
				level.grnd_numplayers[var_01.pers["team"]]++;
			}
		}

		foreach(var_01 in level.players)
		{
			if(isdefined(var_01.ingrindzone) && var_01.pers["team"] != "spectator")
			{
				if(level.grnd_numplayers["axis"] == level.grnd_numplayers["allies"])
				{
					var_01.grndheadicon setshader("waypoint_captureneutral_b",14,14);
					var_01.grndheadicon setwaypoint(0,1,0,0);
					objective_icon(var_01.grndobjid,"waypoint_captureneutral_b");
					continue;
				}

				if(level.grnd_numplayers[var_01.pers["team"]] > level.grnd_numplayers[level.otherteam[var_01.pers["team"]]])
				{
					var_01.grndheadicon setshader("waypoint_defend_b",14,14);
					var_01.grndheadicon setwaypoint(0,1,0,0);
					objective_icon(var_01.grndobjid,"waypoint_defend_b");
					continue;
				}

				var_01.grndheadicon setshader("waypoint_capture_b",14,14);
				var_01.grndheadicon setwaypoint(0,1,0,0);
				objective_icon(var_01.grndobjid,"waypoint_capture_b");
			}
		}

		wait(0.5);
	}
}

//Function Number: 17
locationscoring()
{
	level endon("game_ended");
	maps\mp\_utility::gameflagwait("prematch_done");
	var_00 = maps\mp\gametypes\_rank::func_3BE0("zone_tick");
	for(;;)
	{
		foreach(var_02 in level.players)
		{
			if(isdefined(var_02.ingrindzone) && maps\mp\_utility::func_4945(var_02) && var_02.pers["team"] != "spectator" && var_02 isingrindzone())
			{
				var_02.ingrindzonepoints = var_02.ingrindzonepoints + var_00;
				maps\mp\gametypes\_gamescore::func_3D00("zone_tick",var_02,undefined,0,1);
				if(isai(var_02))
				{
					continue;
				}

				var_02.xpupdatetotal = 0;
				var_02 thread maps\mp\gametypes\_rank::func_8E77(20);
			}
		}

		if(level.grnd_numplayers["axis"])
		{
			maps\mp\gametypes\_gamescore::giveteamscoreforobjective("axis",var_00 * level.grnd_numplayers["axis"]);
		}

		if(level.grnd_numplayers["allies"])
		{
			maps\mp\gametypes\_gamescore::giveteamscoreforobjective("allies",var_00 * level.grnd_numplayers["allies"]);
		}

		maps\mp\gametypes\_hostmigration::func_8B0D(1);
	}
}

//Function Number: 18
randomdrops()
{
	level endon("game_ended");
	level notify("reset_grnd_drops");
	level endon("reset_grnd_drops");
	level.grnd_previouscratetypes = [];
	for(;;)
	{
		var_00 = getbestplayer();
		var_01 = 1;
		if(isdefined(var_00) && maps\mp\_utility::func_21E7() < maps\mp\_utility::maxvehiclesallowed() && level.fauxvehiclecount + var_01 < maps\mp\_utility::maxvehiclesallowed() && level.numdropcrates < 8)
		{
			var_00 thread maps\mp\gametypes\_rank::func_8E6E("earned_care_package");
			var_00 thread maps\mp\gametypes\_hud_message::func_794E("callout_earned_carepackage");
			var_00 thread maps\mp\_utility::func_4D30(level.otherteam[var_00.team] + "_enemy_airdrop_assault_inbound",level.otherteam[var_00.team]);
			var_00 thread maps\mp\_utility::func_4D30(var_00.team + "_friendly_airdrop_assault_inbound",var_00.team);
			maps\mp\_utility::func_6045("mp_dropzone_obj_taken",var_00.team);
			maps\mp\_utility::func_6045("mp_dropzone_obj_lost",level.otherteam[var_00.team]);
			var_02 = level.grnd_zone.origin + (randomintrange(-50,50),randomintrange(-50,50),0);
			var_03 = getdropzonecratetype();
			if(issubstr(tolower(var_03),"juggernaut"))
			{
				level thread maps\mp\killstreaks\_airdrop::func_2860(var_00,var_02,randomfloat(360),var_03);
			}
			else if(var_03 == "mega")
			{
				level thread maps\mp\killstreaks\_airdrop::domegac130flyby(var_00,var_02,randomfloat(360),"airdrop_grnd",-360);
			}
			else
			{
				maps\mp\_utility::func_4487();
				level thread maps\mp\killstreaks\_airdrop::func_2896(var_00,var_02,randomfloat(360),"airdrop_grnd",0,var_03);
			}

			var_04 = level.matchrules_droptime;
		}
		else
		{
			var_04 = 0.5;
		}

		maps\mp\gametypes\_hostmigration::func_8B0D(var_04);
	}
}

//Function Number: 19
getbestplayer()
{
	var_00 = undefined;
	var_01 = 0;
	foreach(var_03 in level.players)
	{
		if(maps\mp\_utility::func_4945(var_03) && var_03.pers["team"] != "spectator")
		{
			if(var_03 isingrindzone() && var_03.ingrindzonepoints > var_01)
			{
				var_00 = var_03;
				var_01 = var_03.ingrindzonepoints;
			}
		}
	}

	return var_00;
}

//Function Number: 20
getdropzonecratetype()
{
	var_00 = undefined;
	if(!isdefined(level.grnd_previouscratetypes["mega"]) && level.numdropcrates == 0 && randomintrange(0,100) < 5)
	{
		var_00 = "mega";
	}
	else
	{
		if(level.grnd_previouscratetypes.size)
		{
			for(var_01 = 200;var_01;var_01--)
			{
				var_00 = maps\mp\killstreaks\_airdrop::getrandomcratetype("airdrop_grnd");
				if(isdefined(level.grnd_previouscratetypes[var_00]))
				{
					var_00 = undefined;
					continue;
				}

				break;
			}
		}

		if(!isdefined(var_00))
		{
			var_00 = maps\mp\killstreaks\_airdrop::getrandomcratetype("airdrop_grnd");
		}
	}

	level.grnd_previouscratetypes[var_00] = 1;
	if(level.grnd_previouscratetypes.size == 15)
	{
		level.grnd_previouscratetypes = [];
	}

	return var_00;
}

//Function Number: 21
isingrindzone()
{
	if(distance2d(level.grnd_zone.origin,self.origin) < 300 && self.origin[2] > level.grnd_zone.origin[2] - 50)
	{
		return 1;
	}

	return 0;
}

//Function Number: 22
hidehudelementongameend(param_00)
{
	level waittill("game_ended");
	if(isdefined(param_00))
	{
		param_00.alpha = 0;
	}
}

//Function Number: 23
createzones()
{
	level.grnd_dropzones = [];
	level.grnd_dropzones1 = [];
	level.grnd_dropzones2 = [];
	var_00 = common_scripts\utility::func_3C1A("sotf_chest_spawnpoint","targetname");
	if(getdvar("mapname") == "mp_strikezone")
	{
		var_01 = [];
		var_02 = [];
		foreach(var_04 in var_00)
		{
			if(var_04.origin[2] > 10000)
			{
				level.grnd_dropzones2[level.grnd_dropzones2.size] = var_04;
				continue;
			}

			level.grnd_dropzones1[level.grnd_dropzones1.size] = var_04;
		}
	}
	else
	{
		foreach(var_04 in var_04)
		{
			level.grnd_dropzones[level.grnd_dropzones.size] = var_04;
		}
	}

	adjustzones();
}

//Function Number: 24
adjustzones()
{
	var_00 = tolower(getdvar("mapname"));
	if(var_00 == "mp_strikezone")
	{
		level.grnd_dropzones1[level.grnd_dropzones1.size] = spawnstruct();
		level.grnd_dropzones1[level.grnd_dropzones1.size - 1].origin = (-121,-1334,-73);
	}

	if(var_00 == "mp_flooded")
	{
		foreach(var_02 in level.grnd_dropzones)
		{
			if(var_02.origin == (-1596.9,1315.7,374.1))
			{
				var_02.origin = (-1561,1278,431);
			}
		}
	}

	if(var_00 == "mp_zebra")
	{
		foreach(var_02 in level.grnd_dropzones)
		{
			if(var_02.origin == (4008.3,-2066.3,482.1))
			{
				var_02.origin = (4048,-1985,539);
			}
		}
	}

	if(issubstr(var_00,"descent"))
	{
		foreach(var_02 in level.grnd_dropzones)
		{
			if(var_02.origin == (1101,116,5373.1))
			{
				var_02.origin = (1072,-80,5378);
			}
		}
	}
}