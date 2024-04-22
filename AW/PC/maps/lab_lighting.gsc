/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: lab_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 91
 * Decompile Time: 1309 ms
 * Timestamp: 4/22/2024 2:33:01 AM
*******************************************************************/

//Function Number: 1
main()
{
	thread set_level_lighting_values();
	init_level_lighting_flags();
	thread setup_flickerlight_presets();
	thread lab_climb_lighting();
	thread breach_lighting();
	thread breach_dof();
	thread setup_dof_default_interior();
	thread setup_server_room_lighting();
	thread setup_dof_server_room();
	thread setup_server_room_door_open_lighting();
	thread setup_orange_room_enter_volume();
	thread setup_orange_room_exit_volume();
	thread setup_dof_mini_atrium();
	thread setup_sunlight_off();
	thread lighting_vehicle_takedown_01_lerp();
	thread tank_reveal_lighting();
	thread tank_reveal_models();
	thread sun_light_reset();
	thread outer_space_lighting();
	thread red_light_strobe_courtyard();
	precacherumble("heavy_1s");
	precacherumble("heavy_2s");
	precacherumble("heavy_3s");
	precacherumble("light_1s");
	precacherumble("light_2s");
	precacherumble("light_3s");
}

//Function Number: 2
init_level_lighting_flags()
{
	common_scripts\utility::flag_init("breach_start");
	common_scripts\utility::flag_init("player_climbing_wall_lighting");
	common_scripts\utility::flag_init("flag_forest_climb_wall_complete_lighting");
	common_scripts\utility::flag_init("flag_rappel_start_lighting");
	common_scripts\utility::flag_init("open_server_room_door_lighting");
	common_scripts\utility::flag_init("bio_weapons_hack_lighting");
	common_scripts\utility::flag_init("flag_server_room_start_lighting");
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
		setsunflareposition((-30,110,0));
		if(level.currentgen)
		{
			level.player lightsetforplayer("crash_hut");
		}

		if(level.nextgen)
		{
			setsaveddvar("r_dynamicOpl",1);
		}
	}
}

//Function Number: 4
setup_flickerlight_presets()
{
	maps\_lighting::create_flickerlight_preset("server_room_fire",(1,0.4246,0.2),(0.26,0.06,0),0.005,0.2,8);
}

//Function Number: 5
lab()
{
	level.player lightsetforplayer("lab");
	thread enable_motion_blur_rotation();
	thread maps\_utility::vision_set_fog_changes("lab",0);
	level.player setclutforplayer("clut_lab_exterior",0);
	thread intro_dof();
	thread crash_fire_light();
	thread hill_slide();
	thread heli_spotlight_exposure_change();
}

//Function Number: 6
intro_dof()
{
	wait(5);
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",1);
	}

	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(2,33);
	wait(15);
	level.player disablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",0);
	}
}

//Function Number: 7
crash_fire_light()
{
	if(level.nextgen)
	{
		var_00 = getent("crash_fire_light","targetname");
		var_00 setlightcolor((1,0.4,0.1));
		var_00 setlightintensity(1000000);
	}

	wait(12);
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("crash_fire_light",0.5,0);
	}
}

//Function Number: 8
heli_spotlight_exposure_change()
{
	wait(14);
	if(level.nextgen)
	{
		level.player lightsetforplayer("heli_spot_on");
	}
}

//Function Number: 9
hill_slide()
{
	common_scripts\utility::flag_wait("flag_player_slide_start");
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",1);
	}

	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(2,320,30,30);
	earthquake(0.25,3,level.player.origin,400);
	wait(6);
	level.player setphysicaldepthoffield(2,500,30,30);
	wait(2);
	level.player disablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",0);
	}
}

//Function Number: 10
enter_forest()
{
	level.player lightsetforplayer("enter_forest");
	level.player setclutforplayer("clut_lab_exterior",0);
	thread maps\_utility::vision_set_fog_changes("lab_enter_forest",0.01);
	thread enable_motion_blur_rotation();
}

//Function Number: 11
lab_climb_lighting()
{
	wait(0.1);
	thread lt_root_climb_rim_intensity_init();
	thread lt_root_climb_key_intensity_init();
	thread tree_roots_lighting();
	common_scripts\utility::flag_wait("player_climbing_wall_lighting");
	thread disable_motion_blur();
	thread lab_root_climb_vision();
	thread lab_root_climb_dof();
	thread lt_root_climb_key_shadow_res();
	thread lab_climb_rim_lighting_off();
}

//Function Number: 12
lt_root_climb_rim_intensity_init()
{
	if(level.nextgen)
	{
		var_00 = getent("lt_root_climb_rim","targetname");
		wait(0.1);
		var_00 setlightintensity(40000);
	}
}

//Function Number: 13
lt_root_climb_key_intensity_init()
{
	if(level.nextgen)
	{
		var_00 = getent("lt_root_climb_key","targetname");
		wait(0.1);
		var_00 setlightintensity(14000);
	}
}

//Function Number: 14
lt_root_climb_key_shadow_res()
{
	wait(2);
	if(level.nextgen)
	{
		var_00 = getent("lt_root_climb_key","targetname");
		var_00 setlightfovrange(40,30);
	}

	common_scripts\utility::flag_wait("flag_forest_climb_wall_complete_lighting");
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("lt_root_climb_key",1,0);
	}

	thread forest_takedown();
}

//Function Number: 15
lab_root_climb_vision()
{
	setsunflareposition((-70,110,0));
	maps\_utility::vision_set_fog_changes("lab_root_climb",1);
}

//Function Number: 16
lab_root_climb_dof()
{
	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(2,58);
}

//Function Number: 17
lab_climb_rim_lighting_off()
{
	common_scripts\utility::flag_wait("flag_player_cloak_on_pressed");
	if(level.nextgen)
	{
		level.player lightsetforplayer("climb_shadow_tweak");
	}

	level.player setphysicaldepthoffield(3,20,3,3);
	wait(2);
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("lt_root_climb_rim",1,0);
	}

	common_scripts\utility::flag_wait("flag_forest_climb_wall_complete_lighting");
	level.player disablephysicaldepthoffieldscripting();
	thread disable_motion_blur();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",0);
	}
}

//Function Number: 18
tree_roots_lighting()
{
	var_00 = getent("lighting_reflection_tree","targetname");
	var_01 = getent("lighting_centroid_tree","targetname");
	var_02 = getent("wallclimb_roots","targetname");
	var_02 overridereflectionprobe(var_00.origin);
	var_02 overridelightingorigin(var_01.origin);
}

//Function Number: 19
forest_takedown()
{
	level.player lightsetforplayer("logging_road");
	maps\_utility::vision_set_fog_changes("lab_logging_road",0);
	thread forest_takedown_dof();
}

//Function Number: 20
forest_takedown_dof()
{
	common_scripts\utility::flag_wait("flag_se_takedown_01_started");
	thread enable_motion_blur_rotation();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",1);
	}

	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(2,25,30,30);
	wait(5.5);
	level.player setphysicaldepthoffield(2,75,5,5);
	wait(1.5);
	level.player disablephysicaldepthoffieldscripting();
	thread disable_motion_blur();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",0);
	}
}

//Function Number: 21
logging_road()
{
	level.player lightsetforplayer("logging_road");
	maps\_utility::vision_set_fog_changes("lab_logging_road",0);
	level.player setclutforplayer("clut_lab_exterior",0);
}

//Function Number: 22
vrap_takedown_lights_on()
{
	if(level.nextgen)
	{
		wait(0.1);
		var_00 = getent("head_lights_vrap_takedown_b","targetname");
		var_01 = getent("head_lights_vrap_takedown_c","targetname");
		wait(1);
		var_00 setlightintensity(1000000);
	}
}

//Function Number: 23
vrap_takedown_lights_off(param_00)
{
	if(level.nextgen)
	{
		wait(0.1);
		var_01 = getent("head_lights_vrap_takedown_b","targetname");
		var_02 = getent("head_lights_vrap_takedown_c","targetname");
		wait(0.1);
		var_01 setlightintensity(0);
		var_02 setlightintensity(0);
	}

	soundscripts\_snd::snd_message("takedown_truck_lights_off");
	level notify("takedown_lights_off");
}

//Function Number: 24
lighting_vehicle_takedown_01_on()
{
	wait(0.05);
	common_scripts\_exploder::exploder(2132);
	if(level.nextgen)
	{
		var_00 = getent("take_down_light_01","targetname");
		var_01 = getent("take_down_light_02","targetname");
		wait(0.05);
		var_00 setlightintensity(10000);
		wait(0.05);
		var_01 setlightintensity(10000);
		level waittill("takedown_lights_off");
	}

	maps\_utility::stop_exploder(2132);
}

//Function Number: 25
lighting_vehicle_takedown_01_lerp()
{
	level waittill("takedown_lights_off");
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("take_down_light_01",0.5,0);
		thread maps\_lighting::lerp_spot_intensity("take_down_light_02",0.5,0);
	}
}

//Function Number: 26
lighting_vehicle_takedown_01(param_00)
{
	if(isdefined(param_00.helmet_tag))
	{
		param_00.helmet_tag delete();
	}

	param_00.helmet_tag = common_scripts\utility::spawn_tag_origin();
	var_01 = param_00.helmet_tag;
	var_01 linkto(param_00,"J_Head",(0,55,0),(0,0,0),0);
	thread vehicle_takedown_01_dof();
	wait(0.5);
	playfxontag(common_scripts\utility::getfx("point_blue_fill"),var_01,"tag_origin");
	wait(2.3);
	stopfxontag(common_scripts\utility::getfx("point_blue_fill"),var_01,"tag_origin");
}

//Function Number: 27
vehicle_takedown_01_dof()
{
	thread enable_motion_blur_rotation();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",1);
	}

	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(3,65,30,30);
	wait(2.7);
	level.player setphysicaldepthoffield(2,115,30,30);
	wait(7);
	thread disable_motion_blur();
	level.player disablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",0);
	}
}

//Function Number: 28
logging_road_gaz_headlight_moment()
{
	var_00 = common_scripts\utility::spawn_tag_origin();
	playfxontag(common_scripts\utility::getfx("headlight_gaz_spotlight"),var_00,"tag_origin");
	var_00 linkto(self,"TAG_HEADLIGHT_LEFT",(0,0,0),(0,0,0));
	wait(20);
	killfxontag(common_scripts\utility::getfx("headlight_gaz_spotlight"),var_00,"tag_origin");
}

//Function Number: 29
logging_road_post_vrap()
{
	level.player lightsetforplayer("logging_road_post_vrap");
	maps\_utility::vision_set_fog_changes("lab_logging_road_post_vrap",0);
}

//Function Number: 30
cliff_rappel()
{
	level.player lightsetforplayer("cliff_rappel");
	thread maps\_utility::vision_set_fog_changes("lab_cliff_rappel",0);
	level.player setclutforplayer("clut_lab_exterior",0);
}

//Function Number: 31
cliff_rappel_lighting_setup()
{
	thread cliff_rappel_lighting_init();
	thread cliff_rappel_moment();
	thread cliff_rappel_landing();
}

//Function Number: 32
cliff_rappel_lighting_init()
{
	if(level.nextgen)
	{
		var_00 = getent("cliff_light_key","targetname");
		var_01 = getent("cliff_light_fill","targetname");
		var_02 = getent("cliff_light_rim","targetname");
		thread maps\_lighting::lerp_spot_intensity("cliff_light_key",1,200000);
		var_00 setlightcolor((1,1,1));
		thread maps\_lighting::lerp_spot_intensity("cliff_light_fill",1,600000);
		thread maps\_lighting::lerp_spot_intensity("cliff_light_rim",1,500000);
		common_scripts\utility::flag_wait("flag_rappel_start_lighting");
		var_00 setlightfovrange(28,24);
		var_01 setlightfovrange(40,33);
		var_02 setlightfovrange(45,40);
	}
}

//Function Number: 33
cliff_rappel_moment()
{
	common_scripts\utility::flag_wait("flag_rappel_start_lighting");
	thread cliff_rappel_shadow_tweaks();
	maps\_utility::vision_set_fog_changes("lab_cliff_rappel_moment",2.5);
	thread enable_motion_blur_rotation();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",1);
	}

	level.player enablephysicaldepthoffieldscripting();
	wait(1.5);
	level.player setphysicaldepthoffield(2,15,30,30);
	wait(4);
	level.player setphysicaldepthoffield(2,38,30,30);
	wait(5.5);
	level.player setphysicaldepthoffield(5,50,30,30);
}

//Function Number: 34
cliff_rappel_shadow_tweaks()
{
	wait(0.45);
	level.player lightsetforplayer("cliff_rappel_spike");
	wait(5.5);
	level.player lightsetforplayer("cliff_rappel_moment");
	wait(3.5);
	level.player lightsetforplayer("cliff_rappel_jump");
	wait(3);
	level.player lightsetforplayer("cliff_rappel_moment");
	common_scripts\utility::flag_wait("flag_rappel_player_input_start");
	if(level.nextgen)
	{
		level.player lightsetforplayer("facility_breach");
	}
}

//Function Number: 35
cliff_rappel_lerpsun()
{
	if(level.nextgen)
	{
		wait(0.45);
		lerpsunangles((-50,110,0),(-50,-11,0),0.1,0,0);
		wait(5.5);
		lerpsunangles((-50,-11,0),(-50,110,0),0.1,0,0);
	}
}

//Function Number: 36
cliff_rappel_landing()
{
	level waittill("cliff_rappel_landing");
	thread maps\_utility::vision_set_fog_changes("lab_facility_breach",2);
	thread lab_camera_light();
	level.player disablephysicaldepthoffieldscripting();
	thread disable_motion_blur();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",0);
	}
}

//Function Number: 37
lab_camera_light()
{
	if(level.nextgen)
	{
		var_00 = getent("lab_camera_light","targetname");
		var_00 setlightintensity(500000);
		var_00 setlightcolor((0.3,0.5,1));
		common_scripts\utility::flag_wait("flag_light_security_camera_off");
		var_00 setlightintensity(0);
	}
}

//Function Number: 38
facility_breach()
{
	level.player lightsetforplayer("facility_breach");
	maps\_utility::vision_set_fog_changes("lab_facility_breach",0);
	level.player setclutforplayer("clut_lab_exterior",0);
	thread lab_camera_light();
}

//Function Number: 39
breach_fx()
{
	common_scripts\_exploder::exploder("breach_smoke_1");
	if(level.currentgen)
	{
	}
}

//Function Number: 40
breach_lighting()
{
	if(level.nextgen)
	{
		wait(1);
		thread maps\_lighting::lerp_spot_intensity("lab_breach_key",2,100000);
		common_scripts\utility::flag_wait("breach_start");
		thread maps\_utility::sun_light_fade((0.5,0.5,0.5),(0.1,0.1,0.1),1);
		thread enable_motion_blur_rotation();
		thread maps\_lighting::lerp_spot_intensity("lab_breach_rim",2,300000);
		wait(1.8);
		thread maps\_utility::vision_set_fog_changes("lab_facility_breach_moment",0.1);
		level.player lightsetforplayer("facility_breach_moment");
		wait(10.25);
		thread disable_motion_blur();
		level.player lightsetforplayer("breach_room");
		level.player setclutforplayer("clut_lab_breach_brick_interior",0.25);
		thread maps\_utility::vision_set_fog_changes("lab_facility_breach_room",5);
	}

	if(level.currentgen)
	{
		wait(1);
		common_scripts\utility::flag_wait("breach_start");
		wait(1.8);
		thread maps\_utility::vision_set_fog_changes("lab_facility_breach_moment",0.1);
		level.player lightsetforplayer("facility_breach_moment");
		wait(8);
		level.player lightsetforplayer("breach_fx");
		wait(2);
		level.player lightsetforplayer("breach_room");
	}
}

//Function Number: 41
breach_dof()
{
	common_scripts\utility::flag_wait("breach_start");
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",1);
	}

	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(1,61,30,30);
	wait(1.5);
	level.player setphysicaldepthoffield(1.5,19,30,30);
	wait(2);
	level.player setphysicaldepthoffield(1.5,93,30,30);
	wait(10);
	level.player disablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",0);
	}
}

//Function Number: 42
setup_dof_default_interior()
{
	var_00 = getentarray("lab_DOF_default_interior_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_dof_default_interior_volume();
	}
}

//Function Number: 43
setup_dof_default_interior_volume()
{
	self waittill("trigger");
}

//Function Number: 44
building_1()
{
	level.player lightsetforplayer("building_1_bright");
	maps\_utility::vision_set_fog_changes("lab_building_1",0);
	level.player setclutforplayer("clut_lab_breach_interior",0.25);
}

//Function Number: 45
setup_server_room_lighting()
{
	wait(1);
	common_scripts\utility::flag_wait("flag_server_room_start_lighting");
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("lab_server_room_fill",1,175000);
	}

	resetsunlight();
	common_scripts\_exploder::exploder(4031);
	common_scripts\_exploder::exploder(4032);
	common_scripts\_exploder::exploder(4033);
	common_scripts\_exploder::exploder(4034);
	common_scripts\utility::flag_wait("bio_weapons_hack_lighting");
	wait(24.5);
	common_scripts\_exploder::kill_exploder(4031);
	common_scripts\_exploder::kill_exploder(4032);
	common_scripts\_exploder::exploder(4132);
	wait(3.4);
	common_scripts\_exploder::kill_exploder(4033);
	common_scripts\_exploder::exploder(4133);
	if(level.nextgen)
	{
		maps\_lighting::play_flickerlight_preset("server_room_fire","server_room_exit_doorway_light",10000000);
	}

	wait(4.4);
	common_scripts\_exploder::kill_exploder(4034);
	common_scripts\_exploder::exploder(4134);
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("lab_server_room_fill",3,250000);
		maps\_lighting::play_flickerlight_preset("server_room_fire","lab_server_room_fill",250000);
		maps\_lighting::play_flickerlight_preset("server_room_fire","server_room_main_rim_light",250000);
	}
}

//Function Number: 46
setup_dof_server_room()
{
	common_scripts\utility::flag_wait("bio_weapons_hack_lighting");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
		setsaveddvar("r_dof_physical_bokehEnable",1);
	}

	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(1.2,200);
	wait(25.9);
	level.player setphysicaldepthoffield(1.2,57);
	wait(7.4);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_mbCameraRotationInfluence","0");
		setsaveddvar("r_dof_physical_bokehEnable",0);
	}

	level.player disablephysicaldepthoffieldscripting();
}

//Function Number: 47
setup_server_room_door_open_lighting()
{
	common_scripts\utility::flag_wait("bio_weapons_hack_lighting");
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("lab_server_door_open",1,160000);
	}

	common_scripts\utility::flag_wait("open_server_room_door_lighting");
	wait(0.1);
	level.player lightsetforplayer("after_server_room_bright");
	wait(5);
	level.player lightsetforplayer("building_1");
}

//Function Number: 48
setup_orange_room_enter_volume()
{
	var_00 = getentarray("orange_room_enter_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_orange_room_enter();
	}
}

//Function Number: 49
setup_orange_room_enter()
{
	for(;;)
	{
		self waittill("trigger");
		thread maps\_lighting::lerp_spot_intensity("courtyard_exterior_light_01",1,0);
	}
}

//Function Number: 50
setup_orange_room_exit_volume()
{
	var_00 = getentarray("orange_room_exit_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_orange_room_exit();
	}
}

//Function Number: 51
setup_orange_room_exit()
{
	for(;;)
	{
		self waittill("trigger");
		thread maps\_lighting::lerp_spot_intensity("courtyard_exterior_light_01",1,150000);
	}
}

//Function Number: 52
building_research_bridge()
{
	level.player lightsetforplayer("building_1");
	maps\_utility::vision_set_fog_changes("lab_connecting_hallway",0);
	level.player setclutforplayer("clut_lab_orange_interior",0.25);
}

//Function Number: 53
setup_dof_mini_atrium()
{
	var_00 = getentarray("lab_DOF_mini_atrium_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_dof_mini_atrium_volume();
	}
}

//Function Number: 54
setup_dof_mini_atrium_volume()
{
	self waittill("trigger");
}

//Function Number: 55
setup_sunlight_off()
{
	if(level.nextgen)
	{
		var_00 = getentarray("lab_sunlight_tweak_off_volume","targetname");
		foreach(var_02 in var_00)
		{
			var_02 thread setup_sunlight_off_volume();
		}
	}
}

//Function Number: 56
setup_sunlight_off_volume()
{
	for(;;)
	{
		self waittill("trigger");
		wait(0.1);
		setsunlight(0,0,0);
	}
}

//Function Number: 57
foam_room()
{
	level.player lightsetforplayer("foam_room_frost");
	maps\_utility::vision_set_fog_changes("lab_foam_room_frost",0);
	level.player setclutforplayer("clut_lab_blue_interior",0.25);
}

//Function Number: 58
foam_plant_dof()
{
	enable_motion_blur_rotation();
	wait(1);
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",1);
	}

	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(3.5,10,5,5);
	wait(2);
	level.player setphysicaldepthoffield(3.5,20,30,30);
	level waittill("reset_plant_dof");
	level.player disablephysicaldepthoffieldscripting();
	disable_motion_blur();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",0);
	}

	if(level.nextgen)
	{
		setsunlight(0,0,0);
	}
}

//Function Number: 59
courtyard()
{
	level.player lightsetforplayer("locker_room");
	maps\_utility::vision_set_fog_changes("lab_locker_room",0);
	level.player setclutforplayer("clut_lab_blue_interior",0.25);
	if(level.nextgen)
	{
		setsunlight(0,0,0);
	}
}

//Function Number: 60
courtyard_jammer()
{
	level.player lightsetforplayer("enter_courtyard");
	maps\_utility::vision_set_fog_changes("lab_enter_courtyard",0);
	level.player setclutforplayer("clut_lab_courtyard",0.25);
	if(level.nextgen)
	{
		setsunlight(0,0,0);
	}

	level notify("courtyard_red_strobe");
}

//Function Number: 61
courtyard_jammer_plant_dof()
{
	enable_motion_blur_rotation();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",1);
	}

	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(2.5,14,2,2);
	wait(2.5);
	level.player setphysicaldepthoffield(3.5,25,2,2);
	level waittill("reset_jammer_plant_dof");
	level.player disablephysicaldepthoffieldscripting();
	disable_motion_blur();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",0);
	}
}

//Function Number: 62
courtyard_sun_off()
{
	wait(0.1);
	if(level.nextgen)
	{
		setsunlight(0,0,0);
	}
}

//Function Number: 63
tank_hangar()
{
	maps\_utility::vision_set_fog_changes("lab_courtyard_walkway",0);
	level.player lightsetforplayer("courtyard_walkway");
	level.player setclutforplayer("clut_lab_courtyard",0.25);
	if(level.nextgen)
	{
		setsunlight(0,0,0);
	}
}

//Function Number: 64
tank_reveal_models()
{
	wait(0.05);
	var_00 = ["light_models_on_01","light_models_on_02","light_models_on_03","light_models_on_04","light_models_on_05","light_models_on_06","light_models_on_07"];
	foreach(var_02 in var_00)
	{
		foreach(var_04 in getentarray(var_02,"targetname"))
		{
			var_04 hide();
		}
	}

	var_07 = getent("tank_top_light_01","targetname");
	var_08 = getent("tank_top_light_02","targetname");
	var_09 = getent("tank_top_light_03","targetname");
	var_0A = getent("tank_top_light_04","targetname");
	if(level.nextgen)
	{
		var_0A setlightshadowstate("force_on");
	}

	var_0B = getent("tank_top_light_bounce_01","targetname");
	var_0C = getent("tank_top_light_bounce_02","targetname");
	var_0D = getent("tank_top_light_bounce_03","targetname");
	var_0E = getent("tank_top_light_bounce_04","targetname");
	common_scripts\utility::flag_wait("tank_reveal_volume");
	if(level.nextgen)
	{
		var_0A setlightshadowstate("force_on");
	}

	common_scripts\_exploder::exploder(7913);
	if(level.nextgen)
	{
		wait(1);
		var_09 setlightintensity(1000000);
		var_0D setlightintensity(5000);
		wait(1);
		var_0A setlightintensity(1000000);
		var_0E setlightintensity(5000);
		wait(1);
		var_07 setlightintensity(1000000);
		var_0B setlightintensity(5000);
		wait(1);
		var_08 setlightintensity(1000000);
		var_0C setlightintensity(5000);
	}

	common_scripts\utility::flag_wait("player_entering_hovertank");
	if(level.nextgen)
	{
		var_0A setlightshadowstate("force_off");
	}
}

//Function Number: 65
tank_reveal_models_start_point()
{
	wait(0.1);
	var_00 = ["floor_light_models_off_02","floor_light_models_off_03","floor_light_models_off_04"];
	var_01 = ["Light_dyn_on_01","Light_dyn_on_02","Light_dyn_on_03","Light_dyn_on_04","Light_dyn_on_05"];
	var_02 = ["tank_top_light_01","tank_top_light_02","tank_top_light_03","tank_top_light_04"];
	var_03 = ["tank_top_light_bounce_01","tank_top_light_bounce_02","tank_top_light_bounce_03","tank_top_light_bounce_04"];
	var_04 = ["light_models_on_01","light_models_on_02","light_models_on_03","light_models_on_04","light_models_on_05","light_models_on_06","light_models_on_07"];
	foreach(var_06 in var_04)
	{
		foreach(var_08 in getentarray(var_06,"targetname"))
		{
			var_08 show();
		}
	}

	foreach(var_06 in var_00)
	{
		foreach(var_08 in getentarray(var_06,"targetname"))
		{
			var_08 hide();
		}
	}

	foreach(var_06 in var_01)
	{
		foreach(var_11 in getentarray(var_06,"targetname"))
		{
			var_11 setlightintensity(100000);
		}
	}

	foreach(var_06 in var_02)
	{
		foreach(var_11 in getentarray(var_06,"targetname"))
		{
			var_11 setlightintensity(1000000);
		}
	}

	foreach(var_06 in var_03)
	{
		foreach(var_11 in getentarray(var_06,"targetname"))
		{
			var_11 setlightintensity(5000);
		}
	}

	common_scripts\_exploder::exploder(7011);
	common_scripts\_exploder::exploder(7012);
	common_scripts\_exploder::exploder(7013);
	common_scripts\_exploder::exploder(7014);
	common_scripts\_exploder::exploder(7015);
}

//Function Number: 66
tank_reveal_lighting()
{
	wait(0.05);
	var_00 = getentarray("Light_dyn_on_01","targetname");
	var_01 = getentarray("Light_dyn_on_02","targetname");
	var_02 = getentarray("Light_dyn_on_03","targetname");
	var_03 = getentarray("Light_dyn_on_04","targetname");
	var_04 = getentarray("Light_dyn_on_05","targetname");
	var_05 = getentarray("Light_dyn_on_06","targetname");
	var_06 = getentarray("light_models_on_01","targetname");
	var_07 = getentarray("light_models_on_02","targetname");
	var_08 = getentarray("light_models_on_03","targetname");
	var_09 = getentarray("light_models_on_04","targetname");
	var_0A = getentarray("light_models_on_05","targetname");
	var_0B = getentarray("light_models_on_06","targetname");
	var_0C = getentarray("light_models_on_07","targetname");
	var_0D = getentarray("floor_light_models_off_02","targetname");
	var_0E = getentarray("floor_light_models_off_03","targetname");
	var_0F = getentarray("floor_light_models_off_04","targetname");
	wait(0.05);
	common_scripts\utility::flag_wait("tank_reveal_volume");
	wait(1);
	soundscripts\_snd::snd_message("hangar_lights_on");
	common_scripts\_exploder::exploder(7011);
	common_scripts\_exploder::exploder(7021);
	foreach(var_11 in var_00)
	{
		var_11 setlightintensity(100000);
	}

	foreach(var_14 in var_06)
	{
		var_14 show();
	}

	wait(1);
	common_scripts\_exploder::exploder(7012);
	common_scripts\_exploder::exploder(7022);
	foreach(var_11 in var_01)
	{
		var_11 setlightintensity(100000);
	}

	foreach(var_14 in var_07)
	{
		var_14 show();
	}

	foreach(var_14 in var_0D)
	{
		var_14 hide();
	}

	var_1C = getent("blue_flicker","targetname");
	if(isdefined(var_1C))
	{
		var_1C setlightintensity(55000);
		var_1C setlightshadowstate("force_on");
	}

	wait(1);
	common_scripts\_exploder::exploder(7013);
	common_scripts\_exploder::exploder(7023);
	foreach(var_11 in var_02)
	{
		var_11 setlightintensity(100000);
	}

	foreach(var_14 in var_08)
	{
		var_14 show();
	}

	foreach(var_14 in var_0E)
	{
		var_14 hide();
	}

	wait(1);
	common_scripts\_exploder::exploder(7014);
	foreach(var_11 in var_03)
	{
		var_11 setlightintensity(100000);
	}

	foreach(var_14 in var_09)
	{
		var_14 show();
	}

	foreach(var_14 in var_0F)
	{
		var_14 hide();
	}

	wait(1);
	common_scripts\_exploder::exploder(7015);
	foreach(var_11 in var_04)
	{
		var_11 setlightintensity(100000);
	}

	foreach(var_11 in var_05)
	{
		var_11 setlightintensity(10000);
	}

	foreach(var_14 in var_0A)
	{
		var_14 show();
	}

	wait(1);
	common_scripts\_exploder::exploder(7016);
	foreach(var_14 in var_0B)
	{
		var_14 show();
	}

	wait(1);
	common_scripts\_exploder::exploder(7017);
	level waittill("stair_lights");
	foreach(var_14 in var_0C)
	{
		var_14 show();
	}

	common_scripts\utility::flag_wait("player_entering_hovertank");
	if(isdefined(var_1C))
	{
		var_1C setlightshadowstate("force_off");
	}
}

//Function Number: 67
stair_wait()
{
	wait(28);
	level notify("stair_lights");
}

//Function Number: 68
tank_field_nightvision()
{
	level.player lightsetforplayer("tank_nightvision");
	maps\_utility::vision_set_fog_changes("lab_tank_thermal",0);
}

//Function Number: 69
tank_board()
{
	level.player lightsetforplayer("tank_hangar");
	maps\_utility::vision_set_fog_changes("lab_tank_hangar",0);
	level.player setclutforplayer("clut_lab_tank_hangar",0.25);
	if(level.nextgen)
	{
		setsunlight(0,0,0);
	}
}

//Function Number: 70
tank_board_enter()
{
	wait(0.1);
	common_scripts\_exploder::exploder(7122);
	resetsunlight();
	level.player lightsetforplayer("tank_board");
	enable_motion_blur_rotation();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",1);
	}

	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(3,36,2,2);
	wait(2);
	common_scripts\_exploder::kill_exploder(7622);
	level waittill("tank_switch");
	level.player disablephysicaldepthoffieldscripting();
	wait(1.5);
	common_scripts\_exploder::kill_exploder(7122);
	disable_motion_blur();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",0);
	}

	level.player lightsetforplayer("enter_courtyard_2");
}

//Function Number: 71
tank_board_enter_top_lights()
{
	wait(2);
	var_00 = getent("tank_board_light","targetname");
	wait(0.05);
	var_01 = getent("tank_top_light_02","targetname");
	if(isdefined(var_01))
	{
		var_01 setlightintensity(0);
	}

	var_02 = getent("tank_top_light_03","targetname");
	if(isdefined(var_02))
	{
		var_02 setlightintensity(0);
	}

	wait(0.05);
	var_03 = getent("tank_top_light_04","targetname");
	if(isdefined(var_03))
	{
		var_03 setlightshadowstate("normal");
		var_03 setlightintensity(0);
	}

	wait(3.5);
	var_04 = getent("tank_top_light_01","targetname");
	if(isdefined(var_04))
	{
		var_04 setlightintensity(0);
	}
}

//Function Number: 72
hovertank_turrent_light(param_00)
{
	param_00.spot_main = common_scripts\utility::spawn_tag_origin();
	var_01 = param_00.spot_main;
	var_01 linkto(param_00,"barrel",(80,50,0),(180,90,0),0);
	wait(1.5);
	playfxontag(common_scripts\utility::getfx("point_blue_fill_tank_gun"),var_01,"TAG_ORIGIN");
}

//Function Number: 73
hovertank_turrent_reflection(param_00)
{
	var_01 = getent("reflection_dark","targetname");
	param_00 common_scripts\utility::delaycall(0.05,::overridereflectionprobe,var_01.origin);
}

//Function Number: 74
tank_road()
{
	resetsunlight();
	level.player lightsetforplayer("tank_field");
	maps\_utility::vision_set_fog_changes("lab_tank_field",0);
	level.player setclutforplayer("clut_lab_tank",0);
}

//Function Number: 75
tank_field()
{
	resetsunlight();
	level.player lightsetforplayer("tank_field");
	maps\_utility::vision_set_fog_changes("lab_tank_field",0);
	level.player setclutforplayer("clut_lab_tank",0);
}

//Function Number: 76
tank_exit_dof_reset()
{
	setsunlight(0,0,0);
	common_scripts\_exploder::exploder(9123);
	enable_motion_blur_rotation();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",1);
	}

	var_00 = getent("tank_exit_light","targetname");
	var_01 = getent("tank_exit_light_char","targetname");
	thread exfil();
	level waittill("hovertank_show_exterior");
	if(level.nextgen)
	{
		var_00 setlightcolor((0.5,0.8,1));
		var_00 setlightintensity(300000);
		var_01 setlightcolor((0.5,0.8,1));
		var_01 setlightintensity(40000);
	}

	wait(2);
	resetsunlight();
	common_scripts\_exploder::exploder(9158);
	wait(1.25);
	common_scripts\_exploder::kill_exploder(9123);
	common_scripts\_exploder::exploder(9157);
	wait(5);
	common_scripts\_exploder::kill_exploder(9158);
	wait(7);
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",0);
	}

	disable_motion_blur();
	if(level.nextgen)
	{
		var_00 setlightintensity(0);
		var_01 setlightintensity(0);
	}
}

//Function Number: 77
tank_field_lft_frk()
{
	level.player lightsetforplayer("tank_field_lft_frk");
	maps\_utility::vision_set_fog_changes("lab_tank_field_lft_frk",0);
	level.player setclutforplayer("clut_lab_tank",0);
}

//Function Number: 78
tank_field_rgt_frk()
{
	level.player lightsetforplayer("tank_field_rgt_frk");
	maps\_utility::vision_set_fog_changes("lab_tank_field_rgt_frk",0);
	level.player setclutforplayer("clut_lab_tank",0);
}

//Function Number: 79
tank_ascent()
{
	level.player lightsetforplayer("tank_ascent");
	maps\_utility::vision_set_fog_changes("lab_tank_ascent",0);
	level.player setclutforplayer("clut_lab_tank",0);
}

//Function Number: 80
exfil()
{
	level.player lightsetforplayer("exfil");
	common_scripts\_exploder::exploder(9157);
	maps\_utility::vision_set_fog_changes("lab_tank_exfil",0);
	level.player setclutforplayer("clut_lab_tank",0);
}

//Function Number: 81
sun_light_reset()
{
	level.defaultsunlight = getmapsunlight();
}

//Function Number: 82
outer_space_lighting()
{
	var_00 = getent("amb_test","targetname");
	enableouterspacemodellighting(var_00.origin,(0.2,0.25,0.35));
}

//Function Number: 83
red_light_strobe_courtyard()
{
	level waittill("courtyard_red_strobe");
	common_scripts\_exploder::exploder(6125);
	var_00 = getentarray("siren_light_model","targetname");
	var_01 = getentarray("siren_light","targetname");
	foreach(var_03 in var_01)
	{
		var_03 setlightintensity(300000);
		var_03 setlightcolor((1,0,0));
	}

	for(;;)
	{
		foreach(var_06 in var_00)
		{
			var_06 rotateby((360,0,0),1);
		}

		foreach(var_03 in var_01)
		{
			var_03 rotateby((360,0,0),1);
		}

		wait(1);
	}
}

//Function Number: 84
exfil_dof()
{
	enable_motion_blur_rotation();
	level.player enablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",1);
	}

	level.player setphysicaldepthoffield(4,40);
	wait(12);
	level.player setphysicaldepthoffield(4,20);
	common_scripts\utility::flag_wait("flag_burke_destroy_tank");
	wait(2);
	level.player setphysicaldepthoffield(2,1100);
	wait(3.7);
	level.player setphysicaldepthoffield(1.5,40);
	wait(4);
	level.player setphysicaldepthoffield(1.5,20);
}

//Function Number: 85
razorback_lighting(param_00)
{
	param_00 vehicle_scripts\_razorback_fx::vfx_red_lights_on();
	level waittill("thruster_front_off");
	if(level.nextgen)
	{
		setsaveddvar("r_subdiv","1");
	}

	param_00.point_inside = common_scripts\utility::spawn_tag_origin();
	var_01 = param_00.point_inside;
	var_01 linkto(param_00,"TAG_LIGHT_INTERIOR_POINT",(-20,0,0),(30,-125,0),0);
	playfxontag(common_scripts\utility::getfx("spot_red_heli_in"),var_01,"tag_origin");
	param_00.spot_main = common_scripts\utility::spawn_tag_origin();
	var_02 = param_00.spot_main;
	var_02 linkto(param_00,"TAG_LIGHT_INTERIOR_SPOT",(0,0,0),(0,0,0),0);
	param_00.spot_tag4 = common_scripts\utility::spawn_tag_origin();
	var_03 = param_00.spot_tag4;
	var_03 linkto(param_00,"TAG_LIGHT_INTERIOR_SPOT",(40,-20,0),(10,110,0),0);
	param_00.spot_tag3 = common_scripts\utility::spawn_tag_origin();
	var_04 = param_00.spot_tag3;
	var_04 linkto(param_00,"TAG_LIGHT_INTERIOR_SPOT",(30,0,0),(0,45,0),0);
	param_00.spot_tag = common_scripts\utility::spawn_tag_origin();
	var_05 = param_00.spot_tag;
	var_05 linkto(param_00,"TAG_LIGHT_INTERIOR_POINT",(0,80,0),(0,90,0),0);
	playfxontag(common_scripts\utility::getfx("spot_red_heli_in_lrg"),var_05,"tag_origin");
	param_00.spot_tag2 = common_scripts\utility::spawn_tag_origin();
	var_06 = param_00.spot_tag2;
	var_06 linkto(param_00,"TAG_LIGHT_INTERIOR_SPOT",(70,30,0),(180,0,0),0);
	param_00.point_tag = common_scripts\utility::spawn_tag_origin();
	var_07 = param_00.point_tag;
	var_07 linkto(param_00,"TAG_LIGHT_INTERIOR_POINT",(-20,20,0),(0,0,0),0);
	param_00.point_tag2 = common_scripts\utility::spawn_tag_origin();
	var_08 = param_00.point_tag2;
	var_08 linkto(param_00,"TAG_LIGHT_INTERIOR_POINT",(-55,-15,-40),(90,0,0),0);
	common_scripts\utility::flag_wait("flag_exfil_dialogue");
	killfxontag(common_scripts\utility::getfx("spot_red_heli_in_lrg"),var_05,"tag_origin");
	common_scripts\_exploder::kill_exploder(9157);
	if(isdefined(param_00.spot_tag))
	{
		param_00.spot_tag delete();
	}

	if(isdefined(param_00.spot_main))
	{
		param_00.spot_main delete();
	}

	wait(4.5);
	playfxontag(common_scripts\utility::getfx("point_blue_heli"),var_03,"tag_origin");
	wait(5);
	common_scripts\utility::flag_wait("flag_burke_destroy_tank");
	wait(5.5);
	level.player lightsetforplayer("exfil_pre_explosion");
	wait(0.15);
	earthquake(0.25,1,level.player.origin,1600);
	level.player playrumbleonentity("heavy_2s");
	param_00.spot_tag4 = common_scripts\utility::spawn_tag_origin();
	var_03 = param_00.spot_tag4;
	var_03 linkto(param_00,"TAG_LIGHT_INTERIOR_SPOT",(0,0,50),(30,0,0),0);
	thread maps\_utility::vision_set_fog_changes("lab_building_power",0.2);
	level.player lightsetforplayer("exfil_explosion");
	wait(0.5);
	thread maps\_utility::vision_set_fog_changes("lab_tank_exfil",0.5);
	level.player lightsetforplayer("exfil");
	wait(1);
	if(isdefined(param_00.spot_tag2))
	{
		param_00.spot_tag2 delete();
	}
}

//Function Number: 86
burke_exfil_lighting()
{
}

//Function Number: 87
tank_turrent_reflection(param_00,param_01)
{
	var_02 = getent("reflection_orange","targetname");
	param_00 overridereflectionprobe(var_02.origin);
	foreach(var_04 in param_01)
	{
		var_04 overridereflectionprobe(var_02.origin);
	}
}

//Function Number: 88
turn_off_top_tank_lights()
{
	earthquake(0.2,1,level.player.origin,1600);
	level.player playrumbleonentity("heavy_2s");
	var_00 = ["tank_top_light_01","tank_top_light_02","tank_top_light_03"];
	foreach(var_02 in var_00)
	{
		foreach(var_04 in getentarray(var_02,"targetname"))
		{
			var_04 setlightintensity(300000);
		}
	}

	var_07 = getent("tank_top_light_04","targetname");
	if(isdefined(var_07))
	{
		var_07 setlightintensity(50000);
	}

	if(level.nextgen)
	{
		maps\_lighting::play_flickerlight_preset("blue_fire","blue_flicker",500000);
	}

	level waittill("msg_vfx_htank_thrust_regular");
	wait(0.5);
	earthquake(0.25,1,level.player.origin,1600);
	level.player playrumbleonentity("heavy_2s");
}

//Function Number: 89
enable_motion_blur_rotation()
{
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
	}
}

//Function Number: 90
disable_motion_blur()
{
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_mbCameraRotationInfluence","0");
	}
}

//Function Number: 91
enable_physical_dof_hip()
{
	setsaveddvar("r_dof_physical_hipEnable",1);
	setsaveddvar("r_dof_physical_hipFstop",1.5);
	setsaveddvar("r_dof_physical_hipSharpCocDiameter",0.03);
}