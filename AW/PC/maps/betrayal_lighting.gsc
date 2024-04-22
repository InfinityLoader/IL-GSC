/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: betrayal_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 65
 * Decompile Time: 936 ms
 * Timestamp: 4/22/2024 2:25:38 AM
*******************************************************************/

//Function Number: 1
main2()
{
	thread set_level_lighting_values();
	thread setup_dof_presets();
	thread dof_triggers();
	thread setup_dof_viewmodel_presets();
	init_level_lighting_flags();
	thread setup_lighting_office_start();
	thread setup_lighting_basement_start();
	thread setup_lighting_confrontation_start();
	thread setup_lighting_escape_start();
	thread setup_lighting_roof_start();
	thread setup_lighting_swim_start();
	thread setup_lighting_sewer_start();
	thread setup_lighting_old_town_start();
	thread setup_lighting_boat_start();
	thread setup_lighting_boat_crash();
	thread setup_lighting_climb_start();
	thread setup_vfx_sunflare();
	setsaveddvar("r_disablelightsets",0);
	thread lightset_triggers();
	setsaveddvar("r_chromaticAberrationTweaks",1);
	setsaveddvar("r_chromaticAberration",1);
	setsaveddvar("r_chromaticSeparationR",0.5);
	setsaveddvar("r_chromaticSeparationG",-0.5);
	setsaveddvar("r_chromaticSeparationB",0);
	setsaveddvar("r_chromaticAberrationAlpha",0.5);
	setsaveddvar("r_veilFallOffWeight1",(2,2,2));
	setsaveddvar("r_aoDiminish",0.3);
	level.player_dof_aperture = 4;
	thread autofocus_loop();
	thread riverbounce_hideents();
	thread lightbox_hideents();
	if(level.nextgen)
	{
		setsaveddvar("r_hemiAoEnable",1);
	}
}

//Function Number: 2
init_level_lighting_flags()
{
	common_scripts\utility::flag_init("office_start_lighting");
	common_scripts\utility::flag_init("basement_start_lighting");
	common_scripts\utility::flag_init("hospital_start_lighting");
	common_scripts\utility::flag_init("confrontation_start_lighting");
	common_scripts\utility::flag_init("confrontation2_start_lighting");
	common_scripts\utility::flag_init("escape_lighting");
	common_scripts\utility::flag_init("escape_start_lighting");
	common_scripts\utility::flag_init("jail_start_lighting");
	common_scripts\utility::flag_init("holding_start_lighting");
	common_scripts\utility::flag_init("garage_start_lighting");
	common_scripts\utility::flag_init("office_chase_start_lighting");
	common_scripts\utility::flag_init("roof_start_lighting");
	common_scripts\utility::flag_init("swim_start_lighting");
	common_scripts\utility::flag_init("sewer_start_lighting");
	common_scripts\utility::flag_init("oldtown_start_lighting");
	common_scripts\utility::flag_init("checkpoint_start_lighting");
	common_scripts\utility::flag_init("crossing_start_lighting");
	common_scripts\utility::flag_init("cafe_start_lighting");
	common_scripts\utility::flag_init("mall_start_lighting");
	common_scripts\utility::flag_init("boat_start_lighting");
	common_scripts\utility::flag_init("boat_crash_lighting");
	common_scripts\utility::flag_init("subway_start_lighting");
	common_scripts\utility::flag_init("gunfight_start_lighting");
	common_scripts\utility::flag_init("gunfight2_start_lighting");
	common_scripts\utility::flag_init("climb_start_lighting");
}

//Function Number: 3
set_level_lighting_values()
{
	setsaveddvar("r_disablelightsets",0);
	if(level.nextgen)
	{
		setsaveddvar("r_mdao",1);
	}

	level.player lightsetforplayer("betrayal_interior");
	maps\_utility::vision_set_fog_changes("betrayal_grungy_int_intro",0);
	level.player setclutforplayer("clut_betrayal_c3_01",1);
	common_scripts\utility::flag_set("flag_autofocus_on");
	level.player_dof_aperture = 2.2;
	level.player_dof_distance = 53;
	level.player_dof_max_distance = 600;
	thread mblur_disable();
}

//Function Number: 4
setup_dof_presets()
{
	maps\_lighting::create_dof_preset("betrayal_standard",4,35,4,1000,7000,1,0.5);
	maps\_lighting::create_dof_preset("exterior_dof",1,40,1,3001,10000,0.1,0.5);
	maps\_lighting::create_dof_preset("interior_dof",1,35,10,101,6000,10,0.5);
}

//Function Number: 5
dof_triggers()
{
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_enable",1);
	}

	level.player enablephysicaldepthoffieldscripting();
	common_scripts\utility::run_thread_on_targetname("dof_enable_interior",::dof_enable_interior);
	common_scripts\utility::run_thread_on_targetname("dof_enable_exterior",::dof_enable_exterior);
	common_scripts\utility::run_thread_on_targetname("dof_enable_start",::dof_enable_start);
	common_scripts\utility::run_thread_on_targetname("interior_fog",::trigger_interior_fog);
	common_scripts\utility::run_thread_on_targetname("exterior_fog",::trigger_exterior_fog);
	common_scripts\utility::run_thread_on_targetname("mblur_enable",::mblur_enable_trigger);
	common_scripts\utility::run_thread_on_targetname("mblur_cam_enable",::mblur_cam_enable_trigger);
	common_scripts\utility::run_thread_on_targetname("mblur_disable",::mblur_disable_trigger);
}

//Function Number: 6
dof_enable_interior()
{
	self waittill("trigger");
	if(level.nextgen)
	{
		level.player_dof_aperture = 2.8;
	}

	common_scripts\utility::flag_set("flag_autofocus_on");
}

//Function Number: 7
dof_enable_exterior()
{
	self waittill("trigger");
	if(level.nextgen)
	{
		level.player_dof_aperture = 8;
	}

	common_scripts\utility::flag_set("flag_autofocus_on");
}

//Function Number: 8
dof_enable_start()
{
	self waittill("trigger");
	if(level.nextgen)
	{
		level.player_dof_aperture = 4;
	}
}

//Function Number: 9
trigger_interior_fog()
{
	self waittill("trigger");
	if(level.nextgen)
	{
		maps\_utility::fog_set_changes("betrayal_canal",2);
	}
}

//Function Number: 10
trigger_exterior_fog()
{
	self waittill("trigger");
	if(level.nextgen)
	{
		maps\_utility::fog_set_changes("neutral",2);
		return;
	}

	maps\_utility::vision_set_fog_changes("neutral",2);
}

//Function Number: 11
mblur_enable_trigger()
{
	self waittill("trigger");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbVelocityScalar","2");
	}
}

//Function Number: 12
mblur_cam_enable_trigger()
{
	self waittill("trigger");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
		setsaveddvar("r_mbVelocityScalar","2");
	}
}

//Function Number: 13
mblur_disable_trigger()
{
	self waittill("trigger");
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_mbCameraRotationInfluence","0");
		setsaveddvar("r_mbVelocityScalar","0");
	}
}

//Function Number: 14
mblur_enable()
{
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbVelocityScalar","2");
	}
}

//Function Number: 15
mblur_cam_enable()
{
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbCameraRotationInfluence","1");
		setsaveddvar("r_mbVelocityScalar","2");
	}
}

//Function Number: 16
mblur_disable()
{
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","0");
		setsaveddvar("r_mbCameraRotationInfluence","0");
		setsaveddvar("r_mbVelocityScalar","0");
	}
}

//Function Number: 17
autofocus_loop()
{
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_enable",1);
	}

	level.player enablephysicaldepthoffieldscripting();
	var_00 = level.player_dof_aperture;
	for(;;)
	{
		wait 0.05;
		if(common_scripts\utility::flag("flag_autofocus_on") == 1)
		{
			var_01 = min(trace_distance(),level.player_dof_max_distance);
		}
		else
		{
			var_01 = level.player_dof_distance;
		}

		var_00 = level.player_dof_aperture;
		if(var_01 < 60)
		{
			var_00 = var_00 + abs(60 - var_01) * 0.3;
		}
		else
		{
			var_00 = level.player_dof_aperture;
		}

		if(level.nextgen)
		{
			level.player setphysicaldepthoffield(var_00,var_01,4,2);
		}
	}
}

//Function Number: 18
riverbounce_hideents()
{
	var_00 = getentarray("canal_bounce","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] hide();
		var_00[var_01] notsolid();
	}
}

//Function Number: 19
lightbox_hideents()
{
	var_00 = getentarray("lightboxes","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] connectpaths();
		var_00[var_01] hide();
		var_02 = (0,0,0);
		var_00[var_01] moveto(var_02,0.1,0.02,0.02);
	}

	var_00 = getentarray("hide_screens","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] hide();
		var_02 = (0,0,0);
		var_00[var_01] moveto(var_02,0.1,0.02,0.02);
	}
}

//Function Number: 20
blastdoor_hideents()
{
	var_00 = getentarray("roof_window_blastdoor","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] hide();
	}
}

//Function Number: 21
blastdoor_showents()
{
	var_00 = getentarray("roof_window_blastdoor","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] show();
	}
}

//Function Number: 22
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

//Function Number: 23
setup_dof_viewmodel_presets()
{
	maps\_lighting::create_dof_viewmodel_preset("betrayal_viewmodel_standard",1,12);
}

//Function Number: 24
setup_lighting_office_start()
{
	common_scripts\utility::flag_wait("office_start_lighting");
	level.player setclutforplayer("clut_betrayal_c3_02",2);
	if(level.nextgen)
	{
		level.player_dof_aperture = 3.5;
		level.player_dof_distance = 53;
		setsaveddvar("r_dof_physical_bokehEnable",1);
		thread mblur_disable();
		level.player lightsetforplayer("betrayal_interior_lobby");
		maps\_utility::vision_set_fog_changes("betrayal_grungy_int_intro",0.5);
		level.player setclutforplayer("clut_betrayal_c3_01",1);
		var_00 = getent("btr_lobby_light_gideon_key","targetname");
		var_01 = getent("btr_lobby_light_gideon_rim","targetname");
		var_02 = getent("btr_lobby_light_ground_source","targetname");
		var_03 = getent("btr_lobby_light_elevator","targetname");
		var_02 setlightintensity(2000000);
		var_02 setlightcolor((1,1,1));
		var_01 setlightintensity(38000);
		var_00 setlightintensity(28000);
		var_00 setlightradius(170);
		wait(15);
		maps\_lighting::lerp_spot_intensity("btr_lobby_light_gideon_key",13,22000);
		maps\_lighting::lerp_spot_intensity("btr_lobby_light_gideon_rim",4,5000);
		wait(10);
		common_scripts\utility::flag_set("flag_autofocus_on");
		level.player_dof_aperture = 3.5;
		level.player_dof_distance = 53;
		maps\_lighting::lerp_spot_intensity("btr_lobby_light_gideon_key",8,0);
		var_04 = getent("betr_light_vista_rim","targetname");
		var_04 setlightintensity(100000000);
		var_04 setlightshadowstate("force_on");
		level.player_dof_aperture = 8;
	}
}

//Function Number: 25
setup_lighting_basement_start()
{
	common_scripts\utility::flag_wait("basement_start_lighting");
	if(level.nextgen)
	{
		level.player lightsetforplayer("betrayal_interior");
		maps\_utility::vision_set_fog_changes("betrayal_interior",0.5);
	}
	else
	{
		level.player lightsetforplayer("betrayal_interior_darker");
		maps\_utility::vision_set_fog_changes("betrayal_interior",0.5);
	}

	level.player setclutforplayer("clut_betrayal_c3_01",1);
	level.player_dof_max_distance = 600;
	thread mblur_disable();
}

//Function Number: 26
setup_lighting_confrontation_start()
{
	common_scripts\utility::flag_wait("confrontation_start_lighting");
	if(level.nextgen)
	{
		setsaveddvar("r_subdiv","1");
		setsaveddvar("r_adaptiveSubdivBaseFactor","0.5");
	}

	thread blastdoor_hideents();
	common_scripts\_exploder::exploder(1999);
	thread mblur_disable();
	if(level.nextgen)
	{
		maps\_utility::fog_set_changes("betrayal_interior_darker",1);
		level.player lightsetforplayer("betrayal_interior_confrontation_1");
	}
	else
	{
		maps\_utility::vision_set_fog_changes("betrayal_interior_darker",1);
		level.player lightsetforplayer("betrayal_interior_darker");
	}

	level.player setclutforplayer("clut_betrayal_c3_03",1);
	common_scripts\utility::flag_set("flag_dialogue_start_confrontation");
	if(level.nextgen)
	{
		level.player_dof_aperture = 2.5;
		level.player_dof_max_distance = 400;
		setsaveddvar("r_dof_physical_bokehEnable",1);
		var_00 = getent("btr_basement_key1","targetname");
		var_01 = getent("btr_basement_key2","targetname");
		var_00 rotateby((15,0,0),0.1);
		var_01 rotateby((15,0,0),0.1);
		var_02 = getent("btr_basement_hall_light","targetname");
		var_02 setlightintensity(0);
		var_03 = getent("btr_basement_key4","targetname");
		var_03 setlightintensity(4000);
		if(level.nextgen)
		{
			maps\_lighting::lerp_spot_intensity("btr_basement_key4",5,600);
		}

		var_03 setlightradius(150);
		wait(4);
		wait(1);
		var_04 = getent("betr_emergency_alarm_model_1","targetname");
		var_05 = getent("betr_emergency_alarm_model_2","targetname");
		var_06 = getent("betr_emergency_alarm_model_3","targetname");
		var_07 = getent("betr_emergency_alarm_model_4","targetname");
		var_08 = getent("betr_emergency_alarm_model_5","targetname");
		var_09 = getent("betr_emergency_alarm_model_6","targetname");
		var_0A = getent("betr_emergency_alarm_model_7","targetname");
		var_0B = getent("betr_emergency_alarm_model_8","targetname");
		var_0C = getent("betr_emergency_alarm_model_9","targetname");
		var_0D = getent("betr_emergency_alarm_model_10","targetname");
		var_0E = getent("betr_emergency_alarm_model_11","targetname");
		var_0F = getent("betr_emergency_alarm_model_12","targetname");
		var_10 = getent("btr_emergLight_elevator_1","targetname");
		var_11 = getent("btr_emergLight_elevator_2","targetname");
		var_0B hide();
		var_0C hide();
		var_0D hide();
		var_0E hide();
		var_0F hide();
		var_12 = getent("betr_emergency_power_light_off","targetname");
		var_13 = getent("betr_emergency_power_light_on","targetname");
		var_13 hide();
		var_00 setlightintensity(4000);
		var_01 setlightintensity(6000);
		wait(9);
		level.player_dof_aperture = 1;
		maps\_lighting::lerp_spot_intensity("btr_basement_key1",10,6000);
		maps\_lighting::lerp_spot_intensity("btr_basement_key2",10,3000);
		level.player lightsetforplayer("betrayal_interior_confrontation_2");
		maps\_lighting::lerp_spot_intensity("btr_basement_key2",10,4000);
		maps\_lighting::lerp_spot_intensity("btr_basement_key1",10,2000);
		var_03 setlightintensity(10);
		var_03 setlightcolor((1,0.87,0.85));
		var_03 rotateby((60,0,0),1);
		wait(5);
		common_scripts\utility::flag_clear("flag_autofocus_on");
		level.player_dof_aperture = 7;
		level.player_dof_max_distance = 400;
		wait(20);
		level.player lightsetforplayer("betrayal_interior_confrontation_3");
		wait(24);
		var_14 = var_00 getorigin();
		var_14 = var_14 + (40,-20,0);
		var_00 moveto(var_14,4);
		var_00 rotateby((10,0,0),4);
		maps\_lighting::lerp_spot_intensity("btr_basement_key1",5,3000);
		wait(1);
		var_03 setlightintensity(30000);
		common_scripts\utility::flag_wait("escape_lighting");
		level.player setclutforplayer("clut_betrayal_c3_04",0.02);
		common_scripts\_exploder::exploder(2001);
		var_0B show();
		var_0C show();
		var_0D show();
		var_0E show();
		var_0F show();
		var_13 show();
		var_12 hide();
		maps\_utility::stop_exploder(1999);
		level.player lightsetforplayer("betrayal_interior");
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbVelocityScalar","1");
		level.player_dof_aperture = 3.5;
		var_00 setlightintensity(15000);
		var_01 setlightintensity(30000);
		var_03 setlightintensity(60000);
		var_00 setlightfovrange(85,60);
		var_01 setlightfovrange(85,60);
		var_03 setlightfovrange(80,50);
		var_00 setlightcolor((1,0.98,0.95));
		var_01 setlightcolor((1,0.05,0.05));
		var_03 setlightcolor((1,0.05,0.05));
		var_02 setlightintensity(12000);
		var_00 rotateby((-15,0,0),0.1);
		var_00 rotateby((-10,0,0),0.1);
		var_01 rotateby((-15,0,0),0.1);
		var_03 rotateby((-60,0,0),0.1);
		var_00 rotateby((0,0,90),0.1);
		var_00 rotateby((45,45,0),0.1);
		var_01 rotateby((0,0,90),0.1);
		var_03 rotateby((-50,0,0),0.1);
		var_01 rotateby((-30,0,0),0.1);
		var_14 = var_0B getcentroid();
		var_14 = var_14 + (-5,0,0);
		var_01 moveto(var_14,0.1);
		var_14 = var_0C getcentroid();
		var_14 = var_14 + (-2,0,0);
		var_03 moveto(var_14,0.1);
		var_14 = var_13 getcentroid();
		var_14 = var_14 + (-5,10,0);
		var_00 moveto(var_14,0.02);
		var_01 setlightfovrange(70,10);
		var_03 setlightfovrange(70,10);
		if(level.nextgen)
		{
			maps\_utility::fog_set_changes("betrayal_escape",7);
			setsaveddvar("r_dof_physical_bokehEnable",0);
		}
		else
		{
			maps\_utility::vision_set_fog_changes("betrayal_escape",7);
		}

		var_10 setlightintensity(300000);
		var_11 setlightintensity(300000);
		var_14 = var_10 getcentroid();
		var_14 = var_14 + (0,0,200);
		var_10 moveto(var_14,0.02);
		var_14 = var_11 getcentroid();
		var_14 = var_14 + (0,0,200);
		var_11 moveto(var_14,0.02);
		var_10 setlightfovrange(90,30);
		var_11 setlightfovrange(90,30);
		var_10 rotateby((90,0,0),0.02);
		var_11 rotateby((90,0,0),0.02);
		var_15 = [var_01,var_03];
		for(var_16 = 60;var_16 > 0;var_16--)
		{
			var_17 = 20;
			while(var_17 > 0)
			{
				var_18 = abs(cos(gettime() * 0.08)) * 26000;
				var_01 setlightintensity(var_18);
				var_03 setlightintensity(var_18 * 2);
				var_17--;
				wait(0.1);
			}

			var_10 rotateby((0,360,0),2);
			var_11 rotateby((0,360,0),2);
			var_04 rotateby((0,360,0),2);
			if(var_16 == 40)
			{
				maps\_utility::vision_set_fog_changes("betrayal_escape_elevator_interior",20);
			}
		}
	}

	level.player_dof_max_distance = 400;
	maps\_utility::stop_exploder(2001);
	if(level.nextgen)
	{
		setsaveddvar("r_adaptiveSubdivBaseFactor","1.5");
	}

	level.player_dof_aperture = 8;
}

//Function Number: 27
lighting_confrontation_auto_dof(param_00,param_01)
{
	for(var_02 = 715;var_02 > 0 && !isremovedentity(param_01);var_02--)
	{
		var_03 = distance2d(param_00.origin,param_01.origin);
		if(!isremovedentity(param_01) && maps\_utility::player_looking_at(param_01.origin))
		{
			level.player_dof_distance = var_03;
			common_scripts\utility::flag_clear("flag_autofocus_on");
			level.player_dof_aperture = 3.2;
		}
		else if(var_03 < 40)
		{
			level.player_dof_distance = var_03;
			common_scripts\utility::flag_clear("flag_autofocus_on");
			level.player_dof_aperture = 5.5;
		}
		else
		{
			common_scripts\utility::flag_set("flag_autofocus_on");
			level.player_dof_aperture = 2.5;
		}

		wait(0.1);
	}

	common_scripts\utility::flag_set("flag_autofocus_on");
	level.player_dof_aperture = 3.5;
}

//Function Number: 28
lighting_irons_dof(param_00,param_01)
{
	if(level.currentgen)
	{
		setculldist(500);
	}
	else
	{
		setculldist(0);
	}

	common_scripts\utility::flag_wait("confrontation2_start_lighting");
	for(var_02 = 550;var_02 > 0;var_02--)
	{
		var_03 = distance2d(param_00.origin,param_01.origin);
		if(maps\_utility::player_looking_at(param_01.origin))
		{
			level.player_dof_distance = var_03;
			common_scripts\utility::flag_clear("flag_autofocus_on");
			level.player_dof_aperture = 1.1;
		}
		else
		{
			common_scripts\utility::flag_set("flag_autofocus_on");
			level.player_dof_aperture = 3.8;
		}

		wait(0.1);
	}

	common_scripts\utility::flag_set("flag_autofocus_on");
	level.player_dof_aperture = 3;
}

//Function Number: 29
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

	level.player_dof_aperture = var_04;
	common_scripts\utility::flag_set("flag_autofocus_on");
	level.player_dof_aperture = var_04;
}

//Function Number: 30
setup_lighting_escape_start()
{
	if(level.currentgen)
	{
		setculldist(0);
	}
	else
	{
		setculldist(0);
	}

	common_scripts\utility::flag_wait("escape_start_lighting");
	common_scripts\utility::flag_set("flag_autofocus_on");
	level.player_dof_aperture = 3.5;
	if(level.nextgen)
	{
		level.player lightsetforplayer("betrayal_interior_confrontation_1");
		level.player setclutforplayer("clut_betrayal_c3_04",1);
	}
	else
	{
		level.player lightsetforplayer("betrayal_interior_darker");
		maps\_utility::vision_set_fog_changes("betrayal_interior_darker",0.5);
	}

	var_00 = getent("btr_basement_key1","targetname");
	var_01 = getent("btr_basement_key2","targetname");
	var_02 = getent("btr_basement_key4","targetname");
	var_03 = getent("betr_emergency_alarm_model_1","targetname");
	var_04 = getent("betr_emergency_alarm_model_2","targetname");
	var_05 = getent("betr_emergency_alarm_model_3","targetname");
	var_06 = getent("betr_emergency_alarm_model_4","targetname");
	var_07 = getent("betr_emergency_alarm_model_5","targetname");
	var_08 = getent("betr_emergency_alarm_model_6","targetname");
	var_09 = getent("betr_emergency_alarm_model_7","targetname");
	var_0A = getent("betr_emergency_alarm_model_8","targetname");
	var_0B = getent("betr_emergency_alarm_model_9","targetname");
	var_0C = getent("betr_emergency_alarm_model_10","targetname");
	var_0D = getent("betr_emergency_alarm_model_11","targetname");
	var_0E = getent("betr_emergency_alarm_model_12","targetname");
	var_0F = getent("btr_emergLight_elevator_1","targetname");
	var_10 = getent("btr_emergLight_elevator_2","targetname");
	var_11 = getent("btr_basement_hall_light","targetname");
	var_12 = getent("betr_emergency_power_light_off","targetname");
	var_13 = getent("betr_emergency_power_light_on","targetname");
	common_scripts\_exploder::exploder(2001);
	var_0A show();
	var_0B show();
	var_0C show();
	var_0D show();
	var_0E show();
	var_13 show();
	var_12 hide();
	maps\_utility::stop_exploder(1999);
	setsaveddvar("r_mbEnable","2");
	setsaveddvar("r_mbVelocityScalar","1");
	common_scripts\utility::flag_set("flag_autofocus_on");
	level.player_dof_aperture = 3.5;
	var_00 setlightintensity(10000);
	var_01 setlightintensity(60000);
	var_02 setlightintensity(100000);
	var_00 setlightfovrange(85,60);
	var_01 setlightfovrange(85,60);
	var_02 setlightfovrange(80,50);
	var_00 setlightcolor((1,0.98,0.95));
	var_01 setlightcolor((1,0.05,0.05));
	var_02 setlightcolor((1,0.05,0.05));
	var_11 setlightintensity(12000);
	var_14 = 60;
	var_00 rotateby((0,0,90),0.1);
	var_00 rotateby((45,45,0),0.1);
	var_01 rotateby((0,0,90),0.1);
	var_02 rotateby((30,0,0),0.1);
	var_01 rotateby((-30,0,0),0.1);
	var_15 = var_0A getcentroid();
	var_15 = var_15 + (-5,0,0);
	var_01 moveto(var_15,0.1);
	var_15 = var_0B getcentroid();
	var_15 = var_15 + (-2,0,0);
	var_02 moveto(var_15,0.1);
	var_15 = var_13 getcentroid();
	var_15 = var_15 + (-5,10,0);
	var_00 moveto(var_15,0.02);
	var_01 setlightfovrange(70,10);
	var_02 setlightfovrange(70,10);
	if(level.nextgen)
	{
		maps\_utility::fog_set_changes("betrayal_escape",7);
		setsaveddvar("r_dof_physical_bokehEnable",0);
	}
	else
	{
		maps\_utility::vision_set_fog_changes("betrayal_escape",7);
	}

	var_0F setlightintensity(300000);
	var_10 setlightintensity(300000);
	var_15 = var_0F getcentroid();
	var_15 = var_15 + (0,0,200);
	var_0F moveto(var_15,0.02);
	var_15 = var_10 getcentroid();
	var_15 = var_15 + (0,0,200);
	var_10 moveto(var_15,0.02);
	var_0F setlightfovrange(90,30);
	var_10 setlightfovrange(90,30);
	var_0F rotateby((90,0,0),0.02);
	var_10 rotateby((90,0,0),0.02);
	var_16 = [var_01,var_02];
	while(var_14 > 0)
	{
		var_17 = 20;
		while(var_17 > 0)
		{
			var_18 = abs(cos(gettime() * 0.08)) * 26000;
			var_01 setlightintensity(var_18);
			var_02 setlightintensity(var_18 * 2);
			var_17--;
			wait(0.1);
		}

		var_0F rotateby((0,360,0),2);
		var_10 rotateby((0,360,0),2);
		var_03 rotateby((0,360,0),2);
		if(var_14 == 40)
		{
			maps\_utility::vision_set_fog_changes("betrayal_escape_elevator_interior",20);
		}

		var_14--;
	}
}

//Function Number: 31
blink_lights(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_01;
	var_06 = param_02;
	for(var_07 = int(param_03 * 10);var_07 > 0;var_07--)
	{
		var_05 = abs(cos(gettime() * 0.08 * param_04)) * var_05 + var_06;
		foreach(var_09 in param_00)
		{
			var_09 setlightintensity(var_05);
		}

		wait(0.1);
	}
}

//Function Number: 32
blink_lights_flicker(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = param_01;
	var_07 = param_02;
	for(var_08 = int(param_03 * 10);var_08 > 0;var_08--)
	{
		var_06 = abs(cos(gettime() * 0.08 * param_04)) * var_06 + var_07;
		foreach(var_0A in param_00)
		{
			var_0A setlightintensity(var_06);
		}

		if(param_05 > 0)
		{
			wait(randomfloatrange(0,0.3 * param_05));
		}

		wait(0.1);
	}
}

//Function Number: 33
setup_lighting_roof_start()
{
	if(level.currentgen)
	{
		setculldist(0);
	}
	else
	{
		setculldist(0);
	}

	common_scripts\utility::flag_wait("roof_start_lighting");
	level.player_dof_aperture = 8;
	level.player_dof_max_distance = 400;
	thread blastdoor_showents();
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbVelocityScalar","1");
	}

	common_scripts\_exploder::exploder(3001);
	if(level.nextgen)
	{
		var_00 = getent("siren_light_1","targetname");
		var_01 = getent("siren_light_model_1","targetname");
		var_02 = getent("siren_light_2","targetname");
		var_03 = getent("siren_light_model_2","targetname");
		var_04 = getent("siren_light_3","targetname");
		var_05 = getent("siren_light_model_3","targetname");
		var_00 setlightintensity(500000);
		var_02 setlightintensity(500000);
		var_04 setlightintensity(500000);
		for(var_06 = 80;var_06 > 0;var_06--)
		{
			var_01 rotateby((0,360,0),1);
			var_00 rotateby((0,360,0),1);
			var_03 rotateby((0,360,0),1);
			var_02 rotateby((0,360,0),1);
			var_05 rotateby((0,360,0),1);
			var_04 rotateby((0,360,0),1);
			wait(1);
		}
	}

	common_scripts\_exploder::kill_exploder(3001);
}

//Function Number: 34
setup_lighting_swim_start()
{
	common_scripts\utility::flag_wait("swim_start_lighting");
	wait(0.5);
	level.player lightsetforplayer("betrayal_grungy");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_betrayal_c3_05",1);
	}

	maps\_utility::vision_set_fog_changes("betrayal_grungy",0.5);
	level.player_dof_aperture = 1.2;
	level.player_dof_max_distance = 100;
	common_scripts\_exploder::exploder(3002);
	thread mblur_disable();
}

//Function Number: 35
setup_lighting_sewer_start()
{
	common_scripts\utility::flag_wait("sewer_start_lighting");
	wait(0.5);
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_betrayal_c3_05",1);
	}
	else
	{
		level.player lightsetforplayer("betrayal_sewer");
		maps\_utility::vision_set_fog_changes("betrayal_sewer",1);
	}

	level.player_dof_aperture = 8;
	level.player_dof_max_distance = 600;
	level.player lightsetforplayer("betrayal_sewer");
	maps\_utility::vision_set_fog_changes("betrayal_sewer",3);
	thread mblur_disable();
	var_00 = getentarray("sewer_light_1","targetname");
	thread blink_lights_flicker(var_00,9000,7000,100,10,1);
}

//Function Number: 36
setup_lighting_old_town_start()
{
	common_scripts\utility::flag_wait("oldtown_start_lighting");
	maps\_utility::vision_set_fog_changes("betrayal_grungy_market",0.5);
	level.player lightsetforplayer("betrayal_grungy");
	level.player_dof_aperture = 8;
	level.player_dof_max_distance = 600;
	level.player setclutforplayer("clut_betrayal_c3_01",6);
	maps\_utility::stop_exploder(3002);
	var_00 = getentarray("betr_lighting_market_tvs","targetname");
	foreach(var_02 in var_00)
	{
		var_02 setlightcolor((0.92,0.9,1));
	}

	thread blink_lights_flicker(var_00,4000,3200,1000,5,1);
	thread mblur_disable();
}

//Function Number: 37
setup_lighting_boat_start()
{
	common_scripts\utility::flag_wait("boat_start_lighting");
	level.player_dof_aperture = 8;
	level.player_dof_max_distance = 600;
	level.player setclutforplayer("clut_betrayal_c3_01",1);
	level.player lightsetforplayer("betrayal_grungy_boat_chase");
	maps\_utility::vision_set_fog_changes("betrayal_grungy_boat_chase",2);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbVelocityScalar","2");
	}
}

//Function Number: 38
setup_lighting_boat_crash()
{
	common_scripts\utility::flag_wait("boat_crash_lighting");
	if(level.nextgen)
	{
		setsaveddvar("r_subdiv","1");
	}

	common_scripts\utility::flag_clear("flag_autofocus_on");
	level.player_dof_aperture = 1.1;
	level.player_dof_distance = 15;
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",1);
	}

	level.player setclutforplayer("clut_betrayal_c3_01",1);
	level.player lightsetforplayer("betrayal_crash_cine");
	maps\_utility::vision_set_fog_changes("betrayal_grungy",2);
	if(level.nextgen)
	{
		var_00 = getent("btr_crash_light_rim","targetname");
		var_01 = getent("btr_crash_light_fill","targetname");
		var_00 setlightintensity(1200000);
		var_01 setlightintensity(35000);
	}

	wait(6);
	thread lighting_target_dof(level.player,level.ilana,2.8,10);
	wait(10);
	common_scripts\utility::flag_set("flag_autofocus_on");
	thread mblur_disable();
	level.player_dof_max_distance = 400;
	level.player_dof_aperture = 8;
	wait(15);
	level.player lightsetforplayer("betrayal_grungy");
	wait(45);
	maps\_utility::vision_set_fog_changes("betrayal_grungy_climb",20);
	level.player setclutforplayer("clut_betrayal_c3_01",1);
}

//Function Number: 39
setup_lighting_climb_start()
{
	common_scripts\utility::flag_wait("climb_start_lighting");
	maps\_utility::vision_set_fog_changes("betrayal_grungy_climb",6);
	level.player lightsetforplayer("betrayal_grungy");
	level.player_dof_aperture = 9;
	level.player setclutforplayer("clut_betrayal_c3_01",1);
	level.player_dof_max_distance = 400;
	thread mblur_disable();
}

//Function Number: 40
setup_lighting_finale_start(param_00)
{
	if(level.nextgen)
	{
		setsaveddvar("r_subdiv","1");
	}

	level.player lightsetforplayer("betrayal_outro");
	if(level.nextgen)
	{
		maps\_utility::fog_set_changes("betrayal_grungy_finale",5);
		maps\_utility::vision_set_changes("betrayal_outro",0.5);
	}
	else
	{
		maps\_utility::vision_set_fog_changes("betrayal_grungy_climb",1.5);
	}

	level.player setclutforplayer("clut_betrayal_c3_01",1);
	var_01 = -60;
	var_02 = 160;
	var_03 = (var_01,var_02,0);
	maps\_shg_fx::set_sun_flare_position(var_03);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbVelocityScalar","1");
		common_scripts\utility::flag_clear("flag_autofocus_on");
		level.player_dof_aperture = 4.1;
		level.player_dof_distance = 1;
		level.player_dof_max_distance = 400;
		if(level.nextgen)
		{
			setsaveddvar("r_dof_physical_bokehEnable",1);
		}

		wait(0.3);
		level.player_dof_distance = 97;
		thread lighting_target_dof(level.player,param_00[0],3.2,4);
		wait(4);
		thread mblur_disable();
		level.player_dof_distance = 52;
		var_04 = getent("btr_finale_rim_top","targetname");
		maps\_lighting::lerp_spot_intensity("btr_finale_rim_top",4,3000000);
		thread lighting_target_dof(level.player,param_00[1],3.2,8);
		wait(6);
		level.player lightsetforplayer("betrayal_outro_helicopter");
		wait(2);
		thread lighting_target_dof(level.player,param_00[2],3.2,20);
		var_05 = var_04 getorigin();
		var_05 = var_05 + (100,-230,0);
		var_04 moveto(var_05,5);
		var_04 rotateby((1,-50,0),5);
		maps\_lighting::lerp_spot_intensity("btr_finale_rim_top",5,3000000);
		level.player lightsetforplayer("betrayal_outro");
		level.player_dof_distance = 53;
		wait(10);
		common_scripts\_exploder::exploder(9000);
		wait(2);
		thread lighting_target_dof(level.player,param_00[1],3.2,6);
		level.player_dof_distance = 53;
		wait(6);
		thread lighting_target_dof(level.player,param_00[2],3.2,4);
		level.player_dof_distance = 160;
		level.player_dof_aperture = 8;
	}
}

//Function Number: 41
setup_vfx_sunflare()
{
	thread maps\_shg_fx::vfx_sunflare("fx_sunflare_lsr2");
}

//Function Number: 42
lightset_triggers()
{
	common_scripts\utility::run_thread_on_targetname("betrayal",::lightset_betrayal);
	common_scripts\utility::run_thread_on_targetname("betrayal_grungy",::lightset_betrayal_grungy);
	common_scripts\utility::run_thread_on_targetname("betrayal_interior_darker_fog",::betrayal_interior_darker_fog);
	common_scripts\utility::run_thread_on_targetname("betrayal_roof_transition",::betrayal_roof_transition);
	common_scripts\utility::run_thread_on_targetname("betrayal_mall",::lightset_betrayal_mall);
	common_scripts\utility::run_thread_on_targetname("betrayal_subway",::lightset_betrayal_subway);
	common_scripts\utility::run_thread_on_targetname("betrayal_interior",::lightset_betrayal_interior);
	common_scripts\utility::run_thread_on_targetname("betrayal_interior_clut",::betrayal_interior_clut);
	common_scripts\utility::run_thread_on_targetname("betrayal_race",::lightset_betrayal_race);
	common_scripts\utility::run_thread_on_targetname("betrayal_intro",::lightset_betrayal);
	common_scripts\utility::run_thread_on_targetname("betrayal_interior_in",::lightset_betrayal_grungy_int);
	common_scripts\utility::run_thread_on_targetname("betrayal_river_in",::lightset_betrayal_river_int);
	common_scripts\utility::run_thread_on_targetname("betrayal_interior_out",::lightset_betrayal_grungy_out);
	common_scripts\utility::run_thread_on_targetname("betrayal_river_out",::lightset_betrayal_river_out);
	common_scripts\utility::run_thread_on_targetname("betrayal_pigeon",::exploder_pigeon);
	common_scripts\utility::run_thread_on_targetname("betrayal_swim_tube",::visionset_betrayal_swim_tube);
}

//Function Number: 43
lightset_betrayal()
{
	self waittill("trigger");
	wait(1);
	level.player lightsetforplayer("betrayal");
}

//Function Number: 44
lightset_betrayal_mall()
{
	self waittill("trigger");
	wait(1);
	level.player lightsetforplayer("betrayal_mall");
}

//Function Number: 45
lightset_betrayal_subway()
{
	self waittill("trigger");
	wait(1);
	level.player lightsetforplayer("betrayal_subway");
}

//Function Number: 46
lightset_betrayal_interior()
{
	for(;;)
	{
		self waittill("trigger");
		level.player lightsetforplayer("betrayal_interior");
		if(level.nextgen)
		{
			maps\_utility::vision_set_fog_changes("betrayal_interior",1);
		}
		else
		{
			maps\_utility::vision_set_fog_changes("betrayal_interior",1);
		}

		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 47
betrayal_interior_clut()
{
	self waittill("trigger");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_betrayal_interior_grungy",12);
	}
}

//Function Number: 48
lightset_betrayal_race()
{
	self waittill("trigger");
	if(level.nextgen)
	{
		level.player lightsetforplayer("betrayal_grungy_boat_chase");
		maps\_utility::vision_set_fog_changes("betrayal_grungy_boat_chase",2);
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbVelocityScalar","2");
	}
}

//Function Number: 49
lightset_betrayal_grungy()
{
	for(;;)
	{
		self waittill("trigger");
		maps\_utility::vision_set_fog_changes("betrayal_grungy",1);
		level.player lightsetforplayer("betrayal_grungy");
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 50
betrayal_interior_darker_fog()
{
	self waittill("trigger");
	maps\_utility::vision_set_fog_changes("betrayal_interior_darker",3);
	level.player lightsetforplayer("betrayal_interior_darker");
}

//Function Number: 51
betrayal_roof_transition()
{
	self waittill("trigger");
	maps\_utility::vision_set_fog_changes("betrayal_grungy",1);
	level.player setclutforplayer("clut_betrayal_c3_01",1);
	level.player lightsetforplayer("betrayal_grungy");
	wait(3);
	level.player lightsetforplayer("betrayal_grungy_inside");
	wait(2);
	level.player lightsetforplayer("betrayal_grungy");
}

//Function Number: 52
lightset_betrayal_grungy_int()
{
	self waittill("trigger");
	maps\_utility::vision_set_fog_changes("betrayal_grungy_market_int",0.4);
	level.player lightsetforplayer("betrayal_grungy_inside");
}

//Function Number: 53
lightset_betrayal_grungy_out()
{
	self waittill("trigger");
	if(level.nextgen)
	{
		maps\_utility::vision_set_fog_changes("betrayal_grungy",1.5);
	}
	else
	{
		maps\_utility::vision_set_fog_changes("betrayal_grungy_market",0.4);
	}

	level.player lightsetforplayer("betrayal_grungy_market");
}

//Function Number: 54
visionset_betrayal_swim_tube()
{
	self waittill("trigger");
	if(level.nextgen)
	{
		maps\_utility::vision_set_fog_changes("betrayal_swim_tube",1);
		wait(8);
		level.player lightsetforplayer("betrayal_sewer");
		maps\_utility::vision_set_fog_changes("betrayal_sewer",3);
		var_00 = getentarray("sewer_light_1","targetname");
		thread blink_lights_flicker(var_00,9000,7000,100,5,1);
		level.player_dof_aperture = 8;
		level.player_dof_max_distance = 400;
		thread mblur_disable();
		return;
	}

	level.player_dof_aperture = 8;
	level.player_dof_max_distance = 400;
}

//Function Number: 55
lightset_betrayal_river_int()
{
	self waittill("trigger");
	betrayal_boat_vision_set_fog_changes("betrayal_boat_int",3);
	level.player lightsetforplayer("betrayal_grungy_inside");
}

//Function Number: 56
lightset_betrayal_river_out()
{
	self waittill("trigger");
	betrayal_boat_vision_set_fog_changes("betrayal_grungy_boat_chase",3);
	level.player lightsetforplayer("betrayal_grungy");
}

//Function Number: 57
update_sun_flare_position()
{
	self waittill("trigger");
	var_00 = getdvarfloat("r_lightTweakSunPitch");
	var_01 = getdvarfloat("r_lightTweakSunHeading");
	var_02 = (var_00,var_01,0);
	wait(1);
	maps\_shg_fx::set_sun_flare_position(var_02);
}

//Function Number: 58
intro_sun_flare_position()
{
	self waittill("trigger");
	var_00 = (-34.3,46.7,0);
	maps\_shg_fx::set_sun_flare_position(var_00);
}

//Function Number: 59
map_sun_flare_position()
{
	self waittill("trigger");
	var_00 = (-65,46.7,0);
	maps\_shg_fx::set_sun_flare_position(var_00);
}

//Function Number: 60
underwater_visionset_change(param_00)
{
	var_01 = 0;
	level notify("stop_swimming_change_fx");
	var_02 = "tag_origin";
	var_03 = level.player common_scripts\utility::spawn_tag_origin();
	var_03.angles = (0,0,0);
	var_03.origin = level.player geteye() - (0,0,0);
	var_03 linktoplayerview(level.player,"tag_origin",(70,0,-1),(-90,0,0),0);
	if(param_00)
	{
		var_03.origin = level.player geteye() - (0,0,0);
		maps\_utility::vision_set_fog_changes("betrayal_swim",0.02);
		common_scripts\_exploder::exploder(666);
		level.player_dof_aperture = 1.1;
		level.player_dof_max_distance = 100;
		if(level.nextgen)
		{
			setsaveddvar("r_chromaticAberration",1);
			setsaveddvar("r_chromaticSeparationR",2);
			setsaveddvar("r_chromaticSeparationG",-2);
			setsaveddvar("r_chromaticSeparationB",0);
			setsaveddvar("r_chromaticAberrationAlpha",0.7);
		}

		playfxontag(common_scripts\utility::getfx("screen_fx_plunge"),var_03,var_02);
		if(level.nextgen)
		{
			level.player lightsetforplayer("betrayal_boat");
		}

		maps\_water::setunderwateraudiozone();
		self playlocalsound("underwater_enter");
	}
	else
	{
		if(level.nextgen)
		{
			maps\_utility::fog_set_changes("betrayal",0.02);
			maps\_utility::vision_set_changes("neutral",1);
		}
		else
		{
			maps\_utility::vision_set_fog_changes("betrayal_grungy",1);
		}

		maps\_utility::pauseexploder(666);
		level.player_dof_aperture = 8;
		level.player_dof_max_distance = 400;
		if(level.nextgen)
		{
			setsaveddvar("r_chromaticAberration",1);
			setsaveddvar("r_chromaticSeparationR",0.5);
			setsaveddvar("r_chromaticSeparationG",-0.5);
			setsaveddvar("r_chromaticSeparationB",0);
			setsaveddvar("r_chromaticAberrationAlpha",0.5);
		}

		killfxontag(common_scripts\utility::getfx("screen_fx_plunge"),var_03,var_02);
		playfxontag(common_scripts\utility::getfx("screen_fx_emerge"),var_03,var_02);
		level.player lightsetforplayer("betrayal_grungy");
		maps\_water::clearunderwateraudiozone();
		self playlocalsound("breathing_better");
		self playlocalsound("underwater_exit");
		var_04 = undefined;
		if(isdefined(self.water_trigger_current))
		{
			var_04 = maps\_water::getwaterline(self.water_trigger_current);
		}

		if(isdefined(var_04))
		{
			var_05 = (self.origin[0],self.origin[1],var_04);
			playfx(level._effect["water_splash_emerge"],var_05,anglestoforward((0,self.angles[1],0) + (270,180,0)));
		}
	}

	var_03 thread underwater_visionset_change_cleanup();
}

//Function Number: 61
underwater_visionset_change_cleanup()
{
	level common_scripts\utility::waittill_any_timeout(1,"stop_swimming_change_fx");
	self unlink();
	self delete();
}

//Function Number: 62
betrayal_boat_vision_set_fog_changes(param_00,param_01)
{
	level.current_betrayal_boat_vision_fog = param_00;
	maps\_utility::vision_set_fog_changes(param_00,param_01);
}

//Function Number: 63
underwater_boat_visionset_change()
{
	var_00 = 0;
	var_01 = "tag_origin";
	var_02 = level.player_boat common_scripts\utility::spawn_tag_origin();
	var_02 linkto(level.player_boat,"tag_origin",(100,0,0),(-90,0,0));
	var_03 = level.player_boat common_scripts\utility::spawn_tag_origin();
	var_03 linkto(level.player_boat,"tag_origin",(800,0,-80),(-90,0,0));
	var_04 = level.player_boat common_scripts\utility::spawn_tag_origin();
	var_04 linkto(level.player_boat,"tag_origin",(1800,0,-80),(-90,0,0));
	var_05 = level.player_boat common_scripts\utility::spawn_tag_origin();
	var_05 linkto(level.player_boat,"tag_origin",(800,-1000,-80),(-90,0,0));
	var_06 = level.player_boat common_scripts\utility::spawn_tag_origin();
	var_06 linkto(level.player_boat,"tag_origin",(800,1000,-80),(-90,0,0));
	if(isdefined(level.current_betrayal_boat_vision_fog))
	{
		var_07 = level.current_betrayal_boat_vision_fog;
	}
	else
	{
		var_07 = "";
	}

	for(;;)
	{
		if(isdefined(level.player_boat))
		{
			var_08 = level.player_boat vehicle_diveboatissubmerged();
			if(var_08 != var_00)
			{
				if(var_08)
				{
					if(isdefined(level.current_betrayal_boat_vision_fog))
					{
						var_07 = level.current_betrayal_boat_vision_fog;
					}
					else
					{
						var_07 = "";
					}

					if(var_07 == "betrayal_boat_int")
					{
						betrayal_boat_vision_set_fog_changes("betrayal_underwater_int",0.02);
					}
					else
					{
						betrayal_boat_vision_set_fog_changes("betrayal_underwater",0.02);
					}

					level.player_dof_aperture = 1.1;
					level.player_dof_max_distance = 100;
					if(level.nextgen)
					{
						setsaveddvar("r_chromaticAberration",1);
						setsaveddvar("r_chromaticSeparationR",2);
						setsaveddvar("r_chromaticSeparationG",-2);
						setsaveddvar("r_chromaticSeparationB",0);
						setsaveddvar("r_chromaticAberrationAlpha",0.7);
					}

					level.player lightsetforplayer("betrayal_boat");
					level.player_boat thread maps\betrayal_fx::vm_boat_submerge_fx();
				}
				else
				{
					if(level.nextgen)
					{
						betrayal_boat_vision_set_fog_changes(var_07,0.02);
						level.player_dof_aperture = 8;
						level.player_dof_max_distance = 400;
						setsaveddvar("r_chromaticAberration",1);
						setsaveddvar("r_chromaticSeparationR",0.5);
						setsaveddvar("r_chromaticSeparationG",-0.5);
						setsaveddvar("r_chromaticSeparationB",0);
						setsaveddvar("r_chromaticAberrationAlpha",0.5);
					}

					if(level.nextgen)
					{
						level.player lightsetforplayer("betrayal_grungy_boat_chase");
					}
					else
					{
						level.player lightsetforplayer("betrayal_grungy_boat_chase");
						betrayal_boat_vision_set_fog_changes("betrayal_boat_chase",0.02);
					}

					level.player_boat thread maps\betrayal_fx::vm_boat_emerge_fx();
				}

				var_00 = var_08;
			}
		}

		wait 0.05;
	}
}

//Function Number: 64
exploder_pigeon()
{
	var_00 = 901;
	for(;;)
	{
		self waittill("trigger");
		common_scripts\_exploder::exploder(var_00);
		wait(1);
	}
}

//Function Number: 65
manhole_lighting()
{
	var_00 = getent("manhole_cover_2","targetname");
	var_01 = getent("oldtown_sewer_lid","targetname");
	var_01 overridelightingorigin(var_00.origin);
}