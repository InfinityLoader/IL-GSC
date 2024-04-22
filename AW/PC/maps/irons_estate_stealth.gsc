/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: irons_estate_stealth.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 52
 * Decompile Time: 756 ms
 * Timestamp: 4/22/2024 2:32:12 AM
*******************************************************************/

//Function Number: 1
irons_estate_stealth_setup()
{
	setdvarifuninitialized("irons_stealth_lose_interest_time",45);
	setsaveddvar("ai_threatSightDelayRateMax",0.1);
	setsaveddvar("ai_threatSightDelayRateMin",0.3);
	maps\_stealth_utility::stealth_set_default_stealth_function("irons_estate_stealth_custom",::irons_estate_stealth_custom);
	irons_estate_stealth_settings_normal();
	thread player_broke_stealth();
	thread player_stealth_audio();
	level.player thread player_shadow_monitor();
	level.patrol_anim_sets = [];
	level.patrol_anim_sets[level.patrol_anim_sets.size] = "gundown";
	level.patrol_anim_sets[level.patrol_anim_sets.size] = "creepwalk";
	thread irons_estate_whistle();
	level.player thread irons_estate_jump_monitor();
	maps\_stealth_utility::stealth_corpse_collect_func(::irons_estate_collect_corpse_override);
	level.alert_sound = 0;
}

//Function Number: 2
irons_estate_collect_corpse_override()
{
	var_00 = getcorpsearray();
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(isdefined(var_03.target) && var_03.target == "ignore_corpse")
		{
			continue;
		}

		var_01[var_01.size] = var_03;
	}

	return var_01;
}

//Function Number: 3
irons_estate_stealth_custom()
{
	maps\_stealth_utility::stealth_plugin_basic();
	if(isplayer(self))
	{
		return;
	}

	switch(self.team)
	{
		case "axis":
			maps\_stealth_utility::stealth_plugin_threat();
			maps\_stealth_utility::stealth_pre_spotted_function_custom(::irons_estate_custom_pre_spotted);
			maps\_stealth_utility::stealth_enable_seek_player_on_spotted();
			maps\_stealth_utility::stealth_plugin_corpse();
			maps\_stealth_utility::stealth_plugin_event_all(undefined,["explode"]);
			irons_estate_custom_state_behavior();
			maps\_stealth_utility::stealth_plugin_event_custom("reaction_generic",::enemy_event_reaction_irons_generic,::maps\_stealth_animation_funcs::enemy_animation_nothing,0);
			maps\_stealth_utility::stealth_plugin_event_custom("grapple_impact",::enemy_event_reaction_grapple_impact,::maps\_stealth_animation_funcs::enemy_animation_nothing,0);
			maps\_stealth_utility::stealth_plugin_event_custom("witness_kill",::enemy_event_reaction_witness_kill,::maps\_stealth_animation_funcs::enemy_animation_nothing,0);
			maps\_stealth_utility::stealth_plugin_event_custom("whistle",::enemy_event_reaction_whistle,::maps\_stealth_animation_funcs::enemy_animation_nothing,0);
			maps\_stealth_utility::stealth_plugin_event_custom("gunshot_teammate",::enemy_event_reaction_gunshot,::maps\_stealth_animation_funcs::enemy_animation_nothing,0);
			maps\_stealth_utility::stealth_plugin_event_custom("flashed",::enemy_event_reaction_gunshot,::maps\_stealth_animation_funcs::enemy_animation_nothing,0);
			thread irons_estate_stealth_ai_status_monitor();
			thread maps\irons_estate_code::enemy_alert_vo();
			thread maps\irons_estate_code::watch_for_death();
			self.threatsightdelayenabled = 1;
			self.threatsightdelayfalloff = 1;
			break;

		case "allies":
			maps\_stealth_utility::stealth_plugin_aicolor();
			maps\_stealth_utility::stealth_plugin_accuracy();
			maps\_stealth_utility::stealth_plugin_smart_stance();
			break;
	}
}

//Function Number: 4
irons_estate_stealth_settings_normal()
{
	level.corpse_behavior_doesnt_require_player_sight = 1;
	var_00 = [];
	var_00["ai_eventDistGunShot"] = [];
	var_00["ai_eventDistGunShot"]["spotted"] = 1024;
	var_00["ai_eventDistGunShot"]["hidden"] = 1024;
	var_00["ai_eventDistGunShotTeam"] = [];
	var_00["ai_eventDistGunShotTeam"]["spotted"] = 650;
	var_00["ai_eventDistGunShotTeam"]["hidden"] = 450;
	var_00["ai_eventDistNewEnemy"] = [];
	var_00["ai_eventDistNewEnemy"]["spotted"] = 1024;
	var_00["ai_eventDistNewEnemy"]["hidden"] = 512;
	var_00["ai_eventDistExplosion"] = [];
	var_00["ai_eventDistExplosion"]["spotted"] = 2048;
	var_00["ai_eventDistExplosion"]["hidden"] = 2048;
	var_00["ai_eventDistDeath"] = [];
	var_00["ai_eventDistDeath"]["spotted"] = 500;
	var_00["ai_eventDistDeath"]["hidden"] = 500;
	var_00["ai_eventDistPain"] = [];
	var_00["ai_eventDistPain"]["spotted"] = 500;
	var_00["ai_eventDistPain"]["hidden"] = 500;
	var_00["ai_eventDistBullet"] = [];
	var_00["ai_eventDistBullet"]["spotted"] = 300;
	var_00["ai_eventDistBullet"]["hidden"] = 200;
	var_00["ai_eventDistFootstepWalk"] = [];
	var_00["ai_eventDistFootstepWalk"]["spotted"] = 200;
	var_00["ai_eventDistFootstepWalk"]["hidden"] = 50;
	var_00["ai_eventDistFootstep"] = [];
	var_00["ai_eventDistFootstep"]["spotted"] = 300;
	var_00["ai_eventDistFootstep"]["hidden"] = 100;
	var_00["ai_eventDistFootstepSprint"] = [];
	var_00["ai_eventDistFootstepSprint"]["spotted"] = 400;
	var_00["ai_eventDistFootstepSprint"]["hidden"] = 150;
	var_00["ai_eventDistGrenadePing"] = [];
	var_00["ai_eventDistGrenadePing"]["spotted"] = 512;
	var_00["ai_eventDistGrenadePing"]["hidden"] = 512;
	var_00["ai_eventDistProjImpact"] = [];
	var_00["ai_eventDistProjImpact"]["spotted"] = 256;
	var_00["ai_eventDistProjImpact"]["hidden"] = 256;
	var_00["ai_eventDistProjPing"] = [];
	var_00["ai_eventDistProjPing"]["spotted"] = 128;
	var_00["ai_eventDistProjPing"]["hidden"] = 128;
	var_00["ai_eventDistSilencedShot"] = [];
	var_00["ai_eventDistSilencedShot"]["spotted"] = 600;
	var_00["ai_eventDistSilencedShot"]["hidden"] = 100;
	maps\_stealth_utility::stealth_ai_event_dist_custom(var_00);
	var_01 = [];
	var_01["prone"] = 600;
	var_01["crouch"] = 800;
	var_01["stand"] = 1000;
	if(level.gameskill == 3)
	{
		foreach(var_04, var_03 in var_01)
		{
			var_01[var_04] = var_01[var_04] * 1.33;
		}
	}

	var_05 = [];
	var_05["prone"] = 1000;
	var_05["crouch"] = 1250;
	var_05["stand"] = 1500;
	maps\_stealth_utility::stealth_detect_ranges_set(var_01,var_05);
	var_06 = [];
	var_06["player_dist"] = 1000;
	var_06["sight_dist"] = 500;
	var_06["detect_dist"] = 500;
	maps\_stealth_utility::stealth_corpse_ranges_custom(var_06);
	maps\_stealth_utility::stealth_alert_level_duration(0.75);
}

//Function Number: 5
irons_estate_custom_state_behavior()
{
	var_00 = [];
	var_00["hidden"] = ::irons_estate_enemy_state_hidden;
	var_00["spotted"] = ::irons_estate_enemy_state_spotted;
	maps\_stealth_behavior_enemy::enemy_custom_state_behavior(var_00);
	var_01["reset"] = ::irons_estate_enemy_normal_behavior;
	var_01["warning1"] = ::irons_estate_enemy_warning1_behavior;
	var_01["warning2"] = ::irons_estate_enemy_warning2_behavior;
	var_01["attack"] = ::irons_estate_enemy_attack_behavior;
	var_01["normal"] = ::irons_estate_enemy_normal_behavior;
	maps\_stealth_utility::stealth_threat_behavior_custom(var_01);
}

//Function Number: 6
irons_estate_enemy_state_hidden()
{
	self notify("turn_off_stealth_spotted_arrow");
	self.a.disablelongdeath = 1;
	self.grenadeammo = 0;
	self.fovcosine = cos(60);
	self.fovcosinez = cos(10);
	self.fovcosinebusy = cos(84);
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

//Function Number: 7
irons_estate_enemy_state_spotted(param_00)
{
	self.fovcosine = cos(89);
	self.fovcosinez = 0;
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

//Function Number: 8
irons_estate_custom_pre_spotted()
{
	self.battlechatter = 0;
	wait(0.2);
	self.battlechatter = 1;
}

//Function Number: 9
wait_till_every_thing_stealth_normal_for(param_00)
{
	for(;;)
	{
		if(maps\_stealth_utility::stealth_is_everything_normal())
		{
			wait(param_00);
			if(maps\_stealth_utility::stealth_is_everything_normal())
			{
				return;
			}
		}

		wait(1);
	}
}

//Function Number: 10
irons_estate_stealth_achievement()
{
	level endon("player_killed_someone");
	level endon("_stealth_spotted");
	level endon("someone_became_alert");
	common_scripts\utility::flag_wait("meet_cormack_pt2_end");
	thread maps\irons_estate_code::temp_dialogue("Cormack","Nice work, Mitchell. No kills and you weren\'t spotted.",1);
}

//Function Number: 11
enemy_event_reaction_investigate(param_00,param_01,param_02)
{
	self notify("enemy_event_reaction_investigate");
	self endon("enemy_event_reaction_investigate");
	if(!isdefined(self.animname))
	{
		self.animname = "generic";
	}

	if(isdefined(self.script_animation) && self.script_animation == "unarmed")
	{
		childthread enemy_event_set_run_anim(0);
		self.script_animation = "investigate";
		childthread enemy_event_set_run_anim(1.2);
	}
	else
	{
		self.script_animation = undefined;
		self.disablearrivals = undefined;
	}

	enemy_event_reaction_generic(param_00,param_01,param_02);
	if(!common_scripts\utility::flag("_stealth_spotted"))
	{
		self.script_animation = "unarmed";
	}
}

//Function Number: 12
enemy_event_set_run_anim(param_00)
{
	if(param_00 > 0)
	{
		wait(param_00);
	}

	maps\_patrol::set_patrol_run_anim_array();
	self.disablearrivals = 1;
}

//Function Number: 13
enemy_event_reaction_generic(param_00,param_01,param_02)
{
	self notify("enemy_event_reaction");
	self endon("enemy_event_reaction");
	var_03 = self._stealth.logic.event.awareness_param[param_00];
	wait(0.05);
	maps\_utility::ent_flag_waitopen("_stealth_behavior_reaction_anim_in_progress");
	if(isdefined(param_01) && param_01)
	{
		var_04 = maps\_stealth_shared_utilities::enemy_find_free_pathnode_closest(var_03,500,1);
	}
	else
	{
		var_04 = maps\_stealth_shared_utilities::enemy_find_free_pathnode_near(var_04,250,1);
	}

	if(!isdefined(param_02) || !param_02)
	{
		thread maps\_stealth_shared_utilities::enemy_announce_huh();
	}

	if(!isdefined(self.animname))
	{
		self.animname = "generic";
	}

	if(isdefined(var_04))
	{
		irons_estate_enemy_investigate_position(var_04,undefined,param_02);
		return;
	}

	maps\_stealth_shared_utilities::enemy_reactto_and_lookaround(var_03);
}

//Function Number: 14
irons_estate_enemy_investigate_position(param_00,param_01,param_02)
{
	if(isdefined(param_00))
	{
		if(!isdefined(param_02) || !param_02)
		{
			thread maps\_stealth_shared_utilities::enemy_react_and_displace_to(param_00,param_01);
		}

		thread maps\_stealth_shared_utilities::enemy_runto_and_lookaround(param_00,param_01);
		self.disablearrivals = 0;
		self.disableexits = 0;
		self waittill("goal");
		wait(randomfloatrange(5,8));
		return;
	}

	wait(randomfloatrange(1,4));
}

//Function Number: 15
enemy_event_reaction_alert_upward(param_00,param_01)
{
	self notify("enemy_event_reaction");
	self endon("enemy_event_reaction");
	self endon("death");
	if(self.ignoreall)
	{
		return;
	}

	var_02 = self._stealth.logic.event.awareness_param[param_00];
	wait(0.05);
	maps\_utility::ent_flag_waitopen("_stealth_behavior_reaction_anim_in_progress");
	thread maps\_stealth_threat_enemy::enemy_announce_alert();
	var_03 = self.fovcosine;
	var_04 = self.fovcosinez;
	var_05 = self.script_animation;
	self.fovcosine = cos(89);
	self.fovcosinez = 0;
	self.script_animation = "upward";
	maps\_stealth_shared_utilities::enemy_reactto_and_lookaround(var_02);
	self.fovcosine = var_03;
	self.fovcosinez = var_04;
	self.script_animation = var_05;
}

//Function Number: 16
enemy_event_reaction_irons_generic(param_00)
{
	self endon("death");
	if(self.ignoreall)
	{
		return;
	}

	self.event_type = param_00;
	enemy_event_reaction_generic(param_00);
	thread reset_event_type(param_00);
}

//Function Number: 17
enemy_event_reaction_whistle(param_00)
{
	self endon("death");
	var_01 = isdefined(self.event_type) && self.event_type == param_00;
	if(self.ignoreall)
	{
		return;
	}

	if(isdefined(self.do_not_react_to_whistle))
	{
		return;
	}

	if(!isdefined(self.whistle_no_relay))
	{
		childthread enemy_event_reaction_whistle_relay(param_00);
	}

	self.whistle_no_relay = undefined;
	if(!var_01)
	{
		self.whistle_count = 0;
	}

	self.whistle_count = self.whistle_count + 1;
	self.event_type = param_00;
	if(self.whistle_count >= 3)
	{
		common_scripts\utility::flag_set("_stealth_spotted");
		thread enemy_event_reaction_gunshot(param_00);
	}
	else
	{
		self.custommovetransition = ::do_nothing;
		enemy_event_reaction_investigate(param_00,1,var_01);
		if(isdefined(self.whistle_tutorial_enemy))
		{
			level notify("whistle_tutorial_enemy_going_back");
		}
	}

	thread reset_event_type(param_00);
}

//Function Number: 18
enemy_event_reaction_explosion(param_00)
{
	self endon("death");
	if(self.ignoreall)
	{
		return;
	}

	if(!isdefined(self.animname))
	{
		self.animname = "generic";
	}

	maps\_stealth_event_enemy::enemy_event_reaction_explosion(param_00);
}

//Function Number: 19
enemy_event_reaction_grapple_impact(param_00)
{
	self endon("death");
	if(self.ignoreall)
	{
		return;
	}

	self.event_type = param_00;
	enemy_event_reaction_alert_upward(param_00,250);
	thread reset_event_type(param_00);
}

//Function Number: 20
enemy_event_reaction_witness_kill(param_00)
{
	self endon("death");
	if(self.ignoreall)
	{
		return;
	}

	var_01 = self._stealth.logic.event.awareness_param[param_00];
	if(witness_kill_valid(var_01))
	{
		common_scripts\utility::flag_set("_stealth_spotted");
		thread enemy_event_reaction_gunshot(param_00);
	}
}

//Function Number: 21
enemy_event_reaction_gunshot(param_00)
{
	self endon("death");
	if(self.ignoreall)
	{
		return;
	}

	if(isdefined(self.alertlevel) && self.alertlevel == level._stealth.logic.alert_level_table["attack"])
	{
		return;
	}

	level.player thread ai_ignore_foliage_for_time(5);
	thread enemy_know_player_for_time(5);
	thread maps\_stealth_threat_enemy::enemy_alert_level_change("attack");
}

//Function Number: 22
enemy_event_reaction_whistle_relay(param_00)
{
	var_01 = self._stealth.logic.event.awareness_param[param_00];
	var_02 = getnodesinradiussorted(var_01,300,100,500);
	if(!isdefined(var_02) || var_02.size == 0)
	{
		return;
	}

	if(isdefined(self.script_stealthgroup) && isdefined(level._stealth.group.groups[self.script_stealthgroup]))
	{
		foreach(var_04 in level._stealth.group.groups[self.script_stealthgroup])
		{
			if(var_04 == self)
			{
				continue;
			}

			wait(randomfloatrange(0.25,0.5));
			if(!isdefined(var_04))
			{
				continue;
			}

			var_05 = 0;
			if(var_02.size > 1)
			{
				var_06 = int(var_02.size / 2);
				var_05 = int(clamp(var_06 + randomint(var_06),0,var_02.size - 1));
			}

			var_04.whistle_no_relay = 1;
			var_04 notify("whistle",var_02[var_05].origin);
		}
	}
}

//Function Number: 23
do_nothing()
{
}

//Function Number: 24
witness_kill_valid(param_00)
{
	var_01 = self geteye();
	var_02 = anglestoforward(self.angles);
	if(isai(self))
	{
		var_02 = anglestoforward(self gettagangles("tag_eye"));
	}

	var_03 = param_00 - var_01;
	if(vectordot(vectornormalize(var_03),var_02) < self.fovcosine)
	{
		return 0;
	}

	if(!sighttracepassed(var_01,param_00,0,self))
	{
		return 0;
	}

	return 1;
}

//Function Number: 25
reset_event_type(param_00)
{
	self endon("death");
	maps\_utility::ent_flag_wait("_stealth_normal");
	if(isdefined(self.event_type) && self.event_type == param_00)
	{
		self.event_type = undefined;
	}
}

//Function Number: 26
ai_ignore_foliage_for_time(param_00)
{
	self notify("ai_ignore_foliage_for_time");
	self endon("ai_ignore_foliage_for_time");
	self endon("death");
	setsaveddvar("ai_foliageSeeThroughDist",10000);
	wait(param_00);
	setsaveddvar("ai_foliageSeeThroughDist",128);
}

//Function Number: 27
enemy_know_player_for_time(param_00)
{
	self notify("enemy_know_player_for_time");
	self endon("enemy_know_player_for_time");
	self endon("death");
	while(param_00 >= 0)
	{
		self getenemyinfo(level.player);
		param_00 = param_00 - 0.05;
		wait(0.05);
	}
}

//Function Number: 28
stealth_ai_idle_and_react_custom(param_00,param_01,param_02,param_03,param_04)
{
	if(isdefined(param_04))
	{
	}

	param_00 maps\_stealth_utility::stealth_insure_enabled();
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
		thread maps\_anim::anim_generic_loop(param_00,param_01,undefined,param_03);
	}

	param_00 maps\_stealth_shared_utilities::ai_set_custom_animation_reaction(self,param_02,param_03,var_06);
	maps\_utility::add_wait(::maps\_utility::waittill_msg,"stop_idle_proc");
	maps\_utility::add_func(::maps\_stealth_utility::stealth_ai_clear_custom_idle_and_react);
	thread maps\_stealth_utility::do_wait_thread();
}

//Function Number: 29
irons_estate_stealth_ai_status_monitor()
{
	self.stealth_vis_threat = 0;
	childthread irons_estate_stealth_ai_status_thread();
	while(isdefined(self))
	{
		self.stealth_last_alert = "normal";
		maps\_stealth_threat_enemy::enemy_set_alert_level("reset");
		var_00 = common_scripts\utility::waittill_any_return_parms("_stealth_enemy_alert_level_change","going_back","turn_off_stealth_spotted_arrow","death");
		if(!isdefined(self))
		{
			break;
		}

		if(var_00[0] == "_stealth_enemy_alert_level_change")
		{
			if(var_00[1] == "reset")
			{
				self.stealth_vis_threat = 0;
				self.threatsightdelayfalloff = 1;
				self.threatsightdelayenabled = 1;
				self.stealth_last_alert = "normal";
				level.alert_sound = 0;
				maps\_stealth_threat_enemy::enemy_set_alert_level("reset");
				level.aud_music_state = 0;
			}
			else if(var_00[1] == "warning1")
			{
				self.stealth_vis_threat = 0.33;
				self.threatsightdelayfalloff = 0;
				self.threatsightdelayenabled = 1;
				if(!isdefined(level.stealth_disabled) || !level.stealth_disabled)
				{
					level notify("drone_investigate",level.player.origin,self);
				}

				if(level.alert_sound == 0 && !common_scripts\utility::flag("_stealth_spotted"))
				{
					level.alert_sound = 1;
					soundscripts\_snd_playsound::snd_play_2d("irons_spotted_alert");
					level notify("stop_seen_sound");
				}

				level.aud_music_state = 1;
				self.stealth_last_alert = "warning1";
				maps\_stealth_threat_enemy::enemy_set_alert_level("warning");
			}
			else if(var_00[1] == "warning2")
			{
				self.stealth_vis_threat = 0.66;
				self.threatsightdelayfalloff = 0;
				self.threatsightdelayenabled = 1;
				if(!isdefined(level.stealth_disabled) || !level.stealth_disabled)
				{
					level notify("drone_investigate",level.player.origin,self);
				}

				if(level.alert_sound == 0 && !common_scripts\utility::flag("_stealth_spotted"))
				{
					level.alert_sound = 1;
					soundscripts\_snd_playsound::snd_play_2d("irons_spotted_alert");
					level notify("stop_seen_sound");
				}

				level.aud_music_state = 2;
				self.stealth_last_alert = "warning2";
				maps\_stealth_threat_enemy::enemy_set_alert_level("warning");
			}
			else if(var_00[1] == "attack")
			{
				self.stealth_vis_threat = 1;
				thread irons_estate_threat_search();
				self.threatsightdelayfalloff = 0;
				self.threatsightdelayenabled = 0;
				if(level.alert_sound == 0 && !common_scripts\utility::flag("_stealth_spotted"))
				{
					level.alert_sound = 1;
					soundscripts\_snd_playsound::snd_play_2d("irons_spotted_alert");
					level notify("stop_seen_sound");
				}

				level.aud_music_state = 3;
				self.stealth_last_alert = "attack";
				maps\_stealth_threat_enemy::enemy_set_alert_level("attack");
			}

			continue;
		}

		if(var_00[0] == "turn_off_stealth_spotted_arrow" || var_00[0] == "going_back" || var_00[0] == "death")
		{
			self.stealth_vis_threat = 0;
			self.threatsightdelayfalloff = 1;
			self.threatsightdelayenabled = 1;
			self.stealth_last_alert = "normal";
			level.alert_sound = 0;
			maps\_stealth_threat_enemy::enemy_set_alert_level("reset");
			level.aud_music_state = 0;
		}
	}
}

//Function Number: 30
irons_estate_threat_search()
{
	self notify("irons_estate_threat_search");
	self endon("irons_estate_threat_search");
	self endon("death");
	while(isdefined(self) && isdefined(self.enemy) && maps\_utility::ent_flag("_stealth_enabled"))
	{
		var_00 = gettime() - self lastknowntime(self.enemy);
		if(var_00 > getdvarfloat("irons_stealth_lose_interest_time") * 1000)
		{
			self clearenemy();
			return;
		}

		wait(0.5);
	}
}

//Function Number: 31
irons_estate_stealth_ai_status_thread()
{
	self notify("irons_estate_stealth_ai_status_thread");
	self endon("irons_estate_stealth_ai_status_thread");
	self endon("death");
	for(;;)
	{
		var_00 = self getthreatsightdelay(level.player);
		var_01 = self cansee(level.player);
		if(!var_01 && self.alertlevel != "combat" && !self.ignoreall)
		{
			var_01 = irons_estate_close_awareness_check(level.player,200,50);
			if(var_01)
			{
				self getenemyinfo(level.player);
				maps\_stealth_threat_enemy::enemy_alert_level_change("attack");
			}
		}

		if(var_01)
		{
			level.player.stealth_can_be_seen = 1;
		}

		var_02 = max(self.stealth_vis_threat,var_00);
		level.player maps\_stealth_display::stealth_display_seed(self,var_02,var_01);
		wait(0.05);
	}
}

//Function Number: 32
irons_estate_close_awareness_check(param_00,param_01,param_02)
{
	var_03 = param_00.origin;
	if(isai(param_00) || isplayer(param_00))
	{
		var_03 = param_00 geteye();
	}

	var_04 = self geteye();
	var_05 = var_03 - var_04;
	var_06 = lengthsquared(var_05);
	if(var_06 < param_01 * param_01)
	{
		if(var_06 < param_02 * param_02)
		{
			return 1;
		}

		if(var_04[2] > var_03[2])
		{
			var_07 = vectornormalize(var_05);
			var_08 = anglestoforward(self.angles);
			var_09 = vectordot(var_07,var_08);
			if(var_09 > self.fovcosine && var_09 < self.fovcosinez)
			{
				if(sighttracepassed(var_04,var_03,0,undefined))
				{
					return 1;
				}
			}
		}
	}

	return 0;
}

//Function Number: 33
irons_estate_enemy_normal_behavior()
{
	if(!isdefined(self.isbeinggrappled))
	{
		thread maps\_stealth_shared_utilities::enemy_announce_hmph();
		irons_estate_enemy_go_back();
	}
}

//Function Number: 34
irons_estate_enemy_go_back()
{
	self notify("going_back");
	self endon("death");
	self notify("stop_loop");
	self.pathrandompercent = 0;
	self._stealth.debug_state = "Going Back";
	if(isdefined(self._stealth.behavior.goback_startfunc))
	{
		self [[ self._stealth.behavior.goback_startfunc ]]();
	}

	var_00 = self._stealth.behavior.last_spot;
	if(isdefined(var_00) && self.type != "dog" && !isdefined(self.custommovetransition) && !isdefined(self.mech))
	{
		self.custommovetransition = ::irons_estate_patrol_resume_move_start_func;
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
			if(isdefined(self.script_animation))
			{
				var_01 = "patrol_walk_" + self.script_animation;
			}
			else
			{
				var_01 = "_stealth_patrol_walk";
			}

			maps\_stealth_shared_utilities::stealth_set_run_anim("_stealth_patrol_walk",1);
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
		thread maps\_stealth_shared_utilities::enemy_go_back_clear_lastspot(var_00);
	}
}

//Function Number: 35
irons_estate_enemy_warning1_behavior()
{
	if(!isdefined(self.enemy))
	{
		return;
	}

	thread maps\_stealth_threat_enemy::enemy_announce_alert();
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

	maps\_stealth_threat_enemy::enemy_lookaround_for_time(10);
	self.shootposoverride = undefined;
}

//Function Number: 36
irons_estate_enemy_warning2_behavior()
{
	if(!isdefined(self.enemy))
	{
		return;
	}

	thread maps\_stealth_threat_enemy::enemy_announce_alert();
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
	var_02 = common_scripts\utility::waittill_any_timeout(4,"goal","bad_path");
	if(var_02 == "timeout" || var_02 == "bad_path")
	{
		self.shootposoverride = var_00 + (0,0,64);
	}

	if(self.type != "dog")
	{
		var_03 = "_stealth_patrol_search_a";
		if(common_scripts\utility::cointoss())
		{
			var_03 = "_stealth_patrol_search_b";
		}

		maps\_stealth_shared_utilities::stealth_set_run_anim(var_03,1);
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
	var_02 = common_scripts\utility::waittill_any_timeout(4,"goal","bad_path");
	if(var_02 == "timeout" || var_02 == "bad_path")
	{
		self.shootposoverride = var_00 + (0,0,64);
	}

	maps\_stealth_threat_enemy::enemy_lookaround_for_time(10);
	if(self.type != "dog")
	{
		var_03 = "a";
		if(randomint(100) > 50)
		{
			var_03 = "b";
		}

		maps\_stealth_shared_utilities::stealth_set_run_anim("_stealth_patrol_search_" + var_03,1);
		return;
	}

	maps\_utility::set_dog_walk_anim();
	self.script_growl = undefined;
}

//Function Number: 37
irons_estate_enemy_attack_behavior()
{
	thread maps\_stealth_shared_utilities::enemy_announce_spotted(self.origin);
	if(isdefined(self.script_goalvolume))
	{
		thread maps\_spawner::set_goal_volume();
		return;
	}

	irons_estate_enemy_close_in_on_target();
}

//Function Number: 38
irons_estate_enemy_close_in_on_target()
{
	self.pathrandompercent = 200;
	thread maps\_stealth_shared_utilities::enemy_announce_spotted(self.origin);
	self.goalradius = 1024;
	self endon("death");
	maps\_utility::ent_flag_set("_stealth_override_goalpos");
	while(isdefined(self.enemy) && maps\_utility::ent_flag("_stealth_enabled"))
	{
		self setgoalpos(self.enemy.origin);
		wait(randomfloatrange(4,8));
		if(isdefined(self.script_stealth_dontseek) && self.script_stealth_dontseek == 1)
		{
			return;
		}
	}
}

//Function Number: 39
player_broke_stealth()
{
	level endon("stop_player_broke_stealth_monitor");
	level.player endon("death");
	for(;;)
	{
		var_00 = 6;
		var_01 = 0;
		common_scripts\utility::flag_wait("_stealth_spotted");
		if(isdefined(level.player.stealth_display_max) && level.player.stealth_display_max == 1)
		{
			if(level.start_point_scripted != "recon" && level.start_point_scripted != "infil")
			{
				level.awareness_meter_fail = 1;
			}
			else if(common_scripts\utility::flag("stealth_display_tutorial_over"))
			{
				level.awareness_meter_fail = 1;
			}
		}

		if(!isdefined(level.stealth_fail_fast))
		{
			while(var_01 < var_00)
			{
				var_01++;
				if(isdefined(level.stealth_fail_fast))
				{
					break;
				}

				wait(1);
			}
		}
		else
		{
			wait(1);
		}

		if(level.friendlyfire["friend_kill_points"] == -10000)
		{
			soundscripts\_snd::snd_message("aud_panic_walla");
			return;
		}

		if(common_scripts\utility::flag("_stealth_spotted") || drones_have_shot_at_player())
		{
			common_scripts\utility::flag_set("mission_failing");
			soundscripts\_snd::snd_message("aud_panic_walla");
			wait(2);
			if(!isdefined(level.civilian_killed) && !isdefined(level.border_drone_fail) && !isdefined(level.awareness_meter_fail))
			{
				maps\irons_estate_code::player_alerted_mission_fail();
			}
			else if(isdefined(level.awareness_meter_fail))
			{
				maps\irons_estate_code::player_alerted_mission_fail_meter();
			}

			break;
		}
		else
		{
			level notify("drones_abort");
		}

		if(isdefined(level.awareness_meter_fail))
		{
			level.awareness_meter_fail = undefined;
		}
	}
}

//Function Number: 40
drones_have_shot_at_player()
{
	if(!isdefined(level.active_drones))
	{
		return 0;
	}

	var_00 = 0;
	foreach(var_02 in level.active_drones)
	{
		if(isdefined(var_02) && isdefined(var_02.shot_at_player))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 41
player_stealth_audio()
{
	level.player.stealth_can_be_seen = 0;
	level.audiblesightplaying = 0;
	for(;;)
	{
		if(level.player.stealth_can_be_seen && !isdefined(level.seen_audio_ent))
		{
			if(getdvarint("stealth_display"))
			{
				level.seen_audio_ent = soundscripts\_snd_playsound::snd_play_loop_2d("irons_stealth_broken_warning_lp","stop_seen_sound",0.4,0.8);
			}
		}
		else if(!level.player.stealth_can_be_seen && isdefined(level.seen_audio_ent))
		{
			level notify("stop_seen_sound");
			level.seen_audio_ent = undefined;
		}

		level.player.stealth_can_be_seen = 0;
		wait(0.1);
	}
}

//Function Number: 42
stealth_display_tutorial()
{
	self notify("stealth_display_tutorial");
	self endon("stealth_display_tutorial");
	var_00 = 0;
	var_01 = 0;
	for(;;)
	{
		var_00 = clamp(var_00 + 0.03,0,1);
		level.player maps\_stealth_display::stealth_display_seed_angle(0,var_00,1);
		if(var_00 >= 1)
		{
			var_01 = var_01 + 0.05;
		}

		if(var_01 > 1.5)
		{
			var_00 = 0;
			var_01 = 0;
			wait(0.75);
		}

		wait(0.05);
	}
}

//Function Number: 43
player_shadow_monitor()
{
	self endon("death");
	var_00 = getdvarfloat("ai_threatSightDelayRateMin");
	while(!isdefined(self.ent_flag))
	{
		wait(0.05);
	}

	for(;;)
	{
		if(!isdefined(self.ent_flag["_stealth_in_shadow"]) || !self.ent_flag["_stealth_in_shadow"])
		{
			setsaveddvar("ai_threatSightDelayRateMin",var_00);
		}
		else
		{
			setsaveddvar("ai_threatSightDelayRateMin",var_00 * 0.5);
		}

		wait(0.25);
	}
}

//Function Number: 44
player_recovered_stealth()
{
	self notify("player_recovered_stealth");
	self endon("player_recovered_stealth");
	wait_till_every_thing_stealth_normal_for(0.05);
}

//Function Number: 45
force_patrol_anim_set_immediately_or_when_spawned()
{
	self endon("death");
	if(isdefined(level.player_broke_stealth_once))
	{
		if(isdefined(self.force_patrol_anim_set))
		{
			if(isdefined(self))
			{
				thread maps\_patrol_extended::force_patrol_anim_set(self.force_patrol_anim_set,undefined,1);
				return;
			}

			return;
		}

		if(isdefined(self))
		{
			maps\_stealth_shared_utilities::enemy_stop_current_behavior();
			thread maps\_patrol_extended::force_patrol_anim_set(common_scripts\utility::random(level.patrol_anim_sets),undefined,1);
			return;
		}

		return;
	}

	common_scripts\utility::flag_wait("_stealth_spotted");
	wait(0.05);
	if(isdefined(level.player_broke_stealth_once))
	{
		if(isdefined(self.force_patrol_anim_set))
		{
			if(isdefined(self))
			{
				thread maps\_patrol_extended::force_patrol_anim_set(self.force_patrol_anim_set,undefined,1);
				return;
			}

			return;
		}

		if(isdefined(self))
		{
			maps\_stealth_shared_utilities::enemy_stop_current_behavior();
			thread maps\_patrol_extended::force_patrol_anim_set(common_scripts\utility::random(level.patrol_anim_sets),undefined,1);
			return;
		}

		return;
	}
}

//Function Number: 46
irons_estate_whistle(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	level notify("irons_estate_whistle");
	level endon("irons_estate_whistle");
	level endon("missionfailed");
	level.player endon("death");
	if(param_00)
	{
		if(level.start_point == "briefing" || level.start_point == "intro" || level.start_point == "grapple" || level.start_point == "recon" || level.start_point == "infil")
		{
			common_scripts\utility::flag_wait_any("player_concealed","player_skipping_concealed_kill_tutorial","concealed_kill_spawner_dead");
		}

		level.player setweaponhudiconoverride("actionslot" + level.action_slot_whistle,"dpad_icon_whistle");
		var_01 = [];
		var_01[var_01.size] = "irons_whistle";
		level.player notifyonplayercommand("whistle","+actionslot " + level.action_slot_whistle);
	}
	else
	{
		level.player setweaponhudiconoverride("actionslot" + level.action_slot_whistle,"dpad_icon_whistle_off");
		level.player notifyonplayercommandremove("whistle","+actionslot " + level.action_slot_whistle);
		return;
	}

	for(;;)
	{
		while(!common_scripts\utility::flag("_stealth_spotted"))
		{
			level.player waittill("whistle");
			if(isdefined(self.grapple) && isdefined(self.grapple["grappling"]) && self.grapple["grappling"])
			{
				wait(0.05);
				continue;
			}

			level.player playsound(common_scripts\utility::random(var_01),"whistle_done");
			wait(0.25);
			var_02 = getaiarray("axis");
			foreach(var_04 in var_02)
			{
				if(isdefined(var_04.do_not_react_to_whistle) || isdefined(var_04.script_parameters) && var_04.script_parameters == "do_not_react_to_whistle" || isdefined(var_04.script_noteworthy) && var_04.script_noteworthy == "do_not_react_to_whistle")
				{
					var_02 = common_scripts\utility::array_remove(var_02,var_04);
				}
			}

			var_02 = common_scripts\utility::get_array_of_closest(level.player.origin,var_02,undefined,undefined,700,undefined);
			var_02 = maps\_utility::array_removedead_or_dying(var_02);
			if(isdefined(var_02) && var_02.size > 0)
			{
				foreach(var_04 in var_02)
				{
					if(common_scripts\utility::within_fov(level.player geteye(),level.player getplayerangles(),var_04 geteye(),cos(45)))
					{
						var_04 notify("whistle",level.player.origin);
						break;
					}
				}
			}

			wait(1);
		}

		wait(0.1);
	}
}

//Function Number: 47
irons_estate_jump_monitor()
{
	self notify("irons_estate_jump_monitor");
	self endon("irons_estate_jump_monitor");
	self endon("death");
	childthread irons_estate_call_notify(::ishighjumping,"boost_jump_player");
	childthread irons_estate_call_notify(::isdodging,"boost_dodge_player");
	childthread irons_estate_call_notify(::ispowersliding,"boost_slide_player");
	for(;;)
	{
		var_00 = common_scripts\utility::waittill_any_return("boost_jump_player","boost_dodge_player","boost_slide_player");
		var_01 = 600;
		if(var_00 != "boost_jump_player")
		{
			var_01 = 300;
		}

		var_02 = getaiarray("axis","neutral");
		var_02 = common_scripts\utility::get_array_of_closest(self.origin,var_02,undefined,undefined,var_01,undefined);
		var_02 = maps\_utility::array_removedead_or_dying(var_02);
		if(isdefined(var_02) && var_02.size > 0)
		{
			foreach(var_04 in var_02)
			{
				if(var_04.team == "axis")
				{
					var_04 notify("reaction_generic",self.origin);
					continue;
				}

				var_04 notify("alerted",self.origin);
			}
		}
	}
}

//Function Number: 48
irons_estate_call_notify(param_00,param_01)
{
	var_02 = 0;
	for(;;)
	{
		var_03 = self [[ param_00 ]]();
		if(var_03 && !var_02)
		{
			self notify(param_01,self.origin);
		}

		var_02 = var_03;
		wait 0.05;
	}
}

//Function Number: 49
unarmed()
{
	level.scr_anim["generic"]["patrol_walk_unarmed"] = [%patrol_unarmed_walk,%patrol_unarmed_walk_fidget_1,%patrol_unarmed_walk_fidget_2];
	var_00 = [4,1,1];
	level.scr_anim["generic"]["patrol_walk_weights_unarmed"] = common_scripts\utility::get_cumulative_weights(var_00);
	level.scr_anim["generic"]["patrol_walk_unarmed_twitch"] = [%patrol_unarmed_walk_fidget_1,%patrol_unarmed_walk_fidget_2];
	level.scr_anim["generic"]["patrol_stop_unarmed"] = %patrol_unarmed_walk_stop_front;
	level.scr_anim["generic"]["patrol_start_unarmed"] = %patrol_unarmed_walk_start_front;
	level.scr_anim["generic"]["patrol_turn180_unarmed"] = %patrol_unarmed_walk_turn_180;
	level.scr_anim["generic"]["patrol_radio_in_clear_unarmed"] = %patrol_investigate_to_unarmed;
	level.scr_anim["generic"]["patrol_idle_unarmed"] = [%patrol_unarmed_idle,%patrol_unarmed_idle_fidget_1,%patrol_unarmed_idle_fidget_2];
	level.scr_anim["generic"]["patrol_idle_unarmed_1"] = %patrol_unarmed_idle;
	level.scr_anim["generic"]["patrol_idle_unarmed_2"] = %patrol_unarmed_idle_fidget_1;
	level.scr_anim["generic"]["patrol_idle_unarmed_3"] = %patrol_unarmed_idle_fidget_2;
}

//Function Number: 50
investigate()
{
	level.scr_anim["generic"]["patrol_walk_investigate"] = [%patrol_investigate_walk,%patrol_investigate_walk_fidget_1];
	var_00 = [4,1];
	level.scr_anim["generic"]["patrol_walk_weights_investigate"] = common_scripts\utility::get_cumulative_weights(var_00);
	level.scr_anim["generic"]["patrol_walk_investigate_twitch"] = %patrol_investigate_walk_fidget_1;
	level.scr_anim["generic"]["patrol_stop_investigate"] = %patrol_investigate_walk_stop_front;
	level.scr_anim["generic"]["patrol_start_investigate"] = %patrol_investigate_walk_start_front;
	level.scr_anim["generic"]["patrol_turn180_investigate"] = %patrol_investigate_walk_turn_180;
	level.scr_anim["generic"]["patrol_radio_in_clear_investigate"] = %patrolwalk_cold_gunup_transition;
	level.scr_anim["generic"]["patrol_idle_investigate"] = [%patrol_investigate_idle,%patrol_investigate_idle_fidget_1,%patrol_investigate_idle_fidget_2];
	level.scr_anim["generic"]["patrol_idle_investigate_1"] = %patrol_investigate_idle;
	level.scr_anim["generic"]["patrol_idle_investigate_2"] = %patrol_investigate_idle_fidget_1;
	level.scr_anim["generic"]["patrol_idle_investigate_3"] = %patrol_investigate_idle_fidget_2;
	level.scr_anim["generic"]["_stealth_idle_to_run_2_investigate"] = %patrol_unarmed_to_investigate_180;
	level.scr_anim["generic"]["_stealth_idle_to_run_4_investigate"] = %patrol_unarmed_to_investigate_l_90;
	level.scr_anim["generic"]["_stealth_idle_to_run_6_investigate"] = %patrol_unarmed_to_investigate_r_90;
	level.scr_anim["generic"]["_stealth_idle_to_run_8_investigate"] = %patrol_unarmed_to_investigate_front;
	level.scr_anim["generic"]["_stealth_look_around_investigate"] = [%patrol_investigate_idle,%patrol_investigate_idle_fidget_1,%patrol_investigate_idle_fidget_2];
}

//Function Number: 51
irons_estate_stealth_anims()
{
	level.scr_anim["generic"]["_stealth_patrol_jog"] = %patrol_jog;
	level.scr_anim["generic"]["_stealth_patrol_walk"] = %patrol_bored_patrolwalk;
	level.scr_anim["generic"]["_stealth_combat_jog"] = %combat_jog;
	level.scr_anim["generic"]["_stealth_patrol_cqb"] = %cqb_walk_iw6;
	if(!isdefined(level.scr_anim["generic"]["_stealth_patrol_search_a"]))
	{
		level.scr_anim["generic"]["_stealth_patrol_search_a"] = %patrol_boredwalk_lookcycle_a;
		level.scr_anim["generic"]["_stealth_patrol_search_b"] = %patrol_boredwalk_lookcycle_b;
	}

	level.scr_anim["generic"]["_stealth_behavior_spotted_short"] = %exposed_idle_twitch_v4;
	level.scr_anim["generic"]["_stealth_behavior_spotted_long"] = %patrol_bored_react_walkstop_short;
	level.scr_anim["generic"]["_stealth_look_around"][0] = %patrol_bored_react_look_v1;
	level.scr_anim["generic"]["_stealth_look_around"][1] = %patrol_bored_react_look_v2;
	level.scr_anim["generic"]["_stealth_behavior_saw_corpse"] = %exposed_idle_twitch_v4;
	level.scr_anim["generic"]["_stealth_behavior_generic1"] = %patrol_bored_react_look_advance;
	level.scr_anim["generic"]["_stealth_behavior_generic2"] = %patrol_bored_react_look_retreat;
	level.scr_anim["generic"]["_stealth_behavior_generic3"] = %patrol_bored_react_walkstop;
	level.scr_anim["generic"]["_stealth_behavior_generic4"] = %patrol_bored_react_walkstop_short;
	level.scr_anim["generic"]["_stealth_idle_to_run_2"] = %patrol_bored_duckandrun_b;
	level.scr_anim["generic"]["_stealth_idle_to_run_4"] = %patrol_bored_duckandrun_l;
	level.scr_anim["generic"]["_stealth_idle_to_run_6"] = %patrol_bored_duckandrun_r;
	level.scr_anim["generic"]["_stealth_idle_to_run_8"] = %patrol_bored_duckandrun_f;
	level.scr_anim["generic"]["_stealth_find_jog"] = %patrol_boredjog_find;
	level.scr_anim["generic"]["_stealth_find_stand"] = %patrol_bored_react_look_v2;
}

//Function Number: 52
irons_estate_patrol_resume_move_start_func()
{
	self endon("enemy");
	self animmode("zonly_physics",0);
	self orientmode("face current");
	maps\_patrol::stand_up_if_necessary();
	if(isdefined(self.script_animation))
	{
		var_00 = "patrol_radio_in_clear_" + self.script_animation;
		var_01 = level.scr_anim["generic"][var_00];
	}
	else
	{
		var_01 = level.scr_anim["generic"]["patrol_radio_in_clear"];
	}

	if(isdefined(var_01))
	{
		self setflaggedanimknoballrestart("radio",var_01,%root,1);
		animscripts\shared::donotetracks("radio");
	}

	maps\_patrol::turn_180_move_start_func();
}