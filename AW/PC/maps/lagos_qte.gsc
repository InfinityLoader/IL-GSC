/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: lagos_qte.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 52
 * Decompile Time: 723 ms
 * Timestamp: 4/22/2024 2:33:57 AM
*******************************************************************/

//Function Number: 1
takedown_qte(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	level.player.no_breath_hud = 1;
	if(!common_scripts\utility::flag("takedown_underwater"))
	{
		maps\lagos_utility::start_end_takedown_highway_path_player_side();
		level.player allowads(1);
		param_08 hide();
		level.player maps\_shg_utility::setup_player_for_scene();
		level.player takeallweapons();
		var_0B = 1;
		level.player playerlinktoblend(param_08,"tag_player",var_0B);
		level.player common_scripts\utility::delaycall(var_0B,::playerlinktodelta,param_08,"tag_player",1,7,7,5,5,1);
		param_08 common_scripts\utility::delaycall(var_0B,::show);
		level.player enableinvulnerability();
		level.player notifyonplayercommand("gunFired","+attack");
		var_0C = [param_02,param_03,param_08];
		var_0D = [param_01,param_02,param_03,param_08];
		var_0E = [param_02,param_03,param_08];
		var_0F = [param_02,param_03];
		var_10 = [param_02,param_03,param_09];
		var_11 = [param_02,param_03];
		param_02 maps\_utility::deletable_magic_bullet_shield();
		param_03 maps\_utility::deletable_magic_bullet_shield();
		thread truck_takedown_player_hold_check("flag_player_hold_on",param_09);
		foreach(var_13 in var_0D)
		{
			var_13 linkto(param_09,"tag_body");
		}

		param_09 maps\_anim::anim_single(var_0C,"hostage_truck_takedown_pt1","tag_body");
		level thread maps\lagos_fx::fake_tread_fx_hostage_truck(param_09);
		if(!common_scripts\utility::flag("flag_player_hold_on"))
		{
			soundscripts\_snd::snd_printlnbold("Van Grab failure");
			hostage_truck_failure();
			param_00 maps\_anim::anim_first_frame_solo(param_09,"hostage_truck_takedown_pt2");
			param_09 maps\_anim::anim_first_frame(var_0C,"hostage_truck_takedown_pt2","tag_body");
			param_00 thread maps\_anim::anim_single_solo(param_09,"hostage_truck_takedown_pt2");
			param_09 thread maps\_anim::anim_single(var_0C,"hostage_truck_takedown_pt2","tag_body");
			wait(0.4);
			level.player unlink();
			level.player thread truck_takedown_player_hold_fail(param_08 gettagorigin("tag_player"),param_08 gettagangles("tag_player"),(-400,500,-200),(-320,128,0));
			param_08 stopanimscripted();
			param_08 delete();
			hostage_truck_gameover();
			return;
		}

		soundscripts\_snd::snd_message("final_takedown_xbutton_hit");
		param_00 notify("stop_loop");
		thread maps\lagos_vo::highway_traffic_final_takedown_hold_on();
		param_08 attach("npc_titan45_base_loot","TAG_WEAPON_RIGHT",0);
		soundscripts\_snd::snd_printlnbold("Van Grab Success");
		thread truck_takedown_player_shot_enemy_check("flag_player_shot_enemy",4.55,param_02,param_03,param_09);
		thread player_free_aim(param_08,param_09,param_00);
		hostage_truck_anim_single_break_when_timeout_or_fail(param_00,var_0D,param_09);
		level.player notify("part2_done");
		soundscripts\_snd::snd_message("hostage_truck_slomo_end_pt2");
		if(!common_scripts\utility::flag("flag_player_shot_enemy"))
		{
			soundscripts\_snd::snd_printlnbold("Shoot Driver Fail");
			hostage_truck_failure();
			if(isdefined(param_02) && isalive(param_02))
			{
				param_02 thread shootblankthread(1);
			}

			if(isdefined(param_03) && isalive(param_03))
			{
				param_03 thread shootblankthread(0);
			}

			param_00 thread maps\_anim::anim_single_solo(param_09,"hostage_truck_takedown_pt3");
			wait 0.05;
			wait 0.05;
			param_09 thread maps\_anim::anim_single_solo(param_08,"hostage_truck_takedown_fail_pt2","tag_body");
			wait(0.3);
			level.player forcemovingplatformentity(undefined);
			level.player unlink();
			level.burke hide();
			level.player thread truck_takedown_player_hold_fail(param_08 gettagorigin("tag_player"),param_08 gettagangles("tag_player"),(0,500,-200),(-96,360,0));
			param_08 stopanimscripted();
			param_08 delete();
			hostage_truck_gameover();
			return;
		}

		soundscripts\_snd::snd_printlnbold("Shoot Driver Success");
		level.player common_scripts\utility::delaycall(6,::lerpviewangleclamp,1,1,0,0,0,0,0);
		param_09 thread maps\_anim::anim_single_solo(level.burke,"hostage_truck_takedown_pt3","tag_body");
		param_00 thread maps\_anim::anim_single_solo(param_0A,"hostage_truck_takedown_pt3");
		param_00 thread maps\_anim::anim_single_solo(param_09,"hostage_truck_takedown_pt3");
		param_09 thread maps\_anim::anim_single_solo(param_08,"hostage_truck_takedown_pt3","tag_body");
		param_08 waittillmatch("kva_part3_start","single anim");
		param_09 thread maps\_anim::anim_single(var_0F,"hostage_truck_takedown_pt3","tag_body");
		param_08 waittillmatch("unlink_from_truck","single anim");
		thread maps\_utility::autosave_now_silent();
		param_09 delete();
		param_02 delete();
		param_03 delete();
	}

	thread takedown_underwater_portion(param_00,param_08,param_01,param_09,param_04,param_05,param_06);
}

//Function Number: 2
shootblankthread(param_00)
{
	if(param_00)
	{
		self shootblank();
		wait 0.05;
		self shootblank();
		wait 0.05;
		self shoot();
		wait 0.05;
		self shoot();
		wait 0.05;
		self shoot();
		wait 0.05;
		wait 0.05;
		wait 0.05;
		self shoot();
		wait 0.05;
		wait 0.05;
		self shoot();
		wait 0.05;
		wait 0.05;
		self shoot();
		wait 0.05;
		wait 0.05;
		self shoot();
		wait 0.05;
		wait 0.05;
		self shoot();
		return;
	}

	self shootblank();
	wait 0.05;
	self shoot();
	wait 0.05;
	self shoot();
	wait 0.05;
	wait 0.05;
	wait 0.05;
	self shoot();
	wait 0.05;
	wait 0.05;
	wait 0.05;
	self shoot();
	wait 0.05;
	wait 0.05;
	self shoot();
	wait 0.05;
	wait 0.05;
	self shoot();
	wait 0.05;
	wait 0.05;
	self shoot();
}

//Function Number: 3
viewmodel_swim_handle_notetracks()
{
	for(;;)
	{
		self waittill("swim_notes",var_00);
		switch(var_00)
		{
			case "lagos_swimming_into_stroke":
			case "lagos_swimming_drowning_start":
			case "lagos_swimming_stroke":
				soundscripts\_snd::snd_message(var_00);
				break;
		}
	}
}

//Function Number: 4
viewmodel_swim_animations_loop(param_00,param_01,param_02,param_03)
{
	level endon("missionfailed");
	level endon(param_02);
	level.player enablemousesteer(1);
	param_00 childthread viewmodel_swim_handle_notetracks();
	var_04 = %wm_unarmed_underwater_swim_idle_loop;
	var_05 = %wm_unarmed_underwater_swim_loop_into;
	var_06 = %wm_unarmed_underwater_swim_loop;
	var_07 = %wm_unarmed_underwater_swim_drown;
	var_08 = %wm_unarmed_underwater_swim_arms_off_screen;
	var_09 = getnotetracktimes(var_06,"anim_interupt");
	var_0A = getanimlength(var_04);
	var_0B = getanimlength(var_05);
	var_0C = getanimlength(var_06);
	var_0D = 1;
	var_0E = 2;
	var_0F = 3;
	var_10 = 4;
	var_11 = var_0D;
	param_00 setflaggedanimknob("swim_notes",var_08,1,0);
	param_00 setflaggedanimknob("swim_notes",var_04,1,0.5);
	var_12 = 0;
	for(;;)
	{
		level.player hideviewmodel();
		var_13 = level.player getnormalizedmovement();
		var_14 = level.player getnormalizedcameramovements();
		var_15 = 0;
		if(var_13[0] > 0.2)
		{
			var_15 = 1;
		}

		var_16 = var_11;
		var_17 = param_01.origin - level.player.origin;
		if(!common_scripts\utility::flag("van_door_open_lighting") && length(var_17) < 150)
		{
			var_15 = 0;
		}
		else if(common_scripts\utility::flag("van_door_open_lighting") && length(var_17) < 110)
		{
			var_15 = 0;
		}

		if(param_01.origin[2] > level.player.origin[2] && !common_scripts\utility::flag("flag_van_door_open"))
		{
			setdvar("ui_deadquote",&"LAGOS_SWIM_FAIL");
			maps\_utility::missionfailedwrapper();
			level.player enablemousesteer(0);
			return;
		}

		var_18 = 12;
		var_19 = (0,0,0);
		if(!var_15 && param_03)
		{
			var_19 = (0,0,-10);
		}

		param_00 moveto(param_00.origin + anglestoforward(param_00.angles) * var_13[0] * var_18 * var_15 + var_19,0.1,0.05,0.05);
		var_1A = 5;
		param_00 rotateto(param_00.angles - (0,1,0) * var_14[1] * var_1A - (1,0,0) * var_14[0] * var_1A,0.1,0.05,0.05);
		if(common_scripts\utility::flag("player_swimming_drown"))
		{
			if(var_11 == var_0F)
			{
				var_1B = param_00 getanimtime(var_06);
				foreach(var_1D in var_09)
				{
					if(var_1B > var_1D - 0.1 && var_1B < var_1D + 0.1)
					{
						var_11 = var_10;
					}
				}
			}
			else
			{
				var_11 = var_10;
			}
		}

		if(var_11 == var_0D)
		{
			if(var_15)
			{
				var_11 = var_0E;
			}
			else if(var_12 >= var_0A)
			{
				var_16 = 0;
			}
		}
		else if(var_11 == var_0E)
		{
			if(var_12 >= var_0B)
			{
				if(var_15)
				{
					var_11 = var_0F;
				}
				else
				{
					var_11 = var_0D;
				}
			}
		}
		else if(var_11 == var_0F)
		{
			if(var_15)
			{
				if(var_12 >= var_0C)
				{
					var_16 = 0;
				}
			}
			else
			{
				var_1B = param_00 getanimtime(var_06);
				foreach(var_1D in var_09)
				{
					if(var_1B > var_1D - 0.1 && var_1B < var_1D + 0.1)
					{
						var_11 = var_0D;
					}
				}
			}
		}

		if(var_16 != var_11)
		{
			if(var_11 == var_0D)
			{
				if(var_16 == var_0F || var_16 == var_0E)
				{
					param_00 setflaggedanimknobrestart("swim_notes",var_04,1,1);
				}
				else
				{
					param_00 setflaggedanimknobrestart("swim_notes",var_04);
				}
			}
			else if(var_11 == var_0E)
			{
				soundscripts\_snd::snd_message("lagos_swimming_into_stroke");
				param_00 setflaggedanimknobrestart("swim_notes",var_05);
			}
			else if(var_11 == var_0F)
			{
				param_00 setflaggedanimknobrestart("swim_notes",var_06);
			}
			else if(var_11 == var_10)
			{
				param_00 setflaggedanimknobrestart("swim_notes",var_07,1,0.75);
			}

			var_12 = 0.05;
		}

		wait(0.05);
		var_12 = var_12 + 0.05;
	}

	level.player enablemousesteer(0);
}

//Function Number: 5
viewmodel_swim_animations(param_00,param_01,param_02,param_03)
{
	var_04 = spawn("script_model",level.player.origin);
	var_04 setmodel("worldhands_atlas_pmc_smp");
	var_04 dontcastshadows();
	if(isdefined(param_03))
	{
		var_04.angles = param_03.angles;
	}
	else
	{
		var_04.angles = level.player.angles;
	}

	var_04 useanimtree(#animtree);
	level.player playerlinktodelta(var_04,"tag_player",1,0,0,0,0);
	viewmodel_swim_animations_loop(var_04,param_00,param_01,param_02);
	if(!common_scripts\utility::flag("missionfailed"))
	{
		var_04 setflaggedanimknobrestart("swim_notes",%wm_unarmed_underwater_swim_arms_off_screen);
		var_05 = getanimlength(%wm_unarmed_underwater_swim_arms_off_screen);
		wait(var_05);
	}

	var_04 unlink();
	var_04 delete();
}

//Function Number: 6
swim_bounds_fail()
{
	level endon("swimming_fade");
	common_scripts\utility::flag_clear("flag_swim_bounds");
	for(;;)
	{
		if(common_scripts\utility::flag("flag_swim_bounds"))
		{
			setdvar("ui_deadquote",&"LAGOS_SWIM_FAIL");
			maps\_utility::missionfailedwrapper();
			return;
		}

		wait 0.05;
	}
}

//Function Number: 7
swim_time_fail()
{
	wait(10);
	if(!common_scripts\utility::flag("flag_van_door_open"))
	{
		setdvar("ui_deadquote",&"LAGOS_SWIM_FAIL");
		maps\_utility::missionfailedwrapper();
	}
}

//Function Number: 8
takedown_underwater_portion(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = 30;
	var_08 = [param_02,param_01,param_04,param_05,param_06];
	var_09 = maps\_utility::spawn_anim_model("hostage_truck",param_03.origin,param_03.angles);
	var_09 thread hostage_truck_scripted_descent(var_07);
	var_0A = common_scripts\utility::getstruct("van_takedown_underwater_player","targetname");
	param_02 hide();
	param_01 hide();
	level.player forcemovingplatformentity(undefined);
	level.player unlink();
	level.player maps\_utility::teleport_player(var_0A);
	var_0B = (13,0,0);
	level.player.origin = (-34194,76524,130);
	level.player.angles = var_0B;
	wait 0.05;
	level notify("swimming_start");
	var_09 thread maps\lagos_fx::water_bubbles_truck_door();
	soundscripts\_snd::snd_message("underwater_sequence",var_09);
	thread swim_bounds_fail();
	thread swim_time_fail();
	thread viewmodel_swim_animations(var_09,"latch_opened",1,undefined);
	level.player waittill_player_uses_truck_latch(var_09,var_07);
	level notify("swimming_end");
	level.player disableweapons();
	param_04 hide();
	param_05 hide();
	param_06 hide();
	param_04 linkto(var_09,"tag_body");
	param_05 linkto(var_09,"tag_body");
	param_06 linkto(var_09,"tag_body");
	var_0C = 0.75;
	level.player playerlinktoblend(param_01,"tag_player",var_0C,0.5);
	level.player common_scripts\utility::delaycall(var_0C,::playerlinktodelta,param_01,"tag_player",1,7,7,5,5,1);
	param_01 common_scripts\utility::delaycall(var_0C,::show);
	param_02 common_scripts\utility::delaycall(var_0C,::show);
	param_04 common_scripts\utility::delaycall(var_0C,::show);
	param_05 common_scripts\utility::delaycall(var_0C,::show);
	param_06 common_scripts\utility::delaycall(var_0C,::show);
	var_09 thread maps\_anim::anim_single_solo(var_09,"hostage_truck_takedown_pt4_into","tag_origin");
	var_09 thread maps\_anim::anim_single(var_08,"hostage_truck_takedown_pt4_into","tag_body");
	soundscripts\_snd::snd_message("underwater_rescue");
	foreach(var_0E in var_08)
	{
		var_0E linkto(var_09,"tag_body");
	}

	var_07 = getanimlength(param_01 maps\_utility::getanim("hostage_truck_takedown_pt4_into"));
	wait(var_07);
	level thread maps\lagos_fx::ambient_underwater_effects_rescue(var_09);
	param_00 thread maps\_anim::anim_single_solo(var_09,"hostage_truck_takedown_pt4");
	var_09 thread maps\_anim::anim_single(var_08,"hostage_truck_takedown_pt4","tag_body");
	maps\_vehicle_traffic::delete_traffic_path("highway_path_player_side");
	maps\_vehicle_traffic::delete_traffic_path("highway_path_other_side");
	param_01 waittillmatch("unlink_from_truck","single anim");
	level thread maps\lagos_fx::player_gasping_breath();
	common_scripts\utility::flag_set("obj_progress_pursue_hostage_truck_highway_rescue");
	level.player unlink();
	param_01 hide();
	thread viewmodel_swim_animations(var_09,"swimming_end",0,param_01);
	level thread maps\lagos_fx::player_drown_end_vm_transition();
	maps\_utility::delaythread(7,::common_scripts\utility::flag_set,"player_swimming_drown");
	maps\_utility::delaythread(11,::common_scripts\utility::flag_set,"player_swimming_end");
	common_scripts\utility::flag_wait("player_swimming_end");
	level notify("swimming_fade");
	wait(4);
	foreach(var_0E in var_08)
	{
		if(isdefined(var_0E))
		{
			var_0E stopanimscripted();
		}
	}

	level.player allowads(1);
}

//Function Number: 9
hostage_truck_anim_single_break_when_timeout_or_fail(param_00,param_01,param_02)
{
	level.player endon("part2_done");
	level endon("flag_player_shot_enemy");
	param_00 maps\_anim::anim_first_frame_solo(param_02,"hostage_truck_takedown_pt2");
	param_02 maps\_anim::anim_first_frame(param_01,"hostage_truck_takedown_pt2","tag_body");
	param_00 thread maps\_anim::anim_single_solo(param_02,"hostage_truck_takedown_pt2");
	param_02 maps\_anim::anim_single(param_01,"hostage_truck_takedown_pt2","tag_body");
}

//Function Number: 10
hostage_truck_scripted_descent(param_00)
{
	var_01 = common_scripts\utility::getstruct("hostage_truck_sinking_control","targetname");
	var_02 = common_scripts\utility::getstruct(var_01.target,"targetname");
	self.origin = var_01.origin;
	self.angles = var_01.angles;
	self moveto(var_02.origin,param_00,0,param_00);
	self rotateto(var_02.angles,param_00);
}

//Function Number: 11
printorigin3duntilnotify(param_00,param_01,param_02,param_03,param_04)
{
	self endon(param_04);
	wait(0.05);
}

//Function Number: 12
truck_takedown_player_hold_check(param_00,param_01)
{
	level.player waittill("slowmo_start");
	soundscripts\_snd::snd_printlnbold("Slowmo Start");
	var_02 = param_01 maps\_shg_utility::hint_button_tag("x","tag_mirror_right",900,900);
	common_scripts\utility::flag_set("van_takedown_hold_lighting");
	if(level.player common_scripts\utility::is_player_gamepad_enabled())
	{
		wait_for_flag_or_player_command("flag_hostage_truck_is_failure","+usereload");
	}
	else
	{
		wait_for_flag_or_player_command("flag_hostage_truck_is_failure","+activate");
	}

	if(common_scripts\utility::flag("flag_hostage_truck_is_failure"))
	{
		maps\lagos_utility::clear_hint_button(var_02);
		return;
	}

	soundscripts\_snd::snd_message("van_takedown_1stjump_button_press");
	hostage_truck_slomo_end(1);
	var_02 maps\_shg_utility::hint_button_clear();
	common_scripts\utility::flag_set(param_00);
}

//Function Number: 13
truck_takedown_player_hold_fail(param_00,param_01,param_02,param_03)
{
	level.player disableinvulnerability();
	var_04 = common_scripts\utility::spawn_tag_origin();
	var_04.origin = param_00;
	var_04.angles = param_01;
	self playerlinktoabsolute(var_04,"tag_origin");
	var_05 = bullettrace(level.player geteye(),level.player geteye() + param_02,0);
	var_06 = 0.25;
	var_07 = 25;
	var_08 = 360;
	var_09 = 45;
	var_0A = var_05["position"] + (0,0,64);
	var_04 truck_takedown_player_fall(var_06,var_07,var_08,var_09,var_0A,"heavy");
	var_06 = 0.4;
	var_07 = 105;
	var_08 = 360;
	var_09 = 255;
	var_0A = var_0A + param_03;
	var_04 truck_takedown_player_fall(var_06,var_07,var_08,var_09,var_0A,"light");
	level.player kill();
	var_06 = 0.6;
	var_07 = 95;
	var_08 = 200;
	var_09 = 155;
	var_0A = var_0A + param_03;
	var_04 truck_takedown_player_fall(var_06,var_07,var_08,var_09,var_0A,"heavy");
}

//Function Number: 14
truck_takedown_player_fall(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self moveto(param_04,param_00,0,0);
	self rotateby((param_01,param_02,param_03),param_00,0,0);
	earthquake(1,param_00 * 2,self.origin,500);
	level.player dodamage(34,self.origin + (0,0,-32));
	if(isdefined(param_05))
	{
		if(param_05 == "heavy")
		{
			level.player playrumbleonentity("damage_heavy");
		}
		else if(param_05 == "light")
		{
			level.player playrumbleonentity("damage_light");
		}
	}

	wait(param_00);
}

//Function Number: 15
truck_takedown_player_shot_enemy_check(param_00,param_01,param_02,param_03,param_04)
{
	param_02 thread kva_fake_death_checker(param_04,"hostage_truck_takedown_death");
	param_03 thread kva_fake_death_checker(param_04,"hostage_truck_takedown_death");
	for(;;)
	{
		level.kva_dead_count = 0;
		if(!isalive(param_02) || param_02.fake_death)
		{
			level.kva_dead_count++;
		}

		if(!isalive(param_03) || param_03.fake_death)
		{
			level.kva_dead_count++;
		}

		level.kva_1_dead = !isalive(param_02) || param_02.fake_death;
		level.kva_2_dead = !isalive(param_03) || param_03.fake_death;
		if(level.kva_dead_count >= 2)
		{
			hostage_truck_slomo_end(1);
			common_scripts\utility::flag_set(param_00);
			break;
		}

		wait 0.05;
	}

	level.player.weapon_out = undefined;
	level.player notify("set_normal_time_if_gun_fired_kill");
}

//Function Number: 16
set_normal_time_if_gun_fired()
{
	level.player endon("part2_done");
	for(;;)
	{
		level.player waittill("gunFired");
		hostage_truck_slomo_end(1);
		wait 0.05;
	}
}

//Function Number: 17
kva_fake_death_checker(param_00,param_01)
{
	level.player endon("part1_done");
	level.player endon("part2_done");
	self.fake_death = 0;
	thread kva_fake_death_checker_bloodfx();
	self waittill("damage",var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B);
	self.fake_death = 1;
	if(!isdefined(self getlinkedparent()))
	{
		self linkto(param_00.tag_driver);
	}

	if(isdefined(param_00) && isdefined(param_01))
	{
		self stopanimscripted();
		param_00 thread maps\_anim::anim_single_solo(self,param_01,"tag_body");
	}
}

//Function Number: 18
kva_fake_death_checker_bloodfx()
{
	self endon("death");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		var_0A = common_scripts\utility::spawn_tag_origin();
		var_0A linkto(self,var_07,(0,0,0),(0,0,0));
		playfxontag(common_scripts\utility::getfx("lag_tkdown_truck_blood_impact"),var_0A,"TAG_ORIGIN");
	}
}

//Function Number: 19
doclamping()
{
	wait(3);
	level.player lerpviewangleclamp(1,0.25,0.25,0,0,0,0);
}

//Function Number: 20
doclampingrelease()
{
	wait(0.6);
	level.player lerpviewangleclamp(0.05,0.25,0.25,35,35,22.5,22.5);
}

//Function Number: 21
player_free_aim(param_00,param_01,param_02)
{
	thread doclamping();
	level.player waittill("do_viewmodel_swap");
	thread doclampingrelease();
	var_03 = "iw5_titan45lagostrucktakedown_sp";
	level.player enableweapons();
	level.player hideviewmodel();
	level.player giveweapon(var_03);
	level.player switchtoweapon(var_03);
	wait(0.3);
	level.player showviewmodel();
	soundscripts\_snd::snd_message("final_takedown_gun_up");
	common_scripts\utility::flag_set("van_takedown_shoot_lighting");
	level.player forcemovingplatformentity(param_00);
	level.player forcemovingplatformentity(param_01);
	level.player playerrecoilscaleon(0);
	level.player waittill("part2_done");
	level.player disableweapons();
	wait(1);
	level.player playerrecoilscaleon(1);
	common_scripts\utility::flag_set("van_takedown_impact_lighting");
	level.player takeweapon(var_03);
	if(isdefined(param_00))
	{
		param_00 showallparts();
	}
}

//Function Number: 22
waittill_player_uses_truck_latch(param_00,param_01)
{
	var_02 = param_00 maps\_shg_utility::hint_button_tag("x","latch_jnt",150,900);
	var_03 = common_scripts\utility::spawn_tag_origin();
	var_03.origin = param_00 gettagorigin("latch_jnt") - 32 * anglestoforward(param_00.angles);
	var_03 linkto(param_00,"latch_jnt");
	var_03 makeusable();
	level.obj_tag = common_scripts\utility::spawn_tag_origin();
	level.obj_tag.origin = param_00 gettagorigin("latch_jnt");
	level.obj_tag linkto(param_00,"latch_jnt");
	var_04 = getent("trigger_player_ready_for_van_open","targetname");
	var_05 = getent("swim_latch_open_trigger","targetname");
	var_04 maps\lagos_utility::fake_linkto(param_00);
	var_05 maps\lagos_utility::fake_linkto(param_00);
	common_scripts\utility::run_thread_on_targetname("trigger_player_ready_for_van_open",::truck_swim_latch_open_player_validation);
	var_06 = var_04 common_scripts\utility::waittill_notify_or_timeout_return("latch_opening",param_01 - 5);
	var_02 maps\_shg_utility::hint_button_clear();
	if(isdefined(var_06))
	{
		setdvar("ui_deadquote",&"LAGOS_SWIM_FAIL");
		maps\_utility::missionfailedwrapper();
		hostage_truck_gameover();
	}

	level notify("latch_opened");
	common_scripts\utility::flag_set("van_door_open_lighting");
	common_scripts\utility::flag_set("flag_van_door_open");
	var_03 delete();
	thread truck_latch_rumble();
}

//Function Number: 23
truck_latch_rumble()
{
	wait(5);
	level.player playrumbleonentity("damage_heavy");
}

//Function Number: 24
truck_swim_latch_open_player_validation()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		if(isplayer(var_00))
		{
			while(common_scripts\utility::flag("flag_swim_latch_open_trigger"))
			{
				if(level.player usebuttonpressed())
				{
					self notify("latch_opening");
					return;
				}

				wait 0.05;
			}
		}
	}
}

//Function Number: 25
truck_takedown_player_pry_open(param_00,param_01)
{
	level.player waittill("slowmo_start");
	display_hint_timeout_override_old("qte_pry_open",20);
	wait_for_flag_or_player_command("flag_hostage_truck_is_failure","+usereload");
	if(common_scripts\utility::flag("flag_hostage_truck_is_failure"))
	{
		return;
	}

	hostage_truck_slomo_end(1);
	if(param_00 == "flag_player_pry_open")
	{
		level notify("pry_chk_complete");
	}

	common_scripts\utility::flag_set(param_00);
}

//Function Number: 26
hostage_truck_failure()
{
	common_scripts\utility::flag_set("flag_hostage_truck_is_failure");
	hostage_truck_slomo_end(1);
}

//Function Number: 27
hostage_truck_gameover()
{
	level waittill("forever");
}

//Function Number: 28
setup_vehicles_for_takedown()
{
	level.hostage_truck = maps\_vehicle::spawn_vehicle_from_targetname("KVA_hostage_truck_takedown");
	level.hostage_truck.vehicle_stays_alive = 1;
	level.hostage_truck setmodel("vehicle_civ_boxtruck_highres_ai");
	level.hostage_truck.animname = "hostage_truck";
	level.hostage_truck useanimtree(#animtree);
	thread maps\_vehicle_traffic::add_script_car(level.hostage_truck);
	level.hostage_truck.tag_driver = spawn("script_origin",(0,0,0));
	level.hostage_truck.tag_driver.origin = level.hostage_truck gettagorigin("tag_driver");
	level.hostage_truck.tag_driver.angles = level.hostage_truck gettagangles("tag_driver");
	level.hostage_truck.tag_driver linkto(level.hostage_truck);
	level.hostage_truck_oncoming = maps\_vehicle::spawn_vehicle_from_targetname("oncoming_hostage_truck_takedown");
	level.hostage_truck_oncoming.animname = "oncoming_truck";
	level.hostage_truck_oncoming useanimtree(#animtree);
}

//Function Number: 29
hostage_truck_slomo_start(param_00,param_01,param_02)
{
	if(common_scripts\utility::flag("flag_truck_middle_takedown_is_failure"))
	{
		return;
	}

	level.player notify("slowmo_start");
	var_03 = level.player;
	var_03 thread maps\_utility::play_sound_on_entity("slomo_whoosh");
	var_03 thread player_heartbeat();
	maps\_utility::slowmo_start();
	var_03 allowmelee(0);
	maps\_utility::slowmo_setspeed_norm(param_00);
	maps\_utility::slowmo_setspeed_slow(param_01);
	maps\_utility::slowmo_setlerptime_in(param_02);
	maps\_utility::slowmo_lerp_in();
}

//Function Number: 30
hostage_truck_slomo_end(param_00)
{
	var_01 = 0.75;
	if(isdefined(param_00) && param_00)
	{
		var_01 = 0.05;
	}

	level notify("stop_player_heartbeat");
	level.player thread maps\_utility::play_sound_on_entity("slomo_whoosh");
	maps\_utility::slowmo_setspeed_norm(1);
	maps\_utility::slowmo_setlerptime_out(var_01);
	maps\_utility::slowmo_lerp_out();
	maps\_utility::slowmo_end();
}

//Function Number: 31
player_heartbeat()
{
	level endon("stop_player_heartbeat");
	for(;;)
	{
		self playlocalsound("breathing_heartbeat");
		wait(0.5);
	}
}

//Function Number: 32
hostage_truck_slomo_end_notetrack(param_00)
{
	level.player notify("slowmo_end");
	hostage_truck_slomo_end(0);
}

//Function Number: 33
hostage_truck_slomo_start_pt1(param_00)
{
	soundscripts\_snd::snd_message("hostage_truck_slomo_start_pt1");
	var_01 = 0.095;
	var_02 = 0.095;
	var_03 = 0.2;
	hostage_truck_slomo_start(var_01,var_02,var_03);
}

//Function Number: 34
hostage_truck_slomo_start_pt2(param_00)
{
	var_01 = 0.1;
	var_02 = 0.1;
	var_03 = 0.2;
	common_scripts\utility::flag_set("flag_hostage_truck_fire_input_window_started");
	if(!isdefined(level.kva_1_dead) || !isdefined(level.kva_1_dead) || !level.kva_1_dead || !level.kva_1_dead)
	{
		soundscripts\_snd::snd_message("hostage_truck_slomo_start_pt2");
		hostage_truck_slomo_start(var_01,var_02,var_03);
	}
}

//Function Number: 35
hostage_truck_slomo_end_pt2(param_00)
{
	if(common_scripts\utility::flag("flag_hostage_truck_fire_input_window_started"))
	{
		level.player notify("check_and_wait_for_shooting_result");
	}

	hostage_truck_slomo_end_notetrack(param_00);
}

//Function Number: 36
hostage_truck_slomo_start_pt3(param_00)
{
	soundscripts\_snd::snd_message("hostage_truck_slomo_start_pt3");
	var_01 = 0.095;
	var_02 = 0.095;
	var_03 = 0.2;
	hostage_truck_slomo_start(var_01,var_02,var_03);
}

//Function Number: 37
hostage_truck_slomo_start_pt4(param_00)
{
	soundscripts\_snd::snd_message("hostage_truck_slomo_start_pt4");
	var_01 = 0.095;
	var_02 = 0.095;
	var_03 = 0.2;
	hostage_truck_slomo_start(var_01,var_02,var_03);
}

//Function Number: 38
hostage_truck_viewmodel_swap(param_00)
{
	level.player allowmelee(0);
	level.player notify("do_viewmodel_swap");
}

//Function Number: 39
traverse_start_jump_start_slowmo(param_00)
{
	soundscripts\_snd::snd_message("traverse_start_jump_start_slowmo");
	var_01 = 0.095;
	var_02 = 0.095;
	var_03 = 0.2;
	if(level.currentgen)
	{
		var_01 = 0.2;
		var_02 = 0.2;
		var_03 = 0.1;
	}

	hostage_truck_slomo_start(var_01,var_02,var_03);
}

//Function Number: 40
traverse_start_jump_start_prompt(param_00)
{
	thread maps\lagos_code::traffic_traverse_start_player_input();
	common_scripts\utility::flag_wait("flag_highway_ledge_jump_started");
	maps\lagos_utility::disable_exo_for_highway();
	traverse_start_jump_end_slowmo();
	if(isdefined(level.traffic_ledge_jump_trigger_use))
	{
		level.traffic_ledge_jump_trigger_use delete();
	}
}

//Function Number: 41
traverse_start_jump_end_prompt(param_00)
{
	if(isdefined(level.traffic_ledge_jump_trigger_use))
	{
		level.traffic_ledge_jump_trigger_use delete();
	}
}

//Function Number: 42
traverse_start_jump_end_slowmo(param_00)
{
	soundscripts\_snd::snd_message("traverse_start_jump_end_slowmo");
	hostage_truck_slomo_end_notetrack();
	if(common_scripts\utility::flag("flag_highway_ledge_jump_started"))
	{
		return;
	}

	common_scripts\utility::flag_set("flag_highway_ledge_jump_fail");
	level.org_player_highway_ledge maps\_utility::anim_stopanimscripted();
	level.org_player_highway_ledge maps\_anim::anim_single_solo(level.player_rig_highway_ledge,"traffic_start_VM_fail");
	setdvar("ui_deadquote",&"LAGOS_BUS_JUMP_FAILED");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 43
traverse_start_jump_player_looking(param_00)
{
	common_scripts\utility::flag_set("flag_highway_VM_looking_forward");
}

//Function Number: 44
wait_for_flag_or_player_command_aux(param_00,param_01)
{
	level.player endon("qte_success_message");
	common_scripts\utility::flag_wait(param_00);
	return 1;
}

//Function Number: 45
wait_for_flag_or_player_command(param_00,param_01)
{
	level.player notifyonplayercommand("qte_success_message",param_01);
	var_02 = wait_for_flag_or_player_command_aux(param_00,param_01);
	level.player notifyonplayercommandremove("qte_success_message",param_01);
}

//Function Number: 46
display_hint_timeout_override_old(param_00,param_01)
{
	level.player.remove_hint = level.player.current_global_hint;
	level.player maps\_utility::display_hint_timeout(param_00,param_01);
}

//Function Number: 47
qte_grab_hold_off()
{
	if(level.player usebuttonpressed() || isdefined(level.player.remove_hint) && level.player.remove_hint == &"LAGOS_QTE_GRAB_HOLD")
	{
		return 1;
	}

	return 0;
}

//Function Number: 48
qte_shoot_kva_off()
{
	var_00 = "BUTTON_RTRIG";
	if(!level.console && !level.player common_scripts\utility::is_player_gamepad_enabled())
	{
		var_00 = "mouse2";
	}

	if(level.player buttonpressed(var_00) || isdefined(level.player.remove_hint) && level.player.remove_hint == &"LAGOS_QTE_SHOOT_KVA")
	{
		return 1;
	}

	return 0;
}

//Function Number: 49
qte_pry_open_off()
{
	if(level.player usebuttonpressed() || isdefined(level.player.remove_hint) && level.player.remove_hint == &"LAGOS_QTE_PRY_OPEN")
	{
		return 1;
	}

	return 0;
}

//Function Number: 50
qte_swim_off()
{
	if(level.player getnormalizedmovement() > 0.01 || isdefined(level.player.remove_hint) && level.player.remove_hint == &"LAGOS_QTE_SWIM")
	{
		return 1;
	}

	return 0;
}

//Function Number: 51
qte_success_off()
{
	if(isdefined(level.player.remove_hint) && level.player.remove_hint == &"LAGOS_QTE_SUCCESS")
	{
		return 1;
	}

	return 0;
}

//Function Number: 52
qte_fail_off()
{
	if(isdefined(level.player.remove_hint) && level.player.remove_hint == &"LAGOS_QTE_FAIL")
	{
		return 1;
	}

	return 0;
}