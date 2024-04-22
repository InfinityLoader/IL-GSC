/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_solar_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 43 ms
 * Timestamp: 4/22/2024 2:18:25 AM
*******************************************************************/

//Function Number: 1
main()
{
	level._effect["ground_sand_light_wind_lp"] = loadfx("vfx/sand/ground_sand_light_wind_lp");
	level._effect["falling_pipe_water_trickle_continue"] = loadfx("vfx/water/falling_pipe_water_trickle_continue");
	level._effect["ambient_sand_separate"] = loadfx("vfx/map/mp_solar/ambient_sand_separate");
	level._effect["sand_tornado_s_runner"] = loadfx("vfx/sand/sand_tornado_s_runner");
	level._effect["fire_pipe_leak_xsm"] = loadfx("vfx/fire/fire_pipe_leak_xsm");
	level._effect["solar_tank_bubbles"] = loadfx("vfx/water/solar_tank_bubbles");
	level._effect["water_gush_pipe_xsm"] = loadfx("vfx/water/water_gush_pipe_xsm");
	level._effect["steam_pipe_burst_lp_sm"] = loadfx("vfx/steam/steam_pipe_burst_lp_sm");
	level._effect["water_leak_pipe_large"] = loadfx("vfx/water/water_leak_pipe_large");
	level._effect["qn_water_leak_pipe_small"] = loadfx("vfx/test/qn_water_leak_pipe_small");
	level._effect["fire_pipe_leak_med"] = loadfx("vfx/fire/fire_pipe_leak_med");
	level._effect["amb_dust_wind_particles"] = loadfx("vfx/dust/amb_dust_wind_particles");
	level._effect["wind_gust_fan_vortex_mp"] = loadfx("vfx/map/mp_dam/wind_gust_fan_vortex_mp");
	level._effect["light_godray_solarbeams_01"] = loadfx("vfx/lights/mp_solar/light_godray_solarbeams_01");
	level._effect["amb_dust_wind_02"] = loadfx("vfx/dust/amb_dust_wind_02");
	level._effect["steam_sm_vent2"] = loadfx("vfx/steam/steam_sm_vent2");
	level._effect["falling_water_drip_line_lg_runner_sht_fast"] = loadfx("vfx/water/falling_water_drip_line_lg_runner_sht_fast");
	level._effect["grass_blowing_wind_01"] = loadfx("vfx/foliage/grass_blowing_wind_01");
	level._effect["ground_sand_fine_flat_loop"] = loadfx("vfx/sand/ground_sand_fine_flat_loop");
	level._effect["ground_sand_fine_flat"] = loadfx("vfx/sand/ground_sand_fine_flat");
	level._effect["electrical_arc_2"] = loadfx("vfx/map/mp_solar/electrical_arc_2");
	level._effect["mp_solar_water_wake_02"] = loadfx("vfx/map/mp_solar/mp_solar_water_wake_02");
	level._effect["mp_solar_water_wake_01"] = loadfx("vfx/map/mp_solar/mp_solar_water_wake_01");
	level._effect["mp_levity_dust_ambient_int"] = loadfx("vfx/map/mp_levity/mp_levity_dust_ambient_int");
	level._effect["ambient_sand_lingering"] = loadfx("vfx/sand/ambient_sand_lingering");
	level._effect["ground_sand_drifts_flat_lp"] = loadfx("vfx/sand/ground_sand_drifts_flat_lp");
	level._effect["wind_gust_turbine_vortex_mp"] = loadfx("vfx/map/mp_dam/wind_gust_turbine_vortex_mp");
	precachefx();
}

//Function Number: 2
precachefx()
{
	level._effect["fx_flare_solar"] = loadfx("vfx/map/mp_solar/fx_flare_solar");
	level._effect["boiling_runner"] = loadfx("vfx/map/mp_solar/boiling_runner");
	level._effect["water_gush_pipe"] = loadfx("vfx/map/mp_solar/water_gush_pipe");
	level._effect["dust_blowing_ground_02_runner"] = loadfx("vfx/map/mp_solar/dust_blowing_ground_02_runner");
	level._effect["electrical_arc"] = loadfx("vfx/map/mp_dam/electrical_arc");
	level._effect["steam_column_rising"] = loadfx("vfx/steam/steam_column_rising");
	level._effect["smoke_white_column_lg"] = loadfx("vfx/map/mp_solar/smoke_white_column_lg");
	level._effect["low_dust_wave_runner_lp"] = loadfx("vfx/dust/low_dust_wave_runner_lp");
	level._effect["amb_dust_verylight_fade"] = loadfx("vfx/dust/amb_dust_verylight_fade");
	level._effect["wind_gust_turbine_vortex"] = loadfx("vfx/map/mp_dam/wind_gust_turbine_vortex");
	level._effect["godray_window_small_mp"] = loadfx("vfx/map/mp_dam/godray_window_small_mp");
	level._effect["godray_window_med_mp"] = loadfx("vfx/map/mp_dam/godray_window_med_mp");
	level._effect["godray_window_large2_mp"] = loadfx("vfx/map/mp_dam/godray_window_large2_mp");
	level._effect["godray_window_large_mp"] = loadfx("vfx/map/mp_dam/godray_window_large_mp");
	level._effect["electrical_arc_coil"] = loadfx("vfx/map/mp_dam/electrical_arc_coil");
	level._effect["lights_conelight_smokey"] = loadfx("vfx/lights/lights_conelight_smokey");
	level._effect["light_spotlight_cone_haze"] = loadfx("vfx/lights/light_spotlight_cone_haze");
	level._effect["light_godray_02"] = loadfx("vfx/lights/light_godray_beam_2");
	level._effect["lights_conelight_smokey"] = loadfx("vfx/lights/lights_conelight_smokey");
	level._effect["wind_blowing_debris"] = loadfx("vfx/wind/wind_blowing_debris");
	level._effect["water_tank_loop"] = loadfx("vfx/map/mp_solar/water_tank_loop");
	level._effect["fx_tower_flare"] = loadfx("vfx/map/mp_solar/fx_tower_flare");
	level._effect["solar_killstreak_death"] = loadfx("vfx/map/mp_solar/solar_killstreak_death");
	level._effect["fx_sunflare_lsr2"] = loadfx("vfx/map/mp_solar/fx_sunflare_lsr2");
	level._effect["water_drips_med"] = loadfx("vfx/rain/water_drips_med");
	level._effect["sol_evt_window_loop"] = loadfx("vfx/map/mp_solar/sol_evt_window_loop");
}