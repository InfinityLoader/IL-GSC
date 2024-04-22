/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\killstreaks\streak_mp_solar.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 30
 * Decompile Time: 470 ms
 * Timestamp: 4/22/2024 2:12:48 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.solar_killstreak_duration = 30;
	level.solar_fire_fx = loadfx("vfx/fire/fire_xsglow_runner_5s");
	level.solar_reflector_sfx = "mp_solar_array_player";
	level.solar_reflector_target_sfx = "mp_solar_array_target";
	level.killstreakfuncs["mp_solar"] = ::tryusesolarreflector;
	level.mapkillstreak = "mp_solar";
	level.mapkillstreakpickupstring = &"MP_SOLAR_MAP_KILLSTREAK_PICKUP";
	level.mapkillstreakdamagefeedbacksound = ::handledamagefeedbacksound;
	level.mapcustombotkillstreakfunc = ::setupbotsformapkillstreak;
	level.killstreakwieldweapons["killstreak_solar_mp"] = "mp_solar";
}

//Function Number: 2
setupbotsformapkillstreak()
{
	level thread maps\mp\bots\_bots_ks::bot_register_killstreak_func("mp_solar",::maps\mp\bots\_bots_ks::bot_killstreak_never_use,::maps\mp\bots\_bots_ks::bot_killstreak_do_not_use);
}

//Function Number: 3
tryusesolarreflector(param_00,param_01)
{
	if(isdefined(level.solar_reflector_player))
	{
		self iprintlnbold(&"MP_SOLAR_REFLECTOR_IN_USE");
		return 0;
	}

	if(maps\mp\_utility::isusingremote())
	{
		return 0;
	}

	if(maps\mp\_utility::isairdenied())
	{
		return 0;
	}

	if(maps\mp\_utility::isemped())
	{
		return 0;
	}

	var_02 = maps\mp\killstreaks\_killstreaks::initridekillstreak();
	if(var_02 != "success")
	{
		return 0;
	}

	maps\mp\_utility::setusingremote("mp_solar");
	var_02 = setsolarreflectorplayer(self);
	if(isdefined(var_02) && var_02)
	{
		maps\mp\_matchdata::logkillstreakevent("mp_solar",self.origin);
	}
	else if(maps\mp\_utility::isusingremote())
	{
		maps\mp\_utility::clearusingremote();
	}

	return isdefined(var_02) && var_02;
}

//Function Number: 4
setsolarreflectorplayer(param_00)
{
	self endon("solar_reflector_player_removed");
	level.solar_reflector_player = param_00;
	thread maps\mp\_utility::teamplayercardsplash("used_mp_solar",param_00);
	thread onplayerconnect();
	thread setupplayerdeath();
	param_00 thread overlay();
	param_00 thread runbeam();
	param_00 thread removesolarreflectorplayeraftertime(level.solar_killstreak_duration);
	param_00 thread removesolarreflectorplayerwatch();
	param_00 thread removesolarreflectorlevelwatch();
	param_00 thread removesolarreflectorplayeroncommand();
	return 1;
}

//Function Number: 5
beamminimap(param_00)
{
	var_01 = "compassping_orbitallaser_friendly";
	var_02 = "compassping_orbitallaser_hostile";
	var_03 = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(var_03,"invisible",(0,0,0));
	objective_onentity(var_03,param_00);
	objective_state(var_03,"active");
	if(level.teambased)
	{
		objective_team(var_03,self.team);
	}
	else
	{
		objective_player(var_03,self getentitynumber());
	}

	objective_icon(var_03,var_01);
	var_04 = var_03;
	var_03 = maps\mp\gametypes\_gameobjects::getnextobjid();
	objective_add(var_03,"invisible",(0,0,0));
	objective_onentity(var_03,param_00);
	objective_state(var_03,"active");
	if(level.teambased)
	{
		objective_team(var_03,level.otherteam[self.team]);
	}
	else
	{
		objective_playerenemyteam(var_03,self getentitynumber());
	}

	objective_icon(var_03,var_02);
	var_05 = var_03;
	level waittill("solar_reflector_player_removed");
	maps\mp\_utility::_objective_delete(var_04);
	maps\mp\_utility::_objective_delete(var_05);
}

//Function Number: 6
beamsounds(param_00,param_01)
{
	wait 0.05;
	param_01 playloopsound(level.solar_reflector_target_sfx);
	param_00 playloopsound(level.solar_reflector_sfx);
	playsoundatpos(param_00.origin,"array_beam_start");
	level waittill("solar_reflector_player_removed");
	playsoundatpos(param_00.origin,"array_beam_stop");
	param_01 stoploopsound();
	param_00 stoploopsound();
}

//Function Number: 7
runbeam()
{
	var_00 = common_scripts\utility::getstruct("solar_cam_pos","targetname");
	var_01 = common_scripts\utility::getstruct("solar_beam_pos","targetname");
	var_02 = common_scripts\utility::getstruct("solar_ground_pos","targetname");
	var_03 = getgroundent(var_02);
	var_04 = getcameraent(var_00,var_02);
	thread playersetcamera(var_04);
	var_05 = getbeament(var_01,var_02);
	thread beamminimap(var_03);
	thread beamsounds(var_04,var_03);
	runbeamupdate(var_05,var_04,var_03);
	var_05.killcament delete();
	var_05 delete();
	var_04 delete();
	var_03 delete();
}

//Function Number: 8
getcameraent(param_00,param_01)
{
	var_02 = spawn("script_model",param_00.origin);
	var_02.angles = vectortoangles(param_01.origin - param_00.origin);
	var_02 setmodel("tag_player");
	return var_02;
}

//Function Number: 9
getgroundent(param_00)
{
	var_01 = spawn("script_model",param_00.origin);
	var_01.angles = (0,0,0);
	var_01 setmodel("tag_origin");
	return var_01;
}

//Function Number: 10
playersetcamera(param_00)
{
	param_00 endon("death");
	self playerlinkweaponviewtodelta(param_00,"tag_player",1,40,40,12,10);
	self setplayerangles(param_00 gettagangles("tag_player"));
	self setclientomnvar("fov_scale",0.2);
	self thermalvisionfofoverlayon();
	for(;;)
	{
		self enableslowaim(0.05,0.05);
		level waittill("host_migration_begin");
		wait 0.05;
		self setclientomnvar("fov_scale",0.2);
		self thermalvisionfofoverlayon();
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
	}
}

//Function Number: 11
getbeament(param_00,param_01)
{
	var_02 = spawn("script_model",param_00.origin);
	var_02.angles = vectortoangles(param_01.origin - param_00.origin);
	var_02 setmodel("tag_laser");
	var_02 laseron("solar_laser");
	var_03 = anglestoforward(var_02.angles) * 5000 - (0,0,100);
	var_04 = spawn("script_model",param_00.origin + var_03);
	var_04.angles = var_02.angles;
	var_04 linkto(var_02);
	var_02.killcament = var_04;
	return var_02;
}

//Function Number: 12
beamgroundfx(param_00)
{
	param_00 endon("death");
	var_01 = undefined;
	for(;;)
	{
		wait 0.05;
		if(!isdefined(param_00.surfacetype))
		{
			continue;
		}

		var_02 = beamgetgroundfx(param_00.surfacetype);
		if(!isdefined(var_01) || var_01 != var_02)
		{
			if(isdefined(var_01))
			{
				stopfxontag(var_01,param_00,"tag_origin");
			}

			playfxontag(var_02,param_00,"tag_origin");
			var_01 = var_02;
		}
	}
}

//Function Number: 13
beamgetgroundfx(param_00)
{
	switch(param_00)
	{
		case "water_waist":
		case "water":
			return common_scripts\utility::getfx("steam_column_rising");

		default:
			return common_scripts\utility::getfx("fx_flare_solar");
	}
}

//Function Number: 14
runbeamupdate(param_00,param_01,param_02)
{
	self endon("solar_reflector_player_removed");
	var_03 = 300;
	var_04 = 20000;
	var_05 = spawnstruct();
	var_05.origin = param_02.origin;
	var_06 = 0;
	for(;;)
	{
		var_07 = self getplayerangles();
		var_07 = (var_07[0],var_07[1],0);
		var_09 = anglestoforward(var_07);
		var_0A = abs(param_01.origin[2] - var_05.origin[2] / var_09[2]);
		var_0B = param_01.origin + var_09 * var_0A;
		var_0C = distance2d(var_0B,var_05.origin);
		if(var_0C <= var_03 * 0.05)
		{
			var_05.origin = var_0B;
		}
		else
		{
			var_0D = var_0B - var_05.origin;
			var_0D = vectornormalize(var_0D);
			var_05.origin = var_05.origin + var_0D * var_03 * 0.05;
		}

		var_0E = vectornormalize(var_05.origin - param_00.origin);
		param_00 rotateto(vectortoangles(var_0E),0.1);
		var_0F = param_00.origin;
		var_10 = var_0F + var_0E * var_04;
		var_11 = bullettrace(var_0F,var_10,0);
		param_02 moveto(var_11["position"],0.1);
		param_02.surfacetype = var_11["surfacetype"];
		param_02.killcament = param_00.killcament;
		param_02 radiusdamage(param_02.origin,128,8,2,self,"MOD_EXPLOSIVE","killstreak_solar_mp");
		wait 0.05;
	}
}

//Function Number: 15
handledamagefeedbacksound()
{
	self.shouldloopdamagefeedback = 1;
	self.damagefeedbacktimer = 10;
	self playlocalsound("MP_solar_hit_alert");
	self playrumblelooponentity("damage_light");
	while(self.damagefeedbacktimer > 0)
	{
		self.damagefeedbacktimer--;
		wait(0.05);
	}

	self stoprumble("damage_light");
	self stoplocalsound("MP_solar_hit_alert");
	self.shouldloopdamagefeedback = undefined;
}

//Function Number: 16
removesolarreflectorplayeroncommand()
{
	self endon("solar_reflector_player_removed");
	for(;;)
	{
		var_00 = 0;
		while(self usebuttonpressed())
		{
			var_00 = var_00 + 0.05;
			if(var_00 > 0.75)
			{
				level thread removesolarreflectorplayer(self);
				return;
			}

			wait 0.05;
		}

		wait 0.05;
	}
}

//Function Number: 17
removesolarreflectorplayerwatch()
{
	self endon("solar_reflector_player_removed");
	common_scripts\utility::waittill_any("disconnect","joined_team","joined_spectators","spawned","killstreak_exit");
	level thread removesolarreflectorplayer(self);
}

//Function Number: 18
removesolarreflectorlevelwatch()
{
	self endon("solar_reflector_player_removed");
	level waittill("game_cleanup");
	level thread removesolarreflectorplayer(self);
}

//Function Number: 19
removesolarreflectorplayeraftertime(param_00)
{
	self endon("solar_reflector_player_removed");
	wait(1);
	if(maps\mp\_utility::_hasperk("specialty_blackbox") && isdefined(self.specialty_blackbox_bonus))
	{
		param_00 = param_00 * self.specialty_blackbox_bonus;
	}

	thread solarrelectortimer(param_00);
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(param_00);
	level thread removesolarreflectorplayer(self);
}

//Function Number: 20
solarrelectortimer(param_00)
{
	self endon("solar_reflector_player_removed");
	var_01 = gettime() + param_00 * 1000;
	for(;;)
	{
		self setclientomnvar("ui_solar_beam_timer",var_01);
		level waittill("host_migration_begin");
		var_02 = maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
		var_01 = var_01 + var_02;
	}
}

//Function Number: 21
removesolarreflectorplayer(param_00)
{
	param_00 notify("solar_reflector_player_removed");
	level notify("solar_reflector_player_removed");
	waittillframeend;
	if(isdefined(param_00))
	{
		param_00 maps\mp\_utility::clearusingremote();
		param_00 show();
		param_00 unlink();
		param_00 thermalvisionfofoverlayoff();
		param_00 setblurforplayer(0,0);
		param_00 setclientomnvar("ui_solar_beam",0);
		param_00 disableslowaim();
		param_00 setclientomnvar("fov_scale",1);
	}

	level.solar_reflector_player = undefined;
}

//Function Number: 22
overlay()
{
	self endon("disconnect");
	level endon("solar_reflector_player_removed");
	wait(1);
	self setblurforplayer(1.2,0);
	self setclientomnvar("ui_solar_beam",1);
}

//Function Number: 23
onplayerconnect()
{
	level notify("solarOnPlayerConnect");
	level endon("solarOnPlayerConnect");
	level endon("solar_reflector_player_removed");
	for(;;)
	{
		level waittill("connected",var_00);
		var_00.prekilledfunc = ::playerprekilled;
		var_00 thread onplayerspawned();
		var_00 thread playerimmunetofire();
	}
}

//Function Number: 24
onplayerspawned()
{
	level notify("solarOnPlayerSpawned");
	level endon("solarOnPlayerSpawned");
	level endon("solar_reflector_player_removed");
	for(;;)
	{
		self waittill("player_spawned");
		self.hideondeath = undefined;
	}
}

//Function Number: 25
setupplayerdeath()
{
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01) || var_01 == level.solar_reflector_player)
		{
			continue;
		}

		var_01.prekilledfunc = ::playerprekilled;
		var_01 thread onplayerspawned();
	}
}

//Function Number: 26
playerplayvaporizefx()
{
	self.hideondeath = 1;
	var_00 = (0,0,30);
	var_01 = self getstance();
	if(var_01 == "crouch")
	{
		var_00 = (0,0,20);
	}
	else if(var_01 == "prone")
	{
		var_00 = (0,0,10);
	}

	playfx(common_scripts\utility::getfx("solar_killstreak_death"),self.origin + var_00);
}

//Function Number: 27
playerprekilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(param_05 == "killstreak_solar_mp")
	{
		playerplayvaporizefx();
	}
}

//Function Number: 28
playerimmunetofire()
{
	self endon("disconnect");
	self.solarimmunefire = 1;
	wait(5);
	self.solarimmunefire = undefined;
}

//Function Number: 29
beamstartfires(param_00)
{
	level endon("solar_reflector_player_removed");
	var_01 = spawnfx(level.solar_fire_fx,(0,0,0));
	var_02 = (0,0,0);
	var_03 = gettime();
	for(;;)
	{
		wait 0.05;
		var_04 = distance2dsquared(param_00.origin,var_02);
		var_05 = var_03 - gettime() / 1000;
		if(var_04 > 2500 || var_05 > 5)
		{
			var_02 = param_00.origin;
			if(!isdefined(param_00.surfacetype) || !maps\mp\_utility::isstrstart(param_00.surfacetype,"water_"))
			{
				level thread fireatposition(var_02,self);
			}

			var_03 = gettime();
		}
	}
}

//Function Number: 30
fireatposition(param_00,param_01)
{
	playfx(level.solar_fire_fx,param_00);
	var_02 = gettime() + 5000;
	while(gettime() < var_02)
	{
		foreach(var_04 in level.players)
		{
			if(isdefined(var_04.solarimmunefire))
			{
				continue;
			}

			if(var_04.origin[2] < param_00[2] - 5)
			{
				continue;
			}

			if(var_04.origin[2] > param_00[2] + 80)
			{
				continue;
			}

			var_05 = distance2dsquared(var_04.origin,param_00);
			if(var_05 < 4900)
			{
				var_04 dodamage(4,param_00,param_01,param_01,"MOD_EXPLOSIVE","killstreak_solar_mp");
			}
		}

		wait(0.1);
	}
}