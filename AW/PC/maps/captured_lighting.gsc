/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: captured_lighting.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 40
 * Decompile Time: 584 ms
 * Timestamp: 4/22/2024 2:26:21 AM
*******************************************************************/

//Function Number: 1
main()
{
	thread set_level_lighting_values();
	thread dof_init();
	thread lgt_init();
	thread retarget_model_init();
}

//Function Number: 2
retarget_model_init()
{
	wait 0.05;
	wait 0.05;
	var_00 = getentarray("s1_intro_elevator_door","targetname");
	var_01 = spawn("script_model",(5520,-5504,-16));
	var_01 setmodel("tag_origin");
	foreach(var_03 in var_00)
	{
		var_03 retargetscriptmodellighting(var_01);
	}

	var_00 = getentarray("model_s3interrogation_doorin","targetname");
	var_01 = spawn("script_model",(4803,-9935,-1708));
	var_01 setmodel("tag_origin");
	foreach(var_03 in var_00)
	{
		var_03 retargetscriptmodellighting(var_01);
	}

	var_00 = getentarray("model_s3escape_doorout","targetname");
	var_01 = spawn("script_model",(5232,-9928,-1760));
	var_01 setmodel("tag_origin");
	foreach(var_03 in var_00)
	{
		var_03 retargetscriptmodellighting(var_01);
	}

	var_00 = getentarray("model_s3escape_docdoor","targetname");
	var_01 = spawn("script_model",(5256,-10304,-1760));
	var_01 setmodel("tag_origin");
	foreach(var_03 in var_00)
	{
		var_03 retargetscriptmodellighting(var_01);
	}

	var_00 = getentarray("door_ah_morgue","targetname");
	var_01 = spawn("script_model",(4960,-13104,-1620));
	var_01 setmodel("tag_origin");
	foreach(var_03 in var_00)
	{
		var_03 retargetscriptmodellighting(var_01);
	}

	var_00 = getentarray("tc_side_doors","targetname");
	var_01 = spawn("script_model",(3888,-11068,-1544));
	var_01 setmodel("tag_origin");
	foreach(var_03 in var_00)
	{
		var_03 retargetscriptmodellighting(var_01);
	}

	var_00 = getentarray("door_bh_yard","targetname");
	var_01 = spawn("script_model",(11408,-13608,-1852));
	var_01 setmodel("tag_origin");
	foreach(var_03 in var_00)
	{
		var_03 retargetscriptmodellighting(var_01);
	}

	var_00 = getentarray("door_bh_mech","targetname");
	var_01 = spawn("script_model",(11408,-13608,-1852));
	var_01 setmodel("tag_origin");
	foreach(var_03 in var_00)
	{
		var_03 retargetscriptmodellighting(var_01);
	}
}

//Function Number: 3
lgt_init()
{
	thread lgt_s2_walk();
	thread lgt_escape_door_alarm();
	thread lgt_emergency_screens();
	thread lgt_sys_hacking();
	thread lgt_test_chamber();
	thread lgt_uv_flash();
	thread lgt_morgue();
	thread lgt_incinerator_seq();
	thread lgt_heli_escape();
	thread lgt_manticore_bay();
	thread lgt_mech2_door();
}

//Function Number: 4
dof_init()
{
	thread dof_introdrive_seq();
	thread dof_s2_walk();
	thread dof_s3_interrogation();
	thread dof_escape_gun_seq();
	thread dof_sys_hacking();
	thread dof_uv_flash();
	thread dof_incinerator_seq();
	thread dof_autopsy_door_seq();
	thread dof_manticore_hangar();
	thread dof_heli_flight_seq();
	thread dof_heli_crash();
	thread dof_mech_suit_entrance();
	thread dof_mech_jump_getup();
	thread dof_mech_gate_crash();
	thread dof_mech_door();
	thread dof_end_escape();
}

//Function Number: 5
set_level_lighting_values()
{
	if(isusinghdr())
	{
		setsaveddvar("r_disableLightSets",0);
		setsaveddvar("r_mdao",1);
		setsaveddvar("r_mdaoOccluderCullDistance",641);
	}

	if(level.nextgen)
	{
		setsaveddvar("r_hemiAoEnable",1);
	}
}

//Function Number: 6
lgt_change_intensity_over_time(param_00,param_01)
{
	var_02 = int(param_01 * 20);
	var_03 = self getlightintensity();
	var_04 = param_00 - var_03 / var_02;
	for(var_05 = 0;var_05 < var_02;var_05++)
	{
		self setlightintensity(var_03 + var_05 * var_04);
		wait(0.05);
	}

	self setlightintensity(param_00);
}

//Function Number: 7
lgt_emergency_screens()
{
	var_00 = getentarray("lgt_screen_emergency","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 thread lgt_alarm_pulsing(6000,0.15,0.3,0.15,0.6);
	}
}

//Function Number: 8
lgt_start_fire(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0.85;
	}

	self endon("kill_incinerator_light");
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		self setlightintensity(0.01);
		return;
	}

	var_02 = (0.992157,0.321569,0.101961);
	var_03 = (0.305,0.475,0.895);
	for(var_04 = 0;var_04 < param_00;var_04++)
	{
		self setlightintensity(0.01);
		self setlightcolor(var_02);
		var_05 = randomfloatrange(1.7,2.2);
		lgt_change_intensity_over_time(54000,var_05);
		wait(4 - var_05);
		lgt_change_intensity_over_time(0.01,1);
		self setlightcolor(var_03);
		wait(0.5);
		lgt_change_intensity_over_time(15,0.5);
		wait(0.85);
	}
}

//Function Number: 9
lgt_alarm_pulsing(param_00,param_01,param_02,param_03,param_04)
{
	self endon("kill_pulse_light");
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		self setlightintensity(0);
		return;
	}

	var_05 = self getlightintensity();
	if(isdefined(param_00))
	{
		var_05 = param_00;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0.5;
	}

	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	var_06 = 0.05;
	var_07 = var_05;
	if(!isdefined(param_01))
	{
		param_01 = 0.3;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0.6;
	}

	var_08 = var_05 - var_06 / param_01 / 0.05;
	var_09 = var_05 - var_06 / param_02 / 0.05;
	for(;;)
	{
		var_0A = 0;
		while(var_0A < param_02)
		{
			var_07 = var_07 - var_09;
			var_07 = clamp(var_07,0,100);
			self setlightintensity(var_07);
			var_0A = var_0A + 0.05;
			wait(0.05);
		}

		wait(param_04);
		var_0A = 0;
		while(var_0A < param_01)
		{
			var_07 = var_07 + var_08;
			var_07 = clamp(var_07,0,100);
			self setlightintensity(var_07);
			var_0A = var_0A + 0.05;
			wait(0.05);
		}

		wait(param_03);
	}
}

//Function Number: 10
lgt_s2_walk()
{
	var_00 = getentarray("lgt_s2_elevator","script_noteworthy");
	common_scripts\utility::flag_wait("lgt_flag_elevator_entered");
	foreach(var_02 in var_00)
	{
		var_02 thread lgt_change_intensity_over_time(6500,0.3);
	}
}

//Function Number: 11
lgt_escape_door_alarm()
{
	common_scripts\utility::flag_wait("lgt_flag_interrogation_esc");
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00.origin = (5245.18,-10373.4,-1681.97);
	var_00 soundscripts\_snd::snd_message("aud_red_light");
	wait(1.4);
	thread maps\captured_fx::fx_emergency_lights("fx_emergency_lights_s3door","lgt_flag_interrogation_esc_done",2.4);
	common_scripts\utility::flag_wait("lgt_flag_interrogation_esc_done");
	var_00 delete();
}

//Function Number: 12
lgt_sys_hacking()
{
	level waittill("finished_door_hacking");
	wait 0.05;
	wait 0.05;
	thread maps\captured_fx::fx_emergency_lights("fx_emergency_lights_hack","lgt_flag_tc_alarms_off",0.75);
}

//Function Number: 13
lgt_test_chamber()
{
}

//Function Number: 14
lgt_uv_flash()
{
	level waittill("start_anim_tc_exit_stairs");
	var_00 = getentarray("lgt_uv_decontamination","script_noteworthy");
	var_01 = getent("lgt_uv_bake_red","script_noteworthy");
	var_01 setlightcolor((0.95,0.2,0.1));
	var_01 setlightintensity(1600);
	common_scripts\_exploder::exploder("fx_uv_orange_light");
	var_02 = getent("lgt_uv_bake_green","script_noteworthy");
	var_02 setlightcolor((0.1,0.95,0.2));
	var_02 setlightintensity(0.01);
	level waittill("start_anim_tc_enter_test");
	foreach(var_04 in var_00)
	{
		var_04 thread lgt_change_intensity_over_time(8000,1.3);
	}

	wait(0.6);
	foreach(var_04 in var_00)
	{
		var_04 thread lgt_change_intensity_over_time(24000,1.1);
	}

	wait(0.6);
	foreach(var_04 in var_00)
	{
		var_04 thread lgt_change_intensity_over_time(1500,0.3);
	}

	wait(4.5);
	common_scripts\_exploder::kill_exploder("fx_uv_orange_light");
	var_01 lgt_change_intensity_over_time(0.01,0.25);
	common_scripts\_exploder::exploder("fx_uv_green_light");
	var_02 lgt_change_intensity_over_time(1600,0.25);
	wait(5);
	var_02 lgt_change_intensity_over_time(0.01,0.25);
	common_scripts\_exploder::kill_exploder("fx_uv_green_light");
}

//Function Number: 15
lgt_morgue()
{
	if(!common_scripts\utility::flag_exist("lgt_flag_morgue_end"))
	{
		common_scripts\utility::flag_init("lgt_flag_morgue_end");
	}

	thread maps\captured_fx::fx_emergency_lights("fx_emergency_lights_morgue","lgt_flag_morgue_end");
}

//Function Number: 16
lgt_incinerator_seq()
{
	if(!common_scripts\utility::flag_exist("lgt_flag_inc_near_miss"))
	{
		common_scripts\utility::flag_init("lgt_flag_inc_near_miss");
	}

	if(!common_scripts\utility::flag_exist("lgt_flag_inc_pipe_explode"))
	{
		common_scripts\utility::flag_init("lgt_flag_inc_pipe_explode");
	}

	if(!common_scripts\utility::flag_exist("flag_incinerator_saved"))
	{
		common_scripts\utility::flag_init("flag_incinerator_saved");
	}

	var_00 = getentarray("lgt_incinerator_fire","script_noteworthy");
	var_01 = getent("lgt_incinerator_gideon","script_noteworthy");
	var_02 = getent("lgt_incinerator_fire1","script_noteworthy");
	var_03 = getent("lgt_incinerator_fire2","script_noteworthy");
	var_04 = getent("lgt_incinerator_fire3","script_noteworthy");
	var_05 = getent("lgt_incinerator_fire4","script_noteworthy");
	var_06 = getent("lgt_incinerator_fire5","script_noteworthy");
	var_07 = getent("lgt_incinerator_fire_under","script_noteworthy");
	var_08 = (0.992157,0.321569,0.101961);
	var_09 = (0.305,0.475,0.895);
	var_0A = [var_02,var_03,var_04,var_05,var_06];
	if(level.nextgen)
	{
		var_01 setlightintensity(0.01);
		var_01 setlightcolor(var_09);
		common_scripts\utility::array_call(var_0A,::setlightintensity,0.01);
		common_scripts\utility::array_call(var_0A,::setlightcolor,var_09);
		common_scripts\utility::array_call(var_0A,::setlightradius,100);
		common_scripts\utility::array_call(var_00,::setlightintensity,0.01);
		var_02 setlightradius(700);
		var_07 setlightintensity(100);
	}

	var_0B = common_scripts\utility::flag_wait_either_return("flag_autopsy_end","flag_incinerator_saved");
	maps\_utility::fog_set_changes("captured",0.01);
	if(var_0B == "flag_autopsy_end")
	{
		common_scripts\utility::flag_wait("flag_incinerator_saved");
	}

	maps\_art::sunflare_changes("incinerator",0);
	var_0C = randomfloatrange(0.35,0.5);
	thread maps\_utility::vision_set_fog_changes("",var_0C * 5);
	wait(8.15);
	if(level.nextgen)
	{
		var_01 thread lgt_change_intensity_over_time(15,var_0C);
		var_06 lgt_change_intensity_over_time(15,var_0C);
		wait(2.43 - var_0C);
		var_0C = randomfloatrange(0.35,0.5);
		var_05 lgt_change_intensity_over_time(100,var_0C);
		wait(0.9 - var_0C);
		var_0C = randomfloatrange(0.3,0.45);
		var_04 lgt_change_intensity_over_time(60,var_0C);
		wait(0.77 - var_0C);
		var_0C = randomfloatrange(0.35,0.5);
		var_03 lgt_change_intensity_over_time(60,var_0C);
		wait(0.6 - var_0C);
		var_0C = randomfloatrange(0.2,0.4);
		var_02 lgt_change_intensity_over_time(65,var_0C);
		wait(0.53 - var_0C);
		var_01 thread lgt_change_intensity_over_time(25,1.25);
		var_0C = randomfloatrange(0.23,0.4);
		var_02 lgt_change_intensity_over_time(115,var_0C);
		wait(0.7);
		var_02 setlightintensity(0.01);
		var_02 setlightcolor(var_08);
		var_03 setlightintensity(0.01);
		var_03 setlightcolor(var_08);
		var_03 setlightradius(200);
		var_02 thread lgt_start_fire(1);
		var_03 lgt_start_fire(1);
		wait(1.75);
		var_03 setlightintensity(0.01);
		var_03 setlightradius(400);
		var_03 setlightcolor(var_08);
		var_04 setlightradius(400);
		var_04 thread lgt_start_fire(1);
		var_03 lgt_start_fire(1);
		wait(1.75);
		var_04 setlightintensity(0.01);
		var_04 setlightradius(400);
		var_04 setlightcolor(var_08);
		var_04 lgt_start_fire(1);
		wait(1.75);
		var_05 setlightintensity(0.01);
		var_05 setlightradius(400);
		var_05 setlightcolor(var_08);
		var_05 thread lgt_start_fire(6,2.6);
		common_scripts\utility::flag_wait("lgt_flag_inc_near_miss");
		common_scripts\utility::array_call(var_0A,::setlightradius,20);
		var_05 setlightradius(200);
		var_05 notify("kill_incinerator_light");
		var_05 thread lgt_start_fire(40,2.6);
		wait(1.75);
		foreach(var_0E in var_00)
		{
			var_0E thread lgt_start_fire(40,2.6);
		}

		common_scripts\utility::flag_wait("lgt_flag_inc_pipe_explode");
		var_07 lgt_change_intensity_over_time(10000,randomfloatrange(0.23,0.4));
		wait(1.4);
		var_07 lgt_change_intensity_over_time(0.01,randomfloatrange(0.23,0.4));
		common_scripts\utility::flag_wait("flag_incinerator_end");
		foreach(var_0E in var_0A)
		{
			var_0E notify("kill_incinerator_light");
			wait(randomfloatrange(0.6,1.1));
		}

		foreach(var_0E in var_00)
		{
			var_0E notify("kill_incinerator_light");
			wait(randomfloatrange(0.6,1.1));
		}
	}
}

//Function Number: 17
lgt_heli_escape()
{
	common_scripts\utility::flag_wait("flag_bh_intro_start_scene");
	wait(2);
	thread maps\captured_fx::fx_emergency_lights("fx_emergency_lights_heli","flag_bh_pit",2);
}

//Function Number: 18
lgt_manticore_bay()
{
	var_00 = getentarray("lgt_manticore_pulsing","script_noteworthy");
	common_scripts\utility::flag_wait("flag_s3guard_security_door_shuts");
	foreach(var_02 in var_00)
	{
		var_02 thread lgt_alarm_pulsing(15000);
	}

	common_scripts\utility::flag_wait("s3escape_hall_enemies_dead");
	foreach(var_02 in var_00)
	{
		var_02 notify("kill_pulse_light");
	}
}

//Function Number: 19
lgt_mech2_door()
{
	if(!common_scripts\utility::flag_exist("lgt_flag_mb2_end"))
	{
		common_scripts\utility::flag_init("lgt_flag_mb2_end");
	}

	common_scripts\utility::flag_wait("flag_mb1_end");
	thread maps\captured_fx::fx_emergency_lights("fx_emergency_lights_mb2","lgt_flag_mb2_end");
	wait(20);
	common_scripts\utility::flag_set("lgt_flag_mb2_end");
}

//Function Number: 20
dof_set_focus(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(param_04) && isdefined(param_05))
	{
		level.player setphysicaldepthoffield(param_02,param_03,param_04,param_05);
	}
	else
	{
		level.player setphysicaldepthoffield(param_02,param_03);
	}

	wait(param_01);
}

//Function Number: 21
dof_introdrive_seq()
{
	common_scripts\utility::flag_wait("lgt_flag_introdrive");
	setsaveddvar("r_dof_physical_bokehEnable",1);
	if(level.xb3)
	{
		setsaveddvar("sm_sunShadowBoundsMin","-10240 -10240 -64");
		setsaveddvar("sm_sunShadowBoundsMax","10240 10240 2048");
		setsaveddvar("sm_sunShadowBoundsOverride","1");
	}

	level.player enablephysicaldepthoffieldscripting();
	dof_set_focus("beginning hands",5.5,2.8,20);
	dof_set_focus("background look up",9,11,1860,2,1);
	dof_set_focus("faces",20,2.8,65,0.5,0.5);
	dof_set_focus("slow down",8.5,8,65,3,1.5);
	dof_set_focus("guard approach",2,5.6,60);
	dof_set_focus("guard climb",1.5,5.6,25);
	dof_set_focus("guard and Ilana",2.25,5.6,13);
	dof_set_focus("guard close",4,5.6,10);
	dof_set_focus("guard when falling",1.25,5.6,60);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable",2);
		setsaveddvar("r_mbCameraRotationInfluence",1);
		setsaveddvar("r_mbCameraTranslationInfluence",1);
		setsaveddvar("r_mbVelocityScalar",0.85);
	}

	dof_set_focus("hit",1,1.2,40);
	setsaveddvar("sm_sunsamplesizenear",0.6);
	dof_set_focus("hands",2.25,3.5,20);
	dof_set_focus("gideon",1.5,5.6,100);
	dof_set_focus("gideon and co",5,3.5,260);
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable",0);
		setsaveddvar("r_dof_physical_hipEnable",1);
		setsaveddvar("r_dof_physical_hipFstop",4);
		setsaveddvar("r_dof_physical_hipSharpCocDiameter",0.08);
	}

	if(level.xb3)
	{
		setsaveddvar("sm_sunShadowBoundsOverride","0");
	}

	common_scripts\utility::flag_wait("flag_start_s1elevator");
	setsaveddvar("sm_sunsamplesizenear","0.1");
	setsaveddvar("r_dof_physical_hipEnable",0);
	level.player disablephysicaldepthoffieldscripting();
}

//Function Number: 22
dof_s2_walk()
{
	common_scripts\utility::flag_wait("flag_s2walk_start");
	level.player enablephysicaldepthoffieldscripting();
	setsaveddvar("r_mbEnable",3);
	setsaveddvar("r_mbCameraTranslationInfluence",1);
	dof_set_focus("hands",2.25,3.5,30);
	dof_set_focus("walk",2.25,3.5,100);
	level waittill("trolley_doctor_start");
	wait(2);
	dof_set_focus("gideon start",1.5,1.25,85,2,2);
	dof_set_focus("gideon",3,0.5,85,2,2);
	dof_set_focus("doctor",2.5,3.5,18);
	dof_set_focus("out",0,0.5,20);
	wait(0.5);
	common_scripts\utility::flag_wait("flag_s2elevator_end");
	setsaveddvar("r_mbEnable",0);
	level.player disablephysicaldepthoffieldscripting();
}

//Function Number: 23
dof_s3_interrogation()
{
	common_scripts\utility::flag_wait("lgt_flag_interrogation_begin");
	level.player enablephysicaldepthoffieldscripting();
	dof_set_focus("interrogation wake up",4,3,24);
	dof_set_focus("Hands",2.5,5.6,24);
	dof_set_focus("Friends",5.5,2,170);
	dof_set_focus("Iron Enter",2.5,3.5,64);
	dof_set_focus("Iron Enter 2",3,5.6,54);
	dof_set_focus("Iron turn",7.5,5,76);
	dof_set_focus("Iron talk",17.5,8,56);
	dof_set_focus("Iron start Close",2.75,8,30);
	dof_set_focus("Iron mid Close",1.75,7.5,23);
	dof_set_focus("Iron Close",12,7.5,20);
	dof_set_focus("Cormack",11,6.5,70);
	dof_set_focus("Irons shoot",14,6.5,65);
	dof_set_focus("Iron far",8.5,4,145);
	dof_set_focus("Iron / Cormack",3,6,80);
	dof_set_focus("Cormack",3,4,50);
	dof_set_focus("Iron close again",12.5,7.5,24);
	dof_set_focus("Right up",14,11,12.5);
	dof_set_focus("Hands 1",1,8,14);
	dof_set_focus("Face",1.5,6,24);
	dof_set_focus("Hands 2",4.5,8,14);
	dof_set_focus("Close",14,11,20);
	dof_set_focus("Fade Out",10,4,54,4,5);
	dof_set_focus("Fade In",2.5,0.4,24);
	dof_set_focus("Fade Up",3,1.4,74);
	dof_set_focus("Friends",5,3.5,154);
	dof_set_focus("Friends escape",6,5.5,74);
	dof_set_focus("Gideon",9,7,40);
	dof_set_focus("Undo shackles",7,3.5,30);
	dof_set_focus("Everyone",5,11,64);
	common_scripts\utility::flag_wait("flag_s3interrogate_end");
	level.player disablephysicaldepthoffieldscripting();
}

//Function Number: 24
dof_escape_gun_seq()
{
	level waittill("s3_escape_player_got_gun");
	level.player enablephysicaldepthoffieldscripting();
	setsaveddvar("r_dof_physical_bokehEnable",1);
	dof_set_focus("beginning gun",1,8,31);
	dof_set_focus("gideon",9,4.5,31,2,1);
	dof_set_focus("gideonfar",5,22,170,3,4);
	setsaveddvar("r_dof_physical_bokehEnable",0);
	level.player disablephysicaldepthoffieldscripting();
}

//Function Number: 25
dof_sys_hacking()
{
	level waittill("started_door_hacking");
	level.player enablephysicaldepthoffieldscripting();
	setsaveddvar("r_dof_physical_bokehEnable",1);
	wait(0.5);
	dof_set_focus("hacking",6.5,2,32,1.5,1.5);
	level waittill("finished_door_hacking");
	setsaveddvar("r_dof_physical_hipEnable",0);
	setsaveddvar("r_dof_physical_bokehEnable",0);
	level.player disablephysicaldepthoffieldscripting();
}

//Function Number: 26
dof_uv_flash()
{
	level waittill("start_anim_tc_enter_test");
	level.player enablephysicaldepthoffieldscripting();
	dof_set_focus("Gideon",5.4,3,94);
	common_scripts\utility::flag_wait("lgt_flag_entered_tc");
	setsaveddvar("r_dof_physical_hipEnable",1);
	setsaveddvar("r_dof_physical_hipFstop",4);
	setsaveddvar("r_dof_physical_hipSharpCocDiameter",0.22);
	common_scripts\utility::flag_wait("lgt_flag_exit_tc");
	setsaveddvar("r_dof_physical_hipSharpCocDiameter",0.15);
	wait(1);
	setsaveddvar("r_dof_physical_hipSharpCocDiameter",0.08);
	wait(1);
	setsaveddvar("r_dof_physical_hipEnable",0);
	level.player disablephysicaldepthoffieldscripting();
}

//Function Number: 27
dof_autopsy_door_seq()
{
	common_scripts\utility::flag_wait("lgt_flag_entered_autopsy");
	setsaveddvar("r_dof_physical_hipEnable",1);
	setsaveddvar("r_dof_physical_hipFstop",2);
	setsaveddvar("r_dof_physical_hipSharpCocDiameter",0.05);
	level waittill("doctor_door_weapon_hidden");
	setsaveddvar("r_dof_physical_hipEnable",0);
	level.player enablephysicaldepthoffieldscripting();
	dof_set_focus("face and gun",2.5,2.2,25,3.5,3.5);
	dof_set_focus("doctor",1,4,65,1,2);
	level.player disablephysicaldepthoffieldscripting();
}

//Function Number: 28
dof_incinerator_seq()
{
	var_00 = common_scripts\utility::flag_wait_either_return("flag_autopsy_end","flag_incinerator_saved");
	if(var_00 == "flag_autopsy_end")
	{
		common_scripts\utility::flag_wait("flag_incinerator_saved");
	}

	wait(8.15);
	level.player enablephysicaldepthoffieldscripting();
	dof_set_focus("Gideon",2.43,4,20);
	dof_set_focus("pilot 2",1.9,3.5,109);
	dof_set_focus("pilot 3",5,2.6,250);
	dof_set_focus("Gideon again",2,4,20);
	dof_set_focus("Gideon further",2,4,60,5,3);
	common_scripts\utility::flag_wait("flag_incinerator_push_start");
	dof_set_focus("Gideon close",6,4,32,5,3);
	common_scripts\utility::flag_wait("lgt_flag_inc_near_miss");
	dof_set_focus("near miss",0,5.6,50);
	common_scripts\utility::flag_wait("lgt_flag_inc_pipe_explode");
	common_scripts\utility::flag_wait("flag_incinerator_end");
	level.player disablephysicaldepthoffieldscripting();
}

//Function Number: 29
dof_manticore_hangar()
{
	level waittill("lgt_dof_run_to_heli");
	thread heli_probe_override();
	level.player enablephysicaldepthoffieldscripting();
	dof_set_focus("Gideon",2.5,4,180);
	common_scripts\utility::flag_wait("flag_player_and_ally_at_window");
	level.player disablephysicaldepthoffieldscripting();
	setsaveddvar("r_dof_physical_hipEnable",1);
	setsaveddvar("r_dof_physical_hipFstop",11);
	setsaveddvar("r_dof_physical_hipSharpCocDiameter",0.055);
	common_scripts\utility::flag_wait("flag_bh_run");
	setsaveddvar("r_mbEnable",2);
	setsaveddvar("r_mbCameraRotationInfluence",1);
	setsaveddvar("r_mbCameraTranslationInfluence",1);
	setsaveddvar("r_mbVelocityScalar",0.2);
	common_scripts\utility::flag_wait("flag_heliride_warbird_mount");
	setsaveddvar("r_dof_physical_hipEnable",0);
}

//Function Number: 30
dof_heli_flight_seq()
{
	common_scripts\utility::flag_wait("flag_heliride_warbird_mount");
	level.player lightsetoverrideenableforplayer("captured_heli",12);
	setsaveddvar("r_mbEnable",3);
	setsaveddvar("r_mbCameraRotationInfluence",1);
	setsaveddvar("r_mbCameraTranslationInfluence",1);
	setsaveddvar("r_mbVelocityScalar",0.2);
	level.player enablephysicaldepthoffieldscripting();
	dof_set_focus("heli board",3,2.5,60,0.5,1);
	dof_set_focus("heli flight",0,1.8,80,2,4);
	common_scripts\utility::flag_wait("flag_heliride_end");
	setsaveddvar("r_mbEnable",0);
	level.player disablephysicaldepthoffieldscripting();
	level.player lightsetoverrideenableforplayer();
}

//Function Number: 31
dof_heli_crash()
{
	level waittill("anim_mech_wakeup");
	level.player enablephysicaldepthoffieldscripting();
	dof_set_focus("Wake up",2.43,2.6,24);
	dof_set_focus("Hands",5,2.6,44);
	dof_set_focus("Gideon slide",3,2.6,180);
	dof_set_focus("Gideon close",7,2.6,50);
	level.player disablephysicaldepthoffieldscripting();
}

//Function Number: 32
dof_mech_suit_entrance()
{
	common_scripts\utility::flag_wait("flag_getting_into_mech");
	level.player enablephysicaldepthoffieldscripting();
	setsaveddvar("r_mbEnable",2);
	setsaveddvar("r_mbCameraRotationInfluence",1);
	setsaveddvar("r_mbCameraTranslationInfluence",1);
	setsaveddvar("r_mbVelocityScalar",0.2);
	dof_set_focus("mech",17,4,22);
	dof_set_focus("inside mech",5,5,200);
	common_scripts\utility::flag_wait("lgt_flag_mech_entered");
	setsaveddvar("r_mbEnable",0);
	level.player disablephysicaldepthoffieldscripting();
}

//Function Number: 33
dof_mech_jump_getup()
{
}

//Function Number: 34
dof_mech_gate_crash()
{
}

//Function Number: 35
dof_mech_door()
{
	level waittill("lgt_dof_mechdoor");
	setsaveddvar("r_dof_physical_hipEnable",1);
	setsaveddvar("r_dof_physical_hipFstop",3.5);
	setsaveddvar("r_dof_physical_hipSharpCocDiameter",0.08);
	setsaveddvar("r_mbEnable",2);
	setsaveddvar("r_mbCameraRotationInfluence",1);
	setsaveddvar("r_mbCameraTranslationInfluence",1);
	setsaveddvar("r_mbVelocityScalar",0.2);
	common_scripts\utility::flag_wait("flag_gatedoor_end");
	setsaveddvar("r_dof_physical_hipEnable",0);
}

//Function Number: 36
dof_end_escape()
{
	level waittill("truck_dof");
	level.player enablephysicaldepthoffieldscripting();
	dof_set_focus("hands on ground",3.5,4,20);
	dof_set_focus("gideon",6,2,170);
	dof_set_focus("gideon near",1.5,0.8,100);
	dof_set_focus("gideon nearer",1.25,1.6,75);
	dof_set_focus("explosion",2.25,0.8,1400);
	dof_set_focus("gideon",1.75,2.4,65);
	dof_set_focus("gideon away",6.25,2.5,150);
	dof_set_focus("Ilana",6,16,40);
	dof_set_focus("Gideon close",15,2.5,32);
	level.player disablephysicaldepthoffieldscripting();
}

//Function Number: 37
heli_probe_override()
{
	script_probe_heli_open();
	common_scripts\utility::flag_wait("flag_heliride_end");
	script_probe_heli_reset();
}

//Function Number: 38
script_probe_heli_open()
{
	var_00 = getent("refl_probe_heli_open","targetname");
	level waittill("all_heliride_pieces_spawned");
	level._facility.warbird overridereflectionprobe(var_00.origin);
	level.player_rig overridereflectionprobe(var_00.origin);
	level.allies[0] overridereflectionprobe(var_00.origin);
	level.pilot overridereflectionprobe(var_00.origin);
	level.mech_pilot overridereflectionprobe(var_00.origin);
	level.heli_collision overridereflectionprobe(var_00.origin);
	level.glass overridereflectionprobe(var_00.origin);
	level.glass_broken overridereflectionprobe(var_00.origin);
}

//Function Number: 39
script_probe_heli_closed()
{
	var_00 = getent("refl_probe_heli_closed","targetname");
	level._facility.warbird overridereflectionprobe(var_00.origin);
	level.player_rig overridereflectionprobe(var_00.origin);
	level.allies[0] overridereflectionprobe(var_00.origin);
	level.pilot overridereflectionprobe(var_00.origin);
	level.mech_pilot overridereflectionprobe(var_00.origin);
	level.heli_collision overridereflectionprobe(var_00.origin);
	level.glass overridereflectionprobe(var_00.origin);
	level.glass_broken overridereflectionprobe(var_00.origin);
}

//Function Number: 40
script_probe_heli_reset()
{
	level.allies[0] defaultreflectionprobe();
}