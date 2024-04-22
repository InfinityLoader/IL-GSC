/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: detroit_streets.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 206
 * Decompile Time: 3054 ms
 * Timestamp: 4/22/2024 2:28:28 AM
*******************************************************************/

//Function Number: 1
streets_main()
{
	level.truck_org_cords = (117,65,64);
	thread alley_setup();
	thread bar_setup();
	thread second_room_nightclub_setup();
	thread setup_hospital_transition();
	thread streets_dialogue_manager();
	thread spawn_few_nightclub_guys();
	thread first_nightclub_room_setup();
	thread second_nightclub_room_setup();
	thread ambulance_firstframe_function();
	thread ambulance_objective_update();
}

//Function Number: 2
streets_dialogue_manager()
{
	thread mitchell_over_here_dialogue();
}

//Function Number: 3
setup_hospital_transition()
{
	maps\_utility::trigger_wait_targetname("prepare_the_hospital");
	maps\detroit_hospital::setup_hospital();
}

//Function Number: 4
onfoot_start_alley_setup()
{
	var_00 = getnode("ally_burke_start_onfoot","targetname");
	level.burke maps\_utility::clear_run_anim();
	level.burke maps\_utility::clear_generic_idle_anim();
	level.burke maps\_utility::teleport_ai(var_00);
	level.burke.ignoreall = 0;
	level.burke thread blink_flashlight();
	common_scripts\utility::flag_set("begin_setup_alley");
	common_scripts\utility::flag_wait("burke_alley_flashlight_off");
	level.burke notify("flashlight_off");
}

//Function Number: 5
blink_flashlight()
{
	level.burke maps\detroit_lighting::add_enemy_flashlight("flashlight","light");
}

//Function Number: 6
alley_setup()
{
	level.player thread return_full_mobility("begin_onfoot_street_section");
	common_scripts\utility::flag_wait("begin_setup_alley");
	level.burke maps\_utility::set_force_color("r");
	var_00 = getnode("burke_door_kick_spot","targetname");
	level.burke maps\_utility::teleport_ai(var_00);
	level.burke.goalradius = 75;
	level.burke.disablearrivals = 0;
	level.burke.disableexits = 0;
	thread setup_hazmat_intro_allies();
	thread exterior_street_kickoff();
	thread street_fight_after_snipe();
	thread battle_chatter_check_alley();
}

//Function Number: 7
return_full_mobility(param_00)
{
	maps\_shg_design_tools::waittill_trigger_with_name(param_00);
	self setmovespeedscale(1);
	self allowsprint(1);
}

//Function Number: 8
destroy_the_window_exit()
{
	wait 0.05;
	var_00 = getent("reunite_objective_node","targetname");
	var_01 = getentarray("shoot_at_me_node","targetname");
	foreach(var_03 in var_01)
	{
		var_04 = magicbullet("iw5_bal27_sp",var_00.origin,var_03.origin);
	}
}

//Function Number: 9
shoot_at_ambulance()
{
	var_00 = getentarray("shoot_at_ambulance_node","targetname");
	var_01 = getentarray("shoot_at_me_origin","targetname");
	maps\_utility::trigger_wait_targetname("regroup_kva_spawner_trigger");
	foreach(var_03 in var_01)
	{
		var_03 thread fake_gunfire_shooter_ambulance(var_00);
	}
}

//Function Number: 10
move_bones_and_joker_up()
{
	maps\_utility::trigger_wait_targetname("spawn_few_nightclub_guys_trigger");
	var_00 = getnode("bones_supressed_outside_node","targetname");
	var_01 = getnode("joker_supressed_outside_node","targetname");
	if(!isdefined(level.bones))
	{
		var_02 = getent("bones_spawner_2","targetname");
		level.bones = var_02 maps\_utility::spawn_ai(1);
		level.bones maps\_utility::magic_bullet_shield();
	}

	level.bones.script_friendname = "Torres";
	level.bones.animname = "bones";
	var_03 = getnode("bones_supressed_outside_node_startpoint","targetname");
	level.bones maps\_utility::clear_run_anim();
	level.bones maps\_utility::clear_generic_idle_anim();
	level.bones maps\_utility::teleport_ai(var_03);
	level.bones.goalradius = 15;
	level.bones.accuracy = 15;
	if(!isdefined(level.joker))
	{
		var_02 = getent("joker_spawner_2","targetname");
		level.joker = var_02 maps\_utility::spawn_ai(1);
		level.joker maps\_utility::magic_bullet_shield();
	}

	level.joker.script_friendname = "Joker";
	level.joker.animname = "joker";
	var_04 = getnode("joker_supressed_outside_node_startpoint","targetname");
	level.joker maps\_utility::clear_run_anim();
	level.joker maps\_utility::clear_generic_idle_anim();
	level.joker maps\_utility::teleport_ai(var_04);
	level.joker.goalradius = 15;
	level.joker.accuracy = 0;
}

//Function Number: 11
advance_bones_and_joker_intro()
{
	var_00 = getnode("bones_supressed_outside_node","targetname");
	var_01 = getnode("joker_supressed_outside_node","targetname");
	common_scripts\utility::flag_wait("move_burke_down");
	level.joker setgoalnode(var_01);
	level.bones setgoalnode(var_00);
	level.joker maps\_utility::disable_careful();
	level.bones maps\_utility::disable_careful();
}

//Function Number: 12
distance_to_last_stage(param_00)
{
	for(;;)
	{
		var_01 = distance2d(param_00.origin,level.player.origin);
		wait(0.05);
	}
}

//Function Number: 13
exopush_stage_manager()
{
	common_scripts\utility::flag_wait("exo_push_spawner_scaffolding_trigger");
	var_00 = getent("exo_push_stage2_org","targetname");
	var_01 = getent("exo_push_stage3_org","targetname");
	var_02 = 1;
	var_03 = 1;
	thread exopush_distance_debug_ui(var_02,var_03,var_00,var_01);
	while(var_02)
	{
		var_04 = distance2d(self.origin,var_00.origin);
		if(var_04 < 40)
		{
			common_scripts\utility::flag_set("exo_push_phase1_complete");
			thread maps\_utility::autosave_by_name("seeker");
			var_02 = 0;
		}

		wait(0.05);
	}

	while(var_03)
	{
		var_04 = distance2d(self.origin,var_01.origin);
		if(var_04 < 40)
		{
			common_scripts\utility::flag_set("exo_push_phase2_complete");
			thread maps\_utility::autosave_by_name("seeker");
			thread spawn_hospital_roof_guys();
			var_03 = 0;
		}

		wait(0.05);
	}
}

//Function Number: 14
exopush_distance_debug_ui(param_00,param_01,param_02,param_03)
{
	while(param_00 == 1)
	{
		var_04 = distance2d(self.origin,param_02.origin);
		if(var_04 < 40)
		{
			param_00 = 0;
		}

		wait(0.1);
	}

	while(param_01 == 1)
	{
		var_04 = distance2d(self.origin,param_03.origin);
		if(var_04 < 40)
		{
			param_01 = 0;
		}

		wait(0.1);
	}
}

//Function Number: 15
exopush_start()
{
	maps\_utility::trigger_wait_targetname("runto_exo_start_trigger");
	common_scripts\utility::flag_set("vo_office_reunion_doctor");
	common_scripts\utility::flag_wait("flag_send_team_to_the_truck");
	common_scripts\utility::flag_set("obj_rendezvous_joker_complete");
	thread begin_exo_push();
	wait(3);
	common_scripts\utility::flag_set("vo_exo_push_start");
	thread maps\_utility::autosave_by_name("seeker");
}

//Function Number: 16
preplaced_guys_function()
{
	common_scripts\utility::flag_wait("exo_push_spawner_scaffolding_trigger");
	thread spawn_preplaced_guys();
}

//Function Number: 17
exo_push_combat_manager()
{
	level endon("stop_exo_street_combat");
	level.max_exo_guysalive = 2;
	level.current_exo_guys_alive = 0;
	common_scripts\utility::flag_wait("window_ambush_flag");
	thread new_kva_window_ambush(4);
	common_scripts\utility::flag_wait("exo_push_spawner_scaffolding_trigger");
	for(;;)
	{
		if(level.max_exo_guysalive > level.current_exo_guys_alive)
		{
			wait(randomintrange(3,5));
			spawn_a_guy();
		}

		wait(0.05);
	}
}

//Function Number: 18
bones_rollout_manager()
{
	var_00 = getnode("bones_cover_left_push_1","targetname");
	var_01 = getnode("bones_cover_left_push_2","targetname");
	var_02 = getnode("joker_cover_left_push_1","targetname");
	var_03 = getnode("joker_cover_left_push_2","targetname");
	var_04 = getnode("bones_hospital","targetname");
	var_05 = getnode("joker_hospital","targetname");
	common_scripts\utility::flag_wait("send_bones_joker_to_cover1");
	level.bones thread maps\_utility::disable_careful();
	level.joker thread maps\_utility::disable_careful();
	level.bones.ignoreall = 1;
	level.joker.ignoreall = 1;
	level.bones.ignoreme = 1;
	level.joker.ignoreme = 1;
	level.bones setgoalnode(var_00);
	level.joker setgoalnode(var_02);
	level.bones thread enable_ai_on_goal();
	level.joker thread enable_ai_on_goal();
	level.bones.ignoreme = 0;
	level.joker.ignoreme = 0;
	common_scripts\utility::flag_wait("exo_push_phase2_complete");
	level.bones maps\_utility::disable_careful();
	level.joker maps\_utility::disable_careful();
	level.bones.ignoreall = 1;
	level.joker.ignoreall = 1;
	level.bones.ignoreme = 1;
	level.joker.ignoreme = 1;
	level.bones thread ignore_me_till_goal();
	level.joker thread ignore_me_till_goal();
	level.bones thread maps\_utility::disable_cqbwalk();
	level.joker thread maps\_utility::disable_cqbwalk();
	level.bones setgoalnode(var_01);
	level.joker setgoalnode(var_03);
	level.bones thread enable_ai_on_goal();
	level.joker thread enable_ai_on_goal();
	common_scripts\utility::flag_wait("send_exopush_guys_into_hospital");
	level.bones setgoalnode(var_04);
	level.joker setgoalnode(var_05);
}

//Function Number: 19
surprise_ambush_kva_team()
{
	var_00 = getentarray("surprise_ambush_kva_spawner","targetname");
	var_01 = getent("surprise_ambush_kva_vol","targetname");
	maps\_utility::trigger_wait_targetname("runto_exo_start_trigger");
	foreach(var_03 in var_00)
	{
		var_04 = var_03 maps\_utility::spawn_ai(1);
		if(isdefined(var_04))
		{
			var_04 setgoalvolumeauto(var_01);
			var_04.goalradius = 30;
			var_04 thread maps\detroit_lighting::add_enemy_flashlight();
			var_04 thread ignore_me_till_goal();
			var_04 thread kill_me_on_truck_pushover();
		}
	}
}

//Function Number: 20
kill_off_inside_guy()
{
	self endon("death");
	common_scripts\utility::flag_wait("begin_spawning_troops_hospital");
	thread maps\detroit::bloody_death();
}

//Function Number: 21
new_kva_window_ambush(param_00)
{
	common_scripts\utility::flag_wait("begin_spawning_troops_hospital");
	if(isdefined(param_00))
	{
		wait(param_00);
	}

	var_01 = getent("scaffold_1_windowshoot_org","targetname");
	var_02 = getent("scaffold_2_windowshoot_org","targetname");
	var_03 = getentarray("scaffold_1_windowshoot_target","targetname");
	var_04 = getentarray("scaffold_2_windowshoot_target","targetname");
	var_05 = getent("exo_push_spawner_scaffold","targetname");
	var_06 = getent("exo_push_spawner_scaffold_start","targetname");
	var_07 = getnode("shoot_ambulance_org1","targetname");
	var_08 = getnode("shoot_ambulance_org2","targetname");
	var_09 = getent("surprise_ambush_kva_vol","targetname");
	thread shoot_out_windows(var_01,var_03);
	wait(0.2);
	shoot_out_windows(var_02,var_04);
	var_0A = var_05 maps\_utility::spawn_ai(1);
	if(isalive(var_0A))
	{
		var_0A setgoalnode(var_07);
	}

	wait(2.4);
	var_0B = var_06 maps\_utility::spawn_ai(1);
	if(isalive(var_0B))
	{
		var_0B setgoalnode(var_08);
	}
}

//Function Number: 22
enable_ai_after_time(param_00)
{
	wait(param_00);
	self.ignoreall = 0;
}

//Function Number: 23
exo_push_gourney()
{
	level endon("gourney_stop");
	thread gourney_stop();
	var_00 = 0;
	var_01 = getent("exo_push_gourney_spawner","targetname");
	for(;;)
	{
		if(common_scripts\utility::flag("exo_push_arrived"))
		{
			return;
		}

		var_01.count = 1;
		var_02 = var_01 maps\_utility::spawn_ai(1);
		var_00++;
		if(var_00 == 3)
		{
			common_scripts\utility::flag_set("gourney_guys_dead");
			return;
		}

		var_02 waittill("death");
		wait(randomintrange(2,6));
	}
}

//Function Number: 24
all_exopush_enemies_dead()
{
	common_scripts\utility::flag_wait("gourney_guys_dead");
	common_scripts\utility::flag_wait("secondline_guys_killed");
	common_scripts\utility::flag_wait("backline_guys_alldead");
	common_scripts\utility::flag_set("exo_push_arrived");
}

//Function Number: 25
gourney_stop()
{
	common_scripts\utility::flag_wait("exo_push_arrived");
	level notify("gourney_stop");
}

//Function Number: 26
enable_ai_on_goal()
{
	self endon("death");
	self.goalradius = 15;
	self waittill("goal");
	self.ignoreall = 0;
}

//Function Number: 27
ignore_me_till_goal()
{
	self endon("death");
	self.ignoreme = 1;
	self waittill("goal");
	self.ignoreme = 0;
}

//Function Number: 28
kill_me_on_truck_pushover()
{
	self endon("death");
	var_00 = randomfloatrange(4.6,5.1);
	for(;;)
	{
		if(common_scripts\utility::flag("kill_the_two_guys_by_ambulance"))
		{
			maps\detroit::bloody_death(var_00);
		}

		wait(0.05);
	}
}

//Function Number: 29
fake_gunfire_sniper_moment()
{
	var_00 = getentarray("shoot_at_me_origin","targetname");
	var_01 = getentarray("shoot_at_me_node","targetname");
	maps\_utility::trigger_wait_targetname("regroup_kva_spawner_trigger");
	foreach(var_03 in var_00)
	{
		var_03 thread fake_gunfire_shooter(var_01);
	}
}

//Function Number: 30
fake_gunfire_shooter(param_00)
{
	level endon("time to stop shooting the roof");
	for(;;)
	{
		if(common_scripts\utility::flag("obj_rendezvous_joker_pos_joker"))
		{
			thread stop_shooting_timer();
		}

		var_01 = randomint(param_00.size);
		var_02 = magicbullet("iw5_bal27_sp",self.origin,param_00[var_01].origin);
		wait(randomfloatrange(0.2,0.4));
	}
}

//Function Number: 31
fake_gunfire_shooter_ambulance(param_00)
{
	level endon("time to stop shooting the ambulance");
	thread stop_shooting_ambulance_timer();
	for(;;)
	{
		var_01 = randomint(param_00.size);
		var_02 = magicbullet("iw5_bal27_sp",self.origin,param_00[var_01].origin);
		wait(randomfloatrange(0.2,0.4));
	}
}

//Function Number: 32
stop_shooting_ambulance_timer()
{
	maps\_utility::trigger_wait_targetname("runto_exo_start_trigger");
	level notify("time to stop shooting the ambulance");
}

//Function Number: 33
stop_shooting_timer()
{
	wait(0.6);
	level notify("time to stop shooting the roof");
}

//Function Number: 34
bloody_death_all_survivors()
{
	common_scripts\utility::flag_wait("exo_push_arrived");
	common_scripts\utility::flag_set("obj_exo_push_complete");
	var_00 = getentarray("killable_exopush_guy","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 thread random_bloody_death(3);
	}
}

//Function Number: 35
back_fake_bullets()
{
	var_00 = getentarray("exopush_shooter_org_back","targetname");
	var_01 = getentarray("exopush_shooter_org_mid","targetname");
	var_02 = getentarray("exopush_shooter_org_front","targetname");
	var_03 = getentarray("exopush_shooter_org_target","targetname");
	common_scripts\utility::flag_wait("send_bones_joker_to_cover1");
	foreach(var_05 in var_00)
	{
		var_05 thread fake_gunfire_shooter_exopush_back(var_03);
	}

	foreach(var_05 in var_02)
	{
		var_05 thread fake_gunfire_shooter_exopush_front(var_03);
	}

	foreach(var_05 in var_01)
	{
		var_05 thread fake_gunfire_shooter_exopush_mid(var_03);
	}

	common_scripts\utility::flag_wait("exo_push_arrived");
	level notify("stop_all_fake_bullets");
}

//Function Number: 36
fake_gunfire_shooter_exopush_back(param_00)
{
	level endon("stop_back_shooting");
	level endon("stop_all_fake_bullets");
	var_01 = getent("exo_push_ambulance","targetname");
	thread back_gunfire_timer();
	var_02 = getent("exo_push_street_vol3","targetname");
	for(;;)
	{
		if(distance2d(level.player.origin,var_01.origin) < 260)
		{
			if(!level.player istouching(var_02))
			{
				var_03 = randomint(param_00.size);
				var_04 = magicbullet("iw5_bal27_sp",self.origin,param_00[var_03].origin);
			}
		}
		else if(!level.player istouching(var_02))
		{
			var_05 = level.player.origin + (randomfloatrange(-70,70),randomfloatrange(-70,70),randomfloatrange(-70,70));
			var_04 = magicbullet("iw5_bal27_sp",self.origin,var_05);
		}

		wait(randomfloatrange(0.1,0.4));
	}
}

//Function Number: 37
fake_gunfire_shooter_exopush_mid(param_00)
{
	level endon("stop_mid_shooting");
	level endon("stop_all_fake_bullets");
	var_01 = getent("exo_push_ambulance","targetname");
	thread mid_gunfire_timer();
	var_02 = getent("exo_push_street_vol3","targetname");
	for(;;)
	{
		if(distance2d(level.player.origin,var_01.origin) < 260)
		{
			if(!level.player istouching(var_02))
			{
				var_03 = randomint(param_00.size);
				var_04 = magicbullet("iw5_bal27_sp",self.origin,param_00[var_03].origin);
			}
		}
		else if(!level.player istouching(var_02))
		{
			var_05 = level.player.origin + (randomfloatrange(-70,70),randomfloatrange(-70,70),randomfloatrange(-70,70));
			var_04 = magicbullet("iw5_bal27_sp",self.origin,var_05);
		}

		wait(randomfloatrange(0.1,0.4));
	}
}

//Function Number: 38
fake_gunfire_shooter_exopush_front(param_00)
{
	level endon("stop_front_shooting");
	level endon("stop_all_fake_bullets");
	var_01 = getent("exo_push_ambulance","targetname");
	thread front_gunfire_timer();
	var_02 = getent("exo_push_street_vol3","targetname");
	for(;;)
	{
		if(distance2d(level.player.origin,var_01.origin) < 260)
		{
			if(!level.player istouching(var_02))
			{
				var_03 = randomint(param_00.size);
				var_04 = magicbullet("iw5_bal27_sp",self.origin,param_00[var_03].origin);
			}
		}
		else if(!level.player istouching(var_02))
		{
			var_05 = level.player.origin + (randomfloatrange(-70,70),randomfloatrange(-70,70),randomfloatrange(-70,70));
			var_04 = magicbullet("iw5_bal27_sp",self.origin,var_05);
		}

		wait(randomfloatrange(0.1,0.4));
	}
}

//Function Number: 39
back_gunfire_timer()
{
	common_scripts\utility::flag_wait("exo_push_phase2_complete");
	level notify("stop_back_shooting");
}

//Function Number: 40
mid_gunfire_timer()
{
	common_scripts\utility::flag_wait("exo_push_phase1_complete");
	level notify("stop_mid_shooting");
}

//Function Number: 41
front_gunfire_timer()
{
	common_scripts\utility::flag_wait("exo_push_phase1_complete");
	level notify("stop_front_shooting");
}

//Function Number: 42
random_bloody_death(param_00)
{
	wait(randomfloatrange(0.3,param_00));
	if(isalive(self))
	{
		maps\detroit::bloody_death();
	}
}

//Function Number: 43
spawn_a_guy()
{
	if(!common_scripts\utility::flag("exo_push_arrived"))
	{
		var_00 = randomintrange(1,4);
		if(var_00 == 1)
		{
			if(!common_scripts\utility::flag("window_exo_guys_spawned_yet"))
			{
				common_scripts\utility::flag_set("window_exo_guys_spawned_yet");
				thread shoot_out_exo_windows_scaffolding_think();
				thread exo_scaffolding_enemy();
				return;
			}

			thread exo_scaffolding_enemy();
			return;
		}

		if(var_00 == 2)
		{
			if(!common_scripts\utility::flag("window_exo_guys_spawned_yet"))
			{
				common_scripts\utility::flag_set("window_exo_guys_spawned_yet");
				thread spawn_scaffolding_to_floor_right();
				return;
			}

			thread spawn_scaffolding_to_floor_right();
			return;
		}

		if(var_00 == 3)
		{
			thread spawn_left_building_scaffolding_guy();
			return;
		}

		return;
	}
}

//Function Number: 44
spawn_left_building_scaffolding_guy()
{
	var_00 = getent("left_building_scaffolding1","targetname");
	var_01 = getent("exo_push_leftbuilding_spawner_bottom","targetname");
	var_01.count = 1;
	var_02 = randomint(12);
	var_03 = var_01 maps\_utility::spawn_ai(1);
	if(isdefined(var_03))
	{
		level.current_exo_guys_alive++;
		var_03.goalradius = 15;
		var_03.grenadeammo = 0;
		var_03.meleeattackdist = 0;
		var_03 thread exo_guy_cleanup_think();
		var_03 maps\detroit_lighting::add_enemy_flashlight("flashlight",undefined,undefined,25);
		var_03 setgoalvolumeauto(var_00);
		var_03.ignoreall = 1;
		var_03 waittill("goal");
		var_03.ignoreall = 0;
	}
}

//Function Number: 45
spawn_scaffolding_to_floor_right()
{
	var_00 = getent("exo_push_spawner_scaffold","targetname");
	var_00.count = 1;
	var_01 = var_00 maps\_utility::spawn_ai(1);
	if(isdefined(var_01))
	{
		level.current_exo_guys_alive++;
		var_01.goalradius = 15;
		var_01.grenadeammo = 0;
		var_01.meleeattackdist = 0;
		var_01 maps\detroit_lighting::add_enemy_flashlight("flashlight",undefined,undefined,25);
		var_01 thread move_into_place_right();
		var_01 thread exo_guy_cleanup_think();
		var_01 thread street_update_my_volume_think();
	}
}

//Function Number: 46
move_into_place_right()
{
	self.ignoreall = 1;
	level.burke.ignoreme = 1;
	level.bones.ignoreme = 1;
	self waittill("goal");
	self.ignoreall = 0;
	level.burke.ignoreme = 0;
	level.bones.ignoreme = 0;
}

//Function Number: 47
street_update_my_volume_think()
{
	self endon("death");
	for(;;)
	{
		if(!common_scripts\utility::flag("exo_push_phase1_complete"))
		{
			var_00 = getent("exo_push_street_vol1","targetname");
		}
		else if(!common_scripts\utility::flag("exo_push_phase2_complete"))
		{
			var_00 = getent("exo_push_street_vol2","targetname");
		}
		else
		{
			var_00 = getent("exo_push_street_vol3","targetname");
		}

		if(isalive(self))
		{
			self setgoalvolumeauto(var_00);
		}

		wait(3);
	}
}

//Function Number: 48
shoot_out_exo_windows_scaffolding_think()
{
	var_00 = getglass("hospital_jumpout_glass1");
	var_01 = getglass("hospital_jumpout_glass2");
	var_02 = getent("scaffold_1_windowshoot_org","targetname");
	var_03 = getent("scaffold_2_windowshoot_org","targetname");
	var_04 = getentarray("scaffold_1_windowshoot_target","targetname");
	var_05 = getentarray("scaffold_2_windowshoot_target","targetname");
	thread shoot_out_windows(var_02,var_04);
	destroyglass(var_00);
	wait(0.4);
	thread shoot_out_windows(var_03,var_05);
	destroyglass(var_01);
}

//Function Number: 49
exo_scaffolding_enemies()
{
	common_scripts\utility::flag_wait("exo_push_spawner_scaffolding_trigger");
	var_00 = getentarray("exo_push_spawner_scaffold","targetname");
	var_01 = getent("scaffolding_1_vol","targetname");
	var_02 = getent("scaffolding_2_vol","targetname");
	var_03 = getent("scaffolding_3_vol","targetname");
	if(!common_scripts\utility::flag("exo_push_phase1_complete"))
	{
		foreach(var_05 in var_00)
		{
			var_06 = var_05 maps\_utility::spawn_ai(1);
			if(isdefined(var_06))
			{
				var_06 setgoalvolumeauto(var_01);
				var_06.goalradius = 15;
				var_06.grenadeammo = 0;
				var_06.meleeattackdist = 0;
				var_06 maps\detroit_lighting::add_enemy_flashlight("flashlight",undefined,undefined,25);
				var_06 thread move_right_scaffolding_guy();
				wait(randomintrange(3,5));
			}
		}
	}
}

//Function Number: 50
exo_guy_cleanup_think()
{
	self waittill("death");
	level.current_exo_guys_alive--;
}

//Function Number: 51
exo_scaffolding_enemy()
{
	var_00 = randomint(12);
	var_01 = getent("exo_push_spawner_scaffold","targetname");
	var_02 = var_01 maps\_utility::spawn_ai(1);
	var_01.count = 1;
	if(isdefined(var_02))
	{
		var_02 endon("death");
		var_02.grenadeammo = 0;
		var_02.meleeattackdist = 0;
		level.current_exo_guys_alive++;
		var_02 thread exo_guy_cleanup_think();
		var_02.goalradius = 15;
		var_02 maps\detroit_lighting::add_enemy_flashlight("flashlight",undefined,undefined,25);
		var_02 thread move_right_scaffolding_guy();
		wait(randomintrange(1,4));
		if(var_00 > 9)
		{
			var_02 thread scaffolding_update_my_volume_think();
			return;
		}
	}
}

//Function Number: 52
scaffolding_update_my_volume_think()
{
	self endon("death");
	var_00 = getent("scaffolding_1_vol","targetname");
	var_01 = getent("scaffolding_2_vol","targetname");
	var_02 = getent("scaffolding_3_vol","targetname");
	for(;;)
	{
		if(!common_scripts\utility::flag("exo_push_phase1_complete"))
		{
			var_03 = var_00;
		}
		else if(!common_scripts\utility::flag("exo_push_phase2_complete"))
		{
			var_03 = var_01;
		}
		else
		{
			var_03 = var_02;
		}

		if(isalive(self))
		{
			self setgoalvolumeauto(var_03);
		}

		wait(3);
	}
}

//Function Number: 53
shoot_out_windows(param_00,param_01)
{
	foreach(var_03 in param_01)
	{
		var_04 = magicbullet("iw5_bal27_sp",param_00.origin,var_03.origin);
		wait(randomfloatrange(0.1,0.2));
		var_04 = magicbullet("iw5_bal27_sp",param_00.origin,var_03.origin);
		wait(randomfloatrange(0.25,0.4));
	}
}

//Function Number: 54
move_right_scaffolding_guy()
{
	self endon("death");
	self.ignoreall = 1;
	level.burke.ignoreme = 1;
	level.bones.ignoreme = 1;
	self waittill("goal");
	self.ignoreall = 0;
	level.burke.ignoreme = 0;
	level.bones.ignoreme = 0;
}

//Function Number: 55
setup_street_reunion_spawners()
{
	maps\_utility::trigger_wait_targetname("regroup_kva_spawner_trigger");
	thread setup_sniper_spawns();
	common_scripts\utility::flag_set("vo_office_reunion_start");
	common_scripts\utility::flag_set("flicker_street_lights");
	var_00 = getentarray("regroup_kva_spawner","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = var_02 maps\_utility::spawn_ai(1);
		var_03.accuracy = 0;
		var_03 maps\detroit_lighting::add_enemy_flashlight("flashlight",undefined,undefined,25);
	}
}

//Function Number: 56
setup_sniper_spawns()
{
	var_00 = getent("snipe_setup_vol_1","targetname");
	var_01 = getent("snipe_setup_vol_2","targetname");
	var_02 = getent("snipe_setup_vol_3","targetname");
	var_03 = getent("snipe_setup_vol_4","targetname");
	var_04 = getent("sniper_setup_spawner_1","targetname");
	var_05 = getent("sniper_setup_spawner_2","targetname");
	var_06 = getent("sniper_setup_spawner_3","targetname");
	var_07 = getent("sniper_setup_spawner_4","targetname");
	var_08 = getent("sniper_setup_spawner_6","targetname");
	thread spawn_sniper_guy(var_04,var_00);
	thread spawn_sniper_guy(var_05,var_01,0);
	thread spawn_sniper_guy(var_06,var_02);
	thread spawn_sniper_guy(var_07,var_03,0);
	thread spawn_sniper_guy(var_08,var_03,0);
	wait(0.25);
	common_scripts\utility::flag_set("start_tracking_sniper_deaths");
}

//Function Number: 57
ambush_player_if_alive_exopush()
{
	common_scripts\utility::flag_wait("exo_push_spawner_scaffolding_trigger");
	if(isalive(self))
	{
		maps\_utility::player_seek();
	}
}

//Function Number: 58
spawn_sniper_guy(param_00,param_01,param_02)
{
	var_03 = param_00 maps\_utility::spawn_ai(1);
	var_03.accuracy = 0;
	var_03 maps\detroit_lighting::add_enemy_flashlight("flashlight",undefined,undefined,25);
	var_03 thread ambush_player_if_alive_exopush();
	if(!isdefined(param_02))
	{
		var_03 cleargoalvolume();
		var_03 setgoalvolumeauto(param_01);
	}
}

//Function Number: 59
push_right_after_flag()
{
	self endon("death");
	var_00 = getent("snipe_setup_vol_4","targetname");
	maps\_utility::trigger_wait_targetname("runto_exo_start_trigger");
	wait(randomintrange(1,4));
	if(isalive(self))
	{
		self setgoalvolumeauto(var_00);
	}
}

//Function Number: 60
angles_clamp_180(param_00)
{
	return (angleclamp180(param_00[0]),angleclamp180(param_00[1]),angleclamp180(param_00[2]));
}

//Function Number: 61
angle_lerp(param_00,param_01,param_02)
{
	return angleclamp(param_00 + angleclamp180(param_01 - param_00) * param_02);
}

//Function Number: 62
euler_lerp(param_00,param_01,param_02)
{
	return (angle_lerp(param_00[0],param_01[0],param_02),angle_lerp(param_00[1],param_01[1],param_02),angle_lerp(param_00[2],param_01[2],param_02));
}

//Function Number: 63
train_gopath(param_00,param_01,param_02)
{
	var_03 = 0.052;
	var_04 = spawnstruct();
	var_04.origin = self.origin;
	var_04.angles = self.angles;
	param_00 = common_scripts\utility::array_combine([var_04],param_00);
	if(!isdefined(param_01))
	{
		param_01 = 1200;
	}

	soundscripts\_snd::snd_message("play_maglev_train_path");
	var_05 = 0;
	for(var_06 = 0;var_06 < param_00.size - 1;var_06++)
	{
		var_07 = param_00[var_06];
		var_08 = param_00[var_06 + 1];
		var_09 = vectornormalize(var_08.origin - var_07.origin);
		var_0A = distance(var_08.origin,var_07.origin);
		while(var_05 < var_0A)
		{
			var_0B = var_07.origin + var_05 * var_09;
			var_0C = euler_lerp(var_07.angles,var_08.angles,var_05 / var_0A);
			self moveto(var_0B,var_03,0,0);
			self rotateto(var_0C,var_03,0,0);
			if(isdefined(param_02))
			{
				var_0D = transformmove(var_0B,var_0C,(0,0,0),(0,0,0),(0,0,48),(0,90,0));
				var_0E = var_0D["origin"];
				var_0F = var_0D["angles"];
				param_02 moveto(var_0E,var_03,0,0);
				param_02 rotateto(var_0F,var_03,0,0);
			}

			wait 0.05;
			var_05 = var_05 + param_01 * 0.05;
		}

		var_05 = var_05 - var_0A;
	}

	if(isdefined(self.tags))
	{
		common_scripts\utility::array_call(self.tags,::delete);
	}

	self delete();
}

//Function Number: 64
get_door(param_00)
{
	var_01 = getent(param_00 + "org","targetname");
	var_02 = getent(param_00 + "brush","targetname");
	var_03 = getent(param_00 + "clip","targetname");
	var_04 = var_01 common_scripts\utility::spawn_tag_origin();
	var_02 linkto(var_04,"tag_origin");
	var_03 linkto(var_04,"tag_origin");
	var_05 = spawnstruct();
	var_05.org = var_01;
	var_05.brush = var_02;
	var_05.hasclip = var_03;
	var_05.tag = var_04;
	return var_05;
}

//Function Number: 65
second_room_nightclub_setup()
{
	thread destroy_the_window_exit();
	thread move_bones_and_joker_up();
	thread exopush_start();
	thread preplaced_guys_function();
	thread advance_bones_and_joker_intro();
	thread setup_street_reunion_spawners();
	thread move_burke_outside_office();
	thread destroy_office_snipe_glass();
	thread temp_clip_delete();
	thread office_2guys_ambush();
	thread break_office_glass_ahead_of_time();
	thread initiate_exo_push_on_sniperguys_dead();
	thread initiate_exo_push_on_player_advance();
	thread last_guy_in_group();
	thread second_floor_snipers();
	thread kill_all_inside_guys_now();
	thread exo_push_combat_manager();
	thread bones_rollout_manager();
	thread exo_push_gourney();
	thread all_exopush_enemies_dead();
}

//Function Number: 66
dead_guy_for_moors()
{
	var_00 = getent("dead_sniper_spawner","targetname");
	var_01 = getent("dead_sniper_animorg","targetname");
	var_02 = var_00 maps\_utility::spawn_ai(1);
	var_02.animname = "generic";
	var_01 thread maps\_anim::anim_last_frame_solo(var_02,"airport_civ_pillar_exit_death");
}

//Function Number: 67
destroy_office_snipe_glass()
{
	var_00 = getglass("snipe_glass");
	var_01 = getglass("left_snipe_glass");
	destroyglass(var_00);
	destroyglass(var_01);
}

//Function Number: 68
temp_clip_delete()
{
	var_00 = getent("temp_window_clip","targetname");
	maps\_utility::trigger_wait_targetname("jump_window_clip_delete");
	if(isdefined(var_00))
	{
		var_00 connectpaths();
		var_00 delete();
	}
}

//Function Number: 69
bullets_break_office_glass_gag()
{
	var_00 = getentarray("office_shooter_org","targetname");
	var_01 = getentarray("office_shooter_target_org","targetname");
	maps\_utility::disable_trigger_with_targetname("office_first_enemy_intro_trigger");
	maps\_utility::trigger_wait_targetname("office_shooter_org_moment_trigger");
	wait(2.3);
	thread bullet_break_glass_gag_timer();
	foreach(var_03 in var_00)
	{
		var_03 thread shoot_at_these_targets(var_01);
	}

	common_scripts\utility::flag_wait("stop_shoot_org_moment");
	level notify("stop_shooting_fake_shots");
}

//Function Number: 70
shoot_at_these_targets(param_00)
{
	level endon("stop_shooting_fake_shots");
	for(;;)
	{
		var_01 = randomint(param_00.size);
		var_02 = magicbullet("iw5_bal27_sp",self.origin,param_00[var_01].origin);
		wait(randomfloatrange(0.1,0.3));
	}
}

//Function Number: 71
sneaky_reload()
{
	var_00 = level.player getcurrentweapon();
	var_01 = level.player getammocount(var_00);
	var_02 = level.player getcurrentweaponclipammo();
	var_03 = weaponclipsize(var_00);
	var_04 = var_03 - var_02;
	level.player setweaponammoclip(var_00,var_03);
	level.player setweaponammostock(var_00,var_01 - var_04);
}

//Function Number: 72
break_office_glass_ahead_of_time()
{
	var_00 = getglass("office_glass_break1");
	var_01 = getglass("office_glass_break2");
	destroyglass(var_00);
	destroyglass(var_01);
}

//Function Number: 73
office_2guys_ambush()
{
	var_00 = getentarray("office_spawner_guys_shootingfrom_office","targetname");
	maps\_utility::trigger_wait_targetname("office_shooter_org_moment_trigger");
	var_01 = getent("office_ambush_waitvol","targetname");
	foreach(var_03 in var_00)
	{
		var_04 = var_03 maps\_utility::spawn_ai(1);
		var_04.goalradius = 15;
		var_04 thread seek_player_on_trigger();
	}
}

//Function Number: 74
seek_player_on_trigger()
{
	self endon("death");
	maps\_utility::trigger_wait_targetname("player_moving_out_area1");
	wait(randomintrange(1,3));
	if(isalive(self))
	{
		maps\_utility::player_seek();
	}
}

//Function Number: 75
office_support_after_ambush()
{
	var_00 = getentarray("office_first_enemy_intro_spawner_DISABLED","targetname");
	maps\_utility::trigger_wait_targetname("office_first_enemy_intro_spawner_zone_trigger");
	foreach(var_02 in var_00)
	{
		var_03 = var_02 maps\_utility::spawn_ai();
	}
}

//Function Number: 76
wait_then_movetogoalvol(param_00)
{
	common_scripts\utility::flag_wait("stop_shoot_org_moment");
	wait(randomfloatrange(0.8,1.5));
	if(isalive(self))
	{
		self setgoalvolumeauto(param_00);
	}
}

//Function Number: 77
bullet_break_glass_gag_timer()
{
	wait(4.5);
	common_scripts\utility::flag_set("stop_shoot_org_moment");
}

//Function Number: 78
move_burke_outside_office()
{
	common_scripts\utility::flag_wait("move_burke_down");
	thread kill_last_sniper_guys();
	level.burke maps\_utility::disable_careful();
	level.burke.goalradius = 15;
	level.burke.ignoreall = 1;
	level.burke maps\_utility::disable_pain();
	var_00 = getnode("player_parkinglot_startorg","targetname");
	level.burke setgoalpos(var_00.origin);
	level.burke waittill("goal");
	level.burke.ignoreall = 0;
	level.burke maps\_utility::enable_pain();
}

//Function Number: 79
kill_last_sniper_guys()
{
	var_00 = getentarray("sniper_setup_guy","script_noteworthy");
	maps\_utility::trigger_wait_targetname("runto_exo_start_trigger");
	foreach(var_02 in var_00)
	{
		if(isalive(var_02))
		{
			var_03 = randomint(3);
			var_02 maps\detroit::bloody_death(var_03);
		}

		wait(randomintrange(1,2));
	}
}

//Function Number: 80
teleport_bones_and_joker()
{
	maps\_utility::trigger_wait_targetname("spawn_few_nightclub_guys_trigger");
	var_00 = getnode("bones_supressed_outside_node_startpoint","targetname");
	level.bones maps\_utility::teleport_ai(var_00);
	level.bones.goalradius = 15;
	wait(0.05);
	var_01 = getnode("joker_supressed_outside_node_startpoint","targetname");
	level.joker maps\_utility::teleport_ai(var_01);
	level.joker.goalradius = 15;
	level.joker.accuracy = 0;
	level.bones.accuracy = 0;
	level.joker.accuracy = 1;
	level.bones.accuracy = 1;
}

//Function Number: 81
sniper_kva_dead_body()
{
	var_00 = getent("kva_at_window_spawner_2","targetname");
	var_01 = var_00 maps\_utility::spawn_ai(1);
	wait(0.05);
	var_01.nodrop = 1;
	var_01.ignoreall = 1;
	var_01.ignoreme = 1;
	var_01 kill();
}

//Function Number: 82
waittill_enemy_group_size_is(param_00,param_01)
{
	thread maps\_shg_design_tools::trigger_to_notify(param_01);
	level endon(param_01);
	var_02 = self;
	while(var_02.size > param_00)
	{
		var_02 = maps\_utility::array_removedead_or_dying(var_02);
		wait 0.05;
	}
}

//Function Number: 83
monitor_death_and_reinforce(param_00,param_01)
{
	var_02 = self;
	for(var_03 = 0;var_03 < param_01;var_03++)
	{
		var_02 waittill("death");
		var_04 = common_scripts\utility::random(param_00);
		var_04.count = 1;
		var_02 = var_04 maps\_utility::spawn_ai(1);
		level.alleyway_fight_enemies[level.alleyway_fight_enemies.size] = var_02;
		wait(0.1);
	}

	foreach(var_04 in param_00)
	{
		var_04.count = 0;
	}
}

//Function Number: 84
setup_hazmat_intro_allies()
{
	thread burke_reunite_with_player_alley();
}

//Function Number: 85
burke_reunite_with_player_alley()
{
	thread burke_move_into_office();
	var_00 = getent("intro_alley_hide_spot3","targetname");
	var_00 thread maps\_anim::anim_loop_solo(level.burke,"wall_stack_idle","move ahead");
	var_01 = getnode("burke_take_a_shot_spot","targetname");
	common_scripts\utility::flag_wait("burke_alley_flashlight_off");
	level notify("burke_and_player_reunited");
	var_00 notify("move ahead");
	maps\_utility::battlechatter_off("allies");
	level.burke stopanimscripted();
	level.burke.ignoreall = 0;
	level.burke maps\_utility::enable_dontevershoot();
	level.burke maps\_utility::enable_cqbwalk();
	level.burke setgoalnode(var_01);
	common_scripts\utility::flag_set("vo_alley_burke_reunite");
	thread spawn_placed_alleyway_guys();
	thread dog_attack_enemies();
	level.burke waittill("goal");
	level.burke maps\_utility::disable_cqbwalk();
	common_scripts\utility::flag_set("vo_alley_burke_patrol");
	level common_scripts\utility::waittill_any_timeout(13,"move_allies_up_street1","second_street_alley_r2");
	if(isdefined(getent("move_allies_up_street1","targetname")))
	{
		maps\_utility::disable_trigger_with_targetname("move_allies_up_street1");
	}

	if(common_scripts\utility::flag("stop_burke_asking_player_to_drop_patrol") == 0)
	{
		common_scripts\utility::flag_set("vo_alley_burke_too_slow");
		wait 0.05;
		level.burke.ignoreall = 0;
		level.burke maps\_utility::clear_generic_run_anim();
		level.burke maps\_utility::enable_careful();
		level.burke maps\_utility::disable_dontevershoot();
		var_02 = getaiarray("axis");
		var_03 = 0;
		if(isdefined(level.burke.enemy) && isdefined(level.burke.a.aimidlethread) && level.burke animscripts\utility::canseeenemy(0))
		{
			level.burke shoot(1000,level.burke.enemy geteye());
			level.burke.enemy kill(level.burke geteye(),level.burke);
		}

		common_scripts\utility::flag_set("_stealth_spotted");
		if(isdefined(getent("move_allies_up_street1","targetname")) && !isdefined(getent("move_allies_up_street1","targetname").trigger_off))
		{
			maps\_utility::activate_trigger_with_targetname("move_allies_up_street1");
		}

		common_scripts\utility::flag_set("move_allies_up_street1");
		level notify("snipe_ambush_fail");
		common_scripts\utility::flag_set("stop_burke_asking_player_to_drop_patrol");
		level.burke.accuracy = 1;
		wait(2);
		level.burke.accuracy = 0.25;
		level notify("kickoff_street_fight");
	}

	common_scripts\utility::flag_set("vo_alley_combat");
}

//Function Number: 86
burke_move_into_office()
{
	var_00 = getnode("burke_path_onfoot_bar","targetname");
	var_01 = getnode("burke_path_onfoot_01a","targetname");
	common_scripts\utility::flag_wait("send_burke_to_office_wait_point");
	common_scripts\utility::flag_wait("all_street_fighters_dead");
	common_scripts\utility::flag_set("sitrep_dialogue_line");
	level.burke maps\_utility::enable_careful();
	level.burke setgoalnode(var_00);
	common_scripts\utility::flag_wait("bar_has_been_cleared");
	level.burke setgoalnode(var_01);
}

//Function Number: 87
bar_guy_check_function()
{
	common_scripts\utility::flag_wait("player_has_entered_the_bar");
	for(;;)
	{
		var_00 = getentarray("bar_fighter","script_noteworthy");
		var_00 = maps\_utility::remove_dead_from_array(var_00);
		if(var_00.size == 0)
		{
			common_scripts\utility::flag_set("bar_has_been_cleared");
			thread barfighters_notify();
			return;
		}

		wait(0.05);
	}
}

//Function Number: 88
street_fighter_check_function()
{
	for(;;)
	{
		var_00 = getentarray("street_fighters","script_noteworthy");
		var_00 = maps\_utility::remove_dead_from_array(var_00);
		if(var_00.size == 0)
		{
			common_scripts\utility::flag_set("all_street_fighters_dead");
			return;
		}

		wait(0.05);
	}
}

//Function Number: 89
mitchell_over_here_dialogue()
{
	level endon("burke_and_player_reunited");
	maps\_utility::trigger_wait_targetname("begin_onfoot_street_section");
	thread onfoot_start_alley_setup();
	common_scripts\utility::flag_set("obj_reunite_with_burke_pos_reunite");
	maps\detroit_school::is_player_near_burke(600);
	common_scripts\utility::flag_set("vo_alley_burke_downhere");
	wait(4);
	if(distance2d(level.burke.origin,level.player.origin) > 500)
	{
		common_scripts\utility::flag_set("vo_alley_burke_overhere");
	}
}

//Function Number: 90
first_nightclub_room_setup()
{
	maps\_utility::trigger_wait_targetname("office_first_enemy_intro_trigger");
	level notify("nightclub_started");
	var_00 = getglass("skylight_glass_01");
	var_01 = getent("skylight_glass_01_org","targetname");
	var_02 = getglass("skylight_glass_02");
	var_03 = getent("skylight_glass_02_org","targetname");
	var_04 = getglass("skylight_glass_03");
	var_05 = getent("skylight_glass_03_org","targetname");
	var_06 = getglass("skylight_glass_04");
	var_07 = getent("skylight_glass_04_org","targetname");
	var_08 = getglass("skylight_glass_05");
	var_09 = getent("skylight_glass_05_org","targetname");
	var_0A = getglass("skylight_glass_06");
	var_0B = getent("skylight_glass_06_org","targetname");
	var_0C = getglass("skylight_glass_07");
	var_0D = getent("skylight_glass_07_org","targetname");
	var_0E = getglass("skylight_glass_08");
	var_0F = getent("skylight_glass_08_org","targetname");
	var_10 = getglass("skylight_glass_09");
	var_11 = getent("skylight_glass_09_org","targetname");
	var_12 = getglass("skylight_glass_10");
	var_13 = getent("skylight_glass_10_org","targetname");
	var_14 = getglass("skylight_glass_11");
	var_15 = getent("skylight_glass_11_org","targetname");
	var_16 = getglass("skylight_glass_12");
	var_17 = getent("skylight_glass_12_org","targetname");
	var_18 = getglass("skylight_glass_13");
	var_19 = getent("skylight_glass_13_org","targetname");
	var_1A = getglass("skylight_glass_14");
	var_1B = getent("skylight_glass_14_org","targetname");
	var_1C = getglass("skylight_glass_15");
	var_1D = getent("skylight_glass_15_org","targetname");
	thread office_glass(var_00,var_01);
	thread office_glass(var_02,var_03);
	thread office_glass(var_04,var_05);
	thread office_glass(var_06,var_07);
	thread office_glass(var_08,var_09);
	thread office_glass(var_0A,var_0B);
	thread office_glass(var_0C,var_0D);
	thread office_glass(var_0E,var_0F);
	thread office_glass(var_10,var_11);
	thread office_glass(var_12,var_13);
	thread office_glass(var_14,var_15);
	thread office_glass(var_16,var_17);
	thread office_glass(var_18,var_19);
	thread office_glass(var_1A,var_1B);
	thread office_glass(var_1C,var_1D);
}

//Function Number: 91
office_glass(param_00,param_01)
{
	level waittillmatch(param_00,"glass_destroyed");
	soundscripts\_snd::snd_message("office_skylights_breakable",param_01);
}

//Function Number: 92
second_nightclub_room_setup()
{
	maps\_utility::trigger_wait_targetname("office_first_enemy_intro_trigger");
	thread sniper_kva_dead_body();
}

//Function Number: 93
self_tracking_functions()
{
	thread are_we_close(500,"begin_first_office_room_fight");
	am_i_hit();
	i_am_hit_engage();
}

//Function Number: 94
are_we_close(param_00,param_01)
{
	level endon(param_01);
	for(;;)
	{
		if(distance2d(self.origin,level.player.origin) <= param_00)
		{
			level notify(param_01);
		}

		wait(0.05);
	}
}

//Function Number: 95
am_i_hit()
{
	level endon("begin_first_office_room_fight");
	var_00 = self.health;
	for(;;)
	{
		if(var_00 > self.health)
		{
			level notify("begin_first_office_room_fight");
		}

		wait(0.1);
	}
}

//Function Number: 96
i_am_hit_engage()
{
	level.player.ignoreme = 0;
	level.burke.ignoreme = 0;
	level.burke.ignoreall = 0;
	maps\detroit_school::remove_patrol_anim_set();
	self.ignoreall = 0;
	self.ignoreme = 0;
}

//Function Number: 97
spawn_few_nightclub_guys()
{
	maps\_utility::trigger_wait_targetname("spawn_few_nightclub_guys_trigger");
	thread maps\_utility::autosave_by_name("seeker");
	var_00 = getentarray("office_firstroom_wave1_spawner","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = var_02 maps\_utility::spawn_ai(1);
		if(isalive(var_03))
		{
			var_03 maps\detroit_lighting::add_enemy_flashlight("flashlight",undefined,undefined,25);
		}

		wait(0.05);
	}
}

//Function Number: 98
goto_goal()
{
	self.ignoreall = 1;
	self waittill("goal");
	self.ignreall = 0;
}

//Function Number: 99
exterior_street_kickoff()
{
	thread top_level_kva_guys();
	var_00 = getent("kva_outside_kickoff_spawner1","targetname");
	var_01 = getent("kva_outside_kickoff_spawner2","targetname");
	var_02 = getnode("guy_1_break_hidenode","targetname");
	var_03 = getnode("guy_2_break_hidenode","targetname");
	var_04 = getent("soldiers_outside_kickoff_talking","targetname");
	var_05 = getent("soldiers_outside_kickoff_talking_2","targetname");
	common_scripts\utility::flag_wait("rendezvous_obj_reached");
	common_scripts\utility::flag_set("obj_reunite_with_burke_complete");
	var_06 = var_00 maps\_utility::spawn_ai(1);
	var_07 = var_01 maps\_utility::spawn_ai(1);
	var_06.health = 10;
	var_07.health = 10;
	var_06.fovcosine = 0.95;
	var_07.fovcosine = 0.95;
	var_06 setgoalpos(var_04.origin);
	var_07 setgoalpos(var_05.origin);
	var_06 maps\_utility::disable_surprise();
	var_07 maps\_utility::disable_surprise();
	level.burke.ignoreme = 1;
	level.burke maps\_utility::disable_surprise();
	var_06.animname = "generic";
	var_07.animname = "generic";
	var_06 thread maps\detroit::force_patrol_anim_set("active_right");
	var_07 thread maps\detroit::force_patrol_anim_set("active");
	var_06 thread maps\detroit_lighting::add_enemy_flashlight("flashlight",undefined,undefined,25);
	var_07 thread maps\detroit_lighting::add_enemy_flashlight("flashlight",undefined,undefined,25);
	var_06 thread begin_the_street_fight();
	var_07 thread begin_the_street_fight();
	var_06 thread wake_me_up_if_still_alive();
	var_07 thread wake_me_up_if_still_alive();
	var_06 thread combat_state();
	var_07 thread combat_state();
	level.burke thread re_enable_combat();
}

//Function Number: 100
re_enable_combat()
{
	common_scripts\utility::flag_wait("one_street_guy_dead_kickoff_fight_now");
	level.burke maps\_utility::disable_dontevershoot();
	level notify("kickoff_street_fight");
	maps\_stealth_utility::disable_stealth_system();
}

//Function Number: 101
combat_state()
{
	level endon("stop_all_combat_state");
	self endon("death");
	for(;;)
	{
		if(isdefined(self.enemy) || common_scripts\utility::flag("_stealth_spotted"))
		{
			maps\_utility::ent_flag_clear("_stealth_enabled");
			common_scripts\utility::flag_set("one_street_guy_dead_kickoff_fight_now");
			common_scripts\utility::flag_set("vo_alley_combat");
			level notify("stop_burke_asking_player_to_drop_patrol");
			level notify("kickoff_street_fight");
			maps\_utility::disable_careful();
			maps\detroit_school::remove_patrol_anim_set();
			self notify("flashlight_off");
			self notify("end_patrol");
			self.alwaysrunforward = undefined;
			level notify("patrol_alerted");
			common_scripts\utility::flag_set("_stealth_spotted");
			return;
		}

		wait(0.05);
	}
}

//Function Number: 102
wake_me_up_if_still_alive()
{
	while(isalive(self))
	{
		common_scripts\utility::flag_wait("one_street_guy_dead_kickoff_fight_now");
		self setgoalpos(self.origin);
		return;
	}
}

//Function Number: 103
begin_the_street_fight()
{
	for(;;)
	{
		common_scripts\utility::waittill_any("death","alert","_stealth_spotted","damage");
		level notify("kickoff_street_fight");
		if(!common_scripts\utility::flag("one_street_guy_dead_kickoff_fight_now"))
		{
			if(isdefined(getent("move_allies_up_street1","targetname")) && !isdefined(getent("move_allies_up_street1","targetname").trigger_off))
			{
				maps\_utility::activate_trigger_with_targetname("move_allies_up_street1");
				maps\_utility::disable_trigger_with_targetname("move_allies_up_street1");
			}

			level.burke maps\_utility::disable_dontevershoot();
			common_scripts\utility::flag_set("one_street_guy_dead_kickoff_fight_now");
			common_scripts\utility::flag_set("move_allies_up_street1");
			level notify("kickoff_street_fight");
			common_scripts\utility::flag_set("stop_burke_asking_player_to_drop_patrol");
			common_scripts\utility::flag_set("vo_alley_combat");
		}
	}
}

//Function Number: 104
notify_spotted_player_alleyway()
{
	self endon("death");
	common_scripts\utility::waittill_any("_stealth_spotted","alert","spotted_player");
	maps\detroit_school::remove_patrol_anim_set();
	self notify("flashlight_off");
	level notify("kickoff_street_fight");
}

//Function Number: 105
seek_player_on_fail()
{
	self endon("death");
	level waittill("snipe_ambush_fail");
	maps\_utility::set_goal_pos(level.player.origin);
	wait(randomfloatrange(0.1,0.4));
	thread maps\_utility::player_seek();
}

//Function Number: 106
player_health_check()
{
	level.player endon("death");
	level endon("kickoff_street_fight");
	level endon("snipe_ambush_fail");
	level endon("snipe_ambush_success");
	var_00 = level.player.health;
	for(;;)
	{
		if(var_00 > level.player.health)
		{
			level notify("kickoff_street_fight");
		}

		wait(0.05);
	}
}

//Function Number: 107
kickoff_modify()
{
	level waittill("kickoff_street_fight");
	maps\_stealth_utility::disable_stealth_system();
	common_scripts\utility::flag_set("vo_alley_combat");
	level.burke maps\_utility::disable_cqbwalk();
	level.burke maps\_utility::clear_generic_run_anim();
}

//Function Number: 108
health_track()
{
	var_00 = self.health;
	for(;;)
	{
		if(self.health < var_00)
		{
			self stopanimscripted();
			maps\detroit_school::remove_patrol_anim_set();
			return;
		}

		wait(0.05);
	}
}

//Function Number: 109
fail_enable(param_00,param_01)
{
	level waittill("snipe_ambush_fail");
	if(isalive(self))
	{
		self.ignoreall = 0;
		self.ignoreme = 0;
		self notify("stop_loop");
		param_00 notify("stop_loop");
		maps\_utility::set_moveplaybackrate(1);
		self stopanimscripted();
		self setgoalnode(param_01);
	}
}

//Function Number: 110
top_level_kva_guys()
{
	level waittill("kickoff_street_fight");
	wait(7);
	var_00 = getent("alley_fight_top_rpg_spawner","targetname");
	var_01 = getent("alley_fight_top_ar_spawner","targetname");
	var_02 = var_00 maps\_utility::spawn_ai(1);
	var_02 maps\detroit_lighting::add_enemy_flashlight("flashlight",undefined,undefined,25);
	var_02.goalradius = 15;
	var_02.fixednode = 1;
	var_02.combatmode = "no_cover";
	var_03 = var_01 maps\_utility::spawn_ai(1);
	var_03 maps\detroit_lighting::add_enemy_flashlight("flashlight",undefined,undefined,25);
	var_03.fixednode = 1;
	var_03.goalradius = 15;
}

//Function Number: 111
street_train_function()
{
	level endon("nightclub_started");
	var_00 = randomintrange(900,1700);
	for(;;)
	{
		spawn_street_train(var_00);
		wait(randomintrange(8,16));
		if(common_scripts\utility::flag("hospital_escape_trains_only"))
		{
			return;
		}
	}
}

//Function Number: 112
reverse_street_train_function()
{
	level endon("nightclub_started");
	var_00 = randomintrange(900,1700);
	for(;;)
	{
		spawn_reverse_street_train(var_00);
		wait(randomintrange(8,16));
		if(common_scripts\utility::flag("hospital_escape_trains_only"))
		{
			return;
		}
	}
}

//Function Number: 113
street_fight_after_snipe()
{
	level waittill("kickoff_street_fight");
	level.burke maps\_utility::disable_cqbwalk();
	thread first_guy_looking();
	wait(6);
	thread outside_group_1();
	thread maps\_utility::autosave_by_name("seeker");
}

//Function Number: 114
spawn_placed_alleyway_guys()
{
	var_00 = getentarray("enemyspawn_onfoot_intro_placed","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = var_02 maps\_utility::spawn_ai(1);
		var_04 = var_03.combatmode;
		var_03.combatmode = "no_cover";
		var_03 thread activate_guy();
		var_03 thread kickoff_notify();
		var_03 thread break_from_ignoreall();
		var_03 thread stealth_guy_think_on_flag();
	}

	street_fighter_check_function();
}

//Function Number: 115
stealth_guy_think_on_flag()
{
	self endon("death");
	maps\detroit_school::stealth_guy_think();
	common_scripts\utility::flag_wait("rendezvous_obj_reached");
}

//Function Number: 116
kickoff_notify()
{
	common_scripts\utility::waittill_any("damage","_stealth_spotted","spotted_player","death");
	level notify("kickoff_street_fight");
	common_scripts\utility::flag_set("_stealth_spotted");
}

//Function Number: 117
break_from_ignoreall()
{
	self endon("death");
	level waittill("kickoff_street_fight");
	self.ignoreall = 0;
}

//Function Number: 118
dog_attack_enemies()
{
	level waittill("kickoff_street_fight");
	var_00 = getent("dog_spawner_1","targetname");
	var_01 = getentarray("dog_spawner_2","targetname");
	var_02 = var_00 maps\_utility::spawn_ai(1);
	var_02 thread maps\_utility::player_seek();
	wait(3);
	foreach(var_04 in var_01)
	{
		var_05 = var_04 maps\_utility::spawn_ai(1);
		var_05 thread maps\_utility::player_seek();
	}

	common_scripts\utility::flag_wait("hide_and_seek");
	var_07 = getent("last_dog_spawner","targetname");
	var_08 = var_07 maps\_utility::spawn_ai(1);
	var_08 thread maps\_utility::player_seek();
}

//Function Number: 119
temp_dog_sfx()
{
	self endon("death");
	for(;;)
	{
		wait(randomintrange(0,3));
		soundscripts\_snd::snd_message("temp_dog_bark",self);
		wait(randomintrange(3,5));
	}
}

//Function Number: 120
activate_guy()
{
	self endon("death");
	level waittill("kickoff_street_fight");
	self stopanimscripted();
	self.ignoreall = 0;
	self.ignoreme = 0;
	self.combatmode = "cover";
	group_wait_seek_player(2,"street_fighters");
}

//Function Number: 121
group_wait_seek_player(param_00,param_01)
{
	for(;;)
	{
		var_02 = getentarray(param_01,"script_noteworthy");
		if(var_02.size < param_00)
		{
			maps\_utility::player_seek();
		}

		wait(0.05);
	}
}

//Function Number: 122
bar_setup()
{
	thread bar_guys_waiting();
	var_00 = getentarray("kva_barcombat_spawner_group","targetname");
	var_01 = getent("nighthawks_vol","targetname");
	common_scripts\utility::flag_wait("move_allies_up_street1");
	foreach(var_03 in var_00)
	{
		var_04 = var_03 maps\_utility::spawn_ai();
		var_04 setgoalvolumeauto(var_01);
		var_04 maps\detroit_lighting::add_enemy_flashlight("flashlight",undefined,undefined,25);
	}

	thread bar_guy_check_function();
}

//Function Number: 123
bar_guys_waiting()
{
	common_scripts\utility::flag_wait("move_allies_up_street1");
	thread burke_move_through_alley_cover();
	thread maps\detroit::battle_chatter_on_both();
	var_00 = getent("kva_barcombat_animspawn1","targetname");
	var_01 = getent("kva_barcombat_animspawn2","targetname");
	var_02 = getnode("burke_path_onfoot_01a","targetname");
	var_03 = var_00 maps\_utility::spawn_ai(1);
	var_03 maps\detroit_lighting::add_enemy_flashlight("flashlight",undefined,undefined,25);
	var_04 = var_01 maps\_utility::spawn_ai(1);
	var_04 maps\detroit_lighting::add_enemy_flashlight("flashlight",undefined,undefined,25);
	var_03.ignoreall = 1;
	var_03.ignoreme = 1;
	var_04.ignoreall = 1;
	var_04.ignoreme = 1;
	common_scripts\utility::flag_wait("hide_and_seek");
	if(isalive(var_03))
	{
		var_03.ignoreall = 0;
		var_03.ignoreme = 0;
	}

	if(isalive(var_04))
	{
		var_04.ignoreall = 0;
		var_04.ignoreme = 0;
	}
}

//Function Number: 124
first_guy_looking()
{
	var_00 = getent("alley_spotlight_guy_vol","targetname");
	var_01 = getent("first_cover_streetfight_spotlighter","targetname");
	wait(0.3);
	var_02 = var_01 maps\_utility::spawn_ai(1);
	var_02 setgoalvolumeauto(var_00);
	var_02 endon("death");
	var_02 maps\detroit_lighting::add_enemy_flashlight("flashlight","med");
	var_02 maps\detroit::set_patrol_anim_set("active");
	var_02 maps\_utility::set_moveplaybackrate(1.5);
	wait(4);
	var_02 thread return_to_normal();
	var_02.ignoreall = 0;
	level notify("flashlight_off");
}

//Function Number: 125
return_to_normal()
{
	maps\_utility::clear_generic_idle_anim();
	maps\_utility::set_moveplaybackrate(1);
	maps\_utility::clear_run_anim();
	self allowedstances("stand","crouch","prone");
	self.disablearrivals = 0;
	self.disableexits = 0;
	self stopanimscripted();
	self notify("stop_animmode");
	self notify("flashlight_off");
	self.script_nobark = undefined;
}

//Function Number: 126
top_guy_spawn()
{
	level endon("AI_broken_out");
	level endon("searching_alleyway_guy_is_dead");
	var_00 = getent("exterior_investigate_animorg","targetname");
	var_01 = getent("investigation spawner","targetname");
	var_02 = var_01 maps\_utility::spawn_ai(1);
	wait 0.05;
	var_02.animname = "generic";
	var_02.ignoreall = 1;
	var_00 maps\_anim::anim_reach_solo(var_02,"so_hijack_search_flashlight_high_loop_single");
	thread break_out_if_damaged(var_02);
	var_02 maps\detroit_lighting::add_enemy_flashlight("flashlight","med");
	var_00 thread maps\_anim::anim_single_solo(var_02,"so_hijack_search_flashlight_high_loop_single");
	wait(2);
	if(isalive(var_02))
	{
		var_02 notify("flashlight_off");
		var_02.ignoreall = 0;
		var_02 stopanimscripted();
		thread spawn_the_rest();
	}
}

//Function Number: 127
break_out_if_damaged(param_00)
{
	param_00 endon("death");
	var_01 = param_00.health;
	for(;;)
	{
		if(param_00.health < var_01)
		{
			wait(0.4);
			param_00.ignoreall = 0;
			param_00 stopanimscripted();
			level notify("AI_broken_out");
			level notify("searching_alleyway_guy_is_dead");
			self notify("flashlight_off");
			return;
		}

		wait(0.05);
	}
}

//Function Number: 128
spawn_the_rest()
{
}

//Function Number: 129
outside_group_1()
{
	var_00 = getentarray("kva_streetcombat_spawner_group","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = var_02 maps\_utility::spawn_ai(1);
		var_03.goalradius = 15;
		var_03 maps\detroit_lighting::add_enemy_flashlight("flashlight",undefined,undefined,25);
	}
}

//Function Number: 130
outside_group_start_fighting()
{
	level waittill("kickoff_street_fight");
	self stopanimscripted();
	self.ignoreall = 0;
	self.ignoreme = 0;
}

//Function Number: 131
battle_chatter_check_alley()
{
	level waittill("partner_shot");
	thread maps\detroit::battle_chatter_on_both();
}

//Function Number: 132
burke_move_through_alley_cover()
{
	common_scripts\utility::flag_wait("second_street_alley_r2");
	wait(0.05);
	if(isdefined(getent("second_street_alley_r2","targetname")))
	{
		maps\_utility::disable_trigger_with_targetname("second_street_alley_r2");
	}

	common_scripts\utility::flag_wait("path_trigger_05");
	wait(0.05);
	if(isdefined(getent("path_trigger_05","targetname")))
	{
		maps\_utility::disable_trigger_with_targetname("path_trigger_05");
	}

	common_scripts\utility::flag_wait("hide_and_seek");
	thread street_fighters_gone_yet();
	wait(0.05);
	if(isdefined(getent("hide_and_seek","targetname")))
	{
		maps\_utility::disable_trigger_with_targetname("hide_and_seek");
	}

	common_scripts\utility::flag_wait("bar_interior_trigger");
	common_scripts\utility::flag_set("player_has_entered_the_bar");
	level notify("street_fighting_over");
	thread kill_all_streetfighters();
	wait(0.05);
}

//Function Number: 133
street_fighters_gone_yet()
{
	level endon("street_fighting_over");
	for(;;)
	{
		var_00 = getentarray("street_fighters","script_noteworthy");
		var_00 = maps\_utility::remove_dead_from_array(var_00);
		if(var_00.size == 0)
		{
			var_01 = getnode("burke_inner_barnode","targetname");
			level.burke setgoalnode(var_01);
			thread streetfighters_notify();
			return;
		}

		wait(0.05);
	}
}

//Function Number: 134
kill_all_streetfighters()
{
	var_00 = getentarray("street_fighters","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 thread random_bloody_death(0.5);
	}
}

//Function Number: 135
streetfighters_notify()
{
	common_scripts\utility::flag_set("move_allies_up_street1");
	common_scripts\utility::flag_set("second_street_alley_r2");
	common_scripts\utility::flag_set("path_trigger_05");
	common_scripts\utility::flag_set("hide_and_seek");
}

//Function Number: 136
barfighters_notify()
{
	common_scripts\utility::flag_set("move_allies_up_street1");
	common_scripts\utility::flag_set("second_street_alley_r2");
	common_scripts\utility::flag_set("path_trigger_05");
	common_scripts\utility::flag_set("hide_and_seek");
	if(isdefined(getent("bar_interior_trigger","targetname")) && !isdefined(getent("bar_interior_trigger","targetname").trigger_off))
	{
		maps\_utility::activate_trigger_with_targetname("bar_interior_trigger");
	}

	common_scripts\utility::flag_set("bar_interior_trigger");
	wait(0.05);
}

//Function Number: 137
guy1_reach_wait()
{
	self endon("death");
	level endon("partner_shot");
	var_00 = getent("soldiers_outside_kickoff_talking","targetname");
	self waittill("goal");
	self notify("flashlight_off");
	self.allowdeath = 1;
	var_00 thread maps\_anim::anim_loop_solo(self,"talking_guard_1","guards_stop_talking");
}

//Function Number: 138
guy2_reach_wait()
{
	self endon("death");
	level endon("partner_shot");
	var_00 = getent("soldiers_outside_kickoff_talking_2","targetname");
	self waittill("goal");
	self notify("flashlight_off");
	var_00 thread maps\_anim::anim_loop_solo(self,"talking_guard_2","guards_stop_talking");
}

//Function Number: 139
setup_guy_for_animation(param_00,param_01,param_02,param_03)
{
	if(isdefined(self))
	{
		self.animname = "generic";
		if(param_00 == 1)
		{
			self.ignoreall = 1;
		}

		if(param_01 == 1)
		{
			self.ignoreme = 1;
		}

		self.goalradius = 15;
		if(param_02 == 1)
		{
			maps\detroit_lighting::add_enemy_flashlight("flashlight","med");
		}

		if(param_03 == 1)
		{
			maps\detroit::set_patrol_anim_set("active");
		}

		if(param_03 == 0)
		{
			maps\detroit::set_patrol_anim_set("gundown");
		}
	}
}

//Function Number: 140
setup_animated_guy()
{
	if(isdefined(self))
	{
		self.animname = "generic";
		self.ignoreall = 1;
		self.goalradius = 15;
		maps\_utility::set_moveplaybackrate(0.8);
	}
}

//Function Number: 141
spawn_street_train(param_00)
{
	if(!common_scripts\utility::flag("hospital_escape_trains_only"))
	{
		var_01 = getent("street_train1_path_start","targetname");
		var_02 = getentarray("street_train1_path","targetname");
		var_03 = maps\detroit_exit_drive::run_train(var_01,var_02,param_00);
		var_03 waittill("death");
	}
}

//Function Number: 142
spawn_reverse_street_train(param_00)
{
	if(!common_scripts\utility::flag("hospital_escape_trains_only"))
	{
		var_01 = getent("street_train2_path_start","targetname");
		var_02 = getentarray("school_train2_path","targetname");
		var_03 = maps\detroit_exit_drive::run_train(var_01,var_02,param_00);
		var_03 waittill("death");
	}
}

//Function Number: 143
initiate_exo_push_on_sniperguys_dead()
{
	level endon("stop_tracking_sniperguys");
	common_scripts\utility::flag_wait("start_tracking_sniper_deaths");
	var_00 = getentarray("sniper_setup_guy","script_noteworthy");
	maps\_utility::waittill_dead_or_dying(var_00);
	maps\_utility::activate_trigger_with_targetname("runto_exo_start_trigger");
	level notify("time to stop shooting the roof");
	level notify("time to stop shooting the ambulance");
	common_scripts\utility::flag_set("window_ambush_flag");
}

//Function Number: 144
initiate_exo_push_on_player_advance()
{
	common_scripts\utility::flag_wait("exo_push_spawner_scaffolding_trigger");
	level notify("stop_tracking_sniperguys");
	maps\_utility::activate_trigger_with_targetname("runto_exo_start_trigger");
	level notify("time to stop shooting the roof");
	level notify("time to stop shooting the ambulance");
	common_scripts\utility::flag_set("window_ambush_flag");
}

//Function Number: 145
second_floor_snipers()
{
	var_00 = getentarray("sniper_setup_spawner","targetname");
	common_scripts\utility::flag_wait("spawn_second_floor_spawners");
	foreach(var_02 in var_00)
	{
		var_03 = var_02 maps\_utility::spawn_ai();
		if(isalive(var_03))
		{
			var_03.custom_laser_function = ::detroit_laser;
			var_03 thread maps\_utility::disable_long_death();
			var_03 thread kill_when_player_reaches_overhang();
			var_03 thread kill_off_inside_guy();
		}
	}
}

//Function Number: 146
kill_all_inside_guys_now()
{
	common_scripts\utility::flag_wait("begin_spawning_troops_hospital");
	var_00 = getentarray("inside_guy_killme","script_noteworthy");
	var_00 = maps\_utility::array_removedead(var_00);
	foreach(var_02 in var_00)
	{
		if(isalive(var_02))
		{
			var_02 kill();
		}
	}

	var_04 = getnode("gideon_cheat_teleport_spot","targetname");
	var_05 = getnode("kva_at_window_guy1_cover1","targetname");
	var_06 = getent("gideon_outside_check_vol","targetname");
	if(distance2d(level.burke.origin,var_05.origin) > 400)
	{
		if(level.burke istouching(var_06))
		{
			return;
		}

		level.burke maps\_utility::teleport_ai(var_04);
		var_07 = getnode("burke_rendezvous_animnode","targetname");
		level.burke setgoalnode(var_07);
	}
}

//Function Number: 147
kill_when_player_reaches_overhang()
{
	self endon("death");
	common_scripts\utility::flag_wait("move_burke_down");
	wait(randomfloatrange(1.2,2.4));
	maps\detroit::bloody_death();
}

//Function Number: 148
detroit_laser()
{
	self laseron("lag_snipper_laser");
}

//Function Number: 149
last_guy_in_group()
{
	common_scripts\utility::flag_wait("start_tracking_sniper_deaths");
	var_00 = getentarray("sniper_setup_guy","script_noteworthy");
	var_01 = [];
	for(;;)
	{
		foreach(var_03 in var_00)
		{
			if(isalive(var_03))
			{
				var_01[var_01.size] = var_03;
			}
		}

		if(var_01.size == 1)
		{
			common_scripts\utility::flag_set("move_to_be_killed");
			var_01 = maps\_utility::remove_dead_from_array(var_01);
			var_01[0] thread move_to_death_spot();
			return;
		}

		var_01 = [];
		wait(0.5);
	}
}

//Function Number: 150
move_to_death_spot()
{
	self endon("death");
	wait(randomfloatrange(0.2,0.8));
	var_00 = getnode("last_node_to_hide","targetname");
	self.ignoreall = 1;
	self.goalradius = 15;
	thread kill_me_in_x_seconds(5);
	self setgoalnode(var_00);
	self waittill("goal");
	self.ignoreall = 0;
}

//Function Number: 151
kill_me_in_x_seconds(param_00)
{
	wait(param_00);
	if(isalive(self))
	{
		maps\detroit::bloody_death();
	}
}

//Function Number: 152
begin_exo_push(param_00)
{
	common_scripts\utility::flag_wait_any("ok_to_start_exo_push","exo_push_spawner_scaffolding_trigger");
	level.burke thread maps\_utility::disable_cqbwalk();
	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	soundscripts\_snd::snd_message("begin_exo_push");
	thread begin_spawnning_exo_spawners();
	thread back_line_of_fire();
	thread second_line_of_fire();
	thread stage1_ambush();
	thread stage2_ambush();
	thread bloody_death_all_survivors();
	thread back_fake_bullets();
	thread end_ambulance_anim_early();
	thread exo_push_hospital_callout();
	thread player_is_pushing_rumble();
	common_scripts\utility::flag_set("obj_exo_push_give");
	var_01 = getent("exo_push_ambulance","targetname");
	level.truck = var_01;
	var_02 = getent("exo_push_first_animorg","targetname");
	playfxontag(common_scripts\utility::getfx("det_exo_push_sparks"),var_01,"TAG_WHEEL_FRONT_RIGHT");
	var_01 thread truck_distance_to_end();
	var_03 = getent("exo_push_player_trigger","targetname");
	var_04 = getent("exo_push_team_goalorg_joker","targetname");
	var_05 = getent("exo_push_team_goalorg_bones","targetname");
	var_06 = getent("exo_push_team_goalorg_burke","targetname");
	var_03 enablelinkto();
	var_03 linkto(var_01,"tag_origin",(-140,-40,30),(0,0,0));
	thread exo_push_think_burke(var_01,var_02,param_00);
	thread exo_push_think_truck(var_01,var_02);
	var_07 = maps\_utility::spawn_anim_model("world_body",level.player.origin);
	var_01 maps\_anim::anim_first_frame_solo(var_07,"exo_push_attach","tag_driver");
	var_07 linkto(var_01,"tag_driver");
	var_07 hide();
	level.burke maps\_utility::set_ignoresuppression(1);
	level.burke maps\_utility::disable_pain();
	level.joker maps\_utility::set_ignoresuppression(1);
	level.joker maps\_utility::disable_pain();
	level.bones maps\_utility::set_ignoresuppression(1);
	level.bones maps\_utility::disable_pain();
	var_08 = 1;
	while(!common_scripts\utility::flag("exo_push_arrived"))
	{
		if(!common_scripts\utility::flag("exo_push_burke_attaching"))
		{
			common_scripts\utility::flag_wait("exo_push_burke_attaching");
			wait(3.5);
		}

		var_03 sethintstring(&"DETROIT_PROMPT_PUSH");
		var_03 makeusable();
		var_03 thread disable_me_when_exopush_finished();
		var_03 waittill("trigger");
		common_scripts\utility::flag_set("exo_push_has_been_started");
		var_09 = 0.5;
		var_07 hide();
		level.player playerlinktoblend(var_07,"tag_player",var_09,0.25,0.25);
		var_03 makeunusable();
		var_03 sethintstring("");
		level.player maps\_shg_utility::setup_player_for_scene(1);
		var_07 show();
		common_scripts\utility::flag_set("exo_push_player_attached");
		soundscripts\_snd::snd_message("ambulance_push_attach","exo_push_player_attached");
		var_01 setanimrestart(var_01 maps\_utility::getanim("exo_push_attach"));
		var_01 maps\_anim::anim_single_solo(var_07,"exo_push_attach","tag_driver");
		var_01 clearanim(var_01 maps\_utility::getanim("exo_push_attach"),0.2);
		var_01 setanimrestart(var_01 maps\_utility::getanim("exo_push_idle")[0]);
		common_scripts\utility::flag_set("exo_push_should_idle");
		thread exo_push_think_player_attached(var_01,var_07);
		while(common_scripts\utility::flag("exo_push_should_idle") || common_scripts\utility::flag("exo_push_should_push"))
		{
			var_0A = level.player getnormalizedmovement()[0];
			if(level.player usebuttonpressed())
			{
				common_scripts\utility::flag_set("exo_push_should_push");
				common_scripts\utility::flag_set("van_pushed_atlaest_once");
				common_scripts\utility::flag_clear("exo_push_should_idle");
				var_01 soundscripts\_snd::snd_message("ambulance_push_active");
			}
			else
			{
				common_scripts\utility::flag_clear("exo_push_should_push");
				common_scripts\utility::flag_clear("exo_push_should_idle");
				var_01 soundscripts\_snd::snd_message("ambulance_push_step_away");
				common_scripts\utility::flag_clear("aud_ambulance_pushing");
			}

			if(common_scripts\utility::flag("exo_push_arrived") || !isalive(level.player))
			{
				common_scripts\utility::flag_clear("exo_push_should_push");
				common_scripts\utility::flag_clear("exo_push_should_idle");
				var_01 soundscripts\_snd::snd_message("ambulance_push_sequence_end");
				common_scripts\utility::flag_clear("aud_ambulance_pushing");
				break;
			}

			wait(0.05);
		}

		common_scripts\utility::flag_clear("exo_push_player_attached");
		level.player common_scripts\utility::delaycall(0.25,::enableweapons);
		var_01 maps\_anim::anim_single_solo(var_07,"exo_push_detach","tag_driver");
		level.player unlink();
		var_0B = getgroundposition(level.player.origin,16)[2] - level.player.origin[2];
		if(var_0B > 1)
		{
			level.player setorigin(level.player.origin + (0,0,var_0B));
		}

		level.player maps\_shg_utility::setup_player_for_gameplay();
		var_07 hide();
	}

	common_scripts\utility::flag_set("vo_exo_push_entry_point");
	level.burke maps\_utility::set_ignoresuppression(0);
	level.burke maps\_utility::enable_pain();
	level.joker maps\_utility::set_ignoresuppression(0);
	level.joker maps\_utility::enable_pain();
	level.bones maps\_utility::set_ignoresuppression(0);
	level.bones maps\_utility::enable_pain();
	var_03 delete();
	var_07 delete();
}

//Function Number: 153
disable_me_when_exopush_finished()
{
	while(isdefined(self))
	{
		common_scripts\utility::flag_wait("exo_push_arrived");
		self makeunusable();
		return;
	}
}

//Function Number: 154
on_alert_chase_player()
{
	while(isalive(self))
	{
		level waittill("chase_the_player_now");
		iprintlnbold("Time to fight the player nowc");
		self setgoalpos(level.player.origin);
		return;
	}
}

//Function Number: 155
on_alert_notify_level()
{
	while(isalive(self))
	{
		common_scripts\utility::waittill_any("_stealth_spotted","damage","alert");
		level notify("chase_the_player_now");
		iprintlnbold("I am alert");
		return;
	}
}

//Function Number: 156
player_is_pushing_rumble()
{
	for(;;)
	{
		if(common_scripts\utility::flag("exo_push_arrived"))
		{
			return;
		}

		if(common_scripts\utility::flag("exo_push_should_push"))
		{
			var_00 = level.player maps\_utility::get_rumble_ent("steady_rumble");
			var_00 maps\_utility::set_rumble_intensity(0.24);
			while(common_scripts\utility::flag("exo_push_should_push"))
			{
				wait(0.05);
			}

			var_00 stoprumble("steady_rumble");
			var_00 delete();
		}

		wait(0.05);
	}
}

//Function Number: 157
exo_push_hospital_callout()
{
	common_scripts\utility::flag_wait("exo_push_arrived");
	common_scripts\utility::flag_set("vo_exo_push_entry_point");
}

//Function Number: 158
end_the_exopush_even_if_never_pushed()
{
	common_scripts\utility::flag_wait("exo_push_arrived");
	if(!common_scripts\utility::flag("van_pushed_atlaest_once"))
	{
		level.burke stopanimscripted();
	}
}

//Function Number: 159
ambulance_objective_update()
{
	common_scripts\utility::flag_wait("office_ambulance_reached");
	common_scripts\utility::flag_set("obj_rendezvous_joker_complete");
}

//Function Number: 160
ambulance_firstframe_function()
{
	if(level.currentgen && !issubstr(level.transient_zone,"middle"))
	{
		level waittill("tff_post_intro_to_middle");
	}

	var_00 = getent("exo_push_ambulance","targetname");
	var_01 = ["tag_rooflight_tkl","tag_rooflight_tkr","tag_rooflight_tl","tag_rooflight_tr","tag_siren_f","tag_roof"];
	var_02 = ["tag_rooflight_tkl_d","tag_rooflight_tkr_d","tag_rooflight_tl_d","tag_rooflight_tr_d","tag_siren_f_d","tag_roof_d"];
	foreach(var_04 in var_02)
	{
		var_00 hidepart(var_04);
	}

	var_06 = getent("exo_push_first_animorg","targetname");
	var_00.animname = "ambulance";
	var_00 maps\_utility::assign_animtree();
	var_00 setcandamage(1);
	for(var_07 = 0;var_07 < 4;var_07++)
	{
		var_00 thread ambulance_part_monitor(var_01[var_07],var_02[var_07],100);
	}

	var_00 thread ambulance_part_monitor(var_01[4],var_02[4],200);
	var_00 thread ambulance_part_monitor(var_01[5],var_02[5],500,1);
	var_00 thread ambulance_max_health();
	var_00.health = 10000;
	var_08 = getent("exo_brush_clip_nosight","targetname");
	var_08 linkto(var_00,"tag_driver");
	var_09 = getent("exo_push_team_goalorg_joker","targetname");
	var_0A = getent("exo_push_team_goalorg_bones","targetname");
	var_0B = getent("exo_push_team_goalorg_burke","targetname");
	var_00 thread exo_objective_use_prompt();
	var_0A linkto(var_00,"tag_origin");
	var_09 linkto(var_00,"tag_origin");
	var_0B linkto(var_00,"tag_origin");
	var_0C = getentarray("exopush_shooter_org_target","targetname");
	foreach(var_0E in var_0C)
	{
		var_0E linkto(var_00,"tag_origin");
	}

	var_06 thread maps\_anim::anim_first_frame_solo(var_00,"exo_push_burke_attach");
	common_scripts\utility::flag_set("ok_to_start_exo_push");
}

//Function Number: 161
exo_objective_use_prompt()
{
	common_scripts\utility::flag_wait("send_bones_joker_to_cover1");
	var_00 = getent("exo_push_player_trigger","targetname");
	var_01 = level.truck.origin;
	var_01 = var_01 + level.truck_org_cords;
	var_00.origin = var_01;
	var_02 = getent("exo_push_ambulance","targetname");
	var_03 = var_02.origin + level.truck_org_cords;
	var_04 = var_00 maps\_shg_utility::hint_button_position("use",var_03,undefined,200,undefined,var_00);
	var_04 thread close_me_when_exopush_over();
	maps\_shg_design_tools::waittill_trigger_with_name("exo_push_player_trigger");
	if(isdefined(var_04))
	{
		var_04 maps\_shg_utility::hint_button_clear();
	}
}

//Function Number: 162
close_me_when_exopush_over()
{
	while(isdefined(self))
	{
		common_scripts\utility::flag_wait("exo_push_arrived");
		if(isdefined(self))
		{
			maps\_shg_utility::hint_button_clear();
		}
	}
}

//Function Number: 163
ambulance_part_monitor(param_00,param_01,param_02,param_03)
{
	self endon("death");
	for(;;)
	{
		self waittill("damage",var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B);
		if(isdefined(param_03) && param_03)
		{
			if(damage_is_explosive(var_08))
			{
				ambulance_damage_part(param_00,param_01);
				return;
			}

			continue;
		}

		if(var_0B == param_00 || var_0B == param_01)
		{
			param_02 = param_02 - var_04;
		}

		if(param_02 <= 0)
		{
			ambulance_damage_part(param_00,param_01);
			return;
		}
	}
}

//Function Number: 164
ambulance_max_health()
{
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07);
		self.health = self.maxhealth;
	}
}

//Function Number: 165
damage_is_explosive(param_00)
{
	param_00 = tolower(param_00);
	switch(param_00)
	{
		case "splash":
		case "mod_explosive":
		case "mod_projectile_splash":
		case "mod_projectile":
		case "mod_grenade_splash":
		case "mod_grenade":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 166
ambulance_damage_part(param_00,param_01)
{
	self hidepart(param_00);
	self showpart(param_01);
}

//Function Number: 167
second_line_of_fire()
{
	common_scripts\utility::flag_wait("begin_spawning_troops_hospital");
	level endon("stop_spawning_second_line_guys");
	var_00 = "second_line_of_fire";
	level.secondguysalive = 0;
	level.secondguys_total = 9;
	for(var_01 = 0;var_01 < 2;var_01++)
	{
		wait(randomfloat(3));
		spawn_a_second_line_guy(var_00);
	}
}

//Function Number: 168
spawn_a_second_line_guy(param_00)
{
	level endon("stop_second_line_spawner");
	if(common_scripts\utility::flag("exo_push_arrived"))
	{
		return;
	}

	if(level.secondguys_total <= 0)
	{
		common_scripts\utility::flag_set("secondline_guys_killed");
		level notify("stop_second_line_spawner");
		return;
	}

	if(!common_scripts\utility::flag("send_bones_joker_to_cover1"))
	{
		var_01 = getent("exo_push_spawner_hospital","targetname");
		var_01.count = 1;
		var_02 = getent("exo_push_secondline_vol","targetname");
		wait(randomfloat(1.1));
		var_03 = var_01 maps\_utility::spawn_ai(1);
		if(isalive(var_03))
		{
			level.secondguysalive++;
			level.secondguys_total--;
			var_03.radius = 15;
			var_03 thread accuracy_fake_function();
			var_03.grenadeammo = 0;
			var_03.meleeattackdist = 0;
			var_03 setgoalvolumeauto(var_02);
			var_03 thread secondline_alive_check(param_00);
			var_03 thread seekplayercheck();
			var_03 thread secondline_flee_check();
			var_03 maps\detroit_lighting::add_enemy_flashlight("flashlight",undefined,undefined,25);
			var_03 thread kill_me_on_flag("exo_push_phase1_complete");
		}
	}

	if(common_scripts\utility::flag("send_bones_joker_to_cover1"))
	{
		var_01 = getent("exo_push_spawner_hospital","targetname");
		var_01.count = 1;
		var_02 = getent("secondline_last_volume","targetname");
		wait(randomfloat(1.1));
		var_03 = var_01 maps\_utility::spawn_ai(1);
		if(isalive(var_03))
		{
			level.secondguysalive++;
			level.secondguys_total--;
			var_03.radius = 15;
			var_03 thread accuracy_fake_function();
			var_03.grenadeammo = 0;
			var_03.meleeattackdist = 0;
			var_03 setgoalvolumeauto(var_02);
			var_03 thread secondline_alive_check(param_00);
			var_03 thread seekplayercheck();
			var_03 thread secondline_flee_check();
			var_03 maps\detroit_lighting::add_enemy_flashlight("flashlight",undefined,undefined,25);
			var_03 thread kill_me_on_flag("exo_push_phase1_complete");
		}
	}
}

//Function Number: 169
kill_me_on_flag(param_00)
{
	self endon("death");
	common_scripts\utility::flag_wait(param_00);
	wait(randomfloatrange(0.3,0.8));
	if(isalive(self))
	{
		maps\detroit::bloody_death();
	}
}

//Function Number: 170
truck_distance_to_end()
{
	var_00 = getnode("joker_hospital","targetname");
	var_01 = 1;
	var_02 = 1;
	while(var_01 == 1)
	{
		var_03 = distance2d(self.origin,var_00.origin);
		if(var_03 < 900)
		{
			common_scripts\utility::flag_set("send_exopush_secondline_into_hospital");
			var_01 = 0;
		}

		wait(1);
	}

	while(var_02 == 1)
	{
		var_03 = distance2d(self.origin,var_00.origin);
		if(var_03 < 600)
		{
			common_scripts\utility::flag_set("send_exopush_guys_into_hospital");
			var_02 = 0;
			return;
		}

		wait(1);
	}
}

//Function Number: 171
seekplayercheck()
{
	wait(randomfloatrange(12,18));
	if(isalive(self))
	{
		var_00 = randomint(3);
		if(var_00 > 1)
		{
			maps\_utility::player_seek();
		}
	}
}

//Function Number: 172
secondline_alive_check(param_00)
{
	level endon("stop_spawning_second_line_guys");
	self waittill("death");
	level.secondguysalive--;
	if(!common_scripts\utility::flag("exo_push_phase2_complete"))
	{
		wait(randomfloat(4));
		if(!common_scripts\utility::flag("exo_push_phase2_complete"))
		{
			thread spawn_a_second_line_guy(param_00);
		}
	}
}

//Function Number: 173
back_line_of_fire()
{
	common_scripts\utility::flag_wait("begin_spawning_troops_hospital");
	level endon("stop_spawning_backline_guys");
	var_00 = "back_line_of_fire";
	level.backlineguysalive = 0;
	level.backlineguys_total = 11;
	for(var_01 = 0;var_01 < 5;var_01++)
	{
		spawn_a_backline_guy(var_00);
	}
}

//Function Number: 174
spawn_a_backline_guy(param_00)
{
	if(!common_scripts\utility::flag("exo_push_arrived"))
	{
		var_01 = getent("exo_push_spawner_hospital","targetname");
		var_01.count = 1;
		var_02 = getent("back_lineoffire_vol","targetname");
		wait(randomfloat(1.1));
		var_03 = var_01 maps\_utility::spawn_ai(1);
		if(level.backlineguys_total <= 0)
		{
			common_scripts\utility::flag_set("backline_guys_alldead");
			return;
		}

		if(isalive(var_03))
		{
			level.backlineguysalive++;
			level.backlineguys_total--;
			var_03.grenadeammo = 0;
			var_03.meleeattackdist = 0;
			var_03 thread accuracy_fake_function();
			var_03.radius = 15;
			var_03 setgoalvolumeauto(var_02);
			var_03 maps\detroit_lighting::add_enemy_flashlight("flashlight",undefined,undefined,25);
			var_03 thread backline_alive_check(param_00);
			var_03 thread backline_flee_check();
		}
	}
}

//Function Number: 175
stage1_ambush()
{
	var_00 = getent("exo_push_spawner_hospital_ambush_ar","targetname");
	common_scripts\utility::flag_wait("exo_push_phase1_complete");
	for(var_01 = 0;var_01 < 1;var_01++)
	{
		var_00.count = 1;
		var_02 = var_00 maps\_utility::spawn_ai(1);
		if(isalive(var_02))
		{
			var_02.grenadeammo = 0;
			var_02.meleeattackdist = 0;
			var_02 thread accuracy_fake_function();
			var_02 thread maps\_utility::player_seek();
			var_02 maps\detroit_lighting::add_enemy_flashlight("flashlight",undefined,undefined,25);
			wait(randomfloatrange(0.5,2));
		}
	}
}

//Function Number: 176
stage2_ambush()
{
	var_00 = getent("exo_push_spawner_hospital_alcove","targetname");
	common_scripts\utility::flag_wait("exo_push_phase2_complete");
	for(var_01 = 0;var_01 < 2;var_01++)
	{
		var_00.count = 1;
		var_02 = var_00 maps\_utility::spawn_ai(1);
		var_02 thread maps\_utility::player_seek();
		var_02 thread accuracy_fake_function();
		var_02 maps\detroit_lighting::add_enemy_flashlight("flashlight",undefined,undefined,25);
		wait(randomfloatrange(0.5,2));
	}
}

//Function Number: 177
backline_flee_check()
{
	self endon("death");
	var_00 = getent("hospital_fight_goal1","targetname");
	common_scripts\utility::flag_wait_any("exo_push_arrived","send_exopush_guys_into_hospital");
	if(isalive(self))
	{
		self setgoalvolumeauto(var_00);
		thread exopush_end_flee();
		self waittill("goal");
	}

	if(isdefined(self))
	{
		maps\detroit::bloody_death(randomint(2));
	}
}

//Function Number: 178
secondline_flee_check()
{
	self endon("death");
	var_00 = getent("hospital_fight_goal1","targetname");
	for(;;)
	{
		if(common_scripts\utility::flag("send_exopush_secondline_into_hospital"))
		{
			if(isdefined(self))
			{
				var_01 = randomint(3);
				self cleargoalvolume();
				self setgoalvolumeauto(var_00);
				self.ignoreall = 1;
				thread player_close_disable_ignore_check();
				thread exopush_end_flee();
				self waittill("goal");
				if(isdefined(self))
				{
					maps\detroit::bloody_death(var_01);
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 179
player_close_disable_ignore_check()
{
	while(isalive(self))
	{
		if(distance(level.player.origin,self.origin) < 400)
		{
			self.ignoreall = 0;
			return;
		}

		wait(0.05);
	}
}

//Function Number: 180
exopush_end_fight()
{
	wait(randomfloat(2));
	var_00 = randomint(3);
	if(isdefined(self))
	{
		maps\detroit::bloody_death(var_00);
	}
}

//Function Number: 181
exopush_end_flee()
{
	wait(randomfloat(2));
	if(isdefined(self))
	{
		thread player_close_disable_ignore_check();
		self.ignoreall = 1;
	}
}

//Function Number: 182
backline_alive_check(param_00)
{
	self waittill("death");
	level.backlineguysalive--;
	if(!common_scripts\utility::flag("exo_push_phase2_complete"))
	{
		wait(randomfloat(4));
		if(!common_scripts\utility::flag("exo_push_phase2_complete"))
		{
			thread spawn_a_backline_guy(param_00);
		}
	}
}

//Function Number: 183
spawn_preplaced_guys()
{
	thread spawn_hospital_roof_guys();
	thread spawn_back_left_scaffold_guys();
}

//Function Number: 184
spawn_hospital_roof_guys()
{
	level.hospitalroofguys = 0;
	var_00 = getentarray("exo_push_spawner_roof","targetname");
	var_01 = getent("roof_1_vol","targetname");
	var_02 = getent("roof_2_vol","targetname");
	foreach(var_04 in var_00)
	{
		var_04.count = 1;
		var_05 = var_04 maps\_utility::spawn_ai(1);
		if(isalive(var_05))
		{
			var_05.radius = 15;
			var_05 thread accuracy_fake_function();
			var_05.grenadeammo = 0;
			var_05.meleeattackdist = 0;
			level.hospitalroofguys++;
			var_05 setgoalvolumeauto(var_01);
			var_05 maps\detroit_lighting::add_enemy_flashlight("flashlight",undefined,undefined,25);
			wait(randomint(4));
		}
	}
}

//Function Number: 185
spawn_back_left_scaffold_guys()
{
	var_00 = getentarray("exo_push_inplace_spawner_scaffold_left_back","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = var_02 maps\_utility::spawn_ai(1);
		if(isalive(var_03))
		{
			var_03.radius = 15;
			var_03 maps\detroit_lighting::add_enemy_flashlight("flashlight",undefined,undefined,25);
			var_03.grenadeammo = 0;
			var_03.meleeattackdist = 0;
			var_03 thread accuracy_fake_function();
		}
	}
}

//Function Number: 186
accuracy_fake_function()
{
	self endon("death");
	var_00 = self.accuracy;
	for(;;)
	{
		if(common_scripts\utility::flag("exo_push_should_push"))
		{
			if(self.accuracy <= 0.5)
			{
				break;
			}

			var_01 = var_00 - randomfloatrange(0.1,0.3);
			if(var_01 <= 0)
			{
				var_01 = 0.1;
			}

			self.accuracy = var_01;
		}
		else if(common_scripts\utility::flag("exo_push_should_idle"))
		{
			self.accuracy = var_00;
		}

		if(distance2d(self.origin,level.player.origin) > 400)
		{
			self.accuracy = 0.02;
		}

		if(distance2d(self.origin,level.player.origin) < 400)
		{
			self.accuracy = 0.6;
		}

		wait(0.05);
	}
}

//Function Number: 187
exo_push_think_joker(param_00,param_01)
{
	var_02 = getnode("joker_cover_exo_wait spot","targetname");
	level.joker setgoalnode(var_02);
	common_scripts\utility::flag_wait("exo_push_has_been_started");
	level.joker thread maps\_utility::set_grenadeammo(0);
	var_03 = getent("exo_push_team_goalorg_joker","targetname");
	level.joker.goalradius = 5;
	level.joker setgoalpos(var_03.origin);
	for(;;)
	{
		if(common_scripts\utility::flag("exo_push_phase1_complete"))
		{
			return;
		}

		if(distance2d(level.joker.origin,var_03.origin) > 30)
		{
			level.joker setgoalpos(var_03.origin);
			level.joker.ignoreme = 1;
		}

		wait(1);
	}
}

//Function Number: 188
stop_animating_when_exopush_over()
{
	common_scripts\utility::flag_wait("exo_push_arrived");
	level notify("stop_vo_for_exo_push");
	self notify("exo_push_burke_wait_ender");
}

//Function Number: 189
burke_exo_push_wait()
{
	thread maps\_anim::anim_loop_solo(level.burke,"exo_push_burke_wait","exo_push_burke_wait_ender","tag_walker3");
	common_scripts\utility::flag_wait("exo_push_arrived");
	self notify("exo_push_burke_wait_ender");
}

//Function Number: 190
exo_push_think_burke(param_00,param_01,param_02)
{
	level endon("stop_vo_for_exo_push");
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_03 = getent("exo_push_team_goalorg_burke","targetname");
	thread move_team_towards_hospital();
	thread exo_push_over_default_values();
	thread burke_exo_push_end_early(param_00);
	var_03 thread stop_animating_when_exopush_over();
	common_scripts\utility::flag_set("kill_the_two_guys_by_ambulance");
	if(param_02 == 0)
	{
		param_01 maps\_anim::anim_reach_solo(level.burke,"exo_push_burke_attach");
	}

	common_scripts\utility::flag_set("exo_push_burke_attaching");
	thread set_flag_on_burke_wave_to_ambulance();
	param_01 maps\_anim::anim_single_solo(level.burke,"exo_push_burke_attach");
	level.burke linkto(param_00,"tag_walker3");
	param_00 thread burke_exo_push_wait();
	common_scripts\utility::flag_wait("exo_push_player_attached");
	level.burke thread maps\_utility::set_grenadeammo(0);
	param_00 notify("exo_push_burke_wait_ender");
	for(;;)
	{
		common_scripts\utility::flag_wait_any("exo_push_should_push","exo_push_should_idle","exo_push_arrived");
		if(common_scripts\utility::flag("exo_push_arrived"))
		{
			break;
		}

		level.burke linkto(param_00,"tag_walker3");
		for(;;)
		{
			if(common_scripts\utility::flag("exo_push_should_push"))
			{
				level.joker allowedstances("crouch","stand","prone");
				level.bones allowedstances("crouch","stand","prone");
				param_00 thread maps\_anim::anim_loop_solo(level.burke,"exo_push_loop","burke_ender","tag_walker3");
				common_scripts\utility::flag_waitopen("exo_push_should_push");
				param_00 notify("burke_ender");
				continue;
			}

			if(common_scripts\utility::flag("exo_push_should_idle"))
			{
				param_00 thread maps\_anim::anim_loop_solo(level.burke,"exo_push_idle","burke_ender","tag_walker3");
				common_scripts\utility::flag_waitopen("exo_push_should_idle");
				param_00 notify("burke_ender");
				continue;
			}

			level.burke.goalradius = 40;
			level.burke setgoalpos(var_03.origin);
			level.bones.ignoreme = 0;
			level.joker.ignoreme = 0;
			level.joker allowedstances("crouch");
			level.bones allowedstances("crouch");
			break;
		}

		level.burke unlink();
		level.burke stopanimscripted();
	}

	var_04 = getent("burke_grenade_location","targetname");
}

//Function Number: 191
burke_exo_push_end_early(param_00)
{
	common_scripts\utility::flag_wait("exo_push_arrived");
	level.burke unlink();
	level.burke stopanimscripted();
	param_00 notify("burke_ender");
}

//Function Number: 192
exo_push_over_default_values()
{
	common_scripts\utility::flag_wait("exo_push_arrived");
	level.joker allowedstances("crouch","stand","prone");
	level.bones allowedstances("crouch","stand","prone");
}

//Function Number: 193
set_flag_on_burke_wave_to_ambulance()
{
	wait(6.4);
	common_scripts\utility::flag_set("send_bones_joker_to_cover1");
}

//Function Number: 194
exo_push_think_bones(param_00,param_01)
{
	common_scripts\utility::flag_wait("exo_push_has_been_started");
	thread maps\_utility::set_grenadeammo(0);
	var_02 = getent("exo_push_team_goalorg_bones","targetname");
	var_03 = getent("exo_push_team_goalorg_joker","targetname");
	level.bones.goalradius = 5;
	for(;;)
	{
		if(common_scripts\utility::flag("exo_push_phase1_complete"))
		{
			return;
		}

		wait(1);
		level.bones setgoalpos(var_02.origin);
		level.bones.ignoreme = 1;
	}
}

//Function Number: 195
exo_push_think_player_attached(param_00,param_01)
{
	for(;;)
	{
		if(common_scripts\utility::flag("exo_push_should_push"))
		{
			param_00 clearanim(param_00 maps\_utility::getanim("exo_push_idle")[0],0.2);
			param_00 setanimrestart(param_00 maps\_utility::getanim("exo_push_idle_to_loop"));
			param_00 maps\_anim::anim_single_solo(param_01,"exo_push_idle_to_loop","tag_driver");
			param_00 clearanim(param_00 maps\_utility::getanim("exo_push_idle_to_loop"),0.2);
			param_00 setanimrestart(param_00 maps\_utility::getanim("exo_push_loop")[0]);
			param_00 thread maps\_anim::anim_loop_solo(param_01,"exo_push_loop","player_ender","tag_driver");
			common_scripts\utility::flag_waitopen("exo_push_should_push");
			param_00 notify("player_ender");
			param_00 clearanim(param_00 maps\_utility::getanim("exo_push_loop")[0],0.2);
			param_00 setanimrestart(param_00 maps\_utility::getanim("exo_push_loop_to_idle"));
			if(isdefined(param_01))
			{
				param_00 maps\_anim::anim_single_solo(param_01,"exo_push_loop_to_idle","tag_driver");
			}

			param_00 clearanim(param_00 maps\_utility::getanim("exo_push_loop_to_idle"),0.2);
			param_00 setanimrestart(param_00 maps\_utility::getanim("exo_push_idle")[0]);
			continue;
		}

		if(common_scripts\utility::flag("exo_push_should_idle"))
		{
			param_00 thread maps\_anim::anim_loop_solo(param_01,"exo_push_idle","player_ender","tag_driver");
			common_scripts\utility::flag_waitopen("exo_push_should_idle");
			param_00 notify("player_ender");
			continue;
		}

		break;
	}
}

//Function Number: 196
end_ambulance_anim_early()
{
	common_scripts\utility::flag_wait("exo_push_arrived");
	level notify("stop_moving_ambulance_now");
	wait(0.3);
	level.truck stopanimscripted();
}

//Function Number: 197
exo_push_think_truck(param_00,param_01)
{
	level endon("stop_moving_ambulance_now");
	param_00.animname = "ambulance";
	param_00 maps\_utility::assign_animtree();
	var_02 = getent("exo_brush_clip_nosight","targetname");
	param_00 thread exopush_stage_manager();
	common_scripts\utility::flag_wait("exo_push_burke_attaching");
	param_01 maps\_anim::anim_single_solo(param_00,"exo_push_burke_attach");
	param_00 thread exo_push_play_truck_idle_at_end_of_frame();
	param_00 thread exo_push_truck_handle_speed(param_00,param_01);
	param_00 thread exo_push_truck_handle_path_disconnect(var_02);
	param_01 maps\_anim::anim_single_solo(param_00,"exo_push_path");
	common_scripts\utility::flag_set("exo_push_arrived");
	common_scripts\utility::flag_set("team_move_hospital");
	level notify("stop_second_line_spawner");
}

//Function Number: 198
exo_push_play_truck_idle_at_end_of_frame()
{
	waittillframeend;
	self setanimrestart(maps\_utility::getanim("exo_push_idle")[0]);
}

//Function Number: 199
exo_push_truck_handle_speed(param_00,param_01)
{
	var_02 = getanimlength(level.scr_anim["world_body"]["exo_push_idle_to_loop"]);
	var_03 = getanimlength(level.scr_anim["world_body"]["exo_push_loop_to_idle"]);
	var_04 = 0;
	var_05 = 0;
	var_06 = 0;
	while(!common_scripts\utility::flag("exo_push_arrived"))
	{
		if(common_scripts\utility::flag("exo_push_should_push"))
		{
			var_04 = 0;
			var_05 = var_05 + 0.05;
		}
		else
		{
			var_04 = var_04 + 0.05;
			var_05 = 0;
		}

		if(var_05 > var_02)
		{
			var_06 = 1;
		}
		else if(var_04 > var_03)
		{
			var_06 = 0;
		}

		param_01 maps\_anim::anim_set_rate([param_00],"exo_push_path",var_06);
		wait(0.05);
	}

	maps\_utility::autosave_by_name("Hospital start");
}

//Function Number: 200
exo_push_truck_handle_path_disconnect(param_00)
{
	var_01 = (0,0,0);
	while(!common_scripts\utility::flag("exo_push_arrived"))
	{
		if(distancesquared(self.origin,var_01) > 1024)
		{
			param_00 connectpaths();
			badplace_delete("ambulance_badplace");
			param_00 disconnectpaths();
			if(common_scripts\utility::flag("exo_push_player_attached"))
			{
				badplace_cylinder("ambulance_badplace",0,self.origin,150,100,"axis","allies");
			}
		}

		wait 0.05;
	}

	badplace_delete("ambulance_badplace");
}

//Function Number: 201
move_team_towards_hospital()
{
	common_scripts\utility::flag_wait("exo_push_arrived");
	var_00 = getnode("burke_hospital_hide_outside","targetname");
	var_01 = getnode("bones_hospital","targetname");
	var_02 = getnode("joker_hospital","targetname");
	level.burke setgoalnode(var_00);
	level.bones setgoalnode(var_01);
	level.joker setgoalnode(var_02);
	maps\_utility::activate_trigger_with_targetname("team_move_hospital");
}

//Function Number: 202
begin_spawnning_exo_spawners()
{
	common_scripts\utility::flag_wait("exo_push_player_attached");
	level.burke.ignoreall = 0;
	var_00 = getentarray("exo_push_spawner","targetname");
	foreach(var_02 in var_00)
	{
		var_03 = var_02 maps\_utility::spawn_ai(1);
		var_03 thread accuracy_fake_function();
		var_03 maps\detroit_lighting::add_enemy_flashlight("flashlight",undefined,undefined,25);
		var_03.accuracy = 0;
		var_04 = randomfloatrange(0.3,0.8);
		wait(var_04);
	}
}

//Function Number: 203
shoot_at_sentinel_agents()
{
	var_00 = getent("sentinel_rocket_start_org","targetname");
	var_01 = getent("sentinel_rocket_end_org","targetname");
	common_scripts\utility::flag_wait("begin_kva_assault_on_sentinel");
	var_02 = getentarray("sentinel_shoot_window_1_org","targetname");
	var_03 = getentarray("sentinel_shoot_window_2_org","targetname");
	var_04 = getentarray("sentinel_shoot_window_3_org","targetname");
	var_05 = [var_02,var_03,var_04];
	var_06 = getentarray("sentinel_bullet_start_org","targetname");
	foreach(var_08 in var_06)
	{
		var_08 thread shoot_at_spots(var_05);
		wait(randomfloatrange(0.3,1.2));
	}
}

//Function Number: 204
shoot_at_spots(param_00)
{
	level endon("cleanup_sentinel_guys");
	var_01 = randomint(4);
	for(;;)
	{
		var_02 = randomfloatrange(-10,10);
		var_03 = randomfloatrange(-10,10);
		var_04 = randomfloatrange(-10,10);
		var_05 = (var_02,var_03,var_04);
		var_06 = "";
		var_07 = undefined;
		var_08 = 0;
		var_09 = param_00[randomintrange(0,param_00.size)];
		var_0A = randomintrange(1,8);
		var_0B = randomfloatrange(0.25,1.15);
		switch(var_01)
		{
			case 0:
				var_06 = "iw5_arx160_sp";
				var_07 = 0.1;
				break;
	
			case 1:
				var_06 = "iw5_mp11_sp";
				var_07 = 0.05;
				break;
	
			case 2:
				var_06 = "iw5_arx160_sp";
				var_07 = randomfloatrange(0.1,0.5);
				break;
	
			case 3:
				var_06 = "iw5_mp11_sp";
				var_07 = randomfloatrange(0.05,0.2);
				break;
	
			default:
				break;
		}

		fire_loop_at_target_with_delay(var_06,var_0A,var_08,var_05,var_09,var_07,var_0B);
	}
}

//Function Number: 205
fire_loop_at_target_with_delay(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	while(param_01 > param_02)
	{
		param_04 = param_04 if_array_choose_random_target();
		var_07 = magicbullet(param_00,self.origin,param_04.origin + param_03);
		param_02++;
		wait(param_05);
	}

	wait(param_06);
}

//Function Number: 206
if_array_choose_random_target()
{
	if(isdefined(self) && isarray(self))
	{
		var_00 = self[randomintrange(0,self.size)];
		return var_00;
	}

	return self;
}