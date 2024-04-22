/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_highrise2_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 43 ms
 * Timestamp: 4/22/2024 2:17:31 AM
*******************************************************************/

//Function Number: 1
main()
{
	level._effect["mp_hr2_water_dripping_edges_splashes"] = loadfx("vfx/map/mp_highrise2/mp_hr2_water_dripping_edges_splashes");
	level._effect["light_heli_red_blink_no_light"] = loadfx("vfx/lights/dlc/light_heli_red_blink_no_light");
	level._effect["mp_hr2_interior_dust_sm"] = loadfx("vfx/map/mp_highrise2/mp_hr2_interior_dust_sm");
	level._effect["mp_hr2_vista_fog_bright_far"] = loadfx("vfx/map/mp_highrise2/mp_hr2_vista_fog_bright_far");
	level._effect["steam_pipe_burst_lp_xsml"] = loadfx("vfx/steam/dlc/steam_pipe_burst_lp_xsml");
	level._effect["mp_hr2_interior_dust"] = loadfx("vfx/map/mp_highrise2/mp_hr2_interior_dust");
	level._effect["mp_hr2_drone_prop_wind"] = loadfx("vfx/map/mp_highrise2/mp_hr2_drone_prop_wind");
	level._effect["mp_hr2_drone_lightbeam"] = loadfx("vfx/map/mp_highrise2/mp_hr2_drone_lightbeam");
	level._effect["test_axis_effectnow"] = loadfx("vfx/test/test_axis_effectnow");
	level._effect["steam_ambient_vents_light"] = loadfx("vfx/map/mp_dam/steam_ambient_vents_light");
	level._effect["steam_sm_vent_a"] = loadfx("vfx/steam/dlc/steam_sm_vent_a");
	level._effect["steam_pipe_burst_lp_sm"] = loadfx("vfx/steam/dlc/steam_pipe_burst_lp_sm");
	level._effect["steam_ambient_vents"] = loadfx("vfx/map/mp_dam/steam_ambient_vents");
	level._effect["insects_moths"] = loadfx("vfx/animal/insects_moths");
	level._effect["mp_hr2_water_pipe_drips"] = loadfx("vfx/map/mp_highrise2/mp_hr2_water_pipe_drips");
	level._effect["mp_hr2_pipe_fan_spray"] = loadfx("vfx/map/mp_highrise2/mp_hr2_pipe_fan_spray");
	level._effect["mp_hr2_hose_water"] = loadfx("vfx/map/mp_highrise2/mp_hr2_hose_water");
	level._effect["mp_hr2_water_spray_narrow"] = loadfx("vfx/map/mp_highrise2/mp_hr2_water_spray_narrow");
	level._effect["mp_hr2_water_spray"] = loadfx("vfx/map/mp_highrise2/mp_hr2_water_spray");
	level._effect["mp_hr2_water_splashes_lp_runner"] = loadfx("vfx/map/mp_highrise2/mp_hr2_water_splashes_lp_runner");
	level._effect["mp_hr2_water_dripping_edges"] = loadfx("vfx/map/mp_highrise2/mp_hr2_water_dripping_edges");
	level._effect["mp_hr2_water_edge_runoff"] = loadfx("vfx/map/mp_highrise2/mp_hr2_water_edge_runoff");
	level._effect["mp_hr2_water_ring_ripple_lp"] = loadfx("vfx/map/mp_highrise2/mp_hr2_water_ring_ripple_lp");
	level._effect["mp_hr2_water_geyser"] = loadfx("vfx/map/mp_highrise2/mp_hr2_water_geyser");
	level._effect["mp_hr2_longflare"] = loadfx("vfx/map/mp_highrise2/mp_hr2_longflare");
	level._effect["mp_hr2_keyline_flare"] = loadfx("vfx/map/mp_highrise2/mp_hr2_keyline_flare");
	level._effect["mp_hr2_vista_fog_bright"] = loadfx("vfx/map/mp_highrise2/mp_hr2_vista_fog_bright");
	level._effect["mp_hr2_vista_fog"] = loadfx("vfx/map/mp_highrise2/mp_hr2_vista_fog");
	level._effect["mp_hr2_wind_gust_runner"] = loadfx("vfx/map/mp_highrise2/mp_hr2_wind_gust_runner");
	level._effect["mp_hr2_wind_gust_01"] = loadfx("vfx/map/mp_highrise2/mp_hr2_wind_gust_01");
	level._effect["electrical_sparks_runner_no_impact_spawn"] = loadfx("vfx/explosion/electrical_sparks_runner_no_impact_spawn");
	level._effect["brg_dust_mote_ambient_interior"] = loadfx("vfx/map/mp_zombie_brg/brg_dust_mote_ambient_interior");
	level._effect["trash_tornado_s_runner"] = loadfx("vfx/wind/dlc/trash_tornado_s_runner");
	level._effect["wind_blowing_debris_02"] = loadfx("vfx/wind/dlc/wind_blowing_debris_02");
	level._effect["light_clr_shell_filament_blue"] = loadfx("vfx/lights/light_clr_shell_filament_blue");
	level._effect["mp_pipe_gas_fire_leak_runner"] = loadfx("vfx/fire/mp_pipe_gas_fire_leak_runner");
	level._effect["fx_drone_flood_lgt_flare"] = loadfx("vfx/lensflare/fx_drone_flood_lgt_flare");
	level._effect["light_heli_red_blink"] = loadfx("vfx/lights/dlc/light_heli_red_blink");
	level._effect["mp_plex_drone_hover"] = loadfx("vfx/map/mp_perplex/mp_plex_drone_hover");
	level._effect["mp_hr2_light_glow_square"] = loadfx("vfx/map/mp_highrise2/mp_hr2_light_glow_square");
	level._effect["fx_highrise_flour_flare"] = loadfx("vfx/lensflare/fx_highrise_flour_flare");
	level._effect["mp_hr2_light_glow_spot"] = loadfx("vfx/map/mp_highrise2/mp_hr2_light_glow_spot");
	level._effect["fx_hr2_fluor_interior_flare"] = loadfx("vfx/lensflare/fx_hr2_fluor_interior_flare");
	thread helipad_light_fx();
}

//Function Number: 2
helipad_light_fx()
{
	wait(2);
	var_00 = common_scripts\utility::getstructarray("helipad_fx_loc","targetname");
	foreach(var_02 in var_00)
	{
		playfx(common_scripts\utility::getfx("light_clr_shell_filament_blue"),var_02.origin);
	}
}