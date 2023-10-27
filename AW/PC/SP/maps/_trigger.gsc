/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_trigger.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 86
 * Decompile Time: 1341 ms
 * Timestamp: 10/27/2023 2:01:14 AM
*******************************************************************/

//Function Number: 1
get_load_trigger_classes()
{
	var_00 = [];
	var_00["trigger_multiple_nobloodpool"] = ::trigger_nobloodpool;
	var_00["trigger_multiple_flag_set"] = ::trigger_flag_set;
	var_00["trigger_multiple_flag_clear"] = ::trigger_flag_clear;
	var_00["trigger_multiple_sun_off"] = ::trigger_sun_off;
	var_00["trigger_multiple_sun_on"] = ::trigger_sun_on;
	var_00["trigger_use_flag_set"] = ::trigger_flag_set;
	var_00["trigger_use_flag_clear"] = ::trigger_flag_clear;
	var_00["trigger_multiple_flag_set_touching"] = ::trigger_flag_set_touching;
	var_00["trigger_multiple_flag_lookat"] = ::trigger_lookat;
	var_00["trigger_multiple_flag_looking"] = ::trigger_looking;
	var_00["trigger_multiple_no_prone"] = ::trigger_no_prone;
	var_00["trigger_multiple_no_crouch_or_prone"] = ::trigger_no_crouch_or_prone;
	var_00["trigger_multiple_compass"] = ::trigger_multiple_compass;
	var_00["trigger_multiple_specialops_flag_set"] = ::trigger_flag_set_specialops;
	var_00["trigger_multiple_fx_volume"] = ::trigger_multiple_fx_volume;
	var_00["trigger_multiple_fx_fxzone"] = ::trigger_flag_set_touching;
	var_00["trigger_multiple_light_sunshadow"] = ::maps\_lights::sun_shadow_trigger;
	if(!maps\_utility::is_no_game_start())
	{
		var_00["trigger_multiple_autosave"] = ::maps\_autosave::trigger_autosave;
		var_00["trigger_multiple_spawn"] = ::maps\_spawner::trigger_spawner;
		var_00["trigger_multiple_spawn_reinforcement"] = ::maps\_spawner::trigger_spawner_reinforcement;
	}

	var_00["trigger_multiple_slide"] = ::trigger_slide;
	var_00["trigger_multiple_statscheckpoint"] = ::trigger_stats;
	var_00["trigger_multiple_fog"] = ::trigger_fog;
	var_00["trigger_multiple_depthoffield"] = ::trigger_multiple_depthoffield;
	var_00["trigger_multiple_tessellationcutoff"] = ::trigger_multiple_tessellationcutoff;
	var_00["trigger_damage_player_flag_set"] = ::trigger_damage_player_flag_set;
	var_00["trigger_multiple_visionset"] = ::trigger_multiple_visionset;
	var_00["trigger_multiple_sunflare"] = ::trigger_multiple_sunflare;
	var_00["trigger_multiple_glass_break"] = ::trigger_glass_break;
	var_00["trigger_radius_glass_break"] = ::trigger_glass_break;
	var_00["trigger_multiple_friendly_respawn"] = ::trigger_friendly_respawn;
	var_00["trigger_multiple_enemy_respawn"] = ::trigger_enemy_respawn;
	var_00["trigger_multiple_friendly_stop_respawn"] = ::trigger_friendly_stop_respawn;
	var_00["trigger_multiple_enemy_stop_respawn"] = ::trigger_enemy_stop_respawn;
	var_00["trigger_multiple_physics"] = ::trigger_physics;
	var_00["trigger_multiple_fx_watersheeting"] = ::trigger_multiple_fx_watersheeting;
	var_00["trigger_multiple_fx_wakevolume"] = ::trigger_wakevolume_think;
	var_00["trigger_multiple_fx_fallingwatervolume"] = ::trigger_fallingwatervolume_think;
	return var_00;
}

//Function Number: 2
trigger_multiple_fx_watersheeting(param_00)
{
	var_01 = 3;
	if(isdefined(param_00.script_duration))
	{
		var_01 = param_00.script_duration;
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		if(isplayer(var_02))
		{
			var_02 setwatersheeting(1,var_01);
			wait(var_01 * 0.2);
		}
	}
}

//Function Number: 3
get_load_trigger_funcs()
{
	var_00 = [];
	var_00["friendly_wave"] = ::maps\_spawner::friendly_wave;
	var_00["friendly_wave_off"] = ::maps\_spawner::friendly_wave;
	var_00["friendly_mgTurret"] = ::maps\_spawner::friendly_mgturret;
	if(!maps\_utility::is_no_game_start())
	{
		var_00["camper_spawner"] = ::maps\_spawner::camper_trigger_think;
		var_00["flood_spawner"] = ::maps\_spawner::flood_trigger_think;
		var_00["trigger_spawner"] = ::maps\_spawner::trigger_spawner;
		var_00["trigger_autosave"] = ::maps\_autosave::trigger_autosave;
		var_00["trigger_spawngroup"] = ::trigger_spawngroup;
		var_00["two_stage_spawner"] = ::maps\_spawner::two_stage_spawner_think;
		var_00["trigger_vehicle_spline_spawn"] = ::trigger_vehicle_spline_spawn;
		var_00["trigger_vehicle_spawn"] = ::trigger_vehicle_spawn;
		var_00["trigger_vehicle_getin_spawn"] = ::trigger_vehicle_getin_spawn;
		var_00["random_spawn"] = ::maps\_spawner::random_spawn;
	}

	var_00["autosave_now"] = ::maps\_autosave::autosave_now_trigger;
	var_00["trigger_autosave_tactical"] = ::maps\_autosave::trigger_autosave_tactical;
	var_00["trigger_autosave_stealth"] = ::maps\_autosave::trigger_autosave_stealth;
	var_00["trigger_unlock"] = ::trigger_unlock;
	var_00["trigger_lookat"] = ::trigger_lookat;
	var_00["trigger_looking"] = ::trigger_looking;
	var_00["trigger_cansee"] = ::trigger_cansee;
	var_00["autosave_immediate"] = ::maps\_autosave::trigger_autosave_immediate;
	var_00["flag_set"] = ::trigger_flag_set;
	if(maps\_utility::is_coop())
	{
		var_00["flag_set_coop"] = ::trigger_flag_set_coop;
	}

	var_00["flag_set_player"] = ::trigger_flag_set_player;
	var_00["flag_unset"] = ::trigger_flag_clear;
	var_00["flag_clear"] = ::trigger_flag_clear;
	var_00["objective_event"] = ::maps\_spawner::objective_event_init;
	var_00["friendly_respawn_trigger"] = ::trigger_friendly_respawn;
	var_00["enemy_respawn_trigger"] = ::trigger_enemy_respawn;
	var_00["radio_trigger"] = ::trigger_radio;
	var_00["trigger_ignore"] = ::trigger_ignore;
	var_00["trigger_pacifist"] = ::trigger_pacifist;
	var_00["trigger_delete"] = ::trigger_turns_off;
	var_00["trigger_delete_on_touch"] = ::trigger_delete_on_touch;
	var_00["trigger_off"] = ::trigger_turns_off;
	var_00["trigger_outdoor"] = ::maps\_spawner::outdoor_think;
	var_00["trigger_indoor"] = ::maps\_spawner::indoor_think;
	var_00["trigger_hint"] = ::trigger_hint;
	var_00["trigger_grenade_at_player"] = ::trigger_throw_grenade_at_player;
	var_00["flag_on_cleared"] = ::trigger_flag_on_cleared;
	var_00["flag_set_touching"] = ::trigger_flag_set_touching;
	var_00["delete_link_chain"] = ::trigger_delete_link_chain;
	var_00["trigger_fog"] = ::trigger_fog;
	var_00["trigger_slide"] = ::trigger_slide;
	var_00["trigger_stats"] = ::trigger_stats;
	var_00["trigger_dooropen"] = ::trigger_dooropen;
	var_00["no_crouch_or_prone"] = ::trigger_no_crouch_or_prone;
	var_00["no_prone"] = ::trigger_no_prone;
	return var_00;
}

//Function Number: 4
init_script_triggers()
{
	var_00 = get_load_trigger_classes();
	var_01 = get_load_trigger_funcs();
	foreach(var_05, var_03 in var_00)
	{
		var_04 = getentarray(var_05,"classname");
		common_scripts\utility::array_levelthread(var_04,var_03);
	}

	var_06 = getentarray("trigger_multiple","classname");
	var_07 = getentarray("trigger_radius","classname");
	var_04 = maps\_utility::array_merge(var_06,var_07);
	var_08 = getentarray("trigger_disk","classname");
	var_04 = maps\_utility::array_merge(var_04,var_08);
	var_09 = getentarray("trigger_once","classname");
	var_04 = maps\_utility::array_merge(var_04,var_09);
	if(!maps\_utility::is_no_game_start())
	{
		for(var_0A = 0;var_0A < var_04.size;var_0A++)
		{
			if(var_04[var_0A].spawnflags & 32)
			{
				thread maps\_spawner::trigger_spawner(var_04[var_0A]);
			}
		}
	}

	var_0B = 0;
	if(var_0B < 7)
	{
		switch(var_0B)
		{
			case 0:
				break;

			case 1:
				break;

			case 2:
				break;

			case 3:
				break;

			case 4:
				break;

			case 5:
				break;

			default:
				break;
		}
	}
}

//Function Number: 5
trigger_createart_transient(param_00)
{
	var_01 = 1;
	if(var_01)
	{
		param_00 delete();
	}
}

//Function Number: 6
createart_transient_thread()
{
}

//Function Number: 7
trigger_damage_player_flag_set(param_00)
{
	var_01 = param_00 maps\_utility::get_trigger_flag();
	if(!isdefined(level.flag[var_01]))
	{
		common_scripts\utility::flag_init(var_01);
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		if(!isalive(var_02))
		{
			continue;
		}

		if(!isplayer(var_02))
		{
			continue;
		}

		param_00 maps\_utility::script_delay();
		common_scripts\utility::flag_set(var_01,var_02);
	}
}

//Function Number: 8
trigger_flag_clear(param_00)
{
	var_01 = param_00 maps\_utility::get_trigger_flag();
	if(!isdefined(level.flag[var_01]))
	{
		common_scripts\utility::flag_init(var_01);
	}

	for(;;)
	{
		param_00 waittill("trigger");
		param_00 maps\_utility::script_delay();
		common_scripts\utility::flag_clear(var_01);
	}
}

//Function Number: 9
trigger_flag_on_cleared(param_00)
{
	var_01 = param_00 maps\_utility::get_trigger_flag();
	if(!isdefined(level.flag[var_01]))
	{
		common_scripts\utility::flag_init(var_01);
	}

	for(;;)
	{
		param_00 waittill("trigger");
		wait(1);
		if(param_00 found_toucher())
		{
			continue;
		}

		break;
	}

	common_scripts\utility::flag_set(var_01);
}

//Function Number: 10
found_toucher()
{
	var_00 = getaiarray("bad_guys");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = var_00[var_01];
		if(!isalive(var_02))
		{
			continue;
		}

		if(var_02 istouching(self))
		{
			return 1;
		}

		wait(0.1);
	}

	var_00 = getaiarray("bad_guys");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_02 = var_00[var_01];
		if(var_02 istouching(self))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 11
trigger_flag_set(param_00)
{
	var_01 = param_00 maps\_utility::get_trigger_flag();
	if(!isdefined(level.flag[var_01]))
	{
		common_scripts\utility::flag_init(var_01);
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		param_00 maps\_utility::script_delay();
		common_scripts\utility::flag_set(var_01,var_02);
	}
}

//Function Number: 12
trigger_flag_set_coop(param_00)
{
	var_01 = param_00 maps\_utility::get_trigger_flag();
	if(!isdefined(level.flag[var_01]))
	{
		common_scripts\utility::flag_init(var_01);
	}

	var_02 = [];
	for(;;)
	{
		param_00 waittill("trigger",var_03);
		if(!isplayer(var_03))
		{
			continue;
		}

		var_04 = [];
		var_04[var_04.size] = var_03;
		var_02 = maps\_utility::array_merge(var_02,var_04);
		if(var_02.size == level.players.size)
		{
			break;
		}
	}

	param_00 maps\_utility::script_delay();
	common_scripts\utility::flag_set(var_01);
}

//Function Number: 13
trigger_flag_set_specialops(param_00)
{
	var_01 = param_00 maps\_utility::get_trigger_flag();
	if(!isdefined(level.flag[var_01]))
	{
		common_scripts\utility::flag_init(var_01);
	}

	param_00.player_touched_arr = level.players;
	param_00 thread trigger_flag_set_specialops_clear(var_01);
	for(;;)
	{
		param_00 waittill("trigger",var_02);
		param_00.player_touched_arr = common_scripts\utility::array_remove(param_00.player_touched_arr,var_02);
		if(param_00.player_touched_arr.size)
		{
			continue;
		}

		param_00 maps\_utility::script_delay();
		common_scripts\utility::flag_set(var_01,var_02);
	}
}

//Function Number: 14
trigger_flag_set_specialops_clear(param_00)
{
	for(;;)
	{
		level waittill(param_00);
		if(common_scripts\utility::flag(param_00))
		{
			self.player_touched_arr = [];
			continue;
		}

		self.player_touched_arr = level.players;
	}
}

//Function Number: 15
trigger_friendly_respawn(param_00)
{
	param_00 endon("death");
	var_01 = getent(param_00.target,"targetname");
	var_02 = undefined;
	if(isdefined(var_01))
	{
		var_02 = var_01.origin;
		var_01 delete();
	}
	else
	{
		var_01 = common_scripts\utility::getstruct(param_00.target,"targetname");
		var_02 = var_01.origin;
	}

	for(;;)
	{
		param_00 waittill("trigger");
		maps\_colors::colornode_set_respawn_point(var_02,"allies");
		common_scripts\utility::flag_set("respawn_friendlies");
		wait(0.5);
	}
}

//Function Number: 16
trigger_friendly_stop_respawn(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger");
		common_scripts\utility::flag_clear("respawn_friendlies");
	}
}

//Function Number: 17
trigger_enemy_respawn(param_00)
{
	param_00 endon("death");
	var_01 = getent(param_00.target,"targetname");
	var_02 = undefined;
	if(isdefined(var_01))
	{
		var_02 = var_01.origin;
		var_01 delete();
	}
	else
	{
		var_01 = common_scripts\utility::getstruct(param_00.target,"targetname");
		var_02 = var_01.origin;
	}

	for(;;)
	{
		param_00 waittill("trigger");
		maps\_colors::colornode_set_respawn_point(var_02,"axis");
		common_scripts\utility::flag_set("respawn_enemies");
		wait(0.5);
	}
}

//Function Number: 18
trigger_enemy_stop_respawn(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger");
		common_scripts\utility::flag_clear("respawn_enemies");
	}
}

//Function Number: 19
trigger_flag_set_touching(param_00)
{
	var_01 = param_00 maps\_utility::get_trigger_flag();
	if(!isdefined(level.flag[var_01]))
	{
		common_scripts\utility::flag_init(var_01);
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		param_00 maps\_utility::script_delay();
		if(isalive(var_02) && var_02 istouching(param_00) && isdefined(param_00))
		{
			common_scripts\utility::flag_set(var_01);
		}

		while(isalive(var_02) && var_02 istouching(param_00) && isdefined(param_00))
		{
			wait(0.25);
		}

		common_scripts\utility::flag_clear(var_01);
	}
}

//Function Number: 20
trigger_group()
{
	thread trigger_group_remove();
	level endon("trigger_group_" + self.script_trigger_group);
	self waittill("trigger");
	level notify("trigger_group_" + self.script_trigger_group,self);
}

//Function Number: 21
trigger_group_remove()
{
	level waittill("trigger_group_" + self.script_trigger_group,var_00);
	if(self != var_00)
	{
		self delete();
	}
}

//Function Number: 22
trigger_nobloodpool(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isalive(var_01))
		{
			continue;
		}

		var_01.skipbloodpool = 1;
		var_01 thread set_wait_then_clear_skipbloodpool();
	}
}

//Function Number: 23
set_wait_then_clear_skipbloodpool()
{
	self notify("notify_wait_then_clear_skipBloodPool");
	self endon("notify_wait_then_clear_skipBloodPool");
	self endon("death");
	wait(2);
	self.skipbloodpool = undefined;
}

//Function Number: 24
trigger_physics(param_00)
{
	var_01 = [];
	var_02 = common_scripts\utility::getstructarray(param_00.target,"targetname");
	var_03 = getentarray(param_00.target,"targetname");
	foreach(var_05 in var_03)
	{
		var_06 = spawnstruct();
		var_06.origin = var_05.origin;
		var_06.script_parameters = var_05.script_parameters;
		var_06.script_damage = var_05.script_damage;
		var_06.radius = var_05.radius;
		var_02[var_02.size] = var_06;
		var_05 delete();
	}

	param_00.org = var_02[0].origin;
	param_00 waittill("trigger");
	param_00 maps\_utility::script_delay();
	foreach(var_06 in var_02)
	{
		var_09 = var_06.radius;
		var_0A = var_06.script_parameters;
		var_0B = var_06.script_damage;
		if(!isdefined(var_09))
		{
			var_09 = 350;
		}

		if(!isdefined(var_0A))
		{
			var_0A = 0.25;
		}

		setdvar("tempdvar",var_0A);
		var_0A = getdvarfloat("tempdvar");
		if(isdefined(var_0B))
		{
			radiusdamage(var_06.origin,var_09,var_0B,var_0B * 0.5);
		}

		physicsexplosionsphere(var_06.origin,var_09,var_09 * 0.5,var_0A);
	}
}

//Function Number: 25
trigger_playerseek(param_00)
{
	var_01 = param_00.script_triggered_playerseek;
	param_00 waittill("trigger");
	var_02 = getaiarray();
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(!isalive(var_02[var_03]))
		{
			continue;
		}

		if(isdefined(var_02[var_03].script_triggered_playerseek) && var_02[var_03].script_triggered_playerseek == var_01)
		{
			var_02[var_03].goalradius = 800;
			var_02[var_03] setgoalentity(level.player);
			level thread maps\_spawner::delayed_player_seek_think(var_02[var_03]);
		}
	}
}

//Function Number: 26
trigger_script_flag_false(param_00)
{
	var_01 = common_scripts\utility::create_flags_and_return_tokens(param_00.script_flag_false);
	param_00 add_tokens_to_trigger_flags(var_01);
	param_00 common_scripts\utility::update_trigger_based_on_flags();
}

//Function Number: 27
trigger_script_flag_true(param_00)
{
	var_01 = common_scripts\utility::create_flags_and_return_tokens(param_00.script_flag_true);
	param_00 add_tokens_to_trigger_flags(var_01);
	param_00 common_scripts\utility::update_trigger_based_on_flags();
}

//Function Number: 28
add_tokens_to_trigger_flags(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		var_02 = param_00[var_01];
		if(!isdefined(level.trigger_flags[var_02]))
		{
			level.trigger_flags[var_02] = [];
		}

		level.trigger_flags[var_02][level.trigger_flags[var_02].size] = self;
	}
}

//Function Number: 29
trigger_spawngroup(param_00)
{
	waittillframeend;
	var_01 = param_00.script_spawngroup;
	if(!isdefined(level.spawn_groups[var_01]))
	{
		return;
	}

	param_00 waittill("trigger");
	var_02 = common_scripts\utility::random(level.spawn_groups[var_01]);
	foreach(var_04 in var_02)
	{
		var_04 maps\_utility::spawn_ai();
	}
}

//Function Number: 30
trigger_sun_off(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(getdvarint("sm_sunenable") == 0)
		{
			continue;
		}

		setsaveddvar("sm_sunenable",0);
	}
}

//Function Number: 31
trigger_sun_on(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(getdvarint("sm_sunenable") == 1)
		{
			continue;
		}

		setsaveddvar("sm_sunenable",1);
	}
}

//Function Number: 32
trigger_vehicle_getin_spawn(param_00)
{
	var_01 = getentarray(param_00.target,"targetname");
	foreach(var_03 in var_01)
	{
		var_04 = getentarray(var_03.target,"targetname");
		foreach(var_06 in var_04)
		{
			if(!issubstr(var_06.code_classname,"actor"))
			{
				continue;
			}

			if(!var_06.spawnflags & 1)
			{
				continue;
			}

			var_06.dont_auto_ride = 1;
		}
	}

	param_00 waittill("trigger");
	var_01 = getentarray(param_00.target,"targetname");
	common_scripts\utility::array_thread(var_01,maps\_vehicle_free_drive::spawn_vehicle_and_attach_to_free_path(undefined,0,1));
}

//Function Number: 33
trigger_vehicle_spline_spawn(param_00)
{
	param_00 waittill("trigger");
	var_01 = getentarray(param_00.target,"targetname");
	foreach(var_03 in var_01)
	{
		var_03 thread maps\_vehicle_free_drive::spawn_vehicle_and_attach_to_free_path(70);
		wait(0.05);
	}
}

//Function Number: 34
get_trigger_targs()
{
	var_00 = [];
	var_01 = undefined;
	if(isdefined(self.target))
	{
		var_02 = getentarray(self.target,"targetname");
		var_03 = [];
		foreach(var_05 in var_02)
		{
			if(var_05.classname == "script_origin")
			{
				var_03[var_03.size] = var_05;
			}

			if(issubstr(var_05.classname,"trigger"))
			{
				var_00[var_00.size] = var_05;
			}
		}

		var_02 = common_scripts\utility::getstructarray(self.target,"targetname");
		foreach(var_05 in var_02)
		{
			var_03[var_03.size] = var_05;
		}

		if(var_03.size == 1)
		{
			var_09 = var_03[0];
			var_01 = var_09.origin;
			if(isdefined(var_09.code_classname))
			{
				var_09 delete();
			}
		}
	}

	var_0A = [];
	var_0A["triggers"] = var_00;
	var_0A["target_origin"] = var_01;
	return var_0A;
}

//Function Number: 35
trigger_lookat(param_00)
{
	trigger_lookat_think(param_00,1);
}

//Function Number: 36
trigger_looking(param_00)
{
	trigger_lookat_think(param_00,0);
}

//Function Number: 37
trigger_lookat_think(param_00,param_01)
{
	var_02 = 0.78;
	if(isdefined(param_00.script_dot))
	{
		var_02 = param_00.script_dot;
	}

	var_03 = param_00 get_trigger_targs();
	var_04 = var_03["triggers"];
	var_05 = var_03["target_origin"];
	var_06 = isdefined(param_00.script_flag) || isdefined(param_00.script_noteworthy);
	var_07 = undefined;
	if(var_06)
	{
		var_07 = param_00 maps\_utility::get_trigger_flag();
		if(!isdefined(level.flag[var_07]))
		{
			common_scripts\utility::flag_init(var_07);
		}
	}
	else if(!var_04.size)
	{
	}

	if(param_01 && var_06)
	{
		level endon(var_07);
	}

	param_00 endon("death");
	var_08 = 0;
	if(isdefined(param_00.script_parameters))
	{
		var_08 = !issubstr("no_sight",param_00.script_parameters);
	}

	for(;;)
	{
		if(var_06)
		{
			common_scripts\utility::flag_clear(var_07);
		}

		param_00 waittill("trigger",var_09);
		var_0A = [];
		while(var_09 istouching(param_00))
		{
			if(var_08 && !sighttracepassed(var_09 geteye(),var_05,0,undefined))
			{
				if(var_06)
				{
					common_scripts\utility::flag_clear(var_07);
				}

				wait(0.5);
				continue;
			}

			var_0B = vectornormalize(var_05 - var_09.origin);
			var_0C = var_09 getplayerangles();
			var_0D = anglestoforward(var_0C);
			var_0E = vectordot(var_0D,var_0B);
			if(var_0E >= var_02)
			{
				common_scripts\utility::array_thread(var_04,::maps\_utility::send_notify,"trigger");
				if(var_06)
				{
					common_scripts\utility::flag_set(var_07,var_09);
				}

				if(param_01)
				{
					return;
				}

				wait(2);
			}
			else if(var_06)
			{
				common_scripts\utility::flag_clear(var_07);
			}

			if(var_08)
			{
				wait(0.5);
				continue;
			}

			wait(0.05);
		}
	}
}

//Function Number: 38
trigger_cansee(param_00)
{
	var_01 = [];
	var_02 = undefined;
	var_03 = param_00 get_trigger_targs();
	var_01 = var_03["triggers"];
	var_02 = var_03["target_origin"];
	var_04 = isdefined(param_00.script_flag) || isdefined(param_00.script_noteworthy);
	var_05 = undefined;
	if(var_04)
	{
		var_05 = param_00 maps\_utility::get_trigger_flag();
		if(!isdefined(level.flag[var_05]))
		{
			common_scripts\utility::flag_init(var_05);
		}
	}
	else if(!var_01.size)
	{
	}

	param_00 endon("death");
	var_06 = 12;
	var_07 = [];
	var_07[var_07.size] = (0,0,0);
	var_07[var_07.size] = (var_06,0,0);
	var_07[var_07.size] = (var_06 * -1,0,0);
	var_07[var_07.size] = (0,var_06,0);
	var_07[var_07.size] = (0,var_06 * -1,0);
	var_07[var_07.size] = (0,0,var_06);
	for(;;)
	{
		if(var_04)
		{
			common_scripts\utility::flag_clear(var_05);
		}

		param_00 waittill("trigger",var_08);
		while(level.player istouching(param_00))
		{
			if(!var_08 cantraceto(var_02,var_07))
			{
				if(var_04)
				{
					common_scripts\utility::flag_clear(var_05);
				}

				wait(0.1);
				continue;
			}

			if(var_04)
			{
				common_scripts\utility::flag_set(var_05);
			}

			common_scripts\utility::array_thread(var_01,::maps\_utility::send_notify,"trigger");
			wait(0.5);
		}
	}
}

//Function Number: 39
cantraceto(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_01.size;var_02++)
	{
		if(sighttracepassed(self geteye(),param_00 + param_01[var_02],1,self))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 40
trigger_unlock(param_00)
{
	var_01 = "not_set";
	if(isdefined(param_00.script_noteworthy))
	{
		var_01 = param_00.script_noteworthy;
	}

	var_02 = getentarray(param_00.target,"targetname");
	param_00 thread trigger_unlock_death(param_00.target);
	for(;;)
	{
		common_scripts\utility::array_thread(var_02,::common_scripts\utility::trigger_off);
		param_00 waittill("trigger");
		common_scripts\utility::array_thread(var_02,::common_scripts\utility::trigger_on);
		wait_for_an_unlocked_trigger(var_02,var_01);
		maps\_utility::array_notify(var_02,"relock");
	}
}

//Function Number: 41
trigger_unlock_death(param_00)
{
	self waittill("death");
	var_01 = getentarray(param_00,"targetname");
	common_scripts\utility::array_thread(var_01,::common_scripts\utility::trigger_off);
}

//Function Number: 42
wait_for_an_unlocked_trigger(param_00,param_01)
{
	level endon("unlocked_trigger_hit" + param_01);
	var_02 = spawnstruct();
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		param_00[var_03] thread report_trigger(var_02,param_01);
	}

	var_02 waittill("trigger");
	level notify("unlocked_trigger_hit" + param_01);
}

//Function Number: 43
report_trigger(param_00,param_01)
{
	self endon("relock");
	level endon("unlocked_trigger_hit" + param_01);
	self waittill("trigger");
	param_00 notify("trigger");
}

//Function Number: 44
trigger_battlechatter(param_00)
{
	var_01 = undefined;
	if(isdefined(param_00.target))
	{
		var_02 = getentarray(param_00.target,"targetname");
		if(issubstr(var_02[0].classname,"trigger"))
		{
			var_01 = var_02[0];
		}
	}

	if(isdefined(var_01))
	{
		var_01 waittill("trigger",var_03);
	}
	else
	{
		var_01 waittill("trigger",var_03);
	}

	var_04 = undefined;
	if(isdefined(var_01))
	{
		if(var_03.team != level.player.team && level.player istouching(param_00))
		{
			var_04 = level.player animscripts\battlechatter::getclosestfriendlyspeaker("custom");
		}
		else if(var_03.team == level.player.team)
		{
			var_05 = "axis";
			if(level.player.team == "axis")
			{
				var_05 = "allies";
			}

			var_06 = animscripts\battlechatter::getspeakers("custom",var_05);
			var_06 = common_scripts\utility::get_array_of_farthest(level.player.origin,var_06);
			foreach(var_08 in var_06)
			{
				if(var_08 istouching(param_00))
				{
					var_04 = var_08;
					if(battlechatter_dist_check(var_08.origin))
					{
						break;
					}
				}
			}
		}
	}
	else if(isplayer(var_03))
	{
		var_04 = var_03 animscripts\battlechatter::getclosestfriendlyspeaker("custom");
	}
	else
	{
		var_04 = var_03;
	}

	if(!isdefined(var_04))
	{
		return;
	}

	if(battlechatter_dist_check())
	{
		return;
	}

	var_0A = var_04 maps\_utility::custom_battlechatter(param_00.script_bctrigger);
	if(!var_0A)
	{
		level maps\_utility::delaythread(0.25,::trigger_battlechatter,param_00);
		return;
	}

	param_00 notify("custom_battlechatter_done");
}

//Function Number: 45
battlechatter_dist_check(param_00)
{
	return distancesquared(param_00,level.player getorigin()) <= 262144;
}

//Function Number: 46
trigger_vehicle_spawn(param_00)
{
	param_00 waittill("trigger");
	var_01 = getentarray(param_00.target,"targetname");
	foreach(var_03 in var_01)
	{
		var_03 thread maps\_vehicle::spawn_vehicle_and_gopath();
		wait(0.05);
	}
}

//Function Number: 47
trigger_dooropen(param_00)
{
	param_00 waittill("trigger");
	var_01 = getentarray(param_00.target,"targetname");
	var_02 = [];
	var_02["left_door"] = -170;
	var_02["right_door"] = 170;
	foreach(var_04 in var_01)
	{
		var_05 = var_02[var_04.script_noteworthy];
		var_04 connectpaths();
		var_04 rotateyaw(var_05,1,0,0.5);
	}
}

//Function Number: 48
trigger_glass_break(param_00)
{
	var_01 = getglassarray(param_00.target);
	if(!isdefined(var_01) || var_01.size == 0)
	{
		return;
	}

	for(;;)
	{
		level waittill("glass_break",var_02);
		if(var_02 istouching(param_00))
		{
			var_03 = var_02.origin;
			wait(0.05);
			var_04 = var_02.origin;
			var_05 = undefined;
			if(var_03 != var_04)
			{
				var_05 = var_04 - var_03;
			}

			if(isdefined(var_05))
			{
				foreach(var_07 in var_01)
				{
					destroyglass(var_07,var_05);
				}

				break;
			}
			else
			{
				foreach(var_07 in var_01)
				{
					destroyglass(var_07);
				}

				break;
			}
		}
	}

	param_00 delete();
}

//Function Number: 49
trigger_delete_link_chain(param_00)
{
	param_00 waittill("trigger");
	var_01 = param_00 get_script_linkto_targets();
	common_scripts\utility::array_thread(var_01,::delete_links_then_self);
}

//Function Number: 50
get_script_linkto_targets()
{
	var_00 = [];
	if(!isdefined(self.script_linkto))
	{
		return var_00;
	}

	var_01 = strtok(self.script_linkto," ");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_03 = var_01[var_02];
		var_04 = getent(var_03,"script_linkname");
		if(isdefined(var_04))
		{
			var_00[var_00.size] = var_04;
		}
	}

	return var_00;
}

//Function Number: 51
delete_links_then_self()
{
	var_00 = get_script_linkto_targets();
	common_scripts\utility::array_thread(var_00,::delete_links_then_self);
	self delete();
}

//Function Number: 52
trigger_throw_grenade_at_player(param_00)
{
	param_00 endon("death");
	param_00 waittill("trigger");
	maps\_utility::throwgrenadeatplayerasap();
}

//Function Number: 53
trigger_hint(param_00)
{
	if(!isdefined(level.displayed_hints))
	{
		level.displayed_hints = [];
	}

	waittillframeend;
	var_01 = param_00.script_hint;
	param_00 waittill("trigger",var_02);
	if(isdefined(level.displayed_hints[var_01]))
	{
		return;
	}

	level.displayed_hints[var_01] = 1;
	var_02 maps\_utility::display_hint(var_01);
}

//Function Number: 54
trigger_delete_on_touch(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(isdefined(var_01))
		{
			var_01 delete();
		}
	}
}

//Function Number: 55
trigger_turns_off(param_00)
{
	param_00 waittill("trigger");
	param_00 common_scripts\utility::trigger_off();
	if(!isdefined(param_00.script_linkto))
	{
		return;
	}

	var_01 = strtok(param_00.script_linkto," ");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		common_scripts\utility::array_thread(getentarray(var_01[var_02],"script_linkname"),::common_scripts\utility::trigger_off);
	}
}

//Function Number: 56
trigger_ignore(param_00)
{
	thread trigger_runs_function_on_touch(param_00,::maps\_utility::set_ignoreme,::maps\_utility::get_ignoreme);
}

//Function Number: 57
trigger_pacifist(param_00)
{
	thread trigger_runs_function_on_touch(param_00,::maps\_utility::set_pacifist,::maps\_utility::get_pacifist);
}

//Function Number: 58
trigger_runs_function_on_touch(param_00,param_01,param_02)
{
	for(;;)
	{
		param_00 waittill("trigger",var_03);
		if(!isalive(var_03))
		{
			continue;
		}

		if(var_03 [[ param_02 ]]())
		{
			continue;
		}

		var_03 thread touched_trigger_runs_func(param_00,param_01);
	}
}

//Function Number: 59
touched_trigger_runs_func(param_00,param_01)
{
	self endon("death");
	self.ignoreme = 1;
	[[ param_01 ]](1);
	self.ignoretriggers = 1;
	wait(1);
	self.ignoretriggers = 0;
	while(self istouching(param_00))
	{
		wait(1);
	}

	[[ param_01 ]](0);
}

//Function Number: 60
trigger_radio(param_00)
{
	param_00 waittill("trigger");
	maps\_utility::radio_dialogue(param_00.script_noteworthy);
}

//Function Number: 61
trigger_flag_set_player(param_00)
{
	if(maps\_utility::is_coop())
	{
		thread trigger_flag_set_coop(param_00);
		return;
	}

	var_01 = param_00 maps\_utility::get_trigger_flag();
	if(!isdefined(level.flag[var_01]))
	{
		common_scripts\utility::flag_init(var_01);
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		if(!isplayer(var_02))
		{
			continue;
		}

		param_00 maps\_utility::script_delay();
		common_scripts\utility::flag_set(var_01);
	}
}

//Function Number: 62
trigger_multiple_sunflare(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		var_01 maps\_art::sunflare_changes(param_00.script_visionset,param_00.script_delay);
		wait 0.05;
	}
}

//Function Number: 63
trigger_multiple_visionset(param_00)
{
	var_01 = 0;
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	if(isdefined(param_00.script_visionset_start) && isdefined(param_00.script_visionset_end))
	{
		var_01 = 1;
		var_03 = getent(param_00.target,"targetname");
		if(!isdefined(var_03))
		{
			var_03 = common_scripts\utility::getstruct(param_00.target,"targetname");
		}

		var_04 = getent(var_03.target,"targetname");
		if(!isdefined(var_04))
		{
			var_04 = common_scripts\utility::getstruct(var_03.target,"targetname");
		}

		var_03 = var_03.origin;
		var_04 = var_04.origin;
		var_02 = distance(var_03,var_04);
		param_00 init_visionset_progress_trigger();
	}

	var_05 = -1;
	for(;;)
	{
		param_00 waittill("trigger",var_06);
		if(isplayer(var_06))
		{
			if(var_01)
			{
				var_07 = 0;
				while(var_06 istouching(param_00))
				{
					var_07 = maps\_utility::get_progress(var_03,var_04,var_06.origin,var_02);
					var_07 = clamp(var_07,0,1);
					if(var_07 != var_05)
					{
						var_05 = var_07;
						var_06 vision_set_fog_progress(param_00,var_07);
					}

					wait(0.05);
				}

				if(var_07 < 0.5)
				{
					var_06 maps\_utility::vision_set_fog_changes(param_00.script_visionset_start,param_00.script_delay);
				}
				else
				{
					var_06 maps\_utility::vision_set_fog_changes(param_00.script_visionset_end,param_00.script_delay);
				}

				continue;
			}

			var_06 maps\_utility::vision_set_fog_changes(param_00.script_visionset,param_00.script_delay);
		}
	}
}

//Function Number: 64
init_visionset_progress_trigger()
{
	if(!isdefined(self.script_delay))
	{
		self.script_delay = 2;
	}

	var_00 = maps\_utility::get_vision_set_fog(self.script_visionset_start);
	var_01 = maps\_utility::get_vision_set_fog(self.script_visionset_end);
	if(!isdefined(var_00) || !isdefined(var_01))
	{
		return;
	}

	var_02 = spawnstruct();
	var_02.startdist = var_01.startdist - var_00.startdist;
	var_02.halfwaydist = var_01.halfwaydist - var_00.halfwaydist;
	var_02.red = var_01.red - var_00.red;
	var_02.blue = var_01.blue - var_00.blue;
	var_02.green = var_01.green - var_00.green;
	var_02.hdrcolorintensity = var_01.hdrcolorintensity - var_00.hdrcolorintensity;
	var_02.maxopacity = var_01.maxopacity - var_00.maxopacity;
	var_02.sunfogenabled = isdefined(var_00.sunfogenabled) || isdefined(var_01.sunfogenabled);
	var_02.hdrsuncolorintensity = var_01.hdrsuncolorintensity - var_00.hdrsuncolorintensity;
	var_02.skyfogintensity = var_01.skyfogintensity - var_00.skyfogintensity;
	var_02.skyfogminangle = var_01.skyfogminangle - var_00.skyfogminangle;
	var_02.skyfogmaxangle = var_01.skyfogmaxangle - var_00.skyfogmaxangle;
	var_03 = 0;
	if(isdefined(var_00.sunred))
	{
		var_03 = var_00.sunred;
	}

	var_04 = 0;
	if(isdefined(var_01.sunred))
	{
		var_04 = var_01.sunred;
	}

	var_02.sunred_start = var_03;
	var_02.sunred = var_04 - var_03;
	var_05 = 0;
	if(isdefined(var_00.sungreen))
	{
		var_05 = var_00.sungreen;
	}

	var_06 = 0;
	if(isdefined(var_01.sungreen))
	{
		var_06 = var_01.sungreen;
	}

	var_02.sungreen_start = var_05;
	var_02.sungreen = var_06 - var_05;
	var_07 = 0;
	if(isdefined(var_00.sunblue))
	{
		var_07 = var_00.sunblue;
	}

	var_08 = 0;
	if(isdefined(var_01.sunblue))
	{
		var_08 = var_01.sunblue;
	}

	var_02.sunblue_start = var_07;
	var_02.sunblue = var_08 - var_07;
	var_09 = (0,0,0);
	if(isdefined(var_00.sundir))
	{
		var_09 = var_00.sundir;
	}

	var_0A = (0,0,0);
	if(isdefined(var_01.sundir))
	{
		var_0A = var_01.sundir;
	}

	var_02.sundir_start = var_09;
	var_02.sundir = var_0A - var_09;
	var_0B = 0;
	if(isdefined(var_00.sunbeginfadeangle))
	{
		var_0B = var_00.sunbeginfadeangle;
	}

	var_0C = 0;
	if(isdefined(var_01.sunbeginfadeangle))
	{
		var_0C = var_01.sunbeginfadeangle;
	}

	var_02.sunbeginfadeangle_start = var_0B;
	var_02.sunbeginfadeangle = var_0C - var_0B;
	var_0D = 0;
	if(isdefined(var_00.sunendfadeangle))
	{
		var_0D = var_00.sunendfadeangle;
	}

	var_0E = 0;
	if(isdefined(var_01.sunendfadeangle))
	{
		var_0E = var_01.sunendfadeangle;
	}

	var_02.sunendfadeangle_start = var_0D;
	var_02.sunendfadeangle = var_0E - var_0D;
	var_0F = 0;
	if(isdefined(var_00.normalfogscale))
	{
		var_0F = var_00.normalfogscale;
	}

	var_10 = 0;
	if(isdefined(var_01.normalfogscale))
	{
		var_10 = var_01.normalfogscale;
	}

	var_02.normalfogscale_start = var_0F;
	var_02.normalfogscale = var_10 - var_0F;
	self.visionset_diff = var_02;
}

//Function Number: 65
vision_set_fog_progress(param_00,param_01)
{
	maps\_utility::init_self_visionset();
	if(param_01 < 0.5)
	{
		self.vision_set_transition_ent.vision_set = param_00.script_visionset_start;
	}
	else
	{
		self.vision_set_transition_ent.vision_set = param_00.script_visionset_end;
	}

	self.vision_set_transition_ent.time = 0;
	if(param_00.script_visionset_start == param_00.script_visionset_end)
	{
		return;
	}

	self visionsetnakedforplayer_lerp(param_00.script_visionset_start,param_00.script_visionset_end,param_01);
	var_02 = maps\_utility::get_vision_set_fog(param_00.script_visionset_start);
	var_03 = maps\_utility::get_vision_set_fog(param_00.script_visionset_end);
	var_04 = param_00.visionset_diff;
	var_05 = spawnstruct();
	var_05.startdist = var_02.startdist + var_04.startdist * param_01;
	var_05.halfwaydist = var_02.halfwaydist + var_04.halfwaydist * param_01;
	var_05.halfwaydist = max(1,var_05.halfwaydist);
	var_05.red = var_02.red + var_04.red * param_01;
	var_05.green = var_02.green + var_04.green * param_01;
	var_05.blue = var_02.blue + var_04.blue * param_01;
	var_05.hdrcolorintensity = var_02.hdrcolorintensity + var_04.hdrcolorintensity * param_01;
	var_05.maxopacity = var_02.maxopacity + var_04.maxopacity * param_01;
	var_05.skyfogintensity = var_02.skyfogintensity + var_04.skyfogintensity * param_01;
	var_05.skyfogminangle = var_02.skyfogminangle + var_04.skyfogminangle * param_01;
	var_05.skyfogmaxangle = var_02.skyfogmaxangle + var_04.skyfogmaxangle * param_01;
	if(var_04.sunfogenabled)
	{
		var_05.sunfogenabled = 1;
		var_05.sunred = var_04.sunred_start + var_04.sunred * param_01;
		var_05.sungreen = var_04.sungreen_start + var_04.sungreen * param_01;
		var_05.sunblue = var_04.sunblue_start + var_04.sunblue * param_01;
		var_05.hdrsuncolorintensity = var_02.hdrsuncolorintensity + var_04.hdrsuncolorintensity * param_01;
		var_05.sundir = var_04.sundir_start + var_04.sundir * param_01;
		var_05.sunbeginfadeangle = var_04.sunbeginfadeangle_start + var_04.sunbeginfadeangle * param_01;
		var_05.sunendfadeangle = var_04.sunendfadeangle_start + var_04.sunendfadeangle * param_01;
		var_05.normalfogscale = var_04.normalfogscale_start + var_04.normalfogscale * param_01;
	}

	common_scripts\utility::set_fog_to_ent_values(var_05,0.05);
}

//Function Number: 66
trigger_fog(param_00)
{
	waittillframeend;
	var_01 = param_00.script_fogset_start;
	var_02 = param_00.script_fogset_end;
	param_00.sunfog_enabled = 0;
	if(isdefined(var_01) && isdefined(var_02))
	{
		var_03 = maps\_utility::get_fog(var_01);
		var_04 = maps\_utility::get_fog(var_02);
		param_00.sunfog_enabled = isdefined(var_03.sunred) || isdefined(var_04.sunred);
		param_00.start_neardist = var_03.startdist;
		param_00.start_fardist = var_03.halfwaydist;
		param_00.start_color = (var_03.red,var_03.green,var_03.blue);
		param_00.start_hdrcolorintensity = var_03.hdrcolorintensity;
		param_00.start_opacity = var_03.maxopacity;
		param_00.start_skyfogintensity = var_03.skyfogintensity;
		param_00.start_skyfogminangle = var_03.skyfogminangle;
		param_00.start_skyfogmaxangle = var_03.skyfogmaxangle;
		if(isdefined(var_03.sunred))
		{
			param_00.start_suncolor = (var_03.sunred,var_03.sungreen,var_03.sunblue);
			param_00.start_hdrsuncolorintensity = var_03.hdrsuncolorintensity;
			param_00.start_sundir = var_03.sundir;
			param_00.start_sunbeginfadeangle = var_03.sunbeginfadeangle;
			param_00.start_sunendfadeangle = var_03.sunendfadeangle;
			param_00.start_sunfogscale = var_03.normalfogscale;
		}
		else if(param_00.sunfog_enabled)
		{
			param_00.start_suncolor = param_00.start_color;
			param_00.start_hdrsuncolorintensity = 1;
			param_00.start_sundir = (0,0,0);
			param_00.start_sunbeginfadeangle = 0;
			param_00.start_sunendfadeangle = 90;
			param_00.start_sunfogscale = 1;
		}

		param_00.end_neardist = var_04.startdist;
		param_00.end_fardist = var_04.halfwaydist;
		param_00.end_color = (var_04.red,var_04.green,var_04.blue);
		param_00.end_hdrcolorintensity = var_04.hdrcolorintensity;
		param_00.end_opacity = var_04.maxopacity;
		param_00.end_skyfogintensity = var_04.skyfogintensity;
		param_00.end_skyfogminangle = var_04.skyfogminangle;
		param_00.end_skyfogmaxangle = var_04.skyfogmaxangle;
		if(isdefined(var_04.sunred))
		{
			param_00.end_suncolor = (var_04.sunred,var_04.sungreen,var_04.sunblue);
			param_00.end_hdrsuncolorintensity = var_04.hdrsuncolorintensity;
			param_00.end_sundir = var_04.sundir;
			param_00.end_sunbeginfadeangle = var_04.sunbeginfadeangle;
			param_00.end_sunendfadeangle = var_04.sunendfadeangle;
			param_00.end_sunfogscale = var_04.normalfogscale;
		}
		else if(param_00.sunfog_enabled)
		{
			param_00.end_suncolor = param_00.end_color;
			param_00.end_hdrsuncolorintensity = 1;
			param_00.end_sundir = (0,0,0);
			param_00.end_sunbeginfadeangle = 0;
			param_00.end_sunendfadeangle = 90;
			param_00.end_sunfogscale = 1;
		}
	}

	var_05 = getent(param_00.target,"targetname");
	var_06 = var_05.origin;
	var_07 = undefined;
	if(isdefined(var_05.target))
	{
		var_08 = getent(var_05.target,"targetname");
		var_07 = var_08.origin;
	}
	else
	{
		var_07 = var_06 + param_00.origin - var_06 * 2;
	}

	var_09 = distance(var_06,var_07);
	for(;;)
	{
		param_00 waittill("trigger",var_0A);
		var_0B = 0;
		while(var_0A istouching(param_00))
		{
			var_0B = maps\_utility::get_progress(var_06,var_07,var_0A.origin,var_09);
			var_0B = clamp(var_0B,0,1);
			param_00 maps\_art::set_fog_progress(var_0B);
			wait(0.05);
		}

		if(var_0B > 0.5)
		{
			var_0B = 1;
		}
		else
		{
			var_0B = 0;
		}

		param_00 maps\_art::set_fog_progress(var_0B);
	}
}

//Function Number: 67
trigger_multiple_depthoffield(param_00)
{
	waittillframeend;
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		var_02 = param_00.script_dof_near_start;
		var_03 = param_00.script_dof_near_end;
		var_04 = param_00.script_dof_near_blur;
		var_05 = param_00.script_dof_far_start;
		var_06 = param_00.script_dof_far_end;
		var_07 = param_00.script_dof_far_blur;
		var_08 = param_00.script_delay;
		if(var_02 != level.dof["base"]["goal"]["nearStart"] || var_03 != level.dof["base"]["goal"]["nearEnd"] || var_04 != level.dof["base"]["goal"]["nearBlur"] || var_05 != level.dof["base"]["goal"]["farStart"] || var_06 != level.dof["base"]["goal"]["farEnd"] || var_07 != level.dof["base"]["goal"]["farBlur"])
		{
			maps\_art::dof_set_base(var_02,var_03,var_04,var_05,var_06,var_07,var_08);
			wait(var_08);
			continue;
		}

		wait 0.05;
	}
}

//Function Number: 68
trigger_multiple_tessellationcutoff(param_00)
{
	if(level.xenon || level.ps3)
	{
		return;
	}

	waittillframeend;
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		var_02 = param_00.script_tess_distance;
		var_03 = param_00.script_tess_falloff;
		var_04 = param_00.script_delay;
		if(var_02 != level.tess.cutoff_distance_goal || var_03 != level.tess.cutoff_falloff_goal)
		{
			var_02 = max(0,var_02);
			var_02 = min(10000,var_02);
			var_03 = max(0,var_03);
			var_03 = min(10000,var_03);
			maps\_art::tess_set_goal(var_02,var_03,var_04);
			continue;
		}

		wait 0.05;
	}
}

//Function Number: 69
trigger_slide(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		var_01 thread slidetriggerplayerthink(param_00);
	}
}

//Function Number: 70
slidetriggerplayerthink(param_00)
{
	if(isdefined(self.vehicle))
	{
		return;
	}

	if(maps\_utility::issliding())
	{
		return;
	}

	if(isdefined(self.player_view))
	{
		return;
	}

	self endon("death");
	if(soundexists("SCN_cliffhanger_player_hillslide"))
	{
		self playsound("SCN_cliffhanger_player_hillslide");
	}

	var_01 = undefined;
	if(isdefined(param_00.script_accel))
	{
		var_01 = param_00.script_accel;
	}

	self endon("cancel_sliding");
	maps\_utility::beginsliding(undefined,var_01);
	for(;;)
	{
		if(!self istouching(param_00))
		{
			break;
		}

		wait(0.05);
	}

	if(isdefined(level.end_slide_delay))
	{
		wait(level.end_slide_delay);
	}

	maps\_utility::endsliding();
}

//Function Number: 71
trigger_stats(param_00)
{
	param_00 waittill("trigger",var_01);
}

//Function Number: 72
trigger_multiple_fx_volume(param_00)
{
	var_01 = spawn("script_origin",(0,0,0));
	param_00.fx = [];
	foreach(var_03 in level.createfxent)
	{
		assign_fx_to_trigger(var_03,param_00,var_01);
	}

	var_01 delete();
	if(!isdefined(param_00.target))
	{
		return;
	}

	var_05 = getentarray(param_00.target,"targetname");
	param_00.fx_on = 1;
	var_06 = var_05;
	var_08 = getfirstarraykey(var_06);
	if(isdefined(var_08))
	{
		var_07 = var_06[var_08];
		switch(var_07.classname)
		{
			case "trigger_multiple_fx_volume_on":
				break;

			case "trigger_multiple_fx_volume_off":
				break;

			default:
				break;
		}
	}
}

//Function Number: 73
trigger_multiple_fx_trigger_on_think(param_00)
{
	for(;;)
	{
		self waittill("trigger");
		if(!param_00.fx_on)
		{
			common_scripts\utility::array_thread(param_00.fx,::maps\_utility::restarteffect);
		}

		wait(1);
	}
}

//Function Number: 74
trigger_multiple_fx_trigger_off_think(param_00)
{
	for(;;)
	{
		self waittill("trigger");
		if(param_00.fx_on)
		{
			common_scripts\utility::array_thread(param_00.fx,::common_scripts\utility::pauseeffect);
		}

		wait(1);
	}
}

//Function Number: 75
assign_fx_to_trigger(param_00,param_01,param_02)
{
	if(isdefined(param_00.v["soundalias"]) && param_00.v["soundalias"] != "nil")
	{
		if(!isdefined(param_00.v["stopable"]) || !param_00.v["stopable"])
		{
			return;
		}
	}

	param_02.origin = param_00.v["origin"];
	if(param_02 istouching(param_01))
	{
		param_01.fx[param_01.fx.size] = param_00;
	}
}

//Function Number: 76
trigger_multiple_compass(param_00)
{
	var_01 = param_00.script_parameters;
	if(!isdefined(level.minimap_image))
	{
		level.minimap_image = "";
	}

	for(;;)
	{
		param_00 waittill("trigger");
		if(level.minimap_image != var_01)
		{
			maps\_compass::setupminimap(var_01);
		}
	}
}

//Function Number: 77
trigger_no_crouch_or_prone(param_00)
{
	common_scripts\utility::array_thread(level.players,::no_crouch_or_prone_think_for_player,param_00);
}

//Function Number: 78
no_crouch_or_prone_think_for_player(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isdefined(var_01))
		{
			continue;
		}

		if(var_01 != self)
		{
			continue;
		}

		while(var_01 istouching(param_00))
		{
			var_01 allowprone(0);
			var_01 allowcrouch(0);
			wait(0.05);
		}

		var_01 allowprone(1);
		var_01 allowcrouch(1);
	}
}

//Function Number: 79
trigger_no_prone(param_00)
{
	common_scripts\utility::array_thread(level.players,::no_prone_for_player,param_00);
}

//Function Number: 80
no_prone_for_player(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isdefined(var_01))
		{
			continue;
		}

		if(var_01 != self)
		{
			continue;
		}

		while(var_01 istouching(param_00))
		{
			var_01 allowprone(0);
			wait(0.05);
		}

		var_01 allowprone(1);
	}
}

//Function Number: 81
trigger_wakevolume_think(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isdefined(var_01))
		{
			continue;
		}

		if(var_01 maps\_utility::ent_flag_exist("in_wake_volume"))
		{
		}
		else
		{
			var_01 maps\_utility::ent_flag_init("in_wake_volume");
		}

		if(distancesquared(var_01.origin,level.player.origin) < 9250000)
		{
			if(var_01 maps\_utility::ent_flag("in_wake_volume"))
			{
				continue;
			}

			var_01 thread volume_wakefx(param_00);
			var_01 maps\_utility::ent_flag_set("in_wake_volume");
		}
	}
}

//Function Number: 82
volume_wakefx(param_00)
{
	self endon("death");
	var_01 = 200;
	for(;;)
	{
		if(self istouching(param_00))
		{
			if(var_01 > 0)
			{
				wait(max(1 - var_01 / 120,0.1));
			}
			else
			{
				wait(0.15);
			}

			var_02 = param_00.script_fxid;
			var_03 = (0,0,0);
			if(isplayer(self))
			{
				var_03 = self getvelocity();
			}

			if(isai(self))
			{
				var_03 = self.velocity;
			}

			var_01 = distance(var_03,(0,0,0));
			if(var_01 < 5)
			{
				var_02 = "null";
			}

			if(var_02 != "null")
			{
				var_04 = vectornormalize((var_03[0],var_03[1],0));
				var_05 = anglestoforward(vectortoangles(var_04) + (270,180,0));
				var_06 = self.origin + (0,0,64);
				var_07 = self.origin - (0,0,150);
				var_08 = bullettrace(var_06,var_07,0,undefined);
				if(isdefined(param_00.script_surfacetype))
				{
					if(var_08["surfacetype"] != param_00.script_surfacetype)
					{
						continue;
					}
				}

				var_09 = common_scripts\utility::getfx(var_02);
				var_06 = var_08["position"] + var_01 / 4 * var_04;
				if(isdefined(param_00.script_usenormals) && param_00.script_usenormals == 1)
				{
					var_0A = vectornormalize(vectorcross(var_08["normal"],vectorcross(var_04,var_08["normal"])));
					if(var_08["normal"] != (0,0,0) && var_0A != (0,0,0))
					{
						playfx(var_09,var_06,var_08["normal"],var_0A);
					}
				}
				else
				{
					playfx(var_09,var_06,var_05);
				}
			}

			continue;
		}

		maps\_utility::ent_flag_clear("in_wake_volume");
	}
}

//Function Number: 83
trigger_fallingwatervolume_think(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isdefined(var_01))
		{
			continue;
		}

		if(var_01 maps\_utility::ent_flag_exist("in_fallingwater_volume"))
		{
		}
		else
		{
			var_01 maps\_utility::ent_flag_init("in_fallingwater_volume");
		}

		if(distancesquared(var_01.origin,level.player.origin) < 6250000)
		{
			if(var_01 maps\_utility::ent_flag("in_fallingwater_volume"))
			{
				continue;
			}

			var_01 thread volume_fallingwaterfx(param_00);
			var_01 maps\_utility::ent_flag_set("in_fallingwater_volume");
		}
	}
}

//Function Number: 84
volume_fallingwaterfx(param_00)
{
	self endon("death");
	var_01 = param_00 getpointinbounds(1,1,0);
	var_02 = param_00 getpointinbounds(-1,-1,0);
	var_03 = var_01[0] - var_02[0] * var_01[1] - var_02[1];
	var_04 = 3;
	if(isdefined(param_00.script_duration))
	{
		var_04 = param_00.script_duration;
	}

	var_05 = 1;
	if(isdefined(param_00.script_flowrate))
	{
		var_05 = param_00.script_flowrate;
	}

	var_06 = int(var_05 * var_03 / 50);
	var_07 = "null";
	if(isdefined(param_00.script_fxid))
	{
		var_07 = param_00.script_fxid;
	}

	var_08 = "null";
	if(isdefined(param_00.script_screen_fxid))
	{
		var_08 = param_00.script_screen_fxid;
	}

	var_09 = -1;
	for(;;)
	{
		if(self istouching(param_00))
		{
			if(isai(self))
			{
				wait(0.05);
				for(var_0A = 0;var_0A < var_06;var_0A++)
				{
					if(var_07 != "null")
					{
						var_0B = param_00 getpointinbounds(randomfloat(2) - 1,randomfloat(2) - 1,1);
						var_0C = (var_0B[0],var_0B[1],self.origin[2]);
						if(distance2dsquared(var_0C,self.origin) < 900)
						{
							var_0D = bullettrace(var_0B,var_0C,1,undefined,0,1);
							if(isdefined(var_0D["entity"]) && var_0D["entity"] == self)
							{
								var_0E = common_scripts\utility::getfx(var_07);
								var_0B = var_0D["position"];
								var_0F = vectortoangles(var_0D["normal"] + (90,0,0));
								var_10 = anglestoforward(var_0F);
								var_11 = anglestoup(var_0F);
								playfx(var_0E,var_0B,var_11,var_10);
							}
						}
					}
				}
			}

			if(isplayer(self))
			{
				wait(0.05);
				var_09 = var_09 + 0.05;
				if(var_09 > var_04 * 0.2 || var_09 < 0)
				{
					self setwatersheeting(1,var_04);
					var_09 = 0;
				}

				if(!isdefined(level.effectonplayerviewent))
				{
					if(var_08 != "null")
					{
						spawneffectonplayerview(var_08,(500,0,0),(180,0,0));
					}
				}
			}

			continue;
		}

		maps\_utility::ent_flag_clear("in_fallingwater_volume");
		if(var_08 != "null")
		{
			stopeffectonplayerview(var_08);
		}
	}
}

//Function Number: 85
spawneffectonplayerview(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = (0,0,0);
	}

	if(!isdefined(param_02))
	{
		param_02 = (0,0,0);
	}

	var_03 = common_scripts\utility::getfx(param_00);
	level.effectonplayerviewent = common_scripts\utility::spawn_tag_origin();
	level.effectonplayerviewent linktoplayerview(level.player,"tag_origin",param_01,param_02,1);
	level.effectonplayerview = playfxontag(var_03,level.effectonplayerviewent,"tag_origin");
}

//Function Number: 86
stopeffectonplayerview(param_00,param_01)
{
	if(isdefined(level.effectonplayerviewent))
	{
		if(isdefined(level.effectonplayerview))
		{
			if(param_01)
			{
				killfxontag(common_scripts\utility::getfx(param_00),level.effectonplayerviewent,"tag_origin");
			}
			else
			{
				stopfxontag(common_scripts\utility::getfx(param_00),level.effectonplayerviewent,"tag_origin");
			}
		}

		level.effectonplayerviewent delete();
	}
}