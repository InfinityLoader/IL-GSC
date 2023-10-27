/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_vehicle_spline.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 61
 * Decompile Time: 844 ms
 * Timestamp: 10/27/2023 2:20:28 AM
*******************************************************************/

//Function Number: 1
init_vehicle_splines()
{
	common_scripts\utility::create_dvar("vehicle_spline_debug",0);
	level.spline_min_progress = -2000;
	level.enemy_snowmobiles_max = 6;
	level.player_ent = spawn("script_origin",level.player.origin + (0,0,88));
	level.player_ent linkto(level.player);
	level.snowmobile_path = make_road_path();
	common_scripts\utility::flag_init("ai_snowmobiles_ram_player");
	common_scripts\utility::flag_set("ai_snowmobiles_ram_player");
	var_00 = getentarray("enable_spline_path","targetname");
	common_scripts\utility::array_thread(var_00,::enable_spline_path_think);
}

//Function Number: 2
enable_spline_path_think()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		var_00 notify("enable_spline_path");
	}
}

//Function Number: 3
make_road_path()
{
	level.drive_spline_path_fun = ::bike_drives_path;
	var_00 = process_path();
	common_scripts\utility::flag_init("race_complete");
	level.player_view_org = spawn("script_model",(0,0,0));
	level.player_view_org setmodel("tag_origin");
	level.enemy_snowmobiles = [];
	level.bike_score = 0;
	level.player thread bike_death_score();
	return var_00;
}

//Function Number: 4
bike_death_score()
{
	self waittill("death");
}

//Function Number: 5
get_guy_from_spawner()
{
	var_00 = getent("spawner","targetname");
	var_00.count = 1;
	var_00.origin = self.origin;
	var_00.angles = (0,self.angles[1],0);
	return var_00 stalingradspawn();
}

//Function Number: 6
orient_dir(param_00)
{
	for(;;)
	{
		if(!isdefined(self))
		{
			return;
		}

		self orientmode("face angle",param_00);
		wait 0.05;
	}
}

//Function Number: 7
process_path()
{
	var_00 = create_path();
	level.snowmobile_path = var_00;
	add_collision_to_path(var_00);
	return var_00;
}

//Function Number: 8
droppedline(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_00 = maps\_utility::drop_to_ground(param_00);
	param_01 = maps\_utility::drop_to_ground(param_01);
	thread maps\_debug::linedraw(param_00,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 9
droppedlinez(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	param_01 = (param_01[0],param_01[1],param_00);
	param_01 = maps\_utility::drop_to_ground(param_01);
	param_02 = (param_02[0],param_02[1],param_00);
	param_02 = maps\_utility::drop_to_ground(param_02);
	thread maps\_debug::linedraw(param_01,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 10
draw_path(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		var_04 = param_00[var_03];
		var_05 = vectortoangles(var_04.next_node.var_437C - var_04.var_437C);
		var_06 = anglestoforward(var_05) * var_04.dist_to_next_targ;
		var_07 = var_04.road_width * 0.5;
		var_08 = get_position_from_spline(var_04,0,var_07);
		var_09 = get_position_from_spline(var_04,var_04.dist_to_next_targ,var_07);
		droppedlinez(var_04.z,var_08,var_09,(0,0.5,1),1,1,-15536);
		var_0A = get_position_from_spline(var_04,0,var_07 * -1);
		var_0B = get_position_from_spline(var_04,var_04.dist_to_next_targ,var_07 * -1);
		droppedlinez(var_04.z,var_0A,var_0B,(0,0.5,1),1,1,-15536);
		droppedlinez(var_04.z,var_08,var_0A,(0,0.5,1),1,1,-15536);
		droppedlinez(var_04.z,var_09,var_0B,(0,0.5,1),1,1,-15536);
		foreach(var_0D in var_04.col_volumes)
		{
			var_04 draw_col_vol(var_04.z,var_0D);
		}

		foreach(var_10 in var_04.col_lines)
		{
			var_11 = var_10.origin;
			var_12 = var_10.other_col_point.origin;
			droppedlinez(var_04.z,var_11,var_12,(1,0,0),1,1,-15536);
		}
	}
}

//Function Number: 11
draw_col_vol(param_00,param_01)
{
	var_02 = get_position_from_spline(self,param_01["min"],param_01["left_offset"]);
	var_03 = get_position_from_spline(self,param_01["max"],param_01["left_offset"]);
	droppedlinez(param_00,var_02,var_03,(0.5,0,1),1,1,-15536);
	var_02 = get_position_from_spline(self,param_01["min"],param_01["right_offset"]);
	var_03 = get_position_from_spline(self,param_01["max"],param_01["right_offset"]);
	droppedlinez(param_00,var_02,var_03,(0.5,0,1),1,1,-15536);
	var_02 = get_position_from_spline(self,param_01["min"],param_01["right_offset"]);
	var_03 = get_position_from_spline(self,param_01["min"],param_01["left_offset"]);
	droppedlinez(param_00,var_02,var_03,(0.5,0,1),1,1,-15536);
	var_02 = get_position_from_spline(self,param_01["max"],param_01["right_offset"]);
	var_03 = get_position_from_spline(self,param_01["max"],param_01["left_offset"]);
	droppedlinez(param_00,var_02,var_03,(0.5,0,1),1,1,-15536);
}

//Function Number: 12
draw_col_vol_offset(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = self;
	var_06 = get_position_from_spline(var_05,param_01["min"],param_01[param_02]);
	var_07 = get_position_from_spline(var_05,param_01["max"],param_01[param_02]);
	droppedlinez(param_00,var_06,var_07,(0.5,0,1),1,1,-15536);
}

//Function Number: 13
create_path()
{
	var_00 = common_scripts\utility::getstruct("road_path_left","targetname");
	var_01 = [];
	var_00.origin = (var_00.origin[0],var_00.origin[1],0);
	var_02 = 0;
	var_03 = var_00;
	for(;;)
	{
		var_04 = var_00;
		if(isdefined(var_00.target))
		{
			var_04 = common_scripts\utility::getstruct(var_00.target,"targetname");
		}

		var_04.origin = (var_04.origin[0],var_04.origin[1],0);
		var_01[var_01.size] = var_00;
		var_00.next_node = var_04;
		var_00.prev_node = var_03;
		var_04.previous_node = var_00;
		var_00.col_lines = [];
		var_00.col_volumes = [];
		var_00.col_radiuses = [];
		var_00.origins = [];
		var_00.dist_to_next_targs = [];
		var_00.origins["left"] = var_00.origin;
		var_00.index = var_02;
		var_02++;
		if(var_00 == var_04)
		{
			break;
		}

		var_03 = var_00;
		var_00 = var_04;
	}

	var_00 = common_scripts\utility::getstruct("road_path_right","targetname");
	var_00.origin = (var_00.origin[0],var_00.origin[1],0);
	var_05 = 0;
	for(;;)
	{
		var_04 = var_00;
		if(isdefined(var_00.target))
		{
			var_04 = common_scripts\utility::getstruct(var_00.target,"targetname");
		}

		var_04.origin = (var_04.origin[0],var_04.origin[1],0);
		var_06 = var_01[var_05];
		var_06.origins["right"] = var_00.origin;
		var_06.road_width = distance(var_06.origins["right"],var_06.origins["left"]);
		var_05++;
		if(var_00 == var_04)
		{
			break;
		}

		var_00 = var_04;
	}

	foreach(var_08 in var_01)
	{
		var_08.var_437C = var_08.origins["left"] + var_08.origins["right"] * 0.5;
	}

	foreach(var_08 in var_01)
	{
		var_0B = var_08.var_437C;
		var_0C = var_08.next_node.var_437C;
		var_0D = vectortoangles(var_0B - var_0C);
		var_0E = anglestoright(var_0D);
		var_0F = var_08.road_width * 0.5;
		var_08.origins["left"] = var_08.var_437C + var_0E * var_0F;
		var_08.origins["right"] = var_08.var_437C + var_0E * var_0F * -1;
	}

	var_08 = var_01[var_01.size - 1].next_node;
	var_08.var_437C = var_08.origins["left"] + var_08.origins["right"] * 0.5;
	foreach(var_08 in var_01)
	{
		var_08.dist_to_next_targ = distance(var_08.var_437C,var_08.next_node.var_437C);
		var_08.dist_to_next_targs["left"] = distance(var_08.origins["left"],var_08.next_node.origins["left"]);
		var_08.dist_to_next_targs["right"] = distance(var_08.origins["right"],var_08.next_node.origins["right"]);
	}

	return var_01;
}

//Function Number: 14
drop_path_to_ground(param_00)
{
	var_01 = self;
	foreach(var_03 in param_00)
	{
		var_03.origin = var_03.origin + (0,0,20);
		var_04 = physicstrace(var_03.origin,var_03.origin + (0,0,-100));
		var_03.origin = var_04;
	}
}

//Function Number: 15
add_collision_to_path(param_00)
{
	var_01 = common_scripts\utility::getstructarray("moto_line","targetname");
	foreach(var_03 in var_01)
	{
		var_03.origin = (var_03.origin[0],var_03.origin[1],0);
		var_04 = common_scripts\utility::getstruct(var_03.target,"targetname");
		var_03.other_col_point = var_04;
		var_04.other_col_point = var_03;
	}

	foreach(var_03 in var_01)
	{
	}

	var_08 = self;
	foreach(var_0A in param_00)
	{
		foreach(var_03 in var_01)
		{
			add_collision_to_path_ent(var_0A,var_03);
		}
	}

	var_0E = getentarray("moto_collision","targetname");
	foreach(var_10 in var_0E)
	{
		var_11 = maps\_utility::get_array_of_closest(var_10.origin,param_00,undefined,2);
		foreach(var_0A in var_11)
		{
			var_0A.col_radiuses[var_0A.col_radiuses.size] = var_10;
		}
	}
}

//Function Number: 16
get_offset_percent(param_00,param_01,param_02,param_03)
{
	var_04 = distance(param_00.var_437C,param_01.var_437C);
	var_05 = 1 - param_02 / var_04;
	var_06 = "left";
	if(param_03 > 0)
	{
		var_06 = "right";
	}

	var_07 = param_00.origins[var_06];
	var_08 = param_01.origins[var_06];
	var_09 = var_07 * var_05 + var_08 * 1 - var_05;
	var_0A = param_00.var_437C;
	var_0B = param_01.var_437C;
	var_0C = var_0A * var_05 + var_0B * 1 - var_05;
	var_0D = distance(var_0C,var_09);
	return param_03 / var_0D;
}

//Function Number: 17
add_collision_to_path_ent(param_00,param_01)
{
	if(param_00 == param_00.next_node)
	{
		return;
	}

	var_02 = param_00.road_width;
	if(param_00.dist_to_next_targ > var_02)
	{
		var_02 = param_00.dist_to_next_targ;
	}

	if(distance(param_01.origin,param_00.next_node.var_437C) > var_02 * 1.5)
	{
		return;
	}

	var_03 = common_scripts\utility::getstruct(param_01.target,"targetname");
	var_04 = get_progression_between_points(param_01.origin,param_00.var_437C,param_00.next_node.var_437C);
	var_05 = var_04["progress"];
	var_06 = get_progression_between_points(var_03.origin,param_00.var_437C,param_00.next_node.var_437C);
	var_07 = var_06["progress"];
	if(var_05 < 0 || var_07 < 0)
	{
		return;
	}

	if(var_05 > param_00.dist_to_next_targ && var_07 > param_00.dist_to_next_targ)
	{
		return;
	}

	param_01.claimed = 1;
	var_03.claimed = 1;
	param_01.progress = var_05;
	param_01.offset = var_04["offset"];
	param_01.offset_percent = get_offset_percent(param_00,param_00.next_node,var_05,var_04["offset"]);
	var_03.progress = var_07;
	var_03.offset = var_06["offset"];
	var_03.offset_percent = get_offset_percent(param_00,param_00.next_node,var_07,var_06["offset"]);
	param_01.origin = (param_01.origin[0],param_01.origin[1],param_00.var_437C[2] + 40);
	var_03.origin = (var_03.origin[0],var_03.origin[1],param_00.var_437C[2] + 40);
	if(var_05 < var_07)
	{
		add_collision_offsets_to_path_ent(param_00,param_01,var_03);
		param_00.col_lines[param_00.col_lines.size] = param_01;
		return;
	}

	add_collision_offsets_to_path_ent(param_00,var_03,param_01);
	param_00.col_lines[param_00.col_lines.size] = var_03;
}

//Function Number: 18
add_collision_offsets_to_path_ent(param_00,param_01,param_02)
{
	var_03 = param_02.progress + 500;
	var_04 = param_01.progress - level.dodge_distance;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = undefined;
	var_08 = undefined;
	if(param_02.offset > param_01.offset)
	{
		var_05 = param_02.offset;
		var_06 = param_01.offset;
		var_07 = param_02.offset_percent;
		var_08 = param_01.offset_percent;
	}
	else
	{
		var_05 = param_01.offset;
		var_06 = param_02.offset;
		var_07 = param_01.offset_percent;
		var_08 = param_02.offset_percent;
	}

	var_09 = param_00;
	var_0A = var_03;
	var_0B = var_04;
	for(;;)
	{
		add_vol_to_node(param_00,var_03,var_04,var_05,var_06,var_07,var_08);
		if(!isdefined(param_00.next_node))
		{
			break;
		}

		if(param_00.dist_to_next_targ >= var_03)
		{
			break;
		}

		var_03 = var_03 - param_00.dist_to_next_targ;
		param_00 = param_00.next_node;
		var_04 = 0;
	}

	param_00 = var_09;
	var_03 = var_0A;
	var_04 = var_0B;
	for(;;)
	{
		if(!isdefined(param_00.previous_node))
		{
			break;
		}

		if(var_04 > 0)
		{
			break;
		}

		param_00 = param_00.previous_node;
		var_03 = param_00.dist_to_next_targ;
		var_04 = param_00.dist_to_next_targ + var_04;
		add_vol_to_node(param_00,var_03,var_04,var_05,var_06,var_07,var_08);
	}
}

//Function Number: 19
add_vol_to_node(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = [];
	if(var_7B["max"] > param_01.dist_to_next_targ)
	{
	}

	if(var_7B["min"] < 0)
	{
	}

	param_01.col_volumes[param_01.col_volumes.size] = var_7B;
}

//Function Number: 20
get_progression_between_points(param_00,param_01,param_02)
{
	param_01 = (param_01[0],param_01[1],0);
	param_02 = (param_02[0],param_02[1],0);
	param_00 = (param_00[0],param_00[1],0);
	var_03 = [];
	var_04 = vectortoangles(param_02 - param_01);
	var_05 = anglestoforward(var_04);
	var_06 = param_01;
	var_07 = vectornormalize(var_06 - param_00);
	var_08 = vectordot(var_05,var_07);
	var_09 = vectornormalize(param_02 - param_01);
	var_0A = param_00 - param_01;
	var_0B = vectordot(var_0A,var_09);
	var_0C = param_01 + var_05 * var_0B;
	var_03["progress"] = var_0B;
	var_03["offset"] = distance(var_0C,param_00);
	var_0D = anglestoright(var_04);
	var_07 = vectornormalize(var_0C - param_00);
	var_08 = vectordot(var_0D,var_07);
	var_03["dot"] = var_08;
	if(var_08 > 0)
	{
		var_03["offset"] = var_03["offset"] * -1;
	}

	return var_03;
}

//Function Number: 21
wipe_out(param_00)
{
	foreach(var_02 in self.targ.col_radiuses)
	{
		var_03 = (self.origin[0],self.origin[1],0);
		if(distance((var_02.origin[0],var_02.origin[1],0),var_03) < var_02.radius)
		{
			return 1;
		}
	}

	if(param_00.health >= 100)
	{
		return 0;
	}

	level.bike_score++;
	return 1;
}

//Function Number: 22
vehicle_line(param_00)
{
	self endon("death");
	param_00 endon("death");
	wait 0.05;
}

//Function Number: 23
spawner_random_team()
{
	waittillframeend;
	if(!isdefined(self.riders))
	{
		return;
	}

	var_00 = "axis";
	if(common_scripts\utility::cointoss())
	{
		var_00 = "allies";
	}

	foreach(var_02 in self.riders)
	{
		var_02.team = var_00;
	}
}

//Function Number: 24
get_spawn_position(param_00,param_01)
{
	var_02 = move_to_correct_segment(param_00,param_01);
	var_03 = var_02.progress;
	var_04 = var_02.targ;
	var_05 = var_04.road_width * 0.5;
	var_06 = undefined;
	if(isdefined(level.player.offset))
	{
		var_07 = 500;
		if(common_scripts\utility::cointoss())
		{
			var_07 = var_07 * -1;
		}

		var_06 = level.player.offset + var_07;
	}
	else
	{
		var_06 = randomfloatrange(var_05 * -1,var_05);
	}

	var_08 = get_obstacle_dodge_amount(var_04,var_03,var_06);
	if(isdefined(var_08["dodge"]))
	{
		var_06 = var_08["dodge"];
	}

	var_09 = get_position_from_spline_unlimited(var_04,var_03,var_06);
	var_0A = [];
	return var_7B;
}

//Function Number: 25
debug_enemy_vehicles()
{
}

//Function Number: 26
debug_enemy_vehicles_line()
{
	self endon("death");
	level endon("stop_debugging_enemy_vehicles");
	wait 0.05;
}

//Function Number: 27
spawn_enemy_bike()
{
	if(level.enemy_snowmobiles.size >= level.enemy_snowmobiles_max)
	{
		return;
	}

	var_00 = get_player_targ();
	var_01 = get_player_progress();
	var_02 = "forward";
	var_03 = get_spawn_position(var_00,var_01 - 1000 - level.pos_lookahead_dist);
	var_04 = var_03["spawn_pos"];
	var_05 = maps\_utility::within_fov(level.player.origin,level.player.angles,var_04,0);
	if(var_05)
	{
		var_03 = get_spawn_position(var_00,var_01 + 1000);
		var_04 = var_03["spawn_pos"];
		var_02 = "backward";
		var_05 = maps\_utility::within_fov(level.player.origin,level.player.angles,var_04,0);
		if(var_05)
		{
			return;
		}
	}

	var_04 = maps\_utility::drop_to_ground(var_04);
	var_06 = getent("snowmobile_spawner","targetname");
	var_07 = var_03["targ"];
	var_06.origin = var_04;
	var_06.angles = vectortoangles(var_07.next_node.var_437C - var_07.var_437C);
	var_08 = var_06 maps\_vehicle::get_vehicle_ai_spawners();
	foreach(var_0A in var_08)
	{
		var_0A.origin = var_06.origin;
	}

	var_0C = maps\_vehicle::vehicle_spawn(var_06);
	var_0C.offset_percent = var_03["offset"];
	var_0C phys_setspeed(90);
	var_0C thread crash_detection();
	var_0C.left_spline_path_time = gettime() - 3000;
	waittillframeend;
	if(!isalive(var_0C))
	{
		return;
	}

	var_07 bike_drives_path(var_0C);
}

//Function Number: 28
crash_detection()
{
	self waittill("veh_collision",var_00,var_01);
	wipeout("collision!");
}

//Function Number: 29
rider_death_detection(param_00)
{
	self waittill("death");
	if(isdefined(param_00))
	{
		param_00 wipeout("driver died!");
	}
}

//Function Number: 30
wipeout(param_00)
{
	self.wipeout = 1;
}

//Function Number: 31
update_bike_player_avoidance(param_00)
{
	var_01 = [];
	foreach(var_03 in level.enemy_snowmobiles)
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

	level.enemy_snowmobiles = var_01;
	if(isalive(param_00) && !param_00.wipeout)
	{
		var_05 = 0;
		foreach(var_03 in level.enemy_snowmobiles)
		{
			if(var_03 == param_00)
			{
				var_05 = 1;
				continue;
			}
		}

		if(!var_05)
		{
			level.enemy_snowmobiles[level.enemy_snowmobiles.size] = param_00;
		}
	}

	var_08 = 0;
	foreach(var_03 in level.enemy_snowmobiles)
	{
		var_03.bike_avoidance_offset = var_08;
		var_08 = var_08 + 75;
	}
}

//Function Number: 32
bike_drives_path(param_00)
{
	if(!isdefined(param_00.left_spline_path_time))
	{
		param_00.left_spline_path_time = gettime();
	}

	param_00.wipeout = 0;
	update_bike_player_avoidance(param_00);
	if(!isdefined(param_00.player_offset))
	{
		param_00.player_offset = 250;
	}

	param_00.steering = 0;
	var_01 = randomfloatrange(0,1);
	if(!isdefined(param_00.offset_percent))
	{
		param_00.offset_percent = var_01 * 2 - 1;
	}

	var_02 = self;
	var_03 = spawnstruct();
	var_03.origin = self.var_437C;
	var_03.progress = 0;
	var_03.tilt_vel = 0;
	var_03.speed = 100;
	var_03 maps\_utility::ent_flag_init("biker_reaches_path_end");
	param_00 notify("enable_spline_path");
	if(!param_00.riders.size)
	{
		param_00 phys_crash();
		return;
	}

	common_scripts\utility::array_thread(param_00.riders,::rider_death_detection,param_00);
	var_03.bike = param_00;
	param_00.health = 100;
	var_04 = 0;
	var_03 thread bike_ent_wipe_out_check(param_00);
	param_00.progress_targ = var_02;
	param_00.offset_modifier = 0;
	param_00.fails = 0;
	param_00.direction = "forward";
	param_00.old_pos = param_00.origin;
	for(;;)
	{
		if(!isalive(param_00))
		{
			break;
		}

		set_bike_position(var_03);
		if(!isalive(param_00))
		{
			break;
		}

		if(abs(param_00.progress_dif) > 6000 && gettime() > param_00.left_spline_path_time + 4000)
		{
			param_00 wipeout("left behind!");
		}

		waittillframeend;
		if(param_00.wipeout)
		{
			if(isdefined(param_00.hero))
			{
				continue;
			}

			param_00 phys_crash();
			foreach(var_06 in param_00.riders)
			{
				if(isalive(var_06))
				{
					var_06 kill();
				}
			}

			wait 5;
			if(isdefined(param_00))
			{
				param_00 delete();
			}

			update_bike_player_avoidance();
			return;
		}

		if(var_06 maps\_utility::ent_flag("biker_reaches_path_end") || common_scripts\utility::flag("race_complete"))
		{
			break;
		}
	}

	update_bike_player_avoidance();
	var_06 notify("stop_bike");
	level notify("biker_dies");
	if(var_03.wipeout && !common_scripts\utility::flag("race_complete"))
	{
		wait 5;
	}

	var_06 maps\_utility::ent_flag_clear("biker_reaches_path_end");
}

//Function Number: 33
get_obstacle_dodge_amount(param_00,param_01,param_02)
{
	var_03["near_obstacle"] = 0;
	foreach(var_05 in param_00.col_volumes)
	{
		if(param_01 < var_05["min"])
		{
			continue;
		}

		if(param_01 > var_05["max"])
		{
			continue;
		}

		var_03["near_obstacle"] = 1;
		if(param_02 < var_05["left_offset"])
		{
			continue;
		}

		if(param_02 > var_05["right_offset"])
		{
			continue;
		}

		var_06 = param_00.var_437C + param_00.next_node.var_437C * 0.5;
		if(param_02 > var_05["mid_offset"])
		{
			var_03["dodge"] = var_05["right_offset"];
		}
		else
		{
			var_03["dodge"] = var_05["left_offset"];
		}

		break;
	}

	return var_03;
}

//Function Number: 34
sweep_tells_vehicles_to_get_off_path()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!isdefined(var_00.script_noteworthy))
		{
			continue;
		}

		if(var_00.script_noteworthy != "sweepable")
		{
			continue;
		}

		var_01 = randomfloatrange(0,1);
		var_00 thread maps\_utility::notify_delay("enable_spline_path",var_01);
	}
}

//Function Number: 35
drawmyoff()
{
	for(;;)
	{
		if(isdefined(level.player.vehicle))
		{
			var_00 = self vehicle_getspeed();
			var_01 = level.player.vehicle vehicle_getspeed();
			level.difference = var_00 - var_01;
		}

		wait 0.05;
	}
}

//Function Number: 36
priceliner()
{
}

//Function Number: 37
modulate_speed_based_on_progress()
{
	thread priceliner();
	self.targ = maps\_vehicle::get_my_spline_node(self.origin);
	self.min_speed = 1;
	self endon("stop_modulating_speed");
	var_00 = undefined;
	for(;;)
	{
		wait 0.05;
		var_01 = self.targ;
		if(var_01 == var_01.next_node)
		{
			return;
		}

		var_02 = get_progression_between_points(self.origin,self.targ.var_437C,self.targ.next_node.var_437C);
		var_03 = var_02["progress"];
		var_03 = var_03 + level.pos_lookahead_dist;
		var_04 = move_to_correct_segment(self.targ,var_03);
		var_03 = var_04.progress;
		self.targ = var_04.targ;
		self.progress = var_03;
		var_05 = get_player_targ();
		var_06 = get_player_progress();
		var_07 = progress_dif(self.targ,self.progress,var_05,var_06);
		level.progress_dif = var_07;
		if(!isdefined(level.player.vehicle))
		{
			self vehicle_setspeed(65,1,1);
			continue;
		}

		if(abs(var_07 > 3500))
		{
			var_08 = 65;
			var_07 = var_07 * -1;
			var_07 = var_07 + 750;
			var_08 = level.player.vehicle.veh_speed + var_07 * 0.05;
			var_09 = level.player.vehicle.veh_speed;
			if(var_09 < 100)
			{
				var_09 = 100;
			}

			if(var_08 > var_09)
			{
				var_08 = var_09;
			}
			else if(var_08 < self.min_speed)
			{
				var_08 = self.min_speed;
			}

			level.desired_speed = var_08;
			self vehicle_setspeed(var_08,90,20);
			continue;
		}

		price_match_player_speed(10,10);
	}
}

//Function Number: 38
price_match_player_speed(param_00,param_01)
{
	var_02 = self.angles;
	var_02 = (0,var_02[1],0);
	var_03 = anglestoforward(var_02);
	var_04 = get_progression_between_points(level.player.vehicle.origin,self.origin + var_03 * 1,self.origin - var_03 * 1);
	var_05 = var_04["progress"];
	if(var_05 > 4000)
	{
		self vehicle_setspeed(0,90,20);
		return;
	}

	var_06 = maps\_utility::get_dot(self.origin,self.angles,level.player.origin);
	var_07 = 1;
	if(var_05 > 0)
	{
		var_07 = 1;
	}
	else
	{
		if(var_05 > -500)
		{
			var_07 = 1.25;
		}

		if(var_07 > 0.95 && var_06 > 0.97)
		{
			var_07 = 0.95;
		}
	}

	var_08 = 70 * var_07;
	if(var_08 < self.min_speed)
	{
		var_08 = self.min_speed;
	}

	if(var_08 < 25)
	{
		var_08 = 25;
	}

	level.price_desired_speed = var_08;
	self vehicle_setspeed(var_08,param_00,param_01);
}

//Function Number: 39
match_player_speed(param_00,param_01)
{
	var_02 = self.angles;
	var_02 = (0,var_02[1],0);
	var_03 = anglestoforward(var_02);
	var_04 = get_progression_between_points(level.player.vehicle.origin,self.origin + var_03 * 1,self.origin - var_03 * 1);
	var_05 = var_04["progress"];
	if(var_05 > 4000)
	{
		self vehicle_setspeed(0,90,20);
		return;
	}

	if(var_05 < level.spline_min_progress && gettime() > self.left_spline_path_time + 4000)
	{
		wipeout("low progress!");
	}

	var_05 = var_05 - 750;
	var_05 = var_05 + self.bike_avoidance_offset;
	var_06 = 1;
	if(var_05 > 150)
	{
		var_06 = 0.6;
	}
	else if(var_05 > 100)
	{
		var_06 = 1;
	}
	else if(var_05 < -100)
	{
		var_06 = 1.5;
	}

	if(isdefined(level.player.offset))
	{
		if(var_05 > 250)
		{
		}
	}

	var_07 = level.player.vehicle.veh_speed * var_06;
	if(var_07 < 25)
	{
		var_07 = 25;
	}

	self vehicle_setspeed(var_07,param_00,param_01);
}

//Function Number: 40
track_player_progress(param_00)
{
	self notify("track_player_progress");
	self endon("track_player_progress");
	self.targ = maps\_vehicle::get_my_spline_node(param_00);
	self.progress = 0;
	var_01 = getent("player_sweep_trigger","targetname");
	var_02 = isdefined(var_01);
	if(var_02)
	{
		var_01 thread sweep_tells_vehicles_to_get_off_path();
	}

	for(;;)
	{
		if(self.targ == self.targ.next_node)
		{
			return;
		}

		var_03 = get_progression_between_points(self.origin,self.targ.var_437C,self.targ.next_node.var_437C);
		var_04 = var_03["progress"];
		var_04 = var_04 + level.pos_lookahead_dist;
		var_05 = move_to_correct_segment(self.targ,var_04);
		var_04 = var_05.progress;
		self.targ = var_05.targ;
		self.progress = var_04;
		self.offset = var_03["offset"];
		if(var_02)
		{
			var_06 = get_position_from_spline_unlimited(self.targ,var_04 + 2000,0);
			var_06 = (var_06[0],var_06[1],self.origin[2] - 500);
			var_01.origin = var_06;
			var_07 = get_position_from_spline_unlimited(self.targ,var_04 + 3000,0);
			var_08 = vectortoangles(var_01.origin - var_07);
			var_01.angles = (0,var_08[1],0);
		}

		if(common_scripts\utility::flag("ai_snowmobiles_ram_player"))
		{
			level.closest_enemy_snowmobile_to_player = maps\_utility::getclosest(self.origin,level.enemy_snowmobiles);
		}
		else
		{
			level.closest_enemy_snowmobile_to_player = undefined;
		}

		wait 0.05;
	}
}

//Function Number: 41
progress_dif(param_00,param_01,param_02,param_03)
{
	while(param_00.index > param_02.index)
	{
		param_00 = param_00.prev_node;
		param_01 = param_01 + param_00.dist_to_next_targ;
	}

	while(param_02.index > param_00.index)
	{
		param_02 = param_02.prev_node;
		param_03 = param_03 + param_02.dist_to_next_targ;
	}

	return param_01 - param_03;
}

//Function Number: 42
set_bike_position(param_00)
{
	var_01 = param_00.bike;
	var_02 = 0.1;
	var_03 = 0;
	var_04 = 0;
	var_05 = var_01.progress_targ;
	if(var_05 == var_05.next_node)
	{
		var_01 delete();
		return;
	}

	var_06 = get_progression_between_points(var_01.origin,var_05.var_437C,var_05.next_node.var_437C);
	var_07 = get_progression_between_points(var_01.origin,var_05.next_node.var_437C,var_05.next_node.next_node.var_437C);
	if(var_07["progress"] > 0 && var_07["progress"] < var_05.next_node.dist_to_next_targ)
	{
		var_06 = var_07;
		var_05 = var_05.next_node;
	}

	var_04 = var_06["offset"];
	var_08 = 0;
	var_03 = var_06["progress"];
	var_01.progress = var_03;
	var_09 = get_obstacle_dodge_amount(var_05,var_03,var_04);
	var_0A = var_09["near_obstacle"];
	var_0B = progress_dif(var_05,var_03,get_player_targ(),get_player_progress());
	var_01.progress_dif = var_0B;
	if(var_01.direction == "forward")
	{
		var_03 = var_03 + level.pos_lookahead_dist;
	}
	else
	{
		var_03 = var_03 - level.pos_lookahead_dist;
		if(var_0B < 500)
		{
			var_01.direction = "forward";
		}
	}

	var_0C = 60;
	var_0D = 90;
	var_0E = 100;
	var_0F = 200;
	if(var_0B > var_0F)
	{
		var_10 = var_0C;
	}
	else if(var_0C < var_0F)
	{
		var_10 = var_0E;
	}
	else
	{
		var_11 = var_10 - var_0F;
		var_12 = var_0D - var_0C;
		var_10 = var_0B - var_0E;
		var_10 = var_11 - var_10;
		var_10 = var_10 * var_12 / var_11;
		var_10 = var_10 + var_0C;
	}

	if(var_10 > 0)
	{
		if(var_01 vehicle_getspeed() < 2)
		{
			var_01.fails++;
			if(var_01.fails > 10)
			{
				var_01 wipeout("move fail!");
				return;
			}
		}
		else
		{
			var_01.fails = 0;
		}
	}
	else
	{
		var_01.fails = 0;
	}

	var_13 = randomfloatrange(0,100);
	var_13 = var_13 * 0.001;
	var_14 = 0;
	var_15 = var_05.road_width;
	param_00 = move_to_correct_segment(var_05,var_03);
	var_03 = param_00.progress;
	var_05 = param_00.targ;
	var_16 = var_05.var_437C + var_05.next_node.var_437C * 0.5;
	var_04 = var_04 * var_05.road_width / var_15;
	var_09 = get_obstacle_dodge_amount(var_05,var_03,var_04);
	if(isdefined(var_09["dodge"]))
	{
		var_04 = var_09["dodge"];
	}
	else if(isdefined(var_01.preferred_offset))
	{
		var_04 = var_01.preferred_offset;
	}

	var_17 = 0.95;
	var_18 = var_05.road_width * 0.5;
	var_18 = var_18 - 50;
	if(var_04 > var_18)
	{
		var_04 = var_18;
	}
	else if(var_04 < -1 * var_18)
	{
		var_04 = -1 * var_18;
	}

	if(var_05 != var_05.next_node)
	{
		var_19 = var_01 get_bike_pos_from_spline(var_05,var_03,var_04,var_01.origin[2]);
		var_1A = maps\_utility::get_dot(var_01.origin,var_01.angles,var_19);
		if(var_1A < 0.97)
		{
			var_10 = 50;
		}
		else if(var_1A < 0.96)
		{
			var_10 = 25;
		}
		else if(var_1A < 0.95)
		{
			var_10 = 15;
		}

		var_01 vehicledriveto(var_19,var_10);
		if(!isdefined(level.player.vehicle))
		{
			var_01 vehicle_setspeed(65,1,1);
		}
		else
		{
			var_01.veh_topspeed = level.player.vehicle.veh_topspeed * 1.3;
			var_01 match_player_speed(45,30);
		}
	}

	var_01.progress_targ = var_05;
	var_01.offset = var_04;
	wait var_02;
}

//Function Number: 43
get_bike_pos_from_spline(param_00,param_01,param_02,param_03)
{
	var_04 = get_position_from_spline(param_00,param_01,param_02);
	var_04 = maps\_utility::set_z(var_04,param_03);
	return physicstrace(var_04 + (0,0,200),var_04 + (0,0,-200));
}

//Function Number: 44
move_to_correct_segment(param_00,param_01)
{
	var_02 = spawnstruct();
	for(;;)
	{
		if(param_00 == param_00.next_node)
		{
			break;
		}

		if(param_01 > param_00.dist_to_next_targ)
		{
			param_01 = param_01 - param_00.dist_to_next_targ;
			param_00 = param_00.next_node;
			continue;
		}

		if(param_01 < 0)
		{
			param_01 = param_01 + param_00.dist_to_next_targ;
			param_00 = param_00.prev_node;
			continue;
		}

		break;
	}

	var_02.targ = param_00;
	var_02.progress = param_01;
	return var_02;
}

//Function Number: 45
get_position_from_spline_unlimited(param_00,param_01,param_02)
{
	for(;;)
	{
		if(param_00 == param_00.next_node)
		{
			return param_00.var_437C;
		}

		if(param_01 > param_00.dist_to_next_targ)
		{
			param_01 = param_01 - param_00.dist_to_next_targ;
			param_00 = param_00.next_node;
			continue;
		}

		break;
	}

	return get_position_from_spline(param_00,param_01,param_02);
}

//Function Number: 46
get_position_from_spline(param_00,param_01,param_02)
{
	var_03 = vectortoangles(param_00.next_node.var_437C - param_00.var_437C);
	var_04 = anglestoforward(var_03);
	var_05 = anglestoright(var_03);
	return param_00.var_437C + var_04 * param_01 + var_05 * param_02;
}

//Function Number: 47
get_position_from_progress(param_00,param_01)
{
	var_02 = 1 - param_01 / param_00.dist_to_next_targ;
	return param_00.var_437C * var_02 + param_00.next_node.var_437C * 1 - var_02;
}

//Function Number: 48
bike_ent_wipe_out_check(param_00)
{
	self endon("stop_bike");
	for(;;)
	{
		self.wipeout = 0;
		if(self.wipeout)
		{
			break;
		}

		wait 0.05;
	}
}

//Function Number: 49
draw_bike_debug()
{
	for(;;)
	{
		waittillframeend;
		wait 0.05;
	}
}

//Function Number: 50
track_progress()
{
	self endon("stop_bike");
	for(;;)
	{
		var_00 = (self.origin[0],self.origin[1],0);
		var_01 = (self.targ.var_437C[0],self.targ.var_437C[1],0);
		var_02 = (self.next_targ.var_437C[0],self.next_targ.var_437C[1],0);
		var_03 = vectornormalize(var_01 - var_00);
		var_04 = anglestoforward(self.angles);
		var_05 = vectordot(var_04,var_03);
		var_06 = vectornormalize(var_02 - var_01);
		var_07 = var_00 - var_01;
		self.progress = vectordot(var_07,var_06);
		wait 0.05;
	}
}

//Function Number: 51
set_road_offset(param_00)
{
	self.right_offset = param_00.road_width * 0.5;
	self.safe_offset = self.right_offset - 100;
}

//Function Number: 52
bike_avoids_obstacles(param_00)
{
	self endon("stop_bike");
	self endon("end_path");
	self.goal_dir = 0;
	thread bike_randomly_changes_lanes();
	bike_turns();
}

//Function Number: 53
bike_randomly_changes_lanes()
{
	self endon("stop_bike");
	self endon("end_path");
	for(;;)
	{
		if(self.targ.col_volumes.size == 0 && self.dodge_dir == 0)
		{
			if(common_scripts\utility::cointoss())
			{
				self.goal_dir++;
			}
			else
			{
				self.goal_dir--;
			}

			if(self.goal_dir > 1)
			{
				self.goal_dir = self.goal_dir - 3;
			}
			else if(self.goal_dir < -1)
			{
				self.goal_dir = self.goal_dir + 3;
			}
		}

		wait randomfloatrange(1,3);
	}
}

//Function Number: 54
should_stabilize()
{
	if(self.goal_dir == 0)
	{
		return 1;
	}

	if(self.goal_dir == 1 && self.offset > self.safe_offset)
	{
		return 1;
	}

	if(self.goal_dir == -1 && self.offset < self.safe_offset * -1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 55
bike_turns()
{
	self.tilt_vel = 0;
	var_00 = 12;
	var_01 = 3;
	var_02 = 130;
	for(;;)
	{
		if(should_stabilize())
		{
			if(self.tilt > 0)
			{
				self.tilt_vel = self.tilt_vel - var_01;
			}
			else if(self.tilt < 0)
			{
				self.tilt_vel = self.tilt_vel + var_01;
			}
		}
		else if(self.goal_dir == 1)
		{
			self.tilt_vel = self.tilt_vel + var_01;
		}
		else if(self.goal_dir == -1)
		{
			self.tilt_vel = self.tilt_vel - var_01;
		}

		if(self.tilt_vel > var_00)
		{
			self.tilt_vel = var_00;
		}
		else if(self.tilt_vel < -1 * var_00)
		{
			self.tilt_vel = -1 * var_00;
		}

		self.tilt = self.tilt + self.tilt_vel;
		if(self.tilt > var_02)
		{
			self.tilt = var_02;
			self.tilt_vel = 1;
		}
		else if(self.tilt < var_02 * -1)
		{
			self.tilt = var_02 * -1;
			self.tilt_vel = -1;
		}

		wait 0.05;
	}
}

//Function Number: 56
stabalize(param_00,param_01)
{
	if(self.tilt > 0)
	{
		self.tilt = self.tilt - param_01;
	}
	else
	{
		self.tilt = self.tilt + param_01;
	}

	if(abs(self.tilt) < param_01)
	{
		self.tilt = param_01;
	}
}

//Function Number: 57
tilt_right(param_00,param_01)
{
	if(self.offset >= self.safe_offset)
	{
		self.goal_dir = 0;
		return;
	}

	self.tilt = self.tilt + param_01;
	if(self.tilt >= param_00)
	{
		self.tilt = param_00;
	}
}

//Function Number: 58
tilt_left(param_00,param_01)
{
	if(self.offset < self.safe_offset * -1)
	{
		self.goal_dir = 0;
		return;
	}

	self.tilt = self.tilt - param_01;
	if(self.tilt < param_00 * -1)
	{
		self.tilt = param_00 * -1;
	}
}

//Function Number: 59
get_player_progress()
{
	if(isdefined(level.player.progress))
	{
		return level.player.progress;
	}

	return 0;
}

//Function Number: 60
get_player_targ()
{
	if(isdefined(level.player.targ))
	{
		return level.player.targ;
	}

	return level.snowmobile_path[0];
}

//Function Number: 61
debug_bike_line()
{
	var_00 = (0.2,0.2,1);
	if(isdefined(level.player.vehicle) && self.veh_speed > level.player.vehicle.veh_speed)
	{
		var_00 = (1,0.2,0.2);
	}

	self.old_pos = self.origin;
}