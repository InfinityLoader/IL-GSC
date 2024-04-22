/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_terrace_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 37 ms
 * Timestamp: 4/22/2024 2:18:30 AM
*******************************************************************/

//Function Number: 1
main()
{
	level._effect["mp_gb_water_splash_sm"] = loadfx("vfx/map/mp_greenband/mp_gb_water_splash_sm");
	level._effect["leaves_blowing_slow"] = loadfx("vfx/wind/leaves_blowing_slow");
	level._effect["mp_terrace_spot_flare2"] = loadfx("vfx/lights/mp_terrace/mp_terrace_spot_flare2");
	level._effect["mp_terrace_spot_flare"] = loadfx("vfx/lights/mp_terrace/mp_terrace_spot_flare");
	level._effect["mp_terrace_sign_flare2"] = loadfx("vfx/lights/mp_terrace/mp_terrace_sign_flare2");
	level._effect["ambient_wind_particles_slow"] = loadfx("vfx/wind/ambient_wind_particles_slow");
	level._effect["insects_moths_area_sml"] = loadfx("vfx/animal/insects_moths_area_sml");
	level._effect["insects_mosquitos_flying"] = loadfx("vfx/animal/insects_mosquitos_flying");
	level._effect["mp_terrace_wall_light_04d"] = loadfx("vfx/lights/mp_terrace/mp_terrace_wall_light_04d");
	level._effect["mp_terrace_wall_light_04c"] = loadfx("vfx/lights/mp_terrace/mp_terrace_wall_light_04c");
	level._effect["mp_terrace_hanging_light3"] = loadfx("vfx/lights/mp_terrace/mp_terrace_hanging_light3");
	level._effect["mp_gb_sparks_runner"] = loadfx("vfx/map/mp_greenband/mp_gb_sparks_runner");
	level._effect["mp_terrace_dust_ambient_int_sm"] = loadfx("vfx/map/mp_terrace/mp_terrace_dust_ambient_int_sm");
	level._effect["mp_terrace_spotlight_cone3"] = loadfx("vfx/lights/mp_terrace/mp_terrace_spotlight_cone3");
	level._effect["mp_terrace_spotlight_cone_purple"] = loadfx("vfx/lights/mp_terrace/mp_terrace_spotlight_cone_purple");
	level._effect["mp_terrace_spotlight_cone_red"] = loadfx("vfx/lights/mp_terrace/mp_terrace_spotlight_cone_red");
	level._effect["mp_terrace_spotlight_cone2"] = loadfx("vfx/lights/mp_terrace/mp_terrace_spotlight_cone2");
	level._effect["mp_terrace_sign_flare"] = loadfx("vfx/lights/mp_terrace/mp_terrace_sign_flare");
	level._effect["mp_terrace_jewelry_light"] = loadfx("vfx/lights/mp_terrace/mp_terrace_jewelry_light");
	level._effect["mp_terrace_hanging_light2"] = loadfx("vfx/lights/mp_terrace/mp_terrace_hanging_light2");
	level._effect["mp_terrace_hanging_light"] = loadfx("vfx/lights/mp_terrace/mp_terrace_hanging_light");
	level._effect["mp_terrace_standing_light2"] = loadfx("vfx/lights/mp_terrace/mp_terrace_standing_light2");
	level._effect["mp_terrace_wall_light_04b"] = loadfx("vfx/lights/mp_terrace/mp_terrace_wall_light_04b");
	level._effect["mp_terrace_wall_light_01b"] = loadfx("vfx/lights/mp_terrace/mp_terrace_wall_light_01b");
	level._effect["mp_terrace_wall_light_02c"] = loadfx("vfx/lights/mp_terrace/mp_terrace_wall_light_02c");
	level._effect["mp_terrace_wall_light_02b"] = loadfx("vfx/lights/mp_terrace/mp_terrace_wall_light_02b");
	level._effect["mp_terrace_window_glow"] = loadfx("vfx/lights/mp_terrace/mp_terrace_window_glow");
	level._effect["mp_terrace_wall_glow"] = loadfx("vfx/lights/mp_terrace/mp_terrace_wall_glow");
	level._effect["mp_terrace_tv_glow"] = loadfx("vfx/lights/mp_terrace/mp_terrace_tv_glow");
	level._effect["mp_terrace_candle_light"] = loadfx("vfx/lights/mp_terrace/mp_terrace_candle_light");
	level._effect["mp_terrace_torch_light"] = loadfx("vfx/lights/mp_terrace/mp_terrace_torch_light");
	level._effect["mp_terrace_standing_light"] = loadfx("vfx/lights/mp_terrace/mp_terrace_standing_light");
	level._effect["mp_terrace_wall_light_04"] = loadfx("vfx/lights/mp_terrace/mp_terrace_wall_light_04");
	level._effect["mp_terrace_wall_light_03"] = loadfx("vfx/lights/mp_terrace/mp_terrace_wall_light_03");
	level._effect["mp_terrace_wall_light_02"] = loadfx("vfx/lights/mp_terrace/mp_terrace_wall_light_02");
	level._effect["mp_terrace_wall_light_01"] = loadfx("vfx/lights/mp_terrace/mp_terrace_wall_light_01");
	level._effect["mp_terrace_spotlight_cone"] = loadfx("vfx/lights/mp_terrace/mp_terrace_spotlight_cone");
	level._effect["mp_terrace_fountain_wake"] = loadfx("vfx/map/mp_terrace/mp_terrace_fountain_wake");
	level._effect["mp_terrace_dust_ambient_ext"] = loadfx("vfx/map/mp_terrace/mp_terrace_dust_ambient_ext");
	level._effect["mp_terrace_dust_ambient_int"] = loadfx("vfx/map/mp_terrace/mp_terrace_dust_ambient_int");
	level._effect["mp_terrace_motes_blue"] = loadfx("vfx/map/mp_terrace/mp_terrace_motes_blue");
	level._effect["dust_blowing_ground_slow_runner"] = loadfx("vfx/dust/dust_blowing_ground_slow_runner");
	level._effect["light_dust_particles"] = loadfx("vfx/dust/light_dust_particles");
	level._effect["ambient_wind_streaks"] = loadfx("vfx/wind/ambient_wind_streaks");
	level._effect["wave_mist"] = loadfx("vfx/water/wave_mist");
	level._effect["wave_hit_large_mp_runner"] = loadfx("vfx/water/wave_hit_large_mp_runner");
	level._effect["breaking_wave_large_01"] = loadfx("vfx/water/breaking_wave_large_01");
	level._effect["falling_water_drip_circle_lg_runner_fast"] = loadfx("vfx/water/falling_water_drip_circle_lg_runner_fast");
	level._effect["mp_terrace_pool_bubbles"] = loadfx("vfx/map/mp_terrace/mp_terrace_pool_bubbles");
	level._effect["mp_terrace_pool_wake"] = loadfx("vfx/map/mp_terrace/mp_terrace_pool_wake");
	level._effect["mp_terrace_lightning"] = loadfx("vfx/map/mp_terrace/mp_terrace_lightning");
	level._effect["mp_terrace_distant_rain"] = loadfx("vfx/map/mp_terrace/mp_terrace_distant_rain");
	level._effect["mp_terrace_steamroom_mist_fast"] = loadfx("vfx/map/mp_terrace/mp_terrace_steamroom_mist_fast");
	level._effect["mp_terrace_shower_spray"] = loadfx("vfx/map/mp_terrace/mp_terrace_shower_spray");
	level._effect["mp_terrace_shower_01"] = loadfx("vfx/map/mp_terrace/mp_terrace_shower_01");
	level._effect["fire_campfire_small"] = loadfx("vfx/fire/fire_campfire_small");
	level._effect["fire_campfire"] = loadfx("vfx/fire/fire_campfire");
	level._effect["embers_constant_sm"] = loadfx("vfx/fire/embers_constant_sm");
	level._effect["insects_gnats_flying_heavy"] = loadfx("vfx/map/mp_dam/insects_gnats_flying_heavy");
	level._effect["insects_flies_landing_sm"] = loadfx("vfx/animal/insects_flies_landing_sm");
	level._effect["wood_piece_falling_sm_runner"] = loadfx("vfx/explosion/wood_piece_falling_sm_runner");
	level._effect["ambient_falling_leaves_infrequent"] = loadfx("vfx/wind/ambient_falling_leaves_infrequent");
	level._effect["mp_terrace_steamroom_mist_lt"] = loadfx("vfx/map/mp_terrace/mp_terrace_steamroom_mist_lt");
	level._effect["mp_terrace_steamroom_mist"] = loadfx("vfx/map/mp_terrace/mp_terrace_steamroom_mist");
	level._effect["sniper_drone_thruster_view"] = loadfx("vfx/distortion/sniper_drone_runner_idle_view");
	level._effect["sniper_drone_wind_marker"] = loadfx("vfx/map/greece/sniper_drone_wind_marker_runner");
}