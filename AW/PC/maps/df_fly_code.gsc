/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: df_fly_code.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 363 ms
 * Timestamp: 4/22/2024 2:28:42 AM
*******************************************************************/

//Function Number: 1
precache_code()
{
	precacheitem("sam_dogfight");
	precacheitem("s19_cannon_ground_turret");
}

//Function Number: 2
radio_dialog_add_and_go(param_00,param_01)
{
	maps\_utility::radio_add(param_00);
	maps\_utility::radio_dialogue(param_00,param_01);
}

//Function Number: 3
char_dialog_add_and_go(param_00)
{
	level.scr_sound[self.animname][param_00] = param_00;
	maps\_utility::dialogue_queue(param_00);
}

//Function Number: 4
ai_array_killcount_flag_set(param_00,param_01,param_02,param_03)
{
	waittill_vehicles_dead(param_00,param_01,param_03);
	common_scripts\utility::flag_set(param_02);
}

//Function Number: 5
waittill_vehicles_dead(param_00,param_01,param_02)
{
	var_03 = [];
	foreach(var_05 in param_00)
	{
		if(isalive(var_05))
		{
			var_03[var_03.size] = var_05;
		}
	}

	param_00 = var_03;
	var_07 = spawnstruct();
	if(isdefined(param_02))
	{
		var_07 endon("thread_timed_out");
		var_07 thread maps\_utility::waittill_dead_timeout(param_02);
	}

	var_07.count = param_00.size;
	if(isdefined(param_01) && param_01 < var_07.count)
	{
		var_07.count = param_01;
	}

	common_scripts\utility::array_thread(param_00,::maps\_utility::waittill_dead_thread,var_07);
	while(var_07.count > 0)
	{
		var_07 waittill("waittill_dead guy died");
	}
}

//Function Number: 6
plane_in_formation(param_00,param_01,param_02)
{
	param_02 = param_02 * param_02;
	for(var_03 = 0;var_03 < param_01.size;var_03++)
	{
		var_04 = distancesquared(param_00.origin,param_01[var_03].origin);
		if(var_04 < param_02)
		{
			if(vectordot(anglestoforward(param_00.angles),anglestoforward(param_01[var_03].angles)) > 0)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 7
wait_for_formation(param_00,param_01,param_02)
{
	var_03 = gettime() + param_02 * 1000;
	var_04 = plane_in_formation(self,param_00,param_01);
	while(gettime() < var_03 || !var_04)
	{
		wait(0.1);
		var_04 = plane_in_formation(self,param_00,param_01);
		if(!var_04)
		{
			var_03 = gettime() + param_02 * 1000;
		}
	}

	self notify("in_formation");
}

//Function Number: 8
wait_for_formation_break(param_00,param_01,param_02)
{
	level endon("ignore_formation");
	var_03 = gettime() + param_02 * 1000;
	var_04 = plane_in_formation(self,param_00,param_01);
	while(gettime() < var_03 || var_04)
	{
		wait(0.1);
		var_04 = plane_in_formation(self,param_00,param_01);
		if(var_04)
		{
			var_03 = gettime() + param_02 * 1000;
		}
	}

	self notify("broke_formation");
}

//Function Number: 9
shoot_sam_missiles(param_00)
{
	foreach(var_02 in param_00)
	{
		thread shoot_sam_missile(var_02);
		wait(0.2);
	}
}

//Function Number: 10
shoot_sam_missile(param_00,param_01)
{
	if(maps\_utility::hastag(self.model,"tag_flash"))
	{
		var_02 = self gettagorigin("tag_flash");
		var_03 = var_02 + (0,0,100);
	}
	else
	{
		var_03 = maps\df_fly_flight_code::offset_position_from_tag("forward","tag_origin",200);
		var_03 = var_03 + (0,0,100);
		var_02 = maps\df_fly_flight_code::offset_position_from_tag("forward","tag_origin",50);
	}

	if(!isdefined(param_01))
	{
		param_01 = self.origin + (0,0,12000);
		param_01 = param_01 + param_00.origin;
		param_01 = param_01 / 2;
	}

	var_04 = vectornormalize(param_01 - self.origin);
	var_05 = self.origin + var_04 * 2000;
	var_06 = magicbullet("sam_dogfight",var_03,param_01 + (randomfloatrange(-1000,1000),randomfloatrange(-1000,1000),randomfloatrange(-1000,1000)));
	playfx(common_scripts\utility::getfx("turret_gun_muzzle"),var_02,vectornormalize(param_01 - var_02));
	self playsound("canyon_missile_fire_npc");
	wait(0.25);
	if(isdefined(var_06) && isvalidmissile(var_06) && isdefined(param_00))
	{
		var_06 missile_settargetent(param_00);
		var_06 thread maps\df_fly_flight_code::monitor_missile_death(1,self,undefined,param_00);
		wait(2);
		return;
	}

	var_07 = 1;
}

//Function Number: 11
turret_ai()
{
	var_00 = 3;
	var_01 = 0.4;
	var_02 = 3;
	var_03 = 50000;
	self endon("death");
	var_04 = isdefined(self.script_parameters) && self.script_parameters == "missiles";
	var_05 = isdefined(self.script_parameters) && self.script_parameters == "missiles_only";
	var_06 = isdefined(self.script_parameters) && self.script_parameters == "none";
	if(var_06)
	{
		return;
	}

	if(var_05)
	{
		var_04 = 1;
	}

	if(!isdefined(level.last_turret_missile_time))
	{
		level.last_turret_missile_time = 0;
	}

	while(isalive(self))
	{
		var_07 = gettime();
		if(var_04 && var_07 >= level.last_turret_missile_time + var_02 * 1000)
		{
			var_08 = turret_choose_targets(5000,var_03);
		}
		else
		{
			var_08 = turret_choose_targets(0,var_03);
		}

		if(var_08.size > 0 && !isremovedentity(var_08[0]))
		{
			var_09 = var_08[0];
			if(var_04 && var_07 >= level.last_turret_missile_time + var_02 * 1000 && var_08.size >= 2)
			{
				if(var_05)
				{
					var_0A = [];
					for(var_0B = 0;var_0B < var_08.size && var_0B <= 4;var_0B++)
					{
						var_0A[var_0A.size] = var_08[var_0B];
					}

					shoot_sam_missiles(var_0A);
				}
				else
				{
					shoot_sam_missiles(maps\_utility::make_array(var_08[0]));
				}

				level.last_turret_missile_time = var_07;
				wait(0.2);
			}

			if(var_05)
			{
				wait(0.05);
				continue;
			}

			var_0C = var_07 + var_00 + randomfloatrange(-0.5,0.5) * 1000;
			var_0D = vectortoangles(var_09.origin - self.origin);
			self playloopsound("ground_turret_mgun_lp_npc");
			self rotateto(var_0D,var_0C - 1);
			while(var_07 < var_0C && !isremovedentity(var_09))
			{
				var_0E = var_09.origin;
				if(maps\_utility::hastag(self.model,"tag_flash"))
				{
					var_0F = self gettagorigin("tag_flash");
					var_10 = var_0F;
					var_11 = undefined;
					var_12 = vectornormalize(var_0E - var_0F);
					var_10 = var_10 + var_12 * 100;
				}
				else
				{
					var_10 = maps\df_fly_flight_code::offset_position_from_tag("right","tag_origin",100) + (0,0,100);
					var_11 = maps\df_fly_flight_code::offset_position_from_tag("left","tag_origin",100) + (0,0,100);
					var_0F = maps\df_fly_flight_code::offset_position_from_tag("forward","tag_origin",50) + (0,0,100);
					var_12 = vectornormalize(var_0E - var_0F);
				}

				playfx(common_scripts\utility::getfx("turret_gun_muzzle"),var_0F,var_12);
				var_13 = magicbullet("s19_cannon_ground_turret",var_10,var_0E);
				if(isdefined(var_11))
				{
					wait(0.1);
					var_13 = magicbullet("s19_cannon_ground_turret",var_11,var_0E);
				}

				wait(0.2);
				var_07 = gettime();
			}

			self stoploopsound();
			self playsound("ground_turret_mgun_end_npc");
			wait(randomfloatrange(0.2,0.4));
			continue;
		}

		wait(0.2);
	}
}

//Function Number: 12
turret_choose_targets(param_00,param_01)
{
	param_00 = float(param_00 * param_00);
	param_01 = float(param_01 * param_01);
	var_02 = level.plane;
	var_03 = distancesquared(self.origin,level.plane.origin);
	var_04 = [var_02];
	var_05 = common_scripts\utility::array_combine(level.allies,level.friend_jets);
	foreach(var_07 in var_05)
	{
		if(isalive(var_07))
		{
			var_08 = distancesquared(self.origin,var_07.origin);
			if(var_08 <= param_01 && var_08 >= param_00)
			{
				if(var_08 < var_03)
				{
					var_03 = var_08;
					var_02 = var_07;
					var_04 = common_scripts\utility::array_insert(var_04,var_02,0);
				}
				else
				{
					var_04 = common_scripts\utility::array_add(var_04,var_02);
				}
			}
		}
	}

	if(var_03 > param_01)
	{
		var_02 = undefined;
		var_04 = [];
	}

	return var_04;
}

//Function Number: 13
handle_turrets(param_00,param_01,param_02)
{
	common_scripts\utility::flag_wait(param_01);
	var_03 = getentarray(param_00,"targetname");
	if(!isdefined(level.enemy_units))
	{
		level.enemy_units = [];
	}

	foreach(var_05 in var_03)
	{
		var_05 setcandamage(1);
		var_05 setcanradiusdamage(1);
		var_05.default_hud = "hud_fofbox_hostile_obstructed";
		var_05.health = 10000;
		var_05.ground_target = 1;
		level.enemy_units[level.enemy_units.size] = var_05;
		var_05 thread maps\df_fly_flight_code::hud_target_think(500);
		var_05 thread turret_ai();
		var_05 thread wait_for_damage();
		if(isdefined(var_05.animation))
		{
			var_05.animname = "turret";
			var_05 useanimtree(level.scr_animtree[var_05.animname]);
			if(isarray(level.scr_anim["turret"][var_05.animation]))
			{
				var_05 thread maps\_anim::anim_loop_solo(var_05,var_05.animation);
				continue;
			}

			var_05 playloopsound("canyon_hover_drone_lp");
			if(isdefined(var_05.script_delay))
			{
				var_05 maps\_utility::delaythread(var_05.script_delay,::maps\_anim::anim_single_solo,var_05,var_05.animation);
				continue;
			}

			var_05 thread maps\_anim::anim_single_solo(var_05,var_05.animation);
		}
	}

	common_scripts\utility::flag_wait(param_02);
	level.enemy_units = common_scripts\utility::array_remove_array(level.enemy_units,var_03);
	array_safe_delete(var_03);
}

//Function Number: 14
handle_flak_cannons(param_00,param_01,param_02)
{
	common_scripts\utility::flag_wait(param_01);
	var_03 = getentarray(param_00,"targetname");
	if(!isdefined(level.enemy_units))
	{
		level.enemy_units = [];
	}

	foreach(var_05 in var_03)
	{
		var_05.default_hud = "hud_fofbox_hostile_obstructed";
		var_05 setcandamage(1);
		var_05 setcanradiusdamage(1);
		var_05.health = 10000;
		var_05.ground_target = 1;
		level.enemy_units[level.enemy_units.size] = var_05;
		var_05 thread maps\df_fly_flight_code::hud_target_think();
		var_05 thread wait_for_damage();
	}

	common_scripts\utility::flag_wait(param_02);
	var_03 = maps\_utility::remove_dead_from_array(var_03);
	level.enemy_units = common_scripts\utility::array_remove_array(level.enemy_units,var_03);
	array_safe_delete(var_03);
}

//Function Number: 15
wait_for_damage()
{
	var_00 = 0;
	var_01 = self;
	while(var_00 < 10 && var_01 != level.player)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
	}

	if(var_01 == level.player)
	{
		level.player maps\_upgrade_challenge::give_player_challenge_kill(1);
	}

	if(!isdefined(self))
	{
		return;
	}

	self notify("kill_target_think");
	if(target_istarget(self))
	{
		target_hidefromplayer(self,level.player);
		target_remove(self);
	}

	if(isdefined(self.animation) && self.animation == "dogfight_canyon_mwp_hover" || !isarray(level.scr_anim["turret"][self.animation]))
	{
		playfx(common_scripts\utility::getfx("bagh_aircraft_explosion_midair"),self.origin);
		self stoploopsound();
		if(maps\_utility::hastag(self.model,"tag_origin"))
		{
			var_05 = playfxontag(common_scripts\utility::getfx("bagh_aircraft_damage_trail_huge"),self,"tag_origin");
		}
		else
		{
			var_05 = playfx(common_scripts\utility::getfx("bagh_aircraft_damage_trail_huge"),self.origin);
		}

		maps\_anim::anim_single_solo(self,"crash");
		if(isdefined(self) && maps\_utility::hastag(self.model,"tag_origin"))
		{
			stopfxontag(common_scripts\utility::getfx("bagh_aircraft_damage_trail_huge"),self,"tag_origin");
		}
	}
	else
	{
		playfx(common_scripts\utility::getfx("canyon_jet_impact"),self.origin);
	}

	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 16
setup_destructibles()
{
	var_00 = getentarray("canyon_destructible","script_noteworthy");
	common_scripts\utility::array_thread(var_00,::handle_canyon_destructible);
	var_00 = getentarray("canyon_destructible_clip","targetname");
	common_scripts\utility::array_thread(var_00,::handle_canyon_destructible_clips);
	var_00 = getentarray("canyon_turret_clip","targetname");
	common_scripts\utility::array_thread(var_00,::handle_canyon_turret_clips);
}

//Function Number: 17
handle_canyon_turret_clips()
{
	if(isdefined(self.target) && isdefined(self.script_noteworthy))
	{
		var_00 = getent(self.target,"script_noteworthy");
		self linkto(var_00,self.script_noteworthy);
	}
}

//Function Number: 18
handle_canyon_destructible_clips()
{
	if(isdefined(self.target) && isdefined(self.script_parameters))
	{
		var_00 = getent(self.target,"targetname");
		self linkto(var_00,self.script_parameters);
	}
}

//Function Number: 19
handle_canyon_destructible(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	var_01 = undefined;
	if(isdefined(self.script_parameters))
	{
		var_02 = strtok(self.script_parameters," ");
		var_01 = int(var_02[0]);
		if(var_02.size > 1)
		{
			var_03 = var_02[1];
			thread waitforhoodooflag(var_03);
		}

		if(var_02.size > 2)
		{
			param_00 = var_02[2] != "noshoot";
		}
	}

	self.animname = self.animation;
	self useanimtree(level.scr_animtree[self.animation]);
	if(param_00)
	{
		self setcandamage(1);
		self setcanradiusdamage(1);
		self.health = 100;
		self.maxhealth = 100;
		thread waitforhoodoodamage();
	}

	self waittill("fall_down");
	if(isdefined(var_01) && var_01 > 0)
	{
		common_scripts\_exploder::exploder(var_01);
	}

	soundscripts\_snd::snd_message("destructable_destroyed",self);
	thread maps\_anim::anim_single_solo(self,"destroy");
}

//Function Number: 20
waitforhoodooflag(param_00)
{
	common_scripts\utility::flag_wait(param_00);
	self notify("fall_down");
}

//Function Number: 21
waitforhoodoodamage()
{
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		self.health = self.maxhealth;
		if(var_04 == "mod_projectile" || var_04 == "mod_projectile_splash")
		{
			continue;
		}

		self notify("fall_down");
		break;
	}
}

//Function Number: 22
handle_missile_jet(param_00,param_01,param_02,param_03,param_04)
{
	common_scripts\utility::flag_wait(param_00);
	var_05 = getent(param_01,"targetname");
	var_06 = var_05 thread maps\_vehicle::spawn_vehicle_and_gopath();
	var_07 = var_06;
	var_08 = "tag_left_wingtip";
	var_09 = undefined;
	var_0A = common_scripts\utility::getfx("bagh_aircraft_damage_fire_trail");
	if(maps\df_fly_flight_code::is_true(param_04))
	{
		var_09 = maps\_utility::spawn_anim_model("refueler");
		var_09.origin = var_06.origin;
		var_09.angles = var_06.angles;
		var_09 linkto(var_06,"tag_origin",(0,0,0),(0,0,0));
		var_06 hide();
		var_07 = var_09;
		var_08 = "TAG_LT_WING_LIGHT_FX";
		var_0A = common_scripts\utility::getfx("bagh_tanker_crash");
	}

	playfxontag(var_0A,var_07,var_08);
	var_06 waittill("death");
	var_06 maps\_utility::ent_flag_clear("engineeffects");
	stopfxontag(common_scripts\utility::getfx("bagh_aircraft_damage_fire_trail"),var_07,var_08);
	if(isdefined(var_09))
	{
		var_09 delete();
	}

	if(maps\df_fly_flight_code::is_true(param_03))
	{
		playfx(common_scripts\utility::getfx("canyon_jet_impact"),var_06.origin,anglestoforward(var_06.angles) * -1);
	}

	if(isdefined(var_06))
	{
		var_06 delete();
	}

	if(isdefined(param_02))
	{
		common_scripts\utility::flag_set(param_02);
	}
}

//Function Number: 23
fake_missile_from_behind_player(param_00,param_01,param_02,param_03,param_04)
{
	common_scripts\utility::flag_wait(param_00);
	if(randomfloat(1) > 0.5)
	{
		maps\_utility::delaythread(0.25,::fake_missile_from_behind_player,param_00,param_01,param_02,param_03);
	}

	var_05 = getent(param_01,"targetname");
	if(!isdefined(var_05))
	{
		return;
	}

	var_06 = undefined;
	if(isdefined(param_03))
	{
		var_07 = getent(param_03,"targetname");
		var_06 = var_07.origin;
	}
	else
	{
		var_06 = level.plane maps\df_fly_flight_code::offset_position_from_tag("backward","tag_origin",500);
		var_06 = var_06 + (0,0,200);
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	var_08 = var_05.origin;
	var_09 = undefined;
	for(var_0A = 0;var_0A < param_04;var_0A++)
	{
		var_09 = magicbullet("sidewinder_atlas_jet",var_06,var_08);
		var_09 missile_settargetent(var_05);
		var_09 thread maps\df_fly_flight_code::monitor_missile_death(1,self,undefined,var_05);
		var_08 = var_05.origin + (randomintrange(-500,500),randomintrange(-500,500),randomintrange(-500,500));
	}

	var_09 waittill("explode",var_0B);
	if(isdefined(param_02))
	{
		common_scripts\utility::flag_set(param_02);
	}
}

//Function Number: 24
array_safe_delete(param_00)
{
	foreach(var_02 in param_00)
	{
		if(!isremovedentity(var_02))
		{
			var_02 delete();
		}
	}
}

//Function Number: 25
adjust_bounce_lookahead(param_00,param_01,param_02)
{
	var_03 = getdvarfloat("vehPlaneCollisionLookAheadTime");
	common_scripts\utility::flag_wait(param_01);
	setsaveddvar("vehPlaneCollisionLookAheadTime",param_00);
	common_scripts\utility::flag_wait(param_02);
	setsaveddvar("vehPlaneCollisionLookAheadTime",var_03);
}