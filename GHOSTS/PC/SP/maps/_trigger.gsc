/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_trigger.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 77
 * Decompile Time: 1423 ms
 * Timestamp: 10/27/2023 1:25:20 AM
*******************************************************************/

//Function Number: 1
get_load_trigger_classes()
{
	var_00 = [];
	var_00["trigger_multiple_nobloodpool"] = ::func_8378;
	var_00["trigger_multiple_flag_set"] = ::func_8344;
	var_00["trigger_multiple_flag_clear"] = ::func_8342;
	var_00["trigger_multiple_sun_off"] = ::func_839F;
	var_00["trigger_multiple_sun_on"] = ::func_83A0;
	var_00["trigger_use_flag_set"] = ::func_8344;
	var_00["trigger_use_flag_clear"] = ::func_8342;
	var_00["trigger_multiple_flag_set_touching"] = ::func_8349;
	var_00["trigger_multiple_flag_lookat"] = ::func_8363;
	var_00["trigger_multiple_flag_looking"] = ::func_8365;
	var_00["trigger_multiple_no_prone"] = ::func_8377;
	var_00["trigger_multiple_no_crouch_or_prone"] = ::func_8376;
	var_00["trigger_multiple_compass"] = ::func_836C;
	var_00["trigger_multiple_specialops_flag_set"] = ::trigger_flag_set_specialops;
	var_00["trigger_multiple_fx_volume"] = ::func_8370;
	var_00["trigger_multiple_light_sunshadow"] = ::maps\_lights::func_7D3D;
	if(!maps\_utility::func_4813())
	{
		var_00["trigger_multiple_autosave"] = ::maps\_autosave::func_832C;
		var_00["trigger_multiple_spawn"] = ::maps\_spawner::func_839A;
		var_00["trigger_multiple_spawn_reinforcement"] = ::maps\_spawner::func_839B;
	}

	var_00["trigger_multiple_slide"] = ::func_8397;
	var_00["trigger_multiple_fog"] = ::func_834B;
	var_00["trigger_multiple_depthoffield"] = ::trigger_multiple_depthoffield;
	var_00["trigger_multiple_tessellationcutoff"] = ::trigger_multiple_tessellationcutoff;
	var_00["trigger_damage_player_flag_set"] = ::func_8335;
	var_00["trigger_multiple_visionset"] = ::func_8374;
	var_00["trigger_multiple_sunflare"] = ::trigger_multiple_sunflare;
	var_00["trigger_multiple_glass_break"] = ::trigger_glass_break;
	var_00["trigger_radius_glass_break"] = ::trigger_glass_break;
	var_00["trigger_multiple_friendly_respawn"] = ::func_834C;
	var_00["trigger_multiple_friendly_stop_respawn"] = ::func_834D;
	var_00["trigger_multiple_physics"] = ::func_8381;
	var_00["trigger_multiple_fx_watersheeting"] = ::func_8372;
	var_00["trigger_multiple_audio"] = ::maps\_audio::func_836B;
	return var_00;
}

//Function Number: 2
func_8372(param_00)
{
	var_01 = 3;
	if(isdefined(param_00.var_6B9E))
	{
		var_01 = param_00.var_6B9E;
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
	var_00["friendly_wave"] = ::maps\_spawner::func_3569;
	var_00["friendly_wave_off"] = ::maps\_spawner::func_3569;
	var_00["friendly_mgTurret"] = ::maps\_spawner::friendly_mgturret;
	if(!maps\_utility::func_4813())
	{
		var_00["camper_spawner"] = ::maps\_spawner::camper_trigger_think;
		var_00["flood_spawner"] = ::maps\_spawner::func_3466;
		var_00["trigger_spawner"] = ::maps\_spawner::func_839A;
		var_00["trigger_autosave"] = ::maps\_autosave::func_832C;
		var_00["trigger_spawngroup"] = ::trigger_spawngroup;
		var_00["two_stage_spawner"] = ::maps\_spawner::func_854E;
		var_00["trigger_vehicle_spline_spawn"] = ::func_83AA;
		var_00["trigger_vehicle_spawn"] = ::func_83A9;
		var_00["trigger_vehicle_getin_spawn"] = ::func_83A8;
		var_00["random_spawn"] = ::maps\_spawner::func_6326;
	}

	var_00["autosave_now"] = ::maps\_autosave::autosave_now_trigger;
	var_00["trigger_autosave_tactical"] = ::maps\_autosave::func_832F;
	var_00["trigger_autosave_stealth"] = ::maps\_autosave::func_832E;
	var_00["trigger_unlock"] = ::func_83A6;
	var_00["trigger_lookat"] = ::func_8363;
	var_00["trigger_looking"] = ::func_8365;
	var_00["trigger_cansee"] = ::func_8332;
	var_00["autosave_immediate"] = ::maps\_autosave::func_832D;
	var_00["flag_set"] = ::func_8344;
	if(maps\_utility::func_47D0())
	{
		var_00["flag_set_coop"] = ::func_8345;
	}

	var_00["flag_set_player"] = ::func_8346;
	var_00["flag_unset"] = ::func_8342;
	var_00["flag_clear"] = ::func_8342;
	var_00["objective_event"] = ::maps\_spawner::func_57CD;
	var_00["friendly_respawn_trigger"] = ::func_834C;
	var_00["radio_trigger"] = ::func_838B;
	var_00["trigger_ignore"] = ::func_835A;
	var_00["trigger_pacifist"] = ::func_837F;
	var_00["trigger_delete"] = ::trigger_turns_off;
	var_00["trigger_delete_on_touch"] = ::func_8338;
	var_00["trigger_off"] = ::trigger_turns_off;
	var_00["trigger_outdoor"] = ::maps\_spawner::func_5A2A;
	var_00["trigger_indoor"] = ::maps\_spawner::indoor_think;
	var_00["trigger_hint"] = ::func_8356;
	var_00["trigger_grenade_at_player"] = ::func_83A4;
	var_00["flag_on_cleared"] = ::func_8343;
	var_00["flag_set_touching"] = ::func_8349;
	var_00["delete_link_chain"] = ::func_8337;
	var_00["trigger_fog"] = ::func_834B;
	var_00["trigger_slide"] = ::func_8397;
	var_00["trigger_dooropen"] = ::func_833D;
	var_00["no_crouch_or_prone"] = ::func_8376;
	var_00["no_prone"] = ::func_8377;
	return var_00;
}

//Function Number: 4
func_459F()
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
	var_04 = maps\_utility::func_EF4(var_06,var_07);
	var_08 = getentarray("trigger_disk","classname");
	var_04 = maps\_utility::func_EF4(var_04,var_08);
	var_09 = getentarray("trigger_once","classname");
	var_04 = maps\_utility::func_EF4(var_04,var_09);
	if(!maps\_utility::func_4813())
	{
		for(var_0A = 0;var_0A < var_04.size;var_0A++)
		{
			if(var_04[var_0A].spawnflags & 32)
			{
				thread maps\_spawner::func_839A(var_04[var_0A]);
			}
		}
	}

	for(var_0B = 0;var_0B < 7;var_0B++)
	{
		switch(var_0B)
		{
			case 0:
				var_0C = "trigger_multiple";
				break;

			case 1:
				var_0C = "trigger_once";
				break;

			case 2:
				var_0C = "trigger_use";
				break;

			case 3:
				var_0C = "trigger_radius";
				break;

			case 4:
				var_0C = "trigger_lookat";
				break;

			case 5:
				var_0C = "trigger_disk";
				break;

			default:
				var_0C = "trigger_damage";
				break;
		}

		var_04 = getentarray(var_0C,"code_classname");
		for(var_0A = 0;var_0A < var_04.size;var_0A++)
		{
			if(isdefined(var_04[var_0A].script_flag_true))
			{
				level thread func_8395(var_04[var_0A]);
			}

			if(isdefined(var_04[var_0A].script_flag_false))
			{
				level thread func_8394(var_04[var_0A]);
			}

			if(isdefined(var_04[var_0A].var_6B47) || isdefined(var_04[var_0A].var_6B46))
			{
				level thread maps\_autosave::func_11D3(var_04[var_0A]);
			}

			if(isdefined(var_04[var_0A].var_6BB0))
			{
				level thread maps\_spawner::func_31C9(var_04[var_0A]);
			}

			if(isdefined(var_04[var_0A].var_6C22))
			{
				level thread maps\_mgturret::mgturret_auto(var_04[var_0A]);
			}

			if(isdefined(var_04[var_0A].var_6C08))
			{
				level thread maps\_spawner::func_4AFC(var_04[var_0A]);
			}

			if(isdefined(var_04[var_0A].var_6C07))
			{
				level thread maps\_vehicle_code::func_4B07(var_04[var_0A]);
			}

			if(isdefined(var_04[var_0A].var_6BA0))
			{
				level thread maps\_spawner::empty_spawner(var_04[var_0A]);
			}

			if(isdefined(var_04[var_0A].script_prefab_exploder))
			{
				var_04[var_0A].script_exploder = var_04[var_0A].script_prefab_exploder;
			}

			if(isdefined(var_04[var_0A].script_exploder))
			{
				level thread maps\_load::func_30BC(var_04[var_0A]);
			}

			if(isdefined(var_04[var_0A].ambient))
			{
				level thread maps\_audio::func_836B(var_04[var_0A]);
			}

			if(isdefined(var_04[var_0A].script_triggered_playerseek))
			{
				level thread func_8385(var_04[var_0A]);
			}

			if(isdefined(var_04[var_0A].var_6B52))
			{
				level thread trigger_battlechatter(var_04[var_0A]);
			}

			if(isdefined(var_04[var_0A].var_6CDC))
			{
				var_04[var_0A] thread trigger_group();
			}

			if(isdefined(var_04[var_0A].var_6C88))
			{
				level thread maps\_spawner::func_6315(var_04[var_0A]);
			}

			if(isdefined(var_04[var_0A].targetname))
			{
				var_0D = var_04[var_0A].targetname;
				if(isdefined(var_01[var_0D]))
				{
					level thread [[ var_01[var_0D] ]](var_04[var_0A]);
				}
			}
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
func_8335(param_00)
{
	var_01 = param_00 maps\_utility::func_39D6();
	if(!isdefined(level.flag[var_01]))
	{
		common_scripts\utility::func_3385(var_01);
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
func_8342(param_00)
{
	var_01 = param_00 maps\_utility::func_39D6();
	if(!isdefined(level.flag[var_01]))
	{
		common_scripts\utility::func_3385(var_01);
	}

	for(;;)
	{
		param_00 waittill("trigger");
		param_00 maps\_utility::script_delay();
		common_scripts\utility::func_337C(var_01);
	}
}

//Function Number: 9
func_8343(param_00)
{
	var_01 = param_00 maps\_utility::func_39D6();
	if(!isdefined(level.flag[var_01]))
	{
		common_scripts\utility::func_3385(var_01);
	}

	for(;;)
	{
		param_00 waittill("trigger");
		wait(1);
		if(param_00 func_34F8())
		{
			continue;
		}

		break;
	}

	common_scripts\utility::flag_set(var_01);
}

//Function Number: 10
func_34F8()
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
func_8344(param_00)
{
	var_01 = param_00 maps\_utility::func_39D6();
	if(!isdefined(level.flag[var_01]))
	{
		common_scripts\utility::func_3385(var_01);
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		param_00 maps\_utility::script_delay();
		common_scripts\utility::flag_set(var_01,var_02);
	}
}

//Function Number: 12
func_8345(param_00)
{
	var_01 = param_00 maps\_utility::func_39D6();
	if(!isdefined(level.flag[var_01]))
	{
		common_scripts\utility::func_3385(var_01);
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
		var_02 = maps\_utility::func_EF4(var_02,var_04);
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
	var_01 = param_00 maps\_utility::func_39D6();
	if(!isdefined(level.flag[var_01]))
	{
		common_scripts\utility::func_3385(var_01);
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
func_834C(param_00)
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
		var_01 = common_scripts\utility::func_3C18(param_00.target,"targetname");
		var_02 = var_01.origin;
	}

	for(;;)
	{
		param_00 waittill("trigger");
		level.respawn_spawner_org = var_02;
		common_scripts\utility::flag_set("respawn_friendlies");
		wait(0.5);
	}
}

//Function Number: 16
func_8349(param_00)
{
	var_01 = param_00 maps\_utility::func_39D6();
	if(!isdefined(level.flag[var_01]))
	{
		common_scripts\utility::func_3385(var_01);
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

		common_scripts\utility::func_337C(var_01);
	}
}

//Function Number: 17
func_834D(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger");
		common_scripts\utility::func_337C("respawn_friendlies");
	}
}

//Function Number: 18
trigger_group()
{
	thread func_8353();
	level endon("trigger_group_" + self.var_6CDC);
	self waittill("trigger");
	level notify("trigger_group_" + self.var_6CDC,self);
}

//Function Number: 19
func_8353()
{
	level waittill("trigger_group_" + self.var_6CDC,var_00);
	if(self != var_00)
	{
		self delete();
	}
}

//Function Number: 20
func_8378(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(!isalive(var_01))
		{
			continue;
		}

		var_01.var_757E = 1;
		var_01 thread func_6FC5();
	}
}

//Function Number: 21
func_6FC5()
{
	self notify("notify_wait_then_clear_skipBloodPool");
	self endon("notify_wait_then_clear_skipBloodPool");
	self endon("death");
	wait(2);
	self.var_757E = undefined;
}

//Function Number: 22
func_8381(param_00)
{
	var_01 = [];
	var_02 = common_scripts\utility::func_3C1A(param_00.target,"targetname");
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

	param_00.var_59DA = var_02[0].origin;
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

//Function Number: 23
func_8385(param_00)
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

//Function Number: 24
func_8394(param_00)
{
	var_01 = common_scripts\utility::func_2079(param_00.script_flag_false);
	param_00 add_tokens_to_trigger_flags(var_01);
	param_00 common_scripts\utility::func_86B9();
}

//Function Number: 25
func_8395(param_00)
{
	var_01 = common_scripts\utility::func_2079(param_00.script_flag_true);
	param_00 add_tokens_to_trigger_flags(var_01);
	param_00 common_scripts\utility::func_86B9();
}

//Function Number: 26
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

//Function Number: 27
trigger_spawngroup(param_00)
{
	waittillframeend;
	var_01 = param_00.var_6CB0;
	if(!isdefined(level.var_77D2[var_01]))
	{
	}

	param_00 waittill("trigger");
	var_02 = common_scripts\utility::func_6306(level.var_77D2[var_01]);
	foreach(var_04 in var_02)
	{
		var_04 maps\_utility::func_7766();
	}
}

//Function Number: 28
func_839F(param_00)
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

//Function Number: 29
func_83A0(param_00)
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

//Function Number: 30
func_83A8(param_00)
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
	common_scripts\utility::func_F1B(var_01,::maps\_utility::add_spawn_function,::maps\_vehicle_code::func_892E);
	common_scripts\utility::func_F1B(var_01,::maps\_utility::func_784B);
}

//Function Number: 31
func_83AA(param_00)
{
	param_00 waittill("trigger");
	var_01 = getentarray(param_00.target,"targetname");
	foreach(var_03 in var_01)
	{
		var_03 thread maps\_vehicle_code::func_784C(70);
		wait(0.05);
	}
}

//Function Number: 32
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

		var_02 = common_scripts\utility::func_3C1A(self.target,"targetname");
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

//Function Number: 33
func_8363(param_00)
{
	func_8364(param_00,1);
}

//Function Number: 34
func_8365(param_00)
{
	func_8364(param_00,0);
}

//Function Number: 35
func_8364(param_00,param_01)
{
	var_02 = 0.78;
	if(isdefined(param_00.var_6B96))
	{
		var_02 = param_00.var_6B96;
	}

	var_03 = param_00 get_trigger_targs();
	var_04 = var_03["triggers"];
	var_05 = var_03["target_origin"];
	var_06 = isdefined(param_00.script_flag) || isdefined(param_00.script_noteworthy);
	var_07 = undefined;
	if(var_06)
	{
		var_07 = param_00 maps\_utility::func_39D6();
		if(!isdefined(level.flag[var_07]))
		{
			common_scripts\utility::func_3385(var_07);
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
			common_scripts\utility::func_337C(var_07);
		}

		param_00 waittill("trigger",var_09);
		var_0A = [];
		while(var_09 istouching(param_00))
		{
			if(var_08 && !sighttracepassed(var_09 geteye(),var_05,0,undefined))
			{
				if(var_06)
				{
					common_scripts\utility::func_337C(var_07);
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
				common_scripts\utility::func_F1B(var_04,::maps\_utility::func_6D98,"trigger");
				if(var_06)
				{
					common_scripts\utility::flag_set(var_07,var_09);
				}

				if(param_01)
				{
				}

				wait(2);
			}
			else if(var_06)
			{
				common_scripts\utility::func_337C(var_07);
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

//Function Number: 36
func_8332(param_00)
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
		var_05 = param_00 maps\_utility::func_39D6();
		if(!isdefined(level.flag[var_05]))
		{
			common_scripts\utility::func_3385(var_05);
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
			common_scripts\utility::func_337C(var_05);
		}

		param_00 waittill("trigger",var_08);
		while(level.player istouching(param_00))
		{
			if(!var_08 cantraceto(var_02,var_07))
			{
				if(var_04)
				{
					common_scripts\utility::func_337C(var_05);
				}

				wait(0.1);
				continue;
			}

			if(var_04)
			{
				common_scripts\utility::flag_set(var_05);
			}

			common_scripts\utility::func_F1B(var_01,::maps\_utility::func_6D98,"trigger");
			wait(0.5);
		}
	}
}

//Function Number: 37
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

//Function Number: 38
func_83A6(param_00)
{
	var_01 = "not_set";
	if(isdefined(param_00.script_noteworthy))
	{
		var_01 = param_00.script_noteworthy;
	}

	var_02 = getentarray(param_00.target,"targetname");
	param_00 thread func_83A7(param_00.target);
	for(;;)
	{
		common_scripts\utility::func_F1B(var_02,::common_scripts\utility::trigger_off);
		param_00 waittill("trigger");
		common_scripts\utility::func_F1B(var_02,::common_scripts\utility::func_837B);
		func_8A71(var_02,var_01);
		maps\_utility::array_notify(var_02,"relock");
	}
}

//Function Number: 39
func_83A7(param_00)
{
	self waittill("death");
	var_01 = getentarray(param_00,"targetname");
	common_scripts\utility::func_F1B(var_01,::common_scripts\utility::trigger_off);
}

//Function Number: 40
func_8A71(param_00,param_01)
{
	level endon("unlocked_trigger_hit" + param_01);
	var_02 = spawnstruct();
	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		param_00[var_03] thread func_65C6(var_02,param_01);
	}

	var_02 waittill("trigger");
	level notify("unlocked_trigger_hit" + param_01);
}

//Function Number: 41
func_65C6(param_00,param_01)
{
	self endon("relock");
	level endon("unlocked_trigger_hit" + param_01);
	self waittill("trigger");
	param_00 notify("trigger");
}

//Function Number: 42
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
			var_04 = level.player animscripts/battlechatter::getclosestfriendlyspeaker("custom");
		}
		else if(var_03.team == level.player.team)
		{
			var_05 = "axis";
			if(level.player.team == "axis")
			{
				var_05 = "allies";
			}

			var_06 = animscripts/battlechatter::getspeakers("custom",var_05);
			var_06 = common_scripts\utility::get_array_of_farthest(level.player.origin,var_06);
			foreach(var_08 in var_06)
			{
				if(var_08 istouching(param_00))
				{
					var_04 = var_08;
					if(func_130E(var_08.origin))
					{
						break;
					}
				}
			}
		}
	}
	else if(isplayer(var_03))
	{
		var_04 = var_03 animscripts/battlechatter::getclosestfriendlyspeaker("custom");
	}
	else
	{
		var_04 = var_03;
	}

	if(!isdefined(var_04))
	{
	}

	if(func_130E())
	{
	}

	var_0A = var_04 maps\_utility::func_2218(param_00.var_6B52);
	if(!var_0A)
	{
		level maps\_utility::func_252F(0.25,::trigger_battlechatter,param_00);
	}

	param_00 notify("custom_battlechatter_done");
}

//Function Number: 43
func_130E(param_00)
{
	return distancesquared(param_00,level.player getorigin()) <= 262144;
}

//Function Number: 44
func_83A9(param_00)
{
	param_00 waittill("trigger");
	var_01 = getentarray(param_00.target,"targetname");
	foreach(var_03 in var_01)
	{
		var_03 thread maps\_vehicle::func_784D();
		wait(0.05);
	}
}

//Function Number: 45
func_833D(param_00)
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

//Function Number: 46
trigger_glass_break(param_00)
{
	var_01 = getglassarray(param_00.target);
	if(!isdefined(var_01) || var_01.size == 0)
	{
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

//Function Number: 47
func_8337(param_00)
{
	param_00 waittill("trigger");
	var_01 = param_00 get_script_linkto_targets();
	common_scripts\utility::func_F1B(var_01,::delete_links_then_self);
}

//Function Number: 48
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

//Function Number: 49
delete_links_then_self()
{
	var_00 = get_script_linkto_targets();
	common_scripts\utility::func_F1B(var_00,::delete_links_then_self);
	self delete();
}

//Function Number: 50
func_83A4(param_00)
{
	param_00 endon("death");
	param_00 waittill("trigger");
	maps\_utility::func_80AD();
}

//Function Number: 51
func_8356(param_00)
{
	if(!isdefined(level.displayed_hints))
	{
		level.displayed_hints = [];
	}

	waittillframeend;
	var_01 = param_00.var_6BF8;
	param_00 waittill("trigger",var_02);
	if(isdefined(level.displayed_hints[var_01]))
	{
	}

	level.displayed_hints[var_01] = 1;
	var_02 maps\_utility::display_hint(var_01);
}

//Function Number: 52
func_8338(param_00)
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

//Function Number: 53
trigger_turns_off(param_00)
{
	param_00 waittill("trigger");
	param_00 common_scripts\utility::trigger_off();
	if(!isdefined(param_00.script_linkto))
	{
	}

	var_01 = strtok(param_00.script_linkto," ");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		common_scripts\utility::func_F1B(getentarray(var_01[var_02],"script_linkname"),::common_scripts\utility::trigger_off);
	}
}

//Function Number: 54
func_835A(param_00)
{
	thread func_8393(param_00,::maps\_utility::set_ignoreme,::maps\_utility::func_38B7);
}

//Function Number: 55
func_837F(param_00)
{
	thread func_8393(param_00,::maps\_utility::func_6F3F,::maps\_utility::get_pacifist);
}

//Function Number: 56
func_8393(param_00,param_01,param_02)
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

		var_03 thread func_8189(param_00,param_01);
	}
}

//Function Number: 57
func_8189(param_00,param_01)
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

//Function Number: 58
func_838B(param_00)
{
	param_00 waittill("trigger");
	maps\_utility::func_62C0(param_00.script_noteworthy);
}

//Function Number: 59
func_8346(param_00)
{
	if(maps\_utility::func_47D0())
	{
		thread func_8345(param_00);
	}

	var_01 = param_00 maps\_utility::func_39D6();
	if(!isdefined(level.flag[var_01]))
	{
		common_scripts\utility::func_3385(var_01);
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

//Function Number: 60
trigger_multiple_sunflare(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		var_01 maps\_art::func_7D49(param_00.script_visionset,param_00.script_delay);
		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 61
func_8374(param_00)
{
	var_01 = 0;
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	if(isdefined(param_00.var_6D01) && isdefined(param_00.var_6CFF))
	{
		var_01 = 1;
		var_03 = getent(param_00.target,"targetname");
		if(!isdefined(var_03))
		{
			var_03 = common_scripts\utility::func_3C18(param_00.target,"targetname");
		}

		var_04 = getent(var_03.target,"targetname");
		if(!isdefined(var_04))
		{
			var_04 = common_scripts\utility::func_3C18(var_03.target,"targetname");
		}

		var_03 = var_03.origin;
		var_04 = var_04.origin;
		var_02 = distance(var_03,var_04);
		param_00 func_45CB();
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
					var_07 = maps\_utility::func_396C(var_03,var_04,var_06.origin,var_02);
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
					var_06 maps\_utility::func_8A02(param_00.var_6D01,param_00.script_delay);
				}
				else
				{
					var_06 maps\_utility::func_8A02(param_00.var_6CFF,param_00.script_delay);
				}

				continue;
			}

			var_06 maps\_utility::func_8A02(param_00.script_visionset,param_00.script_delay);
		}
	}
}

//Function Number: 62
func_45CB()
{
	if(!isdefined(self.script_delay))
	{
		self.script_delay = 2;
	}

	var_00 = maps\_utility::func_39F2(self.var_6D01);
	var_01 = maps\_utility::func_39F2(self.var_6CFF);
	if(!isdefined(var_00) || !isdefined(var_01))
	{
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

	var_02.var_7D4F = var_05;
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

	var_02.var_7D41 = var_07;
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

	var_02.var_7D3F = var_0B;
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

	var_02.var_7D47 = var_0D;
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

	var_02.var_567A = var_0F;
	var_02.normalfogscale = var_10 - var_0F;
	self.visionset_diff = var_02;
}

//Function Number: 63
vision_set_fog_progress(param_00,param_01)
{
	maps\_utility::func_45A2();
	if(param_01 < 0.5)
	{
		self.var_8A06.var_89FF = param_00.var_6D01;
	}
	else
	{
		self.var_8A06.var_89FF = param_00.var_6CFF;
	}

	self.var_8A06.time = 0;
	if(param_00.var_6D01 == param_00.var_6CFF)
	{
	}

	self visionsetnakedforplayer_lerp(param_00.var_6D01,param_00.var_6CFF,param_01);
	var_02 = maps\_utility::func_39F2(param_00.var_6D01);
	var_03 = maps\_utility::func_39F2(param_00.var_6CFF);
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
		var_05.sungreen = var_04.var_7D4F + var_04.sungreen * param_01;
		var_05.sunblue = var_04.var_7D41 + var_04.sunblue * param_01;
		var_05.hdrsuncolorintensity = var_02.hdrsuncolorintensity + var_04.hdrsuncolorintensity * param_01;
		var_05.sundir = var_04.sundir_start + var_04.sundir * param_01;
		var_05.sunbeginfadeangle = var_04.var_7D3F + var_04.sunbeginfadeangle * param_01;
		var_05.sunendfadeangle = var_04.var_7D47 + var_04.sunendfadeangle * param_01;
		var_05.normalfogscale = var_04.var_567A + var_04.normalfogscale * param_01;
	}

	maps\_utility::func_6EDD(var_05,0.05);
}

//Function Number: 64
func_834B(param_00)
{
	waittillframeend;
	var_01 = param_00.var_6BCA;
	var_02 = param_00.var_6BC9;
	param_00.var_7D4C = 0;
	if(isdefined(var_01) && isdefined(var_02))
	{
		var_03 = maps\_utility::func_3882(var_01);
		var_04 = maps\_utility::func_3882(var_02);
		param_00.var_7D4C = isdefined(var_03.sunred) || isdefined(var_04.sunred);
		param_00.var_7A62 = var_03.startdist;
		param_00.var_7A37 = var_03.halfwaydist;
		param_00.var_7A17 = (var_03.red,var_03.green,var_03.blue);
		param_00.var_7A45 = var_03.hdrcolorintensity;
		param_00.var_7A6F = var_03.maxopacity;
		param_00.var_7A91 = var_03.skyfogintensity;
		param_00.var_7A93 = var_03.skyfogminangle;
		param_00.var_7A92 = var_03.skyfogmaxangle;
		if(isdefined(var_03.sunred))
		{
			param_00.start_suncolor = (var_03.sunred,var_03.sungreen,var_03.sunblue);
			param_00.start_hdrsuncolorintensity = var_03.hdrsuncolorintensity;
			param_00.var_7AA1 = var_03.sundir;
			param_00.var_7A9F = var_03.sunbeginfadeangle;
			param_00.var_7AA2 = var_03.sunendfadeangle;
			param_00.var_7AA3 = var_03.normalfogscale;
		}
		else if(param_00.var_7D4C)
		{
			param_00.start_suncolor = param_00.var_7A17;
			param_00.start_hdrsuncolorintensity = 1;
			param_00.var_7AA1 = (0,0,0);
			param_00.var_7A9F = 0;
			param_00.var_7AA2 = 90;
			param_00.var_7AA3 = 1;
		}

		param_00.end_neardist = var_04.startdist;
		param_00.end_fardist = var_04.halfwaydist;
		param_00.end_color = (var_04.red,var_04.green,var_04.blue);
		param_00.var_2D1C = var_04.hdrcolorintensity;
		param_00.end_opacity = var_04.maxopacity;
		param_00.end_skyfogintensity = var_04.skyfogintensity;
		param_00.var_2D38 = var_04.skyfogminangle;
		param_00.var_2D37 = var_04.skyfogmaxangle;
		if(isdefined(var_04.sunred))
		{
			param_00.end_suncolor = (var_04.sunred,var_04.sungreen,var_04.sunblue);
			param_00.end_hdrsuncolorintensity = var_04.hdrsuncolorintensity;
			param_00.end_sundir = var_04.sundir;
			param_00.end_sunbeginfadeangle = var_04.sunbeginfadeangle;
			param_00.end_sunendfadeangle = var_04.sunendfadeangle;
			param_00.end_sunfogscale = var_04.normalfogscale;
		}
		else if(param_00.var_7D4C)
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
			var_0B = maps\_utility::func_396C(var_06,var_07,var_0A.origin,var_09);
			var_0B = clamp(var_0B,0,1);
			param_00 maps\_art::func_6EDC(var_0B);
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

		param_00 maps\_art::func_6EDC(var_0B);
	}
}

//Function Number: 65
trigger_multiple_depthoffield(param_00)
{
	waittillframeend;
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		var_02 = param_00.var_6B91;
		var_03 = param_00.var_6B90;
		var_04 = param_00.var_6B8F;
		var_05 = param_00.script_dof_far_start;
		var_06 = param_00.var_6B8D;
		var_07 = param_00.var_6B8C;
		var_08 = param_00.script_delay;
		if(var_02 != level.var_287A["base"]["goal"]["nearStart"] || var_03 != level.var_287A["base"]["goal"]["nearEnd"] || var_04 != level.var_287A["base"]["goal"]["nearBlur"] || var_05 != level.var_287A["base"]["goal"]["farStart"] || var_06 != level.var_287A["base"]["goal"]["farEnd"] || var_07 != level.var_287A["base"]["goal"]["farBlur"])
		{
			maps\_art::func_288C(var_02,var_03,var_04,var_05,var_06,var_07,var_08);
			wait(var_08);
			continue;
		}

		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 66
trigger_multiple_tessellationcutoff(param_00)
{
	if(level.xenon || level.ps3)
	{
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

		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 67
func_8397(param_00)
{
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		var_01 thread func_75E9(param_00);
	}
}

//Function Number: 68
func_75E9(param_00)
{
	if(isdefined(self.vehicle))
	{
	}

	if(maps\_utility::issliding())
	{
	}

	if(isdefined(self.var_5F5F))
	{
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
	maps\_utility::func_13F9(undefined,var_01);
	for(;;)
	{
		if(!self istouching(param_00))
		{
			break;
		}

		wait(0.05);
	}

	if(isdefined(level.var_2D39))
	{
		wait(level.var_2D39);
	}

	maps\_utility::endsliding();
}

//Function Number: 69
func_8370(param_00)
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
	}

	var_05 = getentarray(param_00.target,"targetname");
	param_00.var_3638 = 1;
	foreach(var_07 in var_05)
	{
		switch(var_07.classname)
		{
			case "trigger_multiple_fx_volume_on":
				var_07 thread trigger_multiple_fx_trigger_on_think(param_00);
				break;

			case "trigger_multiple_fx_volume_off":
				var_07 thread func_836E(param_00);
				break;

			default:
				break;
		}
	}
}

//Function Number: 70
trigger_multiple_fx_trigger_on_think(param_00)
{
	for(;;)
	{
		self waittill("trigger");
		if(!param_00.var_3638)
		{
			common_scripts\utility::func_F1B(param_00.fx,::maps\_utility::func_6643);
		}

		wait(1);
	}
}

//Function Number: 71
func_836E(param_00)
{
	for(;;)
	{
		self waittill("trigger");
		if(param_00.var_3638)
		{
			common_scripts\utility::func_F1B(param_00.fx,::common_scripts\utility::func_5B59);
		}

		wait(1);
	}
}

//Function Number: 72
assign_fx_to_trigger(param_00,param_01,param_02)
{
	if(isdefined(param_00.var_880E["soundalias"]) && param_00.var_880E["soundalias"] != "nil")
	{
		if(!isdefined(param_00.var_880E["stopable"]) || !param_00.var_880E["stopable"])
		{
		}
	}

	param_02.origin = param_00.var_880E["origin"];
	if(param_02 istouching(param_01))
	{
		param_01.fx[param_01.fx.size] = param_00;
	}
}

//Function Number: 73
func_836C(param_00)
{
	var_01 = param_00.script_parameters;
	if(!isdefined(level.var_527D))
	{
		level.var_527D = "";
	}

	for(;;)
	{
		param_00 waittill("trigger");
		if(level.var_527D != var_01)
		{
			maps\_compass::func_7200(var_01);
		}
	}
}

//Function Number: 74
func_8376(param_00)
{
	common_scripts\utility::func_F1B(level.players,::no_crouch_or_prone_think_for_player,param_00);
}

//Function Number: 75
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

//Function Number: 76
func_8377(param_00)
{
	common_scripts\utility::func_F1B(level.players,::func_562C,param_00);
}

//Function Number: 77
func_562C(param_00)
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