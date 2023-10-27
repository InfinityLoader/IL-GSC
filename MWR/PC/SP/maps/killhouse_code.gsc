/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\killhouse_code.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 152
 * Decompile Time: 2550 ms
 * Timestamp: 10/27/2023 2:46:11 AM
*******************************************************************/

//Function Number: 1
precachelevelstuff()
{
	precachemodel("h1_mwr_com_office_chair_black");
	precachemodel("com_clipboard_mocap");
	precachemodel("characters_accessories_pencil");
}

//Function Number: 2
new_look_training_setup()
{
	var_00 = getent("aim_down_target","targetname");
	var_01 = getent("aim_up_target","targetname");
	var_00 rotateto(var_00.angles + (0,0,-90),0.25,0,0);
	var_01 rotateto(var_01.angles + (0,0,-90),0.25,0,0);
}

//Function Number: 3
new_look_wait_for_target(param_00,param_01)
{
	self setcandamage(1);
	self rotateto(self.angles + (0,0,param_00),0.25,0,0);
	self playsound("killhouse_target_up");
	for(;;)
	{
		self waittill("damage",var_02,var_03,var_04,var_05,var_06);
		if(level.player maps\_utility::isads())
		{
			break;
		}
		else
		{
			if(level.xenon)
			{
				thread keyhint("ads_360");
				continue;
			}

			thread keyhint("ads");
		}
	}

	self playsound("killhouse_buzzer");
	self playsound("killhouse_target_up");
	self rotateto(self.angles + (0,0,param_01),0.25,0,0);
}

//Function Number: 4
rope_obj(param_00)
{
	level endon("starting_cargoship_obj");
	if(param_00)
	{
		setobjectivestring("obj_price",&"KILLHOUSE_SLIDE_DOWN_THE_ROPE");
		setobjectivestate("obj_price","current");
		var_01 = getent("top_of_rope","targetname");
		setobjectivelocation("obj_price",var_01);
	}
}

//Function Number: 5
level_scripted_unloadnode()
{
	for(;;)
	{
		self waittill("trigger",var_00);
		var_00 maps\_utility::vehicle_detachfrompath();
		var_00 vehicle_setspeed(20,20);
		var_00 maps\_utility::vehicle_land();
		wait(10);
		var_00 maps\_utility::vehicle_resumepath();
	}
}

//Function Number: 6
ambient_trucks()
{
	var_00 = getent("se_truck_trigger","targetname");
	for(;;)
	{
		var_01 = randomint(8);
		var_02 = maps\_vehicle::create_vehicle_from_spawngroup_and_gopath(var_01);
		foreach(var_04 in var_02)
		{
			var_04.veh_pathtype = "constrained";
		}

		for(var_06 = 0;var_06 < var_02.size;var_06++)
		{
			var_07 = randomintrange(30,50);
			var_02[var_06] vehicle_setspeed(var_07,30,30);
		}

		wait(randomintrange(3,6));
	}
}

//Function Number: 7
delay_objective_after_intro()
{
	registerobjective("obj_rifle",&"KILLHOUSE_PICK_UP_A_RIFLE_FROM",getent("obj_rifle_ammo","targetname"));
	wait(3);
	setobjectivestate("obj_rifle","current");
}

//Function Number: 8
waters_think()
{
	level.waters = getent("waters","script_noteworthy");
	level.waters.animname = "gaz";
	level.waters.disablearrivals = 1;
	level.waters.disableexits = 1;
	level.waters.lastspeaktime = 0;
	level.waters.lastnagtime = 0;
	level.waters.speaking = 0;
	thread maps\killhouse_anim::gaz_face_think(level.waters);
}

//Function Number: 9
newcastle_think()
{
	common_scripts\utility::flag_wait("spawn_frags");
	var_00 = getent("nwc","script_noteworthy");
	level.newcastle = var_00 maps\_utility::spawn_ai();
	level.newcastle.animname = "nwc";
	level.newcastle.disablearrivals = 1;
	level.newcastle.disableexits = 1;
	level.newcastle.lastspeaktime = 0;
	level.newcastle.lastnagtime = 0;
	level.newcastle.speaking = 0;
	level.newcastle pushplayer(1);
	level.newcastle maps\_utility::disable_cqbwalk();
	level.newcastle maps\_utility::gun_remove();
	level.newcastle maps\_utility::set_generic_run_anim("patrol_unarmed_walk");
	level.newcastle maps\_utility::set_generic_idle_anim("patrol_unarmed_idle");
	level.newcastle.grenadeawareness = 0;
	level.newcastle setlookatentity(level.player,1);
	level.newcastle specify_head_model("head_sp_sas_woodland_golden");
	thread maps\killhouse_anim::newcastle_face_think(level.newcastle);
}

//Function Number: 10
mac_think()
{
	level.mac = getent("mac","script_noteworthy");
	level.mac.animname = "mac";
	level.mac.disablearrivals = 1;
	level.mac.disableexits = 1;
	level.mac.lastspeaktime = 0;
	level.mac.lastnagtime = 0;
	level.mac.speaking = 0;
	level.mac pushplayer(1);
}

//Function Number: 11
price_think()
{
	level.price = getent("price","script_noteworthy");
	level.price.animname = "price";
	level.price.disablearrivals = 1;
	level.price.disableexits = 1;
	level.price.lastspeaktime = 0;
	level.price.lastnagtime = 0;
	level.price.speaking = 0;
	level.price pushplayer(1);
}

//Function Number: 12
clear_hints_on_flag(param_00)
{
	common_scripts\utility::flag_wait(param_00);
	clear_hints();
}

//Function Number: 13
generic_compass_hint_reminder(param_00,param_01)
{
	thread clear_hints_on_flag(param_00);
	level endon(param_00);
	wait(param_01);
	compass_hint();
	wait(2);
	var_02 = 6;
	for(;;)
	{
		if(var_02 > 20)
		{
			thread compass_reminder();
			refreshhudcompass();
			var_02 = 0;
		}

		var_02 = var_02 + 0.05;
		wait(0.05);
	}
}

//Function Number: 14
objective_hints(param_00)
{
	level endon("mission failed");
	level endon("navigationTraining_end");
	level endon("reveal_dialog_starting");
	compass_hint();
	wait(2);
	if(level.console || level.player usinggamepad())
	{
		keyhint("objectives",6);
	}
	else
	{
		keyhint("objectives_pc",6);
	}

	var_01 = 16;
	var_02 = 20;
	var_03 = 0.2;
	for(;;)
	{
		if(!common_scripts\utility::flag(param_00) && var_01 > var_02)
		{
			thread compass_reminder();
			refreshhudcompass();
			var_01 = 0;
			var_02 = var_02 + 5;
		}

		if(common_scripts\utility::flag("in_explosives_area") || common_scripts\utility::flag("in_obstacle_area") || common_scripts\utility::flag("in_NoReminder_Compass"))
		{
			var_01 = 0;
		}
		else
		{
			var_01 = var_01 + var_03;
		}

		wait(var_03);
	}
}

//Function Number: 15
compass_hint(param_00,param_01)
{
	clear_hints();
	level endon("clearing_hints");
	maps\_utility::hint(&"KILLHOUSE_HINT_OBJECTIVE_MARKER",undefined,undefined,1);
	level.iconelem = maps\_hud_util::createicon("objective",32,32);
	level.iconelem.hidewheninmenu = 1;
	level.iconelem maps\_hud_util::setpoint("TOP",undefined,0,155);
	wait(5);
	level.iconelem maps\_hud_util::setpoint("TOP",undefined,0,425,1);
	level.iconelem scaleovertime(1,20,20);
	wait(0.85);
	level.iconelem fadeovertime(0.15);
	level.iconelem.alpha = 0;
	maps\_utility::hint_fade(0.5);
}

//Function Number: 16
compass_reminder()
{
	clear_hints();
	level endon("clearing_hints");
	maps\_utility::hint(&"KILLHOUSE_HINT_OBJECTIVE_REMINDER",undefined,undefined,1);
	level.iconelem = maps\_hud_util::createicon("objective",32,32);
	level.iconelem.hidewheninmenu = 1;
	level.iconelem maps\_hud_util::setpoint("TOP",undefined,0,155);
	for(var_00 = 0;var_00 < 5;var_00++)
	{
		wait(1);
		if(common_scripts\utility::flag("in_explosives_area") || common_scripts\utility::flag("in_obstacle_area") || common_scripts\utility::flag("in_NoReminder_Compass"))
		{
			level.iconelem fadeovertime(0.15);
			level.iconelem.alpha = 0;
			maps\_utility::hint_fade(0.5);
			wait(0.75);
			clear_hints();
			wait(0.25);
			return;
		}
	}

	level.iconelem maps\_hud_util::setpoint("TOP",undefined,0,425,1);
	level.iconelem scaleovertime(1,20,20);
	wait(0.85);
	level.iconelem fadeovertime(0.15);
	level.iconelem.alpha = 0;
	wait(2);
	maps\_utility::hint_fade(0.5);
}

//Function Number: 17
move_gaz_once_player_past()
{
	common_scripts\utility::flag_wait("past_gaz");
	common_scripts\utility::flag_wait("gaz_intro_done");
	common_scripts\utility::flag_wait("rifle_picked_up");
	var_00 = getnode("gaz_intro","targetname");
	var_00 maps\_anim::anim_single_solo(level.waters,"h1_killhouse_gaz_walkonstage");
	var_00 notify("end_idle");
	level.waters.ref_node = var_00;
	var_00 thread maps\_anim::anim_loop_solo(level.waters,"killhouse_gaz_idleB",undefined,"stop_loop");
	common_scripts\utility::flag_set("gaz_in_idle_position");
}

//Function Number: 18
move_gaz_fake()
{
	var_00 = getnode("stationone_node","script_noteworthy");
	var_01 = spawn("script_origin",var_00.origin + (0,12,0));
	var_01.angles = var_00.angles;
	level.waters.ref_node = var_01;
	level.waters.ref_node thread maps\_anim::anim_loop_solo(level.waters,"killhouse_gaz_idleB",undefined,"stop_loop");
	common_scripts\utility::flag_set("gaz_in_idle_position");
}

//Function Number: 19
fail_on_damage()
{
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(isplayer(var_01))
		{
			maps\_friendlyfire::missionfail();
		}
	}
}

//Function Number: 20
fail_if_friendlies_in_line_of_fire()
{
	var_00 = 1;
	var_01 = 1;
	level endon("okay_if_friendlies_in_line_of_fire");
	for(;;)
	{
		var_02 = level.player common_scripts\utility::waittill_any_return("weapon_fired","player_flash","player_frag");
		if(!isdefined(var_02))
		{
			break;
		}

		if(var_02 == "weapon_fired")
		{
			var_03 = level.player getcurrentweapon();
			if(var_03 == "c4")
			{
				continue;
			}
		}

		if(var_02 == "player_frag" && isdefined(var_00))
		{
			if(!level.player isthrowinggrenade())
			{
				continue;
			}

			wait(1);
		}

		if(var_02 == "player_flash" && isdefined(var_01))
		{
			if(!level.player isthrowinggrenade())
			{
				continue;
			}

			wait(1);
		}

		var_04 = getaiarray("allies");
		for(var_05 = 0;var_05 < var_04.size;var_05++)
		{
			var_06 = common_scripts\utility::within_fov(level.player.origin,level.player.angles,var_04[var_05].origin,cos(25));
			var_07 = distance(level.player.origin,var_04[var_05].origin);
			if(var_06 && var_07 < 1000)
			{
				level notify("mission failed");
				setdvar("ui_deadquote",&"KILLHOUSE_FIRED_NEAR_FRIENDLY");
				maps\_utility::missionfailedwrapper();
			}
		}
	}
}

//Function Number: 21
setup_player_action_notifies()
{
	wait(1);
	notifyoncommand("player_frag","+frag");
	notifyoncommand("player_flash","-smoke");
}

//Function Number: 22
vision_trigger(param_00)
{
	for(;;)
	{
		self waittill("trigger");
		maps\_utility::set_vision_set(param_00,1);
		while(level.player istouching(self))
		{
			wait(0.1);
		}
	}
}

//Function Number: 23
flashed_hud_elem()
{
	for(;;)
	{
		if(level.player common_scripts\utility::isflashed())
		{
			level notify("flashed");
		}
		else
		{
			level notify("not_flashed");
		}

		wait(0.2);
	}
}

//Function Number: 24
flashed_debug()
{
	for(;;)
	{
		level waittill("flashed");
		var_00 = maps\_hud_util::get_stats_display_hud();
		var_00.y = 130;
		var_00 settext(&"KILLHOUSE_YOUR_TIME");
		level waittill("not_flashed");
		var_00 destroy();
	}
}

//Function Number: 25
flag_when_lowered(param_00)
{
	level.targets_hit = 0;
	var_01 = gettargetdummies("rifle");
	var_02 = var_01.size;
	while(level.targets_hit < var_02)
	{
		wait(0.05);
	}

	common_scripts\utility::flag_set(param_00);
}

//Function Number: 26
ads_shoot_dialog()
{
	wait(0.4);
	if(!common_scripts\utility::flag("ADS_targets_shot"))
	{
		if(level.console)
		{
			thread keyhint("attack");
		}
		else
		{
			thread keyhint("pc_attack");
		}

		level.waters execdialog("shooteachtarget");
	}

	common_scripts\utility::flag_set("ADS_shoot_dialog");
}

//Function Number: 27
deck_start()
{
	var_00 = getent("deck_start","targetname");
	level.player setorigin(var_00.origin);
	level.player setplayerangles(var_00.angles);
	level.player giveweapon("g36c");
	level.player giveweapon("mp5");
	level.player switchtoweapon("mp5");
	common_scripts\utility::flag_set("start_deck");
}

//Function Number: 28
deck_training()
{
	var_00 = getentarray("deck_target","script_noteworthy");
	common_scripts\utility::array_thread(var_00,::cargoship_targets);
	common_scripts\utility::flag_wait("start_deck");
	var_01 = getent("area_two_one","targetname");
	var_02 = getent("area_two_two","targetname");
	var_03 = getent("area_two_three","targetname");
	var_04 = getent("area_two_four","targetname");
	var_05 = getent("area_two_five","targetname");
	var_06 = getent("area_two_finish","targetname");
	var_07 = getent("area_two_quit","targetname");
	var_08 = 1;
	for(;;)
	{
		common_scripts\utility::flag_wait("price_reveal_done");
		var_01 waittill("trigger");
		thread maps\_utility::autosave_by_name("starting_deck_attack");
		if(var_08)
		{
			registerobjective("obj_deck",&"KILLHOUSE_COMPLETE_THE_DECK_MOCKUP",getent("area_two_one","targetname"));
			var_08 = 0;
		}

		setobjectivestate("obj_deck","current");
		cqb_timer_setup();
		wait(2);
		level.price thread execdialog("gogogo");
		thread accuracy_bonus();
		thread starttimer(60);
		if(isdefined(level.iw_best))
		{
			level.iw_best destroy();
		}

		var_07 thread check_deck_training_quit();
		var_01 pop_up_and_wait();
		level.price thread execdialog("position2");
		setobjectivelocation("obj_deck",var_02);
		var_02 pop_up_and_wait();
		level.price thread execdialog("position3");
		setobjectivelocation("obj_deck",var_03);
		var_03 pop_up_and_wait();
		level.price thread execdialog("position4");
		setobjectivelocation("obj_deck",var_04);
		var_04 pop_up_and_wait();
		level.price thread execdialog("5go");
		setobjectivelocation("obj_deck",var_05);
		var_05 pop_up_and_wait();
		level.price thread execdialog("finalgo");
		setobjectivelocation("obj_deck",var_06);
		var_06 waittill("trigger");
		level notify("test_cleared");
		setobjectivestate("obj_deck","done");
		thread maps\_utility::autosave_by_name("completed_deck_attack");
		killtimer(15.85,1);
	}
}

//Function Number: 29
check_deck_training_quit()
{
	level endon("test_cleared");
	self waittill("trigger");
	level notify("mission failed");
	setdvar("ui_deadquote",&"KILLHOUSE_SHIP_MUST_CLEAR_DECK_MOCK_UP");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 30
get_randomized_targets()
{
	var_00 = strtok(self.script_linkto," ");
	var_01 = [];
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_03 = var_00[var_02];
		var_04 = getent(var_03,"script_linkname");
		if(isdefined(var_04))
		{
			var_01 = common_scripts\utility::add_to_array(var_01,var_04);
			continue;
		}
	}

	var_01 = common_scripts\utility::array_randomize(var_01);
	return var_01;
}

//Function Number: 31
pop_up_and_wait()
{
	self waittill("trigger");
	var_00 = get_randomized_targets();
	var_01 = 0;
	level.targets_hit = 0;
	var_02 = [];
	var_03 = 0;
	for(var_04 = 0;var_01 < 3;var_04++)
	{
		wait(randomfloatrange(0.25,0.4));
		var_00[var_04] notify("pop_up");
		if(var_00[var_04].targetname == "hostile")
		{
			var_01++;
			continue;
		}

		var_02[var_03] = var_00[var_04];
		var_03++;
	}

	while(level.targets_hit != var_01)
	{
		wait(0.05);
	}

	if(var_02.size > 0)
	{
		for(var_05 = 0;var_05 < var_02.size;var_05++)
		{
			var_02[var_05] notify("pop_down");
		}
	}
}

//Function Number: 32
jumpoff_monitor()
{
	level endon("starting_rope");
	self waittill("trigger");
	var_00 = getent("top_of_rope_trigger","targetname");
	var_00 common_scripts\utility::trigger_off();
	level.jumpoff = 1;
	level notify("mission failed");
	if(common_scripts\utility::flag("activate_rope"))
	{
		setdvar("ui_deadquote",&"KILLHOUSE_SHIP_JUMPED_OFF");
	}
	else
	{
		setdvar("ui_deadquote",&"KILLHOUSE_SHIP_JUMPED_TOO_EARLY");
	}

	maps\_utility::missionfailedwrapper();
}

//Function Number: 33
flashbang_ammo_monitor(param_00)
{
	level endon("test_cleared");
	level.volumes_flashed = 0;
	for(;;)
	{
		level.player waittill("grenade_fire",var_01,var_02);
		var_01 waittill("death");
		waittillframeend;
		var_03 = param_00.size - level.volumes_flashed;
		if(level.player getweaponammostock("flash_grenade") < var_03)
		{
			level notify("mission failed");
			setdvar("ui_deadquote",&"KILLHOUSE_SHIP_OUT_OF_FLASH");
			maps\_utility::missionfailedwrapper();
		}
	}
}

//Function Number: 34
check_if_in_volume(param_00,param_01)
{
	self waittill("death");
	if(param_00 istouching(param_01))
	{
		param_01 notify("flashed");
		level.volumes_flashed++;
	}
}

//Function Number: 35
track_grenade_origin(param_00,param_01)
{
	self endon("death");
	param_01 endon("flashed");
	for(;;)
	{
		param_00.origin = self.origin;
		wait(0.05);
	}
}

//Function Number: 36
flash_dialog_three(param_00)
{
	level endon("clear_course");
	param_00 endon("flashed");
	self waittill("trigger");
	var_01 = 1;
	for(;;)
	{
		if(!level.player istouching(self))
		{
			if(var_01)
			{
				level.price thread execdialog("3");
				level.price thread execdialog("goback");
				var_01 = 0;
			}
			else
			{
				level.price thread execdialog("position3");
				var_01 = 1;
			}
		}
		else
		{
			level.price thread execdialog("flashthrudoor");
			thread keyhint("flash");
		}

		wait(5);
	}
}

//Function Number: 37
flash_dialog_six(param_00)
{
	level endon("clear_course");
	param_00 endon("flashed");
	self waittill("trigger");
	var_01 = 1;
	for(;;)
	{
		if(!level.player istouching(self))
		{
			if(var_01)
			{
				level.price thread execdialog("goback");
				var_01 = 0;
			}
			else
			{
				level.price thread execdialog("6go");
				var_01 = 1;
			}
		}
		else
		{
			level.price thread execdialog("flashthrudoor");
			thread keyhint("flash");
		}

		wait(5);
	}
}

//Function Number: 38
wait_till_flashed(param_00)
{
	param_00 endon("flashed");
	for(;;)
	{
		level.player waittill("grenade_fire",var_01,var_02);
		if(var_02 == "flash_grenade")
		{
			var_03 = spawn("script_origin",(0,0,0));
			var_01 thread track_grenade_origin(var_03,param_00);
			var_01 thread check_if_in_volume(var_03,param_00);
		}
	}
}

//Function Number: 39
wait_till_pos_cleared(param_00)
{
	level endon("clear_course");
	if(!isdefined(param_00))
	{
		self waittill("trigger");
	}

	level.targets_hit = 0;
	if(isdefined(self.target))
	{
		var_01 = getentarray(self.target,"targetname");
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			var_01[var_02] notify("pop_up");
		}

		level.price thread execdialog("hittargets");
		var_03 = 0;
		while(level.targets_hit != var_01.size)
		{
			if(var_03 > 5)
			{
				if(!level.player istouching(self))
				{
					var_04 = [];
					var_04[0] = "missgoback";
					var_04[1] = "passgoback";
					var_04[2] = "goback";
					var_05 = var_04[randomint(var_04.size)];
					level.price thread execdialog(var_05);
					var_03 = 0;
				}
				else
				{
					if(level.targets_hit > 0)
					{
						var_06 = [];
						var_06[0] = "shoottarget";
						var_06[1] = "remainingtarg";
						var_06[2] = "hitother";
						var_05 = var_06[randomint(var_06.size)];
						level.price thread execdialog(var_05);
					}
					else
					{
						level.price thread execdialog("hittargets");
					}

					var_03 = 0;
				}
			}

			var_03 = var_03 + 0.05;
			wait(0.05);
		}
	}
}

//Function Number: 40
rope_triggercheck_playerisinvalidstate()
{
	level endon("starting_rope");
	var_00 = getent("top_of_rope_trigger","targetname");
	for(;;)
	{
		if(level.player isonground() && !level.player isleaning())
		{
			var_00 common_scripts\utility::trigger_on();
		}
		else
		{
			var_00 common_scripts\utility::trigger_off();
		}

		wait 0.05;
	}
}

//Function Number: 41
rope()
{
	var_00 = getent("top_of_rope_trigger","targetname");
	var_00 common_scripts\utility::trigger_off();
	var_00 usetriggerrequirelookat();
	var_01 = getent("top_of_rope","targetname");
	var_02 = getent("bottom_of_rope","targetname");
	level.jumpoff = 0;
	for(;;)
	{
		common_scripts\utility::flag_wait("activate_rope");
		thread rope_triggercheck_playerisinvalidstate();
		var_00 sethintstring(&"KILLHOUSE_USE_ROPE");
		for(;;)
		{
			var_00 waittill("trigger");
			wait 0.05;
			if(!level.player isleaning())
			{
				break;
			}
		}

		level notify("starting_rope");
		level.player disableweapons();
		level.player allowcrouch(0);
		level.player allowprone(0);
		level.player allowlean(0);
		if(level.jumpoff == 1)
		{
			return;
		}

		level.player thread maps\_utility::play_sound_on_entity("scn_killhouse_rope_slide");
		var_03 = maps\_utility::spawn_anim_model("view_body");
		var_03 hide();
		var_04 = getent("training_rope_node","targetname");
		var_04 thread maps\_anim::anim_first_frame_solo(var_03,"training_rope");
		var_04 thread maps\_anim::anim_single_solo(var_03,"training_rope");
		var_05 = getanimlength(level.scr_anim[var_03.animname]["training_rope"]);
		var_06 = var_05 - 1.7;
		thread maps\_utility::flag_set_delayed("start_timer",var_06);
		level.player method_855E(var_03,"tag_player",1,0.3,0,0.1,40,40,55,55,1);
		wait(0.35);
		var_03 show();
		var_04 waittill("training_rope");
		var_03 delete();
		level.player enableweapons();
		level.player allowcrouch(1);
		level.player allowprone(1);
		level.player allowlean(1);
		var_00 common_scripts\utility::trigger_off();
	}
}

//Function Number: 42
fail_if_damage_waiter()
{
	self endon("pop_down");
	self waittill("damage",var_00,var_01,var_02,var_03,var_04);
	setdvar("ui_deadquote",&"KILLHOUSE_HIT_FRIENDLY");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 43
timer_think()
{
	for(;;)
	{
		common_scripts\utility::flag_wait("start_timer");
		var_00 = 60;
		if(getdvarint("killhouse_too_slow") >= 1)
		{
			var_00 = 90;
		}

		thread starttimer(var_00);
		common_scripts\utility::flag_clear("start_timer");
	}
}

//Function Number: 44
starttimer(param_00)
{
	clear_timer_elems();
	level endon("kill_timer");
	level.hudtimerindex = 20;
	thread cqb_timer_think();
	level.updated_timer = maps\_hud_util::get_countdown_hud();
	level.updated_timer.text.label = &"KILLHOUSE_YOUR_TIME";
	level.updated_timer settenthstimerup(0.05);
	wait(param_00);
	maps\_hud_util::destroy_countdown_hud(level.updated_timer);
	level thread mission_failed_out_of_time();
}

//Function Number: 45
cqb_timer_setup()
{
	level.digit_array_tenths = cqb_timer_get_planes("tenths_plane");
	level.digit_array_seconds = cqb_timer_get_planes("seconds_plane");
	level.digit_array_tens_of_seconds = cqb_timer_get_planes("tens_of_seconds_plane");
	cqb_digit_reset(level.digit_array_seconds);
	cqb_digit_reset(level.digit_array_tenths);
	cqb_digit_reset(level.digit_array_tens_of_seconds);
}

//Function Number: 46
cqb_timer_get_planes(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 <= 9;var_02++)
	{
		var_01[var_02] = getent(param_00 + "_" + common_scripts\utility::tostring(var_02),"targetname");
	}

	return var_01;
}

//Function Number: 47
cqb_digit_reset(param_00)
{
	for(var_01 = 1;var_01 <= 9;var_01++)
	{
		param_00[var_01] hide();
	}

	param_00[0] show();
}

//Function Number: 48
cqb_timer_think()
{
	level endon("kill_timer");
	wait(0.1);
	level.start_time = gettime();
	cqb_digit_reset(level.digit_array_seconds);
	cqb_digit_reset(level.digit_array_tenths);
	cqb_digit_reset(level.digit_array_tens_of_seconds);
	var_00 = 9;
	var_01 = 9;
	var_02 = 9;
	for(;;)
	{
		var_03 = gettime() - level.start_time * 0.001;
		var_04 = floor(var_03);
		var_05 = int(var_03 - var_04 * 10);
		var_06 = int(common_scripts\utility::mod(var_04,10));
		var_07 = int(floor(var_04 * 0.1));
		if(var_05 != var_00)
		{
			var_00 = var_05;
			cqb_timer_change_digit(var_05,level.digit_array_tenths);
		}

		if(var_06 != var_01)
		{
			var_01 = var_06;
			cqb_timer_change_digit(var_06,level.digit_array_seconds);
		}

		if(var_07 != var_02)
		{
			var_02 = var_07;
			cqb_timer_change_digit(var_07,level.digit_array_tens_of_seconds);
		}

		wait(0.05);
	}
}

//Function Number: 49
cqb_timer_change_digit(param_00,param_01)
{
	switch(param_00)
	{
		case 0:
			break;

		case 1:
			break;

		case 2:
			break;

		case 3:
			break;

		case 4:
			break;

		case 5:
			break;

		case 6:
			break;

		case 7:
			break;

		case 8:
			break;

		case 9:
			break;
	}
}

//Function Number: 50
dialog_sprint_reminders()
{
	level endon("sprinted");
	for(;;)
	{
		wait(8);
		level.price thread execdialog("sprint");
	}
}

//Function Number: 51
mission_failed_out_of_time()
{
	level.player endon("death");
	level endon("kill_timer");
	var_00 = [];
	var_00[0] = "startover";
	var_00[1] = "doitagain";
	var_00[2] = "tooslow";
	var_01 = var_00[randomint(var_00.size)];
	level.price thread execdialog(var_01);
	var_02 = getdvarint("killhouse_too_slow");
	setdvar("killhouse_too_slow",var_02 + 1);
	level notify("mission failed");
	if(!common_scripts\utility::flag("at_finish"))
	{
		setdvar("ui_deadquote",&"KILLHOUSE_SHIP_TOO_SLOW");
	}
	else
	{
		setdvar("ui_deadquote",&"KILLHOUSE_SHIP_DIDNT_SPRINT");
	}

	maps\_utility::missionfailedwrapper();
}

//Function Number: 52
mission_failed_quit_training()
{
	while(common_scripts\utility::flag("cargoshipTrainingOn"))
	{
		if(common_scripts\utility::flag("in_quit_cargoship_tutorial"))
		{
			level.player endon("death");
			level endon("kill_timer");
			level notify("mission failed");
			setdvar("ui_deadquote",&"KILLHOUSE_SHIP_MUST_CLEAR_DECK_MOCK_UP");
			maps\_utility::missionfailedwrapper();
		}

		wait(1);
	}
}

//Function Number: 53
clear_timer_elems()
{
	if(isdefined(level.updated_timer))
	{
		maps\_hud_util::destroy_countdown_hud(level.updated_timer);
	}

	if(isdefined(level.time))
	{
		level.time destroy();
	}

	if(isdefined(level.final_time))
	{
		level.final_time destroy();
	}

	if(isdefined(level.bonus))
	{
		level.bonus destroy();
	}

	if(isdefined(level.label))
	{
		level.label destroy();
	}

	if(isdefined(level.iw_best))
	{
		level.iw_best destroy();
	}

	if(isdefined(level.recommended_label))
	{
		level.recommended_label destroy();
	}

	if(isdefined(level.recommended_label2))
	{
		level.recommended_label2 destroy();
	}

	if(isdefined(level.recommended))
	{
		level.recommended destroy();
	}

	if(isdefined(level.bonus_text))
	{
		level.bonus_text destroy();
	}

	if(isdefined(level.time_text))
	{
		level.time_text destroy();
	}

	if(isdefined(level.final_time_text))
	{
		level.final_time_text destroy();
	}

	if(isdefined(level.iw_best_text))
	{
		level.iw_best_text destroy();
	}

	if(isdefined(level.backers))
	{
		for(var_00 = 0;var_00 < level.backers.size;var_00++)
		{
			level.backers[var_00] destroy();
		}

		level.backers = undefined;
	}
}

//Function Number: 54
clearhud_after10sec()
{
	wait(10);
	if(!common_scripts\utility::flag("cargoshipTrainingOn"))
	{
		clear_timer_elems();
	}
}

//Function Number: 55
getstatbackers(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	var_04[0] = newhudelem();
	var_04[0].x = param_00;
	var_04[0].y = param_01;
	var_04[0] setshader("h1_hud_fng_results_blur",param_02,param_03);
	var_04[0].alignx = "right";
	var_04[0].aligny = "top";
	var_04[0].sort = 1;
	var_04[0].foreground = 0;
	var_04[0].horzalign = "right";
	var_04[0].vertalign = "top";
	var_04[0].alpha = 0.9;
	var_04[0].hidewheninmenu = 1;
	var_04[0].hidewhendead = 1;
	var_04[1] = newhudelem();
	var_04[1].x = param_00;
	var_04[1].y = param_01;
	var_04[1] setshader("h1_hud_fng_results_border",param_02,param_03);
	var_04[1].alignx = "right";
	var_04[1].aligny = "top";
	var_04[1].sort = 2;
	var_04[1].foreground = 0;
	var_04[1].horzalign = "right";
	var_04[1].vertalign = "top";
	var_04[1].alpha = 0.33;
	var_04[1].hidewheninmenu = 1;
	var_04[1].hidewhendead = 1;
	return var_04;
}

//Function Number: 56
killtimer(param_00,param_01)
{
	level notify("kill_timer");
	clear_timer_elems();
	thread maps\killhouse_aud::aud_timer_end();
	var_02 = 227;
	var_03 = 227;
	var_04 = 2;
	var_05 = 20;
	var_06 = -30;
	var_07 = -232;
	var_08 = -50;
	var_09 = -143;
	level.backers = getstatbackers(var_06,var_05,var_02,var_03);
	var_0A = gettime() - level.start_time / 1000;
	if(getdvarint("loc_language",0) == 12)
	{
		level.time = maps\_hud_util::get_stats_display_hud(var_07,82,undefined,undefined,1);
		level.time_text = maps\_hud_util::get_stats_display_hud(var_08,82,undefined,undefined,1,&"KILLHOUSE_YOUR_TIME");
		level.time_text.alignx = "right";
	}
	else
	{
		level.time = maps\_hud_util::get_stats_display_hud(var_08,82,undefined,undefined,1);
		level.time.alignx = "right";
		level.time_text = maps\_hud_util::get_stats_display_hud(var_07,82,undefined,undefined,1,&"KILLHOUSE_YOUR_TIME");
	}

	level.time setvalue(var_0A);
	level waittill("accuracy_bonus");
	var_0B = var_0A - level.bonus_time;
	level.final_time = maps\_hud_util::get_stats_display_hud(var_09,146,undefined,undefined,1.6);
	level.final_time_text = maps\_hud_util::get_stats_display_hud(var_09,126,undefined,undefined,1,&"KILLHOUSE_YOUR_FINAL_TIME");
	level.final_time_text.alignx = "center";
	level.final_time.alignx = "center";
	level.final_time setvalue(var_0B);
	if(getdvarint("loc_language",0) == 12)
	{
		level.iw_best = maps\_hud_util::get_stats_display_hud(var_07,68,undefined,undefined,1);
		if(param_01)
		{
			level.iw_best_text = maps\_hud_util::get_stats_display_hud(var_08,68,undefined,undefined,1,&"KILLHOUSE_IW_DECK_TIME");
		}
		else
		{
			level.iw_best_text = maps\_hud_util::get_stats_display_hud(var_08,68,undefined,undefined,1,&"KILLHOUSE_IW_BEST_TIME");
		}

		level.iw_best_text.alignx = "right";
	}
	else
	{
		level.iw_best = maps\_hud_util::get_stats_display_hud(var_08,68,undefined,undefined,1);
		level.iw_best.alignx = "right";
		if(param_01)
		{
			level.iw_best_text = maps\_hud_util::get_stats_display_hud(var_07,68,undefined,undefined,1,&"KILLHOUSE_IW_DECK_TIME");
		}
		else
		{
			level.iw_best_text = maps\_hud_util::get_stats_display_hud(var_07,68,undefined,undefined,1,&"KILLHOUSE_IW_BEST_TIME");
		}
	}

	level.iw_best setvalue(param_00);
	if(param_01)
	{
		wait(5);
		clear_timer_elems();
		return;
	}

	level.recommended_label = maps\_hud_util::get_stats_display_hud(var_09,174,undefined,undefined,1,&"KILLHOUSE_RECOMMENDED_LABEL");
	level.recommended_label.alignx = "center";
	thread clearhud_after10sec();
	if(var_0B > 40)
	{
		setdvar("recommended_gameskill","0");
		level.recommended = maps\_hud_util::get_stats_display_hud(var_09,192,undefined,undefined,1.6,&"KILLHOUSE_RECOMMENDED_EASY");
	}
	else if(var_0B > 26)
	{
		setdvar("recommended_gameskill","1");
		level.recommended = maps\_hud_util::get_stats_display_hud(var_09,192,undefined,undefined,1.6,&"KILLHOUSE_RECOMMENDED_NORMAL");
	}
	else if(var_0B > 20)
	{
		setdvar("recommended_gameskill","2");
		level.recommended = maps\_hud_util::get_stats_display_hud(var_09,192,undefined,undefined,1.6,&"KILLHOUSE_RECOMMENDED_HARD");
	}
	else
	{
		setdvar("recommended_gameskill","3");
		level.recommended = maps\_hud_util::get_stats_display_hud(var_09,192,undefined,undefined,1.6,&"KILLHOUSE_RECOMMENDED_VETERAN");
	}

	level.recommended.alignx = "center";
	if(var_0B < 19)
	{
		maps\_utility::giveachievement_wrapper("NEW_SQUADRON_RECORD");
		if(var_0B < 15.1)
		{
			maps\_utility::giveachievement_wrapper("BEST_OF_THE_BEST");
		}
	}

	return var_0B;
}

//Function Number: 57
accuracy_bonus()
{
	var_00 = level.player getweaponslistprimaries();
	var_01 = level.player getweaponammostock(var_00[0]);
	var_02 = level.player getweaponammostock(var_00[1]);
	var_03 = level.player getweaponammoclip(var_00[0]);
	var_04 = level.player getweaponammoclip(var_00[1]);
	var_05 = var_01 + var_02 + var_03 + var_04;
	level waittill("test_cleared");
	var_01 = level.player getweaponammostock(var_00[0]);
	var_02 = level.player getweaponammostock(var_00[1]);
	var_03 = level.player getweaponammoclip(var_00[0]);
	var_04 = level.player getweaponammoclip(var_00[1]);
	var_06 = var_01 + var_02 + var_03 + var_04;
	var_07 = var_05 - var_06;
	var_08 = 20;
	if(var_07 > var_08)
	{
		var_09 = var_07 - var_08;
	}
	else
	{
		var_09 = 0;
	}

	level.bonus_time = 15 - var_09 * 0.2;
	level.bonus_time = common_scripts\utility::ter_op(level.bonus_time > 0,level.bonus_time,0);
	if(getdvarint("loc_language",0) == 12)
	{
		level.bonus_text = maps\_hud_util::get_stats_display_hud(-50,97,undefined,undefined,1,&"KILLHOUSE_ACCURACY_BONUS");
		level.bonus = maps\_hud_util::get_stats_display_hud(-232,97,undefined,undefined,1);
		level.bonus.alignx = "left";
		level.bonus_text.alignx = "right";
	}
	else
	{
		level.bonus_text = maps\_hud_util::get_stats_display_hud(-232,97,undefined,undefined,1,&"KILLHOUSE_ACCURACY_BONUS");
		level.bonus = maps\_hud_util::get_stats_display_hud(-50,97,undefined,undefined,1);
		level.bonus.alignx = "right";
	}

	level.bonus setvalue(level.bonus_time * -1);
	level notify("accuracy_bonus");
}

//Function Number: 58
nagplayer(param_00,param_01)
{
	if(self.speaking)
	{
		return 0;
	}

	var_02 = gettime();
	if(var_02 - self.lastspeaktime < 1)
	{
		return 0;
	}

	if(var_02 - self.lastnagtime < param_01 * 1000)
	{
		return 0;
	}

	execdialog(param_00);
	self.lastnagtime = self.lastspeaktime;
	return 1;
}

//Function Number: 59
scoldplayer(param_00)
{
	if(self.speaking)
	{
		return 0;
	}

	execdialog(param_00);
	return 1;
}

//Function Number: 60
execdialog(param_00,param_01)
{
	self.speaking = 1;
	maps\_anim::anim_single_queue(self,param_00);
	self.speaking = 0;
	self.lastspeaktime = gettime();
	if(isdefined(param_01) && param_01 == 1)
	{
		thread maps\killhouse_anim::play_idle_facial_anim();
	}
}

//Function Number: 61
actionnodethink(param_00)
{
	switch(param_00.script_noteworthy)
	{
		case "ammo_node":
			break;
	}
}

//Function Number: 62
getfreeactionnode(param_00)
{
	var_01 = undefined;
	while(isdefined(param_00.target))
	{
		var_02 = getnode(param_00.target,"targetname");
		if(isdefined(var_02.script_noteworthy))
		{
			if(var_02.inuse)
			{
				if(!isdefined(var_01))
				{
					return param_00;
				}
				else
				{
					return var_01;
				}
			}

			var_01 = var_02;
		}

		param_00 = var_02;
	}

	return var_01;
}

//Function Number: 63
initactionchain(param_00)
{
	while(isdefined(param_00.target))
	{
		param_00.inuse = 0;
		param_00 = getnode(param_00.target,"targetname");
	}
}

//Function Number: 64
actionchainthink(param_00)
{
	self getgoalvolume(param_00);
	self waittill("goal");
	var_01 = param_00;
	var_02 = undefined;
	while(!isdefined(var_02))
	{
		var_02 = getfreeactionnode(var_01);
		wait(0.05);
	}

	while(isdefined(var_02))
	{
		var_02.inuse = 1;
		while(var_01 != var_02)
		{
			var_01 = getnode(var_01.target,"targetname");
			self getgoalvolume(var_01);
			self waittill("goal");
		}

		actionnodethink(var_02);
		while(isdefined(var_02) && var_01 == var_02)
		{
			var_02 = getfreeactionnode(var_01);
			wait(randomfloatrange(0.1,0.5));
		}

		var_01.inuse = 0;
	}

	while(isdefined(var_01.target))
	{
		var_01 = getnode(var_01.target,"targetname");
		self getgoalvolume(var_01);
		self waittill("goal");
	}
}

//Function Number: 65
raiseplywoodwalls()
{
	var_00 = getentarray("plywood","script_noteworthy");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] rotateroll(90,0.25,0.1,0.1);
		var_00[var_01] playsound("killhouse_target_up_wood");
	}
}

//Function Number: 66
silently_lowerplywoodwalls()
{
	var_00 = getentarray("plywood","script_noteworthy");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] rotateroll(-90,0.25,0.1,0.1);
	}
}

//Function Number: 67
lowerplywoodwalls()
{
	var_00 = getentarray("plywood","script_noteworthy");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] rotateroll(-90,0.25,0.1,0.1);
		var_00[var_01] playsound("killhouse_target_up_wood");
	}
}

//Function Number: 68
raisetargetdummies(param_00,param_01,param_02)
{
	var_03 = getentarray(param_00 + "_target_dummy","script_noteworthy");
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_05 = var_03[var_04];
		if(isdefined(param_02) && var_05.dummyid != param_02)
		{
			continue;
		}

		if(isdefined(param_01) && var_05.laneid != param_01)
		{
			continue;
		}

		if(var_05.raised)
		{
			continue;
		}

		var_03[var_04] thread movetargetdummy("raise");
	}
}

//Function Number: 69
raisetargetdummies_noassist(param_00,param_01,param_02)
{
	var_03 = getentarray(param_00 + "_target_dummy","script_noteworthy");
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_05 = var_03[var_04];
		if(isdefined(param_02) && var_05.dummyid != param_02)
		{
			continue;
		}

		if(isdefined(param_01) && var_05.laneid != param_01)
		{
			continue;
		}

		if(var_05.raised)
		{
			continue;
		}

		var_03[var_04] thread movetargetdummy("raiseNoAssist");
	}
}

//Function Number: 70
movetargetdummy(param_00)
{
	self setcandamage(0);
	while(self.moving)
	{
		wait(0.05);
	}

	switch(param_00)
	{
		case "raise":
			break;

		case "raiseNoAssist":
			break;

		case "lower":
			break;
	}
}

//Function Number: 71
lowertargetdummies(param_00,param_01,param_02)
{
	var_03 = getentarray(param_00 + "_target_dummy","script_noteworthy");
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_05 = var_03[var_04];
		if(isdefined(param_02) && var_05.dummyid != param_02)
		{
			continue;
		}

		if(isdefined(param_01) && var_05.laneid != param_01)
		{
			continue;
		}

		if(!var_05.raised)
		{
			continue;
		}

		var_03[var_04] thread movetargetdummy("lower");
	}
}

//Function Number: 72
training_targetdummies(param_00)
{
	var_01 = gettargetdummies(param_00);
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_01[var_02] thread targetdummythink();
	}
}

//Function Number: 73
targetdummythink()
{
	self.orgent = getent(self.target,"targetname");
	self linkto(self.orgent);
	self.dummyid = int(self.script_label);
	self.laneid = int(self.targetname[4]);
	self.aim_assist_target = getent(self.orgent.target,"targetname");
	self.aim_assist_target.health = 10;
	self.aim_assist_target hide();
	self.aim_assist_target notsolid();
	self.orgent rotatepitch(-90,0.25);
	self.raised = 0;
	self.moving = 0;
	var_00 = getent("rifleTraining_stall","targetname");
	level.waters_speaking = 0;
	level.waters_last_line = 0;
	for(;;)
	{
		for(;;)
		{
			self waittill("damage",var_01,var_02,var_03,var_04,var_05);
			if(!level.player istouching(var_00))
			{
				target_down();
				if(level.waters_speaking != 1)
				{
					var_06 = [];
					var_06[0] = "gotostation1";
					var_06[1] = "heygo";
					var_06[2] = "getback";
					var_07 = var_06[randomint(var_06.size)];
					level.waters_speaking = 1;
					level.waters execdialog(var_07);
					level.waters_speaking = 0;
				}

				movetargetdummy("raise");
				continue;
			}

			var_08 = 1;
			if(level.hip_fire_required)
			{
				if(level.player maps\_utility::isads())
				{
					thread keyhint("stop_ads",2,var_08);
					target_down();
					if(level.waters_speaking != 1)
					{
						level.waters_speaking = 1;
						var_06 = [];
						var_06[0] = "stopaiming";
						var_06[1] = "seeyoufire";
						if(level.waters_last_line == 0)
						{
							level.waters execdialog("stopaiming");
							level.waters_last_line = 1;
						}
						else
						{
							level.waters execdialog("seeyoufire");
							level.waters_last_line = 0;
						}

						level.waters_speaking = 0;
					}

					movetargetdummy("raise");
					continue;
				}
			}

			break;
		}

		self notify("hit");
		level.targets_hit++;
		self playsound("killhouse_buzzer");
		target_down();
	}
}

//Function Number: 74
target_down()
{
	self.health = 10;
	self playsound("killhouse_target_up");
	self.moving = 1;
	self.aim_assist_target disableaimassist();
	self setcandamage(0);
	self.orgent rotatepitch(-90,0.25);
	wait(0.5);
	self.raised = 0;
	self.moving = 0;
}

//Function Number: 75
cargoship_targets()
{
	var_00 = getent(self.target,"targetname");
	var_01 = var_00 common_scripts\utility::spawn_tag_origin();
	var_02 = anglestoforward(var_01.angles);
	if(!isdefined(var_00.script_noteworthy))
	{
		var_00.script_noteworthy = "standard";
	}

	if(var_00.script_noteworthy == "reverse")
	{
		var_00 rotatepitch(90,0.25);
		var_01.origin = var_01.origin + anglestoforward(var_01.angles) * 65;
	}
	else
	{
		var_00 rotatepitch(-90,0.25);
		var_01.origin = var_01.origin - anglestoforward(var_01.angles) * 65;
	}

	self linkto(var_00);
	var_03 = getent(var_00.target,"targetname");
	var_03.health = 10;
	var_03 hide();
	var_03 notsolid();
	for(;;)
	{
		self waittill("pop_up");
		wait(randomfloatrange(0,0.2));
		self solid();
		self playsound("killhouse_target_up_metal");
		playfxontag(level._effect["dust_poof_radial_dummy_fng"],var_01,"tag_origin");
		self setcandamage(1);
		if(self.targetname != "friendly")
		{
			var_03 enableaimassist();
		}

		if(var_00.script_noteworthy == "reverse")
		{
			var_00 rotatepitch(-90,0.2);
		}
		else
		{
			var_00 rotatepitch(90,0.2);
		}

		wait(0.25);
		if(self.targetname == "friendly")
		{
			fail_if_damage_waiter();
		}
		else
		{
			for(;;)
			{
				self waittill("damage",var_04,var_05,var_06,var_07,var_08);
				if(var_08 == "MOD_IMPACT")
				{
					continue;
				}
				else
				{
					break;
				}
			}

			self notify("hit");
			self.health = 10;
			level.targets_hit++;
			self playsound("killhouse_buzzer");
			self playsound("killhouse_target_up");
			playfxontag(level._effect["dust_puff_radial_dummy_down_fng"],var_01,"tag_origin");
			var_03 disableaimassist();
		}

		self notsolid();
		if(var_00.script_noteworthy == "reverse")
		{
			var_00 rotatepitch(90,0.25);
		}
		else
		{
			var_00 rotatepitch(-90,0.25);
		}

		self setcandamage(0);
		wait(0.25);
	}

	var_01 delete();
}

//Function Number: 76
gettargetdummies(param_00,param_01,param_02)
{
	var_03 = getentarray(param_00 + "_target_dummy","script_noteworthy");
	var_04 = [];
	for(var_05 = 0;var_05 < var_03.size;var_05++)
	{
		var_06 = var_03[var_05];
		if(isdefined(param_02) && var_06.dummyid != param_02)
		{
			continue;
		}

		if(isdefined(param_01) && var_06.laneid != param_01)
		{
			continue;
		}

		var_04[var_04.size] = var_06;
	}

	if(isdefined(param_01) && isdefined(param_02))
	{
	}

	return var_04;
}

//Function Number: 77
set_ammo()
{
	if(self.classname == "weapon_fraggrenade" || self.classname == "weapon_flash_grenade")
	{
		self itemweaponsetammo(1,0);
		return;
	}

	self itemweaponsetammo(999,999);
}

//Function Number: 78
ammorespawnthink(param_00,param_01,param_02)
{
	wait(0.2);
	var_03 = self;
	var_04 = var_03.classname;
	var_05 = var_03.origin + (0,0,8);
	var_06 = var_03.angles;
	var_03 set_ammo();
	var_07 = undefined;
	if(isdefined(var_03.target))
	{
		var_07 = getent(var_03.target,"targetname");
		var_07.origin = var_03.origin;
		var_07.angles = var_03.angles;
	}

	if(param_01 == "flash_grenade")
	{
		var_08 = 1;
	}
	else
	{
		var_08 = 0.2;
	}

	if(isdefined(param_00))
	{
		self.origin = self.origin + (0,0,-10000);
		if(isdefined(var_07))
		{
			var_07 hide();
		}

		common_scripts\utility::flag_wait(param_00);
		if(isdefined(var_07))
		{
			var_07 show();
		}

		self.origin = self.origin + (0,0,10000);
		var_03 set_ammo();
	}

	if(isdefined(var_07) && isdefined(param_02))
	{
		var_07 thread delete_if_obj_complete(param_02);
	}

	if(param_01 == "alt_m16_grenadier")
	{
		while(!level.player hasweapon("m16_grenadier"))
		{
			wait(0.05);
		}
	}
	else
	{
		var_03 waittill("trigger");
	}

	if(isdefined(var_07))
	{
		var_07 delete();
	}

	if(param_01 == "alt_m16_grenadier")
	{
		return;
	}

	for(;;)
	{
		wait(1);
		if(level.player getfractionmaxammo(param_01) < var_08)
		{
			while(distance(level.player.origin,var_05) < 160)
			{
				wait(1);
			}

			var_03 = spawn(var_04,var_05,1);
			if(param_01 == "alt_m16_grenadier")
			{
				var_03 setmodel("weapon_m16gr_sp");
			}

			var_03.angles = var_06;
			var_03 set_ammo();
			wait(0.2);
			var_03.origin = var_05 + (0,0,-8);
			while(isdefined(var_03))
			{
				wait(1);
			}
		}
	}
}

//Function Number: 79
delete_if_obj_complete(param_00)
{
	self endon("death");
	common_scripts\utility::flag_wait(param_00);
	self delete();
}

//Function Number: 80
test2(param_00)
{
	wait(1);
}

//Function Number: 81
pointinfov(param_00)
{
	var_01 = anglestoforward(self.angles);
	return vectordot(var_01,param_00 - self.origin) > 0.766;
}

//Function Number: 82
registerobjective(param_00,param_01,param_02)
{
	common_scripts\utility::flag_init(param_00);
	var_03 = level.objectives.size;
	var_04 = spawnstruct();
	var_04.name = param_00;
	var_04.id = var_03;
	var_04.state = "invisible";
	var_04.text = param_01;
	var_04.entity = param_02;
	var_04.added = 0;
	level.objectives[param_00] = var_04;
	return var_04;
}

//Function Number: 83
setobjectivestate(param_00,param_01)
{
	var_02 = level.objectives[param_00];
	var_02.state = param_01;
	if(!var_02.added)
	{
		objective_add(var_02.id,var_02.state,var_02.text,var_02.entity.origin);
		var_02.added = 1;
	}
	else
	{
		objective_state(var_02.id,var_02.state);
	}

	if(var_02.state == "done")
	{
		common_scripts\utility::flag_set(param_00);
	}
}

//Function Number: 84
setobjectivestate_nomessage(param_00,param_01)
{
	var_02 = level.objectives[param_00];
	var_02.state = param_01;
	if(!var_02.added)
	{
		objective_add(var_02.id,var_02.state,var_02.text,var_02.entity.origin);
		var_02.added = 1;
	}
	else
	{
		objective_state_nomessage(var_02.id,var_02.state);
	}

	if(var_02.state == "done")
	{
		common_scripts\utility::flag_set(param_00);
	}
}

//Function Number: 85
setassubobjective(param_00,param_01)
{
	var_02 = level.objectives[param_00];
	objective_indentlevel(var_02.id,param_01);
}

//Function Number: 86
setobjectivestring(param_00,param_01)
{
	var_02 = level.objectives[param_00];
	var_02.text = param_01;
	objective_string(var_02.id,param_01);
}

//Function Number: 87
setobjectivelocation(param_00,param_01)
{
	var_02 = level.objectives[param_00];
	var_02.loc = param_01;
	objective_position(var_02.id,var_02.loc.origin);
}

//Function Number: 88
setobjectiveremaining(param_00,param_01,param_02)
{
	var_03 = level.objectives[param_00];
	if(!param_02)
	{
		objective_string(var_03.id,param_01);
		return;
	}

	objective_string(var_03.id,param_01,param_02);
}

//Function Number: 89
printabovehead(param_00,param_01,param_02,param_03)
{
	self endon("death");
	if(!isdefined(param_02))
	{
		param_02 = (0,0,0);
	}

	if(!isdefined(param_03))
	{
		param_03 = (1,0,0);
	}

	for(var_04 = 0;var_04 < param_01 * 20;var_04++)
	{
		if(!isalive(self))
		{
			return;
		}

		var_05 = self getshootatpos() + (0,0,10) + param_02;
		wait(0.05);
	}
}

//Function Number: 90
killhouse_guy_exitconditionoverride(param_00)
{
	return 0;
}

//Function Number: 91
firearmdepot_guy_think()
{
	level endon("DespawnGuysHangar1");
	var_00 = getent("firearmDepotGuy","targetname");
	var_00 maps\_utility::set_ignoresuppression(1);
	var_01 = [];
	var_01[0] = getnode("firearmDepotNode_0","targetname");
	var_01[1] = getnode("firearmDepotNode_1","targetname");
	var_01[2] = getnode("firearmDepotNode_2","targetname");
	var_01[3] = getnode("firearmDepotNode_3","targetname");
	var_02 = 3;
	var_03 = 0;
	var_04 = 0;
	var_00.disablearrivals = 1;
	var_00.exitconditioncheckfunc = ::killhouse_guy_exitconditionoverride;
	var_00 maps\_utility::set_generic_run_anim("patrol_walk_unarmed");
	var_00 maps\_utility::set_generic_idle_anim("patrol_unarmed_idle");
	var_00 maps\_utility::gun_remove();
	common_scripts\utility::flag_wait("lootz_intro_start");
	var_00 thread common_scripts\utility::play_loop_sound_on_entity("npc_firearmdepot_guy_lp");
	var_00 maps\_utility::set_goal_node(var_01[3]);
	wait(7);
	var_05 = randomintrange(0,var_01.size);
	if(var_05 == 0 && var_02 == 2)
	{
		continue;
	}
	else if(var_05 == 2 && var_02 == 0)
	{
		continue;
	}
	else if(var_05 == 1 && var_02 == 3)
	{
		continue;
	}
	else if(var_05 == 3 && var_02 == 1)
	{
		continue;
	}

	if(var_05 != var_02)
	{
		var_00 maps\_utility::set_goal_node(var_01[var_05]);
		var_02 = var_05;
		var_03 = var_04;
		if(var_04 != 0)
		{
			var_04 = 0;
		}
		else
		{
			while(var_04 == var_03)
			{
				var_04 = randomintrange(1,var_01.size);
			}
		}

		switch(var_04)
		{
			case 0:
				break;

			case 1:
				break;

			case 2:
				break;

			case 3:
				break;
		}
	}
}

//Function Number: 92
inventory_guy_setup()
{
	level endon("DespawnGuysHangar1");
	var_00 = getent("inventory_guy","targetname");
	var_00.animname = "generic";
	var_00 maps\_utility::gun_remove();
	var_00 attach("com_clipboard_mocap","tag_inhand");
	var_00 attach("characters_accessories_pencil","tag_weapon_right");
	var_01 = getentarray("inventoryNode","targetname");
	var_02 = randomintrange(0,var_01.size);
	var_03 = var_01[var_02];
	var_03 thread maps\_anim::anim_loop_solo(var_00,"guy_inventory_idle01",undefined,"1stPosDone");
	common_scripts\utility::flag_wait("inventoryNewPos");
	var_03 notify("1stPosDone");
	var_03 maps\_utility::anim_stopanimscripted();
	var_04 = var_02;
	while(var_02 == var_04)
	{
		var_02 = randomintrange(0,var_01.size);
	}

	var_03 = var_01[var_02];
	var_03 thread maps\_anim::anim_loop_solo(var_00,"guy_inventory_idle01",undefined,"2ndPosDone");
}

//Function Number: 93
chair_guy_setup()
{
	var_00 = getent("chair_guy","script_noteworthy");
	var_01 = getent("chair_guy_origin","script_noteworthy");
	var_00.animname = "generic";
	var_00 maps\_utility::gun_remove();
	var_00 teleport(var_01.origin);
	var_00 specify_head_model("head_sp_sas_woodland_colon");
	var_01 thread chair_guy_think(var_00);
}

//Function Number: 94
chair_guy_think(param_00)
{
	var_01 = self;
	var_02 = getent("in_front_of_armory","targetname");
	var_02 thread check_in_front_of_armory();
	var_03 = 0;
	var_04 = getent("chair_guy_origin","script_noteworthy");
	var_05 = maps\_utility::spawn_anim_model("chair",var_04.origin);
	var_04 thread maps\_anim::anim_single_solo(var_05,"chair_counting");
	while(!common_scripts\utility::flag("lootz_intro_start"))
	{
		var_01 maps\_anim::anim_single_solo(param_00,"guy_chair_counting");
	}

	var_04 thread maps\_anim::anim_single_solo(var_05,"chair_turnaround");
	var_01 maps\_anim::anim_single_solo(param_00,"guy_chair_turnaround");
	var_04 thread maps\_anim::anim_single_solo(var_05,"chair_idle");
	for(;;)
	{
		var_06 = "chair_typing";
		if(common_scripts\utility::flag("play_nod_01"))
		{
			var_06 = "chair_nod_01";
			common_scripts\utility::flag_clear("play_nod_01");
		}
		else if(common_scripts\utility::flag("play_nod_02"))
		{
			var_06 = "chair_nod_02";
			common_scripts\utility::flag_clear("play_nod_02");
		}
		else if(var_03 > 4)
		{
			var_07 = randomint(100);
			if(var_07 < 20)
			{
				var_06 = "chair_typing_variation";
			}
			else if(var_07 < 40)
			{
				var_06 = "chair_typing_pause";
			}
		}

		if(var_06 == "chair_typing_variation" || var_06 == "chair_typing_pause")
		{
			var_03 = 0;
		}
		else
		{
			var_03++;
		}

		var_01 maps\_anim::anim_single_solo(param_00,var_06);
	}
}

//Function Number: 95
check_in_front_of_armory()
{
	common_scripts\utility::flag_init("play_nod_01");
	common_scripts\utility::flag_init("play_nod_02");
	self endon("play_nod_02_called");
	var_00 = 0;
	for(;;)
	{
		if(level.player istouching(self))
		{
			if(!var_00)
			{
				common_scripts\utility::flag_set("play_nod_01");
				var_00 = 1;
			}
			else if(common_scripts\utility::flag("aa_sidearm_melee"))
			{
				common_scripts\utility::flag_set("play_nod_02");
				self notify("play_nod_02_called");
			}
		}

		wait(0.1);
	}
}

//Function Number: 96
glowing_rope()
{
	var_00 = getent("glowing_rope","targetname");
	var_00 hide();
	for(;;)
	{
		level waittill("show_glowing_rope");
		var_00 show();
		level waittill("hide_glowing_rope");
		var_00 hide();
	}
}

//Function Number: 97
registeractions()
{
	level.actionbinds = [];
	registeractionbinding("objectives","pause",&"KILLHOUSE_HINT_CHECK_OBJECTIVES_PAUSED");
	registeractionbinding("objectives_pc","+scores",&"KILLHOUSE_HINT_CHECK_OBJECTIVES_SCORES");
	registeractionbinding("pc_attack","+attack",&"KILLHOUSE_HINT_ATTACK_PC");
	registeractionbinding("pc_attack","+attack_akimbo_accessible",&"TRAINER_HINT_HIP_ATTACK_PC");
	registeractionbinding("pc_hip_attack","+attack",&"KILLHOUSE_HINT_HIP_ATTACK_PC");
	registeractionbinding("pc_hip_attack","+attack_akimbo_accessible",&"TRAINER_HINT_HIP_ATTACK_PC");
	registeractionbinding("hip_attack","+attack",&"KILLHOUSE_HINT_HIP_ATTACK");
	registeractionbinding("hip_attack","+attack_akimbo_accessible",&"TRAINER_HINT_HIP_ATTACK_PC");
	registeractionbinding("attack","+attack",&"KILLHOUSE_HINT_ATTACK");
	registeractionbinding("attack","+attack_akimbo_accessible",&"TRAINER_HINT_HIP_ATTACK_PC");
	registeractionbinding("stop_ads","+speed_throw",&"KILLHOUSE_HINT_STOP_ADS_THROW");
	registeractionbinding("stop_ads","+speed",&"KILLHOUSE_HINT_STOP_ADS");
	registeractionbinding("stop_ads","+toggleads_throw",&"KILLHOUSE_HINT_STOP_ADS_TOGGLE_THROW");
	registeractionbinding("stop_ads","toggleads",&"KILLHOUSE_HINT_STOP_ADS_TOGGLE");
	registeractionbinding("ads_360","+speed_throw",&"KILLHOUSE_HINT_ADS_THROW_360");
	registeractionbinding("ads_360","+speed",&"KILLHOUSE_HINT_ADS_360");
	registeractionbinding("ads","+speed_throw",&"KILLHOUSE_HINT_ADS_THROW");
	registeractionbinding("ads","+speed",&"KILLHOUSE_HINT_ADS");
	registeractionbinding("ads","+toggleads_throw",&"KILLHOUSE_HINT_ADS_TOGGLE_THROW");
	registeractionbinding("ads","toggleads",&"KILLHOUSE_HINT_ADS_TOGGLE");
	registeractionbinding("ads_switch","+speed_throw",&"KILLHOUSE_HINT_ADS_SWITCH_THROW");
	registeractionbinding("ads_switch","+speed",&"KILLHOUSE_HINT_ADS_SWITCH");
	registeractionbinding("ads_switch_shoulder","+speed_throw",&"KILLHOUSE_HINT_ADS_SWITCH_THROW_SHOULDER");
	registeractionbinding("ads_switch_shoulder","+speed",&"KILLHOUSE_HINT_ADS_SWITCH_SHOULDER");
	registeractionbinding("breath","+melee_breath",&"KILLHOUSE_HINT_BREATH_MELEE");
	registeractionbinding("breath","+breath_sprint",&"KILLHOUSE_HINT_BREATH_SPRINT");
	registeractionbinding("breath","+holdbreath",&"KILLHOUSE_HINT_BREATH");
	registeractionbinding("melee","+melee",&"KILLHOUSE_HINT_MELEE");
	registeractionbinding("melee","+melee_breath",&"KILLHOUSE_HINT_MELEE");
	registeractionbinding("melee","+melee_zoom",&"KILLHOUSE_HINT_MELEE");
	registeractionbinding("prone","goprone",&"KILLHOUSE_HINT_PRONE");
	registeractionbinding("prone","+stance",&"KILLHOUSE_HINT_PRONE_STANCE");
	registeractionbinding("prone","toggleprone",&"KILLHOUSE_HINT_PRONE_TOGGLE");
	registeractionbinding("prone","+prone",&"KILLHOUSE_HINT_PRONE_HOLD");
	registeractionbinding("prone","lowerstance",&"KILLHOUSE_HINT_PRONE_DOUBLE");
	registeractionbinding("crouch","gocrouch",&"KILLHOUSE_HINT_CROUCH");
	registeractionbinding("crouch","+stance",&"KILLHOUSE_HINT_CROUCH_STANCE");
	if(!level.console)
	{
		registeractionbinding("crouch","+togglecrouch",&"PLATFORM_HINT_CROUCH_TOGGLE_PC");
		registeractionbinding("crouch","+movedown",&"PLATFORM_HINT_HOLD_CROUCH");
	}

	registeractionbinding("crouch","togglecrouch",&"KILLHOUSE_HINT_CROUCH_TOGGLE");
	registeractionbinding("stand","+gostand",&"KILLHOUSE_HINT_STAND");
	registeractionbinding("stand","+stance",&"KILLHOUSE_HINT_STAND_STANCE");
	registeractionbinding("jump","+gostand",&"KILLHOUSE_HINT_JUMP_STAND");
	registeractionbinding("jump","+moveup",&"KILLHOUSE_HINT_JUMP");
	registeractionbinding("sprint","+breath_sprint",&"KILLHOUSE_HINT_SPRINT");
	registeractionbinding("sprint","+sprint",&"KILLHOUSE_HINT_SPRINT");
	registeractionbinding("sprint","+sprint_zoom",&"KILLHOUSE_HINT_SPRINT");
	registeractionbinding("sprint_pc","+breath_sprint",&"KILLHOUSE_HINT_SPRINT_PC");
	registeractionbinding("sprint_pc","+sprint",&"KILLHOUSE_HINT_SPRINT_PC");
	registeractionbinding("sprint_pc","+sprint_zoom",&"KILLHOUSE_HINT_SPRINT_PC");
	registeractionbinding("sprint2","+breath_sprint",&"KILLHOUSE_HINT_HOLDING_SPRINT");
	registeractionbinding("sprint2","+sprint",&"KILLHOUSE_HINT_HOLDING_SPRINT");
	registeractionbinding("sprint2","+sprint_zoom",&"KILLHOUSE_HINT_HOLDING_SPRINT");
	registeractionbinding("reload","+reload",&"KILLHOUSE_HINT_RELOAD");
	registeractionbinding("reload","+usereload",&"KILLHOUSE_HINT_RELOAD_USE");
	registeractionbinding("mantle","+gostand",&"KILLHOUSE_HINT_MANTLE");
	registeractionbinding("sidearm","weapnext",&"KILLHOUSE_HINT_SIDEARM_SWAP");
	registeractionbinding("primary","weapnext",&"KILLHOUSE_HINT_PRIMARY_SWAP");
	registeractionbinding("frag","+frag",&"KILLHOUSE_HINT_FRAG");
	registeractionbinding("flash","+smoke",&"KILLHOUSE_HINT_FLASH");
	registeractionbinding("swap_launcher","+activate",&"KILLHOUSE_HINT_SWAP");
	registeractionbinding("swap_launcher","+usereload",&"KILLHOUSE_HINT_SWAP_RELOAD");
	registeractionbinding("firemode","+actionslot 2",&"KILLHOUSE_HINT_FIREMODE");
	registeractionbinding("attack_launcher","+attack",&"KILLHOUSE_HINT_LAUNCHER_ATTACK");
	registeractionbinding("pc_attack_launcher","+attack",&"KILLHOUSE_HINT_LAUNCHER_ATTACK_PC");
	registeractionbinding("swap_explosives","+activate",&"KILLHOUSE_HINT_EXPLOSIVES");
	registeractionbinding("swap_explosives","+usereload",&"KILLHOUSE_HINT_EXPLOSIVES_RELOAD");
	registeractionbinding("plant_explosives","+activate",&"KILLHOUSE_HINT_EXPLOSIVES_PLANT");
	registeractionbinding("plant_explosives","+usereload",&"KILLHOUSE_HINT_EXPLOSIVES_PLANT");
	registeractionbinding("equip_C4","+actionslot 4",&"KILLHOUSE_HINT_EQUIP_C4");
	registeractionbinding("throw_C4","+toggleads_throw",&"KILLHOUSE_HINT_THROW_C4_TOGGLE");
	registeractionbinding("throw_C4","+speed_throw",&"KILLHOUSE_HINT_THROW_C4_SPEED");
	registeractionbinding("throw_C4","+throw",&"KILLHOUSE_HINT_THROW_C4");
	registeractionbinding("detonate_C4","+attack",&"KILLHOUSE_DETONATE_C4");
	initkeys();
	updatekeysforbindings();
}

//Function Number: 98
registeractionbinding(param_00,param_01,param_02)
{
	if(!isdefined(level.actionbinds[param_00]))
	{
		level.actionbinds[param_00] = [];
	}

	var_03 = spawnstruct();
	var_03.binding = param_01;
	var_03.hint = param_02;
	var_03.keytext = undefined;
	var_03.hinttext = undefined;
	precachestring(param_02);
	level.actionbinds[param_00][level.actionbinds[param_00].size] = var_03;
}

//Function Number: 99
getactionbind(param_00)
{
	for(var_01 = 0;var_01 < level.actionbinds[param_00].size;var_01++)
	{
		var_02 = level.actionbinds[param_00][var_01];
		var_03 = getkeybinding(var_02.binding);
		if(!var_03["count"])
		{
			continue;
		}

		return level.actionbinds[param_00][var_01];
	}

	return level.actionbinds[param_00][0];
}

//Function Number: 100
updatekeysforbindings()
{
	if(level.console)
	{
		setkeyforbinding(getcommandfromkey("BUTTON_START"),"BUTTON_START");
		setkeyforbinding(getcommandfromkey("BUTTON_A"),"BUTTON_A");
		setkeyforbinding(getcommandfromkey("BUTTON_B"),"BUTTON_B");
		setkeyforbinding(getcommandfromkey("BUTTON_X"),"BUTTON_X");
		setkeyforbinding(getcommandfromkey("BUTTON_Y"),"BUTTON_Y");
		setkeyforbinding(getcommandfromkey("BUTTON_LSTICK"),"BUTTON_LSTICK");
		setkeyforbinding(getcommandfromkey("BUTTON_RSTICK"),"BUTTON_RSTICK");
		setkeyforbinding(getcommandfromkey("BUTTON_LSHLDR"),"BUTTON_LSHLDR");
		setkeyforbinding(getcommandfromkey("BUTTON_RSHLDR"),"BUTTON_RSHLDR");
		setkeyforbinding(getcommandfromkey("BUTTON_LTRIG"),"BUTTON_LTRIG");
		setkeyforbinding(getcommandfromkey("BUTTON_RTRIG"),"BUTTON_RTRIG");
		return;
	}

	for(var_00 = 0;var_00 < level.kbkeys.size;var_00++)
	{
		setkeyforbinding(getcommandfromkey(level.kbkeys[var_00]),level.kbkeys[var_00]);
	}

	for(var_00 = 0;var_00 < level.specialkeys.size;var_00++)
	{
		setkeyforbinding(getcommandfromkey(level.specialkeys[var_00]),level.specialkeys[var_00]);
	}
}

//Function Number: 101
getactionforbinding(param_00)
{
	var_01 = getarraykeys(level.actionbinds);
	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		var_03 = level.actionbinds[var_01[var_02]];
		for(var_04 = 0;var_04 < var_03.size;var_04++)
		{
			if(var_03[var_04].binding != param_00)
			{
				continue;
			}

			return var_01[var_02];
		}
	}
}

//Function Number: 102
setkeyforbinding(param_00,param_01)
{
	if(param_00 == "")
	{
		return;
	}

	var_02 = getarraykeys(level.actionbinds);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = level.actionbinds[var_02[var_03]];
		for(var_05 = 0;var_05 < var_04.size;var_05++)
		{
			if(var_04[var_05].binding != param_00)
			{
				continue;
			}

			var_04[var_05].key = param_01;
		}
	}
}

//Function Number: 103
killhouse_hint(param_00,param_01,param_02)
{
	clear_hints();
	level endon("clearing_hints");
	maps\_utility::hint(param_00,undefined,undefined,param_02);
	if(param_00 == &"KILLHOUSE_HINT_LADDER")
	{
		param_01 = 5;
	}

	if(isdefined(param_01))
	{
		wait(param_01);
	}
	else
	{
		return;
	}

	maps\_utility::hint_fade(0.5);
}

//Function Number: 104
clear_hints()
{
	maps\_utility::hint_fade(0);
	if(isdefined(level.iconelem))
	{
		level.iconelem maps\_hud_util::destroyelem();
	}

	if(isdefined(level.iconelem2))
	{
		level.iconelem2 maps\_hud_util::destroyelem();
	}

	if(isdefined(level.iconelem3))
	{
		level.iconelem3 maps\_hud_util::destroyelem();
	}

	level notify("clearing_hints");
}

//Function Number: 105
keyhint(param_00,param_01,param_02)
{
	clear_hints();
	level endon("clearing_hints");
	var_03 = getactionbind(param_00);
	if(param_00 == "melee" && level.xenon && var_03.key == "BUTTON_RSTICK")
	{
		maps\_utility::hint(&"KILLHOUSE_HINT_MELEE_CLICK");
	}
	else
	{
		maps\_utility::hint(var_03.hint,undefined,undefined,param_02);
	}

	var_04 = "did_action_" + param_00;
	for(var_05 = 0;var_05 < level.actionbinds[param_00].size;var_05++)
	{
		var_03 = level.actionbinds[param_00][var_05];
		notifyoncommand(var_04,var_03.binding);
	}

	if(isdefined(param_01))
	{
		level.player thread notifyontimeout(var_04,param_01);
	}

	level.player waittill(var_04);
	maps\_utility::hint_fade(0.5);
}

//Function Number: 106
keyhintmantle(param_00,param_01)
{
	clear_hints();
	level endon("clearing_hints");
	var_02 = getactionbind("mantle");
	maps\_utility::hint(var_02.hint,undefined,undefined,param_01);
	var_03 = 0;
	while(!level.player ismantling() && var_03 < param_00)
	{
		var_03 = var_03 + 0.05;
		wait(0.05);
	}

	maps\_utility::hint_fade(0.5);
}

//Function Number: 107
keyhintprone(param_00,param_01)
{
	clear_hints();
	level endon("clearing_hints");
	var_02 = getactionbind("prone");
	maps\_utility::hint(var_02.hint,undefined,undefined,param_01);
	var_03 = 0;
	while(level.player getstance() != "prone" && var_03 < param_00)
	{
		var_03 = var_03 + 0.05;
		wait(0.05);
	}

	maps\_utility::hint_fade(0.5);
}

//Function Number: 108
second_sprint_hint()
{
	level endon("kill_sprint_hint");
	wait(0.5);
	var_00 = getactionbind("sprint2");
	killhouse_hint(var_00.hint,5);
}

//Function Number: 109
notifyontimeout(param_00,param_01)
{
	self endon(param_00);
	wait(param_01);
	self notify(param_00);
}

//Function Number: 110
training_stalltriggers(param_00,param_01)
{
	var_02 = getentarray(param_00 + "_stall_trigger","script_noteworthy");
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_02[var_03] thread stalltriggerthink(param_00);
	}

	thread wrongstallnag(param_01);
}

//Function Number: 111
wrongstallnag(param_00)
{
	level endon(param_00);
	for(;;)
	{
		level waittill("player_wrong_stall",var_01);
		level.marine2 maps\_anim::anim_single_solo(level.marine2,"gotofour");
		wait(10);
	}
}

//Function Number: 112
stalltriggerthink(param_00)
{
	for(;;)
	{
		self waittill("trigger",var_01);
		if(!isplayer(var_01))
		{
			continue;
		}

		if(self.targetname != "stall4")
		{
			level notify("player_wrong_stall",self.targetname);
			continue;
		}

		common_scripts\utility::flag_set(param_00 + "_player_at_stall");
	}
}

//Function Number: 113
initkeys()
{
	level.kbkeys = "1234567890-=qwertyuiop[]asdfghjkl;\'zxcvbnm,./";
	level.specialkeys = [];
	level.specialkeys[level.specialkeys.size] = "TAB";
	level.specialkeys[level.specialkeys.size] = "ENTER";
	level.specialkeys[level.specialkeys.size] = "ESCAPE";
	level.specialkeys[level.specialkeys.size] = "SPACE";
	level.specialkeys[level.specialkeys.size] = "BACKSPACE";
	level.specialkeys[level.specialkeys.size] = "UPARROW";
	level.specialkeys[level.specialkeys.size] = "DOWNARROW";
	level.specialkeys[level.specialkeys.size] = "LEFTARROW";
	level.specialkeys[level.specialkeys.size] = "RIGHTARROW";
	level.specialkeys[level.specialkeys.size] = "ALT";
	level.specialkeys[level.specialkeys.size] = "CTRL";
	level.specialkeys[level.specialkeys.size] = "SHIFT";
	level.specialkeys[level.specialkeys.size] = "CAPSLOCK";
	level.specialkeys[level.specialkeys.size] = "F1";
	level.specialkeys[level.specialkeys.size] = "F2";
	level.specialkeys[level.specialkeys.size] = "F3";
	level.specialkeys[level.specialkeys.size] = "F4";
	level.specialkeys[level.specialkeys.size] = "F5";
	level.specialkeys[level.specialkeys.size] = "F6";
	level.specialkeys[level.specialkeys.size] = "F7";
	level.specialkeys[level.specialkeys.size] = "F8";
	level.specialkeys[level.specialkeys.size] = "F9";
	level.specialkeys[level.specialkeys.size] = "F10";
	level.specialkeys[level.specialkeys.size] = "F11";
	level.specialkeys[level.specialkeys.size] = "F12";
	level.specialkeys[level.specialkeys.size] = "INS";
	level.specialkeys[level.specialkeys.size] = "DEL";
	level.specialkeys[level.specialkeys.size] = "PGDN";
	level.specialkeys[level.specialkeys.size] = "PGUP";
	level.specialkeys[level.specialkeys.size] = "HOME";
	level.specialkeys[level.specialkeys.size] = "END";
	level.specialkeys[level.specialkeys.size] = "MOUSE1";
	level.specialkeys[level.specialkeys.size] = "MOUSE2";
	level.specialkeys[level.specialkeys.size] = "MOUSE3";
	level.specialkeys[level.specialkeys.size] = "MOUSE4";
	level.specialkeys[level.specialkeys.size] = "MOUSE5";
	level.specialkeys[level.specialkeys.size] = "MWHEELUP";
	level.specialkeys[level.specialkeys.size] = "MWHEELDOWN";
	level.specialkeys[level.specialkeys.size] = "AUX1";
	level.specialkeys[level.specialkeys.size] = "AUX2";
	level.specialkeys[level.specialkeys.size] = "AUX3";
	level.specialkeys[level.specialkeys.size] = "AUX4";
	level.specialkeys[level.specialkeys.size] = "AUX5";
	level.specialkeys[level.specialkeys.size] = "AUX6";
	level.specialkeys[level.specialkeys.size] = "AUX7";
	level.specialkeys[level.specialkeys.size] = "AUX8";
	level.specialkeys[level.specialkeys.size] = "AUX9";
	level.specialkeys[level.specialkeys.size] = "AUX10";
	level.specialkeys[level.specialkeys.size] = "AUX11";
	level.specialkeys[level.specialkeys.size] = "AUX12";
	level.specialkeys[level.specialkeys.size] = "AUX13";
	level.specialkeys[level.specialkeys.size] = "AUX14";
	level.specialkeys[level.specialkeys.size] = "AUX15";
	level.specialkeys[level.specialkeys.size] = "AUX16";
	level.specialkeys[level.specialkeys.size] = "KP_HOME";
	level.specialkeys[level.specialkeys.size] = "KP_UPARROW";
	level.specialkeys[level.specialkeys.size] = "KP_PGUP";
	level.specialkeys[level.specialkeys.size] = "KP_LEFTARROW";
	level.specialkeys[level.specialkeys.size] = "KP_5";
	level.specialkeys[level.specialkeys.size] = "KP_RIGHTARROW";
	level.specialkeys[level.specialkeys.size] = "KP_END";
	level.specialkeys[level.specialkeys.size] = "KP_DOWNARROW";
	level.specialkeys[level.specialkeys.size] = "KP_PGDN";
	level.specialkeys[level.specialkeys.size] = "KP_ENTER";
	level.specialkeys[level.specialkeys.size] = "KP_INS";
	level.specialkeys[level.specialkeys.size] = "KP_DEL";
	level.specialkeys[level.specialkeys.size] = "KP_SLASH";
	level.specialkeys[level.specialkeys.size] = "KP_MINUS";
	level.specialkeys[level.specialkeys.size] = "KP_PLUS";
	level.specialkeys[level.specialkeys.size] = "KP_NUMLOCK";
	level.specialkeys[level.specialkeys.size] = "KP_STAR";
	level.specialkeys[level.specialkeys.size] = "KP_EQUALS";
	level.specialkeys[level.specialkeys.size] = "PAUSE";
	level.specialkeys[level.specialkeys.size] = "SEMICOLON";
	level.specialkeys[level.specialkeys.size] = "COMMAND";
	level.specialkeys[level.specialkeys.size] = "181";
	level.specialkeys[level.specialkeys.size] = "191";
	level.specialkeys[level.specialkeys.size] = "223";
	level.specialkeys[level.specialkeys.size] = "224";
	level.specialkeys[level.specialkeys.size] = "225";
	level.specialkeys[level.specialkeys.size] = "228";
	level.specialkeys[level.specialkeys.size] = "229";
	level.specialkeys[level.specialkeys.size] = "230";
	level.specialkeys[level.specialkeys.size] = "231";
	level.specialkeys[level.specialkeys.size] = "232";
	level.specialkeys[level.specialkeys.size] = "233";
	level.specialkeys[level.specialkeys.size] = "236";
	level.specialkeys[level.specialkeys.size] = "241";
	level.specialkeys[level.specialkeys.size] = "242";
	level.specialkeys[level.specialkeys.size] = "243";
	level.specialkeys[level.specialkeys.size] = "246";
	level.specialkeys[level.specialkeys.size] = "248";
	level.specialkeys[level.specialkeys.size] = "249";
	level.specialkeys[level.specialkeys.size] = "250";
	level.specialkeys[level.specialkeys.size] = "252";
}

//Function Number: 114
turn_off_frag_lights()
{
	var_00 = getentarray("frag_lights","script_noteworthy");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] setlightintensity(0);
	}
}

//Function Number: 115
blink_primary_lights()
{
	var_00 = getentarray("frag_lights","script_noteworthy");
	for(;;)
	{
		wait(1);
		for(var_01 = 0;var_01 < var_00.size;var_01++)
		{
			var_00[var_01] setlightintensity(1);
		}

		wait(1);
		for(var_01 = 0;var_01 < var_00.size;var_01++)
		{
			var_00[var_01] setlightintensity(0);
		}
	}
}

//Function Number: 116
melon_think()
{
	var_00 = getent("scr_watermelon","targetname");
	var_01 = getent(var_00.target,"targetname");
	var_01 hide();
	var_01 notsolid();
	level waittill("show_melon");
	var_01 show();
	var_01 solid();
	var_00 waittill("trigger");
	maps\_cheat::slowmomoderesume();
	var_00 playsound("melee_knife_hit_watermelon");
	common_scripts\utility::flag_set("melee_complete");
	playfx(level._effect["watermelon"],var_01.origin);
	var_01 hide();
	var_01 notsolid();
}

//Function Number: 117
test()
{
	wait(1);
}

//Function Number: 118
clear_hints_on_stand()
{
	while(level.player getstance() != "stand")
	{
		wait(0.05);
	}

	clear_hints();
}

//Function Number: 119
move_mac()
{
	self waittill("trigger");
	level.mac maps\_utility::set_generic_run_anim("jog");
	level.mac getgoalvolume(getnode(self.target,"targetname"));
}

//Function Number: 120
loop_obstacle()
{
	for(var_00 = 0;var_00 < level.buddies.size;var_00++)
	{
		level.mac maps\_utility::set_generic_run_anim("jog");
		level.buddies[var_00] thread obstacletrainingcoursethink(level.buddies[var_00].startnode,level.buddies[var_00].waittime);
	}

	level.mac maps\_utility::set_generic_run_anim("walk",1);
	level.mac getgoalvolume(getnode("mac_start_node","targetname"));
	level.mac waittill("goal");
}

//Function Number: 121
obstacletraining_buddies()
{
	buddiesinit();
	for(var_00 = 0;var_00 < level.buddies.size;var_00++)
	{
		var_01 = level.buddies[var_00];
		var_01.startnode = getnode("obstacle_lane_node" + var_01.buddyid,"targetname");
		level.buddies[var_00] thread obstacletrainingcoursethink(var_01.startnode);
	}
}

//Function Number: 122
buddiesinit()
{
	level.buddies = getentarray("buddy","script_noteworthy");
	level.buddiesbyid = [];
	var_00 = 0;
	if(var_00 < level.buddies.size)
	{
		level.buddies[var_00].buddyid = int(level.buddies[var_00].targetname[5]);
		level.buddiesbyid[level.buddies[var_00].buddyid] = level.buddies[var_00];
		switch(level.buddies[var_00].buddyid)
		{
			case 1:
				break;

			case 2:
				break;

			case 3:
				break;
		}
	}
}

//Function Number: 123
obstacletrainingcoursethink(param_00,param_01)
{
	level endon("obstacleTraining_end");
	self.goalradius = 32;
	if(isdefined(param_01))
	{
		wait(param_01);
	}

	self getgoalvolume(param_00);
	self waittill("goal");
	common_scripts\utility::flag_wait("start_course");
	var_02["prone"] = ::set_allowed_stances_prone;
	var_02["stand"] = ::set_allowed_stances_all;
	var_02["stand_from_prone"] = ::set_allowed_stances_all_from_prone;
	var_02["sprint"] = ::set_sprint;
	var_02["finishNode"] = ::set_idle_after_course;
	self.disablearrivals = 1;
	while(isdefined(param_00.target))
	{
		param_00 = getnode(param_00.target,"targetname");
		self getgoalvolume(param_00);
		self waittill("goal");
		if(!isdefined(param_00.script_noteworthy))
		{
			continue;
		}

		[[ var_02[param_00.script_noteworthy] ]]();
	}

	self.disablearrivals = 0;
}

//Function Number: 124
set_allowed_stances_prone()
{
	self allowedstances("prone");
}

//Function Number: 125
set_allowed_stances_all()
{
	self allowedstances("prone","stand","crouch");
}

//Function Number: 126
set_allowed_stances_all_from_prone()
{
	self allowedstances("prone","stand","crouch");
	maps\_anim::anim_generic(self,"prone_to_stand");
	self.standing = 1;
}

//Function Number: 127
set_sprint()
{
	self.sprint = 1;
}

//Function Number: 128
set_idle_after_course()
{
	self.goalradius = 100;
	self notify("goal");
	maps\_utility::set_goal_pos(self.origin);
}

//Function Number: 129
frag_trigger_think(param_00,param_01,param_02)
{
	common_scripts\utility::flag_init(param_00);
	param_01 enablegrenadetouchdamage();
	if(isdefined(param_01.target))
	{
		param_01.light = getent(param_01.target,"targetname");
	}

	if(isdefined(param_01.light))
	{
		param_01.light thread flicker_on();
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	for(;;)
	{
		param_01 waittill("trigger");
		if(!common_scripts\utility::flag("in_safety_pit"))
		{
			continue;
		}

		common_scripts\utility::flag_set(param_00);
		level.player playsound("killhouse_buzzer");
		if(isdefined(param_01.light))
		{
			param_01.light thread flicker_off();
		}

		return param_01;
	}
}

//Function Number: 130
light_off()
{
	self setlightintensity(0);
}

//Function Number: 131
light_on()
{
	self setlightintensity(1);
}

//Function Number: 132
flicker_off()
{
	wait(randomfloatrange(0.2,0.5));
	self setlightintensity(0);
	wait(randomfloatrange(0.05,0.1));
	self setlightintensity(0.7);
	wait(randomfloatrange(0.1,0.2));
	self setlightintensity(0);
	wait(randomfloatrange(0.05,0.4));
	self setlightintensity(0.5);
	wait(randomfloatrange(0.1,0.5));
	self setlightintensity(0);
}

//Function Number: 133
flicker_on()
{
	wait(randomfloatrange(0.2,0.5));
	self setlightintensity(0.4);
	wait(randomfloatrange(0.2,0.4));
	self setlightintensity(0);
	wait(randomfloatrange(0.2,0.5));
	self setlightintensity(0.6);
	wait(randomfloatrange(0.05,0.2));
	self setlightintensity(0);
	wait(randomfloatrange(0.05,0.1));
	self setlightintensity(1);
}

//Function Number: 134
in_pit()
{
	var_00 = getent("safety_pit","targetname");
	if(!level.player istouching(var_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 135
frag_too_low_hint()
{
	level endon("fragTraining_end");
	self enablegrenadetouchdamage();
	for(;;)
	{
		self waittill("trigger");
		clear_hints();
		level.currentkeyhintactionname = "";
		killhouse_hint(&"KILLHOUSE_HINT_GRENADE_TOO_LOW",6);
	}
}

//Function Number: 136
walk_to(param_00)
{
	maps\_utility::set_generic_run_anim("patrol_unarmed_walk");
	self.animplaybackrate = 1.25;
	self.goalradius = 16;
	self getgoalvolume(param_00);
	self waittill("goal");
	self.animplaybackrate = 1;
}

//Function Number: 137
jog_to(param_00)
{
	level.newcastle setlookatentity();
	maps\_utility::set_generic_run_anim("RunNoGun_1");
	self.goalradius = 16;
	self getgoalvolume(param_00);
	self waittill("goal");
	level.newcastle setlookatentity(level.player,1);
}

//Function Number: 138
walk_to_debrief(param_00)
{
	level.mocaporiginhangar3 notify("end_idle");
	var_01 = [];
	var_01[0] = level.sas_blackkits[0];
	var_01[1] = level.sas_blackkits[1];
	var_01[2] = level.sas_blackkits[2];
	var_01[3] = level.price;
	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_01[var_02] maps\_utility::set_generic_run_anim("jog",1);
		var_01[var_02] maps\_utility::ai_ignore_everything();
		var_01[var_02] maps\_utility::anim_stopanimscripted();
		param_00 thread maps\_anim::anim_reach_and_idle_solo(var_01[var_02],"debrief_idle_s" + var_02 + 1 + "_b","debrief_idle_s" + var_02 + 1 + "_b","stop_loop");
		wait(1);
	}

	if(common_scripts\utility::flag("price_reveal_done"))
	{
		price_mask_up_gun_spawn();
	}
}

//Function Number: 139
price_mask_up_gun_spawn()
{
	level.price setanimlimited(level.scr_anim["price"]["price_mask_up"],1);
	level.price setanimlimited(level.scr_anim["price"]["price_mask_outloop"],1);
	level.price animscripts\shared::placeweaponon(level.price.weapon,"right");
}

//Function Number: 140
dialog_nag_till_in_pit()
{
	level endon("in_pit_nag_finish");
	for(;;)
	{
		while(!common_scripts\utility::flag("in_pit_with_frags") && common_scripts\utility::flag("in_explosives_area"))
		{
			level.newcastle execdialog("getinsafety");
			wait(9);
		}

		wait(1);
	}
}

//Function Number: 141
pause_anim()
{
	self setflaggedanim("single anim",maps\_utility::getanim("reveal"),1,0,0);
}

//Function Number: 142
unpause_anim()
{
	self setflaggedanim("single anim",maps\_utility::getanim("reveal"),1,0,1);
}

//Function Number: 143
m203_icon_hint()
{
	clear_hints();
	level waittill("clearing_hints");
	wait(0.7);
	maps\_utility::hint_fade(0.5);
}

//Function Number: 144
c4_icon_hint()
{
	clear_hints();
	level endon("clearing_hints");
	level waittill("c4_equiped");
	level.currentkeyhintactionname = "";
	wait(0.85);
	maps\_utility::hint_fade(0.5);
}

//Function Number: 145
auto_aim()
{
	if(level.console)
	{
		if(isdefined(getdvar("input_autoaim")))
		{
			if(getdvar("input_autoaim") == "1")
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 146
is_ps3_flipped()
{
	var_00 = 0;
	var_01 = getdvar("gpad_buttonsConfig");
	if(isdefined(var_01))
	{
		if(issubstr(var_01,"_alt"))
		{
			var_00 = 1;
		}
	}

	return var_00;
}

//Function Number: 147
gaz_animation(param_00,param_01,param_02,param_03)
{
	level.waters setlookatentity();
	if(isdefined(param_01))
	{
		wait(param_01);
	}

	if(!common_scripts\utility::flag("gaz_in_idle_position"))
	{
		return;
	}

	level.waters notify("gaz_animation");
	level.waters endon("gaz_animation");
	level.waters.ref_node notify("stop_loop");
	level.waters stopanimscripted();
	level.waters.ref_node maps\_anim::anim_single_solo(level.waters,param_00);
	if(isdefined(param_02))
	{
		if(param_03 == 1)
		{
			level.waters.ref_node notify("stop_loop");
			level.waters.ref_node thread maps\_anim::anim_loop_solo(level.waters,param_02,undefined,"stop_loop");
			return;
		}
		else
		{
			level.waters.ref_node maps\_anim::anim_single_solo(level.waters,param_02);
		}
	}

	level.waters.ref_node notify("stop_loop");
	level.waters.ref_node thread maps\_anim::anim_loop_solo(level.waters,"killhouse_gaz_idleB",undefined,"stop_loop");
	level.waters setlookatentity(level.player,1);
}

//Function Number: 148
nwc_talk_animation(param_00)
{
	execdialog(param_00);
}

//Function Number: 149
melontargetdummies()
{
	var_00 = getentarray("rifle_target_dummy","script_noteworthy");
	var_01 = getentarray("aim_target","targetname");
	var_02 = getentarray("aim_target_right","targetname");
	var_03 = getentarray("cargoship_target","script_noteworthy");
	var_04 = common_scripts\utility::array_combine(var_00,var_01);
	var_04 = common_scripts\utility::array_combine(var_04,var_02);
	var_04 = common_scripts\utility::array_combine(var_04,var_03);
	foreach(var_06 in var_04)
	{
		var_06 thread melonhead_monitor_targetdummy();
	}
}

//Function Number: 150
melonhead_infinite_melons()
{
	self endon("melonhead_infinite_disabled");
	for(;;)
	{
		self waittill("want_newMelon");
		if(!level.melonhead_mode_enabled)
		{
			self notify("melonhead_infinite_disabled");
		}

		maps\_cheat::melonhead_add_melon();
	}
}

//Function Number: 151
melonhead_monitor_targetdummy()
{
	self notify("melonhead_monitor");
	self endon("melonhead_monitor");
	wait 0.05;
	if(isdefined(self.melonhead_ignore) && self.melonhead_ignore)
	{
		return;
	}

	for(;;)
	{
		if(level.melonhead_mode_enabled)
		{
			maps\_cheat::melonhead_add_melon();
			thread melonhead_infinite_melons();
		}
		else
		{
			maps\_cheat::melonhead_remove_melon();
			self notify("melonhead_infinite_disabled");
		}

		level waittill("melonhead_mode_updated");
	}
}

//Function Number: 152
specify_head_model(param_00)
{
	self detach(self.headmodel);
	self attach(param_00,"",1);
	self.headmodel = param_00;
}