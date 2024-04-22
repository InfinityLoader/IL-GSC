/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _cloak_enemy_behavior.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 286 ms
 * Timestamp: 4/22/2024 2:20:17 AM
*******************************************************************/

//Function Number: 1
cloak_enemy_reset_behavior()
{
	self endon("death");
	self endon("_stealth_enemy_alert_level_change");
	wait(randomfloatrange(1,7));
	self._stealth.logic.threat_level = "reset";
	self._cloak_enemy_state = "default_stealth_state";
	maps\_stealth_threat_enemy::enemy_alert_level_normal();
}

//Function Number: 2
cloak_enemy_reset_behavior_mech()
{
	self endon("death");
	self endon("_stealth_enemy_alert_level_change");
	wait(randomfloatrange(1,7));
	self._stealth.logic.threat_level = "reset";
	self._cloak_enemy_state = "default_stealth_state";
	maps\_stealth_threat_enemy::enemy_alert_level_normal();
}

//Function Number: 3
cloak_enemy_warning1_behavior_mech()
{
	self endon("death");
	self endon("_stealth_enemy_alert_level_change");
	self._stealth.logic.threat_level = "warning1";
	thread maps\_stealth_threat_enemy::enemy_announce_alert();
	if(isdefined(self.enemy))
	{
		var_00 = self lastknownpos(self.enemy);
		maps\_utility::ent_flag_set("_stealth_override_goalpos");
		self setgoalpos(var_00);
		self.goalradius = 36;
		self._cloak_enemy_state = "Path 2 LKP";
		self waittill("goal");
		self._cloak_enemy_state = "Looking around LKP";
		maps\_stealth_threat_enemy::enemy_lookaround_for_time(randomfloatrange(2,4));
		self._cloak_enemy_state = "Unknown";
		self.shootposoverride = undefined;
	}
}

//Function Number: 4
cloak_enemy_warning1_behavior()
{
	self endon("death");
	self endon("_stealth_enemy_alert_level_change");
	self._stealth.logic.threat_level = "warning1";
	thread maps\_stealth_threat_enemy::enemy_announce_alert();
	if(isdefined(self.script_patroller))
	{
		var_00 = "a";
		if(common_scripts\utility::cointoss())
		{
			var_00 = "b";
		}

		maps\_stealth_shared_utilities::stealth_set_run_anim("_stealth_patrol_search_" + var_00,1);
		self.disablearrivals = 1;
		self.disableexits = 1;
	}

	if(isdefined(self.enemy))
	{
		var_01 = self lastknownpos(self.enemy);
		maps\_utility::ent_flag_set("_stealth_override_goalpos");
		self setgoalpos(var_01);
		self.goalradius = 36;
		self._cloak_enemy_state = "Path 2 LKP";
		self waittill("goal");
		self._cloak_enemy_state = "Looking around LKP";
		maps\_stealth_threat_enemy::enemy_lookaround_for_time(randomfloatrange(2,4));
		self._cloak_enemy_state = "Unknown";
		self.shootposoverride = undefined;
	}
}

//Function Number: 5
cloak_enemy_warning2_behavior()
{
	self endon("death");
	self endon("_stealth_enemy_alert_level_change");
	self._stealth.logic.threat_level = "warning2";
	maps\_stealth_threat_enemy::enemy_alert_level_warning2();
}

//Function Number: 6
_investigate_last_known_position_with_endons()
{
	self endon("death");
	self endon("_stealth_enemy_alert_level_change");
	self.pathrandompercent = 50;
	self.goalradius = 64;
	maps\_utility::ent_flag_set("_stealth_override_goalpos");
	self setgoalpos(level._stealth.logic.lastknownposition);
	self._cloak_enemy_state = "Path 2 LKP";
	self waittill("goal");
	self._cloak_enemy_state = "Looking around LKP";
	maps\_stealth_threat_enemy::enemy_lookaround_for_time(randomfloatrange(2,4));
}

//Function Number: 7
_investigate_last_known_position_wrapper()
{
	level._stealth.logic.last_known_position_claimed = 1;
	_investigate_last_known_position_with_endons();
	level._stealth.logic.last_known_position_claimed = 0;
	if(isdefined(self))
	{
		self.investigating_last_known_position = 0;
	}
}

//Function Number: 8
cloak_enemy_attack_behavior_mech()
{
	self endon("death");
	self endon("_stealth_enemy_alert_level_change");
	self._stealth.logic.threat_level = "attack";
	self._stealth.logic.has_entered_attack_behavior = 1;
	thread maps\_mech::mech_hunt_stealth_behavior();
}

//Function Number: 9
cloak_enemy_fast_attack_behavior()
{
	var_00 = 10;
	self endon("death");
	self endon("_stealth_enemy_alert_level_change");
	self._stealth.logic.threat_level = "attack";
	self._cloak_enemy_state = "fast_attack";
	thread maps\_stealth_shared_utilities::enemy_announce_spotted(self.origin);
	if(isdefined(self.enemy))
	{
		self.enemy_who_surprised_me = self.enemy;
		self.dontmelee = 1;
		self.disablereactionanims = 1;
		animscripts\shoot_behavior::decidewhatandhowtoshoot("normal");
		wait(var_00);
		self.disablereactionanims = 0;
		self.dontmelee = undefined;
		if(isdefined(self.mech))
		{
			self.dontmelee = 1;
		}

		self.enemy_who_surprised_me = undefined;
	}

	if(isdefined(self.script_goalvolume))
	{
		thread maps\_spawner::set_goal_volume();
		return;
	}

	maps\_stealth_threat_enemy::enemy_close_in_on_target();
}

//Function Number: 10
cloak_enemy_investigative_attack_behavior()
{
	self endon("death");
	self endon("_stealth_enemy_alert_level_change");
	self._stealth.logic.threat_level = "attack";
	self._cloak_enemy_state = "investigative_attack";
	self._stealth.logic.has_entered_attack_behavior = 1;
	thread maps\_stealth_shared_utilities::enemy_announce_spotted(self.origin);
	while(isdefined(self.enemy))
	{
		if(!isdefined(level._stealth.logic.last_known_position_claimed) || !level._stealth.logic.last_known_position_claimed)
		{
			foreach(var_01 in level._stealth.group.groups)
			{
				if(isdefined(common_scripts\utility::array_find(var_01,self)))
				{
					level._stealth.logic.lastknownposition = self lastknownpos(self.enemy);
					if(isarray(var_01))
					{
						var_01 = maps\_utility::array_removedead(var_01);
						var_02 = sortbydistance(var_01,level._stealth.logic.lastknownposition);
						if(isdefined(var_02))
						{
							var_02[0] thread _investigate_last_known_position_wrapper();
							var_02[0].investigating_last_known_position = 1;
						}
					}
				}
			}

			while(isdefined(self.investigating_last_known_position) && self.investigating_last_known_position)
			{
				wait(0.05);
			}

			wait(0.1);
			continue;
		}

		var_05 = getentarray("info_v_stealth","targetname");
		if(isdefined(var_05))
		{
			foreach(var_07 in var_05)
			{
				if(ispointinvolume(level._stealth.logic.lastknownposition,var_07))
				{
					self cleargoalvolume();
					self setgoalvolumeauto(var_07);
					wait(1);
					break;
				}
				else
				{
					self._cloak_enemy_state = "Thinking";
					wait(randomfloatrange(0.2,1));
				}
			}
		}
		else
		{
		}

		self._cloak_enemy_state = "Pathing to Cover";
		self waittill("goal");
		self._cloak_enemy_state = "In Cover";
		wait(1);
	}
}

//Function Number: 11
cloak_enemy_attack_behavior()
{
	var_00 = 180;
	var_01 = 0;
	if(isdefined(self.enemy))
	{
		var_02 = self.enemy.origin;
		var_03 = self.origin;
		if(distance2dsquared(var_03,var_02) < var_00 * var_00)
		{
			var_01 = 1;
		}
	}

	if(var_01)
	{
		cloak_enemy_fast_attack_behavior();
		return;
	}

	if(isdefined(self.mech) && self.mech)
	{
		self.goalradius = 1024;
		self setgoalpos(self lastknownpos(self.enemy));
		wait(randomfloatrange(0.5,1.5));
		self setgoalpos(self.origin);
		cloak_enemy_attack_behavior_mech();
		return;
	}

	if(randomfloatrange(0,1) < 0.33)
	{
		maps\_utility::enable_cqbwalk();
	}

	cloak_enemy_investigative_attack_behavior();
}

//Function Number: 12
cloak_enemy_normal_behavior_mech()
{
	self endon("death");
	self endon("_stealth_enemy_alert_level_change");
	self notify("stop_hunting");
	self._stealth.logic.threat_level = "normal";
	cloak_enemy_reset_behavior_mech();
}

//Function Number: 13
cloak_enemy_normal_behavior()
{
	self endon("death");
	self endon("_stealth_enemy_alert_level_change");
	self._stealth.logic.threat_level = "normal";
	cloak_enemy_reset_behavior();
}

//Function Number: 14
cloak_enemy_state_hidden()
{
	self.fovcosine = 0.5;
	self.fovcosinebusy = 0.1;
	self.favoriteenemy = undefined;
	self.dontattackme = 1;
	self.dontevershoot = 1;
	thread maps\_utility::set_battlechatter(0);
	self.diequietly = 1;
	self clearenemy();
}

//Function Number: 15
cloak_enemy_state_spotted(param_00)
{
	self.fovcosine = 0.01;
	self.ignoreall = 0;
	self.dontattackme = undefined;
	self.dontevershoot = undefined;
	if(isdefined(self.oldfixednode))
	{
		self.fixednode = self.oldfixednode;
	}

	thread maps\_utility::set_battlechatter(1);
	self.diequietly = 0;
	if(!isdefined(param_00))
	{
		maps\_utility::clear_run_anim();
		maps\_stealth_shared_utilities::enemy_stop_current_behavior();
	}

	if(isdefined(param_00))
	{
	}
}

//Function Number: 16
cloak_enemy_default_setup()
{
	if(isplayer(self))
	{
		maps\_stealth_visibility_friendly::stealth_visibility_friendly_main();
		return;
	}

	self._cloak_enemy_state = "default_stealth_state";
	maps\_stealth_utility::stealth_plugin_basic();
	self.pathrandompercent = 0;
	maps\_stealth_utility::stealth_plugin_threat();
	if(isdefined(self.mech))
	{
		var_00["reset"] = ::cloak_enemy_reset_behavior_mech;
		var_00["attack"] = ::cloak_enemy_attack_behavior;
		var_00["normal"] = ::cloak_enemy_normal_behavior_mech;
		var_01 = [];
		var_01["reset"] = ::maps\_stealth_animation_funcs::enemy_animation_nothing;
		var_01["warning"] = ::maps\_stealth_animation_funcs::enemy_animation_nothing;
		var_01["attack"] = ::maps\_stealth_animation_funcs::enemy_animation_nothing;
		maps\_stealth_utility::stealth_threat_behavior_custom(var_00,var_01);
	}
	else
	{
		var_01["reset"] = ::cloak_enemy_reset_behavior;
		var_01["attack"] = ::cloak_enemy_attack_behavior;
		var_01["normal"] = ::cloak_enemy_normal_behavior;
		var_01 = [];
		var_01["reset"] = ::maps\_stealth_animation_funcs::enemy_animation_nothing;
		var_01["warning"] = ::maps\_stealth_animation_funcs::enemy_animation_nothing;
		var_01["attack"] = ::maps\_stealth_animation_funcs::enemy_animation_nothing;
		maps\_stealth_utility::stealth_threat_behavior_custom(var_00,var_01);
	}

	maps\_stealth_utility::stealth_enable_seek_player_on_spotted();
	maps\_stealth_utility::stealth_plugin_corpse();
	maps\_stealth_utility::stealth_plugin_event_all();
	maps\_stealth_event_enemy::stealth_event_mod("heard_alarm",::heard_alarm_reaction_behavior,::maps\_stealth_animation_funcs::enemy_animation_generic);
	self.baseaccuracy = 2;
	self.fovcosine = 0.5;
	self.fovcosinebusy = 0.1;
	var_02 = [];
	if(isdefined(self.mech))
	{
		var_02["hidden"] = ::cloak_enemy_state_hidden;
		var_02["spotted"] = ::cloak_enemy_state_spotted;
	}
	else
	{
		var_02["hidden"] = ::cloak_enemy_state_hidden;
		var_02["spotted"] = ::cloak_enemy_state_spotted;
	}

	maps\_stealth_utility::stealth_basic_states_custom(var_02);
	if(!isdefined(level._cloak_enemy_array))
	{
		level._cloak_enemy_array = [];
	}

	level._cloak_enemy_array[level._cloak_enemy_array.size] = self;
	self setthreatbiasgroup("cloak_enemy_npcs");
	maps\_utility::enable_surprise();
}

//Function Number: 17
cqb_investigate_behavior(param_00)
{
	self endon("_stealth_enemy_alert_level_change");
	level endon("_stealth_spotted");
	self endon("_stealth_attack");
	self endon("death");
	self endon("pain_death");
	self.disablearrivals = 0;
	self.disableexits = 0;
	var_01 = distance(param_00.origin,self.origin);
	self setgoalnode(param_00);
	self.goalradius = var_01 * 0.5;
	wait(0.05);
	maps\_utility::set_generic_run_anim("_stealth_patrol_cqb");
	self._stealth.debug_state = "Investigate-CQB";
	self waittill("goal");
	if(!common_scripts\utility::flag("_stealth_spotted") && !isdefined(self.enemy) || !self cansee(self.enemy))
	{
		maps\_stealth_shared_utilities::enemy_runto_and_lookaround(param_00);
	}
}

//Function Number: 18
heard_alarm_reaction_behavior(param_00)
{
	self endon("death");
	self endon("pain_death");
	level endon("_stealth_spotted");
	self endon("_stealth_attack");
	if(!common_scripts\utility::flag("_stealth_spotted") && !maps\_utility::ent_flag("_stealth_attack"))
	{
		var_01 = self._stealth.logic.event.awareness_param[param_00];
		var_02 = maps\_stealth_shared_utilities::enemy_find_free_pathnode_near(var_01,300,40);
		thread maps\_stealth_shared_utilities::enemy_announce_wtf();
		if(isdefined(var_02))
		{
			thread cqb_investigate_behavior(var_02);
		}
	}

	var_03 = maps\_stealth_shared_utilities::group_get_flagname("_stealth_spotted");
	if(common_scripts\utility::flag(var_03))
	{
		common_scripts\utility::flag_waitopen(var_03);
		return;
	}

	self waittill("normal");
}