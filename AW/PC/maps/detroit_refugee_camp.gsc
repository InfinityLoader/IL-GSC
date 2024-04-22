/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: detroit_refugee_camp.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 128
 * Decompile Time: 1974 ms
 * Timestamp: 4/22/2024 2:28:11 AM
*******************************************************************/

//Function Number: 1
refugee_camp_main()
{
	common_scripts\utility::flag_init("bikes_enter_detroit");
	level.refugee_camp_ai = [];
	level.downtown_ambient_guys = [];
	if(level.nextgen)
	{
		precachemodel("character_arab_civilian_lowres_a");
		precachemodel("character_arab_civilian_lowres_b");
		precachemodel("character_arab_civilian_lowres_c");
		precachemodel("character_arab_civilian_lowres_d");
		precachemodel("character_arab_civilian_lowres_e");
		precachemodel("character_arab_civilian_lowres_f");
	}

	thread setup_civs();
	thread gate_decon_player_side();
	thread gate_decon_opposite_side();
	if(level.nextgen)
	{
		thread spraypaint_gag();
		thread setup_refugee_stage_audience();
	}
	else
	{
		thread maps\detroit_transients_cg::cg_spraypaint_gag();
		thread maps\detroit_transients_cg::cg_setup_refugee_stage_audience();
	}

	thread buttress_function();
	thread ambient_dialogue_manager();
	thread refugee_camp_cleanup();
	thread left_mount_trigger_function();
	thread middle_civ_manager();
}

//Function Number: 2
unload_intro_cinematic_assets()
{
	if(istransientloaded("detroit_introA_tr"))
	{
		wait(6);
		unloadtransient("detroit_introA_tr");
		for(;;)
		{
			if(istransientloaded("detroit_introa_tr"))
			{
				common_scripts\utility::flag_set("flag_cg_intro_cin_has_run");
				level notify("tff_post_shed_intro_cin");
				break;
			}

			wait(0.05);
		}
	}
}

//Function Number: 3
delay_show_bones()
{
	level.bones hide();
	common_scripts\utility::flag_wait("flag_camp_visibility_03");
	level.bones show();
}

//Function Number: 4
refugee_walk()
{
	soundscripts\_snd::snd_message("begin_refugee_walk");
	thread player_speed_control();
	level.squad_gestures_wait_count = [];
	level.squad_gestures_idle_count = [];
	level.burke thread squad_gestures_burke();
	level.joker thread squad_gestures_joker();
	if(level.currentgen && !issubstr(level.transient_zone,"middle"))
	{
		common_scripts\utility::array_thread(getentarray("joker_lookat_trigger","targetname"),::det_camp_lookat_trigger_think,level.joker);
		common_scripts\utility::array_thread(getentarray("burke_lookat_trigger","targetname"),::det_camp_lookat_trigger_think,level.burke);
	}

	level.bones maps\_utility::set_moveplaybackrate(1);
	level.bones.ignoreall = 1;
}

//Function Number: 5
squad_gestures_burke()
{
	level.burke set_refugee_camp_walk_anims();
	level.burke maps\_utility::set_moveplaybackrate(1);
	level.burke.ignoreall = 1;
	goto_squad_node("post_gesture_01_burke","flag_post_gesture_01");
	goto_squad_node("pre_gesture_02_burke","flag_gesture_spray_paint");
	play_squad_gesture("org_gesture_02_burke","det_casual_gestures_l_shakehead_burke");
	goto_squad_node("post_gesture_02_burke","flag_post_gesture_02");
	goto_squad_node("pre_gesture_03_burke","flag_gesture_food_truck");
	goto_squad_node("post_gesture_03_burke","flag_gesture_stage_speaker");
	goto_squad_node("post_gesture_04_burke","flag_post_gesture_04");
	goto_squad_node("pre_gesture_05_burke","flag_gesture_last_guard");
	goto_squad_node("post_gesture_05_burke","flag_enter_scanner");
	self.turnrate = self.old_turnrate;
	self.old_turnrate = undefined;
	common_scripts\utility::flag_wait("flag_enter_scanner");
	common_scripts\utility::flag_set("squad_gestures_done_burke");
}

//Function Number: 6
squad_gestures_joker()
{
	level.joker set_refugee_camp_walk_anims();
	level.joker maps\_utility::set_moveplaybackrate(1);
	level.joker.ignoreall = 1;
	goto_squad_node("post_gesture_01_joker","flag_post_gesture_01",0.5);
	goto_squad_node("pre_gesture_02_joker","flag_gesture_spray_paint",0.5);
	goto_squad_node("post_gesture_02_joker","flag_post_gesture_02",0.75);
	goto_squad_node("pre_gesture_03_joker","flag_gesture_food_truck",0.5);
	goto_squad_node("post_gesture_03_joker","flag_gesture_stage_speaker",0.5);
	goto_squad_node("post_gesture_04_joker","flag_post_gesture_04");
	goto_squad_node("pre_gesture_05_joker","flag_gesture_last_guard",0.5);
	goto_squad_node("post_gesture_05_joker","flag_enter_scanner");
	self.turnrate = self.old_turnrate;
	self.old_turnrate = undefined;
	common_scripts\utility::flag_wait("flag_enter_scanner");
	common_scripts\utility::flag_set("squad_gestures_done_joker");
}

//Function Number: 7
play_doctor_pip()
{
	wait(7);
	wait(1);
	maps\_shg_utility::play_videolog("detroit_videolog","screen_add");
}

//Function Number: 8
play_squad_gesture(param_00,param_01)
{
	var_02 = getent(param_00,"targetname");
	var_02 maps\_anim::anim_reach_solo(self,param_01);
	var_02 maps\_anim::anim_single_solo_run(self,param_01);
}

//Function Number: 9
goto_squad_node(param_00,param_01,param_02)
{
	var_03 = getnode(param_00,"targetname");
	var_04 = level.scr_anim[self.animname]["refugee_camp_walk_to_idle"];
	var_05 = transformmove(var_03.origin,var_03.angles,getmovedelta(var_04),getangledelta3d(var_04),(0,0,0),(0,0,0));
	var_06 = spawnstruct();
	var_06.origin = var_05["origin"];
	var_06.angles = var_05["angles"];
	self setgoalpos(var_06.origin);
	self.goalradius = 4;
	var_07 = 128;
	if(param_00 == "pre_gesture_02_burke")
	{
		var_07 = 32;
	}

	while(distance(self.origin,var_06.origin) > var_07)
	{
		wait 0.05;
	}

	if(isdefined(param_01))
	{
		if(!isdefined(level.squad_gestures_wait_count[param_01]))
		{
			level.squad_gestures_wait_count[param_01] = 0;
		}

		if(!isdefined(level.squad_gestures_idle_count[param_01]))
		{
			level.squad_gestures_idle_count[param_01] = 0;
		}

		if(!common_scripts\utility::flag(param_01) || level.squad_gestures_wait_count[param_01] > 0)
		{
			level.squad_gestures_wait_count[param_01]++;
			var_06 maps\_anim::anim_reach_solo(self,"refugee_camp_walk_to_idle");
			var_06 maps\_anim::anim_custom_animmode_solo(self,"gravity","refugee_camp_walk_to_idle");
			thread maps\_anim::anim_loop_solo(self,"refugee_camp_idle","refugee_camp_idle_ender");
			level.squad_gestures_idle_count[param_01]++;
			common_scripts\utility::flag_wait(param_01);
			while(level.squad_gestures_idle_count[param_01] < 2)
			{
				wait 0.05;
			}

			if(isdefined(param_02))
			{
				wait(param_02);
			}

			self notify("refugee_camp_idle_ender");
			maps\_anim::anim_custom_animmode_solo(self,"gravity","refugee_camp_idle_to_walk");
			return;
		}
	}
}

//Function Number: 10
det_camp_lookat_trigger_think(param_00)
{
	if(level.currentgen)
	{
		level endon("flag_camp_visibility_04");
	}

	var_01 = getent(self.target,"targetname");
	var_02 = self.radius;
	while(distancesquared(self.origin,param_00.origin) > var_02 * var_02)
	{
		wait(0.1);
	}

	param_00 setlookatentity(var_01);
	wait(1);
	while(distancesquared(self.origin,param_00.origin) < var_02 * var_02)
	{
		wait(0.1);
	}

	param_00 setlookatentity();
}

//Function Number: 11
signed_distance_to_plane(param_00,param_01,param_02)
{
	return vectordot(param_02 - param_00,param_01);
}

//Function Number: 12
player_speed_control()
{
	var_00 = 0.05;
	var_01 = 1;
	var_02 = 0;
	var_03 = 220;
	var_04 = 500;
	var_05 = 200;
	level.player setmovespeedscale(0.3);
	level.player allowsprint(0);
	common_scripts\utility::flag_wait("flag_player_off_helipad");
	var_06 = 1;
	while(!common_scripts\utility::flag("flag_camp_visibility_04"))
	{
		var_07 = vectornormalize(anglestoforward(level.burke.angles) + anglestoforward(level.joker.angles) + vectornormalize(level.burke.origin + level.joker.origin * 0.5 - level.player.origin));
		var_08 = 0 - signed_distance_to_plane(level.burke.origin,var_07,level.player.origin);
		var_09 = 0 - signed_distance_to_plane(level.joker.origin,var_07,level.player.origin);
		var_0A = min(var_08,var_09);
		var_06 = maps\_shg_utility::linear_map_clamp(var_0A,var_02,var_03,var_00,var_01);
		waittillframeend;
		level.player setmovespeedscale(var_06);
		if(var_0A > var_04)
		{
		}

		if(var_0A < var_05)
		{
			level.player allowsprint(0);
		}

		wait 0.05;
	}

	var_0B = 1 - var_06 / 50;
	while(var_06 < 1)
	{
		var_06 = var_06 + var_0B;
		level.player setmovespeedscale(var_06);
		wait(0.1);
	}

	level.player setmovespeedscale(1);
}

//Function Number: 13
decon_guy_walk_to(param_00,param_01)
{
	param_00 maps\_anim::anim_reach_solo(param_01,"gate_decon");
	param_01 thread maps\_anim::anim_loop_solo(param_01,"gate_decon_idle");
}

//Function Number: 14
decon_guy_walk_away(param_00,param_01)
{
	param_00 maps\_anim::anim_single_solo(self,"gate_decon");
	if(param_01 == 1 || param_01 == 6)
	{
		self delete();
		return;
	}

	var_02 = getnode("node_decon_delete_pass","targetname");
	if(param_01 == 4)
	{
		var_02 = getnode("node_decon_delete_pass_b","targetname");
	}

	self setgoalnode(var_02);
	self.goalradius = 8;
	self waittill("goal");
	self delete();
}

//Function Number: 15
gate_decon_opposite_side()
{
	var_00 = getent("scanner_intro_anim_node","targetname");
	thread gate_decon_opposite_side_guard(var_00);
	common_scripts\utility::flag_wait("flag_camp_visibility_03");
	var_01 = [];
	for(var_02 = 0;var_02 < 2;var_02++)
	{
		var_01[var_02] = getent("scanner_guy_animated_spawner0" + var_02 + 1,"targetname") maps\_utility::spawn_ai(1);
		var_01[var_02].animname = "scanner_guy_animated_spawner0" + var_02 + 1;
		var_01[var_02].ignoreall = 1;
		var_01[var_02].ignoreme = 1;
		var_01[var_02].team = level.player.team;
		var_01[var_02].disableexits = 1;
		var_01[var_02] maps\_utility::gun_remove();
		var_01[var_02] maps\_utility::set_run_anim("gate_decon_walk");
	}

	var_00 maps\_anim::anim_first_frame_solo(var_01[0],"gate_decon");
	var_01[0] thread maps\_anim::anim_loop_solo(var_01[0],"gate_decon_idle","stop_idle_guy1");
	var_00 maps\_anim::anim_first_frame_solo(var_01[1],"gate_decon");
	var_01[1] thread maps\_anim::anim_loop_solo(var_01[1],"gate_decon_idle","stop_idle_guy2");
	maps\_utility::trigger_wait_targetname("gate_decon_opposite_side");
	for(var_02 = 2;var_02 < 4;var_02++)
	{
		var_01[var_02] = getent("scanner_guy_animated_spawner0" + var_02 + 1,"targetname") maps\_utility::spawn_ai(1);
		var_01[var_02].animname = "scanner_guy_animated_spawner0" + var_02 + 1;
		var_01[var_02] maps\_utility::gun_remove();
		var_01[var_02] maps\_utility::set_run_anim("gate_decon_walk");
		var_01[var_02].team = level.player.team;
		var_01[var_02].ignoreall = 1;
		var_01[var_02].ignoreme = 1;
		var_01[var_02].alwaysrunforward = undefined;
	}

	thread decon_guy_walk_to(var_00,var_01[2]);
	maps\_utility::delaythread(0.75,::decon_guy_walk_to,var_00,var_01[3]);
	level waittill("decon_a");
	var_01[0] thread decon_guy_walk_away(var_00,1);
	var_01[1] thread decon_guy_walk_away(var_00,2);
	level waittill("decon_b");
	var_01[2] thread decon_guy_walk_away(var_00,3);
	level waittill("decon_c");
	var_01[3] thread decon_guy_walk_away(var_00,4);
	level waittill("decon_d");
	level waittill("decon_e");
}

//Function Number: 16
gate_decon_opposite_side_guard(param_00)
{
	var_01 = getent("det_security_checkpoint_b","targetname");
	var_01 hide();
	thread decon_reverse_blocking();
	common_scripts\utility::flag_wait("flag_camp_visibility_03");
	var_02 = getent("scanner_guard_animated_spawner01","targetname") maps\_utility::spawn_ai(1);
	var_02.animname = "scanner_guard_animated_spawner01";
	var_03 = getent("scanner_guard_animated_spawner01","targetname");
	var_02.ignoreall = 1;
	var_02.ignoreme = 1;
	var_01 show();
	var_01.animname = "decon_gate";
	var_01 maps\_anim::setanimtree();
	param_00 thread maps\_anim::anim_first_frame_solo(var_01,"det_gate_decon_station");
	param_00 thread maps\_anim::anim_first_frame_solo(var_02,"gate_decon");
	var_02 thread maps\_anim::anim_loop_solo(var_02,"gate_decon_idle","decon_guard_opposite_side_idle_ender");
	maps\_utility::trigger_wait_targetname("gate_decon_opposite_side");
	var_02 notify("decon_guard_opposite_side_idle_ender");
	param_00 thread maps\_anim::anim_single_solo(var_01,"det_gate_decon_station");
	param_00 maps\_anim::anim_single_solo(var_02,"gate_decon");
	var_02 thread maps\_anim::anim_loop_solo(var_02,"gate_decon_idle","decon_guard_opposite_side_idle_ender");
}

//Function Number: 17
decon_reverse_blocking()
{
	var_00 = getent("player_camp_scan_reverse_blockage","targetname");
	var_00 notsolid();
	var_00 connectpaths();
	maps\_utility::trigger_wait_targetname("gate_decon_opposite_side");
	wait(38.76);
	var_00 solid();
	var_00 disconnectpaths();
}

//Function Number: 18
gate_decon_player_side()
{
	var_00 = getent("det_security_checkpoint_a","targetname");
	var_00 hide();
	thread gate_decon_player_side_cinematic_screens();
	common_scripts\utility::flag_wait("flag_camp_visibility_03");
	var_01 = getent("scanner_intro_anim_node","targetname");
	var_02 = getent("decon_gate_clip_01","targetname");
	var_02 notsolid();
	var_02 thread solidify_on_player_decon();
	var_00 show();
	var_00.animname = "decon_gate";
	var_00 maps\_anim::setanimtree();
	var_01 thread maps\_anim::anim_first_frame_solo(var_00,"decon_scanner_front");
	var_03 = getent("scanner_guard_animated_spawner","targetname") maps\_utility::spawn_ai(1);
	var_03.animname = "scanner_guard_animated_spawner";
	var_04 = getent("scanner_guard_animated_spawner","targetname");
	var_03.ignoreall = 1;
	var_03.ignoreme = 1;
	level.camp_scanner_guy = var_03;
	var_01 thread maps\_anim::anim_first_frame_solo(var_03,"gate_decon");
	var_03 thread maps\_anim::anim_loop_solo(var_03,"gate_decon_idle","decon_guard_gate_decon_idle_ender");
	thread gate_decon_player_side_burke(var_01);
	thread gate_decon_player_side_joker(var_01);
	thread gate_decon_player_side_bones(var_01);
	level waittill("start_decon_guard");
	common_scripts\utility::flag_set("vo_refugee_camp_security_checkpoint");
	var_01 thread maps\_anim::anim_single_solo(var_03,"gate_decon");
	var_01 thread maps\_anim::anim_single_solo(var_00,"decon_scanner_front");
	common_scripts\utility::flag_wait_all("flag_decon_ready_burke","flag_decon_ready_joker","flag_decon_ready_player");
	common_scripts\utility::flag_set("vo_refugee_camp_scanner");
	common_scripts\utility::flag_set("flag_camp_visibility_04");
	var_01 notify("decon_guard_gate_decon_idle_ender");
	var_01 thread maps\_anim::anim_single_solo(var_00,"decon_scanner_back");
	level maps\_utility::notify_delay("enable_decon_cinematic_screens",1);
	thread scanner_rumble();
	var_02 solid();
	thread decon_finish();
	var_03 notify("decon_guard_gate_decon_idle_ender");
	var_01 maps\_anim::anim_single_solo(var_03,"gate_decon_b");
	var_05 = getent("decon_guard_casual_idle_org","targetname");
	var_05 maps\_anim::anim_loop_solo(var_03,"gate_decon_idle");
}

//Function Number: 19
decon_finish()
{
	level waittill("scanner_doors_open");
	common_scripts\utility::flag_set("flag_scanner_doors_open");
	if(level.currentgen)
	{
		var_00 = getent("decon_gate_clip_02","targetname");
		var_00 notsolid();
	}
}

//Function Number: 20
scanner_rumble()
{
	wait(0.5);
	var_00 = level.player maps\_utility::get_rumble_ent("steady_rumble");
	var_00 maps\_utility::set_rumble_intensity(0.01);
	var_00 maps\_utility::rumble_ramp_to(0.15,1);
	wait(5.2);
	var_00 stoprumble("steady_rumble");
	var_00 delete();
}

//Function Number: 21
hoverbike_rumble()
{
	wait(3);
	var_00 = level.player maps\_utility::get_rumble_ent("steady_rumble");
	var_00 maps\_utility::set_rumble_intensity(0.1);
	var_00 maps\_utility::delaythread(2,::maps\_utility::set_rumble_intensity,0.35);
	var_00 maps\_utility::delaythread(3.1,::maps\_utility::set_rumble_intensity,0.17);
	var_00 maps\_utility::delaythread(7.1,::maps\_utility::set_rumble_intensity,0.22);
	var_00 maps\_utility::delaythread(9.1,::maps\_utility::set_rumble_intensity,0.08);
	var_00 maps\_utility::delaythread(11.1,::maps\_utility::set_rumble_intensity,0.22);
	var_00 maps\_utility::delaythread(16,::maps\_utility::set_rumble_intensity,0.18);
	var_00 maps\_utility::delaythread(20,::maps\_utility::set_rumble_intensity,0.26);
	var_00 maps\_utility::delaythread(23,::maps\_utility::set_rumble_intensity,0.2);
	var_00 maps\_utility::delaythread(24.5,::maps\_utility::set_rumble_intensity,0.15);
	var_00 maps\_utility::delaythread(25,::maps\_utility::set_rumble_intensity,0.13);
	var_00 maps\_utility::delaythread(35,::maps\_utility::set_rumble_intensity,0.25);
	var_00 maps\_utility::delaythread(36,::maps\_utility::set_rumble_intensity,0.06);
	var_00 maps\_utility::delaythread(52,::maps\_utility::set_rumble_intensity,0.18);
	var_00 maps\_utility::delaythread(55,::maps\_utility::set_rumble_intensity,0.23);
	var_00 maps\_utility::delaythread(59,::maps\_utility::set_rumble_intensity,0.18);
	thread hoverbike_ride_in_autorumble(undefined,"ride_over");
	wait(65);
	var_00 stoprumble("steady_rumble");
	var_00 delete();
}

//Function Number: 22
hoverbike_ride_in_autorumble(param_00,param_01)
{
	var_02 = level.player maps\_utility::get_rumble_ent("steady_rumble");
	var_02 maps\_utility::set_rumble_intensity(0.01);
	if(!isdefined(param_00))
	{
		param_00 = 90;
	}

	for(;;)
	{
		if(!isdefined(self))
		{
			var_02 stoprumble("steady_rumble");
			var_02 delete();
			return;
		}

		var_03 = self.veh_speed / param_00;
		if(var_03 > 0)
		{
			var_02 maps\_utility::set_rumble_intensity(var_03);
		}

		if(var_03 == 0)
		{
			var_02 maps\_utility::set_rumble_intensity(0.01);
		}

		if(common_scripts\utility::flag(param_01))
		{
			if(isdefined(var_02))
			{
				var_02 stoprumble("steady_rumble");
				var_02 delete();
			}

			return;
		}

		wait(randomfloatrange(0.3,0.6));
	}
}

//Function Number: 23
speed_display()
{
	for(;;)
	{
		if(!isdefined(self))
		{
			return;
		}

		if(isdefined(self.veh_speed))
		{
			iprintln(self.veh_speed);
		}

		wait(0.05);
		if(common_scripts\utility::flag("ride_over"))
		{
			return;
		}
	}
}

//Function Number: 24
solidify_on_player_decon()
{
	common_scripts\utility::flag_wait("flag_decon_ready_player");
	self solid();
}

//Function Number: 25
gate_decon_player_side_cinematic_screens()
{
	var_00 = getentarray("scanner_cinematic_panels","targetname");
	foreach(var_02 in var_00)
	{
		var_02 hide();
		var_02 notsolid();
	}

	level waittill("enable_decon_cinematic_screens");
	foreach(var_02 in var_00)
	{
		var_02 show();
	}

	setsaveddvar("cg_cinematicFullScreen","0");
	cinematicingameloop("detroit_body_scan");
	common_scripts\utility::flag_wait("flag_scanner_doors_open");
	foreach(var_02 in var_00)
	{
		var_02 delete();
	}

	stopcinematicingame();
}

//Function Number: 26
gate_decon_player_side_burke(param_00)
{
	level endon("player_has_used_bike");
	common_scripts\utility::flag_wait("squad_gestures_done_burke");
	common_scripts\utility::flag_set("obj_acquire_bikes_pos_bike");
	param_00 maps\_anim::anim_reach_solo(level.burke,"gate_decon");
	level notify("start_decon_guard");
	param_00 maps\_anim::anim_single_solo(level.burke,"gate_decon");
	param_00 thread maps\_anim::anim_loop_solo(level.burke,"gate_decon_idle","burke_gate_decon_idle_ender");
	common_scripts\utility::flag_set("flag_decon_ready_burke");
	common_scripts\utility::flag_wait_all("flag_decon_ready_burke","flag_decon_ready_joker","flag_decon_ready_player");
	param_00 notify("burke_gate_decon_idle_ender");
	param_00 thread maps\_anim::anim_single_solo(level.burke,"gate_decon_b");
	thread bike_reach_function(level.burke,param_00);
}

//Function Number: 27
gate_decon_player_side_joker(param_00)
{
	level endon("player_has_used_bike");
	common_scripts\utility::flag_wait("squad_gestures_done_joker");
	param_00 maps\_anim::anim_reach_solo(level.joker,"gate_decon");
	level notify("start_decon_guard");
	param_00 maps\_anim::anim_single_solo(level.joker,"gate_decon");
	param_00 thread maps\_anim::anim_loop_solo(level.joker,"gate_decon_idle","joker_gate_decon_idle_ender");
	common_scripts\utility::flag_set("flag_decon_ready_joker");
	common_scripts\utility::flag_wait_all("flag_decon_ready_burke","flag_decon_ready_joker","flag_decon_ready_player");
	param_00 notify("joker_gate_decon_idle_ender");
	common_scripts\utility::flag_set("joker_deliver_decon_line");
	param_00 thread maps\_anim::anim_single_solo(level.joker,"gate_decon_b");
	thread bike_reach_function(level.joker,param_00);
}

//Function Number: 28
gate_decon_player_side_bones(param_00)
{
	level endon("player_has_used_bike");
	common_scripts\utility::flag_wait_all("flag_decon_ready_burke","flag_decon_ready_joker","flag_decon_ready_player");
	param_00 thread maps\_anim::anim_single_solo(level.bones,"gate_decon_b");
	thread bike_reach_function(level.bones,param_00);
}

//Function Number: 29
refugee_debug()
{
	wait(1);
	if(isdefined(level.bones))
	{
		level.bones thread color_debug("bones","y");
	}

	if(isdefined(level.joker))
	{
		level.joker thread color_debug("joker","o");
	}
}

//Function Number: 30
color_debug(param_00,param_01)
{
	if(!isdefined(self))
	{
		return;
	}

	maps\_utility::is_default_start();
	if(!maps\_utility::is_default_start())
	{
		return;
	}

	self endon("color_force_off");
	while(maps\_utility::is_default_start())
	{
		if(isdefined(self.script_forcecolor))
		{
			wait 0.05;
			continue;
		}

		maps\_utility::set_force_color(param_01);
		if(isdefined(self.patrol_anim_set))
		{
			maps\detroit::set_patrol_anim_set(self.patrol_anim_set);
		}

		wait(1);
	}
}

//Function Number: 31
refugee_camp_cleanup()
{
	common_scripts\utility::flag_wait("flag_camp_visibility_04");
	common_scripts\utility::array_thread(level.refugee_camp_ai,::maps\_shg_design_tools::delete_auto);
	common_scripts\utility::flag_wait("refugee_camp_cleanup");
	var_00 = getent("det_security_checkpoint_a","targetname");
	var_01 = getent("det_security_checkpoint_b","targetname");
	var_00 delete();
	var_01 delete();
}

//Function Number: 32
player_ads_disable_manager()
{
	wait 0.05;
	level.player allowads(0);
	common_scripts\utility::flag_wait("drivein_player_bike_used");
	level.player allowads(1);
}

//Function Number: 33
left_mount_trigger_function()
{
	level endon("player_has_used_bike");
	level.playerisonleft = 0;
	var_00 = getent("player_left_mount_vol","targetname");
	for(;;)
	{
		if(level.player istouching(var_00))
		{
			level.playerisonleft = 1;
		}
		else
		{
			level.playerisonleft = 0;
		}

		wait(0.05);
	}
}

//Function Number: 34
middle_civ_manager()
{
	wait 0.05;
	maps\_utility::stop_exploder("1501");
	thread disable_middle_civs();
	thread show_middle_civs_now();
	thread disable_middle_civs_now();
}

//Function Number: 35
disable_middle_civs()
{
	level endon("No more civs ever");
	for(;;)
	{
		common_scripts\utility::flag_wait("hide_middle_civs_trigger");
		maps\_utility::stop_exploder("1501");
		wait(0.1);
		common_scripts\utility::flag_clear("hide_middle_civs_trigger");
	}
}

//Function Number: 36
disable_middle_civs_now()
{
	common_scripts\utility::flag_wait("begin_player_mount_bike");
	maps\_utility::stop_exploder("1501");
	level notify("No more civs ever");
}

//Function Number: 37
show_middle_civs_now()
{
	level endon("No more civs ever");
	for(;;)
	{
		common_scripts\utility::flag_wait("show_middle_civs_trigger");
		common_scripts\_exploder::exploder("1501");
		wait(0.1);
		common_scripts\utility::flag_clear("show_middle_civs_trigger");
	}
}

//Function Number: 38
spraypaint_gag()
{
	var_00 = getent("sparaypaint_animspot","targetname");
	var_01 = getent("spraypaint_artist_spawner","targetname");
	var_02 = var_01 maps\_utility::spawn_ai(1);
	var_02.animname = "generic";
	var_02.goalradius = 15;
	var_00 thread maps\_anim::anim_loop_solo(var_02,"spraypaint_idle");
	var_02 attach("com_spray_can01","tag_weapon_right");
	common_scripts\utility::flag_wait("flag_gesture_spray_paint");
	var_03 = getent("spraypaint_guard","targetname");
	var_04 = var_03 maps\_utility::spawn_ai(1);
	var_04.ignoreall = 1;
	var_04.ignoreme = 1;
	var_04.goalradius = 15;
	var_04.animname = "generic";
	var_00 thread maps\_anim::anim_first_frame_solo(var_04,"chase_away");
	thread spraypaint_runner(var_02,var_00);
	thread spraypaint_chaser(var_04,var_00);
	wait(7.31);
	var_04 maps\_utility::dialogue_queue("detroit_atd_heyhey");
}

//Function Number: 39
spraypaint_chaser(param_00,param_01)
{
	param_01 maps\_anim::anim_single_solo(param_00,"chase_away");
	var_02 = getnode("chaser_goal","targetname");
	param_00 setgoalnode(var_02);
	param_00 delete();
}

//Function Number: 40
spraypaint_runner(param_00,param_01)
{
	param_01 maps\_anim::anim_single_solo(param_00,"spraypaint");
	var_02 = getnode("artist_goal","targetname");
	param_00 setgoalnode(var_02);
	param_00 delete();
}

//Function Number: 41
make_smart_floor_effect(param_00)
{
	while(!maps\_utility::ent_flag("security_passed"))
	{
		param_00.origin = self.origin + (0,0,2);
		wait 0.05;
	}

	param_00.origin = param_00.oldorigin;
}

//Function Number: 42
setup_civs()
{
	if(level.nextgen)
	{
		thread setup_civs_foodtruck();
		thread setup_civs_infosign();
		thread setup_civs_fence();
		thread setup_civs_baseball();
		thread setup_social_groups();
	}
	else
	{
		thread maps\detroit_transients_cg::cg_setup_civs_foodtruck();
		thread maps\detroit_transients_cg::cg_setup_civs_infosign();
		thread maps\detroit_transients_cg::cg_setup_civs_fence();
		thread maps\detroit_transients_cg::cg_setup_civs_baseball();
		thread maps\detroit_transients_cg::cg_setup_social_groups();
	}

	thread setup_food_line_and_guards();
	thread setup_choppers();
}

//Function Number: 43
setup_civs_foodtruck()
{
	common_scripts\utility::flag_wait("show_middle_civs_trigger");
	var_00 = getent("civilian_foodtruck1_spawner","targetname") spawndrone();
	var_01 = undefined;
	var_02 = getent("civilian_foodtruck3_spawner","targetname") spawndrone();
	var_03 = undefined;
	var_04 = getent("civilian_foodtruck5_spawner","targetname") spawndrone();
	var_05 = getent("civilian_foodtruck6_spawner","targetname") spawndrone();
	var_06 = undefined;
	var_07 = getent("civilian_foodtruck8_spawner","targetname") spawndrone();
	var_08 = getent("civilian_foodtruck9_spawner","targetname") spawndrone();
	var_09 = getent("civilian_foodtruck10_spawner","targetname") spawndrone();
	var_0A = getent("civilian_foodtruck11_spawner","targetname") spawndrone();
	var_0B = undefined;
	var_0C = getent("civilian_foodtruck13_spawner","targetname") spawndrone();
	var_0D = getent("civilian_foodtruck14_spawner","targetname") spawndrone();
	var_0E = undefined;
	var_0F = getent("atlas_guard_foodtruck2_spawner","targetname") spawndrone();
	var_10 = getent("foodtruck","targetname");
	var_00.animname = "drone_civs";
	var_02.animname = "drone_civs";
	var_04.animname = "drone_civs";
	var_05.animname = "drone_civs";
	var_07.animname = "drone_civs";
	var_08.animname = "drone_civs";
	var_09.animname = "drone_civs";
	var_0A.animname = "drone_civs";
	var_0C.animname = "drone_civs";
	var_0D.animname = "drone_civs";
	var_0F.animname = "drone_civs";
	var_10.animname = "foodtruck";
	var_00 maps\_anim::setanimtree();
	var_02 maps\_anim::setanimtree();
	var_04 maps\_anim::setanimtree();
	var_05 maps\_anim::setanimtree();
	var_07 maps\_anim::setanimtree();
	var_08 maps\_anim::setanimtree();
	var_09 maps\_anim::setanimtree();
	var_0A maps\_anim::setanimtree();
	var_0C maps\_anim::setanimtree();
	var_0D maps\_anim::setanimtree();
	var_0F maps\_anim::setanimtree();
	var_10 maps\_anim::setanimtree();
	var_11 = getent("org_foodtruck","targetname");
	var_12 = spawn("script_model",var_11.origin);
	var_12 setmodel("det_cargo_box_single_01");
	var_12.animname = "foodtruck_mre";
	var_12 maps\_anim::setanimtree();
	var_13 = spawn("script_model",var_11.origin);
	var_13 setmodel("det_cargo_box_single_01");
	var_13.animname = "foodtruck_mre";
	var_13 maps\_anim::setanimtree();
	var_11 thread maps\_anim::anim_loop_solo(var_00,"foodtruck1");
	var_11 thread maps\_anim::anim_loop_solo(var_02,"foodtruck3");
	var_11 thread maps\_anim::anim_loop_solo(var_04,"foodtruck5");
	var_11 thread maps\_anim::anim_loop_solo(var_05,"foodtruck6");
	var_11 thread maps\_anim::anim_loop_solo(var_07,"foodtruck8");
	var_11 thread maps\_anim::anim_loop_solo(var_08,"foodtruck9");
	var_11 thread maps\_anim::anim_loop_solo(var_09,"foodtruck10");
	var_11 thread maps\_anim::anim_loop_solo(var_0A,"foodtruck11");
	var_11 thread maps\_anim::anim_loop_solo(var_0C,"foodtruck13");
	var_11 thread maps\_anim::anim_loop_solo(var_0D,"foodtruck14");
	var_11 thread maps\_anim::anim_loop_solo(var_0F,"foodtruck18");
	var_11 thread maps\_anim::anim_loop_solo(var_10,"foodtruck_door");
	thread mre_loop(var_12);
	thread mre_loop(var_13);
	var_11 thread maps\_anim::anim_loop_solo(var_12,"foodtruck_mre1");
	var_11 thread maps\_anim::anim_loop_solo(var_13,"foodtruck_mre2");
	if(level.nextgen)
	{
		var_01 = getent("civilian_foodtruck2_spawner","targetname") spawndrone();
		var_01.animname = "drone_civs";
		var_01 maps\_anim::setanimtree();
		var_11 thread maps\_anim::anim_loop_solo(var_01,"foodtruck2");
		var_03 = getent("civilian_foodtruck4_spawner","targetname") spawndrone();
		var_03.animname = "drone_civs";
		var_03 maps\_anim::setanimtree();
		var_11 thread maps\_anim::anim_loop_solo(var_03,"foodtruck4");
		var_06 = getent("civilian_foodtruck7_spawner","targetname") spawndrone();
		var_06.animname = "drone_civs";
		var_06 maps\_anim::setanimtree();
		var_11 thread maps\_anim::anim_loop_solo(var_06,"foodtruck7");
		var_0B = getent("civilian_foodtruck12_spawner","targetname") spawndrone();
		var_0B.animname = "drone_civs";
		var_0B maps\_anim::setanimtree();
		var_11 thread maps\_anim::anim_loop_solo(var_0B,"foodtruck12");
		var_0E = getent("atlas_guard_foodtruck1_spawner","targetname") spawndrone();
		var_0E.animname = "drone_civs";
		var_0E maps\_anim::setanimtree();
		var_11 thread maps\_anim::anim_loop_solo(var_0E,"foodtruck17");
	}

	while(!common_scripts\utility::flag("flag_camp_visibility_04"))
	{
		if(randomint(100) > 50)
		{
			var_14 = getent("civilian_foodtruck_grab_spawner_right","targetname") spawndrone();
			var_14 hide();
			var_14.animname = "drone_civs";
			var_14 maps\_anim::setanimtree();
			var_14.runanim = level.scr_anim[var_14.animname]["foodtruck_grab_walk"];
			level waittill("food_walker_go");
			var_14 show();
			var_14 thread foodtruck_drone_walk_away_right(var_11);
			continue;
		}

		var_14 = getent("civilian_foodtruck_grab_spawner_left","targetname") spawndrone();
		var_14 hide();
		var_14.animname = "drone_civs";
		var_14 maps\_anim::setanimtree();
		var_14.runanim = level.scr_anim[var_14.animname]["foodtruck_grab_walk"];
		level waittill("food_walker_go");
		var_14 show();
		var_14 thread foodtruck_drone_walk_away_left(var_11);
	}

	common_scripts\utility::flag_wait("flag_camp_visibility_04");
	var_00 delete();
	var_02 delete();
	var_04 delete();
	var_05 delete();
	var_07 delete();
	var_08 delete();
	var_09 delete();
	var_0A delete();
	var_0C delete();
	var_0D delete();
	var_0F delete();
	var_10 delete();
	if(level.nextgen)
	{
		var_01 delete();
		var_03 delete();
		var_06 delete();
		var_0B delete();
		var_0E delete();
	}
}

//Function Number: 44
mre_loop(param_00)
{
	level waittill("No more civs ever");
	if(isdefined(param_00))
	{
		param_00 stopanimscripted();
		param_00 delete();
	}
}

//Function Number: 45
foodtruck_drone_walk_away_right(param_00)
{
	param_00 maps\_anim::anim_single_solo(self,"foodtruck_grab");
	self.moveplaybackrate = 1;
	thread maps\_drone::drone_move();
}

//Function Number: 46
foodtruck_drone_walk_away_left(param_00)
{
	param_00 maps\_anim::anim_single_solo(self,"foodtruck_grab_left");
	self.moveplaybackrate = 1;
	thread maps\_drone::drone_move();
}

//Function Number: 47
setup_civs_infosign()
{
	common_scripts\utility::flag_wait("flag_camp_visibility_01");
	var_00 = undefined;
	var_01 = getent("civilian_sign2_spawner","targetname") spawndrone();
	var_02 = getent("civilian_sign3_spawner","targetname") spawndrone();
	var_03 = undefined;
	var_01.animname = "drone_civs";
	var_02.animname = "drone_civs";
	var_01 maps\_anim::setanimtree();
	var_02 maps\_anim::setanimtree();
	var_01 thread maps\_anim::anim_loop_solo(var_01,"sign2_spawner");
	var_02 thread maps\_anim::anim_loop_solo(var_02,"sign3_spawner");
	if(level.nextgen)
	{
		var_00 = getent("civilian_sign1_spawner","targetname") spawndrone();
		var_00.animname = "drone_civs";
		var_00 maps\_anim::setanimtree();
		var_00 thread maps\_anim::anim_loop_solo(var_00,"sign1_spawner");
		var_03 = getent("civilian_sign4_spawner","targetname") spawndrone();
		var_03.animname = "drone_civs";
		var_03 maps\_anim::setanimtree();
		var_03 thread maps\_anim::anim_loop_solo(var_03,"sign4_spawner");
	}

	common_scripts\utility::flag_wait("flag_camp_visibility_04");
	var_01 delete();
	var_02 delete();
	if(level.nextgen)
	{
		var_00 delete();
		var_03 delete();
	}
}

//Function Number: 48
setup_civ_fence_special()
{
	var_00 = getent("civilian_fence9_spawner","targetname") spawndrone();
	var_00.animname = "drone_civs";
	var_00 maps\_anim::setanimtree();
	var_00 thread maps\_anim::anim_loop_solo(var_00,"fence_spawner9_idle_start");
	common_scripts\utility::flag_wait("flag_civ_fence_sit");
	var_00 notify("stop_loop");
	var_00 maps\_anim::anim_single_solo(var_00,"fence_spawner9_transition");
	var_00 thread maps\_anim::anim_loop_solo(var_00,"fence_spawner9_idle_end");
	while(!common_scripts\utility::flag("flag_camp_visibility_04"))
	{
		common_scripts\utility::flag_wait("flag_camp_visibility_03b");
		var_00 delete();
		common_scripts\utility::flag_clear("flag_camp_visibility_03a");
		common_scripts\utility::flag_wait("flag_camp_visibility_03a");
		var_00 = getent("civilian_fence9_spawner","targetname") spawndrone();
		var_00.animname = "drone_civs";
		var_00 maps\_anim::setanimtree();
		var_00 thread maps\_anim::anim_loop_solo(var_00,"fence_spawner9_idle_end");
		common_scripts\utility::flag_clear("flag_camp_visibility_03b");
	}
}

//Function Number: 49
setup_civs_fence()
{
	thread setup_civ_fence_special();
	while(!common_scripts\utility::flag("flag_camp_visibility_04"))
	{
		var_00 = getent("civilian_fence1_spawner","targetname") spawndrone();
		var_01 = undefined;
		var_02 = getent("civilian_fence3_spawner","targetname") spawndrone();
		var_03 = getent("civilian_fence4_spawner","targetname") spawndrone();
		var_04 = getent("civilian_fence5_spawner","targetname") spawndrone();
		var_05 = getent("civilian_fence6_spawner","targetname") spawndrone();
		var_06 = getent("civilian_fence7_spawner","targetname") spawndrone();
		var_07 = getent("civilian_fence8_spawner","targetname") spawndrone();
		var_08 = undefined;
		var_09 = undefined;
		var_00.animname = "drone_civs";
		var_02.animname = "drone_civs";
		var_03.animname = "drone_civs";
		var_04.animname = "drone_civs";
		var_05.animname = "drone_civs";
		var_06.animname = "drone_civs";
		var_07.animname = "drone_civs";
		var_00 maps\_anim::setanimtree();
		var_02 maps\_anim::setanimtree();
		var_03 maps\_anim::setanimtree();
		var_04 maps\_anim::setanimtree();
		var_05 maps\_anim::setanimtree();
		var_06 maps\_anim::setanimtree();
		var_07 maps\_anim::setanimtree();
		var_00 thread maps\_anim::anim_loop_solo(var_00,"fence_spawner1");
		var_02 thread maps\_anim::anim_loop_solo(var_02,"fence_spawner3");
		var_03 thread maps\_anim::anim_loop_solo(var_03,"fence_spawner4");
		var_04 thread maps\_anim::anim_loop_solo(var_04,"fence_spawner5");
		var_05 thread maps\_anim::anim_loop_solo(var_05,"fence_spawner6");
		var_06 thread maps\_anim::anim_loop_solo(var_06,"fence_spawner7");
		var_07 thread maps\_anim::anim_loop_solo(var_07,"fence_spawner8");
		if(level.nextgen)
		{
			var_01 = getent("civilian_fence2_spawner","targetname") spawndrone();
			var_01.animname = "drone_civs";
			var_01 maps\_anim::setanimtree();
			var_01 thread maps\_anim::anim_loop_solo(var_01,"fence_spawner2");
			var_08 = getent("civilian_fence10_spawner","targetname") spawndrone();
			var_08.animname = "drone_civs";
			var_08 maps\_anim::setanimtree();
			var_09 = getent("civilian_fence11_spawner","targetname") spawndrone();
			var_09.animname = "drone_civs";
			var_09 maps\_anim::setanimtree();
		}

		wait(1);
		if(level.nextgen)
		{
			var_08 thread maps\_anim::anim_loop_solo(var_08,"fence_spawner10");
			var_09 thread maps\_anim::anim_loop_solo(var_09,"fence_spawner11");
		}

		common_scripts\utility::flag_wait("flag_camp_visibility_03b");
		common_scripts\utility::flag_clear("flag_camp_visibility_03a");
		var_00 delete();
		var_02 delete();
		var_03 delete();
		var_04 delete();
		var_05 delete();
		var_06 delete();
		var_07 delete();
		if(level.nextgen)
		{
			var_01 delete();
			var_08 delete();
			var_09 delete();
		}

		common_scripts\utility::flag_wait("flag_camp_visibility_03a");
		common_scripts\utility::flag_clear("flag_camp_visibility_03b");
	}
}

//Function Number: 50
setup_civs_baseball()
{
	common_scripts\utility::flag_wait("flag_camp_visibility_01");
	var_00 = getent("org_baseball","targetname");
	var_01 = getent("civilian_baseball1_spawner","targetname") spawndrone();
	var_01.animname = "drone_civs";
	var_01 maps\_anim::setanimtree();
	var_02 = getent("civilian_baseball2_spawner","targetname") spawndrone();
	var_02.animname = "drone_civs";
	var_02 maps\_anim::setanimtree();
	var_03 = getent("baseball_glove1","targetname");
	var_03.animname = "baseball_glove";
	var_03 maps\_anim::setanimtree();
	var_04 = getent("baseball_glove2","targetname");
	var_04.animname = "baseball_glove";
	var_04 maps\_anim::setanimtree();
	var_00 thread maps\_anim::anim_loop_solo(var_01,"baseball1");
	var_00 thread maps\_anim::anim_loop_solo(var_02,"baseball2");
	var_00 thread maps\_anim::anim_loop_solo(var_03,"baseball_glove1");
	var_00 thread maps\_anim::anim_loop_solo(var_04,"baseball_glove2");
	var_01 attach("ehq_baseball","tag_weapon_chest");
	common_scripts\utility::flag_wait("flag_camp_visibility_04");
	var_01 delete();
	var_02 delete();
	var_03 delete();
	var_04 delete();
}

//Function Number: 51
setup_civs_talking()
{
	var_00 = getent("civilian_talking1_spawner","targetname") spawndrone();
	var_01 = getent("civilian_talking2_spawner","targetname") spawndrone();
	var_00.animname = "drone_civs";
	var_01.animname = "drone_civs";
	var_00 maps\_anim::setanimtree();
	var_01 maps\_anim::setanimtree();
	var_02 = getent("org_civtalking","targetname");
	var_02 thread maps\_anim::anim_single_solo(var_00,"civtalking1");
	var_02 thread maps\_anim::anim_single_solo(var_01,"civtalking2");
	common_scripts\utility::flag_wait("flag_camp_visibility_04");
	var_00 delete();
	var_01 delete();
}

//Function Number: 52
setup_choppers()
{
	level endon("flag_camp_visibility_04");
	if(level.currentgen)
	{
		level endon("flag_cg_kill_camp_chopper_loop");
	}

	if(level.currentgen)
	{
		for(;;)
		{
			if(istransientloaded("detroit_intro_tr"))
			{
				break;
			}

			wait(0.5);
		}
	}

	var_00 = getentarray("cargo_chopper_01","targetname");
	var_01 = "com_prague_rope_animated";
	var_02 = "mob_cargo_pallet_long";
	var_03 = 464;
	wait(1);
	while(!common_scripts\utility::flag("flag_camp_visibility_04"))
	{
		var_04 = var_00;
		for(var_05 = 0;var_05 < 2;var_05++)
		{
			var_06 = var_04[randomint(var_04.size)];
			var_04 = common_scripts\utility::array_remove(var_04,var_06);
			var_07 = var_06 maps\_vehicle::spawn_vehicle_and_gopath();
			var_07.targetname = "refugee_camp_looping_choppers";
			playfxontag(common_scripts\utility::getfx("aircraft_light_wingtip_red_med"),var_07,"TAG_light_L_wing");
			wait(0.05);
			playfxontag(common_scripts\utility::getfx("aircraft_light_wingtip_red_med"),var_07,"TAG_light_R_wing");
			playfxontag(common_scripts\utility::getfx("aircraft_light_wingtip_red_med"),var_07,"TAG_light_tail");
			var_08 = getent("reflection_golden_bottom","targetname");
			var_07 overridereflectionprobe(var_08.origin);
			if(level.currentgen)
			{
				if(common_scripts\utility::flag("flag_cg_kill_camp_chopper_loop"))
				{
					break;
				}
			}

			wait(randomintrange(2,10));
		}

		wait(30);
	}
}

//Function Number: 53
setup_social_groups()
{
	var_00 = ["civilian_smoking_a","civilian_smoking_b","civilian_atm","civilian_stand_idle","london_civ_idle_checkwatch","london_civ_idle_foldarms2","london_civ_idle_lookbehind","london_civ_idle_foldarms_scratchass","london_civ_idle_scratchnose"];
	var_01 = ["civilian_sitting_business_lunch_a_1","civilian_sitting_business_lunch_b_1","civilian_sitting_talking_a_1","civilian_sitting_talking_a_2","civilian_sitting_talking_b_1","civilian_sitting_talking_b_2","civilian_texting_sitting","civilian_reader_1","sitting_guard_loadak_idle","guarda_sit_sleeper_idle","parabolic_leaning_guy_idle","civilian_stand_idle","det_camp_box_seated_civ_guy01","det_camp_box_seated_civ_guy02","det_camp_box_seated_civ_guy02","sitting_guard_loadak_idle","civilian_reader_2"];
	var_02 = getentarray("civ_life_scene_01","targetname");
	var_03 = getentarray("civ_life_scene_02","targetname");
	var_04 = common_scripts\utility::getstructarray("civ_life_scene_01","targetname");
	var_05 = common_scripts\utility::getstructarray("civ_life_scene_02","targetname");
	var_06 = common_scripts\utility::array_combine(var_04,var_05);
	var_07 = getentarray("spawner_civs_food_herd_01","targetname");
	var_08 = getentarray("civ_life_scene_01_orgs","targetname");
	var_06 = common_scripts\utility::array_combine(var_06,var_08);
	level.section_1_civilians = [];
	level.tent_scene_civilians_01 = [];
	level.tent_scene_civilians_02 = [];
	foreach(var_0A in var_06)
	{
		var_0B = common_scripts\utility::random(var_07) spawndrone();
		var_0B.animname = "drone_civs";
		var_0B maps\_anim::setanimtree();
		var_0B.origin = var_0A.origin;
		var_0B.angles = var_0A.angles;
		var_0B thread delete_me_on_notify();
		level.section_1_civilians[level.section_1_civilians.size] = var_0B;
		if(isdefined(var_0A.script_noteworthy) && var_0A.script_noteworthy == "civ_sitting")
		{
			var_0A thread maps\_shg_design_tools::anim_simple(var_0B,common_scripts\utility::random(var_01));
			continue;
		}

		var_0A thread maps\_shg_design_tools::anim_simple(var_0B,common_scripts\utility::random(var_00));
	}

	var_0D = common_scripts\utility::getstructarray("civ_tent_scene_01","targetname");
	var_0E = common_scripts\utility::getstructarray("civ_tent_scene_02","targetname");
	foreach(var_0A in var_0E)
	{
		var_0B = common_scripts\utility::random(var_07) spawndrone();
		var_0B.animname = "drone_civs";
		var_0B maps\_anim::setanimtree();
		var_0B.origin = var_0A.origin;
		var_0B.angles = var_0A.angles;
		var_0B thread delete_me_on_notify();
		level.tent_scene_civilians_02[level.tent_scene_civilians_02.size] = var_0B;
		if(var_0A.animation == "civilian_smoking_b" || var_0A.animation == "civilian_smoking_a")
		{
			var_0B attach("prop_cigarette","tag_inhand",1);
			var_0A thread maps\_shg_design_tools::anim_simple(var_0B,var_0A.animation);
			continue;
		}

		var_0A thread maps\_shg_design_tools::anim_simple(var_0B,var_0A.animation);
	}

	while(!common_scripts\utility::flag("flag_camp_visibility_04"))
	{
		foreach(var_0A in var_0D)
		{
			var_0B = common_scripts\utility::random(var_07) spawndrone();
			var_0B.animname = "drone_civs";
			var_0B maps\_anim::setanimtree();
			var_0B.origin = var_0A.origin;
			var_0B.angles = var_0A.angles;
			var_0B thread delete_me_on_notify();
			level.tent_scene_civilians_01[level.tent_scene_civilians_01.size] = var_0B;
			if(var_0A.animation == "civilian_smoking_b" || var_0A.animation == "civilian_smoking_a")
			{
				var_0B attach("prop_cigarette","tag_inhand",1);
				var_0A thread maps\_shg_design_tools::anim_simple(var_0B,var_0A.animation);
				continue;
			}

			var_0A thread maps\_shg_design_tools::anim_simple(var_0B,var_0A.animation);
		}

		common_scripts\utility::flag_wait("flag_camp_visibility_03b");
		common_scripts\utility::flag_clear("flag_camp_visibility_03a");
		common_scripts\utility::array_thread(level.tent_scene_civilians_01,::maps\_shg_design_tools::delete_auto);
		common_scripts\utility::flag_wait("flag_camp_visibility_03a");
		common_scripts\utility::flag_clear("flag_camp_visibility_03b");
		wait(0.2);
	}

	common_scripts\utility::array_thread(level.section_1_civilians,::maps\_shg_design_tools::delete_auto);
	common_scripts\utility::array_thread(level.tent_scene_civilians_01,::maps\_shg_design_tools::delete_auto);
	common_scripts\utility::array_thread(level.tent_scene_civilians_02,::maps\_shg_design_tools::delete_auto);
}

//Function Number: 54
delete_me_on_notify()
{
	common_scripts\utility::flag_wait("begin_player_mount_bike");
	if(isdefined(self))
	{
		self stopanimscripted();
		self delete();
	}
}

//Function Number: 55
setup_food_line_and_guards()
{
	common_scripts\utility::flag_wait("level_intro_cinematic_complete");
	level endon("flag_camp_visibility_04");
	var_00 = getentarray("spawner_civs_food_herd_01","targetname");
	common_scripts\utility::array_thread(var_00,::looping_civilian_path_foodwalkers);
	wait(randomfloatrange(10,15));
	common_scripts\utility::array_thread(var_00,::looping_civilian_path_foodwalkers);
	wait(randomfloatrange(10,15));
	common_scripts\utility::array_thread(var_00,::looping_civilian_path_foodwalkers);
}

//Function Number: 56
looping_civilian_path_foodwalkers()
{
	level endon("flag_camp_visibility_04");
	var_00 = ["civ_team1","civ_team2","civ_team3","civ_team4","civ_team5","civ_team6","civ_team7","civ_team8","civ_team9"];
	for(;;)
	{
		var_01 = common_scripts\utility::random(maps\_utility::getgenericanim("depressed_walk"));
		wait(randomfloatrange(5,10));
		var_02 = maps\_utility::dronespawn(self);
		thread setup_civ_animations(var_02,var_01);
		if(!isdefined(var_02.target))
		{
			var_02 delete();
			continue;
		}

		var_02.team = common_scripts\utility::random(var_00);
		var_02 waittill("goal");
		var_02 delete();
	}
}

//Function Number: 57
setup_civ_animations(param_00,param_01)
{
	if(isdefined(param_00))
	{
		param_00.animname = "generic";
		param_00.runanim = param_01;
	}
}

//Function Number: 58
set_refugee_camp_walk_anims()
{
	maps\_utility::set_run_anim("refugee_camp_walk_fast");
	maps\_utility::set_idle_anim("refugee_camp_idle");
	self.old_turnrate = self.turnrate;
	self.turnrate = 0.05;
	self orientmode("face motion");
	self.usepathsmoothingvalues = 1;
	self.maxturnspeed = 3;
	self.old_pathlookaheaddist = self.pathlookaheaddist;
	self.pathlookaheaddist = 160;
	self.sharpturn = 0.2;
	self.stand_to_run_overrideanim = maps\_utility::getanim("refugee_camp_idle_to_walk");
	self notify("move_loop_restart");
	self allowedstances("stand");
	self.disablearrivals = 1;
	self.disableexits = 1;
	thread clear_refugee_camp_walk_anims();
}

//Function Number: 59
clear_refugee_camp_walk_anims()
{
	common_scripts\utility::flag_wait("refugee_camp_cleanup");
	self.usepathsmoothingvalues = 0;
	self.old_disablearrivals = undefined;
	self.pathlookaheaddist = self.old_pathlookaheaddist;
	self.old_pathlookaheaddist = undefined;
	self.disablearrivals = 0;
	self.disableexits = 0;
	self allowedstances("stand","crouch","prone");
}

//Function Number: 60
setup_civs_walkers()
{
	maps\_utility::trigger_wait_targetname("spawn_walking_civs");
	var_00 = getent("walker","targetname");
	var_01 = var_00 maps\_utility::spawn_ai(1);
	wait(5);
}

//Function Number: 61
security_triggers()
{
	thread sec_trig1();
	thread sec_trig2();
	thread sec_trig3();
	thread sec_trig4();
}

//Function Number: 62
sec_trig1()
{
	maps\_utility::trigger_wait_targetname("invalid_1");
}

//Function Number: 63
sec_trig2()
{
	maps\_utility::trigger_wait_targetname("invalid_2");
}

//Function Number: 64
sec_trig3()
{
	maps\_utility::trigger_wait_targetname("access_granted");
}

//Function Number: 65
sec_trig4()
{
}

//Function Number: 66
tv_movie()
{
	common_scripts\utility::array_call(getentarray("propaganda_screens_static","targetname"),::hide);
	setsaveddvar("cg_cinematicFullScreen","0");
	cinematicingameloop("detroit_stage_display");
	common_scripts\utility::flag_wait("flag_camp_visibility_04");
	stopcinematicingame();
	common_scripts\utility::array_call(getentarray("propaganda_screens","targetname"),::delete);
	common_scripts\utility::array_call(getentarray("propaganda_screens_static","targetname"),::show);
}

//Function Number: 67
debug_start_bike_ride_in()
{
	var_00 = getent("player_bike_node","targetname");
	wait(0.05);
	level.player maps\_utility::teleport_player(var_00);
}

//Function Number: 68
opening_start()
{
	thread delay_show_bones();
	common_scripts\utility::flag_set("level_intro_cinematic_complete_real");
	thread opening_start_fov_changes();
	soundscripts\_snd::snd_message("opening_start");
	var_00 = getdvarint("g_friendlyNameDist");
	setsaveddvar("compass","0");
	setsaveddvar("ammoCounterHide","1");
	setsaveddvar("hud_showstance","0");
	setsaveddvar("actionSlotsHide","1");
	setsaveddvar("g_friendlyNameDist",0);
	common_scripts\utility::flag_wait("level_name_intro_done");
	level.player allowjump(0);
	var_01 = maps\_utility::spawn_anim_model("world_body");
	level.player maps\_shg_utility::setup_player_for_scene();
	thread player_ads_disable_manager();
	level.player playerlinktodelta(var_01,"tag_player",1,0,0,0,0,1);
	var_02 = getent("burke_level_intro_animnode","targetname");
	var_03 = maps\_utility::spawn_anim_model("warbird_int");
	var_04 = maps\_utility::spawn_anim_model("warbird_ext");
	thread maps\detroit_fx::waribird_intro_vfx(var_04);
	var_05 = getent("reflection_golden_bottom","targetname");
	var_06 = getent("reflection_dark_bottom","targetname");
	var_07 = getent("reflection_dark_bottom2","targetname");
	var_08 = getent("reflection_white_bottom","targetname");
	var_03 overridereflectionprobe(var_06.origin);
	var_04 overridereflectionprobe(var_05.origin);
	playfxontag(common_scripts\utility::getfx("light_wingtip_red_med_point"),var_04,"TAG_light_L_wing");
	playfxontag(common_scripts\utility::getfx("light_wingtip_red_med_point"),var_04,"TAG_light_R_wing");
	playfxontag(common_scripts\utility::getfx("light_wingtip_red_med_point"),var_04,"TAG_light_tail");
	common_scripts\utility::flag_set("vo_refugee_camp_intro");
	var_09 = getent("intro_guy1","targetname");
	var_0A = getent("intro_guy2","targetname");
	var_0B = getent("intro_guy3","targetname");
	var_0C = var_09 maps\_utility::spawn_ai(1);
	var_0D = var_0A maps\_utility::spawn_ai(1);
	var_0E = var_0B maps\_utility::spawn_ai(1);
	if(level.nextgen)
	{
		var_0C overridereflectionprobe(var_07.origin);
		var_0D overridereflectionprobe(var_07.origin);
	}

	var_0C.animname = "intro_guy1";
	var_0D.animname = "intro_guy2";
	var_0E.animname = "intro_guy3";
	soundscripts\_snd::snd_message("level_intro_cinematic",var_04);
	var_03 common_scripts\utility::delaycall(9,::delete);
	var_0C common_scripts\utility::delaycall(9,::delete);
	var_0D common_scripts\utility::delaycall(9,::delete);
	thread play_jump_out_of_heli_rumble();
	var_02 thread maps\_anim::anim_single_run([level.burke],"level_intro_cinematic");
	var_02 thread maps\_anim::anim_single_run([level.joker],"level_intro_cinematic");
	var_02 maps\_anim::anim_single_run([var_03,var_04,var_01,var_0C,var_0D,var_0E],"level_intro_cinematic");
	common_scripts\utility::flag_set("level_intro_cinematic_complete");
	var_0E thread guard_the_gate(var_02);
	var_01 delete();
	level.player unlink();
	level notify("end_burke_intro_talk");
	common_scripts\utility::flag_set("intro_animation_completed_now");
	level.player maps\_shg_utility::setup_player_for_gameplay();
	maps\_utility::delaythread(2,::maps\_utility::center_screen_text,&"DETROIT_FOUR_YEARS_LATER");
	maps\_utility::delaythread(2,::common_scripts\utility::flag_set,"begin_objectives");
	level.player allowprone(0);
	level.player takeallweapons();
	level.player giveweapon("iw5_bal27down_sp_silencer01_variablereddot");
	level.player switchtoweapon("iw5_bal27down_sp_silencer01_variablereddot");
	level.player allowfire(0);
	level.player allowmelee(0);
	level.player allowsprint(0);
	level.player disableoffhandweapons();
	level.player maps\_player_exo::unsetboostdash();
	setsaveddvar("r_hudOutlineEnable",0);
	setsaveddvar("compass","1");
	setsaveddvar("hud_showstance","1");
	setsaveddvar("actionSlotsHide","0");
	setsaveddvar("g_friendlyNameDist",var_00);
	common_scripts\utility::flag_set("obj_acquire_bikes_give");
	thread refugee_walk();
	wait(0.05);
	var_04 delete();
	wait(9.25);
	common_scripts\utility::flag_set("vo_refugee_camp_meet_joker");
}

//Function Number: 69
play_jump_out_of_heli_rumble()
{
	wait(3.92);
	level.player playrumbleonentity("damage_light");
}

//Function Number: 70
guard_the_gate(param_00)
{
	param_00 thread maps\_anim::anim_loop_solo(self,"post_level_intro_cinematic_idle");
	level waittill("player_has_used_bike");
	param_00 notify("stop_loop");
	self delete();
}

//Function Number: 71
opening_start_fov_changes()
{
	level waittill("opening_fovchange");
	level.player lerpfov(65,1);
}

//Function Number: 72
setup_refugee_camp_soldiers_group_1()
{
	var_00 = getent("refugee_soldier_spawner","targetname");
	var_01 = getentarray("refugee_vignette_soldier_loop_01","targetname");
	while(!common_scripts\utility::flag("flag_camp_visibility_04"))
	{
		var_02 = [];
		foreach(var_04 in var_01)
		{
			var_00.count = 1;
			var_05 = var_00 maps\_utility::spawn_ai(1);
			var_02[var_02.size] = var_05;
			var_05 maps\_utility::deletable_magic_bullet_shield();
			if(var_04.animation != "casual_stand_idle")
			{
				var_04 thread maps\_shg_design_tools::anim_simple(var_05,var_04.animation);
			}
			else
			{
				var_05.origin = var_04.origin;
				var_05.angles = var_04.angles;
				if(maps\_utility::s1_motionset_avaliable())
				{
					var_05 maps\_drone::drone_set_archetype_idle("s1_soldier");
				}
				else
				{
					var_05 maps\_drone::drone_set_archetype_idle("soldier");
				}
			}

			wait(0.05);
		}

		common_scripts\utility::flag_wait("flag_camp_visibility_03b");
		common_scripts\utility::array_call(var_02,::delete);
		common_scripts\utility::flag_clear("flag_camp_visibility_03a");
		common_scripts\utility::flag_wait("flag_camp_visibility_03a");
		common_scripts\utility::flag_clear("flag_camp_visibility_03b");
	}
}

//Function Number: 73
player_bike_shutoff(param_00)
{
	common_scripts\utility::flag_wait("shutoff_player_bike");
	level.player takeallweapons();
	param_00 notify("stop_jetbike_handle_viewmodel_anims");
	param_00 vehicle_jetbikesethoverforcescale(0);
	level.player giveweapon("iw5_bal27_sp_silencer01_variablereddot");
	level.player switchtoweapon("iw5_bal27_sp_silencer01_variablereddot");
	level.player allowfire(1);
	level.player allowmelee(1);
	level.player allowdodge(1);
	setsaveddvar("r_hudOutlineEnable",1);
}

//Function Number: 74
player_bike_lower()
{
	level endon("stop_lowering_bike");
	level endon("time to raise bike up");
	maps\_utility::trigger_wait_targetname("enter_garage");
	for(;;)
	{
		level.player_hover_height = 0.6;
		wait(0.05);
	}
}

//Function Number: 75
mechs_motorpool_animation()
{
	var_00 = getent("scanner_intro_anim_node","targetname");
	maps\_shg_design_tools::waittill_trigger_with_name("access_granted");
	if(level.currentgen)
	{
		thread transient_intro_to_middle_begin();
		for(;;)
		{
			if(istransientloaded("detroit_gatetrans_tr"))
			{
				break;
			}

			wait(0.5);
		}
	}

	common_scripts\utility::flag_wait("everone_motorpool_animate");
	var_01 = [level.mech1,level.mech2];
	var_00 thread maps\_anim::anim_single(var_01,"hoverbike_meet_up");
}

//Function Number: 76
ai_motorpool_animation()
{
	var_00 = getent("scanner_intro_anim_node","targetname");
	var_01 = getent("detroit_entrance_gate","targetname");
	var_01.animname = "entrance_gate";
	var_01 maps\_anim::setanimtree();
	var_02 = [level.bones,level.joker,level.burke,var_01];
	var_03 = [level.burke_bike,level.joker_bike,level.bones_bike];
	common_scripts\utility::flag_wait("everone_motorpool_animate");
	var_00 thread maps\_anim::anim_single_solo(var_01,"hoverbike_meet_up");
}

//Function Number: 77
setup_refugee_camp_soldiers()
{
	maps\_drone_ai::init();
	if(level.nextgen)
	{
		thread setup_refugee_stage_speaker();
	}
	else
	{
		thread maps\detroit_transients_cg::cg_setup_refugee_stage_speaker();
	}

	thread setup_refugee_camp_soldiers_group_1();
	var_00 = getent("refugee_soldier_spawner","targetname");
	common_scripts\utility::flag_wait("flag_camp_visibility_01");
	var_01 = [];
	var_02 = getentarray("refugee_vignette_soldier_loop_02","targetname");
	foreach(var_04 in var_02)
	{
		var_00.count = 1;
		var_05 = var_00 maps\_utility::spawn_ai(1);
		var_05.friendname = "soldier 2";
		var_01[var_01.size] = var_05;
		var_05 maps\_utility::deletable_magic_bullet_shield();
		var_04 thread maps\_shg_design_tools::anim_simple(var_05,var_04.animation);
		wait(0.05);
	}

	common_scripts\utility::flag_wait("flag_camp_visibility_02");
	var_07 = [];
	var_02 = getentarray("refugee_vignette_soldier_loop_03","targetname");
	foreach(var_04 in var_02)
	{
		var_00.count = 1;
		var_05 = var_00 maps\_utility::spawn_ai(1);
		var_07[var_07.size] = var_05;
		var_05 maps\_utility::deletable_magic_bullet_shield();
		var_04 thread maps\_shg_design_tools::anim_simple(var_05,var_04.animation);
		wait(0.05);
	}

	if(level.currentgen)
	{
		var_0A = [];
		var_02 = getentarray("refugee_vignette_soldier_loop_03_pre_scanners","targetname");
		foreach(var_04 in var_02)
		{
			var_00.count = 1;
			var_05 = var_00 maps\_utility::spawn_ai(1);
			var_05 maps\_utility::deletable_magic_bullet_shield();
			var_04 thread maps\_shg_design_tools::anim_simple(var_05,var_04.animation);
			thread maps\detroit_transients_cg::cg_kill_entity_on_flag(var_05,"flag_camp_visibility_04");
			wait(0.05);
		}
	}

	common_scripts\utility::flag_wait("flag_camp_visibility_04");
	var_0D = [];
	var_02 = getentarray("refugee_vignette_soldier_loop_04","targetname");
	foreach(var_04 in var_02)
	{
		var_00.count = 1;
		var_05 = var_00 maps\_utility::spawn_ai(1);
		var_0D[var_0D.size] = var_05;
		var_05 maps\_utility::deletable_magic_bullet_shield();
		var_04 thread maps\_shg_design_tools::anim_simple(var_05,var_04.animation);
		wait(0.05);
	}

	common_scripts\utility::array_call(var_01,::delete);
	common_scripts\utility::flag_wait("refugee_camp_cleanup");
	common_scripts\utility::array_call(var_07,::delete);
	common_scripts\utility::flag_wait("open_massive_door");
	common_scripts\utility::array_call(var_0D,::delete);
}

//Function Number: 78
setup_refugee_stage_speaker()
{
	common_scripts\utility::flag_wait("flag_stage_dialogue_start_audio");
	var_00 = getent("refugee_stage_speaker","targetname") maps\_utility::dronespawn();
	var_00.animname = "Atlas_Commander";
	var_00.runanim = level.scr_anim[var_00.animname]["det_camp_stagespeech_walk"];
	var_01 = getent("org_stage_speaker","targetname");
	var_01 maps\_anim::anim_single_solo(var_00,"det_camp_stagespeech_guy01");
	var_00.target = "stage_talker_exit";
	var_00.moveplaybackrate = 1;
	var_00 thread maps\_drone::drone_move();
}

//Function Number: 79
setup_refugee_stage_audience()
{
	common_scripts\utility::flag_wait("flag_camp_visibility_01");
	var_00 = [];
	var_01 = getentarray("civilian_orgs_sitting","targetname");
	var_02 = getentarray("civilian_spawner","targetname");
	foreach(var_04 in var_01)
	{
		if(maps\_shg_design_tools::percentchance(30))
		{
			var_05 = common_scripts\utility::random(var_02);
			var_05.count = 1;
			var_06 = maps\_utility::dronespawn(var_05);
			var_04 thread maps\_shg_design_tools::anim_simple(var_06,var_04.animation);
			var_00[var_00.size] = var_06;
			level.refugee_camp_ai[level.refugee_camp_ai.size] = var_06;
		}

		wait(randomfloat(0.25));
	}

	common_scripts\utility::flag_wait("flag_camp_visibility_04");
	common_scripts\utility::array_call(var_00,::delete);
}

//Function Number: 80
sighting_think(param_00)
{
	var_01 = common_scripts\utility::spawn_tag_origin();
	target_set(var_01);
	target_hidefromplayer(var_01,level.player);
	param_00.count = 1;
	var_02 = param_00 maps\_utility::spawn_ai(1);
	if(!isdefined(var_02))
	{
		return;
	}

	var_02.ignoreall = 1;
	var_02.animname = "generic";
	var_02 teleport(self.origin,self.angles);
	var_02 thread maps\_anim::anim_generic_first_frame(var_02,self.animation);
	var_01.origin = var_02 gettagorigin("tag_eye");
	while(isdefined(var_02))
	{
		if(target_isincircle(var_01,level.player,65,100) && bullettracepassed(level.player geteye(),var_02 geteye(),0,var_02))
		{
			break;
		}

		wait 0.05;
	}

	if(isdefined(var_02))
	{
		var_02 maps\_anim::anim_generic(var_02,self.animation);
		var_02 delete();
	}

	var_01 delete();
}

//Function Number: 81
debug_vehicle_node()
{
	for(;;)
	{
		self waittill("trigger");
		thread draw_vehicle_node_triggered();
	}
}

//Function Number: 82
draw_vehicle_node_triggered()
{
	for(var_00 = 0;var_00 < 20;var_00++)
	{
		wait 0.05;
	}
}

//Function Number: 83
debug_tag(param_00,param_01,param_02,param_03)
{
	thread debug_tag_internal(param_00,param_01,param_02,param_03);
}

//Function Number: 84
debug_tag_internal(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = param_01;
	}

	if(!isdefined(param_03))
	{
		param_03 = 10;
	}

	param_00 endon("death");
	for(;;)
	{
		var_04 = param_00 gettagorigin(param_01);
		var_05 = param_00 gettagangles(param_01);
		wait 0.05;
	}
}

//Function Number: 85
handle_ambient_cleanup_vehicles()
{
	wait(1);
	var_00 = getent("spawner_ambient_car_guys","targetname");
	var_01 = getent("ambient_cleanup_vehicle_01","targetname");
	var_02 = 3;
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = var_00 maps\_shg_design_tools::actual_spawn();
		var_04.ignoreall = 1;
		thread maps\_utility::guy_runtovehicle_load(var_04,var_01);
		var_04 thread turn_self_into_level_notify("enteredvehicle");
		wait(1.5);
	}

	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		level waittill("enteredvehicle");
	}

	wait(1);
	var_01 maps\_vehicle::gopath();
	level waittill("stop_busses");
}

//Function Number: 86
turn_self_into_level_notify(param_00)
{
	self waittill(param_00);
	level notify(param_00);
}

//Function Number: 87
handle_name_identifiers_intro_drive()
{
	var_00 = getdvarint("g_friendlyNameDist");
	setsaveddvar("g_friendlyNameDist",0);
	common_scripts\utility::flag_wait("obj_check_school_give");
	setsaveddvar("g_friendlyNameDist",var_00);
}

//Function Number: 88
handle_guage_textures_intro_drive()
{
	level waittill("intro_drive_on_button_pressed");
	level.player_bike vehicle_scripts\_jetbike::jetbike_speedometer_on();
	level waittill("intro_drive_off_button_pressed");
	level.player_bike vehicle_scripts\_jetbike::jetbike_speedometer_off();
}

//Function Number: 89
handle_guage_textures_intro_drive_newbike()
{
	level waittill("intro_drive_on_button_pressed");
	level.player_bikenew vehicle_scripts\_jetbike::jetbike_speedometer_on();
	level waittill("intro_drive_off_button_pressed");
	level.player_bikenew vehicle_scripts\_jetbike::jetbike_speedometer_off();
}

//Function Number: 90
notify_bike_hover(param_00)
{
	param_00 notify("powerup");
}

//Function Number: 91
notify_guy_mounted(param_00)
{
	param_00 notify("bike_mounted");
}

//Function Number: 92
joker_bones_bike_start(param_00)
{
	common_scripts\utility::flag_wait("flag_decon_ready_joker");
	var_01 = [level.joker_bike,level.bones_bike];
	param_00 thread maps\_anim::anim_single(var_01,"hoverbike_kickstand");
	thread joker_bike_idle_wait(param_00);
	thread bones_bike_idle_wait(param_00);
}

//Function Number: 93
joker_bike_idle_wait(param_00)
{
	level.joker_bike waittill("powerup");
	param_00 thread maps\_anim::anim_loop([level.joker_bike],"hoverbike_pre_mount","hoverbike_pre_mount_ender");
}

//Function Number: 94
bones_bike_idle_wait(param_00)
{
	level.bones_bike waittill("powerup");
	param_00 thread maps\_anim::anim_loop([level.bones_bike],"hoverbike_pre_mount","hoverbike_pre_mount_ender");
}

//Function Number: 95
setup_mechs()
{
	level.mech1 = getent("big_door_mech_spawner_left","targetname") maps\_shg_design_tools::actual_spawn();
	level.mech1.animname = "mech1";
	level.mech1.ignoreall = 1;
	level.mech1.ignoreme = 1;
	level.mech2 = getent("big_door_mech_spawner_right","targetname") maps\_shg_design_tools::actual_spawn();
	level.mech2.animname = "mech2";
	level.mech2.ignoreall = 1;
	level.mech2.ignoreme = 1;
	level.hoverbike_meet_up_mech1 = level.mech1;
	var_00 = getent("detroit_entrance_gate","targetname");
	var_00.animname = "entrance_gate";
	var_00 maps\_anim::setanimtree();
}

//Function Number: 96
setup_motorpool(param_00)
{
	var_01 = getent("scanner_intro_anim_node","targetname");
	var_02 = [];
	foreach(var_04 in ["burke_bike","joker_bike","bones_bike","player_bike"])
	{
		var_05 = getstartorigin(var_01.origin,var_01.angles,level.scr_anim[var_04]["hoverbike_pre_mount"][0]);
		var_06 = getstartangles(var_01.origin,var_01.angles,level.scr_anim[var_04]["hoverbike_pre_mount"][0]);
		var_07 = spawn("script_model",var_05);
		var_07.angles = var_06;
		var_07 setmodel("vehicle_mil_hoverbike_parked_static");
		var_02[var_02.size] = var_07;
	}

	common_scripts\utility::flag_wait("flag_camp_visibility_03");
	maps\detroit::spawn_bikes();
	foreach(var_0A in var_02)
	{
		var_0A delete();
	}

	level.player_bike_obj = spawn("script_model",(0,0,0));
	level.player_bike_obj.animname = level.player_bike.animname;
	level.player_bike_obj maps\_utility::assign_animtree();
	level.player_bike_obj setmodel("vehicle_mil_hoverbike_ai_obj");
	var_0C = [level.player_bike,level.burke_bike,level.joker_bike,level.bones_bike];
	var_0D = [level.player_bike_obj,level.player_bike,level.burke_bike];
	var_01 thread maps\_anim::anim_loop(var_0D,"hoverbike_pre_mount","hoverbike_pre_mount_ender");
	thread joker_bones_bike_start(var_01);
	level.player_bike showallparts();
	level.player_bike_obj hideallparts();
	common_scripts\utility::flag_wait("flag_scanner_doors_open");
	if(level.nextgen)
	{
	}

	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(param_00 == 0)
	{
		maps\_shg_design_tools::waittill_trigger_with_name("access_granted");
	}

	if(level.currentgen)
	{
		thread transient_intro_to_middle_begin();
		for(;;)
		{
			if(istransientloaded("detroit_gatetrans_tr"))
			{
				break;
			}

			wait(0.5);
		}
	}

	level.mech1 = getent("big_door_mech_spawner_left","targetname") maps\_shg_design_tools::actual_spawn();
	level.mech1.animname = "mech1";
	level.mech1.ignoreall = 1;
	level.mech1.ignoreme = 1;
	level.mech2 = getent("big_door_mech_spawner_right","targetname") maps\_shg_design_tools::actual_spawn();
	level.mech2.animname = "mech2";
	level.mech2.ignoreall = 1;
	level.mech2.ignoreme = 1;
	level.hoverbike_meet_up_mech1 = level.mech1;
	var_0E = getent("detroit_entrance_gate","targetname");
	var_0E.animname = "entrance_gate";
	var_0E maps\_anim::setanimtree();
	var_0F = [level.burke,level.bones,level.joker];
	var_10 = getent("use_hoverbike_opening_trigger","targetname");
	var_10 sethintstring(&"DETROIT_PROMPT_USE");
	var_11 = getent("use_hoverbike_opening_trigger","targetname") maps\_shg_utility::hint_button_trigger("use",200);
	if(level.start_point != "mount_bikes")
	{
		var_10 waittill("trigger");
	}

	thread play_doctor_pip();
	level notify("player_has_used_bike");
	common_scripts\utility::flag_set("begin_player_mount_bike");
	var_10 delete();
	var_11 maps\_shg_utility::hint_button_clear();
	objective_position(maps\_utility::obj("Follow Gideon"),(0,0,0));
	objective_setpointertextoverride(maps\_utility::obj("Follow Gideon"),&"DETROIT_FOLLOW");
	level.player maps\_shg_utility::setup_player_for_scene(1);
	common_scripts\utility::flag_set("vo_autopilot_engaged");
	common_scripts\utility::flag_set("refugee_camp_cleanup");
	common_scripts\utility::flag_set("security_checkpoint_cleanup");
	common_scripts\utility::flag_set("drivein_player_bike_used");
	common_scripts\utility::flag_set("obj_acquire_bikes_complete");
	if(level.nextgen)
	{
		level.burke_bike overridematerial("mtl_mil_hoverbike","m/mtl_mil_hoverbike_emissive");
		level.burke_bike overridematerial("m/mtl_mil_hoverbike_glass","m/mtl_mil_hoverbike_glass");
		level.joker_bike overridematerial("mtl_mil_hoverbike","m/mtl_mil_hoverbike_emissive");
		level.joker_bike overridematerial("m/mtl_mil_hoverbike_glass","m/mtl_mil_hoverbike_glass");
		level.bones_bike overridematerial("mtl_mil_hoverbike","m/mtl_mil_hoverbike_emissive");
		level.bones_bike overridematerial("m/mtl_mil_hoverbike_glass","m/mtl_mil_hoverbike_glass");
	}
	else
	{
		level.burke_bike overridematerial("mtl_mil_hoverbike","mq/mtl_mil_hoverbike_emissive");
		level.burke_bike overridematerial("mq/mtl_mil_hoverbike_glass","mq/mtl_mil_hoverbike_glass");
		level.joker_bike overridematerial("mtl_mil_hoverbike","mq/mtl_mil_hoverbike_emissive");
		level.joker_bike overridematerial("mq/mtl_mil_hoverbike_glass","mq/mtl_mil_hoverbike_glass");
		level.bones_bike overridematerial("mtl_mil_hoverbike","mq/mtl_mil_hoverbike_emissive");
		level.bones_bike overridematerial("mq/mtl_mil_hoverbike_glass","mq/mtl_mil_hoverbike_glass");
	}

	level.player_bike_obj delete();
	if(level.nextgen)
	{
		level.player_bike showallparts();
	}

	level.player takeallweapons();
	level.player giveweapon("iw5_bal27_sp_silencer01_variablereddot");
	level.player switchtoweapon("iw5_bal27_sp_silencer01_variablereddot");
	level.player allowfire(1);
	level.player allowmelee(1);
	level.player allowsprint(1);
	level.player maps\_player_exo::setboostdash();
	setsaveddvar("r_hudOutlineEnable",1);
	thread handle_name_identifiers_intro_drive();
	thread handle_guage_textures_intro_drive();
	thread maps\detroit_lighting::bike_mount_dof();
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbVelocityScalar","1");
	}

	level.player lerpfov(level.detroit_drive_in_fov,2);
	thread maps\detroit_lighting::gate_lights_on();
	level.player setmovespeedscale(1);
	level.player allowjump(1);
	var_12 = maps\_utility::spawn_anim_model("world_body",level.player.origin);
	if(isdefined(level.playerisonleft) && level.playerisonleft)
	{
		var_13 = "hoverbike_mount_left";
	}
	else
	{
		var_13 = "hoverbike_mount";
	}

	var_01 maps\_anim::anim_first_frame_solo(var_12,var_13);
	var_12 hide();
	var_14 = 0.5;
	level.player playerlinktoblend(var_12,"tag_player",var_14,var_14 * 0.3,var_14 * 0.3);
	wait(var_14);
	level.player playerlinktodelta(var_12,"tag_player",1,70,70,30,30,1);
	level.player springcamenabled(0,level.detroit_spring_cam_lerp_speed,level.detroit_spring_cam_release_speed);
	var_12 show();
	var_01 notify("hoverbike_pre_mount_ender");
	if(level.playerisonleft)
	{
		var_15 = [level.burke_bike,level.joker_bike,level.bones_bike,level.burke,level.joker,level.bones];
		soundscripts\_snd::snd_message("jetbike_intro","left_anim");
		level.player_bike thread hoverbike_rumble();
		var_01 thread maps\_anim::anim_single_solo(var_12,"hoverbike_mount_left");
		var_01 thread maps\_anim::anim_single_solo(level.player_bike,"hoverbike_mount_left");
		var_01 maps\_anim::anim_single(var_15,"hoverbike_mount",undefined,0.05);
	}
	else
	{
		var_15 = [level.player_bike,level.burke_bike,level.joker_bike,level.bones_bike,var_13,level.burke,level.joker,level.bones];
		soundscripts\_snd::snd_message("jetbike_intro","right_anim");
		level.player_bike thread hoverbike_rumble();
		var_01 maps\_anim::anim_single(var_15,"hoverbike_mount",undefined,0.05);
	}

	level.hoverbike_meet_up_mech1 = level.mech1;
	var_16 = [level.player_bike,level.burke_bike,level.joker_bike,level.bones_bike,var_12,level.burke,level.joker,level.bones,level.mech1,level.mech2,var_0E];
	thread maps\detroit_lighting::mech_intro_gate_lighting(level.mech2);
	level.ride_in_mech = level.mech1;
	foreach(var_0A in var_0C)
	{
		var_0A maps\_utility::delaythread(getanimlength(var_12 maps\_utility::getanim("hoverbike_meet_up")) - 0.35,::maps\_vehicle::gopath);
	}

	level.player_bike vehicle_jetbikesethoverforcescale(0.8);
	level.burke_bike vehicle_jetbikesethoverforcescale(1.1);
	level.bones_bike vehicle_jetbikesethoverforcescale(0.8);
	level.joker_bike vehicle_jetbikesethoverforcescale(0.5);
	common_scripts\utility::flag_set("vo_drive_in_mech_scene");
	var_01 maps\_anim::anim_single(var_16,"hoverbike_meet_up",undefined,0.05);
	level.player_bike setanim(level.player_bike maps\_utility::getanim("jetbike_casual_drive_idle"));
	level.player_bike.world_body = var_12;
	var_12 linkto(level.player_bike,"tag_driver",(0,0,0),(0,0,0));
	level.player_bike thread maps\_anim::anim_single_solo(var_12,"jetbike_casual_drive_idle","tag_driver");
	level.player_bike stopanimscripted();
	level.player_bike vehicle_jetbikesethoverforcescale(1,2);
	level.player_bike setanim(level.player_bike maps\_utility::getanim("jetbike_casual_drive_idle"));
	level.burke_bike thread intro_drive_scripted_bike_burke();
	level.bones_bike thread intro_drive_scripted_bike_bones();
	level.joker_bike thread intro_drive_scripted_bike_joker();
	level.mech1 delete();
	level.mech2 delete();
	maps\_utility::delaythread(2,::camera_rotator_begin);
	thread maps\detroit_school::play_garage_bike_dismount(level.burke_bike,level.bones_bike,level.joker_bike,level.player_bike);
}

//Function Number: 97
school_begin_onbike()
{
	maps\_utility::vision_set_fog_changes("detroit_garage",0);
	level.player lightsetforplayer("garage");
	level.player setclutforplayer("clut_detroit_exterior",0);
	level.player maps\_stealth_utility::stealth_default();
	maps\detroit::debug_start_common();
	maps\detroit_school::school_animated_fences();
	if(level.nextgen)
	{
		setsaveddvar("r_mbEnable","2");
		setsaveddvar("r_mbVelocityScalar","1");
	}

	var_00 = getent("player_jetbike","targetname");
	level.player_onbike = var_00 maps\_utility::spawn_vehicle();
	level.player_onbike.animname = "player_bike";
	var_01 = getent("bones_jetbike","targetname");
	level.bones_onbike = var_01 maps\_utility::spawn_vehicle();
	level.bones_onbike.animname = "bones_bike";
	var_02 = getent("joker_jetbike","targetname");
	level.joker_onbike = var_02 maps\_utility::spawn_vehicle();
	level.joker_onbike.animname = "joker_bike";
	var_03 = getent("burke_jetbike","targetname");
	level.burke_onbike = var_03 maps\_utility::spawn_vehicle();
	level.burke_onbike.animname = "burke_bike";
	var_04 = getent("actual_dismount_animation_origin","targetname");
	var_05 = [level.burke_onbike,level.player_onbike,level.bones_onbike,level.joker_onbike];
	var_04 maps\_anim::anim_first_frame(var_05,"bike_dismount");
	level.player_hover_height = 0.8;
	level.player_onbike stopanimscripted();
	level.player_onbike setmodel("vehicle_mil_hoverbike_vm");
	level.player_onbike vehicle_jetbikesethoverforcescale(level.player_hover_height);
	level.player_onbike attach(level.scr_model["world_body"],"tag_driver");
	level.player lerpfov(level.detroit_drive_in_fov,2);
	level.smooth_veh_play = 0;
	thread maps\detroit_school::play_garage_bike_dismount(level.burke_onbike,level.bones_onbike,level.joker_onbike,level.player_onbike);
	thread player_bike_shutoff(level.player_onbike);
	thread player_bike_lower();
	level.player_onbike detach(level.scr_model["world_body"],"tag_driver");
	common_scripts\utility::flag_set("begin_bike_dismount_burke");
	common_scripts\utility::flag_set("begin_bike_dismount_bones");
	common_scripts\utility::flag_set("begin_bike_dismount_joker");
	common_scripts\utility::flag_set("begin_playing_player_dismount_anim");
	common_scripts\utility::flag_wait("shutoff_player_bike");
	level notify("stop hovering player bike");
	level.player_onbike vehicle_jetbikesethoverforcescale(0);
	level.player_onbike notify("stop_jetbike_handle_viewmodel_anims");
}

//Function Number: 98
hint_hoverbike()
{
	maps\_utility::hint(&"DETROIT_JETBIKE_CONTROLS",4,-80);
}

//Function Number: 99
debug_tag_camera()
{
	wait 0.05;
}

//Function Number: 100
transient_hide_intro_vista_buildings()
{
	var_00 = getentarray("intro_vista_buildings","targetname");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] hide();
	}
}

//Function Number: 101
transient_intro_to_middle_begin()
{
	common_scripts\utility::flag_set("flag_cg_kill_camp_chopper_loop");
	var_00 = getentarray("cargo_chopper_01","targetname");
	var_01 = getentarray("refugee_camp_looping_choppers","targetname");
	var_00 = common_scripts\utility::array_combine(var_00,var_01);
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_00[var_02] delete();
	}

	thread transient_add_gatetrans_entry();
	level notify("tff_pre_intro_to_middle");
	level waittill("player_has_used_bike");
	for(var_02 = 0;var_02 < 35;var_02++)
	{
		wait(1);
	}

	unloadtransient("detroit_intro_tr");
	loadtransient("detroit_middle_tr");
	for(;;)
	{
		if(istransientloaded("detroit_middle_tr"))
		{
			level notify("tff_post_intro_to_middle");
			break;
		}

		wait(0.05);
	}
}

//Function Number: 102
transient_add_gatetrans_entry()
{
	if(!istransientloaded("detroit_gatetrans_tr"))
	{
		loadtransient("detroit_gatetrans_tr");
		for(;;)
		{
			if(istransientloaded("detroit_gatetrans_tr"))
			{
				level notify("tff_post_gatetrans_entry");
				break;
			}

			wait(0.05);
		}
	}
}

//Function Number: 103
camera_rotator_begin()
{
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00 thread camera_rotator_think(level.player_bike.world_body,level.joker_bike);
	wait 0.05;
	level.player playerlinktodelta(var_00,"tag_origin",1,50,50,30,30,1);
	level.player springcamenabled(0,level.detroit_spring_cam_lerp_speed,level.detroit_spring_cam_release_speed);
}

//Function Number: 104
smooth_limit(param_00,param_01)
{
	return atan(param_00 / param_01) * 0.01745329 * param_01;
}

//Function Number: 105
camera_rotator_think(param_00,param_01)
{
	var_02 = 0.8;
	var_03 = 45;
	var_04 = 0;
	var_05 = 1;
	var_06 = 0;
	while(isdefined(param_01) && isdefined(param_00) && isdefined(self))
	{
		var_07 = transformmove((0,0,0),(0,0,0),param_00.origin,param_00.angles,param_01.origin,param_01.angles)["origin"];
		var_08 = angleclamp180(vectortoangles(var_07)[1]);
		var_06 = maps\_utility::linear_interpolate(var_02,smooth_limit(var_08,var_03),var_06);
		if(common_scripts\utility::flag("begin_bike_dismount_player"))
		{
			var_05 = 0;
			var_04 = 0;
		}

		if(var_05)
		{
			var_09 = maps\_shg_utility::linear_map_clamp(var_04,0,5,0,1);
		}
		else
		{
			var_09 = maps\_shg_utility::linear_map_clamp(var_04,0,1,1,0);
		}

		self linkto(param_00,"tag_player",(0,0,0),(0,var_06 * var_09,0));
		var_04 = var_04 + 0.05;
		wait(0.05);
	}

	self delete();
}

//Function Number: 106
draw_trail(param_00,param_01)
{
	var_02 = 10;
	self endon("death");
	var_03 = self gettagorigin(param_00);
	for(;;)
	{
		waittillframeend;
		waittillframeend;
		thread common_scripts\utility::draw_line_for_time(var_03,self gettagorigin(param_00),param_01[0],param_01[1],param_01[2],var_02);
		var_03 = self gettagorigin(param_00);
		wait 0.05;
	}
}

//Function Number: 107
play_bike_gesture(param_00,param_01)
{
	var_02 = maps\_vehicle::vehicle_ai_event(param_00);
	if(isdefined(param_01))
	{
		wait(param_01);
		return;
	}

	var_02[0] waittill("anim_on_tag_done");
}

//Function Number: 108
intro_drive_scripted_bike_burke()
{
	intro_drive_start_scripted_bike(level.burke,level.burke_bike);
	level.burke_bike maps\detroit_jetbike::vehicle_rubberband(level.player_bike,780,0,4,6);
	thread intro_drive_scripted_bike_burke_gestures();
	wait(23);
	level.burke_bike maps\detroit_jetbike::vehicle_rubberband_set_desired_range(39);
}

//Function Number: 109
intro_drive_scripted_bike_burke_gestures()
{
	play_bike_gesture("hoverbike_driving_gesture_lft_2");
	wait(2);
	play_bike_gesture("hoverbike_driving_lean_right_into_2");
	play_bike_gesture("hoverbike_driving_lean_right_out_2");
	play_bike_gesture("hoverbike_driving_gesture_lft_2");
	wait(3.5);
	play_bike_gesture("hoverbike_driving_lean_right_into_2");
	play_bike_gesture("hoverbike_driving_lean_right_out_2");
	wait(3);
	level.burke maps\detroit_lighting::add_enemy_flashlight("flashlight","bright");
	level.burke maps\_utility::delaythread(8,::notify_method,"flashlight_off");
	play_bike_gesture("hoverbike_driving_flashlight_left_1");
	level.burke maps\_utility::gun_recall();
}

//Function Number: 110
notify_method(param_00)
{
	self notify(param_00);
}

//Function Number: 111
intro_drive_scripted_bike_bones()
{
	intro_drive_start_scripted_bike(level.bones,level.bones_bike);
	level.bones_bike maps\detroit_jetbike::vehicle_rubberband(level.player_bike,390,0,4,6);
	thread intro_drive_scripted_bike_bones_gestures();
	wait(23);
	level.bones_bike maps\detroit_jetbike::vehicle_rubberband_set_desired_range(-273);
}

//Function Number: 112
intro_drive_scripted_bike_bones_gestures()
{
	wait(1);
	play_bike_gesture("hoverbike_driving_look_over_lft_shoulder_1");
	play_bike_gesture("hoverbike_driving_look_over_rt_shoulder_1");
	play_bike_gesture("hoverbike_driving_lean_right_into_1");
	play_bike_gesture("hoverbike_driving_lean_right_out_1");
	play_bike_gesture("hoverbike_driving_gesture_rt_1");
	play_bike_gesture("hoverbike_driving_lean_right_into_1");
	play_bike_gesture("hoverbike_driving_lean_right_out_1");
	play_bike_gesture("hoverbike_driving_lean_left_into_1");
	play_bike_gesture("hoverbike_driving_lean_left_out_1");
	level.bones maps\_utility::gun_recall();
}

//Function Number: 113
intro_drive_scripted_bike_joker()
{
	intro_drive_start_scripted_bike(level.joker,level.joker_bike);
	level.joker_bike maps\detroit_jetbike::vehicle_rubberband(level.player_bike,585,0,4,6);
	thread intro_drive_scripted_bike_joker_gestures();
	wait(23);
	level.joker_bike maps\detroit_jetbike::vehicle_rubberband_set_desired_range(19.5);
}

//Function Number: 114
intro_drive_scripted_bike_joker_gestures()
{
	wait(5);
	level.joker maps\detroit_lighting::add_enemy_flashlight("flashlight","bright");
	level.joker maps\_utility::delaythread(8,::notify_method,"flashlight_off");
	play_bike_gesture("hoverbike_driving_flashlight_right_1");
	wait(4);
	play_bike_gesture("hoverbike_driving_lean_right_into_1");
	play_bike_gesture("hoverbike_driving_lean_right_out_1");
	wait(4);
	play_bike_gesture("hoverbike_driving_lean_right_into_1");
	play_bike_gesture("hoverbike_driving_lean_right_out_1");
	play_bike_gesture("hoverbike_driving_lean_right_into_1");
	play_bike_gesture("hoverbike_driving_lean_right_out_1");
	play_bike_gesture("hoverbike_driving_lean_left_into_1");
	play_bike_gesture("hoverbike_driving_lean_left_idle_1");
	play_bike_gesture("hoverbike_driving_lean_left_out_1");
	wait(10);
	level.joker maps\_utility::gun_recall();
}

//Function Number: 115
bike_reach_function(param_00,param_01)
{
	param_01 endon("hoverbike_pre_mount_ender");
	param_01 maps\_anim::anim_reach_solo(param_00,"hoverbike_pre_mount");
	if(param_00 == level.joker || param_00 == level.bones)
	{
		param_00 waittill("bike_mounted");
	}

	param_01 maps\_anim::anim_loop_solo(param_00,"hoverbike_pre_mount","hoverbike_pre_mount_ender");
}

//Function Number: 116
intro_drive_start_scripted_bike(param_00,param_01)
{
	param_01 stopanimscripted();
	param_01 vehicle_jetbikesethoverforcescale(1,3);
	param_00 stopanimscripted();
	param_01 maps\_utility::guy_enter_vehicle(param_00);
	param_01.dont_clear_vehicle_anim = 1;
	param_00 dontinterpolate();
}

//Function Number: 117
open_big_door()
{
	var_00 = getent("right_main_door","targetname");
	var_01 = getent("right_inner_door","targetname");
	var_02 = getent("left_main_door","targetname");
	var_03 = getent("left_inner_door","targetname");
	var_04 = getent("right_door_inner_org1","targetname");
	var_05 = getent("left_door_inner_org1","targetname");
	var_06 = getent("right_door_inner_org2","targetname");
	var_07 = getent("left_door_inner_org2","targetname");
	var_08 = getent("right_door_main_org1","targetname");
	var_09 = getent("left_door_main_org1","targetname");
	var_01 moveto(var_04.origin,2,0.75,1.25);
	var_03 moveto(var_05.origin,2,0.75,1.25);
	wait(2.05);
	var_01 moveto(var_06.origin,2,0.75,1.25);
	var_03 moveto(var_07.origin,2,0.75,1.25);
	var_00 moveto(var_08.origin,2,0.75,1.25);
	var_02 moveto(var_09.origin,2,0.75,1.25);
}

//Function Number: 118
setup_door_anim_leader(param_00,param_01,param_02,param_03)
{
	var_04 = [param_00,param_01,param_02,param_03];
	var_05 = getent(var_04[0],"targetname");
	var_05 thread maps\_anim::anim_generic_loop(self,var_05.animation);
	self.ignoreall = 1;
	maps\detroit::set_patrol_anim_set("gundown");
	maps\_shg_design_tools::waittill_trigger_with_name("open_radiation_doors_trigger");
	maps\_shg_design_tools::anim_stop(var_05);
	var_06 = getent(var_04[1],"targetname");
	var_06 maps\_anim::anim_generic_reach(self,var_06.animation);
	maps\_utility::set_moveplaybackrate(0.6);
	var_06 maps\_anim::anim_generic(self,var_06.animation);
	maps\_utility::set_moveplaybackrate(1);
	common_scripts\utility::flag_set("massive_door_guard_in_position");
	var_06 = getent(var_04[2],"targetname");
	var_06 maps\_anim::anim_generic_reach(self,var_06.animation);
	var_06 thread maps\_anim::anim_generic_loop(self,var_06.animation);
	level notify("finished_door_scan");
	maps\_shg_design_tools::anim_stop(var_06);
	var_06 = getent(var_04[3],"targetname");
	var_06 maps\_anim::anim_generic_reach(self,var_06.animation);
	var_06 maps\_anim::anim_generic(self,var_06.animation);
	thread maps\_anim::anim_generic_loop(self,"patrol_bored_idle_cellphone");
	wait(30);
	common_scripts\utility::flag_set("massive_door_cleanup");
}

//Function Number: 119
setup_door_anim(param_00,param_01,param_02,param_03)
{
	var_04 = [param_00,param_01,param_02,param_03];
	var_05 = getent(var_04[0],"targetname");
	var_05 thread maps\_anim::anim_generic_loop(self,var_05.animation);
	self.ignoreall = 1;
	maps\detroit::set_patrol_anim_set("gundown");
	maps\_shg_design_tools::waittill_trigger_with_name("open_radiation_doors_trigger");
	wait(randomfloat(3));
	maps\_shg_design_tools::anim_stop(var_05);
	var_06 = getent(var_04[1],"targetname");
	var_06 maps\_anim::anim_generic_reach(self,var_06.animation);
	var_06 thread maps\_anim::anim_generic_loop(self,var_06.animation);
	level waittill("finished_door_scan");
	wait(randomfloat(1));
	maps\_shg_design_tools::anim_stop(var_06);
	var_06 = getent(var_04[2],"targetname");
	var_06 maps\_anim::anim_generic_reach(self,var_06.animation);
	var_06 thread maps\_anim::anim_generic_loop(self,var_06.animation);
}

//Function Number: 120
ambient_dialogue_manager()
{
	thread atlas_guard_dialogue_line1();
	if(level.nextgen)
	{
		thread civ_conversation_gag1();
	}
	else
	{
		thread maps\detroit_transients_cg::cg_civ_conversation_gag1();
	}

	thread security_check_1_dialogue();
}

//Function Number: 121
security_check_1_dialogue()
{
	common_scripts\utility::flag_wait("flag_camp_visibility_03");
	var_00 = getent("org_security_gate_guards_dialogue","targetname");
	var_01 = getent("dialogue_guard_at_first_gate","targetname");
	var_02 = var_01 maps\_utility::spawn_ai(1);
	var_02.animname = "generic";
	var_00 thread maps\_shg_design_tools::anim_simple(var_02,var_00.animation);
	level.camp_security_greeter = var_02;
}

//Function Number: 122
player_dist_to_speaker(param_00)
{
	wait(0.1);
}

//Function Number: 123
civ_conversation_gag1()
{
	var_00 = getent("civilian_1_spawner","targetname");
	var_01 = getent("civilian_2_spawner","targetname");
	var_02 = getent("civilian_3_spawner","targetname");
	var_03 = getent("civilian_4_spawner","targetname");
	level.civ1 = var_00 spawndrone();
	level.civ1.animname = "drone_civs";
	level.civ1 maps\_anim::setanimtree();
	level.civ2 = var_01 spawndrone();
	level.civ2.animname = "drone_civs";
	level.civ2 maps\_anim::setanimtree();
	level.civ3 = var_02 spawndrone();
	level.civ3.animname = "drone_civs";
	level.civ3 maps\_anim::setanimtree();
	level.civ4 = var_03 spawndrone();
	level.civ4.animname = "drone_civs";
	level.civ4 maps\_anim::setanimtree();
	level.civ1 thread maps\_anim::anim_loop_solo(level.civ1,"sign1_spawner");
	level.civ2 thread maps\_anim::anim_loop_solo(level.civ2,"sign2_spawner");
	level.civ3 thread maps\_anim::anim_loop_solo(level.civ3,"sign3_spawner");
	level.civ4 thread maps\_anim::anim_loop_solo(level.civ4,"sign4_spawner");
	maps\detroit_school::continue_when_player_near_entity(level.civ1,250);
	common_scripts\utility::flag_set("vo_civ_convo_01");
	common_scripts\utility::flag_wait("flag_camp_visibility_04");
	level.civ1 delete();
	level.civ2 delete();
	level.civ3 delete();
	level.civ4 delete();
}

//Function Number: 124
atlas_guard_dialogue_line1()
{
	common_scripts\utility::flag_wait("flag_camp_visibility_01");
	var_00 = getent("atlas_guard_dialogue_line_spawner","targetname");
	var_01 = var_00 maps\_utility::spawn_ai(1);
	var_01.animname = "generic";
	var_02 = getent("refugee_vignette_soldier_loop_dialogue","targetname");
	var_01 thread guy_cig_manager();
	var_02 thread maps\_anim::anim_loop_solo(var_01,"patrol_bored_idle_smoke");
	maps\detroit_school::continue_when_player_near_entity(var_01,300);
	var_01 maps\_utility::dialogue_queue("detroit_atd_rememberonepacketpersector");
	common_scripts\utility::flag_wait("flag_camp_visibility_04");
	var_01 delete();
}

//Function Number: 125
guy_cig_manager()
{
	while(isalive(self))
	{
		level waittill("show special cig");
		self attach("prop_cigarette","tag_inhand",1);
		level waittill("hide special cig");
		self detach("prop_cigarette","tag_inhand");
	}
}

//Function Number: 126
buttress_function()
{
	var_00 = getent("butress1_origin","targetname");
	var_01 = getent("butress2_origin","targetname");
	var_02 = getent("butress3_origin","targetname");
	var_03 = getent("butress1","targetname");
	var_04 = getent("butress2","targetname");
	var_05 = getent("butress3","targetname");
	var_06 = getent("butress1_trigger","targetname");
	var_07 = getent("butress3_trigger","targetname");
	thread butress_animate(var_03,var_00,var_06);
	thread butress_animate(var_04,var_01,var_06);
	thread butress_animate(var_05,var_02,var_07);
}

//Function Number: 127
butress_animate(param_00,param_01,param_02)
{
	param_00.animname = "butress";
	param_00 maps\_anim::setanimtree();
	param_01 maps\_anim::anim_first_frame_solo(param_00,"close");
	maps\_utility::trigger_wait_targetname(param_02.targetname);
	param_01 soundscripts\_snd::snd_message("refugee_butress_down");
	param_01 thread maps\_anim::anim_single_solo(param_00,"close");
	maps\_anim::anim_set_rate_single(param_00,"close",0.5);
}

//Function Number: 128
disable_same_side_blocking()
{
	var_00 = getent("player_same_side_blocking","targetname");
	level waittill("scanner_doors_open");
	wait(3);
	var_00 notsolid();
}