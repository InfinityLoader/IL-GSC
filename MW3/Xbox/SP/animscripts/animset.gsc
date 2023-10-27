/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\animset.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 37
 * Decompile Time: 620 ms
 * Timestamp: 10/27/2023 2:29:42 AM
*******************************************************************/

//Function Number: 1
func_084F()
{
	anim.animsets = spawnstruct();
	level.animsets.move = [];
	init_animset_default_stand();
	init_animset_cqb_stand();
	init_animset_pistol_stand();
	init_animset_rpg_stand();
	init_animset_shotgun_stand();
	init_animset_heat_stand();
	init_animset_default_crouch();
	init_animset_rpg_crouch();
	init_animset_shotgun_crouch();
	init_animset_default_prone();
	init_animset_run_move();
	init_animset_walk_move();
	init_animset_cqb_move();
	init_animset_heat_run_move();
	init_moving_turn_animations();
}

//Function Number: 2
init_animset_run_move()
{
	anim.initanimset = [];
	level.initanimset["sprint"] = %sprint_loop_distant;
	level.initanimset["sprint_short"] = %sprint1_loop;
	level.initanimset["prone"] = %prone_crawl;
	level.initanimset["straight"] = %run_lowready_f;
	level.initanimset["move_f"] = %walk_forward;
	level.initanimset["move_l"] = %walk_left;
	level.initanimset["move_r"] = %walk_right;
	level.initanimset["move_b"] = %walk_backward;
	level.initanimset["crouch"] = %crouch_fastwalk_f;
	level.initanimset["crouch_l"] = %crouch_fastwalk_l;
	level.initanimset["crouch_r"] = %crouch_fastwalk_r;
	level.initanimset["crouch_b"] = %crouch_fastwalk_b;
	level.initanimset["stairs_up"] = %traverse_stair_run_01;
	level.initanimset["stairs_down"] = %traverse_stair_run_down;
	level.animsets.move["run"] = level.initanimset;
}

//Function Number: 3
init_animset_heat_run_move()
{
	anim.initanimset = level.animsets.move["run"];
	level.initanimset["straight"] = %heat_run_loop;
	level.animsets.move["heat_run"] = level.initanimset;
}

//Function Number: 4
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
	level.initanimset["stairs_up"] = %traverse_stair_run;
	level.initanimset["stairs_down"] = %traverse_stair_run_down_01;
	level.animsets.move["walk"] = level.initanimset;
}

//Function Number: 5
init_animset_cqb_move()
{
	anim.initanimset = [];
	level.initanimset["sprint"] = %sprint_loop_distant;
	level.initanimset["sprint_short"] = %sprint1_loop;
	level.initanimset["straight"] = %run_cqb_f_search_v1;
	level.initanimset["move_f"] = %walk_cqb_f;
	level.initanimset["move_l"] = %walk_left;
	level.initanimset["move_r"] = %walk_right;
	level.initanimset["move_b"] = %walk_backward;
	level.initanimset["stairs_up"] = %traverse_stair_run;
	level.initanimset["stairs_down"] = %traverse_stair_run_down_01;
	level.animsets.move["cqb"] = level.initanimset;
}

//Function Number: 6
init_animset_pistol_stand()
{
	anim.initanimset = [];
	level.initanimset["add_aim_up"] = %pistol_stand_aim_8_add;
	level.initanimset["add_aim_down"] = %pistol_stand_aim_2_add;
	level.initanimset["add_aim_left"] = %pistol_stand_aim_4_add;
	level.initanimset["add_aim_right"] = %pistol_stand_aim_6_add;
	level.initanimset["straight_level"] = %pistol_stand_aim_5;
	level.initanimset["fire"] = %pistol_stand_fire_a;
	level.initanimset["single"] = animscripts/utility::array(%pistol_stand_fire_a);
	level.initanimset["reload"] = animscripts/utility::array(%pistol_stand_reload_a);
	level.initanimset["reload_crouchhide"] = animscripts/utility::array();
	level.initanimset["exposed_idle"] = animscripts/utility::array(%exposed_idle_alert_v1,%exposed_idle_alert_v2,%exposed_idle_alert_v3);
	set_animarray_standing_turns_pistol();
	level.initanimset["add_turn_aim_up"] = %pistol_stand_aim_8_alt;
	level.initanimset["add_turn_aim_down"] = %pistol_stand_aim_2_alt;
	level.initanimset["add_turn_aim_left"] = %pistol_stand_aim_4_alt;
	level.initanimset["add_turn_aim_right"] = %pistol_stand_aim_6_alt;
	level.animsets.pistolstand = level.initanimset;
}

//Function Number: 7
init_animset_rpg_stand()
{
	anim.initanimset = [];
	level.initanimset["add_aim_up"] = %rpg_stand_aim_8;
	level.initanimset["add_aim_down"] = %rpg_stand_aim_2;
	level.initanimset["add_aim_left"] = %rpg_stand_aim_4;
	level.initanimset["add_aim_right"] = %rpg_stand_aim_6;
	level.initanimset["straight_level"] = %rpg_stand_aim_5;
	level.initanimset["fire"] = %rpg_stand_fire;
	level.initanimset["single"] = animscripts/utility::array(%exposed_shoot_semi1);
	level.initanimset["reload"] = animscripts/utility::array(%rpg_stand_reload);
	level.initanimset["reload_crouchhide"] = animscripts/utility::array();
	level.initanimset["exposed_idle"] = animscripts/utility::array(%rpg_stand_idle);
	set_animarray_stance_change();
	set_animarray_standing_turns();
	set_animarray_add_turn_aims_stand();
	level.animsets.rpgstand = level.initanimset;
}

//Function Number: 8
init_animset_shotgun_stand()
{
	anim.initanimset = [];
	level.initanimset["add_aim_up"] = %shotgun_aim_8;
	level.initanimset["add_aim_down"] = %shotgun_aim_2;
	level.initanimset["add_aim_left"] = %shotgun_aim_4;
	level.initanimset["add_aim_right"] = %shotgun_aim_6;
	level.initanimset["straight_level"] = %shotgun_aim_5;
	level.initanimset["fire"] = %exposed_shoot_auto_v3;
	level.initanimset["single"] = animscripts/utility::array(%shotgun_stand_fire_1a,%shotgun_stand_fire_1b);
	set_animarray_burst_and_semi_fire_stand();
	level.initanimset["exposed_idle"] = animscripts/utility::array(%exposed_idle_alert_v1,%exposed_idle_alert_v2,%exposed_idle_alert_v3);
	level.initanimset["reload"] = animscripts/utility::array(%shotgun_stand_reload_a,%shotgun_stand_reload_b,%shotgun_stand_reload_c,%shotgun_stand_reload_c,%shotgun_stand_reload_c);
	level.initanimset["reload_crouchhide"] = animscripts/utility::array(%shotgun_stand_reload_a,%shotgun_stand_reload_b);
	set_animarray_stance_change();
	set_animarray_standing_turns();
	set_animarray_add_turn_aims_stand();
	level.animsets.shotgunstand = level.initanimset;
}

//Function Number: 9
init_animset_cqb_stand()
{
	anim.initanimset = [];
	level.initanimset["add_aim_up"] = %cqb_stand_aim8;
	level.initanimset["add_aim_down"] = %cqb_stand_aim2;
	level.initanimset["add_aim_left"] = %cqb_stand_aim4;
	level.initanimset["add_aim_right"] = %cqb_stand_aim6;
	level.initanimset["straight_level"] = %cqb_stand_aim5;
	level.initanimset["fire"] = %exposed_shoot_auto_v3;
	level.initanimset["single"] = animscripts/utility::array(%exposed_shoot_semi1);
	set_animarray_burst_and_semi_fire_stand();
	level.initanimset["exposed_idle"] = animscripts/utility::array(%exposed_idle_alert_v1,%exposed_idle_alert_v2,%exposed_idle_alert_v3);
	level.initanimset["reload"] = animscripts/utility::array(%cqb_stand_reload_steady);
	level.initanimset["reload_crouchhide"] = animscripts/utility::array(%cqb_stand_reload_knee);
	set_animarray_stance_change();
	set_animarray_standing_turns();
	set_animarray_add_turn_aims_stand();
	level.animsets.cqbstand = level.initanimset;
}

//Function Number: 10
init_animset_heat_stand()
{
	anim.initanimset = [];
	level.initanimset["add_aim_up"] = %heat_stand_aim_8;
	level.initanimset["add_aim_down"] = %heat_stand_aim_2;
	level.initanimset["add_aim_left"] = %heat_stand_aim_4;
	level.initanimset["add_aim_right"] = %heat_stand_aim_6;
	level.initanimset["straight_level"] = %heat_stand_aim_5;
	level.initanimset["fire"] = %heat_stand_fire_auto;
	level.initanimset["single"] = animscripts/utility::array(%heat_stand_fire_single);
	set_animarray_custom_burst_and_semi_fire_stand(%heat_stand_fire_burst);
	level.initanimset["exposed_idle"] = animscripts/utility::array(%heat_stand_idle,%heat_stand_scana,%heat_stand_scanb);
	level.initanimset["reload"] = animscripts/utility::array(%heat_exposed_reload);
	level.initanimset["reload_crouchhide"] = animscripts/utility::array();
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
	level.animsets.heatstand = level.initanimset;
}

//Function Number: 11
init_animset_default_stand()
{
	anim.initanimset = [];
	level.initanimset["add_aim_up"] = %exposed_aim_8;
	level.initanimset["add_aim_down"] = %exposed_aim_2;
	level.initanimset["add_aim_left"] = %exposed_aim_4;
	level.initanimset["add_aim_right"] = %exposed_aim_6;
	level.initanimset["straight_level"] = %exposed_aim_5;
	level.initanimset["fire"] = %exposed_shoot_auto_v3;
	level.initanimset["single"] = animscripts/utility::array(%exposed_shoot_semi1);
	set_animarray_burst_and_semi_fire_stand();
	level.initanimset["exposed_idle"] = animscripts/utility::array(%exposed_idle_alert_v1,%exposed_idle_alert_v2,%exposed_idle_alert_v3);
	level.initanimset["exposed_grenade"] = animscripts/utility::array(%exposed_grenadethrowb,%exposed_grenadethrowc);
	level.initanimset["reload"] = animscripts/utility::array(%exposed_reload);
	level.initanimset["reload_crouchhide"] = animscripts/utility::array(%exposed_reloadb);
	set_animarray_stance_change();
	set_animarray_standing_turns();
	set_animarray_add_turn_aims_stand();
	level.animsets.defaultstand = level.initanimset;
}

//Function Number: 12
init_animset_default_crouch()
{
	anim.initanimset = [];
	level.initanimset["add_aim_up"] = %exposed_crouch_aim_8;
	level.initanimset["add_aim_down"] = %exposed_crouch_aim_2;
	level.initanimset["add_aim_left"] = %exposed_crouch_aim_4;
	level.initanimset["add_aim_right"] = %exposed_crouch_aim_6;
	level.initanimset["straight_level"] = %exposed_crouch_aim_5;
	level.initanimset["fire"] = %exposed_crouch_shoot_auto_v2;
	level.initanimset["single"] = animscripts/utility::array(%exposed_crouch_shoot_semi1);
	set_animarray_burst_and_semi_fire_crouch();
	level.initanimset["reload"] = animscripts/utility::array(%exposed_crouch_reload);
	level.initanimset["exposed_idle"] = animscripts/utility::array(%exposed_crouch_idle_alert_v1,%exposed_crouch_idle_alert_v2,%exposed_crouch_idle_alert_v3);
	set_animarray_stance_change();
	set_animarray_crouching_turns();
	set_animarray_add_turn_aims_crouch();
	level.animsets.defaultcrouch = level.initanimset;
}

//Function Number: 13
init_animset_rpg_crouch()
{
	anim.initanimset = [];
	level.initanimset["add_aim_up"] = %rpg_crouch_aim_8;
	level.initanimset["add_aim_down"] = %rpg_crouch_aim_2;
	level.initanimset["add_aim_left"] = %rpg_crouch_aim_4;
	level.initanimset["add_aim_right"] = %rpg_crouch_aim_6;
	level.initanimset["straight_level"] = %rpg_crouch_aim_5;
	level.initanimset["fire"] = %rpg_crouch_fire;
	level.initanimset["single"] = animscripts/utility::array(%rpg_crouch_fire);
	level.initanimset["reload"] = animscripts/utility::array(%rpg_crouch_reload);
	level.initanimset["exposed_idle"] = animscripts/utility::array(%rpg_crouch_idle);
	set_animarray_stance_change();
	set_animarray_crouching_turns();
	set_animarray_add_turn_aims_crouch();
	level.animsets.rpgcrouch = level.initanimset;
}

//Function Number: 14
init_animset_shotgun_crouch()
{
	anim.initanimset = [];
	level.initanimset["add_aim_up"] = %exposed_crouch_aim_8;
	level.initanimset["add_aim_down"] = %exposed_crouch_aim_2;
	level.initanimset["add_aim_left"] = %exposed_crouch_aim_4;
	level.initanimset["add_aim_right"] = %exposed_crouch_aim_6;
	level.initanimset["straight_level"] = %exposed_crouch_aim_5;
	level.initanimset["fire"] = %exposed_crouch_shoot_auto_v2;
	level.initanimset["single"] = animscripts/utility::array(%shotgun_crouch_fire);
	set_animarray_burst_and_semi_fire_crouch();
	level.initanimset["reload"] = animscripts/utility::array(%shotgun_crouch_reload);
	level.initanimset["exposed_idle"] = animscripts/utility::array(%exposed_crouch_idle_alert_v1,%exposed_crouch_idle_alert_v2,%exposed_crouch_idle_alert_v3);
	set_animarray_stance_change();
	set_animarray_crouching_turns();
	set_animarray_add_turn_aims_crouch();
	level.animsets.shotguncrouch = level.initanimset;
}

//Function Number: 15
init_animset_default_prone()
{
	anim.initanimset = [];
	level.initanimset["add_aim_up"] = %prone_aim_8_add;
	level.initanimset["add_aim_down"] = %prone_aim_2_add;
	level.initanimset["add_aim_left"] = %prone_aim_4_add;
	level.initanimset["add_aim_right"] = %prone_aim_6_add;
	level.initanimset["straight_level"] = %prone_aim_5;
	level.initanimset["fire"] = %prone_fire_1;
	level.initanimset["single"] = animscripts/utility::array(%prone_fire_1);
	level.initanimset["reload"] = animscripts/utility::array(%prone_reload);
	level.initanimset["burst2"] = %prone_fire_burst;
	level.initanimset["burst3"] = %prone_fire_burst;
	level.initanimset["burst4"] = %prone_fire_burst;
	level.initanimset["burst5"] = %prone_fire_burst;
	level.initanimset["burst6"] = %prone_fire_burst;
	level.initanimset["semi2"] = %prone_fire_burst;
	level.initanimset["semi3"] = %prone_fire_burst;
	level.initanimset["semi4"] = %prone_fire_burst;
	level.initanimset["semi5"] = %prone_fire_burst;
	level.initanimset["exposed_idle"] = animscripts/utility::array(%exposed_crouch_idle_alert_v1,%exposed_crouch_idle_alert_v2,%exposed_crouch_idle_alert_v3);
	set_animarray_stance_change();
	level.animsets.defaultprone = level.initanimset;
}

//Function Number: 16
init_animset_complete_custom_stand(param_00)
{
	self.combatstandanims = param_00;
}

//Function Number: 17
init_animset_custom_stand(param_00,param_01,param_02,param_03)
{
	anim.initanimset = level.animsets.defaultstand;
	if(isdefined(param_01))
	{
		level.initanimset["straight_level"] = param_01;
	}

	if(isdefined(param_00))
	{
		level.initanimset["fire"] = param_00;
		level.initanimset["single"] = animscripts/utility::array(param_00);
		set_animarray_custom_burst_and_semi_fire_stand(param_00);
	}

	if(isdefined(param_02))
	{
		level.initanimset["exposed_idle"] = animscripts/utility::array(param_02);
	}

	if(isdefined(param_03))
	{
		level.initanimset["reload"] = animscripts/utility::array(param_03);
		level.initanimset["reload_crouchhide"] = animscripts/utility::array(param_03);
	}

	self.combatstandanims = level.initanimset;
}

//Function Number: 18
func_086F(param_00)
{
	self.combatcrouchanims = param_00;
}

//Function Number: 19
func_0871(param_00,param_01,param_02)
{
	anim.initanimset = level.animsets.defaultcrouch;
	if(isdefined(param_00))
	{
		level.initanimset["fire"] = param_00;
		level.initanimset["single"] = animscripts/utility::array(param_00);
		set_animarray_custom_burst_and_semi_fire_crouch(param_00);
	}

	if(isdefined(param_01))
	{
		level.initanimset["exposed_idle"] = animscripts/utility::array(param_01);
	}

	if(isdefined(param_02))
	{
		level.initanimset["reload"] = animscripts/utility::array(param_02);
	}

	self.combatcrouchanims = level.initanimset;
}

//Function Number: 20
clear_custom_animset()
{
	self.custommoveanimset = undefined;
	self.customidleanimset = undefined;
	self.combatstandanims = undefined;
	self.combatcrouchanims = undefined;
}

//Function Number: 21
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

//Function Number: 22
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

//Function Number: 23
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

//Function Number: 24
set_animarray_stance_change()
{
	level.initanimset["crouch_2_stand"] = %exposed_crouch_2_stand;
	level.initanimset["crouch_2_prone"] = %crouch_2_prone;
	level.initanimset["stand_2_crouch"] = %exposed_stand_2_crouch;
	level.initanimset["stand_2_prone"] = %stand_2_prone;
	level.initanimset["prone_2_crouch"] = %prone_2_crouch;
	level.initanimset["prone_2_stand"] = %prone_2_stand;
}

//Function Number: 25
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

//Function Number: 26
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

//Function Number: 27
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

//Function Number: 28
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

//Function Number: 29
set_animarray_add_turn_aims_stand()
{
	level.initanimset["add_turn_aim_up"] = %exposed_turn_aim_8;
	level.initanimset["add_turn_aim_down"] = %exposed_turn_aim_2;
	level.initanimset["add_turn_aim_left"] = %exposed_turn_aim_4;
	level.initanimset["add_turn_aim_right"] = %exposed_turn_aim_6;
}

//Function Number: 30
set_animarray_add_turn_aims_crouch()
{
	level.initanimset["add_turn_aim_up"] = %exposed_crouch_turn_aim_8;
	level.initanimset["add_turn_aim_down"] = %exposed_crouch_turn_aim_2;
	level.initanimset["add_turn_aim_left"] = %exposed_crouch_turn_aim_4;
	level.initanimset["add_turn_aim_right"] = %exposed_crouch_turn_aim_6;
}

//Function Number: 31
set_animarray_standing()
{
	if(animscripts/utility::usingsidearm())
	{
		self.a.array = level.animsets.pistolstand;
		return;
	}

	if(isdefined(self.combatstandanims))
	{
		self.a.array = self.combatstandanims;
		return;
	}

	if(isdefined(self.heat))
	{
		self.a.array = level.animsets.heatstand;
		return;
	}

	if(animscripts/utility::usingrocketlauncher())
	{
		self.a.array = level.animsets.rpgstand;
		return;
	}

	if(isdefined(self.weapon) && animscripts/utility::weapon_pump_action_shotgun())
	{
		self.a.array = level.animsets.shotgunstand;
		return;
	}

	if(animscripts/utility::iscqbwalking())
	{
		self.a.array = level.animsets.cqbstand;
		return;
	}

	self.a.array = level.animsets.defaultstand;
}

//Function Number: 32
set_animarray_crouching()
{
	if(animscripts/utility::usingsidearm())
	{
		animscripts/shared::placeweaponon(self.primaryweapon,"right");
	}

	if(isdefined(self.combatcrouchanims))
	{
		self.a.array = self.combatcrouchanims;
		return;
	}

	if(animscripts/utility::usingrocketlauncher())
	{
		self.a.array = level.animsets.rpgcrouch;
		return;
	}

	if(isdefined(self.weapon) && animscripts/utility::weapon_pump_action_shotgun())
	{
		self.a.array = level.animsets.shotguncrouch;
		return;
	}

	self.a.array = level.animsets.defaultcrouch;
}

//Function Number: 33
set_animarray_prone()
{
	if(animscripts/utility::usingsidearm())
	{
		animscripts/shared::placeweaponon(self.primaryweapon,"right");
	}

	self.a.array = level.animsets.defaultprone;
}

//Function Number: 34
init_moving_turn_animations()
{
	level.runturnanims["L90"] = %run_turn_l90;
	level.runturnanims["R90"] = %run_turn_r90;
	level.runturnanims["L45"] = %run_turn_l45;
	level.runturnanims["R45"] = %run_turn_r45;
	level.runturnanims["L135"] = %run_turn_l135;
	level.runturnanims["R135"] = %run_turn_r135;
	level.runturnanims["180"] = %run_turn_180;
	level.cqbturnanims["L90"] = %cqb_walk_turn_4;
	level.cqbturnanims["R90"] = %cqb_walk_turn_6;
	level.cqbturnanims["L45"] = %cqb_walk_turn_7;
	level.cqbturnanims["R45"] = %cqb_walk_turn_9;
	level.cqbturnanims["L135"] = %cqb_walk_turn_1;
	level.cqbturnanims["R135"] = %cqb_walk_turn_3;
	level.cqbturnanims["180"] = %cqb_walk_turn_2;
}

//Function Number: 35
func_088B()
{
	self.maxrunngunangle = 130;
	self.runnguntransitionpoint = 0.4615385;
	self.runngunincrement = 0.3;
	self.runngunanims["F"] = %run_n_gun_f;
	self.runngunanims["L"] = %run_n_gun_l;
	self.runngunanims["R"] = %run_n_gun_r;
	self.runngunanims["LB"] = %run_n_gun_l_120;
	self.runngunanims["RB"] = %run_n_gun_r_120;
}

//Function Number: 36
set_ambush_sidestep_anims()
{
	self.a.moveanimset["move_l"] = %combatwalk_l;
	self.a.moveanimset["move_r"] = %combatwalk_r;
	self.a.moveanimset["move_b"] = %combatwalk_b;
}

//Function Number: 37
heat_reload_anim()
{
	if(self.weapon != self.primaryweapon)
	{
		return animscripts/utility::animarraypickrandom("reload");
	}

	if(isdefined(self.node))
	{
		if(self nearclaimnodeandangle())
		{
			var_00 = undefined;
			if(self.node.type == "Cover Left")
			{
				var_00 = %heat_cover_reload_r;
			}
			else if(self.node.type == "Cover Right")
			{
				var_00 = %heat_cover_reload_l;
			}

			if(isdefined(var_00))
			{
				return var_00;
			}
		}
	}

	return %heat_exposed_reload;
}