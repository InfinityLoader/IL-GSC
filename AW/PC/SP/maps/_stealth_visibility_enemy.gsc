/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_stealth_visibility_enemy.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 291 ms
 * Timestamp: 10/27/2023 2:01:05 AM
*******************************************************************/

//Function Number: 1
stealth_visibility_enemy_main()
{
	enemy_init();
	thread enemy_threat_logic();
}

//Function Number: 2
enemy_threat_logic()
{
	self endon("death");
	self endon("pain_death");
	for(;;)
	{
		maps\_utility::ent_flag_wait("_stealth_enabled");
		self waittill("enemy");
		if(!maps\_utility::ent_flag("_stealth_enabled"))
		{
			continue;
		}

		if(!isalive(self.enemy))
		{
			continue;
		}

		if(!maps\_stealth_utility::stealth_group_spotted_flag())
		{
			if(!enemy_alert_level_logic(self.enemy))
			{
				continue;
			}
		}
		else
		{
			maps\_stealth_threat_enemy::enemy_alert_level_change("attack");
		}

		thread enemy_threat_set_spotted();
		wait(10);
		while(isdefined(self.enemy) && maps\_utility::ent_flag("_stealth_enabled"))
		{
			var_00 = gettime() - self lastknowntime(self.enemy);
			if(20000 > var_00)
			{
				wait(20000 - var_00 * 0.001);
				continue;
			}

			if(distance(self.origin,self.enemy.origin) > self.enemy.maxvisibledist)
			{
				break;
			}

			wait(0.5);
		}

		if(!maps\_utility::ent_flag("_stealth_enabled"))
		{
			continue;
		}

		maps\_utility::ent_flag_waitopen("_stealth_behavior_reaction_anim_in_progress");
		if(isdefined(self.enemy))
		{
			maps\_stealth_shared_utilities::enemy_alert_level_forget(self.enemy,0);
		}

		self clearenemy();
		maps\_stealth_threat_enemy::enemy_alert_level_change("reset");
	}
}

//Function Number: 3
enemy_alert_level_logic(param_00)
{
	if(!isdefined(param_00._stealth))
	{
		return 1;
	}

	if(!isdefined(param_00._stealth.logic.spotted_list[self.unique_id]))
	{
		param_00._stealth.logic.spotted_list[self.unique_id] = 0;
	}

	for(;;)
	{
		param_00._stealth.logic.spotted_list[self.unique_id]++;
		if(maps\_utility::ent_flag("_stealth_bad_event_listener") || param_00._stealth.logic.spotted_list[self.unique_id] > self._stealth.logic.alert_level.max_warnings)
		{
			maps\_stealth_threat_enemy::enemy_alert_level_change("attack");
			return 1;
		}

		var_01 = param_00._stealth.logic.spotted_list[self.unique_id];
		maps\_stealth_threat_enemy::enemy_alert_level_change("warning" + var_01);
		thread maps\_stealth_shared_utilities::enemy_alert_level_forget(param_00);
		enemy_alert_level_waittime(param_00);
		if(!isdefined(param_00) || gettime() - self lastknowntime(param_00) > 500)
		{
			self clearenemy();
			return 0;
		}
	}
}

//Function Number: 4
enemy_threat_set_spotted()
{
	self endon("death");
	self endon("pain_death");
	var_00 = self.enemy;
	self.dontevershoot = undefined;
	self [[ self._stealth.logic.pre_spotted_func ]]();
	if(isdefined(var_00))
	{
		level._stealth.group.spotted_enemy[self.script_stealthgroup] = var_00;
	}

	maps\_stealth_shared_utilities::group_flag_set("_stealth_spotted");
}

//Function Number: 5
enemy_prespotted_func_default()
{
	wait(2.25);
}

//Function Number: 6
enemy_alert_level_waittime(param_00)
{
	if(maps\_stealth_utility::stealth_group_corpse_flag() || maps\_utility::ent_flag("_stealth_bad_event_listener"))
	{
		return;
	}

	var_01 = distance(self.origin,param_00.origin) * 0.0005;
	var_02 = level._stealth.logic.min_alert_level_duration + var_01;
	maps\_stealth_shared_utilities::stealth_debug_print("WARNING time = " + var_02);
	level endon(maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted"));
	self endon("_stealth_bad_event_listener");
	wait(var_02);
}

//Function Number: 7
enemy_event_listeners_logic()
{
	self endon("death");
	self addaieventlistener("grenade danger");
	self addaieventlistener("gunshot");
	self addaieventlistener("gunshot_teammate");
	self addaieventlistener("silenced_shot");
	self addaieventlistener("bulletwhizby");
	self addaieventlistener("projectile_impact");
	for(;;)
	{
		self waittill("ai_event",var_00,var_01);
		if(!maps\_utility::ent_flag("_stealth_enabled"))
		{
			continue;
		}

		if(maps\_utility::ent_flag_exist("_stealth_behavior_asleep") && maps\_utility::ent_flag("_stealth_behavior_asleep"))
		{
			continue;
		}

		maps\_utility::ent_flag_set("_stealth_bad_event_listener");
	}
}

//Function Number: 8
enemy_event_listeners_proc()
{
	self endon("death");
	for(;;)
	{
		maps\_utility::ent_flag_wait("_stealth_bad_event_listener");
		wait(0.65);
		maps\_utility::ent_flag_clear("_stealth_bad_event_listener");
	}
}

//Function Number: 9
enemy_event_awareness_notify(param_00,param_01)
{
	maps\_utility::ent_flag_clear("_stealth_normal");
	self._stealth.logic.event.awareness_param[param_00] = param_01;
	self notify("event_awareness",param_00);
	level notify("event_awareness",param_00);
}

//Function Number: 10
enemy_event_category_awareness(param_00)
{
	self endon("death");
	self endon("pain_death");
	self waittill(param_00,var_01,var_02);
	if(!maps\_utility::ent_flag("_stealth_enabled"))
	{
		continue;
	}

	switch(param_00)
	{
		case "awareness_alert_level":
			break;

		case "ai_event":
			break;

		default:
			break;
	}
}

//Function Number: 11
enemy_event_awareness(param_00)
{
	self endon("death");
	self endon("pain_death");
	self._stealth.logic.event.awareness_param[param_00] = 1;
	for(;;)
	{
		self waittill(param_00,var_01);
		if(!maps\_utility::ent_flag("_stealth_enabled"))
		{
			continue;
		}

		maps\_stealth_shared_utilities::group_flag_set("_stealth_event");
		level thread enemy_event_handle_clear(self.script_stealthgroup);
		enemy_event_awareness_notify(param_00,var_01);
		waittillframeend;
	}
}

//Function Number: 12
enemy_event_handle_clear(param_00)
{
	var_01 = "enemy_event_handle_clear:" + param_00 + " Proc";
	var_02 = "enemy_event_handle_clear:" + param_00 + " Cleared";
	level notify(var_01);
	level endon(var_01);
	wait(2);
	var_03 = maps\_stealth_shared_utilities::group_get_ai_in_group(param_00);
	if(var_03.size)
	{
		level maps\_utility::add_wait(::maps\_utility::array_wait,var_03,"event_awareness_waitclear_ai");
		level maps\_utility::add_endon(var_01);
		level maps\_utility::add_func(::maps\_utility::send_notify,var_02);
		level thread maps\_utility::do_wait();
		common_scripts\utility::array_thread(var_03,::event_awareness_waitclear_ai,var_01);
		level waittill(var_02);
	}

	maps\_stealth_shared_utilities::group_flag_clear("_stealth_event",param_00);
}

//Function Number: 13
event_awareness_waitclear_ai(param_00)
{
	level endon(param_00);
	event_awareness_waitclear_ai_proc();
	self notify("event_awareness_waitclear_ai");
}

//Function Number: 14
event_awareness_waitclear_ai_proc()
{
	self endon("death");
	waittillframeend;
	var_00 = 0;
	if(isdefined(self.ent_flag["_stealth_behavior_first_reaction"]))
	{
		var_00 = maps\_utility::ent_flag("_stealth_behavior_first_reaction");
	}

	var_01 = 0;
	if(isdefined(self.ent_flag["_stealth_behavior_reaction_anim"]))
	{
		var_01 = maps\_utility::ent_flag("_stealth_behavior_reaction_anim");
	}

	if(!var_00 && !var_01)
	{
		return;
	}

	maps\_utility::add_wait(::maps\_utility::waittill_msg,"death");
	maps\_utility::add_wait(::maps\_utility::waittill_msg,"going_back");
	maps\_utility::do_wait_any();
	self endon("goal");
	var_02 = common_scripts\utility::array_combine(getaiarray("allies"),level.players);
	var_03 = level._stealth.logic.detect_range["hidden"]["crouch"];
	var_04 = var_03 * var_03;
	var_05 = 1;
	if(var_05)
	{
		var_05 = 0;
		foreach(var_07 in var_02)
		{
			if(distancesquared(self.origin,var_07.origin) < var_04)
			{
				continue;
			}

			var_05 = 1;
		}

		wait(1);
	}
}

//Function Number: 15
enemy_event_declare_to_team(param_00,param_01)
{
	var_02 = undefined;
	var_03 = self.team;
	if(!isalive(self))
	{
		return;
	}

	self waittill(param_00,var_04,var_05);
	if(isalive(self) && !maps\_utility::ent_flag("_stealth_enabled"))
	{
		continue;
	}

	switch(param_00)
	{
		case "death":
			break;

		case "damage":
			break;
	}
}

//Function Number: 16
enemy_init()
{
	self clearenemy();
	self._stealth = spawnstruct();
	self._stealth.logic = spawnstruct();
	maps\_utility::ent_flag_init("_stealth_enabled");
	maps\_utility::ent_flag_set("_stealth_enabled");
	maps\_utility::ent_flag_init("_stealth_normal");
	maps\_utility::ent_flag_set("_stealth_normal");
	maps\_utility::ent_flag_init("_stealth_attack");
	maps\_stealth_shared_utilities::group_flag_init("_stealth_spotted");
	maps\_stealth_shared_utilities::group_flag_init("_stealth_event");
	maps\_stealth_shared_utilities::group_flag_init("_stealth_found_corpse");
	maps\_stealth_shared_utilities::group_add_to_global_list();
	if(!isdefined(level._stealth.behavior.sound["spotted"][self.script_stealthgroup]))
	{
		level._stealth.behavior.sound["spotted"][self.script_stealthgroup] = 0;
	}

	self._stealth.logic.alert_level = spawnstruct();
	self._stealth.logic.alert_level.max_warnings = 0;
	enemy_alert_level_default_pre_spotted_func();
	enemy_event_listeners_init();
}

//Function Number: 17
enemy_event_listeners_init()
{
	maps\_utility::ent_flag_init("_stealth_bad_event_listener");
	self._stealth.logic.event = spawnstruct();
	thread enemy_event_listeners_logic();
	thread enemy_event_declare_to_team("damage","ai_eventDistPain");
	thread enemy_event_declare_to_team("death","ai_eventDistDeath");
	thread enemy_event_listeners_proc();
	self._stealth.logic.event.awareness_param = [];
	self._stealth.logic.event.aware_aievents = [];
	self._stealth.logic.event.aware_aievents["bulletwhizby"] = 1;
	self._stealth.logic.event.aware_aievents["projectile_impact"] = 1;
	self._stealth.logic.event.aware_aievents["gunshot_teammate"] = 1;
	self._stealth.logic.event.aware_aievents["grenade danger"] = 1;
	thread enemy_event_category_awareness("ai_event");
	thread enemy_event_category_awareness("awareness_alert_level");
	thread enemy_event_category_awareness("awareness_corpse");
}

//Function Number: 18
enemy_alert_level_set_pre_spotted_func(param_00)
{
	self._stealth.logic.pre_spotted_func = param_00;
}

//Function Number: 19
enemy_alert_level_default_pre_spotted_func()
{
	self._stealth.logic.pre_spotted_func = ::enemy_prespotted_func_default;
}