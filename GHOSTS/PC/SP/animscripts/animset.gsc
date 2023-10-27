/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\animset.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 44
 * Decompile Time: 778 ms
 * Timestamp: 10/27/2023 1:23:13 AM
*******************************************************************/

//Function Number: 1
func_44EB()
{
	if(isdefined(level.archetypes))
	{
		return;
	}

	anim.archetypes = [];
	level.archetypes["soldier"] = [];
	animscripts/cover_left::func_44F7();
	animscripts/cover_right::init_animset_cover_right();
	animscripts/cover_prone::func_44F9();
	animscripts/cover_multi::init_animset_cover_multi();
	animscripts/cover_wall::init_animset_cover_wall();
	animscripts/reactions::init_animset_reactions();
	animscripts/pain::init_animset_pain();
	animscripts/death::init_animset_death();
	animscripts/combat::init_animset_combat();
	animscripts/move::func_450A();
	animscripts/flashed::init_animset_flashed();
	animscripts/stop::init_animset_idle();
	animscripts/melee::func_4509();
	anim.animsets = spawnstruct();
	level.animsets.var_5428 = [];
	func_4503();
	init_animset_cqb_stand();
	func_450C();
	func_450F();
	init_animset_shotgun_stand();
	init_animset_heat_stand();
	init_animset_default_crouch();
	init_animset_rpg_crouch();
	func_4512();
	func_4502();
	func_4510();
	func_4514();
	init_animset_cqb_move();
	func_4506();
	func_4572();
	func_4546();
	func_4505();
	func_4550();
	func_4511();
	init_animset_ambush();
}

//Function Number: 2
func_6466(param_00,param_01,param_02)
{
	func_44EB();
	level.archetypes[param_00] = param_01;
	if(isdefined(param_01["flashed"]))
	{
		level.flashanimindex[param_00] = 0;
	}

	if(isdefined(param_02) && param_02)
	{
		animscripts/init_move_transitions::getsplittimes(param_00);
	}
}

//Function Number: 3
archetypeexists(param_00)
{
	return isdefined(level.archetypes[param_00]);
}

//Function Number: 4
func_4510()
{
	anim.var_45DF = [];
	level.var_45DF["sprint"] = %sprint_loop_distant;
	level.var_45DF["sprint_short"] = %sprint1_loop;
	level.var_45DF["prone"] = %prone_crawl;
	level.var_45DF["straight"] = %run_lowready_f;
	level.var_45DF["straight_twitch"] = [%run_twitch_guncheck,%run_twitch_aim_straight,%run_twitch_aim_above,%run_twitch_lookbehind_a,%run_twitch_lookbehind_b];
	level.var_45DF["move_f"] = %walk_forward;
	level.var_45DF["move_l"] = %walk_left;
	level.var_45DF["move_r"] = %walk_right;
	level.var_45DF["move_b"] = %walk_backward;
	level.var_45DF["crouch"] = %crouch_fastwalk_f;
	level.var_45DF["crouch_l"] = %crouch_fastwalk_l;
	level.var_45DF["crouch_r"] = %crouch_fastwalk_r;
	level.var_45DF["crouch_b"] = %crouch_fastwalk_b;
	level.var_45DF["stairs_up"] = %run_stairs_up;
	level.var_45DF["stairs_up_in"] = %run_stairs_up_in;
	level.var_45DF["stairs_up_out"] = %run_stairs_up_out;
	level.var_45DF["stairs_down"] = %traverse_stair_run_down;
	level.var_45DF["reload"] = [%run_reload_a,%run_reload_b];
	level.archetypes["soldier"]["run"] = level.var_45DF;
}

//Function Number: 5
func_4506()
{
	anim.var_45DF = level.archetypes["soldier"]["run"];
	level.var_45DF["straight"] = %heat_run_loop;
	level.archetypes["soldier"]["heat_run"] = level.var_45DF;
}

//Function Number: 6
func_4514()
{
	anim.var_45DF = [];
	level.var_45DF["sprint"] = %sprint_loop_distant;
	level.var_45DF["sprint_short"] = %sprint1_loop;
	level.var_45DF["prone"] = %prone_crawl;
	level.var_45DF["straight"] = %cqb_walk_iw6;
	level.var_45DF["move_f"] = %cqb_walk_iw6;
	level.var_45DF["move_l"] = %walk_left;
	level.var_45DF["move_r"] = %walk_right;
	level.var_45DF["move_b"] = %walk_backward;
	level.var_45DF["crouch"] = %crouch_fastwalk_f;
	level.var_45DF["crouch_l"] = %crouch_fastwalk_l;
	level.var_45DF["crouch_r"] = %crouch_fastwalk_r;
	level.var_45DF["crouch_b"] = %crouch_fastwalk_b;
	level.var_45DF["aim_2"] = %walk_aim_2;
	level.var_45DF["aim_4"] = %walk_aim_4;
	level.var_45DF["aim_6"] = %walk_aim_6;
	level.var_45DF["aim_8"] = %walk_aim_8;
	level.var_45DF["stairs_up"] = %traverse_stair_run;
	level.var_45DF["stairs_down"] = %traverse_stair_run_down_01;
	level.archetypes["soldier"]["walk"] = level.var_45DF;
}

//Function Number: 7
init_animset_cqb_move()
{
	anim.var_45DF = [];
	level.var_45DF["sprint"] = %sprint_loop_distant;
	level.var_45DF["sprint_short"] = %sprint1_loop;
	level.var_45DF["straight"] = %run_cqb_f_search_v1;
	level.var_45DF["straight_twitch"] = [%cqb_run_twitch_a_iw6,%cqb_run_twitch_b_iw6,%cqb_run_twitch_c_iw6,%cqb_run_twitch_d_iw6];
	level.var_45DF["move_f"] = %cqb_walk_iw6;
	level.var_45DF["move_l"] = %walk_left;
	level.var_45DF["move_r"] = %walk_right;
	level.var_45DF["move_b"] = %walk_backward;
	level.var_45DF["aim_2"] = %cqb_run_aim_2;
	level.var_45DF["aim_4"] = %cqb_run_aim_4;
	level.var_45DF["aim_5"] = %cqb_run_aim_5;
	level.var_45DF["aim_6"] = %cqb_run_aim_6;
	level.var_45DF["aim_8"] = %cqb_run_aim_8;
	level.var_45DF["stairs_up"] = %traverse_stair_run;
	level.var_45DF["stairs_down_in"] = %cqb_stairs_down_in_m;
	level.var_45DF["stairs_down"] = %cqb_stairs_down;
	level.var_45DF["stairs_down_out"] = %cqb_stairs_down_out_m;
	level.var_45DF["shotgun_pullout"] = %shotgun_cqbrun_pullout;
	level.var_45DF["shotgun_putaway"] = %shotgun_cqbrun_putaway;
	level.var_45DF["reload"] = [%cqb_run_reload_a_iw6,%cqb_run_reload_b_iw6];
	level.archetypes["soldier"]["cqb"] = level.var_45DF;
}

//Function Number: 8
func_450C()
{
	anim.var_45DF = [];
	level.var_45DF["add_aim_up"] = %pistol_stand_aim_8_add;
	level.var_45DF["add_aim_down"] = %pistol_stand_aim_2_add;
	level.var_45DF["add_aim_left"] = %pistol_stand_aim_4_add;
	level.var_45DF["add_aim_right"] = %pistol_stand_aim_6_add;
	level.var_45DF["straight_level"] = %pistol_stand_aim_5;
	level.var_45DF["fire"] = %pistol_stand_fire_a;
	level.var_45DF["single"] = animscripts/utility::func_ED8(%pistol_stand_fire_a);
	level.var_45DF["reload"] = animscripts/utility::func_ED8(%pistol_stand_reload_a);
	level.var_45DF["reload_crouchhide"] = [];
	level.var_45DF["exposed_idle"] = [%exposed_idle_alert_v1,%exposed_idle_alert_v2,%exposed_idle_alert_v3];
	func_6E45();
	level.var_45DF["add_turn_aim_up"] = %pistol_stand_aim_8_alt;
	level.var_45DF["add_turn_aim_down"] = %pistol_stand_aim_2_alt;
	level.var_45DF["add_turn_aim_left"] = %pistol_stand_aim_4_alt;
	level.var_45DF["add_turn_aim_right"] = %pistol_stand_aim_6_alt;
	level.archetypes["soldier"]["pistol_stand"] = level.var_45DF;
}

//Function Number: 9
func_450F()
{
	anim.var_45DF = [];
	level.var_45DF["add_aim_up"] = %rpg_stand_aim_8;
	level.var_45DF["add_aim_down"] = %rpg_stand_aim_2;
	level.var_45DF["add_aim_left"] = %rpg_stand_aim_4;
	level.var_45DF["add_aim_right"] = %rpg_stand_aim_6;
	level.var_45DF["straight_level"] = %rpg_stand_aim_5;
	level.var_45DF["fire"] = %rpg_stand_fire;
	level.var_45DF["single"] = [%exposed_shoot_semi1];
	level.var_45DF["reload"] = [%rpg_stand_reload];
	level.var_45DF["reload_crouchhide"] = [];
	level.var_45DF["exposed_idle"] = [%rpg_stand_idle];
	func_6E40();
	func_6E44();
	func_6E36();
	level.archetypes["soldier"]["rpg_stand"] = level.var_45DF;
}

//Function Number: 10
init_animset_shotgun_stand()
{
	anim.var_45DF = [];
	level.var_45DF["add_aim_up"] = %shotgun_aim_8;
	level.var_45DF["add_aim_down"] = %shotgun_aim_2;
	level.var_45DF["add_aim_left"] = %shotgun_aim_4;
	level.var_45DF["add_aim_right"] = %shotgun_aim_6;
	level.var_45DF["straight_level"] = %shotgun_aim_5;
	level.var_45DF["fire"] = %exposed_shoot_auto_v3;
	level.var_45DF["single"] = [%shotgun_stand_fire_1a,%shotgun_stand_fire_1b];
	func_6E38();
	level.var_45DF["exposed_idle"] = [%exposed_idle_alert_v1,%exposed_idle_alert_v2,%exposed_idle_alert_v3];
	level.var_45DF["reload"] = [%shotgun_stand_reload_a,%shotgun_stand_reload_b,%shotgun_stand_reload_c,%shotgun_stand_reload_c,%shotgun_stand_reload_c];
	level.var_45DF["reload_crouchhide"] = [%shotgun_stand_reload_a,%shotgun_stand_reload_b];
	func_6E40();
	func_6E44();
	func_6E36();
	level.archetypes["soldier"]["shotgun_stand"] = level.var_45DF;
}

//Function Number: 11
init_animset_cqb_stand()
{
	anim.var_45DF = [];
	level.var_45DF["add_aim_up"] = %cqb_stand_aim8;
	level.var_45DF["add_aim_down"] = %cqb_stand_aim2;
	level.var_45DF["add_aim_left"] = %cqb_stand_aim4;
	level.var_45DF["add_aim_right"] = %cqb_stand_aim6;
	level.var_45DF["straight_level"] = %cqb_stand_aim5;
	level.var_45DF["fire"] = %exposed_shoot_auto_v3;
	level.var_45DF["single"] = [%exposed_shoot_semi1];
	func_6E38();
	level.var_45DF["exposed_idle"] = [%exposed_idle_alert_v1,%exposed_idle_alert_v2,%exposed_idle_alert_v3];
	level.var_45DF["reload"] = [%cqb_stand_reload_steady];
	level.var_45DF["reload_crouchhide"] = [%cqb_stand_reload_knee];
	func_6E40();
	func_6E44();
	func_6E36();
	level.archetypes["soldier"]["cqb_stand"] = level.var_45DF;
}

//Function Number: 12
init_animset_heat_stand()
{
	anim.var_45DF = [];
	level.var_45DF["add_aim_up"] = %heat_stand_aim_8;
	level.var_45DF["add_aim_down"] = %heat_stand_aim_2;
	level.var_45DF["add_aim_left"] = %heat_stand_aim_4;
	level.var_45DF["add_aim_right"] = %heat_stand_aim_6;
	level.var_45DF["straight_level"] = %heat_stand_aim_5;
	level.var_45DF["fire"] = %heat_stand_fire_auto;
	level.var_45DF["single"] = animscripts/utility::func_ED8(%heat_stand_fire_single);
	func_6E3E(%heat_stand_fire_burst);
	level.var_45DF["exposed_idle"] = animscripts/utility::func_ED8(%heat_stand_idle,%heat_stand_scana,%heat_stand_scanb);
	level.var_45DF["reload"] = animscripts/utility::func_ED8(%heat_exposed_reload);
	level.var_45DF["reload_crouchhide"] = animscripts/utility::func_ED8();
	func_6E40();
	level.var_45DF["turn_left_45"] = %heat_stand_turn_l;
	level.var_45DF["turn_left_90"] = %heat_stand_turn_l;
	level.var_45DF["turn_left_135"] = %heat_stand_turn_180;
	level.var_45DF["turn_left_180"] = %heat_stand_turn_180;
	level.var_45DF["turn_right_45"] = %heat_stand_turn_r;
	level.var_45DF["turn_right_90"] = %heat_stand_turn_r;
	level.var_45DF["turn_right_135"] = %heat_stand_turn_180;
	level.var_45DF["turn_right_180"] = %heat_stand_turn_180;
	func_6E36();
	level.archetypes["soldier"]["heat_stand"] = level.var_45DF;
}

//Function Number: 13
func_4505()
{
	anim.var_45DF = [];
	level.var_45DF["reload_cover_left"] = %heat_cover_reload_r;
	level.var_45DF["reload_cover_right"] = %heat_cover_reload_l;
	level.var_45DF["reload_default"] = %heat_cover_reload_l;
	level.archetypes["soldier"]["heat_reload"] = level.var_45DF;
}

//Function Number: 14
func_4503()
{
	anim.var_45DF = [];
	level.var_45DF["add_aim_up"] = %exposed_aim_8;
	level.var_45DF["add_aim_down"] = %exposed_aim_2;
	level.var_45DF["add_aim_left"] = %exposed_aim_4;
	level.var_45DF["add_aim_right"] = %exposed_aim_6;
	level.var_45DF["straight_level"] = %exposed_aim_5;
	level.var_45DF["fire"] = %exposed_shoot_auto_v3;
	level.var_45DF["fire_corner"] = %exposed_shoot_auto_v2;
	level.var_45DF["single"] = animscripts/utility::func_ED8(%exposed_shoot_semi1);
	func_6E38();
	level.var_45DF["exposed_idle"] = animscripts/utility::func_ED8(%exposed_idle_alert_v1,%exposed_idle_alert_v2,%exposed_idle_alert_v3);
	level.var_45DF["exposed_grenade"] = animscripts/utility::func_ED8(%exposed_grenadethrowb,%exposed_grenadethrowc);
	level.var_45DF["reload"] = animscripts/utility::func_ED8(%exposed_reload);
	level.var_45DF["reload_crouchhide"] = animscripts/utility::func_ED8(%exposed_reloadb);
	func_6E40();
	func_6E44();
	func_6E36();
	level.archetypes["soldier"]["default_stand"] = level.var_45DF;
}

//Function Number: 15
init_animset_default_crouch()
{
	anim.var_45DF = [];
	level.var_45DF["add_aim_up"] = %exposed_crouch_aim_8;
	level.var_45DF["add_aim_down"] = %exposed_crouch_aim_2;
	level.var_45DF["add_aim_left"] = %exposed_crouch_aim_4;
	level.var_45DF["add_aim_right"] = %exposed_crouch_aim_6;
	level.var_45DF["straight_level"] = %exposed_crouch_aim_5;
	level.var_45DF["fire"] = %exposed_crouch_shoot_auto_v2;
	level.var_45DF["single"] = animscripts/utility::func_ED8(%exposed_crouch_shoot_semi1);
	set_animarray_burst_and_semi_fire_crouch();
	level.var_45DF["reload"] = animscripts/utility::func_ED8(%exposed_crouch_reload);
	level.var_45DF["exposed_idle"] = animscripts/utility::func_ED8(%exposed_crouch_idle_alert_v1,%exposed_crouch_idle_alert_v2,%exposed_crouch_idle_alert_v3);
	func_6E40();
	func_6E3C();
	func_6E35();
	level.archetypes["soldier"]["default_crouch"] = level.var_45DF;
}

//Function Number: 16
init_animset_rpg_crouch()
{
	anim.var_45DF = [];
	level.var_45DF["add_aim_up"] = %rpg_crouch_aim_8;
	level.var_45DF["add_aim_down"] = %rpg_crouch_aim_2;
	level.var_45DF["add_aim_left"] = %rpg_crouch_aim_4;
	level.var_45DF["add_aim_right"] = %rpg_crouch_aim_6;
	level.var_45DF["straight_level"] = %rpg_crouch_aim_5;
	level.var_45DF["fire"] = %rpg_crouch_fire;
	level.var_45DF["single"] = [%rpg_crouch_fire];
	level.var_45DF["reload"] = [%rpg_crouch_reload];
	level.var_45DF["exposed_idle"] = [%rpg_crouch_idle];
	func_6E40();
	func_6E3C();
	func_6E35();
	level.archetypes["soldier"]["rpg_crouch"] = level.var_45DF;
}

//Function Number: 17
func_4512()
{
	anim.var_45DF = [];
	level.var_45DF["add_aim_up"] = %exposed_crouch_aim_8;
	level.var_45DF["add_aim_down"] = %exposed_crouch_aim_2;
	level.var_45DF["add_aim_left"] = %exposed_crouch_aim_4;
	level.var_45DF["add_aim_right"] = %exposed_crouch_aim_6;
	level.var_45DF["straight_level"] = %exposed_crouch_aim_5;
	level.var_45DF["fire"] = %exposed_crouch_shoot_auto_v2;
	level.var_45DF["single"] = [%shotgun_crouch_fire];
	set_animarray_burst_and_semi_fire_crouch();
	level.var_45DF["reload"] = [%shotgun_crouch_reload];
	level.var_45DF["exposed_idle"] = [%exposed_crouch_idle_alert_v1,%exposed_crouch_idle_alert_v2,%exposed_crouch_idle_alert_v3];
	func_6E40();
	func_6E3C();
	func_6E35();
	level.archetypes["soldier"]["shotgun_crouch"] = level.var_45DF;
}

//Function Number: 18
func_4502()
{
	anim.var_45DF = [];
	level.var_45DF["add_aim_up"] = %prone_aim_8_add;
	level.var_45DF["add_aim_down"] = %prone_aim_2_add;
	level.var_45DF["add_aim_left"] = %prone_aim_4_add;
	level.var_45DF["add_aim_right"] = %prone_aim_6_add;
	level.var_45DF["straight_level"] = %prone_aim_5;
	level.var_45DF["fire"] = %prone_fire_1;
	level.var_45DF["single"] = [%prone_fire_1];
	level.var_45DF["reload"] = [%prone_reload];
	level.var_45DF["burst2"] = %prone_fire_burst;
	level.var_45DF["burst3"] = %prone_fire_burst;
	level.var_45DF["burst4"] = %prone_fire_burst;
	level.var_45DF["burst5"] = %prone_fire_burst;
	level.var_45DF["burst6"] = %prone_fire_burst;
	level.var_45DF["semi2"] = %prone_fire_burst;
	level.var_45DF["semi3"] = %prone_fire_burst;
	level.var_45DF["semi4"] = %prone_fire_burst;
	level.var_45DF["semi5"] = %prone_fire_burst;
	level.var_45DF["exposed_idle"] = [%exposed_crouch_idle_alert_v1,%exposed_crouch_idle_alert_v2,%exposed_crouch_idle_alert_v3];
	func_6E40();
	level.archetypes["soldier"]["default_prone"] = level.var_45DF;
}

//Function Number: 19
func_44F6(param_00)
{
	self.var_1E61 = param_00;
}

//Function Number: 20
init_animset_custom_stand(param_00,param_01,param_02,param_03)
{
	anim.var_45DF = animscripts/utility::func_4F5D("default_stand");
	if(isdefined(param_01))
	{
		level.var_45DF["straight_level"] = param_01;
	}

	if(isdefined(param_00))
	{
		level.var_45DF["fire"] = param_00;
		level.var_45DF["single"] = animscripts/utility::func_ED8(param_00);
		func_6E3E(param_00);
	}

	if(isdefined(param_02))
	{
		level.var_45DF["exposed_idle"] = animscripts/utility::func_ED8(param_02);
	}

	if(isdefined(param_03))
	{
		level.var_45DF["reload"] = animscripts/utility::func_ED8(param_03);
		level.var_45DF["reload_crouchhide"] = animscripts/utility::func_ED8(param_03);
	}

	self.var_1E61 = level.var_45DF;
}

//Function Number: 21
func_44F5(param_00)
{
	self.var_1E55 = param_00;
}

//Function Number: 22
func_44FE(param_00,param_01,param_02)
{
	anim.var_45DF = animscripts/utility::func_4F5D("default_crouch");
	if(isdefined(param_00))
	{
		level.var_45DF["fire"] = param_00;
		level.var_45DF["single"] = animscripts/utility::func_ED8(param_00);
		func_6E3D(param_00);
	}

	if(isdefined(param_01))
	{
		level.var_45DF["exposed_idle"] = animscripts/utility::func_ED8(param_01);
	}

	if(isdefined(param_02))
	{
		level.var_45DF["reload"] = animscripts/utility::func_ED8(param_02);
	}

	self.var_1E55 = level.var_45DF;
}

//Function Number: 23
func_1D04()
{
	self.custommoveanimset = undefined;
	self.customidleanimset = undefined;
	self.var_1E61 = undefined;
	self.var_1E55 = undefined;
}

//Function Number: 24
func_6E45(param_00)
{
	level.var_45DF["turn_left_45"] = %pistol_stand_turn45l;
	level.var_45DF["turn_left_90"] = %pistol_stand_turn90l;
	level.var_45DF["turn_left_135"] = %pistol_stand_turn90l;
	level.var_45DF["turn_left_180"] = %pistol_stand_turn180l;
	level.var_45DF["turn_right_45"] = %pistol_stand_turn45r;
	level.var_45DF["turn_right_90"] = %pistol_stand_turn90r;
	level.var_45DF["turn_right_135"] = %pistol_stand_turn90r;
	level.var_45DF["turn_right_180"] = %pistol_stand_turn180l;
}

//Function Number: 25
func_6E44()
{
	level.var_45DF["turn_left_45"] = %exposed_tracking_turn45l;
	level.var_45DF["turn_left_90"] = %exposed_tracking_turn90l;
	level.var_45DF["turn_left_135"] = %exposed_tracking_turn135l;
	level.var_45DF["turn_left_180"] = %exposed_tracking_turn180l;
	level.var_45DF["turn_right_45"] = %exposed_tracking_turn45r;
	level.var_45DF["turn_right_90"] = %exposed_tracking_turn90r;
	level.var_45DF["turn_right_135"] = %exposed_tracking_turn135r;
	level.var_45DF["turn_right_180"] = %exposed_tracking_turn180r;
}

//Function Number: 26
func_6E3C()
{
	level.var_45DF["turn_left_45"] = %exposed_crouch_turn_90_left;
	level.var_45DF["turn_left_90"] = %exposed_crouch_turn_90_left;
	level.var_45DF["turn_left_135"] = %exposed_crouch_turn_180_left;
	level.var_45DF["turn_left_180"] = %exposed_crouch_turn_180_left;
	level.var_45DF["turn_right_45"] = %exposed_crouch_turn_90_right;
	level.var_45DF["turn_right_90"] = %exposed_crouch_turn_90_right;
	level.var_45DF["turn_right_135"] = %exposed_crouch_turn_180_right;
	level.var_45DF["turn_right_180"] = %exposed_crouch_turn_180_right;
}

//Function Number: 27
func_6E40()
{
	level.var_45DF["crouch_2_stand"] = %exposed_crouch_2_stand;
	level.var_45DF["crouch_2_prone"] = %crouch_2_prone;
	level.var_45DF["stand_2_crouch"] = %exposed_stand_2_crouch;
	level.var_45DF["stand_2_prone"] = %stand_2_prone;
	level.var_45DF["prone_2_crouch"] = %prone_2_crouch;
	level.var_45DF["prone_2_stand"] = %prone_2_stand;
}

//Function Number: 28
func_6E38()
{
	level.var_45DF["burst2"] = %exposed_shoot_burst3;
	level.var_45DF["burst3"] = %exposed_shoot_burst3;
	level.var_45DF["burst4"] = %exposed_shoot_burst4;
	level.var_45DF["burst5"] = %exposed_shoot_burst5;
	level.var_45DF["burst6"] = %exposed_shoot_burst6;
	level.var_45DF["semi2"] = %exposed_shoot_semi2;
	level.var_45DF["semi3"] = %exposed_shoot_semi3;
	level.var_45DF["semi4"] = %exposed_shoot_semi4;
	level.var_45DF["semi5"] = %exposed_shoot_semi5;
}

//Function Number: 29
func_6E3E(param_00)
{
	level.var_45DF["burst2"] = param_00;
	level.var_45DF["burst3"] = param_00;
	level.var_45DF["burst4"] = param_00;
	level.var_45DF["burst5"] = param_00;
	level.var_45DF["burst6"] = param_00;
	level.var_45DF["semi2"] = param_00;
	level.var_45DF["semi3"] = param_00;
	level.var_45DF["semi4"] = param_00;
	level.var_45DF["semi5"] = param_00;
}

//Function Number: 30
set_animarray_burst_and_semi_fire_crouch()
{
	level.var_45DF["burst2"] = %exposed_crouch_shoot_burst3;
	level.var_45DF["burst3"] = %exposed_crouch_shoot_burst3;
	level.var_45DF["burst4"] = %exposed_crouch_shoot_burst4;
	level.var_45DF["burst5"] = %exposed_crouch_shoot_burst5;
	level.var_45DF["burst6"] = %exposed_crouch_shoot_burst6;
	level.var_45DF["semi2"] = %exposed_crouch_shoot_semi2;
	level.var_45DF["semi3"] = %exposed_crouch_shoot_semi3;
	level.var_45DF["semi4"] = %exposed_crouch_shoot_semi4;
	level.var_45DF["semi5"] = %exposed_crouch_shoot_semi5;
}

//Function Number: 31
func_6E3D(param_00)
{
	level.var_45DF["burst2"] = param_00;
	level.var_45DF["burst3"] = param_00;
	level.var_45DF["burst4"] = param_00;
	level.var_45DF["burst5"] = param_00;
	level.var_45DF["burst6"] = param_00;
	level.var_45DF["semi2"] = param_00;
	level.var_45DF["semi3"] = param_00;
	level.var_45DF["semi4"] = param_00;
	level.var_45DF["semi5"] = param_00;
}

//Function Number: 32
func_6E36()
{
	level.var_45DF["add_turn_aim_up"] = %exposed_turn_aim_8;
	level.var_45DF["add_turn_aim_down"] = %exposed_turn_aim_2;
	level.var_45DF["add_turn_aim_left"] = %exposed_turn_aim_4;
	level.var_45DF["add_turn_aim_right"] = %exposed_turn_aim_6;
}

//Function Number: 33
func_6E35()
{
	level.var_45DF["add_turn_aim_up"] = %exposed_crouch_turn_aim_8;
	level.var_45DF["add_turn_aim_down"] = %exposed_crouch_turn_aim_2;
	level.var_45DF["add_turn_aim_left"] = %exposed_crouch_turn_aim_4;
	level.var_45DF["add_turn_aim_right"] = %exposed_crouch_turn_aim_6;
}

//Function Number: 34
func_6E41()
{
	if(animscripts/utility::func_87FE())
	{
		self.a.var_ED8 = animscripts/utility::func_4F5D("pistol_stand");
	}

	if(isdefined(self.var_1E61))
	{
		self.a.var_ED8 = self.var_1E61;
	}

	if(isdefined(self.heat))
	{
		self.a.var_ED8 = animscripts/utility::func_4F5D("heat_stand");
	}

	if(animscripts/utility::func_87FA())
	{
		self.a.var_ED8 = animscripts/utility::func_4F5D("rpg_stand");
	}

	if(isdefined(self.weapon) && animscripts/utility::func_8D9B())
	{
		self.a.var_ED8 = animscripts/utility::func_4F5D("shotgun_stand");
	}

	if(animscripts/utility::func_48A0())
	{
		self.a.var_ED8 = animscripts/utility::func_4F5D("cqb_stand");
	}

	self.a.var_ED8 = animscripts/utility::func_4F5D("default_stand");
}

//Function Number: 35
set_animarray_crouching()
{
	if(animscripts/utility::func_87FE())
	{
		animscripts/shared::placeweaponon(self.primaryweapon,"right");
	}

	if(isdefined(self.var_1E55))
	{
		self.a.var_ED8 = self.var_1E55;
	}

	if(animscripts/utility::func_87FA())
	{
		self.a.var_ED8 = animscripts/utility::func_4F5D("rpg_crouch");
	}

	if(isdefined(self.weapon) && animscripts/utility::func_8D9B())
	{
		self.a.var_ED8 = animscripts/utility::func_4F5D("shotgun_crouch");
	}

	self.a.var_ED8 = animscripts/utility::func_4F5D("default_crouch");
}

//Function Number: 36
func_6E3F()
{
	if(animscripts/utility::func_87FE())
	{
		animscripts/shared::placeweaponon(self.primaryweapon,"right");
	}

	self.a.var_ED8 = animscripts/utility::func_4F5D("default_prone");
}

//Function Number: 37
func_4572()
{
	anim.var_45DF = [];
	level.var_45DF[0] = %run_turn_180;
	level.var_45DF[1] = %run_turn_l135;
	level.var_45DF[2] = %run_turn_l90;
	level.var_45DF[3] = %run_turn_l45;
	level.var_45DF[5] = %run_turn_r45;
	level.var_45DF[6] = %run_turn_r90;
	level.var_45DF[7] = %run_turn_r135;
	level.var_45DF[8] = %run_turn_180;
	level.archetypes["soldier"]["run_turn"] = level.var_45DF;
	anim.var_45DF = [];
	level.var_45DF[0] = %cqb_walk_turn_2;
	level.var_45DF[1] = %cqb_walk_turn_1;
	level.var_45DF[2] = %cqb_walk_turn_4;
	level.var_45DF[3] = %cqb_walk_turn_7;
	level.var_45DF[5] = %cqb_walk_turn_9;
	level.var_45DF[6] = %cqb_walk_turn_6;
	level.var_45DF[7] = %cqb_walk_turn_3;
	level.var_45DF[8] = %cqb_walk_turn_2;
	level.archetypes["soldier"]["cqb_turn"] = level.var_45DF;
	anim.var_45DF = [];
	level.var_45DF[0] = %cqb_run_turn_180_iw6;
	level.var_45DF[1] = %cqb_run_turn_l135_iw6;
	level.var_45DF[2] = %cqb_run_turn_l90_iw6;
	level.var_45DF[3] = %cqb_run_turn_l45_iw6;
	level.var_45DF[5] = %cqb_run_turn_r45_iw6;
	level.var_45DF[6] = %cqb_run_turn_r90_iw6;
	level.var_45DF[7] = %cqb_run_turn_r135_iw6;
	level.var_45DF[8] = %cqb_run_turn_180_iw6;
	level.archetypes["soldier"]["cqb_run_turn"] = level.var_45DF;
}

//Function Number: 38
func_4546()
{
	anim.var_45DF = [];
	level.var_45DF["turn_left_45"] = %exposed_tracking_turn45l;
	level.var_45DF["turn_left_90"] = %exposed_tracking_turn90l;
	level.var_45DF["turn_left_135"] = %exposed_tracking_turn135l;
	level.var_45DF["turn_left_180"] = %exposed_tracking_turn180l;
	level.var_45DF["turn_right_45"] = %exposed_tracking_turn45r;
	level.var_45DF["turn_right_90"] = %exposed_tracking_turn90r;
	level.var_45DF["turn_right_135"] = %exposed_tracking_turn135r;
	level.var_45DF["turn_right_180"] = %exposed_tracking_turn180r;
	level.archetypes["soldier"]["exposed_turn"] = level.var_45DF;
	anim.var_45DF = [];
	level.var_45DF["turn_left_45"] = %exposed_crouch_turn_90_left;
	level.var_45DF["turn_left_90"] = %exposed_crouch_turn_90_left;
	level.var_45DF["turn_left_135"] = %exposed_crouch_turn_180_left;
	level.var_45DF["turn_left_180"] = %exposed_crouch_turn_180_left;
	level.var_45DF["turn_right_45"] = %exposed_crouch_turn_90_right;
	level.var_45DF["turn_right_90"] = %exposed_crouch_turn_90_right;
	level.var_45DF["turn_right_135"] = %exposed_crouch_turn_180_right;
	level.var_45DF["turn_right_180"] = %exposed_crouch_turn_180_right;
	level.archetypes["soldier"]["exposed_turn_crouch"] = level.var_45DF;
}

//Function Number: 39
func_4550()
{
	anim.var_45DF = [];
	level.var_45DF["cower_squat"] = %exposed_squat_down_grenade_f;
	level.var_45DF["cower_squat_idle"] = %exposed_squat_idle_grenade_f;
	level.var_45DF["cower_dive_back"] = %exposed_dive_grenade_b;
	level.var_45DF["cower_dive_front"] = %exposed_dive_grenade_f;
	level.var_45DF["return_throw_short"] = [%grenade_return_running_throw_forward,%grenade_return_standing_throw_forward_1];
	level.var_45DF["return_throw_long"] = [%grenade_return_running_throw_forward,%grenade_return_standing_throw_overhand_forward];
	level.var_45DF["return_throw_default"] = [%grenade_return_standing_throw_overhand_forward];
	level.archetypes["soldier"]["grenade"] = level.var_45DF;
}

//Function Number: 40
func_4511()
{
	anim.var_45DF = [];
	level.var_45DF["F"] = %run_n_gun_f;
	level.var_45DF["L"] = %run_n_gun_l;
	level.var_45DF["R"] = %run_n_gun_r;
	level.var_45DF["LB"] = %run_n_gun_l_120;
	level.var_45DF["RB"] = %run_n_gun_r_120;
	level.var_45DF["move_back"] = %combatwalk_b;
	level.archetypes["soldier"]["run_n_gun"] = level.var_45DF;
}

//Function Number: 41
func_71B6()
{
	self.var_5118 = 130;
	self.var_6998 = 0.4615385;
	self.var_6997 = 0.3;
}

//Function Number: 42
init_animset_ambush()
{
	anim.var_45DF = [];
	level.var_45DF["move_l"] = %combatwalk_l;
	level.var_45DF["move_r"] = %combatwalk_r;
	level.var_45DF["move_b"] = %combatwalk_b;
	level.archetypes["soldier"]["ambush"] = level.var_45DF;
}

//Function Number: 43
func_6E2E()
{
	self.a.var_5473["move_l"] = animscripts/utility::lookupanim("ambush","move_l");
	self.a.var_5473["move_r"] = animscripts/utility::lookupanim("ambush","move_r");
	self.a.var_5473["move_b"] = animscripts/utility::lookupanim("ambush","move_b");
}

//Function Number: 44
func_4067()
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
				var_00 = animscripts/utility::lookupanim("heat_reload","reload_cover_left");
			}
			else if(self.node.type == "Cover Right")
			{
				var_00 = animscripts/utility::lookupanim("heat_reload","reload_cover_right");
			}

			if(isdefined(var_00))
			{
				return var_00;
			}
		}
	}

	return animscripts/utility::lookupanim("heat_reload","reload_default");
}