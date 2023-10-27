/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\zombie_afterlife_arcade.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 56
 * Decompile Time: 2464 ms
 * Timestamp: 10/27/2023 12:26:58 AM
*******************************************************************/

//Function Number: 1
func_6603(param_00)
{
	if(isdefined(level.rewind_afterlife_func))
	{
		level thread [[ level.rewind_afterlife_func ]](param_00);
	}

	if(!isdefined(param_00.var_6DDD))
	{
		param_00.var_6DDD = 1;
	}

	if(isdefined(level.afterlife_arcade_set_audio_zone_func))
	{
		param_00 thread [[ level.afterlife_arcade_set_audio_zone_func ]](param_00);
	}

	var_01 = func_77D5(param_00);
	func_41CE(param_00);
	level notify("player_entered_ala",param_00);
	param_00 notify("player_entered_ala");
	param_00.var_6977 = 0;
	if(isdefined(level.var_11929))
	{
		level.var_11929++;
	}

	param_00.var_118EE = gettime();
	param_00.health = param_00.maxhealth;
	param_00 method_8070(0.02);
	param_00 scripts\cp\_utility::stoplocalsound_safe("zmb_laststand_music");
	param_00 setorigin(var_01.origin);
	param_00 laststandrevive();
	param_00 setstance("stand");
	param_00 method_83B7();
	param_00 method_8447();
	param_00 scripts\cp\_utility::func_12C6("iw7_gunless_zm",undefined,undefined,1);
	param_00 scripts\common\utility::func_1C53(0);
	param_00 lib_0D5B::func_F53F(param_00,"afterlife");
	param_00 scripts\cp\_utility::func_7298();
	param_00 func_18E5(param_00);
	param_00 func_F3FA(param_00,0);
	param_00 func_93E4(param_00);
	if(isdefined(param_00))
	{
		if(func_3DCA(param_00))
		{
			param_00 scripts\cp\_utility::setlowermessage("welcome_to_afterlife",&"CP_ZOMBIE_AFTERLIFE_ARCADE_WELCOME",6);
		}
		else
		{
			param_00 scripts\cp\_utility::setlowermessage("welcome_to_afterlife_no_self_revives",&"CP_ZOMBIE_AFTERLIFE_ARCADE_NO_REVIVES",6);
		}

		scripts\cp\zombies\zombie_analytics::func_AF69(1,param_00,level.wave_num,param_00.var_10450,int(level.wave_num / 10) + 1 - param_00.times_self_revived);
	}

	if(param_00.var_6DDD)
	{
		param_00 thread scripts\cp\_vo::try_to_play_vo("spawn_arcade_first","zmb_comment_vo","highest",15,0,0,1,50);
		param_00.var_6DDD = 0;
	}
	else
	{
		param_00 thread scripts\cp\_vo::try_to_play_vo("spawn_arcade","zmb_comment_vo","high",15,0,0,1,50);
	}

	param_00 func_E226(param_00);
	param_00 thread func_D058(param_00);
	param_00 thread func_50CD(param_00,var_01.angles);
	param_00 thread func_2B1D(param_00);
	param_00 thread func_D052(param_00);
	level thread func_C5DA(param_00,10);
	param_00 func_F418(param_00,1);
	param_00 func_18E4(param_00,1);
	param_00 scripts\cp\_utility::func_8EC2(param_00.var_92B4);
	param_00 visionsetnakedforplayer("cp_zmb_afterlife",1);
	param_00 setclientomnvar("zm_ui_player_in_afterlife_arcade",1);
	param_00 setclientomnvarbit("player_damaged",1,0);
	param_00 setclientomnvarbit("player_damaged",2,0);
	if(scripts\cp\_utility::isplayingsolo() || level.only_one_player)
	{
		scripts\common\utility::flag_set("pause_wave_progression");
		level.var_13FA3 = 1;
		foreach(var_03 in scripts\cp\_agent_utils::func_7DB0("axis"))
		{
			if(isdefined(var_03.dont_cleanup))
			{
				continue;
			}

			if(isdefined(var_03.agent_type) && var_03.agent_type == "zombie_brute" || var_03.agent_type == "zombie_grey")
			{
				continue;
			}

			if(isdefined(var_03.agent_type) && var_03.agent_type == "crab_mini" || var_03.agent_type == "crab_brute")
			{
				var_03.vignette_nocorpse = 1;
			}

			var_03.var_54CB = 1;
			var_03 suicide();
		}

		param_00 thread scripts\cp\_hud_message::wait_and_play_tutorial_message("afterlife",18);
		thread give_solo_self_revive_token(param_00);
	}

	if(isdefined(level.enter_afterlife_clear_player_scriptable_func))
	{
		[[ level.enter_afterlife_clear_player_scriptable_func ]](param_00);
	}

	if(isdefined(level.aa_ww_char_vo))
	{
		param_00 thread [[ level.aa_ww_char_vo ]](param_00);
	}
	else
	{
		level thread play_willard_afterlife_vo(param_00);
	}

	if(isdefined(level.aa_memoirs_vo))
	{
		param_00 thread [[ level.aa_memoirs_vo ]](param_00);
	}

	param_00 thread freeze_controls_for_time();
}

//Function Number: 2
play_willard_afterlife_vo(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	while(scripts\common\utility::istrue(param_00.var_13518))
	{
		wait(0.1);
	}

	param_00 thread scripts\cp\_vo::try_to_play_vo("ww_afterlife_arrive","zmb_afterlife_vo","high",20,0,0,1);
}

//Function Number: 3
freeze_controls_for_time()
{
	self endon("disconnect");
	self allowmovement(0);
	wait(3);
	self allowmovement(1);
}

//Function Number: 4
play_ww_vo_memoirs(param_00)
{
	param_00 endon("disconnect");
	param_00 endon("death");
	level endon("game_ended");
	param_00 endon("player_done_exit_afterlife");
	wait(randomintrange(30,40));
	if(!isdefined(param_00.array_of_memoir_vos))
	{
		param_00.array_of_memoir_vos = ["ww_afterlife_memoir_1","ww_afterlife_memoir_2","ww_afterlife_memoir_3","ww_afterlife_memoir_4","ww_afterlife_memoir_5","ww_afterlife_memoir_6","ww_afterlife_memoir_7","ww_afterlife_memoir_8"];
	}

	while(param_00.array_of_memoir_vos.size > 0)
	{
		if(randomint(100) < 30)
		{
			scripts\common\utility::play_sound_in_space(param_00.array_of_memoir_vos[0],level.willard_speaker.origin);
		}

		param_00.array_of_memoir_vos = scripts\common\utility::func_22A9(param_00.array_of_memoir_vos,param_00.array_of_memoir_vos[0]);
		if(isdefined(param_00.array_of_memoir_vos[0]))
		{
			if(soundexists(param_00.array_of_memoir_vos[0]))
			{
				wait(randomfloatrange(80,110) + scripts\cp\_vo::func_7C76(param_00.array_of_memoir_vos[0]));
			}

			continue;
		}

		wait(randomfloatrange(120,180));
	}
}

//Function Number: 5
choose_correct_vo_for_player(param_00)
{
	wait(10);
	var_01 = "";
	if(param_00.times_self_revived >= param_00.max_self_revive_machine_use)
	{
		var_01 = "ww_afterlife_p4_notoken";
	}
	else
	{
		var_02 = ["ww_afterlife_p1_generic","ww_afterlife_p5_alt_1","ww_afterlife_arrive"];
		var_01 = scripts\common\utility::random(var_02);
	}

	if(var_01 == "ww_afterlife_arrive")
	{
		param_00 thread scripts\cp\_vo::try_to_play_vo(var_01,"zmb_afterlife_vo","high",20,0,0,1);
		return;
	}

	var_03 = strtok(var_01,"_");
	var_04 = "";
	var_05 = var_03[3];
	var_06 = param_00.vo_suffix;
	var_07 = strtok(var_06,"_");
	var_08 = var_07[0];
	switch(var_08)
	{
		case "p5":
		case "p4":
		case "p3":
		case "p2":
		case "p1":
			var_04 = choose_vo_based_on_type(var_08,var_05);
			break;

		default:
			var_04 = var_01;
			break;
	}

	if(soundexists(var_04))
	{
		param_00 thread scripts\cp\_vo::try_to_play_vo(var_04,"zmb_afterlife_vo","high",60,1,0,1);
	}
}

//Function Number: 6
choose_vo_based_on_type(param_00,param_01)
{
	var_02 = "ww_afterlife_";
	for(;;)
	{
		var_02 = "ww_afterlife_";
		switch(param_01)
		{
			case "generic":
				var_02 = var_02 + param_00 + "_generic";
				break;
	
			case "notoken":
				var_02 = var_02 + param_00 + "_notoken";
				break;
	
			case "alt":
				var_02 = var_02 + param_00 + "_alt_1";
				break;
	
			default:
				break;
		}

		if(!soundexists(var_02))
		{
			var_03 = ["ww_afterlife_p1_generic","ww_afterlife_arrive","ww_afterlife_p5_alt_1"];
			var_02 = scripts\common\utility::random(var_03);
			if(var_02 == "ww_afterlife_arrive")
			{
				return var_02;
			}
			else
			{
				var_04 = strtok(var_02,"_");
				param_01 = var_04[3];
				continue;
			}
		}
		else
		{
			return var_02;
		}

		scripts\common\utility::func_136F7();
	}

	return var_02;
}

//Function Number: 7
func_41CE(param_00)
{
	param_00.var_C8A2 = [];
}

//Function Number: 8
func_77D5(param_00)
{
	var_01 = scripts\common\utility::getstructarray("afterlife_arcade","targetname");
	if(isdefined(level.additional_afterlife_arcade_start_point))
	{
		var_01 = scripts\common\utility::array_combine(var_01,level.additional_afterlife_arcade_start_point);
	}

	var_01 = scripts\common\utility::array_randomize(var_01);
	foreach(var_03 in var_01)
	{
		if(can_spawn_at_afterlife_arcade_start_point(var_03,param_00))
		{
			return var_03;
		}
	}

	return scripts\common\utility::random(var_01);
}

//Function Number: 9
can_spawn_at_afterlife_arcade_start_point(param_00,param_01)
{
	var_02 = 16;
	foreach(var_04 in level.players)
	{
		if(var_04 == param_01)
		{
			continue;
		}

		if(distance2d(param_00.origin,var_04.origin) < var_02)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 10
func_12859(param_00)
{
	if(func_9C10(param_00))
	{
		func_693F(param_00);
	}
}

//Function Number: 11
clear_up_all_vo_in_afterlife(param_00)
{
	foreach(var_02 in level.var_134FE)
	{
		if(isdefined(param_00.var_13516.var_134FF[var_02]) && param_00.var_13516.var_134FF[var_02].size > 0)
		{
			foreach(var_04 in param_00.var_13516.var_134FF[var_02])
			{
				if(isdefined(var_04))
				{
					if(issubstr(var_04.var_1B46,"afterlife"))
					{
						param_00 stoplocalsound(var_04.var_1B46);
					}
				}
			}
		}
	}

	var_07 = undefined;
	if(isdefined(param_00.var_13516))
	{
		if(isdefined(param_00.var_13516.var_134C6))
		{
			if(isdefined(param_00.var_13516.var_134C6.var_1B46))
			{
				var_07 = param_00.var_13516.var_134C6.var_1B46;
			}
		}
	}

	if(isdefined(var_07))
	{
		param_00 stoplocalsound(var_07);
	}
}

//Function Number: 12
func_693F(param_00)
{
	if(param_00.var_AF9B == "wave_complete")
	{
		param_00.var_DDAD = "Wave Complete";
	}
	else
	{
		param_00.var_DDAD = "Self Revive";
	}

	if(param_00 hasweapon("iw7_gunless_zm"))
	{
		param_00 takeweapon("iw7_gunless_zm");
	}

	if(isdefined(level.afterlife_arcade_unset_audio_zone_func))
	{
		param_00 thread [[ level.afterlife_arcade_unset_audio_zone_func ]](param_00);
	}

	level thread func_4250(param_00);
	level thread clear_up_all_vo_in_afterlife(param_00);
	if(isdefined(param_00.var_55D5) && param_00.var_55D5 >= 1)
	{
		param_00 scripts\common\utility::func_1C53(1);
	}

	param_00.var_6977 = 1;
	param_00.var_1192F = gettime() - param_00.var_118EE / 1000;
	scripts\cp\zombies\zombie_analytics::func_AF6B(1,param_00,level.wave_num,param_00.var_DDAD,param_00.var_1192F);
	param_00 scripts\common\utility::func_1C6E(0);
	param_00 func_F418(param_00,0);
	param_00 func_18E4(param_00,0);
	param_00 scripts\cp\_utility::func_1012C(param_00.var_92B4);
	param_00 visionsetnakedforplayer("",0);
	param_00 setclientomnvar("zm_ui_player_in_afterlife_arcade",0);
	param_00.var_9C54 = undefined;
	param_00.is_in_pap = undefined;
	param_00 setclientomnvar("zombie_afterlife_soul_power_needed",-1);
	param_00 thread func_CD06(param_00);
	param_00 notify("player_done_exit_afterlife");
}

//Function Number: 13
func_CD06(param_00)
{
	param_00 endon("disconnect");
	if(isdefined(param_00.ignoreselfrevive))
	{
		return;
	}

	wait(4);
	if(!isdefined(param_00.var_C1F9))
	{
		param_00.var_C1F9 = 0;
	}

	param_00.var_C1F9++;
	if(param_00.var_C1F9 == 1)
	{
		param_00 thread scripts\cp\_vo::try_to_play_vo("arcade_token_revive_first","zmb_comment_vo","low",3,0,0,1);
		return;
	}

	param_00 thread scripts\cp\_vo::try_to_play_vo("arcade_token_revive","zmb_comment_vo","low",3,0,0,1);
}

//Function Number: 14
func_5172()
{
	wait(0.1);
	self delete();
}

//Function Number: 15
func_50CD(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("player_exit_afterlife");
	scripts\common\utility::func_136F7();
	param_00 setplayerangles(param_01);
}

//Function Number: 16
func_2B1D(param_00)
{
	param_00 endon("disconnect");
	var_01 = newclienthudelem(param_00);
	var_01.x = 0;
	var_01.y = 0;
	var_01 setshader("black",640,480);
	var_01.alignx = "left";
	var_01.aligny = "top";
	var_01.sort = 1;
	var_01.horzalign = "fullscreen";
	var_01.vertalign = "fullscreen";
	var_01.alpha = 1;
	var_01.foreground = 1;
	var_01 fadeovertime(15);
	var_01.alpha = 0;
	var_01 scripts\cp\_utility::func_1372C(15,param_00,"player_exit_afterlife",level,"game_ended");
	var_01 destroy();
}

//Function Number: 17
func_18E5(param_00)
{
	param_00.var_9A3F = scripts\cp\_interaction::func_7B99();
	scripts\cp\_interaction::func_E1F8();
	param_00.var_A8D3 = undefined;
	param_00.var_9A3F makeunusable();
	param_00 thread func_18E7();
	param_00 thread scripts\cp\_interaction::player_interaction_monitor();
}

//Function Number: 18
func_18E7()
{
	var_00 = self.var_9A3F;
	scripts\common\utility::waittill_any_3("player_exit_afterlife","spawned","disconnect");
	var_00.var_93A8 = 0;
}

//Function Number: 19
func_F418(param_00,param_01)
{
	param_00.in_afterlife_arcade = param_01;
}

//Function Number: 20
func_18E4(param_00,param_01)
{
	param_00.var_C004 = param_01;
	param_00.var_C016 = param_01;
}

//Function Number: 21
func_9C10(param_00)
{
	return scripts\common\utility::istrue(param_00.in_afterlife_arcade);
}

//Function Number: 22
func_975E()
{
}

//Function Number: 23
func_972F()
{
}

//Function Number: 24
func_1301F(param_00,param_01)
{
	if(level.players.size == 1)
	{
		param_01 scripts\cp\_interaction::func_9A3C(param_00,&"CP_ZOMBIE_AFTERLIFE_ARCADE_CANNOT_SPECTATE");
		return;
	}

	param_01.var_D7DC = param_01.origin;
	param_01.var_D7DB = param_01 getplayerangles();
	param_01 scripts\cp\_globallogic::func_662C();
	param_01 thread func_6962(param_01);
}

//Function Number: 25
func_6962(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("player_exit_afterlife");
	param_00 endon("spawned");
	param_00 notifyonplayercommand("release_use_button","-usereload");
	param_00 notifyonplayercommand("release_use_button","-activate");
	param_00 notifyonplayercommand("press_use_button","+usereload");
	param_00 notifyonplayercommand("press_use_button","+activate");
	param_00 waittill("release_use_button");
	param_00 waittill("press_use_button");
	param_00 scripts\cp\_utility::func_12F19("playing");
	param_00 spawn(param_00.var_D7DC,param_00.var_D7DB);
	param_00 method_8422(0);
	param_00 method_8424(0);
}

//Function Number: 26
func_1300F(param_00,param_01)
{
	param_01 endon("disconnect");
	if(param_01 scripts\cp\_utility::isplayingsolo() || level.only_one_player)
	{
		if(!scripts\common\utility::istrue(level.dont_resume_wave_after_solo_afterlife))
		{
			level thread resumespawningaftertime();
		}
	}

	if(!isdefined(param_01.ignoreselfrevive))
	{
		param_01 func_1794();
	}

	if(isdefined(param_01.var_55D5) && param_01.var_55D5 >= 1)
	{
		param_01 scripts\common\utility::func_1C53(1);
	}

	if(!isdefined(param_01.ignoreselfrevive))
	{
		func_BC83(param_01,"fast_travel_tube_start","fast_travel_tube_end");
		param_01 thread func_E0AE(0.1);
	}

	param_01 notify("player_exit_afterlife");
	param_01 scripts\cp\_laststand::func_992F(param_01);
	param_01 setclientomnvar("zombie_afterlife_soul_power_earned",0);
	param_01 setclientomnvar("zombie_afterlife_soul_power_goal",0);
	param_01 setclientomnvar("zombie_afterlife_soul_power_needed",-1);
	param_01 func_F3FA(param_01,0);
	if(param_01 scripts\cp\_utility::func_9BA0("self_revive"))
	{
		return;
	}

	if(param_01 scripts\cp\_utility::isplayingsolo() || level.only_one_player)
	{
		param_01.times_self_revived = param_01.var_F1E7;
		var_02 = param_01.max_self_revive_machine_use - param_01.times_self_revived;
	}
	else
	{
		var_02.times_self_revived = var_02.times_self_revived + 1;
		var_02 = int(level.wave_num / 10) + 1 - var_02.times_self_revived;
	}

	param_01 setclientomnvar("zombie_afterlife_self_revive_count",int(max(var_02,0)));
	param_01 thread set_spawn_defaults();
}

//Function Number: 27
set_spawn_defaults()
{
	self endon("disconnect");
	wait(0.15);
	self method_8422(0);
	self allowslide(1);
	self method_8424(0);
	self method_8412(0);
	self method_8426(0);
	self method_8425(0);
	self method_8454(3);
	if(isdefined(level.player_suit))
	{
		self method_845A(level.player_suit);
	}
	else
	{
		self method_845A("zom_suit");
	}

	self.var_111BC = "zom_suit";
}

//Function Number: 28
resumespawningaftertime()
{
	level endon("game_ended");
	wait(20);
	level.var_13FA3 = 0;
	scripts\common\utility::func_6E2A("pause_wave_progression");
}

//Function Number: 29
update_player_revives_every_ten_waves(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	for(var_01 = 0;var_01 < 2;var_01++)
	{
		level scripts\common\utility::waittill_any_3("regular_wave_starting","event_wave_starting");
		if(param_00 scripts\cp\_utility::isplayingsolo() || level.only_one_player)
		{
			continue;
		}
		else
		{
			var_02 = int(level.wave_num / 10) + 1 - param_00.times_self_revived;
		}

		param_00 setclientomnvar("zombie_afterlife_self_revive_count",int(max(var_02,0)));
	}
}

//Function Number: 30
func_BC83(param_00,param_01,param_02)
{
	var_03 = getent(param_01,"targetname");
	var_04 = getent(param_02,"targetname");
	if(!isdefined(var_03) || !isdefined(var_04))
	{
		return;
	}

	param_00 earthquakeforplayer(0.3,0.2,param_00.origin,200);
	param_00 cancelmantle();
	param_00.var_C004 = 1;
	param_00.var_C016 = 1;
	var_05 = var_03.origin + (0,0,-45);
	var_06 = var_04.origin + (0,0,-45);
	param_00.var_9BE1 = 1;
	param_00 scripts\cp\_utility::func_1C5C(1);
	param_00 dontinterpolate();
	param_00 setorigin(var_05);
	param_00 setplayerangles(var_03.angles);
	param_00 playlocalsound("zmb_portal_travel_lr");
	var_07 = spawn("script_origin",var_05);
	param_00 playerlinkto(var_07);
	wait(0.1);
	var_07 moveto(var_06,1);
	param_00 thread func_E0AE(0.1);
	wait(1);
	param_00.var_9BE1 = undefined;
	if(param_00 scripts\cp\_utility::func_9E3A())
	{
		param_00 scripts\cp\_utility::func_1C5C(0);
	}

	param_00.var_C004 = 0;
	param_00.var_C016 = 0;
	if(isdefined(level.var_D679))
	{
		var_08 = anglestoforward((0,90,0));
		playfx(level._effect["vfx_zmb_portal_exit_burst"],level.var_D679,var_08);
	}

	param_00 func_1794();
	var_07 thread func_5172();
}

//Function Number: 31
func_1794()
{
	if(isdefined(self.var_13D0C))
	{
		return;
	}

	self.var_13D0C = newclienthudelem(self);
	self.var_13D0C.x = 0;
	self.var_13D0C.y = 0;
	self.var_13D0C setshader("white",640,480);
	self.var_13D0C.alignx = "left";
	self.var_13D0C.aligny = "top";
	self.var_13D0C.sort = 1;
	self.var_13D0C.horzalign = "fullscreen";
	self.var_13D0C.vertalign = "fullscreen";
	self.var_13D0C.alpha = 1;
	self.var_13D0C.foreground = 1;
}

//Function Number: 32
func_E0AE(param_00)
{
	self endon("disconnect");
	if(isdefined(param_00))
	{
		wait(param_00);
	}

	if(isdefined(self.var_13D0C))
	{
		self.var_13D0C.alpha = 0;
		wait(0.1);
		if(isdefined(self.var_13D0C))
		{
			self.var_13D0C destroy();
		}
	}
}

//Function Number: 33
func_386A(param_00,param_01)
{
	if(scripts\cp\_utility::isplayingsolo() || scripts\common\utility::istrue(level.only_one_player))
	{
		return 1;
	}

	if(func_8BA8(param_01))
	{
		return 1;
	}

	return 0;
}

//Function Number: 34
func_7C53(param_00,param_01)
{
	if(func_3DCA(param_01))
	{
		if(func_8BA8(param_01) || scripts\cp\_utility::isplayingsolo() || scripts\common\utility::istrue(level.only_one_player))
		{
			return &"CP_ZOMBIE_AFTERLIFE_ARCADE_SELFREVIVE_DOOR";
		}

		return &"CP_ZOMBIE_AFTERLIFE_ARCADE_NEED_SELFREVIVE_TOKEN";
	}

	return &"CP_ZOMBIE_AFTERLIFE_ARCADE_NO_MORE_SELF_REVIVES";
}

//Function Number: 35
func_832E(param_00)
{
	param_00 thread scripts\cp\_vo::try_to_play_vo("arcade_token_earn","zmb_comment_vo","low",3,0,0,1);
	param_00 playlocalsound("zmb_ala_soul_meter_filled");
	param_00 func_F3FA(param_00,1);
	param_00.var_10450 = 0;
	param_00.var_1044F = 0;
	level thread func_C5DA(param_00,165);
	wait(5);
	param_00 thread scripts\cp\_vo::try_to_play_vo("ww_afterlife_overstay","zmb_afterlife_vo","high",undefined,undefined,undefined,1);
}

//Function Number: 36
give_solo_self_revive_token(param_00)
{
	param_00 playlocalsound("zmb_ala_soul_meter_filled");
	param_00 func_F3FA(param_00,1);
	param_00 setclientomnvar("zombie_afterlife_soul_power_needed",-1);
	param_00.var_10450 = 0;
	param_00.var_1044F = 0;
	level thread func_C5DA(param_00,165);
}

//Function Number: 37
func_C5DA(param_00,param_01)
{
	if(!isdefined(level.var_1B14))
	{
		level.var_1B15 = getent("ala_revive_door","targetname");
		var_02 = scripts\common\utility::getstruct("selfrevive_portal","targetname");
		level.var_1B14 = spawn("script_model",var_02.origin);
		level.var_1B14 setmodel("tag_origin");
		level.var_1B14.angles = var_02.angles;
		wait(0.1);
	}

	if(!isdefined(param_00.var_E498))
	{
		param_00.var_E498 = spawn("script_model",level.var_1B15.origin + (0,0,-300));
		param_00.var_E498 setmodel(level.var_1B15.model);
		param_00.var_E498.angles = level.var_1B15.angles;
		foreach(var_04 in level.players)
		{
			if(var_04 != param_00)
			{
				param_00.var_E498 method_8429(var_04);
			}
		}

		wait(0.1);
		param_00.var_E498.origin = param_00.var_E498.origin + (0,0,300);
		wait(0.1);
		level.var_1B15 method_8429(param_00);
	}

	param_00.var_E498 rotateyaw(param_01,0.2);
	var_06 = level._effect["vfx_zmb_portal_centhub"];
	if(isdefined(level.centhub_portal_fx))
	{
		var_06 = level.centhub_portal_fx;
	}

	playfxontagforclients(var_06,level.var_1B14,"tag_origin",param_00);
}

//Function Number: 38
func_4250(param_00)
{
	if(isdefined(param_00.var_E498))
	{
		param_00.var_E498.angles = level.var_1B15.angles;
	}

	function_0297(level._effect["vfx_zmb_portal_centhub"],level.var_1B14,"tag_origin",param_00);
}

//Function Number: 39
func_F3FA(param_00,param_01)
{
	param_00.var_8BA8 = param_01;
	if(param_01 == 1)
	{
		param_00 setclientomnvar("zombie_afterlife_has_self_revive_token",1);
		return;
	}

	param_00 setclientomnvar("zombie_afterlife_has_self_revive_token",0);
}

//Function Number: 40
func_8BA8(param_00)
{
	return scripts\common\utility::istrue(param_00.var_8BA8);
}

//Function Number: 41
func_3DCA(param_00)
{
	if(scripts\cp\_utility::isplayingsolo() || level.only_one_player)
	{
		return 1;
	}

	if(scripts\common\utility::istrue(param_00.have_gns_perk))
	{
		return 1;
	}

	if(param_00.times_self_revived >= param_00.max_self_revive_machine_use)
	{
		return 0;
	}

	if(int(level.wave_num / 10) + 1 - param_00.times_self_revived >= 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 42
func_D058(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("player_done_exit_afterlife");
	param_00 scripts\common\utility::func_13734("player_exit_afterlife","spawned");
	param_00 func_693F(param_00);
}

//Function Number: 43
func_94D7()
{
	level.var_11929 = 0;
	level.var_CF91 = ::func_6603;
}

//Function Number: 44
func_10B95()
{
	var_00 = spawn("script_origin",(-10100,114,-1753));
	var_00 playloopsound("zmb_afterlife_music");
}

//Function Number: 45
func_D052(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("player_done_exit_afterlife");
	wait(3);
	if(func_3DCA(param_00))
	{
		func_12991(param_00);
	}

	param_00 visionsetnakedforplayer("",2);
}

//Function Number: 46
func_12991(param_00)
{
	param_00 setclientomnvar("zombie_afterlife_soul_power_earned",param_00.var_10450);
	param_00 setclientomnvar("zombie_afterlife_soul_power_needed",param_00.var_10451);
	param_00 setclientomnvar("zombie_afterlife_soul_power_goal",param_00.var_10451);
}

//Function Number: 47
func_D0F7(param_00)
{
	param_00.var_92B4 = [];
}

//Function Number: 48
func_1766(param_00,param_01)
{
	param_00.var_92B4[param_00.var_92B4.size] = param_01;
}

//Function Number: 49
func_E01E(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return;
	}

	param_00.var_92B4 = scripts\common\utility::func_22A9(param_00.var_92B4,param_01);
	param_00.var_92B4 = scripts\common\utility::func_22BC(param_00.var_92B4);
}

//Function Number: 50
func_974F(param_00)
{
	param_00.var_10450 = 0;
	param_00.var_1044F = 0;
	param_00.times_self_revived = 0;
	param_00.var_10451 = func_7C74(param_00);
}

//Function Number: 51
func_8334(param_00,param_01)
{
	if(func_3DCA(param_00) && !func_8BA8(param_00))
	{
		param_00.var_10450 = param_00.var_10450 + param_01;
		param_00 thread func_56C9(param_00);
	}
}

//Function Number: 52
func_56C9(param_00)
{
	param_00 notify("display_soul_power_earned");
	level endon("game_ended");
	param_00 endon("display_soul_power_earned");
	param_00 endon("revive");
	while(param_00.var_1044F < min(param_00.var_10450,param_00.var_10451))
	{
		var_01 = min(param_00.var_10450,param_00.var_10451);
		var_02 = param_00.var_1044F + 5;
		param_00.var_1044F = min(var_02,var_01);
		param_00 setclientomnvar("zombie_afterlife_soul_power_earned",int(param_00.var_1044F));
		param_00 setclientomnvar("zombie_afterlife_soul_power_needed",int(param_00.var_10451 - param_00.var_1044F));
		scripts\common\utility::func_136F7();
	}

	if(param_00.var_10450 >= param_00.var_10451)
	{
		if(func_3DCA(param_00))
		{
			func_832E(param_00);
		}
	}
}

//Function Number: 53
func_93E4(param_00)
{
	if(!isdefined(param_00.var_C207))
	{
		param_00.var_C207 = 0;
	}

	param_00.var_C207++;
}

//Function Number: 54
func_7C74(param_00)
{
	if(scripts\cp\_utility::isplayingsolo() || scripts\common\utility::istrue(level.only_one_player))
	{
		return 0;
	}

	return 200;
}

//Function Number: 55
register_interactions()
{
	level.interaction_hintstrings["afterlife_spectate_door"] = &"CP_ZOMBIE_AFTERLIFE_ARCADE_SPECTATE_DOOR";
	scripts\cp\_interaction::func_DEBB("afterlife_spectate_door",undefined,undefined,undefined,::func_1301F,0,0,::func_975E);
	scripts\cp\_interaction::func_DEBB("afterlife_selfrevive_door",undefined,undefined,::func_7C53,::func_1300F,0,0,::func_972F,::func_386A);
}

//Function Number: 56
func_E226(param_00)
{
	param_00.var_10450 = 0;
	param_00.var_1044F = 0;
	param_00 setclientomnvar("zombie_afterlife_soul_power_earned",param_00.var_10450);
}