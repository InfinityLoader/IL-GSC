/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\grnd.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 23
 * Decompile Time: 343 ms
 * Timestamp: 10/27/2023 2:26:11 AM
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
		maps\mp\_utility::registerscorelimitdvar(level.gametype,20000);
		maps\mp\_utility::func_3312(level.gametype,1);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,1);
		maps\mp\_utility::func_3317(level.gametype,0);
		maps\mp\_utility::registerhalftimedvar(level.gametype,0);
		level.matchrules_droptime = 30;
		level.matchrules_zoneswitchtime = 120;
		level.matchrules_damagemultiplier = 0;
		level.matchrules_vampirism = 0;
	}

	level.teambased = 1;
	level.onprecachegametype = ::onprecachegametype;
	level.onstartgametype = ::onstartgametype;
	level.getspawnpoint = ::getspawnpoint;
	level.onspawnplayer = ::onspawnplayer;
	if(level.matchrules_damagemultiplier || level.matchrules_vampirism)
	{
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::func_2D57;
	}

	level.grnd_fx["smoke"] = loadfx("smoke/airdrop_flare_mp_effect_now");
	level.grnd_fx["flare"] = loadfx("smoke/signal_smoke_airdrop");
	level.grnd_targetfxid = loadfx("misc/ui_flagbase_red");
	level.dangermaxradius["drop_zone"] = 1200;
	level.dangerminradius["drop_zone"] = 1190;
	level.dangerforwardpush["drop_zone"] = 0;
	level.dangerovalscale["drop_zone"] = 1;
	createzones();
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::func_334C();
	level.matchrules_droptime = getmatchrulesdata("grndData","dropTime");
	level.matchrules_zoneswitchtime = 60 * getmatchrulesdata("grndData","zoneSwitchTime");
	if(level.matchrules_zoneswitchtime < 60)
	{
		level.matchrules_zoneswitchtime = 120;
	}

	setdynamicdvar("scr_grnd_roundswitch",0);
	maps\mp\_utility::func_330E("grnd",0,0,9);
	setdynamicdvar("scr_grnd_roundlimit",1);
	maps\mp\_utility::func_3312("grnd",1);
	setdynamicdvar("scr_grnd_winlimit",1);
	maps\mp\_utility::registerwinlimitdvar("grnd",1);
	setdynamicdvar("scr_grnd_halftime",0);
	maps\mp\_utility::registerhalftimedvar("grnd",0);
	setdynamicdvar("scr_grnd_promode",0);
}

//Function Number: 3
onprecachegametype()
{
	precacheshader("waypoint_captureneutral");
	precacheshader("waypoint_capture");
	precacheshader("waypoint_defend");
	precachemodel("prop_flag_neutral");
	precachestring(&"OBJECTIVES_GRND");
	precachestring(&"OBJECTIVES_GRND_SCORE");
	precachestring(&"OBJECTIVES_GRND_HINT");
	precachestring(&"OBJECTIVES_GRND_CONFIRM");
	precachestring(&"MP_CALLING_AIRDROP");
	precachestring(&"MP_NEXT_DROP_ZONE_IN");
	precachemodel("weapon_us_smoke_grenade_burnt2");
}

//Function Number: 4
onstartgametype()
{
	setclientnamemode("auto_change");
	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	maps\mp\_utility::func_3305("allies",&"OBJECTIVES_GRND");
	maps\mp\_utility::func_3305("axis",&"OBJECTIVES_GRND");
	if(level.splitscreen)
	{
		maps\mp\_utility::func_3306("allies",&"OBJECTIVES_GRND");
		maps\mp\_utility::func_3306("axis",&"OBJECTIVES_GRND");
	}
	else
	{
		maps\mp\_utility::func_3306("allies",&"OBJECTIVES_GRND_SCORE");
		maps\mp\_utility::func_3306("axis",&"OBJECTIVES_GRND_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_GRND_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_GRND_HINT");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_sab_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_sab_spawn_axis_start");
	maps\mp\gametypes\_spawnlogic::func_2FD0("allies","mp_tdm_spawn");
	maps\mp\gametypes\_spawnlogic::func_2FD0("axis","mp_tdm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::func_2FCD(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	var_00 = getent("sab_bomb","targetname");
	level.grnd_centerloc = var_00.origin;
	maps\mp\gametypes\_rank::registerscoreinfo("kill",50);
	maps\mp\gametypes\_rank::registerscoreinfo("zone_kill",100);
	maps\mp\gametypes\_rank::registerscoreinfo("zone_tick",20);
	var_01[0] = level.gametype;
	maps\mp\gametypes\_gameobjects::main(var_41);
	level.grnd_hud["timerDisplay"] = maps\mp\gametypes\_hud_util::createservertimer("objective",1.4);
	level.grnd_hud["timerDisplay"].label = &"MP_NEXT_DROP_ZONE_IN";
	if(level.splitscreen)
	{
		level.grnd_hud["timerDisplay"] maps\mp\gametypes\_hud_util::setpoint("TOPLEFT","TOPLEFT",80,0);
	}
	else
	{
		level.grnd_hud["timerDisplay"] maps\mp\gametypes\_hud_util::setpoint("TOPLEFT","TOPLEFT",115,5);
	}

	level.grnd_hud["timerDisplay"].alpha = 0;
	level.grnd_hud["timerDisplay"].archived = 0;
	level.grnd_hud["timerDisplay"].hidewheninmenu = 1;
	thread func_3535(level.grnd_hud["timerDisplay"]);
	initfirstzone();
}

//Function Number: 5
initfirstzone()
{
	level.zonescycling = 0;
	level.var_8244 = 0;
	var_00 = 999999;
	var_01 = 0;
	for(var_02 = 0;var_02 < level.grnd_dropzones[level.script].size;var_02++)
	{
		var_03 = level.grnd_dropzones[level.script][var_02];
		var_04 = distance2d(level.grnd_centerloc,var_03);
		if(var_04 < var_00)
		{
			var_00 = var_04;
			var_01 = var_02;
		}
	}

	level.grnd_initialindex = var_01;
	var_05 = level.grnd_dropzones[level.script][var_01];
	level.grnd_initialpos = var_05;
	level.grnd_zone = spawn("script_model",var_05);
	level.grnd_zone.origin = var_05;
	level.grnd_zone.angles = (90,0,0);
	level.grnd_zone setmodel("weapon_us_smoke_grenade_burnt2");
	level.grnd_dangercenter = spawnstruct();
	level.grnd_dangercenter.origin = var_05;
	level.grnd_dangercenter.forward = anglestoforward((0,0,0));
	level.grnd_dangercenter.streakname = "drop_zone";
	level.artillerydangercenters[level.artillerydangercenters.size] = level.grnd_dangercenter;
	level.favorclosespawnent = level.grnd_zone;
	level.favorclosespawnscalar = 5;
	level thread func_3525();
}

//Function Number: 6
func_3525()
{
	level.grnd_zones = [];
	for(var_00 = 0;var_00 < level.grnd_dropzones[level.script].size;var_00++)
	{
		var_01 = level.grnd_dropzones[level.script][var_00];
		level.grnd_zones[var_00] = spawn("script_origin",var_01);
		level.grnd_zones[var_00].origin = var_01;
		wait 0.05;
	}

	level.grnd_zones[level.grnd_initialindex] delete();
	level.grnd_zones[level.grnd_initialindex] = undefined;
	level.grnd_zones = common_scripts\utility::array_removeundefined(level.grnd_zones);
}

//Function Number: 7
getspawnpoint()
{
	if(level.ingraceperiod)
	{
		var_00 = maps\mp\gametypes\_spawnlogic::getspawnpointarray("mp_sab_spawn_" + self.pers["team"] + "_start");
		var_01 = maps\mp\gametypes\_spawnlogic::getspawnpoint_random(var_00);
	}
	else
	{
		var_00 = maps\mp\gametypes\_spawnlogic::getteamspawnpoints(self.pers["team"]);
		var_01 = maps\mp\gametypes\_spawnlogic::func_2FE6(var_01);
	}

	return var_01;
}

//Function Number: 8
onspawnplayer()
{
	if(!isdefined(self.ingrindzone))
	{
		level thread setplayermessages(self);
		if(!level.zonescycling)
		{
			level.zonescycling = 1;
			level thread cyclezones();
			level thread locationstatus();
			level thread locationscoring();
		}

		thread waitreplaysmokefxfornewplayer();
	}

	level notify("spawned_player");
}

//Function Number: 9
waitreplaysmokefxfornewplayer()
{
	level endon("game_ended");
	self endon("disconnect");
	maps\mp\_utility::func_274B("prematch_done");
	wait 0.5;
	if(!isdefined(self.grnd_fx_playing))
	{
		playfxontagforclients(level.grnd_fx["smoke"],level.grnd_zone,"tag_fx",self);
		self.grnd_fx_playing = 1;
	}
}

//Function Number: 10
createhudinfo(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = maps\mp\gametypes\_hud_util::createfontstring(param_01,param_02);
	var_07 settext(param_05);
	if(level.splitscreen)
	{
		var_07 maps\mp\gametypes\_hud_util::setpoint("TOPLEFT","TOPLEFT",param_03 - 35,param_04 - 5);
	}
	else
	{
		var_07 maps\mp\gametypes\_hud_util::setpoint("TOPLEFT","TOPLEFT",param_03,param_04);
	}

	var_07.alpha = 1;
	var_07.color = param_06;
	var_07.glowcolor = param_06;
	var_07.archived = 0;
	var_07.hidewheninmenu = 1;
	thread func_3535(var_07);
	self.grnd_hud[param_00] = var_07;
}

//Function Number: 11
setplayermessages(param_00)
{
	level endon("game_ended");
	maps\mp\_utility::func_274B("prematch_done");
	param_00.ingrindzonepoints = 0;
	var_01 = param_00.team + "Score";
	param_00 createhudinfo(var_01,"small",1.6,115,22,0,(0.6,1,0.6));
	var_01 = param_00.team + "Text";
	param_00 createhudinfo(var_01,"small",1.6,135,22,maps\mp\gametypes\_teams::func_276B(param_00.team),(0.6,1,0.6));
	var_01 = level.otherteam[param_00.team] + "Score";
	param_00 createhudinfo(var_01,"small",1.6,115,39,0,(1,0.6,0.6));
	var_01 = level.otherteam[param_00.team] + "Text";
	param_00 createhudinfo(var_01,"small",1.6,135,39,maps\mp\gametypes\_teams::func_276B(level.otherteam[param_00.team]),(1,0.6,0.6));
	param_00.grndheadicon = level.grnd_zone maps\mp\_entityheadicons::func_277C(param_00,"waypoint_captureneutral",(0,0,0),14,14,undefined,undefined,undefined,1,undefined,0);
	param_00.grndobjid = maps\mp\gametypes\_gameobjects::func_2A31();
	objective_add(param_00.grndobjid,"invisible",(0,0,0));
	objective_player(param_00.grndobjid,param_00 getentitynumber());
	objective_onentity(param_00.grndobjid,level.grnd_zone);
	objective_icon(param_00.grndobjid,"waypoint_captureneutral");
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

	param_00 thread grndtracking();
}

//Function Number: 12
getnextzone()
{
	var_00 = undefined;
	var_01 = undefined;
	if(level.grnd_zones.size > 2)
	{
		var_02 = 999999;
		var_03 = 0;
		for(var_04 = 0;var_04 < level.grnd_zones.size;var_04++)
		{
			level.grnd_zones[var_04].index = var_04;
			level.grnd_zones[var_04].disttozone = distance(level.grnd_zones[var_04].origin,level.grnd_zone.origin);
			if(level.grnd_zones[var_04].disttozone > var_03)
			{
				var_03 = level.grnd_zones[var_04].disttozone;
				continue;
			}

			if(level.grnd_zones[var_04].disttozone < var_02)
			{
				var_02 = level.grnd_zones[var_04].disttozone;
			}
		}

		var_05 = [];
		var_06 = [];
		var_07 = int(var_02 + var_03 / 2);
		for(var_04 = 0;var_04 < level.grnd_zones.size;var_04++)
		{
			if(level.grnd_zones[var_04].disttozone >= var_07)
			{
				var_05[var_05.size] = level.grnd_zones[var_04];
				continue;
			}

			var_06[var_06.size] = level.grnd_zones[var_04];
		}

		var_08 = undefined;
		if(var_05.size > 1)
		{
			var_08 = var_05[randomintrange(0,var_05.size)];
		}
		else if(var_05.size)
		{
			var_08 = var_05[0];
		}
		else
		{
			var_08 = var_06[randomintrange(0,var_06.size)];
		}

		var_01 = var_08.index;
	}
	else if(level.grnd_zones.size == 2)
	{
		var_09 = distance(level.grnd_zones[0].origin,level.grnd_zone.origin);
		var_0A = distance(level.grnd_zones[1].origin,level.grnd_zone.origin);
		if(var_09 > var_0A)
		{
			var_01 = 0;
		}
		else
		{
			var_01 = 1;
		}
	}
	else if(level.grnd_zones.size == 1)
	{
		var_01 = 0;
	}

	if(isdefined(var_01))
	{
		var_00 = level.grnd_zones[var_01].origin;
		level.grnd_zones[var_01] delete();
		level.grnd_zones[var_01] = undefined;
		level.grnd_zones = common_scripts\utility::array_removeundefined(level.grnd_zones);
	}
	else
	{
		var_00 = level.grnd_dropzones[level.script][level.grnd_initialindex];
		level thread func_3525();
	}

	return var_00;
}

//Function Number: 13
cyclezones()
{
	level endon("game_ended");
	maps\mp\_utility::func_274B("prematch_done");
	for(;;)
	{
		var_00 = undefined;
		if(!level.var_8244)
		{
			level.var_8244 = 1;
			var_00 = level.grnd_zone.origin;
		}
		else
		{
			var_00 = getnextzone();
			stopfxontag(level.grnd_fx["smoke"],level.grnd_zone,"tag_fx");
			wait 0.05;
		}

		var_01 = var_00 + (0,0,30);
		var_02 = var_00 + (0,0,-1000);
		var_03 = bullettrace(var_01,var_02,0,undefined);
		level.grnd_zone.origin = var_03["position"] + (0,0,1);
		level.grnd_dangercenter.origin = level.grnd_zone.origin;
		var_04 = vectortoangles(var_03["normal"]);
		var_05 = anglestoforward(var_04);
		var_06 = anglestoright(var_04);
		thread func_3084(var_03["position"],var_05,var_06,0.5);
		wait 0.05;
		playfxontag(level.grnd_fx["smoke"],level.grnd_zone,"tag_fx");
		foreach(var_08 in level.players)
		{
			var_08.grnd_fx_playing = 1;
		}

		if(level.matchrules_droptime)
		{
			level thread func_3532();
		}

		level.grnd_hud["timerDisplay"].label = &"MP_NEXT_DROP_ZONE_IN";
		level.grnd_hud["timerDisplay"] settimer(level.matchrules_zoneswitchtime);
		level.grnd_hud["timerDisplay"].alpha = 1;
		maps\mp\gametypes\_hostmigration::func_2740(level.matchrules_zoneswitchtime);
		level.grnd_hud["timerDisplay"].alpha = 0;
		maps\mp\_utility::func_2D68("mp_obj_captured");
	}
}

//Function Number: 14
func_3084(param_00,param_01,param_02,param_03)
{
	if(isdefined(level.grnd_targetfx))
	{
		level.grnd_targetfx delete();
	}

	wait param_03;
	level.grnd_targetfx = spawnfx(level.grnd_targetfxid,param_00,param_01,param_02);
	triggerfx(level.grnd_targetfx);
}

//Function Number: 15
grndtracking()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		if(!self.grnd_wasspectator && self.team == "spectator")
		{
			self.ingrindzone = 0;
			self.ingrindzonepoints = 0;
			self.grndheadicon.alpha = 0;
			self.grnd_hud["axisScore"].alpha = 0;
			self.grnd_hud["axisText"].alpha = 0;
			self.grnd_hud["alliesScore"].alpha = 0;
			self.grnd_hud["alliesText"].alpha = 0;
			self.grnd_wasspectator = 1;
		}
		else if(self.team != "spectator")
		{
			if((self.grnd_wasspectator || !self.ingrindzone) && isingrindzone())
			{
				self.ingrindzone = 1;
				self.ingrindzonepoints = 0;
				self iprintlnbold(&"OBJECTIVES_GRND_CONFIRM");
				self.grnd_hud["axisScore"].alpha = 1;
				self.grnd_hud["axisText"].alpha = 1;
				self.grnd_hud["alliesScore"].alpha = 1;
				self.grnd_hud["alliesText"].alpha = 1;
				self.grnd_hud[self.team + "Score"].glowalpha = 1;
				self.grnd_hud[self.team + "Text"].glowalpha = 1;
				self.grndheadicon.alpha = 0;
			}
			else if((self.grnd_wasspectator || self.ingrindzone) && !isingrindzone())
			{
				self.ingrindzone = 0;
				self.ingrindzonepoints = 0;
				self iprintlnbold(&"OBJECTIVES_GRND_HINT");
				self.grnd_hud["axisScore"].alpha = 1;
				self.grnd_hud["axisText"].alpha = 1;
				self.grnd_hud["alliesScore"].alpha = 1;
				self.grnd_hud["alliesText"].alpha = 1;
				self.grnd_hud[self.team + "Score"].glowalpha = 0;
				self.grnd_hud[self.team + "Text"].glowalpha = 0;
				self.grndheadicon.alpha = 0.85;
			}

			self.grnd_wasspectator = 0;
		}

		wait 0.05;
	}
}

//Function Number: 16
locationstatus()
{
	level endon("game_ended");
	level.grnd_numplayers["axis"] = 0;
	level.grnd_numplayers["allies"] = 0;
	maps\mp\_utility::func_274B("prematch_done");
	for(;;)
	{
		level.grnd_numplayers["axis"] = 0;
		level.grnd_numplayers["allies"] = 0;
		foreach(var_01 in level.players)
		{
			if(isdefined(var_01.ingrindzone) && maps\mp\_utility::isreallyalive(var_01) && var_01.pers["team"] != "spectator" && var_01 isingrindzone())
			{
				level.grnd_numplayers[var_01.pers["team"]]++;
			}
		}

		foreach(var_01 in level.players)
		{
			if(isdefined(var_01.ingrindzone) && var_01.pers["team"] != "spectator")
			{
				var_01.grnd_hud["axisScore"] settext(level.grnd_numplayers["axis"]);
				var_01.grnd_hud["alliesScore"] settext(level.grnd_numplayers["allies"]);
				if(level.grnd_numplayers["axis"] == level.grnd_numplayers["allies"])
				{
					var_01.grndheadicon setshader("waypoint_captureneutral",14,14);
					var_01.grndheadicon setwaypoint(0,1,0,0);
					objective_icon(var_01.grndobjid,"waypoint_captureneutral");
					continue;
				}

				if(level.grnd_numplayers[var_01.pers["team"]] > level.grnd_numplayers[level.otherteam[var_01.pers["team"]]])
				{
					var_01.grndheadicon setshader("waypoint_defend",14,14);
					var_01.grndheadicon setwaypoint(0,1,0,0);
					objective_icon(var_01.grndobjid,"waypoint_defend");
					continue;
				}

				var_01.grndheadicon setshader("waypoint_capture",14,14);
				var_01.grndheadicon setwaypoint(0,1,0,0);
				objective_icon(var_01.grndobjid,"waypoint_capture");
			}
		}

		wait 0.5;
	}
}

//Function Number: 17
locationscoring()
{
	level endon("game_ended");
	maps\mp\_utility::func_274B("prematch_done");
	var_00 = maps\mp\gametypes\_rank::getscoreinfovalue("zone_tick");
	for(;;)
	{
		if(level.grnd_numplayers["axis"])
		{
			maps\mp\gametypes\_gamescore::giveteamscoreforobjective("axis",var_00 * level.grnd_numplayers["axis"]);
		}

		if(level.grnd_numplayers["allies"])
		{
			maps\mp\gametypes\_gamescore::giveteamscoreforobjective("allies",var_00 * level.grnd_numplayers["allies"]);
		}

		foreach(var_02 in level.players)
		{
			if(isdefined(var_02.ingrindzone) && maps\mp\_utility::isreallyalive(var_02) && var_02.pers["team"] != "spectator" && var_02 isingrindzone())
			{
				var_02.ingrindzonepoints = var_02.ingrindzonepoints + var_00;
				maps\mp\gametypes\_gamescore::func_26D3("zone_tick",var_02,undefined,0,1);
				var_02.xpupdatetotal = 0;
				var_02 thread maps\mp\gametypes\_rank::xppointspopup(20,0,(1,1,0.5),0);
			}
		}

		maps\mp\gametypes\_hostmigration::func_2740(1);
	}
}

//Function Number: 18
func_3532()
{
	level endon("game_ended");
	level notify("reset_grnd_drops");
	level endon("reset_grnd_drops");
	level.grnd_previouscratetypes = [];
	for(;;)
	{
		var_00 = func_3533();
		var_01 = 1;
		if(isdefined(var_00) && maps\mp\_utility::func_2BEC() < maps\mp\_utility::maxvehiclesallowed() && level.fauxvehiclecount + var_01 < maps\mp\_utility::maxvehiclesallowed() && level.numdropcrates < 8)
		{
			var_00 thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_EARNED_CAREPACKAGE");
			thread maps\mp\_utility::teamplayercardsplash("callout_earned_carepackage",var_00);
			var_00 thread maps\mp\_utility::func_26E5(level.otherteam[var_00.team] + "_enemy_airdrop_assault_inbound",level.otherteam[var_00.team]);
			var_00 thread maps\mp\_utility::func_26E5(var_00.team + "_friendly_airdrop_assault_inbound",var_00.team);
			maps\mp\_utility::func_2D68("mp_war_objective_taken",var_00.team);
			maps\mp\_utility::func_2D68("mp_war_objective_lost",level.otherteam[var_00.team]);
			var_02 = level.grnd_zone.origin + (randomintrange(-50,50),randomintrange(-50,50),0);
			var_03 = getdropzonecratetype();
			if(issubstr(tolower(var_03),"juggernaut"))
			{
				level thread maps\mp\killstreaks\_airdrop::doc130flyby(var_00,var_02,randomfloat(360),var_03);
			}
			else if(var_03 == "mega")
			{
				level thread maps\mp\killstreaks\_airdrop::func_2E77(var_00,var_02,randomfloat(360),"airdrop_grnd",-360);
			}
			else
			{
				maps\mp\_utility::func_80C7();
				level thread maps\mp\killstreaks\_airdrop::doflyby(var_00,var_02,randomfloat(360),"airdrop_grnd",0,var_03);
			}

			var_04 = level.matchrules_droptime;
		}
		else
		{
			var_04 = 0.5;
		}

		maps\mp\gametypes\_hostmigration::func_2740(var_04);
	}
}

//Function Number: 19
func_3533()
{
	var_00 = undefined;
	var_01 = 0;
	foreach(var_03 in level.players)
	{
		if(maps\mp\_utility::isreallyalive(var_03) && var_03.pers["team"] != "spectator")
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
func_3535(param_00)
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
	var_00 = getentarray("grnd_dropZone","targetname");
	if(isdefined(var_00) && var_00.size)
	{
		var_01 = 0;
		foreach(var_03 in var_00)
		{
			level.grnd_dropzones[level.script][var_01] = var_03.origin;
			var_01++;
		}

		return;
	}

	level.grnd_dropzones["mp_seatown"][0] = (-665,-209,226);
	level.grnd_dropzones["mp_seatown"][1] = (-2225,1573,260);
	level.grnd_dropzones["mp_seatown"][2] = (1275,-747,292);
	level.grnd_dropzones["mp_seatown"][3] = (1210,963,225);
	level.grnd_dropzones["mp_seatown"][4] = (-2343,-811,226);
	level.grnd_dropzones["mp_seatown"][5] = (-1125,-1610,184);
	level.grnd_dropzones["mp_dome"][0] = (649,1096,-250);
	level.grnd_dropzones["mp_dome"][1] = (953,-501,-328);
	level.grnd_dropzones["mp_dome"][2] = (-37,2099,-231);
	level.grnd_dropzones["mp_dome"][3] = (-716,1100,-296);
	level.grnd_dropzones["mp_dome"][4] = (-683,-51,-352);
	level.grnd_dropzones["mp_plaza2"][0] = (266,-212,708);
	level.grnd_dropzones["mp_plaza2"][1] = (295,1842,668);
	level.grnd_dropzones["mp_plaza2"][2] = (-1449,1833,692);
	level.grnd_dropzones["mp_plaza2"][3] = (835,-1815,668);
	level.grnd_dropzones["mp_plaza2"][4] = (-1116,76,729);
	level.grnd_dropzones["mp_plaza2"][5] = (-399,951,676);
	level.grnd_dropzones["mp_mogadishu"][0] = (552,1315,8);
	level.grnd_dropzones["mp_mogadishu"][1] = (990,3248,144);
	level.grnd_dropzones["mp_mogadishu"][2] = (-879,2643,135);
	level.grnd_dropzones["mp_mogadishu"][3] = (-68,-995,16);
	level.grnd_dropzones["mp_mogadishu"][4] = (1499,-1206,15);
	level.grnd_dropzones["mp_mogadishu"][5] = (2387,1786,61);
	level.grnd_dropzones["mp_paris"][0] = (-150,-80,63);
	level.grnd_dropzones["mp_paris"][1] = (-947,-1088,107);
	level.grnd_dropzones["mp_paris"][2] = (1052,-614,50);
	level.grnd_dropzones["mp_paris"][3] = (1886,648,24);
	level.grnd_dropzones["mp_paris"][4] = (628,2096,30);
	level.grnd_dropzones["mp_paris"][5] = (-2033,1082,308);
	level.grnd_dropzones["mp_paris"][6] = (-1230,1836,295);
	level.grnd_dropzones["mp_exchange"][0] = (904,441,-77);
	level.grnd_dropzones["mp_exchange"][1] = (-1056,1435,141);
	level.grnd_dropzones["mp_exchange"][2] = (800,1543,148);
	level.grnd_dropzones["mp_exchange"][3] = (2423,1368,141);
	level.grnd_dropzones["mp_exchange"][4] = (596,-1870,89);
	level.grnd_dropzones["mp_exchange"][5] = (-1241,-821,30);
	level.grnd_dropzones["mp_bootleg"][0] = (-444,-114,-8);
	level.grnd_dropzones["mp_bootleg"][1] = (1053,-1051,-13);
	level.grnd_dropzones["mp_bootleg"][2] = (889,1184,-28);
	level.grnd_dropzones["mp_bootleg"][3] = (-994,1877,-41);
	level.grnd_dropzones["mp_bootleg"][4] = (-1707,-1333,63);
	level.grnd_dropzones["mp_bootleg"][5] = (-334,-2155,61);
	level.grnd_dropzones["mp_carbon"][0] = (-1791,-3892,3813);
	level.grnd_dropzones["mp_carbon"][1] = (-338,-4978,3964);
	level.grnd_dropzones["mp_carbon"][2] = (-82,-2941,3990);
	level.grnd_dropzones["mp_carbon"][3] = (-3198,-2829,3809);
	level.grnd_dropzones["mp_carbon"][4] = (-3673,-3893,3610);
	level.grnd_dropzones["mp_carbon"][5] = (-2986,-4863,3648);
	level.grnd_dropzones["mp_hardhat"][0] = (1187,-322,238);
	level.grnd_dropzones["mp_hardhat"][1] = (2010,-1379,357);
	level.grnd_dropzones["mp_hardhat"][2] = (1615,1245,366);
	level.grnd_dropzones["mp_hardhat"][3] = (-371,825,436);
	level.grnd_dropzones["mp_hardhat"][4] = (-820,-927,348);
	level.grnd_dropzones["mp_alpha"][0] = (-239,1315,52);
	level.grnd_dropzones["mp_alpha"][1] = (-1678,-219,55);
	level.grnd_dropzones["mp_alpha"][2] = (235,-369,60);
	level.grnd_dropzones["mp_alpha"][3] = (-201,2138,60);
	level.grnd_dropzones["mp_alpha"][4] = (-1903,2433,198);
	level.grnd_dropzones["mp_village"][0] = (990,-821,331);
	level.grnd_dropzones["mp_village"][1] = (658,2155,337);
	level.grnd_dropzones["mp_village"][2] = (-559,1882,310);
	level.grnd_dropzones["mp_village"][3] = (-1999,1184,343);
	level.grnd_dropzones["mp_village"][4] = (215,-2875,384);
	level.grnd_dropzones["mp_village"][5] = (1731,-483,290);
	level.grnd_dropzones["mp_lambeth"][0] = (712,217,-196);
	level.grnd_dropzones["mp_lambeth"][1] = (1719,-1095,-196);
	level.grnd_dropzones["mp_lambeth"][2] = (2843,1034,-269);
	level.grnd_dropzones["mp_lambeth"][3] = (1251,2645,-213);
	level.grnd_dropzones["mp_lambeth"][4] = (-1114,1301,-200);
	level.grnd_dropzones["mp_lambeth"][5] = (-693,-823,-132);
	level.grnd_dropzones["mp_radar"][0] = (-5052,2371,1223);
	level.grnd_dropzones["mp_radar"][1] = (-4550,4199,1268);
	level.grnd_dropzones["mp_radar"][2] = (-7149,4449,1376);
	level.grnd_dropzones["mp_radar"][3] = (-6350,1528,1302);
	level.grnd_dropzones["mp_radar"][4] = (-3333,992,1222);
	level.grnd_dropzones["mp_radar"][5] = (-4040,-361,1222);
	level.grnd_dropzones["mp_interchange"][0] = (662,-513,142);
	level.grnd_dropzones["mp_interchange"][1] = (674,1724,112);
	level.grnd_dropzones["mp_interchange"][2] = (-1003,1103,30);
	level.grnd_dropzones["mp_interchange"][3] = (385,-2910,209);
	level.grnd_dropzones["mp_interchange"][4] = (2004,-1760,144);
	level.grnd_dropzones["mp_interchange"][5] = (2458,-300,147);
	level.grnd_dropzones["mp_underground"][0] = (31,1319,-196);
	level.grnd_dropzones["mp_underground"][1] = (165,-940,60);
	level.grnd_dropzones["mp_underground"][2] = (-747,143,4);
	level.grnd_dropzones["mp_underground"][3] = (-1671,1666,-216);
	level.grnd_dropzones["mp_underground"][4] = (-631,3158,-68);
	level.grnd_dropzones["mp_underground"][5] = (500,2865,-89);
	level.grnd_dropzones["mp_bravo"][0] = (-39,-119,1280);
	level.grnd_dropzones["mp_bravo"][1] = (1861,-563,1229);
	level.grnd_dropzones["mp_bravo"][2] = (-1548,-366,1007);
	level.grnd_dropzones["mp_bravo"][3] = (-678,1272,1273);
	level.grnd_dropzones["mp_bravo"][4] = (1438,842,1272);
}