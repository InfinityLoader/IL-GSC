/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_stealth_shared_utilities.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 64
 * Decompile Time: 1062 ms
 * Timestamp: 10/27/2023 2:00:56 AM
*******************************************************************/

//Function Number: 1
ai_message_handler_spotted(param_00,param_01)
{
	self endon("death");
	param_01 = param_01 + "spotted";
	self notify(param_01);
	self endon(param_01);
	switch(self.team)
	{
		case "allies":
			break;

		case "team3":
		case "axis":
			break;
	}
}

//Function Number: 2
ai_message_handler_hidden(param_00,param_01)
{
	self endon("death");
	param_01 = param_01 + "hidden";
	self notify(param_01);
	self endon(param_01);
	switch(self.team)
	{
		case "allies":
			break;

		case "team3":
		case "axis":
			break;
	}
}

//Function Number: 3
ai_create_behavior_function(param_00,param_01,param_02)
{
	self._stealth.behavior.ai_functions[param_00][param_01] = param_02;
}

//Function Number: 4
ai_get_behavior_function(param_00,param_01)
{
	return self._stealth.behavior.ai_functions[param_00][param_01];
}

//Function Number: 5
ai_set_goback_override_function(param_00)
{
	self._stealth.behavior.goback_startfunc = param_00;
}

//Function Number: 6
stealth_event_validate(param_00)
{
	if(param_00 == "heard_scream" || param_00 == "doFlashBanged" || param_00 == "explode")
	{
		return 1;
	}

	return 0;
}

//Function Number: 7
stealth_debug_print(param_00)
{
}

//Function Number: 8
enemy_event_debug_print(param_00)
{
	setdvarifuninitialized("stealth_debug_prints","0");
	if(!isdefined(getdvar("stealth_debug_prints")))
	{
		setdvar("stealth_debug_prints","0");
	}

	if(getdvarint("stealth_debug_prints") != 1)
	{
	}
}

//Function Number: 9
stealth_flag_debug_print(param_00)
{
}

//Function Number: 10
group_flag_init(param_00)
{
	if(isdefined(self.script_stealthgroup))
	{
		self.script_stealthgroup = maps\_utility::string(self.script_stealthgroup);
	}
	else
	{
		self.script_stealthgroup = "default";
	}

	var_01 = group_get_flagname(param_00);
	if(!common_scripts\utility::flag_exist(var_01))
	{
		common_scripts\utility::flag_init(var_01);
		if(!isdefined(level._stealth.group.flags[param_00]))
		{
			level._stealth.group.flags[param_00] = [];
		}

		var_02 = level._stealth.group.flags[param_00].size;
		level._stealth.group.flags[param_00][var_02] = var_01;
	}
}

//Function Number: 11
group_add_to_global_list()
{
	if(!isdefined(level._stealth.group.groups[self.script_stealthgroup]))
	{
		level._stealth.group.groups[self.script_stealthgroup] = [];
		level._stealth.group notify(self.script_stealthgroup);
	}

	var_00 = level._stealth.group.groups[self.script_stealthgroup].size;
	level._stealth.group.groups[self.script_stealthgroup][var_00] = self;
}

//Function Number: 12
group_get_flagname(param_00)
{
	return group_get_flagname_from_group(param_00,self.script_stealthgroup);
}

//Function Number: 13
group_get_flagname_from_group(param_00,param_01)
{
	var_02 = param_00 + "-Group:" + param_01;
	return var_02;
}

//Function Number: 14
group_flag_set(param_00)
{
	var_01 = group_get_flagname(param_00);
	common_scripts\utility::flag_set(var_01);
	common_scripts\utility::flag_set(param_00);
}

//Function Number: 15
group_return_groups_with_flag_set(param_00)
{
	var_01 = [];
	var_02 = level._stealth.group.groups;
	foreach(var_06, var_04 in var_02)
	{
		var_05 = group_get_flagname_from_group(param_00,var_06);
		if(common_scripts\utility::flag(var_05))
		{
			var_01[var_01.size] = var_06;
		}
	}

	return var_01;
}

//Function Number: 16
group_return_ai_with_flag_set(param_00)
{
	var_01 = [];
	var_02 = level._stealth.group.groups;
	foreach(var_07, var_04 in var_02)
	{
		var_05 = group_get_flagname_from_group(param_00,var_07);
		if(common_scripts\utility::flag(var_05))
		{
			var_06 = group_get_ai_in_group(var_07);
			var_01 = maps\_utility::array_merge(var_01,var_06);
		}
	}

	return var_01;
}

//Function Number: 17
group_flag_clear(param_00,param_01)
{
	var_02 = group_get_flagname_from_group(param_00,param_01);
	common_scripts\utility::flag_clear(var_02);
	var_03 = level._stealth.group.flags[param_00];
	var_04 = 1;
	foreach(var_06 in var_03)
	{
		if(common_scripts\utility::flag(var_06))
		{
			return;
		}
	}

	common_scripts\utility::flag_clear(param_00);
}

//Function Number: 18
group_get_ai_in_group(param_00)
{
	level._stealth.group.groups[param_00] = maps\_utility::array_removedead(level._stealth.group.groups[param_00]);
	return level._stealth.group.groups[param_00];
}

//Function Number: 19
group_wait_group_spawned(param_00)
{
	if(!isdefined(level._stealth.group.groups[param_00]))
	{
		level._stealth.group waittill(param_00);
	}
}

//Function Number: 20
ai_stealth_pause_handler()
{
	self endon("death");
	self endon("pain_death");
	maps\_utility::ent_flag_waitopen("_stealth_enabled");
	var_00 = self._stealth.behavior.ai_functions["state"]["spotted"];
	switch(self.team)
	{
		case "allies":
			break;

		case "team3":
		case "axis":
			break;
	}
}

//Function Number: 21
enemy_go_back()
{
	self notify("going_back");
	self endon("death");
	self notify("stop_loop");
	self._stealth.debug_state = "Going Back";
	if(isdefined(self._stealth.behavior.goback_startfunc))
	{
		self [[ self._stealth.behavior.goback_startfunc ]]();
	}

	var_00 = self._stealth.behavior.last_spot;
	if(isdefined(var_00) && self.type != "dog" && !isdefined(self.custommovetransition) && !isdefined(self.mech))
	{
		self.custommovetransition = ::maps\_patrol::patrol_resume_move_start_func;
	}

	if(isdefined(self.custommovetransition) && isdefined(self.pathgoalpos))
	{
		self setgoalpos(self.origin);
		wait(0.05);
	}

	if(isdefined(self.script_patroller))
	{
		if(isdefined(self.last_patrol_goal))
		{
			self.target = self.last_patrol_goal.targetname;
		}

		if(isdefined(self.stealth_first_alert_new_patrol_path))
		{
			self.target = self.stealth_first_alert_new_patrol_path.targetname;
			self.stealth_first_alert_new_patrol_path = undefined;
		}

		thread maps\_patrol::patrol();
	}
	else if(isalive(self.patrol_master))
	{
		thread maps\_patrol::pet_patrol();
		maps\_utility::set_dog_walk_anim();
		self.script_growl = undefined;
	}
	else if(isdefined(var_00))
	{
		if(self.type != "dog")
		{
			stealth_set_run_anim("_stealth_patrol_walk",1);
		}
		else
		{
			maps\_utility::set_dog_walk_anim();
			self.script_growl = undefined;
		}

		self.disablearrivals = 1;
		self.disableexits = 1;
		self setgoalpos(var_00);
		self.goalradius = 40;
	}

	waittillframeend;
	maps\_utility::ent_flag_clear("_stealth_override_goalpos");
	if(isdefined(var_00))
	{
		thread enemy_go_back_clear_lastspot(var_00);
	}
}

//Function Number: 22
enemy_go_back_clear_lastspot(param_00)
{
	self endon("death");
	self endon("_stealth_enemy_alert_level_change");
	maps\_utility::waittill_true_goal(param_00);
	self._stealth.behavior.last_spot = undefined;
}

//Function Number: 23
enemy_get_nearby_pathnodes(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(isdefined(level._stealth.node_search.nodes_array) && distancesquared(param_00,level._stealth.node_search.origin) < 4096 && param_01 == level._stealth.node_search.radius && param_02 == level._stealth.node_search.min_radius)
	{
		return level._stealth.node_search.nodes_array;
	}

	level._stealth.node_search.origin = param_00;
	level._stealth.node_search.radius = param_01;
	level._stealth.node_search.min_radius = param_02;
	level._stealth.node_search.nodes_array = getnodesinradius(param_00,param_01,param_02,512,"Path");
	return level._stealth.node_search.nodes_array;
}

//Function Number: 24
enemy_reaction_state_alert()
{
	self.fovcosine = 0.01;
	self.ignoreall = 0;
	self.diequietly = 0;
	maps\_utility::clear_run_anim();
	self.fixednode = 0;
}

//Function Number: 25
enemy_alert_level_forget(param_00,param_01)
{
	self endon("death");
	param_00 endon("death");
	if(!isdefined(param_01))
	{
		param_01 = 60;
	}

	wait(param_01);
	if(isdefined(param_00._stealth) && isdefined(param_00._stealth.logic.spotted_list[self.unique_id]) && param_00._stealth.logic.spotted_list[self.unique_id] > 0)
	{
		param_00._stealth.logic.spotted_list[self.unique_id]--;
	}
}

//Function Number: 26
enemy_stop_current_behavior()
{
	if(!maps\_utility::ent_flag("_stealth_behavior_reaction_anim"))
	{
		maps\_utility::anim_stopanimscripted();
		self notify("stop_animmode");
		self notify("stop_loop");
	}

	if(isdefined(self.script_patroller))
	{
		if(isdefined(self.last_patrol_goal))
		{
			self.last_patrol_goal.patrol_claimed = undefined;
		}

		self notify("release_node");
		self notify("end_patrol");
	}

	self notify("stop_first_frame");
	maps\_utility::clear_run_anim();
	maps\_utility::clear_generic_idle_anim();
}

//Function Number: 27
enemy_find_original_goal()
{
	if(isdefined(self._stealth.behavior.last_spot))
	{
		return;
	}

	if(isdefined(self.last_set_goalnode))
	{
		self._stealth.behavior.last_spot = self.last_set_goalnode.origin;
		return;
	}

	if(isdefined(self.last_set_goalent))
	{
		self._stealth.behavior.last_spot = self.last_set_goalent.origin;
		return;
	}

	if(isdefined(self.last_set_goalpos))
	{
		self._stealth.behavior.last_spot = self.last_set_goalpos;
		return;
	}

	self._stealth.behavior.last_spot = self.origin;
}

//Function Number: 28
enemy_set_original_goal(param_00)
{
	self._stealth.behavior.last_spot = param_00;
}

//Function Number: 29
enemy_react_and_displace_to(param_00,param_01)
{
	self notify("enemy_react_and_displace_to");
	self endon("enemy_react_and_displace_to");
	self endon("death");
	self endon("_stealth_enemy_alert_level_change");
	if(self.type == "dog")
	{
		return;
	}

	if(isdefined(param_00))
	{
		var_02 = param_00.origin;
	}
	else
	{
		var_02 = var_02;
	}

	var_03 = anglestoforward(self.angles);
	var_04 = vectornormalize(var_03);
	var_05 = vectortoangles(var_04);
	var_06 = vectortoangles(var_02 - self.origin);
	var_07 = var_05[1] - var_06[1];
	var_07 = var_07 + 360;
	var_07 = int(var_07) % 360;
	if(var_07 > 315 || var_07 < 45)
	{
		var_08 = "8";
	}
	else if(var_08 < 135)
	{
		var_08 = "6";
	}
	else if(var_08 < 225)
	{
		var_08 = "2";
	}
	else
	{
		var_08 = "4";
	}

	if(isdefined(self.mech))
	{
		stealth_anim_custom_animmode(self,"gravity","mech_stealth_idle_to_run_" + var_08);
		return;
	}

	stealth_anim_custom_animmode(self,"gravity","_stealth_idle_to_run_" + var_08);
}

//Function Number: 30
enemy_runto_and_lookaround(param_00,param_01)
{
	self notify("enemy_runto_and_lookaround");
	self endon("enemy_runto_and_lookaround");
	self endon("death");
	self endon("_stealth_enemy_alert_level_change");
	if(self.type != "dog")
	{
		self endon("_stealth_saw_corpse");
	}

	var_02 = group_get_flagname("_stealth_spotted");
	level endon(var_02);
	self notify("stop_loop");
	maps\_utility::ent_flag_set("_stealth_override_goalpos");
	if(isdefined(param_00))
	{
		self setgoalnode(param_00);
	}
	else
	{
		self setgoalpos(param_01);
	}

	self.goalradius = 64;
	self waittill("goal");
	if(self.type != "dog")
	{
		stealth_set_idle_anim("_stealth_look_around");
	}
}

//Function Number: 31
enemy_reactto_and_lookaround(param_00)
{
	self notify("enemy_reactto_and_lookaround");
	self endon("enemy_reactto_and_lookaround");
	self endon("death");
	self endon("_stealth_enemy_alert_level_change");
	if(self.type != "dog")
	{
		self endon("_stealth_saw_corpse");
	}

	var_01 = group_get_flagname("_stealth_spotted");
	level endon(var_01);
	self notify("stop_loop");
	self orientmode("face angle",vectortoyaw(param_00 - self.origin));
	if(self.type != "dog")
	{
		maps\_anim::anim_generic_custom_animmode(self,"gravity","_stealth_look_around");
	}
}

//Function Number: 32
enemy_find_free_pathnode_near(param_00,param_01,param_02)
{
	var_03 = enemy_get_nearby_pathnodes(param_00,param_01,param_02);
	if(!isdefined(var_03) || var_03.size == 0)
	{
		return;
	}

	var_04 = var_03[randomint(var_03.size)];
	for(var_03 = common_scripts\utility::array_remove(var_03,var_04);isdefined(var_04.owner);var_03 = common_scripts\utility::array_remove(var_03,var_04))
	{
		if(var_03.size == 0)
		{
			return;
		}

		var_04 = var_03[randomint(var_03.size)];
	}

	level._stealth.node_search.nodes_array = var_03;
	return var_04;
}

//Function Number: 33
enemy_find_free_pathnode_closest(param_00,param_01,param_02)
{
	var_03 = enemy_get_nearby_pathnodes(param_00,param_01,param_02);
	if(!isdefined(var_03) || var_03.size == 0)
	{
		return;
	}

	var_03 = sortbydistance(var_03,param_00);
	var_04 = var_03[0];
	for(var_03 = common_scripts\utility::array_remove(var_03,var_04);isdefined(var_04.owner);var_03 = common_scripts\utility::array_remove(var_03,var_04))
	{
		if(var_03.size == 0)
		{
			return;
		}

		var_04 = var_03[0];
	}

	level._stealth.node_search.nodes_array = var_03;
	return var_04;
}

//Function Number: 34
enemy_announce_wtf()
{
	if(self.type == "dog")
	{
		return;
	}

	if(!enemy_announce_snd("wtf"))
	{
		return;
	}

	var_00 = get_country_prefix();
	if(isstring(var_00) && isstring(self.npcid))
	{
		var_01 = var_00 + self.npcid + "_anexplosion";
		soundscripts\_snd_playsound::snd_play_linked(var_01,"stop_sound");
	}
}

//Function Number: 35
enemy_announce_huh()
{
	if(self.type == "dog")
	{
		return;
	}

	if(common_scripts\utility::flag("_stealth_spotted"))
	{
		return;
	}

	if(!enemy_announce_snd("huh"))
	{
		return;
	}

	var_00 = get_country_prefix();
	if(isstring(var_00) && isstring(self.npcid))
	{
		var_01 = var_00 + self.npcid + "_huh";
		soundscripts\_snd_playsound::snd_play_linked(var_01,"stop_sound");
	}
}

//Function Number: 36
enemy_announce_hmph()
{
	if(self.type == "dog")
	{
		return;
	}

	if(common_scripts\utility::flag("_stealth_spotted"))
	{
		return;
	}

	if(!enemy_announce_snd("hmph"))
	{
		return;
	}

	var_00 = get_country_prefix();
	if(isstring(var_00) && isstring(self.npcid))
	{
		var_01 = var_00 + self.npcid + "_hmph";
		soundscripts\_snd_playsound::snd_play_linked(var_01,"stop_sound");
	}
}

//Function Number: 37
enemy_announce_attack()
{
	self endon("death");
	self endon("pain_death");
	if(self.type == "dog")
	{
		return;
	}

	if(!enemy_announce_snd("spotted"))
	{
		return;
	}

	var_00 = get_country_prefix();
	if(isstring(var_00) && isstring(self.npcid))
	{
		var_01 = var_00 + self.npcid + "_stealth_alert";
		soundscripts\_snd_playsound::snd_play_linked(var_01,"stop_sound");
	}
}

//Function Number: 38
enemy_announce_spotted(param_00)
{
	self endon("death");
	self endon("pain_death");
	maps\_stealth_utility::stealth_group_spotted_flag_wait();
	if(self.type == "dog")
	{
		return;
	}

	if(enemy_announce_snd("spotted"))
	{
		thread enemy_announce_spotted_bring_group(param_00);
		var_01 = get_country_prefix();
		var_02 = var_01 + self.npcid + "_stealth_alert";
		soundscripts\_snd_playsound::snd_play_linked(var_02,"stop_sound");
	}

	if(enemy_announce_snd("acknowledge"))
	{
		thread enemy_announce_spotted_acknowledge(self.origin,get_country_prefix());
	}
}

//Function Number: 39
enemy_announce_spotted_acknowledge(param_00,param_01)
{
	wait(1.5);
	if(isdefined(self.npcid))
	{
		var_02 = self.npcid;
	}
	else
	{
		var_02 = randomint(3);
	}

	var_03 = param_01 + var_02 + "_stealth_alert_r";
	common_scripts\utility::play_sound_in_space(var_03,param_00);
}

//Function Number: 40
enemy_announce_spotted_bring_group(param_00)
{
	var_01 = group_get_ai_in_group(self.script_stealthgroup);
	foreach(var_03 in var_01)
	{
		if(var_03 == self)
		{
			continue;
		}

		if(isdefined(var_03.enemy) || isdefined(var_03.favoriteenemy))
		{
			continue;
		}

		var_03 notify("heard_scream",param_00);
	}
}

//Function Number: 41
enemy_announce_corpse()
{
	self endon("death");
	if(isdefined(self.found_corpse_wait))
	{
		wait(self.found_corpse_wait);
	}

	if(!enemy_announce_snd("corpse"))
	{
		return;
	}

	if(self.type == "dog")
	{
		maps\_utility::ent_flag_waitopen("_stealth_behavior_reaction_anim_in_progress");
		self notify("event_awareness","howl");
		return;
	}

	var_00 = "stealth_" + self.npcid + "_deadbody";
	soundscripts\_snd_playsound::snd_play_linked(var_00,"stop_sound");
}

//Function Number: 42
enemy_announce_snd(param_00)
{
	if(param_00 == "spotted")
	{
		if(level._stealth.behavior.sound[param_00][self.script_stealthgroup])
		{
			return 0;
		}

		level._stealth.behavior.sound[param_00][self.script_stealthgroup] = 1;
	}
	else
	{
		if(level._stealth.behavior.sound[param_00])
		{
			return 0;
		}

		level._stealth.behavior.sound[param_00] = 1;
		thread enemy_announce_snd_reset(param_00);
	}

	return 1;
}

//Function Number: 43
enemy_announce_snd_reset(param_00)
{
	wait(level._stealth.behavior.sound_reset_time);
	level._stealth.behavior.sound[param_00] = 0;
}

//Function Number: 44
enemy_animation_wrapper(param_00)
{
	self endon("death");
	self endon("pain_death");
	if(enemy_animation_pre_anim(param_00))
	{
		return;
	}

	enemy_animation_do_anim(param_00);
	enemy_animation_post_anim(param_00);
}

//Function Number: 45
enemy_animation_do_anim(param_00)
{
	if(isdefined(self._stealth.behavior.event.custom_animation))
	{
		enemy_animation_custom(param_00);
		return;
	}

	var_01 = self._stealth.behavior.ai_functions["animation"][param_00];
	self [[ var_01 ]](param_00);
}

//Function Number: 46
enemy_animation_custom(param_00)
{
	var_01 = self._stealth.behavior.event.custom_animation.node;
	var_02 = self._stealth.behavior.event.custom_animation.anime;
	var_03 = self._stealth.behavior.event.custom_animation.tag;
	var_04 = self._stealth.behavior.event.custom_animation.ender;
	maps\_utility::ent_flag_set("_stealth_behavior_reaction_anim");
	self.allowdeath = 1;
	var_01 notify(var_04);
	if(isdefined(self.anim_props))
	{
		self.anim_props_animated = 1;
		var_01 thread maps\_anim::anim_single(self.anim_props,var_02);
	}

	if(param_00 != "doFlashBanged")
	{
		if(isdefined(var_03) || isdefined(self.has_delta))
		{
			var_01 stealth_anim(self,var_02,var_03);
		}
		else
		{
			var_01 stealth_anim_custom_animmode(self,"gravity",var_02);
		}
	}

	ai_clear_custom_animation_reaction();
}

//Function Number: 47
enemy_animation_pre_anim(param_00)
{
	self notify("enemy_awareness_reaction",param_00);
	if(maps\_utility::ent_flag("_stealth_behavior_first_reaction") || maps\_utility::ent_flag("_stealth_behavior_reaction_anim_in_progress"))
	{
		return 1;
	}

	enemy_stop_current_behavior();
	if(issubstr(param_00,"warning"))
	{
		param_00 = "warning";
	}

	switch(param_00)
	{
		case "found_corpse":
		case "saw_corpse":
		case "heard_corpse":
		case "explode":
			break;

		case "reset":
		case "warning":
			break;

		default:
			break;
	}
}

//Function Number: 48
enemy_animation_pre_anim_dog_special_first_condition()
{
	var_00 = group_get_flagname("_stealth_spotted");
	self endon("death");
	common_scripts\utility::flag_wait_or_timeout(var_00,3);
	if(common_scripts\utility::flag(var_00))
	{
		maps\_utility::ent_flag_set("_stealth_behavior_first_reaction");
	}
}

//Function Number: 49
enemy_animation_post_anim(param_00)
{
	switch(param_00)
	{
		default:
			break;
	}
}

//Function Number: 50
ai_clear_custom_animation_reaction()
{
	self._stealth.behavior.event.custom_animation = undefined;
	self.newenemyreactiondistsq = squared(512);
}

//Function Number: 51
ai_clear_custom_animation_reaction_and_idle(param_00)
{
	if(!isdefined(self._stealth.behavior.event.custom_animation))
	{
		return;
	}

	self._stealth.behavior.event.custom_animation.node notify("stop_loop");
	if(!isdefined(param_00) || param_00 == 0)
	{
		self stopanimscripted();
	}

	ai_clear_custom_animation_reaction();
}

//Function Number: 52
ai_set_custom_animation_reaction(param_00,param_01,param_02,param_03)
{
	self._stealth.behavior.event.custom_animation = spawnstruct();
	self._stealth.behavior.event.custom_animation.node = param_00;
	self._stealth.behavior.event.custom_animation.anime = param_01;
	self._stealth.behavior.event.custom_animation.tag = param_02;
	self._stealth.behavior.event.custom_animation.ender = param_03;
	thread ai_animate_props_on_death(param_00,param_01,param_02,param_03);
	self.newenemyreactiondistsq = 0;
}

//Function Number: 53
ai_animate_props_on_death(param_00,param_01,param_02,param_03)
{
	wait(0.1);
	if(!isdefined(self.anim_props))
	{
		return;
	}

	var_04 = self.anim_props;
	self waittill("death");
	if(isdefined(self.anim_props_animated))
	{
		return;
	}

	param_00 thread maps\_anim::anim_single(var_04,param_01);
}

//Function Number: 54
event_awareness_main(param_00,param_01)
{
	level notify("event_awareness_handler");
	level endon("event_awareness_handler");
	level endon("default_event_awareness_enders");
	event_awareness_enders(param_01);
	maps\_utility::add_wait(::maps\_utility::waittill_msg,"event_awareness_handler");
	maps\_utility::add_wait(::maps\_utility::waittill_msg,"default_event_awareness_enders");
	maps\_utility::add_func(::common_scripts\utility::flag_clear,"_stealth_event");
	thread maps\_utility::do_wait_any();
	for(;;)
	{
		common_scripts\utility::flag_wait("_stealth_enabled");
		common_scripts\utility::flag_wait("_stealth_event");
		if(!common_scripts\utility::flag("_stealth_enabled"))
		{
			continue;
		}

		wait(2);
		event_awareness_dialogue_wrapper(param_00);
		common_scripts\utility::flag_waitopen("_stealth_event");
	}
}

//Function Number: 55
event_awareness_dialogue_wrapper(param_00)
{
	wait(randomfloatrange(0.5,1));
	if(!isdefined(param_00))
	{
		return;
	}

	var_01 = common_scripts\utility::random(param_00);
	level thread maps\_utility::function_stack(::maps\_utility::radio_dialogue,var_01);
}

//Function Number: 56
event_awareness_enders(param_00)
{
	level endon("default_event_awareness_enders");
	level endon("event_awareness_handler");
	if(isdefined(param_00))
	{
		foreach(var_02 in param_00)
		{
			if(common_scripts\utility::flag_exist(var_02) && common_scripts\utility::flag(var_02))
			{
				level notify("default_event_awareness_enders");
			}
		}

		foreach(var_02 in param_00)
		{
			maps\_utility::add_wait(::maps\_utility::waittill_msg,var_02);
		}
	}

	maps\_utility::add_wait(::common_scripts\utility::flag_wait,"_stealth_spotted");
	maps\_utility::add_wait(::maps\_utility::waittill_msg,"end_event_awareness_handler");
	maps\_utility::add_wait(::maps\_utility::waittill_msg,"event_awareness_handler");
	maps\_utility::add_func(::maps\_utility::send_notify,"default_event_awareness_enders");
	thread maps\_utility::do_wait_any();
}

//Function Number: 57
_autosave_stealthcheck()
{
	if(!maps\_stealth_utility::stealth_is_everything_normal())
	{
		return 0;
	}

	if(common_scripts\utility::flag("_stealth_player_nade"))
	{
		return 0;
	}

	if(common_scripts\utility::flag_exist("_radiation_poisoning"))
	{
		if(common_scripts\utility::flag("_radiation_poisoning"))
		{
			return 0;
		}
	}

	var_00 = getentarray("destructible","classname");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.healthdrain))
		{
			return 0;
		}
	}

	var_04 = getentarray("grenade","classname");
	if(var_04.size > 0)
	{
		return 0;
	}

	return 1;
}

//Function Number: 58
_patrol_endon_spotted_flag()
{
	var_00 = maps\_stealth_utility::stealth_get_group_spotted_flag();
	var_01 = maps\_stealth_utility::stealth_get_group_corpse_flag();
	maps\_utility::add_wait(::common_scripts\utility::flag_wait,var_00);
	maps\_utility::add_wait(::common_scripts\utility::flag_wait,var_01);
	maps\_utility::add_abort(::maps\_utility::waittill_msg,"death");
	maps\_utility::add_func(::maps\_utility::send_notify,"end_patrol");
	thread maps\_utility::do_wait_any();
}

//Function Number: 59
_spawner_stealth_default()
{
	thread maps\_stealth_utility::stealth_default();
}

//Function Number: 60
stealth_set_run_anim(param_00,param_01)
{
	if(isdefined(self.script_animation) && isdefined(level.scr_anim["generic"][param_00 + "_" + self.script_animation]))
	{
		maps\_utility::set_generic_run_anim(param_00 + "_" + self.script_animation,param_01);
		return;
	}

	maps\_utility::set_generic_run_anim(param_00,param_01);
}

//Function Number: 61
stealth_set_idle_anim(param_00)
{
	if(isdefined(self.script_animation) && isdefined(level.scr_anim["generic"][param_00 + "_" + self.script_animation]))
	{
		maps\_utility::set_generic_idle_anim(param_00 + "_" + self.script_animation);
		return;
	}

	maps\_utility::set_generic_idle_anim(param_00);
}

//Function Number: 62
stealth_anim_custom_animmode(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_00.script_animation) && isdefined(level.scr_anim["generic"][param_02 + "_" + param_00.script_animation]))
	{
		maps\_anim::anim_custom_animmode_solo(param_00,param_01,param_02 + "_" + param_00.script_animation,param_03);
		return;
	}

	maps\_anim::anim_generic_custom_animmode(param_00,param_01,param_02,param_03);
}

//Function Number: 63
stealth_anim(param_00,param_01,param_02)
{
	if(isdefined(param_00.script_animation) && isdefined(level.scr_anim["generic"][param_01 + "_" + param_00.script_animation]))
	{
		maps\_anim::anim_single_solo(param_00,param_01 + "_" + param_00.script_animation,param_02);
		return;
	}

	maps\_anim::anim_generic(param_00,param_01,param_02);
}

//Function Number: 64
get_country_prefix()
{
	var_00 = self.voice;
	switch(var_00)
	{
		case "african":
			break;

		case "atlas":
			break;

		case "american":
			break;

		case "arab":
			break;

		case "british":
			break;

		case "czech":
			break;

		case "delta":
			break;

		case "french":
			break;

		case "kva":
			break;

		case "pmc":
			break;

		case "portugese":
			break;

		case "russian":
			break;

		case "seal":
			break;

		case "secretservice":
			break;

		case "shadowcompany":
			break;

		case "taskforce":
			break;

		default:
			break;
	}
}