/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\init_move_transitions.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 140 ms
 * Timestamp: 10/27/2023 1:24:03 AM
*******************************************************************/

//Function Number: 1
init_move_transition_arrays()
{
	if(isdefined(level.move_transition_arrays))
	{
		return;
	}

	anim.move_transition_arrays = 1;
	if(!isdefined(level.var_1FD7))
	{
		anim.var_1FD7 = [];
	}

	if(!isdefined(level.coverexit))
	{
		anim.coverexit = [];
	}

	anim.maxdirections = [];
	anim.excludedir = [];
	anim.traverseinfo = [];
	if(!isdefined(level.var_1FDA))
	{
		anim.var_1FDA = [];
	}

	if(!isdefined(level.var_1FD9))
	{
		anim.var_1FD9 = [];
	}

	if(!isdefined(level.var_1FB4))
	{
		anim.var_1FB4 = [];
	}

	anim.coverexitpostdist = [];
	anim.covertranspredist = [];
	if(!isdefined(level.covertransangles))
	{
		anim.covertransangles = [];
	}

	if(!isdefined(level.coverexitangles))
	{
		anim.coverexitangles = [];
	}

	anim.arrivalendstance = [];
}

//Function Number: 2
initmovestartstoptransitions()
{
	init_move_transition_arrays();
	var_00 = [];
	var_00[0] = "left";
	var_00[1] = "right";
	var_00[2] = "left_crouch";
	var_00[3] = "right_crouch";
	var_00[4] = "crouch";
	var_00[5] = "stand";
	var_00[6] = "exposed";
	var_00[7] = "exposed_crouch";
	var_00[8] = "stand_saw";
	var_00[9] = "prone_saw";
	var_00[10] = "crouch_saw";
	var_00[11] = "wall_over_40";
	var_00[12] = "right_cqb";
	var_00[13] = "right_crouch_cqb";
	var_00[14] = "left_cqb";
	var_00[15] = "left_crouch_cqb";
	var_00[16] = "exposed_cqb";
	var_00[17] = "exposed_crouch_cqb";
	var_00[18] = "heat";
	var_00[19] = "heat_left";
	var_00[20] = "heat_right";
	var_00[21] = "exposed_ready";
	var_00[22] = "exposed_ready_cqb";
	var_01 = 6;
	anim.approach_types = [];
	level.approach_types["Cover Left"] = [];
	level.approach_types["Cover Left"]["stand"] = "left";
	level.approach_types["Cover Left"]["crouch"] = "left_crouch";
	level.maxdirections["Cover Left"] = 9;
	level.excludedir["Cover Left"] = 9;
	level.approach_types["Cover Right"] = [];
	level.approach_types["Cover Right"]["stand"] = "right";
	level.approach_types["Cover Right"]["crouch"] = "right_crouch";
	level.maxdirections["Cover Right"] = 9;
	level.excludedir["Cover Right"] = 7;
	level.approach_types["Cover Crouch"] = [];
	level.approach_types["Cover Crouch"]["stand"] = "crouch";
	level.approach_types["Cover Crouch"]["crouch"] = "crouch";
	level.approach_types["Conceal Crouch"] = level.approach_types["Cover Crouch"];
	level.approach_types["Cover Crouch Window"] = level.approach_types["Cover Crouch"];
	level.maxdirections["Cover Crouch"] = 6;
	level.excludedir["Cover Crouch"] = -1;
	level.maxdirections["Conceal Crouch"] = 6;
	level.excludedir["Conceal Crouch"] = -1;
	level.approach_types["Cover Stand"] = [];
	level.approach_types["Cover Stand"]["stand"] = "stand";
	level.approach_types["Cover Stand"]["crouch"] = "stand";
	level.approach_types["Conceal Stand"] = level.approach_types["Cover Stand"];
	level.maxdirections["Cover Stand"] = 6;
	level.excludedir["Cover Stand"] = -1;
	level.maxdirections["Conceal Stand"] = 6;
	level.excludedir["Conceal Stand"] = -1;
	level.approach_types["Cover Prone"] = [];
	level.approach_types["Cover Prone"]["stand"] = "exposed";
	level.approach_types["Cover Prone"]["crouch"] = "exposed";
	level.approach_types["Conceal Prone"] = level.approach_types["Cover Prone"];
	level.excludedir["Conceal Prone"] = -1;
	level.approach_types["Path"] = [];
	level.approach_types["Path"]["stand"] = "exposed";
	level.approach_types["Path"]["crouch"] = "exposed_crouch";
	level.approach_types["Guard"] = level.approach_types["Path"];
	level.approach_types["Ambush"] = level.approach_types["Path"];
	level.approach_types["Scripted"] = level.approach_types["Path"];
	level.approach_types["Exposed"] = level.approach_types["Path"];
	level.var_489C["Guard"] = 1;
	level.var_489C["Ambush"] = 1;
	level.var_489C["Exposed"] = 1;
	level.var_489E["Guard"] = 1;
	level.var_489E["Exposed"] = 1;
	var_02 = [];
	var_02["right"][1] = %corner_standr_trans_in_1;
	var_02["right"][2] = %corner_standr_trans_in_2;
	var_02["right"][3] = %corner_standr_trans_in_3;
	var_02["right"][4] = %corner_standr_trans_in_4;
	var_02["right"][6] = %corner_standr_trans_in_6;
	var_02["right"][8] = %corner_standr_trans_in_8;
	var_02["right"][9] = %corner_standr_trans_in_9;
	var_02["right_crouch"][1] = %cornercrr_trans_in_ml;
	var_02["right_crouch"][2] = %cornercrr_trans_in_m;
	var_02["right_crouch"][3] = %cornercrr_trans_in_mr;
	var_02["right_crouch"][4] = %cornercrr_trans_in_l;
	var_02["right_crouch"][6] = %cornercrr_trans_in_r;
	var_02["right_crouch"][8] = %cornercrr_trans_in_f;
	var_02["right_crouch"][9] = %cornercrr_trans_in_mf;
	var_02["right_cqb"][1] = %corner_standr_trans_cqb_in_1;
	var_02["right_cqb"][2] = %corner_standr_trans_cqb_in_2;
	var_02["right_cqb"][3] = %corner_standr_trans_cqb_in_3;
	var_02["right_cqb"][4] = %corner_standr_trans_cqb_in_4;
	var_02["right_cqb"][6] = %corner_standr_trans_cqb_in_6;
	var_02["right_cqb"][8] = %corner_standr_trans_cqb_in_8;
	var_02["right_cqb"][9] = %corner_standr_trans_cqb_in_9;
	var_02["right_crouch_cqb"][1] = %cornercrr_cqb_trans_in_1;
	var_02["right_crouch_cqb"][2] = %cornercrr_cqb_trans_in_2;
	var_02["right_crouch_cqb"][3] = %cornercrr_cqb_trans_in_3;
	var_02["right_crouch_cqb"][4] = %cornercrr_cqb_trans_in_4;
	var_02["right_crouch_cqb"][6] = %cornercrr_cqb_trans_in_6;
	var_02["right_crouch_cqb"][8] = %cornercrr_cqb_trans_in_8;
	var_02["right_crouch_cqb"][9] = %cornercrr_cqb_trans_in_9;
	var_02["left"][1] = %corner_standl_trans_in_1;
	var_02["left"][2] = %corner_standl_trans_in_2;
	var_02["left"][3] = %corner_standl_trans_in_3;
	var_02["left"][4] = %corner_standl_trans_in_4;
	var_02["left"][6] = %corner_standl_trans_in_6;
	var_02["left"][7] = %corner_standl_trans_in_7;
	var_02["left"][8] = %corner_standl_trans_in_8;
	var_02["left_crouch"][1] = %cornercrl_trans_in_ml;
	var_02["left_crouch"][2] = %cornercrl_trans_in_m;
	var_02["left_crouch"][3] = %cornercrl_trans_in_mr;
	var_02["left_crouch"][4] = %cornercrl_trans_in_l;
	var_02["left_crouch"][6] = %cornercrl_trans_in_r;
	var_02["left_crouch"][7] = %cornercrl_trans_in_mf;
	var_02["left_crouch"][8] = %cornercrl_trans_in_f;
	var_02["left_cqb"][1] = %corner_standl_trans_cqb_in_1;
	var_02["left_cqb"][2] = %corner_standl_trans_cqb_in_2;
	var_02["left_cqb"][3] = %corner_standl_trans_cqb_in_3;
	var_02["left_cqb"][4] = %corner_standl_trans_cqb_in_4;
	var_02["left_cqb"][6] = %corner_standl_trans_cqb_in_6;
	var_02["left_cqb"][7] = %corner_standl_trans_cqb_in_7;
	var_02["left_cqb"][8] = %corner_standl_trans_cqb_in_8;
	var_02["left_crouch_cqb"][1] = %cornercrl_cqb_trans_in_1;
	var_02["left_crouch_cqb"][2] = %cornercrl_cqb_trans_in_2;
	var_02["left_crouch_cqb"][3] = %cornercrl_cqb_trans_in_3;
	var_02["left_crouch_cqb"][4] = %cornercrl_cqb_trans_in_4;
	var_02["left_crouch_cqb"][6] = %cornercrl_cqb_trans_in_6;
	var_02["left_crouch_cqb"][7] = %cornercrl_cqb_trans_in_7;
	var_02["left_crouch_cqb"][8] = %cornercrl_cqb_trans_in_8;
	var_02["crouch"][1] = %covercrouch_run_in_ml;
	var_02["crouch"][2] = %covercrouch_run_in_m;
	var_02["crouch"][3] = %covercrouch_run_in_mr;
	var_02["crouch"][4] = %covercrouch_run_in_l;
	var_02["crouch"][6] = %covercrouch_run_in_r;
	var_02["stand"][1] = %coverstand_trans_in_ml;
	var_02["stand"][2] = %coverstand_trans_in_m;
	var_02["stand"][3] = %coverstand_trans_in_mr;
	var_02["stand"][4] = %coverstand_trans_in_l;
	var_02["stand"][6] = %coverstand_trans_in_r;
	var_02["stand_saw"][1] = %saw_gunner_runin_ml;
	var_02["stand_saw"][2] = %saw_gunner_runin_m;
	var_02["stand_saw"][3] = %saw_gunner_runin_mr;
	var_02["stand_saw"][4] = %saw_gunner_runin_l;
	var_02["stand_saw"][6] = %saw_gunner_runin_r;
	var_02["crouch_saw"][1] = %saw_gunner_lowwall_runin_ml;
	var_02["crouch_saw"][2] = %saw_gunner_lowwall_runin_m;
	var_02["crouch_saw"][3] = %saw_gunner_lowwall_runin_mr;
	var_02["crouch_saw"][4] = %saw_gunner_lowwall_runin_l;
	var_02["crouch_saw"][6] = %saw_gunner_lowwall_runin_r;
	var_02["prone_saw"][1] = %saw_gunner_prone_runin_ml;
	var_02["prone_saw"][2] = %saw_gunner_prone_runin_m;
	var_02["prone_saw"][3] = %saw_gunner_prone_runin_mr;
	var_02["exposed"] = [];
	var_02["exposed"][1] = %run_2_idle_1;
	var_02["exposed"][2] = %run_2_stand_f_6;
	var_02["exposed"][3] = %run_2_idle_3;
	var_02["exposed"][4] = %run_2_stand_90l;
	var_02["exposed"][6] = %run_2_stand_90r;
	var_02["exposed"][7] = %run_2_idle_7;
	var_02["exposed"][8] = %run_2_stand_180l;
	var_02["exposed"][9] = %run_2_idle_9;
	var_02["exposed_crouch"] = [];
	var_02["exposed_crouch"][1] = %run_2_crouch_idle_1;
	var_02["exposed_crouch"][2] = %run_2_crouch_f;
	var_02["exposed_crouch"][3] = %run_2_crouch_idle_3;
	var_02["exposed_crouch"][4] = %run_2_crouch_90l;
	var_02["exposed_crouch"][6] = %run_2_crouch_90r;
	var_02["exposed_crouch"][7] = %run_2_crouch_idle_7;
	var_02["exposed_crouch"][8] = %run_2_crouch_180l;
	var_02["exposed_crouch"][9] = %run_2_crouch_idle_9;
	var_02["exposed_cqb"] = [];
	var_02["exposed_cqb"][1] = %cqb_stop_1;
	var_02["exposed_cqb"][2] = %cqb_stop_2;
	var_02["exposed_cqb"][3] = %cqb_stop_3;
	var_02["exposed_cqb"][4] = %cqb_stop_4;
	var_02["exposed_cqb"][6] = %cqb_stop_6;
	var_02["exposed_cqb"][7] = %cqb_stop_7;
	var_02["exposed_cqb"][8] = %cqb_stop_8;
	var_02["exposed_cqb"][9] = %cqb_stop_9;
	var_02["exposed_crouch_cqb"] = [];
	var_02["exposed_crouch_cqb"][1] = %cqb_crouch_stop_1;
	var_02["exposed_crouch_cqb"][2] = %cqb_crouch_stop_2;
	var_02["exposed_crouch_cqb"][3] = %cqb_crouch_stop_3;
	var_02["exposed_crouch_cqb"][4] = %cqb_crouch_stop_4;
	var_02["exposed_crouch_cqb"][6] = %cqb_crouch_stop_6;
	var_02["exposed_crouch_cqb"][7] = %cqb_crouch_stop_7;
	var_02["exposed_crouch_cqb"][8] = %cqb_crouch_stop_8;
	var_02["exposed_crouch_cqb"][9] = %cqb_crouch_stop_9;
	var_02["heat"] = [];
	var_02["heat"][1] = %heat_approach_1;
	var_02["heat"][2] = %heat_approach_2;
	var_02["heat"][3] = %heat_approach_3;
	var_02["heat"][4] = %heat_approach_4;
	var_02["heat"][6] = %heat_approach_6;
	var_02["heat"][8] = %heat_approach_8;
	var_02["heat_left"] = [];
	var_02["heat_right"] = [];
	var_02["wall_over_96"][1] = %traverse90_in_ml;
	var_02["wall_over_96"][2] = %traverse90_in_m;
	var_02["wall_over_96"][3] = %traverse90_in_mr;
	level.traverseinfo["wall_over_96"]["height"] = 96;
	var_02["wall_over_40"][1] = %traverse_window_m_2_run;
	var_02["wall_over_40"][2] = %traverse_window_m_2_run;
	var_02["wall_over_40"][3] = %traverse_window_m_2_run;
	level.archetypes["soldier"]["cover_trans"] = var_02;
	var_02 = [];
	var_02["right"][1] = %corner_standr_trans_out_1;
	var_02["right"][2] = %corner_standr_trans_out_2;
	var_02["right"][3] = %corner_standr_trans_out_3;
	var_02["right"][4] = %corner_standr_trans_out_4;
	var_02["right"][6] = %corner_standr_trans_out_6;
	var_02["right"][8] = %corner_standr_trans_out_8;
	var_02["right"][9] = %corner_standr_trans_out_9;
	var_02["right_crouch"][1] = %cornercrr_trans_out_ml;
	var_02["right_crouch"][2] = %cornercrr_trans_out_m;
	var_02["right_crouch"][3] = %cornercrr_trans_out_mr;
	var_02["right_crouch"][4] = %cornercrr_trans_out_l;
	var_02["right_crouch"][6] = %cornercrr_trans_out_r;
	var_02["right_crouch"][8] = %cornercrr_trans_out_f;
	var_02["right_crouch"][9] = %cornercrr_trans_out_mf;
	var_02["right_cqb"][1] = %corner_standr_trans_cqb_out_1;
	var_02["right_cqb"][2] = %corner_standr_trans_cqb_out_2;
	var_02["right_cqb"][3] = %corner_standr_trans_cqb_out_3;
	var_02["right_cqb"][4] = %corner_standr_trans_cqb_out_4;
	var_02["right_cqb"][6] = %corner_standr_trans_cqb_out_6;
	var_02["right_cqb"][8] = %corner_standr_trans_cqb_out_8;
	var_02["right_cqb"][9] = %corner_standr_trans_cqb_out_9;
	var_02["right_crouch_cqb"][1] = %cornercrr_cqb_trans_out_1;
	var_02["right_crouch_cqb"][2] = %cornercrr_cqb_trans_out_2;
	var_02["right_crouch_cqb"][3] = %cornercrr_cqb_trans_out_3;
	var_02["right_crouch_cqb"][4] = %cornercrr_cqb_trans_out_4;
	var_02["right_crouch_cqb"][6] = %cornercrr_cqb_trans_out_6;
	var_02["right_crouch_cqb"][8] = %cornercrr_cqb_trans_out_8;
	var_02["right_crouch_cqb"][9] = %cornercrr_cqb_trans_out_9;
	var_02["left"][1] = %corner_standl_trans_out_1;
	var_02["left"][2] = %corner_standl_trans_out_2;
	var_02["left"][3] = %corner_standl_trans_out_3;
	var_02["left"][4] = %corner_standl_trans_out_4;
	var_02["left"][6] = %corner_standl_trans_out_6;
	var_02["left"][7] = %corner_standl_trans_out_7;
	var_02["left"][8] = %corner_standl_trans_out_8;
	var_02["left_crouch"][1] = %cornercrl_trans_out_ml;
	var_02["left_crouch"][2] = %cornercrl_trans_out_m;
	var_02["left_crouch"][3] = %cornercrl_trans_out_mr;
	var_02["left_crouch"][4] = %cornercrl_trans_out_l;
	var_02["left_crouch"][6] = %cornercrl_trans_out_r;
	var_02["left_crouch"][7] = %cornercrl_trans_out_mf;
	var_02["left_crouch"][8] = %cornercrl_trans_out_f;
	var_02["left_cqb"][1] = %corner_standl_trans_cqb_out_1;
	var_02["left_cqb"][2] = %corner_standl_trans_cqb_out_2;
	var_02["left_cqb"][3] = %corner_standl_trans_cqb_out_3;
	var_02["left_cqb"][4] = %corner_standl_trans_cqb_out_4;
	var_02["left_cqb"][6] = %corner_standl_trans_cqb_out_6;
	var_02["left_cqb"][7] = %corner_standl_trans_cqb_out_7;
	var_02["left_cqb"][8] = %corner_standl_trans_cqb_out_8;
	var_02["left_crouch_cqb"][1] = %cornercrl_cqb_trans_out_1;
	var_02["left_crouch_cqb"][2] = %cornercrl_cqb_trans_out_2;
	var_02["left_crouch_cqb"][3] = %cornercrl_cqb_trans_out_3;
	var_02["left_crouch_cqb"][4] = %cornercrl_cqb_trans_out_4;
	var_02["left_crouch_cqb"][6] = %cornercrl_cqb_trans_out_6;
	var_02["left_crouch_cqb"][7] = %cornercrl_cqb_trans_out_7;
	var_02["left_crouch_cqb"][8] = %cornercrl_cqb_trans_out_8;
	var_02["crouch"][1] = %covercrouch_run_out_ml;
	var_02["crouch"][2] = %covercrouch_run_out_m;
	var_02["crouch"][3] = %covercrouch_run_out_mr;
	var_02["crouch"][4] = %covercrouch_run_out_l;
	var_02["crouch"][6] = %covercrouch_run_out_r;
	var_02["stand"][1] = %coverstand_trans_out_ml;
	var_02["stand"][2] = %coverstand_trans_out_m;
	var_02["stand"][3] = %coverstand_trans_out_mr;
	var_02["stand"][4] = %coverstand_trans_out_l;
	var_02["stand"][6] = %coverstand_trans_out_r;
	var_02["stand_saw"][1] = %saw_gunner_runout_ml;
	var_02["stand_saw"][2] = %saw_gunner_runout_m;
	var_02["stand_saw"][3] = %saw_gunner_runout_mr;
	var_02["stand_saw"][4] = %saw_gunner_runout_l;
	var_02["stand_saw"][6] = %saw_gunner_runout_r;
	var_02["prone_saw"][2] = %saw_gunner_prone_runout_m;
	var_02["prone_saw"][4] = %saw_gunner_prone_runout_l;
	var_02["prone_saw"][6] = %saw_gunner_prone_runout_r;
	var_02["prone_saw"][8] = %saw_gunner_prone_runout_f;
	var_02["crouch_saw"][1] = %saw_gunner_lowwall_runout_ml;
	var_02["crouch_saw"][2] = %saw_gunner_lowwall_runout_m;
	var_02["crouch_saw"][3] = %saw_gunner_lowwall_runout_mr;
	var_02["crouch_saw"][4] = %saw_gunner_lowwall_runout_l;
	var_02["crouch_saw"][6] = %saw_gunner_lowwall_runout_r;
	var_02["exposed"] = [];
	var_02["exposed"][1] = %cqb_start_1;
	var_02["exposed"][2] = %stand_2_run_180l;
	var_02["exposed"][3] = %cqb_start_3;
	var_02["exposed"][4] = %stand_2_run_l;
	var_02["exposed"][6] = %stand_2_run_r;
	var_02["exposed"][7] = %cqb_start_7;
	var_02["exposed"][8] = %surprise_start_v1;
	var_02["exposed"][9] = %cqb_start_9;
	var_02["exposed_crouch"] = [];
	var_02["exposed_crouch"][1] = %cqb_crouch_start_1;
	var_02["exposed_crouch"][2] = %crouch_2run_180;
	var_02["exposed_crouch"][3] = %cqb_crouch_start_3;
	var_02["exposed_crouch"][4] = %crouch_2run_l;
	var_02["exposed_crouch"][6] = %crouch_2run_r;
	var_02["exposed_crouch"][7] = %cqb_crouch_start_7;
	var_02["exposed_crouch"][8] = %crouch_2run_f;
	var_02["exposed_crouch"][9] = %cqb_crouch_start_9;
	var_02["exposed_cqb"] = [];
	var_02["exposed_cqb"][1] = %cqb_start_1;
	var_02["exposed_cqb"][2] = %cqb_start_2;
	var_02["exposed_cqb"][3] = %cqb_start_3;
	var_02["exposed_cqb"][4] = %cqb_start_4;
	var_02["exposed_cqb"][6] = %cqb_start_6;
	var_02["exposed_cqb"][7] = %cqb_start_7;
	var_02["exposed_cqb"][8] = %cqb_start_8;
	var_02["exposed_cqb"][9] = %cqb_start_9;
	var_02["exposed_crouch_cqb"] = [];
	var_02["exposed_crouch_cqb"][1] = %cqb_crouch_start_1;
	var_02["exposed_crouch_cqb"][2] = %cqb_crouch_start_2;
	var_02["exposed_crouch_cqb"][3] = %cqb_crouch_start_3;
	var_02["exposed_crouch_cqb"][4] = %cqb_crouch_start_4;
	var_02["exposed_crouch_cqb"][6] = %cqb_crouch_start_6;
	var_02["exposed_crouch_cqb"][7] = %cqb_crouch_start_7;
	var_02["exposed_crouch_cqb"][8] = %cqb_crouch_start_8;
	var_02["exposed_crouch_cqb"][9] = %cqb_crouch_start_9;
	var_02["heat"] = [];
	var_02["heat"][1] = %heat_exit_1;
	var_02["heat"][2] = %heat_exit_2;
	var_02["heat"][3] = %heat_exit_3;
	var_02["heat"][4] = %heat_exit_4;
	var_02["heat"][6] = %heat_exit_6;
	var_02["heat"][7] = %heat_exit_7;
	var_02["heat"][8] = %heat_exit_8;
	var_02["heat"][9] = %heat_exit_9;
	var_02["heat_left"] = [];
	var_02["heat_left"][1] = %heat_exit_1;
	var_02["heat_left"][2] = %heat_exit_2;
	var_02["heat_left"][3] = %heat_exit_3;
	var_02["heat_left"][4] = %heat_exit_4;
	var_02["heat_left"][6] = %heat_exit_6;
	var_02["heat_left"][7] = %heat_exit_8l;
	var_02["heat_left"][8] = %heat_exit_8l;
	var_02["heat_left"][9] = %heat_exit_8r;
	var_02["heat_right"] = [];
	var_02["heat_right"][1] = %heat_exit_1;
	var_02["heat_right"][2] = %heat_exit_2;
	var_02["heat_right"][3] = %heat_exit_3;
	var_02["heat_right"][4] = %heat_exit_4;
	var_02["heat_right"][6] = %heat_exit_6;
	var_02["heat_right"][7] = %heat_exit_8l;
	var_02["heat_right"][8] = %heat_exit_8r;
	var_02["heat_right"][9] = %heat_exit_8r;
	level.archetypes["soldier"]["cover_exit"] = var_02;
	for(var_03 = 1;var_03 <= 6;var_03++)
	{
		if(var_03 == 5)
		{
			continue;
		}

		for(var_04 = 0;var_04 < var_00.size;var_04++)
		{
			var_05 = var_00[var_04];
			if(isdefined(level.archetypes["soldier"]["cover_trans"][var_05]) && isdefined(level.archetypes["soldier"]["cover_trans"][var_05][var_03]))
			{
				level.archetypes["soldier"]["cover_trans_dist"][var_05][var_03] = getmovedelta(level.archetypes["soldier"]["cover_trans"][var_05][var_03],0,1);
				level.archetypes["soldier"]["cover_trans_angles"][var_05][var_03] = getangledelta(level.archetypes["soldier"]["cover_trans"][var_05][var_03],0,1);
			}

			if(isdefined(level.archetypes["soldier"]["cover_exit"][var_05]) && isdefined(level.archetypes["soldier"]["cover_exit"][var_05][var_03]))
			{
				if(animhasnotetrack(level.archetypes["soldier"]["cover_exit"][var_05][var_03],"code_move"))
				{
					var_06 = getnotetracktimes(level.archetypes["soldier"]["cover_exit"][var_05][var_03],"code_move")[0];
				}
				else
				{
					var_06 = 1;
				}

				level.archetypes["soldier"]["cover_exit_dist"][var_05][var_03] = getmovedelta(level.archetypes["soldier"]["cover_exit"][var_05][var_03],0,var_06);
				level.archetypes["soldier"]["cover_exit_angles"][var_05][var_03] = getangledelta(level.archetypes["soldier"]["cover_exit"][var_05][var_03],0,1);
			}
		}
	}

	for(var_04 = 0;var_04 < var_00.size;var_04++)
	{
		var_05 = var_00[var_04];
		level.var_1FDA[var_05] = 0;
		for(var_03 = 1;var_03 <= 6;var_03++)
		{
			if(var_03 == 5 || !isdefined(level.archetypes["soldier"]["cover_trans"][var_05]) || !isdefined(level.archetypes["soldier"]["cover_trans"][var_05][var_03]))
			{
				continue;
			}

			var_07 = lengthsquared(level.archetypes["soldier"]["cover_trans_dist"][var_05][var_03]);
			if(level.var_1FDA[var_05] < var_07)
			{
				level.var_1FDA[var_05] = var_07;
			}
		}

		level.var_1FDA[var_05] = sqrt(level.var_1FDA[var_05]);
	}

	level.var_3105["exposed"] = 1;
	level.var_3105["exposed_crouch"] = 1;
	level.var_3105["exposed_cqb"] = 1;
	level.var_3105["exposed_crouch_cqb"] = 1;
	level.var_3105["exposed_ready_cqb"] = 1;
	level.var_3105["exposed_ready"] = 1;
	level.var_3105["heat"] = 1;
	if(!isdefined(level.var_4F3E))
	{
		anim.var_4F3E = 0;
	}

	foreach(var_05, var_09 in level.var_3105)
	{
		for(var_03 = 7;var_03 <= 9;var_03++)
		{
			if(isdefined(level.archetypes["soldier"]["cover_trans"][var_05]) && isdefined(level.archetypes["soldier"]["cover_trans"][var_05][var_03]))
			{
				level.archetypes["soldier"]["cover_trans_dist"][var_05][var_03] = getmovedelta(level.archetypes["soldier"]["cover_trans"][var_05][var_03],0,1);
				level.archetypes["soldier"]["cover_trans_angles"][var_05][var_03] = getangledelta(level.archetypes["soldier"]["cover_trans"][var_05][var_03],0,1);
			}

			if(isdefined(level.archetypes["soldier"]["cover_exit"][var_05]) && isdefined(level.archetypes["soldier"]["cover_exit"][var_05][var_03]))
			{
				var_06 = getnotetracktimes(level.archetypes["soldier"]["cover_exit"][var_05][var_03],"code_move")[0];
				level.archetypes["soldier"]["cover_exit_dist"][var_05][var_03] = getmovedelta(level.archetypes["soldier"]["cover_exit"][var_05][var_03],0,var_06);
				level.archetypes["soldier"]["cover_exit_angles"][var_05][var_03] = getangledelta(level.archetypes["soldier"]["cover_exit"][var_05][var_03],0,1);
			}
		}

		for(var_03 = 1;var_03 <= 9;var_03++)
		{
			if(!isdefined(level.archetypes["soldier"]["cover_trans"][var_05]) || !isdefined(level.archetypes["soldier"]["cover_trans"][var_05][var_03]))
			{
				continue;
			}

			var_0A = length(level.archetypes["soldier"]["cover_trans_dist"][var_05][var_03]);
			if(var_0A > level.var_4F3E)
			{
				anim.var_4F3E = var_0A;
			}
		}
	}

	level.archetypes["soldier"]["cover_trans_split"]["left"][7] = 0.369369;
	level.archetypes["soldier"]["cover_trans_split"]["left_crouch"][7] = 0.321321;
	level.archetypes["soldier"]["cover_trans_split"]["left_crouch_cqb"][7] = 0.2002;
	level.archetypes["soldier"]["cover_trans_split"]["left_cqb"][7] = 0.275275;
	level.archetypes["soldier"]["cover_exit_split"]["left"][7] = 0.550551;
	level.archetypes["soldier"]["cover_exit_split"]["left_crouch"][7] = 0.558559;
	level.archetypes["soldier"]["cover_exit_split"]["left_cqb"][7] = 0.358358;
	level.archetypes["soldier"]["cover_exit_split"]["left_crouch_cqb"][7] = 0.359359;
	level.archetypes["soldier"]["cover_exit_split"]["heat_left"][7] = 0.42;
	level.archetypes["soldier"]["cover_trans_split"]["left"][8] = 0.525526;
	level.archetypes["soldier"]["cover_trans_split"]["left_crouch"][8] = 0.448448;
	level.archetypes["soldier"]["cover_trans_split"]["left_crouch_cqb"][8] = 0.251251;
	level.archetypes["soldier"]["cover_trans_split"]["left_cqb"][8] = 0.335335;
	level.archetypes["soldier"]["cover_exit_split"]["left"][8] = 0.616617;
	level.archetypes["soldier"]["cover_exit_split"]["left_crouch"][8] = 0.453453;
	level.archetypes["soldier"]["cover_exit_split"]["left_crouch_cqb"][8] = 0.572573;
	level.archetypes["soldier"]["cover_exit_split"]["left_cqb"][8] = 0.336336;
	level.archetypes["soldier"]["cover_exit_split"]["heat_left"][8] = 0.42;
	level.archetypes["soldier"]["cover_trans_split"]["right"][8] = 0.472472;
	level.archetypes["soldier"]["cover_trans_split"]["right_crouch"][8] = 0.248248;
	level.archetypes["soldier"]["cover_trans_split"]["right_cqb"][8] = 0.345345;
	level.archetypes["soldier"]["cover_trans_split"]["right_crouch_cqb"][8] = 0.428428;
	level.archetypes["soldier"]["cover_exit_split"]["right"][8] = 0.431431;
	level.archetypes["soldier"]["cover_exit_split"]["right_crouch"][8] = 0.545546;
	level.archetypes["soldier"]["cover_exit_split"]["right_cqb"][8] = 0.335335;
	level.archetypes["soldier"]["cover_exit_split"]["right_crouch_cqb"][8] = 0.4004;
	level.archetypes["soldier"]["cover_exit_split"]["heat_right"][8] = 0.4;
	level.archetypes["soldier"]["cover_trans_split"]["right"][9] = 0.551552;
	level.archetypes["soldier"]["cover_trans_split"]["right_crouch"][9] = 0.2002;
	level.archetypes["soldier"]["cover_trans_split"]["right_cqb"][9] = 0.3003;
	level.archetypes["soldier"]["cover_trans_split"]["right_crouch_cqb"][9] = 0.224224;
	level.archetypes["soldier"]["cover_exit_split"]["right"][9] = 0.485485;
	level.archetypes["soldier"]["cover_exit_split"]["right_crouch"][9] = 0.493493;
	level.archetypes["soldier"]["cover_exit_split"]["right_cqb"][9] = 0.438438;
	level.archetypes["soldier"]["cover_exit_split"]["right_crouch_cqb"][9] = 0.792793;
	level.archetypes["soldier"]["cover_exit_split"]["heat_right"][9] = 0.4;
	anim.var_7958 = [];
	level.var_7958["left"] = 1;
	level.var_7958["left_crouch"] = 1;
	level.var_7958["left_crouch_cqb"] = 1;
	level.var_7958["left_cqb"] = 1;
	anim.var_795A = [];
	level.var_795A["left"] = 1;
	level.var_795A["left_crouch"] = 1;
	level.var_795A["left_crouch_cqb"] = 1;
	level.var_795A["left_cqb"] = 1;
	level.var_795A["heat_left"] = 1;
	anim.splitarrivalsright = [];
	level.splitarrivalsright["right"] = 1;
	level.splitarrivalsright["right_crouch"] = 1;
	level.splitarrivalsright["right_cqb"] = 1;
	level.splitarrivalsright["right_crouch_cqb"] = 1;
	anim.var_795B = [];
	level.var_795B["right"] = 1;
	level.var_795B["right_crouch"] = 1;
	level.var_795B["right_cqb"] = 1;
	level.var_795B["right_crouch_cqb"] = 1;
	level.var_795B["heat_right"] = 1;
	getsplittimes("soldier");
	level.arrivalendstance["left"] = "stand";
	level.arrivalendstance["left_cqb"] = "stand";
	level.arrivalendstance["right"] = "stand";
	level.arrivalendstance["right_cqb"] = "stand";
	level.arrivalendstance["stand"] = "stand";
	level.arrivalendstance["stand_saw"] = "stand";
	level.arrivalendstance["exposed"] = "stand";
	level.arrivalendstance["exposed_cqb"] = "stand";
	level.arrivalendstance["heat"] = "stand";
	level.arrivalendstance["left_crouch"] = "crouch";
	level.arrivalendstance["left_crouch_cqb"] = "crouch";
	level.arrivalendstance["right_crouch"] = "crouch";
	level.arrivalendstance["right_crouch_cqb"] = "crouch";
	level.arrivalendstance["crouch_saw"] = "crouch";
	level.arrivalendstance["crouch"] = "crouch";
	level.arrivalendstance["exposed_crouch"] = "crouch";
	level.arrivalendstance["exposed_crouch_cqb"] = "crouch";
	level.arrivalendstance["prone_saw"] = "prone";
	level.arrivalendstance["exposed_ready"] = "stand";
	level.arrivalendstance["exposed_ready_cqb"] = "stand";
	level.var_65CE["Cover Stand"] = "stand";
	level.var_65CE["Conceal Stand"] = "stand";
	level.var_65CE["Cover Crouch"] = "crouch";
	level.var_65CE["Conceal Crouch"] = "crouch";
}

//Function Number: 3
getsplittimes(param_00)
{
	func_3BFC(param_00,7,8,0,level.var_7958,level.var_795A);
	func_3BFC(param_00,8,9,1,level.splitarrivalsright,level.var_795B);
}

//Function Number: 4
func_3BFC(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = 0;
	for(var_07 = param_01;var_07 <= param_02;var_07++)
	{
		if(!var_06)
		{
			foreach(var_0A, var_09 in param_04)
			{
				if(isdefined(level.archetypes[param_00]["cover_trans"]) && isdefined(level.archetypes[param_00]["cover_trans"][var_0A]) && isdefined(level.archetypes[param_00]["cover_trans"][var_0A][var_07]))
				{
					level.archetypes[param_00]["cover_trans_predist"][var_0A][var_07] = getmovedelta(level.archetypes[param_00]["cover_trans"][var_0A][var_07],0,gettranssplittime(param_00,var_0A,var_07));
					level.archetypes[param_00]["cover_trans_dist"][var_0A][var_07] = getmovedelta(level.archetypes[param_00]["cover_trans"][var_0A][var_07],0,1) - level.archetypes[param_00]["cover_trans_predist"][var_0A][var_07];
					level.archetypes[param_00]["cover_trans_angles"][var_0A][var_07] = getangledelta(level.archetypes[param_00]["cover_trans"][var_0A][var_07],0,1);
				}
			}

			foreach(var_0A, var_09 in param_05)
			{
				if(isdefined(level.archetypes[param_00]["cover_exit"]) && isdefined(level.archetypes[param_00]["cover_exit"][var_0A]) && isdefined(level.archetypes[param_00]["cover_exit"][var_0A][var_07]))
				{
					level.archetypes[param_00]["cover_exit_dist"][var_0A][var_07] = getmovedelta(level.archetypes[param_00]["cover_exit"][var_0A][var_07],0,getexitsplittime(param_00,var_0A,var_07));
					level.archetypes[param_00]["cover_exit_postdist"][var_0A][var_07] = getmovedelta(level.archetypes[param_00]["cover_exit"][var_0A][var_07],0,1) - level.archetypes[param_00]["cover_exit_dist"][var_0A][var_07];
					level.archetypes[param_00]["cover_exit_angles"][var_0A][var_07] = getangledelta(level.archetypes[param_00]["cover_exit"][var_0A][var_07],0,1);
				}
			}

			continue;
		}
	}
}

//Function Number: 5
getexitsplittime(param_00,param_01,param_02)
{
	return level.archetypes[param_00]["cover_exit_split"][param_01][param_02];
}

//Function Number: 6
gettranssplittime(param_00,param_01,param_02)
{
	return level.archetypes[param_00]["cover_trans_split"][param_01][param_02];
}