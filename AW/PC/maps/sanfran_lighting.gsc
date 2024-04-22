/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: sanfran_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 66
 * Decompile Time: 971 ms
 * Timestamp: 4/22/2024 2:35:51 AM
*******************************************************************/

//Function Number: 1
main()
{
	waittillframeend;
	common_scripts\utility::flag_init("kill_vehicle_lights");
	common_scripts\utility::flag_init("show_ship_shadows");
	thread setup_dof_presets();
	thread set_level_lighting_values();
	thread trigger_exit_tunnel();
	thread set_tunnel_lighting();
	thread set_oncoming_lighting();
	thread set_bridge_lighting();
	thread set_street_lighting();
	thread set_van_lighting();
	thread set_boost_lighting();
	if(level.currentgen)
	{
		thread showboatshadows();
	}

	thread setup_crash_events();
	thread flickering_tunnel_light();
	thread set_cargo_ship_drone_view_lighting();
	if(level.nextgen)
	{
		setsaveddvar("r_subdiv","1");
	}
}

//Function Number: 2
set_level_lighting_values()
{
	if(isusinghdr())
	{
		if(level.nextgen)
		{
			setsaveddvar("r_disableLightSets",0);
			setsaveddvar("r_hemiAoEnable",1);
		}

		if(level.currentgen)
		{
		}

		level.player lightsetforplayer("set_level_lighting_values");
	}
}

//Function Number: 3
set_intro_lighting()
{
	common_scripts\utility::flag_wait("start_intro_lighting");
	maps\_utility::vision_set_fog_changes("sanfran_drone_view",0);
	level.player lightsetforplayer("sanfran_drone_view_0");
	thread move_sunflare_back_startpoints();
	maps\_utility::delaythread(1.8,::overexposed_effect);
}

//Function Number: 4
set_cargo_ship_drone_view_lighting()
{
	common_scripts\utility::flag_wait("flag_cargo_ship");
	if(level.nextgen)
	{
		thread lerp_sun_cargo_ship();
	}

	thread overexposed_effect();
	maps\_utility::vision_set_fog_changes("sanfran_drone_view_1",0);
	wait(1);
	level.player lightsetforplayer("sanfran_drone_view_1");
}

//Function Number: 5
overexposed_effect()
{
	level.player lightsetforplayer("overexposed_effect_0");
	wait(0.25);
	level.player lightsetforplayer("overexposed_effect_1");
}

//Function Number: 6
flickering_tunnel_light()
{
	if(level.nextgen)
	{
		var_00 = getent("lighting_origin","targetname");
		var_01 = getent("light_wall_off","targetname");
		var_02 = getent("light_wall_on","targetname");
		var_03 = getent("light_wall_off_1","targetname");
		var_04 = getent("light_wall_on_1","targetname");
		var_05 = getent("light_wall_off_2","targetname");
		var_06 = getent("light_wall_on_2","targetname");
		var_02 overridelightingorigin(var_00.origin);
		var_01 overridelightingorigin(var_00.origin);
		var_04 overridelightingorigin(var_00.origin);
		var_03 overridelightingorigin(var_00.origin);
		var_06 overridelightingorigin(var_00.origin);
		var_05 overridelightingorigin(var_00.origin);
		thread maps\_lighting::model_flicker_preset("light_flicker_test",0,30000,50000,undefined,undefined,0.1,0.4,0.2,0.4);
		thread maps\_lighting::model_flicker_preset("light_flicker_test_1",0,10000,50000,undefined,undefined,0.2,0.6,0.2,0.4);
		thread maps\_lighting::model_flicker_preset("light_flicker_test_2",0,10000,50000,undefined,undefined,0.2,0.5,0.4,0.6);
	}
}

//Function Number: 7
mblur_rotation_on()
{
	setsaveddvar("r_mbEnable","2");
	setsaveddvar("r_mbCameraRotationInfluence","1");
}

//Function Number: 8
mblur_on()
{
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
	}
}

//Function Number: 9
mblur_off()
{
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
	}
}

//Function Number: 10
set_tunnel_lighting_1()
{
	if(level.nextgen)
	{
		wait(0.5);
	}
	else
	{
		wait(0.125);
	}

	level.player lightsetforplayer("set_tunnel_lighting_1");
	if(level.nextgen)
	{
		thread lerp_sun();
	}
}

//Function Number: 11
set_tunnel_lighting_2()
{
	wait(13.5);
	level.player lightsetforplayer("set_tunnel_lighting_2");
}

//Function Number: 12
showboatshadows()
{
	common_scripts\utility::flag_wait("show_ship_shadows");
	var_00 = getentarray("boat_shadows","targetname");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02))
		{
			var_02 show();
		}
	}
}

//Function Number: 13
hideboatshadows()
{
	var_00 = getentarray("boat_shadows","targetname");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02))
		{
			var_02 hide();
		}
	}
}

//Function Number: 14
set_tunnel_lighting()
{
	common_scripts\utility::flag_wait("start_tunnel_lighting");
	thread tunnel_sequence_dof();
	if(level.nextgen)
	{
		level.player lightsetforplayer("set_tunnel_lighting_0");
	}

	if(level.nextgen)
	{
		thread mblur_rotation_on();
		thread maps\_lighting::set_spot_intensity("intro_car_light",100500);
		level.player setclutforplayer("clut_sanfran_tunnel",0);
		wait(3);
		maps\_utility::vision_set_changes("sanfran_neutral",1);
		maps\_utility::fog_set_changes("sanfran_tunnel",1);
	}
	else
	{
		wait(0.25);
		maps\_utility::vision_set_fog_changes("sanfran_tunnel",0);
	}

	thread set_tunnel_lighting_2();
	thread set_tunnel_lighting_1();
	thread setup_vfx_sunflare();
	thread setup_pitbull_vfx_lights();
	thread pitbull_headlights_on();
}

//Function Number: 15
setup_hud_lighting()
{
	var_00 = (3,-40,-2);
	var_01 = (3,3,-2);
	var_02 = common_scripts\utility::spawn_tag_origin();
	var_02 linkto(level.player_pitbull.fake_vehicle_model,"tag_lt_window_hud",var_00,(0,0,0));
	playfxontag(common_scripts\utility::getfx("lt_pt_pitbull_hud"),var_02,"TAG_ORIGIN");
	wait(0.5);
	var_03 = 0.5;
	var_04 = 0;
	while(var_04 < var_03)
	{
		var_05 = var_04 / var_03;
		var_06 = vectorlerp(var_00,var_01,var_05);
		var_02 linkto(level.player_pitbull.fake_vehicle_model,"tag_lt_window_hud",var_06,(0,0,0));
		wait(0.05);
		var_04 = var_04 + 0.05;
	}

	var_00 = (3,3,-2);
	var_01 = (3,-45,-2);
	wait(10.2);
	var_03 = 0.4;
	var_04 = 0;
	while(var_04 < var_03)
	{
		var_05 = var_04 / var_03;
		var_06 = vectorlerp(var_00,var_01,var_05);
		var_02 linkto(level.player_pitbull.fake_vehicle_model,"tag_lt_window_hud",var_06,(0,0,0));
		wait(0.05);
		var_04 = var_04 + 0.05;
	}

	wait(1);
	var_00 = (3,-45,-2);
	var_01 = (3,-50,5);
	var_03 = 0.4;
	var_04 = 0;
	while(var_04 < var_03)
	{
		var_05 = var_04 / var_03;
		var_06 = vectorlerp(var_00,var_01,var_05);
		var_02 linkto(level.player_pitbull.fake_vehicle_model,"tag_lt_window_hud",var_06,(0,0,0));
		wait(0.05);
		var_04 = var_04 + 0.05;
	}

	var_02 delete();
	common_scripts\utility::flag_set("kill_vehicle_lights");
	if(level.currentgen)
	{
		common_scripts\utility::flag_set("show_ship_shadows");
	}
}

//Function Number: 16
setup_car_passing_lights()
{
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00 linkto(self,"TAG_BRAKELIGHT_LEFT",(0,0,0),(0,-90,0));
	playfxontag(common_scripts\utility::getfx("lt_pt_tunnel_car_pass"),var_00,"TAG_ORIGIN");
	common_scripts\utility::flag_wait("kill_vehicle_lights");
	stopfxontag(common_scripts\utility::getfx("lt_pt_tunnel_car_pass"),var_00,"TAG_ORIGIN");
	var_00 delete();
}

//Function Number: 17
set_oncoming_lighting()
{
	common_scripts\utility::flag_wait("start_oncoming_lighting");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_sanfran_exterior",0);
		maps\_utility::vision_set_changes("sanfran_neutral",1);
		maps\_utility::fog_set_changes("sanfran_oncoming",1);
		thread mblur_on();
	}
	else
	{
		maps\_utility::vision_set_changes("sanfran_oncoming",1);
	}

	level.player lightsetforplayer("setup_drive_shadows");
	thread setup_pitbull_vfx_lights();
	thread setup_vfx_sunflare();
	thread move_sunflare_back_startpoints();
	thread pitbull_drive_dof();
	wait(0.1);
	thread script_probe_pitbull_tunnel_exterior_no_trigger();
}

//Function Number: 18
set_bridge_lighting()
{
	common_scripts\utility::flag_wait("start_bridge_lighting");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_sanfran_exterior",0);
		maps\_utility::vision_set_changes("sanfran_neutral",1);
		maps\_utility::fog_set_changes("sanfran_oncoming",1);
		thread mblur_on();
	}
	else
	{
		maps\_utility::vision_set_changes("sanfran_oncoming",1);
	}

	level.player lightsetforplayer("setup_drive_shadows");
	thread setup_pitbull_vfx_lights();
	thread setup_vfx_sunflare();
	thread move_sunflare_back_startpoints();
	thread pitbull_drive_dof();
	wait(0.1);
	thread script_probe_pitbull_tunnel_exterior_no_trigger();
}

//Function Number: 19
set_street_lighting()
{
	common_scripts\utility::flag_wait("start_street_lighting");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_sanfran_exterior",0);
		maps\_utility::vision_set_changes("sanfran_neutral",1);
		maps\_utility::fog_set_changes("sanfran",1);
	}
	else
	{
		maps\_utility::vision_set_changes("sanfran_oncoming",1);
	}

	level.player lightsetforplayer("set_street_lighting");
	thread setup_vfx_sunflare();
	thread move_sunflare_back_startpoints();
}

//Function Number: 20
set_van_lighting()
{
	common_scripts\utility::flag_wait("start_van_lighting");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_sanfran_exterior",0);
		maps\_utility::vision_set_changes("sanfran_neutral",1);
		maps\_utility::fog_set_changes("sanfran",1);
	}
	else
	{
		maps\_utility::vision_set_changes("sanfran_oncoming",1);
	}

	level.player lightsetforplayer("set_street_lighting");
	thread setup_vfx_sunflare();
	thread move_sunflare_back_startpoints();
}

//Function Number: 21
set_boost_lighting()
{
	common_scripts\utility::flag_wait("start_boost_lighting");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_sanfran_exterior",0);
		maps\_utility::vision_set_changes("sanfran_neutral",1);
		maps\_utility::fog_set_changes("sanfran",1);
	}
	else
	{
		maps\_utility::vision_set_changes("sanfran_oncoming",1);
	}

	level.player lightsetforplayer("set_boost_lighting");
	thread setup_vfx_sunflare();
	thread move_sunflare_back_startpoints();
	thread boost_setup_desat();
	common_scripts\utility::flag_set("flag_van_explosion_start");
}

//Function Number: 22
bridge_collapse_screen_effects()
{
	thread bc_initial_blur();
	thread bc_explosion_vision();
	thread bridge_collapse_sequence();
	maps\_utility::delaythread(0.2,::headless_shadow_tweak);
	maps\_utility::delaythread(1.2,::car_hit_shadows);
	maps\_utility::delaythread(1.3,::car_hit_blur);
	maps\_utility::delaythread(23,::bc_shadow_tweak);
}

//Function Number: 23
trigger_exit_tunnel()
{
	common_scripts\utility::run_thread_on_targetname("exit_tunnel",::script_probe_pitbull_tunnel_exterior);
	common_scripts\utility::run_thread_on_targetname("exit_tunnel",::move_sunflare_back);
	common_scripts\utility::run_thread_on_targetname("exit_tunnel",::vision_set_sanfran);
	common_scripts\utility::run_thread_on_targetname("exit_tunnel",::setup_drive_shadows);
	common_scripts\utility::run_thread_on_targetname("exit_tunnel",::pitbull_headlights_off);
	common_scripts\utility::run_thread_on_targetname("exit_tunnel",::disable_bokeh);
}

//Function Number: 24
intro_rack_focus_dof()
{
	if(level.nextgen)
	{
		maps\_lighting::blend_dof_presets("default","intro_out_of_focus",0.05);
		wait(6.5);
		maps\_lighting::blend_dof_presets("intro_out_of_focus","intro_bg_in_focus",0.5);
		wait(2.5);
		maps\_lighting::blend_dof_presets("intro_bg_in_focus","intro_all_in_focus",1);
		thread intro_zoom_in_out_fleet();
		return;
	}

	thread intro_zoom_in_out_fleet();
}

//Function Number: 25
intro_zoom_in_out_fleet()
{
	common_scripts\utility::flag_wait("flag_zoom_in_fleet");
	if(level.nextgen)
	{
		maps\_lighting::blend_dof_presets("intro_all_in_focus","intro_zoom_out_focus",0.05);
		wait(0.5);
		maps\_lighting::blend_dof_presets("intro_zoom_out_focus","intro_zoom_in_focus",0.1);
		common_scripts\utility::flag_wait("flag_zoom_out_fleet");
		maps\_lighting::blend_dof_presets("intro_zoom_in_focus","intro_bg_in_focus",0.05);
		return;
	}

	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(2,23);
	wait(6.5);
	level.player setphysicaldepthoffield(2,23);
	wait(2.5);
	level.player setphysicaldepthoffield(2,23);
	wait(2.5);
	level.player disablephysicaldepthoffieldscripting();
}

//Function Number: 26
intro_rack_focus_cargo_dof()
{
	if(level.nextgen)
	{
		maps\_lighting::blend_dof_presets("intro_bg_in_focus","cargo_in_focus",0.1);
		common_scripts\utility::flag_wait("flag_zoom_in_cargo");
		maps\_lighting::blend_dof_presets("cargo_in_focus","cargo_out_focus",0.05);
		wait(0.5);
		maps\_lighting::blend_dof_presets("cargo_out_focus","cargo_in_focus",0.1);
		common_scripts\utility::flag_wait("flag_zoom_out_cargo");
		maps\_lighting::blend_dof_presets("cargo_in_focus","cargo_out_focus",0.05);
		wait(0.5);
		maps\_lighting::blend_dof_presets("cargo_out_focus","cargo_in_focus",0.1);
		return;
	}

	common_scripts\utility::flag_wait("flag_zoom_in_cargo");
	wait(0.5);
	common_scripts\utility::flag_wait("flag_zoom_out_cargo");
	wait(0.5);
}

//Function Number: 27
bc_explosion_vision()
{
	level.player lightsetforplayer("overexposed_effect_2");
	wait(0.05);
	level.player lightsetforplayer("set_van_lighting");
}

//Function Number: 28
bc_initial_blur()
{
	setblur(2,0);
	wait(0.5);
	setblur(0,1);
}

//Function Number: 29
headless_shadow_tweak()
{
	level.defaultsundir = getmapsunangles();
	lerpsunangles(level.defaultsundir,(-88,127.1,0),0.01);
	wait(2);
	lerpsunangles((-88,127.1,0),level.defaultsundir,1);
	wait(1.5);
	resetsundirection();
}

//Function Number: 30
car_hit_shadows()
{
	level.player lightsetforplayer("car_hit_shadows_0");
	wait(3);
	level.player lightsetforplayer("car_hit_shadows_1");
	wait(27);
	level.player lightsetforplayer("car_hit_shadows_2");
	wait(8);
	level.player lightsetforplayer("car_hit_shadows_1");
	wait(12.2);
	level.player lightsetforplayer("car_hit_shadows_2");
}

//Function Number: 31
car_hit_blur()
{
	setblur(3,0);
	wait(0.5);
	setblur(0,1);
}

//Function Number: 32
van_knockback_blur()
{
	setblur(3,0);
	wait(0.5);
	setblur(0,1.5);
}

//Function Number: 33
bc_shadow_tweak()
{
	maps\_utility::lerp_saveddvar("sm_sunSampleSizeNear",0.15,1);
	wait(13);
	maps\_utility::lerp_saveddvar("sm_sunSampleSizeNear",0.09,1);
	wait(4.5);
	maps\_utility::lerp_saveddvar("sm_sunSampleSizeNear",0.25,1);
	wait(8.5);
	maps\_utility::lerp_saveddvar("sm_sunSampleSizeNear",0.08,1);
}

//Function Number: 34
tunnel_sequence_dof()
{
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",1);
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(2.5,20,30);
		wait(3.5);
		level.player setphysicaldepthoffield(2.5,40,2);
		wait(11);
		level.player disablephysicaldepthoffieldscripting();
	}
	else
	{
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(2.8,38,30);
		wait(3.5);
		level.player setphysicaldepthoffield(2.5,40,2);
		wait(11);
		level.player disablephysicaldepthoffieldscripting();
	}

	if(level.nextgen)
	{
		wait(3.5);
		wait(11);
	}

	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",0);
		setsaveddvar("r_dof_physical_hipEnable",1);
		setsaveddvar("r_dof_physical_hipFstop",6);
		setsaveddvar("r_dof_physical_hipSharpCocDiameter",0.03);
		setsaveddvar("r_mbCameraRotationInfluence","0");
	}
	else
	{
	}

	common_scripts\utility::flag_set("kill_vehicle_lights");
}

//Function Number: 35
pitbull_drive_dof()
{
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_hipEnable",1);
		setsaveddvar("r_dof_physical_hipFstop",6);
		setsaveddvar("r_dof_physical_hipSharpCocDiameter",0.03);
	}
}

//Function Number: 36
pitbull_atlas_impact_initial(param_00)
{
	thread pitbull_impact_blur();
}

//Function Number: 37
pitbull_atlas_impact(param_00)
{
	thread pitbull_impact_blur();
}

//Function Number: 38
pitbull_crash_jump_start(param_00)
{
	thread pitbull_impact_blur();
}

//Function Number: 39
pitbull_roof_impact(param_00)
{
	thread pitbull_impact_blur();
	wait(1.6);
	thread pitbull_impact_blur();
}

//Function Number: 40
pitbull_crashed_dof()
{
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",1);
		setsaveddvar("r_dof_physical_hipEnable",0);
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(1.5,25,5);
		wait(15);
		level.player setphysicaldepthoffield(0.75,88,3);
		wait(7.5);
		level.player disablephysicaldepthoffieldscripting();
		thread mblur_off();
	}
	else
	{
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(1.5,25,5);
		wait(15);
		level.player setphysicaldepthoffield(0.75,88,3);
		wait(7.5);
		thread mblur_off();
		level.player disablephysicaldepthoffieldscripting();
	}

	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",0);
	}
}

//Function Number: 41
pitbull_impact_blur()
{
	setblur(3,0);
	wait(0.6);
	setblur(0,0.8);
}

//Function Number: 42
pitbull_impact_blur_long()
{
	setblur(3,0);
	wait(1.2);
	setblur(0,2);
}

//Function Number: 43
pitbull_headlights_on()
{
	common_scripts\utility::flag_wait("kill_vehicle_lights");
	wait(0.6);
	level.origin_pitbull_headlight = common_scripts\utility::spawn_tag_origin();
	level.origin_pitbull_headlight linkto(level.player_pitbull.fake_vehicle_model,"tag_headlight_right",(5,10,3),(7,0,0));
	playfxontag(common_scripts\utility::getfx("light_sanfran_pitbull_headlight"),level.origin_pitbull_headlight,"TAG_ORIGIN");
}

//Function Number: 44
pitbull_headlights_off()
{
	self waittill("trigger");
	killfxontag(common_scripts\utility::getfx("light_sanfran_pitbull_headlight"),level.origin_pitbull_headlight,"TAG_ORIGIN");
	level.origin_pitbull_headlight delete();
}

//Function Number: 45
friendly_pitbull_headlights_on()
{
	common_scripts\utility::flag_wait("kill_vehicle_lights");
	level.origin_friendly_pitbull_headlight = common_scripts\utility::spawn_tag_origin();
	level.origin_friendly_pitbull_headlight linkto(level.friendly_pitbull,"tag_headlight_right",(0,0,0),(0,0,0));
	playfxontag(common_scripts\utility::getfx("light_sanfran_pitbull_headlight"),level.origin_friendly_pitbull_headlight,"TAG_ORIGIN");
}

//Function Number: 46
friendly_pitbull_headlights_off()
{
	self waittill("trigger");
	killfxontag(common_scripts\utility::getfx("light_sanfran_pitbull_headlight"),level.origin_friendly_pitbull_headlight,"TAG_ORIGIN");
	level.origin_friendly_pitbull_headlight delete();
}

//Function Number: 47
disable_bokeh()
{
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",0);
	}
}

//Function Number: 48
van_open_bridge_collapse_dof()
{
	if(level.nextgen)
	{
		thread mblur_rotation_on();
		setsaveddvar("r_dof_physical_bokehEnable",1);
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(3.5,23,10);
		wait(3);
		level.player setphysicaldepthoffield(3.5,13,10);
		wait(5.2);
		thread van_knockback_blur();
		wait(1.5);
		level.player setphysicaldepthoffield(1.5,123,5);
		wait(11);
		level.player setphysicaldepthoffield(2.5,1500,5);
		wait(7);
		level.player setphysicaldepthoffield(2.5,40,5);
		wait(3.5);
		level.player setphysicaldepthoffield(2.5,1500,5);
		wait(21);
		level.player setphysicaldepthoffield(2,35,5);
		wait(13);
		level.player setphysicaldepthoffield(2.5,40,5);
		wait(5);
		level.player setphysicaldepthoffield(2.5,1500,5);
		wait(8);
		level.player setphysicaldepthoffield(1.5,64,5);
		wait(10);
		level.player disablephysicaldepthoffieldscripting();
		return;
	}

	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(3.5,23,10);
	wait(3);
	level.player setphysicaldepthoffield(3.5,13,10);
	wait(5.2);
	wait(1.5);
	level.player setphysicaldepthoffield(1.5,123,5);
	wait(11);
	level.player setphysicaldepthoffield(2.5,1500,5);
	wait(7);
	level.player setphysicaldepthoffield(2.5,40,5);
	wait(3.5);
	level.player setphysicaldepthoffield(2.5,1500,5);
	wait(21);
	level.player setphysicaldepthoffield(2,35,5);
	wait(13);
	level.player setphysicaldepthoffield(2.5,40,5);
	wait(5);
	level.player setphysicaldepthoffield(2.5,1500,5);
	wait(8);
	level.player setphysicaldepthoffield(1.5,64,5);
	wait(10);
	level.player disablephysicaldepthoffieldscripting();
}

//Function Number: 49
bridge_collapse_sequence()
{
	common_scripts\_exploder::exploder(9521);
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_sanfran_exterior",6);
	}

	wait(8);
	wait(14.5);
	if(level.currentgen)
	{
		level.player lightsetforplayer("set_boost_lighting");
	}

	wait(20);
	wait(8.75);
	thread burke_rim_lights();
	wait(1);
	thread boost_setup_desat();
	wait(8);
	common_scripts\_exploder::kill_exploder(9521);
}

//Function Number: 50
attach_light_to_police_car(param_00)
{
	if(isdefined(param_00.car_light))
	{
		param_00.car_light delete();
	}

	param_00.car_light = common_scripts\utility::spawn_tag_origin();
	var_01 = param_00.car_light;
	var_01 linkto(param_00,"TAG_ORIGIN",(0,0,0),(0,0,0));
	playfxontag(common_scripts\utility::getfx("light_sedan_police_scroll"),var_01,"tag_origin");
	level waittill("kill_barricade_copcar_lights");
	stopfxontag(common_scripts\utility::getfx("light_sedan_police_scroll"),var_01,"tag_origin");
}

//Function Number: 51
burke_rim_lights()
{
	var_00 = level.burke;
	if(isdefined(var_00.helmet_tag))
	{
		var_00.helmet_tag delete();
	}

	if(isdefined(var_00.helmet_tag2))
	{
		var_00.helmet_tag2 delete();
	}

	var_00.helmet_tag = common_scripts\utility::spawn_tag_origin();
	var_01 = var_00.helmet_tag;
	var_00.helmet_tag2 = common_scripts\utility::spawn_tag_origin();
	var_02 = var_00.helmet_tag2;
	var_01 linkto(var_00,"J_Head",(3,-5,5),(0,0,0),0);
	var_02 linkto(var_00,"J_Head",(3,-5,-5),(0,0,0),0);
}

//Function Number: 52
boost_setup_desat()
{
	if(level.nextgen)
	{
		maps\_utility::vision_set_changes("sanfran_neutral",3);
		maps\_utility::fog_set_changes("sanfran",3);
		return;
	}

	maps\_utility::vision_set_fog_changes("sanfran_boost_desat",3);
}

//Function Number: 53
setup_dof_presets()
{
	maps\_lighting::create_dof_preset("intro_out_of_focus",1500,2000,6,2001,7000,1,0.5);
	maps\_lighting::create_dof_preset("intro_fg_in_focus",760,1820,6,1880,7000,5.5,0.5);
	maps\_lighting::create_dof_preset("intro_bg_in_focus",2000,5450,6,16500,150000,1,0.5);
	maps\_lighting::create_dof_preset("intro_all_in_focus",0,30,4,14140,130000,1,0.5);
	maps\_lighting::create_dof_preset("intro_zoom_out_focus",3000,5000,6.5,5020,6750,6,0.5);
	maps\_lighting::create_dof_preset("intro_zoom_in_focus",3000,6200,6.5,18500,150000,6,0.5);
	maps\_lighting::create_dof_preset("cargo_in_focus",2100,4100,6.3,12150,14680,1.8,0.5);
	maps\_lighting::create_dof_preset("cargo_out_focus",330,2000,6.3,2010,6468,5.5,0.5);
	maps\_lighting::create_dof_preset("tunnel_start",8,23,5,1500,2000,0.3,0.5);
	maps\_lighting::create_dof_preset("tunnel_hud_moment",5,21,5,590,1220,4,0.5);
	maps\_lighting::create_dof_preset("pitbull_drive",0,65,4,3000,37590,1.8,0.5);
	maps\_lighting::create_dof_preset("pitbull_crashed",0,100,4,200,4000,1.5,0.5);
	maps\_lighting::create_dof_preset("bridge_section_01",0,100,4,6000,31000,1.5,0);
	maps\_lighting::create_dof_preset("van_door_approach",0,1,4,52,580,1.8,0.5);
	maps\_lighting::create_dof_preset("van_drones_fly",0,1,4,2000,7100,1.8,0.5);
	maps\_lighting::create_dof_preset("van_bridge_explode",0,240,4,2000,7100,1.8,0.5);
	maps\_lighting::create_dof_preset("bc_knockback",0,30,4,100,720,4,0.5);
	maps\_lighting::create_dof_preset("bc_watch_breakage",25,420,4,2000,18000,2,0.5);
	maps\_lighting::create_dof_preset("bc_catch_moment",1,20,5,20,295,2.7,0.5);
	maps\_lighting::create_dof_preset("bc_bus_overboard",25,215,4,5000,9000,4,0.5);
	maps\_lighting::create_dof_preset("bc_jump_in",10,60,4,61,100,2,0.5);
	maps\_lighting::create_dof_preset("dof_disable",0,10,0,5000,20000,0,0.5);
}

//Function Number: 54
setup_crash_events()
{
	common_scripts\utility::flag_wait("flag_player_crashed");
	thread script_probe_pitbull_default();
	level.defaultsundir = getmapsunangles();
	lerpsunangles(level.defaultsundir,(-24.5,125,0),1);
	if(level.nextgen)
	{
		maps\_utility::fog_set_changes("sanfran",1);
	}
	else
	{
		maps\_utility::vision_set_fog_changes("sanfran",0);
	}

	thread pitbull_crashed_dof();
	level.player lightsetforplayer("setup_crash_events");
	wait(5);
	wait(9.25);
	level.player lightsetforplayer("after_crash");
	wait(7.5);
	lerpsunangles((-24.5,125,0),level.defaultsundir,0.25);
	level.player lightsetforplayer("set_street_lighting");
	wait(2.5);
	resetsundirection();
}

//Function Number: 55
lerp_sun()
{
	resetsundirection();
}

//Function Number: 56
lerp_sun_cargo_ship()
{
	lerpsunangles((-24.5,127.1,0),(-20,160,0),0.01,0,0);
}

//Function Number: 57
script_probe_pitbull_tunnel_interior()
{
	var_00 = getent("refl_pitbull_tunnel_interior","targetname");
	level.burke overridereflectionprobe(var_00.origin);
	level.saint overridereflectionprobe(var_00.origin);
	level.player_pitbull.fake_vehicle_model overridereflectionprobe(var_00.origin);
	level.player_pitbull.player_rig overridereflectionprobe(var_00.origin);
	var_01 = getent("lighting_centroid_burke","targetname");
	level.burke overridelightingorigin(var_01.origin);
}

//Function Number: 58
script_probe_pitbull_tunnel_exterior()
{
	self waittill("trigger");
	var_00 = getent("refl_pitbull_tunnel_exterior","targetname");
	level.burke overridereflectionprobe(var_00.origin);
	level.burke defaultlightingorigin();
	level.saint overridereflectionprobe(var_00.origin);
	level.player_pitbull.fake_vehicle_model overridereflectionprobe(var_00.origin);
	level.player_pitbull.player_rig overridereflectionprobe(var_00.origin);
}

//Function Number: 59
script_probe_pitbull_tunnel_exterior_no_trigger()
{
	var_00 = getent("refl_pitbull_tunnel_exterior","targetname");
	level.burke overridereflectionprobe(var_00.origin);
	level.saint overridereflectionprobe(var_00.origin);
	level.player_pitbull.fake_vehicle_model overridereflectionprobe(var_00.origin);
	level.player_pitbull.player_rig overridereflectionprobe(var_00.origin);
}

//Function Number: 60
script_probe_pitbull_default()
{
	level.burke defaultreflectionprobe();
	level.saint defaultreflectionprobe();
	level.player_pitbull.fake_vehicle_model defaultreflectionprobe();
	level.player_pitbull.player_rig defaultreflectionprobe();
}

//Function Number: 61
setup_pitbull_vfx_lights()
{
	var_00 = level.burke;
	if(isdefined(var_00.helmet_tag))
	{
		var_00.helmet_tag delete();
	}

	var_00.helmet_tag = common_scripts\utility::spawn_tag_origin();
	var_01 = var_00.helmet_tag;
	var_01 linkto(var_00,"J_Head",(5,-10,0),(0,0,0),0);
}

//Function Number: 62
setup_vfx_sunflare()
{
	thread maps\_shg_fx::vfx_sunflare("sanfran_sunflare_a");
}

//Function Number: 63
move_sunflare_back()
{
	self waittill("trigger");
	setsunflareposition((-24.5,127.1,0));
}

//Function Number: 64
move_sunflare_back_startpoints()
{
	setsunflareposition((-24.5,127.1,0));
}

//Function Number: 65
vision_set_sanfran()
{
	self waittill("trigger");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_sanfran_exterior",1);
		maps\_utility::vision_set_changes("sanfran_neutral",1);
		maps\_utility::fog_set_changes("sanfran_oncoming",1);
		return;
	}

	maps\_utility::vision_set_changes("sanfran_oncoming",1);
}

//Function Number: 66
setup_drive_shadows()
{
	self waittill("trigger");
	level.player lightsetforplayer("setup_drive_shadows");
}