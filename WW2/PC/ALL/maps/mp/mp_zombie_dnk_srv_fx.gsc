/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_zombie_dnk_srv_fx.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 30 ms
 * Timestamp: 10/27/2023 3:18:50 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	level.var_611["snow_chunk_impact"] = loadfx("vfx/weaponimpact/snow_chunk_impact");
	level.var_611["water_splash_small"] = loadfx("vfx/water/water_splash_small");
	level.var_611["snow_chunk_impact_small"] = loadfx("vfx/weaponimpact/snow_chunk_impact_small");
	level.var_611["zmb_dnk_boat_water_pull"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_boat_water_pull");
	level.var_611["zmb_dlc2_straub_death"] = loadfx("vfx/blood/zmb_dlc2_straub_death");
	level.var_611["zmb_dlc2_straub_hit"] = loadfx("vfx/blood/zmb_dlc2_straub_hit");
	level.var_611["zmb_dnk_altered_snowfall"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_snowfall");
	level.var_611["zmb_isl_fog_freezer_gas_pocket"] = loadfx("vfx/map/mp_zombie_island/zmb_isl_fog_freezer_gas_pocket");
	level.var_611["zmb_isl_beach_fish_flop_rnr"] = loadfx("vfx/map/mp_zombie_island/zmb_isl_beach_fish_flop_rnr");
	level.var_611["zmb_dnk_altered_firebowl"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_firebowl");
	level.var_611["dlc_zmb_dig02_fire_bowl_sm"] = loadfx("vfx/map/mp_zombie_dig02/dlc_zmb_dig02_fire_bowl_sm");
	level.var_611["zmb_dnk_altered_bloodfountain"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_bloodfountain");
	level.var_611["zmb_dnk_geistkraftexplode"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_geistkraftexplode");
	level.var_611["zmb_dnk_steam_linger"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_steam_linger");
	level.var_611["zmb_dnk_altered_geistkraft_suck"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_geistkraft_suck");
	level.var_611["zmb_dnk_altered_geistkraft_edge"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_geistkraft_edge");
	level.var_611["zmb_dnk_altered_bubbles_burst_rnr"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_bubbles_burst_rnr");
	level.var_611["zmb_dnk_altered_bubbles_burst"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_bubbles_burst");
	level.var_611["zmb_dnk_altered_bubbles_chld"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_bubbles_chld");
	level.var_611["zmb_dnk_altered_bubbles_debris"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_bubbles_debris");
	level.var_611["zmb_dnk_altered_bubbles"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_bubbles");
	level.var_611["zmb_dnk_fish_energy"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_fish_energy");
	level.var_611["zmb_dnk_altered_sizzlerbolt"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_sizzlerbolt");
	level.var_611["zmb_ber_fire_vista_lrg_blck_smk"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_fire_vista_lrg_blck_smk");
	level.var_611["zmb_ber_fire_tank_ground"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_fire_tank_ground");
	level.var_611["zmb_dnk_altered_fog_ring_chld"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_fog_ring_chld");
	level.var_611["zmb_dnk_altered_fog_ring"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_fog_ring");
	level.var_611["zmb_dnk_ship_tilt_vf"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_ship_tilt_vf");
	level.var_611["zmb_dnk_altered_ambient_energy"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_ambient_energy");
	level.var_611["zmb_dnk_altered_platform_mist"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_platform_mist");
	level.var_611["zmb_dnk_foam_linger"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_foam_linger");
	level.var_611["zmb_dnk_foam_flowing"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_foam_flowing");
	level.var_611["zmb_red_flare_idle"] = loadfx("vfx/map/mp_zombie_berlin/zmb_red_flare_idle");
	level.var_611["fire_licks_xsmall"] = loadfx("vfx/fire/fire_licks_xsmall");
	level.var_611["zmb_dnk_uber_leak"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_uber_leak");
	level.var_611["zmb_dnk_uber_explode"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_uber_explode");
	level.var_611["test_effect"] = loadfx("vfx/test/test_fx");
	level.var_611["zmb_jolts_out"] = loadfx("vfx/zombie/zmb_jolts_out");
	level.var_611["ground_impact"] = loadfx("vfx/zombie/zmb_ground_impact");
	level.var_611["zmb_dnk_wind_snow_swirl"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_wind_snow_swirl");
	level.var_611["zmb_dnk_spotlight_heavy_snow"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_spotlight_heavy_snow");
	level.var_611["zmb_dnk_snow_attach_player_hvy"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_snow_attach_player_hvy");
	level.var_611["zmb_dnk_ground_snow_skitter_rnr"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_ground_snow_skitter_rnr");
	level.var_611["zmb_dnk_snow_chunks_falling_rnr"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_snow_chunks_falling_rnr");
	level.var_611["mp_prague_falling_ledge_snow_runner"] = loadfx("vfx/map/mp_prauge/mp_prague_falling_ledge_snow_runner");
	level.var_611["zmb_vent_steam"] = loadfx("vfx/map/mp_zombie_nest/zmb_vent_steam");
	level.var_611["zmb_steam_pipe_leak_rnr"] = loadfx("vfx/map/mp_zombie_island/zmb_steam_pipe_leak_rnr");
	level.var_611["zmb_dnk_steam_lrg"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_steam_lrg");
	level.var_611["zmb_dnk_water_busted_pipe_metal"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_water_busted_pipe_metal");
	level.var_611["zmb_dnk_water_busted_pipe"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_water_busted_pipe");
	level.var_611["zmb_dnk_side_splashes_rnr"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_side_splashes_rnr");
	level.var_611["zmb_dnk_mainship_upward_mist"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_mainship_upward_mist");
	level.var_611["zmb_dnk_large_boat_splash_rnr"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_large_boat_splash_rnr");
	level.var_611["falling_water_drip_runner_slow"] = loadfx("vfx/water/falling_water_drip_runner_slow");
	level.var_611["falling_water_drip_runner_fast"] = loadfx("vfx/water/falling_water_drip_runner_fast");
	level.var_611["falling_water_drip_central_fast"] = loadfx("vfx/water/falling_water_drip_central_fast");
	level.var_611["falling_water_drip_line_lg_runner_fast"] = loadfx("vfx/water/falling_water_drip_line_lg_runner_fast");
	level.var_611["zmb_dnk_water_leak_sm"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_water_leak_sm");
	level.var_611["zmb_dnk_water_leak_lrg"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_water_leak_lrg");
	level.var_611["zmb_dnk_water_leak_lrg"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_water_leak_lrg");
	level.var_611["zmb_dnk_water_leak_sm"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_water_leak_sm");
	level.var_611["zmb_dnk_water_foam_lrg"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_water_foam_lrg");
	level.var_611["zmb_dnk_ice_drifting"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_ice_drifting");
	level.var_611["zmb_dnk_projector_lightbeam"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_projector_lightbeam");
	level.var_611["zmb_dnk_floating_debri"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_floating_debri");
	level.var_611["zmb_dnk_ambient_motes_interior"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_ambient_motes_interior");
	level.var_611["zmb_dnk_fog_wispy_lrg"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_fog_wispy_lrg");
	level.var_611["zmb_plastic_shreds_sheet_1"] = loadfx("vfx/map/mp_zombie_berlin/zmb_plastic_shreds_sheet_1");
	level.var_611["plastic_shreds_hanging_e"] = loadfx("vfx/wind/plastic_shreds_hanging_e");
	level.var_611["plastic_shreds_hanging_d"] = loadfx("vfx/wind/plastic_shreds_hanging_d");
	level.var_611["electrical_sparks_burst_runner"] = loadfx("vfx/map/mp_gibraltar/electrical_sparks_burst_runner");
	level.var_611["fish_flop"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_floppy_fish");
	level.var_611["geistkraft_poof"] = loadfx("vfx/map/mp_zombie_berlin/zmb_ber_szlr_geistkraftexplode_1");
	level.var_611["fish_energy"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_fish_energy");
	level.var_611["trap_ready"] = loadfx("vfx/zombie/zmb_trap_light_orange_small");
	level.var_611["trap_not_ready"] = loadfx("vfx/zombie/zmb_trap_light_orange_blink_small");
	level.var_611["zmb_med_trap_gib"] = loadfx("vfx/zombie/zmb_med_trap_gib");
	level.var_611["water_jet"] = loadfx("vfx/water/water_jet");
	level.var_611["boss_bomb_explode"] = loadfx("vfx/destructible/veh_sedan_police_explo_1_no_door");
	level.var_611["spider_web_mesh"] = loadfx("vfx/unique/spider_web_mesh");
	level.var_611["insects_flies_landing_sm"] = loadfx("vfx/animal/insects_flies_landing_sm");
	level.var_611["zmb_dnk_altered_fake_tether"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_fake_tether");
	level.var_611["zmb_dnk_altered_fire_med"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_fire_med");
	level.var_611["zmb_dnk_altered_flare"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_flare");
	level.var_611["zmb_dnk_altered_fog_ground"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_fog_ground");
	level.var_611["zmb_dnk_altered_flak"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_flak");
	level.var_611["zmb_dnk_altered_smk_smolder"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_smk_smolder");
	level.var_611["zmb_dnk_altered_fire_vertical"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_fire_vertical");
	level.var_611["zmb_dnk_altered_ash_cloud"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_ash_cloud");
	level.var_611["zmb_dnk_altered_zepellin"] = loadfx("vfx/map/mp_zombie_dnk/zmb_dnk_altered_zepellin");
}