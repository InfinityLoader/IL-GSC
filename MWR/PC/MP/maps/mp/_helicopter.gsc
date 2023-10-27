/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_helicopter.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 44
 * Decompile Time: 784 ms
 * Timestamp: 10/27/2023 2:38:30 AM
*******************************************************************/

//Function Number: 1
precachehelicopter(param_00)
{
	precachemodel(param_00);
}

//Function Number: 2
precacheassets()
{
	precacheitem("cobra_ffar_mp");
	precacheitem("hind_ffar_mp");
	precacheitem("cobra_20mm_mp");
	level.cobra_missile_models = [];
	level.cobra_missile_models["cobra_Hellfire"] = "projectile_hellfire_missile";
	precachemodel(level.cobra_missile_models["cobra_Hellfire"]);
	level.heli_sound["allies"]["hit"] = "h1_ks_chopper_damage_exp";
	level.heli_sound["allies"]["hitsecondary"] = "h1_ks_chopper_damage_exp";
	level.heli_sound["allies"]["damaged"] = "cobra_helicopter_damaged";
	level.heli_sound["allies"]["spinloop"] = "h1_ks_chopper_death_spin_mid";
	level.heli_sound["allies"]["spinstart"] = "cobra_helicopter_dying_layer";
	level.heli_sound["allies"]["crash"] = "h1_ks_chopper_crash_mid";
	level.heli_sound["allies"]["missilefire"] = "h1_ks_chopper_missile_shot";
	level.heli_sound["axis"]["hit"] = "h1_ks_chopper_damage_exp";
	level.heli_sound["axis"]["hitsecondary"] = "h1_ks_chopper_damage_exp";
	level.heli_sound["axis"]["damaged"] = "hind_helicopter_damaged";
	level.heli_sound["axis"]["spinloop"] = "h1_ks_chopper_death_spin_mid";
	level.heli_sound["axis"]["spinstart"] = "hind_helicopter_dying_layer";
	level.heli_sound["axis"]["crash"] = "h1_ks_chopper_crash_mid";
	level.heli_sound["axis"]["missilefire"] = "h1_ks_chopper_missile_shot";
}

//Function Number: 3
heli_path_graph()
{
	var_00 = getentorstructarray("heli_start","targetname");
	var_01 = getentorstructarray("heli_dest","targetname");
	var_02 = getentorstructarray("heli_loop_start","targetname");
	var_03 = getentorstructarray("heli_leave","targetname");
	var_04 = getentorstructarray("heli_crash_start","targetname");
	for(var_05 = 0;var_05 < var_01.size;var_05++)
	{
		var_06 = [];
		var_07 = var_01[var_05];
		var_08 = getentorstruct(var_07.target,"targetname");
		for(var_09 = 0;var_09 < var_00.size;var_09++)
		{
			var_0A = 0;
			for(var_0B = var_00[var_09];isdefined(var_0B.target);var_0B = var_0C)
			{
				var_0C = getentorstruct(var_0B.target,"targetname");
				if(var_0C.origin == var_08.origin)
				{
					var_0A = 1;
					break;
				}

				debug_print3d_simple("+",var_0B,(0,0,-10));
				if(isdefined(var_0C.target))
				{
					var_0D = getentorstruct(var_0C.target,"targetname");
					if(isdefined(var_0D) && isdefined(var_0D.origin))
					{
						debug_line(var_0C.origin,var_0D.origin,(0.25,0.5,0.25));
					}
				}

				if(isdefined(var_0B.script_delay))
				{
					debug_print3d_simple("Wait: " + var_0B.script_delay,var_0B,(0,0,10));
				}
			}

			if(var_0A)
			{
				var_06[var_06.size] = getentorstruct(var_00[var_09].target,"targetname");
			}
		}

		level.heli_paths[level.heli_paths.size] = var_06;
	}

	for(var_05 = 0;var_05 < var_02.size;var_05++)
	{
		var_0E = getentorstruct(var_02[var_05].target,"targetname");
		level.heli_loop_paths[level.heli_loop_paths.size] = var_0E;
	}

	for(var_05 = 0;var_05 < var_03.size;var_05++)
	{
		level.heli_leavenodes[level.heli_leavenodes.size] = var_03[var_05];
	}

	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		if(isdefined(var_04[var_05].target))
		{
			var_0F = getentorstruct(var_04[var_05].target,"targetname");
		}
		else
		{
			var_0F = var_04[var_05];
		}

		level.heli_crash_paths[level.heli_crash_paths.size] = var_0F;
	}
}

//Function Number: 4
getentorstruct(param_00,param_01)
{
	var_02 = getent(param_00,param_01);
	if(isdefined(var_02))
	{
		return var_02;
	}

	return common_scripts\utility::getstruct(param_00,param_01);
}

//Function Number: 5
getentorstructarray(param_00,param_01)
{
	var_02 = common_scripts\utility::getstructarray(param_00,param_01);
	var_03 = getentarray(param_00,param_01);
	if(var_03.size > 0)
	{
		var_02 = common_scripts\utility::array_combine(var_02,var_03);
	}

	return var_02;
}

//Function Number: 6
init()
{
	var_00 = getentorstructarray("heli_start","targetname");
	var_01 = getentorstructarray("heli_loop_start","targetname");
	if(!var_00.size && !var_01.size)
	{
		return;
	}

	precacheassets();
	precachehelicopter("vehicle_cobra_helicopter_fly");
	precachehelicopter("h1_vehicle_mi24_hind");
	level.chopper = undefined;
	level.heli_paths = [];
	level.heli_loop_paths = [];
	level.heli_leavenodes = [];
	level.heli_crash_paths = [];
	thread heli_update_global_dvars();
	level.chopper_fx["explode"]["death"] = loadfx("fx/explosions/helicopter_explosion_cobra");
	level.chopper_fx["explode"]["large"] = loadfx("fx/explosions/aerial_explosion_large");
	level.chopper_fx["explode"]["medium"] = loadfx("fx/explosions/aerial_explosion");
	level.chopper_fx["smoke"]["trail"] = loadfx("vfx/trail/trail_smk_white_heli");
	level.chopper_fx["fire"]["trail"]["medium"] = loadfx("vfx/trail/trail_smk_black_heli");
	level.chopper_fx["fire"]["trail"]["large"] = loadfx("vfx/trail/trail_fire_smoke_l");
	heli_path_graph();
}

//Function Number: 7
heli_update_global_dvars()
{
	level.heli_loopmax = heli_get_dvar_int("scr_heli_loopmax","1");
	level.heli_missile_rof = heli_get_dvar_int("scr_heli_missile_rof","5");
	level.heli_armor = heli_get_dvar_int("scr_heli_armor","500");
	level.heli_rage_missile = heli_get_dvar("scr_heli_rage_missile","5");
	level.heli_maxhealth = heli_get_dvar_int("scr_heli_maxhealth","1100");
	level.heli_missile_max = heli_get_dvar_int("scr_heli_missile_max","3");
	level.heli_dest_wait = heli_get_dvar_int("scr_heli_dest_wait","2");
	level.heli_debug = heli_get_dvar_int("scr_heli_debug","0");
	level.heli_targeting_delay = heli_get_dvar("scr_heli_targeting_delay","0.5");
	level.heli_turretreloadtime = heli_get_dvar("scr_heli_turretReloadTime","1.5");
	level.heli_turretclipsize = heli_get_dvar_int("scr_heli_turretClipSize","40");
	level.heli_visual_range = heli_get_dvar_int("scr_heli_visual_range","3500");
	level.heli_health_degrade = heli_get_dvar_int("scr_heli_health_degrade","0");
	level.heli_target_spawnprotection = heli_get_dvar_int("scr_heli_target_spawnprotection","5");
	level.heli_turret_engage_dist = heli_get_dvar_int("scr_heli_turret_engage_dist","1000");
	level.heli_missile_engage_dist = heli_get_dvar_int("scr_heli_missile_engage_dist","2000");
	level.heli_missile_regen_time = heli_get_dvar("scr_heli_missile_regen_time","10");
	level.heli_turret_spinup_delay = heli_get_dvar("scr_heli_turret_spinup_delay","0.75");
	level.heli_target_recognition = heli_get_dvar("scr_heli_target_recognition","0.5");
	level.heli_missile_friendlycare = heli_get_dvar_int("scr_heli_missile_friendlycare","256");
	level.heli_missile_target_cone = heli_get_dvar("scr_heli_missile_target_cone","0.3");
	level.heli_armor_bulletdamage = heli_get_dvar("scr_heli_armor_bulletdamage","0.3");
	level.heli_attract_strength = heli_get_dvar("scr_heli_attract_strength","1000");
	level.heli_attract_range = heli_get_dvar("scr_heli_attract_range","4096");
}

//Function Number: 8
heli_get_dvar_int(param_00,param_01)
{
	return int(param_01);
}

//Function Number: 9
heli_get_dvar(param_00,param_01)
{
	return float(param_01);
}

//Function Number: 10
spawn_helicopter(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = spawnhelicopter(param_00,param_01,param_02,param_03,param_04);
	var_05.attractor = missile_createattractorent(var_05,level.heli_attract_strength,level.heli_attract_range);
	return var_05;
}

//Function Number: 11
heli_think(param_00,param_01,param_02,param_03)
{
	var_04 = param_01.origin;
	var_05 = param_01.angles;
	if(param_02 == "allies")
	{
		var_06 = "vehicle_cobra_helicopter_fly";
		if(isdefined(level.heli_model_allies_override))
		{
			var_06 = level.heli_model_allies_override;
		}

		var_07 = spawn_helicopter(param_00,var_04,var_05,"cobra_mp",var_06);
		var_07 playloopsound("h1_ks_chopper_cobra_mid");
	}
	else
	{
		var_06 = "h1_vehicle_mi24_hind";
		if(isdefined(level.heli_model_axis_override))
		{
			var_07 = level.heli_model_axis_override;
		}

		var_07 = spawn_helicopter(param_01,var_05,var_06,"hind_mp",var_07);
		var_07 playloopsound("h1_ks_chopper_hind_mid");
	}

	var_07.requireddeathcount = param_00.deaths;
	var_07.team = param_02;
	var_07.pers["team"] = param_02;
	var_07.owner = param_00;
	var_07 setotherent(param_00);
	var_07 thread heli_existance();
	level.chopper = var_07;
	var_07.reached_dest = 0;
	var_07.maxhealth = level.heli_maxhealth;
	var_07.waittime = level.heli_dest_wait;
	var_07.loopcount = 0;
	var_07.evasive = 0;
	var_07.health_bulletdamageble = level.heli_armor;
	var_07.health_evasive = level.heli_armor;
	var_07.health_low = level.heli_maxhealth * 0.8;
	var_07.targeting_delay = level.heli_targeting_delay;
	var_07.primarytarget = undefined;
	var_07.secondarytarget = undefined;
	var_07.attacker = undefined;
	var_07.missile_ammo = level.heli_missile_max;
	var_07.currentstate = "ok";
	var_07.lastrocketfiretime = -1;
	var_07.helitype = "helicopter";
	var_07 common_scripts\utility::make_entity_sentient_mp(param_02);
	var_07 thread heli_fly(param_01);
	var_07 thread heli_damage_monitor();
	var_07 thread heli_health();
	var_07 thread attack_targets();
	var_07 thread heli_targeting();
	var_07 thread heli_missile_regen();
}

//Function Number: 12
aud_chopper_full_volume(param_00)
{
}

//Function Number: 13
heli_existance()
{
	common_scripts\utility::waittill_any("death","crashing","leaving");
	level notify("helicopter gone");
}

//Function Number: 14
heli_missile_regen()
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	for(;;)
	{
		debug_print3d("Missile Ammo: " + self.missile_ammo,(0.5,0.5,1),self,(0,0,-100),0);
		if(self.missile_ammo >= level.heli_missile_max)
		{
			self waittill("missile fired");
		}
		else if(self.currentstate == "heavy smoke")
		{
			wait(level.heli_missile_regen_time / 4);
		}
		else if(self.currentstate == "light smoke")
		{
			wait(level.heli_missile_regen_time / 2);
		}
		else
		{
			wait(level.heli_missile_regen_time);
		}

		if(self.missile_ammo < level.heli_missile_max)
		{
			self.missile_ammo++;
		}
	}
}

//Function Number: 15
heli_targeting()
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	for(;;)
	{
		var_00 = [];
		var_01 = level.players;
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			var_03 = var_01[var_02];
			if(cantarget_turret(var_03))
			{
				if(isdefined(var_03))
				{
					var_00[var_00.size] = var_03;
				}

				continue;
			}

			continue;
		}

		if(var_00.size == 0)
		{
			self.primarytarget = undefined;
			self.secondarytarget = undefined;
			debug_print_target();
			wait(self.targeting_delay);
			continue;
		}
		else if(var_00.size == 1)
		{
			update_player_threat(var_00[0]);
			self.primarytarget = var_00[0];
			self notify("primary acquired");
			self.secondarytarget = undefined;
			debug_print_target();
			wait(self.targeting_delay);
			continue;
		}
		else if(var_00.size > 1)
		{
			assigntargets(var_00);
		}

		debug_print_target();
	}
}

//Function Number: 16
cantarget_turret(param_00)
{
	var_01 = 1;
	if(!isalive(param_00) || param_00.sessionstate != "playing")
	{
		return 0;
	}

	if(distance(param_00.origin,self.origin) > level.heli_visual_range)
	{
		return 0;
	}

	if(!isdefined(param_00.pers["team"]))
	{
		return 0;
	}

	if(level.teambased && param_00.pers["team"] == self.team)
	{
		return 0;
	}

	if(isdefined(self.owner) && param_00 == self.owner)
	{
		return 0;
	}

	if(param_00.pers["team"] == "spectator")
	{
		return 0;
	}

	if(isdefined(param_00.spawntime) && gettime() - param_00.spawntime / 1000 <= level.heli_target_spawnprotection)
	{
		return 0;
	}

	var_02 = self.origin + (0,0,-160);
	var_03 = anglestoforward(self.angles);
	var_04 = var_02 + 144 * var_03;
	if(param_00 sightconetrace(var_04,self,1) < level.heli_target_recognition)
	{
		return 0;
	}

	return var_01;
}

//Function Number: 17
assigntargets(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		update_player_threat(param_00[var_01]);
	}

	var_02 = 0;
	var_03 = 0;
	var_04 = undefined;
	var_05 = undefined;
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		if(param_00[var_01].threatlevel >= var_02)
		{
			var_02 = param_00[var_01].threatlevel;
			var_04 = param_00[var_01];
		}
	}

	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		if(param_00[var_01].threatlevel >= var_03 && param_00[var_01] != var_04)
		{
			var_03 = param_00[var_01].threatlevel;
			var_05 = param_00[var_01];
		}
	}

	self.primarytarget = var_04;
	self notify("primary acquired");
	self.secondarytarget = var_05;
	self notify("secondary acquired");
	wait(self.targeting_delay);
}

//Function Number: 18
update_player_threat(param_00)
{
	param_00.threatlevel = 0;
	var_01 = distance(param_00.origin,self.origin);
	param_00.threatlevel = param_00.threatlevel + level.heli_visual_range - var_01 / level.heli_visual_range * 100;
	if(isdefined(self.attacker) && param_00 == self.attacker)
	{
		param_00.threatlevel = param_00.threatlevel + 100;
	}

	if(isdefined(param_00.pers["class"]) && param_00.pers["class"] == "CLASS_ASSAULT" || param_00.pers["class"] == "CLASS_RECON")
	{
		param_00.threatlevel = param_00.threatlevel + 200;
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

//Function Number: 19
heli_reset()
{
	self cleartargetyaw();
	self cleargoalyaw();
	self vehicle_setspeed(60,25);
	self setyawspeed(75,45,45);
	self setmaxpitchroll(30,30);
	self neargoalnotifydist(256);
	self setturningability(0.9);
}

//Function Number: 20
heli_wait(param_00)
{
	self endon("death");
	self endon("crashing");
	self endon("evasive");
	wait(param_00);
}

//Function Number: 21
heli_damage_monitor()
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self.damagetaken = 0;
	self.attackerlist = [];
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(!isdefined(var_01) || !isplayer(var_01))
		{
			continue;
		}

		var_0A = maps\mp\gametypes\_weapons::friendlyfirecheck(self.owner,var_01);
		if(!var_0A)
		{
			continue;
		}

		if(isdefined(self.owner) && var_01 == self.owner)
		{
			continue;
		}

		if(level.teambased)
		{
			var_0B = isdefined(var_01.pers["team"]) && var_01.pers["team"] != self.team;
		}
		else
		{
			var_0B = 1;
		}

		if(!var_0B)
		{
			continue;
		}

		var_01 thread maps\mp\gametypes\_damagefeedback::updatedamagefeedback(0);
		self.attacker = var_01;
		maps\mp\gametypes\_hardpoints::killstreakhit(var_01,var_09,self);
		if(maps\mp\gametypes\_damage::isnewattacker(var_01))
		{
			self.attackerlist[self.attackerlist.size] = var_01;
		}

		if(var_04 == "MOD_RIFLE_BULLET" || var_04 == "MOD_PISTOL_BULLET")
		{
			if(self.damagetaken >= self.health_bulletdamageble)
			{
				self.damagetaken = self.damagetaken + var_00;
			}
			else
			{
				self.damagetaken = self.damagetaken + var_00 * level.heli_armor_bulletdamage;
			}
		}
		else
		{
			self.damagetaken = self.damagetaken + var_00;
		}

		if(self.damagetaken > self.maxhealth)
		{
			var_01 notify("destroyed_helicopter");
			maps\mp\gametypes\_damage::onkillstreakkilled(var_01,var_09,var_04,var_00,"helicopter_destroyed",undefined,"callout_destroyed_helicopter",1);
			return;
		}
	}
}

//Function Number: 22
heli_health()
{
	self endon("death");
	self endon("leaving");
	self endon("crashing");
	self.currentstate = "ok";
	self.laststate = "ok";
	self setdamagestage(3);
	for(;;)
	{
		if(self.health_bulletdamageble > self.health_low)
		{
			if(self.damagetaken >= self.health_bulletdamageble)
			{
				self.currentstate = "heavy smoke";
			}
			else if(self.damagetaken >= self.health_low)
			{
				self.currentstate = "light smoke";
			}
		}
		else if(self.damagetaken >= self.health_low)
		{
			self.currentstate = "heavy smoke";
		}
		else if(self.damagetaken >= self.health_bulletdamageble)
		{
			self.currentstate = "light smoke";
		}

		if(self.currentstate == "light smoke" && self.laststate != "light smoke")
		{
			self setdamagestage(2);
			self.laststate = self.currentstate;
		}

		if(self.currentstate == "heavy smoke" && self.laststate != "heavy smoke")
		{
			self setdamagestage(1);
			self notify("stop body smoke");
			self.laststate = self.currentstate;
		}

		if(self.currentstate == "heavy smoke")
		{
			self.damagetaken = self.damagetaken + level.heli_health_degrade;
			level.heli_rage_missile = 20;
		}

		if(self.currentstate == "light smoke")
		{
			self.damagetaken = self.damagetaken + level.heli_health_degrade / 2;
			level.heli_rage_missile = 10;
		}

		if(self.damagetaken >= self.health_evasive)
		{
			if(!self.evasive)
			{
				thread heli_evasive();
			}
		}

		if(self.damagetaken > self.maxhealth)
		{
			self setdamagestage(0);
			thread heli_crash();
		}

		if(self.damagetaken <= level.heli_armor)
		{
			debug_print3d_simple("Armor: " + level.heli_armor - self.damagetaken,self,(0,0,100),20);
		}
		else
		{
			debug_print3d_simple("Health: " + self.maxhealth - self.damagetaken,self,(0,0,100),20);
		}

		wait(1);
	}
}

//Function Number: 23
heli_evasive()
{
	self notify("evasive");
	self.evasive = 1;
	var_00 = level.heli_loop_paths[0];
	thread heli_fly(var_00);
}

//Function Number: 24
heli_crash()
{
	self notify("crashing");
	thread heli_fly(level.heli_crash_paths[0]);
	thread heli_spin(180);
	self waittill("path start");
	playfxontag(level.chopper_fx["explode"]["large"],self,"tag_engine_left");
	self playsound(level.heli_sound[self.team]["hitsecondary"]);
	thread trail_fx(level.chopper_fx["fire"]["trail"]["large"],"tag_engine_left","stop body fire");
	self waittill("destination reached");
	thread heli_explode();
}

//Function Number: 25
heli_spin(param_00)
{
	self endon("death");
	playfxontag(level.chopper_fx["explode"]["medium"],self,"tail_rotor_jnt");
	self playsound(level.heli_sound[self.team]["hit"]);
	thread spinsoundshortly();
	thread trail_fx(level.chopper_fx["smoke"]["trail"],"tail_rotor_jnt","stop tail smoke");
	self setyawspeed(param_00,param_00,param_00);
	while(isdefined(self))
	{
		self settargetyaw(self.angles[1] + param_00 * 0.9);
		wait(1);
	}
}

//Function Number: 26
spinsoundshortly()
{
	self endon("death");
	wait(0.25);
	self stoploopsound();
	wait(0.05);
	self playloopsound(level.heli_sound[self.team]["spinloop"]);
	wait(0.05);
}

//Function Number: 27
trail_fx(param_00,param_01,param_02)
{
	self notify(param_02);
	self endon(param_02);
	self endon("death");
	for(;;)
	{
		playfxontag(param_00,self,param_01);
		wait(0.05);
	}
}

//Function Number: 28
heli_explode()
{
	self notify("death");
	var_00 = self.origin + (0,0,100) - self.origin;
	playfx(level.chopper_fx["explode"]["death"],self.origin,var_00);
	self playsound(level.heli_sound[self.team]["crash"]);
	level.chopper = undefined;
	self delete();
}

//Function Number: 29
heli_leave()
{
	self notify("desintation reached");
	self notify("leaving");
	self scalevolume(0,5);
	var_00 = randomint(level.heli_leavenodes.size);
	var_01 = level.heli_leavenodes[var_00];
	heli_reset();
	self vehicle_setspeed(100,45);
	self setgoalpos(var_01.origin,1);
	self waittillmatch("goal");
	self notify("death");
	level.chopper = undefined;
	self delete();
}

//Function Number: 30
heli_fly(param_00)
{
	self endon("death");
	self notify("flying");
	self endon("flying");
	self endon("abandoned");
	self.reached_dest = 0;
	heli_reset();
	var_01 = self.origin;
	wait(2);
	while(isdefined(param_00.target))
	{
		maps\mp\gametypes\_hostmigration::waittillhostmigrationdone();
		var_02 = getentorstruct(param_00.target,"targetname");
		var_01 = var_02.origin + (0,0,30);
		if(isdefined(param_00.script_airspeed) && isdefined(param_00.script_accel))
		{
			var_03 = param_00.script_airspeed;
			var_04 = param_00.script_accel;
		}
		else
		{
			var_03 = 30 + randomint(20);
			var_04 = 15 + randomint(15);
		}

		if(!isdefined(var_02.target))
		{
			var_05 = 1;
		}
		else
		{
			var_05 = 0;
		}

		debug_line(param_00.origin,var_02.origin,(1,0.5,0.5),200);
		if(self.currentstate == "heavy smoke" || self.currentstate == "light smoke")
		{
			self vehicle_setspeed(var_03,var_04);
			self setgoalpos(var_01,var_05);
			self waittill("near_goal");
			self notify("path start");
		}
		else
		{
			if(isdefined(var_02.script_delay))
			{
				var_05 = 1;
			}

			self vehicle_setspeed(var_03,var_04);
			self setgoalpos(var_01,var_05);
			if(!isdefined(var_02.script_delay))
			{
				self waittill("near_goal");
				self notify("path start");
			}
			else
			{
				self setgoalyaw(var_02.angles[1]);
				self waittillmatch("goal");
				heli_wait(var_02.script_delay);
			}
		}

		for(var_06 = 0;var_06 < level.heli_loop_paths.size;var_06++)
		{
			if(level.heli_loop_paths[var_06].origin == var_02.origin)
			{
				self.loopcount++;
			}
		}

		if(self.loopcount >= level.heli_loopmax)
		{
			thread heli_leave();
			return;
		}

		param_00 = var_02;
	}

	self setgoalyaw(param_00.angles[1]);
	self.reached_dest = 1;
	self notify("destination reached");
	heli_wait(self.waittime);
	if(isdefined(self))
	{
		thread heli_evasive();
	}
}

//Function Number: 31
fire_missile(param_00,param_01,param_02)
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
			break;

		default:
			break;
	}
}

//Function Number: 32
check_owner()
{
	if(!isdefined(self.owner) || !isdefined(self.owner.pers["team"]) || self.owner.pers["team"] != self.team)
	{
		self notify("abandoned");
		thread heli_leave();
	}
}

//Function Number: 33
attack_targets()
{
	thread attack_primary();
	thread attack_secondary();
}

//Function Number: 34
attack_secondary()
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
				if(missile_target_sight_check(self.missiletarget))
				{
					thread missile_support(self.missiletarget,level.heli_missile_rof,1,undefined);
				}
				else
				{
					break;
				}

				var_00 = var_00 + 100;
				self.missiletarget.antithreat = var_00;
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

//Function Number: 35
missile_target_sight_check(param_00)
{
	var_01 = vectornormalize(param_00.origin - self.origin);
	var_02 = anglestoforward(self.angles);
	var_03 = vectornormalize(var_02);
	var_04 = vectordot(var_01,var_03);
	if(var_04 >= level.heli_missile_target_cone)
	{
		debug_print3d_simple("Missile sight: " + var_04,self,(0,0,-40),40);
		return 1;
	}

	return 0;
}

//Function Number: 36
missile_support(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	if(isdefined(param_03))
	{
		self endon(param_03);
	}

	self.turret_giveup = 0;
	if(!param_02)
	{
		wait(param_01);
		self.turret_giveup = 1;
		self notify("give up");
	}

	if(isdefined(param_00))
	{
		if(level.teambased)
		{
			for(var_04 = 0;var_04 < level.players.size;var_04++)
			{
				var_05 = level.players[var_04];
				if(isdefined(var_05.pers["team"]) && var_05.pers["team"] == self.team && distance(var_05.origin,param_00.origin) <= level.heli_missile_friendlycare)
				{
					debug_print3d_simple("Missile omitted due to nearby friendly",self,(0,0,-80),40);
					self notify("missile ready");
					return;
				}
			}
		}
		else
		{
			var_05 = self.owner;
			if(isdefined(var_05) && isdefined(var_05.pers["team"]) && var_05.pers["team"] == self.team && distance(var_05.origin,param_00.origin) <= level.heli_missile_friendlycare)
			{
				debug_print3d_simple("Missile omitted due to nearby friendly",self,(0,0,-80),40);
				self notify("missile ready");
				return;
			}
		}
	}

	if(self.missile_ammo > 0 && isdefined(param_00))
	{
		fire_missile("ffar",1,param_00);
		self.missile_ammo--;
		self notify("missile fired");
	}
	else
	{
		return;
	}

	if(param_02)
	{
		wait(param_01);
		self notify("missile ready");
	}
}

//Function Number: 37
attack_primary()
{
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	for(;;)
	{
		if(isdefined(self.primarytarget))
		{
			self.primarytarget.antithreat = undefined;
			self.turrettarget = self.primarytarget;
			var_00 = 0;
			var_01 = undefined;
			while(isdefined(self.turrettarget) && isalive(self.turrettarget))
			{
				self setturrettargetent(self.turrettarget,(0,0,40));
				if(missile_target_sight_check(self.turrettarget))
				{
					thread missile_support(self.turrettarget,10 / level.heli_rage_missile,0,"turret on target");
				}

				self waittill("turret_on_target");
				self notify("turret on target");
				thread turret_target_flag(self.turrettarget);
				wait(level.heli_turret_spinup_delay);
				var_02 = weaponfiretime("cobra_20mm_mp");
				self setvehweapon("cobra_20mm_mp");
				for(var_03 = 0;var_03 < level.heli_turretclipsize;var_03++)
				{
					if(isdefined(self.turrettarget) && isdefined(self.primarytarget))
					{
						if(self.primarytarget != self.turrettarget)
						{
							self setturrettargetent(self.primarytarget,(0,0,40));
						}
					}
					else if(isdefined(self.targetlost) && self.targetlost && isdefined(self.turret_last_pos))
					{
						self setturrettargetvec(self.turret_last_pos);
					}
					else
					{
						self clearturrettargetent();
					}

					if(gettime() != self.lastrocketfiretime)
					{
						self setvehweapon("cobra_20mm_mp");
						var_04 = self fireweapon("tag_flash");
					}

					if(var_03 < level.heli_turretclipsize - 1)
					{
						wait(var_02);
					}
				}

				self notify("turret reloading");
				wait(level.heli_turretreloadtime);
				if(isdefined(self.turrettarget) && isalive(self.turrettarget))
				{
					var_00 = var_00 + 100;
					self.turrettarget.antithreat = var_00;
				}

				if(!isdefined(self.primarytarget) || isdefined(self.turrettarget) && isdefined(self.primarytarget) && self.primarytarget != self.turrettarget)
				{
					break;
				}
			}

			if(isdefined(self.turrettarget))
			{
				self.turrettarget.antithreat = undefined;
			}
		}

		self waittill("primary acquired");
		check_owner();
	}
}

//Function Number: 38
turret_target_flag(param_00)
{
	self notify("flag check is running");
	self endon("flag check is running");
	self endon("death");
	self endon("crashing");
	self endon("leaving");
	self endon("turret reloading");
	param_00 endon("death");
	param_00 endon("disconnect");
	self.targetlost = 0;
	self.turret_last_pos = undefined;
	while(isdefined(param_00))
	{
		var_01 = self.origin + (0,0,-160);
		var_02 = anglestoforward(self.angles);
		var_03 = var_01 + 144 * var_02;
		var_04 = param_00 sightconetrace(var_03,self,1);
		if(var_04 < level.heli_target_recognition)
		{
			break;
		}

		wait(0.05);
	}

	if(isdefined(param_00) && isdefined(param_00.origin))
	{
		self.turret_last_pos = param_00.origin + (0,0,40);
		self setturrettargetvec(self.turret_last_pos);
		debug_print3d_simple("Turret target lost at: " + self.turret_last_pos,self,(0,0,-70),60);
		self.targetlost = 1;
		return;
	}

	self.targetlost = undefined;
	self.turret_last_pos = undefined;
}

//Function Number: 39
debug_print_target()
{
	if(isdefined(level.heli_debug) && level.heli_debug == 1)
	{
		if(isdefined(self.primarytarget) && isdefined(self.primarytarget.threatlevel))
		{
			var_00 = "Primary: " + self.primarytarget.name + " : " + self.primarytarget.threatlevel;
		}
		else
		{
			var_00 = "Primary: ";
		}

		if(isdefined(self.secondarytarget) && isdefined(self.secondarytarget.threatlevel))
		{
			var_01 = "Secondary: " + self.secondarytarget.name + " : " + self.secondarytarget.threatlevel;
		}
		else
		{
			var_01 = "Secondary: ";
		}

		var_02 = int(self.targeting_delay * 20) + 1;
		thread draw_text(var_00,(1,0.6,0.6),self,(0,0,40),var_02);
		thread draw_text(var_01,(1,0.6,0.6),self,(0,0,0),var_02);
	}
}

//Function Number: 40
debug_print3d(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(level.heli_debug) && level.heli_debug == 1)
	{
		thread draw_text(param_00,param_01,param_02,param_03,param_04);
	}
}

//Function Number: 41
debug_print3d_simple(param_00,param_01,param_02,param_03)
{
	if(isdefined(level.heli_debug) && level.heli_debug == 1)
	{
		if(isdefined(param_03))
		{
			thread draw_text(param_00,(0.8,0.8,0.8),param_01,param_02,param_03);
			return;
		}

		thread draw_text(param_00,(0.8,0.8,0.8),param_01,param_02,0);
	}
}

//Function Number: 42
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

//Function Number: 43
draw_text(param_00,param_01,param_02,param_03,param_04)
{
	if(param_04 == 0)
	{
		while(isdefined(param_02))
		{
			wait(0.05);
		}

		return;
	}

	for(var_05 = 0;var_05 < param_04;var_05++)
	{
		if(!isdefined(param_02))
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 44
draw_line(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		for(var_04 = 0;var_04 < param_03;var_04++)
		{
			wait(0.05);
		}

		return;
	}

	wait(0.05);
}