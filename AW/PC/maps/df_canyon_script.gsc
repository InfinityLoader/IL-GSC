/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: df_canyon_script.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 89
 * Decompile Time: 1319 ms
 * Timestamp: 4/22/2024 2:28:37 AM
*******************************************************************/

//Function Number: 1
setup_canyon()
{
	maps\df_fly::setup_common();
	common_scripts\utility::flag_set("intro_finished");
	level.player thread maps\_hud_util::fade_out(0.1,"white");
	maps\df_fly_flight_code::flight_code_start("canyon_run_start");
	soundscripts\_snd::snd_message("snd_start_canyon");
	thread maps\df_fly::handle_gun_hint();
}

//Function Number: 2
setup_canyon_old_controls()
{
	level.old_controls = 1;
	setup_canyon();
}

//Function Number: 3
setup_canyon2_old_controls()
{
	level.old_controls = 1;
	setup_canyon2();
}

//Function Number: 4
setup_canyon_dam_old_controls()
{
	level.old_controls = 1;
	setup_canyon_dam();
}

//Function Number: 5
setup_canyon3_old_controls()
{
	level.old_controls = 1;
	setup_canyon3();
}

//Function Number: 6
setup_canyon2()
{
	maps\df_fly::setup_common();
	common_scripts\utility::flag_set("intro_finished");
	thread maps\df_fly_flight_code::process_flight_path("canyon_run_start2_path");
	maps\df_fly_flight_code::flight_code_start("canyon_run_start2");
	common_canyon_funcs("canyon_ally_start2");
	soundscripts\_snd::snd_message("snd_start_canyon2");
}

//Function Number: 7
setup_canyon_dam()
{
	maps\df_fly::setup_common();
	common_scripts\utility::flag_set("intro_finished");
	thread maps\df_fly_flight_code::process_flight_path("pre_dam_path");
	maps\df_fly_flight_code::flight_code_start("canyon_run_start_dam");
	common_canyon_funcs("canyon_ally_start_dam");
	common_scripts\utility::flag_set("turrets2");
	thread maps\df_fly_code::handle_turrets("enemy_turret_dam","turrets2","enemies6");
	soundscripts\_snd::snd_message("snd_start_canyon_dam");
}

//Function Number: 8
setup_canyon3()
{
	maps\df_fly::setup_common();
	common_scripts\utility::flag_set("intro_finished");
	thread maps\df_fly_flight_code::process_flight_path("canyon_run_start3_path");
	maps\df_fly_flight_code::flight_code_start("canyon_run_start3");
	common_canyon_funcs("canyon_ally_start3");
	common_scripts\utility::flag_set("dam_cracks1");
	level.allies[2] thread redshirt_death_vo();
	soundscripts\_snd::snd_message("snd_start_canyon3");
}

//Function Number: 9
setup_canyon_exit()
{
	maps\df_fly::setup_common();
	common_scripts\utility::flag_set("intro_finished");
	maps\df_fly_flight_code::flight_code_start("canyon_run_exit");
	soundscripts\_snd::snd_message("snd_start_canyon_exit");
}

//Function Number: 10
spawn_allies(param_00)
{
	level.ally_ai_active = 1;
	var_01 = [1,2,3];
	level.allies = [];
	var_02 = getentarray(param_00,"targetname");
	foreach(var_04 in var_02)
	{
		var_05 = var_04 maps\df_fly_flight_code::make_ally_jet(level.plane);
		switch(var_04.script_noteworthy)
		{
			case "canyon_ally1":
				var_01[0] = var_05;
				break;

			case "canyon_ally2":
				var_01[1] = var_05;
				break;

			case "canyon_ally3":
				var_01[2] = var_05;
				break;
		}
	}

	level.allies = var_01;
	return var_01;
}

//Function Number: 11
common_canyon_funcs(param_00)
{
	level.base_agl = 0;
	spawn_allies(param_00);
	if(!isdefined(level.enemy_units))
	{
		level.enemy_units = [];
	}

	thread stay_low_nags();
	thread ambient_combat_vo();
	thread maps\df_fly_code::setup_destructibles();
	soundscripts\_snd::snd_music_message("df_fly_jet_combat");
	thread maps\df_fly::handle_gun_hint();
	thread bump_nag_vo();
}

//Function Number: 12
hide_mountains(param_00)
{
	var_01 = getentarray("intro_mountain","targetname");
	if(maps\df_fly_flight_code::is_true(param_00))
	{
		common_scripts\utility::array_call(var_01,::show);
		return;
	}

	common_scripts\utility::array_call(var_01,::hide);
}

//Function Number: 13
begin_canyon()
{
	thread maps\df_fly_flight_code::process_flight_path("canyon_run_start_path");
	var_00 = maps\_utility::obj("reach_obj");
	objective_add(var_00,"current",&"PLAYERPLANE_REACH_NEW_BAGHDAD");
	level.enemy_units = [];
	level.base_agl = 0;
	common_scripts\utility::flag_clear("target_player");
	wait(0.1);
	thread maps\df_fly_flight_code::steering_hack();
	var_01 = getent("canyon_run_start","targetname");
	level.plane vehicle_teleport(var_01.origin,var_01.angles,1);
	spawn_allies("canyon_ally");
	level.player thread maps\df_fly::wait_for_stick_press();
	var_02 = 0;
	var_03 = getentarray("canyon_ally_redshirt","targetname");
	common_scripts\utility::array_thread(var_03,::maps\df_fly_flight_code::make_ally_jet,level.plane,0);
	thread tanker_crash();
	wait(0.5);
	level.player maps\_hud_util::fade_in(1,"white");
	maps\_utility::autosave_by_name("canyon_start");
	thread stay_low_nags();
	thread canyon_ally_vo();
	thread left_canyon1();
	thread maps\df_fly_code::handle_turrets("enemy_turret0","intro_finished","canyon_enemy2a");
	thread maps\df_fly_code::handle_turrets("canyon_turrets0","ally_fire1","canyon_enemy3_warning");
	thread maps\df_fly_code::setup_destructibles();
	thread handle_flak("flak_origin00","start_flak00");
	thread amb_sky_combat_setup();
	common_scripts\utility::flag_set("trig_amb_enemywave_starters");
	soundscripts\_snd::snd_message("snd_start_canyon");
	level.player thread maps\_utility::hintdisplayhandler("climb_hint",5);
	level.next_obj_pos = 0;
	var_04 = maps\df_fly_flight_code::spawn_enemy_jets("canyon_enemy_tut","targetname");
	thread ambient_combat_vo("control_check");
	thread handle_missile_hint();
	thread bump_nag_vo();
	var_05 = maps\df_fly_flight_code::spawn_enemy_jets("canyon_enemy1","targetname");
	thread invert_controls_prompt();
	thread maps\df_fly_code::fake_missile_from_behind_player("fake_missiles1","fake_missile_target1",undefined,undefined,3);
	common_scripts\utility::flag_wait("enemy_ambush");
	thread maps\df_fly_code::handle_missile_jet("explode_wall_hoodoo_jet","missile_jet_exploding_hoodoo","explode_wall_hoodoo");
	wait 0.05;
	var_06 = maps\_utility::remove_dead_from_array(var_05);
	var_07 = maps\df_fly_flight_code::get_jet_array("canyon_ally3");
	common_scripts\utility::array_thread(var_07,::redshirt_death_vo);
	if(var_06.size > 0)
	{
		level.player thread maps\df_fly_code::radio_dialog_add_and_go("df_mag_ambush");
		thread ambush_ambushed_vo(var_07,var_06);
		wait(1);
		thread maps\df_fly_flight_code::engage_enemies(var_06,var_07,0.5,3,1);
		if(var_06.size > 0)
		{
			level.player thread maps\df_fly_code::radio_dialog_add_and_go("df_mag_painted");
		}
	}

	common_scripts\utility::flag_wait("speed_boost1");
	thread handle_flak("flak_origin0","start_flak0");
	common_scripts\utility::flag_wait("enemies1b");
	maps\df_fly_flight_code::spawn_enemy_jets("canyon_enemy1b","targetname");
	level.allies = maps\_utility::remove_dead_from_array(level.allies);
	var_06 = maps\_utility::remove_dead_from_array(var_06);
	var_08 = var_06;
	common_scripts\utility::array_thread(var_06,::maps\df_fly_flight_code::set_optimal_flight_dist,5000);
	var_09 = 0;
	foreach(var_0B in var_06)
	{
		var_0B.has_flares = 4;
		var_0B maps\df_fly_flight_code::change_optimal_flight_distance(var_09);
		var_09 = var_09 + 1000;
	}

	common_scripts\utility::array_thread(level.allies,::maps\df_fly_flight_code::set_optimal_flight_dist,-5000);
	common_scripts\utility::array_thread(var_06,::player_catch_up_on_boost,1500,1,7000);
	common_scripts\utility::array_thread(var_06,::player_catch_up_on_boost,1500,0,5000);
	common_scripts\utility::flag_wait("brake_hint");
	show_brake_hint();
	common_scripts\utility::flag_wait("canyon_enemy2a");
	thread maps\_utility::autosave_by_name("first corner");
	common_scripts\utility::flag_clear("target_player");
	var_06 = maps\df_fly_flight_code::spawn_enemy_jets("canyon_enemy2a");
	foreach(var_0B in var_06)
	{
		var_0B.has_flares = 2;
	}

	common_scripts\utility::flag_wait("target_player");
	thread flare_warning();
	common_scripts\utility::flag_set("target_player");
	common_scripts\utility::flag_wait("ally_fire1");
	level.allies = maps\_utility::remove_dead_from_array(level.allies);
	var_08 = maps\_utility::remove_dead_from_array(var_08);
	if(var_08.size > 0)
	{
		foreach(var_0B in var_08)
		{
			var_0B.has_flares = 0;
		}

		thread maps\df_fly_flight_code::engage_enemies(level.allies,var_08,2,3,1,2);
	}

	level common_scripts\utility::waittill_any("autosave","pop_flares");
	var_06 = maps\_utility::remove_dead_from_array(var_06);
	thread maps\df_fly_flight_code::engage_enemies(var_06,level.allies,0.25,2,2,1);
	common_scripts\utility::flag_wait("autosave");
	maps\_utility::autosave_by_name("first_corner_done");
	maps\_utility::delaythread(3,::common_scripts\utility::flag_clear,"autosave");
	level.enemies = var_06;
}

//Function Number: 14
show_brake_hint()
{
	if(level.player usinggamepad())
	{
		level.player thread maps\_utility::display_hint_timeout("airbrake_hint",5);
		return;
	}

	if(maps\_utility::is_command_bound("toggleprone"))
	{
		level.player thread maps\_utility::display_hint_timeout("airbrake_hint_pc_toggle",5);
		return;
	}

	if(maps\_utility::is_command_bound("+prone"))
	{
		level.player thread maps\_utility::display_hint_timeout("airbrake_hint_pc_hold",5);
		return;
	}
}

//Function Number: 15
handle_dying_player_brake_hint()
{
	setdvarifuninitialized("df_fly_deaths",0);
	setdvar("df_fly_deaths",0);
	var_00 = 0;
	thread watch_for_deaths();
	for(;;)
	{
		wait(2);
		var_01 = getdvarint("df_fly_deaths");
		if(var_00 != var_01)
		{
			var_00 = var_01;
			if(var_01 >= 5)
			{
				thread show_brake_hint();
				var_01 = 0;
				setdvar("df_fly_deaths",var_01);
			}
		}
	}
}

//Function Number: 16
watch_for_deaths()
{
	for(;;)
	{
		level maps\_utility::add_wait(::common_scripts\utility::flag_wait,"missionfailed");
		level.player maps\_utility::add_wait(::maps\_utility::waittill_msg,"death");
		maps\_utility::do_wait_any();
		var_00 = getdvarint("df_fly_deaths");
		var_00++;
		setdvar("df_fly_deaths",var_00);
		wait(1);
	}
}

//Function Number: 17
handle_missile_hint()
{
	common_scripts\utility::flag_wait("player_steered");
	level.player maps\_utility::display_hint_timeout("missile_hint",5);
}

//Function Number: 18
invert_controls_prompt()
{
	common_scripts\utility::flag_wait("hint_time");
	wait(0.05);
	level.player luiopenmenu(&"flight_controls_setting_popmenu");
	wait(0.5);
	maps\_utility::autosave_now(1);
}

//Function Number: 19
tanker_crash()
{
	var_00 = getent("crashing_tanker","targetname");
	var_01 = var_00 thread maps\_vehicle::spawn_vehicle_and_gopath();
	var_02 = maps\_utility::spawn_anim_model("refueler");
	var_02.origin = var_01.origin;
	var_02.angles = var_01.angles;
	var_02 linkto(var_01,"tag_origin",(0,0,0),(0,0,0));
	var_01 hide();
	playfxontag(common_scripts\utility::getfx("bagh_tanker_crash"),var_02,"TAG_ORIGIN");
	wait 0.05;
	var_01 maps\_utility::ent_flag_clear("engineeffects");
	wait(0.25);
	var_01 notify("stop_engineeffects");
	common_scripts\utility::flag_wait("tanker_impact");
	playfx(common_scripts\utility::getfx("canyon_jet_impact"),var_02.origin,anglestoforward(var_02.angles) * -1);
	playfxontag(common_scripts\utility::getfx("bagh_tanker_dust_trail"),var_02,"TAG_ORIGIN");
	wait(7);
	playfx(common_scripts\utility::getfx("bagh_dam_explosion"),var_02.origin);
	stopfxontag(common_scripts\utility::getfx("bagh_tanker_crash"),var_02,"TAG_ORIGIN");
	stopfxontag(common_scripts\utility::getfx("bagh_hoodoo_dust_trail"),var_02,"TAG_ORIGIN");
	var_01 waittill("death");
	var_02 unlink();
	var_02 delete();
}

//Function Number: 20
player_catch_up_on_boost(param_00,param_01,param_02)
{
	self endon("death");
	if(!level.player_boosting)
	{
		level waittill("player_boost_start");
	}

	maps\df_fly_flight_code::set_optimal_flight_dist(param_00);
	if(isdefined(param_01))
	{
		if(isdefined(param_02))
		{
			while(isalive(self) && distance(level.player.origin,self.origin) > param_02)
			{
				wait(0.1);
			}
		}

		if(isdefined(self))
		{
			self.has_flares = param_01;
		}
	}
}

//Function Number: 21
left_canyon1()
{
	var_00 = [];
	common_scripts\utility::flag_wait("enemy_ambush");
	var_01 = maps\df_fly_flight_code::get_jet_array("canyon_enemy1_left","script_noteworthy");
	var_02 = maps\df_fly_flight_code::get_jet_array("canyon_enemy1_right","script_noteworthy");
	if(common_scripts\utility::flag("left_canyon1") && var_01.size > 1)
	{
		var_00 = var_02;
	}

	if(!common_scripts\utility::flag("left_canyon1") && var_02.size > 1)
	{
		var_00 = var_01;
	}

	foreach(var_04 in var_00)
	{
		var_04 delete();
	}
}

//Function Number: 22
begin_canyon2()
{
	hide_mountains();
	thread canyon_ally_vo2();
	thread flak_scenario1();
	thread maps\df_fly_code::handle_turrets("enemy_turret_b","the_peak","allies_split_vo");
	common_scripts\utility::flag_wait("canyon_enemy3_warning");
	common_scripts\utility::flag_clear("target_player");
	thread maps\df_fly_code::handle_turrets("enemy_turret","canyon_enemy3_warning","allies_split_vo");
	if(!isdefined(level.enemies))
	{
		level.enemies = [];
	}

	var_00 = level.enemies;
	var_00 = common_scripts\utility::array_combine(var_00,maps\df_fly_flight_code::get_jet_array("canyon_enemy2","script_noteworthy"));
	var_00 = maps\_utility::remove_dead_from_array(var_00);
	level.allies = maps\_utility::remove_dead_from_array(level.allies);
	thread maps\df_fly_flight_code::engage_enemies(level.allies,var_00,1,1,2,1);
	common_scripts\utility::array_thread(level.allies,::maps\df_fly_flight_code::set_optimal_flight_dist,-5000);
	common_scripts\utility::flag_wait("canyon_enemy4");
	var_01 = maps\df_fly_flight_code::spawn_enemy_jets("canyon_enemy4");
	common_scripts\utility::array_thread(var_00,::player_catch_up_on_boost,5000,1,7000);
	common_scripts\utility::flag_wait("allies_drop_back");
	common_scripts\utility::array_thread(level.allies,::maps\df_fly_flight_code::set_optimal_flight_dist,-5000);
	common_scripts\utility::flag_wait("autosave");
	maps\_utility::autosave_by_name("second_corner");
	maps\_utility::delaythread(3,::common_scripts\utility::flag_clear,"autosave");
	thread maps\df_fly_code::handle_missile_jet("hoodoo_w1_missile","missile_jet_hoodoo_w1","hoodoo_w1");
	common_scripts\utility::flag_wait("enemies_drop_back");
	level.enemy_units = maps\_utility::remove_dead_from_array(level.enemy_units);
	common_scripts\utility::flag_wait("split_reinforcements");
	var_02 = maps\_utility::make_array("rs1","rs2","ls1","ls2");
	foreach(var_04 in var_02)
	{
		if(common_scripts\utility::flag(var_04))
		{
			maps\df_fly_flight_code::spawn_enemy_jets(var_04);
		}
	}

	thread white_hoodoos();
	var_06 = [];
	foreach(var_08 in level.enemy_units)
	{
		if(!maps\df_fly_flight_code::is_true(var_08.ground_target))
		{
			var_06[var_06.size] = var_08;
		}
	}

	level.enemy_units = var_06;
	var_0A = 2000;
	foreach(var_0C in level.enemy_units)
	{
		var_0C maps\df_fly_flight_code::set_optimal_flight_dist(var_0A);
		var_0A = var_0A + 1000;
	}

	level.allies = maps\_utility::remove_dead_from_array(level.allies);
	thread maps\df_fly_code::adjust_bounce_lookahead(0.25,"tighten_up","loosen_up");
	common_scripts\utility::flag_wait_any("canyon_left2","canyon_right2");
	maps\_utility::delaythread(0.5,::maps\df_fly_code::handle_missile_jet,"canyon_right2","missile_jet_arch_r","arch_r",1);
	maps\_utility::delaythread(0.5,::maps\df_fly_code::fake_missile_from_behind_player,"canyon_left2","left_arch_missile_targ","arch_l","left_arch_missile_start");
	thread maps\df_fly_code::fake_missile_from_behind_player("canyon_left2","left_arch_missile_targ","arch_l","left_arch_missile_start");
	thread maps\df_fly_code::fake_missile_from_behind_player("canyon_left2","left_hoodoo_missile_targ","hoodoo_w2","left_arch_missile_start");
	thread maps\df_fly_code::fake_missile_from_behind_player("hoodoo_w5_missile","left_hoodoo_missile_targ3","hoodoo_w5","left_hoodoo_missile_source3");
	thread maps\df_fly_code::fake_missile_from_behind_player("hoodoo_w3_missile","right_hoodoo_missile_targ3","hoodoo_w3","right_hoodoo_missile_source3");
	thread maps\df_fly_code::fake_missile_from_behind_player("shoot_hoodoo_w4","hoodoo_w4_targ","hoodoo_w4","hoodoo_w4_start");
	common_scripts\utility::array_thread(level.allies,::maps\df_fly_flight_code::set_optimal_flight_dist,-5000);
	if(common_scripts\utility::flag("canyon_left2"))
	{
		var_0E = maps\df_fly_flight_code::get_jet_array("righty2","script_noteworthy");
		thread maps\df_fly_flight_code::process_flight_path("left_canyon_path");
	}
	else
	{
		var_0E = maps\df_fly_flight_code::get_jet_array("lefty2","script_noteworthy");
		thread maps\df_fly_flight_code::process_flight_path("right_canyon_path");
	}

	foreach(var_0C in var_0E)
	{
		var_0C delete();
	}

	level.enemy_units = maps\_utility::remove_dead_from_array(level.enemy_units);
	if(level.enemy_units.size < 2)
	{
		if(common_scripts\utility::flag("canyon_left2"))
		{
			var_11 = "lefty3";
		}
		else
		{
			var_11 = "righty3";
		}

		maps\df_fly_flight_code::spawn_enemy_jets(var_11);
	}

	common_scripts\utility::flag_wait("turrets2");
	level.enemy_units = maps\_utility::remove_dead_from_array(level.enemy_units);
	common_scripts\utility::array_thread(level.enemy_units,::maps\df_fly_flight_code::set_optimal_flight_dist,3000);
	thread maps\df_fly_code::handle_turrets("enemy_turret_dam","turrets2","enemies6");
	thread maps\df_fly_code::handle_turrets("enemy_turret2","turrets2","start_dam_run");
	level.enemy_units = maps\_utility::remove_dead_from_array(level.enemy_units);
	var_12 = level.enemy_units;
	common_scripts\utility::flag_wait("canyon_merge1");
	var_12 = maps\_utility::remove_dead_from_array(var_12);
	if(var_12.size > 0)
	{
		thread maps\df_fly_flight_code::engage_enemies(level.allies,var_12,0.5,2,1,2);
	}
}

//Function Number: 23
begin_canyon_dam()
{
	maps\_utility::autosave_by_name("dam_area");
	var_00 = getentarray("terrain_shadow_fix","targetname");
	common_scripts\utility::array_call(var_00,::hide);
	common_scripts\utility::array_thread(level.allies,::maps\df_fly_flight_code::set_optimal_flight_dist,2000);
	thread maps\df_fly_code::handle_turrets("enemy_turret3","allies_fire_dam_missile","narrows_flyby");
	thread dam_enemies();
	thread dam_objective();
	thread canyon_ally_vo_dam();
	var_01 = gettime();
	var_02 = var_01 + 1000;
	common_scripts\utility::array_thread(level.allies,::switch_path,"switch_paths");
	for(var_03 = 0;var_03 < level.friend_jets.size;var_03++)
	{
		level.friend_jets[var_03].script_noteworthy = common_scripts\utility::tostring(var_03 + 1);
	}

	common_scripts\utility::array_thread(level.friend_jets,::switch_path,"switch_paths");
	common_scripts\utility::flag_wait_any("ally_tailer_dead","enemies6");
	common_scripts\utility::flag_wait("start_dam");
	maps\_utility::autosave_by_name("dam_start");
	common_scripts\utility::flag_wait("dam_cracks1");
}

//Function Number: 24
dam_objective()
{
	common_scripts\utility::flag_wait("start_dam_run");
	level.dam_targ = getent("dam_target","script_noteworthy");
	thread handle_dam_targets();
	var_00 = getent("allly_dam_trigger","targetname");
	common_scripts\utility::array_thread(level.allies,::ally_fire_on_dam,var_00);
	wait(0.5);
	thread maps\df_fly_fx::vfx_dam_setup();
	common_scripts\utility::flag_wait("dam_cracks1");
	wait(0.75);
	common_scripts\utility::flag_set("dam_cracks2");
}

//Function Number: 25
ally_fire_on_dam(param_00)
{
	var_01 = level.player;
	while(var_01 != self)
	{
		param_00 waittill("trigger",var_01);
	}

	if(isalive(level.dam_targ))
	{
		thread maps\df_fly_flight_code::ai_shoot_missile_salvo(level.dam_targ,1);
	}
}

//Function Number: 26
handle_dam_targets()
{
	if(!isdefined(level.enemy_units))
	{
		level.enemy_units = [];
	}

	level.dam_targ setcandamage(1);
	level.dam_targ setcanradiusdamage(1);
	level.dam_targ.default_hud = "hud_fofbox_hostile_obstructed";
	level.dam_targ.health = 100;
	level.dam_targ.ground_target = 1;
	level.enemy_units[level.enemy_units.size] = level.dam_targ;
	level.dam_targ thread maps\df_fly_flight_code::hud_target_think();
	level.dam_targ thread dam_target_death();
	common_scripts\utility::flag_wait("dam_destroyed");
	if(isdefined(level.dam_targ))
	{
		level.enemy_units = common_scripts\utility::array_remove(level.enemy_units,level.dam_targ);
		level.dam_targ delete();
	}
}

//Function Number: 27
dam_target_death()
{
	var_00 = self.origin;
	self waittill("death");
	if(!maps\df_fly_flight_code::is_true(level.dam_destroyed))
	{
		level.dam_destroyed = 1;
		common_scripts\_exploder::exploder(10);
		soundscripts\_snd::snd_message("dam_explode");
	}

	if(isdefined(self))
	{
		level.enemy_units = common_scripts\utility::array_remove(level.enemy_units,self);
		self delete();
	}

	wait(1);
	common_scripts\utility::flag_set("dam_destroyed");
}

//Function Number: 28
dam_enemies()
{
	common_scripts\utility::flag_wait("dam_cracks1");
	common_scripts\utility::flag_set("dam_destroyed");
	maps\_utility::autosave_by_name("dam_enemies");
	var_00 = maps\df_fly_flight_code::spawn_enemy_jets("canyon_enemy5b");
}

//Function Number: 29
begin_canyon3()
{
	while(!isdefined(level.allies) || !isdefined(level.allies[1]))
	{
		wait 0.05;
	}

	level.allies[0].has_flares = 9999;
	level.allies[1].has_flares = 9999;
	if(isdefined(level.allies[2]) && isalive(level.allies[2]))
	{
		level.allies[2].has_flares = 2;
	}

	maps\_utility::autosave_by_name("canyon3");
	thread canyon_ally_vo3();
	common_scripts\utility::flag_wait("dam_cracks1");
	common_scripts\utility::array_thread(level.allies,::maps\df_fly_flight_code::set_optimal_flight_dist,-5000);
	common_scripts\utility::flag_wait("enemies6");
	common_scripts\utility::flag_set("target_player");
	thread maps\df_fly_flight_code::process_flight_path("canyon_run_start3_path");
	maps\_utility::stop_exploder(10);
	thread handle_train_bridge();
	var_00 = maps\df_fly_flight_code::spawn_enemy_jets("canyon_enemy6","targetname",1);
	thread monitor_airbrake(var_00);
	thread maps\df_fly_flight_code::engage_enemies(var_00,level.allies,1,3,1,1);
	wait(2);
	common_scripts\utility::flag_set("airbrake_hint");
	common_scripts\utility::flag_wait_any("narrows_flyby","player_braking");
	foreach(var_02 in var_00)
	{
		var_02 notify("stop_engaging");
	}

	level.allies = maps\_utility::remove_dead_from_array(level.allies);
	common_scripts\utility::flag_set("player_braking");
	wait(2);
	var_00 = maps\_utility::remove_dead_from_array(var_00);
	common_scripts\utility::array_thread(var_00,::maps\_vehicle::godoff);
	common_scripts\utility::flag_wait("enemies7");
	maps\_utility::autosave_by_name("through_narrows");
	var_00 = maps\_utility::remove_dead_from_array(var_00);
	thread maps\df_fly_flight_code::engage_enemies(level.allies,var_00,1,1,2,1);
	common_scripts\utility::flag_clear("target_player");
	var_00 = maps\df_fly_flight_code::spawn_enemy_jets("canyon_enemy7");
	foreach(var_02 in var_00)
	{
		var_02.has_flares = 5;
	}

	level.allies = maps\_utility::remove_dead_from_array(level.allies);
	thread maps\df_fly_code::adjust_bounce_lookahead(0.25,"tighten_up2","enemies9");
	common_scripts\utility::flag_wait("chicken_run");
	common_scripts\utility::flag_set("target_player");
	common_scripts\utility::array_thread(var_00,::pop_flares_when_fired_on);
	common_scripts\utility::array_thread(var_00,::fire_on_allies,"enemy_chicken_fire");
	thread maps\df_fly_flight_code::engage_enemies(level.allies,var_00,1,3,1,1);
	thread maps\df_fly_code::handle_missile_jet("enemies8","missile_jet8","hoodoo1",1,1);
	thread red_hoodoos();
	common_scripts\utility::flag_wait("enemies8");
	thread maps\df_fly_code::handle_turrets("enemy_turret4","5miles","canyon_finished");
	thread maps\df_fly_code::fake_missile_from_behind_player("red_hoodoo_missile1","hoodoo_missile_target1","red_hoodoo1");
	thread domino_hoodoos();
	maps\_utility::autosave_by_name("past_chicken");
	common_scripts\utility::array_thread(level.allies,::maps\df_fly_flight_code::set_optimal_flight_dist,-5000);
	var_00 = maps\df_fly_flight_code::spawn_enemy_jets("canyon_enemy8");
	foreach(var_02 in var_00)
	{
		var_02.has_flares = 5;
	}

	common_scripts\utility::flag_wait("enemies9");
	maps\_utility::autosave_by_name("near_end");
	var_08 = maps\_utility::remove_dead_from_array(level.enemy_units);
	foreach(var_02 in var_08)
	{
		var_02.has_flares = 0;
	}

	thread maps\df_fly_flight_code::engage_enemies(level.allies,var_08,0.5,2,1,1);
	thread maps\df_fly_code::handle_turrets("enemy_turret4b","enemies9","canyon_finished");
	common_scripts\utility::flag_wait("clean_up_enemies");
	var_08 = maps\_utility::remove_dead_from_array(level.enemy_units);
	thread maps\df_fly_flight_code::engage_enemies(level.allies,var_08,0.5,2,1,1);
}

//Function Number: 30
domino_hoodoos()
{
	thread maps\df_fly_code::handle_missile_jet("red_hoodoo_missile3","red_hoodoo_domino_crasher","red_hoodoo3",1,0);
	common_scripts\utility::flag_wait("red_hoodoo3");
	wait(0.9);
	var_00 = getent("domino_hoodoo_hit1","targetname");
	playfx(common_scripts\utility::getfx("bagh_hoodoo_impact1_crack_large"),var_00.origin,anglestoforward(var_00.angles));
	common_scripts\utility::flag_set("red_hoodoo3b");
	wait(1.3);
	var_00 = getent("domino_hoodoo_hit2","targetname");
	playfx(common_scripts\utility::getfx("bagh_hoodoo_domino_impact1"),var_00.origin,anglestoforward(var_00.angles));
	common_scripts\utility::flag_set("red_hoodoo3c");
}

//Function Number: 31
handle_train_bridge()
{
	thread maps\df_fly_code::handle_missile_jet("train_missile","train_missile_jet","bridge_fall",1);
	var_00 = getentarray("trainbridge","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02.animname = var_02.animation;
		var_02 useanimtree(level.scr_animtree[var_02.animation]);
	}

	common_scripts\utility::flag_wait("bridge_fall");
	soundscripts\_snd::snd_message("bridge_fall");
	common_scripts\_exploder::exploder(20);
	foreach(var_02 in var_00)
	{
		var_02 thread maps\_anim::anim_single_solo(var_02,"destroy");
		var_02 setanimrate(var_02 maps\_utility::getanim("destroy"),1.5);
	}

	wait(0.5);
	maps\df_fly_code::radio_dialog_add_and_go("df_nox_bridgeout3");
	maps\df_fly_code::radio_dialog_add_and_go("df_gid_heavydebris");
	wait(1);
	maps\df_fly_code::radio_dialog_add_and_go("df_gid_acp5");
}

//Function Number: 32
white_hoodoos()
{
	var_00 = [];
	for(var_01 = 1;var_01 <= 5;var_01++)
	{
		var_02 = "hoodoo_w" + var_01;
		var_00[var_00.size] = getent(var_02,"targetname");
	}

	common_scripts\utility::array_thread(var_00,::white_hoodoo_fx);
}

//Function Number: 33
white_hoodoo_fx()
{
	self waittill("fall_down");
	var_00 = common_scripts\utility::getfx("bagh_hoodoo_dust_trail");
	playfxontag(var_00,self,"Tag_fx_top");
	playfxontag(var_00,self,"Tag_fx_mid");
	self waittillmatch("end","single anim");
	stopfxontag(var_00,self,"Tag_fx_top");
	stopfxontag(var_00,self,"Tag_fx_mid");
}

//Function Number: 34
red_hoodoos()
{
	var_00 = getentarray("crumble_hoodoo","targetname");
	var_01 = getentarray("wall_hoodoo","targetname");
	var_00 = common_scripts\utility::array_combine(var_00,var_01);
	common_scripts\utility::array_thread(var_00,::crumble_hoodoo_fx);
	var_00 = getentarray("red_hoodoo2","targetname");
	common_scripts\utility::array_thread(var_00,::red_hoodoo_fx);
}

//Function Number: 35
crumble_hoodoo_fx()
{
	self waittill("fall_down");
	var_00 = common_scripts\utility::getfx("bagh_hoodoo_dust_trail");
	playfxontag(var_00,self,"tag_fx_1");
	playfxontag(var_00,self,"tag_fx_2");
	playfxontag(var_00,self,"tag_fx_4");
	self waittillmatch("end","single anim");
	stopfxontag(var_00,self,"tag_fx_1");
	stopfxontag(var_00,self,"tag_fx_2");
	stopfxontag(var_00,self,"tag_fx_4");
}

//Function Number: 36
red_hoodoo_fx()
{
	self waittill("fall_down");
	var_00 = common_scripts\utility::getfx("bagh_hoodoo_dust_trail");
	playfxontag(var_00,self,"tag_fx_1");
	playfxontag(var_00,self,"tag_fx_2");
	self waittillmatch("end","single anim");
	stopfxontag(var_00,self,"tag_fx_1");
	stopfxontag(var_00,self,"tag_fx_2");
}

//Function Number: 37
red_hoodoo1()
{
	common_scripts\utility::flag_wait("hoodoo1");
	var_00 = getent("hoodoo1","targetname");
	var_01 = common_scripts\utility::getfx("bagh_hoodoo_dust_trail");
	playfxontag(var_01,var_00,"TAG_FX_TOP_1");
	playfxontag(var_01,var_00,"TAG_FX_TOP_2");
	playfxontag(var_01,var_00,"TAG_FX_TOP_3");
	playfxontag(var_01,var_00,"TAG_FX_TOP_4");
	wait(5);
	stopfxontag(var_01,var_00,"TAG_FX_TOP_1");
	stopfxontag(var_01,var_00,"TAG_FX_TOP_2");
	stopfxontag(var_01,var_00,"TAG_FX_TOP_3");
	stopfxontag(var_01,var_00,"TAG_FX_TOP_4");
}

//Function Number: 38
pop_flares_when_fired_on()
{
	self endon("death");
	while(isalive(self))
	{
		self waittill("missile_fired_at");
		wait(randomfloat(0.5));
		playfx(common_scripts\utility::getfx("missile_repel"),self.origin);
	}
}

//Function Number: 39
fire_on_allies(param_00)
{
	self endon("death");
	var_01 = getent(param_00,"targetname");
	var_02 = level.player;
	while(var_02 != self)
	{
		var_01 waittill("trigger",var_02);
	}

	var_03 = randomint(level.allies.size);
	maps\df_fly_flight_code::engage_enemies(maps\_utility::make_array(self),maps\_utility::make_array(level.allies[var_03]),0,2,1,1);
}

//Function Number: 40
airbrake_hint()
{
	if(level.player_airbraked)
	{
		return 1;
	}

	return 0;
}

//Function Number: 41
monitor_airbrake(param_00)
{
	thread trailing_jets_move_up_on_airbrake(param_00);
	common_scripts\utility::flag_wait("airbrake_hint");
	level.player_airbraked = 0;
	thread maps\df_fly_code::radio_dialog_add_and_go("df_gid_yourtail");
	level.player_airbraked = 1;
	common_scripts\utility::flag_set("player_braking");
	common_scripts\utility::flag_wait_or_timeout("player_braking",5);
	if(!common_scripts\utility::flag("player_braking"))
	{
		thread maps\df_fly_code::radio_dialog_add_and_go("df_gid_airbrake");
	}
}

//Function Number: 42
trailing_jets_move_up_on_airbrake(param_00)
{
	common_scripts\utility::flag_wait("player_braking");
	param_00 = maps\_utility::remove_dead_from_array(param_00);
	level.allies = maps\_utility::remove_dead_from_array(level.allies);
	common_scripts\utility::array_thread(param_00,::maps\df_fly_flight_code::set_optimal_flight_dist,2000);
	common_scripts\utility::array_thread(level.allies,::maps\df_fly_flight_code::set_optimal_flight_dist,-5000);
}

//Function Number: 43
switch_path(param_00)
{
	var_01 = getent(param_00,"targetname");
	var_02 = level.player;
	while(var_02 != self)
	{
		var_01 waittill("trigger",var_02);
	}

	var_03 = var_02.script_noteworthy[var_02.script_noteworthy.size - 1];
	var_04 = var_01.script_parameters + var_03;
	var_05 = getvehiclenode(var_04,"targetname");
	var_02 thread maps\_vehicle::vehicle_paths(var_05);
	var_02 startpath(var_05);
}

//Function Number: 44
flare_warning()
{
	level.player waittill("enemy_lock_on");
	maps\_utility::radio_dialogue_stop();
	maps\df_fly_code::radio_dialog_add_and_go("df_gid_lockonyou");
}

//Function Number: 45
flares_hint()
{
	if(level.player_popped_flares)
	{
		return 1;
	}

	return 0;
}

//Function Number: 46
handle_flak(param_00,param_01)
{
	common_scripts\utility::flag_wait(param_01);
	var_02 = getentarray(param_00,"targetname");
	common_scripts\utility::array_thread(var_02,::flak_explode);
}

//Function Number: 47
flak_scenario1()
{
	thread maps\df_fly_code::handle_flak_cannons("flak_cannon","the_peak","allies_drop_back");
	thread flak_nag_vo();
	common_scripts\utility::flag_wait("canyon_enemy3_warning");
	handle_flak("flak_origin1","canyon_enemy3_warning");
	common_scripts\utility::flag_wait("flak2");
	var_00 = getentarray("flak_origin2","targetname");
	common_scripts\utility::array_thread(var_00,::flak_explode);
	common_scripts\utility::flag_wait("flak3");
	var_00 = getentarray("flak_origin3","targetname");
	common_scripts\utility::array_thread(var_00,::flak_explode);
	common_scripts\utility::flag_wait("flak4");
	var_00 = getentarray("flak_origin4","targetname");
	common_scripts\utility::array_thread(var_00,::flak_explode);
	common_scripts\utility::flag_wait("flak5");
	var_00 = getentarray("flak_origin5","targetname");
	common_scripts\utility::array_thread(var_00,::flak_explode);
}

//Function Number: 48
flak_explode()
{
	if(isdefined(self.script_parameters))
	{
		wait(float(self.script_parameters));
	}

	wait(randomfloat(0.2));
	playfx(common_scripts\utility::getfx("flak_explosion"),self.origin);
	self playsound("flak_expl");
	var_00 = vectornormalize(level.plane.origin - self.origin);
	if(distancesquared(level.plane.origin,self.origin) <= 6250000)
	{
		level.player playsound("plr_jet_hit_by_missile_lyr1");
		if(level.player_boosting)
		{
			level.plane notify("damage",100,undefined,var_00,level.plane.origin,"flak_pepper");
			level.plane vehicle_teleport(level.plane.origin,level.plane.angles + (0,0,25));
			return;
		}

		level.plane notify("damage",100,undefined,var_00,level.plane.origin,"flak_hit");
		level.plane vehicle_teleport(level.plane.origin,level.plane.angles + (0,0,45));
		return;
	}

	var_01 = spawn("trigger_radius",self.origin - (0,0,2500),1,2500,5000);
	var_01 thread flak_pepper_player(self.origin);
	var_01 common_scripts\utility::waittill_notify_or_timeout("trigger",2);
	var_01 delete();
}

//Function Number: 49
flak_pepper_player(param_00)
{
	self waittill("trigger");
	var_01 = vectornormalize(level.plane.origin - param_00);
	level.plane notify("damage",100,undefined,var_01,param_00,"flak_pepper");
}

//Function Number: 50
flak_nag_vo()
{
	level endon("finale");
	var_00 = [];
	var_00[0] = "df_gid_watchflak";
	var_00[1] = "df_gid_chrewedup";
	var_00[2] = "df_gid_dropdown";
	var_01 = 0;
	for(;;)
	{
		level.plane waittill("damage",var_02,var_03,var_04,var_05,var_06);
		if(var_06 == "flak_pepper" || var_06 == "flak_hit")
		{
			maps\df_fly_code::radio_dialog_add_and_go(var_00[var_01]);
			wait(1);
			var_01++;
			if(var_01 >= var_00.size)
			{
				var_01 = 0;
			}
		}
	}
}

//Function Number: 51
bump_nag_vo()
{
	level endon("finale");
	var_00 = [];
	var_00[0] = "df_gid_watchwings";
	var_00[1] = "df_nox_tooclose1";
	var_00[2] = "df_gid_headsup11";
	var_00[3] = "df_gid_steerclear";
	var_00[4] = "df_nox_damn4";
	var_01 = 0;
	for(;;)
	{
		level.plane waittill("plane_bump");
		maps\df_fly_code::radio_dialog_add_and_go(var_00[var_01]);
		wait(5);
		var_01++;
		if(var_01 >= var_00.size)
		{
			var_01 = 0;
		}
	}
}

//Function Number: 52
begin_canyon_intro()
{
	thread maps\df_fly::intro_movie();
	common_scripts\utility::flag_wait("intro_screen_done");
	common_scripts\utility::flag_wait("intro_screen_done");
	level.player freezecontrols(0);
	common_scripts\utility::flag_set("intro_finished");
	maps\df_fly_flight_code::flight_code_start("canyon_run_start");
	thread maps\df_fly::handle_gun_hint();
}

//Function Number: 53
canyon_intro_vo()
{
	soundscripts\_snd::snd_music_message("df_fly_intro");
	soundscripts\_snd::snd_message("fly_fade_in_intro");
	level.player maps\df_fly_code::radio_dialog_add_and_go("df_gid_nought");
	level.player maps\df_fly_code::radio_dialog_add_and_go("df_kp_rogerthat10");
	level.player maps\df_fly_code::radio_dialog_add_and_go("df_kp_lowlevel10");
	level.player maps\df_fly_code::radio_dialog_add_and_go("df_kp_kingpinout");
	level.player maps\df_fly_code::radio_dialog_add_and_go("df_gid_fencein10");
	level.player maps\df_fly_code::radio_dialog_add_and_go("df_gid_engageanything");
	common_scripts\utility::flag_set("intro_vo_done");
}

//Function Number: 54
canyon_ally_vo()
{
	common_scripts\utility::flag_set("hint_time");
	wait(0.5);
	level.player thread maps\df_fly_code::radio_dialog_add_and_go("ds_gid_3bandits");
	level.player thread maps\df_fly_code::radio_dialog_add_and_go("ds_gid_12oclocklow3");
	level.player maps\df_fly_code::radio_dialog_add_and_go("ds_gid_timetobump");
	common_scripts\utility::flag_wait("speed_boost1");
	maps\df_fly_code::radio_dialog_add_and_go("df_gid_trancers");
	common_scripts\utility::flag_wait("canyon_enemy2");
	maps\df_fly_code::radio_dialog_add_and_go("df_gid_acp3");
	common_scripts\utility::flag_wait("canyon_enemy2a");
	thread maps\df_fly_code::radio_dialog_add_and_go("df_nox_overridge");
	thread maps\df_fly_code::radio_dialog_add_and_go("df_gid_tapem");
	wait(1.5);
	common_scripts\utility::flag_set("target_player");
}

//Function Number: 55
canyon_ally_vo2()
{
	common_scripts\utility::flag_wait("canyon_enemy3_warning");
	level.player thread maps\_utility::display_hint_timeout("boost_hint",5);
	thread maps\df_fly_code::radio_dialog_add_and_go("df_nox_flakahead");
	maps\df_fly_code::radio_dialog_add_and_go("df_gid_useblower");
	common_scripts\utility::flag_wait("flak3");
	maps\df_fly_code::radio_dialog_add_and_go("df_knox_phallanx");
	common_scripts\utility::flag_wait("canyon_enemy4");
	wait(1);
	thread maps\df_fly_code::radio_dialog_add_and_go("df_nox_4birds");
	maps\df_fly_code::radio_dialog_add_and_go("df_gid_engage2");
	common_scripts\utility::flag_wait("acp4");
	maps\df_fly_code::radio_dialog_add_and_go("df_gid_acp4");
	common_scripts\utility::flag_wait("allies_split_vo");
	maps\df_fly_code::radio_dialog_add_and_go("df_gid_rightcanyon");
	maps\df_fly_code::radio_dialog_add_and_go("df_nox_takingleft1");
	common_scripts\utility::flag_wait_any("canyon_left2","canyon_right2");
	maps\df_fly_code::radio_dialog_add_and_go("df_nox_watchyoursix");
	wait(0.5);
	thread maps\df_fly_code::radio_dialog_add_and_go("df_nox_rockfall");
	maps\df_fly_code::radio_dialog_add_and_go("df_gid_watchdebris55");
	common_scripts\utility::flag_wait("close_call");
	maps\df_fly_code::radio_dialog_add_and_go("df_nox_watchhead2");
}

//Function Number: 56
canyon_ally_vo_dam()
{
	maps\df_fly_code::radio_dialog_add_and_go("df_nox_approachingdam");
	maps\df_fly_code::radio_dialog_add_and_go("df_gid_hardpoints");
	common_scripts\utility::flag_wait("dam_destroyed");
	maps\df_fly_code::radio_dialog_add_and_go("df_gid_directhit");
	maps\df_fly_code::radio_dialog_add_and_go("df_gid_watchdebris");
}

//Function Number: 57
canyon_ally_vo3()
{
	common_scripts\utility::flag_wait("enemies6");
	maps\df_fly_code::radio_dialog_add_and_go("df_gid_closingin");
	common_scripts\utility::flag_wait("enemies7");
	maps\df_fly_code::radio_dialog_add_and_go("df_nox_4bandits");
	common_scripts\utility::flag_wait("chicken_run");
	common_scripts\utility::flag_wait("enemies8");
	maps\df_fly_code::radio_dialog_add_and_go("df_nox_backaround");
	wait(3);
	maps\df_fly_code::radio_dialog_add_and_go("df_gid_getinclose");
	common_scripts\utility::flag_wait("5miles");
	maps\df_fly_code::radio_dialog_add_and_go("df_nox_5miles");
	common_scripts\utility::flag_wait("almost_done");
	maps\df_fly_code::radio_dialog_add_and_go("df_gid_stayfocused");
}

//Function Number: 58
ambush_ambushed_vo(param_00,param_01)
{
	thread maps\df_fly_code::ai_array_killcount_flag_set(param_01,param_01.size,"ambush_dead");
	common_scripts\utility::flag_wait("ambush_dead");
	param_00 = maps\_utility::remove_dead_from_array(param_00);
	if(param_00.size > 0)
	{
		maps\df_fly_code::radio_dialog_add_and_go("df_mag_savedtail");
	}
}

//Function Number: 59
redshirt_death_vo()
{
	level endon("finale");
	self waittill("death");
	maps\_utility::radio_dialogue_stop();
	thread maps\df_fly_code::radio_dialog_add_and_go("df_mag_i\'mhit");
	maps\df_fly_code::radio_dialog_add_and_go("df_mag_aaaaah");
}

//Function Number: 60
begin_canyon_exit()
{
	setsaveddvar("vehPlanePathAllowance",20);
	thread maps\df_fly_flight_code::process_flight_path("canyon_end_close");
	thread jet_shakes();
	common_scripts\utility::flag_wait("canyon_finished");
	soundscripts\_snd::snd_music_message("df_fly_ending");
	soundscripts\_snd::snd_message("fly_ending_mix");
	level notify("finale");
	level.plane notify("finale");
	thread deploy_sequence();
	common_scripts\utility::flag_wait("black_out");
	thread maps\_hud_util::fade_out(0.5);
	common_scripts\utility::flag_wait("finale_vo_done");
	maps\_utility::nextmission();
}

//Function Number: 61
jet_shakes()
{
	maps\df_fly_flight_code::fighter_jet_set_shake(3,1.5);
	wait(2);
	maps\df_fly_flight_code::fighter_jet_set_shake(2,1);
}

//Function Number: 62
ambient_combat_vo(param_00)
{
	level endon("death");
	var_01 = 8;
	var_02 = [];
	var_02[0] = "df_gid_boola";
	var_02[1] = "df_nox_trgtdestroyed";
	var_02[2] = "df_gid_bravozulu";
	var_02[3] = "df_nox_gotone1";
	var_03 = [];
	var_03[0] = "df_gid_niceshot";
	var_03[1] = "df_gid_sierrahotel";
	var_03[2] = "df_nox_niceshootin";
	var_03[3] = "df_gid_goodshot";
	var_03[4] = "df_nox_goodone";
	var_03[5] = "df_gid_bravozulu";
	var_04 = [];
	var_04[0] = "df_gid_onedown";
	var_04[1] = "df_gid_thatstwo1";
	var_04[2] = "df_gid_thatsall";
	var_05 = [];
	var_05[0] = "df_gid_inmysights";
	var_05[1] = "df_nox_gotthisone";
	var_05[2] = "df_gid_onim";
	var_05[3] = "df_nox_thatonesmine";
	var_06 = "";
	var_07 = 0;
	var_08 = 0;
	var_09 = 0;
	var_0A = 0;
	for(;;)
	{
		var_0B = level common_scripts\utility::waittill_any_return("enemy_dead","enemy_dead_by_player","ally_targeting_enemy");
		if(isdefined(param_00) && !common_scripts\utility::flag(param_00) && var_0A < var_04.size)
		{
			var_06 = var_04[var_0A];
			var_0A++;
		}
		else if(var_0B == "ally_targeting_enemy")
		{
			var_06 = var_05[var_09];
			var_09++;
			if(var_09 >= var_05.size)
			{
				var_09 = 0;
			}
		}
		else if(var_0B == "enemy_dead_by_player")
		{
			var_06 = var_03[var_08];
			var_08++;
			if(var_08 >= var_03.size)
			{
				var_08 = 0;
			}
		}
		else
		{
			var_06 = var_02[var_07];
			var_07++;
			if(var_07 >= var_02.size)
			{
				var_07 = 0;
			}
		}

		if(maps\_utility::radio_dialogue_safe(var_06) && !isdefined(param_00) || !common_scripts\utility::flag(param_00))
		{
			wait(var_01);
		}
	}
}

//Function Number: 63
stay_low_nags()
{
	level endon("death");
	var_00 = [];
	var_00[0] = "df_gid_incanyon";
	var_00[1] = "df_gid_headdown";
	var_00[2] = "df_gid_staylow2";
	var_00[3] = "df_gid_2000agl";
	var_01 = 0;
	common_scripts\utility::flag_waitopen_or_timeout("stay_low",20);
	for(;;)
	{
		common_scripts\utility::flag_wait("stay_low");
		maps\df_fly_code::radio_dialog_add_and_go(var_00[var_01]);
		var_01++;
		if(var_01 > var_00.size)
		{
			var_01 = 0;
		}

		common_scripts\utility::flag_waitopen_or_timeout("stay_low",10);
	}
}

//Function Number: 64
canopy_fade_in_cinematic()
{
	cinematicingame("df_canopy_transition");
	while(cinematicgetframe() < 2)
	{
		wait 0.05;
	}

	pausecinematicingame(1);
}

//Function Number: 65
deploy_sequence()
{
	var_00 = level.plane vehicle_getspeed();
	maps\df_fly_flight_code::fighter_jet_set_shake(4,0.25);
	level.player notify("toggle_chase_cam");
	level notify("end_canyon");
	level.plane notify("end_canyon");
	level.player notify("remove_jet_hud");
	level.player notify("end_canyon");
	setsaveddvar("cg_cinematicFullScreen","0");
	thread canopy_fade_in_cinematic();
	luinotifyevent(&"plane_hud_fade_out",1,5000);
	var_01 = maps\_utility::spawn_anim_model("pod");
	level.finale_pod = var_01;
	level.finale_pod hidepart("TAG_TRANSFER_AR");
	var_02 = maps\_utility::spawn_anim_model("pod_l");
	var_03 = maps\_utility::spawn_anim_model("pod_r");
	var_04 = maps\_utility::spawn_anim_model("jet");
	var_04 hide();
	level.finale_jet = var_04;
	var_05 = maps\_utility::spawn_anim_model("jet_l");
	var_06 = maps\_utility::spawn_anim_model("jet_r");
	var_07 = maps\_utility::spawn_anim_model("player_rig");
	var_08 = maps\_utility::spawn_anim_model("finale_genProp");
	level.fake_plane unlinkfromplayerview(level.player);
	var_01.origin = level.fake_plane.origin;
	var_01.angles = level.fake_plane.angles;
	var_01 thread maps\_anim::anim_loop_solo(var_01,"idle","stop_loop");
	level.plane maps\_utility::ent_flag_clear("engineeffects");
	var_09 = [var_07,var_02,var_03,var_04,var_05,var_06];
	common_scripts\utility::array_call(var_09,::hide);
	var_0A = common_scripts\utility::getstruct("finale_struct","targetname");
	level.player dismountvehicle();
	level.player unlink();
	level.player disableweapons();
	level.player allowcrouch(0);
	level.player disableoffhandweapons();
	level.player disableweaponswitch();
	level.plane hide();
	if(isdefined(level.allies))
	{
		foreach(var_0C in level.allies)
		{
			if(isdefined(var_0C))
			{
				var_0C delete();
			}
		}
	}

	thread deploy_vo();
	var_09 = common_scripts\utility::array_add(var_09,var_01);
	var_0A maps\_anim::anim_first_frame_solo(var_08,"deploy");
	level.player playerlinktoabsolute(var_01,"tag_player");
	setsaveddvar("sv_znear","1");
	var_0E = maps\_utility::make_array(var_01);
	var_0F = spawn("script_model",var_01.origin);
	var_0F.angles = var_01.angles;
	var_0F.origin = var_01.origin;
	var_01 linkto(var_0F);
	var_10 = var_08 maps\_anim::get_anim_position("j_prop_1");
	var_11 = var_10["origin"];
	var_12 = var_10["angles"];
	var_13 = getstartorigin(var_11,var_12,level.scr_anim[var_01.animname]["deploy"]);
	var_14 = getstartangles(var_11,var_12,level.scr_anim[var_01.animname]["deploy"]);
	var_15 = distance(var_13,var_0F.origin) / 12 / 5280;
	var_16 = var_15 / var_00 * 60 * 60;
	var_17 = vectortoangles(var_13 - var_0F.origin);
	thread fake_cockpit_jitter(var_01,var_16);
	var_0F moveto(var_13,var_16,0,0);
	var_0F rotateto(var_17,var_16 / 4,var_16 / 16,var_16 / 4 - var_16 / 16);
	var_01 dontinterpolate();
	var_08 dontinterpolate();
	var_0A maps\_anim::anim_first_frame_solo(var_08,"deploy");
	var_08 maps\_anim::anim_first_frame(var_09,"deploy","j_prop_1");
	wait(var_16 / 2);
	var_0F rotateto(var_14,var_16 / 2,var_16 / 4,var_16 / 4);
	wait(var_16 / 2);
	level.plane delete();
	foreach(var_19 in var_09)
	{
		var_19 linkto(var_08,"j_prop_1",(0,0,0),(0,0,0));
		if(var_19 != level.finale_jet)
		{
			var_19 show();
		}
	}

	level.player playerlinktodelta(var_07,"tag_player",0.9,10,10,10,10,1);
	var_1B = common_scripts\utility::getfx("s19_engineeffect");
	playfxontag(var_1B,var_05,"tag_engine_left");
	playfxontag(var_1B,var_06,"tag_engine_left");
	playfxontag(var_1B,var_04,"tag_engine_left");
	var_02 thread maps\df_fly_fx::pod_engine_fx(1);
	var_03 thread maps\df_fly_fx::pod_engine_fx(1);
	var_0A thread maps\_anim::anim_single_solo(var_08,"deploy");
	var_01 notify("stop_loop");
	var_08 maps\_anim::anim_single(var_09,"deploy","j_prop_1");
	var_02 thread maps\df_fly_fx::pod_engine_fx(0);
	var_03 thread maps\df_fly_fx::pod_engine_fx(0);
}

//Function Number: 66
fake_cockpit_jitter(param_00,param_01)
{
	wait(0.1);
	param_01 = param_01 - 0.1;
	var_02 = 0;
	var_03 = gettime();
	for(var_04 = var_03;var_02 < param_01;var_04 = var_06)
	{
		var_05 = randomfloatrange(0.05,0.1);
		level.player playerlinktodelta(param_00,"tag_player",0.9,10,10,10,10,1);
		wait(var_05);
		var_06 = gettime();
		var_02 = var_02 + var_06 - var_04 / 1000;
	}
}

//Function Number: 67
deploy_vo()
{
	maps\df_fly_code::radio_dialog_add_and_go("df_gid_finalapproach");
	maps\df_fly_code::radio_dialog_add_and_go("df_so_flakperimeter");
	wait(0.5);
	maps\df_fly_code::radio_dialog_add_and_go("df_gid_dropsequence");
	maps\df_fly_code::radio_dialog_add_and_go("df_nox_autopilot");
	wait(2);
	maps\df_fly_code::radio_dialog_add_and_go("df_gid_deploymentsuccessful");
	maps\df_fly_code::radio_dialog_add_and_go("df_so_offradar");
	common_scripts\utility::flag_set("black_out");
	common_scripts\utility::flag_set("finale_vo_done");
}

//Function Number: 68
do_fly_screen()
{
	var_00 = getent("fly_screen_start","targetname");
	var_01 = getent("fly_screen_mid","targetname");
	var_02 = getent("fly_screen_end","targetname");
	level.player disableweapons();
	level.player freezecontrols(1);
	level.player maps\_utility::teleport_player(var_00);
	wait 0.05;
	level.player maps\_utility::lerp_player_view_to_position(var_02.origin,level.player.angles,18,1,0,0,0,0);
}

//Function Number: 69
do_hoodoo_voodoo()
{
	var_00 = getentarray("canyon_destructible","script_noteworthy");
	common_scripts\utility::array_thread(var_00,::maps\df_fly_code::handle_canyon_destructible);
	foreach(var_02 in var_00)
	{
		var_02 notify("fall_down");
	}
}

//Function Number: 70
deathspin()
{
	var_00 = maps\_utility::spawn_anim_model("enemy_jet");
	var_00 linkto(self,"tag_origin",(0,0,0),(0,0,0));
	self hide();
	var_00 maps\_anim::anim_single_solo(var_00,"deathspin");
}

//Function Number: 71
amb_sky_combat_setup()
{
	thread amb_sky_combat();
	thread sky_booms();
	thread mothership_fly();
	thread mothership_fly2();
	thread mothership_fly3();
	thread mothership_fly4();
	thread mothership_fly5();
	thread tanker_mountain_crash();
	thread tanker_mountain_crash2();
}

//Function Number: 72
amb_sky_combat()
{
	thread jet_spawn_loop("trig_amb_enemywave_starters","trig_amb_enemywave0","amb_jets_starters");
	thread jet_spawn_loop("trig_amb_enemywave0","trig_amb_enemywave1","amb_jets0");
	thread jet_spawn_loop("trig_amb_enemywave1","trig_amb_enemywave2","amb_jets1");
	thread jet_spawn_loop("trig_amb_enemywave2","trig_amb_enemywave3","amb_jets2");
	thread jet_spawn_loop("trig_amb_enemywave3","trig_amb_enemywave4","amb_jets3");
	thread jet_spawn_loop("trig_amb_enemywave4","trig_amb_enemywave5","amb_jets4");
	thread jet_spawn_loop("trig_amb_enemywave5","trig_amb_enemywave6","amb_jets5");
	thread jet_spawn_loop("trig_amb_enemywave6","trig_amb_enemywave7","amb_jets6");
	thread jet_spawn_loop("trig_amb_enemywave7","trig_amb_enemywave8","amb_jets7");
	thread jet_spawn_loop("trig_amb_enemywave8a","trig_amb_enemywave9a","amb_jets8a");
	thread jet_spawn_loop("trig_amb_enemywave8b","trig_amb_enemywave9b","amb_jets8b");
	thread jet_spawn_loop("trig_amb_enemywave9a","trig_amb_enemywave10","amb_jets9a");
	thread jet_spawn_loop("trig_amb_enemywave9b","trig_amb_enemywave10","amb_jets9b");
	thread jet_spawn_loop("trig_amb_enemywave10","trig_amb_enemywave11","amb_jets10");
	thread jet_spawn_loop("trig_amb_enemywave11","trig_amb_enemywave12","amb_jets11");
	thread jet_spawn_loop("trig_amb_enemywave12","trig_amb_enemywave13","amb_jets12");
	thread jet_spawn_loop("trig_amb_enemywave13","trig_amb_enemywave14","amb_jets13");
	thread jet_spawn_loop("trig_amb_enemywave14","trig_amb_enemywave15","amb_jets14");
	thread jet_spawn_loop("trig_amb_enemywave15","trig_amb_enemywave16","amb_jets15");
	thread jet_spawn_loop("trig_amb_enemywave16","trig_amb_enemywave17","amb_jets16");
	thread jet_spawn_loop("trig_amb_enemywave17","trig_amb_enemywave18","amb_jets17");
}

//Function Number: 73
sky_booms()
{
}

//Function Number: 74
jet_spawn_loop(param_00,param_01,param_02)
{
	common_scripts\utility::flag_wait(param_00);
	while(!common_scripts\utility::flag(param_01))
	{
		var_03 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive(param_02);
		common_scripts\utility::array_thread(var_03,::setup_jet_waits);
		while(var_03.size > 0)
		{
			wait(1.5);
			var_03 = maps\_utility::remove_dead_from_array(var_03);
		}

		wait 0.05;
	}
}

//Function Number: 75
setup_jet_waits()
{
	if(isdefined(self.script_noteworthy))
	{
		if(self.script_noteworthy == "jet_fire")
		{
			thread jet_wait_start_firing();
			thread jet_wait_stop_firing();
			return;
		}

		if(self.script_noteworthy == "jet_missile")
		{
			thread jet_wait_fire_missile();
			return;
		}

		if(self.script_noteworthy == "jet_boom")
		{
			thread jet_wait_boom();
			return;
		}

		return;
	}
}

//Function Number: 76
jet_wait_start_firing()
{
	self endon("death");
	maps\_utility::ent_flag_init("start_firing");
	maps\_utility::ent_flag_wait("start_firing");
	maps\_utility::ent_flag_clear("start_firing");
	thread jet_fire_guns();
}

//Function Number: 77
jet_wait_stop_firing()
{
	self endon("death");
	maps\_utility::ent_flag_init("stop_firing");
	maps\_utility::ent_flag_wait("stop_firing");
	maps\_utility::ent_flag_clear("stop_firing");
}

//Function Number: 78
jet_wait_fire_missile()
{
	self endon("death");
	maps\_utility::ent_flag_init("fire_missile");
	maps\_utility::ent_flag_wait("fire_missile");
	thread jet_launch_missile();
}

//Function Number: 79
jet_wait_boom()
{
	self endon("death");
	maps\_utility::ent_flag_init("jet_explode");
	maps\_utility::ent_flag_wait("jet_explode");
	thread jet_boom();
}

//Function Number: 80
jet_fire_guns()
{
	self endon("death");
	self endon("stop_firing");
	self.firing_sound_ent = spawn("script_origin",(0,0,0));
	for(;;)
	{
		var_00 = anglestoforward(self.angles);
		var_01 = 1000;
		var_02 = self gettagorigin("tag_flash") + var_00 * var_01;
		var_03 = var_02 + var_00 * 999999999;
		magicbullet("s19_cannon_AI",var_02 + var_00,var_03);
		wait(0.1);
	}
}

//Function Number: 81
jet_launch_missile()
{
	var_00 = anglestoforward(self.angles);
	var_01 = maps\df_fly_flight_code::offset_position_from_tag("forward","tag_origin",1000);
	var_02 = magicbullet("sidewinder_atlas_jet",var_01,var_00);
}

//Function Number: 82
jet_boom()
{
	var_00 = playfx(common_scripts\utility::getfx("bagh_aircraft_explosion_midair"),self.origin);
	self delete();
}

//Function Number: 83
tanker_mountain_crash()
{
	common_scripts\utility::flag_wait("trig_amb_enemywave5");
	var_00 = getent("crashing_tanker2","targetname");
	var_01 = var_00 thread maps\_vehicle::spawn_vehicle_and_gopath();
	var_02 = maps\_utility::spawn_anim_model("refueler");
	var_02.origin = var_01.origin;
	var_02.angles = var_01.angles;
	var_02 linkto(var_01,"tag_origin",(0,0,0),(0,0,0));
	var_01 hide();
	playfxontag(common_scripts\utility::getfx("bagh_tanker_crash"),var_02,"TAG_ORIGIN");
	wait 0.05;
	var_01 maps\_utility::ent_flag_clear("engineeffects");
	wait(0.25);
	var_01 notify("stop_engineeffects");
	wait(6);
	playfx(common_scripts\utility::getfx("canyon_jet_impact"),var_02.origin,anglestoforward(var_02.angles) * -1);
	playfxontag(common_scripts\utility::getfx("bagh_tanker_dust_trail"),var_02,"TAG_ORIGIN");
	wait(7);
	playfx(common_scripts\utility::getfx("bagh_dam_explosion"),var_02.origin);
	stopfxontag(common_scripts\utility::getfx("bagh_tanker_crash"),var_02,"TAG_ORIGIN");
	stopfxontag(common_scripts\utility::getfx("bagh_hoodoo_dust_trail"),var_02,"TAG_ORIGIN");
	var_01 waittill("death");
	var_02 unlink();
	var_02 delete();
}

//Function Number: 84
tanker_mountain_crash2()
{
	common_scripts\utility::flag_wait("trig_amb_enemywave12");
	var_00 = getent("crashing_tanker3","targetname");
	var_01 = var_00 thread maps\_vehicle::spawn_vehicle_and_gopath();
	var_02 = maps\_utility::spawn_anim_model("refueler");
	var_02.origin = var_01.origin;
	var_02.angles = var_01.angles;
	var_02 linkto(var_01,"tag_origin",(0,0,0),(0,0,0));
	var_01 hide();
	playfxontag(common_scripts\utility::getfx("bagh_tanker_crash"),var_02,"TAG_ORIGIN");
	wait 0.05;
	var_01 maps\_utility::ent_flag_clear("engineeffects");
	wait(0.25);
	var_01 notify("stop_engineeffects");
	wait(4);
	playfx(common_scripts\utility::getfx("canyon_jet_impact"),var_02.origin,anglestoforward(var_02.angles) * -1);
	playfxontag(common_scripts\utility::getfx("bagh_tanker_dust_trail"),var_02,"TAG_ORIGIN");
	wait(7);
	playfx(common_scripts\utility::getfx("bagh_dam_explosion"),var_02.origin);
	stopfxontag(common_scripts\utility::getfx("bagh_tanker_crash"),var_02,"TAG_ORIGIN");
	stopfxontag(common_scripts\utility::getfx("bagh_hoodoo_dust_trail"),var_02,"TAG_ORIGIN");
	var_01 waittill("death");
	var_02 unlink();
	var_02 delete();
}

//Function Number: 85
mothership_fly()
{
	common_scripts\utility::flag_wait("trig_amb_enemywave1");
	var_00 = getent("osp_fly","targetname");
	var_01 = var_00 thread maps\_vehicle::spawn_vehicle_and_gopath();
	var_02 = maps\_utility::spawn_anim_model("osp");
	var_02.origin = var_01.origin;
	var_02.angles = var_01.angles;
	var_02 linkto(var_01,"tag_origin",(0,0,0),(0,0,0));
	var_01 hide();
	var_01 waittill("death");
	var_02 unlink();
}

//Function Number: 86
mothership_fly2()
{
	common_scripts\utility::flag_wait("trig_amb_enemywave1");
	var_00 = getent("osp_fly2","targetname");
	var_01 = var_00 thread maps\_vehicle::spawn_vehicle_and_gopath();
	var_02 = maps\_utility::spawn_anim_model("osp");
	var_02.origin = var_01.origin;
	var_02.angles = var_01.angles;
	var_02 linkto(var_01,"tag_origin",(0,0,0),(0,0,0));
	var_01 hide();
	var_01 waittill("death");
	var_02 unlink();
}

//Function Number: 87
mothership_fly3()
{
	common_scripts\utility::flag_wait("trig_amb_enemywave1");
	var_00 = getent("osp_fly3","targetname");
	var_01 = var_00 thread maps\_vehicle::spawn_vehicle_and_gopath();
	var_02 = maps\_utility::spawn_anim_model("osp");
	var_02.origin = var_01.origin;
	var_02.angles = var_01.angles;
	var_02 linkto(var_01,"tag_origin",(0,0,0),(0,0,0));
	var_01 hide();
	var_01 waittill("death");
	var_02 unlink();
}

//Function Number: 88
mothership_fly4()
{
	common_scripts\utility::flag_wait("trig_amb_enemywave1");
	var_00 = getent("osp_fly4","targetname");
	var_01 = var_00 thread maps\_vehicle::spawn_vehicle_and_gopath();
	var_02 = maps\_utility::spawn_anim_model("osp");
	var_02.origin = var_01.origin;
	var_02.angles = var_01.angles;
	var_02 linkto(var_01,"tag_origin",(0,0,0),(0,0,0));
	var_01 hide();
	var_01 waittill("death");
	var_02 unlink();
}

//Function Number: 89
mothership_fly5()
{
	common_scripts\utility::flag_wait("trig_amb_enemywave11");
	var_00 = getent("osp_fly5","targetname");
	var_01 = var_00 thread maps\_vehicle::spawn_vehicle_and_gopath();
	var_02 = maps\_utility::spawn_anim_model("osp");
	var_02.origin = var_01.origin;
	var_02.angles = var_01.angles;
	var_02 linkto(var_01,"tag_origin",(0,0,0),(0,0,0));
	var_01 hide();
	var_01 waittill("death");
	var_02 unlink();
}