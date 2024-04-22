/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: greece_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 52
 * Decompile Time: 784 ms
 * Timestamp: 4/22/2024 2:31:07 AM
*******************************************************************/

//Function Number: 1
main()
{
	init_level_lighting_flags();
	thread setup_dof_presets();
	thread set_level_lighting_values();
	thread initsafehousexslice();
	thread initsafehouseintro();
	thread inittabletoverlay();
	thread initsafehousefollow();
	thread initsafehouseclearstart();
	thread setsafehouseextdrawdist();
	thread setsafehouseintdrawdist();
	thread lightintensityflicker("safehouse_computer_room_monitor_flicker","start_safehouse_computerlab_light_flicker","stop_safehouse_computerlab_light_flicker",500,2000,0.05,0.15);
	if(level.nextgen)
	{
		thread lightintensityflicker("safehouse_computer_room_monitor_main_flicker","start_safehouse_computerlab_light_flicker","stop_safehouse_computerlab_light_flicker",1,5000,0.1,0.25);
	}
	else
	{
		thread lightintensityflicker("safehouse_computer_room_monitor_main_flicker","start_safehouse_computerlab_light_flicker","stop_safehouse_computerlab_light_flicker",100,15000,0.1,0.25);
	}

	thread lightintensityflicker("halogen_flickering","halogen_flickering_jewelry_start","halogen_flickering_jewelry_stop",1,155000,0.1,0.25);
	thread initsafehousetransitionstart();
	thread initsafehouseexosuitup();
	thread initsafehouseexosuitupfadeout();
	thread initconfcenterstart();
	thread initbeginconfcentersupporta();
	thread initbeginconfcentersupportb();
	thread initbeginconfcentersupportc();
	thread initbeginconfcenterkill();
	thread initbeginconfcentercombat();
	thread initbeginconfcenteroutro();
	thread initsafehouseoutrostart();
	thread setalleystransitionculldist();
	thread initalleystransitionstart();
	thread initalleysstart();
	thread initsniperscrambleintro();
	thread initsniperscramblestarthotel();
	thread initsniperscrambledrones();
	thread initsniperscramblefinalelighting();
	thread initendingambushinteractlighting();
	thread ending_confculldist();
	thread preending_confculldist();
	thread endingambushvision();
	thread initendinghadesfight();
	if(level.nextgen)
	{
		setsaveddvar("r_hemiAoEnable",1);
	}

	if(level.currentgen)
	{
	}

	thread inittriggermultiplevisionlightset("alleys_store_aa","greece_alleys_start","greece_alleys_store_aa","alleys_start","alleys_store_aa",2);
	thread dynamic_dof(0.25,1.5,1,"init_tablet_overlay",1);
	thread setup_vfx_sunflare();
	thread setup_dof_safehouseintro();
	thread setup_dof_safehousefollow();
	thread setup_dof_takedownkill();
}

//Function Number: 2
inittriggermultiplevisionlightset(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = getent(param_00,"targetname");
	if(!isdefined(var_06))
	{
		iprintln("Failed to find Vision / LightSet Trigger:" + param_00);
		return;
	}

	var_06 thread triggermultiplevisionlightsetinternal(param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 3
triggermultiplevisionlightsetinternal(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 1;
	var_06 = 0;
	for(;;)
	{
		if(level.player istouching(self))
		{
			if(var_05)
			{
				if(param_01 != "none")
				{
					maps\_utility::vision_set_changes(param_01,param_04);
				}

				if(param_03 != "none")
				{
					level.player lightsetforplayer(param_03);
				}

				var_06 = 1;
				var_05 = 0;
			}
		}
		else if(var_06)
		{
			if(param_00 != "none")
			{
				maps\_utility::vision_set_changes(param_00,param_04);
			}

			if(param_02 != "none")
			{
				level.player lightsetforplayer(param_02);
			}

			var_06 = 0;
			var_05 = 1;
		}

		wait(0.2);
	}
}

//Function Number: 4
linearlerp(param_00,param_01,param_02)
{
	return abs(param_00 * 1 - param_02 + param_01 * param_02);
}

//Function Number: 5
dynamic_dof(param_00,param_01,param_02,param_03,param_04)
{
	if(!common_scripts\utility::flag("autofocus_loop_active"))
	{
		common_scripts\utility::flag_wait(param_03);
		var_05 = 10;
		while(common_scripts\utility::flag(param_03))
		{
			common_scripts\utility::flag_set("autofocus_loop_active");
			var_06 = 12000;
			var_07 = level.player getplayerangles();
			var_08 = anglestoforward(var_07);
			if(param_04)
			{
				var_09 = level.cameralinkpoint.origin;
			}
			else
			{
				var_09 = level.player.origin + (0,0,68);
			}

			var_0A = var_09 + var_08 * var_06;
			var_0B = bullettrace(var_09 + var_08 * 1,var_0A,0,undefined);
			var_0C = distance(var_09,var_0B["position"]);
			var_0D = var_0B["entity"];
			var_0E = var_0C;
			if(isdefined(var_0D))
			{
				if(isdefined(var_0D.origin))
				{
					var_0F = distance(var_09,var_0D.origin);
					if(var_0F < var_0C)
					{
						var_0E = var_0F;
					}
				}
			}

			var_10 = var_0E * param_00;
			var_10 = linearlerp(var_05,var_10,0.35);
			var_05 = var_10;
			level.dof["script"]["current"]["nearEnd"] = var_10;
			level.dof["script"]["current"]["farStart"] = var_0E;
			level.dof["script"]["current"]["farEnd"] = var_0E * param_01;
			level.dof["script"]["current"]["farBlur"] = param_02;
			wait 0.05;
		}

		wait 0.05;
		common_scripts\utility::flag_clear("autofocus_loop_active");
		wait 0.05;
		thread dynamic_dof(param_00,param_01,param_02,param_03,param_04);
	}
}

//Function Number: 6
autofocus_loop()
{
	common_scripts\utility::flag_wait("flag_autofocus_on");
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_enable",1);
	}

	level.player enablephysicaldepthoffieldscripting();
	wait 0.05;
	while(common_scripts\utility::flag("flag_autofocus_on") == 1)
	{
		wait 0.05;
		var_00 = trace_distance();
		level.player setphysicaldepthoffield(1.8,var_00);
	}

	level.player disablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
	}
}

//Function Number: 7
trace_distance()
{
	var_00 = 10000;
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

//Function Number: 8
lightintensityflicker(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = getent(param_00,"targetname");
	if(!isdefined(var_07))
	{
		return;
	}

	common_scripts\utility::flag_wait(param_01);
	common_scripts\utility::flag_clear(param_02);
	var_08 = 1;
	while(var_08)
	{
		var_09 = randomfloatrange(param_03,param_04);
		var_07 setlightintensity(var_09);
		if(common_scripts\utility::flag(param_02))
		{
			var_08 = 0;
			common_scripts\utility::flag_clear(param_01);
			thread lightintensityflicker(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
			continue;
		}

		wait(randomfloatrange(param_05,param_06));
	}
}

//Function Number: 9
set_level_lighting_values()
{
	if(isusinghdr())
	{
		setsaveddvar("r_disableLightSets",0);
		setsaveddvar("r_aodiminish",0.1);
		maps\_utility::vision_set_fog_changes("greece",0);
		level.player lightsetforplayer("greece");
		if(level.nextgen)
		{
			level.player setclutforplayer("clut_greece_safehouse_start_aa",1);
		}
	}

	maps\_lighting::blend_dof_presets("default","greece_safehouse_intro",1);
}

//Function Number: 10
init_level_lighting_flags()
{
	common_scripts\utility::flag_init("init_safehouse_intro_lighting");
	common_scripts\utility::flag_init("init_tablet_overlay");
	common_scripts\utility::flag_init("init_safehouse_follow_lighting");
	common_scripts\utility::flag_init("init_safehouse_takedown_kill");
	common_scripts\utility::flag_init("init_safehouse_xslice");
	common_scripts\utility::flag_init("safehouse_terrace_int");
	common_scripts\utility::flag_init("safehouse_terrace_ext");
	common_scripts\utility::flag_init("init_safehouse_melee_kill_initiated_post");
	common_scripts\utility::flag_init("init_safehouse_clear_start_lighting");
	common_scripts\utility::flag_init("start_safehouse_computerlab_light_flicker");
	common_scripts\utility::flag_init("stop_safehouse_computerlab_light_flicker");
	common_scripts\utility::flag_init("init_safehouse_transition_start_lighting");
	common_scripts\utility::flag_init("greece_safehouse_exso_dressup");
	common_scripts\utility::flag_init("greece_safehouse_exso_dressup_fadeout");
	common_scripts\utility::flag_init("init_confcenter_start_lighting");
	common_scripts\utility::flag_init("init_begin_confcenter_support_a_lighting");
	common_scripts\utility::flag_init("init_begin_confcenter_support_b_lighting");
	common_scripts\utility::flag_init("init_begin_confcenter_support_c_lighting");
	common_scripts\utility::flag_init("init_begin_confcenter_kill_lighting");
	common_scripts\utility::flag_init("init_begin_confcenter_combat_lighting");
	common_scripts\utility::flag_init("init_begin_confcenter_outro_lighting");
	common_scripts\utility::flag_init("init_safehouse_outro_start_lighting");
	common_scripts\utility::flag_init("init_alleys_transition_start_lighting");
	common_scripts\utility::flag_init("init_alleys_lighting");
	common_scripts\utility::flag_init("init_sniper_scramble_lighting");
	common_scripts\utility::flag_init("init_sniper_scramble_hotel_lighting");
	common_scripts\utility::flag_init("init_sniper_scramble_drones_lighting");
	common_scripts\utility::flag_init("init_sniper_scramble_finale_lighting");
	common_scripts\utility::flag_init("init_ending_ambush_interact_lighting_level");
	common_scripts\utility::flag_init("Init_FlagEndingSetAmbushInteractBeginLighting");
	common_scripts\utility::flag_init("init_ending_hades_fight");
	common_scripts\utility::flag_init("halogen_flickering_jewelry_start");
	common_scripts\utility::flag_init("halogen_flickering_jewelry_stop");
	common_scripts\utility::flag_init("init_dynamic_dof");
	common_scripts\utility::flag_init("flag_autofocus_on");
	common_scripts\utility::flag_init("autofocus_loop_active");
	common_scripts\utility::flag_init("pre_ending_conf_culldist");
	common_scripts\utility::flag_init("ending_conf_culldist");
}

//Function Number: 11
setup_dof_presets()
{
	if(level.nextgen)
	{
		maps\_lighting::create_dof_preset("greece",10,18,4,2500,38000,0.964,0.5);
		maps\_lighting::create_dof_preset("greece_safehouse_intro",10,18,4,2500,38000,0.964,0.5);
		maps\_lighting::create_dof_preset("greece_safehouse_takedown_kill",0,0,4,0,50,2,0.5);
		maps\_lighting::create_dof_preset("greece_safehouse_exso_dressup_fov",0,0,4,10,200,4,0.5);
		maps\_lighting::create_dof_preset("greece_safehouse_transition_start",10,18,4,2500,38000,0.964,0.5);
		maps\_lighting::create_dof_preset("greece_confcenter_start",10,18,4,2500,38000,0.964,0.5);
		maps\_lighting::create_dof_preset("greece_confcenter_begin_support_a",10,18,4,1000,22360,1.8,0.5);
		maps\_lighting::create_dof_preset("greece_confcenter_begin_support_b",10,18,4,1500,30000,0.964,0.5);
		maps\_lighting::create_dof_preset("greece_confcenter_begin_support_c",10,18,4,1500,30000,0.964,0.5);
		maps\_lighting::create_dof_preset("greece_confcenter_begin_kill",10,18,4,2500,38000,0.964,0.5);
		maps\_lighting::create_dof_preset("greece_confcenter_begin_combat",10,18,4,2500,38000,0.964,0.5);
		maps\_lighting::create_dof_preset("greece_confcenter_begin_outro",10,18,4,2500,38000,0.964,0.5);
		maps\_lighting::create_dof_preset("greece_safehouse_outro_start",10,18,4,2500,38000,0.964,0.5);
		maps\_lighting::create_dof_preset("greece_alleys_transition_start",10,18,4,2500,38000,0.964,0.5);
		maps\_lighting::create_dof_preset("greece_alleys_start",10,18,4,2500,38000,0.964,0.5);
		maps\_lighting::create_dof_viewmodel_preset("greece_drone_dof",7,15);
		return;
	}

	maps\_lighting::create_dof_preset("greece",10,18,2,2500,38000,0.564,0.5);
	maps\_lighting::create_dof_preset("greece_safehouse_intro",10,18,2,2500,38000,0.564,0.5);
	maps\_lighting::create_dof_preset("greece_safehouse_takedown_kill",0,0,2,0,50,2,0.5);
	maps\_lighting::create_dof_preset("greece_safehouse_exso_dressup_fov",0,0,2,10,200,3,0.5);
	maps\_lighting::create_dof_preset("greece_safehouse_transition_start",10,18,2,2500,38000,0.564,0.5);
	maps\_lighting::create_dof_preset("greece_confcenter_start",10,18,2,2500,38000,0.564,0.5);
	maps\_lighting::create_dof_preset("greece_confcenter_begin_support_a",10,60,4,6373,30471,2.12,0.5);
	maps\_lighting::create_dof_preset("greece_confcenter_begin_support_b",10,18,2,1500,30000,0.564,0.5);
	maps\_lighting::create_dof_preset("greece_confcenter_begin_support_c",10,18,2,1500,30000,0.564,0.5);
	maps\_lighting::create_dof_preset("greece_confcenter_begin_kill",10,18,2,2500,38000,0.564,0.5);
	maps\_lighting::create_dof_preset("greece_confcenter_begin_combat",10,18,2,2500,38000,0.564,0.5);
	maps\_lighting::create_dof_preset("greece_confcenter_begin_outro",10,18,2,2500,38000,0.564,0.5);
	maps\_lighting::create_dof_preset("greece_safehouse_outro_start",10,18,2,2500,38000,0.564,0.5);
	maps\_lighting::create_dof_preset("greece_alleys_transition_start",10,18,2,2500,38000,0.564,0.5);
	maps\_lighting::create_dof_preset("greece_alleys_start",10,18,2,2500,38000,0.564,0.5);
	maps\_lighting::create_dof_viewmodel_preset("greece_drone_dof",7,15);
}

//Function Number: 12
hack_lighttweaks_enable(param_00)
{
	wait(0.1);
}

//Function Number: 13
setup_vfx_sunflare()
{
	thread maps\_shg_fx::fx_spot_lens_flare_dir("sunflare",(-15.2216,146.493,0),10000);
}

//Function Number: 14
initsafehouseintro()
{
	common_scripts\utility::flag_wait("init_safehouse_intro_lighting");
	if(level.currentgen)
	{
		setculldist(0);
		var_00 = getent("vista_buildings_intro","targetname");
		if(isdefined(var_00))
		{
			var_00 hide();
		}
	}
	else
	{
		setculldist(0);
	}

	maps\_utility::vision_set_fog_changes("greece_safehouse_intro",0);
	maps\_lighting::blend_dof_presets("default","greece_safehouse_intro",1);
	level.player lightsetforplayer("safehouse_intro");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_greece_safehouse_start_aa",0);
	}

	thread setup_ilona_lighting();
}

//Function Number: 15
setup_ilona_lighting()
{
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_bokehEnable",1);
		var_00 = getent("char_fill","targetname");
		thread maps\_lighting::set_spot_intensity("char_fill",5000);
		var_00 setlightradius(120);
		var_00 setlightfovrange(110,20);
		var_01 = getent("char_rim","targetname");
		thread maps\_lighting::set_spot_intensity("char_rim",50000);
		var_01 setlightradius(120);
		var_01 setlightfovrange(110,20);
	}

	var_02 = getent("ilona_lighting_centroid","targetname");
	level.allies["Ilona"] overridelightingorigin(var_02.origin);
}

//Function Number: 16
inittabletoverlay()
{
	common_scripts\utility::flag_wait("init_tablet_overlay");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_greece_security_cam",0);
	}
	else
	{
		maps\_utility::vision_set_fog_changes("greece_tablet_overlay",0);
	}

	setsaveddvar("r_dof_physical_hipenable",1);
	setsaveddvar("r_dof_physical_hipFstop",1.5);
	if(level.currentgen)
	{
		setculldist(6500);
		var_00 = getent("vista_buildings_intro","targetname");
		if(isdefined(var_00))
		{
			var_00 show();
		}
	}
	else
	{
		setculldist(0);
	}

	common_scripts\utility::flag_clear("init_tablet_overlay");
}

//Function Number: 17
setup_dof_safehouseintro()
{
	common_scripts\utility::flag_wait("init_safehouse_intro_lighting");
	wait(2);
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_enable",1);
	}

	setsaveddvar("r_dof_physical_hipenable",0);
	level.player enablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		level.player setphysicaldepthoffield(2,450,2,2);
		wait(3);
		level.player setphysicaldepthoffield(3,70,2,2);
		wait(8);
		level.player setphysicaldepthoffield(3,54);
		wait(5);
		level.player setphysicaldepthoffield(3,60);
	}
	else
	{
		level.player setphysicaldepthoffield(3,450,2,2);
		wait(3);
		level.player setphysicaldepthoffield(2.8,60,2,2);
		wait(8);
		level.player setphysicaldepthoffield(3,54);
		wait(5);
		level.player setphysicaldepthoffield(3,60);
	}

	common_scripts\utility::flag_wait("FlagScanTargetBegin");
	level.player disablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_hipenable",0);
	}

	wait(2);
	maps\_lighting::blend_dof_presets("default","greece_safehouse_intro",1);
}

//Function Number: 18
initsafehousefollow()
{
	common_scripts\utility::flag_wait("init_safehouse_follow_lighting");
	common_scripts\utility::flag_clear("init_tablet_overlay");
	if(level.currentgen)
	{
		setculldist(0);
		var_00 = getent("vista_buildings_intro","targetname");
		if(isdefined(var_00))
		{
			var_00 show();
		}
	}
	else
	{
		setculldist(0);
	}

	maps\_utility::vision_set_fog_changes("greece_safehouse_intro",1);
	level.player lightsetforplayer("safehouse_intro");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_greece_safehouse_start_aa",0);
	}

	thread setup_ilona_lighting();
	setsaveddvar("r_dof_physical_hipenable",0);
}

//Function Number: 19
setup_dof_safehousefollow()
{
	common_scripts\utility::flag_wait("init_safehouse_follow_lighting");
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_enable",1);
	}

	level.player enablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		level.player setphysicaldepthoffield(8,14,20,20);
		wait(2);
		level.player setphysicaldepthoffield(12,55,2,2);
		wait(4);
		level.player setphysicaldepthoffield(3.8,26,2,2);
		wait(1.5);
		level.player setphysicaldepthoffield(8,70,1,2);
	}
	else
	{
		level.player setphysicaldepthoffield(5,14,20,20);
		wait(1.5);
		level.player setphysicaldepthoffield(3.8,55,7,7);
		wait(2);
		level.player setphysicaldepthoffield(4.8,26,7,7);
		wait(4.5);
		level.player setphysicaldepthoffield(11,250,1,2);
	}

	wait(5);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable",0);
		level.player disablephysicaldepthoffieldscripting();
	}

	var_00 = getent("ilona_lighting_centroid","targetname");
	level.allies["Ilona"] defaultlightingorigin();
	if(level.nextgen)
	{
	}

	if(!common_scripts\utility::flag("flag_autofocus_on"))
	{
		common_scripts\utility::flag_set("flag_autofocus_on");
		thread dynamic_dof(0.015,5,0.8,"flag_autofocus_on",0);
	}
}

//Function Number: 20
inittakedownkill()
{
	maps\_lighting::blend_dof_presets("greece_safehouse_intro","greece_safehouse_takedown_kill",0.5);
	wait(4);
	wait(1);
	maps\_lighting::blend_dof_presets("greece_safehouse_takedown_kill","greece_safehouse_intro",1);
}

//Function Number: 21
initsafehousetakedownkill()
{
	common_scripts\utility::flag_wait("init_safehouse_melee_kill_initiated_post");
	if(level.currentgen)
	{
		setculldist(3000);
		var_00 = getent("vista_buildings_intro","targetname");
		if(isdefined(var_00))
		{
			var_00 hide();
		}
	}
	else
	{
		setculldist(3000);
	}

	thread inittakedownkill();
}

//Function Number: 22
setup_dof_takedownkill()
{
	common_scripts\utility::flag_wait("init_safehouse_melee_kill_initiated_post");
	thread inittakedownkill();
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable",2);
		setsaveddvar("r_mbVelocityScalar",0.5);
		setsaveddvar("r_dof_physical_enable",1);
	}

	level.player enablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
		level.player setphysicaldepthoffield(6,20);
		wait(0.5);
		level.player setphysicaldepthoffield(6,20);
		wait(0.5);
		level.player setphysicaldepthoffield(6,70);
		wait(0.5);
		level.player setphysicaldepthoffield(6,26);
		wait(0.5);
		level.player setphysicaldepthoffield(6,7.5);
		wait(1.5);
		level.player setphysicaldepthoffield(6,20);
		wait(1);
		level.player setphysicaldepthoffield(12,350);
		wait(2);
		level.player setphysicaldepthoffield(12,40);
		wait(1);
		level.player setphysicaldepthoffield(12,250);
	}
	else
	{
		level.player setphysicaldepthoffield(5.2,20);
		wait(0.5);
		level.player setphysicaldepthoffield(5.2,20);
		wait(0.5);
		level.player setphysicaldepthoffield(5.2,70);
		wait(0.5);
		level.player setphysicaldepthoffield(5.2,26);
		wait(0.5);
		level.player setphysicaldepthoffield(5.2,7.5);
		wait(1.5);
		level.player setphysicaldepthoffield(5.2,20);
		wait(1);
		level.player setphysicaldepthoffield(9,350);
		wait(2);
		level.player setphysicaldepthoffield(9,40);
		wait(1);
		level.player setphysicaldepthoffield(9,250);
	}

	wait(1);
	level.player disablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
	}

	wait(0.2);
	wait(1);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable",0);
	}

	maps\_lighting::blend_dof_presets("default","greece_safehouse_transition_start",1);
}

//Function Number: 23
initsafehousexslice()
{
	common_scripts\utility::flag_wait("init_safehouse_xslice");
	if(level.currentgen)
	{
		setculldist(3000);
		var_00 = getent("vista_buildings_intro","targetname");
		if(isdefined(var_00))
		{
			var_00 show();
		}
	}
	else
	{
		setculldist(3000);
	}

	maps\_utility::vision_set_fog_changes("greece_safehouse_intro",0);
	maps\_lighting::blend_dof_presets("default","greece_safehouse_intro",0);
	level.player lightsetforplayer("safehouse_intro");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_greece_safehouse_start_aa",0);
	}
}

//Function Number: 24
initsafehouseclearstart()
{
	common_scripts\utility::flag_wait("init_safehouse_clear_start_lighting");
	if(level.currentgen)
	{
		setculldist(3000);
		var_00 = getent("vista_buildings_intro","targetname");
		if(isdefined(var_00))
		{
			var_00 show();
		}
	}
	else
	{
		setculldist(3000);
	}

	maps\_utility::vision_set_fog_changes("greece_safehouse_intro",0);
	maps\_lighting::blend_dof_presets("default","greece_safehouse_intro",0);
	level.player lightsetforplayer("safehouse_intro");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_greece_safehouse_start_aa",3);
	}

	common_scripts\utility::flag_set("start_safehouse_computerlab_light_flicker");
}

//Function Number: 25
setsafehouseextdrawdist()
{
	common_scripts\utility::flag_wait("safehouse_terrace_ext");
	if(level.currentgen)
	{
		setculldist(0);
		var_00 = getent("vista_buildings_intro","targetname");
		if(isdefined(var_00))
		{
			var_00 show();
		}

		common_scripts\utility::flag_clear("safehouse_terrace_ext");
		thread setsafehouseextdrawdist();
	}
}

//Function Number: 26
setsafehouseintdrawdist()
{
	common_scripts\utility::flag_wait("safehouse_terrace_int");
	if(level.currentgen)
	{
		setculldist(3000);
		var_00 = getent("vista_buildings_intro","targetname");
		if(isdefined(var_00))
		{
			var_00 show();
		}

		common_scripts\utility::flag_clear("safehouse_terrace_int");
		thread setsafehouseintdrawdist();
	}
}

//Function Number: 27
initsafehousetransitionstart()
{
	common_scripts\utility::flag_wait("init_safehouse_transition_start_lighting");
	if(level.currentgen)
	{
		setculldist(3000);
		var_00 = getent("vista_buildings_intro","targetname");
		if(isdefined(var_00))
		{
			var_00 show();
		}
	}
	else
	{
		setculldist(0);
	}

	maps\_utility::vision_set_fog_changes("greece_safehouse_dark",1);
	maps\_lighting::blend_dof_presets("default","greece_safehouse_intro",1);
	level.player lightsetforplayer("safehouse_dark");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_greece_safehouse_start_aa",3);
	}
}

//Function Number: 28
initsafehouseexosuitup()
{
	common_scripts\utility::flag_wait("greece_safehouse_exso_dressup");
	maps\_lighting::blend_dof_presets("greece_safehouse_intro","greece_safehouse_exso_dressup_fov",6);
}

//Function Number: 29
initsafehouseexosuitupfadeout()
{
	common_scripts\utility::flag_wait("greece_safehouse_exso_dressup_fadeout");
	maps\_lighting::blend_dof_presets("greece_safehouse_exso_dressup_fov","greece_safehouse_intro",2);
}

//Function Number: 30
hackenablevisiontweaks()
{
}

//Function Number: 31
setup_dof_drone()
{
	setsaveddvar("r_dof_physical_hipEnable",1);
	setsaveddvar("r_dof_physical_hipFstop",0.15);
	setsaveddvar("r_dof_physical_hipSharpCocDiameter",0.05);
	setsaveddvar("r_dof_physical_hipFocusSpeed",32,32,32,32);
}

//Function Number: 32
initconfcenterstart()
{
	common_scripts\utility::flag_wait("init_confcenter_start_lighting");
	if(level.currentgen)
	{
		setculldist(0);
	}
	else
	{
		setculldist(0);
	}

	maps\_utility::vision_set_fog_changes("greece_confcenter_begin_support_a",0);
	maps\_lighting::blend_dof_presets("default","greece_confcenter_begin_support_a",0);
	level.player lightsetforplayer("confcenter_start");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_greece_conference_center_aa",0);
	}

	common_scripts\utility::flag_set("stop_safehouse_computerlab_light_flicker");
	thread setup_dof_drone();
}

//Function Number: 33
initbeginconfcentersupporta()
{
	common_scripts\utility::flag_wait("init_begin_confcenter_support_a_lighting");
	if(level.currentgen)
	{
		setculldist(0);
	}
	else
	{
		setculldist(0);
	}

	level.player enableforceviewmodeldof();
	maps\_utility::vision_set_fog_changes("greece_confcenter_begin_support_a",0);
	maps\_lighting::blend_dof_presets("default","greece_confcenter_begin_support_a",0);
	maps\_lighting::blend_dof_viewmodel_presets("default","greece_drone_dof",0.1);
	level.player lightsetforplayer("confcenter_start");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_greece_conference_center_aa",0);
	}

	thread setup_dof_drone();
}

//Function Number: 34
initbeginconfcentersupportb()
{
	common_scripts\utility::flag_wait("init_begin_confcenter_support_b_lighting");
	if(level.currentgen)
	{
		setculldist(0);
	}
	else
	{
		setculldist(0);
	}

	maps\_utility::vision_set_fog_changes("greece_confcenter_begin_support_a",0);
	maps\_lighting::blend_dof_presets("default","greece_confcenter_begin_support_a",0);
	maps\_lighting::blend_dof_viewmodel_presets("default","greece_drone_dof",0.1);
	thread hackenablevisiontweaks();
	level.player lightsetforplayer("confcenter_start");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_greece_conference_center_aa",0);
	}

	thread setup_dof_drone();
}

//Function Number: 35
initbeginconfcentersupportc()
{
	common_scripts\utility::flag_wait("init_begin_confcenter_support_c_lighting");
	if(level.currentgen)
	{
		setculldist(0);
	}
	else
	{
		setculldist(0);
	}

	maps\_utility::vision_set_fog_changes("greece_confcenter_begin_support_a",0);
	maps\_lighting::blend_dof_presets("default","greece_confcenter_begin_support_a",0);
	maps\_lighting::blend_dof_viewmodel_presets("default","greece_drone_dof",0.1);
	thread hackenablevisiontweaks();
	level.player lightsetforplayer("confcenter_start");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_greece_conference_center_aa",0);
	}

	thread setup_dof_drone();
}

//Function Number: 36
initbeginconfcenterkill()
{
	common_scripts\utility::flag_wait("init_begin_confcenter_kill_lighting");
	if(level.currentgen)
	{
		setculldist(0);
	}
	else
	{
		setculldist(0);
	}

	maps\_utility::vision_set_fog_changes("greece_confcenter_begin_support_a",0);
	maps\_lighting::blend_dof_presets("default","greece_confcenter_begin_support_a",0);
	level.player lightsetforplayer("confcenter_start");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_greece_conference_center_aa",0);
	}

	thread setup_dof_drone();
}

//Function Number: 37
initbeginconfcentercombat()
{
	common_scripts\utility::flag_wait("init_begin_confcenter_combat_lighting");
	if(level.currentgen)
	{
		setculldist(0);
	}
	else
	{
		setculldist(0);
	}

	maps\_utility::vision_set_fog_changes("greece_confcenter_begin_support_a",0);
	maps\_lighting::blend_dof_presets("default","greece_confcenter_begin_support_a",0);
	level.player lightsetforplayer("confcenter_start");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_greece_conference_center_aa",0);
	}

	thread setup_dof_drone();
}

//Function Number: 38
initbeginconfcenteroutro()
{
	common_scripts\utility::flag_wait("init_begin_confcenter_outro_lighting");
	if(level.currentgen)
	{
		setculldist(0);
	}
	else
	{
		setculldist(0);
	}

	maps\_utility::vision_set_fog_changes("greece_confcenter_begin_support_a",0);
	maps\_lighting::blend_dof_presets("default","greece_confcenter_begin_support_a",0);
	level.player lightsetforplayer("confcenter_start");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_greece_conference_center_aa",0);
	}

	thread setup_dof_drone();
}

//Function Number: 39
initsafehouseoutrostart()
{
	common_scripts\utility::flag_wait("init_safehouse_outro_start_lighting");
	setsaveddvar("r_dof_physical_hipenable",0);
	if(level.currentgen)
	{
		setculldist(0);
		var_00 = getent("vista_buildings_intro","targetname");
		if(isdefined(var_00))
		{
			var_00 show();
		}
	}
	else
	{
		setculldist(0);
	}

	if(level.nextgen)
	{
	}

	thread handlesafehouseoutroblur();
	maps\_utility::vision_set_fog_changes("greece_safehouse_outro_start",0);
	level.player lightsetforplayer("safehouse_outro_start");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_greece_safehouse_start_aa",0);
	}

	common_scripts\utility::flag_set("start_safehouse_computerlab_light_flicker");
	common_scripts\utility::flag_wait("FlagTriggerExitPlayerComingDownStairs");
	var_01 = getent("light_cuc_greece_bullets_ent","targetname");
	var_02 = getent("safehouse_windowblast_light","targetname");
	if(isdefined(var_01) && isdefined(var_02))
	{
		var_01 setlightshadowstate("force_on");
		thread maps\_lighting::lerp_spot_intensity("light_cuc_greece_bullets_ent",1,1);
		wait(1);
		thread maps\_lighting::lerp_spot_intensity("light_cuc_greece_bullets_ent",1,0.1);
		var_02 setlightshadowstate("force_on");
		thread maps\_lighting::lerp_spot_intensity("safehouse_windowblast_light",3,75000);
		common_scripts\utility::flag_wait("FlagTriggerExitPlayerLeavingBuilding");
		var_01 setlightshadowstate("normal");
		thread maps\_lighting::lerp_spot_intensity("safehouse_windowblast_light",2,0.1);
	}
}

//Function Number: 40
handlesafehouseoutroblur()
{
	wait(3);
	if(!common_scripts\utility::flag("flag_autofocus_on"))
	{
		common_scripts\utility::flag_set("flag_autofocus_on");
		thread dynamic_dof(0.015,5,0.8,"flag_autofocus_on",0);
	}

	maps\_lighting::blend_dof_presets("default","greece_safehouse_outro_start",0);
	level.player setviewmodeldepthoffield(1,0);
}

//Function Number: 41
setalleystransitionculldist()
{
	common_scripts\utility::flag_wait("FlagTriggerAlleysTransitionStreet");
	if(level.currentgen)
	{
		setculldist(6500);
		return;
	}

	setculldist(6500);
}

//Function Number: 42
initalleystransitionstart()
{
	common_scripts\utility::flag_wait("init_alleys_transition_start_lighting");
	wait(2);
	if(level.currentgen)
	{
		setculldist(6500);
		var_00 = getent("vista_buildings_intro","targetname");
		if(isdefined(var_00))
		{
			var_00 show();
		}
	}
	else
	{
		setculldist(6500);
	}

	if(!common_scripts\utility::flag("flag_autofocus_on"))
	{
		common_scripts\utility::flag_set("flag_autofocus_on");
		thread dynamic_dof(0.015,5,0.8,"flag_autofocus_on",0);
	}

	maps\_utility::vision_set_fog_changes("greece_alleys_transition_start",3);
	level.player lightsetforplayer("alleys_transition_start");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_greece_safehouse_start_aa",2);
	}
}

//Function Number: 43
initalleysstart()
{
	common_scripts\utility::flag_wait("init_alleys_lighting");
	if(level.currentgen)
	{
		setculldist(3000);
		var_00 = getent("vista_buildings_intro","targetname");
		if(isdefined(var_00))
		{
			var_00 show();
		}
	}
	else
	{
		setculldist(3000);
	}

	if(!common_scripts\utility::flag("flag_autofocus_on"))
	{
		common_scripts\utility::flag_set("flag_autofocus_on");
		thread dynamic_dof(0.015,5,0.8,"flag_autofocus_on",0);
	}

	maps\_utility::vision_set_fog_changes("greece_alleys_start",1);
	maps\_lighting::blend_dof_presets("default","greece_alleys_start",0);
	level.player lightsetforplayer("alleys_start");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_greece_safehouse_start_aa",1);
	}

	common_scripts\utility::flag_set("stop_safehouse_computerlab_light_flicker");
	common_scripts\utility::flag_set("halogen_flickering_jewelry_start");
}

//Function Number: 44
initsniperscrambleintro()
{
	common_scripts\utility::flag_wait("FlagSniperScrambleStart");
	if(level.currentgen)
	{
		setculldist(5000);
		var_00 = getent("vista_buildings_intro","targetname");
		if(isdefined(var_00))
		{
			var_00 hide();
		}
	}
	else
	{
		setculldist(0);
	}

	if(!common_scripts\utility::flag("flag_autofocus_on"))
	{
		common_scripts\utility::flag_set("flag_autofocus_on");
		thread dynamic_dof(0.015,5,0.8,"flag_autofocus_on",0);
	}

	maps\_utility::vision_set_fog_changes("greece_sniper_scramble_start",0);
	level.player lightsetforplayer("sniper_scramble_start");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_greece_safehouse_start_aa",2);
	}
}

//Function Number: 45
initsniperscramblestarthotel()
{
	common_scripts\utility::flag_wait("init_sniper_scramble_hotel_lighting");
	if(level.currentgen)
	{
		setculldist(9000);
		var_00 = getent("vista_buildings_intro","targetname");
		if(isdefined(var_00))
		{
			var_00 hide();
		}
	}
	else
	{
		setculldist(0);
	}

	if(!common_scripts\utility::flag("flag_autofocus_on"))
	{
		common_scripts\utility::flag_set("flag_autofocus_on");
		thread dynamic_dof(0.015,5,0.8,"flag_autofocus_on",0);
	}

	if(level.nextgen)
	{
		maps\_utility::vision_set_fog_changes("greece_sniper_scramble_start",0);
	}
	else
	{
		maps\_utility::vision_set_fog_changes("greece_sniper_scramble",0);
	}

	level.player lightsetforplayer("sniper_scramble_start");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_greece_safehouse_start_aa",0);
	}
}

//Function Number: 46
initsniperscrambledrones()
{
	common_scripts\utility::flag_wait("init_sniper_scramble_drones_lighting");
	if(level.currentgen)
	{
		setculldist(9000);
		var_00 = getent("vista_buildings_intro","targetname");
		if(isdefined(var_00))
		{
			var_00 hide();
		}
	}
	else
	{
		setculldist(0);
	}

	if(!common_scripts\utility::flag("flag_autofocus_on"))
	{
		common_scripts\utility::flag_set("flag_autofocus_on");
		thread dynamic_dof(0.015,5,0.8,"flag_autofocus_on",0);
	}

	if(level.nextgen)
	{
		maps\_utility::vision_set_fog_changes("greece_sniper_scramble_start",0);
	}
	else
	{
		maps\_utility::vision_set_fog_changes("greece_sniper_scramble",0);
	}

	level.player lightsetforplayer("sniper_scramble_start");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_greece_safehouse_start_aa",0);
	}
}

//Function Number: 47
initsniperscramblefinalelighting()
{
	common_scripts\utility::flag_wait("init_sniper_scramble_finale_lighting");
	if(level.currentgen)
	{
		setculldist(9000);
		var_00 = getent("vista_buildings_intro","targetname");
		if(isdefined(var_00))
		{
			var_00 hide();
		}
	}
	else
	{
		setculldist(0);
	}

	if(!common_scripts\utility::flag("flag_autofocus_on"))
	{
		common_scripts\utility::flag_set("flag_autofocus_on");
		thread dynamic_dof(0.015,5,0.8,"flag_autofocus_on",0);
	}

	if(level.nextgen)
	{
		maps\_utility::vision_set_fog_changes("greece_sniper_scramble_start",0);
	}
	else
	{
		maps\_utility::vision_set_fog_changes("greece_sniper_scramble",0);
	}

	level.player lightsetforplayer("sniper_scramble_start");
	if(level.nextgen)
	{
		level.player setclutforplayer("clut_greece_safehouse_start_aa",0);
	}

	common_scripts\utility::flag_wait("FlagScrambleSniperKilled");
	maps\_utility::vision_set_fog_changes("greece_convoy_explosion",0.25);
	wait(0.12);
	maps\_utility::vision_set_fog_changes("greece_sniper_scramble_start",0.25);
	common_scripts\utility::flag_wait("FlagScramblePlayerStartMoveTruck");
	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_enable",1);
		level.player enablephysicaldepthoffieldscripting();
		setsaveddvar("r_mbEnable",2);
		setsaveddvar("r_mbVelocityScalar",0.5);
		level.player setphysicaldepthoffield(3,54);
		wait(3.5);
		level.player setphysicaldepthoffield(3,55);
		wait(1.5);
		level.player setphysicaldepthoffield(6,45);
		wait(1.5);
		level.player setphysicaldepthoffield(8,55);
		wait(0.5);
		level.player setphysicaldepthoffield(12,160);
		wait(0.5);
		if(level.nextgen)
		{
			setsaveddvar("r_mbEnable",0);
		}
	}
	else
	{
		level.player setphysicaldepthoffield(4,54);
		wait(4);
		level.player setphysicaldepthoffield(4,13);
		wait(4);
		level.player setphysicaldepthoffield(3,26);
	}

	wait(0.5);
	level.player disablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
	}

	wait(0.2);
	maps\_lighting::blend_dof_presets("default","greece_safehouse_intro",1);
}

//Function Number: 48
initendingambushinteractlighting()
{
	common_scripts\utility::flag_wait("init_ending_ambush_interact_lighting_level");
	level.player lightsetforplayer("sniper_scramble_start");
	if(level.currentgen)
	{
		setculldist(10000);
		var_00 = getent("vista_buildings_intro","targetname");
		if(isdefined(var_00))
		{
			var_00 hide();
		}
	}
	else
	{
		setculldist(10000);
	}

	if(level.nextgen)
	{
		level.player setclutforplayer("clut_greece_safehouse_start_aa",2);
		setsaveddvar("r_mbEnable",2);
		setsaveddvar("r_mbVelocityScalar",0.5);
	}
	else
	{
		maps\_utility::vision_set_fog_changes("greece_sniper_scramble",1);
	}

	if(level.nextgen)
	{
		setsaveddvar("r_dof_physical_enable",1);
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(8,16,2,2);
		wait(0.5);
		level.player setphysicaldepthoffield(18,330,2,2);
		wait(2.2);
		level.player setphysicaldepthoffield(3,17,2,2);
		wait(1);
		level.player setphysicaldepthoffield(6,115,2,2);
		wait(1);
		level.player setphysicaldepthoffield(8,40,2,2);
		wait(1);
		level.player setphysicaldepthoffield(12,110,2,2);
		wait(1);
		level.player setphysicaldepthoffield(18,348,2,2);
		wait(3);
		level.player setphysicaldepthoffield(22,850,2,2);
		wait(2);
		level.player setphysicaldepthoffield(22,13,2,2);
		wait(1);
		level.player setphysicaldepthoffield(22,320,2,2);
		wait(2.5);
		level.player setphysicaldepthoffield(32,389,2,2);
		wait(0.5);
	}
	else
	{
		level.player setphysicaldepthoffield(2,16,2,2);
		wait(2);
		level.player setphysicaldepthoffield(4,30,2,2);
		wait(1);
		level.player setphysicaldepthoffield(6,234,2,2);
		wait(1);
		level.player setphysicaldepthoffield(6,155,2,2);
		wait(1);
		level.player setphysicaldepthoffield(9,51,2,2);
		wait(1);
		level.player setphysicaldepthoffield(13,127,2,2);
		wait(1);
		level.player setphysicaldepthoffield(19,348,2,2);
		wait(3);
		level.player setphysicaldepthoffield(23,850,2,2);
		wait(2);
		level.player setphysicaldepthoffield(23,13,2,2);
		wait(1);
		level.player setphysicaldepthoffield(23,320,2,2);
		wait(10);
		level.player setphysicaldepthoffield(33,389,2,2);
		wait(1);
		level.player setphysicaldepthoffield(19,17,2,2);
		wait(6);
		level.player setphysicaldepthoffield(33,389,2,2);
		wait(0.5);
	}

	level.player disablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
	}

	wait(0.2);
	wait(1);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable",0);
	}

	maps\_lighting::blend_dof_presets("default","greece_safehouse_transition_start",1);
	if(!common_scripts\utility::flag("flag_autofocus_on"))
	{
		common_scripts\utility::flag_set("flag_autofocus_on");
		thread dynamic_dof(0.015,5,0.8,"flag_autofocus_on",0);
	}
}

//Function Number: 49
ending_confculldist()
{
	common_scripts\utility::flag_wait("ending_conf_culldist");
	if(level.currentgen)
	{
		setculldist(10000);
	}

	common_scripts\utility::flag_clear("ending_conf_culldist");
	thread ending_confculldist();
}

//Function Number: 50
preending_confculldist()
{
	common_scripts\utility::flag_wait("pre_ending_conf_culldist");
	if(level.currentgen)
	{
		setculldist(3000);
	}

	common_scripts\utility::flag_clear("pre_ending_conf_culldist");
	thread preending_confculldist();
}

//Function Number: 51
endingambushvision()
{
	common_scripts\utility::flag_wait("Init_FlagEndingSetAmbushInteractBeginLighting");
	if(level.currentgen)
	{
		setculldist(8000);
		var_00 = getent("vista_buildings_intro","targetname");
		if(isdefined(var_00))
		{
			var_00 hide();
		}
	}
	else
	{
		setculldist(10000);
	}

	maps\_utility::vision_set_fog_changes("greece_convoy_explosion",0.5);
	wait(0.25);
	maps\_utility::vision_set_fog_changes("greece_sniper_scramble_start",0.5);
}

//Function Number: 52
initendinghadesfight()
{
	common_scripts\utility::flag_wait("init_ending_hades_fight");
	common_scripts\utility::flag_wait("FlagEndingHadesVehicleInteractBegin");
	if(level.currentgen)
	{
		setculldist(3000);
		var_00 = getent("vista_buildings_intro","targetname");
		if(isdefined(var_00))
		{
			var_00 hide();
		}
	}
	else
	{
		setculldist(10000);
	}

	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable",2);
		setsaveddvar("r_mbVelocityScalar",0.5);
		setsaveddvar("r_dof_physical_enable",1);
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(4,16,2,2);
		wait(2);
		level.player setphysicaldepthoffield(5,40,2,2);
		wait(1);
		level.player setphysicaldepthoffield(7,14,2,2);
		wait(3);
		level.player setphysicaldepthoffield(7,155,2,2);
		wait(2.1);
		level.player setphysicaldepthoffield(14,50,2,2);
		wait(1);
		level.player setphysicaldepthoffield(14,127,2,2);
		wait(1);
		level.player setphysicaldepthoffield(7,12,2,2);
		maps\_utility::vision_set_fog_changes("greece_ending_hades",2);
		wait(3);
		level.player setphysicaldepthoffield(28,850,2,2);
		wait(1);
		level.player setphysicaldepthoffield(28,13,2,2);
		wait(1);
		level.player setphysicaldepthoffield(28,320,2,2);
		maps\_utility::vision_set_fog_changes("greece_sniper_scramble_start",4);
		wait(5);
		level.player setphysicaldepthoffield(32,389,2,2);
		wait(47);
		level.player setphysicaldepthoffield(6,20,2,2);
		wait(2);
		level.player setphysicaldepthoffield(36,389,2,2);
		wait(3);
		level.player setphysicaldepthoffield(6,20,2,2);
		wait(16);
		level.player setphysicaldepthoffield(20,60,2,2);
		wait(20);
	}
	else
	{
		level.player setphysicaldepthoffield(3,16,2,2);
		wait(2);
		level.player setphysicaldepthoffield(4,40,2,2);
		wait(1);
		level.player setphysicaldepthoffield(6,14,2,2);
		wait(3);
		level.player setphysicaldepthoffield(6,155,2,2);
		wait(2.1);
		level.player setphysicaldepthoffield(13,50,2,2);
		maps\_utility::vision_set_fog_changes("greece_ending_hades",1);
		wait(1);
		level.player setphysicaldepthoffield(13,127,2,2);
		wait(1);
		level.player setphysicaldepthoffield(6,12,2,2);
		wait(3);
		level.player setphysicaldepthoffield(24,850,2,2);
		wait(1);
		level.player setphysicaldepthoffield(24,13,2,2);
		wait(1);
		level.player setphysicaldepthoffield(24,320,2,2);
		maps\_utility::vision_set_fog_changes("greece_sniper_scramble",4);
		wait(5);
		level.player setphysicaldepthoffield(33,389,2,2);
		wait(45);
		level.player setphysicaldepthoffield(3,20,2,2);
		wait(20);
	}

	level.player disablephysicaldepthoffieldscripting();
	if(level.nextgen)
	{
	}

	wait(0.2);
	wait(1);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable",0);
	}

	maps\_lighting::blend_dof_presets("default","greece_safehouse_transition_start",1);
	if(!common_scripts\utility::flag("flag_autofocus_on"))
	{
		common_scripts\utility::flag_set("flag_autofocus_on");
		thread dynamic_dof(0.015,5,0.8,"flag_autofocus_on",0);
	}
}