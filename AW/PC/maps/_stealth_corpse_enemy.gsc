/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _stealth_corpse_enemy.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 314 ms
 * Timestamp: 4/22/2024 2:23:03 AM
*******************************************************************/

//Function Number: 1
stealth_corpse_enemy_main()
{
	enemy_init();
	thread enemy_corpse_logic();
	thread enemy_corpse_loop();
}

//Function Number: 2
enemy_corpse_loop()
{
	self endon("death");
	self endon("pain_death");
	thread enemy_found_corpse_loop();
	for(;;)
	{
		self waittill("_stealth_saw_corpse");
		if(!maps\_utility::ent_flag("_stealth_enabled"))
		{
			continue;
		}

		enemy_saw_corpse_logic();
	}
}

//Function Number: 3
enemy_found_corpse_loop()
{
	var_00 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
	var_01 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_found_corpse");
	self endon("death");
	self endon("pain_death");
	if(common_scripts\utility::flag(var_00))
	{
		return;
	}

	level endon(var_00);
	for(;;)
	{
		maps\_utility::ent_flag_wait("_stealth_enabled");
		if(maps\_utility::ent_flag_exist("_stealth_behavior_asleep"))
		{
			maps\_utility::ent_flag_waitopen("_stealth_behavior_asleep");
		}

		maps\_stealth_utility::stealth_group_corpse_flag_wait();
		if(!maps\_utility::ent_flag("_stealth_enabled"))
		{
			continue;
		}

		while(maps\_stealth_utility::stealth_group_corpse_flag())
		{
			if(!maps\_utility::ent_flag("_stealth_enabled"))
			{
				break;
			}

			enemy_corpse_found_wrapper();
			level waittill(var_01);
		}
	}
}

//Function Number: 4
enemy_saw_corpse_logic()
{
	var_00 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
	var_01 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_found_corpse");
	if(common_scripts\utility::flag(var_00))
	{
		return;
	}

	level endon(var_00);
	self endon("attack");
	level endon(var_01);
	for(;;)
	{
		maps\_utility::ent_flag_waitopen("_stealth_enemy_alert_level_action");
		enemy_corpse_saw_wrapper();
		self waittill("normal");
	}
}

//Function Number: 5
enemy_corpse_saw_wrapper()
{
	maps\_stealth_shared_utilities::enemy_find_original_goal();
	self endon("enemy_alert_level_change");
	thread maps\_stealth_shared_utilities::enemy_announce_huh();
	maps\_utility::ent_flag_set("_stealth_running_to_corpse");
	maps\_utility::ent_flag_set("_stealth_override_goalpos");
	var_00 = self._stealth.behavior.ai_functions["corpse"];
	self [[ var_00["saw"] ]]();
}

//Function Number: 6
enemy_corpse_found_wrapper()
{
	maps\_stealth_shared_utilities::enemy_find_original_goal();
	if(!maps\_utility::ent_flag("_stealth_found_corpse"))
	{
		self notify("awareness_corpse","heard_corpse",(0,0,0));
	}

	maps\_stealth_shared_utilities::enemy_reaction_state_alert();
	if(self.type == "dog")
	{
		maps\_utility::ent_flag_set("_stealth_override_goalpos");
	}

	thread enemy_corpse_reset_wrapper();
	var_00 = self._stealth.behavior.ai_functions["corpse"];
	self [[ var_00["found"] ]]();
}

//Function Number: 7
enemy_corpse_reset_wrapper()
{
	var_00 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
	self endon("death");
	self endon("_stealth_enemy_alert_level_change");
	level endon(var_00);
	waittillframeend;
	self endon("enemy_awareness_reaction");
	maps\_stealth_utility::stealth_group_corpse_flag_waitopen();
	maps\_utility::ent_flag_set("_stealth_normal");
	var_01 = self._stealth.behavior.ai_functions["corpse"];
	self thread [[ var_01["reset"] ]]();
}

//Function Number: 8
enemy_corpse_saw_behavior()
{
	self.disablearrivals = 0;
	self.disableexits = 0;
	if(self.type != "dog")
	{
		maps\_stealth_shared_utilities::stealth_set_run_anim("_stealth_combat_jog");
	}
	else
	{
		maps\_utility::clear_run_anim();
		self.script_growl = 1;
		self.script_nobark = 1;
	}

	self.goalradius = 80;
	self setgoalpos(self._stealth.logic.corpse.origin);
}

//Function Number: 9
enemy_corpse_found_behavior()
{
	if(self.type == "dog")
	{
		self setgoalpos(self.origin);
		return;
	}

	var_00 = maps\_stealth_shared_utilities::enemy_find_free_pathnode_near(level._stealth.logic.corpse.last_pos,512,40);
	if(!isdefined(var_00))
	{
		return;
	}

	thread maps\_stealth_shared_utilities::enemy_runto_and_lookaround(var_00);
}

//Function Number: 10
enemy_corpse_reset_behavior()
{
	self endon("death");
	wait(randomfloatrange(0,5));
	maps\_stealth_shared_utilities::enemy_stop_current_behavior();
	maps\_stealth_threat_enemy::enemy_alert_level_change("reset");
}

//Function Number: 11
player_can_see_corpse(param_00)
{
	var_01 = maps\_utility::get_closest_player(param_00);
	var_02 = distance(var_01.origin,param_00);
	if(var_02 < 150)
	{
		return 1;
	}

	if(var_02 > level._stealth.logic.corpse.player_distsqrd)
	{
		return 0;
	}

	return sighttracepassed(param_00 + (0,0,48),var_01 geteye(),0,var_01);
}

//Function Number: 12
enemy_corpse_logic()
{
	self endon("death");
	self endon("pain_death");
	thread enemy_corpse_found_loop();
	for(;;)
	{
		if(maps\_utility::ent_flag_exist("_stealth_behavior_asleep"))
		{
			maps\_utility::ent_flag_waitopen("_stealth_behavior_asleep");
		}

		maps\_utility::ent_flag_wait("_stealth_enabled");
		while(!maps\_stealth_utility::stealth_group_spotted_flag() && !maps\_utility::ent_flag("_stealth_attack"))
		{
			var_00 = 0;
			var_01 = 0;
			var_02 = undefined;
			var_03 = undefined;
			var_04 = get_corpse_array();
			for(var_05 = 0;var_05 < var_04.size;var_05++)
			{
				var_02 = var_04[var_05];
				if(isdefined(var_02.found))
				{
					continue;
				}

				if(!isdefined(level.corpse_behavior_doesnt_require_player_sight))
				{
					if(!player_can_see_corpse(var_02.origin))
					{
						continue;
					}
				}

				var_06 = distancesquared(self.origin,var_02.origin);
				if(self.type != "dog")
				{
					var_03 = level._stealth.logic.corpse.found_distsqrd;
				}
				else
				{
					var_03 = level._stealth.logic.corpse.found_dog_distsqrd;
				}

				if(var_06 < var_03)
				{
					var_00 = 1;
					break;
				}

				if(isdefined(self._stealth.logic.corpse.corpse_entity))
				{
					if(self._stealth.logic.corpse.corpse_entity == var_02)
					{
						continue;
					}

					var_07 = distancesquared(self.origin,self._stealth.logic.corpse.corpse_entity.origin);
					if(var_07 <= var_06)
					{
						continue;
					}
				}

				if(var_06 > level._stealth.logic.corpse.sight_distsqrd)
				{
					continue;
				}

				if(var_06 < level._stealth.logic.corpse.detect_distsqrd)
				{
					if(self cansee(var_02))
					{
						var_01 = 1;
						break;
					}
				}

				var_08 = self gettagangles("tag_eye");
				var_09 = self geteye();
				var_0A = anglestoforward(var_08);
				var_0B = vectornormalize(var_02.origin - var_09);
				if(vectordot(var_0A,var_0B) > 0.55)
				{
					if(self cansee(var_02))
					{
						var_01 = 1;
						break;
					}
				}
			}

			if(var_00)
			{
				if(!maps\_utility::ent_flag("_stealth_found_corpse"))
				{
					maps\_utility::ent_flag_set("_stealth_found_corpse");
				}
				else
				{
					self notify("_stealth_found_corpse");
				}

				maps\_utility::ent_flag_clear("_stealth_saw_corpse");
				thread enemy_corpse_found(var_02);
				self notify("awareness_corpse","found_corpse",var_02);
				continue;
			}

			if(var_01)
			{
				self._stealth.logic.corpse.corpse_entity = var_02;
				self._stealth.logic.corpse.origin = var_02.origin;
				if(!maps\_utility::ent_flag("_stealth_saw_corpse"))
				{
					maps\_utility::ent_flag_set("_stealth_saw_corpse");
				}
				else
				{
					self notify("_stealth_saw_corpse");
				}

				level notify("_stealth_saw_corpse");
				self notify("awareness_corpse","saw_corpse",var_02);
			}

			wait(0.5);
		}

		remove_corpse_loop_while_stealth_broken();
		maps\_stealth_utility::stealth_group_spotted_flag_waitopen();
		maps\_utility::ent_flag_waitopen("_stealth_attack");
	}
}

//Function Number: 13
remove_corpse_loop_while_stealth_broken()
{
	var_00 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
	while(common_scripts\utility::flag(var_00))
	{
		var_01 = get_corpse_array();
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			var_03 = var_01[var_02];
			if(isdefined(var_03.found))
			{
				continue;
			}

			var_04 = distancesquared(self.origin,var_03.origin);
			if(self.type != "dog")
			{
				var_05 = level._stealth.logic.corpse.found_distsqrd;
			}
			else
			{
				var_05 = level._stealth.logic.corpse.found_dog_distsqrd;
			}

			if(var_04 < var_05)
			{
				var_03 setcorpseremovetimer(10);
				var_03.found = 1;
			}
		}

		wait(0.5);
	}
}

//Function Number: 14
enemy_corpse_found_loop()
{
	self endon("death");
	self endon("pain_death");
	var_00 = maps\_stealth_utility::stealth_get_group_corpse_flag();
	for(;;)
	{
		level waittill(var_00);
		if(!maps\_stealth_utility::stealth_group_corpse_flag())
		{
			continue;
		}

		enemy_corpse_alert_level();
	}
}

//Function Number: 15
enemy_corpse_alert_level()
{
	var_00 = undefined;
	if(isdefined(self.enemy))
	{
		var_00 = self.enemy;
	}
	else
	{
		var_00 = common_scripts\utility::random(level.players);
	}

	if(!isdefined(var_00._stealth) && !isplayer(var_00))
	{
		return;
	}

	if(!isdefined(var_00._stealth.logic.spotted_list[self.unique_id]))
	{
		var_00._stealth.logic.spotted_list[self.unique_id] = 0;
	}

	if(var_00._stealth.logic.spotted_list[self.unique_id] < self._stealth.logic.alert_level.max_warnings)
	{
		var_00._stealth.logic.spotted_list[self.unique_id]++;
		thread maps\_stealth_shared_utilities::enemy_alert_level_forget(var_00);
	}
}

//Function Number: 16
enemy_corpse_found(param_00)
{
	self endon("death");
	level._stealth.logic.corpse.last_pos = param_00.origin;
	param_00 setcorpseremovetimer(level._stealth.logic.corpse.reset_time);
	param_00.found = 1;
	if(self.type == "dog" && maps\_utility::ent_flag_exist("_stealth_behavior_reaction_anim_in_progress"))
	{
		wait(0.1);
		maps\_utility::ent_flag_waitopen("_stealth_behavior_reaction_anim_in_progress");
		wait(0.5);
	}
	else
	{
		wait(2);
	}

	thread maps\_stealth_shared_utilities::enemy_announce_corpse();
	wait(2);
	var_01 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_found_corpse");
	if(!maps\_stealth_utility::stealth_group_corpse_flag())
	{
		maps\_stealth_shared_utilities::group_flag_set("_stealth_found_corpse");
	}
	else
	{
		level notify(var_01);
	}

	thread enemy_corpse_clear();
}

//Function Number: 17
enemy_corpse_clear()
{
	var_00 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_found_corpse");
	var_01 = self.script_stealthgroup;
	level endon(var_00);
	maps\_utility::waittill_dead_or_dying(maps\_stealth_shared_utilities::group_get_ai_in_group(var_01),undefined,level._stealth.logic.corpse.reset_time);
	thread maps\_stealth_shared_utilities::group_flag_clear("_stealth_found_corpse",var_01);
}

//Function Number: 18
enemy_init()
{
	self._stealth.logic.corpse = spawnstruct();
	self._stealth.logic.corpse.corpse_entity = undefined;
	maps\_utility::ent_flag_init("_stealth_saw_corpse");
	maps\_utility::ent_flag_init("_stealth_found_corpse");
	enemy_default_corpse_behavior();
	enemy_default_corpse_anim_behavior();
	self._stealth.plugins.corpse = 1;
}

//Function Number: 19
enemy_default_corpse_anim_behavior()
{
	if(self.type == "dog")
	{
		maps\_stealth_shared_utilities::ai_create_behavior_function("animation","heard_corpse",::maps\_stealth_animation_funcs::dog_animation_generic);
		maps\_stealth_shared_utilities::ai_create_behavior_function("animation","saw_corpse",::maps\_stealth_animation_funcs::dog_animation_sawcorpse);
		maps\_stealth_shared_utilities::ai_create_behavior_function("animation","found_corpse",::maps\_stealth_animation_funcs::dog_animation_foundcorpse);
		maps\_stealth_shared_utilities::ai_create_behavior_function("animation","howl",::maps\_stealth_animation_funcs::dog_animation_howl);
		return;
	}

	maps\_stealth_shared_utilities::ai_create_behavior_function("animation","heard_corpse",::maps\_stealth_animation_funcs::enemy_animation_generic);
	maps\_stealth_shared_utilities::ai_create_behavior_function("animation","saw_corpse",::maps\_stealth_animation_funcs::enemy_animation_sawcorpse);
	maps\_stealth_shared_utilities::ai_create_behavior_function("animation","found_corpse",::maps\_stealth_animation_funcs::enemy_animation_foundcorpse);
}

//Function Number: 20
enemy_default_corpse_behavior()
{
	var_00 = [];
	var_00["saw"] = ::enemy_corpse_saw_behavior;
	var_00["found"] = ::enemy_corpse_found_behavior;
	var_00["reset"] = ::enemy_corpse_reset_behavior;
	enemy_custom_corpse_behavior(var_00);
}

//Function Number: 21
enemy_custom_corpse_behavior(param_00)
{
	foreach(var_03, var_02 in param_00)
	{
		maps\_stealth_shared_utilities::ai_create_behavior_function("corpse",var_03,var_02);
	}
}

//Function Number: 22
get_corpse_array()
{
	if(isdefined(level._stealth.logic.corpse.collect_func))
	{
		return [[ level._stealth.logic.corpse.collect_func ]]();
	}

	return getcorpsearray();
}