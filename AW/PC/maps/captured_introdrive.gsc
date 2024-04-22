/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: captured_introdrive.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 29
 * Decompile Time: 426 ms
 * Timestamp: 4/22/2024 2:26:19 AM
*******************************************************************/

//Function Number: 1
pre_load()
{
}

//Function Number: 2
post_load()
{
	common_scripts\utility::flag_init("flag_t2e_moveup");
	common_scripts\utility::flag_init("flag_entered_s1elevator");
	common_scripts\utility::flag_init("flag_start_s1elevator");
	common_scripts\utility::flag_init("flag_intro_bounds_double_check");
	common_scripts\utility::flag_init("lgt_flag_introdrive");
}

//Function Number: 3
start()
{
	level.player disableweapons();
	level.player disableoffhandweapons();
	level.player disableweaponswitch();
	setsaveddvar("g_friendlyNameDist",0);
	thread maps\_utility::battlechatter_off("allies");
	thread maps\_utility::battlechatter_off("axis");
	if(issubstr(level.start_point,"introdrive"))
	{
		level.player maps\captured_util::warp_to_start("origin_playerstart_introdrive");
		maps\captured_util::warp_allies("struct_allystart_introdrive");
		return;
	}

	level.player maps\captured_util::warp_to_start("struct_playerstart_s1elevator");
	soundscripts\_snd::snd_message("start_s1_elevator");
	thread truck_to_s1elevator_scene();
	common_scripts\utility::flag_set("flag_introdrive_end");
}

//Function Number: 4
main_introdrive()
{
	level.player freezecontrols(1);
	common_scripts\utility::flag_wait("chyron_video_done");
	soundscripts\_snd::snd_message("scn_truck_sounds");
	soundscripts\_snd::snd_music_message("mus_captured_intro");
	soundscripts\_snd::snd_message("start_intro_drive");
	soundscripts\_snd::snd_message("aud_mech_idle_sfx");
	setsaveddvar("g_friendlyNameDist",0);
	level.player enableslowaim(0.3,0.15);
	common_scripts\utility::flag_set("lgt_flag_introdrive");
	var_00 = getent("model_introdrive_playertruck","targetname");
	thread player_truck(var_00);
	thread intro_ambient_cleanup();
	thread s1_drive_and_elevator_scene(var_00);
	wait(1);
	if(!level.currentgen)
	{
		thread maps\captured_util::captured_caravan_spawner("intro_drive_truck_one",3,9.1,9.2,"intro_drive");
	}
	else
	{
		thread maps\captured_util::captured_caravan_spawner("intro_drive_truck_one",3,19.1,19.2,"intro_drive");
	}

	wait(10);
	wait(12.5);
	if(!level.currentgen)
	{
		thread maps\captured_util::captured_caravan_spawner("intro_drive_trucks",undefined,3,10,"intro_drive");
	}
	else
	{
		thread maps\captured_util::captured_caravan_spawner("intro_drive_trucks",undefined,18,23,"intro_drive");
	}

	common_scripts\utility::flag_wait("flag_introdrive_end");
	level.player disableslowaim();
}

//Function Number: 5
intro_ambient_cleanup()
{
	maps\_utility::wait_for_targetname_trigger("intro_ambient_cleanup");
	level notify("s1_killpoppingcharacters");
	level notify("s1_looping_prisoner_intro");
}

//Function Number: 6
main_s1elevator()
{
	common_scripts\utility::flag_wait("flag_s1elevator_end");
}

//Function Number: 7
player_truck(param_00)
{
	var_01 = getent("origin_playerstart_introdrive","targetname") common_scripts\utility::spawn_tag_origin();
	soundscripts\_snd::snd_message("entrance_alarm");
	var_02 = maps\_vehicle::spawn_vehicle_from_targetname("vehicle_introdrive_player");
	var_02 hide();
	param_00 linkto(var_02,"tag_origin",(0,0,0),(0,0,0));
	if(level.currentgen)
	{
		param_00 thread maps\captured_util::tff_cleanup_vehicle("intro_drive");
		var_02 thread maps\captured_util::tff_cleanup_vehicle("intro_drive");
	}

	soundscripts\_snd::snd_message("entrance_alarm_fast2");
	var_03 = getvehiclenode("intro_drive_player_vehicle_entrance_start","targetname");
	var_02 attachpath(var_03);
	var_02 startpath();
	var_02 waittill("reached_end_node");
	wait(7);
	soundscripts\_snd::snd_message("entrance_alarm_fast");
}

//Function Number: 8
s1_drive_and_elevator_scene(param_00)
{
	var_01 = common_scripts\utility::getstruct("struct_scene_truckunload","targetname");
	var_02 = getent("origin_scene_s1elevator","targetname");
	thread player_fov_controller();
	wait(3.5);
	if(!isdefined(var_01))
	{
		return;
	}

	var_03 = common_scripts\utility::spawn_tag_origin();
	var_03 linkto(param_00,"tag_origin",(0,0,0),(0,90,0));
	var_04 = level.allies[2];
	var_05 = level.allies;
	common_scripts\utility::array_thread(var_05,::maps\captured_util::ignore_everything);
	common_scripts\utility::array_thread(var_05,::maps\_utility::gun_remove);
	var_06 = [level.allies[0],level.allies[1]];
	foreach(var_04 in level.allies)
	{
		var_04 attach("s1_captured_handcuffs","tag_weapon_left");
		var_04.hasattachedprops = 1;
		var_04 linkto(var_03);
	}

	var_09 = maps\_utility::array_spawn_noteworthy("truck_to_s1elevator_guards");
	for(var_0A = 0;var_0A < var_09.size;var_0A++)
	{
		var_09[var_0A] maps\captured_util::ignore_everything();
		var_09[var_0A] maps\_utility::disable_danger_react();
		var_0B = var_0A + 1;
		if(var_0B > 3)
		{
			var_0B = var_0B + 1;
		}

		var_09[var_0A].animname = "guard_" + var_0B;
	}

	var_0C = maps\_utility::spawn_script_noteworthy("truck_to_s1elevator_general");
	var_0C.animname = "general_1";
	var_0C thread maps\captured_util::ignore_everything();
	var_0C thread maps\_utility::gun_remove();
	thread maps\captured::dialogue_s1elevator_outside(var_09,var_0C);
	var_0D = var_09[0];
	var_0E = var_09[1];
	var_0F = var_09[1];
	var_10 = var_09[3];
	var_09 = common_scripts\utility::array_remove(var_09,var_0D);
	var_09 = common_scripts\utility::array_remove(var_09,var_0F);
	common_scripts\utility::array_removeundefined(var_09);
	var_11 = maps\_utility::array_spawn_noteworthy("truck_to_s1elevator_prisoners",1);
	for(var_0A = 0;var_0A < var_11.size;var_0A++)
	{
		var_11[var_0A] maps\captured_util::ignore_everything();
		var_11[var_0A] linkto(var_03);
		var_0B = var_0A + 1;
		if(var_0B > 4)
		{
			var_0B = var_0B + 5;
		}

		var_11[var_0A].animname = "prisoner_" + var_0B;
	}

	var_12 = maps\_utility::spawn_script_noteworthy("truck_to_s1elevator_prisoner_5");
	var_12.animname = "prisoner_5";
	var_13 = maps\_utility::spawn_script_noteworthy("truck_to_s1elevator_prisoner_6");
	var_13.animname = "prisoner_6";
	var_14 = maps\_utility::spawn_script_noteworthy("truck_to_s1elevator_prisoner_7");
	var_14.animname = "prisoner_7";
	var_15 = maps\_utility::spawn_script_noteworthy("truck_to_s1elevator_prisoner_8");
	var_15.animname = "prisoner_8";
	var_15 hide();
	foreach(var_17 in var_11)
	{
		var_17 attach("s1_captured_handcuffs","tag_weapon_left");
	}

	var_19 = [var_12,var_13,var_14,var_15];
	foreach(var_17 in var_19)
	{
		var_17 attach("s1_captured_handcuffs","tag_weapon_left");
	}

	var_1C = common_scripts\utility::array_combine([var_12,var_13,var_14,var_15],var_11);
	var_1D = [var_0D,var_0F,var_10];
	var_1E = [var_12,var_14];
	var_1F = [var_0D,var_09[0]];
	var_20 = "truck_to_s1elevator_start_loop_ender";
	var_21 = "truck_to_s1elevator_start_guard_loop_ender";
	var_22 = "truck_to_s1elevator_start_loop_ambient_ender";
	foreach(var_24 in var_1E)
	{
		var_01 thread maps\_anim::anim_loop_solo(var_24,"s1_truck_start_loop",var_22);
	}

	foreach(var_24 in var_1D)
	{
		var_01 thread maps\_anim::anim_loop_solo(var_24,"s1_truck_start_loop",var_21);
	}

	var_03 thread s1_deleted_prisoners_anims(var_11);
	var_03 thread s1_truck_unload_main_allies_anims(var_06,var_01,var_02,var_15);
	var_03 thread s1_truck_unload_main_guards_anims(var_1D,var_09[0],var_0C,var_01,var_21,var_02,var_13,var_20,param_00);
	var_28 = maps\_utility::spawn_anim_model("player_rig_noexo");
	var_29 = var_28 thread maps\captured_util::captured_player_cuffs();
	var_28 linkto(var_03);
	thread player_look_limit_controller(var_28);
	thread prisoner_6_shadow_and_loop(var_13,var_03,var_01);
	level.player common_scripts\utility::delaycall(31.55,::playrumbleonentity,"light_1s");
	level.player common_scripts\utility::delaycall(48.85,::playrumbleonentity,"heavy_1s");
	level.player thread maps\_utility::blend_movespeedscale(0.075);
	level.player allowsprint(0);
	level.player allowcrouch(0);
	level.player allowprone(0);
	level.player freezecontrols(0);
	var_03 maps\_anim::anim_single_solo(var_28,"truck_to_s1elevator_unload","tag_origin");
	common_scripts\utility::flag_set("flag_introdrive_end");
	var_2A = [var_0D,var_0C,var_0F,var_10];
	var_2B = common_scripts\utility::array_combine(var_09,var_2A);
	var_01 truck_to_s1elevator_scene(var_22,var_28,var_0F,var_15,var_1C,var_2B,var_29);
}

//Function Number: 9
player_fov_controller()
{
	level.player lerpfov(52,1);
	wait(13);
	level.player lerpfov(40,5);
	level waittill("s1_drive_guards_start");
	level.player common_scripts\utility::delaycall(2,::lerpfov,65,3);
}

//Function Number: 10
player_look_limit_controller(param_00)
{
	level.player playerlinktodelta(param_00,"tag_player",1,0,0,0,0,1);
	wait(12);
	level.player playerlinktodelta(param_00,"tag_player",1,25,25,12,12,1);
	level waittill("s1_drive_guards_start");
	wait(1);
	level.player playerlinktoblend(param_00,"tag_player",3,1.5,1.5);
}

//Function Number: 11
s1_deleted_prisoners_anims(param_00)
{
	var_01 = self;
	var_01 maps\captured_anim::anim_single_to_delete(param_00,"truck_to_s1elevator_unload");
}

//Function Number: 12
prisoner_6_shadow_and_loop(param_00,param_01,param_02)
{
	param_00 linkto(param_01);
	param_01 maps\_anim::anim_single_solo(param_00,"truck_drive_player_shadow");
	param_00 unlink();
	param_02 maps\_anim::anim_loop_solo(param_00,"s1_truck_start_loop","prisoner_truck_start_loop_ender");
}

//Function Number: 13
s1_truck_unload_main_allies_anims(param_00,param_01,param_02,param_03)
{
	var_04 = self;
	var_05 = maps\_utility::spawn_script_noteworthy("introdrive_driver",1);
	var_05.animname = "driver";
	var_05 linkto(var_04,"tag_origin",(0,0,0),(0,0,0));
	var_05 maps\captured_util::ignore_everything();
	var_04 thread maps\_anim::anim_single_solo(var_05,"truck_drive");
	var_04 thread maps\_anim::anim_single(param_00,"truck_drive");
	var_06 = getanimlength(level.allies[0] maps\_utility::getanim("truck_drive")) - 2;
	wait(var_06);
	var_05 delete();
	wait(2);
	foreach(var_08 in level.allies)
	{
		var_08 unlink();
	}

	param_01 thread maps\captured_anim::anim_single_to_loop(level.allies,"truck_to_s1elevator_unload","truck_to_s1elevator_loop","truck_to_s1elevator_ally_loop_ender",param_02);
	param_02 thread maps\captured_anim::anim_single_to_loop(param_03,"truck_to_s1elevator_unload","truck_to_s1elevator_loop","loop_forever_ender");
	level.player common_scripts\utility::delaycall(9.65,::playrumbleonentity,"light_1s");
	wait(6);
	param_03 show();
	var_0A = getent("s1_intro_elevator_door","targetname");
	var_0A soundscripts\_snd::snd_message("s2_elevator_door_open_top");
	var_0A moveto(var_0A.origin + (0,0,192),4);
}

//Function Number: 14
s1_truck_unload_main_guards_anims(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = self;
	param_06 common_scripts\utility::delaycall(3.5,::hide);
	param_06 common_scripts\utility::delaycall(7,::show);
	level waittill("s1_drive_guards_start");
	param_08 maps\_utility::assign_animtree("intro_truck");
	param_08 thread maps\_anim::anim_single_solo(param_08,"introdrive_truckopen");
	param_03 notify(param_04);
	param_03 notify("prisoner_truck_start_loop_ender");
	level.player common_scripts\utility::delaycall(2,::lerpfov,65,3);
	var_09 thread introdrive_truck_throw_guard(param_00[0],getanimlength(param_00[0] maps\_utility::getanim("truck_to_s1elevator_unload")));
	param_03 thread maps\captured_anim::anim_single_to_loop(param_00[2],"truck_to_s1elevator_unload","truck_to_s1elevator_loop","truck_to_s1elevator_loop_ender");
	param_03 thread maps\captured_anim::anim_single_to_loop(param_06,"truck_to_s1elevator_unload","truck_to_s1elevator_loop","truck_to_s1elevator_loop_ender");
	var_09 maps\_anim::anim_single_solo(param_00[1],"truck_drive");
	param_03 thread maps\captured_anim::anim_single_to_loop(param_00[1],"truck_to_s1elevator_unload","truck_to_s1elevator_loop","truck_to_s1elevator_loop_ender");
	if(isdefined(param_07))
	{
		param_03 notify(param_07);
	}

	param_03 thread maps\captured_anim::anim_single_to_loop([param_01,param_02],"truck_to_s1elevator_unload","truck_to_s1elevator_loop","truck_to_s1elevator_loop_ender");
}

//Function Number: 15
introdrive_truck_throw_guard(param_00,param_01)
{
	param_00 common_scripts\utility::delaycall(param_01 - 11.85,::hide);
	param_00 common_scripts\utility::delaycall(param_01 - 11.65,::show);
	thread maps\_anim::anim_single_solo(param_00,"truck_to_s1elevator_unload");
	param_00 maps\captured_util::unignore_everything();
	param_00 thread opfor_kill_guard(getnode("t2e_node_guard_back","targetname"));
}

//Function Number: 16
truck_to_s1elevator_scene(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = self;
	var_08 = getent("origin_scene_s1elevator","targetname");
	if(!isdefined(var_08))
	{
		return;
	}

	var_09 = level.allies;
	var_0A = getent("t2e_clip_start","targetname");
	var_0B = getent("t2e_clip_end","targetname");
	var_0A maps\_utility::flagwaitthread(["flag_t2e_moveup",0.25],::func_9092);
	var_0A maps\_utility::delaythread(15,::common_scripts\utility::flag_set,"flag_t2e_moveup");
	var_0B maps\_utility::delaythread(30,::func_9092);
	level.cover_warnings_disabled = 1;
	param_01 hide();
	level.player unlink();
	param_01 unlink();
	param_06 hide();
	thread soundscripts\_snd::snd_message("aud_intro_caravan_unmute");
	level.player thread maps\_utility::blend_movespeedscale(0.4,7);
	level.player thread func_9093(var_0B);
	maps\_utility::array_spawn_function_targetname("t2e_kill_guard",::opfor_kill_guard);
	var_0C = maps\_utility::array_spawn_targetname("t2e_kill_guard",1);
	param_05 = maps\_utility::array_merge(param_05,var_0C);
	thread s1_elevator_boundary_function(var_0C);
	thread maps\captured_s2walk::spawn_player_prisoner_hands();
	maps\_utility::trigger_wait_targetname("truck_to_s1elevator_trigger");
	common_scripts\utility::flag_set("flag_entered_s1elevator");
	soundscripts\_snd::snd_message("s2_elevator_ride_down");
	soundscripts\_snd::snd_message("aud_stop_cormack_foley");
	level.player setstance("stand");
	var_0D = [param_01,param_03];
	var_08 thread maps\_anim::anim_single(var_0D,"truck_to_s1elevator_push");
	var_07 thread maps\_anim::anim_single_solo(param_02,"truck_to_s1elevator_push");
	if(level.currentgen)
	{
		thread maps\_utility::tff_sync(6);
	}

	level.player playerlinktoblend(param_01,"tag_player",0.5);
	wait(0.5);
	maps\captured_s2walk::player_hands_idle_stop(1);
	param_01 show();
	param_06 show();
	level.player playerlinktodelta(param_01,"tag_player",1,0,0,0,0,1);
	level.player common_scripts\utility::delaycall(0.3,::playrumbleonentity,"light_1s");
	level waittill("s1_elevator_player_fall");
	level.player enableslowaim(0.3,0.15);
	level.player common_scripts\utility::delaycall(3,::playerlinktodelta,param_01,"tag_player",0.5,20,30,15,15,1);
	var_07 notify("truck_to_s1elevator_ally_loop_ender");
	var_08 notify("truck_to_s1elevator_ally_loop_ender");
	var_08 thread maps\captured_anim::anim_single_to_loop(var_09,"truck_to_s1elevator_push","s2walk_wait_intro_loop_allies","s2walk_all_wait_loop_ender");
	if(isdefined(param_00))
	{
		var_07 notify(param_00);
	}

	thread elevator_ride_s1s2(param_01,param_06);
	wait(getanimlength(param_02 maps\_utility::getanim("truck_to_s1elevator_push")));
	level notify("stop_caravan_spawner");
	foreach(var_0F in param_05)
	{
		if(!isremovedentity(var_0F))
		{
			var_0F delete();
		}
	}

	foreach(var_12 in param_04)
	{
		if(!isremovedentity(var_12))
		{
			var_12 delete();
		}
	}
}

//Function Number: 17
func_9093(param_00)
{
	self endon("death");
	level endon("flag_entered_s1elevator");
	thread set_demigod_while("s1_elevator_boundary");
	self waittill("damage",var_01,var_02,var_03,var_04);
	if(!common_scripts\utility::flag("s1_elevator_boundary"))
	{
		var_02.dontmelee = 1;
		maps\_utility::set_ignoreme(1);
		while(isdefined(var_02.melee))
		{
			wait(0.05);
		}

		maps\_utility::set_ignoreme(0);
	}

	var_05 = common_scripts\utility::array_randomize(["cap_gr4_inline","cap_gr4_getinline"]);
	var_02 maps\_utility::smart_dialogue_generic(var_05[0]);
	wait(3);
	setdemigodmode(self,0);
	maps\_utility::set_ignoreme(0);
	self waittill("damage",var_01,var_02,var_03,var_04);
	var_02 thread maps\_utility::smart_dialogue_generic(var_05[1]);
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 18
func_9092()
{
	self connectpaths();
	self delete();
}

//Function Number: 19
set_demigod_while(param_00)
{
	self endon("death");
	setdemigodmode(self,1);
	while(common_scripts\utility::flag(param_00))
	{
		wait(0.05);
	}

	setdemigodmode(self,0);
}

//Function Number: 20
s1_elevator_boundary_function(param_00)
{
	self endon("death");
	level endon("flag_entered_s1elevator");
	for(;;)
	{
		common_scripts\utility::flag_waitopen("s1_elevator_boundary");
		wait(2);
		if(!common_scripts\utility::flag("s1_elevator_boundary"))
		{
			var_01 = common_scripts\utility::getclosest(level.player.origin,param_00);
			magicbullet("iw5_titan45_sp",var_01 geteye(),level.player geteye());
			level.player kill((5352,-5148,32),var_01);
		}
	}
}

//Function Number: 21
elevator_ride_s1s2(param_00,param_01)
{
	var_02 = getentarray("brush_elevator_s1s2","targetname");
	var_03 = getent("origin_scene_s1elevator","targetname");
	var_04 = getent("brush_elevator_s1s2_bottomgate","targetname");
	var_05 = level.allies;
	common_scripts\utility::array_thread(var_05,::maps\captured_util::ignore_everything);
	common_scripts\utility::array_thread(var_05,::maps\_utility::gun_remove);
	var_06 = undefined;
	var_07 = [];
	var_08 = 0;
	foreach(var_0A in var_02)
	{
		if(var_08 != 1)
		{
			if(var_0A.classname == "script_brushmodel")
			{
				var_06 = var_0A;
				var_08 = 1;
			}
			else
			{
				var_07 = common_scripts\utility::array_add(var_07,var_0A);
			}

			continue;
		}

		var_07 = common_scripts\utility::array_add(var_07,var_0A);
	}

	var_07 = common_scripts\utility::array_add(var_07,var_03);
	var_07 = common_scripts\utility::array_add(var_07,var_04);
	var_07 = common_scripts\utility::array_combine(var_07,var_05);
	param_00 linkto(var_06);
	foreach(var_0D in var_07)
	{
		var_0D linkto(var_06);
	}

	common_scripts\utility::flag_set("flag_start_s1elevator");
	var_0F = spawn("script_model",(5520,-5705,75));
	var_0F setmodel("tag_origin");
	playfxontag(level._effect["cap_intro_elevator_light_soft"],var_0F,"tag_origin");
	var_0F linkto(var_06);
	wait(5.8);
	if(level.currentgen)
	{
		if(!istransientloaded("captured_s2walk_tr"))
		{
			level waittill("tff_post_intro_drive_to_s2walk");
		}
	}

	level notify("stop_elevator_push");
	level notify("start_elevator_sounds");
	thread scene_enemy_walk_setup_loops(param_00,param_01);
	var_06 moveto(var_06.origin - (0,0,593),18.5);
	wait(14);
	common_scripts\utility::flag_set("flag_s1elevator_end");
	wait(4.5);
	var_04 unlink();
	level notify("stop_elevator_sounds");
}

//Function Number: 22
elevator_push()
{
	level endon("stop_elevator_push");
	var_00 = anglestoforward(common_scripts\utility::getstruct("struct_playerstart_s1elevator","targetname").angles) * 16;
	for(;;)
	{
		common_scripts\utility::flag_wait("flag_s1elevator_push");
		player_push_impulse(var_00,1);
	}
}

//Function Number: 23
player_push_impulse(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0.05;
	}

	var_02 = param_01;
	while(var_02 > 0)
	{
		var_03 = clamp(var_02 / param_01,0,1);
		var_04 = param_00 * var_03;
		level.player pushplayervector(var_04);
		var_02 = var_02 - 0.05;
		wait(0.05);
	}

	level.player pushplayervector((0,0,0));
}

//Function Number: 24
scene_s1_in_elevator()
{
	common_scripts\utility::flag_wait("flag_start_s1elevator");
}

//Function Number: 25
scene_enemy_walk_setup_loops(param_00,param_01)
{
	var_02 = common_scripts\utility::getstruct("struct_scene_s2walkstart","targetname");
	if(!isdefined(var_02))
	{
		return;
	}

	var_03 = maps\_utility::array_spawn_noteworthy("actor_s2wintro_guards");
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_03[var_04] maps\captured_util::ignore_everything();
		var_05 = var_04 + 1;
		var_03[var_04].animname = "guard_" + var_05;
		if(var_05 == 3)
		{
			var_03[var_04] maps\_utility::gun_remove();
		}
	}

	var_02 thread maps\_anim::anim_loop(var_03,"s2walk_guard_intro_loop","s2walk_guard_intro_loop_ender");
	level waittill("s1elevator_end");
	var_02 notify("s2walk_guard_intro_loop_ender");
	thread maps\captured_s2walk::scene_intro_walk(var_03,param_00,param_01);
}

//Function Number: 26
nt_s1_elevator_push_fall(param_00)
{
	level notify("s1_elevator_player_fall");
}

//Function Number: 27
nt_s1_truck_dismount_guards(param_00)
{
	level notify("s1_drive_guards_start");
	thread soundscripts\_snd::snd_message("aud_intro_to_elev_walla");
}

//Function Number: 28
nt_s1_elevator_end(param_00)
{
	level notify("s1elevator_end");
}

//Function Number: 29
opfor_kill_guard(param_00)
{
	self endon("death");
	self.newenemyreactiondistsq = 0;
	maps\_utility::flagwaitthread("flag_entered_s1elevator",::maps\_utility::set_ignoreall,1);
	if(isdefined(param_00))
	{
		self.script_forcegoal = 1;
		thread maps\_utility::follow_path(param_00);
	}
	else if(isdefined(self.target))
	{
		param_00 = getnode(self.target,"targetname");
	}

	if(isdefined(param_00) && isdefined(param_00.script_flag_wait) && isdefined(param_00.target))
	{
		var_01 = getnode(param_00.target,"targetname");
		var_02 = 0;
		if(isdefined(param_00.script_wait) && param_00.script_wait > 0.05)
		{
			var_02 = param_00.script_wait - 0.05;
		}

		maps\_utility::flagwaitthread([param_00.script_flag_wait,var_02],::maps\_utility::follow_path,var_01);
	}

	self.a.nextmeleechargesound = gettime() + 320000;
	maps\_utility::set_favoriteenemy(level.player);
	maps\_utility::enable_dontevershoot();
	maps\_utility::magic_bullet_shield(1);
	common_scripts\utility::flag_wait("s1_elevator_boundary");
	common_scripts\utility::flag_waitopen("s1_elevator_boundary");
	maps\_utility::disable_dontevershoot();
	level.player waittill("death");
	maps\_utility::enable_dontevershoot();
}