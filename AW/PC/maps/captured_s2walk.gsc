/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: captured_s2walk.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 37
 * Decompile Time: 539 ms
 * Timestamp: 4/22/2024 2:26:32 AM
*******************************************************************/

//Function Number: 1
pre_load()
{
}

//Function Number: 2
post_load()
{
	common_scripts\utility::flag_init("flag_allow_punishment");
	common_scripts\utility::flag_init("flag_s2walk_start");
	common_scripts\utility::flag_init("flag_stop_mover");
	level._s2walk = spawnstruct();
	level._s2walk.ally_mover = [];
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
	if(issubstr(level.start_point,"s2walk"))
	{
		level.player maps\captured_util::warp_to_start("struct_playerstart_s2walk");
		spawn_player_prisoner_hands();
		soundscripts\_snd::snd_message("start_s2_walk");
		var_00 = getent("origin_scene_s1elevator","targetname");
		if(isdefined(var_00))
		{
			var_00 moveto(var_00.origin - (0,0,594),0.1);
			wait(0.2);
		}

		thread scene_intro_walk();
		return;
	}

	level.player maps\captured_util::warp_to_start("struct_playerstart_s2elevator");
	soundscripts\_snd::snd_message("start_s2_elevator");
}

//Function Number: 4
main_s2walk()
{
	wait(5.5);
	var_00 = getent("brush_elevator_s1s2_bottomgate","targetname");
	var_00 moveto(var_00.origin + (0,0,192),2);
	thread s2walk_ambient_character_cleanup();
	level.cover_warnings_disabled = undefined;
	level notify("s1_elevator_gate_open");
	soundscripts\_snd::snd_message("s2_elevator_door_open");
	soundscripts\_snd::snd_message("aud_s2walk_loudspeaker2_line1");
	var_01 = maps\_utility::array_spawn_noteworthy("actor_s2w_guards");
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_01[var_02] maps\captured_util::ignore_everything();
		var_01[var_02] maps\_utility::gun_remove();
		var_01[var_02].animname = "guard_" + var_02;
	}

	var_03 = common_scripts\utility::getstruct("struct_s2walk","targetname");
	var_03 thread maps\_anim::anim_loop(var_01,"s2walk_loop","s2walk_loop_ender");
	level waittill("s2walk_intro_end");
	soundscripts\_snd::snd_message("aud_s2walk_emitters");
	level.player thread maps\_utility::blend_movespeedscale(1,3);
	level.player thread player_walk();
	thread scene_walk(var_01,var_03);
	thread helicopter_flyby();
	thread maps\captured_util::captured_caravan_spawner("vehicle_s2_truck",13,4,10,"s2walk");
	soundscripts\_snd::snd_message("s2_prison_amb");
	soundscripts\_snd::snd_message("aud_s2walk_trigger_start");
	soundscripts\_snd::snd_message("s2_walk_vo_execution");
	common_scripts\utility::flag_set("flag_allow_punishment");
	common_scripts\utility::flag_wait("flag_s2walk_near_end");
	soundscripts\_snd::snd_message("aud_s2walk_loudspeaker2_line2");
	common_scripts\utility::flag_wait("flag_s2walk_end");
}

//Function Number: 5
s2walk_ambient_character_cleanup()
{
	var_00 = getent("s2_cell_prisoner_trigger_on","targetname");
	var_00 waittill("trigger");
	level notify("s2_killpoppingcharacters");
	var_00 = getent("s2_looping_cleanup_1","targetname");
	var_00 waittill("trigger");
	level notify("s2_looping_group_1");
	common_scripts\utility::flag_wait("flag_s2elevator_end");
	level notify("s2_looping_group_2");
}

//Function Number: 6
main_s2elevator()
{
	thread elevator_ride_s2s3();
	common_scripts\utility::flag_wait("flag_s2elevator_end");
}

//Function Number: 7
scene_intro_walk(param_00,param_01,param_02)
{
	var_03 = common_scripts\utility::getstruct("struct_scene_s2walkstart","targetname");
	var_04 = common_scripts\utility::getstruct("struct_s2walk","targetname");
	var_05 = getent("origin_scene_s1elevator","targetname");
	var_06 = level.allies;
	common_scripts\utility::array_thread(var_06,::maps\captured_util::ignore_everything);
	common_scripts\utility::array_thread(var_06,::maps\_utility::gun_remove);
	if(!isdefined(param_00))
	{
		param_00 = maps\_utility::array_spawn_noteworthy("actor_s2wintro_guards");
	}

	for(var_07 = 0;var_07 < param_00.size;var_07++)
	{
		param_00[var_07] maps\captured_util::ignore_everything();
		var_08 = var_07 + 1;
		param_00[var_07].animname = "guard_" + var_08;
		if(var_08 == 3)
		{
			param_00[var_07] maps\_utility::gun_remove();
		}
	}

	var_09 = [param_00[2]];
	var_0A = [param_00[0],param_00[1]];
	var_0B = [param_00[3],param_00[4]];
	thread maps\captured::dialogue_s2_elevator_open(param_00);
	var_03 thread maps\captured_anim::anim_single_to_loop(var_0A,"s2walk_intro_start_front","s2walk_wait_intro_loop_front","s2walk_front_guard_wait_loop");
	var_03 thread maps\captured_anim::anim_single_to_loop(var_0B,"s2walk_intro_start_back","s2walk_wait_intro_loop_back","s2walk_all_wait_loop_ender");
	var_03 maps\captured_anim::anim_single_to_loop(var_09,"s2walk_intro_start_third","s2walk_wait_intro_loop_thrid","s2walk_front_guard_wait_loop");
	level waittill("s1_elevator_gate_open");
	wait(3);
	level.player disableslowaim();
	level.player allowcrouch(0);
	level.player allowjump(0);
	level.player allowprone(0);
	level.player allowsprint(0);
	player_hands_idle_start();
	level.player thread maps\_utility::blend_movespeedscale(0.015);
	level.player thread maps\_utility::blend_movespeedscale(0.3,20);
	level.player unlink();
	if(isdefined(param_01))
	{
		param_01 delete();
	}

	if(isdefined(param_02))
	{
		param_02 delete();
	}

	var_0C = getent("s2walk_elevator_exit_collision","targetname");
	var_0C delete();
	common_scripts\utility::flag_wait("flag_s2walk_start");
	level thread s2walk_player_push(var_03,var_09,param_00);
	var_03 thread maps\_anim::anim_single(var_0A,"s2walk_intro_grab");
	level waittill("s2walk_start_walking");
	level notify("s2walk_intro_end");
	var_03 notify("s2walk_all_wait_loop_ender");
	var_05 notify("s2walk_all_wait_loop_ender");
}

//Function Number: 8
s2walk_player_push(param_00,param_01,param_02)
{
	param_00 notify("s2walk_front_guard_wait_loop");
	if(isdefined(level.player.rig))
	{
		player_hands_idle_stop(1);
	}

	var_03 = maps\_utility::spawn_anim_model("player_rig_noexo");
	var_04 = var_03 thread maps\captured_util::captured_player_cuffs();
	var_04 hide();
	var_03 hide();
	var_05 = common_scripts\utility::array_add(param_01,var_03);
	param_00 thread maps\_anim::anim_single(var_05,"s2walk_intro_grab");
	level.player common_scripts\utility::delaycall(3.85,::playrumbleonentity,"heavy_1s");
	level.player playerlinktoblend(var_03,"tag_player",0.5);
	wait(0.5);
	var_04 show();
	var_03 show();
	level.player playerlinktodelta(var_03,"tag_player",1,0,0,0,0,1);
	wait(getanimlength(var_03 maps\_utility::getanim("s2walk_intro_grab")) - 0.5);
	var_03 delete();
	var_04 delete();
	player_hands_idle_start();
	level waittill("s2_looping_group_1");
	maps\_utility::array_delete(param_02);
}

//Function Number: 9
scene_walk(param_00,param_01)
{
	var_02 = level.allies;
	var_03 = undefined;
	var_04 = undefined;
	level.player thread maps\_utility::blend_movespeedscale(1,1);
	var_05 = getent("s2elevator_trolley_intro_guard","script_noteworthy");
	if(isdefined(var_05))
	{
		var_03 = var_05 maps\_utility::spawn_ai(1);
		var_03 maps\captured_util::ignore_everything();
		var_03.animname = "guard_3";
		var_04 = common_scripts\utility::getstruct("struct_scene_s2elevator","targetname");
		var_04 thread maps\_anim::anim_loop_solo(var_03,"s2walk_intro_trolley_loop","s2walk_intro_trolley_loop_ender");
		thread trolley_doors_function();
	}

	var_06 = getent("s2elevator_trolley_intro_guard_end","script_noteworthy");
	var_07 = var_06 maps\_utility::spawn_ai(1);
	var_07 maps\captured_util::ignore_everything();
	var_07 maps\_utility::gun_remove();
	var_07.animname = "guard_end";
	thread maps\captured::dialogue_s2_walk(param_00,var_07,var_03);
	param_01 notify("s2walk_loop_ender");
	var_08 = common_scripts\utility::array_combine(var_02,param_00);
	var_08 = common_scripts\utility::array_add(var_08,var_07);
	var_08 = common_scripts\utility::array_add(var_08,level.player._walk.walk_node);
	soundscripts\_snd::snd_message("s2_elevator_door_close");
	soundscripts\_snd::snd_message("aud_s2walk_guard_radios");
	soundscripts\_snd::snd_message("aud_s2walk_temp_guard_VO",param_00[0]);
	var_09 = common_scripts\utility::spawn_tag_origin();
	var_0A = common_scripts\utility::spawn_tag_origin();
	var_09 thread set_origin_per_time(var_02[1],var_02[2],0.05);
	var_0A thread set_origin_per_time(var_02[0],param_00[1],0.05);
	param_01 thread maps\_anim::anim_single(var_08,"s2walk");
	thread s2walk_cage_door_open();
	var_0B = getanimlength(var_07 maps\_utility::getanim("s2walk"));
	thread s2walk_guard_end_cleanup(var_0B,var_07);
	param_00 = common_scripts\utility::array_remove(param_00,var_07);
	s2elevator_trolley_intro_scene(param_00,var_03,var_04);
	var_09 delete();
	var_0A delete();
}

//Function Number: 10
s2walk_cage_door_open()
{
	var_00 = getent("s2walk_cage_door","targetname");
	wait(14.5);
	var_00 soundscripts\_snd::snd_message("aud_s2walk_door_open");
	var_00 rotateto((0,285,0),2,1,0.25);
	wait(16.5);
	var_00 rotateto((0,-285,0),2,1,0.25);
	level waittill("trolley_player_start");
	var_00 delete();
}

//Function Number: 11
nt_s2walk_anims_start(param_00)
{
	level notify("s2walk_start_walking");
}

//Function Number: 12
s2walk_guard_end_cleanup(param_00,param_01)
{
	wait(param_00);
	param_01 delete();
}

//Function Number: 13
player_walk()
{
	self endon("beaten_to_death");
	level endon("stop_walk");
	self endon("death");
	var_00 = common_scripts\utility::getstruct("struct_player_goal","targetname");
	self._walk = spawnstruct();
	self._walk.walk_node = maps\_utility::spawn_anim_model("s2_walking_node");
	self._walk.pushpoint = self._walk.walk_node common_scripts\utility::spawn_tag_origin();
	self._walk.pushpoint linkto(self._walk.walk_node);
	self._walk.walk_speed = 60;
	self._walk.sprint_speed = 80;
	self._walk.player_move_mod = 0;
	self._walk.punishment_level["forward"] = 0;
	self._walk.punishment_level["back"] = 0;
	self._walk.punishment_level["left_right"] = 0;
	self._walk.punishment_level["look"] = 0;
	self._walk.max_punishments = 2;
	self._walk.forward_punish_dist = 64;
	self._walk.behind_punish_dist = -64;
	self._walk.right_left_punish_dist = 64;
	var_01 = 5;
	var_02 = 0;
	var_03 = self._walk;
	for(;;)
	{
		var_04 = s2walk_dynamic_speed_adjuster();
		maps\_utility::player_speed_set(var_04[0]);
		if(common_scripts\utility::flag("flag_allow_punishment"))
		{
			punishment_check();
			if(isdefined(self.punishment))
			{
				punishment();
				var_02 = 0;
				self.punishment = undefined;
			}
			else
			{
				var_02++;
				if(var_02 >= var_01 * 20)
				{
					punishment_recovery();
					var_02 = 0;
				}
			}
		}

		wait(0.05);
	}

	self._walk.pushpoint delete();
	self._walk delete();
}

//Function Number: 14
player_walk_end()
{
	level notify("stop_walk");
	player_hands_idle_stop();
	level.player unlink();
	level.player.rig delete();
	level.player maps\_utility::player_speed_default();
}

//Function Number: 15
spawn_player_prisoner_hands()
{
	level.player disableweapons();
	level.player disableoffhandweapons();
	level.player disableweaponswitch();
	level.player.rig = maps\_utility::spawn_anim_model("player_arms",level.player.origin,level.player.angles);
	level.player.rig linktoplayerviewignoreparentrot(level.player,"tag_origin",(-6,0,-60),(0,-90,0),1,0,0,1);
	level.player.rig attach("s1_vm_handcuffs","tag_weapon_left");
	player_hands_idle_start();
}

//Function Number: 16
player_hands_idle_start()
{
	if(isdefined(level.player.rig.hidden))
	{
		level.player.rig show();
		level.player.rig.hidden = undefined;
	}

	level.player.rig notify("s2walk_idle_ender");
	level.player.rig thread maps\_anim::anim_loop_solo(level.player.rig,"s2walk_idle","s2walk_idle_ender");
	level.player allowcrouch(0);
	level.player allowjump(0);
	level.player allowprone(0);
}

//Function Number: 17
player_hands_idle_stop(param_00)
{
	if(isdefined(param_00) && param_00)
	{
		level.player.rig hide();
		level.player.rig.hidden = 1;
	}

	level.player.rig maps\_utility::anim_stopanimscripted();
}

//Function Number: 18
s2walk_dynamic_speed_adjuster()
{
	var_00 = -20;
	var_01 = 40;
	var_02 = 1.2;
	var_03 = level.player._walk.pushpoint;
	var_04 = vectornormalize(level.player.origin - var_03.origin);
	var_05 = anglestoforward(var_03.angles);
	var_06 = anglestoright(var_03.angles);
	var_07 = distance(level.player.origin,var_03.origin);
	var_08 = vectordot(var_04,var_05);
	var_09 = level.player._walk.walk_speed;
	var_0A = level.player._walk.sprint_speed;
	if(var_08 * var_07 > var_00)
	{
		var_0B = abs(var_00 + var_08 * var_07);
		var_0C = abs(var_01 - var_0B * var_02);
		var_09 = level.player._walk.walk_speed - var_0C;
		var_0A = level.player._walk.sprint_speed - var_0C;
	}

	var_0D = [var_09,var_0A];
	return var_0D;
}

//Function Number: 19
punishment_check()
{
	var_00 = self._walk.forward_punish_dist;
	var_01 = self._walk.behind_punish_dist;
	var_02 = self._walk.right_left_punish_dist;
	var_03 = -0.4;
	var_04 = 0.6;
	var_05 = 5;
	var_06 = self._walk.pushpoint;
	var_07 = vectornormalize(self.origin - var_06.origin);
	var_08 = anglestoforward(var_06.angles);
	var_09 = anglestoright(var_06.angles);
	var_0A = distance(self.origin,var_06.origin);
	var_0B = vectordot(var_07,var_08);
	var_0C = vectordot(var_07,var_09);
	if(var_0C * var_0A > var_02)
	{
		self.punishment = "right";
	}
	else if(var_0C * var_0A * -1 > var_02)
	{
		self.punishment = "left";
	}
	else if(var_0B * var_0A > var_00)
	{
		self.punishment = "forward";
	}
	else if(var_0B * var_0A < var_01)
	{
		self.punishment = "back";
	}

	if(isdefined(self.punishment))
	{
		self.punish_view_level = undefined;
		return;
	}

	var_0D = anglestoforward(self getplayerangles());
	var_0E = vectordot(var_0D,var_08);
	if(vectordot(var_0D,var_08) > var_04)
	{
		if(isdefined(self.punish_view_level) && self.punish_view_level > 0)
		{
			self.punish_view_level = self.punish_view_level - 0.05;
		}
		else
		{
			self.punish_view_level = undefined;
		}

		return;
	}

	if(!isdefined(self.punish_view_level))
	{
		self.punish_view_level = 0;
		self.last_punish_time = gettime();
	}

	if(var_0E < var_03 || self.punish_view_level > var_05)
	{
		var_0F = (var_08[0],var_08[1],0);
		self.last_punish_time = gettime();
		if(vectorcross(var_0D,var_0F)[2] > 0)
		{
			self.punishment = "look_right";
		}
		else
		{
			self.punishment = "look_left";
		}

		self.punish_view_level = undefined;
		return;
	}

	var_10 = var_06 * 0.05;
	self.punish_view_level = self.punish_view_level + randomfloatrange(0,var_10);
}

//Function Number: 20
punishment()
{
	if(self.punishment != "forward")
	{
		common_scripts\utility::flag_set("flag_stop_mover");
		var_00 = 0;
		var_01 = ["cap_gr4_inline","cap_gr4_getinline"];
		var_02 = ["cap_gr4_staycentered","cap_gr4_stayinline"];
		var_03 = ["cap_gr4_eyesforward","cap_gr4_stoplookin","cap_gr4_eyesforward2"];
		switch(self.punishment)
		{
			case "forward":
				self._walk.punishment_level["forward"]++;
				var_00 = self._walk.punishment_level["forward"];
				thread maps\_utility::smart_radio_dialogue(common_scripts\utility::random(var_01));
				break;

			case "back":
				self._walk.punishment_level["back"]++;
				var_00 = self._walk.punishment_level["back"];
				thread maps\_utility::smart_radio_dialogue(common_scripts\utility::random(var_01));
				break;

			case "left":
				self._walk.punishment_level["left_right"]++;
				var_00 = self._walk.punishment_level["left_right"];
				thread maps\_utility::smart_radio_dialogue(common_scripts\utility::random(var_02));
				thread punishment_anim("s2walk_punish_left");
				break;

			case "right":
				self._walk.punishment_level["left_right"]++;
				var_00 = self._walk.punishment_level["left_right"];
				thread maps\_utility::smart_radio_dialogue(common_scripts\utility::random(var_02));
				thread punishment_anim("s2walk_punish_right");
				break;

			case "look_left":
				self._walk.punishment_level["look"]++;
				var_00 = self._walk.punishment_level["look"];
				thread maps\_utility::smart_radio_dialogue(common_scripts\utility::random(var_03));
				thread punishment_anim("s2walk_punish_left");
				break;

			case "look_right":
				self._walk.punishment_level["look"]++;
				var_00 = self._walk.punishment_level["look"];
				thread maps\_utility::smart_radio_dialogue(common_scripts\utility::random(var_03));
				thread punishment_anim("s2walk_punish_right");
				break;
		}

		self freezecontrols(1);
		var_04 = var_00 * 20;
		self dodamage(var_04,self.origin);
		screenshake(self.origin,var_00,var_00,var_00,1,0,1,256,8,15,12,5);
		soundscripts\_snd::snd_message("aud_plr_hit");
		self playerlinktoblend(self._walk.pushpoint,"tag_origin",0.5,0,0.5);
		wait(0.5);
		self unlink();
		self freezecontrols(0);
		self.punishment = undefined;
		common_scripts\utility::flag_clear("flag_stop_mover");
	}
}

//Function Number: 21
punishment_anim(param_00)
{
	level endon("stop_walk");
	player_hands_idle_stop();
	level.player.rig maps\_anim::anim_single_solo(level.player.rig,param_00);
	player_hands_idle_start();
}

//Function Number: 22
punishment_recovery()
{
	foreach(var_02, var_01 in self._walk.punishment_level)
	{
		if(self._walk.punishment_level[var_02] > 0)
		{
			self._walk.punishment_level[var_02]--;
		}
	}
}

//Function Number: 23
punishment_push(param_00)
{
}

//Function Number: 24
set_origin_per_time(param_00,param_01,param_02)
{
	self endon("death");
	for(;;)
	{
		self.origin = averagepoint([param_00.origin,param_01.origin]);
		wait(param_02);
	}
}

//Function Number: 25
goal_mover(param_00,param_01)
{
	self notify("stop_goalmover");
	self endon("stop_goalmover");
	level.player endon("beaten_to_death");
	level endon("stop_walk");
	var_02 = 80;
	var_03 = self;
	self.at_goal = 0;
	param_00.at_goal = 0;
	for(;;)
	{
		if(isdefined(var_03.target))
		{
			var_03 = common_scripts\utility::getstruct(var_03.target,"targetname");
			if(!isdefined(var_03))
			{
				var_03 = getent(var_03.target,"targetname");
			}
		}
		else
		{
			self.at_goal = 1;
			break;
		}

		var_04 = distance(self.origin,var_03.origin);
		var_05 = vectornormalize(var_03.origin - self.origin);
		var_06 = var_04 / level.player._walk.walk_speed + level.player._walk.player_move_mod;
		var_07 = var_04 / var_06 * 0.05;
		var_08 = 0;
		while(var_08 <= var_06)
		{
			common_scripts\utility::flag_waitopen("flag_stop_mover");
			if(isdefined(param_00) && !param_00.at_goal)
			{
				var_09 = distance(self.origin,param_00.origin);
				while(var_09 < var_02)
				{
					var_09 = distance(self.origin,param_00.origin);
					wait(0.5);
				}
			}
			else
			{
				param_00 = undefined;
			}

			if(isdefined(param_01))
			{
				self rotateto(vectortoangles(param_01.origin - self.origin),1);
			}

			self moveto(self.origin + var_05 * var_07,0.05);
			wait(0.05);
			var_08 = var_08 + 0.05;
		}
	}
}

//Function Number: 26
elevator_ride_s2s3()
{
	common_scripts\utility::flag_wait("flag_player_in_s2s3_room");
	level waittill("elevator_black");
	common_scripts\utility::flag_set("flag_s2elevator_end");
}

//Function Number: 27
s2elevator_trolley_intro_scene(param_00,param_01,param_02)
{
	var_03 = common_scripts\utility::getstruct("struct_scene_s2elevator","targetname");
	if(!isdefined(param_01))
	{
		return;
	}

	level waittill("trolley_guard_3_start");
	param_02 notify("s2walk_intro_trolley_loop_ender");
	var_03 thread maps\_anim::anim_single_solo(param_01,"s2walk_intro_trolley");
	level waittill("trolley_player_start");
	player_walk_end();
	var_04 = maps\_utility::spawn_anim_model("player_rig_noexo");
	var_05 = var_04 thread maps\captured_util::captured_player_cuffs();
	var_05 hide();
	var_04 hide();
	level.player common_scripts\utility::delaycall(17.3,::playrumbleonentity,"heavy_1s");
	level.player common_scripts\utility::delaycall(18.35,::playrumbleonentity,"light_3s");
	var_03 thread maps\_anim::anim_single_solo(var_04,"s2walk_intro_trolley");
	level.player playerlinktoblend(var_04,"tag_player",0.5);
	wait(0.5);
	level.player playerlinktodelta(var_04,"tag_player",0.5,30,30,20,20,1);
	var_05 show();
	var_04 show();
	wait(getanimlength(var_04 maps\_utility::getanim("s2walk_intro_trolley")));
	maps\_utility::array_delete(param_00);
	var_04 delete();
	var_05 delete();
}

//Function Number: 28
trolley_doors_function()
{
	var_00 = common_scripts\utility::getstruct("struct_scene_s2elevator","targetname");
	var_01 = maps\_utility::spawn_anim_model("trolley_guard_door_1");
	var_00 maps\_anim::anim_first_frame_solo(var_01,"s2walk_intro_trolley");
	var_02 = maps\_utility::spawn_anim_model("trolley_guard_door_2");
	var_00 maps\_anim::anim_first_frame_solo(var_02,"s2walk_intro_trolley");
	var_03 = maps\_utility::spawn_anim_model("trolley_gate");
	var_00 maps\_anim::anim_first_frame_solo(var_03,"s2walk_intro_trolley");
	var_04 = spawn("script_model",(5372,-8116,-592));
	var_04 setmodel("tag_origin");
	var_03 retargetscriptmodellighting(var_04);
	var_05 = [];
	for(var_06 = 0;var_06 < 4;var_06++)
	{
		var_07 = var_06 + 1;
		var_08 = "trolley_zip_" + var_07;
		var_09 = maps\_utility::spawn_anim_model(var_08);
		var_00 maps\_anim::anim_first_frame_solo(var_09,"s2walk_intro_trolley");
		var_05 = common_scripts\utility::array_add(var_05,var_09);
	}

	level waittill("trolley_guard_3_door_1");
	var_00 thread maps\_anim::anim_single_solo(var_01,"s2walk_intro_trolley");
	level waittill("trolley_guard_3_door_2");
	var_00 thread maps\_anim::anim_single_solo(var_02,"s2walk_intro_trolley");
	level waittill("trolley_zip_start");
	var_00 thread maps\_anim::anim_single(var_05,"s2walk_intro_trolley");
	level waittill("trolley_gate");
	var_00 thread maps\_anim::anim_single_solo(var_03,"s2walk_intro_trolley");
	level waittill("trolley_doctor_start");
	soundscripts\_snd::snd_message("aud_s2walk_clear_foley_mix");
	var_0A = getent("trolley_doctor","targetname");
	var_0B = var_0A maps\_utility::spawn_ai(1);
	var_0B.animname = "drug_doctor";
	var_0C = maps\_utility::spawn_anim_model("trolley_syringe");
	var_0D = [var_0B,var_0C];
	var_00 thread maps\_anim::anim_single(var_0D,"s2walk_intro_trolley");
	thread maps\captured::dialogue_doctor_trolley(var_0B);
	wait(getanimlength(var_0B maps\_utility::getanim("s2walk_intro_trolley")) - 3.05);
	thread s2elevator_fade_transition();
	common_scripts\utility::flag_wait("flag_s2elevator_end");
	var_01 delete();
	var_02 delete();
	var_03 delete();
	var_0B delete();
	maps\_utility::array_delete(var_05);
}

//Function Number: 29
nt_trolley_guard_start(param_00)
{
	level notify("trolley_guard_3_start");
}

//Function Number: 30
nt_trolley_player_start(param_00)
{
	level notify("trolley_player_start");
}

//Function Number: 31
nt_trolley_zip_start(param_00)
{
	level notify("trolley_zip_start");
}

//Function Number: 32
nt_trolley_doctor_start(param_00)
{
	level notify("trolley_doctor_start");
}

//Function Number: 33
nt_trolley_door_01(param_00)
{
	level notify("trolley_guard_3_door_1");
}

//Function Number: 34
nt_trolley_door_02(param_00)
{
	level notify("trolley_guard_3_door_2");
}

//Function Number: 35
nt_trolley_gate(param_00)
{
	level notify("trolley_gate");
}

//Function Number: 36
s2elevator_fade_transition()
{
	var_00 = maps\_hud_util::create_client_overlay("black",0,level.player);
	var_00 fadeovertime(3);
	var_00.alpha = 1;
	wait(4);
	level notify("elevator_black");
	wait(3);
	if(level.currentgen)
	{
		if(!istransientloaded("captured_interrogate_tr"))
		{
			level waittill("tff_post_s2walk_to_interrogate");
		}
	}

	var_00 fadeovertime(5);
	var_00.alpha = 0;
	wait(5);
	var_00 destroy();
}

//Function Number: 37
helicopter_flyby()
{
	level waittill("start_helicopter_fly");
	level notify("s1_looping_prisoner");
	var_00 = getent("first_walk_helo","script_noteworthy");
	var_01 = var_00 maps\_vehicle::spawn_vehicle_and_gopath();
	var_01 vehicle_turnengineoff();
	var_01 waittill("reached_dynamic_path_end");
	var_01 delete();
	level waittill("start_helicopter_fly");
	level thread maps\captured_fx::fx_walk_heli_flyby();
	var_00 = getent("second_walk_helo","script_noteworthy");
	var_01 = var_00 maps\_vehicle::spawn_vehicle_and_gopath();
	var_01 vehicle_turnengineoff();
	var_01 waittill("reached_dynamic_path_end");
	var_01 delete();
}