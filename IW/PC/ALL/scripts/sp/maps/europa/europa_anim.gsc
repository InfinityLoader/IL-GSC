/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\maps\europa\europa_anim.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 40
 * Decompile Time: 1551 ms
 * Timestamp: 10/27/2023 12:22:40 AM
*******************************************************************/

//Function Number: 1
main()
{
	func_91DC();
	func_3353();
	func_3508();
	player();
	func_13267();
	func_EE25();
}

//Function Number: 2
func_91DC()
{
	level.var_EC87["sdf1"] = #animtree;
	level.var_EC87["sdf2"] = #animtree;
	level.var_EC87["sdf3"] = #animtree;
	level.var_EC85["generic"]["c6_hack_enter"] = %europa_armory_eng_console_intro;
	level.var_EC85["generic"]["c6_hack"][0] = %europa_armory_eng_console_idle;
	level.var_EC85["scar1"]["europa_dropship_intro"] = %europa_dropship_intro_scar01_scene;
	level.var_EC85["scar2"]["europa_dropship_intro"] = %europa_dropship_intro_scar02_scene;
	lib_0B06::func_17FA("scar2","nt_door_open","dropship_door_open","europa_dropship_intro");
	lib_0B06::func_17FC("scar2","weapon_attach","scar2_stow_weapon","europa_dropship_intro");
	level.var_EC85["scar1"]["europa_dropship_idle"][0] = %europa_dropship_intro_scar01_idle;
	level.var_EC85["scar2"]["europa_dropship_idle"][0] = %europa_dropship_intro_scar02_idle;
	level.var_EC85["scar1"]["europa_dropship_halo_jump"] = %europa_dropship_intro_scar01_halo_jump;
	level.var_EC85["scar2"]["europa_dropship_halo_jump"] = %europa_dropship_intro_scar02_halo_jump;
	level.var_EC85["scar1"]["lookdown"] = %europa_crevasse_scar02_lookdown;
	level.var_EC85["scar1"]["lookdown_idle"][0] = %europa_crevasse_scar02_idle;
	level.var_EC85["scar2"]["lookdown"] = %europa_crevasse_scar01_lookdown;
	level.var_EC85["scar2"]["lookdown_idle"][0] = %europa_crevasse_scar01_idle;
	level.var_EC85["scar1"]["airlock_response"] = %europa_airlock_scar01_reload_scene;
	level.var_EC88["scar2"]["europa_tee_gearsicingupletspl"] = %europa_tee_4_30_hr_r2;
	level.var_EC88["scar2"]["europa_tee_trackintwotargest"] = %europa_tee_3_70_hr_r2;
	level.var_EC88["scar2"]["europa_tee_boostdowntakeem"] = %europa_tee_3_80_hr_r2;
	level.var_EC88["scar1"]["europa_sip_wolfjumpdownwe"] = %europa_sip_4_10_hr_r2;
	level.var_EC85["player_enemy"]["cliffjumper"] = %europa_landing_takedown_a_enemy;
	level.var_EC85["player_enemy"]["cliffjumper_loop"] = %europa_landing_takedown_melee_loop_a_enemy;
	level.var_EC85["player_enemy"]["cliffjumper_kill"] = %europa_landing_takedown_melee_kill_a_enemy;
	level.var_EC85["player_enemy"]["cliffjumper_exit"] = %europa_landing_takedown_shoot_exit_a_enemy;
	level.var_EC85["ally_enemy"]["cliffjumper"] = %europa_landing_takedown_b_enemy;
	level.var_EC85["scar2"]["cliffjumper"] = %europa_landing_takedown_b_ally;
	lib_0B06::func_17F6("ally_enemy","helmet_pop",::func_8E1D,"cliffjumper");
	lib_0B06::func_17F6("player_enemy","die",::func_12920,"cliffjumper");
	lib_0B06::func_17F6("player_enemy","kick_impact",::func_12923,"cliffjumper");
	level.var_EC85["guy1"]["platform_scene"] = %europa_labs_eng_c12_walkby_pcap;
	level.var_EC85["guy2"]["platform_scene"] = %europa_labs_xo_c12_walkby_pcap;
	level.var_EC85["takedown_enemy"]["tunnel_takedown"] = %europa_ice_cavern_sdf_takedown_02;
	level.var_EC85["scar1"]["tunnel_takedown"] = %europa_ice_cavern_scar_takedown_02;
	lib_0B06::func_17F6("takedown_enemy","die",::func_12920,"tunnel_takedown");
	lib_0B06::func_17F6("takedown_enemy","nt_interupt_end",::func_12924,"tunnel_takedown");
	lib_0B06::func_17FC("scar1","nt_interupt_check","interupt_check","tunnel_takedown");
	lib_0B06::func_17FC("scar1","nt_stab","scar_stab","tunnel_takedown");
	lib_0B06::func_17F6("scar1","knife_on",::func_12922,"tunnel_takedown");
	lib_0B06::func_17FC("scar1","knife_off","knife_off","tunnel_takedown");
	level.var_EC85["scar1"]["hold_up"] = %europa_seeker_scar01_hold;
	level.var_EC85["scar2"]["hold_up"] = %europa_seeker_scar01_hold;
	level.var_EC85["generic"]["rummage1"] = %europa_airlock_locker_sdf01_scavenge;
	level.var_EC85["generic"]["rummage2"] = %europa_airlock_locker_sdf02_scavenge;
	level.var_EC85["generic"]["rummage3"] = %europa_airlock_locker_sdf03_scavenge;
	level.var_EC85["generic"]["rummage1_react"] = %europa_airlock_locker_sdf01_react;
	level.var_EC85["generic"]["rummage2_react"] = %europa_airlock_locker_sdf02_react;
	level.var_EC85["generic"]["rummage3_react"] = %europa_airlock_locker_sdf03_react;
	level.var_EC85["generic"]["rummage1_loop"][0] = %europa_airlock_locker_sdf01_scavenge_idle;
	level.var_EC85["generic"]["rummage2_loop"][0] = %europa_airlock_locker_sdf02_scavenge_idle;
	level.var_EC85["generic"]["rummage3_loop"][0] = %europa_airlock_locker_sdf03_scavenge_idle;
	level.var_EC85["generic"]["scripted_long_death_start"] = %hm_grnd_org_long_death_stand_trans_to_crawl;
	level.var_EC85["generic"]["scripted_long_death_crawl"] = %hm_grnd_org_long_death_crawl01;
	level.var_EC85["generic"]["scripted_long_death_die"] = %hm_grnd_org_long_death_crawl_death01;
	level.var_EC85["scar1"]["antigrav_breach"] = %europa_airlock_scar01_grav_grenade_scene;
	lib_0B06::func_17FC("scar1","grenade_appear","grenade_appear","antigrav_breach");
	lib_0B06::func_17FC("scar1","grenade_toss","grenade_toss","antigrav_breach");
	level.var_EC85["scar2"]["lab_airlock_close_intro"] = %europa_airlock_xo_door_intro;
	level.var_EC85["scar2"]["lab_airlock_close_idle"][0] = %europa_airlock_xo_door_idle;
	level.var_EC85["scar2"]["lab_airlock_close"] = %europa_airlock_xo_door_close;
	level.var_EC85["generic"]["search_flashlight_left"] = %hm_grnd_yel_flashlightsearch_left;
	level.var_EC85["generic"]["search_locker"] = %ph_un_hq_listening_stand_taking_notes_loop;
	level.var_EC85["sdf1"]["airlock_open_breakout"] = %europa_airlock_locker_sdf01_react;
	level.var_EC85["sdf2"]["airlock_open_breakout"] = %europa_airlock_locker_sdf02_react;
	level.var_EC85["sdf3"]["airlock_open_breakout"] = %europa_airlock_locker_sdf03_react;
	level.var_EC85["scar1"]["new_armory_enter"] = %europa_armory_scar01_enter;
	level.var_EC85["scar2"]["new_armory_enter"] = %europa_armory_scar02_enter;
	level.var_EC85["scar1"]["office_enter_in"] = %europa_office_enter_scar01_into;
	level.var_EC85["scar1"]["office_enter_idle"][0] = %europa_office_enter_scar01_idle;
	level.var_EC85["scar1"]["office_enter_go"] = %europa_office_enter_scar01_out;
	level.var_EC85["scar2"]["office_enter_tapgo"] = %europa_office_enter_scar02_tap;
	lib_0B06::func_17FC("scar2","scar01_out_start","nt_notify_tapandgo","office_enter_tapgo");
	level.var_EC85["generic"]["sdf_seeker_pulltable_sc"] = %europa_gunrange_sdf01_pulltable;
	level.var_EC85["scar1"]["cutter_entry_scars"] = %europa_armory_scar01_enter;
	level.var_EC85["scar2"]["cutter_entry_scars"] = %europa_armory_scar02_enter;
	level.var_EC85["scar1"]["armory_vault_reaction"] = %europa_armory_scar02_back_away;
	level.var_EC85["scar2"]["selfdestruct"] = %europa_armory_scar01_self_destruct;
	lib_0B06::func_17F6("scar2","give_weapon",::func_C0D7,"selfdestruct");
	level.var_EC85["scar2"]["selfdestruct_alt"] = %europa_armory_scar01_self_destruct_alt;
	lib_0B06::func_17F6("scar2","give_weapon",::func_C0D7,"selfdestruct_alt");
	level.var_EC85["scar1"]["fspar_boot_intro"] = %europa_armory_ally_starting_up_fspar_intro;
	level.var_EC85["scar1"]["fspar_boot_idle"][0] = %europa_armory_ally_starting_up_fspar_idle;
	level.var_EC85["scar1"]["fspar_boot_exit"] = %europa_armory_ally_starting_up_fspar_exit;
	level.var_EC85["scar1"]["fspar_suckout"] = %europa_end_ally_suckout;
	lib_0B06::func_17FA("scar1","impact","decompress_blackout","fspar_suckout");
	level.scr_sound["scar1"]["decompress_intro"] = "europa_tee_scramblingtofinds";
	level.var_EC85["scar1"]["decompress_intro"] = %europa_end_tunnel_scar_02_hangon_intro;
	level.var_EC85["scar1"]["decompress_loop"][0] = %europa_end_tunnel_scar_02_hangon_idle;
	level.var_EC85["scar1"]["right_decompress"] = %europa_end_tunnel_scar_02_scene;
	lib_0B06::func_17FA("scar1","hit_player","decompress_blackout","right_decompress");
	level.var_EC85["scar1"]["left_decompress"] = %europa_end_tunnel_scar_02_scene_left;
	lib_0B06::func_17FA("scar1","hit_player","decompress_blackout","left_decompress");
	level.var_EC85["scar2"]["decompress"] = %europa_end_tunnel_scar_01_suckout;
	level.scr_sound["scar2"]["decompress"] = "europa_sip_arrrhhhhhhgettings";
	level.var_EC85["generic"]["decompress"][0] = %europa_end_tunnel_scar_01_suckout_rel;
	level.var_EC85["scar1"]["outro"] = %europa_end_scar01_scene;
	lib_0B06::func_17F6("scar1","headsmash",::func_8CA1,"outro");
	level.var_EC85["scar2"]["outro"] = %europa_end_scar02_scene;
	lib_0B06::func_17F6("scar2","headsmash",::func_8CA1,"outro");
	level.var_EC85["sdf1"]["outro"] = %europa_end_sdf01_scene;
	lib_0B06::func_17F6("sdf1","kill_me",::func_C7C7,"outro");
	level.var_EC85["sdf2"]["outro"] = %europa_end_sdf02_scene;
	lib_0B06::func_17F6("sdf2","first_hit",::func_C7BF,"outro");
	lib_0B06::func_17F6("sdf2","hit",::func_C7C5,"outro");
	lib_0B06::func_17F6("sdf2","focus_on_me",::func_C7C4,"outro");
	lib_0B06::func_17F6("sdf2","raise_fist",::func_C7CE,"outro");
	level.var_EC85["sdf3"]["outro"] = %europa_end_sdf03_scene;
	level.var_EC85["sdf4"]["outro"] = %europa_end_sdf04_scene;
	level.var_EC85["kotch"]["outro"] = %europa_end_kotch_scene;
	lib_0B06::func_17FC("kotch","kotch_kneel","kotch_kneel","outro");
	lib_0B06::func_17FC("kotch","kotch_stands","kotch_stands","outro");
	lib_0B06::func_17FC("kotch","kotch_kneel2","kotch_kneel2","outro");
	lib_0B06::func_17F6("kotch","fire",::func_C7BE,"outro");
	lib_0B06::func_17F6("kotch","oxygen_in",::func_C7CB,"outro");
	lib_0B06::func_17F6("kotch","oxygen_out",::func_C7CC,"outro");
	lib_0B06::func_17F6("kotch","detach_canister",::func_C7BA,"outro");
	level.var_EC85["generic"]["generic_dead_civ_01"] = %generic_dead_civ_01;
	level.var_EC85["generic"]["generic_dead_civ_02"] = %generic_dead_civ_02;
	level.var_EC85["generic"]["generic_dead_civ_03"] = %generic_dead_civ_03;
	level.var_EC85["generic"]["generic_dead_civ_04"] = %generic_dead_civ_04;
	level.var_EC85["generic"]["generic_dead_civ_05"] = %generic_dead_civ_05;
	level.var_EC85["generic"]["generic_dead_civ_06"] = %generic_dead_civ_06;
	level.var_EC85["generic"]["generic_dead_civ_07"] = %generic_dead_civ_07;
	level.var_EC85["generic"]["europa_labs_dead_pose01"] = %europa_labs_dead_pose01;
	level.var_EC85["generic"]["europa_labs_dead_pose02"] = %europa_labs_dead_pose02;
	level.var_EC85["generic"]["europa_labs_dead_pose03"] = %europa_labs_dead_pose03;
	level.var_EC85["generic"]["europa_labs_dead_pose04"] = %europa_labs_dead_pose04;
	level.var_EC85["generic"]["europa_labs_rail_dead_pose_01"] = %europa_labs_rail_dead_pose_01;
	level.var_EC85["generic"]["hm_grnd_yel_patrol_react_to_combat_6_ar"] = %hm_grnd_yel_patrol_react_to_combat_6_ar;
	level.var_EC85["generic"]["hm_grnd_yel_patrol_react_to_combat_2_ar"] = %hm_grnd_yel_patrol_react_to_combat_2_ar;
	level.var_EC85["generic"]["hm_grnd_yel_patrol_react_to_combat_4_ar"] = %hm_grnd_yel_patrol_react_to_combat_4_ar;
}

//Function Number: 3
func_12921(param_00)
{
	playfx(scripts\common\utility::getfx("vfx_eu_icecave_landing_kickup_sml"),scripts\sp\_utility::func_864C(param_00.origin));
}

//Function Number: 4
func_12924(param_00)
{
	param_00.var_38DF = 1;
	param_00 notify("cannot_interupt");
}

//Function Number: 5
func_C7C7(param_00)
{
	playfx(scripts\common\utility::getfx("deathfx_bloodpool_generic"),param_00 gettagorigin("j_head"),(0,0,1));
	param_00.var_1491.var_C043 = 1;
	param_00 method_81D0();
}

//Function Number: 6
func_C7BE(param_00)
{
	if(!isdefined(param_00.var_6D66))
	{
		param_00.var_6D66 = 1;
		return;
	}

	playfxontag(scripts\common\utility::getfx("kotch_muzzleflash"),level.var_A70E.var_1FB6,"tag_flash");
	var_01 = scripts\common\utility::getfx("outro_gun_impact");
	var_02 = anglestoforward(level.var_A70E.origin - level.var_C7D2.origin);
	var_03 = anglestoright(level.var_C7D2.origin - level.var_A70E.origin);
	var_04 = anglestoup(level.var_C7D2.origin - level.var_A70E.origin);
	var_05 = level.var_C7D2 gettagorigin("j_head");
	var_05 = var_05 + var_03 * -3;
	var_05 = var_05 + var_04 * -5;
	playfx(var_01,var_05,var_02);
	var_06 = scripts\common\utility::spawn_tag_origin(var_05,vectortoangles(var_02));
	var_06 linkto(level.var_C7D2,"j_spineupper");
	playfxontag(scripts\common\utility::getfx("outro_gun_impact_leak"),var_06,"tag_origin");
	wait(3.75);
	stopfxontag(scripts\common\utility::getfx("outro_gun_impact_leak"),var_06,"tag_origin");
}

//Function Number: 7
func_C7BB(param_00)
{
	param_00.var_1FB6 hide();
}

//Function Number: 8
func_C7CB(param_00)
{
	level.var_8E0F = "good";
	level.player notify("o2_in");
}

//Function Number: 9
func_C7CC(param_00)
{
	level.var_8E0F = "depleted";
	level.player notify("o2_out");
}

//Function Number: 10
func_C7BA(param_00)
{
	var_01 = "tag_accessory_right";
	var_02 = param_00 gettagorigin(var_01);
	var_03 = param_00 gettagangles(var_01);
	var_04 = spawn("script_model",var_02);
	var_04.angles = var_03;
	var_04 setmodel("oxygen_bottle_air_boss");
	wait(0.05);
	param_00 detach("oxygen_bottle_air_boss",var_01);
}

//Function Number: 11
func_8E1D(param_00)
{
	playfx(level.var_7649["human_gib_head"],param_00 gettagorigin("j_head"),(0,0,1));
	playfx(scripts\common\utility::getfx("deathfx_bloodpool_generic"),param_00 gettagorigin("j_head"),(0,0,1));
	param_00.var_C065 = 1;
	param_00 thread scripts\sp\_utility::func_19D3();
	param_00 method_83A1();
}

//Function Number: 12
func_8CA1(param_00)
{
	playfx(scripts\common\utility::getfx("deathfx_bloodpool_generic"),param_00 gettagorigin("j_head"),(0,0,1));
	param_00 lib_0C60::func_8C99();
	param_00 detach(param_00.var_8C43);
	if(param_00 == level.var_EBBB)
	{
		param_00 attach("helmet_hero_sipes_crushed");
		return;
	}

	param_00 attach("helmet_hero_t_crushed");
}

//Function Number: 13
func_C7BF(param_00)
{
	level.player method_83F6(100,param_00.origin,0);
	level.player thread func_54D7(0.5,2,0.5);
	level.player thread scripts\sp\_gameskill::func_2BDB(2,0.5);
	var_01 = getentarray("europa_lights_outro_2","targetname");
	foreach(var_03 in var_01)
	{
		var_03 setlightintensity(0);
	}
}

//Function Number: 14
func_54D7(param_00,param_01,param_02)
{
	level.player method_809A(param_00,param_01);
	wait(param_02);
	level.player method_809A(0,1);
}

//Function Number: 15
func_C7C5(param_00)
{
	if(!isdefined(param_00.var_902B))
	{
		param_00.var_902B = 0;
	}

	if(scripts\sp\_utility::func_93A6() && !isdefined(level.player.var_8DDA))
	{
		level.player.var_8DDA = level.var_10964.var_8DDA;
	}

	param_00.var_902B++;
	var_01 = 1;
	if(param_00.var_902B == 1)
	{
		level.player thread scripts\sp\_gameskill::func_2BDB(2.5,0.5);
		level.player method_809A(0.25,2);
		level.player.var_8DDA setmodel("vm_hero_protagonist_helmet_glass_crack_02_clear");
		level.player playsound("scn_europa_outro_plr_helmet_glass_break_01");
		level.player scripts\common\utility::func_5127(0.2,::scripts\sp\_utility::func_CE2F,"europa_plr_end_efforts_2");
		level.player notify("sfx_beep_fade");
	}
	else if(param_00.var_902B == 2)
	{
		level.player thread scripts\sp\_gameskill::func_2BDB(2.7,0.5);
		level.player method_809A(0.5,2);
		level.player.var_8DDA setmodel("vm_hero_protagonist_helmet_glass_crack_03_clear");
		level.player playsound("scn_europa_outro_plr_helmet_glass_break_03");
		level.player scripts\common\utility::func_5127(0.2,::scripts\sp\_utility::func_CE2F,"europa_plr_end_efforts_3");
	}
	else if(param_00.var_902B == 3)
	{
		thread scripts\sp\_hud::func_8DF7(0.05);
		level.player method_809A(0,1);
		level.player scripts\common\utility::func_5127(0.2,::scripts\sp\_utility::func_CE2F,"europa_plr_end_efforts_4");
		wait(0.15);
		level.player playsound("scn_europa_outro_plr_helmet_glass_break_04");
		func_C7CD();
		wait(0.05);
		var_01 = 0;
		level.player.var_E505 method_82B1(level.player.var_E505 scripts\sp\_utility::func_7DC1("outro"),0);
		param_00 method_82B1(param_00 scripts\sp\_utility::func_7DC1("outro"),0);
		level.player freezecontrols(1);
		setomnvar("ui_show_compass",1);
		scripts\common\utility::flag_set("outro_freeze");
	}

	if(var_01)
	{
		level.player method_83F6(100,param_00.origin,0);
	}
}

//Function Number: 16
func_C7CD()
{
	var_00 = anglestoforward(level.player getplayerangles());
	playfx(scripts\common\utility::getfx("outro_player_glass_punch"),level.player geteye(),var_00);
	if(scripts\sp\_utility::func_93A6())
	{
		level.var_10964.var_8DDA delete();
		return;
	}

	level.player.var_8DDA delete();
}

//Function Number: 17
func_C7C4(param_00)
{
	level.player notify("connor");
	level notify("stop_dof_target_thread");
	level.var_584B = param_00;
	level.var_5844 = 1;
}

//Function Number: 18
func_C7CE(param_00)
{
	var_01 = 0.4;
	var_02 = 0.05;
	var_03 = 1;
	var_04 = [level.player.var_E505,param_00];
	foreach(var_06 in var_04)
	{
		var_06 thread func_AB76(var_06 scripts\sp\_utility::func_7DC1("outro"),var_01,var_03,var_02);
	}

	wait(0.5);
	foreach(var_06 in var_04)
	{
		var_06 thread func_AB76(var_06 scripts\sp\_utility::func_7DC1("outro"),var_01,var_02,var_03);
	}
}

//Function Number: 19
func_AB76(param_00,param_01,param_02,param_03)
{
	self notify("stop_lerp_animrate");
	self endon("stop_lerp_animrate");
	var_04 = param_01 * 20;
	var_05 = param_03 - param_02 / var_04;
	for(var_06 = 0;var_06 < var_04;var_06++)
	{
		param_02 = param_02 + var_05;
		self method_82B1(param_00,param_02);
		wait(0.05);
	}

	self method_82B1(param_00,param_03);
}

//Function Number: 20
func_3353()
{
	level.var_EC87["c6"] = #animtree;
	level.var_EC8C["c6"] = "robot_c6";
	level.var_EC85["c6"]["locker_deploy"] = %c6_grnd_red_exposed_rack_arm_spawn_ar;
	level.var_EC85["generic"]["robot_through_window"] = %traverse_window_m_2_run;
	level.var_EC85["c61"]["outro"] = %europa_end_c6_01_scene;
	level.var_EC85["c62"]["outro"] = %europa_end_c6_02_scene;
}

//Function Number: 21
func_3508()
{
	level.var_EC87["c12"] = #animtree;
	level.var_EC8C["c12"] = "robot_c12";
}

//Function Number: 22
player()
{
	level.var_EC87["player_rig"] = #animtree;
	level.var_EC8C["player_rig"] = "viewmodel_base_viewhands_iw7";
	level.var_EC85["player_rig"]["europa_dropship_idle"][0] = %europa_dropship_intro_plr_idle;
	level.var_EC85["player_rig"]["europa_dropship_intro"] = %europa_dropship_intro_plr_scene;
	lib_0B06::func_17FA("player_rig","vo_europa_rpr_warlordactual","nt_flag_warlordactual","europa_dropship_intro");
	lib_0B06::func_17FA("player_rig","vo_europa_rpr_goindark","nt_flag_going_dark","europa_dropship_intro");
	lib_0B06::func_17FA("player_rig","visor_lower","nt_flag_visor_lower","europa_dropship_intro");
	lib_0B06::func_17F6("player_rig","visor_lower",::func_67AF,"europa_dropship_intro");
	lib_0B06::func_17FA("player_rig","nt_thirty_seconds","nt_thirty_seconds","europa_dropship_intro");
	lib_0B06::func_17FA("player_rig","nt_twenty_seconds","nt_twenty_seconds","europa_dropship_intro");
	lib_0B06::func_17FA("player_rig","nt_ten_seconds","nt_ten_seconds","europa_dropship_intro");
	level.var_EC85["player_rig"]["europa_dropship_halo_jump"] = %europa_dropship_intro_plr_halo_jump_all;
	level.var_EC85["player_rig"]["europa_dropship_halo_land"] = %europa_dropship_intro_plr_halo_land;
	level.var_EC85["player_rig"]["europa_dropship_halo_land_rel"] = %europa_dropship_intro_plr_halo_land_rel;
	level.var_EC85["player_rig"]["europa_dropship_halo_land_death"] = %europa_dropship_intro_plr_halo_death;
	level.var_EC85["player_rig"]["europa_dropship_halo_death_rel"] = %europa_dropship_intro_plr_halo_death_rel;
	level.var_EC85["player_rig"]["cliffjumper"] = %europa_landing_takedown_a_plr;
	level.var_EC85["player_rig"]["cliffjumper_loop"] = %europa_landing_takedown_melee_loop_a_plr;
	level.var_EC85["player_rig"]["cliffjumper_kill"] = %europa_landing_takedown_melee_kill_a_plr;
	level.var_EC85["player_rig"]["cliffjumper_exit"] = %europa_landing_takedown_shoot_exit_a_plr;
	lib_0B06::func_17F6("player_rig","knife_attach",::func_D1B0,"cliffjumper");
	lib_0B06::func_17F6("player_rig","head_crack",::func_8C5B,"cliffjumper");
	lib_0B06::func_17FA("player_rig","kick_done","cliffjump_kick_done","cliffjumper");
	lib_0B06::func_17FA("player_rig","boost_end","boost_required_end","cliffjumper");
	lib_0B06::func_17FC("player_rig","stab","stab","cliffjumper_kill");
	level.var_EC85["player_rig"]["antigrav_breach"] = %europa_airlock_plr_grav_grenade_scene;
	lib_0B06::func_17FA("player_rig","door_ajar","door_ajar","antigrav_breach");
	lib_0B06::func_17FA("player_rig","door_kick","door_kick","antigrav_breach");
	level.var_EC85["player_rig"]["selfdestruct"] = %europa_armory_plr_self_destruct;
	lib_0B06::func_17F5("player_rig","attach_weapon","weapon_steeldragon_sp_wm","tag_accessory_right","selfdestruct");
	lib_0B06::func_17FA("player_rig","open_doors","open_armory_doors","selfdestruct");
	lib_0B06::func_17FA("player_rig","lookdown","armory_lookdown","selfdestruct");
	lib_0B06::func_17FA("player_rig","pvo_europa_plr_bootitupsipes","sipes_mount_fspar","selfdestruct");
	lib_0B06::func_17FC("player_rig","dof1","dof_change","selfdestruct");
	lib_0B06::func_17FC("player_rig","dof2","dof_change","selfdestruct");
	lib_0B06::func_17FC("player_rig","dof3","dof_change","selfdestruct");
	level.var_EC85["player_rig"]["decompress_loop"] = %europa_end_tunnel_plr_suckout_idle;
	level.var_EC85["player_rig"]["right_decompress"] = %europa_end_tunnel_plr_suckout_scene;
	level.var_EC85["player_rig"]["left_decompress"] = %europa_end_tunnel_plr_suckout_scene_left;
	level.var_EC85["player_rig"]["fspar_suckout"] = %europa_plr_fires_large_steel_dragon_suckout;
	level.var_EC85["player_rig"]["fspar_idle"][0] = %europa_plr_fires_large_steel_dragon_idle;
	level.var_EC85["player_rig"]["fspar_fire"] = %europa_plr_fires_large_steel_dragon_button_press;
	lib_0B06::func_17FA("player_rig","holding_on","player_holding_on","fspar_suckout");
	lib_0B06::func_17F6("player_rig","player_scream",::func_D015,"decompress");
	level.var_EC85["player_rig"]["outro"] = %europa_end_plr_scene;
	level.var_C7D5 = getanimlength(level.var_EC85["player_rig"]["outro"]);
	lib_0B06::func_17F6("player_rig","oxygen_depleted",::func_C7CA,"outro");
	lib_0B06::func_17FC("player_rig","look_at_friendlies","look_at_friendlies","outro");
	level.var_EC85["player_rig"]["fire_fspar"] = %europa_plr_fires_large_steel_dragon;
}

//Function Number: 23
func_8C5B(param_00)
{
	var_01 = (29221,-5369,-76);
	playfx(level._effect["small_cracks"],var_01);
}

//Function Number: 24
func_12922(param_00)
{
	var_01 = spawn("script_model",param_00 gettagorigin("tag_accessory_right"));
	var_01.angles = param_00 gettagangles("tag_accessory_right");
	var_01 linkto(param_00,"tag_accessory_right");
	var_01 setmodel("tactical_knife_iw7_wm");
	level waittill("scar_stab");
	playfx(scripts\common\utility::getfx("player_stab"),var_01 gettagorigin("tag_knife_fx"));
	level waittill("knife_off");
	var_01 delete();
}

//Function Number: 25
func_12923(param_00)
{
	param_00 func_8E18();
	level.player playsound("scn_cave_jump_boostkill");
}

//Function Number: 26
func_8E18(param_00)
{
	if(!isdefined(self.var_8C43))
	{
		return;
	}

	var_01 = self gettagorigin("j_head");
	var_02 = anglestoforward(self gettagangles("j_head"));
	playfx(scripts\common\utility::getfx("helmet_sdf_army_broken_europa"),var_01,var_02);
	if(isdefined(self.var_8E1E))
	{
		self.var_8E1E = undefined;
		var_03 = self method_850C("helmet","helmet");
		if(var_03 > 0)
		{
			self method_850B(var_03,"helmet","helmet");
		}
	}

	self detach(self.var_8C43,"");
	self.var_8C43 = undefined;
}

//Function Number: 27
func_D1B0(param_00)
{
	level endon("scar_saved_player");
	level.var_4214 = spawn("script_model",level.player.origin);
	level.var_4214 setmodel("tactical_knife_iw7_vm");
	level.var_4214 linkto(level.player.var_D267,"tag_accessory_left",(0,0,0),(0,0,0));
	level.var_4214 hide();
	thread scripts\common\utility::func_6E3F("teleport_scar1",3);
	level waittill("stab");
	scripts\common\utility::exploder("enemy_ground_impact");
	playfx(scripts\common\utility::getfx("player_stab"),level.var_4214 gettagorigin("tag_knife_fx"));
	playfx(scripts\common\utility::getfx("vfx_eu_icecave_takedown_bloodpool"),level.var_4214 gettagorigin("tag_knife_fx"));
}

//Function Number: 28
func_67AF(param_00)
{
	function_02A9("atmosphere","helmet",1);
}

//Function Number: 29
func_D015(param_00)
{
	thread scripts\sp\_utility::func_1034F("europa_plr_effortsholdingontod");
}

//Function Number: 30
func_C7CA(param_00)
{
	level.var_8E0F = "depleted";
}

//Function Number: 31
func_13267()
{
	level.var_EC87["dropship"] = #animtree;
	level.var_EC85["dropship"]["europa_dropship_intro"] = %europa_dropship_intro_dropship_start;
}

//Function Number: 32
func_EE25()
{
	level.var_EC87["script_model"] = #animtree;
	level.var_EC87["desk"] = #animtree;
	level.var_EC85["cutter"]["cutter_crawl"][0] = %europa_seeker_forward_in_place;
	level.var_EC85["desk"]["sdf_seeker_pulltable_sc"] = %europa_gunrange_desk_pulltable;
	level.var_EC85["script_model"]["c12_pose_02"] = %europa_labs_c12_02_hanging_idle;
	level.var_EC85["script_model"]["c12_pose_03"] = %europa_labs_c12_03_hanging_idle;
	level.var_EC85["door"]["lab_airlock_close"] = %europa_airlock_door_close;
	level.var_EC87["tag_origin_mover"] = #animtree;
	level.var_EC8C["tag_origin_mover"] = "tag_origin";
	level.var_EC85["tag_origin_mover"]["new_armory_enter"] = %europa_armory_seeker_door_fall;
	level.var_EC87["locker_arm"] = #animtree;
	level.var_EC8C["locker_arm"] = "veh_mil_air_ca_drop_pod_arm";
	level.var_EC85["locker_arm"]["locker_deploy"] = %c6_grnd_red_exposed_rack_arm_spawn_arm;
	level.var_EC87["fhr40"] = #animtree;
	level.var_EC8C["fhr40"] = "weapon_fhr40_wm";
	level.var_EC85["fhr40"]["airlock_response"] = %europa_airlock_fhr40_reload_scene;
	level.var_EC85["fhr40"]["europa_dropship_intro"] = %europa_dropship_intro_fhr40_scene;
	level.var_EC87["antigrav_door"] = #animtree;
	level.var_EC85["antigrav_door"]["antigrav_breach"] = %europa_airlock_grav_grenade_scene;
	level.var_EC87["selfdestruct_console"] = #animtree;
	level.var_EC85["selfdestruct_console"]["selfdestruct"] = %europa_armory_plr_self_destruct_console;
	level.var_EC85["selfdestruct_console"]["selfdestruct_alt"] = %europa_armory_plr_self_destruct_console_alt;
	level.var_EC87["flag"] = #animtree;
	level.var_EC8C["flag"] = "ctf_game_flag_nostand";
	level.var_EC85["flag"]["outro"] = %europa_end_sdf_flag_scene;
	level.var_EC8C["fspar"] = "weapon_steeldragon_wm";
	level.var_EC87["script_model_corpse"] = #animtree;
	level.var_EC85["script_model_corpse"]["generic_dead_civ_01"] = %generic_dead_civ_01;
	level.var_EC85["script_model_corpse"]["generic_dead_civ_02"] = %generic_dead_civ_02;
	level.var_EC85["script_model_corpse"]["generic_dead_civ_03"] = %generic_dead_civ_03;
	level.var_EC85["script_model_corpse"]["generic_dead_civ_04"] = %generic_dead_civ_04;
	level.var_EC85["script_model_corpse"]["generic_dead_civ_05"] = %generic_dead_civ_05;
	level.var_EC85["script_model_corpse"]["generic_dead_civ_06"] = %generic_dead_civ_06;
	level.var_EC85["script_model_corpse"]["generic_dead_civ_07"] = %generic_dead_civ_07;
	level.var_EC85["script_model_corpse"]["europa_labs_dead_pose01"] = %europa_labs_dead_pose01;
	level.var_EC85["script_model_corpse"]["europa_labs_dead_pose02"] = %europa_labs_dead_pose02;
	level.var_EC85["script_model_corpse"]["europa_labs_dead_pose03"] = %europa_labs_dead_pose03;
	level.var_EC85["script_model_corpse"]["europa_labs_dead_pose04"] = %europa_labs_dead_pose04;
	level.var_EC85["script_model_corpse"]["europa_labs_rail_dead_pose_01"] = %europa_labs_rail_dead_pose_01;
	level.var_EC87["kotch_gun"] = #animtree;
	level.var_EC8C["kotch_gun"] = "weapon_emc_wm";
	level.var_EC85["kotch_gun"]["outro"] = %europa_end_emcpistol_scene;
}

//Function Number: 33
func_12920(param_00)
{
	if(isdefined(param_00.var_B14F))
	{
		param_00 scripts\sp\_utility::func_1101B();
	}

	param_00.var_EF = 1;
	param_00.var_DC1A = 1;
	param_00.var_30 = 1;
	param_00 scripts\sp\_utility::func_F2DA(0);
	param_00 method_81D0();
}

//Function Number: 34
func_C0C7(param_00)
{
	if(isdefined(param_00.var_B14F))
	{
		param_00 scripts\sp\_utility::func_1101B();
	}

	param_00.var_1491.var_C043 = 1;
	param_00 scripts\sp\_utility::func_54C6();
}

//Function Number: 35
func_7348(param_00)
{
	level endon("fpar_fire_stop");
	for(;;)
	{
		param_00 method_8494("iw7_steeldragon",level.var_21F7 gettagorigin("tag_flash"),level.var_21F7 gettagangles("tag_flash"));
		wait(0.05);
	}
}

//Function Number: 36
func_F1EC(param_00)
{
	setomnvar("ui_europa_selfdestruct",1);
	function_01C5("bg_cinematicFullScreen","0");
	function_01C5("bg_cinematicCanPause","1");
	level.player playsound("europa_armory_self_destruct_ui");
	function_003D("europa_selfdestruct");
	while(!function_0102())
	{
		wait(0.05);
	}

	thread scripts\sp\_art::func_583F(0,4,10,5,15,150,0.5);
	scripts\common\utility::func_5127(3.5,::scripts\sp\_art::func_583D,1);
	while(function_0102())
	{
		wait(0.05);
	}

	function_01F1();
	function_01C5("bg_cinematicFullScreen","1");
	function_01C5("bg_cinematicCanPause","1");
	setomnvar("ui_europa_selfdestruct",0);
}

//Function Number: 37
func_C0D7(param_00)
{
	scripts\common\utility::flag_set("scar1_moveto_fspar");
	scripts\sp\maps\europa\europa_util::func_117FF(75);
	var_01 = "iw7_steeldragon+europaspeedmod";
	level.player giveweapon(var_01);
	level.player method_83B6(var_01);
}

//Function Number: 38
func_F2DF(param_00)
{
	if(!isdefined(self.var_1310C))
	{
		level.var_11B30.var_2AA2 method_83D0(#animtree);
		level.var_11B30.var_2AA2.var_1310C = 1;
	}

	level.var_11B30.var_2AA2 notify("stop_idle_thread");
	var_01["powerup"] = %steel_dragon_powerup;
	var_01["idle"] = %steel_dragon_idle;
	var_01["fire"] = %steel_dragon_fire;
	var_01["powerdown"] = %steel_dragon_powerdown;
	var_02 = "bfganim";
	level.var_11B30.var_2AA2 method_806F(%root,0.2);
	if(param_00 == "idle")
	{
		level.var_11B30.var_2AA2 thread func_2AA4(var_01[param_00]);
	}

	level.var_11B30.var_2AA2 method_82E1(var_02,var_01[param_00],1,0.2,1);
	if(param_00 == "fire")
	{
		thread func_2AA3();
	}

	if(param_00 != "idle")
	{
		level.var_11B30.var_2AA2 waittillmatch("end",var_02);
	}
}

//Function Number: 39
func_2AA4(param_00)
{
	self endon("death");
	self endon("stop_idle_thread");
	wait(0.05);
	var_01 = 1;
	for(;;)
	{
		wait(randomfloatrange(2,5));
		var_02 = randomfloatrange(3,5);
		var_03 = randomfloatrange(0.2,1);
		var_04 = var_03 - var_01;
		var_05 = int(var_02 / 0.05);
		var_06 = var_04 / var_05;
		for(var_07 = 0;var_07 < var_05;var_07++)
		{
			var_01 = var_01 + var_06;
			self method_82B1(param_00,var_01);
			wait(0.05);
		}

		var_01 = var_03;
		self method_82B1(param_00,var_01);
	}
}

//Function Number: 40
func_2AA3()
{
	wait(0.8);
	level.var_11B30.var_113F2 playsound("scn_europa_fspar_fire");
	thread scripts\sp\maps\europa\europa_armory::func_3532();
	wait(2);
}