/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _pdrone_tactical_picker.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 36
 * Decompile Time: 509 ms
 * Timestamp: 4/22/2024 2:05:25 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.player_test_points = get_player_test_points();
	level.drone_test_points = common_scripts\utility::getstructarray("drone_test_point","targetname");
	level.drone_air_spaces = getentarray("drone_air_space","script_noteworthy");
	var_00 = spawnstruct();
	var_00.enabled = 1;
	var_00.tactical_location = (0,0,0);
	var_00.target_air_space = undefined;
	var_00.drone_test_point = undefined;
	var_00.eval_min_range = 300;
	var_00.eval_max_range = 600;
	var_00.eval_too_close_range = 100;
	var_00.time_between_attacks = 1;
	var_00.num_move_wait_skips = 0;
	var_00.skip_moves = 0;
	level.drone_tactical_picker_data = var_00;
	common_scripts\utility::create_dvar("AI_Drone_Tactical_Debug",0);
	build_nodes_for_airspace();
	thread update_tactical_picker();
	thread update_flock();
	thread update_drone_moves();
	thread update_drone_attacks();
	thread update_grenade_dodger();
}

//Function Number: 2
get_player_test_points()
{
	var_00 = common_scripts\utility::getstructarray("player_test_point","targetname");
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(!isdefined(var_03.target) || !isdefined(getent(var_03.target,"targetname")))
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 3
build_nodes_for_airspace()
{
	foreach(var_01 in level.drone_air_spaces)
	{
		if(isdefined(var_01.tactical_location))
		{
			continue;
		}

		var_01.tactical_location = var_01 getpointinbounds(0,0,0);
		var_02 = transformmove((0,0,0),(0,0,0),var_01.origin,var_01.angles,var_01 getpointinbounds(1,1,1),(0,0,0));
		var_01.box_extent = var_02["origin"];
		if(!isdefined(var_01.target))
		{
			continue;
		}

		var_03 = common_scripts\utility::getstructarray(var_01.target,"targetname");
		if(!isdefined(var_03) || var_03.size == 0)
		{
			continue;
		}

		var_04 = var_03[0];
		if(!isdefined(var_04.script_noteworthy) || var_04.script_noteworthy != "drone_forward_point")
		{
			continue;
		}

		var_01.forward_direction = vectornormalize(var_04.origin - var_01.origin * (1,1,0));
	}
}

//Function Number: 4
validate_drone_test_points()
{
	if(level.drone_test_points.size == 0)
	{
		return;
	}

	foreach(var_01 in level.drone_test_points)
	{
		var_02 = getent(var_01.target,"targetname");
		if(!isdefined(var_02))
		{
		}

		if(!ispointinvolume(var_01.origin,var_02))
		{
		}
	}
}

//Function Number: 5
find_tactical_override(param_00)
{
	if(!isdefined(level.player_test_points))
	{
		return 0;
	}

	var_01 = [];
	foreach(var_03 in level.player_test_points)
	{
		var_04 = lengthsquared(var_03.origin - level.player.origin);
		if(var_04 > squared(var_03.radius))
		{
			continue;
		}

		var_05 = getent(var_03.target,"targetname");
		var_01[var_01.size] = var_05;
	}

	if(var_01.size == 0)
	{
		return 0;
	}

	var_07 = 0;
	var_08 = -1;
	var_09 = var_01.size + 1;
	if(isdefined(var_01))
	{
		var_09 = var_09 + var_01.size;
	}

	foreach(var_05 in var_01)
	{
		if(!isdefined(var_05.tactical_location))
		{
			continue;
		}

		wait(0.05);
		var_0B = calculate_tactical_score(var_05.tactical_location,var_05);
		if(var_0B >= 0 && var_0B > var_08)
		{
			if(var_01.size > 1 && var_05 != level.drone_tactical_picker_data.target_air_space && isdefined(var_05.last_picked_time) && getlevelticks() * 0.05 - var_05.last_picked_time < 3)
			{
				continue;
			}

			var_05.last_picked_time = getlevelticks() * 0.05;
			level.drone_tactical_picker_data.target_air_space = var_05;
			level.drone_tactical_picker_data.tactical_location = var_05.tactical_location;
			level.drone_tactical_picker_data.drone_test_point = undefined;
			var_08 = var_0B;
			var_07 = 1;
		}
	}

	return var_07;
}

//Function Number: 6
evaluate_tactical_range(param_00,param_01,param_02,param_03)
{
	param_02 = max(0.001,param_02);
	param_03 = max(0.001,param_03);
	var_04 = length2d(param_00 - param_01 geteye());
	if(var_04 < param_02)
	{
		return squared(min(var_04 / param_02,1));
	}

	if(var_04 < param_03)
	{
		return 1;
	}

	return 1 - squared(min(var_04 - param_02 / param_03,1));
}

//Function Number: 7
evaluate_tactical_los(param_00,param_01)
{
	if(vehicle_scripts\_pdrone_threat_sensor::trace_to_enemy(param_00,param_01,undefined))
	{
		return 1;
	}

	return 0.5;
}

//Function Number: 8
evaluate_tactical_too_close(param_00,param_01,param_02)
{
	var_03 = length2d(param_00 - param_01 geteye());
	if(var_03 >= param_02)
	{
		return 1;
	}

	return squared(param_02 - var_03 / param_02);
}

//Function Number: 9
evaluate_tactical_in_front_of_enemy(param_00,param_01)
{
	var_02 = param_00 - param_01 geteye() * (1,1,0);
	var_02 = vectornormalize(var_02);
	var_03 = anglestoforward(param_01.angles * (1,1,0));
	var_04 = vectordot(var_03,var_02) + 1 / 2;
	return var_04;
}

//Function Number: 10
evaluate_tactical_above_player(param_00,param_01)
{
	var_02 = param_00[2] - param_01.origin[2];
	var_03 = 0.5;
	if(var_02 < 0)
	{
		return var_03;
	}

	var_04 = 80;
	if(var_02 > var_04)
	{
		return 1;
	}

	return maps\_utility::linear_interpolate(clamp(var_02 / var_04,0,1),var_03,1);
}

//Function Number: 11
evaluate_tactical_in_front_of_volume(param_00,param_01)
{
	if(!isdefined(param_00) || !isdefined(param_00.forward_direction))
	{
		return 1;
	}

	var_02 = param_01.origin - param_00.origin * (1,1,0);
	var_02 = vectornormalize(var_02);
	var_03 = vectordot(var_02,param_00.forward_direction);
	if(var_03 > 0)
	{
		return 1;
	}

	return 0.1;
}

//Function Number: 12
calculate_tactical_score(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return -1;
	}

	var_02 = level.player;
	if(!isdefined(var_02))
	{
		return -1;
	}

	var_03 = evaluate_tactical_range(param_00,var_02,level.drone_tactical_picker_data.eval_min_range,level.drone_tactical_picker_data.eval_max_range);
	var_03 = var_03 + evaluate_tactical_too_close(param_00,var_02,level.drone_tactical_picker_data.eval_too_close_range);
	var_03 = var_03 + evaluate_tactical_in_front_of_enemy(param_00,var_02);
	var_03 = var_03 + evaluate_tactical_above_player(param_00,var_02);
	var_03 = var_03 * evaluate_tactical_los(param_00,var_02);
	var_03 = var_03 * evaluate_tactical_in_front_of_volume(param_01,var_02);
	return var_03 / 4;
}

//Function Number: 13
set_time_between_attacks(param_00)
{
	level.drone_tactical_picker_data.time_between_attacks = param_00;
}

//Function Number: 14
toggle_tactical_picker(param_00)
{
	level.drone_tactical_picker_data.enabled = param_00;
}

//Function Number: 15
update_tactical_picker()
{
	level notify("pdrone_update_tactical_picker");
	level endon("pdrone_update_tactical_picker");
	level.drone_tactical_picker_data.target_air_space = level.drone_air_spaces[randomint(level.drone_air_spaces.size)];
	level.drone_tactical_picker_data.tactical_location = level.drone_tactical_picker_data.target_air_space.tactical_location;
	for(;;)
	{
		wait(0.05);
		if(!level.drone_tactical_picker_data.enabled)
		{
			continue;
		}

		if(!isdefined(level.flying_attack_drones))
		{
			continue;
		}

		level.flying_attack_drones = common_scripts\utility::array_removeundefined(level.flying_attack_drones);
		if(level.flying_attack_drones.size == 0)
		{
			continue;
		}

		if(find_tactical_override())
		{
			continue;
		}

		update_tactical();
	}
}

//Function Number: 16
update_tactical()
{
	level notify("pdrone_update_tactical");
	level endon("pdrone_update_tactical");
	var_00 = calculate_tactical_score(level.drone_tactical_picker_data.tactical_location,level.drone_tactical_picker_data.target_air_space);
	var_01 = level.drone_air_spaces.size + 1;
	if(isdefined(level.drone_test_points))
	{
		var_01 = var_01 + level.drone_test_points.size;
	}

	foreach(var_03 in level.drone_air_spaces)
	{
		if(!isdefined(var_03.tactical_location))
		{
			continue;
		}

		if(isdefined(var_03.script_ignoreme) && var_03.script_ignoreme)
		{
			continue;
		}

		var_04 = 0.01;
		if(length2dsquared(var_03.origin - level.player.origin) < squared(2000))
		{
			wait(0.05);
			var_04 = calculate_tactical_score(var_03.tactical_location,var_03);
		}

		if(var_04 >= 0 && var_04 > var_00)
		{
			if(var_03 != level.drone_tactical_picker_data.target_air_space && isdefined(var_03.last_picked_time) && getlevelticks() * 0.05 - var_03.last_picked_time < 3)
			{
				continue;
			}

			var_03.last_picked_time = getlevelticks() * 0.05;
			level.drone_tactical_picker_data.target_air_space = var_03;
			level.drone_tactical_picker_data.tactical_location = var_03.tactical_location;
			level.drone_tactical_picker_data.drone_test_point = undefined;
			var_00 = var_04;
		}
	}

	if(!isdefined(level.drone_test_points))
	{
		return;
	}

	foreach(var_07 in level.drone_test_points)
	{
		if(isdefined(var_07.script_ignoreme) && var_07.script_ignoreme)
		{
			continue;
		}

		var_04 = 0;
		if(length2dsquared(var_07.origin - level.player.origin) < squared(2000))
		{
			wait(0.05);
			var_04 = calculate_tactical_score(var_07.origin);
		}

		if(var_04 >= 0 && var_04 > var_00)
		{
			level.drone_tactical_picker_data.target_air_space = getent(var_07.target,"targetname");
			level.drone_tactical_picker_data.tactical_location = var_07.origin;
			level.drone_tactical_picker_data.drone_test_point = var_07;
			var_00 = var_04;
		}
	}
}

//Function Number: 17
update_flock()
{
	level notify("pdrone_update_flock");
	level endon("pdrone_update_flock");
	for(;;)
	{
		wait(0.05);
		if(!level.drone_tactical_picker_data.enabled)
		{
			continue;
		}

		update_flock_goal_positions();
	}
}

//Function Number: 18
randomize_flock_positions()
{
	foreach(var_01 in level.flying_attack_drones)
	{
		if(!isdefined(var_01) || !isalive(var_01))
		{
			continue;
		}

		if(!isdefined(var_01.flock_goal_position) || !ispointinvolume(var_01.flock_goal_position,level.drone_tactical_picker_data.target_air_space))
		{
			var_01.flock_goal_position = var_01 get_random_point_nearby_in_volume(level.drone_tactical_picker_data.target_air_space,1);
			var_01.current_goal_position = var_01.flock_goal_position;
			var_01.current_goal_offset = (0,0,0);
		}
	}
}

//Function Number: 19
update_flock_goal_positions()
{
	level notify("pdrone_update_flock_position");
	level endon("pdrone_update_flock_position");
	if(!isdefined(level.flying_attack_drones) || level.flying_attack_drones.size == 0)
	{
		return;
	}

	if(!isdefined(level.drone_tactical_picker_data.target_air_space))
	{
		return;
	}

	randomize_flock_positions();
	calculate_flock_goal_positions();
}

//Function Number: 20
calculate_flock_goal_positions()
{
	level notify("pdrone_calculate_flock_position");
	level endon("pdrone_calculate_flock_position");
	foreach(var_01 in level.flying_attack_drones)
	{
		if(!isdefined(var_01) || !isalive(var_01))
		{
			continue;
		}

		var_02 = 0;
		var_03 = 0;
		var_04 = (0,0,0);
		var_05 = 0;
		var_06 = (0,0,0);
		var_07 = (0,0,0);
		foreach(var_09 in level.flying_attack_drones)
		{
			if(!isdefined(var_09) || !isalive(var_09))
			{
				continue;
			}

			if(var_01 == var_09)
			{
				continue;
			}

			var_02++;
			var_0A = var_09.flock_goal_position - var_01.flock_goal_position;
			var_0B = length(var_0A);
			if(var_0B <= 0)
			{
				var_0B = 1;
			}

			if(var_0B < 90)
			{
				var_03++;
				var_04 = var_04 - 0.5 * 90 - var_0B * var_0A / var_0B;
				continue;
			}

			if(var_0B > 150)
			{
				var_05++;
				var_06 = var_06 + 0.5 * var_0B - 150 * var_0A / var_0B;
			}
		}

		if(var_02 > 0)
		{
			if(var_03 > 0)
			{
				var_07 = var_07 + var_04 / var_03;
			}

			if(var_05 > 0)
			{
				var_07 = var_07 + var_06 / var_05;
			}

			var_01.flock_goal_offset = var_07;
		}
	}
}

//Function Number: 21
set_random_flock_goal_position()
{
	self.flock_goal_position = get_random_point_radius_in_volume(level.drone_tactical_picker_data.target_air_space,randomintrange(30,150));
	self.flock_goal_offset = (0,0,0);
}

//Function Number: 22
get_normalized_point_in_volume(param_00,param_01)
{
	var_02 = transformmove((0,0,0),(0,0,0),param_01.origin,param_01.angles,param_00,(0,0,0));
	var_03 = (clamp(var_02["origin"][0] / param_01.box_extent[0],-1,1),clamp(var_02["origin"][1] / param_01.box_extent[1],-1,1),clamp(var_02["origin"][2] / param_01.box_extent[2],-1,1));
	return var_03;
}

//Function Number: 23
get_random_point_in_bounds(param_00,param_01)
{
	var_02 = clamp(param_00[0] + randomfloatrange(-1 * param_01,param_01),-1,1);
	var_03 = clamp(param_00[1] + randomfloatrange(-1 * param_01,param_01),-1,1);
	var_04 = clamp(param_00[2] + randomfloatrange(-1 * param_01,param_01),-1,1);
	var_05 = level.drone_tactical_picker_data.target_air_space getpointinbounds(var_02,var_03,var_04);
	return var_05;
}

//Function Number: 24
get_random_point_nearby_in_volume(param_00,param_01)
{
	if(!isdefined(level.drone_tactical_picker_data.drone_test_point))
	{
		return get_random_point_in_volume(param_00);
	}

	var_02 = get_normalized_point_in_volume(level.drone_tactical_picker_data.tactical_location,param_00);
	var_03 = get_random_point_in_bounds(var_02,0.3);
	return var_03;
}

//Function Number: 25
get_random_point_radius_in_volume(param_00,param_01)
{
	var_02 = common_scripts\utility::randomvector(1);
	var_02 = vectornormalize(var_02);
	var_03 = self.origin + var_02 * param_01;
	if(!ispointinvolume(var_03,param_00))
	{
		var_02 = var_02 * -1;
		var_03 = self.origin + var_02 * param_01;
		if(!ispointinvolume(var_03,param_00))
		{
			var_03 = get_random_point_in_volume(param_00);
		}
	}

	return var_03;
}

//Function Number: 26
get_random_point_in_volume(param_00)
{
	return param_00 getpointinbounds(randomfloatrange(-1,1),randomfloatrange(-1,1),randomfloatrange(-1,1));
}

//Function Number: 27
update_drone_moves()
{
	level notify("pdrone_update_move");
	level endon("pdrone_update_move");
	for(;;)
	{
		wait(0.05);
		if(!level.drone_tactical_picker_data.enabled)
		{
			continue;
		}

		sort_drone_moves();
	}
}

//Function Number: 28
sort_drone_moves()
{
	level notify("pdrone_sort_drone_moves");
	level endon("pdrone_sort_drone_moves");
	if(!isdefined(level.flying_attack_drones) || level.flying_attack_drones.size == 0)
	{
		return;
	}

	var_00 = maps\_sarray::sarray_spawn();
	foreach(var_02 in level.flying_attack_drones)
	{
		if(!isdefined(var_02) || !isalive(var_02))
		{
			continue;
		}

		if(!isdefined(var_02.time_before_move))
		{
			var_02.time_before_move = 0;
		}

		var_02.time_before_move = var_02.time_before_move - 0.05;
		if(isdefined(var_02.current_air_space) && var_02.current_air_space != level.drone_tactical_picker_data.target_air_space)
		{
			continue;
		}

		var_00 maps\_sarray::sarray_push(var_02);
	}

	if(var_00.array.size == 0)
	{
		return;
	}

	maps\_sarray::sarray_sort_by_handler(var_00,maps\_sarray::sarray_create_func_obj(::compare_time_before_move));
	var_04 = var_00.array[0];
	if(var_04.time_before_move > 0)
	{
		return;
	}

	var_04.time_before_move = 1;
	var_05 = 0;
	if(level.flying_attack_drones.size == 1)
	{
		var_05 = randomfloatrange(3,5);
	}
	else
	{
		if(level.drone_tactical_picker_data.num_move_wait_skips <= 0)
		{
			level.drone_tactical_picker_data.num_move_wait_skips = randomint(level.flying_attack_drones.size);
			level.drone_tactical_picker_data.skip_moves = !level.drone_tactical_picker_data.skip_moves;
		}

		if(level.drone_tactical_picker_data.skip_moves)
		{
			var_05 = randomfloatrange(0,3);
		}

		level.drone_tactical_picker_data.num_move_wait_skips--;
	}

	var_04.current_goal_position = var_04.flock_goal_position;
	var_04.current_goal_offset = var_04.flock_goal_offset;
	var_04.flock_goal_position = var_04 get_random_point_nearby_in_volume(level.drone_tactical_picker_data.target_air_space);
	foreach(var_02 in level.flying_attack_drones)
	{
		if(!isdefined(var_02) || !isalive(var_02))
		{
			continue;
		}

		var_02.time_before_move = var_02.time_before_move + var_05;
	}
}

//Function Number: 29
compare_time_before_move(param_00,param_01)
{
	return param_00.time_before_move < param_01.time_before_move;
}

//Function Number: 30
update_drone_attacks()
{
	level notify("pdrone_update_attacks");
	level endon("pdrone_update_attacks");
	for(;;)
	{
		wait(0.05);
		if(!level.drone_tactical_picker_data.enabled)
		{
			continue;
		}

		sort_drone_attacks();
	}
}

//Function Number: 31
sort_drone_attacks()
{
	level notify("pdrone_sort_drone_attacks");
	level endon("pdrone_sort_drone_attacks");
	if(!isdefined(level.flying_attack_drones) || level.flying_attack_drones.size == 0)
	{
		return;
	}

	var_00 = maps\_sarray::sarray_spawn();
	foreach(var_02 in level.flying_attack_drones)
	{
		if(!isdefined(var_02) || !isalive(var_02))
		{
			continue;
		}

		if(!isdefined(var_02.time_before_attack))
		{
			var_02.time_before_attack = 0;
		}

		var_02.time_before_attack = var_02.time_before_attack - 0.05;
		var_00 maps\_sarray::sarray_push(var_02);
	}

	if(var_00.array.size == 0)
	{
		return;
	}

	maps\_sarray::sarray_sort_by_handler(var_00,maps\_sarray::sarray_create_func_obj(::compare_time_before_attack));
	var_02 = var_00.array[0];
	if(var_02.time_before_attack > 0)
	{
		return;
	}

	var_04 = level.drone_tactical_picker_data.time_between_attacks;
	if(isdefined(var_02.attack_delay))
	{
		var_04 = var_02.attack_delay;
	}

	var_02.time_before_attack = var_04;
	var_02.attack_available = 1;
	if(isdefined(var_02.drone_threat_data.threat) && var_02.drone_threat_data.threat != level.player)
	{
		return;
	}

	var_05 = randomfloatrange(0,var_04);
	foreach(var_02 in level.flying_attack_drones)
	{
		if(!isdefined(var_02) || !isalive(var_02))
		{
			continue;
		}

		var_02.time_before_attack = var_02.time_before_attack + var_05;
	}
}

//Function Number: 32
compare_time_before_attack(param_00,param_01)
{
	return param_00.time_before_attack < param_01.time_before_attack;
}

//Function Number: 33
update_grenade_dodger()
{
	level notify("pdrone_update_grenade_dodger");
	level endon("pdrone_update_grenade_dodger");
	for(;;)
	{
		level.player waittill("grenade_fire",var_00);
		if(!isdefined(level.flying_attack_drones) || level.flying_attack_drones.size == 0)
		{
			return;
		}

		var_01 = anglestoforward(level.player getgunangles());
		calculate_dodge_positions(var_00,var_01);
		wait(0.5);
		clear_dodge_positions();
	}
}

//Function Number: 34
calculate_dodge_positions(param_00,param_01)
{
	var_02 = (0,0,0);
	foreach(var_04 in level.flying_attack_drones)
	{
		var_02 = var_02 + var_04.origin;
	}

	var_02 = var_02 / level.flying_attack_drones.size;
	for(;;)
	{
		wait(0.05);
		if(!isdefined(param_00))
		{
			return;
		}

		var_06 = length(param_00.origin - var_02);
		if(var_06 < 200)
		{
			break;
		}
	}

	foreach(var_04 in level.flying_attack_drones)
	{
		wait(0.05);
		if(!isdefined(var_04) || !isalive(var_04))
		{
			continue;
		}

		calculate_dodge_position(var_04,param_00,param_01);
	}

	level notify("pdrone_wait_in_current_air_space");
}

//Function Number: 35
calculate_dodge_position(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		return;
	}

	var_03 = param_00.origin - param_01.origin;
	param_02 = param_02 * (1,1,0);
	param_02 = vectornormalize(param_02);
	var_04 = vectordot(var_03,param_02);
	var_05 = param_01.origin + param_02 * var_04;
	var_06 = param_00.origin - var_05;
	var_06 = var_06 * (1,1,0);
	var_06 = vectornormalize(var_06);
	var_07 = param_00.origin + var_06 * randomfloatrange(200,300);
	var_08 = physicstrace(param_00.origin,var_07);
	if(var_08 != var_07)
	{
		var_09 = length(var_07 - param_00.origin);
		if(var_09 < 60)
		{
			return;
		}

		var_07 = var_08 - var_06 * 60;
	}

	param_00.dodge_position = var_07;
	param_00.time_before_attack = randomfloatrange(2,3);
	param_00.time_before_move = randomfloatrange(1,3);
}

//Function Number: 36
clear_dodge_positions()
{
	foreach(var_01 in level.flying_attack_drones)
	{
		if(!isdefined(var_01) || !isalive(var_01))
		{
			continue;
		}

		var_01.dodge_position = undefined;
	}
}