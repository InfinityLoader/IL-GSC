/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_koth.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 174 ms
 * Timestamp: 10/27/2023 2:37:17 AM
*******************************************************************/

//Function Number: 1
main()
{
	setup_callbacks();
	bot_koth_start();
}

//Function Number: 2
bot_koth_start()
{
	setup_bot_koth();
}

//Function Number: 3
setup_callbacks()
{
	level.bot_funcs["gametype_think"] = ::bot_koth_think;
	level.bot_funcs["should_start_cautious_approach"] = ::should_start_cautious_approach_koth;
}

//Function Number: 4
setup_bot_koth()
{
	maps\mp\bots\_bots_util::bot_waittill_bots_enabled();
	var_00 = 0;
	for(var_01 = 0;var_01 < level.radios.size;var_01++)
	{
		var_02 = level.radios[var_01];
		var_02.script_label = "radio_" + var_01;
		var_02 thread maps\mp\bots\_bots_gametype_common::monitor_zone_control();
		var_03 = 0;
		if(isdefined(var_02.trig.trigger_off) && var_02.trig.trigger_off)
		{
			var_02.trig common_scripts\utility::trigger_on();
			var_03 = 1;
		}

		var_04 = 0;
		if(!var_02.visible)
		{
			var_02 maps\mp\gametypes\koth::makeradiovisible();
			var_04 = 1;
		}

		var_02.nodes = maps\mp\bots\_bots_gametype_common::bot_get_valid_nodes_in_trigger(var_02.trig);
		if(var_03)
		{
			var_02.trig common_scripts\utility::trigger_off();
		}

		if(var_04)
		{
			var_02 maps\mp\gametypes\koth::makeradioinvisible();
		}
	}

	level.bot_set_zone_nodes = 1;
	if(!var_00)
	{
		var_05 = find_current_radio();
		if(!isdefined(var_05))
		{
			var_05 = common_scripts\utility::random(level.radios);
		}

		maps\mp\bots\_bots_gametype_common::bot_cache_entrances_to_zones([var_05]);
		level.bot_gametype_radios_precached[var_05 getentitynumber()] = 1;
		level.bot_gametype_precaching_done = 1;
		thread bot_cache_entrances_to_other_radios(var_05);
	}
}

//Function Number: 5
bot_cache_entrances_to_other_radios(param_00)
{
	for(var_01 = common_scripts\utility::array_remove(level.radios,param_00);var_01.size > 0;var_01 = common_scripts\utility::array_remove(var_01,var_02))
	{
		var_02 = undefined;
		var_03 = find_current_radio();
		if(isdefined(var_03) && common_scripts\utility::array_contains(var_01,var_03))
		{
			var_02 = var_03;
		}
		else
		{
			var_02 = common_scripts\utility::random(var_01);
		}

		maps\mp\bots\_bots_gametype_common::bot_cache_entrances_to_zones([var_02]);
		level.bot_gametype_radios_precached[var_02 getentitynumber()] = 1;
	}
}

//Function Number: 6
bot_koth_think()
{
	self notify("bot_koth_think");
	self endon("bot_koth_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(!isdefined(level.bot_gametype_precaching_done))
	{
		wait(0.05);
	}

	self botsetflag("separation",0);
	self botsetflag("grenade_objectives",1);
	for(;;)
	{
		wait(0.05);
		if(self.health <= 0)
		{
			continue;
		}

		var_00 = find_current_radio();
		if(!isdefined(var_00) || !isdefined(level.bot_gametype_radios_precached[var_00 getentitynumber()]))
		{
			bot_clear_koth_zone();
			self [[ self.personality_update_function ]]();
			continue;
		}

		var_01 = level.radioobject maps\mp\gametypes\_gameobjects::getownerteam();
		if(self.team != var_01)
		{
			if(!bot_is_capturing_koth_zone(var_00))
			{
				bot_capture_koth_zone(var_00);
			}

			continue;
		}

		var_02 = common_scripts\utility::get_enemy_team(self.team);
		var_03 = level.radioobject.touchlist[var_02].size > 0;
		if(var_03)
		{
			if(!bot_is_capturing_koth_zone(var_00))
			{
				bot_capture_koth_zone(var_00);
			}

			continue;
		}

		if(!bot_is_protecting_koth_zone(var_00))
		{
			if(bot_is_capturing_koth_zone(var_00))
			{
				wait(randomfloat(2));
				bot_clear_koth_zone();
				continue;
			}

			bot_protect_koth_zone(var_00);
		}
	}
}

//Function Number: 7
find_current_radio()
{
	foreach(var_01 in level.radios)
	{
		if(isdefined(level.radioobject) && var_01.trig == level.radioobject.trigger)
		{
			return var_01;
		}
	}
}

//Function Number: 8
bot_is_capturing_koth_zone(param_00)
{
	if(!maps\mp\bots\_bots_util::bot_is_capturing())
	{
		return 0;
	}

	return isdefined(self.current_zone) && self.current_zone == param_00;
}

//Function Number: 9
bot_is_protecting_koth_zone(param_00)
{
	if(!maps\mp\bots\_bots_util::bot_is_protecting())
	{
		return 0;
	}

	return isdefined(self.current_zone) && self.current_zone == param_00;
}

//Function Number: 10
bot_capture_koth_zone(param_00)
{
	self.current_zone = param_00;
	var_01["entrance_points_index"] = param_00.entrance_indices;
	var_01["override_origin_node"] = param_00.center_node;
	maps\mp\bots\_bots_strategy::bot_capture_zone(param_00.origin,param_00.nodes,param_00.trig,var_01);
}

//Function Number: 11
bot_protect_koth_zone(param_00)
{
	self.current_zone = param_00;
	var_01 = length(param_00.zone_bounds.half_size) * 2;
	var_02["override_origin_node"] = param_00.center_node;
	maps\mp\bots\_bots_strategy::bot_protect_point(param_00.center_node.origin,var_01,var_02);
}

//Function Number: 12
bot_clear_koth_zone()
{
	if(maps\mp\bots\_bots_util::bot_is_defending())
	{
		maps\mp\bots\_bots_strategy::bot_defend_stop();
	}

	self.current_zone = undefined;
}

//Function Number: 13
should_start_cautious_approach_koth(param_00)
{
	if(param_00)
	{
		var_01 = level.radioobject maps\mp\gametypes\_gameobjects::getownerteam();
		if(var_01 == "neutral" || var_01 == self.team)
		{
			return 0;
		}
	}

	return maps\mp\bots\_bots_strategy::should_start_cautious_approach_default(param_00);
}