/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_kremlin_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 86 ms
 * Timestamp: 4/22/2024 2:17:39 AM
*******************************************************************/

//Function Number: 1
main()
{
	level._effect["krem_mine_burst"] = loadfx("vfx/map/mp_kremlin/krem_mine_burst");
	level._effect["krem_snow_light_wind_puff_a"] = loadfx("vfx/map/mp_kremlin/krem_snow_light_wind_puff_a");
	level._effect["krem_snow_light_wind_puff_a"] = loadfx("vfx/snow/krem_snow_light_wind_puff_a");
	level._effect["krem_mine_laser_origin_main"] = loadfx("vfx/map/mp_kremlin/krem_mine_laser_origin_main");
	level._effect["krm_mine_snow_puff"] = loadfx("vfx/map/mp_kremlin/krm_mine_snow_puff");
	level._effect["krem_mine_laser_origin"] = loadfx("vfx/map/mp_kremlin/krem_mine_laser_origin");
	level._effect["krem_laser_patch_b"] = loadfx("vfx/map/mp_kremlin/krem_laser_patch_b");
	level._effect["krem_laser_patch_a"] = loadfx("vfx/map/mp_kremlin/krem_laser_patch_a");
	level._effect["krem_mine_burst"] = loadfx("vfx/map/mp_kremlin/krem_mine_burst");
	level._effect["krem_battlefield_smoke_ground"] = loadfx("vfx/map/mp_kremlin/krem_battlefield_smoke_ground");
	level._effect["electrical_sparks_runner"] = loadfx("vfx/explosion/electrical_sparks_runner");
	level._effect["krem_ambient_exp_runner_b"] = loadfx("vfx/map/mp_kremlin/krem_ambient_exp_runner_b");
	level._effect["krem_burning_fire_trail"] = loadfx("vfx/map/mp_kremlin/krem_burning_fire_trail");
	level._effect["krem_smoldering_smk_direction_l"] = loadfx("vfx/map/mp_kremlin/krem_smoldering_smk_direction_l");
	level._effect["insects_fruitflies_flying"] = loadfx("vfx/animal/insects_fruitflies_flying");
	level._effect["insects_flies_landing_sm"] = loadfx("vfx/animal/insects_flies_landing_sm");
	level._effect["krem_snow_mist_blowing_runner"] = loadfx("vfx/map/mp_clowntown/krem_snow_mist_blowing_runner");
	level._effect["krem_smk_fire_sm"] = loadfx("vfx/map/mp_kremlin/krem_smk_fire_sm");
	level._effect["krem_small_fire_b"] = loadfx("vfx/map/mp_kremlin/krem_small_fire_b");
	level._effect["fire_sm_licks_loop"] = loadfx("vfx/fire/fire_sm_licks_loop");
	level._effect["krem_ground_fire_sm"] = loadfx("vfx/map/mp_kremlin/krem_ground_fire_sm");
	level._effect["krem_smoke_white_slow"] = loadfx("vfx/map/mp_kremlin/krem_smoke_white_slow");
	level._effect["krem_snow_blowing_tunnel"] = loadfx("vfx/map/mp_kremlin/krem_snow_blowing_tunnel");
	level._effect["krem_burning_fire_no_embers"] = loadfx("vfx/map/mp_kremlin/krem_burning_fire_no_embers");
	level._effect["krem_sm_smoldering_smk"] = loadfx("vfx/map/mp_kremlin/krem_sm_smoldering_smk");
	level._effect["krem_wind_blowing_corner"] = loadfx("vfx/map/mp_kremlin/krem_wind_blowing_corner");
	level._effect["smoke_pillar_black_large_slow"] = loadfx("vfx/smoke/smoke_pillar_black_large_slow");
	level._effect["krem_vista_smk_stack_dark"] = loadfx("vfx/map/mp_kremlin/krem_vista_smk_stack_dark");
	level._effect["krem_small_fire"] = loadfx("vfx/map/mp_kremlin/krem_small_fire");
	level._effect["krem_smoke_rise"] = loadfx("vfx/map/mp_kremlin/krem_smoke_rise");
	level._effect["krem_smoke_column_smaller"] = loadfx("vfx/map/mp_kremlin/krem_smoke_column_smaller");
	level._effect["krem_smoke_column_slower"] = loadfx("vfx/map/mp_kremlin/krem_smoke_column_slower");
	level._effect["krem_falling_leaves_b"] = loadfx("vfx/map/mp_kremlin/krem_falling_leaves_b");
	level._effect["krem_wind_snow_puff"] = loadfx("vfx/map/mp_kremlin/krem_wind_snow_puff");
	level._effect["krem_falling_leaves"] = loadfx("vfx/map/mp_kremlin/krem_falling_leaves");
	level._effect["krem_snow_light_wind_puff_a"] = loadfx("vfx/map/mp_kremlin/krem_snow_light_wind_puff_a");
	level._effect["krem_moths_area_sml"] = loadfx("vfx/map/mp_kremlin/krem_moths_area_sml");
	level._effect["krem_snow_light_wind_puff_a"] = loadfx("vfx/snow/krem_snow_light_wind_puff_a");
	level._effect["krem_birds_scatter_runner"] = loadfx("vfx/map/mp_kremlin/krem_birds_scatter_runner");
	level._effect["krem_dust_falling_no_debri_runner"] = loadfx("vfx/map/mp_kremlin/krem_dust_falling_no_debri_runner");
	level._effect["krem_close_smoke_rise"] = loadfx("vfx/map/mp_kremlin/krem_close_smoke_rise");
	level._effect["krem_smoldering_smk_direction_m"] = loadfx("vfx/map/mp_kremlin/krem_smoldering_smk_direction_m");
	level._effect["krem_vista_smk_stack"] = loadfx("vfx/map/mp_kremlin/krem_vista_smk_stack");
	level._effect["smk_stack_single_01_lp_med_rev_unlit"] = loadfx("vfx/smoke/smk_stack_single_01_lp_med_rev_unlit");
	level._effect["krem_fire_smoke_med"] = loadfx("vfx/map/mp_kremlin/krem_fire_smoke_med");
	level._effect["krem_smoke_stack"] = loadfx("vfx/map/mp_kremlin/krem_smoke_stack");
	level._effect["krem_vent_steam_small"] = loadfx("vfx/map/mp_kremlin/krem_vent_steam_small");
	level._effect["krem_smoke_column"] = loadfx("vfx/map/mp_kremlin/krem_smoke_column");
	level._effect["krem_snow_light_wind_gust_runner"] = loadfx("vfx/map/mp_kremlin/krem_snow_light_wind_gust_runner");
	level._effect["krem_snow_chunks_falling"] = loadfx("vfx/map/mp_kremlin/krem_snow_chunks_falling");
	level._effect["wind_blowing_trash"] = loadfx("vfx/wind/wind_blowing_trash");
	level._effect["mp_trash_blowing_runner"] = loadfx("vfx/map/mp_lost/mp_trash_blowing_runner");
	level._effect["krem_lightrays_sml"] = loadfx("vfx/map/mp_kremlin/krem_lightrays_sml");
	level._effect["krem_birds_runner"] = loadfx("vfx/map/mp_kremlin/krem_birds_runner");
	level._effect["krem_wind_blowing_snow_2"] = loadfx("vfx/map/mp_kremlin/krem_wind_blowing_snow_2");
	level._effect["krem_wind_blowing_snow"] = loadfx("vfx/map/mp_kremlin/krem_wind_blowing_snow");
	level._effect["fireball_lp_smk_s_cg"] = loadfx("vfx/fire/fireball_lp_smk_s_cg");
	level._effect["krem_distant_large_smoke"] = loadfx("vfx/map/mp_kremlin/krem_distant_large_smoke");
	level._effect["krem_dust_falling_runner"] = loadfx("vfx/map/mp_kremlin/krem_dust_falling_runner");
	level._effect["krem_burning_fire"] = loadfx("vfx/map/mp_kremlin/krem_burning_fire");
	level._effect["krem_electrical_sparks_runner"] = loadfx("vfx/map/mp_kremlin/krem_electrical_sparks_runner");
	level._effect["krem_dust_ambient_int"] = loadfx("vfx/map/mp_kremlin/krem_dust_ambient_int");
	level._effect["krem_heavy_dust_smoke"] = loadfx("vfx/map/mp_kremlin/krem_heavy_dust_smoke");
	level._effect["krem_molten_drip"] = loadfx("vfx/map/mp_kremlin/krem_molten_drip");
	level._effect["krem_settled_dust"] = loadfx("vfx/map/mp_kremlin/krem_settled_dust");
	level._effect["krem_settling_dust"] = loadfx("vfx/map/mp_kremlin/krem_settling_dust");
	level._effect["krem_snow_fall"] = loadfx("vfx/map/mp_kremlin/krem_snow_fall");
	level._effect["test_effect"] = loadfx("vfx/test/test_fx");
	level._effect["snow_blizard_far"] = loadfx("vfx/wind/snow_blizard_far");
	level._effect["ground_snow_hvy_wind_flat_crash"] = loadfx("vfx/snow/ground_snow_hvy_wind_flat_crash");
	level._effect["snow_dune_top"] = loadfx("vfx/wind/snow_dune_top");
	level._effect["fx_sunflare_mp_kremlin"] = loadfx("vfx/lensflare/fx_sunflare_mp_kremlin");
	level._effect["mp_godray_angled_dusty"] = loadfx("vfx/map/mp_kremlin/mp_godray_angled_dusty");
	level._effect["mp_godray_angled_gold_dusty"] = loadfx("vfx/map/mp_kremlin/mp_godray_angled_gold_dusty");
	level._effect["mp_godray_sm"] = loadfx("vfx/map/mp_kremlin/mp_godray_sm");
	level._effect["sphere_flare"] = loadfx("vfx/map/mp_kremlin/sphere_flare");
	level._effect["sphere_flare_sm"] = loadfx("vfx/map/mp_kremlin/sphere_flare_sm");
	level._effect["blue_sm_lens"] = loadfx("vfx/lights/mp_kremlin/blue_sm_lens");
	level._effect["sconce_sm"] = loadfx("vfx/lights/mp_kremlin/sconce_sm");
	level._effect["sconce_lrg"] = loadfx("vfx/lights/mp_kremlin/sconce_lrg");
	level._effect["stadium_sm"] = loadfx("vfx/lights/mp_kremlin/stadium_sm");
	level._effect["stadium_sm_bright"] = loadfx("vfx/lights/mp_kremlin/stadium_sm_bright");
	level._effect["stadium_blue_sm"] = loadfx("vfx/lights/mp_kremlin/stadium_blue_sm");
	level._effect["torqued_flou_flare"] = loadfx("vfx/lights/mp_torqued/torqued_flou_flare");
	level._effect["flare_ambient"] = loadfx("vfx/props/flare_ambient");
	level._effect["dlc_flare_light_spot_6_sm"] = loadfx("vfx/lensflare/dlc/dlc_flare_light_spot_6_sm");
	level._effect["flare_spot_sm"] = loadfx("vfx/lights/mp_kremlin/flare_spot_sm");
}

//Function Number: 2
laser_grid_a_fx()
{
	level endon("game_ended");
	wait(level.minesettings[self.minetype].eventstartcountdown - 1.5);
	var_00 = (360,359,0);
	var_01 = anglestoforward(var_00);
	var_02 = anglestoup(var_00);
	var_03 = spawnfx(common_scripts\utility::getfx("krem_laser_patch_a"),(-61,834,139),var_01,var_02);
	triggerfx(var_03);
	level waittill("minefield_complete");
	var_03 delete();
}

//Function Number: 3
laser_grid_b_fx()
{
	level endon("game_ended");
	wait(level.minesettings[self.minetype].eventstartcountdown - 1.3);
	var_00 = (270,0,0);
	var_01 = anglestoforward(var_00);
	var_02 = anglestoup(var_00);
	var_03 = spawnfx(common_scripts\utility::getfx("krem_laser_patch_b"),(-353,-706,156),var_01,var_02);
	triggerfx(var_03);
	level waittill("minefield_complete");
	var_03 delete();
}

//Function Number: 4
snow_puff_fx()
{
	wait(1);
	playfxontag(common_scripts\utility::getfx("krm_mine_snow_puff"),self,"tag_origin");
}