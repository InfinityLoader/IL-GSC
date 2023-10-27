/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_town\cp_town_mpq.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 151
 * Decompile Time: 7635 ms
 * Timestamp: 10/27/2023 12:07:40 AM
*******************************************************************/

//Function Number: 1
cp_town_mpq_init()
{
	lib_0D52::func_DED3("deathray",0,::func_4FF9,::deathray_step_1,::complete_deathray_step_1,::debug_deathray_step_1,1);
	lib_0D52::func_DED3("deathray",1,::func_4FF9,::deathray_step_2,::complete_deathray_step_2,::debug_deathray_step_2,1);
	lib_0D52::func_DED3("deathray",2,::func_4FF9,::deathray_step_3,::complete_deathray_step_3,::debug_deathray_step_3,1);
	lib_0D52::func_DED3("deathray",3,::func_4FF9,::deathray_step_4,::complete_deathray_step_4,::debug_deathray_step_4,1);
	lib_0D52::func_DED3("deathray",4,::func_4FF9,::deathray_step_5,::complete_deathray_step_5,::debug_deathray_step_5,1);
	lib_0D52::func_DED3("deathray",5,::func_4FF9,::deathray_step_6,::complete_deathray_step_6,::debug_deathray_step_6,1);
	lib_0D52::func_DED3("deathray",6,::func_4FF9,::deathray_step_7,::complete_deathray_step_7,::debug_deathray_step_7,1);
	lib_0D52::func_DED3("chemistry",0,::init_chemistry_step_1,::chemistry_step_1,::complete_chemistry_step_1,::debug_chemistry_step_1,2);
	lib_0D52::func_DED3("chemistry",1,::init_chemistry_step_2,::chemistry_step_2,::complete_chemistry_step_2,::debug_chemistry_step_2,2);
	lib_0D52::func_DED3("chemistry",2,::init_chemistry_step_3,::chemistry_step_3,::complete_chemistry_step_3,::debug_chemistry_step_3,2," Create & carry Chem Mix ");
	lib_0D52::func_DED3("chemistry",3,::init_chemistry_step_4,::chemistry_step_4,::complete_chemistry_step_4,::debug_chemistry_step_4,2," Add Chem Mix to bomb");
	lib_0D52::func_DED3("launchcode",0,::init_launchcode_step_1,::launchcode_step_1,::launchcode_step_1_complete,::launchcode_step_1_debug,3," Open safe");
	lib_0D52::func_DED3("launchcode",1,::func_4FF9,::launchcode_step_2,::launchcode_step_2_complete,::launchcode_step_2_debug,3," Take codes");
	lib_0D52::func_DED3("launchcode",2,::func_4FF9,::launchcode_step_3,::launchcode_step_3_complete,::launchcode_step_3_debug,3," Build bomb");
	lib_0D52::func_DED3("launchcode",3,::func_4FF9,::launchcode_step_4,::complete_launchcode_step_4,::debug_launchcode_step_4,3);
	level.mpq_arm_func = ::set_quake_flag_if_close_to_arm;
	level._effect["locker_key"] = loadfx("vfx/iw7/levels/cp_disco/Requests/vfx_locker_key.vfx");
	level._effect["ufo_glow_death"] = loadfx("vfx/iw7/levels/cp_town/alien/vfx_atomize_zombie.vfx");
	level._effect["life_ray_beam"] = loadfx("vfx/iw7/levels/cp_town/skq/vfx_life_beam.vfx");
	level._effect["life_ray_burst"] = loadfx("vfx/iw7/levels/cp_town/skq/vfx_revive_burst.vfx");
	level._effect["death_ray_beam"] = loadfx("vfx/iw7/levels/cp_town/skq/vfx_death_beam.vfx");
	level._effect["death_ray_vaporize"] = loadfx("vfx/iw7/_requests/mp/vfx_atomize_body.vfx");
	level._effect["torso_glow"] = loadfx("vfx/iw7/levels/cp_town/skq/vfx_part_torso_glow.vfx");
	level._effect["head_glow"] = loadfx("vfx/iw7/levels/cp_town/skq/vfx_part_head_glow.vfx");
	level._effect["meat_freeze"] = loadfx("vfx/iw7/levels/cp_town/skq/vfx_meat_freeze.vfx");
	level._effect["mirror_break"] = loadfx("vfx/iw7/levels/cp_town/skq/vfx_mirror_break.vfx");
	level._effect["turnstile_teleport"] = loadfx("vfx/iw7/levels/cp_town/vfx_town_telep_diss.vfx");
	init_zom_body();
	level thread spawn_film_reel_hints();
	level thread listen_for_zombie_spawn();
	level thread listen_for_death_by_cleaver();
	level thread listen_for_toilet_head();
	level thread listen_for_turnstile_damage();
	level thread listen_for_photo_change();
	level thread shuffle_film_reels();
	scripts\common\utility::flag_init("deathray_step1");
	scripts\common\utility::flag_init("deathray_step2");
	scripts\common\utility::flag_init("deathray_step3");
	scripts\common\utility::flag_init("deathray_step4");
	scripts\common\utility::flag_init("deathray_step5");
	scripts\common\utility::flag_init("deathray_step6");
	scripts\common\utility::flag_init("deathray_step7");
	scripts\common\utility::flag_init("chemistry_step1");
	scripts\common\utility::flag_init("chemistry_step2");
	scripts\common\utility::flag_init("chemistry_step3");
	scripts\common\utility::flag_init("chemistry_step4");
	scripts\common\utility::flag_init("launchcode_step1");
	scripts\common\utility::flag_init("launchcode_step2");
	scripts\common\utility::flag_init("launchcode_step3");
	scripts\common\utility::flag_init("launchcode_step4");
	scripts\common\utility::flag_init("frozen_meat_gone");
	scripts\common\utility::flag_init("quake_lifts_arm");
	scripts\common\utility::flag_init("allow_quake_lifts_arm");
}

//Function Number: 2
debug_bounce_laser()
{
	wait(10);
	for(;;)
	{
		bounce_laser("tag_origin_death_ray_fx","life_ray_beam","life_ray_burst");
		wait(10);
		bounce_laser("tag_origin_death_ray_fx","death_ray_beam","death_ray_vaporize");
		wait(10);
	}
}

//Function Number: 3
set_backstory_interaction_active_for_players()
{
	foreach(var_01 in level.players)
	{
		if(scripts\common\utility::istrue(var_01.played_backstory_vo))
		{
			scripts\cp\_interaction::func_175D(level.backstory_interactions[0],var_01);
			var_01.played_backstory_vo = 0;
		}
	}
}

//Function Number: 4
deathray_step_1()
{
	scripts\common\utility::flag_wait("deathray_step1");
}

//Function Number: 5
deathray_step_2()
{
	scripts\common\utility::flag_wait("deathray_step2");
}

//Function Number: 6
deathray_step_3()
{
	scripts\common\utility::flag_wait("deathray_step3");
}

//Function Number: 7
deathray_step_4()
{
	scripts\common\utility::flag_wait("deathray_step4");
}

//Function Number: 8
deathray_step_5()
{
	scripts\common\utility::flag_wait("deathray_step5");
}

//Function Number: 9
deathray_step_6()
{
	scripts\common\utility::flag_wait("deathray_step6");
}

//Function Number: 10
deathray_step_7()
{
	scripts\common\utility::flag_wait("deathray_step7");
}

//Function Number: 11
complete_deathray_step_1()
{
	scripts\common\utility::flag_set("deathray_step1");
	level thread set_backstory_interaction_active_for_players();
}

//Function Number: 12
complete_deathray_step_2()
{
	scripts\common\utility::flag_set("deathray_step2");
	level thread set_backstory_interaction_active_for_players();
}

//Function Number: 13
complete_deathray_step_3()
{
	scripts\common\utility::flag_set("deathray_step3");
	level thread set_backstory_interaction_active_for_players();
}

//Function Number: 14
complete_deathray_step_4()
{
	scripts\common\utility::flag_set("deathray_step4");
	level thread set_backstory_interaction_active_for_players();
}

//Function Number: 15
complete_deathray_step_5()
{
	scripts\common\utility::flag_set("deathray_step5");
	level thread set_backstory_interaction_active_for_players();
}

//Function Number: 16
complete_deathray_step_6()
{
	scripts\common\utility::flag_set("deathray_step6");
	level thread set_backstory_interaction_active_for_players();
}

//Function Number: 17
complete_deathray_step_7()
{
	scripts\common\utility::flag_set("deathray_step7");
	level thread set_backstory_interaction_active_for_players();
}

//Function Number: 18
debug_deathray_step_1()
{
	foreach(var_01 in level.mpq_zom_body_parts)
	{
		set_quest_omnvar_by_targetname(var_01);
		var_01 hide();
		wait(0.1);
	}

	level.leg_knocked_down = 1;
	var_03 = getent("mpq_zom_l_leg_part_ground","targetname");
	if(isdefined(var_03))
	{
		var_03 hide();
	}

	foreach(var_05, var_01 in level.mpq_zom_parts)
	{
		if(!isdefined(var_01.var_757B))
		{
			level thread glow_bed_part(var_05,var_01);
		}

		var_01 show();
		wait(0.1);
	}

	level.mpq_zom_parts_picked_up["head"] = 1;
	level.mpq_zom_parts_picked_up["torso"] = 1;
	level.mpq_zom_parts_picked_up["left_arm"] = 1;
	level.mpq_zom_parts_picked_up["right_arm"] = 1;
	level.mpq_zom_parts_picked_up["left_leg"] = 1;
	level.mpq_zom_parts_picked_up["right_leg"] = 1;
	level.mpq_zom_parts_index = level.mpq_zom_parts_picked_up.size;
}

//Function Number: 19
debug_deathray_step_2()
{
	var_00 = getent("mpq_punch_card","targetname");
	var_00 hide();
	set_quest_omnvar_by_targetname(var_00);
	level.punch_card_acquired = 1;
}

//Function Number: 20
debug_deathray_step_3()
{
	var_00 = getent("elvira_mirror","targetname");
	var_00 hide();
	level.mirrors_picked_up["elvira_mirror"] = 1;
	set_quest_omnvar_by_targetname(var_00);
	var_00 = getent("car_mirror","targetname");
	var_00 hide();
	var_00 = getent("car_mirror_ground","targetname");
	var_00 hide();
	level.mirrors_picked_up["car_mirror_ground"] = 1;
	set_quest_omnvar_by_targetname(var_00);
	var_00 = getent("bathroom_mirror_piece","targetname");
	var_00 hide();
	level.mirrors_picked_up["bathroom_mirror_piece"] = 1;
	set_quest_omnvar_by_targetname(var_00);
	var_01 = scripts\common\utility::getstructarray("mirror_placement","script_noteworthy");
	foreach(var_03 in var_01)
	{
		var_04 = scripts\common\utility::getstruct(var_03.target,"targetname");
		var_00 = spawn("script_model",var_04.origin);
		var_00.angles = var_04.angles;
		var_00 setmodel(var_04.script_noteworthy);
	}

	level.mirrors_placed["car_mirror"] = 1;
	level.mirrors_placed["bathroom_mirror"] = 1;
	level.mirrors_placed["elvira_mirror"] = 1;
}

//Function Number: 21
debug_deathray_step_4()
{
	foreach(var_01 in level.mpq_zom_parts)
	{
		var_01 hide();
	}

	level.knife_throw_target_body show();
	level.body_made = 1;
	level.terminal_unlocked = 1;
}

//Function Number: 22
debug_deathray_step_5()
{
	level.polarity_reversed = 1;
}

//Function Number: 23
debug_deathray_step_6()
{
	level.knife_throw_target_body hide();
	spawn_garage_key(level.knife_throw_target_body.origin);
	level.key_spawned = 1;
}

//Function Number: 24
debug_deathray_step_7()
{
	foreach(var_01 in level.mpq_zom_body_parts)
	{
		set_quest_omnvar_by_targetname(var_01);
		var_01 hide();
		wait(0.1);
	}

	level scripts\cp\_utility::set_completed_quest_mark(1);
	level.garage_key_found = 1;
}

//Function Number: 25
init_chemistry_step_1()
{
}

//Function Number: 26
init_chemistry_step_2()
{
}

//Function Number: 27
init_chemistry_step_3()
{
}

//Function Number: 28
init_chemistry_step_4()
{
}

//Function Number: 29
chemistry_step_1()
{
	scripts\common\utility::flag_wait("chemistry_step1");
}

//Function Number: 30
chemistry_step_2()
{
	scripts\common\utility::flag_wait("chemistry_step2");
}

//Function Number: 31
chemistry_step_3()
{
	scripts\common\utility::flag_wait("chemistry_step3");
}

//Function Number: 32
chemistry_step_4()
{
	scripts\common\utility::flag_wait("chemistry_step4");
}

//Function Number: 33
complete_chemistry_step_1()
{
	scripts\common\utility::flag_set("chemistry_step1");
	level thread set_backstory_interaction_active_for_players();
}

//Function Number: 34
complete_chemistry_step_2()
{
	scripts\common\utility::flag_set("chemistry_step2");
	level thread set_backstory_interaction_active_for_players();
}

//Function Number: 35
complete_chemistry_step_3()
{
	scripts\common\utility::flag_set("chemistry_step3");
	level thread set_backstory_interaction_active_for_players();
}

//Function Number: 36
complete_chemistry_step_4()
{
	scripts\common\utility::flag_set("chemistry_step4");
	level thread set_backstory_interaction_active_for_players();
}

//Function Number: 37
debug_chemistry_step_1()
{
}

//Function Number: 38
debug_chemistry_step_2()
{
}

//Function Number: 39
debug_chemistry_step_3()
{
}

//Function Number: 40
debug_chemistry_step_4()
{
}

//Function Number: 41
init_launchcode_step_1()
{
	scripts\common\utility::flag_init("teleporter_charged");
	scripts\common\utility::flag_init("teleporter_charging");
	level.teleporter_pieces_found = 0;
	level.teleporter_pieces_placed = 0;
	level.safe = getent("town_safe","targetname");
	level.gauge_trigs = getentarray("mpq_gauge_trig","targetname");
	level thread phase3_launchcode_interaction();
}

//Function Number: 42
launchcode_step_1()
{
	scripts\common\utility::array_thread(level.gauge_trigs,::phase3_watch_gauge_trigs);
	level thread phase3_create_safe_combo();
	scripts\common\utility::flag_wait("launchcode_step1");
}

//Function Number: 43
launchcode_step_1_complete()
{
	scripts\common\utility::flag_set("launchcode_step1");
	phase3_open_safe();
	level thread set_backstory_interaction_active_for_players();
}

//Function Number: 44
launchcode_step_1_debug()
{
}

//Function Number: 45
launchcode_step_2()
{
	scripts\common\utility::flag_wait("launchcode_step2");
}

//Function Number: 46
launchcode_step_2_complete()
{
	scripts\common\utility::flag_set("launchcode_step2");
	scripts\cp\_utility::set_quest_icon(20);
	level thread set_backstory_interaction_active_for_players();
}

//Function Number: 47
launchcode_step_2_debug()
{
}

//Function Number: 48
launchcode_step_3()
{
	scripts\cp\maps\cp_town\cp_town_crab_boss_fight::advance_pre_combat_stage();
	scripts\common\utility::flag_wait("launchcode_step3");
}

//Function Number: 49
launchcode_step_3_debug()
{
}

//Function Number: 50
launchcode_step_3_complete()
{
	scripts\common\utility::flag_set("launchcode_step3");
	level.teleporter_pieces_placed = 3;
	level.teleporter_pieces_found = 3;
	scripts\cp\_utility::set_quest_icon(16);
	scripts\cp\_utility::set_quest_icon(17);
	scripts\cp\_utility::set_quest_icon(18);
	scripts\common\utility::flag_set("launchcode_step3");
	level thread set_backstory_interaction_active_for_players();
}

//Function Number: 51
launchcode_step_4()
{
	scripts\common\utility::flag_wait("launchcode_step4");
}

//Function Number: 52
complete_launchcode_step_4()
{
	scripts\common\utility::flag_set("launchcode_step4");
	level thread set_backstory_interaction_active_for_players();
}

//Function Number: 53
debug_launchcode_step_4()
{
}

//Function Number: 54
init_mpq_interactions()
{
	scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1,"mpq_zom_body",undefined,undefined,::zom_body_bed_hint_func,::zom_body_bed_activation_func,0,0,::zom_body_bed_init_func,undefined);
	scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1,"mpq_zom_body_part",undefined,undefined,::zom_body_part_hint_func,::zom_body_part_activation_func,0,0,::zom_body_part_init_func,undefined);
	scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1,"mirror",undefined,undefined,::mirror_hint_func,::mirror_activation_func,0,0,::mirror_init_func,undefined);
	scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1,"mirror_placement",undefined,undefined,::mirror_placement_hint_func,::mirror_placement_activation_func,0,0,::mirror_placement_init_func,undefined);
	scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1,"punch_card",undefined,undefined,::punch_card_hint_func,::punch_card_activation_func,0,0,::punch_card_init_func,undefined);
	scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1,"ray_gun_start",undefined,undefined,::ray_gun_hint_func,::ray_gun_activation_func,0,0,::ray_gun_init_func,undefined);
	scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1,"garage_door",undefined,undefined,::garage_door_hint_func,::garage_door_activation_func,0,0,::garage_door_init_func,undefined);
	scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1,"mpq_ray_gun",undefined,undefined,::ray_gun_hint_func,::ray_gun_hint_func,0,0,::ray_gun_hint_func,undefined);
	level.interaction_hintstrings["take_launchcodes"] = "";
	level.interaction_hintstrings["bomb_teleporter_part"] = "";
	scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1,"take_launchcodes",undefined,undefined,undefined,::phase3_take_launch_codes,0,0);
	scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1,"bomb_teleporter_part",undefined,undefined,undefined,::phase3_take_bomb_part,0,0);
	scripts\cp\maps\cp_town\cp_town_interactions::town_register_interaction(1,"place_bomb_parts",undefined,undefined,::phase3_place_bomb_parts_hint,::phase3_place_bomb_parts,0,0);
}

//Function Number: 55
init_zom_body()
{
	var_00 = spawnstruct();
	var_00.origin = (4113.5,-4577.5,20);
	var_00.angles = (333.461,131.629,-2.74148);
	level.knife_throw_target_body = spawn("script_model",var_00.origin);
	level.knife_throw_target_body setmodel("fullbody_zmb_soldier");
	level.knife_throw_target_body.angles = var_00.angles;
	level.knife_throw_target_body scriptmodelplayanim("IW7_cp_zom_wheel_idle_01",1);
	level.knife_throw_target_body hide();
	level.zom_parts_placed = [];
}

//Function Number: 56
zom_body_bed_hint_func(param_00,param_01)
{
	return "";
}

//Function Number: 57
zom_body_bed_activation_func(param_00,param_01)
{
	if(isdefined(level.body_made) && isdefined(level.key_spawned))
	{
		if(isdefined(level.key_fx))
		{
			level scripts\cp\_utility::set_completed_quest_mark(1);
			level.key_fx delete();
			level.garage_key_found = 1;
			return;
		}

		return;
	}

	if(level.mpq_zom_parts_picked_up.size > level.mpq_zom_parts_index)
	{
		foreach(var_05, var_03 in level.mpq_zom_parts_picked_up)
		{
			level.zom_parts_placed[var_05] = 1;
			var_04 = level.mpq_zom_parts[var_05];
			if(!isdefined(var_04.var_757B))
			{
				level thread glow_bed_part(var_05,var_04);
			}

			var_04 show();
		}

		level.mpq_zom_parts_index = level.mpq_zom_parts_picked_up.size;
	}
}

//Function Number: 58
glow_bed_part(param_00,param_01)
{
	param_01.var_757B = spawn("script_model",param_01.origin);
	switch(param_00)
	{
		case "torso":
			param_01.var_757B.origin = param_01.var_757B.origin + (17,-17,50);
			param_01.fx_ent_2 = spawn("script_model",param_01.origin);
			param_01.fx_ent_2.origin = param_01.fx_ent_2.origin + (12,-12,35);
			param_01.fx_ent_2 setmodel("tag_origin_limb_glow_fx");
			break;

		case "head":
			param_01.var_757B.origin = param_01.var_757B.origin + (2,-2,15);
			break;

		case "left_arm":
			param_01.var_757B.origin = param_01.var_757B.origin + (-9,-9,3);
			break;

		case "right_arm":
			param_01.var_757B.origin = param_01.var_757B.origin + (8,8,6);
			break;

		case "left_leg":
			param_01.var_757B.origin = param_01.var_757B.origin + (-17,-5,-5);
			break;

		case "right_leg":
			param_01.var_757B.origin = param_01.var_757B.origin + (-5,10,-5);
			break;
	}

	param_01.var_757B setmodel("tag_origin_limb_glow_fx");
}

//Function Number: 59
zom_body_bed_init_func(param_00,param_01)
{
	level.mpq_zom_parts_index = 0;
	level.mpq_zom_parts = [];
	level.mpq_zom_parts["head"] = getent("mpq_zom_head","targetname");
	level.mpq_zom_parts["torso"] = getent("mpq_zom_torso","targetname");
	level.mpq_zom_parts["left_arm"] = getent("mpq_zom_l_arm","targetname");
	level.mpq_zom_parts["right_arm"] = getent("mpq_zom_r_arm","targetname");
	level.mpq_zom_parts["left_leg"] = getent("mpq_zom_l_leg","targetname");
	level.mpq_zom_parts["right_leg"] = getent("mpq_zom_r_leg","targetname");
	level.mpq_zom_parts_picked_up = [];
	foreach(var_03 in level.mpq_zom_parts)
	{
		var_03 hide();
	}

	level.life_ray_end = spawnstruct();
	level.life_ray_end.origin = (4116,-4575,60);
}

//Function Number: 60
zom_body_bed_can_use_override_func(param_00,param_01)
{
}

//Function Number: 61
spawn_garage_key(param_00)
{
	level.key_fx = spawnfx(level._effect["locker_key"],param_00 + (0,0,32));
	wait(0.2);
	triggerfx(level.key_fx);
}

//Function Number: 62
zom_body_part_init_func(param_00,param_01)
{
	if(!isdefined(level.mpq_zom_body_parts))
	{
		level.mpq_zom_body_parts = [];
	}

	level.mpq_zom_body_parts["head"] = getent("mpq_zom_head_part","targetname");
	level.mpq_zom_body_parts["torso"] = getent("mpq_zom_torso_part","targetname");
	level.mpq_zom_body_parts["left_arm"] = getent("mpq_zom_l_arm_part","targetname");
	level.mpq_zom_body_parts["right_arm"] = getent("mpq_zom_r_arm_part","targetname");
	level.mpq_zom_body_parts["left_leg"] = getent("mpq_zom_l_leg_part","targetname");
	level.mpq_zom_body_parts["right_leg"] = getent("mpq_zom_r_leg_part","targetname");
	var_02 = getent("mpq_zom_l_leg_part_ground","targetname");
	if(isdefined(var_02))
	{
		var_02 hide();
	}

	level thread listen_for_power_handle();
	level thread listen_for_leg_damage();
	level thread play_glow_on_parts();
	level thread update_struct_positions();
}

//Function Number: 63
update_struct_positions()
{
	wait(10);
	var_00 = scripts\common\utility::getstructarray("mirror","script_noteworthy");
	var_01 = scripts\common\utility::getclosest((5579,363.5,342),var_00,1000);
	var_01.origin = (5579,363.5,342);
	var_00 = scripts\common\utility::getstructarray("mpq_zom_body_part","script_noteworthy");
	var_01 = scripts\common\utility::getclosest((6242,-526,378),var_00,1000);
	var_01.origin = var_01.origin + (0,0,60);
	var_01 = scripts\common\utility::getclosest((-317,3665,475),var_00,1000);
	var_01.origin = (-327,3661,475);
	var_01 = scripts\common\utility::getclosest((3230,1868,-90),var_00,1000);
	var_01.origin = (3236,1878,-86);
}

//Function Number: 64
play_glow_on_parts()
{
	wait(5);
	foreach(var_02, var_01 in level.mpq_zom_body_parts)
	{
		var_01.var_757B = spawn("script_model",var_01.origin);
		wait(1);
		switch(var_02)
		{
			case "torso":
				var_01.var_757B.origin = var_01.var_757B.origin + (0,-5,50);
				break;

			case "head":
				var_01.var_757B.origin = var_01.var_757B.origin + (0,0,12);
				break;

			case "left_arm":
				var_01.var_757B.origin = var_01.var_757B.origin + (0,0,20);
				break;

			case "right_arm":
				var_01.var_757B.origin = var_01.var_757B.origin + (0,0,5);
				break;

			case "left_leg":
				var_01.var_757B.origin = var_01.var_757B.origin + (-20,-20,0);
				break;

			case "right_leg":
				break;
		}

		var_01.var_757B setmodel("tag_origin_limb_glow_fx");
		wait(1);
	}
}

//Function Number: 65
zom_body_part_hint_func(param_00,param_01)
{
	return "";
}

//Function Number: 66
zom_body_part_activation_func(param_00,param_01)
{
	var_02 = scripts\common\utility::getclosest(param_00.origin,level.mpq_zom_body_parts,500);
	var_03 = "none";
	foreach(var_06, var_05 in level.mpq_zom_body_parts)
	{
		if(var_02 == var_05)
		{
			var_03 = var_06;
		}
	}

	if(scripts\common\utility::istrue(level.mpq_zom_parts_picked_up[var_03]))
	{
		return;
	}

	if(var_03 == "left_arm")
	{
		if(!scripts\common\utility::flag("found_missing_handle"))
		{
			return;
		}

		if(!scripts\common\utility::flag("quake_lifts_arm"))
		{
			return;
		}
	}
	else if(var_03 == "torso")
	{
		if(!scripts\common\utility::flag("frozen_meat_gone"))
		{
			return;
		}
	}
	else if(var_03 == "left_leg")
	{
		if(!isdefined(level.leg_knocked_down))
		{
			return;
		}

		var_07 = getent("mpq_zom_l_leg_part_ground","targetname");
		var_07 hide();
	}

	set_quest_omnvar_by_targetname(var_02);
	param_01 playlocalsound("part_pickup");
	playfx(level._effect["generic_pickup"],var_02.origin);
	var_02 hide();
	level.mpq_zom_parts_picked_up[var_03] = 1;
	switch(var_02.var_336)
	{
		case "mpq_zom_head_part":
			param_01 thread scripts\cp\_vo::try_to_play_vo("key_phase_1_collect_head","town_comment_vo");
			break;

		case "mpq_zom_torso_part":
			param_01 thread scripts\cp\_vo::try_to_play_vo("key_phase_1_collect_torso","town_comment_vo");
			break;

		case "mpq_zom_l_arm_part":
			param_01 thread scripts\cp\_vo::try_to_play_vo("key_phase_1_collect_arms","town_comment_vo");
			break;

		case "mpq_zom_r_arm_part":
			param_01 thread scripts\cp\_vo::try_to_play_vo("key_phase_1_collect_arms","town_comment_vo");
			break;

		case "mpq_zom_l_leg_part":
			param_01 thread scripts\cp\_vo::try_to_play_vo("key_phase_1_collect_legs","town_comment_vo");
			break;

		case "mpq_zom_r_leg_part":
			param_01 thread scripts\cp\_vo::try_to_play_vo("key_phase_1_collect_legs","town_comment_vo");
			break;
	}

	var_02.var_757B setscriptablepartstate("muzzle_fx","inactive");
	wait(0.1);
	if(isdefined(var_02.var_757B))
	{
		var_02.var_757B delete();
	}
}

//Function Number: 67
set_quest_omnvar_by_targetname(param_00)
{
	var_01 = 0;
	switch(param_00.var_336)
	{
		case "mpq_zom_head_part":
			var_01 = 1;
			break;

		case "mpq_zom_torso_part":
			var_01 = 6;
			break;

		case "mpq_zom_l_arm_part":
			var_01 = 2;
			break;

		case "mpq_zom_r_arm_part":
			var_01 = 3;
			break;

		case "mpq_zom_l_leg_part":
			var_01 = 4;
			break;

		case "mpq_zom_r_leg_part":
			var_01 = 5;
			break;

		case "mpq_punch_card":
			var_01 = 10;
			break;

		case "car_mirror_ground":
		case "mirror":
			var_01 = 7;
			break;

		case "elvira_mirror":
			var_01 = 8;
			break;

		case "bathroom_mirror_piece":
			var_01 = 9;
			break;
	}

	if(var_01 > 0)
	{
		scripts\cp\_utility::set_quest_icon(var_01);
	}
}

//Function Number: 68
listen_for_power_handle()
{
	level.mpq_zom_body_parts["left_arm"].high_point = level.mpq_zom_body_parts["left_arm"].origin[2];
	var_00 = scripts\common\utility::getstructarray("mpq_zom_body_part","script_noteworthy");
	var_01 = scripts\common\utility::getclosest(level.mpq_zom_body_parts["left_arm"].origin,var_00);
	scripts\cp\_interaction::remove_from_current_interaction_list(var_01);
	scripts\common\utility::flag_wait("found_missing_handle");
	level thread play_arm_fx(0.25);
	level.mpq_zom_body_parts["left_arm"] movez(-16,1);
	scripts\common\utility::flag_set("allow_quake_lifts_arm");
	scripts\common\utility::flag_wait("quake_lifts_arm");
}

//Function Number: 69
play_arm_fx(param_00)
{
	playfx(level._effect["vfx_mini_stuck_impact"],level.mpq_zom_body_parts["left_arm"].origin);
}

//Function Number: 70
listen_for_leg_damage()
{
	var_00 = level.mpq_zom_body_parts["left_leg"];
	var_00 setcandamage(1);
	var_01 = 0;
	while(!var_01)
	{
		var_00 waittill("damage",var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B);
		if(isdefined(var_06) && is_explosive(var_06,var_08))
		{
			var_01 = 1;
			break;
		}

		wait(0.1);
	}

	knock_leg_down(var_00);
	level.leg_knocked_down = 1;
}

//Function Number: 71
knock_leg_down(param_00)
{
	var_01 = getent("mpq_zom_l_leg_part_ground","targetname");
	if(isdefined(var_01))
	{
		param_00 moveto(var_01.origin,1);
		param_00 rotateto(var_01.angles,1);
		wait(1);
		var_01.var_757B = param_00.var_757B;
		var_01 show();
		var_01.var_757B.origin = var_01.origin + (25,10,0);
		var_01.var_757B setmodel("tag_origin_limb_glow_fx");
		param_00 hide();
	}
}

//Function Number: 72
is_explosive(param_00,param_01)
{
	return param_00 == "MOD_EXPLOSIVE_BULLET" || param_00 == "MOD_EXPLOSIVE" || param_00 == "MOD_GRENADE_SPLASH" || param_00 == "MOD_PROJECTILE" || param_00 == "MOD_PROJECTILE_SPLASH";
}

//Function Number: 73
set_quake_flag_if_close_to_arm()
{
	self endon("death");
	if(scripts\common\utility::flag("quake_lifts_arm"))
	{
		return;
	}

	var_00 = 10000;
	var_01 = level.mpq_zom_body_parts["left_arm"];
	if(distancesquared(self.origin,var_01.origin) < var_00)
	{
		lift_arm_out_of_ground(var_01);
	}
}

//Function Number: 74
lift_arm_out_of_ground(param_00)
{
	self endon("death");
	wait(1);
	var_01 = 0;
	var_02 = param_00.origin + (0,0,16);
	while(param_00.origin[2] < param_00.high_point)
	{
		if(scripts\common\utility::flag("allow_quake_lifts_arm"))
		{
			playfx(level._effect["vfx_mini_stuck_release"],var_02);
			param_00 movez(4,0.25);
		}

		wait(3);
	}

	if(scripts\common\utility::flag("allow_quake_lifts_arm"))
	{
		scripts\common\utility::flag_set("quake_lifts_arm");
	}
}

//Function Number: 75
mirror_init_func(param_00,param_01)
{
	level.mirrors_picked_up = [];
}

//Function Number: 76
mirror_hint_func(param_00,param_01)
{
	return "";
}

//Function Number: 77
mirror_activation_func(param_00,param_01)
{
	if(level.mirrors_picked_up.size > 2)
	{
		return;
	}

	var_02 = param_00.name;
	if(isdefined(level.mirrors_picked_up[var_02]))
	{
		return;
	}

	if(var_02 == "car_mirror")
	{
		if(level.car_mirror_hit)
		{
			var_03 = getent("car_mirror_ground","targetname");
			set_quest_omnvar_by_targetname(var_03);
			param_01 playlocalsound("part_pickup");
			playfx(level._effect["generic_pickup"],var_03.origin);
			var_03 delete();
			level.mirrors_picked_up[var_02] = 1;
			param_01 thread scripts\cp\_vo::try_to_play_vo("key_phase_1_collect_mirror","town_comment_vo");
			return;
		}

		return;
	}

	if(var_03 == "bathroom_mirror")
	{
		if(level.bathroom_mirror_hit)
		{
			var_03 = getent("bathroom_mirror_piece","targetname");
			set_quest_omnvar_by_targetname(var_03);
			param_01 playlocalsound("part_pickup");
			playfx(level._effect["generic_pickup"],var_03.origin);
			var_03 delete();
			level.mirrors_picked_up[var_02] = 1;
			param_01 thread scripts\cp\_vo::try_to_play_vo("key_phase_1_collect_mirror","town_comment_vo");
			return;
		}
	}
}

//Function Number: 78
elvira_is_up()
{
	if(isdefined(level.elvira_ai))
	{
		return 0;
	}

	return 1;
}

//Function Number: 79
mirror_placement_init_func(param_00,param_01)
{
	level.mirrors_placed = [];
	level thread listen_for_mirror_damage();
}

//Function Number: 80
mirror_placement_hint_func(param_00,param_01)
{
	return "";
}

//Function Number: 81
mirror_placement_activation_func(param_00,param_01)
{
	if(level.mirrors_placed.size > 2)
	{
		return;
	}

	var_02 = param_00.name;
	if(!isdefined(level.mirrors_picked_up[var_02]))
	{
		return;
	}

	if(isdefined(level.mirrors_placed[var_02]))
	{
		return;
	}

	var_03 = scripts\common\utility::getstruct(param_00.target,"targetname");
	var_04 = spawn("script_model",var_03.origin);
	var_04.angles = var_03.angles;
	var_04 setmodel(var_03.script_noteworthy);
	level.mirrors_placed[var_02] = 1;
}

//Function Number: 82
get_model_for_mirror(param_00)
{
	var_01 = "";
	switch(param_00.name)
	{
		case "car_mirror":
			var_01 = "veh_civ_lnd_39_coupe_mirror_lft_frt_dmg";
			break;

		case "bathroom_mirror":
			var_01 = "cp_town_broken_mirror_shard";
			break;

		case "elvira_mirror":
			var_01 = "cp_town_elvira_mirror";
			break;

		default:
			break;
	}

	return var_01;
}

//Function Number: 83
listen_for_mirror_damage()
{
	var_00 = getent("mirror_car","targetname");
	var_00 method_8187("tag_mirror_right");
	var_01 = getent("car_mirror","targetname");
	var_01 thread hide_on_damage();
	var_02 = getent("bathroom_mirror","targetname");
	var_02 thread break_mirror_in_bathroom();
	var_03 = getent("frozen_meat","targetname");
	var_03 thread freeze_meat_in_locker();
}

//Function Number: 84
hide_on_damage()
{
	level.car_mirror_hit = 0;
	self setcandamage(1);
	var_00 = getent("car_mirror_ground","targetname");
	var_00 hide();
	for(;;)
	{
		self waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(isdefined(var_02) && isplayer(var_02) && var_05 == "MOD_MELEE" && var_02.var_4BF5 == "iw7_knife_zm_crowbar")
		{
			self hide();
			level.car_mirror_hit = 1;
			var_00 = getent("car_mirror_ground","targetname");
			var_00 show();
			break;
		}
	}

	wait(0.1);
	self delete();
}

//Function Number: 85
break_mirror_in_bathroom()
{
	level.bathroom_mirror_hit = 0;
	self setcandamage(1);
	var_00 = getent("bathroom_mirror_broken","targetname");
	var_00 hide();
	var_01 = getent("bathroom_mirror_piece","targetname");
	var_01 hide();
	for(;;)
	{
		self waittill("damage",var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B);
		if(isdefined(var_03) && isplayer(var_03) && var_06 == "MOD_MELEE" && var_03.var_4BF5 == "iw7_knife_zm_crowbar")
		{
			playfx(level._effect["mirror_break"],(-1060.77,3661.85,463.01),(0,0,-30));
			playsoundatpos((-1060,3661,463),"mpq_mirror_shatter");
			self hide();
			level.bathroom_mirror_hit = 1;
			var_00 = getent("bathroom_mirror_broken","targetname");
			var_00 show();
			var_0C = getent("bathroom_mirror_piece","targetname");
			var_0C show();
			break;
		}
	}
}

//Function Number: 86
freeze_meat_in_locker()
{
	level waittill("start_freeze_trap");
	self setcandamage(1);
	playfx(level._effect["meat_freeze"],(6263.18,-512,418.71),(0,0,-30));
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isdefined(var_01) && isplayer(var_01) && var_04 == "MOD_MELEE" && var_01.var_4BF5 == "iw7_knife_zm_crowbar")
		{
			playfx(level._effect["zombie_freeze_shatter"],(6263.18,-512,418.71));
			self hide();
			break;
		}
	}

	scripts\common\utility::flag_set("frozen_meat_gone");
}

//Function Number: 87
punch_card_init_func()
{
}

//Function Number: 88
punch_card_hint_func(param_00,param_01)
{
	return "";
}

//Function Number: 89
punch_card_activation_func(param_00,param_01)
{
	var_02 = getent("mpq_punch_card","targetname");
	var_02 hide();
	param_01 thread scripts\cp\_vo::try_to_play_vo("key_phase_1_collect_punchcard_pc","town_comment_vo");
	set_quest_omnvar_by_targetname(var_02);
	level.punch_card_acquired = 1;
}

//Function Number: 90
garage_door_init_func()
{
	wait(5);
	var_00 = getent("garage_door","targetname");
	var_00 movez(-96,3,0.5,0.1);
}

//Function Number: 91
garage_door_hint_func(param_00,param_01)
{
	return "";
}

//Function Number: 92
garage_door_activation_func(param_00,param_01)
{
	if(!isdefined(level.garage_key_found))
	{
		return;
	}

	if(scripts\common\utility::istrue(level.garage_door_open))
	{
		return;
	}

	var_02 = getent("garage_door","targetname");
	var_02 movez(96,3,0.5,0.1);
	playsoundatpos((4767,1233,431),"town_roll_up_garage_door");
	wait(1);
	var_03 = getent("garage_door_clip","targetname");
	var_03 notsolid();
	level.garage_door_open = 1;
	param_01 thread scripts\cp\_vo::try_to_play_vo("key_phase_1_success_garage","town_comment_vo");
	var_04 = scripts\cp\zombies\zombies_spawning::create_spawner("gas_station_street",(4795.6,1395.2,344),(0,163,0),"ground_spawn_no_boards","spawn_ground","dirt");
	var_04 scripts\cp\zombies\zombies_spawning::func_B287();
}

//Function Number: 93
ray_gun_init_func()
{
	level.ray_gun_interaction_structs = [];
	var_00 = scripts\common\utility::getstructarray("ray_gun_start","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_03 = scripts\common\utility::getstructarray(var_02.target,"targetname");
		foreach(var_05 in var_03)
		{
			switch(var_05.script_noteworthy)
			{
				case "bomb_counter":
					var_02.bomb_counter = var_05;
					var_05.origin = var_05.origin + (-0.1,-0.1,-23.9);
					if(!isdefined(var_05.angles))
					{
						var_02.bomb_counter.angles = (0,0,0);
					}
					break;

				case "bomb_status":
					var_02.bomb_status = var_05;
					if(!isdefined(var_05.angles))
					{
						var_02.bomb_status.angles = (0,0,0);
					}
					break;
			}
		}
	}
}

//Function Number: 94
ray_gun_hint_func(param_00,param_01)
{
	return "";
}

//Function Number: 95
ray_gun_activation_func(param_00,param_01)
{
	if(!isdefined(param_00.angles))
	{
		param_00.angles = (0,0,0);
	}

	if(!isdefined(level.punch_card_added))
	{
		if(isdefined(level.punch_card_acquired))
		{
			var_02 = getent("mpq_punch_card","targetname");
			var_02 show();
			var_03 = scripts\common\utility::getstruct("punch_card_slot","targetname");
			var_02.origin = var_03.origin;
			var_02.angles = var_03.angles;
			level.punch_card_added = 1;
			param_01 thread scripts\cp\_vo::try_to_play_vo("key_phase_1_collect_punchcard_generic","town_comment_vo");
			return;
		}

		return;
	}

	if(level.mpq_zom_parts_picked_up.size < level.mpq_zom_parts.size)
	{
		return;
	}

	if(!isdefined(level.terminal_unlocked))
	{
		ray_gun_terminal(var_02,var_03);
		if(!isdefined(level.terminal_unlocked))
		{
			level thread ray_fail_vo(var_03);
			return;
		}

		return;
	}

	if(!isdefined(level.body_made))
	{
		var_04 = scripts\common\utility::getstruct("mirror_laser_start","targetname");
		playsoundatpos(var_04.origin,"cp_town_life_death_ray");
		wait(1);
		wait(1);
		wait(1);
		bounce_laser("tag_origin_life_ray_fx","life_ray_beam","life_ray_burst");
		var_05 = level.mirrors_placed.size > 2;
		var_06 = level.zom_parts_placed.size > 5;
		if(var_05 && var_06)
		{
			foreach(var_08 in level.mpq_zom_parts)
			{
				var_08 hide();
				if(isdefined(var_08.var_757B))
				{
					var_08.var_757B delete();
				}

				if(isdefined(var_08.fx_ent_2))
				{
					var_08.fx_ent_2 delete();
				}
			}

			level.knife_throw_target_body show();
			level scripts\cp\_utility::set_completed_quest_mark(5);
			level.body_made = 1;
			var_0A = scripts\common\utility::random(level.players);
			if(isdefined(var_0A.var_134FD))
			{
				switch(var_0A.var_134FD)
				{
					case "p1_":
						level thread scripts\cp\_vo::try_to_play_vo("sally_life_ray_1","rave_dialogue_vo","highest",666,0,0,0,100);
						break;

					case "p2_":
						level thread scripts\cp\_vo::try_to_play_vo("pdex_life_ray_1","rave_dialogue_vo","highest",666,0,0,0,100);
						break;

					case "p3_":
						level thread scripts\cp\_vo::try_to_play_vo("andre_life_ray_1","rave_dialogue_vo","highest",666,0,0,0,100);
						break;

					case "p4_":
						level thread scripts\cp\_vo::try_to_play_vo("aj_life_ray_1","rave_dialogue_vo","highest",666,0,0,0,100);
						break;

					default:
						break;
				}

				return;
			}

			return;
		}

		return;
	}

	if(!isdefined(level.polarity_reversed))
	{
		ray_gun_terminal(var_06,var_07);
		if(!isdefined(level.polarity_reversed))
		{
			level thread ray_fail_vo(var_07);
			return;
		}

		return;
	}

	if(!isdefined(level.key_spawned))
	{
		var_0B = 1;
		if(var_0B)
		{
			level.key_spawned = 1;
			var_04 = scripts\common\utility::getstruct("mirror_laser_start","targetname");
			playsoundatpos(var_0B.origin,"cp_town_life_death_ray");
			wait(1);
			wait(1);
			wait(1);
			bounce_laser("tag_origin_death_ray_fx","death_ray_beam","death_ray_vaporize");
			level thread ray_fail_vo(var_06);
			level.knife_throw_target_body hide();
			spawn_garage_key(level.knife_throw_target_body.origin);
			var_0A = scripts\common\utility::random(level.players);
			if(isdefined(var_0A.var_134FD))
			{
				switch(var_0A.var_134FD)
				{
					case "p1_":
						level thread scripts\cp\_vo::try_to_play_vo("sally_death_ray_1","rave_dialogue_vo","highest",666,0,0,0,100);
						break;

					case "p2_":
						level thread scripts\cp\_vo::try_to_play_vo("pdex_death_ray_1","rave_dialogue_vo","highest",666,0,0,0,100);
						break;

					case "p3_":
						level thread scripts\cp\_vo::try_to_play_vo("andre_death_ray_1","rave_dialogue_vo","highest",666,0,0,0,100);
						break;

					case "p4_":
						level thread scripts\cp\_vo::try_to_play_vo("aj_death_ray_1","rave_dialogue_vo","highest",666,0,0,0,100);
						break;

					default:
						break;
				}

				return;
			}

			return;
		}

		return;
	}
}

//Function Number: 96
ray_fail_vo(param_00)
{
	param_00 thread scripts\cp\_vo::try_to_play_vo("key_phase_1_fail_liferay","town_comment_vo");
}

//Function Number: 97
bounce_laser(param_00,param_01,param_02)
{
	var_03 = scripts\common\utility::getstruct("mirror_laser_start","targetname");
	var_04 = spawn("script_model",var_03.origin);
	var_04.angles = var_03.angles;
	var_04 setmodel(param_00);
	wait(1);
	var_05 = scripts\common\utility::getstruct("mirror_spot_1","targetname");
	if(!scripts\common\utility::istrue(level.mirrors_placed["bathroom_mirror"]))
	{
		var_05 = scripts\common\utility::getstruct("mirror_spot_1","targetname");
		if(!isdefined(var_03.angles))
		{
			var_03.angles = (0,0,0);
		}

		function_02E0(level._effect[param_01],var_03.origin,var_03.angles,var_05.origin);
		wait(0.1);
		var_04 delete();
		return;
	}

	if(!isdefined(var_03.angles))
	{
		var_03.angles = (0,0,0);
	}

	function_02E0(level._effect[param_01],var_03.origin,var_03.angles,var_05.origin);
	wait(0.1);
	var_03 = var_05;
	var_05 = scripts\common\utility::getstruct("mirror_spot_2","targetname");
	if(!scripts\common\utility::istrue(level.mirrors_placed["elvira_mirror"]))
	{
		var_05 = scripts\common\utility::getstruct("mirror_spot_2","targetname");
		if(!isdefined(var_03.angles))
		{
			var_03.angles = (0,0,0);
		}

		function_02E0(level._effect[param_01],var_03.origin,var_03.angles,var_05.origin);
		wait(0.1);
		var_04 delete();
		return;
	}

	if(!isdefined(var_03.angles))
	{
		var_03.angles = (0,0,0);
	}

	function_02E0(level._effect[param_01],var_03.origin,var_03.angles,var_05.origin);
	wait(0.1);
	var_03 = var_05;
	var_05 = scripts\common\utility::getstruct("mirror_spot_3","targetname");
	if(!scripts\common\utility::istrue(level.mirrors_placed["car_mirror"]))
	{
		var_05 = scripts\common\utility::getstruct("mirror_spot_3","targetname");
		if(!isdefined(var_03.angles))
		{
			var_03.angles = (0,0,0);
		}

		function_02E0(level._effect[param_01],var_03.origin,var_03.angles,var_05.origin);
		wait(0.1);
		var_04 delete();
		return;
	}

	if(!isdefined(var_03.angles))
	{
		var_03.angles = (0,0,0);
	}

	function_02E0(level._effect[param_01],var_03.origin,var_03.angles,var_05.origin);
	wait(0.1);
	var_03 = var_05;
	var_05 = level.life_ray_end;
	if(!isdefined(var_03.angles))
	{
		var_03.angles = (0,0,0);
	}

	function_02E0(level._effect[param_01],var_03.origin,var_03.angles,var_05.origin);
	wait(0.1);
	playfx(level._effect[param_02],var_05.origin);
	var_04 delete();
}

//Function Number: 98
stop_and_fire()
{
	var_00 = 1440000;
	var_01 = level.spawned_enemies;
	var_02 = undefined;
	foreach(var_04 in var_01)
	{
		if(distance2dsquared(var_04.origin,self.origin) < var_00)
		{
			var_02 = var_04;
			break;
		}
	}

	if(!isdefined(var_02))
	{
		return;
	}

	wait(5);
	playfxontag(level._effect["death_ray_cannon_muzzle_flash"],self,"tag_origin");
	var_06 = self gettagorigin("tag_origin");
	var_07 = self gettagangles("tag_origin");
	function_02E0(level._effect["death_ray_cannon_beam"],var_06,var_07,var_02.origin);
	playfx(level._effect["death_ray_cannon_rock_impact"],var_02.origin);
	level thread make_glowing_zombies(var_02.origin);
	wait(5);
}

//Function Number: 99
make_glowing_zombies(param_00)
{
	var_01 = 160000;
	var_02 = sortbydistance(level.spawned_enemies,param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(distance2dsquared(var_02[var_03].origin,param_00) > var_01)
		{
			break;
		}

		var_02[var_03] set_glow_attributes();
	}
}

//Function Number: 100
listen_for_zombie_spawn()
{
	for(;;)
	{
		level waittill("agent_spawned",var_00);
		if(isdefined(var_00) && isdefined(var_00.agent_type) && var_00.agent_type == "generic_zombie")
		{
			if(scripts\common\utility::istrue(var_00.is_soldier))
			{
				var_00 set_glow_attributes();
			}
		}
	}
}

//Function Number: 101
set_glow_attributes()
{
	self.glowing = 1;
	self.full_gib = 1;
	self.nocorpse = 1;
	self.var_828A = "ufo_glow_death";
	self setscriptablepartstate("ufo_glow","active",1);
	self.var_1F5 = "sprint";
}

//Function Number: 102
listen_for_death_by_cleaver()
{
	level.death_by_cleaver = 0;
	while(!level.death_by_cleaver)
	{
		scripts\common\utility::func_136F7();
	}

	var_00 = scripts\common\utility::getstructarray("mpq_zom_body_part","script_noteworthy");
	var_01 = scripts\common\utility::getclosest(level.mpq_zom_body_parts["right_leg"].origin,var_00);
	level.mpq_zom_body_parts["right_leg"] notsolid();
	level.mpq_zom_body_parts["right_leg"].origin = level.death_by_cleaver_org + (0,0,-5);
	var_01.origin = level.death_by_cleaver_org + (-20,10,10);
	level.mpq_zom_body_parts["right_leg"].var_757B = spawn("script_model",level.death_by_cleaver_org + (-20,10,0));
	level.mpq_zom_body_parts["right_leg"].var_757B setmodel("tag_origin_limb_glow_fx");
}

//Function Number: 103
spawn_film_reel_hints()
{
	var_00 = spawn("script_model",(4070,-4190,16));
	wait(0.1);
	var_00 setmodel("cp_town_film_reel_case");
}

//Function Number: 104
listen_for_toilet_head()
{
	level endon("game_ended");
	while(!isdefined(level.players))
	{
		wait(0.1);
	}

	var_00 = scripts\common\utility::getstruct("toilet_head","targetname");
	var_01 = var_00.origin;
	var_02 = var_00.angles;
	level.toilet_head = spawn("script_model",var_01);
	level.toilet_head setmodel("zmb_male_head_01");
	level.toilet_head.angles = var_02;
	var_03 = scripts\common\utility::getstruct("toilet_head_spot","targetname");
	var_04 = 0;
	var_05 = 1600;
	while(!var_04)
	{
		foreach(var_07 in level.players)
		{
			if(distance2dsquared(var_03.origin,var_07.origin) < var_05)
			{
				var_08 = 0;
				var_09 = var_07 getstance();
				if(isdefined(var_07.chemical_base_picked) && var_07.chemical_base_picked == "animalfat" && var_09 == "prone")
				{
					var_08 = 1;
					level.toilet_head playsound("zmb_vo_base_male_pain");
					var_07 setclientomnvar("zm_chem_element_index",0);
					var_07.chemical_base_picked = undefined;
				}

				lift_head(var_08,var_07);
				var_04 = 1;
				break;
			}
		}

		wait(0.1);
	}

	level.toilet_head delete();
}

//Function Number: 105
lift_head(param_00,param_01)
{
	level.toilet_head movez(5,2,0.1,0.1);
	wait(5);
	if(param_00 == 1)
	{
		param_01 scripts\cp\_merits::func_D9AD("mt_dlc3_troll2");
	}

	level.toilet_head movez(-8,2,0.1,0.1);
	wait(3);
}

//Function Number: 106
ray_gun_terminal(param_00,param_01)
{
	enter_detonate_bomb_sequence(param_00,param_01);
	enter_bomb_code_internal(param_00,param_01);
}

//Function Number: 107
assign_nuclear_code(param_00,param_01,param_02)
{
	param_00.ray_gun_code = [];
	if(param_02)
	{
		for(var_03 = 5;var_03 > 0;var_03--)
		{
			param_00.ray_gun_code[5 - var_03] = param_01[var_03 - 1];
		}

		return;
	}

	for(var_03 = 0;var_03 < 5;var_03++)
	{
		param_00.ray_gun_code[var_03] = param_01[var_03];
	}
}

//Function Number: 108
shuffle_film_reels()
{
	var_00 = [3,4,5,6,8];
	var_01 = scripts\common\utility::array_randomize(var_00);
	for(var_02 = 1;var_02 < 6;var_02++)
	{
		var_03 = getent("film_reel_" + var_02,"targetname");
		var_03 setmodel("cp_town_film_reel_case_" + var_01[var_02 - 1]);
		wait(0.1);
	}

	level.liferaycode = var_01;
}

//Function Number: 109
enter_detonate_bomb_sequence(param_00,param_01)
{
	turn_off_other_hud(param_01);
	turn_on_bomb_status_light(param_00);
	param_01 allowmelee(0);
	param_01 method_80AA();
	param_01 scripts\common\utility::func_1C76(0);
}

//Function Number: 110
enter_bomb_code_internal(param_00,param_01)
{
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	param_01.bomb_interaction_struct = param_00;
	if(!isdefined(level.terminal_unlocked))
	{
		assign_nuclear_code(param_01,level.liferaycode,0);
	}
	else
	{
		assign_nuclear_code(param_01,level.liferaycode,1);
	}

	reset_nuclear_code_progress(param_01);
	transition_into_enter_bomb_code(param_00,param_01);
	turn_on_enter_bomb_code_hud(param_01,param_00);
	param_00 thread run_bomb_counters(param_01,param_00);
	param_00 thread bomb_counter_selected_monitor(param_01,param_00);
	param_00 thread player_exit_monitor(param_01,param_00);
	param_00 thread player_damage_exit_monitor(param_01,param_00);
}

//Function Number: 111
turn_on_bomb_status_light(param_00)
{
	var_01 = spawn("script_model",(4102.2,-4242.1,51));
	var_01 setmodel("crab_boss_origin");
	var_01.angles = param_00.bomb_status.angles;
	var_01 setscriptablepartstate("bomb_status","red");
	param_00.bomb_status_light = var_01;
}

//Function Number: 112
reset_nuclear_code_progress(param_00)
{
	param_00 setclientomnvar("zm_ui_dialpad_1",-1);
	param_00 setclientomnvar("zm_ui_dialpad_5",0);
	param_00.ray_gun_code_progress_index = 0;
	param_00.completed_ray_gun_code = "";
	param_00.times_input_wrong_digits = 0;
}

//Function Number: 113
transition_into_enter_bomb_code(param_00,param_01)
{
	var_02 = spawn("script_model",param_00.origin);
	var_02 setmodel("tag_origin");
	var_02.angles = param_00.angles + (34,0,0);
	var_02.origin = param_00.origin + scripts\cp\_utility::func_13192(anglestoforward(param_00.angles),3);
	param_00.anchor = var_02;
}

//Function Number: 114
run_bomb_counters(param_00,param_01)
{
	param_00 endon("disconnect");
	param_01 endon("stop_bomb_counter");
	for(;;)
	{
		for(var_02 = 0;var_02 < 10;var_02++)
		{
			param_00 setclientomnvar("zm_ui_dialpad_0",var_02 + 1);
			wait(0.1);
		}
	}
}

//Function Number: 115
bomb_counter_selected_monitor(param_00,param_01)
{
	param_00 endon("disconnect");
	param_01 endon("stop_bomb_counter");
	for(;;)
	{
		param_00 waittill("luinotifyserver",var_02,var_03);
		if(var_02 != "bomb_counter_digit")
		{
			continue;
		}

		if(correct_digit_entered(param_00,var_03))
		{
			advance_nuclear_code_progress(param_00,var_03);
			if(nuclear_code_completed(param_00))
			{
				player_complete_nuclear_code(param_01,param_00);
			}

			continue;
		}

		input_wrong_digit(param_01,param_00);
	}
}

//Function Number: 116
player_damage_exit_monitor(param_00,param_01)
{
	param_00 endon("disconnect");
	param_01 endon("stop_bomb_counter");
	for(;;)
	{
		param_00 waittill("damage");
		param_00 notify("luinotifyserver","exit_bomb_counter");
	}
}

//Function Number: 117
player_exit_monitor(param_00,param_01)
{
	param_00 endon("disconnect");
	param_01 endon("stop_bomb_counter");
	for(;;)
	{
		param_00 waittill("luinotifyserver",var_02);
		if(var_02 != "exit_bomb_counter")
		{
			continue;
		}

		param_01 thread delay_enable_interaction(param_01);
		param_01 thread exit_enter_bomb_code(param_01,param_00);
	}
}

//Function Number: 118
turn_on_enter_bomb_code_hud(param_00,param_01)
{
	var_02 = spawn("script_model",param_01.bomb_counter.origin);
	var_02 setmodel("tag_origin");
	var_02.origin = var_02.origin + (-0.2,0.25,0);
	var_02.angles = (0,335,0);
	var_02.angles = param_01.bomb_counter.angles;
	var_02.angles = (0,340.5,0);
	param_01.bomb_counter_ent = var_02;
	param_00 setclientomnvar("zm_ui_dialpad_ent",var_02);
	param_00 setclientomnvar("zm_ui_dialpad_2",2);
}

//Function Number: 119
turn_off_enter_bomb_code_hud(param_00)
{
	param_00 setclientomnvar("zm_ui_dialpad_2",0);
}

//Function Number: 120
reset_bomb_interaction_struct()
{
	level.num_of_ray_gun_code_entered = 0;
	foreach(var_01 in level.ray_gun_interaction_structs)
	{
		scripts\cp\_interaction::add_to_current_interaction_list(var_01);
	}
}

//Function Number: 121
correct_digit_entered(param_00,param_01)
{
	return param_01 == param_00.ray_gun_code[param_00.ray_gun_code_progress_index];
}

//Function Number: 122
input_wrong_digit(param_00,param_01)
{
	param_01.times_input_wrong_digits++;
	param_01 setclientomnvar("zm_ui_dialpad_5",param_01.times_input_wrong_digits);
	if(param_01.times_input_wrong_digits == 3)
	{
		wait(1);
		param_00 thread delay_enable_interaction(param_00);
		param_00 thread exit_enter_bomb_code(param_00,param_01);
	}
}

//Function Number: 123
advance_nuclear_code_progress(param_00,param_01)
{
	param_00.ray_gun_code_progress_index++;
	param_00.completed_ray_gun_code = param_00.completed_ray_gun_code + param_01;
	param_00 setclientomnvar("zm_ui_dialpad_1",int(param_00.completed_ray_gun_code));
}

//Function Number: 124
nuclear_code_completed(param_00)
{
	return param_00.ray_gun_code_progress_index == 5;
}

//Function Number: 125
player_complete_nuclear_code(param_00,param_01)
{
	param_01 setclientomnvar("zm_ui_dialpad_5",4);
	wait(2);
	level thread nuclear_bomb_armed_sequence(param_01);
	param_00.bomb_status_light setscriptablepartstate("bomb_status","green");
	exit_enter_bomb_code(param_00,param_01);
}

//Function Number: 126
delay_enable_interaction(param_00)
{
	wait(0.5);
	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
}

//Function Number: 127
exit_enter_bomb_code(param_00,param_01)
{
	end_detonate_bomb(param_01);
	param_00.anchor delete();
	param_01.bomb_interaction_struct = undefined;
	thread delay_enable_interaction(param_00);
	param_00 notify("stop_bomb_counter");
}

//Function Number: 128
nuclear_bomb_armed_sequence(param_00)
{
	if(!scripts\common\utility::istrue(level.terminal_unlocked))
	{
		level.terminal_unlocked = 1;
		return;
	}

	level.polarity_reversed = 1;
	var_01 = getentarray("death_ray_sign","targetname");
	foreach(var_03 in var_01)
	{
		var_03 setmodel("cp_town_camp_danger_deathraysign");
	}
}

//Function Number: 129
end_detonate_bomb(param_00)
{
	exit_detonate_bomb_sequence(param_00);
}

//Function Number: 130
clean_up_bomb_interaction_struct(param_00)
{
	if(isdefined(param_00.bomb_counter_ent))
	{
		param_00.bomb_counter_ent delete();
	}

	if(isdefined(param_00.bomb_status_light))
	{
		param_00.bomb_status_light delete();
	}
}

//Function Number: 131
exit_detonate_bomb_sequence(param_00)
{
	turn_off_enter_bomb_code_hud(param_00);
	turn_on_other_hud(param_00);
	param_00 enableweapons();
	param_00 scripts\common\utility::func_1C76(1);
	param_00 allowmelee(1);
}

//Function Number: 132
turn_off_other_hud(param_00)
{
	param_00 setclientomnvar("zm_ui_dialpad_4",1);
}

//Function Number: 133
turn_on_other_hud(param_00)
{
	param_00 setclientomnvar("zm_ui_dialpad_4",0);
}

//Function Number: 134
listen_for_turnstile_damage()
{
	var_00 = getent("turnstile","targetname");
	if(isdefined(var_00))
	{
		var_00 setcandamage(1);
		for(;;)
		{
			var_00 waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
			if(isdefined(var_02) && isplayer(var_02))
			{
				playfx(level._effect["turnstile_teleport"],var_00.origin);
				var_00 hide();
				var_02 scripts\cp\_merits::func_D9AD("mt_dlc3_troll");
				break;
			}

			wait(0.1);
		}
	}
}

//Function Number: 135
listen_for_photo_change()
{
	level waittill("crab_boss_beaten");
	var_00 = getent("hero_photo","targetname");
	var_00 setmodel("cp_town_space_hero_photos_01");
}

//Function Number: 136
phase3_watch_gauge_trigs()
{
	level endon("deathray_step1");
	self.gauge = getent(self.target,"targetname");
	self.gauge thread phase3_gauge_movement_logic();
	if(!isdefined(level.gauges))
	{
		level.gauges = [];
	}

	level.gauges = scripts\common\utility::array_add(level.gauges,self.gauge);
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isdefined(var_01) && isplayer(var_01) && var_04 == "MOD_MELEE" && var_01.var_4BF5 == "iw7_knife_zm_crowbar")
		{
			self.gauge playsound("mpq_gauge_hit");
			if(scripts\common\utility::istrue(self.gauge.stuck))
			{
				self.gauge.current_value = undefined;
				self.gauge.current_reading = undefined;
				self.gauge.stuck = undefined;
				self.gauge thread phase3_gauge_movement_logic();
				continue;
			}
			else
			{
				var_0A = self.gauge.angles;
				self.gauge notify("damaged");
				wait(0.1);
				self.gauge.angles = var_0A;
				self.gauge.current_value = var_0A;
				self.gauge.current_reading = phase3_get_gauge_reading(self.gauge);
				self.gauge.stuck = 1;
				var_0B = phase3_check_for_combo_complete();
				if(var_0B)
				{
					scripts\common\utility::flag_set("launchcode_step1");
					return;
				}
			}
		}
	}
}

//Function Number: 137
phase3_open_safe()
{
	scripts\common\utility::exploder(200);
	earthquake(0.45,1,level.safe.origin,256);
	playsoundatpos(level.safe.origin,"mpq_safe_open");
	level.safe setmodel("cp_town_safe_open");
	var_00 = scripts\common\utility::getstruct("take_launchcodes","script_noteworthy");
	scripts\cp\_interaction::add_to_current_interaction_list(var_00);
	var_01 = scripts\common\utility::random(level.players);
	if(isdefined(var_01.var_134FD))
	{
		switch(var_01.var_134FD)
		{
			case "p1_":
				level thread scripts\cp\_vo::try_to_play_vo("sally_safe_unlock_1","rave_dialogue_vo","highest",666,0,0,0,100);
				break;

			case "p2_":
				level thread scripts\cp\_vo::try_to_play_vo("pdex_safe_unlock_1","rave_dialogue_vo","highest",666,0,0,0,100);
				break;

			case "p3_":
				level thread scripts\cp\_vo::try_to_play_vo("andre_safe_unlock_1","rave_dialogue_vo","highest",666,0,0,0,100);
				break;

			case "p4_":
				level thread scripts\cp\_vo::try_to_play_vo("aj_safe_unlock_1","rave_dialogue_vo","highest",666,0,0,0,100);
				break;

			default:
				break;
		}
	}
}

//Function Number: 138
phase3_take_launch_codes(param_00,param_01)
{
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	var_02 = getent(param_00.target,"targetname");
	playfx(level._effect["generic_pickup"],var_02.origin);
	param_01 playlocalsound("zmb_item_pickup");
	var_02 delete();
	scripts\common\utility::flag_set("launchcode_step2");
}

//Function Number: 139
phase3_take_bomb_part(param_00,param_01)
{
	var_02 = getent(param_00.target,"targetname");
	if(!isdefined(var_02))
	{
		return;
	}

	switch(var_02.model)
	{
		case "cp_town_teleporter_device_projector":
			if(param_01 getstance() != "prone")
			{
				return;
			}
	
			scripts\cp\_utility::set_quest_icon(16);
			break;

		case "cp_town_teleporter_device_pipes":
			scripts\cp\_utility::set_quest_icon(17);
			break;

		default:
			scripts\cp\_utility::set_quest_icon(18);
			break;
	}

	playfx(level._effect["generic_pickup"],var_02.origin);
	param_01 playlocalsound("zmb_item_pickup");
	level.teleporter_pieces_found++;
	var_02 delete();
}

//Function Number: 140
phase3_get_gauge_reading(param_00)
{
	var_01 = 0;
	if(isdefined(param_00.current_value))
	{
		var_02 = int(param_00.current_value[2]);
		if(is_in_range(var_02,70,75))
		{
			var_01 = 0;
			param_00._current_value = (0,0,75);
			param_00.angles = (param_00.angles[0],param_00.angles[1],75);
		}
		else if(is_in_range(var_02,59,69))
		{
			var_01 = 1;
			param_00._current_value = (param_00.angles[0],param_00.angles[1],65);
			param_00.angles = (param_00.angles[0],param_00.angles[1],65);
		}
		else if(is_in_range(var_02,44,58))
		{
			var_01 = 2;
			param_00._current_value = (param_00.angles[0],param_00.angles[1],50);
			param_00.angles = (param_00.angles[0],param_00.angles[1],50);
		}
		else if(is_in_range(var_02,28,43))
		{
			var_01 = 3;
			param_00._current_value = (param_00.angles[0],param_00.angles[1],33);
			param_00.angles = (param_00.angles[0],param_00.angles[1],33);
		}
		else if(is_in_range(var_02,10,27))
		{
			var_01 = 4;
			param_00._current_value = (param_00.angles[0],param_00.angles[1],15);
			param_00.angles = (param_00.angles[0],param_00.angles[1],15);
		}
		else if(is_in_range(var_02,-7,9))
		{
			var_01 = 5;
			param_00._current_value = (param_00.angles[0],param_00.angles[1],0);
			param_00.angles = (param_00.angles[0],param_00.angles[1],0);
		}
		else if(is_in_range(var_02,-20,-8))
		{
			var_01 = 6;
			param_00._current_value = (param_00.angles[0],param_00.angles[1],-15);
			param_00.angles = (param_00.angles[0],param_00.angles[1],-15);
		}
		else if(is_in_range(var_02,-35,-21))
		{
			var_01 = 7;
			param_00._current_value = (param_00.angles[0],param_00.angles[1],-32);
			param_00.angles = (param_00.angles[0],param_00.angles[1],-32);
		}
		else if(is_in_range(var_02,-50,-36))
		{
			var_01 = 8;
			param_00._current_value = (param_00.angles[0],param_00.angles[1],-45);
			param_00.angles = (param_00.angles[0],param_00.angles[1],-45);
		}
		else if(is_in_range(var_02,-69,-51))
		{
			var_01 = 9;
			param_00._current_value = (param_00.angles[0],param_00.angles[1],-62);
			param_00.angles = (param_00.angles[0],param_00.angles[1],-62);
		}
		else
		{
			var_01 = 10;
			param_00._current_value = (0,0,-75);
			param_00.angles = (param_00.angles[0],param_00.angles[1],-75);
		}
	}
	else
	{
		var_01 = 0;
	}

	if(var_01 > 0)
	{
		var_03 = var_01;
	}
	else
	{
		var_03 = 0;
	}

	return var_03;
}

//Function Number: 141
is_in_range(param_00,param_01,param_02)
{
	if(param_00 >= param_01 && param_00 <= param_02)
	{
		return 1;
	}

	if(param_00 + 360 >= param_01 && param_00 + 360 <= param_02)
	{
		return 1;
	}

	if(param_00 - 360 >= param_01 && param_00 - 360 <= param_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 142
phase3_gauge_movement_logic()
{
	self endon("damaged");
	if(isdefined(self.var_C378))
	{
		self.angles = self.var_C378;
	}
	else
	{
		self.var_C378 = self.angles;
	}

	self rotateto((self.angles[0],self.angles[1],-75),randomfloatrange(0.15,0.4));
	self waittill("rotatedone");
	wait(0.1);
	for(;;)
	{
		wait(randomfloatrange(0.25,1.6));
		self rotateto((self.angles[0],self.angles[1],75),randomfloatrange(3,4));
		self waittill("rotatedone");
		wait(randomfloatrange(0.25,1.6));
		self rotateto((self.angles[0],self.angles[1],-75),randomfloatrange(3,4));
		self waittill("rotatedone");
	}
}

//Function Number: 143
phase3_create_safe_combo()
{
	wait(20);
	level.combo_numbers = [];
	level.combo_numbers["1"] = "geneva_building_number_signs_07";
	level.combo_numbers["2"] = "geneva_building_number_signs_01";
	level.combo_numbers["4"] = "geneva_building_number_signs_4_fix";
	level.combo_numbers["6"] = "geneva_building_number_signs_13";
	level.combo_numbers["7"] = "geneva_building_number_signs_04";
	level.combo_numbers["8"] = "geneva_building_number_signs_10";
	level.combo_numbers["9"] = "geneva_building_number_signs_19";
	var_00 = ["1","2","4","6","7","8","9"];
	var_01 = [];
	var_02 = "";
	var_03 = [];
	var_04 = getentarray("pressure_numbers","targetname");
	for(var_05 = 0;var_05 < 4;var_05++)
	{
		var_06 = scripts\common\utility::random(var_00);
		var_07 = level.combo_numbers[var_06];
		if(var_05 < 3)
		{
			var_02 = var_02 + "" + var_06 + ",";
		}
		else
		{
			var_02 = var_02 + "" + var_06 + "";
		}

		var_04[var_05] setmodel(var_07);
	}

	level.combo_numbers = var_02;
}

//Function Number: 144
phase3_check_for_combo_complete()
{
	var_00 = strtok(level.combo_numbers,",");
	foreach(var_02 in level.gauges)
	{
		if(!isdefined(var_02.current_reading))
		{
			return 0;
		}

		if(scripts\common\utility::func_2286(var_00,"" + var_02.current_reading))
		{
			var_03 = 0;
			var_04 = [];
			foreach(var_06 in var_00)
			{
				if(var_06 == "" + var_02.current_reading && !var_03)
				{
					var_03 = 1;
					continue;
				}

				var_04[var_04.size] = var_06;
			}

			var_00 = var_04;
			continue;
		}

		return 0;
	}

	return 1;
}

//Function Number: 145
phase3_place_bomb_parts_hint(param_00,param_01)
{
	if(scripts\common\utility::flag("teleporter_charged"))
	{
		return &"CP_TOWN_INTERACTIONS_TELEPORT_READY";
	}

	if(level.teleporter_pieces_placed < level.teleporter_pieces_found)
	{
		return &"CP_TOWN_INTERACTIONS_PLACE_BOMB_PIECE";
	}

	if(scripts\common\utility::flag("chemistry_step3") && !scripts\common\utility::flag("chemistry_step4"))
	{
		return &"CP_TOWN_INTERACTIONS_ADD_CHEMS";
	}

	if(scripts\common\utility::flag("chemistry_step4") && scripts\common\utility::flag("launchcode_step2") && scripts\common\utility::flag("launchcode_step3") && !scripts\common\utility::flag("launchcode_step4"))
	{
		return &"CP_TOWN_INTERACTIONS_ACTIVATE_TELEPORT";
	}

	return "";
}

//Function Number: 146
phase3_place_bomb_parts(param_00,param_01)
{
	if(scripts\common\utility::flag("chemistry_step3") && !scripts\common\utility::flag("chemistry_step4"))
	{
		if(isdefined(param_01.chemical_base_picked) && param_01.chemical_base_picked == level.bomb_compound.name)
		{
			param_01 thread scripts\cp\_vo::try_to_play_vo("key_phase_3_success_bomb_const","town_comment_vo");
			scripts\common\utility::flag_set("chemistry_step4");
			scripts\cp\maps\cp_town\cp_town_chemistry::set_chemical_carried_by_player_after_beaker_deposit(param_01,"");
			var_02 = getent("hero_photo","targetname");
			var_02 setmodel("cp_town_space_hero_photos_02");
			param_01 scripts\cp\_interaction::func_DE6E();
			return;
		}
		else
		{
			var_02 scripts\cp\_interaction::func_DE6E();
			return;
		}
	}

	if(scripts\common\utility::flag("teleporter_charged"))
	{
		foreach(var_04 in level.players)
		{
			if(distance2dsquared(var_04.origin,param_01.origin) > 9216)
			{
				return;
			}

			if(!var_04 usebuttonpressed())
			{
				return;
			}
		}

		var_06 = scripts\common\utility::getstruct("place_bomb_parts","script_noteworthy");
		var_07 = getent(var_06.target,"targetname");
		var_07 stoploopsound();
		scripts\cp\_utility::func_D52A("cp_town_bomb_charge_stop",var_07.origin);
		level notify("bomb_teleported");
		var_02 thread scripts\cp\_vo::try_to_play_vo("key_phase_3_success_bomb_teleport","town_comment_vo");
		var_02 scripts\cp\_interaction::remove_from_current_interaction_list(param_01);
		level thread phase3_teleport_bomb();
		return;
	}

	if(scripts\common\utility::flag("chemistry_step4") && scripts\common\utility::flag("launchcode_step2") && scripts\common\utility::flag("launchcode_step3") && !scripts\common\utility::flag("launchcode_step4"))
	{
		foreach(var_08 in level.players)
		{
			if(distance2dsquared(var_08.origin,var_05.origin) > 9216)
			{
				return;
			}

			if(!var_08 usebuttonpressed())
			{
				return;
			}
		}

		var_06 thread scripts\cp\_vo::try_to_play_vo("boss_charge_portal_first","town_comment_vo");
		var_06 scripts\cp\_interaction::remove_from_current_interaction_list(var_05);
		level thread phase3_charge_bomb_teleporter(var_05);
		return;
	}

	if(level.teleporter_pieces_found != level.teleporter_pieces_placed)
	{
		var_09 playlocalsound("zmb_coin_sounvenir_place");
	}

	while(level.teleporter_pieces_placed != level.teleporter_pieces_found)
	{
		level.teleporter_pieces_placed++;
		wait(0.05);
	}

	if(level.teleporter_pieces_placed == 3)
	{
		scripts\common\utility::flag_set("launchcode_step3");
		level thread play_teleporter_vo(var_09);
		var_09 scripts\cp\_interaction::func_DE6E();
	}
}

//Function Number: 147
play_teleporter_vo(param_00)
{
	param_00 endon("disconnect");
	param_00 thread scripts\cp\_vo::try_to_play_vo("key_phase_3_success_teleporter_craft","town_comment_vo");
	wait(scripts\cp\_vo::func_7C76("key_phase_3_success_teleporter_craft") + 10);
	param_00 thread scripts\cp\_vo::try_to_play_vo("boss_charge_portal_generic","town_comment_vo");
}

//Function Number: 148
phase3_charge_bomb_teleporter(param_00)
{
	level endon("bomb_teleported");
	level endon("game_ended");
	var_01 = scripts\common\utility::getstruct("place_bomb_parts","script_noteworthy");
	var_02 = getent(var_01.target,"targetname");
	playfxontag(level._effect["vfx_bomb_portal_chargeup"],var_02,"tag_bomb");
	var_02 playsound("cp_town_bomb_charge_start");
	var_02 playloopsound("cp_town_bomb_charge_lp");
	wait(20);
	var_02 stoploopsound("cp_town_bomb_charge_lp");
	var_02 playloopsound("cp_town_bomb_charged_up_lp");
	stopfxontag(level._effect["vfx_bomb_portal_chargeup"],var_02,"tag_bomb");
	playfxontag(level._effect["vfx_bomb_portal_charged"],var_02,"tag_bomb");
	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
	scripts\common\utility::flag_set("teleporter_charged");
	scripts\common\utility::func_6E2A("teleporter_charging");
	if(!scripts\common\utility::istrue(param_00.played_charging_vo))
	{
		scripts\cp\_vo::try_to_play_vo_on_all_players("boss_charge_portal_complete_first",0);
		param_00.played_charging_vo = 1;
	}
	else
	{
		scripts\cp\_vo::try_to_play_vo_on_all_players("boss_charge_portal_complete_generic",0);
	}

	wait(30);
	var_02 playsound("cp_town_bomb_charge_fail");
	var_02 stoploopsound("cp_town_bomb_charged_up_lp");
	stopfxontag(level._effect["vfx_bomb_portal_charged"],var_02,"tag_bomb");
	scripts\common\utility::func_6E2A("teleporter_charged");
	scripts\common\utility::func_6E2A("teleporter_charging");
}

//Function Number: 149
phase3_teleport_bomb()
{
	var_00 = scripts\common\utility::getstruct("place_bomb_parts","script_noteworthy");
	var_01 = getent(var_00.target,"targetname");
	playfx(level._effect["vfx_bomb_portal_out"],var_01.origin);
	var_01 delete();
	scripts\common\utility::flag_set("launchcode_step4");
	level notify("crab_boss_quest_completed");
}

//Function Number: 150
phase3_launchcode_interaction()
{
	wait(5);
	var_00 = scripts\common\utility::getstruct("take_launchcodes","script_noteworthy");
	scripts\cp\_interaction::remove_from_current_interaction_list(var_00);
}

//Function Number: 151
func_4FF9()
{
}