/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\init_move_transitions.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 108 ms
 * Timestamp: 10/27/2023 2:18:23 AM
*******************************************************************/

//Function Number: 1
func_2082()
{
	if(isdefined(level.var_2083))
	{
		return;
	}

	anim.var_2083 = 1;
	if(!isdefined(level.var_1164))
	{
		anim.var_1164 = [];
	}

	if(!isdefined(level.var_1173))
	{
		anim.var_1173 = [];
	}

	anim.var_1176 = [];
	anim.var_1177 = [];
	anim.var_2084 = [];
	if(!isdefined(level.var_1185))
	{
		anim.var_1185 = [];
	}

	if(!isdefined(level.var_1186))
	{
		anim.var_1186 = [];
	}

	if(!isdefined(level.var_11AC))
	{
		anim.var_11AC = [];
	}

	anim.var_11AD = [];
	anim.var_11B0 = [];
	if(!isdefined(level.var_1187))
	{
		anim.var_1187 = [];
	}

	if(!isdefined(level.var_11A9))
	{
		anim.var_11A9 = [];
	}

	anim.var_2085 = [];
	anim.var_2086 = [];
	anim.var_1166 = [];
}

//Function Number: 2
func_2087()
{
	func_2082();
	level.var_1184 = 1;
	var_00 = [];
	var_01 = 6;
	anim.var_116F = [];
	level.var_116F["Cover Left"] = [];
	level.var_116F["Cover Left"]["stand"] = "left";
	level.var_116F["Cover Left"]["crouch"] = "left_crouch";
	level.var_1176["Cover Left"] = 9;
	level.var_1177["Cover Left"] = 9;
	level.var_116F["Cover Right"] = [];
	level.var_116F["Cover Right"]["stand"] = "right";
	level.var_116F["Cover Right"]["crouch"] = "right_crouch";
	level.var_1176["Cover Right"] = 9;
	level.var_1177["Cover Right"] = 7;
	level.var_116F["Cover Crouch"] = [];
	level.var_116F["Cover Crouch"]["stand"] = "crouch";
	level.var_116F["Cover Crouch"]["crouch"] = "crouch";
	level.var_116F["Conceal Crouch"] = level.var_116F["Cover Crouch"];
	level.var_116F["Cover Crouch Window"] = level.var_116F["Cover Crouch"];
	level.var_1176["Cover Crouch"] = 6;
	level.var_1177["Cover Crouch"] = -1;
	level.var_1176["Conceal Crouch"] = 6;
	level.var_1177["Conceal Crouch"] = -1;
	level.var_116F["Cover Stand"] = [];
	level.var_116F["Cover Stand"]["stand"] = "stand";
	level.var_116F["Cover Stand"]["crouch"] = "stand";
	level.var_116F["Conceal Stand"] = level.var_116F["Cover Stand"];
	level.var_1176["Cover Stand"] = 6;
	level.var_1177["Cover Stand"] = -1;
	level.var_1176["Conceal Stand"] = 6;
	level.var_1177["Conceal Stand"] = -1;
	level.var_116F["Cover Prone"] = [];
	level.var_116F["Cover Prone"]["stand"] = "exposed";
	level.var_116F["Cover Prone"]["crouch"] = "exposed";
	level.var_116F["Conceal Prone"] = level.var_116F["Cover Prone"];
	level.var_1177["Conceal Prone"] = -1;
	level.var_116F["Path"] = [];
	level.var_116F["Path"]["stand"] = "exposed";
	level.var_116F["Path"]["crouch"] = "exposed_crouch";
	level.var_116F["Guard"] = level.var_116F["Path"];
	level.var_116F["Ambush"] = level.var_116F["Path"];
	level.var_116F["Scripted"] = level.var_116F["Path"];
	level.var_116F["Exposed"] = level.var_116F["Path"];
	level.var_112F["Guard"] = 1;
	level.var_112F["Ambush"] = 1;
	level.var_112F["Exposed"] = 1;
	level.var_CBD["Guard"] = 1;
	level.var_CBD["Exposed"] = 1;
	level.var_1164["right"][1] = %corner_standr_trans_in_1;
	level.var_1164["right"][2] = %corner_standr_trans_in_2;
	level.var_1164["right"][3] = %corner_standr_trans_in_3;
	level.var_1164["right"][4] = %corner_standr_trans_in_4;
	level.var_1164["right"][6] = %corner_standr_trans_in_6;
	level.var_1164["right"][8] = %corner_standr_trans_in_8;
	level.var_1164["right"][9] = %corner_standr_trans_in_9;
	level.var_1164["right_crouch"][1] = %cornercrr_trans_in_ml;
	level.var_1164["right_crouch"][2] = %cornercrr_trans_in_m;
	level.var_1164["right_crouch"][3] = %cornercrr_trans_in_mr;
	level.var_1164["right_crouch"][4] = %cornercrr_trans_in_l;
	level.var_1164["right_crouch"][6] = %cornercrr_trans_in_r;
	level.var_1164["right_crouch"][8] = %cornercrr_trans_in_f;
	level.var_1164["right_crouch"][9] = %cornercrr_trans_in_mf;
	level.var_1164["right_cqb"][1] = %corner_standr_trans_cqb_in_1;
	level.var_1164["right_cqb"][2] = %corner_standr_trans_cqb_in_2;
	level.var_1164["right_cqb"][3] = %corner_standr_trans_cqb_in_3;
	level.var_1164["right_cqb"][4] = %corner_standr_trans_cqb_in_4;
	level.var_1164["right_cqb"][6] = %corner_standr_trans_cqb_in_6;
	level.var_1164["right_cqb"][8] = %corner_standr_trans_cqb_in_8;
	level.var_1164["right_cqb"][9] = %corner_standr_trans_cqb_in_9;
	level.var_1164["right_crouch_cqb"][1] = %cornercrr_cqb_trans_in_1;
	level.var_1164["right_crouch_cqb"][2] = %cornercrr_cqb_trans_in_2;
	level.var_1164["right_crouch_cqb"][3] = %cornercrr_cqb_trans_in_3;
	level.var_1164["right_crouch_cqb"][4] = %cornercrr_cqb_trans_in_4;
	level.var_1164["right_crouch_cqb"][6] = %cornercrr_cqb_trans_in_6;
	level.var_1164["right_crouch_cqb"][8] = %cornercrr_cqb_trans_in_8;
	level.var_1164["right_crouch_cqb"][9] = %cornercrr_cqb_trans_in_9;
	level.var_1164["left"][1] = %corner_standl_trans_in_1;
	level.var_1164["left"][2] = %corner_standl_trans_in_2;
	level.var_1164["left"][3] = %corner_standl_trans_in_3;
	level.var_1164["left"][4] = %corner_standl_trans_in_4;
	level.var_1164["left"][6] = %corner_standl_trans_in_6;
	level.var_1164["left"][7] = %corner_standl_trans_in_7;
	level.var_1164["left"][8] = %corner_standl_trans_in_8;
	level.var_1164["left_crouch"][1] = %cornercrl_trans_in_ml;
	level.var_1164["left_crouch"][2] = %cornercrl_trans_in_m;
	level.var_1164["left_crouch"][3] = %cornercrl_trans_in_mr;
	level.var_1164["left_crouch"][4] = %cornercrl_trans_in_l;
	level.var_1164["left_crouch"][6] = %cornercrl_trans_in_r;
	level.var_1164["left_crouch"][7] = %cornercrl_trans_in_mf;
	level.var_1164["left_crouch"][8] = %cornercrl_trans_in_f;
	level.var_1164["left_cqb"][1] = %corner_standl_trans_cqb_in_1;
	level.var_1164["left_cqb"][2] = %corner_standl_trans_cqb_in_2;
	level.var_1164["left_cqb"][3] = %corner_standl_trans_cqb_in_3;
	level.var_1164["left_cqb"][4] = %corner_standl_trans_cqb_in_4;
	level.var_1164["left_cqb"][6] = %corner_standl_trans_cqb_in_6;
	level.var_1164["left_cqb"][7] = %corner_standl_trans_cqb_in_7;
	level.var_1164["left_cqb"][8] = %corner_standl_trans_cqb_in_8;
	level.var_1164["left_crouch_cqb"][1] = %cornercrl_cqb_trans_in_1;
	level.var_1164["left_crouch_cqb"][2] = %cornercrl_cqb_trans_in_2;
	level.var_1164["left_crouch_cqb"][3] = %cornercrl_cqb_trans_in_3;
	level.var_1164["left_crouch_cqb"][4] = %cornercrl_cqb_trans_in_4;
	level.var_1164["left_crouch_cqb"][6] = %cornercrl_cqb_trans_in_6;
	level.var_1164["left_crouch_cqb"][7] = %cornercrl_cqb_trans_in_7;
	level.var_1164["left_crouch_cqb"][8] = %cornercrl_cqb_trans_in_8;
	level.var_1164["crouch"][1] = %covercrouch_run_in_ml;
	level.var_1164["crouch"][2] = %covercrouch_run_in_m;
	level.var_1164["crouch"][3] = %covercrouch_run_in_mr;
	level.var_1164["crouch"][4] = %covercrouch_run_in_l;
	level.var_1164["crouch"][6] = %covercrouch_run_in_r;
	level.var_1164["stand"][1] = %coverstand_trans_in_ml;
	level.var_1164["stand"][2] = %coverstand_trans_in_m;
	level.var_1164["stand"][3] = %coverstand_trans_in_mr;
	level.var_1164["stand"][4] = %coverstand_trans_in_l;
	level.var_1164["stand"][6] = %coverstand_trans_in_r;
	level.var_1164["stand_saw"][1] = %saw_gunner_runin_ml;
	level.var_1164["stand_saw"][2] = %saw_gunner_runin_m;
	level.var_1164["stand_saw"][3] = %saw_gunner_runin_mr;
	level.var_1164["stand_saw"][4] = %saw_gunner_runin_l;
	level.var_1164["stand_saw"][6] = %saw_gunner_runin_r;
	level.var_1164["crouch_saw"][1] = %saw_gunner_lowwall_runin_ml;
	level.var_1164["crouch_saw"][2] = %saw_gunner_lowwall_runin_m;
	level.var_1164["crouch_saw"][3] = %saw_gunner_lowwall_runin_mr;
	level.var_1164["crouch_saw"][4] = %saw_gunner_lowwall_runin_l;
	level.var_1164["crouch_saw"][6] = %saw_gunner_lowwall_runin_r;
	level.var_1164["prone_saw"][1] = %saw_gunner_prone_runin_ml;
	level.var_1164["prone_saw"][2] = %saw_gunner_prone_runin_m;
	level.var_1164["prone_saw"][3] = %saw_gunner_prone_runin_mr;
	level.var_1164["exposed"] = [];
	level.var_1164["exposed"][1] = %cqb_stop_1;
	level.var_1164["exposed"][2] = %run_2_stand_f_6;
	level.var_1164["exposed"][3] = %cqb_stop_3;
	level.var_1164["exposed"][4] = %run_2_stand_90l;
	level.var_1164["exposed"][6] = %run_2_stand_90r;
	level.var_1164["exposed"][7] = %cqb_stop_7;
	level.var_1164["exposed"][8] = %run_2_stand_180l;
	level.var_1164["exposed"][9] = %cqb_stop_9;
	level.var_1164["exposed_crouch"] = [];
	level.var_1164["exposed_crouch"][1] = %cqb_crouch_stop_1;
	level.var_1164["exposed_crouch"][2] = %run_2_crouch_f;
	level.var_1164["exposed_crouch"][3] = %cqb_crouch_stop_3;
	level.var_1164["exposed_crouch"][4] = %run_2_crouch_90l;
	level.var_1164["exposed_crouch"][6] = %run_2_crouch_90r;
	level.var_1164["exposed_crouch"][7] = %cqb_crouch_stop_7;
	level.var_1164["exposed_crouch"][8] = %run_2_crouch_180l;
	level.var_1164["exposed_crouch"][9] = %cqb_crouch_stop_9;
	level.var_1164["exposed_cqb"] = [];
	level.var_1164["exposed_cqb"][1] = %cqb_stop_1;
	level.var_1164["exposed_cqb"][2] = %cqb_stop_2;
	level.var_1164["exposed_cqb"][3] = %cqb_stop_3;
	level.var_1164["exposed_cqb"][4] = %cqb_stop_4;
	level.var_1164["exposed_cqb"][6] = %cqb_stop_6;
	level.var_1164["exposed_cqb"][7] = %cqb_stop_7;
	level.var_1164["exposed_cqb"][8] = %cqb_stop_8;
	level.var_1164["exposed_cqb"][9] = %cqb_stop_9;
	level.var_1164["exposed_crouch_cqb"] = [];
	level.var_1164["exposed_crouch_cqb"][1] = %cqb_crouch_stop_1;
	level.var_1164["exposed_crouch_cqb"][2] = %cqb_crouch_stop_2;
	level.var_1164["exposed_crouch_cqb"][3] = %cqb_crouch_stop_3;
	level.var_1164["exposed_crouch_cqb"][4] = %cqb_crouch_stop_4;
	level.var_1164["exposed_crouch_cqb"][6] = %cqb_crouch_stop_6;
	level.var_1164["exposed_crouch_cqb"][7] = %cqb_crouch_stop_7;
	level.var_1164["exposed_crouch_cqb"][8] = %cqb_crouch_stop_8;
	level.var_1164["exposed_crouch_cqb"][9] = %cqb_crouch_stop_9;
	level.var_1164["heat"] = [];
	level.var_1164["heat"][1] = %heat_approach_1;
	level.var_1164["heat"][2] = %heat_approach_2;
	level.var_1164["heat"][3] = %heat_approach_3;
	level.var_1164["heat"][4] = %heat_approach_4;
	level.var_1164["heat"][6] = %heat_approach_6;
	level.var_1164["heat"][8] = %heat_approach_8;
	level.var_1164["heat_left"] = [];
	level.var_1164["heat_right"] = [];
	anim.var_2088 = [];
	level.var_2088["right"] = %corner_standr_trans_b_2_alert;
	level.var_2088["right_crouch"] = %cornercrr_trans_b_2_alert;
	level.var_2088["left"] = %corner_standl_trans_b_2_alert_v2;
	level.var_2088["left_crouch"] = %cornercrl_trans_b_2_alert;
	level.var_2088["crouch"] = %covercrouch_aim_2_hide;
	level.var_2088["stand"] = %coverstand_aim_2_hide;
	anim.var_2089 = [];
	anim.var_208A = [];
	for(var_02 = 0;var_02 < var_01;var_02++ = var_7B[22])
	{
		var_03 = var_7B[var_02];
		level.var_2089[var_03] = getmovedelta(level.var_2088[var_03],0,1);
		level.var_208A[var_03] = getangledelta(level.var_2088[var_03],0,1);
	}

	level.var_208A["right"] = level.var_208A["right"] + 90;
	level.var_208A["right_crouch"] = level.var_208A["right_crouch"] + 90;
	level.var_208A["left"] = level.var_208A["left"] - 90;
	level.var_208A["left_crouch"] = level.var_208A["left_crouch"] - 90;
	level.var_1164["wall_over_96"][1] = %traverse90_in_ml;
	level.var_1164["wall_over_96"][2] = %traverse90_in_m;
	level.var_1164["wall_over_96"][3] = %traverse90_in_mr;
	level.var_2084["wall_over_96"]["height"] = 96;
	level.var_1164["wall_over_40"][1] = %traverse_window_m_2_run;
	level.var_1164["wall_over_40"][2] = %traverse_window_m_2_run;
	level.var_1164["wall_over_40"][3] = %traverse_window_m_2_run;
	level.var_1173["right"][1] = %corner_standr_trans_out_1;
	level.var_1173["right"][2] = %corner_standr_trans_out_2;
	level.var_1173["right"][3] = %corner_standr_trans_out_3;
	level.var_1173["right"][4] = %corner_standr_trans_out_4;
	level.var_1173["right"][6] = %corner_standr_trans_out_6;
	level.var_1173["right"][8] = %corner_standr_trans_out_8;
	level.var_1173["right"][9] = %corner_standr_trans_out_9;
	level.var_1173["right_crouch"][1] = %cornercrr_trans_out_ml;
	level.var_1173["right_crouch"][2] = %cornercrr_trans_out_m;
	level.var_1173["right_crouch"][3] = %cornercrr_trans_out_mr;
	level.var_1173["right_crouch"][4] = %cornercrr_trans_out_l;
	level.var_1173["right_crouch"][6] = %cornercrr_trans_out_r;
	level.var_1173["right_crouch"][8] = %cornercrr_trans_out_f;
	level.var_1173["right_crouch"][9] = %cornercrr_trans_out_mf;
	level.var_1173["right_cqb"][1] = %corner_standr_trans_cqb_out_1;
	level.var_1173["right_cqb"][2] = %corner_standr_trans_cqb_out_2;
	level.var_1173["right_cqb"][3] = %corner_standr_trans_cqb_out_3;
	level.var_1173["right_cqb"][4] = %corner_standr_trans_cqb_out_4;
	level.var_1173["right_cqb"][6] = %corner_standr_trans_cqb_out_6;
	level.var_1173["right_cqb"][8] = %corner_standr_trans_cqb_out_8;
	level.var_1173["right_cqb"][9] = %corner_standr_trans_cqb_out_9;
	level.var_1173["right_crouch_cqb"][1] = %cornercrr_cqb_trans_out_1;
	level.var_1173["right_crouch_cqb"][2] = %cornercrr_cqb_trans_out_2;
	level.var_1173["right_crouch_cqb"][3] = %cornercrr_cqb_trans_out_3;
	level.var_1173["right_crouch_cqb"][4] = %cornercrr_cqb_trans_out_4;
	level.var_1173["right_crouch_cqb"][6] = %cornercrr_cqb_trans_out_6;
	level.var_1173["right_crouch_cqb"][8] = %cornercrr_cqb_trans_out_8;
	level.var_1173["right_crouch_cqb"][9] = %cornercrr_cqb_trans_out_9;
	level.var_1173["left"][1] = %corner_standl_trans_out_1;
	level.var_1173["left"][2] = %corner_standl_trans_out_2;
	level.var_1173["left"][3] = %corner_standl_trans_out_3;
	level.var_1173["left"][4] = %corner_standl_trans_out_4;
	level.var_1173["left"][6] = %corner_standl_trans_out_6;
	level.var_1173["left"][7] = %corner_standl_trans_out_7;
	level.var_1173["left"][8] = %corner_standl_trans_out_8;
	level.var_1173["left_crouch"][1] = %cornercrl_trans_out_ml;
	level.var_1173["left_crouch"][2] = %cornercrl_trans_out_m;
	level.var_1173["left_crouch"][3] = %cornercrl_trans_out_mr;
	level.var_1173["left_crouch"][4] = %cornercrl_trans_out_l;
	level.var_1173["left_crouch"][6] = %cornercrl_trans_out_r;
	level.var_1173["left_crouch"][7] = %cornercrl_trans_out_mf;
	level.var_1173["left_crouch"][8] = %cornercrl_trans_out_f;
	level.var_1173["left_cqb"][1] = %corner_standl_trans_cqb_out_1;
	level.var_1173["left_cqb"][2] = %corner_standl_trans_cqb_out_2;
	level.var_1173["left_cqb"][3] = %corner_standl_trans_cqb_out_3;
	level.var_1173["left_cqb"][4] = %corner_standl_trans_cqb_out_4;
	level.var_1173["left_cqb"][6] = %corner_standl_trans_cqb_out_6;
	level.var_1173["left_cqb"][7] = %corner_standl_trans_cqb_out_7;
	level.var_1173["left_cqb"][8] = %corner_standl_trans_cqb_out_8;
	level.var_1173["left_crouch_cqb"][1] = %cornercrl_cqb_trans_out_1;
	level.var_1173["left_crouch_cqb"][2] = %cornercrl_cqb_trans_out_2;
	level.var_1173["left_crouch_cqb"][3] = %cornercrl_cqb_trans_out_3;
	level.var_1173["left_crouch_cqb"][4] = %cornercrl_cqb_trans_out_4;
	level.var_1173["left_crouch_cqb"][6] = %cornercrl_cqb_trans_out_6;
	level.var_1173["left_crouch_cqb"][7] = %cornercrl_cqb_trans_out_7;
	level.var_1173["left_crouch_cqb"][8] = %cornercrl_cqb_trans_out_8;
	level.var_1173["crouch"][1] = %covercrouch_run_out_ml;
	level.var_1173["crouch"][2] = %covercrouch_run_out_m;
	level.var_1173["crouch"][3] = %covercrouch_run_out_mr;
	level.var_1173["crouch"][4] = %covercrouch_run_out_l;
	level.var_1173["crouch"][6] = %covercrouch_run_out_r;
	level.var_1173["stand"][1] = %coverstand_trans_out_ml;
	level.var_1173["stand"][2] = %coverstand_trans_out_m;
	level.var_1173["stand"][3] = %coverstand_trans_out_mr;
	level.var_1173["stand"][4] = %coverstand_trans_out_l;
	level.var_1173["stand"][6] = %coverstand_trans_out_r;
	level.var_1173["stand_saw"][1] = %saw_gunner_runout_ml;
	level.var_1173["stand_saw"][2] = %saw_gunner_runout_m;
	level.var_1173["stand_saw"][3] = %saw_gunner_runout_mr;
	level.var_1173["stand_saw"][4] = %saw_gunner_runout_l;
	level.var_1173["stand_saw"][6] = %saw_gunner_runout_r;
	level.var_1173["prone_saw"][2] = %saw_gunner_prone_runout_m;
	level.var_1173["prone_saw"][4] = %saw_gunner_prone_runout_l;
	level.var_1173["prone_saw"][6] = %saw_gunner_prone_runout_r;
	level.var_1173["prone_saw"][8] = %saw_gunner_prone_runout_f;
	level.var_1173["crouch_saw"][1] = %saw_gunner_lowwall_runout_ml;
	level.var_1173["crouch_saw"][2] = %saw_gunner_lowwall_runout_m;
	level.var_1173["crouch_saw"][3] = %saw_gunner_lowwall_runout_mr;
	level.var_1173["crouch_saw"][4] = %saw_gunner_lowwall_runout_l;
	level.var_1173["crouch_saw"][6] = %saw_gunner_lowwall_runout_r;
	level.var_1173["exposed"] = [];
	level.var_1173["exposed"][1] = %cqb_start_1;
	level.var_1173["exposed"][2] = %stand_2_run_180l;
	level.var_1173["exposed"][3] = %cqb_start_3;
	level.var_1173["exposed"][4] = %stand_2_run_l;
	level.var_1173["exposed"][6] = %stand_2_run_r;
	level.var_1173["exposed"][7] = %cqb_start_7;
	level.var_1173["exposed"][8] = %surprise_start_v1;
	level.var_1173["exposed"][9] = %cqb_start_9;
	level.var_1173["exposed_crouch"] = [];
	level.var_1173["exposed_crouch"][1] = %cqb_crouch_start_1;
	level.var_1173["exposed_crouch"][2] = %crouch_2run_180;
	level.var_1173["exposed_crouch"][3] = %cqb_crouch_start_3;
	level.var_1173["exposed_crouch"][4] = %crouch_2run_l;
	level.var_1173["exposed_crouch"][6] = %crouch_2run_r;
	level.var_1173["exposed_crouch"][7] = %cqb_crouch_start_7;
	level.var_1173["exposed_crouch"][8] = %crouch_2run_f;
	level.var_1173["exposed_crouch"][9] = %cqb_crouch_start_9;
	level.var_1173["exposed_cqb"] = [];
	level.var_1173["exposed_cqb"][1] = %cqb_start_1;
	level.var_1173["exposed_cqb"][2] = %cqb_start_2;
	level.var_1173["exposed_cqb"][3] = %cqb_start_3;
	level.var_1173["exposed_cqb"][4] = %cqb_start_4;
	level.var_1173["exposed_cqb"][6] = %cqb_start_6;
	level.var_1173["exposed_cqb"][7] = %cqb_start_7;
	level.var_1173["exposed_cqb"][8] = %cqb_start_8;
	level.var_1173["exposed_cqb"][9] = %cqb_start_9;
	level.var_1173["exposed_crouch_cqb"] = [];
	level.var_1173["exposed_crouch_cqb"][1] = %cqb_crouch_start_1;
	level.var_1173["exposed_crouch_cqb"][2] = %cqb_crouch_start_2;
	level.var_1173["exposed_crouch_cqb"][3] = %cqb_crouch_start_3;
	level.var_1173["exposed_crouch_cqb"][4] = %cqb_crouch_start_4;
	level.var_1173["exposed_crouch_cqb"][6] = %cqb_crouch_start_6;
	level.var_1173["exposed_crouch_cqb"][7] = %cqb_crouch_start_7;
	level.var_1173["exposed_crouch_cqb"][8] = %cqb_crouch_start_8;
	level.var_1173["exposed_crouch_cqb"][9] = %cqb_crouch_start_9;
	level.var_1173["heat"] = [];
	level.var_1173["heat"][1] = %heat_exit_1;
	level.var_1173["heat"][2] = %heat_exit_2;
	level.var_1173["heat"][3] = %heat_exit_3;
	level.var_1173["heat"][4] = %heat_exit_4;
	level.var_1173["heat"][6] = %heat_exit_6;
	level.var_1173["heat"][7] = %heat_exit_7;
	level.var_1173["heat"][8] = %heat_exit_8;
	level.var_1173["heat"][9] = %heat_exit_9;
	level.var_1173["heat_left"] = [];
	level.var_1173["heat_left"][1] = %heat_exit_1;
	level.var_1173["heat_left"][2] = %heat_exit_2;
	level.var_1173["heat_left"][3] = %heat_exit_3;
	level.var_1173["heat_left"][4] = %heat_exit_4;
	level.var_1173["heat_left"][6] = %heat_exit_6;
	level.var_1173["heat_left"][7] = %heat_exit_8l;
	level.var_1173["heat_left"][8] = %heat_exit_8l;
	level.var_1173["heat_left"][9] = %heat_exit_8r;
	level.var_1173["heat_right"] = [];
	level.var_1173["heat_right"][1] = %heat_exit_1;
	level.var_1173["heat_right"][2] = %heat_exit_2;
	level.var_1173["heat_right"][3] = %heat_exit_3;
	level.var_1173["heat_right"][4] = %heat_exit_4;
	level.var_1173["heat_right"][6] = %heat_exit_6;
	level.var_1173["heat_right"][7] = %heat_exit_8l;
	level.var_1173["heat_right"][8] = %heat_exit_8r;
	level.var_1173["heat_right"][9] = %heat_exit_8r;
	for(var_02 = 1;var_02 <= 6;var_02++ = var_7B[21])
	{
		if(var_02 == 5)
		{
			continue;
		}

		for(var_04 = 0;var_04 < var_7B.size;var_04++ = "exposed_ready_cqb")
		{
			var_03 = var_7B[var_04];
			if(isdefined(level.var_1164[var_03]) && isdefined(level.var_1164[var_03][var_02]))
			{
				level.var_1186[var_03][var_02] = getmovedelta(level.var_1164[var_03][var_02],0,1);
				level.var_1187[var_03][var_02] = getangledelta(level.var_1164[var_03][var_02],0,1);
			}

			if(isdefined(level.var_1173[var_03]) && isdefined(level.var_1173[var_03][var_02]))
			{
				if(animhasnotetrack(level.var_1173[var_03][var_02],"code_move"))
				{
					var_05 = getnotetracktimes(level.var_1173[var_03][var_02],"code_move")[0];
				}
				else
				{
					var_05 = 1;
				}

				level.var_11AC[var_03][var_02] = getmovedelta(level.var_1173[var_03][var_02],0,var_05);
				level.var_11A9[var_03][var_02] = getangledelta(level.var_1173[var_03][var_02],0,1);
			}
		}
	}

	for(var_04 = 0;var_04 < var_7B.size;var_04++ = var_7B[20])
	{
		var_03 = var_7B[var_04];
		level.var_1185[var_03] = 0;
		for(var_02 = 1;var_02 <= 6;var_02++ = "exposed_ready")
		{
			if(var_02 == 5 || !isdefined(level.var_1164[var_03]) || !isdefined(level.var_1164[var_03][var_02]))
			{
				continue;
			}

			var_06 = lengthsquared(level.var_1186[var_03][var_02]);
			if(level.var_1185[var_03] < var_06)
			{
				level.var_1185[var_03] = var_06;
			}
		}

		level.var_1185[var_03] = sqrt(level.var_1185[var_03]);
	}

	level.var_1179["exposed"] = 1;
	level.var_1179["exposed_crouch"] = 1;
	level.var_1179["exposed_cqb"] = 1;
	level.var_1179["exposed_crouch_cqb"] = 1;
	level.var_1179["exposed_ready_cqb"] = 1;
	level.var_1179["exposed_ready"] = 1;
	level.var_1179["heat"] = 1;
	if(!isdefined(level.var_1190))
	{
		anim.var_1190 = 0;
	}

	foreach(var_03, var_08 in level.var_1179)
	{
		for(var_02 = 7;var_02 <= 9;var_02++ = "heat_right")
		{
			if(isdefined(level.var_1164[var_03]) && isdefined(level.var_1164[var_03][var_02]))
			{
				level.var_1186[var_03][var_02] = getmovedelta(level.var_1164[var_03][var_02],0,1);
				level.var_1187[var_03][var_02] = getangledelta(level.var_1164[var_03][var_02],0,1);
			}

			if(isdefined(level.var_1173[var_03]) && isdefined(level.var_1173[var_03][var_02]))
			{
				var_05 = getnotetracktimes(level.var_1173[var_03][var_02],"code_move")[0];
				level.var_11AC[var_03][var_02] = getmovedelta(level.var_1173[var_03][var_02],0,var_05);
				level.var_11A9[var_03][var_02] = getangledelta(level.var_1173[var_03][var_02],0,1);
			}
		}

		for(var_02 = 1;var_02 <= 9;var_02++ = var_7B[19])
		{
			if(!isdefined(level.var_1164[var_03]) || !isdefined(level.var_1164[var_03][var_02]))
			{
				continue;
			}

			var_09 = length(level.var_1186[var_03][var_02]);
			if(var_09 > level.var_1190)
			{
				anim.var_1190 = var_09;
			}
		}
	}

	level.var_2086["left"][7] = 0.369369;
	level.var_2086["left_crouch"][7] = 0.319319;
	level.var_2086["left_cqb"][7] = 0.451451;
	level.var_2086["left_crouch_cqb"][7] = 0.246246;
	level.var_2085["left"][7] = 0.547548;
	level.var_2085["left_crouch"][7] = 0.593594;
	level.var_2085["left_cqb"][7] = 0.702703;
	level.var_2085["left_crouch_cqb"][7] = 0.718719;
	level.var_2085["heat_left"][7] = 0.42;
	level.var_2086["left"][8] = 0.525526;
	level.var_2086["left_crouch"][8] = 0.428428;
	level.var_2086["left_cqb"][8] = 0.431431;
	level.var_2086["left_crouch_cqb"][8] = 0.33033;
	level.var_2085["left"][8] = 0.614615;
	level.var_2085["left_crouch"][8] = 0.451451;
	level.var_2085["left_cqb"][8] = 0.451451;
	level.var_2085["left_crouch_cqb"][8] = 0.603604;
	level.var_2085["heat_left"][8] = 0.42;
	level.var_2086["right"][8] = 0.458458;
	level.var_2086["right_crouch"][8] = 0.248248;
	level.var_2086["right_cqb"][8] = 0.458458;
	level.var_2086["right_crouch_cqb"][8] = 0.311311;
	level.var_2085["right"][8] = 0.457457;
	level.var_2085["right_crouch"][8] = 0.545546;
	level.var_2085["right_cqb"][8] = 0.540541;
	level.var_2085["right_crouch_cqb"][8] = 0.399399;
	level.var_2085["heat_right"][8] = 0.4;
	level.var_2086["right"][9] = 0.546547;
	level.var_2086["right_crouch"][9] = 0.2002;
	level.var_2086["right_cqb"][9] = 0.546547;
	level.var_2086["right_crouch_cqb"][9] = 0.232232;
	level.var_2085["right"][9] = 0.483483;
	level.var_2085["right_crouch"][9] = 0.493493;
	level.var_2085["right_cqb"][9] = 0.565566;
	level.var_2085["right_crouch_cqb"][9] = 0.518519;
	level.var_2085["heat_right"][9] = 0.4;
	var_0A = [];
	var_0B = [];
	func_208B(7,8,0,var_0A,var_0B);
	var_0A = [];
	var_0A["right"] = 1;
	var_0A["right_crouch"] = 1;
	var_0A["right_cqb"] = 1;
	var_0A["right_crouch_cqb"] = 1;
	var_0B = [];
	func_208B(8,9,1,var_0A,var_0B);
	level.var_1166["left"] = "stand";
	level.var_1166["left_cqb"] = "stand";
	level.var_1166["right"] = "stand";
	level.var_1166["right_cqb"] = "stand";
	level.var_1166["stand"] = "stand";
	level.var_1166["stand_saw"] = "stand";
	level.var_1166["exposed"] = "stand";
	level.var_1166["exposed_cqb"] = "stand";
	level.var_1166["heat"] = "stand";
	level.var_1166["left_crouch"] = "crouch";
	level.var_1166["left_crouch_cqb"] = "crouch";
	level.var_1166["right_crouch"] = "crouch";
	level.var_1166["right_crouch_cqb"] = "crouch";
	level.var_1166["crouch_saw"] = "crouch";
	level.var_1166["crouch"] = "crouch";
	level.var_1166["exposed_crouch"] = "crouch";
	level.var_1166["exposed_crouch_cqb"] = "crouch";
	level.var_1166["prone_saw"] = "prone";
	level.var_1166["exposed_ready"] = "stand";
	level.var_1166["exposed_ready_cqb"] = "stand";
	level.var_1172["Cover Stand"] = "stand";
	level.var_1172["Conceal Stand"] = "stand";
	level.var_1172["Cover Crouch"] = "crouch";
	level.var_1172["Conceal Crouch"] = "crouch";
}

//Function Number: 3
func_208B(param_00,param_01,param_02,param_03,param_04)
{
	for(var_05 = param_00;var_05 <= param_01;var_05++)
	{
		foreach(var_08, var_07 in param_03)
		{
			level.var_11B0[var_08][var_05] = getmovedelta(level.var_1164[var_08][var_05],0,func_208D(var_08,var_05));
			level.var_1186[var_08][var_05] = getmovedelta(level.var_1164[var_08][var_05],0,1) - level.var_11B0[var_08][var_05];
			level.var_1187[var_08][var_05] = getangledelta(level.var_1164[var_08][var_05],0,1);
		}

		foreach(var_08, var_07 in param_04)
		{
			level.var_11AC[var_08][var_05] = getmovedelta(level.var_1173[var_08][var_05],0,func_208C(var_08,var_05));
			level.var_11AD[var_08][var_05] = getmovedelta(level.var_1173[var_08][var_05],0,1) - level.var_11AC[var_08][var_05];
			level.var_11A9[var_08][var_05] = getangledelta(level.var_1173[var_08][var_05],0,1);
		}
	}
}

//Function Number: 4
func_208C(param_00,param_01)
{
	return level.var_2085[param_00][param_01];
}

//Function Number: 5
func_208D(param_00,param_01)
{
	return level.var_2086[param_00][param_01];
}