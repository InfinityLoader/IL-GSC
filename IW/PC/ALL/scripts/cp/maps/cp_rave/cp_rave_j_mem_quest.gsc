/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_rave\cp_rave_j_mem_quest.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 68
 * Decompile Time: 3422 ms
 * Timestamp: 10/27/2023 12:06:29 AM
*******************************************************************/

//Function Number: 1
j_mem_quest_init()
{
	scripts\common\utility::flag_init("photo_1_kev_given");
	scripts\common\utility::flag_init("photo_2_kev_given");
	scripts\common\utility::flag_init("photo_1_kev_vo_done");
	scripts\common\utility::flag_init("photo_2_kev_vo_done");
	level._effect["arm_symbol_column"] = loadfx("vfx/iw7/_requests/coop/vfx_zmb_skel_arm_telgraph.vfx");
	level._effect["j_mem_start_symbol"] = loadfx("vfx/iw7/levels/cp_rave/vfx_rave_j_mem_start.vfx");
	level._effect["slasher_appear"] = loadfx("vfx/iw7/levels/cp_rave/slasher/vfx_rave_slasher_teleportation_appear.vfx");
	level thread init_j_mem_arms();
	lib_0D52::func_DED3("jmem",0,::func_2B53,::do_find_thing_1,::func_2B53,::func_2B53);
	lib_0D52::func_DED3("jmem",1,::func_2B53,::do_circle_fight_1,::func_2B53,::func_2B53);
	lib_0D52::func_DED3("jmem",2,::func_2B53,::do_give_thing_to_kev_1,::func_2B53,::func_2B53);
	lib_0D52::func_DED3("jmem",3,::func_2B53,::do_find_thing_2,::func_2B53,::func_2B53);
	lib_0D52::func_DED3("jmem",4,::func_2B53,::do_circle_fight_2,::func_2B53,::func_2B53);
	lib_0D52::func_DED3("jmem",5,::func_2B53,::do_give_thing_to_kev_2,::func_2B53,::func_2B53);
	lib_0D52::func_DED3("jmem",6,::func_2B53,::do_find_thing_3,::func_2B53,::func_2B53);
	lib_0D52::func_DED3("jmem",7,::func_2B53,::do_circle_fight_3,::func_2B53,::func_2B53);
	lib_0D52::func_DED3("jmem",8,::func_2B53,::do_give_thing_to_kev_3,::func_2B53,::func_2B53);
	level.slasher_fight = 0;
}

//Function Number: 2
func_2B53()
{
}

//Function Number: 3
init_j_mem_arms()
{
	level.j_mem_arms = getentarray("j_mem_arm","targetname");
	foreach(var_01 in level.j_mem_arms)
	{
		var_01 thread init_arm();
	}

	level.j_mem_legs = getentarray("j_mem_leg","targetname");
	foreach(var_01 in level.j_mem_legs)
	{
		var_01 thread init_arm();
	}

	level.j_mem_heads = getentarray("j_mem_head","targetname");
	foreach(var_01 in level.j_mem_heads)
	{
		var_01 thread init_arm();
	}

	level.circle_fight_done = [];
}

//Function Number: 4
init_arm()
{
	self.turned_angles = self.angles;
	self.high_point = self.origin + (0,0,6);
	self.low_point = self.origin + (0,0,-20);
	self moveto(self.origin + (0,0,-15),1);
	self waittill("movedone");
	self.angles = (270,180,180);
	var_00 = randomintrange(-270,270);
	self rotateyaw(var_00,0.1);
	wait(0.1);
}

//Function Number: 5
init_find_thing_1()
{
}

//Function Number: 6
do_find_thing_1()
{
	while(!scripts\common\utility::istrue(level.met_kev))
	{
		wait(0.1);
	}

	find_thing("j_mem_1","cp_rave_quest_photo_03");
	give_thing_to_player("j_mem_1");
	level scripts\cp\_utility::set_quest_icon(13);
}

//Function Number: 7
do_find_thing_2()
{
	find_thing("j_mem_2","cp_rave_quest_photo_04");
	give_thing_to_player("j_mem_2");
	level scripts\cp\_utility::set_quest_icon(14);
}

//Function Number: 8
do_find_thing_3()
{
	find_thing("j_mem_3","p7_skulls_bones_head_01");
	give_thing_to_player("j_mem_3");
	level scripts\cp\_utility::set_quest_icon(15);
}

//Function Number: 9
complete_find_thing_1()
{
}

//Function Number: 10
init_circle_fight_1()
{
}

//Function Number: 11
do_circle_fight_1()
{
	circle_fight_loop_check("j_mem_1_place","circle_org_arm","cp_rave_j_mem_arm",level.j_mem_arms,"cp_rave_quest_photo_01","cp_rave_quest_photo_03");
}

//Function Number: 12
do_circle_fight_2()
{
	circle_fight_loop_check("j_mem_2_place","circle_org_leg","cp_rave_j_mem_arm",level.j_mem_legs,"cp_rave_quest_photo_02","cp_rave_quest_photo_04");
}

//Function Number: 13
do_circle_fight_3()
{
	circle_fight_loop_check("j_mem_3_place","circle_org_head","cp_rave_j_mem_arm",level.j_mem_heads,"p7_skulls_bones_head_01","p7_skulls_bones_head_01");
}

//Function Number: 14
complete_circle_fight_1()
{
}

//Function Number: 15
init_give_thing_to_kev_1()
{
}

//Function Number: 16
do_give_thing_to_kev_1()
{
	level scripts\cp\_utility::set_quest_icon(20);
	give_thing_to_kev("j_mem_1_give");
	level thread play_ambient_kevin_smith_vo_jay_memory();
}

//Function Number: 17
do_give_thing_to_kev_2()
{
	level scripts\cp\_utility::set_quest_icon(19);
	give_thing_to_kev("j_mem_2_give");
}

//Function Number: 18
do_give_thing_to_kev_3()
{
	scripts\common\utility::flag_set("survivor_trapped");
	level scripts\cp\_utility::set_quest_icon(15);
	level notify("third_quest_part_done");
}

//Function Number: 19
find_thing(param_00,param_01)
{
	var_02 = getent(param_00,"targetname");
	var_03 = spawn("script_model",var_02.origin);
	var_03 setmodel(param_01);
	if(param_00 == "j_mem_3")
	{
		var_02 moveto(var_02.origin + (0,0,15),1);
	}

	var_02 makeusable();
	var_02 sethintstring(&"CP_RAVE_PICKUP_ITEM");
	var_02 waittill("trigger",var_04);
	var_02 makeunusable();
	level.player_picked_up_thing = var_04;
	var_03 delete();
	if(param_00 == "j_mem_1")
	{
		var_04 thread play_jay_memory_pickup("memento_1","m10_jmewes_bff_1");
		return;
	}

	if(param_00 == "j_mem_2")
	{
		var_04 thread play_jay_memory_pickup("memento_2","m11_jmewes_bff_1");
		return;
	}

	if(param_00 == "j_mem_3")
	{
		var_04 play_mem_3_vo();
		return;
	}
}

//Function Number: 20
play_mem_3_vo()
{
	play_jay_memory_pickup("memento_3","m12_jmewes_bff_1");
	play_get_j_mem_vo_dialogue("j_mem_3");
	if(self.var_134FD == "p5_")
	{
		thread scripts\cp\_vo::try_to_play_vo("totheisland","rave_comment_vo");
	}
}

//Function Number: 21
give_thing_to_player(param_00)
{
	if(!isdefined(level.j_mem))
	{
		level.j_mem = [];
	}

	level.j_mem[param_00] = 1;
}

//Function Number: 22
play_get_j_mem_vo_dialogue(param_00)
{
	var_01 = strtok(param_00,"_");
	var_02 = var_01[2];
	if(param_00 != "j_mem_3")
	{
		return;
	}

	if(!isdefined(level.player_picked_up_thing))
	{
		return;
	}

	switch(level.player_picked_up_thing.var_134FD)
	{
		case "p1_":
			level.player_picked_up_thing thread scripts\cp\_vo::try_to_play_vo("mem3_p1_42_1","rave_dialogue_vo");
			break;

		case "p2_":
			level.player_picked_up_thing thread scripts\cp\_vo::try_to_play_vo("mem3_p2_45_1","rave_dialogue_vo");
			break;

		case "p3_":
			level.player_picked_up_thing thread scripts\cp\_vo::try_to_play_vo("mem3_p3_43_1","rave_dialogue_vo");
			break;

		case "p4_":
			level.player_picked_up_thing thread scripts\cp\_vo::try_to_play_vo("mem3_p4_44_1","rave_dialogue_vo");
			break;

		default:
			break;
	}
}

//Function Number: 23
unset_quest_icon(param_00)
{
	setomnvarbit("zombie_quest_piece",param_00,0);
	setclientmatchdata("questPieces","quest_piece_" + param_00,0);
}

//Function Number: 24
display_symbols(param_00,param_01)
{
	var_02 = [];
	var_03 = level.players.size;
	var_04 = 0;
	foreach(var_06 in param_00)
	{
		if(var_04 < var_03)
		{
			playfx(level._effect["j_mem_start_symbol"],var_06.origin);
			var_04++;
			wait(0.05);
		}
	}

	wait(param_01);
}

//Function Number: 25
circle_fight_loop_check(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(level.circle_fight_done[param_01]))
	{
		level.circle_fight_done[param_01] = 0;
	}

	var_06 = 1000000;
	var_07 = scripts\common\utility::getstruct(param_01,"targetname");
	if(!isdefined(level.photo))
	{
		level.photo = spawn("script_model",var_07.origin);
		level.photo setmodel("tag_origin");
		var_08 = getgroundposition(level.photo.origin,2);
		level.photo.origin = var_08 + (0,0,1);
	}

	while(!level.circle_fight_done[param_01])
	{
		wait_for_start_trigger(param_00,param_01);
		level.slasher_fight = 1;
		scripts\common\utility::func_6E2A("can_drop_coins");
		var_09 = get_model_name(param_01);
		level.photo setmodel(var_09);
		level.no_slasher = 1;
		if(isdefined(level.slasher))
		{
			level.slasher setscriptablepartstate("teleport","hide");
			wait(0.1);
			level.slasher hide();
			level.slasher suicide();
			wait(0.1);
		}

		level.forceravemode = 1;
		foreach(var_0B in level.players)
		{
			if(distancesquared(var_0B.origin,var_07.origin) < var_06)
			{
				var_0B.unlimited_rave = 1;
				level thread scripts\cp\maps\cp_rave\cp_rave::func_6619(var_0B);
			}
		}

		start_circle_fight_fx(param_03,param_02);
		level thread spawn_guys_to_fight(var_07,param_02,param_03,param_00);
		var_0D = 0;
		var_0E = level scripts\common\utility::func_13734("speaker_defense_failed","speaker_defense_completed");
		if(var_0E == "speaker_defense_completed")
		{
			for(var_0F = 0;var_0F < param_03.size;var_0F++)
			{
				var_10 = param_03[var_0F];
				if(var_0F == param_03.size - 1)
				{
					level.photo_soul = zombie_limb_soul_fly_to_photo(var_10.origin + (0,0,10),var_10,1);
					continue;
				}

				zombie_limb_soul_fly_to_photo(var_10.origin + (0,0,10),var_10);
			}

			end_circle_fight_fx(param_03,param_02);
			level.no_slasher = 1;
			level thread pick_up_charged_photo(param_01,param_04);
			level thread time_out_charged_photo(30);
			var_0E = level scripts\common\utility::func_13734("slasher_photo_timeout","slasher_photo_taken");
			if(var_0E == "slasher_photo_timeout")
			{
				level.photo_soul delete();
				level.forceravemode = 0;
				foreach(var_0B in level.players)
				{
					var_0B.unlimited_rave = 0;
					level thread scripts\cp\maps\cp_rave\cp_rave::func_695D(var_0B);
					level thread slash_a_perk(var_0B);
				}

				show_kev();
				var_0D = 1;
			}
			else
			{
				level thread slasher_fight(param_01,param_04,param_05);
				level.forceravemode = 0;
				var_0E = level scripts\common\utility::func_13734("slasher_timeout","slasher_killed");
				if(var_0E == "slasher_timeout")
				{
					show_kev();
					var_0D = 1;
					level.slasher setscriptablepartstate("teleport","hide");
					wait(0.1);
					level.slasher suicide();
				}
				else
				{
					if(scripts\common\utility::flag("photo_1_kev_vo_done") && scripts\common\utility::flag("photo_2_kev_vo_done"))
					{
					}
					else
					{
						show_kev();
					}

					level.slasher setscriptablepartstate("teleport","hide");
					wait(0.1);
					level.slasher hide();
					wait(0.1);
					level.slasher suicide();
					level.slasher_visible_in_normal_mode = 0;
					var_07 = scripts\common\utility::getstruct(param_01,"targetname");
					nuke_fx_kill_everyone();
					level drop_photo_from_slasher(level.slasher_drop,param_05,param_01);
				}
			}
		}
		else
		{
			lower_arm_array(param_03,param_02);
			foreach(var_0B in level.players)
			{
				var_0B.unlimited_rave = 0;
				level thread scripts\cp\maps\cp_rave\cp_rave::func_695D(var_0B);
				level thread slash_a_perk(var_0B);
			}

			var_0D = 1;
		}

		if(var_0D)
		{
			level.forceravemode = 0;
			end_circle_fight_fx(param_03,param_02);
			level.no_slasher = 0;
			level.photo show();
			nuke_fx_kill_everyone();
		}

		level.slasher_fight = 0;
		scripts\common\utility::flag_set("can_drop_coins");
		clear_defense_sequence_active_flag();
		wait(1);
	}

	foreach(var_10 in param_03)
	{
		var_10 hide();
	}

	if(isdefined(level.photo))
	{
		level.photo delete();
	}

	if(isdefined(level.photo_soul))
	{
		level.photo_soul delete();
	}

	wait(2);
}

//Function Number: 26
nuke_fx_kill_everyone()
{
	var_00 = level.spawned_enemies;
	foreach(var_02 in var_00)
	{
		if(isalive(var_02) && isdefined(var_02.agent_type) && var_02.agent_type == "generic_zombie")
		{
			var_02.var_54CB = 1;
		}
	}

	var_04 = spawn("script_model",level.players[0].origin);
	var_04 setmodel("tag_origin");
	var_04.team = "allies";
	level.var_72AA = 1;
	scripts\cp\zombies\_powerups::func_D980(level.players[0],"kill_50",var_04,0);
}

//Function Number: 27
get_model_name(param_00)
{
	switch(param_00)
	{
		case "circle_org_arm":
			return "cp_rave_quest_photo_03";

		case "circle_org_leg":
			return "cp_rave_quest_photo_04";

		case "circle_org_head":
			return "p7_skulls_bones_head_01";
	}
}

//Function Number: 28
slash_a_perk(param_00)
{
	param_00 setclientomnvar("zombie_coaster_ticket_earned",1);
	if(isdefined(param_00.var_13FA4) && param_00.var_13FA4.size > 0)
	{
		var_01 = randomint(param_00.var_13FA4.size);
		var_02 = getarraykeys(param_00.var_13FA4);
		var_03 = scripts\common\utility::random(var_02);
		param_00 lib_0D5D::func_1145C(var_03);
	}
	else
	{
	}

	wait(3);
	param_00 setclientomnvar("zombie_coaster_ticket_earned",-1);
}

//Function Number: 29
wait_for_start_trigger(param_00,param_01)
{
	var_02 = 1000000;
	level.photo makeusable();
	level.photo sethintstring(&"CP_RAVE_PLACE_ITEM");
	for(;;)
	{
		level.photo waittill("trigger",var_03);
		var_04 = 0;
		foreach(var_06 in level.players)
		{
			if(distancesquared(var_06.origin,level.photo.origin) > var_02)
			{
				var_04 = 1;
				continue;
			}

			if(scripts\common\utility::istrue(var_06.var_DCEB))
			{
				var_04 = 1;
			}
		}

		if(var_04)
		{
			var_08 = scripts\common\utility::getstructarray(param_01 + "_symbol","targetname");
			display_symbols(var_08,2);
			continue;
		}

		break;
	}

	level.photo makeunusable();
	var_09 = get_quest_icon_num(param_01);
	unset_quest_icon(var_09);
	hide_kev();
}

//Function Number: 30
hide_kev()
{
	level.survivor hide();
	var_00 = scripts\common\utility::getstructarray("survivor_interaction","script_noteworthy");
	scripts\cp\_interaction::disable_like_interactions(var_00[0]);
}

//Function Number: 31
show_kev()
{
	level.survivor show();
	var_00 = scripts\common\utility::getstructarray("survivor_interaction","script_noteworthy");
	scripts\cp\_interaction::enable_like_interactions(var_00[0]);
}

//Function Number: 32
get_quest_icon_num(param_00)
{
	switch(param_00)
	{
		case "circle_org_arm":
			return 13;

		case "circle_org_leg":
			return 14;

		case "circle_org_head":
			return 15;
	}
}

//Function Number: 33
start_circle_fight_fx(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		add_to_and_play_arm_fx_array(param_00[var_02].origin);
		param_00[var_02] thread raise_arm(param_01);
		wait(0.1);
	}
}

//Function Number: 34
end_circle_fight_fx(param_00,param_01)
{
	if(isdefined(level.arm_fx))
	{
		foreach(var_03 in level.arm_fx)
		{
			if(isdefined(var_03))
			{
				var_03 delete();
			}
		}
	}
}

//Function Number: 35
lower_arm_array(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		wait(0.1);
		param_00[var_02] lower_arm(param_01);
		wait(0.1);
	}
}

//Function Number: 36
add_to_and_play_arm_fx_array(param_00)
{
	if(!isdefined(level.arm_fx))
	{
		level.arm_fx = [];
	}

	var_01 = spawnfx(level._effect["arm_symbol_column"],param_00);
	level.arm_fx[level.arm_fx.size] = var_01;
	wait(0.1);
	triggerfx(var_01);
}

//Function Number: 37
raise_arm(param_00)
{
	self setmodel(param_00);
	if(isdefined(self.high_point))
	{
		self moveto(self.high_point,0.2);
	}
	else
	{
		self moveto(self.origin + (0,0,10),0.2);
	}

	self waittill("movedone");
}

//Function Number: 38
lower_arm(param_00)
{
	if(isdefined(self.low_point))
	{
		self moveto(self.low_point,0.2);
	}
	else
	{
		self moveto(self.origin - (0,0,10),0.2);
	}

	self waittill("movedone");
}

//Function Number: 39
spawn_guys_to_fight(param_00,param_01,param_02,param_03)
{
	func_F34A();
	level thread func_110A0(param_00);
	thread func_10DF2(param_00);
	level thread fight_timer(60);
	level thread listen_for_circle_kills(param_01,param_02,param_03);
}

//Function Number: 40
func_F34A()
{
	if(!scripts\common\utility::func_6E34("defense_sequence_active"))
	{
		scripts\common\utility::flag_init("defense_sequence_active");
	}

	scripts\common\utility::flag_set("defense_sequence_active");
}

//Function Number: 41
clear_defense_sequence_active_flag()
{
	if(!scripts\common\utility::func_6E34("defense_sequence_active"))
	{
		scripts\common\utility::flag_init("defense_sequence_active");
	}

	scripts\common\utility::func_6E2A("defense_sequence_active");
}

//Function Number: 42
func_110A0(param_00)
{
	var_01 = level.var_4632;
	var_02 = level.var_4B6E;
	var_03 = level.var_B467;
	var_04 = level.var_5274;
	var_05 = level.wave_num;
	while(level.var_4B6E == level.var_5274)
	{
		wait(0.05);
	}

	level.var_4B6E = 0;
	if(scripts\cp\_utility::isplayingsolo() || scripts\common\utility::istrue(level.only_one_player))
	{
		level.var_B467 = 16;
	}
	else
	{
		level.var_B467 = 24;
	}

	level.var_5274 = 24;
	level.var_10942 = 1;
	scripts\common\utility::flag_set("pause_wave_progression");
	var_06 = level scripts\common\utility::func_13734("speaker_defense_failed","slasher_photo_timeout","slasher_timeout","slasher_killed");
	level.var_10847 = undefined;
	level.var_13BD6 = undefined;
	level.var_10942 = undefined;
	turn_despawn_back_on();
	wait(2);
	wait(3);
	scripts\common\utility::func_6E2A("pause_wave_progression");
	if(level.wave_num == var_05)
	{
		level.var_4B6E = var_02;
		level.var_B467 = var_03;
		level.var_5274 = var_04;
		return;
	}

	level.var_4B6E = 0;
	level.var_B467 = scripts\cp\zombies\zombies_spawning::func_7ACD(level.wave_num);
	level.var_5274 = scripts\cp\zombies\zombies_spawning::func_7D10(level.wave_num);
}

//Function Number: 43
func_10DF2(param_00)
{
	var_01 = level.var_1646;
	var_02 = undefined;
	var_03 = scripts\cp\_agent_utils::func_7DB0("axis");
	var_04 = scripts\common\utility::func_782F(param_00.origin,level.players,undefined,4,1000);
	foreach(var_06 in scripts\cp\_agent_utils::func_7DB0("axis"))
	{
		var_06 thread func_1887(var_06);
	}

	foreach(var_09 in var_01)
	{
		if(function_010F(param_00.origin,var_09))
		{
			var_02 = var_09;
			break;
		}
	}

	if(isdefined(var_02))
	{
		if(isdefined(var_02.var_1087B))
		{
			var_0B = scripts\common\utility::func_782F(param_00.origin,var_02.var_1087B,undefined,100,400);
			foreach(var_0D in var_0B)
			{
				var_0D scripts\cp\zombies\zombies_spawning::func_B288();
			}
		}

		foreach(var_10 in var_01)
		{
			if(var_10 == var_02)
			{
				continue;
			}

			var_10 scripts\cp\zombies\zombies_spawning::func_B292();
		}
	}

	level scripts\common\utility::func_13734("speaker_defense_failed","speaker_defense_completed");
	foreach(var_13 in var_01)
	{
		var_13 scripts\cp\zombies\zombies_spawning::func_B291();
	}
}

//Function Number: 44
turn_despawn_back_on()
{
	foreach(var_01 in level.spawned_enemies)
	{
		var_01.dont_cleanup = undefined;
	}
}

//Function Number: 45
func_1887(param_00,param_01)
{
	param_00 endon("death");
	if(scripts\common\utility::istrue(param_01))
	{
		wait(0.5);
	}

	param_00.var_1F5 = "sprint";
	param_00 lib_0A1B::func_2968("sprint");
}

//Function Number: 46
fight_timer(param_00)
{
	wait(param_00);
	level notify("speaker_defense_failed");
	deactivate_dismember_circle_logic();
}

//Function Number: 47
listen_for_circle_kills(param_00,param_01,param_02)
{
	level endon("speaker_defense_failed");
	level.circle_arms = 0;
	switch(param_02)
	{
		case "j_mem_1_place":
			func_15A6();
			level thread arm_counter(param_00,"add_arm",param_01);
			break;

		case "j_mem_2_place":
			func_15A7();
			level thread arm_counter(param_00,"add_leg",param_01);
			break;

		case "j_mem_3_place":
			activate_dismember_head();
			level thread arm_counter(param_00,"add_head",param_01);
			break;

		default:
			break;
	}

	while(level.circle_arms < 10)
	{
		wait(0.1);
	}

	deactivate_dismember_circle_logic();
	level notify("speaker_defense_completed");
}

//Function Number: 48
func_15A6()
{
	level thread dismember_circle_logic("arm");
}

//Function Number: 49
func_15A7()
{
	level thread dismember_circle_logic("leg");
}

//Function Number: 50
activate_dismember_head()
{
	level thread dismember_circle_logic("head");
}

//Function Number: 51
dismember_circle_logic(param_00)
{
	level endon("stop_circle_dismember_logic");
	for(;;)
	{
		level waittill("dismember",var_01,var_02);
		switch(var_02)
		{
			case 2:
			case 1:
				if(param_00 == "arm")
				{
					level notify("add_arm",var_01);
				}
				break;
	
			case 8:
			case 4:
				if(param_00 == "leg")
				{
					level notify("add_leg",var_01);
				}
				break;
	
			case 16:
				if(param_00 == "head")
				{
					level notify("add_head",var_01);
				}
				break;
		}
	}
}

//Function Number: 52
deactivate_dismember_circle_logic()
{
	level notify("stop_circle_dismember_logic");
}

//Function Number: 53
arm_counter(param_00,param_01,param_02)
{
	level endon("stop_circle_dismember_logic");
	foreach(var_04 in param_02)
	{
		var_04 thread raise_arm(param_00);
		wait(0.25);
	}

	wait(1);
	foreach(var_04 in param_02)
	{
		var_04 thread lower_arm(param_00);
		wait(0.25);
	}

	wait(2);
	var_08 = 5;
	var_09 = 5;
	for(;;)
	{
		level waittill(param_01,var_0A);
		if(level.circle_arms < 10)
		{
			level.circle_arms++;
			level thread play_fx_and_raise_arm(var_0A,param_02,param_00);
		}

		if(level.circle_arms > 9)
		{
			break;
		}
	}
}

//Function Number: 54
play_fx_and_raise_arm(param_00,param_01,param_02)
{
	zombie_limb_soul_fly_to_arm(param_00.origin,param_01[level.circle_arms - 1]);
	param_01[level.circle_arms - 1] raise_arm(param_02);
}

//Function Number: 55
zombie_limb_soul_fly_to_arm(param_00,param_01)
{
	var_02 = spawn("script_model",param_00);
	var_02 setmodel("tag_origin_soultrail");
	var_03 = level.photo.origin + (0,0,20);
	var_04 = var_02.origin;
	var_05 = distance(var_04,var_03);
	var_06 = var_05 / 450;
	if(var_06 < 0.05)
	{
		var_06 = 0.05;
	}

	var_02 moveto(var_03,var_06);
	var_02 waittill("movedone");
	var_03 = param_01.origin;
	var_04 = var_02.origin;
	var_05 = distance(var_04,var_03);
	var_06 = var_05 / 450;
	if(var_06 < 0.05)
	{
		var_06 = 0.05;
	}

	var_02 moveto(var_03,var_06);
	var_02 waittill("movedone");
	var_02 delete();
}

//Function Number: 56
zombie_limb_soul_fly_to_photo(param_00,param_01,param_02)
{
	var_03 = spawn("script_model",param_00);
	var_03 setmodel("tag_origin_soultrail");
	var_04 = level.photo.origin;
	var_05 = var_03.origin;
	var_06 = distance(var_05,var_04);
	var_07 = var_06 / 450;
	if(var_07 < 0.05)
	{
		var_07 = 0.05;
	}

	var_03 moveto(var_04,var_07);
	var_03 waittill("movedone");
	var_08 = "unused";
	param_01 thread lower_arm(var_08);
	if(isdefined(param_02))
	{
		return var_03;
	}

	var_03 delete();
}

//Function Number: 57
pick_up_charged_photo(param_00,param_01)
{
	level.photo show();
	var_02 = level.photo;
	var_02 setmodel(param_01);
	var_02 makeusable();
	var_02 sethintstring(&"CP_RAVE_INSPECT_ITEM");
	var_02 waittill("trigger",var_03);
	var_02 makeunusable();
	if(isdefined(level.photo_soul))
	{
		level.photo_soul delete();
	}

	var_02 hide();
	level notify("slasher_photo_taken");
}

//Function Number: 58
time_out_charged_photo(param_00)
{
	wait(param_00);
	level notify("slasher_photo_timeout");
}

//Function Number: 59
slasher_fight(param_00,param_01,param_02)
{
	var_03 = 1000000;
	var_04 = scripts\common\utility::getstruct(param_00,"targetname");
	var_05 = spawnfx(level._effect["memory_trap_loop"],var_04.origin + (0,0,-22));
	playfx(level._effect["slasher_appear"],var_04.origin);
	if(isdefined(level.photo_soul))
	{
		level.photo_soul delete();
	}

	level.no_slasher = 0;
	scripts\cp\maps\cp_rave\cp_rave::spawn_slasher_after_timer(0.1,var_04.origin);
	if(isdefined(level.slasher))
	{
		level.slasher.var_180 = 1;
		wait(2);
		playsoundatpos(var_04.origin,"slasher_rave_mode_exit_portal_fx");
		triggerfx(var_05);
		wait(2);
		level.slasher method_85B7(0);
		foreach(var_07 in level.players)
		{
			var_07.unlimited_rave = 0;
			level thread scripts\cp\maps\cp_rave\cp_rave::func_695D(var_07);
		}

		wait(2);
		level.slasher.var_180 = 0;
		var_05 delete();
		level.slasher_visible_in_normal_mode = 1;
		level.slasher thread get_slasher_death_loc();
		level.slasher thread time_out_slasher_fight(60);
	}
}

//Function Number: 60
time_out_slasher_fight(param_00)
{
	wait(param_00);
	level notify("slasher_timeout");
}

//Function Number: 61
get_slasher_death_loc()
{
	self waittill("fake_death");
	level.slasher setscriptablepartstate("teleport","hide");
	wait(0.1);
	level.slasher hide();
	level notify("slasher_killed");
	level.slasher_drop = self.origin;
}

//Function Number: 62
drop_photo_from_slasher(param_00,param_01,param_02)
{
	level.photo setmodel(param_01);
	level.photo show();
	level thread scripts\cp\zombies\_powerups::drop_loot(level.slasher_drop,undefined,"ammo_max");
	var_03 = spawn("script_model",level.photo.origin);
	var_03 setmodel("tag_origin_soultrail");
	level.photo makeusable();
	level.photo sethintstring(&"CP_RAVE_INSPECT_ITEM");
	level.photo waittill("trigger",var_04);
	level.photo hide();
	var_03 delete();
	if(param_01 == "cp_rave_quest_photo_03")
	{
		scripts\common\utility::flag_set("photo_1_kev_given");
		if(level.slasher_level < 2)
		{
			level.slasher_level = 2;
		}

		play_jay_memory_after_slasher_fight("m10_jmewes_bff_2");
	}
	else if(param_01 == "cp_rave_quest_photo_04")
	{
		scripts\common\utility::flag_set("photo_2_kev_given");
		if(level.slasher_level < 3)
		{
			level.slasher_level = 3;
		}

		play_jay_memory_after_slasher_fight("m11_jmewes_bff_2");
	}
	else
	{
		play_jay_memory_after_slasher_fight("m12_jmewes_bff_2");
	}

	level.circle_fight_done[param_02] = 1;
}

//Function Number: 63
give_thing_to_kev(param_00)
{
	if(param_00 == "j_mem_1_give")
	{
		scripts\common\utility::flag_wait("photo_1_kev_vo_done");
	}
	else if(param_00 == "j_mem_2_give")
	{
		scripts\common\utility::flag_wait("photo_2_kev_vo_done");
	}

	if(!isdefined(level.j_mem_complete))
	{
		level.j_mem_complete = [];
	}

	level.j_mem_complete[param_00] = self;
}

//Function Number: 64
play_j_mem_vo(param_00,param_01)
{
	scripts\cp\_vo::try_to_play_vo_on_all_players("m" + param_00 + "_jmewes_bff_" + param_01);
	wait(scripts\cp\_vo::func_7C76("m" + param_00 + "_jmewes_bff_" + param_01));
}

//Function Number: 65
play_jay_memory_pickup(param_00,param_01)
{
	thread scripts\cp\_vo::try_to_play_vo(param_00,"rave_comment_vo");
	wait(scripts\cp\_vo::func_7C76(self.var_134FD + param_00));
	wait(1);
	foreach(var_03 in level.players)
	{
		var_03 thread scripts\cp\_vo::try_to_play_vo(param_01,"rave_memory_vo");
	}
}

//Function Number: 66
play_ambient_kevin_smith_vo_jay_memory()
{
	level endon("game_ended");
	level endon("third_quest_part_done");
	if(!isdefined(level.times_played_mem_1))
	{
		level.times_played_mem_1 = 0;
	}

	if(!isdefined(level.times_played_mem_2))
	{
		level.times_played_mem_2 = 0;
	}

	wait(randomintrange(30,50));
	for(;;)
	{
		if(scripts\common\utility::istrue(level.j_mem["j_mem_1"]))
		{
			if(level.times_played_mem_1 == 0)
			{
				scripts\cp\_utility::func_D52A("ks_examine_memento_4",level.survivor.origin,1);
				wait(randomfloatrange(1,2));
				scripts\cp\_utility::func_D52A("ks_examine_memento_2",level.survivor.origin,1);
				wait(randomfloatrange(1,2));
				scripts\cp\_utility::func_D52A("ks_examine_memento_3",level.survivor.origin,1);
				wait(randomfloatrange(1,2));
			}
			else
			{
				return;
			}

			level.times_played_mem_1 = 1;
		}
		else if(scripts\common\utility::istrue(level.j_mem["j_mem_2"]))
		{
			if(level.times_played_mem_2 == 0)
			{
				scripts\cp\_utility::func_D52A("ks_examine_memento_6",level.survivor.origin,1);
				wait(randomfloatrange(1,2));
				scripts\cp\_utility::func_D52A("ks_examine_memento_5",level.survivor.origin,1);
				wait(randomfloatrange(1,2));
				scripts\cp\_utility::func_D52A("ks_examine_memento_3",level.survivor.origin,1);
				wait(randomfloatrange(1,2));
				level.times_played_mem_2 = 1;
			}
			else
			{
				return;
			}
		}

		wait(randomintrange(30,50));
	}
}

//Function Number: 67
play_jay_memory_after_slasher_fight(param_00)
{
	foreach(var_02 in level.players)
	{
		var_02 thread scripts\cp\_vo::try_to_play_vo(param_00,"rave_memory_vo");
	}
}

//Function Number: 68
play_jay_memory_to_kev(param_00)
{
	var_01 = 1;
	if(scripts\common\utility::flag("photo_2_kev_vo_done"))
	{
		var_01 = 3;
	}
	else if(scripts\common\utility::flag("photo_1_kev_vo_done"))
	{
		var_01 = 2;
	}

	var_02 = "memento_";
	thread scripts\cp\_vo::try_to_play_vo(var_02 + var_01 + 3,"rave_comment_vo");
	wait(scripts\cp\_vo::func_7C76(self.var_134FD + var_02 + var_01 + 3));
	thread scripts\cp\_vo::try_to_play_vo("ks_" + var_02 + "quest_" + var_01,"rave_ks_vo");
	wait(scripts\cp\_vo::func_7C76("ks_" + var_02 + "quest_" + var_01));
	wait(2);
	thread scripts\cp\_vo::try_to_play_vo("ks_" + var_02 + var_01,"rave_ks_vo");
	wait(scripts\cp\_vo::func_7C76("ks_" + var_02 + var_01));
	level thread scripts\cp\maps\cp_rave\cp_rave_interactions::add_back_to_interaction_system(param_00,"");
}