/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_twar.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 162 ms
 * Timestamp: 10/27/2023 2:37:23 AM
*******************************************************************/

//Function Number: 1
main()
{
	level.bot_ignore_precalc_paths = 0;
	if(level.currentgen)
	{
		level.bot_ignore_precalc_paths = 1;
	}

	setup_callbacks();
	setup_bot_twar();
}

//Function Number: 2
setup_callbacks()
{
	level.bot_funcs["gametype_think"] = ::bot_twar_think;
	level.bot_funcs["should_start_cautious_approach"] = ::bot_twar_should_start_cautious_approach;
	if(!level.bot_ignore_precalc_paths)
	{
		level.bot_funcs["get_watch_node_chance"] = ::bot_twar_get_node_chance;
	}
}

//Function Number: 3
setup_bot_twar()
{
	maps\mp\bots\_bots_util::bot_waittill_bots_enabled();
	for(var_00 = 0;var_00 < level.twar_zones.size;var_00++)
	{
		level.twar_zones[var_00].script_label = "_" + var_00;
	}

	maps\mp\bots\_bots_gametype_common::bot_cache_entrances_to_gametype_array(level.twar_zones,"zone",level.bot_ignore_precalc_paths);
	var_01 = 55;
	var_02 = 0;
	foreach(var_04 in level.twar_zones)
	{
		if(!isdefined(var_04.nearest_node))
		{
			return;
		}

		var_04 thread monitor_twar_zone_control();
		var_05 = var_04.origin - (0,0,var_01) + var_04.origin + (0,0,level.zone_height) / 2;
		var_06 = level.zone_height + var_01 / 2;
		var_04.nodes = getnodesinradius(var_05,level.zone_radius,0,var_06);
		if(var_04.nodes.size < 6)
		{
			var_02++;
			if(var_02 == 1)
			{
				wait(5);
				continue;
			}

			wait(1);
		}
	}

	level.bot_gametype_precaching_done = 1;
}

//Function Number: 4
monitor_twar_zone_control()
{
	self notify("monitor_twar_zone_control");
	self endon("monitor_twar_zone_control");
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		wait(1);
		var_00 = self.owner;
		if(var_00 == "none" && level.twar_use_obj.userate > 0)
		{
			var_00 = level.twar_use_obj.claimteam;
		}

		if(var_00 != "none")
		{
			var_01 = getzonenearest(self.origin);
			if(isdefined(var_01))
			{
				botzonesetteam(var_01,var_00);
			}
		}
	}
}

//Function Number: 5
bot_twar_think()
{
	self notify("bot_twar_think");
	self endon("bot_twar_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("owner_disconnect");
	while(!isdefined(level.bot_gametype_precaching_done))
	{
		wait(0.05);
	}

	self botsetflag("separation",0);
	self botsetpathingstyle("beeline");
	self botsetflag("force_sprint",1);
	for(;;)
	{
		if(!bot_twar_is_capturing_zone(level.twar_use_obj.zone))
		{
			bot_twar_capture_zone(level.twar_use_obj.zone);
		}

		wait(0.05);
	}
}

//Function Number: 6
bot_twar_capture_zone(param_00)
{
	self.current_zone = param_00;
	var_01["entrance_points_index"] = bot_twar_get_zone_label(param_00);
	var_01["nearest_node_to_center"] = param_00.nearest_node;
	var_01["objective_radius"] = 500;
	maps\mp\bots\_bots_strategy::bot_capture_point(param_00.origin,level.zone_radius,var_01);
}

//Function Number: 7
bot_twar_is_capturing_zone(param_00)
{
	if(maps\mp\bots\_bots_util::bot_is_capturing())
	{
		if(self.current_zone == param_00)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 8
bot_twar_get_node_chance(param_00)
{
	var_01 = 0;
	var_02 = bot_twar_get_zone_label(level.twar_use_obj.zone);
	var_03 = bot_twar_get_zones_for_team(self.team);
	var_01 = 0;
	foreach(var_05 in var_03)
	{
		if(param_00 maps\mp\bots\_bots_util::node_is_on_path_from_labels(var_02,bot_twar_get_zone_label(var_05)))
		{
			var_01 = 1;
			break;
		}
	}

	if(var_01)
	{
		var_07 = bot_twar_get_zones_for_team(common_scripts\utility::get_enemy_team(self.team));
		foreach(var_09 in var_07)
		{
			if(param_00 maps\mp\bots\_bots_util::node_is_on_path_from_labels(var_02,bot_twar_get_zone_label(var_09)))
			{
				var_01 = 0;
				break;
			}
		}
	}

	if(var_01)
	{
		return 0.2;
	}

	return 1;
}

//Function Number: 9
bot_twar_get_zones_for_team(param_00)
{
	var_01 = [];
	foreach(var_03 in level.twar_zones)
	{
		if(var_03.owner == param_00)
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 10
bot_twar_get_zone_label(param_00)
{
	return "zone" + param_00.script_label;
}

//Function Number: 11
bot_twar_should_start_cautious_approach(param_00)
{
	return 0;
}