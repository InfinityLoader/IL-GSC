/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\directors_cut.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 68
 * Decompile Time: 3488 ms
 * Timestamp: 10/27/2023 12:09:01 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["directors_cut_golden_film"] = loadfx("vfx/iw7/levels/cp_final/pap/vfx_filmreel_golden_anim.vfx");
	level._effect["soul_key_place"] = loadfx("vfx/iw7/levels/cp_final/pap/vfx_soulkey_place.vfx");
}

//Function Number: 2
start_directors_cut()
{
	level endon("game_ended");
	if(!allow_directors_cut())
	{
		level thread store_no_dc_mode_in_player_data();
		return;
	}

	level thread directors_cut_player_connect_monitor();
	wait(7);
	set_up_soul_jar_interaction();
	set_directors_cut_is_activated();
	if(directors_cut_is_activated())
	{
		scripts\cp\zombies\zombie_analytics::log_using_dc_mode(1);
		activate_directors_cut_global_benefits();
		start_level_specific_easter_eggs();
	}
}

//Function Number: 3
store_no_dc_mode_in_player_data()
{
	wait(10);
	scripts\cp\zombies\zombie_analytics::log_using_dc_mode(0);
}

//Function Number: 4
allow_directors_cut()
{
	if(scripts\cp\zombies\direct_boss_fight::should_directly_go_to_boss_fight())
	{
		return 0;
	}

	if(!level.onlinegame)
	{
		return 0;
	}

	return 1;
}

//Function Number: 5
directors_cut_player_connect_monitor()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("connected",var_00);
		if(directors_cut_activated_for(var_00))
		{
			var_00 thread give_directors_cut_benefits_to(var_00);
		}
	}
}

//Function Number: 6
give_directors_cut_benefits_to(param_00)
{
	param_00 endon("disconnect");
	param_00 waittill("spawned_player");
	scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::set_consumable_meter_scalar(param_00,2);
	wait(get_pre_perkaholic_wait_time());
	give_unlimited_self_revive(param_00);
	give_perkaholic_to(param_00);
}

//Function Number: 7
give_perkaholic_to(param_00)
{
	param_00.have_permanent_perks = 1;
	param_00 thread scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::func_5FB7(param_00);
}

//Function Number: 8
give_unlimited_self_revive(param_00)
{
	param_00.max_self_revive_machine_use = 6;
	param_00.have_gns_perk = 1;
}

//Function Number: 9
try_drop_talisman(param_00,param_01)
{
	level endon("game_ended");
	if(should_drop_talisman())
	{
		wait(3);
		drop_talisman(param_00,param_01);
	}
}

//Function Number: 10
drop_talisman(param_00,param_01)
{
	var_02 = undefined;
	switch(level.script)
	{
		case "cp_zmb":
			var_02 = "d";
			break;

		case "cp_rave":
			var_02 = "e";
			break;

		case "cp_disco":
			var_02 = "a";
			break;

		case "cp_town":
			var_02 = "t";
			break;

		case "cp_final":
			var_02 = "h";
			break;
	}

	var_03 = spawn("script_model",param_00);
	var_03 setmodel("directors_cut_origin");
	var_03.angles = param_01;
	var_03 setscriptablepartstate("talisman_flames",var_02);
	var_04 = make_talisman_pick_up_interaction(param_00);
	var_04.talisman = var_03;
	enable_talisman_pick_up_for_players(var_04);
}

//Function Number: 11
should_drop_talisman()
{
	foreach(var_01 in level.players)
	{
		if(player_can_earn_talisman(var_01))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 12
enable_talisman_pick_up_for_players(param_00)
{
	foreach(var_02 in level.players)
	{
		if(player_can_earn_talisman(var_02))
		{
			enable_talisman_pick_up_for(param_00,var_02);
		}
	}
}

//Function Number: 13
enable_talisman_pick_up_for(param_00,param_01)
{
	if(!isdefined(param_00.players_who_can_pick_up))
	{
		param_00.players_who_can_pick_up = [];
	}

	param_00.players_who_can_pick_up[param_00.players_who_can_pick_up.size] = param_01;
}

//Function Number: 14
player_can_earn_talisman(param_00)
{
	var_01 = param_00 getplayerdata("cp","dc");
	return var_01;
}

//Function Number: 15
set_up_soul_jar_interaction()
{
	var_00 = getent("pap_machine","targetname");
	var_01 = var_00.origin;
	var_02 = var_00.angles;
	var_03 = anglestoforward(var_02);
	var_04 = anglestoright(var_02);
	var_05 = var_04 * -1;
	var_06 = anglestoup(var_02);
	var_07 = var_01 + var_03 * 34 + var_05 * 133.5 + var_06 * 55;
	var_08 = spawnstruct();
	var_08.name = "open_soul_jar";
	var_08.script_noteworthy = "open_soul_jar";
	var_08.origin = var_07;
	var_08.cost = 0;
	var_08.var_D776 = 1;
	var_08.var_109DA = undefined;
	var_08.var_EE79 = "";
	var_08.var_E1B9 = 0;
	var_08.var_8FFA = ::soul_jar_hint_func;
	var_08.var_161A = ::try_open_soul_jar;
	var_08.var_6261 = 1;
	var_08.disable_guided_interactions = 0;
	level.interactions["open_soul_jar"] = var_08;
	scripts\cp\_interaction::add_to_current_interaction_list(var_08);
}

//Function Number: 16
try_open_soul_jar(param_00,param_01)
{
	if(can_open_soul_jar(param_01))
	{
		open_soul_jar(param_00,param_01);
	}
}

//Function Number: 17
make_talisman_pick_up_interaction(param_00)
{
	var_01 = spawnstruct();
	var_01.name = "talisman_pick_up";
	var_01.script_noteworthy = "talisman_pick_up";
	var_01.origin = param_00;
	var_01.cost = 0;
	var_01.var_D776 = 1;
	var_01.var_109DA = undefined;
	var_01.var_EE79 = "";
	var_01.var_E1B9 = 0;
	var_01.var_8FFA = ::talisman_hint_func;
	var_01.var_161A = ::pick_up_talisman;
	var_01.var_6261 = 1;
	var_01.disable_guided_interactions = 0;
	level.interactions["talisman_pick_up"] = var_01;
	scripts\cp\_interaction::add_to_current_interaction_list(var_01);
	return var_01;
}

//Function Number: 18
talisman_player_connect_monitor(param_00)
{
	level endon("game_ended");
	param_00 endon("talisman_pick_up_complete");
	for(;;)
	{
		level waittill("connected",var_01);
		var_01 thread remove_talisman_interaction(param_00,var_01);
	}
}

//Function Number: 19
remove_talisman_interaction(param_00,param_01)
{
	param_01 endon("disconnect");
	level endon("game_ended");
	param_01 waittill("spawned_player");
	scripts\cp\_interaction::func_E01A(param_00,param_01);
}

//Function Number: 20
talisman_hint_func(param_00,param_01)
{
	if(player_can_earn_talisman(param_01))
	{
		return &"DIRECTORS_CUT_PICK_UP_TALISMAN";
	}

	return &"DIRECTORS_CUT_UNABLE_PICK_UP_TALISMAN";
}

//Function Number: 21
soul_jar_hint_func(param_00,param_01)
{
	return "";
}

//Function Number: 22
pick_up_talisman(param_00,param_01)
{
	if(!player_can_earn_talisman(param_01))
	{
		return;
	}

	scripts\cp\_interaction::func_E01A(param_00,param_01);
	param_00.players_who_can_pick_up = scripts\common\utility::func_22A9(param_00.players_who_can_pick_up,param_01);
	param_00.talisman method_8429(param_01);
	update_talisman_interaction_after_pick_up(param_00);
	mark_talisman_possession(param_01);
}

//Function Number: 23
update_talisman_interaction_after_pick_up(param_00)
{
	if(param_00.players_who_can_pick_up.size == 0)
	{
		scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
		param_00 notify("talisman_pick_up_complete");
		param_00.talisman delete();
	}
}

//Function Number: 24
mark_talisman_possession(param_00)
{
	var_01 = undefined;
	switch(level.script)
	{
		case "cp_zmb":
			var_01 = "item_1";
			break;

		case "cp_rave":
			var_01 = "item_2";
			break;

		case "cp_disco":
			var_01 = "item_3";
			break;

		case "cp_town":
			var_01 = "item_4";
			break;

		case "cp_final":
			var_01 = "item_5";
			break;
	}

	param_00 setplayerdata("cp","haveItems",var_01,1);
	var_02 = getdvar("ui_mapname");
	switch(var_02)
	{
		case "cp_zmb":
			param_00 scripts\cp\_merits::func_D9AD("mt_tali_1");
			break;

		case "cp_rave":
			param_00 scripts\cp\_merits::func_D9AD("mt_tali_2");
			break;

		case "cp_disco":
			param_00 scripts\cp\_merits::func_D9AD("mt_tali_3");
			break;

		case "cp_town":
			param_00 scripts\cp\_merits::func_D9AD("mt_tali_4");
			break;

		case "cp_final":
			param_00 scripts\cp\_merits::func_D9AD("mt_tali_5");
			break;
	}
}

//Function Number: 25
activate_directors_cut_global_benefits()
{
	give_unlimited_fnf_refill();
	allow_max_pap_from_start();
	upgrade_magic_wheel();
	add_wonder_weapons_to_magic_wheel();
}

//Function Number: 26
give_unlimited_fnf_refill()
{
	level.unlimited_fnf = 1;
}

//Function Number: 27
allow_max_pap_from_start()
{
	level.var_C8A4 = 3;
	level thread insert_fuses_into_pap_machine();
}

//Function Number: 28
insert_fuses_into_pap_machine()
{
	var_00 = getdvar("ui_mapname");
	switch(var_00)
	{
		case "cp_zmb":
			var_01 = getent("pap_machine","targetname");
			var_01 setscriptablepartstate("door","close");
			wait(0.5);
			var_01 setscriptablepartstate("machine","upgraded");
			wait(0.25);
			var_01 setscriptablepartstate("reels","neutral");
			wait(0.25);
			var_01 setscriptablepartstate("reels","on");
			wait(0.25);
			var_01 setscriptablepartstate("door","open_idle");
			break;

		default:
			foreach(var_01 in level.player_pap_machines)
			{
				var_01 setscriptablepartstate("machine","upgraded");
			}
			break;
	}
}

//Function Number: 29
upgrade_magic_wheel()
{
	level.magic_wheel_upgraded_pap1 = 1;
}

//Function Number: 30
add_wonder_weapons_to_magic_wheel()
{
	switch(level.script)
	{
		case "cp_zmb":
			level.var_B15E["dischord"] = "iw7_dischord_zm_pap1";
			level.var_B15E["facemelter"] = "iw7_facemelter_zm_pap1";
			level.var_B15E["headcutter"] = "iw7_headcutter_zm_pap1";
			level.var_B15E["shredder"] = "iw7_shredder_zm_pap1";
			break;

		case "cp_rave":
			level.var_B15E["acidrain"] = "iw7_harpoon1_zm";
			level.var_B15E["benfranklin"] = "iw7_harpoon2_zm";
			level.var_B15E["trapomatic"] = "iw7_harpoon3_zm+akimbo";
			level.var_B15E["whirlwind"] = "iw7_harpoon4_zm";
			break;

		case "cp_disco":
			level.var_B15E["nunchucks"] = "iw7_nunchucks_zm_pap1";
			break;

		case "cp_town":
			level.var_B15E["cutie"] = "iw7_cutie_zm+cutiecrank+cutiegrip+cutieplunger";
			break;

		case "cp_final":
			level.var_B15E["venomx"] = "iw7_venomx_zm_pap1";
			break;

		default:
			break;
	}

	foreach(var_01 in level.var_B163)
	{
		var_01.var_13C25 = scripts\cp\zombies\interaction_magicwheel::func_7ABF();
	}
}

//Function Number: 31
get_pre_perkaholic_wait_time()
{
	switch(level.script)
	{
		case "cp_final":
		case "cp_disco":
		case "cp_rave":
		case "cp_zmb":
			return 9;

		case "cp_town":
			return 13;
	}
}

//Function Number: 32
open_soul_jar(param_00,param_01)
{
	param_01 setplayerdata("cp","dc_available",1);
	level thread open_soul_jar_sequence(param_01);
}

//Function Number: 33
open_soul_jar_sequence(param_00)
{
	var_01 = getent("pap_machine","targetname");
	var_02 = var_01.origin;
	var_03 = var_01.angles;
	var_04 = anglestoforward(var_03);
	var_05 = anglestoup(var_03);
	var_01 = getent("pap_machine","targetname");
	var_02 = var_01.origin;
	var_03 = var_01.angles;
	var_04 = anglestoforward(var_03);
	var_06 = anglestoright(var_03);
	var_07 = var_06 * -1;
	var_05 = anglestoup(var_03);
	var_08 = var_02 + var_04 * 59 + var_07 * 133.5 + var_05 * 61;
	playfx(level._effect["soul_key_place"],var_08,var_04 * -1,var_05,param_00);
	wait(9.2);
	var_09 = make_lost_reel(param_00);
	var_0A = make_lost_reel(param_00);
	wait(1);
	var_01 = getent("pap_machine","targetname");
	var_0B = var_01 gettagorigin("j_top_wheel");
	var_0C = var_01 gettagorigin("j_bottom_wheel");
	var_09 moveto(var_0B,0.8,0.8);
	var_0A moveto(var_0C,0.8,0.8);
	wait(0.8);
	var_09 delete();
	var_0A delete();
	try_play_lost_reel_vfx_on_machine();
}

//Function Number: 34
make_lost_reel(param_00)
{
	var_01 = getent("pap_machine","targetname");
	var_02 = var_01.origin;
	var_03 = var_01.angles;
	var_04 = anglestoforward(var_03);
	var_05 = anglestoright(var_03);
	var_06 = var_05 * -1;
	var_07 = anglestoup(var_03);
	var_08 = var_02 + var_04 * 72 + var_06 * 133.5 + var_07 * 70;
	var_09 = spawn("script_model",var_08);
	var_09 hide();
	var_09 setmodel("directors_cut_origin");
	var_09 setscriptablepartstate("lost_reel","on");
	var_09 showtoplayer(param_00);
	return var_09;
}

//Function Number: 35
can_open_soul_jar(param_00)
{
	if(param_00 getplayerdata("cp","dc_available"))
	{
		return 0;
	}

	if(!param_00 getplayerdata("cp","haveSoulKeys","soul_key_1"))
	{
		return 0;
	}

	if(!param_00 getplayerdata("cp","haveSoulKeys","soul_key_2"))
	{
		return 0;
	}

	if(!param_00 getplayerdata("cp","haveSoulKeys","soul_key_3"))
	{
		return 0;
	}

	if(!param_00 getplayerdata("cp","haveSoulKeys","soul_key_4"))
	{
		return 0;
	}

	if(!param_00 getplayerdata("cp","haveSoulKeys","soul_key_5"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 36
try_play_lost_reel_vfx_on_machine()
{
	if(scripts\common\utility::istrue(level.lost_reel_vfx_on_machine))
	{
		return;
	}

	level.lost_reel_vfx_on_machine = 1;
	var_00 = getent("pap_machine","targetname");
	var_01 = var_00 gettagorigin("tag_origin");
	var_02 = var_00.angles;
	playfx(level._effect["directors_cut_golden_film"],var_01,anglestoforward(var_02),anglestoup(var_02));
}

//Function Number: 37
set_directors_cut_is_activated()
{
	level.directors_cut_is_activated = 0;
	foreach(var_01 in level.players)
	{
		if(directors_cut_activated_for(var_01))
		{
			level.directors_cut_is_activated = 1;
		}
	}
}

//Function Number: 38
directors_cut_is_activated()
{
	return scripts\common\utility::istrue(level.directors_cut_is_activated);
}

//Function Number: 39
directors_cut_activated_for(param_00)
{
	return param_00 getplayerdata("cp","dc");
}

//Function Number: 40
get_directors_cut_starting_currency()
{
	return 25000;
}

//Function Number: 41
start_level_specific_easter_eggs()
{
	switch(level.script)
	{
		case "cp_zmb":
			level thread cp_zmb_directors_cut_easter_egg();
			break;

		case "cp_rave":
			level thread cp_rave_directors_cut_easter_egg();
			break;

		case "cp_disco":
			level thread cp_disco_directors_cut_easter_egg();
			break;

		case "cp_town":
			level thread cp_town_directors_cut_easter_egg();
			break;

		case "cp_final":
			level thread cp_final_directors_cut_easter_egg();
			break;

		default:
			break;
	}
}

//Function Number: 42
give_dc_player_extra_xp_for_carrying_newb()
{
	var_00 = get_num_of_newbs_in_game();
	var_01 = var_00 * -15536;
	foreach(var_03 in level.players)
	{
		if(directors_cut_activated_for(var_03))
		{
			var_03 scripts\cp\_persistence::give_player_xp(var_01,1);
		}
	}
}

//Function Number: 43
get_num_of_newbs_in_game()
{
	var_00 = 0;
	var_01 = undefined;
	switch(level.script)
	{
		case "cp_zmb":
			var_01 = "soul_key_1";
			break;

		case "cp_rave":
			var_01 = "soul_key_2";
			break;

		case "cp_disco":
			var_01 = "soul_key_3";
			break;

		case "cp_town":
			var_01 = "soul_key_4";
			break;

		case "cp_final":
			var_01 = "soul_key_5";
			break;
	}

	foreach(var_03 in level.players)
	{
		if(!var_03 getplayerdata("cp","haveSoulKeys",var_01))
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 44
cp_zmb_directors_cut_easter_egg()
{
	level.var_BF51 = 0;
	level.glasses_drop_change_increase = 90;
	level thread func_42F2();
}

//Function Number: 45
func_42F2()
{
	for(;;)
	{
		level waittill("coaster_started",var_00);
		if(isdefined(level.wave_num) && level.wave_num > 1)
		{
			return;
		}

		var_01 = spawn("script_model",(2141,-3807,348));
		var_01 setmodel("cp_final_talisman_alt");
		var_01.angles = (26,145,0);
		var_02 = [];
		foreach(var_04 in level.players)
		{
			if(isdefined(var_04.var_AD1C) && var_04.var_AD1C == var_00)
			{
				var_02[var_02.size] = var_04;
			}
		}

		talisman_visibility_manager(var_01,var_02);
		foreach(var_04 in var_02)
		{
			var_04 thread shoot_talisman_monitor(var_04,var_00,var_01);
		}

		var_00 waittill("ride_finished");
		var_01 delete();
		if(isdefined(level.wave_num) && level.wave_num > 1)
		{
			return;
		}
	}
}

//Function Number: 46
talisman_visibility_manager(param_00,param_01)
{
	foreach(var_03 in param_01)
	{
		if(!directors_cut_activated_for(var_03))
		{
			param_00 method_8429(var_03);
		}

		if(!scripts\common\utility::istrue(var_03.var_13CE5))
		{
			param_00 method_8429(var_03);
		}
	}
}

//Function Number: 47
shoot_talisman_monitor(param_00,param_01,param_02)
{
	param_00 endon("disconnect");
	param_01 endon("ride_finished");
	if(!scripts\common\utility::istrue(param_00.var_13CE5))
	{
		return;
	}

	if(!directors_cut_activated_for(param_00))
	{
		return;
	}

	param_00 notifyonplayercommand("shoot_while_riding_coaster","+Attack");
	param_00 notifyonplayercommand("shoot_while_riding_coaster","+attack_akimbo_accessible");
	for(;;)
	{
		param_00 waittill("shoot_while_riding_coaster");
		if(distancesquared(param_00.origin,param_02.origin) <= 1440000)
		{
			if(param_00 method_8409(param_02.origin,25,100))
			{
				playfx(level._effect["souvenir_pickup"],param_02.origin,anglestoforward(param_02.angles),anglestoup(param_02.angles),param_00);
				param_02 method_8429(param_00);
				param_00 setplayerdata("cp","dcq","cp_zmb",1);
				param_00 scripts\cp\_damage::func_12E84("hitaliensoft");
				param_00 scripts\cp\_merits::func_D9AD("mt_dc_1");
				if(scripts\common\utility::istrue(level.onlinegame))
				{
					param_00 setplayerdata("cp","hasSongsUnlocked","any_song",1);
					param_00 setplayerdata("cp","hasSongsUnlocked","song_7",1);
				}

				return;
			}
		}
	}
}

//Function Number: 48
cp_rave_directors_cut_easter_egg()
{
	level.dc_wheel_of_misfortune_start_func = ::dc_wheel_of_misfortune_start_func;
	if(isdefined(level.enable_slasher_weapon))
	{
		level thread [[ level.enable_slasher_weapon ]]();
	}
}

//Function Number: 49
dc_wheel_of_misfortune_start_func(param_00,param_01)
{
	if(!directors_cut_activated_for(param_01))
	{
		return;
	}

	if(isdefined(level.wave_num) && level.wave_num > 1)
	{
		level.dc_wheel_of_misfortune_start_func = undefined;
		return;
	}

	var_02 = spawn("script_model",(-581,-1604,152));
	var_02 hide();
	var_02 setmodel("cp_final_talisman_alt");
	var_02.angles = (0,320,0);
	var_02 linkto(param_00);
	var_03 = randomfloatrange(0.3,1);
	wait(var_03);
	var_02 showtoplayer(param_01);
	var_02 thread talisman_damage_monitor(var_02);
	var_04 = var_02 scripts\cp\_utility::func_1372C(4,var_02,"talisman_hit_by_knife",param_01,"arcade_game_over_for_player");
	if(var_04 == "talisman_hit_by_knife")
	{
		playfx(level._effect["souvenir_pickup"],var_02.origin,anglestoforward(var_02.angles),anglestoup(var_02.angles),param_01);
		param_01 setplayerdata("cp","dcq","cp_rave",1);
		param_01 scripts\cp\_damage::func_12E84("hitaliensoft");
		param_01 scripts\cp\_merits::func_D9AD("mt_dc_2");
		if(scripts\common\utility::istrue(level.onlinegame))
		{
			param_01 setplayerdata("cp","hasSongsUnlocked","any_song",1);
			param_01 setplayerdata("cp","hasSongsUnlocked","song_8",1);
		}
	}

	var_02 delete();
}

//Function Number: 50
talisman_damage_monitor(param_00)
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

	param_00 notify("talisman_hit_by_knife");
}

//Function Number: 51
cp_disco_directors_cut_easter_egg()
{
	var_00 = spawn("script_model",(-709,1253,246));
	var_00 setmodel("cp_final_talisman_alt");
	var_00.angles = (346,120,0);
	var_00 disco_talisman_visibility_manager(var_00);
	var_00 thread disco_talisman_damage_monitor(var_00);
	var_00 thread talisman_clean_up_monitor(var_00);
}

//Function Number: 52
disco_talisman_damage_monitor(param_00)
{
	param_00 endon("death");
	param_00 setcandamage(1);
	param_00.health = 999999;
	for(;;)
	{
		param_00 waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		param_00.health = 999999;
		if(isplayer(var_02))
		{
			var_0B = var_02;
			if(directors_cut_activated_for(var_0B) && !scripts\common\utility::istrue(var_0B.got_disco_talisman))
			{
				param_00 method_8429(var_0B);
				var_0B.got_disco_talisman = 1;
				playfx(level._effect["crafting_pickup"],param_00.origin,anglestoforward(param_00.angles),anglestoup(param_00.angles),var_0B);
				var_0B setplayerdata("cp","dcq","cp_disco",1);
				var_0B scripts\cp\_damage::func_12E84("hitaliensoft");
				var_0B scripts\cp\_merits::func_D9AD("mt_dc_3");
				if(scripts\common\utility::istrue(level.onlinegame))
				{
					var_0B setplayerdata("cp","hasSongsUnlocked","any_song",1);
					var_0B setplayerdata("cp","hasSongsUnlocked","song_9",1);
				}
			}
		}
	}
}

//Function Number: 53
talisman_clean_up_monitor(param_00)
{
	param_00 endon("death");
	for(;;)
	{
		level waittill("regular_wave_starting");
		if(isdefined(level.wave_num) && level.wave_num > 1)
		{
			param_00 delete();
		}
	}
}

//Function Number: 54
disco_talisman_visibility_manager(param_00)
{
	param_00 hide();
	foreach(var_02 in level.players)
	{
		if(directors_cut_activated_for(var_02))
		{
			param_00 showtoplayer(var_02);
		}
	}

	param_00 thread disco_player_connect_monitor(param_00);
}

//Function Number: 55
disco_player_connect_monitor(param_00)
{
	param_00 endon("death");
	for(;;)
	{
		level waittill("connected",var_01);
		if(directors_cut_activated_for(var_01))
		{
			param_00 showtoplayer(var_01);
		}
	}
}

//Function Number: 56
cp_town_directors_cut_easter_egg()
{
	var_00 = spawn("script_model",(135.5,-2568,583.3));
	var_00 setmodel("directors_cut_origin");
	var_00.angles = (0,180,0);
	var_00 setscriptablepartstate("small_red_talisman","on");
	town_talisman_visibility_manager(var_00);
	town_talisman_player_shoot_manager(var_00);
	level thread town_player_connect_manager(var_00);
	for(;;)
	{
		level waittill("regular_wave_starting");
		if(isdefined(level.wave_num) && level.wave_num > 1)
		{
			var_00 delete();
			return;
		}
	}
}

//Function Number: 57
town_player_connect_manager(param_00)
{
	param_00 endon("death");
	for(;;)
	{
		level waittill("connected",var_01);
		if(directors_cut_activated_for(var_01))
		{
			param_00 showtoplayer(var_01);
			var_01 thread shoot_small_talisman_monitor(var_01,param_00);
		}
	}
}

//Function Number: 58
town_talisman_visibility_manager(param_00)
{
	param_00 hide();
	foreach(var_02 in level.players)
	{
		if(directors_cut_activated_for(var_02))
		{
			param_00 showtoplayer(var_02);
		}
	}
}

//Function Number: 59
town_talisman_player_shoot_manager(param_00)
{
	foreach(var_02 in level.players)
	{
		if(directors_cut_activated_for(var_02))
		{
			var_02 thread shoot_small_talisman_monitor(var_02,param_00);
		}
	}
}

//Function Number: 60
shoot_small_talisman_monitor(param_00,param_01)
{
	param_00 endon("disconnect");
	param_01 endon("death");
	param_00 notifyonplayercommand("try_shoot_at_small_talisman","+Attack");
	param_00 notifyonplayercommand("try_shoot_at_small_talisman","+attack_akimbo_accessible");
	for(;;)
	{
		param_00 waittill("try_shoot_at_small_talisman");
		if(distancesquared(param_00.origin,param_01.origin) <= 250000)
		{
			if(param_00 method_8409(param_01.origin,25,25))
			{
				if(facing_the_right_angles(param_00))
				{
					playfx(level._effect["sb_quest_item_pickup"],param_01.origin,anglestoforward(param_01.angles),anglestoup(param_01.angles),param_00);
					param_01 method_8429(param_00);
					param_00 setplayerdata("cp","dcq","cp_town",1);
					param_00 scripts\cp\_damage::func_12E84("hitaliensoft");
					param_00 scripts\cp\_merits::func_D9AD("mt_dc_4");
					if(scripts\common\utility::istrue(level.onlinegame))
					{
						param_00 setplayerdata("cp","hasSongsUnlocked","any_song",1);
						param_00 setplayerdata("cp","hasSongsUnlocked","song_10",1);
					}

					return;
				}
			}
		}
	}
}

//Function Number: 61
facing_the_right_angles(param_00)
{
	var_01 = param_00 getplayerangles();
	var_02 = var_01[1];
	return var_02 >= -38 && var_02 <= 39;
}

//Function Number: 62
cp_final_directors_cut_easter_egg()
{
	var_00 = [(4917,-5852,71),(4910.5,-5859.5,71),(4910.5,-5873,71),(4910.5,-5897,71),(4910.5,-5921,71),(4910.5,-5945,71),(4910.5,-5969,71),(4910.5,-5993,71),(4910.5,-6017,71),(4910.5,-6041,71),(4910.5,-6065,71),(4910.5,-6089,71),(4910.5,-6113,71),(4911.5,-6126.5,71),(4922.5,-6138.5,71)];
	level.abandoned_shooting_gallery_interactions = [];
	foreach(var_02 in var_00)
	{
		set_up_abandoned_shooting_gallery_interaction_at(var_02);
	}

	for(;;)
	{
		level scripts\common\utility::waittill_any_3("event_wave_starting","regular_wave_starting");
		if(isdefined(level.wave_num) && level.wave_num > 1)
		{
			foreach(var_05 in level.abandoned_shooting_gallery_interactions)
			{
				scripts\cp\_interaction::remove_from_current_interaction_list(var_05);
			}
		}
	}
}

//Function Number: 63
set_up_abandoned_shooting_gallery_interaction_at(param_00)
{
	var_01 = spawnstruct();
	var_01.name = "abandoned_shooting_gallery";
	var_01.script_noteworthy = "abandoned_shooting_gallery";
	var_01.origin = param_00;
	var_01.cost = 0;
	var_01.var_D776 = 1;
	var_01.var_109DA = undefined;
	var_01.var_EE79 = "";
	var_01.var_E1B9 = 0;
	var_01.var_8FFA = ::abandoned_shooting_gallery_hint_func;
	var_01.var_161A = ::try_abandoned_shooting_gallery;
	var_01.var_6261 = 1;
	var_01.disable_guided_interactions = 1;
	level.interactions["abandoned_shooting_gallery"] = var_01;
	level.abandoned_shooting_gallery_interactions[level.abandoned_shooting_gallery_interactions.size] = var_01;
	scripts\cp\_interaction::add_to_current_interaction_list(var_01);
}

//Function Number: 64
abandoned_shooting_gallery_hint_func(param_00,param_01)
{
	return "";
}

//Function Number: 65
try_abandoned_shooting_gallery(param_00,param_01)
{
	if(!directors_cut_activated_for(param_01))
	{
		return;
	}

	if(scripts\common\utility::istrue(param_01.played_abandoned_shooting_gallery))
	{
		return;
	}

	param_01.played_abandoned_shooting_gallery = 1;
	var_02 = [(4440,-5826,287),(4440,-5826,253),(4442,-5906,246),(4488,-6082,249),(4488,-6082,287)];
	var_03 = [(4488,-6082,287),(4488,-6082,249),(4442,-5906,246),(4440,-5826,253),(4440,-5826,287)];
	var_04 = [var_02,var_03];
	var_05 = scripts\common\utility::random(var_04);
	level thread talisman_fly_over_shooting_gallery(param_01,var_05);
}

//Function Number: 66
talisman_fly_over_shooting_gallery(param_00,param_01)
{
	var_02 = param_01[0];
	var_03 = spawn("script_model",var_02);
	var_03 setmodel("cp_final_talisman_alt");
	var_03.angles = (0,360,0);
	var_03 hide();
	var_03 showtoplayer(param_00);
	var_03 thread talisman_start_flying(var_03,param_01);
	var_03 thread flying_talisman_damage_monitor(var_03,param_00);
}

//Function Number: 67
talisman_start_flying(param_00,param_01)
{
	param_00 endon("death");
	for(var_02 = 1;var_02 < param_01.size;var_02++)
	{
		var_03 = param_01[var_02];
		var_04 = distance(param_00.origin,var_03);
		var_05 = var_04 / 85;
		param_00 moveto(var_03,var_05);
		param_00 waittill("movedone");
		if(var_02 < param_01.size - 1)
		{
			var_06 = randomfloatrange(0.5,3.5);
			wait(var_06);
		}
	}

	param_00 delete();
}

//Function Number: 68
flying_talisman_damage_monitor(param_00,param_01)
{
	param_00 endon("death");
	param_00 setcandamage(1);
	param_00.health = 999999;
	for(;;)
	{
		param_00 waittill("damage",var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B);
		param_00.health = 999999;
		if(isplayer(var_03) && var_03 == param_01 && directors_cut_activated_for(param_01))
		{
			playfx(level._effect["sb_quest_item_pickup"],param_00.origin,anglestoforward(param_00.angles),anglestoup(param_00.angles),param_01);
			param_00 method_8429(param_01);
			param_01 setplayerdata("cp","dcq","cp_final",1);
			param_01 scripts\cp\_damage::func_12E84("hitaliensoft");
			param_01 scripts\cp\_merits::func_D9AD("mt_dc_5");
			if(scripts\common\utility::istrue(level.onlinegame))
			{
				param_01 setplayerdata("cp","hasSongsUnlocked","any_song",1);
				param_01 setplayerdata("cp","hasSongsUnlocked","song_11",1);
			}

			param_00 delete();
			return;
		}
	}
}