/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_zmb\cp_zmb_player_character_setup.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 194 ms
 * Timestamp: 10/27/2023 12:08:26 AM
*******************************************************************/

//Function Number: 1
init_player_characters()
{
	lib_0D5B::register_player_character(1,"yes","zmb_body_hero_valley_girl","viewmodel_zmb_hero_valley_girl","zmb_head_hero_valley_girl","zmb_hero_valley_girl_hair","p1_","_p1","iw7_pap_zm_vgirl","ges_zombies_revive_valley_girl",0,"iw7_valleygirlcard_zm","mus_zombies_valley_girl","iw7_loadoutvalley_zm","iw7_knife_zm_vgirl");
	lib_0D5B::register_player_character(2,"yes","zmb_hero_nerd","zmb_hero_nerd_viewmode_arms","head_hero_nerd",undefined,"p2_","_p2","iw7_pap_zm_nerd","ges_zombies_revive_nerd",1,"iw7_nerdcard_zm","mus_zombies_nerd","iw7_loadoutnerd_zm","iw7_knife_zm_nerd");
	lib_0D5B::register_player_character(3,"yes","zmb_hero_rapper","viewmodel_zmb_hero_rapper","head_zmb_rapper",undefined,"p3_","_p3","iw7_pap_zm_rapper","ges_zombies_revive_rapper",2,"iw7_rappercard_zm","mus_zombies_rapper","iw7_loadoutrapper_zm","iw7_knife_zm_rapper");
	lib_0D5B::register_player_character(4,"yes","body_zmb_hero_jock","fullbody_zmb_hero_jock_viewmodel_arms","head_zmb_hero_jock",undefined,"p4_","_p4","iw7_pap_zm_jock","ges_zombies_revive_jock",3,"iw7_jockcard_zm","mus_zombies_jock","iw7_loadoutjock_zm","iw7_knife_zm_jock");
	lib_0D5B::register_player_character(5,"no","body_zmb_hero_dj","viewmodel_zmb_hero_dj","head_zmb_dj",undefined,"p5_","_p5","iw7_pap_zm_hoff","ges_zombies_revive_hoff",4,"iw7_hoffcard_zm","mus_zombies_hoff","iw7_loadouthoff_zm","iw7_knife_zm_hoff",::post_hoff_setup_func);
	lib_0D5B::register_player_character(6,"no","body_zmb_projectionist","zmb_projectionist_viewmodel_arms","head_zmb_projectionist",undefined,"p6_","_p6","iw7_pap_zm_wyler","ges_zombies_revive_wyler",5,"iw7_wylercard_zm","mus_zombies_jock","iw7_loadoutwyler_zm","iw7_knife_zm_wyler",::post_ww_player_setup_func);
}

//Function Number: 2
post_hoff_setup_func(param_00)
{
	param_00 lib_0D2A::func_12D7C("HOFF_THE_CHARTS",1);
	if(!isdefined(level.special_character_count))
	{
		level.special_character_count = 1;
		return;
	}

	level.special_character_count++;
}

//Function Number: 3
post_ww_player_setup_func(param_00)
{
	if(!isdefined(level.special_character_count_ww))
	{
		level.special_character_count_ww = 1;
		return;
	}

	level.special_character_count_ww++;
}