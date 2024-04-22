/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: irons_estate_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 40
 * Decompile Time: 582 ms
 * Timestamp: 4/22/2024 2:32:01 AM
*******************************************************************/

//Function Number: 1
lighting_begin_preload()
{
	common_scripts\utility::flag_init("intro_begin");
	common_scripts\utility::flag_init("player_under_car");
	common_scripts\utility::flag_init("introscreen1_complete");
	common_scripts\utility::flag_init("player_grappled_to_vtol");
}

//Function Number: 2
main()
{
	thread lighting_begin_preload();
	thread setup_flickerlight_motion_presets();
	thread set_level_lighting_values();
	thread set_hemi_ao();
	thread irons_estate_vignette();
	thread irons_estate_outside_vision_setup();
	thread irons_estate_briefing_setup();
	thread lerp_spot_briefing();
	thread force_bounce_on_briefing_hanger();
	thread force_bounce_on_briefing_hanger_02();
	thread irons_estate_waterfall_cave_setup();
	thread irons_estate_waterfall_setup();
	thread irons_estate_waterfall_debug_checkpoint();
	thread irons_estate_intro_reveal_setup();
	thread irons_estate_intro_reveal_setup_debug_checkpoint();
	thread irons_estate_tutorial_setup();
	thread irons_estate_recon_setup();
	thread irons_estate_security_center_setup();
	thread irons_estate_security_center_debug_checkpoint();
	thread irons_estate_security_center_exit_setup();
	thread garage_door_shut_off();
	thread irons_estate_penthouse_setup();
	if(level.currentgen)
	{
		thread irons_estate_penthouse_cormack_setup();
	}

	thread irons_estate_intel_debug_checkpoint();
	thread irons_estate_elevator_dof();
	thread irons_estate_car_setup();
	thread irons_estate_hanger_setup();
	thread force_bounce_on();
	thread plant_tracker_debug_checkpoint();
	thread irons_estate_exfil_setup();
	thread plant_tracker_light_model_swap();
	thread irons_estate_plane_setup();
	thread irons_estate_underwater_setup();
	if(level.start_point == "briefing" || level.start_point == "intro" || level.start_point == "grapple" || level.start_point == "recon" || level.start_point == "infil" || level.start_point == "security_center" || level.start_point == "hack_security")
	{
		thread set_security_lights();
		thread set_security_center_tv();
	}
}

//Function Number: 3
setup_flickerlight_motion_presets()
{
	if(level.nextgen)
	{
		maps\_lighting::create_flickerlight_motion_preset("water_motion_large",(0.83,0.94,1),710,1,0.1,0.12);
		maps\_lighting::create_flickerlight_motion_preset("fire_motion_medium",(1,0.2246,0),600,2,0.1,0.2);
		return;
	}

	maps\_lighting::create_flickerlight_motion_preset("water_motion_large",(0.55,0.83,1),2000,1,0.1,0.12);
	maps\_lighting::create_flickerlight_motion_preset("fire_motion_medium",(1,0.2246,0),3000,2,0.05,0.2);
}

//Function Number: 4
set_level_lighting_values()
{
	if(isusinghdr())
	{
		setsaveddvar("r_disableLightSets",0);
		level.player lightsetforplayer("irons_estate");
	}

	if(level.currentgen)
	{
		setsaveddvar("r_gunSightColorEntityScale",0.7);
		setsaveddvar("r_gunSightColorNoneScale",0.2);
	}
}

//Function Number: 5
set_hemi_ao()
{
	if(level.nextgen)
	{
		setsaveddvar("r_hemiAoEnable",1);
	}
}

//Function Number: 6
irons_estate_vignette()
{
	level.player thread maps\_lighting::screen_effect_base(0,"ac130_overlay_pip_vignette",0,0,1,0,0);
}

//Function Number: 7
irons_estate_outside_vision_setup()
{
	level.player lightsetforplayer("irons_estate");
	maps\_utility::vision_set_fog_changes("irons_estate",0);
	level.player setclutforplayer("clut_base_default",0);
}

//Function Number: 8
irons_estate_briefing_setup()
{
	common_scripts\utility::flag_wait("introscreen1_complete");
	level.player lightsetforplayer("irons_estate_briefing");
	maps\_utility::vision_set_fog_changes("irons_estate_briefing",0);
	level.player setclutforplayer("clut_base_briefing",0);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbVelocityScalar","1");
	}

	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(13,27,1,1);
	wait(8);
	level.player setphysicaldepthoffield(11,27,1,1);
	level waittill("player_can_move");
	level.player disablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
	}

	maps\_lighting::lerp_spot_intensity("Illona_briefing_fill",1,0);
	maps\_lighting::lerp_spot_intensity("Illona_briefing_bounce",1,0);
}

//Function Number: 9
lerp_spot_briefing()
{
	common_scripts\utility::flag_wait("introscreen1_complete");
	wait(26);
	if(level.nextgen)
	{
		maps\_lighting::lerp_spot_intensity("cormack_briefing_shadow",1,0);
	}
}

//Function Number: 10
force_bounce_on_briefing_hanger()
{
	if(level.nextgen)
	{
		var_00 = getent("briefing_hanger_lod","targetname");
		var_00 setlightshadowstate("force_on");
		common_scripts\utility::flag_wait("intro_begin");
		var_00 setlightshadowstate("force_off");
	}
}

//Function Number: 11
force_bounce_on_briefing_hanger_02()
{
	if(level.nextgen)
	{
		var_00 = getent("briefing_hanger_lod_02","targetname");
		var_00 setlightshadowstate("force_on");
		common_scripts\utility::flag_wait("intro_begin");
		var_00 setlightshadowstate("force_off");
	}
}

//Function Number: 12
irons_estate_waterfall_cave_setup()
{
	common_scripts\utility::flag_wait("intro_begin");
	maps\_lighting::play_flickerlight_motion_preset("water_motion_large","water_shim_01");
	level.player lightsetforplayer("irons_estate_waterfall_intro");
	if(level.nextgen)
	{
		maps\_utility::vision_set_fog_changes("irons_estate_waterfall_intro",0);
		level.player setclutforplayer("clut_base_default",0);
	}
	else
	{
		maps\_utility::vision_set_fog_changes("irons_estate_waterfall_intro",0.1);
		level.player setclutforplayer("clut_base_cave",0.1);
	}

	common_scripts\utility::flag_wait("drone_passed");
	setsunflareposition((-44.0771,52.229,0));
}

//Function Number: 13
irons_estate_waterfall_setup()
{
	common_scripts\utility::flag_wait("intro_waterfall_dof");
	maps\_lighting::play_flickerlight_motion_preset("water_motion_large","water_shim_01");
	level.player lightsetforplayer("irons_estate_waterfall");
	maps\_utility::vision_set_fog_changes("irons_estate_waterfall",2);
	level.player setclutforplayer("clut_base_default",2);
	setsunflareposition((-44.0771,52.229,0));
	common_scripts\utility::flag_wait("water_shim_off");
	maps\_lighting::stop_flickerlight("water_motion_large","water_shim_01",0);
}

//Function Number: 14
irons_estate_waterfall_debug_checkpoint()
{
	common_scripts\utility::flag_wait("grapple_debug");
	maps\_lighting::play_flickerlight_motion_preset("water_motion_large","water_shim_01");
	level.player lightsetforplayer("irons_estate_waterfall");
	maps\_utility::vision_set_fog_changes("irons_estate_waterfall",2);
	level.player setclutforplayer("clut_base_default",2);
	setsunflareposition((-44.0771,52.229,0));
	common_scripts\utility::flag_wait("water_shim_off");
	maps\_lighting::stop_flickerlight("water_motion_large","water_shim_01",0);
}

//Function Number: 15
irons_estate_intro_reveal_setup()
{
	common_scripts\utility::flag_wait("spawn_infil_enemies");
	level.player lightsetforplayer("irons_estate_intro_reveal");
	maps\_utility::vision_set_fog_changes("irons_estate_intro_reveal",0.1);
	level.player setclutforplayer("clut_base_default",0.1);
	setsunflareposition((-44.0771,52.229,0));
}

//Function Number: 16
irons_estate_intro_reveal_setup_debug_checkpoint()
{
	common_scripts\utility::flag_wait("irons_estate_recon_dof");
	level.player lightsetforplayer("irons_estate_intro_reveal");
	maps\_utility::vision_set_fog_changes("irons_estate_intro_reveal",0);
	level.player setclutforplayer("clut_base_default",0);
	setsunflareposition((-44.0771,52.229,0));
}

//Function Number: 17
irons_estate_tutorial_setup()
{
	common_scripts\utility::flag_wait("irons_estate_tutorial_dof");
	level.player lightsetforplayer("irons_estate_tutorial");
	maps\_utility::vision_set_fog_changes("irons_estate_tutorial",1);
	level.player setclutforplayer("clut_base_default",1);
	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(1.12,548,1,1);
	common_scripts\utility::flag_wait("stealth_display_tutorial_over");
	level.player disablephysicaldepthoffieldscripting();
	setsunflareposition((-44.0771,52.229,0));
}

//Function Number: 18
irons_estate_recon_setup()
{
	common_scripts\utility::flag_wait("irons_estate_tutorial_end");
	level.player lightsetforplayer("irons_estate");
	maps\_utility::vision_set_fog_changes("irons_estate",2);
	level.player setclutforplayer("clut_base_default",2);
	setsunflareposition((-44.0771,52.229,0));
}

//Function Number: 19
irons_estate_security_center_setup()
{
	level waittill("player_planting_emp");
	setsaveddvar("r_mbEnable","2");
	setsaveddvar("r_mbCameraRotationInfluence","1");
	setsaveddvar("r_mbVelocityScalar","1");
	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(8,15,1,1);
	common_scripts\utility::flag_wait("security_center_enter_anim_done");
	level.player disablephysicaldepthoffieldscripting();
	setsaveddvar("r_mbEnable","0");
	level.player lightsetforplayer("irons_estate_security_center");
	maps\_utility::vision_set_fog_changes("irons_estate_security_center",2);
	level.player setclutforplayer("clut_base_security_center",2);
	common_scripts\utility::flag_wait("handprint_start");
	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(17,0,1,1);
	wait(3);
	level.player disablephysicaldepthoffieldscripting();
	setsunflareposition((-45,-15,0));
}

//Function Number: 20
irons_estate_security_center_debug_checkpoint()
{
	common_scripts\utility::flag_wait("inside_security_center");
	level.player lightsetforplayer("irons_estate_security_center");
	maps\_utility::vision_set_fog_changes("irons_estate_security_center",0);
	level.player setclutforplayer("clut_base_security_center",0);
	setsunflareposition((-44.0771,52.229,0));
	common_scripts\utility::flag_wait("handprint_start");
	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(17,0,1,1);
	wait(3);
	level.player disablephysicaldepthoffieldscripting();
}

//Function Number: 21
irons_estate_penthouse_cormack_setup()
{
}

//Function Number: 22
irons_estate_security_center_exit_setup()
{
	common_scripts\utility::flag_wait("outside_security_center");
	level.player lightsetforplayer("irons_estate");
	maps\_utility::vision_set_fog_changes("irons_estate",10);
	level.player setclutforplayer("clut_base_default",10);
	setsunflareposition((-44.0771,52.229,0));
	common_scripts\utility::flag_wait("firelight_on");
	maps\_lighting::play_flickerlight_motion_preset("fire_motion_medium","fireplace_01");
}

//Function Number: 23
garage_door_shut_off()
{
	var_00 = getent("garage_light_source_off","targetname");
	var_01 = getent("garage_light_source_on","targetname");
	var_01 show();
	var_00 hide();
	common_scripts\utility::flag_wait("garage_door_light_off");
	var_00 show();
	var_01 hide();
	var_02 = getent("garage_door_light","targetname");
	var_02 setlightintensity(0);
}

//Function Number: 24
irons_estate_penthouse_setup()
{
	common_scripts\utility::flag_wait("irons_estate_penthouse_dof");
	maps\_lighting::play_flickerlight_motion_preset("fire_motion_medium","fireplace_01");
	level.player lightsetforplayer("irons_estate_penthouse");
	maps\_utility::vision_set_fog_changes("irons_estate_penthouse",4);
	level.player setclutforplayer("clut_base_default",1);
	setsunflareposition((-44.0771,52.229,0));
	common_scripts\utility::flag_wait("player_used_intel_trigger");
	setsaveddvar("r_mbEnable","2");
	setsaveddvar("r_mbVelocityScalar","1");
	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(8,15,1,1);
	common_scripts\utility::flag_wait("player_finished_desk_anim");
	level.player disablephysicaldepthoffieldscripting();
	setsaveddvar("r_mbEnable","0");
	common_scripts\utility::flag_wait("firelight_off") maps\_lighting::stop_flickerlight("fire_motion_medium","fireplace_01",0);
}

//Function Number: 25
irons_estate_intel_debug_checkpoint()
{
	common_scripts\utility::flag_wait("intel_debug_lighting");
	maps\_lighting::play_flickerlight_motion_preset("fire_motion_medium","fireplace_01");
	level.player lightsetforplayer("irons_estate_penthouse");
	maps\_utility::vision_set_fog_changes("irons_estate_penthouse",1);
	level.player setclutforplayer("clut_base_default",1);
	setsunflareposition((-44.0771,52.229,0));
	common_scripts\utility::flag_wait("player_used_intel_trigger");
	setsaveddvar("r_mbEnable","2");
	setsaveddvar("r_mbVelocityScalar","1");
	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(22,49,1,1);
	common_scripts\utility::flag_wait("player_finished_desk_anim");
	level.player disablephysicaldepthoffieldscripting();
	setsaveddvar("r_mbEnable","0");
	common_scripts\utility::flag_wait("firelight_off") maps\_lighting::stop_flickerlight("fire_motion_medium","fireplace_01",0);
}

//Function Number: 26
irons_estate_elevator_dof()
{
	common_scripts\utility::flag_wait("elevator_rappel_start");
	setsaveddvar("r_mbEnable","2");
	setsaveddvar("r_mbVelocityScalar","1");
	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(18,0,1,1);
	wait(2);
	level.player setphysicaldepthoffield(5,0,1,1);
	wait(2);
	level.player disablephysicaldepthoffieldscripting();
	setsaveddvar("r_mbEnable","0");
	if(level.currentgen)
	{
		var_00 = getent("guard_house_exit_light","targetname");
		var_00 setlightintensity(15000);
	}
}

//Function Number: 27
irons_estate_car_setup()
{
	common_scripts\utility::flag_wait("player_under_car");
	wait(2);
	level.player lightsetforplayer("irons_estate_car");
	maps\_utility::vision_set_fog_changes("irons_estate_car",2);
	level.player setclutforplayer("clut_base_default",2);
	wait(16);
	maps\_utility::vision_set_fog_changes("irons_estate_hanger",2);
	setsaveddvar("r_mbEnable","2");
	setsaveddvar("r_mbCameraRotationInfluence","1");
	setsaveddvar("r_mbVelocityScalar","1");
	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(3,22,1,1);
	common_scripts\utility::flag_wait("track_irons_start");
	level.player disablephysicaldepthoffieldscripting();
	setsaveddvar("r_mbEnable","0");
	setsunflareposition((-44.0771,52.229,0));
}

//Function Number: 28
irons_estate_hanger_setup()
{
	common_scripts\utility::flag_wait("irons_estate_hanger_dof");
	maps\_lighting::lerp_spot_intensity("spacey_bounce",0,0);
	level.player lightsetforplayer("irons_estate_hanger");
	maps\_utility::vision_set_fog_changes("irons_estate_hanger",2);
	level.player setclutforplayer("clut_base_default",0);
	setsunflareposition((-44.0771,52.229,0));
	common_scripts\utility::flag_wait("at_listening_position");
	maps\_lighting::lerp_spot_intensity("spacey_bounce",0,2000);
	setsaveddvar("r_mbEnable","2");
	setsaveddvar("r_mbVelocityScalar","1");
	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(10,500,1,1);
	wait(7);
	level.player setphysicaldepthoffield(35,500,1,1);
	wait(6);
	level.player setphysicaldepthoffield(30,540,1,1);
	common_scripts\utility::flag_wait("track_irons_end");
	level.player disablephysicaldepthoffieldscripting();
	maps\_lighting::lerp_spot_intensity("spacey_bounce",1,0);
	setsaveddvar("r_mbEnable","0");
}

//Function Number: 29
force_bounce_on()
{
	common_scripts\utility::flag_wait("bounce_force_on");
	var_00 = getent("spacey_bounce_force_on","targetname");
	var_00 setlightshadowstate("force_on");
	common_scripts\utility::flag_wait("bounce_force_off");
	var_00 setlightshadowstate("force_off");
}

//Function Number: 30
plant_tracker_debug_checkpoint()
{
	common_scripts\utility::flag_wait("irons_estate_plant_tracker_debug");
	level.player lightsetforplayer("irons_estate_hanger");
	maps\_utility::vision_set_fog_changes("irons_estate_hanger",0);
	level.player setclutforplayer("clut_base_default",0);
}

//Function Number: 31
irons_estate_exfil_setup()
{
	common_scripts\utility::flag_wait("irons_estate_exfil");
	level.player lightsetforplayer("irons_estate_exfil");
	maps\_utility::vision_set_fog_changes("irons_estate_exfil",2);
	level.player setclutforplayer("clut_base_default",2);
	setsunflareposition((-44.0771,52.229,0));
	playfxontag(level._effect["ie_light_red_cormack_plane"],level.vtol,"TAG_LT_WING_CORMACK_LIGHT");
	playfxontag(level._effect["ie_light_red_cormack_plane"],level.vtol,"TAG_RT_WING_CORMACK_LIGHT");
}

//Function Number: 32
plant_tracker_light_model_swap()
{
	var_00 = getent("plant_tracker_blue_light_off","targetname");
	var_01 = getent("plant_tracker_blue_light_on","targetname");
	var_00 show();
	var_01 hide();
	common_scripts\utility::flag_wait("model_swap_light");
	var_01 show();
	var_00 hide();
}

//Function Number: 33
irons_estate_plane_setup()
{
	common_scripts\utility::flag_wait("player_grappled_to_vtol");
	level.player lightsetforplayer("irons_estate_plane");
	maps\_utility::vision_set_fog_changes("irons_estate_plane",2);
	level.player setclutforplayer("clut_base_default",2);
	setsunflareposition((-44.0771,52.229,0));
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbVelocityScalar","1");
	}

	if(level.nextgen)
	{
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(5,29,1,1);
		wait(2);
		level.player setphysicaldepthoffield(9,0,1,1);
		wait(2);
		level.player setphysicaldepthoffield(5,29,1,1);
		wait(4);
		level.player setphysicaldepthoffield(6,30,1,1);
		wait(2);
	}
	else
	{
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(0.6816,47.298,1,1);
		wait(1.5);
		level.player setphysicaldepthoffield(5.84,0,1,1);
		wait(2);
		level.player setphysicaldepthoffield(2.66,30,1,1);
		wait(4);
		level.player setphysicaldepthoffield(1.6,100,1,1);
		wait(2);
	}

	maps\_utility::vision_set_fog_changes("irons_estate_plane_drop",2);
}

//Function Number: 34
irons_estate_underwater_setup()
{
	common_scripts\utility::flag_wait("irons_estate_underwater_dof");
	level.player.underwater = 1;
	level.player thread maps\_water::underwaterbubbles();
	level.player thread maps\_water::underwatercloudy();
	level.player lightsetforplayer("irons_estate_underwater_waterfall");
	maps\_utility::vision_set_fog_changes("irons_estate_underwater_waterfall",0);
	level.player setclutforplayer("clut_base_default",0);
	level.player setwatersheeting(1,2);
	level.player playlocalsound("underwater_enter");
	setsunflareposition((-44.0771,52.229,0));
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbVelocityScalar","1");
	}

	if(level.nextgen)
	{
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(9.8,24,1,1);
		return;
	}

	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(1.65,110,1,1);
}

//Function Number: 35
pre_hack_security_check()
{
	if(level.start_point == "hack_security")
	{
		return 0;
	}

	return 1;
}

//Function Number: 36
set_security_lights()
{
	self endon("death");
	var_00 = getentarray("set_security_lights","script_noteworthy");
	if(pre_hack_security_check())
	{
		foreach(var_02 in var_00)
		{
			var_02 setlightintensity(0);
		}

		common_scripts\utility::flag_wait("security_center_wake_up");
		var_04 = 6;
		var_05 = 1;
		var_06 = randomfloatrange(0.05,0.1);
		while(var_05 < var_04)
		{
			foreach(var_02 in var_00)
			{
				var_02 setlightintensity(200);
			}

			wait(var_06);
			foreach(var_02 in var_00)
			{
				var_02 setlightintensity(0);
			}

			var_05++;
			wait(var_06);
		}
	}

	foreach(var_02 in var_00)
	{
		var_02 setlightintensity(6000);
	}
}

//Function Number: 37
set_security_center_tv()
{
	self endon("death");
	var_00 = getentarray("set_security_center_tv","script_noteworthy");
	if(pre_hack_security_check())
	{
		foreach(var_02 in var_00)
		{
			var_02 setlightintensity(0);
		}

		common_scripts\utility::flag_wait("security_center_wake_up");
		var_04 = 6;
		var_05 = 0;
		var_06 = randomfloatrange(0.05,0.1);
		while(var_05 < var_04)
		{
			foreach(var_02 in var_00)
			{
				if(level.nextgen)
				{
					var_02 setlightintensity(800);
					continue;
				}

				var_02 setlightintensity(1000);
			}

			wait(var_06);
			foreach(var_02 in var_00)
			{
				var_02 setlightintensity(0);
			}

			var_05++;
			wait(var_06);
		}
	}

	foreach(var_02 in var_00)
	{
		if(level.nextgen)
		{
			var_02 setlightintensity(800);
			continue;
		}

		var_02 setlightintensity(1000);
	}

	thread maps\irons_estate_code::security_center_bink();
	thread maps\irons_estate_code::security_center_main_screen_bink(undefined,1);
	var_0D = getent("security_center_desk_screen","targetname");
	var_0D show();
}

//Function Number: 38
tennis_court_lights_intial()
{
	var_00 = getentarray("tennis_court_net_light","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 setlightintensity(800);
	}

	var_04 = getentarray("tennis_court_light","script_noteworthy");
	foreach(var_02 in var_04)
	{
		var_02 setlightintensity(100);
	}
}

//Function Number: 39
tennis_court_lights_dimmed()
{
	var_00 = getentarray("tennis_court_net_light","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 setlightintensity(400);
	}

	var_04 = getentarray("tennis_court_light","script_noteworthy");
	foreach(var_02 in var_04)
	{
		var_02 setlightintensity(50);
	}
}

//Function Number: 40
tennis_court_lights_on()
{
	var_00 = getentarray("tennis_court_net_light","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 setlightintensity(800);
	}

	var_04 = getentarray("tennis_court_light","script_noteworthy");
	foreach(var_02 in var_04)
	{
		var_02 setlightintensity(100);
	}
}