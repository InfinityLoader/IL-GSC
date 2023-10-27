/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_helicopter.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 87
 * Decompile Time: 1521 ms
 * Timestamp: 10/27/2023 2:26:56 AM
*******************************************************************/

//Function Number: 1
init()
{
	var_00 = getentarray("heli_start","targetname");
	var_01 = getentarray("heli_loop_start","targetname");
	if(!var_00.size && !var_01.size)
	{
		return;
	}

	level.heli_types = [];
	precacheitem("heli_remote_mp");
	precachehelicopter("vehicle_cobra_helicopter_fly_low","cobra");
	precachehelicopter("vehicle_mi24p_hind_mp","hind");
	precachevehicle("cobra_mp");
	precacheitem("cobra_20mm_mp");
	precachehelicopter("vehicle_pavelow","pavelow");
	precachehelicopter("vehicle_pavelow_opfor","pavelow");
	precachevehicle("pavelow_mp");
	precacheturret("pavelow_minigun_mp");
	precachestring(&"SPLASHES_DESTROYED_PAVELOW");
	precachestring(&"SPLASHES_DESTROYED_MINIGUNNER");
	precachestring(&"SPLASHES_DESTROYED_HELICOPTER");
	level.chopper = undefined;
	level.heli_start_nodes = getentarray("heli_start","targetname");
	level.heli_loop_nodes = getentarray("heli_loop_start","targetname");
	level.heli_leave_nodes = getentarray("heli_leave","targetname");
	level.heli_crash_nodes = getentarray("heli_crash_start","targetname");
	level.heli_missile_rof = 5;
	level.heli_maxhealth = 2000;
	level.heli_debug = 0;
	level.heli_targeting_delay = 0.5;
	level.heli_turretreloadtime = 1.5;
	level.heli_turretclipsize = 40;
	level.heli_visual_range = 3700;
	level.heli_target_spawnprotection = 5;
	level.heli_target_recognition = 0.5;
	level.heli_missile_friendlycare = 256;
	level.heli_missile_target_cone = 0.3;
	level.heli_armor_bulletdamage = 0.3;
	level.heli_attract_strength = 1000;
	level.heli_attract_range = 4096;
	level.heli_angle_offset = 90;
	level.heli_forced_wait = 0;
	level.chopper_fx["explode"]["death"] = [];
	level.chopper_fx["explode"]["large"] = loadfx("explosions/helicopter_explosion_secondary_small");
	level.chopper_fx["explode"]["medium"] = loadfx("explosions/aerial_explosion");
	level.chopper_fx["smoke"]["trail"] = loadfx("smoke/smoke_trail_white_heli");
	level.chopper_fx["fire"]["trail"]["medium"] = loadfx("fire/fire_smoke_trail_L_emitter");
	level.chopper_fx["fire"]["trail"]["large"] = loadfx("fire/fire_smoke_trail_L");
	level.chopper_fx["damage"]["light_smoke"] = loadfx("smoke/smoke_trail_white_heli_emitter");
	level.chopper_fx["damage"]["heavy_smoke"] = loadfx("smoke/smoke_trail_black_heli_emitter");
	level.chopper_fx["damage"]["on_fire"] = loadfx("fire/fire_smoke_trail_L_emitter");
	level.chopper_fx["light"]["left"] = loadfx("misc/aircraft_light_wingtip_green");
	level.chopper_fx["light"]["right"] = loadfx("misc/aircraft_light_wingtip_red");
	level.chopper_fx["light"]["belly"] = loadfx("misc/aircraft_light_red_blink");
	level.chopper_fx["light"]["tail"] = loadfx("misc/aircraft_light_white_blink");
	level.fx_heli_dust = loadfx("treadfx/heli_dust_default");
	level.fx_heli_water = loadfx("treadfx/heli_water");
	makehelitype("cobra","explosions/helicopter_explosion_cobra_low",::defaultlightfx);
	addairexplosion("cobra","explosions/aerial_explosion_cobra_low_mp");
	makehelitype("pavelow","explosions/helicopter_explosion_pavelow",::pavelowlightfx);
	addairexplosion("pavelow","explosions/aerial_explosion_pavelow_mp");
	makehelitype("mi28","explosions/helicopter_explosion_mi28_flying",::defaultlightfx);
	addairexplosion("mi28","explosions/aerial_explosion_mi28_flying_mp");
	makehelitype("hind","explosions/helicopter_explosion_hind_chernobyl",::defaultlightfx);
	addairexplosion("hind","explosions/aerial_explosion_hind_chernobyl_mp");
	makehelitype("apache","explosions/helicopter_explosion_apache",::defaultlightfx);
	addairexplosion("apache","explosions/aerial_explosion_apache_mp");
	makehelitype("littlebird","explosions/aerial_explosion_littlebird_mp",::defaultlightfx);
	addairexplosion("littlebird","explosions/aerial_explosion_littlebird_mp");
	level.killstreakfuncs["helicopter"] = ::usehelicopter;
	level.killstreakfuncs["helicopter_blackbox"] = ::func_2BE2;
	level.killstreakfuncs["helicopter_flares"] = ::usehelicopterflares;
	level.killstreakfuncs["helicopter_minigun"] = ::usehelicopterminigun;
	level.killstreakfuncs["helicopter_mk19"] = ::usehelicoptermk19;
	level.helidialog["tracking"][0] = "ac130_fco_moreenemy";
	level.helidialog["tracking"][1] = "ac130_fco_getthatguy";
	level.helidialog["tracking"][2] = "ac130_fco_guyrunnin";
	level.helidialog["tracking"][3] = "ac130_fco_gotarunner";
	level.helidialog["tracking"][4] = "ac130_fco_personnelthere";
	level.helidialog["tracking"][5] = "ac130_fco_rightthere";
	level.helidialog["tracking"][6] = "ac130_fco_tracking";
	level.helidialog["locked"][0] = "ac130_fco_lightemup";
	level.helidialog["locked"][1] = "ac130_fco_takehimout";
	level.helidialog["locked"][2] = "ac130_fco_nailthoseguys";
	level.lasthelidialogtime = 0;
	maps\mp\_utility::func_2BDB("helicopter");
}

//Function Number: 2
makehelitype(param_00,param_01,param_02)
{
	level.chopper_fx["explode"]["death"][param_00] = loadfx(param_01);
	level.lightfxfunc[param_00] = param_02;
}

//Function Number: 3
addairexplosion(param_00,param_01)
{
	level.chopper_fx["explode"]["air_death"][param_00] = loadfx(param_01);
}

//Function Number: 4
pavelowlightfx()
{
	playfxontag(level.chopper_fx["light"]["left"],self,"tag_light_L_wing1");
	wait 0.05;
	playfxontag(level.chopper_fx["light"]["right"],self,"tag_light_R_wing1");
	wait 0.05;
	playfxontag(level.chopper_fx["light"]["belly"],self,"tag_light_belly");
	wait 0.05;
	playfxontag(level.chopper_fx["light"]["tail"],self,"tag_light_tail");
	wait 0.05;
	playfxontag(level.chopper_fx["light"]["tail"],self,"tag_light_tail2");
	wait 0.05;
	playfxontag(level.chopper_fx["light"]["belly"],self,"tag_light_cockpit01");
}

//Function Number: 5
defaultlightfx()
{
	playfxontag(level.chopper_fx["light"]["left"],self,"tag_light_L_wing");
	wait 0.05;
	playfxontag(level.chopper_fx["light"]["right"],self,"tag_light_R_wing");
	wait 0.05;
	playfxontag(level.chopper_fx["light"]["belly"],self,"tag_light_belly");
	wait 0.05;
	playfxontag(level.chopper_fx["light"]["tail"],self,"tag_light_tail");
}

//Function Number: 6
usehelicopter(param_00)
{
	return tryusehelicopter(param_00,"helicopter");
}

//Function Number: 7
func_2BE2(param_00)
{
	return tryusehelicopter(param_00,"blackbox");
}

//Function Number: 8
usehelicopterflares(param_00)
{
	return tryusehelicopter(param_00,"flares");
}

//Function Number: 9
usehelicopterminigun(param_00)
{
	if(isdefined(self.laststand) && !maps\mp\_utility::func_27AF("specialty_finalstand"))
	{
		self iprintlnbold(&"MP_UNAVILABLE_IN_LASTSTAND");
		return 0;
	}

	return tryusehelicopter(param_00,"minigun");
}

//Function Number: 10
usehelicoptermk19(param_00)
{
	if(isdefined(self.laststand) && !maps\mp\_utility::func_27AF("specialty_finalstand"))
	{
		self iprintlnbold(&"MP_UNAVILABLE_IN_LASTSTAND");
		return 0;
	}

	return tryusehelicopter(param_00,"mk19");
}

//Function Number: 11
tryusehelicopter(param_00,param_01)
{
	if(isdefined(level.civilianjetflyby))
	{
		self iprintlnbold(&"MP_CIVILIAN_AIR_TRAFFIC");
		return 0;
	}

	if(maps\mp\_utility::func_2BE7())
	{
		return 0;
	}

	if(maps\mp\_utility::func_27E5())
	{
		return 0;
	}

	var_02 = 1;
	if((!isdefined(param_01) || param_01 == "flares") && isdefined(level.chopper))
	{
		self iprintlnbold(&"MP_HELI_IN_QUEUE");
		if(isdefined(param_01))
		{
			var_03 = "helicopter_" + param_01;
		}
		else
		{
			var_03 = "helicopter";
		}

		thread maps\mp\killstreaks\_killstreaks::updatekillstreaks();
		var_04 = spawn("script_origin",(0,0,0));
		var_04 hide();
		var_04 thread func_2BF1(self,"disconnect");
		var_04.player = self;
		var_04.lifeid = param_00;
		var_04.helitype = param_01;
		var_04.streakname = var_03;
		maps\mp\_utility::func_2BEB("helicopter",var_04);
		var_05 = undefined;
		if(!self hasweapon(common_scripts\utility::getlastweapon()))
		{
			var_05 = maps\mp\killstreaks\_killstreaks::func_31E7();
		}
		else
		{
			var_05 = common_scripts\utility::getlastweapon();
		}

		var_06 = maps\mp\killstreaks\_killstreaks::func_2C01("helicopter_flares");
		thread maps\mp\killstreaks\_killstreaks::waittakekillstreakweapon(var_06,var_05);
		return 0;
	}
	else if(isdefined(level.chopper))
	{
		self iprintlnbold(&"MP_AIR_SPACE_TOO_CROWDED");
		return 0;
	}
	else if(maps\mp\_utility::func_2BEC() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_06 >= maps\mp\_utility::maxvehiclesallowed())
	{
		self iprintlnbold(&"MP_TOO_MANY_VEHICLES");
		return 0;
	}

	var_06 = 1;
	if(isdefined(var_05) && var_05 == "minigun")
	{
		maps\mp\_utility::setusingremote("helicopter_" + var_05);
		var_07 = maps\mp\killstreaks\_killstreaks::initridekillstreak();
		if(var_07 != "success")
		{
			if(var_07 != "disconnect")
			{
				maps\mp\_utility::clearusingremote();
			}

			return 0;
		}

		if(isdefined(level.chopper))
		{
			maps\mp\_utility::clearusingremote();
			self iprintlnbold(&"MP_AIR_SPACE_TOO_CROWDED");
			return 0;
		}
		else if(maps\mp\_utility::func_2BEC() >= maps\mp\_utility::maxvehiclesallowed() || level.fauxvehiclecount + var_06 >= maps\mp\_utility::maxvehiclesallowed())
		{
			maps\mp\_utility::clearusingremote();
			self iprintlnbold(&"MP_TOO_MANY_VEHICLES");
			return 0;
		}
	}

	func_2BF2(var_04,var_05);
	return 1;
}

//Function Number: 12
func_2BF1(param_00,param_01)
{
	self endon("death");
	param_00 waittill(param_01);
	self delete();
}

//Function Number: 13
func_2BF2(param_00,param_01)
{
	maps\mp\_utility::func_80C7();
	if(!isdefined(param_01))
	{
		param_01 = "";
	}

	switch(param_01)
	{
		case "flares":
			thread func_2C56();
			var_02 = "helicopter_flares";
			break;

		case "minigun":
			var_02 = "helicopter_minigun";
			break;

		default:
			var_02 = "helicopter";
			break;
	}

	var_03 = self.pers["team"];
	var_04 = level.heli_start_nodes[randomint(level.heli_start_nodes.size)];
	maps\mp\_matchdata::logkillstreakevent(var_02,self.origin);
	thread heli_think(param_00,self,var_04,self.pers["team"],param_01);
}

//Function Number: 14
precachehelicopter(param_00,param_01)
{
	var_02 = loadfx("explosions/tanker_explosion");
	precachemodel(param_00);
	level.heli_types[param_00] = param_01;
	level.cobra_missile_models = [];
	level.cobra_missile_models["cobra_Hellfire"] = "projectile_hellfire_missile";
	precachemodel(level.cobra_missile_models["cobra_Hellfire"]);
	level.heli_sound["allies"]["hit"] = "cobra_helicopter_hit";
	level.heli_sound["allies"]["hitsecondary"] = "cobra_helicopter_secondary_exp";
	level.heli_sound["allies"]["damaged"] = "cobra_helicopter_damaged";
	level.heli_sound["allies"]["spinloop"] = "cobra_helicopter_dying_loop";
	level.heli_sound["allies"]["spinstart"] = "cobra_helicopter_dying_layer";
	level.heli_sound["allies"]["crash"] = "cobra_helicopter_crash";
	level.heli_sound["allies"]["missilefire"] = "weap_cobra_missile_fire";
	level.heli_sound["axis"]["hit"] = "cobra_helicopter_hit";
	level.heli_sound["axis"]["hitsecondary"] = "cobra_helicopter_secondary_exp";
	level.heli_sound["axis"]["damaged"] = "cobra_helicopter_damaged";
	level.heli_sound["axis"]["spinloop"] = "cobra_helicopter_dying_loop";
	level.heli_sound["axis"]["spinstart"] = "cobra_helicopter_dying_layer";
	level.heli_sound["axis"]["crash"] = "cobra_helicopter_crash";
	level.heli_sound["axis"]["missilefire"] = "weap_cobra_missile_fire";
}

//Function Number: 15
spawn_helicopter(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = spawnhelicopter(param_00,param_01,param_02,param_03,param_04);
	if(!isdefined(var_05))
	{
		return undefined;
	}

	var_05.heli_type = level.heli_types[param_04];
	var_05 thread [[ level.lightfxfunc[var_05.heli_type] ]]();
	var_05 func_2C47();
	var_05.zoffset = (0,0,var_05 gettagorigin("tag_origin")[2] - var_05 gettagorigin("tag_ground")[2]);
	var_05.attractor = missile_createattractorent(var_05,level.heli_attract_strength,level.heli_attract_range);
	return var_05;
}

//Function Number: 16
heliride(param_00,param_01)
{
	self endon("disconnect");
	param_01 endon("helicopter_done");
	thread maps\mp\_utility::teamplayercardsplash("used_helicopter_minigun",self);
	self visionsetthermalforplayer("black_bw",0);
	maps\mp\_utility::_giveweapon("heli_remote_mp");
	self switchtoweapon("heli_remote_mp");
	self visionsetthermalforplayer(game["thermal_vision"],6);
	self thermalvisionon();
	self thermalvisionfofoverlayon();
	thread thermalvision(param_01);
	if(getdvarint("camera_thirdPerson"))
	{
		maps\mp\_utility::setthirdpersondof(0);
	}

	param_01 vehicleturretcontrolon(self);
	self playerlinkweaponviewtodelta(param_01,"tag_player",1,180,180,0,180,1);
	param_01.gunner = self;
	self.heliridelifeid = param_00;
	thread func_2C02(param_01);
	thread func_2BFD(param_01);
	for(;;)
	{
		param_01 waittill("turret_fire");
		param_01 fireweapon();
		earthquake(0.2,1,param_01.origin,1000);
	}
}

//Function Number: 17
thermalvision(param_00)
{
	param_00 endon("helicopter_done");
	if(maps\mp\_utility::getintproperty("ac130_thermal_enabled",1) == 0)
	{
		return;
	}

	var_01 = 0;
	self visionsetthermalforplayer(level.ac130.enhanced_vision,1);
	self.lastvisionsetthermal = level.ac130.enhanced_vision;
	self thermalvisionoff();
	self notifyonplayercommand("switch thermal","+usereload");
	self notifyonplayercommand("switch thermal","+activate");
	for(;;)
	{
		self waittill("switch thermal");
		if(!var_01)
		{
			self visionsetthermalforplayer(level.ac130.thermal_vision,0.62);
			self.lastvisionsetthermal = level.ac130.thermal_vision;
			self thermalvisionon();
		}
		else
		{
			self visionsetthermalforplayer(level.ac130.enhanced_vision,0.51);
			self.lastvisionsetthermal = level.ac130.enhanced_vision;
			self thermalvisionoff();
		}

		var_01 = !var_01;
	}
}

//Function Number: 18
func_2BFD(param_00)
{
	self endon("disconnect");
	param_00 endon("helicopter_done");
	if(!isdefined(level.helitargetorigin))
	{
		level.helitargetorigin = spawn("script_origin",(0,0,0));
		level.helitargetorigin hide();
	}

	for(;;)
	{
		var_01 = bullettrace(self geteye(),self geteye() + anglestoforward(self getplayerangles()) * 100000,1,self);
		level.helitargetorigin.origin = var_01["position"];
		var_02 = [];
		var_03 = [];
		foreach(var_05 in level.players)
		{
			if(!isalive(var_05))
			{
				continue;
			}

			if(level.teambased && var_05.team == self.team)
			{
				continue;
			}

			if(var_05 == self)
			{
				continue;
			}

			if(var_05 maps\mp\_utility::func_27AF("specialty_blindeye"))
			{
				continue;
			}

			if(isdefined(var_05.spawntime) && gettime() - var_05.spawntime / 1000 <= 5)
			{
				continue;
			}

			var_05.remotehelilos = 1;
			if(!bullettracepassed(self geteye(),var_05.origin + (0,0,32),0,param_00))
			{
				var_03[var_03.size] = var_05;
				continue;
			}

			var_02[var_02.size] = var_05;
		}

		var_07 = [];
		var_07 = var_02;
		foreach(var_09 in var_03)
		{
			var_02[var_02.size] = var_09;
		}

		if(var_07.size != 0)
		{
			var_0B = sortbydistance(var_07,var_01["position"]);
			if(distance(var_0B[0].origin,var_01["position"]) < 384 && var_0B[0] damageconetrace(var_01["position"]))
			{
				self weaponlockfinalize(var_0B[0]);
				helidialog("locked");
			}
			else
			{
				self weaponlockstart(var_0B[0]);
				helidialog("tracking");
			}
		}
		else
		{
			self weaponlockfree();
		}

		wait 0.05;
	}
}

//Function Number: 19
helidialog(param_00)
{
	if(gettime() - level.lasthelidialogtime < 6000)
	{
		return;
	}

	level.lasthelidialogtime = gettime();
	var_01 = randomint(level.helidialog[param_00].size);
	var_02 = level.helidialog[param_00][var_01];
	var_03 = maps\mp\gametypes\_teams::getteamvoiceprefix(self.team) + var_02;
	self playlocalsound(var_03);
}

//Function Number: 20
func_2C00(param_00)
{
	self remotecamerasoundscapeoff();
	self thermalvisionoff();
	self thermalvisionfofoverlayoff();
	self unlink();
	self switchtoweapon(common_scripts\utility::getlastweapon());
	maps\mp\_utility::clearusingremote();
	if(getdvarint("camera_thirdPerson"))
	{
		maps\mp\_utility::setthirdpersondof(1);
	}

	self visionsetthermalforplayer(game["thermal_vision"],0);
	if(isdefined(param_00))
	{
		var_01 = maps\mp\killstreaks\_killstreaks::func_2C01("helicopter_minigun");
		self takeweapon(var_01);
		param_00 vehicleturretcontroloff(self);
	}

	self notify("heliPlayer_removed");
}

//Function Number: 21
func_2C02(param_00)
{
	self endon("disconnect");
	param_00 waittill("helicopter_done");
	func_2C00(param_00);
}

//Function Number: 22
getposnearenemies()
{
	var_00 = [];
	foreach(var_02 in level.players)
	{
		if(var_02.team == "spectator")
		{
			continue;
		}

		if(var_02.team == self.team)
		{
			continue;
		}

		if(!isalive(var_02))
		{
			continue;
		}

		if(!bullettracepassed(var_02.origin,var_02.origin + (0,0,2048),0,var_02))
		{
			continue;
		}

		var_02.remotehelidist = 0;
		var_00[var_00.size] = var_02;
	}

	if(!var_00.size)
	{
		return undefined;
	}

	for(var_04 = 0;var_04 < var_00.size;var_04++)
	{
		for(var_05 = var_04 + 1;var_05 < var_00.size;var_05++)
		{
			var_06 = distancesquared(var_00[var_04].origin,var_00[var_05].origin);
			var_00[var_04].remotehelidist = var_00[var_04].remotehelidist + var_06;
			var_00[var_05].remotehelidist = var_00[var_05].remotehelidist + var_06;
		}
	}

	var_07 = var_00[0];
	foreach(var_02 in var_00)
	{
		if(var_02.remotehelidist < var_07.remotehelidist)
		{
			var_07 = var_02;
		}
	}

	return var_07.origin;
}

//Function Number: 23
func_2C05(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_03.validplayers = [];
		var_03.nodescore = 0;
	}

	foreach(var_06 in level.players)
	{
		if(!isalive(var_06))
		{
			continue;
		}

		if(var_06.team == self.team)
		{
			continue;
		}

		foreach(var_03 in param_00)
		{
			if(distancesquared(var_06.origin,var_03.origin) > 1048576)
			{
				continue;
			}

			var_03.validplayers[var_03.validplayers.size] = var_06;
		}
	}

	var_0A = param_00[0];
	foreach(var_03 in param_00)
	{
		var_0C = getent(var_03.target,"targetname");
		foreach(var_06 in var_03.validplayers)
		{
			var_03.nodescore = var_03.nodescore + 1;
			if(bullettracepassed(var_06.origin + (0,0,32),var_0C.origin,0,var_06))
			{
				var_03.nodescore = var_03.nodescore + 3;
			}
		}

		if(var_03.nodescore > var_0A.nodescore)
		{
			var_0A = var_03;
		}
	}

	return getent(var_0A.target,"targetname");
}

//Function Number: 24
heli_think(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_02.origin;
	var_06 = param_02.angles;
	switch(param_04)
	{
		case "minigun":
			var_07 = "cobra_minigun_mp";
			if(param_01.team == "allies")
			{
				var_08 = "vehicle_apache_mp";
			}
			else
			{
				var_08 = "vehicle_mi-28_mp";
			}
			break;

		case "flares":
			var_07 = "pavelow_mp";
			if(param_02.team == "allies")
			{
				var_08 = "vehicle_pavelow";
			}
			else
			{
				var_08 = "vehicle_pavelow_opfor";
			}
			break;

		default:
			var_07 = "cobra_mp";
			if(param_02.team == "allies")
			{
				var_08 = "vehicle_cobra_helicopter_fly_low";
			}
			else
			{
				var_08 = "vehicle_mi24p_hind_mp";
			}
			break;
	}

	var_09 = spawn_helicopter(param_01,var_05,var_06,var_07,var_08);
	if(!isdefined(var_09))
	{
		return;
	}

	level.chopper = var_09;
	var_09.helitype = param_04;
	var_09.lifeid = param_00;
	var_09.team = param_03;
	var_09.pers["team"] = param_03;
	var_09.owner = param_01;
	if(param_04 == "flares")
	{
		var_09.maxhealth = level.heli_maxhealth * 2;
	}
	else
	{
		var_09.maxhealth = level.heli_maxhealth;
	}

	var_09.targeting_delay = level.heli_targeting_delay;
	var_09.primarytarget = undefined;
	var_09.secondarytarget = undefined;
	var_09.attacker = undefined;
	var_09.currentstate = "ok";
	var_09.empgrenaded = 0;
	if(param_04 == "flares" || param_04 == "minigun")
	{
		var_09 thread heli_flares_monitor();
	}

	var_09 thread heli_leave_on_disconnect(param_01);
	var_09 thread func_2C2B(param_01);
	var_09 thread heli_leave_on_gameended(param_01);
	var_09 thread func_2447();
	var_09 thread func_2C22();
	var_09 thread func_2C14();
	var_09 endon("helicopter_done");
	var_09 endon("crashing");
	var_09 endon("leaving");
	var_09 endon("death");
	if(param_04 == "minigun")
	{
		param_01 thread heliride(param_00,var_09);
		var_09 thread heli_leave_on_spawned(param_01);
	}

	var_0A = getentarray("heli_attack_area","targetname");
	var_0B = level.heli_loop_nodes[randomint(level.heli_loop_nodes.size)];
	switch(param_04)
	{
		case "minigun":
			var_09 thread func_2C17();
			var_09 heli_fly_simple_path(param_02);
			var_09 thread func_2C2E(40);
			if(var_0A.size)
			{
				var_09 thread func_2C3F(var_0A);
			}
			else
			{
				var_09 thread func_2C3A(var_0B);
			}
			break;

		case "flares":
			var_09 thread makegunship();
			thread maps\mp\_utility::teamplayercardsplash("used_helicopter_flares",param_01);
			var_09 heli_fly_simple_path(param_02);
			var_09 thread func_2C2E(60);
			var_09 thread func_2C3A(var_0B);
			break;

		default:
			var_09 thread func_2C2F();
			var_09 thread func_2C17();
			var_09 heli_fly_simple_path(param_02);
			var_09 thread func_2C2E(60);
			var_09 thread func_2C3A(var_0B);
			break;
	}
}

//Function Number: 25
makegunship()
{
	self endon("death");
	self endon("helicopter_done");
	wait 0.5;
	var_00 = spawnturret("misc_turret",self.origin,"pavelow_minigun_mp");
	var_00.lifeid = self.lifeid;
	var_00 linkto(self,"tag_gunner_left",(0,0,0),(0,0,0));
	var_00 setmodel("weapon_minigun");
	var_00.owner = self.owner;
	var_00.team = self.team;
	var_00 maketurretinoperable();
	var_00.pers["team"] = self.team;
	var_00.killcament = self;
	self.mgturretleft = var_00;
	self.mgturretleft setdefaultdroppitch(0);
	var_00 = spawnturret("misc_turret",self.origin,"pavelow_minigun_mp");
	var_00.lifeid = self.lifeid;
	var_00 linkto(self,"tag_gunner_right",(0,0,0),(0,0,0));
	var_00 setmodel("weapon_minigun");
	var_00.owner = self.owner;
	var_00.team = self.team;
	var_00 maketurretinoperable();
	var_00.pers["team"] = self.team;
	var_00.killcament = self;
	self.mgturretright = var_00;
	self.mgturretright setdefaultdroppitch(0);
	if(level.teambased)
	{
		self.mgturretleft setturretteam(self.team);
		self.mgturretright setturretteam(self.team);
	}

	self.mgturretleft setmode("auto_nonai");
	self.mgturretright setmode("auto_nonai");
	self.mgturretleft setsentryowner(self.owner);
	self.mgturretright setsentryowner(self.owner);
	self.mgturretleft setturretminimapvisible(0);
	self.mgturretright setturretminimapvisible(0);
	self.mgturretleft.chopper = self;
	self.mgturretright.chopper = self;
	self.mgturretleft thread sentry_attacktargets();
	self.mgturretright thread sentry_attacktargets();
	thread func_2C10();
}

//Function Number: 26
func_2C10()
{
	self waittill("helicopter_done");
	self.mgturretright delete();
	self.mgturretleft delete();
}

//Function Number: 27
sentry_attacktargets()
{
	self endon("death");
	self endon("helicopter_done");
	level endon("game_ended");
	for(;;)
	{
		self waittill("turretstatechange");
		if(self isfiringturret() && !self.chopper.empgrenaded)
		{
			thread sentry_burstfirestart();
			continue;
		}

		thread sentry_burstfirestop();
	}
}

//Function Number: 28
sentry_burstfirestart()
{
	self endon("death");
	self endon("stop_shooting");
	self endon("leaving");
	level endon("game_ended");
	var_00 = 0.1;
	var_01 = 40;
	var_02 = 80;
	var_03 = 1;
	var_04 = 2;
	for(;;)
	{
		var_05 = randomintrange(var_01,var_02 + 1);
		for(var_06 = 0;var_06 < var_05;var_06++)
		{
			var_07 = self getturrettarget(0);
			if(isdefined(var_07) && !isdefined(var_07.spawntime) || gettime() - var_07.spawntime / 1000 > 5)
			{
				self shootturret();
			}

			wait var_00;
		}

		wait randomfloatrange(var_03,var_04);
	}
}

//Function Number: 29
sentry_burstfirestop()
{
	self notify("stop_shooting");
}

//Function Number: 30
func_2C14()
{
	var_00 = self getentitynumber();
	common_scripts\utility::waittill_any("death","crashing","leaving");
	func_2C49(var_00);
	self notify("helicopter_done");
	self notify("helicopter_removed");
	var_01 = undefined;
	var_02 = maps\mp\_utility::queueremovefirst("helicopter");
	if(!isdefined(var_02))
	{
		level.chopper = undefined;
		return;
	}

	var_01 = var_02.player;
	var_03 = var_02.lifeid;
	var_04 = var_02.streakname;
	var_05 = var_02.helitype;
	var_02 delete();
	if(isdefined(var_01) && var_01.sessionstate == "playing" || var_01.sessionstate == "dead")
	{
		var_01 maps\mp\killstreaks\_killstreaks::func_2C16(var_04,1);
		var_01 func_2BF2(var_03,var_05);
		return;
	}

	level.chopper = undefined;
}

//Function Number: 31
func_2C17()
{
	self endon("death");
	self endon("helicopter_done");
	for(;;)
	{
		var_00 = [];
		self.primarytarget = undefined;
		self.secondarytarget = undefined;
		var_01 = level.players;
		foreach(var_03 in level.players)
		{
			if(!cantarget_turret(var_03))
			{
				continue;
			}

			var_00[var_00.size] = var_03;
		}

		if(var_00.size)
		{
			for(var_05 = getbestprimarytarget(var_00);!isdefined(var_05);var_05 = getbestprimarytarget(var_00))
			{
				wait 0.05;
			}

			self.primarytarget = var_05;
			self notify("primary acquired");
		}

		if(isdefined(level.harriers))
		{
			foreach(var_07 in level.harriers)
			{
				if(!isdefined(var_07))
				{
					continue;
				}

				if((level.teambased && var_07.team != self.team) || !level.teambased && var_07.owner != self.owner)
				{
					self notify("secondary acquired");
					self.secondarytarget = var_07;
				}
			}
		}

		wait 0.5;
	}
}

//Function Number: 32
cantarget_turret(param_00)
{
	var_01 = 1;
	if(!isalive(param_00) || param_00.sessionstate != "playing")
	{
		return 0;
	}

	if(self.helitype == "remote_mortar")
	{
		if(param_00 sightconetrace(self.origin,self) < 1)
		{
			return 0;
		}
	}
	else if(self.helitype != "flares")
	{
		if(!self vehicle_canturrettargetpoint(param_00.origin + (0,0,40),1,self))
		{
			return 0;
		}
	}

	if(distance(param_00.origin,self.origin) > level.heli_visual_range)
	{
		return 0;
	}

	if(level.teambased && param_00.pers["team"] == self.team)
	{
		return 0;
	}

	if(param_00 == self.owner)
	{
		return 0;
	}

	if(isdefined(param_00.spawntime) && gettime() - param_00.spawntime / 1000 <= 5)
	{
		return 0;
	}

	if(param_00 maps\mp\_utility::func_27AF("specialty_blindeye"))
	{
		return 0;
	}

	var_02 = self.origin + (0,0,-160);
	var_03 = anglestoforward(self.angles);
	var_04 = var_02 + 144 * var_03;
	if(param_00 sightconetrace(var_04,self) < level.heli_target_recognition)
	{
		return 0;
	}

	return var_01;
}

//Function Number: 33
getbestprimarytarget(param_00)
{
	foreach(var_02 in param_00)
	{
		func_2C1B(var_02);
	}

	var_04 = 0;
	var_05 = undefined;
	var_06 = getentarray("minimap_corner","targetname");
	foreach(var_02 in param_00)
	{
		if(var_06.size == 2)
		{
			var_08 = var_06[0].origin;
			var_09 = var_06[0].origin;
			if(var_06[1].origin[0] > var_09[0])
			{
				var_09 = (var_06[1].origin[0],var_09[1],var_09[2]);
			}
			else
			{
				var_08 = (var_06[1].origin[0],var_08[1],var_08[2]);
			}

			if(var_06[1].origin[1] > var_09[1])
			{
				var_09 = (var_09[0],var_06[1].origin[1],var_09[2]);
			}
			else
			{
				var_08 = (var_08[0],var_06[1].origin[1],var_08[2]);
			}

			if(var_02.origin[0] < var_08[0] || var_02.origin[0] > var_09[0] || var_02.origin[1] < var_08[1] || var_02.origin[1] > var_09[1])
			{
				continue;
			}
		}

		if(var_02.threatlevel < var_04)
		{
			continue;
		}

		var_04 = var_02.threatlevel;
		var_05 = var_02;
	}

	return var_05;
}

//Function Number: 34
func_2C1B(param_00)
{
	param_00.threatlevel = 0;
	var_01 = distance(param_00.origin,self.origin);
	param_00.threatlevel = param_00.threatlevel + level.heli_visual_range - var_01 / level.heli_visual_range * 100;
	if(isdefined(self.attacker) && param_00 == self.attacker)
	{
		param_00.threatlevel = param_00.threatlevel + 100;
	}

	param_00.threatlevel = param_00.threatlevel + param_00.score * 4;
	if(isdefined(param_00.antithreat))
	{
		param_00.threatlevel = param_00.threatlevel - param_00.antithreat;
	}

	if(param_00.threatlevel <= 0)
	{
		param_00.threatlevel = 1;
	}
}

//Function Number: 35
heli_reset()
{
	self cleartargetyaw();
	self cleargoalyaw();
	self vehicle_setspeed(60,25);
	self setyawspeed(75,45,45);
	self setmaxpitchroll(30,30);
	self setneargoalnotifydist(256);
	self setturningability(0.9);
}

//Function Number: 36
func_2C1E(param_00)
{
	self endon("death");
	self.recentdamageamount = self.recentdamageamount + param_00;
	wait 4;
	self.recentdamageamount = self.recentdamageamount - param_00;
}

//Function Number: 37
func_2447()
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self.health = 999999;
	self.damagetaken = 0;
	self.recentdamageamount = 0;
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isdefined(var_01.class) && var_01.class == "worldspawn")
		{
			continue;
		}
		else if(var_01 == self)
		{
			continue;
		}

		if(!maps\mp\gametypes\_weapons::func_27A1(self.owner,var_01))
		{
			continue;
		}

		self.attacker = var_01;
		var_0A = var_00;
		if(isplayer(var_01))
		{
			var_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("");
			if(var_04 == "MOD_RIFLE_BULLET" || var_04 == "MOD_PISTOL_BULLET")
			{
				if(self.helitype == "flares")
				{
					var_0A = var_0A * level.heli_armor_bulletdamage;
				}

				if(var_01 maps\mp\_utility::func_27AF("specialty_armorpiercing"))
				{
					var_0A = var_0A + var_00 * level.armorpiercingmod;
				}
			}
		}

		if(isdefined(var_01.owner) && isplayer(var_01.owner))
		{
			var_01.owner maps\mp\gametypes\_damagefeedback::updatedamagefeedback("helicopter");
		}

		if(isdefined(var_09))
		{
			switch(var_09)
			{
				case "remote_mortar_missile_mp":
				case "javelin_mp":
				case "stinger_mp":
				case "remotemissile_projectile_mp":
				case "ac130_40mm_mp":
				case "ac130_105mm_mp":
					self.largeprojectiledamage = 1;
					var_0A = self.maxhealth + 1;
					break;
	
				case "sam_projectile_mp":
					self.largeprojectiledamage = 1;
					switch(self.helitype)
					{
						case "osprey":
						case "flares":
						case "osprey_gunner":
							var_0A = self.maxhealth * 0.07;
							break;
		
						case "littlebird":
						case "helicopter":
							var_0A = self.maxhealth * 0.09;
							break;
					}
					break;
	
				case "emp_grenade_mp":
					var_0A = 0;
					thread heli_empgrenaded();
					break;
	
				case "osprey_player_minigun_mp":
					self.largeprojectiledamage = 0;
					var_0A = var_0A * 2;
					break;
			}

			maps\mp\killstreaks\_killstreaks::killstreakhit(var_01,var_09,self);
		}

		self.damagetaken = self.damagetaken + var_0A;
		thread func_2C1E(var_0A);
		if(self.damagetaken >= self.maxhealth)
		{
			if((level.teambased && self.team != var_01.team) || !level.teambased)
			{
				var_0B = undefined;
				if(isdefined(var_01.owner) && !isdefined(self.owner) || var_01.owner != self.owner)
				{
					var_0B = var_01.owner;
				}
				else if(!isdefined(var_01.owner) && var_01.classname == "script_vehicle")
				{
					return;
				}
				else if(!isdefined(self.owner) || var_01 != self.owner)
				{
					var_0B = var_01;
				}

				if(isdefined(var_0B))
				{
					var_0B notify("destroyed_helicopter");
					switch(self.helitype)
					{
						case "flares":
							var_0B thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_DESTROYED_PAVELOW");
							thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_helicopter_flares",var_0B);
							var_0C = 400;
							break;
	
						case "minigun":
							var_0C thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_DESTROYED_MINIGUNNER");
							thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_helicopter_minigun",var_0C);
							var_0C = 300;
							break;
	
						case "osprey":
						case "osprey_gunner":
							var_0C thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_DESTROYED_OSPREY");
							thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_osprey",var_0C);
							var_0C = 300;
							break;
	
						case "littlebird":
							var_0C thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_DESTROYED_LITTLE_BIRD");
							thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_little_bird",var_0C);
							var_0C = 200;
							break;
	
						default:
							var_0B thread maps\mp\gametypes\_rank::xpeventpopup(&"SPLASHES_DESTROYED_HELICOPTER");
							thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_helicopter",var_0B);
							var_0C = 200;
							break;
					}

					var_0B thread maps\mp\gametypes\_rank::func_2AB3("kill",var_0C,var_09,var_04);
					thread maps\mp\gametypes\_missions::vehiclekilled(self.owner,self,undefined,var_0B,var_00,var_04,var_09);
				}
			}
		}
	}
}

//Function Number: 38
heli_empgrenaded()
{
	self notify("heli_EMPGrenaded");
	self endon("heli_EMPGrenaded");
	self endon("death");
	self endon("leaving");
	self endon("crashing");
	self.owner endon("disconnect");
	level endon("game_ended");
	self.empgrenaded = 1;
	if(isdefined(self.mgturretleft))
	{
		self.mgturretleft notify("stop_shooting");
	}

	if(isdefined(self.mgturretright))
	{
		self.mgturretright notify("stop_shooting");
	}

	wait 3.5;
	self.empgrenaded = 0;
	if(isdefined(self.mgturretleft))
	{
		self.mgturretleft notify("turretstatechange");
	}

	if(isdefined(self.mgturretright))
	{
		self.mgturretright notify("turretstatechange");
	}
}

//Function Number: 39
func_2C22()
{
	self endon("death");
	self endon("leaving");
	self endon("crashing");
	self.currentstate = "ok";
	self.laststate = "ok";
	self setdamagestage(3);
	var_00 = 3;
	self setdamagestage(var_00);
	for(;;)
	{
		if(self.damagetaken >= self.maxhealth * 0.33 && var_00 == 3)
		{
			var_00 = 2;
			self setdamagestage(var_00);
			self.currentstate = "light smoke";
			playfxontag(level.chopper_fx["damage"]["light_smoke"],self,"tag_engine_left");
		}
		else if(self.damagetaken >= self.maxhealth * 0.66 && var_00 == 2)
		{
			var_00 = 1;
			self setdamagestage(var_00);
			self.currentstate = "heavy smoke";
			stopfxontag(level.chopper_fx["damage"]["light_smoke"],self,"tag_engine_left");
			playfxontag(level.chopper_fx["damage"]["heavy_smoke"],self,"tag_engine_left");
		}
		else if(self.damagetaken > self.maxhealth)
		{
			var_00 = 0;
			self setdamagestage(var_00);
			stopfxontag(level.chopper_fx["damage"]["heavy_smoke"],self,"tag_engine_left");
			if(isdefined(self.largeprojectiledamage) && self.largeprojectiledamage)
			{
				thread func_2C28(1);
			}
			else
			{
				playfxontag(level.chopper_fx["damage"]["on_fire"],self,"tag_engine_left");
				thread func_2C24();
			}
		}

		wait 0.05;
	}
}

//Function Number: 40
func_2C24()
{
	self notify("crashing");
	var_00 = level.heli_crash_nodes[randomint(level.heli_crash_nodes.size)];
	thread func_2C26(180);
	thread func_2C25();
	heli_fly_simple_path(var_00);
	thread func_2C28();
}

//Function Number: 41
func_2C25()
{
	playfxontag(level.chopper_fx["explode"]["large"],self,"tag_engine_left");
	self playsound(level.heli_sound[self.team]["hitsecondary"]);
	wait 3;
	if(!isdefined(self))
	{
		return;
	}

	playfxontag(level.chopper_fx["explode"]["large"],self,"tag_engine_left");
	self playsound(level.heli_sound[self.team]["hitsecondary"]);
}

//Function Number: 42
func_2C26(param_00)
{
	self endon("death");
	self playsound(level.heli_sound[self.team]["hit"]);
	thread func_2C27();
	self setyawspeed(param_00,param_00,param_00);
	while(isdefined(self))
	{
		self settargetyaw(self.angles[1] + param_00 * 0.9);
		wait 1;
	}
}

//Function Number: 43
func_2C27()
{
	self endon("death");
	wait 0.25;
	self stoploopsound();
	wait 0.05;
	self playloopsound(level.heli_sound[self.team]["spinloop"]);
	wait 0.05;
	self playloopsound(level.heli_sound[self.team]["spinstart"]);
}

//Function Number: 44
func_2C28(param_00)
{
	self notify("death");
	if(isdefined(param_00) && isdefined(level.chopper_fx["explode"]["air_death"][self.heli_type]))
	{
		var_01 = self gettagangles("tag_deathfx");
		playfx(level.chopper_fx["explode"]["air_death"][self.heli_type],self gettagorigin("tag_deathfx"),anglestoforward(var_01),anglestoup(var_01));
	}
	else
	{
		var_02 = self.origin;
		var_03 = self.origin + (0,0,1) - self.origin;
		playfx(level.chopper_fx["explode"]["death"][self.heli_type],var_02,var_03);
	}

	self playsound(level.heli_sound[self.team]["crash"]);
	wait 0.05;
	if(isdefined(self.killcament))
	{
		self.killcament delete();
	}

	maps\mp\_utility::func_80C8();
	self delete();
}

//Function Number: 45
func_23F2(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_03 = undefined;
	var_04 = undefined;
	var_05 = "cobra_20mm_mp";
	var_06 = [];
	switch(param_00)
	{
		case "ffar":
			var_03 = "harrier_FFAR_mp";
			break;
	var_41[0]
	"tag_store_r_2"
			break;

		default:
			break;
	}

	var_05 = weaponfiretime(var_04);
	self setvehweapon(var_04);
	var_07 = -1;
	for(var_08 = 0;var_08 < param_02;var_08++)
	{
		var_07++;
		if(var_07 >= var_41.size)
		{
			var_07 = 0;
		}

		self setvehweapon("harrier_FFAR_mp");
		if(isdefined(var_03))
		{
			var_09 = self fireweapon(var_41[var_07],var_03);
			var_09 missile_setflightmodedirect();
			var_09 missile_settargetent(var_03);
		}
		else
		{
			var_09 = self fireweapon(var_41[var_07]);
			var_09 missile_setflightmodedirect();
			var_09 missile_settargetent(var_03);
		}

		if(var_08 < param_02 - 1)
		{
			wait var_05;
		}
	}
}

//Function Number: 46
check_owner()
{
	if(!isdefined(self.owner) || !isdefined(self.owner.pers["team"]) || self.owner.pers["team"] != self.team)
	{
		thread func_2C41();
		return 0;
	}

	return 1;
}

//Function Number: 47
heli_leave_on_disconnect(param_00)
{
	self endon("death");
	self endon("helicopter_done");
	param_00 waittill("disconnect");
	thread func_2C41();
}

//Function Number: 48
func_2C2B(param_00)
{
	self endon("death");
	self endon("helicopter_done");
	param_00 common_scripts\utility::waittill_any("joined_team","joined_spectators");
	thread func_2C41();
}

//Function Number: 49
heli_leave_on_spawned(param_00)
{
	self endon("death");
	self endon("helicopter_done");
	param_00 waittill("spawned");
	thread func_2C41();
}

//Function Number: 50
heli_leave_on_gameended(param_00)
{
	self endon("death");
	self endon("helicopter_done");
	level waittill("game_ended");
	thread func_2C41();
}

//Function Number: 51
func_2C2E(param_00)
{
	self endon("death");
	self endon("helicopter_done");
	maps\mp\gametypes\_hostmigration::func_2740(param_00);
	thread func_2C41();
}

//Function Number: 52
func_2C2F()
{
	thread attack_primary();
	thread func_2C30();
}

//Function Number: 53
func_2C30()
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	for(;;)
	{
		if(isdefined(self.secondarytarget))
		{
			self.secondarytarget.antithreat = undefined;
			self.missiletarget = self.secondarytarget;
			var_00 = 0;
			while(isdefined(self.missiletarget) && isalive(self.missiletarget))
			{
				if(func_2C32(self.missiletarget))
				{
					thread missile_support(self.missiletarget,level.heli_missile_rof);
				}
				else
				{
					break;
				}

				self waittill("missile ready");
				if(!isdefined(self.secondarytarget) || isdefined(self.secondarytarget) && self.missiletarget != self.secondarytarget)
				{
					break;
				}
			}

			if(isdefined(self.missiletarget))
			{
				self.missiletarget.antithreat = undefined;
			}
		}

		self waittill("secondary acquired");
		check_owner();
	}
}

//Function Number: 54
func_2C32(param_00)
{
	var_01 = vectornormalize(param_00.origin - self.origin);
	var_02 = anglestoforward(self.angles);
	var_03 = vectornormalize(var_02);
	var_04 = vectordot(var_01,var_03);
	if(var_04 >= level.heli_missile_target_cone)
	{
		func_2C45("Missile sight: " + var_04,self,(0,0,-40),40);
		return 1;
	}

	return 0;
}

//Function Number: 55
missile_support(param_00,param_01)
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	if(isdefined(param_00))
	{
		if(level.teambased)
		{
			if(isdefined(param_00.owner) && param_00.team != self.team)
			{
				func_23F2("ffar",1,param_00);
				self notify("missile fired");
			}
		}
		else if(isdefined(param_00.owner) && param_00.owner != self.owner)
		{
			func_23F2("ffar",1,param_00);
			self notify("missile fired");
		}
	}

	wait param_01;
	self notify("missile ready");
}

//Function Number: 56
attack_primary()
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	for(;;)
	{
		wait 0.05;
		if(!isalive(self.primarytarget))
		{
			continue;
		}

		var_00 = self.primarytarget;
		var_00.antithreat = 0;
		if(randomint(5) < 3)
		{
			var_01 = var_00.angles[1] + randomfloatrange(-30,30);
		}
		else
		{
			var_01 = randomint(360);
		}

		var_02 = 96;
		var_03 = cos(var_01) * var_02;
		var_04 = sin(var_01) * var_02;
		self setturrettargetent(var_00,(var_03,var_04,40));
		waitontargetordeath(var_00,3);
		if(!isalive(var_00) || !self vehicle_canturrettargetpoint(var_00.origin + (0,0,40)))
		{
			continue;
		}

		var_05 = weaponfiretime("cobra_20mm_mp");
		var_06 = 1;
		var_07 = 0;
		self playloopsound("weap_cobra_20mm_fire_npc");
		for(var_08 = 0;var_08 < level.heli_turretclipsize;var_08++)
		{
			if(self.empgrenaded)
			{
				break;
			}

			self setvehweapon("cobra_20mm_mp");
			self fireweapon("tag_flash");
			if(var_08 < level.heli_turretclipsize - 1)
			{
				wait var_05;
			}

			if(!isdefined(var_00))
			{
				break;
			}

			if(self vehicle_canturrettargetpoint(var_00.origin + (0,0,40),1,self))
			{
				var_06 = max(var_06 - 0.05,0);
				var_07 = 0;
			}
			else
			{
				var_07++;
			}

			if(var_07 > 10)
			{
				break;
			}

			var_09 = (var_03 * var_06 + randomfloatrange(-6,6),var_04 * var_06 + randomfloatrange(-6,6),40 + randomfloatrange(-6,6));
			self setturrettargetent(var_00,var_09);
		}

		self stoploopsound();
		if(isalive(var_00))
		{
			var_00.antithreat = var_00.antithreat + 100;
		}

		wait randomfloatrange(0.5,2);
	}
}

//Function Number: 57
waitontargetordeath(param_00,param_01)
{
	self endon("death");
	self endon("helicopter_done");
	param_00 endon("death");
	param_00 endon("disconnect");
	common_scripts\utility::waittill_notify_or_timeout("turret_on_target",param_01);
}

//Function Number: 58
firemissile(param_00)
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	if(!isdefined(param_00))
	{
		return;
	}

	if(distance2d(self.origin,param_00.origin) < 512)
	{
		return;
	}

	self setvehweapon("harrier_FFAR_mp");
	var_01 = self fireweapon("tag_flash",param_00);
	var_01 missile_setflightmodedirect();
	var_01 missile_settargetent(param_00);
}

//Function Number: 59
func_2C37(param_00)
{
	var_01 = self.origin;
	var_02 = param_00.origin;
	var_03 = 0;
	var_04 = 40;
	var_05 = (0,0,-196);
	for(var_06 = bullettrace(var_01 + var_05,var_02 + var_05,0,self);distancesquared(var_06["position"],var_02 + var_05) > 10 && var_03 < var_04;var_06 = bullettrace(var_01 + var_05,var_02 + var_05,0,self))
	{
		if(var_01[2] < var_02[2])
		{
			var_01 = var_01 + (0,0,128);
		}
		else if(var_01[2] > var_02[2])
		{
			var_02 = var_02 + (0,0,128);
		}
		else
		{
			var_01 = var_01 + (0,0,128);
			var_02 = var_02 + (0,0,128);
		}

		var_03++;
	}

	var_07 = [];
	return var_41;
}

//Function Number: 60
func_2C38(param_00)
{
	var_01 = func_2C37(param_00);
	if(var_01["start"] != self.origin)
	{
		if(isdefined(param_00.script_airspeed) && isdefined(param_00.script_accel))
		{
			var_02 = param_00.script_airspeed;
			var_03 = param_00.script_accel;
		}
		else
		{
			var_02 = 30 + randomint(20);
			var_03 = 15 + randomint(15);
		}

		self vehicle_setspeed(var_02,var_03);
		self setvehgoalpos(var_01["start"] + (0,0,30),0);
		self setgoalyaw(param_00.angles[1] + level.heli_angle_offset);
		self waittill("goal");
	}

	if(var_01["end"] != param_00.origin)
	{
		if(isdefined(param_00.script_airspeed) && isdefined(param_00.script_accel))
		{
			var_02 = param_00.script_airspeed;
			var_03 = param_00.script_accel;
		}
		else
		{
			var_02 = 30 + randomint(20);
			var_03 = 15 + randomint(15);
		}

		self vehicle_setspeed(var_02,var_03);
		self setvehgoalpos(var_01["end"] + (0,0,30),0);
		self setgoalyaw(param_00.angles[1] + level.heli_angle_offset);
		self waittill("goal");
	}
}

//Function Number: 61
heli_fly_simple_path(param_00)
{
	self endon("death");
	self endon("leaving");
	self notify("flying");
	self endon("flying");
	heli_reset();
	for(var_01 = param_00;isdefined(var_01.target);var_01 = var_02)
	{
		var_02 = getent(var_01.target,"targetname");
		if(isdefined(var_01.script_airspeed) && isdefined(var_01.script_accel))
		{
			var_03 = var_01.script_airspeed;
			var_04 = var_01.script_accel;
		}
		else
		{
			var_03 = 30 + randomint(20);
			var_04 = 15 + randomint(15);
		}

		self vehicle_setspeed(var_03,var_04);
		if(!isdefined(var_02.target))
		{
			self setvehgoalpos(var_02.origin + self.zoffset,1);
			self waittill("near_goal");
			continue;
		}

		self setvehgoalpos(var_02.origin + self.zoffset,0);
		self waittill("near_goal");
		self setgoalyaw(var_02.angles[1]);
		self waittillmatch("goal");
	}
}

//Function Number: 62
func_2C3A(param_00)
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self notify("flying");
	self endon("flying");
	heli_reset();
	thread heli_loop_speed_control(param_00);
	for(var_01 = param_00;isdefined(var_01.target);var_01 = var_02)
	{
		var_02 = getent(var_01.target,"targetname");
		if(isdefined(var_01.script_airspeed) && isdefined(var_01.script_accel))
		{
			self.desired_speed = var_01.script_airspeed;
			self.desired_accel = var_01.script_accel;
		}
		else
		{
			self.desired_speed = 30 + randomint(20);
			self.desired_accel = 15 + randomint(15);
		}

		if(self.helitype == "flares")
		{
			self.desired_speed = self.desired_speed * 0.5;
			self.desired_accel = self.desired_accel * 0.5;
		}

		if(isdefined(var_02.script_delay) && isdefined(self.primarytarget) && !func_2C3E())
		{
			self setvehgoalpos(var_02.origin + self.zoffset,1);
			self waittill("near_goal");
			wait var_02.script_delay;
			continue;
		}

		self setvehgoalpos(var_02.origin + self.zoffset,0);
		self waittill("near_goal");
		self setgoalyaw(var_02.angles[1]);
		self waittillmatch("goal");
	}
}

//Function Number: 63
heli_loop_speed_control(param_00)
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	if(isdefined(param_00.script_airspeed) && isdefined(param_00.script_accel))
	{
		self.desired_speed = param_00.script_airspeed;
		self.desired_accel = param_00.script_accel;
	}
	else
	{
		self.desired_speed = 30 + randomint(20);
		self.desired_accel = 15 + randomint(15);
	}

	var_01 = 0;
	var_02 = 0;
	for(;;)
	{
		var_03 = self.desired_speed;
		var_04 = self.desired_accel;
		if(self.helitype != "flares" && isdefined(self.primarytarget) && !func_2C3E())
		{
			var_03 = var_03 * 0.25;
		}

		if(var_01 != var_03 || var_02 != var_04)
		{
			self vehicle_setspeed(var_03,var_04);
			var_01 = var_03;
			var_02 = var_04;
		}

		wait 0.05;
	}
}

//Function Number: 64
func_2C3E()
{
	if(self.recentdamageamount > 50)
	{
		return 1;
	}

	if(self.currentstate == "heavy smoke")
	{
		return 1;
	}

	return 0;
}

//Function Number: 65
func_2C3F(param_00)
{
	self notify("flying");
	self endon("flying");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	for(;;)
	{
		var_01 = func_2C40(param_00);
		func_2C38(var_01);
		if(isdefined(var_01.script_airspeed) && isdefined(var_01.script_accel))
		{
			var_02 = var_01.script_airspeed;
			var_03 = var_01.script_accel;
		}
		else
		{
			var_02 = 30 + randomint(20);
			var_03 = 15 + randomint(15);
		}

		self vehicle_setspeed(var_02,var_03);
		self setvehgoalpos(var_01.origin + self.zoffset,1);
		self setgoalyaw(var_01.angles[1] + level.heli_angle_offset);
		if(level.heli_forced_wait != 0)
		{
			self waittill("near_goal");
			wait level.heli_forced_wait;
			continue;
		}

		if(!isdefined(var_01.script_delay))
		{
			self waittill("near_goal");
			wait 5 + randomint(5);
			continue;
		}

		self waittillmatch("goal");
		wait var_01.script_delay;
	}
}

//Function Number: 66
func_2C40(param_00)
{
	return func_2C05(param_00);
}

//Function Number: 67
func_2C41(param_00)
{
	self notify("leaving");
	if(isdefined(self.helitype) && self.helitype == "osprey" && isdefined(self.pathgoal))
	{
		self setvehgoalpos(self.pathgoal,1);
		common_scripts\utility::waittill_any_timeout(5,"goal");
	}

	if(!isdefined(param_00))
	{
		var_01 = level.heli_leave_nodes[randomint(level.heli_leave_nodes.size)];
		param_00 = var_01.origin;
	}

	var_02 = spawn("script_origin",param_00);
	if(isdefined(var_02))
	{
		self setlookatent(var_02);
		var_02 thread func_2C43(3);
	}

	heli_reset();
	self vehicle_setspeed(100,45);
	self setvehgoalpos(param_00,1);
	self waittillmatch("goal");
	self notify("death");
	wait 0.05;
	if(isdefined(self.killcament))
	{
		self.killcament delete();
	}

	maps\mp\_utility::func_80C8();
	self delete();
}

//Function Number: 68
func_2C43(param_00)
{
	self endon("death");
	level endon("game_ended");
	wait param_00;
	self delete();
}

//Function Number: 69
debug_print3d(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(level.heli_debug) && level.heli_debug == 1)
	{
		thread func_2C46(param_00,param_01,param_02,param_03,param_04);
	}
}

//Function Number: 70
func_2C45(param_00,param_01,param_02,param_03)
{
	if(isdefined(level.heli_debug) && level.heli_debug == 1)
	{
		if(isdefined(param_03))
		{
			thread func_2C46(param_00,(0.8,0.8,0.8),param_01,param_02,param_03);
			return;
		}

		thread func_2C46(param_00,(0.8,0.8,0.8),param_01,param_02,0);
	}
}

//Function Number: 71
debug_line(param_00,param_01,param_02,param_03)
{
	if(isdefined(level.heli_debug) && level.heli_debug == 1 && !isdefined(param_03))
	{
		thread draw_line(param_00,param_01,param_02);
		return;
	}

	if(isdefined(level.heli_debug) && level.heli_debug == 1)
	{
		thread draw_line(param_00,param_01,param_02,param_03);
	}
}

//Function Number: 72
func_2C46(param_00,param_01,param_02,param_03,param_04)
{
	if(param_04 == 0)
	{
		while(isdefined(param_02))
		{
			wait 0.05;
		}

		return;
	}

	for(var_05 = 0;var_05 < param_04;var_05++)
	{
		if(!isdefined(param_02))
		{
			break;
		}

		wait 0.05;
	}
}

//Function Number: 73
draw_line(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		for(var_04 = 0;var_04 < param_03;var_04++)
		{
			wait 0.05;
		}

		return;
	}

	wait 0.05;
}

//Function Number: 74
func_2C47()
{
	level.helis[self getentitynumber()] = self;
}

//Function Number: 75
func_2C49(param_00)
{
	level.helis[param_00] = undefined;
}

//Function Number: 76
func_2C4A()
{
	level.littlebirds[self getentitynumber()] = self;
}

//Function Number: 77
func_2C4B()
{
	var_00 = self getentitynumber();
	self waittill("death");
	level.littlebirds[var_00] = undefined;
}

//Function Number: 78
exceededmaxlittlebirds(param_00)
{
	if(level.littlebirds.size >= 4 || level.littlebirds.size >= 2 && param_00 == "littlebird_flock")
	{
		return 1;
	}

	return 0;
}

//Function Number: 79
func_2C4D()
{
	for(var_00 = 0;var_00 < 10;var_00++)
	{
		if(!isdefined(self))
		{
			return;
		}

		playfxontag(level._effect["ac130_flare"],self,"TAG_FLARE");
		wait 0.15;
	}
}

//Function Number: 80
deployflares()
{
	var_00 = spawn("script_origin",self.origin + (0,0,-256));
	var_00.angles = self.angles;
	var_00 movegravity((0,0,-1),5);
	var_00 thread func_2C55(5);
	return var_00;
}

//Function Number: 81
heli_flares_monitor()
{
	switch(self.helitype)
	{
		case "osprey":
		case "osprey_gunner":
			self.numflares = 2;
			break;

		default:
			self.numflares = 1;
			break;
	}

	thread func_2C53();
	thread handleincomingstinger();
}

//Function Number: 82
handleincomingstinger(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self endon("helicopter_done");
	for(;;)
	{
		level waittill("stinger_fired",var_01,var_02,var_03);
		if(!isdefined(var_03) || var_03 != self)
		{
			continue;
		}

		if(isdefined(param_00))
		{
			var_02 thread [[ param_00 ]](var_01,var_01.team,var_03);
			continue;
		}

		var_02 thread func_2C52(var_01,var_01.team,var_03);
	}
}

//Function Number: 83
func_2C52(param_00,param_01,param_02)
{
	self endon("death");
	for(;;)
	{
		if(!isdefined(param_02))
		{
			break;
		}

		var_03 = param_02 getpointinbounds(0,0,0);
		var_04 = distance(self.origin,var_03);
		if(var_04 < 4000 && param_02.numflares > 0)
		{
			param_02.numflares--;
			param_02 thread func_2C4D();
			var_05 = param_02 deployflares();
			self missile_settargetent(var_05);
			return;
		}

		wait 0.05;
	}
}

//Function Number: 84
func_2C53(param_00)
{
	level endon("game_ended");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self endon("helicopter_done");
	for(;;)
	{
		level waittill("sam_fired",var_01,var_02,var_03);
		if(!isdefined(var_03) || var_03 != self)
		{
			continue;
		}

		if(isdefined(param_00))
		{
			level thread [[ param_00 ]](var_01,var_01.team,var_03,var_02);
			continue;
		}

		level thread watchsamproximity(var_01,var_01.team,var_03,var_02);
	}
}

//Function Number: 85
watchsamproximity(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	param_02 endon("death");
	for(;;)
	{
		var_04 = param_02 getpointinbounds(0,0,0);
		var_05 = [];
		for(var_06 = 0;var_06 < param_03.size;var_06++)
		{
			if(isdefined(param_03[var_06]))
			{
				var_05[var_06] = distance(param_03[var_06].origin,var_04);
			}
		}

		var_06 = 0;
		while(var_06 < var_05.size)
		{
			if(isdefined(var_05[var_06]))
			{
				if(var_05[var_06] < 4000 && param_02.numflares > 0)
				{
					param_02.numflares--;
					param_02 thread func_2C4D();
					var_07 = param_02 deployflares();
					for(var_08 = 0;var_08 < param_03.size;var_08++)
					{
						if(isdefined(param_03[var_08]))
						{
							param_03[var_08] missile_settargetent(var_07);
						}
					}

					return;
				}
			}

			var_08++;
		}

		wait 0.05;
	}
}

//Function Number: 86
func_2C55(param_00)
{
	wait param_00;
	self delete();
}

//Function Number: 87
func_2C56()
{
	self endon("death");
	self endon("disconnect");
	self playlocalsound(game["voice"][self.team] + "KS_hqr_pavelow");
	wait 3.5;
	self playlocalsound(game["voice"][self.team] + "KS_pvl_inbound");
}