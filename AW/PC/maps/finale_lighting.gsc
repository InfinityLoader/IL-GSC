/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: finale_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 114
 * Decompile Time: 1605 ms
 * Timestamp: 4/22/2024 2:29:21 AM
*******************************************************************/

//Function Number: 1
main2()
{
	thread set_level_lighting_values();
	thread manage_day_night();
	thread manage_dof();
	thread underwater_sunrays();
	thread init_level_lighting_flags();
	thread hide_on_models();
	thread motion_manage();
	thread trigger_canal_p1();
	thread trigger_canal_p2();
	thread trigger_silo_p1();
	thread trigger_enter_finale_silo_orange_approach();
	thread trigger_flashlight_off();
	thread trigger_enter_finale_silo_orange();
	thread trigger_enter_finale_silo_blue();
	thread cg_trigger_enter_finale_silo_yellow();
	thread cg_trigger_enter_finale_silo_neutral();
	thread trigger_enter_finale_silo_round_tunnel();
	thread trigger_enter_finale_silo_center();
	thread trigger_enter_vision_light_fog_normal();
	thread trigger_enter_finale_low_burn();
	thread trigger_science_room();
	thread trigger_ending();
	thread trigger_ending2();
	precacheshader("ac130_overlay_pip_vignette");
	thread setup_flickerlight_motion_presets();
	thread setup_flickerlight_presets2();
	thread trigger_silo_centroid_switch_floor3();
	thread trigger_silo_centroid_switch_top();
	thread atlas_sign_flicker();
}

//Function Number: 2
init_level_lighting_flags()
{
	common_scripts\utility::flag_init("first_half_lighting");
	common_scripts\utility::flag_init("second_half_lighting");
	common_scripts\utility::flag_init("turn_on_lights");
	common_scripts\utility::flag_init("flyin_mb");
	common_scripts\utility::flag_init("underwater_lighting");
	common_scripts\utility::flag_init("stair_lights_on");
	common_scripts\utility::flag_init("flag_dof_rocket_success_pt2_start");
	common_scripts\utility::flag_init("flag_lighting_rocket_success_pt2_gideon_run");
	common_scripts\utility::flag_init("flag_autofocus_on");
	common_scripts\utility::flag_init("lighting_target_dof");
}

//Function Number: 3
set_level_lighting_values()
{
	if(level.nextgen)
	{
		setsaveddvar("r_hemiAoEnable",1);
	}

	if(isusinghdr())
	{
		setsaveddvar("r_disableLightSets",0);
		setsaveddvar("r_tonemapMinExposureAdjust",-7.4919);
		setsaveddvar("sm_usedSunCascadeCount",2);
		setsaveddvar("sm_sunSampleSizeNear",0.2);
		setsaveddvar("r_fog_ev_adjust",1);
	}
}

//Function Number: 4
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

//Function Number: 5
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

//Function Number: 6
enable_motion_blur()
{
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
	}
}

//Function Number: 7
enable_motion_blur_rotation()
{
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
	}
}

//Function Number: 8
disable_motion_blur()
{
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
	}
}

//Function Number: 9
setup_dof_presets()
{
	maps\_lighting::create_dof_preset("fall",10,18,10,25,150,4,0.5);
}

//Function Number: 10
setup_dof_viewmodel_presets()
{
	maps\_lighting::create_dof_viewmodel_preset("bike_vm_dof",10,90);
}

//Function Number: 11
setup_flickerlight_presets()
{
	maps\_lighting::create_flickerlight_preset("fire2",(0.972549,0.62451,1),(0.2,0.1462746,1),0.2,1,80000);
}

//Function Number: 12
setup_flickerlight_motion_presets()
{
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_red_burn",(1,0.2246,0),32000,20,0.05,0.2);
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_red_burn_exhaust",(1,0.2246,0),800000,20,0.05,0.2);
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_cold_burn",(1,1,1),320000,10,0.03,0.1);
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_large_ending",(1,0.3,0),1400000,7,0.05,0.2);
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_large_atlas",(1,0.3,0),100000,7,0.05,0.2);
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_large_ending2",(1,0.3,0),10000,7,0.05,0.2);
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_large_ending3",(1,0.3,0),5000,7,0.05,0.2);
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_med_ending",(1,0.3,0),30000,7,0.05,0.2);
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_med_ending2",(1,0.3,0),6000,7,0.05,0.2);
	maps\_lighting::create_flickerlight_motion_preset("firelight_motion_med_ending3",(1,0.2,0.05),5000,7,0.05,0.2);
}

//Function Number: 13
setup_flickerlight_presets2()
{
	maps\_lighting::create_flickerlight_preset("firelight_med_ending",(1,0.2246,0),(0.46,0.16,0.06),0.005,0.2,8);
	maps\_lighting::create_flickerlight_preset("firelight_large_ending3",(1,0.2246,0),(0.46,0.16,0.06),0.005,0.2,8);
	maps\_lighting::create_flickerlight_preset("firelight_med_ending2",(1,0.2246,0),(0.46,0.16,0.06),0.005,0.2,8);
}

//Function Number: 14
manage_dof()
{
	if(level.nextgen)
	{
		level.player enablephysicaldepthoffieldscripting();
		level.player_dof_aperture = 4.5;
		level.player_dof_distance = 30;
	}
}

//Function Number: 15
trigger_canal_p1()
{
	common_scripts\utility::run_thread_on_targetname("canal_p1",::canal_p1);
}

//Function Number: 16
canal_p1()
{
	for(;;)
	{
		self waittill("trigger");
		if(level.nextgen)
		{
			maps\_utility::vision_set_fog_changes("finale_underwater",3);
			level.player setclutforplayer("clut_finale_underwater",0);
			level.player lightsetforplayer("underwater_lightset");
		}
		else if(level.currentgen)
		{
			maps\_utility::vision_set_fog_changes("finale_underwater",0.1);
			level.player lightsetforplayer("underwater_lightset");
		}

		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 17
trigger_canal_p2()
{
	common_scripts\utility::run_thread_on_targetname("canal_p2",::canal_p2);
}

//Function Number: 18
canal_p2()
{
	for(;;)
	{
		self waittill("trigger");
		maps\_utility::vision_set_fog_changes("finale_underwater_darkfog",3);
		level.player lightsetforplayer("canal_p2");
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 19
trigger_silo_p1()
{
	common_scripts\utility::run_thread_on_targetname("silo_p1",::silo_p1);
}

//Function Number: 20
silo_p1()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("finale_silo_orange");
		maps\_utility::vision_set_fog_changes("finale_silo_orange",0);
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 21
trigger_flashlight_off()
{
	common_scripts\utility::run_thread_on_targetname("trig_flashlight_off",::play_trigger_flashlight_off);
}

//Function Number: 22
play_trigger_flashlight_off()
{
	for(;;)
	{
		self waittill("trigger");
		common_scripts\utility::flag_clear("underwater_flashlight");
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 23
trigger_enter_finale_silo_orange_approach()
{
	common_scripts\utility::run_thread_on_targetname("trig_fog_silo_orange_approach",::play_finale_silo_orange_approach);
}

//Function Number: 24
play_finale_silo_orange_approach()
{
	for(;;)
	{
		self waittill("trigger");
		level.player setclutforplayer("clut_finale_orange_silo_approach_density",2);
		level.player lightsetforplayer("finale_silo_orange");
		maps\_utility::vision_set_fog_changes("finale_silo_orange",1);
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 25
trigger_enter_finale_silo_orange()
{
	common_scripts\utility::run_thread_on_targetname("trig_fog_silo_orange",::play_finale_silo_orange);
}

//Function Number: 26
play_finale_silo_orange()
{
	for(;;)
	{
		self waittill("trigger");
		level.player setclutforplayer("",2);
		level.player lightsetforplayer("finale_silo_orange");
		maps\_utility::vision_set_fog_changes("finale_silo_orange",1);
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 27
trigger_enter_finale_silo_blue()
{
	common_scripts\utility::run_thread_on_targetname("trig_fog_silo_blue",::play_finale_silo_blue);
}

//Function Number: 28
play_finale_silo_blue()
{
	for(;;)
	{
		self waittill("trigger");
		level.player setclutforplayer("clut_finale_silo_blue",2);
		level.player lightsetforplayer("finale_silo_blue");
		maps\_utility::vision_set_fog_changes("finale_silo_blue",1);
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 29
cg_trigger_enter_finale_silo_yellow()
{
	common_scripts\utility::run_thread_on_targetname("trig_fog_silo_yellow",::play_finale_silo_yellow);
}

//Function Number: 30
play_finale_silo_yellow()
{
	for(;;)
	{
		self waittill("trigger");
		level.player setclutforplayer("",2);
		level.player lightsetforplayer("finale_silo_orange");
		maps\_utility::vision_set_fog_changes("finale_silo_yellow",1);
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 31
cg_trigger_enter_finale_silo_neutral()
{
	common_scripts\utility::run_thread_on_targetname("trig_fog_silo_neutral",::play_finale_silo_neutral);
}

//Function Number: 32
play_finale_silo_neutral()
{
	for(;;)
	{
		self waittill("trigger");
		level.player setclutforplayer("",2);
		level.player lightsetforplayer("finale_silo_orange");
		maps\_utility::vision_set_fog_changes("finale_silo_neutral",1);
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 33
trigger_enter_finale_silo_round_tunnel()
{
	common_scripts\utility::run_thread_on_targetname("trig_fog_silo_round_tunnel",::play_finale_silo_round_tunnel);
}

//Function Number: 34
play_finale_silo_round_tunnel()
{
	for(;;)
	{
		self waittill("trigger");
		level.player setclutforplayer("clut_finale_round_tunnel",2);
		level.player lightsetforplayer("finale_silo_blue");
		maps\_utility::vision_set_fog_changes("finale_silo_blue",1);
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 35
trigger_enter_finale_silo_center()
{
	common_scripts\utility::run_thread_on_targetname("trig_fog_silo_center",::play_finale_silo_center);
}

//Function Number: 36
play_finale_silo_center()
{
	for(;;)
	{
		self waittill("trigger");
		level.player setclutforplayer("",2);
		setsunflareposition((-64.7,29.9,0));
		level.player lightsetforplayer("finale_silo_center");
		maps\_utility::vision_set_fog_changes("finale_silo_center",1);
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 37
trigger_enter_vision_light_fog_normal()
{
	common_scripts\utility::run_thread_on_targetname("trig_fog_normal",::play_vision_light_fog_normal);
}

//Function Number: 38
play_vision_light_fog_normal()
{
	for(;;)
	{
		self waittill("trigger");
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 39
trigger_enter_finale_low_burn()
{
	common_scripts\utility::run_thread_on_targetname("trig_fog_low_burn",::play_finale_low_burn);
}

//Function Number: 40
trigger_science_room()
{
	common_scripts\utility::run_thread_on_targetname("science_room",::science_room);
}

//Function Number: 41
science_room()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("finale_will_litend");
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 42
trigger_ending()
{
	common_scripts\utility::run_thread_on_targetname("ending",::ending);
}

//Function Number: 43
ending()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("finale_night");
		level notify("leave_will_room");
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 44
trigger_ending2()
{
	common_scripts\utility::run_thread_on_targetname("ending2",::ending2);
}

//Function Number: 45
ending2()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("finale_night2");
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 46
trigger_silo_centroid_switch_floor3()
{
	common_scripts\utility::run_thread_on_targetname("trig_silo_centroid_switch_floor3",::play_centroid_switch_floor3);
}

//Function Number: 47
play_centroid_switch_floor3()
{
	for(;;)
	{
		self waittill("trigger");
		thread main_missle_lighting_floor3();
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 48
trigger_silo_centroid_switch_top()
{
	common_scripts\utility::run_thread_on_targetname("trig_silo_centroid_switch_top",::play_centroid_switch_top);
}

//Function Number: 49
play_centroid_switch_top()
{
	for(;;)
	{
		self waittill("trigger");
		thread main_missle_lighting_silotop();
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 50
debug_silo_approach_clut()
{
	wait(0.05);
	level.player setclutforplayer("clut_finale_orange_silo_approach_density",1);
}

//Function Number: 51
debug_silo_floor_03_clut()
{
	wait(0.05);
	level.player setclutforplayer("clut_finale_silo_blue",1);
}

//Function Number: 52
debug_silo_door_kick_clut()
{
	wait(0.05);
	level.player setclutforplayer("",2);
}

//Function Number: 53
debug_silo_exhaust_entrance_clut()
{
	wait(0.05);
	level.player setclutforplayer("clut_finale_round_tunnel",1);
}

//Function Number: 54
hatch_lighting()
{
	enable_motion_blur();
	thread hatch_dof();
	level.player lightsetforplayer("finale_hatch");
	maps\_utility::vision_set_fog_changes("finale_hatch",2);
	common_scripts\_exploder::exploder("4000");
	wait(1.5);
	level.player setclutforplayer("clut_finale_silo_shaft",2);
}

//Function Number: 55
hatch_dof()
{
	thread hatch_land_blur();
	level.player enablephysicaldepthoffieldscripting();
	setsaveddvar("r_dof_physical_bokehEnable",1);
	level.player setphysicaldepthoffield(12,33);
	wait(1);
	level.player setphysicaldepthoffield(1.5,33,1,2);
}

//Function Number: 56
hatch_land_blur()
{
	common_scripts\utility::flag_wait("flag_lighting_fall_blur");
	wait(0.5);
	setblur(40,0.5);
	wait(0.1);
	setblur(0,0.8);
}

//Function Number: 57
play_finale_low_burn()
{
	for(;;)
	{
		self waittill("trigger");
		level.player setphysicaldepthoffield(12,33,1,2);
		setsaveddvar("r_dof_physical_bokehEnable",0);
		setsunflareposition((0,180,0));
		level.player setclutforplayer("clut_finale_burn_pre",4);
		var_00 = getent("light_rocket_exhaust","targetname");
		maps\_lighting::set_spot_intensity("light_rocket_exhaust",4000);
		maps\_lighting::set_spot_color("light_rocket_exhaust",(0.156863,0.313726,0.847059));
		level.player lightsetforplayer("finale_low_burn");
		maps\_utility::vision_set_fog_changes("finale_low_burn",2);
		var_01 = common_scripts\utility::getstruct("struct_light_silo_cine_low_burn_rim","targetname");
		var_02 = getent("light_rocket_rim","targetname");
		maps\_lighting::set_spot_intensity("light_rocket_rim",300000);
		maps\_lighting::set_spot_color("light_rocket_rim",(0.255,0.376,1));
		var_02 maps\_lighting::lerp_light_fov_range(30,5,30,1,0.05);
		var_02 setlightradius(285);
		wait(5);
		lerp_origin_function(var_02,0.05,var_01.origin);
		lerp_angles_function(var_02,0.05,var_01.angles);
		common_scripts\_exploder::kill_exploder("4000");
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 58
red_burn_lighting_fog()
{
	var_00 = getent("light_rocket_exhaust","targetname");
	level.player setclutforplayer("clut_finale_burn_red",2.6);
	level.player lightsetforplayer("finale_red_burn");
	maps\_utility::vision_set_fog_changes("finale_red_burn",2.6);
	var_00 maps\_lighting::lerp_light_fov_range(90,60,30,5,0.05);
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_red_burn_exhaust","light_rocket_exhaust");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_red_burn","light_rocket_thrusters");
}

//Function Number: 59
cold_burn_lighting_fog()
{
	level.player setclutforplayer("",1);
	level.player lightsetforplayer("finale_cold_burn");
	maps\_utility::vision_set_fog_changes("finale_cold_burn",8);
	maps\_lighting::stop_flickerlight("firelight_motion_red_burn","light_rocket_exhaust",0);
	maps\_lighting::stop_flickerlight("firelight_motion_red_burn","light_rocket_thrusters",0);
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_cold_burn","light_rocket_exhaust");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_cold_burn","light_rocket_thrusters");
	thread rocket_fail_lighting();
}

//Function Number: 60
rocket_success_lighting_pre_cine()
{
	common_scripts\utility::flag_wait("lighting_flag_obj_stop_missile_complete");
	level.player lightsetforplayer("finale_silo_end_cine");
	maps\_utility::vision_set_fog_changes("finale_silo_end_cine",10);
	maps\_lighting::pause_flickerlight("firelight_motion_cold_burn","light_rocket_exhaust");
	maps\_lighting::pause_flickerlight("firelight_motion_cold_burn","light_rocket_thrusters");
	maps\_lighting::lerp_spot_intensity("light_rocket_thrusters",2,8000);
	maps\_lighting::lerp_spot_color("light_rocket_thrusters",2,(1,0.608,0.459));
	wait(0.5);
	setsunflareposition((278.8,602,0));
}

//Function Number: 61
rocket_success_dof_debugging(param_00)
{
	iprintlnbold("dof timing debug START");
	wait(1.65);
	iprintlnbold("ground hit");
	wait(3.75);
	iprintlnbold("rocket left direction switch");
	wait(10.2);
	iprintlnbold("Gideon enter (whole head just in frame");
}

//Function Number: 62
rocket_success_pt2_lighting_debugging(param_00)
{
	common_scripts\utility::flag_set("flag_dof_rocket_success_pt2_start");
}

//Function Number: 63
rocket_success_pt2_gideon_in_frame(param_00)
{
	common_scripts\utility::flag_set("flag_lighting_rocket_success_pt2_gideon_run");
}

//Function Number: 64
rocket_cine_dof(param_00)
{
	level.player enablephysicaldepthoffieldscripting();
	setsaveddvar("r_dof_physical_bokehEnable",1);
	enable_motion_blur_rotation();
	level.player setphysicaldepthoffield(12,100);
	wait(2);
	level.player setphysicaldepthoffield(1.5,36,5,2);
	wait(2);
	level.player setphysicaldepthoffield(1.5,500,5,2);
	wait(1);
	level.player setphysicaldepthoffield(0.3,72,5,2);
	wait(1);
	level.player setphysicaldepthoffield(1.5,600,5,2);
	wait(2.5);
	level.player setphysicaldepthoffield(0.5,72,5,2);
	common_scripts\utility::flag_wait("flag_dof_rocket_success_pt2_start");
	level.player setphysicaldepthoffield(2.5,22,5,2);
	wait(3);
	level.player setphysicaldepthoffield(4,85,10,10);
	wait(0.5);
	level.player setphysicaldepthoffield(1.5,43,2,4);
	wait(1);
	level.player setphysicaldepthoffield(1,21,1,2);
	wait(1);
	level.player setphysicaldepthoffield(2.5,22,5,2);
	wait(4.25);
	level.player setphysicaldepthoffield(2,21.5,5,2);
	wait(1.25);
	level.player setphysicaldepthoffield(2.5,23,5,2);
	wait(2);
	level.player setphysicaldepthoffield(2.5,27.2,5,2);
	wait(1.75);
	level.player setphysicaldepthoffield(2.5,23.8,5,2);
	wait(2);
	level.player setphysicaldepthoffield(2.5,27.3,5,2);
	wait(1);
	level.player setphysicaldepthoffield(2.5,13.6,5,2);
	wait(4);
	setsaveddvar("r_dof_physical_bokehEnable",0);
	level.player disablephysicaldepthoffieldscripting();
	disable_motion_blur();
}

//Function Number: 65
play_finale_silo_end_cine()
{
	level.player lightsetforplayer("finale_silo_end_cine");
	maps\_utility::vision_set_fog_changes("finale_silo_end_cine",1);
	var_00 = getent("light_rocket_exhaust","targetname");
	var_01 = getent("light_rocket_thrusters","targetname");
	var_02 = getent("light_rocket_rim","targetname");
	var_00 setlightshadowstate("force_on");
	var_01 setlightshadowstate("force_on");
	var_02 setlightshadowstate("force_on");
	var_03 = common_scripts\utility::getstruct("struct_light_silo_cine_key_1","targetname");
	var_04 = common_scripts\utility::getstruct("struct_light_silo_cine_key_2_alt3","targetname");
	var_05 = common_scripts\utility::getstruct("struct_light_silo_cine_key_2","targetname");
	var_06 = common_scripts\utility::getstruct("struct_light_silo_cine_key_2_alt2","targetname");
	var_07 = common_scripts\utility::getstruct("struct_light_silo_cine_fill_1","targetname");
	var_08 = common_scripts\utility::getstruct("struct_light_silo_cine_fill_2","targetname");
	var_09 = common_scripts\utility::getstruct("struct_light_silo_cine_rim_1","targetname");
	var_0A = common_scripts\utility::getstruct("struct_light_silo_cine_rim_2","targetname");
	var_0B = common_scripts\utility::getstruct("struct_light_silo_cine_rim_2_alt1","targetname");
	var_0C = common_scripts\utility::getstruct("struct_light_silo_cine_rim_2_alt2","targetname");
	level.player lightsetforplayer("finale_silo_end_cine");
	maps\_utility::vision_set_fog_changes("finale_silo_end_cine",1);
	maps\_lighting::stop_flickerlight("firelight_motion_cold_burn","light_rocket_thrusters",0);
	maps\_lighting::stop_flickerlight("firelight_motion_cold_burn","light_rocket_exhaust",0);
	maps\_lighting::set_spot_intensity("light_rocket_exhaust",240000);
	maps\_lighting::set_spot_color("light_rocket_exhaust",(0.352,0.541,1));
	var_00 maps\_lighting::lerp_light_fov_range(30,5,85,15,0.05);
	lerp_origin_function(var_00,0.05,var_04.origin);
	lerp_angles_function(var_00,0.05,var_04.angles);
	maps\_lighting::set_spot_intensity("light_rocket_thrusters",10000);
	maps\_lighting::set_spot_color("light_rocket_thrusters",(0.565,0.643,0.937));
	var_01 maps\_lighting::lerp_light_fov_range(90,60,35,1,0.05);
	lerp_origin_function(var_01,0.05,var_07.origin);
	lerp_angles_function(var_01,0.05,var_07.angles);
	maps\_lighting::set_spot_intensity("light_rocket_rim",20000);
	maps\_lighting::set_spot_color("light_rocket_rim",(0.75,0.5,0.4));
	var_02 maps\_lighting::lerp_light_fov_range(90,60,25,5,0.05);
	lerp_origin_function(var_02,0.05,var_09.origin);
	lerp_angles_function(var_02,0.05,var_09.angles);
	common_scripts\utility::flag_wait("flag_lighting_rocket_success_pt2_gideon_run");
	wait(5);
	maps\_lighting::set_spot_intensity("light_rocket_rim",250000);
	maps\_lighting::set_spot_color("light_rocket_rim",(0.352,0.541,1));
	var_02 maps\_lighting::lerp_light_fov_range(25,5,40,18,0.05);
	lerp_origin_function(var_02,0.05,var_0A.origin);
	lerp_angles_function(var_02,0.05,var_0A.angles);
	maps\_lighting::lerp_spot_intensity("light_rocket_exhaust",0.3,1);
	maps\_lighting::set_spot_color("light_rocket_exhaust",(0.92,0.729,0.698));
	var_00 maps\_lighting::lerp_light_fov_range(85,15,35,1,0.05);
	lerp_origin_function(var_00,0.05,var_06.origin);
	lerp_angles_function(var_00,0.05,var_06.angles);
	maps\_lighting::set_spot_intensity("light_rocket_thrusters",4000);
	maps\_lighting::set_spot_color("light_rocket_thrusters",(0.447,0.572,1));
	var_01 maps\_lighting::lerp_light_fov_range(90,60,35,1,0.05);
	lerp_origin_function(var_01,0.05,var_08.origin);
	lerp_angles_function(var_01,0.05,var_08.angles);
	wait(0.7);
	wait(0.5);
	maps\_lighting::lerp_spot_intensity("light_rocket_rim",0.1,0);
	wait(0.1);
	thread maps\_lighting::set_spot_color("light_rocket_rim",(0.1607,0.3921,1));
	var_02 maps\_lighting::lerp_light_fov_range(25,5,10,1,0.05);
	thread maps\_lighting::lerp_spot_radius("light_rocket_rim",0.05,170);
	lerp_origin_function(var_02,0.05,var_0C.origin);
	lerp_angles_function(var_02,0.05,var_0C.angles);
	thread maps\_lighting::lerp_spot_intensity("light_rocket_rim",0.3,2000000);
	thread maps\_lighting::lerp_spot_intensity("light_rocket_exhaust",0.3,1500);
	wait(2);
	wait(4);
	var_00 setlightshadowstate("normal");
	var_01 setlightshadowstate("normal");
	var_02 setlightshadowstate("normal");
}

//Function Number: 66
rocket_fail_lighting()
{
	common_scripts\utility::flag_wait("lighting_missile_fail");
	maps\_lighting::pause_flickerlight("firelight_motion_cold_burn","light_rocket_exhaust");
	maps\_lighting::pause_flickerlight("firelight_motion_cold_burn","light_rocket_thrusters");
	var_00 = getent("light_rocket_exhaust","targetname");
	var_01 = getent("light_rocket_thrusters","targetname");
	var_02 = common_scripts\utility::getstruct("struct_light_silo_cine_fail_highdown","targetname");
	maps\_lighting::set_spot_intensity("light_rocket_thrusters",320000);
	maps\_lighting::set_spot_color("light_rocket_thrusters",(1,1,1));
	maps\_lighting::set_spot_intensity("light_rocket_thrusters",320000);
	maps\_lighting::set_spot_color("light_rocket_thrusters",(1,1,1));
	maps\_lighting::lerp_spot_intensity("light_rocket_exhaust",4.5,0);
	var_00 maps\_lighting::lerp_light_fov_range(30,5,90,15,0.05);
	thread move_god_rays_rocket_fail();
	maps\_lighting::lerp_spot_intensity("light_rocket_exhaust",1,1300000);
	thread spot_exhaust_fail_orig();
	lerp_angles_function(var_01,0.05,var_02.angles);
	lerp_origin_function(var_01,5,var_02.origin);
}

//Function Number: 67
move_god_rays_rocket_fail()
{
	var_00 = (0,180,0);
	var_01 = (-90,180,0);
	var_02 = 5;
	var_03 = 0;
	while(var_03 < var_02)
	{
		var_04 = var_03 / var_02;
		var_05 = vectorlerp(var_00,var_01,var_04);
		thread maps\_shg_fx::set_sun_flare_position(var_05);
		wait(0.05);
		var_03 = var_03 + 0.05;
	}
}

//Function Number: 68
spot_exhaust_fail_angles()
{
	var_00 = common_scripts\utility::getstruct("struct_light_silo_cine_fail_highdown","targetname");
	var_01 = getent("light_rocket_exhaust","targetname");
	lerp_angles_function(var_01,0.05,var_00.angles);
}

//Function Number: 69
spot_exhaust_fail_orig()
{
	var_00 = common_scripts\utility::getstruct("struct_light_silo_cine_fail_highdown","targetname");
	var_01 = getent("light_rocket_exhaust","targetname");
	lerp_origin_function(var_01,5,var_00.origin);
}

//Function Number: 70
test_sun_flare()
{
	thread maps\_shg_fx::vfx_sunflare("finale_sun_flare");
}

//Function Number: 71
manage_day_night()
{
	wait(0.05);
	if(common_scripts\utility::flag("first_half_lighting") == 1)
	{
		setsaveddvar("r_useLightGridDefaultFXLightingLookup",1);
		setsaveddvar("r_useLightGridDefaultModelLightingLookup",1);
		setsaveddvar("r_lightGridDefaultFXLightingLookup",(-702,-7842,202));
		setsaveddvar("r_lightGridDefaultModelLightingLookup",(-702,-7842,202));
		common_scripts\utility::flag_waitopen("first_half_lighting");
		setsaveddvar("r_useLightGridDefaultFXLightingLookup",1);
		setsaveddvar("r_useLightGridDefaultModelLightingLookup",1);
		setsaveddvar("r_lightGridDefaultFXLightingLookup",(15286.3,-87020.1,7820.69));
		setsaveddvar("r_lightGridDefaultModelLightingLookup",(15286.3,-87020.1,7820.69));
		return;
	}

	setsaveddvar("r_useLightGridDefaultFXLightingLookup",1);
	setsaveddvar("r_useLightGridDefaultModelLightingLookup",1);
	setsaveddvar("r_lightGridDefaultFXLightingLookup",(15286.3,-87020.1,7820.69));
	setsaveddvar("r_lightGridDefaultModelLightingLookup",(15286.3,-87020.1,7820.69));
}

//Function Number: 72
hide_on_models()
{
	wait(0.05);
	var_00 = ["will_room_model_on_03_bright","will_room_model_on_07_bright","will_room_model_on_06_bright","will_room_model_on_09_bright"];
	foreach(var_02 in var_00)
	{
		foreach(var_04 in getentarray(var_02,"targetname"))
		{
			var_04 hide();
		}
	}

	for(var_07 = 1;var_07 <= 9;var_07++)
	{
		var_08[var_07] = getentarray("will_room_model_on_0" + var_07,"targetname");
		foreach(var_0A in var_08[var_07])
		{
			var_0A hide();
		}

		wait(0.05);
	}
}

//Function Number: 73
turn_on_lab_lights_scriptable()
{
	level.player thread maps\_lighting::screen_effect_base(0,"ac130_overlay_pip_vignette",0,0,1,0,0);
	level.lighting_origin = getent("tube_on","targetname");
	setsaveddvar("r_adaptivesubdiv",0);
	var_00 = getentarray("light_strips_on","targetname");
	var_01 = getentarray("light_strips_off","targetname");
	foreach(var_03 in var_00)
	{
		var_03 hide();
	}

	foreach(var_03 in var_01)
	{
		var_03 show();
	}

	common_scripts\utility::flag_wait("turn_on_lights");
	foreach(var_03 in var_00)
	{
		var_03 show();
	}

	foreach(var_03 in var_01)
	{
		var_03 hide();
	}

	maps\_lighting::set_spot_intensity("light_will_room_exit",100000);
	maps\_lighting::set_spot_intensity("door_bright",600000);
	common_scripts\_exploder::exploder("lighton");
	wait(70);
	maps\_utility::vision_set_fog_changes("finale_roof",5);
	setsaveddvar("r_adaptivesubdiv",1);
	level.player lightsetforplayer("finale_will_litend");
}

//Function Number: 74
animated_lights(param_00)
{
	var_01 = maps\_lighting::setup_scriptable_primary_light("will_key_light",0,(141.1,-204,-24.78),(25.9,85,0),3000,(0.4,0.7,1),70,120,level.lighting_origin,"tag_origin",250);
	var_02 = maps\_lighting::setup_scriptable_primary_light("will_rim_light",2,(206.5,-179.112,-36.9),(4.4,170,0),5000,(0.55,0.8,1),30,80,level.lighting_origin,"tag_origin",150);
	var_03 = maps\_lighting::setup_scriptable_primary_light("will_back_light",3,(109.12,-76.21,-2.06),(20,-69,0),10500,(0.26,0.54,1),30,80,level.lighting_origin,"tag_origin",150);
	maps\_lighting::execute_scriptable_primary_light(var_01);
	maps\_lighting::execute_scriptable_primary_light(var_02);
	maps\_lighting::execute_scriptable_primary_light(var_03);
	wait(1.9);
	maps\_lighting::stop_scriptable_primary_light(var_01);
	maps\_lighting::stop_scriptable_primary_light(var_02);
	maps\_lighting::stop_scriptable_primary_light(var_03);
	wait(0.9);
	thread maps\_lighting::lerp_spot_intensity("will_back_light",0.5,420000);
	wait(0.45);
	thread maps\_lighting::lerp_spot_intensity("will_back_light",1,0);
	common_scripts\utility::flag_wait("turn_on_lights");
	thread maps\_lighting::lerp_spot_intensity("will_fill_light",1,45000);
	thread maps\_lighting::lerp_spot_color("will_fill_light",1,(0.68,0.8,1));
	maps\_utility::vision_set_fog_changes("finale_cinematic",0);
	level.player lightsetforplayer("finale_will_lit_bright");
	wait(0.05);
	level.player lightsetforplayer("finale_will_lit");
	var_04 = maps\_lighting::setup_scriptable_primary_light("will_key_light",0,(93.6,-142.9,24.08),(31.6,-8,0),5000,(1,0.9,0.85),70,120,level.lighting_origin,"tag_origin",200);
	var_05 = maps\_lighting::setup_scriptable_primary_light("will_rim_light",2,(136.95,-265.679,54.899),(21.24,82.3,0),60000.5,(1,0.95,0.95),30,80,level.lighting_origin,"tag_origin",250);
	var_06 = maps\_lighting::setup_scriptable_primary_light("will_back_light",3,(220.99,-112.189,-17.25),(13,-162,0),250700,(0.45,0.6,1),30,80,level.lighting_origin,"tag_origin",150);
	maps\_lighting::execute_scriptable_primary_light(var_04);
	maps\_lighting::execute_scriptable_primary_light(var_05);
	maps\_lighting::execute_scriptable_primary_light(var_06);
	wait(1);
	maps\_lighting::stop_scriptable_primary_light(var_04);
	maps\_lighting::stop_scriptable_primary_light(var_05);
	maps\_lighting::stop_scriptable_primary_light(var_06);
	wait(5);
	wait(12.5);
	thread maps\_lighting::lerp_spot_intensity("will_back_light",7,25700);
	wait(13.5);
	thread maps\_lighting::lerp_spot_intensity("will_back_light",6,70700);
	wait(7);
	thread maps\_lighting::lerp_spot_intensity("will_back_light",6,25700);
}

//Function Number: 75
turn_on_lab_lights()
{
	wait(8);
	var_00 = getent("will_key_light","targetname");
	var_00 setlightintensity(100000);
	var_00 setlightcolor((0.4,0.7,1));
	var_01 = getent("will_fill_light","targetname");
	var_01 setlightintensity(5000);
	var_01 setlightcolor((0.4,0.7,1));
	var_02 = getent("will_rim_light","targetname");
	var_02 setlightintensity(100000);
	var_02 setlightcolor((0.55,0.8,1));
	var_02 setlightradius(250);
	for(var_03 = 1;var_03 <= 9;var_03++)
	{
		var_04[var_03] = getentarray("will_room_model_on_0" + var_03,"targetname");
		foreach(var_06 in var_04[var_03])
		{
			var_06 hide();
		}
	}

	for(var_03 = 1;var_03 <= 8;var_03++)
	{
		var_08[var_03] = getentarray("will_room_model_off_0" + var_03,"targetname");
		foreach(var_0A in var_08[var_03])
		{
			var_0A hide();
		}

		var_04[var_03] = getentarray("will_room_model_on_0" + var_03,"targetname");
		foreach(var_0D in var_04[var_03])
		{
			var_0D show();
		}

		var_0F = "811" + var_03;
		common_scripts\_exploder::exploder(var_0F);
		wait(1);
	}

	wait(15);
	thread maps\_lighting::lerp_spot_intensity("will_rim_light",6,700000);
	wait(5);
	thread maps\_lighting::lerp_spot_radius("will_key_light",8,240);
	thread maps\_lighting::lerp_spot_radius("will_fill_light",8,240);
	wait(90);
	common_scripts\utility::flag_wait("stair_lights_on");
	thread maps\_lighting::lerp_spot_intensity("will_key_light",3,500000);
	thread maps\_lighting::lerp_spot_intensity("will_fill_light",3,10000);
	wait(15);
	maps\_utility::vision_set_fog_changes("finale_roof",2);
}

//Function Number: 76
underwater_reflection()
{
	var_00 = getent("reflection_underwater_green","targetname");
}

//Function Number: 77
underwater_sunrays()
{
	for(;;)
	{
		thread maps\_lighting::lerp_spot_intensity_array("sun_ray",3,1000000);
		wait(3);
		thread maps\_lighting::lerp_spot_intensity_array("sun_ray",3,500000);
		wait(3);
		thread maps\_lighting::lerp_spot_intensity_array("sun_ray",1,200000);
		wait(2);
	}
}

//Function Number: 78
motion_manage()
{
	if(level.nextgen)
	{
		wait(0.05);
		if(common_scripts\utility::flag("flyin_mb") == 1)
		{
			setsaveddvar("r_mbEnable","3");
			setsaveddvar("r_mbvelocityscalar",".5");
			common_scripts\utility::flag_waitopen("flyin_mb");
			setsaveddvar("r_mbEnable","0");
			return;
		}

		setsaveddvar("r_mbEnable","0");
	}
}

//Function Number: 79
setup_final_lighting()
{
	var_00 = getent("key","targetname");
	var_01 = getent("rim","targetname");
	var_02 = getent("fill","targetname");
}

//Function Number: 80
enable_physical_dof()
{
}

//Function Number: 81
disable_physical_dof()
{
}

//Function Number: 82
enable_physical_dof_hip()
{
	setsaveddvar("r_dof_physical_hipEnable",1);
	setsaveddvar("r_dof_physical_hipFstop",0.125);
	setsaveddvar("r_dof_physical_hipSharpCocDiameter",0.1);
}

//Function Number: 83
dof_intro()
{
	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(1.5,200);
	common_scripts\utility::flag_wait("flag_intro_flyin_done");
	level.player disablephysicaldepthoffieldscripting();
}

//Function Number: 84
dof_outro()
{
	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(0.5,50);
}

//Function Number: 85
light_ending_cinematic()
{
	var_00 = getent("will_lighting_org","targetname");
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01.origin = var_00.origin;
	level.player thread maps\_lighting::screen_effect_base(0,"ac130_overlay_pip_vignette",0,0,1,0,0);
	thread light_ending_cinematic_dof();
	wait(10);
	wait(0.05);
}

//Function Number: 86
light_ending_cinematic_dof()
{
	level.player enablephysicaldepthoffieldscripting();
	wait(0.5);
	level.player setphysicaldepthoffield(4.5,4);
	wait(0.5);
	level.player setphysicaldepthoffield(5.5,60);
	wait(1);
	level.player setphysicaldepthoffield(2.5,40);
	level.player lightsetforplayer("finale_night_cinematic");
	wait(10.3);
	if(level.nextgen)
	{
		level.player disablephysicaldepthoffieldscripting();
	}

	level waittill("dof_look_down");
	if(level.nextgen)
	{
		level.player enablephysicaldepthoffieldscripting();
	}

	level.player setphysicaldepthoffield(2.5,40);
	common_scripts\utility::flag_wait("arm_off");
	setsaveddvar("r_mbEnable","2");
	setsaveddvar("r_mbvelocityscalar","3");
	level.player setphysicaldepthoffield(4.5,1290);
	level waittill("irons_dead");
	setsaveddvar("r_mbEnable","0");
	wait(3.5);
	level.player setphysicaldepthoffield(8.5,16.5);
	wait(5.5);
	level.player setphysicaldepthoffield(8.5,16.5);
	wait(6);
	level.player setphysicaldepthoffield(4.5,1290);
	wait(4);
	level.player setphysicaldepthoffield(4.5,1290);
	wait(15.25);
	level.player setphysicaldepthoffield(8,16);
	wait(3);
	level.player setphysicaldepthoffield(5,300);
}

//Function Number: 87
will_room_speech_end()
{
	common_scripts\utility::flag_wait("turn_on_lights");
	var_00 = getentarray("will_room_model_on_03","targetname");
	var_01 = ["will_room_model_on_03","will_room_model_on_07","will_room_model_on_06","will_room_model_on_09"];
	foreach(var_03 in var_01)
	{
		foreach(var_05 in getentarray(var_03,"targetname"))
		{
			var_05 hide();
		}
	}

	var_08 = ["will_room_model_on_03_bright","will_room_model_on_07_bright","will_room_model_on_06_bright","will_room_model_on_09_bright"];
	foreach(var_03 in var_08)
	{
		foreach(var_05 in getentarray(var_03,"targetname"))
		{
			var_05 show();
		}
	}

	common_scripts\_exploder::kill_exploder(8113);
	common_scripts\utility::flag_wait("stair_lights_on");
}

//Function Number: 88
lighting_will_reveal()
{
	level.player lightsetforplayer("finale_will");
	maps\_utility::vision_set_fog_changes("finale_cinematic_nofog",2);
	thread turn_on_lab_lights_scriptable();
}

//Function Number: 89
missle_lighting(param_00)
{
	var_01 = getent("org_missile_corridor_origin","targetname");
	var_02 = getent("script_origin_rocket_top","targetname");
	foreach(var_04 in param_00)
	{
		var_04 overridelightingorigin(var_01.origin);
	}
}

//Function Number: 90
main_missle_lighting_silotop()
{
	var_00 = getent("org_missile_corridor_origin","targetname");
	var_01 = getent("script_origin_rocket_top","targetname");
	var_02 = getent("missile_top","targetname");
	var_03 = getent("missile_mid_01","targetname");
	var_04 = getent("missile_mid_02","targetname");
	var_05 = getent("missile_bottom","targetname");
	var_02 overridelightingorigin(var_01.origin);
	var_03 overridelightingorigin(var_01.origin);
	var_04 overridelightingorigin(var_01.origin);
	var_05 overridelightingorigin(var_01.origin);
}

//Function Number: 91
main_missle_lighting_floor3()
{
	var_00 = getent("org_missile_corridor_origin","targetname");
	var_01 = getent("script_origin_rocket_top","targetname");
	var_02 = getent("missile_top","targetname");
	var_03 = getent("missile_mid_01","targetname");
	var_04 = getent("missile_mid_02","targetname");
	var_05 = getent("missile_bottom","targetname");
	var_02 overridelightingorigin(var_00.origin);
	var_03 overridelightingorigin(var_00.origin);
	var_04 overridelightingorigin(var_00.origin);
	var_05 overridelightingorigin(var_00.origin);
}

//Function Number: 92
s_flicker_catwalk_alarm()
{
	thread main_missle_lighting_floor3();
	var_00 = getent("alarm_catwalk_01","targetname");
	var_01 = getent("alarm_catwalk_02","targetname");
	var_02 = getent("alarm_catwalk_03","targetname");
	var_03 = getent("alarm_catwalk_04","targetname");
	var_00 hide();
	var_01 hide();
	var_02 hide();
	var_03 hide();
	maps\_lighting::model_flicker_preset("undefined",0,0,undefined,undefined,"9543spot",0.15,0.151,1,1.001,"lighting_kill_catwalk_s_flicker_red");
	maps\_lighting::model_flicker_preset("undefined",0,0,undefined,undefined,9542,0.15,0.151,1,1.001,"lighting_kill_catwalk_s_flicker_white");
}

//Function Number: 93
setup_eye_highlights_gideon()
{
	if(level.nextgen)
	{
		level.gideon overridematerial("mtl_gideon_eye_shader_l","mc/mtl_gideon_eye_shader_end_l");
		level.gideon overridematerial("mtl_gideon_eye_shader_r","mc/mtl_gideon_eye_shader_end_r");
	}
}

//Function Number: 94
setup_eye_highlights_02()
{
	if(level.nextgen)
	{
		level.irons overridematerial("mtl_irons_eye_shader_l","mc/mtl_irons_eye_shader_finale_fire_l");
		level.irons overridematerial("mtl_irons_eye_shader_r","mc/mtl_irons_eye_shader_finale_fire_r");
	}
}

//Function Number: 95
setup_eye_highlights(param_00)
{
	if(level.nextgen)
	{
		wait(20);
		param_00 overridematerial("mtl_irons_eye_shader_l","mc/mtl_irons_eye_shader_finale_l");
		param_00 overridematerial("mtl_irons_eye_shader_r","mc/mtl_irons_eye_shader_finale_r");
	}
}

//Function Number: 96
mb_surprise()
{
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbvelocityscalar","3");
		wait(5);
		setsaveddvar("r_mbEnable","0");
	}
}

//Function Number: 97
mb_tackle()
{
	if(level.nextgen)
	{
		common_scripts\utility::flag_wait("flag_balcony_tackle_success");
		thread light_ending_cinematic();
		thread fire_ending_light();
		setsaveddvar("r_adaptivesubdiv",0);
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbvelocityscalar","2.5");
		wait(3.2);
		maps\_utility::vision_set_fog_changes("finale_roof_hang",1);
		level.player setclutforplayer("clut_finale_fire",0.5);
		level.player lightsetforplayer("finale_night3");
		thread setup_eye_highlights_02();
		wait(3);
		setsaveddvar("r_mbvelocityscalar",".5");
	}

	if(level.currentgen)
	{
		common_scripts\utility::flag_wait("flag_balcony_tackle_success");
		thread light_ending_cinematic();
		thread fire_ending_light();
		wait(3.2);
		maps\_utility::vision_set_fog_changes("finale_roof_hang",1);
		level.player lightsetforplayer("finale_night3");
		thread setup_eye_highlights_02();
		wait(3);
	}
}

//Function Number: 98
star(param_00)
{
	wait(0.05);
}

//Function Number: 99
dof_irons_meet(param_00)
{
	if(level.nextgen)
	{
		common_scripts\utility::flag_wait("flag_sit_down");
		var_01 = common_scripts\utility::spawn_tag_origin();
		var_01 linkto(param_00,"J_Head",(0,3,0),(0,0,0),0);
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(3.5,60);
		wait(2.5);
		level.player setphysicaldepthoffield(3.5,15);
		wait(2);
		level.player setphysicaldepthoffield(0.5,120);
		common_scripts\utility::flag_wait("turn_on_lights");
		level.player setclutforplayer("clut_finale_chase",0);
		common_scripts\utility::flag_set("lighting_target_dof");
		thread lighting_target_dof_ender(level.player,var_01,3.5);
		thread autofocus_loop();
		wait(12);
		common_scripts\utility::flag_clear("lighting_target_dof");
		wait(0.05);
		common_scripts\utility::flag_set("lighting_target_dof");
		thread lighting_target_dof_ender(level.player,var_01,15);
		wait(9);
		common_scripts\utility::flag_clear("lighting_target_dof");
		wait(0.05);
		common_scripts\utility::flag_set("lighting_target_dof");
		thread lighting_target_dof_ender(level.player,var_01,3.5);
		wait(15);
		common_scripts\utility::flag_clear("lighting_target_dof");
		wait(0.05);
		common_scripts\utility::flag_set("lighting_target_dof");
		thread lighting_target_dof_ender(level.player,var_01,15);
		wait(18);
		common_scripts\utility::flag_clear("lighting_target_dof");
		level.player waittill("exo_released");
		level notify("end_screen_effect");
		common_scripts\_exploder::exploder(2000);
	}
}

//Function Number: 100
gideon_mech_light()
{
	common_scripts\utility::flag_wait("underwater_flashlight");
	wait(6);
	var_00 = level.gideon;
	if(isdefined(var_00.light_tag))
	{
		var_00.light_tag delete();
	}

	var_00.light_tag = common_scripts\utility::spawn_tag_origin();
	var_01 = var_00.light_tag;
	var_01 linkto(var_00,"J_Head",(0,20,0),(180,-105,0),0);
	playfxontag(common_scripts\utility::getfx("fin_light_mech"),var_01,"tag_origin");
	wait(0.1);
	killfxontag(common_scripts\utility::getfx("fin_light_mech"),var_01,"tag_origin");
	wait(0.1);
	playfxontag(common_scripts\utility::getfx("fin_light_mech"),var_01,"tag_origin");
	wait(0.2);
	killfxontag(common_scripts\utility::getfx("fin_light_mech"),var_01,"tag_origin");
	wait(0.1);
	playfxontag(common_scripts\utility::getfx("fin_light_mech"),var_01,"tag_origin");
	wait(0.15);
	killfxontag(common_scripts\utility::getfx("fin_light_mech"),var_01,"tag_origin");
	wait(0.5);
	playfxontag(common_scripts\utility::getfx("fin_light_mech"),var_01,"tag_origin");
	common_scripts\utility::flag_waitopen("underwater_flashlight");
	killfxontag(common_scripts\utility::getfx("fin_light_mech"),var_01,"tag_origin");
}

//Function Number: 101
add_player_flashlight(param_00,param_01,param_02)
{
	var_03 = level.player common_scripts\utility::spawn_tag_origin();
	var_03 linktoplayerview(level.player,"tag_origin",(0,-10,10),(0,0,0),0);
	playfxontag(common_scripts\utility::getfx("player_light_med2"),var_03,"tag_origin");
	level.player.tag_weapon = var_03;
	thread monitor_player_light_off();
}

//Function Number: 102
monitor_player_light_off()
{
	common_scripts\utility::waittill_any("flashlight_off","death");
	if(!isdefined(self))
	{
		return;
	}

	stopfxontag(common_scripts\utility::getfx("player_light_med2"),self.tag_weapon,"tag_origin");
	self.tag_weapon delete();
}

//Function Number: 103
light_strip_checkpoint()
{
	var_00 = getentarray("light_strips_on","targetname");
	var_01 = getentarray("light_strips_off","targetname");
	foreach(var_03 in var_00)
	{
		var_03 show();
	}

	foreach(var_03 in var_01)
	{
		var_03 hide();
	}
}

//Function Number: 104
fire_ending_light()
{
	wait(1.5);
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_med_ending","light_spot_irons_key_02");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large_ending","light_spot_irons_fill_02");
	setsunflareposition((81,62,0));
	level waittill("irons_dead");
	wait(2);
	maps\_utility::vision_set_fog_changes("finale_roof_hang_end",1.5);
	maps\_lighting::stop_flickerlight("firelight_motion_med_ending","light_spot_irons_key_02",0);
	maps\_lighting::stop_flickerlight("firelight_motion_large_ending","light_spot_irons_fill_02",0);
	wait(0.25);
	var_00 = getent("gideon_lighting_org","targetname");
	wait(0.5);
}

//Function Number: 105
atlas_sign_flicker()
{
	var_00 = getent("atlas_off","script_noteworthy");
	var_01 = getent("atlas_halfoff","script_noteworthy");
	var_02 = getent("atlas_on","script_noteworthy");
	var_03 = getent("light_spot_irons_rim","targetname");
	var_04 = common_scripts\utility::getstruct("finale_rim_org_02","targetname");
	var_00 show();
	var_01 hide();
	var_02 hide();
	level waittill("irons_dead");
	wait(3.9);
	var_03 moveto(var_04.origin,0.1,0.05,0.05);
	wait(0.15);
	level.player setclutforplayer("clut_finale_roof",0);
	thread maps\_utility::vision_set_fog_changes("finale_roof_hang_end",1);
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_large_atlas","fire_ending_shot");
	maps\_lighting::play_flickerlight_motion_preset("firelight_motion_med_ending3","light_spot_irons_rim_02");
	maps\_lighting::play_flickerlight_preset("firelight_med_ending2","light_spot_irons_rim",7000);
	wait(0.05);
	thread setup_eye_highlights_gideon();
}

//Function Number: 106
lighting_target_dof(param_00,param_01,param_02,param_03)
{
	var_04 = level.player_dof_aperture;
	level.player_dof_aperture = param_02;
	var_05 = param_03 * 10;
	common_scripts\utility::flag_clear("flag_autofocus_on");
	while(var_05 > 0)
	{
		var_06 = distance2d(param_00.origin,param_01.origin);
		level.player_dof_distance = var_06;
		wait(0.1);
		var_05--;
	}

	common_scripts\utility::flag_set("flag_autofocus_on");
	level.player_dof_aperture = var_04;
}

//Function Number: 107
lighting_target_dof_ender(param_00,param_01,param_02)
{
	var_03 = level.player_dof_aperture;
	level.player_dof_aperture = param_02;
	common_scripts\utility::flag_clear("flag_autofocus_on");
	while(common_scripts\utility::flag("lighting_target_dof") == 1)
	{
		var_04 = distance2d(param_00.origin,param_01.origin);
		level.player_dof_distance = var_04;
		wait(0.1);
	}

	common_scripts\utility::flag_set("flag_autofocus_on");
	level.player_dof_aperture = var_03;
}

//Function Number: 108
autofocus_loop()
{
	level.player enablephysicaldepthoffieldscripting();
	var_00 = level.player_dof_aperture;
	while(common_scripts\utility::flag("flag_autofocus_on") == 0)
	{
		wait 0.05;
		var_01 = level.player_dof_distance;
		var_00 = level.player_dof_aperture;
		if(var_01 < 60)
		{
			var_00 = var_00 + abs(60 - var_01) * 0.1;
		}

		if(level.nextgen)
		{
			level.player setphysicaldepthoffield(var_00,var_01,4,2);
		}
	}

	level.player disablephysicaldepthoffieldscripting();
}

//Function Number: 109
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

//Function Number: 110
player_rig_lighting_org_willroom(param_00)
{
	param_00 defaultlightingorigin();
	wait(0.05);
	var_01 = common_scripts\utility::getstruct("will_room_lighting_origin","targetname");
	param_00 overridelightingorigin(level.gideon.origin);
	level.player waittill("exo_released");
	param_00 defaultlightingorigin();
}

//Function Number: 111
player_rig_lighting_org(param_00)
{
	param_00 defaultlightingorigin();
	wait(0.05);
	var_01 = getent("org_player_carried_lobby_03_lighting","targetname");
	param_00 overridelightingorigin(level.irons.origin);
	level.player waittill("exo_released");
	param_00 defaultlightingorigin();
}

//Function Number: 112
clut_rotate()
{
	wait(15);
	for(;;)
	{
		level.player setclutforplayer("clut_finale_fire",0);
		wait(1);
		level.player setclutforplayer("clut_finale_intro",0);
		wait(1);
		level.player setclutforplayer("clut_finale_chase",0);
		wait(1);
		level.player setclutforplayer("clut_finale_irons",0);
		wait(1);
		level.player setclutforplayer("clut_finale_lobby",0);
		wait(1);
		level.player setclutforplayer("clut_finale_roof",0);
		wait(1);
		level.player setclutforplayer("clut_finale_walkway",0);
		wait(1);
		level.player setclutforplayer("clut_finale_burn_pre",0);
		wait(1);
		level.player setclutforplayer("clut_finale_burn_red",0);
		wait(1);
		level.player setclutforplayer("clut_finale_orange_silo_approach",0);
		wait(1);
		level.player setclutforplayer("clut_finale_round_tunnel",0);
		wait(1);
		level.player setclutforplayer("clut_finale_silo_blue",0);
		wait(1);
		level.player setclutforplayer("clut_finale_silo_center",0);
		wait(1);
		level.player setclutforplayer("clut_finale_silo_shaft",0);
		wait(1);
		level.player setclutforplayer("clut_finale_floor3_density",0);
		wait(1);
		level.player setclutforplayer("clut_finale_orange_silo_approach_density",0);
		wait(1);
		level.player setclutforplayer("clut_finale_round_tunnel",0);
		wait(1);
		level.player setclutforplayer("",0);
	}
}

//Function Number: 113
balcony_lighting(param_00)
{
	common_scripts\utility::flag_wait("flag_balcony_tackle_success");
	wait(3);
	var_01 = getent("gideon_lighting_org","targetname");
	param_00 overridelightingorigin(level.gideon.origin);
}

//Function Number: 114
sky_bridge_dof()
{
	setsaveddvar("r_mbEnable","2");
	setsaveddvar("r_mbvelocityscalar","1");
	setsaveddvar("r_mbCameraRotationInfluence","1");
	level.player enablephysicaldepthoffieldscripting();
	wait(5);
	level.player setphysicaldepthoffield(1.5,30);
	wait(4);
	level.player setphysicaldepthoffield(2.5,3000);
	wait(10);
	level.player setphysicaldepthoffield(1.5,30);
	wait(8);
	level.player disablephysicaldepthoffieldscripting();
	disable_motion_blur();
}