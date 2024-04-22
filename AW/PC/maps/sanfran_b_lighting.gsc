/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: sanfran_b_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 45
 * Decompile Time: 647 ms
 * Timestamp: 4/22/2024 2:35:30 AM
*******************************************************************/

//Function Number: 1
main()
{
	waittillframeend;
	thread setup_dof_presets();
	thread setup_dof_viewmodel_presets();
	thread setup_flickerlight_presets();
	thread set_level_lighting_values();
	thread fix_dark_script_models();
	thread intro_sun_flare_position();
	if(level.nextgen)
	{
		thread clut_trigger_manage();
	}

	if(level.currentgen)
	{
	}

	if(level.nextgen)
	{
		setsaveddvar("r_hemiAoEnable",1);
	}

	precacheshader("ac130_overlay_pip_vignette");
}

//Function Number: 2
set_level_lighting_values()
{
	if(isusinghdr())
	{
		if(level.nextgen)
		{
			setsaveddvar("r_dynamicOpl",1);
		}

		setsaveddvar("r_disableLightSets",0);
		setsaveddvar("r_tonemapMinExposureAdjust",-7.4919);
		setsaveddvar("sm_usedSunCascadeCount",2);
		setsaveddvar("sm_sunSampleSizeNear",0.2);
		if(level.nextgen)
		{
			return;
		}
	}
}

//Function Number: 3
setup_dof_presets()
{
	maps\_lighting::create_dof_preset("intro",10,18,10,25,150,4.5,0.5);
	maps\_lighting::create_dof_preset("temp",0,60,5,1000,8000,2.5,0.5);
	maps\_lighting::create_dof_preset("sf_b_intro",8,16,4,50,250,1,0.5);
	maps\_lighting::create_dof_preset("sf_b_intro_blur",8,16,5,50,150,2.7,0.5);
	maps\_lighting::create_dof_preset("sf_b_intro_crash",8,16,8,20,50,5,0.5);
	maps\_lighting::create_dof_preset("sf_b_interior",8,16,5,17,650,4,0.5);
	maps\_lighting::create_dof_preset("sf_b_guns",8,300,5,5000,7000,0,0.5);
	maps\_lighting::create_dof_preset("sf_b_end",8,16,5,17,450,2,0.5);
	maps\_lighting::create_dof_preset("cg_default",0,100,4,6000,31000,1.5,0);
}

//Function Number: 4
setup_dof_viewmodel_presets()
{
	maps\_lighting::create_dof_viewmodel_preset("vm_rack_nblur",2,10);
	maps\_lighting::create_dof_viewmodel_preset("vm_off",0,0);
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
viewmodel_blend()
{
	maps\_lighting::blend_dof_viewmodel_presets("vm_rack_nblur","vm_off",2);
}

//Function Number: 7
dof_car_explosion()
{
	wait(1.5);
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_sanfran_b_exterior",0.25);
		wait(1.75);
		level.player setclutforplayer("clut_sanfran_b_fire",0.5);
	}

	wait(8.3);
	if(level.currentgen)
	{
		level.player lightsetforplayer("sanfran_b_intro");
		wait(1.75);
		thread maps\_utility::vision_set_fog_changes("sanfran_b_exterior_darker_fog",0.2);
	}

	if(level.nextgen)
	{
		setsaveddvar("r_mbVelocityScalar","2");
	}

	wait(0.3);
	if(level.nextgen)
	{
		maps\_utility::fog_set_changes("sanfran_b_exterior_light_fog",0.2);
		level.player lightsetforplayer("sanfran_b_intro_bright");
	}

	if(level.currentgen)
	{
		thread maps\_utility::vision_set_fog_changes("sanfran_b_exterior_light_fog",0.2);
	}

	wait(0.4);
	if(level.currentgen)
	{
		thread maps\_utility::vision_set_fog_changes("sanfran_b_exterior_dark_fog",0.5);
		level.player lightsetforplayer("sanfran_b_intro");
	}

	if(level.nextgen)
	{
		maps\_utility::fog_set_changes("sanfran_b_exterior_darker_fog",3);
		level.player lightsetforplayer("sanfran_b_intro");
	}

	wait(1);
	if(level.nextgen)
	{
		setsaveddvar("r_mbVelocityScalar",".5");
	}
}

//Function Number: 8
interior_dof_blend()
{
	if(level.nextgen)
	{
	}
}

//Function Number: 9
play_flickering_hanger_light()
{
	if(level.nextgen)
	{
		thread maps\_lighting::model_flicker_preset("model_flicker_02",0,300000,300000,undefined,1668);
	}
	else
	{
		thread maps\_lighting::model_flicker_preset("model_flicker_02",0,25000,25000,undefined,1668);
	}

	if(level.nextgen)
	{
		maps\_lighting::play_flickerlight_preset("fire","fire_hallway",1700000);
		return;
	}

	maps\_lighting::play_flickerlight_preset("fire","fire_hallway",4000);
}

//Function Number: 10
stop_flickering_hanger_light()
{
	maps\_lighting::stop_flickerlight("fire","fire_hallway",0);
}

//Function Number: 11
play_flickering_interior_light()
{
	maps\_lighting::play_flickerlight_preset("fire","fire_interior",100000);
}

//Function Number: 12
stop_flickering_interior_light()
{
	maps\_lighting::stop_flickerlight("fire","fire_interior",0);
}

//Function Number: 13
play_flickering_fire_light()
{
	thread intro_dof();
	if(level.nextgen)
	{
		wait(0.05);
		var_00 = getent("heli_light","targetname");
		var_00 setlightintensity(10000000);
		var_00 setlightcolor((1,0.8,0.6));
		maps\_lighting::play_flickerlight_preset("sfb_fire","fire_outside",2058000);
		wait(3.5);
		maps\_lighting::lerp_spot_intensity("fire_outside",1,0);
		wait(0.4);
		maps\_lighting::lerp_spot_intensity("fire_outside",0.5,2058000);
		wait(6.8);
	}
}

//Function Number: 14
intro_dof()
{
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbVelocityScalar",".5");
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(2,241);
		wait(2.1);
		level.player setphysicaldepthoffield(1.5,40);
		wait(0.5);
		level.player setphysicaldepthoffield(1.5,30);
		wait(1.5);
		level.player setphysicaldepthoffield(2,241);
		wait(5.5);
		level.player setphysicaldepthoffield(1.2,41);
		wait(12.2);
		level.player setphysicaldepthoffield(1.5,30);
		level.player disablephysicaldepthoffieldscripting();
		wait(0.2);
		setsaveddvar("r_mbEnable","0");
		return;
	}

	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(2,241);
	wait(2.1);
	level.player setphysicaldepthoffield(1.5,40);
	wait(0.5);
	level.player setphysicaldepthoffield(1.5,30);
	wait(1.5);
	level.player setphysicaldepthoffield(2,241);
	wait(5.5);
	level.player setphysicaldepthoffield(1.2,41);
	wait(12.2);
	level.player setphysicaldepthoffield(1.5,30);
	wait(0.2);
	level.player setphysicaldepthoffield(19,0,2,3);
}

//Function Number: 15
stop_flickering_fire_light()
{
	maps\_lighting::stop_flickerlight("fire","fire_outside",0);
	maps\_lighting::stop_flickerlight("fire","fire_outside2",0);
}

//Function Number: 16
fire_inside_02_manage()
{
	level endon("console_guy_spawn");
	for(;;)
	{
		common_scripts\utility::flag_wait("fire_inside_02_on");
		if(level.nextgen)
		{
			maps\_lighting::play_flickerlight_preset("fire","fire_inside_02",5580000);
		}
		else
		{
			maps\_lighting::play_flickerlight_preset("fire","fire_inside_02",150000);
		}

		maps\_utility::lerp_saveddvar("r_specularColorScale",2,1.5);
		common_scripts\utility::flag_waitopen("fire_inside_02_on");
		maps\_lighting::stop_flickerlight("fire","fire_inside_02",0);
		maps\_utility::lerp_saveddvar("r_specularColorScale",1,1.5);
	}
}

//Function Number: 17
play_flickering_info_hallway_light()
{
	maps\_lighting::play_flickerlight_preset("hallway","hallway_flicker",70000);
}

//Function Number: 18
stop_flickering_info_hallway_light()
{
	maps\_lighting::stop_flickerlight("hallway","hallway_flicker",0);
}

//Function Number: 19
play_flickering_info_light()
{
	if(level.nextgen)
	{
		thread maps\_lighting::model_flicker_preset("model_flicker_03",0,300000,300000,undefined,1669);
	}
	else
	{
		thread maps\_lighting::model_flicker_preset("model_flicker_03",0,100000,100000,undefined,1669);
	}

	thread maps\_lighting::play_pulse_preset("red","red_strobe",260000);
	thread maps\_lighting::play_pulse_preset("red","red_strobe2",260000);
}

//Function Number: 20
play_flickering_bridge_light()
{
}

//Function Number: 21
stop_flickering_info_light()
{
}

//Function Number: 22
play_pulse_light()
{
	maps\_lighting::play_flickerlight_preset("pulse","pulse_light",4000);
}

//Function Number: 23
stop_pulse_light()
{
	maps\_lighting::stop_flickerlight("pulse","pulse_light",0);
}

//Function Number: 24
lerp_sun_01()
{
	thread maps\_shg_fx::set_sun_flare_position((-24,180,0));
	wait(1);
	thread maps\_shg_fx::vfx_sunflare("sanfran_sunflare_a");
}

//Function Number: 25
lerp_sun_02()
{
	thread maps\_shg_fx::set_sun_flare_position((-15,85,0));
	wait(1);
	thread maps\_shg_fx::vfx_sunflare("sanfran_sunflare_a");
}

//Function Number: 26
flip_spot_light()
{
	var_00 = getent("spot_switch_off","targetname");
	var_00 setlightintensity(0);
}

//Function Number: 27
sundark_call()
{
	var_00 = getentarray("sun_dark","targetname");
	level.sundark_touched = 0;
	foreach(var_02 in var_00)
	{
		var_02 thread sundark_volume();
	}
}

//Function Number: 28
sundark_volume()
{
	for(;;)
	{
		self waittill("trigger");
		level.sundark_touched++;
		while(level.player istouching(self))
		{
			wait(0.1);
		}

		level.sundark_touched--;
		if(level.sundark_touched == 0)
		{
			resetsunlight();
		}
	}
}

//Function Number: 29
ending_viewmodelblur()
{
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbVelocityScalar","1");
	}
}

//Function Number: 30
ending_viewmodelblur_reset()
{
	if(level.nextgen)
	{
		if(level.xb3)
		{
			setsaveddvar("sm_sunShadowBoundsOverride","1");
			setsaveddvar("sm_sunShadowBoundsMin","-10000 50000 -1000");
			setsaveddvar("sm_sunShadowBoundsMax","-2000 70000 1000");
		}

		setsaveddvar("r_dof_physical_bokehenable",1);
		setsaveddvar("r_mbCameraRotationInfluence",1);
		thread shadow_card();
		common_scripts\_exploder::exploder(7022);
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(1,35,10,10);
		wait(1);
		level.player setphysicaldepthoffield(1,165,2,3);
		wait(9.5);
		level.player setphysicaldepthoffield(1.5,41,2,3);
		wait(3.5);
		level.player setphysicaldepthoffield(1.5,74,2,3);
		wait(6.25);
		level.player setphysicaldepthoffield(1.5,31,2,3);
		wait(9);
		level.player setphysicaldepthoffield(1.5,45,2,3);
		wait(10);
		if(level.xb3)
		{
			setsaveddvar("sm_sunShadowBoundsOverride","0");
			return;
		}

		return;
	}

	thread shadow_card();
	common_scripts\_exploder::exploder(7022);
	level.player enablephysicaldepthoffieldscripting();
	level.player setphysicaldepthoffield(1,35,10,10);
	wait(1);
	level.player setphysicaldepthoffield(1,165,2,3);
	wait(9.5);
	level.player setphysicaldepthoffield(1.5,41,2,3);
	wait(3.5);
	level.player setphysicaldepthoffield(1.5,74,2,3);
	wait(6.25);
	level.player setphysicaldepthoffield(1.5,31,2,3);
	wait(9);
	level.player setphysicaldepthoffield(1.5,45,2,3);
	wait(10);
}

//Function Number: 31
shadow_card()
{
	var_00 = level.maddox;
	var_00.helmet_tag = common_scripts\utility::spawn_tag_origin();
	var_01 = var_00.helmet_tag;
	var_01 linkto(var_00,"TAG_ORIGIN",(0,-50,50),(0,0,0));
	playfxontag(common_scripts\utility::getfx("shadow_card1"),var_01,"tag_origin");
}

//Function Number: 32
fix_dark_script_models()
{
	wait(5);
	var_00 = getent("refl_probe_outside","targetname");
	var_01 = getent("mob_placement_marker","targetname");
	var_02 = getent("mob_turret_right","targetname");
	var_03 = getent("mob_turret_left","targetname");
	var_04 = getent("railgun_turn_off","targetname");
	var_02 overridereflectionprobe(var_00.origin);
	var_03 overridereflectionprobe(var_00.origin);
	var_04 overridereflectionprobe(var_00.origin);
	var_02.origin = var_01.origin;
}

//Function Number: 33
intro_sun_flare_position()
{
	var_00 = (-31,84,0);
	maps\_shg_fx::set_sun_flare_position(var_00);
	thread maps\_shg_fx::vfx_sunflare("sanfran_sunflare_a");
}

//Function Number: 34
clut_trigger_manage()
{
	common_scripts\utility::run_thread_on_targetname("sanfran_b_exterior",::sanfran_b_exterior_clut);
	common_scripts\utility::run_thread_on_targetname("sanfran_b_exterior_fast",::sanfran_b_exterior_clut_fast);
	common_scripts\utility::run_thread_on_targetname("sanfran_b_interior",::sanfran_b_interior_clut);
	common_scripts\utility::run_thread_on_targetname("sanfran_b_bridge",::sanfran_b_bridge_clut);
	common_scripts\utility::run_thread_on_targetname("sanfran_b_interior_blue",::sanfran_b_interior_blue_clut);
	common_scripts\utility::run_thread_on_targetname("sanfran_b_fire",::sanfran_b_fire);
	common_scripts\utility::run_thread_on_targetname("sanfran_b_dark_lightset",::sanfran_b_dark_lightset);
	common_scripts\utility::run_thread_on_targetname("sanfran_b_darker_lightset",::sanfran_b_darker_lightset);
	common_scripts\utility::run_thread_on_targetname("sanfran_b_lightset",::sanfran_b_lightset);
	common_scripts\utility::run_thread_on_targetname("sanfran_b_hangar_lightset",::sanfran_b_hangar_lightset);
	common_scripts\utility::run_thread_on_targetname("sanfran_b_info_top_lightset",::sanfran_b_info_top_lightset);
}

//Function Number: 35
sanfran_b_exterior_clut()
{
	for(;;)
	{
		self waittill("trigger");
		thread maps\_utility::fog_set_changes("sanfran_b",3);
		level.player setclutforplayer("clut_sanfran_b_exterior",3);
		while(level.player istouching(self))
		{
			wait(0.05);
		}
	}
}

//Function Number: 36
sanfran_b_exterior_clut_fast()
{
	for(;;)
	{
		self waittill("trigger");
		thread maps\_utility::fog_set_changes("sanfran_b",1.5);
		level.player setclutforplayer("clut_sanfran_b_exterior",1.5);
		while(level.player istouching(self))
		{
			wait(0.05);
		}
	}
}

//Function Number: 37
sanfran_b_interior_clut()
{
	for(;;)
	{
		self waittill("trigger");
		level.player setclutforplayer("",3);
		thread maps\_utility::fog_set_changes("sanfran_b",3);
		while(level.player istouching(self))
		{
			wait(0.05);
		}
	}
}

//Function Number: 38
sanfran_b_bridge_clut()
{
	for(;;)
	{
		self waittill("trigger");
		level.player setclutforplayer("",3);
		thread maps\_utility::fog_set_changes("sanfran_b_bridge",3);
		while(level.player istouching(self))
		{
			wait(0.05);
		}
	}
}

//Function Number: 39
sanfran_b_interior_blue_clut()
{
	for(;;)
	{
		self waittill("trigger");
		while(level.player istouching(self))
		{
			wait(0.05);
		}
	}
}

//Function Number: 40
sanfran_b_fire()
{
	for(;;)
	{
		self waittill("trigger");
		level.player setclutforplayer("clut_sanfran_b_fire",5);
		while(level.player istouching(self))
		{
			wait(0.05);
		}
	}
}

//Function Number: 41
sanfran_b_dark_lightset()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("sanfran_b_dark");
		while(level.player istouching(self))
		{
			wait(0.05);
		}
	}
}

//Function Number: 42
sanfran_b_darker_lightset()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("sanfran_b_darker");
		while(level.player istouching(self))
		{
			wait(0.05);
		}
	}
}

//Function Number: 43
sanfran_b_lightset()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("sanfran_b");
		while(level.player istouching(self))
		{
			wait(0.05);
		}
	}
}

//Function Number: 44
sanfran_b_hangar_lightset()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("sanfran_b_hangar");
		while(level.player istouching(self))
		{
			wait(0.05);
		}
	}
}

//Function Number: 45
sanfran_b_info_top_lightset()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("sanfran_b_info_top");
		while(level.player istouching(self))
		{
			wait(0.05);
		}
	}
}