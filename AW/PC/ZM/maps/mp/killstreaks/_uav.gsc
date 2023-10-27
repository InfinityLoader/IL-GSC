/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/killstreaks/_uav.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 512 ms
 * Timestamp: 10/27/2023 2:10:02 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["uav_explode"] = loadfx("vfx/explosion/vehicle_uav_explosion");
	level._effect["uav_exit"] = loadfx("vfx/trail/smoketrail_uav");
	level._effect["uav_trail"] = loadfx("vfx/trail/smoketrail_uav");
	level.killstreakfuncs["uav"] = ::tryuseuav;
	level.killstreakfuncs["uav_support"] = ::tryuseuav;
	level.killstreakfuncs["counter_uav"] = ::tryuseuav;
	var_00 = getentarray("minimap_corner","targetname");
	if(var_00.size)
	{
		var_01 = maps\mp\gametypes\_spawnlogic::findboxcenter(var_00[0].origin,var_00[1].origin);
	}
	else
	{
		var_01 = (0,0,0);
	}

	level.uavrig = spawn("script_model",var_01);
	level.uavrig setmodel("c130_zoomrig");
	level.uavrig.angles = (0,115,0);
	level.uavrig hide();
	level.uavrig.targetname = "uavrig_script_model";
	level.uavrig thread rotateuavrig();
	if(level.teambased)
	{
		level.radarmode["allies"] = "normal_radar";
		level.radarmode["axis"] = "normal_radar";
		level.activeuavs["allies"] = 0;
		level.activeuavs["axis"] = 0;
		level.activecounteruavs["allies"] = 0;
		level.activecounteruavs["axis"] = 0;
		level.uavmodels["allies"] = [];
		level.uavmodels["axis"] = [];
	}
	else
	{
		level.radarmode = [];
		level.activeuavs = [];
		level.activecounteruavs = [];
		level.uavmodels = [];
	}

	level thread onplayerconnect();
	level thread uavtracker();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(!level.teambased)
		{
			level.activeuavs[var_00.guid] = 0;
			level.activeuavs[var_00.guid + "_radarStrength"] = 0;
			level.activecounteruavs[var_00.guid] = 0;
			level.radarmode[var_00.guid] = "normal_radar";
		}

		var_00 thread onplayerspawned();
	}
}

//Function Number: 3
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		level notify("uav_update");
	}
}

//Function Number: 4
rotateuavrig()
{
	for(;;)
	{
		self rotateyaw(-360,60);
		wait(60);
	}
}

//Function Number: 5
playtrailfx()
{
	self endon("death");
	level endon("game_ended");
	playfxontag(level._effect["uav_trail"],self,"tag_origin");
}

//Function Number: 6
launchuav(param_00,param_01,param_02,param_03)
{
	var_04 = spawn("script_model",level.uavrig gettagorigin("tag_origin"));
	var_04.modules = param_03;
	var_04.value = 1;
	if(common_scripts\utility::array_contains(var_04.modules,"uav_advanced_updates"))
	{
		var_04.value = 2;
	}

	if(common_scripts\utility::array_contains(var_04.modules,"uav_enemy_direction"))
	{
		var_04.value = 3;
	}

	if(common_scripts\utility::array_contains(var_04.modules,"uav_scrambler"))
	{
		var_05 = 1;
	}
	else
	{
		var_05 = 0;
	}

	var_04 setmodel("uav_drone_static");
	var_04 thread playtrailfx();
	var_04 thread maps\mp\gametypes\_damage::setentitydamagecallback(1000,undefined,::uavondeath,undefined,1);
	var_04.team = param_01;
	var_04.owner = param_00;
	var_04.timetoadd = 0;
	var_04.orbit = common_scripts\utility::array_contains(var_04.modules,"uav_orbit");
	var_04.paintoutline = common_scripts\utility::array_contains(var_04.modules,"uav_paint_outline");
	var_04.assistpoints = common_scripts\utility::array_contains(var_04.modules,"uav_assist_points");
	var_04 common_scripts\utility::make_entity_sentient_mp(param_01);
	var_04 thread handleincomingstinger();
	var_04.streakcustomization = param_00.streakcustomization;
	var_04 adduavmodel();
	thread flyin(var_04);
	var_04 thread updateuavmodelvisibility();
	var_04 thread maps\mp\killstreaks\_killstreaks::updateaerialkillstreakmarker();
	var_04 addactiveuav();
	if(var_05)
	{
		var_04 addactivecounteruav();
	}

	if(isdefined(level.activeuavs[param_01]))
	{
		foreach(var_07 in level.uavmodels[param_01])
		{
			if(var_07 == var_04)
			{
				continue;
			}

			if(var_05)
			{
				var_07.timetoadd = var_07.timetoadd + 5;
				continue;
			}

			if(!var_05)
			{
				var_07.timetoadd = var_07.timetoadd + 5;
			}
		}
	}

	wait 0.05;
	level notify("uav_update");
	var_09 = 30;
	if(common_scripts\utility::array_contains(var_04.modules,"uav_increased_time"))
	{
		var_09 = var_09 + 15;
	}

	var_04 waittill_notify_or_timeout_hostmigration_pause("death",var_09);
	if(var_04.damagetaken < var_04.maxhealth)
	{
		var_04 unlink();
		var_0A = var_04.origin + anglestoforward(var_04.angles) * 20000;
		var_04 moveto(var_0A,60);
		playfxontag(common_scripts\utility::getfx("uav_exit"),var_04,"tag_origin");
		var_04 waittill_notify_or_timeout_hostmigration_pause("death",3);
		if(var_04.damagetaken < var_04.maxhealth)
		{
			var_04 notify("leaving");
			var_04.isleaving = 1;
			var_04 moveto(var_0A,4,4,0);
		}

		var_04 waittill_notify_or_timeout_hostmigration_pause("death",4 + var_04.timetoadd);
	}

	if(var_05)
	{
		var_04 removeactivecounteruav();
	}

	var_04 removeactiveuav();
	var_04 delete();
	var_04 removeuavmodel();
	level notify("uav_update");
}

//Function Number: 7
flyin(param_00)
{
	param_00 hide();
	var_01 = randomintrange(3000,5000);
	if(isdefined(level.spawnpoints))
	{
		var_02 = level.spawnpoints;
	}
	else
	{
		var_02 = level.startspawnpoints;
	}

	var_03 = var_02[0];
	foreach(var_05 in var_02)
	{
		if(var_05.origin[2] < var_03.origin[2])
		{
			var_03 = var_05;
		}
	}

	var_07 = var_03.origin[2];
	var_08 = level.uavrig.origin[2];
	if(var_07 < 0)
	{
		var_08 = var_08 + var_07 * -1;
		var_07 = 0;
	}

	var_09 = var_08 - var_07;
	if(var_09 + var_01 > 8100)
	{
		var_01 = var_01 - var_09 + var_01 - 8100;
	}

	var_0A = randomint(360);
	var_0B = randomint(2000) + 5000;
	var_0C = cos(var_0A) * var_0B;
	var_0D = sin(var_0A) * var_0B;
	var_0E = vectornormalize((var_0C,var_0D,var_01));
	var_0E = var_0E * randomintrange(6000,7000);
	param_00 linkto(level.uavrig,"tag_origin",var_0E,(0,var_0A - 90,135));
	wait 0.05;
	var_0F = param_00.origin;
	param_00 unlink();
	param_00.origin = var_0F + anglestoforward(param_00.angles) * -20000;
	param_00 moveto(var_0F,4,0,2);
	wait(4);
	if(isdefined(param_00))
	{
		param_00 linkto(level.uavrig,"tag_origin");
	}
}

//Function Number: 8
waittill_notify_or_timeout_hostmigration_pause(param_00,param_01)
{
	self endon(param_00);
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(param_01);
}

//Function Number: 9
updateuavmodelvisibility()
{
	self endon("death");
	for(;;)
	{
		level common_scripts\utility::waittill_either("joined_team","uav_update");
		self hide();
		foreach(var_01 in level.players)
		{
			if(level.teambased)
			{
				if(var_01.team != self.team && !self.orbit)
				{
					self showtoplayer(var_01);
				}

				continue;
			}

			if((isdefined(self.owner) && var_01 == self.owner) || self.orbit)
			{
				continue;
			}

			self showtoplayer(var_01);
		}
	}
}

//Function Number: 10
uavondeath(param_00,param_01,param_02,param_03)
{
	self hide();
	self notify("death");
	var_04 = anglestoright(self.angles) * 200;
	playfx(common_scripts\utility::getfx("uav_explode"),self.origin,var_04);
	playsoundatpos(self.origin,"uav_air_death");
	maps\mp\gametypes\_damage::onkillstreakkilled(param_00,param_01,param_02,param_03,"uav_destroyed",undefined,"callout_destroyed_uav",1);
}

//Function Number: 11
tryuseuav(param_00,param_01)
{
	if(isdefined(self.pers["killstreaks"][self.killstreakindexweapon].streakname))
	{
		var_02 = self.pers["killstreaks"][self.killstreakindexweapon].streakname;
	}
	else
	{
		var_02 = "uav_support";
	}

	if(isdefined(level.ishorde) && level.ishorde && self.killstreakindexweapon == 1)
	{
		self notify("used_horde_uav");
	}

	return useuav(var_02,param_01);
}

//Function Number: 12
useuav(param_00,param_01)
{
	maps\mp\_matchdata::logkillstreakevent(param_00,self.origin);
	var_02 = self.pers["team"];
	level thread launchuav(self,var_02,param_00,param_01);
	return 1;
}

//Function Number: 13
uavtracker()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("uav_update");
		if(level.teambased)
		{
			updateteamuavstatus("allies");
			updateteamuavstatus("axis");
			continue;
		}

		updateplayersuavstatus();
	}
}

//Function Number: 14
_getradarstrength(param_00,param_01,param_02)
{
	var_03 = 0;
	var_04 = 0;
	foreach(var_06 in level.uavmodels[param_00])
	{
		var_03 = var_03 + var_06.value;
	}

	foreach(var_06 in level.uavmodels[level.otherteam[param_00]])
	{
		if(var_06.uavtype != "counter")
		{
			continue;
		}

		var_04 = var_04 + var_06.value;
	}

	if(var_04 > 0)
	{
		var_0A = -3;
	}
	else
	{
		var_0A = var_04;
	}

	var_0B = getuavstrengthmin();
	var_0C = getuavstrengthmax();
	if(var_0A <= var_0B)
	{
		var_0A = var_0B;
	}
	else if(var_0A >= var_0C)
	{
		var_0A = var_0C;
	}

	return var_0A;
}

//Function Number: 15
_getteampaintoutline(param_00)
{
	var_01 = 0;
	var_02 = 0;
	foreach(var_04 in level.uavmodels[param_00])
	{
		if(var_04.paintoutline)
		{
			var_01 = var_01 + var_04.value;
		}
	}

	if(var_01 > 0)
	{
		var_02 = 1;
	}
	else
	{
		var_02 = 0;
	}

	return var_02;
}

//Function Number: 16
_getpaintoutline(param_00)
{
	var_01 = 0;
	var_02 = 0;
	foreach(var_04 in level.uavmodels)
	{
		if(isdefined(var_04.owner) && var_04.owner == param_00 && var_04.paintoutline)
		{
			var_01 = var_01 + var_04.value;
		}
	}

	if(var_01 > 0)
	{
		var_02 = 1;
	}
	else
	{
		var_02 = 0;
	}

	return var_02;
}

//Function Number: 17
updateteamuavstatus(param_00)
{
	var_01 = _getradarstrength(param_00);
	var_02 = _getteampaintoutline(param_00);
	updateteampaintoutline(param_00,var_02);
	setteamradarstrength(param_00,var_01);
	if(var_01 >= getuavstrengthlevelneutral())
	{
		updateteamradarblocked(param_00,0);
		unblockteamradar(param_00);
	}
	else
	{
		updateteamradarblocked(param_00,1);
		blockteamradar(param_00);
	}

	if(var_01 <= getuavstrengthlevelneutral())
	{
		setteamradarwrapper(param_00,0);
		updateteamuavtype(param_00);
		return;
	}

	if(var_01 >= getuavstrengthlevelshowenemyfastsweep())
	{
		level.radarmode[param_00] = "fast_radar";
	}
	else
	{
		level.radarmode[param_00] = "normal_radar";
	}

	updateteamuavtype(param_00);
	setteamradarwrapper(param_00,1);
}

//Function Number: 18
updateplayersuavstatus()
{
	var_00 = getuavstrengthmin();
	var_01 = getuavstrengthmax();
	var_02 = getuavstrengthlevelshowenemydirectional();
	foreach(var_04 in level.players)
	{
		var_05 = level.activeuavs[var_04.guid + "_radarStrength"];
		var_06 = _getpaintoutline(var_04);
		updatepaintoutline(var_04,var_06);
		foreach(var_08 in level.players)
		{
			if(var_08 == var_04)
			{
				continue;
			}

			var_09 = level.activecounteruavs[var_08.guid];
			if(var_09 > 0)
			{
				var_05 = -3;
				break;
			}
		}

		if(var_05 <= var_00)
		{
			var_05 = var_00;
		}
		else if(var_05 >= var_01)
		{
			var_05 = var_01;
		}

		var_04.radarstrength = var_05;
		if(var_05 >= getuavstrengthlevelneutral())
		{
			updateplayerradarblocked(var_04,0);
			var_04.isradarblocked = 0;
		}
		else
		{
			updateplayerradarblocked(var_04,1);
			var_04.isradarblocked = 1;
		}

		if(var_05 <= getuavstrengthlevelneutral())
		{
			var_04.hasradar = 0;
			var_04.radarshowenemydirection = 0;
			continue;
		}

		if(var_05 >= getuavstrengthlevelshowenemyfastsweep())
		{
			var_04.radarmode = "fast_radar";
		}
		else
		{
			var_04.radarmode = "normal_radar";
		}

		var_04.radarshowenemydirection = var_05 >= var_02;
		var_04.hasradar = 1;
	}
}

//Function Number: 19
updateteamuavtype(param_00,param_01)
{
	var_02 = _getradarstrength(param_00) >= getuavstrengthlevelshowenemydirectional();
	foreach(var_04 in level.players)
	{
		if(var_04.team == "spectator")
		{
			continue;
		}

		var_05 = maps\mp\gametypes\_gameobjects::getenemyteam(var_04.team);
		var_04.radarmode = level.radarmode[var_04.team];
		var_04.enemyradarmode = level.radarmode[var_05];
		if(var_04.team == param_00)
		{
			var_04.radarshowenemydirection = var_02;
		}
	}
}

//Function Number: 20
updateteampaintoutline(param_00,param_01)
{
	level endon("game_ended");
	foreach(var_03 in level.players)
	{
		if(isdefined(var_03) && var_03.team == param_00)
		{
			var_03 playersetupuavpaintoutline(param_01);
		}
	}
}

//Function Number: 21
updatepaintoutline(param_00,param_01)
{
	level endon("game_ended");
	param_00 playersetupuavpaintoutline(param_01);
}

//Function Number: 22
playersetupuavpaintoutline(param_00)
{
	if(param_00)
	{
		if(!isdefined(self.uav_paint_effect))
		{
			self.uav_paint_effect = maps\mp\_threatdetection::detection_highlight_hud_effect_on(self,-1);
		}

		self setperk("specialty_uav_paint",1,0);
		return;
	}

	if(isdefined(self.uav_paint_effect))
	{
		maps\mp\_threatdetection::detection_highlight_hud_effect_off(self.uav_paint_effect);
		self.uav_paint_effect = undefined;
	}

	self unsetperk("specialty_uav_paint",1);
}

//Function Number: 23
updateteamradarblocked(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(isdefined(var_03) && var_03.team == param_00)
		{
			updateplayerradarblocked(var_03,param_01);
		}
	}
}

//Function Number: 24
updateplayerradarblocked(param_00,param_01)
{
	if(!param_01 || !param_00 maps\mp\_utility::_hasperk("specialty_class_hardwired"))
	{
		param_00 setclientomnvar("ui_uav_scrambler_on",param_01);
	}
}

//Function Number: 25
setteamradarwrapper(param_00,param_01)
{
	setteamradar(param_00,param_01);
	level notify("radar_status_change",param_00);
}

//Function Number: 26
handleincomingstinger()
{
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		level waittill("stinger_fired",var_00,var_01);
		if(!maps\mp\_stingerm7::anystingermissilelockedon(var_01,self))
		{
			continue;
		}

		foreach(var_03 in var_01)
		{
			if(!isdefined(var_03))
			{
				continue;
			}

			var_03 thread stingerproximitydetonate(var_03.lockedstingertarget,var_00);
		}
	}
}

//Function Number: 27
stingerproximitydetonate(param_00,param_01)
{
	self endon("death");
	var_02 = distance(self.origin,param_00 getpointinbounds(0,0,0));
	var_03 = param_00 getpointinbounds(0,0,0);
	for(;;)
	{
		if(!isdefined(param_00))
		{
			var_04 = var_03;
		}
		else
		{
			var_04 = param_00 getpointinbounds(0,0,0);
		}

		var_03 = var_04;
		var_05 = distance(self.origin,var_04);
		if(var_05 < var_02)
		{
			var_02 = var_05;
		}

		if(var_05 > var_02)
		{
			if(var_05 > 1536)
			{
				return;
			}

			radiusdamage(self.origin,1536,600,600,param_01,"MOD_EXPLOSIVE","stinger_mp");
			playfx(level.stingerfxid,self.origin);
			self hide();
			self notify("deleted");
			wait(0.05);
			self delete();
			param_01 notify("killstreak_destroyed");
		}

		wait(0.05);
	}
}

//Function Number: 28
adduavmodel()
{
	if(level.teambased)
	{
		level.uavmodels[self.team][level.uavmodels[self.team].size] = self;
		return;
	}

	level.uavmodels[self.owner.guid + "_" + gettime()] = self;
}

//Function Number: 29
removeuavmodel()
{
	var_00 = [];
	if(level.teambased)
	{
		var_01 = self.team;
		foreach(var_03 in level.uavmodels[var_01])
		{
			if(!isdefined(var_03))
			{
				continue;
			}

			var_00[var_00.size] = var_03;
		}

		level.uavmodels[var_01] = var_00;
		return;
	}

	foreach(var_03 in level.uavmodels)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		var_00[var_00.size] = var_03;
	}

	level.uavmodels = var_00;
}

//Function Number: 30
addactiveuav()
{
	self.uavtype = "standard";
	if(level.teambased)
	{
		level.activeuavs[self.team]++;
		return;
	}

	level.activeuavs[self.owner.guid]++;
	level.activeuavs[self.owner.guid + "_radarStrength"] = level.activeuavs[self.owner.guid + "_radarStrength"] + self.value;
}

//Function Number: 31
addactivecounteruav()
{
	self.uavtype = "counter";
	if(level.teambased)
	{
		level.activecounteruavs[self.team]++;
		return;
	}

	level.activecounteruavs[self.owner.guid]++;
}

//Function Number: 32
removeactiveuav()
{
	if(level.teambased)
	{
		level.activeuavs[self.team]--;
		if(!level.activeuavs[self.team])
		{
			return;
		}

		return;
	}

	if(isdefined(self.owner))
	{
		level.activeuavs[self.owner.guid]--;
		level.activeuavs[self.owner.guid + "_radarStrength"] = level.activeuavs[self.owner.guid + "_radarStrength"] - self.value;
	}
}

//Function Number: 33
removeactivecounteruav()
{
	if(level.teambased)
	{
		level.activecounteruavs[self.team]--;
		if(!level.activecounteruavs[self.team])
		{
			return;
		}

		return;
	}

	if(isdefined(self.owner))
	{
		level.activecounteruavs[self.owner.guid]--;
	}
}