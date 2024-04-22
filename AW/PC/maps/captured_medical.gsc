/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: captured_medical.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 63
 * Decompile Time: 872 ms
 * Timestamp: 4/22/2024 2:26:30 AM
*******************************************************************/

//Function Number: 1
pre_load()
{
	precachemodel("vm_kvaHasmatKnifeDown");
}

//Function Number: 2
post_load()
{
	setthreatbias("allies","playerseek",-1024);
	setthreatbias("playerseek","allies",-1024);
	setthreatbias("playerseek","player",512);
	common_scripts\utility::flag_init("flag_tc_approach");
	common_scripts\utility::flag_init("flag_tc_move_down");
	common_scripts\utility::flag_init("flag_tc_gideon_at_door");
	common_scripts\utility::flag_init("gps_ah_combat_start");
	common_scripts\utility::flag_init("gps_ah_open_morgue");
	common_scripts\utility::flag_init("gps_ah_in_morgue");
	common_scripts\utility::flag_init("flag_ah_combat_start");
	common_scripts\utility::flag_init("flag_ah_ai_blocker");
	common_scripts\utility::flag_init("flag_ah_combat_hall");
	common_scripts\utility::flag_init("flag_ah_combat_front");
	common_scripts\utility::flag_init("flag_ah_combat_goto_mid");
	common_scripts\utility::flag_init("flag_ah_combat_mid");
	common_scripts\utility::flag_init("flag_ah_combat_back");
	common_scripts\utility::flag_init("flag_ah_combat_near_done");
	common_scripts\utility::flag_init("flag_ah_combat_done");
	common_scripts\utility::flag_init("flag_ah_ready_to_leave");
	common_scripts\utility::flag_init("flag_spawning_autopsy_techs");
	common_scripts\utility::flag_init("flag_autopsy_enter");
	common_scripts\utility::flag_init("flag_autopsy_doctor_door");
	common_scripts\utility::flag_init("flag_autopsy_chute");
	common_scripts\utility::flag_init("flag_autopsy_gideon_at_door");
	common_scripts\utility::flag_init("flag_autopsy_doctor_scene_start");
	common_scripts\utility::flag_init("flag_autopsy_safe_to_open_door");
	common_scripts\utility::flag_init("flag_autopsy_start_fail");
	if(isdefined(common_scripts\utility::getstruct("struct_playerstart_autopsy","targetname")))
	{
		thread setup_spawners();
		thread ah_init_track_doors();
		level.tcah_doors = [];
		level.tcah_doors = [maps\_utility::spawn_anim_model("tcah_door_l"),maps\_utility::spawn_anim_model("tcah_door_r")];
		level.tcah_node = common_scripts\utility::getstruct("anim_tc_chamber","targetname");
		level.tcah_node maps\_anim::anim_first_frame(level.tcah_doors,"tc_enter_test_exit_door");
		getent("tcah_door_l_link","targetname") linkto(level.tcah_doors[0],"j_bone_door_left");
		getent("tcah_door_r_link","targetname") linkto(level.tcah_doors[1],"j_bone_door_right");
		return;
	}

	iprintln("Warning: Autopsy start point missing.  Compiled out?");
}

//Function Number: 3
start_test_chamber()
{
	thread maps\_utility::battlechatter_off("allies");
	thread maps\_utility::battlechatter_off("axis");
	maps\captured_util::warp_allies("struct_allystart_test_chamber");
	level.player maps\captured_util::warp_to_start("struct_playerstart_test_chamber");
	level.player thread maps\captured_util::start_one_handed_gunplay("iw5_sn6pickup_sp_xmags");
	maps\_player_exo::player_exo_activate();
	thread test_chamber_stairs_up_door();
	soundscripts\_snd::snd_message("start_test_chamber");
}

//Function Number: 4
main_test_chamber()
{
	getscriptablearray("s3_escape_console_monitor","targetname")[0] setscriptablepartstate(0,3);
	setsaveddvar("cg_cinematicfullscreen","0");
	cinematicingameloop("captured_manticore_display",1,1);
	if(level.allies.size > 1)
	{
		for(var_00 = level.allies.size - 1;var_00 > 0;var_00--)
		{
			level.allies[var_00] maps\_utility::stop_magic_bullet_shield();
			level.allies[var_00] delete();
		}
	}

	var_01 = getentarray("tc_manticore_doors","targetname");
	foreach(var_03 in var_01)
	{
		var_03.door_tag = common_scripts\utility::spawn_tag_origin();
		var_03.door_tag.origin = var_03.origin;
		var_03.door_tag.angles = var_03.angles;
		var_03.door_tag.script_noteworthy = "aut_cleanup";
		var_03.animname = "controlroom_entrance_door";
		var_03 maps\_utility::assign_animtree();
		var_03.script_noteworthy = "aut_cleanup";
		var_03.door_tag thread maps\_anim::anim_first_frame_solo(var_03,"s3escape_takedown");
	}

	var_05 = getent("test_chamber_door_a_clip","targetname");
	var_05 notsolid();
	thread tc_side_door_movement();
	level.player thread maps\_utility::blend_movespeedscale(0.5);
	var_06 = common_scripts\utility::getstruct("anim_tc_observation","targetname");
	var_07 = [maps\_utility::spawn_targetname("opfor_tc_observation_scientist_1"),maps\_utility::spawn_targetname("opfor_tc_observation_scientist_2")];
	var_08 = [maps\_utility::spawn_targetname("opfor_tc_observation_scientist_3"),maps\_utility::spawn_targetname("opfor_tc_observation_scientist_4")];
	var_07[0].animname = "scientist_1";
	var_07[1].animname = "scientist_2";
	var_08[0].animname = "scientist_3";
	var_08[1].animname = "scientist_4";
	var_07[0] thread observation_room_scientist_anims(var_07,1);
	var_07[1] thread observation_room_scientist_anims(var_07,2);
	var_08[0] thread observation_room_scientist_setup(3);
	var_08[1] thread observation_room_scientist_setup(4);
	var_09 = common_scripts\utility::getstruct("struct_scene_test_chamber_manticore","targetname");
	var_09 maps\_anim::anim_first_frame(var_08,"tc_manticore_start");
	level.ally maps\_utility::disable_ai_color();
	var_0A = common_scripts\utility::getstruct("anim_tc_stairs","targetname");
	var_0A thread tc_manticore_ally_traverse();
	common_scripts\utility::flag_wait("flag_tc_player_can_see_manticore");
	var_0B = common_scripts\utility::getstruct("struct_scene_s3escape_security","targetname");
	var_0B notify("s3_close_sliding_door");
	thread maps\captured_util::physics_bodies_on("test_chamber_bodies_1",0);
	thread maps\captured_util::physics_bodies_on("test_chamber_bodies_2",0);
	var_09 thread maps\captured_anim::anim_single_to_loop(var_08,"tc_manticore_start","tc_manticore_loop","tc_manticore_ender");
	common_scripts\utility::flag_wait("flag_tc_gideon_at_door");
	var_0C = getnode("tc_ally_exit_manticore_node","targetname");
	level.ally.goalradius = 16;
	level.ally setgoalnode(var_0C);
	common_scripts\utility::flag_wait("flag_tc_player_can_see_manticore");
	thread maps\_utility::battlechatter_on("allies");
	thread maps\_utility::battlechatter_on("axis");
	wait(1);
	var_0D = getentarray("med_observation_enemies","targetname");
	var_0E = maps\_utility::array_spawn(var_0D,1);
	soundscripts\_snd::snd_message("aud_door","test_chamber");
	foreach(var_03 in var_01)
	{
		var_03.door_tag thread maps\_anim::anim_single_solo(var_03,"s3escape_takedown");
	}

	wait(1);
	var_11 = getent("tc_manticore_doors_col","targetname");
	var_11 connectpaths();
	var_11 delete();
	level notify("start_anim_tc_melee");
	level.allies[0] maps\captured_util::unignore_everything();
	common_scripts\utility::flag_wait("flag_med_observation_enemies");
	thread maps\_utility::battlechatter_off("allies");
	thread maps\_utility::battlechatter_off("axis");
	maps\_utility::autosave_by_name("observation");
	common_scripts\utility::flag_wait("flag_tc_approach");
	level notify("start_anim_tc_approach");
	var_12 = getnode("tc_ally_enter_observation_node","targetname");
	level.ally.goalradius = 16;
	level.ally setgoalnode(var_12);
	var_0A notify("ally_keep_moving");
	common_scripts\utility::flag_wait("flag_tc_move_to_door");
	var_13 = common_scripts\utility::getstruct("anim_tc_chamber","targetname");
	var_13 maps\_anim::anim_reach_solo(level.ally,"tc_observation");
	var_13 maps\_anim::anim_single_solo(level.ally,"tc_observation");
	if(!common_scripts\utility::flag("flag_tc_move_down"))
	{
		var_13 maps\_anim::anim_reach_solo(level.ally,"tc_observation_loop");
		var_13 thread maps\_anim::anim_loop_solo(level.ally,"tc_observation_loop","tc_observation_loop_ender");
	}
	else
	{
		level.tcah_node maps\_anim::anim_reach_solo(level.ally,"tc_exit_stairs");
	}

	common_scripts\utility::flag_wait("flag_tc_move_down");
	soundscripts\_snd::snd_message("aud_door","test_chamber_exit","open");
	var_14 = getent("tc_exit_stairs_door","targetname");
	var_15 = getent(var_14.target,"targetname");
	var_15 linkto(var_14);
	var_14 moveto(var_14.origin + (52,0,0),1,0.25,0.5);
	level notify("start_anim_tc_exit_stairs");
	var_13 notify("tc_observation_loop_ender");
	thread tc_door_to_stairs_closer(var_14);
	if(level.currentgen)
	{
		thread tc_ai_clip_blocker();
	}

	level.tcah_node maps\_anim::anim_single_solo(level.ally,"tc_exit_stairs");
	if(!common_scripts\utility::flag("flag_tc_chamber_enter"))
	{
		level.tcah_node thread maps\_anim::anim_loop_solo(level.ally,"tc_exit_door_loop","ally_keep_moving");
	}

	level notify("start_anim_tc_exit_door_loop");
	common_scripts\utility::flag_wait("flag_tc_chamber_enter");
	soundscripts\_snd::snd_message("aud_zap_scene");
	level notify("start_anim_tc_enter_test");
	level.tcah_node notify("ally_keep_moving");
	maps\_utility::delaythread(2,::tc_uv_rumble);
	var_05 solid();
	var_16 = getent("test_chamber_door_a_rt","targetname");
	var_17 = getent("test_chamber_door_a_lt","targetname");
	var_17 movex(29,0.3);
	var_16 movex(-29,0.3);
	stopcinematicingame();
	var_08 = maps\_utility::array_removedead(var_08);
	maps\_utility::array_delete(var_08);
	maps\captured_util::physics_bodies_off();
	var_18 = getentarray("physics_chair_cleanup","script_noteworthy");
	maps\_utility::array_delete(var_18);
	thread maps\captured_util::physics_bodies_on("test_chamber_bodies_1",5);
	thread maps\captured_util::physics_bodies_on("test_chamber_bodies_2",5);
	var_19 = getent("test_chamber_door_b","targetname");
	var_1A = getent("test_chamber_door_b_collision","targetname");
	var_1A linkto(var_19);
	var_19 common_scripts\utility::delaycall(6,::movex,-55,0.3);
	if(level.currentgen)
	{
		if(!istransientloaded("captured_autopsy_halls_tr"))
		{
			level waittill("tff_post_load_autopsy_halls");
		}
	}

	level notify("start_anim_tc_enter_test");
	thread test_chamber_body_pushes();
	level.tcah_node maps\_anim::anim_single_solo(level.ally,"tc_enter_test");
	level notify("end_anim_tc_enter_test");
	level.tcah_node thread maps\_anim::anim_loop_solo(level.ally,"tc_enter_test_loop","tc_enter_test_loop_ender");
	common_scripts\utility::flag_wait("flag_test_chamber_end");
}

//Function Number: 5
tc_uv_rumble()
{
	var_00 = level.player maps\_utility::get_rumble_ent("steady_rumble");
	var_00 maps\_utility::set_rumble_intensity(0.01);
	var_00 maps\_utility::rumble_ramp_to(1,2.1);
	var_00 stoprumble("steady_rumble");
}

//Function Number: 6
tc_ai_clip_blocker()
{
	var_00 = getent("ah_ai_clip_blocker_test_chamber","targetname");
	var_00 notsolid();
	var_00 connectpaths();
	common_scripts\utility::flag_wait("flag_ah_ai_blocker");
	var_00 solid();
	var_00 disconnectpaths();
}

//Function Number: 7
tc_door_to_stairs_closer(param_00)
{
	maps\_utility::wait_for_targetname_trigger("tc_player_on_stairs_to_tc");
	level notify("tc_stairs_down");
	soundscripts\_snd::snd_message("aud_door","test_chamber_exit","close");
	param_00 moveto(param_00.origin - (52,0,0),1.25,0.2,0.5);
}

//Function Number: 8
test_chamber_stairs_up_door()
{
	var_00 = common_scripts\utility::getstruct("anim_tc_stairs","targetname");
	var_01 = maps\_utility::spawn_anim_model("tc_stairs_door_1");
	var_02 = maps\_utility::spawn_anim_model("tc_stairs_door_2");
	var_03 = getent("door_tc_stairs_01","targetname");
	var_03 linkto(var_01,"j_bone_door_left",(-28,0,48),(0,90,0));
	var_04 = [var_01,var_02];
	var_00 maps\_anim::anim_first_frame(var_04,"tc_stairs");
	level waittill("tc_stair_door_1");
	var_00 thread maps\_anim::anim_single(var_04,"tc_stairs");
	if(level.currentgen)
	{
		if(!istransientloaded("captured_test_chamber_tr"))
		{
			level waittill("tff_pre_escape_to_test_chamber");
			soundscripts\_snd::snd_message("aud_door","test_chamber_stairwell","close");
			var_00 maps\_anim::anim_first_frame(var_04,"tc_stairs");
		}
	}

	level waittill("start_anim_tc_enter_test");
	maps\_utility::array_delete(var_04);
}

//Function Number: 9
test_chamber_stairs_up_door_notetrack(param_00)
{
	level notify("tc_stair_door_1");
}

//Function Number: 10
test_chamber_stairs_up_door_swipe_sfx_notetrack(param_00)
{
	soundscripts\_snd::snd_message("aud_escape_keycard","tc_stairs_door");
}

//Function Number: 11
computer_door_entry_sfx_notetrack(param_00)
{
	soundscripts\_snd::snd_message("aud_morgue_computer_door_entry_sfx");
}

//Function Number: 12
tc_manticore_ally_traverse()
{
	var_00 = self;
	var_01 = getnode("tc_ally_exit_manticore_node","targetname");
	level.ally.goalradius = 16;
	level.ally setgoalnode(var_01);
	var_00 maps\_anim::anim_single_solo(level.ally,"tc_stairs");
	var_00 = common_scripts\utility::getstruct("anim_tc_observation","targetname");
	if(!common_scripts\utility::flag("flag_tc_player_can_see_manticore"))
	{
		var_00 thread maps\_anim::anim_loop_solo(level.ally,"tc_landing_loop","tc_hall_ender");
	}

	common_scripts\utility::flag_wait("flag_tc_player_can_see_manticore");
	var_00 = common_scripts\utility::getstruct("anim_tc_observation","targetname");
	level.ally.goalradius = 16;
	var_00 notify("tc_hall_ender");
	level notify("manticore_hall_vo");
	var_00 maps\_anim::anim_single_solo(level.ally,"tc_hall");
	common_scripts\utility::flag_set("flag_tc_gideon_at_door");
}

//Function Number: 13
tc_side_door_movement()
{
	var_00 = getentarray("tc_side_doors","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = getentarray(var_02.target,"targetname");
		common_scripts\utility::array_call(var_03,::linkto,var_02);
	}

	while(!common_scripts\utility::flag("flag_test_chamber_end"))
	{
		common_scripts\utility::flag_wait("flag_tc_side_door_open");
		soundscripts\_snd::snd_message("aud_door","test_chamber_side","open");
		var_00[0] moveto(var_00[0].origin + (0,50,0),1.25,0.2,0.5);
		var_00[1] moveto(var_00[1].origin - (0,50,0),1.25,0.2,0.5);
		wait(1.5);
		while(common_scripts\utility::flag("flag_tc_side_door_open"))
		{
			wait(0.05);
		}

		soundscripts\_snd::snd_message("aud_door","test_chamber_side","close");
		var_00[0] moveto(var_00[0].origin - (0,50,0),1.25,0.2,0.5);
		var_00[1] moveto(var_00[1].origin + (0,50,0),1.25,0.2,0.5);
		wait(1.5);
	}
}

//Function Number: 14
test_chamber_body_pushes()
{
	wait(16.36);
	var_00 = level.ally gettagorigin("tag_flash");
	physicsexplosionsphere(var_00,30,30,0.3);
	wait(1.9);
	var_01 = level.ally gettagorigin("tag_stowed_back");
	physicsexplosionsphere(var_01,25,25,0.3);
}

//Function Number: 15
test_chamber_exit_door(param_00)
{
	wait(1);
	var_01 = tc_setup_door("tc_exit_door");
	var_01 rotateyaw(100,1,0.25,0.25);
}

//Function Number: 16
test_chamber_exit_door_notetrack(param_00)
{
	level notify("tc_exit_door");
}

//Function Number: 17
observation_room_scientist_anims(param_00,param_01)
{
	self endon("death");
	maps\_utility::set_ignoreall(1);
	maps\_utility::set_ignoreme(1);
	self.grenadeammo = 0;
	maps\_utility::disable_pain();
	maps\_utility::magic_bullet_shield(1);
	self.no_friendly_fire_penalty = 1;
	self.ignoresonicaoe = 1;
	self pushplayer(1);
	maps\_utility::set_deathanim("tc_scientist_" + param_01 + "_death");
	var_02 = "observation_room_scientist_node_" + param_01;
	var_03 = common_scripts\utility::getstruct(var_02,"targetname");
	var_04 = maps\_utility::spawn_anim_model("observation_chair_" + param_01);
	thread observation_room_scientist_death(var_03,param_01,var_04);
	var_05 = [self,var_04];
	var_03 maps\_anim::anim_first_frame(var_05,"tc_melee");
	level waittill("start_anim_tc_melee");
	var_03 maps\_anim::anim_single(var_05,"tc_melee");
	var_03 maps\_anim::anim_loop(var_05,"tc_scientist_" + param_01 + "_loop","observation_room_scientist_endloop");
	common_scripts\utility::flag_wait("flag_tc_chamber_enter");
	var_03 notify("observation_room_scientist_endloop");
	param_00 = common_scripts\utility::array_removeundefined(param_00);
	if(param_00.size > 0)
	{
		common_scripts\utility::array_thread(param_00,::maps\_utility::anim_stopanimscripted);
		common_scripts\utility::array_call(param_00,::delete);
	}

	var_04 delete();
}

//Function Number: 18
observation_room_scientist_death(param_00,param_01,param_02)
{
	level endon("tc_stairs_down");
	self waittill("damage",var_03,var_04);
	param_00 notify("observation_room_scientist_endloop");
	var_05 = [self,param_02];
	var_06 = "tc_scientist_" + param_01 + "_death";
	if(var_04 == level.player)
	{
		if(!level.missionfailed)
		{
			setdvar("ui_deadquote",&"CAPTURED_FAIL_INNOCENT");
			thread maps\_utility::missionfailedwrapper();
		}
	}

	param_00 thread maps\_anim::anim_single(var_05,var_06);
	var_07 = getanimlength(maps\_utility::getanim(var_06));
	wait(var_07 - 0.05);
	self setanimrate(maps\_utility::getanim(var_06),0);
	param_02 setanimrate(param_02 maps\_utility::getanim(var_06),0);
}

//Function Number: 19
observation_room_scientist_setup(param_00)
{
	maps\_utility::set_ignoreall(1);
	maps\_utility::set_ignoreme(1);
	self.grenadeammo = 0;
	maps\_utility::disable_pain();
	self.no_friendly_fire_penalty = 1;
	self.ignoresonicaoe = 1;
	self pushplayer(1);
	thread vign_ai_check_for_death(1);
}

//Function Number: 20
vign_ai_check_for_death(param_00)
{
	self notify("stop_check_for_death");
	self endon("stop_check_for_death");
	self endon("flag_test_chamber_end");
	self waittill("damage",var_01,var_02,var_03,var_04);
	if(isplayer(var_02))
	{
		if(!level.missionfailed)
		{
			setdvar("ui_deadquote",&"CAPTURED_FAIL_INNOCENT");
			thread maps\_utility::missionfailedwrapper();
		}
	}

	if(!isdefined(param_00))
	{
		level.ally stopanimscripted();
	}

	self startragdollfromimpact(var_04,var_03);
	level notify("tech_dead");
}

//Function Number: 21
tc_setup_door(param_00,param_01)
{
	var_02 = getent(param_00,"targetname");
	var_03 = getentarray(var_02.target,"targetname");
	var_04 = undefined;
	foreach(var_06 in var_03)
	{
		if(var_06.classname == "script_brushmodel")
		{
			var_04 = var_06;
		}

		var_06 linkto(var_02);
	}

	if(isdefined(param_01))
	{
		return [var_02,var_04];
	}

	return var_02;
}

//Function Number: 22
start_autopsy_halls()
{
	maps\captured_util::warp_allies("struct_allystart_autopsy_halls");
	level.player thread maps\_utility::blend_movespeedscale(0.5);
	level.player maps\captured_util::warp_to_start("struct_playerstart_autopsy_halls");
	level.player thread maps\captured_util::start_one_handed_gunplay("iw5_titan45pickup_sp_xmags");
	soundscripts\_snd::snd_message("start_halls_to_autopsy");
	maps\_player_exo::player_exo_activate();
	level thread autopsy_first_frame_entry_doors();
	soundscripts\_snd::snd_message("aud_alarm_submix");
}

//Function Number: 23
main_autopsy_halls()
{
	var_00 = getentarray("ent_ah_autopsy_doors","targetname");
	foreach(var_02 in var_00)
	{
		var_02.script_noteworthy = "aut_cleanup";
		var_02 maps\_utility::assign_animtree("controlroom_entrance_door");
		var_02.door_tag = common_scripts\utility::spawn_tag_origin();
		var_02.door_tag.origin = var_02.origin;
		var_02.door_tag.angles = var_02.angles;
		var_02.door_tag.script_noteworthy = "aut_cleanup";
		var_02.door_tag maps\_anim::anim_first_frame_solo(var_02,"s3escape_takedown");
		getent(var_02.target,"targetname") linkto(var_02);
	}

	var_04 = common_scripts\utility::getstructarray("ent_ah_track_body","targetname");
	common_scripts\utility::array_thread(getentarray("ent_ah_track_block","targetname"),::ah_init_track_block,var_04);
	level.player thread ah_player_bodybag_slowdown(0.4,0.8,0.05,0.1);
	thread ah_morgue_doors();
	soundscripts\_snd::snd_message("aud_morgue_bodybag_line_emt");
	var_05 = common_scripts\utility::array_add(level.tcah_doors,level.ally);
	level.tcah_node notify("tc_enter_test_loop_ender");
	soundscripts\_snd::snd_music_message("mus_captured_halls");
	soundscripts\_snd::snd_message("start_indoor_alarms_2");
	soundscripts\_snd::snd_message("aud_stop_horror_ambience");
	level.tcah_node thread maps\_anim::anim_single(var_05,"tc_enter_test_exit_door",undefined,0.2);
	maps\_utility::array_spawn(getentarray("civ_ah_intro","targetname"),1);
	wait(1.5);
	if(!level.currentgen)
	{
		maps\_utility::array_spawn(getentarray("civ_ah_start","targetname"),1);
	}

	level.ally thread maps\_utility::enable_cqbwalk();
	level.ally thread maps\_utility::follow_path(getnode("node_ah_ally_start","targetname"));
	common_scripts\utility::flag_set("flag_ah_ai_blocker");
	common_scripts\utility::flag_wait("flag_ah_combat_start");
	thread maps\_utility::battlechatter_on("allies");
	thread maps\_utility::battlechatter_on("axis");
	level.nextgrenadedrop = 573000;
	level.one_handed_help = 1;
	level.player thread maps\_utility::blend_movespeedscale(0.8,1);
	soundscripts\_snd::snd_message("aud_limp_off");
	level.ally thread maps\_utility::disable_cqbwalk();
	maps\_utility::array_spawn(getentarray("opfor_ah_start_front","targetname"));
	maps\_utility::array_spawn(getentarray("opfor_ah_start","targetname"));
	maps\captured_util::delay_retreat("opfor_ah",10,-2,"flag_ah_combat_hall","color_ah_combat_hall",1);
	level.ally thread maps\_utility::notify_delay("stop_going_to_node",0.5);
	level.ally maps\_utility::delaythread(0.5,::maps\_utility::set_force_color,"r");
	level thread ah_delay_playerseek(10,"gps_ah_combat_start");
	maps\_utility::flood_spawn(getentarray("opfor_ah_front","targetname"));
	maps\captured_util::delay_retreat("opfor_ah",60,[-4,3],"flag_ah_combat_front","color_ah_combat_front",1);
	maps\_utility::flood_spawn(getentarray("opfor_ah_mid","targetname"));
	maps\_utility::flagwaitthread("flag_ah_combat_goto_mid",::maps\_utility::autosave_by_name,"ah_morgue");
	level.player thread ah_morgue_threat_proc();
	maps\captured_util::delay_retreat("opfor_ah",60,[-6,4],"flag_ah_combat_mid","color_ah_combat_mid",1);
	thread maps\_spawner::killspawner(91);
	common_scripts\utility::flag_set("flag_ah_combat_goto_mid");
	wait(1);
	maps\captured_util::delay_retreat("opfor_ah",60,2,"flag_ah_combat_back","color_ah_combat_back",1);
	thread maps\_spawner::killspawner(92);
	maps\_utility::array_spawn(getentarray("opfor_ah_back","targetname"));
	var_06 = getent("color_ah_combat_near_done","targetname");
	var_06 maps\_utility::flagwaitthread("flag_ah_combat_near_done",::maps\_utility::notify_delay,"trigger",0);
	maps\captured_util::delay_retreat("opfor_ah",60,0,"flag_ah_combat_done");
	level.one_handed_help = undefined;
	maps\_utility::delaythread(5,::maps\_utility::kill_deathflag,"flag_ah_combat_done",3,1);
	soundscripts\_snd::snd_music_message("mus_captured_halls_end");
	var_07 = common_scripts\utility::getstruct("node_ah_security_console","targetname");
	level.ally maps\_utility::disable_ai_color();
	level.ally maps\_utility::follow_path(var_07);
	level notify("obj_exit_morgue");
	var_08 = common_scripts\utility::getstruct("struct_vign_autopsy_door","targetname");
	var_08 maps\_anim::anim_reach_solo(level.ally,"morgue_exit_door_start");
	var_08 maps\_anim::anim_single_solo(level.ally,"morgue_exit_door_start");
	var_08 thread maps\_anim::anim_loop_solo(level.ally,"morgue_exit_door_loop","morgue_exit_door_loop_ender");
	while(!common_scripts\utility::flag("flag_ah_combat_near_done"))
	{
		wait(0.05);
	}

	thread ah_tranistion_doors(var_08,var_00);
	level notify("vo_morgue_transition");
	var_08 notify("morgue_exit_door_loop_ender");
	var_08 maps\_anim::anim_single_solo(level.ally,"morgue_exit_door_end");
	common_scripts\utility::flag_set("flag_ah_ready_to_leave");
}

//Function Number: 24
ah_player_bodybag_slowdown(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self notify("stop_bodybag_slowdown");
	self endon("stop_bodybag_slowdown");
	for(;;)
	{
		if(common_scripts\utility::flag("flag_player_hit_bodybag") && self.movespeedscale > param_00)
		{
			maps\_utility::blend_movespeedscale(max(param_00,self.movespeedscale - param_02),0.05);
		}
		else if(!common_scripts\utility::flag("flag_player_hit_bodybag") && self.movespeedscale < param_01)
		{
			maps\_utility::blend_movespeedscale(min(param_01,self.movespeedscale + param_03),0.05);
		}

		wait(0.05);
	}
}

//Function Number: 25
ah_tranistion_doors(param_00,param_01)
{
	foreach(var_03 in param_01)
	{
		var_03.closed = var_03.origin;
	}

	level waittill("ally_opens_autopsy_outer_door");
	soundscripts\_snd::snd_message("aud_door","autopsy_pre_doors","open");
	foreach(var_03 in param_01)
	{
		var_03.door_tag thread maps\_anim::anim_single_solo(var_03,"s3escape_takedown");
	}

	var_07 = getent("ent_ah_autopsy_doors_col","targetname");
	var_07 notsolid();
	common_scripts\utility::flag_wait("flag_ah_ready_to_leave");
	var_08 = getent("trig_autopsy_halls_end","targetname");
	while(!level.player istouching(var_08))
	{
		wait(0.05);
	}

	var_08 delete();
	soundscripts\_snd::snd_message("aud_door","autopsy_pre_doors","close");
	foreach(var_03 in param_01)
	{
		var_03 moveto(var_03.closed,0.5,0.05,0.05);
	}

	var_07 solid();
	wait(0.5);
	common_scripts\utility::flag_set("flag_autopsy_halls_end");
	thread ah_fast_body_cleanup();
	if(level.currentgen)
	{
		common_scripts\utility::flag_set("tff_trans_autopsy_halls_to_autopsy");
	}

	level waittill("autopsy_enemy_door_open");
	if(level.nextgen)
	{
		param_01[0] moveto(param_01[0].origin + (0,52,0),1,0.05,0.05);
		param_01[1] moveto(param_01[1].origin - (0,52,0),1,0.05,0.05);
		return;
	}

	var_0B = getent(param_01[0].target,"targetname");
	var_0C = getent(param_01[1].target,"targetname");
	var_0B delete();
	var_0C delete();
}

//Function Number: 26
ah_delay_playerseek(param_00,param_01,param_02)
{
	if(isdefined(param_01))
	{
		level endon(param_01);
	}

	if(isdefined(level.flag[param_01]) && common_scripts\utility::flag(param_01))
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}
	else if(param_02 > 4)
	{
		return;
	}

	wait(param_00);
	var_03 = undefined;
	var_04 = common_scripts\utility::get_array_of_closest(level.player.origin,maps\_utility::get_ai_group_ai("opfor_ah"),undefined,undefined,1536);
	foreach(var_06 in var_04)
	{
		if(isdefined(var_06.enemy) && isplayer(var_06.enemy))
		{
			var_03 = var_06;
			break;
		}
	}

	if(!isdefined(var_03) || !isalive(var_03))
	{
		level thread ah_delay_playerseek(1,param_01,param_02 + 1);
		return;
	}

	var_03 endon("death");
	var_03 setthreatbiasgroup("playerseek");
	var_03 thread maps\_utility::player_seek();
}

//Function Number: 27
ah_init_track_block(param_00)
{
	self endon("death");
	self.models = ["cap_hanging_bodybag","cap_hanging_bodybag_02","cap_hanging_bodybag_b","cap_hanging_bodybag_c","cap_hanging_bodybag_02_b","cap_hanging_bodybag_02_c"];
	var_01 = common_scripts\utility::getclosest(self.origin,param_00,128);
	self.body = spawn("script_model",var_01.origin);
	self.body setmodel(common_scripts\utility::random(self.models));
	self.body.angles = (self.angles[0],randomint(360),self.angles[2]);
	self.slow_trig = getent(var_01.target,"targetname");
	self.slow_trig enablelinkto();
	wait(0.05);
	self.body linkto(self);
	self.slow_trig linkto(self);
	self.offset = (0,4,-7);
	self.track_start = getent("org_ah_track_start","targetname");
	self.track_end = getent("org_ah_track_end","targetname");
	var_02 = getent(self.target,"targetname");
	thread ah_move_track_block(var_02);
}

//Function Number: 28
ah_move_track_block(param_00)
{
	self endon("death");
	level endon("stop_moving_bodies");
	while(!common_scripts\utility::flag("flag_autopsy_halls_end"))
	{
		var_01 = distance(self.origin,param_00.origin) * 0.03;
		if(isdefined(param_00.doors))
		{
			param_00 thread ah_track_door_open(var_01);
		}

		self moveto(param_00.origin,var_01);
		wait(var_01);
		if(isdefined(param_00.script_noteworthy) && param_00.script_noteworthy == "turn")
		{
			wait(0.25);
			self rotateto(param_00.angles,1);
			wait(1);
		}

		param_00 = getent(param_00.target,"targetname");
		if(param_00 == self.track_start)
		{
			self.body delete();
			self teleportentityrelative(self.track_end,self.track_start);
			self dontinterpolate();
			wait(0.05);
			self.body = spawn("script_model",self.origin + self.offset + (0,0,randomfloatrange(-1,1)));
			self.body setmodel(common_scripts\utility::random(self.models));
			self.body.angles = (self.angles[0],randomint(360),self.angles[2]);
			wait(0.05);
			self.body linkto(self);
			param_00 = getent(param_00.target,"targetname");
		}
	}

	self delete();
}

//Function Number: 29
ah_fast_body_cleanup()
{
	level notify("stop_moving_bodies");
	var_00 = getentarray("ent_ah_track_block","targetname");
	foreach(var_02 in var_00)
	{
		var_02.body delete();
	}
}

//Function Number: 30
ah_init_track_doors()
{
	var_00 = getent("org_ah_track_start","targetname");
	if(isdefined(var_00))
	{
		var_01 = getent(var_00.target,"targetname");
		while(var_01 != var_00)
		{
			if(isdefined(var_01.script_noteworthy) && var_01.script_noteworthy != "turn")
			{
				var_01.doors = getentarray(var_01.script_noteworthy,"targetname");
				foreach(var_03 in var_01.doors)
				{
					var_04 = getentarray(var_03.target,"targetname");
					common_scripts\utility::array_call(var_04,::linkto,var_03);
					var_03.open = var_03.origin;
					var_03.close = var_03.open + 28 * vectornormalize((var_01.origin[0],var_01.origin[1],var_03.open[2]) - var_03.open);
					var_03 moveto(var_03.close,0.05);
				}
			}

			var_01 = getent(var_01.target,"targetname");
		}
	}
}

//Function Number: 31
ah_track_door_open(param_00)
{
	wait(param_00 - 1.25);
	foreach(var_02 in self.doors)
	{
		var_02 moveto(var_02.open,1,0.1,0.4);
	}

	soundscripts\_snd::snd_message("aud_morgue_bodybag_doors","open");
	wait(1.5);
	foreach(var_02 in self.doors)
	{
		var_02 moveto(var_02.close,1,0.2,0.2);
	}

	soundscripts\_snd::snd_message("aud_morgue_bodybag_doors","close");
}

//Function Number: 32
ah_morgue_doors()
{
	var_00 = common_scripts\utility::getstruct("door_ah_morgue_close","targetname");
	var_01 = getentarray("door_ah_morgue","targetname");
	foreach(var_03 in var_01)
	{
		var_04 = getentarray(var_03.target,"targetname");
		common_scripts\utility::array_call(var_04,::linkto,var_03);
		var_03.open = var_03.origin;
		var_03.close = var_00.origin;
		var_03 moveto(var_03.close,0.05);
	}

	while(!common_scripts\utility::flag("flag_incinerator_saved"))
	{
		common_scripts\utility::flag_wait("gps_ah_open_morgue");
		soundscripts\_snd::snd_message("aud_door","morgue_doors","open");
		foreach(var_03 in var_01)
		{
			var_03 moveto(var_03.open,1.25,0.2,0.5);
		}

		wait(1.5);
		while(common_scripts\utility::flag("gps_ah_open_morgue"))
		{
			wait(0.05);
		}

		soundscripts\_snd::snd_message("aud_door","morgue_doors","close");
		foreach(var_03 in var_01)
		{
			var_03 moveto(var_03.close,1.25,0.2,0.5);
		}
	}
}

//Function Number: 33
ah_morgue_threat_proc()
{
	self endon("death");
	self.threat_stance = "none";
	while(!common_scripts\utility::flag("flag_incinerator_saved"))
	{
		while(common_scripts\utility::flag("gps_ah_in_morgue"))
		{
			var_00 = self getstance();
			if(self.threat_stance != var_00)
			{
				maps\captured_util::one_handed_modify_threatbias(var_00);
			}

			wait(0.05);
		}

		maps\captured_util::one_handed_modify_threatbias("none");
		common_scripts\utility::flag_wait("gps_ah_in_morgue");
	}

	self.threat_stance = undefined;
}

//Function Number: 34
start_autopsy()
{
	if(level.nextgen)
	{
		var_00 = getentarray("ent_ah_autopsy_doors","targetname");
		common_scripts\utility::array_call(var_00,::delete);
	}
	else
	{
		var_01 = getentarray("ent_ah_autopsy_doors","targetname");
		foreach(var_03 in var_01)
		{
			var_03.script_noteworthy = "aut_cleanup";
			var_03 maps\_utility::assign_animtree("controlroom_entrance_door");
			var_03.door_tag = common_scripts\utility::spawn_tag_origin();
			var_03.door_tag.origin = var_03.origin;
			var_03.door_tag.angles = var_03.angles;
			var_03.door_tag.script_noteworthy = "aut_cleanup";
			var_03.door_tag maps\_anim::anim_first_frame_solo(var_03,"s3escape_takedown");
		}
	}

	maps\captured_util::warp_allies("struct_allystart_autopsy");
	level.player thread maps\_utility::blend_movespeedscale(0.8);
	level.player maps\captured_util::warp_to_start("struct_playerstart_autopsy");
	level.player thread maps\captured_util::start_one_handed_gunplay("iw5_titan45pickup_sp_xmags");
	maps\_player_exo::player_exo_activate();
	common_scripts\utility::flag_set("flag_autopsy_halls_end");
}

//Function Number: 35
main_autopsy()
{
	thread maps\_utility::battlechatter_off("allies");
	thread maps\_utility::battlechatter_off("axis");
	level thread autopsy_start();
	common_scripts\utility::flag_wait("flag_autopsy_end");
}

//Function Number: 36
setup_spawners()
{
	common_scripts\utility::array_call(getentarray("opfor_tc_observation_scientist","script_noteworthy"),::setspawnerteam,"allies");
	maps\_utility::array_spawn_function(getentarray("civ_ah_intro","targetname"),::civ_ah);
	maps\_utility::array_spawn_function(getentarray("civ_ah_start","targetname"),::civ_ah);
	maps\_utility::array_spawn_function(getentarray("opfor_ah_start_front","targetname"),::opfor_ah_start_front);
	maps\_utility::array_spawn_function(getentarray("opfor_ah_start","targetname"),::opfor_ah);
	maps\_utility::array_spawn_function(getentarray("opfor_ah_front","targetname"),::opfor_ah);
	maps\_utility::array_spawn_function(getentarray("opfor_ah_front_pyr","targetname"),::opfor_ah);
	maps\_utility::array_spawn_function(getentarray("opfor_ah_mid","targetname"),::opfor_ah);
	maps\_utility::array_spawn_function(getentarray("opfor_ah_mid_pyr","targetname"),::opfor_ah);
	maps\_utility::array_spawn_function(getentarray("opfor_ah_back","targetname"),::opfor_ah);
	maps\_utility::array_spawn_function(getentarray("med_observation_enemies","targetname"),::opfor_ah);
	maps\_utility::array_spawn_function_targetname("opfor_autopsy_guard",::autopsy_guard);
	maps\_utility::array_spawn_function_targetname("opfor_autopsy_doctor",::autopsy_main_doctor);
}

//Function Number: 37
civ_ah()
{
	self endon("death");
	self.no_friendly_fire_penalty = 1;
	self.a.disablelongdeath = 1;
	if(isdefined(self.script_noteworthy))
	{
		self.health = 50;
		self.allowdeath = 1;
		self.ignoresonicaoe = 1;
		thread vign_ai_check_for_death();
		level.tcah_node maps\_anim::anim_single([self],"tc_enter_test_exit_door",undefined,0.2,self.script_noteworthy);
		self notify("stop_check_for_death");
	}

	thread maps\captured_util::cap_civilian_damage_proc();
	thread maps\_spawner::go_to_node(undefined,undefined,undefined,randomintrange(448,576));
	self waittill("civ_kill_me");
	for(;;)
	{
		if(distancesquared(self.origin,level.player.origin) > 1048576 && !maps\_utility::player_can_see_ai(self))
		{
			break;
		}

		wait(0.1);
	}

	self delete();
}

//Function Number: 38
opfor_ah()
{
	self endon("death");
	thread maps\captured_util::opfor_death_mod();
	thread maps\captured_util::opfor_ammo_drop_mod();
	thread maps\_utility::set_grenadeammo(0);
	var_00 = undefined;
	if(isdefined(self.target,"targetname"))
	{
		var_00 = getentarray(self.target,"targetname");
	}

	while(isdefined(var_00) && var_00.size > 0)
	{
		var_01 = randomint(var_00.size);
		if(isdefined(var_00[var_01].target) && isdefined(var_00[var_01].script_flag_wait) && common_scripts\utility::flag(var_00[var_01].script_flag_wait))
		{
			var_00 = getentarray(var_00[var_01].target,"targetname");
			continue;
		}

		thread maps\_utility::follow_path(var_00[var_01]);
		break;
	}
}

//Function Number: 39
opfor_ah_start_front()
{
	self endon("death");
	thread maps\captured_util::opfor_death_mod();
	thread maps\captured_util::opfor_ammo_drop_mod();
	thread maps\_utility::set_grenadeammo(0);
	maps\_utility::set_favoriteenemy(level.ally);
	maps\_utility::set_baseaccuracy(0.5);
	self waittill("goal");
	self.health = 1;
	level.ally maps\_utility::set_favoriteenemy(self);
}

//Function Number: 40
autopsy_guard()
{
	self endon("death");
	self.baseaccuracy = 0;
	self.script_noteworthy = "aut_cleanup";
	if(!isdefined(self.script_delay) || self.script_delay < 3)
	{
		maps\_utility::gun_remove();
		maps\_utility::place_weapon_on("iw5_titan45pickup_sp","right");
	}

	maps\_utility::set_ignoreall(1);
	wait(randomfloatrange(4,8));
	maps\_utility::set_ignoreall(0);
	maps\_utility::delaythread(3,::autopsy_guard_player_hit);
	while(!common_scripts\utility::flag("flag_incinerator_fires_start"))
	{
		self.baseaccuracy = min(1,self.baseaccuracy + randomfloat(0.05));
		self.bulletsinclip = weaponclipsize(self.weapon);
		if(common_scripts\utility::cointoss())
		{
			maps\_utility::enable_dontevershoot();
			continue;
		}

		maps\_utility::disable_dontevershoot();
		wait(randomfloatrange(0.5,1));
	}

	self delete();
}

//Function Number: 41
autopsy_guard_player_hit()
{
	self endon("death");
	level endon("stop_autopsy_guard_player_hit");
	for(;;)
	{
		self waittill("shooting");
		if(isplayer(self.enemy) && self cansee(level.player) && randomfloat(1) < self.baseaccuracy)
		{
			level.player dodamage(10,self geteye(),self);
		}
	}
}

//Function Number: 42
autopsy_main_doctor()
{
	self endon("death");
	self.animname = "doctor";
	self.grenadeammo = 0;
	self.ignoresonicaoe = 1;
	maps\_utility::magic_bullet_shield(1);
	maps\_utility::set_ignoreall(1);
	maps\_utility::set_ignoreme(1);
	maps\_utility::gun_remove();
	maps\_utility::place_weapon_on("iw5_titan45pickup_sp","left");
	thread vign_ai_check_for_death();
	self pushplayer(1);
	self waittill("vig_kill_me");
	self notify("stop_check_for_death");
	maps\_utility::stop_magic_bullet_shield();
	self.a.nodeath = 1;
	self.allowdeath = 1;
	self.diequietly = 1;
	self kill();
}

//Function Number: 43
doc_fire(param_00)
{
	param_00 shoot();
}

//Function Number: 44
doc_punched(param_00)
{
	playfxontag(level._effect["punch_mouth_blood_spit"],param_00,"j_head");
}

//Function Number: 45
rifle_butt(param_00)
{
	playfxontag(level._effect["punch_mouth_blood_spit"],param_00,"J_Elbow_RI");
}

//Function Number: 46
autopsy_first_frame_entry_doors()
{
	var_00 = [];
	var_00["left"] = getent("aut_door_lt","targetname");
	var_00["left_col"] = getent("aut_door_lt_col","targetname");
	var_00["left"] maps\_utility::assign_animtree("autopsy_door");
	var_00["left_col"] linkto(var_00["left"],"j_bone_door_left");
	var_00["right"] = getent("aut_door_rt","targetname");
	var_00["right_col"] = getent("aut_door_rt_col","targetname");
	var_00["right"] maps\_utility::assign_animtree("autopsy_door_rt");
	var_00["right_col"] linkto(var_00["right"],"j_bone_door_right");
	var_01 = common_scripts\utility::getstruct("struct_vign_autopsy_door","targetname");
	var_01 thread maps\_anim::anim_first_frame([var_00["left"],var_00["right"]],"autopsy_door");
	return var_00;
}

//Function Number: 47
autopsy_start()
{
	level endon("missionfailed");
	level notify("start_autopsy_enter");
	level.ally maps\_utility::follow_path(getnode("node_autopsy_hold_0","targetname"));
	level.ally maps\_utility::enable_cqbwalk();
	var_00 = maps\_utility::spawn_targetname("opfor_autopsy_doctor");
	var_01 = common_scripts\utility::getstruct("struct_vign_autopsy_doctor_door","targetname");
	var_01 thread maps\_anim::anim_loop_solo(var_00,"autopsy_doctor_loop_start","stop_doctor_loop");
	common_scripts\utility::flag_set("flag_spawning_autopsy_techs");
	level maps\_utility::delaythread(0.05,::autopsy_create_fodder_techs);
	var_02 = autopsy_first_frame_entry_doors();
	var_03 = maps\_utility::spawn_anim_model("autopsy_hatch");
	var_01 maps\_anim::anim_first_frame_solo(var_03,"autopsy_doctor_door_open");
	var_04 = common_scripts\utility::getstruct("struct_vign_autopsy_door","targetname");
	var_04 thread maps\_anim::anim_loop_solo(level.ally,"autopsy_entrance_door_loop","autopsy_entrance_door_loop_ender");
	common_scripts\utility::flag_wait("flag_autopsy_halls_end");
	var_04 notify("autopsy_entrance_door_loop_ender");
	level notify("ready_for_autopsy_start");
	thread maps\captured_util::physics_bodies_off();
	thread maps\captured_util::physics_bodies_on("autopsy_bodies_1",0);
	if(level.currentgen)
	{
		if(!istransientloaded("captured_autopsy_tr"))
		{
			level waittill("tff_post_autopsy_halls_to_autopsy");
		}
	}

	common_scripts\utility::flag_set("flag_autopsy_enter");
	level.mission_fail_func = undefined;
	soundscripts\_snd::snd_message("aud_autopsy_entrance");
	level.ally maps\_utility::ai_ignore_everything();
	var_04 thread autopsy_door_tech();
	var_04 thread maps\_anim::anim_single([level.ally,var_02["left"],var_02["right"]],"autopsy_door",undefined,0.2);
	var_01 thread autopsy_doctor_door_doctor(var_00);
	var_01 maps\_anim::anim_reach_solo(level.ally,"autopsy_doctor_gideon_walk");
	common_scripts\utility::flag_set("flag_autopsy_doctor_scene_start");
	var_01 thread autopsy_doctor_door_gideon();
	var_05 = ["cap_dcr_getbackorillshoot","cap_dcr_imwarningyou"];
	var_00 thread maps\captured_util::dialogue_nag_loop(var_05,"doctor_door_weapon_hidden",3,4,3,8);
	common_scripts\utility::flag_wait("flag_autopsy_gideon_at_door");
	common_scripts\utility::flag_wait("flag_autopsy_safe_to_open_door");
	var_06 = getent("aut_door_use_trig","targetname");
	var_06 maps\_utility::addhinttrigger(&"CAPTURED_HINT_OPEN_CONSOLE",&"CAPTURED_HINT_OPEN_PC");
	maps\captured_actions::autopsy_door_action(var_06,var_01);
	var_06 delete();
	var_01 thread autopsy_doctor_door_player();
	thread maps\captured::dialogue_s3_head_doctor(var_00);
	level waittill("doctor_door_weapon_hidden");
	soundscripts\_snd_common::snd_enable_soundcontextoverride("bullet_whizby_glass");
	var_01 notify("stop_gideon_loop");
	var_01 notify("stop_doctor_loop");
	var_07 = [];
	var_07["doctor"] = var_00;
	var_07["autopsy_hatch"] = var_03;
	var_07["sliding_door"] = getent("aut_doctor_doors","targetname");
	var_07["sliding_door"] maps\_utility::assign_animtree("autopsy_doc_doors");
	level.cover_warnings_disabled = 1;
	level maps\_utility::delaythread(8,::autopsy_doctor_door_enemies);
	thread maps\captured_fx::fx_autopsy_hatch_open();
	var_00 thread maps\_utility::notify_delay("vig_kill_me",getanimlength(%cap_s3_autopsydoc_opendoor_doc));
	var_01 thread maps\captured_anim::anim_single_to_loop_solo(level.ally,"autopsy_doctor_door_open","autopsy_doctor_hatch_open_loop","autopsy_hatch_ender");
	var_01 thread maps\_anim::anim_single(var_07,"autopsy_doctor_door_open");
	wait(getanimlength(level.ally maps\_utility::getanim("autopsy_doctor_door_open")));
	level.ally maps\_utility::ai_unignore_everything();
	var_08 = common_scripts\utility::getstructarray("action_doctor_hatch_node","targetname");
	array_waittill_player_lookat(var_08,0.8,0.25,1,3,var_03);
	common_scripts\utility::flag_set("flag_autopsy_chute");
	var_07 = [];
	var_07["ally_0"] = level.ally;
	var_07["autopsy_hatch"] = var_03;
	var_01 notify("autopsy_hatch_ender");
	soundscripts\_snd::snd_message("aud_hatch_gideon");
	var_09 = getanimlength(level.ally maps\_utility::getanim("autopsy_doctor_hatch_open_jump"));
	var_01 thread maps\_anim::anim_single(var_07,"autopsy_doctor_hatch_open_jump");
	level.ally common_scripts\utility::delaycall(var_09,::hide);
	level.ally maps\_utility::delaythread(var_09,::maps\_utility::disable_cqbwalk);
	common_scripts\utility::getstruct("struct_anim_incinerator","targetname") maps\_utility::delaythread(var_09,::maps\_anim::anim_first_frame_solo,level.ally,"incinerator_intro");
	wait(2);
	for(;;)
	{
		array_waittill_player_lookat(var_08,0.9,0.15,1);
		if(distance2d(level.player.origin,var_08[0].origin) < 70 && level.player isonground())
		{
			setdemigodmode(level.player,1);
			break;
		}

		wait 0.05;
	}

	var_0A = maps\_utility::spawn_anim_model("player_rig");
	var_0A hide();
	level.player freezecontrols(1);
	level.player allowprone(0);
	level.player allowcrouch(0);
	level.player allowstand(1);
	level.player allowjump(0);
	level.player setstance("stand");
	while(level.player getstance() != "stand")
	{
		wait(0.05);
	}

	level thread maps\_utility::notify_delay("stop_autopsy_guard_player_hit",2);
	level notify("autopsy_player_jumping_into_hatch");
	thread maps\captured_util::smooth_player_link(var_0A,0.4);
	var_01 maps\_anim::anim_single([var_0A,var_03],"autopsy_doctor_player_jump",undefined,0.25);
	level.player unlink();
	var_0A delete();
	level.player freezecontrols(0);
	level.cover_warnings_disabled = undefined;
	common_scripts\utility::flag_set("flag_autopsy_end");
	soundscripts\_snd_common::snd_disable_soundcontextoverride("bullet_whizby_glass");
	wait(2);
	setdemigodmode(level.player,0);
	var_03 delete();
	common_scripts\utility::array_call(var_02,::delete);
	thread maps\captured_util::physics_bodies_off();
}

//Function Number: 48
array_waittill_player_lookat(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = spawnstruct();
	foreach(var_09 in param_00)
	{
		var_07 thread array_waittill_player_lookat_proc(var_09,param_01,param_02,param_03,param_04,param_05,param_06);
	}

	var_07 waittill("lookat_complete");
}

//Function Number: 49
array_waittill_player_lookat_proc(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("lookat_complete");
	param_00 maps\_utility::waittill_player_lookat(param_01,param_02,param_03,param_04,param_05,param_06);
	self notify("lookat_complete");
}

//Function Number: 50
autopsy_doctor_door_no_hint()
{
	if(!isalive(level.player))
	{
		return 1;
	}

	if(common_scripts\utility::flag("missionfailed"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 51
autopsy_doctor_door_player()
{
	maps\_utility::autosave_by_name_silent("autopsy_doctor");
	common_scripts\utility::flag_set("flag_autopsy_doctor_door");
	var_00 = maps\_utility::spawn_anim_model("player_rig");
	var_00 hide();
	maps\_anim::anim_first_frame([var_00],"autopsy_doctor_door_open");
	setsaveddvar("g_friendlyNameDist",0);
	level.player disableweapons();
	level.player allowmelee(0);
	level.player setstance("stand");
	level.player allowstand(1);
	level.player allowcrouch(0);
	level.player allowprone(0);
	level.player allowsprint(0);
	level.player playerlinktoblend(var_00,"tag_player",0.5);
	if(issubstr(tolower(level.player.one_weap),"titan45") || issubstr(tolower(level.player.one_weap),"knife"))
	{
		soundscripts\_snd::snd_message("aud_autopsy_knife_pry_door","handgun");
		wait(0.6);
	}
	else
	{
		soundscripts\_snd::snd_message("aud_autopsy_knife_pry_door","rifle");
		wait(1);
	}

	level notify("doctor_door_weapon_hidden");
	level.player notify("stop_one_handed_gunplay");
	level.player takeallweapons();
	maps\_player_exo::player_exo_deactivate();
	level notify("stop_overdrive_tracker");
	var_00 show();
	var_00 attach("vm_kvaHasmatKnifeDown","tag_weapon_right");
	level.player playerlinktodelta(var_00,"tag_player",1,0,0,0,0,1);
	maps\_anim::anim_single([var_00],"autopsy_doctor_door_open");
	level.player allowsprint(1);
	level.player allowprone(1);
	level.player allowcrouch(1);
	level.player allowstand(1);
	level.player takeallweapons();
	level.player enableweapons();
	level.player unlink();
	var_00 delete();
}

//Function Number: 52
autopsy_doctor_door_gideon()
{
	level.ally endon("death");
	maps\_utility::delaythread(3,::common_scripts\utility::flag_set,"flag_autopsy_gideon_at_door");
	maps\captured_anim::anim_single_to_loop_solo(level.ally,"autopsy_doctor_gideon_walk","autopsy_doctor_gideon_door_loop","stop_gideon_loop");
}

//Function Number: 53
autopsy_doctor_door_doctor(param_00)
{
	param_00 endon("death");
	while(distance(param_00.origin,level.ally.origin) > 704)
	{
		wait(0.05);
	}

	self notify("stop_doctor_loop");
	maps\_anim::anim_single_solo(param_00,"autopsy_doctor_grabgun");
	common_scripts\utility::flag_set("flag_autopsy_safe_to_open_door");
	maps\_anim::anim_loop_solo(param_00,"autopsy_doctor_grabgun_loop","stop_doctor_loop");
}

//Function Number: 54
autopsy_doctor_door_fail()
{
	level endon("missionfailed");
	level endon("flag_autopsy_chute");
	var_00 = 10;
	common_scripts\utility::flag_set("flag_autopsy_start_fail");
	wait(var_00);
	if(!common_scripts\utility::flag("flag_autopsy_chute"))
	{
		setdvar("ui_deadquote",&"CAPTURED_FAIL_AUTOPSY_ESCAPE");
		thread maps\_utility::missionfailedwrapper();
	}
}

//Function Number: 55
autopsy_doctor_door_enemies()
{
	level notify("autopsy_enemy_door_open");
	var_00 = getent("aut_glass_clip","targetname");
	var_00 delete();
	maps\_utility::flood_spawn(getentarray("opfor_autopsy_guard","targetname"));
}

//Function Number: 56
autopsy_doctor_door_enemy_think(param_00)
{
	var_01 = common_scripts\utility::getstruct("aut_door_enemy_node_" + param_00,"targetname");
	self.script_noteworthy = "aut_cleanup";
	maps\_utility::set_ignoreall(1);
	self.goalradius = 16;
	self setgoalpos(var_01.origin);
	wait(4);
	maps\_utility::set_ignoreall(0);
}

//Function Number: 57
autopsy_doctor_door_enemy_ammo()
{
	self endon("death");
	for(;;)
	{
		self givemaxammo(self.weapon);
		wait(1);
	}
}

//Function Number: 58
autopsy_door_tech()
{
	if(level.currentgen)
	{
		if(!istransientloaded("captured_autopsy_tr"))
		{
			level waittill("tff_post_autopsy_halls_to_autopsy");
		}
	}

	var_00 = maps\_utility::spawn_targetname("aut_tech",1);
	common_scripts\utility::flag_clear("flag_spawning_autopsy_techs");
	var_00 maps\_utility::set_ignoreall(1);
	var_00 maps\_utility::set_ignoreme(1);
	var_00.grenadeammo = 0;
	var_00.animname = "autopsy_tech";
	var_00.ignoresonicaoe = 1;
	var_00 pushplayer(1);
	var_00 endon("death");
	var_00 thread vign_ai_check_for_death();
	var_00 maps\_utility::delaythread(6.75,::vign_ai_check_for_death,0);
	maps\_anim::anim_single_solo(var_00,"autopsy_door");
	thread maps\_anim::anim_loop_solo(var_00,"autopsy_door_tech_loop","stop_looping");
}

//Function Number: 59
autopsy_create_fodder_techs()
{
	var_00 = common_scripts\utility::getstructarray("aut_tech","targetname");
	common_scripts\utility::flag_waitopen("flag_spawning_autopsy_techs");
	wait 0.05;
	foreach(var_02 in var_00)
	{
		var_02 thread autopsy_fodder_tech_think();
		wait 0.05;
	}
}

//Function Number: 60
autopsy_fodder_tech_think()
{
	var_00 = self.origin;
	var_01 = self.angles;
	var_02 = maps\_utility::spawn_targetname("aut_tech",1);
	var_02 maps\_utility::set_ignoreall(1);
	var_02 maps\_utility::set_ignoreme(1);
	var_02.grenadeammo = 0;
	var_02.animname = "tech";
	var_02 forceteleport(var_00,var_01);
	var_02 setgoalpos(var_00);
	var_02 maps\_utility::set_deathanim("cap_s3_autopsy_tech_death");
	var_02 thread vign_ai_check_for_death(1);
	var_02.ignoresonicaoe = 1;
	var_02 pushplayer(1);
	var_02 endon("death");
	var_03 = 0;
	var_04 = 0;
	if(isdefined(self.script_index))
	{
		var_04 = 0.01 * self.script_index;
	}

	if(isdefined(self.script_count))
	{
		var_03 = self.script_count;
	}

	var_02 maps\_anim::anim_first_frame_solo(var_02,self.animation);
	wait(var_03);
	var_02 common_scripts\utility::delaycall(0.05,::setanimtime,level.scr_anim[var_02.animname][self.animation],var_04);
	thread autopsy_fodder_tech_animate(var_02);
}

//Function Number: 61
autopsy_fodder_tech_animate(param_00)
{
	param_00 endon("death");
	param_00 maps\_anim::anim_single_solo(param_00,self.animation);
	param_00 thread maps\_anim::anim_loop_solo(param_00,self.animation + "_loop");
}

//Function Number: 62
autopsy_cleanup()
{
	var_00 = getentarray("aut_cleanup","script_noteworthy");
	maps\_utility::array_delete(var_00);
}

//Function Number: 63
bmcd_debug_loop()
{
	while(!common_scripts\utility::flag("flag_battle_to_heli_end"))
	{
		if(!level.player buttonpressed("BUTTON_B"))
		{
			wait(0.1);
			continue;
		}

		if(level.player buttonpressed("DPAD_LEFT") || level.player buttonpressed("LEFTARROW"))
		{
			maps\_player_exo::player_exo_activate();
			iprintln("Exo On");
			wait(0.2);
			continue;
		}

		if(level.player buttonpressed("DPAD_RIGHT") || level.player buttonpressed("RIGHTARROW"))
		{
			maps\_player_exo::player_exo_deactivate();
			iprintln("Exo Off");
			wait(0.2);
			continue;
		}

		if(level.player buttonpressed("DPAD_UP") || level.player buttonpressed("UPARROW"))
		{
			level.player notify("stop_one_handed_gunplay");
			iprintln("One Handed Off");
			wait(0.2);
			continue;
		}

		if(level.player buttonpressed("DPAD_DOWN") || level.player buttonpressed("DOWNARROW"))
		{
			if(isdefined(level.debugging_on))
			{
				level.debugging_on = undefined;
				iprintln("Debugging Off");
			}
			else
			{
				level.debugging_on = 1;
				iprintln("Debugging On");
			}

			wait(0.2);
		}

		wait(0.1);
	}
}