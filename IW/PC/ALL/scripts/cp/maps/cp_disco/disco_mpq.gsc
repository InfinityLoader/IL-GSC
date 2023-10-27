/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_disco\disco_mpq.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 122
 * Decompile Time: 6119 ms
 * Timestamp: 10/27/2023 12:04:20 AM
*******************************************************************/

//Function Number: 1
skq()
{
	init_skq_flags();
	scripts\common\utility::flag_wait("interactions_initialized");
	thread phase_1();
	thread phase_2();
	thread phase_3();
}

//Function Number: 2
init_skq_flags()
{
	scripts\common\utility::flag_init("eye_picked");
	scripts\common\utility::flag_init("heart_picked");
	scripts\common\utility::flag_init("brain_picked");
	scripts\common\utility::flag_init("skq_phase_1");
	scripts\common\utility::flag_init("skq_phase_3");
	scripts\common\utility::flag_init("disco_roof power_on");
	scripts\common\utility::flag_init("skq_p2t1_0");
	scripts\common\utility::flag_init("skq_p2t1_1");
	scripts\common\utility::flag_init("skq_p2t1_2");
	scripts\common\utility::flag_init("skq_p2t1_3");
	scripts\common\utility::flag_init("skq_p2t1_4");
	scripts\common\utility::flag_init("skq_p2t1_5");
	scripts\common\utility::flag_init("skq_p2t2_0");
	scripts\common\utility::flag_init("skq_p2t2_1");
	scripts\common\utility::flag_init("skq_p2t2_2");
	scripts\common\utility::flag_init("skq_p2t2_3");
	scripts\common\utility::flag_init("skq_p2t2_4");
	scripts\common\utility::flag_init("skq_p2t2_5");
	scripts\common\utility::flag_init("skq_p2t2_6");
	scripts\common\utility::flag_init("skq_p2t2_7");
	scripts\common\utility::flag_init("skq_p2t3_0");
	scripts\common\utility::flag_init("skq_p2t3_1");
	scripts\common\utility::flag_init("skq_p2t3_2");
	scripts\common\utility::flag_init("skq_p2t3_3");
	scripts\common\utility::flag_init("skq_p2t3_4");
	scripts\common\utility::flag_init("skq_p2t3_5");
	scripts\common\utility::flag_init("skq_p2t3_6");
	scripts\common\utility::flag_init("morse_code_heard");
	scripts\common\utility::flag_init("turnstile_done");
	scripts\common\utility::flag_init("turnstyle_glyph_hit");
	scripts\common\utility::flag_init("reel_zoms_beaten");
	scripts\common\utility::flag_init("cleanup_reel_assets");
	scripts\common\utility::flag_init("fever_started");
	scripts\common\utility::flag_init("savage_treasure");
	scripts\common\utility::flag_init("first_cipher_seen");
	scripts\common\utility::flag_init("second_cipher_seen");
	scripts\common\utility::flag_init("third_cipher_seen");
	scripts\common\utility::flag_init("correct_poster_got");
	scripts\common\utility::flag_init("skq_phase_1dbg");
	scripts\common\utility::flag_init("skq_phase_3dbg");
	scripts\common\utility::flag_init("skq_p2t1_0dbg");
	scripts\common\utility::flag_init("skq_p2t1_1dbg");
	scripts\common\utility::flag_init("skq_p2t1_2dbg");
	scripts\common\utility::flag_init("skq_p2t1_3dbg");
	scripts\common\utility::flag_init("skq_p2t1_4dbg");
	scripts\common\utility::flag_init("skq_p2t1_5dbg");
	scripts\common\utility::flag_init("skq_p2t2_0dbg");
	scripts\common\utility::flag_init("skq_p2t2_1dbg");
	scripts\common\utility::flag_init("skq_p2t2_2dbg");
	scripts\common\utility::flag_init("skq_p2t2_3dbg");
	scripts\common\utility::flag_init("skq_p2t2_4dbg");
	scripts\common\utility::flag_init("skq_p2t2_5dbg");
	scripts\common\utility::flag_init("skq_p2t2_6dbg");
	scripts\common\utility::flag_init("skq_p2t2_7dbg");
	scripts\common\utility::flag_init("skq_p2t3_0dbg");
	scripts\common\utility::flag_init("skq_p2t3_1dbg");
	scripts\common\utility::flag_init("skq_p2t3_2dbg");
	scripts\common\utility::flag_init("skq_p2t3_3dbg");
	scripts\common\utility::flag_init("skq_p2t3_4dbg");
	scripts\common\utility::flag_init("skq_p2t3_5dbg");
	scripts\common\utility::flag_init("skq_p2t3_6dbg");
}

//Function Number: 3
phase_1()
{
	var_00 = scripts\common\utility::func_6E4F("skq_phase_1","skq_phase_1dbg");
	if(isdefined(level.spoke_to_pam_first_after_wave_five) && !scripts\common\utility::istrue(level.played_first_pam_dialogue))
	{
		switch(level.spoke_to_pam_first_after_wave_five.var_134FD)
		{
			case "p1_":
				level.spoke_to_pam_first_after_wave_five thread scripts\cp\_vo::try_to_play_vo("sally_pam_first_1","pam_dialogue_vo","highest",20,1);
				break;

			case "p2_":
				level.spoke_to_pam_first_after_wave_five thread scripts\cp\_vo::try_to_play_vo("pdex_pam_first_1","pam_dialogue_vo","highest",20,1);
				break;

			case "p3_":
				level.spoke_to_pam_first_after_wave_five thread scripts\cp\_vo::try_to_play_vo("andre_pam_first_1","pam_dialogue_vo","highest",20,1);
				break;

			case "p4_":
				level.spoke_to_pam_first_after_wave_five thread scripts\cp\_vo::try_to_play_vo("aj_pam_first_1","pam_dialogue_vo","highest",20,1);
				break;

			case "p5_":
				level.spoke_to_pam_first_after_wave_five thread scripts\cp\_vo::try_to_play_vo("pam_generic_response","pam_dialogue_vo","highest",20,1);
				break;

			default:
				break;
		}

		level.played_first_pam_dialogue = 1;
	}
	else
	{
		foreach(var_02 in level.players)
		{
			var_03 = ["pam_generic_response","pam_return_nothing"];
			var_02 thread scripts\cp\_vo::try_to_play_vo(scripts\common\utility::random(var_03),"pam_dialogue_vo","highest",100,1);
		}
	}

	if(isdefined(level.trainer))
	{
		level.trainer notify("play_idle");
	}

	foreach(var_06 in level.all_animal_structs)
	{
		thread scripts\cp\_interaction::add_to_current_interaction_list(var_06);
	}

	scripts\cp\maps\cp_disco\kung_fu_mode::disable_trainer_interactions();
}

//Function Number: 4
phase_2()
{
	thread phase_2_task_1();
	thread phase_2_task_2();
	thread phase_2_task_3();
}

//Function Number: 5
phase_2_task_1()
{
	thread p2t1_0_receive_quest();
	thread p2t1_1_destroy_cages();
	thread p2t1_2_subway_locker();
	thread p2t1_3_decal_puzzle();
	thread p2t1_4_rat_king_fight();
	thread p2t1_5_complete_task();
}

//Function Number: 6
p2t1_0_receive_quest()
{
	var_00 = scripts\common\utility::func_6E4F("skq_p2t1_0","skq_p2t1_0dbg");
	scripts\cp\maps\cp_disco\kung_fu_mode::disable_trainer_interactions();
	foreach(var_02 in level.players)
	{
		var_02 thread scripts\cp\_vo::try_to_play_vo("pam_quest_ratking_eye","pam_dialogue_vo","highest",100,1);
		if(var_02.var_134FD == "p5_")
		{
			var_02 thread play_pam_reaction_vo("pam_quest_ratking_eye",1,0,0);
		}
	}

	scripts\cp\_vo::func_E01F("pam_quest_return");
	level.trainer notify("play_sit_idle");
	scripts\common\utility::flag_set("skq_p2t1_1");
}

//Function Number: 7
p2t1_1_destroy_cages()
{
	level endon("game_ended");
	var_00 = scripts\common\utility::func_6E4F("skq_p2t1_1","skq_p2t1_1dbg");
	var_01 = scripts\common\utility::getstructarray("mpq_rat_cage","targetname");
	foreach(var_03 in var_01)
	{
		var_03 thread monitor_cage_visibility();
	}

	for(;;)
	{
		var_05 = monitor_cage_destruction();
		if(var_05)
		{
			break;
		}
		else
		{
			reset_cage_puzzle();
		}
	}

	remove_cage_quest();
	if(!isdefined(level.next_cage))
	{
		var_01 = scripts\common\utility::getstructarray("mpq_rat_cage","targetname");
		var_01 = sortbydistance(var_01,level.players[0].origin);
		level.next_cage = var_01[0];
	}

	var_03 = undefined;
	var_01 = scripts\common\utility::getstructarray("cage_challenge_ring","targetname");
	foreach(var_07 in var_01)
	{
		if(var_07.script_noteworthy == level.next_cage.script_noteworthy)
		{
			var_03 = var_07;
			break;
		}
	}

	zombie_challenge_ring(15,var_03);
	wait(10);
	var_03 rat_cage_kung_fu_zombies();
	var_09 = spawnfx(level._effect["locker_key"],var_03.origin + (0,0,32),anglestoforward(var_03.angles),anglestoup(var_03.angles));
	var_0A = scripts\common\utility::spawn_tag_origin(var_03.origin + (0,0,32),var_03.angles);
	wait(0.2);
	triggerfx(var_09);
	var_0A makeusable(1);
	var_0A method_84A5(60);
	var_0A method_84A2(50);
	var_0A waittill("trigger",var_0B);
	if(isdefined(var_0B) && isplayer(var_0B))
	{
		var_0B thread scripts\cp\_vo::try_to_play_vo("pam_collect_lockerkey","disco_comment_vo");
		var_0B thread scripts\cp\_vo::func_1769("missing_item_misc","disco_comment_vo",240,120,4,1);
	}

	level scripts\cp\_utility::set_quest_icon(14);
	var_0A delete();
	var_09 delete();
	scripts\common\utility::flag_set("skq_p2t1_2");
}

//Function Number: 8
zombie_challenge_ring(param_00,param_01)
{
	level endon("game_ended");
	var_02 = scripts\common\utility::func_5D14(param_01.origin,30,-100);
	var_03 = spawnfx(level._effect["challenge_ring"],var_02,anglestoforward(param_01.angles));
	wait(1);
	level thread zombie_challenge_ring_sfx(var_02);
	triggerfx(var_03);
	var_04 = param_00;
	while(var_04 > 0)
	{
		level waittill("zombie_killed",var_05,var_06,var_06,var_07);
		if(distancesquared(var_02,var_05) <= 22500)
		{
			var_04--;
		}

		wait(0.05);
	}

	level notify("stop_this_challenge_ring_sfx");
	var_03 delete();
}

//Function Number: 9
zombie_challenge_ring_sfx(param_00)
{
	level endon("game_ended");
	var_01 = scripts\common\utility::play_loopsound_in_space("kill_zone_circle_lr_lp",param_00);
	level waittill("stop_this_challenge_ring_sfx");
	wait(0.15);
	var_01 stoploopsound();
	var_01 delete();
}

//Function Number: 10
rat_cage_kung_fu_zombies()
{
	level.rat_cage_zoms = 0;
	mpq_spawn_special_wave(level.rat_cage_zoms,8);
}

//Function Number: 11
remove_cage_quest()
{
	var_00 = scripts\common\utility::getstructarray("mpq_rat_cage","targetname");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.cage_model))
		{
			var_02.cage_model delete();
		}

		if(isdefined(var_02.cage_rat))
		{
			if(var_02.cage_rat.model == "tag_origin_templeton")
			{
				var_02.cage_rat setscriptablepartstate("templeton",1);
				var_02.cage_rat delete();
				continue;
			}

			var_02.cage_rat delete();
		}
	}

	level notify("cage_win");
}

//Function Number: 12
reset_cage_puzzle()
{
	level endon("game_ended");
	var_00 = scripts\common\utility::getstructarray("mpq_rat_cage","targetname");
	level thread scripts\cp\_vo::try_to_play_vo("ww_quest_failure","rave_announcer_vo","highest",70,0,0,1);
	level notify("cage_fail");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.claimed_cage))
		{
			var_02.claimed_cage = undefined;
		}

		if(isdefined(var_02.cage_model))
		{
			var_02.cage_model delete();
		}

		if(isdefined(var_02.cage_rat))
		{
			if(var_02.cage_rat.model == "tag_origin_templeton")
			{
				var_02.cage_rat setscriptablepartstate("templeton",1);
				var_02.cage_rat delete();
				continue;
			}

			var_02.cage_rat delete();
		}
	}

	wait(4);
	foreach(var_02 in var_00)
	{
		var_02 thread monitor_cage_visibility();
	}
}

//Function Number: 13
spawn_rat_cage()
{
	level endon("game_ended");
	level endon("cage_fail");
	level endon("cage_win");
	if(!isdefined(self.angles))
	{
		self.angles = (0,0,0);
	}

	self.cage_model = spawn("script_model",self.origin);
	self.cage_model.angles = self.angles;
	self.cage_model setmodel("cp_disco_rat_cage");
	var_00 = scripts\common\utility::getstruct(self.target,"targetname");
	self.cage_rat = spawn("script_model",var_00.origin);
	self.cage_rat.angles = var_00.angles;
	self.cage_rat setmodel("zmb_rat");
	thread cage_logic();
}

//Function Number: 14
cage_logic()
{
	level endon("game_ended");
	self endon("not_visible");
	level endon("cage_fail");
	level endon("cage_win");
	self.cage_model setcandamage(1);
	for(;;)
	{
		self.cage_model waittill("damage",var_00,var_01,var_00,var_00,var_00,var_00,var_00,var_00,var_00,var_02);
		if(isdefined(var_02) && issubstr(var_02,"shuriken"))
		{
			break;
		}
		else
		{
			wait(0.2);
		}
	}

	level notify("cage_hit",self,var_01);
}

//Function Number: 15
monitor_cage_destruction()
{
	level endon("game_ended");
	level endon("cage_fail");
	level endon("cage_win");
	level waittill("cage_hit",var_00,var_01);
	playsoundatpos(var_00.origin,"ninja_zombie_poof_in");
	playfx(level._effect["rat_cage_poof"],var_00.origin,anglestoforward(var_00.angles),anglestoup(var_00.angles));
	var_00 thread send_rat_wandering(var_01);
	while(!isdefined(level.next_cage))
	{
		wait(0.1);
	}

	for(var_02 = 0;var_02 < 4;var_02++)
	{
		level waittill("cage_hit",var_00,var_01);
		playsoundatpos(var_00.origin,"ninja_zombie_poof_in");
		playsoundatpos(var_00.origin,"rat_cage_open");
		playfx(level._effect["rat_cage_poof"],var_00.origin,anglestoforward(var_00.angles),anglestoup(var_00.angles));
		if(var_00 == level.next_cage)
		{
			var_00 thread send_rat_wandering(var_01);
			continue;
		}

		return 0;
	}

	level waittill("cage_hit",var_00,var_01);
	if(var_00 == level.next_cage)
	{
		return 1;
	}

	return 0;
}

//Function Number: 16
send_rat_wandering(param_00)
{
	level endon("game_ended");
	level endon("cage_fail");
	level endon("cage_win");
	self.claimed_cage = 1;
	self notify("cage_destroyed");
	var_01 = select_next_cage();
	self.cage_model delete();
	var_02 = build_path_network(self.cage_rat,var_01,param_00);
	self.cage_rat thread rat_follow_path(var_02,var_01);
	self.cage_rat playloopsound("rat_scurry_follow_lp");
}

//Function Number: 17
build_path_network(param_00,param_01,param_02)
{
	level endon("game_ended");
	level endon("cage_fail");
	level endon("cage_win");
	var_03 = [];
	var_04 = 0;
	var_05 = scripts\common\utility::getstructarray("mpq_rat_traversal","targetname");
	var_06 = undefined;
	for(;;)
	{
		if(var_03.size == 0)
		{
			var_03 = param_02 method_8428(param_00.origin,param_01.origin,1,1);
		}
		else
		{
			var_07 = param_02 method_8428(var_03[var_03.size - 1],param_01.origin,1,1);
			var_03 = scripts\common\utility::array_combine(var_03,var_07);
		}

		if(distance2dsquared(param_01.origin,var_03[var_03.size - 1]) <= 4096)
		{
			return var_03;
		}

		var_05 = sortbydistance(var_05,var_03[var_03.size - 1]);
		var_08 = [];
		var_09 = undefined;
		foreach(var_0B in var_05)
		{
			if(var_04 && var_0B == var_05[0] || var_0B == var_06)
			{
				continue;
			}

			var_08 = param_02 method_8428(var_03[var_03.size - 1],var_0B.origin,1,1);
			if(distance2dsquared(var_0B.origin,var_08[var_08.size - 1]) <= 4096)
			{
				var_09 = var_0B;
				break;
			}
		}

		if(!var_04)
		{
			var_04 = 1;
		}

		if(!isdefined(var_09))
		{
			return var_03;
		}
		else
		{
			var_06 = var_09;
		}

		var_08 = [];
		var_08[var_08.size] = var_09.origin;
		var_0D = scripts\common\utility::getstruct(var_09.target,"targetname");
		var_08[var_08.size] = var_0D.origin;
		var_03 = scripts\common\utility::array_combine(var_03,var_08);
		wait(0.05);
	}
}

//Function Number: 18
rat_follow_path(param_00,param_01)
{
	level endon("game_ended");
	level endon("cage_fail");
	level endon("cage_win");
	var_02 = 120;
	self setmodel("tag_origin_templeton");
	foreach(var_04 in param_00)
	{
		var_05 = distance(self.origin,var_04);
		var_06 = 16;
		if(var_05 >= var_06 * 2)
		{
			var_07 = floor(var_05 / var_06);
			for(var_08 = 0;var_08 < var_07;var_08++)
			{
				var_09 = vectortoangles(var_04 - self.origin);
				var_0A = self.origin + anglestoforward(var_09) * var_06;
				var_0A = scripts\common\utility::func_5D14(var_0A,50,-100);
				var_05 = distance(self.origin,var_0A);
				var_0B = var_05 / var_02;
				if(var_0B <= 0.05)
				{
					var_0B = 0.05;
				}

				var_09 = (var_09[0],var_09[1] + 90,var_09[2]);
				self rotateto(var_09,0.05);
				self moveto(var_0A,var_0B);
				wait(var_0B);
			}
		}

		var_05 = distance(self.origin,var_04);
		var_0C = self.origin - var_04;
		var_0D = vectortoangles(var_0C);
		var_0B = var_05 / var_02;
		if(var_0B <= 0)
		{
			var_0B = 0.1;
		}

		var_0D = (var_0D[0],var_0D[1] - 90,var_0D[2]);
		self rotateto(var_0D,0.1);
		self moveto(var_04,var_0B);
		wait(var_0B);
	}

	self stoploopsound("rat_scurry_follow_lp");
	playsoundatpos(self.origin,"rat_cage_close");
	if(self.model == "tag_origin_templeton")
	{
		self setscriptablepartstate("templeton",1);
		self delete();
		return;
	}

	self delete();
}

//Function Number: 19
select_next_cage()
{
	level endon("game_ended");
	level endon("cage_fail");
	level endon("cage_win");
	var_00 = scripts\common\utility::getstructarray("mpq_rat_cage","targetname");
	var_00 = scripts\common\utility::func_22A8(var_00);
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(!isdefined(var_00[var_01].claimed_cage))
		{
			level.next_cage = var_00[var_01];
			return var_00[var_01];
		}
	}
}

//Function Number: 20
monitor_cage_visibility()
{
	level endon("game_ended");
	self endon("cage_destroyed");
	level endon("cage_fail");
	level endon("cage_win");
	var_00 = 0;
	foreach(var_02 in level.players)
	{
		if(distance2dsquared(var_02.origin,self.origin) <= 1048576)
		{
			playsoundatpos(self.origin,"ninja_zombie_poof_in");
			playfx(level._effect["rat_cage_poof"],self.origin,anglestoforward(self.angles),anglestoup(self.angles));
			break;
		}
	}

	for(;;)
	{
		if(!isdefined(self.cage_model))
		{
			var_04 = 0;
			while(!var_04)
			{
				foreach(var_02 in level.players)
				{
					if(distance2dsquared(var_02.origin,self.origin) <= 1048576)
					{
						var_04 = 1;
						break;
					}
				}

				wait(0.1);
			}

			spawn_rat_cage();
		}
		else
		{
			var_04 = 0;
			while(!var_04)
			{
				var_07 = 0;
				foreach(var_02 in level.players)
				{
					if(distance2dsquared(var_02.origin,self.origin) <= 1048576)
					{
						var_07 = 1;
						break;
					}
				}

				if(!var_07)
				{
					var_04 = 1;
				}

				wait(0.2);
			}

			self notify("not_visible");
			self.cage_rat delete();
			self.cage_model delete();
			self.cage_rat = undefined;
			self.cage_model = undefined;
		}

		wait(0.2);
	}
}

//Function Number: 21
p2t1_2_subway_locker()
{
	level endon("game_ended");
	var_00 = scripts\common\utility::func_6E4F("skq_p2t1_2","skq_p2t1_2dbg");
	var_01 = getent("subway_locker_door","targetname");
	var_02 = scripts\common\utility::getstruct(var_01.target,"targetname");
	var_03 = spawn("script_model",var_02.origin);
	var_03 setmodel("tag_origin");
	var_03 makeusable();
	var_03 waittill("trigger",var_04);
	if(isdefined(var_04) && isplayer(var_04))
	{
		var_04 thread scripts\cp\_vo::try_to_play_vo("pam_open_locker","disco_comment_vo");
		level thread scripts\cp\_vo::func_E01F("missing_item_misc");
	}

	var_05 = scripts\common\utility::getstruct("locker_rortator_mpq","targetname");
	if(isdefined(var_05))
	{
		var_06 = scripts\common\utility::spawn_tag_origin(var_05.origin,var_05.angles);
		var_01 linkto(var_06);
		playsoundatpos(var_06.origin,"disco_locker_open");
		var_06 rotateyaw(120,2,1,0.5);
		wait(2);
		var_06 delete();
	}
	else
	{
		var_01 delete();
	}

	scripts\common\utility::flag_set("skq_p2t1_3");
}

//Function Number: 22
p2t1_3_decal_puzzle()
{
	level endon("game_ended");
	var_00 = scripts\common\utility::func_6E4F("skq_p2t1_3","skq_p2t1_3dbg");
	var_01 = getent("graffiti_quest_clip","targetname");
	var_02 = getent("graffiti_quest_fail_clip","targetname");
	var_03 = getent("graffiti_quest_clip_alt","targetname");
	var_01 thread setup_chinese_targ_clip();
	var_02 thread setup_chinese_fail_clip();
	var_03 thread setup_chinese_alt_clip();
	var_04 = "start";
	var_05 = 0;
	while(!var_05)
	{
		level waittill("update_graffiti",var_06,var_07);
		if(!isdefined(var_07) || !isplayer(var_07))
		{
			continue;
		}

		switch(var_06)
		{
			case "chinese_symbol_0":
				if(var_04 == "start")
				{
					var_04 = "chinese_symbol_0";
					var_07 playsoundtoplayer("chinese_symbol_hit",var_07);
				}
				else
				{
					failmpqstep();
					var_04 = "start";
				}
				break;

			case "chinese_symbol_1":
				if(var_04 == "chinese_symbol_0")
				{
					var_04 = "chinese_symbol_1";
					var_07 playsoundtoplayer("chinese_symbol_hit",var_07);
				}
				else
				{
					failmpqstep();
					var_04 = "start";
				}
				break;

			case "chinese_symbol_2":
				if(var_04 == "chinese_symbol_1")
				{
					var_04 = "chinese_symbol_2";
					var_07 playsoundtoplayer("chinese_symbol_hit",var_07);
				}
				else
				{
					failmpqstep();
					var_04 = "start";
				}
				break;

			case "chinese_symbol_3":
				if(var_04 == "chinese_symbol_2")
				{
					var_05 = 1;
					var_07 playsoundtoplayer("chinese_symbol_hit",var_07);
				}
				else if(var_04 == "chinese_symbol_1")
				{
					var_04 = "chinese_symbol_3";
					var_07 playsoundtoplayer("chinese_symbol_hit",var_07);
				}
				else
				{
					failmpqstep();
					var_04 = "start";
				}
				break;

			case "fail":
				failmpqstep();
				var_04 = "start";
				break;

			case "alt":
				if(var_04 == "chinese_symbol_3")
				{
					var_05 = 1;
					var_07 playsoundtoplayer("chinese_symbol_hit",var_07);
				}
				else
				{
					failmpqstep();
					var_04 = "start";
				}
				break;

			default:
				break;
		}
	}

	level notify("active_word_done");
	thread rk_symbol_handler("rk_symbol_punk_streets","skq_p2t1_4");
	scripts\cp\_utility::deactivatebrushmodel(var_01,1);
	scripts\cp\_utility::deactivatebrushmodel(var_02,1);
	scripts\cp\_utility::deactivatebrushmodel(var_03,1);
}

//Function Number: 23
setup_chinese_targ_clip()
{
	level endon("game_ended");
	level endon("active_word_done");
	var_00 = scripts\common\utility::getstructarray("graffiti_check_struct","targetname");
	for(;;)
	{
		self setcandamage(1);
		self.health = 9999;
		self waittill("damage",var_01,var_02,var_01,var_03);
		var_00 = sortbydistance(var_00,var_03);
		level notify("update_graffiti",var_00[0].script_noteworthy,var_02);
		self setcandamage(0);
		wait(0.1);
	}
}

//Function Number: 24
setup_chinese_fail_clip()
{
	level endon("game_ended");
	level endon("active_word_done");
	for(;;)
	{
		self setcandamage(1);
		self.health = 9999;
		self waittill("damage",var_00,var_01,var_00,var_02);
		level notify("update_graffiti","fail",var_01);
		self setcandamage(0);
		wait(0.1);
	}
}

//Function Number: 25
setup_chinese_alt_clip()
{
	level endon("game_ended");
	level endon("active_word_done");
	for(;;)
	{
		self setcandamage(1);
		self.health = 9999;
		self waittill("damage",var_00,var_01,var_00,var_02);
		level notify("update_graffiti","alt",var_01);
		self setcandamage(0);
		wait(0.1);
	}
}

//Function Number: 26
p2t1_4_rat_king_fight()
{
	level endon("game_ended");
	var_00 = scripts\common\utility::getstruct("p2t1_4","script_noteworthy");
	var_01 = scripts\common\utility::func_6E4F("skq_p2t1_4","skq_p2t1_4dbg");
	level thread play_rat_king_vo_discussion(1);
	scripts\cp\maps\cp_disco\rat_king::spawn_rat_king(var_00.origin,var_00.angles,1);
	level thread scripts\cp\maps\cp_disco\cp_disco::enableratkingpas();
	foreach(var_03 in level.players)
	{
		var_03 playsoundtoplayer("quest_stage_completed_gong_lr",var_03);
	}

	setrkabilities_p2t1_4();
	level watchrkretreat(1000);
	thread createrelicinteraction("eye");
	scripts\cp\maps\cp_disco\kung_fu_mode::increase_trainer_interaction_progression();
	foreach(var_03 in level.players)
	{
		var_03 thread play_corresponding_vo(1);
	}
}

//Function Number: 27
play_rat_king_vo_discussion(param_00)
{
	level endon("game_ended");
	if(!isdefined(param_00))
	{
		return;
	}

	if(!scripts\cp\_music_and_dialog::func_3837())
	{
		return;
	}

	switch(param_00)
	{
		case 1:
			level thread scripts\cp\_vo::try_to_play_vo("ww_ratking_firstspawn","rave_announcer_vo","highest",70,0,0,1);
			wait(scripts\cp\_vo::func_7C76("ww_ratking_firstspawn"));
			play_vo_based_on_player(param_00);
			break;

		case 2:
			wait(scripts\cp\_vo::func_7C76("ww_ratking_spawn"));
			play_vo_based_on_player(param_00);
			break;

		case 3:
			wait(scripts\cp\_vo::func_7C76("ww_ratking_spawn"));
			play_vo_based_on_player(param_00);
			break;
	}
}

//Function Number: 28
play_vo_based_on_player(param_00)
{
	level endon("game_ended");
	var_01 = scripts\common\utility::random(level.players);
	switch(var_01.var_134FD)
	{
		case "p1_":
			if(param_00 == 1)
			{
				var_01 thread scripts\cp\_vo::try_to_play_vo("sally_rat_king_1_1","rave_dialogue_vo");
			}
			else if(param_00 == 2)
			{
				var_01 thread scripts\cp\_vo::try_to_play_vo("sally_rat_king_2_1","rave_dialogue_vo");
			}
			else if(param_00 == 3)
			{
				var_01 thread scripts\cp\_vo::try_to_play_vo("sally_rat_king_3_1","rave_dialogue_vo");
			}
			break;

		case "p2_":
			if(param_00 == 1)
			{
				var_01 thread scripts\cp\_vo::try_to_play_vo("pdex_rat_king_1_1","rave_dialogue_vo");
			}
			else if(param_00 == 2)
			{
				var_01 thread scripts\cp\_vo::try_to_play_vo("pdex_rat_king_2_1","rave_dialogue_vo");
			}
			else if(param_00 == 3)
			{
				var_01 thread scripts\cp\_vo::try_to_play_vo("pdex_rat_king_3_1","rave_dialogue_vo");
			}
			break;

		case "p3_":
			if(param_00 == 1)
			{
				var_01 thread scripts\cp\_vo::try_to_play_vo("andre_rat_king_1_1","rave_dialogue_vo");
			}
			else if(param_00 == 2)
			{
				var_01 thread scripts\cp\_vo::try_to_play_vo("andre_rat_king_2_1","rave_dialogue_vo");
			}
			else if(param_00 == 3)
			{
				var_01 thread scripts\cp\_vo::try_to_play_vo("andre_rat_king_3_1","rave_dialogue_vo");
			}
			break;

		case "p4_":
			if(param_00 == 1)
			{
				var_01 thread scripts\cp\_vo::try_to_play_vo("aj_rat_king_1_1","rave_dialogue_vo");
			}
			else if(param_00 == 2)
			{
				var_01 thread scripts\cp\_vo::try_to_play_vo("aj_rat_king_2_1","rave_dialogue_vo");
			}
			else if(param_00 == 3)
			{
				var_01 thread scripts\cp\_vo::try_to_play_vo("aj_rat_king_3_1","rave_dialogue_vo");
			}
			break;
	}
}

//Function Number: 29
watchrkretreat(param_00)
{
	level endon("game_ended");
	level.rat_king.health = param_00;
	level.rat_king waittill("fake_death");
}

//Function Number: 30
setrkabilities_p2t1_4()
{
	scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("teleport",1);
	scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("block",1);
	scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("melee_attack",1);
	scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("summon",1);
	scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("staff_stomp",0);
	scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("staff_projectile",0);
	scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("shield_attack",0);
	scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("shield_attack_spot",0);
	level.rat_king_attack_priorities = [];
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "melee_attack";
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "block";
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "teleport";
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "summon";
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "staff_stomp";
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "staff_projectile";
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "shield_attack";
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "shield_attack_spot";
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "attack_zombies";
	level.rk_tuning_override = ::setrkblocktuning;
	level.rk_solo_tuning_override = ::setrkblocktuning;
	setrkblocktuning(level.agenttunedata["ratking"]);
}

//Function Number: 31
setrkblocktuning(param_00)
{
	param_00.need_to_block_damage_threshold = 20;
	param_00.max_time_after_last_damage_to_block = 1000;
	param_00.block_chance = 100;
	param_00.min_block_time = 3000;
	param_00.max_block_time = 7000;
	param_00.quit_block_if_no_damage_time = 2000;
	param_00.min_block_interval = 7000;
	param_00.max_block_interval = 10000;
}

//Function Number: 32
p2t1_5_complete_task()
{
	level endon("game_ended");
	var_00 = scripts\common\utility::func_6E4F("skq_p2t1_5","skq_p2t1_5dbg");
	scripts\cp\maps\cp_disco\kung_fu_mode::disable_trainer_interactions();
	foreach(var_02 in level.players)
	{
		var_02 thread scripts\cp\_vo::try_to_play_vo("pam_quest_ratking_brain","pam_dialogue_vo","highest",100,1);
		if(var_02.var_134FD == "p5_")
		{
			var_02 thread play_pam_reaction_vo("pam_quest_ratking_brain",0,0,1);
		}
	}

	level.trainer notify("play_sit_idle");
	scripts\common\utility::flag_set("skq_p2t2_0");
}

//Function Number: 33
phase_2_task_2()
{
	thread p2t2_0_symbol_hunt();
	thread p2t2_1_phone_puzzle();
	thread p2t2_3_poster_puzzle();
	thread p2t2_4_kung_fu_fight();
	thread p2t2_5_rat_king_puzzle();
	thread p2t2_6_rat_king_fight();
	thread p2t2_7_complete_task();
}

//Function Number: 34
p2t2_0_symbol_hunt(param_00)
{
	level endon("game_ended");
	var_01 = scripts\common\utility::func_6E4F("skq_p2t2_0","skq_p2t2_0dbg");
	var_02 = scripts\common\utility::getstructarray("phonebooth","script_noteworthy");
	var_03 = scripts\common\utility::getstructarray("symbol_point","targetname");
	var_02 = scripts\common\utility::func_22A8(var_02);
	var_03 = scripts\common\utility::func_22A8(var_03);
	var_04 = 0;
	var_05 = var_02[var_02.size - 1];
	level.active_hunt_symbol = var_03[var_04];
	for(;;)
	{
		if(var_02[var_04] == var_05)
		{
			break;
		}
		else
		{
			wait(0.1);
		}

		active_symbol_logic();
		turn_off_phone_light(var_02[var_04]);
		var_04++;
		cleanup_previous_symbol();
		level.active_hunt_symbol = var_03[var_04];
	}

	cleanup_previous_symbol();
	level.phone_puzzle_phone = var_05;
	thread payphone_ringing(level.phone_puzzle_phone);
	scripts\common\utility::flag_set("skq_p2t2_1");
}

//Function Number: 35
turn_off_phone_light(param_00)
{
	param_00.quest_state = 1;
	scripts\cp\maps\cp_disco\phonebooth::update_all_phonebooth_scriptable_states();
}

//Function Number: 36
active_symbol_logic()
{
	if(!isdefined(level.active_hunt_symbol))
	{
		return;
	}

	level endon("game_ended");
	thread toggle_symbols_for_players();
	var_00 = getent("symbol_point_clip","targetname");
	var_01 = getent(var_00.target,"targetname");
	var_01 linkto(var_00);
	var_00.origin = level.active_hunt_symbol.origin;
	var_00.angles = level.active_hunt_symbol.angles;
	wait(0.1);
	var_01 setcandamage(1);
	var_01.health = 9999;
	for(;;)
	{
		var_01 waittill("damage",var_02,var_03);
		if(scripts\common\utility::istrue(var_03.wearing_rat_king_eye))
		{
			break;
		}
		else
		{
			wait(0.1);
		}
	}

	playfx(level._effect["glyph_death"],level.active_hunt_symbol.origin,anglestoforward(level.active_hunt_symbol.angles),anglestoup(level.active_hunt_symbol.angles));
	var_01 setcandamage(0);
	wait(0.1);
}

//Function Number: 37
cleanup_previous_symbol()
{
	if(!isdefined(level.active_hunt_symbol))
	{
		return;
	}

	level notify("symbol_updated");
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01.symbol_hunt_fx))
		{
			var_01.symbol_hunt_fx delete();
		}
	}
}

//Function Number: 38
toggle_symbols_for_players()
{
	level endon("game_ended");
	level endon("symbol_updated");
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			var_01 thread determine_symbol_visibility();
		}

		level scripts\common\utility::waittill_any_3("rat_king_eye_activated","rat_king_eye_deactivated","connected");
	}
}

//Function Number: 39
determine_symbol_visibility()
{
	level endon("game_ended");
	if(!isdefined(level.active_hunt_symbol))
	{
		return;
	}
	else
	{
		var_00 = level.active_hunt_symbol;
	}

	if(scripts\common\utility::istrue(self.wearing_rat_king_eye))
	{
		if(isdefined(self.symbol_hunt_fx))
		{
			return;
		}

		var_01 = function_01E1(level._effect["test_glyph_mpq"],var_00.origin,self,anglestoforward(var_00.angles),anglestoup(var_00.angles));
		self.symbol_hunt_fx = var_01;
		wait(0.05);
		triggerfx(var_01);
		return;
	}

	if(isdefined(self.symbol_hunt_fx))
	{
		self.symbol_hunt_fx delete();
	}
}

//Function Number: 40
reset_phone_puzzle()
{
	level.phone_puzzle_phone = undefined;
	scripts\common\utility::func_6E2A("morse_code_heard");
	level notify("puzzle_phone_reset");
	scripts\common\utility::func_6E2A("skq_p2t2_1");
	level thread scripts\cp\_vo::try_to_play_vo("ww_magicbox_laughter","rave_announcer_vo","highest",70,0,0,1);
	var_00 = scripts\common\utility::getstructarray("phonebooth","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02.quest_state = 0;
	}

	scripts\cp\maps\cp_disco\phonebooth::update_all_phonebooth_scriptable_states();
	init_poster_nums(1);
	thread p2t2_1_phone_puzzle();
	thread p2t2_0_symbol_hunt(1);
	if(!scripts\common\utility::flag("skq_p2t2_0"))
	{
		scripts\common\utility::flag_set("skq_p2t2_0");
	}
}

//Function Number: 41
p2t2_1_phone_puzzle()
{
	level endon("game_ended");
	var_00 = scripts\common\utility::func_6E4F("skq_p2t2_1","skq_p2t2_1dbg");
	if(!isdefined(level.phone_puzzle_phone))
	{
		var_01 = scripts\common\utility::getstructarray("phonebooth","script_noteworthy");
		var_01 = scripts\common\utility::func_22A8(var_01);
		level.phone_puzzle_phone = var_01[0];
		thread payphone_ringing(level.phone_puzzle_phone);
		foreach(var_03 in var_01)
		{
			if(var_03 != var_01[0])
			{
				var_03.quest_state = 1;
				continue;
			}

			var_03.quest_state = 0;
		}

		scripts\cp\maps\cp_disco\phonebooth::update_all_phonebooth_scriptable_states();
	}

	level notify("puzzle_phone_answered");
	scripts\common\utility::flag_wait("morse_code_heard");
	scripts\common\utility::flag_set("skq_p2t2_3");
}

//Function Number: 42
play_phone_vo()
{
	self endon("disconnect");
	level endon("game_ended");
	wait(0.5);
	thread scripts\cp\_vo::try_to_play_vo("pam_answer_phone","disco_comment_vo");
}

//Function Number: 43
payphone_ringing(param_00)
{
	level endon("game_ended");
	var_01 = spawn("script_model",param_00.origin + (0,0,50));
	var_01 setmodel("tag_origin");
	var_01 playloopsound("payphone_npc_ring");
	param_00 waittill("phone_answered",var_02);
	level.player_answered_phone = var_02;
	var_01 delete();
}

//Function Number: 44
p2t2_3_poster_puzzle()
{
	level endon("game_ended");
	var_00 = init_poster_nums(0);
	var_01 = spawnstruct();
	var_01.var_1B9 = getent("spotlight_light","targetname");
	var_01.poster = getent(var_01.var_1B9.target,"targetname");
	var_01.fx_struct = scripts\common\utility::getstruct(var_01.poster.target,"targetname");
	var_01.poster hide();
	thread watch_for_spotlight_power(var_01);
	var_02 = scripts\common\utility::func_6E4F("skq_p2t2_3","skq_p2t2_3dbg");
	foreach(var_04 in var_00)
	{
		if(var_04 == var_00[0])
		{
			var_04 thread use_poster_logic(1);
			continue;
		}

		var_04 thread use_poster_logic(0);
	}

	scripts\common\utility::flag_wait("correct_poster_got");
	foreach(var_07 in level.players)
	{
		var_07 thread scripts\cp\_vo::func_1769("missing_item_misc","disco_comment_vo",200,120,4,1);
	}

	var_09 = scripts\common\utility::getstructarray("phonebooth","script_noteworthy");
	foreach(var_0B in var_09)
	{
		var_0B.quest_state = 0;
	}

	scripts\cp\maps\cp_disco\phonebooth::update_all_phonebooth_scriptable_states();
	scripts\common\utility::flag_wait("disco_roof power_on");
	var_01.poster makeusable();
	var_01.poster waittill("trigger");
	level thread scripts\cp\_vo::func_E01F("missing_item_misc");
	var_01.poster setmodel("cp_disco_poster_nightmare_summer_torn");
	var_01.poster show();
	var_0D = scripts\common\utility::getstruct("nade_toss_point","targetname");
	var_0E = spawn("script_model",var_0D.origin);
	var_0E setmodel("zmb_rat");
	var_0E setcandamage(1);
	var_0E waittill("damage",var_0F,var_10,var_11,var_12,var_13,var_14,var_15,var_16,var_17,var_18);
	var_0E delete();
	scripts\common\utility::flag_set("skq_p2t2_4");
}

//Function Number: 45
watch_for_spotlight_power(param_00)
{
	level endon("game_ended");
	scripts\common\utility::flag_wait("disco_roof power_on");
	playsoundatpos((-1638,2988,1305),"power_buy_powerup_lr");
	playsoundatpos(param_00.var_1B9.origin,"power_buy_rooftop_spotlight_turn_on");
	var_01 = param_00.var_1B9.model;
	param_00.var_1B9 setmodel("cp_disco_searchlight_swivel_on");
	var_02 = getentarray("quest_light_fx","targetname");
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04))
		{
			var_04 setlightintensity(150);
		}
	}

	var_06 = param_00.fx_struct;
	var_07 = spawnfx(level._effect["spotlight_flare"],var_06.origin + anglestoforward(var_06.angles) * -15,anglestoforward(var_06.angles),anglestoup(var_06.angles));
	wait(0.1);
	triggerfx(var_07);
	param_00.poster waittill("trigger");
	foreach(var_04 in var_02)
	{
		if(isdefined(var_04))
		{
			var_04 setlightintensity(0);
		}
	}

	var_06 = scripts\common\utility::getstruct("spotlight_x_marker","targetname");
	var_0A = undefined;
	if(isdefined(var_06))
	{
		playsoundatpos((-1096,3287,1222),"place_flyer_on_spotlight");
		var_0A = spawnfx(level._effect["spotlight_x"],var_06.origin,anglestoforward(var_06.angles),anglestoup(var_06.angles));
		wait(0.1);
		triggerfx(var_0A);
	}

	scripts\common\utility::flag_wait("skq_p2t2_4");
	if(isdefined(var_0A))
	{
		var_0A delete();
	}

	param_00.var_1B9 setmodel(var_01);
	var_07 delete();
}

//Function Number: 46
init_poster_nums(param_00)
{
	level endon("game_ended");
	level endon("reset_posters");
	level endon("correct_poster_got");
	var_01 = getentarray("mpq_poster_model","targetname");
	if(!param_00)
	{
		foreach(var_03 in var_01)
		{
			var_03.var_C211 = getent(var_03.target,"targetname");
		}
	}
	else
	{
		foreach(var_03 in var_03)
		{
			var_03 notify("reset_posters");
		}
	}

	var_01 = scripts\common\utility::func_22A8(var_01);
	var_07 = ["281","407","420","596","713","818"];
	var_07 = scripts\common\utility::func_22A8(var_07);
	level.morse_number = var_07[0];
	var_08 = 0;
	foreach(var_03 in var_01)
	{
		if(var_03 == var_01[0])
		{
			var_03.model_num = level.morse_number;
			if(param_00)
			{
				var_03 thread use_poster_logic(1);
			}

			var_08++;
		}
		else
		{
			var_03.model_num = var_07[var_08];
			if(var_08 + 1 >= var_07.size)
			{
				var_08 = 1;
			}
			else
			{
				var_08++;
			}

			if(param_00)
			{
				var_03 thread use_poster_logic(0);
			}
		}

		var_03.var_C211 setmodel("cp_disco_film_registration_decal_" + var_03.model_num);
	}

	if(!param_00)
	{
		return var_01;
	}
}

//Function Number: 47
use_poster_logic(param_00)
{
	level endon("game_ended");
	scripts\common\utility::flag_wait("skq_p2t2_1");
	self makeusable(1);
	self method_84A5(45);
	self method_84A2(96);
	var_01 = scripts\common\utility::func_13734("trigger","correct_poster_got","reset_posters");
	if(var_01 == "correct_poster_got" || var_01 == "reset_posters")
	{
		return;
	}

	if(param_00)
	{
		var_02 = getentarray("mpq_poster_model","targetname");
		foreach(var_04 in var_02)
		{
			var_04 notify("correct_poster_got");
		}

		self.var_C211 delete();
		self delete();
		level scripts\cp\_utility::set_quest_icon(16);
		scripts\common\utility::flag_set("correct_poster_got");
		level.phone_puzzle_phone = undefined;
		return;
	}

	level thread reset_phone_puzzle();
}

//Function Number: 48
empty_hint(param_00,param_01)
{
	return "";
}

//Function Number: 49
p2t2_4_kung_fu_fight()
{
	level endon("game_ended");
	var_00 = scripts\common\utility::func_6E4F("skq_p2t2_4","skq_p2t2_4dbg");
	var_01 = scripts\common\utility::getstruct("kf_zombies_disco_roof","targetname");
	level.spotlight_roof_zoms = 0;
	var_01 mpq_spawn_special_wave(level.spotlight_roof_zoms,10);
	scripts\common\utility::flag_set("skq_p2t2_5");
}

//Function Number: 50
p2t2_5_rat_king_puzzle()
{
	level endon("game_ended");
	var_00 = scripts\common\utility::func_6E4F("skq_p2t2_5","skq_p2t2_5dbg");
	var_01 = build_word_codex_list();
	solve_word_logic(var_01);
}

//Function Number: 51
solve_word_logic(param_00)
{
	level endon("game_ended");
	var_01 = [];
	var_01[0] = scripts\common\utility::getstruct("letter_puzzle_solve_struct","targetname");
	level.bchartoggle = 0;
	level.cur_puzzle_letter = undefined;
	level.rooftopcypherglyphs = [];
	while(isdefined(var_01[var_01.size - 1].target))
	{
		var_01[var_01.size] = scripts\common\utility::getstruct(var_01[var_01.size - 1].target,"targetname");
		wait(0.05);
	}

	var_02 = 0;
	var_03 = thread setup_cipher_glyphs();
	var_04 = 0;
	wait(1);
	var_05 = determine_puzzle_wordlist(param_00);
	var_06 = 0;
	var_07 = 0;
	while(!var_02)
	{
		if(var_04 >= var_05.size)
		{
			var_04 = 0;
			var_05 = determine_puzzle_wordlist(param_00);
			var_06 = 0;
			foreach(var_09 in level.players)
			{
				var_09 playlocalsound("ww_magicbox_laughter");
			}

			wait_for_wave_change(1);
		}

		var_0B = 0;
		var_02 = 0;
		var_0C = undefined;
		var_0D = [];
		var_03 = [];
		var_0E = var_05[var_06];
		if(!var_07 && randomint(101) == 100)
		{
			var_07 = 1;
			var_0E = "savagemadethis";
		}

		for(;;)
		{
			var_0F = getsubstr(var_0E,var_0B,var_0B + 1);
			if(!isdefined(var_0F) || var_0F == "")
			{
				var_02 = 1;
				break;
			}
			else
			{
				if(var_0B != 0)
				{
					level.cur_puzzle_letter = var_0F;
					level.bchartoggle = 1;
					level waittill("puzzle_letter_shot",var_0C);
					if(var_0C != var_0F)
					{
						playsoundatpos(var_01[var_0B].origin,"mpq_fail_buzzer");
						var_04++;
						var_06++;
						foreach(var_11 in var_0D)
						{
							var_11 delete();
						}

						wait(0.2);
						break;
					}
				}

				var_0D[var_0B] = spawnfx(level._effect["magnet_alphabet_" + var_0F],var_01[var_0B].origin,anglestoforward(var_01[var_0B].angles),anglestoup(var_01[var_0B].angles));
				wait(0.1);
				triggerfx(var_0D[var_0B]);
			}

			var_0B++;
		}

		if(var_02)
		{
			level thread delaydeleteletters(var_0D);
		}
	}

	foreach(var_11 in level.rooftopcypherglyphs)
	{
		if(isdefined(var_11))
		{
			var_11 delete();
		}
	}

	level.rooftopcypherglyphs = undefined;
	thread rk_symbol_handler("rk_symbol_punk_rooftops","skq_p2t2_6");
}

//Function Number: 52
delaydeleteletters(param_00)
{
	level endon("game_ended");
	wait(5);
	foreach(var_02 in param_00)
	{
		var_02 delete();
	}
}

//Function Number: 53
waittill_character_change()
{
	level endon("game_ended");
	while(!level.bchartoggle)
	{
		wait(0.1);
	}

	level.bchartoggle = 0;
	return level.cur_puzzle_letter;
}

//Function Number: 54
setup_cipher_glyphs()
{
	level endon("game_ended");
	level endon("skq_p2t2_6");
	var_00 = scripts\common\utility::getstructarray("letter_puzzle_struct","script_noteworthy");
	var_01 = getent("letter_puzzle_clip","targetname");
	var_02 = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"];
	foreach(var_04 in var_00)
	{
		var_04.current_letter = undefined;
	}

	var_06 = undefined;
	for(;;)
	{
		var_07 = [];
		var_08 = waittill_character_change();
		var_00 = scripts\common\utility::func_22A8(var_00);
		var_02 = scripts\common\utility::func_22A8(var_02);
		var_09 = 0;
		if(isdefined(var_06))
		{
			while(var_00[0] == var_06)
			{
				var_00 = scripts\common\utility::func_22A8(var_00);
				wait(0.1);
			}
		}

		foreach(var_04 in var_00)
		{
			if(!isdefined(var_04.angles))
			{
				var_04.angles = (0,0,0);
			}

			if(var_04 == var_00[0])
			{
				var_06 = var_04;
				var_04.current_letter = var_08;
			}
			else
			{
				for(var_0B = var_09;var_0B < 26;var_0B++)
				{
					if(var_02[var_0B] != var_08)
					{
						var_04.current_letter = var_02[var_0B];
						var_09++;
						break;
					}
					else
					{
						var_09++;
					}
				}
			}

			var_0C = spawnfx(level._effect["cipher_alphabet_" + var_04.current_letter],var_04.origin + anglestoforward(var_04.angles + (0,90,0)) * -1,anglestoforward(var_04.angles),anglestoup(var_04.angles));
			var_07[var_07.size] = var_0C;
		}

		level.rooftopcypherglyphs = var_07;
		wait(0.1);
		foreach(var_0C in var_07)
		{
			triggerfx(var_0C);
		}

		var_04 = undefined;
		var_01 setcandamage(1);
		var_01.health = 999999;
		while(!isdefined(var_04))
		{
			var_01 waittill("damage",var_10,var_11,var_10,var_04);
			if(!isplayer(var_11))
			{
				var_04 = undefined;
				var_01.health = 999999;
				continue;
			}
		}

		var_01 setcandamage(0);
		var_00 = sortbydistance(var_00,var_04);
		var_12 = var_00[0].current_letter;
		level notify("puzzle_letter_shot",var_12);
		foreach(var_0C in var_07)
		{
			var_0C delete();
		}
	}
}

//Function Number: 55
p2t2_6_rat_king_fight()
{
	level endon("game_ended");
	var_00 = scripts\common\utility::getstruct("p2t2_6","script_noteworthy");
	var_01 = scripts\common\utility::func_6E4F("skq_p2t2_6","skq_p2t2_6dbg");
	scripts\cp\maps\cp_disco\rat_king::spawn_rat_king(var_00.origin,var_00.angles,1);
	level thread scripts\cp\maps\cp_disco\cp_disco::enableratkingpas();
	setrkabilities_p2t2_6();
	foreach(var_03 in level.players)
	{
		var_03 playsoundtoplayer("quest_stage_completed_gong_lr",var_03);
		if(var_03.var_134FD == "p5_")
		{
			var_03 thread scripts\cp\_vo::try_to_play_vo("ww_ratking_spawn_p5","rave_ww_vo","highest",70,0,0,1);
			continue;
		}

		var_03 thread scripts\cp\_vo::try_to_play_vo("ww_ratking_spawn","rave_ww_vo","highest",70,0,0,1);
	}

	if(level.players.size == 4)
	{
		level thread play_rat_king_vo_discussion(2);
	}

	level watchrkretreat(1000);
	thread createrelicinteraction("brain");
	scripts\cp\maps\cp_disco\kung_fu_mode::increase_trainer_interaction_progression();
	foreach(var_03 in level.players)
	{
		var_03 thread play_corresponding_vo(2);
	}
}

//Function Number: 56
play_corresponding_vo(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	if(!isplayer(self) && !isdefined(self.var_134FD))
	{
		return;
	}

	var_01 = "";
	switch(param_00)
	{
		case 1:
			var_01 = "defeat_ratking_1";
			break;

		case 2:
			var_01 = "defeat_ratking_2";
			break;

		case 3:
			var_01 = "defeat_ratking_3";
			break;
	}

	thread scripts\cp\_vo::try_to_play_vo(var_01,"disco_comment_vo","highest",30,1);
	wait(scripts\cp\_vo::func_7C76(self.var_134FD + var_01) + 5);
	thread scripts\cp\_vo::try_to_play_vo("pam_quest_complete","disco_comment_vo","highest",30,1);
}

//Function Number: 57
createrelicinteraction(param_00)
{
	level endon("game_ended");
	while(isdefined(level.rat_king))
	{
		scripts\common\utility::func_136F7();
	}

	var_01 = spawnstruct();
	var_01.origin = getrelicspawnpos();
	var_01.script_noteworthy = "mpq_relics";
	var_01.name = "mpq_relics";
	var_01.var_EE79 = "default";
	var_01.var_E1B9 = 0;
	var_01.var_D776 = 1;
	var_01.var_109DA = undefined;
	var_02 = spawn("script_model",var_01.origin + (0,0,4));
	var_02 setmodel("tag_origin_rk_relics");
	if(isdefined(var_01.angles))
	{
		var_02.angles = var_01.angles;
	}

	var_01.model = var_02;
	var_01.relic = param_00;
	var_03 = scripts\common\utility::func_5D14(var_01.origin,32,-100);
	var_04 = spawnfx(level._effect["relic_active"],var_03 + (0,0,1));
	var_01.var_7542 = var_04;
	triggerfx(var_04);
	var_01.model setscriptablepartstate("rk_models","active_" + var_01.relic);
	var_01 thread startrelicmoveloop(var_01,var_01.model);
	scripts\cp\_interaction::add_to_current_interaction_list(var_01);
	var_01 thread hiderkrelicsduringrkfight(var_01);
}

//Function Number: 58
hiderkrelicsduringrkfight(param_00)
{
	level endon("game_ended");
	scripts\common\utility::flag_wait("rk_fight_started");
	param_00.model hide();
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	scripts\common\utility::func_6E5A("rk_fight_started");
	param_00.model show();
	scripts\cp\_interaction::add_to_current_interaction_list(param_00);
}

//Function Number: 59
startrelicmoveloop(param_00,param_01)
{
	level endon("game_ended");
	param_01 endon("death");
	for(;;)
	{
		var_02 = 3;
		param_01 moveto(param_00.origin + (0,0,32),var_02);
		wait(var_02);
		param_01 moveto(param_00.origin,var_02);
		wait(var_02);
	}
}

//Function Number: 60
getrelicspawnpos()
{
	if(isdefined(level.rat_king_death_pos))
	{
		var_00 = level.rat_king_death_pos;
	}
	else
	{
		var_00 = level.players[0].origin;
	}

	if(!isinactivevolume(var_00))
	{
		var_00 = getpositionnearclosestplayer(var_00);
	}

	var_01 = getclosestpointonnavmesh(var_00) + (0,0,4);
	return var_01;
}

//Function Number: 61
isinactivevolume(param_00)
{
	if(!isdefined(level.var_1646))
	{
		return 1;
	}

	var_01 = sortbydistance(level.var_1646,param_00);
	foreach(var_03 in var_01)
	{
		if(function_010F(param_00,var_03))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 62
getpositionnearclosestplayer(param_00)
{
	var_01 = scripts\common\utility::getclosest(param_00,level.players);
	return getclosestpointonnavmesh(scripts\common\utility::func_5D14(var_01.origin,32,-100));
}

//Function Number: 63
mpqrelichintfunc(param_00,param_01)
{
	return "";
}

//Function Number: 64
mpqrelicusefunc(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_01.kung_fu_mode))
	{
		return;
	}

	if(scripts\common\utility::istrue(param_01.inlaststand))
	{
		return;
	}

	switch(param_00.relic)
	{
		case "brain":
			if(!scripts\common\utility::flag("brain_picked"))
			{
				scripts\common\utility::flag_set("brain_picked");
				if(param_01.var_134FD == "p5_")
				{
					param_01 thread scripts\cp\_vo::try_to_play_vo("ratking_brain","disco_comment_vo");
				}
				else
				{
					param_01 thread scripts\cp\_vo::try_to_play_vo("pam_collect_brain","disco_comment_vo");
				}
	
				param_01 thread scripts\cp\_vo::func_1769("pam_quest_return","disco_comment_vo",120,120,4,1);
				level scripts\cp\_utility::set_quest_icon(17);
				level scripts\cp\_utility::set_completed_quest_mark(2);
				param_00.model thread cleanupmpqbrain(param_00,param_01);
			}
			break;

		case "heart":
			if(!scripts\common\utility::flag("heart_picked"))
			{
				scripts\common\utility::flag_set("heart_picked");
				if(param_01.var_134FD == "p5_")
				{
					param_01 thread scripts\cp\_vo::try_to_play_vo("ratking_heart","disco_comment_vo");
				}
				else
				{
					param_01 thread scripts\cp\_vo::try_to_play_vo("pam_collect_heart","disco_comment_vo");
				}
	
				param_01 thread scripts\cp\_vo::func_1769("pam_quest_return","disco_comment_vo",120,120,4,1);
				level scripts\cp\_utility::set_quest_icon(7);
				level scripts\cp\_utility::set_completed_quest_mark(1);
			}
	
			if(!scripts\common\utility::istrue(param_01.has_heart))
			{
				param_01 scripts\cp\powers\coop_powers::func_8397("power_heart","primary",undefined,undefined,undefined,undefined,1);
				param_00.model thread cleanupmpqrelic(param_00,param_01);
			}
			break;

		case "eye":
			if(!scripts\common\utility::flag("eye_picked"))
			{
				scripts\common\utility::flag_set("eye_picked");
				param_01 thread scripts\cp\_vo::try_to_play_vo("pam_collect_eye","disco_comment_vo");
				param_01 thread scripts\cp\_vo::func_1769("pam_quest_return","disco_comment_vo",120,120,4,1);
				level scripts\cp\_utility::set_quest_icon(13);
				level scripts\cp\_utility::set_completed_quest_mark(4);
			}
	
			if(!scripts\common\utility::istrue(param_01.has_eye))
			{
				param_01 scripts\cp\powers\coop_powers::func_8397("power_rat_king_eye","secondary",undefined,undefined,undefined,1,1);
				param_00.model thread cleanupmpqrelic(param_00,param_01);
			}
			break;
	}
}

//Function Number: 65
cleanupmpqbrain(param_00,param_01)
{
	param_00 notify("clean_up_relic");
	scripts\cp\_interaction::remove_from_current_interaction_list(param_00);
	param_00.model setscriptablepartstate("interactions","pickup");
	wait(0.5);
	if(isdefined(param_00.var_7542))
	{
		param_00.var_7542 delete(param_01);
	}

	if(isdefined(param_00.model))
	{
		param_00.model delete(param_01);
	}
}

//Function Number: 66
cleanupmpqrelic(param_00,param_01)
{
	param_00 notify("clean_up_relic");
	param_00.model setscriptablepartstate("interactions","pickup_" + param_00.relic);
}

//Function Number: 67
setrkabilities_p2t2_6()
{
	scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("teleport",1);
	scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("melee_attack",1);
	scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("shield_attack",1);
	scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("summon",1);
	scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("block",0);
	scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("staff_stomp",0);
	scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("staff_projectile",0);
	scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("shield_attack_spot",0);
	level.rat_king_attack_priorities = [];
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "shield_attack";
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "melee_attack";
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "teleport";
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "summon";
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "staff_stomp";
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "staff_projectile";
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "block";
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "shield_attack_spot";
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "attack_zombies";
}

//Function Number: 68
p2t2_7_complete_task()
{
	var_00 = scripts\common\utility::func_6E4F("skq_p2t2_7","skq_p2t2_7dbg");
	scripts\cp\maps\cp_disco\kung_fu_mode::disable_trainer_interactions();
	foreach(var_02 in level.players)
	{
		var_02 thread scripts\cp\_vo::try_to_play_vo("pam_quest_ratking_heart","pam_dialogue_vo","highest",100,1);
		if(var_02.var_134FD == "p5_")
		{
			var_02 thread play_pam_reaction_vo("pam_quest_ratking_heart",0,1,0);
		}
	}

	scripts\common\utility::flag_set("skq_p2t3_0");
}

//Function Number: 69
play_pam_reaction_vo(param_00,param_01,param_02,param_03)
{
	self endon("disconnect");
	wait(scripts\cp\_vo::func_7C76(param_00));
	if(scripts\common\utility::istrue(param_01))
	{
		thread scripts\cp\_vo::try_to_play_vo("pam_instuctions_rat_eye","disco_comment_vo");
		return;
	}

	if(scripts\common\utility::istrue(param_02))
	{
		thread scripts\cp\_vo::try_to_play_vo("pam_instuctions_rat_heart","disco_comment_vo");
		return;
	}

	thread scripts\cp\_vo::try_to_play_vo("pam_instuctions_rat_brain","disco_comment_vo");
}

//Function Number: 70
phase_2_task_3()
{
	thread p2t3_0_missing_reel();
	thread p2t3_1_turnstile_puzzle();
	thread p2t3_2_chi_symbol();
	thread p2t3_3_disco_fever();
	thread p2t3_4_final_chi_door();
	thread p2t3_5_rat_king_fight();
	thread p2t3_6_complete_task();
}

//Function Number: 71
p2t3_0_missing_reel()
{
	level endon("game_ended");
	var_00 = scripts\common\utility::func_6E4F("skq_p2t3_0","skq_p2t3_0dbg");
	if(issubstr(var_00,"dbg"))
	{
	}
	else
	{
		wait_for_wave_change(3,1);
	}

	wait(35);
	var_01 = 0;
	while(!var_01)
	{
		var_01 = 1;
		foreach(var_03 in level.players)
		{
			if(isdefined(level.clock_interaction) && isdefined(level.clock_interaction.clock_owner) && level.clock_interaction.clock_owner == var_03)
			{
				var_01 = 0;
			}

			if(isdefined(level.clock_interaction_q2) && isdefined(level.clock_interaction_q2.clock_owner) && level.clock_interaction_q2.clock_owner == var_03)
			{
				var_01 = 0;
			}

			if(isdefined(level.clock_interaction_q3) && isdefined(level.clock_interaction_q3.clock_owner) && level.clock_interaction_q3.clock_owner == var_03)
			{
				var_01 = 0;
			}

			if(scripts\common\utility::istrue(var_03.isfasttravelling) || scripts\common\utility::istrue(var_03.var_9C54))
			{
				var_01 = 0;
			}
		}

		if(scripts\common\utility::istrue(level.gns_active))
		{
			var_01 = 0;
		}

		wait(0.1);
	}

	var_05 = scripts\common\utility::getstructarray("missing_reel_tp_struct","targetname");
	var_06 = getent("missing_reel_fire_trig","targetname");
	var_07 = scripts\common\utility::getstructarray("missing_reel_fire_struct","targetname");
	stop_spawn_wave();
	foreach(var_03 in level.players)
	{
		var_03 playlocalsound("bink_ducking_alias");
	}

	scripts\cp\_utility::play_bink_video("MissingReel",8,1);
	clear_existing_enemies();
	var_0A = 0;
	foreach(var_03 in level.players)
	{
		if(var_03 scripts\cp\_utility::isteleportenabled())
		{
			var_03 scripts\cp\_utility::allow_player_teleport(0);
		}

		thread missing_reel_pickup_players(var_05[var_0A],var_03);
		var_0A++;
	}

	thread missing_reel_fire_fx(var_07);
	var_06 thread missing_reel_trigger_damage(var_05);
	wait(7);
	level.wave_num = level.wave_num + randomintrange(2,4);
	foreach(var_03 in level.players)
	{
		var_03 setclientomnvar("zombie_wave_number",level.wave_num);
	}

	thread spawn_missing_reel_wave(var_05);
	wait(1);
	scripts\common\utility::func_6E59("reel_zoms_beaten",60);
	scripts\common\utility::flag_set("cleanup_reel_assets");
	foreach(var_10 in level.players)
	{
		if(!var_10 scripts\cp\_utility::isteleportenabled())
		{
			var_10 scripts\cp\_utility::allow_player_teleport(1);
		}
	}

	scripts\common\utility::func_6E2A("pause_wave_progression");
	level.var_13FA3 = 0;
	level.dont_resume_wave_after_solo_afterlife = 0;
	var_06.trigger_off = 1;
	var_06 notify("trigger_off");
	var_05 = scripts\common\utility::func_22A8(var_05);
	var_12 = scripts\common\utility::func_5D14(var_05[0].origin,30,-100);
	var_13 = spawn("script_model",var_12 + (0,0,32));
	var_14 = scripts\common\utility::spawn_tag_origin(var_13.origin + anglestoforward(var_13.angles) * 2,(0,0,0));
	var_13 setmodel("tag_origin");
	var_13 linkto(var_14);
	var_14 thread spin_linker_turnstile(var_13);
	wait(0.5);
	playfxontag(level._effect["turnstile_arm"],var_13,"tag_origin");
	var_13 makeusable();
	var_13 waittill("trigger",var_03);
	if(isdefined(var_03) && isplayer(var_03))
	{
		var_03 thread scripts\cp\_vo::try_to_play_vo("pam_collect_turnstile","disco_comment_vo");
		var_03 thread scripts\cp\_vo::func_1769("missing_item_misc","disco_comment_vo",200,120,4,1);
	}

	level scripts\cp\_utility::set_quest_icon(9);
	var_13 delete();
	var_14 delete();
	scripts\common\utility::flag_set("skq_p2t3_1");
}

//Function Number: 72
missing_reel_pickup_players(param_00,param_01)
{
	wait(1);
	param_00.tp_active = 1;
	if(scripts\common\utility::istrue(param_01.inlaststand) || scripts\common\utility::istrue(param_01.in_afterlife_arcade))
	{
		param_01 notify("arcade_special_interrupt");
		param_01.ignoreselfrevive = 1;
		scripts\cp\_laststand::func_4164(param_01);
		param_01 notify("revive_success");
		if(isdefined(param_01.reviveent))
		{
			param_01.reviveent notify("revive_success");
		}

		wait(6);
		if(isdefined(param_01.var_B0A0))
		{
			lib_0D50::func_E2CD(param_01);
		}
	}

	param_01 setorigin(param_00.origin);
	param_01 setplayerangles(param_00.angles);
	param_01.missing_reel = 1;
	param_01.ignoreselfrevive = undefined;
}

//Function Number: 73
spin_linker_turnstile(param_00)
{
	param_00 endon("trigger");
	for(;;)
	{
		self rotateyaw(360,2,0,0);
		wait(2);
	}
}

//Function Number: 74
spawn_missing_reel_wave(param_00)
{
	level.reel_zombies = 0;
	var_01 = [];
	var_02 = 0;
	foreach(var_04 in param_00)
	{
		if(isdefined(var_04.tp_active))
		{
			var_05 = scripts\common\utility::getstructarray(var_04.target,"targetname");
			var_06 = 6;
			var_06 = var_06 - floor(level.players.size / 2);
			var_06 = int(var_06);
			foreach(var_08 in var_05)
			{
				if(var_06 <= 0)
				{
					break;
				}

				var_09 = scripts\common\utility::func_5D14(var_08.origin,30,-100);
				var_0A = spawnstruct();
				var_0A.origin = var_09;
				var_0B = var_0A scripts\cp\zombies\zombies_spawning::func_1081B("generic_zombie",1);
				var_01[var_01.size] = var_0B;
				scripts\cp\zombies\zombies_spawning::func_93EB(1);
				var_02++;
				var_06--;
			}
		}
	}

	for(;;)
	{
		var_0E = 1;
		foreach(var_0B in var_01)
		{
			if(isdefined(var_0B) && isalive(var_0B))
			{
				var_0E = 0;
				break;
			}
		}

		if(var_0E)
		{
			break;
		}

		wait(0.1);
	}

	scripts\common\utility::flag_set("reel_zoms_beaten");
	scripts\cp\zombies\zombies_spawning::func_4FB8(var_02);
}

//Function Number: 75
teleport_zoms(param_00)
{
	var_01 = scripts\common\utility::getstructarray(self.target,"targetname");
	var_02 = 0;
	foreach(var_04 in param_00)
	{
		var_04 scripts\cp\zombies\cp_disco_spawning::func_BC94(var_01[var_02]);
		if(var_02 + 1 == var_01.size)
		{
			var_02 = 0;
			continue;
		}

		var_02++;
	}
}

//Function Number: 76
missing_reel_fire_fx(param_00)
{
	level endon("game_ended");
	var_01 = [];
	foreach(var_03 in param_00)
	{
		var_01[var_01.size] = spawnfx(level._effect["vfx_zb_carfire_b"],var_03.origin,anglestoforward(var_03.angles),anglestoup(var_03.angles));
	}

	wait(0.1);
	foreach(var_06 in var_01)
	{
		triggerfx(var_06);
	}

	scripts\common\utility::flag_wait("cleanup_reel_assets");
	foreach(var_06 in var_01)
	{
		var_06 delete();
	}
}

//Function Number: 77
missing_reel_trigger_damage(param_00)
{
	level endon("game_ended");
	level endon("cleanup_reel_assets");
	var_01 = 0;
	thread damage_reel_trigger_solo();
	for(;;)
	{
		level waittill("connected",var_02);
		var_02 setorigin(param_00[var_01].origin);
		var_02 setplayerangles(param_00[var_01].angles);
		var_02 thread damage_reel_trigger_solo(self);
		if(var_01 == 3)
		{
			var_01 = 0;
			continue;
		}

		var_01++;
	}
}

//Function Number: 78
damage_reel_trigger_solo()
{
	level endon("game_ended");
	level endon("cleanup_reel_assets");
	for(;;)
	{
		self waittill("trigger",var_00);
		var_00 dodamage(var_00.health * 2,self.origin);
	}
}

//Function Number: 79
p2t3_1_turnstile_puzzle()
{
	var_00 = scripts\common\utility::func_6E4F("skq_p2t3_1","skq_p2t3_1dbg");
	var_01 = getent("window_cover","targetname");
	var_01.ogpos = var_01.origin;
	var_02 = getent("window_cover_struct_clip","targetname");
	var_03 = 25;
	thread turnstile_glyph_logic();
	scripts\common\utility::flag_wait("turnstile_done");
	level thread scripts\cp\_vo::func_E01F("missing_item_misc");
	var_01 movez(60,8,3,3);
	scripts\common\utility::flag_wait("turnstyle_glyph_hit");
	var_04 = var_01.ogpos[2] - var_01.origin[2];
	var_01 movez(var_04,1,0,0);
	scripts\common\utility::flag_set("skq_p2t3_2");
}

//Function Number: 80
turnstile_glyph_logic()
{
	var_00 = scripts\common\utility::getstruct("window_cover_struct","targetname");
	var_01 = getent("window_cover_struct_clip","targetname");
	var_02 = spawnfx(level._effect["test_glyph_mpq"],var_00.origin,anglestoforward(var_00.angles),anglestoup(var_00.angles));
	scripts\common\utility::flag_wait("turnstile_done");
	triggerfx(var_02);
	var_01 setcandamage(1);
	var_01.health = 9999;
	var_01 waittill("damage");
	var_02 delete();
	scripts\common\utility::flag_set("turnstyle_glyph_hit");
	wait(2);
	scripts\cp\_utility::deactivatebrushmodel(var_01,1);
}

//Function Number: 81
init_turnstile()
{
	var_00 = scripts\common\utility::getstruct("turnstile","script_noteworthy");
	var_00.var_86A2 = "locoverride";
	scripts\cp\maps\cp_disco\cp_disco::addtopersonalinteractionlist(var_00);
	level.special_mode_activation_funcs["turnstile"] = ::setup_turnstile;
	level.normal_mode_activation_funcs["turnstile"] = ::setup_turnstile;
}

//Function Number: 82
setup_turnstile(param_00,param_01,param_02,param_03)
{
	if(scripts\common\utility::flag("skq_p2t3_2") || scripts\common\utility::flag("turnstile_done"))
	{
		param_00 setmodel("cp_disco_subway_turnstyle_animated");
		return;
	}

	param_00 setmodel("cp_disco_subway_turnstyle_missing_arm");
}

//Function Number: 83
use_turnstile(param_00,param_01)
{
	if(scripts\common\utility::flag("skq_p2t3_1") && !scripts\common\utility::flag("turnstile_done"))
	{
		var_02 = param_00.currentlyownedby[param_01.name];
		var_02 setmodel("cp_disco_subway_turnstyle_animated");
		playsoundatpos(var_02.origin,"disco_turnstile");
		var_02 scriptmodelplayanim("IW7_cp_turnstyle_rotate");
		scripts\common\utility::flag_set("turnstile_done");
		foreach(param_01 in level.players)
		{
			param_01 lib_0D2A::func_12D7C("MESSAGE_RECEIVED",1);
		}

		wait(2);
		var_02 method_8292();
	}
}

//Function Number: 84
p2t3_2_chi_symbol()
{
	var_00 = scripts\common\utility::func_6E4F("skq_p2t3_2","skq_p2t3_2dbg");
	level.task3ring_fxstruct = scripts\common\utility::getstruct("task_3_ring_struct","targetname");
	var_01 = randomintrange(6,10);
	zombie_challenge_ring(var_01,level.task3ring_fxstruct);
	var_02 = 5;
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		next_ring_struct();
		var_01 = randomintrange(6,10);
		zombie_challenge_ring(var_01,level.task3ring_fxstruct);
	}

	level notify("task3RingDone");
	foreach(var_05 in level.players)
	{
		var_05 playsoundtoplayer("quest_stage_completed_gong_lr",var_05);
	}

	wait(1);
	scripts\common\utility::flag_set("skq_p2t3_3");
}

//Function Number: 85
next_ring_struct()
{
	var_00 = scripts\common\utility::getstructarray("task_3_ring_struct_rand","targetname");
	var_00 = scripts\common\utility::func_22A8(var_00);
	foreach(var_02 in var_00)
	{
		if(level.task3ring_fxstruct != var_02)
		{
			level.task3ring_fxstruct = var_02;
			return;
		}
	}
}

//Function Number: 86
ring_explode_zombies()
{
	level endon("task3RingDone");
	self endon("death");
	var_00 = 1.5;
	var_01 = 0.3;
	var_02 = var_00 / var_01;
	for(;;)
	{
		var_03 = 1;
		if(distancesquared(level.task3ring_fxstruct.origin,self.origin) <= 30625)
		{
			for(var_04 = 0;var_04 < var_02;var_04++)
			{
				wait(var_01);
				if(distancesquared(level.task3ring_fxstruct.origin,self.origin) > 30625)
				{
					var_03 = 0;
					break;
				}
			}

			if(var_03)
			{
				break;
			}
		}

		wait(0.1);
	}

	level notify("ring_kill");
	self.atomize_me = 1;
	self dodamage(self.health * 2,level.task3ring_fxstruct.origin);
}

//Function Number: 87
p2t3_3_disco_fever()
{
	var_00 = scripts\common\utility::func_6E4F("skq_p2t3_3","skq_p2t3_3dbg");
	scripts\common\utility::flag_wait("fever_started");
	var_01 = 10;
	var_02 = undefined;
	var_03 = 1;
	var_04 = scripts\common\utility::getstruct("disco_fever_spawn_struct","targetname");
	for(;;)
	{
		if(isdefined(var_02))
		{
			var_01--;
			if(var_01 <= 0)
			{
				break;
			}

			var_05 = var_02;
			if(isdefined(var_05))
			{
				var_05.var_180 = 1;
				var_05.var_5273 = (0,0,0);
				var_05.bhasdiscofever = 1;
				var_05.dontmutilate = 1;
				var_05 method_841F();
				var_05 thread handle_fx_for_fever();
				var_05 waittill("death");
				var_02 = find_near_disco_zombie(var_04.origin);
			}
			else
			{
				var_02 = undefined;
			}

			continue;
		}

		if(var_03)
		{
			var_03 = 0;
		}
		else
		{
			level notify("update_fx");
			wait(10);
		}

		var_01 = 10;
		for(var_05 = undefined;!isdefined(var_05);var_05 = spawn_fever_zombie())
		{
			wait(0.05);
		}

		var_05 method_841F();
		var_05 thread handle_fx_for_fever();
		var_05 waittill("death");
		var_02 = find_near_disco_zombie(var_04.origin);
	}

	scripts\common\utility::flag_set("skq_p2t3_4");
}

//Function Number: 88
handle_fx_for_fever()
{
	self endon("death");
	wait(0.15);
	playfxontag(level._effect["disco_fever"],self,"tag_origin");
	thread setfevereffectsonhostmigration();
}

//Function Number: 89
setfevereffectsonhostmigration()
{
	self endon("death");
	self endon("disconnect");
	level waittill("host_migration_begin");
	level waittill("host_migration_end");
	if(!scripts\common\utility::flag("skq_p2t3_4"))
	{
		playfxontag(level._effect["disco_fever"],self,"tag_origin");
	}
}

//Function Number: 90
find_near_disco_zombie(param_00)
{
	var_01 = getent("disco_fever_vol","targetname");
	var_02 = [];
	foreach(var_04 in level.spawned_enemies)
	{
		if(isdefined(var_04.var_565C) && var_04.var_565C)
		{
			continue;
		}

		if((isdefined(var_04.agent_type) && var_04.agent_type == "karatemaster") || var_04.agent_type == "skater")
		{
			continue;
		}

		var_02[var_02.size] = var_04;
	}

	var_06 = sortbydistance(var_02,param_00);
	if(isdefined(var_06[0]) && var_06[0] istouching(var_01))
	{
		return var_06[0];
	}

	return undefined;
}

//Function Number: 91
spawn_fever_zombie()
{
	var_00 = scripts\common\utility::getstruct("disco_fever_spawn_struct","targetname");
	var_01 = scripts\common\utility::func_5D14(var_00.origin,30,-100);
	var_02 = spawnstruct();
	var_02.origin = var_01;
	var_02.var_ECF5 = undefined;
	var_02.var_EE79 = undefined;
	var_03 = var_02 scripts\cp\zombies\zombies_spawning::func_1081B("generic_zombie",1);
	if(!isdefined(var_03))
	{
		return undefined;
	}

	var_03.dontmutilate = 1;
	var_03.var_180 = 1;
	var_03.var_5273 = (0,0,0);
	var_03.bhasdiscofever = 1;
	return var_03;
}

//Function Number: 92
init_turntable()
{
	var_00 = scripts\common\utility::getstruct("disco_fever_interact","script_noteworthy");
	var_00.var_86A2 = "locoverride";
	scripts\cp\maps\cp_disco\cp_disco::addtopersonalinteractionlist(var_00);
	level.special_mode_activation_funcs["disco_fever_interact"] = ::setup_turntable;
	level.normal_mode_activation_funcs["disco_fever_interact"] = ::setup_turntable;
}

//Function Number: 93
setup_turntable(param_00,param_01,param_02,param_03)
{
	param_00 setmodel("cp_disco_record_02");
	if(scripts\common\utility::flag("skq_p2t3_3") || scripts\common\utility::flag("skq_p2t3_3dbg"))
	{
		param_00 thread rotate_platter(param_03);
	}
}

//Function Number: 94
rotate_platter(param_00)
{
	param_00 endon("disconnect");
	level endon("game_ended");
	self endon("p_ent_reset");
	while(self.model == "cp_disco_record_02")
	{
		self rotateyaw(360,1.5,0,0);
		wait(1.5);
	}
}

//Function Number: 95
discofeverhintfunc(param_00,param_01)
{
	param_01.var_9A3F method_83D6(0);
	param_01.var_9A3F method_84A5(360);
	return "";
}

//Function Number: 96
use_turntable(param_00,param_01)
{
	if(scripts\common\utility::flag("skq_p2t3_3") && !scripts\common\utility::flag("fever_started"))
	{
		scripts\common\utility::flag_set("fever_started");
	}
}

//Function Number: 97
p2t3_4_final_chi_door()
{
	var_00 = scripts\common\utility::func_6E4F("skq_p2t3_4","skq_p2t3_4dbg");
	thread rk_symbol_handler("rk_symbol_disco_streets","skq_p2t3_5");
}

//Function Number: 98
p2t3_5_rat_king_fight()
{
	var_00 = scripts\common\utility::getstruct("p2t3_5","script_noteworthy");
	var_01 = scripts\common\utility::func_6E4F("skq_p2t3_5","skq_p2t3_5dbg");
	scripts\cp\maps\cp_disco\rat_king::spawn_rat_king(var_00.origin,var_00.angles,1);
	level thread scripts\cp\maps\cp_disco\cp_disco::enableratkingpas();
	setrkabilities_p2t3_5();
	foreach(var_03 in level.players)
	{
		var_03 playsoundtoplayer("quest_stage_completed_gong_lr",var_03);
		if(var_03.var_134FD == "p5_")
		{
			var_03 thread scripts\cp\_vo::try_to_play_vo("ww_ratking_spawn_p5","rave_ww_vo","highest",70,0,0,1);
			continue;
		}

		var_03 thread scripts\cp\_vo::try_to_play_vo("ww_ratking_spawn","rave_ww_vo","highest",70,0,0,1);
	}

	if(level.players.size == 4)
	{
		level thread play_rat_king_vo_discussion(3);
	}

	level watchrkretreat(2500);
	thread createrelicinteraction("heart");
	scripts\cp\maps\cp_disco\kung_fu_mode::increase_trainer_interaction_progression();
	foreach(var_03 in level.players)
	{
		var_03 thread play_corresponding_vo(3);
	}
}

//Function Number: 99
setrkabilities_p2t3_5()
{
	scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("teleport",1);
	scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("melee_attack",1);
	scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("staff_stomp",1);
	scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("staff_projectile",1);
	scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("summon",1);
	scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("block",0);
	scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("shield_attack",0);
	scripts\cp\maps\cp_disco\rat_king_fight::togglerkability("shield_attack_spot",0);
	level.rat_king_attack_priorities = [];
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "staff_projectile";
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "staff_stomp";
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "melee_attack";
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "summon";
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "teleport";
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "shield_attack";
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "shield_attack_spot";
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "attack_zombies";
	level.rat_king_attack_priorities[level.rat_king_attack_priorities.size] = "block";
}

//Function Number: 100
p2t3_6_complete_task()
{
	var_00 = scripts\common\utility::func_6E4F("skq_p2t3_6","skq_p2t3_6dbg");
	level thread watchforallplayersinroom();
}

//Function Number: 101
watchforallplayersinroom()
{
	level endon("game_Ended");
	var_00 = getent("slime_pool","targetname");
	for(;;)
	{
		wait(0.1);
		var_00 waittill("trigger",var_01);
		if(!isplayer(var_01))
		{
			continue;
		}

		var_02 = 1;
		if(isdefined(level.clock_interaction) && scripts\common\utility::istrue(level.clock_interaction.clock_active))
		{
			continue;
		}

		if(isdefined(level.clock_interaction_q2) && scripts\common\utility::istrue(level.clock_interaction_q2.clock_active))
		{
			continue;
		}

		if(isdefined(level.clock_interaction_q3) && scripts\common\utility::istrue(level.clock_interaction_q3.clock_active))
		{
			continue;
		}

		foreach(var_04 in level.players)
		{
			if(scripts\common\utility::istrue(var_04.isrewinding))
			{
				var_02 = 0;
				break;
			}

			if(scripts\common\utility::istrue(var_04.isfasttravelling))
			{
				var_02 = 0;
				break;
			}

			if(scripts\common\utility::istrue(var_04.var_9C54))
			{
				var_02 = 0;
				break;
			}
		}

		if(var_02)
		{
			break;
		}
	}

	scripts\common\utility::flag_set("skq_phase_3");
}

//Function Number: 102
phase_3()
{
	var_00 = scripts\common\utility::func_6E4F("skq_phase_3","skq_phase_3dbg");
	level scripts\cp\maps\cp_disco\rat_king_fight::start_rk_fight();
}

//Function Number: 103
mpq_spawn_special_wave(param_00,param_01,param_02,param_03,param_04)
{
	level endon("game_ended");
	param_00 = param_01;
	var_05 = 0;
	var_06 = undefined;
	var_07 = undefined;
	var_08 = undefined;
	var_09 = undefined;
	if(scripts\cp\zombies\zombies_spawning::func_C209() < param_01)
	{
		var_06 = level.var_4B6E;
		var_07 = level.var_B467;
		var_08 = level.var_5274;
		var_09 = level.wave_num;
		while(level.var_4B6E == level.var_5274)
		{
			wait(0.05);
		}

		level.var_4B6E = 0;
		level.var_5274 = 24;
		level.var_10942 = 1;
		scripts\common\utility::flag_set("pause_wave_progression");
		level.var_13FA3 = 1;
		var_05 = 1;
	}

	if(isdefined(param_02))
	{
		playsoundatpos(self.origin,param_02);
	}

	if(isdefined(param_03))
	{
		playfx(level._effect[param_03],self.origin);
	}

	var_0A = getrandomnavpoints(self.origin,1024,param_01);
	scripts\cp\zombies\zombies_spawning::func_93EB(param_01);
	wait(2);
	var_0B = skeleton_spawner(var_0A,param_00,param_04);
	if(isdefined(param_04))
	{
		return var_0B;
	}

	wait_for_skeleton_death_or_timeout(var_0B,300);
	self.finished_final_part = 1;
	if(var_05)
	{
		level.var_10847 = undefined;
		level.var_13BD6 = undefined;
		level.var_10942 = undefined;
		level.var_13FA3 = 0;
		scripts\common\utility::func_6E2A("pause_wave_progression");
		if(level.wave_num == var_09)
		{
			level.var_4B6E = var_06;
			level.var_B467 = var_07;
			level.var_5274 = var_08;
		}
		else
		{
			level.var_4B6E = 0;
			level.var_B467 = scripts\cp\zombies\zombies_spawning::func_7ACD(level.wave_num);
			level.var_5274 = scripts\cp\zombies\zombies_spawning::func_7D10(level.wave_num);
		}
	}

	scripts\cp\zombies\zombies_spawning::func_4FB8(param_01);
	return 1;
}

//Function Number: 104
wait_for_skeleton_death_or_timeout(param_00,param_01)
{
	level endon("skeleton_timeout");
	level thread notify_after_time("skeleton_timeout",param_01);
	for(;;)
	{
		var_02 = 1;
		var_03 = 0;
		foreach(var_05 in param_00)
		{
			if(isdefined(var_05) && isalive(var_05) && isdefined(var_05.agent_type) && var_05.agent_type == "karatemaster")
			{
				var_02 = 0;
				var_03++;
			}
		}

		if(var_02)
		{
			break;
		}
		else
		{
		}

		wait(0.5);
	}
}

//Function Number: 105
notify_after_time(param_00,param_01)
{
	wait(param_01);
	self notify(param_00);
}

//Function Number: 106
determine_best_shovel_spawns(param_00,param_01)
{
	var_02 = [];
	var_03 = scripts\common\utility::getstructarray("camper_to_lake_spawner","targetname");
	var_03 = sortbydistance(var_03,param_00);
	for(var_04 = 0;var_04 < param_01;var_04++)
	{
		var_02[var_04] = var_03[var_04];
	}

	var_05 = scripts\common\utility::func_22A8(var_02);
	return var_02;
}

//Function Number: 107
get_rand_point(param_00)
{
	while(![[ level.var_164B ]](param_00))
	{
		param_00 = getrandomnavpoint(param_00,64);
		scripts\common\utility::func_136F7();
	}

	return param_00;
}

//Function Number: 108
skeleton_spawner(param_00,param_01,param_02)
{
	var_03 = [];
	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		param_00[var_04] = get_rand_point(param_00[var_04]);
		var_05 = spawn_skeleton_solo(param_00[var_04],param_02);
		if(isdefined(var_05))
		{
			var_05 thread skeleton_death_watcher(param_01);
			var_03[var_03.size] = var_05;
			var_05 thread set_skeleton_attributes();
			wait(1);
			continue;
		}

		param_01--;
	}

	return var_03;
}

//Function Number: 109
skeleton_death_watcher(param_00)
{
	level endon("game_ended");
	self waittill("death");
	param_00--;
}

//Function Number: 110
spawn_skeleton_solo(param_00,param_01)
{
	param_00 = scripts\common\utility::func_5D14(param_00,30,-100);
	var_02 = spawnstruct();
	var_02.origin = param_00;
	var_02.var_EE79 = "ground_spawn_no_boards";
	var_02.var_ECF5 = "spawn_ground";
	var_03 = 4;
	var_04 = 0.3;
	for(var_05 = 0;var_05 < var_03;var_05++)
	{
		if(isdefined(param_01))
		{
			var_02.var_ECF5 = undefined;
			var_02.var_EE79 = undefined;
			var_06 = var_02 scripts\cp\zombies\zombies_spawning::func_1081B(param_01,1);
		}
		else
		{
			var_06 = var_02 scripts\cp\zombies\zombies_spawning::func_1081B("karatemaster",1);
		}

		wait(var_04);
		if(isdefined(var_06))
		{
			return var_06;
		}
	}

	return undefined;
}

//Function Number: 111
set_skeleton_attributes()
{
	level endon("game_ended");
	self endon("death");
	self.dont_cleanup = 1;
	self.var_1F5 = "sprint";
	self.is_skeleton = 1;
	self.health = 800;
	self.maxhealth = 800;
	self waittill("intro_vignette_done");
	self.health = scripts\cp\zombies\cp_disco_spawning::func_3728("karatemaster");
}

//Function Number: 112
skeleton_arrival_cowbell(param_00)
{
	var_01 = (0,0,-11);
	var_02 = spawnfx(level._effect["superslasher_summon_zombie_portal"],param_00 + var_01,(0,0,1),(1,0,0));
	triggerfx(var_02);
	scripts\common\utility::waittill_any_3("death","intro_vignette_done");
	var_02 delete();
}

//Function Number: 113
build_word_codex_list()
{
	var_00 = [];
	var_00["rave"] = [];
	var_00["spaceland"] = [];
	var_00["disco"] = [];
	var_00["disco2"] = [];
	var_00["extinction"] = [];
	var_00["willard"] = [];
	var_00["characters"] = [];
	var_00["rave"] = ["harpoon","trees","dance","basement","slasher","memories","charms","boat","kevinsmith","fairies"];
	var_00["spaceland"] = ["brute","octonian","rollercoaster","arcade","slide","geyser","zapper","forgefreeze","bumpercars","yetieyes"];
	var_00["disco"] = ["rollerskates","katana","kungfu","nunchucks","dragon","crane","snake","tiger","pamgrier","arthur"];
	var_00["disco2"] = ["disco","ratking","subway","punks","blackcat","pinkcat","inferno","mcintosh","staff","shield"];
	var_00["extinction"] = ["cryptid","drcross","hives","ancestor","breeder","kraken","obelisk","davidarcher","nightfall","samantha"];
	var_00["willard"] = ["shuffle","winonawyler","director","death","redwoods","mephistopheles","sixtymillion","afterlife","spaceland","shaolin"];
	var_00["characters"] = ["werewolfpoets","losangeles","realitytv","beverlyhills","ghetto","broadway","comicbooks","newyork","actors","audition"];
	return var_00;
}

//Function Number: 114
determine_puzzle_wordlist(param_00)
{
	var_01 = [];
	var_02 = randomintrange(0,101);
	var_03 = scripts\common\utility::func_22A8(getarraykeys(param_00));
	if(!isdefined(level.current_active_word_list) || var_03[0] == level.current_active_word_list)
	{
		level.current_active_word_list = var_03[1];
		var_01 = scripts\common\utility::func_22A8(param_00[var_03[1]]);
		return var_01;
	}

	level.current_active_word_list = var_03[0];
	var_01 = scripts\common\utility::func_22A8(param_00[var_03[0]]);
	return var_01;
}

//Function Number: 115
clear_existing_enemies()
{
	foreach(var_01 in level.spawned_enemies)
	{
		if(isalive(var_01) && var_01.health >= 1)
		{
			var_01.var_54CB = 1;
			var_01.nocorpse = 1;
			var_01 suicide();
		}
	}

	scripts\common\utility::func_136F7();
}

//Function Number: 116
stop_spawn_wave()
{
	scripts\common\utility::flag_set("pause_wave_progression");
	level.var_13FA3 = 1;
	level.dont_resume_wave_after_solo_afterlife = 1;
}

//Function Number: 117
wait_for_wave_change(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	var_02 = 4;
	if(isdefined(param_01))
	{
		foreach(var_04 in level.players)
		{
			var_04 setclientomnvar("zom_escape_gate_score",var_02);
		}
	}

	for(var_06 = 0;var_06 < param_00;var_06++)
	{
		var_02--;
		var_07 = level.wave_num;
		while(var_07 == level.wave_num)
		{
			wait(1);
		}

		if(isdefined(param_01))
		{
			foreach(var_04 in level.players)
			{
				var_04 setclientomnvar("zom_escape_gate_score",var_02);
			}
		}
	}
}

//Function Number: 118
show_effects_for_eye_only(param_00,param_01,param_02)
{
	level endon("game_ended");
	for(;;)
	{
		foreach(var_04 in level.players)
		{
			var_04 thread determine_effect_visibility(param_00,param_02);
		}

		var_06 = level scripts\common\utility::func_13734("rat_king_eye_activated","rat_king_eye_deactivated","connected",param_01);
		if(var_06 == param_01)
		{
			break;
		}
	}

	foreach(var_04 in level.players)
	{
		var_04 thread determine_effect_visibility();
	}
}

//Function Number: 119
determine_effect_visibility(param_00,param_01)
{
	if(!isdefined(param_00) || !isdefined(param_01))
	{
		if(isdefined(self.active_effect))
		{
			self.active_effect delete();
		}

		return;
	}

	var_02 = param_01;
	if(scripts\common\utility::istrue(self.wearing_rat_king_eye))
	{
		var_03 = function_01E1(level._effect[param_00],var_02.origin,self,anglestoforward(var_02.angles),anglestoup(var_02.angles));
		self.active_effect = var_03;
		wait(1);
		triggerfx(var_03);
		return;
	}

	if(isdefined(self.active_effect))
	{
		self.active_effect delete();
	}
}

//Function Number: 120
monitor_spawning_agents(param_00,param_01)
{
	level endon(param_01);
	level endon("game_ended");
	for(;;)
	{
		level waittill("agent_spawned",var_02);
		var_02 scripts\common\utility::func_5127(0.05,param_00);
	}
}

//Function Number: 121
rk_symbol_handler(param_00,param_01)
{
	level endon("game_ended");
	var_02 = scripts\common\utility::getstruct(param_00,"targetname");
	var_03 = scripts\common\utility::spawn_tag_origin(var_02.origin,var_02.angles);
	var_03 makeusable();
	var_03 method_84A5(45);
	var_03 method_84A2(96);
	var_04 = scripts\common\utility::func_5D14(var_02.origin,30,-100);
	var_04 = var_04 + (0,0,1);
	var_05 = spawnfx(level._effect["test_glyph_mpq"],var_04,anglestoforward(var_02.angles),anglestoup(var_02.angles));
	triggerfx(var_05);
	foreach(var_07 in level.players)
	{
		var_07 playsoundtoplayer("quest_stage_completed_gong_lr",var_07);
	}

	var_03 method_84A5(180);
	var_03 waittill("trigger");
	var_03 delete();
	var_05 delete();
	scripts\common\utility::flag_set(param_01);
}

//Function Number: 122
failmpqstep()
{
	foreach(var_01 in level.players)
	{
		var_01 playsoundtoplayer("mpq_fail_buzzer",var_01);
	}
}