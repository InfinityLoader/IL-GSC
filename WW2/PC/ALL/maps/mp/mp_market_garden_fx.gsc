/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_market_garden_fx.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 30 ms
 * Timestamp: 10/27/2023 3:15:47 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	level.var_611["wall_tile_shatter_sm_02"] = loadfx("vfx/destructible/wall_tile_shatter_sm_02");
	level.var_611["mp_mg_street_flare"] = loadfx("vfx/map/mp_market_garden/mp_mg_street_flare");
	level.var_611["mp_mg_water_drip_line_rnr"] = loadfx("vfx/map/mp_market_garden/mp_mg_water_drip_line_rnr");
	level.var_611["mp_mg_screen_splash_droplets"] = loadfx("vfx/map/mp_market_garden/mp_mg_screen_splash_droplets");
	level.var_611["mp_mg_water_drips_crash"] = loadfx("vfx/map/mp_market_garden/mp_mg_water_drips_crash");
	level.var_611["mp_mg_water_drip_f"] = loadfx("vfx/map/mp_market_garden/mp_mg_water_drip_f");
	level.var_611["mp_mg_electrical_arc_2"] = loadfx("vfx/map/mp_market_garden/mp_mg_electrical_arc_2");
	level.var_611["mp_mg_explosions_distant_runner"] = loadfx("vfx/map/mp_market_garden/mp_mg_explosions_distant_runner");
	level.var_611["mp_mg_water_explosion_beach_runner"] = loadfx("vfx/map/mp_market_garden/mp_mg_water_explosion_beach_runner");
	level.var_611["mp_mg_vista_cloud_glow_1"] = loadfx("vfx/map/mp_market_garden/mp_mg_vista_cloud_glow_1");
	level.var_611["mp_mg_moon"] = loadfx("vfx/map/mp_market_garden/mp_mg_moon");
	level.var_611["mp_mg_ash_ember_cloud_freq_lrg"] = loadfx("vfx/map/mp_market_garden/mp_mg_ash_ember_cloud_freq_lrg");
	level.var_611["mp_mg_ground_fire_b"] = loadfx("vfx/map/mp_market_garden/mp_mg_ground_fire_b");
	level.var_611["mp_mp_embers_pop_01"] = loadfx("vfx/map/mp_market_garden/mp_mp_embers_pop_01");
	level.var_611["mp_mg_embers_3"] = loadfx("vfx/map/mp_market_garden/mp_mg_embers_3");
	level.var_611["mp_mg_embers_2"] = loadfx("vfx/map/mp_market_garden/mp_mg_embers_2");
	level.var_611["mp_mg_gust_water_mist_loop"] = loadfx("vfx/map/mp_market_garden/mp_mg_gust_water_mist_loop");
	level.var_611["mp_mg_embers_lrg"] = loadfx("vfx/map/mp_market_garden/mp_mg_embers_lrg");
	level.var_611["mp_mg_water_gush_pipe"] = loadfx("vfx/map/mp_market_garden/mp_mg_water_gush_pipe");
	level.var_611["mp_mg_light_flare_lrg"] = loadfx("vfx/map/mp_market_garden/mp_mg_light_flare_lrg");
	level.var_611["mp_mg_smk_fire_damage"] = loadfx("vfx/map/mp_market_garden/mp_mg_smk_fire_damage");
	level.var_611["mp_mg_smk_damage_lrg"] = loadfx("vfx/map/mp_market_garden/mp_mg_smk_damage_lrg");
	level.var_611["mp_mg_fire_ground_small_1"] = loadfx("vfx/map/mp_market_garden/mp_mg_fire_ground_small_1");
	level.var_611["mp_mg_ground_smoke_low_fill_w"] = loadfx("vfx/map/mp_market_garden/mp_mg_ground_smoke_low_fill_w");
	level.var_611["mp_mg_vista_hero_smk_column_01"] = loadfx("vfx/map/mp_market_garden/mp_mg_vista_hero_smk_column_01");
	level.var_611["mp_mg_vista_hero_smk_bridge_2"] = loadfx("vfx/map/mp_market_garden/mp_mg_vista_hero_smk_bridge_2");
	level.var_611["vf_wind_mp_market_garden"] = loadfx("vfx/vectorfield/vf_wind_mp_market_garden");
	level.var_611["mp_mg_fire_damage_tree_4_lrg"] = loadfx("vfx/map/mp_market_garden/mp_mg_fire_damage_tree_4_lrg");
	level.var_611["mp_mg_vista_hero_smk_bridge"] = loadfx("vfx/map/mp_market_garden/mp_mg_vista_hero_smk_bridge");
	level.var_611["mp_house_headlight_2"] = loadfx("vfx/map/mp_house/mp_house_headlight_2");
	level.var_611["mp_mg_light_flare"] = loadfx("vfx/map/mp_market_garden/mp_mg_light_flare");
	level.var_611["mp_mg_dust_interior"] = loadfx("vfx/map/mp_market_garden/mp_mg_dust_interior");
	level.var_611["mp_mg_interior_ash_embers_falling"] = loadfx("vfx/map/mp_market_garden/mp_mg_interior_ash_embers_falling");
	level.var_611["mp_mg_fire_barrel"] = loadfx("vfx/map/mp_market_garden/mp_mg_fire_barrel");
	level.var_611["mp_mg_barrel_smoke_embers_dist"] = loadfx("vfx/map/mp_market_garden/mp_mg_barrel_smoke_embers_dist");
	level.var_611["mp_mg_fire_lp_ceiling_01"] = loadfx("vfx/map/mp_market_garden/mp_mg_fire_lp_ceiling_01");
	level.var_611["mp_mg_fire_damage_tree_4"] = loadfx("vfx/map/mp_market_garden/mp_mg_fire_damage_tree_4");
	level.var_611["mp_mg_fire_damage_tree_3"] = loadfx("vfx/map/mp_market_garden/mp_mg_fire_damage_tree_3");
	level.var_611["wolf_fire_tree_1"] = loadfx("vfx/map/mp_wolfslair/wolf_fire_tree_1");
	level.var_611["mp_mg_fire_damage_tree_2"] = loadfx("vfx/map/mp_market_garden/mp_mg_fire_damage_tree_2");
	level.var_611["mp_mg_ground_fire_a"] = loadfx("vfx/map/mp_market_garden/mp_mg_ground_fire_a");
	level.var_611["mp_mg_light_hanging_cone"] = loadfx("vfx/map/mp_market_garden/mp_mg_light_hanging_cone");
	level.var_611["mp_mg_fire_falling_runner"] = loadfx("vfx/map/mp_market_garden/mp_mg_fire_falling_runner");
	level.var_611["mp_mg_fire_flat_bright"] = loadfx("vfx/map/mp_market_garden/mp_mg_fire_flat_bright");
	level.var_611["mp_mg_fire_flat"] = loadfx("vfx/map/mp_market_garden/mp_mg_fire_flat");
	level.var_611["mp_mg_light_shafts_1"] = loadfx("vfx/map/mp_market_garden/mp_mg_light_shafts_1");
	level.var_611["mp_mg_smk_medium_corner"] = loadfx("vfx/map/mp_market_garden/mp_mg_smk_medium_corner");
	level.var_611["mp_mg_smk_large_1"] = loadfx("vfx/map/mp_market_garden/mp_mg_smk_large_1");
	level.var_611["mp_mg_smk_billow_door"] = loadfx("vfx/map/mp_market_garden/mp_mg_smk_billow_door");
	level.var_611["mp_mg_smk_billow_ceiling"] = loadfx("vfx/map/mp_market_garden/mp_mg_smk_billow_ceiling");
	level.var_611["mp_mg_smk_simmer_med_2"] = loadfx("vfx/map/mp_market_garden/mp_mg_smk_simmer_med_2");
	level.var_611["mp_mg_smk_simmer_med"] = loadfx("vfx/map/mp_market_garden/mp_mg_smk_simmer_med");
	level.var_611["mp_mg_fire_lp_ceil_beam_tiny"] = loadfx("vfx/map/mp_market_garden/mp_mg_fire_lp_ceil_beam_tiny");
	level.var_611["mp_mg_fire_lp_ceiling_beam_sm"] = loadfx("vfx/map/mp_market_garden/mp_mg_fire_lp_ceiling_beam_sm");
	level.var_611["mp_mg_ash_and_emb_sm"] = loadfx("vfx/map/mp_market_garden/mp_mg_ash_and_emb_sm");
	level.var_611["potty_impacts_med_01"] = loadfx("vfx/destructible/potty_impacts_med_01");
	level.var_611["wall_tile_shatter_sm_01"] = loadfx("vfx/destructible/wall_tile_shatter_sm_01");
	level.var_611["wall_tile_shatter_blk_sm_01"] = loadfx("vfx/destructible/wall_tile_shatter_blk_sm_01");
	level.var_611["glass_mirror_shatter_01"] = loadfx("vfx/destructible/glass_mirror_shatter_01");
	level.var_611["potty_explosion_med_01"] = loadfx("vfx/destructible/potty_explosion_med_01");
	level.var_611["wall_tile_shatter_med_01"] = loadfx("vfx/destructible/wall_tile_shatter_med_01");
	level.var_611["mp_mg_vista_explosion_runner"] = loadfx("vfx/map/mp_market_garden/mp_mg_vista_explosion_runner");
	level.var_611["mp_mg_white_smoke_stack_1"] = loadfx("vfx/map/mp_market_garden/mp_mg_white_smoke_stack_1");
	level.var_611["mp_mg_leaves_falling_1"] = loadfx("vfx/map/mp_market_garden/mp_mg_leaves_falling_1");
	level.var_611["mp_mg_fire_medium_1"] = loadfx("vfx/map/mp_market_garden/mp_mg_fire_medium_1");
	level.var_611["mp_mg_electrical_arc"] = loadfx("vfx/map/mp_market_garden/mp_mg_electrical_arc");
	level.var_611["mp_mg_aa_flak_runner"] = loadfx("vfx/map/mp_market_garden/mp_mg_aa_flak_runner");
	level.var_611["mp_mg_vista_hero_smk_column_03"] = loadfx("vfx/map/mp_market_garden/mp_mg_vista_hero_smk_column_03");
	level.var_611["mp_mg_vista_hero_smk_column_02"] = loadfx("vfx/map/mp_market_garden/mp_mg_vista_hero_smk_column_02");
	level.var_611["mp_mg_vista_hero_smk_column"] = loadfx("vfx/map/mp_market_garden/mp_mg_vista_hero_smk_column");
	level.var_611["mp_mg_exp_glow_distant_runner"] = loadfx("vfx/map/mp_market_garden/mp_mg_exp_glow_distant_runner");
	level.var_611["mp_mg_vista_fire_smoke_1"] = loadfx("vfx/map/mp_market_garden/mp_mg_vista_fire_smoke_1");
	level.var_611["mp_mg_ptrooper_deploy_1_runner"] = loadfx("vfx/map/mp_market_garden/mp_mg_ptrooper_deploy_1_runner");
	level.var_611["mp_mg_water_fountain_1"] = loadfx("vfx/map/mp_market_garden/mp_mg_water_fountain_1");
	level.var_611["mp_mg_ground_smoke_low_fill"] = loadfx("vfx/map/mp_market_garden/mp_mg_ground_smoke_low_fill");
	level.var_611["mp_mg_falling_debris_brick_runner"] = loadfx("vfx/map/mp_market_garden/mp_mg_falling_debris_brick_runner");
	level.var_611["mp_mg_smk_wall_01"] = loadfx("vfx/map/mp_market_garden/mp_mg_smk_wall_01");
	level.var_611["mp_mg_smk_plume_medium_white_1"] = loadfx("vfx/map/mp_market_garden/mp_mg_smk_plume_medium_white_1");
	level.var_611["mp_mg_water_leak_pipe_1"] = loadfx("vfx/map/mp_market_garden/mp_mg_water_leak_pipe_1");
	level.var_611["mp_mg_rain_attach_player_hvy"] = loadfx("vfx/map/mp_market_garden/mp_mg_rain_attach_player_hvy");
	level.var_611["mp_mg_water_screen_drips_droplets"] = loadfx("vfx/map/mp_market_garden/mp_mg_water_screen_drips_droplets");
	level.var_611["mp_mg_water_falling_splash_tall_1"] = loadfx("vfx/map/mp_market_garden/mp_mg_water_falling_splash_tall_1");
	level.var_611["mp_mg_water_falling_splash_1"] = loadfx("vfx/map/mp_market_garden/mp_mg_water_falling_splash_1");
	level.var_611["mp_mg_smk_fire_vista_large_1"] = loadfx("vfx/map/mp_market_garden/mp_mg_smk_fire_vista_large_1");
	level.var_611["mp_mg_rain_splash_area_1"] = loadfx("vfx/map/mp_market_garden/mp_mg_rain_splash_area_1");
	level.var_611["mp_mg_paper_blowing_rnr"] = loadfx("vfx/map/mp_market_garden/mp_mg_paper_blowing_rnr");
	level.var_611["mp_mg_fire_medium_sparks_1"] = loadfx("vfx/map/mp_market_garden/mp_mg_fire_medium_sparks_1");
	level.var_611["mp_mg_embers_1"] = loadfx("vfx/map/mp_market_garden/mp_mg_embers_1");
	level.var_611["mp_mg_birds_rnr"] = loadfx("vfx/map/mp_market_garden/mp_mg_birds_rnr");
	level.var_611["mp_mg_rain_sheeting_runner"] = loadfx("vfx/map/mp_market_garden/mp_mg_rain_sheeting_runner");
	level.var_611["test_effect"] = loadfx("vfx/test/test_fx");
}