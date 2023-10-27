/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/_aerial_pathnodes.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 226 ms
 * Timestamp: 10/27/2023 2:07:54 AM
*******************************************************************/

//Function Number: 1
waittill_aerial_pathnodes_calculated()
{
	while(!isdefined(level.calculated_aerial_nodes_done) || !level.calculated_aerial_nodes_done)
	{
		wait(0.5);
	}
}

//Function Number: 2
get_aerial_offset()
{
	if(isdefined(level.aerial_pathnode_offset))
	{
		return (0,0,level.aerial_pathnode_offset);
	}

	return (0,0,500);
}

//Function Number: 3
get_group_connect_dist()
{
	if(isdefined(level.aerial_pathnode_group_connect_dist))
	{
		if(level.nextgen)
		{
		}
		else
		{
		}

		return level.aerial_pathnode_group_connect_dist;
	}

	return 250;
}

//Function Number: 4
node_is_valid__to_convert_to_aerial_pathnode(param_00)
{
	return (param_00.type == "Path" && nodeexposedtosky(param_00,1) && !param_00 nodeisdisconnected()) || isdefined(param_00.forceenableaerialnode) && param_00.forceenableaerialnode;
}

//Function Number: 5
calculate_aerial_pathnodes()
{
	if(isdefined(level.calculated_aerial_nodes_in_progress) || isdefined(level.calculated_aerial_nodes_done))
	{
		return;
	}

	var_00 = getdvar("mapname");
	if(var_00 == getdvar("virtualLobbyMap") || var_00 == "mp_character_room" || getdvarint("virtualLobbyActive") == 1)
	{
		return;
	}

	level.calculated_aerial_nodes_in_progress = 1;
	level.calculated_aerial_nodes_done = 0;
	wait(0.5);
	level.aerial_pathnodes = [];
	var_01 = getallnodes();
	foreach(var_03 in var_01)
	{
		if(node_is_valid__to_convert_to_aerial_pathnode(var_03))
		{
			level.aerial_pathnodes[level.aerial_pathnodes.size] = var_03;
			if(!isdefined(var_03.aerial_neighbors))
			{
				var_03.aerial_neighbors = [];
			}

			var_04 = getlinkednodes(var_03);
			foreach(var_06 in var_04)
			{
				if(node_is_valid__to_convert_to_aerial_pathnode(var_06) && !common_scripts\utility::array_contains(var_03.aerial_neighbors,var_06))
				{
					var_03.aerial_neighbors[var_03.aerial_neighbors.size] = var_06;
					if(!isdefined(var_06.aerial_neighbors))
					{
						var_06.aerial_neighbors = [];
					}

					if(!common_scripts\utility::array_contains(var_06.aerial_neighbors,var_03))
					{
						var_06.aerial_neighbors[var_06.aerial_neighbors.size] = var_03;
					}
				}
			}
		}
	}

	var_01 = undefined;
	wait(0.05);
	var_09 = divide_nodes_into_groups(level.aerial_pathnodes,1);
	var_0A = 3;
	if(!0)
	{
		var_0B = get_group_connect_dist();
		var_0C = [];
		var_0D = 0;
		for(var_0E = 0;var_0E < var_09.size;var_0E++)
		{
			if(!isdefined(var_0C[var_0E]))
			{
				var_0C[var_0E] = [];
			}

			foreach(var_03 in var_09[var_0E])
			{
				for(var_10 = var_0E + 1;var_10 < var_09.size;var_10++)
				{
					if(!isdefined(var_0C[var_0E][var_10]))
					{
						var_0C[var_0E][var_10] = [];
					}

					var_11 = [];
					foreach(var_13 in var_09[var_10])
					{
						var_14 = distance(var_03.origin,var_13.origin);
						var_15 = var_14 < var_0B;
						var_16 = 0;
						if(!var_15)
						{
							if(isdefined(level.aerial_pathnodes_force_connect))
							{
								foreach(var_18 in level.aerial_pathnodes_force_connect)
								{
									var_19 = squared(var_18.radius);
									if(distance2dsquared(var_18.origin,var_03.origin) < var_19 && distance2dsquared(var_18.origin,var_13.origin) < var_19)
									{
										var_16 = 1;
										break;
									}
								}
							}
						}

						var_1B = var_11.size < var_0A || var_14 < var_11[var_0A - 1][2];
						if(var_15 && var_1B)
						{
							if(var_11.size == var_0A)
							{
								var_11[var_0A - 1] = undefined;
							}

							var_11[var_11.size] = [var_03,var_13,var_14];
							var_11 = common_scripts\utility::array_sort_with_func(var_11,::is_pair_a_closer_than_pair_b);
							continue;
						}

						if(var_16)
						{
							var_0C[var_0E][var_10][var_0C[var_0E][var_10].size] = [var_03,var_13,-1];
						}
					}

					foreach(var_1E in var_11)
					{
						var_0C[var_0E][var_10][var_0C[var_0E][var_10].size] = var_1E;
					}
				}

				var_0D++;
				if(var_0D >= 50)
				{
					var_0D = 0;
					wait(0.05);
				}
			}
		}

		wait(0.05);
		var_21 = 0;
		for(var_0E = 0;var_0E < var_09.size;var_0E++)
		{
			for(var_10 = var_0E + 1;var_10 < var_09.size;var_10++)
			{
				var_21 = var_21 + var_0C[var_0E][var_10].size;
				var_0C[var_0E][var_10] = common_scripts\utility::array_sort_with_func(var_0C[var_0E][var_10],::is_pair_a_closer_than_pair_b,150);
				if(var_21 > 500)
				{
					wait(0.05);
					var_21 = 0;
				}
			}
		}

		wait(0.05);
		var_22 = get_aerial_offset();
		var_23 = 10;
		var_24 = 0;
		if(0)
		{
			level.added_aerial_links = [];
		}

		for(var_0E = 0;var_0E < var_09.size;var_0E++)
		{
			for(var_10 = var_0E + 1;var_10 < var_09.size;var_10++)
			{
				foreach(var_26 in var_0C[var_0E][var_10])
				{
					var_27 = var_26[0];
					var_28 = var_26[1];
					if(!node0_has_neighbor_connected_to_node1(var_27,var_28))
					{
						var_29 = num_node_connections_to_group(var_27,var_28.aerial_group);
						var_2A = num_node_connections_to_group(var_28,var_27.aerial_group);
						if(var_29 < var_0A && var_2A < var_0A)
						{
							var_2B = playerphysicstrace(var_27.origin + var_22,var_28.origin + var_22);
							var_24++;
							var_2C = distancesquared(var_2B,var_28.origin + var_22) < 1;
							if(!var_2C && var_26[2] == -1)
							{
								var_2C = bullettracepassed(var_27.origin + var_22,var_28.origin + var_22,0,undefined);
							}

							if(var_2C)
							{
								var_27.aerial_neighbors[var_27.aerial_neighbors.size] = var_28;
								var_28.aerial_neighbors[var_28.aerial_neighbors.size] = var_27;
								if(0)
								{
									level.added_aerial_links[level.added_aerial_links.size] = [var_27,var_28];
								}
							}

							if(var_24 % var_23 == 0)
							{
								wait(0.05);
							}
						}
					}
				}
			}
		}

		var_0C = undefined;
		var_09 = divide_nodes_into_groups(level.aerial_pathnodes);
		if(0)
		{
			var_09 = common_scripts\utility::array_sort_with_func(var_09,::is_group_a_larger_than_group_b);
			for(var_0E = 0;var_0E < var_09.size;var_0E++)
			{
				foreach(var_03 in var_09[var_0E])
				{
					var_03.aerial_group = var_0E;
				}
			}
		}
		else
		{
			foreach(var_03 in level.aerial_pathnodes)
			{
				var_03.aerial_group = undefined;
			}
		}

		var_32 = 0;
		for(var_0E = 0;var_0E < var_09.size;var_0E++)
		{
			var_32 = max(var_09[var_0E].size,var_32);
		}

		for(var_0E = 0;var_0E < var_09.size;var_0E++)
		{
			if(var_09[var_0E].size < 0.1 * var_32)
			{
				foreach(var_03 in var_09[var_0E])
				{
					level.aerial_pathnodes = common_scripts\utility::array_remove(level.aerial_pathnodes,var_03);
					foreach(var_06 in var_03.aerial_neighbors)
					{
						for(var_10 = 0;var_10 < var_06.aerial_neighbors.size;var_10++)
						{
							var_35 = var_06.aerial_neighbors[var_10];
							if(var_35 == var_03)
							{
								var_06.aerial_neighbors[var_10] = var_06.aerial_neighbors[var_06.aerial_neighbors.size - 1];
								var_06.aerial_neighbors[var_06.aerial_neighbors.size - 1] = undefined;
								var_10--;
							}
						}
					}

					var_03.aerial_neighbors = undefined;
				}
			}
		}
	}

	level.calculated_aerial_nodes_done = 1;
	level.calculated_aerial_nodes_in_progress = 0;
}

//Function Number: 6
is_group_a_larger_than_group_b(param_00,param_01)
{
	return param_00.size > param_01.size;
}

//Function Number: 7
is_pair_a_closer_than_pair_b(param_00,param_01)
{
	return param_00[2] < param_01[2];
}

//Function Number: 8
num_node_connections_to_group(param_00,param_01)
{
	var_02 = 0;
	foreach(var_04 in param_00.aerial_neighbors)
	{
		if(var_04.aerial_group == param_01)
		{
			var_02++;
		}
	}

	return var_02;
}

//Function Number: 9
node0_has_neighbor_connected_to_node1(param_00,param_01)
{
	foreach(var_03 in param_00.aerial_neighbors)
	{
		foreach(var_05 in var_03.aerial_neighbors)
		{
			if(var_05 == param_01)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 10
divide_nodes_into_groups(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	foreach(var_03 in param_00)
	{
		var_03.aerial_group = undefined;
	}

	var_05 = param_00;
	var_06 = [];
	while(var_05.size > 0)
	{
		var_07 = var_06.size;
		var_06[var_07] = [];
		var_05[0].aerial_group = -1;
		var_08 = [var_05[0]];
		var_09 = 0;
		while(var_08.size > 0)
		{
			var_0A = var_08[0];
			var_06[var_07][var_06[var_07].size] = var_0A;
			var_0A.aerial_group = var_07;
			var_08[0] = var_08[var_08.size - 1];
			var_08[var_08.size - 1] = undefined;
			foreach(var_0C in var_0A.aerial_neighbors)
			{
				if(!isdefined(var_0C.aerial_group))
				{
					var_0C.aerial_group = -1;
					var_08[var_08.size] = var_0C;
				}
			}

			for(var_0E = 0;var_0E < var_05.size;var_0E++)
			{
				if(var_05[var_0E] == var_0A)
				{
					var_05[var_0E] = var_05[var_05.size - 1];
					var_05[var_05.size - 1] = undefined;
					break;
				}
			}

			var_09++;
			if(var_09 > 100)
			{
				wait(0.05);
				var_09 = 0;
			}
		}

		if(var_06[var_07].size <= param_01)
		{
			var_06[var_07] = undefined;
			continue;
		}

		wait(0.05);
	}

	wait(0.05);
	return var_06;
}

//Function Number: 11
node_is_aerial(param_00)
{
	return isdefined(param_00.aerial_neighbors);
}

//Function Number: 12
get_ent_closest_aerial_node(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 1500;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	var_02 = getnodesinradiussorted(self.origin,param_00,param_01,get_aerial_offset()[2] * 2,"path");
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(node_is_aerial(var_02[var_03]))
		{
			return var_02[var_03];
		}
	}
}

//Function Number: 13
find_path_between_aerial_nodes(param_00,param_01)
{
	param_00.path_to_this_node = [];
	var_02 = [param_00];
	var_03 = [param_00];
	while(!isdefined(param_01.path_to_this_node))
	{
		var_04 = var_02[0];
		var_02 = common_scripts\utility::array_remove(var_02,var_04);
		foreach(var_06 in var_04.aerial_neighbors)
		{
			if(!isdefined(var_06.path_to_this_node))
			{
				var_06.path_to_this_node = common_scripts\utility::array_add(var_04.path_to_this_node,var_04);
				var_02[var_02.size] = var_06;
				var_03[var_03.size] = var_06;
			}
		}
	}

	var_08 = common_scripts\utility::array_add(param_01.path_to_this_node,param_01);
	foreach(var_0A in var_03)
	{
		var_0A.path_to_this_node = undefined;
	}

	return var_08;
}