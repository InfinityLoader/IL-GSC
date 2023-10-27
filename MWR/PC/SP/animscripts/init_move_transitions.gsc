/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\init_move_transitions.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 223 ms
 * Timestamp: 10/27/2023 2:44:16 AM
*******************************************************************/

//Function Number: 1
init_move_transition_arrays()
{
	if(isdefined(level.move_transition_arrays))
	{
		return;
	}

	anim.move_transition_arrays = 1;
	if(!isdefined(level.covertrans))
	{
		anim.covertrans = [];
	}

	if(!isdefined(level.coverexit))
	{
		anim.coverexit = [];
	}

	anim.maxdirections = [];
	anim.excludedir = [];
	anim.traverseinfo = [];
	if(!isdefined(level.covertransdist))
	{
		anim.covertransdist = [];
	}

	if(!isdefined(level.coverexitdist))
	{
		anim.coverexitdist = [];
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
initsoldierentrance()
{
	var_00 = [];
	var_00["right"][1] = %corner_standr_trans_in_1;
	var_00["right"][2] = %corner_standr_trans_in_2;
	var_00["right"][3] = %corner_standr_trans_in_3;
	var_00["right"][4] = %corner_standr_trans_in_4;
	var_00["right"][6] = %corner_standr_trans_in_6;
	var_00["right"][8] = %corner_standr_trans_in_8;
	var_00["right"][9] = %corner_standr_trans_in_9;
	var_00["right_crouch"][1] = %cornercrr_trans_in_ml;
	var_00["right_crouch"][2] = %cornercrr_trans_in_m;
	var_00["right_crouch"][3] = %cornercrr_trans_in_mr;
	var_00["right_crouch"][4] = %cornercrr_trans_in_l;
	var_00["right_crouch"][6] = %cornercrr_trans_in_r;
	var_00["right_crouch"][8] = %cornercrr_trans_in_f;
	var_00["right_crouch"][9] = %cornercrr_trans_in_mf;
	var_00["right_cqb"][1] = %corner_standr_trans_cqb_in_1;
	var_00["right_cqb"][2] = %corner_standr_trans_cqb_in_2;
	var_00["right_cqb"][3] = %corner_standr_trans_cqb_in_3;
	var_00["right_cqb"][4] = %corner_standr_trans_cqb_in_4;
	var_00["right_cqb"][6] = %corner_standr_trans_cqb_in_6;
	var_00["right_cqb"][8] = %corner_standr_trans_cqb_in_8;
	var_00["right_cqb"][9] = %corner_standr_trans_cqb_in_9;
	var_00["right_crouch_cqb"][1] = %cornercrr_cqb_trans_in_1;
	var_00["right_crouch_cqb"][2] = %cornercrr_cqb_trans_in_2;
	var_00["right_crouch_cqb"][3] = %cornercrr_cqb_trans_in_3;
	var_00["right_crouch_cqb"][4] = %cornercrr_cqb_trans_in_4;
	var_00["right_crouch_cqb"][6] = %cornercrr_cqb_trans_in_6;
	var_00["right_crouch_cqb"][8] = %cornercrr_cqb_trans_in_8;
	var_00["right_crouch_cqb"][9] = %cornercrr_cqb_trans_in_9;
	var_00["left"][1] = %corner_standl_trans_in_1;
	var_00["left"][2] = %corner_standl_trans_in_2;
	var_00["left"][3] = %corner_standl_trans_in_3;
	var_00["left"][4] = %corner_standl_trans_in_4;
	var_00["left"][6] = %corner_standl_trans_in_6;
	var_00["left"][7] = %corner_standl_trans_in_7;
	var_00["left"][8] = %corner_standl_trans_in_8;
	var_00["left_crouch"][1] = %cornercrl_trans_in_ml;
	var_00["left_crouch"][2] = %cornercrl_trans_in_m;
	var_00["left_crouch"][3] = %cornercrl_trans_in_mr;
	var_00["left_crouch"][4] = %cornercrl_trans_in_l;
	var_00["left_crouch"][6] = %cornercrl_trans_in_r;
	var_00["left_crouch"][7] = %cornercrl_trans_in_mf;
	var_00["left_crouch"][8] = %cornercrl_trans_in_f;
	var_00["left_cqb"][1] = %corner_standl_trans_cqb_in_1;
	var_00["left_cqb"][2] = %corner_standl_trans_cqb_in_2;
	var_00["left_cqb"][3] = %corner_standl_trans_cqb_in_3;
	var_00["left_cqb"][4] = %corner_standl_trans_cqb_in_4;
	var_00["left_cqb"][6] = %corner_standl_trans_cqb_in_6;
	var_00["left_cqb"][7] = %corner_standl_trans_cqb_in_7;
	var_00["left_cqb"][8] = %corner_standl_trans_cqb_in_8;
	var_00["left_crouch_cqb"][1] = %cornercrl_cqb_trans_in_1;
	var_00["left_crouch_cqb"][2] = %cornercrl_cqb_trans_in_2;
	var_00["left_crouch_cqb"][3] = %cornercrl_cqb_trans_in_3;
	var_00["left_crouch_cqb"][4] = %cornercrl_cqb_trans_in_4;
	var_00["left_crouch_cqb"][6] = %cornercrl_cqb_trans_in_6;
	var_00["left_crouch_cqb"][7] = %cornercrl_cqb_trans_in_7;
	var_00["left_crouch_cqb"][8] = %cornercrl_cqb_trans_in_8;
	var_00["crouch"][1] = %covercrouch_run_in_ml;
	var_00["crouch"][2] = %covercrouch_run_in_m;
	var_00["crouch"][3] = %covercrouch_run_in_mr;
	var_00["crouch"][4] = %covercrouch_run_in_l;
	var_00["crouch"][6] = %covercrouch_run_in_r;
	var_00["stand"][1] = %coverstand_trans_in_ml;
	var_00["stand"][2] = %coverstand_trans_in_m;
	var_00["stand"][3] = %coverstand_trans_in_mr;
	var_00["stand"][4] = %coverstand_trans_in_l;
	var_00["stand"][6] = %coverstand_trans_in_r;
	var_00["stand_saw"][1] = %saw_gunner_runin_ml;
	var_00["stand_saw"][2] = %saw_gunner_runin_m;
	var_00["stand_saw"][3] = %saw_gunner_runin_mr;
	var_00["stand_saw"][4] = %saw_gunner_runin_l;
	var_00["stand_saw"][6] = %saw_gunner_runin_r;
	var_00["stand_unstable"] = [];
	var_00["stand_unstable"][1] = %lag_unstable_moveforward_arrive_1;
	var_00["stand_unstable"][2] = %lag_unstable_moveforward_arrive_2;
	var_00["stand_unstable"][3] = %lag_unstable_moveforward_arrive_3;
	var_00["stand_unstable"][4] = %lag_unstable_moveforward_arrive_4;
	var_00["stand_unstable"][6] = %lag_unstable_moveforward_arrive_6;
	var_00["stand_unstable"][7] = %lag_unstable_moveforward_arrive_7;
	var_00["stand_unstable"][8] = %lag_unstable_moveforward_arrive_8;
	var_00["stand_unstable"][9] = %lag_unstable_moveforward_arrive_9;
	var_00["stand_unstable_run"] = [];
	var_00["stand_unstable_run"][1] = %lag_unstable_run_arrive_1;
	var_00["stand_unstable_run"][2] = %lag_unstable_run_arrive_2;
	var_00["stand_unstable_run"][3] = %lag_unstable_run_arrive_3;
	var_00["stand_unstable_run"][4] = %lag_unstable_run_arrive_4;
	var_00["stand_unstable_run"][6] = %lag_unstable_run_arrive_6;
	var_00["stand_unstable_run"][7] = %lag_unstable_run_arrive_7;
	var_00["stand_unstable_run"][8] = %lag_unstable_run_arrive_8;
	var_00["stand_unstable_run"][9] = %lag_unstable_run_arrive_9;
	var_00["crouch_saw"][1] = %saw_gunner_lowwall_runin_ml;
	var_00["crouch_saw"][2] = %saw_gunner_lowwall_runin_m;
	var_00["crouch_saw"][3] = %saw_gunner_lowwall_runin_mr;
	var_00["crouch_saw"][4] = %saw_gunner_lowwall_runin_l;
	var_00["crouch_saw"][6] = %saw_gunner_lowwall_runin_r;
	var_00["prone_saw"][1] = %saw_gunner_prone_runin_ml;
	var_00["prone_saw"][2] = %saw_gunner_prone_runin_m;
	var_00["prone_saw"][3] = %saw_gunner_prone_runin_mr;
	var_00["exposed"] = [];
	var_00["exposed"][1] = %run_2_idle_1;
	var_00["exposed"][2] = %run_2_stand_f_6;
	var_00["exposed"][3] = %run_2_idle_3;
	var_00["exposed"][4] = %run_2_stand_90l;
	var_00["exposed"][6] = %run_2_stand_90r;
	var_00["exposed"][7] = %run_2_idle_7;
	var_00["exposed"][8] = %run_2_stand_180l;
	var_00["exposed"][9] = %run_2_idle_9;
	var_00["exposed_smg"] = [];
	var_00["exposed_smg"][1] = %cqb_stop_1;
	var_00["exposed_smg"][2] = %smg_run_2_stand_f_6;
	var_00["exposed_smg"][3] = %cqb_stop_3;
	var_00["exposed_smg"][4] = %run_2_stand_90l;
	var_00["exposed_smg"][6] = %run_2_stand_90r;
	var_00["exposed_smg"][7] = %cqb_stop_7;
	var_00["exposed_smg"][8] = %run_2_stand_180l;
	var_00["exposed_smg"][9] = %cqb_stop_9;
	var_00["exposed_crouch"] = [];
	var_00["exposed_crouch"][1] = %run_2_crouch_idle_1;
	var_00["exposed_crouch"][2] = %run_2_crouch_f;
	var_00["exposed_crouch"][3] = %run_2_crouch_idle_3;
	var_00["exposed_crouch"][4] = %run_2_crouch_90l;
	var_00["exposed_crouch"][6] = %run_2_crouch_90r;
	var_00["exposed_crouch"][7] = %run_2_crouch_idle_7;
	var_00["exposed_crouch"][8] = %run_2_crouch_180l;
	var_00["exposed_crouch"][9] = %run_2_crouch_idle_9;
	var_00["exposed_crouch_crouchwalk"] = [];
	var_00["exposed_crouch_crouchwalk"][1] = %crouchwalk_2_crouch_stop_1;
	var_00["exposed_crouch_crouchwalk"][2] = %crouchwalk_2_crouch_stop_2;
	var_00["exposed_crouch_crouchwalk"][3] = %crouchwalk_2_crouch_stop_3;
	var_00["exposed_crouch_crouchwalk"][4] = %crouchwalk_2_crouch_stop_4;
	var_00["exposed_crouch_crouchwalk"][6] = %crouchwalk_2_crouch_stop_6;
	var_00["exposed_crouch_crouchwalk"][7] = %crouchwalk_2_crouch_stop_7;
	var_00["exposed_crouch_crouchwalk"][8] = %crouchwalk_2_crouch_stop_8;
	var_00["exposed_crouch_crouchwalk"][9] = %crouchwalk_2_crouch_stop_9;
	var_00["exposed_cqb"] = [];
	var_00["exposed_cqb"][1] = %cqb_stop_1;
	var_00["exposed_cqb"][2] = %cqb_stop_2;
	var_00["exposed_cqb"][3] = %cqb_stop_3;
	var_00["exposed_cqb"][4] = %cqb_stop_4;
	var_00["exposed_cqb"][6] = %cqb_stop_6;
	var_00["exposed_cqb"][7] = %cqb_stop_7;
	var_00["exposed_cqb"][8] = %cqb_stop_8;
	var_00["exposed_cqb"][9] = %cqb_stop_9;
	var_00["exposed_crouch_cqb"] = [];
	var_00["exposed_crouch_cqb"][1] = %cqb_crouch_stop_1;
	var_00["exposed_crouch_cqb"][2] = %cqb_crouch_stop_2;
	var_00["exposed_crouch_cqb"][3] = %cqb_crouch_stop_3;
	var_00["exposed_crouch_cqb"][4] = %cqb_crouch_stop_4;
	var_00["exposed_crouch_cqb"][6] = %cqb_crouch_stop_6;
	var_00["exposed_crouch_cqb"][7] = %cqb_crouch_stop_7;
	var_00["exposed_crouch_cqb"][8] = %cqb_crouch_stop_8;
	var_00["exposed_crouch_cqb"][9] = %cqb_crouch_stop_9;
	var_00["exposed_unstable"] = [];
	var_00["exposed_unstable"][1] = %lag_unstable_moveforward_arrive_1;
	var_00["exposed_unstable"][2] = %lag_unstable_moveforward_arrive_2;
	var_00["exposed_unstable"][3] = %lag_unstable_moveforward_arrive_3;
	var_00["exposed_unstable"][4] = %lag_unstable_moveforward_arrive_4;
	var_00["exposed_unstable"][6] = %lag_unstable_moveforward_arrive_6;
	var_00["exposed_unstable"][7] = %lag_unstable_moveforward_arrive_7;
	var_00["exposed_unstable"][8] = %lag_unstable_moveforward_arrive_8;
	var_00["exposed_unstable"][9] = %lag_unstable_moveforward_arrive_9;
	var_00["exposed_unstable_run"] = [];
	var_00["exposed_unstable_run"][1] = %lag_unstable_run_arrive_1;
	var_00["exposed_unstable_run"][2] = %lag_unstable_run_arrive_2;
	var_00["exposed_unstable_run"][3] = %lag_unstable_run_arrive_3;
	var_00["exposed_unstable_run"][4] = %lag_unstable_run_arrive_4;
	var_00["exposed_unstable_run"][6] = %lag_unstable_run_arrive_6;
	var_00["exposed_unstable_run"][7] = %lag_unstable_run_arrive_7;
	var_00["exposed_unstable_run"][8] = %lag_unstable_run_arrive_8;
	var_00["exposed_unstable_run"][9] = %lag_unstable_run_arrive_9;
	var_00["heat"] = [];
	var_00["heat"][1] = %heat_approach_1;
	var_00["heat"][2] = %heat_approach_2;
	var_00["heat"][3] = %heat_approach_3;
	var_00["heat"][4] = %heat_approach_4;
	var_00["heat"][6] = %heat_approach_6;
	var_00["heat"][8] = %heat_approach_8;
	var_00["heat_left"] = [];
	var_00["heat_right"] = [];
	var_00["wall_over_96"][1] = %traverse90_in_ml;
	var_00["wall_over_96"][2] = %traverse90_in_m;
	var_00["wall_over_96"][3] = %traverse90_in_mr;
	level.traverseinfo["wall_over_96"]["height"] = 96;
	var_00["wall_over_40"][1] = %traverse_window_m_2_run;
	var_00["wall_over_40"][2] = %traverse_window_m_2_run;
	var_00["wall_over_40"][3] = %traverse_window_m_2_run;
	level.archetypes["soldier"]["cover_trans"] = var_00;
}

//Function Number: 3
initsoldierexit()
{
	var_00 = [];
	var_00["right"][1] = %corner_standr_trans_out_1;
	var_00["right"][2] = %corner_standr_trans_out_2;
	var_00["right"][3] = %corner_standr_trans_out_3;
	var_00["right"][4] = %corner_standr_trans_out_4;
	var_00["right"][6] = %corner_standr_trans_out_6;
	var_00["right"][8] = %corner_standr_trans_out_8;
	var_00["right"][9] = %corner_standr_trans_out_9;
	var_00["right_crouch"][1] = %cornercrr_trans_out_ml;
	var_00["right_crouch"][2] = %cornercrr_trans_out_m;
	var_00["right_crouch"][3] = %cornercrr_trans_out_mr;
	var_00["right_crouch"][4] = %cornercrr_trans_out_l;
	var_00["right_crouch"][6] = %cornercrr_trans_out_r;
	var_00["right_crouch"][8] = %cornercrr_trans_out_f;
	var_00["right_crouch"][9] = %cornercrr_trans_out_mf;
	var_00["right_cqb"][1] = %corner_standr_trans_cqb_out_1;
	var_00["right_cqb"][2] = %corner_standr_trans_cqb_out_2;
	var_00["right_cqb"][3] = %corner_standr_trans_cqb_out_3;
	var_00["right_cqb"][4] = %corner_standr_trans_cqb_out_4;
	var_00["right_cqb"][6] = %corner_standr_trans_cqb_out_6;
	var_00["right_cqb"][8] = %corner_standr_trans_cqb_out_8;
	var_00["right_cqb"][9] = %corner_standr_trans_cqb_out_9;
	var_00["right_crouch_cqb"][1] = %cornercrr_cqb_trans_out_1;
	var_00["right_crouch_cqb"][2] = %cornercrr_cqb_trans_out_2;
	var_00["right_crouch_cqb"][3] = %cornercrr_cqb_trans_out_3;
	var_00["right_crouch_cqb"][4] = %cornercrr_cqb_trans_out_4;
	var_00["right_crouch_cqb"][6] = %cornercrr_cqb_trans_out_6;
	var_00["right_crouch_cqb"][8] = %cornercrr_cqb_trans_out_8;
	var_00["right_crouch_cqb"][9] = %cornercrr_cqb_trans_out_9;
	var_00["left"][1] = %corner_standl_trans_out_1;
	var_00["left"][2] = %corner_standl_trans_out_2;
	var_00["left"][3] = %corner_standl_trans_out_3;
	var_00["left"][4] = %corner_standl_trans_out_4;
	var_00["left"][6] = %corner_standl_trans_out_6;
	var_00["left"][7] = %corner_standl_trans_out_7;
	var_00["left"][8] = %corner_standl_trans_out_8;
	var_00["left_crouch"][1] = %cornercrl_trans_out_ml;
	var_00["left_crouch"][2] = %cornercrl_trans_out_m;
	var_00["left_crouch"][3] = %cornercrl_trans_out_mr;
	var_00["left_crouch"][4] = %cornercrl_trans_out_l;
	var_00["left_crouch"][6] = %cornercrl_trans_out_r;
	var_00["left_crouch"][7] = %cornercrl_trans_out_mf;
	var_00["left_crouch"][8] = %cornercrl_trans_out_f;
	var_00["left_cqb"][1] = %corner_standl_trans_cqb_out_1;
	var_00["left_cqb"][2] = %corner_standl_trans_cqb_out_2;
	var_00["left_cqb"][3] = %corner_standl_trans_cqb_out_3;
	var_00["left_cqb"][4] = %corner_standl_trans_cqb_out_4;
	var_00["left_cqb"][6] = %corner_standl_trans_cqb_out_6;
	var_00["left_cqb"][7] = %corner_standl_trans_cqb_out_7;
	var_00["left_cqb"][8] = %corner_standl_trans_cqb_out_8;
	var_00["left_crouch_cqb"][1] = %cornercrl_cqb_trans_out_1;
	var_00["left_crouch_cqb"][2] = %cornercrl_cqb_trans_out_2;
	var_00["left_crouch_cqb"][3] = %cornercrl_cqb_trans_out_3;
	var_00["left_crouch_cqb"][4] = %cornercrl_cqb_trans_out_4;
	var_00["left_crouch_cqb"][6] = %cornercrl_cqb_trans_out_6;
	var_00["left_crouch_cqb"][7] = %cornercrl_cqb_trans_out_7;
	var_00["left_crouch_cqb"][8] = %cornercrl_cqb_trans_out_8;
	var_00["crouch"][1] = %covercrouch_run_out_ml;
	var_00["crouch"][2] = %covercrouch_run_out_m;
	var_00["crouch"][3] = %covercrouch_run_out_mr;
	var_00["crouch"][4] = %covercrouch_run_out_l;
	var_00["crouch"][6] = %covercrouch_run_out_r;
	var_00["stand"][1] = %coverstand_trans_out_ml;
	var_00["stand"][2] = %coverstand_trans_out_m;
	var_00["stand"][3] = %coverstand_trans_out_mr;
	var_00["stand"][4] = %coverstand_trans_out_l;
	var_00["stand"][6] = %coverstand_trans_out_r;
	var_00["stand_saw"][1] = %saw_gunner_runout_ml;
	var_00["stand_saw"][2] = %saw_gunner_runout_m;
	var_00["stand_saw"][3] = %saw_gunner_runout_mr;
	var_00["stand_saw"][4] = %saw_gunner_runout_l;
	var_00["stand_saw"][6] = %saw_gunner_runout_r;
	var_00["stand_unstable"] = [];
	var_00["stand_unstable"][1] = %lag_unstable_moveforward_exit_1;
	var_00["stand_unstable"][2] = %lag_unstable_moveforward_exit_2;
	var_00["stand_unstable"][3] = %lag_unstable_moveforward_exit_3;
	var_00["stand_unstable"][4] = %lag_unstable_moveforward_exit_4;
	var_00["stand_unstable"][6] = %lag_unstable_moveforward_exit_6;
	var_00["stand_unstable"][7] = %lag_unstable_moveforward_exit_7;
	var_00["stand_unstable"][8] = %lag_unstable_moveforward_exit_8;
	var_00["stand_unstable"][9] = %lag_unstable_moveforward_exit_9;
	var_00["stand_unstable_run"] = [];
	var_00["stand_unstable_run"][1] = %lag_unstable_run_exit_1;
	var_00["stand_unstable_run"][2] = %lag_unstable_run_exit_2;
	var_00["stand_unstable_run"][3] = %lag_unstable_run_exit_3;
	var_00["stand_unstable_run"][4] = %lag_unstable_run_exit_4;
	var_00["stand_unstable_run"][6] = %lag_unstable_run_exit_6;
	var_00["stand_unstable_run"][7] = %lag_unstable_run_exit_7;
	var_00["stand_unstable_run"][8] = %lag_unstable_run_exit_8;
	var_00["stand_unstable_run"][9] = %lag_unstable_run_exit_9;
	var_00["prone_saw"][2] = %saw_gunner_prone_runout_m;
	var_00["prone_saw"][4] = %saw_gunner_prone_runout_l;
	var_00["prone_saw"][6] = %saw_gunner_prone_runout_r;
	var_00["prone_saw"][8] = %saw_gunner_prone_runout_f;
	var_00["crouch_saw"][1] = %saw_gunner_lowwall_runout_ml;
	var_00["crouch_saw"][2] = %saw_gunner_lowwall_runout_m;
	var_00["crouch_saw"][3] = %saw_gunner_lowwall_runout_mr;
	var_00["crouch_saw"][4] = %saw_gunner_lowwall_runout_l;
	var_00["crouch_saw"][6] = %saw_gunner_lowwall_runout_r;
	var_00["exposed"] = [];
	var_00["exposed"][1] = %cqb_start_1;
	var_00["exposed"][2] = %stand_2_run_180l;
	var_00["exposed"][3] = %cqb_start_3;
	var_00["exposed"][4] = %stand_2_run_l;
	var_00["exposed"][6] = %stand_2_run_r;
	var_00["exposed"][7] = %cqb_start_7;
	var_00["exposed"][8] = %surprise_start_v1;
	var_00["exposed"][9] = %cqb_start_9;
	var_00["exposed_smg"] = [];
	var_00["exposed_smg"][1] = %cqb_start_1;
	var_00["exposed_smg"][2] = %smg_stand_2_run_180l;
	var_00["exposed_smg"][3] = %cqb_start_3;
	var_00["exposed_smg"][4] = %smg_stand_2_run_l;
	var_00["exposed_smg"][6] = %smg_stand_2_run_r;
	var_00["exposed_smg"][7] = %cqb_start_7;
	var_00["exposed_smg"][8] = %smg_stand_2_run_f_2;
	var_00["exposed_smg"][9] = %cqb_start_9;
	var_00["exposed_crouch"] = [];
	var_00["exposed_crouch"][1] = %cqb_crouch_start_1;
	var_00["exposed_crouch"][2] = %crouch_2run_180;
	var_00["exposed_crouch"][3] = %cqb_crouch_start_3;
	var_00["exposed_crouch"][4] = %crouch_2run_l;
	var_00["exposed_crouch"][6] = %crouch_2run_r;
	var_00["exposed_crouch"][7] = %cqb_crouch_start_7;
	var_00["exposed_crouch"][8] = %crouch_2run_f;
	var_00["exposed_crouch"][9] = %cqb_crouch_start_9;
	var_00["exposed_crouch_crouchwalk"] = [];
	var_00["exposed_crouch_crouchwalk"][1] = %crouchwalk_2_crouch_start_1;
	var_00["exposed_crouch_crouchwalk"][2] = %crouchwalk_2_crouch_start_2;
	var_00["exposed_crouch_crouchwalk"][3] = %crouchwalk_2_crouch_start_3;
	var_00["exposed_crouch_crouchwalk"][4] = %crouchwalk_2_crouch_start_4;
	var_00["exposed_crouch_crouchwalk"][6] = %crouchwalk_2_crouch_start_6;
	var_00["exposed_crouch_crouchwalk"][7] = %crouchwalk_2_crouch_start_7;
	var_00["exposed_crouch_crouchwalk"][8] = %crouchwalk_2_crouch_start_8;
	var_00["exposed_crouch_crouchwalk"][9] = %crouchwalk_2_crouch_start_9;
	var_00["exposed_cqb"] = [];
	var_00["exposed_cqb"][1] = %cqb_start_1;
	var_00["exposed_cqb"][2] = %cqb_start_2;
	var_00["exposed_cqb"][3] = %cqb_start_3;
	var_00["exposed_cqb"][4] = %cqb_start_4;
	var_00["exposed_cqb"][6] = %cqb_start_6;
	var_00["exposed_cqb"][7] = %cqb_start_7;
	var_00["exposed_cqb"][8] = %cqb_start_8;
	var_00["exposed_cqb"][9] = %cqb_start_9;
	var_00["exposed_crouch_cqb"] = [];
	var_00["exposed_crouch_cqb"][1] = %cqb_crouch_start_1;
	var_00["exposed_crouch_cqb"][2] = %cqb_crouch_start_2;
	var_00["exposed_crouch_cqb"][3] = %cqb_crouch_start_3;
	var_00["exposed_crouch_cqb"][4] = %cqb_crouch_start_4;
	var_00["exposed_crouch_cqb"][6] = %cqb_crouch_start_6;
	var_00["exposed_crouch_cqb"][7] = %cqb_crouch_start_7;
	var_00["exposed_crouch_cqb"][8] = %cqb_crouch_start_8;
	var_00["exposed_crouch_cqb"][9] = %cqb_crouch_start_9;
	var_00["exposed_unstable"] = [];
	var_00["exposed_unstable"][1] = %lag_unstable_moveforward_exit_1;
	var_00["exposed_unstable"][2] = %lag_unstable_moveforward_exit_2;
	var_00["exposed_unstable"][3] = %lag_unstable_moveforward_exit_3;
	var_00["exposed_unstable"][4] = %lag_unstable_moveforward_exit_4;
	var_00["exposed_unstable"][6] = %lag_unstable_moveforward_exit_6;
	var_00["exposed_unstable"][7] = %lag_unstable_moveforward_exit_7;
	var_00["exposed_unstable"][8] = %lag_unstable_moveforward_exit_8;
	var_00["exposed_unstable"][9] = %lag_unstable_moveforward_exit_9;
	var_00["exposed_unstable_run"] = [];
	var_00["exposed_unstable_run"][1] = %lag_unstable_run_exit_1;
	var_00["exposed_unstable_run"][2] = %lag_unstable_run_exit_2;
	var_00["exposed_unstable_run"][3] = %lag_unstable_run_exit_3;
	var_00["exposed_unstable_run"][4] = %lag_unstable_run_exit_4;
	var_00["exposed_unstable_run"][6] = %lag_unstable_run_exit_6;
	var_00["exposed_unstable_run"][7] = %lag_unstable_run_exit_7;
	var_00["exposed_unstable_run"][8] = %lag_unstable_run_exit_8;
	var_00["exposed_unstable_run"][9] = %lag_unstable_run_exit_9;
	var_00["heat"] = [];
	var_00["heat"][1] = %heat_exit_1;
	var_00["heat"][2] = %heat_exit_2;
	var_00["heat"][3] = %heat_exit_3;
	var_00["heat"][4] = %heat_exit_4;
	var_00["heat"][6] = %heat_exit_6;
	var_00["heat"][7] = %heat_exit_7;
	var_00["heat"][8] = %heat_exit_8;
	var_00["heat"][9] = %heat_exit_9;
	var_00["heat_left"] = [];
	var_00["heat_left"][1] = %heat_exit_1;
	var_00["heat_left"][2] = %heat_exit_2;
	var_00["heat_left"][3] = %heat_exit_3;
	var_00["heat_left"][4] = %heat_exit_4;
	var_00["heat_left"][6] = %heat_exit_6;
	var_00["heat_left"][7] = %heat_exit_8l;
	var_00["heat_left"][8] = %heat_exit_8l;
	var_00["heat_left"][9] = %heat_exit_8r;
	var_00["heat_right"] = [];
	var_00["heat_right"][1] = %heat_exit_1;
	var_00["heat_right"][2] = %heat_exit_2;
	var_00["heat_right"][3] = %heat_exit_3;
	var_00["heat_right"][4] = %heat_exit_4;
	var_00["heat_right"][6] = %heat_exit_6;
	var_00["heat_right"][7] = %heat_exit_8l;
	var_00["heat_right"][8] = %heat_exit_8r;
	var_00["heat_right"][9] = %heat_exit_8r;
	var_00["prone"] = [];
	var_00["prone"][1] = %h1_crawlstart_l90;
	var_00["prone"][2] = %h1_crawlstart_180;
	var_00["prone"][3] = %h1_crawlstart_180;
	var_00["prone"][4] = %h1_crawlstart_l90;
	var_00["prone"][6] = %h1_crawlstart_r90;
	var_00["prone"][7] = %h1_crawlstart_l45;
	var_00["prone"][8] = %h1_crawlstart_f_codemove;
	var_00["prone"][9] = %h1_crawlstart_r45;
	level.archetypes["soldier"]["cover_exit"] = var_00;
}

//Function Number: 4
getmoveend(param_00)
{
	var_01 = 0.5;
	var_02 = 0;
	var_03 = 1;
	var_04 = 0.05;
	var_05 = getanimlength(param_00);
	while(var_03 - var_02 * var_05 > var_04)
	{
		var_06 = getmovedelta(param_00,var_01,1);
		if(length2dsquared(var_06) < 1)
		{
			var_03 = var_01;
			continue;
		}

		var_02 = var_01;
		var_01 = var_03 - var_02 / 2 + var_02;
	}

	return var_03;
}

//Function Number: 5
inittransdistandanglesforarchetype(param_00)
{
	if(!isdefined(level.archetypes[param_00]))
	{
		return;
	}

	var_01 = [];
	var_01[0] = "left";
	var_01[1] = "right";
	var_01[2] = "left_crouch";
	var_01[3] = "right_crouch";
	var_01[4] = "crouch";
	var_01[5] = "stand";
	var_01[6] = "exposed";
	var_01[7] = "exposed_crouch";
	var_01[8] = "stand_saw";
	var_01[9] = "prone_saw";
	var_01[10] = "crouch_saw";
	var_01[11] = "wall_over_40";
	var_01[12] = "right_cqb";
	var_01[13] = "right_crouch_cqb";
	var_01[14] = "left_cqb";
	var_01[15] = "left_crouch_cqb";
	var_01[16] = "exposed_cqb";
	var_01[17] = "exposed_crouch_cqb";
	var_01[18] = "heat";
	var_01[19] = "heat_left";
	var_01[20] = "heat_right";
	var_01[21] = "exposed_ready";
	var_01[22] = "exposed_ready_cqb";
	var_01[23] = "exposed_smg";
	var_01[24] = "exposed_unstable";
	var_01[25] = "stand_unstable";
	var_01[26] = "exposed_unstable_run";
	var_01[27] = "stand_unstable_run";
	var_01[28] = "exposed_crouch_crouchwalk";
	var_01[29] = "prone";
	if(!isdefined(level.archetypes[param_00]["cover_trans"]))
	{
		return;
	}

	for(var_02 = 1;var_02 <= 6;var_02++)
	{
		if(var_02 == 5)
		{
			continue;
		}

		for(var_03 = 0;var_03 < var_01.size;var_03++)
		{
			var_04 = var_01[var_03];
			if(isdefined(level.archetypes[param_00]["cover_trans"][var_04]) && isdefined(level.archetypes[param_00]["cover_trans"][var_04][var_02]))
			{
				level.archetypes[param_00]["cover_trans_dist"][var_04][var_02] = getmovedelta(level.archetypes[param_00]["cover_trans"][var_04][var_02],0,1);
				level.archetypes[param_00]["cover_trans_angles"][var_04][var_02] = getangledelta(level.archetypes[param_00]["cover_trans"][var_04][var_02],0,1);
				level.archetypes[param_00]["cover_trans_move_end"][var_04][var_02] = getmoveend(level.archetypes[param_00]["cover_trans"][var_04][var_02]);
			}

			if(isdefined(level.archetypes[param_00]["cover_exit"][var_04]) && isdefined(level.archetypes[param_00]["cover_exit"][var_04][var_02]))
			{
				if(animhasnotetrack(level.archetypes[param_00]["cover_exit"][var_04][var_02],"code_move"))
				{
					var_05 = getnotetracktimes(level.archetypes[param_00]["cover_exit"][var_04][var_02],"code_move")[0];
				}
				else
				{
					var_05 = 1;
				}

				level.archetypes[param_00]["cover_exit_dist"][var_04][var_02] = getmovedelta(level.archetypes[param_00]["cover_exit"][var_04][var_02],0,var_05);
				level.archetypes[param_00]["cover_exit_angles"][var_04][var_02] = getangledelta(level.archetypes[param_00]["cover_exit"][var_04][var_02],0,1);
			}
		}
	}

	if(!isdefined(level.archetypes[param_00]["CoverTransLongestDist"]))
	{
		level.archetypes[param_00]["CoverTransLongestDist"] = [];
	}

	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		var_04 = var_01[var_03];
		level.archetypes[param_00]["CoverTransLongestDist"][var_04] = 0;
		for(var_02 = 1;var_02 <= 6;var_02++)
		{
			if(var_02 == 5 || !isdefined(level.archetypes[param_00]["cover_trans"][var_04]) || !isdefined(level.archetypes[param_00]["cover_trans"][var_04][var_02]))
			{
				continue;
			}

			var_06 = lengthsquared(level.archetypes[param_00]["cover_trans_dist"][var_04][var_02]);
			if(level.archetypes[param_00]["CoverTransLongestDist"][var_04] < var_06)
			{
				level.archetypes[param_00]["CoverTransLongestDist"][var_04] = var_06;
			}
		}

		level.archetypes[param_00]["CoverTransLongestDist"][var_04] = sqrt(level.archetypes[param_00]["CoverTransLongestDist"][var_04]);
	}

	level.exposedtransition["exposed"] = 1;
	level.exposedtransition["exposed_crouch"] = 1;
	level.exposedtransition["exposed_crouch_crouchwalk"] = 1;
	level.exposedtransition["exposed_cqb"] = 1;
	level.exposedtransition["exposed_crouch_cqb"] = 1;
	level.exposedtransition["exposed_ready_cqb"] = 1;
	level.exposedtransition["exposed_unstable"] = 1;
	level.exposedtransition["exposed_unstable_run"] = 1;
	level.exposedtransition["exposed_ready"] = 1;
	level.exposedtransition["exposed_smg"] = 1;
	level.exposedtransition["heat"] = 1;
	if(!isdefined(level.archetypes[param_00]["longestExposedApproachDist"]))
	{
		level.archetypes[param_00]["longestExposedApproachDist"] = 0;
	}

	foreach(var_04, var_08 in level.exposedtransition)
	{
		for(var_02 = 7;var_02 <= 9;var_02++)
		{
			if(isdefined(level.archetypes[param_00]["cover_trans"][var_04]) && isdefined(level.archetypes[param_00]["cover_trans"][var_04][var_02]))
			{
				level.archetypes[param_00]["cover_trans_dist"][var_04][var_02] = getmovedelta(level.archetypes[param_00]["cover_trans"][var_04][var_02],0,1);
				level.archetypes[param_00]["cover_trans_angles"][var_04][var_02] = getangledelta(level.archetypes[param_00]["cover_trans"][var_04][var_02],0,1);
				level.archetypes[param_00]["cover_trans_move_end"][var_04][var_02] = getmoveend(level.archetypes[param_00]["cover_trans"][var_04][var_02]);
			}

			if(isdefined(level.archetypes[param_00]["cover_exit"][var_04]) && isdefined(level.archetypes[param_00]["cover_exit"][var_04][var_02]))
			{
				var_09 = animhasnotetrack(level.archetypes[param_00]["cover_exit"][var_04][var_02],"code_move");
				var_05 = getnotetracktimes(level.archetypes[param_00]["cover_exit"][var_04][var_02],"code_move")[0];
				level.archetypes[param_00]["cover_exit_dist"][var_04][var_02] = getmovedelta(level.archetypes[param_00]["cover_exit"][var_04][var_02],0,var_05);
				level.archetypes[param_00]["cover_exit_angles"][var_04][var_02] = getangledelta(level.archetypes[param_00]["cover_exit"][var_04][var_02],0,1);
			}
		}

		for(var_02 = 1;var_02 <= 9;var_02++)
		{
			if(!isdefined(level.archetypes[param_00]["cover_trans"][var_04]) || !isdefined(level.archetypes[param_00]["cover_trans"][var_04][var_02]))
			{
				continue;
			}

			var_0A = length(level.archetypes[param_00]["cover_trans_dist"][var_04][var_02]);
			if(var_0A > level.archetypes[param_00]["longestExposedApproachDist"])
			{
				level.archetypes[param_00]["longestExposedApproachDist"] = var_0A;
			}
		}
	}
}

//Function Number: 6
initmovestartstoptransitions()
{
	init_move_transition_arrays();
	anim.approach_types = [];
	level.approach_types["Cover Left"] = [];
	level.approach_types["Cover Left"]["stand"] = "left";
	level.approach_types["Cover Left"]["crouch"] = "left_crouch";
	level.approach_types["Cover Wide Left"] = level.approach_types["Cover Left"];
	level.maxdirections["Cover Left"] = 9;
	level.excludedir["Cover Left"] = 9;
	level.approach_types["Cover Right"] = [];
	level.approach_types["Cover Right"]["stand"] = "right";
	level.approach_types["Cover Right"]["crouch"] = "right_crouch";
	level.approach_types["Cover Wide Right"] = level.approach_types["Cover Right"];
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
	level.approach_types["Guard"]["prone"] = "prone";
	level.approach_types["Ambush"] = level.approach_types["Path"];
	level.approach_types["Scripted"] = level.approach_types["Path"];
	level.approach_types["Exposed"] = level.approach_types["Path"];
	level.iscombatpathnode["Guard"] = 1;
	level.iscombatpathnode["Ambush"] = 1;
	level.iscombatpathnode["Exposed"] = 1;
	level.iscombatscriptnode["Guard"] = 1;
	level.iscombatscriptnode["Exposed"] = 1;
	initsoldierentrance();
	initsoldierexit();
	if(maps\_utility::s1_motionset_avaliable())
	{
		animscripts\s1_common_anims::initsoliders1entrance();
		animscripts\s1_common_anims::initsoliders1exit();
	}

	inittransdistandanglesforarchetype("soldier");
	if(maps\_utility::s1_motionset_avaliable())
	{
		inittransdistandanglesforarchetype("s1_soldier");
	}

	anim.splitarrivalsleft = [];
	level.splitarrivalsleft["left"] = 1;
	level.splitarrivalsleft["left_crouch"] = 1;
	level.splitarrivalsleft["left_crouch_cqb"] = 1;
	level.splitarrivalsleft["left_cqb"] = 1;
	anim.splitexitsleft = [];
	level.splitexitsleft["left"] = 1;
	level.splitexitsleft["left_crouch"] = 1;
	level.splitexitsleft["left_crouch_cqb"] = 1;
	level.splitexitsleft["left_cqb"] = 1;
	level.splitexitsleft["heat_left"] = 1;
	anim.splitarrivalsright = [];
	level.splitarrivalsright["right"] = 1;
	level.splitarrivalsright["right_crouch"] = 1;
	level.splitarrivalsright["right_cqb"] = 1;
	level.splitarrivalsright["right_crouch_cqb"] = 1;
	anim.splitexitsright = [];
	level.splitexitsright["right"] = 1;
	level.splitexitsright["right_crouch"] = 1;
	level.splitexitsright["right_cqb"] = 1;
	level.splitexitsright["right_crouch_cqb"] = 1;
	level.splitexitsright["heat_right"] = 1;
	getsplittimes("soldier");
	if(maps\_utility::s1_motionset_avaliable())
	{
		getsplittimes("s1_soldier");
	}

	level.arrivalendstance["left"] = "stand";
	level.arrivalendstance["left_cqb"] = "stand";
	level.arrivalendstance["right"] = "stand";
	level.arrivalendstance["right_cqb"] = "stand";
	level.arrivalendstance["stand"] = "stand";
	level.arrivalendstance["stand_saw"] = "stand";
	level.arrivalendstance["stand_unstable"] = "stand";
	level.arrivalendstance["exposed"] = "stand";
	level.arrivalendstance["exposed_cqb"] = "stand";
	level.arrivalendstance["exposed_smg"] = "stand";
	level.arrivalendstance["exposed_unstable"] = "stand";
	level.arrivalendstance["exposed_unstable_run"] = "stand";
	level.arrivalendstance["heat"] = "stand";
	level.arrivalendstance["left_crouch"] = "crouch";
	level.arrivalendstance["left_crouch_cqb"] = "crouch";
	level.arrivalendstance["right_crouch"] = "crouch";
	level.arrivalendstance["right_crouch_cqb"] = "crouch";
	level.arrivalendstance["crouch_saw"] = "crouch";
	level.arrivalendstance["crouch"] = "crouch";
	level.arrivalendstance["exposed_crouch"] = "crouch";
	level.arrivalendstance["exposed_crouch_crouchwalk"] = "crouch";
	level.arrivalendstance["exposed_crouch_cqb"] = "crouch";
	level.arrivalendstance["prone_saw"] = "prone";
	level.arrivalendstance["exposed_ready"] = "stand";
	level.arrivalendstance["exposed_ready_cqb"] = "stand";
	level.requiredexitstance["Cover Stand"] = "stand";
	level.requiredexitstance["Conceal Stand"] = "stand";
	level.requiredexitstance["Cover Crouch"] = "crouch";
	level.requiredexitstance["Conceal Crouch"] = "crouch";
}

//Function Number: 7
getsplittimes(param_00)
{
	getsplittimesside(param_00,7,8,0,level.splitarrivalsleft,level.splitexitsleft);
	getsplittimesside(param_00,8,9,1,level.splitarrivalsright,level.splitexitsright);
}

//Function Number: 8
getsplitdeltas(param_00,param_01)
{
	var_02 = 1;
	if(animhasnotetrack(param_00,"code_move"))
	{
		var_02 = getnotetracktimes(param_00,"code_move")[0];
	}

	var_03 = spawnstruct();
	var_03.predist = getmovedelta(param_00,0,param_01);
	var_03.postdist = getmovedelta(param_00,0,var_02) - var_03.predist;
	var_03.angledelta = getangledelta(param_00,0,1);
	return var_03;
}

//Function Number: 9
getsplittimesside(param_00,param_01,param_02,param_03,param_04,param_05)
{
	for(var_06 = param_01;var_06 <= param_02;var_06++)
	{
		if(isdefined(level.archetypes[param_00]["cover_trans"]))
		{
			foreach(var_0B, var_08 in param_04)
			{
				if(issubstr(var_0B,"heat"))
				{
					continue;
				}

				if(isdefined(level.archetypes[param_00]["cover_trans"][var_0B]) && isdefined(level.archetypes[param_00]["cover_trans"][var_0B][var_06]))
				{
					var_09 = findbestsplittime(level.archetypes[param_00]["cover_trans"][var_0B][var_06],1,param_03);
					var_0A = getsplitdeltas(level.archetypes[param_00]["cover_trans"][var_0B][var_06],var_09);
					level.archetypes[param_00]["cover_trans_predist"][var_0B][var_06] = var_0A.predist;
					level.archetypes[param_00]["cover_trans_dist"][var_0B][var_06] = var_0A.postdist;
					level.archetypes[param_00]["cover_trans_angles"][var_0B][var_06] = var_0A.angledelta;
					level.archetypes[param_00]["cover_trans_move_end"][var_0B][var_06] = getmoveend(level.archetypes[param_00]["cover_trans"][var_0B][var_06]);
				}
			}
		}

		if(isdefined(level.archetypes[param_00]["cover_exit"]))
		{
			foreach(var_0B, var_08 in param_05)
			{
				if(issubstr(var_0B,"heat"))
				{
					continue;
				}

				if(isdefined(level.archetypes[param_00]["cover_exit"][var_0B]) && isdefined(level.archetypes[param_00]["cover_exit"][var_0B][var_06]))
				{
					var_09 = findbestsplittime(level.archetypes[param_00]["cover_exit"][var_0B][var_06],0,param_03);
					var_0A = getsplitdeltas(level.archetypes[param_00]["cover_exit"][var_0B][var_06],var_09);
					level.archetypes[param_00]["cover_exit_dist"][var_0B][var_06] = var_0A.predist;
					level.archetypes[param_00]["cover_exit_postdist"][var_0B][var_06] = var_0A.postdist;
					level.archetypes[param_00]["cover_exit_angles"][var_0B][var_06] = var_0A.angledelta;
				}
			}
		}
	}
}

//Function Number: 10
findbestsplittime(param_00,param_01,param_02)
{
	var_03 = getangledelta(param_00,0,1);
	var_04 = getmovedelta(param_00,0,1);
	var_05 = 1000;
	var_06 = -1;
	var_07 = -100000000;
	var_08 = (0,0,0);
	for(var_09 = 0;var_09 < var_05;var_09++)
	{
		var_0A = 1 * var_09 / var_05 - 1;
		var_0B = getmovedelta(param_00,0,var_0A);
		if(param_01)
		{
			var_0B = deltarotate(var_04 - var_0B,180 - var_03);
		}

		if(param_02)
		{
			var_0B = (var_0B[0],0 - var_0B[1],var_0B[2]);
		}

		var_0C = min(var_0B[0] - 32,var_0B[1]);
		if(var_0C > var_07 || var_06 < 0)
		{
			var_07 = var_0C;
			var_06 = var_0A;
			var_08 = var_0B;
		}
	}

	return var_06;
}

//Function Number: 11
deltarotate(param_00,param_01)
{
	var_02 = cos(param_01);
	var_03 = sin(param_01);
	return (param_00[0] * var_02 - param_00[1] * var_03,param_00[1] * var_02 + param_00[0] * var_03,0);
}