/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_climate_3_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 30
 * Decompile Time: 504 ms
 * Timestamp: 4/22/2024 2:17:10 AM
*******************************************************************/

//Function Number: 1
main()
{
	level._effect["mp_climate_center_window_toxic"] = loadfx("vfx/map/mp_climate/mp_climate_center_window_toxic");
	level._effect["mp_climate_center_machine_window"] = loadfx("vfx/map/mp_climate/mp_climate_center_machine_window");
	level._effect["cli_screen_drops"] = loadfx("vfx/map/mp_climate/cli_screen_drops");
	level._effect["toxic_waterfall_splashes"] = loadfx("vfx/map/mp_climate/toxic_waterfall_splashes");
	level._effect["mp_climate_toxic_waterfall_release"] = loadfx("vfx/map/mp_climate/mp_climate_toxic_waterfall_release");
	level._effect["mp_climate_toxic_waterfall_large"] = loadfx("vfx/map/mp_climate/mp_climate_toxic_waterfall_large");
	level._effect["mp_climate_vent_trans_runner"] = loadfx("vfx/map/mp_climate/mp_climate_vent_trans_runner");
	level._effect["cli_waterfall_rainbow"] = loadfx("vfx/map/mp_climate/cli_waterfall_rainbow");
	level._effect["mp_climate_waterfall_mesh_distort"] = loadfx("vfx/map/mp_climate/mp_climate_waterfall_mesh_distort");
	level._effect["mp_climate_fish_school_circle"] = loadfx("vfx/map/mp_climate/mp_climate_fish_school_circle");
	level._effect["mp_climate_window_toxic"] = loadfx("vfx/map/mp_climate/mp_climate_window_toxic");
	level._effect["cli_lilypad_runner"] = loadfx("vfx/map/mp_climate/cli_lilypad_runner");
	level._effect["cli_calm_water_foam_strip"] = loadfx("vfx/map/mp_climate/cli_calm_water_foam_strip");
	level._effect["cli_calm_water_foam_sm"] = loadfx("vfx/map/mp_climate/cli_calm_water_foam_sm");
	level._effect["cli_calm_water_foam"] = loadfx("vfx/map/mp_climate/cli_calm_water_foam");
	level._effect["mp_climate_waterfall_large_02"] = loadfx("vfx/map/mp_climate/mp_climate_waterfall_large_02");
	level._effect["mp_climate_machine_window"] = loadfx("vfx/map/mp_climate/mp_climate_machine_window");
	level._effect["cli_heat_distortion_large"] = loadfx("vfx/map/mp_climate/cli_heat_distortion_large");
	level._effect["cli_electrical_sparks_runner_no_bounce"] = loadfx("vfx/map/mp_climate/cli_electrical_sparks_runner_no_bounce");
	level._effect["mp_climate_toxic_med_pipe"] = loadfx("vfx/map/mp_climate/mp_climate_toxic_med_pipe");
	level._effect["mp_climate_toxic_sml_pipe"] = loadfx("vfx/map/mp_climate/mp_climate_toxic_sml_pipe");
	level._effect["mp_climate_toxic_lrg_pipe"] = loadfx("vfx/map/mp_climate/mp_climate_toxic_lrg_pipe");
	level._effect["mp_climate_lrg_pipe"] = loadfx("vfx/map/mp_climate/mp_climate_lrg_pipe");
	level._effect["mp_climate_med_pipe"] = loadfx("vfx/map/mp_climate/mp_climate_med_pipe");
	level._effect["mp_climate_sml_pipe"] = loadfx("vfx/map/mp_climate/mp_climate_sml_pipe");
	level._effect["mp_climate_vent_filler"] = loadfx("vfx/map/mp_climate/mp_climate_vent_filler");
	level._effect["cli_small_toxic_steam"] = loadfx("vfx/map/mp_climate/cli_small_toxic_steam");
	level._effect["cli_slow_steam_linger"] = loadfx("vfx/map/mp_climate/cli_slow_steam_linger");
	level._effect["cli_lightrays_sml"] = loadfx("vfx/map/mp_climate/cli_lightrays_sml");
	level._effect["cli_clear_water_displacement_patch"] = loadfx("vfx/map/mp_climate/cli_clear_water_displacement_patch");
	level._effect["cli_toxic_water_displacement_patch"] = loadfx("vfx/map/mp_climate/cli_toxic_water_displacement_patch");
	level._effect["cli_electrical_arc_roll"] = loadfx("vfx/map/mp_climate/cli_electrical_arc_roll");
	level._effect["mp_climate_green_room_ambient"] = loadfx("vfx/map/mp_climate/mp_climate_green_room_ambient");
	level._effect["cli_butterfly_runner"] = loadfx("vfx/map/mp_climate/cli_butterfly_runner");
	level._effect["cli_toxic_water_displacement_patch"] = loadfx("vfx/map/mp_climate/cli_toxic_water_displacement_patch");
	level._effect["cli_lightrays_lrg"] = loadfx("vfx/map/mp_climate/cli_lightrays_lrg");
	level._effect["cli_toxic_water_boiling_clear_runner"] = loadfx("vfx/map/mp_climate/cli_toxic_water_boiling_clear_runner");
	level._effect["cli_smoke_rise"] = loadfx("vfx/map/mp_climate/cli_smoke_rise");
	level._effect["mp_climate_vent_smoke_transition_b"] = loadfx("vfx/map/mp_climate/mp_climate_vent_smoke_transition_b");
	level._effect["cli_insect_dragonfly_runner"] = loadfx("vfx/map/mp_climate/cli_insect_dragonfly_runner");
	level._effect["mp_godray_dusty"] = loadfx("vfx/map/mp_climate/mp_godray_dusty");
	level._effect["falling_water_drip_line_runner_fast"] = loadfx("vfx/water/falling_water_drip_line_runner_fast");
	level._effect["cli_vent_fire_crawl"] = loadfx("vfx/map/mp_climate/cli_vent_fire_crawl");
	level._effect["cli_lilypad"] = loadfx("vfx/map/mp_climate/cli_lilypad");
	level._effect["cli_lilypad_death"] = loadfx("vfx/map/mp_climate/cli_lilypad_death");
	level._effect["mp_climate_vent_transition"] = loadfx("vfx/map/mp_climate/mp_climate_vent_transition");
	level._effect["cli_toxic_water_transition_pool_2"] = loadfx("vfx/map/mp_climate/cli_toxic_water_transition_pool_2");
	level._effect["cli_toxic_water_transition_pool_1"] = loadfx("vfx/map/mp_climate/cli_toxic_water_transition_pool_1");
	level._effect["mp_climate_electrical_sparks_heavy"] = loadfx("vfx/map/mp_climate/mp_climate_electrical_sparks_heavy");
	level._effect["cli_less_freq_electrical_sparks_runner"] = loadfx("vfx/map/mp_climate/cli_less_freq_electrical_sparks_runner");
	level._effect["cli_electrical_sparks_runner"] = loadfx("vfx/map/mp_climate/cli_electrical_sparks_runner");
	level._effect["mp_climate_vent_smoke_transition"] = loadfx("vfx/map/mp_climate/mp_climate_vent_smoke_transition");
	level._effect["mp_climate_electrical_arcs_runner"] = loadfx("vfx/map/mp_climate/mp_climate_electrical_arcs_runner");
	level._effect["mp_climate_smoke_plume"] = loadfx("vfx/map/mp_climate/mp_climate_smoke_plume");
	level._effect["mp_climate_steam_toxic_transition"] = loadfx("vfx/map/mp_climate/mp_climate_steam_toxic_transition");
	level._effect["mp_climate_vent_steam_small"] = loadfx("vfx/map/mp_climate/mp_climate_vent_steam_small");
	level._effect["mp_climate_ambient_int"] = loadfx("vfx/map/mp_climate/mp_climate_ambient_int");
	level._effect["mp_climate_dust_ambient_int"] = loadfx("vfx/map/mp_climate/mp_climate_dust_ambient_int");
	level._effect["water_pipe_drip_lp"] = loadfx("vfx/water/water_pipe_drip_lp");
	level._effect["electrical_sparks_small_runner"] = loadfx("vfx/explosion/electrical_sparks_small_runner");
	level._effect["mp_climate_fish_jumping_runner"] = loadfx("vfx/map/mp_climate/mp_climate_fish_jumping_runner");
	level._effect["mp_climate_fish_jumping"] = loadfx("vfx/map/mp_climate/mp_climate_fish_jumping");
	level._effect["mp_climate_vent_steam"] = loadfx("vfx/map/mp_climate/mp_climate_vent_steam");
	level._effect["mp_climate_leaves_blow_runner"] = loadfx("vfx/map/mp_climate/mp_climate_leaves_blow_runner");
	level._effect["mp_climate_birds_takeoff_runner"] = loadfx("vfx/map/mp_climate/mp_climate_birds_takeoff_runner");
	level._effect["mp_climate_crumbling_rock_runner"] = loadfx("vfx/map/mp_climate/mp_climate_crumbling_rock_runner");
	level._effect["mp_climate_cloud_cover"] = loadfx("vfx/map/mp_climate/mp_climate_cloud_cover");
	level._effect["cli_toxic_water_boiling_bubble_runner"] = loadfx("vfx/map/mp_climate/cli_toxic_water_boiling_bubble_runner");
	level._effect["cli_water_surface_steam"] = loadfx("vfx/map/mp_climate/cli_water_surface_steam");
	level._effect["test_effect"] = loadfx("vfx/test/test_fx");
	level._effect["fx_sunflare_mp_climate_3"] = loadfx("vfx/lensflare/fx_sunflare_mp_climate_3");
	level._effect["mp_climate_waterfall_large"] = loadfx("vfx/map/mp_climate/mp_climate_waterfall_large");
	level._effect["flower_petals_runner"] = loadfx("vfx/map/mp_climate/flower_petals_runner");
	level._effect["ambient_needles_runner"] = loadfx("vfx/map/mp_climate/ambient_needles_runner");
	level._effect["mp_climate_fish_school"] = loadfx("vfx/map/mp_climate/mp_climate_fish_school");
	level._effect["waterfall_splashes"] = loadfx("vfx/map/mp_climate/waterfall_splashes");
	level._effect["mp_climate_waterfall_release"] = loadfx("vfx/map/mp_climate/mp_climate_waterfall_release");
	level._effect["plastic_shreds_hanging_e_slow"] = loadfx("vfx/wind/plastic_shreds_hanging_e_slow");
	level._effect["mp_climate_streaming_water"] = loadfx("vfx/map/mp_climate/mp_climate_streaming_water");
	level._effect["mp_ground_grassdirt_runner"] = loadfx("vfx/map/mp_climate/mp_ground_grassdirt_runner");
	level thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		start_persistent_fx(var_00);
	}
}

//Function Number: 3
start_persistent_fx(param_00)
{
	if(level.toxiceventcomplete)
	{
		toxic_fx(param_00);
		return;
	}

	if(level.toxiceventstarted)
	{
		mid_event_fx(param_00);
		return;
	}

	clean_fx(param_00);
}

//Function Number: 4
clean_fx(param_00)
{
	vent_steam_fx(param_00);
	waterfall_start(param_00);
	machine_window_fx(param_00);
	clean_water_foam_fx(param_00);
	fish_school_fx(param_00);
}

//Function Number: 5
toxic_fx(param_00)
{
	top_vent_damage_fx(param_00);
	clear_water_transition_looping_fx(param_00);
	toxic_vent_steam_fx(param_00);
	small_toxic_vent_steam_fx(param_00);
	machine_toxic_window_fx(param_00);
	vent_firecrawl_fx(param_00);
	machine_toxic_pipes_fx(param_00);
	dead_fish_fx(param_00);
	toxic_waterfall_start(param_00);
	vent_smoke_damage_fx(param_00);
	less_freq_electrical_sparks_fx(param_00);
	water_surface_steam_fx(param_00);
}

//Function Number: 6
mid_event_fx(param_00)
{
	if(!isdefined(level.toxicstage6finished))
	{
		fish_school_fx(param_00);
		waterfall_start(param_00);
		if(!isdefined(level.toxicstage5finished))
		{
			clean_water_foam_fx(param_00);
			machine_window_fx(param_00);
			if(!isdefined(level.toxicstage3finished))
			{
				vent_steam_fx(param_00);
			}
		}
	}

	if(isdefined(level.toxicstage1finished) && level.toxicstage1finished)
	{
		top_vent_damage_fx(param_00);
		if(isdefined(level.toxicstage2finished) && level.toxicstage2finished)
		{
			clear_water_transition_looping_fx(param_00);
			electrical_arcs_fx(param_00);
			if(isdefined(level.toxicstage3finished) && level.toxicstage3finished)
			{
				toxic_vent_steam_fx(param_00);
				small_toxic_vent_steam_fx(param_00);
				machine_toxic_window_fx(param_00);
				if(isdefined(level.toxicstage4finished) && level.toxicstage4finished)
				{
					vent_firecrawl_fx(param_00);
					if(isdefined(level.toxicstage5finished) && level.toxicstage5finished)
					{
						machine_toxic_pipes_fx(param_00);
						if(isdefined(level.toxicstage6finished) && level.toxicstage6finished)
						{
							dead_fish_fx(param_00);
							toxic_waterfall_start(param_00);
							if(isdefined(level.toxicstage7finished) && level.toxicstage7finished)
							{
								vent_smoke_damage_fx(param_00);
								return;
							}

							return;
						}

						return;
					}

					return;
				}

				return;
			}
		}
	}
}

//Function Number: 7
water_surface_steam_fx(param_00)
{
	level thread common_scripts\_exploder::activate_clientside_exploder(1,param_00);
}

//Function Number: 8
waterfall_start(param_00)
{
	level thread common_scripts\_exploder::activate_clientside_exploder(20,param_00);
}

//Function Number: 9
toxic_waterfall_start(param_00)
{
	if(!isdefined(param_00))
	{
		stopclientexploder(20);
	}

	level thread common_scripts\_exploder::activate_clientside_exploder(21,param_00);
}

//Function Number: 10
dead_fish_fx(param_00)
{
	if(!isdefined(param_00))
	{
		stopclientexploder(2);
		wait(1);
	}

	level thread common_scripts\_exploder::activate_clientside_exploder(3,param_00);
}

//Function Number: 11
machine_window_fx(param_00)
{
	level thread common_scripts\_exploder::activate_clientside_exploder(17,param_00);
}

//Function Number: 12
machine_toxic_pipes_fx(param_00)
{
	if(!isdefined(param_00))
	{
		stopclientexploder(17);
	}

	level thread common_scripts\_exploder::activate_clientside_exploder(18,param_00);
}

//Function Number: 13
machine_toxic_window_fx(param_00)
{
	level thread common_scripts\_exploder::activate_clientside_exploder(19,param_00);
}

//Function Number: 14
fish_school_fx(param_00)
{
	level thread common_scripts\_exploder::activate_clientside_exploder(2,param_00);
}

//Function Number: 15
water_transition_fx()
{
	level thread common_scripts\_exploder::activate_clientside_exploder(200);
	wait(8);
	stopclientexploder(201);
	wait 0.05;
	stopclientexploder(203);
}

//Function Number: 16
clear_water_transition_fx()
{
	level thread common_scripts\_exploder::activate_clientside_exploder(201);
}

//Function Number: 17
clear_water_transition_looping_fx(param_00)
{
	if(!isdefined(param_00))
	{
		wait 0.05;
	}

	level thread common_scripts\_exploder::activate_clientside_exploder(202,param_00);
}

//Function Number: 18
vent_steam_fx(param_00)
{
	level thread common_scripts\_exploder::activate_clientside_exploder(6,param_00);
}

//Function Number: 19
toxic_vent_steam_fx(param_00)
{
	if(!isdefined(param_00))
	{
		stopclientexploder(6);
	}

	level thread common_scripts\_exploder::activate_clientside_exploder(5,param_00);
}

//Function Number: 20
small_toxic_vent_steam_fx(param_00)
{
	level thread common_scripts\_exploder::activate_clientside_exploder(16,param_00);
}

//Function Number: 21
top_vent_damage_fx(param_00)
{
	level thread common_scripts\_exploder::activate_clientside_exploder(7,param_00);
}

//Function Number: 22
vent_smoke_damage_fx(param_00)
{
	level thread common_scripts\_exploder::activate_clientside_exploder(8,param_00);
}

//Function Number: 23
vent_metal_shards_fx()
{
	level thread common_scripts\_exploder::activate_clientside_exploder(9);
}

//Function Number: 24
freq_electrical_sparks_fx()
{
	level thread common_scripts\_exploder::activate_clientside_exploder(10);
}

//Function Number: 25
less_freq_electrical_sparks_fx(param_00)
{
	if(!isdefined(param_00))
	{
		stopclientexploder(10);
		stopclientexploder(12);
		stopclientexploder(13);
	}

	level thread common_scripts\_exploder::activate_clientside_exploder(11,param_00);
}

//Function Number: 26
electrical_arcs_fx(param_00)
{
	level thread common_scripts\_exploder::activate_clientside_exploder(12,param_00);
}

//Function Number: 27
electrical_arc_coils_fx()
{
	level thread common_scripts\_exploder::activate_clientside_exploder(15);
}

//Function Number: 28
heavy_electrical_sparks_fx()
{
	level thread common_scripts\_exploder::activate_clientside_exploder(13);
}

//Function Number: 29
vent_firecrawl_fx(param_00)
{
	level thread common_scripts\_exploder::activate_clientside_exploder(14,param_00);
}

//Function Number: 30
clean_water_foam_fx(param_00)
{
	level thread common_scripts\_exploder::activate_clientside_exploder(203,param_00);
}