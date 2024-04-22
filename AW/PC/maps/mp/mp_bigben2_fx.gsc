/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\mp_bigben2_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 370 ms
 * Timestamp: 4/22/2024 2:17:01 AM
*******************************************************************/

//Function Number: 1
main()
{
	level._effect["mp_bigb_water_stream_med"] = loadfx("vfx/map/mp_bigben/mp_bigb_water_stream_med");
	level._effect["mp_bigb_falling_water_splash_runner"] = loadfx("vfx/map/mp_bigben/mp_bigb_falling_water_splash_runner");
	level._effect["dirty_foam_flowing"] = loadfx("vfx/map/mp_bigben/dirty_foam_flowing");
	level._effect["mp_bigb_window_glow_03"] = loadfx("vfx/map/mp_bigben/mp_bigb_window_glow_03");
	level._effect["mp_bigb_window_glow_02"] = loadfx("vfx/map/mp_bigben/mp_bigb_window_glow_02");
	level._effect["mp_bigb_rain_splash_200x200_no_distort"] = loadfx("vfx/map/mp_bigben/mp_bigb_rain_splash_200x200_no_distort");
	level._effect["mp_bigb_window_glow"] = loadfx("vfx/map/mp_bigben/mp_bigb_window_glow");
	level._effect["rain_splash_sm_runner_no_ripple"] = loadfx("vfx/rain/rain_splash_sm_runner_no_ripple");
	level._effect["mp_bigb_fire_vista_glow"] = loadfx("vfx/map/mp_bigben/mp_bigb_fire_vista_glow");
	level._effect["mp_bigb_killstreak_curvy_missile"] = loadfx("vfx/map/mp_bigben/mp_bigb_killstreak_curvy_missile");
	level._effect["mp_bigb_rain_splash_line"] = loadfx("vfx/map/mp_bigben/mp_bigb_rain_splash_line");
	level._effect["mp_bigb_firelight"] = loadfx("vfx/map/mp_bigben/mp_bigb_firelight");
	level._effect["mp_bigb_river_fire"] = loadfx("vfx/fire/mp_bigb_river_fire");
	level._effect["mp_bigb_light_mist"] = loadfx("vfx/map/mp_bigben/mp_bigb_light_mist");
	level._effect["electrical_sparks_small_runner"] = loadfx("vfx/explosion/electrical_sparks_small_runner");
	level._effect["jet_flyover"] = loadfx("vfx/unique/jet_flyover");
	level._effect["dust_falling_int_runner"] = loadfx("vfx/dust/dust_falling_int_runner");
	level._effect["mp_bigb_bridge_smoke"] = loadfx("vfx/map/mp_bigben/mp_bigb_bridge_smoke");
	level._effect["bigb_light_vent_steam"] = loadfx("vfx/map/mp_bigben/bigb_light_vent_steam");
	level._effect["mp_bigb_ambient_int_dust"] = loadfx("vfx/map/mp_bigben/mp_bigb_ambient_int_dust");
	level._effect["battlefield_smoke_m_dark"] = loadfx("vfx/smoke/dlc/battlefield_smoke_m_dark");
	level._effect["mp_bigb_deck_wind_runner"] = loadfx("vfx/map/mp_bigben/mp_bigb_deck_wind_runner");
	level._effect["bigb_aa_flash_tracer"] = loadfx("vfx/map/mp_bigben/bigb_aa_flash_tracer");
	level._effect["mp_bigb_searchlights"] = loadfx("vfx/map/mp_bigben/mp_bigb_searchlights");
	level._effect["mp_bigb_building_hit"] = loadfx("vfx/map/mp_bigben/mp_bigb_building_hit");
	level._effect["mp_bigb_boat_explosion"] = loadfx("vfx/map/mp_bigben/mp_bigb_boat_explosion");
	level._effect["mp_bigb_atm_paper_runner"] = loadfx("vfx/map/mp_bigben/mp_bigb_atm_paper_runner");
	level._effect["mp_bigb_water_edge_splash_sml_runner"] = loadfx("vfx/map/mp_bigben/mp_bigb_water_edge_splash_sml_runner");
	level._effect["mp_trash_blowing_runner"] = loadfx("vfx/map/mp_lost/mp_trash_blowing_runner");
	level._effect["mp_bigb_concrete_debris_water_runner"] = loadfx("vfx/map/mp_bigben/mp_bigb_concrete_debris_water_runner");
	level._effect["mp_bigb_building_smoke_debris_runner"] = loadfx("vfx/map/mp_bigben/mp_bigb_building_smoke_debris_runner");
	level._effect["mp_bigb_water_explosion_runner"] = loadfx("vfx/map/mp_bigben/mp_bigb_water_explosion_runner");
	level._effect["steam_pipe_burst_lp_xsml"] = loadfx("vfx/steam/dlc/steam_pipe_burst_lp_xsml");
	level._effect["mp_bigb_falling_leaves_runner"] = loadfx("vfx/map/mp_bigben/mp_bigb_falling_leaves_runner");
	level._effect["mp_bigb_bus_headlight_flicker"] = loadfx("vfx/map/mp_bigben/mp_bigb_bus_headlight_flicker");
	level._effect["mp_bigb_bus_headlight"] = loadfx("vfx/map/mp_bigben/mp_bigb_bus_headlight");
	level._effect["mp_bigb_vista_smk_stack"] = loadfx("vfx/map/mp_bigben/mp_bigb_vista_smk_stack");
	level._effect["mp_bigb_water_mist_deck_lrg_runner"] = loadfx("vfx/map/mp_bigben/mp_bigb_water_mist_deck_lrg_runner");
	level._effect["falling_water_drip_runner_slow"] = loadfx("vfx/water/falling_water_drip_runner_slow");
	level._effect["smoke_pillar_white_01"] = loadfx("vfx/smoke/smoke_pillar_white_01");
	level._effect["water_stream_med"] = loadfx("vfx/rain/water_stream_med");
	level._effect["mp_bigb_falling_water_exterior_short"] = loadfx("vfx/map/mp_bigben/mp_bigb_falling_water_exterior_short");
	level._effect["mp_bigb_water_edge_runoff_sml"] = loadfx("vfx/map/mp_bigben/mp_bigb_water_edge_runoff_sml");
	level._effect["mp_bigb_water_edge_runoff"] = loadfx("vfx/map/mp_bigben/mp_bigb_water_edge_runoff");
	level._effect["mp_bigb_falling_water_exterior"] = loadfx("vfx/map/mp_bigben/mp_bigb_falling_water_exterior");
	level._effect["mp_bigb_rain_splash_sm_50x50_lp"] = loadfx("vfx/map/mp_bigben/mp_bigb_rain_splash_sm_50x50_lp");
	level._effect["rain_splat_on_lens_sml_rnr_night"] = loadfx("vfx/rain/rain_splat_on_lens_sml_rnr_night");
	level._effect["mp_bigb_water_explosion"] = loadfx("vfx/map/mp_bigben/mp_bigb_water_explosion");
	level._effect["mp_bigb_rain_volume_far"] = loadfx("vfx/map/mp_bigben/mp_bigb_rain_volume_far");
	level._effect["mp_bigb_fire_l_blacksmk_nonlit"] = loadfx("vfx/map/mp_bigben/mp_bigb_fire_l_blacksmk_nonlit");
	level._effect["mp_bigb_fire_lp_clocktower_smoke"] = loadfx("vfx/map/mp_bigben/mp_bigb_fire_lp_clocktower_smoke");
	level._effect["smoke_pillar_black_medium_slow"] = loadfx("vfx/smoke/smoke_pillar_black_medium_slow");
	level._effect["mp_bigb_building_explosion_runner"] = loadfx("vfx/map/mp_bigben/mp_bigb_building_explosion_runner");
	level._effect["fire_tiny_area"] = loadfx("vfx/map/mp_blackbox/fire_tiny_area");
	level._effect["fire_falling_runner_point_infrequent"] = loadfx("vfx/fire/fire_falling_runner_point_infrequent");
	level._effect["fire_vista_lp_lrg_blacksmk_thick"] = loadfx("vfx/fire/fire_vista_lp_lrg_blacksmk_thick");
	level._effect["electrical_sparks_runner_slit"] = loadfx("vfx/explosion/electrical_sparks_runner_slit");
	level._effect["fire_lp_m_no_light"] = loadfx("vfx/fire/fire_lp_m_no_light");
	level._effect["fire_lp_s_no_light"] = loadfx("vfx/fire/fire_lp_s_no_light");
	level._effect["mp_bigb_rain_splash_sm_200x200_lp"] = loadfx("vfx/map/mp_bigben/mp_bigb_rain_splash_sm_200x200_lp");
	level._effect["mp_bigb_rain_splash_sm_100x100_lp"] = loadfx("vfx/map/mp_bigben/mp_bigb_rain_splash_sm_100x100_lp");
	level._effect["mp_bigb_rain_volume_close"] = loadfx("vfx/map/mp_bigben/mp_bigb_rain_volume_close");
	level._effect["mp_bigb_water_displacement_patch"] = loadfx("vfx/map/mp_bigben/mp_bigb_water_displacement_patch");
	level._effect["smoketrail_rpg"] = loadfx("vfx/trail/smoketrail_rpg");
	level._effect["smoketrail_missile_thick"] = loadfx("vfx/trail/smoketrail_missile_thick");
	level._effect["mp_bigb_killstreak_rocket_explosion"] = loadfx("vfx/map/mp_bigben/mp_bigb_killstreak_rocket_explosion");
	level._effect["mp_bigb_killstreak_ventsmoke"] = loadfx("vfx/map/mp_bigben/mp_bigb_killstreak_ventsmoke");
	level._effect["mp_bigb_killstreak_rockettrail"] = loadfx("vfx/map/mp_bigben/mp_bigb_killstreak_rockettrail");
	level thread onplayerconnect();
	level thread start_temporary_fx();
	level thread manage_close_explosions();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		level thread start_persistent_fx(var_00);
	}
}

//Function Number: 3
start_persistent_fx(param_00)
{
	if(!isdefined(level.skylight_vista_fx_off) && level.skylight_vista_fx_off)
	{
		level thread rain_splashes(param_00);
		level thread vista_smoke(param_00);
		level thread water_explosions_far(param_00);
		level thread bridge_rubble(param_00);
	}

	if(isdefined(level.bridgeexploded) && level.bridgeexploded)
	{
		level thread bridge_explosion(param_00);
	}
}

//Function Number: 4
start_temporary_fx()
{
	level thread boat_explosion_bow();
	level thread boat_explosion_stern();
	level thread car_explosion_bridge();
	level thread car_explosion();
	level thread bus_explosion();
	level thread rock_explosion_bridge();
	wait(300);
	level.bridgeexploded = 1;
	level thread bridge_explosion();
}

//Function Number: 5
manage_close_explosions()
{
	while(!isdefined(level.players))
	{
		wait(1);
	}

	for(;;)
	{
		var_00 = randomintrange(8,12);
		wait(var_00);
		while(isdefined(level.skylight_available) && !level.skylight_available)
		{
			wait(40);
		}

		level thread water_explosions_bow();
		var_00 = randomintrange(8,12);
		wait(var_00);
		while(isdefined(level.skylight_available) && !level.skylight_available)
		{
			wait(40);
		}

		level thread water_explosions_stern();
	}
}

//Function Number: 6
water_explosions_bow()
{
	level thread common_scripts\_exploder::activate_clientside_exploder(4);
	wait(1);
	level thread water_explosion_earthquake_bow();
	wait(5);
	stopclientexploder(4);
}

//Function Number: 7
water_explosion_earthquake_bow()
{
	var_00 = 1000;
	var_01 = (5345.45,1850.61,145);
	earthquake(0.9,1,var_01,var_00);
	foreach(var_03 in level.players)
	{
		if(!isdefined(var_03.team) && var_03.team == "spectator")
		{
			if(distancesquared(var_03.origin,var_01) < var_00 * var_00)
			{
				var_03 playrumbleonentity("heavygun_fire");
			}
		}
	}
}

//Function Number: 8
water_explosions_stern()
{
	level thread common_scripts\_exploder::activate_clientside_exploder(3);
	wait(1);
	level thread water_explosion_earthquake_stern();
	wait(5);
	stopclientexploder(3);
}

//Function Number: 9
water_explosion_earthquake_stern()
{
	var_00 = 1000;
	var_01 = (2889.97,2035.69,147);
	earthquake(0.9,1,var_01,var_00);
	foreach(var_03 in level.players)
	{
		if(!isdefined(var_03.team) && var_03.team == "spectator")
		{
			if(distancesquared(var_03.origin,var_01) < var_00 * var_00)
			{
				var_03 playrumbleonentity("heavygun_fire");
			}
		}
	}
}

//Function Number: 10
water_explosions_far(param_00)
{
	level thread common_scripts\_exploder::activate_clientside_exploder(5,param_00);
}

//Function Number: 11
boat_explosion_bow()
{
	var_00 = randomintrange(30,550);
	wait(var_00);
	start_fx_exploder();
	level thread common_scripts\_exploder::activate_clientside_exploder(10);
	finish_fx_exploder();
}

//Function Number: 12
boat_explosion_stern()
{
	var_00 = randomintrange(30,550);
	wait(var_00);
	start_fx_exploder();
	level thread common_scripts\_exploder::activate_clientside_exploder(11);
	finish_fx_exploder();
}

//Function Number: 13
car_explosion()
{
	var_00 = randomintrange(30,550);
	wait(var_00);
	start_fx_exploder();
	level thread common_scripts\_exploder::activate_clientside_exploder(21);
	finish_fx_exploder();
}

//Function Number: 14
bus_explosion()
{
	var_00 = randomintrange(30,550);
	wait(var_00);
	start_fx_exploder();
	level thread common_scripts\_exploder::activate_clientside_exploder(22);
	finish_fx_exploder();
}

//Function Number: 15
bridge_explosion(param_00)
{
	level thread common_scripts\_exploder::activate_clientside_exploder(23,param_00);
	var_01 = getscriptablearray("fiyah","targetname");
	foreach(var_03 in var_01)
	{
		var_03 setscriptablepartstate(0,1);
	}
}

//Function Number: 16
car_explosion_bridge()
{
	var_00 = randomintrange(30,550);
	wait(var_00);
	start_fx_exploder();
	level thread common_scripts\_exploder::activate_clientside_exploder(24);
	finish_fx_exploder();
}

//Function Number: 17
rock_explosion_bridge()
{
	var_00 = randomintrange(30,550);
	wait(var_00);
	start_fx_exploder();
	level thread common_scripts\_exploder::activate_clientside_exploder(25);
	finish_fx_exploder();
}

//Function Number: 18
bridge_rubble(param_00)
{
	level thread common_scripts\_exploder::activate_clientside_exploder(31,param_00);
}

//Function Number: 19
vista_smoke(param_00)
{
	level thread common_scripts\_exploder::activate_clientside_exploder(32,param_00);
}

//Function Number: 20
rain_splashes(param_00)
{
	level thread common_scripts\_exploder::activate_clientside_exploder(33,param_00);
}

//Function Number: 21
stop_vista_vfx()
{
	level endon("skylight_start");
	level.skylight_vista_fx_off = 1;
	wait(0.1);
	level thread killstreak_exhaust_smoke();
	wait(0.1);
	stopclientexploder(5);
	stopclientexploder(31);
	wait(0.1);
	stopclientexploder(32);
	stopclientexploder(33);
	wait(40);
	waittillframeend;
	foreach(var_01 in level.players)
	{
		level thread restart_vista_fx(var_01);
	}

	level.skylight_vista_fx_off = 0;
}

//Function Number: 22
restart_vista_fx(param_00)
{
	level thread rain_splashes(param_00);
	wait(0.1);
	level thread vista_smoke(param_00);
	wait(0.1);
	level thread water_explosions_far(param_00);
	wait(0.1);
	level thread bridge_rubble(param_00);
}

//Function Number: 23
killstreak_exhaust_smoke()
{
	level thread common_scripts\_exploder::activate_clientside_exploder(30);
	wait(2);
	stopclientexploder(30);
}

//Function Number: 24
start_fx_exploder()
{
	while(isdefined(level.exploderexploding) && level.exploderexploding)
	{
		wait(7);
	}

	level.exploderexploding = 1;
}

//Function Number: 25
finish_fx_exploder()
{
	wait(5);
	level.exploderexploding = 0;
}