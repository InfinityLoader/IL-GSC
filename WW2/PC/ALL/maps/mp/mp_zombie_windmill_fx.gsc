/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_zombie_windmill_fx.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 42 ms
 * Timestamp: 10/27/2023 3:20:14 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	level.var_611["zmb_wm_ground_fire_a"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_ground_fire_a");
	level.var_611["zmb_wm_fire_lp_m_tall"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_fire_lp_m_tall");
	level.var_611["zmb_ber_elec_sparks_pzl_battery_on"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_elec_sparks_pzl_battery_on");
	level.var_611["zmb_snipe_fire_lp_m_whitesmk"] = loadfx("vfx/map/mp_zombie_snipe/zmb_snipe_fire_lp_m_whitesmk");
	level.var_611["zmb_fire_vista_lrg_fog"] = loadfx("vfx/map/mp_zombie_island/zmb_fire_vista_lrg_fog");
	level.var_611["test_effect"] = loadfx("vfx/test/test_fx");
	level.var_611["zmb_jolts_out"] = loadfx("vfx/zombie/zmb_jolts_out");
	level.var_611["zmb_zmb_key_light"] = loadfx("vfx/lights/mp_zombie_nest/zmb_zmb_key_light");
	level.var_611["vf_zmb_windmill"] = loadfx("vfx/map/mp_zombie_windmill/vf_zmb_windmill");
	level.var_611["zmb_windmill_sky_lightning"] = loadfx("vfx/map/mp_zombie_windmill/zmb_windmill_sky_lightning");
	level.var_611["ground_impact"] = loadfx("vfx/zombie/zmb_ground_impact");
	level.var_611["zmb_wm_target_sphere"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_target_sphere");
	level.var_611["zmb_wm_water_dripping_line_lrg1"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_water_dripping_line_lrg1");
	level.var_611["zmb_wm_water_dripping_line_med1"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_water_dripping_line_med1");
	level.var_611["zmb_wm_water_falling_line_1"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_water_falling_line_1");
	level.var_611["zmb_wm_water_falling_splash_1"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_water_falling_splash_1");
	level.var_611["zmb_wm_rain_splash_area_1"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_rain_splash_area_1");
	level.var_611["zmb_windmill_drops_attach_player"] = loadfx("vfx/map/mp_zombie_windmill/zmb_windmill_drops_attach_player");
	level.var_611["zmb_windmill_rain_attach_player"] = loadfx("vfx/map/mp_zombie_windmill/zmb_windmill_rain_attach_player");
	level.var_611["falling_water_drip_runner_slow"] = loadfx("vfx/water/falling_water_drip_runner_slow");
	level.var_611["falling_water_drip_runner_fast"] = loadfx("vfx/water/falling_water_drip_runner_fast");
	level.var_611["zmb_wm_ground_rainy_sheets_mist1"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_ground_rainy_sheets_mist1");
	level.var_611["zmb_wm_river_splash1_sm"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_river_splash1_sm");
	level.var_611["zmb_wm_river_splash1_m"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_river_splash1_m");
	level.var_611["zmb_wm_river_splash_runner"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_river_splash_runner");
	level.var_611["zmb_wm_water_falling_line_2_sm"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_water_falling_line_2_sm");
	level.var_611["zmb_wm_rain_splashes_props_sm"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_rain_splashes_props_sm");
	level.var_611["zmb_wm_house_waterfall01_splash"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_house_waterfall01_splash");
	level.var_611["zmb_wm_house_waterfall01_thin"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_house_waterfall01_thin");
	level.var_611["zmb_wm_water_trickle_loop"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_water_trickle_loop");
	level.var_611["zmb_wm_water_leak_pipe_sm"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_water_leak_pipe_sm");
	level.var_611["zmb_wm_heavy_rain_attach_player"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_heavy_rain_attach_player");
	level.var_611["zmb_wm_rain_volume_windy"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_rain_volume_windy");
	level.var_611["zmb_wm_sink_drip01_rnr"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_sink_drip01_rnr");
	level.var_611["zmb_wm_frank_mud_splash_impt_rnr"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_frank_mud_splash_impt_rnr");
	level.var_611["zmb_wm_river_foam_end"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_river_foam_end");
	level.var_611["zmb_wm_river_foam"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_river_foam");
	level.var_611["battery_glow"] = loadfx("vfx/lights/red_dot_light");
	level.var_611["battery_glow_finished"] = loadfx("vfx/lights/green_dot_light");
	level.var_611["dlc_zmb_dig_02_uber_explode"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig_02_uber_explode");
	level.var_611["zmb_wm_wood_falling_dust_med_rnr"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_wood_falling_dust_med_rnr");
	level.var_611["zmb_wm_wood_burst_splinter"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_wood_burst_splinter");
	level.var_611["roach_flock_slow_crawl_runner"] = loadfx("vfx/map/mp_clowntown/roach_flock_slow_crawl_runner");
	level.var_611["zmb_rat_flock_short_runner"] = loadfx("vfx/map/mp_zombie_training/zmb_rat_flock_short_runner");
	level.var_611["insects_flies_landing_sm"] = loadfx("vfx/animal/insects_flies_landing_sm");
	level.var_611["insects_gnats_flying"] = loadfx("vfx/map/mp_dam/insects_gnats_flying");
	level.var_611["roach_flock_straight_runner"] = loadfx("vfx/animal/roach_flock_straight_runner");
	level.var_611["zmb_rat_flock_runaway_runner"] = loadfx("vfx/map/mp_zombie_nest/zmb_rat_flock_runaway_runner");
	level.var_611["zmb_windmill_wind_leaves"] = loadfx("vfx/map/mp_zombie_windmill/zmb_windmill_wind_leaves");
	level.var_611["zmb_wm_windy_leaves2"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_windy_leaves2");
	level.var_611["zmb_wm_lightning_flasha_rnr"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_lightning_flasha_rnr");
	level.var_611["zmb_elec_sparks_far_burst_rnr"] = loadfx("vfx/map/mp_zombie_berlin/zmb_elec_sparks_far_burst_rnr");
	level.var_611["zmb_wm_radio_damaged"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_radio_damaged");
	level.var_611["zmb_wm_radio_fixed"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_radio_fixed");
	level.var_611["zmb_dust_fall_wood_debris_01_rnr"] = loadfx("vfx/map/mp_zombie_windmill/zmb_dust_fall_wood_debris_01_rnr");
	level.var_611["zmb_dust_falling_wood_debris_01"] = loadfx("vfx/map/mp_zombie_windmill/zmb_dust_falling_wood_debris_01");
	level.var_611["zmb_wm_ground_ambient_smk_wispy"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_ground_ambient_smk_wispy");
	level.var_611["ambient_indoor_dust"] = loadfx("vfx/dust/ambient_indoor_dust");
	level.var_611["zmb_wm_frank_mud_splash_impact1"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_frank_mud_splash_impact1");
	level.var_611["zmb_wm_ambient_indoor_dust"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_ambient_indoor_dust");
	level.var_611["zmb_wm_smk_smoldering_crater01"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_smk_smoldering_crater01");
	level.var_611["zmb_wm_falling_debris_brick_rnr"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_falling_debris_brick_rnr");
	level.var_611["zmb_wm_explosion_dirt01"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_explosion_dirt01");
	level.var_611["zmb_wm_lightning_impact_base_rnr"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_lightning_impact_base_rnr");
	level.var_611["zmb_wm_lightning_impact_base"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_lightning_impact_base");
	level.var_611["zmb_wm_droppod_dirt_impact"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_droppod_dirt_impact");
	level.var_611["zmb_wm_frank_ele_explosion"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_frank_ele_explosion");
	level.var_611["zmb_wm_smk_smoldering_crater_lrg"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_smk_smoldering_crater_lrg");
	level.var_611["zmb_isl_ground_fire_a"] = loadfx("vfx/map/mp_zombie_island/zmb_isl_ground_fire_a");
	level.var_611["zmb_wm_veh_opel_fire_01"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_veh_opel_fire_01");
	level.var_611["zmb_wm_fire_roof_01"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_fire_roof_01");
	level.var_611["zmb_wm_fireplace_fire01"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_fireplace_fire01");
	level.var_611["zmb_wm_fire_roof_02"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_fire_roof_02");
	level.var_611["zmb_wm_fire_falling_rnr"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_fire_falling_rnr");
	level.var_611["fx_sunflare_zombie_windmill_dlc3"] = loadfx("vfx/lensflare/dlc/fx_sunflare_zombie_windmill_dlc3");
	level.var_611["moneyCloud"] = loadfx("vfx/gameplay/mp/zombie/gj_pickup_zombies_01_money");
	level.var_611["zmb_snipe_boss_energy_field"] = loadfx("vfx/map/mp_zombie_snipe/zmb_snipe_boss_pommel_shield");
	level.var_611["zmb_snipe_boss_energy_field_burst"] = loadfx("vfx/map/mp_zombie_snipe/zmb_snipe_boss_pommel_shield_burst");
	level.var_611["bombing_run_targeting"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_target_sphere");
	level.var_611["bombing_run_bomb_explode"] = loadfx("vfx/explosion/zmb_windmill_boss_explosion_01");
	level.var_611["zmb_wm_boss_bmb_target_400"] = loadfx("vfx/map/mp_zombie_windmill/zmb_wm_boss_bmb_target_400");
	level.var_611["zmb_mm_tracer_p38"] = loadfx("vfx/trail/zmb_mm_tracer_p38");
}