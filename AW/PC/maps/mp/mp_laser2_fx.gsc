/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_laser2_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 146 ms
 * Timestamp: 4/22/2024 2:17:52 AM
*******************************************************************/

//Function Number: 1
main()
{
	level._effect["steam_sm_street_windy"] = loadfx("vfx/steam/steam_sm_street_windy");
	level._effect["ref_wall_light"] = loadfx("vfx/lights/lgt_fixtures/ref_wall_light");
	level._effect["lab2_interiorlight_1_intct_loop"] = loadfx("vfx/lights/lgt_fixtures/lab2_interiorlight_1_intct_loop");
	level._effect["lab2_mod_wall_light_x64_glow_loop"] = loadfx("vfx/lights/lgt_fixtures/lab2_mod_wall_light_x64_glow_loop");
	level._effect["laser2_lighthouse_light"] = loadfx("vfx/lights/mp_laser2/laser2_lighthouse_light");
	level._effect["light_laser_fill"] = loadfx("vfx/lights/mp_laser2/light_laser_fill");
	level._effect["light_laser_off_lightbeam"] = loadfx("vfx/lights/mp_laser2/light_laser_off_lightbeam");
	level._effect["boat_edge_wave_distortion"] = loadfx("vfx/map/mp_laser2/laser2_boat_edge_wave_distortion");
	level._effect["shallow_debris_physics"] = loadfx("vfx/map/mp_laser2/shallow_debris_physics");
	level._effect["cargo_containers_physics"] = loadfx("vfx/map/mp_laser2/cargo_containers_physics");
	level._effect["test_water_physics"] = loadfx("vfx/test/test_water_physics");
	level._effect["rain_floorsheet_slow_foam_200x200_mist"] = loadfx("vfx/rain/rain_floorsheet_slow_foam_200x200_mist");
	level._effect["beacon_light_red_blink"] = loadfx("vfx/lights/beacon_light_red_blink");
	level._effect["beacon_light_red_static"] = loadfx("vfx/lights/beacon_light_red_static_large");
	level._effect["falling_water_wall_long"] = loadfx("vfx/water/falling_water_wall_long");
	level._effect["water_stream_med"] = loadfx("vfx/rain/water_stream_med");
	level._effect["water_drips_fat_splash"] = loadfx("vfx/rain/water_drips_fat_splash");
	level._effect["water_runoff_narrow_splashes_lp"] = loadfx("vfx/rain/water_runoff_narrow_splashes_lp");
	level._effect["water_edge_runoff_wide"] = loadfx("vfx/water/water_edge_runoff_wide");
	level._effect["falling_water_trickle_wide"] = loadfx("vfx/water/falling_water_trickle_wide_nofoam");
	level._effect["falling_water_exterior_narrow"] = loadfx("vfx/water/falling_water_exterior_narrow");
	level._effect["falling_water_drip_100x100_runner"] = loadfx("vfx/water/falling_water_drip_100x100_runner");
	level._effect["water_edge_runoff_short"] = loadfx("vfx/water/water_edge_runoff_short");
	level._effect["tidal_wave_receding_foam1"] = loadfx("vfx/water/tidal_wave_receding_foam1");
	level._effect["tidal_wave_crest_mist"] = loadfx("vfx/water/tidal_wave_crest_mist");
	level._effect["det_light_spotlight_cone_haze"] = loadfx("vfx/lights/detroit/det_light_spotlight_cone_haze");
	level._effect["tidal_wave_lingering_foam1"] = loadfx("vfx/water/tidal_wave_lingering_foam1");
	level._effect["tidal_wave_hit_01"] = loadfx("vfx/water/tidal_wave_hit_01");
	level._effect["test_effect"] = loadfx("vfx/test/test_fx");
	level._effect["tire_industrial_01_rubber"] = loadfx("vfx/destructible/tire_industrial_01_rubber");
	level._effect["wave_hit_mist_01"] = loadfx("vfx/water/wave_hit_mist_01");
	level._effect["water_wave_splash"] = loadfx("fx/water/water_wave_splash");
	level._effect["water_froth_oilrig"] = loadfx("fx/misc/water_froth_oilrig");
	level._effect["wavebreak_01"] = loadfx("fx/misc/wavebreak_01");
	level._effect["breaking_wave_01"] = loadfx("vfx/water/breaking_wave_01");
	level._effect["breaking_wave_large_01"] = loadfx("vfx/water/breaking_wave_large_01");
	level._effect["light_buoy_red"] = loadfx("vfx/lights/light_buoy_red");
	level._effect["fx_sunflare_laser2"] = loadfx("vfx/lensflare/fx_sunflare_laser2");
	level._effect["laser_core_lvl1"] = loadfx("vfx/map/mp_laser2/laser_core_lvl1");
	level._effect["light_glow_white_square"] = loadfx("vfx/lights/global/light_glow_white_square");
	level._effect["laser_fluorescent_smoke_dim"] = loadfx("vfx/map/mp_laser2/laser_fluorescent_smoke_dim");
	level._effect["leaves_runner"] = loadfx("vfx/wind/leaves_runner");
	level._effect["falling_water_drip_line_runner_fast"] = loadfx("vfx/water/falling_water_drip_line_runner_fast");
	level._effect["falling_water_drip_line_runner_slow"] = loadfx("vfx/water/falling_water_drip_line_runner_slow");
	level._effect["single_drip_runner"] = loadfx("vfx/water/single_drip_runner");
	level._effect["single_drip_runner_frequent"] = loadfx("vfx/water/single_drip_runner_frequent");
	level._effect["bird_seagull_flock_large"] = loadfx("vfx/animal/bird_seagull_flock_large");
	level._effect["electrical_sparks_runner"] = loadfx("vfx/explosion/electrical_sparks_runner");
	level._effect["dust_falling_debris_runner"] = loadfx("vfx/dust/dust_falling_debris_runner");
	level._effect["insects_flies_landing"] = loadfx("vfx/animal/insects_flies_landing");
	level._effect["insects_moths"] = loadfx("vfx/animal/insects_moths");
	level._effect["roach_flock_straight_runner"] = loadfx("vfx/animal/roach_flock_straight_runner");
	level._effect["roach_lrg_pipe_scatter_runner"] = loadfx("vfx/animal/roach_lrg_pipe_scatter_runner");
	level._effect["roach_med_pipe_scatter_runner"] = loadfx("vfx/animal/roach_med_pipe_scatter_runner");
	level._effect["trash_tornado_s_runner"] = loadfx("vfx/wind/trash_tornado_s_runner");
	level._effect["light_skylight_haze"] = loadfx("vfx/lights/light_skylight_haze");
	level._effect["light_skylight_haze_narrow"] = loadfx("vfx/lights/light_skylight_haze_narrow");
	level._effect["laser_generator_glow_blue"] = loadfx("vfx/map/mp_laser2/laser_generator_glow_blue");
	level._effect["laser_long_fluorescent_glow"] = loadfx("vfx/map/mp_laser2/laser_long_fluorescent_glow");
	level._effect["fog_distant_vista_dense"] = loadfx("vfx/fog/fog_distant_vista_dense");
	level._effect["fog_close_onbridge"] = loadfx("vfx/fog/fog_close_onbridge");
	level._effect["fog_distant_aerialview"] = loadfx("vfx/fog/fog_distant_aerialview");
	level._effect["fog_over_hill_slow"] = loadfx("vfx/fog/fog_over_hill_slow");
	level._effect["fog_distant_vista"] = loadfx("vfx/fog/fog_distant_vista");
	level._effect["fog_laser2_hills"] = loadfx("vfx/map/mp_laser2/fog_laser2_hills");
	level._effect["fog_laser2_distant_vista_1"] = loadfx("vfx/map/mp_laser2/fog_laser2_distant_vista_1");
	level.fx_waves = [];
	level.fx_oceanfoam = [];
	thread deactivatedlaserfx();
}

//Function Number: 2
setupwaves(param_00)
{
	var_01 = [(-584.903,-1536.18,163.125),1.5,(-252.849,-2122.8,166.125),0,(-156.219,-1567.68,160.125),2,(172.208,-1528.17,167.125),3,(1054.11,-1649.7,164.125),0,(1602.57,-1416.54,167.125),1,(2043.16,-942.894,167.125),1.6,(2530.3,-567.627,164.125),2.2,(2852.56,-303.176,163.79),4,(-1169.37,-1656.77,161.125),1,(-1622.98,-1736.73,164.125),0,(-2182.48,-480.268,168),1.2,(-2455.47,-131.343,168),0,(-1917.2,-1068.53,159),2,(2980.57,245.072,170.125),0.5,(3434.08,736.992,210.864),3,(4049.32,1242.84,168),4.5,(2270.59,-692.692,170.125),3.5];
	for(var_02 = 0;var_02 < var_01.size;var_02 = var_02 + 2)
	{
		var_03 = spawnstruct();
		var_03.delay = var_01[var_02 + 1];
		var_04 = common_scripts\utility::spawn_tag_origin();
		var_04 show();
		var_04.origin = (var_01[var_02][0],var_01[var_02][1],param_00.origin[2]);
		var_04.angles = (270,0,-90);
		var_04 vehicle_jetbikesethoverforcescale(param_00);
		var_03.ent = var_04;
		level.fx_waves[level.fx_waves.size] = var_03;
	}
}

//Function Number: 3
setupoceanfoam(param_00)
{
	var_01 = [(-589.197,-1605.05,233.502),(270,0,-90),0,(-843.596,-1305.72,258.718),(270,0,-90),1,(37.7022,-1250.75,255.878),(270,0,-90),2,(-605.969,-878.506,254.76),(270,0,-90),3,(-225.131,-725.816,254.456),(270,0,-90),4,(503.141,-654.117,273.566),(270,0,-90),5,(1366.39,-1202.34,266.587),(270,0,-77),6,(2322.31,-81.669,215.623),(270,0,-77),7,(3591.37,752.588,255),(270,0,-58),8];
	for(var_02 = 0;var_02 < var_01.size;var_02 = var_02 + 3)
	{
		var_03 = spawnstruct();
		var_03.num = var_01[var_02 + 2];
		var_04 = common_scripts\utility::spawn_tag_origin();
		var_04 show();
		var_04.origin = (var_01[var_02][0],var_01[var_02][1],param_00.origin[2]);
		var_04.angles = var_01[var_02 + 1];
		var_04 vehicle_jetbikesethoverforcescale(param_00);
		var_03.ent = var_04;
		level.fx_oceanfoam[level.fx_oceanfoam.size] = var_03;
	}
}

//Function Number: 4
playwaves(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	if(isdefined(param_00))
	{
		level notify(param_00);
		level endon(param_00);
	}

	if(!isdefined(param_01))
	{
		param_01 = 3;
	}

	if(!isdefined(param_02))
	{
		param_02 = 5;
	}

	for(;;)
	{
		foreach(var_05 in level.fx_waves)
		{
			var_05.fxid = param_03;
			thread playfxent(var_05);
		}

		wait(randomfloatrange(param_01,param_02));
	}
}

//Function Number: 5
playfxent(param_00)
{
	wait(param_00.delay);
	playfxontag(common_scripts\utility::getfx(param_00.fxid),param_00.ent,"tag_origin");
}

//Function Number: 6
playoceanfoam(param_00,param_01)
{
	foreach(var_03 in level.fx_oceanfoam)
	{
		if(var_03.num == param_01)
		{
			playfxontag(common_scripts\utility::getfx(param_00),var_03.ent,"tag_origin");
		}
	}
}

//Function Number: 7
start_wave_mist_fx()
{
	playfxontag(common_scripts\utility::getfx("tidal_wave_crest_mist"),self,"tag_fx_5");
	wait(0.2);
	playfxontag(common_scripts\utility::getfx("tidal_wave_crest_mist"),self,"tag_fx_4");
	wait(0.2);
	playfxontag(common_scripts\utility::getfx("tidal_wave_crest_mist"),self,"tag_fx_3");
	wait(0.2);
	playfxontag(common_scripts\utility::getfx("tidal_wave_crest_mist"),self,"tag_fx_2");
	wait(0.2);
	playfxontag(common_scripts\utility::getfx("tidal_wave_crest_mist"),self,"tag_fx_1");
}

//Function Number: 8
stop_wave_mist_fx()
{
	stopfxontag(common_scripts\utility::getfx("tidal_wave_crest_mist"),self,"tag_fx_1");
	wait(0.2);
	stopfxontag(common_scripts\utility::getfx("tidal_wave_crest_mist"),self,"tag_fx_2");
	wait(0.2);
	stopfxontag(common_scripts\utility::getfx("tidal_wave_crest_mist"),self,"tag_fx_3");
	wait(0.2);
	stopfxontag(common_scripts\utility::getfx("tidal_wave_crest_mist"),self,"tag_fx_4");
	wait(0.2);
	stopfxontag(common_scripts\utility::getfx("tidal_wave_crest_mist"),self,"tag_fx_5");
}

//Function Number: 9
deactivatedlaserfx()
{
	activatepersistentclientexploder(200);
}