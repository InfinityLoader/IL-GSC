/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_disco\cp_disco_ghost_activation.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 170
 * Decompile Time: 8420 ms
 * Timestamp: 10/27/2023 12:03:59 AM
*******************************************************************/

//Function Number: 1
init_ghost_n_skull_3_quest()
{
	lib_0D52::func_DED3("ghostThree",0,::func_2B53,::clean_arcade_cabinet,::complete_clean_arcade_cabinet,::debug_clean_arcade_cabinet);
	lib_0D52::func_DED3("ghostThree",1,::func_2B53,::make_winning_mahjong_hand,::complete_make_winning_mahjong_hand,::debug_make_winning_mahjong_hand);
	lib_0D52::func_DED3("ghostThree",2,::func_2B53,::write_1_9_7_2,::complete_write_1_9_7_2,::debug_write_1_9_7_2);
	lib_0D52::func_DED3("ghostThree",3,::func_2B53,::do_sky_steps,::complete_sky_steps,::debug_do_sky_steps);
	lib_0D52::func_DED3("ghostThree",4,::func_2B53,::grab_skull_in_front_train,::complete_grab_skull_in_front_train,::debug_grab_skull_in_front_train);
	lib_0D52::func_DED3("ghostThree",5,::func_2B53,::call_service_number,::complete_call_service_number,::debug_call_service_number);
	lib_0D52::func_DED3("ghostThree",6,::func_2B53,::func_135F6,::func_447F,::func_4F30);
}

//Function Number: 2
func_2B53()
{
}

//Function Number: 3
clean_arcade_cabinet()
{
	delete_dirty_glass();
	level.sb_quest_cleaner = make_cleaning_item_to_collect("sb_quest_cleaner","p7_bottle_plastic_cleaner_dmg","picked_up_cleaner");
	level.sb_quest_towel = make_cleaning_item_to_collect("sb_quest_towel","towel_crumpled_01","picked_up_towel");
	level scripts\common\utility::func_137AC("picked_up_cleaner","picked_up_towel");
	wait_for_player_clean_up_arcade_cabinet();
}

//Function Number: 4
make_cleaning_item_to_collect(param_00,param_01,param_02)
{
	var_03 = scripts\common\utility::getstructarray(param_00,"targetname");
	var_04 = scripts\common\utility::random(var_03);
	var_05 = spawn("script_model",var_04.origin);
	var_05 setmodel(param_01);
	var_05.angles = var_04.angles;
	var_05 thread player_pick_up_monitor(var_05,param_02);
	return var_05;
}

//Function Number: 5
player_pick_up_monitor(param_00,param_01)
{
	param_00 endon("death");
	for(;;)
	{
		foreach(var_03 in level.players)
		{
			if(player_picking_up_item(var_03,param_00))
			{
				level notify(param_01);
				if(param_00.model == "towel_crumpled_01")
				{
					var_04 = "skullbuster_arcade_pickup_rag";
				}
				else
				{
					var_04 = "skullbuster_arcade_pickup_spraycleaner";
				}

				var_03 playlocalsound(var_04);
				playfx(level._effect["sb_quest_item_pickup"],param_00.origin);
				param_00 delete();
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 6
player_picking_up_item(param_00,param_01)
{
	if(!isplayer(param_00))
	{
		return 0;
	}

	if(!player_within_pick_up_distance(param_00,param_01))
	{
		return 0;
	}

	if(!param_00 usebuttonpressed())
	{
		return 0;
	}

	if(!param_00 method_8409(param_01.origin,65,80))
	{
		return 0;
	}

	if(!sighttracepassed(param_00 geteye(),param_01.origin + (0,0,5),0,param_01))
	{
		return 0;
	}

	return 1;
}

//Function Number: 7
wait_for_player_clean_up_arcade_cabinet()
{
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			if(player_cleaning_up_arcade_cabinet(var_01))
			{
				var_01 playlocalsound("skullbuster_arcade_clean_arcade_machine");
				wait(2);
				return;
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 8
player_cleaning_up_arcade_cabinet(param_00)
{
	var_01 = (-731,2610,900);
	var_02 = (-717,2610,942);
	var_03 = 900;
	if(distance2dsquared(param_00.origin,var_01) > var_03)
	{
		return 0;
	}

	if(!param_00 usebuttonpressed())
	{
		return 0;
	}

	if(!param_00 method_8409(var_02,80,100))
	{
		return 0;
	}

	return 1;
}

//Function Number: 9
player_within_pick_up_distance(param_00,param_01)
{
	if(distance2dsquared(param_01.origin,param_00.origin) <= 2500)
	{
		return 1;
	}

	if(distance2dsquared(param_01.origin,param_00 geteye()) <= 2500)
	{
		return 1;
	}

	return 0;
}

//Function Number: 10
delete_dirty_glass()
{
	var_00 = getent("sb_quest_dirty_glass","targetname");
	var_00 delete();
}

//Function Number: 11
complete_clean_arcade_cabinet()
{
	delete_clean_arcade_cabinet_entities();
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_C127(1);
}

//Function Number: 12
delete_clean_arcade_cabinet_entities()
{
	if(isdefined(level.sb_quest_cleaner))
	{
		level.sb_quest_cleaner delete();
	}

	if(isdefined(level.sb_quest_towel))
	{
		level.sb_quest_towel delete();
	}
}

//Function Number: 13
debug_clean_arcade_cabinet()
{
}

//Function Number: 14
make_winning_mahjong_hand()
{
	var_00 = scripts\common\utility::getstruct("mahjong_set","targetname");
	level thread set_up_mahjong_set(var_00);
	level waittill("mahjong_won_sequence_complete");
}

//Function Number: 15
complete_make_winning_mahjong_hand()
{
	clean_up_all_mahjong();
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_C127(2);
}

//Function Number: 16
debug_make_winning_mahjong_hand()
{
}

//Function Number: 17
set_up_mahjong_set(param_00)
{
	init_current_mahjong_count();
	init_mahjong_set_controlling_struct(param_00);
	var_01 = generate_mahjong_values(get_num_of_missing_tiles());
	var_02 = scripts\common\utility::array_randomize(var_01.starting_hand);
	var_03 = var_01.tiles_for_pick_up;
	set_up_starting_hand(param_00,var_02);
	set_up_tiles_for_pick_up(var_03);
	param_00 thread update_player_monitor(param_00);
	param_00 thread player_interact_monitor(param_00);
}

//Function Number: 18
set_up_starting_hand(param_00,param_01)
{
	for(var_02 = 1;var_02 <= 14;var_02++)
	{
		set_up_mahjong(param_00,var_02,param_01[var_02 - 1]);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 19
player_interact_monitor(param_00)
{
	level endon("winning_mahjong_hand");
	for(;;)
	{
		foreach(var_02 in level.players)
		{
			if(player_interact_with_mahjong_set(var_02,param_00))
			{
				swap_mahjong_tile_with_player_mahjong(var_02.mahjong_struct_currently_looking_at,var_02,1);
				if(check_winning_hand(param_00))
				{
					level thread mahjong_win_sequence(param_00);
					level notify("winning_mahjong_hand");
					continue;
				}

				wait(1);
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 20
mahjong_win_sequence(param_00)
{
	clear_outline_for_all_players(param_00);
	wait(0.5);
	var_01 = spawn("script_model",param_00.origin);
	var_01 setmodel("sb_quest_origin");
	var_01 setscriptablepartstate("vfx","fireworks_sparks");
	playsoundatpos(param_00.origin,"mahjong_success_fireworks");
	wait(3);
	var_01 delete();
	level notify("mahjong_won_sequence_complete");
}

//Function Number: 21
clear_outline_for_all_players(param_00)
{
	foreach(var_02 in level.players)
	{
		for(var_03 = 1;var_03 <= 14;var_03++)
		{
			param_00.mahjong_set[var_03].mahjong_tile hudoutlinedisableforclient(var_02);
		}
	}
}

//Function Number: 22
check_winning_hand(param_00)
{
	if(!check_all_mahjong_filled(param_00))
	{
		return 0;
	}

	if(!check_streak_or_triplet(1,param_00))
	{
		return 0;
	}

	if(!check_streak_or_triplet(4,param_00))
	{
		return 0;
	}

	if(!check_streak_or_triplet(7,param_00))
	{
		return 0;
	}

	if(!check_streak_or_triplet(10,param_00))
	{
		return 0;
	}

	if(!check_pair(13,param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 23
check_all_mahjong_filled(param_00)
{
	for(var_01 = 1;var_01 <= 14;var_01++)
	{
		if(param_00.mahjong_set[var_01].mahjong_value == "")
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 24
check_streak_or_triplet(param_00,param_01)
{
	if(check_streak(param_00,param_01))
	{
		return 1;
	}

	if(check_triplet(param_00,param_01))
	{
		return 1;
	}

	return 0;
}

//Function Number: 25
check_streak(param_00,param_01)
{
	var_02 = int(param_01.mahjong_set[param_00].mahjong_value);
	var_03 = int(param_01.mahjong_set[param_00 + 1].mahjong_value);
	var_04 = int(param_01.mahjong_set[param_00 + 2].mahjong_value);
	if(var_03 == var_02 + 1 && var_04 == var_03 + 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 26
check_triplet(param_00,param_01)
{
	var_02 = int(param_01.mahjong_set[param_00].mahjong_value);
	var_03 = int(param_01.mahjong_set[param_00 + 1].mahjong_value);
	var_04 = int(param_01.mahjong_set[param_00 + 2].mahjong_value);
	if(var_03 == var_02 && var_04 == var_03)
	{
		return 1;
	}

	return 0;
}

//Function Number: 27
check_pair(param_00,param_01)
{
	var_02 = int(param_01.mahjong_set[param_00].mahjong_value);
	var_03 = int(param_01.mahjong_set[param_00 + 1].mahjong_value);
	if(var_03 == var_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 28
update_player_monitor(param_00)
{
	level endon("winning_mahjong_hand");
	for(;;)
	{
		foreach(var_02 in level.players)
		{
			update_mahjong_state_for_player(var_02,param_00);
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 29
update_mahjong_state_for_player(param_00,param_01)
{
	if(!player_in_play_space(param_00,param_01))
	{
		if(player_looking_at_any_mahjong_tile(param_00))
		{
			clear_mahjong_state_for_player(param_00);
		}

		return;
	}

	var_02 = get_mahjong_struct_currently_looking_at(param_00,param_01);
	if(isdefined(var_02))
	{
		if(!looking_at_the_same_mahjong(param_00,var_02))
		{
			if(player_looking_at_any_mahjong_tile(param_00))
			{
				clear_mahjong_state_for_player(param_00);
			}

			set_mahjong_struct_currently_looking_at(param_00,var_02);
		}
	}
}

//Function Number: 30
player_interact_with_mahjong_set(param_00,param_01)
{
	if(!player_in_play_space(param_00,param_01))
	{
		return 0;
	}

	if(!player_looking_at_any_mahjong_tile(param_00))
	{
		return 0;
	}

	if(!param_00 usebuttonpressed())
	{
		return 0;
	}

	return 1;
}

//Function Number: 31
looking_at_the_same_mahjong(param_00,param_01)
{
	return isdefined(param_00.mahjong_struct_currently_looking_at) && param_00.mahjong_struct_currently_looking_at == param_01;
}

//Function Number: 32
player_in_play_space(param_00,param_01)
{
	return function_010F(param_00.origin,param_01.play_area);
}

//Function Number: 33
set_mahjong_struct_currently_looking_at(param_00,param_01)
{
	if(is_empty_mahjong(param_01))
	{
		show_empty_mahjong_for_player(param_00,param_01);
	}
	else
	{
		show_mahjong_outline_for_player(param_00,param_01);
	}

	param_00.mahjong_struct_currently_looking_at = param_01;
}

//Function Number: 34
clear_mahjong_state_for_player(param_00)
{
	var_01 = param_00.mahjong_struct_currently_looking_at;
	if(is_empty_mahjong(var_01))
	{
		clear_empty_mahjong_for_player(param_00,var_01);
	}
	else
	{
		hide_mahjong_outline_for_player(param_00,var_01);
	}

	param_00.mahjong_struct_currently_looking_at = undefined;
}

//Function Number: 35
show_empty_mahjong_for_player(param_00,param_01)
{
	param_01.mahjong_tile setmodel("cp_disco_mahjong_tile_clear");
}

//Function Number: 36
clear_empty_mahjong_for_player(param_00,param_01)
{
	if(any_other_player_looking_at_it(param_00,param_01))
	{
		return;
	}

	param_01.mahjong_tile setmodel("tag_origin");
}

//Function Number: 37
any_other_player_looking_at_it(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(var_03 == param_00)
		{
			continue;
		}

		if(isdefined(var_03.mahjong_struct_currently_looking_at) && var_03.mahjong_struct_currently_looking_at == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 38
show_mahjong_outline_for_player(param_00,param_01)
{
	param_01.mahjong_tile hudoutlineenableforclient(param_00,1,1,0);
}

//Function Number: 39
hide_mahjong_outline_for_player(param_00,param_01)
{
	param_01.mahjong_tile hudoutlinedisableforclient(param_00);
}

//Function Number: 40
player_looking_at_any_mahjong_tile(param_00)
{
	return isdefined(param_00.mahjong_struct_currently_looking_at);
}

//Function Number: 41
is_empty_mahjong(param_00)
{
	return get_mahjong_value(param_00) == "";
}

//Function Number: 42
get_mahjong_value(param_00)
{
	return param_00.mahjong_value;
}

//Function Number: 43
get_mahjong_struct_currently_looking_at(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_01.mahjong_set)
	{
		if(param_00 method_8409(var_04.origin,25,75))
		{
			var_02[var_02.size] = var_04;
		}
	}

	return scripts\common\utility::getclosest(param_00.origin,var_02);
}

//Function Number: 44
generate_mahjong_values(param_00)
{
	var_01 = spawnstruct();
	var_02 = [];
	var_03 = [];
	for(var_04 = 1;var_04 <= 4;var_04++)
	{
		if(coin_flip())
		{
			var_03 = scripts\common\utility::array_combine(var_03,get_random_streak());
			continue;
		}

		var_03 = scripts\common\utility::array_combine(var_03,get_random_triplet());
	}

	var_03 = scripts\common\utility::array_combine(var_03,get_random_pair());
	var_05 = get_index_to_remove(param_00);
	foreach(var_07 in var_05)
	{
		var_02[var_02.size] = var_03[var_07];
		var_03[var_07] = "";
	}

	var_09 = get_additional_num_of_missing_tiles();
	for(var_04 = 0;var_04 < var_09;var_04++)
	{
		var_02[var_02.size] = "" + randomintrange(1,6);
	}

	var_01.starting_hand = var_03;
	var_01.tiles_for_pick_up = var_02;
	return var_01;
}

//Function Number: 45
get_index_to_remove(param_00)
{
	var_01 = [];
	var_02 = [];
	for(var_03 = 0;var_03 < 14;var_03++)
	{
		var_02[var_02.size] = var_03;
	}

	var_02 = scripts\common\utility::array_randomize(var_02);
	for(var_04 = 0;var_04 < param_00;var_04++)
	{
		var_01[var_01.size] = var_02[var_04];
	}

	return var_01;
}

//Function Number: 46
init_current_mahjong_count()
{
	level.current_mahjong_count = [];
	for(var_00 = 1;var_00 <= 5;var_00++)
	{
		level.current_mahjong_count[var_00] = 0;
	}
}

//Function Number: 47
get_least_used_num(param_00)
{
	var_01 = 9999;
	var_02 = -1;
	if(coin_flip())
	{
		for(var_03 = 1;var_03 <= param_00;var_03++)
		{
			if(level.current_mahjong_count[var_03] <= var_01)
			{
				var_01 = level.current_mahjong_count[var_03];
				var_02 = var_03;
			}
		}
	}
	else
	{
		for(var_03 = var_01;var_03 >= 1;var_03--)
		{
			if(level.current_mahjong_count[var_03] <= var_01)
			{
				var_01 = level.current_mahjong_count[var_03];
				var_02 = var_03;
			}
		}
	}

	return var_02;
}

//Function Number: 48
get_random_streak()
{
	var_00 = get_least_used_num(3);
	update_current_mahjong_conunt([var_00,var_00 + 1,var_00 + 2]);
	return [int_to_string(var_00),int_to_string(var_00 + 1),int_to_string(var_00 + 2)];
}

//Function Number: 49
get_random_triplet()
{
	var_00 = get_least_used_num(5);
	update_current_mahjong_conunt([var_00,var_00,var_00]);
	return [int_to_string(var_00),int_to_string(var_00),int_to_string(var_00)];
}

//Function Number: 50
get_random_pair()
{
	var_00 = get_least_used_num(5);
	update_current_mahjong_conunt([var_00,var_00]);
	return [int_to_string(var_00),int_to_string(var_00)];
}

//Function Number: 51
update_current_mahjong_conunt(param_00)
{
	foreach(var_02 in param_00)
	{
		level.current_mahjong_count[var_02]++;
	}
}

//Function Number: 52
coin_flip()
{
	return randomintrange(1,100) > 50;
}

//Function Number: 53
set_up_tiles_for_pick_up(param_00)
{
	level.mahjong_struct_for_pick_up = [];
	var_01 = scripts\common\utility::getstructarray("sb_mahjong_tile","targetname");
	var_01 = scripts\common\utility::array_randomize(var_01);
	foreach(var_05, var_03 in param_00)
	{
		var_04 = var_01[var_05];
		level.mahjong_struct_for_pick_up[level.mahjong_struct_for_pick_up.size] = var_04;
		spawn_mahjong_tile(var_01[var_05],var_03);
		var_04 thread player_use_monitor(var_04);
		scripts\common\utility::func_136F7();
	}
}

//Function Number: 54
player_use_monitor(param_00)
{
	level endon("winning_mahjong_hand");
	for(;;)
	{
		foreach(var_02 in level.players)
		{
			if(player_use_mahjong_struct(param_00,var_02))
			{
				try_play_swap_vfx(param_00,var_02);
				swap_mahjong_tile_with_player_mahjong(param_00,var_02,0);
				var_02 thread mahjong_player_disconnect_monitor(var_02);
				wait(1);
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 55
try_play_swap_vfx(param_00,param_01)
{
	var_02 = get_mahjong_value(param_00);
	var_03 = get_mahjong_tile_on_player(param_01);
	if(var_02 == "" && var_03 == "")
	{
		return;
	}

	playfx(level._effect["sb_quest_item_pickup"],param_00.origin);
}

//Function Number: 56
swap_mahjong_tile_with_player_mahjong(param_00,param_01,param_02)
{
	var_03 = get_mahjong_value(param_00);
	var_04 = get_mahjong_tile_on_player(param_01);
	play_swap_mahjong_sfx(param_00,var_03,var_04,param_02);
	set_mahjong_tile_on_player(param_01,var_03);
	set_mahjong_value(param_00,var_04,param_02);
}

//Function Number: 57
play_swap_mahjong_sfx(param_00,param_01,param_02,param_03)
{
	if(param_01 != "" && param_02 == "" && param_03 == 1)
	{
		playsoundatpos(param_00.origin,"mahjong_pickup_existing_tile");
		return;
	}

	if(param_01 != "" && param_02 == "" && !param_03 == 1)
	{
		playsoundatpos(param_00.origin,"mahjong_pickup_tile_exlpo");
		return;
	}

	if(param_01 != "" && param_02 != "")
	{
		playsoundatpos(param_00.origin,"mahjong_pickup_existing_tile");
		return;
	}

	if(param_01 == "" && param_02 != "")
	{
		playsoundatpos(param_00.origin,"mahjong_place_tile");
		return;
	}
}

//Function Number: 58
get_mahjong_tile_on_player(param_00)
{
	if(!isdefined(param_00.mahjong_tile_on_me))
	{
		param_00.mahjong_tile_on_me = "";
	}

	return param_00.mahjong_tile_on_me;
}

//Function Number: 59
set_mahjong_tile_on_player(param_00,param_01)
{
	param_00.mahjong_tile_on_me = param_01;
}

//Function Number: 60
player_use_mahjong_struct(param_00,param_01)
{
	if(distance2dsquared(param_00.origin,param_01.origin) > 6400)
	{
		return 0;
	}

	if(!param_01 usebuttonpressed())
	{
		return 0;
	}

	if(!param_01 method_8409(param_00.origin,55,75))
	{
		return 0;
	}

	return 1;
}

//Function Number: 61
set_up_mahjong(param_00,param_01,param_02)
{
	var_03 = get_mahjong_struct_at_index(param_00,param_01);
	spawn_mahjong_tile(var_03,param_02);
}

//Function Number: 62
spawn_mahjong_tile(param_00,param_01)
{
	var_02 = spawn("script_model",param_00.origin);
	var_02.angles = param_00.angles;
	param_00.mahjong_tile = var_02;
	set_mahjong_value(param_00,param_01);
}

//Function Number: 63
set_mahjong_value(param_00,param_01,param_02)
{
	param_00.mahjong_value = param_01;
	param_00.mahjong_tile setmodel(get_mahjong_model(param_01,param_02));
}

//Function Number: 64
get_mahjong_model(param_00,param_01)
{
	switch(param_00)
	{
		case "":
			if(scripts\common\utility::istrue(param_01))
			{
				return "cp_disco_mahjong_tile_clear";
			}
			else
			{
				return "tag_origin";
			}
	
			break;

		case "1":
			return "cp_disco_mahjong_tile_01";

		case "2":
			return "cp_disco_mahjong_tile_02";

		case "3":
			return "cp_disco_mahjong_tile_03";

		case "4":
			return "cp_disco_mahjong_tile_04";

		case "5":
			return "cp_disco_mahjong_tile_05";
	}
}

//Function Number: 65
init_mahjong_set_controlling_struct(param_00)
{
	var_01 = [];
	var_02 = scripts\common\utility::getstructarray(param_00.target,"targetname");
	foreach(var_04 in var_02)
	{
		var_05 = int(var_04.script_noteworthy);
		var_01[var_05] = var_04;
	}

	param_00.mahjong_set = var_01;
	var_07 = getentarray(param_00.target,"targetname");
	foreach(var_09 in var_07)
	{
		switch(var_09.script_noteworthy)
		{
			case "play_area":
				param_00.play_area = var_09;
				break;
		}
	}
}

//Function Number: 66
get_mahjong_struct_at_index(param_00,param_01)
{
	return param_00.mahjong_set[param_01];
}

//Function Number: 67
int_to_string(param_00)
{
	return "" + param_00;
}

//Function Number: 68
get_num_of_missing_tiles()
{
	return 3 + level.players.size - 1;
}

//Function Number: 69
get_additional_num_of_missing_tiles()
{
	return 2 + level.players.size - 1;
}

//Function Number: 70
clean_up_all_mahjong()
{
	var_00 = scripts\common\utility::getstruct("mahjong_set","targetname");
	if(isdefined(var_00.mahjong_set))
	{
		for(var_01 = 1;var_01 <= 14;var_01++)
		{
			if(isdefined(var_00.mahjong_set[var_01].mahjong_tile))
			{
				var_00.mahjong_set[var_01].mahjong_tile delete();
			}
		}
	}

	if(isdefined(level.mahjong_struct_for_pick_up))
	{
		foreach(var_03 in level.mahjong_struct_for_pick_up)
		{
			if(isdefined(var_03.mahjong_tile))
			{
				var_03.mahjong_tile delete();
			}
		}
	}
}

//Function Number: 71
mahjong_player_disconnect_monitor(param_00)
{
	level endon("winning_mahjong_hand");
	param_00 notify("mahjong_player_disconnect_monitor");
	param_00 endon("mahjong_player_disconnect_monitor");
	param_00 waittill("disconnect");
	if(param_00.mahjong_tile_on_me != "")
	{
		var_01 = get_available_mahjong_struct_for_pick_up();
		set_mahjong_value(var_01,param_00.mahjong_tile_on_me,0);
	}
}

//Function Number: 72
get_available_mahjong_struct_for_pick_up()
{
	foreach(var_01 in level.mahjong_struct_for_pick_up)
	{
		if(var_01.mahjong_value == "")
		{
			return var_01;
		}
	}
}

//Function Number: 73
write_1_9_7_2()
{
	var_00 = ["1","9","7","2"];
	foreach(var_02 in var_00)
	{
		wait_player_write_number(var_02);
	}
}

//Function Number: 74
wait_player_write_number(param_00)
{
	var_01 = scripts\common\utility::getstruct("sb_writing_quest_" + param_00,"targetname");
	set_up_controlling_struct(var_01);
	set_up_timer_candles(var_01);
	for(;;)
	{
		set_should_detect_damage(var_01,1);
		reset_tiles_hit_array(var_01);
		var_01 thread tiles_hit_listener(var_01,param_00);
		var_02 = var_01 scripts\common\utility::func_13734("write_number_success","write_number_fail","write_number_timeout");
		clean_all_flame_vfx(var_01);
		if(var_02 == "write_number_success")
		{
			thread scripts\common\utility::play_sound_in_space("skullbuster_number_success_plr",var_01.origin);
			clean_all_candles(var_01);
			clean_damage_monitor(var_01);
			wait(0.3);
			clean_all_cube_vfx(var_01);
			play_success_vfx(var_01);
			return;
		}
		else
		{
			thread scripts\common\utility::play_sound_in_space("skullbuster_number_fail_buzzer_plr",var_01.origin);
			set_should_detect_damage(var_01,0);
			hide_all_candles(var_01);
			clean_all_cube_vfx(var_01);
			func_13650();
			show_all_candles(var_01);
		}
	}
}

//Function Number: 75
reset_tiles_hit_array(param_00)
{
	param_00.tiles_hit = [];
}

//Function Number: 76
play_success_vfx(param_00)
{
	playfx(level._effect["write_1972_success"],param_00.origin,anglestoforward(param_00.angles),anglestoup(param_00.angles));
}

//Function Number: 77
clean_damage_monitor(param_00)
{
	if(isdefined(param_00.var_4D07))
	{
		param_00.var_4D07 delete();
	}
}

//Function Number: 78
clean_all_candles(param_00)
{
	if(isdefined(param_00.timer_structs))
	{
		foreach(var_02 in param_00.timer_structs)
		{
			if(isdefined(var_02.candle))
			{
				var_02.candle delete();
			}
		}
	}
}

//Function Number: 79
clean_all_flame_vfx(param_00)
{
	if(isdefined(param_00.timer_structs))
	{
		foreach(var_02 in param_00.timer_structs)
		{
			if(isdefined(var_02.flame_vfx))
			{
				var_02.flame_vfx delete();
			}
		}
	}
}

//Function Number: 80
clean_all_cube_vfx(param_00)
{
	if(isdefined(param_00.damage_marker_structs))
	{
		foreach(var_02 in param_00.damage_marker_structs)
		{
			if(isdefined(var_02.cube_vfx))
			{
				var_02.cube_vfx delete();
			}
		}
	}
}

//Function Number: 81
show_cube_at_tile(param_00,param_01)
{
	var_02 = get_damage_marker_with_id(param_00,param_01);
	var_03 = param_00.script_area;
	var_04 = spawn("script_model",var_02.origin);
	var_04.angles = var_02.angles;
	var_04 setmodel("sb_quest_origin");
	var_04 setscriptablepartstate("vfx","window_cube_" + var_03);
	var_02.cube_vfx = var_04;
}

//Function Number: 82
get_damage_marker_with_id(param_00,param_01)
{
	foreach(var_03 in param_00.damage_marker_structs)
	{
		if(isdefined(var_03.name) && var_03.name == param_01)
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 83
wait_for_first_tile_hit(param_00)
{
	for(;;)
	{
		param_00 waittill("damage_marker_hit",var_01);
		if(var_01 == 1)
		{
			return;
		}
	}
}

//Function Number: 84
tiles_hit_listener(param_00,param_01)
{
	param_00 endon("write_number_fail");
	for(;;)
	{
		param_00 waittill("damage_marker_hit",var_02);
		if(var_02 == -1)
		{
			if(param_00.tiles_hit.size > 0)
			{
				param_00 notify("write_number_fail");
			}

			continue;
		}

		if(!scripts\common\utility::func_2286(param_00.tiles_hit,var_02))
		{
			show_cube_at_tile(param_00,"" + var_02);
			param_00.tiles_hit[param_00.tiles_hit.size] = var_02;
			if(param_00.tiles_hit.size == 1)
			{
				param_00 thread start_candle_timer(param_00,get_timer_time(param_01));
			}
		}

		if(param_00.tiles_hit.size == param_00.num_of_tile_to_hit)
		{
			param_00 notify("write_number_success");
		}
	}
}

//Function Number: 85
get_timer_time(param_00)
{
	switch(param_00)
	{
		case "1":
			return 6;

		case "9":
			return 7;

		case "7":
			return 7;

		case "2":
			return 7;
	}
}

//Function Number: 86
start_candle_timer(param_00,param_01)
{
	param_00 endon("write_number_fail");
	param_00 endon("write_number_success");
	spawn_candle_flame(param_00);
	for(var_02 = 0;var_02 < 3;var_02++)
	{
		wait(param_01 / 3);
		param_00.timer_structs[var_02].flame_vfx delete();
	}

	param_00 notify("write_number_timeout");
}

//Function Number: 87
hide_all_candles(param_00)
{
	foreach(var_02 in param_00.timer_structs)
	{
		var_02.candle hide();
	}
}

//Function Number: 88
show_all_candles(param_00)
{
	foreach(var_02 in param_00.timer_structs)
	{
		var_02.candle show();
	}
}

//Function Number: 89
spawn_candle_flame(param_00)
{
	foreach(var_04, var_02 in param_00.timer_structs)
	{
		var_03 = spawnfx(level._effect["candle_flame"],var_02.candle.origin + get_flame_vfx_offset(var_04));
		triggerfx(var_03);
		var_02.flame_vfx = var_03;
	}
}

//Function Number: 90
set_up_timer_candles(param_00)
{
	foreach(var_03, var_02 in param_00.timer_structs)
	{
		var_02.candle = set_up_candle(var_02,var_03);
	}
}

//Function Number: 91
set_up_controlling_struct(param_00)
{
	param_00.timer_structs = [];
	param_00.damage_marker_structs = [];
	set_should_detect_damage(param_00,0);
	var_01 = scripts\common\utility::getstructarray(param_00.target,"targetname");
	foreach(var_03 in var_01)
	{
		var_04 = var_03.script_noteworthy;
		if(issubstr(var_04,"timer"))
		{
			var_05 = int(strtok(var_04,"_")[1]);
			param_00.timer_structs[var_05] = var_03;
			continue;
		}

		if(var_04 == "damage_marker")
		{
			param_00.damage_marker_structs[param_00.damage_marker_structs.size] = var_03;
		}
	}

	var_07 = getentarray(param_00.target,"targetname");
	foreach(var_09 in var_07)
	{
		var_0A = var_09.script_noteworthy;
		if(var_0A == "damage_monitor")
		{
			var_09 thread damage_watcher(param_00,var_09);
			param_00.var_4D07 = var_09;
		}
	}

	param_00.num_of_tile_to_hit = int(param_00.name);
}

//Function Number: 92
set_should_detect_damage(param_00,param_01)
{
	param_00.should_detect_damage = param_01;
}

//Function Number: 93
should_detect_damage(param_00)
{
	return param_00.should_detect_damage;
}

//Function Number: 94
damage_watcher(param_00,param_01)
{
	param_01 endon("death");
	param_01 setcandamage(1);
	param_01.health = 99999999;
	for(;;)
	{
		param_01 waittill("damage",var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B);
		param_01.health = 99999999;
		if(should_detect_damage(param_00))
		{
			var_0C = get_tile_hit_id(param_00,var_05);
			param_00 notify("damage_marker_hit",var_0C);
		}
	}
}

//Function Number: 95
get_tile_hit_id(param_00,param_01)
{
	var_02 = param_00.damage_marker_structs;
	var_03 = scripts\common\utility::getclosest(param_01,var_02);
	if(isdefined(var_03.name))
	{
		return int(var_03.name);
	}

	return -1;
}

//Function Number: 96
set_up_candle(param_00,param_01)
{
	var_02 = spawn("script_model",param_00.origin);
	var_02 setmodel(get_candle_model(param_01));
	var_02.angles = param_00.angles;
	return var_02;
}

//Function Number: 97
get_flame_vfx_offset(param_00)
{
	switch(param_00)
	{
		case 0:
			return (0,0,8.2);

		case 1:
			return (0,0,6);

		case 2:
			return (0,0,3);

		default:
			break;
	}
}

//Function Number: 98
get_candle_model(param_00)
{
	switch(param_00)
	{
		case 0:
			return "p7_candle_tall";

		case 1:
			return "p7_candle_med";

		case 2:
			return "p7_candle_sml";

		default:
			break;
	}
}

//Function Number: 99
complete_write_1_9_7_2()
{
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_C127(3);
}

//Function Number: 100
debug_write_1_9_7_2()
{
}

//Function Number: 101
clean_up_1_9_7_2_setups()
{
	var_00 = ["1","9","7","2"];
	foreach(var_02 in var_00)
	{
		var_03 = scripts\common\utility::getstruct("sb_writing_quest_" + var_02,"targetname");
		clean_all_flame_vfx(var_03);
		clean_all_candles(var_03);
		clean_damage_monitor(var_03);
		clean_all_cube_vfx(var_03);
	}
}

//Function Number: 102
do_sky_steps()
{
	wait_for_ghetto_rooftop_bridge_door_open();
	prepare_sky_steps();
	for(;;)
	{
		var_00 = scripts\common\utility::getstruct("sky_step_start","targetname");
		var_01 = activate_sky_step(var_00,0);
		wait_for_player_to_jump_on_top(var_01);
		var_01 thread sky_step_timeout_monitor(var_01);
		var_02 = var_01;
		var_03 = 1;
		for(;;)
		{
			var_04 = get_sky_steps_at_tier(var_03,var_02);
			if(var_04.size == 0)
			{
				break;
			}

			var_05 = scripts\common\utility::random(var_04);
			activate_sky_step(var_05,1);
			var_02 = var_05;
			wait(1);
			var_03++;
		}

		var_06 = activate_sky_step_goal();
		var_07 = level scripts\common\utility::func_13734("sky_step_goal_reached","sky_step_goal_timeout");
		if(var_07 == "sky_step_goal_reached")
		{
			break;
		}
		else if(var_07 == "sky_step_goal_timeout")
		{
			func_13650();
		}
	}
}

//Function Number: 103
wait_for_ghetto_rooftop_bridge_door_open()
{
	var_00 = (-564,474,978);
	var_01 = (-425,445,980);
	for(;;)
	{
		var_02 = getclosestdoortrig(var_00,level.door_trigs,100);
		var_03 = getclosestdoortrig(var_01,level.door_trigs,100);
		if(isdefined(var_02) || isdefined(var_03))
		{
			wait(1);
			continue;
		}
	}
}

//Function Number: 104
getclosestdoortrig(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 500000;
	}

	var_03 = undefined;
	foreach(var_05 in param_01)
	{
		if(isdefined(var_05))
		{
			var_06 = distance(var_05.origin,param_00);
			if(var_06 >= param_02)
			{
				continue;
			}

			param_02 = var_06;
			var_03 = var_05;
		}
	}

	return var_03;
}

//Function Number: 105
complete_sky_steps()
{
	clean_up_sky_steps();
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_C127(4);
}

//Function Number: 106
debug_do_sky_steps()
{
}

//Function Number: 107
activate_sky_step_goal()
{
	var_00 = scripts\common\utility::getstruct("sky_step_goal","targetname");
	var_01 = spawn("script_model",var_00.origin);
	var_01 setmodel("sb_quest_origin");
	var_01 setscriptablepartstate("vfx","train_skull");
	var_01.angles = var_00.angles;
	var_01 thread sky_step_goal_timeout_monitor(var_01);
	var_01 thread player_reached_monitor(var_01);
	return var_01;
}

//Function Number: 108
sky_step_goal_timeout_monitor(param_00)
{
	param_00 endon("death");
	wait(5);
	level notify("sky_step_goal_timeout");
	param_00 delete();
}

//Function Number: 109
player_reached_monitor(param_00)
{
	param_00 endon("death");
	for(;;)
	{
		if(player_reach_goal(param_00))
		{
			break;
		}

		scripts\common\utility::func_136F7();
	}

	level notify("sky_step_goal_reached");
	playfx(level._effect["ghost_explosion_death_green"],param_00.origin,anglestoforward(param_00.angles),anglestoup(param_00.angles));
	param_00 delete();
}

//Function Number: 110
player_reach_goal(param_00)
{
	foreach(var_02 in level.players)
	{
		if(distancesquared(param_00.origin,var_02 geteye()) < 1600)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 111
wait_for_player_to_jump_on_top(param_00)
{
	param_00 endon("death");
	for(;;)
	{
		foreach(var_02 in level.players)
		{
			if(player_is_on_top_sky_step(var_02,param_00))
			{
				return;
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 112
sky_step_timeout_monitor(param_00)
{
	param_00 endon("death");
	wait(5);
	deactivate_sky_step(param_00);
}

//Function Number: 113
player_is_on_top_sky_step(param_00,param_01)
{
	if(distancesquared(param_00.origin,param_01.origin) > 400)
	{
		return 0;
	}

	if(param_00.origin[2] < param_01.origin[2])
	{
		return 0;
	}

	return 1;
}

//Function Number: 114
get_sky_steps_at_tier(param_00,param_01)
{
	var_02 = scripts\common\utility::getstructarray("sky_step_tier_" + param_00,"targetname");
	var_03 = [];
	foreach(var_05 in var_02)
	{
		if(distancesquared(param_01.origin,var_05.origin) > 27225)
		{
			continue;
		}

		var_03[var_03.size] = var_05;
	}

	return var_03;
}

//Function Number: 115
prepare_sky_steps()
{
	var_00 = getentarray("sky_step_clip","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = spawn("script_model",var_02.origin + (0,0,2));
		var_03 setmodel("sb_quest_origin");
		var_03 linkto(var_02);
		var_02.var_1604 = 0;
		var_02.sky_step_vfx = var_03;
		var_02.var_C726 = var_02.origin;
		var_02 dontinterpolate();
		scripts\common\utility::func_136F7();
	}

	level.sky_steps = var_00;
}

//Function Number: 116
activate_sky_step(param_00,param_01)
{
	var_02 = get_available_sky_step();
	var_02.var_1604 = 1;
	var_02 dontinterpolate();
	var_02.sky_step_vfx dontinterpolate();
	var_02.sky_step_vfx show();
	var_02.origin = param_00.origin;
	var_02.sky_step_vfx setscriptablepartstate("vfx","sky_step");
	if(scripts\common\utility::istrue(param_01))
	{
		var_02 thread sky_step_timeout_monitor(var_02);
	}

	return var_02;
}

//Function Number: 117
deactivate_sky_step(param_00)
{
	param_00.sky_step_vfx setscriptablepartstate("vfx","off");
	param_00.var_1604 = 0;
	param_00 dontinterpolate();
	param_00.sky_step_vfx dontinterpolate();
	param_00.sky_step_vfx hide();
	param_00.origin = param_00.var_C726;
}

//Function Number: 118
clean_up_sky_steps()
{
	if(isdefined(level.sky_steps))
	{
		foreach(var_01 in level.sky_steps)
		{
			var_01.sky_step_vfx delete();
			var_01 delete();
		}
	}
}

//Function Number: 119
get_available_sky_step()
{
	foreach(var_01 in level.sky_steps)
	{
		if(var_01.var_1604 == 0)
		{
			return var_01;
		}
	}
}

//Function Number: 120
grab_skull_in_front_train()
{
	level.should_set_up_skull_in_front_of_train = 1;
	level waittill("player_grabs_train_skull");
}

//Function Number: 121
try_set_up_skull_in_front_of_train(param_00)
{
	if(should_set_up_skull_in_front_of_train())
	{
		var_01 = param_00.origin + (0,450,150);
		var_02 = spawn("script_model",var_01);
		var_02.angles = vectortoangles((0,1,0));
		var_02 setmodel("sb_quest_origin");
		var_02 setscriptablepartstate("vfx","train_skull");
		var_02 linkto(param_00);
		level.train_skull = var_02;
		var_02 thread player_jump_by_monitor(var_02);
	}
}

//Function Number: 122
player_jump_by_monitor(param_00)
{
	param_00 endon("death");
	for(;;)
	{
		if(any_player_reach_skull(param_00))
		{
			playfx(level._effect["ghost_explosion_death_green"],param_00.origin,anglestoforward(param_00.angles),anglestoup(param_00.angles));
			level notify("player_grabs_train_skull");
			param_00 delete();
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 123
any_player_reach_skull(param_00)
{
	foreach(var_02 in level.players)
	{
		if(distancesquared(var_02 geteye(),param_00.origin) < 8100)
		{
			playfxontagforclients(level._effect["get_train_skull"],var_02,"tag_eye",var_02);
			return 1;
		}
	}

	return 0;
}

//Function Number: 124
should_set_up_skull_in_front_of_train()
{
	if(!scripts\common\utility::istrue(level.should_set_up_skull_in_front_of_train))
	{
		return 0;
	}

	if(isdefined(level.train_skull))
	{
		return 0;
	}

	return 1;
}

//Function Number: 125
complete_grab_skull_in_front_train()
{
	if(isdefined(level.train_skull))
	{
		level.train_skull delete();
	}

	level.should_set_up_skull_in_front_of_train = 0;
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_C127(5);
}

//Function Number: 126
debug_grab_skull_in_front_train()
{
}

//Function Number: 127
call_service_number()
{
	level.skullbuster_service_available = 1;
	level waittill("skullbuster_service_called");
}

//Function Number: 128
complete_call_service_number()
{
	level.skullbuster_service_available = 0;
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_C127(6);
	level thread play_gns_success_vo();
}

//Function Number: 129
play_gns_success_vo()
{
	level endon("game_ended");
	foreach(var_01 in level.players)
	{
		var_01 thread scripts\cp\_vo::try_to_play_vo("access_ghostnskulls","disco_comment_vo");
	}
}

//Function Number: 130
debug_call_service_number()
{
}

//Function Number: 131
func_135F6()
{
	level endon("player_debug_activate_cabinet");
	level.gns_game_console_vfx = spawnfx(level._effect["GnS_activation"],(-713,2609,943));
	triggerfx(level.gns_game_console_vfx);
	var_00 = (-731,2611,898);
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

		foreach(var_04 in level.players)
		{
			if(isdefined(level.clock_interaction) && isdefined(level.clock_interaction.clock_owner) && level.clock_interaction.clock_owner == var_04)
			{
				var_02 = 0;
			}

			if(isdefined(level.clock_interaction_q2) && isdefined(level.clock_interaction_q2.clock_owner) && level.clock_interaction_q2.clock_owner == var_04)
			{
				var_02 = 0;
			}

			if(isdefined(level.clock_interaction_q3) && isdefined(level.clock_interaction_q3.clock_owner) && level.clock_interaction_q3.clock_owner == var_04)
			{
				var_02 = 0;
			}

			if(scripts\common\utility::istrue(var_04.start_breaking_clock))
			{
				var_02 = 0;
			}

			if(scripts\common\utility::istrue(var_04.is_using_gourd))
			{
				var_02 = 0;
			}

			if(scripts\common\utility::istrue(var_04.kung_fu_mode))
			{
				var_02 = 0;
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

//Function Number: 132
func_447F()
{
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_C127(-1,0.5);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_10C61();
}

//Function Number: 133
func_4F30()
{
}

//Function Number: 134
func_13650()
{
	level waittill("regular_wave_starting");
}

//Function Number: 135
cp_disco_gns_3_setup()
{
	level.gns_num_of_wave = 3;
	level.init_formation_movement_func = ::gns3_formation_movement;
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::init();
	level.death_trigger_reset_y_pos = -3234;
	level.death_trigger_activate_y_pos = -2305;
	level.original_death_grid_lines_front_y_pos = -638;
	level.zombie_ghost_model = "zombie_ghost_cube_green";
	level.zombie_ghost_color_manager = ::cp_disco_ghost_color_manager;
	level.set_moving_target_color_func = ::cp_disco_set_moving_target_color;
	level.should_moving_target_explode = ::cp_disco_should_moving_target_explode;
	level.hit_wrong_moving_target_func = ::cp_disco_hit_wrong_moving_target_func;
	level.moving_target_pre_fly_time = 0.5;
	level.gns_hotjoin_wait_notify = "finish_intro_gesture";
	level.ghost_n_skull_reactivate_func = ::reactivate_skullbuster_cabinet;
	level.gns_reward_func = ::disco_gns_player_reward_func;
	level.get_fake_ghost_model_func = ::disco_get_fake_ghost_model_func;
	level.activate_moving_targets_func = ::cp_disco_activate_moving_targets;
	level.assign_moving_target_flags_func = ::cp_disco_assign_moving_target_flags;
	level.var_E207 = ::cp_disco_reset_moving_target_wave_data;
	level.process_moving_target_hit_func = ::cp_disco_process_moving_target_hit_with_right_color;
	level.grab_same_ghost_string = &"CP_DISCO_GNS_TRACK_SAME_CUBE";
	level.gns_moving_target_model = "cp_disco_pixel_question_mark";
	level.enter_ghosts_n_skulls_func = ::cp_disco_enter_ghosts_n_skulls_func;
	level.all_perk_list = ["perk_machine_boom","perk_machine_flash","perk_machine_fwoosh","perk_machine_more","perk_machine_rat_a_tat","perk_machine_revive","perk_machine_run","perk_machine_deadeye","perk_machine_tough","perk_machine_zap"];
	load_gns_3_vfx();
	register_ghost_form();
	register_waves_movement();
	load_cp_disco_ghost_exp_vfx();
	level thread adjust_player_exit_gns_pos();
	level thread adjust_mahjong_pick_up_pos();
	init_ghost_n_skull_3_quest();
}

//Function Number: 136
cp_disco_enter_ghosts_n_skulls_func(param_00)
{
	param_00 notify("exit_kung_fu_requested");
	scripts\common\utility::func_136F7();
}

//Function Number: 137
load_gns_3_vfx()
{
	level._effect["combo_arc_green"] = loadfx("vfx/iw7/core/zombie/ghosts_n_skulls/vfx_ghost_combo_arc_green.vfx");
	level._effect["combo_arc_red"] = loadfx("vfx/iw7/core/zombie/ghosts_n_skulls/vfx_ghost_combo_arc_red.vfx");
	level._effect["combo_arc_blue"] = loadfx("vfx/iw7/core/zombie/ghosts_n_skulls/vfx_ghost_combo_arc_blue.vfx");
	level._effect["combo_arc_yellow"] = loadfx("vfx/iw7/core/zombie/ghosts_n_skulls/vfx_ghost_combo_arc_yellow.vfx");
	level._effect["candle_flame"] = loadfx("vfx/iw7/levels/cp_disco/amb/vfx_candle_flame.vfx");
	level._effect["get_train_skull"] = loadfx("vfx/iw7/core/zombie/ghosts_n_skulls/vfx_zmb_get_train_skull.vfx");
}

//Function Number: 138
cp_disco_ghost_color_manager()
{
	var_00 = 6;
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	var_04 = 0;
	foreach(var_06 in level.var_13F2D)
	{
		if(var_06.color == "red")
		{
			var_01++;
		}

		if(var_06.color == "green")
		{
			var_02++;
		}

		if(var_06.color == "yellow")
		{
			var_03++;
		}

		if(var_06.color == "blue")
		{
			var_04++;
		}
	}

	if(var_01 < var_00)
	{
		level.zombie_ghost_model = "zombie_ghost_cube_red";
		return;
	}

	if(var_02 < var_00)
	{
		level.zombie_ghost_model = "zombie_ghost_cube_green";
		return;
	}

	if(var_03 < var_00)
	{
		level.zombie_ghost_model = "zombie_ghost_cube_yellow";
		return;
	}

	level.zombie_ghost_model = "zombie_ghost_cube_blue";
}

//Function Number: 139
cp_disco_set_moving_target_color(param_00,param_01)
{
	var_02 = ["green","yellow","blue"];
	var_03 = "";
	if(param_01 == 1)
	{
		if(!isdefined(level.moving_target_color_based_on_priority))
		{
			determine_color(var_02);
		}

		if(scripts\common\utility::func_2286(level.var_BD46["low"],param_00))
		{
			var_03 = level.moving_target_color_based_on_priority["low"];
		}
		else if(scripts\common\utility::func_2286(level.var_BD46["medium"],param_00))
		{
			var_03 = level.moving_target_color_based_on_priority["medium"];
		}
		else if(scripts\common\utility::func_2286(level.var_BD46["high"],param_00))
		{
			var_03 = level.moving_target_color_based_on_priority["high"];
		}
	}
	else
	{
		var_03 = scripts\common\utility::random(var_02);
	}

	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::set_moving_target_color(param_00,var_03);
}

//Function Number: 140
determine_color(param_00)
{
	var_01 = scripts\common\utility::array_randomize(param_00);
	level.moving_target_color_based_on_priority = [];
	level.moving_target_color_based_on_priority["low"] = var_01[0];
	level.moving_target_color_based_on_priority["medium"] = var_01[1];
	level.moving_target_color_based_on_priority["high"] = var_01[2];
}

//Function Number: 141
cp_disco_should_moving_target_explode(param_00,param_01)
{
	if(level.allow_skulls_to_explode == 0)
	{
		return 0;
	}

	if(param_01.revealed == 1)
	{
		return 0;
	}

	return isdefined(param_01) && isdefined(param_01.color) && param_00.color == param_01.color;
}

//Function Number: 142
cp_disco_hit_wrong_moving_target_func(param_00,param_01,param_02)
{
	if(param_01.revealed == 1)
	{
		return;
	}

	if(level.allow_skulls_to_explode == 0)
	{
		return;
	}

	playfxontag(level._effect["wrong_color_" + param_02.color],param_01,"tag_origin");
	param_00 playlocalsound("ghosts_8bit_match3_negative");
	level.var_C1F0++;
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_12DF9();
	level thread delay_determine_game_fail();
}

//Function Number: 143
delay_determine_game_fail()
{
	level endon("game_ended");
	var_00 = 2;
	wait(var_00);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_53BB();
}

//Function Number: 144
disco_gns_player_reward_func()
{
	upgrade_magic_wheel();
	foreach(var_01 in level.players)
	{
		if(!scripts\common\utility::istrue(level.entered_thru_card))
		{
			var_01 lib_0D2A::func_12D7C("COIN_OP",1);
		}

		var_01 thread scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::give_gns_base_reward(var_01);
	}

	level notify("end_this_thread_of_gns_fnf_card");
}

//Function Number: 145
upgrade_magic_wheel()
{
	level.magic_wheel_upgraded_pap1 = 1;
	level.complete_skull_buster = 1;
	if(isdefined(level.current_active_wheel))
	{
		level.current_active_wheel setscriptablepartstate("fx","upgrade");
	}
}

//Function Number: 146
gns3_formation_movement()
{
	level.formation_movements = [];
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_DEB7(1,::formation_move_pattern);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_DEB7(2,::formation_move_pattern);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_DEB7(3,::formation_move_pattern);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_DEB7(4,::formation_move_pattern);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_DEB7(5,::formation_move_pattern);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_DEB7(6,::formation_move_pattern);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_DEB7(7,::formation_move_pattern);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_DEB7(8,::formation_move_pattern);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_DEB7(9,::formation_move_pattern);
}

//Function Number: 147
formation_move_pattern(param_00)
{
	return ["R","R","R","F","L","L","L","F"];
}

//Function Number: 148
register_ghost_form()
{
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(1,1);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(1,2);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(1,3);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2,4);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2,5);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(2,6);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3,7);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3,8);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_available_formation(3,9);
}

//Function Number: 149
register_waves_movement()
{
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_moving_target_wave(1,1,2,0.7);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_moving_target_wave(2,1,1.6,0.7);
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::register_moving_target_wave(3,1,1.2,0.7);
	level.available_formations = undefined;
	level.formation_movements = undefined;
}

//Function Number: 150
load_cp_disco_ghost_exp_vfx()
{
	level._effect["ghost_explosion_death_red"] = loadfx("vfx/iw7/core/zombie/ghosts_n_skulls/vfx_zmb_ghost_imp_red.vfx");
	level._effect["ghost_explosion_death_yellow"] = loadfx("vfx/iw7/core/zombie/ghosts_n_skulls/vfx_zmb_ghost_imp_yellow.vfx");
	level._effect["ghost_explosion_death_blue"] = loadfx("vfx/iw7/core/zombie/ghosts_n_skulls/vfx_zmb_ghost_imp_blue.vfx");
	level._effect["sb_quest_item_pickup"] = loadfx("vfx/iw7/core/zombie/vfx_zom_souvenir_pickup.vfx");
	level._effect["write_1972_success"] = loadfx("vfx/iw7/levels/cp_disco/vfx_skb_1972_burst.vfx");
	level._effect["wrong_color_green"] = loadfx("vfx/iw7/core/zombie/ghosts_n_skulls/vfx_zmb_alien_head_x_green.vfx");
	level._effect["wrong_color_red"] = loadfx("vfx/iw7/core/zombie/ghosts_n_skulls/vfx_zmb_alien_head_x_red.vfx");
	level._effect["wrong_color_blue"] = loadfx("vfx/iw7/core/zombie/ghosts_n_skulls/vfx_zmb_alien_head_x_blue.vfx");
	level._effect["wrong_color_yellow"] = loadfx("vfx/iw7/core/zombie/ghosts_n_skulls/vfx_zmb_alien_head_x_yellow.vfx");
}

//Function Number: 151
disco_get_fake_ghost_model_func(param_00)
{
	return "fake_zombie_ghost_cube_" + param_00;
}

//Function Number: 152
cp_disco_activate_moving_targets(param_00)
{
	randomize_color_for_color_group();
	assign_color_to_color_group();
	reveal_color_for_puzzle();
	set_allow_skulls_to_explode(1);
}

//Function Number: 153
randomize_color_for_color_group()
{
	level.color_for_color_group = [];
	for(var_00 = ["red","blue","yellow","green"];var_00.size > 0;var_00 = scripts\common\utility::func_22A9(var_00,var_01))
	{
		var_01 = scripts\common\utility::random(var_00);
		level.color_for_color_group[level.color_for_color_group.size] = var_01;
	}
}

//Function Number: 154
assign_color_to_color_group()
{
	foreach(var_01 in level.var_BD43)
	{
		foreach(var_03 in var_01)
		{
			var_03.color = level.color_for_color_group[var_03.color_group];
		}
	}
}

//Function Number: 155
reveal_color_for_puzzle()
{
	var_00 = 0.5;
	var_01 = 0.25;
	var_02 = 0.5;
	wait(var_00);
	var_03 = 0;
	for(;;)
	{
		var_04 = get_moving_targets_with_reveal_id(var_03);
		if(var_04.size > 0)
		{
			foreach(var_06 in var_04)
			{
				reveal_moving_target_color(var_06);
			}

			wait(var_01);
		}
		else
		{
			wait(var_02);
			return;
		}

		var_03++;
	}
}

//Function Number: 156
get_moving_targets_with_reveal_id(param_00)
{
	var_01 = [];
	foreach(var_03 in level.var_BD43)
	{
		foreach(var_05 in var_03)
		{
			if(isdefined(var_05.reveal_id) && var_05.reveal_id == param_00)
			{
				var_01[var_01.size] = var_05;
			}
		}
	}

	return var_01;
}

//Function Number: 157
reveal_moving_target_color(param_00)
{
	param_00 setmodel("zmb_pixel_skull");
	param_00.revealed = 1;
	param_00 setscriptablepartstate("skull_vfx",param_00.color);
}

//Function Number: 158
cp_disco_assign_moving_target_flags(param_00,param_01)
{
	param_01.revealed = 0;
	param_01.color_group = int(param_00.var_86A2);
	param_01.subgroup = param_00.var_111A4;
	param_01.vfx_start = isdefined(param_00.script_side);
	if(isdefined(param_00.var_EECB))
	{
		param_01.reveal_id = int(param_00.var_EECB);
	}
}

//Function Number: 159
cp_disco_reset_moving_target_wave_data()
{
	set_allow_skulls_to_explode(0);
}

//Function Number: 160
set_allow_skulls_to_explode(param_00)
{
	level.allow_skulls_to_explode = param_00;
}

//Function Number: 161
cp_disco_process_moving_target_hit_with_right_color(param_00,param_01,param_02)
{
	param_01 playlocalsound("ghosts_8bit_match3_positive");
	reveal_moving_target_color(param_00);
	var_03 = get_moving_targets_in_same_subgroup(param_00.subgroup);
	if(all_moving_targets_are_revealed(var_03))
	{
		param_01 playlocalsound("ghosts_8bit_match3_explo");
		explode_moving_targets(var_03,param_01);
	}
}

//Function Number: 162
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

//Function Number: 163
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

//Function Number: 164
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

//Function Number: 165
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

//Function Number: 166
delay_moving_target_explode(param_00,param_01,param_02,param_03)
{
	play_combo_arc_vfx(param_00,param_02,param_03);
	playfx(level._effect["ghost_explosion_death_" + param_00.color],param_00.origin,anglestoforward(param_00.angles),anglestoup(param_00.angles));
	lib_0C2D::remove_moving_target_default(param_00,param_01);
}

//Function Number: 167
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

//Function Number: 168
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

//Function Number: 169
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

//Function Number: 170
reactivate_skullbuster_cabinet()
{
	if(!lib_0D52::quest_line_exist("reactivateghost"))
	{
		var_00 = getomnvar("zm_num_ghost_n_skull_coin");
		if(isdefined(var_00) && var_00 < 5)
		{
			return;
		}

		lib_0D52::func_DED3("reactivateghost",0,::scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::reactivate_cabinet,::call_service_number,::complete_call_service_number,::debug_call_service_number);
		lib_0D52::func_DED3("reactivateghost",1,::func_2B53,::func_135F6,::func_447F,::func_4F30);
	}

	level thread lib_0D52::func_10CEE("reactivateghost");
}