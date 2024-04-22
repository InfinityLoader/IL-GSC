/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: captured_fx.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 71
 * Decompile Time: 1075 ms
 * Timestamp: 4/22/2024 2:26:17 AM
*******************************************************************/

//Function Number: 1
main()
{
	level._effect["cap_heli_fire_dlight"] = loadfx("vfx/map/captured/cap_heli_fire_dlight");
	maps\createfx\captured_fx::main();
	maps\createfx\captured_sound::main();
	level._effect["cap_body_fire_lp_cheap_02"] = loadfx("vfx/map/captured/cap_body_fire_lp_cheap_02");
	level._effect["cap_emergency_light_orange_03"] = loadfx("vfx/map/captured/cap_emergency_light_orange_03");
	level._effect["cap_crash_dust_lite_sml"] = loadfx("vfx/map/captured/cap_crash_dust_lite_sml");
	level._effect["cap_mech_damage_wv"] = loadfx("vfx/map/captured/cap_mech_damage_wv");
	level._effect["cap_mech_soft_land_dust"] = loadfx("vfx/map/captured/cap_mech_soft_land_dust");
	level._effect["cap_door_kick"] = loadfx("vfx/map/captured/cap_door_kick");
	level._effect["cap_body_dust_child2"] = loadfx("vfx/map/captured/cap_body_dust_child2");
	level._effect["cap_mech_exit_steam"] = loadfx("vfx/map/captured/cap_mech_exit_steam");
	level._effect["cap_crash_dust_lite_02"] = loadfx("vfx/map/captured/cap_crash_dust_lite_02");
	level._effect["cap_burn_mark"] = loadfx("vfx/map/captured/cap_burn_mark");
	level._effect["cap_gate_sparks_smk"] = loadfx("vfx/map/captured/cap_gate_sparks_smk");
	level._effect["cap_exo_arm_burst"] = loadfx("vfx/map/captured/cap_exo_arm_burst");
	level._effect["cap_end_rocket_impact_chunks"] = loadfx("vfx/map/captured/cap_end_rocket_impact_chunks");
	level._effect["cap_end_rocket_impact_linger"] = loadfx("vfx/map/captured/cap_end_rocket_impact_linger");
	level._effect["cap_end_rocket_impact"] = loadfx("vfx/map/captured/cap_end_rocket_impact");
	level._effect["cap_warehouse_whitelight"] = loadfx("vfx/map/captured/cap_warehouse_whitelight");
	level._effect["cap_ambient_dust_lrg"] = loadfx("vfx/map/captured/cap_ambient_dust_lrg");
	level._effect["cap_crane_light"] = loadfx("vfx/map/captured/cap_crane_light");
	level._effect["blood_pool_static_40"] = loadfx("vfx/blood/blood_pool_static_40");
	level._effect["smk_stacks_lp_lrg_a"] = loadfx("vfx/smoke/smk_stacks_lp_lrg_a");
	level._effect["cap_godray_outdoor_xtralrg"] = loadfx("vfx/map/captured/cap_godray_outdoor_xtralrg");
	level._effect["cap_godray_warehouse_lrg"] = loadfx("vfx/map/captured/cap_godray_warehouse_lrg");
	level._effect["ash_cloud_freq_lrg_loop_dark"] = loadfx("vfx/ash/ash_cloud_freq_lrg_loop_dark");
	level._effect["ash_cloud_freq_lrg_loop_indoor"] = loadfx("vfx/ash/ash_cloud_freq_lrg_loop_indoor");
	level._effect["ash_ember_cloud_freq_sml_loop"] = loadfx("vfx/ash/ash_ember_cloud_freq_sml_loop");
	level._effect["battlefield_smoke_l"] = loadfx("vfx/smoke/battlefield_smoke_l");
	level._effect["battlefield_smoke_m"] = loadfx("vfx/smoke/battlefield_smoke_m");
	level._effect["beacon_light_red_blink"] = loadfx("vfx/lights/beacon_light_red_blink");
	level._effect["beacon_light_red_static"] = loadfx("vfx/lights/beacon_light_red_static");
	level._effect["bird_vulture_circle_runner"] = loadfx("vfx/animal/bird_vulture_circle_runner");
	level._effect["cap_aa_explosion"] = loadfx("vfx/map/captured/cap_aa_explosion");
	level._effect["cap_ash_cloud_indoor"] = loadfx("vfx/map/captured/cap_ash_cloud_indoor");
	level._effect["cap_ash_door_exhaust"] = loadfx("vfx/map/captured/cap_ash_door_exhaust");
	level._effect["cap_ash_fan_exhaust"] = loadfx("vfx/map/captured/cap_ash_fan_exhaust");
	level._effect["cap_ash_inc_crawl_ground"] = loadfx("vfx/map/captured/cap_ash_inc_crawl_ground");
	level._effect["cap_ash_inc_exhaust"] = loadfx("vfx/map/captured/cap_ash_inc_exhaust");
	level._effect["cap_ash_pit_door_exhaust"] = loadfx("vfx/map/captured/cap_ash_pit_door_exhaust");
	level._effect["cap_ash_pit_fan_exhaust"] = loadfx("vfx/map/captured/cap_ash_pit_fan_exhaust");
	level._effect["cap_ash_pit_fill"] = loadfx("vfx/map/captured/cap_ash_pit_fill");
	level._effect["cap_ash_smoke_ambient"] = loadfx("vfx/map/captured/cap_ash_smoke_ambient");
	level._effect["cap_auto_hatch_ash_1"] = loadfx("vfx/map/captured/cap_auto_hatch_ash_1");
	level._effect["cap_body_dust_rocks"] = loadfx("vfx/map/captured/cap_body_dust_rocks");
	level._effect["cap_body_dust_rocks2"] = loadfx("vfx/map/captured/cap_body_dust_rocks2");
	level._effect["cap_body_dust_emit"] = loadfx("vfx/map/captured/cap_body_dust_emit");
	level._effect["cap_body_dust_mech"] = loadfx("vfx/map/captured/cap_body_dust_mech");
	level._effect["cap_body_fire_low_lp"] = loadfx("vfx/map/captured/cap_body_fire_low_lp");
	level._effect["cap_body_fire_lp"] = loadfx("vfx/map/captured/cap_body_fire_lp");
	level._effect["cap_body_fire_lp_cheap"] = loadfx("vfx/map/captured/cap_body_fire_lp_cheap");
	level._effect["cap_body_smoke_ambient"] = loadfx("vfx/map/captured/cap_body_smoke_ambient");
	level._effect["cap_crash_debris_dust"] = loadfx("vfx/map/captured/cap_crash_debris_dust");
	level._effect["cap_crash_damaged_sparks"] = loadfx("vfx/map/captured/cap_crash_damaged_sparks");
	level._effect["cap_crash_dust_01"] = loadfx("vfx/map/captured/cap_crash_dust_01");
	level._effect["cap_crash_dust_02"] = loadfx("vfx/map/captured/cap_crash_dust_02");
	level._effect["cap_crash_dust_lite"] = loadfx("vfx/map/captured/cap_crash_dust_lite");
	level._effect["cap_crash_hero_dust_falling"] = loadfx("vfx/map/captured/cap_crash_hero_dust_falling");
	level._effect["cap_crash_hero_dust_mech"] = loadfx("vfx/map/captured/cap_crash_hero_dust_mech");
	level._effect["cap_emergency_light_orange_01"] = loadfx("vfx/map/captured/cap_emergency_light_orange_01");
	level._effect["cap_emergency_light_orange_01_fast"] = loadfx("vfx/map/captured/cap_emergency_light_orange_01_fast");
	level._effect["cap_fire_barrel"] = loadfx("vfx/map/captured/cap_fire_barrel");
	level._effect["cap_flare_orange_lp_dir"] = loadfx("vfx/map/captured/cap_flare_orange_lp_dir");
	level._effect["cap_foot_stomp_blood"] = loadfx("vfx/map/captured/cap_foot_stomp_blood");
	level._effect["cap_foot_stomp_blood_decal"] = loadfx("vfx/map/captured/cap_foot_stomp_blood_decal");
	level._effect["cap_footstep_dust"] = loadfx("vfx/map/captured/cap_footstep_dust");
	level._effect["cap_footstep_dust_mech"] = loadfx("vfx/map/captured/cap_footstep_dust_mech");
	level._effect["cap_footstep_dust_rocks"] = loadfx("vfx/map/captured/cap_footstep_dust_rocks");
	level._effect["cap_footstep_water_small"] = loadfx("vfx/map/captured/cap_footstep_water_small");
	level._effect["cap_godray_ambient_grates_dusty"] = loadfx("vfx/map/captured/cap_godray_ambient_grates_dusty");
	level._effect["cap_godray_autopsy_light"] = loadfx("vfx/map/captured/cap_godray_autopsy_light");
	level._effect["cap_godray_inc_door"] = loadfx("vfx/map/captured/cap_godray_inc_door");
	level._effect["cap_godray_inc_fan"] = loadfx("vfx/map/captured/cap_godray_inc_fan");
	level._effect["cap_godray_inc_soft"] = loadfx("vfx/map/captured/cap_godray_inc_soft");
	level._effect["cap_godray_int_sm"] = loadfx("vfx/map/captured/cap_godray_int_sm");
	level._effect["cap_godray_rect_light"] = loadfx("vfx/map/captured/cap_godray_rect_light");
	level._effect["cap_halon_gas_fill"] = loadfx("vfx/map/captured/cap_halon_gas_fill");
	level._effect["cap_halon_gas_ground"] = loadfx("vfx/map/captured/cap_halon_gas_ground");
	level._effect["cap_halon_gas_ground_fill"] = loadfx("vfx/map/captured/cap_halon_gas_ground_fill");
	level._effect["cap_halon_gas_spray"] = loadfx("vfx/map/captured/cap_halon_gas_spray");
	level._effect["cap_halon_gas_spray_nofb"] = loadfx("vfx/map/captured/cap_halon_gas_spray_nofb");
	level._effect["cap_head_slam_blood"] = loadfx("vfx/map/captured/cap_head_slam_blood");
	level._effect["cap_head_slam_dust"] = loadfx("vfx/map/captured/cap_head_slam_dust");
	level._effect["cap_heli_aa_explosion_runner"] = loadfx("vfx/map/captured/cap_heli_aa_explosion_runner");
	level._effect["cap_heli_damage_1"] = loadfx("vfx/map/captured/cap_heli_damage_1");
	level._effect["cap_heli_damaged_sparks"] = loadfx("vfx/map/captured/cap_heli_damaged_sparks");
	level._effect["cap_heli_damaged_sparks_3"] = loadfx("vfx/map/captured/cap_heli_damaged_sparks_3");
	level._effect["cap_heli_dust_settle_3s_lp"] = loadfx("vfx/map/captured/cap_heli_dust_settle_3s_lp");
	level._effect["cap_heli_fireball_lp"] = loadfx("vfx/map/captured/cap_heli_fireball_lp");
	level._effect["cap_heli_fireball_lp_smk"] = loadfx("vfx/map/captured/cap_heli_fireball_lp_smk");
	level._effect["cap_heli_fireball_lp_smk_low_distort"] = loadfx("vfx/map/captured/cap_heli_fireball_lp_smk_low_distort");
	level._effect["cap_heli_gideon_blood"] = loadfx("vfx/map/captured/cap_heli_gideon_blood");
	level._effect["cap_heli_gideon_sparks"] = loadfx("vfx/map/captured/cap_heli_gideon_sparks");
	level._effect["cap_heli_glass_shatter_01"] = loadfx("vfx/map/captured/cap_heli_glass_shatter_01");
	level._effect["cap_heli_light_red_01"] = loadfx("vfx/map/captured/cap_heli_light_red_01");
	level._effect["cap_heli_smk"] = loadfx("vfx/map/captured/cap_heli_smk");
	level._effect["cap_inc_cart_fire"] = loadfx("vfx/map/captured/cap_inc_cart_fire");
	level._effect["cap_inc_cart_fire_sm"] = loadfx("vfx/map/captured/cap_inc_cart_fire_sm");
	level._effect["cap_inc_cart_fire_sm_2s"] = loadfx("vfx/map/captured/cap_inc_cart_fire_sm_2s");
	level._effect["cap_inc_crawl_heat"] = loadfx("vfx/map/captured/cap_inc_crawl_heat");
	level._effect["cap_inc_gas_explode"] = loadfx("vfx/map/captured/cap_inc_gas_explode");
	level._effect["cap_inc_gas_explode_ceiling_fire"] = loadfx("vfx/map/captured/cap_inc_gas_explode_ceiling_fire");
	level._effect["cap_inc_gas_explode_late_light"] = loadfx("vfx/map/captured/cap_inc_gas_explode_late_light");
	level._effect["cap_inc_gas_leak"] = loadfx("vfx/map/captured/cap_inc_gas_leak");
	level._effect["cap_inc_oven_ash"] = loadfx("vfx/map/captured/cap_inc_oven_ash");
	level._effect["cap_inc_oven_ash_fire"] = loadfx("vfx/map/captured/cap_inc_oven_ash_fire");
	level._effect["cap_inc_oven_ash_fire_large_still"] = loadfx("vfx/map/captured/cap_inc_oven_ash_fire_large_still");
	level._effect["cap_inc_side_fire_runner"] = loadfx("vfx/map/captured/cap_inc_side_fire_runner");
	level._effect["cap_inc_side_fire_splash"] = loadfx("vfx/map/captured/cap_inc_side_fire_splash");
	level._effect["cap_insects_mosquitoes_small"] = loadfx("vfx/map/captured/cap_insects_mosquitoes_small");
	level._effect["cap_int_blood_splat"] = loadfx("vfx/map/captured/cap_int_blood_splat");
	level._effect["cap_int_glass_crack"] = loadfx("vfx/map/captured/cap_int_glass_crack");
	level._effect["cap_int_glass_shatter"] = loadfx("vfx/map/captured/cap_int_glass_shatter");
	level._effect["cap_intro_truck_dust_01"] = loadfx("vfx/map/captured/cap_intro_truck_dust_01");
	level._effect["cap_intro_truck_dust_02"] = loadfx("vfx/map/captured/cap_intro_truck_dust_02");
	level._effect["cap_mech_cockpit_damage"] = loadfx("vfx/map/captured/cap_mech_cockpit_damage");
	level._effect["cap_mech_intro_land_dust_debris"] = loadfx("vfx/dust/cap_mech_intro_land_dust_debris");
	level._effect["cap_paper_ground_linger"] = loadfx("vfx/map/captured/cap_paper_ground_linger");
	level._effect["cap_particulates_100"] = loadfx("vfx/map/captured/cap_particulates_100");
	level._effect["cap_particulates_100_less"] = loadfx("vfx/map/captured/cap_particulates_100_less");
	level._effect["cap_poison_gas"] = loadfx("vfx/map/captured/cap_poison_gas");
	level._effect["cap_poison_gas_lite"] = loadfx("vfx/map/captured/cap_poison_gas_lite");
	level._effect["cap_smoke_barrel"] = loadfx("vfx/map/captured/cap_smoke_barrel");
	level._effect["cap_sunflare"] = loadfx("vfx/map/captured/cap_sunflare");
	level._effect["cap_steam_ambient_ring_low"] = loadfx("vfx/map/captured/cap_steam_ambient_ring_low");
	level._effect["cap_steam_ambient_ring_low_2"] = loadfx("vfx/map/captured/cap_steam_ambient_ring_low_2");
	level._effect["cap_steam_ambient_tunnel_low"] = loadfx("vfx/map/captured/cap_steam_ambient_tunnel_low");
	level._effect["cap_steam_ambient_tunnel_low_2"] = loadfx("vfx/map/captured/cap_steam_ambient_tunnel_low_2");
	level._effect["cap_uv_flash_panel_buildup_runner"] = loadfx("vfx/map/captured/cap_uv_flash_panel_buildup_runner");
	level._effect["cap_uv_flash_panel_noray_runner"] = loadfx("vfx/map/captured/cap_uv_flash_panel_noray_runner");
	level._effect["cap_uv_flash_panel_runner"] = loadfx("vfx/map/captured/cap_uv_flash_panel_runner");
	level._effect["cap_uv_flash"] = loadfx("vfx/map/captured/cap_uv_flash");
	level._effect["cap_uv_flash_buildup"] = loadfx("vfx/map/captured/cap_uv_flash_buildup");
	level._effect["cap_uv_light_green"] = loadfx("vfx/map/captured/cap_uv_light_green");
	level._effect["cap_uv_light_orange"] = loadfx("vfx/map/captured/cap_uv_light_orange");
	level._effect["cap_water_drip_runner_hose"] = loadfx("vfx/map/captured/cap_water_drip_runner_hose");
	level._effect["cap_water_leak_hose"] = loadfx("vfx/map/captured/cap_water_leak_hose");
	level._effect["cap_water_leak_hose_splash_runner"] = loadfx("vfx/map/captured/cap_water_leak_hose_splash_runner");
	level._effect["dust_blowing_ground_slow_lp_300"] = loadfx("vfx/dust/dust_blowing_ground_slow_lp_300");
	level._effect["dust_falling_debris_runner"] = loadfx("vfx/map/captured/cap_dust_falling_debris_runner");
	level._effect["electrical_sparks_xs_runner"] = loadfx("vfx/explosion/electrical_sparks_xs_runner");
	level._effect["fire_fast_lp_sml_vf"] = loadfx("vfx/fire/fire_fast_lp_sml_vf");
	level._effect["fire_lp_m_blacksmk"] = loadfx("vfx/fire/fire_lp_m_blacksmk");
	level._effect["fire_lp_m_nosmk"] = loadfx("vfx/fire/fire_lp_m_nosmk");
	level._effect["fire_lp_s_nosmk"] = loadfx("vfx/fire/fire_lp_s_nosmk");
	level._effect["fire_lp_smk_s"] = loadfx("vfx/fire/fire_lp_smk_s");
	level._effect["fire_lp_xs_blacksmk"] = loadfx("vfx/fire/fire_lp_xs_blacksmk");
	level._effect["fire_lp_xs_nosmk"] = loadfx("vfx/fire/fire_lp_xs_nosmk");
	level._effect["fire_lp_xxs"] = loadfx("vfx/fire/fire_lp_xxs");
	level._effect["heat_distortion_mirage_med"] = loadfx("vfx/distortion/heat_distortion_mirage_med");
	level._effect["heli_dust_settle_3s"] = loadfx("vfx/dust/heli_dust_settle_3s");
	level._effect["ind_camera_lens_glow"] = loadfx("vfx/unique/ind_camera_lens_glow");
	level._effect["ind_camera_lens_glow_02"] = loadfx("vfx/unique/ind_camera_lens_glow_02");
	level._effect["low_dust_ambient_lp"] = loadfx("vfx/dust/low_dust_ambient_lp");
	level._effect["pilot_flame_45_runner"] = loadfx("vfx/fire/pilot_flame_45_runner");
	level._effect["fireball_explosion_cluster_parent_02"] = loadfx("vfx/explosion/fireball_explosion_cluster_parent_02");
	level._effect["smoke_grey_column_4_spot_directional_lg"] = loadfx("vfx/smoke/smoke_grey_column_4_spot_directional_lg");
	level._effect["cap_intro_truck_light_soft_offset"] = loadfx("vfx/lights/cap_intro_truck_light_soft_offset");
	level._effect["cap_intro_elevator_light_soft"] = loadfx("vfx/lights/cap_intro_elevator_light_soft");
	level._effect["punch_mouth_blood_spit"] = loadfx("vfx/blood/punch_mouth_blood_spit");
	level._effect["playermech_cannon_default"] = loadfx("vfx/explosion/playermech_cannon_default");
	level._effect["drone_search_lt"] = loadfx("vfx/lights/drone_search_lt");
	level._effect["emergency_light"] = loadfx("vfx/lights/emergency_lt_red_pulse");
	level._effect["barrel_gen_flammable"] = loadfx("vfx/destructible/barrel_gen_flammable_01_dstry_scrptdst");
	level._effect["tire_industrial_01_rubber"] = loadfx("vfx/destructible/tire_industrial_01_rubber");
	level._effect["fx_lift_steam"] = loadfx("vfx/map/captured/cap_mech_lift_steam");
	level._effect["mech_chest_explosion"] = loadfx("vfx/map/captured/cap_mech_explosion_chest");
	level._effect["mech_wall_explosion"] = loadfx("vfx/map/captured/cap_mech_explosion_wall");
	level._effect["flesh_hit"] = loadfx("fx/impacts/flesh_hit");
	fx_init();
}

//Function Number: 2
fx_init()
{
	maps\_shg_fx::setup_shg_fx();
	if(isusinghdr())
	{
		setsaveddvar("r_tonemap","1");
	}

	thread maps\_shg_fx::fx_zone_watcher(1000,"msg_vfx_zone1_intro_ambient");
	thread maps\_shg_fx::fx_zone_watcher(1100,"msg_vfx_zone1_intro_upper");
	thread maps\_shg_fx::fx_zone_watcher(1200,"msg_vfx_zone1_intro_lower");
	thread maps\_shg_fx::fx_zone_watcher(2000,"msg_vfx_zone2_tunnels_ambient");
	thread maps\_shg_fx::fx_zone_watcher(2200,"msg_vfx_zone2_tunnels_poison_gas");
	thread maps\_shg_fx::fx_zone_watcher(2300,"msg_vfx_zone2_tunnels_poison_gas_lite");
	thread maps\_shg_fx::fx_zone_watcher(2400,"msg_vfx_zone2_tunnels_morgue");
	thread maps\_shg_fx::fx_zone_watcher(2410,"msg_vfx_zone2_tunnels_morgue_extra_gas");
	thread maps\_shg_fx::fx_zone_watcher(3000,"msg_vfx_zone3_incinerator_ambient");
	thread maps\_shg_fx::fx_zone_watcher(3100,"msg_vfx_zone3_incinerator_oven");
	thread maps\_shg_fx::fx_zone_watcher(4000,"msg_vfx_zone4_heli_ambient");
	thread maps\_shg_fx::fx_zone_watcher(4100,"msg_vfx_zone4_heli_pit");
	thread maps\_shg_fx::fx_zone_watcher(4200,"msg_vfx_zone4_heli_mech");
	thread fx_inc();
	thread fx_inc_godrays();
	thread fx_props_setup();
	thread fx_uv_flash();
}

//Function Number: 3
fx_sun_lens_flare()
{
	if(!common_scripts\utility::flag_exist("fx_spot_flare_kill"))
	{
		common_scripts\utility::flag_init("fx_spot_flare_kill");
	}

	wait 0.05;
	for(;;)
	{
		common_scripts\utility::flag_waitopen("msg_vfx_zone2_tunnels_ambient");
		common_scripts\utility::flag_clear("fx_spot_flare_kill");
		thread maps\_shg_fx::fx_spot_lens_flare_dir("cap_sunflare",(-33.7061,-54.212,0),8000);
		common_scripts\utility::flag_wait("msg_vfx_zone2_tunnels_ambient");
		common_scripts\utility::flag_set("fx_spot_flare_kill");
	}
}

//Function Number: 4
fx_props_setup()
{
	common_scripts\utility::array_thread(getentarray("cap_ind_camera_sm_square_top","script_noteworthy"),::fx_props_security_cameras,"ind_camera_lens_glow",0,200000);
	common_scripts\utility::array_thread(getentarray("cap_ind_camera_sm_square_top_02","script_noteworthy"),::fx_props_security_cameras,"ind_camera_lens_glow_02",1,200000);
	common_scripts\utility::array_thread(getentarray("cap_ind_camera_sm_square_top_far","script_noteworthy"),::fx_props_security_cameras,"ind_camera_lens_glow",0,2500000);
	var_00 = getent("fx_crash_sky_blocker","targetname");
	var_00 hide();
	var_00 notsolid();
}

//Function Number: 5
fx_props_security_cameras(param_00,param_01,param_02)
{
	self endon("death");
	var_03 = self.angles;
	var_04 = self.angles - (20,80,0);
	var_05 = self.angles + (20,80,0);
	var_06 = 0;
	var_07 = undefined;
	if(!isdefined(param_02))
	{
		param_02 = 200000;
	}

	if(param_01)
	{
		playfxontag(level._effect[param_00],self,"tag_fx");
	}

	for(;;)
	{
		while(!var_06)
		{
			wait(0.1);
			if(isdefined(level.allies))
			{
				var_07 = common_scripts\utility::random(level.allies);
				if(isdefined(var_07))
				{
					var_08 = distancesquared(self.origin,var_07.origin);
					var_06 = var_08 <= param_02;
				}
			}

			if(!var_06)
			{
				var_07 = level.player;
				if(isdefined(var_07))
				{
					var_08 = distancesquared(self.origin,var_07.origin);
					var_06 = var_08 <= param_02;
				}
			}
		}

		if(!param_01)
		{
			playfxontag(level._effect[param_00],self,"tag_fx");
		}

		while(var_06)
		{
			if(isdefined(var_07))
			{
				var_09 = vectortoangles(var_07.origin + (0,60,0) - self.origin);
				self.angles = fx_clamp_rotation(self.angles,var_09,var_04,var_05,4);
				wait(0.05);
				var_08 = distancesquared(self.origin,var_07.origin);
				var_06 = var_08 <= param_02;
			}
			else
			{
				var_06 = 0;
			}

			if(!var_06)
			{
				if(isdefined(level.allies))
				{
					for(var_0A = 0;var_0A < level.allies.size;var_0A++)
					{
						var_07 = level.allies[var_0A];
						var_08 = distancesquared(self.origin,var_07.origin);
						var_06 = var_08 <= param_02;
						if(var_06)
						{
							break;
						}
					}

					if(!var_06)
					{
						var_07 = level.player;
						if(isdefined(var_07))
						{
							var_08 = distancesquared(self.origin,var_07.origin);
							var_06 = var_08 <= param_02;
						}
					}
				}
			}
		}

		if(param_01)
		{
			self rotateto(var_03,0.5);
			wait(0.5);
			continue;
		}

		killfxontag(level._effect[param_00],self,"tag_fx");
	}
}

//Function Number: 6
fx_clamp_rotation(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	for(var_06 = 0;var_06 < 3;var_06++)
	{
		var_05[var_06] = clamp(param_01[var_06],param_02[var_06],param_03[var_06]);
		if(param_01[var_06] - param_03[var_06] > 360 - param_01[var_06] + param_02[var_06])
		{
			var_05[var_06] = param_02[var_06];
		}

		if(var_05[var_06] > param_00[var_06] + param_04)
		{
			var_05[var_06] = param_00[var_06] + param_04;
			continue;
		}

		if(var_05[var_06] < param_00[var_06] - param_04)
		{
			var_05[var_06] = param_00[var_06] - param_04;
		}
	}

	return (var_05[0],var_05[1],var_05[2]);
}

//Function Number: 7
fx_footstep_dust_le(param_00)
{
	var_01 = param_00 gettagorigin("j_ball_le");
	playfx(level._effect["cap_footstep_dust"],var_01,(0,0,1));
}

//Function Number: 8
fx_footstep_dust_ri(param_00)
{
	var_01 = param_00 gettagorigin("j_ball_ri");
	playfx(level._effect["cap_footstep_dust"],var_01,(0,0,1));
}

//Function Number: 9
fx_footstep_dust_rocks_le(param_00)
{
	var_01 = param_00 gettagorigin("j_ball_le");
	playfx(level._effect["cap_footstep_dust_rocks"],var_01,(0,0,1));
}

//Function Number: 10
fx_footstep_dust_rocks_ri(param_00)
{
	var_01 = param_00 gettagorigin("j_ball_ri");
	playfx(level._effect["cap_footstep_dust_rocks"],var_01,(0,0,1));
}

//Function Number: 11
fx_heli_crash_fist_dust_mech(param_00)
{
	common_scripts\_exploder::exploder("fx_crash_fist_dust_mech");
}

//Function Number: 12
fx_footstep_dust_mech_le(param_00)
{
	var_01 = param_00 gettagorigin("j_ball_le");
	playfx(level._effect["cap_footstep_dust_mech"],var_01,(0,0,1));
}

//Function Number: 13
fx_footstep_dust_mech_ri(param_00)
{
	var_01 = param_00 gettagorigin("j_ball_ri");
	playfx(level._effect["cap_footstep_dust_mech"],var_01,(0,0,1));
}

//Function Number: 14
fx_knee_dust_mech_le(param_00)
{
	var_01 = param_00 gettagorigin("j_knee_le");
	playfx(level._effect["cap_footstep_dust_mech"],var_01,(0,0,1));
}

//Function Number: 15
fx_knee_dust_mech_ri(param_00)
{
	var_01 = param_00 gettagorigin("j_knee_ri");
	playfx(level._effect["cap_footstep_dust_mech"],var_01,(0,0,1));
}

//Function Number: 16
fx_body_dust_mech(param_00)
{
	var_01 = param_00 gettagorigin("j_shoulder_le") - (0,0,16);
	playfx(level._effect["cap_body_dust_mech"],var_01,(0,0,1));
}

//Function Number: 17
fx_footstep_water_small_le(param_00)
{
}

//Function Number: 18
fx_footstep_water_small_ri(param_00)
{
}

//Function Number: 19
fx_inc()
{
	if(!common_scripts\utility::flag_exist("flag_incinerator_saved"))
	{
		common_scripts\utility::flag_init("flag_incinerator_saved");
	}

	common_scripts\utility::flag_wait("flag_incinerator_saved");
	common_scripts\_exploder::exploder("fx_inc_oven_ash_static");
	wait(8.35);
	common_scripts\_exploder::exploder("fx_inc_pilot_light_a_6");
	wait(2.43);
	common_scripts\_exploder::exploder("fx_inc_pilot_light_a_5");
	wait(0.9);
	common_scripts\_exploder::exploder("fx_inc_pilot_light_a_4");
	wait(0.77);
	common_scripts\_exploder::exploder("fx_inc_pilot_light_a_3");
	wait(0.6);
	common_scripts\_exploder::exploder("fx_inc_pilot_light_a_2");
	wait(0.53);
	common_scripts\_exploder::exploder("fx_inc_pilot_light_a_1");
	wait(1.87);
	maps\_utility::stop_exploder("fx_inc_pilot_light_a_1");
	common_scripts\_exploder::exploder("fx_inc_fire_a_1");
	common_scripts\_exploder::exploder("fx_inc_fire_1");
	thread fx_inc_oven_godrays_on(1);
	level notify("incinerator_flame_on");
	wait(4.36);
	maps\_utility::stop_exploder("fx_inc_fire_a_1");
	maps\_utility::stop_exploder("fx_inc_fire_1");
	common_scripts\_exploder::exploder("fx_inc_pilot_light_a_1");
	thread fx_inc_oven_godrays_off();
	wait(4.14);
	maps\_utility::stop_exploder("fx_inc_pilot_light_a_2");
	common_scripts\_exploder::exploder("fx_inc_fire_a_2");
	common_scripts\_exploder::exploder("fx_inc_fire_2");
	thread fx_inc_oven_godrays_on(2);
	level notify("incinerator_flame_on");
	wait(4.36);
	maps\_utility::stop_exploder("fx_inc_fire_a_2");
	maps\_utility::stop_exploder("fx_inc_fire_2");
	common_scripts\_exploder::exploder("fx_inc_pilot_light_a_2");
	thread fx_inc_oven_godrays_off();
	wait(4.14);
	maps\_utility::stop_exploder("fx_inc_pilot_light_a_3");
	common_scripts\_exploder::exploder("fx_inc_fire_a_3");
	common_scripts\_exploder::exploder("fx_inc_fire_3");
	thread fx_inc_oven_godrays_on(3);
	level notify("incinerator_flame_on");
	wait(4.36);
	maps\_utility::stop_exploder("fx_inc_fire_a_3");
	maps\_utility::stop_exploder("fx_inc_fire_3");
	common_scripts\_exploder::exploder("fx_inc_pilot_light_a_3");
	thread fx_inc_oven_godrays_off();
	wait(4.14);
	maps\_utility::stop_exploder("fx_inc_pilot_light_a_4");
	if(maps\_utility::is_gen4())
	{
		common_scripts\_exploder::exploder("fx_inc_fire_a_4");
	}

	common_scripts\_exploder::exploder("fx_inc_fire_4");
	thread fx_inc_oven_godrays_on(3);
	level notify("incinerator_flame_on");
	common_scripts\utility::flag_set("flag_incinerator_last_fire_loop");
}

//Function Number: 20
fx_inc_near_miss(param_00)
{
	if(!common_scripts\utility::flag_exist("lgt_flag_inc_near_miss"))
	{
		common_scripts\utility::flag_init("lgt_flag_inc_near_miss");
	}

	wait(0.3);
	maps\_utility::stop_exploder("fx_inc_pilot_light_a_5");
	maps\_utility::stop_exploder("fx_inc_fire_4");
	common_scripts\_exploder::exploder("fx_inc_fire_5");
	common_scripts\_exploder::exploder("fx_inc_crawl_heat");
	common_scripts\utility::flag_set("lgt_flag_inc_near_miss");
	if(maps\_utility::is_gen4())
	{
		maps\_utility::stop_exploder("fx_inc_fire_a_4");
		common_scripts\_exploder::exploder("fx_inc_fire_a_5");
	}

	wait(0.75);
	if(maps\_utility::is_gen4())
	{
		maps\_utility::stop_exploder("fx_inc_fire_a_5");
		common_scripts\_exploder::exploder("fx_inc_pilot_light_a_5");
	}

	maps\_utility::stop_exploder("fx_inc_fire_5");
	thread fx_inc_oven_godrays_off();
}

//Function Number: 21
fx_inc_oven_godrays_on(param_00)
{
	maps\_utility::stop_exploder("fx_inc_oven_ash_static");
	common_scripts\_exploder::exploder("fx_inc_oven_ash_fire");
	if(maps\_utility::is_gen4())
	{
		wait(0.2);
		thread maps\_utility::vision_set_fog_changes("captured_inc_fires_godray_" + param_00,0.1);
		thread maps\_art::sunflare_changes("fx_inc_oven_godrays",0.1);
		return;
	}

	if(!isdefined(level.first_oven))
	{
		wait(1.1);
		common_scripts\_exploder::exploder("fx_inc_oven_ash_fire_cg_burst");
		level.first_oven = 1;
	}
}

//Function Number: 22
fx_inc_oven_godrays_off()
{
	maps\_utility::stop_exploder("fx_inc_oven_ash_fire");
	common_scripts\_exploder::exploder("fx_inc_oven_ash_static");
	if(maps\_utility::is_gen4())
	{
		wait(0.3);
		thread maps\_utility::vision_set_fog_changes("",0.1);
		thread maps\_art::sunflare_changes("fx_inc_fan_godrays",0.1);
		return;
	}

	if(isdefined(level.first_oven))
	{
		if(level.first_oven)
		{
			maps\_utility::stop_exploder("fx_inc_oven_ash_fire_cg_burst");
			return;
		}
	}
}

//Function Number: 23
fx_stop_pilot_lights()
{
	common_scripts\utility::flag_wait("flag_incinerator_last_fire_loop");
	for(var_00 = 1;var_00 <= 6;var_00++)
	{
		if(var_00 == 5)
		{
			continue;
		}

		maps\_utility::stop_exploder("fx_inc_pilot_light_a_" + var_00);
		wait 0.05;
	}

	common_scripts\utility::flag_wait("lgt_flag_inc_near_miss");
	maps\_utility::stop_exploder("fx_inc_pilot_light_a_5");
}

//Function Number: 24
fx_inc_pipe_explode(param_00)
{
	if(!common_scripts\utility::flag_exist("lgt_flag_inc_pipe_explode"))
	{
		common_scripts\utility::flag_init("lgt_flag_inc_pipe_explode");
	}

	soundscripts\_snd::snd_message("aud_incin_pipe_burst");
	playfxontag(level._effect["cap_inc_gas_leak"],level.pipe,"bottom_05_jnt");
	common_scripts\utility::flag_set("flag_inc_pipe_break");
	maps\_utility::stop_exploder("fx_inc_crawl_heat");
	wait(1);
	playfxontag(level._effect["cap_inc_gas_explode"],level.pipe,"bottom_05_jnt");
	common_scripts\_exploder::exploder("fx_inc_gas_explode");
	common_scripts\utility::flag_set("lgt_flag_inc_pipe_explode");
	wait(0.2);
	common_scripts\_exploder::exploder("fx_inc_gas_explode_late_fire");
	wait(2.8);
	maps\_utility::stop_exploder("fx_inc_oven_ash_static");
	wait(5);
	maps\_utility::stop_exploder("fx_inc_gas_explode_late_fire");
	common_scripts\_exploder::exploder("fx_inc_open_room_ambient");
	thread maps\_art::sunflare_changes("fx_inc_fan_godrays",0.1);
	level thread fx_inc_cycle_fires("a");
	level thread fx_inc_cycle_fires("c");
	wait(7.8);
	maps\_utility::stop_exploder("fx_inc_pilot_light_b_1");
	common_scripts\_exploder::exploder("fx_inc_fire_b_1_2s");
	wait(2);
	maps\_utility::stop_exploder("fx_inc_fire_b_1_2s");
	common_scripts\_exploder::exploder("fx_inc_pilot_light_b_1");
	level thread fx_inc_cycle_fires("b");
}

//Function Number: 25
fx_inc_cycle_fires(param_00)
{
	var_01 = undefined;
	while(!common_scripts\utility::flag("flag_bh_pit"))
	{
		wait(randomfloatrange(0.5,2));
		var_01 = randomintrange(1,7);
		maps\_utility::stop_exploder("fx_inc_pilot_light_" + param_00 + "_" + var_01);
		common_scripts\_exploder::exploder("fx_inc_fire_" + param_00 + "_" + var_01);
		wait(4);
		maps\_utility::stop_exploder("fx_inc_fire_" + param_00 + "_" + var_01);
		common_scripts\_exploder::exploder("fx_inc_pilot_light_" + param_00 + "_" + var_01);
	}

	for(var_01 = 1;var_01 < 7;var_01++)
	{
		wait 0.05;
		maps\_utility::stop_exploder("fx_inc_pilot_light_a_" + var_01);
		maps\_utility::stop_exploder("fx_inc_pilot_light_b_" + var_01);
		maps\_utility::stop_exploder("fx_inc_pilot_light_c_" + var_01);
	}

	wait 0.05;
	maps\_utility::stop_exploder("fx_inc_open_room_ambient");
}

//Function Number: 26
fx_inc_godrays()
{
	var_00 = getent("fx_inc_sun_blocker","targetname");
	var_00 hide();
	var_00 notsolid();
	if(maps\_utility::is_gen4())
	{
		if(!common_scripts\utility::flag_exist("fx_inc_godrays"))
		{
			common_scripts\utility::flag_init("fx_inc_godrays");
		}

		wait 0.05;
		for(;;)
		{
			common_scripts\utility::flag_wait("fx_inc_godrays");
			var_00 show();
			thread maps\_art::sunflare_changes("fx_inc_fan_godrays",2);
			common_scripts\utility::flag_waitopen("fx_inc_godrays");
			thread maps\_art::sunflare_changes("default",2);
			var_00 hide();
		}
	}
}

//Function Number: 27
fx_uv_flash()
{
	level waittill("start_anim_tc_exit_stairs");
	common_scripts\_exploder::exploder("fx_uv_dust");
	var_00 = getentarray("fx_uv_light_on","targetname");
	var_01 = getentarray("fx_uv_light_off","targetname");
	foreach(var_03 in var_00)
	{
		var_03 hide();
	}

	level waittill("start_anim_tc_enter_test");
	wait(1.9);
	common_scripts\_exploder::exploder("fx_uv_flash_buildup");
	wait(2);
	common_scripts\_exploder::exploder("fx_uv_flash");
	common_scripts\_exploder::kill_exploder("fx_uv_dust");
	foreach(var_03 in var_00)
	{
		var_03 show();
	}

	wait 0.05;
	foreach(var_03 in var_01)
	{
		var_03 hide();
	}

	wait(0.3);
	foreach(var_03 in var_01)
	{
		var_03 show();
	}

	wait 0.05;
	foreach(var_03 in var_00)
	{
		var_03 hide();
	}
}

//Function Number: 28
fx_autopsy_hatch_open()
{
	wait(16.8);
	common_scripts\_exploder::exploder("fx_autopsy_hatch_ash_1");
}

//Function Number: 29
fx_escape_takedown_wastebasket(param_00)
{
	physicsjolt((5024,-10592,-1756),60,60,(-0.4,1,0.2));
}

//Function Number: 30
fx_escape_takedown_foot_stomp(param_00)
{
	var_01 = param_00 gettagorigin("j_ankle_ri") - (0,0,4);
	playfx(level._effect["cap_foot_stomp_blood"],var_01,(0,0,1));
	wait(0.07);
	var_01 = param_00 gettagorigin("j_ankle_ri") - (6,-2,4);
	playfx(level._effect["cap_foot_stomp_blood_decal"],var_01,(0,0,1));
}

//Function Number: 31
fx_walk_heli_flyby()
{
	wait(0.5);
	common_scripts\_exploder::exploder("fx_walk_heli_dust_1");
	wait(0.5);
	common_scripts\_exploder::exploder("fx_walk_heli_dust_2");
	wait(0.5);
	common_scripts\_exploder::exploder("fx_walk_heli_dust_3");
}

//Function Number: 32
fx_heli_flyby_dust(param_00)
{
	var_01 = 0;
	while(var_01 < 10)
	{
		var_02 = bullettrace(param_00.origin,param_00.origin - (0,0,1000),0);
		playfx(level._effect["heli_dust_settle_3s"],var_02["position"],(0,0,1));
		var_01 = var_01 + 1;
		wait(1);
	}

	common_scripts\_exploder::exploder("fx_heli_flyby_dust_settle");
}

//Function Number: 33
fx_heli_manticore_dust(param_00)
{
	wait(3);
	var_01 = 0;
	while(var_01 < 5)
	{
		var_02 = bullettrace(param_00.origin,param_00.origin - (0,0,1000),0);
		playfx(level._effect["heli_dust_settle_3s"],var_02["position"],(0,0,1));
		var_01 = var_01 + 1;
		wait(1);
	}

	common_scripts\_exploder::exploder("fx_heli_dust_settle");
}

//Function Number: 34
fx_heli_gideon_fire(param_00)
{
	if(!isdefined(level.heli_gideon_fire))
	{
		level.heli_gideon_fire = 0;
	}

	level.heli_gideon_fire = level.heli_gideon_fire + 1;
	var_01 = param_00 gettagorigin("tag_flash");
	var_02 = undefined;
	switch(level.heli_gideon_fire)
	{
		case 1:
			var_02 = level.pilot gettagorigin("j_hip_le");
			break;

		case 2:
			var_02 = level.pilot gettagorigin("j_spinelower");
			break;

		case 3:
			var_02 = level.pilot gettagorigin("j_spineupper");
			break;

		case 4:
			var_02 = level.pilot gettagorigin("j_shoulder_ri");
			break;

		case 5:
			var_02 = level.pilot gettagorigin("j_neck");
			break;

		case 6:
			var_02 = level.pilot gettagorigin("j_head");
			break;
	}

	magicbullet("iw5_hmr9_sp",var_01,var_02);
	var_03 = bullettrace(var_01,var_02,1);
	if(isdefined(var_03["position"]))
	{
		common_scripts\_exploder::exploder("fx_heli_gideon_sparks_" + randomintrange(1,7));
	}

	var_03 = bullettrace(var_01,var_01 + 100 * var_02 - var_01,0,undefined,1,0,1);
	if(isdefined(var_03["position"]))
	{
		playfx(level._effect["cap_heli_gideon_sparks"],var_03["position"],var_03["normal"]);
	}

	if(level.heli_gideon_fire == 1)
	{
		level notify("heliride_blood");
	}
}

//Function Number: 35
fx_heli_ride()
{
	wait(3);
	maps\_utility::stop_exploder("fx_heli_flyby_dust_settle");
	maps\_utility::stop_exploder("fx_heli_dust_settle");
	wait(9);
	while(!common_scripts\utility::flag("flag_heliride_end"))
	{
		playfx(level._effect["cap_heli_aa_explosion_runner"],level.player.origin);
		wait(0.1);
	}
}

//Function Number: 36
fx_heli_aa_explosion(param_00)
{
	if(!isdefined(level.aa_explosion))
	{
		level.aa_explosion = 0;
	}

	level.aa_explosion = level.aa_explosion + 1;
	var_01 = (0,0,0);
	switch(level.aa_explosion)
	{
		case 1:
			var_01 = (11434,-11428,-1874);
			break;

		case 2:
			var_01 = (11843,-8615,42);
			break;

		case 3:
			var_01 = (11879,-7784,278);
			break;

		case 4:
			var_01 = (11921,-7121,644);
			break;

		case 5:
			var_01 = (9557,-6985,757);
			break;

		case 6:
			var_01 = (8566.5,-6633.43,1158.82);
			break;

		case 7:
			var_01 = (7965.59,-5802.48,1437.4);
			break;

		case 8:
			var_01 = (7674,-5237,1860);
			break;
	}

	playfx(level._effect["cap_aa_explosion"],var_01);
	playfxontag(level._effect["cap_heli_damage_1"],level.heli_collision,"tag_fx_5");
	playfxontag(level._effect["cap_heli_damaged_sparks_3"],level.heli_collision,"tag_fx_" + randomintrange(1,5));
	switch(level.aa_explosion)
	{
		case 2:
			wait 0.05;
			playfxontag(level._effect["cap_heli_damaged_sparks"],level.heli_collision,"tag_fx_top_panel");
			playfxontag(level._effect["cap_heli_light_red_01"],level.heli_collision,"tag_fx_light");
			break;

		case 4:
			wait 0.05;
			playfxontag(level._effect["cap_heli_damaged_sparks"],level.heli_collision,"tag_fx_4");
			break;
	}
}

//Function Number: 37
fx_heli_mech_punch(param_00)
{
	level notify("heliride_punch");
	playfxontag(level._effect["cap_heli_glass_shatter_01"],level.heli_collision,"tag_fx_glass");
}

//Function Number: 38
fx_heli_crash_godrays_on()
{
	if(maps\_utility::is_gen4())
	{
		thread maps\_utility::vision_set_fog_changes("captured_heli_crash_godray",0.1);
		thread maps\_art::sunflare_changes("fx_heli_crash_godrays",0.1);
		var_00 = getent("fx_crash_sky_blocker","targetname");
		var_00 show();
	}
}

//Function Number: 39
fx_heli_crash_godrays_off()
{
	if(maps\_utility::is_gen4())
	{
		thread maps\_utility::vision_set_fog_changes("",0.1);
		thread maps\_art::sunflare_changes("default",0.1);
		var_00 = getent("fx_crash_sky_blocker","targetname");
		var_00 hide();
	}
}

//Function Number: 40
scriptable_pillars_light_retarget()
{
	wait(1);
	var_00 = getent("pillar_light_target","targetname");
	iprintlnbold("START RETARGETING PILLARS");
	var_01 = getscriptablearray("scriptable_pillar","targetname");
	foreach(var_03 in var_01)
	{
		iprintlnbold("RETARGETING A NEW PILLAR");
		var_03 retargetscriptmodellighting(var_00);
	}
}

//Function Number: 41
fx_heli_crash_debris_dust(param_00)
{
	common_scripts\_exploder::exploder("fx_crash_debris_dust");
	level thread fx_heli_crash_mech_sparks(param_00);
}

//Function Number: 42
fx_heli_crash_mech_sparks(param_00)
{
	wait(1.3);
	playfxontag(level._effect["cap_crash_damaged_sparks"],param_00,"j_plate_mkl");
	soundscripts\_snd::snd_message("aud_spark_1");
	wait(0.7);
	playfxontag(level._effect["cap_crash_damaged_sparks"],param_00,"j_plate_bfl");
	soundscripts\_snd::snd_message("aud_spark_2");
	wait(1.3);
	playfxontag(level._effect["cap_crash_damaged_sparks"],param_00,"j_chestprotect_r");
	soundscripts\_snd::snd_message("aud_spark_3");
}

//Function Number: 43
fx_heli_crash_enter_mech_sparks(param_00)
{
	wait(11.3);
	playfxontag(level._effect["cap_crash_damaged_sparks"],param_00,"j_chestprotect_L");
	soundscripts\_snd::snd_message("aud_spark_4");
	wait(1.3);
	playfxontag(level._effect["cap_crash_damaged_sparks"],param_00,"J2_exoShoulder_r");
	soundscripts\_snd::snd_message("aud_spark_5");
}

//Function Number: 44
fx_intro_ambient(param_00)
{
	common_scripts\_exploder::exploder("fx_intro_ambient");
	wait(14);
	common_scripts\_exploder::exploder("fx_intro_passing_truck_1");
	wait(5.75);
	common_scripts\_exploder::exploder("fx_intro_passing_truck_2");
	wait(8.25);
	maps\_utility::stop_exploder("fx_intro_passing_truck_1");
	maps\_utility::stop_exploder("fx_intro_passing_truck_2");
	common_scripts\_exploder::exploder("fx_intro_passing_truck_3");
}

//Function Number: 45
fx_intro_truck_dust(param_00)
{
	maps\_utility::stop_exploder("fx_intro_ambient");
	common_scripts\_exploder::exploder("fx_intro_truck_dust_01");
	wait(1);
	common_scripts\_exploder::exploder("fx_intro_truck_dust_02");
	wait(7);
	maps\_utility::stop_exploder("fx_intro_truck_dust_01");
	maps\_utility::stop_exploder("fx_intro_truck_dust_02");
}

//Function Number: 46
fx_intro_body_dust(param_00)
{
	var_01 = param_00 gettagorigin("j_SpineLower");
	playfx(level._effect["cap_body_dust_rocks"],var_01);
	wait(1);
	var_01 = level.allies[0] gettagorigin("j_SpineLower");
	playfx(level._effect["cap_body_dust_rocks"],var_01);
	wait(0.5);
	var_01 = level.allies[1] gettagorigin("j_SpineLower");
	playfx(level._effect["cap_body_dust_rocks"],var_01);
}

//Function Number: 47
fx_gideon_body_dust(param_00)
{
	wait(0.01);
	var_01 = level.allies[0] gettagorigin("j_SpineLower");
	playfx(level._effect["cap_body_dust_rocks"],var_01);
}

//Function Number: 48
fx_gideon_body_dust_inc(param_00)
{
	wait(0.01);
	var_01 = level.allies[0] gettagorigin("j_SpineLower");
	playfx(level._effect["cap_body_dust_rocks2"],var_01);
}

//Function Number: 49
fx_body_dust_drag(param_00)
{
	playfxontag(level._effect["cap_body_dust_emit"],level.allies[0],"j_SpineLower");
	wait(1.9);
	playfxontag(level._effect["cap_body_dust_emit"],level.allies[1],"j_SpineLower");
	wait(1.9);
	playfxontag(level._effect["cap_body_dust_emit"],level.allies[2],"j_SpineLower");
}

//Function Number: 50
fx_emergency_lights(param_00,param_01,param_02)
{
	self endon("kill_pulse_light");
	self endon("tff_pre_escape_to_test_chamber");
	if(!isdefined(param_02))
	{
		param_02 = 1.412;
	}

	while(!common_scripts\utility::flag(param_01))
	{
		common_scripts\_exploder::exploder(param_00);
		wait(param_02);
	}
}

//Function Number: 51
fx_interrogation_irons_fire(param_00)
{
	var_01 = param_00 gettagorigin("j_wrist_le") + (0,0,4);
	var_02 = level.allies[2] gettagorigin("j_hip_le");
	magicbullet("iw5_titan45onearm_sp",var_01,var_02);
	wait(0.1);
	common_scripts\_exploder::exploder("fx_int_blood_splat");
}

//Function Number: 52
fx_rescue_guard_2_init(param_00)
{
	level.fx_guard_2 = param_00;
}

//Function Number: 53
fx_rescue_guard_fire(param_00)
{
	if(!isdefined(level.rescue_guard_fire))
	{
		level.rescue_guard_fire = 0;
	}

	level.rescue_guard_fire = level.rescue_guard_fire + 1;
	switch(level.rescue_guard_fire)
	{
		case 2:
			var_01 = param_00 gettagorigin("j_wrist_le") + (0,0,4);
			var_02 = level.fx_guard_2 gettagorigin("j_hip_le") + (0,0,6);
			magicbullet("iw5_titan45onearm_sp",var_01,var_02);
			wait(0.1);
			common_scripts\_exploder::exploder("fx_rescue_guard_2_blood_splat");
			break;

		case 3:
			common_scripts\_exploder::exploder("fx_int_guard_fire_3");
			break;

		case 4:
			common_scripts\_exploder::exploder("fx_int_guard_fire_4");
			break;

		case 5:
			common_scripts\_exploder::exploder("fx_int_guard_fire_5");
			break;

		default:
			break;
	}
}

//Function Number: 54
fx_rescue_body_slam_1(param_00)
{
	var_01 = fx_get_ground_pos(param_00 gettagorigin("j_SpineUpper") + (0,0,10));
	playfx(level._effect["cap_body_dust_rocks"],var_01,(0,0,1));
}

//Function Number: 55
fx_rescue_body_slam_2(param_00)
{
	var_01 = fx_get_ground_pos(param_00 gettagorigin("j_neck") + (0,0,10));
	playfx(level._effect["cap_body_dust_rocks"],var_01,(0,0,1));
}

//Function Number: 56
fx_rescue_head_slam_1(param_00)
{
	var_01 = fx_get_ground_pos(param_00 gettagorigin("j_head") + (0,0,10));
	playfx(level._effect["cap_head_slam_dust"],var_01,(0,0,1));
}

//Function Number: 57
fx_rescue_head_slam_2(param_00)
{
	var_01 = fx_get_ground_pos(param_00 gettagorigin("j_head") + (0,0,10));
	playfx(level._effect["cap_head_slam_blood"],var_01,(0,0,1));
	wait(0.07);
	var_01 = fx_get_ground_pos(param_00 gettagorigin("j_head") + (0,0,10));
	playfx(level._effect["cap_foot_stomp_blood_decal"],var_01,(0,0,1));
}

//Function Number: 58
fx_get_ground_pos(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 100;
	}

	var_02 = bullettrace(param_00,param_00 - (0,0,param_01),0,undefined,1);
	return var_02["position"];
}

//Function Number: 59
fx_mech_cockpit_damage()
{
	if(!isdefined(level.fx_mech_cockpit))
	{
		level.fx_mech_cockpit = common_scripts\utility::spawn_tag_origin();
		level.fx_mech_cockpit linkto(self,"tag_view",(0,0,0),(0,0,0));
		playfxontag(level._effect["cap_mech_cockpit_damage"],level.fx_mech_cockpit,"tag_origin");
	}
}

//Function Number: 60
fx_mech_cockpit_damage_stop()
{
	if(isdefined(level.fx_mech_cockpit))
	{
		killfxontag(level._effect["cap_mech_cockpit_damage"],level.fx_mech_cockpit,"tag_origin");
	}
}

//Function Number: 61
fx_end_amb_fx()
{
	common_scripts\_exploder::exploder("end_amb_fx");
}

//Function Number: 62
fx_mech_foot_sparks(param_00)
{
	common_scripts\_exploder::exploder("mech_foot_sparks");
}

//Function Number: 63
fx_interrogation_arm_smash(param_00)
{
	var_01 = spawn("script_model",param_00 gettagorigin("J_Elbow_LE"));
	var_01.angles = (15,0,0);
	var_01 setmodel("tag_origin");
	playfxontag(level._effect["cap_exo_arm_burst"],var_01,"tag_origin");
	var_01 linkto(param_00,"J_Elbow_LE");
	wait(5);
	var_01 delete();
}

//Function Number: 64
fx_mech_explode_amb_fx()
{
	common_scripts\_exploder::exploder("mf_amb_fx");
}

//Function Number: 65
fx_mech_door_lift_fx()
{
	wait(6);
	common_scripts\_exploder::exploder("gate_lift_fx");
}

//Function Number: 66
fx_stop_mech_door_lift_fx()
{
	wait(6);
	maps\_utility::stop_exploder("gate_lift_fx");
}

//Function Number: 67
fx_mech_exit_steam(param_00)
{
	common_scripts\_exploder::exploder("mech_exit_steam");
}

//Function Number: 68
fx_mech_land_sparks(param_00)
{
	if(!isdefined(level.fx_mech_cockpit))
	{
		level.fx_mech_cockpit = common_scripts\utility::spawn_tag_origin();
		level.fx_mech_cockpit linkto(self,"tag_view",(0,0,0),(0,0,0));
		playfxontag(level._effect["cap_heli_gideon_sparks"],level.fx_mech_cockpit,"tag_origin");
	}
}

//Function Number: 69
fx_mech_exit_land_dust(param_00)
{
	common_scripts\_exploder::exploder("mech_exit_body_dust");
}

//Function Number: 70
fx_mech_soft_land_dust(param_00)
{
	common_scripts\_exploder::exploder("mech_soft_land_dust");
}

//Function Number: 71
fx_heli_crash_hero_falling_dust()
{
	wait(1);
	common_scripts\_exploder::exploder("mech_intro_dust_falling");
}