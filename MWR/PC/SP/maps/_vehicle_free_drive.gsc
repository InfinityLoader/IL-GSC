/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_vehicle_free_drive.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 47
 * Decompile Time: 741 ms
 * Timestamp: 10/27/2023 2:50:14 AM
*******************************************************************/

//Function Number: 1
init_vehicle_free_path(param_00)
{
	common_scripts\utility::create_dvar("vehicle_free_path_debug",0);
	clean_up_vehicle_free_path(1);
	setup_default_level_vars();
	level.enemy_free_vehicles = [];
	level.drive_free_path_func = ::vehicle_drives_free_path;
	level.vehicle_free_path = setup_free_drive_path(param_00);
	common_scripts\utility::run_thread_on_targetname("enable_free_path",::enable_free_path_think);
}

//Function Number: 2
setup_default_level_vars()
{
	if(!isdefined(level.freedrive_playermatch_farbehind_delete_dist))
	{
		level.freedrive_playermatch_farbehind_delete_dist = -4000;
	}

	if(!isdefined(level.freedrive_playermatch_catchup_ramp_start_dist))
	{
		level.freedrive_playermatch_catchup_ramp_start_dist = -2000;
	}

	if(!isdefined(level.freedrive_playermatch_catchup_ramp_end_dist))
	{
		level.freedrive_playermatch_catchup_ramp_end_dist = 100;
	}

	if(!isdefined(level.freedrive_playermatch_slowdown_ramp_start_dist))
	{
		level.freedrive_playermatch_slowdown_ramp_start_dist = 650;
	}

	if(!isdefined(level.freedrive_playermatch_slowdown_ramp_end_dist))
	{
		level.freedrive_playermatch_slowdown_ramp_end_dist = 2000;
	}

	if(!isdefined(level.freedrive_playermatch_farahead_delete_dist))
	{
		level.freedrive_playermatch_farahead_delete_dist = 4000;
	}

	if(!isdefined(level.freedrive_playermatch_matched_multiplier))
	{
		level.freedrive_playermatch_matched_multiplier = 1;
	}

	if(!isdefined(level.freedrive_playermatch_slowdown_multiplier))
	{
		level.freedrive_playermatch_slowdown_multiplier = 0.6;
	}

	if(!isdefined(level.freedrive_playermatch_catchup_multiplier))
	{
		level.freedrive_playermatch_catchup_multiplier = 1.6;
	}

	if(!isdefined(level.freedrive_progress_mod_default))
	{
		level.freedrive_progress_mod_default = 200;
	}

	if(!isdefined(level.freedrive_progress_mod_step))
	{
		level.freedrive_progress_mod_step = 200;
	}

	if(!isdefined(level.freedrive_vehicle_min_allowed_speed))
	{
		level.freedrive_vehicle_min_allowed_speed = 25;
	}

	if(!isdefined(level.freedrive_dodge_static_early_distance))
	{
		level.freedrive_dodge_static_early_distance = 200;
	}

	if(!isdefined(level.freedrive_stay_within_percent_of_edge))
	{
		level.freedrive_stay_within_percent_of_edge = 0.9;
	}
}

//Function Number: 3
enable_free_path_think()
{
	level endon("stop_vehicle_free_path");
	for(;;)
	{
		self waittill("trigger",var_00);
		var_00 notify("enable_free_path");
	}
}

//Function Number: 4
clean_up_vehicle_free_path(param_00)
{
	level notify("stop_vehicle_free_path");
	level.vehicle_free_path = undefined;
	level.moving_obstacles = undefined;
	if(param_00 && isdefined(level.enemy_free_vehicles))
	{
		foreach(var_02 in level.enemy_free_vehicles)
		{
			if(!isremovedentity(var_02))
			{
				var_02 delete();
			}
		}
	}

	level.enemy_free_vehicles = undefined;
	if(isdefined(level.player.drivingvehicle) && isdefined(level.player.drivingvehicle.progress_node))
	{
		level.player.drivingvehicle.progress_node = undefined;
	}
}

//Function Number: 5
spawn_vehicle_and_attach_to_free_path(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(level.enemy_free_vehicles))
	{
		level.enemy_free_vehicles = [];
	}

	if(level.enemy_free_vehicles.size >= 8)
	{
		return undefined;
	}

	if(param_02 && param_03)
	{
		var_04 = getentarray(self.target,"targetname");
		var_05 = [];
		foreach(var_07 in var_04)
		{
			if(var_07.code_classname == "info_vehicle_node")
			{
				continue;
			}

			var_05[var_05.size] = var_07;
		}

		var_05 = common_scripts\utility::get_array_of_closest(self.origin,var_05);
		foreach(var_0B, var_0A in var_05)
		{
			var_0A thread maps\_utility::add_spawn_function(::guy_spawns_and_gets_in_vehicle,self,var_0B);
		}

		var_0C = maps\_utility::spawn_vehicle();
		var_0C waittill("guy_entered");
		wait(3);
		if(!self.riders.size)
		{
			return undefined;
		}
	}
	else
	{
		var_0C = maps\_utility::spawn_vehicle();
	}

	var_0C.dontunloadonend = 1;
	var_0C.has_riders = param_02;
	var_0C thread maps\_vehicle_code::vehicle_becomes_crashable();
	if(isdefined(param_00))
	{
		var_0C vehphys_setspeed(param_00);
	}

	if(param_01)
	{
		wait(0.15);
		var_0C leave_path_for_free_path(1,param_00);
	}
	else
	{
		var_0C thread leave_path_for_free_path(0,param_00);
		var_0C thread maps\_vehicle_code::_gopath(var_0C);
	}

	return var_0C;
}

//Function Number: 6
leave_path_for_free_path(param_00,param_01)
{
	self endon("death");
	self endon("script_crash_vehicle");
	if(!param_00)
	{
		level endon("stop_vehicle_free_path");
		common_scripts\utility::waittill_either("enable_free_path","reached_end_node");
	}

	var_02 = get_my_free_path_node(self.origin);
	if(isdefined(level.drive_free_path_func))
	{
		var_02 thread [[ level.drive_free_path_func ]](self,param_01);
	}

	thread vehicle_crash_detection();
}

//Function Number: 7
get_my_free_path_node(param_00)
{
	param_00 = (param_00[0],param_00[1],0);
	var_01 = common_scripts\utility::get_array_of_closest(param_00,level.vehicle_free_path,undefined,3);
	var_02 = var_01[0];
	var_03 = var_02.index;
	if(var_01[1].index < var_03)
	{
		var_02 = var_01[1];
		var_03 = var_02.index;
	}

	if(var_01[2].index < var_03)
	{
		var_02 = var_01[2];
	}

	return var_02;
}

//Function Number: 8
guy_spawns_and_gets_in_vehicle(param_00,param_01)
{
	maps\_vehicle_code::_mount_snowmobile(param_00,param_01);
}

//Function Number: 9
setup_free_drive_path(param_00)
{
	var_01 = create_path(param_00);
	add_collision_to_path(var_01);
	return var_01;
}

//Function Number: 10
create_path(param_00)
{
	var_01 = common_scripts\utility::getstruct(param_00,"targetname");
	var_02 = [];
	var_03 = 0;
	var_04 = var_01;
	for(;;)
	{
		var_05 = var_01;
		if(isdefined(var_01.target))
		{
			var_05 = common_scripts\utility::getstruct(var_01.target,"targetname");
		}

		var_01.origin = drop_point_to_ground(var_01.origin);
		var_02[var_02.size] = var_01;
		var_01.next_node = var_05;
		var_01.prev_node = var_04;
		var_01.col_lines = [];
		var_01.col_volumes = [];
		var_01.col_moving_volumes = [];
		var_01.origins = [];
		var_01.origins["left"] = var_01.origin;
		var_06 = common_scripts\utility::getstruct(var_01.script_linkto,"script_linkname");
		var_06.origin = drop_point_to_ground(var_06.origin);
		var_01.origins["right"] = var_06.origin;
		var_01.road_width = distance(var_01.origins["right"],var_01.origins["left"]);
		var_01.midpoint = var_01.origins["left"] + var_01.origins["right"] * 0.5;
		var_01.index = var_03;
		var_03++;
		if(var_01 == var_05)
		{
			break;
		}

		var_04 = var_01;
		var_01 = var_05;
	}

	foreach(var_08 in var_02)
	{
		if(var_08.next_node == var_08)
		{
			continue;
		}

		var_09 = var_08.midpoint;
		var_0A = var_08.next_node.midpoint;
		var_0B = vectortoangles(var_09 - var_0A);
		var_0C = anglestoright(var_0B);
		var_0D = var_08.road_width * 0.5;
		var_08.origins["left"] = var_08.midpoint + var_0C * var_0D;
		var_08.origins["left_warning"] = var_08.midpoint + var_0C * var_0D * level.freedrive_stay_within_percent_of_edge;
		var_08.origins["right"] = var_08.midpoint + var_0C * var_0D * -1;
		var_08.origins["right_warning"] = var_08.midpoint + var_0C * var_0D * -1 * level.freedrive_stay_within_percent_of_edge;
	}

	foreach(var_08 in var_02)
	{
		var_08.dist_to_next_node = distance(var_08.midpoint,var_08.next_node.midpoint);
	}

	return var_02;
}

//Function Number: 11
add_collision_to_path(param_00)
{
	var_01 = common_scripts\utility::getstructarray("road_path_col","targetname");
	foreach(var_03 in var_01)
	{
		var_04 = common_scripts\utility::getstruct(var_03.target,"targetname");
		var_03.origin = drop_point_to_ground(var_03.origin);
		var_04.origin = drop_point_to_ground(var_04.origin);
		var_03.other_col_point = var_04;
		var_04.other_col_point = var_03;
	}

	foreach(var_07 in param_00)
	{
		foreach(var_03 in var_01)
		{
			if(!isdefined(var_03.line_claimed))
			{
				add_collision_to_path_node(var_07,var_03);
			}
		}
	}
}

//Function Number: 12
add_collision_to_path_node(param_00,param_01)
{
	if(param_00 == param_00.next_node)
	{
		return;
	}

	if(!test_col_points_in_segment(param_00,param_01))
	{
		return;
	}

	var_02 = param_01.other_col_point;
	var_03 = get_progression_between_points(param_01.origin,param_00.midpoint,param_00.next_node.midpoint);
	var_04 = get_progression_between_points(var_02.origin,param_00.midpoint,param_00.next_node.midpoint);
	param_01.progress = var_03["progress"];
	param_01.offset = var_03["offset"];
	var_02.progress = var_04["progress"];
	var_02.offset = var_04["offset"];
	if(var_03["progress"] < var_04["progress"])
	{
		add_collision_offsets_to_path_ent(param_00,param_01,var_02);
		param_00.col_lines[param_00.col_lines.size] = param_01;
		param_01.line_claimed = 1;
		return;
	}

	add_collision_offsets_to_path_ent(param_00,var_02,param_01);
	param_00.col_lines[param_00.col_lines.size] = var_02;
	param_01.line_claimed = 1;
}

//Function Number: 13
test_col_points_in_segment(param_00,param_01)
{
	var_02[0] = param_00.origins["left"];
	var_02[1] = param_00.origins["right"];
	var_02[2] = param_00.next_node.origins["right"];
	var_02[3] = param_00.next_node.origins["left"];
	var_03[0] = param_01.origin;
	var_03[1] = param_01.other_col_point.origin;
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_05 = 0;
		var_06 = 0;
		var_07 = var_02.size - 1;
		while(var_06 < var_02.size)
		{
			if(var_02[var_06][1] > var_03[var_04][1] != var_02[var_07][1] > var_03[var_04][1] && var_03[var_04][0] < var_02[var_07][0] - var_02[var_06][0] * var_03[var_04][1] - var_02[var_06][1] / var_02[var_07][1] - var_02[var_06][1] + var_02[var_06][0])
			{
				var_05 = !var_05;
			}

			var_07 = var_06;
			var_06++;
		}

		if(var_05)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 14
add_collision_offsets_to_path_ent(param_00,param_01,param_02)
{
	var_03 = param_02.progress + 200;
	var_04 = param_01.progress - level.freedrive_dodge_static_early_distance;
	var_05 = undefined;
	var_06 = undefined;
	if(param_02.offset > param_01.offset)
	{
		var_05 = param_02.offset;
		var_06 = param_01.offset;
	}
	else
	{
		var_05 = param_01.offset;
		var_06 = param_02.offset;
	}

	var_07 = param_00;
	var_08 = var_03;
	var_09 = var_04;
	var_0A = var_05;
	var_0B = var_06;
	for(;;)
	{
		var_0C = get_segment_max_progress_at_offset(param_00,var_05);
		var_0D = get_segment_max_progress_at_offset(param_00,var_06);
		var_0E = max(var_0C,var_0D);
		var_0F = min(var_03,var_0E);
		add_vol_to_node(param_00,var_0F,var_04,var_05,var_06);
		if(!isdefined(param_00.next_node) || param_00 == param_00.next_node)
		{
			break;
		}

		var_03 = var_03 - var_0E;
		var_04 = 0;
		if(var_03 <= 0)
		{
			break;
		}

		var_10 = get_position_from_spline(param_00,var_0C,var_05);
		var_11 = get_position_from_spline(param_00,var_0D,var_06);
		param_00 = param_00.next_node;
		var_12 = get_progression_between_points(var_10,param_00.midpoint,param_00.next_node.midpoint);
		var_05 = var_12["offset"];
		var_13 = get_progression_between_points(var_11,param_00.midpoint,param_00.next_node.midpoint);
		var_06 = var_13["offset"];
	}

	param_00 = var_07;
	var_03 = var_08;
	var_04 = var_09;
	var_05 = var_0A;
	var_06 = var_0B;
	for(;;)
	{
		if(!isdefined(param_00.prev_node) || param_00 == param_00.prev_node)
		{
			break;
		}

		if(var_04 > 0)
		{
			break;
		}

		var_10 = get_position_from_spline(param_00,0,var_05);
		var_11 = get_position_from_spline(param_00,0,var_06);
		param_00 = param_00.prev_node;
		var_12 = get_progression_between_points(var_10,param_00.midpoint,param_00.next_node.midpoint);
		var_05 = var_12["offset"];
		var_13 = get_progression_between_points(var_11,param_00.midpoint,param_00.next_node.midpoint);
		var_06 = var_13["offset"];
		var_03 = max(var_12["progress"],var_13["progress"]);
		var_04 = var_04 + var_03;
		add_vol_to_node(param_00,var_03,var_04,var_05,var_06);
	}
}

//Function Number: 15
add_vol_to_node(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = spawnstruct();
	var_05.colvol = [];
	var_05.colvol["max"] = param_01;
	var_05.colvol["min"] = param_02;
	if(var_05.colvol["min"] < 0)
	{
		var_05.colvol["min"] = 0;
	}

	if(isdefined(param_00.next_node) && param_00 != param_00.next_node)
	{
	}

	var_05.colvol["left_offset"] = param_04;
	var_05.colvol["right_offset"] = param_03;
	var_05.colvol["mid_offset"] = param_03 + param_04 * 0.5;
	param_00.col_volumes[param_00.col_volumes.size] = var_05;
}

//Function Number: 16
add_moving_obstacle(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.ent = self;
	var_02.bounds = param_00;
	if(isdefined(param_01) && param_01 == 1)
	{
		var_02 thread remove_moving_obstacle_on_death();
	}

	var_02 thread update_moving_object_volume();
}

//Function Number: 17
remove_moving_obstacle_on_death()
{
	level endon("stop_vehicle_free_path");
	self.ent endon("moving_obstacle_removed");
	self.ent waittill("death");
	remove_moving_obstacle();
}

//Function Number: 18
remove_moving_obstacle()
{
	unregister_moving_collision_on_nodes();
	self.ent notify("moving_obstacle_removed");
}

//Function Number: 19
update_moving_object_volume()
{
	level endon("stop_vehicle_free_path");
	self.ent endon("moving_obstacle_removed");
	self.ent endon("death");
	self.node = self.ent get_my_free_path_node(self.ent.origin);
	var_00 = self.ent get_progression_between_points(self.ent.origin,self.node.midpoint,self.node.next_node.midpoint);
	var_01 = self.ent move_to_correct_node(self.node,var_00["progress"],var_00["offset"]);
	self.node = var_01.node;
	for(;;)
	{
		var_00 = self.ent get_progression_between_points(self.ent.origin,self.node.midpoint,self.node.next_node.midpoint);
		var_01 = self.ent move_to_correct_node(self.node,var_00["progress"],var_00["offset"]);
		if(self.node != var_01.node)
		{
			self.node = var_01.node;
		}

		update_moving_collision_on_node();
		wait(0.1);
	}
}

//Function Number: 20
update_moving_collision_on_node()
{
	var_00 = anglestoforward(self.ent.angles);
	var_01 = anglestoright(self.ent.angles);
	self.corners = [];
	self.corners[0] = drop_point_to_ground(self.ent.origin + -1 * self.bounds["width"] / 2 * var_01 + self.bounds["length"] / 2 * var_00);
	self.corners[1] = drop_point_to_ground(self.ent.origin + self.bounds["width"] / 2 * var_01 + self.bounds["length"] / 2 * var_00);
	self.corners[2] = drop_point_to_ground(self.ent.origin + -1 * self.bounds["width"] / 2 * var_01 + -1 * self.bounds["length"] / 2 * var_00);
	self.corners[3] = drop_point_to_ground(self.ent.origin + self.bounds["width"] / 2 * var_01 + -1 * self.bounds["length"] / 2 * var_00);
	var_02 = [];
	var_02[0] = get_progression_between_points(self.corners[0],self.node.midpoint,self.node.next_node.midpoint);
	var_02[1] = get_progression_between_points(self.corners[1],self.node.midpoint,self.node.next_node.midpoint);
	var_02[2] = get_progression_between_points(self.corners[2],self.node.midpoint,self.node.next_node.midpoint);
	var_02[3] = get_progression_between_points(self.corners[3],self.node.midpoint,self.node.next_node.midpoint);
	var_03 = var_02[0]["offset"];
	var_04 = var_03;
	var_05 = var_02[0]["progress"];
	var_06 = var_05;
	for(var_07 = 1;var_07 < var_02.size;var_07++)
	{
		if(var_02[var_07]["offset"] < var_03)
		{
			var_03 = var_02[var_07]["offset"];
		}

		if(var_02[var_07]["offset"] > var_04)
		{
			var_04 = var_02[var_07]["offset"];
		}

		if(var_02[var_07]["progress"] < var_05)
		{
			var_05 = var_02[var_07]["progress"];
		}

		if(var_02[var_07]["progress"] > var_06)
		{
			var_06 = var_02[var_07]["progress"];
		}
	}

	var_06 = var_06 + 200;
	var_05 = var_05 - 200;
	unregister_moving_collision_on_nodes();
	register_moving_collision_on_nodes(var_06,var_05,var_04,var_03);
}

//Function Number: 21
register_moving_collision_on_nodes(param_00,param_01,param_02,param_03)
{
	var_04 = param_00;
	var_05 = param_01;
	var_06 = param_02;
	var_07 = param_03;
	var_08 = self.node;
	var_09 = var_08;
	for(;;)
	{
		var_0A = get_segment_max_progress_at_offset(var_09,param_02);
		var_0B = get_segment_max_progress_at_offset(var_09,param_03);
		var_0C = max(max(var_0A,var_0B),0);
		var_0D = min(param_00,var_0C);
		if(var_0D <= 0)
		{
			break;
		}

		add_moving_vol_to_node(var_09,var_0D,param_01,param_02,param_03);
		if(!isdefined(var_09.next_node) || var_09 == var_09.next_node)
		{
			break;
		}

		param_00 = param_00 - var_0C;
		param_01 = 0;
		if(param_00 <= 0)
		{
			break;
		}

		var_0E = get_position_from_spline(var_09,var_0A,param_02);
		var_0F = get_position_from_spline(var_09,var_0B,param_03);
		var_09 = var_09.next_node;
		var_10 = get_progression_between_points(var_0E,var_09.midpoint,var_09.next_node.midpoint);
		param_02 = var_10["offset"];
		var_11 = get_progression_between_points(var_0F,var_09.midpoint,var_09.next_node.midpoint);
		param_03 = var_11["offset"];
	}

	var_09 = var_08;
	param_00 = var_04;
	param_01 = var_05;
	param_02 = var_06;
	param_03 = var_07;
	for(;;)
	{
		if(!isdefined(var_09.prev_node) || var_09 == var_09.prev_node)
		{
			break;
		}

		if(param_01 > 0)
		{
			break;
		}

		var_0E = get_position_from_spline(var_09,0,param_02);
		var_0F = get_position_from_spline(var_09,0,param_03);
		var_09 = var_09.prev_node;
		var_10 = get_progression_between_points(var_0E,var_09.midpoint,var_09.next_node.midpoint);
		param_02 = var_10["offset"];
		var_11 = get_progression_between_points(var_0F,var_09.midpoint,var_09.next_node.midpoint);
		param_03 = var_11["offset"];
		param_00 = max(var_10["progress"],var_11["progress"]);
		param_01 = param_01 + param_00;
		if(param_00 <= 0)
		{
			break;
		}

		add_moving_vol_to_node(var_09,param_00,param_01,param_02,param_03);
	}
}

//Function Number: 22
unregister_moving_collision_on_nodes()
{
	foreach(var_01 in level.vehicle_free_path)
	{
		foreach(var_03 in var_01.col_moving_volumes)
		{
			if(var_03.owner == self)
			{
				var_01.col_moving_volumes = common_scripts\utility::array_remove(var_01.col_moving_volumes,var_03);
			}
		}
	}
}

//Function Number: 23
add_moving_vol_to_node(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = spawnstruct();
	var_05.colvol = [];
	var_05.owner = self;
	var_05.colvol["max"] = param_01;
	var_05.colvol["min"] = param_02;
	if(var_05.colvol["min"] < 0)
	{
		var_05.colvol["min"] = 0;
	}

	if(param_00.index != 0)
	{
	}
	else if(var_05.colvol["min"] < var_05.colvol["max"])
	{
		return;
	}

	var_05.colvol["left_offset"] = param_04;
	var_05.colvol["right_offset"] = param_03;
	var_05.colvol["mid_offset"] = param_03 + param_04 * 0.5;
	param_00.col_moving_volumes[param_00.col_moving_volumes.size] = var_05;
}

//Function Number: 24
vehicle_drives_free_path(param_00,param_01)
{
	level endon("stop_vehicle_free_path");
	param_00 endon("death");
	param_00 notify("enable_free_path");
	if(param_00.has_riders && !param_00.riders.size)
	{
		param_00 vehphys_crash();
		return;
	}

	var_02 = self;
	if(isdefined(param_01))
	{
		param_00.starting_speed = param_01;
	}
	else
	{
		param_00.starting_speed = param_00 vehicle_getspeed();
	}

	param_00.wipeout = 0;
	param_00.progress_node = var_02;
	param_00.progress = 0;
	param_00.endpos = param_00.origin;
	param_00.extra_lookahead = 0;
	param_00.move_fails = 0;
	param_00.path_timeout = gettime();
	common_scripts\utility::array_thread(param_00.riders,::rider_death_detection,param_00);
	param_00 thread vehicle_death_watcher();
	update_vehicle_status(param_00);
	for(;;)
	{
		if(!isalive(param_00))
		{
			break;
		}

		if(param_00.wipeout)
		{
			param_00 vehphys_crash();
			foreach(var_04 in param_00.riders)
			{
				if(isalive(var_04))
				{
					var_04 kill();
				}
			}

			param_00 kill();
			wait(5);
			if(isdefined(param_00))
			{
				param_00 delete();
			}

			update_vehicle_status();
			return;
		}

		if(!var_03.wipeout && var_03 vehicle_getspeed() < 2)
		{
			var_03.move_fails++;
			if(var_03.move_fails > 5)
			{
				var_03 wipeout("move fail!");
			}
		}
		else
		{
			var_03.move_fails = 0;
		}

		var_03 set_vehicle_goal_position();
		wait(0.05);
	}
}

//Function Number: 25
set_vehicle_goal_position()
{
	var_00 = self;
	var_01 = var_00.progress_node;
	if(var_01 == var_01.next_node)
	{
		return;
	}

	var_02 = get_progression_between_points(var_00.origin,var_01.midpoint,var_01.next_node.midpoint);
	var_03 = var_02["offset"];
	var_04 = var_01.road_width;
	var_05 = move_to_correct_node(var_01,var_02["progress"],var_03);
	var_06 = var_05.progress;
	var_07 = var_05.offset;
	var_01 = var_05.node;
	var_00.progress_node = var_01;
	var_00.progress = var_06;
	if(var_01 == var_01.next_node)
	{
		return;
	}

	var_08 = move_to_correct_node(var_01,var_06 + var_00.extra_lookahead,var_07);
	var_09 = var_08.progress;
	var_0A = var_08.offset;
	var_0B = var_08.node;
	var_0C = get_edge_offset_bounds_at_progress(var_0B,var_09);
	var_0D = get_obstacle_dodge_amount(var_0B,var_09,var_0A,1);
	var_0E = 0;
	if(isdefined(var_0D["dodge1"]))
	{
		var_0A = var_0D["dodge1"];
		var_0E = 1;
		if(isdefined(var_0C["right"]) && var_0A > var_0C["right"])
		{
			var_0A = var_0D["dodge2"];
		}

		if(isdefined(var_0C["left"]) && var_0A < var_0C["left"])
		{
			var_0A = var_0D["dodge2"];
		}
	}

	if(isdefined(var_0C["right"]) && var_0A > var_0C["right"])
	{
		var_0A = var_0C["right"];
		var_0E = 1;
	}

	if(isdefined(var_0C["left"]) && var_0A < var_0C["left"])
	{
		var_0A = var_0C["left"];
		var_0E = 1;
	}

	var_0F = 0;
	var_00.endpos = var_00 get_vehicle_pos_from_spline(var_0B,var_09,var_0A,var_0F);
	var_10 = maps\_utility::get_dot(var_00.origin,var_00.angles,var_00.endpos);
	var_11 = 1;
	if(var_10 > 0.9659)
	{
		var_11 = 1;
	}
	else if(var_10 > 0.866)
	{
		var_11 = 0.85;
	}
	else if(var_10 > 0.7071)
	{
		var_11 = 0.65;
	}
	else if(var_10 > 0.5)
	{
		var_11 = 0.4;
	}
	else
	{
		var_11 = 0.1;
	}

	var_12 = max(var_00.starting_speed * var_11,level.freedrive_vehicle_min_allowed_speed);
	var_00 vehicledriveto(var_00.endpos,var_12);
	if(isdefined(level.player.drivingvehicle))
	{
		var_00 match_player_speed(var_11);
	}
}

//Function Number: 26
get_obstacle_dodge_amount(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03) && param_03 == 1)
	{
		foreach(var_05 in param_00.col_volumes)
		{
			var_05.has_veh_collision = 0;
		}

		foreach(var_05 in param_00.col_moving_volumes)
		{
			var_05.has_veh_collision = 0;
		}
	}

	var_09 = [];
	var_0A = common_scripts\utility::array_combine(param_00.col_volumes,param_00.col_moving_volumes);
	foreach(var_05 in var_0A)
	{
		if(var_05.has_veh_collision == 1)
		{
			continue;
		}

		if(isdefined(var_05.owner) && isdefined(var_05.owner.ent) && var_05.owner.ent == self)
		{
			continue;
		}

		if(param_01 < var_05.colvol["min"])
		{
			continue;
		}

		if(param_01 > var_05.colvol["max"])
		{
			continue;
		}

		if(param_02 < var_05.colvol["left_offset"])
		{
			continue;
		}

		if(param_02 > var_05.colvol["right_offset"])
		{
			continue;
		}

		var_0C = var_05.colvol["right_offset"] + 50;
		var_0D = var_05.colvol["left_offset"] - 50;
		var_05.has_veh_collision = 1;
		var_0E = get_obstacle_dodge_amount(param_00,param_01,var_0C);
		var_0F = get_obstacle_dodge_amount(param_00,param_01,var_0D);
		if(var_0E.size > 0)
		{
			if(var_0E["dodge1"] > var_0C)
			{
				var_0C = var_0E["dodge1"];
			}

			if(var_0E["dodge2"] > var_0C)
			{
				var_0C = var_0E["dodge2"];
			}

			if(var_0E["dodge1"] < var_0D)
			{
				var_0D = var_0E["dodge1"];
			}

			if(var_0E["dodge2"] < var_0D)
			{
				var_0D = var_0E["dodge2"];
			}
		}

		if(var_0F.size > 0)
		{
			if(var_0F["dodge1"] > var_0C)
			{
				var_0C = var_0F["dodge1"];
			}

			if(var_0F["dodge2"] > var_0C)
			{
				var_0C = var_0F["dodge2"];
			}

			if(var_0F["dodge1"] < var_0D)
			{
				var_0D = var_0F["dodge1"];
			}

			if(var_0F["dodge2"] < var_0D)
			{
				var_0D = var_0F["dodge2"];
			}
		}

		var_10 = var_0C + var_0D * 0.5;
		if(param_02 > var_10)
		{
			var_09["dodge1"] = var_0C;
			var_09["dodge2"] = var_0D;
		}
		else
		{
			var_09["dodge1"] = var_0D;
			var_09["dodge2"] = var_0C;
		}

		break;
	}

	return var_09;
}

//Function Number: 27
update_vehicle_status(param_00)
{
	var_01 = [];
	foreach(var_03 in level.enemy_free_vehicles)
	{
		if(!isalive(var_03))
		{
			continue;
		}

		if(var_03.wipeout)
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	level.enemy_free_vehicles = var_01;
	if(isalive(param_00) && !param_00.wipeout)
	{
		if(!common_scripts\utility::array_contains(level.enemy_free_vehicles,param_00))
		{
			level.enemy_free_vehicles[level.enemy_free_vehicles.size] = param_00;
			if(1)
			{
				level.enemy_free_vehicles = common_scripts\utility::array_sort_by_handler(level.enemy_free_vehicles,::get_total_distance2d_on_path);
			}
		}
	}

	var_05 = level.freedrive_progress_mod_default;
	var_06 = 200;
	foreach(var_03 in level.enemy_free_vehicles)
	{
		var_03.player_chase_progress_mod = var_05;
		var_05 = var_05 + level.freedrive_progress_mod_step;
		var_03.extra_lookahead = var_06;
		var_06 = var_06 + 100;
	}
}

//Function Number: 28
get_total_distance2d_on_path()
{
	var_00 = 0;
	var_01 = 0;
	var_02 = self.progress_node;
	if(!isdefined(var_02) || !isdefined(self.progress))
	{
		return 0;
	}

	var_03 = maps\_utility::getent_or_struct(var_02.target,"targetname");
	var_00 = self.progress;
	for(;;)
	{
		if(!isdefined(var_02.targetname))
		{
			break;
		}

		var_03 = var_02;
		var_02 = maps\_utility::getent_or_struct(var_02.targetname,"target");
		if(!isdefined(var_02))
		{
			break;
		}

		var_01++;
		var_00 = var_00 + distance2d(var_03.origin,var_02.origin);
	}

	return var_00;
}

//Function Number: 29
distance2d_to_player()
{
	return distance2dsquared(self.origin,level.player.origin);
}

//Function Number: 30
vehicle_death_watcher()
{
	self waittill("death");
	wait 0.05;
	update_vehicle_status();
}

//Function Number: 31
rider_death_detection(param_00)
{
	self waittill("death");
	if(isdefined(param_00))
	{
		param_00 wipeout("driver died!");
	}
}

//Function Number: 32
vehicle_crash_detection()
{
	level endon("stop_vehicle_free_path");
	self endon("death");
	for(;;)
	{
		self waittill("veh_contact",var_00,var_01,var_02,var_03,var_04);
		if(isdefined(var_03))
		{
			var_05 = length(var_03) / 63360 * 60 * 60;
			if(var_05 > 20)
			{
				wipeout("crash");
			}
		}
	}
}

//Function Number: 33
wipeout(param_00)
{
	self.wipeout = 1;
}

//Function Number: 34
match_player_speed(param_00)
{
	if(!isdefined(level.player.drivingvehicle.progress_node))
	{
		level.player.drivingvehicle.progress_node = get_my_free_path_node(level.player.drivingvehicle.origin);
	}

	var_01 = get_progression_between_points(level.player.drivingvehicle.origin,level.player.drivingvehicle.progress_node.midpoint,level.player.drivingvehicle.progress_node.next_node.midpoint);
	var_02 = move_to_correct_node(level.player.drivingvehicle.progress_node,var_01["progress"],var_01["offset"]);
	var_03 = var_02.progress;
	var_04 = var_02.offset;
	level.player.drivingvehicle.progress_node = var_02.node;
	var_05 = progress_dif(self.progress_node,self.progress,var_02.node,var_02.progress);
	var_05 = var_05 - self.player_chase_progress_mod;
	if(var_05 < level.freedrive_playermatch_farbehind_delete_dist)
	{
		if(gettime() > self.path_timeout + 2000)
		{
			wipeout("too far behind");
			return;
		}
	}
	else if(var_05 > level.freedrive_playermatch_farahead_delete_dist)
	{
		if(gettime() > self.path_timeout + 2000)
		{
			wipeout("too far ahead");
			return;
		}
	}
	else
	{
		self.path_timeout = gettime();
	}

	if(param_00 < 0.6)
	{
		return;
	}

	var_06 = get_multiplier(var_05);
	var_07 = max(level.player.drivingvehicle vehicle_getspeed() * var_06,level.freedrive_vehicle_min_allowed_speed);
	if(self vehicle_isphysveh())
	{
		self vehphys_setspeed(var_07);
		return;
	}

	self vehicle_setspeed(var_07);
}

//Function Number: 35
get_multiplier(param_00)
{
	var_01 = level.freedrive_playermatch_matched_multiplier;
	if(param_00 < level.freedrive_playermatch_catchup_ramp_start_dist)
	{
		var_01 = level.freedrive_playermatch_catchup_multiplier;
	}
	else if(param_00 > level.freedrive_playermatch_slowdown_ramp_end_dist)
	{
		var_01 = level.freedrive_playermatch_slowdown_multiplier;
	}
	else if(param_00 < level.freedrive_playermatch_catchup_ramp_end_dist)
	{
		var_02 = level.freedrive_playermatch_catchup_ramp_end_dist - level.freedrive_playermatch_catchup_ramp_start_dist;
		var_03 = level.freedrive_playermatch_catchup_ramp_end_dist - param_00 / var_02;
		var_04 = level.freedrive_playermatch_catchup_multiplier - level.freedrive_playermatch_matched_multiplier;
		var_01 = var_03 * var_04 + level.freedrive_playermatch_matched_multiplier;
	}
	else if(param_00 > level.freedrive_playermatch_slowdown_ramp_start_dist)
	{
		var_02 = level.freedrive_playermatch_slowdown_ramp_end_dist - level.freedrive_playermatch_slowdown_ramp_start_dist;
		var_03 = param_00 - level.freedrive_playermatch_slowdown_ramp_start_dist / var_02;
		var_04 = level.freedrive_playermatch_slowdown_multiplier - level.freedrive_playermatch_matched_multiplier;
		var_01 = var_03 * var_04 + level.freedrive_playermatch_matched_multiplier;
	}
	else
	{
		var_05 = level.freedrive_playermatch_matched_multiplier;
	}

	return var_01;
}

//Function Number: 36
progress_dif(param_00,param_01,param_02,param_03)
{
	while(param_00.index > param_02.index)
	{
		param_00 = param_00.prev_node;
		param_01 = param_01 + param_00.dist_to_next_node;
	}

	while(param_02.index > param_00.index)
	{
		param_02 = param_02.prev_node;
		param_03 = param_03 + param_02.dist_to_next_node;
	}

	return param_01 - param_03;
}

//Function Number: 37
get_progression_between_points(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = vectornormalize(param_02 - param_01);
	var_05 = param_00 - param_01;
	var_06 = vectordot(var_05,var_04);
	var_07 = param_01 + var_04 * var_06;
	var_03["progress"] = var_06;
	var_03["offset"] = distance2d(var_07,param_00);
	var_08 = anglestoright(vectortoangles(var_04));
	var_09 = vectornormalize(var_07 - param_00);
	var_0A = vectordot(var_08,var_09);
	var_03["side"] = "right";
	if(var_0A > 0)
	{
		var_03["offset"] = var_03["offset"] * -1;
		var_03["side"] = "left";
	}

	return var_03;
}

//Function Number: 38
get_segment_max_progress_at_offset(param_00,param_01)
{
	var_02 = param_00.dist_to_next_node;
	var_03 = undefined;
	if(param_01 > 0)
	{
		var_03 = get_progression_between_points(param_00.next_node.origins["right"],param_00.midpoint,param_00.next_node.midpoint);
	}
	else
	{
		var_03 = get_progression_between_points(param_00.next_node.origins["left"],param_00.midpoint,param_00.next_node.midpoint);
	}

	var_04 = param_01 / var_03["offset"];
	var_05 = var_03["progress"] - var_02 * var_04;
	return var_05 + var_02;
}

//Function Number: 39
get_edge_offset_bounds_at_progress(param_00,param_01)
{
	var_02 = [];
	if(isdefined(param_00.next_node.origins["right_warning"]))
	{
		var_03 = get_progression_between_points(param_00.origins["right_warning"],param_00.midpoint,param_00.next_node.midpoint);
		var_04 = get_progression_between_points(param_00.next_node.origins["right_warning"],param_00.midpoint,param_00.next_node.midpoint);
		var_05 = param_01 / var_04["progress"] - var_03["progress"];
		var_02["right"] = var_03["offset"] + var_05 * var_04["offset"] - var_03["offset"];
	}

	if(isdefined(param_00.next_node.origins["left_warning"]))
	{
		var_03 = get_progression_between_points(param_00.origins["left_warning"],param_00.midpoint,param_00.next_node.midpoint);
		var_04 = get_progression_between_points(param_00.next_node.origins["left_warning"],param_00.midpoint,param_00.next_node.midpoint);
		var_05 = param_01 / var_04["progress"] - var_03["progress"];
		var_02["left"] = var_03["offset"] + var_05 * var_04["offset"] - var_03["offset"];
	}

	return var_02;
}

//Function Number: 40
get_position_from_spline(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_04 = vectortoangles(param_00.next_node.midpoint - param_00.midpoint);
	var_05 = anglestoforward(var_04);
	var_06 = anglestoright(var_04);
	return param_00.midpoint + var_05 * param_01 + var_06 * param_02;
}

//Function Number: 41
get_vehicle_pos_from_spline(param_00,param_01,param_02,param_03)
{
	var_04 = get_position_from_spline(param_00,param_01,param_02,param_03);
	return drop_point_to_ground(var_04);
}

//Function Number: 42
drop_point_to_ground(param_00)
{
	var_01 = physicstrace(param_00 + (0,0,100),param_00 + (0,0,-100));
	if(var_01 == param_00 + (0,0,-100))
	{
		var_02 = bullettrace(param_00 + (0,0,100),param_00 + (0,0,-100),0,undefined,0,0,1,0,0);
		if(var_02["position"] == var_01)
		{
			return param_00;
		}

		if(isdefined(var_02["surfacetype"]) && issubstr(var_02["surfacetype"],"water"))
		{
			var_01 = var_02["position"];
		}

		return param_00;
	}

	return var_02;
}

//Function Number: 43
move_to_correct_node(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	for(;;)
	{
		var_04 = param_00.dist_to_next_node;
		if(isdefined(param_02))
		{
			var_04 = get_segment_max_progress_at_offset(param_00,param_02);
		}

		if(param_01 > var_04)
		{
			if(param_00 == param_00.next_node)
			{
				break;
			}

			var_05 = get_position_from_spline(param_00,var_04,param_02);
			param_01 = param_01 - var_04;
			param_00 = param_00.next_node;
			var_06 = get_progression_between_points(var_05,param_00.midpoint,param_00.next_node.midpoint);
			param_02 = var_06["offset"];
			continue;
		}

		if(param_01 < 0)
		{
			if(param_00 == param_00.prev_node)
			{
				break;
			}

			var_05 = get_position_from_spline(param_00,0,param_02);
			param_00 = param_00.prev_node;
			var_06 = get_progression_between_points(var_05,param_00.midpoint,param_00.next_node.midpoint);
			param_01 = param_01 + var_06["progress"];
			param_02 = var_06["offset"];
			continue;
		}

		break;
	}

	var_03.node = param_00;
	var_03.progress = param_01;
	var_03.offset = param_02;
	return var_03;
}

//Function Number: 44
debug_free_path()
{
}

//Function Number: 45
debug_draw_path()
{
	level endon("stop_free_path_debug");
	iprintlnbold("!!!!DEBUG PATH!!!!");
	var_00 = undefined;
	var_01 = undefined;
	for(;;)
	{
		if(!isdefined(level.vehicle_free_path))
		{
			wait(0.05);
			continue;
		}

		var_02 = level.vehicle_free_path;
		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
			var_04 = var_02[var_03];
			if(isdefined(var_04.next_node.origins["left_warning"]))
			{
			}

			if(isdefined(var_04.next_node.origins["right_warning"]))
			{
			}

			foreach(var_06 in var_04.col_volumes)
			{
				var_04 draw_col_vol(var_06.colvol,(0.5,0,1));
			}

			foreach(var_06 in var_04.col_moving_volumes)
			{
				var_04 draw_col_vol(var_06.colvol,(1,0,0.5));
			}

			foreach(var_0B in var_04.col_lines)
			{
				var_0C = var_0B.origin;
				var_0D = var_0B.other_col_point.origin;
			}
		}

		wait(0.05);
	}
}

//Function Number: 46
debug_bike_line(param_00)
{
	var_01 = (0.2,0.2,1);
	if(param_00)
	{
	}
	else
	{
	}
}

//Function Number: 47
draw_col_vol(param_00,param_01)
{
	var_02 = get_position_from_spline(self,param_00["min"],param_00["left_offset"]);
	var_03 = get_position_from_spline(self,param_00["max"],param_00["left_offset"]);
	var_02 = get_position_from_spline(self,param_00["min"],param_00["right_offset"]);
	var_03 = get_position_from_spline(self,param_00["max"],param_00["right_offset"]);
	var_02 = get_position_from_spline(self,param_00["min"],param_00["right_offset"]);
	var_03 = get_position_from_spline(self,param_00["min"],param_00["left_offset"]);
	var_02 = get_position_from_spline(self,param_00["max"],param_00["right_offset"]);
	var_03 = get_position_from_spline(self,param_00["max"],param_00["left_offset"]);
}