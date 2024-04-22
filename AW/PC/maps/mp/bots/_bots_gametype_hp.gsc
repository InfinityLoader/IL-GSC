/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\bots\_bots_gametype_hp.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 238 ms
 * Timestamp: 4/22/2024 2:08:41 AM
*******************************************************************/

//Function Number: 1
main()
{
	setup_callbacks();
	setup_bot_hp();
}

//Function Number: 2
setup_callbacks()
{
	level.bot_funcs["gametype_think"] = ::bot_hp_think;
	level.bot_funcs["should_start_cautious_approach"] = ::should_start_cautious_approach_hp;
}

//Function Number: 3
setup_bot_hp()
{
	maps\mp\bots\_bots_util::bot_waittill_bots_enabled();
	for(var_00 = 0;var_00 < level.all_hp_zones.size;var_00++)
	{
		var_01 = level.all_hp_zones[var_00];
		var_01.script_label = "zone_" + var_00;
		var_01 thread monitor_zone_control();
		var_02 = 0;
		if(isdefined(var_01.trig.trigger_off) && var_01.trig.trigger_off)
		{
			var_01.trig common_scripts\utility::trigger_on();
			var_02 = 1;
		}

		var_01.nodes = getnodesintrigger(var_01.trig);
		maps\mp\bots\_bots_gametype_common::bot_add_missing_nodes(var_01,var_01.trig);
		if(var_02)
		{
			var_01.trig common_scripts\utility::trigger_off();
		}
	}

	bot_cache_entrances_to_hardpoints(1);
	level.bot_hp_allow_predictive_capping = 1;
	level.bot_gametype_precaching_done = 1;
	thread bot_cache_entrances_to_hardpoints(0);
}

//Function Number: 4
bot_cache_entrances_to_hardpoints(param_00)
{
	var_01 = [];
	var_02 = [];
	var_03 = 0;
	foreach(var_05 in level.all_hp_zones)
	{
		if((param_00 && var_05 != level.zone) || !param_00 && var_05 == level.zone)
		{
			continue;
		}

		var_06 = 0;
		var_05.entrance_indices = [];
		var_05.zone_bounds = calculate_zone_node_extents(var_05);
		var_05.center_node = zone_get_node_nearest_2d_bounds(var_05,0,0);
		var_07 = [(0,0,0),(1,1,0),(1,-1,0),(-1,1,0),(-1,-1,0)];
		foreach(var_09 in var_07)
		{
			var_0A = zone_get_node_nearest_2d_bounds(var_05,var_09[0],var_09[1]);
			var_01[var_03] = var_0A.origin;
			var_0B = var_05.script_label + "_" + var_06;
			var_02[var_03] = var_0B;
			var_05.entrance_indices[var_05.entrance_indices.size] = var_0B;
			var_03++;
			var_06++;
		}
	}

	maps\mp\bots\_bots_gametype_common::bot_cache_entrances(var_01,var_02,1);
}

//Function Number: 5
calculate_zone_node_extents(param_00)
{
	var_01 = spawnstruct();
	var_01.min_pt = (999999,999999,999999);
	var_01.max_pt = (-999999,-999999,-999999);
	foreach(var_03 in param_00.nodes)
	{
		var_01.min_pt = (min(var_03.origin[0],var_01.min_pt[0]),min(var_03.origin[1],var_01.min_pt[1]),min(var_03.origin[2],var_01.min_pt[2]));
		var_01.max_pt = (max(var_03.origin[0],var_01.max_pt[0]),max(var_03.origin[1],var_01.max_pt[1]),max(var_03.origin[2],var_01.max_pt[2]));
	}

	var_01.center = (var_01.min_pt[0] + var_01.max_pt[0] / 2,var_01.min_pt[1] + var_01.max_pt[1] / 2,var_01.min_pt[2] + var_01.max_pt[2] / 2);
	var_01.half_size = (var_01.max_pt[0] - var_01.center[0],var_01.max_pt[1] - var_01.center[1],var_01.max_pt[2] - var_01.center[2]);
	var_01.radius = max(var_01.half_size[0],var_01.half_size[1]);
	return var_01;
}

//Function Number: 6
zone_get_node_nearest_2d_bounds(param_00,param_01,param_02)
{
	var_03 = (param_00.zone_bounds.center[0] + param_01 * param_00.zone_bounds.half_size[0],param_00.zone_bounds.center[1] + param_02 * param_00.zone_bounds.half_size[1],0);
	var_04 = undefined;
	var_05 = 9999999;
	foreach(var_07 in param_00.nodes)
	{
		var_08 = distance2dsquared(var_07.origin,var_03);
		if(var_08 < var_05)
		{
			var_05 = var_08;
			var_04 = var_07;
		}
	}

	return var_04;
}

//Function Number: 7
monitor_zone_control()
{
	self notify("monitor_zone_control");
	self endon("monitor_zone_control");
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		var_00 = self.gameobject maps\mp\gametypes\_gameobjects::getownerteam();
		if(var_00 != "neutral" && var_00 != "none")
		{
			var_01 = getzonenearest(self.origin);
			if(isdefined(var_01))
			{
				botzonesetteam(var_01,var_00);
			}
		}

		wait(1);
	}
}

//Function Number: 8
bot_hp_think()
{
	self notify("bot_hp_think");
	self endon("bot_hp_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(!isdefined(level.bot_gametype_precaching_done))
	{
		wait(0.05);
	}

	self botsetflag("separation",0);
	self botsetflag("grenade_objectives",1);
	var_00 = undefined;
	var_01 = level.zone;
	for(;;)
	{
		wait(0.05);
		if(self.health <= 0)
		{
			continue;
		}

		if(var_01 != level.zone)
		{
			var_00 = undefined;
			var_01 = level.zone;
		}

		if(!isdefined(var_00) && level.randomzonespawn == 0 && level.bot_hp_allow_predictive_capping)
		{
			var_02 = level.zonemovetime - gettime();
			if(var_02 > 0 && var_02 < 10000)
			{
				var_03 = level.zone.gameobject maps\mp\gametypes\_gameobjects::getownerteam() == self.team;
				if(!var_03)
				{
					var_04 = level.zone.zone_bounds.radius * 6;
					if(var_02 < 5000)
					{
						var_04 = level.zone.zone_bounds.radius * 3;
					}

					var_05 = distance(level.zone.zone_bounds.center,self.origin);
					if(var_05 > var_04)
					{
						var_00 = bot_should_cap_next_zone();
					}
				}
				else
				{
					var_06 = maps\mp\bots\_bots_util::bot_get_max_players_on_team(self.team);
					var_07 = ceil(var_06 / 2);
					if(var_02 < 5000)
					{
						var_07 = ceil(var_06 / 3);
					}

					var_08 = bot_get_num_teammates_capturing_zone(level.zone);
					if(var_08 + 1 > var_07)
					{
						var_00 = bot_should_cap_next_zone();
					}
				}
			}
		}

		var_09 = level.zone;
		if(isdefined(var_00) && var_00)
		{
			var_09 = level.zones[level.prevzoneindex + 1 % level.zones.size];
		}

		if(!bot_is_capturing_zone(var_09))
		{
			bot_capture_hp_zone(var_09);
		}
	}
}

//Function Number: 9
bot_should_cap_next_zone()
{
	if(level.randomzonespawn)
	{
		return 0;
	}

	var_00 = self botgetdifficultysetting("strategyLevel");
	var_01 = 0;
	if(var_00 == 1)
	{
		var_01 = 0.1;
	}
	else if(var_00 == 2)
	{
		var_01 = 0.5;
	}
	else if(var_00 == 3)
	{
		var_01 = 0.8;
	}

	return randomfloat(1) < var_01;
}

//Function Number: 10
bot_get_num_teammates_capturing_zone(param_00)
{
	return bot_get_teammates_capturing_zone(param_00).size;
}

//Function Number: 11
bot_get_teammates_capturing_zone(param_00)
{
	var_01 = [];
	foreach(var_03 in level.participants)
	{
		if(var_03 != self && maps\mp\_utility::isteamparticipant(var_03) && isalliedsentient(self,var_03))
		{
			if(var_03 istouching(level.zone.trig))
			{
				if(!isai(var_03) || var_03 bot_is_capturing_zone(param_00))
				{
					var_01[var_01.size] = var_03;
				}
			}
		}
	}

	return var_01;
}

//Function Number: 12
bot_is_capturing_zone(param_00)
{
	if(!maps\mp\bots\_bots_util::bot_is_capturing())
	{
		return 0;
	}

	return self.current_zone == param_00;
}

//Function Number: 13
bot_capture_hp_zone(param_00)
{
	self.current_zone = param_00;
	var_01["entrance_points_index"] = param_00.entrance_indices;
	var_01["override_origin_node"] = param_00.center_node;
	maps\mp\bots\_bots_strategy::bot_capture_zone(param_00.origin,param_00.nodes,param_00.trig,var_01);
}

//Function Number: 14
should_start_cautious_approach_hp(param_00)
{
	if(param_00)
	{
		var_01 = level.zone.gameobject maps\mp\gametypes\_gameobjects::getownerteam();
		if(var_01 == "neutral" || var_01 == self.team)
		{
			return 0;
		}
	}

	return maps\mp\bots\_bots_strategy::should_start_cautious_approach_default(param_00);
}