/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\init_move_transitions.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 5
 * Decompile Time: 112 ms
 * Timestamp: 10/27/2023 2:30:27 AM
*******************************************************************/

//Function Number: 1
init_move_transition_arrays()
{
	if(isdefined(level.var_1C05))
	{
		return;
	}

	anim.var_1C05 = 1;
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
	anim.var_1C06 = [];
	if(!isdefined(level.covertranslongestdist))
	{
		anim.covertranslongestdist = [];
	}

	if(!isdefined(level.covertransdist))
	{
		anim.covertransdist = [];
	}

	if(!isdefined(level.coverexitdist))
	{
		anim.coverexitdist = [];
	}

	anim.var_D98 = [];
	anim.var_D9B = [];
	if(!isdefined(level.var_D72))
	{
		anim.var_D72 = [];
	}

	if(!isdefined(level.coverexitangles))
	{
		anim.coverexitangles = [];
	}

	anim.var_1C07 = [];
	anim.covertranssplit = [];
	anim.arrivalendstance = [];
}

//Function Number: 2
initmovestartstoptransitions()
{
	init_move_transition_arrays();
	level.newarrivals = 1;
	var_00 = [];
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
	level.iscombatpathnode["Guard"] = 1;
	level.iscombatpathnode["Ambush"] = 1;
	level.iscombatpathnode["Exposed"] = 1;
	level.iscombatscriptnode["Guard"] = 1;
	level.iscombatscriptnode["Exposed"] = 1;
	level.covertrans["right"][1] = %corner_standr_trans_in_1;
	level.covertrans["right"][2] = %corner_standr_trans_in_2;
	level.covertrans["right"][3] = %corner_standr_trans_in_3;
	level.covertrans["right"][4] = %corner_standr_trans_in_4;
	level.covertrans["right"][6] = %corner_standr_trans_in_6;
	level.covertrans["right"][8] = %corner_standr_trans_in_8;
	level.covertrans["right"][9] = %corner_standr_trans_in_9;
	level.covertrans["right_crouch"][1] = %cornercrr_trans_in_ml;
	level.covertrans["right_crouch"][2] = %cornercrr_trans_in_m;
	level.covertrans["right_crouch"][3] = %cornercrr_trans_in_mr;
	level.covertrans["right_crouch"][4] = %cornercrr_trans_in_l;
	level.covertrans["right_crouch"][6] = %cornercrr_trans_in_r;
	level.covertrans["right_crouch"][8] = %cornercrr_trans_in_f;
	level.covertrans["right_crouch"][9] = %cornercrr_trans_in_mf;
	level.covertrans["right_cqb"][1] = %corner_standr_trans_cqb_in_1;
	level.covertrans["right_cqb"][2] = %corner_standr_trans_cqb_in_2;
	level.covertrans["right_cqb"][3] = %corner_standr_trans_cqb_in_3;
	level.covertrans["right_cqb"][4] = %corner_standr_trans_cqb_in_4;
	level.covertrans["right_cqb"][6] = %corner_standr_trans_cqb_in_6;
	level.covertrans["right_cqb"][8] = %corner_standr_trans_cqb_in_8;
	level.covertrans["right_cqb"][9] = %corner_standr_trans_cqb_in_9;
	level.covertrans["right_crouch_cqb"][1] = %cornercrr_cqb_trans_in_1;
	level.covertrans["right_crouch_cqb"][2] = %cornercrr_cqb_trans_in_2;
	level.covertrans["right_crouch_cqb"][3] = %cornercrr_cqb_trans_in_3;
	level.covertrans["right_crouch_cqb"][4] = %cornercrr_cqb_trans_in_4;
	level.covertrans["right_crouch_cqb"][6] = %cornercrr_cqb_trans_in_6;
	level.covertrans["right_crouch_cqb"][8] = %cornercrr_cqb_trans_in_8;
	level.covertrans["right_crouch_cqb"][9] = %cornercrr_cqb_trans_in_9;
	level.covertrans["left"][1] = %corner_standl_trans_in_1;
	level.covertrans["left"][2] = %corner_standl_trans_in_2;
	level.covertrans["left"][3] = %corner_standl_trans_in_3;
	level.covertrans["left"][4] = %corner_standl_trans_in_4;
	level.covertrans["left"][6] = %corner_standl_trans_in_6;
	level.covertrans["left"][7] = %corner_standl_trans_in_7;
	level.covertrans["left"][8] = %corner_standl_trans_in_8;
	level.covertrans["left_crouch"][1] = %cornercrl_trans_in_ml;
	level.covertrans["left_crouch"][2] = %cornercrl_trans_in_m;
	level.covertrans["left_crouch"][3] = %cornercrl_trans_in_mr;
	level.covertrans["left_crouch"][4] = %cornercrl_trans_in_l;
	level.covertrans["left_crouch"][6] = %cornercrl_trans_in_r;
	level.covertrans["left_crouch"][7] = %cornercrl_trans_in_mf;
	level.covertrans["left_crouch"][8] = %cornercrl_trans_in_f;
	level.covertrans["left_cqb"][1] = %corner_standl_trans_cqb_in_1;
	level.covertrans["left_cqb"][2] = %corner_standl_trans_cqb_in_2;
	level.covertrans["left_cqb"][3] = %corner_standl_trans_cqb_in_3;
	level.covertrans["left_cqb"][4] = %corner_standl_trans_cqb_in_4;
	level.covertrans["left_cqb"][6] = %corner_standl_trans_cqb_in_6;
	level.covertrans["left_cqb"][7] = %corner_standl_trans_cqb_in_7;
	level.covertrans["left_cqb"][8] = %corner_standl_trans_cqb_in_8;
	level.covertrans["left_crouch_cqb"][1] = %cornercrl_cqb_trans_in_1;
	level.covertrans["left_crouch_cqb"][2] = %cornercrl_cqb_trans_in_2;
	level.covertrans["left_crouch_cqb"][3] = %cornercrl_cqb_trans_in_3;
	level.covertrans["left_crouch_cqb"][4] = %cornercrl_cqb_trans_in_4;
	level.covertrans["left_crouch_cqb"][6] = %cornercrl_cqb_trans_in_6;
	level.covertrans["left_crouch_cqb"][7] = %cornercrl_cqb_trans_in_7;
	level.covertrans["left_crouch_cqb"][8] = %cornercrl_cqb_trans_in_8;
	level.covertrans["crouch"][1] = %covercrouch_run_in_ml;
	level.covertrans["crouch"][2] = %covercrouch_run_in_m;
	level.covertrans["crouch"][3] = %covercrouch_run_in_mr;
	level.covertrans["crouch"][4] = %covercrouch_run_in_l;
	level.covertrans["crouch"][6] = %covercrouch_run_in_r;
	level.covertrans["stand"][1] = %coverstand_trans_in_ml;
	level.covertrans["stand"][2] = %coverstand_trans_in_m;
	level.covertrans["stand"][3] = %coverstand_trans_in_mr;
	level.covertrans["stand"][4] = %coverstand_trans_in_l;
	level.covertrans["stand"][6] = %coverstand_trans_in_r;
	level.covertrans["stand_saw"][1] = %saw_gunner_runin_ml;
	level.covertrans["stand_saw"][2] = %saw_gunner_runin_m;
	level.covertrans["stand_saw"][3] = %saw_gunner_runin_mr;
	level.covertrans["stand_saw"][4] = %saw_gunner_runin_l;
	level.covertrans["stand_saw"][6] = %saw_gunner_runin_r;
	level.covertrans["crouch_saw"][1] = %saw_gunner_lowwall_runin_ml;
	level.covertrans["crouch_saw"][2] = %saw_gunner_lowwall_runin_m;
	level.covertrans["crouch_saw"][3] = %saw_gunner_lowwall_runin_mr;
	level.covertrans["crouch_saw"][4] = %saw_gunner_lowwall_runin_l;
	level.covertrans["crouch_saw"][6] = %saw_gunner_lowwall_runin_r;
	level.covertrans["prone_saw"][1] = %saw_gunner_prone_runin_ml;
	level.covertrans["prone_saw"][2] = %saw_gunner_prone_runin_m;
	level.covertrans["prone_saw"][3] = %saw_gunner_prone_runin_mr;
	level.covertrans["exposed"] = [];
	level.covertrans["exposed"][1] = %cqb_stop_1;
	level.covertrans["exposed"][2] = %run_2_stand_f_6;
	level.covertrans["exposed"][3] = %cqb_stop_3;
	level.covertrans["exposed"][4] = %run_2_stand_90l;
	level.covertrans["exposed"][6] = %run_2_stand_90r;
	level.covertrans["exposed"][7] = %cqb_stop_7;
	level.covertrans["exposed"][8] = %run_2_stand_180l;
	level.covertrans["exposed"][9] = %cqb_stop_9;
	level.covertrans["exposed_crouch"] = [];
	level.covertrans["exposed_crouch"][1] = %cqb_crouch_stop_1;
	level.covertrans["exposed_crouch"][2] = %run_2_crouch_f;
	level.covertrans["exposed_crouch"][3] = %cqb_crouch_stop_3;
	level.covertrans["exposed_crouch"][4] = %run_2_crouch_90l;
	level.covertrans["exposed_crouch"][6] = %run_2_crouch_90r;
	level.covertrans["exposed_crouch"][7] = %cqb_crouch_stop_7;
	level.covertrans["exposed_crouch"][8] = %run_2_crouch_180l;
	level.covertrans["exposed_crouch"][9] = %cqb_crouch_stop_9;
	level.covertrans["exposed_cqb"] = [];
	level.covertrans["exposed_cqb"][1] = %cqb_stop_1;
	level.covertrans["exposed_cqb"][2] = %cqb_stop_2;
	level.covertrans["exposed_cqb"][3] = %cqb_stop_3;
	level.covertrans["exposed_cqb"][4] = %cqb_stop_4;
	level.covertrans["exposed_cqb"][6] = %cqb_stop_6;
	level.covertrans["exposed_cqb"][7] = %cqb_stop_7;
	level.covertrans["exposed_cqb"][8] = %cqb_stop_8;
	level.covertrans["exposed_cqb"][9] = %cqb_stop_9;
	level.covertrans["exposed_crouch_cqb"] = [];
	level.covertrans["exposed_crouch_cqb"][1] = %cqb_crouch_stop_1;
	level.covertrans["exposed_crouch_cqb"][2] = %cqb_crouch_stop_2;
	level.covertrans["exposed_crouch_cqb"][3] = %cqb_crouch_stop_3;
	level.covertrans["exposed_crouch_cqb"][4] = %cqb_crouch_stop_4;
	level.covertrans["exposed_crouch_cqb"][6] = %cqb_crouch_stop_6;
	level.covertrans["exposed_crouch_cqb"][7] = %cqb_crouch_stop_7;
	level.covertrans["exposed_crouch_cqb"][8] = %cqb_crouch_stop_8;
	level.covertrans["exposed_crouch_cqb"][9] = %cqb_crouch_stop_9;
	level.covertrans["heat"] = [];
	level.covertrans["heat"][1] = %heat_approach_1;
	level.covertrans["heat"][2] = %heat_approach_2;
	level.covertrans["heat"][3] = %heat_approach_3;
	level.covertrans["heat"][4] = %heat_approach_4;
	level.covertrans["heat"][6] = %heat_approach_6;
	level.covertrans["heat"][8] = %heat_approach_8;
	level.covertrans["heat_left"] = [];
	level.covertrans["heat_right"] = [];
	anim.coverstepinanim = [];
	level.coverstepinanim["right"] = %corner_standr_trans_b_2_alert;
	level.coverstepinanim["right_crouch"] = %cornercrr_trans_b_2_alert;
	level.coverstepinanim["left"] = %corner_standl_trans_b_2_alert_v2;
	level.coverstepinanim["left_crouch"] = %cornercrl_trans_b_2_alert;
	level.coverstepinanim["crouch"] = %covercrouch_aim_2_hide;
	level.coverstepinanim["stand"] = %coverstand_aim_2_hide;
	anim.coverstepinoffsets = [];
	anim.coverstepinangles = [];
	for(var_02 = 0;var_02 < var_01;var_02++ = var_41[22])
	{
		var_03 = var_41[var_02];
		level.coverstepinoffsets[var_03] = getmovedelta(level.coverstepinanim[var_03],0,1);
		level.coverstepinangles[var_03] = getangledelta(level.coverstepinanim[var_03],0,1);
	}

	level.coverstepinangles["right"] = level.coverstepinangles["right"] + 90;
	level.coverstepinangles["right_crouch"] = level.coverstepinangles["right_crouch"] + 90;
	level.coverstepinangles["left"] = level.coverstepinangles["left"] - 90;
	level.coverstepinangles["left_crouch"] = level.coverstepinangles["left_crouch"] - 90;
	level.covertrans["wall_over_96"][1] = %traverse90_in_ml;
	level.covertrans["wall_over_96"][2] = %traverse90_in_m;
	level.covertrans["wall_over_96"][3] = %traverse90_in_mr;
	level.var_1C06["wall_over_96"]["height"] = 96;
	level.covertrans["wall_over_40"][1] = %traverse_window_m_2_run;
	level.covertrans["wall_over_40"][2] = %traverse_window_m_2_run;
	level.covertrans["wall_over_40"][3] = %traverse_window_m_2_run;
	level.coverexit["right"][1] = %corner_standr_trans_out_1;
	level.coverexit["right"][2] = %corner_standr_trans_out_2;
	level.coverexit["right"][3] = %corner_standr_trans_out_3;
	level.coverexit["right"][4] = %corner_standr_trans_out_4;
	level.coverexit["right"][6] = %corner_standr_trans_out_6;
	level.coverexit["right"][8] = %corner_standr_trans_out_8;
	level.coverexit["right"][9] = %corner_standr_trans_out_9;
	level.coverexit["right_crouch"][1] = %cornercrr_trans_out_ml;
	level.coverexit["right_crouch"][2] = %cornercrr_trans_out_m;
	level.coverexit["right_crouch"][3] = %cornercrr_trans_out_mr;
	level.coverexit["right_crouch"][4] = %cornercrr_trans_out_l;
	level.coverexit["right_crouch"][6] = %cornercrr_trans_out_r;
	level.coverexit["right_crouch"][8] = %cornercrr_trans_out_f;
	level.coverexit["right_crouch"][9] = %cornercrr_trans_out_mf;
	level.coverexit["right_cqb"][1] = %corner_standr_trans_cqb_out_1;
	level.coverexit["right_cqb"][2] = %corner_standr_trans_cqb_out_2;
	level.coverexit["right_cqb"][3] = %corner_standr_trans_cqb_out_3;
	level.coverexit["right_cqb"][4] = %corner_standr_trans_cqb_out_4;
	level.coverexit["right_cqb"][6] = %corner_standr_trans_cqb_out_6;
	level.coverexit["right_cqb"][8] = %corner_standr_trans_cqb_out_8;
	level.coverexit["right_cqb"][9] = %corner_standr_trans_cqb_out_9;
	level.coverexit["right_crouch_cqb"][1] = %cornercrr_cqb_trans_out_1;
	level.coverexit["right_crouch_cqb"][2] = %cornercrr_cqb_trans_out_2;
	level.coverexit["right_crouch_cqb"][3] = %cornercrr_cqb_trans_out_3;
	level.coverexit["right_crouch_cqb"][4] = %cornercrr_cqb_trans_out_4;
	level.coverexit["right_crouch_cqb"][6] = %cornercrr_cqb_trans_out_6;
	level.coverexit["right_crouch_cqb"][8] = %cornercrr_cqb_trans_out_8;
	level.coverexit["right_crouch_cqb"][9] = %cornercrr_cqb_trans_out_9;
	level.coverexit["left"][1] = %corner_standl_trans_out_1;
	level.coverexit["left"][2] = %corner_standl_trans_out_2;
	level.coverexit["left"][3] = %corner_standl_trans_out_3;
	level.coverexit["left"][4] = %corner_standl_trans_out_4;
	level.coverexit["left"][6] = %corner_standl_trans_out_6;
	level.coverexit["left"][7] = %corner_standl_trans_out_7;
	level.coverexit["left"][8] = %corner_standl_trans_out_8;
	level.coverexit["left_crouch"][1] = %cornercrl_trans_out_ml;
	level.coverexit["left_crouch"][2] = %cornercrl_trans_out_m;
	level.coverexit["left_crouch"][3] = %cornercrl_trans_out_mr;
	level.coverexit["left_crouch"][4] = %cornercrl_trans_out_l;
	level.coverexit["left_crouch"][6] = %cornercrl_trans_out_r;
	level.coverexit["left_crouch"][7] = %cornercrl_trans_out_mf;
	level.coverexit["left_crouch"][8] = %cornercrl_trans_out_f;
	level.coverexit["left_cqb"][1] = %corner_standl_trans_cqb_out_1;
	level.coverexit["left_cqb"][2] = %corner_standl_trans_cqb_out_2;
	level.coverexit["left_cqb"][3] = %corner_standl_trans_cqb_out_3;
	level.coverexit["left_cqb"][4] = %corner_standl_trans_cqb_out_4;
	level.coverexit["left_cqb"][6] = %corner_standl_trans_cqb_out_6;
	level.coverexit["left_cqb"][7] = %corner_standl_trans_cqb_out_7;
	level.coverexit["left_cqb"][8] = %corner_standl_trans_cqb_out_8;
	level.coverexit["left_crouch_cqb"][1] = %cornercrl_cqb_trans_out_1;
	level.coverexit["left_crouch_cqb"][2] = %cornercrl_cqb_trans_out_2;
	level.coverexit["left_crouch_cqb"][3] = %cornercrl_cqb_trans_out_3;
	level.coverexit["left_crouch_cqb"][4] = %cornercrl_cqb_trans_out_4;
	level.coverexit["left_crouch_cqb"][6] = %cornercrl_cqb_trans_out_6;
	level.coverexit["left_crouch_cqb"][7] = %cornercrl_cqb_trans_out_7;
	level.coverexit["left_crouch_cqb"][8] = %cornercrl_cqb_trans_out_8;
	level.coverexit["crouch"][1] = %covercrouch_run_out_ml;
	level.coverexit["crouch"][2] = %covercrouch_run_out_m;
	level.coverexit["crouch"][3] = %covercrouch_run_out_mr;
	level.coverexit["crouch"][4] = %covercrouch_run_out_l;
	level.coverexit["crouch"][6] = %covercrouch_run_out_r;
	level.coverexit["stand"][1] = %coverstand_trans_out_ml;
	level.coverexit["stand"][2] = %coverstand_trans_out_m;
	level.coverexit["stand"][3] = %coverstand_trans_out_mr;
	level.coverexit["stand"][4] = %coverstand_trans_out_l;
	level.coverexit["stand"][6] = %coverstand_trans_out_r;
	level.coverexit["stand_saw"][1] = %saw_gunner_runout_ml;
	level.coverexit["stand_saw"][2] = %saw_gunner_runout_m;
	level.coverexit["stand_saw"][3] = %saw_gunner_runout_mr;
	level.coverexit["stand_saw"][4] = %saw_gunner_runout_l;
	level.coverexit["stand_saw"][6] = %saw_gunner_runout_r;
	level.coverexit["prone_saw"][2] = %saw_gunner_prone_runout_m;
	level.coverexit["prone_saw"][4] = %saw_gunner_prone_runout_l;
	level.coverexit["prone_saw"][6] = %saw_gunner_prone_runout_r;
	level.coverexit["prone_saw"][8] = %saw_gunner_prone_runout_f;
	level.coverexit["crouch_saw"][1] = %saw_gunner_lowwall_runout_ml;
	level.coverexit["crouch_saw"][2] = %saw_gunner_lowwall_runout_m;
	level.coverexit["crouch_saw"][3] = %saw_gunner_lowwall_runout_mr;
	level.coverexit["crouch_saw"][4] = %saw_gunner_lowwall_runout_l;
	level.coverexit["crouch_saw"][6] = %saw_gunner_lowwall_runout_r;
	level.coverexit["exposed"] = [];
	level.coverexit["exposed"][1] = %cqb_start_1;
	level.coverexit["exposed"][2] = %stand_2_run_180l;
	level.coverexit["exposed"][3] = %cqb_start_3;
	level.coverexit["exposed"][4] = %stand_2_run_l;
	level.coverexit["exposed"][6] = %stand_2_run_r;
	level.coverexit["exposed"][7] = %cqb_start_7;
	level.coverexit["exposed"][8] = %surprise_start_v1;
	level.coverexit["exposed"][9] = %cqb_start_9;
	level.coverexit["exposed_crouch"] = [];
	level.coverexit["exposed_crouch"][1] = %cqb_crouch_start_1;
	level.coverexit["exposed_crouch"][2] = %crouch_2run_180;
	level.coverexit["exposed_crouch"][3] = %cqb_crouch_start_3;
	level.coverexit["exposed_crouch"][4] = %crouch_2run_l;
	level.coverexit["exposed_crouch"][6] = %crouch_2run_r;
	level.coverexit["exposed_crouch"][7] = %cqb_crouch_start_7;
	level.coverexit["exposed_crouch"][8] = %crouch_2run_f;
	level.coverexit["exposed_crouch"][9] = %cqb_crouch_start_9;
	level.coverexit["exposed_cqb"] = [];
	level.coverexit["exposed_cqb"][1] = %cqb_start_1;
	level.coverexit["exposed_cqb"][2] = %cqb_start_2;
	level.coverexit["exposed_cqb"][3] = %cqb_start_3;
	level.coverexit["exposed_cqb"][4] = %cqb_start_4;
	level.coverexit["exposed_cqb"][6] = %cqb_start_6;
	level.coverexit["exposed_cqb"][7] = %cqb_start_7;
	level.coverexit["exposed_cqb"][8] = %cqb_start_8;
	level.coverexit["exposed_cqb"][9] = %cqb_start_9;
	level.coverexit["exposed_crouch_cqb"] = [];
	level.coverexit["exposed_crouch_cqb"][1] = %cqb_crouch_start_1;
	level.coverexit["exposed_crouch_cqb"][2] = %cqb_crouch_start_2;
	level.coverexit["exposed_crouch_cqb"][3] = %cqb_crouch_start_3;
	level.coverexit["exposed_crouch_cqb"][4] = %cqb_crouch_start_4;
	level.coverexit["exposed_crouch_cqb"][6] = %cqb_crouch_start_6;
	level.coverexit["exposed_crouch_cqb"][7] = %cqb_crouch_start_7;
	level.coverexit["exposed_crouch_cqb"][8] = %cqb_crouch_start_8;
	level.coverexit["exposed_crouch_cqb"][9] = %cqb_crouch_start_9;
	level.coverexit["heat"] = [];
	level.coverexit["heat"][1] = %heat_exit_1;
	level.coverexit["heat"][2] = %heat_exit_2;
	level.coverexit["heat"][3] = %heat_exit_3;
	level.coverexit["heat"][4] = %heat_exit_4;
	level.coverexit["heat"][6] = %heat_exit_6;
	level.coverexit["heat"][7] = %heat_exit_7;
	level.coverexit["heat"][8] = %heat_exit_8;
	level.coverexit["heat"][9] = %heat_exit_9;
	level.coverexit["heat_left"] = [];
	level.coverexit["heat_left"][1] = %heat_exit_1;
	level.coverexit["heat_left"][2] = %heat_exit_2;
	level.coverexit["heat_left"][3] = %heat_exit_3;
	level.coverexit["heat_left"][4] = %heat_exit_4;
	level.coverexit["heat_left"][6] = %heat_exit_6;
	level.coverexit["heat_left"][7] = %heat_exit_8l;
	level.coverexit["heat_left"][8] = %heat_exit_8l;
	level.coverexit["heat_left"][9] = %heat_exit_8r;
	level.coverexit["heat_right"] = [];
	level.coverexit["heat_right"][1] = %heat_exit_1;
	level.coverexit["heat_right"][2] = %heat_exit_2;
	level.coverexit["heat_right"][3] = %heat_exit_3;
	level.coverexit["heat_right"][4] = %heat_exit_4;
	level.coverexit["heat_right"][6] = %heat_exit_6;
	level.coverexit["heat_right"][7] = %heat_exit_8l;
	level.coverexit["heat_right"][8] = %heat_exit_8r;
	level.coverexit["heat_right"][9] = %heat_exit_8r;
	for(var_02 = 1;var_02 <= 6;var_02++ = var_41[21])
	{
		if(var_02 == 5)
		{
			continue;
		}

		for(var_04 = 0;var_04 < var_41.size;var_04++ = "exposed_ready_cqb")
		{
			var_03 = var_41[var_04];
			if(isdefined(level.covertrans[var_03]) && isdefined(level.covertrans[var_03][var_02]))
			{
				level.covertransdist[var_03][var_02] = getmovedelta(level.covertrans[var_03][var_02],0,1);
				level.var_D72[var_03][var_02] = getangledelta(level.covertrans[var_03][var_02],0,1);
			}

			if(isdefined(level.coverexit[var_03]) && isdefined(level.coverexit[var_03][var_02]))
			{
				if(animhasnotetrack(level.coverexit[var_03][var_02],"code_move"))
				{
					var_05 = getnotetracktimes(level.coverexit[var_03][var_02],"code_move")[0];
				}
				else
				{
					var_05 = 1;
				}

				level.coverexitdist[var_03][var_02] = getmovedelta(level.coverexit[var_03][var_02],0,var_05);
				level.coverexitangles[var_03][var_02] = getangledelta(level.coverexit[var_03][var_02],0,1);
			}
		}
	}

	for(var_04 = 0;var_04 < var_41.size;var_04++ = var_41[20])
	{
		var_03 = var_41[var_04];
		level.covertranslongestdist[var_03] = 0;
		for(var_02 = 1;var_02 <= 6;var_02++ = "exposed_ready")
		{
			if(var_02 == 5 || !isdefined(level.covertrans[var_03]) || !isdefined(level.covertrans[var_03][var_02]))
			{
				continue;
			}

			var_06 = lengthsquared(level.covertransdist[var_03][var_02]);
			if(level.covertranslongestdist[var_03] < var_06)
			{
				level.covertranslongestdist[var_03] = var_06;
			}
		}

		level.covertranslongestdist[var_03] = sqrt(level.covertranslongestdist[var_03]);
	}

	level.exposedtransition["exposed"] = 1;
	level.exposedtransition["exposed_crouch"] = 1;
	level.exposedtransition["exposed_cqb"] = 1;
	level.exposedtransition["exposed_crouch_cqb"] = 1;
	level.exposedtransition["exposed_ready_cqb"] = 1;
	level.exposedtransition["exposed_ready"] = 1;
	level.exposedtransition["heat"] = 1;
	if(!isdefined(level.longestexposedapproachdist))
	{
		anim.longestexposedapproachdist = 0;
	}

	foreach(var_03, var_08 in level.exposedtransition)
	{
		for(var_02 = 7;var_02 <= 9;var_02++ = "heat_right")
		{
			if(isdefined(level.covertrans[var_03]) && isdefined(level.covertrans[var_03][var_02]))
			{
				level.covertransdist[var_03][var_02] = getmovedelta(level.covertrans[var_03][var_02],0,1);
				level.var_D72[var_03][var_02] = getangledelta(level.covertrans[var_03][var_02],0,1);
			}

			if(isdefined(level.coverexit[var_03]) && isdefined(level.coverexit[var_03][var_02]))
			{
				var_05 = getnotetracktimes(level.coverexit[var_03][var_02],"code_move")[0];
				level.coverexitdist[var_03][var_02] = getmovedelta(level.coverexit[var_03][var_02],0,var_05);
				level.coverexitangles[var_03][var_02] = getangledelta(level.coverexit[var_03][var_02],0,1);
			}
		}

		for(var_02 = 1;var_02 <= 9;var_02++ = var_41[19])
		{
			if(!isdefined(level.covertrans[var_03]) || !isdefined(level.covertrans[var_03][var_02]))
			{
				continue;
			}

			var_09 = length(level.covertransdist[var_03][var_02]);
			if(var_09 > level.longestexposedapproachdist)
			{
				anim.longestexposedapproachdist = var_09;
			}
		}
	}

	level.covertranssplit["left"][7] = 0.369369;
	level.covertranssplit["left_crouch"][7] = 0.319319;
	level.covertranssplit["left_cqb"][7] = 0.451451;
	level.covertranssplit["left_crouch_cqb"][7] = 0.246246;
	level.var_1C07["left"][7] = 0.547548;
	level.var_1C07["left_crouch"][7] = 0.593594;
	level.var_1C07["left_cqb"][7] = 0.702703;
	level.var_1C07["left_crouch_cqb"][7] = 0.718719;
	level.var_1C07["heat_left"][7] = 0.42;
	level.covertranssplit["left"][8] = 0.525526;
	level.covertranssplit["left_crouch"][8] = 0.428428;
	level.covertranssplit["left_cqb"][8] = 0.431431;
	level.covertranssplit["left_crouch_cqb"][8] = 0.33033;
	level.var_1C07["left"][8] = 0.614615;
	level.var_1C07["left_crouch"][8] = 0.451451;
	level.var_1C07["left_cqb"][8] = 0.451451;
	level.var_1C07["left_crouch_cqb"][8] = 0.603604;
	level.var_1C07["heat_left"][8] = 0.42;
	level.covertranssplit["right"][8] = 0.458458;
	level.covertranssplit["right_crouch"][8] = 0.248248;
	level.covertranssplit["right_cqb"][8] = 0.458458;
	level.covertranssplit["right_crouch_cqb"][8] = 0.311311;
	level.var_1C07["right"][8] = 0.457457;
	level.var_1C07["right_crouch"][8] = 0.545546;
	level.var_1C07["right_cqb"][8] = 0.540541;
	level.var_1C07["right_crouch_cqb"][8] = 0.399399;
	level.var_1C07["heat_right"][8] = 0.4;
	level.covertranssplit["right"][9] = 0.546547;
	level.covertranssplit["right_crouch"][9] = 0.2002;
	level.covertranssplit["right_cqb"][9] = 0.546547;
	level.covertranssplit["right_crouch_cqb"][9] = 0.232232;
	level.var_1C07["right"][9] = 0.483483;
	level.var_1C07["right_crouch"][9] = 0.493493;
	level.var_1C07["right_cqb"][9] = 0.565566;
	level.var_1C07["right_crouch_cqb"][9] = 0.518519;
	level.var_1C07["heat_right"][9] = 0.4;
	var_0A = [];
	var_0B = [];
	getsplittimes(7,8,0,var_0A,var_0B);
	var_0A = [];
	var_0A["right"] = 1;
	var_0A["right_crouch"] = 1;
	var_0A["right_cqb"] = 1;
	var_0A["right_crouch_cqb"] = 1;
	var_0B = [];
	getsplittimes(8,9,1,var_0A,var_0B);
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
	level.var_D5D["Cover Stand"] = "stand";
	level.var_D5D["Conceal Stand"] = "stand";
	level.var_D5D["Cover Crouch"] = "crouch";
	level.var_D5D["Conceal Crouch"] = "crouch";
}

//Function Number: 3
getsplittimes(param_00,param_01,param_02,param_03,param_04)
{
	for(var_05 = param_00;var_05 <= param_01;var_05++)
	{
		foreach(var_08, var_07 in param_03)
		{
			level.var_D9B[var_08][var_05] = getmovedelta(level.covertrans[var_08][var_05],0,gettranssplittime(var_08,var_05));
			level.covertransdist[var_08][var_05] = getmovedelta(level.covertrans[var_08][var_05],0,1) - level.var_D9B[var_08][var_05];
			level.var_D72[var_08][var_05] = getangledelta(level.covertrans[var_08][var_05],0,1);
		}

		foreach(var_08, var_07 in param_04)
		{
			level.coverexitdist[var_08][var_05] = getmovedelta(level.coverexit[var_08][var_05],0,getexitsplittime(var_08,var_05));
			level.var_D98[var_08][var_05] = getmovedelta(level.coverexit[var_08][var_05],0,1) - level.coverexitdist[var_08][var_05];
			level.coverexitangles[var_08][var_05] = getangledelta(level.coverexit[var_08][var_05],0,1);
		}
	}
}

//Function Number: 4
getexitsplittime(param_00,param_01)
{
	return level.var_1C07[param_00][param_01];
}

//Function Number: 5
gettranssplittime(param_00,param_01)
{
	return level.covertranssplit[param_00][param_01];
}