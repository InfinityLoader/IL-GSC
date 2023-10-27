/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\grnd.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 289 ms
 * Timestamp: 10/27/2023 2:13:15 AM
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
		maps\mp\_utility::registerroundswitchdvar(level.gametype,0,0,9);
		maps\mp\_utility::registertimelimitdvar(level.gametype,10);
		maps\mp\_utility::registerscorelimitdvar(level.gametype,20000);
		maps\mp\_utility::registerroundlimitdvar(level.gametype,1);
		maps\mp\_utility::registerwinlimitdvar(level.gametype,1);
		maps\mp\_utility::registernumlivesdvar(level.gametype,0);
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
		level.modifyplayerdamage = ::maps\mp\gametypes\_damage::gamemodemodifyplayerdamage;
	}

	level.grnd_fx["smoke"] = loadfx("smoke/airdrop_flare_mp_effect_now");
	level.grnd_fx["flare"] = loadfx("smoke/signal_smoke_airdrop");
	func_3A0C();
}

//Function Number: 2
initializematchrules()
{
	maps\mp\_utility::setcommonrulesfrommatchrulesdata();
	level.matchrules_droptime = getmatchrulesdata("grndData","dropTime");
	level.matchrules_zoneswitchtime = 60 * getmatchrulesdata("grndData","zoneSwitchTime");
	setdynamicdvar("scr_grnd_roundswitch",0);
	maps\mp\_utility::registerroundswitchdvar("grnd",0,0,9);
	setdynamicdvar("scr_grnd_roundlimit",1);
	maps\mp\_utility::registerroundlimitdvar("grnd",1);
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

	maps\mp\_utility::setobjectivetext("allies",&"OBJECTIVES_GRND");
	maps\mp\_utility::setobjectivetext("axis",&"OBJECTIVES_GRND");
	if(level.splitscreen)
	{
		maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_GRND");
		maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_GRND");
	}
	else
	{
		maps\mp\_utility::setobjectivescoretext("allies",&"OBJECTIVES_GRND_SCORE");
		maps\mp\_utility::setobjectivescoretext("axis",&"OBJECTIVES_GRND_SCORE");
	}

	maps\mp\_utility::setobjectivehinttext("allies",&"OBJECTIVES_GRND_HINT");
	maps\mp\_utility::setobjectivehinttext("axis",&"OBJECTIVES_GRND_HINT");
	level.spawnmins = (0,0,0);
	level.spawnmaxs = (0,0,0);
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_sab_spawn_allies_start");
	maps\mp\gametypes\_spawnlogic::placespawnpoints("mp_sab_spawn_axis_start");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("allies","mp_tdm_spawn");
	maps\mp\gametypes\_spawnlogic::addspawnpoints("axis","mp_tdm_spawn");
	level.mapcenter = maps\mp\gametypes\_spawnlogic::findboxcenter(level.spawnmins,level.spawnmaxs);
	setmapcenter(level.mapcenter);
	var_00 = getent("sab_bomb","targetname");
	level.grnd_centerloc = var_00.origin;
	maps\mp\gametypes\_rank::registerscoreinfo("zone_kill",100);
	maps\mp\gametypes\_rank::registerscoreinfo("zone_tick",20);
	var_01[0] = level.gametype;
	maps\mp\gametypes\_gameobjects::main(var_7B);
	level.grnd_timerdisplay = maps\mp\gametypes\_hud_util::createservertimer("objective",1.4);
	if(level.splitscreen)
	{
		level.grnd_timerdisplay maps\mp\gametypes\_hud_util::setpoint("TOPLEFT","TOPLEFT",80,0);
	}
	else
	{
		level.grnd_timerdisplay maps\mp\gametypes\_hud_util::setpoint("TOPLEFT","TOPLEFT",115,5);
	}

	level.grnd_timerdisplay.label = &"MP_NEXT_DROP_ZONE_IN";
	level.grnd_timerdisplay.alpha = 0;
	level.grnd_timerdisplay.archived = 0;
	level.grnd_timerdisplay.hidewheninmenu = 1;
	thread func_3A0B(level.grnd_timerdisplay);
	func_39F6();
}

//Function Number: 5
func_39F6()
{
	level.zonescycling = 0;
	level.var_14 = 0;
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
	level.grnd_zone = spawn("script_model",var_05);
	level.grnd_zone.origin = var_05;
	level.grnd_zone.angles = (90,0,0);
	level.grnd_zone setmodel("weapon_us_smoke_grenade_burnt2");
	level.favorclosespawnent = level.grnd_zone;
	level.favorclosespawnscalar = 5;
	level thread func_39FB();
}

//Function Number: 6
func_39FB()
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
		var_01 = maps\mp\gametypes\_spawnlogic::getspawnpoint_nearteam(var_01);
	}

	return var_01;
}

//Function Number: 8
onspawnplayer()
{
	if(!isdefined(self.ingrindzone))
	{
		level thread func_39FE(self);
		if(!level.zonescycling)
		{
			level.zonescycling = 1;
			level thread func_3A05();
			level thread func_3A07();
		}
	}

	level notify("spawned_player");
}

//Function Number: 9
func_39FE(param_00)
{
	level endon("game_ended");
	maps\mp\_utility::gameflagwait("prematch_done");
	param_00.ingrindzonepoints = 0;
	param_00.grndhudtext = param_00 maps\mp\gametypes\_hud_util::createfontstring("small",1.6);
	if(level.splitscreen)
	{
		param_00.grndhudtext maps\mp\gametypes\_hud_util::setpoint("TOP LEFT","TOP LEFT",80,18);
	}
	else
	{
		param_00.grndhudtext maps\mp\gametypes\_hud_util::setpoint("TOP LEFT","TOP LEFT",115,22);
	}

	param_00.grndhudtext.alpha = 1;
	param_00.grndhudtext.archived = 0;
	param_00.grndhudtext.hidewheninmenu = 1;
	level thread func_3A0B(param_00.grndhudtext);
	param_00.grndheadicon = level.grnd_zone maps\mp\_entityheadicons::setheadicon(param_00,"waypoint_captureneutral",(0,0,0),14,14,undefined,undefined,undefined,undefined,undefined,0);
	param_00.grndobjid = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(param_00.grndobjid,"invisible",(0,0,0));
	objective_player(param_00.grndobjid,param_00 getentitynumber());
	objective_onentity(param_00.grndobjid,level.grnd_zone);
	objective_icon(param_00.grndobjid,"waypoint_captureneutral");
	objective_state(param_00.grndobjid,"active");
	if(distance2d(level.grnd_zone.origin,param_00.origin) < 300)
	{
		param_00.ingrindzone = 1;
		param_00.grndhudtext settext(&"OBJECTIVES_GRND_CONFIRM");
		param_00.grndhudtext.color = (0.6,1,0.6);
		param_00.grndheadicon.alpha = 0;
	}
	else
	{
		param_00.ingrindzone = 0;
		param_00.grndhudtext settext(&"OBJECTIVES_GRND_HINT");
		param_00.grndhudtext.color = (1,0.6,0.6);
		param_00.grndheadicon.alpha = 0.85;
	}

	param_00.grnd_wasspectator = 0;
	if(param_00.team == "spectator")
	{
		param_00.ingrindzone = 0;
		param_00.ingrindzonepoints = 0;
		param_00.grndheadicon.alpha = 0;
		param_00.grndhudtext.alpha = 0;
		param_00.grnd_wasspectator = 1;
	}

	param_00 thread func_3A06();
}

//Function Number: 10
func_3A03()
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
		level thread func_39FB();
	}

	return var_00;
}

//Function Number: 11
func_3A05()
{
	level endon("game_ended");
	maps\mp\_utility::gameflagwait("prematch_done");
	for(;;)
	{
		var_00["axis"] = game["teamScores"]["axis"];
		var_00["allies"] = game["teamScores"]["allies"];
		var_01 = undefined;
		if(!level.var_14)
		{
			level.var_14 = 1;
			var_01 = level.grnd_zone.origin;
		}
		else
		{
			var_01 = func_3A03();
			stopfxontag(level.grnd_fx["smoke"],level.grnd_zone,"tag_fx");
			wait 0.05;
		}

		var_02 = var_01 + (0,0,30);
		var_03 = var_01 + (0,0,-1000);
		var_04 = bullettrace(var_02,var_03,0,undefined);
		level.grnd_zone.origin = var_04["position"] + (0,0,1);
		wait 0.05;
		playfxontag(level.grnd_fx["smoke"],level.grnd_zone,"tag_fx");
		if(level.matchrules_droptime)
		{
			level thread func_3A08();
		}

		level.grnd_timerdisplay.label = &"MP_NEXT_DROP_ZONE_IN";
		level.grnd_timerdisplay settimer(level.matchrules_zoneswitchtime);
		level.grnd_timerdisplay.alpha = 1;
		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(level.matchrules_zoneswitchtime);
		level.grnd_timerdisplay.alpha = 0;
		if(game["teamScores"]["axis"] - var_00["axis"] > game["teamScores"]["allies"] - var_00["allies"])
		{
			maps\mp\_utility::playsoundonplayers("mp_obj_captured","axis");
			maps\mp\_utility::playsoundonplayers("mp_enemy_obj_captured","allies");
			continue;
		}

		if(game["teamScores"]["allies"] - var_00["allies"] > game["teamScores"]["axis"] - var_00["axis"])
		{
			maps\mp\_utility::playsoundonplayers("mp_obj_captured","allies");
			maps\mp\_utility::playsoundonplayers("mp_enemy_obj_captured","axis");
		}
	}
}

//Function Number: 12
func_3A06()
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
			self.grndhudtext.alpha = 0;
			self.grnd_wasspectator = 1;
		}
		else if(self.team != "spectator")
		{
			if((self.grnd_wasspectator || !self.ingrindzone) && distance2d(level.grnd_zone.origin,self.origin) < 300)
			{
				self.ingrindzone = 1;
				self.ingrindzonepoints = 0;
				self.grndhudtext settext(&"OBJECTIVES_GRND_CONFIRM");
				self.grndhudtext.color = (0.6,1,0.6);
				self.grndhudtext.alpha = 1;
				self.grndheadicon.alpha = 0;
			}
			else if((self.grnd_wasspectator || self.ingrindzone) && distance2d(level.grnd_zone.origin,self.origin) >= 300)
			{
				self.ingrindzone = 0;
				self.ingrindzonepoints = 0;
				self.grndhudtext settext(&"OBJECTIVES_GRND_HINT");
				self.grndhudtext.color = (1,0.6,0.6);
				self.grndhudtext.alpha = 1;
				self.grndheadicon.alpha = 0.85;
			}

			self.grnd_wasspectator = 0;
		}

		wait 0.05;
	}
}

//Function Number: 13
func_3A07()
{
	level endon("game_ended");
	maps\mp\_utility::gameflagwait("prematch_done");
	var_00 = maps\mp\gametypes\_rank::getscoreinfovalue("zone_tick");
	for(;;)
	{
		var_01["axis"] = 0;
		var_01["allies"] = 0;
		foreach(var_03 in level.players)
		{
			if(isdefined(var_03.ingrindzone) && maps\mp\_utility::isreallyalive(var_03) && distance2d(level.grnd_zone.origin,var_03.origin) < 300)
			{
				var_01[var_03.pers["team"]]++;
				var_03.ingrindzonepoints = var_03.ingrindzonepoints + var_00;
			}
		}

		if(var_01["axis"])
		{
			lib_036E::func_2B88("axis",var_00 * var_01["axis"]);
		}

		if(var_01["allies"])
		{
			lib_036E::func_2B88("allies",var_00 * var_01["allies"]);
		}

		if(var_01["axis"] == var_01["allies"])
		{
			foreach(var_03 in level.players)
			{
				if(isdefined(var_03.ingrindzone))
				{
					var_03.grndheadicon setshader("waypoint_captureneutral",14,14);
					var_03.grndheadicon setwaypoint(0,0,0,0);
					objective_icon(var_03.grndobjid,"waypoint_captureneutral");
				}
			}
		}
		else
		{
			foreach(var_03 in level.players)
			{
				if(isdefined(var_03.ingrindzone))
				{
					if(var_01[var_03.pers["team"]] > var_01[level.otherteam[var_03.pers["team"]]])
					{
						var_03.grndheadicon setshader("waypoint_defend",14,14);
						var_03.grndheadicon setwaypoint(0,0,0,0);
						objective_icon(var_03.grndobjid,"waypoint_defend");
						continue;
					}

					var_03.grndheadicon setshader("waypoint_capture",14,14);
					var_03.grndheadicon setwaypoint(0,0,0,0);
					objective_icon(var_03.grndobjid,"waypoint_capture");
				}
			}
		}

		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(1);
	}
}

//Function Number: 14
func_3A08()
{
	level endon("game_ended");
	level notify("reset_grnd_drops");
	level endon("reset_grnd_drops");
	level.grnd_previouscratetypes = [];
	for(;;)
	{
		var_00 = func_3A09();
		var_01 = 1;
		if(isdefined(var_00) && maps\mp\_utility::currentactivevehiclecount() < maps\mp\_utility::maxvehiclesallowed() && level.fauxvehiclecount + var_01 < maps\mp\_utility::maxvehiclesallowed() && level.numdropcrates < 8)
		{
			var_00 thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_EARNED_CAREPACKAGE");
			thread maps\mp\_utility::teamplayercardsplash("callout_earned_carepackage",var_00);
			var_00 thread maps\mp\_utility::leaderdialog(level.otherteam[var_00.team] + "_enemy_airdrop_assault_inbound",level.otherteam[var_00.team]);
			var_00 thread maps\mp\_utility::leaderdialog(var_00.team + "_friendly_airdrop_assault_inbound",var_00.team);
			maps\mp\_utility::playsoundonplayers("mp_war_objective_taken",var_00.team);
			maps\mp\_utility::playsoundonplayers("mp_war_objective_lost",level.otherteam[var_00.team]);
			var_02 = level.grnd_zone.origin + (randomintrange(-72,72),randomintrange(-72,72),0);
			var_03 = func_3A0A();
			if(issubstr(tolower(var_03),"juggernaut"))
			{
				level thread maps\mp\killstreaks\_airdrop::doc130flyby(var_00,var_02,randomfloat(360),var_03);
			}
			else if(var_03 == "mega")
			{
				level thread maps\mp\killstreaks\_airdrop::domegac130flyby(var_00,var_02,randomfloat(360),"airdrop_grnd",-360);
			}
			else
			{
				level thread maps\mp\killstreaks\_airdrop::doflyby(var_00,var_02,randomfloat(360),"airdrop_grnd",0,var_03);
			}

			var_04 = level.matchrules_droptime;
		}
		else
		{
			var_04 = 0.5;
		}

		maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_04);
	}
}

//Function Number: 15
func_3A09()
{
	var_00 = undefined;
	var_01 = 0;
	foreach(var_03 in level.players)
	{
		if(maps\mp\_utility::isreallyalive(var_03))
		{
			if(distance2d(level.grnd_zone.origin,var_03.origin) < 300 && var_03.ingrindzonepoints > var_01)
			{
				var_00 = var_03;
				var_01 = var_03.ingrindzonepoints;
			}
		}
	}

	return var_00;
}

//Function Number: 16
func_3A0A()
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

//Function Number: 17
func_3A0B(param_00)
{
	level waittill("game_ended");
	if(isdefined(param_00))
	{
		param_00.alpha = 0;
	}
}

//Function Number: 18
func_3A0C()
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

	level.grnd_dropzones["mp_seatown"][0] = (-1226,-1399,204);
	level.grnd_dropzones["mp_seatown"][1] = (1048,886,228);
	level.grnd_dropzones["mp_seatown"][2] = (-2086,1263,260);
	level.grnd_dropzones["mp_seatown"][3] = (-2297,-855,210);
	level.grnd_dropzones["mp_seatown"][4] = (-2261,-334,248);
	level.grnd_dropzones["mp_seatown"][5] = (-2048,512,248);
	level.grnd_dropzones["mp_seatown"][6] = (-1439,1065,72);
	level.grnd_dropzones["mp_seatown"][7] = (-410,982,127);
	level.grnd_dropzones["mp_seatown"][8] = (-666,-217,226);
	level.grnd_dropzones["mp_seatown"][9] = (-523,-875,280);
	level.grnd_dropzones["mp_seatown"][10] = (-345,-1449,254);
	level.grnd_dropzones["mp_seatown"][11] = (1167,-533,294);
	level.grnd_dropzones["mp_seatown"][12] = (367,991,179);
	level.grnd_dropzones["mp_seatown"][13] = (1106,219,292);
	level.grnd_dropzones["mp_dome"][0] = (97,898,-240);
	level.grnd_dropzones["mp_dome"][1] = (-226,1464,-231);
	level.grnd_dropzones["mp_dome"][2] = (-603,194,-358);
	level.grnd_dropzones["mp_dome"][3] = (814,-406,-335);
	level.grnd_dropzones["mp_dome"][4] = (5,1975,-231);
	level.grnd_dropzones["mp_dome"][5] = (-673,1100,-284);
	level.grnd_dropzones["mp_dome"][6] = (669,1028,-255);
	level.grnd_dropzones["mp_dome"][7] = (1231,807,-267);
	level.grnd_dropzones["mp_dome"][8] = (709,210,-342);
	level.grnd_dropzones["mp_dome"][9] = (1223,10,-336);
	level.grnd_dropzones["mp_dome"][10] = (-222,418,-333);
	level.grnd_dropzones["mp_dome"][11] = (501,-183,-330);
	level.grnd_dropzones["mp_plaza2"][0] = (221,440,754);
	level.grnd_dropzones["mp_plaza2"][1] = (155,1763,668);
	level.grnd_dropzones["mp_plaza2"][2] = (-430,1871,691);
	level.grnd_dropzones["mp_plaza2"][3] = (-1190,1759,668);
	level.grnd_dropzones["mp_plaza2"][4] = (-1273,1279,829);
	level.grnd_dropzones["mp_plaza2"][5] = (-593,1274,676);
	level.grnd_dropzones["mp_plaza2"][6] = (-251,1006,722);
	level.grnd_dropzones["mp_plaza2"][7] = (80,1343,676);
	level.grnd_dropzones["mp_plaza2"][8] = (397,-99,708);
	level.grnd_dropzones["mp_plaza2"][9] = (-1109,92,741);
	level.grnd_dropzones["mp_plaza2"][10] = (-280,-195,700);
	level.grnd_dropzones["mp_plaza2"][11] = (28,-1600,668);
	level.grnd_dropzones["mp_plaza2"][12] = (764,-1752,669);
	level.grnd_dropzones["mp_mogadishu"][0] = (1448,1945,39);
	level.grnd_dropzones["mp_mogadishu"][1] = (1499,-1193,15);
	level.grnd_dropzones["mp_mogadishu"][2] = (791,-880,16);
	level.grnd_dropzones["mp_mogadishu"][3] = (38,-1007,16);
	level.grnd_dropzones["mp_mogadishu"][4] = (-691,-260,22);
	level.grnd_dropzones["mp_mogadishu"][5] = (2,52,2);
	level.grnd_dropzones["mp_mogadishu"][6] = (664,69,12);
	level.grnd_dropzones["mp_mogadishu"][7] = (1676,251,-1);
	level.grnd_dropzones["mp_mogadishu"][8] = (2314,1860,63);
	level.grnd_dropzones["mp_mogadishu"][9] = (73,858,3);
	level.grnd_dropzones["mp_mogadishu"][10] = (710,837,16);
	level.grnd_dropzones["mp_mogadishu"][11] = (-549,829,2);
	level.grnd_dropzones["mp_mogadishu"][12] = (34,1850,84);
	level.grnd_dropzones["mp_mogadishu"][13] = (-778,2614,157);
	level.grnd_dropzones["mp_mogadishu"][14] = (-204,3206,152);
	level.grnd_dropzones["mp_mogadishu"][15] = (752,3189,148);
	level.grnd_dropzones["mp_mogadishu"][16] = (692,2354,95);
	level.grnd_dropzones["mp_paris"][0] = (-931,-921,110);
	level.grnd_dropzones["mp_paris"][1] = (1597,1768,47);
	level.grnd_dropzones["mp_paris"][2] = (716,1809,33);
	level.grnd_dropzones["mp_paris"][3] = (258,2074,36);
	level.grnd_dropzones["mp_paris"][4] = (459,1067,37);
	level.grnd_dropzones["mp_paris"][5] = (852,1350,118);
	level.grnd_dropzones["mp_paris"][6] = (1601,897,45);
	level.grnd_dropzones["mp_paris"][7] = (1286,420,41);
	level.grnd_dropzones["mp_paris"][8] = (1613,181,172);
	level.grnd_dropzones["mp_paris"][9] = (466,-752,67);
	level.grnd_dropzones["mp_paris"][10] = (994,-625,50);
	level.grnd_dropzones["mp_paris"][11] = (-211,-60,63);
	level.grnd_dropzones["mp_paris"][12] = (-742,177,133);
	level.grnd_dropzones["mp_paris"][13] = (-1532,100,250);
	level.grnd_dropzones["mp_paris"][14] = (-343,1922,121);
	level.grnd_dropzones["mp_paris"][15] = (-1127,1555,284);
	level.grnd_dropzones["mp_paris"][16] = (-2025,1327,316);
	level.grnd_dropzones["mp_paris"][17] = (-1039,841,187);
	level.grnd_dropzones["mp_exchange"][0] = (-614,1286,113);
	level.grnd_dropzones["mp_exchange"][1] = (182,1155,148);
	level.grnd_dropzones["mp_exchange"][2] = (1018,1254,120);
	level.grnd_dropzones["mp_exchange"][3] = (2182,1322,145);
	level.grnd_dropzones["mp_exchange"][4] = (655,815,13);
	level.grnd_dropzones["mp_exchange"][5] = (761,-312,-18);
	level.grnd_dropzones["mp_exchange"][6] = (761,-771,112);
	level.grnd_dropzones["mp_exchange"][7] = (635,-1450,110);
	level.grnd_dropzones["mp_exchange"][8] = (152,-1538,96);
	level.grnd_dropzones["mp_exchange"][9] = (303,-824,88);
	level.grnd_dropzones["mp_exchange"][10] = (-953,-768,45);
	level.grnd_dropzones["mp_exchange"][11] = (2392,1305,144);
	level.grnd_dropzones["mp_exchange"][12] = (1634,1329,151);
	level.grnd_dropzones["mp_exchange"][13] = (1315,743,159);
	level.grnd_dropzones["mp_bootleg"][0] = (-1432,1404,8);
	level.grnd_dropzones["mp_bootleg"][1] = (-1017,1787,-39);
	level.grnd_dropzones["mp_bootleg"][2] = (-590,1514,-43);
	level.grnd_dropzones["mp_bootleg"][3] = (-588,614,-12);
	level.grnd_dropzones["mp_bootleg"][4] = (-1732,84,11);
	level.grnd_dropzones["mp_bootleg"][5] = (-1809,-302,140);
	level.grnd_dropzones["mp_bootleg"][6] = (-1649,-1147,92);
	level.grnd_dropzones["mp_bootleg"][7] = (-884,-1035,-4);
	level.grnd_dropzones["mp_bootleg"][8] = (-719,-1673,60);
	level.grnd_dropzones["mp_bootleg"][9] = (-335,-2111,60);
	level.grnd_dropzones["mp_bootleg"][10] = (208,-1955,68);
	level.grnd_dropzones["mp_bootleg"][11] = (-198,-1726,60);
	level.grnd_dropzones["mp_bootleg"][12] = (100,-1101,-9);
	level.grnd_dropzones["mp_bootleg"][13] = (-427,-100,-8);
	level.grnd_dropzones["mp_bootleg"][14] = (949,-1132,-10);
	level.grnd_dropzones["mp_bootleg"][15] = (884,1182,-28);
	level.grnd_dropzones["mp_bootleg"][16] = (242,1194,-45);
	level.grnd_dropzones["mp_carbon"][0] = (-3330,-3392,3630);
	level.grnd_dropzones["mp_carbon"][1] = (-3635,-3735,3630);
	level.grnd_dropzones["mp_carbon"][2] = (-3625,-4189,3633);
	level.grnd_dropzones["mp_carbon"][3] = (-2992,-4339,3627);
	level.grnd_dropzones["mp_carbon"][4] = (-2925,-4999,3673);
	level.grnd_dropzones["mp_carbon"][5] = (-2573,-4771,3784);
	level.grnd_dropzones["mp_carbon"][6] = (-1705,-4643,3813);
	level.grnd_dropzones["mp_carbon"][7] = (-1799,-3957,3813);
	level.grnd_dropzones["mp_carbon"][8] = (-2141,-3647,3815);
	level.grnd_dropzones["mp_carbon"][9] = (-3212,-2879,3807);
	level.grnd_dropzones["mp_carbon"][10] = (-1623,-3339,3808);
	level.grnd_dropzones["mp_carbon"][11] = (-1223,-4234,3834);
	level.grnd_dropzones["mp_carbon"][12] = (-896,-4888,3944);
	level.grnd_dropzones["mp_carbon"][13] = (-228,-4535,3975);
	level.grnd_dropzones["mp_carbon"][14] = (-257,-3865,3956);
	level.grnd_dropzones["mp_carbon"][15] = (-215,-3260,3967);
	level.grnd_dropzones["mp_carbon"][16] = (-535,-3798,3966);
	level.grnd_dropzones["mp_hardhat"][0] = (2125,-364,266);
	level.grnd_dropzones["mp_hardhat"][1] = (1959,-772,352);
	level.grnd_dropzones["mp_hardhat"][2] = (1883,-1384,351);
	level.grnd_dropzones["mp_hardhat"][3] = (848,-1520,334);
	level.grnd_dropzones["mp_hardhat"][4] = (1326,-1380,342);
	level.grnd_dropzones["mp_hardhat"][5] = (-338,-1273,348);
	level.grnd_dropzones["mp_hardhat"][6] = (-821,-884,348);
	level.grnd_dropzones["mp_hardhat"][7] = (-920,-290,230);
	level.grnd_dropzones["mp_hardhat"][8] = (-463,-250,333);
	level.grnd_dropzones["mp_hardhat"][9] = (-741,208,245);
	level.grnd_dropzones["mp_hardhat"][10] = (-201,806,437);
	level.grnd_dropzones["mp_hardhat"][11] = (224,980,436);
	level.grnd_dropzones["mp_hardhat"][12] = (1125,656,255);
	level.grnd_dropzones["mp_hardhat"][13] = (1531,1241,364);
	level.grnd_dropzones["mp_hardhat"][14] = (1522,542,244);
	level.grnd_dropzones["mp_alpha"][0] = (-1979,1653,148);
	level.grnd_dropzones["mp_alpha"][1] = (-1392,1623,60);
	level.grnd_dropzones["mp_alpha"][2] = (-1697,1205,52);
	level.grnd_dropzones["mp_alpha"][3] = (-1671,692,54);
	level.grnd_dropzones["mp_alpha"][4] = (-572,-272,55);
	level.grnd_dropzones["mp_alpha"][5] = (634,-345,52);
	level.grnd_dropzones["mp_alpha"][6] = (391,121,60);
	level.grnd_dropzones["mp_alpha"][7] = (291,1271,60);
	level.grnd_dropzones["mp_alpha"][8] = (-459,868,52);
	level.grnd_dropzones["mp_alpha"][9] = (-353,1334,52);
	level.grnd_dropzones["mp_alpha"][10] = (-37,1637,52);
	level.grnd_dropzones["mp_alpha"][11] = (-5,2226,52);
	level.grnd_dropzones["mp_alpha"][12] = (-407,2198,196);
	level.grnd_dropzones["mp_village"][0] = (647,1891,332);
	level.grnd_dropzones["mp_village"][1] = (-26,1749,334);
	level.grnd_dropzones["mp_village"][2] = (104,1292,323);
	level.grnd_dropzones["mp_village"][3] = (-1064,1552,322);
	level.grnd_dropzones["mp_village"][4] = (-599,886,378);
	level.grnd_dropzones["mp_village"][5] = (-1038,569,317);
	level.grnd_dropzones["mp_village"][6] = (-1899,1217,336);
	level.grnd_dropzones["mp_village"][7] = (-1540,289,304);
	level.grnd_dropzones["mp_village"][8] = (-454,-277,270);
	level.grnd_dropzones["mp_village"][9] = (-1734,-790,365);
	level.grnd_dropzones["mp_village"][10] = (-1418,-1371,431);
	level.grnd_dropzones["mp_village"][11] = (-928,-749,417);
	level.grnd_dropzones["mp_village"][12] = (-861,-2105,408);
	level.grnd_dropzones["mp_village"][13] = (-191,-1550,400);
	level.grnd_dropzones["mp_village"][14] = (357,-678,245);
	level.grnd_dropzones["mp_village"][15] = (-216,295,223);
	level.grnd_dropzones["mp_village"][16] = (162,-199,229);
	level.grnd_dropzones["mp_village"][17] = (179,-3052,447);
	level.grnd_dropzones["mp_village"][18] = (510,-1790,375);
	level.grnd_dropzones["mp_village"][19] = (1089,-615,398);
	level.grnd_dropzones["mp_village"][20] = (1631,394,297);
	level.grnd_dropzones["mp_village"][21] = (1007,1385,337);
	level.grnd_dropzones["mp_village"][22] = (992,248,330);
	level.grnd_dropzones["mp_village"][23] = (551,732,386);
	level.grnd_dropzones["mp_lambeth"][0] = (-293,-1286,-180);
	level.grnd_dropzones["mp_lambeth"][1] = (-938,-785,-130);
	level.grnd_dropzones["mp_lambeth"][2] = (-375,-250,-187);
	level.grnd_dropzones["mp_lambeth"][3] = (-355,409,-196);
	level.grnd_dropzones["mp_lambeth"][4] = (161,-5,-181);
	level.grnd_dropzones["mp_lambeth"][5] = (682,-407,-197);
	level.grnd_dropzones["mp_lambeth"][6] = (694,263,-196);
	level.grnd_dropzones["mp_lambeth"][7] = (690,1158,-243);
	level.grnd_dropzones["mp_lambeth"][8] = (1181,801,-67);
	level.grnd_dropzones["mp_lambeth"][9] = (1281,1248,-257);
	level.grnd_dropzones["mp_lambeth"][10] = (2057,757,-249);
	level.grnd_dropzones["mp_lambeth"][11] = (1470,-1040,-109);
	level.grnd_dropzones["mp_lambeth"][12] = (1761,-258,-210);
	level.grnd_dropzones["mp_lambeth"][13] = (2800,-652,-186);
	level.grnd_dropzones["mp_lambeth"][14] = (2785,445,-244);
	level.grnd_dropzones["mp_lambeth"][15] = (2751,1090,-263);
	level.grnd_dropzones["mp_lambeth"][16] = (1535,1980,-214);
	level.grnd_dropzones["mp_lambeth"][17] = (1262,2602,-213);
	level.grnd_dropzones["mp_lambeth"][18] = (419,2218,-183);
	level.grnd_dropzones["mp_lambeth"][19] = (170,1631,-182);
	level.grnd_dropzones["mp_lambeth"][20] = (-606,1549,-201);
	level.grnd_dropzones["mp_lambeth"][21] = (-1199,1030,-196);
	level.grnd_dropzones["mp_radar"][0] = (-3482,-498,1222);
	level.grnd_dropzones["mp_radar"][1] = (-4263,-124,1229);
	level.grnd_dropzones["mp_radar"][2] = (-4006,827,1238);
	level.grnd_dropzones["mp_radar"][3] = (-3375,342,1222);
	level.grnd_dropzones["mp_radar"][4] = (-4623,531,1298);
	level.grnd_dropzones["mp_radar"][5] = (-5157,877,1200);
	level.grnd_dropzones["mp_radar"][6] = (-5950,1071,1305);
	level.grnd_dropzones["mp_radar"][7] = (-6509,1660,1299);
	level.grnd_dropzones["mp_radar"][8] = (-7013,2955,1359);
	level.grnd_dropzones["mp_radar"][9] = (-6333,3473,1421);
	level.grnd_dropzones["mp_radar"][10] = (-5675,2923,1388);
	level.grnd_dropzones["mp_radar"][11] = (-7119,4357,1380);
	level.grnd_dropzones["mp_radar"][12] = (-5487,4077,1356);
	level.grnd_dropzones["mp_radar"][13] = (-5736,2960,1407);
	level.grnd_dropzones["mp_radar"][14] = (-4908,3281,1225);
	level.grnd_dropzones["mp_radar"][15] = (-4421,4071,1268);
	level.grnd_dropzones["mp_radar"][16] = (-4979,1816,1205);
	level.grnd_dropzones["mp_radar"][17] = (-4874,2306,1223);
	level.grnd_dropzones["mp_interchange"][0] = (2465,-402,149);
	level.grnd_dropzones["mp_interchange"][1] = (2128,199,68);
	level.grnd_dropzones["mp_interchange"][2] = (1280,1263,126);
	level.grnd_dropzones["mp_interchange"][3] = (762,1747,114);
	level.grnd_dropzones["mp_interchange"][4] = (-9,1836,38);
	level.grnd_dropzones["mp_interchange"][5] = (-284,1171,159);
	level.grnd_dropzones["mp_interchange"][6] = (-1028,944,31);
	level.grnd_dropzones["mp_interchange"][7] = (-256,264,126);
	level.grnd_dropzones["mp_interchange"][8] = (462,-463,158);
	level.grnd_dropzones["mp_interchange"][9] = (1029,-1045,179);
	level.grnd_dropzones["mp_interchange"][10] = (1760,-1434,142);
	level.grnd_dropzones["mp_interchange"][11] = (1538,-361,142);
	level.grnd_dropzones["mp_interchange"][12] = (1150,-2977,171);
	level.grnd_dropzones["mp_interchange"][13] = (371,-2883,209);
	level.grnd_dropzones["mp_interchange"][14] = (399,-2149,220);
	level.grnd_dropzones["mp_underground"][0] = (-602,3072,-68);
	level.grnd_dropzones["mp_underground"][1] = (-285,2551,-215);
	level.grnd_dropzones["mp_underground"][2] = (574,2656,-40);
	level.grnd_dropzones["mp_underground"][3] = (-627,1579,-196);
	level.grnd_dropzones["mp_underground"][4] = (28,1556,-196);
	level.grnd_dropzones["mp_underground"][5] = (727,1615,-196);
	level.grnd_dropzones["mp_underground"][6] = (-1491,1268,-196);
	level.grnd_dropzones["mp_underground"][7] = (-1370,1757,-196);
	level.grnd_dropzones["mp_underground"][8] = (-1259,599,-156);
	level.grnd_dropzones["mp_underground"][9] = (-959,-26,60);
	level.grnd_dropzones["mp_underground"][10] = (-303,-562,60);
	level.grnd_dropzones["mp_underground"][11] = (193,-922,60);
	level.grnd_dropzones["mp_underground"][12] = (305,817,-68);
	level.grnd_dropzones["mp_underground"][13] = (-276,370,-68);
	level.grnd_dropzones["mp_bravo"][0] = (-1359,608,975);
	level.grnd_dropzones["mp_bravo"][1] = (-1686,313,991);
	level.grnd_dropzones["mp_bravo"][2] = (-1228,41,976);
	level.grnd_dropzones["mp_bravo"][3] = (-732,-715,1032);
	level.grnd_dropzones["mp_bravo"][4] = (31,-771,1038);
	level.grnd_dropzones["mp_bravo"][5] = (986,-833,1116);
	level.grnd_dropzones["mp_bravo"][6] = (1800,-577,1229);
	level.grnd_dropzones["mp_bravo"][7] = (1588,-55,1181);
	level.grnd_dropzones["mp_bravo"][8] = (619,916,1175);
	level.grnd_dropzones["mp_bravo"][9] = (-129,1310,1228);
	level.grnd_dropzones["mp_bravo"][10] = (-726,1272,1268);
	level.grnd_dropzones["mp_bravo"][11] = (-741,752,1053);
	level.grnd_dropzones["mp_bravo"][12] = (6,-136,1282);
}