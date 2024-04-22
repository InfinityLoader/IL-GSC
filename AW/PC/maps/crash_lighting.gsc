/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: crash_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 30
 * Decompile Time: 464 ms
 * Timestamp: 4/22/2024 2:27:17 AM
*******************************************************************/

//Function Number: 1
main()
{
	thread crash_dof_presets();
	thread setup_crash_flicker_presets();
	thread setup_crash_light_motions();
	thread crash_set_level_lighting_values();
	thread crash_lighting_skyjack_setup();
	thread crash_lighting_crash_site();
	thread crash_lighting_plane_fire();
	thread crash_lighting_crash_site_dof();
	thread crash_lighting_entry_dof();
	thread crash_lighting_drone_hall();
	thread crash_lighting_ice_caves_01();
	thread crash_lighting_goliath_dof();
	thread crash_lighting_post_goliath_fall();
	thread crash_lighting_ice_caves_02();
	thread ice_caves_02_trigger();
	thread ice_caves_03_trigger();
	thread crash_lighting_overlook();
	thread crash_overlook_trigger();
	thread crash_overlook_sunflare();
	thread crash_lighting_underground_lake();
	thread crash_lighting_lake_cinema();
}

//Function Number: 2
crash_dof_presets()
{
	if(level.nextgen)
	{
		maps\_lighting::create_dof_preset("crash_skyjack_01",10,60,0.2,1000,8000,0.8,0.5);
		maps\_lighting::create_dof_preset("crash_crash_site",10,60,0.2,9000,24000,1,0.5);
		maps\_lighting::create_dof_preset("crash_site_entry",10,60,0.2,0,712,4.6,0.5);
		maps\_lighting::create_dof_preset("crash_drone_hall",10,60,0.2,0,480,2,0.5);
		maps\_lighting::create_dof_preset("crash_ice_caves_01",10,60,0.2,15,1500,2,0.5);
		maps\_lighting::create_dof_preset("crash_goliath_fight",10,60,0.2,15,800,6.5,0.5);
		maps\_lighting::create_dof_preset("crash_ice_caves_02",10,60,0.2,15,1800,2.48,0.5);
		maps\_lighting::create_dof_preset("crash_overlook",10,60,0.2,0,3200,0.9,0.5);
		maps\_lighting::create_dof_preset("crash_underground_lake",10,60,0.2,4562,28504,1.7,0.5);
		maps\_lighting::create_dof_preset("crash_avalanche_01",10,60,0.2,0,1024,3,0.5);
		maps\_lighting::create_dof_preset("crash_avalanche_02",10,60,0.2,9000,24000,1,0.5);
	}
}

//Function Number: 3
setup_crash_flicker_presets()
{
	maps\_lighting::create_flickerlight_preset("engine_1",(1,0.85,0.58),(1,0.94,0.58),0.005,0.2,100000);
	maps\_lighting::create_flickerlight_preset("engine_2",(1,0.85,0.58),(1,0.94,0.58),0.005,0.2,100000);
	maps\_lighting::create_flickerlight_preset("plane_crash_fire",(1,0.29,0.29),(1,0.59,0.28),0.005,0.2,15000);
	maps\_lighting::create_flickerlight_preset("plane_crash_fire_main",(1,0.29,0.29),(1,0.8,0.28),0.005,0.2,15000);
	maps\_lighting::create_flickerlight_preset("big_cave_flare",(0.41,0.81,1),(0.41,1,0.94),0.005,0.15,2000);
}

//Function Number: 4
setup_crash_light_motions()
{
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_large_lake",(1,0.15,0),20000,20,0.05,0.22);
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_large_lake_02",(1,0.25,0),30000,15,0.05,0.22);
	maps\_lighting::create_flickerlight_motion_preset("fire_crash_site_plane",(1,0.25,0),300000,25,0.05,0.22);
}

//Function Number: 5
crash_set_level_lighting_values()
{
	if(isusinghdr())
	{
		setsaveddvar("r_disableLightSets",0);
	}

	if(level.nextgen)
	{
		setsaveddvar("r_hemiAoEnable",1);
	}
}

//Function Number: 6
crash_lighting_skyjack_setup()
{
	common_scripts\utility::flag_wait("start_action");
	level.player lightsetforplayer("crash_skyjack");
	maps\_utility::vision_set_fog_changes("crash_skyjack",2);
	level.player setclutforplayer("clut_crash_crash_site",2);
	setsaveddvar("r_mbEnable","2");
	setsaveddvar("r_mbVelocityScalar","3");
	setsunflareposition((-2.3,-44.1,0));
	level.player enablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehSharpness",0.2);
	}

	common_scripts\utility::flag_wait("crash_lighting_screen_dof");
	level.player setphysicaldepthoffield(9,6.5,1,1);
	wait(6);
	level.player disablephysicaldepthoffieldscripting();
}

//Function Number: 7
crash_lighting_engine_lighting()
{
	level endon("begin_crash_site_lighting");
	maps\_lighting::play_flickerlight_preset("engine_1","light_engine_01",900000);
	maps\_lighting::play_flickerlight_preset("engine_2","light_engine_02",900000);
}

//Function Number: 8
crash_lighting_crash_site()
{
	common_scripts\utility::flag_wait("begin_crash_site_lighting");
	setsunflareposition((-10.08,-87.9,0));
	level.player lightsetforplayer("crash_hud");
	maps\_utility::vision_set_fog_changes("crash_skyjack",3);
	if(level.start_point == "crash_site")
	{
		level.player setclutforplayer("clut_crash_crash_site",2);
		maps\_utility::vision_set_fog_changes("crash_crash_site_cinematic",2);
		level.player lightsetforplayer("crash_crash_site");
	}

	setsaveddvar("r_mbEnable","2");
	setsaveddvar("r_mbVelocityScalar","2");
	level.player enablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehSharpness",0.2);
	}

	level.player setphysicaldepthoffield(6,50,1,1);
	common_scripts\utility::flag_wait("crash_dof_fly_in");
	wait(9);
	level.player setphysicaldepthoffield(3.7,45,6,6);
	wait(11);
	maps\_lighting::lerp_spot_intensity("crash_crash_site_rim_1",2,0);
	wait(1);
	level.player setphysicaldepthoffield(2.26,80,1,1);
	common_scripts\utility::flag_wait("crash_lighting_cinema_end");
	level.player disablephysicaldepthoffieldscripting();
	setsaveddvar("r_dof_physical_bokehenable",0);
	maps\_lighting::lerp_spot_intensity("crash_crash_site_key_1",1,0);
	maps\_lighting::lerp_spot_intensity("crash_crash_site_fill_1",1,0);
	setsaveddvar("r_mbEnable","0");
	maps\_utility::vision_set_fog_changes("crash_crash_site",4);
}

//Function Number: 9
crash_lighting_plane_fire()
{
	common_scripts\utility::flag_wait("crash_dof_fly_in");
	wait(7);
	maps\_lighting::play_flickerlight_motion_preset("fire_crash_site_plane","fire_plane_crash");
}

//Function Number: 10
crash_lighting_crash_site_dof()
{
	common_scripts\utility::flag_wait("lighting_loading_cargo");
	setsaveddvar("r_mbEnable","2");
	setsaveddvar("r_mbVelocityScalar","2");
	setsaveddvar("r_dof_physical_bokehenable",1);
	level.player enablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehSharpness",0.2);
	}

	level.player setphysicaldepthoffield(5.6,25.8,1,1);
	common_scripts\utility::flag_wait("lighting_razorback_loaded");
	wait(2);
	setsaveddvar("r_mbEnable","0");
	level.player disablephysicaldepthoffieldscripting();
	setsaveddvar("r_dof_physical_bokehenable",0);
}

//Function Number: 11
crash_lighting_entry()
{
	common_scripts\utility::flag_wait("csh_lighting_entry_debug");
	setsunflareposition((-10.08,-87.9,0));
	level.player lightsetforplayer("crash_crash_site");
	maps\_utility::vision_set_fog_changes("crash_crash_site",0);
	level.player setclutforplayer("clut_crash_crash_site",0);
	setsaveddvar("r_dof_physical_bokehenable",0);
}

//Function Number: 12
crash_lighting_entry_dof()
{
	common_scripts\utility::flag_wait("cave_entry_anim_start");
	wait(0.25);
	setsaveddvar("r_mbEnable","2");
	setsaveddvar("r_mbVelocityScalar","5");
	maps\_lighting::stop_flickerlight("fire_crash_site_plane","fire_plane_crash",0);
	setsaveddvar("r_dof_physical_bokehenable",1);
	level.player enablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehSharpness",0.2);
	}

	level.player setphysicaldepthoffield(0.75,51,2,2);
	wait(3);
	level.player setphysicaldepthoffield(0.3,20,2,2);
}

//Function Number: 13
crash_lighting_drone_hall()
{
	common_scripts\utility::flag_wait("csh_lighting_ice_caves_transition");
	level.player lightsetforplayer("crash_prometheus");
	maps\_utility::vision_set_fog_changes("crash_ice_caves_prometheus",2);
	level.player setclutforplayer("clut_crash_prometheus",2);
	setsaveddvar("r_mbEnable","2");
	setsaveddvar("r_mbVelocityScalar","2");
	thread crash_lighting_entry_dof_scripted();
}

//Function Number: 14
crash_lighting_entry_dof_scripted()
{
	common_scripts\utility::flag_wait("blur_player_vision");
	setsaveddvar("r_dof_physical_bokehenable",1);
	if(level.nextgen)
	{
		level.player enablephysicaldepthoffieldscripting();
		setsaveddvar("r_dof_physical_bokehSharpness",0.2);
	}

	wait(1);
	level.player setphysicaldepthoffield(0.41,24,1,1);
	wait(5);
	maps\_utility::vision_set_fog_changes("crash_ice_caves_prometheus",5);
	level.player setphysicaldepthoffield(1.6,47,3,3);
	wait(1);
	level.player disablephysicaldepthoffieldscripting();
	setsaveddvar("r_dof_physical_bokehenable",0);
}

//Function Number: 15
crash_lighting_ice_caves_01()
{
	common_scripts\utility::flag_wait("csh_lighting_ice_caves_01");
	level.player lightsetforplayer("crash_ice_caves_01");
	maps\_utility::vision_set_fog_changes("crash_ice_caves_01",4);
	level.player setclutforplayer("clut_crash_ice_caves",4);
	thread crash_lighting_ice_caves_01_flare();
	setsaveddvar("r_mbEnable","0");
	setsaveddvar("r_dof_physical_bokehenable",0);
}

//Function Number: 16
crash_lighting_ice_caves_01_flare()
{
	maps\_lighting::play_flickerlight_preset("big_cave_flare","lighting_big_cave_flare",9000);
}

//Function Number: 17
crash_lighting_goliath_dof()
{
	common_scripts\utility::flag_wait("goliath_change_anim");
	setsaveddvar("r_mbEnable","2");
	setsaveddvar("r_mbVelocityScalar","2");
	setsaveddvar("r_dof_physical_bokehenable",1);
	level.player enablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehSharpness",0.2);
	}

	level.player setphysicaldepthoffield(10.9,17.15,1,1);
	wait(7);
	level.player disablephysicaldepthoffieldscripting();
}

//Function Number: 18
crash_lighting_post_goliath_fall()
{
	common_scripts\utility::flag_wait("csh_lighting_post_goliath_fall");
	maps\_lighting::stop_flickerlight("big_cave_flare","lighting_big_cave_flare",0);
	level.player lightsetforplayer("crash_post_goliath");
	maps\_utility::vision_set_fog_changes("crash_post_goliath",3);
	level.player setclutforplayer("clut_crash_ice_caves",4);
	level.visionset_default = "crash_post_goliath";
	setsaveddvar("r_dof_physical_hipenable",0);
	level.player enablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehSharpness",0.2);
	}

	level.player setphysicaldepthoffield(1.1,68,1,1);
	common_scripts\utility::flag_wait("crash_lighting_goliath_pit");
	level.player disablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehenable",0);
	}
}

//Function Number: 19
crash_lighting_ice_caves_02()
{
	common_scripts\utility::flag_wait("csh_lighting_ice_caves_02");
	setsunflareposition((-27,-116,0));
	setsaveddvar("r_mbEnable","0");
	level.lightset_previous = "crash_ice_caves_02";
	level.visionset_default = "crash_ice_caves_02";
	maps\_lighting::stop_flickerlight("goliath_flare_flash","goliath_suit_flicker",8000);
	setsaveddvar("r_dof_physical_bokehenable",1);
}

//Function Number: 20
ice_caves_02_trigger()
{
	common_scripts\utility::run_thread_on_targetname("ice_caves_02_sets",::ice_caves_02_sets);
}

//Function Number: 21
ice_caves_02_sets()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("crash_ice_caves_02");
		maps\_utility::vision_set_fog_changes("crash_ice_caves_02",2);
		level.player setclutforplayer("clut_crash_overlook",2);
		setsaveddvar("r_mbEnable","0");
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 22
ice_caves_03_trigger()
{
	common_scripts\utility::run_thread_on_targetname("ice_caves_03_sets",::ice_caves_03_sets);
}

//Function Number: 23
ice_caves_03_sets()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("crash_ice_caves_03");
		maps\_utility::vision_set_fog_changes("crash_ice_caves_02_ground_fog",2);
		level.player setclutforplayer("clut_crash_overlook",2);
		setsaveddvar("r_mbEnable","0");
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 24
crash_lighting_overlook()
{
	common_scripts\utility::flag_wait("csh_lighting_overlook");
	level.player lightsetforplayer("crash_overlook");
	maps\_utility::vision_set_fog_changes("crash_overlook",2);
	level.player setclutforplayer("clut_crash_overlook",2);
	setsaveddvar("r_mbEnable","2");
	setsaveddvar("r_mbVelocityScalar","1");
	setsaveddvar("r_dof_physical_bokehenable",0);
}

//Function Number: 25
crash_overlook_trigger()
{
	common_scripts\utility::run_thread_on_targetname("ice_overlook_sets",::ice_overlook_sets);
}

//Function Number: 26
ice_overlook_sets()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("crash_overlook");
		maps\_utility::vision_set_fog_changes("crash_overlook",2);
		level.player setclutforplayer("clut_crash_overlook",2);
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbVelocityScalar","1");
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 27
crash_overlook_sunflare()
{
	common_scripts\utility::run_thread_on_targetname("crash_overlook_sunflare",::crash_overlook_trigger_sunflare);
}

//Function Number: 28
crash_overlook_trigger_sunflare()
{
	for(;;)
	{
		self waittill("trigger");
		setsunflareposition((-13.9,-125.7,0));
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 29
crash_lighting_underground_lake()
{
	common_scripts\utility::flag_wait("csh_lighting_overlook_exit");
	level.player lightsetforplayer("crash_avalanche");
	maps\_utility::vision_set_fog_changes("crash_avalanche",2);
	level.player setclutforplayer("clut_crash_overlook",2);
	setsaveddvar("r_mbEnable","0");
	setsunflareposition((-10.39,-112.7,0));
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large_lake","fire_razorback_lake");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large_lake_02","fire_razorback_lake_02");
	setsaveddvar("r_dof_physical_bokehenable",0);
}

//Function Number: 30
crash_lighting_lake_cinema()
{
	common_scripts\utility::flag_wait("lake_underwater_lighting");
	wait(2);
	level.player maps\_utility::vision_set_fog_changes("crash_lake_underwater",2);
	level.player setclutforplayer("clut_crash_underwater",2);
	level.player lightsetforplayer("crash_lake_fallin_02");
	setsunflareposition((-31,-169,0));
	level.player enablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehSharpness",0.2);
	}

	level.player setphysicaldepthoffield(4.32,40.9,1,1);
	common_scripts\utility::flag_wait("go_lighting_gideon");
	level.player lightsetforplayer("crash_avalanche");
	maps\_utility::vision_set_fog_changes("crash_avalanche_cinematic",2);
	setsunflareposition((-10.39,-112.7,0));
	level.player setclutforplayer("clut_crash_overlook",2);
	setsaveddvar("r_mbEnable","0");
	wait(2);
	setsaveddvar("r_dof_physical_bokehenable",1);
	level.player enablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehSharpness",0.2);
	}

	wait(3.5);
	level.player setphysicaldepthoffield(2,86,1,1);
	common_scripts\utility::flag_wait("gideon_lighting_unlock");
	level.player disablephysicaldepthoffieldscripting();
	wait(15);
	maps\_lighting::lerp_spot_intensity("crash_lake_cinema_cormack_rim",3,0);
	wait(16);
	maps\_lighting::lerp_spot_intensity("crash_lake_cinema_cormack_key",3,0);
	maps\_utility::vision_set_fog_changes("crash_avalanche",4);
}