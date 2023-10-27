/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_rave\cp_rave_player_character_setup.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 142 ms
 * Timestamp: 10/27/2023 12:06:33 AM
*******************************************************************/

//Function Number: 1
init_player_characters()
{
	lib_0D5B::register_player_character(1,"yes","zmb_hero_female_gangster","viewmodel_zmb_female_gangster_arms",undefined,undefined,"p1_","_p1","iw7_pap_zm_chola","ges_zombies_revive_chola",0,"iw7_cholacard_zm","mus_zombies_valley_girl","iw7_loadout_zm_chola","iw7_knife_zm_chola",undefined,"iw7_gunless_zm");
	lib_0D5B::register_player_character(2,"yes","zmb_hero_male_raver","viewmodel_arms_zmb_hero_male_raver","head_zmb_hero_male_raver",undefined,"p2_","_p2","iw7_pap_zm_raver","ges_zombies_revive_raver",1,"iw7_ravercard_zm","mus_zombies_nerd","iw7_loadout_zm_raver","iw7_knife_zm_raver",undefined,"iw7_gunless_zm");
	lib_0D5B::register_player_character(3,"yes","body_zmb_hero_grunge","viewmodel_arms_zmb_hero_grunge","head_zmb_hero_grunge",undefined,"p3_","_p3","iw7_pap_zm_grunge","ges_zombies_revive_grunge",2,"iw7_grungecard_zm","mus_zombies_rapper","iw7_loadout_zm_grunge","iw7_knife_zm_grunge",undefined,"iw7_gunless_zm");
	lib_0D5B::register_player_character(4,"yes","zmb_hero_hip_hop","viewmodel_zmb_hero_hip_hop","head_zmb_hero_hip_hop",undefined,"p4_","_p4","iw7_pap_zm_hiphop","ges_zombies_revive_hiphop",3,"iw7_hiphopcard_zm","mus_zombies_jock","iw7_loadout_zm_hiphop","iw7_knife_zm_hiphop",undefined,"iw7_gunless_zm");
	lib_0D5B::register_player_character(5,"no","zmb_hero_k_smith","viewmodel_zmb_hero_k_smith",undefined,undefined,"p5_","_p5","iw7_pap_zm_survivor","ges_zombies_revive_survivor",4,"iw7_survivorcard_zm","mus_zombies_kevinsmith","iw7_loadout_zm_survivor","iw7_knife_zm_survivor",::post_hoff_setup_func,"iw7_gunless_zm");
}

//Function Number: 2
post_hoff_setup_func(param_00)
{
	param_00 lib_0D2A::func_12D7C("SUPER_SLACKER",1);
	if(!isdefined(level.special_character_count))
	{
		level.special_character_count = 1;
		return;
	}

	level.special_character_count++;
}