/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_clowntown3_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 1
 * Decompile Time: 27 ms
 * Timestamp: 4/22/2024 2:17:14 AM
*******************************************************************/

//Function Number: 1
main()
{
	level._effect["ball_trail"] = loadfx("vfx/map/mp_clowntown/vfx_clown_ball_trl");
	level._effect["ball_idle"] = loadfx("vfx/map/mp_clowntown/vfx_clown_ball_idle");
	level._effect["cannon_firing"] = loadfx("vfx/map/mp_clowntown/ct_cannon_blast");
	level._effect["ball_flash"] = loadfx("vfx/map/mp_clowntown/vfx_clown_ball_glow");
	level._effect["ball_physics_impact"] = loadfx("vfx/map/mp_clowntown/clown_ball_bounce");
	level._effect["spark_fountain1"] = loadfx("vfx/weaponimpact/metal_spark_fountain_large");
	level._effect["mp_clowtown_sign_bubbles"] = loadfx("vfx/map/mp_clowntown/mp_clowtown_sign_bubbles");
	level._effect["mp_trash_blowing_ground"] = loadfx("vfx/wind/dlc/mp_trash_blowing_ground");
	level._effect["plastic_shreds_hanging_e_slow"] = loadfx("vfx/wind/plastic_shreds_hanging_e_slow");
	level._effect["amb_dust_patch_light"] = loadfx("vfx/dust/amb_dust_patch_light");
	level._effect["water_pipe_drip_lp"] = loadfx("vfx/water/water_pipe_drip_lp");
	level._effect["mp_dust_blowing_runner"] = loadfx("vfx/map/mp_clowntown/mp_dust_blowing_runner");
	level._effect["mp_ground_grassdirt_runner"] = loadfx("vfx/map/mp_clowntown/mp_ground_grassdirt_runner");
	level._effect["bird_vulture_circle_a_loop"] = loadfx("vfx/animal/bird_vulture_circle_a_loop");
	level._effect["rock_dust_falling_runner"] = loadfx("vfx/map/mp_clowntown/rock_dust_falling_runner");
	level._effect["fx_sunflare_clowntown_dlc"] = loadfx("vfx/lensflare/fx_sunflare_clowntown_dlc");
	level._effect["mp_ground_dirt_loop_runner"] = loadfx("vfx/map/mp_clowntown/mp_ground_dirt_loop_runner");
	level._effect["mp_clowntown_amb_dust_lg"] = loadfx("vfx/map/mp_clowntown/mp_clowntown_amb_dust_lg");
	level._effect["mp_clowntown_ambient_needles"] = loadfx("vfx/map/mp_clowntown/mp_clowntown_ambient_needles");
	level._effect["insects_flies_wall"] = loadfx("vfx/animal/insects_flies_wall");
	level._effect["mp_clowntown_dust_ambient_int"] = loadfx("vfx/map/mp_clowntown/mp_clowntown_dust_ambient_int");
	level._effect["falling_sewage_water_ripple_runner"] = loadfx("vfx/map/mp_clowntown/falling_sewage_water_ripple_runner");
	level._effect["sewage_water_stream"] = loadfx("vfx/map/mp_clowntown/sewage_water_stream");
	level._effect["roach_flock_slow_crawl_runner"] = loadfx("vfx/map/mp_clowntown/roach_flock_slow_crawl_runner");
	level._effect["roach_flock_scatter_runner"] = loadfx("vfx/map/mp_clowntown/roach_flock_scatter_runner");
	level._effect["sewage_water_trash"] = loadfx("vfx/map/mp_clowntown/sewage_water_trash");
	level._effect["sewage_water_bubbles"] = loadfx("vfx/map/mp_clowntown/sewage_water_bubbles");
	level._effect["insects_fruitflies_flying"] = loadfx("vfx/animal/insects_fruitflies_flying");
	level._effect["sewage_flies_flying"] = loadfx("vfx/map/mp_clowntown/sewage_flies_flying");
	level._effect["mp_clowntown_cloud_cover"] = loadfx("vfx/map/mp_clowntown/mp_clowntown_cloud_cover");
	level._effect["birds_tree_flyout_runner"] = loadfx("vfx/animal/birds_tree_flyout_runner");
	level._effect["mp_godray_dusty"] = loadfx("vfx/map/mp_clowntown/mp_godray_dusty");
	level._effect["insects_dragonfly_runner_a"] = loadfx("vfx/animal/insects_dragonfly_runner_a");
	level._effect["insects_moths"] = loadfx("vfx/animal/insects_moths");
	level._effect["insects_flies_landing"] = loadfx("vfx/animal/insects_flies_landing");
	level._effect["falling_water_drip_line_runner_slow"] = loadfx("vfx/water/falling_water_drip_line_runner_slow");
	level._effect["falling_water_drip_line_lg_runner_fast"] = loadfx("vfx/water/falling_water_drip_line_lg_runner_fast");
	level._effect["trash_dust_tornado_s_runner"] = loadfx("vfx/wind/trash_dust_tornado_s_runner");
	level._effect["mp_ground_dirt_loop_runner_flat"] = loadfx("vfx/map/mp_clowntown/mp_ground_dirt_loop_runner_flat");
	level._effect["mp_clowntown_rock_slide_s"] = loadfx("vfx/map/mp_clowntown/mp_clowntown_rock_slide_s");
	level._effect["mp_ground_ambient_sitting_dust"] = loadfx("vfx/map/mp_clowntown/mp_ground_ambient_sitting_dust");
	level._effect["electrical_sparks_small_runner"] = loadfx("vfx/explosion/electrical_sparks_small_runner");
	level._effect["mp_clowntown_bathroom_steam"] = loadfx("vfx/map/mp_clowntown/mp_clowntown_bathroom_steam");
	level._effect["mp_clowtown_sign_bubbles_runner"] = loadfx("vfx/map/mp_clowntown/mp_clowtown_sign_bubbles_runner");
	level._effect["mp_clowntown_bomb_fuse"] = loadfx("vfx/map/mp_clowntown/mp_clowntown_bomb_fuse");
	level._effect["mp_dust_blowing_runner_02"] = loadfx("vfx/map/mp_clowntown/mp_dust_blowing_runner_02");
	level._effect["dust_blowing_vista"] = loadfx("vfx/dust/dust_blowing_vista");
	level._effect["ct_heat_distortion_large"] = loadfx("vfx/map/mp_clowntown/ct_heat_distortion_large");
	level._effect["ground_sand_skitter"] = loadfx("vfx/sand/ground_sand_skitter");
	level._effect["mp_ground_dirt_loop_04"] = loadfx("vfx/map/mp_clowntown/mp_ground_dirt_loop_04");
	level._effect["clowntown_fire_m"] = loadfx("vfx/map/mp_clowntown/clowntown_fire_m");
}