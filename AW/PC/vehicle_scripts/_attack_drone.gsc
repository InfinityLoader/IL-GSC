/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _attack_drone.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 42
 * Decompile Time: 592 ms
 * Timestamp: 4/22/2024 2:04:22 AM
*******************************************************************/

//Function Number: 1
drone_swarm_init()
{
	if(level.nextgen)
	{
		level.attack_drones_num_drones_per_queen = 24;
		level.attack_drones_num_queens = 6;
		level.attack_drones_nofly_zone_radius = 125;
	}
	else
	{
		level.attack_drones_num_drones_per_queen = 5;
		level.attack_drones_num_queens = 3;
		level.attack_drones_nofly_zone_radius = 125;
	}

	level.swarm_spawned = 0;
	level.drone_turret_fake_death_awesome = 0;
	level.killable_kamikazes = 0;
	level.big_kamikaze_death = 0;
	common_scripts\utility::flag_init("cloud_in_formation");
	if(!isdefined(level.flock_drones))
	{
		level.flock_drones = [];
	}

	if(!isdefined(level.snakes))
	{
		level.snakes = [];
	}

	level.expected_drones = level.attack_drones_num_queens * level.attack_drones_num_drones_per_queen;
	level.drones_vs_car_shield = 0;
	level.no_fly_zone = undefined;
	level.smart_drone_think = 0;
	level.drone_test_tag = common_scripts\utility::spawn_tag_origin();
	precacheitem("iw5_attackdronemagicbullet");
	precacheitem("remote_missile_drone_light");
	precachemodel("vehicle_mil_attack_drone_static");
	precachemodel("vehicle_mil_attack_drone_destroy");
	precachemodel("vehicle_mil_attack_drone_ai");
	precachemodel("vehicle_atlas_assault_drone_physics");
	vehicle_scripts\_attack_drone_common::drone_fx();
	if(!isdefined(level.boid_settings_presets))
	{
		level.boid_settings_presets = [];
	}

	level.boid_settings_presets["default_snake"] = spawnstruct();
	level.boid_settings_presets["default_snake"].queen_deadzone = 0;
	level.boid_settings_presets["default_snake"].queen_curl = 0.5;
	level.boid_settings_presets["default_snake"].neighborhood_radius = 110;
	level.boid_settings_presets["default_snake"].separation_factor = 12000;
	level.boid_settings_presets["default_snake"].alignment_factor = 0.002;
	level.boid_settings_presets["default_snake"].cohesion_factor = 0.00015;
	level.boid_settings_presets["default_snake"].magnet_factor = 10;
	level.boid_settings_presets["default_snake"].random_factor = 250;
	level.boid_settings_presets["default_snake"].max_accel = 3200;
	level.boid_settings_presets["default_snake"].drag_amount = 0.05;
	level.boid_settings_presets["default_snake"].random_drag_amount = 0.2;
	level.boid_settings_presets["default_snake"].queen_relative_speed = 1;
	level.boid_settings_presets["default_snake"].dodge_player_shots = 1;
	level.boid_settings_presets["default_snake"].emp_mode = 0;
	level.boid_settings_presets["frozen_snake"] = spawnstruct();
	level.boid_settings_presets["frozen_snake"].queen_deadzone = 0;
	level.boid_settings_presets["frozen_snake"].queen_curl = 0;
	level.boid_settings_presets["frozen_snake"].neighborhood_radius = 110;
	level.boid_settings_presets["frozen_snake"].separation_factor = 48000;
	level.boid_settings_presets["frozen_snake"].alignment_factor = -0.002;
	level.boid_settings_presets["frozen_snake"].cohesion_factor = 0;
	level.boid_settings_presets["frozen_snake"].magnet_factor = 2.5;
	level.boid_settings_presets["frozen_snake"].random_factor = 100;
	level.boid_settings_presets["frozen_snake"].max_accel = 3200;
	level.boid_settings_presets["frozen_snake"].drag_amount = 0.15;
	level.boid_settings_presets["frozen_snake"].random_drag_amount = 0;
	level.boid_settings_presets["frozen_snake"].queen_relative_speed = 0;
	level.boid_settings_presets["frozen_snake"].min_speed = 0;
	level.boid_settings_presets["frozen_snake"].max_speed = 352;
	level.boid_settings_presets["frozen_snake"].dodge_player_shots = 1;
	level.boid_settings_presets["frozen_snake"].emp_mode = 0;
	level.boid_settings_presets["emp_snake"] = spawnstruct();
	level.boid_settings_presets["emp_snake"].queen_deadzone = 0;
	level.boid_settings_presets["emp_snake"].queen_curl = 0;
	level.boid_settings_presets["emp_snake"].neighborhood_radius = 110;
	level.boid_settings_presets["emp_snake"].separation_factor = 48000;
	level.boid_settings_presets["emp_snake"].alignment_factor = 0;
	level.boid_settings_presets["emp_snake"].cohesion_factor = 0;
	level.boid_settings_presets["emp_snake"].magnet_factor = 0.000386;
	level.boid_settings_presets["emp_snake"].random_factor = 150;
	level.boid_settings_presets["emp_snake"].max_accel = 800;
	level.boid_settings_presets["emp_snake"].drag_amount = 0.01;
	level.boid_settings_presets["emp_snake"].random_drag_amount = 0;
	level.boid_settings_presets["emp_snake"].queen_relative_speed = 0;
	level.boid_settings_presets["emp_snake"].min_speed = 0;
	level.boid_settings_presets["emp_snake"].max_speed = 880;
	level.boid_settings_presets["emp_snake"].dodge_player_shots = 0;
	level.boid_settings_presets["emp_snake"].emp_mode = 1;
}

//Function Number: 2
spawn_queen_drone_and_drive(param_00,param_01,param_02)
{
	if(isdefined(param_01))
	{
		var_03 = param_01 maps\_utility::spawn_vehicle();
	}
	else
	{
		var_03 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive(param_01);
	}

	var_03 vehicle_scripts\_attack_drone_common::setup_queen_drone();
	return var_03;
}

//Function Number: 3
monitor_drone_death()
{
	self endon("death");
	foreach(var_01 in self.drones)
	{
		while(isdefined(var_01))
		{
			wait(0.05);
		}
	}

	self notify("drones_gone");
}

//Function Number: 4
flying_attack_drone_move_think()
{
	self endon("death");
	self.current_air_space = common_scripts\utility::getclosest(self.origin,level.drone_air_spaces);
	update_flying_attack_drone_goal_pos();
	self waittill("near_goal");
	wait(2);
	for(;;)
	{
		var_00 = maps\_utility::get_closest_player_healthy(self.origin);
		self setlookatent(var_00);
		var_01 = var_00.origin;
		var_02 = common_scripts\utility::getclosest(var_01,level.player_test_points);
		var_03 = getent(var_02.target,"targetname");
		if(var_03 != self.current_air_space)
		{
			var_04 = get_next_air_space(self.current_air_space,var_03,level.drone_air_spaces);
			if(isdefined(var_04))
			{
				self.current_air_space = var_04;
			}
		}

		update_flying_attack_drone_goal_pos();
		self waittill("near_goal");
		if(var_03 == self.current_air_space)
		{
			wait(randomfloatrange(0.5,1.5));
		}
	}
}

//Function Number: 5
update_flying_attack_drone_goal_pos()
{
	var_00 = self.origin;
	var_01 = spawn("script_origin",(0,0,0));
	var_01.origin = var_00;
	if(!var_01 istouching(self.current_air_space))
	{
		var_00 = get_random_point_in_air_space(self.current_air_space);
	}
	else
	{
		var_02 = 0;
		var_03 = 0;
		var_04 = (0,0,0);
		var_05 = 0;
		var_06 = (0,0,0);
		foreach(var_08 in level.flying_attack_drones)
		{
			if(self != var_08 && isdefined(self.current_air_space) && isdefined(var_08.current_air_space))
			{
				if(self.current_air_space == var_08.current_air_space)
				{
					var_02++;
					var_09 = var_08.origin - self.origin;
					var_0A = length(var_09);
					if(var_0A < 90)
					{
						var_03++;
						var_04 = var_04 - 0.5 * 90 - var_0A * var_09 / var_0A;
					}
					else if(var_0A > 150)
					{
						var_05++;
						var_06 = var_06 + 0.5 * var_0A - 150 * var_09 / var_0A;
					}
				}
			}
		}

		if(var_02 > 0)
		{
			if(var_03 > 0)
			{
				var_00 = var_00 + var_04 / var_03;
			}

			if(var_05 > 0)
			{
				var_00 = var_00 + var_06 / var_05;
			}
		}
		else
		{
			var_00 = get_random_point_in_air_space(self.current_air_space);
		}
	}

	self setvehgoalpos(var_00,1);
	var_01 delete();
}

//Function Number: 6
get_random_point_in_air_space(param_00)
{
	var_01 = spawn("script_origin",(0,0,0));
	var_01.origin = param_00 getpointinbounds(randomfloatrange(-1,1),randomfloatrange(-1,1),randomfloatrange(-1,1));
	while(!var_01 istouching(param_00))
	{
		var_01.origin = param_00 getpointinbounds(randomfloatrange(-1,1),randomfloatrange(-1,1),randomfloatrange(-1,1));
	}

	var_02 = var_01.origin;
	var_01 delete();
	return var_02;
}

//Function Number: 7
flying_attack_drone_damage_monitor()
{
	self endon("death");
	self.damagetaken = 0;
	self.istakingdamage = 0;
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(!isdefined(var_01) || !isplayer(var_01))
		{
			continue;
		}

		self notify("flying_attack_drone_damaged_by_player");
		thread flying_attack_drone_damage_update();
	}
}

//Function Number: 8
flying_attack_drone_damage_update()
{
	self notify("taking damage");
	self endon("taking damage");
	self endon("death");
	self.istakingdamage = 1;
	wait(1);
	self.istakingdamage = 0;
}

//Function Number: 9
flying_attack_drone_death_monitor()
{
	level.flying_attack_drones = common_scripts\utility::array_add(level.flying_attack_drones,self);
	self waittill("death");
	level.flying_attack_drones = common_scripts\utility::array_remove(level.flying_attack_drones,self);
	level notify("flying_attack_drone_destroyed");
}

//Function Number: 10
get_linked_air_spaces(param_00,param_01)
{
	var_02 = [];
	var_03 = [];
	if(isdefined(param_00.script_linkto))
	{
		var_03 = strtok(param_00.script_linkto," ");
	}

	for(var_04 = 0;var_04 < param_01.size;var_04++)
	{
		var_05 = 0;
		if(isdefined(param_01[var_04].script_linkname))
		{
			for(var_06 = 0;var_06 < var_03.size;var_06++)
			{
				if(param_01[var_04].script_linkname == var_03[var_06])
				{
					var_02[var_02.size] = param_01[var_04];
					var_05 = 1;
					break;
				}
			}
		}

		if(!var_05 && isdefined(param_01[var_04].script_linkto) && isdefined(param_00.script_linkname))
		{
			var_07 = strtok(param_01[var_04].script_linkto," ");
			for(var_06 = 0;var_06 < var_07.size;var_06++)
			{
				if(param_00.script_linkname == var_07[var_06])
				{
					var_02[var_02.size] = param_01[var_04];
					break;
				}
			}
		}
	}

	return var_02;
}

//Function Number: 11
get_next_air_space(param_00,param_01,param_02)
{
	var_03 = [];
	var_03[0] = param_00;
	var_04 = [];
	foreach(var_06 in param_02)
	{
		var_06.g_score = 0;
	}

	param_00.f_score = param_00.g_score + distance(param_00.origin,param_01.origin);
	while(var_03.size > 0)
	{
		var_08 = undefined;
		var_09 = 500000;
		foreach(var_0B in var_03)
		{
			if(var_0B.f_score < var_09)
			{
				var_08 = var_0B;
				var_09 = var_0B.f_score;
			}
		}

		if(var_08 == param_01)
		{
			var_0D = param_01;
			while(var_0D.came_from != param_00)
			{
				var_0D = var_0D.came_from;
			}

			return var_0D;
		}

		var_04 = common_scripts\utility::array_remove(var_04,var_09);
		var_05[var_05.size] = var_09;
		var_0F = get_linked_air_spaces(var_09,var_03);
		foreach(var_0C in var_0F)
		{
			var_11 = var_09.g_score + distance(var_09.origin,var_0C.origin);
			if(common_scripts\utility::array_contains(var_05,var_0C) && var_11 >= var_0C.g_score)
			{
				continue;
			}

			var_12 = common_scripts\utility::array_contains(var_04,var_0C);
			if(!var_12 || var_11 < var_0C.g_score)
			{
				var_0C.came_from = var_09;
				var_0C.g_score = var_11;
				var_0C.f_score = var_0C.g_score + distance(var_0C.origin,param_02.origin);
				if(!var_12)
				{
					var_04[var_04.size] = var_0C;
				}
			}
		}
	}

	return undefined;
}

//Function Number: 12
sortbydistanceauto(param_00,param_01)
{
	return sortbydistance(param_00,param_01,0,1);
}

//Function Number: 13
kamikaze_new_style(param_00,param_01)
{
	level endon("end_kamikaze_newstyle");
	level endon("delete_drone_cloud");
	for(;;)
	{
		var_02 = sortbydistanceauto(level.flock_drones,level.player.origin);
		var_03 = randomint(5);
		for(var_04 = 0;var_04 < var_03;var_04++)
		{
			if(!isdefined(var_02[var_04]) || isdefined(var_02[var_04].attacking_player))
			{
				continue;
			}

			var_02[var_04] thread drone_kamikaze_player(param_01,param_00);
			var_02[var_04].attacking_player = 1;
			wait(randomfloatrange(0.1,0.25));
		}

		wait(0.5);
	}
}

//Function Number: 14
handle_drones_vs_car_shield(param_00)
{
	if(!level.drones_vs_car_shield)
	{
		return;
	}

	level notify("kill_drone_vs_carshiel_process");
	level endon("kill_drone_vs_carshiel_process");
	level endon("end_drone_kamikaze_player");
	level endon("delete_drone_cloud");
	for(;;)
	{
		while(level.flock_drones.size <= 0)
		{
			wait(0.05);
		}

		var_01 = anglestoforward(level.player getplayerangles());
		var_02 = level.player geteye() + var_01 * 200;
		var_03 = sortbydistanceauto(level.flock_drones,var_02);
		if(var_03.size > 0)
		{
			var_04 = distance(var_03[0].origin,level.player.origin);
			if(var_04 <= 1000)
			{
				var_03[0] thread drone_kamikaze_player(param_00);
				var_03[0] setmodel("vehicle_mil_attack_drone_static");
				wait(randomfloatrange(1.5,2.5));
			}
			else
			{
				wait(0.25);
			}

			continue;
		}

		wait(0.25);
	}
}

//Function Number: 15
force_kamikaze(param_00,param_01)
{
	level endon("delete_drone_cloud");
	var_02 = get_legal_drone_for_kamikaze();
	if(!isdefined(var_02))
	{
		return;
	}

	while(isdefined(param_00.vehicle_spawned_thisframe))
	{
		wait(0.1);
	}

	var_02 thread drone_kamikaze_player(param_00,undefined,param_01);
}

//Function Number: 16
get_legal_drone_for_kamikaze()
{
	level endon("delete_drone_cloud");
	var_00 = undefined;
	for(;;)
	{
		var_01 = anglestoforward(level.player getplayerangles());
		var_02 = level.player geteye() + var_01 * 200;
		var_03 = sortbydistanceauto(level.flock_drones,var_02);
		foreach(var_00 in var_03)
		{
			var_05 = distance(var_00.origin,var_02);
			if(var_05 > 100)
			{
				continue;
			}
			else
			{
				return var_00;
			}
		}

		wait 0.05;
	}
}

//Function Number: 17
drone_kamikaze_player(param_00,param_01,param_02)
{
	level endon("delete_drone_cloud");
	level endon("stop_kamikaze_player");
	if(isdefined(param_00.vehicle_spawned_thisframe))
	{
		return;
	}

	if(!isdefined(level.spawned_kamikaze_drones))
	{
		level.spawned_kamikaze_drones = [];
	}

	var_03 = param_00 maps\_utility::spawn_vehicle();
	level.spawned_kamikaze_drones[level.spawned_kamikaze_drones.size] = var_03;
	if(!isdefined(var_03) || !var_03 maps\_vehicle::isvehicle())
	{
		return;
	}

	var_03 notify("nodeath_thread");
	var_03.health = 1;
	if(isdefined(self))
	{
		var_03 vehicle_teleport(self.origin,self.angles);
		var_04 = vectortoangles(level.player.origin - var_03.origin);
		var_03 vehicle_teleport(self.origin,var_04);
	}
	else
	{
		return;
	}

	if(level.killable_kamikazes)
	{
		level.flock_drones = common_scripts\utility::array_add(level.flock_drones,var_03);
		var_03.kamikaze = 1;
	}

	var_05 = var_03.origin;
	for(;;)
	{
		if(!isdefined(var_03) || !var_03 maps\_vehicle::isvehicle())
		{
			return;
		}

		var_06 = anglestoforward(level.player getplayerangles());
		var_07 = level.player geteye() + var_06 * 30;
		var_03 vehicle_setspeed(20,20,20);
		var_03 setvehgoalposauto(var_07);
		var_08 = level.player.origin - var_03.origin;
		var_08 = vectortoyaw(var_08);
		var_03 setgoalyaw(var_08);
		if(!isdefined(param_01))
		{
			if(distance(var_03.origin,level.player geteye()) < 60)
			{
				var_09 = 30;
				level.player notify("car_door_shield_damaged",var_09,var_03.origin,var_03.angles,"drones");
				if(!is_current_weapon_shield(level.player getcurrentweapon()))
				{
					soundscripts\_snd::snd_message("drone_kamikaze_hit_player");
				}

				var_03 thread drone_die_random();
				level.player notify("kamikaze_hit_player");
				earthquake(randomfloatrange(0.25,1),0.5,level.player.origin,32);
			}
		}
		else if((isdefined(param_01) && var_03 isorigintouchingvol(param_01)) || distance(var_03.origin,level.player geteye()) < 60)
		{
			if(distance(var_03.origin,level.player geteye()) < 60)
			{
				soundscripts\_snd::snd_message("drone_kamikaze_hit_player");
			}

			var_03 thread drone_die_random();
			earthquake(randomfloatrange(0.25,1),0.5,level.player.origin,32);
		}
		else if(!bullettracepassed(var_05,var_03.origin,0,var_03))
		{
			var_03 thread drone_die_random();
		}

		if(isdefined(var_03))
		{
			var_05 = var_03.origin;
		}

		wait(0.05);
	}
}

//Function Number: 18
is_current_weapon_shield(param_00)
{
	return param_00 == "weapon_suv_door_shield_fr" || param_00 == "weapon_suv_door_shield_fl" || param_00 == "weapon_suv_door_shield_kl" || param_00 == "weapon_suv_door_shield_kr";
}

//Function Number: 19
drone_kamikaze_player_evil_style(param_00,param_01)
{
	var_02 = param_00.model;
	var_03 = spawn("script_model",self.origin);
	var_03.angles = self.angles;
	var_03 setmodel(var_02);
	var_04 = 352;
	var_05 = 1920;
	var_06 = 0.15;
	var_07 = 0.3;
	var_08 = (0,0,0);
	var_09 = 0;
	var_0A = 60;
	var_0B = self evaluatetrajectorydelta();
	var_0C = undefined;
	var_0D = vectornormalize(var_0B);
	var_0E = var_0D;
	for(;;)
	{
		var_0C = kamikaze_drone_get_target_origin();
		var_0F = var_0C - var_03.origin;
		var_0D = vectornormalize(var_0F);
		var_10 = var_0D - var_0E * 20 + var_08 + common_scripts\utility::randomvector(var_09);
		var_0E = var_0D;
		var_11 = length(var_0B);
		var_12 = vectornormalize(var_0B);
		if(var_11 < var_04)
		{
			var_13 = min(var_11 + var_05 * 0.05,var_04);
		}
		else
		{
			var_13 = max(var_11 - var_05 * 0.05,var_04);
		}

		if(vectordot(var_0B,var_0C - var_03.origin) < 0)
		{
			var_10 = var_10 * -1;
		}

		var_14 = vectorclamp(var_10 * var_07,var_06);
		var_15 = vectornormalize(var_12 + var_14);
		var_0B = var_15 * var_13;
		var_16 = var_03.origin + var_0B * 0.05;
		if(!bullettracepassed(self.origin,var_16,0,var_03))
		{
			break;
		}

		var_03.origin = var_16;
		var_03.angles = vectortoangles(var_0B);
		if(distance(var_16,var_0C) < var_0A)
		{
			break;
		}

		if(isdefined(param_01) && var_03 istouching(param_01))
		{
			break;
		}

		wait 0.05;
	}

	var_17 = 30;
	level.player notify("car_door_shield_damaged",var_17,var_03.origin,var_03.angles,"drones");
	var_03 drone_die_random(var_0B);
	earthquake(randomfloatrange(0.25,1),0.5,level.player.origin,32);
}

//Function Number: 20
kamikaze_drone_get_target_origin()
{
	var_00 = anglestoforward(level.player getplayerangles());
	var_01 = level.player geteye() + var_00 * 30;
	return var_01;
}

//Function Number: 21
isorigintouchingvol(param_00)
{
	var_01 = common_scripts\utility::spawn_tag_origin();
	if(var_01 istouching(param_00))
	{
		var_01 delete();
		return 1;
	}
	else
	{
		var_01 delete();
	}

	return 0;
}

//Function Number: 22
setvehgoalposauto(param_00)
{
	if(!isdefined(self))
	{
		return;
	}

	if(!maps\_vehicle::isvehicle())
	{
		return;
	}

	self setvehgoalpos(param_00);
}

//Function Number: 23
drone_die_random(param_00,param_01)
{
	var_02 = self.origin;
	var_03 = self.angles;
	if(!isdefined(level.every_other_one))
	{
		level.every_other_one = 0;
	}

	if(level.every_other_one > 1)
	{
		level.every_other_one = 0;
	}

	if(randomint(100) < 5)
	{
		playfx(common_scripts\utility::getfx("drone_sparks"),var_02);
	}

	if(isdefined(param_00))
	{
		if(level.gameskill > 1 && level.every_other_one < 1)
		{
			magicbullet("iw5_attackdronemagicbullet",var_02,var_02 + param_00);
			level.every_other_one++;
		}
		else
		{
			magicbullet("iw5_attackdronemagicbullet",var_02,var_02 + param_00);
		}
	}
	else if(level.gameskill > 1 && level.every_other_one < 1)
	{
		magicbullet("iw5_attackdronemagicbullet",var_02,level.player geteye());
		level.every_other_one++;
	}
	else
	{
		magicbullet("iw5_attackdronemagicbullet",var_02,level.player geteye());
	}

	level notify("heavy_rumble");
	var_04 = spawn("script_model",var_02);
	var_04 setmodel("vehicle_mil_attack_drone_destroy");
	var_04.angles = var_03;
	level notify("drone_kamikaze_crash",self.origin);
	if(!isdefined(param_01) || !param_01)
	{
		self delete();
	}

	var_05 = var_04.origin + (randomintrange(-10,10),randomintrange(-10,10),randomintrange(-10,10)) - level.player geteye();
	var_06 = randomintrange(50,80);
	var_04 physicslaunchserver(var_04.origin + (randomintrange(-15,15),randomintrange(-15,15),randomintrange(-15,15)),var_05 * var_06);
	if(randomint(100) < 15)
	{
		playfxontag(common_scripts\utility::getfx("drone_smoke"),var_04,"tag_origin");
	}

	playfxontag(common_scripts\utility::getfx("drone_sparks"),var_04,"tag_origin");
	if(level.big_kamikaze_death)
	{
		playfxontag(common_scripts\utility::getfx("drone_death_explode1"),var_04,"tag_origin");
	}

	wait(15);
	var_04 delete();
}

//Function Number: 24
spawn_drone_physics(param_00,param_01)
{
	var_02 = self.origin;
	var_03 = self.angles;
	var_04 = spawn("script_model",var_02);
	var_04 setmodel("vehicle_mil_attack_drone_destroy");
	var_04.angles = var_03;
	var_05 = var_04.origin + (randomintrange(-10,10),randomintrange(-10,10),randomintrange(-10,10)) - level.player geteye();
	var_04 physicslaunchserver(var_04.origin + (randomintrange(-15,15),randomintrange(-15,15),randomintrange(-15,15)),var_05);
	if(randomint(100) < 5)
	{
		playfxontag(common_scripts\utility::getfx("drone_smoke"),var_04,"tag_origin");
	}

	wait(randomfloat(5));
	playfx(common_scripts\utility::getfx("drone_sparks"),var_04.origin);
	var_04 delete();
}

//Function Number: 25
clear_drone_cloud()
{
	level waittill("delete_drone_cloud");
	common_scripts\utility::array_thread(level.flock_drones,::delete_drone);
}

//Function Number: 26
delete_drone()
{
	if(!isdefined(self))
	{
		return;
	}

	self delete();
}

//Function Number: 27
handle_drone_cloud_vehicle_attack(param_00,param_01)
{
	self notify("kill_cloud_vehicle_attack_process");
	self endon("kill_cloud_vehicle_attack_process");
	if(!common_scripts\utility::flag("cloud_in_formation"))
	{
		common_scripts\utility::flag_set("cloud_in_formation");
	}

	if(isdefined(param_00))
	{
		thread drone_cloud_formation_circle(param_00,param_01);
	}

	while(vehicle_scripts\_attack_drone_common::isdronevehiclealive(param_00))
	{
		wait(0.05);
	}

	common_scripts\utility::flag_clear("cloud_in_formation");
	level notify("drone_cloud_formation_end");
}

//Function Number: 28
drone_cloud_formation_circle(param_00,param_01)
{
	self notify("kill_drone_cloud_formation_circle_process");
	self endon("kill_drone_cloud_formation_circle_process");
	var_02 = (0,0,0);
	param_00 endon("death");
	param_00.follow_dist = 200;
	level.cloud_queen.radii = 600;
	level.cloud_queen.accel = 35;
	level.cloud_queen.decel = 45;
	if(!isdefined(param_01))
	{
		param_01 = 100;
	}

	while(vehicle_scripts\_attack_drone_common::isdronevehiclealive(param_00))
	{
		level.cloud_queen.desired_speed = level.cloud_queen vehicle_getspeed() + 8;
		level.drone_test_tag.origin = param_00.origin;
		level.drone_test_tag.angles = param_00.angles;
		var_03 = level.drone_test_tag vehicle_scripts\_attack_drone_common::offset_position_from_drone("backward","tag_origin",param_00.follow_dist);
		var_03 = var_03 + (0,0,param_01);
		if(var_03 == var_02 && distance(var_03,level.cloud_queen.origin) < 20)
		{
			level.cloud_queen vehicle_setspeed(0,30,40);
		}
		else
		{
			var_04 = param_00 vehicle_getspeed() * 1.25;
			if(var_04 <= 0)
			{
				var_04 = 18;
			}

			level.cloud_queen vehicle_setspeed(var_04,var_04,var_04 * 1.25);
			level.cloud_queen setvehgoalpos(var_03);
		}

		var_02 = var_03;
		wait(0.05);
	}

	level.cloud_queen vehicle_setspeed(10,5,5);
}

//Function Number: 29
drone_cloud_formation_circle_player(param_00,param_01,param_02)
{
	self notify("kill_drone_cloud_formation_circle_process");
	self endon("kill_cdrone_cloud_formation_circle_process");
	level endon("end_cherry_picker");
	level endon("end_drone_cloud");
	self endon("death");
	foreach(var_05, var_04 in level.drone_swarm_queens)
	{
		if(var_04 != self)
		{
			var_04 thread queen_drone_form_hemisphere(self,var_05);
		}
	}

	self hide();
	var_06 = (0,0,0);
	param_00 endon("death");
	level.player endon("death");
	param_00.follow_dist = 200;
	self.radii = 600;
	self.accel = 35;
	self.decel = 45;
	self.retreat_path = 0;
	var_07 = param_00.origin + (0,0,90);
	var_08 = var_07[2] + 50;
	var_09 = var_07[2] + 250;
	if(!isdefined(param_01))
	{
		param_01 = 50;
	}

	while(isdefined(self))
	{
		while(common_scripts\utility::flag("cloud_queen_retreat_path"))
		{
			self.retreat_path = 1;
			wait(0.05);
		}

		self.retreat_path = 0;
		wait(randomfloatrange(0.5,0.9));
		var_0A = fixed_point_on_squished_sphere(250,70);
		var_0B = param_00 gettagorigin("tag_flash");
		var_0C = param_00 gettagangles("tag_flash");
		var_0B = var_0B + anglestoforward(var_0C) * param_01;
		var_0B = var_0B + var_0A;
		if(var_0B[2] > var_09)
		{
			var_0B = (var_0B[0],var_0B[1],var_08);
		}
		else if(var_0B[2] < var_08)
		{
			var_0B = (var_0B[0],var_0B[1],var_09);
		}

		var_0D = vectortoangles(var_07 - self.origin);
		self vehicle_teleport(var_0B,var_0D);
		self vehicle_setspeed(0,5,5);
		wait(0.25);
	}
}

//Function Number: 30
queen_drone_form_hemisphere(param_00,param_01)
{
	level endon("delete_drone_cloud");
	level endon("end_drone_cloud");
	self endon("death");
	self notify("kill_queen_drone_fly_process");
	self endon("kill_queen_drone_fly_process");
	self.retreat_path = 0;
	self.radii = 250;
	self.accel = 5;
	self.decel = 15;
	var_02 = (0,0,0);
	self.desired_speed = 15;
	self.new_position = param_00.origin;
	var_03 = level.player.cherry_turret;
	self.maintain_position = undefined;
	thread maintain_position_around_queen(200,-100,150,level.cloud_queen);
	while(vehicle_scripts\_attack_drone_common::is_real_vehicle())
	{
		while(!isdefined(self.maintain_position) || self.retreat_path)
		{
			wait(0.05);
		}

		if(level.cloud_queen vehicle_getspeed() < 18)
		{
			var_04 = 18;
		}
		else
		{
			var_04 = level.cloud_queen vehicle_getspeed();
		}

		self vehicle_setspeed(var_04,var_04,var_04);
		self setvehgoalpos(self.maintain_position);
		wait(0.5);
	}
}

//Function Number: 31
maintain_position_around_queen(param_00,param_01,param_02,param_03)
{
	level endon("end_drone_cloud");
	var_04 = level.player.cherry_turret;
	var_05 = param_03.origin;
	var_06 = var_05;
	while(isdefined(self))
	{
		var_07 = distance(var_05,param_03.origin);
		var_08 = fixed_point_on_squished_sphere(param_00);
		var_09 = param_03.origin + var_08;
		var_06 = param_03.origin;
		if(!isdefined(level.no_fly_zone) || isdefined(level.no_fly_zone) && distance(level.no_fly_zone,var_09) > level.attack_drones_nofly_zone_radius)
		{
			self.maintain_position = var_09;
			continue;
		}

		wait(0.05);
		continue;
		wait(0.1);
	}
}

//Function Number: 32
queen_drone_fly(param_00,param_01)
{
	level endon("delete_drone_cloud");
	self endon("death");
	self notify("kill_queen_drone_fly_process");
	self endon("kill_queen_drone_fly_process");
	self.radii = param_01;
	self.accel = 5;
	self.decel = 15;
	var_02 = (0,0,0);
	self.desired_speed = 15;
	self notify("queen_set_fly_logic");
	while(vehicle_scripts\_attack_drone_common::is_real_vehicle())
	{
		var_03 = (perlinnoise2d(gettime() * 0.001 * 0.05,10,4,5,2),perlinnoise2d(gettime() * 0.001 * 0.05,20,4,5,2),perlinnoise2d(gettime() * 0.001 * 0.05,30,4,5,2));
		var_04 = position_in_circle(param_00.origin,self.radii);
		var_02 = var_04;
		var_05 = param_00 vehicle_getspeed();
		if(var_05 <= 5)
		{
			var_06 = 1;
			var_05 = 18;
			self vehicle_setspeed(var_05 * 1.25,var_05 * 2,var_05 * 2.25);
		}
		else
		{
			var_06 = 0;
			self vehicle_setspeed(var_05 * 1.25,var_05,var_05 * 1.25);
		}

		self setvehgoalpos(var_03 + var_04);
		if(var_06)
		{
			if(self.location + 1 <= self.num_in_formation)
			{
				self.location++;
			}
			else
			{
				self.location = 0;
			}

			wait(0.05);
			continue;
		}

		wait(0.25);
	}
}

//Function Number: 33
position_in_circle(param_00,param_01)
{
	var_02 = param_01;
	var_03 = 1;
	var_04 = self.num_in_formation;
	var_05 = 360 / var_04;
	var_06 = [];
	var_07 = [];
	for(var_08 = 0;var_08 < var_04;var_08++)
	{
		var_03 = var_05 * var_08;
		var_09 = 0;
		var_06[var_06.size] = param_00 + anglestoforward((var_09,var_03,0)) * var_02;
	}

	if(isdefined(var_06[self.location]))
	{
		return var_06[self.location];
	}

	return var_06[0];
}

//Function Number: 34
position_in_spear(param_00,param_01,param_02)
{
	return param_02.origin;
}

//Function Number: 35
make_boidcloud(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = level.attack_drones_num_drones_per_queen;
	}

	if(!isdefined(param_02))
	{
		param_02 = 50;
	}

	var_03 = spawnstruct();
	var_03.queen = self;
	var_03.queen.flock = var_03;
	var_03.boids = [];
	if(isdefined(param_00))
	{
		var_03.boid_settings = param_00;
	}
	else
	{
		var_03.boid_settings = spawnstruct();
	}

	setsaveddvar("r_lightCacheLessFrequentPeriod",20);
	setsaveddvar("r_lightCacheLessFrequentMaxDistance",9999);
	for(var_04 = 0;var_04 < param_01;var_04++)
	{
		var_05 = spawn("script_model",self.origin);
		if(level.nextgen)
		{
			var_05 setmodel(self.model);
		}
		else if(randomint(100) < param_02)
		{
			var_05 setmodel("vehicle_mil_attack_drone_static_multi_cg");
			var_05 thread multi_drone_handle_anim();
		}
		else
		{
			var_05 setmodel(self.model);
		}

		var_05.old_contents = var_05 setcontents(0);
		var_05 startusinglessfrequentlighting();
		var_03.boids[var_03.boids.size] = var_05;
		var_05 thread vehicle_scripts\_attack_drone_common::monitor_drone_cloud_health();
	}

	self.boid_cloud_spawned = 1;
	var_03 thread vehicle_scripts\_attack_drone_common::boid_flock_think();
	return var_03;
}

//Function Number: 36
make_boidcloud_from_spawned_models(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.queen = self;
	var_02.queen.flock = var_02;
	var_02.boids = param_01;
	if(isdefined(param_00))
	{
		var_02.boid_settings = param_00;
	}
	else
	{
		var_02.boid_settings = spawnstruct();
	}

	setsaveddvar("r_lightCacheLessFrequentPeriod",20);
	setsaveddvar("r_lightCacheLessFrequentMaxDistance",9999);
	foreach(var_04 in param_01)
	{
		var_04.old_contents = var_04 setcontents(0);
		var_04 startusinglessfrequentlighting();
		var_04 thread vehicle_scripts\_attack_drone_common::monitor_drone_cloud_health();
	}

	self.boid_cloud_spawned = 1;
	var_02 thread vehicle_scripts\_attack_drone_common::boid_flock_think();
	return var_02;
}

//Function Number: 37
monitor_drone_swearm_boundaries()
{
	if(common_scripts\utility::cointoss())
	{
		return;
	}

	var_00 = getentarray("vol_drone_swarm_boundary","targetname");
	while(isdefined(self))
	{
		if(!is_boid_in_vols(var_00))
		{
			wait(0.1);
		}

		wait(0.05);
	}
}

//Function Number: 38
is_boid_in_vols(param_00)
{
	foreach(var_02 in param_00)
	{
		if(self istouching(var_02))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 39
fixed_point_squished_sphere(param_00)
{
	var_01 = param_00 * param_00;
	for(var_02 = common_scripts\utility::randomvector(param_00);lengthsquared(var_02) > var_01;var_02 = common_scripts\utility::randomvector(param_00))
	{
	}

	return (var_02[0],var_02[1],var_02[2] * 0.65);
}

//Function Number: 40
fixed_point_on_squished_sphere(param_00,param_01)
{
	var_02 = fixed_point_squished_sphere(1);
	var_03 = vectornormalize(var_02) * param_00;
	while(isdefined(param_01))
	{
		if(var_03[2] < param_01)
		{
			var_02 = fixed_point_squished_sphere(1);
			var_03 = vectornormalize(var_02) * param_00;
			continue;
		}

		break;
	}

	return var_03;
}

//Function Number: 41
boid_add_vehicle_to_targets(param_00,param_01)
{
	param_00 notify("stop_friendlyfire_shield");
	level endon("end_drone_cloud");
	param_00 endon("death");
	if(!isdefined(param_01))
	{
		param_01 = 300;
	}

	while(vehicle_scripts\_attack_drone_common::isdronevehiclealive(param_00))
	{
		var_02 = sortbydistanceauto(level.flock_drones,param_00.origin);
		for(var_03 = 0;var_03 < 5;var_03++)
		{
			if(isdefined(var_02[var_03]))
			{
				var_02[var_03] thread vehicle_scripts\_attack_drone_common::boid_vehicle_targets(param_00,param_01);
				wait(0.1);
			}
		}

		wait(2);
	}
}

//Function Number: 42
multi_drone_handle_anim()
{
	self endon("death");
	level endon("end_drone_cloud");
	level endon("delete_drone_cloud");
	self useanimtree(#animtree);
	if(randomfloat(1) >= 0.5)
	{
		var_00 = %mil_attack_drone_multi_cg_spin_cw;
	}
	else
	{
		var_00 = %mil_attack_drone_multi_cg_spin_ccw;
	}

	var_01 = getanimlength(var_00);
	wait(randomfloat(1));
	for(;;)
	{
		self setanimknobrestart(var_00);
		wait(var_01);
	}
}