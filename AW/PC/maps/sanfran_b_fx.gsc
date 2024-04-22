/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: sanfran_b_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 204 ms
 * Timestamp: 4/22/2024 2:35:27 AM
*******************************************************************/

//Function Number: 1
main()
{
	precachefx();
	maps\createfx\sanfran_b_fx::main();
	if(!isdefined(level.createfxent))
	{
		level.createfxent = [];
	}

	set_lighting_values();
	maps\_shg_fx::setup_shg_fx();
	common_scripts\utility::flag_init("msg_vfx_zone1000_disable");
	common_scripts\utility::flag_init("fx_stagger_env_fx");
	thread maps\_shg_fx::fx_zone_watcher(1000,"msg_vfx_zone1000","msg_vfx_zone1500","msg_vfx_zone1000_disable");
	thread maps\_shg_fx::fx_zone_watcher(2000,"msg_vfx_zone2000","msg_vfx_zone2100","msg_vfx_zone2300");
	thread maps\_shg_fx::fx_zone_watcher(2400,"msg_vfx_zone2400","msg_vfx_zone2500");
	thread maps\_shg_fx::fx_zone_watcher(3000,"msg_vfx_zone3000","msg_vfx_zone3100");
	thread maps\_shg_fx::fx_zone_watcher(4000,"msg_vfx_zone4000");
	thread stagger_env_fx();
}

//Function Number: 2
testfx()
{
	common_scripts\utility::flag_wait("msg_vfx_zone3000");
	iprintlnbold("3000");
	common_scripts\utility::flag_wait("msg_vfx_zone3000");
	iprintlnbold("1000");
	common_scripts\utility::flag_wait("msg_vfx_zone3000");
	iprintlnbold("2000");
}

//Function Number: 3
set_lighting_values()
{
	if(isusinghdr())
	{
		setsaveddvar("r_tonemap",2);
	}
}

//Function Number: 4
precachefx()
{
	level._effect["sub_monitor_explosion"] = loadfx("vfx/explosion/monitor_explo_1");
	level._effect["test_axis"] = loadfx("vfx/test/test_axis_2");
	level._effect["fire_lp_m_blacksmk_tall"] = loadfx("vfx/fire/fire_lp_m_blacksmk_tall");
	level._effect["embers_runner_loop_nosmoke"] = loadfx("vfx/fire/embers_runner_loop_nosmoke");
	level._effect["embers_runner_loop_no_cull"] = loadfx("vfx/map/sanfran_b/sfb_fire_embers_no_cull");
	level._effect["fire_lp_s_blacksmk"] = loadfx("vfx/fire/fire_lp_s_blacksmk");
	level._effect["fire_lp_l_blacksmk_thick_nonlit"] = loadfx("vfx/fire/fire_lp_l_blacksmk_thick_nonlit");
	level._effect["battlefield_smoke_m"] = loadfx("vfx/smoke/battlefield_smoke_windy_m");
	level._effect["aa_explosion_runner"] = loadfx("vfx/explosion/aa_explosion_runner");
	level._effect["ambient_explosion"] = loadfx("vfx/explosion/aa_explosion_generic_02");
	level._effect["water_drips_line_fast"] = loadfx("vfx/water/falling_water_drip_line_runner_fast");
	level._effect["water_falling_low_narrow"] = loadfx("vfx/water/falling_water_interior_narrow");
	level._effect["water_falling_low_wide"] = loadfx("vfx/water/falling_water_interior_wide");
	level._effect["water_falling_low_wide2"] = loadfx("vfx/water/falling_water_interior_wide2");
	level._effect["water_falling_trickle_wide"] = loadfx("vfx/water/falling_water_trickle_wide");
	level._effect["water_drips_splashes"] = loadfx("vfx/water/falling_water_drips_splashes_loop");
	level._effect["water_leak_small"] = loadfx("vfx/water/water_leak_pipe_small");
	level._effect["water_sprinkler"] = loadfx("vfx/water/water_sprinkler_spray_single");
	level._effect["wind_gust_seabreeze_edge_lg"] = loadfx("vfx/wind/wind_gust_seabreeze_edge_large");
	level._effect["wind_gust_seabreeze_lg"] = loadfx("vfx/wind/wind_gust_seabreeze_large");
	level._effect["wind_gust_mist_lg"] = loadfx("vfx/wind/wind_gust_water_mist_large");
	level._effect["smoke_flare_marker_yellow_windy"] = loadfx("vfx/smoke/smoke_flare_marker_yellow_windy");
	level._effect["steam_pipe_small"] = loadfx("vfx/steam/steam_pipe_leak_interior_sm");
	level._effect["steam_pipe_medium"] = loadfx("vfx/steam/steam_pipe_leak_interior_med");
	level._effect["fire_interior_debris_small"] = loadfx("vfx/map/sanfran_b/sfb_interior_fire_debris_sm");
	level._effect["fire_interior_debris_sm_no_light"] = loadfx("vfx/map/sanfran_b/sfb_interior_fire_debris_sm_no_light");
	level._effect["fire_interior_rubble_base_med"] = loadfx("vfx/map/sanfran_b/sfb_interior_fire_rubble_base_med");
	level._effect["fire_interior_rubble_med_light"] = loadfx("vfx/map/sanfran_b/sfb_interior_fire_rubble_med_light");
	level._effect["fire_interior_floor_med"] = loadfx("vfx/map/sanfran_b/sfb_interior_fire_floor_med");
	level._effect["fire_interior_wall_med"] = loadfx("vfx/map/sanfran_b/sfb_interior_fire_wall_med");
	level._effect["fire_interior_ceiling_med"] = loadfx("vfx/map/sanfran_b/sfb_interior_fire_ceiling_med");
	level._effect["fire_interior_smoke_filler"] = loadfx("vfx/map/sanfran_b/sfb_interior_fire_smoke_filler");
	level._effect["fire_interior_smoke_filler2"] = loadfx("vfx/map/sanfran_b/sfb_interior_fire_smoke_filler2");
	level._effect["fire_interior_smoke_filler3"] = loadfx("vfx/map/sanfran_b/sfb_interior_fire_smoke_filler3");
	level._effect["smoke_disperse_directional_lg"] = loadfx("vfx/map/sanfran_b/sfb_smoke_disperse_directional_lg");
	level._effect["smoke_column_spot_directional_lg"] = loadfx("vfx/smoke/smoke_grey_column_spot_directional_lg");
	level._effect["smoke_column_2_spot_directional_lg"] = loadfx("vfx/smoke/smoke_grey_column_2_spot_directional_lg");
	level._effect["smoke_column_3_spot_directional_lg"] = loadfx("vfx/smoke/smoke_grey_column_3_spot_directional_lg");
	level._effect["smoke_column_4_spot_directional_lg"] = loadfx("vfx/smoke/smoke_grey_column_4_spot_directional_lg");
	level._effect["fire_spot_directional_smoke_sm"] = loadfx("vfx/map/sanfran_b/sfb_fire_spot_directional_blacksmk_sm");
	level._effect["fire_spot_directional_smoke_med"] = loadfx("vfx/map/sanfran_b/sfb_fire_spot_directional_blacksmk_med");
	level._effect["fire_spot_directional_smoke_lg"] = loadfx("vfx/map/sanfran_b/sfb_fire_spot_directional_blacksmk_lg");
	level._effect["fire_spot_directional_med"] = loadfx("vfx/map/sanfran_b/sfb_fire_spot_directional_med");
	level._effect["fire_spot_directional_windy_smk_sm"] = loadfx("vfx/map/sanfran_b/sfb_fire_spot_directional_windy_smk_sm");
	level._effect["fire_spot_directional_windy_smk_med"] = loadfx("vfx/map/sanfran_b/sfb_fire_spot_direct_windy_smk_med");
	level._effect["fire_spot_directional_windy_xsm"] = loadfx("vfx/map/sanfran_b/sfb_fire_spot_directional_windy_xsm");
	level._effect["fire_spot_directional_windy_sm"] = loadfx("vfx/map/sanfran_b/sfb_fire_spot_directional_windy_sm");
	level._effect["fire_spot_directional_windy_med"] = loadfx("vfx/map/sanfran_b/sfb_fire_spot_directional_windy_med");
	level._effect["heli_dust_kickup"] = loadfx("vfx/map/sanfran_b/sfb_heli_dust_runner");
	level._effect["heli_down_draft"] = loadfx("vfx/map/sanfran_b/sfb_heli_down_draft");
	level._effect["sparks_interior_runner"] = loadfx("vfx/explosion/electrical_sparks_small_runner");
	level._effect["sparks_exterior_runner"] = loadfx("vfx/explosion/electrical_sparks_runner");
	level._effect["fire_molten_drip_med"] = loadfx("vfx/map/sanfran_b/sfb_fire_molten_drip_directional_med");
	level._effect["fire_molten_drip_lg"] = loadfx("vfx/map/sanfran_b/sfb_fire_molten_drip_directional_lg");
	level._effect["fire_vehicle_interior_small_1"] = loadfx("vfx/fire/vehicle_fire_interior_small_1_direct");
	level._effect["fire_vehicle_interior_small_2"] = loadfx("vfx/fire/vehicle_fire_interior_small_2_direct");
	level._effect["fire_vehicle_interior_small_3"] = loadfx("vfx/fire/vehicle_fire_interior_small_3_direct");
	level._effect["fire_interior_debris_small_2"] = loadfx("vfx/map/sanfran_b/sfb_interior_fire_debris_2_sm");
	level._effect["wind_blowing_debris"] = loadfx("vfx/wind/wind_blowing_debris");
	level._effect["fire_burst_car_crash"] = loadfx("vfx/map/sanfran_b/sfb_fire_burst_car_crash");
	level._effect["dust_blowing_ground_fast_xsm"] = loadfx("vfx/map/sanfran_b/sfb_dust_ground_blowing_fast_xsm");
	level._effect["smoke_ambient_large"] = loadfx("vfx/map/sanfran_b/sfb_ambient_smoke_lg");
	level._effect["smoke_ambient_dark_large"] = loadfx("vfx/map/sanfran_b/sfb_ambient_smoke_dark_lg");
	level._effect["cloud_mist_ambient_xlarge"] = loadfx("vfx/map/sanfran_b/sfb_ambient_cloud_mist_xlg");
	level._effect["cloud_mist_ambient_xxlarge"] = loadfx("vfx/map/sanfran_b/sfb_ambient_cloud_mist_xxlg");
	level._effect["dust_ground_residual_xsm"] = loadfx("vfx/map/sanfran_b/sfb_dust_ground_residual_xsm");
	level._effect["godray_wide_medium"] = loadfx("vfx/map/sanfran_b/sfb_godray_window2_wide");
	level._effect["godray_window_medium"] = loadfx("vfx/map/sanfran_b/sfb_godray_window2_med");
	level._effect["godray_medium_intro"] = loadfx("vfx/map/sanfran_b/sfb_godray_med_intro");
	level._effect["godray_window_large"] = loadfx("vfx/map/sanfran_b/sfb_godray_window_lg");
	level._effect["godray_window_large_dim"] = loadfx("vfx/map/sanfran_b/sfb_godray_window_lg_dim");
	level._effect["godray_window_large_cinematic"] = loadfx("vfx/map/sanfran_b/sfb_godray_window_lg_cinematic");
	level._effect["cg_ending_character_light"] = loadfx("vfx/map/sanfran_b/sfb_character_light_1_cg");
	level._effect["flesh_hit"] = loadfx("vfx/weaponimpact/flesh_impact_body_fatal_exit");
	level._effect["func_glass_shatter_64x64"] = loadfx("vfx/code/func_glass_shatter_64x64");
	level._effect["tire_industrial_01_rubber"] = loadfx("vfx/destructible/tire_industrial_01_rubber");
	level._effect["lights_godray_beam_simple"] = loadfx("vfx/lights/lights_godray_beam_simple");
	level._effect["lights_godray_beam_simple_lrg"] = loadfx("vfx/lights/lights_godray_beam_simple_lrg");
	level._effect["lights_godray_beam_simple_door"] = loadfx("vfx/lights/lights_godray_beam_simple_door");
	level._effect["lights_godray_beam_simple_window"] = loadfx("vfx/lights/lights_godray_beam_simple_window");
	level._effect["light_fluorescent_smoke_dim"] = loadfx("vfx/lights/light_fluorescent_smoke_dim");
	level._effect["light_smoke_dim"] = loadfx("vfx/lights/light_smoke_dim");
	level._effect["light_white_radiosity_sim"] = loadfx("vfx/lights/light_white_radiosity_sim");
	level._effect["lights_godray_beam_simple"] = loadfx("vfx/lights/lights_godray_beam_simple");
	level._effect["light_red_tower_bright"] = loadfx("vfx/lights/light_red_tower_bright");
	level._effect["sf_window_shadow"] = loadfx("vfx/lights/sanfran_b/sf_window_shadow");
	level._effect["light_red_strobe"] = loadfx("vfx/lights/sanfran_b/sf_light_red_strobe");
	level._effect["sfb_wind_blowing_debris"] = loadfx("vfx/map/sanfran_b/sfb_wind_blowing_debris");
	level._effect["water_dissipate_linger"] = loadfx("vfx/water/water_dissipate_linger");
	level._effect["light_firelight_lrg"] = loadfx("vfx/lights/light_firelight_lrg");
	level._effect["amb_dust_medium"] = loadfx("vfx/dust/amb_dust_medium");
	level._effect["spot_end"] = loadfx("vfx/lights/sanfran_b/sf_spot_end");
	level._effect["fire_horizon_glow_sf"] = loadfx("vfx/lights/sanfran_b/fire_horizon_glow_sf");
	level._effect["shadow_card"] = loadfx("vfx/lights/sanfran_b/shadow_card");
	level._effect["shadow_card1"] = loadfx("vfx/lights/sanfran_b/shadow_card1");
	level._effect["sanfran_sunflare_a"] = loadfx("vfx/lensflare/sanfran/sanfran_sunflare_a");
	level._effect["sanfran_sunflare_b"] = loadfx("vfx/lensflare/sanfran/sanfran_sunflare_b_cg");
	level._effect["boat_waves_cargoship_sfb"] = loadfx("vfx/water/boat_waves_cargoship_sfb");
	level._effect["boat_shockwave_cargoship_sfb"] = loadfx("vfx/water/boat_shockwave_cargoship_sfb");
	level._effect["water_impact"] = loadfx("vfx/explosion/water_impact_large");
	level._effect["boat_edge_wave_distortion"] = loadfx("vfx/water/boat_edge_wave_distortion");
	level._effect["boat_edge_wave_distortion_bottom"] = loadfx("vfx/water/boat_edge_wave_distortion_bottom");
	level._effect["boat_edge_wave_distortion_shadow"] = loadfx("vfx/water/boat_edge_wave_distortion_shadow");
	level._effect["boat_edge_wave_distortion_shadow_bottom"] = loadfx("vfx/water/boat_edge_wave_distortion_shadow_bottom");
	level._effect["sfb_cargoship_impact_explosion"] = loadfx("vfx/weaponimpact/railgun_ship_impact");
	level._effect["mob_turret_flash_view"] = loadfx("vfx/muzzleflash/mob_turret_flash_view");
	level._effect["mob_turret_flash_view_muzzlesmoke"] = loadfx("vfx/muzzleflash/mob_turret_flash_view_muzzlesmoke");
	level._effect["missile_launch_smoke"] = loadfx("vfx/muzzleflash/missile_launch_smoke");
	level._effect["cargoship_turret"] = loadfx("vfx/muzzleflash/cargoship_turret");
	level._effect["sfb_cargoship_explosion_1"] = loadfx("vfx/map/sanfran_b/sfb_cargoship_explosion_1");
	level._effect["sfb_cargoship_explosion_1_small"] = loadfx("vfx/map/sanfran_b/sfb_cargoship_explosion_1_small");
	level._effect["sfb_cargoship_explosion_1_reflect"] = loadfx("vfx/map/sanfran_b/sfb_cargoship_explosion_1_reflect");
	level._effect["sfb_ship_dripping_fire"] = loadfx("vfx/map/sanfran_b/sfb_ship_dripping_fire");
	level._effect["sfb_turret_mist_spray"] = loadfx("vfx/map/sanfran_b/sfb_turret_mist_spray");
	level._effect["drone_cam_distortion"] = loadfx("vfx/code/drone_cam_distortion");
	level._effect["sfb_bridge_debris_falling"] = loadfx("vfx/map/sanfran_b/sfb_bridge_debris_falling");
	level._effect["rpg_trail"] = loadfx("vfx/trail/smoketrail_shiptoship");
	level._effect["rpg_muzzle"] = loadfx("vfx/muzzleflash/x4walker_wheels_rpg_fv");
	level._effect["rpg_explode"] = loadfx("vfx/explosion/rocket_explosion_default");
}

//Function Number: 5
vfx_heli_drop_off_intro_on()
{
	maps\_utility::delaythread(0.1,::common_scripts\utility::flag_set,"msg_vfx_zone1000_disable");
	common_scripts\_exploder::exploder(4001);
	common_scripts\_exploder::exploder(4445);
	wait(3);
	maps\_utility::pauseexploder(4001);
	common_scripts\_exploder::exploder(4002);
	common_scripts\_exploder::exploder(4004);
	maps\_utility::delaythread(7,::maps\_utility::pauseexploder,4004);
	maps\_utility::delaythread(10,::maps\_utility::pauseexploder,4002);
	maps\_utility::delaythread(10,::common_scripts\_exploder::exploder,4001);
	maps\_utility::delaythread(11.7,::common_scripts\_exploder::exploder,4003);
	maps\_utility::delaythread(11.7,::common_scripts\_exploder::exploder,4005);
	maps\_utility::delaythread(15,::maps\_utility::pauseexploder,4003);
	maps\_utility::delaythread(16,::maps\_utility::pauseexploder,4005);
	thread maps\sanfran_b_lighting::dof_car_explosion();
	maps\_utility::delaythread(90,::maps\_utility::pauseexploder,4001);
}

//Function Number: 6
stagger_env_fx()
{
	common_scripts\utility::flag_wait("fx_stagger_env_fx");
	common_scripts\_exploder::exploder(1100);
}

//Function Number: 7
setup_window_explosion_wait()
{
	var_00 = getentarray("godray_destroyed","targetname");
	var_01 = getentarray("godray_destroyed_dim","targetname");
	var_02 = getentarray("window_explosion_wait","targetname");
	if(isdefined(var_00[0]))
	{
		common_scripts\utility::array_thread(var_00,::shadow_godray_window_large_think);
	}

	if(isdefined(var_01[0]))
	{
		common_scripts\utility::array_thread(var_01,::shadow_godray_window_large_dim_think);
	}

	if(isdefined(var_02[0]))
	{
		common_scripts\utility::array_thread(var_02,::window_explosion_wait_think);
	}
}

//Function Number: 8
shadow_destroyed_trigger_think()
{
	common_scripts\utility::trigger_off();
	level waittill("console_guy_dead");
	common_scripts\utility::trigger_on();
	self waittill("trigger");
	maps\_utility::stop_exploder(self.script_noteworthy);
}

//Function Number: 9
shadow_godray_window_large_think()
{
	common_scripts\utility::trigger_off();
	common_scripts\utility::trigger_on();
	self waittill("trigger");
	common_scripts\_exploder::exploder(self.script_noteworthy);
	level.player lightsetforplayer("sanfran_b_bridge");
	if(level.nextgen)
	{
		maps\_utility::fog_set_changes("sanfran_b_bridge",1.5);
		return;
	}

	maps\_utility::vision_set_fog_changes("sanfran_b_bridge",1.5);
}

//Function Number: 10
shadow_godray_window_large_dim_think()
{
	common_scripts\utility::trigger_off();
	common_scripts\utility::trigger_on();
	self waittill("trigger");
	maps\_utility::pauseexploder(self.script_noteworthy);
}

//Function Number: 11
window_explosion_wait_think()
{
	common_scripts\utility::trigger_off();
	common_scripts\utility::trigger_on();
}

//Function Number: 12
vfx_start_boost_fx(param_00)
{
	playfxontag(common_scripts\utility::getfx("boost_dust_npc"),param_00,"J_SpineLower");
	param_00 thread newhandlespawngroundimpact();
}

//Function Number: 13
vfx_stop_boost_fx(param_00)
{
	stopfxontag(common_scripts\utility::getfx("boost_dust_npc"),param_00,"J_SpineLower");
}

//Function Number: 14
newhandlespawngroundimpact()
{
	var_00 = self.origin + (0,0,64);
	var_01 = self.origin - (0,0,150);
	var_02 = bullettrace(var_00,var_01,0,undefined);
	var_03 = common_scripts\utility::getfx("boost_dust_impact_ground");
	var_00 = var_02["position"];
	var_04 = vectortoangles(var_02["normal"]);
	var_04 = var_04 + (90,0,0);
	var_05 = anglestoforward(var_04);
	var_06 = anglestoup(var_04);
	playfx(var_03,var_00,var_06,var_05);
}