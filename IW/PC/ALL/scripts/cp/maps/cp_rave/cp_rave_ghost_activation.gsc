/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_rave\cp_rave_ghost_activation.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 51
 * Decompile Time: 2662 ms
 * Timestamp: 10/27/2023 12:06:19 AM
*******************************************************************/

//Function Number: 1
init_ghost_n_skull_2_quest()
{
	lib_0D52::func_DED3("ghostTwo",0,::func_2B53,::get_1_9_9_2_kills_from_trap,::complete_1_9_9_2_kills_from_trap,::debug_1_9_9_2_kills_from_trap);
	lib_0D52::func_DED3("ghostTwo",1,::func_2B53,::match_the_right_symbol,::complete_match_the_right_symbol,::debug_match_the_right_symbol);
	lib_0D52::func_DED3("ghostTwo",2,::func_2B53,::hit_skull_at_wheel_of_misfortune,::complete_hit_skull_at_wheel_of_misfortune,::debug_hit_skull_at_wheel_of_misfortune);
	lib_0D52::func_DED3("ghostTwo",3,::func_2B53,::spell_skull,::complete_spell_skull,::debug_spell_skull);
	lib_0D52::func_DED3("ghostTwo",4,::func_2B53,::shoot_skull_during_boat,::complete_shoot_skull_during_boat,::debug_shoot_skull_during_boat);
	lib_0D52::func_DED3("ghostTwo",5,::func_2B53,::hit_gns_cabinet_with_ben_franklin,::complete_hit_gns_cabinet_with_ben_franklin,::debug_hit_gns_cabinet_with_ben_franklin);
	lib_0D52::func_DED3("ghostTwo",6,::func_2B53,::func_135F6,::func_447F,::func_4F30);
}

//Function Number: 2
func_2B53()
{
}

//Function Number: 3
get_1_9_9_2_kills_from_trap()
{
	wait_for_trap_kills("logswing_trap_kills",1);
	wait_for_trap_kills("woodchipper_trap_kills",9);
	wait_for_trap_kills("speaker_trap_kills",9);
	wait_for_trap_kills("waterfall_trap_kills",2);
}

//Function Number: 4
wait_for_trap_kills(param_00,param_01)
{
	for(;;)
	{
		level waittill(param_00,var_02);
		if(var_02 == param_01)
		{
			return;
		}
	}
}

//Function Number: 5
complete_1_9_9_2_kills_from_trap()
{
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_C127(1);
}

//Function Number: 6
debug_1_9_9_2_kills_from_trap()
{
}

//Function Number: 7
match_the_right_symbol()
{
	var_00 = ["c","e","p","w","z"];
	for(;;)
	{
		func_13650();
		var_01 = scripts\common\utility::random(var_00);
		player_look_at_initial_symbol(var_01);
		func_13650();
		var_02 = player_select_one_symbol();
		if(var_02 == var_01)
		{
			break;
		}
	}
}

//Function Number: 8
player_look_at_initial_symbol(param_00)
{
	var_01 = spawn_quest_vfx_symbol((-280,-1483,440),(0,270,45),param_00);
	level.gns_symbol_to_match = var_01;
	wait_for_player_look_at(var_01);
	var_01 thread quest_vfx_fade_out(var_01);
}

//Function Number: 9
player_select_one_symbol()
{
	level.gns_quest_letter_symbols = [];
	var_00 = ["c","e","p","w","z"];
	var_01 = [(2984,150,380),(-184,-1328,76),(-3306,-3040,184),(-1320,-4748,360),(-1648,1119,-58),(-5972,4600,330),(1918,-2184,196),(-3616,1376,23),(-2046,-1306,46),(776,1432,261)];
	var_02 = [(0,330,90),(0,0,90),(0,168,90),(0,240,90),(0,225,90),(0,11,90),(0,150,90),(0,205,90),(0,220,90),(0,0,90)];
	var_03 = scripts\common\utility::array_randomize([0,1,2,3,4,5,6,7,8,9]);
	foreach(var_0A, var_05 in var_00)
	{
		var_06 = var_03[var_0A];
		var_07 = var_01[var_06];
		var_08 = var_02[var_06];
		var_09 = spawn_quest_vfx_symbol(var_07,var_08,var_05);
		var_09 thread wait_for_selection(var_09);
		level.gns_quest_letter_symbols[level.gns_quest_letter_symbols.size] = var_09;
		scripts\common\utility::func_136F7();
	}

	level waittill("GnS_letter_selected",var_0B);
	delete_letter_symbols();
	return var_0B;
}

//Function Number: 10
spawn_quest_vfx_symbol(param_00,param_01,param_02)
{
	var_03 = spawn("script_model",param_00);
	var_03.angles = param_01;
	var_03 setmodel("gns_quest_origin");
	var_03 setscriptablepartstate("vfx",param_02);
	var_03.letter = param_02;
	return var_03;
}

//Function Number: 11
wait_for_selection(param_00)
{
	param_00 endon("death");
	wait_for_player_look_at(param_00);
	param_00 thread quest_vfx_fade_out(param_00);
	level.gns_quest_letter_symbols = scripts\common\utility::func_22A9(level.gns_quest_letter_symbols,param_00);
	level notify("GnS_letter_selected",param_00.letter);
}

//Function Number: 12
wait_for_player_look_at(param_00)
{
	var_01 = int(10);
	for(;;)
	{
		if(any_player_look_at_target(param_00))
		{
			for(var_02 = 1;var_02 <= var_01;var_02++)
			{
				wait(0.15);
				if(any_player_look_at_target(param_00))
				{
					if(var_02 == var_01)
					{
						return;
					}

					continue;
				}
				else
				{
					break;
				}
			}
		}

		wait(0.15);
	}
}

//Function Number: 13
any_player_look_at_target(param_00)
{
	foreach(var_02 in level.players)
	{
		if(player_look_at_target(param_00,var_02))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 14
player_look_at_target(param_00,param_01)
{
	var_02 = 6400;
	if(!scripts\common\utility::istrue(param_01.var_DCEB))
	{
		return 0;
	}

	if(!param_01 adsbuttonpressed())
	{
		return 0;
	}

	if(!param_01 method_8409(param_00.origin,25,75))
	{
		return 0;
	}

	var_03 = bullettrace(param_01 geteye(),param_00.origin,0,param_01);
	var_04 = var_03["position"];
	if(distancesquared(var_04,param_00.origin) > var_02)
	{
		return 0;
	}

	return 1;
}

//Function Number: 15
quest_vfx_fade_out(param_00)
{
	param_00 endon("death");
	param_00 setscriptablepartstate("vfx",param_00.letter + "_fade");
	wait(3);
	param_00 delete();
}

//Function Number: 16
complete_match_the_right_symbol()
{
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_C127(2);
}

//Function Number: 17
delete_letter_symbols()
{
	if(isdefined(level.gns_quest_letter_symbols))
	{
		foreach(var_01 in level.gns_quest_letter_symbols)
		{
			if(isdefined(var_01))
			{
				var_01 delete();
			}
		}
	}
}

//Function Number: 18
debug_match_the_right_symbol()
{
}

//Function Number: 19
func_13650()
{
	level waittill("regular_wave_starting");
}

//Function Number: 20
hit_skull_at_wheel_of_misfortune()
{
	setup_skull_on_wheel_of_misfortune();
	level.gns_wheel_of_misfortune_start_func = ::wheel_of_misfortune_start_func;
	level waittill("hit_GnS_skull_during_wheel_of_misfortune");
	level.gns_wheel_of_misfortune_start_func = undefined;
}

//Function Number: 21
complete_hit_skull_at_wheel_of_misfortune()
{
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_C127(3);
	clear_skull_on_wheel_of_misfortune();
}

//Function Number: 22
debug_hit_skull_at_wheel_of_misfortune()
{
}

//Function Number: 23
setup_skull_on_wheel_of_misfortune()
{
	var_00 = scripts\common\utility::getstructarray("interaction_knife_throw","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_03 = spawn("script_model",var_02.knife_throw_target.origin);
		var_03.angles = var_02.knife_throw_target.angles;
		var_03 setmodel("p7_skulls_bones_head_01");
		var_03 setscriptablepartstate("vfx","green_eyes");
		var_02.knife_throw_target.skull_target = var_03;
		var_03 hide();
	}
}

//Function Number: 24
clear_skull_on_wheel_of_misfortune()
{
	var_00 = scripts\common\utility::getstructarray("interaction_knife_throw","script_noteworthy");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.knife_throw_target.skull_target))
		{
			var_02.knife_throw_target.skull_target delete();
		}
	}
}

//Function Number: 25
wheel_of_misfortune_start_func(param_00,param_01)
{
	var_02 = [(-571,-1582,122),(-602,-1612,122),(-579,-1604,98)];
	var_03 = scripts\common\utility::random(var_02);
	var_04 = param_00.skull_target;
	var_04.origin = var_03;
	var_04.angles = param_00.angles;
	var_04 linkto(param_00);
	var_05 = randomfloatrange(0.1,0.7);
	wait(var_05);
	var_04 show();
	var_04 thread func_4D07(var_04);
	var_06 = var_04 scripts\cp\_utility::func_1372C(5,var_04,"skull_hit_by_knife",param_01,"arcade_game_over_for_player");
	var_04 hide();
	var_04 unlink();
	if(var_06 == "skull_hit_by_knife")
	{
		playfx(level._effect["ghost_explosion_death_green"],var_04.origin,anglestoforward(var_04.angles),anglestoup(var_04.angles));
		level notify("hit_GnS_skull_during_wheel_of_misfortune");
		return;
	}

	var_04 notify("timeout");
}

//Function Number: 26
func_4D07(param_00)
{
	param_00 endon("timeout");
	param_00 setcandamage(1);
	param_00.health = 999999;
	for(;;)
	{
		param_00 waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		param_00.health = 999999;
		if(isplayer(var_02) && isdefined(var_0A) && var_0A == "iw7_cpknifethrow_mp")
		{
			break;
		}
	}

	param_00 notify("skull_hit_by_knife");
}

//Function Number: 27
spell_skull()
{
	for(;;)
	{
		func_13650();
		set_up_characters();
		var_00 = "";
		for(var_01 = 0;var_01 < 5;var_01++)
		{
			level waittill("gns_character_selected",var_02);
			var_00 = var_00 + var_02;
		}

		if(var_00 == "skull")
		{
			break;
		}
	}
}

//Function Number: 28
set_up_characters()
{
	var_00 = [(2984,150,380),(-184,-1328,76),(-3306,-3040,184),(-1320,-4748,360),(-1648,1119,-58),(-5972,4600,330),(1918,-2184,196),(-3616,1376,23),(-2046,-1306,46),(776,1432,261)];
	var_01 = [(0,330,90),(0,0,90),(0,168,90),(0,240,90),(0,225,90),(0,11,90),(0,150,90),(0,205,90),(0,220,90),(0,0,90)];
	var_02 = ["s","k","u","l","l"];
	var_03 = scripts\common\utility::array_randomize([0,1,2,3,4,5,6,7,8,9]);
	level.gns_spell_character_ents = [];
	for(var_04 = 0;var_04 < 5;var_04++)
	{
		var_05 = var_03[var_04];
		var_06 = spawn_quest_vfx_symbol(var_00[var_05],var_01[var_05],var_02[var_04]);
		var_06 thread player_select_monitor(var_06);
		level.gns_spell_character_ents[level.gns_spell_character_ents.size] = var_06;
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 29
player_select_monitor(param_00)
{
	param_00 endon("death");
	wait_for_player_look_at(param_00);
	level.gns_spell_character_ents = scripts\common\utility::func_22A9(level.gns_spell_character_ents,param_00);
	level notify("gns_character_selected",param_00.letter);
	param_00 setscriptablepartstate("vfx",param_00.letter + "_fade");
	wait(3);
	param_00 delete();
}

//Function Number: 30
clear_gns_spell_letters()
{
	if(isdefined(level.gns_spell_character_ents))
	{
		foreach(var_01 in level.gns_spell_character_ents)
		{
			if(isdefined(var_01))
			{
				var_01 delete();
			}
		}
	}
}

//Function Number: 31
complete_spell_skull()
{
	clear_gns_spell_letters();
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_C127(4);
}

//Function Number: 32
debug_spell_skull()
{
}

//Function Number: 33
shoot_skull_during_boat()
{
	level.start_boat_ride_func = ::gns_start_boat_ride_func;
	level waittill("shoot_all_escaping_skulls_during_boat_ride");
	level.start_boat_ride_func = undefined;
}

//Function Number: 34
gns_start_boat_ride_func()
{
	wait(12);
	level thread activate_scaping_skulls();
}

//Function Number: 35
activate_scaping_skulls()
{
	level endon("skull_escaped");
	var_00 = [1,2,3,4,5,6,7,8];
	var_01 = var_00;
	level.skull_destroyed = 0;
	level.escaping_skulls = [];
	for(var_02 = 0;var_02 < 12;var_02++)
	{
		if(var_02 % 8 == 0)
		{
			var_01 = scripts\common\utility::array_randomize(var_00);
		}

		var_03 = var_01[var_02 % 8];
		level thread skull_escape((-2335,5347,-107) + (146 * var_03,-120 * var_03,0),6);
		wait(1);
	}
}

//Function Number: 36
skull_escape(param_00,param_01)
{
	var_02 = spawn("script_model",param_00);
	level.escaping_skulls[level.escaping_skulls.size] = var_02;
	var_02 endon("death");
	var_02 setmodel("zmb_pixel_skull");
	var_02 show_to_boat_players(var_02);
	var_02 thread skull_damage_monitor(var_02);
	var_02 thread color_manager(var_02,param_01);
	var_02.angles = (0,225,0);
	var_02 set_skull_color(var_02,"green");
	var_02 moveto(param_00 + (0,0,500),param_01);
	var_02 waittill("movedone");
	level notify("skull_escaped");
	level thread clear_escaping_skulls();
}

//Function Number: 37
clear_escaping_skulls()
{
	if(isdefined(level.escaping_skulls))
	{
		foreach(var_01 in level.escaping_skulls)
		{
			if(isdefined(var_01))
			{
				var_01 delete();
			}
		}
	}
}

//Function Number: 38
color_manager(param_00,param_01)
{
	param_00 endon("death");
	param_00 set_skull_color(param_00,"green");
	wait(param_01 - 2);
	param_00 set_skull_color(param_00,"red");
}

//Function Number: 39
set_skull_color(param_00,param_01)
{
	param_00.color = param_01;
	param_00 setscriptablepartstate("skull_vfx",param_01);
}

//Function Number: 40
show_to_boat_players(param_00)
{
	param_00 hide();
	foreach(var_02 in level.players)
	{
		if(scripts\common\utility::istrue(var_02.var_AD2B))
		{
			param_00 showtoplayer(var_02);
		}
	}
}

//Function Number: 41
exp_vfx_to_boat_player(param_00)
{
	foreach(var_02 in level.players)
	{
		if(scripts\common\utility::istrue(var_02.var_AD2B))
		{
			playfx(level._effect["ghost_explosion_death_" + param_00.color],param_00.origin,(1,1,0),(0,0,1),var_02);
		}
	}
}

//Function Number: 42
skull_damage_monitor(param_00)
{
	param_00 endon("death");
	param_00 setcandamage(1);
	param_00.health = 999999;
	for(;;)
	{
		param_00 waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		param_00.health = 999999;
		if(!isplayer(var_02))
		{
			continue;
		}

		if(!scripts\common\utility::istrue(var_02.var_AD2B))
		{
			continue;
		}

		break;
	}

	exp_vfx_to_boat_player(param_00);
	level.skull_destroyed++;
	if(level.skull_destroyed == 12)
	{
		level notify("shoot_all_escaping_skulls_during_boat_ride");
	}

	param_00 delete();
}

//Function Number: 43
complete_shoot_skull_during_boat()
{
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_C127(5);
}

//Function Number: 44
debug_shoot_skull_during_boat()
{
}

//Function Number: 45
hit_gns_cabinet_with_ben_franklin()
{
	for(;;)
	{
		level waittill("ben_franklin_lightning_pos",var_00);
		if(var_00[2] > 467)
		{
			continue;
		}

		if(var_00[2] < 386)
		{
			continue;
		}

		if(distance2dsquared(var_00,(-275,-1483,431)) > 484)
		{
			continue;
		}

		break;
	}
}

//Function Number: 46
complete_hit_gns_cabinet_with_ben_franklin()
{
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_C127(6);
}

//Function Number: 47
debug_hit_gns_cabinet_with_ben_franklin()
{
}

//Function Number: 48
func_135F6()
{
	level endon("player_debug_activate_cabinet");
	level.gns_game_console_vfx = spawnfx(level._effect["GnS_activation"],(-282,-1483,437));
	triggerfx(level.gns_game_console_vfx);
	var_00 = (-294,-1469,396);
	var_01 = 2500;
	for(;;)
	{
		var_02 = 1;
		foreach(var_04 in level.players)
		{
			if(scripts\common\utility::istrue(var_04.inlaststand))
			{
				var_02 = 0;
				break;
			}

			if(scripts\common\utility::istrue(var_04.var_9D81))
			{
				var_02 = 0;
				break;
			}

			if(distancesquared(var_04.origin,var_00) > var_01)
			{
				var_02 = 0;
				break;
			}

			if(!var_04 usebuttonpressed())
			{
				var_02 = 0;
				break;
			}
		}

		wait(0.25);
		if(var_02)
		{
			var_02 = 1;
			foreach(var_04 in level.players)
			{
				if(scripts\common\utility::istrue(var_04.inlaststand))
				{
					var_02 = 0;
					break;
				}

				if(scripts\common\utility::istrue(var_04.var_9D81))
				{
					var_02 = 0;
					break;
				}

				if(distancesquared(var_04.origin,var_00) > var_01)
				{
					var_02 = 0;
					break;
				}

				if(!var_04 usebuttonpressed())
				{
					var_02 = 0;
					break;
				}
			}
		}

		if(var_02)
		{
			level.gns_game_console_vfx delete();
			return;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 49
func_447F()
{
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_C127(-1,0.5);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_10C61();
}

//Function Number: 50
func_4F30()
{
}

//Function Number: 51
reactive_ghost_n_skull_cabinet()
{
	if(!lib_0D52::quest_line_exist("reactivateghost"))
	{
		lib_0D52::func_DED3("reactivateghost",0,::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::reactivate_cabinet,::hit_gns_cabinet_with_ben_franklin,::complete_hit_gns_cabinet_with_ben_franklin,::debug_hit_gns_cabinet_with_ben_franklin);
		lib_0D52::func_DED3("reactivateghost",1,::func_2B53,::func_135F6,::func_447F,::func_4F30);
	}

	level thread lib_0D52::func_10CEE("reactivateghost");
}