/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\sg_events_v1\extermination.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 224 ms
 * Timestamp: 10/27/2023 3:12:18 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::sg_obj_register_defaults("type_extermination_common",::basic_extermination_run,120,0,0);
}

//Function Number: 2
basic_extermination_run(param_00)
{
	var_01 = level.zmb_sg_objectives[param_00];
	var_02 = ["zombie_exploder"];
	var_03 = undefined;
	level.zmb_temp_zombie_health_buff = maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::get_player_level_setting("extermination_common_extermination_health_multiplier");
	level.zmb_disable_all_hitreacts = maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::get_player_level_setting("extermination_common_extermination_hitreacts_enabled");
	if(level.zmb_temp_zombie_health_buff == 1)
	{
		level.zmb_temp_zombie_health_buff = undefined;
	}

	if(isdefined(var_01.var_2A35))
	{
		if(isdefined(var_01.var_2A35.ext_type))
		{
			if(isarray(var_01.var_2A35.ext_type))
			{
				if(isarray(var_01.var_2A35.ext_type[0]))
				{
					var_02 = common_scripts\utility::func_7A33(var_01.var_2A35.ext_type);
				}
				else
				{
					var_02 = var_01.var_2A35.ext_type;
				}
			}
			else
			{
				var_02 = [var_01.var_2A35.ext_type];
			}
		}

		foreach(var_05 in var_02)
		{
			switch(var_05)
			{
				case "zombie_exploder":
					var_03 = level.var_A41["zombie_exploder"]["move_mode"];
					level.var_A41["zombie_exploder"]["move_mode"] = ::objective_extermination_bomber_movemode;
					break;

				case "zombie_generic":
					level thread objective_extermination_sizzler_handler();
					break;
			}
		}

		if(common_scripts\utility::func_F79(var_02,"zombie_sizzler") || common_scripts\utility::func_F79(var_02,"zombie_generic"))
		{
			level thread maps/mp/zombies/shotgun/_zombies_shotgun_rideau_global::run_extermination_dialog();
		}

		var_07 = maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::get_difficulty_setting(param_00 + "_delay");
		if(!isdefined(var_07) && isdefined(var_01.var_2A35.ext_spawn_delay))
		{
			var_07 = var_01.var_2A35.ext_spawn_delay;
		}

		if(isdefined(var_07))
		{
			level.sg_manual_spawn_delay = var_07;
		}

		var_08 = maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::get_difficulty_setting(param_00 + "_count");
		var_09 = maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::get_player_level_setting("extermination_common_player_level_extension");
		var_08 = int(var_08 * var_09);
		lib_0547::func_7BA9(::exterminationkillcounter);
		level thread notify_on_extermination_kill_requirement(var_08);
		if(!isdefined(var_08) && isdefined(var_01.var_2A35.ext_wave_count))
		{
			var_08 = var_01.var_2A35.ext_wave_count;
		}
	}

	level notify("extermination_round_start",var_02[0]);
	level.var_1CC0 = var_02;
	var_0A = common_scripts\utility::func_A70E(level,"sg_obj_timeout",level,"round complete",level,"extermination complete");
	var_0B = var_0A[0];
	var_0C = var_0A[1];
	lib_0547::func_2D8C(::exterminationkillcounter);
	level.zmb_temp_zombie_health_buff = undefined;
	level.zmb_disable_all_hitreacts = undefined;
	level.var_1CC0 = undefined;
	foreach(var_05 in var_02)
	{
		switch(var_05)
		{
			case "zombie_exploder":
				level.var_A41["zombie_exploder"]["move_mode"] = var_03;
				break;
		}
	}

	if(var_0B == "sg_obj_timeout")
	{
		return 0;
	}

	return 1;
}

//Function Number: 3
notify_on_extermination_kill_requirement(param_00)
{
	level endon("sg_obj_timeout");
	level endon("round complete");
	level.plr_extermination_kills = 0;
	level.currentexterminationgoal = param_00;
	foreach(var_02 in level.var_744A)
	{
		var_02 setclientomnvar("ui_onevone_class_3",level.currentexterminationgoal);
		var_02 setclientomnvar("ui_onevone_class_4",level.plr_extermination_kills);
	}

	while(level.plr_extermination_kills < param_00)
	{
		wait 0.05;
	}

	level notify("extermination complete");
}

//Function Number: 4
exterminationkillcounter(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(common_scripts\utility::func_562E(self.var_AC10))
	{
		return;
	}

	var_09 = 0;
	if(lib_0547::func_5565(self.var_A4B,"zombie_exploder"))
	{
		var_09 = 1;
	}

	if(lib_0547::func_5565(self.var_A4B,"zombie_sizzler") && lib_0547::func_5565(param_04,"trap_zm_mp") || isdefined(param_01) && isplayer(param_01))
	{
		var_09 = 1;
	}

	if(lib_0547::func_5565(self.var_A4B,"zombie_generic") && common_scripts\utility::func_562E(self.transformingtosizzler) && lib_0547::func_5565(param_04,"trap_zm_mp") || isdefined(param_01) && isplayer(param_01))
	{
		var_09 = 1;
	}

	if(var_09)
	{
		level.plr_extermination_kills++;
		if(isdefined(level.currentexterminationgoal))
		{
			foreach(var_0B in level.var_744A)
			{
				var_0B setclientomnvar("ui_onevone_class_3",level.currentexterminationgoal);
				var_0B setclientomnvar("ui_onevone_class_4",level.plr_extermination_kills);
			}
		}
	}
}

//Function Number: 5
objective_extermination_bomber_movemode()
{
	if(!isdefined(self.bomberforceruntimestart))
	{
		self.bomberforceruntimestart = gettime();
		self.bomberforcerundelay = maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::get_player_level_setting("extermination_common_bomber_force_run_start");
	}

	if(gettime() - self.bomberforceruntimestart / 1000 >= self.bomberforcerundelay)
	{
		return lib_054D::func_957E(100);
	}

	return "walk";
}

//Function Number: 6
basic_extermination_skip_cleanup()
{
	level endon("sg_obj_timeout");
	level endon("round complete");
	level waittill("skipWave");
	level.var_1CC0 = undefined;
}

//Function Number: 7
objective_extermination_sizzler_handler()
{
	level endon("round complete");
	level.max_sizzlers = maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::get_difficulty_setting("extermination_common_sizzler_maximum");
	level.max_sizzlers = level.max_sizzlers + maps/mp/zombies/shotgun/_zombies_shotgun_gamemode_utility::get_player_level_setting("extermination_common_sizzler_add");
	var_00 = 0.05;
	var_01 = 0.15;
	wait(randomfloatrange(var_00,var_01));
	for(;;)
	{
		level.current_sizz = lib_0547::func_4090("zombie_sizzler").size;
		if(level.current_sizz < level.max_sizzlers)
		{
			var_02 = lib_0547::func_4090("zombie_generic");
			foreach(var_04 in var_02)
			{
				if(!function_01EF(var_04) || !isalive(var_04) || var_04 method_85A5() != "zombie_animclass" || common_scripts\utility::func_562E(var_04.transformingtosizzler))
				{
					var_05 = common_scripts\utility::func_F93(var_02,var_04);
				}
			}

			var_07 = undefined;
			if(var_02.size > 0)
			{
				var_07 = objective_extermination_sizzler_choose_best_generic(var_02);
			}
			else
			{
				level waittill("spawned_agent",var_04);
				var_07 = var_04;
				wait(1);
				if(!isdefined(var_07))
				{
					wait 0.05;
					continue;
				}
			}

			if(isdefined(var_07))
			{
				if(!var_07 try_to_become_a_sizzler())
				{
					wait 0.05;
					continue;
				}
				else
				{
				}

				wait(randomfloatrange(var_00,var_01));
			}
			else
			{
				wait(0.15);
			}
		}
		else
		{
			wait(0.15);
		}

		wait 0.05;
	}
}

//Function Number: 8
try_to_become_a_sizzler(param_00)
{
	var_01 = self;
	if(!lib_0547::func_5565(var_01.var_A4B,"zombie_generic") || !function_01EF(var_01) || !isalive(var_01) || var_01 method_85A5() != "zombie_animclass" || common_scripts\utility::func_562E(var_01.transformingtosizzler))
	{
		return 0;
	}

	var_01 objective_extermination_sizzler_think(param_00);
	return 1;
}

//Function Number: 9
objective_extermination_sizzler_choose_best_generic(param_00)
{
	if(param_00.size == 1)
	{
		return param_00[0];
	}

	return common_scripts\utility::func_7A33(param_00);
}

//Function Number: 10
objective_extermination_sizzler_think(param_00)
{
	self endon("death");
	if(!common_scripts\utility::func_562E(param_00))
	{
		thread func_5D67(self.var_116);
	}

	thread maps/mp/zombies/zombie_sizzler::zombie_make_sizzler();
}

//Function Number: 11
func_5D67(param_00)
{
	var_01 = 5000;
	var_02 = spawn("script_model",param_00 + (0,0,var_01));
	var_02 setmodel("tag_origin");
	var_02.var_1D = var_02.var_1D + (90,0,0);
	var_03 = spawn("script_model",param_00);
	var_03 setmodel("tag_origin");
	var_03.var_1D = var_03.var_1D + (-90,0,0);
	var_04 = launchbeam("zmb_wm_lightning_beam",var_02,"tag_origin",var_03,"tag_origin");
	playfxontag(level.var_611["zmb_wm_lightning_impact_base_rnr"],var_03,"tag_origin");
	lib_0378::func_8D74("lightning_strike",var_02.var_116,param_00);
	wait(randomfloatrange(0.25,0.35));
	var_04 delete();
	var_02 delete();
	var_03 delete();
}