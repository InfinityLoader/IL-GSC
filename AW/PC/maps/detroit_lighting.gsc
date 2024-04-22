/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: detroit_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 120
 * Decompile Time: 1875 ms
 * Timestamp: 4/22/2024 2:28:04 AM
*******************************************************************/

//Function Number: 1
main2()
{
	waittillframeend;
	thread set_level_lighting_values();
	thread setup_dof_presets();
	thread setup_dof_viewmodel_presets();
	thread sunflare();
	thread setup_flickerlight_presets();
	thread lightning_call_single("detroit_lightning_max",0.3,0.7,1675);
	thread toggle_lighting_spot01_on();
	thread manage_staircase_lights();
	thread toogle_burke_fall_light();
	thread gate_lights_off();
	thread train_spotlight_lerp();
	thread setup_player_fall_fog();
	thread hospital_flicker_lights();
	thread show_hidden_rail();
	thread outerspacelighting();
	thread setup_vfx_sunflare();
	thread main_camp_spot();
	thread gate_pulse_on();
	thread exo_flicker_lighting();
	thread clut_manage();
	thread clut_manage_school();
	thread butress_origin_fix();
	thread det_vignette();
	if(level.currentgen)
	{
		common_scripts\utility::flag_init("school_spotlight_off");
		thread cg_car_light_shadowstate_on();
		thread cg_car_light_shadowstate_reset();
	}

	precacheshader("ac130_overlay_pip_bottom_vignette");
	precachemodel("com_flashlight_on_physics");
	precacherumble("heavy_1s");
	precacherumble("heavy_2s");
	precacherumble("heavy_3s");
	precacherumble("light_1s");
	precacherumble("light_2s");
	precacherumble("light_3s");
}

//Function Number: 2
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
		if(level.nextgen)
		{
			setsaveddvar("r_dynamicOpl",1);
			setsaveddvar("r_gunSightColorEntityScale",0.3);
			setsaveddvar("r_gunSightColorNoneScale",0.3);
		}
	}
}

//Function Number: 3
setup_dof_presets()
{
	maps\_lighting::create_dof_preset("fall",10,18,10,25,150,4,0.5);
	maps\_lighting::create_dof_preset("detroit_grab",1,2,4,50,150,2.7,0.5);
	maps\_lighting::create_dof_preset("schoolextdof",10,60,6,100,5000,2.3,0.5);
	maps\_lighting::create_dof_preset("huddle",10,18,5,100,200,3,0.5);
	maps\_lighting::create_dof_preset("breach",1,2,5,40,120,3,0.5);
	maps\_lighting::create_dof_preset("breach_back",1,2,5,90,220,3,0.5);
	maps\_lighting::create_dof_preset("introdof",10,18,10,30,100,2.5,0.5);
	maps\_lighting::create_dof_preset("capture",10,40,4,30,300,2.5,0.5);
	maps\_lighting::create_dof_preset("camp",5,35,5,1000,7000,0.5,0.5);
	maps\_lighting::create_dof_preset("detroit_med_blur",1,2,6,30,40,2,0.5);
}

//Function Number: 4
setup_dof_viewmodel_presets()
{
	maps\_lighting::create_dof_viewmodel_preset("bike_vm_dof",10,90);
}

//Function Number: 5
setup_flickerlight_presets()
{
	maps\_lighting::create_flickerlight_preset("fire2",(0.972549,0.62451,1),(0.2,0.1462746,1),0.005,0.2,80000);
	maps\_lighting::create_flickerlight_preset("hallway",(1,1,1),(0,0,0),0.005,0.2,80000);
	maps\_lighting::create_flickerlight_preset("hallway2",(1,1,1),(0,0,0),0.005,0.2,80000);
	maps\_lighting::create_flickerlight_preset("hallway3",(1,1,1),(0,0,0),0.005,0.2,80000);
	maps\_lighting::create_flickerlight_preset("red_pulse",(1,0,0),(0.3,0,0),0.2,1,80000);
}

//Function Number: 6
sunflare()
{
	maps\_art::sunflare_changes("default",0);
}

//Function Number: 7
play_flickering_light_school_01()
{
	level endon("console_guy_spawn");
	for(;;)
	{
		thread maps\_lighting::model_flicker_preset("model_flicker_01",0,5000,5000,undefined,1660,0.2,1.5,0.05,0.2,"endlight");
		common_scripts\utility::flag_wait("exploder1660");
		level notify("endlight");
		common_scripts\utility::flag_waitopen("exploder1660");
	}
}

//Function Number: 8
manage_staircase_lights()
{
	common_scripts\utility::flag_init("staircase_lights");
	for(;;)
	{
		common_scripts\utility::flag_wait("staircase_lights");
		common_scripts\_exploder::exploder(5193);
		if(level.nextgen)
		{
			var_00 = 100;
			var_01 = 100;
		}
		else
		{
			var_00 = 70;
			var_01 = 70;
		}

		var_02 = 0.005;
		var_03 = 0.4;
		var_04 = 0.005;
		var_05 = 0.4;
		var_06["on"] = "school_flickering_light_on";
		var_06["off"] = "school_flickering_light_off";
		var_06["loop"] = "school_flickering_light_lp";
		var_06["vol_env"] = [[var_00,0.25],[var_01,1]];
		thread maps\_lighting::model_flicker_preset("model_flicker_02",0,var_00,var_01,1661,undefined,var_02,var_03,var_04,var_05,"flickering_light_02_off",var_06,500);
		common_scripts\utility::flag_waitopen("staircase_lights");
	}
}

//Function Number: 9
play_flickering_light_school_03()
{
	thread maps\_lighting::model_flicker_preset("model_flicker_03",0,500,500,undefined,undefined,0.2,0.5,0.05,1);
}

//Function Number: 10
hallway_light_scare()
{
	var_00 = getent("light_scare_flicker","targetname");
	var_01 = getent("light_scare_flicker_bounce","targetname");
	if(level.nextgen)
	{
		maps\_lighting::play_flickerlight_preset("white_fire","light_scare_flicker",160);
		maps\_lighting::play_flickerlight_preset("white_fire_dim","light_scare_flicker_bounce",1.5);
	}
	else
	{
		maps\_lighting::play_flickerlight_preset("white_fire","light_scare_flicker",2000);
	}

	common_scripts\_exploder::exploder(5145);
	maps\_utility::trigger_wait_targetname("tile_fall");
	maps\_lighting::stop_flickerlight("white_fire","light_scare_flicker",0);
	maps\_lighting::stop_flickerlight("white_fire","light_scare_flicker_bounce",0);
	wait(0.05);
	wait(0.05);
	if(isdefined(var_00))
	{
		var_00 setlightintensity(4000000);
	}

	var_01 setlightintensity(500000);
	common_scripts\_exploder::exploder(2321);
	wait(0.1);
	if(isdefined(var_00))
	{
		var_00 setlightintensity(0);
	}

	if(isdefined(var_01))
	{
		var_01 setlightintensity(0);
	}

	wait(0.15);
	common_scripts\_exploder::kill_exploder(2321);
	common_scripts\_exploder::kill_exploder(5145);
}

//Function Number: 11
burke_walk_lighting()
{
	var_00 = getent("burke_walk_light","targetname");
	if(isdefined(var_00))
	{
		var_00 setlightintensity(0);
	}
}

//Function Number: 12
player_fall_lighting()
{
	common_scripts\_exploder::kill_exploder(5193);
	level notify("flashlight_off");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbVelocityScalar","1");
	}

	wait(4);
	common_scripts\_exploder::exploder(1669);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
	}

	setblur(10,0.5);
	wait(0.5);
	setblur(0,1);
	wait(10);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
	}

	wait(2);
	common_scripts\_exploder::exploder(1670);
	maps\_utility::set_blur(2,0.3);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
	}

	maps\_utility::set_blur(8,0.2);
	maps\_utility::set_blur(0,2);
	common_scripts\utility::flag_wait("flag_start_kva_2_basement");
	common_scripts\_exploder::kill_exploder(1669);
}

//Function Number: 13
toogle_burke_fall_light()
{
	if(level.nextgen)
	{
		var_00 = getent("burke_fall_light","targetname");
		var_01 = getent("burke_fall_light2","targetname");
		var_02 = getent("player_fall_light","targetname");
		var_03 = getent("burke_fall_light3","targetname");
		common_scripts\utility::flag_wait("school_player_falling");
		var_04 = getent("burke_fx_footdrop","targetname");
		level.burke overridelightingorigin(var_04.origin);
		wait(1);
		maps\_utility::vision_set_fog_changes("detroit_school_walk_nofog",0.5);
		if(isdefined(var_00))
		{
			var_00 setlightintensity(50);
		}

		var_00 setlightcolor((0.2,0.4,0.8));
		if(isdefined(var_01))
		{
			var_01 setlightintensity(80);
		}

		var_01 setlightcolor((0.2,0.4,0.8));
		if(isdefined(var_03))
		{
			var_03 setlightintensity(5);
		}

		var_03 setlightcolor((0.2,0.4,0.8));
		wait(3.1);
		if(isdefined(var_02))
		{
			var_02 setlightintensity(700);
		}

		var_02 setlightcolor((0.2,0.4,0.8));
		wait(10);
		level.burke defaultlightingorigin();
	}
}

//Function Number: 14
setup_player_fall_fog()
{
	maps\_shg_design_tools::waittill_trigger_with_name("player_fall_fog");
	common_scripts\_exploder::exploder(5571);
	maps\_shg_design_tools::waittill_trigger_with_name("lightning_single");
	common_scripts\_exploder::kill_exploder(5571);
}

//Function Number: 15
toggle_school_exterior_light_on()
{
	wait(0.05);
	var_00 = getentarray("toggle_school_exterior_light","targetname");
	foreach(var_02 in var_00)
	{
		if(level.nextgen)
		{
			var_02 setlightintensity(5000);
			continue;
		}

		var_02 setlightintensity(10000);
	}

	common_scripts\_exploder::exploder(2663);
	common_scripts\utility::flag_wait("hide_and_seek");
	common_scripts\_exploder::kill_exploder(2663);
}

//Function Number: 16
toggle_school_exterior_light_off()
{
	common_scripts\utility::flag_wait("school_spotlight_off");
	var_00 = getent("toggle_school_exterior_light","targetname");
	if(isdefined(var_00))
	{
		var_00 setlightintensity(0.01);
		return;
	}
}

//Function Number: 17
intro_lighting()
{
	common_scripts\utility::flag_wait("level_intro_cinematic_complete_real");
	wait(0.05);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbVelocityScalar","1.25");
	}

	if(level.nextgen)
	{
		setsaveddvar("r_lightgridenabletweaks",1);
		maps\_utility::lerp_saveddvar("r_lightgridintensity",0.2,0.1);
	}

	wait(5.5);
	wait(1);
	if(level.nextgen)
	{
		thread intro_lerp_sun();
	}

	wait(2.3);
	level.player lightsetforplayer("detroit_intro_2");
	if(level.nextgen)
	{
		wait(13.5);
		level.player lightsetforplayer("detroit_intro_1");
		wait(3);
		setsaveddvar("r_mbEnable","0");
		maps\_utility::lerp_saveddvar("r_lightgridintensity",1,2);
		level.player setclutforplayer("clut_detroit_camp",20);
		return;
	}

	wait(11);
	level.player lightsetforplayer("detroit_intro_1");
	wait(3);
	level.player lightsetforplayer("detroit_camp");
}

//Function Number: 18
intro_dof_physically_based()
{
	common_scripts\utility::flag_wait("level_intro_cinematic_complete_real");
	level.player setphysicalviewmodeldepthoffield(9,25);
	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(4,35);
	wait(17);
	level.player setphysicaldepthoffield(4,25);
	if(level.nextgen)
	{
		wait(4.5);
		level.player setphysicaldepthoffield(4.5,16);
		wait(1.5);
		level.player setphysicaldepthoffield(9,80);
	}
	else
	{
		wait(4.5);
		level.player setphysicaldepthoffield(2.375,18.5);
		wait(1.5);
		level.player setphysicaldepthoffield(9,80,2.5,3.5);
	}

	wait(3);
	common_scripts\utility::flag_set("flag_autofocus_on");
	if(level.currentgen)
	{
		common_scripts\utility::flag_init("bike_mount_dof_cg");
	}

	thread autofocus_hipenable();
}

//Function Number: 19
autofocus_hipenable()
{
	common_scripts\utility::flag_wait("flag_autofocus_on");
	if(level.nextgen)
	{
	}

	level.player disablephysicaldepthoffieldscripting();
	setsaveddvar("r_dof_physical_hipEnable",1);
	setsaveddvar("r_dof_physical_hipFstop",3.5);
	setsaveddvar("r_dof_physical_hipSharpCocDiameter",0.03);
	common_scripts\utility::flag_waitopen("flag_autofocus_on");
	setsaveddvar("r_dof_physical_hipEnable",0);
	thread mount_bike_dof();
}

//Function Number: 20
mount_bike_dof()
{
	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(1.5,40,30,30);
	wait(2.5);
	level.player setphysicaldepthoffield(1.5,77,30,30);
	wait(2.8);
	level.player setphysicaldepthoffield(1.5,20,30,30);
	wait(3);
	level.player setphysicaldepthoffield(5,200,30,30);
	wait(2);
	level.player disablephysicaldepthoffieldscripting();
	wait(3);
	level.player setclutforplayer("clut_detroit_exterior_drive_1",3);
}

//Function Number: 21
autofocus_hipenable_bike()
{
	setsaveddvar("r_dof_physical_hipEnable",1);
	setsaveddvar("r_dof_physical_hipSharpCocDiameter",0.03);
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_hipFstop",3.5);
		return;
	}

	setsaveddvar("r_dof_physical_hipFstop",5.5);
}

//Function Number: 22
bike_mount_dof()
{
	common_scripts\utility::flag_clear("flag_autofocus_on");
	if(level.nextgen)
	{
		var_00 = level.burke;
		if(isdefined(var_00.helmet_tag))
		{
			var_00.helmet_tag delete();
		}

		var_00.helmet_tag = common_scripts\utility::spawn_tag_origin();
		var_01 = var_00.helmet_tag;
		var_01 linkto(var_00,"J_Head",(3,10,0),(0,0,0),0);
		playfxontag(common_scripts\utility::getfx("intro_point_rim"),var_01,"tag_origin");
		wait(1);
		wait(5);
		wait(2);
		wait(2);
		if(level.nextgen)
		{
			setsaveddvar("r_mbEnable","2");
			setsaveddvar("r_mbVelocityScalar","1");
		}

		var_02 = getentarray("gate_top_lights1","targetname");
		foreach(var_04 in var_02)
		{
			var_04 setlightintensity(0);
		}

		stopfxontag(common_scripts\utility::getfx("intro_point_rim"),var_01,"tag_origin");
		if(isdefined(var_00.helmet_tag))
		{
			var_00.helmet_tag delete();
		}

		wait(4);
		level.player setclutforplayer("clut_detroit_exterior_drive_1",2);
		wait(14);
		level.player setclutforplayer("",2);
		return;
	}

	common_scripts\utility::flag_set("bike_mount_dof_cg");
}

//Function Number: 23
jetbike_dismount_red_light()
{
	level.player setclutforplayer("clut_detroit_exterior",3);
	if(level.currentgen)
	{
		if(common_scripts\utility::flag_exist("bike_mount_dof_cg"))
		{
			common_scripts\utility::flag_clear("bike_mount_dof_cg");
		}
	}

	thread school_jeep_light_tgl();
	common_scripts\_exploder::exploder(9405);
	wait(4);
	wait(7);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
	}

	wait(0.05);
}

//Function Number: 24
hospital_breach_dof()
{
	if(level.nextgen)
	{
		maps\_utility::vision_set_fog_changes("detroit_hospital_capture1",2);
	}
	else
	{
		maps\_utility::vision_set_fog_changes("detroit_hospital_capture",2);
	}

	level.player disablephysicaldepthoffieldscripting();
	wait(0.5);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbVelocityScalar","1.5");
	}
}

//Function Number: 25
intro_helipad_lights()
{
	var_00 = getentarray("det_helipad_light_on","targetname");
	var_01 = getentarray("det_helipad_light_off","targetname");
	foreach(var_03 in var_00)
	{
		var_03 hide();
	}

	wait(6);
	thread maps\detroit_fx::cg_helipad_red_fx_lights();
	for(var_05 = 0;var_05 < 6;var_05++)
	{
		wait(0.75);
		foreach(var_07 in var_01)
		{
			var_07 hide();
		}

		foreach(var_03 in var_00)
		{
			var_03 show();
		}

		common_scripts\_exploder::exploder(1112);
		wait(0.75);
		foreach(var_03 in var_00)
		{
			var_03 hide();
		}

		common_scripts\_exploder::kill_exploder(1112);
		foreach(var_07 in var_01)
		{
			var_07 show();
		}
	}
}

//Function Number: 26
gate_lights_on()
{
	var_00 = getent("door_right_rigged","targetname");
	var_01 = common_scripts\utility::getstruct("door_right_rigged_origin","targetname");
	var_00 overridelightingorigin(var_01.origin);
	common_scripts\_exploder::exploder(1124);
	wait(2);
	level.player lightsetforplayer("jetbike_gate");
	var_02 = getent("door_lights_script2","targetname");
	if(isdefined(var_02))
	{
		var_02 setlightintensity(1118200);
	}

	wait(0.05);
	var_03 = getent("door_lights_script1","targetname");
	if(isdefined(var_02))
	{
		var_03 setlightintensity(422000);
	}

	wait(0.05);
	wait(0.05);
}

//Function Number: 27
gate_lights_off()
{
	var_00 = getentarray("gate_light_models","targetname");
	var_01 = getentarray("gate_light_models_off","targetname");
	foreach(var_03 in var_00)
	{
		var_03 show();
	}

	foreach(var_06 in var_01)
	{
		var_06 hide();
	}
}

//Function Number: 28
gate_lights_off_toggle_on(param_00)
{
	maps\_utility::stop_exploder(1124);
	common_scripts\utility::flag_set("gate_pulse_light");
	wait(0.05);
	thread gate_fx();
	wait(1);
	wait(0.05);
	wait(0.05);
	wait(0.05);
	level.player lightsetforplayer("detroit_intro_dark");
	wait(11);
	common_scripts\utility::flag_set("open_massive_door");
	common_scripts\utility::flag_set("vo_drive_in");
	level.player setclutforplayer("clut_detroit_exterior_drive_2",3);
}

//Function Number: 29
gate_pulse_on()
{
	var_00 = getentarray("siren_white_on","targetname");
	var_01 = getentarray("siren_white_off","targetname");
	foreach(var_03 in var_00)
	{
		var_03 hide();
	}

	common_scripts\utility::flag_wait("gate_pulse_light");
	common_scripts\_exploder::exploder(1125);
	for(var_05 = 0;var_05 < 12;var_05++)
	{
		foreach(var_03 in var_00)
		{
			var_03 show();
		}

		foreach(var_09 in var_01)
		{
			var_09 hide();
		}

		wait(0.15);
		foreach(var_03 in var_00)
		{
			var_03 hide();
		}

		foreach(var_09 in var_01)
		{
			var_09 show();
		}

		wait(0.85);
	}

	if(level.nextgen)
	{
		setsaveddvar("r_mbVelocityScalar","1.5");
	}

	maps\_utility::stop_exploder(1125);
}

//Function Number: 30
gate_model_spin()
{
	var_00 = getentarray("siren_orange_model","targetname");
	var_01 = getentarray("siren_light","targetname");
	var_02 = 0;
	foreach(var_04 in var_01)
	{
		var_04 setlightintensity(3000000);
		var_04 setlightcolor((1,1,1));
	}

	while(var_02 < 15)
	{
		foreach(var_07 in var_00)
		{
			var_07 rotateby((360,0,0),1);
		}

		foreach(var_04 in var_01)
		{
			var_04 rotateby((360,0,0),1);
		}

		wait(1);
		var_02++;
	}
}

//Function Number: 31
gate_earthquake()
{
	earthquake(0.1,7,level.player.origin,1600);
	wait(4);
	earthquake(0.4,1,level.player.origin,1600);
}

//Function Number: 32
gate_fx()
{
	thread gate_rumble();
	wait(3);
}

//Function Number: 33
turn_on_helmet_light_bright()
{
	wait(7);
	var_00 = level.player;
	if(isdefined(var_00.helmet_tag))
	{
		var_00.helmet_tag delete();
	}

	if(isdefined(var_00.flashlight_tag))
	{
		var_00.flashlight_tag delete();
	}

	var_00.helmet_tag = common_scripts\utility::spawn_tag_origin();
	var_01 = var_00.helmet_tag;
	var_01 linktoplayerview(var_00,"tag_origin",(0,0,2),(0,0,0),0);
	playfxontag(common_scripts\utility::getfx("player_light_bright"),var_01,"tag_origin");
}

//Function Number: 34
turn_off_light_bright()
{
	var_00 = level.player;
	if(isdefined(var_00.helmet_tag))
	{
		var_00.helmet_tag delete();
	}

	if(isdefined(var_00.flashlight_tag))
	{
		var_00.flashlight_tag delete();
	}
}

//Function Number: 35
turn_on_helmet_light()
{
	var_00 = level.player;
	if(isdefined(var_00.helmet_tag))
	{
		var_00.helmet_tag delete();
	}

	if(isdefined(var_00.flashlight_tag))
	{
		var_00.flashlight_tag delete();
	}

	var_00.helmet_tag = common_scripts\utility::spawn_tag_origin();
	var_01 = var_00.helmet_tag;
	var_01 linktoplayerview(var_00,"tag_origin",(0,0,2),(0,0,0),0);
	playfxontag(common_scripts\utility::getfx("player_light"),var_01,"tag_origin");
}

//Function Number: 36
turn_off_light()
{
	var_00 = level.player;
	if(isdefined(var_00.helmet_tag))
	{
		var_00.helmet_tag delete();
	}

	if(isdefined(var_00.flashlight_tag))
	{
		var_00.flashlight_tag delete();
	}
}

//Function Number: 37
turn_on_weapon_light()
{
	var_00 = level.player;
	if(isdefined(var_00.helmet_tag))
	{
		var_00.helmet_tag delete();
	}

	if(isdefined(var_00.flashlight_tag))
	{
		var_00.flashlight_tag delete();
	}

	var_00.flashlight_tag = common_scripts\utility::spawn_tag_origin();
	var_01 = var_00.flashlight_tag;
	var_01 linktoplayerview(var_00,"tag_flash",(0,0,-2),(0,0,0),0);
	playfxontag(common_scripts\utility::getfx("player_light2"),var_01,"tag_origin");
}

//Function Number: 38
turn_on_cheap_flashlight()
{
	self endon("death");
	var_00 = ["flashlight_enemy"];
	self.flashfx = var_00[randomint(var_00.size)];
	playfxontag(common_scripts\utility::getfx(self.flashfx),self,"tag_flash");
}

//Function Number: 39
train_bridge_light_on()
{
	var_00 = getent("train_bridge_light","targetname");
	if(isdefined(var_00))
	{
		var_00 setlightintensity(100000000);
	}
}

//Function Number: 40
lightning_call(param_00,param_01,param_02)
{
	common_scripts\utility::flag_init("lightning_on");
	wait(0.05);
	common_scripts\utility::flag_set("lightning_on");
}

//Function Number: 41
lightning_call_single(param_00,param_01,param_02,param_03)
{
	for(;;)
	{
		maps\_shg_design_tools::waittill_trigger_with_name("lightning_single");
		thread toggle_lighting_spot01_lightning();
		level.player playrumbleonentity("heavy_1s");
		var_04 = getdvar("vision_set_current");
		var_05 = getmapsundirection();
		setsundirection(var_05);
		level.lite_settings = vectortoangles(var_05);
		level.new_lite_settings = level.lite_settings;
		var_06 = (randomfloatrange(20,30) * -1,randomfloatrange(20,25),0);
		var_07 = (-59.4,105.5,0);
		var_08 = level.new_lite_settings + var_06;
		var_09 = anglestoforward(var_08);
		setsundirection(var_09);
		setsunlight(0.05,0.05,0.05);
		wait(0.05);
		setblur(0.5,param_01);
		if(isdefined(param_03))
		{
			common_scripts\_exploder::exploder(param_03);
		}

		wait(randomfloatrange(0.1,0.4));
		resetsunlight();
		resetsundirection();
		setblur(0,param_02);
		wait(40);
	}
}

//Function Number: 42
lightning_call_gate(param_00,param_01,param_02,param_03)
{
	var_04 = getdvar("vision_set_current");
	var_05 = getmapsundirection();
	setsundirection(var_05);
	level.lite_settings = vectortoangles(var_05);
	level.new_lite_settings = level.lite_settings;
	var_06 = (randomfloatrange(20,30) * -1,randomfloatrange(20,25),0);
	var_07 = (-59.4,105.5,0);
	var_08 = level.new_lite_settings + var_06;
	var_09 = anglestoforward(var_08);
	setsundirection(var_09);
	setsunlight(0.05,0.05,0.05);
	wait(0.05);
	setblur(0.3,param_01);
	if(isdefined(param_03))
	{
		common_scripts\_exploder::exploder(param_03);
	}

	wait(randomfloatrange(0.2,0.5));
	if(isdefined(param_03))
	{
		maps\_utility::stop_exploder(param_03);
	}

	resetsunlight();
	resetsundirection();
	setblur(0,param_02);
	wait(40);
}

//Function Number: 43
lightning_call_traversal(param_00,param_01,param_02,param_03)
{
	for(;;)
	{
		wait(1);
		while(common_scripts\utility::flag("start_exit_trains") == 1)
		{
			var_04 = getdvar("vision_set_current");
			var_05 = getmapsundirection();
			setsundirection(var_05);
			level.lite_settings = vectortoangles(var_05);
			level.new_lite_settings = level.lite_settings;
			var_06 = (randomfloatrange(20,30) * -1,randomfloatrange(20,25),0);
			var_07 = (-59.4,105.5,0);
			var_08 = level.new_lite_settings + var_06;
			var_09 = anglestoforward(var_08);
			setsundirection(var_09);
			setsunlight(0.05,0.05,0.05);
			setblur(0.1,param_01);
			if(isdefined(param_03))
			{
				common_scripts\_exploder::exploder(param_03);
			}

			wait(randomfloatrange(0.2,0.5));
			if(isdefined(param_03))
			{
				maps\_utility::stop_exploder(param_03);
			}

			resetsunlight();
			resetsundirection();
			setblur(0,param_02);
			wait(8);
		}
	}
}

//Function Number: 44
toggle_lighting_spot01_on()
{
	if(level.nextgen)
	{
		var_00 = getent("lightning_spot_01","targetname");
		var_01 = getent("lightning_spot_02","targetname");
		common_scripts\utility::flag_wait("flag_player_shimmy_start");
		if(isdefined(var_00))
		{
			var_00 setlightintensity(2000);
		}

		var_00 setlightcolor((0.8,0.9,1));
		var_01 setlightintensity(800);
		var_01 setlightcolor((0.8,0.9,1));
		return;
	}

	common_scripts\utility::flag_wait("flag_player_shimmy_start");
	var_00 = getent("lightning_spot_01","targetname");
	if(isdefined(var_00))
	{
		var_00 setlightintensity(1);
		var_00 setlightcolor((0.8,0.9,1));
	}
}

//Function Number: 45
toggle_lighting_spot01_on_checkpoint()
{
	if(level.nextgen)
	{
		var_00 = getent("lightning_spot_01","targetname");
		var_01 = getent("lightning_spot_02","targetname");
		if(isdefined(var_00))
		{
			var_00 setlightintensity(2000);
		}

		var_00 setlightcolor((0.5,0.7,1));
		var_01 setlightintensity(800);
		var_01 setlightcolor((0.5,0.7,1));
		return;
	}

	var_00 = getent("lightning_spot_01","targetname");
	if(isdefined(var_00))
	{
		var_00 setlightintensity(1);
		var_00 setlightcolor((0.5,0.7,1));
	}
}

//Function Number: 46
basement_fog_checkpoint()
{
	common_scripts\_exploder::exploder(5571);
	maps\_shg_design_tools::waittill_trigger_with_name("lightning_single");
	common_scripts\_exploder::kill_exploder(5571);
}

//Function Number: 47
toggle_lighting_spot01_lightning()
{
	var_00 = getent("lightning_spot_01","targetname");
	var_01 = common_scripts\utility::getstruct("old_origin","targetname");
	var_02 = common_scripts\utility::getstruct("new_origin","targetname");
	if(isdefined(var_00))
	{
		var_00 setlightintensity(randomfloatrange(10055,50050));
		var_00.origin = var_02.origin;
		var_00 soundscripts\_snd::snd_message("lightning_strike");
		wait(1);
		if(level.nextgen)
		{
			var_00 setlightintensity(1000);
		}
		else
		{
			var_00 setlightintensity(1);
		}

		var_00.origin = var_01.origin;
	}
}

//Function Number: 48
burke_intro_lighting()
{
	common_scripts\utility::flag_wait("level_intro_cinematic_complete_real");
	wait(1);
	var_00 = level.burke;
	if(isdefined(var_00.helmet_tag))
	{
		var_00.helmet_tag delete();
	}

	if(isdefined(var_00.flashlight_tag))
	{
		var_00.flashlight_tag delete();
	}

	var_00.helmet_tag = common_scripts\utility::spawn_tag_origin();
	var_01 = var_00.helmet_tag;
	var_00.helmet_tag2 = common_scripts\utility::spawn_tag_origin();
	var_02 = var_00.helmet_tag2;
	var_01 linkto(var_00,"TAG_ORIGIN",(-9,5,65),(0,0,0),0);
	var_02 linkto(var_00,"J_Head",(0,20,0),(0,0,0),0);
	level waittill("end_burke_intro_talk");
}

//Function Number: 49
guy_outside_school(param_00)
{
	wait(7);
	param_00 add_enemy_flashlight("flashlight","bright");
	param_00 maps\_utility::notify_delay("flashlight_off",21);
	maps\_utility::stop_exploder(9405);
}

//Function Number: 50
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

//Function Number: 51
train_spotlight_lerp()
{
	var_00 = getent("lerp_light","targetname");
	var_01 = common_scripts\utility::getstruct("origin_final","targetname");
	var_02 = common_scripts\utility::getstruct("origin_start","targetname");
	var_03 = common_scripts\utility::spawn_tag_origin();
	var_03.origin = var_00.origin;
	var_03.angles = var_00.angles;
	maps\_shg_design_tools::waittill_trigger_with_name("train_scare");
	var_00 setlightshadowstate("force_on");
	soundscripts\_snd::snd_message("train_scare");
	thread train_rumble();
	earthquake(0.05,1,level.player.origin,1600);
	wait(0.5);
	earthquake(0.12,1,level.player.origin,1600);
	var_00 moveto(var_02.origin,0.15,0.05,0.05);
	wait(0.5);
	earthquake(0.2,5,level.player.origin,1600);
	var_00 setlightintensity(8000);
	thread lerp_origin_function(var_00,9,var_01.origin);
	var_03 linkto(var_00,"",(0,0,0),(0,0,0));
	wait(1);
	earthquake(0.12,4,level.player.origin,1600);
	wait(2);
	earthquake(0.05,4,level.player.origin,1600);
	thread maps\_lighting::lerp_spot_intensity("lerp_light",2,1);
	wait(6.5);
	var_00 setlightshadowstate("force_off");
}

//Function Number: 52
train_rumble()
{
	level.player playrumbleonentity("light_2s");
	wait(0.5);
	level.player playrumbleonentity("light_2s");
	wait(0.5);
	level.player playrumbleonentity("light_2s");
	wait(0.5);
	level.player playrumbleonentity("heavy_2s");
	wait(0.5);
	level.player playrumbleonentity("heavy_2s");
	wait(0.5);
	level.player playrumbleonentity("heavy_2s");
	wait(0.5);
	level.player playrumbleonentity("light_2s");
	wait(0.5);
	level.player playrumbleonentity("light_2s");
	wait(0.5);
	level.player playrumbleonentity("light_2s");
}

//Function Number: 53
gate_rumble()
{
	level.player playrumbleonentity("light_3s");
	wait(1);
	level.player playrumbleonentity("light_3s");
	wait(1);
	level.player playrumbleonentity("light_2s");
	wait(2);
	level.player playrumbleonentity("heavy_1s");
}

//Function Number: 54
train_radiosity()
{
}

//Function Number: 55
player_school_flashlight()
{
	maps\_utility::trigger_wait_targetname("jetbike_lights_off");
	level.player add_player_flashlight();
	level waittill("player_door_open");
	level notify("all_flashlights_off");
	wait(4);
	level.burke add_burke_flashlight("flashlight",1);
	common_scripts\_exploder::kill_exploder(5622);
	common_scripts\utility::flag_wait("flag_player_shimmy_start");
	level.player notify("flashlight_off");
}

//Function Number: 56
add_player_flashlight(param_00,param_01,param_02)
{
	var_03 = level.player common_scripts\utility::spawn_tag_origin();
	var_03 linktoplayerview(level.player,"tag_flash",(0,-10,10),(0,0,0),0);
	playfxontag(common_scripts\utility::getfx("player_light_med2"),var_03,"tag_origin");
	level.player.tag_weapon = var_03;
	thread monitor_player_light_off();
}

//Function Number: 57
player_spotlight(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("flashlight_off");
	thread monitor_player_light_off();
	self.roaming_light = param_00 common_scripts\utility::spawn_tag_origin();
	target_set(self.roaming_light);
	playfxontag(common_scripts\utility::getfx("player_light_med2"),self.roaming_light,"tag_origin");
	while(isalive(self))
	{
		var_04 = param_00.origin;
		var_05 = param_00.angles;
		var_06 = anglestoforward(var_05) * 400;
		var_07 = anglestoforward(var_05) * -20;
		var_08 = bullettrace(var_04,var_04 + var_06,1,param_00,0);
		var_09 = bullettrace(var_08["position"],var_08["position"] + var_07,1,self,0);
		self.roaming_light.origin = var_09["position"];
		wait 0.05;
	}
}

//Function Number: 58
attach_light_to_face(param_00,param_01)
{
	self.facelight = common_scripts\utility::spawn_tag_origin();
	if(!isdefined(param_00) || !param_00)
	{
		if(!isdefined(param_01) || !param_01)
		{
			playfxontag(common_scripts\utility::getfx("point_amber"),self.facelight,"tag_origin");
		}
		else if(isdefined(param_01) && param_01)
		{
			playfxontag(common_scripts\utility::getfx("point_amber_dim"),self.facelight,"tag_origin");
		}
	}
	else
	{
		playfxontag(common_scripts\utility::getfx("point_blue_med"),self.facelight,"tag_origin");
	}

	var_02 = maps\_shg_design_tools::offset_position_from_tag("forward","tag_eye",20);
	self.facelight.origin = var_02;
	self.facelight linkto(self,"tag_eye");
	common_scripts\utility::waittill_any("death","facelight_off");
	if(isdefined(self) && isdefined(self.facelight))
	{
		self.facelight delete();
	}
}

//Function Number: 59
remove_light_from_face()
{
	self notify("facelight_off");
}

//Function Number: 60
add_enemy_flashlight(param_00,param_01,param_02,param_03)
{
	var_04 = cheap_flashlight_setup(param_00,param_01,param_02,param_03);
	thread fake_spotlight(var_04,param_01,param_02,0);
	self.flashlight_on = 1;
	self.flashlight_parm_type = param_00;
	self.flashlight_parm_spotlight = param_01;
	self.flashlight_parm_point_light = param_02;
	self.flashlight_parm_offset = param_03;
}

//Function Number: 61
add_basement_enemy_flashlight(param_00,param_01,param_02)
{
	var_03 = basement_enemy_flashlight_setup(param_00,param_01,param_02);
	thread fake_spotlight("tag_light",param_01,param_02,0);
}

//Function Number: 62
add_burke_flashlight(param_00,param_01,param_02)
{
	var_03 = burke_cheap_flashlight_setup(param_00,param_01,param_02);
	level.burke thread fake_spotlight(var_03,param_01,param_02,1);
}

//Function Number: 63
cheap_flashlight_setup(param_00,param_01,param_02,param_03)
{
	var_04 = self;
	var_05 = "tag_eye";
	if(isdefined(param_00) && param_00 == "flashlight")
	{
		var_06 = self gettagorigin("tag_inhand");
		var_07 = self gettagangles("tag_inhand");
		self.flashlight = spawn("script_model",var_06);
		self.flashlight setmodel("com_flashlight_on_physics");
		if(isdefined(param_03))
		{
			self.flashlight.angles = anglestoforward(var_07) * param_03;
		}
		else
		{
			self.flashlight.angles = var_07;
		}

		self.flashlight linkto(self,"tag_inhand");
		var_04 = self.flashlight;
		var_05 = "tag_light";
		thread flashlight_off_think();
	}

	return var_05;
}

//Function Number: 64
basement_enemy_flashlight_setup(param_00,param_01,param_02)
{
	var_03 = self;
	var_04 = "tag_weapon_left";
	if(isdefined(param_00) && param_00 == "flashlight")
	{
		var_05 = self gettagorigin("tag_inhand");
		var_06 = self gettagangles("tag_inhand");
		self.flashlight = spawn("script_model",var_05);
		self.flashlight setmodel("com_flashlight_on_physics");
		self.flashlight.angles = var_06;
		self.flashlight linkto(self,"tag_inhand");
		var_03 = self.flashlight;
		var_04 = "tag_weapon_left";
		thread flashlight_off_think();
	}

	return var_04;
}

//Function Number: 65
burke_cheap_flashlight_setup(param_00,param_01,param_02)
{
	var_03 = "tag_flash";
	return var_03;
}

//Function Number: 66
flashlight_off_think()
{
	var_00 = self.flashlight;
	var_01 = common_scripts\utility::waittill_any_return("death","damage","alert","flashlight_off");
	stopfxontag(common_scripts\utility::getfx(self.fx_type),var_00,"tag_light");
	var_00 notify("flashlight_off");
	var_00.light_tag delete();
	var_00 delete();
}

//Function Number: 67
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

//Function Number: 68
monitor_turn_light_off()
{
	common_scripts\utility::waittill_any_ents(self,"flashlight_off",self,"death",level,"all_flashlights_off");
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.light_tag))
	{
		stopfxontag(common_scripts\utility::getfx("point_amber"),self.light_tag,"tag_origin");
	}

	if(isdefined(self.fx_tag) && isdefined(self.fx_type))
	{
		stopfxontag(common_scripts\utility::getfx(self.fx_type),self,self.fx_tag);
	}
}

//Function Number: 69
fake_spotlight(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("damage");
	self endon("alert");
	level endon("all_flashlights_off");
	if(param_00 == "tag_light")
	{
		var_04 = self.flashlight;
	}
	else
	{
		var_04 = self;
	}

	var_04 endon("flashlight_off");
	var_04 thread monitor_turn_light_off();
	self.disablelongdeath = 1;
	var_04.light_tag = common_scripts\utility::spawn_tag_origin();
	var_05 = "flashlight_enemy";
	if(isdefined(param_01))
	{
		if(isstring(param_01))
		{
			if(param_01 == "bright")
			{
				var_05 = "player_light_bright";
			}

			if(param_01 == "med")
			{
				var_05 = "player_light_med";
			}

			if(param_01 == "light")
			{
				var_05 = "player_light_light";
			}
		}
		else
		{
			var_05 = "player_light";
		}

		if(isdefined(param_02) && param_02)
		{
			playfxontag(common_scripts\utility::getfx("point_amber"),var_04.light_tag,"tag_origin");
		}
	}
	else if(isdefined(param_03) && param_03)
	{
		playfxontag(common_scripts\utility::getfx("point_blue"),var_04.light_tag,"tag_origin");
	}
	else
	{
		playfxontag(common_scripts\utility::getfx("point_amber"),var_04.light_tag,"tag_origin");
	}

	playfxontag(common_scripts\utility::getfx(var_05),var_04,param_00);
	thread kill_flashlight_fx(common_scripts\utility::getfx(var_05),var_04,param_00);
	var_04.fx_tag = param_00;
	self.fx_type = var_05;
	var_04.fx_type = var_05;
	while(isalive(self))
	{
		var_06 = var_04 gettagorigin(param_00);
		var_07 = var_04 gettagangles(param_00);
		var_08 = anglestoforward(var_07) * 400;
		var_09 = anglestoforward(var_07) * -20;
		var_0A = bullettrace(var_06,var_06 + var_08,1,var_04,0);
		var_0B = bullettrace(var_0A["position"],var_0A["position"] + var_09,1,var_04,0);
		var_04.light_tag.origin = var_0B["position"];
		wait 0.05;
	}
}

//Function Number: 70
kill_flashlight_fx(param_00,param_01,param_02)
{
	level waittill("all_flashlights_off");
	if(isdefined(param_01))
	{
		killfxontag(param_00,param_01,param_02);
	}
}

//Function Number: 71
attach_pointlight_to_beam(param_00)
{
	var_01 = common_scripts\utility::spawn_tag_origin();
	playfxontag(common_scripts\utility::getfx("point_amber"),var_01,"tag_origin");
	for(;;)
	{
		var_02 = self gettagorigin(param_00);
		var_03 = self gettagangles(param_00);
		var_04 = anglestoforward(var_03) * 800;
		var_05 = anglestoforward(var_03) * -20;
		var_06 = bullettrace(var_02,var_02 + var_04,1,self,0);
		var_07 = bullettrace(var_06["position"],var_06["position"] + var_05,1,self,0);
		thread common_scripts\utility::draw_line_for_time(self.origin,var_07["position"],0,0,1,0.05);
		var_01.origin = var_07["position"];
		wait 0.05;
	}
}

//Function Number: 72
sundark_manage()
{
	for(;;)
	{
		common_scripts\utility::flag_waitopen("lightning_on");
		setsunlight(0,0,0);
		common_scripts\utility::flag_wait("lightning_on");
		resetsunlight();
	}
}

//Function Number: 73
debug_flashlight_basement_switch()
{
	self endon("death");
	for(;;)
	{
		var_00 = "";
		if(self.has_expensive_flashlight == 1)
		{
			var_00 = "expensive";
		}
		else
		{
			var_00 = "cheap";
		}

		wait(0.05);
	}
}

//Function Number: 74
guy_basement_flashlight_monitor()
{
	self endon("death");
	for(;;)
	{
		level waittill("update_basement_flashlights");
		self notify("flashlight_off");
		if(isdefined(self.give_expensive_flashlight))
		{
			self.give_expensive_flashlight = undefined;
			self.has_expensive_flashlight = 1;
			add_basement_enemy_flashlight("flashlight","med");
			continue;
		}

		add_enemy_flashlight("flashlight","med");
		self.has_expensive_flashlight = 0;
	}
}

//Function Number: 75
guy_flashlight_basement_switch(param_00,param_01)
{
	self endon("death");
	thread guy_basement_flashlight_monitor();
	self.has_expensive_flashlight = 0;
	if(param_01)
	{
		self.give_expensive_flashlight = 1;
		level notify("update_basement_flashlights");
	}
	else
	{
		add_enemy_flashlight("flashlight","med");
	}

	thread debug_flashlight_basement_switch();
	for(;;)
	{
		maps\_shg_design_tools::waittill_trigger_with_name(param_00);
		if(!self.has_expensive_flashlight)
		{
			self.give_expensive_flashlight = 1;
			level notify("update_basement_flashlights");
		}
	}
}

//Function Number: 76
enemy_flashlight_think_on(param_00)
{
	self endon("death");
	for(;;)
	{
		maps\_shg_design_tools::waittill_trigger_with_name(param_00);
		if(!isdefined(self.flashlight_on) || self.flashlight_on == 0)
		{
			add_enemy_flashlight(self.flashlight_parm_type,self.flashlight_parm_spotlight,self.flashlight_parm_point_light,self.flashlight_parm_offset);
			self.flashlight_on = 1;
		}
	}
}

//Function Number: 77
enemy_flashlight_think_off(param_00)
{
	self endon("death");
	for(;;)
	{
		maps\_shg_design_tools::waittill_trigger_with_name(param_00);
		if(isdefined(self.flashlight_on) && self.flashlight_on == 1)
		{
			self notify("flashlight_off");
			self.flashlight_on = undefined;
		}
	}
}

//Function Number: 78
enemy_flashlight_toggle_think(param_00,param_01)
{
	thread enemy_flashlight_think_on(param_00);
	thread enemy_flashlight_think_off(param_01);
}

//Function Number: 79
grab_lighting()
{
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbVelocityScalar",".5");
	}

	common_scripts\_exploder::exploder(1685);
	wait(11);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
		common_scripts\_exploder::kill_exploder(1685);
	}
}

//Function Number: 80
hospital_flicker_lights()
{
	if(level.nextgen)
	{
		maps\_utility::trigger_wait_targetname("team_move_hospital");
		maps\_lighting::play_flickerlight_preset("white_fire","hospital_pulse_01",290000);
		maps\_lighting::play_flickerlight_preset("white_fire","hospital_pulse_02",80000);
	}
}

//Function Number: 81
burke_red_arm_light()
{
	maps\_shg_design_tools::waittill_trigger_with_name("move_burke_ahead");
	level.burke.red_point = common_scripts\utility::spawn_tag_origin();
	var_00 = level.burke.red_point;
	var_00 linkto(level.burke,"J_Elbow_LE",(4,-6,0),(0,0,0),0);
	playfxontag(common_scripts\utility::getfx("red_point"),var_00,"tag_origin");
}

//Function Number: 82
burke_red_arm_light_checkpoint()
{
	level.burke.red_point = common_scripts\utility::spawn_tag_origin();
	var_00 = level.burke.red_point;
	var_00 linkto(level.burke,"J_Elbow_LE",(4,-6,0),(160,90,90),0);
	if(common_scripts\utility::flag("red_dim") == 1)
	{
		playfxontag(common_scripts\utility::getfx("red_point_dim"),var_00,"tag_origin");
	}
	else
	{
		playfxontag(common_scripts\utility::getfx("red_point"),var_00,"tag_origin");
	}

	level waittill("kill_burke_red_light");
	if(isdefined(level.burke.red_point))
	{
		level.burke.red_point delete();
	}
}

//Function Number: 83
joker_red_arm_light_checkpoint()
{
	level.joker.red_point = common_scripts\utility::spawn_tag_origin();
	var_00 = level.joker.red_point;
	var_00 linkto(level.joker,"J_Elbow_LE",(4,-6,0),(160,90,90),0);
	playfxontag(common_scripts\utility::getfx("red_point_dim"),var_00,"tag_origin");
	level waittill("kill_joker_red_light");
	if(isdefined(level.joker.red_point))
	{
		level.joker.red_point delete();
	}
}

//Function Number: 84
train_lighting(param_00,param_01,param_02)
{
	param_00 endon("death");
	param_01 endon("death");
	param_02 endon("death");
	wait(0.1);
	if(common_scripts\utility::flag("jetbike_dynfx_on") == 1)
	{
		for(;;)
		{
			common_scripts\utility::flag_wait("lightning_on");
			playfxontag(common_scripts\utility::getfx("det_dyn_spotlight_train_nolight"),param_01,"tag_origin");
			playfxontag(common_scripts\utility::getfx("det_track_water_splash"),param_02,"tag_origin");
			common_scripts\utility::flag_waitopen("lightning_on");
			killfxontag(common_scripts\utility::getfx("det_dyn_spotlight_train_nolight"),param_01,"tag_origin");
			killfxontag(common_scripts\utility::getfx("det_track_water_splash"),param_02,"tag_origin");
		}

		return;
	}

	for(;;)
	{
		common_scripts\utility::flag_wait("lightning_on");
		if(common_scripts\utility::flag("alleyway_train") == 1)
		{
			playfxontag(common_scripts\utility::getfx("det_dyn_spotlight_train_lrg"),param_00,"tag_origin");
			playfxontag(common_scripts\utility::getfx("det_track_water_splash"),param_02,"tag_origin");
			common_scripts\utility::flag_waitopen("alleyway_train");
			killfxontag(common_scripts\utility::getfx("det_dyn_spotlight_train_lrg"),param_00,"tag_origin");
			killfxontag(common_scripts\utility::getfx("det_track_water_splash"),param_02,"tag_origin");
			continue;
		}

		playfxontag(common_scripts\utility::getfx("det_dyn_spotlight_train"),param_00,"tag_origin");
		playfxontag(common_scripts\utility::getfx("det_track_water_splash"),param_02,"tag_origin");
		common_scripts\utility::flag_waitopen("lightning_on");
		killfxontag(common_scripts\utility::getfx("det_dyn_spotlight_train"),param_00,"tag_origin");
		killfxontag(common_scripts\utility::getfx("det_track_water_splash"),param_02,"tag_origin");
	}
}

//Function Number: 85
trigger_chopper_spotlight_follow(param_00,param_01)
{
	self endon("death");
	level endon("kill_spotlight");
	if(!isdefined(self.spotlight))
	{
		self.spotlight = common_scripts\utility::spawn_tag_origin();
		self.spotlight thread handle_spotlight_fx(param_01);
	}

	for(;;)
	{
		self.spotlight.origin = maps\_shg_design_tools::offset_position_from_tag("down","tag_light_nose",0);
		var_02 = param_00.origin + param_00 maps\_shg_utility::get_differentiated_velocity() * 0.3;
		var_03 = (randomfloatrange(-20,20),randomfloatrange(-20,20),0);
		var_04 = vectortoangles(var_02 + var_03 - self.spotlight.origin);
		self.spotlight.angles = var_04;
		wait(randomfloat(0.05));
	}
}

//Function Number: 86
handle_spotlight_fx(param_00)
{
	if(param_00)
	{
		var_01 = ["heli_spotlight_god","heli_spot_flare"];
	}
	else
	{
		var_01 = ["heli_spotlight","heli_spot_flare"];
	}

	foreach(var_03 in var_01)
	{
		playfxontag(common_scripts\utility::getfx(var_03),self,"tag_origin");
	}

	level waittill("kill_spotlight");
	foreach(var_03 in var_01)
	{
		killfxontag(common_scripts\utility::getfx(var_03),self,"tag_origin");
	}

	wait 0.05;
	self delete();
}

//Function Number: 87
kill_spotlight()
{
	level notify("kill_spotlight");
	wait(0.5);
}

//Function Number: 88
trigger_chopper_spotlight_straight(param_00)
{
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(self,"tag_light_nose",(0,0,0),(28,0,0));
	var_01 thread handle_spotlight_fx(param_00);
}

//Function Number: 89
show_hidden_rail()
{
	if(level.nextgen)
	{
		var_00 = getent("hidden_rail_01","targetname");
		var_01 = getent("hidden_rail_02","targetname");
		var_02 = getent("hidden_rail_03","targetname");
		var_03 = getent("hidden_rail_04","targetname");
		var_04 = getent("hidden_rail_11","targetname");
		var_05 = getent("hidden_rail_12","targetname");
		var_06 = getent("hidden_rail_13","targetname");
		var_07 = getent("hidden_rail_14","targetname");
		var_08 = getent("hidden_rail_15","targetname");
		var_09 = getent("hidden_rail_16","targetname");
		var_0A = getent("hidden_rail_17","targetname");
		var_0B = getent("track_model_01","targetname");
		var_0C = getent("track_model_02","targetname");
		var_0D = common_scripts\utility::getstruct("rail_pos_01","targetname");
		var_0E = common_scripts\utility::getstruct("rail_pos_02","targetname");
		var_0F = common_scripts\utility::getstruct("rail_pos_03","targetname");
		var_10 = common_scripts\utility::getstruct("rail_pos_04","targetname");
		var_11 = common_scripts\utility::getstruct("rail_pos_11","targetname");
		var_12 = common_scripts\utility::getstruct("rail_pos_12","targetname");
		var_13 = common_scripts\utility::getstruct("rail_pos_13","targetname");
		var_14 = common_scripts\utility::getstruct("rail_pos_14","targetname");
		var_15 = common_scripts\utility::getstruct("rail_pos_15","targetname");
		var_16 = common_scripts\utility::getstruct("rail_pos_16","targetname");
		var_17 = common_scripts\utility::getstruct("rail_pos_17","targetname");
		var_18 = common_scripts\utility::getstruct("track_model_org_01","targetname");
		var_19 = common_scripts\utility::getstruct("track_model_org_02","targetname");
		var_00 hide();
		var_01 hide();
		var_02 hide();
		var_03 hide();
		var_04 hide();
		var_05 hide();
		var_06 hide();
		var_07 hide();
		var_08 hide();
		var_09 hide();
		var_0A hide();
		var_0B hide();
		var_0C hide();
		common_scripts\utility::flag_wait("capture_start");
		var_00 show();
		var_01 show();
		var_02 show();
		var_03 show();
		var_04 show();
		var_05 show();
		var_06 show();
		var_07 show();
		var_08 show();
		var_09 show();
		var_0A show();
		var_0B show();
		var_0C show();
		var_00.origin = var_0D.origin;
		var_01.origin = var_0E.origin;
		var_02.origin = var_0F.origin;
		var_03.origin = var_10.origin;
		var_04.origin = var_11.origin;
		var_05.origin = var_12.origin;
		var_06.origin = var_13.origin;
		var_07.origin = var_14.origin;
		var_08.origin = var_15.origin;
		var_09.origin = var_16.origin;
		var_0A.origin = var_17.origin;
		var_0B.origin = var_18.origin;
		var_0C.origin = var_19.origin;
	}
}

//Function Number: 90
exit_drive_jetbike_lighting()
{
	level.jetbike thread exit_drive_jetbike_lights_player();
	level.jetbike thread maps\detroit_exit_drive::exit_drive_player_jetbike_initial_lights();
	level.burke_bike thread exit_drive_jetbike_lights_ai();
}

//Function Number: 91
exit_drive_jetbike_lights_player()
{
	for(;;)
	{
		if(level.nextgen)
		{
			setsaveddvar("r_mbEnable","2");
			setsaveddvar("r_mbVelocityScalar","1.25");
		}

		common_scripts\utility::flag_wait("exitdrive_lights_on");
		common_scripts\utility::flag_set("jetbike_dynfx_on");
		var_00 = maps\_shg_utility::play_fx_with_handle("det_dyn_spotlight_jetbike",self,"tag_headlight");
		common_scripts\utility::flag_waitopen("exitdrive_lights_on");
		maps\_shg_utility::kill_fx_with_handle(var_00);
		if(level.nextgen)
		{
			setsaveddvar("r_mbEnable","0");
		}

		wait(0.05);
	}
}

//Function Number: 92
exit_drive_jetbike_lights_ai()
{
	level.burke_bike thread maps\detroit_jetbike::intro_drive_jetbike_lights_friendlies();
}

//Function Number: 93
ending_mech_lighting()
{
	var_00 = getentarray("gate_light_02_models","targetname");
	var_01 = getentarray("gate_light_02_models_off","targetname");
	foreach(var_03 in var_00)
	{
		var_03 show();
	}

	foreach(var_06 in var_01)
	{
		var_06 hide();
	}

	common_scripts\_exploder::exploder(9125);
	var_08 = common_scripts\utility::getstruct("light_ending_rim","targetname");
	var_09 = common_scripts\utility::getstruct("light_ending_key","targetname");
	var_0A = getent("door_lights_script1","targetname");
	var_0B = getent("heli_light_02","targetname");
	var_0C = getent("ending_light_02","targetname");
	if(isdefined(var_0A))
	{
		var_0A.origin = var_08.origin;
		var_0A setlightintensity(320000);
		var_0A setlightcolor((1,1,1));
		var_0A rotateby((0,-45,0),0.1);
	}

	if(isdefined(var_0B))
	{
		var_0B setlightintensity(600000);
		var_0B setlightcolor((1,0.5,0.25));
	}

	if(isdefined(var_0C))
	{
		var_0C setlightintensity(190000);
		var_0C setlightcolor((1,0.5,0.25));
	}
}

//Function Number: 94
move_mech_origins(param_00)
{
	level waittill("vfx_player_jetbike_stops");
	wait(3);
	var_01 = common_scripts\utility::getstruct("mech_new_origin2","targetname");
}

//Function Number: 95
final_chopper_lighting(param_00)
{
	var_01 = getent("heli_light","targetname");
	wait(0.05);
	if(isdefined(var_01))
	{
		var_01 setlightintensity(28200000);
		var_01 setlightcolor((1,0.9,0.6));
	}

	level.bones_bike maps\detroit_jetbike::intro_drive_jetbike_lights_friendlies();
	level.joker_bike maps\detroit_jetbike::intro_drive_jetbike_lights_friendlies();
	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(15.5,400);
	if(level.nextgen)
	{
		maps\_utility::lerp_saveddvar("r_mbVelocityScalar",1,1);
		wait(5);
		var_02 = getent("reflection_white_bottom","targetname");
		param_00 overridereflectionprobe(var_02.origin);
	}
	else
	{
		wait(5);
	}

	maps\_utility::vision_set_fog_changes("detroit_jetbike_end",2);
	var_03 = common_scripts\utility::spawn_tag_origin();
	var_03 linkto(param_00,"tag_light_nose",(60,40,0),(0,0,0));
	playfxontag(common_scripts\utility::getfx("aircraft_light_wingtip_red_med"),param_00,"tag_light_nose");
	wait(5);
	if(level.nextgen)
	{
		maps\_utility::lerp_saveddvar("r_mbVelocityScalar",2,1);
	}

	wait(1);
	maps\_utility::vision_set_fog_changes("detroit_jetbike_end_fire",0.4);
	wait(0.5);
	maps\_utility::vision_set_fog_changes("detroit_jetbike_end",0.5);
	wait(1.4);
	maps\_utility::vision_set_fog_changes("detroit_jetbike_end_fire",0.25);
	wait(1);
	maps\_utility::vision_set_fog_changes("detroit_jetbike_end",0.5);
	wait(0.65);
	maps\_utility::vision_set_fog_changes("detroit_jetbike_end_fire",0.1);
	wait(1.5);
	maps\_utility::vision_set_fog_changes("detroit_jetbike_end",1.5);
	level.player setphysicaldepthoffield(2.5,50);
	wait(10);
	level.player setphysicaldepthoffield(2.5,60);
}

//Function Number: 96
gate_origin_change()
{
	var_00 = getent("gate_lighting_origin","targetname");
	var_01 = getent("detroit_entrance_gate","targetname");
	var_01 overridelightingorigin(var_00.origin);
}

//Function Number: 97
jetbike_exit_pre_mount_lighting()
{
	common_scripts\_exploder::exploder(9405);
	var_00 = getentarray("gate_top_lights1","targetname");
	foreach(var_02 in var_00)
	{
		if(level.nextgen)
		{
			var_02 setlightintensity(10000);
		}
	}

	common_scripts\utility::flag_wait("player_on_exitdrive_jetbike");
	maps\_shg_design_tools::waittill_trigger_with_name("exitdrive_trigger_lightsoff");
	maps\_utility::stop_exploder(9405);
}

//Function Number: 98
sentinel_reveal_lighting()
{
	common_scripts\utility::flag_wait("reveal_the_sentinels");
	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(1.5,300);
	wait(1);
	setblur(1,1);
	if(level.nextgen)
	{
		maps\_utility::vision_set_fog_changes("detroit_sentinal",3);
	}

	wait(2);
	setblur(0,1);
	level.player setphysicaldepthoffield(5,300);
	thread maps\_lighting::lerp_spot_intensity("sent_reveal_spot_blue",4,10000);
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("sentkeylight",4,1000);
	}

	setblur(0,3);
	if(level.nextgen)
	{
		var_00 = getent("sentkeylight","targetname");
		var_00 setlightfovrange(60,50);
	}

	wait(10);
	thread maps\_lighting::lerp_spot_intensity("sent_reveal_spot_blue",8,200000);
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("sentkeylight",4,500);
		thread maps\_lighting::lerp_spot_color("sentkeylight",0.15,(1,1,1));
	}

	thread maps\_lighting::lerp_spot_radius("sent_reveal_spot_blue",3,400);
	wait(2);
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",1);
	}

	wait(2);
	level.player setphysicaldepthoffield(3,32);
	wait(4);
	level.player setphysicaldepthoffield(3,38);
	wait(2);
	thread maps\_lighting::lerp_spot_intensity("sent_reveal_spot_blue",4,50000);
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("sentkeylight",4,1000);
	}

	wait(8);
	thread maps\_lighting::lerp_spot_intensity("sent_reveal_spot_blue",2.5,4000);
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("sentkeylight",2.5,0);
	}

	maps\_utility::vision_set_fog_changes("detroit_city",5);
	level.player disablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",0);
	}
}

//Function Number: 99
sentinel_reveal_lighting_origins(param_00)
{
	var_01 = getent("new_grenade_org","targetname");
	param_00 overridelightingorigin(var_01.origin);
}

//Function Number: 100
outerspacelighting()
{
	if(level.nextgen)
	{
		setsaveddvar("r_useLightGridDefaultFXLightingLookup",1);
		setsaveddvar("r_useLightGridDefaultModelLightingLookup",1);
		setsaveddvar("r_lightGridDefaultFXLightingLookup",(-1493.99,7192.58,-96.875));
		setsaveddvar("r_lightGridDefaultModelLightingLookup",(-1493.99,7192.58,-96.875));
	}
}

//Function Number: 101
mech_intro_gate_lighting(param_00)
{
	if(isdefined(param_00.helmet_tag))
	{
		param_00.helmet_tag delete();
	}

	param_00.helmet_tag = common_scripts\utility::spawn_tag_origin();
	var_01 = param_00.helmet_tag;
	var_01 linkto(param_00,"J_Head",(0,5,-5),(0,0,0),0);
	playfxontag(common_scripts\utility::getfx("det_point_rim_lrg"),var_01,"tag_origin");
	wait(20);
	wait(4);
	soundscripts\_snd::snd_message("gate_lightning");
}

//Function Number: 102
mech_exit_gate_lighting(param_00)
{
	if(isdefined(param_00.helmet_tag))
	{
		param_00.helmet_tag delete();
	}

	param_00.helmet_tag = common_scripts\utility::spawn_tag_origin();
	var_01 = param_00.helmet_tag;
	var_01 linkto(param_00,"J_Head",(0,5,-5),(0,0,0),0);
	playfxontag(common_scripts\utility::getfx("det_point_rim_lrg"),var_01,"tag_origin");
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("door_lights_script2",10,6000);
		thread maps\_lighting::lerp_spot_intensity("door_lights_script1",10,100000);
	}
}

//Function Number: 103
setup_vfx_sunflare()
{
	thread maps\_shg_fx::fx_spot_lens_flare_dir("sunflare",(-30,85.5,0),10000);
}

//Function Number: 104
main_camp_spot()
{
	if(level.nextgen)
	{
		wait(0.05);
		var_00 = getent("courtyard_light_force","targetname");
		for(;;)
		{
			common_scripts\utility::flag_wait("main_camp_spot_on");
			var_00 setlightshadowstate("force_on");
			common_scripts\utility::flag_waitopen("main_camp_spot_on");
			var_00 setlightshadowstate("force_off");
		}
	}
}

//Function Number: 105
warbird_intro_lighting(param_00)
{
	param_00.interior_light = common_scripts\utility::spawn_tag_origin();
	var_01 = param_00.interior_light;
	var_01 linkto(param_00,"TAG_burke_key_light",(0,0,-35),(0,0,0),0);
	playfxontag(common_scripts\utility::getfx("point_white_med"),var_01,"tag_origin");
	wait(8);
	killfxontag(common_scripts\utility::getfx("point_white_med"),var_01,"tag_origin");
}

//Function Number: 106
vinette_overlay()
{
	level.player thread maps\_lighting::screen_effect_base(0,"s1_railgun_hud_outer_shadow",0,0,0.1,0,0,3);
	level waittill("end_screen_effect");
	level.overlay destroy();
}

//Function Number: 107
turn_off_gold_light()
{
	var_00 = getent("turn_off_gold_light","targetname");
	wait(8.75);
	var_00 setlightintensity(0);
}

//Function Number: 108
school_jeep_light_tgl()
{
	common_scripts\_exploder::exploder(4123);
	var_00 = getent("car_light","targetname");
	common_scripts\utility::flag_wait("school_player_falling");
	var_00 setlightintensity(0);
	common_scripts\_exploder::kill_exploder(4123);
}

//Function Number: 109
turn_off_jeep_light()
{
	var_00 = getent("car_light","targetname");
	var_00 setlightintensity(0);
}

//Function Number: 110
intro_lerp_sun()
{
	if(level.nextgen)
	{
		wait(2);
		var_00 = anglestoforward((-33.942,180,0));
		var_01 = anglestoforward((-65.942,162,0));
		var_02 = vectornormalize(var_00);
		var_03 = vectornormalize(var_01);
		wait(3);
		lerpsundirection(var_02,var_03,7);
		wait(80);
		lerpsundirection(var_03,var_02,17);
		common_scripts\utility::flag_wait("open_massive_door");
		resetsundirection();
	}
}

//Function Number: 111
capture_lighting()
{
	common_scripts\utility::flag_set("capture_start");
	maps\_utility::vision_set_fog_changes("detroit_hospital_capture",6);
	wait(2);
	common_scripts\utility::flag_set("red_dim");
	common_scripts\_exploder::exploder(9211);
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("officelamp",1,50);
		thread maps\_lighting::lerp_spot_intensity("bluemoon",1,2500);
		thread maps\_lighting::lerp_spot_intensity("bluemoonrim",1,1000);
	}

	wait(1);
	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(5.6,100);
	wait(1.2);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbVelocityScalar","2.5");
	}

	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("officelamp",1,100);
		thread maps\_lighting::lerp_spot_intensity("bluemoon",1,500);
		thread maps\_lighting::lerp_spot_intensity("rim_capture",1,2500);
		thread maps\_lighting::lerp_spot_intensity("bluemoonrim",1,2500);
	}

	wait(2.2);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
	}

	wait(15);
	maps\_utility::lerp_saveddvar("r_ssaoStrength",0.45,1);
	if(level.nextgen)
	{
		thread maps\_lighting::lerp_spot_intensity("rim_capture",1,0);
		thread maps\_lighting::lerp_spot_intensity("bluemoonrim",1,0);
	}

	wait(1);
	common_scripts\utility::flag_clear("red_dim");
	level notify("kill_burke_red_light");
	level notify("kill_joker_red_light");
	maps\_utility::lerp_saveddvar("r_ssaoStrength",0.45,1);
	level.player disablephysicaldepthoffieldscripting();
	maps\_utility::vision_set_fog_changes("detroit_hospital_top",4);
}

//Function Number: 112
exo_flicker_lighting()
{
	common_scripts\utility::flag_wait("flicker_street_lights");
	if(level.nextgen)
	{
		maps\_lighting::play_flickerlight_preset("street_light","streetlight_01",8000);
		maps\_lighting::play_flickerlight_preset("street_light","streetlight_02",9500);
		return;
	}

	maps\_lighting::play_flickerlight_preset("street_light","streetlight_01",100);
	maps\_lighting::play_flickerlight_preset("street_light","streetlight_02",500);
}

//Function Number: 113
handshake_lighting()
{
	common_scripts\utility::flag_wait("flag_scanner_doors_open");
	wait(13);
	thread maps\_lighting::lerp_spot_intensity("handshake_light",1,10);
}

//Function Number: 114
clut_manage()
{
	for(;;)
	{
		common_scripts\utility::flag_wait("lightning_on");
		level.player setclutforplayer("clut_detroit_exterior",1);
		common_scripts\utility::flag_waitopen("lightning_on");
		level.player setclutforplayer("clut_detroit_interior",1);
	}
}

//Function Number: 115
clut_manage_school()
{
	for(;;)
	{
		common_scripts\utility::flag_wait("lightning_on_school");
		level.player setclutforplayer("clut_detroit_exterior",1);
		common_scripts\utility::flag_waitopen("lightning_on_school");
		level.player setclutforplayer("clut_detroit_interior",1);
	}
}

//Function Number: 116
butress_origin_fix()
{
	var_00 = common_scripts\utility::getstruct("low_walls_origin","targetname");
	var_01 = getent("butress2","targetname");
	var_01 overridelightingorigin(var_00.origin);
}

//Function Number: 117
blockage_lighting(param_00)
{
	var_01 = getent("burke_third_floor_corner_check_wait","targetname");
	param_00 overridelightingorigin(var_01.origin);
}

//Function Number: 118
det_vignette()
{
	level.player thread maps\_lighting::screen_effect_base(0,"ac130_overlay_pip_bottom_vignette",0,0,1,0,3);
}

//Function Number: 119
cg_car_light_shadowstate_reset()
{
	var_00 = getent("car_light","targetname");
	for(;;)
	{
		level maps\_utility::wait_for_targetname_trigger("car_light_ssoff");
		var_00 setlightshadowstate("normal");
	}
}

//Function Number: 120
cg_car_light_shadowstate_on()
{
	var_00 = getent("car_light","targetname");
	for(;;)
	{
		level maps\_utility::wait_for_targetname_trigger("car_light_ssoon");
		var_00 setlightshadowstate("force_on");
	}
}