/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: irons_estate_penthouse.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 523 ms
 * Timestamp: 4/22/2024 2:32:05 AM
*******************************************************************/

//Function Number: 1
penthouse_start()
{
	level.start_point_scripted = "meet_cormack";
	maps\irons_estate::irons_estate_objectives();
	maps\irons_estate_code::spawn_player_checkpoint();
	maps\irons_estate_code::spawn_allies();
	thread maps\irons_estate_infil::poolhouse_enemies();
	thread ie_west_enemies();
	thread guesthouse_enemies();
	thread maps\irons_estate_civilians::ie_west_civilian_vignettes();
	thread maps\irons_estate_code::tennis_court_floor(1);
	thread maps\irons_estate_code::player_kill_trigger("waterfall_top_kill_trigger");
	thread maps\irons_estate_security_center::security_center_fan_blades();
	soundscripts\_snd::snd_message("start_penthouse");
	common_scripts\utility::flag_set("player_in_estate");
}

//Function Number: 2
penthouse_main()
{
	level.start_point_scripted = "meet_cormack";
	thread penthouse_begin();
	common_scripts\utility::flag_wait("penthouse_end");
	maps\_utility::autosave_stealth();
}

//Function Number: 3
penthouse_begin()
{
	common_scripts\utility::flag_set("penthouse_start");
	level.player.grapple["dist_max"] = 800;
	thread maps\irons_estate_code::handle_player_abandoned_mission("iln");
	thread penthouse_vo();
	thread penthouse_objective();
	thread maps\irons_estate_code::irons_estate_trigger_saves("penthouse_end","player_enters_front_yard_save_1");
	thread maps\irons_estate_code::irons_estate_trigger_saves("penthouse_end","player_enters_front_yard_save_2");
	thread maps\irons_estate_code::irons_estate_trigger_saves("penthouse_end","player_enters_front_yard_save_2a");
	thread maps\irons_estate_code::irons_estate_trigger_saves("penthouse_end","player_enters_front_yard_save_3");
	thread maps\irons_estate_code::irons_estate_trigger_saves("penthouse_end","player_enters_front_yard_save_4");
	thread maps\irons_estate_code::irons_estate_trigger_saves("penthouse_end","player_enters_front_yard_save_5");
	thread maps\irons_estate_code::generic_enemy_vo_chatter("player_entered_balcony_door");
	thread ilona_generic_update_vo();
	thread tennis_court();
	common_scripts\utility::flag_wait("player_enters_front_yard_save_1");
	thread vtol_flyover();
	common_scripts\utility::flag_wait("player_enters_front_yard_save_4");
	maps\_utility::delaythread(4,::maps\irons_estate_code::corpse_cleanup);
}

//Function Number: 4
vtol_flyover()
{
	var_00 = common_scripts\utility::getstruct("vtol_struct","targetname");
	var_01 = maps\_utility::spawn_anim_model("vtol",(0,0,0));
	var_01.grapple_magnets = [];
	soundscripts\_snd::snd_message("aud_vtol_land",var_01);
	var_01 thread vtol_fx_land();
	var_00 thread maps\_anim::anim_single_solo(var_01,"cormack_stealth_takedown");
	var_01 waittillmatch("end","single anim");
	var_01 delete();
}

//Function Number: 5
vtol_fx_land()
{
	playfxontag(level._effect["ie_vtol_wtip_light_red_blink"],self,"TAG_LT_WING_LIGHT_FX");
	playfxontag(level._effect["ie_vtol_wtip_light_red_blink"],self,"TAG_RT_WING_LIGHT_FX");
	playfxontag(level._effect["ie_vtol_wtip_light_red_blink"],self,"TAG_LT_WING_LIGHT_FX");
	playfxontag(level._effect["ie_vtol_wtip_light_red_blink"],self,"TAG_RT_WING_LIGHT_FX");
	wait(0.05);
	playfxontag(level._effect["ie_vtol_wtip_light_tail_red"],self,"tag_light_L_wing");
	playfxontag(level._effect["ie_vtol_wtip_light_tail_red"],self,"tag_light_R_wing");
	playfxontag(level._effect["ie_vtol_wtip_light_tail_red"],self,"tag_light_L_tail");
	playfxontag(level._effect["ie_vtol_wtip_light_tail_red"],self,"tag_light_R_tail");
	wait(0.05);
	playfxontag(level._effect["vtol_exhaust_l"],self,"TAG_LT_WING_EXHAUSE_FX");
	playfxontag(level._effect["vtol_exhaust_r"],self,"TAG_RT_WING_EXHAUSE_FX");
	wait(10);
	playfxontag(level._effect["vtol_engine_land"],self,"TAG_FX_ENGINE_RI_1");
	playfxontag(level._effect["vtol_engine_land"],self,"TAG_FX_ENGINE_RI_2");
	playfxontag(level._effect["vtol_engine_land"],self,"TAG_FX_ENGINE_RI_3");
	playfxontag(level._effect["vtol_engine_land"],self,"TAG_FX_ENGINE_RI_4");
	wait(0.05);
	playfxontag(level._effect["vtol_engine_land"],self,"TAG_FX_ENGINE_LE_1");
	playfxontag(level._effect["vtol_engine_land"],self,"TAG_FX_ENGINE_LE_2");
	playfxontag(level._effect["vtol_engine_land"],self,"TAG_FX_ENGINE_LE_3");
	playfxontag(level._effect["vtol_engine_land"],self,"TAG_FX_ENGINE_LE_4");
}

//Function Number: 6
penthouse_vo()
{
	wait(1);
	maps\_utility::smart_radio_dialogue("ie_crmk_regroup");
	wait(0.5);
	maps\_utility::smart_radio_dialogue("ie_iln_movingposition");
	wait(0.5);
	level.play_ally_warning_vo = 1;
	level.play_ally_callout_vo = 1;
	thread maps\irons_estate_code::enemy_callout_vo("iln");
	thread maps\irons_estate_code::drone_incoming_vo("iln");
	thread maps\irons_estate_code::clean_kill_vo("iln");
	maps\irons_estate_code::enemy_alert_vo_setup("iln");
	thread maps\irons_estate_code::failed_vo("iln");
	thread maps\irons_estate_code::dont_shoot_warning_vo("iln");
	thread maps\irons_estate_code::exposed_group_logic();
	common_scripts\utility::flag_wait("overlook_obj_trigger");
	level.play_ally_warning_vo = undefined;
	level.play_ally_callout_vo = undefined;
	level.ally_vo_org stopsounds();
	wait(0.05);
	maps\_utility::smart_radio_dialogue("ie_iln_inposition");
	level.play_ally_warning_vo = 1;
	level.play_ally_callout_vo = 1;
	thread pre_guesthouse_vo();
	thread guest_house_vo();
	common_scripts\utility::flag_wait("penthouse_end_ready");
	level.ally_vo_org stopsounds();
	wait(0.05);
	var_00 = [];
	var_00[0] = spawnstruct();
	var_00[0].vo = "ie_iln_driveway";
	var_00[0].vo_priority = 7;
	var_00[1] = spawnstruct();
	var_00[1].vo = "ie_iln_onbalcony";
	var_00[1].vo_priority = 7;
	wait(1);
	maps\irons_estate_code::ally_vo_controller(var_00[0]);
	wait(0.5);
	maps\irons_estate_code::ally_vo_controller(var_00[1]);
}

//Function Number: 7
pre_guesthouse_vo()
{
	level endon("guesthouse_balcony_enemy_1_dead");
	level endon("guesthouse_balcony_enemy_2_dead");
	level endon("player_enters_front_yard_save_4");
	common_scripts\utility::flag_wait("two_on_balcony_vo");
	if(common_scripts\utility::flag("_stealth_spotted"))
	{
		return;
	}

	level.play_ally_warning_vo = undefined;
	level.play_ally_callout_vo = undefined;
	level.ally_vo_org stopsounds();
	wait(0.05);
	maps\_utility::smart_radio_dialogue("ie_iln_shadows");
	level.play_ally_warning_vo = 1;
	level.play_ally_callout_vo = 1;
}

//Function Number: 8
guest_house_vo()
{
	level endon("player_enters_front_yard_save_4");
	common_scripts\utility::flag_wait("spawn_civilian_guesthouse_walkin");
	wait(1);
	if(common_scripts\utility::flag("_stealth_spotted"))
	{
		return;
	}

	var_00 = [];
	var_00[0] = spawnstruct();
	var_00[0].vo = "ie_iln_raftersquick";
	var_00[0].vo_priority = 4;
	var_00[1] = spawnstruct();
	var_00[1].vo = "ie_iln_clear4";
	var_00[1].vo_priority = 4;
	thread maps\irons_estate_code::ally_vo_controller(var_00[0]);
	common_scripts\utility::flag_wait("guesthouse_walkin_all_clear");
	if(common_scripts\utility::flag("_stealth_spotted"))
	{
		return;
	}

	if(!maps\irons_estate_code::check_player_in_stop_enemy_callout_vo_volume())
	{
		thread maps\irons_estate_code::ally_vo_controller(var_00[1]);
	}
}

//Function Number: 9
penthouse_objective()
{
	wait(2);
	objective_add(maps\_utility::obj("penthouse"),"current",&"IRONS_ESTATE_OBJ_PENTHOUSE");
	var_00 = common_scripts\utility::getstruct("overlook_obj","targetname");
	objective_position(maps\_utility::obj("penthouse"),var_00.origin);
	common_scripts\utility::flag_wait("overlook_obj_trigger");
	maps\_utility::autosave_stealth();
	var_01 = common_scripts\utility::getstruct("penthouse_obj_org","targetname");
	objective_position(maps\_utility::obj("penthouse"),var_01.origin);
	common_scripts\utility::flag_wait("penthouse_end_ready");
	var_02 = common_scripts\utility::getstruct("penthouse_balcony_obj","targetname");
	objective_position(maps\_utility::obj("penthouse"),var_02.origin);
	common_scripts\utility::flag_wait("penthouse_end");
	var_03 = common_scripts\utility::getstruct("penthouse_balcony_interior_obj","targetname");
	objective_position(maps\_utility::obj("penthouse"),var_03.origin);
}

//Function Number: 10
ilona_generic_update_vo()
{
	common_scripts\utility::flag_wait("player_enters_front_yard_save_3");
	if(common_scripts\utility::flag("_stealth_spotted") || common_scripts\utility::flag("someone_became_alert"))
	{
		return;
	}

	var_00 = [];
	var_00[0] = spawnstruct();
	var_00[0].vo = "ie_iln_sofarsogood";
	var_00[0].vo_priority = 4;
	maps\irons_estate_code::ally_vo_controller(var_00[0]);
	wait(1);
	maps\_utility::deletestruct_ref(var_00[0]);
}

//Function Number: 11
tennis_court()
{
	level endon("bedroom_end");
	common_scripts\utility::flag_init("tennis_court_clear");
	common_scripts\utility::flag_wait("tennis_court_activated");
	level.tennis_court_trigger = getent("tennis_court_trigger","targetname");
	level.tennis_court_trigger common_scripts\utility::trigger_off();
	soundscripts\_snd::snd_message("aud_tennis_court_wakeup");
	wait(0.5);
	level.tennis_court_origin = getent("tennis_court_origin","targetname");
	thread maps\irons_estate_lighting::tennis_court_lights_intial();
	thread tennis_court_player_brackets();
	thread tennis_court_ball_launcher();
	thread maps\irons_estate_code::tennis_court_floor();
	common_scripts\_exploder::exploder(747);
	wait(2);
	thread tennis_court_nags();
	start_tennis_court_alert();
	common_scripts\utility::flag_wait("player_entered_balcony_door");
	maps\_utility::stop_exploder(747);
}

//Function Number: 12
tennis_court_player_brackets()
{
	level endon("bedroom_end");
	var_00 = getent("tennis_court_playing_area","targetname");
	var_01 = common_scripts\utility::getstruct("tennis_court_floor_struct","targetname");
	for(;;)
	{
		var_00 waittill("trigger");
		var_02 = getaiarray("axis");
		var_02 = common_scripts\utility::array_add(var_02,level.player);
		var_03 = var_00 getistouchingentities(var_02);
		if(isdefined(var_03) && var_03.size > 0)
		{
			foreach(var_05 in var_03)
			{
				if(!isdefined(var_05.has_bracket))
				{
					if(var_05 == level.player)
					{
						var_05 thread tennis_court_player_brackets_internal(var_00,var_01,"ie_tennis_ring");
						continue;
					}

					if(isdefined(var_05.classname) && var_05.classname == "actor_enemy_atlas_bodyguard_smg" || var_05.classname == "actor_enemy_atlas_pmc_estate_smg")
					{
						var_05 thread tennis_court_player_brackets_internal(var_00,var_01,"ie_tennis_ring_inv");
					}
				}
			}
		}

		wait 0.05;
	}
}

//Function Number: 13
tennis_court_player_brackets_internal(param_00,param_01,param_02)
{
	level endon("player_entered_balcony_door");
	var_03 = common_scripts\utility::spawn_tag_origin();
	var_03.origin = (self.origin[0],self.origin[1],param_01.origin[2] + 0.1);
	var_03.angles = var_03.angles + (-90,0,0);
	wait 0.05;
	playfxontag(level._effect[param_02],var_03,"tag_origin");
	self.has_bracket = 1;
	while(self istouching(param_00) && isalive(self))
	{
		var_03.angles = (var_03.angles[0],self.angles[1],var_03.angles[2]);
		var_03.origin = (self.origin[0],self.origin[1],param_01.origin[2] + 0.1);
		wait 0.05;
	}

	stopfxontag(level._effect[param_02],var_03,"tag_origin");
	var_03 delete();
	wait(1);
	self.has_bracket = undefined;
}

//Function Number: 14
tennis_court_ball_launcher()
{
	var_00 = getent("tennis_ball_launcher","targetname");
	var_01 = getent("tennis_ball_launcher_clip","targetname");
	var_02 = getentarray("tennis_ball","targetname");
	var_03 = getent("tennis_ball_launcher_anim_origin","targetname");
	var_04 = var_00 gettagorigin("tag_origin");
	var_05 = common_scripts\utility::spawn_tag_origin();
	var_05.origin = var_04;
	var_00 linkto(var_05,"tag_origin");
	var_01 linkto(var_05,"tag_origin");
	foreach(var_07 in var_02)
	{
		var_07 linkto(var_05,"tag_origin");
	}

	var_03 linkto(var_05,"tag_origin");
	var_09 = getent("tennis_ball_launcher_anim_origin_temp","targetname");
	var_09 linkto(var_05,"tag_origin");
	var_05 thread tennis_court_ball_launcher_logic(var_09);
	common_scripts\utility::flag_wait("bedroom_end");
	var_00 delete();
	var_01 delete();
	foreach(var_07 in var_02)
	{
		var_07 delete();
	}

	var_03 delete();
	var_09 delete();
	var_05 delete();
}

//Function Number: 15
tennis_court_ball_launcher_logic(param_00)
{
	level endon("bedroom_end");
	var_01 = [];
	var_01[0] = "ie_cv_serving";
	level.audio_org = level.tennis_court_origin common_scripts\utility::spawn_tag_origin();
	for(;;)
	{
		wait 0.05;
		common_scripts\utility::flag_clear("tennis_court_activated");
		var_02 = 0;
		wait(0.5);
		play_tennis_court_vo("ie_cv_starting");
		wait(1.5);
		play_tennis_court_vo("ie_cv_lovelove");
		for(;;)
		{
			if(common_scripts\utility::flag("player_playing_tennis"))
			{
				var_03 = vectortoangles(level.player.origin - self.origin);
				var_04 = var_03[1];
				var_05 = var_04 - self.angles[1];
				if(var_05 > 0)
				{
					var_05 = var_05 - 180;
				}
				else
				{
					var_05 = var_05 + 180;
				}
			}
			else
			{
				var_05 = 180 - self.angles[1];
				if(var_05 > 0)
				{
					var_05 = var_05 - 180;
				}
				else
				{
					var_05 = var_05 + 180;
				}

				var_05 = var_05 + randomintrange(-10,10);
			}

			self rotateyaw(var_05,0.3,0,0);
			wait(0.3);
			play_tennis_court_vo("ie_cv_serving");
			var_06 = spawn("script_model",param_00.origin);
			var_06 setmodel("base_tennis_ball_01");
			var_07 = anglestoforward(param_00.angles);
			var_06 physicslaunchclient(var_06.origin,var_07 * 850);
			soundscripts\_snd_playsound::snd_play_at("irons_tennis_ball_launch",(-2664,-4892,444));
			var_06 thread tennis_court_ball_cleanup();
			wait(2);
			var_02++;
			if(var_02 == 1)
			{
				play_tennis_court_vo("ie_cv_15");
				play_tennis_court_vo("ie_cv_love");
			}

			if(var_02 == 2)
			{
				play_tennis_court_vo("ie_cv_30");
				play_tennis_court_vo("ie_cv_love");
			}

			if(var_02 == 3)
			{
				play_tennis_court_vo("ie_cv_40");
				play_tennis_court_vo("ie_cv_love");
			}

			if(var_02 == 4)
			{
				level.audio_org playsound("ie_cv_pausing");
				break;
			}

			wait 0.05;
		}

		thread maps\irons_estate_lighting::tennis_court_lights_dimmed();
		thread enemies_in_tennis_court();
		common_scripts\utility::flag_wait("tennis_court_clear");
		wait(8);
		level.tennis_court_trigger common_scripts\utility::trigger_on();
		common_scripts\utility::flag_wait("tennis_court_activated");
		level.tennis_court_trigger common_scripts\utility::trigger_off();
		thread maps\irons_estate_lighting::tennis_court_lights_on();
	}
}

//Function Number: 16
play_tennis_court_vo(param_00)
{
	level.tennis_court_computer_talking = 1;
	level.audio_org playsound(param_00,"sounddone");
	level.audio_org tennis_court_computer_line_done();
	level.tennis_court_computer_talking = undefined;
}

//Function Number: 17
touchtest()
{
	self endon("tennis_ball_delete");
	var_00 = common_scripts\utility::getstruct("tennis_court_floor_struct","targetname");
	var_01 = getent("tennis_court_floor_volume","targetname");
	for(;;)
	{
		if(self istouching(var_01))
		{
			if(!isdefined(self.ball_touching_ground))
			{
				self.ball_touching_ground = 1;
				iprintlnbold("Yes");
			}
		}
		else if(isdefined(self.ball_touching_ground))
		{
			self.ball_touching_ground = undefined;
			iprintlnbold("No");
		}

		wait 0.05;
	}
}

//Function Number: 18
tennis_court_ball_cleanup()
{
	common_scripts\utility::flag_wait_either("tennis_court_activated","bedroom_end");
	if(isdefined(self))
	{
		self notify("tennis_ball_delete");
		self delete();
	}
}

//Function Number: 19
tennis_court_computer_line_done()
{
	self waittill("sounddone");
}

//Function Number: 20
tennis_court_nags()
{
	common_scripts\utility::flag_wait("tennis_court_clear");
	level endon("_stealth_spotted");
	level endon("bedroom_end");
	var_00 = [];
	var_00[0] = spawnstruct();
	var_00[0].vo = "ie_iln_quitplaying";
	var_00[0].vo_priority = 4;
	var_00[1] = spawnstruct();
	var_00[1].vo = "ie_iln_serious";
	var_00[1].vo_priority = 4;
	common_scripts\utility::flag_wait("tennis_court_activated");
	wait(2);
	var_01 = getent("player_touching_tennis_court_floor_volume","targetname");
	if(level.player istouching(var_01))
	{
		thread maps\irons_estate_code::ally_vo_controller(var_00[0]);
	}

	common_scripts\utility::flag_wait("tennis_court_activated");
	wait(2);
	if(level.player istouching(var_01))
	{
		thread maps\irons_estate_code::ally_vo_controller(var_00[1]);
	}
}

//Function Number: 21
start_tennis_court_alert(param_00)
{
	if(!common_scripts\utility::flag("_stealth_spotted"))
	{
		level.play_ally_warning_vo = undefined;
		level.play_ally_callout_vo = undefined;
		level.ally_vo_org stopsounds();
		wait(0.05);
		maps\_utility::smart_radio_dialogue("ie_iln_tangoscoming");
		level.play_ally_warning_vo = 1;
		level.play_ally_callout_vo = 1;
		wait(0.25);
		var_01 = getaiarray("axis");
		var_02 = common_scripts\utility::get_array_of_closest(level.tennis_court_origin.origin,var_01,undefined,undefined,1024,undefined);
		if(isdefined(var_02))
		{
			foreach(var_04 in var_02)
			{
				wait(0.5);
				if(!isdefined(level.tennis_court_alert_vo))
				{
					level.tennis_court_alert_vo = 1;
					var_04.animname = "generic";
					var_04 maps\_utility::smart_dialogue("ie_as1_whatsthat5");
				}

				if(!common_scripts\utility::flag("_stealth_spotted") && isalive(var_04) && isdefined(var_04._stealth))
				{
					var_04 notify("reaction_generic",level.tennis_court_origin.origin);
					var_05 = maps\_stealth_shared_utilities::group_get_ai_in_group(var_04.script_stealthgroup);
					if(isdefined(var_05))
					{
						foreach(var_07 in var_05)
						{
							if(var_07 == self)
							{
								continue;
							}

							if(isdefined(var_07.enemy) || isdefined(var_07.favoriteenemy))
							{
								continue;
							}

							var_07 thread maps\irons_estate_code::notify_delay_param("reaction_generic",randomfloatrange(0.1,0.5),level.tennis_court_origin.origin);
						}

						break;
					}
				}
			}
		}
	}
}

//Function Number: 22
enemies_in_tennis_court()
{
	var_00 = getent("player_touching_tennis_court_floor_volume","targetname");
	for(;;)
	{
		var_01 = var_00 maps\_utility::get_ai_touching_volume("axis");
		if(var_01.size == 0)
		{
			break;
		}

		wait(0.5);
	}

	common_scripts\utility::flag_set("tennis_court_clear");
}

//Function Number: 23
ie_west_enemies()
{
	if(level.start_point_scripted == "hack_security")
	{
		if(common_scripts\utility::flag("security_center_guard_right"))
		{
			maps\_utility::array_spawn_function_targetname("security_center_guard_right_spawner",::maps\irons_estate_infil::security_center_guard_spawner_setup);
			var_00 = maps\_utility::array_spawn_targetname("security_center_guard_right_spawner",1);
		}

		if(common_scripts\utility::flag("security_center_guard_left"))
		{
			maps\_utility::array_spawn_function_targetname("security_center_guard_left_spawner",::maps\irons_estate_infil::security_center_guard_spawner_setup);
			var_01 = maps\_utility::array_spawn_targetname("security_center_guard_left_spawner",1);
		}
	}

	maps\_utility::array_spawn_function_targetname("ie_west_spawner",::ie_west_spawner_setup);
	var_02 = maps\_utility::array_spawn_targetname("ie_west_spawner",1);
	thread ie_west_drones();
	thread maps\irons_estate_car_alarm::car_alarm_main("ie_west_driveway_car","player_entered_balcony_door");
	if(level.start_point_scripted == "hack_security")
	{
		common_scripts\utility::flag_wait("spawn_garage_civilians");
		wait(1);
	}

	maps\_utility::array_spawn_function_targetname("ie_west_spawner_2",::ie_west_spawner_setup);
	var_03 = maps\_utility::array_spawn_targetname("ie_west_spawner_2",1);
}

//Function Number: 24
alcove_clips()
{
	level endon("player_entered_balcony_door");
	common_scripts\utility::flag_wait("start_car_lift_scene");
	if(!common_scripts\utility::flag("_stealth_spotted"))
	{
		common_scripts\utility::flag_wait("_stealth_spotted");
	}

	var_00 = getent("garage_alcove_clip","targetname");
	var_00 notsolid();
}

//Function Number: 25
garage_balcony_enemy()
{
	level endon("player_entered_balcony_door");
	common_scripts\utility::flag_wait_either("spawn_garage_balcony_spawner","do_not_spawn_garage_balcony_spawner");
	if(common_scripts\utility::flag("_stealth_spotted") || common_scripts\utility::flag("do_not_spawn_garage_balcony_spawner"))
	{
		return;
	}

	maps\_utility::array_spawn_function_targetname("ie_west_garage_balcony_spawner",::garage_balcony_spawner_setup);
	var_00 = maps\_utility::array_spawn_targetname("ie_west_garage_balcony_spawner",1);
	thread garage_balcony_door();
	thread garage_balcony_vo();
}

//Function Number: 26
garage_balcony_spawner_setup()
{
	self endon("death");
	common_scripts\utility::flag_wait("player_entered_balcony_door");
	self delete();
}

//Function Number: 27
garage_balcony_door()
{
	var_00 = getent("garage_balcony_door","targetname");
	var_01 = getent("garage_balcony_door_clip","targetname");
	var_01 linkto(var_00,"door_single_01_lod0");
	var_00 rotateyaw(90,1);
	var_02 = getent("garage_balcony_door_light","targetname");
	var_02 setlightintensity(15000);
	var_01 connectpaths();
	common_scripts\utility::flag_wait_or_timeout("garage_balcony_door_close",5);
	var_00 rotateyaw(-90,1);
	var_01 disconnectpaths();
	wait(1);
	var_02 setlightintensity(1);
}

//Function Number: 28
garage_balcony_vo()
{
	wait(1);
	maps\_utility::smart_radio_dialogue("ie_iln_hide2");
}

//Function Number: 29
ie_west_drones()
{
	var_00 = vehicle_scripts\_pdrone_security::drone_spawn_and_drive("ie_west_drones");
	common_scripts\utility::flag_wait("player_entered_balcony_door");
	common_scripts\utility::array_thread(var_00,::frontyard_drone_cleanup);
}

//Function Number: 30
frontyard_drone_cleanup()
{
	self endon("death");
	var_00 = 0;
	while(!var_00)
	{
		if(!maps\_utility::within_fov_2d(level.player.origin,level.player.angles,self.origin,cos(45)))
		{
			var_00 = 1;
			continue;
		}

		wait(0.1);
	}

	self delete();
}

//Function Number: 31
ie_west_spawner_setup()
{
	self endon("death");
	maps\_utility::walkdist_zero();
	common_scripts\utility::flag_wait("player_entered_balcony_door");
	self delete();
}

//Function Number: 32
guesthouse_enemies()
{
	maps\_utility::array_spawn_function_targetname("guesthouse_spawner",::guesthouse_spawner_setup);
	var_00 = maps\_utility::array_spawn_targetname("guesthouse_spawner",1);
	level endon("player_enters_front_yard_save_4");
	common_scripts\utility::flag_wait("spawn_civilian_guesthouse_smoking");
	maps\_utility::array_spawn_function_targetname("guesthouse_balcony_walkout_spawner",::guesthouse_spawner_setup);
	var_01 = maps\_utility::array_spawn_targetname("guesthouse_balcony_walkout_spawner",1);
}

//Function Number: 33
guesthouse_spawner_setup()
{
	self endon("death");
	maps\_utility::walkdist_zero();
	common_scripts\utility::flag_wait("player_entered_balcony_door");
	self delete();
}