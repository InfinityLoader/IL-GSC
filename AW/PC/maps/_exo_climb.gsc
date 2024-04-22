/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _exo_climb.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 119
 * Decompile Time: 1928 ms
 * Timestamp: 4/22/2024 2:20:56 AM
*******************************************************************/

//Function Number: 1
load_precache()
{
	precachemodel("viewbody_generic_s1");
	precachemodel("viewbody_sentinel");
	precachemodel("viewbody_atlas_pmc_smp_custom");
	precachemodel("viewbody_atlas_military_smp");
	precachemodel("viewbody_atlas_military_smp_grapple");
	precacheitem("frag_grenade_var_exoclimb");
	precacheitem("tracking_grenade_var_exoclimb");
	precacheitem("contact_grenade_var_exoclimb");
	precacheitem("flash_grenade_var_exoclimb");
	precacheitem("emp_grenade_var_exoclimb");
	precacheitem("paint_grenade_var_exoclimb");
	precachestring(&"EXOCLIMB_CLIMB_HINT");
	precachestring(&"EXOCLIMB_CLIMB_HINT_PC");
	precacherumble("falling_land");
	precacherumble("damage_light");
	level._effect["exo_r_gloves_engage"] = loadfx("vfx/ui/exo_r_gloves_engage");
	level._effect["exo_l_gloves_engage"] = loadfx("vfx/ui/exo_l_gloves_engage");
	level._effect["exo_r_gloves_engage_slow"] = loadfx("vfx/ui/exo_r_gloves_engage_slow");
	level._effect["exo_l_gloves_engage_slow"] = loadfx("vfx/ui/exo_l_gloves_engage_slow");
	level._effect["exo_r_gloves_disengage"] = loadfx("vfx/ui/exo_r_gloves_disengage");
	level._effect["exo_l_gloves_disengage"] = loadfx("vfx/ui/exo_l_gloves_disengage");
	level._effect["dust_mag_r_glove_impact"] = loadfx("vfx/dust/dust_mag_r_glove_impact");
	level._effect["dust_mag_l_glove_impact"] = loadfx("vfx/dust/dust_mag_l_glove_impact");
	if(isdefined(1) && 1)
	{
		temp_exoclimb_hud_precache();
	}
}

//Function Number: 2
main(param_00)
{
	common_scripts\utility::flag_init("flag_exo_climbing_enabled");
	setup_climb_special_arrays();
	setup_climb_model(param_00);
	setup_climb_anims();
	setup_exo_climb_audio();
	verify_jump_mount_points();
	verify_mag_mount_points();
	get_climb_triggers();
	init_exoclimb_hud();
}

//Function Number: 3
is_exo_climbing()
{
	if(isdefined(level.exo_climb_rig))
	{
		return 1;
	}

	return 0;
}

//Function Number: 4
is_exoclimb_combat()
{
	if(!isdefined(level.exo_climb_rig.combatbuttonbuffer))
	{
		return 0;
	}

	if(climbing_helper_player_combat_requested())
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
is_exoclimb_cover()
{
	if(!isdefined(level.exo_climb_rig.crouch_button_reset))
	{
		return 0;
	}

	if(climbing_helper_player_exit_combat_mode_requested())
	{
		return 1;
	}

	return 0;
}

//Function Number: 6
is_exoclimb_jumped()
{
	if(!isdefined(level.exo_climb_rig.jumpbuttonbuffer))
	{
		return 0;
	}

	if(climbing_helper_player_jump_requested())
	{
		return 1;
	}

	return 0;
}

//Function Number: 7
is_exoclimb_mag_moved()
{
	if(!isdefined(level.exo_climb_rig.surface_state))
	{
		return 0;
	}

	if(climbing_helper_player_mag_moving())
	{
		return 1;
	}

	return 0;
}

//Function Number: 8
override_mount_anim(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = getentarray(param_00,"script_noteworthy");
	foreach(var_07 in var_05)
	{
		var_07.override_anim = param_01;
		var_07.override_anim_org = param_02;
		var_07.override_rig = param_03;
		var_07.override_view_angle_unclamp_time = param_04;
	}
}

//Function Number: 9
disable_mount_point(param_00)
{
	var_01 = getentarray(param_00,"script_noteworthy");
	foreach(var_03 in var_01)
	{
		var_03 notify("disable_mount_point");
	}
}

//Function Number: 10
enable_exoclimb_combat(param_00)
{
	if(isdefined(param_00) && !param_00)
	{
		level.exoclimb_combat_enabled = 0;
		return;
	}

	level.exoclimb_combat_enabled = 1;
}

//Function Number: 11
setup_climb_special_arrays()
{
	level.exo_climb_move_options = [];
	level.exo_climb_move_options["short"] = [];
	level.exo_climb_move_options["long"] = [];
	level.exo_climb_move_options["magnetic"] = [];
	level.exo_climb_move_options["jump2mag"] = [];
	level.exo_climb_move_options["mag2jump"] = [];
	level.exo_climb_anim_offsets = [];
	level.exo_climb_weapon = [];
}

//Function Number: 12
add_shake_and_rumble_notetracks_for_jump(param_00)
{
	maps\_anim::addnotetrack_customfunction("player_climb_rig","jump_rumble",::exo_climb_jump_rumble,param_00);
	maps\_anim::addnotetrack_customfunction("player_climb_rig","jump_shake",::exo_climb_jump_shake,param_00);
}

//Function Number: 13
add_shake_and_rumble_notetracks_for_grab(param_00)
{
	maps\_anim::addnotetrack_customfunction("player_climb_rig","grab_rumble",::exo_climb_grab_rumble,param_00);
	maps\_anim::addnotetrack_customfunction("player_climb_rig","grab_shake",::exo_climb_grab_shake,param_00);
}

//Function Number: 14
add_shake_and_rumble_notetracks(param_00)
{
	add_shake_and_rumble_notetracks_for_jump(param_00);
	add_shake_and_rumble_notetracks_for_grab(param_00);
}

//Function Number: 15
add_mag_move_notetracks(param_00)
{
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::exo_climb_allow_player_input_1,param_00);
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input_2",::exo_climb_allow_player_input_2,param_00);
}

//Function Number: 16
setup_climb_model(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		level.scr_model["player_climb_rig"] = "viewbody_generic_s1";
		return;
	}

	if(param_00 == "atlas_pmc")
	{
		level.scr_model["player_climb_rig"] = "viewbody_atlas_pmc_smp_custom";
		return;
	}

	if(param_00 == "atlas_army")
	{
		if(isdefined(param_01))
		{
			level.scr_model["player_climb_rig"] = "viewbody_atlas_military_smp_grapple";
			return;
		}

		level.scr_model["player_climb_rig"] = "viewbody_atlas_military_smp";
		return;
	}

	if(param_00 == "sentinel")
	{
		level.scr_model["player_climb_rig"] = "viewbody_sentinel";
		return;
	}
}

//Function Number: 17
setup_climb_anims()
{
	level.scr_animtree["player_climb_rig"] = #animtree;
	level.scr_anim["player_climb_rig"]["mount2jump"] = %vm_exoclimb_mount;
	level.scr_anim["player_climb_rig"]["mount2mag"] = %vm_exoclimb_mag_mount_up;
	level.scr_anim["player_climb_rig"]["mount_override"] = undefined;
	level.scr_anim["player_climb_rig"]["dismount"] = %vm_exoclimb_dismount_down;
	level.scr_anim["player_climb_rig"]["idle"][0] = %vm_exoclimb_idle;
	level.scr_anim["player_climb_rig"]["idleleft"][0] = %vm_exoclimb_idle_left;
	level.scr_anim["player_climb_rig"]["idleright"][0] = %vm_exoclimb_idle_right;
	level.scr_anim["player_climb_rig"]["idleleft_back"][0] = %vm_exoclimb_idle_left_back;
	level.scr_anim["player_climb_rig"]["idleright_back"][0] = %vm_exoclimb_idle_right_back;
	level.scr_anim["player_climb_rig"]["idle_magnetic_gloves"][0] = %vm_exoclimb_mag_idle;
	level.scr_anim["player_climb_rig"]["combat_idle"][0] = %vm_exoclimb_combat_idle;
	level.scr_anim["player_climb_rig"]["combat_idle_left"][0] = %vm_exoclimb_combat_idle_left;
	level.scr_anim["player_climb_rig"]["combat_idle_right"][0] = %vm_exoclimb_combat_idle_right;
	level.scr_anim["player_climb_rig"]["climb_to_combat_idle"] = %vm_exoclimb_climb_idle_to_combat_idle;
	level.scr_anim["player_climb_rig"]["combat_to_climb_idle"] = %vm_exoclimb_combat_idle_to_climb_idle;
	level.scr_anim["player_climb_rig"]["combat_center_to_left"] = %vm_exoclimb_combat_idle_to_combat_idle_left;
	level.scr_anim["player_climb_rig"]["combat_left_to_center"] = %vm_exoclimb_combat_idle_left_to_combat_idle;
	level.scr_anim["player_climb_rig"]["combat_center_to_right"] = %vm_exoclimb_combat_idle_to_combat_idle_right;
	level.scr_anim["player_climb_rig"]["combat_right_to_center"] = %vm_exoclimb_combat_idle_right_to_combat_idle;
	level.scr_anim["player_climb_rig"]["normal_long_d"] = %vm_exoclimb_jump_2;
	level.scr_anim["player_climb_rig"]["normal_long_l"] = %vm_exoclimb_jump_4;
	level.scr_anim["player_climb_rig"]["normal_long_r"] = %vm_exoclimb_jump_6;
	level.scr_anim["player_climb_rig"]["normal_long_u"] = %vm_exoclimb_jump_8;
	level.scr_anim["player_climb_rig"]["magnetic_u_0"] = %vm_exoclimb_mag_up_00;
	level.scr_anim["player_climb_rig"]["magnetic_u_1"] = %vm_exoclimb_mag_up_01;
	level.scr_anim["player_climb_rig"]["magnetic_u_2"] = %vm_exoclimb_mag_up_02;
	level.scr_anim["player_climb_rig"]["magnetic_d_0"] = %vm_exoclimb_mag_down_00;
	level.scr_anim["player_climb_rig"]["magnetic_d_1"] = %vm_exoclimb_mag_down_01;
	level.scr_anim["player_climb_rig"]["magnetic_d_2"] = %vm_exoclimb_mag_down_02;
	level.scr_anim["player_climb_rig"]["magnetic_l_0"] = %vm_exoclimb_mag_left_00;
	level.scr_anim["player_climb_rig"]["magnetic_l_1"] = %vm_exoclimb_mag_left_01;
	level.scr_anim["player_climb_rig"]["magnetic_l_2"] = %vm_exoclimb_mag_left_02;
	level.scr_anim["player_climb_rig"]["magnetic_r_0"] = %vm_exoclimb_mag_right_00;
	level.scr_anim["player_climb_rig"]["magnetic_r_1"] = %vm_exoclimb_mag_right_01;
	level.scr_anim["player_climb_rig"]["magnetic_r_2"] = %vm_exoclimb_mag_right_02;
	level.scr_anim["player_climb_rig"]["jump2mag_u"] = %vm_exoclimb_jump2mag_up;
	level.scr_anim["player_climb_rig"]["jump2mag_d"] = %vm_exoclimb_jump2mag_down;
	level.scr_anim["player_climb_rig"]["jump2mag_l"] = %vm_exoclimb_jump2mag_left;
	level.scr_anim["player_climb_rig"]["jump2mag_r"] = %vm_exoclimb_jump2mag_right;
	level.scr_anim["player_climb_rig"]["mag2jump_u"] = %vm_exoclimb_mag2jump_up;
	level.scr_anim["player_climb_rig"]["mag2jump_d"] = %vm_exoclimb_mag2jump_down;
	level.scr_anim["player_climb_rig"]["mag2jump_l"] = %vm_exoclimb_mag2jump_left;
	level.scr_anim["player_climb_rig"]["mag2jump_r"] = %vm_exoclimb_mag2jump_right;
	level.scr_anim["player_climb_rig"]["idle_to_idleleft"] = %vm_exoclimb_idle_to_idle_left;
	level.scr_anim["player_climb_rig"]["idleleft_to_idle"] = %vm_exoclimb_idle_left_to_idle;
	level.scr_anim["player_climb_rig"]["idle_to_idleright"] = %vm_exoclimb_idle_to_idle_right;
	level.scr_anim["player_climb_rig"]["idleright_to_idle"] = %vm_exoclimb_idle_right_to_idle;
	level.scr_anim["player_climb_rig"]["idleleft_to_idleleftback"] = %vm_exoclimb_idle_left_to_idle_left_back;
	level.scr_anim["player_climb_rig"]["idleleftback_to_idleleft"] = %vm_exoclimb_idle_left_back_to_idle_left;
	level.scr_anim["player_climb_rig"]["idleright_to_idlerightback"] = %vm_exoclimb_idle_right_to_idle_right_back;
	level.scr_anim["player_climb_rig"]["idlerightback_to_idleright"] = %vm_exoclimb_idle_right_back_to_idle_right;
	level.scr_anim["player_climb_rig"]["special_short_l_90convex"] = %vm_exoclimb_move_in_90_4;
	level.scr_anim["player_climb_rig"]["special_short_r_90convex"] = %vm_exoclimb_move_in_90_6;
	level.scr_anim["player_climb_rig"]["special_long_l_90concave2"] = %vm_exoclimb_jump_90_4_2;
	level.scr_anim["player_climb_rig"]["special_long_r_90concave2"] = %vm_exoclimb_jump_90_6_2;
	setup_climb_anims_parse_anim_offsets(level.scr_anim["player_climb_rig"]);
	add_shake_and_rumble_notetracks("normal_long_u");
	add_shake_and_rumble_notetracks("normal_long_d");
	add_shake_and_rumble_notetracks("normal_long_r");
	add_shake_and_rumble_notetracks("normal_long_l");
	add_shake_and_rumble_notetracks("special_long_l_90concave2");
	add_shake_and_rumble_notetracks("special_long_r_90concave2");
	add_shake_and_rumble_notetracks("mount2jump");
	add_shake_and_rumble_notetracks("mount2mag");
	add_shake_and_rumble_notetracks("jump2mag_u");
	add_shake_and_rumble_notetracks("jump2mag_d");
	add_shake_and_rumble_notetracks("jump2mag_l");
	add_shake_and_rumble_notetracks("jump2mag_r");
	add_shake_and_rumble_notetracks_for_grab("mag2jump_u");
	add_shake_and_rumble_notetracks_for_grab("mag2jump_d");
	add_shake_and_rumble_notetracks_for_grab("mag2jump_l");
	add_shake_and_rumble_notetracks_for_grab("mag2jump_r");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","jump_rumble",::exo_climb_jump_rumble,"dismount");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","jump_shake",::exo_climb_jump_shake,"dismount");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","mag_rumble",::exo_climb_mag_rumble,"magnetic_d_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","mag_rumble",::exo_climb_mag_rumble,"magnetic_d_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","mag_rumble",::exo_climb_mag_rumble,"magnetic_d_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","vm_swap",::exo_climb_draw_weapon,"climb_to_combat_idle");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::exo_climb_allow_player_input_1,"normal_long_u");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::exo_climb_allow_player_input_1,"normal_long_d");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::exo_climb_allow_player_input_1,"normal_long_r");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::exo_climb_allow_player_input_1,"normal_long_l");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::exo_climb_allow_player_input_1,"special_long_l_90concave2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::exo_climb_allow_player_input_1,"special_long_r_90concave2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::exo_climb_allow_player_input_1,"special_short_l_90convex");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::exo_climb_allow_player_input_1,"special_short_r_90convex");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::exo_climb_allow_player_input_1,"jump2mag_u");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::exo_climb_allow_player_input_1,"jump2mag_d");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::exo_climb_allow_player_input_1,"jump2mag_l");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::exo_climb_allow_player_input_1,"jump2mag_r");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::exo_climb_allow_player_input_1,"mag2jump_u");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::exo_climb_allow_player_input_1,"mag2jump_d");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::exo_climb_allow_player_input_1,"mag2jump_l");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","player_input",::exo_climb_allow_player_input_1,"mag2jump_r");
	add_mag_move_notetracks("magnetic_u_0");
	add_mag_move_notetracks("magnetic_u_1");
	add_mag_move_notetracks("magnetic_u_2");
	add_mag_move_notetracks("magnetic_d_0");
	add_mag_move_notetracks("magnetic_d_1");
	add_mag_move_notetracks("magnetic_d_2");
	add_mag_move_notetracks("magnetic_l_0");
	add_mag_move_notetracks("magnetic_l_1");
	add_mag_move_notetracks("magnetic_l_2");
	add_mag_move_notetracks("magnetic_r_0");
	add_mag_move_notetracks("magnetic_r_1");
	add_mag_move_notetracks("magnetic_r_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_engage",::fx_exo_climb_rglove_engage,"magnetic_u_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_engage",::fx_exo_climb_lglove_engage,"magnetic_u_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_disengage",::fx_exo_climb_rglove_disengage,"magnetic_u_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_disengage",::fx_exo_climb_lglove_disengage,"magnetic_u_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_engage",::fx_exo_climb_rglove_engage,"magnetic_u_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_engage",::fx_exo_climb_lglove_engage,"magnetic_u_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_disengage",::fx_exo_climb_rglove_disengage,"magnetic_u_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_disengage",::fx_exo_climb_lglove_disengage,"magnetic_u_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_engage",::fx_exo_climb_rglove_engage,"magnetic_u_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_engage",::fx_exo_climb_lglove_engage,"magnetic_u_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_disengage",::fx_exo_climb_rglove_disengage,"magnetic_u_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_disengage",::fx_exo_climb_lglove_disengage,"magnetic_u_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_engage",::fx_exo_climb_rglove_engage,"magnetic_d_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_engage",::fx_exo_climb_lglove_engage,"magnetic_d_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_disengage",::fx_exo_climb_rglove_disengage,"magnetic_d_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_disengage",::fx_exo_climb_lglove_disengage,"magnetic_d_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_engage",::fx_exo_climb_rglove_engage,"magnetic_d_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_engage",::fx_exo_climb_lglove_engage,"magnetic_d_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_disengage",::fx_exo_climb_rglove_disengage,"magnetic_d_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_disengage",::fx_exo_climb_lglove_disengage,"magnetic_d_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_engage",::fx_exo_climb_rglove_engage,"magnetic_d_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_engage",::fx_exo_climb_lglove_engage,"magnetic_d_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_disengage",::fx_exo_climb_rglove_disengage,"magnetic_d_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_disengage",::fx_exo_climb_lglove_disengage,"magnetic_d_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_engage",::fx_exo_climb_rglove_engage,"magnetic_l_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_engage",::fx_exo_climb_lglove_engage,"magnetic_l_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_disengage",::fx_exo_climb_rglove_disengage,"magnetic_l_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_disengage",::fx_exo_climb_lglove_disengage,"magnetic_l_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_engage",::fx_exo_climb_rglove_engage,"magnetic_l_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_engage",::fx_exo_climb_lglove_engage,"magnetic_l_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_disengage",::fx_exo_climb_rglove_disengage,"magnetic_l_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_disengage",::fx_exo_climb_lglove_disengage,"magnetic_l_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_engage",::fx_exo_climb_rglove_engage,"magnetic_l_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_engage",::fx_exo_climb_lglove_engage,"magnetic_l_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_disengage",::fx_exo_climb_rglove_disengage,"magnetic_l_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_disengage",::fx_exo_climb_lglove_disengage,"magnetic_l_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_engage",::fx_exo_climb_rglove_engage,"magnetic_r_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_engage",::fx_exo_climb_lglove_engage,"magnetic_r_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_disengage",::fx_exo_climb_rglove_disengage,"magnetic_r_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_disengage",::fx_exo_climb_lglove_disengage,"magnetic_r_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_engage",::fx_exo_climb_rglove_engage,"magnetic_r_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_engage",::fx_exo_climb_lglove_engage,"magnetic_r_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_disengage",::fx_exo_climb_rglove_disengage,"magnetic_r_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_disengage",::fx_exo_climb_lglove_disengage,"magnetic_r_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_engage",::fx_exo_climb_rglove_engage,"magnetic_r_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_engage",::fx_exo_climb_lglove_engage,"magnetic_r_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_disengage",::fx_exo_climb_rglove_disengage,"magnetic_r_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_disengage",::fx_exo_climb_lglove_disengage,"magnetic_r_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_engage",::fx_exo_climb_rglove_engage,"jump2mag_u");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_engage",::fx_exo_climb_lglove_engage,"jump2mag_u");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_disengage",::fx_exo_climb_rglove_disengage,"jump2mag_u");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_disengage",::fx_exo_climb_lglove_disengage,"jump2mag_u");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_engage",::fx_exo_climb_rglove_engage,"jump2mag_d");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_engage",::fx_exo_climb_lglove_engage,"jump2mag_d");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_disengage",::fx_exo_climb_rglove_disengage,"jump2mag_d");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_disengage",::fx_exo_climb_lglove_disengage,"jump2mag_d");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_engage",::fx_exo_climb_rglove_engage,"jump2mag_l");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_engage",::fx_exo_climb_lglove_engage,"jump2mag_l");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_disengage",::fx_exo_climb_rglove_disengage,"jump2mag_l");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_disengage",::fx_exo_climb_lglove_disengage,"jump2mag_l");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_engage",::fx_exo_climb_rglove_engage,"jump2mag_r");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_engage",::fx_exo_climb_lglove_engage,"jump2mag_r");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_disengage",::fx_exo_climb_rglove_disengage,"jump2mag_r");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_disengage",::fx_exo_climb_lglove_disengage,"jump2mag_r");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_engage",::fx_exo_climb_rglove_engage,"mag2jump_u");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_engage",::fx_exo_climb_lglove_engage,"mag2jump_u");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_disengage",::fx_exo_climb_rglove_disengage,"mag2jump_u");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_disengage",::fx_exo_climb_lglove_disengage,"mag2jump_u");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_engage",::fx_exo_climb_rglove_engage,"mag2jump_d");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_engage",::fx_exo_climb_lglove_engage,"mag2jump_d");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_disengage",::fx_exo_climb_rglove_disengage,"mag2jump_d");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_disengage",::fx_exo_climb_lglove_disengage,"mag2jump_d");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_engage",::fx_exo_climb_rglove_engage,"mag2jump_l");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_engage",::fx_exo_climb_lglove_engage,"mag2jump_l");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_disengage",::fx_exo_climb_rglove_disengage,"mag2jump_l");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_disengage",::fx_exo_climb_lglove_disengage,"mag2jump_l");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_engage",::fx_exo_climb_rglove_engage,"mag2jump_r");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_engage",::fx_exo_climb_lglove_engage,"mag2jump_r");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_disengage",::fx_exo_climb_rglove_disengage,"mag2jump_r");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_disengage",::fx_exo_climb_lglove_disengage,"mag2jump_r");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_engage",::fx_exo_climb_rglove_engage,"mount2mag");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_engage",::fx_exo_climb_lglove_engage,"mount2mag");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_disengage",::fx_exo_climb_rglove_disengage,"mount2mag");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_disengage",::fx_exo_climb_lglove_disengage,"mount2mag");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_engage",::fx_exo_climb_rglove_engage,"normal_long_d");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_engage",::fx_exo_climb_lglove_engage,"normal_long_d");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_disengage",::fx_exo_climb_rglove_disengage,"normal_long_d");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_disengage",::fx_exo_climb_lglove_disengage,"normal_long_d");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_engage",::fx_exo_climb_rglove_engage,"normal_long_l");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_engage",::fx_exo_climb_lglove_engage,"normal_long_l");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_disengage",::fx_exo_climb_rglove_disengage,"normal_long_l");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_disengage",::fx_exo_climb_lglove_disengage,"normal_long_l");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_engage",::fx_exo_climb_rglove_engage,"normal_long_r");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_engage",::fx_exo_climb_lglove_engage,"normal_long_r");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_disengage",::fx_exo_climb_rglove_disengage,"normal_long_r");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_disengage",::fx_exo_climb_lglove_disengage,"normal_long_r");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_engage",::fx_exo_climb_rglove_engage,"normal_long_u");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_engage",::fx_exo_climb_lglove_engage,"normal_long_u");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_disengage",::fx_exo_climb_rglove_disengage,"normal_long_u");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_disengage",::fx_exo_climb_lglove_disengage,"normal_long_u");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_r_glove_disengage",::fx_exo_climb_rglove_disengage,"dismount");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_l_glove_disengage",::fx_exo_climb_lglove_disengage,"dismount");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","fx_gloves_off",::fx_exo_climb_gloves_off,"dismount");
}

//Function Number: 18
play_new_and_kill_old_fx_l(param_00,param_01,param_02)
{
	if(isdefined(param_00.previously_played_fx_name_l) && isdefined(param_00.previously_played_fx_joint_l) && param_01 == param_00.previously_played_fx_name_l && param_02 == param_00.previously_played_fx_joint_l)
	{
		var_03 = 0;
	}
	else
	{
		if(isdefined(param_00.previously_played_fx_name_l))
		{
			killfxontag(common_scripts\utility::getfx(param_00.previously_played_fx_name_l),param_00,param_00.previously_played_fx_joint_l);
		}

		playfxontag(common_scripts\utility::getfx(param_01),param_00,param_02);
	}

	param_00.previously_played_fx_name_l = param_01;
	param_00.previously_played_fx_joint_l = param_02;
}

//Function Number: 19
play_new_and_kill_old_fx_r(param_00,param_01,param_02)
{
	if(isdefined(param_00.previously_played_fx_name_r) && isdefined(param_00.previously_played_fx_joint_r) && param_01 == param_00.previously_played_fx_name_r && param_02 == param_00.previously_played_fx_joint_r)
	{
	}
	else
	{
		if(isdefined(param_00.previously_played_fx_name_r))
		{
			killfxontag(common_scripts\utility::getfx(param_00.previously_played_fx_name_r),param_00,param_00.previously_played_fx_joint_r);
		}

		playfxontag(common_scripts\utility::getfx(param_01),param_00,param_02);
	}

	param_00.previously_played_fx_name_r = param_01;
	param_00.previously_played_fx_joint_r = param_02;
}

//Function Number: 20
fx_exo_climb_rglove_engage(param_00)
{
	play_new_and_kill_old_fx_r(param_00,"exo_r_gloves_engage","J_Wrist_RI");
	playfxontag(common_scripts\utility::getfx("dust_mag_r_glove_impact"),param_00,"J_Mid_RI_0");
}

//Function Number: 21
fx_exo_climb_rglove_disengage(param_00)
{
	play_new_and_kill_old_fx_r(param_00,"exo_r_gloves_disengage","J_Wrist_RI");
	killfxontag(common_scripts\utility::getfx("exo_r_gloves_engage_slow"),param_00,"J_Wrist_RI");
}

//Function Number: 22
fx_exo_climb_lglove_engage(param_00)
{
	play_new_and_kill_old_fx_l(param_00,"exo_l_gloves_engage","J_Wrist_LE");
	killfxontag(common_scripts\utility::getfx("exo_l_gloves_engage_slow"),param_00,"J_Wrist_LE");
	playfxontag(common_scripts\utility::getfx("dust_mag_l_glove_impact"),param_00,"J_Mid_LE_0");
}

//Function Number: 23
fx_exo_climb_lglove_disengage(param_00)
{
	play_new_and_kill_old_fx_l(param_00,"exo_l_gloves_disengage","J_Wrist_LE");
	killfxontag(common_scripts\utility::getfx("exo_l_gloves_engage_slow"),param_00,"J_Wrist_LE");
}

//Function Number: 24
fx_exo_climb_gloves_off(param_00)
{
	param_00.previously_played_fx_name_l = undefined;
	param_00.previously_played_fx_joint_l = undefined;
	killfxontag(common_scripts\utility::getfx("exo_l_gloves_engage_slow"),param_00,"J_Wrist_LE");
	killfxontag(common_scripts\utility::getfx("exo_r_gloves_engage_slow"),param_00,"J_Wrist_RI");
	wait 0.05;
	killfxontag(common_scripts\utility::getfx(param_00.previously_played_fx_name_l),param_00,param_00.previously_played_fx_joint_l);
	param_00.previously_played_fx_name_l = undefined;
	param_00.previously_played_fx_joint_l = undefined;
}

//Function Number: 25
setup_climb_anims_parse_anim_offsets(param_00)
{
	var_01 = getarraykeys(param_00);
	foreach(var_03 in var_01)
	{
		var_04 = strtok(var_03,"_");
		if(var_04[0] == "normal" || var_04[0] == "special" || var_04[0] == "magnetic" || var_04[0] == "jump2mag" || var_04[0] == "mag2jump")
		{
			if(!isdefined(level.exo_climb_anim_offsets[var_04[0]]))
			{
				level.exo_climb_anim_offsets[var_04[0]] = [];
			}

			if(var_04[0] == "normal")
			{
				if(!isdefined(level.exo_climb_anim_offsets[var_04[0]][var_04[1]]))
				{
					level.exo_climb_anim_offsets[var_04[0]][var_04[1]] = [];
				}

				level.exo_climb_anim_offsets[var_04[0]][var_04[1]][var_04[2]] = [];
				level.exo_climb_anim_offsets[var_04[0]][var_04[1]][var_04[2]]["offset"] = getmovedelta(param_00[var_03],0,1);
				level.exo_climb_anim_offsets[var_04[0]][var_04[1]][var_04[2]]["angle"] = getangledelta(param_00[var_03],0,1);
				continue;
			}

			if(var_04[0] == "special")
			{
				if(!isdefined(level.exo_climb_anim_offsets[var_04[0]][var_04[1]]))
				{
					level.exo_climb_anim_offsets[var_04[0]][var_04[1]] = [];
				}

				if(!isdefined(level.exo_climb_anim_offsets[var_04[0]][var_04[1]][var_04[2]]))
				{
					level.exo_climb_anim_offsets[var_04[0]][var_04[1]][var_04[2]] = [];
				}

				level.exo_climb_anim_offsets[var_04[0]][var_04[1]][var_04[2]][var_04[3]] = [];
				level.exo_climb_anim_offsets[var_04[0]][var_04[1]][var_04[2]][var_04[3]]["offset"] = getmovedelta(param_00[var_03],0,1);
				level.exo_climb_anim_offsets[var_04[0]][var_04[1]][var_04[2]][var_04[3]]["angle"] = getangledelta(param_00[var_03],0,1);
				continue;
			}

			if(var_04[0] == "magnetic")
			{
				if(!isdefined(level.exo_climb_anim_offsets[var_04[0]][var_04[1]]))
				{
					level.exo_climb_anim_offsets[var_04[0]][var_04[1]] = [];
				}

				level.exo_climb_anim_offsets[var_04[0]][var_04[1]][var_04[2]] = [];
				level.exo_climb_anim_offsets[var_04[0]][var_04[1]][var_04[2]]["offset"] = getmovedelta(param_00[var_03],0,1);
				level.exo_climb_anim_offsets[var_04[0]][var_04[1]][var_04[2]]["angle"] = getangledelta(param_00[var_03],0,1);
				continue;
			}

			if(var_04[0] == "jump2mag")
			{
				var_05 = var_04[1];
				level.exo_climb_anim_offsets["jump2mag"][var_05] = [];
				level.exo_climb_anim_offsets["jump2mag"][var_05]["offset"] = getmovedelta(param_00[var_03],0,1);
				level.exo_climb_anim_offsets["jump2mag"][var_05]["angle"] = getangledelta(param_00[var_03],0,1);
				continue;
			}

			if(var_04[0] == "mag2jump")
			{
				var_05 = var_04[1];
				level.exo_climb_anim_offsets["mag2jump"][var_05] = [];
				level.exo_climb_anim_offsets["mag2jump"][var_05]["offset"] = getmovedelta(param_00[var_03],0,1);
				level.exo_climb_anim_offsets["mag2jump"][var_05]["angle"] = getangledelta(param_00[var_03],0,1);
			}
		}
	}
}

//Function Number: 26
verify_jump_mount_points()
{
	var_00 = getentarray("exo_climbing_mount_point","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = getent(var_02.target,"targetname");
		var_04 = getent(var_03.target,"targetname");
		var_03.mount_org = var_04;
		var_03 thread trigger_handle_jump_mount();
	}
}

//Function Number: 27
verify_mag_mount_points()
{
	var_00 = getentarray("exoclimb_magnetic_mount_point","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = getent(var_02.target,"targetname");
		var_04 = getent(var_03.target,"targetname");
		var_03.mount_org = var_04;
		var_03 thread trigger_handle_mag_mount();
	}
}

//Function Number: 28
get_climb_triggers()
{
	level.exo_climb_jump_trigs = getentarray("exo_climbing_bounds_trigger","targetname");
	level.exo_climb_magnetic_trigs = getentarray("exo_climbing_magnetic_trigger","targetname");
}

//Function Number: 29
trigger_handle_jump_mount()
{
	maps\_utility::addhinttrigger(&"EXOCLIMB_CLIMB_HINT",&"EXOCLIMB_CLIMB_HINT_PC");
	self.script_flag_false = "flag_exo_climbing_enabled";
	level thread maps\_trigger::trigger_script_flag_false(self);
	for(;;)
	{
		common_scripts\utility::flag_waitopen("flag_exo_climbing_enabled");
		var_00 = maps\_shg_utility::hint_button_position("use",self.origin + (0,0,-15),undefined,200,undefined,self);
		var_01 = common_scripts\utility::waittill_any_return("trigger","disable_mount_point");
		if(var_01 == "trigger")
		{
			level thread climbing_player_mount(self.mount_org,"jump");
			var_00 maps\_shg_utility::hint_button_clear();
			continue;
		}

		var_00 maps\_shg_utility::hint_button_clear();
		self delete();
	}
}

//Function Number: 30
trigger_handle_mag_mount()
{
	self usetriggerrequirelookat();
	maps\_utility::addhinttrigger(&"EXOCLIMB_CLIMB_HINT",&"EXOCLIMB_CLIMB_HINT_PC");
	self.script_flag_false = "flag_exo_climbing_enabled";
	level thread maps\_trigger::trigger_script_flag_false(self);
	for(;;)
	{
		level endon("flag_cancel_exo_climb");
		common_scripts\utility::flag_waitopen("flag_exo_climbing_enabled");
		var_00 = maps\_shg_utility::hint_button_position("use",self.origin,undefined,200,undefined,self);
		var_01 = common_scripts\utility::waittill_any_return("trigger","disable_mount_point");
		if(var_01 == "trigger")
		{
			level thread climbing_player_mount(self.mount_org,"magnetic");
			var_00 maps\_shg_utility::hint_button_clear();
			continue;
		}

		var_00 maps\_shg_utility::hint_button_clear();
		self delete();
	}
}

//Function Number: 31
climbing_player_mount(param_00,param_01)
{
	level.player endon("death");
	if(common_scripts\utility::flag("flag_exo_climbing_enabled"))
	{
		return;
	}

	common_scripts\utility::flag_set("flag_exo_climbing_enabled");
	if(isdefined(1) && 1)
	{
		level thread temp_exoclimb_hud_thread();
	}

	if(isdefined(param_00.override_rig))
	{
		level.exo_climb_rig = param_00.override_rig;
		level.exo_climb_rig.animname = "player_climb_rig";
	}
	else
	{
		level.exo_climb_rig = maps\_utility::spawn_anim_model("player_climb_rig",level.player.origin,level.player.angles);
		level.exo_climb_rig hide();
	}

	if(!isdefined(level.exoclimb_combat_enabled))
	{
		level.exoclimb_combat_enabled = 1;
	}

	level.exo_climb_rig.facing = "center";
	if(!isdefined(level.exo_climb_player_center))
	{
		level.exo_climb_player_center = spawn("script_origin",level.exo_climb_rig.origin);
		level.exo_climb_player_center.angles = level.exo_climb_rig.angles;
		var_02 = anglestoforward(level.exo_climb_player_center.angles);
		var_03 = 0 * var_02 + (0,0,60);
		level.exo_climb_player_center linkto(level.exo_climb_rig,"tag_origin",var_03,(0,0,0));
	}

	if(!isdefined(param_00.override_rig))
	{
		level.player maps\_shg_utility::setup_player_for_scene();
		level.player allowads(0);
		level.player disableweaponswitch();
		level.player enableoffhandweapons();
		level.player waittill("weapon_change");
	}

	swap_to_climbing_weapon();
	var_04 = "";
	if(param_01 == "jump")
	{
		var_04 = "mount2jump";
	}
	else if(param_01 == "magnetic")
	{
		var_04 = "mount2mag";
	}
	else
	{
		return;
	}

	var_05 = 0.5;
	if(!isdefined(param_00.override_rig))
	{
		level.player playerlinktoblend(level.exo_climb_rig,"tag_player",var_05);
		level.player common_scripts\utility::delaycall(var_05,::playerlinktodelta,level.exo_climb_rig,"tag_player",1,0,0,0,0,1);
	}

	var_06 = 120;
	var_07 = 60;
	var_08 = 57;
	if(param_01 == "magnetic")
	{
		var_06 = 80;
		var_07 = 60;
		var_08 = 57;
		if(isdefined(level.player.exo_climb_overrides))
		{
			if(isdefined(level.player.exo_climb_overrides.idle_look_sideways_limit_mag))
			{
				var_06 = level.player.exo_climb_overrides.idle_look_sideways_limit_mag;
			}

			if(isdefined(level.player.exo_climb_overrides.idle_look_up_limit_mag))
			{
				var_07 = level.player.exo_climb_overrides.idle_look_up_limit_mag;
			}

			if(isdefined(level.player.exo_climb_overrides.idle_look_down_limit_mag))
			{
				var_08 = level.player.exo_climb_overrides.idle_look_down_limit_mag;
			}
		}
	}

	if(!isdefined(param_00.override_rig))
	{
		level.exo_climb_rig common_scripts\utility::delaycall(var_05,::show);
	}

	var_09 = var_05 + 0.1;
	if(isdefined(param_00.override_view_angle_unclamp_time))
	{
		var_09 = param_00.override_view_angle_unclamp_time;
	}

	level.player common_scripts\utility::delaycall(var_09,::lerpviewangleclamp,0.5,0,0,var_06,var_06,var_07,var_08);
	level.player lerpfov(70,var_09 + 0.1);
	level notify("exoclimb_start_mount_anim");
	if(isdefined(param_00.override_anim_org) && isdefined(param_00.override_anim))
	{
		level.scr_anim["player_climb_rig"]["mount_override"] = param_00.override_anim;
		param_00.override_anim_org maps\_anim::anim_single_solo(level.exo_climb_rig,"mount_override");
	}
	else
	{
		param_00 maps\_anim::anim_single_solo(level.exo_climb_rig,var_04);
	}

	level.exo_climb_ground_ref_ent = spawn("script_model",(0,0,0));
	level.exo_climb_ground_ref_ent setmodel("tag_origin");
	level.exo_climb_ground_ref_ent linkto(level.exo_climb_rig,"tag_origin",(0,0,0),(0,0,0));
	if(!isdefined(level.player.hack_fix_lagos_flank_alley_camera_pop) || !level.player.hack_fix_lagos_flank_alley_camera_pop)
	{
		level.player playersetgroundreferenceent(level.exo_climb_ground_ref_ent);
	}

	level.player enableslowaim(1,0.6);
	level thread climbing_player_controller(param_01);
}

//Function Number: 32
using_variable_grenade(param_00)
{
	if(!isdefined(self.variable_grenade))
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00.size != 2)
	{
		return 0;
	}

	var_01 = level.player maps\_variable_grenade::get_mode_for_weapon_name(param_00[0]);
	if(!isdefined(var_01))
	{
		return 0;
	}

	var_01 = level.player maps\_variable_grenade::get_mode_for_weapon_name(param_00[1]);
	if(!isdefined(var_01))
	{
		return 0;
	}

	return 1;
}

//Function Number: 33
swap_to_climbing_weapon()
{
	maps\_player_exo::player_exo_deactivate();
	var_00 = level.player getweaponslistoffhands();
	if(level.player using_variable_grenade(var_00))
	{
		var_01 = 0;
		if(isdefined(var_00[0]))
		{
			var_01 = level.player maps\_variable_grenade::get_index_for_weapon_name(var_00[0]);
		}

		var_02 = 0;
		if(isdefined(var_00[1]))
		{
			var_02 = level.player maps\_variable_grenade::get_index_for_weapon_name(var_00[1]);
		}

		var_03["normal"][0] = "tracking_grenade_var_exoclimb";
		var_03["normal"][1] = "contact_grenade_var_exoclimb";
		var_03["normal"][2] = "frag_grenade_var_exoclimb";
		var_03["special"][0] = "paint_grenade_var_exoclimb";
		var_03["special"][1] = "flash_grenade_var_exoclimb";
		var_03["special"][2] = "emp_grenade_var_exoclimb";
		level.exo_climb_rig.stored_variable_grenade = level.player.variable_grenade;
		level.player.variable_grenade = var_03;
		var_04 = [];
		var_04["frag_grenade_var_exoclimb"] = 1;
		var_04["contact_grenade_var_exoclimb"] = 2;
		var_04["tracking_grenade_var_exoclimb"] = 3;
		var_04["paint_grenade_var_exoclimb"] = 4;
		var_04["flash_grenade_var_exoclimb"] = 5;
		var_04["emp_grenade_var_exoclimb"] = 6;
		level.exo_climb_rig.stored_variable_grenade_ui_type = level.player.variable_grenade_ui_type;
		level.player.variable_grenade_ui_type = var_04;
		foreach(var_06 in var_00)
		{
			level.player takeweapon(var_06);
		}

		level.player setlethalweapon(level.player.variable_grenade["normal"][var_01]);
		level.player giveweapon(level.player.variable_grenade["normal"][var_01]);
		level.player settacticalweapon(level.player.variable_grenade["special"][var_02]);
		level.player giveweapon(level.player.variable_grenade["special"][var_02]);
	}

	level.exo_climb_rig.stored_weapon = level.player maps\_utility::get_storable_current_weapon();
	level.exo_climb_rig.stored_clipsize = level.player getweaponammoclip(level.exo_climb_rig.stored_weapon);
	level.exo_climb_rig.stored_stock = level.player setweaponammostock(level.exo_climb_rig.stored_weapon);
	level.player takeweapon(level.exo_climb_rig.stored_weapon);
}

//Function Number: 34
swap_to_real_weapon()
{
	maps\_player_exo::player_exo_activate();
	level.player giveweapon(level.exo_climb_rig.stored_weapon);
	level.player setweaponammoclip(level.exo_climb_rig.stored_weapon,level.exo_climb_rig.stored_clipsize);
	level.player setweaponammostock(level.exo_climb_rig.stored_weapon,level.exo_climb_rig.stored_stock);
	level.player switchtoweapon(level.exo_climb_rig.stored_weapon);
	if(isdefined(level.exo_climb_rig.stored_variable_grenade))
	{
		var_00 = level.player getweaponslistoffhands();
		var_01 = 0;
		if(isdefined(var_00[0]))
		{
			var_01 = level.player maps\_variable_grenade::get_index_for_weapon_name(var_00[0]);
		}

		var_02 = 0;
		if(isdefined(var_00[1]))
		{
			var_02 = level.player maps\_variable_grenade::get_index_for_weapon_name(var_00[1]);
		}

		level.player.variable_grenade = level.exo_climb_rig.stored_variable_grenade;
		level.exo_climb_rig.stored_variable_grenade = undefined;
		foreach(var_04 in var_00)
		{
			level.player takeweapon(var_04);
		}

		level.player setlethalweapon(level.player.variable_grenade["normal"][var_01]);
		level.player giveweapon(level.player.variable_grenade["normal"][var_01]);
		level.player settacticalweapon(level.player.variable_grenade["special"][var_02]);
		level.player giveweapon(level.player.variable_grenade["special"][var_02]);
	}

	if(isdefined(level.exo_climb_rig.stored_variable_grenade_ui_type))
	{
		level.player.variable_grenade_ui_type = level.exo_climb_rig.stored_variable_grenade_ui_type;
	}
}

//Function Number: 35
stop_player_climbing(param_00)
{
	if(!param_00)
	{
		swap_to_real_weapon();
		level.player maps\_shg_utility::setup_player_for_gameplay();
		level.player allowads(1);
		level.player enableweaponswitch();
		level.player unlink();
		level.exo_climb_rig delete();
	}

	level.exo_climb_rig = undefined;
	level.player disableslowaim();
	level.exo_climb_player_center unlink();
	level.exo_climb_player_center delete();
	level.exo_climb_player_center = undefined;
	level.player playersetgroundreferenceent(undefined);
	level.exo_climb_ground_ref_ent unlink();
	level.exo_climb_ground_ref_ent delete();
	level.exo_climb_ground_ref_ent = undefined;
	common_scripts\utility::flag_clear("flag_exo_climbing_enabled");
	level.player notify("stop_player_climbing");
}

//Function Number: 36
enter_state_on_jump_surface()
{
	level.exo_climb_rig.surface_state = "on_jump_surface";
	climbing_update_available_moving_options();
}

//Function Number: 37
enter_state_on_mag_surface()
{
	level.exo_climb_rig.surface_state = "on_mag_surface";
	level.exo_climb_rig.mag_move_dir = "";
	level.exo_climb_rig.next_chain_move = undefined;
	climbing_update_available_moving_options();
}

//Function Number: 38
enter_state_mag_to_jump_surface()
{
	level.exo_climb_rig.surface_state = "mag_to_jump_surface";
	reset_button_buffers();
}

//Function Number: 39
reset_button_buffers()
{
	level.exo_climb_rig.jumpbuttonbuffer = 0;
	level.exo_climb_rig.combatbuttonbuffer = 0;
}

//Function Number: 40
update_button_buffers()
{
	if(level.player jumpbuttonpressed())
	{
		level.exo_climb_rig.jumpbuttonbuffer = 0.6;
	}
	else if(level.exo_climb_rig.jumpbuttonbuffer > 0)
	{
		level.exo_climb_rig.jumpbuttonbuffer = level.exo_climb_rig.jumpbuttonbuffer - 0.05;
	}

	if(level.player buttonpressed("Button_B") || level.player attackbuttonpressed() || level.player adsbuttonpressed() || level.player fragbuttonpressed() || level.player secondaryoffhandbuttonpressed())
	{
		level.exo_climb_rig.combatbuttonbuffer = 0.6;
		return;
	}

	if(level.exo_climb_rig.combatbuttonbuffer > 0)
	{
		level.exo_climb_rig.combatbuttonbuffer = level.exo_climb_rig.combatbuttonbuffer - 0.05;
	}
}

//Function Number: 41
climbing_player_controller(param_00)
{
	level.player endon("stop_player_climbing");
	wait(0.05);
	reset_button_buffers();
	if(param_00 == "jump")
	{
		enter_state_on_jump_surface();
	}
	else if(param_00 == "magnetic")
	{
		enter_state_on_mag_surface();
	}
	else
	{
		return;
	}

	restore_idle();
	for(;;)
	{
		if(isdefined(level.exo_climb_retest_jumps_triggers))
		{
			climbing_update_available_moving_options();
		}

		if(level.exo_climb_rig.surface_state == "on_jump_surface")
		{
			update_button_buffers();
			if(climbing_helper_player_in_combat_mode() && level.player isthrowinggrenade())
			{
				climbing_motion_player_combat_mode();
			}
			else if(climbing_helper_player_dismount_requested())
			{
				climbing_motion_dismount();
			}
			else if(climbing_helper_player_jump_requested() && climbing_helper_player_input_1_allowed())
			{
				var_01 = get_requested_jump_direction();
				if(jump_to_mag_direction_is_valid(var_01))
				{
					if(climbing_helper_player_in_combat_mode())
					{
						climbing_motion_stop_player_combat_mode_quick();
					}

					climbing_motion_start_player_jump_to_mag(var_01);
				}
				else if(jump_direction_is_valid(var_01))
				{
					if(climbing_helper_player_in_combat_mode())
					{
						climbing_motion_stop_player_combat_mode_quick();
					}

					climbing_motion_start_player_jump(var_01);
				}
				else
				{
					level.exo_climb_rig.jumpbuttonbuffer = 0;
				}
			}
			else if(climbing_helper_player_combat_requested() && climbing_helper_player_input_1_allowed() && !climbing_helper_player_in_combat_mode() && level.exoclimb_combat_enabled)
			{
				climbing_motion_start_player_shooting();
			}
			else if(climbing_helper_player_jumping())
			{
				climbing_motion_player_jumping();
			}
			else if(climbing_helper_player_in_combat_mode() && climbing_helper_player_exit_combat_mode_requested())
			{
				climbing_motion_stop_player_combat_mode();
				level.exo_climb_rig.combatbuttonbuffer = 0;
			}
			else if(climbing_helper_player_in_combat_mode())
			{
				climbing_motion_player_combat_mode();
			}
			else
			{
				climbing_motion_player_looking();
			}
		}
		else if(level.exo_climb_rig.surface_state == "on_mag_surface")
		{
			if(climbing_helper_player_mag_moving())
			{
				var_01 = get_requested_move_direction();
				if(climbing_helper_player_input_1_allowed() && var_01 == level.exo_climb_rig.mag_move_dir && magnetic_hands_direction_is_valid(var_01))
				{
					climbing_motion_start_player_mag_move(var_01);
				}
				else if(climbing_helper_player_input_2_allowed() && var_01 != level.exo_climb_rig.mag_move_dir && magnetic_hands_direction_is_valid(var_01))
				{
					climbing_motion_start_player_mag_move(var_01);
				}
				else if(climbing_helper_player_input_1_allowed() && mag_to_jump_direction_is_valid(var_01))
				{
					climbing_motion_start_player_mag_to_jump(var_01);
				}
				else
				{
					climbing_motion_player_moving_on_magnetic_surface();
				}
			}
			else
			{
				var_01 = get_requested_move_direction();
				if(magnetic_hands_direction_is_valid(var_01))
				{
					climbing_motion_start_player_mag_move(var_01);
				}
				else if(mag_to_jump_direction_is_valid(var_01))
				{
					climbing_motion_start_player_mag_to_jump(var_01);
				}
			}
		}
		else if(level.exo_climb_rig.surface_state == "jump_to_mag_surface")
		{
			climbing_motion_player_jump_to_mag();
		}
		else if(level.exo_climb_rig.surface_state == "mag_to_jump_surface")
		{
			update_button_buffers();
			if(climbing_helper_player_input_1_allowed())
			{
				enter_state_on_jump_surface();
			}
			else
			{
				climbing_motion_player_mag_to_jump();
			}
		}

		wait(0.05);
	}
}

//Function Number: 42
restore_idle()
{
	if(level.exo_climb_rig.surface_state == "on_mag_surface")
	{
		level thread climbing_animation_idle_loop("magnetic");
		return;
	}

	if(level.exo_climb_rig.facing == "right")
	{
		level thread climbing_animation_idle_loop("right");
		return;
	}

	if(level.exo_climb_rig.facing == "right_back")
	{
		level thread climbing_animation_idle_loop("right_back");
		return;
	}

	if(level.exo_climb_rig.facing == "left")
	{
		level thread climbing_animation_idle_loop("left");
		return;
	}

	if(level.exo_climb_rig.facing == "left_back")
	{
		level thread climbing_animation_idle_loop("left_back");
		return;
	}

	level thread climbing_animation_idle_loop();
}

//Function Number: 43
exo_climb_grab_rumble(param_00)
{
	var_01 = randomfloat(360);
	var_02 = anglestoright(level.exo_climb_rig.angles);
	var_03 = anglestoup(level.exo_climb_rig.angles);
	var_04 = sin(var_01) * var_03 + cos(var_01) * var_02;
	var_05 = 0.9;
	glassradiusdamage(level.exo_climb_rig.origin,84,10,10,var_05,var_04);
	level.player playrumbleonentity("falling_land");
}

//Function Number: 44
exo_climb_jump_rumble(param_00)
{
	level.player playrumbleonentity("damage_light");
}

//Function Number: 45
exo_climb_mag_rumble(param_00)
{
	level.player playrumbleonentity("damage_light");
}

//Function Number: 46
exo_climb_grab_shake(param_00)
{
	level.player screenshakeonentity(12,6,2,0.5,0,0.25,128,10,5,5,2);
}

//Function Number: 47
exo_climb_jump_shake(param_00)
{
	level.player screenshakeonentity(4,2,0.5,0.5,0,0.25,128,10,5,5,2);
}

//Function Number: 48
exo_climb_allow_player_input_1(param_00)
{
	level.exo_climb_rig.allow_player_input_1 = 1;
	climbing_update_available_moving_options();
}

//Function Number: 49
exo_climb_allow_player_input_2(param_00)
{
	level.exo_climb_rig.allow_player_input_2 = 1;
}

//Function Number: 50
climbing_motion_start_player_jump(param_00)
{
	if(level.exo_climb_move_options["long"][param_00] != "blocked")
	{
		var_01 = level.exo_climb_move_options["long"][param_00];
		thread climbing_animation_traverse_move(var_01,2);
		if(param_00 == "u")
		{
			var_02 = level.player getplayerangles()[0];
			if(var_02 < 20)
			{
				level.player common_scripts\utility::delaycall(0.2,::lerpfov,100,0.4);
			}
			else
			{
				level.player common_scripts\utility::delaycall(0.2,::lerpfov,85,0.4);
			}

			level.player common_scripts\utility::delaycall(0.9,::lerpfov,70,0.15);
		}
		else if(param_00 == "d")
		{
			var_02 = level.player getplayerangles()[0];
			if(var_02 > -20)
			{
				level.player lerpfov(100,0.5);
			}
			else
			{
				level.player lerpfov(85,0.5);
			}

			level.player common_scripts\utility::delaycall(0.7,::lerpfov,70,0.4);
		}
		else if(param_00 == "l")
		{
			var_03 = get_player_local_yaw();
			if(var_03 > -20)
			{
				level.player common_scripts\utility::delaycall(0.2,::lerpfov,100,0.4);
			}
			else
			{
				level.player common_scripts\utility::delaycall(0.2,::lerpfov,85,0.4);
			}

			level.player common_scripts\utility::delaycall(0.7,::lerpfov,70,0.4);
		}
		else if(param_00 == "r")
		{
			var_03 = get_player_local_yaw();
			if(var_03 < 20)
			{
				level.player common_scripts\utility::delaycall(0.2,::lerpfov,100,0.4);
			}
			else
			{
				level.player common_scripts\utility::delaycall(0.2,::lerpfov,85,0.4);
			}

			level.player common_scripts\utility::delaycall(0.7,::lerpfov,70,0.4);
		}
	}
	else if(level.exo_climb_move_options["short"][var_01] != "blocked")
	{
		var_01 = level.exo_climb_move_options["short"][var_01];
		thread climbing_animation_traverse_move(var_01,0);
	}
	else
	{
		return;
	}

	level.exo_climb_rig.is_jumping = 1;
	level.exo_climb_rig.allow_player_input_1 = undefined;
	level.exo_climb_rig.allow_player_input_2 = undefined;
}

//Function Number: 51
climbing_motion_start_player_jump_to_mag(param_00)
{
	var_01 = "jump2mag_" + param_00;
	thread climbing_animation_traverse_move(var_01,2);
	level.exo_climb_rig.surface_state = "jump_to_mag_surface";
	level.exo_climb_rig.is_jumping = undefined;
	var_02 = 80;
	var_03 = 60;
	var_04 = 57;
	if(isdefined(level.player.exo_climb_overrides))
	{
		if(isdefined(level.player.exo_climb_overrides.idle_look_sideways_limit_mag))
		{
			var_02 = level.player.exo_climb_overrides.idle_look_sideways_limit_mag;
		}

		if(isdefined(level.player.exo_climb_overrides.idle_look_up_limit_mag))
		{
			var_03 = level.player.exo_climb_overrides.idle_look_up_limit_mag;
		}

		if(isdefined(level.player.exo_climb_overrides.idle_look_down_limit_mag))
		{
			var_04 = level.player.exo_climb_overrides.idle_look_down_limit_mag;
		}
	}

	level.player lerpviewangleclamp(0.5,0,0,var_02,var_02,var_03,var_04);
	level.exo_climb_rig.allow_player_input_1 = undefined;
	level.exo_climb_rig.allow_player_input_2 = undefined;
}

//Function Number: 52
climbing_motion_player_jumping()
{
	if(isdefined(level.exo_climb_rig.current_traverse_anime))
	{
		var_00 = level.scr_anim["player_climb_rig"][level.exo_climb_rig.current_traverse_anime];
		var_01 = level.exo_climb_rig getanimtime(var_00);
		if(var_01 >= 1)
		{
			level.exo_climb_rig.is_jumping = undefined;
			if(level.nextgen)
			{
				setsaveddvar("r_mbEnable","0");
			}

			climbing_update_available_moving_options();
			restore_idle();
		}
	}
}

//Function Number: 53
climbing_motion_player_moving_on_magnetic_surface()
{
	if(isdefined(level.exo_climb_rig.current_traverse_anime))
	{
		var_00 = level.scr_anim["player_climb_rig"][level.exo_climb_rig.current_traverse_anime];
		var_01 = level.exo_climb_rig getanimtime(var_00);
		if(var_01 >= 1)
		{
			level.exo_climb_rig.mag_move_dir = "";
			level.exo_climb_rig.next_chain_move = undefined;
			climbing_update_available_moving_options();
			if(isdefined(level.exo_climb_force_animated_dismount))
			{
				climbing_motion_dismount();
			}
			else
			{
				restore_idle();
			}

			if(level.nextgen)
			{
				setsaveddvar("r_mbEnable","0");
				return;
			}
		}
	}
}

//Function Number: 54
climbing_motion_player_jump_to_mag()
{
	if(isdefined(level.exo_climb_rig.current_traverse_anime))
	{
		var_00 = level.scr_anim["player_climb_rig"][level.exo_climb_rig.current_traverse_anime];
		var_01 = level.exo_climb_rig getanimtime(var_00);
		if(var_01 >= 1)
		{
			enter_state_on_mag_surface();
			restore_idle();
			if(level.nextgen)
			{
				setsaveddvar("r_mbEnable","0");
				return;
			}
		}
	}
}

//Function Number: 55
climbing_motion_player_mag_to_jump()
{
	if(climbing_helper_player_input_1_allowed())
	{
		enter_state_on_jump_surface();
		return;
	}

	if(isdefined(level.exo_climb_rig.current_traverse_anime))
	{
		var_00 = level.scr_anim["player_climb_rig"][level.exo_climb_rig.current_traverse_anime];
		var_01 = level.exo_climb_rig getanimtime(var_00);
		if(var_01 >= 1)
		{
			level.exo_climb_rig.is_jumping = undefined;
			enter_state_on_jump_surface();
			if(level.nextgen)
			{
				setsaveddvar("r_mbEnable","0");
			}

			restore_idle();
			return;
		}
	}
}

//Function Number: 56
get_direction_from_normalized_movement(param_00)
{
	var_01 = angleclamp360(param_00[0],param_00[1]);
	var_02 = "";
	if(var_01 < -135 || var_01 > 135)
	{
		var_02 = "l";
	}
	else if(var_01 < -45)
	{
		var_02 = "d";
	}
	else if(var_01 < 45)
	{
		var_02 = "r";
	}
	else
	{
		var_02 = "u";
	}

	return var_02;
}

//Function Number: 57
get_requested_jump_direction()
{
	var_00 = "u";
	var_01 = level.player getnormalizedmovement();
	var_02 = length2d(var_01);
	if(var_02 > 0.15)
	{
		var_00 = get_direction_from_normalized_movement(var_01);
	}

	return var_00;
}

//Function Number: 58
jump_to_mag_direction_is_valid(param_00)
{
	return level.exo_climb_move_options["jump2mag"][param_00] != "blocked";
}

//Function Number: 59
jump_direction_is_valid(param_00)
{
	return level.exo_climb_move_options["long"][param_00] != "blocked" || level.exo_climb_move_options["short"][param_00] != "blocked";
}

//Function Number: 60
get_requested_move_direction()
{
	var_00 = level.player getnormalizedmovement();
	if(length2d(var_00) <= 0.15)
	{
		return "";
	}

	return get_direction_from_normalized_movement(var_00);
}

//Function Number: 61
magnetic_hands_direction_is_valid(param_00)
{
	return param_00 != "" && level.exo_climb_move_options["magnetic"][param_00] != "blocked";
}

//Function Number: 62
mag_to_jump_direction_is_valid(param_00)
{
	return param_00 != "" && level.exo_climb_move_options["mag2jump"][param_00] != "blocked";
}

//Function Number: 63
climbing_motion_start_player_mag_move(param_00)
{
	if(isdefined(level.exo_climb_rig.next_chain_move))
	{
		if(level.exo_climb_rig.next_chain_move == "1")
		{
			var_01 = "magnetic_" + param_00 + "_1";
			level.exo_climb_rig.next_chain_move = "2";
		}
		else
		{
			var_01 = "magnetic_" + var_01 + "_2";
			level.exo_climb_rig.next_chain_move = "1";
		}
	}
	else
	{
		var_01 = "magnetic_" + var_01 + "_0";
		level.exo_climb_rig.next_chain_move = "2";
	}

	level.exo_climb_rig.allow_player_input_1 = undefined;
	level.exo_climb_rig.allow_player_input_2 = undefined;
	level.exo_climb_rig.mag_move_dir = param_00;
	thread climbing_animation_traverse_move(var_01,1);
}

//Function Number: 64
climbing_motion_start_player_mag_to_jump(param_00)
{
	var_01 = "mag2jump_" + param_00;
	thread climbing_animation_traverse_move(var_01,2);
	enter_state_mag_to_jump_surface();
	level.exo_climb_rig.is_jumping = 1;
	level.player lerpviewangleclamp(0.5,0,0,120,120,60,57);
	level.exo_climb_rig.allow_player_input_1 = undefined;
	level.exo_climb_rig.allow_player_input_2 = undefined;
}

//Function Number: 65
climbing_update_available_moving_options()
{
	level.exo_climb_retest_jumps_triggers = undefined;
	var_00 = spawn("script_origin",level.exo_climb_player_center.origin);
	level.exo_climb_move_options["long"]["u"] = "blocked";
	level.exo_climb_move_options["long"]["d"] = "blocked";
	level.exo_climb_move_options["long"]["l"] = "blocked";
	level.exo_climb_move_options["long"]["r"] = "blocked";
	level.exo_climb_move_options["short"]["u"] = "blocked";
	level.exo_climb_move_options["short"]["d"] = "blocked";
	level.exo_climb_move_options["short"]["l"] = "blocked";
	level.exo_climb_move_options["short"]["r"] = "blocked";
	level.exo_climb_move_options["magnetic"]["u"] = "blocked";
	level.exo_climb_move_options["magnetic"]["d"] = "blocked";
	level.exo_climb_move_options["magnetic"]["l"] = "blocked";
	level.exo_climb_move_options["magnetic"]["r"] = "blocked";
	level.exo_climb_move_options["jump2mag"]["u"] = "blocked";
	level.exo_climb_move_options["jump2mag"]["d"] = "blocked";
	level.exo_climb_move_options["jump2mag"]["l"] = "blocked";
	level.exo_climb_move_options["jump2mag"]["r"] = "blocked";
	level.exo_climb_move_options["mag2jump"]["u"] = "blocked";
	level.exo_climb_move_options["mag2jump"]["d"] = "blocked";
	level.exo_climb_move_options["mag2jump"]["l"] = "blocked";
	level.exo_climb_move_options["mag2jump"]["r"] = "blocked";
	if((level.exo_climb_rig.surface_state == "on_mag_surface" || level.exo_climb_rig.surface_state == "jump_to_mag_surface") && isdefined(level.exo_climb_anim_offsets["magnetic"]))
	{
		var_01 = getarraykeys(level.exo_climb_anim_offsets["magnetic"]);
		foreach(var_03 in var_01)
		{
			var_00.origin = level.exo_climb_player_center localtoworldcoords(level.exo_climb_anim_offsets["magnetic"][var_03]["0"]["offset"]);
			foreach(var_05 in level.exo_climb_magnetic_trigs)
			{
				if(var_00 istouching(var_05))
				{
					if(isdefined(var_05.script_noteworthy) && issubstr(var_05.script_noteworthy,"exo_climb_toggle_trigger"))
					{
						if(isdefined(var_05.allow_exo_climb))
						{
							level.exo_climb_move_options["magnetic"][var_03] = "ok";
						}
					}
					else
					{
						level.exo_climb_move_options["magnetic"][var_03] = "ok";
					}

					break;
				}
			}
		}
	}

	if(level.exo_climb_rig.surface_state == "on_jump_surface" && isdefined(level.exo_climb_anim_offsets["jump2mag"]))
	{
		var_08 = getarraykeys(level.exo_climb_anim_offsets["jump2mag"]);
		foreach(var_03 in var_08)
		{
			var_00.origin = level.exo_climb_player_center localtoworldcoords(level.exo_climb_anim_offsets["jump2mag"][var_03]["offset"]);
			foreach(var_05 in level.exo_climb_magnetic_trigs)
			{
				if(var_00 istouching(var_05))
				{
					if(isdefined(var_05.script_noteworthy) && issubstr(var_05.script_noteworthy,"exo_climb_toggle_trigger"))
					{
						if(isdefined(var_05.allow_exo_climb))
						{
							level.exo_climb_move_options["jump2mag"][var_03] = "ok";
						}
					}
					else
					{
						level.exo_climb_move_options["jump2mag"][var_03] = "ok";
					}

					break;
				}
			}
		}
	}

	if(level.exo_climb_rig.surface_state == "on_mag_surface" && isdefined(level.exo_climb_anim_offsets["mag2jump"]))
	{
		var_0D = getarraykeys(level.exo_climb_anim_offsets["mag2jump"]);
		foreach(var_03 in var_0D)
		{
			var_00.origin = level.exo_climb_player_center localtoworldcoords(level.exo_climb_anim_offsets["mag2jump"][var_03]["offset"]);
			foreach(var_05 in level.exo_climb_jump_trigs)
			{
				if(var_00 istouching(var_05))
				{
					if(isdefined(var_05.script_noteworthy) && issubstr(var_05.script_noteworthy,"exo_climb_toggle_trigger"))
					{
						if(isdefined(var_05.allow_exo_climb))
						{
							level.exo_climb_move_options["mag2jump"][var_03] = "ok";
						}
					}
					else
					{
						level.exo_climb_move_options["mag2jump"][var_03] = "ok";
					}

					break;
				}
			}
		}
	}

	if((level.exo_climb_rig.surface_state == "on_jump_surface" || level.exo_climb_rig.surface_state == "mag_to_jump_surface") && isdefined(level.exo_climb_anim_offsets["normal"]))
	{
		var_12 = getarraykeys(level.exo_climb_anim_offsets["normal"]);
		foreach(var_14 in var_12)
		{
			var_15 = getarraykeys(level.exo_climb_anim_offsets["normal"][var_14]);
			foreach(var_03 in var_15)
			{
				var_00.origin = level.exo_climb_player_center localtoworldcoords(level.exo_climb_anim_offsets["normal"][var_14][var_03]["offset"]);
				foreach(var_05 in level.exo_climb_jump_trigs)
				{
					if(var_00 istouching(var_05))
					{
						if(isdefined(var_05.script_noteworthy) && issubstr(var_05.script_noteworthy,"exo_climb_toggle_trigger"))
						{
							if(isdefined(var_05.allow_exo_climb))
							{
								level.exo_climb_move_options[var_14][var_03] = "normal_" + var_14 + "_" + var_03;
							}
						}
						else
						{
							level.exo_climb_move_options[var_14][var_03] = "normal_" + var_14 + "_" + var_03;
						}

						break;
					}
				}
			}
		}

		var_12 = getarraykeys(level.exo_climb_anim_offsets["special"]);
		foreach(var_14 in var_12)
		{
			var_15 = getarraykeys(level.exo_climb_anim_offsets["special"][var_14]);
			foreach(var_03 in var_15)
			{
				if(level.exo_climb_move_options[var_14][var_03] != "blocked")
				{
					continue;
				}

				var_1D = getarraykeys(level.exo_climb_anim_offsets["special"][var_14][var_03]);
				foreach(var_1F in var_1D)
				{
					if(level.exo_climb_move_options[var_14][var_03] != "blocked")
					{
						continue;
					}

					var_00.origin = level.exo_climb_player_center localtoworldcoords(level.exo_climb_anim_offsets["special"][var_14][var_03][var_1F]["offset"]);
					foreach(var_05 in level.exo_climb_jump_trigs)
					{
						if(var_00 istouching(var_05))
						{
							if(isdefined(var_05.script_noteworthy) && issubstr(var_05.script_noteworthy,"exo_climb_toggle_trigger"))
							{
								if(isdefined(var_05.allow_exo_climb))
								{
									level.exo_climb_move_options[var_14][var_03] = "special_" + var_14 + "_" + var_03 + "_" + var_1F;
								}
							}
							else
							{
								level.exo_climb_move_options[var_14][var_03] = "special_" + var_14 + "_" + var_03 + "_" + var_1F;
							}

							break;
						}
					}
				}
			}
		}
	}

	var_00 delete();
	if(isdefined(level.exo_climb_rig.is_linked))
	{
		level.exo_climb_retest_jumps_triggers = 1;
	}
}

//Function Number: 66
get_player_local_yaw()
{
	var_00 = level.player getplayerangles()[1];
	if(var_00 > 180)
	{
		var_00 = var_00 - 360;
	}

	return var_00;
}

//Function Number: 67
climbing_motion_player_looking()
{
	var_00 = get_player_local_yaw();
	if(level.exo_climb_rig.facing == "center")
	{
		if(var_00 > 30)
		{
			climbing_animation_idle_to_side_idle("left");
			return;
		}

		if(var_00 < -30)
		{
			climbing_animation_idle_to_side_idle("right");
			return;
		}

		return;
	}

	if(level.exo_climb_rig.facing == "left")
	{
		if(var_00 < 25)
		{
			climbing_animation_side_idle_to_idle("left");
			return;
		}

		if(var_00 > 90)
		{
			climbing_animation_side_idle_to_back("left");
			return;
		}

		return;
	}

	if(level.exo_climb_rig.facing == "left_back")
	{
		if(var_00 < 80)
		{
			climbing_animation_back_to_side_idle("left");
			return;
		}

		return;
	}

	if(level.exo_climb_rig.facing == "right")
	{
		if(var_00 > -25)
		{
			climbing_animation_side_idle_to_idle("right");
			return;
		}

		if(var_00 < -90)
		{
			climbing_animation_side_idle_to_back("right");
			return;
		}

		return;
	}

	if(var_00 > -80)
	{
		climbing_animation_back_to_side_idle("right");
		return;
	}
}

//Function Number: 68
climbing_motion_player_combat_mode()
{
	if(!level.player buttonpressed("BUTTON_B"))
	{
		level.exo_climb_rig.crouch_button_reset = 1;
	}

	var_00 = get_player_local_yaw();
	if(level.exo_climb_rig.facing == "center")
	{
		if(var_00 > 30)
		{
			climbing_animation_stop_idle();
			level.exo_climb_rig.facing = "left";
			level.exo_climb_rig maps\_anim::anim_single_solo(level.exo_climb_rig,"combat_center_to_left");
			level.exo_climb_rig thread maps\_anim::anim_loop_solo(level.exo_climb_rig,"combat_idle_left","stop_climb_idle");
			return;
		}

		if(var_00 < -30)
		{
			climbing_animation_stop_idle();
			level.exo_climb_rig.facing = "right";
			level.exo_climb_rig maps\_anim::anim_single_solo(level.exo_climb_rig,"combat_center_to_right");
			level.exo_climb_rig thread maps\_anim::anim_loop_solo(level.exo_climb_rig,"combat_idle_right","stop_climb_idle");
			return;
		}

		return;
	}

	if(level.exo_climb_rig.facing == "left")
	{
		if(var_00 < 25)
		{
			climbing_animation_stop_idle();
			level.exo_climb_rig.facing = "center";
			level.exo_climb_rig maps\_anim::anim_single_solo(level.exo_climb_rig,"combat_left_to_center");
			level.exo_climb_rig thread maps\_anim::anim_loop_solo(level.exo_climb_rig,"combat_idle","stop_climb_idle");
			return;
		}

		return;
	}

	if(var_00 > -25)
	{
		climbing_animation_stop_idle();
		level.exo_climb_rig.facing = "center";
		level.exo_climb_rig maps\_anim::anim_single_solo(level.exo_climb_rig,"combat_right_to_center");
		level.exo_climb_rig thread maps\_anim::anim_loop_solo(level.exo_climb_rig,"combat_idle","stop_climb_idle");
		return;
	}
}

//Function Number: 69
exo_climb_draw_weapon(param_00)
{
	climbing_give_player_weapon("right");
}

//Function Number: 70
climbing_motion_start_player_shooting()
{
	climbing_animation_stop_idle();
	level.exo_climb_rig.facing = "center";
	level.exo_climb_rig maps\_anim::anim_single_solo(level.exo_climb_rig,"climb_to_combat_idle");
	level.exo_climb_rig thread maps\_anim::anim_loop_solo(level.exo_climb_rig,"combat_idle","stop_climb_idle");
	level.exo_climb_rig.crouch_button_reset = undefined;
	level.exo_climb_rig.is_jumping = undefined;
}

//Function Number: 71
climbing_motion_stop_player_combat_mode_quick()
{
	level.player allowads(0);
	level.player disableweapons();
	var_00 = level.player getcurrentweapon();
	level.exo_climb_rig.stored_clipsize = level.player getweaponammoclip(var_00);
	level.exo_climb_rig.stored_stock = level.player setweaponammostock(var_00);
	level.player takeweapon(var_00);
	level.exo_climb_rig.in_combat_mode = undefined;
	climbing_animation_stop_idle();
}

//Function Number: 72
climbing_motion_stop_player_combat_mode()
{
	level.player allowads(0);
	level.player disableweapons();
	level.player waittill("weapon_change");
	var_00 = level.player getcurrentweapon();
	level.exo_climb_rig.stored_clipsize = level.player getweaponammoclip(var_00);
	level.exo_climb_rig.stored_stock = level.player setweaponammostock(var_00);
	level.player takeweapon(var_00);
	level.exo_climb_rig.in_combat_mode = undefined;
	climbing_animation_stop_idle();
	level.exo_climb_rig maps\_anim::anim_single_solo(level.exo_climb_rig,"combat_to_climb_idle");
	level.exo_climb_rig.facing = "center";
	level thread climbing_animation_idle_loop();
}

//Function Number: 73
climbing_motion_dismount()
{
	level.player lerpfov(65,1);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
	}

	if(climbing_helper_player_in_combat_mode())
	{
		climbing_motion_stop_player_combat_mode();
	}

	climbing_animation_dismount();
}

//Function Number: 74
climbing_give_player_weapon(param_00)
{
	level.exo_climb_rig.in_combat_mode = 1;
	var_01 = "iw5_sn6_sp";
	var_02 = getarraykeys(level.exo_climb_weapon);
	var_03 = common_scripts\utility::array_contains(var_02,level.exo_climb_rig.stored_weapon);
	if(var_03)
	{
		var_04 = level.exo_climb_weapon[level.exo_climb_rig.stored_weapon][param_00];
	}
	else
	{
		var_04 = level.exo_climb_weapon[var_02][var_01];
	}

	level.player giveweapon(var_04);
	level.player switchtoweapon(var_04);
	level.player setweaponammoclip(var_04,level.exo_climb_rig.stored_clipsize);
	level.player setweaponammostock(var_04,level.exo_climb_rig.stored_stock);
	level.player enableweapons();
	level.player waittill("weapon_change");
	level.player allowads(1);
}

//Function Number: 75
climbing_animation_stop_idle()
{
	level.exo_climb_rig notify("stop_climb_idle");
	level.exo_climb_rig maps\_utility::anim_stopanimscripted();
}

//Function Number: 76
climbing_animation_idle_to_side_idle(param_00)
{
	climbing_animation_stop_idle();
	level.exo_climb_rig.facing = param_00;
	level.exo_climb_rig maps\_anim::anim_single_solo(level.exo_climb_rig,"idle_to_idle" + param_00);
	level thread climbing_animation_idle_loop(param_00);
}

//Function Number: 77
climbing_animation_side_idle_to_back(param_00)
{
	climbing_animation_stop_idle();
	if(param_00 == "left")
	{
		level.exo_climb_rig.facing = "left_back";
		level.exo_climb_rig maps\_anim::anim_single_solo(level.exo_climb_rig,"idleleft_to_idleleftback");
		level thread climbing_animation_idle_loop("left_back");
		return;
	}

	level.exo_climb_rig.facing = "right_back";
	level.exo_climb_rig maps\_anim::anim_single_solo(level.exo_climb_rig,"idleright_to_idlerightback");
	level thread climbing_animation_idle_loop("right_back");
}

//Function Number: 78
climbing_animation_back_to_side_idle(param_00)
{
	climbing_animation_stop_idle();
	level.exo_climb_rig.facing = param_00;
	if(param_00 == "left")
	{
		level.exo_climb_rig maps\_anim::anim_single_solo(level.exo_climb_rig,"idleleftback_to_idleleft");
	}
	else
	{
		level.exo_climb_rig maps\_anim::anim_single_solo(level.exo_climb_rig,"idlerightback_to_idleright");
	}

	level thread climbing_animation_idle_loop(param_00);
}

//Function Number: 79
climbing_animation_side_idle_to_idle(param_00)
{
	climbing_animation_stop_idle();
	level.exo_climb_rig.facing = "center";
	level.exo_climb_rig maps\_anim::anim_single_solo(level.exo_climb_rig,"idle" + param_00 + "_to_idle");
	level thread climbing_animation_idle_loop();
}

//Function Number: 80
climbing_animation_idle_loop(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "";
	}

	if(param_00 == "magnetic")
	{
		level.exo_climb_rig thread maps\_anim::anim_loop_solo(level.exo_climb_rig,"idle_magnetic_gloves","stop_climb_idle");
		return;
	}

	level.exo_climb_rig thread maps\_anim::anim_loop_solo(level.exo_climb_rig,"idle" + param_00,"stop_climb_idle");
}

//Function Number: 81
climbing_animation_traverse_move(param_00,param_01)
{
	climbing_animation_stop_idle();
	level.exo_climb_rig.current_traverse_anime = param_00;
	level.exo_climb_rig maps\_anim::anim_single_solo(level.exo_climb_rig,param_00);
	if(level.nextgen)
	{
		if(param_01 == 0)
		{
			setsaveddvar("r_mbEnable","0");
			return;
		}

		if(param_01 == 1)
		{
			setsaveddvar("r_mbEnable","2");
			setsaveddvar("r_mbVelocityScalar","2");
			return;
		}

		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbVelocityScalar","6");
		return;
	}
}

//Function Number: 82
climbing_animation_dismount()
{
	climbing_animation_stop_idle();
	level.player playersetgroundreferenceent(undefined);
	level.player lerpviewangleclamp(0.5,0,0,0,0,0,0);
	level.exo_climb_rig dontcastshadows();
	var_00 = 0;
	if(isdefined(level.exo_climb_force_animated_dismount))
	{
		var_01 = level.exo_climb_animated_dismount["org"];
		var_02 = level.exo_climb_animated_dismount["animname"];
		var_03 = level.exo_climb_animated_dismount["anime"];
		var_01 maps\_anim::anim_single_solo(level.exo_climb_rig,var_03,undefined,undefined,var_02);
		level.exo_climb_force_animated_dismount = undefined;
		if(isdefined(level.exo_climb_animated_dismount["keep_rig"]))
		{
			var_00 = 1;
		}
	}
	else
	{
		level.exo_climb_rig maps\_anim::anim_single_solo(level.exo_climb_rig,"dismount");
	}

	stop_player_climbing(var_00);
}

//Function Number: 83
climbing_head_sway()
{
	level.player endon("death");
	level.player endon("stop_player_climbing");
	for(;;)
	{
		screenshake(level.player.origin,3,5,1,2,0.2,0.2,0,0.3,0.375,0.225);
		wait(1);
	}
}

//Function Number: 84
climbing_helper_player_jumping()
{
	return isdefined(level.exo_climb_rig.is_jumping);
}

//Function Number: 85
climbing_helper_player_moving()
{
	return climbing_helper_player_jumping() || climbing_helper_player_mag_moving() || isdefined(level.exo_climb_rig.surface_state) && level.exo_climb_rig.surface_state == "jump_to_mag_surface" || isdefined(level.exo_climb_rig.surface_state) && level.exo_climb_rig.surface_state == "mag_to_jump_surface";
}

//Function Number: 86
climbing_helper_player_mag_moving()
{
	return isdefined(level.exo_climb_rig.surface_state) && level.exo_climb_rig.surface_state == "on_mag_surface" && isdefined(level.exo_climb_rig.mag_move_dir) && level.exo_climb_rig.mag_move_dir != "";
}

//Function Number: 87
climbing_helper_player_input_1_allowed()
{
	if(isdefined(level.exo_climb_force_animated_dismount))
	{
		return 0;
	}

	if(isdefined(level.exo_climb_rig.allow_player_input_1))
	{
		return 1;
	}

	if(!climbing_helper_player_moving())
	{
		return 1;
	}

	return 0;
}

//Function Number: 88
climbing_helper_player_input_2_allowed()
{
	if(isdefined(level.exo_climb_force_animated_dismount))
	{
		return 0;
	}

	if(isdefined(level.exo_climb_rig.allow_player_input_2))
	{
		return 1;
	}

	if(!climbing_helper_player_moving())
	{
		return 1;
	}

	return 0;
}

//Function Number: 89
climbing_helper_player_jump_requested()
{
	return level.exo_climb_rig.jumpbuttonbuffer > 0;
}

//Function Number: 90
climbing_helper_player_in_combat_mode()
{
	return isdefined(level.exo_climb_rig.in_combat_mode);
}

//Function Number: 91
climbing_helper_dir_is_blocked(param_00)
{
	return param_00 == "blocked";
}

//Function Number: 92
climbing_helper_player_combat_requested()
{
	return level.exo_climb_rig.combatbuttonbuffer > 0;
}

//Function Number: 93
climbing_helper_player_exit_combat_mode_requested()
{
	return isdefined(level.exo_climb_rig.crouch_button_reset) && level.player buttonpressed("Button_B");
}

//Function Number: 94
climbing_helper_player_dismount_requested()
{
	if(!isdefined(level.exo_climb_rig.dismount_timer))
	{
		level.exo_climb_rig.dismount_timer = 500;
	}

	if(climbing_helper_player_moving())
	{
		level.exo_climb_rig.dismount_timer = 500;
		return 0;
	}

	if(isdefined(level.exo_climb_force_animated_dismount))
	{
		return 1;
	}

	if(level.player buttonpressed("BUTTON_X"))
	{
		if(isdefined(level.exo_climb_rig.dismount_timer) && level.exo_climb_rig.dismount_timer < 0)
		{
			return 1;
		}
		else
		{
			level.exo_climb_rig.dismount_timer = level.exo_climb_rig.dismount_timer - 50;
		}

		return 0;
	}

	level.exo_climb_rig.dismount_timer = 500;
	return 0;
}

//Function Number: 95
force_animated_dismount(param_00,param_01,param_02,param_03)
{
	level.exo_climb_force_animated_dismount = 1;
	level.exo_climb_animated_dismount = [];
	level.exo_climb_animated_dismount["org"] = param_00;
	level.exo_climb_animated_dismount["animname"] = param_01;
	level.exo_climb_animated_dismount["anime"] = param_02;
	level.exo_climb_animated_dismount["keep_rig"] = param_03;
}

//Function Number: 96
toggle_mount_mag_trigger_off(param_00,param_01)
{
	self.allow_exo_climb = undefined;
	level.exo_climb_retest_jumps_triggers = 1;
	if(!isdefined(level.exo_climb_rig))
	{
		return;
	}

	if(isdefined(param_00))
	{
		if(!isdefined(param_01))
		{
			param_01 = 0;
		}

		var_02 = gettime() + param_01 * 1000;
		var_03 = spawn("script_origin",level.exo_climb_player_center.origin);
		while(gettime() < var_02)
		{
			var_03.origin = level.exo_climb_player_center.origin;
			mag_mount_unlink_player(param_00,var_03);
			mag_mount_link_player(param_00,var_03);
			wait(0.05);
		}

		var_03 delete();
	}
}

//Function Number: 97
toggle_mount_mag_trigger_on(param_00)
{
	self.allow_exo_climb = 1;
	level.exo_climb_retest_jumps_triggers = 1;
	if(!isdefined(level.exo_climb_rig))
	{
		return;
	}

	var_01 = spawn("script_origin",level.exo_climb_player_center.origin);
	for(var_02 = 0;var_02 < 5;var_02++)
	{
		var_01.origin = level.exo_climb_player_center.origin;
		mag_mount_unlink_player(param_00,var_01);
		wait(0.05);
	}

	var_01 delete();
}

//Function Number: 98
mag_mount_link_player(param_00,param_01)
{
	if(!isdefined(param_00.player_linked) && param_01 istouching(self))
	{
		level.exo_climb_rig linkto(param_00);
		level.exo_climb_rig.is_linked = 1;
		param_00.player_linked = 1;
	}
}

//Function Number: 99
mag_mount_unlink_player(param_00,param_01)
{
	if(isdefined(param_00.player_linked))
	{
		level.exo_climb_rig unlink();
		level.exo_climb_rig.is_linked = undefined;
		param_00.player_linked = undefined;
	}
}

//Function Number: 100
init_exoclimb_hud()
{
	if(isdefined(1) && 1)
	{
		temp_exoclimb_hud_init();
	}
}

//Function Number: 101
temp_exoclimb_hud_precache()
{
	precacheshader("hud_arrow_up");
	precacheshader("hud_arrow_down");
	precacheshader("hud_arrow_left");
	precacheshader("hud_arrow_right");
}

//Function Number: 102
temp_exoclimb_hud_init()
{
	if(isdefined(level.temp_exoclimb_hud))
	{
		return;
	}

	level.temp_exoclimb_hud = spawnstruct();
	level.temp_exoclimb_hud.up_arrow = newhudelem();
	level.temp_exoclimb_hud.up_arrow.x = 320;
	level.temp_exoclimb_hud.up_arrow.y = 324;
	level.temp_exoclimb_hud.up_arrow.alignx = "center";
	level.temp_exoclimb_hud.up_arrow.aligny = "middle";
	level.temp_exoclimb_hud.up_arrow.horzalign = "fullscreen";
	level.temp_exoclimb_hud.up_arrow.vertalign = "fullscreen";
	level.temp_exoclimb_hud.up_arrow.color = (1,1,1);
	level.temp_exoclimb_hud.up_arrow setshader("hud_arrow_up",64,64);
	level.temp_exoclimb_hud.down_arrow = newhudelem();
	level.temp_exoclimb_hud.down_arrow.x = 320;
	level.temp_exoclimb_hud.down_arrow.y = 356;
	level.temp_exoclimb_hud.down_arrow.alignx = "center";
	level.temp_exoclimb_hud.down_arrow.aligny = "middle";
	level.temp_exoclimb_hud.down_arrow.horzalign = "fullscreen";
	level.temp_exoclimb_hud.down_arrow.vertalign = "fullscreen";
	level.temp_exoclimb_hud.down_arrow.color = (1,1,1);
	level.temp_exoclimb_hud.down_arrow setshader("hud_arrow_down",64,64);
	level.temp_exoclimb_hud.left_arrow = newhudelem();
	level.temp_exoclimb_hud.left_arrow.x = 304;
	level.temp_exoclimb_hud.left_arrow.y = 340;
	level.temp_exoclimb_hud.left_arrow.alignx = "center";
	level.temp_exoclimb_hud.left_arrow.aligny = "middle";
	level.temp_exoclimb_hud.left_arrow.horzalign = "fullscreen";
	level.temp_exoclimb_hud.left_arrow.vertalign = "fullscreen";
	level.temp_exoclimb_hud.left_arrow.color = (1,1,1);
	level.temp_exoclimb_hud.left_arrow setshader("hud_arrow_left",64,64);
	level.temp_exoclimb_hud.right_arrow = newhudelem();
	level.temp_exoclimb_hud.right_arrow.x = 336;
	level.temp_exoclimb_hud.right_arrow.y = 340;
	level.temp_exoclimb_hud.right_arrow.alignx = "center";
	level.temp_exoclimb_hud.right_arrow.aligny = "middle";
	level.temp_exoclimb_hud.right_arrow.horzalign = "fullscreen";
	level.temp_exoclimb_hud.right_arrow.vertalign = "fullscreen";
	level.temp_exoclimb_hud.right_arrow.color = (1,1,1);
	level.temp_exoclimb_hud.right_arrow setshader("hud_arrow_right",64,64);
	temp_exoclimb_hud_hide();
}

//Function Number: 103
temp_exoclimb_hud_hide()
{
	level.temp_exoclimb_hud.up_arrow.alpha = 0;
	level.temp_exoclimb_hud.down_arrow.alpha = 0;
	level.temp_exoclimb_hud.left_arrow.alpha = 0;
	level.temp_exoclimb_hud.right_arrow.alpha = 0;
}

//Function Number: 104
temp_exoclimb_hud_check_array(param_00)
{
	if(isdefined(param_00["u"]) && param_00["u"] != "blocked")
	{
		level.temp_exoclimb_hud.show_up_arrow = 1;
	}

	if(isdefined(param_00["d"]) && param_00["d"] != "blocked")
	{
		level.temp_exoclimb_hud.show_down_arrow = 1;
	}

	if(isdefined(param_00["l"]) && param_00["l"] != "blocked")
	{
		level.temp_exoclimb_hud.show_left_arrow = 1;
	}

	if(isdefined(param_00["r"]) && param_00["r"] != "blocked")
	{
		level.temp_exoclimb_hud.show_right_arrow = 1;
	}
}

//Function Number: 105
temp_exoclimb_hud_thread()
{
	var_00 = 0.05;
	for(;;)
	{
		if(is_exo_climbing() && climbing_helper_player_input_1_allowed())
		{
			level.temp_exoclimb_hud.show_up_arrow = 0;
			level.temp_exoclimb_hud.show_down_arrow = 0;
			level.temp_exoclimb_hud.show_left_arrow = 0;
			level.temp_exoclimb_hud.show_right_arrow = 0;
			temp_exoclimb_hud_check_array(level.exo_climb_move_options["long"]);
			temp_exoclimb_hud_check_array(level.exo_climb_move_options["short"]);
			temp_exoclimb_hud_check_array(level.exo_climb_move_options["jump2mag"]);
			temp_exoclimb_hud_check_array(level.exo_climb_move_options["mag2jump"]);
			if(level.temp_exoclimb_hud.show_up_arrow)
			{
				level.temp_exoclimb_hud.up_arrow.alpha = 0.7;
			}
			else
			{
				level.temp_exoclimb_hud.up_arrow.alpha = 0;
			}

			if(level.temp_exoclimb_hud.show_down_arrow)
			{
				level.temp_exoclimb_hud.down_arrow.alpha = 0.7;
			}
			else
			{
				level.temp_exoclimb_hud.down_arrow.alpha = 0;
			}

			if(level.temp_exoclimb_hud.show_left_arrow)
			{
				level.temp_exoclimb_hud.left_arrow.alpha = 0.7;
			}
			else
			{
				level.temp_exoclimb_hud.left_arrow.alpha = 0;
			}

			if(level.temp_exoclimb_hud.show_right_arrow)
			{
				level.temp_exoclimb_hud.right_arrow.alpha = 0.7;
			}
			else
			{
				level.temp_exoclimb_hud.right_arrow.alpha = 0;
			}
		}
		else
		{
			temp_exoclimb_hud_hide();
		}

		wait(var_00);
	}
}

//Function Number: 106
setup_exo_climb_audio()
{
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_mount_jump",::aud_exo_climb_mount_jump,"mount2mag");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_mount_land",::aud_exo_climb_mount_land,"mount2mag");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_windup_lt",::aud_exo_climb_windup_lt,"mount2mag");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_windup_rt",::aud_exo_climb_windup_rt,"mount2mag");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_hit_lt",::aud_exo_climb_hit_lt,"mount2mag");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_hit_rt",::aud_exo_climb_hit_rt,"mount2mag");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_gear_lt",::aud_exo_climb_gear_lt,"magnetic_u_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_gear_rt",::aud_exo_climb_gear_rt,"magnetic_u_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_windup_lt",::aud_exo_climb_windup_lt,"magnetic_u_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_windup_rt",::aud_exo_climb_windup_rt,"magnetic_u_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_hit_lt",::aud_exo_climb_hit_lt,"magnetic_u_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_hit_rt",::aud_exo_climb_hit_rt,"magnetic_u_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_rest_lt",::aud_exo_climb_rest_lt,"magnetic_u_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_rest_rt",::aud_exo_climb_rest_rt,"magnetic_u_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_gear_lt",::aud_exo_climb_gear_lt,"magnetic_u_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_gear_rt",::aud_exo_climb_gear_rt,"magnetic_u_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_windup_lt",::aud_exo_climb_windup_lt,"magnetic_u_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_windup_rt",::aud_exo_climb_windup_rt,"magnetic_u_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_hit_lt",::aud_exo_climb_hit_lt,"magnetic_u_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_hit_rt",::aud_exo_climb_hit_rt,"magnetic_u_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_rest_lt",::aud_exo_climb_rest_lt,"magnetic_u_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_rest_rt",::aud_exo_climb_rest_rt,"magnetic_u_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_gear_lt",::aud_exo_climb_gear_lt,"magnetic_u_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_gear_rt",::aud_exo_climb_gear_rt,"magnetic_u_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_windup_lt",::aud_exo_climb_windup_lt,"magnetic_u_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_windup_rt",::aud_exo_climb_windup_rt,"magnetic_u_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_hit_lt",::aud_exo_climb_hit_lt,"magnetic_u_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_hit_rt",::aud_exo_climb_hit_rt,"magnetic_u_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_rest_lt",::aud_exo_climb_rest_lt,"magnetic_u_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_rest_rt",::aud_exo_climb_rest_rt,"magnetic_u_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_gear_lt",::aud_exo_climb_gear_lt,"magnetic_l_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_gear_rt",::aud_exo_climb_gear_rt,"magnetic_l_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_windup_lt",::aud_exo_climb_windup_lt,"magnetic_l_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_windup_rt",::aud_exo_climb_windup_rt,"magnetic_l_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_hit_lt",::aud_exo_climb_hit_lt,"magnetic_l_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_hit_rt",::aud_exo_climb_hit_rt,"magnetic_l_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_rest_lt",::aud_exo_climb_rest_lt,"magnetic_l_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_rest_rt",::aud_exo_climb_rest_rt,"magnetic_l_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_gear_lt",::aud_exo_climb_gear_lt,"magnetic_l_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_gear_rt",::aud_exo_climb_gear_rt,"magnetic_l_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_windup_lt",::aud_exo_climb_windup_lt,"magnetic_l_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_windup_rt",::aud_exo_climb_windup_rt,"magnetic_l_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_hit_lt",::aud_exo_climb_hit_lt,"magnetic_l_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_hit_rt",::aud_exo_climb_hit_rt,"magnetic_l_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_rest_lt",::aud_exo_climb_rest_lt,"magnetic_l_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_rest_rt",::aud_exo_climb_rest_rt,"magnetic_l_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_gear_lt",::aud_exo_climb_gear_lt,"magnetic_l_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_gear_rt",::aud_exo_climb_gear_rt,"magnetic_l_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_windup_lt",::aud_exo_climb_windup_lt,"magnetic_l_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_windup_rt",::aud_exo_climb_windup_rt,"magnetic_l_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_hit_lt",::aud_exo_climb_hit_lt,"magnetic_l_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_hit_rt",::aud_exo_climb_hit_rt,"magnetic_l_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_rest_lt",::aud_exo_climb_rest_lt,"magnetic_l_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_rest_rt",::aud_exo_climb_rest_rt,"magnetic_l_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_gear_lt",::aud_exo_climb_gear_lt,"magnetic_r_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_gear_rt",::aud_exo_climb_gear_rt,"magnetic_r_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_windup_lt",::aud_exo_climb_windup_lt,"magnetic_r_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_windup_rt",::aud_exo_climb_windup_rt,"magnetic_r_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_hit_lt",::aud_exo_climb_hit_lt,"magnetic_r_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_hit_rt",::aud_exo_climb_hit_rt,"magnetic_r_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_rest_lt",::aud_exo_climb_rest_lt,"magnetic_r_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_rest_rt",::aud_exo_climb_rest_rt,"magnetic_r_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_gear_lt",::aud_exo_climb_gear_lt,"magnetic_r_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_gear_rt",::aud_exo_climb_gear_rt,"magnetic_r_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_windup_lt",::aud_exo_climb_windup_lt,"magnetic_r_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_windup_rt",::aud_exo_climb_windup_rt,"magnetic_r_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_hit_lt",::aud_exo_climb_hit_lt,"magnetic_r_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_hit_rt",::aud_exo_climb_hit_rt,"magnetic_r_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_rest_lt",::aud_exo_climb_rest_lt,"magnetic_r_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_rest_rt",::aud_exo_climb_rest_rt,"magnetic_r_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_gear_lt",::aud_exo_climb_gear_lt,"magnetic_r_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_gear_rt",::aud_exo_climb_gear_rt,"magnetic_r_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_windup_lt",::aud_exo_climb_windup_lt,"magnetic_r_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_windup_rt",::aud_exo_climb_windup_rt,"magnetic_r_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_hit_lt",::aud_exo_climb_hit_lt,"magnetic_r_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_hit_rt",::aud_exo_climb_hit_rt,"magnetic_r_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_rest_lt",::aud_exo_climb_rest_lt,"magnetic_r_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_rest_rt",::aud_exo_climb_rest_rt,"magnetic_r_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_slide_push",::aud_exo_climb_slide_push,"magnetic_d_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_slide_start",::aud_exo_climb_slide_start,"magnetic_d_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_slide_stop",::aud_exo_climb_slide_stop,"magnetic_d_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_gear_rt",::aud_exo_climb_gear_rt,"magnetic_d_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_windup_rt",::aud_exo_climb_windup_rt,"magnetic_d_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_hit_rt",::aud_exo_climb_hit_rt,"magnetic_d_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_rest_rt",::aud_exo_climb_rest_lt,"magnetic_d_0");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_slide_start",::aud_exo_climb_slide_start,"magnetic_d_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_slide_stop",::aud_exo_climb_slide_stop,"magnetic_d_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_gear_rt",::aud_exo_climb_gear_rt,"magnetic_d_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_windup_rt",::aud_exo_climb_windup_rt,"magnetic_d_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_hit_rt",::aud_exo_climb_hit_rt,"magnetic_d_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_rest_rt",::aud_exo_climb_rest_lt,"magnetic_d_1");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_slide_start",::aud_exo_climb_slide_start,"magnetic_d_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_slide_stop",::aud_exo_climb_slide_stop,"magnetic_d_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_gear_rt",::aud_exo_climb_gear_rt,"magnetic_d_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_windup_rt",::aud_exo_climb_windup_rt,"magnetic_d_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_hit_rt",::aud_exo_climb_hit_rt,"magnetic_d_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_rest_rt",::aud_exo_climb_rest_lt,"magnetic_d_2");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_gear_lt",::aud_exo_climb_gear_lt,"dismount");
	maps\_anim::addnotetrack_customfunction("player_climb_rig","aud_exo_climb_gear_rt",::aud_exo_climb_gear_rt,"dismount");
}

//Function Number: 107
aud_exo_climb_mount_jump(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("exo_climb_mount_jump");
}

//Function Number: 108
aud_exo_climb_mount_land(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("exo_climb_mount_land");
}

//Function Number: 109
aud_exo_climb_gear_lt(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("exo_climb_gear_lt");
}

//Function Number: 110
aud_exo_climb_gear_rt(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("exo_climb_gear_rt");
}

//Function Number: 111
aud_exo_climb_windup_lt(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("exo_climb_windup_lt");
}

//Function Number: 112
aud_exo_climb_windup_rt(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("exo_climb_windup_rt");
}

//Function Number: 113
aud_exo_climb_hit_lt(param_00)
{
	exo_climb_mag_rumble(param_00);
	soundscripts\_snd_playsound::snd_play_2d("exo_climb_hit_magnet");
}

//Function Number: 114
aud_exo_climb_hit_rt(param_00)
{
	exo_climb_mag_rumble(param_00);
	soundscripts\_snd_playsound::snd_play_2d("exo_climb_hit_magnet");
}

//Function Number: 115
aud_exo_climb_rest_lt(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("exo_climb_rest_magnet");
}

//Function Number: 116
aud_exo_climb_rest_rt(param_00)
{
	soundscripts\_snd_playsound::snd_play_2d("exo_climb_rest_magnet");
}

//Function Number: 117
aud_exo_climb_slide_push(param_00)
{
}

//Function Number: 118
aud_exo_climb_slide_start(param_00)
{
	if(!isdefined(level.aud.exo_climb_sliding))
	{
		level.aud.exo_climb_sliding = 1;
		soundscripts\_snd_playsound::snd_play_loop_2d("exo_climb_slide_lp","kill_exo_slide",undefined,0.5);
	}
}

//Function Number: 119
aud_exo_climb_slide_stop(param_00)
{
	level notify("kill_exo_slide");
	level.aud.exo_climb_sliding = undefined;
	exo_climb_mag_rumble(param_00);
}