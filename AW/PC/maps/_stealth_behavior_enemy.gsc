/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _stealth_behavior_enemy.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 138 ms
 * Timestamp: 4/22/2024 2:23:00 AM
*******************************************************************/

//Function Number: 1
stealth_behavior_enemy_main()
{
	enemy_init();
	var_00 = self._stealth.behavior.ai_functions["state"]["hidden"];
	thread maps\_stealth_shared_utilities::ai_message_handler_hidden(var_00,"enemy_behavior");
	var_00 = self._stealth.behavior.ai_functions["state"]["spotted"];
	thread maps\_stealth_shared_utilities::ai_message_handler_spotted(var_00,"enemy_behavior");
	thread enemy_animation_loop();
}

//Function Number: 2
enemy_animation_loop()
{
	self endon("death");
	self endon("pain_death");
	self endon("damage");
	for(;;)
	{
		self waittill("event_awareness",var_00);
		if(!maps\_utility::ent_flag("_stealth_enabled"))
		{
			continue;
		}

		var_01 = self._stealth.behavior.ai_functions["animation"]["wrapper"];
		self thread [[ var_01 ]](var_00);
	}
}

//Function Number: 3
enemy_state_hidden()
{
	self.fovcosine = 0.5;
	self.fovcosinebusy = 0.1;
	self.favoriteenemy = undefined;
	self.dontattackme = 1;
	self.dontevershoot = 1;
	thread maps\_utility::set_battlechatter(0);
	if(self.type == "dog")
	{
		return;
	}

	self.diequietly = 1;
	self clearenemy();
}

//Function Number: 4
enemy_state_spotted(param_00)
{
	self.fovcosine = 0.01;
	if(!isdefined(self.dog_attacking_me))
	{
		self.ignoreall = 0;
		thread maps\_utility::set_battlechatter(1);
	}

	self.dontattackme = undefined;
	self.dontevershoot = undefined;
	if(isdefined(self.oldfixednode))
	{
		self.fixednode = self.oldfixednode;
	}

	if(self.type != "dog")
	{
		self.diequietly = 0;
		if(!isdefined(param_00))
		{
			maps\_utility::clear_run_anim();
			maps\_stealth_shared_utilities::enemy_stop_current_behavior();
		}
	}
	else
	{
		self.script_growl = undefined;
		self.script_nobark = undefined;
	}

	if(isdefined(param_00))
	{
		return;
	}

	if(isdefined(level._stealth.group.spotted_enemy))
	{
		var_01 = level._stealth.group.spotted_enemy[self.script_stealthgroup];
		if(isdefined(var_01))
		{
			self getenemyinfo(var_01);
		}
	}
}

//Function Number: 5
enemy_init()
{
	maps\_utility::ent_flag_init("_stealth_override_goalpos");
	maps\_utility::ent_flag_init("_stealth_enemy_alert_level_action");
	maps\_utility::ent_flag_init("_stealth_running_to_corpse");
	maps\_utility::ent_flag_init("_stealth_behavior_reaction_anim");
	maps\_utility::ent_flag_init("_stealth_behavior_first_reaction");
	maps\_utility::ent_flag_init("_stealth_behavior_reaction_anim_in_progress");
	self._stealth.behavior = spawnstruct();
	self.a.nofirstframemelee = 1;
	self._stealth.behavior.ai_functions = [];
	enemy_default_state_behavior();
	enemy_default_anim_behavior();
	self._stealth.behavior.event = spawnstruct();
	if(self.type == "dog")
	{
		enemy_dog_init();
	}

	self._stealth.plugins = spawnstruct();
	thread maps\_stealth_shared_utilities::ai_stealth_pause_handler();
}

//Function Number: 6
enemy_dog_init()
{
	if(threatbiasgroupexists("dog"))
	{
		self setthreatbiasgroup("dog");
	}

	if(isdefined(self.enemy) || isdefined(self.favoriteenemy))
	{
		return;
	}

	maps\_utility::ent_flag_init("_stealth_behavior_asleep");
	if(isdefined(self.script_pet) || isdefined(self.script_patroller))
	{
		return;
	}

	self.ignoreme = 1;
	self.ignoreall = 1;
	self.allowdeath = 1;
	thread maps\_anim::anim_generic_custom_animmode_loop(self,"gravity","_stealth_dog_sleeping");
	maps\_utility::ent_flag_set("_stealth_behavior_asleep");
}

//Function Number: 7
enemy_custom_state_behavior(param_00)
{
	foreach(var_03, var_02 in param_00)
	{
		maps\_stealth_shared_utilities::ai_create_behavior_function("state",var_03,var_02);
	}

	var_04 = self._stealth.behavior.ai_functions["state"]["hidden"];
	thread maps\_stealth_shared_utilities::ai_message_handler_hidden(var_04,"enemy_behavior");
	var_04 = self._stealth.behavior.ai_functions["state"]["spotted"];
	thread maps\_stealth_shared_utilities::ai_message_handler_spotted(var_04,"enemy_behavior");
}

//Function Number: 8
enemy_default_state_behavior()
{
	var_00 = [];
	var_00["hidden"] = ::enemy_state_hidden;
	var_00["spotted"] = ::enemy_state_spotted;
	enemy_custom_state_behavior(var_00);
}

//Function Number: 9
enemy_default_anim_behavior()
{
	maps\_stealth_shared_utilities::ai_create_behavior_function("animation","wrapper",::maps\_stealth_shared_utilities::enemy_animation_wrapper);
	if(self.type == "dog")
	{
		maps\_stealth_shared_utilities::ai_create_behavior_function("animation","grenade danger",::maps\_stealth_animation_funcs::dog_animation_wakeup_fast);
		maps\_stealth_shared_utilities::ai_create_behavior_function("animation","bulletwhizby",::maps\_stealth_animation_funcs::dog_animation_wakeup_fast);
		maps\_stealth_shared_utilities::ai_create_behavior_function("animation","gunshot_teammate",::maps\_stealth_animation_funcs::dog_animation_wakeup_fast);
		maps\_stealth_shared_utilities::ai_create_behavior_function("animation","projectile_impact",::maps\_stealth_animation_funcs::dog_animation_wakeup_slow);
		return;
	}

	maps\_stealth_shared_utilities::ai_create_behavior_function("animation","grenade danger",::maps\_stealth_animation_funcs::enemy_animation_nothing);
	maps\_stealth_shared_utilities::ai_create_behavior_function("animation","bulletwhizby",::maps\_stealth_animation_funcs::enemy_animation_nothing);
	maps\_stealth_shared_utilities::ai_create_behavior_function("animation","gunshot_teammate",::maps\_stealth_animation_funcs::enemy_animation_nothing);
	maps\_stealth_shared_utilities::ai_create_behavior_function("animation","projectile_impact",::maps\_stealth_animation_funcs::enemy_animation_nothing);
}