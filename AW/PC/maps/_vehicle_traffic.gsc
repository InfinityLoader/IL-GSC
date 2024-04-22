/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _vehicle_traffic.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 144
 * Decompile Time: 2147 ms
 * Timestamp: 4/22/2024 2:24:54 AM
*******************************************************************/

//Function Number: 1
traffic_init(param_00)
{
	traffic_set_traffic_tuning(0);
	common_scripts\utility::create_dvar("vehicle_traffic_debug",0);
	common_scripts\utility::create_dvar("vehicle_traffic_dodge_debug",0);
	common_scripts\utility::create_dvar("vehicle_traffic_lane_change_debug",0);
	common_scripts\utility::create_dvar("vehicle_traffic_debug_spawn",0);
	common_scripts\utility::create_dvar("vehicle_traffic_draw_scriptcar_path",0);
	common_scripts\utility::create_dvar("vehicle_traffic_debug_single",0);
	if(!isdefined(level.traffic_cars))
	{
		level.traffic_cars = 0;
	}

	if(!isdefined(level.traffic_cars_scriptmodel_only_count))
	{
		level.traffic_cars_scriptmodel_only_count = 0;
	}

	if(!isdefined(level.script_cars))
	{
		level.script_cars = [];
	}

	level.traffic_collision_fx_func = param_00;
	thread handle_wakeup_sphere_global();
}

//Function Number: 2
traffic_set_traffic_tuning(param_00)
{
	if(isdefined(param_00) && param_00)
	{
		level.traffic_tune_single_spawn_dist_between_cars = 315;
		level.traffic_tune_fill_spawn_dist_between_cars = 250;
		level.traffic_tune_min_follow_dist = 240;
		level.traffic_tune_min_speedup_dist = 300;
		level.traffic_tune_follow_speed_scale = 0.7;
		level.traffic_tune_min_stop_dist = 230;
		level.traffic_tune_extreme_near_car_dist = 100;
		level.traffic_tune_speedup_speed_scale = 1.3;
		level.traffic_tune_start_spawn_rand_chance = 100;
	}
	else
	{
		level.traffic_tune_single_spawn_dist_between_cars = 800;
		level.traffic_tune_fill_spawn_dist_between_cars = 2000;
		level.traffic_tune_min_follow_dist = 1400;
		level.traffic_tune_min_speedup_dist = 999999;
		level.traffic_tune_follow_speed_scale = 0.8;
		level.traffic_tune_min_stop_dist = 300;
		level.traffic_tune_extreme_near_car_dist = 100;
		level.traffic_tune_speedup_speed_scale = 1;
		level.traffic_tune_start_spawn_rand_chance = 70;
	}

	level.traffic_tune_single_spawn_dist_between_cars_sq = level.traffic_tune_single_spawn_dist_between_cars * level.traffic_tune_single_spawn_dist_between_cars;
	level.traffic_tune_fill_spawn_dist_between_cars_sq = level.traffic_tune_fill_spawn_dist_between_cars * level.traffic_tune_fill_spawn_dist_between_cars;
	level.traffic_tune_min_follow_dist_sq = level.traffic_tune_min_follow_dist * level.traffic_tune_min_follow_dist;
	level.traffic_tune_min_speedup_dist_sq = level.traffic_tune_min_speedup_dist * level.traffic_tune_min_speedup_dist;
	level.traffic_tune_min_stop_dist_sq = level.traffic_tune_min_stop_dist * level.traffic_tune_min_stop_dist;
	level.traffic_tune_extreme_near_car_dist_sq = level.traffic_tune_extreme_near_car_dist * level.traffic_tune_extreme_near_car_dist;
}

//Function Number: 3
traffic_set_traffic_tuning_lagos_highway()
{
	traffic_set_traffic_tuning(0);
	level.traffic_tune_fill_spawn_dist_between_cars = level.traffic_tune_single_spawn_dist_between_cars;
	level.traffic_tune_fill_spawn_dist_between_cars_sq = level.traffic_tune_single_spawn_dist_between_cars_sq;
}

//Function Number: 4
get_max_cars()
{
	if(level.currentgen)
	{
		return 15;
	}

	return 40;
}

//Function Number: 5
traffic_path_head_car_traffic_jam(param_00)
{
	traffic_path_all_cars_helper(param_00,1,1);
}

//Function Number: 6
traffic_path_head_car_traffic_jam_end_thread(param_00)
{
	traffic_path_all_cars_helper(param_00,0,0);
}

//Function Number: 7
traffic_path_head_car_set_force_script_model(param_00,param_01)
{
	traffic_path_all_cars_helper(param_00,param_01,4);
}

//Function Number: 8
traffic_path_head_car_set_force_stop(param_00,param_01)
{
	traffic_path_all_cars_helper(param_00,param_01,3);
}

//Function Number: 9
traffic_path_all_cars_set_force_stop(param_00,param_01)
{
	traffic_path_all_cars_helper(param_00,param_01,0);
}

//Function Number: 10
traffic_path_all_cars_set_script_brush(param_00,param_01)
{
	traffic_path_all_cars_helper(param_00,param_01,2);
}

//Function Number: 11
traffic_path_remove_cars_at_node(param_00,param_01)
{
	traffic_path_all_cars_helper(param_00,param_01,5);
}

//Function Number: 12
traffic_path_set_cars_at_node_ai_path_blocker(param_00,param_01)
{
	traffic_path_all_cars_helper(param_00,param_01,9);
}

//Function Number: 13
traffic_path_all_cars_helper(param_00,param_01,param_02)
{
	var_03 = 1;
	for(;;)
	{
		var_04 = param_00 + "_" + var_03;
		var_05 = getvehiclenodearray(var_04,"targetname");
		if(!isdefined(var_05) || var_05.size <= 0)
		{
			return;
		}

		foreach(var_07 in var_05)
		{
			var_07 notify("stop_car_random_stops");
			if(param_02 == 1)
			{
				var_07 thread traffic_path_head_car_random_stops();
				continue;
			}

			if(param_02 == 6)
			{
				var_07.dont_spawn_over_obstacles = param_01;
				continue;
			}

			if(param_02 == 7)
			{
				var_07.no_crash_handling = param_01;
				continue;
			}

			if(param_02 == 8)
			{
				var_07.do_pathbased_avoidance = param_01;
				continue;
			}

			traffic_path_all_cars_set_command_single_lane(var_07,param_01,param_02);
		}

		var_03++;
	}
}

//Function Number: 14
traffic_path_head_car_random_stops()
{
	level endon("stop_traffic");
	self endon("stop_traffic_lane");
	self endon("stop_car_random_stops");
	var_00 = 1;
	for(;;)
	{
		var_01 = 20 + randomfloat(80) * 0.02;
		wait(var_01);
		traffic_path_all_cars_set_command_single_lane(self,var_00,3);
		var_00 = !var_00;
	}
}

//Function Number: 15
traffic_path_all_cars_set_command_single_lane(param_00,param_01,param_02)
{
	var_03 = param_00.traffic_head_veh;
	while(is_traffic_ent(var_03))
	{
		if(param_02 == 0 || param_02 == 3)
		{
			if(param_01)
			{
				var_03.traffic_speed_override = 0;
				var_03 scale_vehicle_speed(0);
			}
			else
			{
				var_03.traffic_speed_override = undefined;
			}

			if(param_02 == 3)
			{
				break;
			}

			continue;
		}

		if(param_02 == 2)
		{
			if(param_01)
			{
				var_03.vehicle vehicle_assignbrushmodelcollision();
				var_03.vehicle setcandamage(1);
				var_03.vehicle vehphys_enablecrashing();
			}
			else
			{
				var_03.vehicle vehicle_removebrushmodelcollision();
				var_03.vehicle setcandamage(0);
				var_03.vehicle vehphys_disablecrashing();
			}

			continue;
		}

		if(param_02 == 5)
		{
			if(var_03 vehicle_getcurrentnode_a().targetname == param_01)
			{
				var_03 notify("reached_end_node");
			}

			continue;
		}

		if(param_02 == 9)
		{
			if(var_03 vehicle_getcurrentnode_a().targetname == param_01)
			{
				var_03.vehicle disconnectpaths();
			}
		}

		var_03 = var_03.traffic_follower;
	}
}

//Function Number: 16
setup_traffic_path(param_00,param_01,param_02,param_03)
{
	setup_traffic_path_with_options(param_00,param_01,param_02,param_03,0,0,0,1,9000000,1);
}

//Function Number: 17
setup_traffic_path_with_options(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isdefined(level.traffic_cars))
	{
		return;
	}

	if(!setup_traffic_spawner(param_01))
	{
		return;
	}

	if(!isdefined(level.traffic_lanes))
	{
		level.traffic_lanes = [];
	}

	if(!isdefined(level.traffic_crashed_vehicles))
	{
		level.traffic_crashed_vehicles = [];
	}

	var_0A = 1;
	for(;;)
	{
		var_0B = param_00 + "_" + var_0A;
		var_0C = getvehiclenodearray(var_0B,"targetname");
		if(!isdefined(var_0C) || var_0C.size <= 0)
		{
			return;
		}

		level thread setup_traffic_group(var_0C,param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
		var_0A++;
	}
}

//Function Number: 18
delete_traffic_path(param_00)
{
	var_01 = 1;
	for(;;)
	{
		var_02 = param_00 + "_" + var_01;
		var_03 = getvehiclenodearray(var_02,"targetname");
		if(!isdefined(var_03) || var_03.size <= 0)
		{
			return;
		}

		level delete_traffic_group(var_03);
		var_01++;
	}
}

//Function Number: 19
setup_traffic_spawner(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	if(!isdefined(var_01) || var_01.size <= 0)
	{
		return 0;
	}

	if(!isdefined(level.traffic_spawners))
	{
		level.traffic_spawners = [];
	}

	if(!isdefined(level.traffic_spawners[param_00]))
	{
		level.traffic_spawners[param_00] = [];
		var_02 = 0;
		for(var_03 = 0;var_03 < var_01.size;var_03++)
		{
			level.traffic_spawners[param_00][var_03]["spawner"] = var_01[var_03];
			level.traffic_spawners[param_00][var_03]["spawner"].traffic_locked = 0;
			level.traffic_spawners[param_00][var_03]["model"] = get_traffic_model(var_01[var_03].model);
			level.traffic_spawners[param_00][var_03]["weight"] = get_traffic_weight(var_01[var_03].vehicletype);
			var_02 = var_02 + level.traffic_spawners[param_00][var_03]["weight"];
		}

		if(var_02 > 0)
		{
			for(var_03 = 0;var_03 < level.traffic_spawners[param_00].size;var_03++)
			{
				level.traffic_spawners[param_00][var_03]["normalizedweight"] = level.traffic_spawners[param_00][var_03]["weight"] / var_02;
			}
		}
	}

	return 1;
}

//Function Number: 20
get_traffic_model(param_00)
{
	if(param_00 == "vehicle_suburban")
	{
		return "vehicle_suburban_bridge";
	}

	if(param_00 == "vehicle_80s_hatch1_silv_destructible_mp")
	{
		return "vehicle_80s_hatch2_silv";
	}

	if(param_00 == "vehicle_policecar_lapd_destructible")
	{
		return "vehicle_policecar_lapd";
	}

	if(param_00 == "vehicle_80s_wagon1_silv_destructible_mp")
	{
		return "vehicle_80s_wagon1_silv";
	}

	if(param_00 == "vehicle_80s_wagon1_red_destructible_mp")
	{
		return "vehicle_80s_wagon1_red";
	}

	if(param_00 == "vehicle_uk_utility_truck_destructible")
	{
		return "vehicle_uk_utility_truck_static";
	}

	if(param_00 == "vehicle_jeep_rubicon")
	{
		return "vehicle_jeep_destructible";
	}

	return param_00;
}

//Function Number: 21
get_traffic_weight(param_00)
{
	if(param_00 == "civ_domestic_truck_physics")
	{
		return 1;
	}

	if(param_00 == "civ_domestic_sportscar_01_physics")
	{
		return 0.3;
	}

	if(param_00 == "civ_pickup_truck_01_physics")
	{
		return 1;
	}

	if(param_00 == "civ_workvan_physics")
	{
		return 0.3;
	}

	if(param_00 == "civ_domestic_sedan_taxi_01_physics")
	{
		return 0.5;
	}

	if(param_00 == "civ_domestic_sedan_taxi_02_physics")
	{
		return 0.5;
	}

	if(param_00 == "civ_domestic_sedan_01_physics")
	{
		return 1;
	}

	return 1;
}

//Function Number: 22
setup_traffic_group(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	setup_lane_information(param_00);
	foreach(var_0C in param_00)
	{
		var_0C.traffic_force_script_models_only = param_07;
		var_0C.traffic_spawn_mode = param_05;
		if(isdefined(param_04))
		{
			var_0C.fill_pos_ent = param_04;
		}

		if(isdefined(param_09))
		{
			var_0C.despawn_dist_sq = param_09;
		}

		if(isdefined(param_0A))
		{
			var_0C.despawn_if_not_in_view = param_0A;
		}

		if(isdefined(param_08))
		{
			var_0C.vehicle_collision_enabled = param_08;
		}
		else
		{
			var_0C.vehicle_collision_enabled = 1;
		}

		level.traffic_lanes[level.traffic_lanes.size] = var_0C;
	}

	if(isdefined(level.traffic_tune_no_spawn) && level.traffic_tune_no_spawn == param_01)
	{
		return;
	}

	foreach(var_0C in param_00)
	{
		if(isdefined(var_0C.nospawn) && var_0C.nospawn)
		{
			continue;
		}

		if(isdefined(param_03) && param_03)
		{
			var_0C thread start_traffic_lane(param_02,param_04,param_06);
		}
	}
}

//Function Number: 23
delete_traffic_group(param_00)
{
	if(!isdefined(level.traffic_lanes))
	{
		return;
	}

	var_01 = level.traffic_lanes;
	var_02 = level.traffic_lanes.size;
	level.traffic_lanes = [];
	level.additional_delete_cars = [];
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = var_01[var_03];
		if(!isdefined(var_04))
		{
			continue;
		}

		if(!isdefined(var_04.traffic_tail))
		{
			continue;
		}

		foreach(var_06 in param_00)
		{
			if(var_06 == var_04)
			{
				var_07 = var_04.traffic_tail;
				delete_lane_cars(var_04.traffic_tail);
				var_04.traffic_tail.traffic_leader = undefined;
				var_04.traffic_tail = undefined;
				var_04.traffic_head_veh = undefined;
				var_04 notify("stop_traffic_lane");
				var_01[var_03] = undefined;
			}
		}
	}

	while(level.additional_delete_cars.size > 0)
	{
		var_09 = level.additional_delete_cars;
		level.additional_delete_cars = [];
		foreach(var_0B in var_09)
		{
			delete_lane_cars(var_0B);
		}
	}

	foreach(var_04 in var_01)
	{
		level.traffic_lanes[level.traffic_lanes.size] = var_04;
	}

	level.additional_delete_cars = undefined;
}

//Function Number: 24
delete_lane_cars(param_00)
{
	while(isdefined(param_00))
	{
		var_01 = param_00;
		if(isdefined(param_00.traffic_leader_pending))
		{
			level.additional_delete_cars[level.additional_delete_cars.size] = param_00.traffic_leader_pending;
		}

		param_00 = param_00.traffic_leader;
		var_01 notify("reached_end_node");
	}
}

//Function Number: 25
setup_lane_information(param_00)
{
	var_01 = [];
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(!isdefined(var_04.lane_processed))
		{
			var_04.lane_processed = 1;
			var_02[var_02.size] = var_04;
		}

		var_04.traffic_tail = spawnstruct();
		var_04.traffic_head_veh = undefined;
	}

	if(var_02.size <= 0)
	{
		return;
	}

	for(;;)
	{
		find_node_neighbors(var_02);
		var_06 = undefined;
		var_07 = 0;
		for(var_08 = 0;var_08 < var_02.size;var_08++)
		{
			var_02[var_08].lane_start_node = param_00[var_08];
			var_09 = var_02[var_08];
			if(var_07 > 50)
			{
				return;
			}

			if(isdefined(var_02[var_08].target) && isdefined(var_02[var_08].targetname))
			{
			}

			if(isdefined(var_02[var_08].script_noteworthy))
			{
				if(var_02[var_08].script_noteworthy == "traffic_lane_merge")
				{
					var_0A = undefined;
					if(isdefined(var_02[var_08].target))
					{
						var_0A = getvehiclenodearray(var_02[var_08].target,"target");
					}

					if(isdefined(var_0A) && var_0A.size == 1)
					{
					}
					else
					{
						var_02 = maps\_utility::array_remove_index(var_02,var_08);
						param_00 = maps\_utility::array_remove_index(param_00,var_08);
						if(var_02.size <= 0)
						{
							return;
						}
						else
						{
							var_08--;
							continue;
						}
					}
				}
				else if(var_02[var_08].script_noteworthy == "traffic_lane_split" || var_02[var_08].script_noteworthy == "traffic_lane_exit")
				{
					if(isdefined(var_02[var_08].script_linkto))
					{
						var_0B = getvehiclenodearray(var_02[var_08].script_linkto,"target");
						if(isdefined(var_0B) && var_0B.size == 1)
						{
							var_06 = var_02[var_08].script_linkto;
						}
						else if(var_02[var_08].script_noteworthy == "traffic_lane_split")
						{
							var_0B = getvehiclenodearray(var_02[var_08].script_linkto,"script_linkname");
							foreach(var_0D in var_0B)
							{
								if(!isdefined(var_0D.lane_start_node))
								{
									var_01[var_01.size] = var_0D;
								}
							}
						}
					}
					else
					{
					}
				}
			}

			if(!isdefined(var_02[var_08].target))
			{
				var_07++;
				continue;
			}

			var_0F = getvehiclenode(var_02[var_08].target,"targetname");
			if(!isdefined(var_0F))
			{
				var_07++;
				continue;
			}

			var_02[var_08] = var_0F;
			var_10 = var_02[var_08];
		}

		if(isdefined(var_06))
		{
			var_11 = getvehiclenode(var_06,"script_linkname");
			if(isdefined(var_11))
			{
				var_11.lane_processed = 1;
				param_00[param_00.size] = var_11;
				var_02[var_02.size] = var_11;
			}

			var_06 = undefined;
		}

		if(var_07 > 0)
		{
			break;
		}
	}

	foreach(var_0D in var_01)
	{
		var_16 = [];
		var_16[0] = var_0D;
		setup_lane_information(var_16);
	}
}

//Function Number: 26
find_node_neighbors(param_00)
{
	if(param_00.size <= 1)
	{
		return;
	}

	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		if(!isdefined(param_00[var_01].target))
		{
			continue;
		}

		var_02 = getvehiclenode(param_00[var_01].target,"targetname");
		if(!isdefined(var_02))
		{
			continue;
		}

		var_03 = vectornormalize(var_02.origin - param_00[var_01].origin);
		var_04 = get_closest_neighbors(param_00[var_01],param_00,var_03);
		if(isdefined(var_04["left"]))
		{
			param_00[var_01].neighbor_left = var_04["left"];
		}

		if(isdefined(var_04["right"]))
		{
			param_00[var_01].neighbor_right = var_04["right"];
		}
	}
}

//Function Number: 27
get_closest_neighbors(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = 999999999;
	var_05 = undefined;
	var_06 = 999999999;
	for(var_07 = 0;var_07 < param_01.size;var_07++)
	{
		if(param_00 == param_01[var_07])
		{
			continue;
		}

		var_08 = vectornormalize(param_01[var_07].origin - param_00.origin);
		var_09 = vectorcross(var_08,param_02);
		if(var_09[2] > 0)
		{
			if(!isdefined(var_05))
			{
				var_05 = param_01[var_07];
				var_06 = distance2dsquared(param_00.origin,param_01[var_07].origin);
			}
			else
			{
				var_0A = distance2dsquared(param_00.origin,param_01[var_07].origin);
				if(var_0A < var_06)
				{
					var_05 = param_01[var_07];
					var_06 = var_0A;
				}
			}

			continue;
		}

		if(!isdefined(var_03))
		{
			var_03 = param_01[var_07];
			var_04 = distance2dsquared(param_00.origin,param_01[var_07].origin);
			continue;
		}

		var_0A = distance2dsquared(param_00.origin,param_01[var_07].origin);
		if(var_0A < var_04)
		{
			var_03 = param_01[var_07];
			var_04 = var_0A;
		}
	}

	var_0B["left"] = var_03;
	var_0B["right"] = var_05;
	return var_0B;
}

//Function Number: 28
spawn_single_vehicle_for_lane(param_00,param_01)
{
	var_02 = getvehiclenode(param_00,"targetname");
	if(!isdefined(var_02))
	{
		return undefined;
	}

	var_03 = get_max_cars();
	if(var_03 < 0 || level.traffic_cars < var_03)
	{
		var_04 = spawn_new_traffic_entity_at_node(var_02,param_01);
		if(isdefined(var_04))
		{
			var_04 insert_to_lane(var_02,undefined,"SPAWNING");
			return var_04;
		}

		if(level.currentgen)
		{
			wait(0.1);
		}
	}

	return undefined;
}

//Function Number: 29
get_spawn_chance(param_00)
{
	var_01 = level.traffic_tune_start_spawn_rand_chance;
	if(isdefined(param_00.lane_start_node) && isdefined(param_00.lane_start_node.spawn_chance_override))
	{
		var_01 = param_00.lane_start_node.spawn_chance_override;
	}

	return var_01;
}

//Function Number: 30
start_traffic_lane(param_00,param_01,param_02)
{
	level endon("stop_traffic");
	self endon("stop_traffic_lane");
	var_03 = spawn_route_full_with_traffic_at(self,param_00,param_01,param_02);
	var_04 = var_03[0];
	var_05 = var_03[1];
	if(isdefined(var_04))
	{
		self.traffic_tail.traffic_leader = var_04;
		self.traffic_head_veh = var_05;
		var_04.traffic_follower = self.traffic_tail;
	}

	var_06 = get_max_cars();
	var_07 = getvehiclenode(self.target,"targetname");
	if(self.traffic_spawn_mode == 10 || self.traffic_spawn_mode == 20)
	{
		var_08 = 1;
		var_09 = 0;
		var_0A = 0;
		for(;;)
		{
			if(isdefined(self.nospawn) && self.nospawn)
			{
				wait 0.05;
				continue;
			}

			for(var_0B = 0;var_0B < 2;var_0B++)
			{
				if(randomint(100) < get_spawn_chance(self) * 0.5)
				{
					var_0C = undefined;
					var_0D = get_head_or_tail_variables(var_0B,var_0A,var_09);
					var_08 = var_0D[0];
					var_0E = var_0D[1];
					var_0F = var_0D[2];
					if(isdefined(param_01))
					{
						var_0C = get_node_at_radius_distance(var_07,param_01.origin,get_despawn_dist_sq(self),!var_08);
					}
					else
					{
						var_0C = getvehiclenode(self.target,"targetname");
					}

					if(isdefined(var_0C))
					{
						var_10 = var_0C.targetname;
						var_04 = undefined;
						var_05 = undefined;
						var_04 = self.traffic_tail.traffic_leader;
						if(isdefined(self.traffic_head_veh))
						{
							var_05 = self.traffic_head_veh;
						}

						var_11 = var_0E * level.traffic_tune_single_spawn_dist_between_cars;
						if(!isdefined(var_04) || !isdefined(var_05) || !var_08 && distance2d(var_04.vehicle.origin,var_0C.origin) > level.traffic_tune_single_spawn_dist_between_cars + var_11 && vehicle_in_front_of_node(var_04.vehicle,var_0C) || var_08 && distance2d(var_05.vehicle.origin,var_0C.origin) > level.traffic_tune_single_spawn_dist_between_cars + var_11 && !vehicle_in_front_of_node(var_05.vehicle,var_0C))
						{
							var_12 = spawn_single_vehicle_for_lane(var_10,param_00);
							if(isdefined(var_12))
							{
								var_0E = 0;
							}
							else
							{
								var_0E++;
							}

							if(var_0B == 0)
							{
								var_0A = var_0E;
							}

							if(var_0B == 1)
							{
								var_09 = var_0E;
							}
						}
						else
						{
							wait(0.5);
						}
					}

					if(self.traffic_spawn_mode != 20)
					{
						break;
					}

					continue;
				}
			}

			var_14 = randomint(100);
			wait(var_14 * 0.008);
			wait 0.05;
		}

		return;
	}

	if(self.traffic_spawn_mode == 0)
	{
		for(;;)
		{
			if(var_06 < 0 || level.traffic_cars < var_06)
			{
				fill_new_traffic_entity_near_player(self,param_00);
			}

			wait(randomfloatrange(3,6.5));
		}
	}
}

//Function Number: 31
get_head_or_tail_variables(param_00,param_01,param_02)
{
	if(param_00 == 0)
	{
		var_03 = 0;
		var_04 = param_01;
		var_05 = "tail";
		return [var_03,var_04,var_05];
	}

	var_03 = 1;
	var_04 = var_04;
	var_05 = "head";
	return [var_03,var_04,var_05];
}

//Function Number: 32
vehicle_in_front_of_node(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return 1;
	}

	var_02 = param_00.origin - param_01.origin;
	var_03 = getvehiclenode(param_01.target,"targetname");
	if(!isdefined(var_03))
	{
		return 1;
	}

	var_04 = var_03.origin - param_01.origin;
	var_02 = vectornormalize(var_02);
	var_04 = vectornormalize(var_04);
	var_05 = vectordot(var_02,var_04);
	return var_05 > 0;
}

//Function Number: 33
get_pos_at_given_distance_on_lane(param_00,param_01,param_02,param_03)
{
	var_04 = param_00;
	var_05 = param_02;
	var_06 = undefined;
	var_07 = undefined;
	var_08 = param_01;
	var_09 = 0;
	var_0A = 0;
	if(!isdefined(param_01.target))
	{
		var_08 = undefined;
	}

	if(param_03)
	{
		var_0B = distance(var_04,var_08.origin);
		var_0C = randomfloatrange(1,var_0B * 0.5 + 2);
		var_05 = var_05 + randomfloatrange(var_05,var_05 + var_0C);
	}

	while(isdefined(var_08) && isdefined(var_08.target))
	{
		var_0B = distance(var_04,var_08.origin);
		var_0D = var_08.origin - var_04;
		var_0E = vectornormalize(var_0D);
		if(var_0B > var_05)
		{
			var_06 = var_04 + var_0E * var_05;
			var_07 = vectortoangles(var_0E);
			var_0A = var_0A + var_05;
			break;
		}
		else
		{
			var_05 = var_05 - var_0B;
			var_04 = var_08.origin;
			var_0A = var_0A + var_0B;
		}

		var_08 = getvehiclenode(var_08.target,"targetname");
		var_09++;
	}

	return [var_06,var_07,param_01,var_08,var_0A];
}

//Function Number: 34
spawn_route_full_with_traffic_at(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_00.target))
	{
		return [undefined,undefined];
	}

	var_04 = undefined;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = get_max_cars();
	var_08 = undefined;
	var_09 = undefined;
	var_0A = param_00.origin;
	var_0B = 0;
	var_0C = get_despawn_dist_sq(param_00.lane_start_node);
	var_0D = param_00;
	var_0E = -1;
	while(isdefined(param_00) && isdefined(param_00.target))
	{
		var_0E++;
		param_00 = var_0D;
		if(var_07 >= 0 && level.traffic_cars >= var_07)
		{
			break;
		}

		if(var_0E == 0)
		{
			var_0B = randomfloat(level.traffic_tune_fill_spawn_dist_between_cars * 0.5);
		}
		else
		{
			var_0B = level.traffic_tune_fill_spawn_dist_between_cars;
		}

		if(param_03)
		{
			var_0F = get_pos_at_given_distance_on_lane(var_0A,param_00,var_0B,0);
			var_08 = var_0F[0];
			var_09 = var_0F[1];
			param_00 = var_0F[2];
			var_0D = var_0F[3];
			var_10 = var_0F[4];
		}
		else
		{
			var_11 = get_pos_at_given_distance_on_lane(var_0A,param_00,var_0B,1);
			var_08 = var_11[0];
			var_09 = var_11[1];
			param_00 = var_11[2];
			var_0D = var_11[3];
			var_10 = var_11[4];
		}

		if(!isdefined(var_08))
		{
			break;
		}

		var_0A = var_08;
		if(isdefined(param_00.script_noteworthy) && param_00.script_noteworthy == "traffic_lane_merge")
		{
			if(param_00.script_noteworthy == "traffic_lane_merge")
			{
				return [var_04,var_05];
			}
		}

		if((isdefined(param_00.lane_start_node) && isdefined(param_00.lane_start_node.nospawn) && param_00.lane_start_node.nospawn) || isdefined(param_02) && distance2dsquared(var_08,param_02.origin) > var_0C || isdefined(param_00.script_noteworthy) && param_00.script_noteworthy == "traffic_lane_split" || param_00.script_noteworthy == "traffic_lane_exit")
		{
			continue;
		}

		if(randomint(100) < get_spawn_chance(param_00))
		{
			var_06 = spawn_new_traffic_entity_at_node_override(var_08,var_09,param_00,param_01);
			if(isdefined(var_06))
			{
				if(!isdefined(var_04))
				{
					var_04 = var_06;
				}

				if(isdefined(var_05))
				{
					var_05.traffic_leader = var_06;
					var_06.traffic_follower = var_05;
				}

				var_05 = var_06;
				continue;
			}

			continue;
		}
	}

	return [var_04,var_05];
}

//Function Number: 35
fill_new_traffic_entity_near_player(param_00,param_01)
{
	var_02 = level.player.origin;
	var_03 = anglestoforward(level.player getplayerangles());
	if(!isdefined(param_00.target))
	{
		return;
	}

	var_04 = randomint(level.traffic_spawners[param_01].size);
	var_05 = param_00;
	var_06 = get_max_cars();
	for(;;)
	{
		if(var_06 >= 0 && level.traffic_cars >= var_06)
		{
			return;
		}

		if(!isdefined(var_05.target))
		{
			return;
		}

		if(isdefined(var_05.script_noteworthy) && var_05.script_noteworthy == "traffic_lane_merge")
		{
			return;
		}

		var_07 = getvehiclenode(var_05.target,"targetname");
		if(!isdefined(var_07))
		{
			return;
		}

		if(randomint(100) < get_spawn_chance(param_00))
		{
			var_08 = vectornormalize(var_07.origin - var_05.origin);
			var_09 = vectordot(var_08,var_03);
			var_0A = var_05.origin - var_02;
			var_0B = length2dsquared(var_0A);
			var_0C = vectornormalize(var_0A);
			var_0D = vectordot(var_0C,var_03);
			var_0E = var_09 > 0;
			var_0F = var_0D > 0;
			if(!var_0E && !var_0F)
			{
				return;
			}

			if(!var_0E && var_0B < 225000000)
			{
				return;
			}

			if(var_0E && var_0B > 400000000)
			{
				return;
			}

			var_10 = 0;
			if(var_0F && var_0B > 225000000 && var_0B < 400000000)
			{
				var_10 = 1;
			}

			if(var_10)
			{
				var_11 = undefined;
				var_12 = find_closest_car(var_05,var_05.origin);
				if(isdefined(var_12))
				{
					var_11 = distance2dsquared(var_12.vehicle.origin,var_05.origin);
				}

				if(!isdefined(var_11) || var_11 > level.traffic_tune_single_spawn_dist_between_cars_sq)
				{
					var_13 = spawn_new_traffic_entity_at_node(var_05,param_01);
					if(isdefined(var_13))
					{
						var_13 insert_to_lane(var_05,var_12,"FILL");
					}
				}
			}
		}

		var_05 = var_07;
	}
}

//Function Number: 36
spawn_new_traffic_entity_at_node(param_00,param_01)
{
	return spawn_new_traffic_entity_at_node_override(param_00.origin,param_00.angles,param_00,param_01);
}

//Function Number: 37
spawn_new_traffic_entity_at_node_override(param_00,param_01,param_02,param_03)
{
	if(check_if_intersecting_any_script_car(param_00,param_02.lane_start_node))
	{
		return undefined;
	}

	if(isdefined(param_02.nospawn))
	{
		return undefined;
	}

	var_04 = 0;
	var_05 = randomfloatrange(0,1);
	for(var_06 = 0;var_06 < level.traffic_spawners[param_03].size;var_06++)
	{
		if(var_05 < level.traffic_spawners[param_03][var_06]["normalizedweight"])
		{
			var_04 = var_06;
			break;
		}

		var_05 = var_05 - level.traffic_spawners[param_03][var_06]["normalizedweight"];
	}

	var_07 = spawn("script_origin",(0,0,0));
	var_07.is_traffic_ent = 1;
	var_07.targetname = "traffic_vehicle";
	var_07.traffic_spawner = level.traffic_spawners[param_03][var_04];
	var_07.traffic_speed_status = 0;
	var_07.traffic_leader = undefined;
	var_07.traffic_follower = undefined;
	var_07.spawn_time = gettime();
	if(isdefined(param_02.speed))
	{
		var_07.traffic_speed = param_02.speed;
	}

	var_07.currentnode = param_02;
	var_07.birthnode = param_02.lane_start_node;
	if(!param_02.lane_start_node.traffic_force_script_models_only && should_be_vehicle(param_02.origin))
	{
		var_08 = var_07 spawn_new_traffic_vehicle(param_00,param_01,param_02,level.traffic_spawners[param_03][var_04]);
	}
	else
	{
		var_08 = var_08 spawn_new_traffic_model(param_01 - (0,0,16),param_02,param_03,level.traffic_spawners[var_04][var_05]);
	}

	if(isdefined(var_08))
	{
		var_07.vehicle = var_08;
		if(isdefined(param_02.lane_start_node.vehicle_easy_crash_die))
		{
			if(var_08.code_classname == "script_vehicle")
			{
				var_08.health = 5;
			}
			else
			{
				var_08.currenthealth = 5;
			}
		}

		if(!param_02.lane_start_node.traffic_force_script_models_only)
		{
			var_07 thread traffic_type_swap();
		}

		var_07 thread monitor_vehicle_speed();
		var_07 thread car_behavior();
		var_07 thread clean_up_car(param_02.lane_start_node.traffic_force_script_models_only);
		return var_07;
	}

	var_07 delete();
	return undefined;
}

//Function Number: 38
spawn_new_traffic_vehicle(param_00,param_01,param_02,param_03)
{
	while(param_03["spawner"].traffic_locked == 1)
	{
		wait(0.05);
	}

	foreach(var_05 in vehicle_getarray())
	{
		if(abs(var_05.origin[2] - param_00[2]) < 50 && distance2dsquared(var_05.origin,param_00) < level.traffic_tune_extreme_near_car_dist_sq)
		{
			return undefined;
		}
	}

	param_03["spawner"].traffic_locked = 1;
	var_05 = param_03["spawner"] maps\_utility::spawn_vehicle();
	thread unlock_traffic_spawner(param_03);
	if(isdefined(var_05))
	{
		var_05.parent_ent = self;
		var_07 = undefined;
		if(!isdefined(self.currentnode.lane_start_node.vehicle_nodrivers) || !self.currentnode.lane_start_node.vehicle_nodrivers)
		{
			var_08 = getent("civ_vehicle_driver_spawner","targetname");
			if(isdefined(var_08))
			{
				var_07 = var_08 maps\_utility::spawn_ai(1);
				var_05 maps\_utility::guy_enter_vehicle(var_07);
				var_07 setcandamage(0);
			}
		}

		var_05 thread clean_up_on_parent_death(self);
		var_05 vehicle_setspeedimmediate(model_speed_to_mph(self.traffic_speed),15,15);
		if(isdefined(self.currentnode.lane_start_node.vehicle_notsolid) && self.currentnode.lane_start_node.vehicle_notsolid)
		{
			if(isdefined(var_07))
			{
				var_07 notsolid();
			}

			var_05 vehicle_removebrushmodelcollision();
			var_05 vehphys_disablecrashing();
		}

		if(isdefined(self.currentnode.lane_start_node.no_crash_handling) && !self.currentnode.lane_start_node.no_crash_handling)
		{
			var_05 thread handle_traffic_collisions();
		}

		if(islagostraversesetting(var_05))
		{
			if(isdefined(var_07))
			{
				var_07 notsolid();
			}
		}

		var_05 thread setup_vehicle_for_damage();
		thread sync_entity_damage(var_05);
		var_05 vehicle_teleport(param_00,param_01,1);
		var_05 thread traffic_drive_vehicle(param_02);
		var_05 thread handle_brake_lights();
		var_05 thread detect_being_pushed(::force_vehicle_delete);
		var_05 thread detect_dropping();
		var_05 soundscripts\_snd::snd_message("spawn_new_traffic_vehicle");
	}

	return var_05;
}

//Function Number: 39
unlock_traffic_spawner(param_00)
{
	wait(0.05);
	param_00["spawner"].traffic_locked = 0;
}

//Function Number: 40
spawn_new_traffic_model(param_00,param_01,param_02,param_03)
{
	if(level.currentgen && level.traffic_cars_scriptmodel_only_count > 20)
	{
		return undefined;
	}

	var_04 = spawn("script_model",param_00);
	var_04.angles = param_01;
	var_04 setmodel(param_03["model"]);
	if(param_02.lane_start_node.traffic_force_script_models_only && isdefined(level.vehicle_deathmodel) && isdefined(level.vehicle_deathmodel[var_04.model]) && param_02.lane_start_node.vehicle_collision_enabled)
	{
		var_04 vehicle_assignbrushmodelcollision();
		var_04 setcandamage(1);
		var_04 thread monitor_script_model_damage();
	}
	else
	{
		var_04 vehicle_removebrushmodelcollision();
		var_04 notsolid();
		var_04 removefrommovingplatformsystem(1);
	}

	var_04 thread clean_up_on_parent_death(self);
	sync_entity_damage(var_04);
	var_04.parent_ent = self;
	var_04 thread traffic_drive_vehicle(param_02);
	var_04 thread vehicle_treads_script_model(param_03["spawner"].classname);
	return var_04;
}

//Function Number: 41
vehicle_treads_script_model(param_00)
{
	level endon("stop_traffic");
	self endon("reached_end_node");
	self endon("death");
	var_01 = maps\_vehicle_code::get_vehicle_effect(param_00,"default_script_model");
	if(isdefined(var_01))
	{
		playfxontag(var_01,self,"tag_origin");
	}
}

//Function Number: 42
clear_cars_around_pos(param_00,param_01,param_02)
{
	var_03 = param_01 * param_01;
	var_04 = getentarray("traffic_vehicle","targetname");
	foreach(var_06 in var_04)
	{
		if(!isdefined(var_06))
		{
			continue;
		}

		if(isdefined(param_02))
		{
			if(param_02 && !isdefined(var_06.vehicle))
			{
				continue;
			}
		}

		var_07 = distance2dsquared(var_06.vehicle.origin,param_00);
		if(var_07 < var_03)
		{
			var_06 notify("reached_end_node");
		}
	}
}

//Function Number: 43
add_script_car(param_00,param_01)
{
	var_02 = undefined;
	for(var_03 = 0;var_03 < level.script_cars.size;var_03++)
	{
		if(!isdefined(level.script_cars[var_03]))
		{
			var_02 = var_03;
			break;
		}
	}

	if(!isdefined(var_02))
	{
		var_02 = level.script_cars.size;
	}

	level.script_cars[var_02] = param_00;
	if(!isdefined(param_01) || isdefined(param_01) && param_01)
	{
		param_00 thread handle_traffic_collisions();
	}

	param_00 thread mark_adjacent_script_cars();
	level notify("new_script_car",param_00);
}

//Function Number: 44
mark_adjacent_script_cars()
{
	self endon("death");
	var_00 = 160000;
	var_01 = 130;
	var_02 = 0.5;
	for(;;)
	{
		if(vehicle_getspeed_a() > 50)
		{
			var_03 = 0;
			self.script_car_on_left = undefined;
			self.script_car_on_right = undefined;
			foreach(var_05 in level.script_cars)
			{
				if(!isdefined(var_05) || self == var_05)
				{
					continue;
				}

				var_06 = [];
				if(isdefined(var_05 gettagorigin("tag_wheel_back_left")) && isdefined(var_05 gettagorigin("tag_wheel_front_right")))
				{
					var_06[0] = var_05 get_adjusted_script_car_origin(0);
					var_06[1] = var_05 get_adjusted_script_car_origin(1);
				}
				else
				{
					var_06[0] = var_05.origin;
				}

				foreach(var_08 in var_06)
				{
					if(distance2dsquared(self.origin,var_08) < var_00)
					{
						var_03 = 1;
						var_09 = self.origin + (0,0,25);
						var_0A = var_05 get_adjusted_script_car_origin(0) - var_09;
						var_0B = anglestoright(self.angles);
						var_0C = vectordot(var_0B,var_0A);
						if(var_0C > 0 && var_0C > var_01 && var_0C < var_01 * 2)
						{
							self.script_car_on_right = var_05;
						}

						if(var_0C < 0 && var_0C < -1 * var_01 && var_0C > var_01 * -2)
						{
							self.script_car_on_left = var_05;
						}
					}
				}
			}
		}

		wait(var_02);
	}
}

//Function Number: 45
remove_script_car(param_00)
{
	var_01 = [];
	foreach(var_03 in level.script_cars)
	{
		if(!isdefined(var_03) || var_03 == param_00)
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	level.script_cars = var_01;
}

//Function Number: 46
check_if_intersecting_any_script_car(param_00,param_01)
{
	if(isdefined(param_01.dont_spawn_over_obstacles) && !param_01.dont_spawn_over_obstacles)
	{
		return 0;
	}

	var_02 = 136900;
	foreach(var_04 in level.script_cars)
	{
		if(!isdefined(var_04))
		{
			continue;
		}

		var_05[0] = var_04.origin;
		if(isdefined(var_04 gettagorigin("tag_wheel_back_left")) && isdefined(var_04 gettagorigin("tag_wheel_front_right")))
		{
			var_05[0] = var_04 get_adjusted_script_car_origin(0);
			var_05[1] = var_04 get_adjusted_script_car_origin(1);
		}

		foreach(var_07 in var_05)
		{
			if(distance2dsquared(var_07,param_00) < var_02)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 47
is_traffic_ent(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!isdefined(param_00.is_traffic_ent) || !param_00.is_traffic_ent)
	{
		return 0;
	}

	return 1;
}

//Function Number: 48
traffic_drive_vehicle(param_00)
{
	var_01 = 0;
	level endon("stop_traffic");
	self endon("death");
	self notify("traffic_drive_vehicle_once");
	self endon("traffic_drive_vehicle_once");
	thread traffic_handle_messages();
	if(self.classname == "script_model")
	{
		var_02 = param_00;
		var_03 = anglestoforward(self.angles);
		var_04 = var_02.origin - self.origin;
		var_04 = vectornormalize(var_04);
		var_05 = vectordot(var_03,var_04);
		var_06 = distance2dsquared(param_00.origin,self.origin);
		if(var_06 < level.traffic_tune_extreme_near_car_dist_sq || var_05 < 0)
		{
			if(isdefined(param_00.target))
			{
				var_02 = getvehiclenode(param_00.target,"targetname");
			}
			else
			{
				var_01 = 1;
			}
		}

		for(;;)
		{
			if(isdefined(var_02))
			{
				script_vehicle_move_to_node(var_02);
				if(isdefined(var_02.script_noteworthy))
				{
					self notify("noteworthy",var_02.script_noteworthy);
				}

				param_00 = var_02;
				if(!isdefined(param_00.target))
				{
					var_01 = 1;
					break;
				}

				var_02 = getvehiclenode(var_02.target,"targetname");
				if(isdefined(param_00.speed))
				{
					adjust_model_speed_to_node(param_00);
				}

				continue;
			}

			var_01 = 1;
			break;
		}
	}
	else
	{
		var_07 = getvehiclenodepreviousforstartpath(param_00);
		if(isdefined(var_07))
		{
			param_00 = var_07;
		}

		thread maps\_vehicle_code::_vehicle_paths(param_00);
		self startpath(param_00);
		self waittill("reached_end_node");
		self.parent_ent notify("reached_end_node");
	}

	if(var_01)
	{
		if(gettime() == self.parent_ent.spawn_time)
		{
			wait 0.05;
		}

		self.parent_ent notify("reached_end_node");
	}
}

//Function Number: 49
getvehiclenodepreviousforstartpath(param_00)
{
	var_01 = getvehiclenodearray(param_00.targetname,"target");
	if(!isdefined(var_01))
	{
		return undefined;
	}

	if(var_01.size == 1)
	{
		return var_01[0];
	}

	var_02 = undefined;
	var_03 = 0;
	foreach(var_05 in var_01)
	{
		var_06 = param_00.origin - var_05.origin;
		var_06 = (var_06[0],var_06[1],0);
		var_06 = vectornormalize(var_06);
		var_07 = anglestoforward(self.angles);
		var_07 = (var_07[0],var_07[1],0);
		var_07 = vectornormalize(var_07);
		var_08 = vectordot(var_07,var_06);
		if(var_08 > var_03)
		{
			var_03 = var_08;
			var_02 = var_05;
		}
	}

	return var_02;
}

//Function Number: 50
script_vehicle_move_to_node(param_00)
{
	self endon("death");
	for(;;)
	{
		var_01 = distance2dsquared(param_00.origin,self.origin);
		if(var_01 < level.traffic_tune_extreme_near_car_dist_sq)
		{
			if((!isdefined(self.parent_ent.traffic_speed_override) || self.parent_ent.traffic_speed_override > 0) && self.parent_ent.traffic_speed > 0)
			{
				return;
			}
		}

		path_to_node_at_current_speed(var_01,param_00);
	}
}

//Function Number: 51
set_zero_speed(param_00)
{
	var_01 = param_00.origin - (0,0,16) - self.origin;
	var_02 = undefined;
	if(length2dsquared(var_01) < 400)
	{
		var_02 = param_00.origin;
	}
	else
	{
		var_01 = vectornormalize(var_01);
		var_02 = self.origin + var_01 * 20;
	}

	var_02 = self.origin;
	self moveto(var_02,0.15,0,0.15);
	self rotateto(self.angles,0.1,0,0.1);
}

//Function Number: 52
path_to_node_at_current_speed(param_00,param_01)
{
	self endon("death");
	self endon("traffic_speed_changed");
	if(self.parent_ent.traffic_speed <= 0)
	{
		set_zero_speed(param_01);
		self waittill("forever");
	}

	var_05 = sqrt(param_00) / self.parent_ent.traffic_speed;
	var_06 = var_05 * 2;
	var_07 = maps\_utility::round_float(var_06,1,0);
	var_08 = var_07 * 0.5;
	self.parent_ent.currentnode = param_01;
	self moveto(param_01.origin - (0,0,27),var_08 + 0.05,0,0);
	self rotateto(param_01.angles,var_05,0,0);
	wait(var_08);
}

//Function Number: 53
traffic_handle_messages()
{
	level endon("stop_traffic");
	self endon("death");
	self endon("reached_end_node");
	self endon("vehicle_crash");
	self notify("traffic_handle_msg_once");
	self endon("traffic_handle_msg_once");
	for(;;)
	{
		self waittill("noteworthy",var_00);
		if(var_00 == "traffic_lane_merge")
		{
			self.parent_ent merge_lane();
			continue;
		}

		if(var_00 == "traffic_lane_split" || var_00 == "traffic_lane_exit")
		{
			self.parent_ent split_lane();
		}
	}
}

//Function Number: 54
traffic_type_swap()
{
	level endon("stop_traffic");
	self endon("reached_end_node");
	self endon("death");
	self endon("vehicle_crash");
	var_00 = 0.05;
	if(level.currentgen)
	{
		var_00 = 0.2;
	}

	if(!isdefined(self))
	{
		return;
	}

	wait(0.1);
	for(;;)
	{
		if(self.vehicle.classname == "script_model")
		{
			if(should_be_vehicle(self.vehicle.origin,self.vehicle.classname))
			{
				if(self.traffic_spawner["spawner"].traffic_locked == 0)
				{
					var_01 = spawn_new_traffic_vehicle(self.vehicle.origin,self.vehicle.angles,self.currentnode,self.traffic_spawner);
					if(isdefined(var_01))
					{
						self.vehicle delete();
						self.vehicle = var_01;
						self.vehicle.parent_ent = self;
						var_01 vehicle_setspeedimmediate(model_speed_to_mph(self.traffic_speed),15,15);
						self notify("swap_to_real_vehicle");
					}
					else
					{
						self notify("reached_end_node");
					}
				}
			}
		}
		else if(!should_be_vehicle(self.vehicle.origin,self.vehicle.classname))
		{
			var_01 = spawn_new_traffic_model(self.vehicle.origin,self.vehicle.angles,self.vehicle.currentnode,self.traffic_spawner);
			if(isdefined(var_01))
			{
				self.vehicle notify("newpath");
				self.vehicle notify("stop_dodge");
				if(isdefined(self.vehicle.deathfx_ent))
				{
					self.vehicle.deathfx_ent delete();
				}

				self.vehicle delete();
				self.vehicle = var_01;
				self.vehicle.parent_ent = self;
			}
		}

		wait(var_00);
	}
}

//Function Number: 55
restore_vehicle_speed()
{
	if(isdefined(self.traffic_old_speed))
	{
		self.traffic_speed = self.traffic_old_speed;
		self.vehicle notify("traffic_speed_changed");
	}

	self.traffic_old_speed = undefined;
}

//Function Number: 56
scale_vehicle_speed(param_00)
{
	if(isdefined(self.traffic_old_speed))
	{
		if(self.traffic_speed == self.traffic_old_speed * param_00)
		{
			return;
		}
	}

	restore_vehicle_speed();
	self.traffic_old_speed = self.traffic_speed;
	self.traffic_speed = self.traffic_speed * param_00;
	if(self.vehicle.classname != "script_model")
	{
		self.vehicle vehicle_setspeed(model_speed_to_mph(self.traffic_speed),15,15);
		return;
	}

	self.vehicle notify("traffic_speed_changed");
}

//Function Number: 57
set_vehicle_speed(param_00)
{
	if(!isdefined(self.traffic_old_speed))
	{
		self.traffic_old_speed = self.traffic_speed;
	}

	if(self.traffic_speed != param_00)
	{
		self.traffic_speed = param_00;
		if(self.vehicle.classname != "script_model")
		{
			self.vehicle vehicle_setspeed(model_speed_to_mph(self.traffic_speed),15,15);
			return;
		}

		self.vehicle notify("traffic_speed_changed");
	}
}

//Function Number: 58
monitor_vehicle_speed()
{
	level endon("stop_traffic");
	self endon("reached_end_node");
	self endon("death");
	self endon("vehicle_crash");
	wait(0.05);
	for(;;)
	{
		self.traffic_speed_status_prev = self.traffic_speed_status;
		if(isdefined(self.currentnode.is_blockage) && self.currentnode.is_blockage)
		{
			self.traffic_speed_status = -10;
			scale_vehicle_speed(0);
		}
		else if(isdefined(self.traffic_speed_override))
		{
			self.traffic_speed_status = -20;
			set_vehicle_speed(mph_to_model_speed(self.traffic_speed_override));
		}
		else if(!isdefined(self.dodging))
		{
			var_00 = 2.222222E+09;
			var_01 = 0;
			if(isdefined(self.traffic_leader) && self.traffic_leader != self)
			{
				var_01 = 1;
				var_00 = distance2dsquared(self.vehicle.origin,self.traffic_leader.vehicle.origin);
			}

			if(var_00 < level.traffic_tune_extreme_near_car_dist_sq)
			{
				self notify("reached_end_node");
			}
			else if(self.traffic_speed_status != 10 && var_00 < level.traffic_tune_min_stop_dist_sq)
			{
				self.traffic_speed_status = 10;
				scale_vehicle_speed(0);
				if(self.vehicle.code_classname == "script_vehicle")
				{
					self.traffic_stop_waittime = gettime() + randomfloat(100);
				}
				else
				{
					self.traffic_stop_waittime = gettime() + randomfloat(1000);
				}
			}
			else if(self.traffic_speed_status == 10)
			{
				if(var_00 > level.traffic_tune_min_stop_dist_sq * 1.1)
				{
					if(!var_01 || gettime() > self.traffic_stop_waittime)
					{
						self.traffic_speed_status = 20;
						scale_vehicle_speed(level.traffic_tune_follow_speed_scale);
					}
				}
			}
			else if(islagostraversesetting(self.vehicle) && isdefined(self.traffic_change_lane) && self.traffic_change_lane)
			{
				if(isdefined(self.traffic_change_lane_speed))
				{
					set_vehicle_speed(self.traffic_change_lane_speed);
				}
				else
				{
					scale_vehicle_speed(1.5);
				}
			}
			else if(self.traffic_speed_status != 20 && var_00 < level.traffic_tune_min_follow_dist_sq)
			{
				self.traffic_speed_status = 20;
				scale_vehicle_speed(level.traffic_tune_follow_speed_scale);
			}
			else if(self.traffic_speed_status == 20)
			{
				if(var_00 > level.traffic_tune_min_follow_dist_sq * 1.1)
				{
					self.traffic_speed_status = 0;
				}
			}
			else if(!islagostraversesetting(self.vehicle) && isdefined(self.traffic_change_lane) && self.traffic_change_lane)
			{
				scale_vehicle_speed(1.5);
			}
			else if(self.traffic_speed_status != 30 && var_00 > level.traffic_tune_min_speedup_dist_sq && var_01)
			{
				self.traffic_speed_status = 30;
				scale_vehicle_speed(level.traffic_tune_speedup_speed_scale);
			}
			else if(self.traffic_speed_status == 30)
			{
				if(var_00 < level.traffic_tune_min_speedup_dist_sq * 0.9 || !var_01)
				{
					self.traffic_speed_status = 0;
				}
			}
			else if(isdefined(self.traffic_old_speed))
			{
				restore_vehicle_speed();
				if(self.vehicle.classname != "script_model")
				{
					self.vehicle resumespeed(15);
				}

				self.traffic_speed_status = 0;
			}
		}

		process_traffic_leader_pending_due_to_lane_split();
		wait(0.05);
	}
}

//Function Number: 59
process_traffic_leader_pending_due_to_lane_split()
{
	if(level.template_script != "lagos")
	{
		return;
	}

	var_00 = 0;
	if(isdefined(self.traffic_leader_pending_check) && self.traffic_leader_pending_check)
	{
		if(isdefined(self.traffic_leader))
		{
			var_01 = anglestoforward(self.vehicle.angles);
			var_02 = vectornormalize(var_01);
			var_03 = self.traffic_leader.vehicle.origin - self.vehicle.origin;
			var_04 = vectordot(var_03,var_02) * var_02;
			var_05 = distance2dsquared(var_03,var_04);
			if(var_05 > 8100)
			{
				self.traffic_leader = self.traffic_leader_pending;
				var_00 = 1;
			}
		}
		else
		{
			self.traffic_leader = self.traffic_leader_pending;
			var_00 = 1;
		}

		if(var_00)
		{
			self.traffic_leader_pending_check = undefined;
			self.traffic_leader_pending = undefined;
		}
	}
}

//Function Number: 60
handle_brake_lights()
{
	self endon("death");
	if(!isdefined(level.vehicle_lights_group[self.classname]) || !isdefined(level.vehicle_lights_group[self.classname]["brakelights"]))
	{
		return;
	}

	var_00 = 0.1;
	if(level.currentgen)
	{
		var_00 = 0.25;
	}

	var_01 = 0;
	var_02 = 0;
	for(;;)
	{
		var_03 = self vehicle_getspeed();
		if(var_03 < var_02 && !var_01)
		{
			thread maps\_vehicle::vehicle_lights_on("brakelights");
			var_01 = 1;
		}
		else if(var_01 && var_03 == 0 || var_03 > var_02)
		{
			thread maps\_vehicle::vehicle_lights_off("brakelights");
			var_01 = 0;
		}

		var_02 = var_03;
		wait(var_00);
	}
}

//Function Number: 61
car_behavior()
{
	thread lane_change_behavior();
	thread dodge_behavior();
	thread telefrag_behavior();
}

//Function Number: 62
lane_change_behavior()
{
	level endon("stop_traffic");
	self endon("death");
	self endon("reached_end_node");
	self endon("vehicle_crash");
	self.traffic_change_lane = 0;
	wait 0.05;
	for(;;)
	{
		thread decide_to_change_lane();
		self waittill("change_lane",var_00,var_01);
		if(isdefined(var_00))
		{
			thread turn_signal_on(var_00);
		}

		change_lane(var_00,var_01);
		self notify("changing_lane");
		wait(0.7);
		var_02 = 0;
	}
}

//Function Number: 63
turn_signal_on(param_00)
{
	self notify("one_turn_signal_on");
	self endon("one_turn_signal_on");
	self endon("death");
	self endon("reached_end_node");
	if(self.vehicle.classname == "script_model")
	{
		return;
	}

	if(!isdefined(param_00))
	{
		return;
	}

	var_01 = [];
	var_02 = [];
	if(param_00 == "left")
	{
		var_01 = ["taillight_scroll_left"];
		var_02 = ["taillight_left","mirrorlight_left","frontsignal_left"];
	}
	else if(param_00 == "right")
	{
		var_01 = ["taillight_scroll_right"];
		var_02 = ["taillight_right","mirrorlight_right","frontsignal_right"];
	}

	var_03 = common_scripts\utility::array_combine(var_01,var_02);
	self endon(param_00 + "_light_off");
	thread turn_signal_off(param_00,var_03);
	thread traffic_vehicle_lights_on(var_01);
	for(;;)
	{
		traffic_vehicle_lights_on(var_02);
		wait(0.35);
		traffic_vehicle_lights_off(var_02);
		wait(0.5);
	}
}

//Function Number: 64
turn_signal_off(param_00,param_01)
{
	wait_for_turn_signal_off();
	if(!isdefined(self))
	{
		return;
	}

	self notify(param_00 + "_light_off");
	traffic_vehicle_lights_off(param_01);
}

//Function Number: 65
wait_for_turn_signal_off()
{
	self endon("one_turn_signal_on");
	self endon("death");
	self waittill("changing_lane");
	wait(5);
}

//Function Number: 66
decide_to_change_lane()
{
	self endon("death");
	self endon("reached_end_node");
	self endon("vehicle_crash");
	wait(0.05);
	thread change_lane_too_close();
}

//Function Number: 67
get_path_segment_array(param_00,param_01,param_02)
{
	var_03 = param_00;
	var_04 = distance2d(self.vehicle.origin,var_03.origin);
	var_05 = [];
	if(isdefined(param_02) && param_02)
	{
		var_06 = getvehiclenode(param_00.targetname,"target");
		if(isdefined(var_06))
		{
			var_05[var_05.size] = var_06;
		}
	}

	var_05[var_05.size] = param_00;
	for(;;)
	{
		if(!isdefined(var_03))
		{
			break;
		}

		if(!isdefined(var_03.target))
		{
			break;
		}

		var_07 = var_03;
		var_03 = getvehiclenode(var_03.target,"targetname");
		var_04 = var_04 + distance2d(var_07.origin,var_03.origin);
		if(var_04 > param_01)
		{
			var_05[var_05.size] = var_03;
			break;
		}

		if(var_05.size > 5)
		{
			break;
		}

		var_05[var_05.size] = var_03;
	}

	return var_05;
}

//Function Number: 68
get_c_right_dist_2d(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_00 = (param_00[0],param_00[1],0);
	param_01 = (param_01[0],param_01[1],0);
	param_02 = (param_02[0],param_02[1],0);
	param_04 = (param_04[0],param_04[1],0);
	param_03 = (param_03[0],param_03[1],0);
	param_05 = (param_05[0],param_05[1],0);
	if(vectors_are_equal_2d(param_00,param_01))
	{
		var_06 = param_03 - param_00;
		var_07 = param_05 - param_00;
		var_08 = vectornormalize(var_06);
		var_09 = var_08 * vectordot(var_07,var_08);
		var_0A = param_05 - param_00 + var_09;
		var_0B = vectornormalize(var_0A);
		return vectordot(var_07,var_0B);
	}

	var_06 = var_06 - var_08;
	var_07 = var_06 - var_07;
	var_08 = vectornormalize(var_0A);
	var_09 = var_0B * vectordot(var_0A,var_0B);
	var_0A = param_03 - param_04 + var_0B;
	var_0B = vectornormalize(var_0B);
	return vectordot(var_07,var_0B);
}

//Function Number: 69
vehicle_getcurrentnode_a()
{
	var_00 = undefined;
	if(self.code_classname == "script_vehicle")
	{
		var_00 = self vehicle_getcurrentnode();
		if(isdefined(var_00) && isdefined(var_00.target))
		{
			var_00 = getvehiclenode(var_00.target,"targetname");
		}
		else if(isdefined(self.parent_ent))
		{
			var_00 = self.parent_ent.currentnode;
		}
	}
	else if(isdefined(self.parent_ent))
	{
		var_00 = self.parent_ent.currentnode;
	}
	else if(is_traffic_ent(self))
	{
		return self.vehicle vehicle_getcurrentnode_a();
	}

	if(isdefined(self._animactive) && self._animactive > 0)
	{
		var_00 = undefined;
		if(isdefined(var_00))
		{
			var_00 = get_closest_node_in_front_of_given_car(var_00,self);
		}

		if(!isdefined(var_00) && isdefined(self.vehicle_spawner.target))
		{
			var_00 = getvehiclenode(self.vehicle_spawner.target,"targetname");
		}
	}

	return var_00;
}

//Function Number: 70
change_lane_too_close()
{
	level endon("stop_traffic");
	self endon("death");
	self endon("reached_end_node");
	self endon("vehicle_crash");
	var_00 = 0.05;
	if(level.currentgen)
	{
		var_00 = 0.2;
	}

	for(;;)
	{
		foreach(var_02 in level.script_cars)
		{
			if(!isdefined(var_02))
			{
				continue;
			}

			var_03 = var_02 vehicle_getspeed();
			if(var_03 < 1)
			{
				continue;
			}

			var_04 = anglestoforward(var_02.angles);
			var_05 = anglestoforward(self.vehicle.angles);
			var_06 = self.vehicle.origin - var_02.origin;
			var_07 = vectornormalize(var_06);
			if(vectordot(var_04,var_05) > 0.87 && vectordot(var_04,var_07) > 0.87)
			{
				var_08 = self.traffic_speed;
				if(isdefined(self.traffic_old_speed))
				{
					var_08 = self.traffic_old_speed;
				}

				var_03 = mph_to_model_speed(var_03);
				var_09 = var_02 vehicle_getcurrentnode_a();
				if(isdefined(var_09))
				{
					var_0A = var_09.speed;
					var_03 = max(var_03,var_0A);
				}

				var_0B = var_03 - var_08;
				var_0C = squared(var_0B * 4);
				var_0D = distance2dsquared(self.vehicle.origin,var_02 get_adjusted_script_car_origin(1));
				if((var_0B > 0 || var_0B > -80 && var_0D < level.traffic_tune_min_stop_dist_sq) && var_0D < var_0C)
				{
					var_0E = anglestoright(var_02.angles);
					var_0F = vectordot(var_0E,var_06);
					var_10 = self.vehicle vehicle_getcurrentnode_a();
					if(isdefined(var_10) && isdefined(var_10.lane_start_node.do_pathbased_avoidance) && var_10.lane_start_node.do_pathbased_avoidance && isdefined(var_09))
					{
						var_11 = 0;
						var_12 = sqrt(var_0D);
						var_13 = sqrt(var_0C);
						var_14 = 1;
						var_15 = get_path_segment_array(var_10,var_13 - var_12,var_14);
						var_16 = get_path_segment_array(var_09,var_13);
						var_17 = 0;
						var_18 = undefined;
						var_19 = undefined;
						var_1A = undefined;
						var_1B = undefined;
						var_1C = undefined;
						var_1D = undefined;
						var_1E = undefined;
						var_1F = undefined;
						var_20 = 0;
						var_21 = var_16.size == 1;
						foreach(var_23 in var_15)
						{
							var_24 = 0;
							if(var_14 && var_15[0] == var_23)
							{
								var_24 = 1;
							}

							foreach(var_26 in var_16)
							{
								var_20++;
								var_27 = get_closest_point_from_segment_to_segment_n(var_23,var_26,var_21,var_24);
								var_28 = var_27[0];
								var_29 = var_27[1];
								var_2A = var_27[2];
								var_2B = var_27[3];
								var_2C = var_27[4];
								var_2D = var_27[5];
								var_2E = var_27[6];
								var_2F = var_27[7];
								if(var_2B)
								{
									var_30 = distance2dsquared(self.vehicle.origin,var_29);
									if(var_30 > var_17)
									{
										var_18 = var_28;
										var_19 = var_29;
										var_1A = var_2A;
										var_1B = var_2B;
										var_1C = var_2C;
										var_1E = var_2E;
										var_1D = var_2D;
										var_1F = var_2F;
										var_17 = var_30;
										var_11 = var_20;
									}
								}
							}
						}

						if(var_11 != 0)
						{
							var_33 = [];
							var_34 = get_c_right_dist_2d(var_19,var_1A,var_1C,var_1D,var_1E,var_1F);
							var_35 = 0;
							var_36 = 0;
							if(var_34 > -35 && isdefined(get_neighbor_node("right")) && is_neighboring_lane_clear("right",1))
							{
								var_35 = 1;
							}

							if(var_34 < 35 && isdefined(get_neighbor_node("left")) && is_neighboring_lane_clear("left",1))
							{
								var_36 = 1;
							}

							if(var_35 && var_36)
							{
								if(!isdefined(var_02.script_car_on_right))
								{
									var_33[var_33.size] = "right";
								}

								if(!isdefined(var_02.script_car_on_left))
								{
									var_33[var_33.size] = "left";
								}

								if(isdefined(var_02.script_car_on_right) && isdefined(var_02.script_car_on_left))
								{
									var_37 = get_farthest_car([var_02,var_02.script_car_on_right,var_02.script_car_on_left]);
									if(var_37 == var_02.script_car_on_right)
									{
										var_33[var_33.size] = "right";
									}
									else if(var_37 == var_02.script_car_on_left)
									{
										var_33[var_33.size] = "left";
									}
								}
							}
							else if(var_35)
							{
								if(!isdefined(var_02.script_car_on_right))
								{
									var_33[var_33.size] = "right";
								}
							}
							else if(var_36)
							{
								if(!isdefined(var_02.script_car_on_left))
								{
									var_33[var_33.size] = "left";
								}
							}
							else
							{
								var_38 = 0;
							}

							if(var_33.size > 0)
							{
								var_39 = randomint(var_33.size);
								self notify("change_lane",var_33[var_39],var_02);
								return;
							}
							else
							{
								self.traffic_change_lane++;
								if(var_0E < level.traffic_tune_min_stop_dist_sq)
								{
									thread set_traffic_change_speedup(1,var_04 * 1.05);
								}
								else
								{
									thread set_traffic_change_speedup(1);
								}
							}
						}
					}
					else
					{
						var_3A = undefined;
						if(var_10 > -25 && var_10 < 25)
						{
							if(isdefined(get_neighbor_node("left")))
							{
								var_3A = "right";
							}
							else if(isdefined(get_neighbor_node("left")))
							{
								var_3A = "left";
							}
						}
						else if(isdefined(get_neighbor_node("left")) && var_10 < -25)
						{
							var_3A = "left";
						}
						else if(isdefined(get_neighbor_node("left")) && var_10 > 25)
						{
							var_3A = "right";
						}

						if(isdefined(var_3A))
						{
							self notify("change_lane",var_3A,var_03);
							return;
						}
					}
				}
			}
		}

		wait(var_01);
	}
}

//Function Number: 71
get_farthest_car(param_00)
{
	var_01 = -999;
	var_02 = undefined;
	foreach(var_04 in param_00)
	{
		var_05 = distance2dsquared(var_04.origin,self.vehicle.origin);
		if(var_05 > var_01)
		{
			var_01 = var_05;
			var_02 = var_04;
		}
	}

	return var_02;
}

//Function Number: 72
get_closest_point_from_segment_to_segment_n(param_00,param_01,param_02,param_03)
{
	var_04 = 110;
	var_05 = (1,1,1);
	var_06 = 500;
	var_07 = undefined;
	var_08 = undefined;
	var_09 = undefined;
	var_0A = undefined;
	var_0B = undefined;
	var_0C = undefined;
	if(isdefined(param_00.target))
	{
		var_07 = getvehiclenode(param_00.target,"targetname");
	}
	else
	{
		return [0,(0,0,0),(0,0,0),0];
	}

	if(isdefined(param_03) && param_03)
	{
		var_0D = var_07.origin - param_00.origin;
		var_0D = vectornormalize(var_0D);
		var_0E = vectordot(self.vehicle.origin - param_00.origin,var_0D);
		var_08 = param_00.origin + var_0E * var_0D;
		var_09 = param_00.targetname + "car_projected";
	}
	else
	{
		var_08 = param_00.origin;
		var_09 = param_00.targetname;
	}

	if(isdefined(param_01.target))
	{
		var_0A = getvehiclenode(param_01.target,"targetname");
		var_0B = var_0A.origin;
		var_0C = var_0A.targetname;
	}
	else
	{
		var_0F = getvehiclenode(param_01.targetname,"target");
		if(isdefined(var_0F) && isdefined(param_02) && param_02)
		{
			var_0D = param_01.origin - var_0F.origin;
			var_0D = vectornormalize(var_0D);
			var_0B = param_01.origin + var_0D * var_06;
			var_0C = param_01.targetname + "Extend";
		}
		else
		{
			return [0,(0,0,0),(0,0,0),0];
		}
	}

	var_10 = get_closest_point_from_segment_to_segment(var_08,var_07.origin,param_01.origin,var_0B);
	var_11 = var_10[0];
	var_12 = var_10[1];
	var_13 = var_10[2];
	var_14 = var_08;
	var_15 = var_07.origin;
	var_16 = param_01.origin;
	var_17 = var_0B;
	var_18 = var_11 < var_04 * var_04;
	return [var_11,var_12,var_13,var_18,var_14,var_15,var_16,var_16];
}

//Function Number: 73
get_neighbor_node_of_target(param_00)
{
	return get_neighbor_node(param_00,1);
}

//Function Number: 74
get_neighbor_node(param_00,param_01)
{
	if(self.vehicle.classname == "script_model")
	{
		var_02 = self.currentnode;
	}
	else
	{
		var_03 = vehicle_getcurrentnode_a();
		if(isdefined(param_01) && param_01)
		{
			if(!isdefined(var_03.target))
			{
				return undefined;
			}

			var_02 = getvehiclenode(var_03.target,"targetname");
		}
		else
		{
			var_02 = var_03;
		}
	}

	if(!isdefined(param_00))
	{
		return undefined;
	}

	if(!isdefined(var_02))
	{
		return undefined;
	}

	if(param_00 == "right" || param_00 == "r")
	{
		return var_02.neighbor_right;
	}
	else if(param_00 == "left" || param_00 == "l")
	{
		return var_02.neighbor_left;
	}

	return undefined;
}

//Function Number: 75
is_neighboring_lane_clear(param_00,param_01)
{
	var_02 = 1;
	var_03 = 0;
	var_04 = get_neighbor_node(param_00);
	var_05 = find_closest_car(var_04,self.vehicle.origin);
	if(isdefined(var_05) && var_05 != self)
	{
		var_06 = distance2dsquared(var_05.vehicle.origin,self.vehicle.origin);
		if(var_06 < 65536)
		{
			var_02 = 0;
		}
		else
		{
			var_02 = 1;
		}
	}

	if(isdefined(param_01) && param_01)
	{
		var_07 = undefined;
		param_00 = tolower(getsubstr(param_00,0,1));
		if(param_00 == "r")
		{
			var_07 = anglestoright(self.vehicle.angles);
		}
		else
		{
			var_07 = -1 * anglestoright(self.vehicle.angles);
		}

		var_08 = self.vehicle.origin + (0,0,25) + var_07 * 40;
		for(var_09 = 0;var_09 < 3;var_09++)
		{
			var_0A = undefined;
			if(var_09 == 0)
			{
				var_0A = var_07 * 150;
			}

			if(var_09 == 1)
			{
				var_0A = var_07 + -1 * anglestoforward(self.vehicle.angles) * 150;
			}

			if(var_09 == 2)
			{
				var_0A = var_07 + anglestoforward(self.vehicle.angles) * 2 * 0.5 * 180;
			}

			var_03 = bullettracepassed(var_08,var_08 + var_0A,0,self.vehicle);
			if(!var_03)
			{
				break;
			}
		}
	}
	else
	{
		var_03 = 1;
	}

	return var_03 && var_02;
}

//Function Number: 76
change_lane(param_00,param_01)
{
	self endon("death");
	var_02 = get_neighbor_node(param_00);
	if(!isdefined(var_02))
	{
		return;
	}

	var_03 = 0;
	var_04 = 5;
	var_05 = 0;
	var_06 = 0.0871558;
	while(var_04 > 0)
	{
		var_03 = 1;
		var_07 = anglestoright(self.vehicle.angles);
		if(param_00 == "left")
		{
			var_07 = var_07 * -1;
		}

		var_02 = is_neighboring_lane_clear(param_00);
		if(isdefined(var_02))
		{
			var_03 = 0;
		}
		else
		{
			var_08 = 0;
		}

		if(var_03)
		{
			foreach(var_0A in level.script_cars)
			{
				if(!isdefined(var_0A))
				{
					continue;
				}

				var_0B = var_0A.origin - self.vehicle.origin;
				var_0C = length2dsquared(var_0B);
				if(var_0C < 65536)
				{
					var_0D = vectornormalize(var_0B);
					var_0E = vectordot(var_0D,var_07);
					if(var_0E > var_06)
					{
						var_03 = 0;
						break;
					}
				}
			}
		}

		if(var_03)
		{
			break;
		}

		if(!var_05)
		{
			var_05 = 1;
			self.traffic_change_lane++;
		}

		var_04 = var_04 - 0.05;
		wait(0.05);
	}

	if(var_05)
	{
		self.traffic_change_lane--;
	}

	if(var_03)
	{
		var_02 = get_neighbor_node(param_00);
		if(isdefined(var_02))
		{
			var_10 = 1500;
			if(islagostraversesetting(self.vehicle) && self.vehicle.code_classname == "script_vehicle")
			{
				if(!isdefined(level.traffic_tune_lane_change_angle))
				{
					level.traffic_tune_lane_change_cosangle = cos(30);
				}

				var_11 = anglestoright(self.vehicle.angles);
				var_12 = vectornormalize(var_02.origin - self.vehicle.origin);
				if(abs(vectordot(var_11,var_12)) > level.traffic_tune_lane_change_cosangle)
				{
					var_02 = getvehiclenode(var_02.target,"targetname");
				}

				if(distance2dsquared(self.vehicle.origin,var_02.origin) > var_10 * var_10)
				{
					var_13 = getvehiclenode(var_02.targetname,"target");
					if(isdefined(var_13))
					{
						var_14 = get_goal_pos_on_segment(var_02.origin,var_13.origin,self.vehicle.origin,var_10);
						self.vehicle vehicledriveto(var_14,self.vehicle vehicle_getspeed());
					}
				}
			}

			var_15 = undefined;
			if(isdefined(self.traffic_leader_pending_check) && self.traffic_leader_pending_check)
			{
				var_15 = self.traffic_leader_pending;
			}
			else
			{
				var_15 = self.traffic_leader;
			}

			var_16 = self.traffic_follower;
			insert_to_lane(var_02,undefined,"CHANGELANE");
			self.vehicle thread traffic_drive_vehicle(var_02);
			var_16.traffic_leader = var_15;
			if(islagostraversesetting(self.vehicle) && isdefined(param_01))
			{
				var_17 = mph_to_model_speed(param_01 vehicle_getspeed_a());
				var_18 = param_01 vehicle_getcurrentnode_a();
				if(isdefined(var_18))
				{
					var_19 = var_18.speed;
					var_17 = max(var_17,var_19);
				}

				var_1A = mph_to_model_speed(self.vehicle vehicle_getspeed_a());
				var_1B = param_01.origin;
				var_1C = distance2d(var_1B,self.vehicle.origin);
				var_1D = var_17 - var_1A;
				var_1E = var_1C / var_1D;
				if(var_17 > var_1A * 1.5 || var_1E < 1)
				{
					self.traffic_change_lane++;
					if(var_1C < level.traffic_tune_min_stop_dist)
					{
						thread set_traffic_change_speedup(1,var_17 * 1.05);
						return;
					}

					thread set_traffic_change_speedup(1);
					return;
				}

				return;
			}

			return;
		}

		var_08 = 0;
	}
}

//Function Number: 77
islagostraversesetting(param_00)
{
	var_01 = param_00 vehicle_getcurrentnode_a();
	if(isdefined(var_01) && isdefined(var_01.lane_start_node) && isdefined(var_01.lane_start_node.lagoshack))
	{
		return 1;
	}

	return 0;
}

//Function Number: 78
vehicle_getspeed_a()
{
	if(self.code_classname == "script_vehicle")
	{
		return self vehicle_getspeed();
	}

	if(isdefined(self.vehicle))
	{
		return self.vehicle.parent_ent.traffic_speed;
	}

	return 0;
}

//Function Number: 79
set_traffic_change_speedup(param_00,param_01)
{
	self.traffic_change_lane_speed = param_01;
	self endon("death");
	wait(param_00);
	self.traffic_change_lane--;
	if(self.traffic_change_lane == 0)
	{
		self.traffic_change_lane_speed = undefined;
	}
}

//Function Number: 80
merge_lane()
{
	var_00 = undefined;
	var_00 = vehicle_getcurrentnode_a();
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = self.traffic_follower;
	insert_to_lane(var_00,undefined,"MERGE");
	self.traffic_pre_merge_follower = var_01;
	if(is_traffic_ent(var_01) && var_01 != self)
	{
		var_01.traffic_leader = self;
	}
}

//Function Number: 81
split_lane()
{
	level endon("stop_traffic");
	self endon("death");
	self endon("reached_end_node");
	if(randomint(100) > 40)
	{
		return;
	}

	var_00 = undefined;
	if(self.vehicle.classname == "script_model")
	{
		var_01 = getvehiclenodearray(self.currentnode.targetname,"target");
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			if(isdefined(var_01[var_02].script_noteworthy) && var_01[var_02].script_noteworthy == "traffic_lane_split" || var_01[var_02].script_noteworthy == "traffic_lane_exit")
			{
				var_00 = var_01[var_02];
				break;
			}
		}
	}
	else
	{
		var_00 = self.vehicle;
	}

	if(!isdefined(var_00.script_linkto))
	{
		return;
	}

	var_03 = getvehiclenode(var_00.script_linkto,"script_linkname");
	if(!isdefined(var_03))
	{
		return;
	}

	var_04 = undefined;
	if(isdefined(self.traffic_leader_pending_check) && self.traffic_leader_pending_check)
	{
		var_04 = self.traffic_leader_pending;
	}
	else
	{
		var_04 = self.traffic_leader;
	}

	var_05 = self.traffic_follower;
	insert_to_lane(var_03,undefined,"SPLIT");
	split_lane_extra_handling(var_04,var_05);
	self.vehicle thread traffic_drive_vehicle(var_03);
}

//Function Number: 82
split_lane_extra_handling(param_00,param_01)
{
	if(level.template_script != "lagos")
	{
		return;
	}

	if(is_traffic_ent(param_01))
	{
		param_01.traffic_leader = self;
		if(isdefined(self.traffic_leader_pending))
		{
			param_01.traffic_leader_pending = self.traffic_leader_pending;
		}
		else
		{
			param_01.traffic_leader_pending = param_00;
		}

		param_01.traffic_leader_pending_check = 1;
	}

	if(isdefined(self.traffic_leader_pending_check) && self.traffic_leader_pending_check)
	{
		self.traffic_leader_pending_check = undefined;
		self.traffic_leader_pending = undefined;
	}
}

//Function Number: 83
dodge_behavior()
{
	level endon("stop_traffic");
	self endon("death");
	self endon("reached_end_node");
	if(isdefined(self.crashed))
	{
		return;
	}

	self endon("vehicle_crash");
	var_00 = 0.05;
	if(level.currentgen)
	{
		var_00 = 0.05;
	}

	for(;;)
	{
		if(islagostraversesetting(self.vehicle) && self.traffic_change_lane > 0)
		{
			wait(var_00);
			continue;
		}

		if(self.vehicle.classname == "script_model")
		{
			self waittill("swap_to_real_vehicle");
			continue;
		}

		var_01 = decide_to_dodge();
		var_02 = var_01[0];
		var_03 = var_01[1];
		if(isdefined(var_02))
		{
			self.dodging = 1;
			var_04 = update_dodge(var_02,var_03,2.5);
			self.dodging = undefined;
			if(distance2dsquared(self.vehicle.origin,level.player.origin) > 342225 || self.vehicle vehicle_getspeed() > 0)
			{
				resume_driving_from_dodge(var_04);
			}
			else
			{
				thread do_crash();
			}
		}

		wait(var_00);
	}
}

//Function Number: 84
do_crash()
{
	var_00 = vehicle_getcurrentnode_a();
	if(isdefined(var_00.no_crash_handling) && var_00.no_crash_handling)
	{
		return;
	}

	self notify("vehicle_crash");
	if(isdefined(self.vehicle))
	{
		self.vehicle notify("vehicle_crash");
	}
}

//Function Number: 85
startpath_with_currentnode_update(param_00)
{
	var_01 = get_closest_node_in_front_of_given_car(param_00,self);
	thread maps\_vehicle::vehicle_paths(var_01);
	self startpath(var_01);
}

//Function Number: 86
get_closest_node_in_front_of_given_car(param_00,param_01)
{
	var_02 = param_00;
	var_03 = 1409865409;
	var_04 = param_00;
	for(;;)
	{
		if(!isdefined(var_02))
		{
			break;
		}

		if(!isdefined(var_02.target))
		{
			break;
		}

		var_05 = distance2dsquared(var_02.origin,param_01.origin);
		if(var_05 < var_03 && !vehicle_in_front_of_node(param_01,var_02))
		{
			var_03 = var_05;
			var_04 = var_02;
		}

		var_02 = getvehiclenode(var_02.target,"targetname");
		if(!isdefined(var_02))
		{
			break;
		}
	}

	return var_04;
}

//Function Number: 87
get_node_at_radius_distance(param_00,param_01,param_02,param_03)
{
	var_04 = param_00;
	var_05 = undefined;
	for(;;)
	{
		if(!isdefined(var_04))
		{
			break;
		}

		if(!isdefined(var_04.target))
		{
			break;
		}

		var_06 = distancesquared(param_01,var_04.origin);
		if(var_06 < param_02)
		{
			if(!isdefined(var_04.nospawn))
			{
				var_05 = var_04;
				break;
			}
		}

		var_04 = getvehiclenode(var_04.target,"targetname");
		if(!isdefined(var_04))
		{
			break;
		}
	}

	if(!param_03)
	{
		var_05 = undefined;
		var_07 = var_04;
		for(;;)
		{
			if(!isdefined(var_04))
			{
				break;
			}

			if(!isdefined(var_04.target))
			{
				break;
			}

			var_06 = distancesquared(param_01,var_04.origin);
			if(var_06 > param_02 && !isdefined(var_04.nospawn))
			{
				var_05 = var_07;
				break;
			}

			var_07 = var_04;
			var_04 = getvehiclenode(var_04.target,"targetname");
			if(!isdefined(var_04))
			{
				break;
			}
		}
	}

	return var_05;
}

//Function Number: 88
resume_driving_from_dodge(param_00)
{
	var_01 = get_neighbor_node(param_00);
	if(isdefined(var_01))
	{
		if(isdefined(self.vehicle) && self.vehicle.classname == "script_vehicle")
		{
			self.vehicle vehicledriveto(var_01.origin,var_01.speed * 0.5);
		}

		var_02 = undefined;
		if(isdefined(self.traffic_leader_pending_check) && self.traffic_leader_pending_check)
		{
			var_02 = self.traffic_leader_pending;
		}
		else
		{
			var_02 = self.traffic_leader;
		}

		var_03 = self.traffic_follower;
		var_04 = insert_to_lane(var_01,undefined,"RESUMEDODGE");
		self.vehicle thread traffic_drive_vehicle(var_01);
		if(var_04)
		{
			var_03.traffic_leader = var_02;
			return;
		}

		return;
	}

	if(!isdefined(var_01))
	{
		var_01 = vehicle_getcurrentnode_a();
	}

	self.vehicle thread traffic_drive_vehicle(var_01);
}

//Function Number: 89
update_dodge(param_00,param_01,param_02)
{
	self endon("death");
	self endon("vehicle_crash");
	self.vehicle endon("stop_dodge");
	var_03 = 0;
	var_04 = undefined;
	var_05 = 0.05;
	if(level.currentgen)
	{
		var_05 = 0.05;
	}

	if(self.vehicle.classname == "script_model")
	{
		return undefined;
	}

	for(;;)
	{
		var_06 = most_threatening_car(234);
		var_07 = var_06[0];
		var_08 = var_06[1];
		var_09 = var_06[2];
		if(isdefined(var_07))
		{
			var_0A = maps\_shg_utility::linear_map_clamp(param_01,0,1.8,5,3);
			if(islagostraversesetting(self.vehicle))
			{
				var_0A = var_0A * 2;
			}

			var_0B = self.vehicle vehicle_getvelocity();
			var_0C = length(var_0B);
			var_0D = vectornormalize(var_0B);
			var_0E = var_07 get_adjusted_script_car_origin();
			var_0F = [];
			var_10 = "";
			var_11 = undefined;
			var_12 = [];
			foreach(var_14 in [-1,1])
			{
				var_15 = transformmove((0,0,0),(0,var_14 * var_0A,0),(0,0,0),(0,0,0),var_0D,(0,0,0))["origin"];
				if(var_14 == -1)
				{
					var_10 = "R";
				}
				else
				{
					var_10 = "L";
				}

				if(!is_neighboring_lane_clear(var_10,1))
				{
					continue;
				}

				if(bullettracepassed(self.vehicle.origin,self.vehicle.origin + var_15 * var_0C * 1,0,self.vehicle))
				{
					if(islagostraversesetting(self.vehicle))
					{
						var_16 = var_0C;
					}
					else
					{
						var_16 = var_0D + mph_to_model_speed(5);
					}

					if(var_16 < mph_to_model_speed(90))
					{
						var_0F[var_12.size] = var_10 + "a";
						var_12[var_12.size] = var_15 * var_16;
					}
				}
				else
				{
				}

				if(!islagostraversesetting(self.vehicle))
				{
					var_16 = var_0C - mph_to_model_speed(5);
					if(var_16 > mph_to_model_speed(10))
					{
						var_0F[var_12.size] = var_10 + "d";
						var_12[var_12.size] = var_15 * var_16;
					}
				}
			}

			var_18 = var_0B;
			var_19 = undefined;
			var_1A = -1;
			var_1B = -1;
			var_1C = [];
			var_1D = [];
			var_1E = [];
			foreach(var_20 in var_12)
			{
				var_1B++;
				var_21 = time_and_distance_of_closest_approach(self.vehicle.origin,var_20,var_0E,var_07 vehicle_getvelocity(),0.1,136.5,1);
				var_22 = var_21[0];
				var_23 = var_21[1];
				if(var_22 > 1.8)
				{
					var_1C[var_1B] = -1;
					var_1D[var_1B] = var_22;
					var_1E[var_1B] = var_23;
					continue;
				}

				var_24 = compute_threat(var_22,var_23);
				var_1C[var_1B] = var_24;
				var_1D[var_1B] = var_22;
				var_1E[var_1B] = var_23;
				if(!isdefined(var_19) || var_24 < var_19)
				{
					var_1A = var_1B;
					var_19 = var_24;
					var_18 = var_20;
				}
			}

			if(distance2dsquared(self.vehicle.origin,level.player.origin) < 38025 && vectordot(var_18,anglestoforward(level.player.angles)) < 0)
			{
				var_18 = (0,0,0);
			}

			if(var_1A > -1)
			{
				if(var_0F[var_1A] == "La" || var_0F[var_1A] == "Ld")
				{
					var_04 = "left";
				}
				else
				{
					var_04 = "right";
				}
			}

			var_26 = self.vehicle.origin + var_18 * 10;
			self.vehicle vehicledriveto(var_26,model_speed_to_mph(length(var_18)));
		}
		else if(var_03 > 0.3)
		{
			return var_04;
		}

		var_03 = var_03 + 0.05;
		wait(var_05);
	}

	return var_04;
}

//Function Number: 90
best_dodge_car()
{
	if(self.vehicle.classname == "script_model")
	{
		return [undefined,undefined];
	}

	var_00 = most_threatening_car(136.5);
	var_01 = var_00[0];
	var_02 = var_00[1];
	var_03 = var_00[2];
	if(isdefined(var_01) && var_03 < 136.5)
	{
		return [var_01,var_02];
	}

	return [undefined,undefined];
}

//Function Number: 91
get_adjusted_script_car_origin(param_00)
{
	if(self.vehicletype == "civ_domestic_bus_physics")
	{
		var_01 = self gettagorigin("tag_wheel_back_left");
		var_02 = self gettagorigin("tag_wheel_back_right");
		if(isdefined(param_00) && param_00)
		{
			var_01 = self gettagorigin("tag_wheel_front_left");
			var_02 = self gettagorigin("tag_wheel_front_right");
		}

		var_03 = var_01 - var_02 * 0.5 + var_02;
		return var_03;
	}

	return self.origin;
}

//Function Number: 92
most_threatening_car(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	var_05 = self.vehicle.origin;
	var_06 = self.vehicle vehicle_getvelocity();
	foreach(var_08 in level.script_cars)
	{
		if(!isdefined(var_08))
		{
			continue;
		}

		var_09 = var_08 get_adjusted_script_car_origin();
		if(distance2dsquared(var_05,var_09) > 60840000)
		{
			continue;
		}

		var_0A = time_and_distance_of_closest_approach(var_05,var_06,var_09,var_08 vehicle_getvelocity(),0.1,136.5);
		var_0B = var_0A[0];
		var_0C = var_0A[1];
		if(var_0B > 1.8)
		{
			continue;
		}

		if(isdefined(level.player_pitbull) && var_08 == level.player_pitbull)
		{
			var_0C = var_0C * 0.5;
		}

		if(var_0C > param_00)
		{
			continue;
		}

		var_0D = 0;
		if(islagostraversesetting(self.vehicle))
		{
			var_0E = anglestoforward(self.vehicle.angles);
			var_0E = (var_0E[0],var_0E[1],0);
			var_0E = vectornormalize(var_0E);
			var_0F = var_09 - self.vehicle.origin;
			var_0F = (var_0F[0],var_0F[1],0);
			var_0F = vectornormalize(var_0F);
			var_10 = vectordot(var_0F,var_0E);
			var_0D = 0;
			if(var_10 < 1 && var_10 > -1)
			{
				var_0D = acos(var_10);
			}
		}

		if(var_0D < 30)
		{
			var_11 = compute_threat(var_0B,var_0C);
			if(!isdefined(var_01) || var_11 > var_04)
			{
				var_01 = var_08;
				var_02 = var_0C;
				var_03 = var_0B;
				var_04 = var_11;
			}
		}
	}

	return [var_01,var_03,var_02];
}

//Function Number: 93
compute_threat(param_00,param_01)
{
	if(param_01 < 136.6)
	{
		if(param_00 <= 0.1)
		{
			var_02 = 3 - param_01 / 136.5;
		}
		else
		{
			var_02 = 2 - param_01 / 1.8;
		}
	}
	else
	{
		var_02 = 1 / var_02 + 1;
	}

	return var_02;
}

//Function Number: 94
time_and_distance_of_closest_approach(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_04))
	{
		param_04 = 0.05;
	}

	if(!isdefined(param_05))
	{
		param_05 = 0;
	}

	var_07 = param_00 - param_02;
	var_08 = param_01 - param_03;
	var_09 = lengthsquared(var_08);
	var_0A = 2 * vectordot(var_07,var_08);
	var_0B = lengthsquared(var_07) - squared(param_05);
	var_0C = squared(var_0A) - 4 * var_09 * var_0B;
	var_0D = 0;
	if(var_0C > 0 && var_09 > 0)
	{
		var_0E = -0.5 * var_0A + common_scripts\utility::sign(var_0A) * sqrt(var_0C);
		var_0F = min(var_0E / var_09,var_0B / var_0E);
	}
	else if(var_0A > 0)
	{
		var_0F = var_0B / -2 * var_0A;
	}
	else
	{
		var_0F = param_05;
	}

	if(var_0F < param_04)
	{
		var_0F = param_04;
	}

	var_10 = distance(param_00 + param_01 * var_0F,param_02 + param_03 * var_0F);
	return [var_0F,var_10];
}

//Function Number: 95
decide_to_dodge()
{
	level endon("stop_traffic");
	self endon("death");
	self endon("reached_end_node");
	var_00 = 0.05;
	if(level.currentgen)
	{
		var_00 = 0.05;
	}

	for(;;)
	{
		var_01 = best_dodge_car();
		var_02 = var_01[0];
		var_03 = var_01[1];
		if(isdefined(var_03))
		{
			if(level.nextgen)
			{
				if(var_03 < 2.5 && var_03 > 0.5)
				{
					thread high_beam_oncoming();
				}
			}

			return [var_02,var_03];
		}

		wait(var_00);
	}
}

//Function Number: 96
high_beam_oncoming()
{
	self endon("death");
	if(isdefined(self.high_beaming) && self.high_beaming)
	{
		return;
	}

	var_00 = ["headlight_left","headlight_right","headlight_set"];
	self.high_beaming = 1;
	traffic_vehicle_lights_on(var_00);
	wait(0.2);
	traffic_vehicle_lights_off(var_00);
	wait(0.3);
	traffic_vehicle_lights_on(var_00);
	wait(0.2);
	traffic_vehicle_lights_off(var_00);
	wait(0.3);
	self.high_beaming = undefined;
}

//Function Number: 97
telefrag_behavior()
{
	self endon("death");
	for(;;)
	{
		level waittill("new_script_car",var_00);
		if(distance2dsquared(var_00.origin,self.vehicle.origin) < 24336)
		{
			self notify("reached_end_node");
		}
	}
}

//Function Number: 98
is_lane_start_node(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	foreach(var_02 in level.traffic_lanes)
	{
		if(var_02 == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 99
find_closest_car(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	var_02 = param_00.lane_start_node;
	var_03 = undefined;
	var_04 = 0;
	if(!isdefined(level.player.assertdisplayed))
	{
		level.player.assertdisplayed = 0;
	}

	if(isdefined(var_02.traffic_tail) && isdefined(var_02.traffic_tail.traffic_leader))
	{
		var_05 = var_02.traffic_tail.traffic_leader;
		var_06 = var_05;
		var_03 = var_05;
		var_07 = distance2dsquared(var_05.vehicle.origin,param_01);
		var_08 = [];
		var_09 = var_05;
		while(isdefined(var_05.traffic_leader) && var_05.traffic_leader != var_06)
		{
			var_04++;
			if(isdefined(var_05.traffic_leader_pending_check) && var_05.traffic_leader_pending_check)
			{
				if(!isdefined(self.traffic_follower) || is_traffic_ent(self.traffic_follower) && self.traffic_follower vehicle_getcurrentnode_a().lane_start_node == var_05.traffic_leader vehicle_getcurrentnode_a())
				{
					var_05 = var_05.traffic_leader_pending;
				}
				else
				{
					var_05 = var_05.traffic_leader;
				}
			}
			else
			{
				var_05 = var_05.traffic_leader;
			}

			if(!isdefined(var_05))
			{
				break;
			}

			var_0A = distance2dsquared(var_05.vehicle.origin,param_01);
			if(var_0A < var_07)
			{
				var_03 = var_05;
				var_07 = var_0A;
			}

			if(var_05 == self)
			{
				return self;
			}

			if(var_09 == var_05)
			{
				break;
			}

			if(var_04 > 300)
			{
				if(!level.player.assertdisplayed)
				{
					level.player.assertdisplayed = 1;
				}

				break;
			}
		}
	}

	return var_03;
}

//Function Number: 100
insert_to_lane(param_00,param_01,param_02)
{
	if(!isdefined(level.player.assertdisplayed_b))
	{
		level.player.assertdisplayed_b = 0;
	}

	var_03 = param_00.lane_start_node;
	if(!isdefined(param_01))
	{
		param_01 = find_closest_car(param_00,self.vehicle.origin);
	}

	if(!isdefined(param_01))
	{
		remove_and_insert_at_traffic_tail(param_00);
		return 0;
	}

	if(param_01 == self)
	{
		return 0;
	}

	var_04 = vectornormalize(anglestoforward(self.vehicle.angles));
	var_05 = param_01;
	var_06 = undefined;
	var_07 = 0;
	for(;;)
	{
		var_07++;
		var_08 = vectornormalize(var_05.vehicle.origin - self.vehicle.origin);
		if(vectordot(var_08,var_04) > 0)
		{
			var_06 = var_05;
			break;
		}

		if(!isdefined(var_05.traffic_leader))
		{
			break;
		}

		var_05 = var_05.traffic_leader;
		if(var_07 > 300)
		{
			if(!level.player.assertdisplayed_b)
			{
				level.player.assertdisplayed_b = 1;
			}

			break;
		}
	}

	if(isdefined(var_06))
	{
		remove_and_insert_behind_leader(var_06);
	}
	else
	{
		remove_and_insert_before_leader(var_05);
	}

	return 1;
}

//Function Number: 101
remove_from_traffic_lane()
{
	var_00 = undefined;
	if(isdefined(self.traffic_leader))
	{
		var_00 = self.traffic_leader;
	}

	var_01 = undefined;
	if(isdefined(self.traffic_follower))
	{
		var_01 = self.traffic_follower;
	}

	var_02 = undefined;
	if(isdefined(self.traffic_leader_pending_check) && self.traffic_leader_pending_check)
	{
		var_02 = self.traffic_leader_pending;
	}

	if(isdefined(var_00))
	{
		if(var_00.traffic_follower == self)
		{
			var_00.traffic_follower = var_01;
			if(isdefined(var_01))
			{
				var_01.traffic_leader = var_00;
			}
		}
		else if(isdefined(var_01))
		{
			var_01.traffic_leader = var_00;
		}
	}

	if(isdefined(var_02))
	{
		if(var_02.traffic_follower == self)
		{
			var_02.traffic_follower = var_01;
		}
	}

	foreach(var_04 in level.traffic_lanes)
	{
		if(isdefined(var_04.traffic_head_veh) && var_04.traffic_head_veh == self)
		{
			if(isdefined(var_01) && is_traffic_ent(var_01))
			{
				var_04.traffic_head_veh = var_01;
			}
			else
			{
				var_04.traffic_head_veh = undefined;
			}
		}

		if(isdefined(var_04.traffic_tail) && isdefined(var_04.traffic_tail.traffic_leader) && var_04.traffic_tail.traffic_leader == self)
		{
			if(isdefined(var_00) && is_traffic_ent(var_00))
			{
				var_04.traffic_tail.traffic_leader = var_00;
				continue;
			}

			var_04.traffic_tail.traffic_leader = undefined;
		}
	}

	self.traffic_leader = undefined;
	self.traffic_follower = undefined;
}

//Function Number: 102
remove_and_insert_at_traffic_tail(param_00)
{
	var_01 = param_00.lane_start_node;
	remove_from_traffic_lane();
	self.traffic_follower = var_01.traffic_tail;
	var_01.traffic_tail.traffic_leader = self;
	if(!isdefined(var_01.lane_start_node.traffic_head_veh))
	{
		var_01.lane_start_node.traffic_head_veh = self;
	}
}

//Function Number: 103
remove_and_insert_behind_leader(param_00)
{
	if(param_00 == self)
	{
		return;
	}

	var_01 = 0;
	if(isdefined(self.traffic_leader_pending_check) && self.traffic_leader_pending_check)
	{
		if(isdefined(self.traffic_leader_pending) && param_00 == self.traffic_leader_pending)
		{
			return;
		}
	}
	else if(isdefined(self.traffic_leader) && param_00 == self.traffic_leader)
	{
		if(isdefined(param_00.traffic_follower) && param_00.traffic_follower == self)
		{
			return;
		}
		else
		{
			var_01 = 1;
		}
	}

	var_02 = param_00.traffic_follower;
	if(!var_01)
	{
		remove_from_traffic_lane();
	}

	var_03 = param_00.traffic_follower;
	self.traffic_leader = param_00;
	param_00.traffic_follower = self;
	self.traffic_follower = var_03;
	var_03.traffic_leader = self;
	if(is_traffic_ent(var_02) && var_02 != var_03)
	{
		var_02.traffic_leader = self;
	}
}

//Function Number: 104
remove_and_insert_before_leader(param_00)
{
	if(param_00 == self)
	{
		return;
	}

	var_01 = param_00 vehicle_getcurrentnode_a().lane_start_node;
	remove_from_traffic_lane();
	if(!isdefined(var_01.traffic_head_veh) || !is_traffic_ent(param_00.traffic_leader))
	{
		var_01.traffic_head_veh = self;
	}

	var_02 = param_00.traffic_leader;
	self.traffic_follower = param_00;
	param_00.traffic_leader = self;
	self.traffic_leader = var_02;
	if(isdefined(var_02))
	{
		var_02.traffic_follower = self;
	}
}

//Function Number: 105
wait_to_clean_car(param_00)
{
	level endon("stop_traffic");
	self waittill("reached_end_node");
}

//Function Number: 106
clean_up_car(param_00)
{
	self endon("death");
	if(isdefined(self.birthnode.fill_pos_ent))
	{
		thread remove_when_out_of_range(self.birthnode.fill_pos_ent);
	}

	if(param_00)
	{
		level.traffic_cars_scriptmodel_only_count++;
	}
	else
	{
		level.traffic_cars++;
	}

	wait_to_clean_car();
	if(param_00)
	{
		level.traffic_cars_scriptmodel_only_count--;
	}
	else
	{
		level.traffic_cars--;
	}

	if(is_traffic_ent(self.traffic_pre_merge_follower) && isdefined(self.traffic_pre_merge_follower.traffic_leader) && self.traffic_pre_merge_follower.traffic_leader == self)
	{
		self.traffic_pre_merge_follower.traffic_leader = self.traffic_leader;
	}

	var_01 = self.traffic_leader;
	var_02 = self.traffic_follower;
	remove_from_traffic_lane();
	if(is_traffic_ent(var_02) && !isdefined(var_01))
	{
		var_02.traffic_leader = undefined;
	}

	if(isdefined(self.vehicle.deathfx_ent))
	{
		self.vehicle.deathfx_ent delete();
	}

	self.vehicle delete();
	self delete();
}

//Function Number: 107
remove_when_out_of_range(param_00)
{
	self endon("death");
	var_01 = -1;
	if(param_00 != level.player)
	{
		param_00 = level.player;
	}

	wait 0.05;
	for(;;)
	{
		var_02 = self.vehicle.origin - param_00.origin;
		if(get_despawn_despawn_if_not_in_view(vehicle_getcurrentnode_a().lane_start_node))
		{
			var_03 = anglestoforward(param_00 getplayerangles());
			var_01 = vectordot(var_02,var_03);
		}

		if(var_01 < 0)
		{
			if(length2dsquared(var_02) > get_despawn_dist_sq(vehicle_getcurrentnode_a().lane_start_node))
			{
				break;
			}
		}

		wait(0.2);
	}

	self notify("reached_end_node");
}

//Function Number: 108
get_despawn_despawn_if_not_in_view(param_00)
{
	var_01 = 0;
	if(isdefined(param_00.despawn_if_not_in_view))
	{
		var_01 = param_00.despawn_if_not_in_view;
	}

	return var_01;
}

//Function Number: 109
get_despawn_dist_sq(param_00)
{
	var_01 = 100000000;
	if(isdefined(param_00.despawn_dist_sq))
	{
		var_01 = param_00.despawn_dist_sq;
	}

	return var_01;
}

//Function Number: 110
clean_up_on_parent_death(param_00)
{
	self endon("death");
	if(isdefined(param_00))
	{
		param_00 waittill("death");
	}

	if(isdefined(self.deathfx_ent))
	{
		self.deathfx_ent delete();
	}

	self delete();
}

//Function Number: 111
handle_traffic_collisions()
{
	self endon("death");
	self endon("reached_end_node");
	level endon("stop_traffic");
	for(;;)
	{
		self waittill("veh_contact",var_00,var_01,var_02,var_03,var_04);
		if(isdefined(self.last_traffic_hit_time) && self.last_traffic_hit_time == gettime())
		{
			if(self.last_traffic_hit_pos == var_01)
			{
				continue;
			}
		}

		var_05 = 0;
		if(isdefined(var_00))
		{
			var_05 = 1;
			if(isdefined(var_00.last_traffic_hit_time) && var_00.last_traffic_hit_time == gettime())
			{
				if(var_00.last_traffic_hit_pos == var_01)
				{
					var_05 = 0;
				}
			}
		}

		self.last_traffic_hit_time = gettime();
		self.last_traffic_hit_pos = var_01;
		if(isdefined(var_00))
		{
			var_00.last_traffic_hit_time = gettime();
			var_00.last_traffic_hit_pos = var_01;
		}

		self notify("vehicle_damage_destruct_parts_if_available",var_01,var_02);
		if(var_05)
		{
			var_00 notify("vehicle_damage_destruct_parts_if_available",var_01,var_02);
		}

		if(crash_is_fatal(var_03))
		{
			self notify("vehicle_crash");
			if(isdefined(self.parent_ent))
			{
				self.parent_ent notify("vehicle_crash");
			}
		}

		if(var_05)
		{
			if(var_00 crash_is_fatal(var_03 * -1))
			{
				var_00 notify("vehicle_crash");
				if(isdefined(var_00.parent_ent))
				{
					var_00.parent_ent notify("vehicle_crash");
				}
			}
		}

		if(isdefined(level.traffic_collision_fx_func))
		{
			level thread [[ level.traffic_collision_fx_func ]](self,var_00,var_01,var_02,var_03,var_04);
		}

		var_06 = [];
		var_06["vehicle"] = self;
		var_06["hit_entity"] = var_00;
		var_06["pos"] = var_01;
		var_06["impulse"] = var_02;
		var_06["relativeVel"] = var_03;
		var_06["surface"] = var_04;
		if(isdefined(var_00) && !isdefined(var_00.audio))
		{
			var_00 soundscripts\_snd_common::sndx_vehicle_collision_args_setup(var_06);
		}

		soundscripts\_snd::snd_message("play_vehicle_collision",var_06);
	}
}

//Function Number: 112
crash_is_fatal(param_00)
{
	var_01 = (param_00[0],param_00[1],0);
	var_02 = length2dsquared(var_01);
	if(vectordot(param_00,anglestoforward(self.angles)) > 0)
	{
		return var_02 > 250000;
	}

	var_03 = undefined;
	var_03 = self vehicle_getcurrentnode().lane_start_node;
	if(isdefined(var_03) && isdefined(var_03.vehicle_easy_crash_die) && var_03.vehicle_easy_crash_die)
	{
		return var_02 > 100;
	}

	return var_02 > 2250000;
}

//Function Number: 113
sync_entity_damage(param_00)
{
	param_00 hide_damaged_parts();
	if(isdefined(self.damaged_parts))
	{
		foreach(var_03, var_02 in self.damaged_parts)
		{
			if(var_02)
			{
				param_00 hidepart(var_03);
				param_00 showpart(var_03 + "_D");
			}
		}
	}
}

//Function Number: 114
setup_vehicle_for_damage()
{
	thread handle_destruct_parts();
	thread handle_crashing();
	thread monitor_life();
}

//Function Number: 115
monitor_script_model_damage()
{
	var_00 = undefined;
	var_01 = undefined;
	level endon("stop_traffic");
	self endon("reached_end_node");
	maps\_vehicle_code::vehicle_life();
	self.currenthealth = self.health;
	while(self.currenthealth > 0)
	{
		self waittill("damage",var_02,var_01,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_00);
		self.currenthealth = self.currenthealth - var_02;
	}

	set_zero_speed(self.parent_ent.currentnode);
	thread maps\_vehicle_code::vehicle_kill_common(var_01,undefined);
}

//Function Number: 116
monitor_life()
{
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	var_00 = get_destruct_parts();
	if(!isdefined(var_00))
	{
		return;
	}

	foreach(var_02 in var_00)
	{
		foreach(var_04 in var_02)
		{
			self hidepart(var_04);
			self showpart(var_04 + "_D");
			if(isdefined(self.parent_ent))
			{
				if(!isdefined(self.parent_ent.damaged_parts))
				{
					self.parent_ent.damaged_parts = [];
				}

				self.parent_ent.damaged_parts[var_04] = 1;
			}
		}
	}
}

//Function Number: 117
get_destruct_parts()
{
	var_00 = undefined;
	if(isdefined(self) && isdefined(self.model))
	{
		if(self.model == "vehicle_paris_escape_sedan" || self.model == "vehicle_sedan_destruct_test")
		{
			var_00 = [];
			var_00["front"] = ["hitB","TAG_GLASS_FRONT"];
			var_00["left"] = ["TAG_GLASS_LEFT_FRONT","TAG_GLASS_LEFT_BACK","wheel_A_KL","wheel_A_FL","doorC_FL","doorC_KL"];
			var_00["right"] = ["TAG_GLASS_RIGHT_FRONT","TAG_GLASS_RIGHT_BACK","wheel_A_KR","wheel_A_FR","doorC_FR","doorC_KR"];
			var_00["back"] = ["hitA","trunk","TAG_GLASS_BACK"];
			var_00["top"] = ["hitD","TAG_GLASS_ROOF"];
			var_00["bottom"] = ["hitC"];
		}
	}

	return var_00;
}

//Function Number: 118
hide_damaged_parts()
{
	var_00 = get_destruct_parts();
	if(isdefined(var_00))
	{
		foreach(var_02 in var_00)
		{
			foreach(var_04 in var_02)
			{
				self hidepart(var_04 + "_D");
			}
		}
	}
}

//Function Number: 119
handle_destruct_parts()
{
	level endon("stop_traffic");
	self endon("reached_end_node");
	self endon("death");
	var_00 = get_destruct_parts();
	if(!isdefined(var_00))
	{
		return;
	}

	var_01 = cos(35);
	var_02 = cos(60);
	for(;;)
	{
		self waittill("vehicle_damage_destruct_parts_if_available",var_03,var_04);
		var_05 = var_03 - self.origin;
		var_05 = vectornormalize(var_05);
		var_06 = anglestoforward(self.angles);
		var_07 = anglestoright(self.angles);
		var_08 = anglestoup(self.angles);
		var_09 = vectordot(var_08,var_05);
		if(var_09 > 0.707)
		{
			damage_part_area("top",var_00);
		}
		else if(var_09 < -0.707)
		{
			damage_part_area("bottom",var_00);
		}

		var_0A = vectordot(var_06,var_05);
		if(var_0A > var_01)
		{
			damage_part_area("front",var_00);
		}
		else if(var_0A < var_01 * -1)
		{
			damage_part_area("back",var_00);
		}

		var_0B = vectordot(var_07,var_05);
		if(var_0B > var_02)
		{
			damage_part_area("right",var_00);
			continue;
		}

		if(var_0B < var_02 * -1)
		{
			damage_part_area("left",var_00);
		}
	}
}

//Function Number: 120
damage_part_area(param_00,param_01)
{
	if(!isdefined(param_01) || !isdefined(param_01[param_00]))
	{
		return;
	}

	var_02 = param_01[param_00];
	foreach(var_04 in var_02)
	{
		self hidepart(var_04);
		self showpart(var_04 + "_D");
		if(isdefined(self.parent_ent))
		{
			if(!isdefined(self.parent_ent.damaged_parts))
			{
				self.parent_ent.damaged_parts = [];
			}

			if(!isdefined(self.parent_ent.damaged_parts[var_04]) || !self.parent_ent.damaged_parts[var_04])
			{
				self.parent_ent.damaged_parts[var_04] = 1;
				level notify("vehicle_part_damage",self,var_04);
			}
		}
	}
}

//Function Number: 121
handle_crashing()
{
	level endon("stop_traffic");
	self endon("reached_end_node");
	self endon("death");
	if(isdefined(self.parent_ent.crashed))
	{
		return;
	}

	for(;;)
	{
		self waittill("vehicle_crash");
		if(!isdefined(self.parent_ent.crashed))
		{
			self.parent_ent.crashed = 1;
			var_00 = get_crashed_vehicle_index();
			level.traffic_crashed_vehicles[var_00] = self;
			self vehicledriveto(self.origin + anglestoright(self.angles) * 10000 + anglestoforward(self.angles) * 10000,0);
			self vehicle_setspeed(0,25,25);
			self.parent_ent thread safe_vehicle_delete();
			wait(0.2);
			self vehphys_crash(0);
			return;
		}
	}
}

//Function Number: 122
get_crashed_vehicle_index()
{
	var_00 = undefined;
	var_01 = undefined;
	var_02 = undefined;
	if(level.traffic_crashed_vehicles.size < 10)
	{
		return level.traffic_crashed_vehicles.size;
	}
	else
	{
		for(var_03 = 0;var_03 < level.traffic_crashed_vehicles.size;var_03++)
		{
			if(!isdefined(level.traffic_crashed_vehicles[var_03]))
			{
				return var_03;
			}

			var_04 = distance2dsquared(level.traffic_crashed_vehicles[var_03].origin,level.player.origin);
			if(!isdefined(var_00) || var_00 < var_04)
			{
				var_00 = var_04;
				var_01 = level.traffic_crashed_vehicles[var_03];
				var_02 = var_03;
			}
		}
	}

	var_01.parent_ent notify("reached_end_node");
	return var_02;
}

//Function Number: 123
safe_vehicle_delete()
{
	level endon("stop_traffic");
	self endon("death");
	self endon("reached_end_node");
	for(;;)
	{
		wait(0.05);
		if(!isdefined(self) || !isdefined(self.vehicle))
		{
			return;
		}

		if(!player_can_see_vehicle())
		{
			break;
		}
	}

	self notify("reached_end_node");
}

//Function Number: 124
force_vehicle_delete()
{
	var_00 = self.parent_ent;
	if(var_00 player_can_see_vehicle())
	{
		self dodamage(1000000000,self.origin);
		wait(0.3);
	}

	var_00 notify("reached_end_node");
}

//Function Number: 125
player_can_see_vehicle()
{
	return maps\_utility::players_within_distance(512,self.vehicle.origin) || maps\_utility::either_player_looking_at(self.vehicle.origin + (0,0,48),0.5,1);
}

//Function Number: 126
should_be_vehicle(param_00,param_01)
{
	var_02 = vectornormalize(param_00 - level.player.origin);
	var_03 = vectornormalize(anglestoforward(level.player getplayerangles()));
	var_04 = 0;
	if(vectordot(var_02,var_03) < 0)
	{
		var_05 = 1048576;
		var_04 = 16384;
	}
	else
	{
		var_05 = 16777216;
		var_04 = 262144;
	}

	if(isdefined(param_01) && param_01 != "script_model")
	{
		var_05 = var_05 + var_04;
	}

	if(distance2dsquared(param_00,level.player.origin) < var_05)
	{
		return 1;
	}

	var_05 = 1048576;
	if(isdefined(param_01) && param_01 != "script_model")
	{
		var_05 = var_05 + var_04;
	}

	foreach(var_07 in level.script_cars)
	{
		if(isdefined(var_07) && distance2dsquared(param_00,var_07.origin) < var_05)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 127
model_speed_to_mph(param_00)
{
	return param_00 / 63360 * 60 * 60;
}

//Function Number: 128
mph_to_model_speed(param_00)
{
	return param_00 * 63360 / 60 / 60;
}

//Function Number: 129
too_close_to_leader(param_00)
{
	var_01 = level.traffic_tune_min_follow_dist_sq;
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}

	if(isdefined(self.traffic_leader))
	{
		if(distance2dsquared(self.vehicle.origin,self.traffic_leader.vehicle.origin) < var_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 130
far_enough_from_leader(param_00)
{
	var_01 = level.traffic_tune_min_follow_dist_sq * 1.1;
	if(isdefined(param_00))
	{
		var_01 = param_00;
	}

	if(isdefined(self.traffic_leader))
	{
		if(distance2dsquared(self.vehicle.origin,self.traffic_leader.vehicle.origin) > var_01)
		{
			return 1;
		}
	}
	else
	{
		return 0;
	}

	return 0;
}

//Function Number: 131
adjust_model_speed_to_node(param_00)
{
	if(isdefined(self.parent_ent.traffic_old_speed))
	{
		self.parent_ent.traffic_old_speed = param_00.speed;
		return;
	}

	self.parent_ent.traffic_speed = param_00.speed;
}

//Function Number: 132
traffic_vehicle_lights_on(param_00)
{
	if(self.vehicle.classname == "script_model")
	{
		return;
	}

	foreach(var_02 in param_00)
	{
		self.vehicle maps\_vehicle::vehicle_single_light_on(var_02);
	}
}

//Function Number: 133
traffic_vehicle_lights_off(param_00)
{
	if(self.vehicle.classname == "script_model")
	{
		return;
	}

	foreach(var_02 in param_00)
	{
		self.vehicle maps\_vehicle::vehicle_single_light_off(var_02);
	}
}

//Function Number: 134
handle_wakeup_sphere_global()
{
	level.player endon("death");
	var_00 = squared(3900);
	var_01 = cos(60);
	var_02 = 195;
	var_03 = 10;
	for(;;)
	{
		var_04 = 0;
		foreach(var_06 in sortbydistance(vehicle_getarray(),level.player.origin))
		{
			if(isdefined(self.no_wakeup_physics_sphere))
			{
				continue;
			}

			var_07 = var_06.origin - level.player.origin;
			if(length2dsquared(var_07) > var_00)
			{
				break;
			}

			if(vectordot(anglestoforward(level.player getgunangles()),vectornormalize(var_07)) > var_01)
			{
				var_04++;
				wakeupphysicssphere(var_06.origin,var_02);
			}

			if(var_04 >= var_03)
			{
				break;
			}
		}

		wait 0.05;
	}
}

//Function Number: 135
detect_dropping()
{
	self endon("death");
	self endon("reached_end_node");
	for(;;)
	{
		var_00 = self.origin[2];
		wait(1);
		if(var_00 - self.origin[2] > 2000)
		{
			self notify("reached_end_node");
			return;
		}
	}
}

//Function Number: 136
detect_being_pushed(param_00)
{
	var_01 = 2;
	var_02 = self vehicle_getcurrentnode().lane_start_node;
	if(isdefined(var_02) && isdefined(var_02.vehicle_easy_crash_die) && var_02.vehicle_easy_crash_die)
	{
		var_01 = 0.6;
	}

	var_03 = 0;
	wait 0.05;
	var_04 = 0.05;
	if(level.currentgen)
	{
		var_04 = 0.2;
	}

	while(isdefined(self))
	{
		var_05 = self vehicle_getspeed() > 5 && !any_wheel_on_ground() || some_wheels_slipping();
		if(var_05)
		{
			var_03 = var_03 + 0.05;
		}
		else
		{
			var_03 = var_03 - 0.1;
		}

		if(self vehicle_getvelocity()[2] > 700)
		{
			var_03 = var_03 + 3;
		}

		var_03 = max(var_03,0);
		if(var_03 > var_01)
		{
			self [[ param_00 ]]();
			return;
		}

		wait(var_04);
	}
}

//Function Number: 137
some_wheels_slipping()
{
	var_00 = 0;
	foreach(var_02 in ["front_left","front_right","back_left","back_right"])
	{
		if(self iswheelslipping(var_02))
		{
			var_00++;
		}
	}

	return var_00 >= 3;
}

//Function Number: 138
any_wheel_on_ground()
{
	foreach(var_01 in ["front_left","front_right","back_left","back_right"])
	{
		if(self getwheelsurface(var_01) != "none")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 139
is_inside_radius_of_closest_point_of_segment(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(isdefined(param_00.target))
	{
		var_03 = getvehiclenode(param_00.target,"targetname");
	}
	else
	{
		var_03 = param_00;
	}

	if(distance2dsquared(param_00.origin,param_01) < param_02)
	{
		return 1;
	}

	if(distance2dsquared(var_03.origin,param_01) < param_02)
	{
		return 1;
	}

	var_04 = get_closest_point_from_segment_to_segment(param_00.origin,var_03.origin,param_01,param_01);
	var_05 = var_04[0];
	var_06 = var_04[1];
	var_07 = var_04[2];
	var_08 = var_05 < param_02;
	return var_08;
}

//Function Number: 140
get_goal_pos_on_segment(param_00,param_01,param_02,param_03)
{
	var_04 = param_02;
	var_05 = var_04 - param_00;
	var_06 = param_01 - param_00;
	var_07 = vectornormalize(var_06);
	var_08 = vectordot(var_05,var_07);
	var_09 = var_07 * var_08;
	var_0A = var_09 + var_07 * param_03;
	return var_0A;
}

//Function Number: 141
get_closest_point_from_segment_to_segment(param_00,param_01,param_02,param_03)
{
	var_04 = 0.001;
	var_05 = param_01 - param_00;
	var_06 = param_03 - param_02;
	var_07 = param_00 - param_02;
	var_08 = vectordot(var_05,var_05);
	var_09 = vectordot(var_06,var_06);
	var_0A = vectordot(var_06,var_07);
	var_0B = 0;
	if(var_08 <= var_04 && var_09 <= var_04)
	{
		var_0C = 0;
		var_0D = 0;
		var_0E = param_00;
		var_0F = param_02;
		return [vectordot(var_0E - var_0F,var_0E - var_0F),var_0E,var_0F];
	}

	if(var_0C <= var_08)
	{
		var_0C = 0;
		var_0D = var_0D / var_0C;
		var_0F = clamp(var_0F,0,1);
	}
	else
	{
		var_10 = vectordot(var_09,var_0B);
		if(var_0B <= var_06)
		{
			var_0F = 0;
			var_0E = clamp(-1 * var_10 / var_0A,0,1);
		}
		else
		{
			var_11 = vectordot(var_07,var_08);
			var_12 = var_0A * var_0B - var_11 * var_11;
			if(var_12 != 0)
			{
				var_0E = clamp(var_11 * var_0C - var_10 * var_0B / var_12,0,1);
			}
			else
			{
				var_0E = 0;
			}

			var_0F = var_11 * var_0E + var_0C / var_0B;
			if(var_0F < 0)
			{
				var_0F = 0;
				var_0E = clamp(-1 * var_10 / var_0A,0,1);
			}
			else if(var_0F > 1)
			{
				var_0F = 1;
				var_0E = clamp(var_11 - var_10 / var_0A,0,1);
			}
		}
	}

	var_0E = param_02 + var_07 * var_0E;
	var_0F = param_03 + var_07 * var_0E;
	return [vectordot(var_0E - var_0F,var_0E - var_0F),var_0E,var_0F];
}

//Function Number: 142
vectors_are_equal_2d(param_00,param_01)
{
	var_02 = 0.001;
	var_03 = param_01 - param_00;
	if(abs(var_03[0]) < var_02 && abs(var_03[1]) < var_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 143
mark_nodes_near_spawnnodes_and_startnodes(param_00)
{
	var_01 = 3600;
	var_02 = 25000000;
	var_03 = getvehiclenodearray(param_00,"targetname");
	var_04 = getentarray("script_vehicle","code_classname");
	var_05 = [];
	foreach(var_07 in var_04)
	{
		if(isdefined(var_07.spawnflags) && var_07.spawnflags == 2)
		{
			var_05[var_05.size] = var_07;
		}
	}

	var_09 = getallvehiclenodes();
	var_0A = [];
	foreach(var_07 in var_09)
	{
		if(isdefined(var_07.spawnflags) && var_07.spawnflags == 1 && var_07.targetname != param_00)
		{
			var_0A[var_0A.size] = var_07;
		}
	}

	foreach(var_0E in var_03)
	{
		var_0F = var_0E;
		for(;;)
		{
			if(!isdefined(var_0E))
			{
				break;
			}

			if(!isdefined(var_0E.target))
			{
				break;
			}

			foreach(var_11 in var_05)
			{
				if(distance2dsquared(var_0E.origin,var_11.origin) < var_02 && is_inside_radius_of_closest_point_of_segment(var_0E,var_11.origin,var_01))
				{
					var_0E.nospawn = var_11;
					var_0E = getvehiclenode(var_0E.target,"targetname");
					var_0E.nospawn = var_11;
					var_0F.nospawn = var_11;
				}
			}

			foreach(var_14 in var_0A)
			{
				if(distance2dsquared(var_0E.origin,var_14.origin) < var_02 && is_inside_radius_of_closest_point_of_segment(var_0E,var_14.origin,var_01))
				{
					var_0E.nospawn = var_14;
					var_0E = getvehiclenode(var_0E.target,"targetname");
					var_0E.nospawn = var_14;
					var_0F.nospawn = var_14;
				}
			}

			var_0F = var_0E;
			var_0E = getvehiclenode(var_0E.target,"targetname");
		}
	}
}

//Function Number: 144
drawnode(param_00)
{
	self endon("death");
}