/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _stealth_visibility_system.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 266 ms
 * Timestamp: 4/22/2024 2:23:20 AM
*******************************************************************/

//Function Number: 1
stealth_visibility_system_main()
{
	system_init();
	thread system_message_loop();
	common_scripts\utility::array_thread(getentarray("stealth_clipbrush","targetname"),::system_handle_clipbrush);
}

//Function Number: 2
system_message_loop()
{
	var_00 = "_stealth_spotted";
	for(;;)
	{
		common_scripts\utility::flag_wait("_stealth_enabled");
		common_scripts\utility::flag_wait(var_00);
		if(!common_scripts\utility::flag("_stealth_enabled"))
		{
			continue;
		}

		system_event_change("spotted");
		thread system_state_spotted();
		common_scripts\utility::flag_waitopen(var_00);
		if(!common_scripts\utility::flag("_stealth_enabled"))
		{
			continue;
		}

		system_event_change("hidden");
		waittillframeend;
	}
}

//Function Number: 3
system_event_change(param_00)
{
	level._stealth.logic.detection_level = param_00;
	foreach(var_04, var_02 in level._stealth.logic.ai_event)
	{
		setsaveddvar(var_04,var_02[param_00]);
		var_03 = "ai_busyEvent" + getsubstr(var_04,8);
		setsaveddvar(var_03,var_02[param_00]);
	}
}

//Function Number: 4
system_state_spotted()
{
	while(common_scripts\utility::flag("_stealth_spotted"))
	{
		common_scripts\utility::flag_wait("_stealth_enabled");
		var_00 = level._stealth.group.groups;
		foreach(var_04, var_02 in var_00)
		{
			var_03 = maps\_stealth_shared_utilities::group_get_flagname_from_group("_stealth_spotted",var_04);
			if(!common_scripts\utility::flag(var_03))
			{
				continue;
			}

			var_02 = common_scripts\utility::array_removeundefined(var_02);
			if(var_02.size > 0)
			{
				if(var_02[0].team == "allies")
				{
					continue;
				}
			}

			thread func_9090(var_04);
		}

		common_scripts\utility::flag_waitopen_or_timeout("_stealth_spotted",1.25);
	}
}

//Function Number: 5
func_9090(param_00)
{
	var_01 = system_state_check_no_enemy(param_00);
	if(!var_01)
	{
		return;
	}

	wait(1);
	var_01 = system_state_check_no_enemy(param_00);
	if(!var_01)
	{
		return;
	}

	maps\_stealth_shared_utilities::group_flag_clear("_stealth_spotted",param_00);
}

//Function Number: 6
system_state_check_no_enemy(param_00)
{
	var_01 = maps\_stealth_shared_utilities::group_get_ai_in_group(param_00);
	foreach(var_03 in var_01)
	{
		if(!isalive(var_03.enemy))
		{
			continue;
		}

		return 0;
	}

	return 1;
}

//Function Number: 7
system_save_processes()
{
	common_scripts\utility::flag_init("_stealth_player_nade");
	level._stealth.logic.player_nades = 0;
	common_scripts\utility::array_thread(level.players,::player_grenade_check);
}

//Function Number: 8
player_grenade_check()
{
	for(;;)
	{
		self waittill("grenade_pullback");
		common_scripts\utility::flag_set("_stealth_player_nade");
		self waittill("grenade_fire",var_00);
		thread player_grenade_check_dieout(var_00);
	}
}

//Function Number: 9
player_grenade_check_dieout(param_00)
{
	level._stealth.logic.player_nades++;
	param_00 common_scripts\utility::waittill_notify_or_timeout("death",10);
	level._stealth.logic.player_nades--;
	waittillframeend;
	if(!level._stealth.logic.player_nades)
	{
		common_scripts\utility::flag_clear("_stealth_player_nade");
	}
}

//Function Number: 10
system_init_shadows()
{
	common_scripts\utility::array_thread(getentarray("_stealth_shadow","targetname"),::stealth_shadow_volumes);
	common_scripts\utility::array_thread(getentarray("stealth_shadow","targetname"),::stealth_shadow_volumes);
}

//Function Number: 11
stealth_shadow_volumes()
{
	self endon("death");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!isalive(var_00))
		{
			continue;
		}

		if(!var_00 maps\_utility::ent_flag_exist("_stealth_in_shadow") || var_00 maps\_utility::ent_flag("_stealth_in_shadow"))
		{
			continue;
		}

		var_00 thread stealth_shadow_ai_in_volume(self);
	}
}

//Function Number: 12
stealth_shadow_ai_in_volume(param_00)
{
	self endon("death");
	maps\_utility::ent_flag_set("_stealth_in_shadow");
	while(isdefined(param_00) && self istouching(param_00))
	{
		wait(0.05);
	}

	maps\_utility::ent_flag_clear("_stealth_in_shadow");
}

//Function Number: 13
system_handle_clipbrush()
{
	self endon("death");
	if(isdefined(self.script_flag_wait))
	{
		common_scripts\utility::flag_wait(self.script_flag_wait);
	}

	waittillframeend;
	var_00 = "_stealth_spotted";
	var_01 = "_stealth_found_corpse";
	var_02 = "_stealth_event";
	if(isdefined(self.script_stealthgroup))
	{
		maps\_stealth_shared_utilities::group_wait_group_spawned(maps\_utility::string(self.script_stealthgroup));
		var_00 = maps\_stealth_shared_utilities::group_get_flagname_from_group(var_00,self.script_stealthgroup);
		var_01 = maps\_stealth_shared_utilities::group_get_flagname_from_group(var_01,self.script_stealthgroup);
		var_02 = maps\_stealth_shared_utilities::group_get_flagname_from_group(var_02,self.script_stealthgroup);
	}

	self setcandamage(1);
	maps\_utility::add_wait(::maps\_utility::waittill_msg,"damage");
	level maps\_utility::add_wait(::common_scripts\utility::flag_wait,var_00);
	level maps\_utility::add_wait(::common_scripts\utility::flag_wait,var_01);
	level maps\_utility::add_wait(::common_scripts\utility::flag_wait,var_02);
	maps\_utility::do_wait_any();
	if(self.spawnflags & 1)
	{
		self connectpaths();
	}

	self delete();
}

//Function Number: 14
system_init()
{
	common_scripts\utility::flag_init("_stealth_spotted");
	common_scripts\utility::flag_init("_stealth_event");
	common_scripts\utility::flag_init("_stealth_enabled");
	common_scripts\utility::flag_set("_stealth_enabled");
	level._stealth = spawnstruct();
	level._stealth.logic = spawnstruct();
	level._stealth.group = spawnstruct();
	level._stealth.group.flags = [];
	level._stealth.group.groups = [];
	level._stealth.logic.detection_level = "hidden";
	level._stealth.logic.detect_range = [];
	level._stealth.logic.detect_range["hidden"] = [];
	level._stealth.logic.detect_range["spotted"] = [];
	system_default_detect_ranges();
	level._stealth.logic.ai_event = [];
	level._stealth.logic.ai_event["ai_eventDistDeath"] = [];
	level._stealth.logic.ai_event["ai_eventDistPain"] = [];
	level._stealth.logic.ai_event["ai_eventDistExplosion"] = [];
	level._stealth.logic.ai_event["ai_eventDistBullet"] = [];
	level._stealth.logic.ai_event["ai_eventDistFootstep"] = [];
	level._stealth.logic.ai_event["ai_eventDistFootstepWalk"] = [];
	level._stealth.logic.ai_event["ai_eventDistFootstepSprint"] = [];
	level._stealth.logic.ai_event["ai_eventDistGunShot"] = [];
	level._stealth.logic.ai_event["ai_eventDistGunShotTeam"] = [];
	level._stealth.logic.ai_event["ai_eventDistNewEnemy"] = [];
	system_default_event_distances();
	system_event_change("hidden");
	system_save_processes();
	system_init_shadows();
	maps\_stealth_utility::stealth_alert_level_duration(0.5);
}

//Function Number: 15
system_default_detect_ranges()
{
	var_00 = [];
	var_00["prone"] = 70;
	var_00["crouch"] = 600;
	var_00["stand"] = 1024;
	var_01 = [];
	var_01["prone"] = 512;
	var_01["crouch"] = 5000;
	var_01["stand"] = 8000;
	system_set_detect_ranges(var_00,var_01);
}

//Function Number: 16
system_set_detect_ranges(param_00,param_01)
{
	if(isdefined(param_00))
	{
		level._stealth.logic.detect_range["hidden"]["prone"] = param_00["prone"];
		level._stealth.logic.detect_range["hidden"]["crouch"] = param_00["crouch"];
		level._stealth.logic.detect_range["hidden"]["stand"] = param_00["stand"];
	}

	if(isdefined(param_01))
	{
		level._stealth.logic.detect_range["spotted"]["prone"] = param_01["prone"];
		level._stealth.logic.detect_range["spotted"]["crouch"] = param_01["crouch"];
		level._stealth.logic.detect_range["spotted"]["stand"] = param_01["stand"];
	}
}

//Function Number: 17
system_default_event_distances()
{
	var_00["ai_eventDistDeath"] = [];
	var_00["ai_eventDistPain"] = [];
	var_00["ai_eventDistExplosion"] = [];
	var_00["ai_eventDistBullet"] = [];
	var_00["ai_eventDistFootstep"] = [];
	var_00["ai_eventDistFootstepWalk"] = [];
	var_00["ai_eventDistFootstepSprint"] = [];
	var_00["ai_eventDistGunShot"] = [];
	var_00["ai_eventDistGunShotTeam"] = [];
	var_00["ai_eventDistNewEnemy"] = [];
	var_00["ai_eventDistDeath"]["spotted"] = getdvar("ai_eventDistDeath");
	var_00["ai_eventDistDeath"]["hidden"] = 512;
	var_00["ai_eventDistPain"]["spotted"] = getdvar("ai_eventDistPain");
	var_00["ai_eventDistPain"]["hidden"] = 256;
	var_00["ai_eventDistExplosion"]["spotted"] = 4000;
	var_00["ai_eventDistExplosion"]["hidden"] = 4000;
	var_00["ai_eventDistBullet"]["spotted"] = 96;
	var_00["ai_eventDistBullet"]["hidden"] = 64;
	var_00["ai_eventDistFootstep"]["spotted"] = 350;
	var_00["ai_eventDistFootstep"]["hidden"] = 64;
	var_00["ai_eventDistFootstepWalk"]["spotted"] = 256;
	var_00["ai_eventDistFootstepWalk"]["hidden"] = 32;
	var_00["ai_eventDistFootstepSprint"]["spotted"] = 400;
	var_00["ai_eventDistFootstepSprint"]["hidden"] = 400;
	var_00["ai_eventDistGunShot"]["spotted"] = 2048;
	var_00["ai_eventDistGunShot"]["hidden"] = 2048;
	var_00["ai_eventDistGunShotTeam"]["spotted"] = 750;
	var_00["ai_eventDistGunShotTeam"]["hidden"] = 750;
	var_00["ai_eventDistNewEnemy"]["spotted"] = 750;
	var_00["ai_eventDistNewEnemy"]["hidden"] = 750;
	system_set_event_distances(var_00);
}

//Function Number: 18
system_set_event_distances(param_00)
{
	foreach(var_06, var_02 in param_00)
	{
		foreach(var_05, var_04 in var_02)
		{
			level._stealth.logic.ai_event[var_06][var_05] = var_04;
		}
	}
}