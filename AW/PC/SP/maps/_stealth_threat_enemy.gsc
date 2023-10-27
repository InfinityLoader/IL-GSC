/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_stealth_threat_enemy.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 395 ms
 * Timestamp: 10/27/2023 2:00:59 AM
*******************************************************************/

//Function Number: 1
stealth_threat_enemy_main()
{
	enemy_init();
	thread enemy_threat_loop();
}

//Function Number: 2
enemy_threat_loop()
{
	self endon("death");
	self endon("pain_death");
	if(self.type == "dog")
	{
		thread enemy_threat_logic_dog();
	}

	for(;;)
	{
		self waittill("_stealth_enemy_alert_level_change",var_00);
		if(!maps\_utility::ent_flag("_stealth_enabled"))
		{
			continue;
		}

		enemy_alert_level_change_reponse(var_00);
	}
}

//Function Number: 3
enemy_alert_level_change_reponse(param_00)
{
	maps\_utility::ent_flag_set("_stealth_enemy_alert_level_action");
	var_01 = param_00;
	if(issubstr(param_00,"warning"))
	{
		var_01 = "warning";
	}

	switch(var_01)
	{
		case "warning":
			break;

		case "attack":
			break;

		case "reset":
			break;
	}
}

//Function Number: 4
enemy_threat_logic_dog()
{
	self endon("death");
	self endon("pain_death");
	if(!maps\_utility::ent_flag("_stealth_behavior_asleep"))
	{
		return;
	}

	enemy_threat_logic_dog_wait();
	wait(0.5);
	maps\_utility::delaythread(0.6,::maps\_utility::ent_flag_clear,"_stealth_behavior_asleep");
	self.ignoreall = 0;
}

//Function Number: 5
enemy_threat_logic_dog_wait()
{
	self endon("pain");
	self endon("enemy");
	common_scripts\utility::array_thread(level.players,::enemy_threat_logic_dog_wakeup_dist,self,128);
	for(;;)
	{
		self waittill("event_awareness",var_00);
		if(!maps\_utility::ent_flag("_stealth_enabled"))
		{
			continue;
		}

		if(var_00 == "heard_scream" || var_00 == "bulletwhizby" || var_00 == "projectile_impact" || var_00 == "explode")
		{
			return;
		}
	}
}

//Function Number: 6
enemy_threat_logic_dog_wakeup_dist(param_00,param_01)
{
	param_00 endon("death");
	self endon("death");
	if(!param_00 maps\_utility::ent_flag("_stealth_behavior_asleep"))
	{
		return;
	}

	param_00 endon("_stealth_behavior_asleep");
	var_02 = param_01 * param_01;
	while(distancesquared(self.origin,param_00.origin) > var_02 && maps\_utility::ent_flag("_stealth_enabled"))
	{
		wait(0.1);
	}

	param_00.ignoreall = 0;
	param_00.favoriteenemy = self;
	wait(0.1);
	param_00.favoriteenemy = undefined;
}

//Function Number: 7
enemy_alert_level_reset_wrapper()
{
	self endon("_stealth_enemy_alert_level_change");
	self endon("enemy_awareness_reaction");
	self endon("death");
	self endon("pain_death");
	maps\_stealth_utility::stealth_group_spotted_flag_waitopen();
	maps\_stealth_shared_utilities::enemy_stop_current_behavior();
	maps\_utility::ent_flag_clear("_stealth_enemy_alert_level_action");
	if(isdefined(self._stealth.plugins.corpse))
	{
		maps\_utility::ent_flag_clear("_stealth_saw_corpse");
		maps\_utility::ent_flag_clear("_stealth_found_corpse");
	}

	maps\_utility::ent_flag_clear("_stealth_attack");
	maps\_utility::ent_flag_set("_stealth_normal");
	var_00 = maps\_stealth_shared_utilities::ai_get_behavior_function("threat","reset");
	self thread [[ var_00 ]]();
}

//Function Number: 8
enemy_alert_level_warning_wrapper(param_00)
{
	var_01 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
	self endon("_stealth_enemy_alert_level_change");
	level endon(var_01);
	self endon("death");
	self endon("pain_death");
	self endon("event_awareness");
	maps\_stealth_shared_utilities::enemy_find_original_goal();
	maps\_stealth_shared_utilities::enemy_stop_current_behavior();
	var_02 = maps\_stealth_shared_utilities::ai_get_behavior_function("threat",param_00);
	self [[ var_02 ]]();
	enemy_alert_level_normal_wrapper();
}

//Function Number: 9
enemy_lookaround_for_time(param_00)
{
	var_01 = self.fovcosine;
	self.fovcosine = 0.1;
	if(isdefined(self.mech) && self.mech)
	{
		maps\_stealth_shared_utilities::stealth_set_idle_anim("mech_stealth_look_around");
	}
	else
	{
		maps\_stealth_shared_utilities::stealth_set_idle_anim("_stealth_look_around");
	}

	wait(param_00);
	maps\_utility::clear_generic_idle_anim();
	self.fovcosine = var_01;
}

//Function Number: 10
enemy_announce_alert()
{
	self endon("death");
	wait(0.25);
	if(isdefined(self.enemy) && self cansee(self.enemy))
	{
		maps\_stealth_shared_utilities::enemy_announce_snd("huh");
		thread maps\_stealth_shared_utilities::enemy_announce_attack();
		return;
	}

	thread maps\_stealth_shared_utilities::enemy_announce_huh();
}

//Function Number: 11
enemy_alert_level_warning1()
{
	if(!isdefined(self.enemy))
	{
		return;
	}

	thread enemy_announce_alert();
	if(isdefined(self.script_patroller))
	{
		if(self.type != "dog")
		{
			var_00 = "a";
			if(common_scripts\utility::cointoss())
			{
				var_00 = "b";
			}

			maps\_stealth_shared_utilities::stealth_set_run_anim("_stealth_patrol_search_" + var_00,1);
		}
		else
		{
			maps\_utility::set_dog_walk_anim();
			self.script_growl = 1;
		}

		self.disablearrivals = 1;
		self.disableexits = 1;
	}
	else if(self.type == "dog")
	{
		maps\_utility::set_dog_walk_anim();
		self.script_growl = 1;
		self.disablearrivals = 1;
		self.disableexits = 1;
	}

	var_01 = vectornormalize(self.enemy.origin - self.origin);
	var_02 = distance(self.enemy.origin,self.origin);
	var_02 = var_02 * 0.25;
	var_02 = clamp(var_02,64,128);
	var_01 = var_01 * var_02;
	var_03 = self.origin + var_01 + (0,0,16);
	var_04 = var_03 + (0,0,-96);
	var_03 = physicstrace(var_03,var_04);
	if(var_03 == var_04)
	{
		return;
	}

	maps\_utility::ent_flag_set("_stealth_override_goalpos");
	self setgoalpos(var_03);
	self.goalradius = 64;
	common_scripts\utility::waittill_notify_or_timeout("goal",2);
	if(!self isingoal(self.origin))
	{
		self.shootposoverride = var_03 + (0,0,64);
	}

	enemy_lookaround_for_time(10);
	self.shootposoverride = undefined;
}

//Function Number: 12
enemy_alert_level_warning2()
{
	if(!isdefined(self.enemy))
	{
		return;
	}

	thread enemy_announce_alert();
	if(self.type != "dog")
	{
		maps\_stealth_shared_utilities::stealth_set_run_anim("_stealth_patrol_cqb");
	}
	else
	{
		maps\_utility::clear_run_anim();
		self.script_nobark = 1;
		self.script_growl = 1;
	}

	self.disablearrivals = 0;
	self.disableexits = 0;
	var_00 = self.enemy.origin;
	var_01 = distance(var_00,self.origin);
	maps\_utility::ent_flag_set("_stealth_override_goalpos");
	self setgoalpos(var_00);
	self.goalradius = var_01 * 0.5;
	self waittill("goal");
	if(self.type != "dog")
	{
		var_02 = "_stealth_patrol_search_a";
		if(common_scripts\utility::cointoss())
		{
			var_02 = "_stealth_patrol_search_b";
		}

		maps\_stealth_shared_utilities::stealth_set_run_anim(var_02,1);
	}
	else
	{
		maps\_stealth_shared_utilities::stealth_anim_custom_animmode(self,"gravity","_stealth_dog_stop");
		maps\_utility::set_dog_walk_anim();
	}

	self setgoalpos(var_00);
	self.goalradius = 64;
	self.disablearrivals = 1;
	self.disableexits = 1;
	self waittill("goal");
	enemy_lookaround_for_time(15);
	if(self.type != "dog")
	{
		var_02 = "a";
		if(randomint(100) > 50)
		{
			var_02 = "b";
		}

		maps\_stealth_shared_utilities::stealth_set_run_anim("_stealth_patrol_search_" + var_02,1);
		return;
	}

	maps\_utility::set_dog_walk_anim();
	self.script_growl = undefined;
}

//Function Number: 13
enemy_alert_level_attack_wrapper()
{
	self endon("death");
	self endon("pain_death");
	self endon("_stealth_enemy_alert_level_change");
	if(common_scripts\utility::flag("_cloaked_stealth_enabled"))
	{
		var_00 = self.origin;
		self setruntopos(var_00);
	}
	else
	{
		self notify("endNewEnemyReactionAnim");
	}

	self notify("movemode");
	self.disablearrivals = 0;
	self.disableexits = 0;
	maps\_stealth_shared_utilities::enemy_find_original_goal();
	maps\_utility::ent_flag_set("_stealth_attack");
	var_01 = maps\_stealth_shared_utilities::ai_get_behavior_function("threat","attack");
	self [[ var_01 ]]();
}

//Function Number: 14
enemy_alert_level_attack()
{
	thread maps\_stealth_shared_utilities::enemy_announce_spotted(self.origin);
	if(isdefined(self.script_goalvolume))
	{
		thread maps\_spawner::set_goal_volume();
		return;
	}

	enemy_close_in_on_target();
}

//Function Number: 15
enemy_close_in_on_target()
{
	var_00 = 2048;
	self.goalradius = var_00;
	if(isdefined(self.script_stealth_dontseek) && self.script_stealth_dontseek == 1)
	{
		return;
	}

	self endon("death");
	maps\_utility::ent_flag_set("_stealth_override_goalpos");
	while(isdefined(self.enemy) && maps\_utility::ent_flag("_stealth_enabled"))
	{
		self setgoalpos(self.enemy.origin);
		self.goalradius = var_00;
		if(var_00 > 600)
		{
			var_00 = var_00 * 0.75;
		}
		else
		{
			return;
		}

		wait(15);
		if(isdefined(self.script_stealth_dontseek) && self.script_stealth_dontseek == 1)
		{
			return;
		}
	}
}

//Function Number: 16
enemy_alert_level_normal_wrapper()
{
	enemy_set_alert_level("reset");
	maps\_utility::ent_flag_clear("_stealth_enemy_alert_level_action");
	if(maps\_utility::ent_flag_exist("_stealth_saw_corpse"))
	{
		maps\_utility::ent_flag_waitopen("_stealth_saw_corpse");
	}

	wait(0.05);
	if(maps\_utility::ent_flag_exist("_stealth_found_corpse"))
	{
		maps\_utility::ent_flag_waitopen("_stealth_found_corpse");
	}

	maps\_utility::ent_flag_set("_stealth_normal");
	var_00 = maps\_stealth_shared_utilities::ai_get_behavior_function("threat","normal");
	self [[ var_00 ]]();
}

//Function Number: 17
enemy_alert_level_normal()
{
	thread maps\_stealth_shared_utilities::enemy_announce_hmph();
	maps\_stealth_shared_utilities::enemy_go_back();
}

//Function Number: 18
enemy_init()
{
	enemy_default_threat_behavior();
	enemy_default_threat_anim_behavior();
	self._stealth.plugins.threat = 1;
	self.script_stealth_dontseek = 1;
	self.alertlevel = "noncombat";
	self.newenemyreactiondistsq = squared(level._stealth.logic.ai_event["ai_eventDistFootstepSprint"]["hidden"]);
}

//Function Number: 19
enemy_default_threat_behavior()
{
	var_00 = [];
	var_00["reset"] = ::enemy_alert_level_normal;
	var_00["warning1"] = ::enemy_alert_level_warning1;
	var_00["warning2"] = ::enemy_alert_level_warning2;
	var_00["attack"] = ::enemy_alert_level_attack;
	var_00["normal"] = ::enemy_alert_level_normal;
	if(!isdefined(level._stealth.logic.alert_level_table))
	{
		level._stealth.logic.alert_level_table = [];
		level._stealth.logic.alert_level_table["reset"] = "noncombat";
		level._stealth.logic.alert_level_table["warning"] = "alert";
		level._stealth.logic.alert_level_table["attack"] = "combat";
	}

	enemy_set_threat_behavior(var_00);
}

//Function Number: 20
enemy_set_alert_level(param_00)
{
	self.alertlevel = level._stealth.logic.alert_level_table[param_00];
}

//Function Number: 21
enemy_set_threat_behavior(param_00)
{
	self._stealth.behavior.ai_functions["threat"] = [];
	if(!isdefined(param_00["reset"]))
	{
		param_00["reset"] = ::enemy_alert_level_normal;
	}

	if(!isdefined(param_00["attack"]))
	{
		param_00["attack"] = ::enemy_alert_level_attack;
	}

	if(!isdefined(param_00["normal"]))
	{
		param_00["normal"] = ::enemy_alert_level_normal;
	}

	foreach(var_03, var_02 in param_00)
	{
		maps\_stealth_shared_utilities::ai_create_behavior_function("threat",var_03,var_02);
	}

	self._stealth.logic.alert_level.max_warnings = param_00.size - 3;
}

//Function Number: 22
enemy_alert_level_change(param_00)
{
	self notify("_stealth_enemy_alert_level_change",param_00);
	if(!isdefined(self._stealth.plugins.threat))
	{
		self.goalradius = level.default_goalradius;
		return;
	}

	if(issubstr(param_00,"warning"))
	{
		param_00 = "warning";
	}

	enemy_set_alert_level(param_00);
	self notify("awareness_alert_level",param_00);
}

//Function Number: 23
enemy_threat_anim_defaults()
{
	var_00 = [];
	var_00["reset"] = ::maps\_stealth_animation_funcs::enemy_animation_nothing;
	var_00["warning"] = ::maps\_stealth_animation_funcs::enemy_animation_nothing;
	if(self.type == "dog")
	{
		var_00["attack"] = ::maps\_stealth_animation_funcs::dog_animation_generic;
	}
	else
	{
		var_00["attack"] = ::maps\_stealth_animation_funcs::enemy_animation_attack;
	}

	return var_00;
}

//Function Number: 24
enemy_set_threat_anim_behavior(param_00)
{
	var_01 = enemy_threat_anim_defaults();
	if(!isdefined(param_00["reset"]))
	{
		param_00["reset"] = var_01["reset"];
	}

	if(!isdefined(param_00["warning"]))
	{
		param_00["warning"] = var_01["warning"];
	}

	if(!isdefined(param_00["attack"]))
	{
		param_00["attack"] = var_01["attack"];
	}

	foreach(var_04, var_03 in param_00)
	{
		maps\_stealth_shared_utilities::ai_create_behavior_function("animation",var_04,var_03);
	}
}

//Function Number: 25
enemy_default_threat_anim_behavior()
{
	var_00 = enemy_threat_anim_defaults();
	enemy_set_threat_anim_behavior(var_00);
}