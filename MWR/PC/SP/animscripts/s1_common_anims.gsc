/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\s1_common_anims.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 30
 * Decompile Time: 525 ms
 * Timestamp: 10/27/2023 2:44:37 AM
*******************************************************************/

//Function Number: 1
initsoliders1entrance()
{
	var_00 = [];
	var_00["stand"][1] = %s1_coverstand_trans_in_ml;
	var_00["stand"][2] = %s1_coverstand_trans_in_m;
	var_00["stand"][3] = %s1_coverstand_trans_in_mr;
	var_00["stand"][4] = %s1_coverstand_trans_in_l;
	var_00["stand"][6] = %s1_coverstand_trans_in_r;
	var_00["right"][1] = %s1_corner_standr_trans_in_1;
	var_00["right"][2] = %s1_corner_standr_trans_in_2;
	var_00["right"][3] = %s1_corner_standr_trans_in_3;
	var_00["right"][4] = %s1_corner_standr_trans_in_4;
	var_00["right"][6] = %s1_corner_standr_trans_in_6;
	var_00["right"][8] = %s1_corner_standr_trans_in_8;
	var_00["right"][9] = %s1_corner_standr_trans_in_9;
	var_00["right_cqb"][1] = %s1_corner_standr_trans_cqb_in_1;
	var_00["right_cqb"][2] = %s1_corner_standr_trans_cqb_in_2;
	var_00["right_cqb"][3] = %s1_corner_standr_trans_cqb_in_3;
	var_00["right_cqb"][4] = %s1_corner_standr_trans_cqb_in_4;
	var_00["right_cqb"][6] = %s1_corner_standr_trans_cqb_in_6;
	var_00["right_cqb"][8] = %s1_corner_standr_trans_cqb_in_8;
	var_00["right_cqb"][9] = %s1_corner_standr_trans_cqb_in_9;
	var_00["right_crouch"][1] = %s1_cornercrr_trans_in_ml;
	var_00["right_crouch"][2] = %s1_cornercrr_trans_in_m;
	var_00["right_crouch"][3] = %s1_cornercrr_trans_in_mr;
	var_00["right_crouch"][4] = %s1_cornercrr_trans_in_l;
	var_00["right_crouch"][6] = %s1_cornercrr_trans_in_r;
	var_00["right_crouch"][8] = %s1_cornercrr_trans_in_f;
	var_00["right_crouch"][9] = %s1_cornercrr_trans_in_mf;
	var_00["right_crouch_cqb"][1] = %s1_cornercrr_cqb_trans_in_1;
	var_00["right_crouch_cqb"][2] = %s1_cornercrr_cqb_trans_in_2;
	var_00["right_crouch_cqb"][3] = %s1_cornercrr_cqb_trans_in_3;
	var_00["right_crouch_cqb"][4] = %s1_cornercrr_cqb_trans_in_4;
	var_00["right_crouch_cqb"][6] = %s1_cornercrr_cqb_trans_in_6;
	var_00["right_crouch_cqb"][8] = %s1_cornercrr_cqb_trans_in_8;
	var_00["right_crouch_cqb"][9] = %s1_cornercrr_cqb_trans_in_9;
	var_00["left"][1] = %s1_corner_standl_trans_in_1;
	var_00["left"][2] = %s1_corner_standl_trans_in_2;
	var_00["left"][3] = %s1_corner_standl_trans_in_3;
	var_00["left"][4] = %s1_corner_standl_trans_in_4;
	var_00["left"][6] = %s1_corner_standl_trans_in_6;
	var_00["left"][7] = %s1_corner_standl_trans_in_7;
	var_00["left"][8] = %s1_corner_standl_trans_in_8;
	var_00["left_cqb"][1] = %s1_corner_standl_trans_cqb_in_1;
	var_00["left_cqb"][2] = %s1_corner_standl_trans_cqb_in_2;
	var_00["left_cqb"][3] = %s1_corner_standl_trans_cqb_in_3;
	var_00["left_cqb"][4] = %s1_corner_standl_trans_cqb_in_4;
	var_00["left_cqb"][6] = %s1_corner_standl_trans_cqb_in_6;
	var_00["left_cqb"][7] = %s1_corner_standl_trans_cqb_in_7;
	var_00["left_cqb"][8] = %s1_corner_standl_trans_cqb_in_8;
	var_00["left_crouch_cqb"][1] = %s1_cornercrl_cqb_trans_in_1;
	var_00["left_crouch_cqb"][2] = %s1_cornercrl_cqb_trans_in_2;
	var_00["left_crouch_cqb"][3] = %s1_cornercrl_cqb_trans_in_3;
	var_00["left_crouch_cqb"][4] = %s1_cornercrl_cqb_trans_in_4;
	var_00["left_crouch_cqb"][6] = %s1_cornercrl_cqb_trans_in_6;
	var_00["left_crouch_cqb"][7] = %s1_cornercrl_cqb_trans_in_7;
	var_00["left_crouch_cqb"][8] = %s1_cornercrl_cqb_trans_in_8;
	var_00["left_crouch"][1] = %s1_cornercrl_trans_in_ml;
	var_00["left_crouch"][2] = %s1_cornercrl_trans_in_m;
	var_00["left_crouch"][3] = %s1_cornercrl_trans_in_mr;
	var_00["left_crouch"][4] = %s1_cornercrl_trans_in_l;
	var_00["left_crouch"][6] = %s1_cornercrl_trans_in_r;
	var_00["left_crouch"][7] = %s1_cornercrl_trans_in_mf;
	var_00["left_crouch"][8] = %s1_cornercrl_trans_in_f;
	var_00["left_crouch_cqb"][1] = %s1_cornercrl_cqb_trans_in_1;
	var_00["left_crouch_cqb"][2] = %s1_cornercrl_cqb_trans_in_2;
	var_00["left_crouch_cqb"][3] = %s1_cornercrl_cqb_trans_in_3;
	var_00["left_crouch_cqb"][4] = %s1_cornercrl_cqb_trans_in_4;
	var_00["left_crouch_cqb"][6] = %s1_cornercrl_cqb_trans_in_6;
	var_00["left_crouch_cqb"][7] = %s1_cornercrl_cqb_trans_in_7;
	var_00["left_crouch_cqb"][8] = %s1_cornercrl_cqb_trans_in_8;
	var_00["exposed"][1] = %s1_run_2_idle_1;
	var_00["exposed"][2] = %s1_run_2_stand_f_6;
	var_00["exposed"][3] = %s1_run_2_idle_3;
	var_00["exposed"][4] = %s1_run_2_stand_90l;
	var_00["exposed"][6] = %s1_run_2_stand_90r;
	var_00["exposed"][7] = %s1_run_2_idle_7;
	var_00["exposed"][8] = %s1_run_2_stand_180l;
	var_00["exposed"][9] = %s1_run_2_idle_9;
	var_00["exposed_cqb"][1] = %cqb_stop_1;
	var_00["exposed_cqb"][2] = %cqb_stop_2;
	var_00["exposed_cqb"][3] = %cqb_stop_3;
	var_00["exposed_cqb"][4] = %cqb_stop_4;
	var_00["exposed_cqb"][6] = %cqb_stop_6;
	var_00["exposed_cqb"][7] = %cqb_stop_7;
	var_00["exposed_cqb"][8] = %cqb_stop_8;
	var_00["exposed_cqb"][9] = %cqb_stop_9;
	var_00["exposed_crouch"][1] = %s1_cqb_crouch_stop_1;
	var_00["exposed_crouch"][2] = %s1_cqb_crouch_stop_2;
	var_00["exposed_crouch"][3] = %s1_cqb_crouch_stop_3;
	var_00["exposed_crouch"][4] = %s1_cqb_crouch_stop_4;
	var_00["exposed_crouch"][6] = %s1_cqb_crouch_stop_6;
	var_00["exposed_crouch"][7] = %s1_cqb_crouch_stop_7;
	var_00["exposed_crouch"][8] = %s1_cqb_crouch_stop_8;
	var_00["exposed_crouch"][9] = %s1_cqb_crouch_stop_9;
	var_00["exposed_crouch_cqb"][1] = %s1_cqb_crouch_stop_1;
	var_00["exposed_crouch_cqb"][2] = %s1_cqb_crouch_stop_2;
	var_00["exposed_crouch_cqb"][3] = %s1_cqb_crouch_stop_3;
	var_00["exposed_crouch_cqb"][4] = %s1_cqb_crouch_stop_4;
	var_00["exposed_crouch_cqb"][6] = %s1_cqb_crouch_stop_6;
	var_00["exposed_crouch_cqb"][7] = %s1_cqb_crouch_stop_7;
	var_00["exposed_crouch_cqb"][8] = %s1_cqb_crouch_stop_8;
	var_00["exposed_crouch_cqb"][9] = %s1_cqb_crouch_stop_9;
	var_00["crouch"][1] = %s1_covercrouch_run_in_ml;
	var_00["crouch"][2] = %s1_covercrouch_run_in_m;
	var_00["crouch"][3] = %s1_covercrouch_run_in_mr;
	var_00["crouch"][4] = %s1_covercrouch_run_in_l;
	var_00["crouch"][6] = %s1_covercrouch_run_in_r;
	level.archetypes["s1_soldier"]["cover_trans"] = var_00;
}

//Function Number: 2
initsoliders1exit()
{
	var_00 = [];
	var_00["right"][1] = %s1_corner_standr_trans_out_1;
	var_00["right"][2] = %s1_corner_standr_trans_out_2;
	var_00["right"][3] = %s1_corner_standr_trans_out_3;
	var_00["right"][4] = %s1_corner_standr_trans_out_4;
	var_00["right"][6] = %s1_corner_standr_trans_out_6;
	var_00["right"][8] = %s1_corner_standr_trans_out_8;
	var_00["right"][9] = %s1_corner_standr_trans_out_9;
	var_00["right_cqb"][1] = %s1_corner_standr_trans_cqb_out_1;
	var_00["right_cqb"][2] = %s1_corner_standr_trans_cqb_out_2;
	var_00["right_cqb"][3] = %s1_corner_standr_trans_cqb_out_3;
	var_00["right_cqb"][4] = %s1_corner_standr_trans_cqb_out_4;
	var_00["right_cqb"][6] = %s1_corner_standr_trans_cqb_out_6;
	var_00["right_cqb"][8] = %s1_corner_standr_trans_cqb_out_8;
	var_00["right_cqb"][9] = %s1_corner_standr_trans_cqb_out_9;
	var_00["right_crouch"][1] = %s1_cornercrr_trans_out_ml;
	var_00["right_crouch"][2] = %s1_cornercrr_trans_out_m;
	var_00["right_crouch"][3] = %s1_cornercrr_trans_out_mr;
	var_00["right_crouch"][4] = %s1_cornercrr_trans_out_l;
	var_00["right_crouch"][6] = %s1_cornercrr_trans_out_r;
	var_00["right_crouch"][8] = %s1_cornercrr_trans_out_f;
	var_00["right_crouch"][9] = %s1_cornercrr_trans_out_mf;
	var_00["right_crouch_cqb"][1] = %s1_cornercrr_cqb_trans_out_1;
	var_00["right_crouch_cqb"][2] = %s1_cornercrr_cqb_trans_out_2;
	var_00["right_crouch_cqb"][3] = %s1_cornercrr_cqb_trans_out_3;
	var_00["right_crouch_cqb"][4] = %s1_cornercrr_cqb_trans_out_4;
	var_00["right_crouch_cqb"][6] = %s1_cornercrr_cqb_trans_out_6;
	var_00["right_crouch_cqb"][8] = %s1_cornercrr_cqb_trans_out_8;
	var_00["right_crouch_cqb"][9] = %s1_cornercrr_cqb_trans_out_9;
	var_00["left"][1] = %s1_corner_standl_trans_out_1;
	var_00["left"][2] = %s1_corner_standl_trans_out_2;
	var_00["left"][3] = %s1_corner_standl_trans_out_3;
	var_00["left"][4] = %s1_corner_standl_trans_out_4;
	var_00["left"][6] = %s1_corner_standl_trans_out_6;
	var_00["left"][7] = %s1_corner_standl_trans_out_7;
	var_00["left"][8] = %s1_corner_standl_trans_out_8;
	var_00["left_cqb"][1] = %s1_corner_standl_trans_cqb_out_1;
	var_00["left_cqb"][2] = %s1_corner_standl_trans_cqb_out_2;
	var_00["left_cqb"][3] = %s1_corner_standl_trans_cqb_out_3;
	var_00["left_cqb"][4] = %s1_corner_standl_trans_cqb_out_4;
	var_00["left_cqb"][6] = %s1_corner_standl_trans_cqb_out_6;
	var_00["left_cqb"][7] = %s1_corner_standl_trans_cqb_out_7;
	var_00["left_cqb"][8] = %s1_corner_standl_trans_cqb_out_8;
	var_00["right_cqb"][1] = %s1_corner_standr_trans_cqb_out_1;
	var_00["right_cqb"][2] = %s1_corner_standr_trans_cqb_out_2;
	var_00["right_cqb"][3] = %s1_corner_standr_trans_cqb_out_3;
	var_00["right_cqb"][4] = %s1_corner_standr_trans_cqb_out_4;
	var_00["right_cqb"][6] = %s1_corner_standr_trans_cqb_out_6;
	var_00["right_cqb"][8] = %s1_corner_standr_trans_cqb_out_8;
	var_00["right_cqb"][9] = %s1_corner_standr_trans_cqb_out_9;
	var_00["left_crouch"][1] = %s1_cornercrl_trans_out_ml;
	var_00["left_crouch"][2] = %s1_cornercrl_trans_out_m;
	var_00["left_crouch"][3] = %s1_cornercrl_trans_out_mr;
	var_00["left_crouch"][4] = %s1_cornercrl_trans_out_l;
	var_00["left_crouch"][6] = %s1_cornercrl_trans_out_r;
	var_00["left_crouch"][7] = %s1_cornercrl_trans_out_mf;
	var_00["left_crouch"][8] = %s1_cornercrl_trans_out_f;
	var_00["left_crouch_cqb"][1] = %s1_cornercrl_cqb_trans_out_1;
	var_00["left_crouch_cqb"][2] = %s1_cornercrl_cqb_trans_out_2;
	var_00["left_crouch_cqb"][3] = %s1_cornercrl_cqb_trans_out_3;
	var_00["left_crouch_cqb"][4] = %s1_cornercrl_cqb_trans_out_4;
	var_00["left_crouch_cqb"][6] = %s1_cornercrl_cqb_trans_out_6;
	var_00["left_crouch_cqb"][7] = %s1_cornercrl_cqb_trans_out_7;
	var_00["left_crouch_cqb"][8] = %s1_cornercrl_cqb_trans_out_8;
	var_00["exposed_crouch"][1] = %s1_cqb_crouch_start_1;
	var_00["exposed_crouch"][2] = %s1_cqb_crouch_start_2;
	var_00["exposed_crouch"][3] = %s1_cqb_crouch_start_3;
	var_00["exposed_crouch"][4] = %s1_cqb_crouch_start_4;
	var_00["exposed_crouch"][6] = %s1_cqb_crouch_start_6;
	var_00["exposed_crouch"][7] = %s1_cqb_crouch_start_7;
	var_00["exposed_crouch"][8] = %s1_cqb_crouch_start_8;
	var_00["exposed_crouch"][9] = %s1_cqb_crouch_start_9;
	var_00["exposed_crouch_cqb"][1] = %s1_cqb_crouch_start_1;
	var_00["exposed_crouch_cqb"][2] = %s1_cqb_crouch_start_2;
	var_00["exposed_crouch_cqb"][3] = %s1_cqb_crouch_start_3;
	var_00["exposed_crouch_cqb"][4] = %s1_cqb_crouch_start_4;
	var_00["exposed_crouch_cqb"][6] = %s1_cqb_crouch_start_6;
	var_00["exposed_crouch_cqb"][7] = %s1_cqb_crouch_start_7;
	var_00["exposed_crouch_cqb"][8] = %s1_cqb_crouch_start_8;
	var_00["exposed_crouch_cqb"][9] = %s1_cqb_crouch_start_9;
	var_00["exposed"] = [];
	var_00["exposed"][1] = %cqb_start_1;
	var_00["exposed"][2] = %s1_stand_2_run_180l;
	var_00["exposed"][3] = %cqb_start_3;
	var_00["exposed"][4] = %s1_stand_2_run_l;
	var_00["exposed"][6] = %s1_stand_2_run_r;
	var_00["exposed"][7] = %cqb_start_7;
	var_00["exposed"][8] = %s1_surprise_start_v1;
	var_00["exposed"][9] = %cqb_start_9;
	var_00["exposed_cqb"][1] = %cqb_start_1;
	var_00["exposed_cqb"][2] = %cqb_start_2;
	var_00["exposed_cqb"][3] = %cqb_start_3;
	var_00["exposed_cqb"][4] = %cqb_start_4;
	var_00["exposed_cqb"][6] = %cqb_start_6;
	var_00["exposed_cqb"][7] = %cqb_start_7;
	var_00["exposed_cqb"][8] = %cqb_start_8;
	var_00["exposed_cqb"][9] = %cqb_start_9;
	var_00["crouch"][1] = %s1_covercrouch_run_out_ml;
	var_00["crouch"][2] = %s1_covercrouch_run_out_m;
	var_00["crouch"][3] = %s1_covercrouch_run_out_mr;
	var_00["crouch"][4] = %s1_covercrouch_run_out_l;
	var_00["crouch"][6] = %s1_covercrouch_run_out_r;
	var_00["stand"][1] = %s1_coverstand_trans_out_ml;
	var_00["stand"][2] = %s1_coverstand_trans_out_m;
	var_00["stand"][3] = %s1_coverstand_trans_out_mr;
	var_00["stand"][4] = %s1_coverstand_trans_out_l;
	var_00["stand"][6] = %s1_coverstand_trans_out_r;
	level.archetypes["s1_soldier"]["cover_exit"] = var_00;
}

//Function Number: 3
init_s1_animset_cover_wall()
{
	var_00 = [];
	var_00["add_aim_up"] = %s1_covercrouch_aim8_add;
	var_00["add_aim_down"] = %s1_covercrouch_aim2_add;
	var_00["add_aim_left"] = %s1_covercrouch_aim4_add;
	var_00["add_aim_right"] = %s1_covercrouch_aim6_add;
	var_00["straight_level"] = %s1_covercrouch_aim5;
	var_00["hide_idle"] = %s1_covercrouch_hide_idle;
	var_00["hide_idle_twitch"] = animscripts\utility::array(%s1_covercrouch_twitch_1,%s1_covercrouch_twitch_2,%s1_covercrouch_twitch_3,%s1_covercrouch_twitch_4,%s1_covercrouch_twitch_5);
	var_00["hide_idle_flinch"] = animscripts\utility::array(%s1_covercrouch_explosion_1,%s1_covercrouch_explosion_2,%s1_covercrouch_explosion_3);
	var_00["hide_2_crouch"] = %s1_covercrouch_hide_2_aim;
	var_00["hide_2_stand"] = %s1_covercrouch_hide_2_stand;
	var_00["hide_2_lean"] = %s1_covercrouch_hide_2_lean;
	var_00["hide_2_right"] = %s1_covercrouch_hide_2_right;
	var_00["hide_2_left"] = %s1_covercrouch_hide_2_left;
	var_00["crouch_2_hide"] = %s1_covercrouch_aim_2_hide;
	var_00["stand_2_hide"] = %s1_covercrouch_stand_2_hide;
	var_00["lean_2_hide"] = %s1_covercrouch_lean_2_hide;
	var_00["right_2_hide"] = %s1_covercrouch_right_2_hide;
	var_00["left_2_hide"] = %s1_covercrouch_left_2_hide;
	var_00["crouch_aim"] = %s1_covercrouch_aim5;
	var_00["stand_aim"] = %s1_coverstand_aim_5;
	var_00["lean_aim"] = %s1_covercrouch_lean_aim5;
	var_00["fire"] = %s1_exposed_shoot_auto;
	var_00["semi2"] = %s1_exposed_shoot_semi2;
	var_00["semi3"] = %s1_exposed_shoot_semi3;
	var_00["semi4"] = %s1_exposed_shoot_semi4;
	var_00["semi5"] = %s1_exposed_shoot_semi5;
	var_00["single"] = [%s1_exposed_shoot_semi1];
	var_00["burst2"] = %s1_exposed_shoot_burst3;
	var_00["burst3"] = %s1_exposed_shoot_burst3;
	var_00["burst4"] = %s1_exposed_shoot_burst4;
	var_00["burst5"] = %s1_exposed_shoot_burst5;
	var_00["burst6"] = %s1_exposed_shoot_burst6;
	var_00["blind_fire"] = animscripts\utility::array(%s1_covercrouch_blindfire_1,%s1_covercrouch_blindfire_2,%s1_covercrouch_blindfire_3,%s1_covercrouch_blindfire_4);
	var_00["reload"] = %s1_covercrouch_reload_hide;
	var_00["grenade_safe"] = animscripts\utility::array(%s1_covercrouch_grenadea);
	var_00["grenade_exposed"] = animscripts\utility::array(%s1_covercrouch_grenadea);
	var_00["exposed_idle"] = animscripts\utility::array(%s1_exposed_idle_alert_v1,%s1_exposed_idle_alert_v2,%s1_exposed_idle_alert_v3);
	var_00["look"] = animscripts\utility::array(%s1_covercrouch_hide_look);
	level.archetypes["s1_soldier"]["cover_crouch"] = var_00;
	var_00 = [];
	var_00["add_aim_up"] = %s1_coverstandaim_aim8_add;
	var_00["add_aim_down"] = %s1_coverstandaim_aim2_add;
	var_00["add_aim_left"] = %s1_coverstandaim_aim4_add;
	var_00["add_aim_right"] = %s1_coverstandaim_aim6_add;
	var_00["straight_level"] = %s1_coverstand_aim_5;
	var_00["hide_idle"] = %s1_coverstand_hide_idle;
	var_00["hide_idle_twitch"] = animscripts\utility::array(%s1_coverstand_hide_idle_twitch01,%s1_coverstand_hide_idle_twitch02,%s1_coverstand_hide_idle_twitch03,%s1_coverstand_hide_idle_twitch04,%s1_coverstand_hide_idle_twitch05);
	var_00["hide_idle_flinch"] = animscripts\utility::array(%s1_coverstand_react01,%s1_coverstand_react02,%s1_coverstand_react03,%s1_coverstand_react04);
	var_00["hide_2_stand"] = %s1_coverstand_hide_2_aim;
	var_00["stand_2_hide"] = %s1_coverstand_aim_2_hide;
	var_00["hide_2_stand_tall"] = %coverstand_hide_2_aim;
	var_00["stand_tall_2_hide"] = %coverstand_aim_2_hide;
	var_00["smg_hide_2_stand"] = %smg_coverstand_hide_2_aim;
	var_00["smg_stand_2_hide"] = %smg_coverstand_aim_2_hide;
	var_00["hide_2_over"] = %s1_coverstand_2_coverstandaim;
	var_00["over_2_hide"] = %s1_coverstandaim_2_coverstand;
	var_00["over_aim"] = %s1_coverstand_aim_5;
	var_00["fire"] = %s1_coverstandaim_autofire;
	var_00["semi2"] = %s1_coverstandaim_fire;
	var_00["semi3"] = %s1_coverstandaim_fire;
	var_00["semi4"] = %s1_coverstandaim_fire;
	var_00["semi5"] = %s1_coverstandaim_fire;
	var_00["single"] = animscripts\utility::array(%s1_coverstandaim_fire);
	var_00["burst2"] = %s1_coverstandaim_autofire;
	var_00["burst3"] = %s1_coverstandaim_autofire;
	var_00["burst4"] = %s1_coverstandaim_autofire;
	var_00["burst5"] = %s1_coverstandaim_autofire;
	var_00["burst6"] = %s1_coverstandaim_autofire;
	var_00["blind_fire"] = animscripts\utility::array(%s1_coverstand_blindfire_1,%s1_coverstand_blindfire_2);
	var_00["reload"] = %s1_coverstand_reloada;
	var_00["look"] = animscripts\utility::array(%s1_coverstand_look_quick,%s1_coverstand_look_quick_v2);
	var_00["grenade_safe"] = animscripts\utility::array(%s1_coverstand_grenadea,%s1_coverstand_grenadeb);
	var_00["grenade_exposed"] = animscripts\utility::array(%s1_coverstand_grenadea,%s1_coverstand_grenadeb);
	var_00["exposed_idle"] = animscripts\utility::array(%s1_exposed_idle_alert_v1,%s1_exposed_idle_alert_v2,%s1_exposed_idle_alert_v3);
	var_00["hide_to_look"] = %s1_coverstand_look_moveup;
	var_00["look_idle"] = %s1_coverstand_look_idle;
	var_00["look_to_hide"] = %s1_coverstand_look_movedown;
	var_00["look_to_hide_fast"] = %s1_coverstand_look_movedown_fast;
	level.archetypes["s1_soldier"]["cover_stand"] = var_00;
}

//Function Number: 4
set_s1_animarray_burst_and_semi_fire_stand()
{
	level.initanimset["burst2"] = %s1_exposed_shoot_burst3;
	level.initanimset["burst3"] = %s1_exposed_shoot_burst3;
	level.initanimset["burst4"] = %s1_exposed_shoot_burst4;
	level.initanimset["burst5"] = %s1_exposed_shoot_burst5;
	level.initanimset["burst6"] = %s1_exposed_shoot_burst6;
	level.initanimset["semi2"] = %s1_exposed_shoot_semi2;
	level.initanimset["semi3"] = %s1_exposed_shoot_semi3;
	level.initanimset["semi4"] = %s1_exposed_shoot_semi4;
	level.initanimset["semi5"] = %s1_exposed_shoot_semi5;
}

//Function Number: 5
init_s1_animset_melee()
{
	var_00 = [];
	var_00["standard"] = %s1_melee_1;
	var_00["standard_stand_to_melee"] = %s1_stand_2_melee_1;
	var_00["standard_run_to_melee"] = %s1_run_2_melee_charge;
	var_00["aivai_exposed_attackerwins_attack"] = %s1_melee_f_awin_attack;
	var_00["aivai_exposed_attackerwins_defend"] = %s1_melee_f_awin_defend;
	var_00["aivai_exposed_attackerwins_defend_survive"] = %s1_melee_f_awin_defend_survive;
	var_00["aivai_exposed_defenderwins_attack"] = %s1_melee_f_dwin_attack;
	var_00["aivai_exposed_defenderwins_defend"] = %s1_melee_f_dwin_defend;
	var_00["aivai_wrestle_attackerwins_attack"] = %bog_melee_r_attack;
	var_00["aivai_wrestle_attackerwins_defend"] = %bog_melee_r_defend;
	var_00["aivai_wrestle_attackerwins_defend_survive"] = %bog_melee_r_backdeath2;
	var_00["aivai_behind_attackerwins_attack"] = %s1_melee_sync_attack;
	var_00["aivai_behind_attackerwins_defend"] = %s1_melee_sync_defend;
	var_00["aivai_coverleft_attackerwins_attack"] = %s1_cornersdl_melee_wina_attacker;
	var_00["aivai_coverleft_attackerwins_defend"] = %s1_cornersdl_melee_wina_defender;
	var_00["aivai_coverleft_attackerwins_defend_survive"] = %s1_cornersdl_melee_wina_defender_survive;
	var_00["aivai_coverleft_defenderwins_attack"] = %s1_cornersdl_melee_wind_attacker;
	var_00["aivai_coverleft_defenderwins_attack_survive"] = %s1_cornersdl_melee_wind_attacker_survive;
	var_00["aivai_coverleft_defenderwins_defend"] = %s1_cornersdl_melee_wind_defender;
	var_00["aivai_coverright_attackerwins_attack"] = %s1_cornersdr_melee_wina_attacker;
	var_00["aivai_coverright_attackerwins_defend"] = %s1_cornersdr_melee_wina_defender;
	var_00["aivai_coverright_defenderwins_attack"] = %s1_cornersdr_melee_wind_attacker;
	var_00["aivai_coverright_defenderwins_defend"] = %s1_cornersdr_melee_wind_defender;
	level.archetypes["s1_soldier"]["melee"] = var_00;
}

//Function Number: 6
set_s1_animarray_stance_change()
{
	level.initanimset["crouch_2_stand"] = %s1_exposed_crouch_2_stand;
	level.initanimset["stand_2_crouch"] = %s1_exposed_stand_2_crouch;
}

//Function Number: 7
init_s1_animset_default_stand()
{
	anim.initanimset = [];
	level.initanimset["add_aim_up"] = %s1_exposed_aim_8;
	level.initanimset["add_aim_down"] = %s1_exposed_aim_2;
	level.initanimset["add_aim_left"] = %s1_exposed_aim_4;
	level.initanimset["add_aim_right"] = %s1_exposed_aim_6;
	level.initanimset["straight_level"] = %s1_exposed_aim_5;
	level.initanimset["fire"] = %s1_exposed_shoot_auto_v3;
	level.initanimset["fire_corner"] = %s1_exposed_shoot_auto_v2;
	level.initanimset["single"] = animscripts\utility::array(%s1_exposed_shoot_semi1);
	set_s1_animarray_burst_and_semi_fire_stand();
	level.initanimset["exposed_idle"] = [%s1_exposed_idle_alert_v1,%s1_exposed_idle_alert_v2,%s1_exposed_idle_alert_v3,%s1_exposed_idle_alert_v4,%s1_exposed_idle_alert_v5];
	level.initanimset["exposed_grenade"] = [%s1_exposed_grenadethrowb,%s1_exposed_grenadethrowc];
	level.initanimset["reload"] = [%s1_exposed_reload,%s1_exposed_reloadc];
	level.initanimset["reload_crouchhide"] = animscripts\utility::array(%s1_exposed_reloadb);
	set_s1_animarray_stance_change();
	set_s1_animarray_standing_turns();
	set_s1_animarray_add_turn_aims_stand();
	level.archetypes["s1_soldier"]["default_stand"] = level.initanimset;
}

//Function Number: 8
init_s1_animset_cover_right()
{
	var_00 = [];
	var_00["alert_idle"] = %s1_corner_standr_alert_idle;
	var_00["alert_idle_twitch"] = [%s1_corner_standr_alert_twitch01,%s1_corner_standr_alert_twitch02,%s1_corner_standr_alert_twitch04,%s1_corner_standr_alert_twitch05,%s1_corner_standr_alert_twitch06,%s1_corner_standr_alert_twitch07];
	var_00["alert_idle_flinch"] = [%s1_corner_standr_flinch,%s1_corner_standr_flinchb];
	var_00["alert_to_C"] = %s1_corner_standr_trans_alert_2_c;
	var_00["B_to_C"] = %s1_corner_standr_trans_b_2_c;
	var_00["C_to_alert"] = %s1_corner_standr_trans_c_2_alert;
	var_00["C_to_B"] = %s1_corner_standr_trans_c_2_b;
	var_00["alert_to_A"] = [%s1_corner_standr_trans_alert_2_a,%s1_corner_standr_trans_alert_2_a_v2];
	var_00["alert_to_B"] = [%s1_corner_standr_trans_alert_2_b,%s1_corner_standr_trans_alert_2_b_v2,%s1_corner_standr_trans_alert_2_b_v3];
	var_00["A_to_alert"] = [%s1_corner_standr_trans_a_2_alert_v2];
	var_00["A_to_alert_reload"] = [];
	var_00["A_to_B"] = [%s1_corner_standr_trans_a_2_b,%s1_corner_standr_trans_a_2_b_v2];
	var_00["B_to_alert"] = [%s1_corner_standr_trans_b_2_alert,%s1_corner_standr_trans_b_2_alert_v2,%s1_corner_standr_trans_b_2_alert_v3];
	var_00["B_to_alert_reload"] = [%s1_corner_standr_reload_b_2_alert];
	var_00["B_to_A"] = [%s1_corner_standr_trans_b_2_a,%s1_corner_standr_trans_b_2_a_v2];
	var_00["lean_to_alert"] = [%s1_cornerstndr_lean_2_alert];
	var_00["alert_to_lean"] = [%s1_cornerstndr_alert_2_lean];
	var_00["look"] = %s1_corner_standr_look;
	var_00["reload"] = [%s1_corner_standr_reload_v1];
	var_00["grenade_exposed"] = %s1_corner_standr_grenade_a;
	var_00["grenade_safe"] = %s1_corner_standr_grenade_b;
	var_00["blind_fire"] = [%s1_corner_standr_blindfire_v1,%s1_corner_standr_blindfire_v2];
	var_00["alert_to_look"] = %s1_corner_standr_alert_2_look;
	var_00["look_to_alert"] = %s1_corner_standr_look_2_alert;
	var_00["look_to_alert_fast"] = %s1_corner_standr_look_2_alert_fast;
	var_00["look_idle"] = %s1_corner_standr_look_idle;
	var_00["stance_change"] = %s1_cornercrr_stand_2_alert;
	var_00["lean_aim_down"] = %s1_cornerstndr_lean_aim_2;
	var_00["lean_aim_left"] = %s1_cornerstndr_lean_aim_4;
	var_00["lean_aim_straight"] = %s1_cornerstndr_lean_aim_5;
	var_00["lean_aim_right"] = %s1_cornerstndr_lean_aim_6;
	var_00["lean_aim_up"] = %s1_cornerstndr_lean_aim_8;
	var_00["lean_reload"] = %s1_cornerstndr_lean_reload;
	var_00["lean_idle"] = [%s1_cornerstndr_lean_idle];
	var_00["lean_single"] = %s1_cornerstndr_lean_fire;
	var_00["lean_burst"] = %s1_cornerstndr_lean_autoburst;
	var_00["lean_fire"] = %s1_cornerstndr_lean_auto;
	level.archetypes["s1_soldier"]["cover_right_stand"] = var_00;
	var_00 = [];
	var_00["alert_idle"] = %s1_cornercrr_alert_idle;
	var_00["alert_idle_twitch"] = [%s1_cornercrr_alert_twitch_v1,%s1_cornercrr_alert_twitch_v2,%s1_cornercrr_alert_twitch_v3];
	var_00["alert_idle_flinch"] = [];
	var_00["alert_to_A"] = [%s1_cornercrr_trans_alert_2_a];
	var_00["alert_to_B"] = [%s1_cornercrr_trans_alert_2_b];
	var_00["A_to_alert"] = [%s1_cornercrr_trans_a_2_alert];
	var_00["A_to_alert_reload"] = [];
	var_00["A_to_B"] = [%s1_cornercrr_trans_a_2_b];
	var_00["B_to_alert"] = [%s1_cornercrr_trans_b_2_alert];
	var_00["B_to_alert_reload"] = [];
	var_00["B_to_A"] = [%s1_cornercrr_trans_b_2_a];
	var_00["lean_to_alert"] = [%s1_cornercrr_lean_2_alert];
	var_00["alert_to_lean"] = [%s1_cornercrr_alert_2_lean];
	var_00["reload"] = [%s1_cornercrr_reloada,%s1_cornercrr_reloadb];
	var_00["grenade_exposed"] = %s1_cornercrr_grenadea;
	var_00["grenade_safe"] = %s1_cornercrr_grenadea;
	var_00["alert_to_over"] = [%s1_cornercrr_alert_2_over];
	var_00["over_to_alert"] = [%s1_cornercrr_over_2_alert];
	var_00["over_to_alert_reload"] = [];
	var_00["blind_fire"] = [];
	var_00["rambo90"] = [];
	var_00["rambo45"] = [];
	var_00["alert_to_look"] = %s1_cornercrr_alert_2_look;
	var_00["look_to_alert"] = %s1_cornercrr_look_2_alert;
	var_00["look_to_alert_fast"] = %s1_cornercrr_look_2_alert_fast;
	var_00["look_idle"] = %s1_cornercrr_look_idle;
	var_00["stance_change"] = %s1_cornercrr_alert_2_stand;
	var_00["lean_aim_down"] = %s1_cornercrr_lean_aim_2;
	var_00["lean_aim_left"] = %s1_cornercrr_lean_aim_4;
	var_00["lean_aim_straight"] = %s1_cornercrr_lean_aim_5;
	var_00["lean_aim_right"] = %s1_cornercrr_lean_aim_6;
	var_00["lean_aim_up"] = %s1_cornercrr_lean_aim_8;
	var_00["lean_reload"] = %s1_cornerstndr_lean_reload;
	var_00["lean_idle"] = [%s1_cornercrr_lean_idle];
	var_00["lean_single"] = %s1_cornercrr_lean_fire;
	var_00["lean_fire"] = %s1_cornercrr_lean_auto;
	level.archetypes["s1_soldier"]["cover_right_crouch"] = var_00;
}

//Function Number: 9
init_s1_animset_cover_left()
{
	var_00 = [];
	var_00["alert_idle"] = %s1_corner_standl_alert_idle;
	var_00["alert_idle_twitch"] = [%s1_corner_standl_alert_twitch01,%s1_corner_standl_alert_twitch02,%s1_corner_standl_alert_twitch03,%s1_corner_standl_alert_twitch04,%s1_corner_standl_alert_twitch05,%s1_corner_standl_alert_twitch06,%s1_corner_standl_alert_twitch07];
	var_00["alert_idle_flinch"] = [%s1_corner_standl_flinch];
	var_00["alert_to_C"] = %s1_corner_standl_trans_alert_2_c;
	var_00["B_to_C"] = %s1_corner_standl_trans_b_2_c;
	var_00["C_to_alert"] = %s1_corner_standl_trans_c_2_alert;
	var_00["C_to_B"] = %s1_corner_standl_trans_c_2_b;
	var_00["alert_to_A"] = [%s1_corner_standl_trans_alert_2_a,%s1_corner_standl_trans_alert_2_a_v2];
	var_00["alert_to_B"] = [%s1_corner_standl_trans_alert_2_b_v2];
	var_00["A_to_alert"] = [%s1_corner_standl_trans_a_2_alert_v2];
	var_00["A_to_alert_reload"] = [];
	var_00["A_to_B"] = [%s1_corner_standl_trans_a_2_b_v2];
	var_00["B_to_alert"] = [%s1_corner_standl_trans_b_2_alert_v2];
	var_00["B_to_alert_reload"] = [%s1_corner_standl_reload_b_2_alert];
	var_00["B_to_A"] = [%s1_corner_standl_trans_b_2_a_v2];
	var_00["lean_to_alert"] = [%s1_cornerstndl_lean_2_alert];
	var_00["alert_to_lean"] = [%s1_cornerstndl_alert_2_lean];
	var_00["look"] = %s1_corner_standl_look;
	var_00["reload"] = [%s1_corner_standl_reload_v1];
	var_00["grenade_exposed"] = %s1_corner_standl_grenade_a;
	var_00["grenade_safe"] = %s1_corner_standl_grenade_b;
	var_00["blind_fire"] = [%s1_corner_standl_blindfire_v1,%s1_corner_standl_blindfire_v2];
	var_00["alert_to_look"] = %s1_corner_standl_alert_2_look;
	var_00["look_to_alert"] = %s1_corner_standl_look_2_alert;
	var_00["look_to_alert_fast"] = %s1_corner_standl_look_2_alert_fast_v1;
	var_00["look_idle"] = %s1_corner_standl_look_idle;
	var_00["stance_change"] = %s1_cornercrl_stand_2_alert;
	var_00["lean_aim_down"] = %s1_cornerstndl_lean_aim_2;
	var_00["lean_aim_left"] = %s1_cornerstndl_lean_aim_4;
	var_00["lean_aim_straight"] = %s1_cornerstndl_lean_aim_5;
	var_00["lean_aim_right"] = %s1_cornerstndl_lean_aim_6;
	var_00["lean_aim_up"] = %s1_cornerstndl_lean_aim_8;
	var_00["lean_reload"] = %s1_cornerstndl_lean_reload;
	var_00["lean_idle"] = [%s1_cornerstndl_lean_idle];
	var_00["lean_single"] = %s1_cornerstndl_lean_fire;
	var_00["lean_burst"] = %s1_cornerstndl_lean_autoburst;
	var_00["lean_fire"] = %s1_cornerstndl_lean_auto;
	level.archetypes["s1_soldier"]["cover_left_stand"] = var_00;
	var_00 = [];
	var_00["alert_idle"] = %s1_cornercrl_alert_idle;
	var_00["alert_idle_twitch"] = [];
	var_00["alert_idle_flinch"] = [];
	var_00["alert_to_A"] = [%s1_cornercrl_trans_alert_2_a];
	var_00["alert_to_B"] = [%s1_cornercrl_trans_alert_2_b];
	var_00["A_to_alert"] = [%s1_cornercrl_trans_a_2_alert];
	var_00["A_to_alert_reload"] = [];
	var_00["A_to_B"] = [%s1_cornercrl_trans_a_2_b];
	var_00["B_to_alert"] = [%s1_cornercrl_trans_b_2_alert];
	var_00["B_to_alert_reload"] = [];
	var_00["B_to_A"] = [%s1_cornercrl_trans_b_2_a];
	var_00["lean_to_alert"] = [%s1_cornercrl_lean_2_alert];
	var_00["alert_to_lean"] = [%s1_cornercrl_alert_2_lean];
	var_00["look"] = %s1_cornercrl_look_fast;
	var_00["reload"] = [%s1_cornercrl_reloada,%s1_cornercrl_reloadb];
	var_00["grenade_safe"] = %s1_cornercrl_grenadea;
	var_00["grenade_exposed"] = %s1_cornercrl_grenadeb;
	var_00["alert_to_over"] = [%s1_cornercrl_alert_2_over];
	var_00["over_to_alert"] = [%s1_cornercrl_over_2_alert];
	var_00["over_to_alert_reload"] = [];
	var_00["blind_fire"] = [];
	var_00["rambo90"] = [];
	var_00["rambo45"] = [];
	var_00["alert_to_look"] = %s1_cornercrl_alert_2_look;
	var_00["look_to_alert"] = %s1_cornercrl_look_2_alert;
	var_00["look_to_alert_fast"] = %s1_cornercrl_look_2_alert;
	var_00["look_idle"] = %s1_cornercrl_alert_idle;
	var_00["stance_change"] = %s1_cornercrl_alert_2_stand;
	var_00["lean_aim_down"] = %s1_cornercrl_lean_aim_2;
	var_00["lean_aim_left"] = %s1_cornercrl_lean_aim_4;
	var_00["lean_aim_straight"] = %s1_cornercrl_lean_aim_5;
	var_00["lean_aim_right"] = %s1_cornercrl_lean_aim_6;
	var_00["lean_aim_up"] = %s1_cornercrl_lean_aim_8;
	var_00["lean_idle"] = [%s1_cornercrl_lean_idle];
	var_00["lean_single"] = %s1_cornercrl_lean_fire;
	var_00["lean_fire"] = %s1_cornercrl_lean_auto;
	level.archetypes["s1_soldier"]["cover_left_crouch"] = var_00;
}

//Function Number: 10
init_s1_animset_run_n_gun()
{
	anim.initanimset = [];
	level.initanimset["F"] = %s1_run_n_gun_f;
	level.initanimset["L"] = %s1_run_n_gun_l;
	level.initanimset["R"] = %s1_run_n_gun_r;
	level.initanimset["LB"] = %s1_run_n_gun_l_120;
	level.initanimset["RB"] = %s1_run_n_gun_r_120;
	level.initanimset["move_back"] = %s1_combatwalk_b;
	level.archetypes["s1_soldier"]["run_n_gun"] = level.initanimset;
}

//Function Number: 11
init_s1_animset_default_crouch()
{
	anim.initanimset = [];
	set_s1_animarray_crouch_aim();
	level.initanimset["fire"] = %s1_exposed_crouch_shoot_auto_v2;
	level.initanimset["single"] = animscripts\utility::array(%s1_exposed_crouch_shoot_semi1);
	set_s1_animarray_burst_and_semi_fire_crouch();
	level.initanimset["reload"] = animscripts\utility::array(%s1_exposed_crouch_reload);
	level.initanimset["exposed_idle"] = animscripts\utility::array(%s1_exposed_crouch_idle_alert_v1,%s1_exposed_crouch_idle_alert_v2,%s1_exposed_crouch_idle_alert_v3);
	set_s1_animarray_stance_change();
	set_s1_animarray_crouching_turns();
	set_s1_animarray_add_turn_aims_crouch();
	level.archetypes["s1_soldier"]["default_crouch"] = level.initanimset;
}

//Function Number: 12
init_s1_animset_smg_crouch()
{
	anim.initanimset = [];
	set_s1_animarray_crouch_aim();
	level.initanimset["fire"] = %s1_exposed_crouch_shoot_auto_v2;
	level.initanimset["single"] = animscripts\utility::array(%s1_exposed_crouch_shoot_semi1);
	set_s1_animarray_burst_and_semi_fire_crouch();
	level.initanimset["reload"] = animscripts\utility::array(%s1_exposed_crouch_reload);
	level.initanimset["exposed_idle"] = animscripts\utility::array(%s1_exposed_crouch_idle_alert_v1,%s1_exposed_crouch_idle_alert_v2,%s1_exposed_crouch_idle_alert_v3);
	set_s1_animarray_stance_change_smg();
	set_s1_animarray_crouching_turns();
	set_s1_animarray_add_turn_aims_crouch();
	level.archetypes["s1_soldier"]["smg_crouch"] = level.initanimset;
}

//Function Number: 13
set_s1_animarray_stance_change_smg()
{
	level.initanimset["crouch_2_stand"] = %smg_exposed_crouch_2_stand;
	level.initanimset["crouch_2_prone"] = %crouch_2_prone;
	level.initanimset["stand_2_crouch"] = %smg_exposed_stand_2_crouch;
	level.initanimset["stand_2_prone"] = %stand_2_prone;
	level.initanimset["prone_2_crouch"] = %prone_2_crouch;
	level.initanimset["prone_2_stand"] = %prone_2_stand;
}

//Function Number: 14
set_s1_animarray_crouch_aim()
{
	level.initanimset["add_aim_up"] = %s1_exposed_crouch_aim_8;
	level.initanimset["add_aim_down"] = %s1_exposed_crouch_aim_2;
	level.initanimset["add_aim_left"] = %s1_exposed_crouch_aim_4;
	level.initanimset["add_aim_right"] = %s1_exposed_crouch_aim_6;
	level.initanimset["straight_level"] = %s1_exposed_crouch_aim_5;
}

//Function Number: 15
set_s1_animarray_burst_and_semi_fire_crouch()
{
	level.initanimset["burst2"] = %s1_exposed_crouch_shoot_burst3;
	level.initanimset["burst3"] = %s1_exposed_crouch_shoot_burst3;
	level.initanimset["burst4"] = %s1_exposed_crouch_shoot_burst4;
	level.initanimset["burst5"] = %s1_exposed_crouch_shoot_burst5;
	level.initanimset["burst6"] = %s1_exposed_crouch_shoot_burst6;
	level.initanimset["semi2"] = %s1_exposed_crouch_shoot_semi2;
	level.initanimset["semi3"] = %s1_exposed_crouch_shoot_semi3;
	level.initanimset["semi4"] = %s1_exposed_crouch_shoot_semi4;
	level.initanimset["semi5"] = %s1_exposed_crouch_shoot_semi5;
}

//Function Number: 16
set_s1_animarray_crouching_turns()
{
	level.initanimset["turn_left_45"] = %s1_exposed_crouch_turn_90_left;
	level.initanimset["turn_left_90"] = %s1_exposed_crouch_turn_90_left;
	level.initanimset["turn_left_135"] = %s1_exposed_crouch_turn_180_left;
	level.initanimset["turn_left_180"] = %s1_exposed_crouch_turn_180_left;
	level.initanimset["turn_right_45"] = %s1_exposed_crouch_turn_90_right;
	level.initanimset["turn_right_90"] = %s1_exposed_crouch_turn_90_right;
	level.initanimset["turn_right_135"] = %s1_exposed_crouch_turn_180_right;
	level.initanimset["turn_right_180"] = %s1_exposed_crouch_turn_180_right;
}

//Function Number: 17
set_s1_animarray_add_turn_aims_crouch()
{
	level.initanimset["add_turn_aim_up"] = %s1_exposed_crouch_turn_aim_8;
	level.initanimset["add_turn_aim_down"] = %s1_exposed_crouch_turn_aim_2;
	level.initanimset["add_turn_aim_left"] = %s1_exposed_crouch_turn_aim_4;
	level.initanimset["add_turn_aim_right"] = %s1_exposed_crouch_turn_aim_6;
}

//Function Number: 18
init_s1_animset_cqb_stand()
{
	anim.initanimset = [];
	level.initanimset["add_aim_up"] = %s1_exposed_aim_8;
	level.initanimset["add_aim_down"] = %s1_exposed_aim_2;
	level.initanimset["add_aim_left"] = %s1_exposed_aim_4;
	level.initanimset["add_aim_right"] = %s1_exposed_aim_6;
	level.initanimset["straight_level"] = %s1_exposed_aim_5;
	level.initanimset["fire"] = %s1_exposed_shoot_auto_v2;
	level.initanimset["single"] = animscripts\utility::array(%s1_exposed_shoot_semi1);
	set_s1_animarray_burst_and_semi_fire_stand();
	level.initanimset["exposed_idle"] = [%s1_exposed_idle_alert_v5,%s1_exposed_idle_alert_v4,%s1_exposed_idle_alert_v1,%s1_exposed_idle_alert_v2,%s1_exposed_idle_alert_v3];
	level.initanimset["reload"] = [%s1_exposed_reload,%s1_exposed_reloadc];
	level.initanimset["reload_crouchhide"] = animscripts\utility::array(%s1_exposed_reloadb);
	set_s1_animarray_stance_change();
	set_s1_animarray_standing_turns();
	set_s1_animarray_add_turn_aims_stand();
	level.archetypes["s1_soldier"]["cqb_stand"] = level.initanimset;
}

//Function Number: 19
init_s1_animset_run_move()
{
	anim.initanimset = [];
	level.initanimset["sprint"] = %s1_sprint1_loop;
	level.initanimset["sprint_short"] = %s1_sprint1_loop;
	level.initanimset["straight"] = %s1_run_lowready_f;
	level.initanimset["move_f"] = %s1_combatwalk_f;
	level.initanimset["move_l"] = %s1_combatwalk_l;
	level.initanimset["move_r"] = %s1_combatwalk_r;
	level.initanimset["move_b"] = %s1_combatwalk_b;
	level.archetypes["s1_soldier"]["run"] = level.initanimset;
}

//Function Number: 20
init_s1_animset_walk_move()
{
	anim.initanimset = [];
	level.initanimset["sprint"] = %s1_sprint1_loop;
	level.initanimset["sprint_short"] = %s1_run_lowready_f;
	level.initanimset["straight"] = %s1_combatwalk_f;
	level.initanimset["move_f"] = %s1_combatwalk_f;
	level.initanimset["move_l"] = %s1_combatwalk_l;
	level.initanimset["move_r"] = %s1_combatwalk_r;
	level.initanimset["move_b"] = %s1_combatwalk_b;
	level.initanimset["aim_2"] = %s1_combatwalk_f_aim2;
	level.initanimset["aim_4"] = %s1_combatwalk_f_aim4;
	level.initanimset["aim_6"] = %s1_combatwalk_f_aim6;
	level.initanimset["aim_8"] = %s1_combatwalk_f_aim8;
	level.archetypes["s1_soldier"]["walk"] = level.initanimset;
}

//Function Number: 21
set_s1_animarray_add_turn_aims_stand()
{
	level.initanimset["add_turn_aim_up"] = %exposed_turn_aim_8;
	level.initanimset["add_turn_aim_down"] = %exposed_turn_aim_2;
	level.initanimset["add_turn_aim_left"] = %exposed_turn_aim_4;
	level.initanimset["add_turn_aim_right"] = %exposed_turn_aim_6;
}

//Function Number: 22
init_s1_animset_death()
{
	var_00 = [];
	var_00["running_forward"] = [%s1_run_death_facedown,%s1_run_death_roll,%s1_run_death_fallonback,%run_death_flop];
	var_00["running_forward_f"] = [%s1_run_death_fallonback];
	var_00["cover_stand"] = [%s1_coverstand_death_left,%s1_coverstand_death_right];
	var_00["dying_crawl_crouch"] = [%s1_dying_back_death_v2,%s1_dying_back_death_v3,%s1_dying_back_death_v4];
	var_00["stand_lower_body"] = [%s1_exposed_death_groin,%s1_stand_death_leg];
	var_00["stand_lower_body_extended"] = [%s1_exposed_death_groin,%stand_death_guts];
	var_00["stand_head"] = [%s1_exposed_death_headtwist,%s1_exposed_death_flop];
	var_00["stand_neck"] = [%s1_exposed_death_neckgrab];
	var_00["stand_back"] = [%s1_exposed_death_falltoknees_02];
	var_00["stand_default"] = [%s1_exposed_death_02,%s1_exposed_death_nerve];
	var_00["stand_default_firing"] = [%s1_exposed_death_firing_02,%s1_exposed_death_firing];
	var_00["stand_backup_default"] = %s1_exposed_death;
	level.archetypes["s1_soldier"]["death"] = var_00;
}

//Function Number: 23
init_s1_animset_combat()
{
	var_00 = [];
	var_00["surprise_stop"] = %s1_surprise_stop_v1;
	var_00["trans_to_combat"] = %s1_casual_stand_idle_trans_out;
	var_00["trans_from_crouch_r"] = %s1_cornercrr_2_exposed_crouch;
	var_00["trans_from_crouch_l"] = %s1_cornercrl_2_exposed_crouch;
	var_00["trans_to_crouch_l"] = %s1_exposed_crouch_2_cornercrl;
	var_00["trans_to_crouch_r"] = %s1_exposed_crouch_2_cornercrr;
	level.archetypes["s1_soldier"]["combat"] = var_00;
}

//Function Number: 24
init_s1_animset_pain()
{
	var_00 = [];
	var_00["run_long"] = [%s1_run_pain_leg,%s1_run_pain_shoulder,%s1_run_pain_stomach_stumble,%s1_run_pain_head,%s1_run_pain_fallonknee_02,%s1_run_pain_stomach,%s1_run_pain_stumble,%s1_run_pain_stomach_fast,%s1_run_pain_leg_fast,%s1_run_pain_fall];
	var_00["run_medium"] = [%s1_run_pain_fallonknee_02,%s1_run_pain_stomach,%s1_run_pain_stumble,%s1_run_pain_stomach_fast,%s1_run_pain_leg_fast,%s1_run_pain_fall];
	var_00["run_short"] = [%s1_run_pain_fallonknee,%s1_run_pain_fallonknee_03];
	var_00["cover_left_stand"] = [%s1_corner_standl_painb,%s1_corner_standl_painc,%s1_corner_standl_paind,%s1_corner_standl_paine];
	var_00["cover_right_crouch"] = [%s1_cornercrr_alert_paina,%s1_cornercrr_alert_painb,%s1_cornercrr_alert_painc];
	var_00["cover_right_stand_B"] = %s1_corner_standr_pain_b_2_alert;
	var_00["cover_left_stand_A"] = %s1_corner_standl_pain_a_2_alert;
	var_00["cover_left_stand_B"] = %s1_corner_standl_pain_b_2_alert;
	level.archetypes["s1_soldier"]["pain"] = var_00;
	var_00 = [];
	var_00["prone_transition"] = [%s1_dying_crawl_2_back];
	var_00["stand_transition"] = [%s1_dying_stand_2_back_v1,%s1_dying_stand_2_back_v2];
	var_00["crouch_transition"] = [%s1_dying_crouch_2_back];
	var_00["default_transition"] = %s1_dying_crawl_2_back;
	var_00["stand_2_crawl"] = [%s1_dying_stand_2_crawl_v1,%s1_dying_stand_2_crawl_v2,%s1_dying_stand_2_crawl_v3];
	var_00["crouch_2_crawl"] = [%s1_dying_crouch_2_crawl];
	var_00["crawl"] = %s1_dying_crawl;
	var_00["death"] = [%s1_dying_crawl_death_v1,%s1_dying_crawl_death_v2];
	var_00["back_idle"] = %s1_dying_back_idle;
	var_00["back_crawl"] = %s1_dying_crawl_back;
	var_00["back_fire"] = %s1_dying_back_fire;
	var_00["back_death"] = [%s1_dying_back_death_v1];
	var_00["aim_4"] = %s1_dying_back_aim_4;
	var_00["aim_6"] = %s1_dying_back_aim_6;
	level.archetypes["s1_soldier"]["crawl_death"] = var_00;
	var_00 = [];
	var_00["premature_death"] = [%s1_dying_back_death_v1,%s1_dying_back_death_v2,%s1_dying_back_death_v3,%s1_dying_back_death_v4];
	level.archetypes["s1_soldier"]["corner_grenade_death"] = var_00;
}

//Function Number: 25
init_s1_animset_default_move()
{
	var_00 = [];
	var_00["fire"] = %s1_exposed_shoot_auto_v3;
	var_00["single"] = [%s1_exposed_shoot_semi1];
	var_00["single_shotgun"] = [%shotgun_stand_fire_1a,%shotgun_stand_fire_1b];
	var_00["burst2"] = %s1_exposed_shoot_burst3;
	var_00["burst3"] = %s1_exposed_shoot_burst3;
	var_00["burst4"] = %s1_exposed_shoot_burst4;
	var_00["burst5"] = %s1_exposed_shoot_burst5;
	var_00["burst6"] = %s1_exposed_shoot_burst6;
	var_00["semi2"] = %s1_exposed_shoot_semi2;
	var_00["semi3"] = %s1_exposed_shoot_semi3;
	var_00["semi4"] = %s1_exposed_shoot_semi4;
	var_00["semi5"] = %s1_exposed_shoot_semi5;
	level.archetypes["s1_soldier"]["shoot_while_moving"] = var_00;
	var_00 = [];
	var_00["shuffle_start_from_cover_left"] = %s1_cornercrl_alert_2_shuffle;
	var_00["shuffle_start_from_cover_right"] = %s1_cornercrr_alert_2_shuffle;
	var_00["shuffle_start_left"] = %s1_covercrouch_hide_2_shufflel;
	var_00["shuffle_start_right"] = %s1_covercrouch_hide_2_shuffler;
	var_00["shuffle_to_cover_left"] = %s1_covercrouch_shufflel;
	var_00["shuffle_end_to_cover_left"] = %s1_cornercrl_shuffle_2_alert;
	var_00["shuffle_to_cover_right"] = %s1_covercrouch_shuffler;
	var_00["shuffle_end_to_cover_right"] = %s1_cornercrr_shuffle_2_alert;
	var_00["shuffle_start_left_stand_to_stand"] = %s1_coverstand_hide_2_shufflel;
	var_00["shuffle_left_stand_to_stand"] = %s1_coverstand_shufflel;
	var_00["shuffle_end_left_stand_to_stand"] = %s1_coverstand_shufflel_2_hide;
	var_00["shuffle_start_right_stand_to_stand"] = %s1_coverstand_hide_2_shuffler;
	var_00["shuffle_right_stand_to_stand"] = %s1_coverstand_shuffler;
	var_00["shuffle_end_right_stand_to_stand"] = %s1_coverstand_shuffler_2_hide;
	var_00["shuffle_to_left_crouch"] = %s1_covercrouch_shufflel;
	var_00["shuffle_end_to_left_stand"] = %s1_coverstand_shufflel_2_hide;
	var_00["shuffle_end_to_left_crouch"] = %s1_covercrouch_shufflel_2_hide;
	var_00["shuffle_to_right_crouch"] = %s1_covercrouch_shuffler;
	var_00["shuffle_end_to_right_stand"] = %s1_coverstand_shuffler_2_hide;
	var_00["shuffle_end_to_right_crouch"] = %s1_covercrouch_shuffler_2_hide;
	level.archetypes["s1_soldier"]["shuffle"] = var_00;
}

//Function Number: 26
init_s1_animset_idle()
{
	var_00 = [];
	var_00["stand"][0] = [%s1_casual_stand_idle,%s1_casual_stand_idle_twitch,%s1_casual_stand_idle_twitchb];
	var_00["stand"][1] = [%s1_casual_stand_idle_twitch,%s1_casual_stand_idle_twitch,%s1_casual_stand_v2_twitch_talk,%s1_casual_stand_v2_twitch_talk];
	var_00["stand_cqb"][0] = [%cqb_stand_idle,%cqb_stand_twitch];
	var_00["crouch"][0] = [%casual_crouch_idle];
	level.archetypes["s1_soldier"]["idle"] = var_00;
	var_00 = [];
	var_00["stand"][0] = [2,1,1];
	var_00["stand"][1] = [10,0,0,4];
	var_00["stand_cqb"][0] = [2,1];
	var_00["crouch"][0] = [6];
	level.archetypes["s1_soldier"]["idle_weights"] = var_00;
	var_00 = [];
	var_00["stand"] = %s1_casual_stand_idle_trans_in;
	var_00["crouch"] = %s1_casual_crouch_idle_in;
	var_00["stand_smg"] = %smg_casual_stand_idle_trans_in;
	level.archetypes["s1_soldier"]["idle_transitions"] = var_00;
}

//Function Number: 27
init_s1_moving_turn_animations()
{
	anim.initanimset = [];
	level.initanimset[0] = %s1_run_turn_180;
	level.initanimset[1] = %s1_run_turn_l135;
	level.initanimset[2] = %s1_run_turn_l90;
	level.initanimset[3] = %s1_run_turn_l45;
	level.initanimset[5] = %s1_run_turn_r45;
	level.initanimset[6] = %s1_run_turn_r90;
	level.initanimset[7] = %s1_run_turn_r135;
	level.initanimset[8] = %s1_run_turn_180;
	level.archetypes["s1_soldier"]["run_turn"] = level.initanimset;
	anim.initanimset = [];
	level.initanimset[0] = %s1_run_turn_180;
	level.initanimset[1] = %s1_run_turn_l135;
	level.initanimset[2] = %s1_run_turn_l90;
	level.initanimset[3] = %s1_run_turn_l45;
	level.initanimset[5] = %s1_run_turn_r45;
	level.initanimset[6] = %s1_run_turn_r90;
	level.initanimset[7] = %s1_run_turn_r135;
	level.initanimset[8] = %s1_run_turn_180;
	level.archetypes["s1_soldier"]["walk_turn"] = level.initanimset;
}

//Function Number: 28
set_s1_animarray_standing_turns()
{
	level.initanimset["turn_left_45"] = %s1_exposed_tracking_turn45l;
	level.initanimset["turn_left_90"] = %s1_exposed_tracking_turn90l;
	level.initanimset["turn_left_135"] = %s1_exposed_tracking_turn135l;
	level.initanimset["turn_left_180"] = %s1_exposed_tracking_turn180l;
	level.initanimset["turn_right_45"] = %s1_exposed_tracking_turn45r;
	level.initanimset["turn_right_90"] = %s1_exposed_tracking_turn90r;
	level.initanimset["turn_right_135"] = %s1_exposed_tracking_turn135r;
	level.initanimset["turn_right_180"] = %s1_exposed_tracking_turn180r;
}

//Function Number: 29
init_s1_coverstand_turn_animations()
{
	anim.initanimset = [];
	level.initanimset["turn_left_45"] = %s1_coverstand_tracking_turn45l;
	level.initanimset["turn_left_90"] = %s1_coverstand_tracking_turn90l;
	level.initanimset["turn_left_135"] = %s1_coverstand_tracking_turn135l;
	level.initanimset["turn_left_180"] = %s1_coverstand_tracking_turn180l;
	level.initanimset["turn_right_45"] = %s1_coverstand_tracking_turn45r;
	level.initanimset["turn_right_90"] = %s1_coverstand_tracking_turn90r;
	level.initanimset["turn_right_135"] = %s1_coverstand_tracking_turn135r;
	level.initanimset["turn_right_180"] = %s1_coverstand_tracking_turn180r;
	level.archetypes["s1_soldier"]["coverstand_turn"] = level.initanimset;
}

//Function Number: 30
init_s1_exposed_turn_animations()
{
	anim.initanimset = [];
	level.initanimset["turn_left_45"] = %s1_exposed_tracking_turn45l;
	level.initanimset["turn_left_90"] = %s1_exposed_tracking_turn90l;
	level.initanimset["turn_left_135"] = %s1_exposed_tracking_turn135l;
	level.initanimset["turn_left_180"] = %s1_exposed_tracking_turn180l;
	level.initanimset["turn_right_45"] = %s1_exposed_tracking_turn45r;
	level.initanimset["turn_right_90"] = %s1_exposed_tracking_turn90r;
	level.initanimset["turn_right_135"] = %s1_exposed_tracking_turn135r;
	level.initanimset["turn_right_180"] = %s1_exposed_tracking_turn180r;
	level.archetypes["s1_soldier"]["exposed_turn"] = level.initanimset;
	anim.initanimset = [];
	level.initanimset["turn_left_45"] = %s1_exposed_crouch_turn_90_left;
	level.initanimset["turn_left_90"] = %s1_exposed_crouch_turn_90_left;
	level.initanimset["turn_left_135"] = %s1_exposed_crouch_turn_180_left;
	level.initanimset["turn_left_180"] = %s1_exposed_crouch_turn_180_left;
	level.initanimset["turn_right_45"] = %s1_exposed_crouch_turn_90_right;
	level.initanimset["turn_right_90"] = %s1_exposed_crouch_turn_90_right;
	level.initanimset["turn_right_135"] = %s1_exposed_crouch_turn_180_right;
	level.initanimset["turn_right_180"] = %s1_exposed_crouch_turn_180_right;
	level.archetypes["s1_soldier"]["exposed_turn_crouch"] = level.initanimset;
}