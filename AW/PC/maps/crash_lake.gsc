/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: crash_lake.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 98
 * Decompile Time: 1529 ms
 * Timestamp: 4/22/2024 2:27:16 AM
*******************************************************************/

//Function Number: 1
precache_overlook()
{
	common_scripts\utility::flag_init("overlook_done");
	common_scripts\utility::flag_init("FLAG_overlook_death");
	common_scripts\utility::flag_init("crash_overlook");
	common_scripts\utility::flag_init("overlook_save");
	common_scripts\utility::flag_init("lake_begin_outdoors");
	maps\_utility::add_control_based_hint_strings("player_crash_falloff",&"CRASH_FALLOFF",::should_break_recover_hint);
}

//Function Number: 2
precache_lake()
{
	common_scripts\utility::flag_init("ice_lake_start_combat");
	common_scripts\utility::flag_init("lake_done");
	common_scripts\utility::flag_init("gideon_frees_you");
	common_scripts\utility::flag_init("ice_lake_side_wave");
	common_scripts\utility::flag_init("ice_lake_move_up");
	common_scripts\utility::flag_init("survivors_vulnerable");
	common_scripts\utility::flag_init("kill_survivors");
	common_scripts\utility::flag_init("ice_lake_cormack_movedown");
	common_scripts\utility::flag_init("ice_lake_wave_1_done");
	common_scripts\utility::flag_init("ice_lake_wave_2_done");
	common_scripts\utility::flag_init("ice_lake_wave_3_done");
	common_scripts\utility::flag_init("start_shooting_at_squad");
	common_scripts\utility::flag_init("ice_lake_callout_pause");
	common_scripts\utility::flag_init("lake_underwater_lighting");
	common_scripts\utility::flag_init("lake_drown");
	common_scripts\utility::flag_init("lake_player_fail");
	common_scripts\utility::flag_init("cargo_captured");
	common_scripts\utility::flag_init("player_swimming_end");
	common_scripts\utility::flag_init("player_swimming_drown");
	precacheitem("iw5_mahemstraight_sp");
	precachestring(&"CRASH_FAIL_CARGO");
	precachestring(&"CRASH_FAIL_DROWN");
	maps\_utility::add_control_based_hint_strings("player_lake_swim",&"CRASH_HINT_SWIM_GAMEPAD",::should_break_swim_hint,&"CRASH_HINT_SWIM_KEYBOARD",&"CRASH_HINT_SWIM_GAMEPAD_S");
	precachemodel("generic_prop_raven");
	precachemodel("mob_crane_container_short_blk");
}

//Function Number: 3
precache_lake_cinema()
{
	common_scripts\utility::flag_init("lake_cinema_done");
	common_scripts\utility::flag_init("setup_lake_cargo");
	common_scripts\utility::flag_init("go_lake_cargo");
	common_scripts\utility::flag_init("go_gideon_moment");
	common_scripts\utility::flag_init("go_lighting_gideon");
	common_scripts\utility::flag_init("gideon_lighting_unlock");
	common_scripts\utility::flag_init("go_gideon_moment_save");
}

//Function Number: 4
debug_start_overlook()
{
	maps\crash::set_completed_flags();
	maps\crash_utility::setup_player();
	maps\crash_utility::setup_allies();
	soundscripts\_snd::snd_message("start_overlook");
	common_scripts\utility::flag_set("combat_cave_outdoors");
	thread maps\crash::objective_init();
	level.player lightsetforplayer("crash_overlook");
	maps\_utility::vision_set_fog_changes("crash_overlook",0);
	level.player setclutforplayer("clut_crash_overlook",0);
	setsunflareposition((-13.9,-125.7,0));
	common_scripts\_exploder::exploder(1999);
}

//Function Number: 5
debug_start_lake()
{
	maps\crash::set_completed_flags();
	maps\crash_utility::setup_player();
	maps\crash_utility::setup_allies();
	soundscripts\_snd::snd_message("start_lake");
	thread exo_temp_overlook_lake();
	thread maps\crash::objective_init();
	level.player lightsetforplayer("crash_avalanche");
	maps\_utility::vision_set_fog_changes("crash_avalanche",0);
	level.player setclutforplayer("clut_crash_overlook",2);
	setsunflareposition((-10.39,-112.7,0));
	common_scripts\_exploder::exploder(1999);
}

//Function Number: 6
debug_start_lake_cinema()
{
	maps\crash::set_completed_flags();
	maps\crash_utility::setup_player();
	maps\crash_utility::setup_allies();
	soundscripts\_snd::snd_message("start_lake_cinema");
	thread maps\crash_exfil::dead_stinger_guy();
	thread maps\crash_exfil::vtol_takedown_cormack_stinger();
	thread maps\crash::objective_init();
	common_scripts\utility::flag_set("hide_player_snow_footprints");
	common_scripts\utility::flag_set("indoors");
	thread lake_fall_in(1);
	level.visionset_default = "crash_avalanche";
	common_scripts\_exploder::exploder(1999);
}

//Function Number: 7
overlook_autosave()
{
	common_scripts\utility::flag_wait("FLAG_overlook_autosave");
	thread maps\_utility::autosave_by_name("entered_overlook");
	common_scripts\utility::flag_set("combat_cave_done");
}

//Function Number: 8
begin_overlook()
{
	thread maps\crash_fx::overlook_smoke_vista();
	thread overlook_kill_player();
	thread overlook_autosave();
	thread overlook_anim();
	thread exo_temp_overlook_lake();
	thread overlook_wind();
	thread overlook_land();
	thread overlook_grab_save();
	thread overlook_force_stand();
	thread overlook_drone();
	setdvar("scr_traverse_debug",1);
	common_scripts\utility::flag_wait("overlook_done");
}

//Function Number: 9
overlook_drone()
{
	level endon("lake_begin_indoors");
	common_scripts\utility::flag_wait("FLAG_overlook_traversing");
	level.cormack.ignoreall = 1;
	level.ilana.ignoreall = 1;
	var_00 = vehicle_scripts\_pdrone::start_flying_attack_drones("pdrone_small1");
	wait(2);
	foreach(var_02 in var_00)
	{
		var_02.ignoreme = 1;
		var_02.ignoreall = 1;
	}

	var_04 = vehicle_scripts\_pdrone::start_flying_attack_drones("pdrone_small3");
	var_05 = vehicle_scripts\_pdrone::start_flying_attack_drones("pdrone_small2");
	var_06 = common_scripts\utility::array_combine(var_00,var_04);
	var_06 = common_scripts\utility::array_combine(var_06,var_05);
	foreach(var_02 in var_06)
	{
		var_02.ignoreme = 1;
		var_02.ignoreall = 1;
		var_02.attack_accuracy = 0.25;
		var_02 setthreatdetection("enhanceable");
		var_02 setthreatdetection("detected");
	}

	var_06 overlook_start_combat();
}

//Function Number: 10
overlook_start_combat()
{
	wait(2);
	level.cormack maps\_utility::smart_radio_dialogue("crsh_crmk_dronesincoming4");
	wait(3);
	maps\_utility::smart_radio_dialogue("crsh_crmk_useemps");
	level.cormack.ignoreall = 0;
	level.ilana.ignoreall = 0;
	foreach(var_01 in self)
	{
		if(isdefined(var_01))
		{
			var_01.ignoreme = 0;
			var_01.ignoreall = 0;
		}
	}
}

//Function Number: 11
exo_temp_overlook_lake()
{
	level endon("lake_start");
	level.player thread maps\crash_utility::exo_temp_outdoor();
	for(;;)
	{
		wait(0.05);
		common_scripts\utility::flag_wait_either("combat_cave_outdoors","lake_begin_outdoors");
		common_scripts\utility::flag_clear("combat_cave_indoors");
		common_scripts\utility::flag_clear("lake_begin_indoors");
		common_scripts\utility::flag_clear("hide_player_snow_footprints");
		common_scripts\utility::flag_set("outdoors");
		level.player thread maps\crash_exo_temperature::set_external_temperature_over_time(level.temperature_outdoor,3);
		common_scripts\utility::flag_wait_either("combat_cave_indoors","lake_begin_indoors");
		common_scripts\utility::flag_clear("combat_cave_outdoors");
		common_scripts\utility::flag_clear("lake_begin_outdoors");
		common_scripts\utility::flag_set("hide_player_snow_footprints");
		common_scripts\utility::flag_set("indoors");
		level.player thread maps\crash_exo_temperature::set_external_temperature_over_time(level.temperature_indoor,3);
	}
}

//Function Number: 12
overlook_anim()
{
	common_scripts\utility::flag_wait("overlook_start_slide");
	level.slide_dampening = 0.075;
	var_00 = common_scripts\utility::getstruct("csh_overlook_anim","targetname");
	var_01 = [];
	var_01[0] = level.cormack;
	var_01[1] = level.ilana;
	level.ilana maps\_utility::disable_ai_color();
	level.cormack maps\_utility::disable_ai_color();
	if(!common_scripts\utility::flag("FLAG_overlook_traversing"))
	{
		var_00 maps\_anim::anim_reach_together(var_01,"overlook_intro");
	}

	common_scripts\_exploder::exploder(4333);
	if(!common_scripts\utility::flag("FLAG_overlook_traversing"))
	{
		level.cormack thread overlook_slide_fx();
		level.ilana thread overlook_slide_fx();
		level.cormack pushplayer(1);
		level.ilana pushplayer(1);
		thread overlook_override_anim();
		var_00 maps\_anim::anim_single(var_01,"overlook_intro");
		level notify("overlook_intro_done");
		level.cormack pushplayer(0);
		level.ilana pushplayer(0);
	}

	common_scripts\utility::flag_set("obj_start_overlook_run");
	if(!common_scripts\utility::flag("FLAG_overlook_traversing"))
	{
		thread maps\_utility::autosave_by_name("overlook_anim_over");
	}

	level.ilana maps\_utility::set_force_color("g");
	level.cormack maps\_utility::set_force_color("r");
	level.cormack maps\_utility::set_moveplaybackrate(1);
	level.ilana maps\_utility::set_moveplaybackrate(1);
	thread overlook_dialogue_2();
	common_scripts\utility::flag_set("overlook_done");
}

//Function Number: 13
overlook_slide_fx()
{
	self waittillmatch("start_slide","single anim");
	playfxontag(common_scripts\utility::getfx("ai_slide_snow"),self,"j_ball_le");
	self waittillmatch("end_slide","single anim");
	stopfxontag(common_scripts\utility::getfx("ai_slide_snow"),self,"j_ball_le");
}

//Function Number: 14
overlook_override_anim()
{
	level endon("overlook_intro_done");
	common_scripts\utility::flag_wait("obj_end_overlook_run");
	level.cormack maps\_utility::anim_stopanimscripted();
	level.ilana maps\_utility::anim_stopanimscripted();
}

//Function Number: 15
overlook_dialogue_1()
{
	level endon("lake_begin_outdoors");
	level.ilana maps\_utility::smart_dialogue("crsh_iln_thatsmoke");
	level.cormack maps\_utility::smart_radio_dialogue("crsh_crmk_howcopy2");
	maps\_utility::smart_radio_dialogue("crsh_grdn5_wherethehell");
	level.cormack maps\_utility::smart_dialogue("crsh_crmk_weneedtomove");
}

//Function Number: 16
overlook_dialogue_2()
{
	level endon("lake_begin_outdoors");
	wait(3);
	level.cormack maps\_utility::smart_dialogue("crsh_crmk_footing");
	level.ilana maps\_utility::smart_dialogue("crsh_iln_winds");
	wait(3);
	level.cormack maps\_utility::smart_radio_dialogue("crsh_crmk_locatedbox");
	maps\_utility::smart_radio_dialogue("crsh_so_attemptingtorarally");
	level.cormack maps\_utility::smart_radio_dialogue("crsh_crmk_sayagain");
	maps\_utility::smart_radio_dialogue("crsh_so_multiplefootmobiles");
	level.ilana maps\_utility::smart_dialogue("crsh_iln_almostthere");
}

//Function Number: 17
overlook_continue()
{
	maps\_utility::trigger_wait_targetname("TRIG_move_overlook_1");
	level.cormack maps\_utility::clear_run_anim();
	level.ilana maps\_utility::clear_run_anim();
}

//Function Number: 18
overlook_kill_player()
{
	common_scripts\utility::flag_wait("FLAG_overlook_death");
	setdvar("ui_deadquote",&"CRASH_FAIL_FALL");
	maps\_utility::missionfailedwrapper();
	level.player thread maps\_player_exo::player_exo_deactivate();
}

//Function Number: 19
overlook_wind()
{
	common_scripts\utility::flag_wait("FLAG_overlook_start_dialogue");
	var_00 = anglestoforward(common_scripts\utility::getstruct("overlook_wind_struct","targetname").angles);
	thread heavy_wind();
	while(!common_scripts\utility::flag("lake_start"))
	{
		wait(randomfloatrange(4,7));
		soundscripts\_snd::snd_message("wind_warning",level.player geteye());
		if(common_scripts\utility::flag("FLAG_overlook_traversing"))
		{
			earthquake(0.1,5,level.player.origin,10000);
		}

		wait(randomfloatrange(3,5));
		level.player playrumbleonentity("light_2s");
		soundscripts\_snd::snd_message("wind_gust",level.player geteye());
		common_scripts\_exploder::exploder(4555);
		var_01 = randomfloatrange(5,10);
		var_02 = randomintrange(10,20);
		for(var_03 = 0;var_03 < var_02;var_03++)
		{
			if(common_scripts\utility::flag("FLAG_overlook_traversing"))
			{
				level.player pushplayervector(var_00 * var_01 + 0.5 * var_03,0);
				earthquake(0.15,0.1,level.player.origin,1000);
			}
			else
			{
				level.player pushplayervector((0,0,0),0);
			}

			wait(0.1);
		}

		for(var_03 = var_02;var_03 > 0;var_03--)
		{
			if(common_scripts\utility::flag("FLAG_overlook_traversing"))
			{
				level.player pushplayervector(var_00 * var_01 + 0.5 * var_03,0);
				earthquake(0.15,0.1,level.player.origin,1000);
			}
			else
			{
				level.player pushplayervector((0,0,0),0);
			}

			wait(0.1);
		}

		level.player pushplayervector((0,0,0),0);
	}
}

//Function Number: 20
heavy_wind()
{
	for(;;)
	{
		common_scripts\_exploder::exploder(4555);
		wait(randomfloatrange(1,2));
	}
}

//Function Number: 21
overlook_land()
{
	self endon("death");
	level endon("lake_begin_indoors");
	common_scripts\utility::flag_wait("FLAG_overlook_traversing");
	while(!common_scripts\utility::flag("lake_start"))
	{
		common_scripts\utility::flag_waitopen("overlook_save");
		var_00 = level.player isjumping();
		if(isdefined(var_00) && var_00)
		{
			var_01 = gettime();
			wait 0.05;
			var_02 = level.player isonground();
			while(isdefined(var_02) && !var_02)
			{
				wait 0.05;
				var_02 = level.player isonground();
				if(common_scripts\utility::flag("overlook_save"))
				{
					break;
				}
			}

			if(common_scripts\utility::flag("overlook_save"))
			{
				continue;
			}

			var_03 = gettime();
			var_04 = var_03 - var_01;
			var_05 = var_04 / 3000;
			var_05 = clamp(var_05,0,0.4);
			if(var_05 < 0.21)
			{
				var_06 = 1;
				var_07 = "heavy_1s";
			}
			else if(var_07 < 0.35)
			{
				var_06 = 1;
				var_07 = "heavy_2s";
			}
			else
			{
				var_06 = 1.5;
				var_07 = "heavy_3s";
			}

			maps\_utility::_earthquake(var_05,var_06,level.player.origin,500);
			level.player playrumbleonentity(var_07);
			playfx(level._effect["snow_impact"],level.player.origin);
			soundscripts\_snd::snd_message("overlook_land");
		}

		wait 0.05;
	}
}

//Function Number: 22
overlook_grab_save()
{
	var_00 = getentarray("overlook_grab_trigger","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread overlook_grab_save_individual();
	}
}

//Function Number: 23
overlook_grab_save_individual()
{
	var_00 = common_scripts\utility::getstruct(self.target,"targetname");
	var_01 = common_scripts\utility::getstruct(var_00.target,"targetname");
	for(;;)
	{
		self waittill("trigger",var_02);
		if(isdefined(var_02) && isplayer(var_02) && !common_scripts\utility::flag("overlook_save"))
		{
			common_scripts\utility::flag_set("overlook_save");
			level.player setstance("stand");
			level.player allowcrouch(0);
			level.player allowprone(0);
			level.player hideviewmodel();
			level.player disableweapons();
			level.player playrumbleonentity("heavy_1s");
			soundscripts\_snd::snd_message("overlook_fall");
			wait 0.05;
			var_03 = maps\_utility::spawn_anim_model("rig_hands1",level.player.origin,level.player.angles);
			var_03 hide();
			var_01 thread maps\_anim::anim_single_solo(var_03,"fall_grab");
			var_03 thread play_falling_snow();
			level.player playerlinktoblend(var_03,"tag_player",0.15);
			wait(0.15);
			level.player playerlinktodelta(var_03,"tag_player",1,30,30,30,5,1);
			var_03 show();
			var_03 waittillmatch("end","single anim");
			var_01 thread maps\_anim::anim_loop_solo(var_03,"fall_loop");
			thread should_break_recover_hint_command();
			thread should_break_recover_hint_movement();
			level.player thread maps\_utility::hintdisplayhandler("player_crash_falloff");
			level.player waittill("playerjump");
			level.player playrumbleonentity("damage_heavy");
			soundscripts\_snd::snd_message("overlook_recover");
			level.player.recover = undefined;
			level.player playerlinktodelta(var_03,"tag_player",1,0,0,0,0,1);
			var_01 maps\_anim::anim_single_solo(var_03,"fall_recover");
			wait 0.05;
			level.player playrumbleonentity("damage_heavy");
			level.player allowcrouch(1);
			level.player allowprone(1);
			level.player showviewmodel();
			level.player enableweapons();
			level.player unlink();
			var_03 delete();
			wait 0.05;
			common_scripts\utility::flag_clear("overlook_save");
		}
	}
}

//Function Number: 24
play_falling_snow()
{
	var_00 = self;
	wait(0.45);
	var_01 = playfxontag(level._effect["snow_grab"],var_00,"ringplate_tr");
}

//Function Number: 25
overlook_force_stand()
{
	var_00 = getent("overlook_player_stand","targetname");
	for(;;)
	{
		var_00 waittill("trigger",var_01);
		if(var_01 == level.player)
		{
			level.player setstance("stand");
		}

		wait 0.05;
	}
}

//Function Number: 26
overlook_to_lake_teleport()
{
	common_scripts\utility::flag_wait("overlook_done");
	var_00 = common_scripts\utility::getstruct("lake_player_teleport_pre","targetname");
	var_01 = common_scripts\utility::getstruct("lake_player_teleport","targetname");
	var_02 = maps\_utility::spawn_anim_model("rig_hands1");
	var_02 hide();
	var_00 maps\_anim::anim_first_frame_solo(var_02,"control_fall");
	var_03 = maps\_utility::spawn_anim_model("rig_hands1");
	var_01 maps\_anim::anim_first_frame_solo(var_03,"control_fall");
	common_scripts\utility::flag_wait("lake_begin_indoors");
	common_scripts\utility::flag_set("obj_lake_enter");
	level.player hideviewmodel();
	level.player disableweapons();
	soundscripts\_snd::snd_message("enter_lake_cave");
	level.player playerlinktoblend(var_02,"tag_player",0.35);
	level.player setstance("stand");
	level.player allowcrouch(0);
	level.player allowprone(0);
	wait(0.3);
	var_00 thread maps\_anim::anim_single_solo(var_02,"control_fall");
	var_01 thread maps\_anim::anim_single_solo(var_03,"control_fall");
	var_02 show();
	wait(0.7);
	level.player maps\_hud_util::fade_out(0.05,"black");
	wait 0.05;
	level.player playerlinktoabsolute(var_03,"tag_player");
	thread handle_teleport(var_01);
	level.player playrumbleonentity("heavy_1s");
	var_03 waittillmatch("end","single anim");
	var_02 delete();
	var_03 delete();
	level.player unlink();
	level.player allowcrouch(1);
	level.player allowprone(1);
	level.player showviewmodel();
	level.player enableweapons();
}

//Function Number: 27
handle_teleport(param_00)
{
	wait 0.05;
	var_01 = common_scripts\utility::getstruct("lake_cormack","targetname");
	var_02 = common_scripts\utility::getstruct("lake_ilana","targetname");
	level.cormack maps\_utility::disable_ai_color();
	level.ilana maps\_utility::disable_ai_color();
	level.cormack forceteleport(var_01.origin,var_01.angles);
	level.ilana forceteleport(var_02.origin,var_02.angles);
	wait 0.05;
	level.player maps\_hud_util::fade_in(0.05,"black");
	level.cormack dontinterpolate();
	level.ilana dontinterpolate();
	level.cormack.goalradius = 0;
	level.ilana.goalradius = 0;
	wait 0.05;
	level.cormack maps\_utility::enable_ai_color();
	level.ilana maps\_utility::enable_ai_color();
}

//Function Number: 28
begin_lake()
{
	overlook_to_lake_teleport();
	common_scripts\utility::flag_wait("lake_start");
	level notify("moved_indoors");
	level.player thread maps\crash_exo_temperature::set_external_temperature_over_time(level.temperature_indoor,3);
	level.underwater_visionset_callback = ::ic_underwater_visionset_change;
	var_00 = getaiarray("axis");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02) && isalive(var_02))
		{
			if(isdefined(var_02.magic_bullet_shield) && var_02.magic_bullet_shield)
			{
				var_02 maps\_utility::stop_magic_bullet_shield();
			}

			var_02 delete();
		}
	}

	thread lake_autosave();
	thread lake_dialogue();
	thread lake_upper_deck();
	thread maps\crash_exfil::vtol_takedown_cormack_stinger();
	thread friendly_bias();
	level.player thread sniper_rifle_objective_logic();
	level.player thread play_railgun_fx();
	if(level.currentgen)
	{
		var_04 = ["ice_attack_wave_1_noDelete"];
		thread maps\_cg_encounter_perf_monitor::cg_spawn_perf_monitor("",undefined,15,0,var_04);
	}

	thread ice_lake_chopper();
	thread ice_lake_wave_0();
	thread ice_lake_wave_1();
	thread ice_lake_wave_2();
	thread ice_lake_wave_3();
	thread maps\crash_exfil::dead_stinger_guy();
	common_scripts\utility::flag_wait("chopper_found");
	soundscripts\_snd::snd_message("lake_events");
	common_scripts\utility::flag_set("obj_end_locate_chopper");
	thread lake_fall_in();
	common_scripts\utility::flag_wait("lake_done");
}

//Function Number: 29
lake_autosave()
{
	common_scripts\utility::flag_wait("FLAG_lake_start_save");
	thread maps\_utility::autosave_by_name("entered_lake_area");
}

//Function Number: 30
lake_drown()
{
	common_scripts\utility::flag_wait("lake_drown");
	setdvar("ui_deadquote",&"CRASH_FAIL_DROWN");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 31
sniper_rifle_objective_logic()
{
	for(;;)
	{
		var_00 = self getweaponslistprimaries();
		foreach(var_02 in var_00)
		{
			if(var_02 == "s1_railgun")
			{
				self takeweapon("s1_railgun");
				self giveweapon("s1_railgun+morsscope");
				self switchtoweapon("s1_railgun+morsscope");
				break;
			}
		}

		wait(0.05);
	}
}

//Function Number: 32
friendly_bias()
{
	createthreatbiasgroup("squad");
	createthreatbiasgroup("pilots");
	createthreatbiasgroup("enemies");
	level.ilana setthreatbiasgroup("squad");
	level.cormack setthreatbiasgroup("squad");
	setthreatbias("enemies","squad",-900);
	setthreatbias("enemies","pilots",90000000);
	common_scripts\utility::flag_wait("start_shooting_at_squad");
	maps\_utility::clearthreatbias("enemies","squad");
	maps\_utility::clearthreatbias("enemies","pilots");
}

//Function Number: 33
lake_upper_deck()
{
	var_00 = level.cormack.accuracy;
	var_01 = level.cormack.baseaccuracy;
	level.player.ignoreme = 1;
	level.ilana.ignoreall = 1;
	level.cormack.ignoreall = 1;
	level.cormack.accuracy = 100000;
	level.cormack.baseaccuracy = 10000;
	level.ilana.accuracy = 100000;
	level.ilana.baseaccuracy = 10000;
	common_scripts\utility::flag_wait("ice_lake_start_combat");
	wait(2);
	common_scripts\utility::flag_set("obj_start_recover_cargo");
	level.ilana.ignoreme = 0;
	level.ilana.ignoreall = 0;
	level.ilana.accuracy = var_00;
	level.ilana.baseaccuracy = var_01;
	level.cormack.baseaccuracy = var_01;
	level.cormack.ignoreme = 0;
	level.cormack.ignoreall = 0;
	level.cormack.accuracy = var_00;
	common_scripts\utility::flag_wait("ice_lake_new_move_up");
	level.player.ignoreme = 0;
}

//Function Number: 34
ice_lake_wave_0()
{
	thread ice_lake_wave_0_crate();
	thread ice_lake_wave_0_amb();
	thread ice_lake_wave_0_patrol();
}

//Function Number: 35
ice_lake_wave_0_crate()
{
	var_00 = undefined;
	if(level.nextgen)
	{
		var_00 = maps\_utility::array_spawn_targetname("ice_attack_initial_crate",1);
	}
	else
	{
		var_00 = maps\_utility::array_spawn_targetname_cg("ice_attack_initial_crate",1,0.1);
	}

	var_01 = getent("NODE_lake_scene_vtol","targetname");
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		if(isdefined(var_00[var_02]) && isalive(var_00[var_02]))
		{
			var_00[var_02].ignoreall = 0;
			var_00[var_02].animname = "enemy" + var_02 + 1;
		}
	}

	if(isdefined(var_00[0]) && isalive(var_00[0]))
	{
		var_01 thread maps\_anim::anim_loop_solo(var_00[0],"lake_idle","crate_stop");
	}

	if(isdefined(var_00[1]) && isalive(var_00[1]))
	{
		var_01 thread maps\_anim::anim_loop_solo(var_00[1],"lake_idle","crate_stop");
	}

	common_scripts\utility::flag_wait("ice_lake_start_scene");
	foreach(var_04 in var_00)
	{
		if(isdefined(var_04) && isalive(var_04))
		{
			var_04 thread ice_lake_wakeup();
			var_04 thread ice_lake_kill();
		}
	}

	common_scripts\utility::flag_wait_or_timeout("ice_lake_start_combat",20);
	common_scripts\utility::flag_wait("ice_lake_start_combat");
	level.ilana.ignoreall = 0;
	if(!common_scripts\utility::flag("ice_lake_start_combat"))
	{
		wait(1);
		common_scripts\utility::flag_set("ice_lake_start_combat");
	}

	var_01 notify("crate_stop");
	if(isdefined(var_00[0]) && isalive(var_00[0]))
	{
		var_01 thread maps\_anim::anim_single_solo(var_00[0],"lake_idle_run");
	}

	if(isdefined(var_00[1]) && isalive(var_00[1]))
	{
		var_01 thread maps\_anim::anim_single_solo(var_00[1],"lake_idle_run");
	}
}

//Function Number: 36
ice_lake_wave_0_amb()
{
	var_00 = undefined;
	if(level.nextgen)
	{
		var_00 = maps\_utility::array_spawn_targetname("ice_attack_initial",1);
	}
	else
	{
		var_00 = maps\_utility::array_spawn_targetname_cg("ice_attack_initial",1,0.1);
	}

	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(isdefined(var_00[var_01]) && isalive(var_00[var_01]))
		{
			var_00[var_01].ignoreall = 0;
			var_00[var_01].animname = "lakeguy";
			var_00[var_01].animation = "lake_ambience" + var_01;
			var_00[var_01].reactionanim = "lake_sniped" + var_01;
			var_00[var_01].canjumppath = 5;
			var_02 = getent("NODE_lake_scene_vtol","targetname");
			var_02 thread maps\_anim::anim_loop_solo(var_00[var_01],var_00[var_01].animation,"crate_stop");
		}
	}

	common_scripts\utility::flag_wait("ice_lake_start_scene");
	foreach(var_04 in var_00)
	{
		if(isdefined(var_04) && isalive(var_04))
		{
			var_04 thread ice_lake_wakeup_noreaction();
			var_04 thread ice_lake_kill();
		}
	}
}

//Function Number: 37
ice_lake_wave_0_patrol()
{
	var_00 = undefined;
	if(level.nextgen)
	{
		var_00 = maps\_utility::array_spawn_targetname("ice_lake_patrol",1);
	}
	else
	{
		var_00 = maps\_utility::array_spawn_targetname_cg("ice_lake_patrol",1,0.1);
	}

	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(isdefined(var_00[var_01]) && isalive(var_00[var_01]))
		{
			var_00[var_01].ignoreall = 1;
			var_00[var_01].ignoresuppression = 1;
			var_00[var_01].goalradius = 32;
			var_00[var_01].animname = "generic";
			var_00[var_01].canjumppath = 5;
			var_00[var_01].reactionanim = "lake_sniped" + var_01;
			maps\_utility::set_generic_idle_anim("casual_walk_idle");
			var_00[var_01].customarrivalfunc = ::custom_idle_trans_function;
			var_00[var_01].startidletransitionanim = level.scr_anim["generic"]["casual_walk_in"];
			self.permanentcustommovetransition = 1;
			self.custommovetransition = ::animscripts\cover_arrival::custommovetransitionfunc;
			self.startmovetransitionanim = level.scr_anim["generic"]["casual_walk_out"];
			var_00[var_01] thread maps\_utility::set_run_anim("casual_walk");
			var_00[var_01] thread maps\_utility::follow_path(getnode(var_00[var_01].target,"targetname"));
		}
	}

	common_scripts\utility::flag_wait("ice_lake_start_scene");
	foreach(var_03 in var_00)
	{
		if(isdefined(var_03) && isalive(var_03))
		{
			var_03 thread ice_lake_wakeup_reaction();
			var_03 thread ice_lake_kill();
		}
	}
}

//Function Number: 38
custom_idle_trans_function()
{
	if(!isdefined(self.startidletransitionanim))
	{
		return;
	}

	var_00 = self.approachnumber;
	var_01 = self.startidletransitionanim;
	if(!isdefined(self.heat))
	{
		thread animscripts\cover_arrival::abortapproachifthreatened();
	}

	self clearanim(%body,0.2);
	self setflaggedanimrestart("coverArrival",var_01,1,0.2,self.movetransitionrate);
	animscripts\face::playfacialanim(var_01,"run");
	animscripts\shared::donotetracks("coverArrival",::animscripts\cover_arrival::handlestartaim);
	var_02 = level.arrivalendstance[self.approachtype];
	if(isdefined(var_02))
	{
		self.a.pose = var_02;
	}

	self.a.movement = "stop";
	self.a.arrivaltype = self.approachtype;
	self clearanim(%root,0.3);
	self.lastapproachaborttime = undefined;
	var_03 = self.origin - self.goalpos;
}

//Function Number: 39
clear_custom_patrol_anim_set()
{
	maps\_utility::clear_generic_run_anim();
	maps\_utility::clear_generic_idle_anim();
	self.permanentcustommovetransition = undefined;
	self.custommovetransition = undefined;
	self.startmovetransitionanim = undefined;
	self.customarrivalfunc = undefined;
	self.startidletransitionanim = undefined;
	self allowedstances("stand","crouch","prone");
	if(isdefined(self.oldcombatmode))
	{
		self.combatmode = self.oldcombatmode;
	}
}

//Function Number: 40
ice_lake_wakeup()
{
	self endon("death");
	self addaieventlistener("grenade danger");
	self addaieventlistener("silenced_shot");
	self addaieventlistener("gunshot");
	self addaieventlistener("explode");
	self waittill("ai_event",var_00);
	common_scripts\utility::flag_set("ice_lake_start_combat");
	self.ignoreall = 0;
}

//Function Number: 41
ice_lake_wakeup_noreaction()
{
	self endon("death");
	thread ice_lake_wakeup_play_reaction();
	self addaieventlistener("grenade danger");
	self addaieventlistener("projectile_impact");
	self addaieventlistener("silenced_shot");
	self addaieventlistener("bulletwhizby");
	self addaieventlistener("gunshot");
	self addaieventlistener("gunshot_teammate");
	self addaieventlistener("explode");
	self waittill("ai_event",var_00);
	common_scripts\utility::flag_set("ice_lake_start_combat");
}

//Function Number: 42
ice_lake_wakeup_reaction()
{
	self endon("death");
	self addaieventlistener("grenade danger");
	self addaieventlistener("projectile_impact");
	self addaieventlistener("silenced_shot");
	self addaieventlistener("bulletwhizby");
	self addaieventlistener("gunshot");
	self addaieventlistener("gunshot_teammate");
	self addaieventlistener("explode");
	self waittill("ai_event",var_00);
	common_scripts\utility::flag_set("ice_lake_start_combat");
	self.ignoreall = 0;
	clear_custom_patrol_anim_set();
	maps\_utility::clear_run_anim();
	self notify("_utility::follow_path");
	wait 0.05;
	thread maps\_anim::anim_single_solo(self,self.reactionanim);
	thread lake_handle_vol_movement();
}

//Function Number: 43
ice_lake_wakeup_play_reaction()
{
	self endon("death");
	var_00 = getent("NODE_lake_scene_vtol","targetname");
	common_scripts\utility::flag_wait("ice_lake_start_combat");
	self.ignoreall = 0;
	maps\_utility::anim_stopanimscripted();
	wait 0.05;
	var_00 thread maps\_anim::anim_single_solo(self,self.reactionanim);
}

//Function Number: 44
ice_lake_kill()
{
	self endon("death");
	self waittill("damage");
	common_scripts\utility::flag_set("ice_lake_start_combat");
	maps\_utility::anim_stopanimscripted();
	self kill();
}

//Function Number: 45
ice_lake_wave_1()
{
	level endon("ice_lake_new_move_up");
	common_scripts\utility::flag_wait("ice_lake_start_combat");
	level endon("player_advanced_ahead");
	wait(5);
	var_00 = getent("VOL_ice_lake_wave_1","targetname");
	var_01 = undefined;
	if(level.nextgen)
	{
		var_01 = maps\_utility::array_spawn_targetname("ice_attack_wave_1",1);
	}
	else
	{
		var_01 = maps\_utility::array_spawn_targetname_cg("ice_attack_wave_1",1,0.1);
	}

	var_02 = zippers_spawner("ice_attack_wave_1_zipline");
	var_03 = undefined;
	if(level.nextgen)
	{
		var_03 = maps\_utility::array_spawn_targetname("ice_attack_wave_1_cover",1);
	}
	else
	{
		var_03 = maps\_utility::array_spawn_targetname_cg("ice_attack_wave_1_cover",1,0.1);
	}

	var_04 = common_scripts\utility::array_combine(var_01,var_02);
	var_04 = common_scripts\utility::array_combine(var_04,var_03);
	foreach(var_06 in var_04)
	{
		if(isdefined(var_06) && isalive(var_06))
		{
			var_06.script_noteworthy = "ice_attack_wave_1";
			var_06.ignoresuppression = 1;
			var_06.canjumppath = 5;
			var_06 setthreatbiasgroup("enemies");
			var_06 thread lake_handle_vol_movement();
		}
	}

	foreach(var_09 in var_03)
	{
		if(isdefined(var_09) && isalive(var_09))
		{
			var_09.goalradius = 0;
			var_09 thread maps\_deployablecoverai::handle_deployable_cover("lake_deployablecover");
			var_09 thread handle_volume_assign();
			wait(1);
		}
	}

	var_04 = maps\_utility::remove_dead_from_array(var_04);
	maps\_utility::waittill_dead_or_dying(var_04,2);
	var_0B = maps\crash_utility::spawn_wave_stagger("ice_attack_wave_support",1,var_00);
	var_0C = undefined;
	if(level.nextgen)
	{
		var_0C = maps\_utility::array_spawn_targetname("ice_attack_wave_support_cover",1);
	}
	else
	{
		var_0C = maps\_utility::array_spawn_targetname_cg("ice_attack_wave_support_cover",1,0.1);
	}

	var_0D = common_scripts\utility::array_combine(var_0B,var_0C);
	var_0E = getent("VOL_ice_lake_wave_3","targetname");
	foreach(var_06 in var_0D)
	{
		if(isdefined(var_06) && isalive(var_06))
		{
			var_06.script_noteworthy = "ice_attack_wave_1_back";
			var_06.ignoresuppression = 1;
			var_06.canjumppath = 5;
			var_06 setthreatbiasgroup("enemies");
			var_06 thread lake_handle_vol_movement();
		}
	}

	foreach(var_09 in var_0C)
	{
		if(isdefined(var_09) && isalive(var_09))
		{
			var_09.goalradius = 0;
			var_09 thread maps\_deployablecoverai::handle_deployable_cover("lake_deployablecover");
			var_09 thread handle_volume_assign();
			wait(1);
		}
	}

	thread wave_1_logic();
	var_13 = common_scripts\utility::array_combine(var_04,var_0D);
	var_13 = maps\_utility::array_removedead(var_13);
	maps\_utility::waittill_dead_or_dying(var_13,5);
	maps\_utility::activate_trigger("ice_lake_cormack_moveup1","targetname");
	common_scripts\utility::flag_wait("obj_start_recover_cargo");
	common_scripts\utility::flag_set("ice_lake_wave_1_done");
}

//Function Number: 46
handle_volume_assign()
{
	self waittill("deployable_finished");
	thread lake_handle_vol_movement();
}

//Function Number: 47
zippers_spawner(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	var_02 = [];
	wait(0.5);
	foreach(var_04 in var_01)
	{
		var_05 = animscripts\traverse\seoul_zipline::spawn_npc_and_use_scripted_zipline(var_04,common_scripts\utility::getstruct(var_04.target,"targetname"));
		var_02[var_02.size] = var_05;
		var_05.ignoresuppression = 1;
		var_05.canjumppath = 5;
		var_05 setthreatbiasgroup("enemies");
		var_05 thread lake_handle_vol_movement();
		wait(randomfloatrange(0.1,0.25));
	}

	return var_02;
}

//Function Number: 48
wave_1_logic()
{
	level endon("ice_lake_new_move_up");
	var_00 = getent("VOL_ice_lake_wave_1","targetname");
	var_01 = 1;
	while(var_01)
	{
		var_02 = maps\_utility::get_living_ai_array("ice_attack_wave_1","script_noteworthy");
		var_03 = maps\_utility::get_living_ai_array("ice_attack_wave_1_back","script_noteworthy");
		if(var_03.size == 0)
		{
			var_01 = 0;
		}

		if(var_02.size < var_03.size)
		{
			if(isalive(var_03[0]))
			{
				var_03[0].script_noteworthy = "ice_attack_wave_1";
			}
		}

		wait(2);
	}
}

//Function Number: 49
ice_lake_wave_2()
{
	level endon("ice_lake_new_move_up");
	common_scripts\utility::flag_wait("ice_lake_wave_1_done");
	var_00 = getent("VOL_ice_lake_wave_2","targetname");
	var_01 = maps\crash_utility::spawn_wave_stagger("ice_attack_wave_support",1,var_00);
	createthreatbiasgroup("enemies_2");
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03) && isalive(var_03))
		{
			var_03.script_noteworthy = "ice_attack_wave_2";
			var_03.ignoresuppression = 1;
			var_03.canjumppath = 5;
			var_03 setthreatbiasgroup("enemies_2");
			var_03 thread lake_handle_vol_movement();
		}
	}

	createthreatbiasgroup("player");
	level.player setthreatbiasgroup("player");
	setthreatbias("enemies_2","player",-9000);
	thread ice_lake_clear();
	maps\_utility::waittill_dead_or_dying(var_01,3);
	common_scripts\utility::flag_wait("ice_lake_new_move_up");
	common_scripts\utility::flag_set("ice_lake_wave_2_done");
}

//Function Number: 50
ice_lake_clear()
{
	level endon("ice_lake_new_move_up");
	var_00 = getaiarray("axis");
	maps\_utility::waittill_dead_or_dying(var_00,var_00.size - 5);
	var_00 = getaiarray("axis");
	var_01 = getent("VOL_ice_lake_wave_cargo","targetname");
	foreach(var_03 in var_00)
	{
		var_03 setgoalvolumeauto(var_01);
		randomfloatrange(0.2,0.5);
	}

	level.cormack thread maps\_utility::smart_radio_dialogue("crsh_crmk_jumpdown3");
	var_00 = getaiarray("axis");
	maps\_utility::waittill_dead_or_dying(var_00,var_00.size);
	common_scripts\utility::flag_clear("ice_lake_callout_pause");
	maps\_utility::smart_radio_dialogue("crsh_iln_targetdown2");
	maps\_utility::activate_trigger("ice_lake_cormack_moveup1","targetname");
	maps\_utility::disable_trigger_with_targetname("ice_lake_cormack_moveup1");
	level.cormack maps\_utility::smart_radio_dialogue("crsh_crmk_getdownhere");
	var_05 = maps\_utility::make_array("crsh_crmk_needtoadvance","crsh_crmk_getdownhere");
	thread maps\crash_utility::nag_until_flag(var_05,"ice_lake_start_timer",2,3,10);
	common_scripts\utility::flag_wait("ice_lake_start_timer");
	maps\_utility::activate_trigger("ice_lake_moveup1","targetname");
	cormack_lake_callout_coverme();
	var_05 = maps\_utility::make_array("crsh_crmk_needtogetthatcargo","crsh_crmk_securecargo","crsh_iln_securecargo2");
	thread maps\crash_utility::nag_until_flag(var_05,"ice_lake_new_move_up",2,3,10);
}

//Function Number: 51
lake_reinforcements_1()
{
	level endon("ice_lake_new_move_up");
	for(;;)
	{
		var_00 = maps\_utility::get_living_ai_array("ice_attack_wave_1","script_noteworthy");
		if(var_00.size < 3)
		{
			var_01 = undefined;
			if(level.nextgen)
			{
				var_01 = maps\_utility::array_spawn_targetname("ice_attack_support_1",1);
			}
			else
			{
				var_01 = maps\_utility::array_spawn_targetname_cg("ice_attack_support_1",1,0.1);
			}

			foreach(var_03 in var_01)
			{
				if(isdefined(var_03) && isalive(var_03))
				{
					var_03.ignoresuppression = 1;
					var_03.script_noteworthy = "ice_attack_wave_1";
				}
			}

			wait(4);
		}

		wait(0.05);
	}
}

//Function Number: 52
lake_reinforcements_2()
{
	level endon("ice_lake_new_move_up");
	for(;;)
	{
		var_00 = maps\_utility::get_living_ai_array("ice_attack_wave_2","script_noteworthy");
		if(var_00.size < 2)
		{
			var_01 = undefined;
			if(level.nextgen)
			{
				var_01 = maps\_utility::array_spawn_targetname("ice_attack_support_2",1);
			}
			else
			{
				var_01 = maps\_utility::array_spawn_targetname_cg("ice_attack_support_2",1,0.1);
			}

			foreach(var_03 in var_01)
			{
				if(isdefined(var_03) && isalive(var_03))
				{
					var_03.ignoresuppression = 1;
					var_03.script_noteworthy = "ice_attack_wave_2";
				}
			}

			wait(4);
		}

		wait(0.05);
	}
}

//Function Number: 53
ice_lake_wave_3()
{
	level endon("lake_start_collapse");
	common_scripts\utility::flag_wait_either("ice_lake_wave_2_done","ice_lake_new_move_up");
	common_scripts\utility::flag_set("cargo_captured");
	common_scripts\utility::flag_set("obj_end_lake_sniper_rifle");
	var_00 = getent("VOL_ice_lake_wave_3a","targetname");
	var_01 = zippers_spawner("ice_attack_wave_2_zipline");
	wait(3);
	var_02 = undefined;
	if(level.nextgen)
	{
		var_03 = maps\_utility::array_spawn_targetname("ice_attack_final",1);
	}
	else
	{
		var_03 = maps\_utility::array_spawn_targetname_cg("ice_attack_final",1,0.1);
	}

	foreach(var_05 in var_03)
	{
		if(isdefined(var_05) && isalive(var_05))
		{
			var_05.ignoresuppression = 1;
			var_05.script_noteworthy = "ice_attack";
			var_05.canjumppath = 5;
			var_05 thread lake_handle_vol_movement();
		}
	}

	wait(5);
	var_07 = undefined;
	if(level.nextgen)
	{
		var_07 = maps\_utility::array_spawn_targetname("ice_attack_final_back",1);
	}
	else
	{
		var_07 = maps\_utility::array_spawn_targetname("ice_attack_final_back",1,0.1);
	}

	foreach(var_05 in var_07)
	{
		if(isdefined(var_05) && isalive(var_05))
		{
			var_05.ignoresuppression = 1;
			var_05.script_noteworthy = "ice_attack";
			var_05.canjumppath = 5;
			var_05 thread lake_handle_vol_movement();
		}
	}

	var_02 = getaiarray("axis");
	maps\_utility::waittill_dead_or_dying(var_02,var_02.size - 5);
	var_00 = getent("VOL_ice_lake_wave_cargo","targetname");
	var_02 = maps\_utility::remove_dead_from_array(var_02);
	foreach(var_0B in var_02)
	{
		var_0B setgoalvolumeauto(var_00);
		randomfloatrange(0.2,0.5);
	}

	level.ilana maps\_utility::smart_radio_dialogue("crsh_iln_securecargo2");
	var_02 = getaiarray("axis");
	maps\_utility::waittill_dead_or_dying(var_02,var_02.size);
	common_scripts\utility::flag_clear("ice_lake_callout_pause");
	maps\_utility::smart_radio_dialogue("crsh_iln_allclear3");
	common_scripts\utility::flag_set("ice_lake_wave_3_done");
}

//Function Number: 54
lake_reinforcements_final()
{
	level endon("lake_start_left");
	var_00 = getent("VOL_ice_lake_wave_3","targetname");
	wait(10);
	for(;;)
	{
		var_01 = maps\_utility::get_living_ai_array("ice_attack","script_noteworthy");
		if(var_01.size < 4)
		{
			var_02 = undefined;
			if(level.nextgen)
			{
				var_02 = maps\_utility::array_spawn_targetname("ice_attack_wave_support",1);
			}
			else
			{
				var_02 = maps\_utility::array_spawn_targetname_cg("ice_attack_wave_support",1,0.1);
			}

			foreach(var_04 in var_02)
			{
				if(isdefined(var_04) && isalive(var_04))
				{
					var_04.ignoresuppression = 1;
					var_04.script_noteworthy = "ice_attack";
					var_04 setgoalvolumeauto(var_00);
				}
			}

			wait(4);
		}

		wait(0.05);
	}
}

//Function Number: 55
lake_handle_vol_movement()
{
	if(isdefined(self.target))
	{
		var_00 = strtok(self.target,"VOL_ice_lake_wave_3");
		if(isdefined(var_00) && isdefined(var_00[0]))
		{
			if(var_00[0] == "1" || var_00[0] == "2" || var_00[0] == "3")
			{
				thread lake_vol_movement();
				return;
			}
		}
	}
}

//Function Number: 56
lake_vol_movement()
{
	self endon("death");
	var_00 = getent("VOL_ice_lake_wave_3a","targetname");
	var_01 = getent("VOL_ice_lake_wave_3b","targetname");
	var_02 = getent("VOL_ice_lake_wave_3c","targetname");
	for(;;)
	{
		wait(10);
		var_03 = randomintrange(0,3);
		if(var_03 == 0)
		{
			self setgoalvolumeauto(var_00);
			continue;
		}

		if(var_03 == 1)
		{
			self setgoalvolumeauto(var_01);
			continue;
		}

		self setgoalvolumeauto(var_02);
	}
}

//Function Number: 57
lake_fall_in(param_00)
{
	common_scripts\utility::flag_wait("lake_start_left");
	if(!isdefined(param_00))
	{
		thread maps\_utility::autosave_now_silent();
		level.player enableinvulnerability();
		level.player maps\_player_high_jump::disable_high_jump();
		level.player allowpowerslide(0);
		level.player allowdodge(0);
		level.player maps\crash_utility::disable_exo_melee();
		level.cormack thread maps\_utility::smart_radio_dialogue("crsh_crmk_missilesfired");
		var_01 = 400;
		var_02 = 150;
		var_03 = level.lake_chopper.origin - (0,0,32);
		level.lake_chopper.old_contents = level.lake_chopper setcontents(0);
		var_04 = level.player common_scripts\utility::spawn_tag_origin();
		var_05 = level.player.origin;
		var_06 = level.player getplayerangles();
		var_07 = var_06[1];
		var_04.origin = (var_02 * cos(var_07) + var_05[0],var_02 * sin(var_07) + var_05[1],var_05[2]);
		var_08 = common_scripts\utility::getstruct("csh_lake_repulsor","targetname");
		var_09 = common_scripts\utility::getstruct("csh_lake_repulsor2","targetname");
		var_0A = missile_createrepulsororigin(var_08.origin,10000,500);
		var_0B = missile_createrepulsororigin(var_09.origin,100000,75);
		var_0C = missile_createattractororigin(common_scripts\utility::drop_to_ground(var_04.origin - (0,0,100)),20000,1000);
		wait 0.05;
		var_0D = level.lake_chopper gettagorigin("jnt_launcherbracket_l");
		var_0E = level.lake_chopper gettagorigin("jnt_launcherbracket_r");
		var_0F = magicbullet("iw5_mahemstraight_sp",var_0D,var_04.origin);
		var_10 = magicbullet("iw5_mahemstraight_sp",var_0E,var_04.origin);
		thread vtol_fire_late_rpgs(var_04);
		soundscripts\_snd::snd_message("missile_fire",var_0F,var_10,var_04.origin);
		wait(0.1);
		var_10 common_scripts\utility::waittill_notify_or_timeout("death",2);
		soundscripts\_snd::snd_message("lake_fall_in");
		level notify("player_fell_in_lake");
		level.player maps\_player_high_jump::enable_high_jump();
		level.player allowpowerslide(1);
		level.player allowdodge(1);
	}

	common_scripts\utility::flag_set("lake_done");
	wait(0.25);
	common_scripts\utility::flag_set("go_gideon_moment");
	common_scripts\utility::flag_set("obj_lake_fall");
	wait(2);
	var_11 = getaiarray("axis");
	foreach(var_13 in var_11)
	{
		if(isdefined(var_13) && isalive(var_13))
		{
			if(isdefined(var_13.magic_bullet_shield) && var_13.magic_bullet_shield)
			{
				var_13 maps\_utility::stop_magic_bullet_shield();
			}

			var_13.dontdropweapon = 1;
			var_13 delete();
		}
	}

	maps\crash_utility::cleanup_enemies("ice_attack",1);
	maps\crash_utility::cleanup_enemies("ice_attack_wave_1_back",1);
	if(level.currentgen)
	{
		maps\crash_utility::cleanup_enemies("ice_attack_wave_1_noDelete",1);
	}

	maps\crash_utility::cleanup_enemies("ice_attack_wave_1",1);
	maps\crash_utility::cleanup_enemies("ice_attack_wave_2",1);
	maps\crash_utility::cleanup_enemies("ice_attack_goliath",1);
	maps\crash_utility::cleanup_enemies("ice_attack_bonus",1);
	clearallcorpses();
	maps\crash_utility::cleanupweaponsonground();
}

//Function Number: 58
vtol_fire_late_rpgs(param_00)
{
	wait(0.75);
	var_01 = level.lake_chopper gettagorigin("jnt_launcherbracket_l");
	var_02 = level.lake_chopper gettagorigin("jnt_launcherbracket_r");
	var_03 = level.player.origin;
	var_04 = level.player getplayerangles();
	var_05 = var_04[1];
	var_06 = 150;
	param_00.origin = (var_06 * cos(var_05) + var_03[0],var_06 * sin(var_05) + var_03[1],var_03[2]);
	magicbullet("iw5_mahemstraight_sp",var_01,param_00.origin - (0,0,100));
	magicbullet("iw5_mahemstraight_sp",var_02,param_00.origin - (0,0,100));
	wait(0.75);
	var_01 = level.lake_chopper gettagorigin("jnt_launcherbracket_l");
	var_02 = level.lake_chopper gettagorigin("jnt_launcherbracket_r");
	var_03 = level.player.origin;
	var_04 = level.player getplayerangles();
	var_05 = var_04[1];
	var_06 = 150;
	param_00.origin = (var_06 * cos(var_05) + var_03[0],var_06 * sin(var_05) + var_03[1],var_03[2]);
	magicbullet("iw5_mahemstraight_sp",var_01,param_00.origin - (0,0,200));
	magicbullet("iw5_mahemstraight_sp",var_02,param_00.origin - (0,0,200));
	wait(2);
	level.player disableinvulnerability();
}

//Function Number: 59
ice_lake_chopper()
{
	var_00 = getent("NODE_lake_scene_vtol","targetname");
	var_01 = maps\_utility::spawn_anim_model("vtol");
	level.lake_chopper = var_01;
	var_02 = maps\_utility::spawn_anim_model("pulley");
	var_02 notsolid();
	var_03 = maps\_utility::spawn_anim_model("crate");
	var_03 notsolid();
	level.cargo = var_03;
	var_00 thread maps\_anim::anim_loop_solo(var_03,"lake_loop","stop_wait_loop");
	var_00 thread handle_cargo_shut(var_03);
	common_scripts\utility::flag_wait("ice_lake_start_timer");
	thread lake_scene_fail_timeout();
	common_scripts\utility::flag_wait_any("lake_lift_off","lake_player_fail");
	soundscripts\_snd::snd_message("lake_warbird_approaches");
	var_04 = undefined;
	if(level.nextgen)
	{
		var_04 = maps\_utility::array_spawn_targetname("ice_attack_hookup_crate",1);
	}
	else
	{
		var_04 = maps\_utility::array_spawn_targetname("ice_attack_hookup_crate",1,0.1);
	}

	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		if(isdefined(var_04[var_05]) && isalive(var_04[var_05]))
		{
			var_04[var_05].ignoreall = 0;
			var_04[var_05].animname = "enemy" + var_05 + 1;
			var_04[var_05] thread ice_lake_kill();
			var_00 thread maps\_anim::anim_single_solo(var_04[var_05],"lake_hookup");
		}
	}

	var_06 = [var_01,var_02];
	var_00 maps\_anim::anim_single(var_06,"lake_hookup");
	var_06 = [var_01,var_02,var_03];
	var_00 thread maps\_anim::anim_loop(var_06,"lake_loop","stop_wait_loop");
	maps\_utility::activate_trigger("ice_lake_moveup1","targetname");
	var_00 notify("stop_wait_loop");
	var_00 thread maps\_anim::anim_loop_solo(var_03,"lake_hookup_loop","stop_wait_loop");
	var_00 thread maps\_anim::anim_single_solo(var_01,"lake_turn");
	var_00 maps\_anim::anim_single_solo(var_02,"lake_turn");
	var_00 notify("stop_wait_loop");
	var_00 thread maps\_anim::anim_loop(var_06,"lake_hookup_loop","stop_wait_loop");
	common_scripts\utility::flag_wait_any("lake_start_left","lake_player_fail");
	wait 0.05;
	if(common_scripts\utility::flag("lake_player_fail"))
	{
		var_00 notify("stop_wait_loop");
		var_00 thread maps\_anim::anim_single(var_06,"lake_takeoff");
		wait(3);
		setdvar("ui_deadquote",&"CRASH_FAIL_CARGO");
		maps\_utility::missionfailedwrapper();
		return;
	}

	wait(3);
	var_07 = getent("ice_lake_crate_clip","targetname");
	var_07 delete();
	var_01 delete();
	var_02 delete();
	var_03 delete();
}

//Function Number: 60
handle_cargo_shut(param_00)
{
	common_scripts\utility::flag_wait("ice_lake_start_combat");
	self notify("stop_wait_loop");
	maps\_anim::anim_single_solo(param_00,"lake_shut");
	thread maps\_anim::anim_loop_solo(param_00,"lake_hookup_loop","stop_wait_loop");
}

//Function Number: 61
lake_scene_fail_timeout()
{
	wait(60);
	common_scripts\utility::flag_set("lake_lift_off");
	wait(45);
	common_scripts\utility::flag_set("lake_player_fail");
}

//Function Number: 62
ic_underwater_visionset_change(param_00)
{
	if(param_00)
	{
		var_01 = 1;
		level.player maps\_utility::vision_set_fog_changes("crash_lake_underwater",2);
		level.player setclutforplayer("clut_crash_underwater",2);
		setsunflareposition((-31,-169,0));
		level.player enablephysicaldepthoffieldscripting();
		level.player setphysicaldepthoffield(4.32,40.9,1,1);
		maps\_water::set_light_set_for_player("crash_lake_fallin_02");
		if(isdefined(level.dofunderwater))
		{
			thread maps\_water::setdof(level.dofunderwater);
		}

		playfx(common_scripts\utility::getfx("water_screen_plunge"),self.origin);
		self setwatersheeting(0);
		maps\_water::setunderwateraudiozone();
		self playlocalsound("underwater_enter");
		return;
	}

	maps\_water::revertvisionsetforplayer(0);
	maps\_water::set_light_set_for_player("crash_avalanche");
	if(isdefined(level.dofdefault))
	{
		thread maps\_water::setdof(level.dofdefault);
	}

	level.player maps\_utility::vision_set_fog_changes("crash_avalanche_cinematic",2);
	level.player setclutforplayer("clut_crash_crash_site",2);
	level.player disablephysicaldepthoffieldscripting();
	playfx(common_scripts\utility::getfx("water_screen_emerge"),self.origin);
	self setwatersheeting(1,1);
	maps\_water::clearunderwateraudiozone();
	self playlocalsound("breathing_better");
	self playlocalsound("underwater_exit");
	var_02 = undefined;
	if(isdefined(self.water_trigger_current))
	{
		var_02 = maps\_water::getwaterline(self.water_trigger_current);
	}

	if(isdefined(var_02))
	{
		var_03 = (self.origin[0],self.origin[1],var_02);
		playfx(level._effect["water_splash_emerge"],var_03,anglestoforward((0,self.angles[1],0) + (270,180,0)));
	}
}

//Function Number: 63
lake_dialogue()
{
	level endon("lake_start_left");
	maps\_utility::battlechatter_off("allies");
	thread lake_dialogue_start();
	common_scripts\utility::flag_wait("ice_lake_start_combat");
	soundscripts\_snd::snd_music_message("lake_combat");
	wait(1);
	thread maps\_utility::autosave_by_name("ice_lake_combat_start");
	maps\_utility::smart_radio_dialogue("crsh_crmk_openfire7");
	common_scripts\utility::flag_set("ice_lake_cormack_movedown");
	thread maps\_utility::activate_trigger("lake_cormack_move_down","targetname");
	thread lake_callouts();
	maps\_utility::smart_radio_dialogue("crsh_crmk_needcargo3");
	common_scripts\utility::flag_wait("lake_lift_off");
	thread maps\_utility::autosave_by_name("lake_lift_off");
	level.player.ignoreme = 0;
	maps\_utility::smart_radio_dialogue("crsh_iln_vtolincoming");
	maps\_utility::smart_radio_dialogue("crsh_crmk_needtogetthatcargo");
	wait(3);
	maps\_utility::smart_radio_dialogue("crsh_crmk_hookingupcargo");
	common_scripts\utility::flag_set("ice_lake_callout_pause");
	wait(12);
	maps\_utility::smart_radio_dialogue("crsh_iln_vtoltakeoff");
	var_00 = maps\_utility::make_array("crsh_crmk_needtogetthatcargo","crsh_crmk_securecargo","crsh_iln_vtoltakeoff","crsh_iln_securecargo2");
	thread maps\crash_utility::nag_until_flag(var_00,"lake_start_left",10,15,10);
}

//Function Number: 64
lake_dialogue_start()
{
	level endon("ice_lake_start_combat");
	common_scripts\utility::flag_wait("lake_vo_start");
	maps\_utility::smart_radio_dialogue("crsh_crmk_deadahead");
	maps\_utility::smart_radio_dialogue("crsh_iln_gotcargo5");
	maps\_utility::smart_radio_dialogue("crsh_crmk_intercept");
	maps\_utility::smart_radio_dialogue("crsh_kp_sendingexfil");
	common_scripts\utility::flag_set("ice_lake_cormack_movedown");
	thread maps\_utility::activate_trigger("lake_cormack_move_down","targetname");
	maps\_utility::smart_radio_dialogue("crsh_crmk_drawthemout");
	maps\_utility::smart_radio_dialogue("crsh_crmk_inposition");
	level.cormack maps\_utility::smart_radio_dialogue("crsh_crmk_onyourshot");
	var_00 = maps\_utility::make_array("crsh_crmk_takeshot","crsh_crmk_onyourshot");
	thread maps\crash_utility::nag_until_flag(var_00,"ice_lake_start_combat",10,15,10);
}

//Function Number: 65
lake_callouts()
{
	level endon("lake_start_left");
	common_scripts\utility::flag_set("ice_lake_callout_pause");
	wait(3);
	var_00 = getent("ice_lake_callout_cargo_VOL","targetname");
	var_01 = getent("ice_lake_callout_left_VOL","targetname");
	var_02 = getent("ice_lake_callout_right_VOL","targetname");
	var_03 = getent("ice_lake_callout_front_VOL","targetname");
	var_04 = undefined;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = undefined;
	for(;;)
	{
		var_08 = var_00 maps\_utility::get_ai_touching_volume("axis");
		var_09 = var_03 maps\_utility::get_ai_touching_volume("axis");
		var_0A = var_01 maps\_utility::get_ai_touching_volume("axis");
		var_0B = var_02 maps\_utility::get_ai_touching_volume("axis");
		common_scripts\utility::flag_wait("ice_lake_callout_pause");
		if(isdefined(var_08) && !isdefined(var_04))
		{
			var_04 = 1;
			var_0C = randomint(3);
			if(var_0C == 0)
			{
				ilana_lake_callout_cargo();
			}
			else if(var_0C == 1)
			{
				if(common_scripts\utility::cointoss())
				{
					cormack_lake_callout_cargo();
				}
			}
			else if(var_0C == 2)
			{
				cormack_lake_callout_stop();
			}
		}
		else if(isdefined(var_09) && !isdefined(var_05))
		{
			var_05 = 1;
			var_0C = randomint(3);
			if(var_0C == 0)
			{
				cormack_lake_callout_cover();
			}
			else if(var_0C == 1)
			{
				cormack_lake_callout_coverme();
			}
			else if(var_0C == 2)
			{
				cormack_lake_callout_pin();
			}

			if(common_scripts\utility::cointoss())
			{
				ilana_lake_callout_shot();
			}
		}
		else if(isdefined(var_0A) && !isdefined(var_06))
		{
			var_06 = 1;
			if(common_scripts\utility::cointoss())
			{
				ilana_lake_callout_left();
			}

			var_04 = undefined;
			var_05 = undefined;
			var_07 = undefined;
		}
		else if(isdefined(var_0B) && !isdefined(var_07))
		{
			var_07 = 1;
			if(common_scripts\utility::cointoss())
			{
				ilana_lake_callout_right();
			}

			var_04 = undefined;
			var_05 = undefined;
			var_06 = undefined;
		}

		var_08 = undefined;
		var_09 = undefined;
		var_0A = undefined;
		var_0B = undefined;
		wait(randomfloatrange(4,10));
	}
}

//Function Number: 66
cormack_lake_callout_cargo()
{
	level endon("lake_start_collapse");
	maps\_utility::smart_radio_dialogue("crsh_crmk_needtogetthatcargo");
}

//Function Number: 67
cormack_lake_callout_downhere()
{
	level endon("lake_start_collapse");
	maps\_utility::smart_radio_dialogue("crsh_crmk_getdownhere");
}

//Function Number: 68
cormack_lake_callout_goliath()
{
	level endon("lake_start_collapse");
	maps\_utility::smart_radio_dialogue("crsh_crmk_keephitting");
}

//Function Number: 69
cormack_lake_callout_coverme()
{
	level endon("lake_start_collapse");
	maps\_utility::smart_radio_dialogue("crsh_crmk_movingpos");
}

//Function Number: 70
cormack_lake_callout_stop()
{
	level endon("lake_start_collapse");
	maps\_utility::smart_radio_dialogue("crsh_crmk_getthecargo");
}

//Function Number: 71
cormack_lake_callout_pin()
{
	level endon("lake_start_collapse");
	maps\_utility::smart_radio_dialogue("crsh_crmk_pinemdown");
}

//Function Number: 72
cormack_lake_callout_cover()
{
	level endon("lake_start_collapse");
	maps\_utility::smart_radio_dialogue("crsh_crmk_coverfire");
}

//Function Number: 73
cormack_lake_callout_rpg()
{
	level.cormack maps\_utility::smart_dialogue("crsh_crmk_caveentrance");
}

//Function Number: 74
ilana_lake_callout_right()
{
	maps\_utility::smart_radio_dialogue("crsh_iln_totheright");
}

//Function Number: 75
ilana_lake_callout_cave()
{
	maps\_utility::smart_radio_dialogue("crsh_iln_caveentrance");
}

//Function Number: 76
ilana_lake_callout_left()
{
	maps\_utility::smart_radio_dialogue("crsh_iln_lookleft");
}

//Function Number: 77
ilana_lake_callout_shot()
{
	maps\_utility::smart_radio_dialogue("crsh_iln_takingtheshot");
}

//Function Number: 78
ilana_lake_callout_goliath()
{
	maps\_utility::smart_radio_dialogue("crsh_iln_goliaths_incoming");
}

//Function Number: 79
ilana_lake_callout_cargo()
{
	maps\_utility::smart_radio_dialogue("crsh_iln_moreofthem");
}

//Function Number: 80
begin_lake_cinema()
{
	level.lake_scene_anim_node = getent("NODE_lake_scene","targetname");
	thread ice_lake_cinema_heli();
	thread lake_cinema_player();
	maps\_utility::battlechatter_off("axis");
	maps\_utility::battlechatter_off("allies");
	thread ignore_friendlies();
	level waittill("start_lake_npcs");
	level.gideon = maps\crash_utility::spawn_ally("gideon","gideon_gideon");
	level.gideon.canjumppath = 1;
	level.gideon thread lake_cinema_gideon();
	level.cormack thread lake_cinema_cormack();
	level.ilana thread lake_cinema_ilona();
	thread lake_cinema_enemies();
	common_scripts\utility::flag_wait("lake_cinema_done");
}

//Function Number: 81
lake_cinema_player()
{
	common_scripts\utility::flag_wait("go_gideon_moment");
	common_scripts\utility::flag_set("lake_underwater_lighting");
	level.player hideviewmodel();
	level.player disableweapons();
	maps\_shg_utility::disable_features_entering_cinema(1);
	wait 0.05;
	var_00 = maps\_utility::spawn_anim_model("rig_hands",level.player.origin,level.player.angles);
	var_01 = level.player common_scripts\utility::spawn_tag_origin();
	var_02 = common_scripts\utility::getstruct("lake_fall_water_struct","targetname");
	level.player playerlinktodelta(var_00,"tag_player",1,0,0,0,0);
	level.player maps\_utility::delaythread(1,::maps\_hud_util::fade_out,0.2,"black");
	level.player setstance("stand");
	level.player allowcrouch(0);
	level.player allowprone(0);
	var_01 maps\_anim::anim_single_solo(var_00,"lake_fall");
	var_00 delete();
	var_03 = level.player common_scripts\utility::spawn_tag_origin();
	var_03.origin = (var_02.origin[0],var_02.origin[1],var_03.origin[2]);
	level.player playerlinktodelta(var_03,"tag_origin",1,25,25,25,0);
	var_03 rotateto(var_02.angles,0.1);
	thread falling_bits_fx();
	playfxontag(level._effect["player_bubbles"],var_03,"tag_origin");
	playfx(level._effect["water_splash_enter"],var_03.origin,anglestoforward((0,level.player.angles[1],0) + (270,180,0)));
	playfx(level._effect["water_screen_plunge"],var_03.origin,anglestoforward((0,level.player.angles[1],0) + (270,180,0)));
	wait(0.1);
	var_03 moveto(var_02.origin,1.5,0,0.5);
	playfxontag(level._effect["player_bubbles"],var_03,"tag_origin");
	playfx(level._effect["water_splash_enter"],var_03.origin,anglestoforward((0,level.player.angles[1],0) + (270,180,0)));
	level.player thread maps\_hud_util::fade_in(0.25,"black");
	wait(0.5);
	playfxontag(level._effect["player_bubbles"],var_03,"tag_origin");
	playfx(level._effect["water_splash_enter"],var_03.origin,anglestoforward((0,level.player.angles[1],0) + (270,180,0)));
	level.player thread maps\crash_exo_temperature::set_external_temperature_over_time(level.temperature_water,6.5);
	level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time(40,6.5);
	level.player thread maps\crash_exo_temperature::set_operator_temperature_over_time(91.5,6.5);
	level.player.underwater = 1;
	thread player_swim_hint();
	wait(1);
	stopfxontag(level._effect["player_bubbles"],var_01,"tag_origin");
	level.player_breath_amount_use_rate = 4;
	level.player unlink();
	setsaveddvar("compass","1");
	wait(2);
	stopfxontag(level._effect["player_bubbles"],var_03,"tag_origin");
	var_01 delete();
	var_03 delete();
	common_scripts\utility::flag_wait("lake_underwater_exit_flag");
	soundscripts\_snd::snd_message("lake_exit");
	common_scripts\utility::flag_set("go_gideon_moment_save");
	common_scripts\utility::flag_set("obj_lake_gideon_save");
	thread maps\_utility::autosave_by_name("gideon_save");
	var_00 = maps\_utility::spawn_anim_model("rig2");
	var_00 hide();
	thread falling_bits_fx();
	var_04 = getent("NODE_water_fx","targetname") common_scripts\utility::spawn_tag_origin();
	var_05 = playfxontag(level._effect["player_bubbles"],var_00,"tag_origin");
	playfxontag(level._effect["water_splash_enter"],var_00,"tag_origin");
	common_scripts\utility::flag_clear("hide_player_snow_footprints");
	common_scripts\utility::flag_set("outdoors");
	level notify("start_lake_npcs");
	level.lake_scene_anim_node thread maps\_anim::anim_single_solo(var_00,"gideon_scene");
	level.player thread maps\crash_exo_temperature::set_external_temperature_over_time(level.temperature_outdoor,1.5);
	level.player thread maps\crash_exo_temperature::set_exo_temperature_over_time(level.exo_max,1.5);
	level.player thread maps\crash_exo_temperature::set_operator_temperature_over_time(98.6,1.5);
	level.player playerlinktoblend(var_00,"tag_origin",0.75);
	wait(0.5);
	level.player maps\_utility::ent_flag_set("water_trigger_paused");
	level.player notify("out_of_water");
	level.player maps\_water::disable_swim_or_underwater_walk();
	level.player shellshock("crash_goliath_hit",0.25);
	level.player playerlinktodelta(var_00,"tag_player",1,10,10,10,5,1);
	var_00 show();
	var_06 = level.player maps\_utility::get_storable_weapons_list_primaries();
	level.player takeallweapons();
	stopfxontag(level._effect["player_bubbles"],var_00,"tag_origin");
	wait(1);
	common_scripts\utility::flag_set("go_lighting_gideon");
	var_00 waittillmatch("end","single anim");
	common_scripts\utility::flag_set("gideon_lighting_unlock");
	setsaveddvar("ammoCounterHide",0);
	setsaveddvar("actionSlotsHide",0);
	level.player unlink();
	var_00 delete();
	level.player allowcrouch(1);
	level.player allowprone(1);
	foreach(var_08 in var_06)
	{
		if(!issubstr(tolower(var_08),"s1_railgun"))
		{
			level.player giveweapon(var_08);
			continue;
		}

		level.player giveweapon("iw5_kf5_sp");
	}

	level.player switchtoweapon(var_06[0]);
	level.player showviewmodel();
	level.player enableweapons();
	level.player maps\_utility::blend_movespeedscale(0.5,0.5);
	thread maps\crash_exfil::vtol_takedown_failure();
	common_scripts\utility::flag_set("gideon_frees_you");
	level.player maps\_utility::ent_flag_clear("water_trigger_paused");
	wait(1);
	maps\_shg_utility::enable_features_exiting_cinema(1);
}

//Function Number: 82
delayplayfx(param_00,param_01,param_02,param_03)
{
	wait(param_00);
	playfxontag(param_01,param_02,param_03);
}

//Function Number: 83
falling_bits_fx()
{
	var_00 = common_scripts\utility::getstructarray("NODE_falling_fx","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = var_02 common_scripts\utility::spawn_tag_origin();
		var_04 = playfxontag(level._effect["sinky_bits"],var_03,"tag_origin");
		wait(0.5);
	}
}

//Function Number: 84
player_swim_hint()
{
	wait(4);
	thread maps\_utility::hintdisplayhandler("player_lake_swim");
}

//Function Number: 85
should_break_swim_hint()
{
	return isdefined(level.player.swimming) && level.player getnormalizedmovement()[0] > 0.25 || level.player getnormalizedmovement()[1] > 0.25;
}

//Function Number: 86
should_break_recover_hint()
{
	return isdefined(level.player.recover);
}

//Function Number: 87
should_break_recover_hint_command()
{
	var_00 = "playerjump";
	level.player notifyonplayercommand(var_00,"+gostand");
	level.player notifyonplayercommand(var_00,"+usereload");
	level.player notifyonplayercommand(var_00,"+stance");
	level.player waittill(var_00);
	level.player.recover = 1;
}

//Function Number: 88
should_break_recover_hint_movement()
{
	for(;;)
	{
		if(level.player getnormalizedmovement()[0] > 0.1 || level.player getnormalizedmovement()[1] > 0.1)
		{
			level.player.recover = 1;
			level.player notify("playerjump");
			return;
		}

		wait 0.05;
	}
}

//Function Number: 89
get_forward_movement()
{
	level endon("player_normal_movement");
	level.input_bool = 0;
	var_00 = 0;
	var_01 = 2;
	for(;;)
	{
		var_02 = level.player getnormalizedmovement();
		var_00 = var_02[0];
		while(var_00 <= 0)
		{
			var_02 = level.player getnormalizedmovement();
			var_00 = var_02[0];
			if(level.input_bool)
			{
				level thread input_hint(0.05);
				level.input_bool = 0;
			}

			wait(0.05);
		}

		level notify("stop_hint");
		level thread maps\_utility::hint_fade();
		level.input_bool = 0;
		var_01 = 5;
		common_scripts\utility::flag_clear("waiting_for_input");
		wait(0.05);
	}
}

//Function Number: 90
input_hint(param_00)
{
	level endon("player_normal_movement");
	level endon("stop_hint");
	wait(param_00);
	level thread maps\_utility::hint(&"CRASH_HINT_CAVE_MOVEMENT");
}

//Function Number: 91
lake_cinema_gideon()
{
	level.lake_scene_anim_node maps\_anim::anim_single_solo(self,"gideon_scene");
	thread maps\crash_exfil::vtol_takedown_gideon();
}

//Function Number: 92
lake_cinema_cormack()
{
	thread maps\crash_utility::cormack_helmet_open(self);
	level.lake_scene_anim_node maps\_anim::anim_single_solo(self,"gideon_scene");
	common_scripts\utility::flag_set("cormack_start_vtol");
	thread maps\crash_exfil::vtol_takedown_cormack();
}

//Function Number: 93
lake_cinema_ilona()
{
	level.lake_scene_anim_node maps\_anim::anim_single_solo(self,"gideon_scene");
	thread maps\crash_exfil::vtol_takedown_ilona();
	level.player maps\_utility::blend_movespeedscale(1,0.5);
	thread maps\_utility::autosave_by_name("gideon_moment");
	common_scripts\utility::flag_set("lake_cinema_done");
	level.player notify("HintDisplayHandlerEnd");
}

//Function Number: 94
lake_cinema_enemies()
{
	common_scripts\utility::flag_wait("lake_underwater_exit_flag");
	var_00 = maps\_utility::array_spawn_targetname("gideon_enemy",1);
	var_01 = [];
	var_01[0] = var_00[0];
	var_01[1] = var_00[1];
	var_01[0].ignoreme = 1;
	var_01[0].ignoreall = 1;
	var_01[0] maps\_utility::gun_remove();
	var_01[0] thread maps\crash_utility::disable_awareness();
	var_01[0] maps\_utility::set_battlechatter(0);
	var_01[0].animname = "lake_enemy_0";
	var_01[1].ignoreme = 1;
	var_01[1].ignoreall = 1;
	var_01[1] maps\_utility::gun_remove();
	var_01[1] thread maps\crash_utility::disable_awareness();
	var_01[1] maps\_utility::set_battlechatter(0);
	var_01[1].animname = "lake_enemy_1";
	level.lake_scene_anim_node maps\_anim::anim_single(var_01,"gideon_scene");
	var_01[0] invisiblenotsolid();
	var_01[0] setthreatdetection("disable");
	var_01[0] kill();
	var_01[1] invisiblenotsolid();
	var_01[1] setthreatdetection("disable");
	var_01[1] kill();
}

//Function Number: 95
ignore_friendlies()
{
	level.cormack.ignoreme = 1;
	level.ilana.ignoreme = 1;
	level.player.ignoreme = 1;
	common_scripts\utility::flag_wait("gideon_frees_you");
	level.player.ignoreme = 0;
}

//Function Number: 96
ice_lake_cinema_heli()
{
}

//Function Number: 97
play_railgun_fx()
{
	var_00 = common_scripts\utility::spawn_tag_origin();
	var_00 linktoplayerview(self,"tag_flash",(0,0,-2),(0,0,0),0);
	for(;;)
	{
		self waittill("weapon_fired",var_01);
		if(!issubstr(tolower(var_01),"s1_railgun"))
		{
			continue;
		}

		var_02 = self geteye();
		var_03 = tag_project_player(999999);
		var_04 = bullettrace(var_02,var_03,1,self);
		var_05 = var_04["surfacetype"];
		var_06 = isdefined(var_04["entity"]);
		var_07 = -1 * anglestoforward(self geteye());
		var_08 = vectortoangles(var_04["normal"]);
		var_09 = 500;
		physicsexplosionsphere(var_04["position"],var_09 + 300,var_09 * 0.25,1);
		var_00 unlinkfromplayerview(self);
		var_00 dontinterpolate();
		var_0A = vectortoangles(var_04["position"] - var_02 - (0,0,2));
		var_00 linktoplayerview(self,"tag_flash",(0,0,-2),(0,0,0),0);
		playfx(common_scripts\utility::getfx("railgun_tracer"),var_00.origin,anglestoforward(var_0A),anglestoup(var_0A));
		playfx(common_scripts\utility::getfx("railgun_blast_snow"),var_04["position"],anglestoforward(var_08),anglestoup(var_08));
	}
}

//Function Number: 98
tag_project_player(param_00)
{
	var_01 = self geteye();
	var_02 = self getplayerangles();
	var_03 = anglestoforward(var_02);
	var_03 = vectornormalize(var_03) * param_00;
	return var_01 + var_03;
}