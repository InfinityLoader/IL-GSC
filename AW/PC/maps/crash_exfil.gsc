/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: crash_exfil.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 32
 * Decompile Time: 480 ms
 * Timestamp: 4/22/2024 2:27:08 AM
*******************************************************************/

//Function Number: 1
precache_vtol_takedown()
{
	thread maps\crash_warbird_missile_defense::missile_defense_precache();
	common_scripts\utility::flag_init("vtol_takedown_done");
	common_scripts\utility::flag_init("start_gideon_wave_anim");
	common_scripts\utility::flag_init("ready_for_vtol");
	common_scripts\utility::flag_init("gideon_intro_done");
	common_scripts\utility::flag_init("cormack_start_vtol");
	common_scripts\utility::flag_init("cormack_fires_stinger");
	common_scripts\utility::flag_init("cormack_fires_stinger_failsafe");
	common_scripts\utility::flag_init("vtol_can_lock_on");
	common_scripts\utility::flag_init("vtol_hit_early");
	common_scripts\utility::flag_init("vtol_hit_mid");
	common_scripts\utility::flag_init("vtol_hit_late");
	common_scripts\utility::flag_init("start_gideons_animation");
	common_scripts\utility::flag_init("cormack_missile_1_hit");
	common_scripts\utility::flag_init("missiles_hit_vtol");
	common_scripts\utility::flag_init("end_vtol_dying");
	common_scripts\utility::flag_init("player_stinger_fired");
	common_scripts\utility::flag_init("player_stinger_hit");
	common_scripts\utility::flag_init("vo_heat_line");
	common_scripts\utility::flag_init("vo_bringitdown_line");
	common_scripts\utility::flag_init("vtol_hit_mountain");
	common_scripts\utility::flag_init("player_bottom_of_hill");
	common_scripts\utility::flag_init("vtol_done_sliding");
	common_scripts\utility::flag_init("cargo_trigger");
	common_scripts\utility::flag_init("kill_sliding_anims");
	common_scripts\utility::flag_init("start_exfil");
	common_scripts\utility::flag_init("start_gideon_exfil");
	common_scripts\utility::flag_init("start_vtol_exfil");
	common_scripts\utility::flag_init("player_getting_in_end_chopper");
	common_scripts\utility::flag_init("vo_cormack_exfil1");
	common_scripts\utility::flag_init("vo_cormack_exfil2");
	common_scripts\utility::flag_init("vo_kingpin_exfil");
	common_scripts\utility::flag_init("failed_cargo_grab");
	common_scripts\utility::flag_init("gideon_boost_jump");
	common_scripts\utility::flag_init("player_exfil_success");
	common_scripts\utility::flag_init("exfil_fail");
	precacherumble("hijack_plane_medium");
	precacheitem("iw5_stingerm7fastprojectile_sp");
	precacheitem("turretheadmg_sp");
	precachemodel("genericprop_x5");
	precachemodel("atlas_stabilize_vial_static");
	precachemodel("atlas_stabilize_crate");
	precachemodel("vehicle_xh9_warbird_pulley");
	precachemodel("projectile_stinger_missile");
	precacheshader("m/mtl_xh9_warbird_main_destroy");
	precacheshader("m/mtl_xh9_warbird_main_02_destroy");
	precacheshader("m/mtl_xh9_warbird_windows_out_destroy");
	precachestring(&"CRASH_HINT_STINGER");
	precachestring(&"CRASH_HINT_STINGER_KEYBOARD");
	precachestring(&"CRASH_CARGO_GRAB");
	precachestring(&"CRASH_CARGO_GRAB_KEYBOARD");
	precachestring(&"CRASH_HINT_EXFIL_JUMP");
	maps\_utility::add_control_based_hint_strings("end_jump",&"CRASH_HINT_BOOST_JUMP",::should_break_end_jump_hint);
	var_00 = getentarray("vtol_fail_triggers","targetname");
	foreach(var_02 in var_00)
	{
		var_02 common_scripts\utility::trigger_off();
	}

	level.end_crate = getent("end_vtol_crate","targetname");
	level.end_crate hide();
	level.end_crate_clip = getent("end_vtol_crate_clip","targetname");
	level.end_crate_clip hide();
	level.end_cables = getent("end_vtol_cables","targetname");
	level.end_cables hide();
}

//Function Number: 2
debug_start_vtol_takedown()
{
	maps\crash::set_completed_flags();
	maps\crash_utility::setup_player();
	maps\crash_utility::setup_allies();
	soundscripts\_snd::snd_message("start_vtol_takedown");
	setsunflareposition((-10.39,-112.7,0));
	level.player lightsetforplayer("crash_avalanche",0);
	level.player setclutforplayer("clut_crash_crash_site",2);
	maps\_utility::vision_set_fog_changes("crash_avalanche",0);
	setsaveddvar("r_dof_physical_enable",1);
	setsaveddvar("r_dof_physical_bokehenable",1);
	setsaveddvar("r_dof_physical_hipenable",1);
	setsaveddvar("r_dof_physical_hipFstop",3.2);
	setsaveddvar("r_dof_physical_hipSharpCocDiameter",0.07);
	thread dead_stinger_guy();
	thread vtol_takedown_gideon();
	thread vtol_takedown_cormack();
	thread vtol_takedown_cormack_stinger();
	thread vtol_takedown_ilona();
	thread maps\crash::objective_init();
	maps\_utility::battlechatter_off("allies");
	maps\_utility::battlechatter_off("axis");
	level.cormack maps\_utility::disable_ai_color();
	level.cormack.ignoreall = 1;
	level.cormack.ignoreme = 1;
	thread maps\crash_utility::cormack_helmet_open(level.cormack);
	level.ilana maps\_utility::disable_ai_color();
	level.ilana.ignoreall = 1;
	level.ilana.ignoreme = 1;
	level.gideon maps\_utility::disable_ai_color();
	level.gideon.ignoreall = 1;
	level.gideon.ignoreme = 1;
	common_scripts\_exploder::exploder(1999);
}

//Function Number: 3
begin_vtol_takedown()
{
	thread vtol_takedown_gun_pickup();
	wait 0.05;
	thread vtol_takedown_dialogue();
	thread vtol_takedown_failure();
	thread vtol_takedown_chopper();
	level.player thread maps\crash_utility::exo_temp_outdoor();
	thread avalanche_falling_death();
	common_scripts\utility::flag_wait("vtol_takedown_done");
	level.player thread maps\_hud_util::fade_out(3);
	wait(5);
	maps\_utility::nextmission();
}

//Function Number: 4
dead_stinger_guy()
{
	var_00 = common_scripts\utility::getstruct("vtol_dead_guy","targetname");
	var_01 = maps\_utility::spawn_targetname("vtol_dead_sentinel",1);
	var_01.animname = "generic";
	var_01 maps\_utility::set_ignoreall(1);
	var_01 maps\_utility::set_ignoreme(1);
	var_01 maps\_utility::set_battlechatter(0);
	var_01 maps\_utility::gun_remove();
	var_01.script_friendname = " ";
	var_01.name = " ";
	var_01 invisiblenotsolid();
	var_00 thread maps\_anim::anim_loop_solo(var_01,"npc_deadbody_01","stop_loop");
}

//Function Number: 5
vtol_takedown_gun_pickup()
{
	level.slide_dampening = 0.09;
	var_00 = getent("heli_weapon_trigger","targetname");
	var_00 maps\_utility::addhinttrigger(&"CRASH_HINT_STINGER",&"CRASH_HINT_STINGER_KEYBOARD");
	var_01 = getent("player_heli_weapon","targetname");
	maps\player_scripted_anim_util::waittill_trigger_activate_looking_at(var_00,var_01,cos(40),0,1);
	common_scripts\utility::flag_set("obj_update_get_gun");
	soundscripts\_snd::snd_message("pickup_stinger");
	var_01 delete();
	level.player_weapons = level.player maps\_utility::get_storable_weapons_list_all();
	level.player takeallweapons();
	level.player giveweapon("iw5_stingerm7fastprojectile_sp");
	level.player setweaponammostock("iw5_stingerm7fastprojectile_sp",0);
	level.player switchtoweapon("iw5_stingerm7fastprojectile_sp");
	level.player disableweaponswitch();
	thread vtol_player_fired();
	common_scripts\utility::flag_wait("gideon_intro_done");
	thread vtol_takedown_vtol();
	thread vtol_takedown_cargo_and_cables();
	thread maps\_utility::autosave_now();
	var_02 = getentarray("vtol_takedown_hide_spot","targetname");
	foreach(var_04 in var_02)
	{
		var_04 thread vtol_takedown_hide_check();
	}

	maps\_utility::delaythread(5,::common_scripts\utility::flag_set,"obj_end_get_gun");
	common_scripts\utility::flag_wait_or_timeout("obj_end_get_gun",5);
	common_scripts\utility::flag_wait("vtol_swap_player_weapon");
	level.player disableweapons();
	level.player takeallweapons();
	level.player giveweapon("s1_unarmed");
	level.player switchtoweapon("s1_unarmed");
	while(level.player maps\_utility::issliding())
	{
		wait(0.05);
	}

	level.player setstance("stand");
	level.player enableweapons();
	common_scripts\utility::flag_set("player_bottom_of_hill");
}

//Function Number: 6
vtol_player_fired()
{
	level waittill("stinger_fired",var_00,var_01);
	common_scripts\utility::flag_set("player_stinger_fired");
	wait(0.1);
	setsaveddvar("objectiveHide",1);
	wait(0.2);
	common_scripts\utility::flag_set("cormack_fires_stinger");
	common_scripts\utility::flag_wait("obj_end_exfil");
	setsaveddvar("objectiveHide",0);
}

//Function Number: 7
vtol_takedown_hide_check()
{
	level endon("ready_for_vtol");
	for(;;)
	{
		if(level.player istouching(self))
		{
			common_scripts\utility::flag_set("obj_end_get_gun");
			common_scripts\utility::flag_set("ready_for_vtol");
		}

		wait(0.05);
	}
}

//Function Number: 8
vtol_takedown_gideon()
{
	level.vtol_animnode = common_scripts\utility::getstruct("avalanche_animnode","targetname");
	var_00 = level.player;
	level.gideon pushplayer(1);
	level.vtol_animnode maps\_anim::anim_single_solo(level.gideon,"vtol_ambush_intro");
	common_scripts\utility::flag_set("gideon_intro_done");
	if(!common_scripts\utility::flag("obj_update_get_gun"))
	{
		level.vtol_animnode thread maps\_anim::anim_loop_solo(level.gideon,"vtol_ambush_stinger_loop","stop_gideon_loop");
	}

	common_scripts\utility::flag_wait("obj_update_get_gun");
	level.vtol_animnode notify("stop_gideon_loop");
	level.vtol_animnode maps\_anim::anim_single_solo(level.gideon,"vtol_ambush_vtol_talk");
	level.vtol_animnode thread maps\_anim::anim_loop_solo(level.gideon,"vtol_ambush_stinger_loop","stop_gideon_loop");
	common_scripts\utility::flag_wait("start_gideon_wave_anim");
	level.vtol_animnode notify("stop_gideon_loop");
	level.vtol_animnode maps\_anim::anim_single_solo(level.gideon,"vtol_ambush_wave_gideon");
	level.vtol_animnode thread maps\_anim::anim_loop_solo(level.gideon,"vtol_ambush_stinger_loop","stop_gideon_loop");
	common_scripts\utility::flag_wait("start_gideons_animation");
	level.vtol_animnode notify("stop_gideon_loop");
	level.vtol_animnode maps\_anim::anim_single_solo(level.gideon,"vtol_ambush_exit_cover");
	level.gideon thread vtol_takedown_gideon_slide_fx();
	level.vtol_animnode thread maps\_anim::anim_single_solo(level.gideon,"vtol_sliding_off_cliff_gideon");
	soundscripts\_snd::snd_music_message("end_sequence");
	wait(2);
	var_01 = getent("block_vtol_slide","targetname");
	var_01 delete();
	while(level.gideon getanimtime(level.gideon maps\_utility::getanim("vtol_sliding_off_cliff_gideon")) < 1 && !common_scripts\utility::flag("start_exfil"))
	{
		wait(0.05);
	}

	thread maps\crash_fx::gideon_boost_jump();
	if(common_scripts\utility::flag("start_exfil"))
	{
		common_scripts\utility::flag_wait("start_gideon_exfil");
		level.exfil_animnode maps\_anim::anim_single_solo(level.gideon,"avalanche_exit");
		return;
	}

	thread cargo_recover_fail();
	common_scripts\utility::flag_set("failed_cargo_grab");
	var_02 = getent("end_cargo_trigger","targetname");
	var_02 notify("valid_trigger");
	level.vtol_animnode maps\_anim::anim_single_solo(level.gideon,"vtol_falls_off_cliff_failure_gideon");
}

//Function Number: 9
vtol_takedown_gideon_slide_fx()
{
	self waittillmatch("bodyfall large","single anim");
	playfxontag(common_scripts\utility::getfx("crash_ai_slide_snow_short"),self,"j_ball_le");
	self waittillmatch("bodyfall large","single anim");
	playfxontag(common_scripts\utility::getfx("crash_ai_slide_snow_short"),self,"j_ball_le");
}

//Function Number: 10
vtol_takedown_cormack()
{
	var_00 = common_scripts\utility::getstruct("avalanche_animnode","targetname");
	var_00 maps\_anim::anim_single_solo(level.cormack,"vtol_ambush_intro");
	var_00 thread maps\_anim::anim_loop_solo(level.cormack,"vtol_ambush_cover_loop","stop_cormack_loop");
	common_scripts\utility::flag_wait_any("cormack_fires_stinger","cormack_fires_stinger_failsafe");
	var_00 notify("stop_cormack_loop");
	var_00 maps\_anim::anim_single_solo(level.cormack,"vtol_ambush_fire_stinger");
	var_00 thread maps\_anim::anim_loop_solo(level.cormack,"vtol_ambush_call_evac_loop","stop_cormack_loop");
	common_scripts\utility::flag_wait("start_exfil");
	var_00 notify("stop_cormack_loop");
	level.cormack maps\_utility::gun_remove();
	level.exfil_animnode maps\_anim::anim_single_solo(level.cormack,"avalanche_exit");
}

//Function Number: 11
vtol_takedown_cormack_stinger()
{
	var_00 = common_scripts\utility::getstruct("avalanche_animnode","targetname");
	var_01 = maps\_utility::spawn_anim_model("vtol_launcher");
	var_02 = maps\_utility::spawn_anim_model("vtol_stinger");
	var_00 maps\_anim::anim_first_frame_solo(var_02,"vtol_ambush_fire_stinger_missiles");
	var_00 maps\_anim::anim_first_frame_solo(var_01,"vtol_ambush_intro");
	var_03 = spawn("script_model",var_01 gettagorigin("j_prop_1"));
	var_03.angles = var_01 gettagangles("j_prop_1");
	var_03 setmodel("npc_stingerm7_nocamo");
	var_03 linkto(var_01,"j_prop_1");
	var_04 = spawn("script_model",var_02 gettagorigin("j_prop_1"));
	var_04.angles = var_02 gettagangles("j_prop_1");
	var_04 setmodel("projectile_stinger_missile");
	var_04 linkto(var_02,"j_prop_1");
	var_04 hide();
	var_05 = spawn("script_model",var_02 gettagorigin("j_prop_2"));
	var_05.angles = var_02 gettagangles("j_prop_2");
	var_05 setmodel("projectile_stinger_missile");
	var_05 linkto(var_02,"j_prop_2");
	var_05 hide();
	var_06 = spawn("script_model",var_02 gettagorigin("j_prop_3"));
	var_06.angles = var_02 gettagangles("j_prop_3");
	var_06 setmodel("projectile_stinger_missile");
	var_06 linkto(var_02,"j_prop_3");
	var_06 hide();
	var_07 = spawn("script_model",var_02 gettagorigin("j_prop_4"));
	var_07.angles = var_02 gettagangles("j_prop_4");
	var_07 setmodel("projectile_stinger_missile");
	var_07 linkto(var_02,"j_prop_4");
	var_07 hide();
	common_scripts\utility::flag_wait("cormack_start_vtol");
	var_00 maps\_anim::anim_single_solo(var_01,"vtol_ambush_intro");
	var_00 thread maps\_anim::anim_loop_solo(var_01,"vtol_ambush_cover_loop","stop_launcher_loop");
	common_scripts\utility::flag_wait_any("cormack_fires_stinger","cormack_fires_stinger_failsafe");
	var_00 notify("stop_launcher_loop");
	var_00 thread maps\_anim::anim_single_solo(var_01,"vtol_ambush_fire_stinger");
	var_04 show();
	var_04 thread cormack_missile_fx(0.2);
	soundscripts\_snd::snd_message("cormack_missile",var_04);
	var_05 show();
	var_05 thread cormack_missile_fx(0.23);
	soundscripts\_snd::snd_message("cormack_missile",var_05);
	var_06 show();
	var_06 thread cormack_missile_fx(0.2);
	soundscripts\_snd::snd_message("cormack_missile",var_06);
	var_07 show();
	var_07 thread cormack_missile_fx(0.25,1);
	soundscripts\_snd::snd_message("cormack_missile",var_07);
	var_00 thread maps\_anim::anim_single_solo(var_02,"vtol_ambush_fire_stinger_missiles");
	var_02 waittillmatch("missile1_hit","single anim");
	common_scripts\utility::flag_set("cormack_missile_1_hit");
	stopfxontag(common_scripts\utility::getfx("smoketrail_rpg_sp"),var_04,"tag_origin");
	playfxontag(common_scripts\utility::getfx("crash_rocket_explosion_default"),var_04,"tag_origin");
	stopfxontag(common_scripts\utility::getfx("smoketrail_rpg_sp"),var_05,"tag_origin");
	playfxontag(common_scripts\utility::getfx("crash_rocket_explosion_default"),var_05,"tag_origin");
	wait 0.05;
	var_04 delete();
	var_05 delete();
	var_02 waittillmatch("missile3_hit","single anim");
	stopfxontag(common_scripts\utility::getfx("smoketrail_rpg_sp"),var_06,"tag_origin");
	playfxontag(common_scripts\utility::getfx("ambient_explosion_midair_runner_single"),var_06,"tag_origin");
	var_02 waittillmatch("missile4_hit","single anim");
	stopfxontag(common_scripts\utility::getfx("smoketrail_rpg_sp"),var_07,"tag_origin");
	playfxontag(common_scripts\utility::getfx("ambient_explosion_midair_runner_single"),var_07,"tag_origin");
	var_02 waittillmatch("end","single anim");
	var_06 delete();
	var_07 delete();
	var_02 delete();
	common_scripts\_exploder::exploder(3122);
	wait(0.2);
	common_scripts\_exploder::exploder(3111);
}

//Function Number: 12
cormack_missile_fx(param_00,param_01)
{
	common_scripts\utility::flag_wait_any("cormack_fires_stinger","cormack_fires_stinger_failsafe");
	playfx(common_scripts\utility::getfx("javelin_ignition"),self.origin);
	wait(param_00);
	playfxontag(common_scripts\utility::getfx("smoketrail_rpg_sp"),self,"tag_origin");
}

//Function Number: 13
vtol_takedown_ilona()
{
	var_00 = common_scripts\utility::getstruct("avalanche_animnode","targetname");
	var_00 maps\_anim::anim_single_solo(level.ilana,"vtol_ambush_intro");
	var_00 thread maps\_anim::anim_loop_solo(level.ilana,"vtol_ambush_cover_loop","stop_ilana_loop");
	common_scripts\utility::flag_wait_any("cormack_fires_stinger","cormack_fires_stinger_failsafe");
	var_00 notify("stop_ilana_loop");
	var_00 maps\_anim::anim_single_solo(level.ilana,"vtol_ambush_exit_cover");
	var_00 thread maps\_anim::anim_loop_solo(level.ilana,"vtol_ambush_call_evac_loop","stop_ilana_loop");
	common_scripts\utility::flag_wait("start_exfil");
	var_00 notify("stop_cormack_loop");
	level.ilana maps\_utility::gun_remove();
	level.exfil_animnode maps\_anim::anim_single_solo(level.ilana,"avalanche_exit");
}

//Function Number: 14
cargo_recover_fail()
{
	setdvar("ui_deadquote",&"CRASH_FAIL_CARGO");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 15
vtol_takedown_vtol()
{
	level.stingerm7_lock_range = 10000;
	level.end_vtol = maps\_vehicle::spawn_vehicle_from_targetname("end_vtol");
	soundscripts\_snd::snd_message("vtol_flyin");
	level.end_vtol.animname = "crashed_vtol";
	level.end_vtol maps\_anim::setanimtree();
	level.end_vtol maps\_vehicle::godon();
	level.end_vtol setvehicleteam("axis");
	level.end_vtol hide();
	level.end_vtol.stinger_override_tags = ["tag_driver","tag_grapple_fl","tag_grapple_br","TAG_STATIC_TAIL_ROTOR"];
	level.end_vtol thread maps\crash_warbird_missile_defense::heli_flares_monitor();
	level.end_vtol thread vtol_damage_monitor();
	var_00 = getent("end_vtol_clip","targetname");
	if(isdefined(var_00))
	{
		var_00 linkto(level.end_vtol);
		var_00 notsolid();
	}

	common_scripts\utility::flag_wait("obj_end_get_gun");
	level.end_vtol show();
	level.vtol_animnode thread maps\_anim::anim_single_solo(level.end_vtol,"vtol_ambush_fly_intro");
	while(!common_scripts\utility::flag("cormack_fires_stinger_failsafe") && !common_scripts\utility::flag("player_stinger_hit"))
	{
		wait(0.05);
	}

	level notify("vtol_takedown_vtol_hit");
	level.end_vtol thread stinger_add_hit();
	level.end_vtol thread vtol_delayed_stinger_ignore(5);
	thread maps\_utility::autosave_now();
	if(common_scripts\utility::flag("vtol_can_lock_on") && !common_scripts\utility::flag("vtol_hit_early"))
	{
		common_scripts\utility::flag_wait("vtol_hit_early");
		level.vtol_animnode thread maps\_anim::anim_single_solo(level.end_vtol,"vtol_ambush_stinger_hit_early");
	}
	else if(common_scripts\utility::flag("vtol_hit_early") && !common_scripts\utility::flag("vtol_hit_mid"))
	{
		common_scripts\utility::flag_wait("vtol_hit_mid");
		level.vtol_animnode thread maps\_anim::anim_single_solo(level.end_vtol,"vtol_ambush_stinger_hit_mid");
	}
	else if(common_scripts\utility::flag("vtol_hit_mid"))
	{
		common_scripts\utility::flag_wait("missiles_hit_vtol");
		level.vtol_animnode thread maps\_anim::anim_single_solo(level.end_vtol,"vtol_ambush_stinger_hit_late");
	}
	else
	{
	}

	level.end_vtol notify("warbird_stop_firing");
	level.end_vtol notify("end_vtol_start_dying");
	level notify("vtol_downed");
	playfxontag(common_scripts\utility::getfx("helicopter_explosion_secondary_small"),level.end_vtol,"jnt_wingsocket_l");
	playfxontag(common_scripts\utility::getfx("smoke_trail_black_heli_emitter"),level.end_vtol,"jnt_wingsocket_l");
	level.end_vtol waittillmatch("end","single anim");
	common_scripts\utility::flag_set("end_vtol_dying");
	common_scripts\utility::flag_set("obj_end_exfil");
	common_scripts\_exploder::exploder(3131);
	stopfxontag(common_scripts\utility::getfx("helicopter_explosion_secondary_small"),level.end_vtol,"jnt_wingsocket_l");
	stopfxontag(common_scripts\utility::getfx("smoke_trail_black_heli_emitter"),level.end_vtol,"jnt_wingsocket_l");
	maps\_utility::delaythread(4,::common_scripts\utility::flag_set,"obj_final_recover_cargo");
	if(isdefined(var_00))
	{
		var_00 solid();
	}

	thread vtol_takedown_terrain();
	thread vtol_takedown_vtol_slide_fx();
	if(level.nextgen)
	{
		level.end_vtol overridematerial("mtl_xh9_warbird_main","m/mtl_xh9_warbird_main_destroy");
		level.end_vtol overridematerial("mtl_xh9_warbird_main_02","m/mtl_xh9_warbird_main_02_destroy");
		level.end_vtol overridematerial("mtl_xh9_warbird_windows_out","m/mtl_xh9_warbird_windows_out_destroy");
	}
	else
	{
		level.end_vtol overridematerial("mtl_xh9_warbird_main","mq/mtl_xh9_warbird_main_destroy");
		level.end_vtol overridematerial("mtl_xh9_warbird_main_02","mq/mtl_xh9_warbird_main_02_destroy");
		level.end_vtol overridematerial("mtl_xh9_warbird_windows_out","mq/mtl_xh9_warbird_windows_out_destroy");
	}

	level.end_vtol showpart("TAG_STATIC_MAIN_ROTOR_L");
	level.end_vtol showpart("TAG_STATIC_MAIN_ROTOR_R");
	level.end_vtol showpart("TAG_STATIC_TAIL_ROTOR");
	level.end_vtol hidepart("TAG_SPIN_MAIN_ROTOR_L");
	level.end_vtol hidepart("TAG_SPIN_MAIN_ROTOR_R");
	level.end_vtol hidepart("TAG_SPIN_TAIL_ROTOR");
	level.vtol_animnode maps\_anim::anim_single_solo(level.end_vtol,"vtol_ambush_crash");
	thread avalanche_environment();
	thread vtol_takedown_player_grabs_cargo();
	common_scripts\utility::flag_set("vtol_done_sliding");
	level.vtol_animnode thread maps\_anim::anim_single_solo(level.end_vtol,"vtol_sliding_off_cliff");
	while(level.end_vtol getanimtime(level.end_vtol maps\_utility::getanim("vtol_sliding_off_cliff")) < 1 && !common_scripts\utility::flag("kill_sliding_anims"))
	{
		wait(0.05);
	}

	if(common_scripts\utility::flag("kill_sliding_anims"))
	{
		level.end_vtol setanimrate(level.end_vtol maps\_utility::getanim("vtol_sliding_off_cliff"),0);
		common_scripts\utility::flag_wait("start_vtol_exfil");
		level.vtol_animnode thread maps\_anim::anim_single_solo(level.end_vtol,"avalanche_exit_fail");
	}
	else
	{
		level.vtol_animnode thread maps\_anim::anim_single_solo(level.end_vtol,"vtol_falls_off_cliff");
	}

	playfxontag(common_scripts\utility::getfx("vtol_crash_slide_snow"),level.end_vtol,"jnt_maindoor_LR");
	wait(0.05);
	playfxontag(common_scripts\utility::getfx("vtol_crash_slide_snow"),level.end_vtol,"jnt_launcherDoor02_R");
	wait(0.05);
	playfxontag(common_scripts\utility::getfx("crate_crash_slide_snow"),level.end_crate,"TAG_FX_SLIDE_BL");
	playfxontag(common_scripts\utility::getfx("crate_crash_slide_snow"),level.end_crate,"TAG_FX_SLIDE_FL");
}

//Function Number: 16
stinger_add_hit()
{
	level endon("missiles_hit_vtol");
	common_scripts\utility::flag_wait("player_stinger_hit");
	level.end_vtol setanim(level.end_vtol maps\_utility::getanim("ambush_hit_add"),0.5);
	level.end_cables setanim(level.end_cables maps\_utility::getanim("ambush_hit_add"),0.5);
	level.end_crate setanim(level.end_crate maps\_utility::getanim("ambush_hit_add"),0.5);
}

//Function Number: 17
vtol_takedown_vtol_slide_fx()
{
	playfxontag(common_scripts\utility::getfx("vtol_crash_slide_snow"),level.end_vtol,"jnt_maindoor_LL");
	playfxontag(common_scripts\utility::getfx("vtol_crash_slide_snow"),level.end_vtol,"jnt_maindoor_LR");
	wait(0.05);
	playfxontag(common_scripts\utility::getfx("vtol_crash_slide_snow"),level.end_vtol,"jnt_launcherDoor02_L");
	playfxontag(common_scripts\utility::getfx("vtol_crash_slide_snow"),level.end_vtol,"jnt_launcherDoor02_R");
	wait(0.05);
	playfxontag(common_scripts\utility::getfx("crate_crash_slide_snow"),level.end_crate,"TAG_FX_SLIDE_BL");
	playfxontag(common_scripts\utility::getfx("crate_crash_slide_snow"),level.end_crate,"TAG_FX_SLIDE_FL");
	playfxontag(common_scripts\utility::getfx("vtol_crash_slide_snow"),level.end_vtol,"Tag_light_l_wing");
	common_scripts\utility::flag_wait("vtol_done_sliding");
	stopfxontag(common_scripts\utility::getfx("vtol_crash_slide_snow"),level.end_vtol,"jnt_maindoor_LL");
	stopfxontag(common_scripts\utility::getfx("vtol_crash_slide_snow"),level.end_vtol,"jnt_maindoor_LR");
	wait(0.05);
	stopfxontag(common_scripts\utility::getfx("vtol_crash_slide_snow"),level.end_vtol,"jnt_launcherDoor02_L");
	stopfxontag(common_scripts\utility::getfx("vtol_crash_slide_snow"),level.end_vtol,"jnt_launcherDoor02_R");
	wait(0.05);
	stopfxontag(common_scripts\utility::getfx("crate_crash_slide_snow"),level.end_crate,"TAG_FX_SLIDE_BL");
	stopfxontag(common_scripts\utility::getfx("crate_crash_slide_snow"),level.end_crate,"TAG_FX_SLIDE_FL");
	stopfxontag(common_scripts\utility::getfx("vtol_crash_slide_snow"),level.end_vtol,"Tag_light_l_wing");
}

//Function Number: 18
vtol_delayed_stinger_ignore(param_00)
{
	wait(param_00);
	if(isdefined(self))
	{
		maps\_stingerm7::stinger_ignore();
	}
}

//Function Number: 19
vtol_damage_monitor()
{
	level endon("vtol_takedown_vtol_hit");
	level.end_vtol setcandamage(1);
	level.end_vtol setcanradiusdamage(1);
	for(;;)
	{
		level waittill("stinger_fired",var_00,var_01);
		foreach(var_03 in var_01)
		{
			if(isdefined(var_03))
			{
				var_03 thread projectile_alive();
			}
		}
	}

	level notify("vtol_downed");
	var_05 = getentarray("vtol_fail_triggers","targetname");
	maps\_utility::array_delete(var_05);
}

//Function Number: 20
projectile_alive()
{
	level endon("player_stinger_hit");
	while(isdefined(self))
	{
		wait(0.05);
	}

	common_scripts\utility::flag_set("player_stinger_hit");
}

//Function Number: 21
vtol_takedown_shoot_monitor()
{
	self endon("end_vtol_start_dying");
	level.player.ignoreme = 0;
	wait(0.25);
	thread maps\crash_utility::warbird_shooting_think(0,0.5,2.5,1);
	wait(0.05);
	self notify("warbird_fire");
}

//Function Number: 22
vtol_takedown_cargo_and_cables()
{
	level.end_cables notsolid();
	level.end_crate.origin = level.end_cables gettagorigin("tag_attach");
	level.end_crate.angles = level.end_cables gettagangles("tag_attach");
	level.end_crate notsolid();
	level.end_crate_clip.origin = level.end_crate.origin;
	level.end_crate_clip.angles = level.end_crate.angles;
	level.end_crate_clip linkto(level.end_crate);
	level.end_crate_clip notsolid();
	var_00 = getent("end_cargo_trigger","targetname");
	var_00 enablelinkto();
	var_00 linkto(level.end_crate,"tag_origin",(64,0,48),(0,0,0));
	var_00 common_scripts\utility::trigger_off();
	level.final_loc = level.end_crate common_scripts\utility::spawn_tag_origin();
	level.final_loc.origin = level.end_crate gettagorigin("j_casing_lid");
	level.final_loc linkto(level.end_crate,"j_casing_lid");
	level.final_use_struct = level.end_crate common_scripts\utility::spawn_tag_origin();
	level.final_use_struct.origin = level.end_crate gettagorigin("j_casing_lid");
	level.final_use_struct linkto(level.end_crate,"j_casing_lid");
	var_01 = [];
	var_01[0] = level.end_crate;
	var_01[1] = level.end_cables;
	level.end_crate.animname = "vtol_cargo";
	level.end_crate maps\_anim::setanimtree();
	level.end_cables.animname = "vtol_cables";
	level.end_cables maps\_anim::setanimtree();
	common_scripts\utility::flag_wait("obj_end_get_gun");
	level.end_cables show();
	level.end_crate show();
	level.end_crate_clip show();
	level.vtol_animnode thread maps\_anim::anim_single(var_01,"vtol_ambush_fly_intro");
	while(!common_scripts\utility::flag("cormack_fires_stinger_failsafe") && !common_scripts\utility::flag("player_stinger_hit"))
	{
		wait(0.05);
	}

	if(common_scripts\utility::flag("vtol_can_lock_on") && !common_scripts\utility::flag("vtol_hit_early"))
	{
		common_scripts\utility::flag_wait("vtol_hit_early");
		level.vtol_animnode maps\_anim::anim_single(var_01,"vtol_ambush_stinger_hit_early");
	}
	else if(common_scripts\utility::flag("vtol_hit_early") && !common_scripts\utility::flag("vtol_hit_mid"))
	{
		common_scripts\utility::flag_wait("vtol_hit_mid");
		level.vtol_animnode maps\_anim::anim_single(var_01,"vtol_ambush_stinger_hit_mid");
	}
	else if(common_scripts\utility::flag("vtol_hit_mid"))
	{
		common_scripts\utility::flag_wait("missiles_hit_vtol");
		level.vtol_animnode maps\_anim::anim_single(var_01,"vtol_ambush_stinger_hit_late");
	}
	else
	{
	}

	level.end_cables solid();
	level.end_crate solid();
	level.end_crate_clip solid();
	level.vtol_animnode maps\_anim::anim_single(var_01,"vtol_ambush_crash");
	var_00 common_scripts\utility::trigger_on();
	level.vtol_animnode thread maps\_anim::anim_single(var_01,"vtol_sliding_off_cliff");
	while(level.end_vtol getanimtime(level.end_vtol maps\_utility::getanim("vtol_sliding_off_cliff")) < 1 && !common_scripts\utility::flag("kill_sliding_anims"))
	{
		wait(0.05);
	}

	if(common_scripts\utility::flag("kill_sliding_anims"))
	{
		level.end_cables setanimrate(level.end_cables maps\_utility::getanim("vtol_sliding_off_cliff"),0);
		level.end_crate setanimrate(level.end_crate maps\_utility::getanim("vtol_sliding_off_cliff"),0);
		level.exfil_animnode = level.end_crate common_scripts\utility::spawn_tag_origin();
		common_scripts\utility::flag_set("start_exfil");
		level.exfil_animnode maps\_anim::anim_single_solo(level.end_crate,"avalanche_exit");
		common_scripts\utility::flag_wait("start_vtol_exfil");
		level.vtol_animnode maps\_anim::anim_single(var_01,"avalanche_exit_fail");
		return;
	}

	var_00 delete();
	level.vtol_animnode maps\_anim::anim_single(var_01,"vtol_falls_off_cliff");
}

//Function Number: 23
vtol_takedown_terrain()
{
	var_00 = getent("vtol_slide_cover_01","targetname");
	var_01 = getent("vtol_slide_cover_01a","targetname");
	var_02 = getent("vtol_slide_cover_02","targetname");
	var_03 = getent("vtol_slide_cover_03","targetname");
	var_04 = getent("vtol_slide_cover_04","targetname");
	var_05 = getent("vtol_slide_cover_05","targetname");
	var_06 = getent("vtol_slide_cover_06","targetname");
	var_07 = getent("vtol_slide_cover_07","targetname");
	var_08 = getent("vtol_slide_cover_08","targetname");
	var_09 = getent("vtol_slide_cover_09","targetname");
	var_0A = getent("vtol_slide_cover_10","targetname");
	var_0B = getent("vtol_slide_cover_11","targetname");
	var_0C = getent("vtol_slide_cover_12","targetname");
	common_scripts\_exploder::exploder(8700);
	var_00 delete();
	wait(0.34);
	var_01 delete();
	wait(3.58);
	var_02 delete();
	wait(1.33);
	var_03 delete();
	wait(1.05);
	var_04 delete();
	wait(1.13);
	var_05 delete();
	wait(0.98);
	var_06 delete();
	wait(0.78);
	var_07 delete();
	wait(0.81);
	var_08 delete();
	wait(0.86);
	var_09 delete();
	wait(1.13);
	var_0A delete();
	wait(0.81);
	var_0B delete();
	wait(0.85);
	var_0C delete();
}

//Function Number: 24
vtol_takedown_player_grabs_cargo()
{
	level endon("failed_cargo_grab");
	if(common_scripts\utility::flag("failed_cargo_grab"))
	{
		return;
	}

	var_00 = getent("end_cargo_trigger","targetname");
	var_00 maps\_utility::addhinttrigger(&"CRASH_CARGO_GRAB",&"CRASH_CARGO_GRAB_KEYBOARD");
	maps\player_scripted_anim_util::waittill_trigger_activate_looking_at(var_00,level.final_loc,cos(40),0,1);
	common_scripts\utility::flag_set("cargo_trigger");
	common_scripts\utility::flag_set("kill_sliding_anims");
	common_scripts\utility::flag_wait("start_exfil");
	level.player maps\_shg_utility::setup_player_for_scene();
	var_01 = maps\_utility::spawn_anim_model("rig");
	var_01 hide();
	var_02 = spawn("script_model",var_01.origin);
	var_02 setmodel("atlas_stabilize_vial_static");
	var_02 hide();
	var_02.origin = var_01 gettagorigin("tag_weapon_right");
	var_02.angles = var_01 gettagangles("tag_weapon_right");
	var_02 linkto(var_01,"tag_weapon_right");
	soundscripts\_snd::snd_message("recover_cargo");
	level.exfil_animnode thread maps\_anim::anim_single_solo(var_01,"avalanche_exit");
	thread maps\_shg_utility::disable_features_entering_cinema(1);
	level.player playerlinktoblend(var_01,"tag_player",0.6);
	wait(0.3);
	var_01 show();
	wait(0.3);
	common_scripts\utility::flag_set("obj_end_recover_cargo");
	level.player playerlinktodelta(var_01,"tag_player",1,25,25,20,20,1);
	common_scripts\_exploder::exploder(5186);
	wait(0.5);
	level notify("moved_indoors");
	var_01 waittillmatch("unhide_vial","single anim");
	var_02 show();
	var_01 waittillmatch("jump_window_end","single anim");
	if(!common_scripts\utility::flag("player_exfil_success"))
	{
		var_03 = var_01 common_scripts\utility::spawn_tag_origin();
		var_03 thread maps\_anim::anim_single_solo(var_01,"avalanche_death");
		soundscripts\_snd::snd_message("exfil_fail");
		wait(1);
		var_04 = var_01 common_scripts\utility::spawn_tag_origin();
		var_04 linkto(var_01,"tag_origin");
		playfxontag(common_scripts\utility::getfx("screen_avalanche_death"),var_04,"tag_origin");
		wait(0.75);
		setdvar("ui_deadquote",&"CRASH_FAIL_CARGO");
		maps\_utility::missionfailedwrapper();
	}

	var_01 waittillmatch("end","single anim");
}

//Function Number: 25
exfil_player_jump(param_00)
{
	level.player endon("exfil_fail");
	thread maps\_utility::hintdisplayhandler("end_jump");
	level.player notifyonplayercommand("exfil_jump","+gostand");
	level.player waittill("exfil_jump");
	wait 0.05;
	level.player notifyonplayercommand("exfil_jump2","+gostand");
	level.player waittill("exfil_jump2");
	common_scripts\utility::flag_set("player_exfil_success");
}

//Function Number: 26
exfil_player_jump_fail(param_00)
{
	level.player notify("exfil_fail");
	common_scripts\utility::flag_set("exfil_fail");
}

//Function Number: 27
should_break_end_jump_hint()
{
	return common_scripts\utility::flag("player_exfil_success") || common_scripts\utility::flag("exfil_fail");
}

//Function Number: 28
vtol_takedown_chopper()
{
	common_scripts\utility::flag_wait_any("player_bottom_of_hill","player_at_vtol","cargo_trigger");
	var_00 = common_scripts\utility::getstruct("avalanche_exfil_animnode","targetname");
	level.end_chopper = maps\_vehicle::spawn_vehicle_from_targetname("end_littlebird");
	level.end_chopper.animname = "exfil_heli";
	level.end_chopper maps\_anim::setanimtree();
	level.end_chopper hide();
	level.end_chopper vehicle_turnengineoff();
	var_00 maps\_anim::anim_first_frame_solo(level.end_chopper,"avalanche_exit");
	common_scripts\utility::flag_wait("start_exfil");
	level.end_chopper show();
	level.exfil_animnode maps\_anim::anim_single_solo(level.end_chopper,"avalanche_exit");
}

//Function Number: 29
vtol_takedown_dialogue()
{
	level.gideon maps\_utility::smart_dialogue("crsh_gid_stingers");
	common_scripts\utility::flag_set("obj_start_get_gun");
	common_scripts\utility::flag_wait("gideon_intro_done");
	wait(0.4);
	level.gideon maps\_utility::smart_dialogue("crsh_gid_dealthwith");
	wait(0.75);
	maps\_utility::smart_radio_dialogue("crsh_acp_yourelucky");
	wait(0.5);
	level.gideon maps\_utility::smart_dialogue("crsh_gid_cargosecure2");
	wait(0.75);
	maps\_utility::smart_radio_dialogue("crsh_acp_intact");
	common_scripts\utility::flag_wait("vo_heat_line");
	if(!common_scripts\utility::flag("player_stinger_fired"))
	{
		maps\_utility::smart_radio_dialogue("crsh_acp_heatsignatures");
		common_scripts\utility::flag_wait("vo_bringitdown_line");
		if(!common_scripts\utility::flag("player_stinger_fired"))
		{
			maps\_utility::smart_radio_dialogue("crsh_gid_bringitdown2");
		}
	}

	level waittill("vtol_downed");
	wait(1);
	level.gideon maps\_utility::smart_dialogue("crsh_gid_callevac3");
	common_scripts\utility::flag_wait("gideon_jump_talk");
	level.gideon maps\_utility::smart_dialogue("crsh_gid_comingapart3");
	wait(1);
	maps\_utility::smart_radio_dialogue("crsh_crmk_evacshere");
	wait(1.5);
	if(!common_scripts\utility::flag("player_at_vtol"))
	{
		maps\_utility::smart_radio_dialogue("crsh_gid_loseit2");
	}

	common_scripts\utility::flag_wait("player_at_vtol");
	if(!common_scripts\utility::flag("cargo_trigger"))
	{
		maps\_utility::smart_radio_dialogue("crsh_gid_grabcargo2");
	}

	common_scripts\utility::flag_wait("vo_cormack_exfil1");
	if(common_scripts\utility::flag("player_exfil_success"))
	{
		level.cormack maps\_utility::smart_dialogue("crsh_crmk_boxissecure");
	}

	common_scripts\utility::flag_wait("vo_kingpin_exfil");
	if(common_scripts\utility::flag("player_exfil_success"))
	{
		maps\_utility::smart_radio_dialogue("crsh_so_solidcopy1");
	}

	common_scripts\utility::flag_wait("vo_cormack_exfil2");
	if(common_scripts\utility::flag("player_exfil_success"))
	{
		level.cormack maps\_utility::smart_dialogue("crsh_crmk_donttrustyou");
	}
}

//Function Number: 30
vtol_takedown_failure()
{
	level endon("vtol_downed");
	var_00 = getentarray("vtol_fail_triggers","targetname");
	foreach(var_02 in var_00)
	{
		var_02 common_scripts\utility::trigger_on();
	}

	common_scripts\utility::flag_clear("vtol_fail");
	common_scripts\utility::flag_wait("vtol_fail");
	setdvar("ui_deadquote",&"CRASH_FAIL_CARGO");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 31
avalanche_environment()
{
	while(!common_scripts\utility::flag("obj_end_recover_cargo"))
	{
		var_00 = randomfloatrange(1.5,5.5);
		level.player playrumbleonentity("hijack_plane_medium");
		screenshake(level.player.origin,0.5,0.5,0.25,var_00,0,0.5,500,8,5,2);
		wait(var_00 + randomfloatrange(0.5,1.5));
	}
}

//Function Number: 32
avalanche_falling_death()
{
	common_scripts\utility::flag_wait("av_fall_death");
	setdvar("ui_deadquote",&"CRASH_FAIL_FALL");
	maps\_utility::missionfailedwrapper();
	level.player thread maps\_player_exo::player_exo_deactivate();
}