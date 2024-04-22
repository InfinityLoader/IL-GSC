/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _stealth_event_enemy.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 191 ms
 * Timestamp: 4/22/2024 2:23:06 AM
*******************************************************************/

//Function Number: 1
stealth_event_enemy_main()
{
	thread enemy_event_loop();
	self._stealth.plugins.event = 1;
}

//Function Number: 2
enemy_event_loop()
{
	self endon("death");
	self endon("pain_death");
	for(;;)
	{
		self waittill("event_awareness",var_00);
		if(!maps\_utility::ent_flag("_stealth_enabled"))
		{
			continue;
		}

		if(maps\_stealth_utility::stealth_group_spotted_flag())
		{
			continue;
		}

		var_01 = self._stealth.behavior.ai_functions["event"];
		if(!isdefined(var_01[var_00]))
		{
			continue;
		}

		thread enemy_event_reaction_wrapper(var_00);
	}
}

//Function Number: 3
enemy_event_reaction_wrapper(param_00)
{
	var_01 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
	self endon("_stealth_enemy_alert_level_change");
	level endon(var_01);
	self endon("death");
	waittillframeend;
	self endon("enemy_awareness_reaction");
	self endon("event_awareness");
	maps\_stealth_shared_utilities::enemy_reaction_state_alert();
	maps\_stealth_shared_utilities::enemy_find_original_goal();
	maps\_stealth_shared_utilities::enemy_stop_current_behavior();
	var_02 = self._stealth.behavior.ai_functions["event"][param_00];
	self [[ var_02 ]](param_00);
	maps\_stealth_threat_enemy::enemy_alert_level_change("reset");
}

//Function Number: 4
enemy_event_reaction_heard_scream(param_00)
{
	var_01 = self._stealth.logic.event.awareness_param[param_00];
	wait(0.05);
	maps\_utility::ent_flag_waitopen("_stealth_behavior_reaction_anim_in_progress");
	var_02 = maps\_stealth_shared_utilities::enemy_find_free_pathnode_near(var_01,300,40);
	enemy_investigate_position(var_02);
}

//Function Number: 5
enemy_event_reaction_flashbang(param_00)
{
	var_01 = self._stealth.logic.event.awareness_param[param_00];
	if(common_scripts\utility::isflashed() && self.script == "<custom>")
	{
		wait(0.05);
		self setflashbanged(1);
	}

	wait(0.05);
	if(self.script == "flashed")
	{
		self waittill("stop_flashbang_effect");
	}

	var_02 = maps\_stealth_shared_utilities::enemy_find_free_pathnode_near(var_01,300,40);
	if(isdefined(var_02))
	{
		thread maps\_stealth_shared_utilities::enemy_announce_wtf();
		thread maps\_stealth_shared_utilities::enemy_announce_spotted_bring_group(var_01);
	}

	enemy_investigate_position(var_02);
}

//Function Number: 6
enemy_event_reaction_explosion(param_00)
{
	var_01 = self._stealth.logic.event.awareness_param[param_00];
	wait(0.05);
	maps\_utility::ent_flag_waitopen("_stealth_behavior_reaction_anim_in_progress");
	var_02 = maps\_stealth_shared_utilities::enemy_find_free_pathnode_near(var_01,300,40);
	thread maps\_stealth_shared_utilities::enemy_announce_wtf();
	enemy_investigate_position(var_02);
}

//Function Number: 7
enemy_event_reaction_nothing(param_00)
{
}

//Function Number: 8
enemy_investigate_position(param_00,param_01)
{
	if(isdefined(param_00))
	{
		wait(randomfloat(1));
		thread maps\_stealth_shared_utilities::enemy_react_and_displace_to(param_00,param_01);
		thread maps\_stealth_shared_utilities::enemy_runto_and_lookaround(param_00,param_01);
		self.disablearrivals = 0;
		self.disableexits = 0;
		self waittill("goal");
		wait(randomfloatrange(15,25));
		return;
	}

	wait(randomfloatrange(1,4));
}

//Function Number: 9
stealth_event_mod_all(param_00)
{
	if(!isdefined(param_00) || !common_scripts\utility::array_contains(param_00,"heard_scream"))
	{
		stealth_event_mod("heard_scream");
	}

	if(!isdefined(param_00) || !common_scripts\utility::array_contains(param_00,"doFlashBanged"))
	{
		stealth_event_mod("doFlashBanged");
	}

	if(!isdefined(param_00) || !common_scripts\utility::array_contains(param_00,"explode"))
	{
		stealth_event_mod("explode");
	}
}

//Function Number: 10
stealth_event_mod(param_00,param_01,param_02,param_03)
{
	var_04 = stealth_event_defaults();
	var_05 = stealth_event_anim_defaults();
	if(!isdefined(param_01))
	{
		param_01 = var_04[param_00];
	}

	if(!isdefined(param_02))
	{
		param_02 = var_05[param_00];
	}

	if(!isdefined(param_03))
	{
		param_03 = stealth_event_listener_defaults(param_00);
	}

	maps\_stealth_shared_utilities::ai_create_behavior_function("event",param_00,param_01);
	maps\_stealth_shared_utilities::ai_create_behavior_function("animation",param_00,param_02);
	thread maps\_stealth_visibility_enemy::enemy_event_awareness(param_00);
	if(param_03)
	{
		self addaieventlistener(param_00);
	}

	switch(param_00)
	{
		case "explode":
			self.ignoreexplosionevents = 1;
			break;
	}
}

//Function Number: 11
stealth_event_defaults()
{
	var_00 = [];
	if(self.type == "dog")
	{
		var_00["heard_scream"] = ::enemy_event_reaction_nothing;
		var_00["doFlashBanged"] = ::enemy_event_reaction_nothing;
	}
	else
	{
		var_00["heard_scream"] = ::enemy_event_reaction_heard_scream;
		var_00["doFlashBanged"] = ::enemy_event_reaction_flashbang;
	}

	var_00["explode"] = ::enemy_event_reaction_explosion;
	return var_00;
}

//Function Number: 12
stealth_event_listener_defaults(param_00)
{
	switch(param_00)
	{
		case "heard_scream":
			return 0;

		case "doFlashBanged":
			return 0;

		case "explode":
			return 0;

		default:
			return 0;
	}
}

//Function Number: 13
stealth_event_anim_defaults()
{
	var_00 = [];
	var_00["doFlashBanged"] = ::maps\_stealth_animation_funcs::enemy_animation_nothing;
	if(self.type == "dog")
	{
		var_00["heard_scream"] = ::maps\_stealth_animation_funcs::dog_animation_generic;
		var_00["explode"] = ::maps\_stealth_animation_funcs::dog_animation_wakeup_fast;
	}
	else
	{
		var_00["heard_scream"] = ::maps\_stealth_animation_funcs::enemy_animation_generic;
		var_00["explode"] = ::maps\_stealth_animation_funcs::enemy_animation_generic;
	}

	return var_00;
}