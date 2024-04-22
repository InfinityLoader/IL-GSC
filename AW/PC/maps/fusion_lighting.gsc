/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: fusion_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 96
 * Decompile Time: 1442 ms
 * Timestamp: 4/22/2024 2:30:11 AM
*******************************************************************/

//Function Number: 1
main()
{
	waittillframeend;
	precacheshader("overlay_rain_blur");
	precacheshader("overlay_film_grain");
	thread set_level_lighting_values();
	thread setup_dof_presets();
	thread setup_dof_viewmodel_presets();
	thread setup_flickerlight_presets();
	thread setup_flickerlight_motion_presets();
	thread fusion_intro_dof();
	thread sun_shad_vision_fly_in();
	thread lighting_setup_off_zip();
	thread setup_lighting_courtyard_start();
	thread exposure_adjust_courtyard_room();
	thread sun_shad_exposure_control_room();
	thread sun_shad_cooling_tower_area();
	thread sun_shad_cooling_tower_start();
	thread tonemapkey_call();
	thread tonemapkey_call_control_room();
	thread setup_fusion_finale_arm_rimlight();
	thread setup_fusion_finale_light_flicker();
	thread setup_fusion_finale_lightgrid();
	thread setup_fusion_finale_light_rim();
	thread setup_fusion_finale_helicopter_light();
	thread setup_fusion_finale_arm_fx();
	thread setup_fusion_light_model_flicker();
	thread setup_fusion_light_model_flicker2();
	thread setup_fusion_light_model_flicker3();
	thread setup_dof_security();
	thread setup_elevator_security_light();
	thread elevator_fall_dof_tweaks();
	thread setup_lighting_lab_start();
	thread setup_lab_script_volume();
	thread setup_lab_script_exit_volume();
	thread setup_lighting_reactor_start();
	thread setup_lighting_reactor_exit_start();
	thread setup_lights_pre_elevator();
	thread lighting_setup_turbine_elevator();
	thread setup_lighting_turbine_start();
	thread setup_turbine_room_pulsing_lights();
	thread setup_lighting_control_room_start();
	thread setup_control_room_door_explosion_light();
	thread setup_control_room_screen_light();
	thread setup_control_room_player_start();
	thread setup_control_room_scene_dof();
	thread setup_firelight_explosion_hangar();
	thread reactor_reveal_lighting();
	thread lighting_setup_reactor_door();
	thread test_sun_flare();
	thread setup_lighting_security_start();
	if(level.currentgen)
	{
		thread setup_lighting_security_start();
	}

	var_00 = getent("cooling_towers_fire_light","targetname");
	if(isdefined(var_00))
	{
		var_00 setlightintensity(0);
	}

	level.player thread fusion_zip_dof();
}

//Function Number: 2
linearlerp(param_00,param_01,param_02)
{
	return abs(param_00 * 1 - param_02 + param_01 * param_02);
}

//Function Number: 3
simcurrentgendynamicexpossure()
{
	for(;;)
	{
		var_00 = 5000;
		var_01 = level.player getplayerangles();
		var_02 = anglestoforward(var_01);
		var_03 = anglestoforward(var_01 + (-15,0,0));
		var_04 = anglestoforward(var_01 + (15,45,0));
		var_05 = anglestoforward(var_01 + (15,45,0));
		var_06 = level.player.origin + (0,0,64);
		var_07 = var_06 + var_02 * var_00;
		var_08 = var_06 + var_03 * var_00;
		var_09 = var_06 + var_04 * var_00;
		var_0A = var_06 + var_05 * var_00;
		var_0B = getmapsundirection();
		var_0C = bullettrace(var_06 + var_02 * 3,var_07,0,undefined);
		var_0D = bullettrace(var_06 + var_03 * 3,var_08,0,undefined);
		var_0E = bullettrace(var_06 + var_04 * 3,var_09,0,undefined);
		var_0F = bullettrace(var_06 + var_05 * 3,var_0A,0,undefined);
		var_10 = distance(var_06,var_0C["position"]);
		var_11 = distance(var_06,var_0D["position"]);
		var_12 = distance(var_06,var_0E["position"]);
		var_13 = distance(var_06,var_0F["position"]);
		var_14 = var_10 + var_11 + var_12 + var_13 / 4;
		var_15 = max(vectordot(var_0B,var_02),0);
		var_16 = var_14 / var_00 * var_15;
		var_17 = linearlerp(9.5,11,var_16);
		setsaveddvar("r_tonemapexposure",var_17);
		wait(0.55);
	}
}

//Function Number: 4
test_sun_flare()
{
	thread maps\_shg_fx::vfx_sunflare("fusion_sun_flare");
}

//Function Number: 5
set_level_lighting_values()
{
	if(level.nextgen)
	{
		setsaveddvar("r_hemiAoEnable",1);
	}

	setsaveddvar("r_disablelightsets",0);
	if(isusinghdr())
	{
		if(maps\_utility::is_gen4())
		{
		}
		else
		{
			setsaveddvar("r_tonemapExposureMultiplier",0.3);
		}

		if(level.ps4)
		{
			level.player lightsetforplayer("fusion");
		}
	}
}

//Function Number: 6
setup_dof_presets()
{
	maps\_lighting::create_dof_preset("fusion_intro",10,18,10,25,150,4.5,0.5);
	maps\_lighting::create_dof_preset("fusion_pre_zip",0,0,4.5,0,140,3,0.5);
	maps\_lighting::create_dof_preset("fusion_fly",10,50,4,3500,9000,1.5,0.5);
	maps\_lighting::create_dof_preset("fusion_fly_rack_nblur",1,310,4,3500,9000,1.5,0.5);
	maps\_lighting::create_dof_preset("fusion_ready_zip",1,2,4,300,9000,2,2.75);
	maps\_lighting::create_dof_preset("fusion_zip",100,585,4.5,810,16000,4.5,0.5);
}

//Function Number: 7
setup_dof_viewmodel_presets()
{
	maps\_lighting::create_dof_viewmodel_preset("fusion_vm_fly_rack_nblur",2,10);
	maps\_lighting::create_dof_viewmodel_preset("fusion_vm_off",0,0);
}

//Function Number: 8
setup_flickerlight_presets()
{
	maps\_lighting::create_flickerlight_preset("fusion_fire",(0.972549,0.62451,1),(0.2,0.1462746,1),0.005,0.2,5);
	maps\_lighting::create_flickerlight_preset("finale_heli_light",(0.9,0.8,0.7),(0.2,0.15,0.1),0.005,0.2,8);
}

//Function Number: 9
setup_flickerlight_motion_presets()
{
	maps\_lighting::create_flickerlight_motion_preset("fusion_hangar_fire",(1,0.2246,0),100000,2,0.05,0.2);
}

//Function Number: 10
fusion_intro_dof()
{
	common_scripts\utility::flag_wait("sun_shad_fly_in");
	if(level.nextgen)
	{
		wait(35);
		setsunlight(0,0,0);
		thread fly_in_vfx_dopl_light_setup();
		maps\_utility::vision_set_fog_changes("fusion_helicopter_closed",0);
		level.player setclutforplayer("clut_fusion_heli_interior",0.1);
		thread motion_blur_rotation_enable();
		setsaveddvar("r_dof_physical_bokehEnable",1);
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(1.1,64);
		wait(15);
		level.player setphysicaldepthoffield(1.5,45);
		wait(12);
		level.player setphysicaldepthoffield(1.1,62);
	}
	else
	{
		wait(35);
		thread fly_in_vfx_dopl_light_setup();
		maps\_utility::vision_set_fog_changes("fusion_helicopter",0);
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(1.1,64);
		wait(15);
		level.player setphysicaldepthoffield(2.25,32);
		wait(12);
		level.player setphysicaldepthoffield(1.1,64);
		level.player disablephysicaldepthoffieldscripting();
	}

	level waittill("hatch_door_open");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_fusion_fly_in",1);
		maps\_utility::vision_set_fog_changes("fusion_neutral",0);
	}

	thread maps\_shg_fx::screenshakefade(0.15,20,1,5);
	wait(1);
	thread script_probe_heli_open();
	thread heli_fly_vfx_dopl_fill_light_setup();
	wait(1);
	if(level.nextgen)
	{
		resetsunlight();
	}

	if(level.nextgen)
	{
		level.player disablephysicaldepthoffieldscripting();
	}
	else
	{
	}

	thread frame_rate_tune_shadows_up_over_cliff();
	thread frame_rate_tune_shadows_heli_crash();
	thread frame_rate_tune_shadows_turn_to_right();
	thread frame_rate_tune_shadows_roof_top();
	wait(45);
	if(level.nextgen)
	{
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(2,3500);
	}
	else
	{
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(2,3500);
		maps\_lighting::blend_dof_presets("default","default",0.1);
	}

	wait(3);
	maps\_utility::lerp_saveddvar("r_lightgridintensity",1,3);
	common_scripts\utility::flag_wait("ready_zip");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_fusion_zipline",1);
	}

	if(level.nextgen)
	{
	}
	else
	{
		maps\_lighting::blend_dof_presets("default","default",0.1);
	}

	common_scripts\utility::flag_wait("flag_player_zip_started");
	if(level.nextgen)
	{
		common_scripts\utility::flag_set("flag_autofocus_on");
		thread autofocus_hipenable();
		wait(5.5);
		common_scripts\utility::flag_clear("flag_autofocus_on");
		wait(1);
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_dof_physical_bokehEnable",0);
	}

	thread script_probe_heli_default();
}

//Function Number: 11
fly_in_primary_light_setup()
{
	var_00 = maps\_lighting::setup_scriptable_primary_light("heli_intro_rim",0,(-20,35.8,-11),(-43,-44,0),8500,(0.654,0.619,0.576),20,47,level.warbird_a,"TAG_monitor_top_light",170);
	maps\_lighting::execute_scriptable_primary_light(var_00);
	var_01 = maps\_lighting::setup_scriptable_primary_light("heli_intro_key",1,(87.9,95.8,10.8),(6.2,-97,0),2300,(0.49,0.59,0.678),10,40,level.warbird_a,"TAG_monitor_right_light",256);
	maps\_lighting::execute_scriptable_primary_light(var_01);
}

//Function Number: 12
fly_in_vfx_dopl_light_setup()
{
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00 linkto(level.warbird_a,"TAG_light_body_l",(10,0,-20),(14,110,0));
	playfxontag(common_scripts\utility::getfx("light_spot_key_burke_dopl"),var_00,"TAG_ORIGIN");
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01 linkto(level.warbird_a,"TAG_burke_rim_light",(-5,20,-2),(-10,-20,0));
	playfxontag(common_scripts\utility::getfx("light_spot_rim_burke_dopl"),var_01,"TAG_ORIGIN");
	level waittill("hatch_door_open");
	wait(4);
	stopfxontag(common_scripts\utility::getfx("light_spot_key_burke_dopl"),var_00,"TAG_ORIGIN");
	stopfxontag(common_scripts\utility::getfx("light_spot_rim_burke_dopl"),var_01,"TAG_ORIGIN");
	var_00 delete();
	var_01 delete();
}

//Function Number: 13
heli_fly_vfx_dopl_fill_light_setup()
{
	wait(3.5);
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00 linkto(level.warbird_a,"TAG_light_body_l",(10,0,-20),(6,112,0));
	playfxontag(common_scripts\utility::getfx("light_spot_fill_burke_dopl"),var_00,"TAG_ORIGIN");
	wait(20);
	stopfxontag(common_scripts\utility::getfx("light_spot_fill_burke_dopl"),var_00,"TAG_ORIGIN");
	wait 0.05;
	playfxontag(common_scripts\utility::getfx("light_spot_fill_burke_fade_dopl"),var_00,"TAG_ORIGIN");
	wait(10);
	var_00 delete();
}

//Function Number: 14
frame_rate_tune_shadows_up_over_cliff()
{
	wait(22);
	level.player lightsetforplayer("fusion_helicopter_cliff");
}

//Function Number: 15
frame_rate_tune_shadows_heli_crash()
{
	wait(33);
	level.player lightsetforplayer("fusion_helicopter_crash");
}

//Function Number: 16
frame_rate_tune_shadows_turn_to_right()
{
	wait(39);
	level.player lightsetforplayer("fusion_helicopter_turn_right");
}

//Function Number: 17
frame_rate_tune_shadows_roof_top()
{
	wait(55);
	level.player lightsetforplayer("fusion_helicopter_roof_top");
}

//Function Number: 18
ar_moment()
{
	common_scripts\utility::flag_wait("fx_ar_start");
	maps\_utility::vision_set_fog_changes("fusion_helicopter_ar",1);
	common_scripts\utility::flag_wait("fx_ar_stop");
	maps\_utility::vision_set_fog_changes("fusion_helicopter",1);
}

//Function Number: 19
fusion_zip_dof()
{
	level.player waittill("using_zip");
	if(level.nextgen == 1)
	{
	}
	else
	{
	}

	if(isusingssao())
	{
		level.player lightsetforplayer("fusion_helicopter_zip_grab");
	}

	if(level.nextgen)
	{
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(2.5,22,2,2);
	}
	else
	{
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(2.5,22,2,2);
		level.player disablephysicaldepthoffieldscripting();
	}

	wait(2.5);
	if(level.nextgen == 1)
	{
		wait(0.5);
		level.player setphysicaldepthoffield(9,800,2,2);
	}
	else
	{
	}

	if(isusingssao())
	{
		level.player lightsetforplayer("fusion_helicopter_roof_top");
	}

	self waittill("fastzip_start");
}

//Function Number: 20
sun_shad_vision_fly_in()
{
	common_scripts\utility::flag_wait("sun_shad_fly_in");
	thread set_grid_color_dark();
	thread script_probe_heli_closed();
	level.player lightsetforplayer("fusion_helicopter_intro");
	if(level.currentgen)
	{
		maps\_utility::vision_set_fog_changes("fusion_helicopter",0);
	}
}

//Function Number: 21
setup_vfx_lighting()
{
	if(level.currentgen)
	{
		setsaveddvar("r_dlightLimit",4);
	}

	playfxontag(common_scripts\utility::getfx("light_godray_02"),level.warbird_a,"TAG_godray");
	playfxontag(common_scripts\utility::getfx("light_point_blue_mon_left"),level.warbird_a,"TAG_monitor_left_light");
	playfxontag(common_scripts\utility::getfx("light_point_blue_mon_right"),level.warbird_a,"TAG_monitor_right_light");
	if(level.currentgen)
	{
		level waittill("hatch_door_open");
	}
}

//Function Number: 22
burke_spot_lighting()
{
	wait(11);
	playfxontag(common_scripts\utility::getfx("light_spot_rim_burke_fadeout"),level.warbird_a,"TAG_burke_rim_light");
	wait(10.05);
	stopfxontag(common_scripts\utility::getfx("light_spot_rim_burke_fadeout"),level.warbird_a,"TAG_burke_rim_light");
	wait(0.1);
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00 linkto(level.warbird_a,"TAG_burke_key_light",(-8,-35,5),(0,40,0));
	playfxontag(common_scripts\utility::getfx("light_spot_key_burke"),var_00,"TAG_ORIGIN");
	var_01 = common_scripts\utility::spawn_tag_origin();
	wait(10);
	var_01 linkto(level.warbird_a,"TAG_burke_key_light",(25,25,-10),(0,0,0));
	playfxontag(common_scripts\utility::getfx("light_point_blue_mon_mid"),var_01,"TAG_ORIGIN");
	wait(15);
	wait(1.8);
	stopfxontag(common_scripts\utility::getfx("light_point_blue_mon_mid"),var_01,"TAG_ORIGIN");
}

//Function Number: 23
fusion_fly_player_mist()
{
	var_00 = randomfloatrange(0.2,3);
	level.player maps\_utility::delaythread(var_00,::play_fullscreen_mist,3,0.1,1.5,0.6,0,0);
	var_01 = randomfloatrange(0.2,3);
	level.player maps\_utility::delaythread(var_01,::play_fullscreen_mist,3.5,0.1,1.5,0.6,50,-50);
	var_02 = randomfloatrange(0.2,3);
	level.player maps\_utility::delaythread(var_02,::play_fullscreen_mist,4,0.1,1.5,0.6,-50,50);
	var_03 = randomfloatrange(0.2,3);
	level.player maps\_utility::delaythread(var_03,::play_fullscreen_mist,4.5,0.1,1.5,0.6,20,20);
}

//Function Number: 24
set_grid_color_dark()
{
	if(level.nextgen)
	{
		wait(4);
		level.warbird_a startusingheroonlylighting();
		foreach(var_01 in level.warbird_a.zipline_gun_model)
		{
			var_01 startusingheroonlylighting();
		}
	}

	if(level.nextgen == 1)
	{
		setsaveddvar("r_lightgridenabletweaks","1");
		setsaveddvar("r_lightgridintensity",".4");
	}
}

//Function Number: 25
script_probe_heli_closed()
{
	wait(5);
	var_00 = getent("refl_probe_heli_closed","targetname");
	level.warbird_a overridereflectionprobe(var_00.origin);
	level.burke overridereflectionprobe(var_00.origin);
	level.guy_facing_player_intro overridereflectionprobe(var_00.origin);
	level.copilot_intro overridereflectionprobe(var_00.origin);
	level.pilot_intro overridereflectionprobe(var_00.origin);
	level.carter hide();
	level.deployable_cover hide();
	level.joker hide();
	foreach(var_02 in level.warbird_a.zipline_gun_model)
	{
		var_02 overridereflectionprobe(var_00.origin);
	}
}

//Function Number: 26
hide_all_chars()
{
	level.burke hide();
	level.joker hide();
	level.guy_facing_player_intro hide();
	level.copilot_intro hide();
	level.pilot_intro hide();
}

//Function Number: 27
script_probe_heli_open()
{
	wait(3.5);
	var_00 = getent("refl_probe_heli_open","targetname");
	level.warbird_a overridereflectionprobe(var_00.origin);
	level.burke overridereflectionprobe(var_00.origin);
	level.copilot_intro overridereflectionprobe(var_00.origin);
	level.pilot_intro overridereflectionprobe(var_00.origin);
	if(level.nextgen)
	{
		foreach(var_02 in level.warbird_a.zipline_gun_model)
		{
			var_02 overridereflectionprobe(var_00.origin);
		}

		return;
	}

	maps\_utility::vision_set_fog_changes("fusion_helicopter_open",2);
}

//Function Number: 28
script_probe_heli_default()
{
	level.warbird_a defaultreflectionprobe();
	level.burke defaultreflectionprobe();
	level.joker defaultreflectionprobe();
}

//Function Number: 29
hatch_door_veil(param_00)
{
	level notify("hatch_door_open");
	wait(3);
	common_scripts\_exploder::exploder(1020);
	wait(4);
	common_scripts\_exploder::exploder(1021);
	wait(8);
	common_scripts\_exploder::exploder(1022);
}

//Function Number: 30
hatch_door_vision(param_00)
{
	wait(0.05);
	if(level.currentgen == 1)
	{
		setsaveddvar("r_dlightLimit",2);
	}

	level.player lightsetforplayer("fusion_helicopter_door");
	if(level.nextgen)
	{
		wait(0.5);
	}
	else
	{
		wait(0.5);
	}

	level.player lightsetforplayer("fusion_helicopter_ride");
	wait(2);
	thread fusion_fly_player_mist();
	if(level.currentgen == 1)
	{
		setsaveddvar("r_dlightLimit",2);
		maps\_utility::vision_set_fog_changes("fusion_helicopter_open",1.5);
	}

	wait(12);
	maps\_utility::delaythread(21.8,::fusion_fly_player_mist);
}

//Function Number: 31
hatch_door_lightgrid_off(param_00)
{
	if(level.nextgen == 1)
	{
		maps\_utility::lerp_saveddvar("r_lightgridintensity",0.75,2);
	}
}

//Function Number: 32
hatch_door_push_fog_out(param_00)
{
	wait(24);
	if(level.nextgen)
	{
		maps\_utility::fog_set_changes("fusion_helicopter_closeup",3);
	}
	else
	{
		maps\_utility::vision_set_fog_changes("fusion_helicopter_closeup",3);
	}

	if(level.nextgen)
	{
		wait(14);
		return;
	}

	wait(18);
	maps\_utility::vision_set_fog_changes("fusion_zipline",3);
}

//Function Number: 33
hill_sunflare()
{
	thread maps\_shg_fx::fx_spot_lens_flare_dir("light_sunflare",(-20,110,0),8000);
}

//Function Number: 34
battle_exterior_sunflare()
{
	thread maps\_shg_fx::fx_spot_lens_flare_dir("light_sunflare",(-20,110,0),8000);
}

//Function Number: 35
play_fullscreen_mist(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = newclienthudelem(self);
	var_06.x = param_04;
	var_06.y = param_05;
	var_06 setshader("overlay_rain_blur",640,480);
	var_06.splatter = 1;
	var_06.alignx = "left";
	var_06.aligny = "top";
	var_06.sort = 1;
	var_06.foreground = 0;
	var_06.horzalign = "fullscreen";
	var_06.vertalign = "fullscreen";
	var_06.alpha = 0;
	var_07 = 0;
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	var_08 = 0.05;
	if(param_01 > 0)
	{
		var_09 = 0;
		var_0A = param_03 / param_01 / var_08;
		while(var_09 < param_03)
		{
			var_06.alpha = var_09;
			var_09 = var_09 + var_0A;
			wait(var_08);
		}
	}

	var_06.alpha = param_03;
	wait(param_00 - param_01 + param_02);
	if(param_02 > 0)
	{
		var_09 = param_03;
		var_0B = param_03 / param_02 / var_08;
		while(var_09 > 0)
		{
			var_06.alpha = var_09;
			var_09 = var_09 - var_0B;
			wait(var_08);
		}
	}

	var_06.alpha = 0;
	var_06 destroy();
}

//Function Number: 36
lighting_setup_off_zip()
{
	common_scripts\utility::flag_wait("sun_shad_off_zip");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_fusion_street",1);
	}

	if(isusinghdr())
	{
		level.player lightsetforplayer("fusion_default_exterior_lightset");
	}

	if(level.currentgen)
	{
		maps\_utility::vision_set_fog_changes("fusion_battle_exterior_golden",10);
	}

	thread fusion_fastzip_quake();
}

//Function Number: 37
fusion_fastzip_quake()
{
	earthquake(0.2,1,level.player.origin,1600);
}

//Function Number: 38
setup_lighting_courtyard_start()
{
	if(level.nextgen)
	{
		common_scripts\utility::flag_wait("courtyard_start_lighting");
		maps\_utility::vision_set_fog_changes("fusion_neutral",0.25);
		level.player setclutforplayer("clut_fusion_street",0.1);
	}
}

//Function Number: 39
exposure_adjust_courtyard_room()
{
	if(level.nextgen)
	{
		var_00 = getentarray("exposure_adjust_courtyard_room_volume","targetname");
		foreach(var_02 in var_00)
		{
			var_02 thread exposure_adjust_courtyard_room_volume();
		}
	}
}

//Function Number: 40
exposure_adjust_courtyard_room_volume()
{
	if(level.nextgen)
	{
		for(;;)
		{
			self waittill("trigger");
			if(isusinghdr())
			{
				level.player lightsetforplayer("fusion_courtyard");
			}

			maps\_utility::vision_set_fog_changes("fusion_neutral_fogfar",5);
			while(level.player istouching(self))
			{
				wait(0.1);
			}

			if(isusinghdr())
			{
				level.player lightsetforplayer("fusion_default_exterior_lightset");
			}

			maps\_utility::vision_set_fog_changes("fusion_neutral",5);
		}
	}
}

//Function Number: 41
setup_dof_enter_turret()
{
	setsaveddvar("r_dof_physical_bokehenable",1);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
	}

	setsaveddvar("r_mbCameraRotationInfluence","1");
}

//Function Number: 42
setup_dof_exit_turret()
{
	setsaveddvar("r_dof_physical_bokehenable",0);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
	}

	setsaveddvar("r_mbCameraRotationInfluence","0");
}

//Function Number: 43
setup_lighting_security_start()
{
	common_scripts\utility::flag_wait("security_room_player_start");
	wait(0.5);
	level.player lightsetforplayer("fusion_security_lightset");
	maps\_utility::vision_set_fog_changes("fusion_security",0.05);
	level.player setclutforplayer("clut_fusion_security",0.1);
	thread maps\_lighting::lerp_spot_intensity("fusion_security_elevator_light",1,150000);
	thread setup_turbine_room_outerspace_lighting();
	if(level.currentgen == 1)
	{
		setsaveddvar("r_dlightLimit",2);
	}
}

//Function Number: 44
setup_dof_security()
{
	if(level.currentgen == 1)
	{
		setsaveddvar("r_dlightLimit",2);
	}

	var_00 = getentarray("security_area_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread setup_dof_security_volume();
	}
}

//Function Number: 45
setup_dof_security_volume()
{
	for(;;)
	{
		self waittill("trigger");
		var_00 = getent("fusion_security_elevator_light","targetname");
		var_00 setlightshadowstate("force_on");
		thread setup_turbine_room_outerspace_lighting();
		while(level.player istouching(self))
		{
			wait(0.1);
		}

		var_00 setlightshadowstate("normal");
	}
}

//Function Number: 46
setup_elevator_security_light()
{
	common_scripts\utility::flag_wait("burke_facing_elevator");
	thread maps\_lighting::lerp_spot_intensity("fusion_security_elevator_light",1,85000);
}

//Function Number: 47
elevator_fall_dof_tweaks()
{
	common_scripts\utility::flag_wait("elevator_descent_player");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
	}

	wait(2.5);
	wait(2.5);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_mbCameraRotationInfluence","0");
	}
}

//Function Number: 48
setup_lighting_lab_start()
{
	common_scripts\utility::flag_wait("lab_player_start");
	wait(0.5);
	level.player lightsetforplayer("fusion_lab_lightset");
	maps\_utility::vision_set_fog_changes("fusion_lab",0.05);
	level.player setclutforplayer("clut_fusion_lab",0.1);
	thread setup_turbine_room_outerspace_lighting();
}

//Function Number: 49
setup_lab_script_volume()
{
	var_00 = getentarray("lab_entrance_lighting_script_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread lab_script_volume();
	}
}

//Function Number: 50
lab_script_volume()
{
	for(;;)
	{
		self waittill("trigger");
		setsaveddvar("Sm_spotlightscoreradiuspower",0.8);
		var_00 = getent("lab_warm_light_01","targetname");
		var_00 setlightshadowstate("force_on");
	}
}

//Function Number: 51
setup_lab_script_exit_volume()
{
	var_00 = getentarray("lab_exit_lighting_script_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread lab_script_exit_volume();
	}
}

//Function Number: 52
lab_script_exit_volume()
{
	for(;;)
	{
		self waittill("trigger");
		setsaveddvar("Sm_spotlightscoreradiuspower",0.6);
		var_00 = getent("lab_warm_light_01","targetname");
		var_00 setlightshadowstate("normal");
	}
}

//Function Number: 53
setup_lighting_reactor_start()
{
	if(level.nextgen)
	{
		common_scripts\utility::flag_wait("reactor_player_start");
		wait(0.5);
		level.player lightsetforplayer("fusion_locker_room_lightset");
		maps\_utility::vision_set_fog_changes("fusion_locker_room",0.05);
		level.player setclutforplayer("clut_fusion_lab",0.1);
	}

	thread setup_turbine_room_outerspace_lighting();
}

//Function Number: 54
lighting_setup_reactor_door()
{
	var_00 = getentarray("reactor_door_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread lighting_setup_reactor_door_volume();
	}
}

//Function Number: 55
lighting_setup_reactor_door_volume()
{
	for(;;)
	{
		self waittill("trigger");
		thread maps\_lighting::lerp_spot_intensity("fusion_airlock_open_light",1,0);
		thread maps\_lighting::lerp_spot_intensity("fusion_reactor_airlock_screen_light",1,20);
		var_00 = getent("fusion_airlock_open_light","targetname");
		var_00 setlightshadowstate("force_on");
		while(level.player istouching(self))
		{
			wait(0.1);
		}

		var_00 setlightshadowstate("normal");
	}
}

//Function Number: 56
reactor_reveal_lighting()
{
	common_scripts\utility::flag_wait("reactor_room_reveal_scene");
	thread maps\_lighting::lerp_spot_intensity("fusion_airlock_open_light",1,45000);
	wait(8);
	level.player lightsetforplayer("fusion_reactor_door_lightset");
	if(level.nextgen)
	{
		wait(8);
		level.player lightsetforplayer("fusion_reactor_lightset");
		maps\_utility::vision_set_fog_changes("fusion_reactor",8);
	}
}

//Function Number: 57
setup_lighting_reactor_exit_start()
{
	common_scripts\utility::flag_wait("reactor_exit_player_start");
	wait(0.5);
	if(level.currentgen == 1)
	{
		setsaveddvar("r_dlightLimit",2);
	}

	level.player lightsetforplayer("fusion_pre_elevator_lightset");
	maps\_utility::vision_set_fog_changes("fusion_loading_area",0.5);
	level.player setclutforplayer("clut_fusion_reactor",0.1);
	thread setup_turbine_room_outerspace_lighting();
}

//Function Number: 58
setup_lights_pre_elevator()
{
	wait(0.5);
	var_00 = getent("elevator_control","targetname");
	var_01 = getent("pre_elevator_omni_teal","targetname");
	var_02 = getent("pre_elevator_omni_white","targetname");
	var_01 setlightshadowstate("force_off");
	var_02 setlightshadowstate("force_off");
	thread maps\_lighting::lerp_spot_intensity("elevator_start_fill_light",1,1000);
	thread maps\_lighting::lerp_spot_color("elevator_start_fill_light",1,(0.9,0.6,0.3));
	common_scripts\utility::flag_wait("elevator_ascend");
	thread maps\_lighting::lerp_spot_intensity("elevator_start_fill_light",0.25,0);
	thread scripted_fx_on_struct("turbine_room_elevator_monitor_01_fx","fus_light_elevator_monitor",var_00,"turbine_room_combat_start");
}

//Function Number: 59
lighting_setup_turbine_elevator()
{
	var_00 = getentarray("turbine_elevator_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread lighting_setup_turbine_elevator_volume();
	}
}

//Function Number: 60
lighting_setup_turbine_elevator_volume()
{
	for(;;)
	{
		self waittill("trigger");
		var_00 = getent("elevator_control","targetname");
		if(level.nextgen == 1)
		{
		}

		common_scripts\utility::flag_wait("elevator_ascend");
		if(level.nextgen)
		{
			setsaveddvar("r_mbEnable","2");
		}

		level.player lightsetforplayer("fusion_elevator_dark_lightset");
		if(level.nextgen)
		{
			common_scripts\_exploder::exploder(3466);
		}

		if(level.currentgen == 1)
		{
			setsaveddvar("r_dlightLimit",2);
		}

		common_scripts\utility::flag_wait("turbine_room_combat_start");
		if(level.nextgen)
		{
			common_scripts\_exploder::kill_exploder(3466);
		}

		if(level.nextgen)
		{
			setsaveddvar("r_mbEnable","0");
		}
	}
}

//Function Number: 61
setup_lighting_turbine_start()
{
	common_scripts\utility::flag_wait("turbine_room_player_start");
	wait(0.5);
	if(level.currentgen == 1)
	{
		setsaveddvar("r_dlightLimit",2);
	}

	level.player lightsetforplayer("fusion_elevator_to_turbine_lightset");
	maps\_utility::vision_set_fog_changes("fusion_turbines_reveal",3);
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_fusion_turbine",0.1);
	}

	thread maps\_lighting::lerp_spot_intensity("turbine_main_key_01",1,1200000);
	thread maps\_lighting::lerp_spot_intensity("turbine_main_key_02",1,1200000);
	thread maps\_lighting::lerp_spot_intensity("turbine_main_key_03",1,1200000);
	thread maps\_lighting::lerp_spot_intensity("turbine_back_problem_light_01",3,70000);
	thread maps\_lighting::lerp_spot_intensity("turbine_back_problem_light_02",3,70000);
	thread setup_turbine_room_outerspace_lighting();
}

//Function Number: 62
setup_turbine_room_outerspace_lighting()
{
	var_00 = common_scripts\utility::getstruct("outerspace_lighting_dark","targetname");
	enableouterspacemodellighting(var_00.origin,(1E-06,1E-06,1E-06));
}

//Function Number: 63
setup_turbine_room_pulsing_lights()
{
	common_scripts\utility::flag_wait("turbine_room_combat_start");
	thread maps\_lighting::play_pulse_preset("turbine_pulse","turbine_emergency_light_01");
	thread maps\_lighting::play_pulse_preset("turbine_pulse","turbine_emergency_light_02");
	thread maps\_lighting::play_pulse_preset("turbine_pulse","turbine_emergency_light_03");
	thread maps\_lighting::play_pulse_preset("turbine_pulse","turbine_emergency_light_04");
	thread maps\_lighting::play_pulse_preset("turbine_pulse","turbine_emergency_light_05");
	thread maps\_lighting::play_pulse_preset("turbine_pulse","turbine_emergency_light_06");
	thread maps\_lighting::play_pulse_preset("turbine_pulse","turbine_emergency_light_07");
	thread maps\_lighting::play_pulse_preset("turbine_pulse","turbine_emergency_light_08");
	thread maps\_lighting::play_pulse_preset("turbine_pulse","turbine_emergency_light_09");
	thread maps\_lighting::play_pulse_preset("turbine_pulse","turbine_emergency_light_10");
	thread maps\_lighting::play_pulse_preset("turbine_pulse","turbine_emergency_light_11");
	thread maps\_lighting::play_pulse_preset("turbine_pulse","turbine_emergency_light_12");
}

//Function Number: 64
setup_lighting_fly_drone_turbine()
{
	wait(0.5);
	maps\_utility::vision_set_fog_changes("fusion_turbines_drone",0.1);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
		setsaveddvar("r_dof_physical_bokehenable",1);
	}
}

//Function Number: 65
setup_lighting_fly_drone_off_turbine()
{
	wait(0.5);
	maps\_utility::vision_set_fog_changes("fusion_turbines",0.1);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_mbCameraRotationInfluence","0");
		setsaveddvar("r_dof_physical_bokehenable",0);
	}
}

//Function Number: 66
setup_lighting_control_room_start()
{
	common_scripts\utility::flag_wait("control_room_entrance_player_start");
	wait(1);
	maps\_utility::vision_set_fog_changes("fusion_offices",0.5);
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_fusion_lab",0.1);
	}

	if(level.currentgen)
	{
		setsaveddvar("r_dlightLimit",2);
	}

	level.player lightsetforplayer("fusion_default_interior_lightset");
	thread setup_turbine_room_outerspace_lighting();
}

//Function Number: 67
setup_control_room_door_explosion_light()
{
	common_scripts\utility::flag_wait("control_room_explosion");
	var_00 = getentarray("control_room_door_explosion_light","script_noteworthy");
	foreach(var_02 in var_00)
	{
		if(level.nextgen == 1)
		{
			var_02 setlightintensity(40000);
			continue;
		}

		var_02 setlightintensity(4000);
	}
}

//Function Number: 68
setup_control_room_screen_light()
{
	self endon("death");
	common_scripts\utility::flag_wait("control_room_explosion");
	maps\_lighting::play_flickerlight_preset("static_screen","control_room_static_screen",300000);
}

//Function Number: 69
setup_control_room_player_start()
{
	common_scripts\utility::flag_wait("control_room_player_start");
	level.player lightsetforplayer("fusion_screen_control_room_lightset");
	maps\_utility::vision_set_fog_changes("fusion_control_room_dark",0.5);
	level.player setclutforplayer("clut_fusion_control_room",0.1);
}

//Function Number: 70
setup_control_room_scene_dof()
{
	common_scripts\utility::flag_wait("control_room_console_used");
	if(level.nextgen)
	{
		var_00 = getent("control_room_static_screen","targetname");
		var_00 setlightfovrange(60,30);
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
		setsaveddvar("r_dof_physical_bokehenable",1);
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(3,61);
	}

	common_scripts\utility::flag_wait("flag_shut_down_reactor_failed");
	if(level.nextgen)
	{
		var_00 = getent("control_room_static_screen","targetname");
		var_00 setlightfovrange(110,40);
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_mbCameraRotationInfluence","0");
		setsaveddvar("r_dof_physical_bokehenable",0);
		level.player disablephysicaldepthoffieldscripting();
	}
}

//Function Number: 71
sun_shad_exposure_control_room()
{
	common_scripts\utility::flag_wait("start_control_room_exit_lighting");
	maps\_utility::vision_set_fog_changes("fusion_control_room",0.5);
	level.player setclutforplayer("clut_fusion_hangar",0.1);
	if(level.currentgen == 1)
	{
		setsaveddvar("r_dlightLimit",2);
	}

	level.player lightsetforplayer("fusion_control_room_exit_lightset");
	thread setup_fusion_finale_light_flicker();
}

//Function Number: 72
tonemapkey_call_control_room()
{
	var_00 = getentarray("tonemapkey_control_room_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread tonemapkey_control_room_volume();
	}
}

//Function Number: 73
tonemapkey_control_room_volume()
{
	for(;;)
	{
		self waittill("trigger");
		disableouterspacemodellighting();
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 74
setup_firelight_explosion_hangar()
{
	common_scripts\utility::flag_wait("hangar_enemies");
	common_scripts\utility::flag_waitopen("dialogue_playing");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
	}

	wait(1);
	maps\_lighting::play_flickerlight_motion_preset("fusion_hangar_fire","fusion_hangar_firelight");
	wait(3);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_mbCameraRotationInfluence","0");
	}
}

//Function Number: 75
enable_motion_blur_cooling_tower_explosions()
{
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
	}

	wait(4.5);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_mbCameraRotationInfluence","0");
	}
}

//Function Number: 76
tonemapkey_call()
{
	var_00 = getentarray("tonemapkey_cooling_towers_volume","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread tonemapkey_cooling_towers_volume();
	}
}

//Function Number: 77
tonemapkey_cooling_towers_volume()
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

//Function Number: 78
sun_shad_cooling_tower_area()
{
	common_scripts\utility::flag_wait("cooling_tower_cart_explosion_lighting");
	wait(1.25);
	level.player lightsetforplayer("fusion_cooling_towers_post_lightset");
}

//Function Number: 79
sun_shad_cooling_tower_start()
{
	common_scripts\utility::flag_wait("player_start_cooling_tower");
	if(level.currentgen == 0)
	{
		level.player lightsetforplayer("fusion_cooling_towers_start_lightset");
	}
	else
	{
		setsaveddvar("sm_sunsamplesizenear",0.38);
	}

	level.player setclutforplayer("clut_fusion_cooling_towers",0.1);
	thread setup_fusion_finale_light_flicker();
}

//Function Number: 80
setup_fusion_finale_arm_rimlight()
{
	common_scripts\utility::flag_wait("collapse_start");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
	}

	level.player setclutforplayer("clut_fusion_collapse",0.1);
	level.player lightsetforplayer("fusion_cooling_towers_collapse_lightset");
	setsaveddvar("sm_spotlightscoremodelscale",1);
	maps\_utility::vision_set_fog_changes("fusion_cooling_towers_collapse",5);
	common_scripts\utility::flag_wait("tower_knockback");
	if(isusinghdr())
	{
		level.player lightsetforplayer("fusion_cooling_towers_collapse_lightset");
	}

	wait(2);
	wait(12);
	maps\_utility::vision_set_fog_changes("fusion_cooling_towers_collapse_after",5);
	wait(5);
	wait(16.5);
	if(isusinghdr())
	{
		level.player lightsetforplayer("fusion_arm_sequence_lightset");
	}

	wait(1);
	wait(1);
	wait(14);
	if(isusinghdr())
	{
		level.player lightsetforplayer("fusion_cooling_towers_collapse_veil_off_lightset");
	}
}

//Function Number: 81
setup_fusion_finale_arm_fx()
{
	common_scripts\utility::flag_wait("tower_knockback");
	wait(34);
	common_scripts\_exploder::exploder(6036);
	wait(23);
	maps\_utility::pauseexploder(6036);
}

//Function Number: 82
firelight_volume()
{
	maps\_lighting::play_flickerlight_preset("fire","fire_flicker");
}

//Function Number: 83
firelight_volume2()
{
	maps\_lighting::play_flickerlight_preset("fire","fire_flicker");
}

//Function Number: 84
hide_fusion_street_lights_off()
{
	self endon("death");
	common_scripts\utility::flag_wait("evacuation_started");
	var_00 = getentarray("fusion_light_flicker_off","script_noteworthy");
	var_01 = getentarray("fusion_light_flicker_off1","script_noteworthy");
	var_02 = getentarray("fusion_light_flicker_off2","script_noteworthy");
	var_00 hide();
	var_01 hide();
	var_02 hide();
}

//Function Number: 85
setup_fusion_finale_light_flicker()
{
	self endon("death");
	var_00 = getentarray("fusion_finale_light_flicker","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 setlightintensity(200000);
	}

	common_scripts\utility::flag_wait("collapse_start");
	var_04 = 5;
	var_05 = 0;
	var_06 = randomfloatrange(0.05,0.1);
	while(var_05 < var_04)
	{
		common_scripts\_exploder::exploder(6026);
		foreach(var_02 in var_00)
		{
			var_02 setlightintensity(200000);
		}

		wait(var_06);
		foreach(var_02 in var_00)
		{
			var_02 setlightintensity(0.5);
		}

		var_05++;
		wait(var_06);
	}

	maps\_utility::pauseexploder(6026);
}

//Function Number: 86
setup_fusion_finale_lightgrid()
{
	common_scripts\utility::flag_wait("tower_knockback");
	wait(30);
	setsaveddvar("r_lightgridenabletweaks","1");
	if(level.nextgen == 1)
	{
		maps\_utility::lerp_saveddvar("r_lightgridintensity",0.15,4);
	}
}

//Function Number: 87
setup_fusion_finale_light_rim_fov()
{
	common_scripts\utility::flag_wait("tower_knockback");
	var_00 = getentarray("fusion_finale_light_rim","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 setlightfovrange(45,25);
		wait(36);
		var_02 setlightfovrange(30,20);
		wait(18);
		var_02 setlightfovrange(65,55);
	}
}

//Function Number: 88
setup_fusion_finale_light_rim()
{
	self endon("death");
	thread setup_fusion_finale_light_rim_fov();
	common_scripts\utility::flag_wait("tower_knockback");
	var_00 = getentarray("fusion_finale_light_rim","script_noteworthy");
	foreach(var_02 in var_00)
	{
		wait(18);
		var_02 setlightintensity(300000);
	}

	var_04 = 999;
	var_05 = 0;
	var_06 = randomfloatrange(0.05,1.5);
	while(var_05 < var_04)
	{
		foreach(var_02 in var_00)
		{
			var_02 thread maps\_lights::changelightcolorto((30.1,28.81,25.51),0.5,0.05,0.35);
		}

		wait(var_06);
		foreach(var_02 in var_00)
		{
			var_02 thread maps\_lights::changelightcolorto((0.5,0.5,0.5),0.65,0.45,0.05);
		}

		wait(var_06);
		foreach(var_02 in var_00)
		{
			var_02 thread maps\_lights::changelightcolorto((0.75,0.75,0.75),0.5,0.05,0.35);
		}

		var_05++;
		wait(var_06);
	}
}

//Function Number: 89
setup_fusion_finale_helicopter_light()
{
	common_scripts\utility::flag_wait("tower_knockback");
	wait(10);
	thread maps\_lighting::lerp_spot_intensity("fusion_finale_helicopter_light",1,20000000);
	maps\_lighting::play_flickerlight_preset("finale_heli_light","fusion_finale_helicopter_light",20000000);
}

//Function Number: 90
setup_fusion_light_model_flicker()
{
	self endon("death");
	level endon("collapse_animation_started");
	common_scripts\utility::flag_wait("evacuation_started");
	var_00 = getentarray("fusion_light_flicker_off","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}

	common_scripts\_exploder::exploder(1666);
	common_scripts\_exploder::exploder(1668);
	common_scripts\_exploder::exploder(1669);
	common_scripts\utility::flag_wait("collapse_start");
	var_04 = getentarray("fusion_light_flicker_on","script_noteworthy");
	var_05 = 3;
	var_06 = 0;
	var_07 = randomfloatrange(0.1,0.25);
	common_scripts\_exploder::exploder(1667);
	while(var_06 < var_05)
	{
		common_scripts\_exploder::exploder(1666);
		foreach(var_02 in var_04)
		{
			var_02 show();
		}

		foreach(var_0B in var_00)
		{
			var_0B hide();
		}

		wait(var_07);
		maps\_utility::stop_exploder(1666);
		foreach(var_02 in var_04)
		{
			var_02 hide();
		}

		foreach(var_0B in var_00)
		{
			var_0B show();
		}

		var_06++;
		wait(var_07);
	}
}

//Function Number: 91
setup_fusion_light_model_flicker2()
{
	self endon("death");
	level endon("collapse_animation_started");
	common_scripts\utility::flag_wait("evacuation_started");
	var_00 = getentarray("fusion_light_flicker_off2","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}

	common_scripts\utility::flag_wait("collapse_start");
	var_04 = getentarray("fusion_light_flicker_on2","script_noteworthy");
	var_05 = 5;
	var_06 = 0;
	var_07 = randomfloatrange(0.1,0.25);
	common_scripts\_exploder::exploder(1667);
	while(var_06 < var_05)
	{
		common_scripts\_exploder::exploder(1668);
		foreach(var_02 in var_04)
		{
			var_02 show();
		}

		foreach(var_0B in var_00)
		{
			var_0B hide();
		}

		wait(var_07);
		maps\_utility::stop_exploder(1668);
		foreach(var_02 in var_04)
		{
			var_02 hide();
		}

		foreach(var_0B in var_00)
		{
			var_0B show();
		}

		var_06++;
		wait(var_07);
	}
}

//Function Number: 92
setup_fusion_light_model_flicker3()
{
	self endon("death");
	level endon("collapse_animation_started");
	common_scripts\utility::flag_wait("evacuation_started");
	var_00 = getentarray("fusion_light_flicker_off3","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 hide();
	}

	common_scripts\utility::flag_wait("collapse_start");
	var_04 = getentarray("fusion_light_flicker_on3","script_noteworthy");
	var_05 = 4;
	var_06 = 0;
	var_07 = randomfloatrange(0.1,0.25);
	common_scripts\_exploder::exploder(1667);
	while(var_06 < var_05)
	{
		common_scripts\_exploder::exploder(1669);
		foreach(var_02 in var_04)
		{
			var_02 show();
		}

		foreach(var_0B in var_00)
		{
			var_0B hide();
		}

		wait(var_07);
		maps\_utility::stop_exploder(1669);
		foreach(var_02 in var_04)
		{
			var_02 hide();
		}

		foreach(var_0B in var_00)
		{
			var_0B show();
		}

		var_06++;
		wait(var_07);
	}
}

//Function Number: 93
scripted_fx_on_struct(param_00,param_01,param_02,param_03)
{
	var_04 = common_scripts\utility::getstruct(param_00,"targetname");
	if(!isdefined(param_03) && !isdefined(param_02))
	{
		if(isdefined(var_04.angles))
		{
			playfx(common_scripts\utility::getfx(param_01),var_04.origin,anglestoforward(var_04.angles),anglestoup(var_04.angles));
			return;
		}

		playfx(common_scripts\utility::getfx(param_01),var_04.origin);
		return;
	}

	var_05 = common_scripts\utility::spawn_tag_origin();
	var_05.origin = var_04.origin;
	if(isdefined(var_04.angles))
	{
		var_05.angles = var_04.angles;
	}

	if(isdefined(param_02))
	{
		var_05 linkto(param_02);
	}

	playfxontag(common_scripts\utility::getfx(param_01),var_05,"tag_origin");
	if(isdefined(param_03))
	{
		common_scripts\utility::flag_wait(param_03);
		stopfxontag(common_scripts\utility::getfx(param_01),var_05,"tag_origin");
		var_05 delete();
	}
}

//Function Number: 94
debug_show_org()
{
	self endon("death");
	wait 0.05;
}

//Function Number: 95
motion_blur_rotation_enable()
{
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
	}

	setsaveddvar("r_mbCameraRotationInfluence","1");
}

//Function Number: 96
autofocus_hipenable()
{
	common_scripts\utility::flag_wait("flag_autofocus_on");
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",1);
	}

	level.player disablephysicaldepthoffieldscripting();
	setsaveddvar("r_dof_physical_hipEnable",1);
	setsaveddvar("r_dof_physical_hipFstop",0.2);
	setsaveddvar("r_dof_physical_hipSharpCocDiameter",0.03);
	common_scripts\utility::flag_waitopen("flag_autofocus_on");
	setsaveddvar("r_dof_physical_hipEnable",0);
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",0);
	}
}