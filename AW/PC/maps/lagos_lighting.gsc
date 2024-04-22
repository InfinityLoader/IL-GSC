/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: lagos_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 118
 * Decompile Time: 1688 ms
 * Timestamp: 4/22/2024 2:33:54 AM
*******************************************************************/

//Function Number: 1
main()
{
	thread set_level_lighting_values();
	thread setup_dof_presets();
	thread setup_dof_viewmodel_presets();
	thread setup_flickerlight_presets();
	thread test_sun_flare();
	init_level_lighting_flags();
	thread setup_lighting_intro_drone();
	thread setup_lighting_intro_start();
	thread setup_lighting_government_start();
	thread setup_lighting_pre_h_breach_start();
	thread setup_lighting_post_h_breach_start();
	thread setup_lighting_roundabout_start();
	thread setup_lighting_alley1_start();
	thread setup_lighting_oncoming_start();
	thread setup_lighting_alley2_start();
	thread setup_lighting_flank_start();
	thread setup_lighting_frogger_start();
	thread setup_lighting_rail_start();
	thread setup_lighting_middle_takedown_start();
	thread setup_lighting_post_middle_takedown_start();
	thread setup_lighting_van_takedown_start();
	thread setup_lighting_underwater_start();
	thread setup_lighting_shoreline_start();
	thread setup_lighting_outro_start();
	thread setup_dof_drone();
	thread setup_lightgrid_lighting_drone();
	thread setup_lighting_drone();
	thread setup_hostage_key_fov_tune();
	thread setup_lighting_lagos_generic();
	thread setup_lighting_sunflare();
	thread setup_dof_intro();
	thread setup_lighting_lagos_intro_interiors();
	thread setup_lighting_lagos_intro_post_exo_interiors();
	thread setup_lighting_lagos_intro_alley();
	thread setup_lighting_lagos_intro_alley_transition();
	thread setup_lighting_government_overlook_door();
	thread setup_lighting_government_overlook();
	thread setup_dof_government_overlook();
	thread setup_government_rpg_explosion_lighting();
	thread setup_government_rpg_explosion_dof();
	thread setup_lighting_railwalk();
	thread setup_government_climb_sunlerp();
	thread setup_lighting_override_exo_wallclimb();
	thread setup_dof_government_climb();
	thread setup_dof_government_breach();
	thread setup_lighting_government_breach();
	thread setup_lighting_government();
	thread setup_lighting_harmonic_breach();
	thread setup_lighting_harmonic_breach_hud();
	thread setup_lighting_harmonic_breach_dof();
	thread setup_lighting_government_hostage();
	thread setup_lighting_hostage_release();
	thread setup_dof_hostage_release();
	thread setup_lighting_government_ext();
	thread setup_lighting_lobby();
	thread setup_lighting_roundabout();
	thread setup_lighting_roundabout_transition();
	thread setup_lighting_initial_rpgs();
	thread setup_dof_roundabout_tanker_explosion();
	thread setup_lighting_tanker_aftermath();
	thread setup_lighting_alley();
	thread setup_lighting_alley_interiors();
	thread setup_motion_blur_oncoming();
	thread setup_lighting_rec_yard();
	thread setup_lighting_rec_yard_transition();
	thread setup_lighting_marketplace();
	thread setup_lighting_marketplace_interiors();
	thread setup_lighting_traffic_crossing();
	thread setup_lighting_chase_start();
	thread setup_motion_blur_chase_start();
	thread setup_lighting_chase_tunnel_transition();
	thread setup_lighting_chase_tunnel();
	thread setup_lighting_suv_takedown();
	thread setup_lighting_chase_buildings();
	thread setup_lighting_van_takedown();
	thread setup_dof_van_takedown();
	thread setup_lighting_underwater();
	thread setup_lighting_underwater_sunlerp();
	thread setup_lighting_underwater_lights();
	thread setup_lighting_shoreline();
	thread setup_dof_shoreline();
	thread setup_lighting_outro();
}

//Function Number: 2
init_level_lighting_flags()
{
	common_scripts\utility::flag_init("fly_drone_done_lighting");
	common_scripts\utility::flag_init("exo_door_lighting");
	common_scripts\utility::flag_init("exo_door_lighting_complete");
	common_scripts\utility::flag_init("begin_harmonic_breach_lighting");
	common_scripts\utility::flag_init("harmonic_complete_lighting");
	common_scripts\utility::flag_init("hostage_release_lighting");
	common_scripts\utility::flag_init("alley_oncoming_gate_lighting");
	common_scripts\utility::flag_init("alley_oncoming_truck_lighting");
	common_scripts\utility::flag_init("chase_lighting");
	common_scripts\utility::flag_init("traffic_ledge_lighting");
	common_scripts\utility::flag_init("suv_takedown_lighting");
	common_scripts\utility::flag_init("suv_takedown_shoot_lighting");
	common_scripts\utility::flag_init("suv_takedown_dodge_lighting");
	common_scripts\utility::flag_init("suv_takedown_jump_lighting");
	common_scripts\utility::flag_init("suv_takedown_windshield_lighting");
	common_scripts\utility::flag_init("suv_takedown_jump2_lighting");
	common_scripts\utility::flag_init("flag_post_suv_takedown_lighting");
	common_scripts\utility::flag_init("van_takedown_hold_lighting");
	common_scripts\utility::flag_init("van_takedown_shoot_lighting");
	common_scripts\utility::flag_init("van_takedown_impact_lighting");
	common_scripts\utility::flag_init("government_rpg_lighting");
	common_scripts\utility::flag_init("climb_begin_lighting");
	common_scripts\utility::flag_init("climb_ending_lighting");
	common_scripts\utility::flag_init("gov_breach_start_lighting");
	common_scripts\utility::flag_init("trigger_start_tour_bus_lighting");
	common_scripts\utility::flag_init("takedown_playerstart_lighting");
	common_scripts\utility::flag_init("takedown_underwater_lighting");
	common_scripts\utility::flag_init("underwater_lighting");
	common_scripts\utility::flag_init("van_door_open_lighting");
	common_scripts\utility::flag_init("shoreline_lighting");
}

//Function Number: 3
set_level_lighting_values()
{
	if(isusinghdr())
	{
		setsaveddvar("r_disablelightsets",0);
		if(maps\_utility::is_gen4())
		{
			level.player lightsetforplayer("lagos_intro_drone");
		}

		if(level.nextgen)
		{
			setsaveddvar("r_hemiAoEnable",1);
		}
	}
}

//Function Number: 4
setup_dof_presets()
{
	if(level.nextgen)
	{
		maps\_lighting::create_dof_preset("lagos_drone",0,150,4,250,800,2,0.5);
		maps\_lighting::create_dof_preset("lagos_drone_hostage",0,50,6,200,390,4,0.5);
		maps\_lighting::create_dof_preset("lagos_intro",5,35,5,400,4000,1.5,0.5);
		maps\_lighting::create_dof_preset("lagos_standard",0,20,5,1000,7000,1,0.5);
		maps\_lighting::create_dof_preset("lagos_government_overlook",10,40,8,350,1300,2,0.5);
		maps\_lighting::create_dof_preset("lagos_government_climb",0,20,6,25,315,2,0.5);
		maps\_lighting::create_dof_preset("lagos_government_climb_blurry",0,120,7,25,315,2,0.5);
		maps\_lighting::create_dof_preset("lagos_government_breach",0,24,6,500,1880,1.8,0.5);
		maps\_lighting::create_dof_preset("lagos_hostage_room",5,35,6,250,2500,3.5,0.5);
		maps\_lighting::create_dof_preset("lagos_roundabout_tanker",10,250,6,1000,3000,2,0.5);
		maps\_lighting::create_dof_preset("lagos_chase_start",65,400,6,650,1000,1.5,0.5);
		maps\_lighting::create_dof_preset("lagos_van_takedown",0,60,6,1000,7000,2,0.5);
		maps\_lighting::create_dof_preset("lagos_van_takedown_shootout",0,60,6,214,800,2,0.5);
		maps\_lighting::create_dof_preset("lagos_underwater",0,15,3,1000,5000,0.1,0.5);
		return;
	}

	maps\_lighting::create_dof_preset("lagos_default",0,30,1,1000,7000,1.259,0.5);
	maps\_lighting::create_dof_preset("lagos_drone",0,150,3,250,800,1,0.5);
	maps\_lighting::create_dof_preset("lagos_drone_hostage",0,50,5,200,390,2,0.5);
	maps\_lighting::create_dof_preset("lagos_intro",5,35,4,400,4000,0.75,0.5);
	maps\_lighting::create_dof_preset("lagos_standard",0,20,4,1000,7000,0.5,0.5);
	maps\_lighting::create_dof_preset("lagos_government_overlook",10,40,6,350,1300,1,0.5);
	maps\_lighting::create_dof_preset("lagos_government_climb",0,20,5,25,315,1,0.5);
	maps\_lighting::create_dof_preset("lagos_government_climb_blurry",0,60,6,25,315,1,0.5);
	maps\_lighting::create_dof_preset("lagos_government_breach",0,24,5,500,1880,0.9,0.5);
	maps\_lighting::create_dof_preset("lagos_hostage_room",5,35,5,250,2500,1.75,0.5);
	maps\_lighting::create_dof_preset("lagos_roundabout_tanker",10,125,5,1000,6000,0.75,0.5);
	maps\_lighting::create_dof_preset("lagos_chase_start",65,200,5,650,1000,0.75,0.5);
	maps\_lighting::create_dof_preset("lagos_chase_buildings",0,60,1,1000,7000,1.66,0.5);
	maps\_lighting::create_dof_preset("lagos_van_takedown",0,60,5,1000,7000,1,0.5);
	maps\_lighting::create_dof_preset("lagos_van_takedown_shootout",0,60,5,214,800,1,0.5);
	maps\_lighting::create_dof_preset("lagos_underwater",0,15,2,1000,5000,0.1,0.5);
}

//Function Number: 5
setup_dof_viewmodel_presets()
{
	maps\_lighting::create_dof_viewmodel_preset("lagos_viewmodel_standard",1,12);
	maps\_lighting::create_dof_viewmodel_preset("lagos_viewmodel_harmonic_breach",0,32);
	maps\_lighting::create_dof_viewmodel_preset("lagos_viewmodel_vantakedown_shootout",0,22);
}

//Function Number: 6
setup_flickerlight_presets()
{
	maps\_lighting::create_flickerlight_preset("lagos_underwater",(0.972549,0.62451,1),(0.2,0.1462746,1),0.005,0.2,5);
}

//Function Number: 7
test_sun_flare()
{
	thread maps\_shg_fx::vfx_sunflare("lag_sun_flare");
}

//Function Number: 8
setup_lighting_intro_drone()
{
	common_scripts\utility::flag_wait("fly_drone_start");
	wait(0.5);
	level.player lightsetforplayer("lagos_intro_drone_exterior");
	level.player setclutforplayer("clut_lagos_drone",0.25);
	maps\_utility::vision_set_fog_changes("lagos_intro_drone",0.5);
	maps\_shg_fx::set_sun_flare_position((-31,-35,0));
}

//Function Number: 9
setup_lighting_intro_start()
{
	common_scripts\utility::flag_wait("intro_playerstart");
	wait(0.1);
	level.player lightsetforplayer("lagos_intro_sequence");
	level.player setclutforplayer("clut_lagos_intro_exterior",1);
	maps\_utility::vision_set_fog_changes("lagos_intro",0.1);
	maps\_shg_fx::set_sun_flare_position((-29,-60,0));
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		thread maps\_lighting::lerp_spot_intensity("intro_primary_rim",0.25,1000000);
		thread maps\_lighting::lerp_spot_intensity("intro_primary_final_rim",0.25,200000);
	}

	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("intro_primary_uplight",0.25,80000);
	}
	else
	{
		thread maps\_lighting::lerp_spot_intensity("intro_primary_uplight",0.25,140000);
	}

	var_00 = getent("initial_talking_lighting_centroid","targetname");
	var_01 = getent("under_train_lighting_centroid","targetname");
	if(level.nextgen)
	{
		var_02 = getent("intro_primary_final_rim","targetname");
		var_03 = getent("intro_primary_rim","targetname");
		var_02 setlightshadowstate("force_on");
		var_03 setlightshadowstate("force_on");
	}

	level.burke overridelightingorigin(var_00.origin);
	wait(12);
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("intro_primary_uplight",2,0);
		thread maps\_lighting::lerp_spot_intensity("intro_primary_final_rim",5,40000);
	}

	wait(6);
	level.player lightsetforplayer("lagos_intro");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
		thread maps\_lighting::lerp_spot_intensity("intro_primary_final_rim",2,0);
		thread maps\_lighting::lerp_spot_intensity("intro_primary_rim",5,0);
		var_02 = getent("intro_primary_final_rim","targetname");
		var_03 = getent("intro_primary_rim","targetname");
		var_02 setlightshadowstate("normal");
		var_03 setlightshadowstate("normal");
	}

	level.burke defaultlightingorigin();
}

//Function Number: 10
setup_lighting_government_start()
{
	common_scripts\utility::flag_wait("government_courtyard_playerstart");
	wait(0.1);
	level.player lightsetforplayer("lagos_government_building_ext");
	level.player setclutforplayer("clut_lagos_intro_exterior",1);
	maps\_utility::vision_set_fog_changes("lagos_government_building_ext",0.1);
	if(level.nextgen)
	{
	}

	maps\_shg_fx::set_sun_flare_position((-31,-35,0));
}

//Function Number: 11
setup_lighting_pre_h_breach_start()
{
	common_scripts\utility::flag_wait("pre_h_breach_playerstart");
	wait(0.1);
	level.player lightsetforplayer("lagos_government");
	level.player setclutforplayer("clut_lagos_government_interior",0.1);
	maps\_utility::vision_set_fog_changes("lagos_government_building",0.1);
	if(level.nextgen)
	{
	}

	maps\_shg_fx::set_sun_flare_position((-31,-35,0));
	thread maps\_lighting::lerp_spot_intensity("government_hostage_fill",3,20000);
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("government_window_back_02",1,250000);
		var_00 = getent("government_window_back_02","targetname");
		var_00 setlightfovrange(45,10);
	}

	common_scripts\_exploder::exploder(4007);
}

//Function Number: 12
setup_lighting_post_h_breach_start()
{
	common_scripts\utility::flag_wait("post_h_breach_playerstart");
	wait(0.1);
	level.player lightsetforplayer("lagos_government");
	level.player setclutforplayer("clut_lagos_government_interior",0.1);
	maps\_utility::vision_set_fog_changes("lagos_government_building",0.1);
	if(level.nextgen)
	{
	}

	maps\_shg_fx::set_sun_flare_position((-31,-35,0));
	thread maps\_lighting::lerp_spot_intensity("government_hostage_fill",3,20000);
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("government_window_back_02",1,250000);
		thread maps\_lighting::lerp_spot_intensity("government_building_breach_player",1,120000);
		var_00 = getent("government_window_back_02","targetname");
		var_00 setlightfovrange(45,10);
	}

	common_scripts\_exploder::exploder(4007);
	common_scripts\_exploder::exploder(4023);
}

//Function Number: 13
setup_lighting_roundabout_start()
{
	common_scripts\utility::flag_wait("roundabout_playerstart");
	wait(0.1);
	level.player lightsetforplayer("lagos_government_building_transition");
	level.player setclutforplayer("clut_lagos_intro_exterior",0.1);
	maps\_utility::vision_set_fog_changes("lagos_government_building_ext",0.1);
	if(level.nextgen)
	{
	}

	maps\_shg_fx::set_sun_flare_position((-39,-45,0));
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("government_window_back_02",1,0);
	}
}

//Function Number: 14
setup_lighting_alley1_start()
{
	common_scripts\utility::flag_wait("alley1_playerstart");
	wait(0.1);
	level.player lightsetforplayer("lagos_alley");
	level.player setclutforplayer("clut_lagos_intro_exterior",0.1);
	maps\_utility::vision_set_fog_changes("lagos_alley",0.1);
	if(level.nextgen)
	{
	}

	maps\_shg_fx::set_sun_flare_position((-39,-45,0));
}

//Function Number: 15
setup_lighting_oncoming_start()
{
	common_scripts\utility::flag_wait("oncoming_downhill_playerstart");
	wait(0.1);
	level.player lightsetforplayer("lagos_alley");
	level.player setclutforplayer("clut_lagos_intro_exterior",0.1);
	maps\_utility::vision_set_fog_changes("lagos_alley",0.1);
	if(level.nextgen)
	{
	}

	maps\_shg_fx::set_sun_flare_position((-39,-45,0));
}

//Function Number: 16
setup_lighting_alley2_start()
{
	common_scripts\utility::flag_wait("alley2_playerstart");
	wait(0.1);
	level.player lightsetforplayer("lagos_alley_rec_transition");
	level.player setclutforplayer("clut_lagos_intro_exterior",0.1);
	maps\_utility::vision_set_fog_changes("lagos_rec_yard",0.1);
	if(level.nextgen)
	{
	}

	maps\_shg_fx::set_sun_flare_position((-40,-39,0));
}

//Function Number: 17
setup_lighting_flank_start()
{
	common_scripts\utility::flag_wait("flank_playerstart");
	wait(0.1);
	level.player lightsetforplayer("lagos_alley_interiors");
	level.player setclutforplayer("clut_lagos_intro_exterior",0.1);
	maps\_utility::vision_set_fog_changes("lagos_alley_interiors",0.1);
	if(level.nextgen)
	{
	}

	maps\_shg_fx::set_sun_flare_position((-40,-39,0));
}

//Function Number: 18
setup_lighting_frogger_start()
{
	common_scripts\utility::flag_wait("frogger_playerstart");
	wait(0.1);
	level.player lightsetforplayer("lagos_frogger");
	level.player setclutforplayer("clut_lagos_frogger",0.1);
	maps\_utility::vision_set_fog_changes("lagos_traffic_crossing",0.1);
	if(level.nextgen)
	{
	}

	maps\_shg_fx::set_sun_flare_position((-40,-50,0));
}

//Function Number: 19
setup_lighting_rail_start()
{
	common_scripts\utility::flag_wait("rail_playerstart");
	wait(0.1);
	level.player lightsetforplayer("lagos_frogger");
	level.player setclutforplayer("clut_lagos_frogger",0.1);
	maps\_utility::vision_set_fog_changes("lagos_traffic_crossing",0.1);
	if(level.nextgen)
	{
	}

	maps\_shg_fx::set_sun_flare_position((-40,-39,0));
}

//Function Number: 20
setup_lighting_middle_takedown_start()
{
	common_scripts\utility::flag_wait("flag_begin_suv_takedown");
	wait(0.1);
	level.player lightsetforplayer("lagos_chase");
	level.player setclutforplayer("clut_lagos_chase",0.1);
	maps\_utility::vision_set_fog_changes("lagos_chase",0.1);
	if(level.nextgen)
	{
	}

	maps\_shg_fx::set_sun_flare_position((-40,65,0));
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
	}
}

//Function Number: 21
setup_lighting_post_middle_takedown_start()
{
	common_scripts\utility::flag_wait("flag_post_suv_takedown_lighting");
	wait(0.1);
	level.player lightsetforplayer("lagos_chase");
	level.player setclutforplayer("clut_lagos_chase",0.1);
	maps\_utility::vision_set_fog_changes("lagos_chase",0.1);
	if(level.nextgen)
	{
	}

	maps\_shg_fx::set_sun_flare_position((-40,65,0));
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
	}

	wait(0.3);
	lerpsunangles((-40,72,0),(-85,120,0),0.5);
	wait(2.2);
	lerpsunangles((-85,120,0),(-40,72,0),1);
	wait(5);
	resetsundirection();
}

//Function Number: 22
setup_lighting_van_takedown_start()
{
	common_scripts\utility::flag_wait("takedown_playerstart_lighting");
	wait(0.1);
	level.player lightsetforplayer("lagos_chase");
	level.player setclutforplayer("clut_lagos_chase_vista",0.1);
	maps\_utility::vision_set_fog_changes("lagos_chase_vista",0.1);
	if(level.nextgen)
	{
	}

	maps\_shg_fx::set_sun_flare_position((-20,80,0));
	thread ramp_up_motion_blur();
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
	}
}

//Function Number: 23
setup_lighting_underwater_start()
{
	common_scripts\utility::flag_wait("takedown_underwater_lighting");
	wait(0.1);
	level.player lightsetforplayer("lagos_underwater");
	level.player setclutforplayer("clut_lagos_chase",0.1);
	maps\_utility::vision_set_fog_changes("lagos_underwater",0.1);
	if(level.nextgen)
	{
	}

	maps\_shg_fx::set_sun_flare_position((-20,80,0));
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
	}
}

//Function Number: 24
setup_lighting_shoreline_start()
{
	common_scripts\utility::flag_wait("shore_pcap_playerstart");
	wait(0.1);
	level.player lightsetforplayer("lagos_shoreline");
	level.player setclutforplayer("clut_lagos_shoreline",0.1);
	maps\_utility::vision_set_fog_changes("lagos_shoreline",0.1);
	maps\_shg_fx::set_sun_flare_position((-20,80,0));
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
	}

	setsaveddvar("r_lightgridenabletweaks","1");
	maps\_utility::lerp_saveddvar("r_lightgridintensity",0.75,1);
}

//Function Number: 25
setup_lighting_outro_start()
{
	common_scripts\utility::flag_wait("outro_playerstart");
	wait(0.1);
	level.player lightsetforplayer("lagos_outro");
	maps\_utility::vision_set_fog_changes("lagos_outro",0.1);
	if(level.nextgen)
	{
	}

	maps\_shg_fx::set_sun_flare_position((-20,80,0));
}

//Function Number: 26
droneviewstatic()
{
	level.dronevignette = newhudelem(level.player);
	level.dronevignette.x = 0;
	level.dronevignette.y = 0;
	level.dronevignette.alpha = 0.15;
	level.dronevignette.horzalign = "fullscreen";
	level.dronevignette.vertalign = "fullscreen";
	level.dronevignette.sort = 3;
	level.dronevignette setshader("s1_railgun_hud_outer_shadow",640,480);
	common_scripts\utility::flag_wait("fly_drone_done_lighting");
	level.dronevignette destroy();
}

//Function Number: 27
setup_dof_drone()
{
	common_scripts\utility::flag_wait("fly_drone_start");
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehenable","1");
	}

	common_scripts\utility::flag_wait("flag_player_input_for_drone_start");
	wait(29);
	maps\_utility::vision_set_fog_changes("lagos_intro_drone_hostage",3);
	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(3,100);
}

//Function Number: 28
setup_lightgrid_lighting_drone()
{
	common_scripts\utility::flag_wait("fly_drone_start");
	wait(9);
	setsaveddvar("r_lightgridenabletweaks","1");
	maps\_utility::lerp_saveddvar("r_lightgridintensity",0.5,2);
	wait(18);
	maps\_utility::lerp_saveddvar("r_lightgridintensity",1,5);
	if(level.nextgen)
	{
		var_00 = getent("government_window_back_02","targetname");
		var_00 setlightshadowstate("force_on");
		common_scripts\utility::flag_wait("fly_drone_done_lighting");
		var_00 setlightshadowstate("normal");
	}
}

//Function Number: 29
setup_lighting_drone()
{
	common_scripts\utility::flag_wait("fly_drone_start");
	thread droneviewstatic();
	common_scripts\_exploder::exploder(4024);
	common_scripts\_exploder::exploder(4023);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
	}

	common_scripts\utility::flag_wait("flag_player_input_for_drone_start");
	wait(8);
	level.player lightsetforplayer("lagos_intro_drone");
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("government_window_front_01",3,2000000);
		thread maps\_lighting::lerp_spot_intensity("government_window_front_02",3,2000000);
		thread maps\_lighting::lerp_spot_intensity("government_window_front_03",3,2000000);
		thread maps\_lighting::lerp_spot_intensity("government_window_front_04",3,2000000);
		thread maps\_lighting::lerp_spot_intensity("government_window_front_05",3,2000000);
		thread maps\_lighting::lerp_spot_intensity("government_window_back_02",3,1000000);
	}

	thread maps\_lighting::lerp_spot_intensity("government_hostage_rim_01",3,25000);
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("government_hostage_fill",3,15000);
	}
	else
	{
		thread maps\_lighting::lerp_spot_intensity("government_hostage_fill",2,35000);
	}

	wait(50);
	thread maps\_lighting::lerp_spot_intensity("government_hostage_fill",5,55000);
	wait(11);
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("government_window_back_02",5,6000000);
	}

	common_scripts\utility::flag_wait("fly_drone_done_lighting");
	common_scripts\_exploder::kill_exploder(4024);
	common_scripts\_exploder::kill_exploder(4023);
	if(level.nextgen)
	{
		setsaveddvar("r_mbCameraRotationInfluence","0");
		thread maps\_lighting::lerp_spot_intensity("government_window_front_01",3,0);
		thread maps\_lighting::lerp_spot_intensity("government_window_front_02",3,0);
		thread maps\_lighting::lerp_spot_intensity("government_window_front_03",3,0);
		thread maps\_lighting::lerp_spot_intensity("government_window_front_04",3,0);
		thread maps\_lighting::lerp_spot_intensity("government_window_front_05",3,0);
		thread maps\_lighting::lerp_spot_intensity("government_window_back_02",3,0);
	}

	thread maps\_lighting::lerp_spot_intensity("government_hostage_rim_01",3,0);
	thread maps\_lighting::lerp_spot_intensity("government_hostage_fill",2,20000);
}

//Function Number: 30
setup_hostage_key_fov_tune()
{
	if(level.currentgen)
	{
		return;
	}

	var_00 = getent("government_window_back_02","targetname");
	var_01 = getent("government_hostage_rim_01","targetname");
	common_scripts\utility::flag_wait("fly_drone_start");
	wait(36);
	var_00 setlightfovrange(20,10);
	wait(16.3);
	var_01 setlightfovrange(50,40);
	wait(6);
	var_01 setlightfovrange(90,40);
	common_scripts\utility::flag_wait("fly_drone_done");
	var_00 setlightfovrange(45,10);
}

//Function Number: 31
setup_lighting_lagos_generic()
{
	var_00 = getentarray("lagos_lighting_generic_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_generic_volume();
	}
}

//Function Number: 32
setup_lighting_generic_volume()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("lagos");
		maps\_utility::vision_set_fog_changes("lagos",1);
	}
}

//Function Number: 33
setup_lighting_sunflare()
{
	var_00 = getentarray("lagos_lighting_sunflare_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_lagos_sunflare_volume();
	}
}

//Function Number: 34
setup_lighting_lagos_sunflare_volume()
{
	for(;;)
	{
		self waittill("trigger");
		common_scripts\_exploder::exploder(1025);
		while(level.player istouching(self))
		{
			wait(0.1);
		}

		common_scripts\_exploder::kill_exploder(1025);
	}
}

//Function Number: 35
setup_dof_intro()
{
	common_scripts\utility::flag_wait("intro_playerstart");
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehenable","1");
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(2,72);
		wait(2);
		level.player setphysicaldepthoffield(2.5,30);
		wait(3.5);
		level.player setphysicaldepthoffield(2,88);
		wait(6);
		level.player setphysicaldepthoffield(2,133);
		wait(4.35);
		level.player setphysicaldepthoffield(2.5,23);
		wait(1.7);
		level.player disablephysicaldepthoffieldscripting();
		wait(0.2);
	}
	else
	{
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(3.7,70);
		wait(2);
		level.player setphysicaldepthoffield(3.7,34.3);
		wait(3.5);
		level.player setphysicaldepthoffield(2.16,67);
		wait(6);
		level.player setphysicaldepthoffield(1.76,102.711);
		wait(4.35);
		level.player setphysicaldepthoffield(5.032,24.346);
		wait(1.7);
		wait(0.2);
		level.player setphysicaldepthoffield(19,5);
	}

	wait(1.7);
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehenable","0");
	}
}

//Function Number: 36
setup_lighting_lagos_intro_alley()
{
	var_00 = getentarray("lagos_intro_alley_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lagos_intro_alley_volume();
	}
}

//Function Number: 37
setup_lagos_intro_alley_volume()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("lagos_intro");
		level.player setclutforplayer("clut_lagos_intro_exterior",1);
		maps\_utility::vision_set_fog_changes("lagos_intro_alley",3);
		maps\_shg_fx::set_sun_flare_position((-29,-60,0));
	}
}

//Function Number: 38
setup_lighting_lagos_intro_alley_transition()
{
	var_00 = getentarray("lagos_intro_alley_transition_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lagos_intro_alley_transition_volume();
	}
}

//Function Number: 39
setup_lagos_intro_alley_transition_volume()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("lagos_intro");
		level.player setclutforplayer("clut_lagos_intro_exterior",3);
		maps\_utility::vision_set_fog_changes("lagos_intro_alley_transition",3);
	}
}

//Function Number: 40
setup_lighting_lagos_intro_interiors()
{
	var_00 = getentarray("lagos_intro_interiors_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lagos_intro_interiors_volume();
	}
}

//Function Number: 41
setup_lagos_intro_interiors_volume()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("lagos_intro_interiors");
		level.player setclutforplayer("clut_lagos_intro_exterior",3);
		maps\_utility::vision_set_fog_changes("lagos_intro_interiors",3);
		maps\_shg_fx::set_sun_flare_position((-31,-35,0));
		if(level.nextgen)
		{
			thread maps\_lighting::lerp_spot_intensity("government_window_front_01",1,0);
			thread maps\_lighting::lerp_spot_intensity("government_window_front_02",1,0);
			thread maps\_lighting::lerp_spot_intensity("government_window_front_03",1,0);
			thread maps\_lighting::lerp_spot_intensity("government_window_front_04",1,0);
			thread maps\_lighting::lerp_spot_intensity("government_window_front_05",1,0);
		}
	}
}

//Function Number: 42
setup_lighting_government_overlook_door()
{
	var_00 = getent("lighting_centroid_overlook_door","targetname");
	var_01 = getent("lighting_centroid_overlook_door_exterior","targetname");
	var_02 = getent("lighting_reflection_overlook_door_exterior","targetname");
	var_03 = getent("exo_door_model","targetname");
	var_03 overridelightingorigin(var_00.origin);
	common_scripts\utility::flag_wait("exo_door_lighting");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
	}

	wait(2.75);
	var_03 overridelightingorigin(var_01.origin);
	var_03 overridereflectionprobe(var_02.origin);
	common_scripts\utility::flag_set("exo_door_lighting_complete");
	wait(3);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_mbCameraRotationInfluence","0");
	}
}

//Function Number: 43
setup_lighting_lagos_intro_post_exo_interiors()
{
	var_00 = getentarray("lagos_intro_interiors_post_exo_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lagos_intro_interiors_post_exo_volume();
	}
}

//Function Number: 44
setup_lagos_intro_interiors_post_exo_volume()
{
	for(;;)
	{
		self waittill("trigger");
		common_scripts\utility::flag_wait("exo_door_lighting_complete");
		common_scripts\_exploder::exploder(2032);
		level.player lightsetforplayer("lagos_intro_interiors_post_exo");
		level.player setclutforplayer("clut_lagos_intro_exterior",3);
		maps\_utility::vision_set_fog_changes("lagos_intro_interiors",3);
		maps\_shg_fx::set_sun_flare_position((-31,-35,0));
		if(level.nextgen)
		{
			thread maps\_lighting::lerp_spot_intensity("government_window_front_01",1,0);
			thread maps\_lighting::lerp_spot_intensity("government_window_front_02",1,0);
			thread maps\_lighting::lerp_spot_intensity("government_window_front_03",1,0);
			thread maps\_lighting::lerp_spot_intensity("government_window_front_04",1,0);
			thread maps\_lighting::lerp_spot_intensity("government_window_front_05",1,0);
		}
	}
}

//Function Number: 45
setup_lighting_government_overlook()
{
	var_00 = getentarray("lagos_government_overlook_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_government_overlook_volume();
	}
}

//Function Number: 46
setup_lighting_government_overlook_volume()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("lagos_government_building_ext");
		level.player setclutforplayer("clut_lagos_intro_exterior",4);
		maps\_utility::vision_set_fog_changes("lagos_government_building_ext",4);
	}
}

//Function Number: 47
setup_dof_government_overlook()
{
	common_scripts\utility::flag_wait("exo_door_lighting");
	level.player enablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehenable","1");
	}

	level.player setphysicaldepthoffield(1.2,47);
	wait(3.75);
	if(level.nextgen)
	{
		level.player disablephysicaldepthoffieldscripting();
		setsaveddvar("r_dof_physical_bokehenable","0");
		return;
	}

	level.player setphysicaldepthoffield(19,5);
}

//Function Number: 48
setup_government_rpg_explosion_lighting()
{
	common_scripts\utility::flag_wait("exo_door_lighting");
	common_scripts\utility::flag_wait("government_rpg_lighting");
	level.player lightsetforplayer("lagos_roundabout_tanker_explosion");
	maps\_utility::vision_set_fog_changes("lagos_roundabout_tanker_explosion",0.08);
	wait(0.15);
	level.player lightsetforplayer("lagos_government_building_ext");
	maps\_utility::vision_set_fog_changes("lagos_government_building_ext",0.75);
}

//Function Number: 49
setup_government_rpg_explosion_dof()
{
	common_scripts\utility::flag_wait("exo_door_lighting");
	common_scripts\utility::flag_wait("government_rpg_lighting");
	wait(2);
}

//Function Number: 50
setup_lighting_railwalk()
{
	var_00 = getentarray("lagos_railwalk_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_railwalk_volume();
	}
}

//Function Number: 51
setup_lighting_railwalk_volume()
{
	for(;;)
	{
		self waittill("trigger");
		common_scripts\utility::flag_wait("exo_door_lighting_complete");
		level.player lightsetforplayer("lagos_railwalk");
		while(level.player istouching(self))
		{
			wait(0.1);
		}

		level.player lightsetforplayer("lagos_government_building_ext");
	}
}

//Function Number: 52
setup_government_climb_sunlerp()
{
	common_scripts\utility::flag_wait("climb_begin_lighting");
	common_scripts\_exploder::kill_exploder(2032);
	wait(6.9);
	lerpsunangles((-55,-15,0),(-55,-82,0),1);
	common_scripts\utility::flag_wait("climb_ending_lighting");
	lerpsunangles((-55,-82,0),(-40,-115,0),5);
}

//Function Number: 53
setup_lighting_override_exo_wallclimb()
{
	common_scripts\utility::flag_wait("climb_begin_lighting");
	var_00 = getent("lighting_centroid_overlook_door_exterior","targetname");
	var_01 = getent("lighting_reflection_overlook_door_exterior","targetname");
	var_02 = level.exo_climb_rig;
	var_02 overridelightingorigin(var_00.origin);
	var_02 overridereflectionprobe(var_01.origin);
	common_scripts\utility::flag_wait("climb_ending_lighting");
	var_02 defaultlightingorigin();
	var_02 defaultreflectionprobe();
}

//Function Number: 54
setup_dof_government_climb()
{
	common_scripts\utility::flag_wait("climb_begin_lighting");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
	}

	level.player lightsetforplayer("lagos_wall_climb");
	if(level.nextgen)
	{
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(2,95);
		wait(7.65);
		level.player setphysicaldepthoffield(4.5,11);
		setsaveddvar("r_dof_physical_bokehenable",1);
		wait(6);
		level.player setphysicaldepthoffield(8,16);
		common_scripts\utility::flag_wait("climb_ending_lighting");
		wait(1.5);
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
		wait(0.3);
		level.player setphysicaldepthoffield(2,13,20,20);
		wait(1);
		level.player setphysicaldepthoffield(2,27,20,20);
		wait(1.25);
		level.player setphysicaldepthoffield(2,18,20,20);
		wait(1);
		level.player setphysicaldepthoffield(2,109,20,20);
		wait(2);
		setsaveddvar("r_dof_physical_bokehenable",0);
		level.player disablephysicaldepthoffieldscripting();
	}
	else
	{
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(2,95);
		wait(7.65);
		level.player setphysicaldepthoffield(4.5,11);
		wait(6);
		level.player setphysicaldepthoffield(8,16);
		common_scripts\utility::flag_wait("climb_ending_lighting");
		wait(1.5);
		wait(0.3);
		level.player setphysicaldepthoffield(3.75,12.55,20,20);
		wait(1);
		level.player setphysicaldepthoffield(2,32,20,20);
		wait(1.25);
		level.player setphysicaldepthoffield(2,18,20,20);
		wait(1);
		level.player setphysicaldepthoffield(2,109,20,20);
		wait(2);
		level.player setphysicaldepthoffield(19,5);
	}

	level.player lightsetforplayer("lagos_government_rooftop");
	wait(0.5);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_mbCameraRotationInfluence","0");
	}

	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("government_window_front_01",1,2000000);
		thread maps\_lighting::lerp_spot_intensity("government_window_front_02",1,2000000);
		thread maps\_lighting::lerp_spot_intensity("government_window_front_03",1,2000000);
		thread maps\_lighting::lerp_spot_intensity("government_window_front_04",1,2000000);
		thread maps\_lighting::lerp_spot_intensity("government_window_front_05",1,2000000);
		thread maps\_lighting::lerp_spot_intensity("government_window_back_02",1,250000);
		common_scripts\_exploder::exploder(3056);
		common_scripts\_exploder::exploder(4007);
	}
}

//Function Number: 55
setup_lighting_government_breach()
{
	common_scripts\utility::flag_wait("gov_breach_start_lighting");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
	}

	level.player lightsetforplayer("lagos_government_breach");
	wait(11.75);
	lerpsunangles((-40,-115,0),(-55,-15,0),1);
	wait(0.25);
	resetsundirection();
	wait(3);
	level.player lightsetforplayer("lagos_government");
	level.player setclutforplayer("clut_lagos_government_interior",4);
	maps\_utility::vision_set_fog_changes("lagos_government_building",4);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_mbCameraRotationInfluence","0");
	}
}

//Function Number: 56
setup_dof_government_breach()
{
	common_scripts\utility::flag_wait("gov_breach_start_lighting");
	wait(2);
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehenable",1);
	}

	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(1.2,106);
	wait(4);
	level.player setphysicaldepthoffield(1.2,67);
	wait(10);
	if(level.nextgen)
	{
		level.player disablephysicaldepthoffieldscripting();
		setsaveddvar("r_dof_physical_bokehenable",0);
		return;
	}

	level.player setphysicaldepthoffield(19,5);
}

//Function Number: 57
setup_lighting_government()
{
	var_00 = getentarray("lagos_government_lighting_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_government_volume();
	}
}

//Function Number: 58
setup_lighting_government_volume()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("lagos_government");
		maps\_utility::vision_set_fog_changes("lagos_government_building",4);
	}
}

//Function Number: 59
setup_lighting_harmonic_breach()
{
	common_scripts\utility::flag_wait("begin_harmonic_breach_lighting");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
		thread maps\_lighting::lerp_spot_intensity("government_building_breach_friendly",1,100000);
		thread maps\_lighting::lerp_spot_intensity("government_building_breach_player",1,500000);
	}

	wait(11);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_mbCameraRotationInfluence","0");
		thread maps\_lighting::lerp_spot_intensity("government_building_breach_player",1,1000);
		common_scripts\utility::flag_wait("harmonic_complete_lighting");
		thread maps\_lighting::lerp_spot_intensity("government_building_breach_player",1,200000);
		common_scripts\_exploder::exploder(4023);
	}
}

//Function Number: 60
setup_lighting_harmonic_breach_hud()
{
	common_scripts\utility::flag_wait("begin_harmonic_breach_lighting");
	wait(12.6);
	level.player lightsetforplayer("lagos_breach_hud_bright");
	wait(0.35);
	level.player lightsetforplayer("lagos_breach_hud");
	common_scripts\utility::flag_wait("harmonic_complete_lighting");
	wait(0.75);
	level.player lightsetforplayer("lagos_breach_hud_bright");
	wait(0.35);
	level.player lightsetforplayer("lagos_government");
}

//Function Number: 61
setup_lighting_harmonic_breach_dof()
{
	common_scripts\utility::flag_wait("begin_harmonic_breach_lighting");
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehenable",1);
	}

	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(2,16.1);
	wait(3.15);
	level.player setphysicaldepthoffield(2,142.5,20,20);
	wait(4.5);
	level.player setphysicaldepthoffield(2,16.1,20,20);
	wait(0.75);
	level.player setphysicaldepthoffield(2,23.7,20,20);
	wait(0.75);
	level.player setphysicaldepthoffield(2,13.2,20,20);
	wait(0.75);
	level.player setphysicaldepthoffield(2,20.9,20,20);
	wait(1.25);
	level.player setphysicaldepthoffield(22,100,20,20);
	common_scripts\utility::flag_wait("harmonic_complete_lighting");
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehenable",0);
		level.player disablephysicaldepthoffieldscripting();
	}
	else
	{
		level.player setphysicaldepthoffield(19,5);
	}

	wait(0.25);
}

//Function Number: 62
setup_lighting_government_hostage()
{
	var_00 = getentarray("lagos_government_hostage_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_government_hostage_volume();
	}
}

//Function Number: 63
setup_lighting_government_hostage_volume()
{
	for(;;)
	{
		self waittill("trigger");
		if(level.nextgen)
		{
			level.player lightsetforplayer("lagos_hostage_room");
			maps\_utility::vision_set_fog_changes("lagos_hostage_room",4);
			level.player setclutforplayer("clut_lagos_conference_room",4);
			thread maps\_lighting::lerp_spot_intensity("government_window_back_02",1,250000);
		}

		thread maps\_lighting::lerp_spot_intensity("government_hostage_fill",3,20000);
		if(level.nextgen)
		{
			setsaveddvar("r_dof_physical_hipfstop",5);
		}
	}
}

//Function Number: 64
setup_lighting_hostage_release()
{
	common_scripts\utility::flag_wait("hostage_release_lighting");
	var_00 = getent("government_hostage_fill","targetname");
	var_00 setlightfovrange(90,50);
	thread maps\_lighting::lerp_spot_intensity("government_hostage_fill",4,10000);
	if(level.nextgen)
	{
	}

	wait(28);
	if(level.nextgen)
	{
	}

	thread maps\_lighting::lerp_spot_intensity("government_hostage_fill",3,20000);
}

//Function Number: 65
setup_dof_hostage_release()
{
	common_scripts\utility::flag_wait("hostage_release_lighting");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
	}

	if(level.nextgen)
	{
		level.player enablephysicaldepthoffieldscripting();
		wait(0.5);
		level.player setphysicaldepthoffield(2,13.75);
		wait(2);
		level.player setphysicaldepthoffield(2.6,36);
		wait(7.25);
		level.player setphysicaldepthoffield(2.6,102.5);
		wait(10);
		level.player setphysicaldepthoffield(2.6,46);
		wait(7);
		level.player disablephysicaldepthoffieldscripting();
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_mbCameraRotationInfluence","0");
	}
	else
	{
		level.player enablephysicaldepthoffieldscripting();
		wait(0.5);
		level.player setphysicaldepthoffield(2,13.75);
		wait(2);
		level.player setphysicaldepthoffield(2.6,36);
		wait(7.25);
		level.player setphysicaldepthoffield(2.6,102.5);
		wait(10);
		level.player setphysicaldepthoffield(2.6,46);
		wait(7);
		level.player setphysicaldepthoffield(19,5);
	}

	wait(0.5);
}

//Function Number: 66
setup_lighting_government_ext()
{
	var_00 = getentarray("lagos_government_ext_lighting_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_government_ext_volume();
	}
}

//Function Number: 67
setup_lighting_government_ext_volume()
{
	for(;;)
	{
		self waittill("trigger");
		maps\_utility::vision_set_fog_changes("lagos_government_building_ext",4);
		level.player setclutforplayer("clut_lagos_intro_exterior",4);
		if(level.nextgen)
		{
			thread maps\_lighting::lerp_spot_intensity("government_window_back_02",1,0);
		}

		common_scripts\_exploder::kill_exploder(4007);
		maps\_utility::lerp_saveddvar("r_lightgridintensity",1,2);
		if(level.nextgen)
		{
			setsaveddvar("r_dof_physical_hipfstop",2);
		}
	}
}

//Function Number: 68
setup_lighting_lobby()
{
	var_00 = getentarray("lagos_lobby_lighting_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_lobby_volume();
	}
}

//Function Number: 69
setup_lighting_lobby_volume()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("lagos_lobby");
		maps\_utility::vision_set_fog_changes("lagos_lobby",4);
		level.player setclutforplayer("clut_lagos_intro_exterior",4);
		setsaveddvar("r_lightgridenabletweaks","1");
		maps\_utility::lerp_saveddvar("r_lightgridintensity",1.75,2);
	}
}

//Function Number: 70
setup_lighting_roundabout_transition()
{
	var_00 = getentarray("lagos_roundabout_transition_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_roundabout_transition_volume();
	}
}

//Function Number: 71
setup_lighting_roundabout_transition_volume()
{
	for(;;)
	{
		self waittill("trigger");
		maps\_utility::vision_set_fog_changes("lagos_roundabout",2);
		level.player lightsetforplayer("lagos_roundabout");
		level.player setclutforplayer("clut_lagos_roundabout",6);
		maps\_utility::lerp_saveddvar("r_lightgridintensity",1,2);
	}
}

//Function Number: 72
setup_lighting_roundabout()
{
	var_00 = getentarray("lagos_roundabout_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_roundabout_volume();
	}
}

//Function Number: 73
setup_lighting_roundabout_volume()
{
	for(;;)
	{
		self waittill("trigger");
		maps\_utility::vision_set_fog_changes("lagos_roundabout",2);
		level.player lightsetforplayer("lagos_roundabout");
		level.player setclutforplayer("clut_lagos_roundabout",6);
	}
}

//Function Number: 74
setup_lighting_initial_rpgs()
{
	common_scripts\utility::flag_wait("roundabout_RPG_start");
	wait(0.95);
	common_scripts\_exploder::kill_exploder(4023);
	level.player lightsetforplayer("lagos_roundabout_tanker_explosion");
	level.player setclutforplayer("clut_lagos_explosion",0.15);
	maps\_utility::vision_set_fog_changes("lagos_roundabout_tanker_explosion",0.08);
	wait(2);
	level.player lightsetforplayer("lagos_roundabout");
	level.player setclutforplayer("clut_lagos_roundabout",4);
	maps\_utility::vision_set_fog_changes("lagos_roundabout",0.5);
}

//Function Number: 75
setup_dof_roundabout_tanker_explosion()
{
	common_scripts\utility::flag_wait("roundabout_tanker_flash");
	wait(3);
}

//Function Number: 76
setup_lighting_tanker_aftermath()
{
	var_00 = getentarray("tanker_explosion_aftermath_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_tanker_aftermath_volume();
		var_02 thread setup_lighting_tanker_aftermath_cleanup();
	}
}

//Function Number: 77
setup_lighting_tanker_aftermath_volume()
{
	for(;;)
	{
		self waittill("trigger");
		common_scripts\utility::flag_wait("tanker_explosion_done");
		maps\_utility::vision_set_fog_changes("lagos_roundabout_tanker_aftermath",2);
		while(level.player istouching(self))
		{
			wait(0.1);
		}

		maps\_utility::vision_set_fog_changes("lagos_roundabout",5);
	}
}

//Function Number: 78
setup_lighting_tanker_aftermath_cleanup()
{
	for(;;)
	{
		self waittill("trigger");
		common_scripts\utility::flag_wait("kill_roundabout_flames");
		maps\_utility::vision_set_fog_changes("lagos_roundabout",2);
	}
}

//Function Number: 79
setup_lighting_alley()
{
	var_00 = getentarray("lagos_alley_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_alley_volume();
	}
}

//Function Number: 80
setup_lighting_alley_volume()
{
	for(;;)
	{
		self waittill("trigger");
		maps\_utility::vision_set_fog_changes("lagos_alley",2);
		level.player lightsetforplayer("lagos_alley");
		level.player setclutforplayer("clut_lagos_intro_exterior",4);
	}
}

//Function Number: 81
setup_lighting_alley_interiors()
{
	var_00 = getentarray("lagos_alley_interiors_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_alley_interiors_volume();
	}
}

//Function Number: 82
setup_lighting_alley_interiors_volume()
{
	for(;;)
	{
		self waittill("trigger");
		maps\_utility::vision_set_fog_changes("lagos_alley_interiors",2);
		level.player lightsetforplayer("lagos_alley_interiors");
		level.player setclutforplayer("clut_lagos_intro_exterior",2);
	}
}

//Function Number: 83
setup_motion_blur_oncoming()
{
	common_scripts\utility::flag_wait("alley_oncoming_gate_lighting");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbvelocityscalar",".75");
	}

	common_scripts\utility::flag_wait("alley_oncoming_truck_lighting");
	wait(18);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_mbvelocityscalar","1");
	}
}

//Function Number: 84
setup_lighting_rec_yard_transition()
{
	var_00 = getentarray("lagos_rec_yard_transition_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_rec_yard_transition_volume();
	}
}

//Function Number: 85
setup_lighting_rec_yard_transition_volume()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("lagos_alley_rec_transition");
	}
}

//Function Number: 86
setup_lighting_rec_yard()
{
	var_00 = getentarray("lagos_rec_yard_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_rec_yard_volume();
	}
}

//Function Number: 87
setup_lighting_rec_yard_volume()
{
	for(;;)
	{
		self waittill("trigger");
		maps\_utility::vision_set_fog_changes("lagos_rec_yard",2);
		level.player lightsetforplayer("lagos_alley");
		level.player setclutforplayer("clut_lagos_intro_exterior",4);
	}
}

//Function Number: 88
setup_lighting_marketplace()
{
	var_00 = getentarray("lagos_marketplace_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_marketplace_volume();
	}
}

//Function Number: 89
setup_lighting_marketplace_volume()
{
	for(;;)
	{
		self waittill("trigger");
		if(level.nextgen)
		{
			setsaveddvar("r_mbEnable","0");
		}

		maps\_utility::vision_set_fog_changes("lagos_alley",2);
		level.player lightsetforplayer("lagos_alley");
		level.player setclutforplayer("clut_lagos_intro_exterior",10);
	}
}

//Function Number: 90
setup_lighting_marketplace_interiors()
{
	var_00 = getentarray("lagos_marketplace_interiors_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_marketplace_interiors_volume();
	}
}

//Function Number: 91
setup_lighting_marketplace_interiors_volume()
{
	for(;;)
	{
		self waittill("trigger");
		maps\_utility::vision_set_fog_changes("lagos_alley_interiors",2);
		level.player lightsetforplayer("lagos_alley_interiors");
		level.player setclutforplayer("clut_lagos_intro_exterior",2);
	}
}

//Function Number: 92
setup_flank_wall_climb_lighting()
{
	common_scripts\utility::flag_wait("flag_exo_climbing_enabled");
	level.player lightsetforplayer("lagos_wall_climb");
	level.player enablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
		setsaveddvar("r_dof_physical_bokehenable",1);
	}

	level.player setphysicaldepthoffield(8,16);
}

//Function Number: 93
setup_flank_wall_climb_lighting_complete()
{
	wait(5);
	level.player lightsetforplayer("lagos_frogger");
	level.player setclutforplayer("clut_lagos_frogger",0.1);
	maps\_utility::vision_set_fog_changes("lagos_traffic_crossing",0.1);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_mbCameraRotationInfluence","0");
		setsaveddvar("r_dof_physical_bokehenable",0);
		wait(1);
		level.player disablephysicaldepthoffieldscripting();
		return;
	}

	level.player setphysicaldepthoffield(19,5);
}

//Function Number: 94
setup_lighting_traffic_crossing()
{
	var_00 = getentarray("lagos_traffic_crossing_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_traffic_crossing_volume();
	}
}

//Function Number: 95
setup_lighting_traffic_crossing_volume()
{
	for(;;)
	{
		self waittill("trigger");
		if(level.nextgen)
		{
			setsaveddvar("r_mbEnable","2");
		}

		level.player lightsetforplayer("lagos_frogger");
		level.player setclutforplayer("clut_lagos_frogger",2);
		maps\_utility::vision_set_fog_changes("lagos_traffic_crossing",2);
	}
}

//Function Number: 96
setup_lighting_chase_start()
{
	var_00 = getentarray("lagos_chase_start_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_chase_start_volume();
	}
}

//Function Number: 97
setup_lighting_chase_start_volume()
{
	for(;;)
	{
		self waittill("trigger");
		common_scripts\utility::flag_set("chase_lighting");
		level.player lightsetforplayer("lagos_first_jump_chase_landing");
		level.player setclutforplayer("clut_lagos_chase",1);
		maps\_utility::vision_set_fog_changes("lagos_chase_tunnel_ent",2);
		wait(3);
		level.player lightsetforplayer("lagos_chase");
	}
}

//Function Number: 98
setup_motion_blur_chase_start()
{
	common_scripts\utility::flag_wait("traffic_ledge_lighting");
	level.player lightsetforplayer("lagos_pre_chase_jump");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
	}
}

//Function Number: 99
setup_lighting_chase_tunnel_transition()
{
	var_00 = getentarray("lagos_chase_tunnel_transition_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_chase_tunnel_transition_volume();
	}
}

//Function Number: 100
setup_lighting_chase_tunnel_transition_volume()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("lagos_chase_tunnel_transition");
	}
}

//Function Number: 101
setup_lighting_chase_tunnel()
{
	var_00 = getentarray("lagos_chase_tunnel_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_chase_tunnel_volume();
	}
}

//Function Number: 102
setup_lighting_chase_tunnel_volume()
{
	for(;;)
	{
		self waittill("trigger");
		maps\_utility::vision_set_fog_changes("lagos_chase_tunnel",5);
		level.player lightsetforplayer("lagos_chase_tunnel");
		level.player setclutforplayer("clut_lagos_tunnel",2);
		maps\_shg_fx::set_sun_flare_position((-20,80,0));
		while(level.player istouching(self))
		{
			wait(0.1);
		}

		maps\_utility::vision_set_fog_changes("lagos_chase",1);
		level.player lightsetforplayer("lagos_chase");
		level.player setclutforplayer("clut_lagos_chase",2);
		maps\_shg_fx::set_sun_flare_position((-40,65,0));
	}
}

//Function Number: 103
setup_lighting_suv_takedown()
{
	common_scripts\utility::flag_wait("suv_takedown_lighting");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
	}

	common_scripts\utility::flag_wait("suv_takedown_shoot_lighting");
	wait(7);
	common_scripts\utility::flag_wait("suv_takedown_dodge_lighting");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
	}

	common_scripts\utility::flag_wait("suv_takedown_jump_lighting");
	wait(1);
	level.player lightsetforplayer("lagos_chase_suv_punch");
	lerpsunangles((-40,72,0),(-85,120,0),0.5);
	wait(4);
	lerpsunangles((-85,120,0),(-40,72,0),0.5);
	wait(1);
	resetsundirection();
	common_scripts\utility::flag_wait("suv_takedown_windshield_lighting");
	common_scripts\utility::flag_wait("suv_takedown_jump2_lighting");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
	}

	level.player lightsetforplayer("lagos_chase");
	wait(0.3);
	lerpsunangles((-40,72,0),(-85,120,0),0.5);
	wait(2.2);
	lerpsunangles((-85,120,0),(-40,72,0),1);
	wait(5);
	resetsundirection();
}

//Function Number: 104
setup_lighting_chase_buildings()
{
	var_00 = getentarray("lagos_chase_buildings_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_chase_buildings_volume();
	}
}

//Function Number: 105
setup_lighting_chase_buildings_volume()
{
	for(;;)
	{
		self waittill("trigger");
		maps\_utility::vision_set_fog_changes("lagos_chase",4);
		level.player lightsetforplayer("lagos_chase");
		level.player setclutforplayer("clut_lagos_chase_vista",2);
		while(level.player istouching(self))
		{
			wait(0.1);
		}

		maps\_utility::vision_set_fog_changes("lagos_chase_vista",5);
		level.player lightsetforplayer("lagos_chase");
		level.player setclutforplayer("clut_lagos_chase_vista",2);
	}
}

//Function Number: 106
ramp_down_motion_blur()
{
	setsaveddvar("r_mbvelocityscalar",0.4);
}

//Function Number: 107
ramp_up_motion_blur()
{
	wait(0.5);
	setsaveddvar("r_mbvelocityscalar",1);
}

//Function Number: 108
setup_lighting_van_takedown()
{
	common_scripts\utility::flag_wait("flag_highway_final_takedown_started");
	level.player lightsetforplayer("lagos_chase");
	level.player setclutforplayer("clut_lagos_chase_vista",1);
	maps\_utility::vision_set_fog_changes("lagos_chase_vista",2);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
	}

	common_scripts\utility::flag_wait("van_takedown_hold_lighting");
	common_scripts\utility::flag_wait("van_takedown_shoot_lighting");
	common_scripts\utility::flag_wait("van_takedown_impact_lighting");
	wait(13.9);
	level.player lightsetforplayer("lagos_underwater_impact");
}

//Function Number: 109
setup_dof_van_takedown()
{
	common_scripts\utility::flag_wait("flag_takedown_kva_van");
}

//Function Number: 110
setup_lighting_underwater()
{
	var_00 = getentarray("lagos_underwater_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_underwater_volume();
	}
}

//Function Number: 111
setup_lighting_underwater_volume()
{
	for(;;)
	{
		self waittill("trigger");
		common_scripts\utility::flag_set("underwater_lighting");
		level.player lightsetforplayer("lagos_underwater");
		level.player setclutforplayer("clut_lagos_chase",0.25);
		maps\_utility::vision_set_fog_changes("lagos_underwater",0.25);
	}
}

//Function Number: 112
setup_underwater_dof()
{
	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(0.73,65);
	common_scripts\utility::flag_wait("van_door_open_lighting");
	level.player setphysicaldepthoffield(1.78,39);
}

//Function Number: 113
setup_lighting_underwater_sunlerp()
{
	common_scripts\utility::flag_wait("underwater_lighting");
	if(level.currentgen)
	{
		thread setup_underwater_dof();
	}

	lerpsunangles((-40,72,0),(-30,0,0),1);
	common_scripts\utility::flag_wait("van_door_open_lighting");
	wait(5);
	lerpsunangles((-30,0,0),(-40,52,0),1);
	wait(4);
	lerpsunangles((-40,52,0),(-79,-66,0),0.05);
	maps\_utility::vision_set_fog_changes("lagos_underwater_swim_to_surface",3);
}

//Function Number: 114
setup_lighting_underwater_lights()
{
	common_scripts\utility::flag_wait("underwater_lighting");
	thread maps\_lighting::lerp_spot_intensity("underwater_omni",1,0);
	maps\_lighting::play_flickerlight_preset("static_screen","underwater_key_light_01",10000000);
	common_scripts\_exploder::exploder(16032);
	common_scripts\utility::flag_wait("van_door_open_lighting");
	wait(6.5);
	thread maps\_utility::sun_light_fade((13,13,13),(1,1,1),1);
	wait(3);
	thread maps\_utility::sun_light_fade((1,1,1),(13,13,13),1);
	wait(1);
	resetsunlight();
	thread maps\_lighting::lerp_spot_intensity("underwater_omni",2,2000000000);
	maps\_lighting::play_flickerlight_preset("static_screen","underwater_omni",2000000000);
}

//Function Number: 115
setup_lighting_shoreline()
{
	common_scripts\utility::flag_wait("shoreline_lighting");
	resetsundirection();
	thread maps\_lighting::lerp_spot_intensity("underwater_omni",1,0);
	level.player lightsetforplayer("lagos_shoreline");
	level.player setclutforplayer("clut_lagos_shoreline",2);
	maps\_utility::vision_set_fog_changes("lagos_shoreline",0.5);
	var_00 = getent("shoreline_rim","targetname");
	var_00 setlightfovrange(27,5);
	thread maps\_lighting::lerp_spot_intensity("shoreline_rim",0.25,250000);
	thread maps\_lighting::lerp_spot_intensity("shoreline_omni_fill",0.25,35000);
	thread maps\_lighting::lerp_spot_color("shoreline_omni_fill",0.015,(0.5,0.6,1));
}

//Function Number: 116
setup_dof_shoreline()
{
	common_scripts\utility::flag_wait("shoreline_lighting");
	if(level.nextgen)
	{
		level.player enablephysicaldepthoffieldscripting();
		setsaveddvar("r_dof_physical_bokehenable",1);
		level.player setphysicaldepthoffield(2.5,23,20,20);
		wait(5.35);
		level.player setphysicaldepthoffield(2.5,40,20,20);
		wait(2);
		level.player setphysicaldepthoffield(2.5,78,20,20);
		wait(1);
		level.player setphysicaldepthoffield(2.5,40,20,20);
		wait(2);
		level.player setphysicaldepthoffield(2.5,60,20,20);
		wait(1);
		level.player setphysicaldepthoffield(2.5,78,20,20);
		wait(2);
		level.player setphysicaldepthoffield(2.5,40,20,20);
		wait(4.25);
		level.player setphysicaldepthoffield(2.5,90,20,20);
		wait(3.5);
		level.player setphysicaldepthoffield(2.5,40,20,20);
		wait(5.35);
		level.player setphysicaldepthoffield(2.5,23,20,20);
		wait(0.15);
		level.player setphysicaldepthoffield(2.5,13,20,20);
		wait(0.6);
		level.player setphysicaldepthoffield(2.5,60,20,20);
		return;
	}

	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(3.86,25.48);
	wait(5.35);
	level.player setphysicaldepthoffield(3.55,33);
	wait(5);
	level.player setphysicaldepthoffield(3.37,40.48);
	wait(7.25);
	level.player setphysicaldepthoffield(3.37,40.48);
	wait(4.5);
	level.player setphysicaldepthoffield(3.55,33,20,20);
	wait(1.65);
	level.player setphysicaldepthoffield(3.33,22.7,20,20);
	wait(2.5);
	level.player setphysicaldepthoffield(3.65,23,20,20);
	wait(1);
	level.player setphysicaldepthoffield(2,60,20,20);
	level.player setphysicaldepthoffield(19,5);
}

//Function Number: 117
setup_lighting_outro()
{
	var_00 = getentarray("lagos_outro_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_outro_volume();
	}
}

//Function Number: 118
setup_lighting_outro_volume()
{
	for(;;)
	{
		self waittill("trigger");
		maps\_utility::vision_set_fog_changes("lagos_outro",1);
		level.player lightsetforplayer("lagos_outro");
	}
}