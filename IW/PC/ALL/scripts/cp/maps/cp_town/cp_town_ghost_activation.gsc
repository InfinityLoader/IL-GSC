/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_town\cp_town_ghost_activation.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 150
 * Decompile Time: 7783 ms
 * Timestamp: 10/27/2023 12:07:27 AM
*******************************************************************/

//Function Number: 1
init_ghost_n_skull_4_quest()
{
	lib_0D52::func_DED3("ghostFour",0,::func_2B53,::shoot_skulls_in_map,::complete_shoot_skulls_in_map,::debug_shoot_skulls_in_map,5,"Shoot skulls around the map");
	lib_0D52::func_DED3("ghostFour",1,::func_2B53,::find_radiation_extractor_collect_radiation,::complete_radiation_extractor_collect_radiation,::debug_radiation_extractor_collect_radiation,5,"Collect radiation");
	lib_0D52::func_DED3("ghostFour",2,::func_2B53,::pollute_pool_and_kills,::complete_pollute_pool_and_kills,::debug_pollute_pool_and_kills,5,"Pollute Pool and Kill");
	lib_0D52::func_DED3("ghostFour",3,::func_2B53,::cipher_quest,::complete_cipher_quest,::debug_cipher_quest,5,"Cipher Quest");
	lib_0D52::func_DED3("ghostFour",4,::func_2B53,::weeping_angels_start,::complete_weeping_angels_start,::debug_weeping_angels_start,5,"Weeping angles");
	lib_0D52::func_DED3("ghostFour",5,::func_2B53,::shoot_the_machine,::complete_shoot_the_machine,::debug_shoot_the_machine,5,"Shoot the arcade machine");
	lib_0D52::func_DED3("ghostFour",6,::func_2B53,::func_135F6,::func_447F,::func_4F30,5,"Wait for player activation");
	init();
	init_cipher_clue_texture();
}

//Function Number: 2
init_cipher_clue_texture()
{
	var_00 = getent("cipher_word_hint","script_noteworthy");
	level.cipher_hint = var_00;
	setomnvar("zm_ui_skull_top_ent",level.cipher_hint);
}

//Function Number: 3
func_2B53()
{
}

//Function Number: 4
watch_for_skull_death()
{
	level endon("shoot_skulls_in_map_done");
	self endon("end_this_thread_for_" + self.object_num);
	for(;;)
	{
		self.model waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(!isplayer(var_01))
		{
			continue;
		}

		level.skulls_killed++;
		playfx(scripts\common\utility::getfx("hidden_figure_death"),var_03);
		var_01 playlocalsound("part_pickup");
		if(self.model.health < 0)
		{
			self.model delete();
			self notify("end_this_thread_for_" + self.object_num);
		}
	}
}

//Function Number: 5
shoot_skulls_in_map()
{
	level waittill("prematch_done");
	foreach(var_01 in level.weeping_angels_note)
	{
		var_01 thread watch_for_damage_on_struct();
	}

	var_03 = 0;
	while(!scripts\common\utility::istrue(var_03))
	{
		if(isdefined(level.skulls_killed))
		{
			if(level.skulls_killed >= 5)
			{
				var_03 = 1;
			}
		}

		wait(1);
	}

	level notify("shoot_skulls_in_map_done");
}

//Function Number: 6
complete_shoot_skulls_in_map()
{
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_C127(1);
}

//Function Number: 7
debug_shoot_skulls_in_map()
{
	level.skulls_killed = 5;
}

//Function Number: 8
find_radiation_extractor_collect_radiation()
{
	level waittill("radiation_extraction_started");
	level.radiation_extractor.ticks_of_radiation = 0;
	level thread watch_radiation_extractor_ticks();
	foreach(var_01 in level.players)
	{
		var_01 thread watch_for_player_position();
	}

	scripts\cp\_interaction::add_to_current_interaction_list(level.radiation_extraction_interaction);
	level scripts\common\utility::waittill_any_3("completed_extraction","debug_radiation_extractor_collect_radiation");
	level notify("stop_tick_on_loop");
}

//Function Number: 9
watch_radiation_extractor_ticks()
{
	level endon("completed_extraction");
	level endon("debug_radiation_extractor_collect_radiation");
	for(;;)
	{
		if(level.radiation_extractor.ticks_of_radiation > 9)
		{
			level.radiation_extractor.ticks_of_radiation = 0;
			level.radiation_extractor thread move_model_after_tick(0);
		}
		else if(level.radiation_extractor.ticks_of_radiation == 9)
		{
			level.radiation_extractor.origin = level.radiation_extraction_interaction.origin;
			level.radiation_extractor.angles = level.radiation_extraction_interaction.angles;
			level.radiation_extractor setmodel("cp_town_radiation_extractor");
			level.radiation_extractor thread play_tick_on_loop();
			wait(30);
			level notify("stop_tick_on_loop");
			level.radiation_extractor thread move_model_after_tick(0);
		}

		if(scripts\common\utility::istrue(level.charge_machine))
		{
			level.radiation_extractor.ticks_of_radiation++;
			level.radiation_extractor thread move_model_after_tick(1);
			wait(30);
			continue;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 10
play_tick_on_loop()
{
	level endon("stop_tick_on_loop");
	for(;;)
	{
		scripts\common\utility::play_sound_in_space("town_radiation_extractor_tick_up",self.origin + (0,0,5));
		wait(0.6);
		scripts\common\utility::play_sound_in_space("town_radiation_extractor_tick_up_final",self.origin + (0,0,5));
		wait(2.7);
	}
}

//Function Number: 11
watch_for_player_position()
{
	self endon("disconnect");
	level endon("completed_extraction");
	level endon("debug_radiation_extractor_collect_radiation");
	self notify("one_thread_instance_for_player" + self.name);
	self endon("one_thread_instance_for_player" + self.name);
	for(;;)
	{
		if(!isdefined(level.radiation_extraction_interaction))
		{
			scripts\common\utility::func_136F7();
			continue;
		}

		if(distance2dsquared(level.radiation_extraction_interaction.origin,self.origin) <= 1000000 && !scripts\common\utility::istrue(self.in_afterlife_arcade))
		{
			level.charge_machine = 1;
		}
		else
		{
			level.charge_machine = 0;
		}

		wait(1);
	}
}

//Function Number: 12
complete_radiation_extractor_collect_radiation()
{
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_C127(2);
}

//Function Number: 13
debug_radiation_extractor_collect_radiation()
{
}

//Function Number: 14
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

//Function Number: 15
pollute_pool_and_kills()
{
	level waittill("placed_extractor_in_pool");
	wait_for_trap_kills("pool_trap_kills",16);
	if(isdefined(level.pool_extraction_fx))
	{
		level.pool_extraction_fx delete();
	}

	level.rad_extractor_owner = undefined;
	scripts\cp\_interaction::add_to_current_interaction_list(level.radiation_extraction_interaction);
	level.completed_pool_part_skulltop_quest = 1;
}

//Function Number: 16
complete_pollute_pool_and_kills()
{
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_C127(3);
}

//Function Number: 17
debug_pollute_pool_and_kills()
{
}

//Function Number: 18
calculate_cipher_from_current_interaction(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_01))
	{
		param_01 = "0";
		level.cipher_choices[0].model setscriptablepartstate("cipher_glyph","neutral");
	}
	else
	{
		level.cipher_choices[0].model setscriptablepartstate("cipher_glyph",param_01);
	}

	if(!isdefined(param_02))
	{
		param_02 = "0";
		level.cipher_choices[1].model setscriptablepartstate("cipher_glyph","neutral");
	}
	else
	{
		level.cipher_choices[1].model setscriptablepartstate("cipher_glyph",param_02);
	}

	if(!isdefined(param_03))
	{
		param_03 = "0";
		level.cipher_choices[2].model setscriptablepartstate("cipher_glyph","neutral");
	}
	else
	{
		level.cipher_choices[2].model setscriptablepartstate("cipher_glyph",param_03);
	}

	if(!isdefined(param_04))
	{
		param_04 = "0";
		level.cipher_choices[3].model setscriptablepartstate("cipher_glyph","neutral");
	}
	else
	{
		level.cipher_choices[3].model setscriptablepartstate("cipher_glyph",param_04);
	}

	var_05 = 1;
	var_06 = 2;
	var_07 = 3;
	var_08 = 4;
	var_09 = 3;
	var_0A = 6;
	var_0B = 9;
	var_0C = 0;
	var_0D = 0;
	var_0E = 0;
	var_0F = level.alphabets[param_01];
	if(param_02 == "0")
	{
		var_0C = 0;
	}
	else if(param_02 == level.cipherlettera)
	{
		var_0C = var_05 * var_09 + level.alphabets[param_02];
	}
	else if(param_02 == level.cipherletterb)
	{
		var_0C = var_06 * var_09 + level.alphabets[param_02];
	}
	else if(param_02 == level.cipherletterc)
	{
		var_0C = var_07 * var_09 + level.alphabets[param_02];
	}
	else if(param_02 == level.cipherletterd)
	{
		var_0C = var_08 * var_09 + level.alphabets[param_02];
	}

	if(param_03 == "0")
	{
		var_0D = 0;
	}
	else if(param_03 == level.cipherlettera)
	{
		var_0D = var_05 * var_0A + level.alphabets[param_03];
	}
	else if(param_03 == level.cipherletterb)
	{
		var_0D = var_06 * var_0A + level.alphabets[param_03];
	}
	else if(param_03 == level.cipherletterc)
	{
		var_0D = var_07 * var_0A + level.alphabets[param_03];
	}
	else if(param_03 == level.cipherletterd)
	{
		var_0D = var_08 * var_0A + level.alphabets[param_03];
	}

	if(param_04 == "0")
	{
		var_0E = 0;
	}
	else if(param_04 == level.cipherlettera)
	{
		var_0E = var_05 * var_0B + level.alphabets[param_04];
	}
	else if(param_04 == level.cipherletterb)
	{
		var_0E = var_06 * var_0B + level.alphabets[param_04];
	}
	else if(param_04 == level.cipherletterc)
	{
		var_0E = var_07 * var_0B + level.alphabets[param_04];
	}
	else if(param_04 == level.cipherletterd)
	{
		var_0E = var_08 * var_0B + level.alphabets[param_04];
	}

	var_10 = 0;
	if(!isdefined(var_0F))
	{
		var_10 = var_0C + var_0D + var_0E;
	}
	else
	{
		var_10 = var_0F + var_0C + var_0D + var_0E;
	}

	var_11 = 0;
	var_12 = var_10;
	if(var_12 >= 26)
	{
		var_12 = var_12 - 26 * int(floor(var_12 / 26));
	}
	else
	{
		var_12 = var_10;
	}

	if(var_12 < 1)
	{
		var_12 = 26;
	}
	else
	{
		var_12 = var_12 - 26 * int(floor(var_12 / 26));
	}

	var_11 = var_12;
	var_13 = "";
	foreach(var_16, var_15 in level.alphabets)
	{
		if(var_11 == var_15)
		{
			var_13 = var_16;
			break;
		}
	}

	return var_13;
}

//Function Number: 19
calculate_cipher_from_letters_initially(param_00,param_01,param_02,param_03)
{
	if(!isdefined(level.alphabets))
	{
		level.alphabets = [];
		level.alphabets["a"] = level.alphabets.size + 1;
		level.alphabets["b"] = level.alphabets.size + 1;
		level.alphabets["c"] = level.alphabets.size + 1;
		level.alphabets["d"] = level.alphabets.size + 1;
		level.alphabets["e"] = level.alphabets.size + 1;
		level.alphabets["f"] = level.alphabets.size + 1;
		level.alphabets["g"] = level.alphabets.size + 1;
		level.alphabets["h"] = level.alphabets.size + 1;
		level.alphabets["i"] = level.alphabets.size + 1;
		level.alphabets["j"] = level.alphabets.size + 1;
		level.alphabets["k"] = level.alphabets.size + 1;
		level.alphabets["l"] = level.alphabets.size + 1;
		level.alphabets["m"] = level.alphabets.size + 1;
		level.alphabets["n"] = level.alphabets.size + 1;
		level.alphabets["o"] = level.alphabets.size + 1;
		level.alphabets["p"] = level.alphabets.size + 1;
		level.alphabets["q"] = level.alphabets.size + 1;
		level.alphabets["r"] = level.alphabets.size + 1;
		level.alphabets["s"] = level.alphabets.size + 1;
		level.alphabets["t"] = level.alphabets.size + 1;
		level.alphabets["u"] = level.alphabets.size + 1;
		level.alphabets["v"] = level.alphabets.size + 1;
		level.alphabets["w"] = level.alphabets.size + 1;
		level.alphabets["x"] = level.alphabets.size + 1;
		level.alphabets["y"] = level.alphabets.size + 1;
		level.alphabets["z"] = level.alphabets.size + 1;
	}

	var_04 = [param_00 + "_" + param_03 + "_" + param_01 + "_" + param_02 + "",param_00 + "_" + param_03 + "_" + param_02 + "_" + param_01 + "",param_00 + "_" + param_01 + "_" + param_03 + "_" + param_02 + "",param_00 + "_" + param_01 + "_" + param_02 + "_" + param_03 + "",param_00 + "_" + param_02 + "_" + param_03 + "_" + param_01 + "",param_00 + "_" + param_02 + "_" + param_01 + "_" + param_03 + "",param_03 + "_" + param_00 + "_" + param_02 + "_" + param_01 + "",param_03 + "_" + param_00 + "_" + param_01 + "_" + param_02 + "",param_03 + "_" + param_01 + "_" + param_02 + "_" + param_00 + "",param_03 + "_" + param_01 + "_" + param_00 + "_" + param_02 + "",param_03 + "_" + param_02 + "_" + param_01 + "_" + param_00 + "",param_03 + "_" + param_02 + "_" + param_00 + "_" + param_01 + "",param_01 + "_" + param_00 + "_" + param_03 + "_" + param_02 + "",param_01 + "_" + param_00 + "_" + param_02 + "_" + param_03 + "",param_01 + "_" + param_03 + "_" + param_00 + "_" + param_02 + "",param_01 + "_" + param_03 + "_" + param_02 + "_" + param_00 + "",param_01 + "_" + param_02 + "_" + param_00 + "_" + param_03 + "",param_01 + "_" + param_02 + "_" + param_03 + "_" + param_00 + "",param_02 + "_" + param_00 + "_" + param_01 + "_" + param_03 + "",param_02 + "_" + param_00 + "_" + param_03 + "_" + param_01 + "",param_02 + "_" + param_03 + "_" + param_01 + "_" + param_00 + "",param_02 + "_" + param_03 + "_" + param_00 + "_" + param_01 + "",param_02 + "_" + param_01 + "_" + param_03 + "_" + param_00 + "",param_02 + "_" + param_01 + "_" + param_00 + "_" + param_03 + "",param_00 + "_" + param_03 + "_" + param_01 + "_" + 0 + "",param_00 + "_" + param_01 + "_" + param_03 + "_" + 0 + "",param_03 + "_" + param_00 + "_" + param_01 + "_" + 0 + "",param_03 + "_" + param_01 + "_" + param_00 + "_" + 0 + "",param_01 + "_" + param_00 + "_" + param_03 + "_" + 0 + "",param_01 + "_" + param_03 + "_" + param_00 + "_" + 0 + "",param_00 + "_" + param_03 + "_" + param_02 + "_" + 0 + "",param_00 + "_" + param_02 + "_" + param_03 + "_" + 0 + "",param_03 + "_" + param_00 + "_" + param_02 + "_" + 0 + "",param_03 + "_" + param_02 + "_" + param_00 + "_" + 0 + "",param_02 + "_" + param_00 + "_" + param_03 + "_" + 0 + "",param_02 + "_" + param_03 + "_" + param_00 + "_" + 0 + "",param_00 + "_" + param_01 + "_" + param_02 + "_" + 0 + "",param_00 + "_" + param_02 + "_" + param_01 + "_" + 0 + "",param_01 + "_" + param_00 + "_" + param_02 + "_" + 0 + "",param_01 + "_" + param_02 + "_" + param_00 + "_" + 0 + "",param_02 + "_" + param_00 + "_" + param_01 + "_" + 0 + "",param_02 + "_" + param_01 + "_" + param_00 + "_" + 0 + "",param_03 + "_" + param_01 + "_" + param_02 + "_" + 0 + "",param_03 + "_" + param_02 + "_" + param_01 + "_" + 0 + "",param_01 + "_" + param_03 + "_" + param_02 + "_" + 0 + "",param_01 + "_" + param_02 + "_" + param_03 + "_" + 0 + "",param_02 + "_" + param_03 + "_" + param_01 + "_" + 0 + "",param_02 + "_" + param_01 + "_" + param_03 + "_" + 0 + "",param_00 + "_" + param_01 + "_" + 0 + "_" + 0 + "",param_01 + "_" + param_00 + "_" + 0 + "_" + 0 + "",param_00 + "_" + param_02 + "_" + 0 + "_" + 0 + "",param_02 + "_" + param_00 + "_" + 0 + "_" + 0 + "",param_00 + "_" + param_03 + "_" + 0 + "_" + 0 + "",param_03 + "_" + param_00 + "_" + 0 + "_" + 0 + "",param_01 + "_" + param_02 + "_" + 0 + "_" + 0 + "",param_02 + "_" + param_01 + "_" + 0 + "_" + 0 + "",param_01 + "_" + param_03 + "_" + 0 + "_" + 0 + "",param_03 + "_" + param_01 + "_" + 0 + "_" + 0 + "",param_02 + "_" + param_03 + "_" + 0 + "_" + 0 + "",param_03 + "_" + param_02 + "_" + 0 + "_" + 0 + "",param_00 + "_" + param_00 + "_" + param_00 + "_" + 0 + "",param_01 + "_" + param_01 + "_" + param_01 + "_" + 0 + "",param_02 + "_" + param_02 + "_" + param_02 + "_" + 0 + "",param_03 + "_" + param_03 + "_" + param_03 + "_" + 0 + "",param_00 + "_" + param_00 + "_" + param_00 + "_" + 0 + "",param_01 + "_" + param_01 + "_" + param_01 + "_" + 0 + "",param_02 + "_" + param_02 + "_" + param_02 + "_" + 0 + "",param_03 + "_" + param_03 + "_" + param_03 + "_" + 0 + "",param_00 + "_" + param_00 + "_" + 0 + "_" + 0 + "",param_01 + "_" + param_01 + "_" + 0 + "_" + 0 + "",param_02 + "_" + param_02 + "_" + 0 + "_" + 0 + "",param_03 + "_" + param_03 + "_" + 0 + "_" + 0 + "",param_00 + "_" + 0 + "_" + 0 + "_" + 0 + "",param_01 + "_" + 0 + "_" + 0 + "_" + 0 + "",param_02 + "_" + 0 + "_" + 0 + "_" + 0 + "",param_03 + "_" + 0 + "_" + 0 + "_" + 0 + "",param_00 + "_" + param_00 + "_" + param_00 + "_" + param_00 + "",param_01 + "_" + param_01 + "_" + param_01 + "_" + param_01 + "",param_02 + "_" + param_02 + "_" + param_02 + "_" + param_02 + "",param_03 + "_" + param_03 + "_" + param_03 + "_" + param_03 + "",param_00 + "_" + param_00 + "_" + param_00 + "_" + 0 + "",param_01 + "_" + param_01 + "_" + param_01 + "_" + 0 + "",param_02 + "_" + param_02 + "_" + param_02 + "_" + 0 + "",param_03 + "_" + param_03 + "_" + param_03 + "_" + 0 + "",param_00 + "_" + param_00 + "_" + 0 + "_" + 0 + "",param_01 + "_" + param_01 + "_" + 0 + "_" + 0 + "",param_02 + "_" + param_02 + "_" + 0 + "_" + 0 + "",param_03 + "_" + param_03 + "_" + 0 + "_" + 0 + ""];
	var_05 = [];
	var_06 = [];
	var_07 = [];
	var_08 = [];
	foreach(var_0A in var_04)
	{
		var_0B = strtok(var_0A,"_");
		var_05[var_05.size] = var_0B[0];
		var_06[var_06.size] = var_0B[1];
		var_07[var_07.size] = var_0B[2];
		var_08[var_08.size] = var_0B[3];
	}

	var_0D = 1;
	var_0E = 2;
	var_0F = 3;
	var_10 = 4;
	var_11 = 3;
	var_12 = 6;
	var_13 = 9;
	var_14 = [];
	var_15 = [];
	var_16 = [];
	var_17 = [];
	foreach(var_0A in var_05)
	{
		foreach(var_1B, var_1A in level.alphabets)
		{
			if(var_0A == var_1B)
			{
				var_14[var_14.size] = level.alphabets[var_0A];
			}
		}
	}

	foreach(var_0A in var_06)
	{
		if(var_0A == "0")
		{
			var_15[var_15.size] = 0;
			continue;
		}

		foreach(var_1B, var_1A in level.alphabets)
		{
			if(var_0A == var_1B)
			{
				if(var_0A == param_00)
				{
					var_15[var_15.size] = var_0D * var_11 + level.alphabets[var_1B];
					continue;
				}

				if(var_0A == param_01)
				{
					var_15[var_15.size] = var_0E * var_11 + level.alphabets[var_1B];
					continue;
				}

				if(var_0A == param_02)
				{
					var_15[var_15.size] = var_0F * var_11 + level.alphabets[var_1B];
					continue;
				}

				if(var_0A == param_03)
				{
					var_15[var_15.size] = var_10 * var_11 + level.alphabets[var_1B];
				}
			}
		}
	}

	foreach(var_0A in var_07)
	{
		if(var_0A == "0")
		{
			var_16[var_16.size] = 0;
			continue;
		}

		foreach(var_1B, var_1A in level.alphabets)
		{
			if(var_0A == var_1B)
			{
				if(var_0A == param_00)
				{
					var_16[var_16.size] = var_0D * var_12 + level.alphabets[var_1B];
					continue;
				}

				if(var_0A == param_01)
				{
					var_16[var_16.size] = var_0E * var_12 + level.alphabets[var_1B];
					continue;
				}

				if(var_0A == param_02)
				{
					var_16[var_16.size] = var_0F * var_12 + level.alphabets[var_1B];
					continue;
				}

				if(var_0A == param_03)
				{
					var_16[var_16.size] = var_10 * var_12 + level.alphabets[var_1B];
				}
			}
		}
	}

	foreach(var_0A in var_08)
	{
		if(var_0A == "0")
		{
			var_17[var_17.size] = 0;
			continue;
		}

		foreach(var_1B, var_1A in level.alphabets)
		{
			if(var_0A == var_1B)
			{
				if(var_0A == param_00)
				{
					var_17[var_17.size] = var_0D * var_13 + level.alphabets[var_1B];
					continue;
				}

				if(var_0A == param_01)
				{
					var_17[var_17.size] = var_0E * var_13 + level.alphabets[var_1B];
					continue;
				}

				if(var_0A == param_02)
				{
					var_17[var_17.size] = var_0F * var_13 + level.alphabets[var_1B];
					continue;
				}

				if(var_0A == param_03)
				{
					var_17[var_17.size] = var_10 * var_13 + level.alphabets[var_1B];
				}
			}
		}
	}

	level.ciphertotalcolumn = [];
	for(var_26 = 0;var_26 < var_14.size;var_26++)
	{
		level.ciphertotalcolumn[var_26] = var_14[var_26] + var_15[var_26] + var_16[var_26] + var_17[var_26];
	}

	level.final_cipher_letter_numbers = [];
	foreach(var_2A, var_28 in level.ciphertotalcolumn)
	{
		var_29 = var_28;
		if(var_29 >= 26)
		{
			var_29 = var_29 - 26 * int(floor(var_29 / 26));
		}
		else
		{
			var_29 = var_28;
		}

		if(var_29 < 1)
		{
			var_29 = 26;
		}
		else
		{
			var_29 = var_29 - 26 * int(floor(var_29 / 26));
		}

		level.final_cipher_letter_numbers[var_2A] = var_29;
	}

	level.available_letters_for_cipher = [];
	foreach(var_2C in level.final_cipher_letter_numbers)
	{
		foreach(var_1B, var_2E in level.alphabets)
		{
			if(var_2C == var_2E)
			{
				level.available_letters_for_cipher[level.available_letters_for_cipher.size] = var_1B;
			}
		}
	}
}

//Function Number: 20
cipher_quest()
{
	foreach(var_01 in level.cipher_interactions_structs)
	{
		scripts\cp\_interaction::add_to_current_interaction_list(var_01);
		var_01.model show();
	}

	foreach(var_04 in level.cipher_model_structs)
	{
		var_04.model show();
	}

	level waittill("cipher_solved");
}

//Function Number: 21
complete_cipher_quest()
{
	level.completed_cipher = 1;
	foreach(var_01 in level.cipher_interactions_structs)
	{
		scripts\cp\_interaction::remove_from_current_interaction_list(var_01);
		var_01.model hide();
	}

	foreach(var_04 in level.cipher_model_structs)
	{
		var_04.model hide();
	}

	foreach(var_08, var_07 in level.cipher_choices)
	{
		level.cipher_choices[var_08].model setscriptablepartstate("cipher_glyph","neutral");
	}

	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_C127(4);
}

//Function Number: 22
debug_cipher_quest()
{
}

//Function Number: 23
slow_mo_sphere(param_00)
{
	self.sacred_ground = spawn("trigger_radius",param_00.origin,0,400,256);
	self.sacred_ground.var_7542 = spawnfx(level._effect["slow_time_bubble"],param_00.origin);
	self.sacred_ground.var_FB2F = scripts\common\utility::play_loopsound_in_space("town_mute_circle_lp",param_00.origin);
	thread scripts\common\utility::play_sound_in_space("town_mute_circle_start",param_00.origin);
	self.zombie_list = [];
	playfx(scripts\common\utility::getfx("hidden_figure_death"),param_00.origin);
	wait(1);
	triggerfx(self.sacred_ground.var_7542);
	self.sacred_ground thread apply_slow_mo_on_trigger();
	level waittill("end_painting_" + param_00.name);
	if(isdefined(self.sacred_ground.var_7542))
	{
		self.sacred_ground.var_7542 delete();
	}

	if(isdefined(self.sacred_ground.var_FB2F))
	{
		self.sacred_ground.var_FB2F delete();
	}

	if(isdefined(self.sacred_ground))
	{
		self.sacred_ground delete();
	}

	param_00.model setmodel("cp_town_willard_painting");
	var_01 = scripts\cp\_agent_utils::func_7DB0("axis");
	foreach(var_03 in var_01)
	{
		var_03 scripts\mp\agents\_scriptedagents::func_F85E(0,"DoAttack");
		var_03.activated_slomo_sphere = 0;
		var_03.var_C189 = 0;
		var_03.var_9E0C = undefined;
	}
}

//Function Number: 24
custom_unslow_func(param_00)
{
	param_00 endon("death");
	if(!isalive(param_00))
	{
		return;
	}

	param_00.var_180 = 0;
	param_00.nocorpse = undefined;
	param_00.full_gib = undefined;
	param_00.var_C189 = undefined;
}

//Function Number: 25
custom_slow_time_func(param_00)
{
	param_00 endon("death");
	param_00.var_9E0C = 1;
	param_00.var_180 = 1;
	param_00.nocorpse = 1;
	param_00.full_gib = 1;
	param_00.var_C189 = 1;
	param_00 waittill("unslow_zombie");
	param_00.var_9E0C = undefined;
}

//Function Number: 26
apply_slow_mo_on_trigger()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			if(var_01 istouching(self))
			{
				if(!scripts\common\utility::istrue(var_01.inside_slow_sphere))
				{
					var_01 thread scripts\cp\maps\cp_town\cp_town::update_special_mode_for_player(var_01);
				}

				var_01.inside_slow_sphere = 1;
				continue;
			}

			if(scripts\common\utility::istrue(var_01.inside_slow_sphere))
			{
				var_01 thread scripts\cp\maps\cp_town\cp_town::update_special_mode_for_player(var_01);
			}

			var_01.inside_slow_sphere = 0;
		}

		var_03 = scripts\cp\_agent_utils::func_7DB0("axis");
		level.zombie_list = var_03;
		foreach(var_05 in level.zombie_list)
		{
			if(!isdefined(var_05))
			{
				scripts\common\utility::func_136F7();
				continue;
			}

			if(!var_05 scripts\cp\_utility::func_9D20())
			{
				scripts\common\utility::func_136F7();
				continue;
			}

			if(var_05 scripts\cp\_utility::agentisfnfimmune())
			{
				scripts\common\utility::func_136F7();
				continue;
			}

			if(!scripts\common\utility::istrue(var_05.entered_playspace))
			{
				scripts\common\utility::func_136F7();
				continue;
			}

			if(var_05 istouching(self))
			{
				var_05 scripts\mp\agents\_scriptedagents::func_F85E(1,"DoAttack");
				var_05.activated_slomo_sphere = 1;
				var_05.var_C189 = 1;
				var_05.var_9E0C = 1;
				continue;
			}

			var_05 scripts\mp\agents\_scriptedagents::func_F85E(0,"DoAttack");
			var_05.activated_slomo_sphere = 0;
			var_05.var_C189 = 0;
			var_05.var_9E0C = undefined;
			var_05 notify("unslow_zombie");
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 27
weeping_angels_start()
{
	foreach(var_01 in level.weeping_angels_note)
	{
		var_01.model show();
	}

	level waittill("weeping_angels_note_read");
	foreach(var_04 in level.players)
	{
		var_04.weeping_angels_puzzle = 1;
	}

	level.var_7456 = ::custom_slow_time_func;
	level.var_11768 = ::custom_unslow_func;
	var_06 = 0;
	var_07 = 0;
	var_08 = 0;
	var_09 = 0;
	level scripts\common\utility::func_137AC("painting_01_done","painting_02_done","painting_03_done","painting_04_done");
}

//Function Number: 28
wait_for_painting_kills_complete(param_00,param_01,param_02)
{
	for(;;)
	{
		level waittill(param_00,var_03);
		if(var_03 == param_01)
		{
			param_02 = 1;
			return param_02;
		}
	}
}

//Function Number: 29
complete_weeping_angels_start()
{
	level.var_7456 = ::scripts\cp\zombies\zombie_scriptable_states::func_7383;
	level.var_11768 = ::scripts\cp\zombies\zombie_scriptable_states::func_12B9A;
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_C127(5);
}

//Function Number: 30
debug_weeping_angels_start()
{
}

//Function Number: 31
shoot_the_machine()
{
	level.skulltop_machine = getent("skullhop_machine","targetname");
	level.skulltop_machine setcandamage(1);
	level.skulltop_machine.health = 5;
	level.skulltop_machine.maxhealth = 5;
	level.skulltop_machine thread watch_for_damage_on_machine();
	level waittill("machine_hit_successfully");
	level thread play_gns_success_vo();
}

//Function Number: 32
play_gns_success_vo()
{
	level endon("game_ended");
	foreach(var_01 in level.players)
	{
		var_01 thread scripts\cp\_vo::try_to_play_vo("access_ghostnskulls","town_comment_vo");
	}
}

//Function Number: 33
watch_for_damage_on_machine()
{
	self endon("end_func_on" + self.model);
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(!var_01 scripts\cp\_utility::is_valid_player())
		{
			continue;
		}

		if(isdefined(var_04) && var_04 == "MOD_MELEE")
		{
			self.maxhealth = 5;
			self.health = 5;
			continue;
		}

		if(!issubstr(var_09,"cutie"))
		{
			self.maxhealth = 5;
			self.health = 5;
			continue;
		}

		if(scripts\common\utility::istrue(var_01.fired_fov_beam))
		{
			var_0A = getomnvar("zm_num_ghost_n_skull_coin");
			if(isdefined(var_0A) && var_0A >= 5)
			{
				level notify("machine_hit_successfully");
			}
			else
			{
				continue;
			}

			self notify("end_func_on" + self.model);
		}
	}
}

//Function Number: 34
complete_shoot_the_machine()
{
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_C127(6);
}

//Function Number: 35
debug_shoot_the_machine()
{
}

//Function Number: 36
func_135F6()
{
	level endon("player_debug_activate_cabinet");
	level.gns_game_console_vfx = spawnfx(level._effect["GnS_activation"],(5459,-4767,29));
	triggerfx(level.gns_game_console_vfx);
	var_00 = (5444,-4760,-14);
	var_01 = 10000;
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
			if(isdefined(level.gns_game_console_vfx))
			{
				level.gns_game_console_vfx delete();
			}

			return;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 37
func_447F()
{
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_C127(-1,0.5);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_10C61();
}

//Function Number: 38
func_4F30()
{
}

//Function Number: 39
func_13650()
{
	level waittill("regular_wave_starting");
}

//Function Number: 40
cp_town_gns_4_setup()
{
	level.skulls_killed = 0;
	level.gns_num_of_wave = 3;
	level.init_formation_movement_func = ::gns3_formation_movement;
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::init();
	level.death_trigger_reset_y_pos = 424;
	level.death_trigger_activate_y_pos = 1353;
	level.original_death_grid_lines_front_y_pos = 3020;
	level.zombie_ghost_model = "zombie_ghost_cube_white";
	level.set_moving_target_color_func = ::cp_town_set_moving_target_color;
	level.should_moving_target_explode = ::cp_town_should_moving_target_explode;
	level.hit_wrong_moving_target_func = ::cp_town_hit_wrong_moving_target_func;
	level.moving_target_pre_fly_time = 0.5;
	level.gns_hotjoin_wait_notify = "finish_intro_gesture";
	level.gns_reward_func = ::town_gns_player_reward_func;
	level.get_fake_ghost_model_func = ::town_get_fake_ghost_model_func;
	level.max_num_of_death_trigger_advance = 9;
	level.gns_end_func = ::town_gns_end_func;
	level.gns_start_func = ::town_gns_start_func;
	level.enter_ghosts_n_skulls_func = ::cp_town_enter_ghosts_n_skulls_func;
	level.end_ghosts_n_skulls_func = ::cp_town_end_ghosts_n_skulls_func;
	level.disable_gns_death_trigger = 1;
	level.post_moving_target_rotate_func = ::color_indicator_manager;
	level.complete_one_gns_wave_func = ::kill_color_indicator_manager;
	level.pre_gns_end_func = ::deactivate_color_indicator;
	level.ghost_n_skull_reactivate_func = ::reactivate_skullbuster_cabinet;
	level.moving_target_attack_interval = 9000;
	level.grab_same_ghost_string = &"CP_TOWN_GNS_TRACK_SAME_CUBE";
	level.all_perk_list = ["perk_machine_boom","perk_machine_flash","perk_machine_fwoosh","perk_machine_more","perk_machine_rat_a_tat","perk_machine_revive","perk_machine_run","perk_machine_deadeye","perk_machine_tough","perk_machine_change","perk_machine_zap","perk_machine_smack"];
	level.var_CC0C = [];
	level.pool_placement_volume = getent("pool_extraction_volume","targetname");
	level.radiation_collection_volume = getent("radiation_extraction_volume","targetname");
	init_skulls_to_shoot();
	register_ghost_form();
	register_waves_movement();
	load_cp_town_ghost_exp_vfx();
	set_up_platform_and_trigger();
	level thread init_weeping_angels_note();
	if(!isdefined(level.hidden_figures))
	{
		level.hidden_figures = [];
	}

	level.hidden_figures[0] = spawnstruct();
	level.hidden_figures[0].origin = (4058,-4359,76);
	level.hidden_figures[0].var_D776 = 0;
	level.hidden_figures[0].var_E1B9 = 0;
	level.hidden_figures[0].name = "hidden_figure_objects";
	level.hidden_figures[0].script_noteworthy = "figure_1";
	level.hidden_figures[0].var_EE79 = "default";
	level.hidden_figures[0].var_336 = "interaction";
	var_00 = scripts\common\utility::getstructarray("figure_1","script_noteworthy");
	level.hidden_figures[1] = spawnstruct();
	level.hidden_figures[1].origin = (4058,-4359,76);
	level.hidden_figures[1].var_D776 = 0;
	level.hidden_figures[1].var_E1B9 = 0;
	level.hidden_figures[1].name = "hidden_figure_objects";
	level.hidden_figures[1].script_noteworthy = "figure_2";
	level.hidden_figures[1].var_EE79 = "default";
	level.hidden_figures[1].var_336 = "interaction";
	var_00 = scripts\common\utility::getstructarray("figure_2","script_noteworthy");
	level.hidden_figures[2] = spawnstruct();
	level.hidden_figures[2].origin = (4058,-4359,76);
	level.hidden_figures[2].var_D776 = 0;
	level.hidden_figures[2].var_E1B9 = 0;
	level.hidden_figures[2].name = "hidden_figure_objects";
	level.hidden_figures[2].script_noteworthy = "figure_3";
	level.hidden_figures[2].var_EE79 = "default";
	level.hidden_figures[2].var_336 = "interaction";
	var_00 = scripts\common\utility::getstructarray("figure_3","script_noteworthy");
	level.hidden_figures[3] = spawnstruct();
	level.hidden_figures[3].origin = (4058,-4359,76);
	level.hidden_figures[3].var_D776 = 0;
	level.hidden_figures[3].var_E1B9 = 0;
	level.hidden_figures[3].name = "hidden_figure_objects";
	level.hidden_figures[3].script_noteworthy = "figure_4";
	level.hidden_figures[3].var_EE79 = "default";
	level.hidden_figures[3].var_336 = "interaction";
	var_00 = scripts\common\utility::getstructarray("figure_4","script_noteworthy");
	foreach(var_02 in level.hidden_figures)
	{
		var_02.var_86A2 = "locOverride";
		var_02.playeroffset = [];
		setup_hidden_figure_models(var_02,var_02.script_noteworthy);
	}

	init_ghost_n_skull_4_quest();
}

//Function Number: 41
cp_town_enter_ghosts_n_skulls_func(param_00)
{
	param_00 thread restore_color_in_gns(param_00);
	param_00 thread entangled_cube_color_manager(param_00);
}

//Function Number: 42
restore_color_in_gns(param_00)
{
	param_00 endon("disconnect");
	var_01 = 0;
	foreach(var_03 in level.players)
	{
		if(scripts\common\utility::istrue(var_03.activate_gns_machine))
		{
			var_01 = 1;
			break;
		}
	}

	if(var_01)
	{
		param_00 visionsetnakedforplayer("cp_town_color",1);
		wait(2);
	}

	param_00 visionsetnakedforplayer("cp_zmb_ghost_path",1);
}

//Function Number: 43
cp_town_end_ghosts_n_skulls_func(param_00)
{
	param_00 notify("stop_entangled_cube_color_manager");
	param_00 visionsetnakedforplayer(level.current_vision_set,0);
	scripts\cp\maps\cp_town\cp_town_crab_boss_death_ray::hide_charge_progress(param_00);
}

//Function Number: 44
entangled_cube_color_manager(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("stop_entangled_cube_color_manager");
	for(;;)
	{
		if(isdefined(param_00.ghost_in_entanglement))
		{
			var_01 = param_00.ghost_in_entanglement;
			var_02 = get_platform_trigger_color(param_00);
			if(isdefined(var_01.color) && var_02 != var_01.color)
			{
				change_cube_color(var_01,var_02);
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 45
set_up_platform_and_trigger()
{
	var_00 = ["blue","green","yellow","red"];
	foreach(var_02 in var_00)
	{
		var_03 = getent(var_02 + "_platform","targetname");
		var_04 = getent(var_02 + "_platform_trigger","targetname");
		var_03.var_C725 = var_03.origin;
		var_04.var_C725 = var_04.origin;
		var_04 enablelinkto();
		var_04 linkto(var_03);
	}
}

//Function Number: 46
get_platform_trigger_color(param_00)
{
	var_01 = ["blue","green","yellow","red"];
	foreach(var_03 in var_01)
	{
		var_04 = getent(var_03 + "_platform_trigger","targetname");
		if(param_00 istouching(var_04))
		{
			return var_03;
		}
	}

	return "white";
}

//Function Number: 47
color_indicator_manager()
{
	level endon("kill_color_indicator_manager");
	var_00 = 15;
	var_01 = 0.5;
	var_02 = "none";
	var_03 = ["green","red","blue","yellow"];
	for(;;)
	{
		var_04 = scripts\common\utility::func_22A9(var_03,var_02);
		var_02 = scripts\common\utility::random(var_04);
		update_color_indicator_color(var_02);
		wait(var_00 - var_01 * 5);
		turn_off_color_indicator();
		wait(var_01);
		turn_on_color_indicator();
		wait(var_01);
		turn_off_color_indicator();
		wait(var_01);
		turn_on_color_indicator();
		wait(var_01);
		turn_off_color_indicator();
		wait(var_01);
	}
}

//Function Number: 48
turn_off_color_indicator()
{
	foreach(var_01 in level.skull_hop_color_indicators)
	{
		var_01 setscriptablepartstate("skull_hop_indicator","off");
	}
}

//Function Number: 49
turn_on_color_indicator()
{
	foreach(var_01 in level.skull_hop_color_indicators)
	{
		var_01 setscriptablepartstate("skull_hop_indicator",level.color_indicator_color);
	}
}

//Function Number: 50
kill_color_indicator_manager()
{
	level notify("kill_color_indicator_manager");
	update_color_indicator_color("off");
}

//Function Number: 51
init_cipher_interactions()
{
	scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1,"cipher_interaction",undefined,undefined,::radiation_collection_hint_func,::cipher_activation_func,0,0,::init_cipher_interaction_structs,undefined);
	thread init_cipher_choices();
	thread init_cipher_letters();
}

//Function Number: 52
init_cipher_choices()
{
	var_00 = scripts\common\utility::getstructarray("cipher_choice_model","script_noteworthy");
	level.cipher_choices = [];
	foreach(var_02 in var_00)
	{
		var_03 = undefined;
		switch(var_02.name)
		{
			case "cipher_choice_1":
				var_03 = spawn("script_model",var_02.origin);
				var_03 setmodel("tag_origin_cipher_letter");
				var_03.angles = var_02.angles + (0,90,0);
				break;

			case "cipher_choice_2":
				var_03 = spawn("script_model",var_02.origin);
				var_03 setmodel("tag_origin_cipher_letter");
				var_03.angles = var_02.angles + (0,90,0);
				break;

			case "cipher_choice_3":
				var_03 = spawn("script_model",var_02.origin);
				var_03 setmodel("tag_origin_cipher_letter");
				var_03.angles = var_02.angles + (0,90,0);
				break;

			case "cipher_choice_4":
				var_03 = spawn("script_model",var_02.origin);
				var_03 setmodel("tag_origin_cipher_letter");
				var_03.angles = var_02.angles + (0,90,0);
				break;

			default:
				break;
		}

		var_03 setscriptablepartstate("cipher_glyph","neutral");
		if(isdefined(var_03))
		{
			var_02.model = var_03;
		}

		var_04 = strtok(var_02.name,"_");
		var_02.index = int(var_04[2]);
		level.cipher_choices[var_02.index - 1] = var_02;
	}
}

//Function Number: 53
init_cipher_letters()
{
	level.words_for_cipher = [];
	level.words_for_cipher[0] = ["chlorination","bromination","solvolysis","azides","alkenes","hydrogenation","oxidation","reduction","ethers","ethyl","aldehydes","benzene","nitriles","allomer","neutrino","sublimation","zwitterion"];
	level.chosen_cipher_word = scripts\common\utility::random(level.words_for_cipher[0]);
	roll_correct_letter_combination(level.chosen_cipher_word);
	level thread set_omnvar_based_on_word(level.chosen_cipher_word);
	var_00 = scripts\common\utility::getstructarray("cipher_letter_model","script_noteworthy");
	level.cipher_model_structs = [];
	foreach(var_02 in var_00)
	{
		switch(var_02.name)
		{
			case "cipher_letter_13":
			case "cipher_letter_12":
			case "cipher_letter_11":
			case "cipher_letter_10":
			case "cipher_letter_9":
			case "cipher_letter_8":
			case "cipher_letter_7":
			case "cipher_letter_6":
			case "cipher_letter_5":
			case "cipher_letter_4":
			case "cipher_letter_3":
			case "cipher_letter_2":
			case "cipher_letter_1":
				var_03 = spawn("script_model",var_02.origin);
				var_03 setmodel("tag_origin_cipher_letter");
				var_03.angles = var_02.angles + (0,90,0);
				var_03 setcandamage(1);
				var_03.maxhealth = 99999;
				var_03.health = 99999;
				var_02.model = var_03;
				var_02.current_letter = "";
				var_02.completed_cipher_letter = 0;
				var_04 = strtok(var_02.name,"_");
				var_05 = var_04[2];
				var_02.model setscriptablepartstate("cipher_glyph","neutral");
				var_02.model hide();
				var_02 thread watch_for_damage_on_cipher_letter(var_05);
				level.cipher_model_structs[int(var_05) - 1] = [];
				level.cipher_model_structs[int(var_05) - 1] = var_02;
				break;
		}

		if(!isdefined(level.cipher_pointer))
		{
			level.cipher_pointer = 0;
		}
	}

	level thread watch_for_correct_combination_of_letters_entered();
}

//Function Number: 54
set_omnvar_based_on_word(param_00)
{
	var_01 = 0;
	switch(param_00)
	{
		case "chlorination":
			var_01 = 1;
			break;

		case "bromination":
			var_01 = 2;
			break;

		case "solvolysis":
			var_01 = 3;
			break;

		case "azides":
			var_01 = 4;
			break;

		case "alkenes":
			var_01 = 5;
			break;

		case "hydrogenation":
			var_01 = 6;
			break;

		case "oxidation":
			var_01 = 7;
			break;

		case "reduction":
			var_01 = 8;
			break;

		case "ethers":
			var_01 = 9;
			break;

		case "ethyl":
			var_01 = 10;
			break;

		case "aldehydes":
			var_01 = 11;
			break;

		case "benzene":
			var_01 = 12;
			break;

		case "nitriles":
			var_01 = 13;
			break;

		case "bro":
			var_01 = 14;
			break;

		case "allomer":
			var_01 = 15;
			break;

		case "neutrino":
			var_01 = 16;
			break;

		case "sublimation":
			var_01 = 17;
			break;

		case "zwitterion":
			var_01 = 18;
			break;
	}

	setomnvar("skulltop_cipher_hint",var_01);
}

//Function Number: 55
watch_for_correct_combination_of_letters_entered()
{
	level endon("cipher_solved");
	for(;;)
	{
		if(!isdefined(level.chosen_cipher_word))
		{
			continue;
		}

		var_00 = "";
		for(var_01 = 0;var_01 < level.cipher_pointer;var_01++)
		{
			var_00 = var_00 + level.cipher_model_structs[var_01].current_letter;
			if(level.chosen_cipher_word == var_00)
			{
				level notify("cipher_solved");
			}
		}

		wait(1);
	}
}

//Function Number: 56
roll_correct_letter_combination(param_00)
{
	var_01 = getrandomletter();
	var_02 = getrandomletter();
	var_03 = getrandomletter();
	var_04 = getrandomletter();
	for(;;)
	{
		if(does_cipher_have_all_letters(var_01,var_02,var_03,var_04,param_00))
		{
			level.cipherlettera = var_01;
			level.cipherletterb = var_02;
			level.cipherletterc = var_03;
			level.cipherletterd = var_04;
			return;
		}
		else
		{
			var_01 = getrandomletter();
			var_02 = getrandomletter();
			var_03 = getrandomletter();
			var_04 = getrandomletter();
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 57
does_cipher_have_all_letters(param_00,param_01,param_02,param_03,param_04)
{
	calculate_cipher_from_letters_initially(param_00,param_01,param_02,param_03);
	var_05 = scripts\common\utility::func_22AF(level.available_letters_for_cipher);
	var_06 = [];
	var_06 = get_chars_of_word_as_array(param_04);
	var_07 = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
	foreach(var_09 in var_06)
	{
		if(!scripts\common\utility::func_2286(var_05,var_09))
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 58
get_chars_of_word_as_array(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_01[var_02] = param_00[var_02];
	}

	return var_01;
}

//Function Number: 59
cipher_activation_func(param_00,param_01)
{
	param_01 endon("disconnect");
	if(scripts\common\utility::istrue(level.completed_cipher))
	{
		return;
	}

	if(!isdefined(level.letter_roll))
	{
		level.letter_roll = [];
	}

	if(!isdefined(level.letter_roll["a"]))
	{
		level.letter_roll["a"] = "0";
	}

	if(!isdefined(level.letter_roll["b"]))
	{
		level.letter_roll["b"] = "0";
	}

	if(!isdefined(level.letter_roll["c"]))
	{
		level.letter_roll["c"] = "0";
	}

	if(!isdefined(level.letter_roll["d"]))
	{
		level.letter_roll["d"] = "0";
	}

	if(!isdefined(level.letter_inputs))
	{
		level.letter_inputs = [];
	}

	switch(param_00.name)
	{
		case "cipher_interaction_01":
			level.letter_roll["a"] = param_00.letter;
			break;

		case "cipher_interaction_02":
			level.letter_roll["b"] = param_00.letter;
			break;

		case "cipher_interaction_03":
			level.letter_roll["c"] = param_00.letter;
			break;

		case "cipher_interaction_04":
			level.letter_roll["d"] = param_00.letter;
			break;

		default:
			break;
	}

	if(!isdefined(level.cipherlettera) || !isdefined(level.cipherletterb) || !isdefined(level.cipherletterc) || !isdefined(level.cipherletterd))
	{
		wait(0.8);
		return;
	}

	level.letter_inputs[level.letter_inputs.size] = param_00.letter;
	var_02 = calculate_cipher_from_current_interaction(param_01,level.letter_inputs[0],level.letter_inputs[1],level.letter_inputs[2],level.letter_inputs[3]);
	spawn_fx_on_theatre_screen(param_01,var_02);
	if(level.letter_inputs.size >= 4)
	{
		level thread clear_up_input_display_after_time(20);
		level.letter_inputs = [];
	}
}

//Function Number: 60
clear_up_input_display_after_time(param_00)
{
	level endon("end_clear_input_func");
	level thread watch_for_inputs_reentered();
	wait(param_00);
	foreach(var_03, var_02 in level.cipher_choices)
	{
		level.cipher_choices[var_03].model setscriptablepartstate("cipher_glyph","neutral");
	}
}

//Function Number: 61
watch_for_inputs_reentered()
{
	level endon("end_clear_input_func");
	level notify("one_instance_of_func");
	level endon("one_instance_of_func");
	for(;;)
	{
		if(level.letter_inputs.size > 0)
		{
			level notify("end_clear_input_func");
			continue;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 62
delay_enable_linked_interaction(param_00,param_01,param_02)
{
	param_02 endon("disconnect");
	level waittill("spawn_wave_done");
	scripts\cp\_interaction::func_175D(param_00,param_02);
}

//Function Number: 63
spawn_fx_on_theatre_screen(param_00,param_01)
{
	var_02 = (5076,-2547,473);
	var_03 = (0,300,0);
	level.cipher_model_structs[level.cipher_pointer].model setscriptablepartstate("cipher_glyph",param_01);
	level.cipher_model_structs[level.cipher_pointer].current_letter = param_01;
}

//Function Number: 64
getrandomletter()
{
	var_00 = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
	return scripts\common\utility::random(var_00);
}

//Function Number: 65
init_painting_interactions()
{
	scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1,"painting_interaction",undefined,undefined,::radiation_collection_hint_func,::paintings_activation_function,0,0,::init_paintings_interaction,undefined);
}

//Function Number: 66
paintings_activation_function(param_00,param_01)
{
	level.var_7456 = ::custom_slow_time_func;
	level.var_11768 = ::custom_unslow_func;
	if(!scripts\common\utility::istrue(param_01.weeping_angels_puzzle))
	{
		return;
	}

	if(isdefined(param_00.painting_owner))
	{
		if(param_00.painting_owner == param_01)
		{
			return;
		}
		else
		{
			return;
		}
	}

	if(scripts\common\utility::istrue(level.painting_active))
	{
		return;
	}

	level.painting_active = 1;
	param_00.painting_owner = param_01;
	param_01.hidden_figures_hit = 0;
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	level thread watch_for_player_disconnect_after_painting_trigger(param_00,param_01);
	level thread look_at_painting(param_00,param_01);
	level thread slow_mo_sphere(param_00);
	wait(40);
	level notify("end_painting_" + param_00.name);
	param_01.triggered_rad_extractor_device = 0;
	level.painting_active = 0;
	param_00.painting_owner = undefined;
	param_01.inside_slow_sphere = 0;
	level.var_7456 = ::scripts\cp\zombies\zombie_scriptable_states::func_7383;
	level.var_11768 = ::scripts\cp\zombies\zombie_scriptable_states::func_12B9A;
	if(param_01.hidden_figures_hit >= 7)
	{
		level notify(param_00.name + "_done");
		level thread scripts\common\utility::play_sound_in_space("part_pickup",param_00.origin);
		if(isdefined(param_01.array_of_weeping_angels))
		{
			foreach(var_03 in param_01.array_of_weeping_angels)
			{
				var_03 delete();
			}
		}

		param_01.hidden_figures_hit = 0;
		scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
		return;
	}

	param_01.hidden_figures_hit = 0;
	if(isdefined(param_01.array_of_weeping_angels))
	{
		foreach(var_03 in param_01.array_of_weeping_angels)
		{
			var_03 delete();
		}
	}

	param_01 playlocalsound("perk_machine_deny");
	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
}

//Function Number: 67
watch_for_player_disconnect_after_painting_trigger(param_00,param_01)
{
	level endon("game_ended");
	level endon("end_disconnect_thread_for_" + param_00.name);
	for(;;)
	{
		param_01 waittill("disconnect");
		if(isdefined(param_01.array_of_weeping_angels))
		{
			foreach(var_03 in param_01.array_of_weeping_angels)
			{
				var_03 delete();
			}
		}

		param_00.model setmodel("cp_town_willard_painting");
		level.painting_active = 0;
		param_00.painting_owner = undefined;
		scripts\cp\_interaction::add_to_current_interaction_list(param_00);
		level notify("end_disconnect_thread_for_" + param_00.name);
	}
}

//Function Number: 68
look_at_painting(param_00,param_01)
{
	param_01 endon("disconnect");
	level endon("end_painting_" + param_00.name);
	for(;;)
	{
		if(scripts\common\utility::func_56F4(param_00.origin,param_01.origin) > 5184)
		{
			scripts\common\utility::func_136F7();
			param_00.model setmodel("cp_town_willard_painting");
			continue;
		}

		if(scripts\common\utility::func_13D90(param_01.origin,param_01.angles,param_00.origin,cos(70)))
		{
			param_00.model setmodel("cp_town_willard_painting");
			scripts\common\utility::func_136F7();
			continue;
		}
		else if(randomint(100) > 98)
		{
			param_00.model setmodel("cp_town_willard_painting_skull");
			param_01 dodamage(param_01.health / 15,param_01.origin);
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 69
init_skullbusters_interactions()
{
	scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1,"radiation_collector_interaction",undefined,undefined,::radiation_collection_hint_func,::collector_activation_func,0,0,::init_collector_func,undefined);
	scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1,"radiation_extraction_interaction",undefined,undefined,::radiation_collection_hint_func,::extraction_activation_func,0,0,::init_extraction_point_func,undefined);
	scripts\cp\maps\cp_town\cp_town_chemistry::init_setup_radio_prefabs();
	scripts\cp\maps\cp_town\cp_town_chemistry::init_chem_reaction_interactions();
	init_painting_interactions();
	init_cipher_interactions();
}

//Function Number: 70
collector_activation_func(param_00,param_01)
{
	param_01 endon("disconnect");
	level endon("game_ended");
	if(scripts\common\utility::istrue(level.picked_up_radiation_collector))
	{
		param_01 playlocalsound("perk_machine_deny");
		return;
	}

	if(!isdefined(level.skulls_killed))
	{
		param_01 playlocalsound("perk_machine_deny");
		return;
	}

	if(isdefined(level.skulls_killed) && level.skulls_killed < 5)
	{
		param_01 playlocalsound("perk_machine_deny");
		return;
	}

	level.picked_up_radiation_collector = 1;
	playfx(scripts\common\utility::getfx("hidden_figure_death"),param_00.origin);
	param_01 playlocalsound("part_pickup");
	param_00.model hide();
	level notify("radiation_collector_found");
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
}

//Function Number: 71
last_stand_watcher(param_00)
{
	for(;;)
	{
		scripts\common\utility::waittill_any_3("last_stand","death","disconnect");
		if(!scripts\common\utility::istrue(level.picked_up_radiation_collector))
		{
			scripts\cp\_interaction::add_to_current_interaction_list(param_00);
			level.picked_up_radiation_collector = undefined;
			param_00.model show();
		}
	}
}

//Function Number: 72
pickup_extractor_after_collecting_radiation(param_00)
{
	playfx(scripts\common\utility::getfx("hidden_figure_death"),level.radiation_extraction_interaction.origin);
	param_00 playlocalsound("part_pickup");
	level.rad_extractor_owner = param_00;
	give_crafted_rad_extractor(level.radiation_extraction_interaction,param_00);
	param_00 thread last_stand_watcher_extractor_craft(level.radiation_extraction_interaction);
	level notify("completed_extraction");
}

//Function Number: 73
last_stand_watcher_extractor_craft(param_00)
{
	for(;;)
	{
		scripts\common\utility::waittill_any_3("last_stand","death","disconnect");
		level.rad_extractor_owner = undefined;
	}
}

//Function Number: 74
extraction_activation_func(param_00,param_01)
{
	if(!scripts\common\utility::istrue(level.picked_up_radiation_collector))
	{
		return;
	}

	if(isdefined(level.radiation_extractor) && isdefined(level.radiation_extractor.ticks_of_radiation))
	{
		if(level.radiation_extractor.ticks_of_radiation == 9)
		{
			if(!isdefined(level.rad_extractor_owner))
			{
				thread pickup_extractor_after_collecting_radiation(param_01);
				return;
			}

			return;
		}
		else if(level.radiation_extractor.ticks_of_radiation < 9 || level.radiation_extractor.ticks_of_radiation > 9)
		{
			return;
		}
	}

	scripts\cp\_interaction::remove_from_current_interaction_list(level.radiation_collector[0]);
	level.radiation_extraction_interaction = param_00;
	var_02 = spawn("script_model",param_00.origin);
	var_02 setmodel("cp_town_radiation_extractor_top");
	var_02.angles = param_00.angles;
	level.radiation_extractor = var_02;
	param_01 thread last_stand_watcher_extractor_craft(param_00);
	param_01 playlocalsound("part_pickup");
	level notify("radiation_extraction_started");
	scripts\cp\_interaction::remove_from_current_interaction_list(level.radiation_extraction_interaction);
}

//Function Number: 75
move_model_after_tick(param_00)
{
	if(param_00 == 0)
	{
		var_01 = level.radiation_extraction_interaction.origin;
		self.angles = level.radiation_extraction_interaction.angles;
		self setmodel("cp_town_radiation_extractor_top");
		self moveto(var_01,1);
	}
	else
	{
		var_01 = self.origin + (0,0,var_01 * 0.666);
		self moveto(var_01,0.5);
	}

	scripts\common\utility::play_sound_in_space("town_radiation_extractor_tick_up",self.origin + (0,0,5));
}

//Function Number: 76
init_cipher_interaction_structs()
{
	var_00 = scripts\common\utility::getstructarray("cipher_interaction","script_noteworthy");
	if(isdefined(level.cipher_interactions_structs))
	{
		return;
	}

	foreach(var_04, var_02 in var_00)
	{
		var_03 = undefined;
		switch(var_02.name)
		{
			case "cipher_interaction_01":
				var_03 = spawn("script_model",var_02.origin + (0,0,10));
				var_03 setmodel("tag_origin_cipher_letter");
				var_03.angles = var_02.angles + (0,90,0);
				var_03 setscriptablepartstate("cipher_glyph",level.cipherlettera);
				var_02.letter = level.cipherlettera;
				break;

			case "cipher_interaction_02":
				var_03 = spawn("script_model",var_02.origin + (0,0,10));
				var_03 setmodel("tag_origin_cipher_letter");
				var_03.angles = var_02.angles + (0,90,0);
				var_03 setscriptablepartstate("cipher_glyph",level.cipherletterb);
				var_02.letter = level.cipherletterb;
				break;

			case "cipher_interaction_03":
				var_03 = spawn("script_model",var_02.origin + (0,0,10));
				var_03 setmodel("tag_origin_cipher_letter");
				var_03.angles = var_02.angles + (0,90,0);
				var_03 setscriptablepartstate("cipher_glyph",level.cipherletterc);
				var_02.letter = level.cipherletterc;
				break;

			case "cipher_interaction_04":
				var_03 = spawn("script_model",var_02.origin + (0,0,10));
				var_03 setmodel("tag_origin_cipher_letter");
				var_03.angles = var_02.angles + (0,90,0);
				var_03 setscriptablepartstate("cipher_glyph",level.cipherletterd);
				var_02.letter = level.cipherletterd;
				break;

			default:
				break;
		}

		if(isdefined(var_03))
		{
			var_02.model = var_03;
		}

		scripts\cp\_interaction::remove_from_current_interaction_list(var_02);
		var_02.model hide();
		level.cipher_interactions_structs[var_04] = var_02;
		level.cipher_failures = 0;
	}
}

//Function Number: 77
watch_for_damage_on_cipher_letter(param_00)
{
	self endon("death");
	level endon("game_ended");
	self endon("end_this_thread_for_" + self.name);
	for(;;)
	{
		self.model waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(!var_02 scripts\cp\_utility::is_valid_player())
		{
			continue;
		}

		if(isdefined(var_05) && var_05 == "MOD_MELEE")
		{
			self.model.maxhealth = 99999;
			self.model.health = 99999;
			continue;
		}

		if(scripts\common\utility::istrue(self.completed_cipher_letter))
		{
			self.model.maxhealth = 99999;
			self.model.health = 99999;
			continue;
		}

		if(int(param_00) - 1 >= level.chosen_cipher_word.size)
		{
			self.model.maxhealth = 99999;
			self.model.health = 99999;
			continue;
		}

		if(self.current_letter == level.chosen_cipher_word[int(param_00) - 1])
		{
			playfx(scripts\common\utility::getfx("hidden_figure_death"),var_04);
			level thread scripts\common\utility::play_sound_in_space("part_pickup",var_04);
			self.completed_cipher_letter = 1;
			level.cipher_pointer++;
			continue;
		}

		level.cipher_failures++;
		level thread scripts\common\utility::play_sound_in_space("purchase_deny",var_04);
		if(level.cipher_failures >= 6)
		{
			foreach(var_0C in level.cipher_interactions_structs)
			{
				foreach(var_0E in level.players)
				{
					scripts\cp\_interaction::func_E01A(var_0C,var_0E);
					level thread delay_enable_linked_interaction(var_0C,30,var_0E);
					level.cipher_failures = 0;
				}
			}
		}
	}
}

//Function Number: 78
init_paintings_interaction()
{
	var_00 = scripts\common\utility::getstructarray("painting_interaction","script_noteworthy");
	if(isdefined(level.paintings_struct))
	{
		return;
	}

	foreach(var_04, var_02 in var_00)
	{
		var_03 = getent(var_02.target,"targetname");
		var_02.model = var_03;
		level.paintings_struct[var_04] = var_02;
	}
}

//Function Number: 79
init_collector_func()
{
	var_00 = scripts\common\utility::getstructarray("radiation_collector_interaction","script_noteworthy");
	foreach(var_04, var_02 in var_00)
	{
		var_03 = undefined;
		switch(var_02.name)
		{
			case "radiation_collector":
				var_03 = spawn("script_model",var_02.origin);
				var_03 setmodel("cp_town_radiation_extractor");
				var_03.angles = var_02.angles;
				break;

			default:
				break;
		}

		if(isdefined(var_03))
		{
			var_02.model = var_03;
		}

		level.radiation_collector[var_04] = var_02;
	}
}

//Function Number: 80
init_extraction_point_func()
{
	var_00 = scripts\common\utility::getstructarray("radiation_extraction_interaction","script_noteworthy");
	foreach(var_04, var_02 in var_00)
	{
		var_03 = undefined;
		switch(var_02.name)
		{
			case "radiation_extraction_point":
				var_03 = spawn("script_model",var_02.origin);
				var_03 setmodel("cp_town_radiation_extractor_base");
				var_03.angles = var_02.angles;
				break;

			default:
				break;
		}

		if(isdefined(var_03))
		{
			var_02.model = var_03;
		}

		level.radiation_collector[var_04] = var_02;
	}
}

//Function Number: 81
radiation_collection_hint_func(param_00,param_01)
{
	return "";
}

//Function Number: 82
init_skulls_to_shoot()
{
	var_00 = scripts\common\utility::getstructarray("gns_skull","script_noteworthy");
	var_01 = ["skull1","skull2","skull3","skull4","skull5","skull6","skull7","skull8","skull9","skull10"];
	var_02 = 0;
	foreach(var_08, var_04 in var_00)
	{
		if(var_02 >= 5)
		{
			break;
		}

		var_05 = scripts\common\utility::random(var_01);
		var_01 = scripts\common\utility::func_22A9(var_01,var_05);
		var_06 = scripts\common\utility::getstruct(var_05,"targetname");
		var_02++;
		var_07 = undefined;
		switch(var_05)
		{
			case "skull1":
				var_07 = spawn("script_model",var_06.origin);
				var_07 setmodel("zmb_8_bit_price_town");
				var_07.angles = var_06.angles;
				var_06.object_num = 1;
				break;

			case "skull2":
				var_07 = spawn("script_model",var_06.origin);
				var_07 setmodel("zmb_8_bit_price_town");
				var_07.angles = var_06.angles;
				var_06.object_num = 2;
				break;

			case "skull3":
				var_07 = spawn("script_model",(7147,2187,328));
				var_07 setmodel("zmb_8_bit_price_town");
				var_07.angles = (0,168.9,0);
				var_06.object_num = 3;
				break;

			case "skull4":
				var_07 = spawn("script_model",var_06.origin);
				var_07 setmodel("zmb_8_bit_price_town");
				var_07.angles = var_06.angles;
				var_06.object_num = 4;
				break;

			case "skull5":
				var_07 = spawn("script_model",var_06.origin);
				var_07 setmodel("zmb_8_bit_price_town");
				var_07.angles = var_06.angles;
				var_06.object_num = 5;
				break;

			case "skull6":
				var_07 = spawn("script_model",var_06.origin);
				var_07 setmodel("zmb_8_bit_price_town");
				var_07.angles = var_06.angles;
				var_06.object_num = 6;
				break;

			case "skull7":
				var_07 = spawn("script_model",var_06.origin);
				var_07 setmodel("zmb_8_bit_price_town");
				var_07.angles = var_04.angles;
				var_06.object_num = 7;
				break;

			case "skull8":
				var_07 = spawn("script_model",var_06.origin);
				var_07 setmodel("zmb_8_bit_price_town");
				var_07.angles = var_06.angles;
				var_06.object_num = 8;
				break;

			case "skull9":
				var_07 = spawn("script_model",(6785,-2650.5,105));
				var_07 setmodel("zmb_8_bit_price_town");
				var_07.angles = (0,243.3,0);
				var_06.object_num = 9;
				break;

			case "skull10":
				var_07 = spawn("script_model",var_06.origin);
				var_07 setmodel("zmb_8_bit_price_town");
				var_07.angles = var_06.angles;
				var_06.object_num = 10;
				break;

			default:
				break;
		}

		var_07 setcandamage(1);
		var_07.maxhealth = 5;
		var_07.health = 5;
		var_07.var_4CE9 = 0;
		if(isdefined(var_07))
		{
			var_06.model = var_07;
		}

		level.skullbusters_map_skulls[var_08] = var_06;
		level.skullbusters_map_skulls[var_08] thread watch_for_skull_death();
	}
}

//Function Number: 83
load_gns_3_vfx()
{
	level._effect["combo_arc_green"] = loadfx("vfx/iw7/core/zombie/ghosts_n_skulls/vfx_ghost_combo_arc_green.vfx");
	level._effect["combo_arc_red"] = loadfx("vfx/iw7/core/zombie/ghosts_n_skulls/vfx_ghost_combo_arc_red.vfx");
	level._effect["combo_arc_blue"] = loadfx("vfx/iw7/core/zombie/ghosts_n_skulls/vfx_ghost_combo_arc_blue.vfx");
	level._effect["combo_arc_yellow"] = loadfx("vfx/iw7/core/zombie/ghosts_n_skulls/vfx_ghost_combo_arc_yellow.vfx");
}

//Function Number: 84
cp_town_set_moving_target_color(param_00,param_01)
{
}

//Function Number: 85
determine_color(param_00)
{
	var_01 = scripts\common\utility::array_randomize(param_00);
	level.moving_target_color_based_on_priority = [];
	level.moving_target_color_based_on_priority["low"] = var_01[0];
	level.moving_target_color_based_on_priority["medium"] = var_01[1];
	level.moving_target_color_based_on_priority["high"] = var_01[2];
}

//Function Number: 86
cp_town_should_moving_target_explode(param_00,param_01)
{
	if(!isdefined(level.color_indicator_color))
	{
		return 0;
	}

	if(level.color_indicator_color == "off")
	{
		return 0;
	}

	return param_00.color == level.color_indicator_color;
}

//Function Number: 87
cp_town_hit_wrong_moving_target_func(param_00,param_01,param_02)
{
	level thread scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::activate_red_moving_target(param_01);
}

//Function Number: 88
delay_determine_game_fail()
{
	level endon("game_ended");
	var_00 = 2;
	wait(var_00);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_53BB();
}

//Function Number: 89
town_gns_player_reward_func()
{
	level.unlimited_fnf = 1;
	foreach(var_01 in level.players)
	{
		if(!scripts\common\utility::istrue(level.entered_thru_card))
		{
			var_01 lib_0D2A::func_12D7C("QUARTER_MUNCHER",1);
		}

		var_01 thread scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::give_gns_base_reward(var_01);
	}

	level notify("end_this_thread_of_gns_fnf_card");
}

//Function Number: 90
upgrade_magic_wheel()
{
	level.magic_wheel_upgraded_pap1 = 1;
	if(isdefined(level.current_active_wheel))
	{
		level.current_active_wheel setscriptablepartstate("fx","upgrade");
	}
}

//Function Number: 91
gns3_formation_movement()
{
	level.formation_movements = [];
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_DEB7(1,::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_731A);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_DEB7(2,::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_731B);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_DEB7(3,::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_731C);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_DEB7(4,::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_731D);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_DEB7(5,::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_731E);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_DEB7(6,::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_731F);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_DEB7(7,::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_7320);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_DEB7(8,::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_7321);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_DEB7(9,::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_7322);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_DEB7(10,::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_7323);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_DEB7(11,::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_7324);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_DEB7(12,::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_7325);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_DEB7(13,::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_7326);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_DEB7(14,::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_7327);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_DEB7(15,::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_7328);
}

//Function Number: 92
register_ghost_form()
{
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(1,1);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2,2);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2,3);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2,4);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(1,5);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2,6);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2,7);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2,8);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2,9);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2,10);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2,11);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2,12);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3,13);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3,14);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3,15);
}

//Function Number: 93
register_waves_movement()
{
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_moving_target_wave(1,1,2,0.7);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_moving_target_wave(2,1,2,0.7);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_moving_target_wave(3,2,4,0.7);
	level.available_formations = undefined;
	level.formation_movements = undefined;
}

//Function Number: 94
load_cp_town_ghost_exp_vfx()
{
	level._effect["ghost_explosion_death_red"] = loadfx("vfx/iw7/core/zombie/ghosts_n_skulls/vfx_zmb_ghost_imp_red.vfx");
	level._effect["ghost_explosion_death_yellow"] = loadfx("vfx/iw7/core/zombie/ghosts_n_skulls/vfx_zmb_ghost_imp_yellow.vfx");
	level._effect["ghost_explosion_death_blue"] = loadfx("vfx/iw7/core/zombie/ghosts_n_skulls/vfx_zmb_ghost_imp_blue.vfx");
	level._effect["ghost_explosion_death_white"] = loadfx("vfx/iw7/core/zombie/ghosts_n_skulls/vfx_zmb_ghost_imp_white.vfx");
	level._effect["sb_quest_item_pickup"] = loadfx("vfx/iw7/core/zombie/vfx_zom_souvenir_pickup.vfx");
}

//Function Number: 95
activate_gns_platforms()
{
	var_00 = scripts\common\utility::array_randomize(["up_down","up_down","forward_backward","forward_backward"]);
	var_01 = scripts\common\utility::array_randomize(["green","yellow","blue","red"]);
	foreach(var_04, var_03 in var_01)
	{
		level thread activate_platform_color(var_03,var_00[var_04]);
	}
}

//Function Number: 96
town_gns_start_func()
{
	record_vision_set();
	activate_gns_platforms();
	activate_death_floor();
	activate_color_indicator();
}

//Function Number: 97
town_gns_end_func()
{
	restore_vision_set();
	deactivate_platforms();
	deactivate_death_floor();
}

//Function Number: 98
record_vision_set()
{
	level.pre_gns_vision_set_override = level.var_13445;
	level.var_13445 = "cp_zmb_ghost_path";
}

//Function Number: 99
restore_vision_set()
{
	level.var_13445 = level.pre_gns_vision_set_override;
}

//Function Number: 100
activate_death_floor()
{
	var_00 = getent("skull_hop_death_floor","targetname");
	var_00 thread death_floor_player_monitor(var_00);
}

//Function Number: 101
deactivate_death_floor()
{
	var_00 = getent("skull_hop_death_floor","targetname");
	var_00 notify("stop_death_floor");
}

//Function Number: 102
activate_color_indicator()
{
	var_00 = [(-8222,2421,-2090),(-6356,2402,-2090)];
	level.skull_hop_color_indicators = [];
	foreach(var_02 in var_00)
	{
		var_03 = spawn("script_model",var_02);
		var_03 setmodel("crab_boss_origin");
		level.skull_hop_color_indicators[level.skull_hop_color_indicators.size] = var_03;
	}
}

//Function Number: 103
deactivate_color_indicator()
{
	kill_color_indicator_manager();
	foreach(var_01 in level.skull_hop_color_indicators)
	{
		var_01 delete();
	}
}

//Function Number: 104
update_color_indicator_color(param_00)
{
	level.color_indicator_color = param_00;
	foreach(var_02 in level.skull_hop_color_indicators)
	{
		var_02 setscriptablepartstate("skull_hop_indicator",param_00);
	}
}

//Function Number: 105
death_floor_player_monitor(param_00)
{
	param_00 endon("stop_death_floor");
	for(;;)
	{
		param_00 waittill("trigger",var_01);
		if(isplayer(var_01))
		{
			scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_1162C(var_01);
			var_02 = scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_77CF();
			if(isdefined(var_02))
			{
				level thread scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::activate_red_moving_target(var_02);
			}
		}
	}
}

//Function Number: 106
deactivate_platforms()
{
	level notify("stop_GnS_platforms");
	var_00 = ["blue","red","green","yellow"];
	foreach(var_02 in var_00)
	{
		var_03 = getent(var_02 + "_platform","targetname");
		var_04 = getent(var_02 + "_platform_trigger","targetname");
		var_03.origin = var_03.var_C725;
		var_04.origin = var_04.var_C725;
	}
}

//Function Number: 107
activate_platform_color(param_00,param_01)
{
	level endon("game_ended");
	level endon("stop_GnS_platforms");
	var_02 = 48;
	var_03 = 32;
	var_04 = 64;
	var_05 = getent(param_00 + "_platform","targetname");
	var_06 = getent(param_00 + "_platform_trigger","targetname");
	var_05.origin = var_05.var_C725;
	var_06.origin = var_06.var_C725;
	var_07 = var_04 * scripts\common\utility::func_116D7(randomintrange(0,100) > 5,1,-1);
	var_08 = randomfloatrange(var_03,var_02);
	var_09 = var_04 / var_08;
	if(param_01 == "up_down")
	{
		var_05 moveto(var_05.origin + (0,0,var_07),var_09);
		var_05 waittill("movedone");
		for(;;)
		{
			var_05 moveto(var_05.origin + (0,0,var_07 * -2),var_09);
			var_05 waittill("movedone");
			var_05 moveto(var_05.origin + (0,0,var_07 * 2),var_09);
			var_05 waittill("movedone");
		}

		return;
	}

	var_05 moveto(var_05.origin + (0,var_07,0),var_09);
	var_05 waittill("movedone");
	for(;;)
	{
		var_05 moveto(var_05.origin + (0,var_07 * -2,0),var_09);
		var_05 waittill("movedone");
		var_05 moveto(var_05.origin + (0,var_07 * 2,0),var_09);
		var_05 waittill("movedone");
	}
}

//Function Number: 108
change_cube_color(param_00,param_01)
{
	param_00.color = param_01;
	param_00 setscriptablepartstate("cube",param_01);
}

//Function Number: 109
town_get_fake_ghost_model_func(param_00)
{
	return "fake_zombie_ghost_cube_" + param_00;
}

//Function Number: 110
reveal_moving_target_color(param_00)
{
	param_00 setmodel("zmb_pixel_skull");
	param_00.revealed = 1;
	param_00 setscriptablepartstate("skull_vfx",param_00.color);
}

//Function Number: 111
set_allow_skulls_to_explode(param_00)
{
	level.allow_skulls_to_explode = param_00;
}

//Function Number: 112
get_moving_targets_in_same_subgroup(param_00)
{
	var_01 = [];
	foreach(var_03 in level.var_BD43)
	{
		foreach(var_05 in var_03)
		{
			if(isdefined(var_05) && var_05.subgroup == param_00)
			{
				var_01[var_01.size] = var_05;
			}
		}
	}

	return var_01;
}

//Function Number: 113
all_moving_targets_are_revealed(param_00)
{
	foreach(var_02 in param_00)
	{
		if(var_02.revealed == 0)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 114
explode_moving_targets(param_00,param_01)
{
	var_02 = 1;
	var_03 = get_vfx_start_moving_target(param_00);
	foreach(var_05 in param_00)
	{
		if(var_05 == var_03)
		{
			var_05 thread delay_moving_target_explode(var_05,param_01,var_02);
			continue;
		}

		var_05 thread delay_moving_target_explode(var_05,param_01,var_02,var_03);
	}
}

//Function Number: 115
get_vfx_start_moving_target(param_00)
{
	foreach(var_02 in param_00)
	{
		if(scripts\common\utility::istrue(var_02.vfx_start))
		{
			return var_02;
		}
	}
}

//Function Number: 116
delay_moving_target_explode(param_00,param_01,param_02,param_03)
{
	play_combo_arc_vfx(param_00,param_02,param_03);
	playfx(level._effect["ghost_explosion_death_" + param_00.color],param_00.origin,anglestoforward(param_00.angles),anglestoup(param_00.angles));
	lib_0C2D::remove_moving_target_default(param_00,param_01);
}

//Function Number: 117
play_combo_arc_vfx(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		var_03 = int(param_01 * 20);
		for(var_04 = 0;var_04 < var_03;var_04++)
		{
			var_05 = param_02.origin;
			var_06 = param_00.origin;
			var_07 = var_06 - var_05;
			var_08 = vectortoangles(var_07);
			function_02E0(level._effect["combo_arc_" + param_00.color],var_05,var_08,var_06);
			scripts\common\utility::func_136F7();
		}

		return;
	}

	wait(param_01);
}

//Function Number: 118
adjust_player_exit_gns_pos()
{
	level endon("game_ended");
	wait(5);
	var_00 = scripts\common\utility::getstructarray("ghost_wave_player_end","targetname");
	foreach(var_02 in var_00)
	{
		if(var_02.origin == (-743,2620,906))
		{
			var_02.origin = (-745,2620,906);
			var_02.angles = (0,345,0);
			continue;
		}

		if(var_02.origin == (-743,2572,906))
		{
			var_02.origin = (-771,2598,906);
			var_02.angles = (0,15,0);
			continue;
		}

		if(var_02.origin == (-743,2596,906))
		{
			var_02.origin = (-784,2621,906);
			var_02.angles = (0,355,0);
		}
	}
}

//Function Number: 119
adjust_mahjong_pick_up_pos()
{
	level endon("game_ended");
	wait(5);
	var_00 = scripts\common\utility::getstructarray("sb_mahjong_tile","targetname");
	foreach(var_02 in var_00)
	{
		if(var_02.origin == (1393,816,801))
		{
			var_02.origin = (1040,568,790.6);
			var_02.angles = (7,135,-1);
		}
	}
}

//Function Number: 120
reactivate_skullbuster_cabinet()
{
	if(!lib_0D52::quest_line_exist("reactivateghost"))
	{
		var_00 = getomnvar("zm_num_ghost_n_skull_coin");
		if(isdefined(var_00) && var_00 < 5)
		{
			return;
		}

		lib_0D52::func_DED3("reactivateghost",0,::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::reactivate_cabinet,::shoot_the_machine,::complete_shoot_the_machine,::debug_shoot_the_machine);
		lib_0D52::func_DED3("reactivateghost",1,::func_2B53,::func_135F6,::func_447F,::func_4F30);
	}

	level thread lib_0D52::func_10CEE("reactivateghost");
}

//Function Number: 121
init_weeping_angels_note()
{
	var_00 = scripts\common\utility::getstructarray("weeping_angels_struct","script_noteworthy");
	level.weeping_angels_note = [];
	foreach(var_04, var_02 in var_00)
	{
		var_03 = spawn("script_model",var_02.origin + (0,0,0.05));
		var_03.angles = var_02.angles;
		var_03 setmodel("cp_town_paper_note_02");
		var_03 setcandamage(1);
		var_03.maxhealth = 5;
		var_03.health = 5;
		if(isdefined(var_03))
		{
			var_02.model = var_03;
		}

		var_02.model hide();
		level.weeping_angels_note[var_04] = var_02;
	}
}

//Function Number: 122
watch_for_damage_on_struct()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self.model waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(!isplayer(var_01))
		{
			continue;
		}

		if(!var_01 scripts\cp\_utility::is_valid_player())
		{
			continue;
		}

		if(!scripts\common\utility::istrue(level.completed_cipher))
		{
			continue;
		}

		if(isdefined(var_04) && var_04 != "MOD_MELEE")
		{
			continue;
		}

		playfx(scripts\common\utility::getfx("hidden_figure_death"),var_03);
		var_01 playlocalsound("part_pickup");
		self.model delete();
		level notify("weeping_angels_note_read");
	}
}

//Function Number: 123
init()
{
	var_00 = spawnstruct();
	var_00.var_11901 = 40;
	var_00.var_AC71 = 40;
	var_00.var_17B = &"COOP_CRAFTABLES_PICKUP";
	var_00.var_CC28 = &"COOP_CRAFTABLES_PLACE";
	var_00.var_38E3 = &"COOP_CRAFTABLES_CANNOT_PLACE";
	var_00.var_CC0A = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
	var_00.var_74BF = &"ZOMBIE_CRAFTING_SOUVENIRS_DETONATE";
	var_00.var_9F43 = 0;
	var_00.var_CC22 = 30;
	var_00.var_CC25 = 16;
	var_00.var_3AA7 = (0,0,35);
	var_00.var_3AA6 = (0,-90,0);
	var_00.var_B91A = "cp_town_radiation_extractor";
	var_00.var_B924 = "cp_town_radiation_extractor";
	var_00.var_B925 = "cp_town_radiation_extractor";
	level.rad_extractor_settings = [];
	level.rad_extractor_settings["crafted_rad_extractor"] = var_00;
}

//Function Number: 124
func_82B8(param_00,param_01)
{
	param_01.var_A039 = "crafted_rad_extractor";
	param_01 thread func_13932();
	param_01 notify("new_power","crafted_rad_extractor");
	param_01 setclientomnvar("zom_crafted_weapon",3);
	param_01 thread scripts\cp\_utility::func_1308C(param_01,"iw7_pickup_zm");
	scripts\cp\_utility::func_F313("crafted_rad_extractor",::func_82B8,param_01);
}

//Function Number: 125
func_13932()
{
	self endon("disconnect");
	self endon("death");
	self notify("craft_dpad_watcher");
	self endon("craft_dpad_watcher");
	self notifyonplayercommand("pullout_medusa","+actionslot 3");
	for(;;)
	{
		self waittill("pullout_medusa");
		if(scripts\common\utility::istrue(self.var_9D81))
		{
			continue;
		}

		if(scripts\cp\_utility::is_valid_player())
		{
			break;
		}
	}

	thread func_837E(1,40);
}

//Function Number: 126
func_837E(param_00,param_01)
{
	self endon("disconnect");
	scripts\cp\_utility::clearlowermessage("msg_power_hint");
	var_02 = func_49E8(self);
	scripts\cp\_utility::func_E077();
	self.var_3AA5 = var_02;
	var_03 = func_F685(var_02,param_00,param_01);
	self.var_3AA5 = undefined;
	thread scripts\cp\_utility::func_1365D();
	self.var_9D81 = 0;
	if(isdefined(var_02))
	{
		return 1;
	}

	return 0;
}

//Function Number: 127
func_F685(param_00,param_01,param_02,param_03)
{
	self endon("disconnect");
	param_00 func_B543(self,param_01);
	scripts\common\utility::allow_weapon(0);
	self notifyonplayercommand("place_medusa","+attack");
	self notifyonplayercommand("place_medusa","+attack_akimbo_accessible");
	self notifyonplayercommand("cancel_medusa","+actionslot 3");
	if(!level.console)
	{
		self notifyonplayercommand("cancel_medusa","+actionslot 5");
		self notifyonplayercommand("cancel_medusa","+actionslot 6");
		self notifyonplayercommand("cancel_medusa","+actionslot 7");
	}

	for(;;)
	{
		var_04 = scripts\common\utility::func_13734("place_medusa","cancel_medusa","force_cancel_placement");
		if(!isdefined(param_00))
		{
			scripts\common\utility::allow_weapon(1);
			return 1;
		}

		if(!isdefined(var_04))
		{
			var_04 = "force_cancel_placement";
		}

		if(var_04 == "cancel_medusa" || var_04 == "force_cancel_placement")
		{
			if(!param_01 && var_04 == "cancel_medusa")
			{
				continue;
			}

			scripts\common\utility::allow_weapon(1);
			param_00 func_B542();
			if(var_04 != "force_cancel_placement")
			{
				thread func_13932();
			}
			else if(param_01)
			{
				scripts\cp\_utility::func_DFE0(self);
			}

			return 0;
		}

		if(!param_00.var_3872)
		{
			continue;
		}

		if(param_01)
		{
			scripts\cp\_utility::func_DFE0(self);
		}

		param_00 func_B545(param_02,undefined,self);
		scripts\common\utility::allow_weapon(1);
		return 1;
	}
}

//Function Number: 128
func_49E8(param_00)
{
	var_01 = spawnturret("misc_turret",param_00.origin + (0,0,25),"sentry_minigun_mp");
	var_01.angles = param_00.angles;
	var_01.var_222 = param_00;
	var_01.name = "crafted_rad_extractor";
	var_01 hide();
	var_01.var_3AA1 = spawn("script_model",var_01.origin + (0,0,25));
	var_01.var_3AA1 setmodel(level.rad_extractor_settings["crafted_rad_extractor"].var_B91A);
	var_01 method_81F5();
	var_01 method_835B(1);
	var_01 method_830F("sentry_offline");
	var_01 makeunusable();
	var_01 method_8336(param_00);
	var_01 func_B53F(param_00);
	return var_01;
}

//Function Number: 129
func_B53F(param_00)
{
	self.var_3872 = 1;
	func_B544();
}

//Function Number: 130
func_B53C(param_00)
{
	self waittill("death");
	level.rad_extractor_owner = undefined;
	if(!isdefined(self))
	{
		return;
	}

	func_B544();
	self playsound("sentry_explode");
	if(isdefined(self.var_3CBF))
	{
		self.var_3CBF delete();
	}

	scripts\cp\_utility::func_E11E();
	if(isdefined(self))
	{
		playfxontag(scripts\common\utility::getfx("hidden_figure_death"),self,"tag_origin");
		self playsound("sentry_explode_smoke");
		wait(0.1);
		if(isdefined(self))
		{
			self delete();
		}
	}
}

//Function Number: 131
func_B53D()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!var_00 scripts\cp\_utility::is_valid_player())
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_00.var_9D81))
		{
			continue;
		}

		var_00 thread func_837E(0,self.var_AC71);
		self playsound("trap_medusa_pickup");
		scripts\cp\_utility::func_E11E();
		self delete();
	}
}

//Function Number: 132
func_B545(param_00,param_01,param_02)
{
	var_03 = spawn("script_model",self.origin + (0,0,0));
	var_03.angles = self.angles;
	var_03.name = "crafted_rad_extractor";
	self.var_3AA1 delete();
	var_03 solid();
	if(!isdefined(param_02.var_B546))
	{
		param_02.var_B546 = 1;
	}

	var_04 = "cp_town_radiation_extractor";
	var_03 setmodel(var_04);
	var_03 setcandamage(1);
	var_03.health = 5;
	var_03.maxhealth = 5;
	var_03.var_AC71 = 40;
	self.var_3A9D method_80F3();
	self.var_3A9D = undefined;
	param_02.var_9D81 = 0;
	var_03.var_222 = param_02;
	if(function_010F(var_03.origin,level.pool_placement_volume))
	{
		level thread radiation_extractor_after_pool_part(var_03.origin);
		level.pool_extraction_fx = spawnfx(level._effect["pool_radiation"],var_03.origin + (0,0,3));
		triggerfx(level.pool_extraction_fx);
		level notify("placed_extractor_in_pool");
		scripts\cp\_interaction::remove_from_current_interaction_list(level.radiation_extraction_interaction);
		level.medusa_after_placed = var_03;
		func_B544();
	}
	else
	{
		var_03 thread func_B541(param_00);
	}

	self notify("placed");
	self delete();
}

//Function Number: 133
func_B542()
{
	self.var_3A9D method_80F3();
	if(isdefined(self.var_222))
	{
		self.var_222.var_9D81 = 0;
	}

	self.var_3AA1 delete();
	self delete();
}

//Function Number: 134
func_B543(param_00,param_01)
{
	self setmodel(level.rad_extractor_settings["crafted_rad_extractor"].var_B924);
	self method_8335(param_00);
	self setcandamage(0);
	self.var_3A9D = param_00;
	param_00.var_9D81 = 1;
	if(param_01)
	{
		self.var_6DEC = 1;
	}

	param_00 thread scripts\cp\_utility::func_12E3F(self,self.var_3AA1,level.rad_extractor_settings["crafted_rad_extractor"]);
	thread scripts\cp\_utility::func_A025(param_00);
	thread scripts\cp\_utility::func_A026(param_00);
	thread scripts\cp\_utility::func_A027(param_00);
	func_B544();
	self notify("carried");
}

//Function Number: 135
func_B541(param_00,param_01)
{
	self setcursorhint("HINT_NOICON");
	self sethintstring(level.rad_extractor_settings["crafted_rad_extractor"].var_17B);
	self makeusable();
	self method_84A7("tag_fx");
	self method_84A5(120);
	self method_84A2(96);
	thread medusa_watch_for_player_melee(self.var_222);
	thread func_B53C(self.var_222);
	thread scripts\cp\_utility::func_A021("medusa_handleOwner");
	thread scripts\cp\_utility::func_A030(param_00,level.rad_extractor_settings["crafted_rad_extractor"].var_11901);
	thread func_B53D();
	scripts\cp\_utility::func_1861();
}

//Function Number: 136
medusa_watch_for_player_melee(param_00)
{
	self.health = 5;
	self.maxhealth = 5;
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(!isplayer(var_02))
		{
			continue;
		}

		if(var_02 != param_00)
		{
			continue;
		}

		if(!var_02 scripts\cp\_utility::is_valid_player())
		{
			continue;
		}

		if(isdefined(var_05) && var_05 != "MOD_MELEE")
		{
			self.health = 5;
			self.maxhealth = 5;
			var_02 playlocalsound("perk_machine_deny");
			continue;
		}

		if(!scripts\common\utility::istrue(var_02.triggered_rad_extractor_device))
		{
			var_02.triggered_rad_extractor_device = 1;
			self.health = 5;
			self.maxhealth = 5;
			var_02 thread scripts\cp\maps\cp_town\cp_town::update_special_mode_for_player(var_02);
		}
	}
}

//Function Number: 137
func_B544()
{
	self makeunusable();
	scripts\cp\_utility::func_E11E();
}

//Function Number: 138
give_crafted_rad_extractor(param_00,param_01)
{
	param_01 thread func_13932();
	param_01 notify("new_power","crafted_rad_extractor");
	param_01 setclientomnvar("zom_crafted_weapon",16);
	param_01 thread scripts\cp\_utility::func_1308C(param_01,"iw7_pickup_zm");
	scripts\cp\_utility::func_F313("crafted_rad_extractor",::give_crafted_rad_extractor,param_01);
}

//Function Number: 139
radiation_extractor_after_pool_part(param_00)
{
	level.radiation_extraction_interaction.origin = param_00;
	level.radiation_extractor.origin = param_00;
	playfx(scripts\common\utility::getfx("hidden_figure_death"),param_00);
	scripts\common\utility::play_sound_in_space("part_pickup",param_00);
	scripts\cp\_interaction::add_to_current_interaction_list(level.radiation_extraction_interaction);
}

//Function Number: 140
removememorystructonconnect(param_00)
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_01);
		var_01 thread removememorystructswhenvalid(param_00,var_01);
	}
}

//Function Number: 141
removememorystructswhenvalid(param_00,param_01)
{
	while(!isdefined(param_01.var_55BB))
	{
		scripts\common\utility::func_136F7();
	}

	scripts\cp\_interaction::func_E01A(param_00,param_01);
	param_01 thread scripts\cp\maps\cp_town\cp_town::update_special_mode_for_player(param_01);
}

//Function Number: 142
setup_hidden_figure_models(param_00,param_01)
{
	scripts\cp\maps\cp_town\cp_town::addtopersonalinteractionlist(param_00);
	switch(param_01)
	{
		case "figure_4":
		case "figure_3":
		case "figure_2":
		case "figure_1":
			param_00.var_FEF1 = 0;
			param_00.player_who_shot_figure = undefined;
			break;
	}
}

//Function Number: 143
mem_object_hint(param_00,param_01)
{
	return "";
}

//Function Number: 144
mem_object_func(param_00,param_01)
{
}

//Function Number: 145
activatefiguredamage(param_00,param_01,param_02)
{
	level notify(param_00.script_noteworthy + "_" + param_01.name);
	level endon(param_00.script_noteworthy + "_" + param_01.name);
	level endon("game_ended");
	param_01 endon("disconnect");
	param_01 endon("last_stand");
	level endon("end_hidden_figures_sequence_for_" + param_01.name);
	param_02 endon("p_ent_reset");
	if(!isdefined(param_02))
	{
		return;
	}

	param_02.health = 5;
	param_02.maxhealth = 5;
	param_02 setcandamage(1);
	param_02 endon("end_thread_for_" + param_02.model);
	for(;;)
	{
		param_02 waittill("damage",var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C);
		if(!isplayer(var_04))
		{
			continue;
		}

		if(var_04 != param_01)
		{
			continue;
		}

		if(!var_04 scripts\cp\_utility::is_valid_player())
		{
			continue;
		}

		if(scripts\common\utility::istrue(param_02.got_hit_by_player))
		{
			continue;
		}

		if(param_02.health < 0)
		{
			param_02.health = 5;
			param_02.maxhealth = 5;
			param_02 setscriptablepartstate("figure_effect","death");
			level thread scripts\common\utility::play_sound_in_space("town_kill_black_ghost_success",var_06);
			param_02.got_hit_by_player = 1;
			if(isdefined(var_04.hidden_figures_hit))
			{
				var_04.hidden_figures_hit++;
				if(var_04.hidden_figures_hit >= 4)
				{
					var_04 thread scripts\cp\maps\cp_town\cp_town::update_special_mode_for_player(var_04);
				}
			}

			param_02 method_8429(var_04);
			param_02 notify("end_thread_for_" + param_02.model);
		}
	}
}

//Function Number: 146
showhiddenfigurestoplayer(param_00,param_01,param_02,param_03)
{
	param_03 notify("one_instance_of_" + param_01.script_noteworthy + "_for_" + param_03.name);
	param_03 endon("one_instance_of_" + param_01.script_noteworthy + "_for_" + param_03.name);
	param_03 endon("death");
	param_03 endon("disconnect");
	level endon("game_ended");
	level endon("end_hidden_figures_sequence_for_" + param_03.name);
	if(!isdefined(param_03.var_134FD))
	{
		return;
	}

	if(!isdefined(param_01.script_noteworthy))
	{
		return;
	}

	if(!scripts\common\utility::istrue(param_03.triggered_rad_extractor_device))
	{
		return;
	}

	var_04 = 0.5;
	var_05 = 10000;
	if(scripts\common\utility::istrue(param_03.inside_slow_sphere))
	{
		var_04 = 1.5;
		var_05 = -25536;
	}

	var_06 = [];
	var_07 = gettime();
	param_00.got_hit_by_player = 0;
	thread activatefiguredamage(param_01,param_03,param_00);
	param_00 showtoplayer(param_03);
	while(gettime() <= var_07 + var_05)
	{
		var_08 = randomintrange(-200,200);
		var_09 = randomintrange(-200,200);
		var_0A = randomintrange(90,200);
		param_03.figure_one_offset = (var_08,var_09,var_0A);
		var_0B = randomintrange(-200,200);
		var_0C = randomintrange(-200,200);
		var_0D = randomintrange(90,200);
		param_03.figure_two_offset = (var_0B,var_0C,var_0D);
		var_0E = randomintrange(-200,200);
		var_0F = randomintrange(-200,200);
		var_10 = randomintrange(90,200);
		param_03.figure_three_offset = (var_0E,var_0F,var_10);
		var_11 = randomintrange(-200,200);
		var_12 = randomintrange(-200,200);
		var_13 = randomintrange(90,200);
		param_03.figure_four_offset = (var_11,var_12,var_13);
		switch(param_01.script_noteworthy)
		{
			case "figure_1":
				param_01.playeroffset[param_03.name] = param_03.origin + param_03.figure_one_offset;
				param_00 setmodel("tag_origin_hidden_figure");
				param_00 setscriptablepartstate("figure_effect","active");
				param_00.origin = param_03.origin + param_03.figure_one_offset;
				break;

			case "figure_2":
				param_01.playeroffset[param_03.name] = param_03.origin + param_03.figure_two_offset;
				param_00 setmodel("tag_origin_hidden_figure");
				param_00 setscriptablepartstate("figure_effect","active");
				param_00.origin = param_03.origin + param_03.figure_two_offset;
				break;

			case "figure_3":
				param_01.playeroffset[param_03.name] = param_03.origin + param_03.figure_three_offset;
				param_00 setmodel("tag_origin_hidden_figure");
				param_00 setscriptablepartstate("figure_effect","active");
				param_00.origin = param_03.origin + param_03.figure_three_offset;
				break;

			case "figure_4":
				param_01.playeroffset[param_03.name] = param_03.origin + param_03.figure_four_offset;
				param_00 setmodel("tag_origin_hidden_figure");
				param_00 setscriptablepartstate("figure_effect","active");
				param_00.origin = param_03.origin + param_03.figure_four_offset;
				break;
		}

		if(int(distance(param_00.origin,param_03.origin)) <= 120)
		{
			param_03 dodamage(int(param_03.health / 4),param_03.origin);
		}

		param_00.angles = vectortoangles(param_03.origin - param_00.origin);
		param_01.model = param_00;
		wait(var_04);
	}

	param_00 setscriptablepartstate("figure_effect","neutral");
	scripts\common\utility::func_136F7();
	param_00 setscriptablepartstate("figure_effect","death");
	param_03.triggered_rad_extractor_device = 0;
	level notify("end_hidden_figures_sequence_for_" + param_03.name);
}

//Function Number: 147
init_fig1()
{
	level.special_mode_activation_funcs["figure_1"] = ::showhiddenfigurestoplayer;
	level.normal_mode_activation_funcs["figure_1"] = ::showhiddenfigurestoplayer;
	level.hidden_figures[0] = spawnstruct();
	level.hidden_figures[0].origin = (4058,-4359,76);
	level.hidden_figures[0].var_D776 = 0;
	level.hidden_figures[0].var_E1B9 = 0;
	level.hidden_figures[0].name = "hidden_figure_objects";
	level.hidden_figures[0].script_noteworthy = "figure_1";
	level.hidden_figures[0].var_EE79 = "default";
	level.hidden_figures[0].var_336 = "interaction";
	var_00 = scripts\common\utility::getstructarray("figure_1","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02.var_86A2 = "locOverride";
		var_02.playeroffset = [];
		setup_hidden_figure_models(var_02,"figure_1");
	}
}

//Function Number: 148
init_fig2()
{
	level.special_mode_activation_funcs["figure_2"] = ::showhiddenfigurestoplayer;
	level.normal_mode_activation_funcs["figure_2"] = ::showhiddenfigurestoplayer;
	level.hidden_figures[1] = spawnstruct();
	level.hidden_figures[1].origin = (4058,-4359,76);
	level.hidden_figures[1].var_D776 = 0;
	level.hidden_figures[1].var_E1B9 = 0;
	level.hidden_figures[1].name = "hidden_figure_objects";
	level.hidden_figures[1].script_noteworthy = "figure_2";
	level.hidden_figures[1].var_EE79 = "default";
	level.hidden_figures[1].var_336 = "interaction";
	var_00 = scripts\common\utility::getstructarray("figure_2","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02.var_86A2 = "locOverride";
		var_02.playeroffset = [];
		setup_hidden_figure_models(var_02,"figure_2");
	}
}

//Function Number: 149
init_fig3()
{
	level.special_mode_activation_funcs["figure_3"] = ::showhiddenfigurestoplayer;
	level.normal_mode_activation_funcs["figure_3"] = ::showhiddenfigurestoplayer;
	level.hidden_figures[2] = spawnstruct();
	level.hidden_figures[2].origin = (4058,-4359,76);
	level.hidden_figures[2].var_D776 = 0;
	level.hidden_figures[2].var_E1B9 = 0;
	level.hidden_figures[2].name = "hidden_figure_objects";
	level.hidden_figures[2].script_noteworthy = "figure_3";
	level.hidden_figures[2].var_EE79 = "default";
	level.hidden_figures[2].var_336 = "interaction";
	var_00 = scripts\common\utility::getstructarray("figure_3","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02.var_86A2 = "locOverride";
		var_02.playeroffset = [];
		setup_hidden_figure_models(var_02,"figure_3");
	}
}

//Function Number: 150
init_fig4()
{
	level.special_mode_activation_funcs["figure_4"] = ::showhiddenfigurestoplayer;
	level.normal_mode_activation_funcs["figure_4"] = ::showhiddenfigurestoplayer;
	level.hidden_figures[3] = spawnstruct();
	level.hidden_figures[3].origin = (4058,-4359,76);
	level.hidden_figures[3].var_D776 = 0;
	level.hidden_figures[3].var_E1B9 = 0;
	level.hidden_figures[3].name = "hidden_figure_objects";
	level.hidden_figures[3].script_noteworthy = "figure_4";
	level.hidden_figures[3].var_EE79 = "default";
	level.hidden_figures[3].var_336 = "interaction";
	var_00 = scripts\common\utility::getstructarray("figure_4","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02.var_86A2 = "locOverride";
		var_02.playeroffset = [];
		setup_hidden_figure_models(var_02,"figure_4");
	}
}