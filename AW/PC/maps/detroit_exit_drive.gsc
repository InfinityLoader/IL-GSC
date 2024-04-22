/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: detroit_exit_drive.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 76
 * Decompile Time: 1080 ms
 * Timestamp: 4/22/2024 2:27:49 AM
*******************************************************************/

//Function Number: 1
exit_drive_main()
{
	precacheitem("rpg_straight");
	precacheitem("rpg_player");
	precacheitem("rpg_custom_detroit_exit_drive");
	thread setup_exitdrive_starting_anims();
	thread exit_drive_objects_think();
	thread failed_to_keep_up();
	thread failed_to_avoid_buttress();
	thread setup_exitdrive_encounters();
	thread warning_box_functions();
	thread cleanup_school_cars();
}

//Function Number: 2
transient_middle_remove_hospital_interior_begin()
{
	level notify("tff_pre_remove_hospital_add_exit");
	unloadtransient("detroit_hospital_interior_tr");
	wait(2.5);
	loadtransient("detroit_outro_tr");
	for(;;)
	{
		if(istransientloaded("detroit_outro_tr"))
		{
			level notify("tff_post_remove_hospital_add_exit");
			break;
		}

		wait(0.05);
	}

	level.jetbike overridematerial("mq/mtl_mil_hoverbike_screen_center_off","mq/mtl_hoverbike_screen_ui_01");
	level.jetbike overridematerial("mq/mtl_mil_hoverbike_screen_right_off","mq/mtl_hoverbike_screen_ui_02");
	level.jetbike overridematerial("mq/mtl_mil_hoverbike_screen_top_off","mq/mtl_hoverbike_screen_ui_03");
	level.jetbike overridematerial("mq/mtl_mil_hoverbike_lights_off","mq/mtl_hoverbike_screen_ui_04");
}

//Function Number: 3
warning_box_functions()
{
	var_00 = getent("exit_drive_warning_box","targetname");
	common_scripts\utility::flag_wait("exit_drive_started");
	thread mission_fail_warning_exitdrive(var_00);
}

//Function Number: 4
mission_fail_warning_exitdrive(param_00)
{
	level.player endon("death");
	for(;;)
	{
		if(level.player istouching(param_00))
		{
			maps\_utility::hint(&"DETROIT_LEAVING_MISSION",3);
			wait(8);
		}

		wait(0.05);
	}
}

//Function Number: 5
exit_drive_objects_think()
{
	var_00 = getentarray("exitdrive_vehicle_clip_bubble","targetname");
	foreach(var_02 in var_00)
	{
		var_02.origin = var_02.origin - (0,0,1000);
	}

	common_scripts\utility::flag_wait("exit_drive_started");
	foreach(var_02 in var_00)
	{
		var_02.origin = var_02.origin + (0,0,1000);
	}
}

//Function Number: 6
jetbike_physics()
{
	self endon("death");
	var_00 = 0;
	var_01 = 0;
	var_02 = 0;
	var_03 = 0;
	var_04 = 0.3;
	if(self == level.burke_bike)
	{
		var_00 = 10;
		var_01 = 25;
		var_02 = 60;
		var_03 = -20;
	}

	if(self == level.jetbike)
	{
		var_00 = 74;
		var_01 = 75;
		var_02 = 100;
		var_03 = -100;
		var_04 = 0.06;
	}

	for(;;)
	{
		var_05 = var_04;
		if(self == level.jetbike)
		{
			var_06 = self vehicle_getspeed();
			var_07 = 42;
			var_05 = var_05 * max(0,min(1,var_06 / var_07));
		}

		var_08 = self.origin + anglestoforward(self.angles) * var_02 + anglestoup(self.angles) * var_03;
		physicsexplosionsphere(var_08,var_01,var_00,var_05,0);
		wait(0.05);
	}
}

//Function Number: 7
manage_burke_bike_behavior()
{
	wait(4);
	level.burke_bike maps\detroit_jetbike::vehicle_rubberband(level.jetbike,1000,100);
	level.burke_bike maps\detroit_jetbike::vehicle_rubberband_set_min_speed(30);
	wait(1);
	level.burke_bike maps\detroit_jetbike::vehicle_rubberband_set_fail_range(2000,8);
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_rail_dodge_01a");
	level.burke_bike maps\detroit_jetbike::vehicle_rubberband_set_desired_range(1200);
}

//Function Number: 8
failed_to_keep_up()
{
	common_scripts\utility::flag_wait("player_on_exitdrive_jetbike");
	common_scripts\utility::flag_clear("exit_drive_ending_begin_player");
	common_scripts\utility::flag_wait("flag_jetbike_fail");
	if(common_scripts\utility::flag("exit_drive_ending_begin_player"))
	{
		return;
	}

	maps\detroit_jetbike::fail_out_of_range();
}

//Function Number: 9
failed_to_avoid_buttress()
{
	common_scripts\utility::flag_wait("flag_jetbike_fail_buttress");
	level.player kill();
}

//Function Number: 10
exit_drive_player_jetbike_initial_lights()
{
	var_00 = maps\_shg_utility::play_fx_with_handle("jetbike_lights",self,"tag_headlight");
	self waittill("kill_fx_to_hack_around_setmodel_fx_bug");
	maps\_shg_utility::kill_fx_with_handle(var_00);
}

//Function Number: 11
setup_exitdrive_control_hints()
{
	common_scripts\utility::flag_wait("player_on_exitdrive_jetbike");
	wait(8);
	maps\_utility::hintdisplayhandler("jetbike_controls_controller");
}

//Function Number: 12
player_input_control_hint_off()
{
	if(level.player getnormalizedmovement()[0] != 0 || level.player getnormalizedmovement()[1] != 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 13
handle_name_identifiers_exit_drive()
{
	var_00 = getdvarint("g_friendlyNameDist");
	setsaveddvar("g_friendlyNameDist",0);
	level waittill("detroit_level_fadeout");
	setsaveddvar("g_friendlyNameDist",var_00);
}

//Function Number: 14
setup_exitdrive_starting_anims()
{
	var_00 = getent("exit_drive_starting","targetname");
	thread jetbike_exitdrive_door(var_00);
	common_scripts\utility::flag_wait("exit_drive_cinematic_start");
	thread maps\detroit::spawn_bikes();
	thread jetbike_exitdrive_player(var_00);
	thread jetbike_exitdrive_burke(var_00);
	thread jetbike_exitdrive_joker_and_doctor(var_00);
	thread jetbike_exitdrive_bones(var_00);
	thread exit_drive_starting_anims_ambient_danger();
	thread jetbike_exitdrive_fov_changes();
	thread stay_on_mission();
	if(level.currentgen)
	{
		wait(2);
		level.burke_bike hide();
		level.joker_bike hide();
		level.bones_bike hide();
		if(isdefined(level.player_bike))
		{
			level.player_bike hide();
		}
	}
}

//Function Number: 15
jetbike_exitdrive_fov_changes()
{
	level waittill("exit_drive_FOV_start");
	level.player lerpfov(56,2);
	level waittill("exit_drive_FOV_end");
	level.player lerpfov(65,1);
}

//Function Number: 16
stay_on_mission()
{
	maps\_utility::trigger_wait_targetname("play_garage_animation_sequence");
	maps\_player_death::set_deadquote(&"DETROIT_OBJECTIVE_FAIL_JETBIKE");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 17
jetbike_exitdrive_door(param_00)
{
	if(level.currentgen && !issubstr(level.transient_zone,"middle"))
	{
		level waittill("tff_post_intro_to_middle");
	}

	var_01 = getent("exit_drive_animated_door","targetname");
	var_01.animname = "animated_door";
	var_01 maps\_anim::setanimtree();
	var_02 = getent(var_01.target,"targetname");
	param_00 maps\_anim::anim_first_frame_solo(var_01,"det_exit_drive_starting_anim_1");
	var_02 linkto(var_01,"doorA");
	common_scripts\utility::flag_wait("flag_open_door_to_bikes");
	param_00 thread maps\_anim::anim_single_solo(var_01,"det_exit_drive_starting_anim_1");
}

//Function Number: 18
jetbike_exitdrive_player(param_00)
{
	thread setup_exitdrive_control_hints();
	if(isdefined(level.player_bike))
	{
		level.player_bike delete();
	}

	level.jetbike = maps\_vehicle::spawn_vehicle_from_targetname("player_jetbike_exit");
	level.jetbike.animname = "player_bike";
	level.jetbike_obj = spawn("script_model",(0,0,0));
	level.jetbike_obj.animname = level.jetbike.animname;
	level.jetbike_obj maps\_utility::assign_animtree();
	param_00 thread maps\_anim::anim_loop_solo(level.jetbike,"det_exit_drive_starting_idle_1","bike_idle_ender");
	level.jetbike jetbike_allow_player_use_detroit(undefined);
	level.player thread maps\_player_exo::player_exo_deactivate();
	param_00 notify("bike_idle_ender");
	level.jetbike_obj delete();
	level notify("hide_hoverbike_exit_prompt");
	if(level.nextgen)
	{
		level.jetbike showallparts();
	}

	common_scripts\utility::flag_set("player_on_exitdrive_jetbike");
	common_scripts\utility::flag_clear("start_exit_trains");
	level.jetbike thread maps\detroit_jetbike::handle_glass_collisions();
	thread handle_name_identifiers_exit_drive();
	common_scripts\utility::flag_set("exitdrive_lights_on");
	level.player lightsetforplayer("jetbike_exit");
	maps\_utility::vision_set_fog_changes("detroit_jetbike_exit",2);
	thread maps\detroit_lighting::exit_drive_jetbike_lighting();
	level waittill("exit_drive_on_button_pressed");
	level notify("player_progressed_to_exit_drive");
	level.jetbike vehicle_scripts\_jetbike::jetbike_speedometer_on();
	level.jetbike thread maps\detroit_refugee_camp::hoverbike_ride_in_autorumble(225,"stop_exit_drive_rumbles");
	level.player thread manage_health_rumble();
	if(level.nextgen)
	{
		level.burke_bike overridematerial("mtl_mil_hoverbike","m/mtl_mil_hoverbike_emissive");
		level.burke_bike overridematerial("m/mtl_mil_hoverbike_glass","m/mtl_mil_hoverbike_glass");
	}
	else
	{
		level.burke_bike overridematerial("mtl_mil_hoverbike","mq/mtl_mil_hoverbike_emissive");
		level.burke_bike overridematerial("mq/mtl_mil_hoverbike_glass","mq/mtl_mil_hoverbike_glass");
	}

	common_scripts\utility::flag_set("exit_drive_started");
	level.player thread monitor_wheelman();
	level.player thread maps\_player_exo::player_exo_activate();
	common_scripts\utility::flag_set("obj_escape_detroit_on_burke");
	if(level.currentgen)
	{
		thread transient_middle_remove_hospital_interior_begin();
	}

	maps\_utility::autosave_by_name();
}

//Function Number: 19
monitor_wheelman()
{
	level.player.wheelman_success = 1;
	thread monitor_jetbike_wheelman();
	thread monitor_player_wheelman();
	common_scripts\utility::flag_wait("obj_escape_detroit_complete");
	if(level.player.wheelman_success)
	{
		maps\_utility::giveachievement_wrapper("LEVEL_5A");
	}
}

//Function Number: 20
monitor_jetbike_wheelman()
{
	level endon("obj_escape_detroit_complete");
	for(;;)
	{
		var_00 = level.jetbike common_scripts\utility::waittill_any_return_parms("veh_contact");
		if(isdefined(var_00) && isarray(var_00))
		{
			var_01 = vectornormalize(var_00[3]);
			if(var_01[2] < 0.8)
			{
				if(isdefined(level.player.wheelman_success))
				{
					level.player.wheelman_success = 0;
				}
			}
		}
	}
}

//Function Number: 21
monitor_player_wheelman()
{
	level endon("obj_escape_detroit_complete");
	for(;;)
	{
		var_00 = level.player common_scripts\utility::waittill_any_return("damage","death");
		level.player.wheelman_success = 0;
	}
}

//Function Number: 22
jetbike_allow_player_use_detroit(param_00)
{
	self makeunusable();
	var_01 = getent("hoverbike_exit_trigger_usable","targetname");
	var_01 sethintstring(&"DETROIT_PROMPT_USE");
	var_02 = var_01 maps\_shg_utility::hint_button_position("use",var_01.origin,undefined,200,undefined,var_01);
	var_01 waittill("trigger");
	var_01 delete();
	var_02 maps\_shg_utility::hint_button_clear();
	soundscripts\_snd::snd_message("exit_ride_jetbike_mount_player");
	thread vehicle_scripts\_jetbike::jetbike_allow_player_use_internal(param_00);
	level.doctor hide();
	level.joker hide();
	wait(1.8);
	level.doctor show();
	level.joker show();
}

//Function Number: 23
manage_health_rumble()
{
	self endon("death");
	var_00 = level.player.health;
	var_01 = 0;
	for(;;)
	{
		var_01 = level.player.health;
		if(var_01 < var_00)
		{
			var_02 = var_00 - var_01;
			thread health_based_rumble(var_02);
		}

		var_00 = var_01;
		wait(0.05);
	}
}

//Function Number: 24
health_based_rumble(param_00)
{
	var_01 = level.player maps\_utility::get_rumble_ent("steady_rumble");
	var_01 maps\_utility::set_rumble_intensity(param_00 / 120);
	wait(0.3);
	var_01 stoprumble("steady_rumble");
	var_01 delete();
}

//Function Number: 25
hoverbike_exit_prompt()
{
	var_00 = getent("hoverbike_exit_trigger_usable","targetname") maps\_shg_utility::hint_button_trigger("use",200);
	level waittill("hide_hoverbike_exit_prompt");
	thread hospital_barrel_swap_physics();
	var_00 maps\_shg_utility::hint_button_clear();
}

//Function Number: 26
hospital_barrel_swap_physics()
{
	var_00 = getentarray("static_barrel_hospital","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 physicslaunchclient(var_02.origin,(0,0,0));
	}
}

//Function Number: 27
jetbike_exitdrive_burke(param_00)
{
	if(isdefined(level.burke_bike))
	{
		level.burke_bike delete();
	}

	level.burke_bike = maps\_vehicle::spawn_vehicle_from_targetname("npc_jetbike_burke");
	level.burke_bike.animname = "burke_bike";
	var_01 = level.burke_bike;
	var_02 = [level.burke,var_01];
	param_00 maps\_anim::anim_reach_solo(level.burke,"det_exit_drive_starting_anim_1");
	maps\_utility::delaythread(2,::common_scripts\utility::flag_set,"obj_escape_detroit_on_player_bike");
	common_scripts\utility::flag_set("flag_open_door_to_bikes");
	param_00 thread maps\_anim::anim_single(var_02,"det_exit_drive_starting_anim_1");
	common_scripts\utility::waittill_any_ents(param_00,"det_exit_drive_starting_anim_1",level,"player_on_exitdrive_jetbike");
	if(!common_scripts\utility::flag("player_on_exitdrive_jetbike"))
	{
		param_00 thread maps\_anim::anim_loop(var_02,"det_exit_drive_starting_idle_1","burke_idle_ender");
	}

	common_scripts\utility::flag_wait("player_on_exitdrive_jetbike");
	param_00 notify("burke_idle_ender");
	var_01 maps\_utility::delaythread(getanimlength(level.burke_bike maps\_utility::getanim("det_exit_drive_starting_anim_2")) - 0.2,::maps\_vehicle::gopath);
	param_00 maps\_anim::anim_single(var_02,"det_exit_drive_starting_anim_2");
	var_01 stopanimscripted();
	level.burke stopanimscripted();
	var_01 maps\_utility::guy_enter_vehicle(level.burke);
	var_01.dont_clear_vehicle_anim = 1;
	level notify("vfx_exit_drive_start");
	var_01 vehicle_scripts\_jetbike::jetbike_start_hovering_now();
	var_01 vehphys_disablecrashing();
	var_01 thread maps\detroit_jetbike::handle_glass_collisions();
	var_01 thread maps\detroit_jetbike::handle_contact_collisions();
	level.burke_bike thread jetbike_physics();
	level.jetbike thread jetbike_physics();
	manage_burke_bike_behavior();
}

//Function Number: 28
jetbike_exitdrive_joker_and_doctor(param_00)
{
	var_01 = [level.doctor,level.joker,level.joker_bike];
	param_00 thread maps\_anim::anim_loop_solo(level.joker_bike,"det_exit_drive_starting_idle_1","jokerbike_idle_ender");
	common_scripts\utility::flag_wait("player_on_exitdrive_jetbike");
	common_scripts\utility::flag_set("obj_escape_detroit_on_player_bike_mount");
	param_00 notify("jokerbike_idle_ender");
	level.doctor unlink();
	param_00 maps\_anim::anim_single(var_01,"det_exit_drive_starting_anim_2");
	common_scripts\utility::flag_set("doctor_on_bike");
	param_00 thread maps\_anim::anim_loop(var_01,"det_exit_drive_starting_idle_2","joker_and_doctor_ender");
	wait(10);
	level.joker maps\_utility::gun_recall();
	param_00 notify("joker_and_doctor_ender");
}

//Function Number: 29
jetbike_exitdrive_bones(param_00)
{
	param_00 thread maps\_anim::anim_loop_solo(level.bones_bike,"det_exit_drive_starting_idle_1","bonesbike_idle_ender");
}

//Function Number: 30
exit_drive_starting_anims_ambient_danger()
{
	common_scripts\utility::flag_wait("player_on_exitdrive_jetbike");
	level.player enableinvulnerability();
	wait(1);
	thread exit_drive_starting_magic_bullets();
	common_scripts\utility::flag_wait("exit_drive_started");
	level.player disableinvulnerability();
	var_00 = getentarray("exit_drive_battle","targetname");
	var_01 = [];
	foreach(var_03 in var_00)
	{
		var_04 = var_03 maps\_utility::spawn_ai(1);
		var_04.fixednode = 1;
		var_04.grenadeammo = 0;
		var_04.baseaccuracy = 0.1;
		var_01[var_01.size] = var_04;
		wait(0.5);
	}

	wait(10);
	foreach(var_04 in var_01)
	{
		var_04 delete();
	}
}

//Function Number: 31
exit_drive_starting_magic_bullets()
{
	while(!common_scripts\utility::flag("exit_drive_started"))
	{
		var_00 = undefined;
		switch(randomintrange(0,3))
		{
			case 0:
				var_00 = common_scripts\utility::getstruct("org_exitdrive_magicbullet_01","targetname");
				break;

			case 1:
				var_00 = common_scripts\utility::getstruct("org_exitdrive_magicbullet_02","targetname");
				break;

			case 2:
				var_00 = common_scripts\utility::getstruct("org_exitdrive_magicbullet_03","targetname");
				break;
		}

		var_01 = undefined;
		switch(randomintrange(0,3))
		{
			case 0:
				var_01 = common_scripts\utility::getstruct("dest_exitdrive_magicbullet_01","targetname");
				break;

			case 1:
				var_01 = common_scripts\utility::getstruct("dest_exitdrive_magicbullet_02","targetname");
				break;

			case 2:
				var_01 = common_scripts\utility::getstruct("dest_exitdrive_magicbullet_03","targetname");
				break;
		}

		var_02 = randomintrange(3,9);
		for(var_03 = 0;var_03 < var_02;var_03++)
		{
			magicbullet("iw5_bal27_sp",var_00.origin,var_01.origin);
			wait(randomfloatrange(0.1,0.2));
		}

		wait(randomfloatrange(0.4,1.6));
	}
}

//Function Number: 32
setup_exitdrive_encounters()
{
	common_scripts\utility::flag_wait("exit_drive_started");
	thread linear_encounter_script();
	thread setup_park_rpg_barrage();
	thread setup_water_crash();
	thread setup_tracks_1();
	thread setup_tracks_2();
	thread setup_final_straightaway_missiles();
	thread setup_final_straightaway_buttresses();
	thread setup_final_straightaway_bus_jump();
	thread setup_final_chopper();
	thread setup_exitdrive_ending_anims();
	thread handle_spotlight_switch();
	thread exit_drive_script_checkpoints();
	thread exit_drive_jump_save_attempt();
	thread exit_drive_timeout_fail();
}

//Function Number: 33
handle_spotlight_switch()
{
	maps\_shg_design_tools::waittill_trigger_with_name("exitdrive_ending_spot_switch");
	level notify("kill_spotlight");
}

//Function Number: 34
shoot_at_chopper(param_00)
{
	self endon("death");
	var_01 = param_00.origin;
	level endon("mechs_stop_shooting");
	for(;;)
	{
		if(self gettagindex("tag_flash") != -1)
		{
			var_02 = self gettagorigin("tag_flash");
			var_03 = (randomfloatrange(-200,200),randomfloatrange(-200,200),randomfloatrange(-200,200));
			if(isdefined(param_00))
			{
				var_01 = param_00.origin;
			}
			else
			{
				maps\_utility::notify_delay("mechs_stop_shooting",5);
			}

			var_04 = magicbullet("heli_minigun_so",var_02,var_01 + var_03);
			wait 0.05;
			var_05 = magicbullet("heli_minigun_so",var_02,var_01 + var_03);
			wait 0.05;
			continue;
		}

		wait 0.05;
	}
}

//Function Number: 35
break_glass_when_near(param_00,param_01,param_02)
{
	while(distance(level.player.origin,param_01.origin) > param_00)
	{
		wait 0.05;
	}

	destroyglass(param_02,level.player.origin - param_01.origin);
}

//Function Number: 36
chopper_shoot_straight()
{
	self endon("chopper_stop_shooting");
	for(;;)
	{
		var_00 = self gettagorigin("TAG_MINIGUN_ATTACH_LEFT");
		var_01 = self gettagorigin("TAG_MINIGUN_ATTACH_RIGHT");
		var_02 = maps\_shg_design_tools::offset_position_from_tag("forward","TAG_MINIGUN_ATTACH_LEFT",600);
		var_03 = maps\_shg_design_tools::offset_position_from_tag("forward","TAG_MINIGUN_ATTACH_RIGHT",600);
		var_04 = maps\_shg_design_tools::offset_position_from_tag("forward","TAG_MINIGUN_ATTACH_LEFT",100);
		var_05 = maps\_shg_design_tools::offset_position_from_tag("forward","TAG_MINIGUN_ATTACH_RIGHT",100);
		var_06 = magicbullet("heli_minigun_so",var_04,var_02);
		var_07 = magicbullet("heli_minigun_so",var_05,var_03);
		wait 0.05;
	}
}

//Function Number: 37
chopper_shoot_down()
{
	self endon("death");
	for(;;)
	{
		chopper_shoot_down_internal("TAG_MINIGUN_ATTACH_LEFT");
		chopper_shoot_down_internal("TAG_MINIGUN_ATTACH_RIGHT");
		wait 0.05;
	}
}

//Function Number: 38
chopper_shoot_down_internal(param_00)
{
	var_01 = self gettagorigin(param_00);
	var_02 = self gettagangles(param_00);
	var_03 = anglestoup(var_02);
	var_04 = anglestoforward(var_02);
	var_05 = var_01 + var_04 * 100;
	var_06 = var_01 + var_03 * -1000 + var_04 * 2500;
	var_07 = "heli_minigun_so";
	if(randomint(100) > 90)
	{
		var_07 = "mig_25mm_cannon";
	}

	magicbullet(var_07,var_05,var_06);
}

//Function Number: 39
setup_park_rpg_barrage()
{
	level endon("missionfailed");
	var_00 = getent("spawner_rpg_fire_guy_01","targetname") maps\_utility::spawn_ai(1);
	var_01 = getent("spawner_rpg_fire_guy_02","targetname") maps\_utility::spawn_ai(1);
	var_02 = getent("spawner_rpg_fire_guy_03","targetname") maps\_utility::spawn_ai(1);
	var_00 thread kill_when_player_close();
	var_01 thread kill_when_player_close();
	var_02 thread kill_when_player_close();
	var_00.ignoreall = 1;
	var_01.ignoreall = 1;
	var_02.ignoreall = 1;
	var_03 = common_scripts\utility::getstruct("struct_rpg_fire_loc_01","targetname");
	var_04 = common_scripts\utility::getstruct("struct_rpg_fire_loc_02","targetname");
	var_05 = common_scripts\utility::getstruct("struct_rpg_fire_loc_03","targetname");
	common_scripts\utility::flag_wait("exit_drive_started");
	maps\_shg_design_tools::waittill_trigger_with_name("park_missile_01");
	var_06 = common_scripts\utility::getstruct("struct_rpg_fire_loc_03","targetname");
	var_07 = common_scripts\utility::getstruct("park_target_01","targetname");
	var_08 = magicbullet("rpg_custom_detroit_exit_drive",var_06.origin,var_07.origin);
	var_08 soundscripts\_snd::snd_message("exit_drive_rpgs");
	maps\_shg_design_tools::waittill_trigger_with_name("park_missile_02");
	var_06 = common_scripts\utility::getstruct("struct_rpg_fire_loc_02","targetname");
	var_07 = common_scripts\utility::getstruct("park_target_02","targetname");
	var_08 = magicbullet("rpg_custom_detroit_exit_drive",var_06.origin,var_07.origin);
	var_08 soundscripts\_snd::snd_message("exit_drive_rpgs");
	maps\_shg_design_tools::waittill_trigger_with_name("park_missile_03");
	var_06 = common_scripts\utility::getstruct("struct_rpg_fire_loc_03","targetname");
	var_07 = common_scripts\utility::getstruct("park_target_03","targetname");
	var_08 = magicbullet("rpg_custom_detroit_exit_drive",var_06.origin,var_07.origin);
	var_08 soundscripts\_snd::snd_message("exit_drive_rpgs");
	maps\_shg_design_tools::waittill_trigger_with_name("park_missile_05");
	var_06 = common_scripts\utility::getstruct("struct_rpg_fire_loc_01","targetname");
	var_07 = common_scripts\utility::getstruct("park_target_05","targetname");
	var_08 = magicbullet("rpg_custom_detroit_exit_drive",var_06.origin,var_07.origin);
	var_08 soundscripts\_snd::snd_message("exit_drive_rpgs");
	maps\_shg_design_tools::waittill_trigger_with_name("park_missile_07");
	var_06 = common_scripts\utility::getstruct("struct_rpg_fire_loc_03","targetname");
	var_07 = common_scripts\utility::getstruct("park_target_07","targetname");
	var_08 = magicbullet("rpg_custom_detroit_exit_drive",var_06.origin,var_07.origin);
	var_08 soundscripts\_snd::snd_message("exit_drive_rpgs");
}

//Function Number: 40
exit_drive_script_checkpoints()
{
	maps\_utility::trigger_wait_targetname("park_missile_02");
	maps\_utility::autosave_by_name("exit drive dealership");
}

//Function Number: 41
kill_when_player_close()
{
	self endon("death");
	for(;;)
	{
		var_00 = distance2d(self.origin,level.player.origin);
		if(var_00 < 150)
		{
			self kill();
			return;
		}

		wait(0.05);
	}
}

//Function Number: 42
linear_encounter_script()
{
	var_00 = getentarray("pitbull_refugee_camp","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}

	common_scripts\utility::flag_wait("exit_drive_started");
	level notify("ok_to_stop_sentinel_reveal_warnings");
	var_04 = maps\_vehicle::spawn_vehicle_from_targetname("exitdrive_chopper_initial");
	var_04 soundscripts\_snd::snd_message("exitdrive_chopper_initial");
	maps\_shg_design_tools::waittill_trigger_with_name("exitdrive_trigger_00a");
	var_04 soundscripts\_snd::snd_message("exitdrive_chopper_initial_gopath");
	var_04 maps\_vehicle::gopath();
	var_04 thread maps\detroit_lighting::trigger_chopper_spotlight_follow(level.burke_bike,0);
	maps\_shg_design_tools::waittill_trigger_with_name("exitdrive_trigger_01a");
	var_05 = maps\_vehicle::spawn_vehicle_from_targetname("exitdrive_vehicle_warehouse_02");
	var_05 setmodel("vehicle_mil_humvee_cleaner_01_ai");
	var_05 maps\_vehicle::gopath();
	var_05 thread maps\detroit::setup_cleanup_vehicle();
	var_05 thread vehicle_matchspeed(level.jetbike,8);
	var_05 soundscripts\_snd::snd_message("warehouse_chase_vehicle_01");
	maps\_shg_design_tools::waittill_trigger_with_name("exitdrive_trigger_01b");
	var_06 = maps\_vehicle::spawn_vehicle_from_targetname("exitdrive_vehicle_warehouse_03");
	var_06 setmodel("vehicle_mil_humvee_cleaner_01_ai");
	var_06 maps\_vehicle::gopath();
	var_06 thread maps\detroit::setup_cleanup_vehicle();
	var_06 thread vehicle_matchspeed(level.jetbike);
	var_06 soundscripts\_snd::snd_message("warehouse_chase_vehicle_02");
	maps\_shg_design_tools::waittill_trigger_with_name("exitdrive_trigger_01c");
	var_07 = maps\_vehicle::spawn_vehicle_from_targetname("exitdrive_vehicle_warehouse_04");
	var_07 setmodel("vehicle_mil_humvee_cleaner_01_ai");
	var_07 maps\_vehicle::gopath();
	var_07 soundscripts\_snd::snd_message("gaz_store_shootout_drive");
	var_07 thread maps\detroit::setup_cleanup_vehicle();
	var_07 thread vehicle_matchspeed(level.jetbike,-5);
	var_07 soundscripts\_snd::snd_message("warehouse_chase_vehicle_03");
	maps\_shg_design_tools::waittill_trigger_with_name("exitdrive_trigger_01d");
	thread trigger_store_drive_sequence(var_05,var_06,var_07);
	maps\_shg_design_tools::waittill_trigger_with_name("exitdrive_trigger_02a");
	var_05 thread vehicle_matchspeed(level.jetbike,25);
	var_06 thread vehicle_matchspeed(level.jetbike,25);
	var_07 thread vehicle_matchspeed(level.jetbike,25);
	maps\_shg_design_tools::waittill_trigger_with_name("exitdrive_trigger_02ab");
	var_05 thread vehicle_matchspeed(level.jetbike,4);
	var_06 thread vehicle_matchspeed(level.jetbike,4);
	var_07 thread vehicle_matchspeed(level.jetbike,4);
}

//Function Number: 43
trigger_store_drive_sequence(param_00,param_01,param_02)
{
	param_00.maxhealth = 30000;
	param_00.health = param_00.maxhealth;
	param_00 thread make_shooter_car(1);
	param_01.maxhealth = 30000;
	param_01.health = param_01.maxhealth;
	param_01 thread make_shooter_car();
	param_02.maxhealth = 30000;
	param_02.health = param_02.maxhealth;
	param_02 thread make_shooter_car();
	var_03 = [param_00,param_01,param_02];
	maps\_shg_design_tools::waittill_trigger_with_name("exitdrive_trigger_02a");
	wait(2);
	level notify("cars_stop_shooting");
}

//Function Number: 44
make_shooter_car(param_00)
{
	self endon("death");
	level endon("cars_stop_shooting");
	soundscripts\_snd::snd_message("warehouse_car_shots","cars_stop_shooting");
	for(;;)
	{
		var_01 = self;
		var_02 = "heli_minigun_so";
		var_03 = var_01 maps\_shg_design_tools::offset_position_from_tag("up","tag_origin",115);
		var_04 = level.jetbike maps\_shg_design_tools::offset_position_from_tag("forward","tag_origin",500);
		var_05 = (randomfloat(15),randomfloat(15),randomfloat(15));
		var_02 = magicbullet(var_02,var_03,var_04 + var_05);
		wait 0.05;
		if(level.nextgen)
		{
			if(maps\_shg_design_tools::percentchance(2))
			{
				wait(2);
			}

			continue;
		}

		for(var_06 = 0;var_06 < 7;var_06++)
		{
			wait 0.05;
		}

		if(maps\_shg_design_tools::percentchance(2))
		{
			wait(2);
		}
	}
}

//Function Number: 45
setup_tracks_1()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trig_exitdrive_slowmo_jump_end");
	maps\detroit_lighting::kill_spotlight();
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname("exitdrive_chopper_tracks_1");
	var_00 thread maps\detroit_lighting::trigger_chopper_spotlight_straight(1);
	var_00 soundscripts\_snd::snd_message("exitdrive_chopper_tracks_1");
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_chopper_tracks_1");
	var_00 soundscripts\_snd::snd_message("exitdrive_chopper_tracks_1_gopath");
	var_00 maps\_vehicle::gopath();
	wait(3);
	var_00 thread chopper_shoot_down();
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_rail_dodge_01a");
	var_00 delete();
}

//Function Number: 46
setup_tracks_2()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trigger_rail_dodge_01a");
	common_scripts\utility::flag_set("lightning_on");
	var_00 = getentarray("curve_path_01","targetname");
	var_01 = getent("curve_path_01_start","targetname");
	var_02 = getentarray("curve_path_02","targetname");
	var_03 = getent("curve_path_02_start","targetname");
	var_04 = getentarray("exit_train3_path","targetname");
	var_05 = getent("exit_train3_start","targetname");
	var_06 = run_train(var_01,var_00,900,undefined,"rail_dodge_car_clip_1");
	var_06 soundscripts\_snd::snd_message("exit_train_by",1);
	wait(1.5);
	var_07 = run_train(var_03,var_02,600,undefined,"rail_dodge_car_clip_2");
	var_07 soundscripts\_snd::snd_message("exit_train_by",2);
	var_08 = 0.52;
	var_09 = 0;
	for(var_0A = 3;var_0A < 13;var_0A++)
	{
		if(var_0A == 3)
		{
			var_0B = run_train(var_05,var_04,800,undefined,"rail_dodge_car_clip_" + var_0A);
		}
		else
		{
			var_0B = run_train(var_05,var_04,800,undefined,"rail_dodge_car_clip_" + var_0A);
		}

		if(!var_09)
		{
			var_0B soundscripts\_snd::snd_message("exit_train_by",3);
			var_09 = 1;
		}

		wait(var_08);
	}
}

//Function Number: 47
setup_water_crash()
{
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname("gaz_water_crash_01");
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname("gaz_water_crash_02");
	maps\_shg_design_tools::waittill_trigger_with_name("trig_exit_water_jeep_01");
	common_scripts\utility::flag_set("burke needs to stop rubber banding now");
	level.burke_bike notify("vehicle_rubberband_stop");
	level.burke_bike vehicle_setspeed(45,10,15);
	wait(1);
	var_00 setmodel("vehicle_mil_humvee_cleaner_01_ai");
	var_01 setmodel("vehicle_mil_humvee_cleaner_01_ai");
	level.player.ignoreme = 1;
	var_00.mgturret[0] thread animscripts\hummer_turret\common::set_manual_target(level.burke,999,9999,"turret_stop_firing");
	var_00 maps\_vehicle::gopath();
	var_00 thread exit_drive_gaz_physics();
	var_00 soundscripts\_snd::snd_message("gaz_water_crash_01");
	var_00 maps\_vehicle::vehicle_lights_on("headlights_cheap");
	var_00 thread keep_up_with_burke();
	wait(0.25);
	var_01 maps\_vehicle::gopath();
	var_01 thread exit_drive_gaz_physics();
	var_01 soundscripts\_snd::snd_message("gaz_water_crash_02");
	var_01 maps\_vehicle::vehicle_lights_on("headlights_cheap");
	var_01 thread keep_up_with_burke();
	common_scripts\utility::flag_wait("flag_fan_out");
	var_01 maps\detroit_jetbike::vehicle_rubberband(level.burke_bike,-500);
	common_scripts\utility::flag_wait("flag_water_crash_1");
	level.burke_bike thread maps\detroit_jetbike::vehicle_rubberband_set_desired_range(400);
	level.burke_bike thread maps\detroit_jetbike::vehicle_rubberband_think();
	var_00 soundscripts\_snd::snd_message("gaz_water_crashed",var_01);
	level.burke.ignoreme = 1;
	var_00.mgturret[0] notify("turret_stop_firing");
	wait(0.25);
	physicsexplosionsphere(var_00.origin + (50,0,0),200,50,3);
	common_scripts\utility::flag_wait("flag_water_crash_2");
	wait(0.25);
	physicsexplosionsphere(var_01.origin - (50,0,0),200,50,3);
	level.burke_bike maps\detroit_jetbike::vehicle_rubberband_set_desired_range(1000);
}

//Function Number: 48
burke_bike_speed()
{
	for(;;)
	{
		iprintln(level.burke_bike.speed);
		wait(0.5);
	}
}

//Function Number: 49
keep_up_with_burke()
{
	for(;;)
	{
		if(isdefined(self))
		{
			self vehicle_setspeed(level.burke_bike.speed,15,10);
			wait(0.05);
		}
	}
}

//Function Number: 50
water_crash_jeep_1(param_00)
{
	var_01 = getent("jeep_pusher_1","targetname");
	var_02 = var_01 common_scripts\utility::get_target_ent();
	var_02 linkto(var_01);
	var_01 hide();
	common_scripts\utility::flag_wait("flag_water_crash_jeep_1");
	var_03 = 0.075;
	var_01 moveto(var_01.origin + (0,0,50),var_03,0,0);
	wait(var_03 + 0.2);
	physicsexplosionsphere(param_00.origin + (50,0,0),100,80,1);
	var_01 moveto(var_01.origin - (0,0,50),0.05,0,0);
	var_02 notsolid();
	param_00 vehicle_setspeed(0,50,50);
}

//Function Number: 51
water_crash_jeep_2(param_00)
{
	var_01 = getent("jeep_pusher_2","targetname");
	var_02 = var_01 common_scripts\utility::get_target_ent();
	var_02 linkto(var_01);
	var_01 hide();
	common_scripts\utility::flag_wait("flag_water_crash_jeep_2");
	var_03 = 0.085;
	var_01 moveto(var_01.origin + (0,0,50),var_03,0,0);
	wait(var_03 + 0.2);
	physicsexplosionsphere(param_00.origin - (50,0,0),100,80,1);
	var_01 moveto(var_01.origin - (0,0,50),0.05,0,0);
	var_02 notsolid();
	param_00 vehicle_setspeed(0,50,50);
}

//Function Number: 52
exit_drive_gaz_physics()
{
	level endon("flag_water_crash_1");
	level endon("flag_water_crash_2");
	var_00 = 74;
	var_01 = 200;
	var_02 = 200;
	var_03 = -100;
	var_04 = 0.06;
	for(;;)
	{
		var_05 = var_04;
		var_06 = self.origin + anglestoforward(self.angles) * var_02 + anglestoup(self.angles) * var_03;
		if(level.nextgen)
		{
			wakeupphysicssphere(var_06,var_01);
		}
		else
		{
			physicsexplosionsphere(var_06,var_01,var_00,var_05,0);
		}

		wait(0.05);
	}
}

//Function Number: 53
setup_final_chopper()
{
	maps\_shg_design_tools::waittill_trigger_with_name("trig_exit_water_jeep_01");
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname("exitdrive_chopper_final");
	level.final_scripted_chopper = var_00;
	var_00 soundscripts\_snd::snd_message("exitdrive_chopper_final");
	maps\detroit_lighting::kill_spotlight();
	maps\_shg_design_tools::waittill_trigger_with_name("trig_final_chopper");
	var_00 soundscripts\_snd::snd_message("exitdrive_chopper_final_gopath");
	var_00 maps\_vehicle::gopath();
	wait(1);
	var_00 thread maps\detroit_lighting::trigger_chopper_spotlight_follow(level.burke_bike,0);
	common_scripts\utility::flag_wait("flag_chopper_match_speed");
	var_00 thread maps\detroit_jetbike::vehicle_rubberband(level.jetbike,-400);
}

//Function Number: 54
setup_final_straightaway_missiles()
{
	maps\_shg_design_tools::waittill_trigger_with_name("final_straightaway_missile_01");
	var_00 = common_scripts\utility::getstruct("final_straightaway_org_01","targetname");
	var_01 = common_scripts\utility::getstruct("final_straightaway_target_01","targetname");
	var_02 = magicbullet("sidewinder_warhawk_aftermath",var_00.origin,var_01.origin);
	var_02 soundscripts\_snd::snd_message("collapsing_buttress_missile");
	maps\_shg_design_tools::waittill_trigger_with_name("final_straightaway_missile_02");
	var_00 = common_scripts\utility::getstruct("final_straightaway_org_02","targetname");
	var_01 = common_scripts\utility::getstruct("final_straightaway_target_02","targetname");
	var_02 = magicbullet("sidewinder_warhawk_aftermath",var_00.origin,var_01.origin);
	var_02 soundscripts\_snd::snd_message("collapsing_buttress_missile");
	maps\_shg_design_tools::waittill_trigger_with_name("final_straightaway_missile_03");
	var_00 = common_scripts\utility::getstruct("final_straightaway_org_03","targetname");
	var_01 = common_scripts\utility::getstruct("final_straightaway_target_03","targetname");
	var_02 = magicbullet("sidewinder_warhawk_aftermath",var_00.origin,var_01.origin);
	var_02 soundscripts\_snd::snd_message("collapsing_buttress_missile");
	maps\_shg_design_tools::waittill_trigger_with_name("final_straightaway_missile_04");
	var_00 = common_scripts\utility::getstruct("final_straightaway_org_04","targetname");
	var_01 = common_scripts\utility::getstruct("final_straightaway_target_04","targetname");
	var_02 = magicbullet("sidewinder_warhawk_aftermath",var_00.origin,var_01.origin);
	var_02 soundscripts\_snd::snd_message("collapsing_buttress_missile");
	maps\_shg_design_tools::waittill_trigger_with_name("final_straightaway_missile_05");
	var_00 = common_scripts\utility::getstruct("final_straightaway_org_05","targetname");
	var_01 = common_scripts\utility::getstruct("final_straightaway_target_05","targetname");
	var_02 = magicbullet("sidewinder_warhawk_aftermath",var_00.origin,var_01.origin);
	var_02 soundscripts\_snd::snd_message("collapsing_buttress_missile");
	maps\_shg_design_tools::waittill_trigger_with_name("final_straightaway_missile_06");
	var_00 = common_scripts\utility::getstruct("final_straightaway_org_06","targetname");
	var_01 = common_scripts\utility::getstruct("final_straightaway_target_06","targetname");
	var_02 = magicbullet("sidewinder_warhawk_aftermath",var_00.origin,var_01.origin);
	var_02 soundscripts\_snd::snd_message("collapsing_buttress_missile");
	maps\_shg_design_tools::waittill_trigger_with_name("final_straightaway_missile_07");
	var_00 = common_scripts\utility::getstruct("final_straightaway_org_07","targetname");
	var_01 = common_scripts\utility::getstruct("final_straightaway_target_07","targetname");
	var_02 = magicbullet("sidewinder_warhawk_aftermath",var_00.origin,var_01.origin);
	var_02 soundscripts\_snd::snd_message("collapsing_buttress_missile");
	maps\_shg_design_tools::waittill_trigger_with_name("final_straightaway_missile_08");
	var_00 = common_scripts\utility::getstruct("final_straightaway_org_08","targetname");
	var_01 = common_scripts\utility::getstruct("final_straightaway_target_08","targetname");
	var_02 = magicbullet("sidewinder_warhawk_aftermath",var_00.origin,var_01.origin);
	var_02 soundscripts\_snd::snd_message("collapsing_buttress_missile");
	maps\_shg_design_tools::waittill_trigger_with_name("final_straightaway_missile_09");
	var_00 = common_scripts\utility::getstruct("final_straightaway_org_09","targetname");
	var_01 = common_scripts\utility::getstruct("final_straightaway_target_09","targetname");
	var_02 = magicbullet("sidewinder_warhawk_aftermath",var_00.origin,var_01.origin);
	var_02 soundscripts\_snd::snd_message("collapsing_buttress_missile");
	maps\_shg_design_tools::waittill_trigger_with_name("final_straightaway_missile_10");
	var_00 = common_scripts\utility::getstruct("final_straightaway_org_10","targetname");
	var_01 = common_scripts\utility::getstruct("final_straightaway_target_10","targetname");
	var_03 = common_scripts\utility::getstruct("final_straightaway_target_10b","targetname");
	var_04 = common_scripts\utility::getstruct("final_straightaway_target_10c","targetname");
	var_02 = magicbullet("sidewinder_warhawk_aftermath",var_00.origin,var_01.origin);
	var_02 soundscripts\_snd::snd_message("collapsing_buttress_missile");
	wait(0.4);
	var_02 = magicbullet("sidewinder_warhawk_aftermath",var_00.origin,var_04.origin);
	var_02 soundscripts\_snd::snd_message("collapsing_buttress_missile");
	wait(0.3);
	var_02 = magicbullet("sidewinder_warhawk_aftermath",var_00.origin,var_03.origin);
	var_02 soundscripts\_snd::snd_message("collapsing_buttress_missile");
	maps\_shg_design_tools::waittill_trigger_with_name("final_straightaway_missile_14");
	var_00 = common_scripts\utility::getstruct("final_straightaway_org_14","targetname");
	var_01 = common_scripts\utility::getstruct("final_straightaway_target_14","targetname");
	var_02 = magicbullet("sidewinder_warhawk_aftermath",var_00.origin,var_01.origin);
	var_02 soundscripts\_snd::snd_message("collapsing_buttress_missile");
	maps\_shg_design_tools::waittill_trigger_with_name("final_straightaway_missile_15");
	var_00 = common_scripts\utility::getstruct("final_straightaway_org_15","targetname");
	var_01 = common_scripts\utility::getstruct("final_straightaway_target_15","targetname");
	var_02 = magicbullet("sidewinder_warhawk_aftermath",var_00.origin,var_01.origin);
	var_02 soundscripts\_snd::snd_message("collapsing_buttress_missile");
}

//Function Number: 55
setup_final_straightaway_buttresses()
{
	common_scripts\utility::flag_wait("exit_drive_started");
	var_00 = getentarray("collapsing_buttress_04","targetname");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}

	wait(1);
	maps\_utility::disable_trigger_with_targetname("trigger_buttress_fail_01");
	maps\_utility::disable_trigger_with_targetname("trigger_buttress_fail_03");
	var_04 = 3.25;
	maps\_shg_design_tools::waittill_trigger_with_name("final_straightaway_missile_02");
	wait(0.4);
	maps\_utility::delaythread(var_04 - 1,::maps\_utility::enable_trigger_with_targetname,"trigger_buttress_fail_01");
	maps\_utility::delaythread(var_04 + 1,::maps\_utility::disable_trigger_with_targetname,"trigger_buttress_fail_01");
	var_05 = getentarray("collapsing_buttress_01","targetname");
	var_05 soundscripts\_snd::snd_message("collapsing_buttress_01");
	foreach(var_02 in var_05)
	{
		var_02 delete();
	}

	maps\_shg_design_tools::waittill_trigger_with_name("final_straightaway_missile_04");
	wait(0.4);
	var_08 = getentarray("collapsing_buttress_02","targetname");
	var_08 soundscripts\_snd::snd_message("collapsing_buttress_02");
	foreach(var_02 in var_08)
	{
		var_02 delete();
	}

	maps\_shg_design_tools::waittill_trigger_with_name("final_straightaway_missile_07");
	wait(0.4);
	maps\_utility::delaythread(var_04 - 1,::maps\_utility::enable_trigger_with_targetname,"trigger_buttress_fail_03");
	maps\_utility::delaythread(var_04 + 1,::maps\_utility::disable_trigger_with_targetname,"trigger_buttress_fail_03");
	var_0B = getentarray("collapsing_buttress_03","targetname");
	var_0B soundscripts\_snd::snd_message("collapsing_buttress_03");
	foreach(var_02 in var_0B)
	{
		var_02 delete();
	}
}

//Function Number: 56
setup_final_straightaway_bus_jump()
{
	maps\_shg_design_tools::waittill_trigger_with_name("final_straightaway_bus_jump");
	var_00 = common_scripts\utility::getstruct("final_straightaway_org_bus_jump","targetname");
	var_01 = level.jetbike.origin + (50,0,200);
	wait(0.5);
	var_02 = magicbullet("sidewinder_warhawk_aftermath",var_00.origin,var_01);
}

//Function Number: 57
drawstringtime(param_00,param_01,param_02,param_03)
{
	var_04 = param_03 * 20;
	for(var_05 = 0;var_05 < var_04;var_05++)
	{
		wait(0.05);
	}
}

//Function Number: 58
setup_exitdrive_ending_anims()
{
	var_00 = getent("detroit_entrance_gate","targetname");
	var_00.animname = "gate";
	var_00 useanimtree(#animtree);
	var_01 = getent("exit_drive_ending","targetname");
	var_01 maps\_anim::anim_first_frame_solo(var_00,"det_exit_drive_ending");
	common_scripts\utility::flag_wait("exitdrive_ending_approach");
	thread maps\detroit_lighting::ending_mech_lighting();
	common_scripts\utility::flag_clear("exitdrive_lights_on");
	var_02 = getent("org_mech1_final_stand","targetname");
	var_03 = getent("org_mech2_final_stand","targetname");
	var_04 = getent("org_mech3_final_stand","targetname");
	var_05 = getent("exit_drive_mech1","targetname");
	var_06 = getent("exit_drive_mech2","targetname");
	var_07 = getent("exit_drive_mech3","targetname");
	var_08 = "det_exit_drive_ending_idle";
	var_09 = "mech_cover_idle_end";
	var_0A = var_05 maps\_utility::spawn_ai(1);
	var_0B = var_06 maps\_utility::spawn_ai(1);
	var_0C = var_07 maps\_utility::spawn_ai(1);
	thread maps\detroit_lighting::mech_exit_gate_lighting(var_0C);
	var_0A.ignoreall = 1;
	var_0B.ignoreall = 1;
	var_0C.ignoreall = 1;
	var_0D = [];
	var_0D[var_0D.size] = var_0A;
	var_0D[var_0D.size] = var_0B;
	var_0D[var_0D.size] = var_0C;
	thread maps\detroit_lighting::move_mech_origins(var_0D);
	var_0A.animname = "exitdrive_mech1";
	var_0B.animname = "exitdrive_mech2";
	var_0C.animname = "exitdrive_mech3";
	var_01 thread maps\_anim::anim_loop(var_0D,var_08,var_09);
	thread exitdrive_ending_anims_burke();
	level notify("vfx_player_jetbike_stops");
	common_scripts\utility::flag_clear("exit_drive_ending_begin_player");
	common_scripts\utility::flag_wait("exit_drive_ending_begin_player");
	common_scripts\utility::flag_set("obj_escape_detroit_complete");
	soundscripts\_snd::snd_message("exit_drive_ending_begin");
	prep_cinematic("fusion_endlogo");
	var_0E = level.jetbike maps\_utility::spawn_anim_model("world_body",level.player.origin);
	level.jetbike thread maps\_anim::anim_first_frame_solo(var_0E,"det_exit_drive_ending","tag_passenger");
	waittillframeend;
	var_0E linkto(level.jetbike,"tag_passenger");
	var_0E hide();
	level.jetbike vehicle_scripts\_jetbike::jetbike_blend_out_fake_speed(1.5);
	maps\_utility::delaythread(5,::common_scripts\utility::flag_set,"stop_exit_drive_rumbles");
	vehicle_scripts\_jetbike::smooth_vehicle_animation_wait(level.jetbike,var_01,"det_exit_drive_ending",41.2365,1.5);
	var_01 notify(var_09);
	level.player maps\_shg_utility::setup_player_for_scene(0);
	var_0F = maps\_utility::spawn_anim_model("littlebird");
	thread maps\detroit_lighting::final_chopper_lighting(var_0F);
	var_0F.spotlight = level.final_scripted_chopper.spotlight;
	level.final_scripted_chopper delete();
	var_0F thread maps\detroit_lighting::trigger_chopper_spotlight_follow(level.burke_bike,1);
	thread exitdrive_ending_anims_player(var_01,var_0E);
	var_0D[var_0D.size] = level.bones;
	var_0D[var_0D.size] = level.bones_bike;
	var_0D[var_0D.size] = level.joker;
	var_0D[var_0D.size] = level.joker_bike;
	var_0D[var_0D.size] = level.doctor;
	var_0D[var_0D.size] = var_0F;
	var_0D[var_0D.size] = var_00;
	var_01 thread maps\_anim::anim_single(var_0D,"det_exit_drive_ending");
	level waittill("detroit_final_chopper_hit");
	level notify("kill_spotlight");
	level waittill("detroit_level_fadeout");
	var_10 = 6;
	thread ending_fade_out(var_10);
	maps\_player_exo::player_exo_deactivate();
	maps\_utility::delaythread(3,::maps\_utility::nextmission);
	thread maps\_utility::battlechatter_off("allies");
	thread maps\_utility::battlechatter_off("axis");
	wait(var_10);
}

//Function Number: 59
exitdrive_ending_anims_player(param_00,param_01)
{
	thread vehicle_scripts\_jetbike::smooth_vehicle_animation_play(level.jetbike,param_00,"det_exit_drive_ending",[],0,0.5);
	waittillframeend;
	level.jetbike thread maps\_anim::anim_single_solo(param_01,"det_exit_drive_ending","tag_passenger");
	level.jetbike setanimtime(level.jetbike maps\_utility::getanim("det_exit_drive_ending"),0);
	param_01 setanimtime(param_01 maps\_utility::getanim("det_exit_drive_ending"),0);
	param_01 show();
	level.jetbike vehicle_scripts\_jetbike::jetbike_stop_player_use();
	level.jetbike vehicle_jetbikesethoverforcescale(0);
	level.player playerlinktodelta(param_01,"tag_player",1,0,0,0,0,1);
	wait(1.5);
	maps\detroit::controller_rumble_heavy3();
	wait(2.85);
	maps\detroit::controller_rumble_heavy0();
	wait(2);
	maps\detroit::controller_rumble_heavy0();
	wait(0.9);
	maps\detroit::controller_rumble_heavy0();
	wait(0.35);
	maps\detroit::controller_rumble_heavy0();
	wait(0.35);
	maps\detroit::controller_rumble_heavy0();
	wait(0.35);
	maps\detroit::controller_rumble_heavy0();
	wait(0.35);
	maps\detroit::controller_rumble_heavy1();
	wait(1.5);
	maps\detroit::controller_rumble_light3();
	wait(1);
	maps\detroit::controller_rumble_light3();
	wait(2);
	maps\detroit::controller_rumble_heavy2();
	wait(1.5);
	maps\detroit::controller_rumble_heavy2();
	wait(1);
	maps\detroit::controller_rumble_heavy2();
	wait(1);
	maps\detroit::controller_rumble_heavy3();
}

//Function Number: 60
prep_cinematic(param_00)
{
	setsaveddvar("cg_cinematicFullScreen","0");
	cinematicingame(param_00,1);
	level.current_cinematic = param_00;
}

//Function Number: 61
play_cinematic(param_00,param_01,param_02)
{
	if(isdefined(level.current_cinematic))
	{
		pausecinematicingame(0);
		setsaveddvar("cg_cinematicFullScreen","1");
		level.current_cinematic = undefined;
	}
	else
	{
		cinematicingame(param_00);
	}

	if(!isdefined(param_02) || !param_02)
	{
		setsaveddvar("cg_cinematicCanPause","1");
	}

	wait(1);
	while(iscinematicplaying())
	{
		wait(0.05);
	}

	if(!isdefined(param_02) || !param_02)
	{
		setsaveddvar("cg_cinematicCanPause","0");
	}
}

//Function Number: 62
ending_fade_out(param_00)
{
	var_01 = newhudelem();
	var_01.x = 0;
	var_01.y = 0;
	var_01.horzalign = "fullscreen";
	var_01.vertalign = "fullscreen";
	var_01 setshader("black",640,480);
	if(isdefined(param_00) && param_00 > 0)
	{
		var_01.alpha = 0;
		var_01 fadeovertime(param_00);
		var_01.alpha = 1;
		wait(param_00);
	}

	waittillframeend;
	var_01 destroy();
}

//Function Number: 63
anim_debug(param_00,param_01)
{
	for(;;)
	{
		waittillframeend;
		waittillframeend;
		waittillframeend;
		waittillframeend;
		waittillframeend;
		waittillframeend;
		var_02 = param_01 maps\_utility::getanim("det_exit_drive_ending");
		var_03 = param_01 getanimtime(var_02);
		var_04 = var_03 * getanimlength(var_02);
		var_05 = param_01 getanimweight(var_02);
		var_06 = param_00 maps\_utility::getanim("det_exit_drive_ending");
		var_07 = param_00 getanimtime(var_06);
		var_08 = var_07 * getanimlength(var_06);
		var_09 = param_00 getanimweight(var_06);
		wait(0.05);
	}
}

//Function Number: 64
exitdrive_ending_anims_burke()
{
	var_00 = getent("exit_drive_ending","targetname");
	common_scripts\utility::flag_wait("exit_drive_ending_begin_burke");
	vehicle_scripts\_jetbike::smooth_vehicle_animation_wait(level.burke_bike,var_00,"det_exit_drive_ending",53.0937);
	level.burke maps\_vehicle_aianim::disassociate_guy_from_vehicle();
	level.burke unlink();
	thread vehicle_scripts\_jetbike::smooth_vehicle_animation_play(level.burke_bike,var_00,"det_exit_drive_ending",[level.burke],0,0.25);
}

//Function Number: 65
delete_self_on_death_of(param_00)
{
	param_00 waittill("death");
	self delete();
}

//Function Number: 66
run_train(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 650;
	var_06 = 3;
	if(!isdefined(param_03))
	{
		var_07 = "vehicle_civ_det_train_car_01";
		param_03 = spawn("script_model",param_00.origin);
		param_03 setmodel(var_07);
	}

	var_08 = undefined;
	if(isdefined(param_04))
	{
		var_08 = getent(param_04,"targetname");
		var_08 thread delete_self_on_death_of(param_03);
	}

	var_09 = common_scripts\utility::spawn_tag_origin();
	var_09 linkto(param_03,"",(300,0,80),(25,0,0));
	var_0A = common_scripts\utility::spawn_tag_origin();
	var_0A linkto(param_03,"",(300,0,80),(0,0,0));
	var_0B = common_scripts\utility::spawn_tag_origin();
	var_0B linkto(param_03,"",(200,0,15),(0,90,0));
	thread maps\detroit_lighting::train_lighting(var_09,var_0A,var_0B);
	if(!isdefined(param_03.tags))
	{
		param_03.tags = [];
	}

	param_03.tags[param_03.tags.size] = var_09;
	param_03.tags[param_03.tags.size] = var_0A;
	param_03.tags[param_03.tags.size] = var_0B;
	param_03.origin = param_00.origin;
	param_03.angles = param_00.angles;
	param_01 = sortbydistance(param_01,param_00.origin);
	param_03 thread maps\detroit_streets::train_gopath(param_01,param_02,var_08);
	return param_03;
}

//Function Number: 67
run_train_shaker(param_00,param_01)
{
	self endon("train_delete");
	self endon("train_shutdown");
	self endon("death");
	for(;;)
	{
		var_02 = distance(self.origin,level.player.origin);
		if(var_02 < param_00)
		{
			earthquake(0.4,param_01,self.origin,param_00);
			wait(param_01);
		}

		wait 0.05;
	}
}

//Function Number: 68
delete_on_notify(param_00,param_01)
{
	param_00 endon("death");
	self waittill(param_01);
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 69
player_proximity_rumble(param_00)
{
	while(isdefined(self))
	{
		if(!isdefined(param_00))
		{
			param_00 = 850;
		}

		when_am_i_near_player(param_00);
		var_01 = level.player maps\_utility::get_rumble_ent("steady_rumble");
		var_01 thread rumble_till_out_of_range(param_00,self);
		return;
	}

	level notify("rumble_stop_train");
}

//Function Number: 70
exit_drive_jump_save_attempt()
{
	maps\_utility::trigger_wait_targetname("attempt_to_save_by_jump");
	var_00 = distance(level.burke.origin,level.player.origin);
	if(var_00 < 2000)
	{
		maps\_utility::autosave_by_name();
	}
}

//Function Number: 71
exit_drive_timeout_fail()
{
	common_scripts\utility::flag_wait("flag_gate_in_sight");
	level endon("exit_drive_ending_begin_player");
	wait(5);
	common_scripts\utility::flag_set("flag_jetbike_fail");
}

//Function Number: 72
rumble_till_out_of_range(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 0.8;
	}

	if(!isdefined(param_03))
	{
		param_03 = 150;
	}

	for(;;)
	{
		if(isdefined(param_01))
		{
			var_04 = distance(param_01.origin,level.player.origin);
			if(var_04 >= param_00)
			{
				maps\_utility::set_rumble_intensity(0.01);
			}

			if(var_04 < param_00)
			{
				if(var_04 == 0)
				{
					var_04 = 1;
				}

				var_05 = param_02 / var_04 / param_03;
				if(var_05 > 1)
				{
					var_05 = 1;
				}

				maps\_utility::set_rumble_intensity(var_05);
			}
		}

		if(!isdefined(param_01))
		{
			level notify("rumble_stop_train");
			self stoprumble("steady_rumble");
			return;
		}

		wait(0.05);
	}
}

//Function Number: 73
when_am_i_near_player(param_00)
{
	while(isdefined(self))
	{
		if(distance2d(self.origin,level.player.origin) < param_00)
		{
			return;
		}

		wait(0.05);
	}
}

//Function Number: 74
stop_rumble_on_notify(param_00)
{
	level waittill(param_00);
	self stoprumble("steady_rumble");
}

//Function Number: 75
vehicle_matchspeed(param_00,param_01,param_02)
{
	self endon("death");
	self notify("kill_vehicle_matchspeed");
	self endon("kill_vehicle_matchspeed");
	param_00 endon("death");
	var_03 = 0;
	if(isdefined(param_01))
	{
		var_03 = randomfloat(param_01);
	}

	for(;;)
	{
		var_04 = param_00 vehicle_getspeed();
		if(isdefined(param_02))
		{
			var_04 = var_04 + param_02;
		}

		var_05 = var_04 + var_03;
		if(var_05 < 0)
		{
			var_05 = 0;
		}

		self vehicle_setspeed(var_05,60,60);
		wait 0.05;
	}
}

//Function Number: 76
cleanup_school_cars()
{
	common_scripts\utility::flag_wait("school_jeep_delete");
	var_00 = getent("cleanup_vehicle_outside_school_clip","targetname");
	var_00 delete();
	var_01 = getent("cleanup_vehicle_outside_school","targetname");
	var_01 delete();
	maps\detroit_school::cg_open_close_school_entrance_doors(0);
	maps\detroit_lighting::turn_off_jeep_light();
}