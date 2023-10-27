/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_final\cp_final_player_character_setup.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 173 ms
 * Timestamp: 10/27/2023 12:05:23 AM
*******************************************************************/

//Function Number: 1
init_player_characters()
{
	register_player_character(1,"yes","body_zmb_hero_sally_dlc4","viewmodel_zmb_hero_sally_dlc4","head_zmb_hero_sally_dlc4",undefined,"p1_","_p1","iw7_dlc4pap_zm","ges_zombies_revive_nerd",0,"iw7_dlc4card_zm","mus_zombies_generic_char","iw7_dlc4loadin_zm","iw7_knife_zm_rapper");
	register_player_character(2,"yes","body_zmb_hero_dexter_dlc4","viewmodel_zmb_hero_dexter_dlc4","head_zmb_hero_dexter_dlc4",undefined,"p2_","_p2","iw7_dlc4pap_zm","ges_zombies_revive_nerd",1,"iw7_dlc4card_zm","mus_zombies_generic_char","iw7_dlc4loadin_zm","iw7_knife_zm_rapper");
	register_player_character(3,"yes","body_zmb_hero_andre_dlc4","viewmodel_zmb_hero_andre_dlc4","head_zmb_hero_andre_dlc4",undefined,"p3_","_p3","iw7_dlc4pap_zm","ges_zombies_revive_nerd",2,"iw7_dlc4card_zm","mus_zombies_generic_char","iw7_dlc4loadin_zm","iw7_knife_zm_rapper");
	register_player_character(4,"yes","body_zmb_hero_aj_dlc4","viewmodel_zmb_hero_aj_dlc4","head_zmb_hero_aj_dlc4",undefined,"p4_","_p4","iw7_dlc4pap_zm","ges_zombies_revive_nerd",3,"iw7_dlc4card_zm","mus_zombies_generic_char","iw7_dlc4loadin_zm","iw7_knife_zm_rapper");
}

//Function Number: 2
register_player_character(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D,param_0E,param_0F)
{
	var_10 = spawnstruct();
	var_10.body_model = param_02;
	var_10.view_model = param_03;
	var_10.head_model = param_04;
	var_10.hair_model = param_05;
	var_10.var_134FD = param_06;
	var_10.vo_suffix = param_07;
	var_10.pap_gesture = param_08;
	var_10.revive_gesture = param_09;
	var_10.photo_index = param_0A;
	var_10.var_6BA3 = param_0B;
	var_10.intro_music = param_0C;
	var_10.intro_gesture = param_0D;
	var_10.melee_weapon = param_0E;
	var_10.post_setup_func = param_0F;
	if(!isdefined(level.player_character_info))
	{
		level.player_character_info = [];
	}

	if(!isdefined(level.var_26A0))
	{
		level.var_26A0 = [];
	}

	level.player_character_info[param_00] = var_10;
	if(param_01 == "yes")
	{
		level.var_26A0[level.var_26A0.size] = param_00;
	}
}