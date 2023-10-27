/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_hp.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 153 ms
 * Timestamp: 10/27/2023 2:37:15 AM
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
	var_00 = 0;
	for(var_01 = 0;var_01 < level.all_hp_zones.size;var_01++)
	{
		var_02 = level.all_hp_zones[var_01];
		var_02.script_label = "zone_" + var_01;
		var_02 thread maps\mp\bots\_bots_gametype_common::monitor_zone_control();
		var_03 = 0;
		if(isdefined(var_02.trig.trigger_off) && var_02.trig.trigger_off)
		{
			var_02.trig common_scripts\utility::trigger_on();
			var_03 = 1;
		}

		var_02.nodes = maps\mp\bots\_bots_gametype_common::bot_get_valid_nodes_in_trigger(var_02.trig);
		if(var_03)
		{
			var_02.trig common_scripts\utility::trigger_off();
		}
	}

	level.bot_set_zone_nodes = 1;
	if(!var_00)
	{
		level.bot_hp_allow_predictive_capping = 1;
		var_04 = level.zone;
		if(!isdefined(var_04))
		{
			var_04 = common_scripts\utility::random(level.all_hp_zones);
		}

		maps\mp\bots\_bots_gametype_common::bot_cache_entrances_to_zones([var_04]);
		level.bot_gametype_zones_precached[var_04 getentitynumber()] = 1;
		level.bot_gametype_precaching_done = 1;
		thread bot_cache_entrances_to_other_zones(var_04);
	}
}

//Function Number: 4
bot_cache_entrances_to_other_zones(param_00)
{
	for(var_01 = common_scripts\utility::array_remove(level.all_hp_zones,param_00);var_01.size > 0;var_01 = common_scripts\utility::array_remove(var_01,var_02))
	{
		var_02 = undefined;
		var_03 = level.zone;
		if(isdefined(var_03) && common_scripts\utility::array_contains(var_01,var_03))
		{
			var_02 = var_03;
		}
		else
		{
			var_02 = common_scripts\utility::random(var_01);
		}

		maps\mp\bots\_bots_gametype_common::bot_cache_entrances_to_zones([var_02]);
		level.bot_gametype_zones_precached[var_02 getentitynumber()] = 1;
	}
}

//Function Number: 5
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

		if(!isdefined(level.zone) || !isdefined(level.bot_gametype_zones_precached[level.zone getentitynumber()]))
		{
			if(maps\mp\bots\_bots_util::bot_is_defending())
			{
				maps\mp\bots\_bots_strategy::bot_defend_stop();
			}

			self.current_zone = undefined;
			self [[ self.personality_update_function ]]();
			continue;
		}

		if(var_01 != level.zone)
		{
			var_00 = undefined;
			var_01 = level.zone;
		}

		if(isdefined(level.zonemovetime) && !isdefined(var_00) && level.randomzonespawn == 0 && level.bot_hp_allow_predictive_capping)
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

//Function Number: 6
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

//Function Number: 7
bot_get_num_teammates_capturing_zone(param_00)
{
	return bot_get_teammates_capturing_zone(param_00).size;
}

//Function Number: 8
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

//Function Number: 9
bot_is_capturing_zone(param_00)
{
	if(!maps\mp\bots\_bots_util::bot_is_capturing())
	{
		return 0;
	}

	return self.current_zone == param_00;
}

//Function Number: 10
bot_capture_hp_zone(param_00)
{
	self.current_zone = param_00;
	var_01["entrance_points_index"] = param_00.entrance_indices;
	var_01["override_origin_node"] = param_00.center_node;
	maps\mp\bots\_bots_strategy::bot_capture_zone(param_00.origin,param_00.nodes,param_00.trig,var_01);
}

//Function Number: 11
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