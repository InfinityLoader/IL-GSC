/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_zombies_zone_manager.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 42
 * Decompile Time: 716 ms
 * Timestamp: 4/22/2024 2:14:47 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.zone_data = spawnstruct();
	level.zone_data.zones = [];
	level.zone_data.current_spawn_zones = [];
	level.zone_data.spawnfunc = ::calculaterandomspawnpoint;
}

//Function Number: 2
iszoneenabled(param_00)
{
	return isdefined(level.zone_data.zones) && isdefined(level.zone_data.zones[param_00]) && level.zone_data.zones[param_00].is_enabled;
}

//Function Number: 3
isplayerinzone(param_00)
{
	if(!iszoneenabled(param_00))
	{
		return 0;
	}

	var_01 = level.zone_data.zones[param_00];
	foreach(var_03 in level.players)
	{
		if(var_03.sessionstate == "spectator")
		{
			continue;
		}

		foreach(var_05 in var_01.volumes)
		{
			if(var_03 istouching(var_05))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 4
updateconnectiondistances()
{
	level endon("game_ended");
	level notify("updating_connection_distances");
	level endon("updating_connection_distances");
	level.zone_data.connectionmap = [];
	foreach(var_01 in level.zone_data.zones)
	{
		foreach(var_03 in level.zone_data.zones)
		{
			if(var_01.zone_name == var_03.zone_name)
			{
				continue;
			}

			if(isdefined(level.zone_data.connectionmap[var_01.zone_name]) && isdefined(level.zone_data.connectionmap[var_01.zone_name][var_03.zone_name]))
			{
				continue;
			}

			getzoneconnectionlength(var_01.zone_name,var_03.zone_name);
			wait 0.05;
		}
	}

	if(isdefined(level.zone_is_contaminated_func))
	{
		level.zone_data.infectedconnectionmap = [];
		foreach(var_01 in level.zone_data.zones)
		{
			foreach(var_03 in level.zone_data.zones)
			{
				if(var_01.zone_name == var_03.zone_name)
				{
					continue;
				}

				if(isdefined(level.zone_data.infectedconnectionmap[var_01.zone_name]) && isdefined(level.zone_data.infectedconnectionmap[var_01.zone_name][var_03.zone_name]))
				{
					continue;
				}

				getzoneinfectedconnectionlength(var_01.zone_name,var_03.zone_name);
				wait 0.05;
			}
		}
	}
}

//Function Number: 5
registerconnectiondistance(param_00,param_01,param_02)
{
	level.zone_data.connectionmap[param_00][param_01] = param_02;
	level.zone_data.connectionmap[param_01][param_00] = param_02;
}

//Function Number: 6
getzoneconnectionlength(param_00,param_01)
{
	if(param_00 == param_01)
	{
		return 0;
	}

	if(!isdefined(level.zone_data.connectionmap))
	{
		return -1;
	}

	if(isdefined(level.zone_data.connectionmap[param_00]) && isdefined(level.zone_data.connectionmap[param_00][param_01]))
	{
		return level.zone_data.connectionmap[param_00][param_01];
	}

	var_02[0]["zone"] = param_00;
	var_02[0]["distance"] = 0;
	while(var_02.size > 0)
	{
		var_03 = level.zone_data.zones[var_02[0]["zone"]];
		var_04 = var_02[0]["distance"];
		var_02 = maps\mp\zombies\_util::array_remove_index(var_02,0);
		var_05[var_03.zone_name] = 1;
		foreach(var_0E, var_07 in var_03.adjacent_zones)
		{
			if(isdefined(var_05[var_07.zone_name]))
			{
				continue;
			}

			if(var_07.is_connected)
			{
				var_08 = var_04 + 1;
				if(var_07.zone_name == param_01)
				{
					registerconnectiondistance(param_00,param_01,var_08);
					return var_08;
				}

				var_09 = -1;
				var_0A = -1;
				if(var_02.size == 0)
				{
					var_09 = 0;
				}

				for(var_0B = 0;var_0B < var_02.size;var_0B++)
				{
					var_0C = var_02[var_0B]["distance"] >= var_08;
					if(var_0C && var_09 < 0)
					{
						var_09 = var_0B;
					}

					if(var_02[var_0B]["zone"] == var_07.zone_name)
					{
						if(var_0C)
						{
							var_0A = var_0B;
						}

						break;
					}
				}

				if(var_0A >= 0)
				{
					var_02 = maps\mp\zombies\_util::array_remove_index(var_02,var_0A);
				}

				if(var_0B == var_02.size && var_09 < 0)
				{
					var_09 = var_02.size;
				}

				if(var_09 >= 0)
				{
					param_00["zone"] = var_07.zone_name;
					var_0C["distance"] = var_0E;
					param_01 = common_scripts\utility::array_insert(param_01,var_0C,var_08);
				}
			}
		}
	}

	return -1;
}

//Function Number: 7
registerinfectedconnectiondistance(param_00,param_01,param_02)
{
	level.zone_data.infectedconnectionmap[param_00][param_01] = param_02;
	level.zone_data.infectedconnectionmap[param_01][param_00] = param_02;
}

//Function Number: 8
getzoneinfectedconnectionlength(param_00,param_01)
{
	if(param_00 == param_01)
	{
		return 0;
	}

	if(!isdefined(level.zone_data.connectionmap))
	{
		return -1;
	}

	if(isdefined(level.zone_data.infectedconnectionmap[param_00]) && isdefined(level.zone_data.infectedconnectionmap[param_00][param_01]))
	{
		return level.zone_data.infectedconnectionmap[param_00][param_01];
	}

	var_02[0]["zone"] = param_00;
	var_02[0]["distance"] = 0;
	while(var_02.size > 0)
	{
		var_03 = level.zone_data.zones[var_02[0]["zone"]];
		var_04 = var_02[0]["distance"];
		var_02 = maps\mp\zombies\_util::array_remove_index(var_02,0);
		var_05[var_03.zone_name] = 1;
		foreach(var_0E, var_07 in var_03.adjacent_zones)
		{
			if(isdefined(var_05[var_07.zone_name]))
			{
				continue;
			}

			if([[ level.zone_is_contaminated_func ]](var_07.zone_name))
			{
				continue;
			}

			if(var_07.is_connected)
			{
				var_08 = var_04 + 1;
				if(var_07.zone_name == param_01)
				{
					registerinfectedconnectiondistance(param_00,param_01,var_08);
					return var_08;
				}

				var_09 = -1;
				var_0A = -1;
				if(var_02.size == 0)
				{
					var_09 = 0;
				}

				for(var_0B = 0;var_0B < var_02.size;var_0B++)
				{
					var_0C = var_02[var_0B]["distance"] >= var_08;
					if(var_0C && var_09 < 0)
					{
						var_09 = var_0B;
					}

					if(var_02[var_0B]["zone"] == var_07.zone_name)
					{
						if(var_0C)
						{
							var_0A = var_0B;
						}

						break;
					}
				}

				if(var_0A >= 0)
				{
					var_02 = maps\mp\zombies\_util::array_remove_index(var_02,var_0A);
				}

				if(var_0B == var_02.size && var_09 < 0)
				{
					var_09 = var_02.size;
				}

				if(var_09 >= 0)
				{
					param_00["zone"] = var_07.zone_name;
					var_0C["distance"] = var_0E;
					param_01 = common_scripts\utility::array_insert(param_01,var_0C,var_08);
				}
			}
		}
	}

	return -1;
}

//Function Number: 9
getplayerzonestruct()
{
	if(self.sessionstate == "spectator" || self.sessionstate == "intermission")
	{
		return undefined;
	}

	foreach(var_01 in level.zone_data.zones)
	{
		foreach(var_03 in var_01.volumes)
		{
			if(self istouching(var_03))
			{
				return var_01;
			}
		}
	}

	return undefined;
}

//Function Number: 10
getplayerzone()
{
	if(self.sessionstate == "spectator" || self.sessionstate == "intermission")
	{
		return undefined;
	}

	foreach(var_05, var_01 in level.zone_data.zones)
	{
		foreach(var_03 in var_01.volumes)
		{
			if(self istouching(var_03))
			{
				return var_05;
			}
		}
	}

	return undefined;
}

//Function Number: 11
getcurrentplayeroccupiedzones()
{
	var_00 = [];
	foreach(var_02 in level.zone_data.zones)
	{
		if(isplayerinzone(var_02.zone_name))
		{
			var_00[var_00.size] = var_02.zone_name;
		}
	}

	return var_00;
}

//Function Number: 12
getcurrentplayeroccupiedzonestructs()
{
	var_00 = [];
	foreach(var_02 in level.zone_data.zones)
	{
		if(isplayerinzone(var_02.zone_name))
		{
			var_00[var_00.size] = var_02;
		}
	}

	return var_00;
}

//Function Number: 13
iszombieinanyzone(param_00)
{
	foreach(var_02 in level.zone_data.zones)
	{
		foreach(var_04 in var_02.volumes)
		{
			if(param_00 istouching(var_04))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 14
getzombiezone()
{
	foreach(var_05, var_01 in level.zone_data.zones)
	{
		foreach(var_03 in var_01.volumes)
		{
			if(self istouching(var_03))
			{
				return var_05;
			}
		}
	}

	return undefined;
}

//Function Number: 15
iszombieinenabledzone(param_00)
{
	foreach(var_02 in level.zone_data.zones)
	{
		if(!iszoneenabled(var_02.zone_name))
		{
			continue;
		}

		foreach(var_04 in var_02.volumes)
		{
			if(param_00 istouching(var_04))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 16
ispathnodeinanyzone(param_00)
{
	foreach(var_02 in level.zone_data.zones)
	{
		foreach(var_04 in var_02.volumes)
		{
			if(ispointinvolume(param_00.origin,var_04))
			{
				return 1;
			}

			if(ispointinvolume(param_00.origin + (0,0,20),var_04))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 17
ispathnodeinenabledzone(param_00)
{
	foreach(var_02 in level.zone_data.zones)
	{
		if(!iszoneenabled(var_02.zone_name))
		{
			continue;
		}

		foreach(var_04 in var_02.volumes)
		{
			if(ispointinvolume(param_00.origin,var_04))
			{
				return 1;
			}

			if(ispointinvolume(param_00.origin + (0,0,20),var_04))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 18
ispointinanyzone(param_00,param_01)
{
	var_02 = ispointinanyzonereturn(param_00,param_01);
	return isdefined(var_02);
}

//Function Number: 19
ispointinanyzonereturn(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	foreach(var_03 in level.zone_data.zones)
	{
		if(param_01 && !iszoneenabled(var_03.zone_name))
		{
			continue;
		}

		foreach(var_05 in var_03.volumes)
		{
			if(ispointinvolume(param_00,var_05))
			{
				return var_03.zone_name;
			}
		}
	}
}

//Function Number: 20
getlocationzone(param_00)
{
	foreach(var_02 in level.zone_data.zones)
	{
		foreach(var_04 in var_02.volumes)
		{
			if(ispointinvolume(param_00,var_04))
			{
				return var_02.zone_name;
			}

			if(ispointinvolume(param_00 + (0,0,20),var_04))
			{
				return var_02.zone_name;
			}
		}
	}

	return undefined;
}

//Function Number: 21
anyzombiesinzone(param_00)
{
	var_01 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
	if(var_01.size == 0)
	{
		return 0;
	}

	var_02 = level.zone_data.zones[param_00];
	foreach(var_04 in var_01)
	{
		foreach(var_06 in var_02.volumes)
		{
			if(var_04 istouching(var_06))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 22
getnumberofplayersinzone(param_00)
{
	if(!iszoneenabled(param_00))
	{
		return 0;
	}

	var_01 = level.zone_data.zones[param_00];
	var_02 = 0;
	foreach(var_04 in level.players)
	{
		if(var_04.sessionstate == "spectator")
		{
			continue;
		}

		foreach(var_06 in var_01.volumes)
		{
			if(var_04 istouching(var_06))
			{
				var_02++;
				break;
			}
		}
	}

	return var_02;
}

//Function Number: 23
getplayersinzone(param_00,param_01)
{
	var_02 = [];
	if(!iszoneenabled(param_00))
	{
		return var_02;
	}

	var_03 = level.zone_data.zones[param_00];
	var_04 = var_03.volumes;
	if(param_01)
	{
		foreach(var_06 in var_03.adjacent_zones)
		{
			var_07 = level.zone_data.zones[var_06.zone_name];
			if(iszoneenabled(var_07.zone_name))
			{
				var_04 = common_scripts\utility::array_combine(var_04,var_07.volumes);
			}
		}
	}

	foreach(var_0A in level.players)
	{
		if(var_0A.sessionstate == "spectator")
		{
			continue;
		}

		foreach(var_0C in var_04)
		{
			if(var_0A istouching(var_0C))
			{
				var_02[var_02.size] = var_0A;
			}
		}
	}

	return var_02;
}

//Function Number: 24
playerisinzone(param_00,param_01)
{
	if(!iszoneenabled(param_01))
	{
		return 0;
	}

	if(param_00.sessionstate == "spectator")
	{
		return 0;
	}

	var_02 = level.zone_data.zones[param_01];
	var_03 = var_02.volumes;
	foreach(var_05 in var_03)
	{
		if(param_00 istouching(var_05))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 25
getnumberofzombiesinzone(param_00)
{
	var_01 = maps\mp\agents\_agent_utility::getactiveagentsoftype("all");
	if(var_01.size == 0)
	{
		return 0;
	}

	var_02 = level.zone_data.zones[param_00];
	var_03 = 0;
	foreach(var_05 in var_01)
	{
		if(var_05.team != level.enemyteam)
		{
			continue;
		}

		foreach(var_07 in var_02.volumes)
		{
			if(var_05 istouching(var_07))
			{
				var_03++;
				break;
			}
		}
	}

	return var_03;
}

//Function Number: 26
initializezone(param_00,param_01)
{
	if(isdefined(level.zone_data.zones[param_00]))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	var_02 = spawnstruct();
	var_02.adjacent_zones = [];
	var_02.is_occupied = 0;
	var_02.is_enabled = param_01;
	var_02.is_active = 0;
	var_02.zone_name = param_00;
	var_02.volumes = [];
	var_03 = getentarray(param_00,"targetname");
	foreach(var_05 in var_03)
	{
		if(var_05.classname == "info_volume")
		{
			var_02.volumes[var_02.volumes.size] = var_05;
		}
	}

	common_scripts\utility::flag_init(var_02.zone_name);
	if(param_01)
	{
		common_scripts\utility::flag_set(var_02.zone_name);
	}

	level.zone_data.zones[param_00] = var_02;
	var_02.power_switch = getpowerswitchinzone(param_00);
	var_07 = getspawnersinzone(param_00);
	var_02.zombie_spawners = filterspawnersfromlistbytype(var_07,"zombie_spawner");
	if(!isdefined(level.zombies_spawners_zombie))
	{
		level.zombies_spawners_zombie = [];
	}

	level.zombies_spawners_zombie = common_scripts\utility::array_combine(level.zombies_spawners_zombie,var_02.zombie_spawners);
	if(maps\mp\zombies\_util::civiliansareenabled())
	{
		var_02.civilian_extracts = filterspawnersfromlistbytype(var_07,"civilian_extract");
		var_02.civilian_spawners = filterspawnersfromlistbytype(var_07,"civilian_spawner");
		if(!isdefined(level.zombies_spawners_civilians))
		{
			level.zombies_spawners_civilians = [];
		}

		level.zombies_spawners_civilians = common_scripts\utility::array_combine(level.zombies_spawners_civilians,var_02.civilian_spawners);
	}
}

//Function Number: 27
getpowerswitchinzone(param_00)
{
	var_01 = common_scripts\utility::getstructarray("power_switch","targetname");
	foreach(var_03 in var_01)
	{
		if(isswitchinzonevolumes(var_03,level.zone_data.zones[param_00].volumes))
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 28
isswitchinzonevolumes(param_00,param_01)
{
	foreach(var_03 in param_01)
	{
		if(ispointinvolume(param_00.origin,var_03))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 29
getspawnersinzone(param_00)
{
	var_01 = [];
	foreach(var_03 in level.zone_data.zones[param_00].volumes)
	{
		if(!isdefined(var_03.target))
		{
			continue;
		}

		var_04 = common_scripts\utility::getstructarray(var_03.target,"targetname");
		foreach(var_06 in var_04)
		{
			var_06.zone_name = param_00;
			if(!common_scripts\utility::array_contains(var_01,var_06))
			{
				var_01[var_01.size] = var_06;
			}
		}
	}

	return var_01;
}

//Function Number: 30
filterspawnersfromlistbytype(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(!isdefined(var_04.script_noteworthy))
		{
			continue;
		}

		if(var_04.script_noteworthy != param_01)
		{
			continue;
		}

		var_02[var_02.size] = var_04;
	}

	return var_02;
}

//Function Number: 31
addadjacentzone(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(level.flag[param_02]))
	{
		common_scripts\utility::flag_init(param_02);
	}

	makezoneadjacent(param_00,param_01,param_02,0);
	makezoneadjacent(param_01,param_00,param_02,param_03);
}

//Function Number: 32
makezoneadjacent(param_00,param_01,param_02,param_03)
{
	var_04 = level.zone_data.zones[param_00];
	if(!isdefined(var_04.adjacent_zones[param_01]))
	{
		var_05 = spawnstruct();
		var_05.zone_name = param_01;
		var_05.flags[0] = param_02;
		var_05.is_connected = 0;
		var_05.oneway = param_03;
		var_04.adjacent_zones[param_01] = var_05;
		return;
	}

	var_06 = var_04.adjacent_zones[param_01];
	var_06.flags[var_06.flags.size] = param_02;
}

//Function Number: 33
activate(param_00)
{
	if(isdefined(param_00))
	{
		level.zone_data.spawnfunc = param_00;
	}

	foreach(var_02 in level.zone_data.zones)
	{
		foreach(var_05, var_04 in var_02.adjacent_zones)
		{
			level thread zonewaitforflags(var_02,var_05);
		}
	}

	level thread monitorspawnpointupdate();
}

//Function Number: 34
monitorspawnpointupdate()
{
	level endon("game_ended");
	var_00 = 1;
	for(;;)
	{
		level.zone_data.spawn_points_update_requested = 1;
		while(level.zone_data.spawn_points_update_requested)
		{
			wait 0.05;
		}

		wait(var_00);
	}
}

//Function Number: 35
zonewaitforflags(param_00,param_01)
{
	level endon("game_ended");
	foreach(var_03 in param_00.adjacent_zones[param_01].flags)
	{
		level thread zonewaitforspecificflag(param_00,var_03,param_01);
	}
}

//Function Number: 36
zonewaitforspecificflag(param_00,param_01,param_02)
{
	level endon("game_ended");
	common_scripts\utility::flag_wait(param_01);
	var_03 = level.zone_data.zones[param_02];
	var_03.is_enabled = 1;
	common_scripts\utility::flag_set(param_00.zone_name);
	param_00.adjacent_zones[param_02].is_connected = 1;
	level thread updateconnectiondistances();
}

//Function Number: 37
getcivilianpoint(param_00,param_01)
{
	var_02 = [];
	var_03 = 0;
	var_04 = getcurrentplayeroccupiedzones();
	for(var_05 = var_04.size;var_05 > 0;var_05--)
	{
		var_06 = var_04[var_03];
		var_07 = level.zone_data.zones[var_06];
		if(param_00)
		{
			var_02 = common_scripts\utility::array_combine(var_02,var_07.civilian_spawners);
		}
		else
		{
			var_02 = common_scripts\utility::array_combine(var_02,var_07.civilian_extracts);
			foreach(var_09 in var_02)
			{
				if(!isdefined(var_09.script_parameters))
				{
					var_02 = common_scripts\utility::array_remove(var_02,var_09);
				}
			}
		}

		if(iszoneenabled(var_07.zone_name))
		{
			foreach(var_0C in var_07.adjacent_zones)
			{
				if(!iszoneenabled(var_0C.zone_name))
				{
					if(!param_00)
					{
						continue;
					}

					if(var_0C.oneway)
					{
						continue;
					}
				}

				if(!common_scripts\utility::array_contains(var_04,var_0C.zone_name))
				{
					var_04[var_04.size] = var_0C.zone_name;
					var_05++;
				}
			}
		}

		var_03++;
	}

	var_02 = sortbydistance(var_02,param_01);
	for(var_0E = var_02.size - 1;var_0E >= 0;var_0E--)
	{
		if(!isdefined(var_02[var_0E].hasbeenused))
		{
			var_02[var_0E].hasbeenused = 1;
			return var_02[var_0E];
		}
	}

	var_02[var_02.size - 1].hasbeenused = 1;
	return var_02[var_02.size - 1];
}

//Function Number: 38
getspawnpoint(param_00,param_01)
{
	if(!isdefined(level.zone_data))
	{
		return undefined;
	}

	if(level.zone_data.spawn_points_update_requested)
	{
		level.zone_data.spawn_points_update_requested = 0;
		updatespawnpoints();
	}

	return [[ level.zone_data.spawnfunc ]](param_00,param_01);
}

//Function Number: 39
updatespawnpoints()
{
	var_00 = [];
	var_01 = [];
	foreach(var_03 in level.zone_data.zones)
	{
		if(!isdefined(var_00[var_03.zone_name]))
		{
			var_03.is_active = 0;
		}

		if(!var_03.is_enabled)
		{
			continue;
		}

		if(!isplayerinzone(var_03.zone_name))
		{
			continue;
		}

		if(!isdefined(var_03.disablespawns))
		{
			var_01[var_01.size] = var_03.zone_name;
		}

		var_03.is_active = 1;
		var_00[var_03.zone_name] = 1;
		foreach(var_05 in var_03.adjacent_zones)
		{
			if(!var_05.is_connected || isdefined(var_00[var_05.zone_name]))
			{
				continue;
			}

			var_06 = level.zone_data.zones[var_05.zone_name];
			if(!var_06.is_enabled)
			{
				continue;
			}

			var_01[var_01.size] = var_05.zone_name;
			var_00[var_05.zone_name] = 1;
			var_06.is_active = 1;
		}
	}

	level.zone_data.current_spawn_zones = var_01;
}

//Function Number: 40
calculaterandomspawnpoint(param_00,param_01)
{
	if(isdefined(level.randomspawnpointoverride) && isdefined(level.randomspawnpointoverride[param_00]))
	{
		return [[ level.randomspawnpointoverride[param_00] ]]();
	}

	if(level.zone_data.current_spawn_zones.size == 0)
	{
		return undefined;
	}

	var_02 = level.zone_data.current_spawn_zones;
	var_03 = undefined;
	for(var_04 = [];var_02.size > 0;var_04 = [])
	{
		var_05 = randomint(var_02.size);
		var_06 = level.zone_data.zones[var_02[var_05]];
		var_02 = maps\mp\zombies\_util::array_remove_index(var_02,var_05);
		foreach(var_08 in var_06.zombie_spawners)
		{
			if(var_08 spawnercanbeusedfor(param_00,param_01))
			{
				var_04[var_04.size] = var_08;
			}
		}

		if(var_04.size > 0)
		{
			break;
		}
	}

	if(var_04.size == 0)
	{
		var_0A = "";
		foreach(var_06 in level.zone_data.current_spawn_zones)
		{
			var_0A = var_0A + var_06 + " ";
		}

		var_05 = randomint(level.zone_data.current_spawn_zones.size);
		var_0D = level.zone_data.current_spawn_zones[var_05];
		var_03 = common_scripts\utility::random(var_0D.zombie_spawners);
	}
	else
	{
		var_03 = common_scripts\utility::random(var_04);
	}

	return var_03;
}

//Function Number: 41
calculateweightedspawnpoint(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in level.zone_data.current_spawn_zones)
	{
		var_05 = level.zone_data.zones[var_04];
		var_02 = common_scripts\utility::array_combine(var_02,var_05.zombie_spawners);
	}

	var_07 = maps\mp\zombies\_zombies_spawnscoring::getzombiesspawnpoint_aizombies(var_02,param_00,param_01);
	var_07.lastspawntime = gettime();
	return var_07;
}

//Function Number: 42
spawnercanbeusedfor(param_00,param_01)
{
	if(isdefined(self.script_parameters))
	{
		var_02 = strtok(self.script_parameters," ,");
		var_03 = 0;
		var_04 = 0;
		foreach(var_06 in var_02)
		{
			if(var_06 == param_00)
			{
				var_03 = 1;
			}

			if(var_06 == "exclusive")
			{
				var_04 = 1;
			}
		}

		if(!var_03 && var_04 || param_01)
		{
			return 0;
		}
	}
	else if(param_01)
	{
		return 0;
	}

	return 1;
}