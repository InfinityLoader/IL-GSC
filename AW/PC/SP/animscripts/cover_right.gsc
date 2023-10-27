/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\cover_right.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 98 ms
 * Timestamp: 10/27/2023 1:54:51 AM
*******************************************************************/

//Function Number: 1
init_animset_cover_right()
{
	var_00 = [];
	var_00["alert_idle"] = %corner_standr_alert_idle;
	var_00["alert_idle_twitch"] = [%corner_standr_alert_twitch01,%corner_standr_alert_twitch02,%corner_standr_alert_twitch04,%corner_standr_alert_twitch05,%corner_standr_alert_twitch06,%corner_standr_alert_twitch07];
	var_00["alert_idle_flinch"] = [%corner_standr_flinch,%corner_standr_flinchb];
	var_00["alert_to_A"] = [%corner_standr_trans_alert_2_a,%corner_standr_trans_alert_2_a_v2];
	var_00["alert_to_B"] = [%corner_standr_trans_alert_2_b,%corner_standr_trans_alert_2_b_v2,%corner_standr_trans_alert_2_b_v3];
	var_00["A_to_alert"] = [%corner_standr_trans_a_2_alert_v2];
	var_00["A_to_alert_reload"] = [];
	var_00["A_to_B"] = [%corner_standr_trans_a_2_b,%corner_standr_trans_a_2_b_v2];
	var_00["B_to_alert"] = [%corner_standr_trans_b_2_alert,%corner_standr_trans_b_2_alert_v2,%corner_standr_trans_b_2_alert_v3];
	var_00["B_to_alert_reload"] = [%corner_standr_reload_b_2_alert];
	var_00["B_to_A"] = [%corner_standr_trans_b_2_a,%corner_standr_trans_b_2_a_v2];
	var_00["lean_to_alert"] = [%cornerstndr_lean_2_alert];
	var_00["alert_to_lean"] = [%cornerstndr_alert_2_lean];
	var_00["look"] = %corner_standr_look;
	var_00["reload"] = [%corner_standr_reload_v1];
	var_00["grenade_exposed"] = %corner_standr_grenade_a;
	var_00["grenade_safe"] = %corner_standr_grenade_b;
	var_00["blind_fire"] = [%corner_standr_blindfire_v1,%corner_standr_blindfire_v2];
	var_00["alert_to_look"] = %corner_standr_alert_2_look;
	var_00["look_to_alert"] = %corner_standr_look_2_alert;
	var_00["look_to_alert_fast"] = %corner_standr_look_2_alert_fast;
	var_00["look_idle"] = %corner_standr_look_idle;
	var_00["stance_change"] = %cornercrr_stand_2_alert;
	var_00["lean_aim_down"] = %cornerstndr_lean_aim_2;
	var_00["lean_aim_left"] = %cornerstndr_lean_aim_4;
	var_00["lean_aim_straight"] = %cornerstndr_lean_aim_5;
	var_00["lean_aim_right"] = %cornerstndr_lean_aim_6;
	var_00["lean_aim_up"] = %cornerstndr_lean_aim_8;
	var_00["lean_reload"] = %cornerstndr_lean_reload;
	var_00["lean_idle"] = [%cornerstndr_lean_idle];
	var_00["lean_single"] = %cornerstndr_lean_fire;
	var_00["lean_fire"] = %cornerstndr_lean_auto;
	level.archetypes["soldier"]["cover_right_stand"] = var_00;
	var_00 = [];
	var_00["alert_idle"] = %cornercrr_alert_idle;
	var_00["alert_idle_twitch"] = [%cornercrr_alert_twitch_v1,%cornercrr_alert_twitch_v2,%cornercrr_alert_twitch_v3];
	var_00["alert_idle_flinch"] = [];
	var_00["alert_to_A"] = [%cornercrr_trans_alert_2_a];
	var_00["alert_to_B"] = [%cornercrr_trans_alert_2_b];
	var_00["A_to_alert"] = [%cornercrr_trans_a_2_alert];
	var_00["A_to_alert_reload"] = [];
	var_00["A_to_B"] = [%cornercrr_trans_a_2_b];
	var_00["B_to_alert"] = [%cornercrr_trans_b_2_alert];
	var_00["B_to_alert_reload"] = [];
	var_00["B_to_A"] = [%cornercrr_trans_b_2_a];
	var_00["lean_to_alert"] = [%cornercrr_lean_2_alert];
	var_00["alert_to_lean"] = [%cornercrr_alert_2_lean];
	var_00["reload"] = [%cornercrr_reloada,%cornercrr_reloadb];
	var_00["grenade_exposed"] = %cornercrr_grenadea;
	var_00["grenade_safe"] = %cornercrr_grenadea;
	var_00["alert_to_over"] = [%cornercrr_alert_2_over];
	var_00["over_to_alert"] = [%cornercrr_over_2_alert];
	var_00["over_to_alert_reload"] = [];
	var_00["blind_fire"] = [];
	var_00["rambo90"] = [];
	var_00["rambo45"] = [];
	var_00["alert_to_look"] = %cornercrr_alert_2_look;
	var_00["look_to_alert"] = %cornercrr_look_2_alert;
	var_00["look_to_alert_fast"] = %cornercrr_look_2_alert_fast;
	var_00["look_idle"] = %cornercrr_look_idle;
	var_00["stance_change"] = %cornercrr_alert_2_stand;
	var_00["lean_aim_down"] = %cornercrr_lean_aim_2;
	var_00["lean_aim_left"] = %cornercrr_lean_aim_4;
	var_00["lean_aim_straight"] = %cornercrr_lean_aim_5;
	var_00["lean_aim_right"] = %cornercrr_lean_aim_6;
	var_00["lean_aim_up"] = %cornercrr_lean_aim_8;
	var_00["lean_idle"] = [%cornercrr_lean_idle];
	var_00["lean_single"] = %cornercrr_lean_fire;
	var_00["lean_fire"] = %cornercrr_lean_auto;
	level.archetypes["soldier"]["cover_right_crouch"] = var_00;
}

//Function Number: 2
main()
{
	self.animarrayfuncs = [];
	self.animarrayfuncs["hiding"]["stand"] = ::set_animarray_standing_right;
	self.animarrayfuncs["hiding"]["crouch"] = ::set_animarray_crouching_right;
	self endon("killanimscript");
	animscripts\utility::initialize("cover_right");
	animscripts\corner::corner_think("right",-90);
}

//Function Number: 3
end_script()
{
	animscripts\corner::end_script_corner();
	animscripts\cover_behavior::end_script("right");
}

//Function Number: 4
set_animarray_standing_right()
{
	self.hideyawoffset = -90;
	self.a.array = animscripts\utility::lookupanimarray("cover_right_stand");
	if(isdefined(level.ramboanims))
	{
		self.a.array["rambo90"] = level.ramboanims.coverright90;
		self.a.array["rambo45"] = level.ramboanims.coverright45;
		self.a.array["grenade_rambo"] = level.ramboanims.coverrightgrenade;
	}
}

//Function Number: 5
set_animarray_crouching_right()
{
	self.hideyawoffset = -90;
	self.a.array = animscripts\utility::lookupanimarray("cover_right_crouch");
}