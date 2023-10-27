/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\animset.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 56
 * Decompile Time: 964 ms
 * Timestamp: 10/27/2023 1:54:17 AM
*******************************************************************/

//Function Number: 1
init_anim_sets()
{
	if(isdefined(level.archetypes))
	{
		return;
	}

	anim.archetypes = [];
	level.archetypes["soldier"] = [];
	animscripts\cover_left::init_animset_cover_left();
	animscripts\cover_right::init_animset_cover_right();
	animscripts\cover_prone::init_animset_cover_prone();
	animscripts\cover_multi::init_animset_cover_multi();
	animscripts\cover_wall::init_animset_cover_wall();
	animscripts\reactions::init_animset_reactions();
	animscripts\pain::init_animset_pain();
	animscripts\death::init_animset_death();
	animscripts\combat::init_animset_combat();
	animscripts\move::init_animset_default_move();
	animscripts\move::init_animset_smg_move();
	animscripts\flashed::init_animset_flashed();
	animscripts\stop::init_animset_idle();
	animscripts\melee::init_animset_melee();
	anim.animsets = spawnstruct();
	level.animsets.move = [];
	init_animset_default_stand();
	init_animset_cqb_stand();
	init_animset_pistol_stand();
	init_animset_rpg_stand();
	init_animset_shotgun_stand();
	init_animset_heat_stand();
	init_animset_smg_stand();
	init_animset_unstable_stand();
	init_animset_default_crouch();
	init_animset_rpg_crouch();
	init_animset_shotgun_crouch();
	init_animset_smg_crouch();
	init_animset_default_prone();
	init_animset_run_move();
	init_animset_walk_move();
	init_animset_cqb_move();
	init_animset_heat_run_move();
	init_animset_unstable_walk_move();
	init_animset_unstable_run_move();
	init_animset_pistol_move();
	init_moving_turn_animations();
	init_exposed_turn_animations();
	init_animset_heat_reload();
	init_grenade_animations();
	init_animset_run_n_gun();
	init_animset_ambush();
	init_animset_smg_ambush();
	init_animset_smg_crouch_run();
	if(maps\_utility::s1_motionset_avaliable())
	{
		level.archetypes["s1_soldier"] = [];
		animscripts\s1_common_anims::init_s1_animset_smg_crouch();
		animscripts\s1_common_anims::init_s1_animset_default_crouch();
		animscripts\s1_common_anims::init_s1_animset_melee();
		animscripts\s1_common_anims::init_s1_animset_default_stand();
		animscripts\s1_common_anims::init_s1_animset_cqb_stand();
		animscripts\s1_common_anims::init_s1_animset_cover_left();
		animscripts\s1_common_anims::init_s1_animset_cover_right();
		animscripts\s1_common_anims::init_s1_animset_cover_wall();
		animscripts\s1_common_anims::init_s1_animset_run_move();
		animscripts\s1_common_anims::init_s1_moving_turn_animations();
		animscripts\s1_common_anims::init_s1_animset_run_n_gun();
		animscripts\s1_common_anims::init_s1_animset_pain();
		animscripts\s1_common_anims::init_s1_animset_death();
		animscripts\s1_common_anims::init_s1_animset_idle();
		animscripts\s1_common_anims::init_s1_animset_walk_move();
		animscripts\s1_common_anims::init_s1_animset_default_move();
		animscripts\s1_common_anims::init_s1_animset_combat();
		animscripts\s1_common_anims::init_s1_exposed_turn_animations();
		animscripts\s1_common_anims::init_s1_coverstand_turn_animations();
		level.archetypes["s1_soldier"]["old_default_stand"] = level.archetypes["soldier"]["default_stand"];
	}
}

//Function Number: 2
registerarchetype(param_00,param_01,param_02)
{
	init_anim_sets();
	level.archetypes[param_00] = param_01;
	if(isdefined(param_01["flashed"]))
	{
		level.flashanimindex[param_00] = 0;
	}

	if(isdefined(param_02) && param_02)
	{
		animscripts\init_move_transitions::getsplittimes(param_00);
	}
}

//Function Number: 3
archetypeexists(param_00)
{
	return isdefined(level.archetypes[param_00]);
}

//Function Number: 4
init_animset_run_move()
{
	anim.initanimset = [];
	level.initanimset["sprint"] = %sprint_loop_distant;
	level.initanimset["sprint_short"] = %sprint1_loop;
	level.initanimset["prone"] = %prone_crawl;
	level.initanimset["straight"] = %run_lowready_f;
	level.initanimset["smg_straight"] = %smg_run_lowready_f;
	level.initanimset["straight_twitch"] = [%run_twitch_guncheck,%run_twitch_aim_straight,%run_twitch_aim_above,%run_twitch_lookbehind_a,%run_twitch_lookbehind_b];
	level.initanimset["move_f"] = %walk_forward;
	level.initanimset["move_l"] = %walk_left;
	level.initanimset["move_r"] = %walk_right;
	level.initanimset["move_b"] = %walk_backward;
	level.initanimset["crouch"] = %crouch_fastwalk_f;
	level.initanimset["crouch_l"] = %crouch_fastwalk_l;
	level.initanimset["crouch_r"] = %crouch_fastwalk_r;
	level.initanimset["crouch_b"] = %crouch_fastwalk_b;
	level.initanimset["stairs_up"] = %run_stairs_up;
	level.initanimset["stairs_up_in"] = %run_stairs_up_in;
	level.initanimset["stairs_up_out"] = %run_stairs_up_out;
	level.initanimset["stairs_down"] = %traverse_stair_run_down;
	level.initanimset["reload"] = [%run_reload_a,%run_reload_b];
	level.archetypes["soldier"]["run"] = level.initanimset;
}

//Function Number: 5
init_animset_unstable_run_move()
{
	anim.initanimset = [];
	level.initanimset["sprint"] = %lag_unstable_run;
	level.initanimset["sprint_short"] = %lag_unstable_run;
	level.initanimset["straight"] = %lag_unstable_run;
	level.initanimset["straight_twitch"] = [%lag_unstable_run];
	level.initanimset["move_f"] = %walk_cqb_f;
	level.initanimset["move_l"] = %walk_left;
	level.initanimset["move_r"] = %walk_right;
	level.initanimset["move_b"] = %walk_backward;
	level.initanimset["aim_2"] = %cqb_run_aim_2;
	level.initanimset["aim_4"] = %cqb_run_aim_4;
	level.initanimset["aim_5"] = %cqb_run_aim_5;
	level.initanimset["aim_6"] = %cqb_run_aim_6;
	level.initanimset["aim_8"] = %cqb_run_aim_8;
	level.initanimset["stairs_up"] = %traverse_stair_run;
	level.initanimset["stairs_down_in"] = %cqb_stairs_down_in_m;
	level.initanimset["stairs_down"] = %cqb_stairs_down;
	level.initanimset["stairs_down_out"] = %cqb_stairs_down_out_m;
	level.initanimset["shotgun_pullout"] = %shotgun_cqbrun_pullout;
	level.initanimset["shotgun_putaway"] = %shotgun_cqbrun_putaway;
	level.initanimset["reload"] = [%cqb_run_reload_a_iw6,%cqb_run_reload_b_iw6];
	level.archetypes["soldier"]["unstable_run"] = level.initanimset;
}

//Function Number: 6
init_animset_heat_run_move()
{
	anim.initanimset = level.archetypes["soldier"]["run"];
	level.initanimset["straight"] = %heat_run_loop;
	level.archetypes["soldier"]["heat_run"] = level.initanimset;
}

//Function Number: 7
init_animset_walk_move()
{
	anim.initanimset = [];
	level.initanimset["sprint"] = %sprint_loop_distant;
	level.initanimset["sprint_short"] = %sprint1_loop;
	level.initanimset["prone"] = %prone_crawl;
	level.initanimset["straight"] = %walk_cqb_f;
	level.initanimset["move_f"] = %walk_cqb_f;
	level.initanimset["move_l"] = %walk_left;
	level.initanimset["move_r"] = %walk_right;
	level.initanimset["move_b"] = %walk_backward;
	level.initanimset["crouch"] = %crouch_fastwalk_f;
	level.initanimset["crouch_l"] = %crouch_fastwalk_l;
	level.initanimset["crouch_r"] = %crouch_fastwalk_r;
	level.initanimset["crouch_b"] = %crouch_fastwalk_b;
	level.initanimset["aim_2"] = %walk_aim_2;
	level.initanimset["aim_4"] = %walk_aim_4;
	level.initanimset["aim_6"] = %walk_aim_6;
	level.initanimset["aim_8"] = %walk_aim_8;
	level.initanimset["stairs_up"] = %traverse_stair_run;
	level.initanimset["stairs_down"] = %traverse_stair_run_down_01;
	level.archetypes["soldier"]["walk"] = level.initanimset;
}

//Function Number: 8
init_animset_unstable_walk_move()
{
	anim.initanimset = [];
	level.initanimset["sprint"] = %lag_unstable_run;
	level.initanimset["sprint_short"] = %lag_unstable_run;
	level.initanimset["straight"] = %lag_unstable_moveforward_walk;
	level.initanimset["straight_twitch_l"] = [%lag_unstable_moveforward_stumble_l];
	level.initanimset["straight_twitch_r"] = [%lag_unstable_moveforward_stumble_r];
	level.initanimset["straight_twitch"] = [%lag_unstable_moveforward_stumble];
	level.initanimset["move_f"] = %walk_cqb_f;
	level.initanimset["move_l"] = %walk_left;
	level.initanimset["move_r"] = %walk_right;
	level.initanimset["move_b"] = %walk_backward;
	level.initanimset["aim_2"] = %cqb_run_aim_2;
	level.initanimset["aim_4"] = %cqb_run_aim_4;
	level.initanimset["aim_5"] = %cqb_run_aim_5;
	level.initanimset["aim_6"] = %cqb_run_aim_6;
	level.initanimset["aim_8"] = %cqb_run_aim_8;
	level.initanimset["stairs_up"] = %traverse_stair_run;
	level.initanimset["stairs_down_in"] = %cqb_stairs_down_in_m;
	level.initanimset["stairs_down"] = %cqb_stairs_down;
	level.initanimset["stairs_down_out"] = %cqb_stairs_down_out_m;
	level.initanimset["shotgun_pullout"] = %shotgun_cqbrun_pullout;
	level.initanimset["shotgun_putaway"] = %shotgun_cqbrun_putaway;
	level.initanimset["reload"] = [%cqb_run_reload_a_iw6,%cqb_run_reload_b_iw6];
	level.archetypes["soldier"]["unstable_walk"] = level.initanimset;
}

//Function Number: 9
init_animset_cqb_move()
{
	anim.initanimset = [];
	level.initanimset["sprint"] = %sprint_loop_distant;
	level.initanimset["sprint_short"] = %sprint1_loop;
	level.initanimset["straight"] = %run_cqb_f_search_v1;
	level.initanimset["straight_twitch"] = [%cqb_run_twitch_a_iw6,%cqb_run_twitch_b_iw6,%cqb_run_twitch_c_iw6,%cqb_run_twitch_d_iw6];
	level.initanimset["move_f"] = %walk_cqb_f;
	level.initanimset["move_l"] = %walk_left;
	level.initanimset["move_r"] = %walk_right;
	level.initanimset["move_b"] = %walk_backward;
	level.initanimset["aim_2"] = %cqb_run_aim_2;
	level.initanimset["aim_4"] = %cqb_run_aim_4;
	level.initanimset["aim_5"] = %cqb_run_aim_5;
	level.initanimset["aim_6"] = %cqb_run_aim_6;
	level.initanimset["aim_8"] = %cqb_run_aim_8;
	level.initanimset["stairs_up"] = %traverse_stair_run;
	level.initanimset["stairs_down_in"] = %cqb_stairs_down_in_m;
	level.initanimset["stairs_down"] = %cqb_stairs_down;
	level.initanimset["stairs_down_out"] = %cqb_stairs_down_out_m;
	level.initanimset["shotgun_pullout"] = %shotgun_cqbrun_pullout;
	level.initanimset["shotgun_putaway"] = %shotgun_cqbrun_putaway;
	level.initanimset["reload"] = [%cqb_run_reload_a_iw6,%cqb_run_reload_b_iw6];
	level.archetypes["soldier"]["cqb"] = level.initanimset;
}

//Function Number: 10
init_animset_pistol_move()
{
	anim.initanimset = [];
	level.initanimset["sprint"] = %pistol_sprint;
	level.initanimset["sprint_short"] = %pistol_sprint;
	level.initanimset["straight"] = %pistol_walk;
	level.initanimset["move_f"] = %pistol_walk;
	level.initanimset["move_l"] = %pistol_walk_left;
	level.initanimset["move_r"] = %pistol_walk_right;
	level.initanimset["move_b"] = %pistol_walk_back;
	level.archetypes["soldier"]["pistol_move"] = level.initanimset;
}

//Function Number: 11
init_animset_pistol_stand()
{
	anim.initanimset = [];
	level.initanimset["add_aim_up"] = %pistol_stand_aim_8_add;
	level.initanimset["add_aim_down"] = %pistol_stand_aim_2_add;
	level.initanimset["add_aim_left"] = %pistol_stand_aim_4_add;
	level.initanimset["add_aim_right"] = %pistol_stand_aim_6_add;
	level.initanimset["straight_level"] = %pistol_stand_aim_5;
	level.initanimset["fire"] = %pistol_stand_fire_a;
	level.initanimset["single"] = animscripts\utility::array(%pistol_stand_fire_a);
	level.initanimset["reload"] = animscripts\utility::array(%pistol_stand_reload_a);
	level.initanimset["reload_crouchhide"] = [];
	level.initanimset["exposed_idle"] = [%exposed_idle_alert_v1,%exposed_idle_alert_v2,%exposed_idle_alert_v3];
	set_animarray_standing_turns_pistol();
	level.initanimset["add_turn_aim_up"] = %pistol_stand_aim_8_alt;
	level.initanimset["add_turn_aim_down"] = %pistol_stand_aim_2_alt;
	level.initanimset["add_turn_aim_left"] = %pistol_stand_aim_4_alt;
	level.initanimset["add_turn_aim_right"] = %pistol_stand_aim_6_alt;
	level.archetypes["soldier"]["pistol_stand"] = level.initanimset;
}

//Function Number: 12
init_animset_rpg_stand()
{
	anim.initanimset = [];
	level.initanimset["add_aim_up"] = %rpg_stand_aim_8;
	level.initanimset["add_aim_down"] = %rpg_stand_aim_2;
	level.initanimset["add_aim_left"] = %rpg_stand_aim_4;
	level.initanimset["add_aim_right"] = %rpg_stand_aim_6;
	level.initanimset["straight_level"] = %rpg_stand_aim_5;
	level.initanimset["fire"] = %rpg_stand_fire;
	level.initanimset["single"] = [%exposed_shoot_semi1];
	level.initanimset["reload"] = [%rpg_stand_reload];
	level.initanimset["reload_crouchhide"] = [];
	level.initanimset["exposed_idle"] = [%rpg_stand_idle];
	set_animarray_stance_change();
	set_animarray_standing_turns();
	set_animarray_add_turn_aims_stand();
	level.archetypes["soldier"]["rpg_stand"] = level.initanimset;
}

//Function Number: 13
init_animset_shotgun_stand()
{
	anim.initanimset = [];
	level.initanimset["add_aim_up"] = %shotgun_aim_8;
	level.initanimset["add_aim_down"] = %shotgun_aim_2;
	level.initanimset["add_aim_left"] = %shotgun_aim_4;
	level.initanimset["add_aim_right"] = %shotgun_aim_6;
	level.initanimset["straight_level"] = %shotgun_aim_5;
	level.initanimset["fire"] = %exposed_shoot_auto_v3;
	level.initanimset["single"] = [%shotgun_stand_fire_1a,%shotgun_stand_fire_1b];
	set_animarray_burst_and_semi_fire_stand();
	level.initanimset["exposed_idle"] = [%exposed_idle_alert_v1,%exposed_idle_alert_v2,%exposed_idle_alert_v3];
	level.initanimset["reload"] = [%shotgun_stand_reload_a,%shotgun_stand_reload_b,%shotgun_stand_reload_c,%shotgun_stand_reload_c,%shotgun_stand_reload_c];
	level.initanimset["reload_crouchhide"] = [%shotgun_stand_reload_a,%shotgun_stand_reload_b];
	set_animarray_stance_change();
	set_animarray_standing_turns();
	set_animarray_add_turn_aims_stand();
	level.archetypes["soldier"]["shotgun_stand"] = level.initanimset;
}

//Function Number: 14
init_animset_smg_stand()
{
	anim.initanimset = [];
	level.initanimset["add_aim_up"] = %smg_exposed_aim_8;
	level.initanimset["add_aim_down"] = %smg_exposed_aim_2;
	level.initanimset["add_aim_left"] = %smg_exposed_aim_4;
	level.initanimset["add_aim_right"] = %smg_exposed_aim_6;
	level.initanimset["straight_level"] = %smg_exposed_aim_5;
	level.initanimset["fire"] = %smg_exposed_shoot_auto_v3;
	level.initanimset["fire_corner"] = %smg_exposed_shoot_auto_v2;
	level.initanimset["single"] = animscripts\utility::array(%smg_exposed_shoot_semi1);
	set_animarray_burst_and_semi_fire_stand();
	level.initanimset["exposed_idle"] = animscripts\utility::array(%smg_exposed_idle_alert_v1,%smg_exposed_idle_alert_v2,%smg_exposed_idle_alert_v3);
	level.initanimset["exposed_grenade"] = animscripts\utility::array(%smg_exposed_grenadethrowb,%smg_exposed_grenadethrowc);
	level.initanimset["reload"] = animscripts\utility::array(%smg_exposed_reload);
	level.initanimset["reload_crouchhide"] = animscripts\utility::array(%smg_exposed_reloadb);
	set_animarray_stance_change_smg();
	set_animarray_smg_standing_turns();
	set_animarray_add_smg_turn_aims_stand();
	level.archetypes["soldier"]["smg_stand"] = level.initanimset;
}

//Function Number: 15
init_animset_cqb_stand()
{
	anim.initanimset = [];
	level.initanimset["add_aim_up"] = %cqb_stand_aim8;
	level.initanimset["add_aim_down"] = %cqb_stand_aim2;
	level.initanimset["add_aim_left"] = %cqb_stand_aim4;
	level.initanimset["add_aim_right"] = %cqb_stand_aim6;
	level.initanimset["straight_level"] = %cqb_stand_aim5;
	level.initanimset["fire"] = %exposed_shoot_auto_v3;
	level.initanimset["single"] = [%exposed_shoot_semi1];
	set_animarray_burst_and_semi_fire_stand();
	level.initanimset["exposed_idle"] = [%exposed_idle_alert_v1,%exposed_idle_alert_v2,%exposed_idle_alert_v3];
	level.initanimset["reload"] = [%cqb_stand_reload_steady];
	level.initanimset["reload_crouchhide"] = [%cqb_stand_reload_knee];
	set_animarray_stance_change();
	set_animarray_standing_turns();
	set_animarray_add_turn_aims_stand();
	level.archetypes["soldier"]["cqb_stand"] = level.initanimset;
}

//Function Number: 16
init_animset_unstable_stand()
{
	anim.initanimset = [];
	level.initanimset["add_aim_up"] = %cqb_stand_aim8;
	level.initanimset["add_aim_down"] = %cqb_stand_aim2;
	level.initanimset["add_aim_left"] = %cqb_stand_aim4;
	level.initanimset["add_aim_right"] = %cqb_stand_aim6;
	level.initanimset["straight_level"] = %lag_unstable_idle;
	level.initanimset["fire"] = %exposed_shoot_auto_v3;
	level.initanimset["single"] = [%exposed_shoot_semi1];
	set_animarray_burst_and_semi_fire_stand();
	level.initanimset["exposed_idle"] = [%lag_unstable_idle];
	level.initanimset["reload"] = [%cqb_stand_reload_steady];
	level.initanimset["reload_crouchhide"] = [%cqb_stand_reload_knee];
	set_animarray_stance_change();
	set_animarray_standing_turns();
	set_animarray_add_turn_aims_stand();
	level.archetypes["soldier"]["unstable_stand"] = level.initanimset;
}

//Function Number: 17
init_animset_heat_stand()
{
	anim.initanimset = [];
	level.initanimset["add_aim_up"] = %heat_stand_aim_8;
	level.initanimset["add_aim_down"] = %heat_stand_aim_2;
	level.initanimset["add_aim_left"] = %heat_stand_aim_4;
	level.initanimset["add_aim_right"] = %heat_stand_aim_6;
	level.initanimset["straight_level"] = %heat_stand_aim_5;
	level.initanimset["fire"] = %heat_stand_fire_auto;
	level.initanimset["single"] = animscripts\utility::array(%heat_stand_fire_single);
	set_animarray_custom_burst_and_semi_fire_stand(%heat_stand_fire_burst);
	level.initanimset["exposed_idle"] = animscripts\utility::array(%heat_stand_idle,%heat_stand_scana,%heat_stand_scanb);
	level.initanimset["reload"] = animscripts\utility::array(%heat_exposed_reload);
	level.initanimset["reload_crouchhide"] = animscripts\utility::array();
	set_animarray_stance_change();
	level.initanimset["turn_left_45"] = %heat_stand_turn_l;
	level.initanimset["turn_left_90"] = %heat_stand_turn_l;
	level.initanimset["turn_left_135"] = %heat_stand_turn_180;
	level.initanimset["turn_left_180"] = %heat_stand_turn_180;
	level.initanimset["turn_right_45"] = %heat_stand_turn_r;
	level.initanimset["turn_right_90"] = %heat_stand_turn_r;
	level.initanimset["turn_right_135"] = %heat_stand_turn_180;
	level.initanimset["turn_right_180"] = %heat_stand_turn_180;
	set_animarray_add_turn_aims_stand();
	level.archetypes["soldier"]["heat_stand"] = level.initanimset;
}

//Function Number: 18
init_animset_heat_reload()
{
	anim.initanimset = [];
	level.initanimset["reload_cover_left"] = %heat_cover_reload_r;
	level.initanimset["reload_cover_right"] = %heat_cover_reload_l;
	level.initanimset["reload_default"] = %heat_cover_reload_l;
	level.archetypes["soldier"]["heat_reload"] = level.initanimset;
}

//Function Number: 19
init_animset_default_stand()
{
	anim.initanimset = [];
	level.initanimset["add_aim_up"] = %exposed_aim_8;
	level.initanimset["add_aim_down"] = %exposed_aim_2;
	level.initanimset["add_aim_left"] = %exposed_aim_4;
	level.initanimset["add_aim_right"] = %exposed_aim_6;
	level.initanimset["straight_level"] = %exposed_aim_5;
	level.initanimset["fire"] = %exposed_shoot_auto_v3;
	level.initanimset["fire_corner"] = %exposed_shoot_auto_v2;
	level.initanimset["single"] = animscripts\utility::array(%exposed_shoot_semi1);
	set_animarray_burst_and_semi_fire_stand();
	level.initanimset["exposed_idle"] = animscripts\utility::array(%exposed_idle_alert_v1,%exposed_idle_alert_v2,%exposed_idle_alert_v3);
	level.initanimset["exposed_grenade"] = animscripts\utility::array(%exposed_grenadethrowb,%exposed_grenadethrowc);
	level.initanimset["reload"] = animscripts\utility::array(%exposed_reload);
	level.initanimset["reload_crouchhide"] = animscripts\utility::array(%exposed_reloadb);
	set_animarray_stance_change();
	set_animarray_standing_turns();
	set_animarray_add_turn_aims_stand();
	level.archetypes["soldier"]["default_stand"] = level.initanimset;
}

//Function Number: 20
init_animset_default_crouch()
{
	anim.initanimset = [];
	set_animarray_crouch_aim();
	level.initanimset["fire"] = %exposed_crouch_shoot_auto_v2;
	level.initanimset["single"] = animscripts\utility::array(%exposed_crouch_shoot_semi1);
	set_animarray_burst_and_semi_fire_crouch();
	level.initanimset["reload"] = animscripts\utility::array(%exposed_crouch_reload);
	level.initanimset["exposed_idle"] = animscripts\utility::array(%exposed_crouch_idle_alert_v1,%exposed_crouch_idle_alert_v2,%exposed_crouch_idle_alert_v3);
	set_animarray_stance_change();
	set_animarray_crouching_turns();
	set_animarray_add_turn_aims_crouch();
	level.archetypes["soldier"]["default_crouch"] = level.initanimset;
}

//Function Number: 21
init_animset_rpg_crouch()
{
	anim.initanimset = [];
	level.initanimset["add_aim_up"] = %rpg_crouch_aim_8;
	level.initanimset["add_aim_down"] = %rpg_crouch_aim_2;
	level.initanimset["add_aim_left"] = %rpg_crouch_aim_4;
	level.initanimset["add_aim_right"] = %rpg_crouch_aim_6;
	level.initanimset["straight_level"] = %rpg_crouch_aim_5;
	level.initanimset["fire"] = %rpg_crouch_fire;
	level.initanimset["single"] = [%rpg_crouch_fire];
	level.initanimset["reload"] = [%rpg_crouch_reload];
	level.initanimset["exposed_idle"] = [%rpg_crouch_idle];
	set_animarray_stance_change();
	set_animarray_crouching_turns();
	set_animarray_add_turn_aims_crouch();
	level.archetypes["soldier"]["rpg_crouch"] = level.initanimset;
}

//Function Number: 22
init_animset_shotgun_crouch()
{
	anim.initanimset = [];
	set_animarray_crouch_aim();
	level.initanimset["fire"] = %exposed_crouch_shoot_auto_v2;
	level.initanimset["single"] = [%shotgun_crouch_fire];
	set_animarray_burst_and_semi_fire_crouch();
	level.initanimset["reload"] = [%shotgun_crouch_reload];
	level.initanimset["exposed_idle"] = [%exposed_crouch_idle_alert_v1,%exposed_crouch_idle_alert_v2,%exposed_crouch_idle_alert_v3];
	set_animarray_stance_change();
	set_animarray_crouching_turns();
	set_animarray_add_turn_aims_crouch();
	level.archetypes["soldier"]["shotgun_crouch"] = level.initanimset;
}

//Function Number: 23
init_animset_smg_crouch()
{
	anim.initanimset = [];
	set_animarray_crouch_aim();
	level.initanimset["fire"] = %exposed_crouch_shoot_auto_v2;
	level.initanimset["single"] = animscripts\utility::array(%exposed_crouch_shoot_semi1);
	set_animarray_burst_and_semi_fire_crouch();
	level.initanimset["reload"] = animscripts\utility::array(%exposed_crouch_reload);
	level.initanimset["exposed_idle"] = animscripts\utility::array(%exposed_crouch_idle_alert_v1,%exposed_crouch_idle_alert_v2,%exposed_crouch_idle_alert_v3);
	set_animarray_stance_change_smg();
	set_animarray_crouching_turns();
	set_animarray_add_turn_aims_crouch();
	level.archetypes["soldier"]["smg_crouch"] = level.initanimset;
}

//Function Number: 24
init_animset_default_prone()
{
	anim.initanimset = [];
	level.initanimset["add_aim_up"] = %prone_aim_8_add;
	level.initanimset["add_aim_down"] = %prone_aim_2_add;
	level.initanimset["add_aim_left"] = %prone_aim_4_add;
	level.initanimset["add_aim_right"] = %prone_aim_6_add;
	level.initanimset["straight_level"] = %prone_aim_5;
	level.initanimset["fire"] = %prone_fire_1;
	level.initanimset["single"] = [%prone_fire_1];
	level.initanimset["reload"] = [%prone_reload];
	level.initanimset["burst2"] = %prone_fire_burst;
	level.initanimset["burst3"] = %prone_fire_burst;
	level.initanimset["burst4"] = %prone_fire_burst;
	level.initanimset["burst5"] = %prone_fire_burst;
	level.initanimset["burst6"] = %prone_fire_burst;
	level.initanimset["semi2"] = %prone_fire_burst;
	level.initanimset["semi3"] = %prone_fire_burst;
	level.initanimset["semi4"] = %prone_fire_burst;
	level.initanimset["semi5"] = %prone_fire_burst;
	level.initanimset["exposed_idle"] = [%exposed_crouch_idle_alert_v1,%exposed_crouch_idle_alert_v2,%exposed_crouch_idle_alert_v3];
	set_animarray_stance_change();
	level.archetypes["soldier"]["default_prone"] = level.initanimset;
}

//Function Number: 25
init_animset_complete_custom_stand(param_00)
{
	self.combatstandanims = param_00;
}

//Function Number: 26
init_animset_custom_stand(param_00,param_01,param_02,param_03)
{
	anim.initanimset = animscripts\utility::lookupanimarray("default_stand");
	if(isdefined(param_01))
	{
		level.initanimset["straight_level"] = param_01;
	}

	if(isdefined(param_00))
	{
		level.initanimset["fire"] = param_00;
		level.initanimset["single"] = animscripts\utility::array(param_00);
		set_animarray_custom_burst_and_semi_fire_stand(param_00);
	}

	if(isdefined(param_02))
	{
		level.initanimset["exposed_idle"] = animscripts\utility::array(param_02);
	}

	if(isdefined(param_03))
	{
		level.initanimset["reload"] = animscripts\utility::array(param_03);
		level.initanimset["reload_crouchhide"] = animscripts\utility::array(param_03);
	}

	self.combatstandanims = level.initanimset;
}

//Function Number: 27
init_animset_custom_crouch(param_00,param_01,param_02)
{
	anim.initanimset = animscripts\utility::lookupanimarray("default_crouch");
	if(isdefined(param_00))
	{
		level.initanimset["fire"] = param_00;
		level.initanimset["single"] = animscripts\utility::array(param_00);
		set_animarray_custom_burst_and_semi_fire_crouch(param_00);
	}

	if(isdefined(param_01))
	{
		level.initanimset["exposed_idle"] = animscripts\utility::array(param_01);
	}

	if(isdefined(param_02))
	{
		level.initanimset["reload"] = animscripts\utility::array(param_02);
	}

	self.combatcrouchanims = level.initanimset;
}

//Function Number: 28
init_animset_complete_custom_crouch(param_00)
{
	self.combatcrouchanims = param_00;
}

//Function Number: 29
clear_custom_animset()
{
	self.custommoveanimset = undefined;
	self.customidleanimset = undefined;
	self.combatstandanims = undefined;
	self.combatcrouchanims = undefined;
}

//Function Number: 30
set_animarray_standing_turns_pistol(param_00)
{
	level.initanimset["turn_left_45"] = %pistol_stand_turn45l;
	level.initanimset["turn_left_90"] = %pistol_stand_turn90l;
	level.initanimset["turn_left_135"] = %pistol_stand_turn90l;
	level.initanimset["turn_left_180"] = %pistol_stand_turn180l;
	level.initanimset["turn_right_45"] = %pistol_stand_turn45r;
	level.initanimset["turn_right_90"] = %pistol_stand_turn90r;
	level.initanimset["turn_right_135"] = %pistol_stand_turn90r;
	level.initanimset["turn_right_180"] = %pistol_stand_turn180l;
}

//Function Number: 31
set_animarray_standing_turns()
{
	level.initanimset["turn_left_45"] = %exposed_tracking_turn45l;
	level.initanimset["turn_left_90"] = %exposed_tracking_turn90l;
	level.initanimset["turn_left_135"] = %exposed_tracking_turn135l;
	level.initanimset["turn_left_180"] = %exposed_tracking_turn180l;
	level.initanimset["turn_right_45"] = %exposed_tracking_turn45r;
	level.initanimset["turn_right_90"] = %exposed_tracking_turn90r;
	level.initanimset["turn_right_135"] = %exposed_tracking_turn135r;
	level.initanimset["turn_right_180"] = %exposed_tracking_turn180r;
}

//Function Number: 32
set_animarray_smg_standing_turns()
{
	level.initanimset["turn_left_45"] = %smg_exposed_tracking_turn45l;
	level.initanimset["turn_left_90"] = %smg_exposed_tracking_turn90l;
	level.initanimset["turn_left_135"] = %smg_exposed_tracking_turn135l;
	level.initanimset["turn_left_180"] = %smg_exposed_tracking_turn180l;
	level.initanimset["turn_right_45"] = %smg_exposed_tracking_turn45r;
	level.initanimset["turn_right_90"] = %smg_exposed_tracking_turn90r;
	level.initanimset["turn_right_135"] = %smg_exposed_tracking_turn135r;
	level.initanimset["turn_right_180"] = %smg_exposed_tracking_turn180r;
}

//Function Number: 33
set_animarray_crouching_turns()
{
	level.initanimset["turn_left_45"] = %exposed_crouch_turn_90_left;
	level.initanimset["turn_left_90"] = %exposed_crouch_turn_90_left;
	level.initanimset["turn_left_135"] = %exposed_crouch_turn_180_left;
	level.initanimset["turn_left_180"] = %exposed_crouch_turn_180_left;
	level.initanimset["turn_right_45"] = %exposed_crouch_turn_90_right;
	level.initanimset["turn_right_90"] = %exposed_crouch_turn_90_right;
	level.initanimset["turn_right_135"] = %exposed_crouch_turn_180_right;
	level.initanimset["turn_right_180"] = %exposed_crouch_turn_180_right;
}

//Function Number: 34
set_animarray_stance_change()
{
	level.initanimset["crouch_2_stand"] = %exposed_crouch_2_stand;
	level.initanimset["crouch_2_prone"] = %crouch_2_prone;
	level.initanimset["stand_2_crouch"] = %exposed_stand_2_crouch;
	level.initanimset["stand_2_prone"] = %stand_2_prone;
	level.initanimset["prone_2_crouch"] = %prone_2_crouch;
	level.initanimset["prone_2_stand"] = %prone_2_stand;
}

//Function Number: 35
set_animarray_stance_change_smg()
{
	level.initanimset["crouch_2_stand"] = %smg_exposed_crouch_2_stand;
	level.initanimset["crouch_2_prone"] = %crouch_2_prone;
	level.initanimset["stand_2_crouch"] = %smg_exposed_stand_2_crouch;
	level.initanimset["stand_2_prone"] = %stand_2_prone;
	level.initanimset["prone_2_crouch"] = %prone_2_crouch;
	level.initanimset["prone_2_stand"] = %prone_2_stand;
}

//Function Number: 36
set_animarray_burst_and_semi_fire_stand()
{
	level.initanimset["burst2"] = %exposed_shoot_burst3;
	level.initanimset["burst3"] = %exposed_shoot_burst3;
	level.initanimset["burst4"] = %exposed_shoot_burst4;
	level.initanimset["burst5"] = %exposed_shoot_burst5;
	level.initanimset["burst6"] = %exposed_shoot_burst6;
	level.initanimset["semi2"] = %exposed_shoot_semi2;
	level.initanimset["semi3"] = %exposed_shoot_semi3;
	level.initanimset["semi4"] = %exposed_shoot_semi4;
	level.initanimset["semi5"] = %exposed_shoot_semi5;
}

//Function Number: 37
set_animarray_custom_burst_and_semi_fire_stand(param_00)
{
	level.initanimset["burst2"] = param_00;
	level.initanimset["burst3"] = param_00;
	level.initanimset["burst4"] = param_00;
	level.initanimset["burst5"] = param_00;
	level.initanimset["burst6"] = param_00;
	level.initanimset["semi2"] = param_00;
	level.initanimset["semi3"] = param_00;
	level.initanimset["semi4"] = param_00;
	level.initanimset["semi5"] = param_00;
}

//Function Number: 38
set_animarray_burst_and_semi_fire_crouch()
{
	level.initanimset["burst2"] = %exposed_crouch_shoot_burst3;
	level.initanimset["burst3"] = %exposed_crouch_shoot_burst3;
	level.initanimset["burst4"] = %exposed_crouch_shoot_burst4;
	level.initanimset["burst5"] = %exposed_crouch_shoot_burst5;
	level.initanimset["burst6"] = %exposed_crouch_shoot_burst6;
	level.initanimset["semi2"] = %exposed_crouch_shoot_semi2;
	level.initanimset["semi3"] = %exposed_crouch_shoot_semi3;
	level.initanimset["semi4"] = %exposed_crouch_shoot_semi4;
	level.initanimset["semi5"] = %exposed_crouch_shoot_semi5;
}

//Function Number: 39
set_animarray_crouch_aim()
{
	level.initanimset["add_aim_up"] = %exposed_crouch_aim_8;
	level.initanimset["add_aim_down"] = %exposed_crouch_aim_2;
	level.initanimset["add_aim_left"] = %exposed_crouch_aim_4;
	level.initanimset["add_aim_right"] = %exposed_crouch_aim_6;
	level.initanimset["straight_level"] = %exposed_crouch_aim_5;
}

//Function Number: 40
set_animarray_custom_burst_and_semi_fire_crouch(param_00)
{
	level.initanimset["burst2"] = param_00;
	level.initanimset["burst3"] = param_00;
	level.initanimset["burst4"] = param_00;
	level.initanimset["burst5"] = param_00;
	level.initanimset["burst6"] = param_00;
	level.initanimset["semi2"] = param_00;
	level.initanimset["semi3"] = param_00;
	level.initanimset["semi4"] = param_00;
	level.initanimset["semi5"] = param_00;
}

//Function Number: 41
set_animarray_add_turn_aims_stand()
{
	level.initanimset["add_turn_aim_up"] = %exposed_turn_aim_8;
	level.initanimset["add_turn_aim_down"] = %exposed_turn_aim_2;
	level.initanimset["add_turn_aim_left"] = %exposed_turn_aim_4;
	level.initanimset["add_turn_aim_right"] = %exposed_turn_aim_6;
}

//Function Number: 42
set_animarray_add_smg_turn_aims_stand()
{
	level.initanimset["add_turn_aim_up"] = %smg_exposed_turn_aim_8;
	level.initanimset["add_turn_aim_down"] = %smg_exposed_turn_aim_2;
	level.initanimset["add_turn_aim_left"] = %smg_exposed_turn_aim_4;
	level.initanimset["add_turn_aim_right"] = %smg_exposed_turn_aim_6;
}

//Function Number: 43
set_animarray_add_turn_aims_crouch()
{
	level.initanimset["add_turn_aim_up"] = %exposed_crouch_turn_aim_8;
	level.initanimset["add_turn_aim_down"] = %exposed_crouch_turn_aim_2;
	level.initanimset["add_turn_aim_left"] = %exposed_crouch_turn_aim_4;
	level.initanimset["add_turn_aim_right"] = %exposed_crouch_turn_aim_6;
}

//Function Number: 44
set_animarray_standing()
{
	if(animscripts\utility::usingsidearm() || isdefined(self.alwaysusepistol))
	{
		self.a.array = animscripts\utility::lookupanimarray("pistol_stand");
		return;
	}

	if(isdefined(self.combatstandanims))
	{
		self.a.array = self.combatstandanims;
		return;
	}

	if(isdefined(self.heat))
	{
		self.a.array = animscripts\utility::lookupanimarray("heat_stand");
		return;
	}

	if(animscripts\utility::usingrocketlauncher())
	{
		self.a.array = animscripts\utility::lookupanimarray("rpg_stand");
		return;
	}

	if(animscripts\utility::usingsmg())
	{
		self.a.array = animscripts\utility::lookupanimarray("smg_stand");
		return;
	}

	if(isdefined(self.weapon) && animscripts\utility::weapon_pump_action_shotgun())
	{
		self.a.array = animscripts\utility::lookupanimarray("shotgun_stand");
		return;
	}

	if(animscripts\utility::iscqbwalking())
	{
		self.a.array = animscripts\utility::lookupanimarray("cqb_stand");
		return;
	}

	if(animscripts\utility::isunstableground())
	{
		self.a.array = animscripts\utility::lookupanimarray("unstable_stand");
		return;
	}

	self.a.array = animscripts\utility::lookupanimarray("default_stand");
}

//Function Number: 45
set_animarray_crouching()
{
	if(animscripts\utility::usingsidearm())
	{
		animscripts\shared::placeweaponon(self.primaryweapon,"right");
	}

	if(isdefined(self.combatcrouchanims))
	{
		self.a.array = self.combatcrouchanims;
		return;
	}

	if(animscripts\utility::usingrocketlauncher())
	{
		self.a.array = animscripts\utility::lookupanimarray("rpg_crouch");
		return;
	}

	if(animscripts\utility::usingsmg())
	{
		self.a.array = animscripts\utility::lookupanimarray("smg_crouch");
		return;
	}

	if(isdefined(self.weapon) && animscripts\utility::weapon_pump_action_shotgun())
	{
		self.a.array = animscripts\utility::lookupanimarray("shotgun_crouch");
		return;
	}

	self.a.array = animscripts\utility::lookupanimarray("default_crouch");
}

//Function Number: 46
set_animarray_prone()
{
	if(animscripts\utility::usingsidearm())
	{
		animscripts\shared::placeweaponon(self.primaryweapon,"right");
	}

	self.a.array = animscripts\utility::lookupanimarray("default_prone");
}

//Function Number: 47
init_moving_turn_animations()
{
	anim.initanimset = [];
	level.initanimset[0] = %run_turn_180;
	level.initanimset[1] = %run_turn_l135;
	level.initanimset[2] = %run_turn_l90;
	level.initanimset[3] = %run_turn_l45;
	level.initanimset[5] = %run_turn_r45;
	level.initanimset[6] = %run_turn_r90;
	level.initanimset[7] = %run_turn_r135;
	level.initanimset[8] = %run_turn_180;
	level.archetypes["soldier"]["run_turn"] = level.initanimset;
	anim.initanimset = [];
	level.initanimset[0] = %smg_run_turn_180;
	level.initanimset[1] = %smg_run_turn_l135;
	level.initanimset[2] = %smg_run_turn_l90;
	level.initanimset[3] = %smg_run_turn_l45;
	level.initanimset[5] = %smg_run_turn_r45;
	level.initanimset[6] = %smg_run_turn_r90;
	level.initanimset[7] = %smg_run_turn_r135;
	level.initanimset[8] = %smg_run_turn_180;
	level.archetypes["soldier"]["smg_run_turn"] = level.initanimset;
	anim.initanimset = [];
	level.initanimset[0] = %cqb_walk_turn_2;
	level.initanimset[1] = %cqb_walk_turn_1;
	level.initanimset[2] = %cqb_walk_turn_4;
	level.initanimset[3] = %cqb_walk_turn_7;
	level.initanimset[5] = %cqb_walk_turn_9;
	level.initanimset[6] = %cqb_walk_turn_6;
	level.initanimset[7] = %cqb_walk_turn_3;
	level.initanimset[8] = %cqb_walk_turn_2;
	level.archetypes["soldier"]["cqb_turn"] = level.initanimset;
	anim.initanimset = [];
	level.initanimset[0] = %cqb_run_turn_180_iw6;
	level.initanimset[1] = %cqb_run_turn_l135_iw6;
	level.initanimset[2] = %cqb_run_turn_l90_iw6;
	level.initanimset[3] = %cqb_run_turn_l45_iw6;
	level.initanimset[5] = %cqb_run_turn_r45_iw6;
	level.initanimset[6] = %cqb_run_turn_r90_iw6;
	level.initanimset[7] = %cqb_run_turn_r135_iw6;
	level.initanimset[8] = %cqb_run_turn_180_iw6;
	level.archetypes["soldier"]["cqb_run_turn"] = level.initanimset;
	anim.initanimset = [];
	level.initanimset[0] = %lag_unstable_moveforward_arrive_2;
	level.initanimset[1] = %lag_unstable_moveforward_arrive_1;
	level.initanimset[2] = %lag_unstable_moveforward_arrive_4;
	level.initanimset[3] = %lag_unstable_moveforward_arrive_7;
	level.initanimset[5] = %lag_unstable_moveforward_arrive_9;
	level.initanimset[6] = %lag_unstable_moveforward_arrive_6;
	level.initanimset[7] = %lag_unstable_moveforward_arrive_3;
	level.initanimset[8] = %lag_unstable_moveforward_arrive_2;
	level.archetypes["soldier"]["unstable_run_turn"] = level.initanimset;
}

//Function Number: 48
init_exposed_turn_animations()
{
	anim.initanimset = [];
	level.initanimset["turn_left_45"] = %exposed_tracking_turn45l;
	level.initanimset["turn_left_90"] = %exposed_tracking_turn90l;
	level.initanimset["turn_left_135"] = %exposed_tracking_turn135l;
	level.initanimset["turn_left_180"] = %exposed_tracking_turn180l;
	level.initanimset["turn_right_45"] = %exposed_tracking_turn45r;
	level.initanimset["turn_right_90"] = %exposed_tracking_turn90r;
	level.initanimset["turn_right_135"] = %exposed_tracking_turn135r;
	level.initanimset["turn_right_180"] = %exposed_tracking_turn180r;
	level.archetypes["soldier"]["exposed_turn"] = level.initanimset;
	anim.initanimset = [];
	level.initanimset["turn_left_45"] = %exposed_crouch_turn_90_left;
	level.initanimset["turn_left_90"] = %exposed_crouch_turn_90_left;
	level.initanimset["turn_left_135"] = %exposed_crouch_turn_180_left;
	level.initanimset["turn_left_180"] = %exposed_crouch_turn_180_left;
	level.initanimset["turn_right_45"] = %exposed_crouch_turn_90_right;
	level.initanimset["turn_right_90"] = %exposed_crouch_turn_90_right;
	level.initanimset["turn_right_135"] = %exposed_crouch_turn_180_right;
	level.initanimset["turn_right_180"] = %exposed_crouch_turn_180_right;
	level.archetypes["soldier"]["exposed_turn_crouch"] = level.initanimset;
}

//Function Number: 49
init_grenade_animations()
{
	anim.initanimset = [];
	level.initanimset["cower_squat"] = %exposed_squat_down_grenade_f;
	level.initanimset["cower_squat_idle"] = %exposed_squat_idle_grenade_f;
	level.initanimset["cower_dive_back"] = %exposed_dive_grenade_b;
	level.initanimset["cower_dive_front"] = %exposed_dive_grenade_f;
	level.initanimset["return_throw_short"] = [%grenade_return_running_throw_forward,%grenade_return_standing_throw_forward_1];
	level.initanimset["return_throw_long"] = [%grenade_return_running_throw_forward,%grenade_return_standing_throw_overhand_forward];
	level.initanimset["return_throw_default"] = [%grenade_return_standing_throw_overhand_forward];
	level.initanimset["return_throw_short_smg"] = [%smg_grenade_return_running_throw_forward,%smg_grenade_return_standing_throw_forward_1];
	level.initanimset["return_throw_long_smg"] = [%smg_grenade_return_running_throw_forward,%smg_grenade_return_standing_throw_overhand_forward];
	level.initanimset["return_throw_default_smg"] = [%smg_grenade_return_standing_throw_overhand_forward];
	level.archetypes["soldier"]["grenade"] = level.initanimset;
}

//Function Number: 50
init_animset_run_n_gun()
{
	anim.initanimset = [];
	level.initanimset["F"] = %run_n_gun_f;
	level.initanimset["L"] = %run_n_gun_l;
	level.initanimset["R"] = %run_n_gun_r;
	level.initanimset["LB"] = %run_n_gun_l_120;
	level.initanimset["RB"] = %run_n_gun_r_120;
	level.initanimset["move_back"] = %combatwalk_b;
	level.archetypes["soldier"]["run_n_gun"] = level.initanimset;
}

//Function Number: 51
setup_run_n_gun()
{
	self.maxrunngunangle = 130;
	self.runnguntransitionpoint = 0.4615385;
	self.runngunincrement = 0.3;
}

//Function Number: 52
init_animset_ambush()
{
	anim.initanimset = [];
	level.initanimset["move_l"] = %combatwalk_l;
	level.initanimset["move_r"] = %combatwalk_r;
	level.initanimset["move_b"] = %combatwalk_b;
	level.archetypes["soldier"]["ambush"] = level.initanimset;
}

//Function Number: 53
init_animset_smg_ambush()
{
	anim.initanimset = [];
	level.initanimset["move_l"] = %smg_combatwalk_l;
	level.initanimset["move_r"] = %smg_combatwalk_r;
	level.initanimset["move_b"] = %smg_combatwalk_b;
	level.archetypes["soldier"]["smg_ambush"] = level.initanimset;
}

//Function Number: 54
init_animset_smg_crouch_run()
{
	anim.initanimset = [];
	level.initanimset["crouch"] = %smg_crouch_fastwalk_f;
	level.initanimset["crouch_l"] = %smg_crouch_fastwalk_l;
	level.initanimset["crouch_r"] = %smg_crouch_fastwalk_r;
	level.initanimset["crouch_b"] = %smg_crouch_fastwalk_b;
	level.archetypes["soldier"]["smg_crouch_run"] = level.initanimset;
}

//Function Number: 55
set_ambush_sidestep_anims()
{
	var_00 = "ambush";
	if(animscripts\utility::usingsmg())
	{
		var_00 = "smg_ambush";
	}

	self.a.moveanimset["move_l"] = animscripts\utility::lookupanim(var_00,"move_l");
	self.a.moveanimset["move_r"] = animscripts\utility::lookupanim(var_00,"move_r");
	self.a.moveanimset["move_b"] = animscripts\utility::lookupanim(var_00,"move_b");
}

//Function Number: 56
heat_reload_anim()
{
	if(self.weapon != self.primaryweapon)
	{
		return animscripts\utility::animarraypickrandom("reload");
	}

	if(isdefined(self.node))
	{
		if(self nearclaimnodeandangle())
		{
			var_00 = undefined;
			if(self.node.type == "Cover Left")
			{
				var_00 = animscripts\utility::lookupanim("heat_reload","reload_cover_left");
			}
			else if(self.node.type == "Cover Right")
			{
				var_00 = animscripts\utility::lookupanim("heat_reload","reload_cover_right");
			}

			if(isdefined(var_00))
			{
				return var_00;
			}
		}
	}

	return animscripts\utility::lookupanim("heat_reload","reload_default");
}