/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\animset.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 37
 * Decompile Time: 721 ms
 * Timestamp: 10/27/2023 2:17:37 AM
*******************************************************************/

//Function Number: 1
func_0C64()
{
	anim.animsets = spawnstruct();
	level.animsets.move = [];
	func_0C77();
	func_0C73();
	func_0C6C();
	func_0C6F();
	func_0C71();
	func_0C75();
	func_0C79();
	func_0C7B();
	func_0C7D();
	func_0C7F();
	func_0C67();
	func_0C6A();
	func_0C6B();
	func_0C69();
	func_0C9D();
}

//Function Number: 2
func_0C67()
{
	anim.var_C68 = [];
	level.var_C68["sprint"] = %sprint_loop_distant;
	level.var_C68["sprint_short"] = %sprint1_loop;
	level.var_C68["prone"] = %prone_crawl;
	level.var_C68["straight"] = %run_lowready_f;
	level.var_C68["move_f"] = %walk_forward;
	level.var_C68["move_l"] = %walk_left;
	level.var_C68["move_r"] = %walk_right;
	level.var_C68["move_b"] = %walk_backward;
	level.var_C68["crouch"] = %crouch_fastwalk_f;
	level.var_C68["crouch_l"] = %crouch_fastwalk_l;
	level.var_C68["crouch_r"] = %crouch_fastwalk_r;
	level.var_C68["crouch_b"] = %crouch_fastwalk_b;
	level.var_C68["stairs_up"] = %traverse_stair_run_01;
	level.var_C68["stairs_down"] = %traverse_stair_run_down;
	level.animsets.move["run"] = level.var_C68;
}

//Function Number: 3
func_0C69()
{
	anim.var_C68 = level.animsets.move["run"];
	level.var_C68["straight"] = %heat_run_loop;
	level.animsets.move["heat_run"] = level.var_C68;
}

//Function Number: 4
func_0C6A()
{
	anim.var_C68 = [];
	level.var_C68["sprint"] = %sprint_loop_distant;
	level.var_C68["sprint_short"] = %sprint1_loop;
	level.var_C68["prone"] = %prone_crawl;
	level.var_C68["straight"] = %walk_cqb_f;
	level.var_C68["move_f"] = %walk_cqb_f;
	level.var_C68["move_l"] = %walk_left;
	level.var_C68["move_r"] = %walk_right;
	level.var_C68["move_b"] = %walk_backward;
	level.var_C68["crouch"] = %crouch_fastwalk_f;
	level.var_C68["crouch_l"] = %crouch_fastwalk_l;
	level.var_C68["crouch_r"] = %crouch_fastwalk_r;
	level.var_C68["crouch_b"] = %crouch_fastwalk_b;
	level.var_C68["stairs_up"] = %traverse_stair_run;
	level.var_C68["stairs_down"] = %traverse_stair_run_down_01;
	level.animsets.move["walk"] = level.var_C68;
}

//Function Number: 5
func_0C6B()
{
	anim.var_C68 = [];
	level.var_C68["sprint"] = %sprint_loop_distant;
	level.var_C68["sprint_short"] = %sprint1_loop;
	level.var_C68["straight"] = %run_cqb_f_search_v1;
	level.var_C68["move_f"] = %walk_cqb_f;
	level.var_C68["move_l"] = %walk_left;
	level.var_C68["move_r"] = %walk_right;
	level.var_C68["move_b"] = %walk_backward;
	level.var_C68["stairs_up"] = %traverse_stair_run;
	level.var_C68["stairs_down"] = %traverse_stair_run_down_01;
	level.animsets.move["cqb"] = level.var_C68;
}

//Function Number: 6
func_0C6C()
{
	anim.var_C68 = [];
	level.var_C68["add_aim_up"] = %pistol_stand_aim_8_add;
	level.var_C68["add_aim_down"] = %pistol_stand_aim_2_add;
	level.var_C68["add_aim_left"] = %pistol_stand_aim_4_add;
	level.var_C68["add_aim_right"] = %pistol_stand_aim_6_add;
	level.var_C68["straight_level"] = %pistol_stand_aim_5;
	level.var_C68["fire"] = %pistol_stand_fire_a;
	level.var_C68["single"] = animscripts/utility::array(%pistol_stand_fire_a);
	level.var_C68["reload"] = animscripts/utility::array(%pistol_stand_reload_a);
	level.var_C68["reload_crouchhide"] = animscripts/utility::array();
	level.var_C68["exposed_idle"] = animscripts/utility::array(%exposed_idle_alert_v1,%exposed_idle_alert_v2,%exposed_idle_alert_v3);
	func_0C8A();
	level.var_C68["add_turn_aim_up"] = %pistol_stand_aim_8_alt;
	level.var_C68["add_turn_aim_down"] = %pistol_stand_aim_2_alt;
	level.var_C68["add_turn_aim_left"] = %pistol_stand_aim_4_alt;
	level.var_C68["add_turn_aim_right"] = %pistol_stand_aim_6_alt;
	level.animsets.var_C6E = level.var_C68;
}

//Function Number: 7
func_0C6F()
{
	anim.var_C68 = [];
	level.var_C68["add_aim_up"] = %rpg_stand_aim_8;
	level.var_C68["add_aim_down"] = %rpg_stand_aim_2;
	level.var_C68["add_aim_left"] = %rpg_stand_aim_4;
	level.var_C68["add_aim_right"] = %rpg_stand_aim_6;
	level.var_C68["straight_level"] = %rpg_stand_aim_5;
	level.var_C68["fire"] = %rpg_stand_fire;
	level.var_C68["single"] = animscripts/utility::array(%exposed_shoot_semi1);
	level.var_C68["reload"] = animscripts/utility::array(%rpg_stand_reload);
	level.var_C68["reload_crouchhide"] = animscripts/utility::array();
	level.var_C68["exposed_idle"] = animscripts/utility::array(%rpg_stand_idle);
	func_0C8D();
	func_0C8B();
	func_0C92();
	level.animsets.var_C70 = level.var_C68;
}

//Function Number: 8
func_0C71()
{
	anim.var_C68 = [];
	level.var_C68["add_aim_up"] = %shotgun_aim_8;
	level.var_C68["add_aim_down"] = %shotgun_aim_2;
	level.var_C68["add_aim_left"] = %shotgun_aim_4;
	level.var_C68["add_aim_right"] = %shotgun_aim_6;
	level.var_C68["straight_level"] = %shotgun_aim_5;
	level.var_C68["fire"] = %exposed_shoot_auto_v3;
	level.var_C68["single"] = animscripts/utility::array(%shotgun_stand_fire_1a,%shotgun_stand_fire_1b);
	func_0C8E();
	level.var_C68["exposed_idle"] = animscripts/utility::array(%exposed_idle_alert_v1,%exposed_idle_alert_v2,%exposed_idle_alert_v3);
	level.var_C68["reload"] = animscripts/utility::array(%shotgun_stand_reload_a,%shotgun_stand_reload_b,%shotgun_stand_reload_c,%shotgun_stand_reload_c,%shotgun_stand_reload_c);
	level.var_C68["reload_crouchhide"] = animscripts/utility::array(%shotgun_stand_reload_a,%shotgun_stand_reload_b);
	func_0C8D();
	func_0C8B();
	func_0C92();
	level.animsets.var_C72 = level.var_C68;
}

//Function Number: 9
func_0C73()
{
	anim.var_C68 = [];
	level.var_C68["add_aim_up"] = %cqb_stand_aim8;
	level.var_C68["add_aim_down"] = %cqb_stand_aim2;
	level.var_C68["add_aim_left"] = %cqb_stand_aim4;
	level.var_C68["add_aim_right"] = %cqb_stand_aim6;
	level.var_C68["straight_level"] = %cqb_stand_aim5;
	level.var_C68["fire"] = %exposed_shoot_auto_v3;
	level.var_C68["single"] = animscripts/utility::array(%exposed_shoot_semi1);
	func_0C8E();
	level.var_C68["exposed_idle"] = animscripts/utility::array(%exposed_idle_alert_v1,%exposed_idle_alert_v2,%exposed_idle_alert_v3);
	level.var_C68["reload"] = animscripts/utility::array(%cqb_stand_reload_steady);
	level.var_C68["reload_crouchhide"] = animscripts/utility::array(%cqb_stand_reload_knee);
	func_0C8D();
	func_0C8B();
	func_0C92();
	level.animsets.var_C74 = level.var_C68;
}

//Function Number: 10
func_0C75()
{
	anim.var_C68 = [];
	level.var_C68["add_aim_up"] = %heat_stand_aim_8;
	level.var_C68["add_aim_down"] = %heat_stand_aim_2;
	level.var_C68["add_aim_left"] = %heat_stand_aim_4;
	level.var_C68["add_aim_right"] = %heat_stand_aim_6;
	level.var_C68["straight_level"] = %heat_stand_aim_5;
	level.var_C68["fire"] = %heat_stand_fire_auto;
	level.var_C68["single"] = animscripts/utility::array(%heat_stand_fire_single);
	func_0C8F(%heat_stand_fire_burst);
	level.var_C68["exposed_idle"] = animscripts/utility::array(%heat_stand_idle,%heat_stand_scana,%heat_stand_scanb);
	level.var_C68["reload"] = animscripts/utility::array(%heat_exposed_reload);
	level.var_C68["reload_crouchhide"] = animscripts/utility::array();
	func_0C8D();
	level.var_C68["turn_left_45"] = %heat_stand_turn_l;
	level.var_C68["turn_left_90"] = %heat_stand_turn_l;
	level.var_C68["turn_left_135"] = %heat_stand_turn_180;
	level.var_C68["turn_left_180"] = %heat_stand_turn_180;
	level.var_C68["turn_right_45"] = %heat_stand_turn_r;
	level.var_C68["turn_right_90"] = %heat_stand_turn_r;
	level.var_C68["turn_right_135"] = %heat_stand_turn_180;
	level.var_C68["turn_right_180"] = %heat_stand_turn_180;
	func_0C92();
	level.animsets.var_C76 = level.var_C68;
}

//Function Number: 11
func_0C77()
{
	anim.var_C68 = [];
	level.var_C68["add_aim_up"] = %exposed_aim_8;
	level.var_C68["add_aim_down"] = %exposed_aim_2;
	level.var_C68["add_aim_left"] = %exposed_aim_4;
	level.var_C68["add_aim_right"] = %exposed_aim_6;
	level.var_C68["straight_level"] = %exposed_aim_5;
	level.var_C68["fire"] = %exposed_shoot_auto_v3;
	level.var_C68["single"] = animscripts/utility::array(%exposed_shoot_semi1);
	func_0C8E();
	level.var_C68["exposed_idle"] = animscripts/utility::array(%exposed_idle_alert_v1,%exposed_idle_alert_v2,%exposed_idle_alert_v3);
	level.var_C68["exposed_grenade"] = animscripts/utility::array(%exposed_grenadethrowb,%exposed_grenadethrowc);
	level.var_C68["reload"] = animscripts/utility::array(%exposed_reload);
	level.var_C68["reload_crouchhide"] = animscripts/utility::array(%exposed_reloadb);
	func_0C8D();
	func_0C8B();
	func_0C92();
	level.animsets.var_C78 = level.var_C68;
}

//Function Number: 12
func_0C79()
{
	anim.var_C68 = [];
	level.var_C68["add_aim_up"] = %exposed_crouch_aim_8;
	level.var_C68["add_aim_down"] = %exposed_crouch_aim_2;
	level.var_C68["add_aim_left"] = %exposed_crouch_aim_4;
	level.var_C68["add_aim_right"] = %exposed_crouch_aim_6;
	level.var_C68["straight_level"] = %exposed_crouch_aim_5;
	level.var_C68["fire"] = %exposed_crouch_shoot_auto_v2;
	level.var_C68["single"] = animscripts/utility::array(%exposed_crouch_shoot_semi1);
	func_0C90();
	level.var_C68["reload"] = animscripts/utility::array(%exposed_crouch_reload);
	level.var_C68["exposed_idle"] = animscripts/utility::array(%exposed_crouch_idle_alert_v1,%exposed_crouch_idle_alert_v2,%exposed_crouch_idle_alert_v3);
	func_0C8D();
	func_0C8C();
	func_0C93();
	level.animsets.var_C7A = level.var_C68;
}

//Function Number: 13
func_0C7B()
{
	anim.var_C68 = [];
	level.var_C68["add_aim_up"] = %rpg_crouch_aim_8;
	level.var_C68["add_aim_down"] = %rpg_crouch_aim_2;
	level.var_C68["add_aim_left"] = %rpg_crouch_aim_4;
	level.var_C68["add_aim_right"] = %rpg_crouch_aim_6;
	level.var_C68["straight_level"] = %rpg_crouch_aim_5;
	level.var_C68["fire"] = %rpg_crouch_fire;
	level.var_C68["single"] = animscripts/utility::array(%rpg_crouch_fire);
	level.var_C68["reload"] = animscripts/utility::array(%rpg_crouch_reload);
	level.var_C68["exposed_idle"] = animscripts/utility::array(%rpg_crouch_idle);
	func_0C8D();
	func_0C8C();
	func_0C93();
	level.animsets.var_C7C = level.var_C68;
}

//Function Number: 14
func_0C7D()
{
	anim.var_C68 = [];
	level.var_C68["add_aim_up"] = %exposed_crouch_aim_8;
	level.var_C68["add_aim_down"] = %exposed_crouch_aim_2;
	level.var_C68["add_aim_left"] = %exposed_crouch_aim_4;
	level.var_C68["add_aim_right"] = %exposed_crouch_aim_6;
	level.var_C68["straight_level"] = %exposed_crouch_aim_5;
	level.var_C68["fire"] = %exposed_crouch_shoot_auto_v2;
	level.var_C68["single"] = animscripts/utility::array(%shotgun_crouch_fire);
	func_0C90();
	level.var_C68["reload"] = animscripts/utility::array(%shotgun_crouch_reload);
	level.var_C68["exposed_idle"] = animscripts/utility::array(%exposed_crouch_idle_alert_v1,%exposed_crouch_idle_alert_v2,%exposed_crouch_idle_alert_v3);
	func_0C8D();
	func_0C8C();
	func_0C93();
	level.animsets.var_C7E = level.var_C68;
}

//Function Number: 15
func_0C7F()
{
	anim.var_C68 = [];
	level.var_C68["add_aim_up"] = %prone_aim_8_add;
	level.var_C68["add_aim_down"] = %prone_aim_2_add;
	level.var_C68["add_aim_left"] = %prone_aim_4_add;
	level.var_C68["add_aim_right"] = %prone_aim_6_add;
	level.var_C68["straight_level"] = %prone_aim_5;
	level.var_C68["fire"] = %prone_fire_1;
	level.var_C68["single"] = animscripts/utility::array(%prone_fire_1);
	level.var_C68["reload"] = animscripts/utility::array(%prone_reload);
	level.var_C68["burst2"] = %prone_fire_burst;
	level.var_C68["burst3"] = %prone_fire_burst;
	level.var_C68["burst4"] = %prone_fire_burst;
	level.var_C68["burst5"] = %prone_fire_burst;
	level.var_C68["burst6"] = %prone_fire_burst;
	level.var_C68["semi2"] = %prone_fire_burst;
	level.var_C68["semi3"] = %prone_fire_burst;
	level.var_C68["semi4"] = %prone_fire_burst;
	level.var_C68["semi5"] = %prone_fire_burst;
	level.var_C68["exposed_idle"] = animscripts/utility::array(%exposed_crouch_idle_alert_v1,%exposed_crouch_idle_alert_v2,%exposed_crouch_idle_alert_v3);
	func_0C8D();
	level.animsets.var_C80 = level.var_C68;
}

//Function Number: 16
func_0C81(param_00)
{
	self.var_C82 = param_00;
}

//Function Number: 17
func_0C83(param_00,param_01,param_02,param_03)
{
	anim.var_C68 = level.animsets.var_C78;
	if(isdefined(param_01))
	{
		level.var_C68["straight_level"] = param_01;
	}

	if(isdefined(param_00))
	{
		level.var_C68["fire"] = param_00;
		level.var_C68["single"] = animscripts/utility::array(param_00);
		func_0C8F(param_00);
	}

	if(isdefined(param_02))
	{
		level.var_C68["exposed_idle"] = animscripts/utility::array(param_02);
	}

	if(isdefined(param_03))
	{
		level.var_C68["reload"] = animscripts/utility::array(param_03);
		level.var_C68["reload_crouchhide"] = animscripts/utility::array(param_03);
	}

	self.var_C82 = level.var_C68;
}

//Function Number: 18
func_0C84(param_00)
{
	self.var_C85 = param_00;
}

//Function Number: 19
func_0C86(param_00,param_01,param_02)
{
	anim.var_C68 = level.animsets.var_C7A;
	if(isdefined(param_00))
	{
		level.var_C68["fire"] = param_00;
		level.var_C68["single"] = animscripts/utility::array(param_00);
		func_0C91(param_00);
	}

	if(isdefined(param_01))
	{
		level.var_C68["exposed_idle"] = animscripts/utility::array(param_01);
	}

	if(isdefined(param_02))
	{
		level.var_C68["reload"] = animscripts/utility::array(param_02);
	}

	self.var_C85 = level.var_C68;
}

//Function Number: 20
func_0C87()
{
	self.custommoveanimset = undefined;
	self.var_C89 = undefined;
	self.var_C82 = undefined;
	self.var_C85 = undefined;
}

//Function Number: 21
func_0C8A(param_00)
{
	level.var_C68["turn_left_45"] = %pistol_stand_turn45l;
	level.var_C68["turn_left_90"] = %pistol_stand_turn90l;
	level.var_C68["turn_left_135"] = %pistol_stand_turn90l;
	level.var_C68["turn_left_180"] = %pistol_stand_turn180l;
	level.var_C68["turn_right_45"] = %pistol_stand_turn45r;
	level.var_C68["turn_right_90"] = %pistol_stand_turn90r;
	level.var_C68["turn_right_135"] = %pistol_stand_turn90r;
	level.var_C68["turn_right_180"] = %pistol_stand_turn180l;
}

//Function Number: 22
func_0C8B()
{
	level.var_C68["turn_left_45"] = %exposed_tracking_turn45l;
	level.var_C68["turn_left_90"] = %exposed_tracking_turn90l;
	level.var_C68["turn_left_135"] = %exposed_tracking_turn135l;
	level.var_C68["turn_left_180"] = %exposed_tracking_turn180l;
	level.var_C68["turn_right_45"] = %exposed_tracking_turn45r;
	level.var_C68["turn_right_90"] = %exposed_tracking_turn90r;
	level.var_C68["turn_right_135"] = %exposed_tracking_turn135r;
	level.var_C68["turn_right_180"] = %exposed_tracking_turn180r;
}

//Function Number: 23
func_0C8C()
{
	level.var_C68["turn_left_45"] = %exposed_crouch_turn_90_left;
	level.var_C68["turn_left_90"] = %exposed_crouch_turn_90_left;
	level.var_C68["turn_left_135"] = %exposed_crouch_turn_180_left;
	level.var_C68["turn_left_180"] = %exposed_crouch_turn_180_left;
	level.var_C68["turn_right_45"] = %exposed_crouch_turn_90_right;
	level.var_C68["turn_right_90"] = %exposed_crouch_turn_90_right;
	level.var_C68["turn_right_135"] = %exposed_crouch_turn_180_right;
	level.var_C68["turn_right_180"] = %exposed_crouch_turn_180_right;
}

//Function Number: 24
func_0C8D()
{
	level.var_C68["crouch_2_stand"] = %exposed_crouch_2_stand;
	level.var_C68["crouch_2_prone"] = %crouch_2_prone;
	level.var_C68["stand_2_crouch"] = %exposed_stand_2_crouch;
	level.var_C68["stand_2_prone"] = %stand_2_prone;
	level.var_C68["prone_2_crouch"] = %prone_2_crouch;
	level.var_C68["prone_2_stand"] = %prone_2_stand;
}

//Function Number: 25
func_0C8E()
{
	level.var_C68["burst2"] = %exposed_shoot_burst3;
	level.var_C68["burst3"] = %exposed_shoot_burst3;
	level.var_C68["burst4"] = %exposed_shoot_burst4;
	level.var_C68["burst5"] = %exposed_shoot_burst5;
	level.var_C68["burst6"] = %exposed_shoot_burst6;
	level.var_C68["semi2"] = %exposed_shoot_semi2;
	level.var_C68["semi3"] = %exposed_shoot_semi3;
	level.var_C68["semi4"] = %exposed_shoot_semi4;
	level.var_C68["semi5"] = %exposed_shoot_semi5;
}

//Function Number: 26
func_0C8F(param_00)
{
	level.var_C68["burst2"] = param_00;
	level.var_C68["burst3"] = param_00;
	level.var_C68["burst4"] = param_00;
	level.var_C68["burst5"] = param_00;
	level.var_C68["burst6"] = param_00;
	level.var_C68["semi2"] = param_00;
	level.var_C68["semi3"] = param_00;
	level.var_C68["semi4"] = param_00;
	level.var_C68["semi5"] = param_00;
}

//Function Number: 27
func_0C90()
{
	level.var_C68["burst2"] = %exposed_crouch_shoot_burst3;
	level.var_C68["burst3"] = %exposed_crouch_shoot_burst3;
	level.var_C68["burst4"] = %exposed_crouch_shoot_burst4;
	level.var_C68["burst5"] = %exposed_crouch_shoot_burst5;
	level.var_C68["burst6"] = %exposed_crouch_shoot_burst6;
	level.var_C68["semi2"] = %exposed_crouch_shoot_semi2;
	level.var_C68["semi3"] = %exposed_crouch_shoot_semi3;
	level.var_C68["semi4"] = %exposed_crouch_shoot_semi4;
	level.var_C68["semi5"] = %exposed_crouch_shoot_semi5;
}

//Function Number: 28
func_0C91(param_00)
{
	level.var_C68["burst2"] = param_00;
	level.var_C68["burst3"] = param_00;
	level.var_C68["burst4"] = param_00;
	level.var_C68["burst5"] = param_00;
	level.var_C68["burst6"] = param_00;
	level.var_C68["semi2"] = param_00;
	level.var_C68["semi3"] = param_00;
	level.var_C68["semi4"] = param_00;
	level.var_C68["semi5"] = param_00;
}

//Function Number: 29
func_0C92()
{
	level.var_C68["add_turn_aim_up"] = %exposed_turn_aim_8;
	level.var_C68["add_turn_aim_down"] = %exposed_turn_aim_2;
	level.var_C68["add_turn_aim_left"] = %exposed_turn_aim_4;
	level.var_C68["add_turn_aim_right"] = %exposed_turn_aim_6;
}

//Function Number: 30
func_0C93()
{
	level.var_C68["add_turn_aim_up"] = %exposed_crouch_turn_aim_8;
	level.var_C68["add_turn_aim_down"] = %exposed_crouch_turn_aim_2;
	level.var_C68["add_turn_aim_left"] = %exposed_crouch_turn_aim_4;
	level.var_C68["add_turn_aim_right"] = %exposed_crouch_turn_aim_6;
}

//Function Number: 31
func_0C94()
{
	if(animscripts/utility::func_C95())
	{
		self.a.array = level.animsets.var_C6E;
		return;
	}

	if(isdefined(self.var_C82))
	{
		self.a.array = self.var_C82;
		return;
	}

	if(isdefined(self.heat))
	{
		self.a.array = level.animsets.var_C76;
		return;
	}

	if(animscripts/utility::func_BB6())
	{
		self.a.array = level.animsets.var_C70;
		return;
	}

	if(isdefined(self.weapon) && animscripts/utility::func_C97())
	{
		self.a.array = level.animsets.var_C72;
		return;
	}

	if(animscripts/utility::func_C98())
	{
		self.a.array = level.animsets.var_C74;
		return;
	}

	self.a.array = level.animsets.var_C78;
}

//Function Number: 32
func_0C99()
{
	if(animscripts/utility::func_C95())
	{
		animscripts/shared::func_C9B(self.primaryweapon,"right");
	}

	if(isdefined(self.var_C85))
	{
		self.a.array = self.var_C85;
		return;
	}

	if(animscripts/utility::func_BB6())
	{
		self.a.array = level.animsets.var_C7C;
		return;
	}

	if(isdefined(self.weapon) && animscripts/utility::func_C97())
	{
		self.a.array = level.animsets.var_C7E;
		return;
	}

	self.a.array = level.animsets.var_C7A;
}

//Function Number: 33
func_0C9C()
{
	if(animscripts/utility::func_C95())
	{
		animscripts/shared::func_C9B(self.primaryweapon,"right");
	}

	self.a.array = level.animsets.var_C80;
}

//Function Number: 34
func_0C9D()
{
	level.var_C9E["L90"] = %run_turn_l90;
	level.var_C9E["R90"] = %run_turn_r90;
	level.var_C9E["L45"] = %run_turn_l45;
	level.var_C9E["R45"] = %run_turn_r45;
	level.var_C9E["L135"] = %run_turn_l135;
	level.var_C9E["R135"] = %run_turn_r135;
	level.var_C9E["180"] = %run_turn_180;
	level.var_C9F["L90"] = %cqb_walk_turn_4;
	level.var_C9F["R90"] = %cqb_walk_turn_6;
	level.var_C9F["L45"] = %cqb_walk_turn_7;
	level.var_C9F["R45"] = %cqb_walk_turn_9;
	level.var_C9F["L135"] = %cqb_walk_turn_1;
	level.var_C9F["R135"] = %cqb_walk_turn_3;
	level.var_C9F["180"] = %cqb_walk_turn_2;
}

//Function Number: 35
func_0CA0()
{
	self.var_CA1 = 130;
	self.var_CA2 = 0.4615385;
	self.var_CA3 = 0.3;
	self.var_CA4["F"] = %run_n_gun_f;
	self.var_CA4["L"] = %run_n_gun_l;
	self.var_CA4["R"] = %run_n_gun_r;
	self.var_CA4["LB"] = %run_n_gun_l_120;
	self.var_CA4["RB"] = %run_n_gun_r_120;
}

//Function Number: 36
func_0CA5()
{
	self.a.var_CA6["move_l"] = %combatwalk_l;
	self.a.var_CA6["move_r"] = %combatwalk_r;
	self.a.var_CA6["move_b"] = %combatwalk_b;
}

//Function Number: 37
func_0CA7()
{
	if(self.weapon != self.primaryweapon)
	{
		return animscripts/utility::func_CA8("reload");
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