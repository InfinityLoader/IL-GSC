/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: crash_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 27
 * Decompile Time: 444 ms
 * Timestamp: 4/22/2024 2:27:11 AM
*******************************************************************/

//Function Number: 1
main()
{
	level._effect["wing_top_contrail_loop"] = loadfx("vfx/wind/wing_top_contrail_loop");
	level._effect["crash_ai_slide_snow_short"] = loadfx("vfx/map/crash/crash_ai_slide_snow_short");
	level._effect["crash_slice_device_plant"] = loadfx("vfx/map/crash/crash_slice_device_plant");
	level._effect["ground_snow_hvy_avalanche"] = loadfx("vfx/map/crash/ground_snow_hvy_avalanche");
	level._effect["waterfall_splash_base_sm"] = loadfx("vfx/water/waterfall_splash_base_sm");
	level._effect["waterfall"] = loadfx("vfx/water/waterfall");
	level._effect["waterfall_splash_base_lg"] = loadfx("vfx/water/waterfall_splash_base_lg");
	level._effect["ground_snow_hvy_wind_vista"] = loadfx("vfx/snow/ground_snow_hvy_wind_vista");
	level._effect["blood_impact_burst"] = loadfx("vfx/blood/blood_impact_burst");
	level._effect["snow_blizard_far"] = loadfx("vfx/wind/snow_blizard_far");
	level._effect["ice_chute_falling_debris"] = loadfx("vfx/map/crash/ice_chute_falling_debris");
	level._effect["fire_wreckage_ground_nolight"] = loadfx("vfx/map/crash/fire_wreckage_ground_nolight");
	level._effect["ground_snow_hvy_wind_flat_crash"] = loadfx("vfx/snow/ground_snow_hvy_wind_flat_crash");
	level._effect["smoke_pillar_overlook"] = loadfx("vfx/map/crash/smoke_pillar_overlook");
	level._effect["crash_ai_snow_trail"] = loadfx("vfx/map/crash/crash_ai_snow_trail");
	level._effect["crash_rocket_explosion_default"] = loadfx("vfx/map/crash/crash_rocket_explosion_default");
	level._effect["smoke_flare_out"] = loadfx("vfx/smoke/smoke_flare_out");
	level._effect["water_rising"] = loadfx("vfx/map/crash/water_rising");
	level._effect["vehicle_skyjack_explosion_rhtengine"] = loadfx("vfx/explosion/vehicle_skyjack_explosion_rhtengine");
	level._effect["crash_vtol_landing_exp"] = loadfx("vfx/map/crash/crash_vtol_landing_exp");
	level._effect["fire_burning_vtol_left"] = loadfx("vfx/map/crash/fire_burning_vtol_left");
	level._effect["snow_cloud_moutain_peak"] = loadfx("vfx/wind/snow_cloud_moutain_peak");
	level._effect["crate_crash_slide_snow"] = loadfx("vfx/map/crash/crate_crash_slide_snow");
	level._effect["water_trail"] = loadfx("vfx/water/water_trail");
	level._effect["light_underwater_godray_beam_moving_med"] = loadfx("vfx/map/crash/light_underwater_godray_beam_moving_med");
	level._effect["vtol_crash_slide_snow"] = loadfx("vfx/map/crash/vtol_crash_slide_snow");
	level._effect["crash_site_clouds"] = loadfx("vfx/map/crash/crash_site_clouds");
	level._effect["smoketrail_groundtoair"] = loadfx("vfx/trail/smoketrail_groundtoair_crash");
	level._effect["smoldering_smk_ground_fast_crash"] = loadfx("vfx/smoke/smoldering_smk_ground_fast_crash");
	level._effect["helmet_light"] = loadfx("vfx/lights/helmet_light");
	level._effect["crash_overlook_clouds"] = loadfx("vfx/snow/crash_overlook_clouds");
	level._effect["ambient_explosion_midair_runner_single"] = loadfx("vfx/explosion/ambient_explosion_midair_runner_single");
	level._effect["crash_goliath_walk"] = loadfx("vfx/map/crash/crash_goliath_walk");
	level._effect["crash_cormack_land"] = loadfx("vfx/map/crash/crash_cormack_land");
	level._effect["crash_player_snow_hands"] = loadfx("vfx/map/crash/crash_player_snow_hands");
	level._effect["crash_player_snow_legs"] = loadfx("vfx/map/crash/crash_player_snow_legs");
	level._effect["crash_bridge_exp_far"] = loadfx("vfx/map/crash/crash_bridge_exp_far");
	level._effect["crash_bridge_exp_fall_screen"] = loadfx("vfx/map/crash/crash_bridge_exp_fall_screen");
	level._effect["crash_bridge_player_chunks"] = loadfx("vfx/map/crash/crash_bridge_player_chunks");
	level._effect["ledge_snow_hvy_wind_a_lrg"] = loadfx("vfx/snow/ledge_snow_hvy_wind_a_lrg");
	level._effect["crash_bridge_thick_fall"] = loadfx("vfx/map/crash/crash_bridge_thick_fall");
	level._effect["snow_wind_cave"] = loadfx("vfx/snow/snow_wind_cave");
	level._effect["crash_bridge_exp_fall"] = loadfx("vfx/map/crash/crash_bridge_exp_fall");
	level._effect["crash_bridge_exp_screen"] = loadfx("vfx/map/crash/crash_bridge_exp_screen");
	level._effect["smoke_flare_landing_crash"] = loadfx("vfx/smoke/smoke_flare_landing_crash");
	level._effect["crash_slice_laser_beam_cut"] = loadfx("vfx/map/crash/crash_slice_laser_beam_cut");
	level._effect["crash_slice_laser_beam"] = loadfx("vfx/map/crash/crash_slice_laser_beam");
	level._effect["crash_slice_device_laser_cut_bk"] = loadfx("vfx/map/crash/crash_slice_device_laser_cut_bk");
	level._effect["crash_slice_device_laser_cut_ft"] = loadfx("vfx/map/crash/crash_slice_device_laser_cut_ft");
	level._effect["crash_slice_device_cutting_explosions"] = loadfx("vfx/map/crash/crash_slice_device_cutting_explosions");
	level._effect["crash_slice_device_small_explosion"] = loadfx("vfx/map/crash/crash_slice_device_small_explosion");
	level._effect["crash_res_exp"] = loadfx("vfx/map/crash/crash_res_exp");
	level._effect["snow_blowing_gust"] = loadfx("vfx/snow/snow_blowing_gust");
	level._effect["battlefield_smoke_dark_l"] = loadfx("vfx/smoke/battlefield_smoke_dark_l");
	level._effect["smoldering_smk_ground_xlrg_crash"] = loadfx("vfx/smoke/smoldering_smk_ground_xlrg_crash");
	level._effect["fire_wreckage_ground"] = loadfx("vfx/map/crash/fire_wreckage_ground");
	level._effect["greece_vehicle_fire_small"] = loadfx("vfx/map/greece/greece_vehicle_fire_small");
	level._effect["flat_snow_blowing"] = loadfx("vfx/wind/flat_snow_blowing");
	level._effect["billow_snow_avalanche_nophy"] = loadfx("vfx/map/crash/avalanche/billow_snow_avalanche_nophy");
	level._effect["rocks_falling_water"] = loadfx("vfx/rock/rocks_falling_water");
	level._effect["smoke_flare_held_crash"] = loadfx("vfx/smoke/smoke_flare_held_crash");
	level._effect["crash_drone_main_engine"] = loadfx("vfx/map/crash/crash_drone_main_engine");
	level._effect["crash_atlas_jet_ext_leftwing_lights"] = loadfx("vfx/map/crash/crash_atlas_jet_ext_leftwing_lights");
	level._effect["crash_atlas_jet_ext_rightwing_lights"] = loadfx("vfx/map/crash/crash_atlas_jet_ext_rightwing_lights");
	level._effect["crash_atlas_jet_exterior_lights"] = loadfx("vfx/map/crash/crash_atlas_jet_exterior_lights");
	level._effect["jet_thruster_atlasplane_left"] = loadfx("vfx/smoke/jet_thruster_atlasplane_left");
	level._effect["jet_thruster_atlasplane_right"] = loadfx("vfx/smoke/jet_thruster_atlasplane_right");
	level._effect["vtol_crash_rear_snow"] = loadfx("vfx/smoke/vtol_crash_rear_snow");
	level._effect["vtol_crash_landing_snow"] = loadfx("vfx/smoke/vtol_crash_landing_snow");
	level._effect["fire_burning_vtol"] = loadfx("vfx/map/crash/fire_burning_vtol");
	level._effect["crash_wing_explo_damage"] = loadfx("vfx/map/crash/crash_wing_explo_damage");
	level._effect["water_impact_spawner"] = loadfx("vfx/water/water_impact_spawner");
	level._effect["water_jet"] = loadfx("vfx/water/water_jet");
	level._effect["screen_fx_emerge"] = loadfx("vfx/water/screen_fx_emerge");
	level._effect["waterfall_foam_edge"] = loadfx("vfx/water/waterfall_foam_edge");
	level._effect["waterfall_edge_splatter"] = loadfx("vfx/water/waterfall_edge_splatter");
	level._effect["falling_snow_impact_sound"] = loadfx("vfx/map/crash/falling_snow_impact_sound");
	level._effect["falling_ice_impact_sound"] = loadfx("vfx/map/crash/falling_ice_impact_sound");
	level._effect["cave_water_drip_impact"] = loadfx("vfx/map/crash/cave_water_drip_impact");
	level._effect["water_breach_crash"] = loadfx("vfx/water/water_breach_crash");
	level._effect["calving"] = loadfx("vfx/map/crash/avalanche/calving");
	level._effect["avalanche_flowing_exfil"] = loadfx("vfx/snow/avalanche_flowing_exfil");
	level._effect["avalanche_flowing"] = loadfx("vfx/snow/avalanche_flowing");
	level._effect["falling_avalanche_snow_runner"] = loadfx("vfx/snow/falling_avalanche_snow_runner");
	level._effect["ice_hallway_falling_debris"] = loadfx("vfx/map/crash/ice_hallway_falling_debris");
	level._effect["water_curtain_leak_thin_crash"] = loadfx("vfx/rain/water_curtain_leak_thin_crash");
	level._effect["dripping_ledges_heavy_crash"] = loadfx("vfx/rain/dripping_ledges_heavy_crash");
	level._effect["water_drips_crash_ripples"] = loadfx("vfx/rain/water_drips_crash_ripples");
	level._effect["water_drips_crash_caves"] = loadfx("vfx/rain/water_drips_crash_caves");
	level._effect["billow_snow_avalanche"] = loadfx("vfx/map/crash/avalanche/billow_snow_avalanche");
	level._effect["snow_clouds"] = loadfx("vfx/map/crash/avalanche/snow_clouds");
	level._effect["falling_chunks"] = loadfx("vfx/map/crash/avalanche/falling_chunks");
	level._effect["fracture_burst"] = loadfx("vfx/map/crash/avalanche/fracture_burst");
	level._effect["underwater_particulates_ice"] = loadfx("vfx/map/crash/underwater_particulates_ice");
	level._effect["ice_entry_explosion"] = loadfx("vfx/map/crash/ice_entry_explosion");
	level._effect["footstep_snow_crash"] = loadfx("vfx/treadfx/footstep_snow_crash");
	level._effect["falling_icechunks_child"] = loadfx("vfx/snow/falling_icechunks_child");
	level._effect["vehicle_skyjack_wing_trail"] = loadfx("vfx/explosion/vehicle_skyjack_wing_trail");
	level._effect["wing_top_contrail"] = loadfx("vfx/wind/wing_top_contrail");
	common_scripts\utility::flag_init("indoors");
	common_scripts\utility::flag_init("outdoors");
	common_scripts\utility::flag_init("hide_player_snow_footprints");
	level._effect["falling_snow_runner"] = loadfx("vfx/snow/falling_snow_runner");
	level._effect["falling_water_interior_crash"] = loadfx("vfx/map/crash/falling_water_interior_crash");
	level._effect["falling_water_exterior_narrow"] = loadfx("vfx/water/falling_water_exterior_narrow");
	level._effect["snow_impact_runner"] = loadfx("vfx/weaponimpact/snow_impact_runner");
	level._effect["ie_waterfall_intro_duo"] = loadfx("vfx/map/irons_estate/ie_waterfall_intro_duo");
	level._effect["ie_waterfall_sparklies"] = loadfx("vfx/map/irons_estate/ie_waterfall_sparklies");
	level._effect["ie_waterfall_thin_b"] = loadfx("vfx/map/irons_estate/ie_waterfall_thin_b");
	thread treadfx_override();
	thread setup_footstep_fx();
	set_lighting_values();
	level._effect["light_coldfog_anim"] = loadfx("vfx/map/crash/light_coldfog_anim");
	level._effect["falling_water_drip_line_lg_runner_fast"] = loadfx("vfx/water/falling_water_drip_line_lg_runner_fast");
	level._effect["cloud_oriented_vista"] = loadfx("vfx/cloud/cloud_oriented_vista");
	level._effect["ground_snow_hvy_wind_flat_wide_lp"] = loadfx("vfx/snow/ground_snow_hvy_wind_flat_wide_lp");
	level._effect["snow_dune_top"] = loadfx("vfx/wind/snow_dune_top");
	level._effect["light_rays_moving_rappel"] = loadfx("vfx/map/crash/light_rays_moving_rappel");
	level._effect["light_rays_moving_vesti"] = loadfx("vfx/map/crash/light_rays_moving_vesti");
	level._effect["light_rays_moving_caves"] = loadfx("vfx/map/crash/light_rays_moving_caves");
	level._effect["fx_sunflare_crash"] = loadfx("vfx/lensflare/fx_sunflare_crash");
	level._effect["razorback_death_explosion"] = loadfx("vfx/explosion/razorback_death_explosion");
	level._effect["fireball_lp_smk_xlrg_tall"] = loadfx("vfx/fire/fireball_lp_smk_xlrg_tall");
	level._effect["smoke_pillar_black_large_slow"] = loadfx("vfx/smoke/smoke_pillar_black_large_slow");
	level._effect["vehicle_destroyed_fire_m"] = loadfx("vfx/fire/vehicle_destroyed_fire_m");
	level._effect["distortion_warbird"] = loadfx("vfx/distortion/distortion_warbird");
	level._effect["helicopter_damaged_fire_m"] = loadfx("vfx/fire/helicopter_damaged_fire_m");
	level._effect["ground_snow_flurries"] = loadfx("vfx/snow/ground_snow_flurries");
	level._effect["ground_snow_light_wind_lp"] = loadfx("vfx/snow/ground_snow_light_wind_lp");
	level._effect["ground_snow_drifts_flat_lp"] = loadfx("vfx/snow/ground_snow_drifts_flat_lp");
	level._effect["vehicle_skyjack_explosion_midair"] = loadfx("vfx/explosion/vehicle_skyjack_explosion_midair");
	level._effect["cold_breath"] = loadfx("vfx/unique/cold_breath_cheap");
	level._effect["clouds_moving_fast"] = loadfx("vfx/map/crash/clouds_moving_fast");
	level._effect["snow_wind"] = loadfx("vfx/snow/snow_wind");
	level._effect["boost_dust_npc"] = loadfx("vfx/smoke/jetpack_exhaust_npc");
	level._effect["boost_dust_impact_ground"] = loadfx("vfx/smoke/jetpack_ground_impact_runner");
	level._effect["warbird_harpoon_spiral"] = loadfx("vfx/vehicle/warbird_harpoon_spiral");
	level._effect["warbird_zip_rope_glow"] = loadfx("vfx/vehicle/warbird_zip_rope_glow");
	level._effect["dust_harpoon_impact"] = loadfx("vfx/dust/dust_harpoon_impact");
	level._effect["jetpack_exhaust_exhaust_npc"] = loadfx("vfx/smoke/jetpack_exhaust_npc");
	level._effect["jetpack_skyjack_trail"] = loadfx("vfx/smoke/jetpack_skyjack_trail");
	level._effect["decompress_hole"] = loadfx("vfx/gas/decompress_hole");
	level._effect["jet_thruster"] = loadfx("vfx/smoke/jet_thruster");
	level._effect["drone_chute_thruster"] = loadfx("vfx/map/crash/drone_chute_thruster");
	level._effect["orbital_pod_trail_crsh"] = loadfx("vfx/trail/orbital_pod_trail_crsh");
	level._effect["drop_pod_landing_impact_snow"] = loadfx("vfx/smoke/drop_pod_landing_impact_snow");
	level._effect["drop_pod_landing_impact_nosmoke"] = loadfx("vfx/smoke/drop_pod_landing_impact_nosmoke");
	level._effect["helicopter_explosion_secondary_small"] = loadfx("fx/explosions/helicopter_explosion_secondary_small");
	level._effect["trail_fire_smoke_l"] = loadfx("vfx/trail/trail_fire_smoke_l");
	level._effect["smoke_trail_black_heli_emitter"] = loadfx("vfx/trail/smoke_trail_black_heli_emitter");
	level._effect["ambient_explosion_snow_01"] = loadfx("vfx/explosion/ambient_explosion_snow_01");
	level._effect["ambient_exp_snow_playspace"] = loadfx("vfx/explosion/ambient_exp_snow_playspace");
	level._effect["sonic_charge"] = loadfx("vfx/map/crash/sonic_charge");
	level._effect["resonance_device_light"] = loadfx("vfx/map/crash/resonance_device_light");
	level._effect["heli_dust_snow"] = loadfx("vfx/treadfx/heli_dust_snow");
	level._effect["walker_footstep"] = loadfx("vfx/treadfx/footstep_walker_tank");
	level._effect["walker_footstep_snow"] = loadfx("vfx/map/crash/tank_snow_leg_impact");
	level._effect["fx_crash_hud_flare"] = loadfx("vfx/map/crash/fx_crash_hud_flare");
	level._effect["geo_scanner"] = loadfx("vfx/map/crash/geo_scanner");
	level._effect["energy_distort"] = loadfx("vfx/map/crash/drone_energy_distortion");
	level._effect["cormack_fail_light"] = loadfx("vfx/map/crash/crash_flashlight_spotlight_cormack_light");
	level._effect["landass_exhaust_smk_vm"] = loadfx("vfx/smoke/landass_exhaust_smk_vm");
	level._effect["landass_impact_smk_vm"] = loadfx("vfx/smoke/landass_impact_smk_vm");
	level._effect["landass_exhaust_smk_rt_npc"] = loadfx("vfx/smoke/landass_exhaust_smk_rt_npc");
	level._effect["alternate_jump"] = loadfx("vfx/code/high_jump_jetpack");
	level._effect["rocket_explosion"] = loadfx("vfx/explosion/rocket_explosion_paintedmetal");
	level._effect["crash_goliath_wake_runner_temp"] = loadfx("vfx/map/crash/crash_goliath_wake_runner_temp");
	level._effect["flash_light"] = loadfx("vfx/map/crash/crash_flashlight_spotlight_player_light");
	level._effect["wall_break"] = loadfx("vfx/map/crash/ice_impact");
	level._effect["512_landing"] = loadfx("vfx/weaponimpact/snow_lrgchunk_impact");
	level._effect["snow_impact"] = loadfx("vfx/map/crash/crash_overlook_landing");
	level._effect["snow_grab"] = loadfx("vfx/snow/falling_snow_child");
	level._effect["ai_slide_snow"] = loadfx("vfx/map/crash/crash_ai_slide_snow");
	level._effect["player_bubbles"] = loadfx("vfx/water/underwater_bubble_vm_gasping_breath");
	level._effect["splash_bubbles"] = loadfx("vfx/water/underwater_splash_foam");
	level._effect["floaty_bits"] = loadfx("vfx/map/crash/underwater_particulates_ice");
	level._effect["sinky_bits"] = loadfx("vfx/map/crash/underwater_sinking_ice_single_01");
	level._effect["underwater_bubble_long_crash"] = loadfx("vfx/water/underwater_bubble_long_crash");
	level._effect["falling_icechunks_slide"] = loadfx("vfx/snow/falling_icechunks_slide");
	level._effect["warbird_death"] = loadfx("vfx/explosion/vehicle_warbird_explosion_midair");
	level._effect["warbird_ice_impact"] = loadfx("vfx/map/crash/avalanche/vitol_ice_impact");
	level._effect["javelin_ignition"] = loadfx("fx/misc/javelin_ignition");
	level._effect["smoketrail_rpg_sp"] = loadfx("vfx/trail/smoketrail_rpg_sp");
	level._effect["test_effect"] = loadfx("vfx/test/test_fx");
	level._effect["fracture_burst"] = loadfx("vfx/map/crash/avalanche/fracture_burst");
	level._effect["falling_chunks"] = loadfx("vfx/map/crash/avalanche/falling_chunks");
	level._effect["screen_avalanche_death"] = loadfx("vfx/map/crash/avalanche/screen_avalanche_death");
	level._effect["crash_bridge_glow_light"] = loadfx("vfx/map/crash/crash_bridge_glow_light");
	level._effect["crash_bridge_glow_spread"] = loadfx("vfx/map/crash/crash_bridge_glow_spread");
	level._effect["crash_bridge_glow"] = loadfx("vfx/map/crash/crash_bridge_glow");
	level._effect["crash_goliath_foot"] = loadfx("vfx/map/crash/crash_goliath_foot");
	level._effect["crash_bridge_exp"] = loadfx("vfx/map/crash/crash_bridge_exp");
	level._effect["crash_goliath_jump"] = loadfx("vfx/map/crash/crash_goliath_jump");
	level._effect["crash_goliath_body_impact"] = loadfx("vfx/map/crash/crash_goliath_body_impact");
	level._effect["crash_goliath_run_wake"] = loadfx("vfx/map/crash/crash_goliath_run_wake");
	level._effect["crash_bridge_water_chunks"] = loadfx("vfx/map/crash/crash_bridge_water_chunks");
	level._effect["crash_goliath_wake_runner"] = loadfx("vfx/map/crash/crash_goliath_wake_runner");
	level._effect["crash_goliath_entry_ice"] = loadfx("vfx/map/crash/crash_goliath_entry_ice");
	level._effect["crash_goliath_bridge_fall"] = loadfx("vfx/map/crash/crash_goliath_bridge_fall");
	level._effect["crash_bridge_player_slide"] = loadfx("vfx/map/crash/crash_bridge_player_slide");
	level._effect["crash_bridge_far_slide"] = loadfx("vfx/map/crash/crash_bridge_far_slide");
	level._effect["crash_bridge_far_soot"] = loadfx("vfx/map/crash/crash_bridge_far_soot");
	level._effect["crash_bridge_boost"] = loadfx("vfx/map/crash/crash_bridge_boost");
	level._effect["crash_bridge_pre_smk"] = loadfx("vfx/map/crash/crash_bridge_pre_smk");
	level._effect["ie_dustonlens"] = loadfx("vfx/map/irons_estate/ie_dustonlens");
	level._effect["crash_bridge_water_chunks_splash"] = loadfx("vfx/map/crash/crash_bridge_water_chunks_splash");
	level._effect["cg_light_flare"] = loadfx("vfx/map/crash/crash_light_flare_bright_cg");
	level._effect["railgun_blast_snow"] = loadfx("vfx/weaponimpact/railgun_snow_impact_1");
	level._effect["railgun_tracer"] = loadfx("vfx/map/crash/crash_sniper_railgun_tracer");
	if(!getdvarint("r_reflectionProbeGenerate"))
	{
		maps\createfx\crash_fx::main();
	}
}

//Function Number: 2
set_lighting_values()
{
	if(isusinghdr())
	{
		setsaveddvar("r_tonemap",2);
	}
}

//Function Number: 3
cold_breath()
{
	var_00 = "TAG_EYE";
	self endon("death");
	self notify("stop personal effect");
	self endon("stop personal effect");
	self.has_cold_breath = 1;
	while(isdefined(self))
	{
		wait(0.05);
		if(!isdefined(self))
		{
			break;
		}

		playfxontag(level._effect["cold_breath"],self,var_00);
		wait(2.5 + randomfloat(2.5));
	}
}

//Function Number: 4
setup_footstep_fx()
{
	level._effect["footstep_snow"] = loadfx("vfx/treadfx/footstep_snow_crash");
	level._effect["footstep_snow_small"] = loadfx("vfx/treadfx/footstep_snow_crash");
	level._effect["footstep_ice"] = loadfx("vfx/treadfx/footstep_snow_crash");
	level._effect["footstep_dust"] = loadfx("fx/impacts/footstep_dust");
	level._effect["blank"] = loadfx("fx/misc/blank");
	level.player thread playersnowfootstepscrash();
	common_scripts\utility::flag_set("outdoors");
	for(;;)
	{
		animscripts\utility::setfootstepeffect("snow",level._effect["footstep_snow"]);
		animscripts\utility::setfootstepeffect("ice",level._effect["footstep_ice"]);
		animscripts\utility::setfootstepeffect("asphalt",level._effect["footstep_dust"]);
		animscripts\utility::setfootstepeffect("dirt",level._effect["footstep_dust"]);
		animscripts\utility::setfootstepeffectsmall("snow",level._effect["footstep_snow_small"]);
		animscripts\utility::setfootstepeffectsmall("ice",level._effect["footstep_ice"]);
		animscripts\utility::setfootstepeffectsmall("asphalt",level._effect["footstep_dust"]);
		animscripts\utility::setfootstepeffectsmall("dirt",level._effect["footstep_dust"]);
		common_scripts\utility::flag_wait("indoors");
		common_scripts\utility::flag_clear("outdoors");
		animscripts\utility::setfootstepeffect("snow",level._effect["blank"]);
		animscripts\utility::setfootstepeffect("ice",level._effect["blank"]);
		animscripts\utility::setfootstepeffect("asphalt",level._effect["blank"]);
		animscripts\utility::setfootstepeffect("dirt",level._effect["blank"]);
		animscripts\utility::setfootstepeffectsmall("snow",level._effect["blank"]);
		animscripts\utility::setfootstepeffectsmall("ice",level._effect["blank"]);
		animscripts\utility::setfootstepeffectsmall("asphalt",level._effect["blank"]);
		animscripts\utility::setfootstepeffectsmall("dirt",level._effect["blank"]);
		common_scripts\utility::flag_wait("outdoors");
		common_scripts\utility::flag_clear("indoors");
	}
}

//Function Number: 5
playersnowfootstepscrash()
{
	var_00 = "left";
	for(;;)
	{
		wait(randomfloatrange(0.25,0.5));
		if(var_00 == "left")
		{
			var_01 = self.origin - (anglestoforward(self.angles)[0] * 48,anglestoforward(self.angles)[1] * 48,0) + (anglestoright(self.angles)[0] * -6,anglestoright(self.angles)[1] * -6,0);
			var_02 = self.origin - (anglestoforward(self.angles)[0] * 48,anglestoforward(self.angles)[1] * 48,5) + (anglestoright(self.angles)[0] * -6,anglestoright(self.angles)[1] * -6,0);
			var_00 = "right";
		}
		else
		{
			var_01 = self.origin - (anglestoforward(self.angles)[0] * 48,anglestoforward(self.angles)[1] * 48,0) + (anglestoright(self.angles)[0] * 6,anglestoright(self.angles)[1] * 6,0);
			var_02 = self.origin - (anglestoforward(self.angles)[0] * 48,anglestoforward(self.angles)[1] * 48,5) + (anglestoright(self.angles)[0] * 6,anglestoright(self.angles)[1] * 6,0);
			var_00 = "left";
		}

		var_03 = bullettrace(var_01,var_02,0,undefined);
		var_04 = anglestoforward(self.angles);
		var_05 = distance(self getvelocity(),(0,0,0));
		if(isdefined(self.vehicle))
		{
			continue;
		}

		if(var_03["surfacetype"] != "snow")
		{
			continue;
		}

		if(var_05 <= 24)
		{
			continue;
		}

		var_06 = "snow_movement";
		if(!common_scripts\utility::flag("hide_player_snow_footprints"))
		{
			if(distance(self getvelocity(),(0,0,0)) <= 154)
			{
				playfx(common_scripts\utility::getfx("footstep_snow_small"),var_03["position"],var_03["normal"],var_04 + (0,180,0));
			}

			if(distance(self getvelocity(),(0,0,0)) > 154)
			{
				playfx(common_scripts\utility::getfx("footstep_snow"),var_03["position"],var_03["normal"],var_04 + (0,180,0));
			}
		}
	}
}

//Function Number: 6
skyjack_drone_fx()
{
	var_00 = common_scripts\utility::getfx("crash_drone_main_engine");
	var_01 = common_scripts\utility::getfx("drone_chute_thruster");
	playfxontag(var_00,self,"tag_engine");
	self waittillmatch("end","single anim");
	wait(0.7);
	stopfxontag(var_00,self,"tag_engine");
	self waittillmatch("jets_on","single anim");
	playfxontag(var_00,self,"tag_engine");
	wait 0.05;
	playfxontag(var_01,self,"tag_engine_r");
	playfxontag(var_01,self,"tag_engine_l");
	common_scripts\utility::flag_wait("skyjack_end_heavy_clouds");
	wait(3.25);
	stopfxontag(var_00,self,"tag_engine");
	stopfxontag(var_01,self,"tag_engine_r");
	stopfxontag(var_01,self,"tag_engine_l");
}

//Function Number: 7
skyjack_atlas_jet_fx()
{
	var_00 = common_scripts\utility::getfx("jet_thruster_atlasplane_left");
	var_01 = common_scripts\utility::getfx("jet_thruster_atlasplane_right");
	var_02 = common_scripts\utility::getfx("crash_atlas_jet_exterior_lights");
	var_03 = common_scripts\utility::getfx("crash_atlas_jet_ext_leftwing_lights");
	var_04 = common_scripts\utility::getfx("crash_atlas_jet_ext_rightwing_lights");
	var_05 = common_scripts\utility::getfx("crash_slice_device_laser_cut_ft");
	var_06 = common_scripts\utility::getfx("crash_slice_device_laser_cut_bk");
	playfxontag(var_00,self,"TAG_LT_WING_EXHAUSE_FX");
	playfxontag(var_01,self,"TAG_RT_WING_EXHAUSE_FX");
	wait 0.05;
	playfxontag(var_02,self,"body_animate_jnt");
	wait 0.05;
	playfxontag(var_03,self,"body_animate_jnt");
	playfxontag(var_04,self,"body_animate_jnt");
	self waittillmatch("activate","single anim");
	playfxontag(var_06,self,"TAG_FX_LT_WING_LASER_BK");
	playfxontag(var_05,self,"TAG_FX_LT_WING_LASER_FT");
	self waittillmatch("end_front","single anim");
	stopfxontag(var_05,self,"TAG_FX_LT_WING_LASER_FT");
	self waittillmatch("end_back","single anim");
	wait(0.2);
	killfxontag(var_06,self,"TAG_FX_LT_WING_LASER_BK");
	self waittillmatch("begin_explosion","single anim");
	stopfxontag(var_00,self,"TAG_LT_WING_EXHAUSE_FX");
	stopfxontag(var_01,self,"TAG_RT_WING_EXHAUSE_FX");
	wait(0.1);
	stopfxontag(var_03,self,"body_animate_jnt");
	stopfxontag(var_04,self,"body_animate_jnt");
	wait(0.1);
	stopfxontag(var_02,self,"body_animate_jnt");
}

//Function Number: 8
skyjack_charge_fx()
{
	var_00 = common_scripts\utility::getfx("crash_slice_laser_beam");
	var_01 = common_scripts\utility::getfx("crash_slice_device_plant");
	self waittillmatch("bolt_anchors","single anim");
	playfxontag(var_01,self,"J_Bolt_FL");
	playfxontag(var_01,self,"J_Bolt_FR");
	playfxontag(var_01,self,"J_Bolt_KL");
	playfxontag(var_01,self,"J_Bolt_KR");
	self waittillmatch("activate","single anim");
	playfxontag(var_00,self,"Tag_FX_Panel_L");
	playfxontag(var_00,self,"Tag_FX_Panel_R");
	self waittillmatch("end_front","single anim");
	stopfxontag(var_00,self,"Tag_FX_Panel_L");
	self waittillmatch("end_back","single anim");
	stopfxontag(var_00,self,"Tag_FX_Panel_R");
	playfxontag(common_scripts\utility::getfx("crash_slice_device_cutting_explosions"),self,"tag_body");
}

//Function Number: 9
skyjack_wing_explosion()
{
	var_00 = level.skyjack_plane common_scripts\utility::spawn_tag_origin();
	var_01 = level.skyjack_plane common_scripts\utility::spawn_tag_origin();
	var_00.origin = level.skyjack_plane gettagorigin("tag_smoke_lt_body");
	var_01.origin = level.skyjack_plane gettagorigin("tag_smoke_rt_body");
	var_00 linkto(level.skyjack_plane,"tag_smoke_lt_body");
	var_01 linkto(level.skyjack_plane,"tag_smoke_rt_body");
	playfx(level._effect["vehicle_skyjack_explosion_midair"],var_00.origin);
	playfx(level._effect["vehicle_skyjack_explosion_rhtengine"],var_01.origin);
	common_scripts\utility::flag_wait("skyjack_end_heavy_clouds");
	wait(3.25);
	var_00 delete();
	var_01 delete();
}

//Function Number: 10
skyjack_plane_contrails()
{
	var_00 = level.skyjack_plane common_scripts\utility::spawn_tag_origin();
	var_01 = level.skyjack_plane common_scripts\utility::spawn_tag_origin();
	var_00.origin = level.skyjack_plane gettagorigin("tag_rt_wing_light_fx");
	var_01.origin = level.skyjack_plane gettagorigin("tag_lt_wing_light_fx");
	var_00.angles = level.skyjack_plane gettagangles("tag_rt_wing_light_fx");
	var_01.angles = level.skyjack_plane gettagangles("tag_lt_wing_light_fx");
	var_00 linkto(level.skyjack_plane,"tag_rt_wing_light_fx");
	var_01 linkto(level.skyjack_plane,"tag_lt_wing_light_fx");
	var_02 = (0,90,0);
	while(!common_scripts\utility::flag("skyjack_end_heavy_clouds"))
	{
		if(level.fastcloudlevel > 0)
		{
			playfx(level._effect["wing_top_contrail"],var_01.origin,(1,1,0.1));
		}

		wait(0.3);
	}

	var_00 delete();
	var_01 delete();
}

//Function Number: 11
treadfx_override()
{
	var_00 = "vfx/treadfx/heli_dust_snow";
	maps\_treadfx::setallvehiclefx("script_vehicle_littlebird_sentinel",var_00);
}

//Function Number: 12
ambush_heli_explosion()
{
	playfxontag(level._effect["helicopter_damaged_fire_m"],level.sent_chopper,"tag_engine");
	wait(0.4);
	stopfxontag(level._effect["helicopter_damaged_fire_m"],level.sent_chopper,"tag_engine");
}

//Function Number: 13
resonance_light()
{
	playfxontag(common_scripts\utility::getfx("resonance_device_light"),self,"tag_fx");
	wait(0.5);
	for(var_00 = 0;var_00 < 2;var_00++)
	{
		playfxontag(common_scripts\utility::getfx("resonance_device_light"),self,"tag_fx");
		wait(0.25);
	}

	for(var_00 = 0;var_00 < 5;var_00++)
	{
		playfxontag(common_scripts\utility::getfx("resonance_device_light"),self,"tag_fx");
		wait(0.1);
	}
}

//Function Number: 14
walker_tank_footstep_left(param_00)
{
	playfxontag(common_scripts\utility::getfx("walker_footstep"),param_00,"frontWheelTread01_FL");
}

//Function Number: 15
walker_tank_footstep_right(param_00)
{
	playfxontag(common_scripts\utility::getfx("walker_footstep"),param_00,"frontWheelTread01_FR");
}

//Function Number: 16
walker_tank_footstep_left_rear(param_00)
{
	playfxontag(common_scripts\utility::getfx("walker_footstep"),param_00,"frontWheelTread05_KL");
}

//Function Number: 17
walker_tank_footstep_right_rear(param_00)
{
	playfxontag(common_scripts\utility::getfx("walker_footstep"),param_00,"frontWheelTread05_KR");
}

//Function Number: 18
narrow_cave_axe_throw(param_00)
{
	playfxontag(common_scripts\utility::getfx("water_trail"),level.ice_axe,"tag_fx");
}

//Function Number: 19
overlook_smoke_vista()
{
	var_00 = getent("overlook_smoke","targetname");
	var_01 = var_00 common_scripts\utility::spawn_tag_origin();
	var_02 = playfxontag(level._effect["smoke_pillar_overlook"],var_01,"tag_origin");
	common_scripts\utility::flag_wait("lake_start");
	common_scripts\_exploder::exploder(8420);
	stopfxontag(level._effect["smoke_pillar_overlook"],var_01,"tag_origin");
}

//Function Number: 20
bridge_glows()
{
}

//Function Number: 21
bridge_explosion()
{
	common_scripts\_exploder::exploder(666);
	wait(3);
	maps\_utility::stop_exploder(666);
}

//Function Number: 22
goliath_entry_ice()
{
	common_scripts\_exploder::exploder(701);
}

//Function Number: 23
bridge_chunks()
{
	wait(8);
	common_scripts\_exploder::exploder(901);
	common_scripts\_exploder::exploder(905);
	common_scripts\_exploder::exploder(906);
	common_scripts\_exploder::exploder(909);
	wait(6);
	maps\_utility::stop_exploder(901);
	maps\_utility::stop_exploder(905);
	maps\_utility::stop_exploder(906);
}

//Function Number: 24
bridge_soot()
{
	wait(1.3);
	common_scripts\_exploder::exploder(902);
	wait(1);
	maps\_utility::stop_exploder(902);
}

//Function Number: 25
bridge_screenfx()
{
	wait(10);
	common_scripts\_exploder::exploder(907);
}

//Function Number: 26
far_explode()
{
	wait(7.8);
	common_scripts\_exploder::exploder(909);
}

//Function Number: 27
gideon_boost_jump()
{
	common_scripts\utility::flag_wait("gideon_boost_jump");
	playfxontag(common_scripts\utility::getfx("crash_bridge_boost"),level.gideon,"j_ball_le");
	playfxontag(common_scripts\utility::getfx("crash_ai_snow_trail"),level.gideon,"j_ball_le");
	common_scripts\_exploder::kill_exploder(3173);
	common_scripts\_exploder::kill_exploder(3131);
}