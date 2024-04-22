/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: captured_s3.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 42
 * Decompile Time: 608 ms
 * Timestamp: 4/22/2024 2:26:34 AM
*******************************************************************/

//Function Number: 1
pre_load()
{
}

//Function Number: 2
post_load()
{
	common_scripts\utility::flag_init("s3_escape_exit_door_open");
	common_scripts\utility::flag_init("flag_scene_doctor_done");
	common_scripts\utility::flag_init("flag_injured_player_active");
	common_scripts\utility::flag_init("flag_s3escape_doctor");
	common_scripts\utility::flag_init("flag_s3guard_security_door_shuts");
	common_scripts\utility::flag_init("s3_player_pickedup_console_gun");
	common_scripts\utility::flag_init("s3_interrogation_player_ready");
	common_scripts\utility::flag_init("s3_interrogation_allies_ready");
	common_scripts\utility::flag_init("lgt_flag_interrogation_esc");
	common_scripts\utility::flag_init("lgt_flag_interrogation_begin");
	common_scripts\utility::flag_init("lgt_flag_interrogation_esc_done");
	if(isdefined(common_scripts\utility::getstruct("struct_interrogation_scene","targetname")))
	{
		thread setup_spawners();
	}
}

//Function Number: 3
setup_spawners()
{
	maps\_utility::array_spawn_function(getentarray("actor_s3_interrogation","targetname"),::opfor_interrogation);
	maps\_utility::array_spawn_function(getentarray("s3_escape_main_room_guards","targetname"),::maps\captured_medical::opfor_ah);
	maps\_utility::array_spawn_function(getentarray("s3escape_hall_enemies","targetname"),::maps\captured_medical::opfor_ah);
}

//Function Number: 4
opfor_interrogation()
{
	self endon("death");
	self.no_pain_sound = 1;
	self.allowpain = 0;
	self.diequietly = 1;
	self.nocorpsedelete = 1;
	self.noragdoll = 1;
	if(isdefined(self.script_parameters))
	{
		self.animname = self.script_parameters;
	}

	maps\_utility::gun_remove();
	if(!isdefined(self.script_parameters) || self.script_parameters != "irons")
	{
		maps\_utility::place_weapon_on("iw5_titan45onearmgundown_sp","right");
	}

	maps\captured_util::ignore_everything();
	self.allowdeath = 1;
}

//Function Number: 5
start(param_00)
{
	level.player disableweapons();
	level.player disableoffhandweapons();
	level.player disableweaponswitch();
	thread maps\_utility::battlechatter_off("allies");
	thread maps\_utility::battlechatter_off("axis");
	level.player maps\captured_util::warp_to_start(param_00);
	if(issubstr(level.start_point,"s3trolley"))
	{
		setsaveddvar("g_friendlyNameDist",0);
		iprintln("The trolley start point has been removed");
		return;
	}

	if(issubstr(level.start_point,"s3interrogate"))
	{
		setsaveddvar("g_friendlyNameDist",0);
		return;
	}

	if(issubstr(level.start_point,"escape"))
	{
		common_scripts\utility::flag_set("s3_interrogation_allies_ready");
		level.player.mover = common_scripts\utility::spawn_tag_origin();
		getent("glass_interrogation_before","targetname") delete();
		common_scripts\utility::flag_set("flag_injured_player_active");
		level.player thread injured_player_blur();
		return;
	}
}

//Function Number: 6
main_s3trolley()
{
}

//Function Number: 7
main_s3interrogate()
{
	if(level.currentgen)
	{
		if(!istransientloaded("captured_interrogate_tr"))
		{
			level waittill("tff_post_s2walk_to_interrogate");
		}
	}

	level thread s3_interrogate_doctor_scene();
	var_00 = common_scripts\utility::getstruct("struct_interrogation_scene","targetname");
	var_01 = maps\_utility::array_spawn(getentarray("actor_s3_interrogation","targetname"));
	var_02 = common_scripts\utility::array_combine(var_01,level.allies);
	var_03 = maps\_utility::spawn_anim_model("torque_wrench");
	var_04 = [maps\_utility::spawn_anim_model("stockade_01"),maps\_utility::spawn_anim_model("stockade_02")];
	var_00 maps\_anim::anim_first_frame(common_scripts\utility::add_to_array(var_04,var_03),"s3_interrogation");
	level.breakout_glass = [maps\_utility::spawn_anim_model("breakout_window_1"),maps\_utility::spawn_anim_model("breakout_window_2")];
	common_scripts\utility::getstruct("struct_interrogation_glass","targetname") thread maps\_anim::anim_first_frame(level.breakout_glass,"s3_breakout_break");
	common_scripts\utility::array_call(level.breakout_glass,::hide);
	var_05 = spawn("script_model",(5000,-9928,-1748));
	var_05 setmodel("tag_origin");
	foreach(var_07 in level.breakout_glass)
	{
		var_07 common_scripts\utility::delaycall(0.5,::retargetscriptmodellighting,var_05);
		var_07 common_scripts\utility::delaycall(0.5,::overridereflectionprobe,var_05.origin);
	}

	foreach(var_0A in level.allies)
	{
		var_0A maps\_utility::gun_remove();
		if(var_0A.animname != "ally_2" && !isdefined(var_0A.hasattachedprops))
		{
			var_0A attach("s1_captured_handcuffs","tag_weapon_left");
			var_0A.hasattachedprops = 1;
			continue;
		}

		if(var_0A.animname == "ally_2" && isdefined(var_0A.hasattachedprops))
		{
			var_0A detach("s1_captured_handcuffs","tag_weapon_left");
			var_0A.hasattachedprops = undefined;
		}
	}

	if(level.currentgen)
	{
		level.player lerpfov(60,0);
	}
	else
	{
		level.player lerpfov(50,0);
	}

	level.player unlink();
	level.player takeallweapons();
	level.player allowmelee(0);
	level.player allowstand(1);
	level.player allowcrouch(0);
	level.player allowprone(0);
	level.player allowsprint(0);
	level.player allowjump(0);
	var_0C = [maps\_utility::spawn_anim_model("player_rig_noexo"),maps\_utility::spawn_anim_model("player_rig_smashed_noexo")];
	var_0C[0].toggle = var_0C[1];
	var_0C[1].toggle = var_0C[0];
	var_00 maps\_anim::anim_first_frame(var_0C,"s3_interrogation");
	var_0C[1] hide();
	wait(0.05);
	level.player maps\captured_util::smooth_player_link(var_0C[0],0.05);
	soundscripts\_snd::snd_message("aud_interrogation_scene");
	common_scripts\utility::flag_set("lgt_flag_interrogation_begin");
	setsaveddvar("r_adaptiveSubdiv",0);
	var_0D = getanimlength(var_0C[0] maps\_utility::getanim("s3_interrogation"));
	var_00 thread maps\_anim::anim_single(var_02,"s3_interrogation");
	var_00 thread maps\_anim::anim_single(var_04,"s3_interrogation");
	var_00 thread maps\_anim::anim_single([var_0C[0],var_0C[1],var_03],"s3_interrogation");
	var_0E = common_scripts\utility::spawn_tag_origin();
	foreach(var_10 in getentarray("model_s3interrogation_doorin","targetname"))
	{
		var_10 linkto(var_0E);
	}

	wait(10);
	var_0E moveto(var_0E.origin - (0,90,0),2,2,0);
	level.player common_scripts\utility::delaycall(114.3,::playrumbleonentity,"heavy_2s");
	level.player common_scripts\utility::delaycall(118.1,::playrumbleonentity,"heavy_2s");
	wait(var_0D - 20);
	var_12 = maps\_hud_util::create_client_overlay("black",0,level.player);
	var_12 thread s3_fade_over_time(1,10);
	wait(6);
	var_0E moveto(var_0E.origin + (0,90,0),2,2,0);
	wait(4);
	maps\_utility::array_delete(var_01);
	var_01 = maps\_utility::array_spawn(getentarray("actor_s3_breakout","script_noteworthy"));
	common_scripts\_exploder::exploder("fx_rescue_guard_2_blood_pool");
	soundscripts\_snd::snd_message("aud_rescue_drone");
	level.player lerpfov(55,0);
	wait(3);
	soundscripts\_snd::snd_message("aud_cap_interrogation_transition_vo");
	wait(6);
	common_scripts\utility::flag_set("flag_injured_player_active");
	level.player thread injured_player_blur();
	var_12 maps\_utility::delaythread(0.25,::s3_fade_over_time,0,3);
	maps\_utility::delaythread(getanimlength(level.ally maps\_utility::getanim("s3_breakout")),::common_scripts\utility::flag_set,"s3_interrogation_allies_ready");
	level.player common_scripts\utility::delaycall(23.5,::lerpfov,65,4);
	maps\_utility::delaythread(24.75,::breakout_opfor_cleanup,var_00,var_01,var_04,var_03);
	level.player common_scripts\utility::delaycall(24,::playerlinktodelta,var_0C[1],"tag_player",0.5,20,30,15,15,1);
	level.player common_scripts\utility::delaycall(24,::enableslowaim,0.3,0.15);
	var_00 thread maps\captured_anim::anim_single_to_loop([level.allies[1],level.allies[2]],"s3_breakout","s3_breakout_loop","leave_interrogation_room_allies");
	var_00 thread maps\captured_anim::anim_single_to_loop(level.ally,"s3_breakout","s3_breakout_loop","leave_interrogation_room");
	var_00 thread maps\_anim::anim_single(var_01,"s3_breakout");
	var_00 thread maps\_anim::anim_single(var_04,"s3_breakout");
	var_00 maps\_anim::anim_single(var_0C,"s3_breakout");
	setsaveddvar("r_adaptiveSubdiv",1);
	foreach(var_0A in level.allies)
	{
		if(isdefined(var_0A.hasattachedprops))
		{
			var_0A detach("s1_captured_handcuffs","tag_weapon_left");
			var_0A.hasattachedprops = undefined;
		}
	}

	maps\_utility::flagwaitthread("s3_interrogation_player_ready",::maps\_utility::autosave_now);
	setsaveddvar("g_friendlyNameDist",level.friendlynamedist);
	level.player allowmelee(1);
	level.player allowstand(1);
	level.player allowcrouch(1);
	level.player allowprone(1);
	level.player allowjump(1);
	level.player disableslowaim();
	level.player unlink();
	common_scripts\utility::array_call(var_0C,::delete);
	common_scripts\utility::flag_set("flag_s3interrogate_end");
}

//Function Number: 8
s3_toggle_rig(param_00)
{
	param_00 show();
	param_00.toggle hide();
}

//Function Number: 9
s3_interrogate_doctor_scene()
{
	if(level.currentgen)
	{
		return;
	}

	var_00 = maps\_utility::spawn_targetname("actor_interrogation_doctor");
	var_00.animname = "doctor";
	var_00 maps\_utility::gun_remove();
	var_00 maps\captured_util::ignore_everything();
	var_01 = common_scripts\utility::getstruct("s3_interrogate_hanging_body","targetname");
	var_02 = spawn("script_model",var_01.origin);
	var_02.angles = var_01.angles;
	var_02 setmodel("cap_morgue_body_c");
	var_03 = common_scripts\utility::getstruct("anim_interrogation_doctor","targetname");
	var_03 thread maps\_anim::anim_loop([var_00],"autopsy_doctor_loop_start","stop_interrogate_doctor");
	common_scripts\utility::flag_wait("s3_escape_exit_door_open");
	var_03 notify("stop_interrogate_doctor");
	var_00 delete();
	var_02 delete();
}

//Function Number: 10
s3_fade_over_time(param_00,param_01)
{
	self fadeovertime(param_01);
	self.alpha = param_00;
}

//Function Number: 11
s3_break_glass(param_00)
{
	common_scripts\utility::array_call(level.breakout_glass,::show);
	common_scripts\utility::getstruct("struct_interrogation_glass","targetname") thread maps\_anim::anim_single(level.breakout_glass,"s3_breakout_break");
	common_scripts\_exploder::exploder("fx_int_glass_shatter");
	common_scripts\_exploder::kill_exploder("fx_int_guard_fire_3");
	common_scripts\_exploder::kill_exploder("fx_int_guard_fire_4");
	common_scripts\_exploder::kill_exploder("fx_int_guard_fire_5");
	getent("glass_interrogation_before","targetname") delete();
	common_scripts\utility::flag_wait("s3_escape_exit_door_open");
	common_scripts\utility::array_call(level.breakout_glass,::delete);
}

//Function Number: 12
breakout_opfor_cleanup(param_00,param_01,param_02,param_03)
{
	foreach(var_05 in param_01)
	{
		var_05 setanimrate(var_05 maps\_utility::getanim("s3_breakout"),0);
		var_05 maps\captured_util::kill_no_react();
	}

	common_scripts\utility::flag_wait("s3_escape_exit_door_open");
	common_scripts\utility::array_call(param_02,::delete);
	param_03 delete();
	foreach(var_08 in level.allies)
	{
		if(isdefined(var_08.cuff))
		{
			var_08.cuff delete();
		}
	}
}

//Function Number: 13
main_s3escape()
{
	level.player thread injured_player_wobble();
	common_scripts\utility::array_thread(level.allies,::maps\_utility::enable_cqbwalk);
	thread maps\captured_util::physics_bodies_on("escape_bodies_1",0,1);
	thread slow_player_scaler();
	var_00 = common_scripts\utility::getstruct("struct_scene_s3escape_takedown","targetname");
	var_01 = maps\_utility::spawn_anim_model("takedown_monitor");
	var_00 maps\_anim::anim_first_frame_solo(var_01,"s3escape_takedown");
	thread s3_escape_outer_door();
	var_02 = getent("s3_escape_large_security_door","targetname");
	var_02 moveto(var_02.origin + (0,0,112),1,0.2,0.05);
	var_03 = getentarray("s3_escape_elevator","targetname");
	var_04 = undefined;
	foreach(var_06 in var_03)
	{
		if(var_06.classname == "script_brushmodel")
		{
			var_04 = var_06;
		}
	}

	foreach(var_06 in var_03)
	{
		if(var_06.classname == "script_model")
		{
			var_06 linkto(var_04);
		}
	}

	var_04 moveto(var_04.origin + (0,0,150),1.5,0.2,0.05);
	common_scripts\utility::flag_wait_all("s3_interrogation_player_ready","s3_interrogation_allies_ready");
	var_0A = common_scripts\utility::getstruct("struct_scene_s3escape_hallway","targetname");
	while(!common_scripts\utility::within_fov(level.player.origin,level.player.angles,var_0A.origin,0.8))
	{
		wait(0.05);
	}

	level notify("leave_interrogation_room");
	thread s3escape_intro_scene(var_0A);
	common_scripts\utility::flag_wait("flag_s3escape_hall");
	thread s3escape_doctor_scene();
	common_scripts\utility::flag_wait("flag_scene_doctor_done");
	common_scripts\utility::flag_waitopen("flag_s3escape_hall");
	var_0A notify("s3escape_hallway_gideon_ender");
	common_scripts\utility::flag_set("flag_injured_player_active");
	var_0A = s3_enter_security_room(var_0A,var_01);
	s3_splitup_event(var_0A);
	common_scripts\utility::flag_wait("flag_s3escape_end");
}

//Function Number: 14
s3escape_console_setup()
{
	setsaveddvar("cg_cinematicfullscreen","0");
	cinematicingame("captured_elevator_controls",0,1,1);
	if(!iscinematicplaying())
	{
		wait(0.1);
	}

	wait(1);
	pausecinematicingame(1);
	var_00 = getscriptablearray("s3_escape_console_monitor","targetname");
	level.s3_escape_console_monitor = var_00[0];
	if(!common_scripts\utility::flag_exist("s3_escape_console_monitor_unfreeze"))
	{
		common_scripts\utility::flag_init("s3_escape_console_monitor_unfreeze");
	}

	while(!common_scripts\utility::flag("s3_escape_console_monitor_unfreeze"))
	{
		level.s3_escape_console_monitor setscriptablepartstate(0,0);
		wait(0.2);
		if(!common_scripts\utility::flag("s3_escape_console_monitor_unfreeze"))
		{
			level.s3_escape_console_monitor setscriptablepartstate(0,1);
			wait(0.2);
		}
	}
}

//Function Number: 15
s3escape_console_pause_checkpoint()
{
	if(!iscinematicplaying())
	{
		wait(0.05);
	}

	wait(0.6);
	pausecinematicingame(1);
}

//Function Number: 16
s3escape_console_cinematic_watcher()
{
	wait(1);
	pausecinematicingame(0);
	while(cinematicgettimeinmsec() < 10270)
	{
		wait 0.05;
	}

	wait(1);
	level.s3_escape_console_monitor setscriptablepartstate(0,3);
}

//Function Number: 17
s3escape_intro_scene(param_00)
{
	if(level.currentgen)
	{
		if(!istransientloaded("captured_escape_tr"))
		{
			level waittill("tff_post_load_escape");
		}
	}

	var_01 = common_scripts\utility::getstruct("struct_interrogation_scene","targetname");
	var_01 notify("leave_interrogation_room");
	var_02 = common_scripts\utility::spawn_tag_origin();
	foreach(var_04 in getentarray("model_s3escape_doorout","targetname"))
	{
		var_04 linkto(var_02);
	}

	if(level.currentgen)
	{
		var_06 = getent("model_s3escape_doorout_coll","targetname");
		var_06 linkto(var_02);
		var_06 connectpaths();
	}

	var_02 moveto(var_02.origin + (0,90,0),2,2,0);
	soundscripts\_snd::snd_message("aud_door","rescue");
	var_07 = level.allies;
	foreach(var_09 in var_07)
	{
		var_09 maps\captured_util::ignore_everything();
		var_09 maps\_utility::gun_remove();
	}

	param_00 thread maps\captured_anim::anim_single_to_loop(var_07[0],"s3escape_hallway","s3escape_hallway_loop","s3escape_hallway_gideon_ender");
	common_scripts\utility::flag_wait("flag_s3escape_hall");
	common_scripts\utility::flag_waitopen("flag_s3escape_hall");
	var_01 notify("leave_interrogation_room_allies");
	param_00 thread maps\captured_anim::anim_single_to_loop(var_07[1],"s3escape_hallway","s3escape_hallway_loop","s3escape_hallway_ender");
	param_00 thread maps\captured_anim::anim_single_to_loop(var_07[2],"s3escape_hallway","s3escape_hallway_loop","s3escape_hallway_ender");
	if(level.currentgen)
	{
		wait(3);
		common_scripts\utility::flag_wait("flag_tff_allow_interrogate_unload");
		var_06 = getent("model_s3escape_doorout_coll","targetname");
		var_06 disconnectpaths();
		var_02 moveto(var_02.origin - (0,90,0),0.25,0.25,0);
		wait(1);
		common_scripts\utility::flag_set("flag_tff_unload_interrogate");
	}
}

//Function Number: 18
s3escape_doctor_scene()
{
	level endon("s3escape_player_killed_doctor");
	var_00 = common_scripts\utility::getstruct("s3_escape_doctor_scene","targetname");
	var_01 = maps\_utility::spawn_targetname("s3secape_doctor",1);
	var_01 maps\captured_util::ignore_everything();
	var_01.animname = "doctor";
	var_02 = spawn("script_model",var_00.origin);
	var_02 setmodel("cap_hanging_bodybag");
	var_02.animname = "escape_bodybag";
	var_02 maps\_anim::setanimtree();
	var_03 = spawn("script_model",var_02.origin);
	var_03 setmodel("trolley_block");
	var_03 linkto(var_02,"tag_origin",(0,0,6),(0,0,0));
	var_04 = spawn("script_model",var_00.origin);
	var_04 setmodel("det_patient_chart_01");
	var_04.animname = "escape_clipboard";
	var_04 maps\_anim::setanimtree();
	var_05 = [var_01,var_02,var_04];
	var_06 = common_scripts\utility::spawn_tag_origin();
	foreach(var_08 in getentarray("model_s3escape_docdoor","targetname"))
	{
		var_08 linkto(var_06);
	}

	common_scripts\utility::flag_clear("flag_injured_player_active");
	common_scripts\utility::flag_set("lgt_flag_interrogation_esc");
	soundscripts\_snd::snd_message("aud_escape_doctor_bodybag");
	var_06 common_scripts\utility::delaycall(7.5,::moveto,var_06.origin,1.5,1.5,0);
	var_06 moveto(var_06.origin + (0,90,0),1.5,1.5,0);
	maps\_utility::delaythread(7.5,::common_scripts\utility::flag_set,"flag_scene_doctor_done");
	var_00 maps\_anim::anim_single(var_05,"s3escape_doctor_scene");
	var_05 = maps\_utility::remove_dead_from_array(var_05);
	common_scripts\utility::array_call(var_05,::delete);
	common_scripts\utility::flag_set("lgt_flag_interrogation_esc_done");
}

//Function Number: 19
s3_escape_deathwatcher(param_00)
{
	self waittill("damage");
	param_00 stopanimscripted();
	param_00 delete();
	if(isalive(self))
	{
		self stopanimscripted();
		self kill();
	}

	common_scripts\utility::flag_set("flag_scene_doctor_done");
}

//Function Number: 20
s3escape_doctor_kill(param_00)
{
	level waittill("s3escape_player_killed_doctor");
	iprintlnbold("[ Player kills the doctor. ]");
	param_00 delete();
}

//Function Number: 21
s3escape_doctor_killbox_prompt()
{
	level endon("s3escape_doctor_survived");
	common_scripts\utility::flag_wait("s3escape_doctor_killbox");
	for(;;)
	{
		if(common_scripts\utility::flag("s3escape_doctor_killbox"))
		{
			if(level.player meleebuttonpressed())
			{
				level notify("s3escape_player_killed_doctor");
				break;
			}
		}

		wait(0.05);
	}
}

//Function Number: 22
s3_enter_security_room(param_00,param_01)
{
	var_02 = level.allies;
	var_03 = common_scripts\utility::getstruct("struct_scene_s3escape_hallway","targetname");
	var_04 = common_scripts\utility::getstruct("struct_scene_s3escape_takedown","targetname");
	var_05 = maps\_utility::spawn_anim_model("controlroom_entrance_door");
	var_06 = getent("s3_escape_controlroom_entrance_col","targetname");
	var_04 maps\_anim::anim_first_frame_solo(var_05,"s3escape_takedown");
	var_04 thread s3_escape_sliding_door_player(var_05,var_06,"s3escape_takedown");
	var_07 = maps\_utility::spawn_anim_model("takedown_gun_gideon");
	var_04 maps\_anim::anim_first_frame_solo(var_07,"s3escape_takedown");
	var_08 = getent("s3escape_guard_1","targetname");
	var_09 = maps\_utility::dronespawn_bodyonly(var_08);
	var_09.animname = "guard_1";
	var_09 maps\captured_util::ignore_everything();
	var_09.diequietly = 1;
	var_09 maps\_utility::clear_deathanim();
	var_09.noragdoll = 1;
	var_09 maps\_utility::gun_remove();
	var_09.no_ai = 1;
	var_09.allowpain = 0;
	var_09.skipdeathanim = 1;
	var_09.dont_break_anim = 1;
	var_0A = spawn("script_model",var_04.origin);
	var_0A setmodel("cap_lab_chair");
	var_0A.animname = "takedown_chair";
	var_0A maps\_anim::setanimtree();
	var_0B = [var_09,var_0A,param_01];
	var_04 thread maps\_anim::anim_loop(var_0B,"s3escape_hallway_end_loop","s3escape_hallway_door_ender");
	var_03 thread maps\captured_anim::anim_single_to_loop(var_02[0],"s3escape_hallway_end","s3escape_hallway_end_loop","s3escape_hallway_door_gideon_ender",var_04);
	wait(getanimlength(%cap_s3_escape_hallway_cormack_01_end));
	common_scripts\utility::flag_wait("flag_s3_escape_at_security_room");
	param_00 notify("s3escape_hallway_ender");
	var_03 thread maps\captured_anim::anim_single_to_loop(var_02[1],"s3escape_hallway_end","s3escape_hallway_end_loop","s3escape_hallway_door_ender",var_04);
	var_03 thread maps\captured_anim::anim_single_to_loop(var_02[2],"s3escape_hallway_end","s3escape_hallway_end_loop","s3escape_hallway_door_ender",var_04);
	var_04 notify("s3escape_hallway_door_gideon_ender");
	soundscripts\_snd::snd_message("aud_stop_headspace_ambience");
	thread maps\captured::dialogue_guardroom_door(var_09);
	var_04 thread maps\captured_anim::anim_single_to_loop(level.allies[0],"s3escape_takedown","s3escape_takedown_loop","s3escape_takedown_gideon_ender");
	var_04 thread s3escape_gideon_gun_anim(var_07);
	var_04 thread maps\_anim::anim_single(var_0B,"s3escape_takedown");
	wait(getanimlength(%cap_s3_escape_takedown_guard_01) - 0.05);
	var_09 setanimrate(%cap_s3_escape_takedown_guard_01,0);
	level notify("s3_escape_guard_down");
	var_04 notify("s3escape_hallway_door_ender");
	var_04 thread maps\captured_anim::anim_single_to_loop(level.allies[1],"s3escape_takedown","s3escape_takedown_loop","s3escape_takedown_ender");
	var_04 thread maps\captured_anim::anim_single_to_loop(level.allies[2],"s3escape_takedown","s3escape_takedown_loop","s3escape_takedown_ender");
	var_0C = maps\_utility::spawn_anim_model("takedown_gun");
	var_0C hidepart("tag_rail_master_on");
	var_04 maps\_anim::anim_first_frame_solo(var_0C,"s3escape_takedown");
	var_0C hide();
	var_0D = common_scripts\utility::getstruct("s3_escape_get_weapon_marker","targetname");
	var_0E = spawn("script_origin",var_0D.origin);
	var_0E makeusable();
	var_0E maps\_utility::addhinttrigger(&"CAPTURED_HINT_TAKE_CONSOLE",&"CAPTURED_HINT_TAKE_PC");
	maps\captured_actions::s3_escape_gun_action(var_0E,var_0C);
	level.player soundscripts\_snd::snd_message("aud_escape_give_gun_exo");
	var_0E delete();
	level.player disableweapons();
	var_0F = maps\_utility::spawn_anim_model("player_rig_noexo");
	var_0F hide();
	var_10 = [var_0F,var_09];
	setsaveddvar("g_friendlyNameDist",0);
	level.player setstance("stand");
	level.player allowcrouch(0);
	level.player allowjump(0);
	level.player allowprone(0);
	var_11 = getanimlength(var_0F maps\_utility::getanim("s3escape_takedown_start"));
	thread s3escape_fade_to_black(var_11);
	var_04 thread s3_escape_player_exo_and_gun_anim(var_10,var_09,var_0F,var_0C,var_11);
	level waittill("s3_escape_player_got_gun");
	var_04 s3_escape_ally_gun_help_anim(var_07);
	return var_04;
}

//Function Number: 23
s3_escape_outer_door()
{
	var_00 = common_scripts\utility::getstruct("struct_scene_s3escape_takedown","targetname");
	var_01 = spawn("script_model",var_00.origin);
	var_01 setmodel("cpt_hinge_door_rght_01");
	var_02 = getent("s3_escape_security_door_col","targetname");
	var_02 linkto(var_01,"j_bone_door_right",(28,1.5,48),(0,0,0));
	var_01.animname = "takedown_door";
	var_01 maps\_anim::setanimtree();
	var_00 maps\_anim::anim_first_frame_solo(var_01,"s3escape_takedown");
	level waittill("s3_outer_door_open");
	var_01 thread soundscripts\_snd::snd_message("aud_escape_guard_takedown_door");
	var_00 maps\_anim::anim_single_solo(var_01,"s3escape_takedown");
}

//Function Number: 24
s3escape_gideon_gun_anim(param_00)
{
	maps\_anim::anim_single_solo(param_00,"s3escape_takedown");
	if(!isremovedentity(param_00))
	{
		param_00 hide();
	}

	level.allies[0] maps\_utility::gun_recall();
	level.allies[0] showallparts();
}

//Function Number: 25
s3_escape_sliding_door_player(param_00,param_01,param_02,param_03)
{
	var_04 = self;
	param_01 linkto(param_00);
	var_04 waittill("s3_escape_open_door");
	if(param_02 == "s3escape_takedown")
	{
		soundscripts\_snd::snd_message("aud_door","control_rm","open");
	}
	else
	{
		soundscripts\_snd::snd_message("aud_door","control_rm_exit","open");
	}

	var_04 maps\_anim::anim_single_solo(param_00,param_02);
	var_04 waittill("s3_close_sliding_door");
	soundscripts\_snd::snd_message("aud_door","control_rm","close");
	if(isdefined(param_03))
	{
		param_00 moveto(param_00.origin + (0,53,0),1,0.25,0.25);
	}
	else
	{
		param_00 moveto(param_00.origin - (0,53,0),1,0.25,0.25);
	}

	common_scripts\utility::flag_wait("flag_test_chamber_end");
	param_00 delete();
	param_01 delete();
}

//Function Number: 26
s3_escape_door_notetrack(param_00)
{
	level notify("s3_outer_door_open");
}

//Function Number: 27
s3_escape_player_gun(param_00)
{
	level notify("s3_escape_player_got_gun");
	soundscripts\_snd::snd_music_message("mus_captured_escape");
}

//Function Number: 28
s3_escape_controlroom_door_notetrack(param_00)
{
	soundscripts\_snd::snd_message("aud_escape_keycard","control_room");
	var_01 = common_scripts\utility::getstruct("struct_scene_s3escape_takedown","targetname");
	var_01 notify("s3_escape_open_door");
}

//Function Number: 29
s3_escape_player_exo_and_gun_anim(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = self;
	var_05 thread maps\_anim::anim_single(param_00,"s3escape_takedown_start");
	level.player playerlinktoblend(param_02,"tag_player",0.5);
	wait(0.5);
	param_02 show();
	level.player playerlinktodelta(param_02,"tag_player",0.75,45,45,30,30,1);
	level.player common_scripts\utility::delaycall(3.5,::playrumbleonentity,"light_2s");
	level.player common_scripts\utility::delaycall(4.25,::lerpfov,42,1);
	level.player common_scripts\utility::delaycall(6,::lerpfov,65,3);
	wait(param_04 - 0.5);
	param_02 delete();
	param_02 = maps\_utility::spawn_anim_model("player_rig");
	level.player playerlinktodelta(param_02,"tag_player",1,0,0,0,0,1);
	param_01 delete();
	var_06 = getent("s3escape_noexo_guard","targetname");
	param_01 = maps\_utility::dronespawn_bodyonly(var_06);
	param_01.animname = "guard_1";
	param_01 maps\captured_util::ignore_everything();
	param_01.diequietly = 1;
	param_01 maps\_utility::clear_deathanim();
	param_01.noragdoll = 1;
	param_01 maps\_utility::gun_remove();
	param_01.no_ai = 1;
	param_01.allowpain = 0;
	param_01.skipdeathanim = 1;
	param_01.dont_break_anim = 1;
	var_05 thread maps\_anim::anim_last_frame_solo(param_01,"s3escape_takedown_start");
	var_07 = [param_03,param_02];
	param_03 show();
	var_05 thread maps\_anim::anim_single(var_07,"s3escape_takedown");
	var_08 = getanimlength(param_02 maps\_utility::getanim("s3escape_takedown"));
	var_05 notify("s3escape_takedown_gideon_ender");
	wait(var_08);
	maps\_player_exo::player_exo_activate();
	level notify("s3_escape_player_helped");
	level.player unlink();
	param_02 delete();
	param_03 delete();
	level.player takeallweapons();
	level.player enableweapons();
	level.player giveweapon("iw5_titan45onearmgundown_sp");
	level.player setweaponammostock("iw5_titan45onearmgundown_sp",0);
	level.player switchtoweapon("iw5_titan45onearmgundown_sp");
	level.player allowmelee(0);
	level.player allowfire(0);
	level.player allowcrouch(1);
	level.player allowjump(1);
	level.player allowprone(1);
	common_scripts\utility::flag_wait("escape_guards_dead");
	param_01 delete();
}

//Function Number: 30
s3_escape_ally_gun_help_anim(param_00)
{
	var_01 = self;
	param_00 show();
	level.allies[0] maps\_utility::gun_remove();
	var_02 = [level.allies[0],param_00];
	var_03 = getanimlength(level.allies[0] maps\_utility::getanim("s3escape_takedown_gun_help"));
	var_01 maps\_anim::anim_single(var_02,"s3escape_takedown_gun_help");
	param_00 delete();
	level.allies[0] maps\_utility::gun_recall();
	level.allies[0] showallparts();
}

//Function Number: 31
s3_splitup_event(param_00)
{
	var_01 = common_scripts\utility::getstruct("struct_scene_s3escape_security","targetname");
	var_02 = level.allies;
	var_03 = getent("s3_escape_pickup_gun","targetname");
	var_03 hide();
	var_04 = getent("s3_escape_security_door_blocker","targetname");
	var_04 notsolid();
	var_05 = getent("controlroom_exit_door","targetname");
	var_05.animname = "controlroom_exit_door";
	var_05 maps\_anim::setanimtree();
	var_06 = getent("s3_escape_controlroom_exit_col","targetname");
	var_01 maps\_anim::anim_first_frame_solo(var_05,"s3escape_controlroom_exit");
	var_01 thread s3_escape_sliding_door_player(var_05,var_06,"s3escape_controlroom_exit",1);
	thread maps\_utility::autosave_now();
	thread s3escape_console_setup();
	var_01 thread maps\captured_anim::anim_single_to_loop(var_02[0],"s3escape_controlroom","s3escape_controlroom_loop","s3escape_control_room_ender");
	common_scripts\utility::flag_wait("s3_escape_entered_security_center");
	level.player disableweaponpickup();
	param_00 notify("s3escape_takedown_ender");
	var_01 thread maps\captured_anim::anim_single_to_loop(var_02[1],"s3escape_controlroom","s3escape_controlroom_loop","s3escape_control_room_ender");
	var_01 thread maps\captured_anim::anim_single_to_loop(var_02[2],"s3escape_controlroom","s3escape_controlroom_loop","s3escape_control_room_ender");
	common_scripts\utility::flag_wait("s3_escape_hurry_up_move_done");
	var_07 = getent("s3_escape_security_console_trigger","targetname");
	var_07 maps\_utility::addhinttrigger(&"CAPTURED_HINT_USE_CONSOLE",&"CAPTURED_HINT_USE_PC");
	var_08 = common_scripts\utility::getstruct("s3_escape_console_use_marker","targetname");
	maps\captured_actions::s3_escape_hack_action(var_07,var_08);
	level.player setstance("stand");
	level.player allowcrouch(0);
	level.player allowjump(0);
	level.player allowprone(0);
	level.player freezecontrols(1);
	maps\_player_exo::player_exo_deactivate();
	level notify("started_door_hacking");
	var_07 delete();
	soundscripts\_snd::snd_message("aud_separation_logic");
	var_09 = maps\_utility::spawn_anim_model("player_rig");
	var_09 hide();
	level.player disableweapons();
	var_0A = spawn("script_model",level.player.origin);
	var_0A setmodel("vm_titan45_nocamo");
	var_0A linkto(var_09,"tag_weapon_right",(0,0,0),(0,0,0));
	var_01 thread maps\_anim::anim_single_solo(var_09,"s3escape_console_start");
	thread s3escape_console_cinematic_watcher();
	common_scripts\utility::flag_set("s3_escape_console_monitor_unfreeze");
	level.s3_escape_console_monitor setscriptablepartstate(0,2);
	level.player playerlinktoblend(var_09,"tag_player",0.5);
	wait(0.5);
	level.player freezecontrols(0);
	var_09 show();
	level.player playerlinktodelta(var_09,"tag_player",1,0,0,0,0,1);
	wait(getanimlength(var_09 maps\_utility::getanim("s3escape_console_start")) - 0.5);
	var_01 thread maps\_anim::anim_loop_solo(var_09,"s3escape_console_loop","s3escape_console_ender");
	level waittill("s3_escape_guards_entering_room");
	soundscripts\_snd::snd_music_message("mus_captured_escape_end");
	var_0B = getentarray("s3_escape_main_room_guards","targetname");
	var_0C = maps\_utility::array_spawn(var_0B);
	var_0C[0].animname = "guard_2";
	var_0C[1].animname = "guard_3";
	thread maps\captured::dialogue_control_room_attack(var_0C[0],var_0C[1]);
	common_scripts\utility::array_thread(var_0C,::maps\captured_util::ignore_everything);
	var_0D = getent("s3_escape_security_guard_door","targetname");
	var_0D.animname = "controlroom_guard_door";
	var_0D maps\_utility::assign_animtree();
	var_01 notify("s3escape_control_room_ender");
	var_01 thread maps\captured_anim::anim_single_to_loop(level.allies[1],"s3escape_controlroom_attack","s3escape_controlroom_attack_loop","s3escape_control_room_attack_ender");
	var_01 thread maps\captured_anim::anim_single_to_loop(level.allies[2],"s3escape_controlroom_attack","s3escape_controlroom_attack_loop","s3escape_control_room_attack_ender");
	var_01 thread maps\_anim::anim_single_solo(var_0D,"s3escape_controlroom_attack");
	var_01 thread maps\_anim::anim_single(var_0C,"s3escape_controlroom_attack");
	thread s3_escape_elevator_movement();
	var_01 thread maps\_anim::anim_single_solo(level.allies[0],"s3escape_controlroom_attack");
	var_0E = getnode("s3_escape_ally_attack_node","targetname");
	level.allies[0] setgoalnode(var_0E);
	wait(3);
	level notify("finished_door_hacking");
	common_scripts\utility::flag_set("s3_escape_exit_door_open");
	thread maps\captured_actions::s3_escape_console_gun_action(var_01,var_09,var_0A);
	param_00 notify("s3_close_sliding_door");
	var_04 solid();
	level.player maps\_utility::wait_for_notify_or_timeout("captured_action_complete",3);
	wait 0.05;
	if(!common_scripts\utility::flag("s3_player_pickedup_console_gun"))
	{
		var_01 notify("s3escape_console_ender");
		level.player unlink();
		var_09 delete();
		level.player thread maps\captured_util::start_one_handed_gunplay("iw5_kvahazmatknifeonearm_sp");
		level.player switchtoweaponimmediate("iw5_kvahazmatknifeonearm_sp");
		var_0A delete();
		setsaveddvar("ammoCounterHide","0");
		var_03 show();
		level.player maps\_utility::lerp_player_view_to_position((4709.12,-10660.2,-1760),level.player.angles,0.9,0.5);
		level.player allowfire(1);
		level.player showviewmodel();
		level.player allowmelee(1);
		level.player allowsprint(1);
		level.player allowcrouch(1);
		level.player allowjump(1);
		level.player allowprone(1);
		level.player enableoffhandweapons();
		maps\_player_exo::player_exo_activate();
		wait(0.3);
	}
	else
	{
		level.player enableoffhandweapons();
		maps\_player_exo::player_exo_activate();
		wait(1.6);
	}

	setsaveddvar("ammoCounterHide","0");
	common_scripts\utility::flag_set("s3_player_pickedup_console_gun");
	level.allies[0] unlink();
	level.allies[0].ignoreall = 0;
	level.allies[0].ignoreme = 0;
	level.allies[0].dontmelee = 1;
	common_scripts\utility::array_thread(var_0C,::maps\captured_util::unignore_everything);
	common_scripts\utility::array_thread(var_0C,::maps\_utility::anim_stopanimscripted);
	maps\_utility::kill_deathflag("escape_guards_dead",2.5);
	wait(1);
	common_scripts\utility::flag_wait("escape_guards_dead");
	level.allies[0] maps\captured_util::ignore_everything();
	var_0F = getent("s3_escape_large_security_door","targetname");
	var_0F moveto(var_0F.origin - (0,0,112),1,0.2,0.05);
	soundscripts\_snd::snd_message("aud_separation_door");
	soundscripts\_snd::snd_message("start_indoor_alarms");
	maps\captured_util::physics_bodies_off();
	thread maps\captured_util::physics_bodies_on("escape_bodies_2",5,1);
	common_scripts\utility::flag_set("flag_s3guard_security_door_shuts");
	level.allies[0].dontmelee = 0;
	var_01 notify("s3escape_control_room_attack_ender");
	thread maps\captured_medical::test_chamber_stairs_up_door();
	thread s3_body_movement();
	var_02 = common_scripts\utility::array_remove(var_02,level.allies[0]);
	level notify("split_scene_start");
	var_01 notify("s3escape_controlroom_attack_loop");
	var_01 thread maps\_anim::anim_single(var_02,"s3escape_controlroom_exit");
	var_01 thread maps\_anim::anim_single_solo(level.allies[0],"s3escape_controlroom_exit");
	var_01 waittill("s3_escape_open_door");
	thread maps\_utility::autosave_now();
	thread s3escape_console_pause_checkpoint();
	var_10 = getentarray("s3escape_hall_enemies","targetname");
	var_11 = maps\_utility::array_spawn(var_10,1);
	var_12 = getent("s3escape_enemy_goal_volume_1","targetname");
	foreach(var_14 in var_11)
	{
		var_14 thread s3_escape_guard_function();
	}

	thread maps\_utility::battlechatter_on("allies");
	thread maps\_utility::battlechatter_on("axis");
	wait(2);
	level.allies[0] stopanimscripted();
	level.allies[0].goalradius = 8;
	var_16 = getnodearray("s3escape_ally_cover_nodes","targetname");
	var_17 = randomintrange(0,1);
	level.allies[0] setgoalnode(var_16[var_17]);
	level.allies[0] maps\_utility::set_force_cover(1);
	level.allies[0] waittill("goal");
	level.allies[0] maps\captured_util::unignore_everything();
	common_scripts\utility::flag_wait_either("flag_s3escape_exit","s3escape_hall_enemies_dead");
	var_18 = getent("s3escape_enemy_goal_volume_2","targetname");
	foreach(var_14 in var_11)
	{
		if(isalive(var_14))
		{
			var_14 setgoalvolumeauto(var_18);
		}
	}

	level.allies[0] maps\_utility::set_force_cover(0);
	common_scripts\utility::flag_wait("s3escape_hall_enemies_dead");
	level.allies[0] maps\captured_util::ignore_everything();
	thread maps\_utility::battlechatter_off("allies");
	thread maps\_utility::battlechatter_off("axis");
	level.allies[0].goalradius = 24;
	var_01 maps\_anim::anim_reach_and_idle_solo(level.allies[0],"s3escape_controlroom_exit_loop","s3escape_controlroom_exit_loop","s3escape_controlroom_exit_loop_enter");
	common_scripts\utility::flag_wait("flag_s3escape_end");
	maps\_utility::autosave_by_name("s3escape_end");
	wait(1);
	var_01 notify("s3escape_controlroom_exit_loop_enter");
}

//Function Number: 32
s3_escape_elevator_movement()
{
	wait(2);
	soundscripts\_snd::snd_message("aud_separation_elevator");
	var_00 = getentarray("s3_escape_elevator","targetname");
	var_01 = undefined;
	wait(0.5);
	var_02 = getent("s3_escape_door_left","targetname");
	var_02 moveto(var_02.origin + (52,0,0),0.75,0.2,0.05);
	var_03 = getent("s3_escape_door_right","targetname");
	var_03 moveto(var_03.origin + (-52,0,0),0.75,0.2,0.05);
	foreach(var_05 in var_00)
	{
		if(var_05.classname == "script_brushmodel")
		{
			var_01 = var_05;
		}
	}

	foreach(var_05 in var_00)
	{
		if(var_05.classname == "script_model")
		{
			var_05 linkto(var_01);
		}
	}

	var_01 moveto(var_01.origin + (0,0,-150),1.5,0.2,0.2);
	level waittill("split_scene_start");
	wait(15);
	var_02 moveto(var_02.origin + (-52,0,0),0.75,0.2,0.05);
	var_03 moveto(var_03.origin + (52,0,0),0.75,0.2,0.05);
}

//Function Number: 33
s3_escape_guards_enter(param_00)
{
	level notify("s3_escape_guards_entering_room");
}

//Function Number: 34
s3_escape_elevator_start(param_00)
{
}

//Function Number: 35
s3_escape_controlroom_exit_door_notetrack(param_00)
{
	var_01 = common_scripts\utility::getstruct("struct_scene_s3escape_security","targetname");
	var_01 notify("s3_escape_open_door");
}

//Function Number: 36
s3_escape_controlroom_exit_door_swipe_sfx_notetrack(param_00)
{
	soundscripts\_snd::snd_message("aud_escape_keycard","exit_door");
}

//Function Number: 37
s3_body_movement()
{
	wait(15);
	var_00 = level.hanging_bodies;
	foreach(var_02 in var_00)
	{
		var_02 moveto(var_02.origin - (0,160,0),4,0.05,0.05);
	}
}

//Function Number: 38
s3_escape_guard_function()
{
	self endon("death");
	maps\captured_util::ignore_everything();
	self.goalradius = 16;
	self waittill("goal");
	maps\captured_util::unignore_everything();
}

//Function Number: 39
s3escape_fade_to_black(param_00)
{
	var_01 = newclienthudelem(level.player);
	var_01 setshader("black",1280,720);
	var_01.horzalign = "fullscreen";
	var_01.vertalign = "fullscreen";
	var_01.alpha = 0;
	var_01.foreground = 0;
	var_01 fadeovertime(2);
	var_01.alpha = 1;
	wait(param_00);
	var_01 fadeovertime(3.5);
	var_01.alpha = 0;
	wait(3.5);
	var_01 destroy();
	var_01 = undefined;
}

//Function Number: 40
slow_player_scaler()
{
	level.player allowsprint(0);
	level.player allowjump(0);
	soundscripts\_snd::snd_message("aud_limp_on");
	level.player maps\_utility::blend_movespeedscale(0.27);
	wait(0.5);
	common_scripts\utility::flag_wait("flag_scene_doctor_done");
	level.player maps\_utility::blend_movespeedscale(0.5,5);
	wait(8);
	level.player allowjump(1);
}

//Function Number: 41
injured_player_wobble()
{
	self endon("start_sprint_wobble");
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00.angles = (0,0,0);
	self playersetgroundreferenceent(var_00);
	var_01 = 6;
	var_02 = var_00.angles;
	while(!common_scripts\utility::flag("flag_scene_doctor_done"))
	{
		common_scripts\utility::flag_wait("flag_injured_player_active");
		wait(randomfloatrange(3,5));
		var_03 = randomfloatrange(3,5);
		var_04 = randomfloatrange(0,var_03);
		var_05 = var_03 - var_04;
		var_00 rotateto((var_02[0] + randomfloatrange(var_01 * -1,var_01),var_02[1] + randomfloatrange(var_01 * -1,var_01),var_02[2] + randomfloatrange(var_01 * -1,var_01)),var_03,var_04,var_05);
		wait(var_03);
		var_03 = randomfloatrange(3,5);
		var_04 = randomfloatrange(0,var_03);
		var_05 = var_03 - var_04;
		var_00 rotateto(var_02,var_03,var_04,var_05);
		wait(var_03);
	}

	self playersetgroundreferenceent(undefined);
	var_00 delete();
}

//Function Number: 42
injured_player_blur()
{
	self endon("start_sprint_wobble");
	while(!common_scripts\utility::flag("flag_scene_doctor_done"))
	{
		common_scripts\utility::flag_wait("flag_injured_player_active");
		var_00 = randomfloatrange(1,2);
		setblur(randomfloatrange(1,3),var_00);
		wait(var_00);
		setblur(0,var_00);
		wait(var_00);
		wait(randomfloatrange(3,5));
	}
}