/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _hand_signals.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 30 ms
 * Timestamp: 4/22/2024 2:21:18 AM
*******************************************************************/

//Function Number: 1
inithandsignals()
{
	level.scr_anim["generic"]["signal_moveout_cqb"] = %cqb_stand_signal_move_out;
	level.scr_anim["generic"]["signal_moveup_cqb"] = %cqb_stand_signal_move_up;
	level.scr_anim["generic"]["signal_stop_cqb"] = %cqb_stand_signal_stop;
	level.scr_anim["generic"]["signal_onme_cqb"] = %cqb_stand_wave_on_me;
	level.scr_anim["generic"]["signal_enemy_cqb"] = %cqb_stand_signal_stop;
	level.scr_anim["generic"]["signal_moveout"] = %stand_exposed_wave_move_out;
	level.scr_anim["generic"]["signal_moveup"] = %stand_exposed_wave_move_up;
	level.scr_anim["generic"]["signal_stop"] = %stand_exposed_wave_halt;
	level.scr_anim["generic"]["signal_onme"] = %stand_exposed_wave_on_me;
	level.scr_anim["generic"]["signal_enemy"] = %stand_exposed_wave_target_spotted;
	level.scr_anim["generic"]["signal_go"] = %stand_exposed_wave_go;
	level.scr_anim["generic"]["signal_moveout_crouch"] = %cqb_stand_wave_go_v1;
	level.scr_anim["generic"]["signal_moveup_crouch"] = %cqb_stand_wave_go_v1;
	level.scr_anim["generic"]["signal_stop_crouch"] = %cqb_stand_wave_go_v1;
	level.scr_anim["generic"]["signal_onme_crouch"] = %cqb_stand_wave_go_v1;
	level.scr_anim["generic"]["signal_enemy_crouch"] = %cqb_stand_wave_go_v1;
	level.scr_anim["generic"]["signal_go_crouch"] = %cqb_stand_wave_go_v1;
	level.scr_anim["generic"]["signal_moveout_coverR"] = %cornerstndr_alert_signal_move_out;
	level.scr_anim["generic"]["signal_moveup_coverR"] = %cornerstndr_alert_signal_move_out;
	level.scr_anim["generic"]["signal_stop_coverR"] = %cornerstndr_alert_signal_stopstay_down;
	level.scr_anim["generic"]["signal_onme_coverR"] = %cornerstndr_alert_signal_on_me;
	level.scr_anim["generic"]["signal_enemy_coverR"] = %cornerstndr_alert_signal_enemy_spotted;
	level.scr_anim["generic"]["signal_go_coverR"] = %cornerstndr_alert_signal_move_out;
	level.scr_anim["generic"]["signal_moveout_coverL"] = %corner_standl_signal_move;
	level.scr_anim["generic"]["signal_moveup_coverL"] = %corner_standl_signal_move;
	level.scr_anim["generic"]["signal_stop_coverL"] = %corner_standl_signal_hold;
	level.scr_anim["generic"]["signal_onme_coverL"] = %corner_standl_signal_move;
	level.scr_anim["generic"]["signal_enemy_coverL"] = %corner_standl_signal_look;
	level.scr_anim["generic"]["signal_go_coverL"] = %corner_standl_signal_move;
}