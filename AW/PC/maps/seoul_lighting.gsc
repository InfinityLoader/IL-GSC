/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: seoul_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 189
 * Decompile Time: 2761 ms
 * Timestamp: 4/22/2024 2:37:10 AM
*******************************************************************/

//Function Number: 1
main2()
{
	thread setup_subsurface_scatter();
	thread setup_level_lighting_values();
	thread setup_flickerlight_presets();
	thread setup_flickerlight_motion_presets();
	thread setup_dof_presets();
	thread setup_hemiao_enable();
	thread init_level_lighting_flags();
	thread setup_seoul_jump_lighting();
	thread setup_seoul_intro_lighting();
	thread setup_seoul_space_entry_lighting();
	thread setup_seoul_fob_lighting();
	thread setup_seoul_drone_swarm_intro_lighting();
	thread setup_seoul_hotel_entrance_lighting();
	thread setup_seoul_building_jump_sequence_lighting();
	thread trigger_seoul_building_jump();
	thread trigger_seoul_art_center_atrium();
	thread setup_seoul_sinkhole_start_lighting();
	thread setup_seoul_subway_start_lighting();
	thread setup_seoul_shopping_district_start_lighting();
	thread setup_seoul_canal_start_lighting();
	thread setup_lighting_weapons_platform_area();
	thread setup_lighting_canal_area();
	thread setup_seoul_hotel_lighting();
	thread drone_lighting();
	thread trigger_enter_hotel();
	thread trigger_enter_hotel_lrg();
	thread trigger_seoul_exterior();
	thread trigger_hotel_fall();
	thread trigger_exit_hotel();
	thread trigger_enter_subway();
	thread trigger_enter_sinkhole();
	thread trigger_seoul_shopping();
	thread trigger_enter_canal();
	thread trigger_seoul_finale_cinematic_lighting();
	thread trigger_seoul_streets_02();
	thread trigger_seoul_streets_02_xx();
	thread trigger_seoul_vista();
	thread trigger_seoul_hotel_hallway_cg();
	thread trigger_setup_shopping_walkway_pre_enter();
	thread trigger_setup_shopping_walkway_enter();
	thread trigger_setup_shopping_walkway_exit();
	thread trigger_setup_bar2_enter();
	thread trigger_setup_bar2_exit();
	thread trigger_setup_shopping_restaraunt_interior_enter();
	thread trigger_setup_shopping_restaraunt_interior_exit();
	thread trigger_enter_hotel_lobby();
	thread trigger_fall_to_hotel_lobby();
	thread trigger_enter_sinkhole_s_flicker();
	thread trigger_enter_jb1_s_flicker();
	thread trigger_enter_jb2_s_flicker();
	thread trigger_kill_jb_s_flicker();
	thread trigger_kill_sh_s_flicker();
	thread trigger_s_flicker_fluo_jump2_shadow_on();
	thread trigger_force_shadow_on_subcarback_firespot();
	thread trigger_force_shadow_off_subcarback_firespot();
	thread trigger_enter_lensflare_subway_int_off();
	thread trigger_enter_lensflare_subway_int_on();
	thread trigger_mwp_sinkhole_forceshadows();
	thread trigger_fob_dof_moment();
	thread trigger_fob_dof_autofocus_enable();
	thread trigger_fob_dof_autofocus_disable();
	thread door_breach();
	thread land_assist_effect();
	thread trigger_enter_sinkhole();
	thread hide_brushes();
	thread mwp_cine_lighhting_fx();
	thread finale_part1_cineviewmodel_lighting();
	precacheshader("ac130_overlay_pip_vignette");
	precacheshader("ac130_overlay_pip_bottom_vignette");
}

//Function Number: 2
setup_level_lighting_values()
{
	level.player lightsetforplayer("seoul");
	thread enable_physical_dof();
	thread outerspacelighting();
	if(level.nextgen)
	{
		setsaveddvar("r_dynamicOpl",1);
	}
}

//Function Number: 3
setup_subsurface_scatter()
{
}

//Function Number: 4
setup_flickerlight_presets()
{
	maps\_lighting::create_flickerlight_preset("generic_fire",(0.972549,0.62451,0.345098),(0.2,0.1462746,0.0878432),0.005,0.2,8);
	maps\_lighting::create_flickerlight_preset("generic_fire_blimp",(1,0.42451,0.145098),(0.4,0.1462746,0.0878432),0.07,0.9,8);
	maps\_lighting::create_flickerlight_preset("seoul_fire",(1,0.2246,0),(0.46,0.16,0.06),0.005,0.2,8);
	maps\_lighting::create_flickerlight_preset("pulse_alarm",(0,0,0),(0.46,0.16,0.06),100,500,8);
	maps\_lighting::create_flickerlight_preset("pulse",(0,0,0),(255,107,107),0.2,1,8);
	maps\_lighting::create_flickerlight_preset("fluorescent",(0.972549,0.62451,0.345098),(0.2,0.1462746,0.0878432),0.005,0.2,7);
}

//Function Number: 5
setup_flickerlight_motion_presets()
{
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_small",(1,0.2246,0),6000,2,0.05,0.2);
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_medium",(1,0.2246,0),100000,3,0.05,0.2);
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_medium_bright2",(1,0.2246,0),200000,4,0.05,0.2);
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_large",(1,0.3,0),900000,7,0.05,0.2);
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_large_sub_cine",(1,0.545,0.274),500000,7,0.05,0.2);
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_medium_dim2",(1,0.2246,0),20000,4,0.05,0.2);
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_medium_dim",(1,0.2246,0),500,3,0.05,0.2);
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_medium_bright",(1,0.2246,0),1000000,3,0.05,0.2);
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_canal_fire_light",(1,0.2246,0),4000000,3,0.05,0.2);
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_weaplat_rim",(1,0.2246,0),15000000,3,0.15,0.9);
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_weaplat_rim_dim",(1,0.2246,0),8000000,3,0.15,0.9);
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_weaplat_rim_body",(1,0.346,0.0467),320000,3,0.15,0.9);
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_weaplat_rim_cormack",(1,0.346,0.0467),20000,3,0.15,0.9);
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_weaplat_rim_corm_hi",(1,0.346,0.0467),80000,3,0.15,0.9);
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_weaplat_flyup",(1,0.2246,0),3200000,3,0.15,0.9);
}

//Function Number: 6
setup_dof_presets()
{
	maps\_lighting::create_dof_preset("seoul_standard",0,20,5,1000,35000,0.75,0.5);
}

//Function Number: 7
init_level_lighting_flags()
{
	common_scripts\utility::flag_init("set_seoul_space_entry_lighting");
	common_scripts\utility::flag_init("set_seoul_intro_lighting");
	common_scripts\utility::flag_init("set_pre_seoul_intro_lighting");
	common_scripts\utility::flag_init("set_seoul_hotel_lighting");
	common_scripts\utility::flag_init("set_seoul_hotel_lighting_lrg");
	common_scripts\utility::flag_init("set_seoul_fob_lighting");
	common_scripts\utility::flag_init("set_seoul_drone_swarm_intro_lighting");
	common_scripts\utility::flag_init("set_seoul_hotel_entrance_lighting");
	common_scripts\utility::flag_init("set_seoul_building_jump_sequence_lighting");
	common_scripts\utility::flag_init("set_seoul_sinkhole_start_lighting");
	common_scripts\utility::flag_init("set_seoul_subway_start_lighting");
	common_scripts\utility::flag_init("set_seoul_shopping_district_start_lighting");
	common_scripts\utility::flag_init("set_seoul_canal_start_lighting");
	common_scripts\utility::flag_init("door_pop");
	common_scripts\utility::flag_init("door_shut");
	common_scripts\utility::flag_init("set_seoul_jump_lighting");
	common_scripts\utility::flag_init("vfx_camera_blur_on");
	common_scripts\utility::flag_init("dof_fob");
	common_scripts\utility::flag_init("missle_hit");
	common_scripts\utility::flag_init("flag_autofocus_on");
	common_scripts\utility::flag_init("flag_autofocus_binoc_on");
	common_scripts\utility::flag_init("enable_fob_lighting_trigger");
}

//Function Number: 8
setup_seoul_space_entry_lighting()
{
	common_scripts\utility::flag_wait("set_seoul_space_entry_lighting");
	level.player lightsetforplayer("space_entry");
	level.player setclutforplayer("clut_seoul_pod_v3",0);
}

//Function Number: 9
setup_seoul_intro_lighting()
{
	common_scripts\utility::flag_wait("set_seoul_intro_lighting");
	thread motion_blur_intro();
	thread dof_intro();
	level waittill("pod_land_apartment");
	level waittill("player_drop_pod_door_kick");
	wait(2.8);
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_medium_dim","seoul_intro_ceiling_fire_02");
	maps\_utility::vision_set_fog_changes("seoul_vista",0.5);
	level.player lightsetforplayer("seoul_vista");
	level.player setclutforplayer("clut_seoul_vista",0);
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large","fire_vista_01");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large","fire_vista_03");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large","fire_vista_04");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large","fire_vista_06");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large","firelight_intro_vista_01");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large","firelight_intro_vista_02");
	if(level.nextgen)
	{
		maps\_lighting::play_flickerlight_motion_preset("firelight_motion_medium_bright2","seoul_intro_ceiling_fire");
	}

	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large","seoul_intro_ceiling_fire_04");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large","seoul_intro_ceiling_fire_05");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_small","fire_rim_intro");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_small","fire_rim_intro_02");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_small","fire_rim_intro_03");
	common_scripts\utility::flag_wait("set_seoul_fob_lighting");
}

//Function Number: 10
intro_shadows()
{
}

//Function Number: 11
setup_seoul_hotel_lighting()
{
	common_scripts\utility::flag_wait("set_seoul_hotel_lighting");
	level.player lightsetforplayer("seoul_hotel_top");
	level.player setclutforplayer("clut_seoul_hotel_atrium",0);
	if(level.nextgen)
	{
		maps\_utility::vision_set_fog_changes("seoul_hotel_interior",0);
	}
	else
	{
		maps\_utility::vision_set_fog_changes("seoul_hotel_interior",0.2);
	}

	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_medium_dim2","firelight_hotel_small_11");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_small","firelight_hotel_small_12");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_small","firelight_hotel_small_10");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_small","firelight_hotel_small_09");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_medium","firelight_hotel_medium_02");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_medium","firelight_hotel_medium_04");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_medium","firelight_hotel_medium_10");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_medium","firelight_hotel_medium_09");
}

//Function Number: 12
setup_seoul_fob_lighting()
{
	common_scripts\utility::flag_wait("set_seoul_fob_lighting");
	level.player lightsetforplayer("seoul_streets");
	level.player setclutforplayer("clut_seoul_fob",0);
	wait(0.05);
	maps\_utility::vision_set_fog_changes("seoul_streets",0.5);
	level.player lightsetforplayer("seoul_streets");
	common_scripts\utility::flag_wait("enable_fob_lighting_trigger");
	if(level.nextgen)
	{
	}
}

//Function Number: 13
fob_dof()
{
	thread setup_physical_dof_fob();
	common_scripts\utility::flag_set("flag_autofocus_on");
	thread enable_physical_dof_fob_autofocus_loop();
	thread enable_physical_dof_car_door_shield();
	thread disable_dof_car_door_throw();
}

//Function Number: 14
fob_fire_lighting()
{
	maps\_lighting::play_flickerlight_preset("seoul_fire","fire_under_mech_02",20000000);
	maps\_lighting::play_flickerlight_preset("seoul_fire","firelight_move_01",150000);
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_small","hotel_lobby_small_07");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_small","hotel_lobby_small_08");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_medium","firelight_fob_bldg_medium_1");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_medium","firelight_fob_bldg_medium_2");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large","firelight_fob_bldg_large_1");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large","firelight_fob_bldg_large_2");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large","firelight_fob_bldg_large_3");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large","firelight_fob_bldg_large_4");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large","firelight_fob_bldg_large_5");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large","firelight_fob_bldg_large_6");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_small","firelight_fob_street_small_2");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_medium","firelight_fob_street_medium_1");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_medium","firelight_fob_street_medium_2");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_medium","firelight_fob_street_medium_3");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_medium_bright2","firelight_fob_street_medium_4");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large","firelight_fob_street_large_1");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large","alleyway_fire_01");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_medium","firelight_fob_truck_push");
}

//Function Number: 15
setup_seoul_drone_swarm_intro_lighting()
{
	common_scripts\utility::flag_wait("set_seoul_drone_swarm_intro_lighting");
	level.player lightsetforplayer("seoul_streets");
	maps\_utility::vision_set_fog_changes("seoul_streets",0.5);
}

//Function Number: 16
setup_seoul_hotel_entrance_lighting()
{
	common_scripts\utility::flag_wait("set_seoul_hotel_entrance_lighting");
	level.player lightsetforplayer("seoul_streets");
	if(level.nextgen)
	{
		maps\_utility::vision_set_fog_changes("seoul_streets_dimfog",0.5);
	}
	else
	{
		maps\_utility::vision_set_fog_changes("seoul_convention_center",0.5);
	}

	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large","alleyway_fire_01");
}

//Function Number: 17
setup_seoul_building_jump_sequence_lighting()
{
	common_scripts\utility::flag_wait("set_seoul_building_jump_sequence_lighting");
	if(level.nextgen)
	{
		maps\_utility::vision_set_fog_changes("seoul",0.5);
		level.player lightsetforplayer("seoul");
		return;
	}

	maps\_utility::vision_set_fog_changes("seoul_building_jump",0.5);
	level.player lightsetforplayer("seoul_building_jump");
}

//Function Number: 18
setup_seoul_sinkhole_start_lighting()
{
	common_scripts\utility::flag_wait("set_seoul_sinkhole_start_lighting");
	if(level.nextgen)
	{
		level.player lightsetforplayer("seoul");
	}
	else
	{
		level.player lightsetforplayer("seoul_sinkhole");
	}

	level.player setclutforplayer("clut_seoul_fire_sinkhole",1);
	maps\_utility::vision_set_fog_changes("seoul_sinkhole",0.5);
}

//Function Number: 19
setup_seoul_subway_start_lighting()
{
	common_scripts\utility::flag_wait("set_seoul_subway_start_lighting");
	if(level.nextgen)
	{
		level.player lightsetforplayer("seoul");
		level.player setclutforplayer("seoul_subway",1);
	}
	else
	{
		level.player lightsetforplayer("seoul_subway");
	}

	maps\_utility::vision_set_fog_changes("seoul_subway_interior",0.5);
	level.player lightsetforplayer("seoul_subway");
}

//Function Number: 20
setup_seoul_shopping_district_start_lighting()
{
	common_scripts\utility::flag_wait("set_seoul_shopping_district_start_lighting");
	level.player lightsetforplayer("seoul_shopping_district");
	level.player setclutforplayer("clut_seoul_shopping",1);
	maps\_utility::vision_set_fog_changes("seoul_shopping",1.5);
	maps\_lighting::play_flickerlight_preset("seoul_fire","seoul_light_flicker_sign",1300000);
	if(level.nextgen)
	{
		var_00 = getent("seoul_flicker_streetlight_1","targetname");
		var_00 setlightintensity(400000);
		var_01 = getent("seoul_flicker_streetlight_2","targetname");
		var_01 setlightintensity(360000);
		var_02 = getent("seoul_flicker_streetlight_3","targetname");
		var_02 setlightintensity(600000);
		var_03 = getent("seoul_flicker_streetlight_4","targetname");
		var_03 setlightintensity(920000);
		var_04 = getent("seoul_flicker_streetlight_5","targetname");
		var_04 setlightintensity(300000);
		var_05 = getent("seoul_flicker_streetlight_6","targetname");
		var_05 setlightintensity(300000);
		var_06 = getentarray("seoul_shopping_streetlight_on","targetname");
		var_07 = getentarray("seoul_shopping_streetlight_off","targetname");
		for(var_08 = 0;var_08 < var_07.size;var_08++)
		{
			var_07[var_08] hide();
		}

		for(var_09 = 900;var_09 > 0;var_09--)
		{
			common_scripts\_exploder::exploder(6425);
			wait(randomfloatrange(0,0.5));
			for(var_08 = 0;var_08 < var_06.size;var_08++)
			{
				var_06[var_08] hide();
			}

			for(var_08 = 0;var_08 < var_07.size;var_08++)
			{
				var_07[var_08] show();
			}

			var_00 setlightintensity(0);
			var_01 setlightintensity(0);
			var_02 setlightintensity(0);
			var_03 setlightintensity(0);
			var_04 setlightintensity(0);
			var_05 setlightintensity(0);
			common_scripts\_exploder::kill_exploder(6425);
			wait(randomfloatrange(0.1,1));
			for(var_08 = 0;var_08 < var_06.size;var_08++)
			{
				var_06[var_08] show();
			}

			for(var_08 = 0;var_08 < var_07.size;var_08++)
			{
				var_07[var_08] hide();
			}

			var_00 setlightintensity(100000);
			var_01 setlightintensity(160000);
			var_02 setlightintensity(150000);
			var_03 setlightintensity(320000);
			var_04 setlightintensity(200000);
			var_05 setlightintensity(200000);
		}
	}
}

//Function Number: 21
setup_seoul_canal_start_lighting()
{
	common_scripts\utility::flag_wait("set_seoul_canal_start_lighting");
	level.player lightsetforplayer("seoul_canal");
	level.player setclutforplayer("clut_seoul_canal",1);
	maps\_utility::vision_set_fog_changes("seoul_canal_entrance",0.5);
	maps\_shg_fx::set_sun_flare_position((-10,-80,0));
	thread enable_physical_dof_interest_of_time();
	setsaveddvar("r_dof_physical_hipFstop",2);
	common_scripts\_exploder::kill_exploder(6425);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbvelocityscalar",".25");
	}

	if(level.nextgen)
	{
		setsaveddvar("r_mdaoOccluderCullDistance","1000");
	}

	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_small","fire_light_canal_small1");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_medium","fire_light_canal_medium6");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large","fire_light_canal_large1");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large","fire_light_canal_large2");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large","fire_light_canal_large4");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_weaplat_rim","light_weaplat_rim");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_canal_fire_light","canal_fire_light");
	if(level.nextgen)
	{
		var_00 = getent("light_weaplat_rim","targetname");
		var_01 = getent("light_left_big_key","targetname");
		var_02 = getent("canal_fire_light","targetname");
		var_00 setlightshadowstate("force_on");
		var_01 setlightshadowstate("force_on");
		var_02 setlightshadowstate("force_on");
	}

	maps\_lighting::play_flickerlight_preset("generic_fire_blimp","fire_light_canal_large3",10000000);
}

//Function Number: 22
binocular_mwp_rim_flicker()
{
	maps\_lighting::stop_flickerlight("firelight_motion_weaplat_rim","light_weaplat_rim",0);
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_weaplat_rim","light_weaplat_rim");
}

//Function Number: 23
binocular_dof()
{
	level.player enablephysicaldepthoffieldscripting();
	common_scripts\utility::flag_set("flag_autofocus_binoc_on");
	maps\_utility::vision_set_fog_changes("seoul_binoculars",0.5);
	enable_physical_dof_binoculars_autofocus_loop();
	common_scripts\utility::flag_wait("demo_team_seen");
}

//Function Number: 24
binocular_vision()
{
	maps\_utility::vision_set_fog_changes("seoul_binoculars",0.5);
	common_scripts\utility::flag_wait("demo_team_seen");
	maps\_utility::vision_set_fog_changes("seoul_shopping",0.5);
}

//Function Number: 25
trigger_seoul_finale_cinematic_lighting()
{
	common_scripts\utility::run_thread_on_targetname("trigger_mwp_lightgrid_tweak_01",::seoul_finale_cinematic_lighting);
}

//Function Number: 26
seoul_finale_cinematic_lighting()
{
	self waittill("trigger");
	level.player lightsetforplayer("seoul_finale_run");
	if(level.nextgen)
	{
		maps\_utility::lerp_saveddvar("r_mdaoCapsulestrength",1,1);
	}

	level.player setclutforplayer("clut_seoul_ending_v3",1);
	wait(2);
	level.player lightsetforplayer("seoul_finale");
}

//Function Number: 27
setup_lighting_weapons_platform_area()
{
	var_00 = getentarray("lighting_weapons_platform_area_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_weapons_platform_area_volume();
	}
}

//Function Number: 28
setup_lighting_weapons_platform_area_volume()
{
	for(;;)
	{
		self waittill("trigger");
		if(level.nextgen)
		{
			var_00 = getent("canal_fire_light","targetname");
			var_00 setlightshadowstate("normal");
			setsaveddvar("r_mbvelocityscalar","1");
		}
	}
}

//Function Number: 29
setup_lighting_canal_area()
{
	var_00 = getentarray("lighting_canal_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_canal_area_volume();
	}
}

//Function Number: 30
setup_lighting_canal_area_volume()
{
	for(;;)
	{
		self waittill("trigger");
		if(level.nextgen)
		{
			var_00 = getent("canal_fire_light","targetname");
			var_00 setlightshadowstate("force_on");
		}

		if(level.nextgen)
		{
			setsaveddvar("r_mbvelocityscalar",".25");
		}
	}
}

//Function Number: 31
enable_motion_blur()
{
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
	}
}

//Function Number: 32
enable_motion_blur_rotation()
{
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
	}
}

//Function Number: 33
disable_motion_blur()
{
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
	}
}

//Function Number: 34
enable_physical_dof()
{
}

//Function Number: 35
enable_physical_dof_hip()
{
	setsaveddvar("r_dof_physical_hipEnable",1);
	setsaveddvar("r_dof_physical_hipFstop",0.125);
	setsaveddvar("r_dof_physical_hipSharpCocDiameter",0.1);
}

//Function Number: 36
enable_physical_dof_hip_fob()
{
	setsaveddvar("r_dof_physical_bokehEnable",1);
	setsaveddvar("r_dof_physical_hipEnable",1);
	setsaveddvar("r_dof_physical_hipFstop",2);
	setsaveddvar("r_dof_physical_hipSharpCocDiameter",0.03);
}

//Function Number: 37
setup_physical_dof_fob()
{
	level.player enablephysicaldepthoffieldscripting();
}

//Function Number: 38
enable_physical_dof_fob_autofocus_loop()
{
	if(level.nextgen)
	{
		level.player setphysicalviewmodeldepthoffield(18,20);
		while(common_scripts\utility::flag("flag_autofocus_on") == 1)
		{
			wait 0.05;
			var_00 = trace_distance();
			level.player setphysicaldepthoffield(3.5,var_00,5);
		}

		level.player disablephysicaldepthoffieldscripting();
	}
}

//Function Number: 39
enable_physical_dof_binoculars_autofocus_loop()
{
	level.player setphysicalviewmodeldepthoffield(18,20);
	while(common_scripts\utility::flag("flag_autofocus_binoc_on") == 1)
	{
		wait 0.05;
		var_00 = trace_distance();
		if(level.nextgen)
		{
			level.player setphysicaldepthoffield(0.2,var_00,5);
			continue;
		}

		level.player setphysicaldepthoffield(1,var_00,5);
	}

	level.player disablephysicaldepthoffieldscripting();
}

//Function Number: 40
trace_distance()
{
	var_00 = 4096;
	var_01 = level.player geteye();
	var_02 = level.player getplayerangles();
	if(isdefined(level.player.dof_ref_ent))
	{
		var_03 = combineangles(level.player.dof_ref_ent.angles,var_02);
	}
	else
	{
		var_03 = var_03;
	}

	var_04 = vectornormalize(anglestoforward(var_03));
	var_05 = bullettrace(var_01,var_01 + var_04 * var_00,1,level.player,1,1,0,0,0);
	return distance(var_01,var_05["position"]);
}

//Function Number: 41
trigger_fob_dof_moment()
{
	common_scripts\utility::run_thread_on_targetname("dof_fob_moment_start",::dof_fob_moment_start);
}

//Function Number: 42
dof_fob_moment_start()
{
	if(level.nextgen)
	{
		for(;;)
		{
			self waittill("trigger");
			common_scripts\utility::flag_clear("flag_autofocus_on");
			level.player enablephysicaldepthoffieldscripting();
			level.player setphysicaldepthoffield(2,45,8);
			while(level.player istouching(self))
			{
				wait(0.1);
			}
		}
	}
}

//Function Number: 43
trigger_fob_dof_autofocus_enable()
{
	if(level.nextgen)
	{
		common_scripts\utility::run_thread_on_targetname("dof_fob_autofocus_enable",::dof_fob_autofocus_enable);
	}
}

//Function Number: 44
dof_fob_autofocus_enable()
{
	for(;;)
	{
		self waittill("trigger");
		common_scripts\utility::flag_set("flag_autofocus_on");
		level.player enablephysicaldepthoffieldscripting();
		enable_physical_dof_fob_autofocus_loop();
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 45
trigger_fob_dof_autofocus_disable()
{
	if(level.nextgen)
	{
		common_scripts\utility::run_thread_on_targetname("dof_fob_autofocus_disable",::dof_fob_autofocus_disable);
	}
}

//Function Number: 46
dof_fob_autofocus_disable()
{
	for(;;)
	{
		self waittill("trigger");
		common_scripts\utility::flag_clear("flag_autofocus_on");
		level.player disablephysicaldepthoffieldscripting();
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 47
enable_physical_dof_car_door_shield()
{
	level waittill("player_owns_cardoor_shield");
	common_scripts\utility::flag_clear("flag_autofocus_on");
	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(22,50000,8,8);
	level.player setphysicalviewmodeldepthoffield(4,20);
}

//Function Number: 48
disable_dof_car_door_throw()
{
	level.player waittill("car_door_thrown");
	common_scripts\utility::flag_clear("flag_autofocus_on");
	level.player disablephysicaldepthoffieldscripting();
}

//Function Number: 49
enable_physical_dof_interest_of_time()
{
	common_scripts\utility::flag_clear("flag_autofocus_on");
	level.player disablephysicaldepthoffieldscripting();
}

//Function Number: 50
outerspacelighting()
{
	wait(0.05);
	setsaveddvar("r_useLightGridDefaultFXLightingLookup",1);
	setsaveddvar("r_useLightGridDefaultModelLightingLookup",1);
	if(common_scripts\utility::flag("set_pre_seoul_intro_lighting") == 1)
	{
		setsaveddvar("r_lightGridDefaultFXLightingLookup",(36118.5,1519.77,1799.09));
		setsaveddvar("r_lightGridDefaultModelLightingLookup",(36118.5,1519.77,1799.09));
		common_scripts\utility::flag_waitopen("set_pre_seoul_intro_lighting");
	}

	setsaveddvar("r_lightGridDefaultFXLightingLookup",(36327.9,1157.88,1847.92));
	setsaveddvar("r_lightGridDefaultModelLightingLookup",(36135.9,1365.73,1845.13));
	common_scripts\utility::flag_wait("set_seoul_intro_lighting");
	setsaveddvar("r_useLightGridDefaultFXLightingLookup",1);
	setsaveddvar("r_useLightGridDefaultModelLightingLookup",1);
	setsaveddvar("r_lightGridDefaultFXLightingLookup",(36327.9,1157.88,1847.92));
	setsaveddvar("r_lightGridDefaultModelLightingLookup",(35894,587,1830));
	common_scripts\utility::flag_waitopen("set_seoul_intro_lighting");
	setsaveddvar("r_useLightGridDefaultFXLightingLookup",1);
	setsaveddvar("r_useLightGridDefaultModelLightingLookup",1);
	setsaveddvar("r_lightGridDefaultFXLightingLookup",(36327.9,1157.88,1847.92));
	setsaveddvar("r_lightGridDefaultModelLightingLookup",(36135.9,1365.73,1845.13));
}

//Function Number: 51
outerspace_intro_new()
{
	setsaveddvar("r_useLightGridDefaultFXLightingLookup",1);
	setsaveddvar("r_useLightGridDefaultModelLightingLookup",1);
	setsaveddvar("r_lightGridDefaultFXLightingLookup",(36327.9,1157.88,1847.92));
	setsaveddvar("r_lightGridDefaultModelLightingLookup",(35894,587,1830));
	common_scripts\utility::flag_waitopen("set_seoul_intro_lighting");
	setsaveddvar("r_useLightGridDefaultFXLightingLookup",1);
	setsaveddvar("r_useLightGridDefaultModelLightingLookup",1);
	setsaveddvar("r_lightGridDefaultFXLightingLookup",(36327.9,1157.88,1847.92));
	setsaveddvar("r_lightGridDefaultModelLightingLookup",(36135.9,1365.73,1845.13));
}

//Function Number: 52
outerspacelighting_checkpoint()
{
	setsaveddvar("r_useLightGridDefaultFXLightingLookup",1);
	setsaveddvar("r_useLightGridDefaultModelLightingLookup",1);
	setsaveddvar("r_lightGridDefaultFXLightingLookup",(36327.9,1157.88,1847.92));
	setsaveddvar("r_lightGridDefaultModelLightingLookup",(36135.9,1365.73,1845.13));
}

//Function Number: 53
motion_blur_intro()
{
	enable_motion_blur_rotation();
	level waittill("droppod_empty");
	disable_motion_blur();
}

//Function Number: 54
dof_intro_pre()
{
	wait(0.05);
	level.player enablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",1);
		thread pod_cormack_custom_mats_on();
		level.player setphysicaldepthoffield(7,15,20,20);
		maps\_utility::vision_set_fog_changes("seoul_pre_space_entry_nofog",1);
		level.player setphysicaldepthoffield(2,25,20,20);
		wait(10);
		maps\_utility::vision_set_fog_changes("seoul_pre_space_entry",2);
		wait(11.5);
		level.player setphysicaldepthoffield(2.5,13.5,20,20);
		wait(3);
		level.player setphysicaldepthoffield(22,100000,20,20);
		wait(5);
		maps\_utility::vision_set_fog_changes("seoul_pre_space_entry_fog",0.5);
		setsaveddvar("r_eyeRedness",0.7);
		setsaveddvar("r_eyepupil",0.18);
		return;
	}

	thread pod_cormack_custom_mats_on();
	level.player setphysicaldepthoffield(8,15,20,20);
	wait(11.5);
	maps\_utility::vision_set_fog_changes("seoul_pre_space_entry",1);
	level.player setphysicaldepthoffield(3,25,20,20);
	wait(19.2);
	level.player setphysicaldepthoffield(3.5,13.5,20,20);
	wait(3);
	level.player setphysicaldepthoffield(23,100000,20,20);
	maps\_utility::vision_set_fog_changes("seoul_pre_space_entry_fog",0.5);
}

//Function Number: 55
dof_intro()
{
	common_scripts\utility::flag_wait("vfx_start_drop_pod_intro_phase_2b");
	if(level.nextgen)
	{
		level.player setphysicaldepthoffield(22,100000,20,20);
		wait(2);
		level.player setphysicaldepthoffield(4.5,14.21,20,20);
		setsaveddvar("r_dof_physical_bokehEnable",1);
		wait(2.5);
		level.player setphysicaldepthoffield(22,100000,20,20);
		setsaveddvar("r_dof_physical_bokehEnable",0);
		wait(0.5);
		maps\_utility::vision_set_fog_changes("seoul_space_entry",2);
		wait(4);
		level.player setphysicaldepthoffield(3,25,20,20);
		wait(3.1);
		level.player setphysicaldepthoffield(22,100000,20,20);
		wait(3.9);
		level.player setphysicaldepthoffield(3,25,20,20);
		common_scripts\utility::flag_wait("door_shut");
		level.player setphysicaldepthoffield(3,25,20,20);
		wait(5);
		level.player setphysicaldepthoffield(22,100000,20,20);
		wait(2);
		level.player setphysicaldepthoffield(3,25,20,20);
		wait(2);
		level.player setphysicaldepthoffield(22,100000,20,20);
		level waittill("pod_land_apartment");
		thread intro_camera_blur();
		level.player setphysicaldepthoffield(5,25,20,20);
		level waittill("player_drop_pod_door_kick");
		wait(2.8);
		level.player setphysicaldepthoffield(6,8600,20,20);
		wait(8.25);
		level.player setphysicaldepthoffield(2,35,2,2);
		wait(2.95);
		level.player setphysicaldepthoffield(1.5,235,4,4);
		wait(5);
		wait(1.6);
		level.player setphysicaldepthoffield(3,20,25,25);
		wait(1);
		level.player setphysicaldepthoffield(1.5,75,2,2);
		setsaveddvar("r_eyeRedness",0.2);
		setsaveddvar("r_eyepupil",0.225);
		level waittill("droppod_empty");
		level.player setphysicaldepthoffield(10,7500,1,1);
		wait(3);
		setsaveddvar("r_mbEnable","0");
		level.player disablephysicaldepthoffieldscripting();
		setsaveddvar("r_dof_physical_bokehEnable",0);
		return;
	}

	level.player setphysicaldepthoffield(23,100000,20,20);
	wait(2);
	level.player setphysicaldepthoffield(5.5,14.21,20,20);
	wait(2.5);
	level.player setphysicaldepthoffield(23,100000,20,20);
	wait(0.5);
	maps\_utility::vision_set_fog_changes("seoul_space_entry",2);
	wait(4);
	level.player setphysicaldepthoffield(4,25,20,20);
	wait(3.1);
	level.player setphysicaldepthoffield(23,100000,20,20);
	wait(3.9);
	level.player setphysicaldepthoffield(4,25,20,20);
	common_scripts\utility::flag_wait("door_shut");
	level.player setphysicaldepthoffield(4,25,20,20);
	wait(5);
	level.player setphysicaldepthoffield(23,100000,20,20);
	wait(2);
	level.player setphysicaldepthoffield(4,25,20,20);
	wait(2);
	level.player setphysicaldepthoffield(23,100000,20,20);
	level waittill("pod_land_apartment");
	thread intro_camera_blur();
	level.player setphysicaldepthoffield(6,25,20,20);
	level waittill("player_drop_pod_door_kick");
	level.player setphysicaldepthoffield(7,8600,20,20);
	wait(10);
	level.player setphysicaldepthoffield(3,35,2,2);
	wait(3.1);
	level.player setphysicaldepthoffield(2.5,235,4,4);
	wait(5);
	wait(1);
	level.player setphysicaldepthoffield(4,20,25,25);
	wait(1.1);
	level.player setphysicaldepthoffield(2.5,75,2,2);
	level waittill("droppod_empty");
	level.player setphysicaldepthoffield(11,7500,1,1);
	wait(3);
	level.player disablephysicaldepthoffieldscripting();
}

//Function Number: 56
door_breach()
{
	level waittill("exo_breach_impact");
	enable_motion_blur();
	wait(20);
	disable_motion_blur();
}

//Function Number: 57
motion_blur_sink_hole_zipline()
{
	common_scripts\utility::flag_wait("sinkhole_player_uses_zipline");
	enable_motion_blur();
	wait(5);
	disable_motion_blur();
}

//Function Number: 58
land_assist_effect()
{
	for(;;)
	{
		var_00 = level.player common_scripts\utility::waittill_any_return("full_fall","land_after_full_fall");
		if(isdefined(var_00))
		{
			switch(var_00)
			{
				case "full_fall":
					enable_motion_blur_rotation();
					break;
	
				case "land_after_full_fall":
					disable_motion_blur();
					break;
			}
		}
	}
}

//Function Number: 59
lerp_origin_function(param_00,param_01,param_02)
{
	param_00 notify("stop lerp");
	param_00 endon("stop lerp");
	param_00 endon("death");
	var_03 = param_00.origin;
	var_04 = 0;
	while(var_04 < param_01)
	{
		param_00.origin = vectorlerp(var_03,param_02,var_04 / param_01);
		var_04 = var_04 + 0.05;
		wait(0.05);
	}

	param_00.origin = param_02;
}

//Function Number: 60
lerp_angles_function(param_00,param_01,param_02)
{
	param_00 notify("stop lerp");
	param_00 endon("stop lerp");
	param_00 endon("death");
	var_03 = param_00.angles;
	var_04 = 0;
	while(var_04 < param_01)
	{
		param_00.angles = vectorlerp(var_03,param_02,var_04 / param_01);
		var_04 = var_04 + 0.05;
		wait(0.05);
	}

	param_00.angles = param_02;
}

//Function Number: 61
dof_subway_cinematic()
{
	enable_motion_blur_rotation();
	level.player enablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",1);
	}

	level.player setphysicaldepthoffield(8,13);
	wait(1.7);
	level.player setphysicaldepthoffield(1,169,4,4);
	wait(5.3);
	level.player setphysicaldepthoffield(3.5,23,10,10);
	wait(1.5);
	level.player setphysicaldepthoffield(2,140,2,4);
	wait(2);
	level.player setphysicaldepthoffield(1,110,1,2);
	wait(10.2);
	level.player setphysicaldepthoffield(4,30,1,2);
	wait(2.5);
	level.player setphysicaldepthoffield(12,100,1,2);
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",0);
	}

	level.player disablephysicaldepthoffieldscripting();
	disable_motion_blur();
}

//Function Number: 62
dof_subway_cinematic_optimized()
{
	enable_motion_blur_rotation();
	level.player enablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",1);
	}

	level.player setphysicaldepthoffield(8,13,20,20);
	wait(1.7);
	level.player setphysicaldepthoffield(4,169,20,20);
	wait(2.4);
	level.player setphysicaldepthoffield(0.25,9,40,40);
	wait(0.3);
	level.player setphysicaldepthoffield(4,169,10,10);
	wait(3);
	level.player setphysicaldepthoffield(4.5,23,10,10);
	wait(1.5);
	level.player setphysicaldepthoffield(2,140,4,4);
	wait(2);
	level.player setphysicaldepthoffield(2,110,1,2);
	wait(10.2);
	level.player setphysicaldepthoffield(8,30,4,4);
	wait(2.5);
	level.player setphysicaldepthoffield(12,100,1,2);
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",0);
	}

	level.player disablephysicaldepthoffieldscripting();
	disable_motion_blur();
}

//Function Number: 63
lighting_subway_breach()
{
	wait(4);
	level.player lightsetforplayer("seoul_subway_breachflash");
	wait(0.5);
	level.player lightsetforplayer("seoul_subway");
}

//Function Number: 64
cine_sub_fog()
{
	level.player thread maps\_lighting::screen_effect_base(22,"ac130_overlay_pip_bottom_vignette",5,2,1,0,0);
	wait(3);
	maps\_utility::vision_set_fog_changes("seoul_subway_cinematic",5);
	wait(16);
	maps\_utility::vision_set_fog_changes("seoul_subway_interior",3);
}

//Function Number: 65
cine_sub_will_all_mulitlight()
{
	common_scripts\_exploder::kill_exploder("lensflare_subway_int");
	if(level.nextgen)
	{
		var_00 = getent("cine_left_light_all","targetname");
		var_00 setlightshadowstate("force_on");
		var_01 = var_00.origin;
		var_02 = var_00.angles;
		var_03 = common_scripts\utility::getstruct("script_struct_sub_key_will","targetname");
		var_04 = common_scripts\utility::getstruct("script_struct_sub_key_all","targetname");
		maps\_lighting::lerp_spot_intensity("cine_left_light_all",0.05,10000);
		lerp_origin_function(var_00,3,var_03.origin);
		lerp_angles_function(var_00,3,var_03.angles);
		wait(2);
		maps\_lighting::lerp_spot_intensity("cine_left_light_all",2.5,0);
		lerp_origin_function(var_00,0.05,var_04.origin);
		lerp_angles_function(var_00,0.05,var_04.angles);
		maps\_lighting::lerp_spot_intensity("cine_left_light_all",1.5,160000);
		wait(9);
		maps\_lighting::lerp_spot_intensity("cine_left_light_all",3,0);
	}
}

//Function Number: 66
cine_holelight()
{
	wait(4);
	maps\_lighting::set_spot_color("cine_holelight",(1,0.545,0.274));
	maps\_lighting::lerp_spot_intensity("cine_holelight",1,160000);
	common_scripts\_exploder::exploder("exp_sub_drop_light");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large_sub_cine","cine_holelight");
	if(level.nextgen)
	{
		maps\_lighting::lerp_spot_intensity("cine_holelight",2,160000);
	}
}

//Function Number: 67
cine_left_light()
{
	if(level.nextgen)
	{
		var_00 = getent("cine_left_light_all","targetname");
		wait(8);
		var_00 maps\_lighting::lerp_light_fov_range(90,30,50,30,0.1);
		thread maps\_lighting::lerp_spot_intensity("cine_left_light_all",2,256000);
	}
}

//Function Number: 68
cine_sub_fire_rim()
{
	if(level.nextgen)
	{
		maps\_lighting::set_spot_color("cine_sub_fire_rim",(1,0.4187,0.082));
		wait(8.5);
		maps\_lighting::lerp_spot_intensity("cine_sub_fire_rim",4,400000);
		wait(7);
		maps\_lighting::lerp_spot_intensity("cine_sub_fire_rim",4,1);
	}
}

//Function Number: 69
cine_sub_right_irons()
{
	if(level.nextgen)
	{
		var_00 = getent("cine_right_light_irons","targetname");
		maps\_lighting::lerp_spot_intensity("cine_right_light_irons",2,20000);
		wait(16);
		maps\_lighting::lerp_spot_intensity("cine_right_light_irons",5,400);
	}
}

//Function Number: 70
trigger_enter_subway()
{
	common_scripts\utility::run_thread_on_targetname("seoul_subway_interior",::vision_seoul_subway_interior);
}

//Function Number: 71
vision_seoul_subway_interior()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("seoul_subway");
		if(level.currentgen)
		{
			level.player lightsetforplayer("seoul_subway");
		}

		maps\_utility::vision_set_fog_changes("seoul_subway_interior",3);
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 72
trigger_seoul_art_center_atrium()
{
	common_scripts\utility::run_thread_on_targetname("seoul_art_center_atrium",::vision_seoul_art_center_atrium);
}

//Function Number: 73
vision_seoul_art_center_atrium()
{
	for(;;)
	{
		self waittill("trigger");
		if(level.nextgen)
		{
			maps\_utility::vision_set_fog_changes("seoul",3);
		}
		else
		{
			maps\_utility::vision_set_fog_changes("seoul_convention_center",3);
			level.player lightsetforplayer("seoul_convention_center");
		}

		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 74
trigger_seoul_building_jump()
{
	common_scripts\utility::run_thread_on_targetname("seoul_building_jump",::vision_seoul_building_jump);
}

//Function Number: 75
vision_seoul_building_jump()
{
	self waittill("trigger");
	level.player lightsetforplayer("seoul_building_jump");
	maps\_utility::vision_set_fog_changes("seoul_building_jump",3);
	if(level.currentgen)
	{
	}

	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_cb1_grp1",512000);
	if(level.nextgen)
	{
		maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_cb1_grp2a",256000);
	}

	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_cb1_grp2b",256000);
	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_cb2_grp2a",3000);
	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_cb2_grp2b",128000);
	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_cb2_grp2c",128000);
	for(;;)
	{
		self waittill("trigger");
		maps\_utility::vision_set_fog_changes("seoul_building_jump",3);
		level.player setclutforplayer("clut_seoul_fire_sinkhole",1);
		level.player lightsetforplayer("seoul_building_jump");
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 76
setup_seoul_jump_lighting()
{
	common_scripts\utility::flag_wait("set_seoul_jump_lighting");
	if(level.nextgen)
	{
		level.player lightsetforplayer("seoul");
	}
	else
	{
		level.player lightsetforplayer("seoul_building_jump");
	}

	level.player setclutforplayer("seoul",1);
	maps\_utility::vision_set_fog_changes("seoul_building_jump",3);
	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_cb1_grp1",512000);
	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_cb1_grp2a",256000);
	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_cb1_grp2b",256000);
	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_cb2_grp2a",3000);
	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_cb2_grp2b",128000);
	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_cb2_grp2c",128000);
}

//Function Number: 77
trigger_enter_sinkhole()
{
	common_scripts\utility::run_thread_on_targetname("seoul_sinkhole",::vision_seoul_sinkhole);
}

//Function Number: 78
vision_seoul_sinkhole()
{
	self waittill("trigger");
	maps\_utility::vision_set_fog_changes("seoul_sinkhole",2);
	level.player lightsetforplayer("seoul_sinkhole");
	if(level.currentgen)
	{
		level.player lightsetforplayer("seoul_sinkhole");
	}

	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_cb2_grp2b",128000);
	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_cb2_grp2c",128000);
	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_sinkhole_upper1",200000);
	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_sinkhole_upper2",200000);
	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_sinkhole_upper3",200000);
	if(level.nextgen)
	{
		maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_sinkhole_mid1",10000);
		maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_sinkhole_mid2",200000);
	}
	else
	{
		maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_sinkhole_mid1",1000);
		maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_sinkhole_mid2",500);
	}

	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_sinkhole_mid1_b",4000);
	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_sinkhole_lower1",40000);
	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_sinkhole_lower3",200000);
	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_sinkhole_lower4",200000);
	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_sinkhole_lower5",200000);
	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_sinkhole_crater1",100000);
	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_sinkhole_crater2",10000);
	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_sinkhole_crater3",100000);
	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_sinkhole_crater4",100000);
	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_sinkhole_crater5",100000);
	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_sinkhole_crater6",100000);
	maps\_lighting::play_flickerlight_preset("seoul_fire","flicker_fire_sinkhole_crater7",100000);
	for(;;)
	{
		self waittill("trigger");
		maps\_utility::vision_set_fog_changes("seoul_sinkhole",2);
		level.player lightsetforplayer("seoul_sinkhole");
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 79
trigger_mwp_sinkhole_forceshadows()
{
	common_scripts\utility::run_thread_on_targetname("seoul_weapons_platform_trigger",::play_mwp_sinkhole_forceshadows);
}

//Function Number: 80
play_mwp_sinkhole_forceshadows()
{
	self waittill("trigger");
	var_00 = getent("spot_mwp_sinkhole","targetname");
	var_00 setlightshadowstate("force_on");
	maps\_lighting::lerp_spot_intensity("spot_mwp_sinkhole",3,1600000);
	wait(1);
	maps\_lighting::lerp_spot_intensity("spot_mwp_sinkhole",6,1);
	wait(1);
	var_00 setlightshadowstate("normal");
}

//Function Number: 81
trigger_enter_lensflare_subway_int_on()
{
	common_scripts\utility::run_thread_on_targetname("trig_lensflare_subway_int_on",::play_lensflare_subway_int_on);
}

//Function Number: 82
play_lensflare_subway_int_on()
{
	for(;;)
	{
		self waittill("trigger");
		common_scripts\_exploder::exploder("lensflare_subway_int");
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 83
trigger_enter_lensflare_subway_int_off()
{
	common_scripts\utility::run_thread_on_targetname("trig_lensflare_subway_int_off",::play_lensflare_subway_int_off);
}

//Function Number: 84
play_lensflare_subway_int_off()
{
	for(;;)
	{
		self waittill("trigger");
		common_scripts\_exploder::kill_exploder("lensflare_subway_int");
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 85
lighting_fx_lens_subway_interior()
{
	common_scripts\_exploder::exploder("lensflare_subway_int");
}

//Function Number: 86
trigger_enter_jb1_s_flicker()
{
	common_scripts\utility::run_thread_on_targetname("trig_jb1_s_flicker",::play_s_flicker_jb1);
}

//Function Number: 87
play_s_flicker_jb1()
{
	self waittill("trigger");
	thread maps\_lighting::model_flicker_preset("s_flicker_fluo_jump1",0,0,640000,9911,9911,0.01,0.6,0.03,0.7,"kill_jb_s_flicker");
	thread maps\_lighting::model_flicker_preset("s_flicker_alarm_jump1",0,0,8000,9912,9912,0.3,0.301,1.2,1.201,"kill_jb_s_flicker");
	while(level.player istouching(self))
	{
		wait(0.1);
	}
}

//Function Number: 88
trigger_enter_jb2_s_flicker()
{
	common_scripts\utility::run_thread_on_targetname("trig_jb2_s_flicker",::play_s_flicker_jb2);
}

//Function Number: 89
play_s_flicker_jb2()
{
	self waittill("trigger");
	thread maps\_lighting::model_flicker_preset("s_flicker_fluo2_jump2",0,0,40000,9922,9922,0.1,1.5,0.03,0.7,"kill_jb_s_flicker");
	if(level.nextgen)
	{
		thread maps\_lighting::model_flicker_preset("s_flicker_can_jump2",0,0,4000,9921,9921,0.01,0.3,0.03,0.7,"kill_jb_s_flicker");
		thread maps\_lighting::model_flicker_preset("s_flicker_fluo_jump2",0,0,100000,9922,9922,0.01,0.3,0.03,0.7,"kill_jb_s_flicker");
	}
	else
	{
		thread maps\_lighting::model_flicker_preset("s_flicker_fluo_jump2",0,0,70000,9922,9922,0.01,0.3,0.03,0.7,"kill_jb_s_flicker");
	}

	while(level.player istouching(self))
	{
		wait(0.1);
	}
}

//Function Number: 90
trigger_enter_sinkhole_s_flicker()
{
	common_scripts\utility::run_thread_on_targetname("trig_sh_s_flicker",::play_s_flicker_sh);
}

//Function Number: 91
play_s_flicker_sh()
{
	self waittill("trigger");
	thread maps\_lighting::model_flicker_preset("s_flicker_fluo_ground",0,0,2000000,9931,9931,0.01,0.3,0.03,0.7,"kill_sh_s_flicker");
	thread maps\_lighting::model_flicker_preset("s_flicker_fluo_sh_edge",0,0,160000,9941,9941,0.01,0.3,0.03,0.7,"kill_sh_s_flicker");
	thread maps\_lighting::model_flicker_preset("s_flicker_fluo_ceil_mid",0,0,40000,undefined,undefined,0.01,0.3,0.03,0.7,"kill_sh_s_flicker");
	thread maps\_lighting::model_flicker_preset("s_flicker_fluo_ceil_side",0,0,10000,undefined,undefined,0.01,0.3,0.03,0.7,"kill_sh_s_flicker");
	thread maps\_lighting::model_flicker_preset("s_flicker_fluo_ceil_back",0,0,10000,undefined,undefined,0.01,0.3,0.03,0.7,"kill_sh_s_flicker");
	while(level.player istouching(self))
	{
		wait(0.1);
	}
}

//Function Number: 92
trigger_kill_jb_s_flicker()
{
	common_scripts\utility::run_thread_on_targetname("trig_jb_kill_s_flicker",::kill_s_flicker_jb);
}

//Function Number: 93
kill_s_flicker_jb()
{
	self waittill("trigger");
	level notify("kill_jb_s_flicker");
	var_00 = getent("targ_s_flicker_fluo_jump2","targetname");
	var_00 setlightshadowstate("normal");
	while(level.player istouching(self))
	{
		wait(0.1);
	}
}

//Function Number: 94
trigger_kill_sh_s_flicker()
{
	common_scripts\utility::run_thread_on_targetname("trig_sh_kill_s_flicker",::kill_s_flicker_sh);
}

//Function Number: 95
kill_s_flicker_sh()
{
	self waittill("trigger");
	level notify("kill_sh_s_flicker");
	while(level.player istouching(self))
	{
		wait(0.1);
	}
}

//Function Number: 96
trigger_s_flicker_fluo_jump2_shadow_on()
{
	common_scripts\utility::run_thread_on_targetname("trig_s_flicker_fluo_jump2_shadow_on",::play_s_flicker_fluo_jump2_shadow_on);
}

//Function Number: 97
play_s_flicker_fluo_jump2_shadow_on()
{
	self waittill("trigger");
	var_00 = getent("targ_s_flicker_fluo_jump2","targetname");
	var_00 setlightshadowstate("force_on");
	while(level.player istouching(self))
	{
		wait(0.1);
	}
}

//Function Number: 98
trigger_force_shadow_on_subcarback_firespot()
{
	if(level.nextgen)
	{
		common_scripts\utility::run_thread_on_targetname("trig_train_force_shadows_on",::force_shadow_on_subcarback_firespot);
	}
}

//Function Number: 99
force_shadow_on_subcarback_firespot()
{
	self waittill("trigger");
	var_00 = getent("flicker_fire_sinkhole_lower4","targetname");
	var_00 setlightshadowstate("force_on");
	while(level.player istouching(self))
	{
		wait(0.1);
	}
}

//Function Number: 100
trigger_force_shadow_off_subcarback_firespot()
{
	if(level.nextgen)
	{
		common_scripts\utility::run_thread_on_targetname("trig_train_force_shadows_off",::force_shadow_off_subcarback_firespot);
	}
}

//Function Number: 101
force_shadow_off_subcarback_firespot()
{
	self waittill("trigger");
	var_00 = getent("flicker_fire_sinkhole_lower4","targetname");
	var_00 setlightshadowstate("normal");
	while(level.player istouching(self))
	{
		wait(0.1);
	}
}

//Function Number: 102
trigger_enter_canal()
{
	common_scripts\utility::run_thread_on_targetname("seoul_canal_entrance",::vision_enter_canal);
}

//Function Number: 103
vision_enter_canal()
{
	for(;;)
	{
		self waittill("trigger");
		maps\_utility::vision_set_fog_changes("seoul_canal_entrance",2);
		while(level.player istouching(self))
		{
			wait(0.05);
		}
	}
}

//Function Number: 104
trigger_enter_hotel()
{
	common_scripts\utility::run_thread_on_targetname("seoul_hotel_interior",::vision_seoul_hotel_interior);
}

//Function Number: 105
vision_seoul_hotel_interior()
{
	for(;;)
	{
		self waittill("trigger");
		common_scripts\utility::flag_set("set_seoul_hotel_lighting");
		maps\_utility::vision_set_fog_changes("seoul_hotel_interior",1);
		level.player lightsetforplayer("seoul_hotel_top");
		level.player setclutforplayer("clut_seoul_hotel_atrium",1);
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 106
trigger_enter_hotel_lrg()
{
	common_scripts\utility::run_thread_on_targetname("seoul_hotel_interior_lrg",::vision_seoul_hotel_interior_lrg);
}

//Function Number: 107
vision_seoul_hotel_interior_lrg()
{
	for(;;)
	{
		self waittill("trigger");
		common_scripts\utility::flag_set("set_seoul_hotel_lighting_lrg");
		maps\_utility::vision_set_fog_changes("seoul_hotel_interior_lrg",1);
		if(level.nextgen)
		{
			level.player lightsetforplayer("seoul_hotel_lrg");
			maps\_utility::vision_set_fog_changes("seoul_hotel_interior_lrg",1);
		}
		else
		{
			level.player lightsetforplayer("seoul_convention_center");
			maps\_utility::vision_set_fog_changes("seoul_convention_center",1);
		}

		level.player setclutforplayer("clut_seoul_hotel_02",1);
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 108
trigger_seoul_exterior()
{
	common_scripts\utility::run_thread_on_targetname("seoul_exterior",::vision_seoul_exterior);
}

//Function Number: 109
vision_seoul_exterior()
{
	for(;;)
	{
		self waittill("trigger");
		maps\_utility::vision_set_fog_changes("seoul",1);
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 110
trigger_seoul_vista()
{
	common_scripts\utility::run_thread_on_targetname("seoul_vista",::vision_seoul_vista);
}

//Function Number: 111
vision_seoul_vista()
{
	for(;;)
	{
		self waittill("trigger");
		maps\_utility::vision_set_fog_changes("seoul_vista",1);
		level.player lightsetforplayer("seoul_vista");
		level.player setclutforplayer("clut_seoul_vista",0);
		while(level.player istouching(self))
		{
			wait(0.05);
		}
	}
}

//Function Number: 112
trigger_seoul_hotel_hallway_cg()
{
	common_scripts\utility::run_thread_on_targetname("seoul_hotel_hallway",::vision_seoul_hotel_hallway_cg);
}

//Function Number: 113
vision_seoul_hotel_hallway_cg()
{
	for(;;)
	{
		self waittill("trigger");
		maps\_utility::vision_set_fog_changes("seoul_hotel_hallway",1);
		level.player lightsetforplayer("seoul_vista");
		while(level.player istouching(self))
		{
			wait(0.05);
		}
	}
}

//Function Number: 114
trigger_seoul_streets_02()
{
	common_scripts\utility::run_thread_on_targetname("seoul_streets_02",::vision_seoul_streets_02);
}

//Function Number: 115
vision_seoul_streets_02()
{
	for(;;)
	{
		self waittill("trigger");
		if(level.nextgen)
		{
			maps\_utility::vision_set_fog_changes("seoul_streets_dimfog",1);
		}

		level.player lightsetforplayer("seoul_streets");
		disable_motion_blur();
		while(level.player istouching(self))
		{
			wait(0.05);
		}
	}
}

//Function Number: 116
trigger_seoul_streets_02_xx()
{
	common_scripts\utility::run_thread_on_targetname("seoul_streets_02_xx",::vision_seoul_streets_02_xx);
}

//Function Number: 117
vision_seoul_streets_02_xx()
{
	for(;;)
	{
		self waittill("trigger");
		if(level.nextgen)
		{
			maps\_utility::vision_set_fog_changes("seoul_streets_dimfog",1);
		}

		level.player lightsetforplayer("seoul_streets");
		while(level.player istouching(self))
		{
			wait(0.05);
		}
	}
}

//Function Number: 118
trigger_hotel_fall()
{
	common_scripts\utility::run_thread_on_targetname("seoul_hotel_fall",::motion_blur_fall);
}

//Function Number: 119
motion_blur_fall()
{
	for(;;)
	{
		self waittill("trigger");
		enable_motion_blur_rotation();
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 120
trigger_exit_hotel()
{
	common_scripts\utility::run_thread_on_targetname("exit_hotel_to_fob",::exit_hotel);
}

//Function Number: 121
exit_hotel()
{
	for(;;)
	{
		self waittill("trigger");
		common_scripts\utility::flag_set("enable_fob_lighting_trigger");
		if(level.nextgen)
		{
			maps\_utility::vision_set_fog_changes("seoul_streets",3);
		}

		level.player lightsetforplayer("seoul_streets");
		level.player setclutforplayer("clut_seoul_fob",1);
		thread fob_dof();
		thread fob_fire_lighting();
		if(level.nextgen)
		{
		}

		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 122
trigger_fall_to_hotel_lobby()
{
	common_scripts\utility::run_thread_on_targetname("fall_to_hotel_lobby",::enter_hotel_lobby);
}

//Function Number: 123
trigger_enter_hotel_lobby()
{
	common_scripts\utility::run_thread_on_targetname("enter_hotel_lobby",::enter_hotel_lobby);
}

//Function Number: 124
enter_hotel_lobby()
{
	for(;;)
	{
		self waittill("trigger");
		thread hotel_lobby_fire_lighting();
		level.player disablephysicaldepthoffieldscripting();
		thread disable_motion_blur();
		maps\_utility::vision_set_fog_changes("seoul_hotel_lobby",1);
		level.player lightsetforplayer("seoul_hotel_lobby");
		level.player setclutforplayer("clut_seoul_hotel_atrium",1);
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 125
hotel_lobby_fire_lighting()
{
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_medium","firelight_hotel_lobby_medium_01");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_medium","firelight_hotel_lobby_medium_02");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_small","firelight_hotel_lobby_small_01");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large","firelight_hotel_lobby_laseoulrge_01");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large","firelight_hotel_lobby_large_02");
}

//Function Number: 126
trigger_seoul_shopping()
{
	common_scripts\utility::run_thread_on_targetname("seoul_shopping",::vision_seoul_shopping);
	common_scripts\utility::run_thread_on_targetname("seoul_shopping_district",::lightset_seoul_shopping);
	common_scripts\_exploder::exploder(6425);
	common_scripts\utility::flag_set("set_seoul_shopping_district_start_lighting");
}

//Function Number: 127
vision_seoul_shopping()
{
	for(;;)
	{
		self waittill("trigger");
		maps\_utility::vision_set_fog_changes("seoul_shopping",1);
	}

	while(level.player istouching(self))
	{
		wait(0.1);
	}
}

//Function Number: 128
pod_light_strobe(param_00)
{
	wait(12.05);
}

//Function Number: 129
trigger_setup_shopping_restaraunt_interior_enter()
{
	common_scripts\utility::run_thread_on_targetname("trigger_shopping_restaraunt_bar_enter",::fog_setup_shopping_restaraunt_interior_enter);
}

//Function Number: 130
fog_setup_shopping_restaraunt_interior_enter()
{
	for(;;)
	{
		self waittill("trigger");
		maps\_utility::vision_set_fog_changes("seoul_shopping_district_interiors",2);
		level.player lightsetforplayer("seoul_shopping_int");
	}
}

//Function Number: 131
trigger_setup_shopping_restaraunt_interior_exit()
{
	common_scripts\utility::run_thread_on_targetname("trigger_shopping_restaraunt_bar_exit",::fog_setup_shopping_restaraunt_interior_exit);
}

//Function Number: 132
fog_setup_shopping_restaraunt_interior_exit()
{
	for(;;)
	{
		self waittill("trigger");
		maps\_utility::vision_set_fog_changes("seoul_shopping",2);
		level.player lightsetforplayer("seoul_shopping_district");
	}
}

//Function Number: 133
trigger_setup_shopping_walkway_pre_enter()
{
	common_scripts\utility::run_thread_on_targetname("trigger_shopping_walkway_pre_enter",::shadow_shopping_walkway_pre_enter);
}

//Function Number: 134
shadow_shopping_walkway_pre_enter()
{
	for(;;)
	{
		self waittill("trigger");
		var_00 = getent("prim_spot_walkway_skyfill1","targetname");
		var_00 setlightshadowstate("normal");
		var_01 = getent("prim_spot_walkway_skyfill2","targetname");
		var_01 setlightshadowstate("normal");
		maps\_utility::vision_set_fog_changes("seoul_shopping",2);
		level.player lightsetforplayer("seoul_shopping_district");
	}
}

//Function Number: 135
trigger_setup_shopping_walkway_enter()
{
	common_scripts\utility::run_thread_on_targetname("trigger_shopping_walkway_enter",::shadow_shopping_walkway_enter);
}

//Function Number: 136
shadow_shopping_walkway_enter()
{
	for(;;)
	{
		self waittill("trigger");
		var_00 = getent("prim_spot_walkway_skyfill1","targetname");
		var_00 setlightshadowstate("force_on");
		var_01 = getent("prim_spot_walkway_skyfill2","targetname");
		var_01 setlightshadowstate("force_on");
		maps\_utility::vision_set_fog_changes("seoul_shopping_district_interiors",2);
		level.player lightsetforplayer("seoul_shopping_int");
	}
}

//Function Number: 137
trigger_setup_shopping_walkway_exit()
{
	common_scripts\utility::run_thread_on_targetname("trigger_shopping_walkway_exit",::shadow_shopping_walkway_exit);
}

//Function Number: 138
shadow_shopping_walkway_exit()
{
	if(level.nextgen)
	{
		for(;;)
		{
			self waittill("trigger");
			var_00 = getent("prim_spot_walkway_skyfill1","targetname");
			var_00 setlightshadowstate("normal");
			var_01 = getent("prim_spot_walkway_skyfill2","targetname");
			var_01 setlightshadowstate("normal");
			var_02 = getent("prim_spot_bar_skyfill1","targetname");
			var_02 setlightshadowstate("normal");
		}
	}
}

//Function Number: 139
trigger_setup_bar2_enter()
{
	common_scripts\utility::run_thread_on_targetname("trigger_bar2_enter",::shadow_bar2_enter);
}

//Function Number: 140
shadow_bar2_enter()
{
	for(;;)
	{
		self waittill("trigger");
		if(level.nextgen)
		{
			var_00 = getent("prim_spot_bar_skyfill1","targetname");
			var_00 setlightshadowstate("force_on");
		}

		maps\_utility::vision_set_fog_changes("seoul_shopping_district_interiors",2);
		level.player lightsetforplayer("seoul_shopping_int");
	}
}

//Function Number: 141
trigger_setup_bar2_exit()
{
	common_scripts\utility::run_thread_on_targetname("trigger_bar2_exit",::shadow_bar2_exit);
}

//Function Number: 142
shadow_bar2_exit()
{
	if(level.nextgen)
	{
		for(;;)
		{
			self waittill("trigger");
			if(level.nextgen)
			{
				var_00 = getent("prim_spot_bar_skyfill1","targetname");
				var_00 setlightshadowstate("normal");
			}

			maps\_utility::vision_set_fog_changes("seoul_shopping",2);
			level.player lightsetforplayer("seoul_shopping_district");
		}
	}
}

//Function Number: 143
dof_triggers()
{
	level.player enablephysicaldepthoffieldscripting();
	level.player_dof_aperture = 2.5;
	common_scripts\utility::run_thread_on_targetname("dof_enable_interior",::dof_enable_interior);
	common_scripts\utility::run_thread_on_targetname("dof_enable_exterior",::dof_enable_exterior);
	common_scripts\utility::run_thread_on_targetname("dof_enable_start",::dof_enable_start);
}

//Function Number: 144
dof_enable_interior()
{
	self waittill("trigger");
	level.player setphysicaldepthoffield(3.5,100);
	level.player_dof_aperture = 2.8;
}

//Function Number: 145
dof_enable_exterior()
{
	self waittill("trigger");
	level.player setphysicaldepthoffield(11,100);
	level.player_dof_aperture = 8;
}

//Function Number: 146
dof_enable_start()
{
	self waittill("trigger");
	level.player setphysicaldepthoffield(2.8,30);
	level.player_dof_aperture = 4;
}

//Function Number: 147
bomb_plant_dof()
{
	enable_motion_blur_rotation();
	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(1.5,57);
	wait(2);
	level.player setphysicaldepthoffield(15,14,5,2);
	wait(1);
	level.player setphysicaldepthoffield(6,52,2,10);
	wait(4.3);
	level.player setphysicaldepthoffield(2.5,36,10,2);
	wait(2.3);
	level.player setphysicaldepthoffield(3.5,13.7,10,5);
	wait(0.45);
	level.player setphysicaldepthoffield(4.5,19,20,10);
	wait(4.1);
	level.player setphysicaldepthoffield(3.5,11.2,10,5);
	wait(0.55);
	level.player setphysicaldepthoffield(3.5,24,5,2);
	wait(2.8);
	level.player setphysicaldepthoffield(2.5,14.5,10,5);
	wait(0.4);
	level.player setphysicaldepthoffield(4.5,21,5,2);
	wait(3);
	level.player setphysicaldepthoffield(4.5,16,5,2);
	wait(0.6);
	level.player setphysicaldepthoffield(4.5,9,10,5);
	wait(0.5);
	level.player setphysicaldepthoffield(2.5,20,5,2);
	wait(2.5);
	level.player setphysicaldepthoffield(4.5,11,10,5);
	wait(0.5);
	level.player setphysicaldepthoffield(6,20,5,2);
	wait(1);
	level.player setphysicaldepthoffield(6,300,5,2);
	wait(0.8);
	level.player setphysicaldepthoffield(22,20,2);
	wait(1.7);
	level.player setphysicaldepthoffield(4,300,20,2);
	wait(0.5);
	level.player setphysicaldepthoffield(3,20,2);
	wait(2);
	level.player setphysicaldepthoffield(5,9.7,10,2);
	wait(0.4);
	level.player setphysicaldepthoffield(3,24,10,2);
	wait(1.8);
	level.player setphysicaldepthoffield(1.5,17.8,10,2);
	wait(0.4);
	level.player setphysicaldepthoffield(2,24,10,2);
	wait(0.7);
	level.player setphysicaldepthoffield(3,14.7,20,2);
	wait(3.2);
	level.player setphysicaldepthoffield(12,14,50,2);
	wait(2);
	level.player setphysicaldepthoffield(2.5,300,5,2);
	wait(10);
	level.player setphysicaldepthoffield(3,250,20,2);
	wait(2.5);
	level.player setphysicaldepthoffield(2.5,20,5,2);
	wait(7);
	level.player setphysicaldepthoffield(2.5,220,1,2);
	wait(6.5);
	level.player setphysicaldepthoffield(4,21,1,2);
	wait(2);
	level.player setphysicaldepthoffield(4,14.8,5,2);
	wait(2);
	level.player setphysicaldepthoffield(6,9,5,2);
	wait(2);
	level.player setphysicaldepthoffield(2.5,35,5,2);
	wait(3);
	level.player setphysicaldepthoffield(4,13,2,10);
	wait(1.5);
	level.player setphysicaldepthoffield(4,11.4,5,10);
	wait(1);
	level.player setphysicaldepthoffield(4,13,10,10);
	wait(1.5);
	level.player setphysicaldepthoffield(4,19.5,10,10);
	wait(2.2);
	level.player setphysicaldepthoffield(4,13,10,10);
	wait(7.3);
	level.player setphysicaldepthoffield(2.5,37,10,10);
	wait(3);
	level.player setphysicaldepthoffield(2.5,90,1,2);
}

//Function Number: 148
bomb_plant_dof_bokeh()
{
	enable_motion_blur_rotation();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",1);
	}

	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(1.5,57);
	wait(2);
	level.player setphysicaldepthoffield(13,14,5,2);
	wait(1);
	level.player setphysicaldepthoffield(2,52,5,10);
	wait(4.3);
	level.player setphysicaldepthoffield(1.5,36,10,2);
	wait(2.2);
	level.player setphysicaldepthoffield(2.5,13.7,3,5);
	wait(0.55);
	level.player setphysicaldepthoffield(3.5,19,20,10);
	wait(4.2);
	level.player setphysicaldepthoffield(4,11.2,8,5);
	wait(0.45);
	level.player setphysicaldepthoffield(2.5,24,12,2);
	wait(2.8);
	level.player setphysicaldepthoffield(1.5,14.5,10,5);
	wait(0.4);
	level.player setphysicaldepthoffield(5,21,10,2);
	wait(2.2);
	level.player setphysicaldepthoffield(3.5,17.6,10,2);
	wait(0.4);
	level.player setphysicaldepthoffield(3.5,21,5,2);
	wait(0.4);
	level.player setphysicaldepthoffield(3.5,16,5,2);
	wait(0.6);
	level.player setphysicaldepthoffield(5,9,5,5);
	wait(0.5);
	level.player setphysicaldepthoffield(1.5,20,20,2);
	wait(2.5);
	level.player setphysicaldepthoffield(8,11,5,10);
	wait(0.5);
	level.player setphysicaldepthoffield(4,20,5,2);
	wait(1);
	level.player setphysicaldepthoffield(4,300,5,2);
	wait(0.8);
	level.player setphysicaldepthoffield(22,20,20,2);
	wait(1.7);
	level.player setphysicaldepthoffield(4,300,20,2);
	wait(0.5);
	level.player setphysicaldepthoffield(2,20,2);
	wait(2);
	level.player setphysicaldepthoffield(4,9.7,10,2);
	wait(0.4);
	level.player setphysicaldepthoffield(2,24,10,2);
	wait(1.8);
	level.player setphysicaldepthoffield(1.5,17.8,10,2);
	wait(0.4);
	level.player setphysicaldepthoffield(1,24,10,2);
	wait(0.6);
	level.player setphysicaldepthoffield(2,14.7,10,2);
	wait(3.3);
	level.player setphysicaldepthoffield(6,14,50,2);
	wait(1.3);
	level.player setphysicaldepthoffield(0.5,24,2,1);
	wait(0.8);
	level.player setphysicaldepthoffield(100,1,20,10);
	wait(1.2);
	level.player setphysicaldepthoffield(12,1,40,20);
	wait(0.5);
	level.player setphysicaldepthoffield(100,1,20,10);
	wait(1.5);
	level.player setphysicaldepthoffield(7,1,20,10);
	wait(0.5);
	level.player setphysicaldepthoffield(100,1,20,10);
	wait(0.5);
	level.player setphysicaldepthoffield(5,1,20,10);
	wait(0.1);
	level.player setphysicaldepthoffield(100,1,20,10);
	wait(0.05);
	level.player setphysicaldepthoffield(15,1,20,10);
	wait(0.05);
	level.player setphysicaldepthoffield(12,1,20,10);
	wait(0.05);
	level.player setphysicaldepthoffield(100,1,20,10);
	wait(0.05);
	level.player setphysicaldepthoffield(11,1,20,10);
	wait(0.05);
	level.player setphysicaldepthoffield(100,1,20,10);
	wait(0.05);
	level.player setphysicaldepthoffield(9,1,20,10);
	wait(0.05);
	level.player setphysicaldepthoffield(100,1,20,10);
	wait(0.05);
	level.player setphysicaldepthoffield(12,1,20,10);
	wait(0.05);
	level.player setphysicaldepthoffield(100,1,20,10);
	wait(0.05);
	level.player setphysicaldepthoffield(8,1,20,10);
	wait(0.05);
	level.player setphysicaldepthoffield(100,1,20,10);
	wait(0.05);
	level.player setphysicaldepthoffield(10,1,20,10);
	wait(0.05);
	level.player setphysicaldepthoffield(100,1,20,10);
	wait(0.05);
	level.player setphysicaldepthoffield(8,1,20,10);
	wait(0.05);
	level.player setphysicaldepthoffield(100,1,20,10);
	wait(0.05);
	level.player setphysicaldepthoffield(7,1,20,10);
	wait(0.3);
	level.player setphysicaldepthoffield(100,1,20,10);
	wait(0.5);
	level.player setphysicaldepthoffield(6,1,20,10);
	wait(2);
	level.player setphysicaldepthoffield(100,1,2,1);
	wait(2);
	level.player setphysicaldepthoffield(2,250,20,2);
	wait(2.5);
	level.player setphysicaldepthoffield(0.5,20,5,2);
	wait(7);
	level.player setphysicaldepthoffield(1.5,220,1,2);
	wait(6.5);
	level.player setphysicaldepthoffield(3,21,1,2);
	wait(2);
	level.player setphysicaldepthoffield(3,14.8,5,2);
	wait(2);
	level.player setphysicaldepthoffield(4,9,5,2);
	wait(2);
	level.player setphysicaldepthoffield(1.5,35,5,2);
	wait(3);
	level.player setphysicaldepthoffield(3,13,2,10);
	wait(1.5);
	level.player setphysicaldepthoffield(3,11.4,5,10);
	wait(1);
	level.player setphysicaldepthoffield(3,13,10,10);
	wait(1.5);
	level.player setphysicaldepthoffield(3,19.5,10,10);
	wait(2.2);
	level.player setphysicaldepthoffield(3,13,10,10);
	wait(2.4);
	level.player setphysicaldepthoffield(3,10.9,10,10);
	wait(1.5);
	level.player setphysicaldepthoffield(3,12.5,5,10);
	wait(3);
	level.player setphysicaldepthoffield(1.5,37,10,10);
	wait(3);
	level.player setphysicaldepthoffield(1.5,90,1,2);
}

//Function Number: 149
lightset_seoul_shopping()
{
	self waittill("trigger");
	level.player lightsetforplayer("seoul_shopping_district");
	level.player setclutforplayer("clut_seoul_shopping",1);
	level.player_dof_aperture = 3;
	while(level.player istouching(self))
	{
		wait(0.1);
	}
}

//Function Number: 150
manage_force_shadow_lights()
{
	wait(0.05);
	common_scripts\utility::flag_init("force_light_01");
	var_00 = getent("shadowlight_01","targetname");
	for(;;)
	{
		common_scripts\utility::flag_wait("force_light_01");
		var_00 setlightshadowstate("force_on");
		common_scripts\utility::flag_waitopen("force_light_01");
		var_00 setlightshadowstate("force_off");
	}
}

//Function Number: 151
test()
{
	wait(0.05);
	common_scripts\utility::flag_wait("door_pop");
	common_scripts\utility::flag_wait("door_shut");
}

//Function Number: 152
intro_camera_blur()
{
	setblur(9,1);
	wait(3);
	setblur(0,1);
}

//Function Number: 153
notetrack_setup(param_00)
{
}

//Function Number: 154
finale_eyes_custom_mats_on()
{
	var_00 = level.cormack;
	var_01 = level.will_irons;
	if(level.nextgen)
	{
		var_00 overridematerial("mtl_cormack_eye_shader_l","mc/mtl_cormack_eye_shader_seoulpod_l");
		var_00 overridematerial("mtl_cormack_eye_shader_r","mc/mtl_cormack_eye_shader_seoulpod_r");
		return;
	}

	var_00 overridematerial("mtl_cormack_eye_shader_l","mqc/mtl_cormack_eye_shader_seoulpod_l");
	var_00 overridematerial("mtl_cormack_eye_shader_r","mqc/mtl_cormack_eye_shader_seoulpod_r");
}

//Function Number: 155
finale_mwp_lighting_offset()
{
	var_00 = level.weapon_platform_rigged;
	var_01 = var_00.origin;
	var_02 = getent("lighting_centroid_mwp","targetname");
	var_00 overridelightingorigin(var_02.origin);
}

//Function Number: 156
mwp_lighting_origin_offset_reset()
{
	var_00 = level.weapon_platform_rigged;
	wait(35);
	var_00 defaultlightingorigin();
}

//Function Number: 157
mwp_bombplant_reflection_probe_lightgrid_tweaks()
{
	var_00 = level.weapon_platform_rigged;
	wait(39);
	var_01 = getent("mwp_reflection","targetname");
}

//Function Number: 158
mwp_explosion_lightset_vig()
{
	wait(40.7);
	level.player lightsetforplayer("seoul_finexp_brightest");
	wait(0.1);
	level.player lightsetforplayer("seoul_finexp_dark");
	wait(0.3);
	level.player lightsetforplayer("seoul_finale");
	wait(1.6);
	level.player lightsetforplayer("seoul_finexp_brightest");
	wait(0.1);
	level.player lightsetforplayer("seoul_finexp_dark");
	wait(0.3);
	level.player lightsetforplayer("seoul_finale");
	wait(0.6);
	level.player lightsetforplayer("seoul_finexp_bright");
	wait(0.1);
	level.player lightsetforplayer("seoul_finale");
	wait(0.05);
	level.player lightsetforplayer("seoul_finexp_bright");
	wait(0.05);
	level.player lightsetforplayer("seoul_finexp_bright");
	wait(0.05);
	level.player lightsetforplayer("seoul_finale");
	wait(0.05);
	level.player lightsetforplayer("seoul_finexp_bright");
	wait(0.05);
	level.player lightsetforplayer("seoul_finale");
	wait(0.05);
	level.player lightsetforplayer("seoul_finexp_bright");
	wait(0.05);
	level.player lightsetforplayer("seoul_finale");
	wait(0.05);
	level.player lightsetforplayer("seoul_finexp_bright");
	wait(0.05);
	level.player lightsetforplayer("seoul_finale");
	wait(0.05);
	level.player lightsetforplayer("seoul_finexp_bright");
	wait(0.05);
	level.player lightsetforplayer("seoul_finale");
	wait(0.05);
	level.player lightsetforplayer("seoul_finexp_bright");
	wait(0.05);
	level.player lightsetforplayer("seoul_finale");
	wait(0.05);
	level.player lightsetforplayer("seoul_finexp_bright");
	wait(0.05);
	level.player lightsetforplayer("seoul_finale");
	wait(0.05);
	level.player lightsetforplayer("seoul_finexp_bright");
	wait(0.3);
	level.player lightsetforplayer("seoul_finexp_dark");
	wait(0.5);
	level.player lightsetforplayer("seoul_finexp_brightest");
	wait(0.5);
	level.player lightsetforplayer("seoul_finexp_dark");
	wait(0.5);
	level.player lightsetforplayer("seoul_finale");
}

//Function Number: 159
canal_wmp_key_tweaks()
{
	thread maps\_lighting::set_spot_intensity("light_left_big_key",24000000);
}

//Function Number: 160
pre_bomb_plant_lighting()
{
	var_00 = level.weapon_platform_rigged;
	thread finale_eyes_custom_mats_on();
	var_01 = -1;
	thread mwp_cine_optimize_will_key_left_pre_firerim();
	if(level.nextgen)
	{
		setsaveddvar("r_mbvelocityscalar","1");
	}

	if(level.nextgen)
	{
		maps\_lighting::set_spot_color("light_cine_key_rad",(0.101,0.2,0.515));
		setsaveddvar("r_mdaoCapsulestrength","1");
	}

	if(level.nextgen)
	{
		var_02 = getent("light_cine_key_rad","targetname");
		var_02 setlightfovrange(60,20);
		thread maps\_lighting::lerp_spot_intensity("light_cine_key_rad",1,80000);
	}

	wait(3.75);
}

//Function Number: 161
timing_offset_finale_cine_lighting()
{
	wait(0.62);
	thread bomb_plant_lighting();
	thread mwp_cine_optimize_will_key_left_post_firerim();
	thread bomb_plant_dof_bokeh();
	thread mwp_explosion_lightset_vig();
	thread mwp_cine_optimize_left_big_key_all();
	thread mwp_cine_optimize_weaplat_rim_all();
	thread mwp_lighting_origin_offset_reset();
	thread mwp_bombplant_reflection_probe_lightgrid_tweaks();
}

//Function Number: 162
bomb_plant_lighting()
{
	var_00 = level.weapon_platform_rigged;
	maps\_utility::vision_set_fog_changes("seoul_finale",1);
	var_01 = undefined;
	if(level.nextgen)
	{
		var_01 = getent("light_cine_key_rad","targetname");
	}

	level.player lightsetforplayer("seoul_finale");
	if(level.nextgen)
	{
		maps\_utility::lerp_saveddvar("r_mdaoCapsulestrength",0.25,1);
	}

	wait(1);
	wait(6.7);
	if(level.nextgen)
	{
		var_01 maps\_lighting::lerp_light_fov_range(60,20,20,5,1);
	}
}

//Function Number: 163
cine_fire_debris_stumble()
{
	wait(48);
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_medium_dim2","prim_debris_cine_fire");
	wait(30);
}

//Function Number: 164
mwp_cine_optimize_will_key_left_pre_firerim()
{
	if(level.nextgen)
	{
		wait(1);
		maps\_lighting::pause_flickerlight("firelight_motion_weaplat_rim","light_weaplat_rim");
		maps\_lighting::lerp_spot_intensity("light_weaplat_rim",2,0);
		wait(0.3);
		level.aden_key_fr = maps\_lighting::setup_scriptable_primary_light("light_weaplat_rim",1,(0,0,0),(0,0,0),0,(1,0.6549,0.5922),1,90,level.weapon_platform_rigged,"tag_left_pre_key",200);
		maps\_lighting::scriptable_primary_light_setstate(level.aden_key_fr,0,(0,0,0),(0,0,0),100000,undefined,1,90,200,0.25);
		maps\_lighting::execute_scriptable_primary_light(level.aden_key_fr);
	}
}

//Function Number: 165
mwp_cine_optimize_will_key_left_post_firerim()
{
	if(level.nextgen)
	{
		var_00 = getent("light_weaplat_rim","targetname");
		wait(2);
		maps\_lighting::stop_scriptable_primary_light(level.aden_key_fr);
		var_01 = maps\_lighting::setup_scriptable_primary_light("light_weaplat_rim",2,(0,0,0),(0,0,0),100000,(1,0.6549,0.5922),1,90,level.weapon_platform_rigged,"tag_left_in_key");
		maps\_lighting::execute_scriptable_primary_light(var_01);
		wait(30);
		maps\_lighting::stop_scriptable_primary_light(var_01);
		wait(0.05);
		var_02 = maps\_lighting::setup_scriptable_primary_light("light_weaplat_rim",3,(0,0,0),(0,0,0),1,(1,0.6549,0.5922),1,90,level.weapon_platform_rigged,"tag_left_in_key");
		maps\_lighting::scriptable_primary_light_setstate(var_02,0,(30,-15,-7),(-10,65,0),11266,undefined,12,49,28,1.5);
		maps\_lighting::execute_scriptable_primary_light(var_02);
		wait(11);
		maps\_lighting::stop_scriptable_primary_light(var_02);
		var_00 setlightradius(300);
	}
}

//Function Number: 166
mwp_cine_optimize_left_big_key_all()
{
	if(level.nextgen)
	{
		var_00 = getent("light_left_big_key","targetname");
		var_00 setlightshadowstate("force_on");
		var_01 = var_00.origin;
		var_02 = var_00.angles;
		var_03 = common_scripts\utility::getstruct("script_struct_light_left_cormack_run","targetname");
		var_04 = common_scripts\utility::getstruct("script_struct_light_a","targetname");
		var_05 = common_scripts\utility::getstruct("script_struct_light_c_pt1","targetname");
		var_06 = common_scripts\utility::getstruct("script_struct_light_c_pt2","targetname");
		var_07 = common_scripts\utility::getstruct("script_struct_light_c","targetname");
		var_08 = common_scripts\utility::getstruct("script_struct_light_d","targetname");
		maps\_lighting::set_spot_color("light_left_big_key",(1,0.608,0.459));
		wait(10);
		wait(0.5);
		wait(24);
		maps\_lighting::stop_flickerlight("firelight_motion_weaplat_flyup","light_weaplat_rim",0);
		thread maps\_lighting::lerp_spot_intensity("light_cine_key_rad",0.05,0);
		wait(1.85);
		var_00 maps\_lighting::lerp_light_fov_range(90,70,55,40,0.05);
		thread maps\_lighting::lerp_spot_intensity("light_left_big_key",0.05,4000000);
		lerp_origin_function(var_00,3,var_03.origin);
		lerp_angles_function(var_00,3,var_03.angles);
		wait(2.65);
		maps\_lighting::play_flickerlight_motion_preset("firelight_motion_weaplat_flyup","light_weaplat_rim");
		wait(19.5);
		thread maps\_lighting::lerp_spot_intensity("light_left_big_key",0.75,0.05);
		wait(0.75);
		var_00 maps\_lighting::lerp_light_fov_range(90,70,20,10,0.05);
		lerp_origin_function(var_00,0.05,var_04.origin);
		lerp_angles_function(var_00,0.05,var_04.angles);
		wait(0.05);
		thread maps\_lighting::lerp_spot_intensity("light_left_big_key",1.5,1500000);
		level.player setclutforplayer("clut_seoul_ending_v2",10);
		wait(5);
		thread maps\_lighting::lerp_spot_intensity("light_left_big_key",0.05,10000);
		var_00 maps\_lighting::lerp_light_fov_range(30,10,35,5,0.05);
		lerp_origin_function(var_00,0.2,var_07.origin);
		lerp_angles_function(var_00,0.2,var_05.angles);
		thread maps\_lighting::lerp_spot_intensity("light_left_big_key",3,320000);
		wait(1);
		var_00 maps\_lighting::lerp_light_fov_range(30,10,40,20,1);
		lerp_angles_function(var_00,2,var_06.angles);
		var_09 = getent("light_weaplat_rim","targetname");
		var_09 setlightshadowstate("force_off");
		wait(6.35);
		var_00 maps\_lighting::lerp_light_fov_range(40,20,40,30,0.05);
		lerp_origin_function(var_00,0.1,var_08.origin);
		lerp_angles_function(var_00,0.1,var_08.angles);
		wait(4.1);
		lerp_origin_function(var_00,0.1,var_04.origin);
		lerp_angles_function(var_00,0.1,var_04.angles);
	}
}

//Function Number: 167
mwp_cine_optimize_weaplat_rim_all()
{
	if(level.nextgen)
	{
		var_00 = getent("light_weaplat_rim","targetname");
		var_00 setlightshadowstate("force_on");
		var_01 = var_00.origin;
		var_02 = var_00.angles;
		var_03 = common_scripts\utility::getstruct("script_struct_light_cine_fire_body","targetname");
		var_04 = common_scripts\utility::getstruct("script_struct_light_cine_fire_cormack","targetname");
		maps\_lighting::stop_flickerlight("firelight_motion_weaplat_rim","light_weaplat_rim",0);
		maps\_lighting::stop_flickerlight("firelight_motion_weaplat_rim_dim","light_weaplat_rim",0);
		wait(47);
		maps\_lighting::stop_flickerlight("firelight_motion_weaplat_rim","light_weaplat_rim",0);
		maps\_lighting::stop_flickerlight("firelight_motion_weaplat_rim_dim","light_weaplat_rim",0);
		maps\_lighting::stop_flickerlight("firelight_motion_weaplat_rim_cormack","light_weaplat_rim",0);
		var_00 maps\_lighting::lerp_light_fov_range(120,80,90,30,0.05);
		lerp_origin_function(var_00,0.05,var_03.origin);
		lerp_angles_function(var_00,0.05,var_03.angles);
		maps\_lighting::play_flickerlight_motion_preset("firelight_motion_weaplat_rim_body","light_weaplat_rim");
		wait(15);
		var_00 maps\_lighting::lerp_light_fov_range(90,30,30,10,2);
		maps\_lighting::stop_flickerlight("firelight_motion_weaplat_rim","light_weaplat_rim",0);
		maps\_lighting::stop_flickerlight("firelight_motion_weaplat_rim_dim","light_weaplat_rim",0);
		maps\_lighting::stop_flickerlight("firelight_motion_weaplat_rim_cormack","light_weaplat_rim",0);
		maps\_lighting::stop_flickerlight("firelight_motion_weaplat_rim_body","light_weaplat_rim",0);
		lerp_origin_function(var_00,0.05,var_04.origin);
		lerp_angles_function(var_00,0.05,var_04.angles);
		maps\_lighting::set_spot_color("light_weaplat_rim",(0.3791,0.5788,1));
		thread maps\_lighting::lerp_spot_intensity("light_weaplat_rim",0.05,8000);
		var_00 maps\_lighting::lerp_light_fov_range(10,1,90,30,3);
		wait(8);
		thread maps\_lighting::lerp_spot_intensity("light_weaplat_rim",0.05,2000);
		wait(10.5);
		thread maps\_lighting::set_spot_intensity("light_weaplat_rim",320000);
		maps\_lighting::set_spot_color("light_weaplat_rim",(1,0.346,0.0467));
		var_00 setlightshadowstate("force_on");
		maps\_lighting::stop_flickerlight("firelight_motion_weaplat_rim_body","light_weaplat_rim",0);
		maps\_lighting::stop_flickerlight("firelight_motion_weaplat_rim_cormack","light_weaplat_rim",0);
		var_00 maps\_lighting::lerp_light_fov_range(120,80,90,30,0.05);
		lerp_origin_function(var_00,0.05,var_03.origin);
		lerp_angles_function(var_00,0.05,var_03.angles);
		maps\_lighting::play_flickerlight_motion_preset("firelight_motion_weaplat_rim_body","light_weaplat_rim");
	}
}

//Function Number: 168
mwp_cine_lighhting_radspot()
{
	if(level.nextgen)
	{
		maps\_lighting::set_spot_color("light_cine_finale_left_key_a",(1,0.508,0.332));
		maps\_lighting::set_spot_color("light_cine_finale_left_key_d",(1,0.508,0.332));
		thread maps\_lighting::lerp_spot_intensity("light_cine_finale_left_key_a",3,1);
		thread maps\_lighting::lerp_spot_intensity("light_cine_finale_left_key_d",1,1);
		wait(10);
		thread maps\_lighting::lerp_spot_intensity("light_weaplat_rim",1,1);
		maps\_lighting::stop_flickerlight("firelight_motion_weaplat_rim_dim","light_weaplat_rim",0);
		wait(0.5);
		maps\_lighting::play_flickerlight_motion_preset("firelight_motion_weaplat_flyup","light_weaplat_rim");
		wait(24);
		maps\_lighting::stop_flickerlight("firelight_motion_weaplat_flyup","light_weaplat_rim",0);
		wait(4.5);
		maps\_lighting::play_flickerlight_motion_preset("firelight_motion_weaplat_flyup","light_weaplat_rim");
		wait(3);
		thread maps\_lighting::lerp_spot_intensity("light_left_big_key",1,1);
		var_00 = getent("light_left_big_key","targetname");
		var_00 setlightshadowstate("force_off");
		wait(2);
		level.player setclutforplayer("clut_seoul_ending_v2",10);
		thread maps\_lighting::lerp_spot_intensity("light_cine_finale_left_key_a",1,1280000);
		wait(15);
		var_01 = getent("light_cine_finale_left_key_a","targetname");
		var_01 maps\_lighting::lerp_light_fov_range(80,10,15,1,1);
		wait(7);
		maps\_lighting::stop_flickerlight("firelight_motion_weaplat_flyup","light_weaplat_rim",0);
		var_02 = getent("light_weaplat_rim","targetname");
		var_02 setlightshadowstate("force_off");
		wait(1.5);
		wait(1.5);
		wait(0.7);
		thread maps\_lighting::lerp_spot_intensity("light_cine_finale_left_key_a",0.5,1280000);
		var_01 = getent("light_cine_finale_left_key_a","targetname");
		var_01 maps\_lighting::lerp_light_fov_range(15,1,70,10,0.1);
		wait(0.3);
		var_03 = getent("light_cine_finale_left_key_a","targetname");
		var_04 = common_scripts\utility::getstruct("script_struct_light_c","targetname");
		lerp_origin_function(var_03,0.6,var_04.origin);
		wait(1.5);
		thread maps\_lighting::lerp_spot_intensity("light_cine_finale_left_key_a",2,320000);
		var_01 maps\_lighting::lerp_light_fov_range(70,10,60,5,2);
		var_01 = getent("light_cine_finale_left_key_d","targetname");
		var_01 maps\_lighting::lerp_light_fov_range(90,1,50,1,0.2);
		wait(6.5);
		thread maps\_lighting::lerp_spot_intensity("light_cine_finale_left_key_d",2,800000);
		var_05 = getent("light_cine_finale_left_key_d","targetname");
		var_05 setlightshadowstate("force_on");
		wait(2);
		thread maps\_lighting::lerp_spot_intensity("light_cine_finale_left_key_a",1,1);
		wait(2);
		var_05 = getent("light_cine_finale_left_key_d","targetname");
		thread maps\_lighting::lerp_spot_intensity("light_cine_finale_left_key_a",1,40000);
	}
}

//Function Number: 169
mwp_cine_lighhting_fx()
{
	level waittill("panel_close_wait");
	var_00 = level.weapon_platform_rigged;
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(level.will_irons,"J_head",(5,-5,-8),(0,0,0),0);
	var_02 = common_scripts\utility::spawn_tag_origin();
	var_02 linkto(level.will_irons,"J_head",(4,-4,9),(0,0,0),0);
	if(level.nextgen)
	{
		maps\_utility::lerp_saveddvar("r_mdaoCapsulestrength",0.25,2);
	}

	wait(4.65);
	wait(0.05);
	playfxontag(common_scripts\utility::getfx("light_left_shut_blink"),var_00,"tag_left_key");
	wait(14.8);
	var_03 = common_scripts\utility::spawn_tag_origin();
	var_03 linkto(level.will_irons,"J_head",(0,-6,7),(0,0,0),0);
	wait(3.5);
	wait(1.8);
	var_04 = common_scripts\utility::spawn_tag_origin();
	var_04 linkto(level.will_irons,"J_head",(0,5,-4),(0,0,0),0);
	if(level.nextgen)
	{
		var_05 = getent("light_cine_key_rad","targetname");
		var_05 setlightshadowstate("force_off");
	}

	wait(2);
	if(level.nextgen)
	{
		maps\_utility::lerp_saveddvar("r_mdaoCapsulestrength",0.15,1);
	}

	wait(3.95);
	level.player lightsetforplayer("seoul_mad");
	wait(2);
	killfxontag(common_scripts\utility::getfx("light_left_shut_spot"),var_00,"tag_left_key");
	wait(0.05);
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("light_cine_key_rad",0,1);
	}

	wait(2);
	wait(1.5);
	killfxontag(common_scripts\utility::getfx("light_left_shut_blink"),var_00,"tag_left_key");
	level.player thread maps\_lighting::screen_effect_base(200,"ac130_overlay_pip_vignette",0,0,0.1,0,0);
	wait(0.1);
	if(level.nextgen)
	{
		maps\_utility::lerp_saveddvar("r_mdaoCapsulestrength",0.4,1);
	}

	wait(2.3);
	wait(2);
	wait(2);
	if(level.nextgen)
	{
		setsaveddvar("r_eyepupil",".1");
	}

	wait(2.5);
	level.player lightsetforplayer("seoul_fin_cormack");
	wait(3.35);
	level.player thread maps\_lighting::screen_effect_base(200,"ac130_overlay_pip_vignette",0,0,0.2,0,0);
	wait(6.65);
	var_06 = common_scripts\utility::spawn_tag_origin();
	var_06 linkto(level.cormack,"J_head",(3,8,0),(0,0,0),0);
	wait(4);
	var_07 = common_scripts\utility::spawn_tag_origin();
	var_07 linkto(level.cormack,"J_head",(4,-4,9),(0,0,0),0);
	wait(7.5);
	level.player thread maps\_lighting::screen_effect_base(40,"ac130_overlay_pip_vignette",3,0,0.7,0,0);
	wait(2.5);
	wait(2.9);
	wait(12);
	wait(0.1);
	killfxontag(common_scripts\utility::getfx("light_face_cormack_r"),var_07,"tag_origin");
}

//Function Number: 170
light_cine_fire()
{
	common_scripts\_exploder::exploder("exp_light_cine_fire_cormack");
}

//Function Number: 171
hide_brushes()
{
	var_00 = getentarray("hide_screens","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] hide();
	}
}

//Function Number: 172
finale_part1_cineviewmodel_lighting(param_00)
{
}

//Function Number: 173
finale_cineviewmodel_lighting(param_00)
{
	var_01 = getent("lighting_centroid_viewmodel","targetname");
	param_00 overridelightingorigin(param_00.origin);
	var_02 = level.cormack;
	var_03 = getent("lighting_centroid_cormac","targetname");
	var_03 linkto(var_02,"J_Head");
	var_02 overridelightingorigin(var_03.origin);
}

//Function Number: 174
fob_street_dof()
{
	common_scripts\utility::flag_wait("dof_fob");
	level.player enablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		level.player setphysicaldepthoffield(2,200,20,20);
	}
	else
	{
		level.player setphysicaldepthoffield(20,10000,20,20);
	}

	common_scripts\utility::flag_waitopen("dof_fob");
	thread enable_physical_dof_hip();
}

//Function Number: 175
plane_spots()
{
	thread maps\_lighting::lerp_spot_intensity("plane_lights_01",0.05,400000);
	wait(0.05);
	thread maps\_lighting::lerp_spot_intensity("plane_lights_02",0.05,400000);
	wait(0.1);
	thread maps\_lighting::lerp_spot_intensity("plane_lights_01",0.5,3000);
	wait(0.1);
	thread maps\_lighting::lerp_spot_intensity("plane_lights_02",0.5,3000);
	wait(1.5);
	thread maps\_lighting::lerp_spot_intensity("plane_lights_01",0.05,3000000);
	wait(0.05);
	thread maps\_lighting::lerp_spot_intensity("plane_lights_02",0.05,3000000);
	wait(0.5);
	thread maps\_lighting::lerp_spot_intensity("plane_lights_01",1,3000);
	wait(0.1);
	thread maps\_lighting::lerp_spot_intensity("plane_lights_02",1,3000);
}

//Function Number: 176
bomb_light(param_00)
{
	param_00.light = common_scripts\utility::spawn_tag_origin();
	var_01 = param_00.light;
	var_01 linkto(param_00,"tag_origin",(0,0,0),(0,0,0),0);
	wait(3.75);
	playfxontag(common_scripts\utility::getfx("light_blink_red"),var_01,"tag_origin");
	common_scripts\utility::flag_wait("cleanup_finale_explosive");
	stopfxontag(common_scripts\utility::getfx("light_blink_red"),var_01,"tag_origin");
}

//Function Number: 177
reflection_pod_guys(param_00,param_01,param_02,param_03)
{
	wait 0.05;
	var_04 = getent("pod_orange_reflection","targetname");
	var_05 = getent("pod_reflection","targetname");
	var_06 = getent("main_street_reflection","targetname");
	if(level.nextgen)
	{
		var_07 = getent("pod_reflection_lighter","targetname");
		var_08 = getent("fly_in_reflection","targetname");
	}
	else
	{
		var_07 = getent("main_street_reflection","targetname");
		var_08 = getent("main_street_reflection","targetname");
	}

	foreach(var_0A in param_00)
	{
		var_0A overridereflectionprobe(param_01.origin);
	}
}

//Function Number: 178
reflection_pod_guys_landing(param_00,param_01,param_02,param_03)
{
	setsaveddvar("r_lightGridDefaultFXLightingLookup",(36131,1697.47,1819.99));
	setsaveddvar("r_lightGridDefaultModelLightingLookup",(36131,1697.47,1819.99));
	var_04 = getent("red_reflection_01","targetname");
	foreach(var_06 in param_00)
	{
		var_06 overridereflectionprobe(var_04.origin);
	}
}

//Function Number: 179
reflection_pod_guys2(param_00,param_01,param_02,param_03)
{
	wait(2.8);
	foreach(var_05 in param_00)
	{
		var_05 defaultreflectionprobe();
	}

	wait(25);
	thread force_shadow_hotel();
}

//Function Number: 180
force_shadow_hotel()
{
	if(level.nextgen)
	{
		var_00 = getent("firelight_hotel_small_11","targetname");
		var_00 setlightshadowstate("force_on");
		level waittill("hotel_fall");
		var_00 setlightshadowstate("force_off");
	}
}

//Function Number: 181
intro_spotlight_setup()
{
	level.player thread maps\_lighting::screen_effect_base(0,"ac130_overlay_pip_vignette",0,0,1,0,0);
	var_00 = getent("pre_pod_key","targetname");
	if(level.nextgen)
	{
		var_01 = maps\_lighting::setup_scriptable_primary_light("pre_pod_fill",1,(17.64,25.16,39.2),(4.24,-101,0),400,(1,0.26,0.1),60,120,level.cormack_intro,"tag_origin",250);
		maps\_lighting::execute_scriptable_primary_light(var_01);
		var_02 = undefined;
		var_03 = common_scripts\utility::getstruct("pod_fill_cormac","targetname");
		var_04 = common_scripts\utility::getstruct("pod_key_cormac","targetname");
		maps\_lighting::set_spot_color("pre_pod_key",(0.35,0.75,1));
		thread maps\_lighting::lerp_spot_intensity("pre_pod_key",0,600);
		wait(1);
		var_00 setlightradius(250);
		wait(7);
		wait(5);
		thread maps\_lighting::lerp_spot_intensity("pre_pod_key",4,1550);
		wait(8);
		maps\_lighting::stop_scriptable_primary_light(var_01);
		wait(0.05);
		var_05 = maps\_lighting::setup_scriptable_primary_light("pre_pod_fill",1,(0,-26.7,32.6),(4.24,-101.02,0),500,(0.63,0.73,1),60,120,level.cormack_intro,"tag_origin",100);
		maps\_lighting::execute_scriptable_primary_light(var_05);
		wait(15);
		maps\_lighting::stop_scriptable_primary_light(var_05);
		var_00 setlightradius(250);
		wait(0.05);
		return;
	}

	maps\_lighting::set_spot_color("pre_pod_key",(0.35,1,0.757));
	thread maps\_lighting::lerp_spot_intensity("pre_pod_key",0,60);
	wait(1);
	var_00 setlightradius(250);
	wait(38.1);
	var_00 setlightradius(250);
	wait(0.05);
}

//Function Number: 182
pod_cormack_custom_mats_on()
{
	var_00 = level.cormack_intro;
	var_01 = level.will_irons_intro;
	if(level.nextgen)
	{
		var_00 overridematerial("mtl_cormack_eye_shader_l","mc/mtl_cormack_eye_shader_seoulpod_l");
		var_00 overridematerial("mtl_cormack_eye_shader_r","mc/mtl_cormack_eye_shader_seoulpod_r");
		var_01 overridematerial("mtl_burke_eye_shader_l","mc/mtl_burke_eye_shader_seoulpod_l");
		var_01 overridematerial("mtl_burke_eye_shader_r","mc/mtl_burke_eye_shader_seoulpod_r");
		return;
	}

	var_00 overridematerial("mtl_cormack_eye_shader_l","mqc/mtl_cormack_eye_shader_seoulpod_l");
	var_00 overridematerial("mtl_cormack_eye_shader_r","mqc/mtl_cormack_eye_shader_seoulpod_r");
	var_01 overridematerial("mtl_burke_eye_shader_l","mqc/mtl_burke_eye_shader_seoulpod_l");
	var_01 overridematerial("mtl_burke_eye_shader_r","mqc/mtl_burke_eye_shader_seoulpod_r");
}

//Function Number: 183
pod_cormack_custom_mats_landing_on()
{
	var_00 = level.cormack;
	var_01 = level.will_irons;
	if(level.nextgen)
	{
		var_00 overridematerial("mtl_cormack_eye_shader_l","mc/mtl_cormack_eye_shader_seoulpod_l");
		var_00 overridematerial("mtl_cormack_eye_shader_r","mc/mtl_cormack_eye_shader_seoulpod_r");
		var_01 overridematerial("mtl_burke_eye_shader_l","mc/mtl_burke_eye_shader_seoulpod_l");
		var_01 overridematerial("mtl_burke_eye_shader_r","mc/mtl_burke_eye_shader_seoulpod_r");
	}
	else
	{
		var_00 overridematerial("mtl_cormack_eye_shader_l","mqc/mtl_cormack_eye_shader_seoulpod_l");
		var_00 overridematerial("mtl_cormack_eye_shader_r","mqc/mtl_cormack_eye_shader_seoulpod_r");
		var_01 overridematerial("mtl_burke_eye_shader_l","mqc/mtl_burke_eye_shader_seoulpod_l");
		var_01 overridematerial("mtl_burke_eye_shader_r","mqc/mtl_burke_eye_shader_seoulpod_r");
	}

	level waittill("player_drop_pod_door_kick");
	wait(2.8);
	var_00 overridematerialreset();
	var_01 overridematerialreset();
}

//Function Number: 184
blimp_scripted_lights(param_00)
{
	if(level.nextgen)
	{
		var_01 = maps\_lighting::setup_scriptable_primary_light("pre_pod_key",0,(-5.57,-23.27,40.18),(-2,-78,0),40000,(0.63,0.73,1),80,120,param_00,"tag_origin");
		maps\_lighting::execute_scriptable_primary_light(var_01);
		level waittill("pod_lights_on");
		maps\_lighting::stop_scriptable_primary_light(var_01);
		return;
	}

	var_01 = maps\_lighting::setup_scriptable_primary_light("pre_pod_key",0,(-5.57,-23.27,40.18),(-2,-78,0),40000,(0.63,0.73,1),80,120,var_01,"tag_origin");
	maps\_lighting::execute_scriptable_primary_light(var_01);
	level waittill("pod_lights_on");
	maps\_lighting::stop_scriptable_primary_light(var_01);
}

//Function Number: 185
pod_scripted_lights(param_00)
{
	var_01 = getent("main_street_reflection","targetname");
	var_02 = anglestoforward((30,30,0));
	var_03 = anglestoforward((0,-20,0));
	param_00.door_open_blue = common_scripts\utility::spawn_tag_origin();
	var_04 = param_00.door_open_blue;
	var_04 linkto(param_00,"body_animate_joint",(-20,60,20),(0,-20,0),0);
	var_05 = undefined;
	var_06 = undefined;
	if(level.nextgen)
	{
		var_05 = maps\_lighting::setup_scriptable_primary_light("pre_pod_key",0,(-5.57,-23.27,40.18),(-2,-78,0),350,(0.63,0.73,1),60,100,level.cormack_intro,"tag_origin");
		var_06 = maps\_lighting::setup_scriptable_primary_light("pre_pod_fill",1,(-29.84,-47.8,58.47),(18.98,26.71,0),50,(1,0.25,0),60,100,level.cormack_intro,"tag_origin");
	}
	else
	{
		var_05 = maps\_lighting::setup_scriptable_primary_light("pre_pod_key",0,(-5.57,-23.27,40.18),(-2,-78,0),60,(0.63,0.73,1),60,100,level.cormack_intro,"tag_origin");
		var_06 = maps\_lighting::setup_scriptable_primary_light("pre_pod_fill",1,(-29.84,-47.8,58.47),(18.98,26.71,0),200,(1,0.25,0),60,100,level.cormack_intro,"tag_origin");
	}

	wait(0.05);
	level.player lightsetforplayer("seoul_intro_outside");
	if(level.nextgen)
	{
		maps\_lighting::execute_scriptable_primary_light(var_05);
		maps\_lighting::execute_scriptable_primary_light(var_06);
	}
	else
	{
		maps\_lighting::execute_scriptable_primary_light(var_05);
	}

	wait(3);
	wait(5.1);
	level.player lightsetforplayer("seoul_intro");
	if(level.nextgen)
	{
		maps\_lighting::stop_scriptable_primary_light(var_05);
		maps\_lighting::stop_scriptable_primary_light(var_06);
	}
	else
	{
		maps\_lighting::stop_scriptable_primary_light(var_05);
	}

	wait(0.05);
	level.player lightsetforplayer("seoul_intro");
	var_07 = undefined;
	var_08 = undefined;
	if(level.nextgen)
	{
		var_07 = maps\_lighting::setup_scriptable_primary_light("pre_pod_key",0,(-12.8,-35.31,58.13),(8,68,0),500,(0.63,0.73,1),60,100,level.cormack_intro,"tag_origin",80);
		var_08 = maps\_lighting::setup_scriptable_primary_light("pre_pod_fill",1,(24.8,12.42,47.52),(2.93,-149.42,0),80,(1,0.25,0.1),60,100,level.cormack_intro,"tag_origin",80);
		maps\_lighting::execute_scriptable_primary_light(var_07);
		maps\_lighting::execute_scriptable_primary_light(var_08);
	}
	else
	{
		var_07 = maps\_lighting::setup_scriptable_primary_light("pre_pod_key",0,(-12.8,-35.31,58.13),(8,68,0),500,(0.63,0.73,1),60,100,level.cormack_intro,"tag_origin",80);
		maps\_lighting::execute_scriptable_primary_light(var_07);
	}

	wait(3);
	level.player lightsetforplayer("seoul_intro_outside");
	wait(4);
	level.player lightsetforplayer("seoul_intro_missle_hit");
	if(level.nextgen)
	{
		maps\_lighting::stop_scriptable_primary_light(var_07);
		maps\_lighting::stop_scriptable_primary_light(var_08);
	}
	else
	{
		maps\_lighting::stop_scriptable_primary_light(var_07);
	}

	wait(0.05);
	var_09 = undefined;
	var_0A = undefined;
	if(level.nextgen)
	{
		var_09 = maps\_lighting::setup_scriptable_primary_light("pre_pod_key",0,(-5.5,-37.37,51.89),(3.7,58,0),130,(0.63,0.73,1),60,100,level.cormack_intro,"tag_origin",200);
		var_0A = maps\_lighting::setup_scriptable_primary_light("pre_pod_fill",1,(-25.43,-15.49,45.5),(-1.4,-27,0),800,(1,1,1),60,100,level.cormack_intro,"tag_origin",200);
		maps\_lighting::execute_scriptable_primary_light(var_09);
		maps\_lighting::execute_scriptable_primary_light(var_0A);
	}
	else
	{
		var_09 = maps\_lighting::setup_scriptable_primary_light("pre_pod_key",0,(-5.5,-37.37,51.89),(3.7,58,0),130,(0.63,0.73,1),60,100,level.cormack_intro,"tag_origin",200);
		maps\_lighting::execute_scriptable_primary_light(var_09);
	}

	wait(1.5);
	playfxontag(common_scripts\utility::getfx("pod_godray"),var_04,"tag_origin");
	common_scripts\utility::flag_wait("door_pop");
	wait(0.5);
	level.player lightsetforplayer("seoul_intro_bright");
	maps\_utility::vision_set_fog_changes("seoul_space_entry_bright",0.5);
	killfxontag(common_scripts\utility::getfx("pod_godray"),var_04,"tag_origin");
	if(level.nextgen)
	{
		maps\_lighting::stop_scriptable_primary_light(var_09);
		maps\_lighting::stop_scriptable_primary_light(var_0A);
	}
	else
	{
		maps\_lighting::stop_scriptable_primary_light(var_09);
	}

	wait(0.05);
	var_0B = undefined;
	var_0C = undefined;
	if(level.nextgen)
	{
		var_0B = maps\_lighting::setup_scriptable_primary_light("pre_pod_key",0,(-5.5,-37.37,51.89),(3.7,58,0),2000,(0.3,0.6,1),60,100,level.cormack_intro,"tag_origin",200);
		var_0C = maps\_lighting::setup_scriptable_primary_light("pre_pod_fill",1,(41.79,-7.24,18.23),(-3,135.7,0),35,(0.3,0.6,1),60,100,level.cormack_intro,"tag_origin",200);
		maps\_lighting::execute_scriptable_primary_light(var_0B);
		maps\_lighting::execute_scriptable_primary_light(var_0C);
	}
	else
	{
		var_0B = maps\_lighting::setup_scriptable_primary_light("pre_pod_key",0,(-5.5,-37.37,51.89),(3.7,58,0),2000,(0.3,0.6,1),60,100,level.cormack_intro,"tag_origin",200);
		maps\_lighting::execute_scriptable_primary_light(var_0C);
	}

	wait(0.75);
	playfxontag(common_scripts\utility::getfx("pod_light_spot_blue"),var_04,"tag_origin");
	wait(0.75);
	level.player lightsetforplayer("seoul_intro");
	maps\_utility::vision_set_fog_changes("seoul_space_entry",2);
	common_scripts\utility::flag_wait("door_shut");
	killfxontag(common_scripts\utility::getfx("pod_light_spot_blue"),var_04,"tag_origin");
	if(level.nextgen)
	{
		maps\_lighting::stop_scriptable_primary_light(var_0B);
		maps\_lighting::stop_scriptable_primary_light(var_0C);
	}
	else
	{
		maps\_lighting::stop_scriptable_primary_light(var_0B);
	}

	wait(0.05);
	var_0D = undefined;
	var_0E = undefined;
	if(level.nextgen)
	{
		var_0D = maps\_lighting::setup_scriptable_primary_light("pre_pod_key",0,(5.4,-27.36,107),(84,130,0),12000,(1,0.02,0),30,119,level.cormack_intro,"tag_origin",250);
		var_0E = maps\_lighting::setup_scriptable_primary_light("pre_pod_fill",1,(-5.16,-45.15,77.9),(84,130,0),4200,(1,0.15,0.18),60,119,level.cormack_intro,"tag_origin",250);
		maps\_lighting::execute_scriptable_primary_light(var_0D);
		maps\_lighting::execute_scriptable_primary_light(var_0E);
	}
	else
	{
		var_0D = maps\_lighting::setup_scriptable_primary_light("pre_pod_key",0,(5.4,-27.36,107),(84,130,0),12000,(1,0.02,0),30,119,level.cormack_intro,"tag_origin",250);
		maps\_lighting::execute_scriptable_primary_light(var_0D);
	}

	wait(8);
	if(level.nextgen)
	{
		maps\_lighting::stop_scriptable_primary_light(var_0D);
		maps\_lighting::stop_scriptable_primary_light(var_0E);
	}
	else
	{
		maps\_lighting::stop_scriptable_primary_light(var_0D);
	}

	wait(0.05);
	var_0F = undefined;
	var_10 = undefined;
	if(level.nextgen)
	{
		var_0F = maps\_lighting::setup_scriptable_primary_light("pre_pod_key",0,(5.4,-27.36,107),(84,130,0),12000,(0.125,0.43,0),30,119,level.cormack_intro,"tag_origin",250);
		var_10 = maps\_lighting::setup_scriptable_primary_light("pre_pod_fill",1,(-5.16,-45.15,77.9),(84,130,0),4200,(0,0.86,0.5),60,119,level.cormack_intro,"tag_origin",250);
		maps\_lighting::execute_scriptable_primary_light(var_0F);
		maps\_lighting::execute_scriptable_primary_light(var_10);
	}
	else
	{
		var_0F = maps\_lighting::setup_scriptable_primary_light("pre_pod_key",0,(5.4,-27.36,107),(84,130,0),12000,(0.125,0.43,0),30,119,level.cormack_intro,"tag_origin",250);
		maps\_lighting::execute_scriptable_primary_light(var_0F);
	}

	wait(3);
	if(level.nextgen)
	{
		level.player lightsetforplayer("seoul_intro_outside_dim");
	}

	if(level.nextgen)
	{
		maps\_lighting::stop_scriptable_primary_light(var_0F);
		maps\_lighting::stop_scriptable_primary_light(var_10);
	}
	else
	{
		maps\_lighting::stop_scriptable_primary_light(var_0F);
	}

	wait(3.7);
	if(level.nextgen)
	{
		level.player lightsetforplayer("seoul_intro_outside_hit");
	}

	wait(0.4);
	level.player lightsetforplayer("seoul_intro_outside_dim");
}

//Function Number: 186
pod_light_intro_pre(param_00)
{
	var_01 = level.will_irons_intro;
	param_00.lens_left = common_scripts\utility::spawn_tag_origin();
	var_02 = param_00.lens_left;
	param_00.lens_right = common_scripts\utility::spawn_tag_origin();
	var_03 = param_00.lens_right;
	param_00.redfill = common_scripts\utility::spawn_tag_origin();
	var_04 = param_00.redfill;
	var_03 linkto(param_00,"body_animate_joint",(-30,68,31),(0,-90,90),0);
	var_04 linkto(var_01,"J_Head",(0,0,0),(0,0,0),0);
	wait(9);
	playfxontag(common_scripts\utility::getfx("seo_lens_pod"),var_03,"tag_origin");
	wait(16);
	wait(4);
	killfxontag(common_scripts\utility::getfx("seo_lens_pod"),var_03,"tag_origin");
	if(level.nextgen)
	{
		level.player lightsetforplayer("seoul_intro_outside_light");
	}

	wait(10);
	level.player lightsetforplayer("seoul_intro_outside");
}

//Function Number: 187
pod_light_intro(param_00)
{
	if(level.currentgen)
	{
		maps\_utility::vision_set_fog_changes("seoul_pre_space_entry",0.1);
	}

	common_scripts\utility::flag_wait("dialogue_droppod_intro_phase_2b");
	var_01 = level.cormack_intro;
	setsaveddvar("r_lightgridintensity",0);
	param_00.interior_sun = common_scripts\utility::spawn_tag_origin();
	var_02 = param_00.interior_sun;
	param_00.interior_light_red = common_scripts\utility::spawn_tag_origin();
	var_03 = param_00.interior_light_red;
	param_00.interior_light_red_ending = common_scripts\utility::spawn_tag_origin();
	var_04 = param_00.interior_light_red_ending;
	param_00.redfill = common_scripts\utility::spawn_tag_origin();
	var_05 = param_00.redfill;
	wait(0.05);
	param_00.interior_light_bounce = common_scripts\utility::spawn_tag_origin();
	var_06 = param_00.interior_light_bounce;
	param_00.door_open_blue = common_scripts\utility::spawn_tag_origin();
	var_07 = param_00.door_open_blue;
	param_00.lens_left = common_scripts\utility::spawn_tag_origin();
	var_08 = param_00.lens_left;
	param_00.lens_right = common_scripts\utility::spawn_tag_origin();
	var_09 = param_00.lens_right;
	wait(0.05);
	param_00.door_open_bounce = common_scripts\utility::spawn_tag_origin();
	var_0A = param_00.door_open_bounce;
	param_00.door_open_bounce_face = common_scripts\utility::spawn_tag_origin();
	var_0B = param_00.door_open_bounce_face;
	var_01.screen = common_scripts\utility::spawn_tag_origin();
	var_0C = var_01.screen;
	param_00.fill = common_scripts\utility::spawn_tag_origin();
	var_0D = param_00.fill;
	param_00.key2 = common_scripts\utility::spawn_tag_origin();
	var_0E = param_00.key2;
	wait(0.05);
	param_00.redfill2 = common_scripts\utility::spawn_tag_origin();
	var_0F = param_00.redfill2;
	var_06 linkto(param_00,"body_animate_joint",(25,-20,80),(0,0,0),0);
	var_03 linkto(param_00,"body_animate_joint",(-20,-30,53),(30,30,0),0);
	var_04 linkto(param_00,"body_animate_joint",(-20,-30,30),(10,30,0),0);
	var_02 linkto(param_00,"body_animate_joint",(0,0,120),(90,0,0),0);
	var_07 linkto(param_00,"body_animate_joint",(-20,60,20),(0,-20,0),0);
	wait(0.05);
	var_0A linkto(param_00,"body_animate_joint",(30,-5,0),(0,0,0),0);
	var_0B linkto(param_00,"body_animate_joint",(30,12,10),(0,0,0),0);
	var_0D linkto(param_00,"body_animate_joint",(16,-20,30),(0,125,0),0);
	var_0E linkto(param_00,"body_animate_joint",(5,15,20),(0,-90,10),0);
	var_05 linkto(param_00,"body_animate_joint",(-5,-30,25),(30,30,0),0);
	wait(0.05);
	var_0F linkto(param_00,"body_animate_joint",(-25,0,10),(30,30,0),0);
	level notify("pod_lights_on");
	if(level.nextgen)
	{
		thread pod_scripted_lights(param_00);
	}
	else
	{
		playfxontag(common_scripts\utility::getfx("light_yellow_spot2"),var_0E,"tag_origin");
		wait(0.5);
		playfxontag(common_scripts\utility::getfx("light_red_point_intro"),var_05,"tag_origin");
		wait(3);
		level.player lightsetforplayer("seoul_intro_outside");
		killfxontag(common_scripts\utility::getfx("light_yellow_spot2"),var_0E,"tag_origin");
		killfxontag(common_scripts\utility::getfx("light_red_point_intro"),var_05,"tag_origin");
		wait(0.05);
		playfxontag(common_scripts\utility::getfx("light_pod_screen"),var_02,"tag_origin");
		wait(4.25);
		killfxontag(common_scripts\utility::getfx("light_pod_screen"),var_02,"tag_origin");
		wait(0.25);
		level.player lightsetforplayer("seoul_intro");
		playfxontag(common_scripts\utility::getfx("light_yellow_spot"),var_03,"tag_origin");
		playfxontag(common_scripts\utility::getfx("pod_emissive_yellow"),var_0D,"tag_origin");
		wait(3);
		killfxontag(common_scripts\utility::getfx("light_yellow_spot"),var_03,"tag_origin");
		killfxontag(common_scripts\utility::getfx("pod_emissive_yellow"),var_0D,"tag_origin");
		level.player lightsetforplayer("seoul_intro_outside");
		wait(0.05);
		playfxontag(common_scripts\utility::getfx("light_pod_screen"),var_02,"tag_origin");
		level waittill("missle_hit");
		level.player lightsetforplayer("seoul_intro");
		wait(0.05);
		killfxontag(common_scripts\utility::getfx("light_pod_screen"),var_02,"tag_origin");
		wait(0.05);
		wait(1.5);
		playfxontag(common_scripts\utility::getfx("pod_blue_bounce_dim"),var_0A,"tag_origin");
		wait(0.05);
		playfxontag(common_scripts\utility::getfx("pod_light_spot_blue_dimmer"),var_07,"tag_origin");
		playfxontag(common_scripts\utility::getfx("pod_godray"),var_07,"tag_origin");
		common_scripts\utility::flag_wait("door_pop");
		maps\_utility::vision_set_fog_changes("seoul_space_entry_bright",0.5);
		killfxontag(common_scripts\utility::getfx("pod_blue_bounce_dim"),var_0A,"tag_origin");
		killfxontag(common_scripts\utility::getfx("pod_light_spot_blue_dimmer"),var_07,"tag_origin");
		wait(0.05);
		playfxontag(common_scripts\utility::getfx("pod_light_spot_blue"),var_07,"tag_origin");
		wait(0.5);
		killfxontag(common_scripts\utility::getfx("pod_godray"),var_07,"tag_origin");
		playfxontag(common_scripts\utility::getfx("pod_blue_bounce"),var_0B,"tag_origin");
		wait(0.05);
		level.player lightsetforplayer("seoul_intro_bright");
		maps\_utility::vision_set_fog_changes("seoul_space_entry_bright",0.5);
		wait(1);
		maps\_utility::vision_set_fog_changes("seoul_space_entry",2);
		level.player lightsetforplayer("seoul_intro");
		wait(3);
		common_scripts\utility::flag_wait("door_shut");
		wait(0.05);
		killfxontag(common_scripts\utility::getfx("pod_blue_bounce"),var_0B,"tag_origin");
		killfxontag(common_scripts\utility::getfx("pod_light_spot_blue"),var_07,"tag_origin");
		wait(0.05);
		playfxontag(common_scripts\utility::getfx("light_red_spot"),var_03,"tag_origin");
		playfxontag(common_scripts\utility::getfx("red_fill"),var_0A,"tag_origin");
		wait(8);
		killfxontag(common_scripts\utility::getfx("light_red_spot"),var_03,"tag_origin");
		killfxontag(common_scripts\utility::getfx("red_fill"),var_0A,"tag_origin");
		wait(0.05);
		playfxontag(common_scripts\utility::getfx("light_green_spot"),var_03,"tag_origin");
		playfxontag(common_scripts\utility::getfx("green_fill"),var_0A,"tag_origin");
		wait(3);
		killfxontag(common_scripts\utility::getfx("light_green_spot"),var_03,"tag_origin");
		killfxontag(common_scripts\utility::getfx("green_fill"),var_0A,"tag_origin");
		level.player lightsetforplayer("seoul_vista");
		wait(3.75);
		level.player lightsetforplayer("seoul_intro_outside_hit");
		setsaveddvar("r_lightGridDefaultFXLightingLookup",(36129.9,910.88,1819.92));
		setsaveddvar("r_lightGridDefaultModelLightingLookup",(36129.9,910.88,1819.92));
		wait(0.3);
		level.player lightsetforplayer("seoul_vista");
		level waittill("hit_exit");
		setsaveddvar("r_lightGridDefaultFXLightingLookup",(36327.9,1157.88,1847.92));
		setsaveddvar("r_lightGridDefaultModelLightingLookup",(35894,587,1830));
	}

	level waittill("pod_land_apartment");
	thread pod_cormack_custom_mats_landing_on();
	level.player lightsetforplayer("seoul_intro_dark");
	wait(5.5);
	level.player lightsetforplayer("seoul_landing");
	wait(0.25);
	if(level.nextgen)
	{
		maps\_lighting::set_spot_intensity("seoul_intro_ceiling_fire_03",12000);
		wait(0.5);
		maps\_lighting::set_spot_intensity("seoul_intro_ceiling_fire_02",8000);
	}

	maps\_utility::vision_set_fog_changes("seoul_space_landing_fog",0.5);
	level waittill("player_drop_pod_door_kick");
	wait(2.8);
	level notify("end_screen_effect");
	killfxontag(common_scripts\utility::getfx("red_fill"),var_0A,"tag_origin");
	wait(0.05);
	common_scripts\_exploder::exploder(7695);
	setsaveddvar("r_lightgridintensity",1);
	common_scripts\utility::flag_clear("set_seoul_intro_lighting");
	if(level.nextgen)
	{
		maps\_lighting::set_spot_intensity("seoul_intro_ceiling_fire_03",0);
		wait(0.5);
		maps\_lighting::set_spot_intensity("seoul_intro_ceiling_fire_02",0);
	}

	wait(0.5);
	level.player lightsetforplayer("seoul_vista_01");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_medium","seoul_intro_ceiling_fire_01");
	wait(15);
	level.player lightsetforplayer("seoul_vista");
	level.player setclutforplayer("clut_seoul_vista",0);
	common_scripts\_exploder::kill_exploder(7695);
	wait(9);
}

//Function Number: 188
drone_lighting()
{
	level waittill("forever");
	common_scripts\utility::flag_wait("player_in_x4walker");
	var_00 = getent("main_street_reflection","targetname");
	var_01 = getent("main_street_reflection_02","targetname");
	var_02 = getent("drone_reflection_05","targetname");
	foreach(var_04 in level.flock_drones)
	{
		if(isdefined(var_04))
		{
			var_04 overridereflectionprobe(var_00.origin);
		}
	}

	foreach(var_04 in level.flock_drones)
	{
		if(isdefined(var_04))
		{
			var_04 defaultreflectionprobe();
		}
	}
}

//Function Number: 189
setup_hemiao_enable()
{
	if(level.nextgen)
	{
		setsaveddvar("r_hemiAoEnable",1);
	}
}