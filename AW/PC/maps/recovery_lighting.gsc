/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: recovery_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 125
 * Decompile Time: 1847 ms
 * Timestamp: 4/22/2024 2:34:45 AM
*******************************************************************/

//Function Number: 1
main()
{
	thread set_level_lighting_values();
	thread setup_flickerlight_presets();
	init_level_lighting_flags();
	thread setup_lighting_funeral_start();
	if(level.nextgen)
	{
		thread lightning_strike_hangar_start();
	}

	thread setup_lighting_training_begin_start();
	thread setup_lighting_training_lodge_begin_start();
	thread setup_lighting_training_lodge_breach_start();
	thread setup_lighting_training_lodge_exit_start();
	thread setup_lighting_training_golf_course_start();
	thread setup_lighting_training_end_start();
	thread setup_lighting_tour_ride_begin_start();
	thread setup_lighting_tour_exo_begin_start();
	thread setup_lighting_tour_exo_exit_start();
	thread setup_lighting_tour_firing_range_start();
	thread setup_lighting_tour_augmented_reality_start();
	thread setup_lighting_tour_end_start();
	thread setup_lighting_training_2_begin_start();
	thread setup_lighting_training_2_lodge_begin_start();
	thread setup_lighting_training_2_lodge_breach_start();
	thread setup_lighting_training_2_lodge_exit_start();
	thread setup_lighting_training_2_golf_course_start();
	thread setup_lighting_training_2_end_start();
	thread setup_lighting_night();
	thread setup_lighting_day();
	thread setup_training_start_area_lighting();
	thread setup_lighting_house_interior_transition();
	thread setup_lighting_house_interior();
	thread setup_lighting_pantry_interior();
	thread setup_lighting_ambush();
	thread setup_lighting_door_breach();
	thread setup_dof_door_breach();
	thread setup_lighting_drone_attack();
	thread setup_lighting_night_pool();
	thread setup_knockdown_sequence();
	thread setup_hangar_door_open_sequence();
	thread setup_hangar_shadow_shell();
	thread setup_hangar_interior_walls();
	thread setup_lighting_hangar_doors();
	thread setup_lighting_training_end_character_sequence();
	thread setup_dof_tour_ride();
	thread setup_repair_hangar_lighting();
	thread setup_tour_hangar_doors_lighting();
	thread setup_tour_hangar_opening();
	if(level.nextgen)
	{
		thread setup_tour_ride_skin_spec_fix();
	}

	thread setup_lighting_exo_hangar_doorway();
	thread setup_lab_entrance_light();
	thread setup_lighting_lab_interior();
	thread setup_lighting_exo_hangar();
	thread setup_lighting_lab_warehouse();
	thread setup_lighting_hangar_demos();
	thread setup_lighting_exo_room();
	thread setup_exo_arm_moment_lighting();
	thread setup_lighting_firing_range_doorway();
	thread setup_lighting_firing_range_entrance();
	thread setup_lighting_firing_range_exit();
	thread setup_lighting_firing_range();
	thread setup_lighting_firing_range_stall();
	thread setup_lighting_firing_range_stall_exposure();
	thread setup_lighting_firing_range_gallery();
	thread setup_lighting_firing_range_lights_moment();
	thread tour_glass_door_04_lighting();
	thread move_tour_door_shadow_caulk();
	thread setup_lighting_training_2_transition();
	thread setup_lighting_ready_room_elevators();
	thread setup_lighting_elevator_ride();
	thread setup_training_2_start_area_lighting();
	thread setup_training_2_breach();
	thread setup_dof_training_2_drone();
	thread setup_training_2_drone();
	thread setup_training_2_suv_dof();
	thread setup_training_2_suv_fires();
	thread setup_training_2_heli_dof();
	thread setup_training_2_heli_lighting();
	if(level.currentgen)
	{
	}
}

//Function Number: 2
init_level_lighting_flags()
{
	common_scripts\utility::flag_init("funeral");
	common_scripts\utility::flag_init("training_begin");
	common_scripts\utility::flag_init("training_start_area_lighting");
	common_scripts\utility::flag_init("enter_house_lighting");
	common_scripts\utility::flag_init("training_lodge_begin_lighting");
	common_scripts\utility::flag_init("training_lodge_breach_lighting");
	common_scripts\utility::flag_init("training_lodge_exit_lighting");
	common_scripts\utility::flag_init("training_golf_course_lighting");
	common_scripts\utility::flag_init("training_end_lighting");
	common_scripts\utility::flag_init("knockdown_lighting");
	common_scripts\utility::flag_init("tour_ride_begin_lighting");
	common_scripts\utility::flag_init("tour_ride_drive_lighting");
	common_scripts\utility::flag_init("tour_ride_hangar_lighting");
	common_scripts\utility::flag_init("tour_ride_end_lighting");
	common_scripts\utility::flag_init("tour_exo_begin_lighting");
	common_scripts\utility::flag_init("tour_exo_exit_lighting");
	common_scripts\utility::flag_init("tour_firing_range_lighting");
	common_scripts\utility::flag_init("shooting_range_lighting_ramp_down");
	common_scripts\utility::flag_init("tour_augmented_reality_lighting");
	common_scripts\utility::flag_init("threat_grenade_start_lighting");
	common_scripts\utility::flag_init("threat_grenade_end_lighting");
	common_scripts\utility::flag_init("emp_drone_start_lighting");
	common_scripts\utility::flag_init("emp_drone_end_lighting");
	common_scripts\utility::flag_init("fly_drone_start_lighting");
	common_scripts\utility::flag_init("fly_drone_end_lighting");
	common_scripts\utility::flag_init("tour_end_lighting");
	common_scripts\utility::flag_init("ready_room_elevator_lighting");
	common_scripts\utility::flag_init("training_2_begin_lighting");
	common_scripts\utility::flag_init("training_2_lodge_begin_lighting");
	common_scripts\utility::flag_init("training_2_lodge_breach_lighting");
	common_scripts\utility::flag_init("training_2_lodge_exit_lighting");
	common_scripts\utility::flag_init("training_2_golf_course_lighting");
	common_scripts\utility::flag_init("training_2_suv_lighting");
	common_scripts\utility::flag_init("training_2_end_lighting");
	common_scripts\utility::flag_init("training_2_car_fires_lighting");
	common_scripts\utility::flag_init("training_2_start_area_lighting");
	common_scripts\utility::flag_init("tour_ride_reset_irons_reflection");
}

//Function Number: 3
set_level_lighting_values()
{
	if(isusinghdr())
	{
		setsaveddvar("r_disablelightsets",0);
		if(maps\_utility::is_gen4())
		{
			level.player lightsetforplayer("recovery");
		}

		if(level.nextgen)
		{
			setsaveddvar("r_hemiAoEnable",1);
		}
	}
}

//Function Number: 4
setup_flickerlight_presets()
{
	maps\_lighting::create_flickerlight_preset("recovery_fire",(1,0.2246,0),(0.46,0.16,0.06),0.005,0.2,8);
	maps\_lighting::create_flickerlight_preset("firing_range_holo",(0.1,0.7,1),(0.1,0.4,0.6),0.005,0.2,8);
	maps\_lighting::create_flickerlight_preset("broken_tv",(0.1,0.7,1),(0.1,0.4,0.6),0.005,0.2,8);
}

//Function Number: 5
sun_flare()
{
	thread maps\_shg_fx::vfx_sunflare("recovery_sun_flare");
}

//Function Number: 6
sun_flare_funeral()
{
	thread maps\_shg_fx::vfx_sunflare("recovery_sun_flare_funeral");
}

//Function Number: 7
setup_lighting_funeral_start()
{
	common_scripts\utility::flag_wait("funeral");
	wait(0.1);
	level.player lightsetforplayer("recovery_funeral");
	level.player setclutforplayer("clut_recovery_funeral",0.1);
	maps\_utility::vision_set_fog_changes("recovery_funeral",0.1);
	thread maps\_utility::sun_light_fade((5,5,5),(10,10,10),0.15);
	thread sun_flare_funeral();
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
	}

	maps\_shg_fx::set_sun_flare_position((-18,50,0));
	thread setup_lighting_funeral_sequence();
	if(level.nextgen)
	{
		thread setup_dof_funeral();
		return;
	}

	if(level.currentgen)
	{
		thread setup_dof_funeral_cg();
	}
}

//Function Number: 8
setup_lighting_training_begin_start()
{
	common_scripts\utility::flag_wait("training_begin");
	wait(0.1);
	level.player lightsetforplayer("recovery_night");
	level.player setclutforplayer("clut_recovery_night",0.1);
	maps\_utility::vision_set_fog_changes("recovery_night",0.1);
	setsaveddvar("r_gunSightColorEntityScale",0.75);
	setsaveddvar("r_gunSightColorNoneScale",0.75);
	thread setup_outerspacelighting_interior();
	thread sun_flare();
	maps\_shg_fx::set_sun_flare_position((31,-35,0));
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("light_side_house_01",0.1,600);
		thread maps\_lighting::lerp_spot_intensity("light_side_house_02",0.1,15000);
	}
}

//Function Number: 9
setup_lighting_training_lodge_begin_start()
{
	common_scripts\utility::flag_wait("training_lodge_begin_lighting");
	wait(0.1);
	level.player lightsetforplayer("recovery_pantry_interior");
	level.player setclutforplayer("clut_recovery_house",0.1);
	maps\_utility::vision_set_fog_changes("recovery_house_interior",0.1);
	setsaveddvar("r_gunSightColorEntityScale",0.75);
	setsaveddvar("r_gunSightColorNoneScale",0.75);
	thread setup_outerspacelighting_interior();
	thread sun_flare();
	maps\_shg_fx::set_sun_flare_position((31,-35,0));
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("kitchen_window_light",0.5,0);
	}

	var_00 = getentarray("hangar_exterior","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}
}

//Function Number: 10
setup_lighting_training_lodge_breach_start()
{
	common_scripts\utility::flag_wait("training_lodge_breach_lighting");
	wait(0.1);
	level.player lightsetforplayer("recovery_house_interior");
	level.player setclutforplayer("clut_recovery_house",0.1);
	maps\_utility::vision_set_fog_changes("recovery_house_interior",0.1);
	setsaveddvar("r_gunSightColorEntityScale",0.75);
	setsaveddvar("r_gunSightColorNoneScale",0.75);
	thread setup_outerspacelighting_interior();
	thread sun_flare();
	maps\_shg_fx::set_sun_flare_position((31,-35,0));
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("kitchen_window_light",0.5,0);
	}

	var_00 = getentarray("hangar_exterior","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}
}

//Function Number: 11
setup_lighting_training_lodge_exit_start()
{
	common_scripts\utility::flag_wait("training_lodge_exit_lighting");
	wait(0.1);
	level.player lightsetforplayer("recovery_house_interior");
	level.player setclutforplayer("clut_recovery_house",0.1);
	maps\_utility::vision_set_fog_changes("recovery_house_interior",0.1);
	setsaveddvar("r_gunSightColorEntityScale",0.75);
	setsaveddvar("r_gunSightColorNoneScale",0.75);
	thread setup_outerspacelighting_interior();
	thread sun_flare();
	maps\_shg_fx::set_sun_flare_position((31,-35,0));
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("kitchen_window_light",0.5,0);
	}

	var_00 = getentarray("hangar_exterior","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}
}

//Function Number: 12
setup_lighting_training_golf_course_start()
{
	common_scripts\utility::flag_wait("training_golf_course_lighting");
	wait(0.1);
	level.player lightsetforplayer("recovery_night");
	level.player setclutforplayer("clut_recovery_night_pool_to_end",0.1);
	maps\_utility::vision_set_fog_changes("recovery_night_pool_to_end",0.1);
	setsaveddvar("r_gunSightColorEntityScale",0.75);
	setsaveddvar("r_gunSightColorNoneScale",0.75);
	thread setup_outerspacelighting_interior();
	thread sun_flare();
	maps\_shg_fx::set_sun_flare_position((31,-35,0));
	var_00 = getentarray("hangar_exterior","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}
}

//Function Number: 13
setup_lighting_training_end_start()
{
	common_scripts\utility::flag_wait("training_end_lighting");
	wait(0.1);
	level.player lightsetforplayer("recovery_night");
	level.player setclutforplayer("clut_recovery_night_pool_to_end",0.1);
	maps\_utility::vision_set_fog_changes("recovery_night_pool_to_end",0.1);
	setsaveddvar("r_gunSightColorEntityScale",0.75);
	setsaveddvar("r_gunSightColorNoneScale",0.75);
	thread setup_outerspacelighting_interior();
	thread sun_flare();
	maps\_shg_fx::set_sun_flare_position((31,-35,0));
	var_00 = getentarray("hangar_exterior","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}
}

//Function Number: 14
setup_lighting_tour_ride_begin_start()
{
	common_scripts\utility::flag_wait("tour_ride_begin_lighting");
	wait(0.1);
	level.player lightsetforplayer("recovery_night");
	level.player setclutforplayer("clut_recovery_hangar_transition",0.1);
	maps\_utility::vision_set_fog_changes("recovery_night",0.1);
	setsaveddvar("r_gunSightColorEntityScale",0.75);
	setsaveddvar("r_gunSightColorNoneScale",0.75);
	thread sun_flare();
	maps\_shg_fx::set_sun_flare_position((-40,72,0));
	var_00 = getentarray("hangar_exterior","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}
}

//Function Number: 15
setup_lighting_tour_exo_begin_start()
{
	common_scripts\utility::flag_wait("tour_exo_begin_lighting");
	wait(0.1);
	level.player lightsetforplayer("recovery_day");
	level.player setclutforplayer("clut_recovery_day_exo_area",0.1);
	maps\_utility::vision_set_fog_changes("recovery_day",0.1);
	thread glass_door_01_exterior_lighting();
	thread glass_door_02_exterior_lighting();
	thread glass_door_03_exterior_lighting();
	thread glass_door_04_exterior_lighting();
	thread sun_flare();
	maps\_shg_fx::set_sun_flare_position((-40,72,0));
}

//Function Number: 16
setup_lighting_tour_exo_exit_start()
{
	common_scripts\utility::flag_wait("tour_exo_exit_lighting");
	wait(0.1);
	level.player lightsetforplayer("recovery_lab_warehouse");
	level.player setclutforplayer("clut_recovery_lab",0.1);
	maps\_utility::vision_set_fog_changes("recovery_lab_warehouse",0.1);
	thread glass_door_01_interior_lighting();
	thread glass_door_02_interior_lighting();
	thread sun_flare();
	maps\_shg_fx::set_sun_flare_position((-40,72,0));
}

//Function Number: 17
setup_lighting_tour_firing_range_start()
{
	common_scripts\utility::flag_wait("tour_firing_range_lighting");
	wait(0.1);
	level.player lightsetforplayer("recovery_day");
	level.player setclutforplayer("clut_recovery_day_exo_area",0.1);
	maps\_utility::vision_set_fog_changes("recovery_day",0.1);
	thread glass_door_01_exterior_lighting();
	thread glass_door_02_exterior_lighting();
	thread glass_door_03_exterior_lighting();
	thread glass_door_04_exterior_lighting();
	thread sun_flare();
	maps\_shg_fx::set_sun_flare_position((-40,72,0));
}

//Function Number: 18
setup_lighting_tour_augmented_reality_start()
{
	common_scripts\utility::flag_wait("tour_augmented_reality_lighting");
	wait(0.1);
	level.player lightsetforplayer("recovery_day");
	level.player setclutforplayer("clut_recovery_day_exo_area",0.1);
	maps\_utility::vision_set_fog_changes("recovery_day",0.1);
	thread glass_door_01_exterior_lighting();
	thread glass_door_02_exterior_lighting();
	thread glass_door_03_exterior_lighting();
	thread glass_door_04_exterior_lighting();
	thread sun_flare();
	maps\_shg_fx::set_sun_flare_position((-40,72,0));
}

//Function Number: 19
setup_lighting_tour_end_start()
{
	common_scripts\utility::flag_wait("tour_end_lighting");
	wait(0.1);
	level.player lightsetforplayer("recovery_day");
	level.player setclutforplayer("clut_recovery_day_exo_area",0.1);
	maps\_utility::vision_set_fog_changes("recovery_day",0.1);
	thread glass_door_01_exterior_lighting();
	thread glass_door_02_exterior_lighting();
	thread glass_door_03_exterior_lighting();
	thread glass_door_04_exterior_lighting();
	thread sun_flare();
	maps\_shg_fx::set_sun_flare_position((-40,72,0));
}

//Function Number: 20
setup_lighting_training_2_begin_start()
{
	common_scripts\utility::flag_wait("training_2_begin_lighting");
	wait(0.1);
	level.player lightsetforplayer("recovery_night");
	level.player setclutforplayer("clut_recovery_night",0.1);
	maps\_utility::vision_set_fog_changes("recovery_night",0.1);
	setsaveddvar("r_gunSightColorEntityScale",0.75);
	setsaveddvar("r_gunSightColorNoneScale",0.75);
	thread setup_outerspacelighting_interior();
	thread sun_flare();
	maps\_shg_fx::set_sun_flare_position((40,72,0));
	var_00 = getentarray("hangar_exterior","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}

	wait(0.25);
}

//Function Number: 21
setup_lighting_training_2_lodge_begin_start()
{
	common_scripts\utility::flag_wait("training_2_lodge_begin_lighting");
	wait(0.1);
	level.player lightsetforplayer("recovery_pantry_interior");
	level.player setclutforplayer("clut_recovery_house",0.1);
	maps\_utility::vision_set_fog_changes("recovery_house_interior",0.1);
	setsaveddvar("r_gunSightColorEntityScale",0.75);
	setsaveddvar("r_gunSightColorNoneScale",0.75);
	thread setup_outerspacelighting_interior();
	thread sun_flare();
	maps\_shg_fx::set_sun_flare_position((31,-35,0));
	var_00 = getentarray("hangar_exterior","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}

	wait(0.25);
}

//Function Number: 22
setup_lighting_training_2_lodge_breach_start()
{
	common_scripts\utility::flag_wait("training_2_lodge_breach_lighting");
	wait(0.1);
	level.player lightsetforplayer("recovery_house_interior");
	level.player setclutforplayer("clut_recovery_house",0.1);
	maps\_utility::vision_set_fog_changes("recovery_house_interior",0.1);
	setsaveddvar("r_gunSightColorEntityScale",0.75);
	setsaveddvar("r_gunSightColorNoneScale",0.75);
	if(level.nextgen)
	{
		thread setup_outerspacelighting_interior();
	}

	thread sun_flare();
	maps\_shg_fx::set_sun_flare_position((31,-35,0));
	var_00 = getentarray("hangar_exterior","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}

	wait(0.25);
}

//Function Number: 23
setup_lighting_training_2_lodge_exit_start()
{
	common_scripts\utility::flag_wait("training_2_lodge_exit_lighting");
	wait(0.1);
	level.player lightsetforplayer("recovery_house_interior");
	level.player setclutforplayer("clut_recovery_house",0.1);
	maps\_utility::vision_set_fog_changes("recovery_house_interior",0.1);
	setsaveddvar("r_gunSightColorEntityScale",0.75);
	setsaveddvar("r_gunSightColorNoneScale",0.75);
	thread setup_outerspacelighting_interior();
	thread sun_flare();
	maps\_shg_fx::set_sun_flare_position((31,-35,0));
	var_00 = getentarray("hangar_exterior","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}

	wait(0.25);
}

//Function Number: 24
setup_lighting_training_2_golf_course_start()
{
	common_scripts\utility::flag_wait("training_2_golf_course_lighting");
	wait(0.1);
	level.player lightsetforplayer("recovery_night");
	level.player setclutforplayer("clut_recovery_night_pool_to_end",0.1);
	maps\_utility::vision_set_fog_changes("recovery_night_pool_to_end",0.1);
	setsaveddvar("r_gunSightColorEntityScale",0.75);
	setsaveddvar("r_gunSightColorNoneScale",0.75);
	thread setup_outerspacelighting_interior();
	thread sun_flare();
	maps\_shg_fx::set_sun_flare_position((31,-35,0));
	var_00 = getentarray("hangar_exterior","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}

	wait(0.25);
}

//Function Number: 25
setup_lighting_training_2_end_start()
{
	common_scripts\utility::flag_wait("training_2_end_lighting");
	wait(0.1);
	level.player lightsetforplayer("recovery_night");
	level.player setclutforplayer("clut_recovery_night_pool_to_end",0.1);
	maps\_utility::vision_set_fog_changes("recovery_night_pool_to_end",0.1);
	setsaveddvar("r_gunSightColorEntityScale",0.75);
	setsaveddvar("r_gunSightColorNoneScale",0.75);
	thread setup_outerspacelighting_interior();
	thread sun_flare();
	maps\_shg_fx::set_sun_flare_position((31,-35,0));
	var_00 = getentarray("hangar_exterior","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}

	wait(0.25);
}

//Function Number: 26
setup_lighting_night()
{
	wait(0.5);
	var_00 = getentarray("recovery_night_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_night_lighting_volume();
	}
}

//Function Number: 27
setup_night_lighting_volume()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("recovery_night");
		level.player setclutforplayer("clut_recovery_night",0.1);
		if(level.nextgen)
		{
			maps\_utility::vision_set_fog_changes("recovery_night",10);
		}
		else if(level.currentgen)
		{
			maps\_utility::vision_set_fog_changes("recovery_night",2);
		}

		if(level.nextgen)
		{
			thread maps\_lighting::lerp_spot_intensity("kitchen_window_light",1,40000);
		}
	}
}

//Function Number: 28
setup_lighting_day()
{
	var_00 = getentarray("recovery_day_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_day_lighting_volume();
	}
}

//Function Number: 29
setup_day_lighting_volume()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("recovery_day");
		level.player setclutforplayer("clut_recovery_day",2);
		setsaveddvar("r_gunSightColorEntityScale",1);
		setsaveddvar("r_gunSightColorNoneScale",1);
		if(level.nextgen)
		{
			maps\_utility::vision_set_fog_changes("recovery_day",4);
		}

		if(level.currentgen)
		{
			maps\_utility::vision_set_fog_changes("recovery_day",2);
		}

		var_00 = getentarray("hangar_exterior","targetname");
		foreach(var_02 in var_00)
		{
			var_02 show();
		}
	}
}

//Function Number: 30
setup_lighting_funeral_sequence()
{
	wait(0.2);
	var_00 = undefined;
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_mbCameraRotationInfluence","0");
		var_00 = getent("funeral_rim_conversation_light","targetname");
		var_01 = getent("funeral_rim_light","targetname");
		var_01 setlightfovrange(30,5);
		var_01 setlightradius(500);
		var_00 setlightfovrange(30,20);
	}

	if(level.nextgen)
	{
		if(level.xb3)
		{
			setsaveddvar("sm_sunShadowBoundsMin","0 -50000 -128");
			setsaveddvar("sm_sunShadowBoundsMax","10000 -35000 512");
			setsaveddvar("sm_sunShadowBoundsOverride","1");
		}
	}

	var_02 = getent("funeral_conversation_fill","targetname");
	var_02 setlightfovrange(40,20);
	thread maps\_lighting::lerp_spot_color("funeral_rim_light",0.15,(0.9,0.8,0.7));
	thread maps\_lighting::lerp_spot_color("funeral_crowd_rim_light",0.15,(0.9,0.8,0.7));
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_color("funeral_rim_conversation_light",0.15,(0.7,0.8,0.9));
	}

	thread maps\_lighting::lerp_spot_color("funeral_conversation_fill",0.15,(0.9,0.8,0.7));
	thread maps\_lighting::lerp_spot_intensity("funeral_rim_light",2,5000000);
	thread maps\_lighting::lerp_spot_intensity("funeral_crowd_rim_light",2,5000000);
	wait(33);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
	}

	common_scripts\utility::flag_wait("interact_casket");
	wait(8.5);
	level.player lightsetforplayer("recovery_funeral_walk");
	common_scripts\utility::flag_wait("player_proximity_irons");
	var_03 = getent("funeral_road_lighting_centroid","targetname");
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("funeral_rim_conversation_light",4,3000000);
	}

	thread maps\_lighting::lerp_spot_intensity("funeral_conversation_fill",4,200000);
	wait(7);
	if(level.nextgen && isdefined(var_00))
	{
		var_00 maps\_lighting::lerp_light_fov_range(30,20,80,40,5);
	}

	wait(3.5);
	level.player lightsetforplayer("recovery_funeral_conversation");
	level.funeral_irons overridelightingorigin(var_03.origin);
	wait(46.5);
	level.funeral_irons defaultlightingorigin();
	if(level.xb3)
	{
		setsaveddvar("sm_sunShadowBoundsOverride","0");
	}
}

//Function Number: 31
setup_dof_funeral()
{
	setsaveddvar("r_dof_physical_bokehenable",1);
	if(level.nextgen)
	{
		common_scripts\utility::flag_wait("interact_casket");
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(4.5,24.3);
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
		wait(8.5);
		level.player disablephysicaldepthoffieldscripting();
		common_scripts\utility::flag_wait("player_proximity_irons");
		level.player enablephysicaldepthoffieldscripting();
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
		level.player setphysicaldepthoffield(5,23.8);
		wait(10);
		level.player setphysicaldepthoffield(5.5,30);
		wait(28.5);
		level.player setphysicaldepthoffield(5.5,21.8);
		wait(8);
		level.player setphysicaldepthoffield(5.5,30);
		wait(5);
		level.player setphysicaldepthoffield(5.5,24.7);
		wait(1);
		level.player setphysicaldepthoffield(5.5,10.69);
		wait(3);
		level.player setphysicaldepthoffield(5.5,30);
		wait(3.75);
		level.player setphysicaldepthoffield(5.5,9.2,20,20);
	}
}

//Function Number: 32
setup_dof_funeral_cg()
{
	if(level.currentgen)
	{
		level.player enablephysicaldepthoffieldscripting();
		common_scripts\utility::flag_wait("interact_casket");
		setsaveddvar("r_dof_physical_hipenable",0);
		level.player setphysicaldepthoffield(7.5,17.3);
		wait(9.75);
		setsaveddvar("sm_sunshadowscale",1);
		setsaveddvar("sm_sunSampleSizeNear",0.15);
		level.player disablephysicaldepthoffieldscripting();
		common_scripts\utility::flag_wait("player_proximity_irons");
		setsaveddvar("sm_sunshadowscale",1);
		setsaveddvar("sm_sunSampleSizeNear",0.044);
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(8.5,23.8);
		level.player lightsetforplayer("recovery_funeral_ssn");
		wait(10);
		level.player setphysicaldepthoffield(9,21.4);
		wait(28.5);
		level.player setphysicaldepthoffield(9,18.1);
		wait(8);
		level.player setphysicaldepthoffield(9,21.4);
		wait(5);
		level.player setphysicaldepthoffield(12,10.69);
		wait(4);
		level.player setphysicaldepthoffield(9,21.4);
		wait(4);
		level.player setphysicaldepthoffield(12,10.69);
		wait(4);
		level.player disablephysicaldepthoffieldscripting();
	}
}

//Function Number: 33
lightning_strike_hangar_start()
{
	common_scripts\utility::flag_wait("training_start_area_lighting");
	resetsunlight();
	wait(0.25);
	var_00 = getent("hangar_lightning_light","targetname");
	var_01 = randomfloatrange(0.15,0.35);
	var_02 = 7;
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_00 setlightintensity(randomfloatrange(1000,10000000));
		level.player lightsetforplayer("recovery_lightning");
		wait(var_01);
		var_00 setlightintensity(0);
		level.player lightsetforplayer("recovery_night");
	}
}

//Function Number: 34
setup_training_start_area_lighting()
{
	common_scripts\utility::flag_wait("training_start_area_lighting");
	level.player lightsetforplayer("recovery_night");
	level.player setclutforplayer("clut_recovery_night",0.1);
	maps\_utility::vision_set_fog_changes("recovery_night",0.1);
	setsaveddvar("r_gunSightColorEntityScale",0.75);
	setsaveddvar("r_gunSightColorNoneScale",0.75);
	thread sun_flare();
	maps\_shg_fx::set_sun_flare_position((31,-35,0));
	if(level.nextgen)
	{
		thread setup_training_start_area_dof();
		setsaveddvar("r_aodiminish",1);
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
		thread maps\_lighting::lerp_spot_intensity("light_side_house_01",0.1,600);
		thread maps\_lighting::lerp_spot_intensity("light_side_house_02",0.1,15000);
		thread maps\_lighting::lerp_spot_intensity("training_start_character_fill",2,1000);
		wait(5);
		thread maps\_lighting::lerp_spot_intensity("training_start_character_fill",2,500);
	}
	else
	{
		thread setup_training_start_area_dof();
	}

	var_00 = getentarray("hangar_exterior","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}

	wait(10);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_mbCameraRotationInfluence","0");
		common_scripts\utility::flag_wait("enter_house_lighting");
	}
}

//Function Number: 35
setup_training_start_area_dof()
{
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehenable",1);
	}

	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(25.5,11.7,20,20);
	wait(2.3);
	level.player setphysicaldepthoffield(1.8,13.7,20,20);
	wait(2.5);
	level.player setphysicaldepthoffield(2.5,25.8);
	wait(5.65);
	level.player setphysicaldepthoffield(2.5,2486);
	wait(4);
	level.player disablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehenable",0);
	}

	wait(0.25);
}

//Function Number: 36
setup_lighting_house_interior_transition()
{
	var_00 = getentarray("house_interior_transition_lighting_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_house_interior_transition_volume();
	}
}

//Function Number: 37
setup_lighting_house_interior_transition_volume()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("recovery_house_interior_transition");
		level.player setclutforplayer("clut_recovery_house",0.1);
		if(level.nextgen)
		{
			maps\_utility::vision_set_fog_changes("recovery_house_interior",4);
			thread maps\_lighting::lerp_spot_intensity("kitchen_window_light",0.5,0);
		}

		if(level.currentgen)
		{
			maps\_utility::vision_set_fog_changes("recovery_house_interior_transition",2);
		}
	}
}

//Function Number: 38
setup_lighting_house_interior()
{
	var_00 = getentarray("house_interior_lighting_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_house_interior_volume();
	}
}

//Function Number: 39
setup_lighting_house_interior_volume()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("recovery_house_interior");
		level.player setclutforplayer("clut_recovery_house",0.1);
		if(level.nextgen)
		{
			maps\_utility::vision_set_fog_changes("recovery_house_interior",10);
		}
		else if(level.currentgen)
		{
			maps\_utility::vision_set_fog_changes("recovery_house_interior",2);
		}

		if(level.nextgen)
		{
			thread maps\_lighting::lerp_spot_intensity("kitchen_window_light",0.5,0);
			thread maps\_lighting::lerp_spot_intensity("light_side_house_01",1,30000);
			thread maps\_lighting::lerp_spot_intensity("light_side_house_02",1,30000);
		}

		common_scripts\utility::flag_set("enter_house_lighting");
	}
}

//Function Number: 40
setup_lighting_pantry_interior()
{
	var_00 = getentarray("house_interior_pantry_lighting_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_pantry_interior_volume();
	}
}

//Function Number: 41
setup_lighting_pantry_interior_volume()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("recovery_pantry_interior");
	}
}

//Function Number: 42
setup_lighting_ambush()
{
	common_scripts\utility::flag_wait("bedroom_1_door_scene");
	var_00 = getent("house_ambush_light","targetname");
	var_00 setlightshadowstate("force_on");
	thread maps\_lighting::lerp_spot_intensity("house_ambush_light",0.1,20000);
	wait(6);
	var_00 setlightshadowstate("normal");
}

//Function Number: 43
setup_lighting_door_breach()
{
	common_scripts\utility::flag_wait("training_s1_breach_begin");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
		wait(4);
		thread maps\_lighting::lerp_spot_intensity("lodge_breach_bounce",2,10000);
		maps\_utility::vision_set_fog_changes("recovery_house_door_breach",0.5);
		wait(7);
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_mbCameraRotationInfluence","0");
		thread maps\_lighting::lerp_spot_intensity("lodge_breach_bounce",3,100);
		maps\_utility::vision_set_fog_changes("recovery_house_interior",3);
	}
}

//Function Number: 44
setup_dof_door_breach()
{
	common_scripts\utility::flag_wait("training_s1_breach_begin");
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehenable",1);
	}

	level.player enablephysicaldepthoffieldscripting();
	wait(0.5);
	level.player setphysicaldepthoffield(1.2,18.5,20,20);
	wait(2);
	level.player setphysicaldepthoffield(1.2,77.3,20,20);
	wait(2.15);
	level.player setphysicaldepthoffield(1.2,89,20,20);
	wait(5);
	level.player disablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehenable",0);
	}
}

//Function Number: 45
setup_lighting_drone_attack()
{
	common_scripts\utility::flag_wait("flag_obj_rescue1_drone_attack_clear");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
	}

	maps\_utility::vision_set_fog_changes("recovery_drone_battle",1);
	common_scripts\utility::flag_wait("flag_obj_rescue1_patio_ambush");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
	}
}

//Function Number: 46
setup_lighting_night_pool()
{
	wait(0.5);
	var_00 = getentarray("recovery_night_pool_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_night_lighting_pool_volume();
	}
}

//Function Number: 47
setup_night_lighting_pool_volume()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("recovery_night");
		level.player setclutforplayer("clut_recovery_night_pool_to_end",1);
		if(level.nextgen)
		{
			maps\_utility::vision_set_fog_changes("recovery_night_pool_to_end",2);
		}
		else if(level.currentgen)
		{
			maps\_utility::vision_set_fog_changes("recovery_night",2);
		}

		if(level.nextgen)
		{
			thread maps\_lighting::lerp_spot_intensity("kitchen_window_light",1,40000);
		}
	}
}

//Function Number: 48
hide_reveal_screen_reflections()
{
	var_00 = getentarray("hangar_reveal","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}
}

//Function Number: 49
setup_knockdown_sequence()
{
	common_scripts\utility::flag_wait("knockdown_lighting");
	maps\_utility::vision_set_fog_changes("recovery_night",1);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
		setsaveddvar("r_dof_physical_bokehenable","1");
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(2,22.4,20,20);
		wait(3);
		level.player setphysicaldepthoffield(2,11.36,20,20);
		wait(2.1);
		level.player setphysicaldepthoffield(2,57.8,20,20);
		wait(2);
		level.player setphysicaldepthoffield(2,132.4,20,20);
		wait(6);
		level.player setphysicaldepthoffield(2,55.2,20,20);
		wait(5);
		level.player setphysicaldepthoffield(2,100.6,20,20);
		wait(4);
		level.player setphysicaldepthoffield(2,29.9,20,20);
		wait(4);
		level.player setphysicaldepthoffield(2,246,20,20);
		wait(5.5);
		level.player setphysicaldepthoffield(4,246,20,20);
		wait(2);
		level.player setphysicaldepthoffield(3,15.8,20,20);
		wait(2);
		level.player setphysicaldepthoffield(3,87.7,20,20);
		wait(2.4);
		level.player setphysicaldepthoffield(3.5,32.1,20,20);
		wait(16);
		level.player setphysicaldepthoffield(2,246,20,20);
		level.player disablephysicaldepthoffieldscripting();
		return;
	}

	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(2,22.4,20,20);
	wait(3);
	level.player setphysicaldepthoffield(2,11.36,20,20);
	wait(2.1);
	level.player setphysicaldepthoffield(2,57.8,20,20);
	wait(2);
	level.player setphysicaldepthoffield(2,132.4,20,20);
	wait(6);
	level.player setphysicaldepthoffield(2,55.2,20,20);
	wait(5);
	level.player setphysicaldepthoffield(2,100.6,20,20);
	wait(4);
	level.player setphysicaldepthoffield(2,29.9,20,20);
	wait(4);
	level.player setphysicaldepthoffield(2,246,20,20);
	wait(5.5);
	level.player setphysicaldepthoffield(4,246,20,20);
	wait(2);
	level.player setphysicaldepthoffield(3,15.8,20,20);
	wait(2);
	level.player setphysicaldepthoffield(3,87.7,20,20);
	wait(2.4);
	level.player setphysicaldepthoffield(3.5,32.1,20,20);
	wait(16);
	level.player setphysicaldepthoffield(2,246,20,20);
	level.player disablephysicaldepthoffieldscripting();
}

//Function Number: 50
setup_hangar_door_open_sequence()
{
	common_scripts\utility::flag_wait("training_s1_flag_lights_on");
	maps\_shg_fx::set_sun_flare_position((-40,72,0));
	if(level.nextgen)
	{
		if(level.xb3)
		{
			setsaveddvar("sm_sunShadowBoundsMin","-6400 -10240 -512");
			setsaveddvar("sm_sunShadowBoundsMax","6400 10240 2048");
			setsaveddvar("sm_sunShadowBoundsOverride","1");
		}
	}

	wait(2);
	maps\_utility::vision_set_fog_changes("recovery_hangar_door_bright",0.2);
	wait(2);
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("hangar_door_bounce",5,600000);
	}
	else
	{
		thread maps\_lighting::lerp_spot_intensity("hangar_door_bounce",5,100000);
	}

	wait(2.5);
	level.player lightsetforplayer("recovery_hangar_door_transition");
	level.player setclutforplayer("clut_recovery_hangar_transition",1);
	maps\_utility::vision_set_fog_changes("recovery_hangar_door_transition",3);
	thread disable_outerspacelighting_interior();
	common_scripts\utility::flag_wait("tour_ride_hangar_lighting");
	thread maps\_lighting::lerp_spot_intensity("hangar_door_bounce",1,0);
}

//Function Number: 51
setup_hangar_shadow_shell()
{
	wait(0.1);
	var_00 = getentarray("shadow_shell","targetname");
	var_01 = getent("shadow_shell_hole","targetname");
	var_02 = getent("light_plug","targetname");
	foreach(var_04 in var_00)
	{
		var_04.origin = var_04.origin + (0,0,-1E+07);
	}

	var_02.origin = var_01.origin + (0,0,-1E+07);
	common_scripts\utility::flag_wait("training_s1_flag_lights_on");
	foreach(var_04 in var_00)
	{
		var_04.origin = var_04.origin + (0,0,1E+07);
	}

	common_scripts\utility::flag_wait("training_s1_flag_doors_open");
	var_01.origin = var_01.origin + (0,0,-1E+07);
	common_scripts\utility::flag_wait("tour_ride_hangar_lighting");
	foreach(var_04 in var_00)
	{
		var_04.origin = var_04.origin + (0,0,-1E+07);
	}

	var_01.origin = var_01.origin + (0,0,1E+07);
}

//Function Number: 52
setup_hangar_interior_walls()
{
	wait(0.1);
	var_00 = getent("lighting_centroid_hangar_door_interior","targetname");
	var_01 = getent("lighting_centroid_hangar_door_exterior","targetname");
	var_02 = getent("walls_interior_doorframe","targetname");
	var_03 = getent("right_side_wall","targetname");
	wait(0.1);
	var_04 = getent("walls_interior_roof","targetname");
	var_05 = getent("interior_roof_back","targetname");
	var_06 = getent("rear_wall","targetname");
	var_07 = getent("transition_hangar_doorframe","targetname");
	var_08 = getent("transition_hangar_doorframe_a","targetname");
	var_09 = getent("transition_hangar_doorframe_b","targetname");
	var_02.origin = var_02.origin + (0,0,-1E+07);
	var_04.origin = var_04.origin + (0,0,-1E+07);
	var_05.origin = var_05.origin + (0,0,-1E+07);
	var_03.origin = var_03.origin + (0,0,-1E+07);
	var_06.origin = var_06.origin + (0,0,-1E+07);
	var_07.origin = var_07.origin + (0,0,-1E+07);
	var_08.origin = var_08.origin + (0,0,-1E+07);
	var_09.origin = var_09.origin + (0,0,-1E+07);
	common_scripts\utility::flag_wait("training_s1_flag_wall_interior_decloak");
	var_02.origin = var_02.origin + (0,0,1E+07);
	var_04.origin = var_04.origin + (0,0,1E+07);
	var_03.origin = var_03.origin + (0,0,1E+07);
	var_05.origin = var_05.origin + (0,0,1E+07);
	var_06.origin = var_06.origin + (0,0,1E+07);
	var_07.origin = var_07.origin + (0,0,1E+07);
	var_02 overridelightingorigin(var_00.origin);
	var_04 overridelightingorigin(var_00.origin);
	var_05 overridelightingorigin(var_00.origin);
	var_03 overridelightingorigin(var_00.origin);
	var_06 overridelightingorigin(var_00.origin);
	var_07 overridelightingorigin(var_00.origin);
	common_scripts\utility::flag_wait("training_s1_end_enter_jeep");
	wait(2);
	var_07.origin = var_07.origin + (0,0,-1E+07);
	var_08.origin = var_08.origin + (0,0,1E+07);
	var_09.origin = var_09.origin + (0,0,1E+07);
	wait(0.15);
	var_08 overridelightingorigin(var_00.origin);
	var_09 overridelightingorigin(var_01.origin);
	common_scripts\utility::flag_wait("tour_ride_hangar_lighting");
	var_02.origin = var_02.origin + (0,0,-1E+07);
	var_04.origin = var_04.origin + (0,0,-1E+07);
	var_03.origin = var_03.origin + (0,0,-1E+07);
	var_05.origin = var_05.origin + (0,0,-1E+07);
	var_06.origin = var_06.origin + (0,0,-1E+07);
	if(level.currentgen)
	{
		var_07.origin = var_07.origin + (0,0,1E+07);
		level waittill("tff_post_tour_aug_reality_to_training");
		var_07.origin = var_07.origin + (0,0,-1E+07);
	}

	common_scripts\utility::flag_wait("ready_room_elevator_lighting");
	var_08.origin = var_08.origin + (0,0,-1E+07);
	var_09.origin = var_09.origin + (0,0,-1E+07);
}

//Function Number: 53
setup_lighting_hangar_doors()
{
	wait(0.25);
	var_00 = getent("lighting_centroid_hangar_door_interior","targetname");
	var_01 = getent("lighting_centroid_hangar_door_exterior","targetname");
	var_02 = getent("reflection_centroid_hangar_door_interior","targetname");
	var_03 = getent("tour_giant_door_01_l_part1","targetname");
	var_04 = getent("tour_giant_door_01_l_part2","targetname");
	var_05 = getent("tour_giant_door_01_r_part1","targetname");
	var_06 = getent("tour_giant_door_01_r_part2","targetname");
	var_06 = getent("tour_giant_door_01_r_part2","targetname");
	var_03 overridelightingorigin(var_00.origin);
	var_03 overridereflectionprobe(var_02.origin);
	var_04 overridelightingorigin(var_00.origin);
	var_04 overridereflectionprobe(var_02.origin);
	var_05 overridelightingorigin(var_00.origin);
	var_05 overridereflectionprobe(var_02.origin);
	var_06 overridelightingorigin(var_00.origin);
	var_06 overridereflectionprobe(var_02.origin);
	common_scripts\utility::flag_wait("tour_ride_drive_lighting");
	wait(12);
	var_03 defaultlightingorigin();
	var_04 defaultlightingorigin();
	var_05 defaultlightingorigin();
	var_06 defaultlightingorigin();
}

//Function Number: 54
setup_lighting_training_end_character_sequence()
{
	wait(0.1);
	common_scripts\utility::flag_wait("knockdown_lighting");
	if(level.nextgen)
	{
		wait(11);
	}

	if(level.currentgen)
	{
		wait(5);
		level.player lightsetforplayer("recovery_hangar_door_transition");
		thread maps\_lighting::lerp_spot_intensity("hangar_door_sequence_street_lamp",0.5,8000);
		wait(13);
		thread maps\_lighting::lerp_spot_intensity("hangar_door_bounce",2,100000);
	}

	var_00 = level.gideon;
	var_01 = getent("lighting_centroid_training_end_characters","targetname");
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("hangar_door_sequence_rim",3,2000000);
	}

	var_00 overridelightingorigin(var_01.origin);
	wait(7.75);
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("hangar_door_sequence_street_lamp",0.2,100000);
		thread maps\_lighting::lerp_spot_color("hangar_door_sequence_street_lamp",0.2,(0.1,0.4,0.9));
	}

	wait(3);
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_color("hangar_door_sequence_street_lamp",0.2,(0.6,0.5,0.4));
	}

	wait(3.25);
	var_02 = getent("hangar_door_bounce","targetname");
	if(isdefined(var_02))
	{
		var_02 setlightshadowstate("force_on");
	}

	var_03 = level.irons;
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("hangar_door_sequence_street_lamp",8.5,50000);
	}
	else
	{
		thread maps\_lighting::lerp_spot_intensity("hangar_door_sequence_street_lamp",0.5,5000);
	}

	var_03 overridelightingorigin(var_01.origin);
	common_scripts\utility::flag_wait("training_s1_end_enter_jeep");
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("hangar_door_sequence_street_lamp",2,800);
	}

	maps\_utility::vision_set_fog_changes("recovery_get_in_jeep",1);
	level.player lightsetforplayer("recovery_get_in_jeep");
	var_03 defaultlightingorigin();
	var_00 defaultlightingorigin();
	common_scripts\utility::flag_wait("tour_ride_drive_lighting");
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("hangar_door_bounce",5,100000);
	}

	if(level.currentgen)
	{
	}

	var_02 setlightshadowstate("normal");
	thread glass_door_01_exterior_lighting();
	thread glass_door_02_exterior_lighting();
	thread glass_door_03_exterior_lighting();
	thread glass_door_04_exterior_lighting();
}

//Function Number: 55
set_irons_tour_ride_reflection()
{
	if(level.currentgen)
	{
		wait(10);
		level.irons overridematerial("mtl_irons_head_wrinkle_tns","mtl_irons_head_wrinkle_tour_ride");
		common_scripts\utility::flag_wait("tour_ride_reset_irons_reflection");
		level.irons defaultreflectionprobe();
	}
}

//Function Number: 56
setup_tour_ride_skin_spec_fix()
{
	common_scripts\utility::flag_wait("tour_ride_drive_lighting");
	wait(0.5);
	level.irons overridematerial("mtl_irons_head_wrinkle_tns","mtl_irons_head_wrinkle_recoverytour_tns");
	level.irons overridematerial("mtl_irons_hair","mtl_irons_hair_recoverytour");
	level.irons overridematerial("mtl_irons_hair_cards","mtl_irons_hair_cards_recoverytour");
	level.gideon overridematerial("mtl_gideon_head_wrinkle_tns","mtl_gideon_head_wrinkle_recoverytour_tns");
	wait(20);
	level.gideon overridematerialreset();
	common_scripts\utility::flag_wait("tour_ride_hangar_lighting");
	common_scripts\utility::flag_wait("tour_ride_end_lighting");
	wait(17);
	level.irons overridematerialreset();
}

//Function Number: 57
setup_dof_tour_ride()
{
	if(level.nextgen)
	{
		common_scripts\utility::flag_wait("tour_ride_drive_lighting");
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","0");
		setsaveddvar("r_dof_physical_bokehenable","0");
		wait(2.25);
		resetsundirection();
		wait(2.5);
		resetsunlight();
		common_scripts\utility::flag_wait("tour_ride_end_lighting");
		setsaveddvar("r_mbCameraRotationInfluence","1");
		wait(30);
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_mbCameraRotationInfluence","0");
		return;
	}

	if(level.currentgen)
	{
		common_scripts\utility::flag_wait("tour_ride_drive_lighting");
		wait(2.25);
		wait(2.5);
		common_scripts\utility::flag_wait("tour_ride_end_lighting");
		wait(13);
		level.player lightsetforplayer("recovery_day_ssn");
		wait(11);
		level.player lightsetforplayer("recovery_day");
		wait(19);
		wait(0.2);
	}
}

//Function Number: 58
setup_repair_hangar_lighting()
{
	if(level.nextgen)
	{
		var_00 = getent("hangar_tour_light_02","targetname");
		common_scripts\utility::flag_wait("tour_ride_hangar_lighting");
		wait(5);
		var_00 maps\_lighting::lerp_light_fov_range(90,60,50,40,2);
		thread maps\_lighting::lerp_spot_intensity("hangar_tour_light_02",2,4000000);
		thread maps\_lighting::lerp_spot_intensity("tour_hangar_irons_rim",2,1000000);
	}
}

//Function Number: 59
setup_tour_hangar_doors_lighting()
{
	var_00 = getent("lighting_centroid_hangar_door_tour_01","targetname");
	var_01 = getent("lighting_centroid_hangar_door_tour_02","targetname");
	var_02 = getent("tour_hangar_door_01_r_part1","targetname");
	var_03 = getent("tour_hangar_door_01_r_part2","targetname");
	var_04 = getent("tour_hangar_door_01_l_part1","targetname");
	var_05 = getent("tour_hangar_door_01_l_part2","targetname");
	var_04 overridelightingorigin(var_00.origin);
	var_05 overridelightingorigin(var_00.origin);
	var_02 overridelightingorigin(var_01.origin);
	var_03 overridelightingorigin(var_01.origin);
}

//Function Number: 60
setup_tour_hangar_opening()
{
	wait(0.25);
	var_00 = getent("hangar_door_fill_block","targetname");
	var_00.origin = var_00.origin + (0,0,-1E+07);
	common_scripts\utility::flag_wait("tour_ride_hangar_lighting");
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("tour_ride_hangar_fill",5,1000000);
		thread maps\_lighting::lerp_spot_color("tour_ride_hangar_fill",0.1,(0.4,0.6,1));
		wait(11);
		thread maps\_lighting::lerp_spot_intensity("tour_ride_hangar_fill",3,5000);
	}
}

//Function Number: 61
setup_lighting_exo_hangar_doorway()
{
	var_00 = getentarray("exo_hangar_doorway_lighting_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_exo_hangar_doorway_volume();
	}
}

//Function Number: 62
setup_lighting_exo_hangar_doorway_volume()
{
	for(;;)
	{
		self waittill("trigger");
		if(level.nextgen)
		{
			level.player lightsetforplayer("recovery_day");
			level.player setclutforplayer("clut_recovery_day_exo_area",4);
		}

		setsaveddvar("r_gunSightColorEntityScale",1);
		setsaveddvar("r_gunSightColorNoneScale",1);
		thread glass_door_01_exterior_lighting();
		thread glass_door_02_exterior_lighting();
		if(level.nextgen)
		{
			maps\_utility::vision_set_fog_changes("recovery_day",4);
		}

		if(level.currentgen)
		{
			maps\_utility::vision_set_fog_changes("recovery_day",2);
		}

		var_00 = getentarray("hangar_exterior","targetname");
		foreach(var_02 in var_00)
		{
			var_02 show();
		}
	}
}

//Function Number: 63
setup_lab_entrance_light()
{
	wait(0.1);
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("hangar_exo_entrance_door_light",1,100000);
		thread maps\_lighting::lerp_spot_intensity("exo_hangar_entry_computer_light",1,200);
	}

	if(level.currentgen)
	{
		thread maps\_lighting::lerp_spot_intensity("exo_arm_entrance_key",1,100000);
		thread maps\_lighting::lerp_spot_intensity("exo_hangar_entry_computer_light",1,500);
	}
}

//Function Number: 64
setup_lighting_lab_interior()
{
	var_00 = getentarray("lab_lighting_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_lab_interior_volume();
	}
}

//Function Number: 65
setup_lighting_lab_interior_volume()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("recovery_lab_interior");
		level.player setclutforplayer("clut_recovery_lab",1);
		maps\_utility::vision_set_fog_changes("recovery_lab_interior",3);
	}
}

//Function Number: 66
setup_lighting_exo_hangar()
{
	var_00 = getentarray("exo_hangar_lighting_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_exo_hangar_volume();
	}
}

//Function Number: 67
setup_lighting_exo_hangar_volume()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("recovery_lab_interior");
		level.player setclutforplayer("clut_recovery_lab",1);
		maps\_utility::vision_set_fog_changes("recovery_lab_interior",3);
		thread glass_door_01_interior_lighting();
		thread glass_door_02_interior_lighting();
	}
}

//Function Number: 68
setup_lighting_lab_warehouse()
{
	var_00 = getentarray("atrium_lighting_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_lab_warehouse_volume();
	}
}

//Function Number: 69
setup_lighting_lab_warehouse_volume()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("recovery_lab_warehouse");
		level.player setclutforplayer("clut_recovery_lab",1);
		maps\_utility::vision_set_fog_changes("recovery_lab_warehouse",2);
	}
}

//Function Number: 70
setup_lighting_hangar_demos()
{
	wait(0.25);
	var_00 = getent("lighting_centroid_exo_push_01","targetname");
	var_01 = getent("lighting_centroid_exo_push_02","targetname");
	var_02 = getent("exo_warehouse_gun_lighting_centroid","targetname");
	var_03 = getent("exo_push_sled_01","targetname");
	var_04 = getent("exo_push_sled_02","targetname");
	var_05 = getent("exo_room_turret","targetname");
	var_03 overridelightingorigin(var_01.origin);
	var_04 overridelightingorigin(var_00.origin);
	var_05 overridelightingorigin(var_02.origin);
	var_05 overridereflectionprobe(var_02.origin);
}

//Function Number: 71
setup_lighting_exo_room()
{
	var_00 = getentarray("exo_room_lighting_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_exo_room_lighting_volume();
	}
}

//Function Number: 72
setup_exo_room_lighting_volume()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("recovery_lab_exo_room");
		level.player setclutforplayer("clut_recovery_lab",1);
		maps\_utility::vision_set_fog_changes("recovery_lab_interior",2);
	}
}

//Function Number: 73
setup_exo_arm_moment_lighting()
{
	common_scripts\utility::flag_wait("tour_exo_arm");
	level.player lightsetforplayer("recovery_lab_exo_arm_moment");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_dof_physical_bokehenable",1);
	}

	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(4,28);
	wait(4);
	level.player setphysicaldepthoffield(4,12.3);
	common_scripts\utility::flag_wait("desk_exit");
	wait(3);
	level.player setphysicaldepthoffield(4,15);
	wait(4);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_dof_physical_bokehenable",0);
		setsaveddvar("r_dof_physical_hipfstop",2);
	}

	level.player disablephysicaldepthoffieldscripting();
	wait(0.5);
	common_scripts\utility::flag_wait("desk_exit");
	level.player lightsetforplayer("recovery_lab_exo_room");
}

//Function Number: 74
setup_lighting_firing_range_doorway()
{
	var_00 = getentarray("firing_range_doorway_lighting_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_firing_doorway_volume();
	}
}

//Function Number: 75
setup_lighting_firing_doorway_volume()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("recovery_day");
		level.player setclutforplayer("clut_recovery_day_exo_area",4);
		setsaveddvar("r_gunSightColorEntityScale",1);
		setsaveddvar("r_gunSightColorNoneScale",1);
		thread glass_door_03_exterior_lighting();
		thread glass_door_04_exterior_lighting();
		if(level.nextgen)
		{
			maps\_utility::vision_set_fog_changes("recovery_day",4);
		}

		if(level.currentgen)
		{
			maps\_utility::vision_set_fog_changes("recovery_day",2);
		}

		var_00 = getentarray("hangar_exterior","targetname");
		foreach(var_02 in var_00)
		{
			var_02 show();
		}
	}
}

//Function Number: 76
setup_lighting_firing_range_entrance()
{
	var_00 = getentarray("firing_range_entrance_lighting_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_firing_range_entrance_volume();
	}
}

//Function Number: 77
setup_lighting_firing_range_entrance_volume()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("recovery_lab_interior");
		level.player setclutforplayer("clut_recovery_lab",1);
		maps\_utility::vision_set_fog_changes("recovery_lab_interior",3);
		thread glass_door_03_interior_lighting();
		thread glass_door_04_interior_lighting();
	}
}

//Function Number: 78
setup_lighting_firing_range()
{
	var_00 = getentarray("firing_range_lighting_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_firing_range_volume();
	}
}

//Function Number: 79
setup_lighting_firing_range_volume()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("recovery_firing_range");
		level.player setclutforplayer("clut_recovery_firing_range",1);
		maps\_utility::vision_set_fog_changes("recovery_firing_range",2);
		setsaveddvar("r_gunSightColorEntityScale",0.75);
		setsaveddvar("r_gunSightColorNoneScale",0.75);
	}
}

//Function Number: 80
setup_lighting_firing_range_stall()
{
	var_00 = getentarray("firing_range_lighting_volume_01","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_firing_range_stall_01_volume();
	}

	var_04 = getentarray("firing_range_lighting_volume_02","targetname");
	foreach(var_06 in var_04)
	{
		var_06 thread setup_lighting_firing_range_stall_02_volume();
	}

	var_08 = getentarray("firing_range_lighting_volume_03","targetname");
	foreach(var_0A in var_08)
	{
		var_0A thread setup_lighting_firing_range_stall_03_volume();
	}

	var_0C = getentarray("firing_range_lighting_volume_04","targetname");
	foreach(var_0E in var_0C)
	{
		var_0E thread setup_lighting_firing_range_stall_04_volume();
	}

	var_10 = getentarray("firing_range_lighting_volume_05","targetname");
	foreach(var_12 in var_10)
	{
		var_12 thread setup_lighting_firing_range_stall_05_volume();
	}

	var_14 = getentarray("firing_range_lighting_volume_06","targetname");
	foreach(var_16 in var_14)
	{
		var_16 thread setup_lighting_firing_range_stall_06_volume();
	}

	var_18 = getentarray("firing_range_lighting_volume_07","targetname");
	foreach(var_1A in var_18)
	{
		var_1A thread setup_lighting_firing_range_stall_07_volume();
	}

	var_1C = getentarray("firing_range_lighting_volume_08","targetname");
	foreach(var_1E in var_1C)
	{
		var_1E thread setup_lighting_firing_range_stall_08_volume();
	}
}

//Function Number: 81
setup_lighting_firing_range_stall_01_volume()
{
	for(;;)
	{
		self waittill("trigger");
		thread maps\_lighting::lerp_spot_intensity("firing_range_floor_light_01",0.5,5000);
		common_scripts\_exploder::exploder("range_01");
		while(level.player istouching(self))
		{
			wait(1);
		}

		thread maps\_lighting::lerp_spot_intensity("firing_range_floor_light_01",0.5,0.01);
		wait(0.5);
		common_scripts\_exploder::kill_exploder("range_01");
	}
}

//Function Number: 82
setup_lighting_firing_range_stall_02_volume()
{
	for(;;)
	{
		self waittill("trigger");
		thread maps\_lighting::lerp_spot_intensity("firing_range_floor_light_02",0.5,5000);
		common_scripts\_exploder::exploder("range_02");
		while(level.player istouching(self))
		{
			wait(1);
		}

		thread maps\_lighting::lerp_spot_intensity("firing_range_floor_light_02",0.5,0.01);
		wait(0.5);
		common_scripts\_exploder::kill_exploder("range_02");
	}
}

//Function Number: 83
setup_lighting_firing_range_stall_03_volume()
{
	for(;;)
	{
		self waittill("trigger");
		thread maps\_lighting::lerp_spot_intensity("firing_range_floor_light_03",0.5,5000);
		common_scripts\_exploder::exploder("range_03");
		while(level.player istouching(self))
		{
			wait(1);
		}

		thread maps\_lighting::lerp_spot_intensity("firing_range_floor_light_03",0.5,0.01);
		wait(0.5);
		common_scripts\_exploder::kill_exploder("range_03");
	}
}

//Function Number: 84
setup_lighting_firing_range_stall_04_volume()
{
	for(;;)
	{
		self waittill("trigger");
		thread maps\_lighting::lerp_spot_intensity("firing_range_floor_light_04",0.5,5000);
		common_scripts\_exploder::exploder("range_04");
		while(level.player istouching(self))
		{
			wait(1);
		}

		thread maps\_lighting::lerp_spot_intensity("firing_range_floor_light_04",0.5,0.01);
		wait(0.5);
		common_scripts\_exploder::kill_exploder("range_04");
	}
}

//Function Number: 85
setup_lighting_firing_range_stall_05_volume()
{
	for(;;)
	{
		self waittill("trigger");
		thread maps\_lighting::lerp_spot_intensity("firing_range_floor_light_05",0.5,5000);
		common_scripts\_exploder::exploder("range_05");
		while(level.player istouching(self))
		{
			wait(1);
		}

		thread maps\_lighting::lerp_spot_intensity("firing_range_floor_light_05",0.5,0.01);
		wait(0.5);
		common_scripts\_exploder::kill_exploder("range_05");
	}
}

//Function Number: 86
setup_lighting_firing_range_stall_06_volume()
{
	for(;;)
	{
		self waittill("trigger");
		thread maps\_lighting::lerp_spot_intensity("firing_range_floor_light_06",0.5,5000);
		common_scripts\_exploder::exploder("range_06");
		while(level.player istouching(self))
		{
			wait(1);
		}

		thread maps\_lighting::lerp_spot_intensity("firing_range_floor_light_06",0.5,0.01);
		wait(0.5);
		common_scripts\_exploder::kill_exploder("range_06");
	}
}

//Function Number: 87
setup_lighting_firing_range_stall_07_volume()
{
	for(;;)
	{
		self waittill("trigger");
		thread maps\_lighting::lerp_spot_intensity("firing_range_floor_light_07",0.5,5000);
		common_scripts\_exploder::exploder("range_07");
		while(level.player istouching(self))
		{
			wait(1);
		}

		thread maps\_lighting::lerp_spot_intensity("firing_range_floor_light_07",0.5,0.01);
		wait(0.5);
		common_scripts\_exploder::kill_exploder("range_07");
	}
}

//Function Number: 88
setup_lighting_firing_range_stall_08_volume()
{
	for(;;)
	{
		self waittill("trigger");
		thread maps\_lighting::lerp_spot_intensity("firing_range_floor_light_08",0.5,5000);
		common_scripts\_exploder::exploder("range_08");
		while(level.player istouching(self))
		{
			wait(1);
		}

		thread maps\_lighting::lerp_spot_intensity("firing_range_floor_light_08",0.5,0.01);
		wait(0.5);
		common_scripts\_exploder::kill_exploder("range_08");
	}
}

//Function Number: 89
setup_lighting_firing_range_stall_exposure()
{
	var_00 = getentarray("firing_range_stall_lighting_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_firing_range_stall_lighting_volume();
	}
}

//Function Number: 90
setup_firing_range_stall_lighting_volume()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("recovery_firing_range_stall");
		while(level.player istouching(self))
		{
			wait(0.1);
		}

		level.player lightsetforplayer("recovery_firing_range");
	}
}

//Function Number: 91
setup_lighting_firing_range_gallery()
{
	wait(0.5);
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("range_fill_front",0.25,60000);
		thread maps\_lighting::lerp_spot_intensity("range_fill_middle",0.25,60000);
		thread maps\_lighting::lerp_spot_intensity("range_fill_back",0.25,60000);
		thread maps\_lighting::lerp_spot_intensity("range_fill_bounce",0.25,30000);
	}
}

//Function Number: 92
setup_lighting_firing_range_lights_moment()
{
	var_00 = getentarray("light_off_row_1","targetname");
	var_01 = getentarray("light_off_row_2","targetname");
	var_02 = getentarray("light_off_row_3","targetname");
	var_03 = getentarray("light_off_row_4","targetname");
	var_04 = getentarray("light_off_row_5","targetname");
	var_05 = getentarray("light_on_row_1","targetname");
	var_06 = getentarray("light_on_row_2","targetname");
	var_07 = getentarray("light_on_row_3","targetname");
	var_08 = getentarray("light_on_row_4","targetname");
	var_09 = getentarray("light_on_row_5","targetname");
	foreach(var_0B in var_00)
	{
		var_0B hide();
	}

	foreach(var_0B in var_01)
	{
		var_0B hide();
	}

	foreach(var_0B in var_02)
	{
		var_0B hide();
	}

	foreach(var_0B in var_03)
	{
		var_0B hide();
	}

	foreach(var_0B in var_04)
	{
		var_0B hide();
	}
}

//Function Number: 93
shooting_range_ramp_down_lighting()
{
	var_00 = getentarray("light_off_row_1","targetname");
	var_01 = getentarray("light_off_row_2","targetname");
	var_02 = getentarray("light_off_row_3","targetname");
	var_03 = getentarray("light_off_row_4","targetname");
	var_04 = getentarray("light_off_row_5","targetname");
	var_05 = getentarray("light_on_row_1","targetname");
	var_06 = getentarray("light_on_row_2","targetname");
	var_07 = getentarray("light_on_row_3","targetname");
	var_08 = getentarray("light_on_row_4","targetname");
	var_09 = getentarray("light_on_row_5","targetname");
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("range_fill_front",0.1,0);
		thread maps\_lighting::lerp_spot_intensity("range_fill_bounce",0.1,10000);
	}

	foreach(var_0B in var_05)
	{
		var_0B hide();
	}

	foreach(var_0B in var_06)
	{
		var_0B hide();
	}

	foreach(var_0B in var_00)
	{
		var_0B show();
	}

	foreach(var_0B in var_01)
	{
		var_0B show();
	}

	wait(0.25);
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("range_fill_middle",0.1,0);
		thread maps\_lighting::lerp_spot_intensity("range_fill_bounce",0.1,1000);
	}

	foreach(var_0B in var_07)
	{
		var_0B hide();
	}

	foreach(var_0B in var_02)
	{
		var_0B show();
	}

	wait(0.25);
	level.player lightsetforplayer("recovery_firing_range_shooting");
	foreach(var_0B in var_08)
	{
		var_0B hide();
	}

	foreach(var_0B in var_09)
	{
		var_0B hide();
	}

	foreach(var_0B in var_03)
	{
		var_0B show();
	}

	foreach(var_0B in var_04)
	{
		var_0B show();
	}

	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("range_fill_back",0.04,0);
		thread maps\_lighting::lerp_spot_color("range_fill_bounce",0.1,(0.1,0.7,1));
		maps\_lighting::play_flickerlight_preset("firing_range_holo","range_fill_bounce",1250);
		wait(0.5);
		thread maps\_lighting::lerp_spot_intensity("range_fill_bounce",0.1,2500);
	}
}

//Function Number: 94
shooting_range_ramp_up_lighting()
{
	var_00 = getentarray("light_off_row_1","targetname");
	var_01 = getentarray("light_off_row_2","targetname");
	var_02 = getentarray("light_off_row_3","targetname");
	var_03 = getentarray("light_off_row_4","targetname");
	var_04 = getentarray("light_off_row_5","targetname");
	var_05 = getentarray("light_on_row_1","targetname");
	var_06 = getentarray("light_on_row_2","targetname");
	var_07 = getentarray("light_on_row_3","targetname");
	var_08 = getentarray("light_on_row_4","targetname");
	var_09 = getentarray("light_on_row_5","targetname");
	foreach(var_0B in var_05)
	{
		var_0B show();
	}

	foreach(var_0B in var_00)
	{
		var_0B hide();
	}

	foreach(var_0B in var_06)
	{
		var_0B show();
	}

	foreach(var_0B in var_01)
	{
		var_0B hide();
	}

	foreach(var_0B in var_07)
	{
		var_0B show();
	}

	foreach(var_0B in var_02)
	{
		var_0B hide();
	}

	foreach(var_0B in var_08)
	{
		var_0B show();
	}

	foreach(var_0B in var_03)
	{
		var_0B hide();
	}

	foreach(var_0B in var_09)
	{
		var_0B show();
	}

	foreach(var_0B in var_04)
	{
		var_0B hide();
	}

	level.player lightsetforplayer("recovery_firing_range_stall");
	if(level.nextgen)
	{
		maps\_lighting::stop_flickerlight("firing_range_holo","range_fill_bounce",1000);
		thread maps\_lighting::lerp_spot_intensity("range_fill_front",3.5,60000);
		thread maps\_lighting::lerp_spot_intensity("range_fill_middle",3.5,60000);
		thread maps\_lighting::lerp_spot_intensity("range_fill_back",3.5,60000);
		thread maps\_lighting::lerp_spot_intensity("range_fill_bounce",3.5,30000);
		thread maps\_lighting::lerp_spot_color("range_fill_bounce",0.1,(1,1,1));
	}
}

//Function Number: 95
setup_lighting_firing_range_exit()
{
	var_00 = getentarray("firing_range_exit_lighting_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_firing_range_exit_volume();
	}
}

//Function Number: 96
setup_lighting_firing_range_exit_volume()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("recovery_lab_interior");
		level.player setclutforplayer("clut_recovery_lab",1);
		maps\_utility::vision_set_fog_changes("recovery_lab_interior",3);
		thread glass_door_03_interior_lighting();
		thread glass_door_04_interior_lighting();
	}
}

//Function Number: 97
move_tour_door_shadow_caulk()
{
	if(level.nextgen)
	{
		var_00 = getent("door_01_shadow_caulk","targetname");
		var_00.origin = var_00.origin + (0,0,-1E+07);
		var_00 = getent("door_02_shadow_caulk","targetname");
		var_00.origin = var_00.origin + (0,0,-1E+07);
		var_00 = getent("door_03_shadow_caulk","targetname");
		var_00.origin = var_00.origin + (0,0,-1E+07);
		var_00 = getent("door_04_shadow_caulk","targetname");
		var_00.origin = var_00.origin + (0,0,-1E+07);
	}
}

//Function Number: 98
glass_door_01_interior_lighting()
{
	var_00 = getent("tour_door_1_interior_lighting_centroid","targetname");
	var_01 = getent("tour_glass_door_01_l","targetname");
	var_02 = getent("tour_glass_door_01_r","targetname");
	var_01 overridelightingorigin(var_00.origin);
	var_02 overridelightingorigin(var_00.origin);
	var_01 overridereflectionprobe(var_00.origin);
	var_02 overridereflectionprobe(var_00.origin);
}

//Function Number: 99
glass_door_01_exterior_lighting()
{
	var_00 = getent("tour_door_2_exterior_lighting_centroid","targetname");
	var_01 = getent("tour_glass_door_01_l","targetname");
	var_02 = getent("tour_glass_door_01_r","targetname");
	var_01 overridelightingorigin(var_00.origin);
	var_02 overridelightingorigin(var_00.origin);
	var_01 overridereflectionprobe(var_00.origin);
	var_02 overridereflectionprobe(var_00.origin);
}

//Function Number: 100
glass_door_02_interior_lighting()
{
	var_00 = getent("tour_door_2_interior_lighting_centroid","targetname");
	var_01 = getent("tour_glass_door_02_l","targetname");
	var_02 = getent("tour_glass_door_02_r","targetname");
	var_01 overridelightingorigin(var_00.origin);
	var_02 overridelightingorigin(var_00.origin);
	var_01 overridereflectionprobe(var_00.origin);
	var_02 overridereflectionprobe(var_00.origin);
}

//Function Number: 101
glass_door_02_exterior_lighting()
{
	var_00 = getent("tour_door_2_exterior_lighting_centroid","targetname");
	var_01 = getent("tour_glass_door_02_l","targetname");
	var_02 = getent("tour_glass_door_02_r","targetname");
	var_01 overridelightingorigin(var_00.origin);
	var_02 overridelightingorigin(var_00.origin);
	var_01 overridereflectionprobe(var_00.origin);
	var_02 overridereflectionprobe(var_00.origin);
}

//Function Number: 102
glass_door_03_interior_lighting()
{
	var_00 = getent("firing_range_entrance_interior_lighting_centroid","targetname");
	var_01 = getent("tour_glass_door_03_l","targetname");
	var_02 = getent("tour_glass_door_03_r","targetname");
	var_01 overridelightingorigin(var_00.origin);
	var_02 overridelightingorigin(var_00.origin);
	var_01 overridereflectionprobe(var_00.origin);
	var_02 overridereflectionprobe(var_00.origin);
}

//Function Number: 103
glass_door_03_exterior_lighting()
{
	var_00 = getent("tour_glass_door_03_l","targetname");
	var_01 = getent("tour_glass_door_03_r","targetname");
	var_00 defaultlightingorigin();
	var_01 defaultlightingorigin();
	var_00 defaultreflectionprobe();
	var_01 defaultreflectionprobe();
}

//Function Number: 104
tour_glass_door_04_lighting()
{
	level endon("training_room_elevator_activated");
	common_scripts\utility::flag_wait("shooting_range_completed_once");
	for(;;)
	{
		common_scripts\utility::flag_wait("tour_glass_door_04");
		thread maps\_lighting::lerp_spot_intensity("firing_range_exit_fill",0.15,1500);
		common_scripts\utility::flag_waitopen("tour_glass_door_04");
		thread maps\_lighting::lerp_spot_intensity("firing_range_exit_fill",0.5,0);
	}
}

//Function Number: 105
glass_door_04_interior_lighting()
{
	var_00 = getent("lighting_centroid_firing_range_exit_doors","targetname");
	var_01 = getent("tour_glass_door_04_l","targetname");
	var_02 = getent("tour_glass_door_04_r","targetname");
	var_01 overridelightingorigin(var_00.origin);
	var_02 overridelightingorigin(var_00.origin);
	var_01 overridereflectionprobe(var_00.origin);
	var_02 overridereflectionprobe(var_00.origin);
}

//Function Number: 106
glass_door_04_exterior_lighting()
{
	var_00 = getent("tour_glass_door_04_l","targetname");
	var_01 = getent("tour_glass_door_04_r","targetname");
	var_00 defaultlightingorigin();
	var_01 defaultlightingorigin();
	var_00 defaultreflectionprobe();
	var_01 defaultreflectionprobe();
}

//Function Number: 107
setup_lighting_fx_during_mini_games()
{
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
	}
}

//Function Number: 108
turn_off_lighting_fx_post_mini_games()
{
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
	}
}

//Function Number: 109
setup_lighting_fly_drone()
{
	wait(0.5);
	level.player setclutforplayer("clut_lagos_drone",0.1);
	maps\_utility::vision_set_fog_changes("recovery_drone_view_day",0.1);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
		setsaveddvar("r_dof_physical_bokehenable",1);
	}
}

//Function Number: 110
setup_lighting_fly_drone_off()
{
	wait(0.5);
	level.player setclutforplayer("clut_recovery_day_exo_area",0.1);
	maps\_utility::vision_set_fog_changes("recovery_day",0.1);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_mbCameraRotationInfluence","0");
		setsaveddvar("r_dof_physical_bokehenable",0);
		setsaveddvar("r_dof_physical_hipfstop",2);
	}
}

//Function Number: 111
setup_lighting_fly_drone_off_night()
{
	wait(0.5);
	level.player setclutforplayer("clut_recovery_night_pool_to_end",0.1);
	maps\_utility::vision_set_fog_changes("recovery_night_pool_to_end",0.1);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_mbCameraRotationInfluence","0");
		setsaveddvar("r_dof_physical_bokehenable",0);
		setsaveddvar("r_dof_physical_hipfstop",2);
	}
}

//Function Number: 112
setup_lighting_training_2_transition()
{
	var_00 = getentarray("lighting_training_2_transition_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_lighting_training_2_transition_volume();
	}
}

//Function Number: 113
setup_lighting_training_2_transition_volume()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("recovery_ready_room");
		level.player setclutforplayer("clut_recovery_lab",1);
		maps\_utility::vision_set_fog_changes("recovery_lab_interior",3);
		var_00 = getent("elevator_shaft_spot","targetname");
		var_01 = getent("elevator_shaft_spot_02","targetname");
		var_00 setlightshadowstate("force_on");
		var_01 setlightshadowstate("force_on");
	}
}

//Function Number: 114
setup_lighting_ready_room_elevators()
{
	wait(1);
	thread maps\_lighting::lerp_spot_intensity("ready_room_holo_light",1,1500);
	thread maps\_lighting::lerp_spot_intensity("elevator_shaft_spot",1,500000);
	thread maps\_lighting::lerp_spot_intensity("elevator_shaft_spot_02",1,500000);
	maps\_lighting::play_flickerlight_preset("firing_range_holo","ready_room_holo_light",1500);
	var_00 = getent("ready_room_elevator_left","targetname");
	var_01 = getent("ready_room_elevator_right","targetname");
	var_02 = getent("elevator_01_lighting_centroid","targetname");
	var_03 = getent("elevator_02_lighting_centroid","targetname");
	var_04 = getent("elevator_shaft_spot","targetname");
	var_05 = getent("elevator_shaft_spot_02","targetname");
	var_00 overridelightingorigin(var_02.origin);
	var_01 overridelightingorigin(var_03.origin);
	common_scripts\utility::flag_wait("ready_room_elevator_lighting");
	var_04 setlightshadowstate("normal");
	var_05 setlightshadowstate("normal");
	thread maps\_lighting::lerp_spot_intensity("elevator_shaft_spot",10,0);
	wait(10);
	var_00 defaultlightingorigin();
	var_01 defaultlightingorigin();
}

//Function Number: 115
setup_lighting_elevator_ride()
{
	common_scripts\utility::flag_wait("ready_room_elevator_lighting");
	maps\_shg_fx::set_sun_flare_position((40,72,0));
	thread setup_outerspacelighting_interior();
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
	}

	if(level.xb3)
	{
		setsaveddvar("sm_sunShadowBoundsOverride","0");
	}

	common_scripts\utility::flag_wait("training_s2_ready");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_mbCameraRotationInfluence","0");
	}
}

//Function Number: 116
setup_training_2_start_area_lighting()
{
	common_scripts\utility::flag_wait("training_2_start_area_lighting");
	if(level.currentgen)
	{
		wait(5);
	}

	level.player lightsetforplayer("recovery_night");
	level.player setclutforplayer("clut_recovery_night",3);
	maps\_utility::vision_set_fog_changes("recovery_night",3);
	setsaveddvar("r_gunSightColorEntityScale",0.75);
	setsaveddvar("r_gunSightColorNoneScale",0.75);
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("light_side_house_01",0.1,600);
		thread maps\_lighting::lerp_spot_intensity("light_side_house_02",0.1,15000);
	}
}

//Function Number: 117
setup_training_2_breach()
{
	common_scripts\utility::flag_wait("training_s2_breach_begin");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
		wait(1.65);
		maps\_utility::vision_set_fog_changes("recovery_house_door_breach",0.5);
		thread maps\_lighting::lerp_spot_intensity("lodge_breach_bounce",1.5,20000);
		wait(3.5);
		maps\_utility::vision_set_fog_changes("recovery_house_interior",3);
		thread maps\_lighting::lerp_spot_intensity("lodge_breach_bounce",3,100);
		wait(3);
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_mbCameraRotationInfluence","0");
	}
}

//Function Number: 118
setup_outerspacelighting_interior()
{
	var_00 = common_scripts\utility::getstruct("night_outerspacelighting","targetname");
	enableouterspacemodellighting(var_00.origin,(0.004,0.004,0.008));
}

//Function Number: 119
disable_outerspacelighting_interior()
{
	disableouterspacemodellighting();
}

//Function Number: 120
setup_dof_training_2_drone()
{
	common_scripts\utility::flag_wait("training_s2_drone_start");
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehenable",1);
	}

	level.player enablephysicaldepthoffieldscripting();
	wait(1);
	level.player setphysicaldepthoffield(1.8,13.9,20,20);
	wait(2);
	level.player setphysicaldepthoffield(1.8,53.3,20,20);
	wait(1);
	level.player setphysicaldepthoffield(1.8,12.8,20,20);
	wait(1.5);
	level.player disablephysicaldepthoffieldscripting();
	common_scripts\utility::flag_wait("training_s2_drone_attack_done");
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehenable",0);
	}
}

//Function Number: 121
setup_training_2_drone()
{
	common_scripts\utility::flag_wait("training_s2_drone_start");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
	}

	wait(5.25);
	maps\_utility::vision_set_fog_changes("recovery_drone_view_night",0.1);
	common_scripts\utility::flag_wait("training_s2_drone_attack_done");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_mbCameraRotationInfluence","0");
	}

	maps\_utility::vision_set_fog_changes("recovery_night_pool_to_end",0.1);
	level.player setclutforplayer("clut_recovery_night_pool_to_end",0.1);
}

//Function Number: 122
setup_training_2_suv_dof()
{
	common_scripts\utility::flag_wait("training_2_suv_lighting");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
		setsaveddvar("r_dof_physical_bokehenable",1);
	}

	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(2,21.1);
	wait(3.25);
	level.player setphysicaldepthoffield(2,48.9);
	wait(2);
	level.player setphysicaldepthoffield(2,30.4);
	wait(5);
	level.player disablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_mbCameraRotationInfluence","0");
	}
}

//Function Number: 123
setup_training_2_suv_fires()
{
	common_scripts\utility::flag_wait("training_2_car_fires_lighting");
	wait(6);
	maps\_lighting::play_flickerlight_preset("recovery_fire","training_2_end_fire_01",10000);
	maps\_lighting::play_flickerlight_preset("recovery_fire","training_2_end_fire_02",10000);
}

//Function Number: 124
setup_training_2_heli_dof()
{
	common_scripts\utility::flag_wait("flag_obj_rescue2_complete_clear");
	level.player lightsetforplayer("recovery_training_2_heli");
	maps\_utility::vision_set_fog_changes("recovery_night",1);
	level.player setclutforplayer("clut_recovery_night",1);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
		setsaveddvar("r_dof_physical_bokehenable",1);
	}

	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(2,112.1);
	wait(5);
	level.player setphysicaldepthoffield(2,112.1);
	wait(4);
	level.player setphysicaldepthoffield(3.5,42.9);
	wait(8);
	level.player setphysicaldepthoffield(2,31.4);
}

//Function Number: 125
setup_training_2_heli_lighting()
{
	wait(0.4);
	common_scripts\utility::flag_wait("flag_obj_rescue2_complete_clear");
	var_00 = getent("irons_heli_lighting_centroid","targetname");
	level.irons overridelightingorigin(var_00.origin);
	level.gideon overridelightingorigin(var_00.origin);
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("training_2_end_heli_light_01",6,1000);
		thread maps\_lighting::lerp_spot_intensity("heli_seats_light",3,5000);
		thread maps\_lighting::lerp_spot_intensity("heli_irons_fill",3,300);
	}
	else
	{
		thread maps\_lighting::lerp_spot_intensity("heli_seats_light",3,3000);
		thread maps\_lighting::lerp_spot_intensity("heli_irons_fill",3,6000);
	}

	thread maps\_lighting::lerp_spot_color("heli_irons_fill",0.15,(0.7,0.5,0.4));
}