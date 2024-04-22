/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _stealth_utility.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 85
 * Decompile Time: 1344 ms
 * Timestamp: 4/22/2024 2:23:16 AM
*******************************************************************/

//Function Number: 1
stealth_default()
{
	stealth_plugin_basic();
	if(isplayer(self))
	{
		return;
	}

	switch(self.team)
	{
		case "team3":
		case "axis":
			stealth_plugin_threat();
			stealth_enable_seek_player_on_spotted();
			stealth_plugin_corpse();
			stealth_plugin_event_all();
			break;

		case "allies":
			stealth_plugin_aicolor();
			stealth_plugin_accuracy();
			stealth_plugin_smart_stance();
			break;
	}
}

//Function Number: 2
stealth_set_default_stealth_function(param_00,param_01)
{
	level.stealth_default_func[param_00] = param_01;
}

//Function Number: 3
stealth_plugin_basic(param_00)
{
	if(isplayer(self))
	{
		maps\_stealth_visibility_friendly::stealth_visibility_friendly_main();
		return;
	}

	if(!isdefined(self._stealth) || !isdefined(self._stealth.plugins.basic))
	{
		switch(self.team)
		{
			case "allies":
				maps\_stealth_visibility_friendly::stealth_visibility_friendly_main();
				maps\_stealth_behavior_friendly::stealth_behavior_friendly_main();
				break;

			case "team3":
			case "axis":
				maps\_stealth_visibility_enemy::stealth_visibility_enemy_main();
				maps\_stealth_behavior_enemy::stealth_behavior_enemy_main();
				break;
		}
	}

	if(isdefined(param_00))
	{
		stealth_basic_states_custom(param_00);
	}

	self._stealth.plugins.basic = 1;
}

//Function Number: 4
stealth_basic_states_custom(param_00)
{
	switch(self.team)
	{
		case "allies":
			maps\_stealth_behavior_friendly::friendly_custom_state_behavior(param_00);
			break;

		case "team3":
		case "axis":
			maps\_stealth_behavior_enemy::enemy_custom_state_behavior(param_00);
			break;
	}
}

//Function Number: 5
stealth_basic_states_default()
{
	switch(self.team)
	{
		case "allies":
			maps\_stealth_behavior_friendly::friendly_default_state_behavior();
			break;

		case "team3":
		case "axis":
			maps\_stealth_behavior_enemy::enemy_default_state_behavior();
			break;
	}
}

//Function Number: 6
stealth_pre_spotted_function_custom(param_00)
{
	maps\_stealth_visibility_enemy::enemy_alert_level_set_pre_spotted_func(param_00);
}

//Function Number: 7
stealth_pre_spotted_function_default()
{
	maps\_stealth_visibility_enemy::enemy_alert_level_default_pre_spotted_func();
}

//Function Number: 8
stealth_plugin_threat(param_00)
{
	if(!isdefined(self._stealth.plugins.threat))
	{
		maps\_stealth_threat_enemy::stealth_threat_enemy_main();
	}

	if(isdefined(param_00))
	{
		stealth_threat_behavior_replace(param_00);
	}
}

//Function Number: 9
stealth_enable_seek_player_on_spotted()
{
	self.script_stealth_dontseek = 0;
}

//Function Number: 10
stealth_disable_seek_player_on_spotted()
{
	self.script_stealth_dontseek = 1;
}

//Function Number: 11
stealth_threat_behavior_custom(param_00,param_01)
{
	if(isdefined(param_00))
	{
		maps\_stealth_threat_enemy::enemy_set_threat_behavior(param_00);
	}

	if(isdefined(param_01))
	{
		maps\_stealth_threat_enemy::enemy_set_threat_anim_behavior(param_01);
	}
}

//Function Number: 12
stealth_threat_behavior_replace(param_00,param_01)
{
	var_02 = "threat";
	var_03 = "warning";
	var_04 = 1;
	var_05 = var_03 + var_04;
	if(isdefined(param_00))
	{
		while(isdefined(self._stealth.behavior.ai_functions[var_02][var_05]))
		{
			if(!isdefined(param_00[var_05]))
			{
				param_00[var_05] = maps\_stealth_shared_utilities::ai_get_behavior_function(var_02,var_05);
			}

			var_04++;
			var_05 = var_03 + var_04;
		}
	}

	stealth_threat_behavior_custom(param_00,param_01);
}

//Function Number: 13
stealth_threat_behavior_default_no_warnings()
{
	var_00 = [];
	stealth_threat_behavior_custom(var_00);
}

//Function Number: 14
stealth_threat_behavior_default()
{
	maps\_stealth_threat_enemy::enemy_default_threat_behavior();
	maps\_stealth_threat_enemy::enemy_default_threat_anim_behavior();
}

//Function Number: 15
stealth_alert_level_duration(param_00)
{
	level._stealth.logic.min_alert_level_duration = param_00;
}

//Function Number: 16
stealth_plugin_corpse(param_00)
{
	if(!isdefined(self._stealth.plugins.corpse))
	{
		maps\_stealth_corpse_enemy::stealth_corpse_enemy_main();
	}

	if(isdefined(param_00))
	{
		stealth_corpse_behavior_custom(param_00);
	}
}

//Function Number: 17
stealth_corpse_behavior_custom(param_00)
{
	maps\_stealth_corpse_enemy::enemy_custom_corpse_behavior(param_00);
}

//Function Number: 18
stealth_corpse_behavior_default()
{
	maps\_stealth_corpse_enemy::enemy_default_corpse_behavior();
}

//Function Number: 19
stealth_corpse_forget_time_default()
{
	maps\_stealth_corpse_system::stealth_corpse_default_forget_time();
}

//Function Number: 20
stealth_corpse_forget_time_custom(param_00)
{
	maps\_stealth_corpse_system::stealth_corpse_set_forget_time(param_00);
}

//Function Number: 21
stealth_corpse_reset_time_default()
{
	maps\_stealth_corpse_system::stealth_corpse_default_reset_time();
}

//Function Number: 22
stealth_corpse_reset_time_custom(param_00)
{
	maps\_stealth_corpse_system::stealth_corpse_set_reset_time(param_00);
}

//Function Number: 23
stealth_corpse_collect_func(param_00)
{
	maps\_stealth_corpse_system::stealth_corpse_set_collect_func(param_00);
}

//Function Number: 24
stealth_corpse_reset_collect_func()
{
	maps\_stealth_corpse_system::stealth_corpse_default_collect_func();
}

//Function Number: 25
stealth_plugin_event_all(param_00,param_01)
{
	stealth_plugin_event_main();
	maps\_stealth_event_enemy::stealth_event_mod_all(param_01);
	if(isdefined(param_00))
	{
		foreach(var_04, var_03 in param_00)
		{
			maps\_stealth_event_enemy::stealth_event_mod(var_04,var_03);
		}
	}
}

//Function Number: 26
stealth_plugin_event_main()
{
	if(!isdefined(self._stealth.plugins.event))
	{
		maps\_stealth_event_enemy::stealth_event_enemy_main();
	}
}

//Function Number: 27
stealth_plugin_event_heard_scream(param_00,param_01)
{
	stealth_plugin_event_main();
	maps\_stealth_event_enemy::stealth_event_mod("heard_scream",param_00,param_01);
}

//Function Number: 28
stealth_plugin_event_flashbang(param_00,param_01)
{
	stealth_plugin_event_main();
	maps\_stealth_event_enemy::stealth_event_mod("doFlashBanged",param_00,param_01);
}

//Function Number: 29
stealth_plugin_event_explosion(param_00,param_01)
{
	stealth_plugin_event_main();
	maps\_stealth_event_enemy::stealth_event_mod("explode",param_00,param_01);
}

//Function Number: 30
stealth_plugin_event_custom(param_00,param_01,param_02,param_03)
{
	stealth_plugin_event_main();
	maps\_stealth_event_enemy::stealth_event_mod(param_00,param_01,param_02,param_03);
}

//Function Number: 31
stealth_plugin_aicolor(param_00)
{
	if(!isdefined(self._stealth.plugins.color_system))
	{
		maps\_stealth_color_friendly::stealth_color_friendly_main();
	}

	if(isdefined(param_00))
	{
		stealth_color_state_custom(param_00);
	}
}

//Function Number: 32
stealth_color_state_custom(param_00)
{
	maps\_stealth_color_friendly::friendly_custom_color_behavior(param_00);
}

//Function Number: 33
stealth_color_state_default()
{
	maps\_stealth_color_friendly::friendly_default_color_behavior();
}

//Function Number: 34
stealth_plugin_accuracy(param_00)
{
	if(!isdefined(self._stealth.plugins.accaracy_mod))
	{
		maps\_stealth_accuracy_friendly::stealth_accuracy_friendly_main();
	}

	if(isdefined(param_00))
	{
		stealth_accuracy_state_custom(param_00);
	}
}

//Function Number: 35
stealth_accuracy_state_custom(param_00)
{
	maps\_stealth_accuracy_friendly::friendly_custom_acc_behavior(param_00);
}

//Function Number: 36
stealth_accuracy_state_default()
{
	maps\_stealth_accuracy_friendly::friendly_default_acc_behavior();
}

//Function Number: 37
stealth_plugin_smart_stance()
{
	maps\_stealth_smartstance_friendly::stealth_smartstance_friendly_main();
}

//Function Number: 38
enable_stealth_smart_stance()
{
	maps\_utility::ent_flag_set("_stealth_stance_handler");
}

//Function Number: 39
disable_stealth_smart_stance()
{
	maps\_utility::ent_flag_clear("_stealth_stance_handler");
}

//Function Number: 40
stealth_enemy_waittill_alert()
{
	waittillframeend;
	maps\_utility::ent_flag_waitopen("_stealth_normal");
}

//Function Number: 41
stealth_is_everything_normal()
{
	var_00 = level._stealth.group.groups;
	foreach(var_07, var_02 in var_00)
	{
		var_03 = maps\_stealth_shared_utilities::group_get_ai_in_group(var_07);
		foreach(var_05 in var_03)
		{
			if(!var_05 maps\_utility::ent_flag("_stealth_normal"))
			{
				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 42
stealth_enemy_endon_alert()
{
	stealth_enemy_waittill_alert();
	waittillframeend;
	self notify("stealth_enemy_endon_alert");
}

//Function Number: 43
stealth_event_handler(param_00,param_01)
{
	thread maps\_stealth_shared_utilities::event_awareness_main(param_00,param_01);
}

//Function Number: 44
stealth_detect_ranges_set(param_00,param_01)
{
	maps\_stealth_visibility_system::system_set_detect_ranges(param_00,param_01);
}

//Function Number: 45
stealth_detect_ranges_default()
{
	maps\_stealth_visibility_system::system_default_detect_ranges();
}

//Function Number: 46
stealth_corpse_ranges_custom(param_00)
{
	maps\_stealth_corpse_system::stealth_corpse_set_distances(param_00);
}

//Function Number: 47
stealth_corpse_ranges_default()
{
	maps\_stealth_corpse_system::stealth_corpse_default_distances();
}

//Function Number: 48
stealth_ai_event_dist_custom(param_00)
{
	var_01 = level._stealth.logic.detection_level;
	maps\_stealth_visibility_system::system_set_event_distances(param_00);
	maps\_stealth_visibility_system::system_event_change(var_01);
}

//Function Number: 49
stealth_ai_event_dist_default()
{
	var_00 = level._stealth.logic.detection_level;
	maps\_stealth_visibility_system::system_default_event_distances();
	maps\_stealth_visibility_system::system_event_change(var_00);
}

//Function Number: 50
stealth_friendly_movespeed_scale_set(param_00,param_01)
{
	maps\_stealth_visibility_friendly::friendly_set_movespeed_scale(param_00,param_01);
}

//Function Number: 51
stealth_friendly_movespeed_scale_default()
{
	maps\_stealth_visibility_friendly::friendly_default_movespeed_scale();
}

//Function Number: 52
stealth_friendly_stance_handler_distances_set(param_00,param_01,param_02)
{
	maps\_stealth_smartstance_friendly::friendly_set_stance_handler_distances(param_00,param_01,param_02);
}

//Function Number: 53
stealth_friendly_stance_handler_distances_default()
{
	maps\_stealth_smartstance_friendly::friendly_default_stance_handler_distances();
}

//Function Number: 54
stealth_ai_clear_custom_idle_and_react(param_00)
{
	maps\_stealth_shared_utilities::ai_clear_custom_animation_reaction_and_idle(param_00);
}

//Function Number: 55
stealth_ai_clear_custom_react()
{
	maps\_stealth_shared_utilities::ai_clear_custom_animation_reaction();
}

//Function Number: 56
stealth_ai_idle_and_react(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_04))
	{
	}

	param_00 stealth_insure_enabled();
	var_05 = param_00 maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
	if(common_scripts\utility::flag(var_05))
	{
		return;
	}

	var_06 = "stop_loop";
	param_00.allowdeath = 1;
	if(!isdefined(param_04))
	{
		thread maps\_anim::anim_generic_custom_animmode_loop(param_00,"gravity",param_01,param_03);
	}
	else
	{
		thread maps\_anim::anim_generic_loop(param_00,param_01,param_03);
	}

	param_00 maps\_stealth_shared_utilities::ai_set_custom_animation_reaction(self,param_02,param_03,var_06);
	maps\_utility::add_wait(::maps\_utility::waittill_msg,"stop_idle_proc");
	maps\_utility::add_func(::stealth_ai_clear_custom_idle_and_react);
	thread do_wait_thread();
}

//Function Number: 57
do_wait_thread()
{
	self endon("death");
	maps\_utility::do_wait();
}

//Function Number: 58
stealth_ai_react(param_00,param_01,param_02)
{
	param_00 stealth_insure_enabled();
	param_00 maps\_stealth_shared_utilities::ai_set_custom_animation_reaction(self,param_01,param_02,"stop_loop");
}

//Function Number: 59
stealth_ai_reach_idle_and_react(param_00,param_01,param_02,param_03,param_04)
{
	param_00 stealth_insure_enabled();
	thread stealth_ai_reach_idle_and_react_proc(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 60
stealth_ai_reach_idle_and_react_proc(param_00,param_01,param_02,param_03,param_04)
{
	param_00 stealth_insure_enabled();
	param_00 thread stealth_enemy_endon_alert();
	param_00 endon("stealth_enemy_endon_alert");
	param_00 endon("death");
	maps\_anim::anim_generic_reach(param_00,param_01,param_04);
	stealth_ai_idle_and_react(param_00,param_02,param_03,param_04);
}

//Function Number: 61
stealth_ai_reach_and_arrive_idle_and_react(param_00,param_01,param_02,param_03,param_04)
{
	param_00 stealth_insure_enabled();
	thread stealth_ai_reach_and_arrive_idle_and_react_proc(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 62
stealth_ai_reach_and_arrive_idle_and_react_proc(param_00,param_01,param_02,param_03,param_04)
{
	param_00 stealth_insure_enabled();
	param_00 thread stealth_enemy_endon_alert();
	param_00 endon("stealth_enemy_endon_alert");
	param_00 endon("death");
	maps\_anim::anim_generic_reach_and_arrive(param_00,param_01,param_04);
	stealth_ai_idle_and_react(param_00,param_02,param_03,param_04);
}

//Function Number: 63
stealth_insure_enabled()
{
}

//Function Number: 64
stealth_group_return_groups_with_spotted_flag()
{
	return maps\_stealth_shared_utilities::group_return_groups_with_flag_set("_stealth_spotted");
}

//Function Number: 65
stealth_group_return_groups_with_event_flag()
{
	return maps\_stealth_shared_utilities::group_return_groups_with_flag_set("_stealth_event");
}

//Function Number: 66
stealth_group_return_groups_with_corpse_flag()
{
	return maps\_stealth_shared_utilities::group_return_groups_with_flag_set("_stealth_found_corpse");
}

//Function Number: 67
stealth_group_return_ai_with_spotted_flag()
{
	return maps\_stealth_shared_utilities::group_return_ai_with_flag_set("_stealth_spotted");
}

//Function Number: 68
stealth_group_return_ai_with_event_flag()
{
	return maps\_stealth_shared_utilities::group_return_ai_with_flag_set("_stealth_event");
}

//Function Number: 69
stealth_group_return_ai_with_corpse_flag()
{
	return maps\_stealth_shared_utilities::group_return_ai_with_flag_set("_stealth_found_corpse");
}

//Function Number: 70
stealth_group_spotted_flag()
{
	var_00 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
	return common_scripts\utility::flag(var_00);
}

//Function Number: 71
stealth_group_corpse_flag()
{
	var_00 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_found_corpse");
	return common_scripts\utility::flag(var_00);
}

//Function Number: 72
stealth_group_spotted_flag_wait()
{
	var_00 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
	common_scripts\utility::flag_wait(var_00);
}

//Function Number: 73
stealth_group_corpse_flag_wait()
{
	var_00 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_found_corpse");
	common_scripts\utility::flag_wait(var_00);
}

//Function Number: 74
stealth_group_spotted_flag_waitopen()
{
	var_00 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
	return common_scripts\utility::flag_waitopen(var_00);
}

//Function Number: 75
stealth_group_corpse_flag_waitopen()
{
	var_00 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_found_corpse");
	return common_scripts\utility::flag_waitopen(var_00);
}

//Function Number: 76
stealth_get_group_spotted_flag()
{
	return maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
}

//Function Number: 77
stealth_get_group_corpse_flag()
{
	return maps\_stealth_shared_utilities::group_get_flagname("_stealth_found_corpse");
}

//Function Number: 78
stealth_set_group(param_00)
{
	stealth_set_group_proc(param_00);
}

//Function Number: 79
stealth_set_group_default()
{
	stealth_set_group_proc("default");
}

//Function Number: 80
stealth_set_group_proc(param_00)
{
	if(isdefined(self.script_stealthgroup))
	{
		level._stealth.group.groups[self.script_stealthgroup] = common_scripts\utility::array_remove(level._stealth.group.groups[self.script_stealthgroup],self);
	}

	self.script_stealthgroup = maps\_utility::string(param_00);
	if(isdefined(self._stealth.plugins.basic))
	{
		maps\_stealth_shared_utilities::group_flag_init("_stealth_spotted");
		maps\_stealth_shared_utilities::group_flag_init("_stealth_event");
		maps\_stealth_shared_utilities::group_flag_init("_stealth_found_corpse");
		maps\_stealth_shared_utilities::group_add_to_global_list();
	}
}

//Function Number: 81
stealth_get_group()
{
	return self.script_stealthgroup;
}

//Function Number: 82
enable_stealth_system()
{
	common_scripts\utility::flag_set("_stealth_enabled");
	var_00 = getaispeciesarray("all","all");
	foreach(var_02 in var_00)
	{
		var_02 enable_stealth_for_ai();
	}

	foreach(var_05 in level.players)
	{
		if(var_05 maps\_utility::ent_flag_exist("_stealth_enabled"))
		{
			var_05 maps\_utility::ent_flag_set("_stealth_enabled");
		}

		var_05 maps\_stealth_visibility_friendly::friendly_visibility_logic();
	}

	maps\_stealth_visibility_system::system_event_change("hidden");
}

//Function Number: 83
disable_stealth_system()
{
	common_scripts\utility::flag_clear("_stealth_enabled");
	var_00 = getaispeciesarray("all","all");
	foreach(var_02 in var_00)
	{
		var_02 disable_stealth_for_ai();
	}

	foreach(var_05 in level.players)
	{
		var_05.maxvisibledist = 8192;
		if(var_05 maps\_utility::ent_flag_exist("_stealth_enabled"))
		{
			var_05 maps\_utility::ent_flag_clear("_stealth_enabled");
		}
	}

	maps\_stealth_visibility_system::system_event_change("spotted");
}

//Function Number: 84
enable_stealth_for_ai()
{
	if(maps\_utility::ent_flag_exist("_stealth_enabled"))
	{
		maps\_utility::ent_flag_set("_stealth_enabled");
	}

	if(self.team == "allies")
	{
		thread maps\_stealth_visibility_friendly::friendly_visibility_logic();
	}
}

//Function Number: 85
disable_stealth_for_ai()
{
	if(maps\_utility::ent_flag_exist("_stealth_enabled"))
	{
		maps\_utility::ent_flag_clear("_stealth_enabled");
	}

	self.maxvisibledist = 8192;
}