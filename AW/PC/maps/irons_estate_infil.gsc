/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: irons_estate_infil.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 475 ms
 * Timestamp: 4/22/2024 2:31:57 AM
*******************************************************************/

//Function Number: 1
infil_start()
{
	level.start_point_scripted = "infil";
	maps\irons_estate::irons_estate_objectives();
	maps\irons_estate_code::spawn_player_checkpoint();
	maps\irons_estate_code::spawn_allies();
	thread poolhouse_enemies();
	thread maps\irons_estate_code::tennis_court_floor(1);
	thread maps\irons_estate_code::player_kill_trigger("waterfall_bottom_kill_trigger");
	thread maps\irons_estate_code::player_kill_trigger("waterfall_top_kill_trigger");
	soundscripts\_snd::snd_message("start_infil");
	level.player.tagging["tagging_fade_max"] = 4000;
}

//Function Number: 2
infil_main()
{
	level.start_point_scripted = "infil";
	level.stealth_fail_fast = 1;
	common_scripts\utility::flag_set("infil_begin");
	thread infil_begin();
	common_scripts\utility::flag_wait("infil_end");
	maps\_utility::autosave_stealth();
}

//Function Number: 3
infil_begin()
{
	common_scripts\utility::flag_init("enable_grapple_infil");
	common_scripts\utility::flag_init("security_center_door_open");
	common_scripts\utility::flag_init("decoy_tutorial_obj");
	common_scripts\utility::flag_init("decoy_tutorial_enemy_in_range");
	level.tutorial_anim_struct = common_scripts\utility::getstruct("overlook_balcony_grapple_magnet_struct","targetname");
	thread handle_infil();
	thread infil_allies();
	thread infil_vo();
}

//Function Number: 4
handle_infil()
{
	var_00 = common_scripts\utility::getstruct("infil_obj","targetname");
	objective_add(maps\_utility::obj("infil"),"current",&"IRONS_ESTATE_OBJ_INFIL");
	objective_position(maps\_utility::obj("infil"),var_00.origin);
	wait(1);
	level.player.grapple["dist_max"] = 1100;
	var_01 = common_scripts\utility::getstruct("overlook_balcony_grapple_magnet_struct","targetname");
	var_02 = var_01 common_scripts\utility::spawn_tag_origin();
	var_03 = spawnstruct();
	var_03.landanimbody = %ie_stealth_meter_enter_player;
	var_03.landanimhands = %ie_stealth_meter_view_enter_player;
	var_03.noenableexo = 1;
	var_03.noenableweapon = 1;
	var_03.indicatoroffset = (0,0,45);
	maps\_grapple::grapple_magnet_register(var_02,"tag_origin",(0,0,0),"overlook_balcony_land",undefined,var_03,undefined);
	thread watch_for_player_to_reach_overlook();
	thread handle_player_during_tutorial(var_02);
	thread handle_stealth_display_tutorial();
	thread handle_decoy_tutorial();
	thread tutorial_vo();
	common_scripts\utility::flag_wait("player_in_estate");
	common_scripts\utility::flag_set("ie_west_central_garden_trees");
	level.player.tagging["tagging_fade_max"] = 3000;
	level.stealth_fail_fast = undefined;
	maps\_utility::objective_complete(maps\_utility::obj("infil"));
	level.player.grapple["dist_max"] = 0;
	thread maps\irons_estate_code::handle_player_abandoned_mission("nox");
	var_04 = getent("infil_grapple_magnet_block_clip","targetname");
	var_04 delete();
	thread maps\irons_estate_code::irons_estate_trigger_saves("emp_detonated","poolyard_save_1");
	thread maps\irons_estate_code::irons_estate_trigger_saves("emp_detonated","poolyard_save_2");
	common_scripts\utility::flag_wait_either("concealed_kill_spawner_dead","player_skipping_concealed_kill_tutorial");
	maps\_utility::autosave_stealth();
	var_05 = common_scripts\utility::getstruct("security_center_obj","targetname");
	objective_add(maps\_utility::obj("security_center"),"current",&"IRONS_ESTATE_OBJ_SECURITY_CENTER");
	objective_position(maps\_utility::obj("security_center"),var_05.origin);
	level.player.grapple["grappled_count"] = 1;
	thread start_enemy_callout_vo();
	thread maps\irons_estate_code::drone_incoming_vo("nox");
	thread maps\irons_estate_code::clean_kill_vo("nox");
	maps\_utility::delaythread(6,::maps\irons_estate_code::dont_shoot_warning_vo,"nox");
	maps\_utility::delaythread(6,::maps\irons_estate_code::exposed_group_logic);
	maps\irons_estate_code::enemy_alert_vo_setup("nox");
	thread maps\irons_estate_code::failed_vo("nox");
	maps\_utility::delaythread(5,::maps\irons_estate_code::generic_enemy_vo_chatter,"emp_detonated");
	wait(1);
	level.play_ally_callout_vo = 1;
	level.play_ally_warning_vo = 1;
	common_scripts\utility::flag_wait("poolyard_save");
	common_scripts\_exploder::exploder(6611);
	var_06 = getentarray("security_center_light_hatch","targetname");
	thread maps\irons_estate_code::security_center_lights(undefined,var_06,50000);
	thread maps\irons_estate_security_center::security_center_fan_blades();
	maps\_utility::autosave_stealth();
	level.play_ally_callout_vo = undefined;
	level.ally_vo_org stopsounds();
	wait(0.05);
	wait(0.25);
	var_07 = common_scripts\utility::getstruct("security_center_rooftop_obj","targetname");
	var_08 = common_scripts\utility::getstruct("security_center_emp_xprompt","targetname");
	objective_position(maps\_utility::obj("security_center"),var_08.origin);
	objective_current_nomessage(maps\_utility::obj("security_center"));
	thread maps\irons_estate_code::handle_objective_marker(var_08,var_07,"player_planting_emp",50);
	common_scripts\utility::flag_wait("player_on_security_center_rooftop");
	objective_setpointertextoverride(maps\_utility::obj("security_center"),&"IRONS_ESTATE_PLANT");
	thread maps\irons_estate_security_center::drone_setup_before_emp();
	if(!common_scripts\utility::flag("_stealth_spotted") && !common_scripts\utility::flag("someone_became_alert") && !common_scripts\utility::flag("drones_investigating"))
	{
		common_scripts\utility::flag_wait("security_center_rooftop_drone_up");
		wait(4);
	}

	common_scripts\utility::flag_set("infil_end");
}

//Function Number: 5
start_enemy_callout_vo()
{
	common_scripts\utility::flag_wait("start_enemy_callout_vo");
	maps\_utility::delaythread(6,::maps\irons_estate_code::enemy_callout_vo,"nox");
}

//Function Number: 6
watch_for_player_to_reach_overlook()
{
	var_00 = getent("overlook_block_player_clip","targetname");
	var_00 notsolid();
	common_scripts\utility::flag_wait("overlook_block_player_trigger");
	soundscripts\_snd::snd_message("aud_grapple_infil");
	if(level.player.grapple["grappling"] != 1)
	{
		var_00 solid();
	}
}

//Function Number: 7
handle_player_during_tutorial(param_00)
{
	level.player_rig = maps\_utility::spawn_anim_model("player_rig");
	level.player_rig hide();
	level.tutorial_anim_struct maps\_anim::anim_first_frame_solo(level.player_rig,"tutorial_idle_first_frame_only");
	for(;;)
	{
		level.player waittill("grapple_started",var_01);
		if(isdefined(var_01) && var_01.notifyname == "overlook_balcony_land")
		{
			break;
		}
	}

	level.player waittill("grapple_rig_hidden");
	level.tutorial_anim_struct thread maps\_anim::anim_loop_solo(level.player_rig,"tutorial_idle","stop_loop");
	level.player_rig show();
	level.player waittill("overlook_balcony_land");
	maps\_grapple::grapple_magnet_unregister(param_00,"tag_origin");
	level.player allowcrouch(0);
	level.player allowprone(0);
	level.player freezecontrols(1);
	level.player thread maps\_shg_utility::disable_features_entering_cinema(1);
	level.player disableweapons();
	thread maps\irons_estate_code::remove_grapple();
	level.player thread maps\_tagging::tagging_set_binocs_enabled(0);
	var_02 = "";
	level.player playerlinktodelta(level.player_rig,"tag_player",0,80,40,40,20,1);
	common_scripts\utility::flag_wait("stealth_display_tutorial_over");
	maps\_utility::autosave_stealth();
	level.tutorial_anim_struct notify("stop_loop");
	level.tutorial_anim_struct thread maps\_anim::anim_single_solo(level.player_rig,"tutorial_exit");
	level.player lerpviewangleclamp(0.25,0,0,0,0,0,0);
	level.player_rig waittillmatch("to_crouch","single anim");
	level.player allowcrouch(1);
	level.player setstance("crouch");
	level.player_rig waittillmatch("end","single anim");
	level.player_rig delete();
	level.player unlink();
	level.player allowstand(1);
	level.player allowprone(1);
	level.player freezecontrols(0);
	thread maps\_shg_utility::show_player_hud();
	var_03 = level.player getweaponslistall();
	var_02 = level.player getcurrentweapon();
	level.player giveweapon("s1_unarmed");
	level.player switchtoweaponimmediate("s1_unarmed");
	level.player disableweaponswitch();
	wait(0.25);
	level.player enableweapons();
	level.player allowmelee(0);
	level.player allowsprint(0);
	level.player allowads(0);
	level.player thread maps\_tagging::tagging_set_binocs_enabled(1);
	if(common_scripts\utility::flag("_stealth_spotted"))
	{
		return;
	}

	common_scripts\utility::flag_wait_any("player_concealed","_stealth_spotted","concealed_kill_spawner_dead","player_skipping_concealed_kill_tutorial","tutorial_guard_alerted");
	if(common_scripts\utility::flag("player_concealed"))
	{
		level.player maps\_grapple::grapple_give();
		level.player.grapple["dist_max"] = 800;
		common_scripts\utility::flag_wait_any("concealed_kill_spawner_dead","player_skipping_concealed_kill_tutorial","_stealth_spotted","tutorial_guard_alerted");
	}
	else
	{
		level.player maps\_grapple::grapple_give();
		level.player.grapple["dist_max"] = 800;
	}

	if(!common_scripts\utility::flag("_stealth_spotted") || common_scripts\utility::flag("tutorial_guard_alerted"))
	{
		wait(0.25);
	}

	level.player enableweaponswitch();
	if(level.player getcurrentweapon() != level.player.grapple["weapon"] && !level.player.grapple["quick_firing"])
	{
		level.player switchtoweapon(var_02);
	}
	else
	{
		setsaveddvar("cg_drawCrosshair",0);
	}

	wait(0.25);
	level.player takeweapon("s1_unarmed");
	level.player thread maps\_shg_utility::enable_features_exiting_cinema(1);
	level.player allowmelee(1);
	level.player allowsprint(1);
	level.player allowads(1);
}

//Function Number: 8
handle_stealth_display_tutorial()
{
	common_scripts\utility::flag_wait("player_in_estate");
	wait(2);
	stealth_display_hint();
}

//Function Number: 9
stealth_display_hint()
{
	var_00 = 4;
	level.player thread maps\_utility::display_hint_timeout("HINT_STEALTH_DETECTION");
	wait(var_00);
	common_scripts\utility::flag_set("HINT_STEALTH_DETECTION");
}

//Function Number: 10
concealed_kill_tutorial_display()
{
	level endon("concealed_kill_spawner_dead");
	level endon("_stealth_spotted");
	level.player endon("concealed_kill_enemy_grappled");
	level endon("player_skipping_concealed_kill_tutorial");
	var_00 = getent("concealed_kill_volume","targetname");
	for(;;)
	{
		if(level.player istouching(var_00))
		{
			if(!isdefined(level.concealed_tutorial_display_hint))
			{
				common_scripts\utility::flag_clear("HINT_CONCEALED_KILL_STOP");
				level.player thread maps\_utility::display_hint("HINT_CONCEALED_KILL");
				level.concealed_tutorial_display_hint = 1;
			}
		}
		else
		{
			common_scripts\utility::flag_set("HINT_CONCEALED_KILL_STOP");
			if(isdefined(level.concealed_tutorial_display_hint))
			{
				level.concealed_tutorial_display_hint = undefined;
			}
		}

		wait(0.05);
	}
}

//Function Number: 11
handle_decoy_tutorial()
{
	common_scripts\utility::flag_wait_either("concealed_kill_tutorial_ready","_stealth_spotted");
	if(common_scripts\utility::flag("_stealth_spotted") || common_scripts\utility::flag("concealed_kill_spawner_dead"))
	{
		return;
	}

	var_00 = common_scripts\utility::getstruct("concealed_kill_obj","targetname");
	objective_add(maps\_utility::obj("concealed_kill_obj"),"current");
	objective_position(maps\_utility::obj("concealed_kill_obj"),var_00.origin);
	objective_current_nomessage(maps\_utility::obj("concealed_kill_obj"));
	common_scripts\utility::flag_wait_any("player_concealed","_stealth_spotted","concealed_kill_spawner_dead","player_skipping_concealed_kill_tutorial");
	objective_current_nomessage();
	if(!common_scripts\utility::flag("player_concealed"))
	{
		return;
	}

	level endon("concealed_kill_spawner_dead");
	level endon("_stealth_spotted");
	level endon("player_skipping_concealed_kill_tutorial");
	thread handle_decoy_tutorial_hint_display();
}

//Function Number: 12
handle_decoy_tutorial_hint_display()
{
	level endon("concealed_kill_spawner_dead");
	level endon("player_skipping_concealed_kill_tutorial");
	level.player thread maps\_utility::display_hint_timeout("HINT_DECOY");
	thread decoy_hint_hud();
	level.player notifyonplayercommand("whistle","+actionslot " + level.action_slot_whistle);
	level.player waittill("whistle");
	maps\_grapple::grapple_magnet_register(level.tutorial_enemy_3,"j_SpineUpper",undefined,"concealed_kill_enemy_grappled",undefined,undefined,undefined);
	common_scripts\utility::flag_set("HINT_DECOY");
	level.player waittill("decoy_tutorial_enemy_in_range");
	level.player waittill("concealed_kill_enemy_grappled");
	common_scripts\utility::flag_set("HINT_CONCEALED_KILL");
	maps\_utility::autosave_stealth();
}

//Function Number: 13
decoy_hint_hud()
{
	setsaveddvar("cg_drawcrosshair","0");
	var_00 = undefined;
	var_01 = undefined;
	var_02 = undefined;
	if(level.player usinggamepad())
	{
		var_03 = "icon_hud_dpad";
		if(level.ps4)
		{
			var_03 = "icon_hud_dpad_ps4";
		}
		else if(level.xb3)
		{
			var_03 = "icon_hud_dpad_xb3";
		}

		var_00 = maps\_hud_util::createicon(var_03,48,48);
		var_00.hidewheninmenu = 1;
		var_00 maps\_hud_util::setpoint("TOP",undefined,0,190);
		var_01 = maps\_hud_util::createicon("dpad_icon_whistle",20,20);
		var_01.hidewheninmenu = 1;
		var_01 maps\_hud_util::setpoint("TOP",undefined,20,205);
		var_02 = maps\_hud_util::createicon("hud_dpad_arrow_right",32,32);
		var_02.hidewheninmenu = 1;
		var_02 maps\_hud_util::setpoint("TOP",undefined,-3,198);
		var_02.sort = 1;
		var_02.color = (1,1,0);
		var_02.alpha = 0.7;
	}

	common_scripts\utility::flag_wait_any("HINT_DECOY","_stealth_spotted","concealed_kill_spawner_dead","player_skipping_concealed_kill_tutorial","tutorial_guard_alerted");
	setsaveddvar("cg_drawcrosshair","1");
	if(level.player usinggamepad())
	{
		var_00 destroy();
		var_01 destroy();
		var_02 destroy();
	}

	level.player setweaponhudiconoverride("actionslot" + level.action_slot_whistle,"dpad_icon_whistle");
}

//Function Number: 14
infil_allies()
{
	level.allies[2].ignoreall = 1;
	if(!isdefined(level.allies[2].is_looping))
	{
		level.recon_anim_struct = common_scripts\utility::getstruct("recon_anim_struct","targetname");
		level.recon_anim_struct thread maps\_anim::anim_loop_solo(level.allies[2],"recon_exit_idle","stop_loop");
	}

	common_scripts\utility::flag_wait("hack_security_begin");
	if(isdefined(level.knox_pda))
	{
		stopfxontag(level._effect["ie_light_teal_recon_knox"],level.knox_pda,"tag_origin");
		level.knox_pda delete();
	}

	if(isdefined(level.allies[2].magic_bullet_shield))
	{
		level.allies[2] maps\_utility::stop_magic_bullet_shield();
	}

	level.allies[2] delete();
}

//Function Number: 15
infil_vo()
{
	common_scripts\utility::flag_wait("poolyard_save");
	wait(0.5);
	if(!common_scripts\utility::flag("_stealth_spotted"))
	{
		maps\_utility::smart_radio_dialogue("ie_nox_gettorooftop2");
	}

	common_scripts\utility::flag_wait("player_on_security_center_rooftop");
	wait(1);
	if(!common_scripts\utility::flag("_stealth_spotted") && !common_scripts\utility::flag("someone_became_alert") && !common_scripts\utility::flag("drones_investigating"))
	{
		maps\_utility::smart_radio_dialogue("ie_nox_dontengage");
	}
}

//Function Number: 16
tutorial_vo()
{
	level endon("_stealth_spotted");
	common_scripts\utility::flag_wait("player_in_estate");
	thread player_breaks_stealth_during_tutorial();
	wait(1.5);
	maps\_utility::smart_radio_dialogue("ie_nox_tangosleft");
	common_scripts\utility::flag_wait("stealth_display_tutorial_over");
	thread maps\_utility::smart_radio_dialogue("ie_nox_intobushes");
	wait(1);
	common_scripts\utility::flag_set("concealed_kill_tutorial_ready");
	common_scripts\utility::flag_wait_any("player_concealed","concealed_kill_spawner_dead","player_skipping_concealed_kill_tutorial");
	if(common_scripts\utility::flag("player_concealed"))
	{
		wait(0.25);
		maps\_utility::smart_radio_dialogue("ie_nox_dothisquietly");
		common_scripts\utility::flag_wait_any("concealed_kill_spawner_dead","player_skipping_concealed_kill_tutorial","decoy_tutorial_enemy_in_range");
		if(common_scripts\utility::flag("decoy_tutorial_enemy_in_range"))
		{
			for(;;)
			{
				if(isdefined(level.player.grapple["deathstyle"]) || common_scripts\utility::flag("player_skipping_concealed_kill_tutorial") || common_scripts\utility::flag("concealed_kill_spawner_dead"))
				{
					break;
				}

				wait(0.05);
			}

			if(!common_scripts\utility::flag("concealed_kill_spawner_dead") && !common_scripts\utility::flag("player_skipping_concealed_kill_tutorial"))
			{
				if(!isdefined(level.tutorial_enemy_3.isbeinggrappled))
				{
					maps\_utility::smart_radio_dialogue("ie_nox_takehimout");
				}
			}

			common_scripts\utility::flag_wait_either("concealed_kill_spawner_dead","player_skipping_concealed_kill_tutorial");
		}
	}

	level notify("stealth_display_concealed_kill_tutorial_end");
	wait(3);
	maps\_utility::smart_radio_dialogue("ie_nox_securitycenter");
	wait(1);
	thread nox_generic_hints();
}

//Function Number: 17
nox_generic_hints()
{
	level endon("poolyard_save");
	level.generic_hint_vo[0] = spawnstruct();
	level.generic_hint_vo[0].vo = "ie_nox_sticktoshadows";
	level.generic_hint_vo[0].vo_priority = 4;
	level.generic_hint_vo[1] = spawnstruct();
	level.generic_hint_vo[1].vo = "ie_nox_multipleroutes";
	level.generic_hint_vo[1].vo_priority = 4;
	level.stick_to_shadows = undefined;
	level.multiple_routes = undefined;
	level.last_generic_hint_said = undefined;
	var_00 = getentarray("nox_generic_hints","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread nox_generic_hints_internal();
	}
}

//Function Number: 18
nox_generic_hints_internal()
{
	level endon("poolyard_save");
	while(!isdefined(level.stick_to_shadows) && isdefined(level.multiple_routes))
	{
		wait(1);
		self waittill("trigger");
		if(isdefined(level.last_generic_hint_said))
		{
			var_00 = gettime() - level.last_generic_hint_said;
			if(var_00 < 15000)
			{
				continue;
			}
		}

		if(level.player istouching(self))
		{
			if(isdefined(level.current_vo))
			{
				while(isdefined(level.current_vo))
				{
					wait 0.05;
				}
			}

			if(isdefined(self.script_noteworthy) && self.script_noteworthy == "multiple_routes")
			{
				if(!isdefined(level.multiple_routes))
				{
					thread maps\irons_estate_code::ally_vo_controller(level.generic_hint_vo[1]);
					level.multiple_routes = 1;
					level.last_generic_hint_said = gettime();
					break;
				}

				continue;
			}

			if(!isdefined(level.stick_to_shadows))
			{
				thread maps\irons_estate_code::ally_vo_controller(level.generic_hint_vo[0]);
				level.stick_to_shadows = 1;
				level.last_generic_hint_said = gettime();
				break;
			}
		}
	}
}

//Function Number: 19
player_breaks_stealth_during_tutorial()
{
	level endon("stealth_display_concealed_kill_tutorial_end");
	common_scripts\utility::flag_wait("_stealth_spotted");
	common_scripts\utility::flag_waitopen("_stealth_spotted");
	maps\_utility::smart_radio_dialogue("ie_nox_securitycenter");
}

//Function Number: 20
poolhouse_enemies()
{
	maps\_utility::array_spawn_function_targetname("poolhouse_spawner",::poolhouse_spawner_setup);
	var_00 = maps\_utility::array_spawn_targetname("poolhouse_spawner",1);
	thread maps\irons_estate_civilians::ie_poolhouse_civilian_vignettes();
	thread poolhouse_drones();
	thread ie_west_deterrent_drones();
	thread security_center_rooftop_drone();
	if(level.start_point_scripted == "grapple" || level.start_point_scripted == "recon" || level.start_point_scripted == "infil")
	{
		maps\_utility::array_spawn_function_targetname("stealth_display_tutorial_spawner",::stealth_display_tutorial_spawner_setup);
		var_01 = maps\_utility::array_spawn_targetname("stealth_display_tutorial_spawner",1);
		thread tutorial_guards_vo();
	}

	if(level.start_point_scripted != "hack_security")
	{
		common_scripts\utility::flag_wait("player_in_estate");
		maps\_utility::array_spawn_function_targetname("security_center_guard_right_spawner",::security_center_guard_spawner_setup);
		var_02 = maps\_utility::array_spawn_targetname("security_center_guard_right_spawner",1);
		maps\_utility::array_spawn_function_targetname("security_center_guard_left_spawner",::security_center_guard_spawner_setup);
		var_03 = maps\_utility::array_spawn_targetname("security_center_guard_left_spawner",1);
	}
}

//Function Number: 21
poolhouse_spawner_setup()
{
	self endon("death");
	self.animname = "generic";
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "poolyard_guard_wander")
	{
		thread poolyard_guard_wander_setup();
	}

	maps\_utility::walkdist_zero();
	common_scripts\utility::flag_wait("player_enters_front_yard_save_4");
	self delete();
}

//Function Number: 22
poolyard_guard_wander_setup()
{
	self endon("death");
	self endon("whistle");
	self endon("alerted");
	thread poolyard_guard_wander_watch_for_alert();
	var_00 = common_scripts\utility::getstruct("poolyard_anim_struct_2","targetname");
	var_00 childthread maps\_anim::anim_loop_solo(self,"patrol_unarmed_idle","stop_loop");
	common_scripts\utility::flag_wait("start_poolyard_guard_wander");
	if(common_scripts\utility::flag("_stealth_spotted") || isdefined(self.has_been_alerted))
	{
		return;
	}

	var_00 notify("stop_loop");
	self.nogun = 1;
	maps\_utility::gun_remove();
	var_01 = common_scripts\utility::getstruct("poolyard_anim_struct","targetname");
	var_01 maps\_anim::anim_single_solo(self,"ie_frontyard_garden_wander_enemy1");
}

//Function Number: 23
poolyard_guard_wander_watch_for_alert()
{
	self endon("death");
	maps\_utility::ent_flag_waitopen("_stealth_normal");
	self.has_been_alerted = 1;
	self notify("alerted");
	if(isdefined(self.nogun))
	{
		wait(0.5);
		maps\_utility::gun_recall();
		self.no_gun = undefined;
	}
}

//Function Number: 24
security_center_guard_spawner_setup()
{
	self endon("death");
	maps\_utility::walkdist_zero();
	if(level.start_point_scripted == "hack_security" || level.start_point_scripted == "meet_cormack")
	{
		if(isdefined(level.security_center_guard_exposed_vo_said))
		{
			self.exposed_vo_said = 1;
		}

		if(self.script_noteworthy == "security_center_guard_right" && isdefined(level.security_center_guard_right_tagged))
		{
			maps\_tagging::tag_enemy(level.player);
		}

		if(self.script_noteworthy == "security_center_guard_left" && isdefined(level.security_center_guard_left_tagged))
		{
			maps\_tagging::tag_enemy(level.player);
		}

		common_scripts\utility::flag_wait("player_enters_front_yard_save_4");
		self delete();
		return;
	}

	common_scripts\utility::flag_wait("emp_detonated");
	if(isdefined(self.exposed_vo_said))
	{
		level.security_center_guard_exposed_vo_said = 1;
	}

	if(isdefined(self.tagged) && isdefined(self.tagged[level.player getentitynumber()]))
	{
		if(self.script_noteworthy == "security_center_guard_right")
		{
			level.security_center_guard_right_tagged = 1;
		}

		if(self.script_noteworthy == "security_center_guard_left")
		{
			level.security_center_guard_left_tagged = 1;
		}
	}

	common_scripts\utility::flag_set(self.script_noteworthy);
	self delete();
}

//Function Number: 25
poolhouse_drones()
{
	var_00 = vehicle_scripts\_pdrone_security::drone_spawn_and_drive("poolhouse_drones");
	common_scripts\utility::flag_wait("player_enters_front_yard_save_2");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02))
		{
			var_02 delete();
		}
	}
}

//Function Number: 26
ie_west_deterrent_drones()
{
	if(level.start_point_scripted == "grapple" || level.start_point_scripted == "recon" || level.start_point_scripted == "infil" || level.start_point_scripted == "security_center")
	{
		var_00 = vehicle_scripts\_pdrone_security::drone_spawn_and_drive("ie_west_deterrent_drones");
		common_scripts\utility::flag_wait("hack_security_begin");
		foreach(var_02 in var_00)
		{
			if(isdefined(var_02))
			{
				var_02 delete();
			}
		}
	}
}

//Function Number: 27
security_center_rooftop_drone()
{
	common_scripts\utility::flag_wait("player_on_security_center_rooftop");
	if(!common_scripts\utility::flag("_stealth_spotted") && !common_scripts\utility::flag("someone_became_alert") && !common_scripts\utility::flag("drones_investigating"))
	{
		var_00 = getent("hatch_door_left","targetname");
		var_00.animname = "hatch_door_left";
		var_00 useanimtree(level.scr_animtree["hatch_door_left"]);
		var_00 thread maps\_anim::anim_single_solo(var_00,"hatch_left_open");
		soundscripts\_snd_playsound::snd_play_at("irons_drone_hatch",var_00.origin);
		var_00 waittillmatch("end","single anim");
		common_scripts\_exploder::exploder(430);
		var_01 = vehicle_scripts\_pdrone_security::drone_spawn_and_drive("security_center_rooftop_drone");
		wait(1.5);
		soundscripts\_snd_playsound::snd_play_at("sdrone_voc_aggressive",var_00.origin);
		var_00 thread maps\_anim::anim_single_solo(var_00,"hatch_left_close");
		wait(0.1);
		var_00 waittillmatch("end","single anim");
		maps\_utility::stop_exploder(430);
	}
}

//Function Number: 28
stealth_display_tutorial_spawner_setup()
{
	self endon("death");
	self.animname = "generic";
	self.grapple_magnets = [];
	if(self.script_noteworthy == "stealth_display_tutorial_enemy_1")
	{
		level.tutorial_enemy_1 = self;
	}

	if(self.script_noteworthy == "stealth_display_tutorial_enemy_2")
	{
		level.tutorial_enemy_2 = self;
	}

	if(self.script_noteworthy == "stealth_display_tutorial_enemy_3")
	{
		level.tutorial_enemy_3 = self;
	}

	maps\_utility::walkdist_zero();
	common_scripts\utility::flag_wait("player_in_estate");
	self notify("end_patrol");
	maps\_utility::anim_stopanimscripted();
	wait 0.05;
	maps\_utility::gun_remove();
	level.tutorial_anim_struct maps\_anim::anim_first_frame_solo(self,self.script_noteworthy);
	level.tutorial_anim_struct thread maps\_anim::anim_single_solo(self,self.script_noteworthy);
	if(self.script_noteworthy == "stealth_display_tutorial_enemy_1")
	{
		var_00 = maps\_utility::spawn_anim_model("tutorial_overlook_door_prop");
		var_01 = getent("overlook_door_model","targetname");
		var_02 = getent("overlook_door_clip","targetname");
		level.tutorial_anim_struct maps\_anim::anim_first_frame_solo(var_00,"ie_stealth_meter_door");
		var_01 linkto(var_00,"J_prop_1");
		var_02 linkto(var_00,"J_prop_1");
		self waittillmatch("open_door","single anim");
		level.tutorial_anim_struct thread maps\_anim::anim_single_solo(var_00,"ie_stealth_meter_door");
		wait(1);
		common_scripts\utility::flag_set("stealth_display_tutorial_over");
	}

	if(self.script_noteworthy != "stealth_display_tutorial_enemy_3")
	{
		common_scripts\utility::flag_wait("stealth_display_tutorial_over");
		wait(3);
		maps\_tagging::tag_outline_enemy(0);
	}

	if(self.script_noteworthy == "stealth_display_tutorial_enemy_3")
	{
		thread watch_for_alert();
		thread watch_for_tutorial_enemy_death();
		common_scripts\utility::flag_wait("stealth_display_tutorial_over");
		thread watch_distance_on_tutorial_spawner();
		self endon("whistle");
		level endon("tutorial_guard_alerted");
		level endon("_stealth_spotted");
	}

	self waittillmatch("end","single anim");
	if(self.script_noteworthy != "stealth_display_tutorial_enemy_3")
	{
		self delete();
		return;
	}

	wait 0.05;
	if(!isdefined(self.whistle_tutorial_enemy))
	{
		level.tutorial_anim_struct thread maps\_anim::anim_loop_solo(self,"ie_stealth_meter_guard_idle","guard_3_stop_loop");
	}
}

//Function Number: 29
watch_for_alert()
{
	self endon("death");
	for(;;)
	{
		maps\_utility::ent_flag_waitopen("_stealth_normal");
		wait 0.05;
		if(isdefined(self.event_type) && self.event_type == "whistle")
		{
			if(!isdefined(self.whistle_tutorial_enemy))
			{
				thread whistle();
			}
		}
		else
		{
			common_scripts\utility::flag_set("tutorial_guard_alerted");
			level.tutorial_anim_struct notify("guard_3_stop_loop");
			maps\_utility::anim_stopanimscripted();
			maps\_utility::gun_recall();
		}

		maps\_utility::ent_flag_wait("_stealth_normal");
		var_00 = common_scripts\utility::getstruct("tutorial_guard_idle_struct","targetname");
		self.target = var_00.targetname;
		thread maps\_patrol::patrol(self.target);
		if(common_scripts\utility::flag("tutorial_guard_alerted"))
		{
			break;
		}
	}
}

//Function Number: 30
whistle()
{
	self endon("death");
	self.whistle_tutorial_enemy = 1;
	level.tutorial_anim_struct notify("guard_3_stop_loop");
	maps\_utility::anim_stopanimscripted();
	wait(0.5);
	maps\_utility::gun_recall();
}

//Function Number: 31
watch_for_tutorial_enemy_death()
{
	self waittill("death");
	common_scripts\utility::flag_set("concealed_kill_spawner_dead");
}

//Function Number: 32
watch_distance_on_tutorial_spawner()
{
	self endon("death");
	common_scripts\utility::flag_wait_either("HINT_DECOY","player_skipping_concealed_kill_tutorial");
	if(common_scripts\utility::flag("player_skipping_concealed_kill_tutorial"))
	{
		maps\_grapple::grapple_magnet_register(self,"j_SpineUpper",undefined,"concealed_kill_enemy_grappled",undefined,undefined,undefined);
		return;
	}

	while(!common_scripts\utility::flag("player_skipping_concealed_kill_tutorial"))
	{
		if(distancesquared(self.origin,level.player.origin) < 160000)
		{
			break;
		}

		wait(0.05);
	}

	if(!common_scripts\utility::flag("player_skipping_concealed_kill_tutorial"))
	{
		level.player notify("decoy_tutorial_enemy_in_range");
		common_scripts\utility::flag_set("decoy_tutorial_enemy_in_range");
	}
}

//Function Number: 33
tutorial_guards_vo()
{
	common_scripts\utility::flag_wait("player_in_estate");
	level.tutorial_enemy_1 endon("death");
	level.tutorial_enemy_2 endon("death");
	level.tutorial_enemy_3 endon("death");
	level.tutorial_enemy_1 thread maps\irons_estate_civilians::stop_civilian_conversation("stealth_display_tutorial_over");
	level.tutorial_enemy_2 thread maps\irons_estate_civilians::stop_civilian_conversation("stealth_display_tutorial_over");
	level.tutorial_enemy_3 thread maps\irons_estate_civilians::stop_civilian_conversation("stealth_display_tutorial_over");
	level.tutorial_enemy_3 maps\_utility::smart_dialogue("ie_cm1_luckyshot");
	level.tutorial_enemy_2 maps\_utility::smart_dialogue("ie_cm2_notluck");
	level.tutorial_enemy_1 maps\_utility::smart_dialogue("ie_cm3_bandwagonfan");
	level.tutorial_enemy_2 maps\_utility::smart_dialogue("ie_cm2_likeanyteam");
	level.tutorial_enemy_1 maps\_utility::smart_dialogue("ie_cm3_winitall");
	level.tutorial_enemy_2 maps\_utility::smart_dialogue("ie_cm2_4to1");
	level.tutorial_enemy_1 maps\_utility::smart_dialogue("ie_cm3_anidiot");
}