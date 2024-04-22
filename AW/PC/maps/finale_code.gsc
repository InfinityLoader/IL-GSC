/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: finale_code.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 139
 * Decompile Time: 2088 ms
 * Timestamp: 4/22/2024 2:29:09 AM
*******************************************************************/

//Function Number: 1
finale_intro_screen()
{
	level.intro_offset = -1;
	soundscripts\_snd::snd_message("start_intro");
	var_00 = 8;
	setsaveddvar("cg_cinematicfullscreen","1");
	level.player disableweapons();
	level.player freezecontrols(1);
	level.player takeallweapons();
	thread maps\_shg_utility::play_chyron_video("chyron_text_finale",14,2);
	common_scripts\utility::flag_wait("chyron_video_done");
	common_scripts\utility::flag_set("flag_chyron_finale_complete");
	common_scripts\utility::flag_wait("flag_dialogue_intro_black_complete");
	level.player maps\finale_utility::mech_enable(undefined,1);
	level.player enableweapons();
	common_scripts\utility::flag_set("flag_intro_screen_complete");
	common_scripts\utility::flag_set("flag_canal_combat_start");
}

//Function Number: 2
spawn_function()
{
	maps\_utility::array_spawn_function_noteworthy("enemy_flyin_01",::ai_canal_combat_01_accuracy_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_flyin_bridge_01",::ai_canal_combat_02_accuracy_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_flyin_bridge_02",::ai_canal_combat_03_accuracy_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_flyin_04",::ai_canal_combat_04_accuracy_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_flyin_05",::ai_canal_combat_05_accuracy_think);
	maps\_utility::array_spawn_function_noteworthy("ai_silo_entrance",::ai_silo_think);
	maps\_utility::array_spawn_function_noteworthy("ai_silo_floor_01",::ai_silo_think);
	maps\_utility::array_spawn_function_noteworthy("ai_silo_floor_01_balcony",::ai_silo_floor_01_balcony);
	maps\_utility::array_spawn_function_noteworthy("ai_silo_floor_01_wave_2",::ai_silo_floor_01_wave_2_think);
	maps\_utility::array_spawn_function_noteworthy("ai_silo_floor_02",::ai_silo_floor_01_wave_3_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_boost_silo_01",::maps\finale_utility::follow_volume_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_boost_silo_01_b",::maps\finale_utility::follow_volume_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_boost_silo_01_flood",::maps\finale_utility::follow_volume_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_boost_silo_02",::maps\finale_utility::follow_volume_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_boost_silo_03",::maps\finale_utility::follow_volume_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_boost_silo_03_flood",::maps\finale_utility::follow_volume_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_lobby",::ai_lobby_think);
	maps\_utility::array_spawn_function_noteworthy("rpg_vehicle",::maps\finale_utility::postspawn_rpg_vehicle);
	maps\_utility::array_spawn_function_noteworthy("mech_silo",::mech_behavior_init);
	maps\_utility::array_spawn_function_noteworthy("boat_canal",::boat_death_think);
	maps\_utility::add_global_spawn_function("axis",::tweak_enemy_hp);
	createthreatbiasgroup("enemy_canal");
	createthreatbiasgroup("enemy_silo");
	createthreatbiasgroup("player");
}

//Function Number: 3
setup_combat()
{
	spawn_function();
	level.player thread threat_bias_canal_think();
	level.player thread threat_bias_silo_think();
	thread canal_chase_boats();
	thread combat_canal_01();
	thread combat_flyin_bridge();
	thread combat_silo();
	thread combat_silo_mech();
	thread combat_silo_boost();
}

//Function Number: 4
setup_se()
{
	thread intro_flyin();
}

//Function Number: 5
tweak_enemy_hp()
{
	if(issubstr(self.classname,"elite"))
	{
		self.health = 650;
	}

	if(issubstr(self.classname,"mech"))
	{
		self.health = 7000;
	}
}

//Function Number: 6
player_mech_melee_modifier()
{
	if(issubstr(self.classname,"mech"))
	{
		return;
	}

	maps\_utility::add_damage_function(::player_mech_melee_modifier_damage_function);
}

//Function Number: 7
player_mech_melee_modifier_damage_function(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if((param_04 == "MOD_MELEE" || param_04 == "MOD_MELEE_ALT") && isplayer(param_01))
	{
		self dodamage(self.health + 1000,param_01 geteye(),param_01,param_01,"MOD_MELEE_ALT");
	}
}

//Function Number: 8
ai_silo_think()
{
	self endon("death");
	self cleargoalvolume();
	self setgoalvolumeauto(getent("info_v_silo_entrance","targetname"));
	common_scripts\utility::flag_wait("flag_combat_silo_entrance_retreat");
	self cleargoalvolume();
	self setgoalvolumeauto(getent("info_v_silo_room_01","targetname"));
	common_scripts\utility::flag_wait("flag_combat_silo_floor_01_ware_02");
	self cleargoalvolume();
	self setgoalvolumeauto(getent("info_v_silo_room_01_wave_2","targetname"));
	common_scripts\utility::flag_wait("flag_combat_silo");
	self cleargoalvolume();
	self setgoalvolumeauto(getent("info_v_silo_room_01","targetname"));
	maps\finale_utility::spawn_metrics_waittill_count_reaches(2,["ai_silo_floor_01"],1);
	common_scripts\utility::flag_set("flag_ai_silo_floor_01_end");
	common_scripts\utility::flag_set("flag_combat_silo_floor_02");
	self cleargoalvolume();
	maps\_utility::player_seek();
}

//Function Number: 9
ai_silo_floor_01_balcony()
{
	self endon("death");
	self cleargoalvolume();
	self setgoalvolumeauto(getent("info_v_silo_room_01_balcony","targetname"));
	maps\finale_utility::spawn_metrics_waittill_count_reaches(6,["ai_silo_floor_01_wave_2","ai_silo_floor_01","ai_silo_floor_01_balcony"],1);
	self cleargoalvolume();
	self setgoalvolumeauto(getent("info_v_silo_room_02","targetname"));
	common_scripts\utility::flag_wait("flag_combat_silo_floor_02_retreat");
	self cleargoalvolume();
	self setgoalvolumeauto(getent("info_v_silo_room_02_retreat","targetname"));
}

//Function Number: 10
ai_silo_floor_01_wave_2_think()
{
	self endon("death");
	self cleargoalvolume();
	self setgoalvolumeauto(getent("info_v_silo_room_01_wave_2","targetname"));
	maps\finale_utility::spawn_metrics_waittill_count_reaches(2,["ai_silo_floor_01_wave_2","ai_silo_floor_01"],1);
	common_scripts\utility::flag_set("flag_ai_silo_floor_01_end");
	self cleargoalvolume();
	self setgoalvolumeauto(getent("info_v_silo_room_02","targetname"));
	common_scripts\utility::flag_wait("flag_combat_silo_floor_02_retreat");
	self cleargoalvolume();
	self setgoalvolumeauto(getent("info_v_silo_room_02_retreat","targetname"));
}

//Function Number: 11
ai_silo_floor_01_wave_3_think()
{
	self endon("death");
	self cleargoalvolume();
	self setgoalvolumeauto(getent("info_v_silo_room_02","targetname"));
	common_scripts\utility::flag_wait("flag_combat_silo_floor_02_retreat");
	self cleargoalvolume();
	self setgoalvolumeauto(getent("info_v_silo_room_02_retreat","targetname"));
}

//Function Number: 12
ai_lobby_think()
{
	self endon("death");
	maps\_utility::set_baseaccuracy(0.01);
	common_scripts\utility::flag_wait("flag_lobby_player_can_shoot");
	wait(1);
	self.health = 40;
	maps\_utility::disable_long_death();
	maps\_utility::set_baseaccuracy(0.5);
	maps\finale_utility::disable_grenades();
	common_scripts\utility::flag_wait("flag_lobby_seek_player");
	self cleargoalvolume();
	maps\_utility::player_seek();
}

//Function Number: 13
mech_behavior_init()
{
	self endon("death");
	if(!isdefined(self))
	{
		return;
	}

	self.paindamagestart = 300;
	self.paindamagemin = 150;
	thread badplace_on_entity(195,100,"allies");
	maps\_utility::ent_flag_init("mech_should_attack_player");
	for(;;)
	{
		var_00 = mech_get_closest_node();
		if(isdefined(var_00))
		{
			var_00.mech_using_this_node = self;
			maps\_mech::mech_set_goal_node(var_00);
		}

		maps\_utility::ent_flag_wait("mech_should_attack_player");
		thread maps\_mech::mech_rocket_launcher_behavior();
		maps\_utility::ent_flag_waitopen("mech_should_attack_player");
		maps\_mech::mech_stop_rockets();
	}
}

//Function Number: 14
badplace_on_entity(param_00,param_01,param_02)
{
	self endon("death");
	var_03 = 0.5;
	for(;;)
	{
		badplace_cylinder("",var_03,self.origin,param_00,param_01,param_02);
		wait(var_03);
	}
}

//Function Number: 15
mech_get_closest_node()
{
	var_00 = getnodearray("node_mech","script_noteworthy");
	var_01 = undefined;
	var_02 = undefined;
	foreach(var_04 in var_00)
	{
		if(isalive(var_04.mech_using_this_node))
		{
			continue;
		}

		var_05 = distancesquared(self.origin,var_04.origin);
		if(!isdefined(var_01) || var_05 < var_02)
		{
			var_01 = var_04;
			var_02 = var_05;
		}
	}

	return var_01;
}

//Function Number: 16
combat_silo()
{
	common_scripts\utility::flag_wait("flag_combat_silo_entrance");
	thread maps\_utility::autosave_now();
	level.player thread maps\finale_utility::mech_glass_damage_think("flag_obj_escape");
	level.gideon thread maps\finale_utility::mech_glass_damage_think("flag_obj_escape");
	level.gideon maps\_mech::mech_start_rockets(512,undefined,undefined,undefined,83.33334,undefined,undefined);
	soundscripts\_snd::snd_message("start_silo_approach");
	var_00 = getentarray("ai_silo_entrance","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::spawn_ai(1);
	}

	common_scripts\utility::flag_wait("flag_combat_silo");
	var_00 = getentarray("ai_silo_floor_01","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::spawn_ai(1);
	}

	common_scripts\utility::flag_wait("flag_combat_silo_floor_01_ware_02");
	var_00 = getentarray("ai_silo_floor_01_balcony","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::spawn_ai(1);
	}

	var_00 = getentarray("ai_silo_floor_01_wave_2","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::spawn_ai(1);
	}

	common_scripts\utility::flag_wait("flag_combat_silo_floor_02");
	var_00 = getentarray("ai_silo_floor_02","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::spawn_ai(1);
	}

	common_scripts\utility::flag_wait("flag_combat_silo_floor_02_retreat");
	var_00 = getentarray("ai_silo_floor_02_wave_02","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::spawn_ai(1);
	}
}

//Function Number: 17
combat_silo_mech()
{
	common_scripts\utility::flag_wait_all("flag_silo_watwalks_open","flag_lower_missile_loader");
	wait(6);
	var_00 = getentarray("mech_silo","script_noteworthy");
	thread control_mech_attacks();
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::spawn_ai(1);
	}

	thread maps\finale_utility::combat_silo_seeker_ai();
}

//Function Number: 18
control_mech_attacks()
{
	var_00 = 1;
	level.player.mechs_attacking_me = [];
	for(;;)
	{
		wait(5);
		var_01 = [];
		foreach(var_03 in getentarray("mech_silo","script_noteworthy"))
		{
			if(!var_03 maps\_utility::ent_flag_exist("mech_should_attack_player"))
			{
				continue;
			}

			if(!isdefined(var_03.enemy) || var_03.enemy != level.player)
			{
				continue;
			}

			var_01[var_01.size] = var_03;
			var_03 maps\_utility::ent_flag_clear("mech_should_attack_player");
		}

		var_01 = sortbydistance(var_01,level.player.origin);
		for(var_05 = 0;var_05 < var_01.size && var_05 < var_00;var_05++)
		{
			var_01[var_05] maps\_utility::ent_flag_set("mech_should_attack_player");
		}
	}
}

//Function Number: 19
combat_silo_boost()
{
	common_scripts\utility::flag_wait("flag_missile_move_start");
	var_00 = getentarray("enemy_boost_silo_01","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::spawn_ai(1);
	}

	common_scripts\utility::flag_wait("flag_silo_combat_01_b");
	var_00 = getentarray("enemy_boost_silo_01_b","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::spawn_ai(1);
	}

	var_00 = getentarray("enemy_boost_silo_01_flood","script_noteworthy");
	if(var_00.size > 0)
	{
		maps\_spawner::flood_spawner_scripted(var_00);
	}

	common_scripts\utility::flag_wait_any("flag_silo_combat_02","flag_kill_spawners_silo_01");
	maps\finale_utility::delete_spawners("enemy_boost_silo_01_flood");
	common_scripts\utility::flag_wait("flag_silo_combat_02");
	var_00 = getentarray("enemy_boost_silo_02","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::spawn_ai(1);
	}

	common_scripts\utility::flag_wait("flag_silo_combat_03");
	var_00 = getentarray("enemy_boost_silo_03","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::spawn_ai(1);
	}

	var_00 = getentarray("enemy_boost_silo_03_flood","script_noteworthy");
	if(var_00.size > 0)
	{
		maps\_spawner::flood_spawner_scripted(var_00);
	}

	common_scripts\utility::flag_wait("flag_silo_combat_stop");
	thread combat_silo_complete();
	maps\finale_utility::delete_spawners("enemy_boost_silo_03_flood");
}

//Function Number: 20
combat_silo_complete()
{
	var_00 = ["mech_silo","enemy_boost_silo_01","enemy_boost_silo_01_b","enemy_boost_silo_01_flood","enemy_boost_silo_02","enemy_boost_silo_03","enemy_boost_silo_03_flood"];
	maps\finale_utility::spawn_metrics_waittill_count_reaches(0,[var_00],1);
	common_scripts\utility::flag_set("flag_silo_combat_complete");
}

//Function Number: 21
combat_lobby()
{
	common_scripts\utility::flag_wait("flag_lobby_combat_start");
	var_00 = getentarray("enemy_lobby","script_noteworthy");
	if(var_00.size > 0)
	{
		foreach(var_02 in var_00)
		{
			var_02.script_forcespawn = 1;
		}

		maps\_spawner::flood_spawner_scripted(var_00);
	}

	maps\finale_utility::spawn_metrics_waittill_deaths_reach(4,["enemy_lobby"],1);
	common_scripts\utility::flag_set("flag_lobby_seek_player");
	maps\finale_utility::spawn_metrics_waittill_deaths_reach(6,["enemy_lobby"],1);
	maps\finale_utility::delete_spawners("enemy_lobby");
	common_scripts\utility::flag_set("flag_lobby_clear");
}

//Function Number: 22
intro_flyin()
{
	if(!common_scripts\utility::flag("flag_intro_screen_complete"))
	{
		thread finale_intro_screen();
	}

	common_scripts\utility::flag_wait("flag_intro_flyin_start");
	common_scripts\utility::flag_wait("flag_intro_screen_complete");
	common_scripts\utility::flag_set("flag_se_intro_flyin_start");
	thread maps\_utility::autosave_now();
	level.littlebird_player = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("littlebird_player");
	level.littlebird_player maps\_vehicle::godon();
	var_00 = getent("org_player_attach","targetname");
	var_00.angles = level.littlebird_player.angles;
	var_00 linkto(level.littlebird_player);
	var_01 = maps\_utility::spawn_anim_model("world_body_mech");
	var_01.angles = var_00.angles;
	var_01.origin = var_00.origin;
	var_01 linkto(level.littlebird_player);
	var_01 hide();
	level.player.player_rig_heli = var_01;
	thread se_intro_flyin_gideon();
	thread intro_player(level.littlebird_player,var_01);
	thread intro_bobbing_boats();
	thread se_intro_ambient_warbirds();
	thread se_intro_ambient_jets();
	thread se_intro_missiles();
	thread flyin_handle_steady_rumble();
}

//Function Number: 23
intro_player(param_00,param_01)
{
	level.player playerlinkto(param_01,"tag_player",1,20,20,20,20,0);
	level.player.drivingvehicle = param_00;
	var_02 = getanimlength(param_01 maps\_utility::getanim("intro_flyin"));
	param_01 setanim(param_01 maps\_utility::getanim("intro_flyin"),1,0,1);
	wait(var_02);
	level.player playerlinkto(param_01,"tag_player",0.2,90,90,25,40,0);
	common_scripts\utility::flag_wait("flag_intro_flyin_release");
	soundscripts\_snd::snd_message("start_canal");
}

//Function Number: 24
threat_bias_canal_think()
{
	self setthreatbiasgroup("player");
	setthreatbias("player","enemy_canal",5000);
}

//Function Number: 25
threat_bias_silo_think()
{
	self setthreatbiasgroup("player");
	setthreatbias("player","enemy_silo",7000);
}

//Function Number: 26
se_intro_flyin_gideon()
{
	common_scripts\utility::flag_wait("flag_se_intro_flyin_start");
	var_00 = getent("org_intro_flying","targetname");
	level.littlebird_gideon = maps\_vehicle::spawn_vehicle_from_targetname("littlebird_gideon");
	level.littlebird_gideon maps\_vehicle::godon();
	level.littlebird_gideon.animname = "helo_intro_gideon";
	level.gideon setmodel("npc_exo_armor_bigfin");
	var_01 = [level.littlebird_gideon,level.gideon];
	thread player_helo_release(var_00);
	thread gideon_helo_release(var_00,var_01);
	level.gideon thread maps\finale_heli_custom_aim::start_heli_custom_aim("kill_start_heli_custom_aim");
	soundscripts\_snd::snd_message("fin_flyin_start");
	thread rope_link(level.littlebird_gideon,"ropeAttach_KL",level.gideon,"J2_exoShoulder_L");
	thread rope_link(level.littlebird_gideon,"ropeAttach_KR",level.gideon,"J2_exoShoulder_R");
	thread rope_link(level.littlebird_gideon,"ropeAttach_KM",level.gideon,"J_plate_TKR");
	var_00 maps\_anim::anim_single(var_01,"intro_flyin");
	if(!common_scripts\utility::flag("flag_intro_flyin_release"))
	{
		var_00 thread maps\_anim::anim_loop(var_01,"intro_flyin_idle","ender");
	}
}

//Function Number: 27
flyin_handle_steady_rumble()
{
	level.flyin_steady_rumble_intensity = 0.08;
	maps\finale_utility::set_level_player_rumble_ent_intensity(level.flyin_steady_rumble_intensity);
	level.player waittill("player_released_from_drone");
	maps\finale_utility::set_level_player_rumble_ent_intensity(0);
}

//Function Number: 28
gideon_helo_release(param_00,param_01)
{
	common_scripts\utility::flag_wait("flag_intro_flyin_release");
	level.gideon notify("kill_start_heli_custom_aim");
	wait(0.75);
	param_00 notify("ender");
	level.littlebird_gideon maps\_utility::anim_stopanimscripted();
	level.gideon maps\_utility::anim_stopanimscripted();
	level.gideon common_scripts\utility::delaycall(2,::setmodel,"npc_exo_armor_base");
	param_00 maps\_anim::anim_single(param_01,"intro_flyin_release");
	var_02 = common_scripts\utility::getstruct("path_helo_intro_gideon_end","targetname");
	level.littlebird_gideon thread maps\_utility::vehicle_dynamicpath(var_02,0);
	maps\_utility::activate_trigger_with_targetname("trig_color_canal_land");
}

//Function Number: 29
intro_gideon(param_00,param_01)
{
	level.gideon maps\_utility::teleport_to_ent_tag(param_01,"tag_origin");
	level.gideon linkto(param_01,"tag_origin");
	common_scripts\utility::flag_wait("flag_intro_flyin_release");
	level.gideon unlink();
	param_01 = getent("org_gideon_canal_floor","targetname");
	var_02 = getent("clip_gideon_down_exhaust","targetname");
	var_02.origin = level.gideon.origin;
	level.gideon linkto(var_02);
	var_02 moveto(param_01.origin,1.75,1.65,0.1);
	wait(1.75);
	level.gideon unlink();
}

//Function Number: 30
intro_bobbing_boats()
{
	var_00 = getentarray("civilian_yacht_01","targetname");
	var_01 = getentarray("civilian_yacht_02","targetname");
	var_02 = getentarray("civilian_yacht_03","targetname");
	var_03 = getentarray("civilian_barge_01","targetname");
	common_scripts\utility::array_thread(var_00,::maps\finale_utility::boat_bobbing_think);
	common_scripts\utility::array_thread(var_00,::maps\finale_fx::boat_small_static_foam);
	common_scripts\utility::array_thread(var_01,::maps\finale_utility::boat_bobbing_think);
	common_scripts\utility::array_thread(var_01,::maps\finale_fx::boat_small_static_foam);
	common_scripts\utility::array_thread(var_02,::maps\finale_utility::boat_bobbing_think);
	common_scripts\utility::array_thread(var_02,::maps\finale_fx::boat_small_static_foam);
	common_scripts\utility::array_thread(var_03,::maps\finale_utility::boat_bobbing_think);
	common_scripts\utility::array_thread(var_03,::maps\finale_fx::boat_large_static_foam);
	common_scripts\utility::flag_wait("flag_intro_flyin_release");
	level notify("boat_scene_cleanup");
}

//Function Number: 31
se_intro_missiles()
{
	maps\_utility::delaythread(15,::maps\_vehicle::spawn_vehicle_from_targetname_and_drive,"rpg_at_gideon_01");
	maps\_utility::delaythread(27.6,::maps\_vehicle::spawn_vehicle_from_targetname_and_drive,"rpg_at_gideon_02");
	maps\_utility::delaythread(26.5,::maps\_vehicle::spawn_vehicle_from_targetname_and_drive,"rpg_at_gideon_02b");
	maps\_utility::delaythread(57.5,::maps\_vehicle::spawn_vehicle_from_targetname_and_drive,"rpg_at_gideon_04");
	maps\_utility::delaythread(57.5,::maps\_vehicle::spawn_vehicle_from_targetname_and_drive,"rpg_at_gideon_04b");
	maps\_utility::delaythread(57.5,::maps\_vehicle::spawn_vehicle_from_targetname_and_drive,"rpg_at_gideon_04c");
}

//Function Number: 32
se_intro_ambient_warbirds()
{
	maps\_utility::delaythread(1,::maps\_vehicle::spawn_vehicles_from_targetname_and_drive,"warbird_flyby01");
	maps\_utility::delaythread(9,::maps\_vehicle::spawn_vehicles_from_targetname_and_drive,"warbird_flyby03");
	maps\_utility::delaythread(28,::maps\_vehicle::spawn_vehicles_from_targetname_and_drive,"warbird_flyby05");
	maps\_utility::delaythread(80,::spawn_looping_ambient_vehicles,"warbird_flyby02");
}

//Function Number: 33
se_intro_ambient_jets()
{
	if(level.nextgen)
	{
		thread spawn_looping_ambient_vehicles("f15_01");
	}

	maps\_vehicle::spawn_vehicles_from_targetname_and_drive("f15_03");
	maps\_utility::delaythread(55,::maps\_vehicle::spawn_vehicle_from_targetname_and_drive,"f15_06");
	maps\_utility::delaythread(55,::maps\_vehicle::spawn_vehicle_from_targetname_and_drive,"shrike_06");
	maps\_utility::delaythread(75,::maps\_vehicle::spawn_vehicle_from_targetname_and_drive,"f15_05");
	maps\_utility::delaythread(75,::maps\_vehicle::spawn_vehicle_from_targetname_and_drive,"shrike_05");
}

//Function Number: 34
spawn_looping_ambient_vehicles(param_00)
{
	common_scripts\utility::array_thread(getentarray(param_00,"targetname"),::spawn_looping_ambient_vehicle_single);
}

//Function Number: 35
spawn_looping_ambient_vehicle_single()
{
	while(!common_scripts\utility::flag("flag_intro_flyin_release"))
	{
		var_00 = maps\_vehicle::spawn_vehicle_and_gopath();
		var_00 waittill("death");
		wait 0.05;
	}
}

//Function Number: 36
se_canal_breach()
{
	thread gideon_goto_canal_breach();
	var_00 = getent("org_canal_breach","targetname");
	var_01 = maps\_utility::spawn_anim_model("world_body_mech");
	var_01 hide();
	var_02 = maps\_utility::spawn_anim_model("breach_bomb");
	var_02.animname = "breach_bomb";
	var_02 hide();
	var_03 = [var_01,var_02];
	var_00 thread maps\_anim::anim_first_frame(var_03,"canal_breach");
	maps\_playermech_code::hide_mech_glass_static_overlay(var_01);
	var_04 = getent("trig_canal_breach","targetname");
	var_05 = var_04 maps\_shg_utility::hint_button_trigger("x");
	common_scripts\utility::flag_wait("flag_canal_breach_start");
	if(level.currentgen)
	{
		common_scripts\utility::flag_set("load_middle_transient");
	}

	var_04 sethintstring("");
	var_05 maps\_shg_utility::hint_button_clear();
	maps\_utility::activate_trigger_with_targetname("trig_color_canal_breach");
	thread wall_canal_breach();
	level.player freezecontrols(1);
	var_03 = [var_01,level.gideon,var_02];
	var_06 = getdvarint("g_friendlyNameDist");
	setsaveddvar("g_friendlyNameDist",0);
	var_07 = 0.5;
	level.player playerlinktoblend(var_01,"tag_player",var_07);
	wait(var_07);
	level.player maps\_playermech_code::mech_setup_player_for_scene();
	var_01 show();
	var_02 show();
	var_00 maps\_anim::anim_single_run(var_03,"canal_breach");
	common_scripts\utility::flag_set("flag_obj_enter_silo_complete");
	common_scripts\utility::flag_set("flag_dialogue_canal_breach_complete");
	level.player unlink();
	var_01 delete();
	var_02 delete();
	level.player maps\_playermech_code::mech_setup_player_for_gameplay();
	level.player freezecontrols(0);
	level.player setorigin(level.player.origin + (0,0,-12));
	setsaveddvar("g_friendlyNameDist",var_06);
}

//Function Number: 37
gideon_goto_canal_breach()
{
	common_scripts\utility::flag_wait("flag_gideon_approach_canal_breach");
	var_00 = getnode("node_gideon_canal_breach","targetname");
	level.gideon maps\_utility::disable_ai_color();
	level.gideon maps\finale_utility::goto_node(var_00,1,64);
	level.gideon maps\_utility::enable_ai_color_dontmove();
	common_scripts\utility::flag_set("flag_dialogue_gideon_canal_breach_ready");
}

//Function Number: 38
wall_canal_breach()
{
	var_00 = getent("brush_wall_canal_breach","targetname");
	wait(9);
	var_00 connectpaths();
	var_00 delete();
}

//Function Number: 39
combat_canal_01()
{
	common_scripts\utility::flag_wait("flag_canal_combat_start");
	wait(15);
	var_00 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("vrap_canal_01");
	if(level.currentgen)
	{
		foreach(var_02 in var_00)
		{
			var_02 thread tff_cleanup_vehicle("intro");
		}
	}

	var_04 = getentarray("enemy_flyin_01","script_noteworthy");
	foreach(var_06 in var_04)
	{
		var_06 maps\_utility::spawn_ai(1);
	}

	common_scripts\utility::flag_wait("flag_chase_boats_path_02");
	maps\finale_utility::cleanup_ai_with_script_noteworthy("enemy_flyin_01",256);
	var_04 = getentarray("enemy_flyin_04","script_noteworthy");
	foreach(var_06 in var_04)
	{
		var_06 maps\_utility::spawn_ai(1);
	}

	common_scripts\utility::flag_wait("flag_canal_comabt_post_highway");
	wait(3);
	var_02 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("vrap_canal_03");
	if(level.currentgen)
	{
		var_02 thread tff_cleanup_vehicle("intro");
	}

	wait(2);
	var_02 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("vrap_canal_04");
	if(level.currentgen)
	{
		var_02 thread tff_cleanup_vehicle("intro");
	}

	var_04 = getentarray("enemy_flyin_05","script_noteworthy");
	foreach(var_06 in var_04)
	{
		var_06 maps\_utility::spawn_ai(1);
	}

	common_scripts\utility::flag_wait("flag_canal_combat_end");
	var_00 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("vrap_canal_05");
	if(level.currentgen)
	{
		foreach(var_02 in var_00)
		{
			var_02 thread tff_cleanup_vehicle("intro");
		}
	}

	var_04 = getentarray("enemy_flyin_06","script_noteworthy");
	foreach(var_06 in var_04)
	{
		var_06 maps\_utility::spawn_ai(1);
	}

	common_scripts\utility::flag_wait("flag_intro_flyin_done");
	maps\finale_utility::cleanup_ai_with_script_noteworthy("enemy_flyin_04",256);
	maps\finale_utility::cleanup_ai_with_script_noteworthy("enemy_flyin_05",256);
	common_scripts\utility::flag_wait("flag_intro_flyin_release");
	wait(3);
	maps\finale_utility::cleanup_ai_with_script_noteworthy("enemy_flyin_06",256);
}

//Function Number: 40
combat_flyin_bridge()
{
	common_scripts\utility::flag_wait("flag_combat_flyin_bridge_01");
	var_00 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("vrap_canal_02");
	var_01 = [];
	foreach(var_03 in var_00)
	{
		var_01 = common_scripts\utility::array_combine(var_01,var_03.riders);
	}

	if(level.currentgen)
	{
		foreach(var_03 in var_00)
		{
			var_03 thread tff_cleanup_vehicle("intro");
		}
	}

	wait(3);
	var_07 = getentarray("enemy_flyin_bridge_01","script_noteworthy");
	foreach(var_09 in var_07)
	{
		var_09 maps\_utility::spawn_ai(1);
	}

	var_07 = getentarray("enemy_flyin_bridge_02","script_noteworthy");
	foreach(var_09 in var_07)
	{
		var_09 maps\_utility::spawn_ai(1);
	}

	common_scripts\utility::flag_wait("flag_canal_highway_ai_cleanup");
	maps\finale_utility::cleanup_ai_with_script_noteworthy("enemy_flyin_bridge_01",256);
	foreach(var_0E in var_01)
	{
		if(isdefined(var_0E))
		{
			var_0E delete();
		}
	}

	foreach(var_11 in var_00)
	{
		if(isdefined(var_11))
		{
			var_11 delete();
		}
	}
}

//Function Number: 41
canal_chase_boats()
{
	common_scripts\utility::create_dvar("vehicle_free_path_debug",0);
	common_scripts\utility::flag_wait("flag_canal_combat_start");
	var_00 = [level.player,level.gideon];
	level.freedrive_playermatch_catchup_ramp_start_dist = -125;
	level.freedrive_playermatch_catchup_ramp_end_dist = 500;
	level.freedrive_playermatch_catchup_multiplier = 2.2;
	level.freedrive_playermatch_slowdown_ramp_start_dist = 650;
	level.freedrive_playermatch_slowdown_ramp_end_dist = 600;
	level.freedrive_vehicle_min_allowed_speed = 0;
	level.freedrive_dodge_static_early_distance = 1000;
	level.freedrive_stay_within_percent_of_edge = 0.9;
	level.freedrive_progress_mod_step = 600;
	wait(4);
	maps\_vehicle_free_drive::init_vehicle_free_path("road_path_left_01");
	var_01 = getentarray("enemy_boat_01","targetname");
	foreach(var_03 in var_01)
	{
		var_04 = var_03 maps\_vehicle_free_drive::spawn_vehicle_and_attach_to_free_path(45,0,0,0);
		var_04 thread vehicle_scripts\_diveboat::setup_and_fire_missles_at_guys_repeated(var_00);
	}

	common_scripts\utility::flag_wait("flag_chase_boats_path_02");
	maps\_vehicle_free_drive::init_vehicle_free_path("road_path_left_02");
	var_01 = getentarray("enemy_boat_03","targetname");
	foreach(var_03 in var_01)
	{
		var_04 = var_03 maps\_vehicle_free_drive::spawn_vehicle_and_attach_to_free_path(30,0,0,0);
		var_04 thread vehicle_scripts\_diveboat::setup_and_fire_missles_at_guys_repeated(var_00);
	}
}

//Function Number: 42
ai_canal_combat_01_accuracy_think()
{
	self endon("death");
	common_scripts\utility::flag_wait("flag_combat_flyin_bridge_01");
	maps\_utility::set_baseaccuracy(0.1);
}

//Function Number: 43
ai_canal_combat_02_accuracy_think()
{
	self endon("death");
	common_scripts\utility::flag_wait("flag_chase_boats_path_02");
	maps\_utility::set_baseaccuracy(0.1);
}

//Function Number: 44
ai_canal_combat_03_accuracy_think()
{
	self endon("death");
	common_scripts\utility::flag_wait("flag_canal_accuracy_tweak_bridge_02");
	maps\_utility::set_baseaccuracy(0.1);
}

//Function Number: 45
ai_canal_combat_04_accuracy_think()
{
	self endon("death");
	common_scripts\utility::flag_wait("flag_canal_accuracy_tweak_combat_04");
	maps\_utility::set_baseaccuracy(0.1);
}

//Function Number: 46
ai_canal_combat_05_accuracy_think()
{
	self endon("death");
	common_scripts\utility::flag_wait("flag_canal_combat_end");
	maps\_utility::set_baseaccuracy(0.1);
}

//Function Number: 47
boat_death_think()
{
	if(!isdefined(level.boat_canal))
	{
		level.boat_canal = 0;
	}

	level.boat_canal++;
	self waittill("death",var_00);
	thread flyin_scene_handle_vehicle_destroyed_rumbles(self);
	level.boat_canal--;
	if(level.boat_canal == 0)
	{
		common_scripts\utility::flag_set("flag_boat_canal_dead");
		return;
	}

	if(var_00 == level.player)
	{
		common_scripts\utility::flag_set("flag_boat_single_dead");
	}
}

//Function Number: 48
flyin_scene_handle_vehicle_destroyed_rumbles(param_00)
{
	var_01 = distance(level.player.origin,param_00.origin);
	var_02 = 2500;
	var_03 = 0.8;
	var_04 = var_02 - var_01 / var_02 / var_03;
	if(var_04 > 0.2)
	{
		maps\finale_utility::set_level_player_rumble_ent_intensity_for_time(var_04,0.25);
	}
}

//Function Number: 49
estimate_player_speed()
{
	var_00 = level.player.origin;
	while(!level.player isonground())
	{
		level.player.velocity_scripted = level.player.origin - var_00 / 0.05;
		var_00 = level.player.origin;
		wait 0.05;
	}

	earthquake(0.3,1,level.player.origin,128);
}

//Function Number: 50
player_helo_release(param_00)
{
	common_scripts\utility::flag_wait("flag_intro_flyin_done");
	wait_for_player_release();
	thread maps\_water::watchaienterwater(level.gideon);
	thread player_speed_control_underwater();
	var_01 = level.player.player_rig_heli;
	var_02 = 2;
	level.player lerpviewangleclamp(var_02,1,0.3,0,0,0,0);
	thread estimate_player_speed();
	soundscripts\_snd::snd_message("fin_flyin_drop");
	var_01 maps\_anim::anim_single_solo(var_01,"intro_flyin_release_vm");
	level.player unlink();
	level.player setvelocity((0,0,level.player.velocity_scripted[2]));
	common_scripts\utility::flag_set("flag_intro_flyin_release");
	common_scripts\utility::flag_set("underwater_flashlight");
	common_scripts\utility::flag_clear("flyin_mb");
	maps\_utility::delaythread(5,::maps\_utility::autosave_by_name,"canal");
}

//Function Number: 51
wait_for_player_release()
{
	thread maps\_utility::hintdisplayhandler("release_hint");
	var_00 = 0;
	while(var_00 < 1)
	{
		var_00 = 0;
		while(level.player usebuttonpressed() && var_00 < 1)
		{
			var_00 = var_00 + 0.1;
			wait 0.05;
		}

		wait 0.05;
	}

	common_scripts\utility::flag_set("flag_release_hint_off");
	level.player notify("player_released_from_drone");
}

//Function Number: 52
release_hint_off()
{
	return common_scripts\utility::flag("flag_release_hint_off");
}

//Function Number: 53
signed_distance_to_plane(param_00,param_01,param_02)
{
	return vectordot(param_02 - param_00,param_01);
}

//Function Number: 54
player_speed_control_rocket_blast()
{
	level.origacceleration = getdvarfloat("mechAcceleration");
	setsaveddvar("mechAcceleration",5);
	level.gideon.goalradius = 64;
	player_speed_control(0.12,0.6,0,124,64,0.8,1.2,1.5,::is_player_in_rocket_blast,"start_node_exhaust","gideon_rocket_idle_node",1);
	setsaveddvar("mechAcceleration",level.origacceleration);
}

//Function Number: 55
player_speed_control_underwater()
{
	for(;;)
	{
		for(;;)
		{
			if(isdefined(level.player.underwater) && level.player.underwater)
			{
				break;
			}

			wait 0.05;
		}

		level.player maps\_playermech_code::disable_mech_rocket();
		level.player maps\_playermech_code::disable_mech_chaingun();
		level.player maps\_playermech_code::disable_mech_swarm();
		level.player hidehud();
		player_speed_control(0.25,maps\_swim_player::get_underwater_walk_speed_scale_default() * 1.5,0,300,128,maps\_water::get_underwater_walk_speed_scale_ai(),maps\_water::get_underwater_walk_speed_scale_ai() * 1.4,1.5,::is_player_underwater,"start_node_underwater","end_node_underwater",0);
		level.player maps\_playermech_code::enable_mech_chaingun();
		level.player maps\_playermech_code::enable_mech_rocket();
		level.player maps\_playermech_code::enable_mech_swarm();
		level.player showhud();
		wait 0.05;
	}
}

//Function Number: 56
is_player_underwater()
{
	return isdefined(level.player.underwater) && level.player.underwater;
}

//Function Number: 57
custom_distance_along_path_think(param_00)
{
	var_01 = 0;
	while([[ param_00 ]]())
	{
		var_02 = get_custom_distance_on_path(var_01);
		var_01 = var_02[0];
		var_03 = var_02[1];
		self.distance_on_path = var_03;
		wait 0.05;
	}
}

//Function Number: 58
get_custom_distance_on_path(param_00)
{
	var_01 = (0,0,16);
	var_02 = 130;
	var_03 = undefined;
	var_04 = undefined;
	if(!isdefined(level.speed_control_pathnodes) || level.speed_control_pathnodes.size == 0)
	{
		return [0,0];
	}

	if(isai(self))
	{
		var_03 = self getnearestnode();
	}
	else
	{
		var_05 = getnodesinradiussorted(self.origin,1000,0);
		var_03 = var_05[0];
	}

	if(!isdefined(var_03))
	{
		return [0,0];
	}

	var_04 = getnodesinradius(var_03.origin,var_02,0);
	if(isdefined(var_03.target))
	{
		var_06 = getnode(var_03.target,"targetname");
	}

	if(isdefined(var_03.targetname))
	{
		var_07 = getnode(var_03.targetname,"target");
	}

	var_08 = undefined;
	var_09 = undefined;
	var_0A = 0;
	var_0B = 0;
	var_0C = undefined;
	for(var_0D = param_00;var_0D < level.speed_control_pathnodes.size;var_0D++)
	{
		var_0E = level.speed_control_pathnodes[var_0D];
		foreach(var_10 in var_04)
		{
			if(var_10 == var_0E)
			{
				var_11 = -1;
				var_12 = -1;
				if(var_0D >= 1)
				{
					var_13 = maps\finale_utility::get_closest_point_on_segment(self.origin,level.speed_control_pathnodes[var_0D - 1].origin,var_0E.origin);
					var_11 = var_13[0];
					var_14 = var_13[1];
					var_08 = var_13[2];
					var_09 = var_13[3];
					if(var_11 > 0 && var_11 < 1)
					{
						var_0B = 1;
						param_00 = var_0D - 1;
						var_0A = var_11;
						break;
					}
				}

				if(var_0D < level.speed_control_pathnodes.size - 2)
				{
					var_15 = maps\finale_utility::get_closest_point_on_segment(self.origin,var_0E.origin,level.speed_control_pathnodes[var_0D + 1].origin);
					var_12 = var_15[0];
					var_14 = var_15[1];
					var_08 = var_15[2];
					var_09 = var_15[3];
					if(var_12 > 0 && var_12 < 1)
					{
						var_0B = 1;
						param_00 = var_0D;
						var_0A = var_12;
						break;
					}
				}

				if(var_11 == 1 && var_12 == 0)
				{
					var_0B = 1;
					var_08 = self.origin;
					var_09 = level.speed_control_pathnodes[var_0D].origin;
					param_00 = var_0D;
					var_0A = 0;
					break;
				}
			}
		}

		if(var_0B)
		{
			break;
		}
	}

	var_17 = 0;
	var_18 = level.speed_control_pathnodes_dist[param_00];
	if(!var_0B && param_00 == 0 && var_17 == 0)
	{
		var_19 = level.speed_control_pathnodes[1].origin - level.speed_control_pathnodes[0].origin;
		var_19 = (var_19[0],var_19[1],0);
		var_19 = vectornormalize(var_19);
		var_1A = self.origin - level.speed_control_pathnodes[0].origin;
		var_1A = (var_1A[0],var_1A[1],0);
		var_1B = vectordot(var_1A,var_19);
		var_18 = var_1B;
		var_0B = 1;
	}

	if(var_0B)
	{
		var_17 = level.speed_control_pathnodes_dist[param_00 + 1] - level.speed_control_pathnodes_dist[param_00] * var_0A;
	}

	return [param_00,var_18 + var_17];
}

//Function Number: 59
calculatedistances(param_00)
{
	var_01 = [];
	var_01[0] = 0;
	if(!isdefined(param_00))
	{
		return;
	}

	for(var_02 = 1;var_02 < param_00.size;var_02++)
	{
		var_01[var_02] = var_01[var_02 - 1] + distance2d(param_00[var_02 - 1].origin,param_00[var_02].origin);
	}

	return var_01;
}

//Function Number: 60
player_speed_control(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = 1;
	var_0D = 0;
	var_0E = 0;
	var_0F = undefined;
	if(!isdefined(param_0B))
	{
		param_0B = 1;
	}

	maps\_utility_code::movespeed_ramp_over_time(level.gideon,level.gideon.moveplaybackrate,param_05,0.05);
	if(isdefined(param_09))
	{
		var_10 = getnode(param_09,"targetname");
		var_11 = getnode(param_0A,"targetname");
		level.speed_control_pathnodes = getnodesonpath(var_10.origin,var_11.origin,1,var_10,var_11);
		level.speed_control_pathnodes_dist = calculatedistances(level.speed_control_pathnodes);
	}

	level.gideon thread custom_distance_along_path_think(param_08);
	level.player thread custom_distance_along_path_think(param_08);
	while([[ param_08 ]]())
	{
		var_12 = level.gideon.distance_on_path - level.player.distance_on_path;
		waittillframeend;
		if(gettime() > var_0E)
		{
			var_0C = maps\_shg_utility::linear_map_clamp(var_12,param_02,param_03,param_00,param_01);
			level.player setmovespeedscale(var_0C);
			if(var_12 < param_04)
			{
				var_0D = gettime() + 3000;
				var_0E = gettime() + param_07 * 1000;
				thread maps\_utility_code::movespeed_ramp_over_time(level.gideon,level.gideon.moveplaybackrate,param_06,param_07);
			}

			if(gettime() > var_0D && var_0D != 0)
			{
				var_0E = gettime() + param_07 * 1000;
				thread maps\_utility_code::movespeed_ramp_over_time(level.gideon,level.gideon.moveplaybackrate,param_05,param_07);
				var_0D = 0;
			}
		}

		if(param_0B && var_12 < 20)
		{
			level.player setmovespeedscale(0);
		}

		wait 0.05;
	}

	thread maps\_utility_code::movespeed_ramp_over_time(level.gideon,level.gideon.moveplaybackrate,1,1);
	thread maps\_utility_code::movespeed_ramp_over_time(level.player,var_0C,1,1);
}

//Function Number: 61
anim_loop_hatch_anims_solo(param_00,param_01,param_02,param_03)
{
	param_00 endon("ender_gideon");
	var_04 = 0;
	while(!common_scripts\utility::flag("flag_exhaust_hatch_open"))
	{
		param_00 maps\_anim::anim_single_solo(level.gideon,param_02);
		if(isdefined(level.player.debug_skip_button_press))
		{
			return;
		}

		param_00 maps\_anim::anim_single_solo(level.gideon,param_03);
		if(isdefined(level.player.debug_skip_button_press))
		{
			return;
		}
	}
}

//Function Number: 62
se_missile_load()
{
	var_00 = getent("org_missile_load","targetname");
	var_01 = getent("missile_bottom","targetname");
	var_01.animname = "missile_main";
	var_01 maps\_utility::assign_animtree();
	for(var_02 = var_01;isdefined(var_02.target);var_02 = var_03)
	{
		var_03 = getent(var_02.target,"targetname");
		var_03 linkto(var_01,"missile");
	}

	var_04 = maps\_utility::spawn_anim_model("missile_01");
	var_05 = maps\_utility::spawn_anim_model("missile_02");
	var_06 = maps\_utility::spawn_anim_model("missile_03");
	var_07 = maps\_utility::spawn_anim_model("missile_04");
	var_08 = maps\_utility::spawn_anim_model("missile_05");
	var_09 = maps\_utility::spawn_anim_model("missile_06");
	var_0A = [var_01,var_04,var_05,var_06,var_07,var_08,var_09];
	var_00 thread maps\_anim::anim_first_frame(var_0A,"missile_load");
	thread maps\finale_lighting::missle_lighting(var_0A);
	thread silo_catwalks();
	common_scripts\utility::flag_wait("flag_missile_move_start");
	thread silo_autosaves();
	thread countdown_missile_launch();
	thread close_silo_doors();
	var_0B = getnodearray("node_silo","targetname");
	foreach(var_0D in var_0B)
	{
		var_0D disconnectnode();
	}

	thread speed_up_missile_load(var_0A);
	var_00 maps\_anim::anim_single(var_0A,"missile_load");
	common_scripts\utility::flag_set("flag_missile_seated");
}

//Function Number: 63
countdown_missile_launch()
{
	common_scripts\utility::flag_wait("flag_dialogue_launch_coundown_complete");
	if(!common_scripts\utility::flag("flag_gideon_down_exhaust"))
	{
		common_scripts\utility::flag_set("flag_countdown_complete_mission_fail");
		maps\finale_vo::dialogue_primary_ignitionin();
		thread handle_failstate_primary_ignition_rumbles(1);
		thread maps\finale_utility::chase_timer_countdown(2,&"FINALE_FAILED_MISSILE_LAUNCH");
		return;
	}

	wait(25);
	if(!common_scripts\utility::flag("flag_exhaust_hatch_open"))
	{
		common_scripts\utility::flag_set("flag_countdown_complete_mission_fail");
		maps\finale_vo::dialogue_primary_ignitionin();
		thread handle_failstate_primary_ignition_rumbles(1);
		thread maps\finale_utility::chase_timer_countdown(2,&"FINALE_FAILED_MISSILE_LAUNCH");
	}
}

//Function Number: 64
handle_failstate_primary_ignition_rumbles(param_00)
{
	var_01 = 0;
	for(;;)
	{
		var_02 = 0.2 + var_01 / 50;
		var_03 = 0.01 + var_01 / 80;
		maps\finale_utility::set_level_player_rumble_ent_intensity(var_02);
		if(isdefined(param_00) && param_00)
		{
			earthquake(var_03,0.1,level.player.origin,1000);
		}

		var_01++;
		if(var_01 > 40)
		{
			break;
		}

		wait(0.1);
	}
}

//Function Number: 65
speed_up_missile_load(param_00)
{
	wait 0.05;
	thread maps\_anim::anim_set_rate(param_00,"missile_load",1.75);
}

//Function Number: 66
close_silo_doors()
{
	common_scripts\utility::flag_wait("flag_silo_watwalks_open");
	var_00 = getent("door_silo_right","targetname");
	var_01 = getent("door_silo_left","targetname");
	var_00 rotateby((0,-90,0),2,1,0.5);
	var_01 rotateby((0,90,0),2,1,0.5);
}

//Function Number: 67
silo_catwalks()
{
	var_00 = getent("silo_catwalk","targetname");
	var_00 common_scripts\utility::hide_notsolid();
	var_01 = getnodearray("node_silo_01","targetname");
	foreach(var_03 in var_01)
	{
		var_03 disconnectnode();
	}

	var_05 = getnodearray("node_silo_02","targetname");
	foreach(var_03 in var_05)
	{
		var_03 disconnectnode();
	}

	var_08 = getnodearray("node_silo_03","targetname");
	foreach(var_03 in var_08)
	{
		var_03 disconnectnode();
	}

	common_scripts\utility::flag_wait("flag_missile_move_start");
	thread maps\finale_lighting::s_flicker_catwalk_alarm();
	var_0B = getent("org_silo_catwalk_narrow","targetname");
	var_0C = getent("org_silo_catwalk_wide","targetname");
	var_0D = maps\_utility::spawn_anim_model("catwalk_narrow_01");
	var_0E = maps\_utility::spawn_anim_model("catwalk_narrow_02");
	var_0F = maps\_utility::spawn_anim_model("catwalk_wide_01");
	var_10 = maps\_utility::spawn_anim_model("catwalk_wide_02");
	var_11 = [var_0D,var_0E];
	var_12 = [var_0F,var_10];
	var_0B thread maps\_anim::anim_first_frame(var_11,"catwalk");
	var_0C thread maps\_anim::anim_first_frame(var_12,"catwalk");
	common_scripts\utility::flag_wait("flag_silo_watwalks_open");
	common_scripts\utility::flag_wait("flag_lower_missile_loader");
	common_scripts\utility::flag_set("flag_dialogue_ast_ahead");
	level notify("lighting_kill_catwalk_s_flicker_red");
	common_scripts\utility::flag_set("flag_silo_combat_02");
	var_13 = getent("org_missile_corridor_lower","targetname");
	var_14 = getent("org_missile_corridor_origin","targetname");
	var_15 = getent("missle_corridor","targetname");
	var_16 = getent("missle_corridor_glass","targetname");
	var_16 linkto(var_15);
	var_15 overridelightingorigin(var_14.origin);
	var_15 thread maps\finale_fx::vfx_silo_corridor_lowering();
	var_15 moveto(var_13.origin,6,2,1);
	wait(3);
	var_0B thread maps\_anim::anim_single(var_11,"catwalk");
	var_0C thread maps\_anim::anim_single(var_12,"catwalk");
	thread maps\finale_fx::vfx_catwalk_lowering();
	wait(3);
	level notify("lighting_kill_catwalk_s_flicker_white");
	silo_catwalk_clip(var_00);
	maps\_utility::activate_trigger_with_targetname("trig_color_missile_in_position");
}

//Function Number: 68
se_door_kick()
{
	common_scripts\utility::flag_wait_all("flag_silo_combat_stop","flag_silo_combat_complete");
	soundscripts\_snd::snd_music_message("ast_combat_end");
	level.gideon maps\_utility::disable_ai_color();
	var_00 = getent("org_silo_door_kick","targetname");
	var_00 maps\_anim::anim_reach_solo(level.gideon,"kick_door_enter_mech");
	var_00 maps\_anim::anim_single_solo(level.gideon,"kick_door_enter_mech");
	if(!common_scripts\utility::flag("flag_player_close_to_kick_doors"))
	{
		var_00 thread maps\_anim::anim_loop_solo(level.gideon,"kick_door_idle_mech");
	}

	common_scripts\utility::flag_wait("flag_player_close_to_kick_doors");
	level.player notify("kill_player_follow_volume_think");
	level.gideon maps\_utility::anim_stopanimscripted();
	var_00 maps\_utility::anim_stopanimscripted();
	var_01 = getent("sliding_door_l","targetname");
	var_02 = getent("sliding_door_r","targetname");
	var_03 = var_01 common_scripts\utility::get_target_ent();
	var_04 = var_02 common_scripts\utility::get_target_ent();
	var_03 linkto(var_01);
	var_04 linkto(var_02);
	var_05 = [var_03,var_04];
	var_06 = maps\_utility::spawn_anim_model("kick_door_r");
	var_07 = maps\_utility::spawn_anim_model("kick_door_l");
	var_08 = [level.gideon,var_07,var_06];
	var_00 maps\_anim::anim_first_frame(var_08,"kick_door");
	var_01.origin = var_07 gettagorigin("tag_origin_animated");
	var_02.origin = var_06 gettagorigin("tag_origin_animated");
	var_01 linkto(var_07,"tag_origin_animated");
	var_02 linkto(var_06,"tag_origin_animated");
	foreach(var_0A in var_05)
	{
		var_0A connectpaths();
	}

	level.gideon maps\_utility::walkdist_force_walk();
	soundscripts\_snd::snd_message("silo_door_kick",level.gideon);
	var_00 maps\_anim::anim_single(var_08,"kick_door");
	level.gideon maps\_utility::anim_stopanimscripted();
	var_00 maps\_utility::anim_stopanimscripted();
	maps\_utility::activate_trigger_with_targetname("trig_color_exit_main_silo");
	level.gideon maps\_utility::enable_ai_color();
	level.gideon maps\_utility::delaythread(5,::maps\_utility::walkdist_reset);
	common_scripts\utility::flag_set("flag_se_door_kick_complete");
	var_03 delete();
}

//Function Number: 69
se_exhaust_hatch()
{
	var_00 = getent("org_exhaust_hatch","targetname");
	common_scripts\utility::flag_wait("flag_se_exhaust_hatch_init");
	level.gideon maps\_mech::mech_stop_rockets();
	var_01 = maps\_utility::spawn_anim_model("hatch");
	var_02 = maps\_utility::spawn_anim_model("piston_r");
	var_03 = maps\_utility::spawn_anim_model("piston_l");
	var_01.animname = "hatch";
	var_02.animname = "piston_r";
	var_03.animname = "piston_l";
	var_04 = [var_01,var_03];
	thread se_exhaust_hatch_player(var_00,var_02);
	var_00 thread maps\_anim::anim_first_frame(var_04,"exhaust_hatch_enter");
	common_scripts\utility::flag_wait("flag_gideon_down_exhaust");
	var_04 = [level.gideon,var_01,var_03];
	var_00 maps\_anim::anim_reach_solo(level.gideon,"exhaust_hatch_enter");
	var_00 maps\_anim::anim_single(var_04,"exhaust_hatch_enter");
	soundscripts\_snd::snd_music_message("hatch_scene_being");
	common_scripts\utility::flag_set("flag_obj_exhaust_hatch_open");
	var_00 thread anim_loop_hatch_anims_solo(var_00,level.gideon,"exhaust_hatch_idle_noloop","exhaust_hatch_idle_wave_noloop");
	common_scripts\utility::flag_wait("flag_exhaust_hatch_open");
	maps\_utility::delaythread(7,::save_exhaust_hatch);
	if(!isdefined(level.player.debug_skip_button_press))
	{
		var_00 notify("ender_gideon");
		level.gideon maps\_utility::anim_stopanimscripted();
		var_00 maps\_anim::anim_single(var_04,"exhaust_hatch_open");
	}

	thread maps\finale_lighting::hatch_lighting();
	common_scripts\utility::flag_set("flag_exhaust_hatch_complete");
	var_05 = getent("clip_exhaust_hatch","targetname");
	var_05 delete();
	if(!isdefined(level.player.debug_skip_button_press))
	{
		var_00 thread maps\_anim::anim_loop_solo(level.gideon,"exhaust_hatch_end_idle","ender_gideon");
		common_scripts\utility::flag_wait("flag_player_exhaust_corridor");
		var_00 notify("ender_gideon");
	}
}

//Function Number: 70
save_exhaust_hatch()
{
	if(!common_scripts\utility::flag("flag_countdown_complete_mission_fail"))
	{
		maps\_utility::autosave_by_name("exhaust_hatch");
	}
}

//Function Number: 71
se_exhaust_hatch_player(param_00,param_01)
{
	var_02 = 0.25;
	var_03 = maps\_utility::spawn_anim_model("world_body_mech");
	var_03 hide();
	level.player.player_rig = var_03;
	var_04 = [var_03,param_01];
	maps\_playermech_code::hide_mech_glass_static_overlay(var_03);
	param_00 thread maps\_anim::anim_first_frame(var_04,"exhaust_hatch_vm_approach");
	common_scripts\utility::flag_wait("flag_exhaust_hatch_grab");
	setsaveddvar("g_friendlyNameDist",0);
	level.player maps\_playermech_code::mech_setup_player_for_scene(undefined,1);
	level.player allowads(0);
	var_05 = getanimlength(maps\finale_anim_vm::getanim_vm("s1_playermech_putaway"));
	var_05 = var_05 / 2;
	level.player playerlinktoblend(var_03,"tag_player",0.5);
	thread playerlinktodeltadelayed(2,var_03);
	thread maps\finale_anim_vm::anim_single_solo_vm(level.player,"s1_playermech_putaway");
	wait(0.55);
	var_03 show();
	level.player maps\_playermech_code::mech_setup_player_for_scene();
	thread maps\finale_shaft::do_shaft_gameplay_setup(param_00);
	if(!isdefined(level.player.debug_skip_button_press))
	{
		param_00 maps\_anim::anim_single(var_04,"exhaust_hatch_vm_approach");
		maps\finale_shaft::hatch_button_gameplay(param_00,var_04,var_03,param_01);
	}
	else
	{
	}

	common_scripts\utility::flag_set("flag_exhaust_hatch_open");
	if(!isdefined(level.player.debug_skip_button_press))
	{
		param_00 notify("ender_player");
		thread maps\finale_shaft::store_speed(var_03);
		param_00 maps\_anim::anim_single(var_04,"exhaust_hatch_open");
	}

	soundscripts\_snd::snd_message("start_silo_exhaust_entrance");
	soundscripts\_snd::snd_music_message("hatch_jump_begin");
	level.player maps\finale_shaft::do_shaft_gameplay();
	common_scripts\utility::flag_wait("flag_player_exhaust_corridor");
	maps\_utility::delaythread(7,::maps\_utility::autosave_by_name,"exhaust_corridor");
}

//Function Number: 72
playerlinktodeltadelayed(param_00,param_01)
{
	wait(param_00);
	level.player playerlinktodelta(param_01,"tag_player",0.75,5,5,5,5,1);
}

//Function Number: 73
anim_single_solo_with_special_walk(param_00,param_01)
{
	var_02 = getent("vents","targetname");
	var_02.animname = "vents";
	var_02 maps\_utility::assign_animtree();
	var_03 = [var_02,param_00];
	maps\_anim::anim_first_frame(var_03,param_01);
	var_04 = getanimlength(param_00 maps\_utility::getanim(param_01));
	var_05 = 2.7;
	thread maps\_anim::anim_single(var_03,param_01);
	wait(var_04 - var_05);
	level.player lerpviewangleclamp(1,0.1,0.1,0,0,0,0);
	wait(var_05);
	thread maps\finale_shaft::think_player_blast_walk_anims("nohands");
	wait 0.05;
	param_00 hide();
	level.player unlink();
	level.player maps\_playermech_code::mech_setup_player_for_forced_walk_scene();
}

//Function Number: 74
se_exhaust_land()
{
	common_scripts\utility::trigger_off("trig_exhaust_corridor","targetname");
	common_scripts\utility::flag_wait("flag_player_exhaust_corridor");
	if(isdefined(level.player.player_failed_drop) && level.player.player_failed_drop)
	{
		return;
	}

	var_00 = getent("org_exhaust_hatch","targetname");
	soundscripts\_snd::snd_message("exhaust_shaft_land");
	var_00 thread anim_single_solo_with_special_walk(level.player.player_rig,"exhaust_land_vm");
	common_scripts\utility::flag_set("flag_lighting_fall_blur");
	soundscripts\_snd::snd_music_message("hatch_jump_end");
	level.player waittill("notetrack_gideon_start");
	soundscripts\_snd::snd_message("exhaust_shaft_land_gideon",level.gideon);
	var_00 thread maps\_anim::anim_single_run_solo(level.gideon,"exhaust_land");
	level.gideon set_blast_walk_anims();
	maps\_utility::activate_trigger_with_targetname("trig_color_exhaust_corridor_01");
}

//Function Number: 75
gideon_play_scripted_anim_when_reaching_goal(param_00)
{
	level.gideon endon("gideon_ender");
	var_01 = getnode("gideon_missile_stopped","targetname");
	for(;;)
	{
		if(distance2d(var_01.origin,level.gideon.origin) < 30)
		{
			break;
		}

		wait 0.05;
	}

	level.gideon maps\_utility::disable_ai_color();
	level.gideon maps\finale_utility::goto_node(var_01,1,64);
	param_00 maps\_anim::anim_reach_solo(level.gideon,"missile_stopped");
	for(;;)
	{
		if(abs(level.player.origin[0] - level.gideon.origin[0]) < 200)
		{
			break;
		}

		wait 0.05;
	}

	maps\_utility::delaythread(8,::common_scripts\utility::flag_set,"flag_player_shoot_missile");
	param_00 maps\_anim::anim_single_solo(level.gideon,"missile_stopped");
	param_00 maps\_anim::anim_loop_solo(level.gideon,"missile_stopped_idle","gideon_ender");
}

//Function Number: 76
player_exhaust_corridor()
{
	common_scripts\utility::flag_wait("flag_player_exhaust_corridor");
	level.player thread player_exhaust_corridor_rumbles();
	level.player waittill("notetrack_player_control");
	level.player setmovespeedscale(0.5);
	level.player waittill("notetrack_player_blast_react");
	maps\finale_shaft::anim_single_solo_with_lerp(level.player.player_rig,"exhaust_blast_react");
	common_scripts\utility::trigger_on("trig_exhaust_corridor","targetname");
	thread player_speed_control_rocket_blast();
	thread missile_damage_think();
	var_00 = getent("org_missile_damaged","targetname");
	thread gideon_play_scripted_anim_when_reaching_goal(var_00);
	level.player waittill("notetrack_rocket_launch_start");
	soundscripts\_snd::snd_message("aud_rocket_launch_start");
	common_scripts\utility::flag_set("flag_vfx_missile_liftoff_start");
	common_scripts\utility::flag_set("flag_missile_launch_stop");
	common_scripts\utility::flag_wait("flag_player_shoot_missile");
	if(!common_scripts\utility::flag("flag_exhaust_corridor_timer_fail"))
	{
		level.player maps\finale_utility::mech_enable_switch_exhaust_version();
		level.player maps\_playermech_code::mech_setup_player_for_gameplay();
	}

	common_scripts\utility::flag_wait("flag_missile_damaged");
	common_scripts\utility::flag_set("flag_obj_stop_missile_launch_complete");
	common_scripts\utility::flag_set("lighting_flag_obj_stop_missile_complete");
	common_scripts\utility::flag_set("flag_obj_escape");
	level.player.player_rig show();
	level.player playerlinktoabsolute(level.player.player_rig,"TAG_PLAYER");
	level.player maps\_playermech_code::mech_setup_player_for_scene();
	var_01 = maps\_utility::spawn_anim_model("minigun");
	var_02 = [var_01,level.player.player_rig,level.gideon];
	var_00 maps\_anim::anim_first_frame(var_02,"missile_stopped_vm");
	soundscripts\_snd::snd_message("fin_silo_success");
	var_00 maps\_anim::anim_single(var_02,"missile_stopped_vm");
	var_01 delete();
	thread missile_stopped();
	wait(2);
	common_scripts\utility::flag_set("flag_se_mech_exit_start");
	level.gideon clear_blast_walk_anims();
}

//Function Number: 77
player_exhaust_corridor_rumbles()
{
	level.player waittill("notetrack_vfx_blast");
	wait(1.5);
	maps\finale_utility::set_level_player_rumble_ent_intensity(0.2);
	common_scripts\utility::flag_wait("flag_player_shoot_missile");
	maps\finale_utility::set_level_player_rumble_ent_intensity(0.12);
	common_scripts\utility::flag_wait_either("flag_missile_failed","flag_missile_damaged");
	if(common_scripts\utility::flag("flag_missile_damaged"))
	{
		maps\finale_utility::set_level_player_rumble_ent_intensity(0);
		return;
	}

	thread handle_failstate_primary_ignition_rumbles();
}

//Function Number: 78
exhaust_corridor_timer()
{
	wait(55);
	if(!common_scripts\utility::flag("flag_player_shoot_missile"))
	{
		common_scripts\utility::flag_set("flag_exhaust_corridor_timer_fail");
		thread maps\finale_utility::chase_timer_countdown(2,&"FINALE_FAILED_MISSILE_LAUNCH");
	}
}

//Function Number: 79
missile_stopped()
{
	var_00 = getent("missile","targetname");
	var_01 = getent("org_missile_stopped","targetname");
}

//Function Number: 80
fail_missile_damage_think(param_00)
{
	var_01 = getent("org_missile_damaged","targetname");
	var_02 = getent("org_far_fail","targetname");
	common_scripts\utility::flag_wait("flag_player_shoot_missile");
	wait(2.2);
	wait(18);
	if(common_scripts\utility::flag("flag_missile_damaged"))
	{
		return;
	}

	common_scripts\utility::flag_set("flag_missile_failed");
	common_scripts\utility::flag_set("lighting_missile_fail");
	thread maps\finale_missile::restore_thrusters_all(param_00,param_00.damage_accumulation_clip);
	level.player maps\_playermech_code::mech_setup_player_for_scene();
	var_03 = level.player.player_rig;
	if(!isdefined(var_03))
	{
		var_03 = maps\_utility::spawn_anim_model("world_body_mech");
	}

	var_03 show();
	level.player playerlinktoabsolute(var_03,"TAG_PLAYER");
	level.player.ignore_fade_notetrack = 1;
	level.player takeallweapons();
	level.gideon notify("gideon_ender");
	var_04 = maps\_utility::spawn_anim_model("minigun");
	var_05 = [var_03,param_00,var_04,level.gideon];
	level.gideon thread freeze_anim_at_end("missile_launch");
	if(level.player.origin[0] > var_02.origin[0])
	{
		var_03.origin = (level.player.origin[0],level.player.origin[1],var_02.origin[2]);
		var_03.angles = var_02.angles;
		var_04 hide();
		var_03 maps\_anim::anim_first_frame_solo(var_03,"missile_launch_far_fail");
		var_03 thread maps\finale_shaft::anim_single_solo_in_place(var_03,"missile_launch_far_fail");
		var_05 = common_scripts\utility::array_remove(var_05,var_03);
	}

	var_01 maps\_anim::anim_first_frame(var_05,"missile_launch");
	var_01 maps\_anim::anim_single(var_05,"missile_launch");
	level.player showhud();
	level.player setclientomnvar("ui_playermech_hud",0);
	setsaveddvar("cg_drawCrosshair",0);
	setdvar("ui_deadquote",&"FINALE_FAILED_MISSILE_LAUNCH");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 81
freeze_anim_at_end(param_00)
{
	var_01 = maps\_utility::getanim(param_00);
	var_02 = getanimlength(var_01);
	var_03 = var_02 - 0.1 / var_02;
	for(;;)
	{
		if(self getanimtime(var_01) >= var_03)
		{
			break;
		}

		wait 0.05;
	}

	self setanimrate(var_01,0);
}

//Function Number: 82
missile_damage_think()
{
	level endon("flag_missile_failed");
	common_scripts\utility::flag_wait("flag_missile_launch_stop");
	var_00 = getent("damage_accumulation_clip","targetname");
	var_01 = getent("missile_main_02","targetname");
	maps\finale_missile::setup_complete_missile_prefab(var_01,var_00);
	var_01.damage_accumulation_clip = var_00;
	thread fail_missile_damage_think(var_01);
	var_00 waittill("damage",var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B);
	common_scripts\utility::flag_set("flag_missile_hit");
	playfx(common_scripts\utility::getfx("fin_rocket_silo_explosion"),var_00.origin);
	soundscripts\_snd::snd_message("aud_fin_rocket_damage_vfx");
	var_00 waittill("death",var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B);
	common_scripts\utility::flag_set("flag_missile_damaged");
	level.gideon notify("gideon_ender");
}

//Function Number: 83
is_player_in_rocket_blast()
{
	return !common_scripts\utility::flag("flag_obj_stop_missile_launch_complete");
}

//Function Number: 84
se_mech_exit()
{
	thread maps\finale_lighting::play_finale_silo_end_cine();
	var_00 = getent("org_mech_exit","targetname");
	var_01 = undefined;
	if(isdefined(level.player.player_rig))
	{
		var_01 = level.player.player_rig;
	}
	else
	{
		var_01 = maps\_utility::spawn_anim_model("world_body_mech");
	}

	var_02 = maps\_utility::spawn_anim_model("world_body");
	var_01 hide();
	var_02 hide();
	var_01 thread maps\_playermech_code::scripted_screen_flicker_loop();
	var_03 = [var_01,var_02];
	var_00 thread maps\_anim::anim_first_frame(var_03,"mech_exit");
	level.gideon maps\_utility::disable_ai_color();
	level.gideon maps\finale_utility::clearstencilstate();
	level.gideon delete();
	maps\finale::spawn_gideon();
	level.gideon maps\_utility::gun_remove();
	var_03 = [var_01,var_02,level.gideon];
	common_scripts\utility::flag_wait("flag_se_mech_exit_start");
	if(level.player hasweapon("playermech_auto_cannon_finale") || level.player hasweapon("playermech_auto_cannon_finale_exhaust"))
	{
		level.player maps\_playermech_code::playermech_end();
		level.player takeweapon("iw5_unarmedfinale_nullattach");
		level.player setviewmodel("viewhands_sentinel_mitchell_prosthetic_smashed");
		level.player giveweapon("iw5_titan45finalelobby_sp_xmags");
		level.player setweaponammostock("iw5_titan45finalelobby_sp_xmags",0);
		level.player switchtoweapon("iw5_titan45finalelobby_sp_xmags");
		level.player setadditiveviewmodelanim(0);
	}
	else
	{
		level.player takeweapon("iw5_unarmedfinale_nullattach");
		level.player giveweapon("iw5_titan45finalelobby_sp_xmags");
		level.player setweaponammostock("iw5_titan45finalelobby_sp_xmags",0);
		level.player switchtoweapon("iw5_titan45finalelobby_sp_xmags");
		level.player disableweapons();
	}

	level.player maps\_shg_utility::setup_player_for_scene(1);
	thread maps\finale_utility::screen_fade_in(2);
	level.player maps\_playermech_code::mech_setup_player_for_scene();
	var_01 show();
	var_02 show();
	level.player playerlinktodelta(var_02,"tag_player",0.75,5,5,5,5,1);
	level.player enableslowaim(0.3,0.15);
	soundscripts\_snd::snd_message("gid_release_plr_mech_suit");
	var_00 maps\_anim::anim_single(var_03,"mech_exit");
	thread maps\_utility::lerp_fov_overtime(0.5,var_02.fov_original);
	soundscripts\_snd::snd_music_message("dazed_and_confused1");
	wait(3);
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.gideon maps\_utility::gun_recall();
	level.player maps\_playermech_code::mech_setup_player_for_gameplay();
	level.player disableslowaim();
	level.player unlink();
	var_01 delete();
	var_02 delete();
	level.gideon maps\_utility::anim_stopanimscripted();
}

//Function Number: 85
se_will_reveal()
{
	soundscripts\_snd::snd_message("start_will_room");
	common_scripts\utility::flag_wait("flag_dialogue_carry_scene_02_complete");
	common_scripts\utility::flag_set("second_half_lighting");
	level.player lightsetforplayer("finale_will");
	maps\_utility::vision_set_fog_changes("finale_cinematic_nofog",0);
	maps\_utility::delaythread(10,::maps\finale_utility::screen_fade_in,4);
	var_00 = getent("org_will_reveal","targetname");
	level.player maps\_shg_utility::setup_player_for_scene(1);
	var_01 = maps\_utility::spawn_anim_model("world_body");
	var_01 hide();
	var_02 = [var_01,level.gideon];
	level.player playerlinktodelta(var_01,"tag_player",0.75,5,15,15,15,1);
	level.player enableslowaim(0.3,0.15);
	var_01 show();
	level.player lerpfov(50,0);
	var_00 thread maps\_anim::anim_first_frame(var_02,"will_reveal");
	common_scripts\utility::flag_wait("flag_dialogue_se_will_reveal");
	var_00 thread maps\_anim::anim_single_run_solo(level.gideon,"will_reveal");
	level.gideon maps\_utility::enable_cqbwalk();
	var_00 maps\_anim::anim_single_solo(var_01,"will_reveal");
	level.player unlink();
	var_01 delete();
	level.player setorigin(level.player.origin + (0,4,0));
	level.player disableslowaim();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	setsaveddvar("player_sprintSpeedScale",1.4);
	common_scripts\utility::flag_set("flag_will_reveal_complete");
}

//Function Number: 86
se_irons_reveal_head_sway()
{
	for(;;)
	{
		screenshake(level.player.origin,2.1,2.25,1.9,2,0.2,0.2,0,0.2,0.34,0.3);
		wait(1);
	}
}

//Function Number: 87
se_irons_reveal_head_jolt()
{
	screenshake(level.player.origin,4,1,1,0.25,0.1,0.1,0,0.1,0.1,0.1);
}

//Function Number: 88
se_irons_reveal_handle_button_prompts_on_arm(param_00)
{
	self hide();
	param_00 maps\_anim::anim_first_frame_solo(self,"irons_reveal_button_press");
	common_scripts\utility::delaycall(0.05,::show);
	common_scripts\utility::flag_clear("flag_buttonmash_success");
	var_01 = level.scr_anim["world_body_damaged"]["irons_reveal_button_press"];
	self setflaggedanim("prompt_start",var_01);
	var_02 = level.scr_anim["world_body_damaged"]["fin_irons_reveal_button_press_finger_loop_vm"];
	self waittillmatch("start_button_press","prompt_start");
	var_03 = common_scripts\utility::spawn_tag_origin();
	var_03.origin = self gettagorigin("J_Wrist_RI");
	var_03 linkto(self,"J_Wrist_RI",(-2.5,0,1),(0,0,0));
	var_04 = var_03 maps\_shg_utility::hint_button_tag("x","tag_origin",64,128,1,1);
	var_04.fontscale = 2;
	var_04 thread maps\_shg_utility::hint_button_flash(0.15,0.1);
	maps\_utility::hintdisplayhandler("break_free_buttonmash_hint");
	level.player notifyonplayercommand("x_pressed","+usereload");
	level.player notifyonplayercommand("x_pressed","+activate");
	childthread se_irons_reveal_monitor_button_on_arm();
	childthread se_irons_reveal_head_sway();
	thread maps\finale_utility::chase_timer_countdown(15,&"FINALE_FAILED_IRONS_CHASE");
	var_05 = self getanimtime(var_01);
	self.button_presses = 0;
	var_06 = 1;
	self setanimrate(var_01,0);
	var_07 = 0;
	soundscripts\_snd::snd_message("fin_irons_reveal_mash_start");
	while(var_05 < 1)
	{
		self.button_presses = 0;
		wait(0.2);
		if(self.button_presses >= 1)
		{
			var_07 = var_07 + 0.2;
			if(var_07 >= 1)
			{
				soundscripts\_snd::snd_message("fin_irons_reveal_mash","peak");
				var_07 = 1;
			}
			else
			{
				soundscripts\_snd::snd_message("fin_irons_reveal_mash","speedup");
			}

			self setanimrate(var_01,var_07);
			var_06 = 0;
			self setanim(var_02);
			continue;
		}

		var_07 = var_07 - 0.33;
		if(var_07 <= 0)
		{
			soundscripts\_snd::snd_message("fin_irons_reveal_mash","stopped");
			var_07 = 0;
		}
		else
		{
			soundscripts\_snd::snd_message("fin_irons_reveal_mash","slowdown");
		}

		self setanimrate(var_01,var_07);
		if(!var_06)
		{
			var_06 = 1;
		}

		var_05 = self getanimtime(var_01);
	}

	self setanimtime(var_01,1);
	var_04 maps\_shg_utility::hint_button_clear();
	var_03 delete();
	common_scripts\utility::flag_set("flag_buttonmash_success");
	soundscripts\_snd::snd_message("fin_irons_reveal_mash_finish");
	level.player notifyonplayercommandremove("x_pressed","+usereload");
	level.player notifyonplayercommandremove("x_pressed","+activate");
	common_scripts\utility::flag_set("stair_lights_on");
	level notify("chase_timer_countdown_stop");
}

//Function Number: 89
se_irons_reveal_monitor_button_on_arm()
{
	level endon("flag_buttonmash_success");
	while(!common_scripts\utility::flag("flag_buttonmash_success"))
	{
		level.player common_scripts\utility::waittill_any("x_pressed");
		self.button_presses = self.button_presses + 1;
		level.player playrumbleonentity("damage_light");
	}
}

//Function Number: 90
se_irons_reveal()
{
	soundscripts\_snd::snd_message("start_will_room");
	common_scripts\utility::flag_wait("flag_dialogue_carry_scene_02_complete");
	common_scripts\utility::flag_set("second_half_lighting");
	level.player lightsetforplayer("finale_will");
	maps\_utility::vision_set_fog_changes("finale_cinematic_nofog",0);
	var_00 = maps\_utility::spawn_targetname("irons_will_reveal",1);
	var_00.animname = "irons";
	var_00 maps\_utility::gun_remove();
	var_00.ignoreall = 1;
	level.irons = var_00;
	thread maps\finale_lighting::lighting_will_reveal();
	thread maps\finale_lighting::will_room_speech_end();
	if(level.nextgen)
	{
		thread maps\finale_lighting::setup_eye_highlights(var_00);
		thread maps\finale_lighting::dof_irons_meet(var_00);
	}

	thread will_room_door_exit();
	maps\_utility::delaythread(10,::maps\finale_utility::screen_fade_in,4);
	var_01 = getent("org_irons_reveal","targetname");
	level.player maps\_shg_utility::setup_player_for_scene(1);
	var_02 = maps\_utility::spawn_anim_model("world_body_damaged");
	var_02 hide();
	var_03 = maps\_utility::spawn_anim_model("pistol");
	var_03 hidepart("tag_rail_master_on");
	var_03 hide();
	var_04 = [var_02,level.gideon,var_03];
	level.player playerlinktodelta(var_02,"tag_player",1,0,0,0,0,1);
	level.player enableslowaim(0.3,0.15);
	var_02 show();
	var_03 show();
	var_02 thread se_irons_reveal_handle_material_swap();
	level.player lerpfov(50,0);
	var_01 thread maps\_anim::anim_first_frame(var_04,"irons_reveal");
	var_01 thread maps\_anim::anim_first_frame_solo(var_00,"irons_reveal");
	var_05 = maps\_utility::spawn_anim_model("irons_phone");
	var_05.origin = var_00 gettagorigin("TAG_WEAPON_CHEST");
	var_05.angles = var_00 gettagangles("TAG_WEAPON_CHEST");
	var_05 linkto(var_00,"TAG_WEAPON_CHEST");
	common_scripts\utility::flag_wait("flag_dialogue_se_will_reveal");
	maps\_utility::delaythread(123,::common_scripts\utility::flag_set,"flag_will_room_door_exit_open");
	level thread maps\finale_fx::vfx_irons_reveal_scene();
	level.player common_scripts\utility::delaycall(2.6,::playrumbleonentity,"damage_heavy");
	var_06 = getanimlength(maps\_utility::getanim_from_animname("irons_reveal","irons"));
	var_00 maps\_utility::delaythread(var_06,::maps\_utility::_delete);
	var_05 maps\_utility::delaythread(var_06,::maps\_utility::_delete);
	var_03 maps\_utility::delaythread(var_06,::maps\_utility::_delete);
	var_01 thread maps\_anim::anim_single_solo(var_00,"irons_reveal");
	var_01 maps\finale_ending::anim_single_with_gameplay(var_04,"irons_reveal");
	thread maps\_utility::autosave_by_name("free_from_exo");
	var_01 thread maps\_anim::anim_loop_solo(level.gideon,"irons_reveal_button_idle","ender");
	var_02 se_irons_reveal_handle_button_prompts_on_arm(var_01);
	var_02 setmodel("viewbody_sentinel_mitchell_egress_custom");
	level.player notify("exo_released");
	var_01 notify("ender");
	level.player common_scripts\utility::delaycall(5,::playrumbleonentity,"damage_heavy");
	level.gideon thread se_irons_reveal_pt2_gideon(var_01);
	var_01 thread maps\_anim::anim_single([var_02],"irons_reveal_part2");
	var_07 = var_02 maps\_utility::getanim("irons_reveal_part2");
	var_08 = getanimlength(var_07);
	var_09 = getnotetracktimes(var_07,"ease_out")[0] * var_08;
	var_0A = 0;
	while(var_0A < var_08)
	{
		if(var_0A >= var_09 && level.player getnormalizedmovement()[0] > 0.5)
		{
			break;
		}

		wait 0.05;
		var_0A = var_0A + 0.05;
	}

	level.player unlink();
	var_02 delete();
	level notify("release");
	level.player disableslowaim();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player disableoffhandweapons();
	setsaveddvar("player_sprintSpeedScale",1.6);
	common_scripts\utility::flag_set("flag_will_reveal_complete");
	common_scripts\utility::flag_set("flag_obj_escape_complete");
	common_scripts\utility::flag_set("flag_start_irons_chase");
	maps\_utility::battlechatter_off("allies");
	maps\_utility::battlechatter_off("axis");
	thread maps\finale_lighting::will_room_speech_end();
}

//Function Number: 91
se_irons_reveal_pt2_gideon(param_00)
{
	param_00 maps\_anim::anim_single([self],"irons_reveal_part2");
	param_00 thread maps\_anim::anim_loop_solo(self,"irons_reveal_idle","ender");
}

//Function Number: 92
irons_exo_hack(param_00)
{
	maps\_shg_utility::play_videolog("finale_hud_reboot","screen_add",0,0,0,0,0);
}

//Function Number: 93
se_irons_reveal_handle_material_swap()
{
	self overridematerial("mtl_arm_band_ui_glass","m/mtl_arm_band_ui_offline");
	level.gideon overridematerial("mtl_arm_band_ui_glass","m/mtl_arm_band_ui_offline");
	common_scripts\utility::flag_wait("flag_material_swap_detach_exo");
	self overridematerialreset();
	self overridematerial("mtl_arm_band_ui_glass","m/mtl_arm_band_ui_reboot");
	common_scripts\utility::flag_wait("flag_material_swap_confirm_button");
	self overridematerialreset();
	common_scripts\utility::flag_wait("flag_material_swap_gideon_error");
	level.gideon thread maps\finale_fx::exo_release_gideon_error_glow();
	level.gideon overridematerialreset();
	level.gideon overridematerial("mtl_arm_band_ui_glass","m/mtl_arm_band_ui_failure");
}

//Function Number: 94
door_irons_reveal_open(param_00)
{
	var_01 = getent("door_irons_reveal","targetname");
	var_01 soundscripts\_snd::snd_message("aud_irons_reveal_star_trek_door");
	var_02 = getent("org_door_irons_reveal_open","targetname");
	var_01 moveto(var_02.origin,1,0.25,0.25);
}

//Function Number: 95
se_irons_reveal_exo(param_00)
{
	level.player setviewmodel("viewhands_noexo_mitchell_prosthetic_smashed");
	var_01 = getent("org_irons_reveal","targetname");
	var_02 = maps\_utility::spawn_anim_model("exo");
	var_01 maps\_anim::anim_single_solo(var_02,"irons_reveal_exo");
	var_01 thread maps\_anim::anim_loop_solo(var_02,"irons_reveal_exo_idle");
}

//Function Number: 96
se_will_reveal_irons()
{
	common_scripts\utility::flag_wait("flag_se_will_reveal_irons");
	var_00 = getent("org_will_reveal_irons","targetname");
	level.player maps\_shg_utility::setup_player_for_scene(1);
	var_01 = maps\_utility::spawn_anim_model("world_hands");
	var_01 hide();
	var_02 = maps\_utility::spawn_targetname("irons_will_reveal",1);
	var_02.animname = "irons";
	var_02 maps\_utility::gun_remove();
	var_03 = [var_01,var_02];
	level.player playerlinktodelta(var_01,"tag_player",0.1,0,0,0,0,1);
	var_00 thread maps\_anim::anim_first_frame(var_03,"will_reveal_irons");
	var_00 maps\_anim::anim_single(var_03,"will_reveal_irons");
	level.player unlink();
	var_02 delete();
	var_01 delete();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	maps\_utility::activate_trigger_with_targetname("trig_color_wills_room_exit");
	common_scripts\utility::flag_set("flag_will_reveal_irons_complete");
	level.player lerpfov(65,0);
	level.player setorigin((11608,-85516,7600));
	level.player setplayerangles((0,-90,0));
}

//Function Number: 97
se_irons_chase()
{
	thread se_irons_elevator_doors();
	common_scripts\utility::flag_set("second_half_lighting");
	common_scripts\utility::flag_wait("flag_start_irons_chase");
	level.player allowmelee(0);
	maps\_utility::delaythread(2,::maps\_utility::autosave_by_name,"chase_begin");
	if(!isdefined(level.irons))
	{
		level.irons = maps\_utility::spawn_targetname("irons",1);
		level.irons.animname = "irons";
		level.irons.name = "";
		level.irons maps\finale_utility::set_custom_patrol_anim_set("unaware");
		level.irons maps\_utility::gun_remove();
		level.irons thread maps\_utility::deletable_magic_bullet_shield();
	}

	level.irons.team = "axis";
	thread maps\finale_utility::sprint_hint_reminder();
	thread maps\finale_utility::chase_timer_countdown(15,&"FINALE_FAILED_IRONS_CHASE");
	thread maps\finale_utility::player_chase_speed_control();
	setsaveddvar("player_sprintUnlimited",1);
	var_00 = getent("org_irons_run","targetname");
	var_00 maps\_anim::anim_first_frame_solo(level.irons,"irons_run_left_turn_up_stairs");
	common_scripts\utility::flag_wait("flag_irons_start_running_01");
	thread maps\finale_utility::chase_timer_countdown(8,&"FINALE_FAILED_IRONS_CHASE");
	var_00 maps\_anim::anim_single_solo(level.irons,"irons_run_left_turn_up_stairs");
	var_01 = getent("org_irons_end","targetname");
	var_00 stopanimscripted();
	var_01 stopanimscripted();
	var_02 = getent("door_irons_chase_se","targetname");
	var_02.animname = "keypad_door";
	var_02 maps\_utility::assign_animtree();
	var_03 = getent("clip_door_irons_chase_se","targetname");
	var_00 maps\_anim::anim_first_frame_solo(var_02,"irons_run_to_keypad_door");
	var_00 maps\_anim::anim_first_frame_solo(level.irons,"irons_run_to_elevator_full");
	common_scripts\utility::flag_wait("flag_irons_start_running_02");
	thread maps\finale_utility::chase_timer_countdown(15,&"FINALE_FAILED_IRONS_CHASE");
	thread maps\finale_utility::lowering_door_think(23,"door_irons_chase","clip_door_irons_chase","origin_door_irons_chase","flag_start_door_lowering","trig_door_path_check");
	soundscripts\_snd::snd_message("irons_keypad_door_open",var_02);
	var_00 thread maps\_anim::anim_single_solo(var_02,"irons_run_to_keypad_door");
	var_00 thread maps\_anim::anim_single_solo(level.irons,"irons_run_to_elevator_full");
	wait(9);
	if(!common_scripts\utility::flag("flag_se_bridge_takedown"))
	{
		common_scripts\utility::flag_set("flag_irons_passed_final_run_start");
	}
}

//Function Number: 98
se_irons_elevator_doors()
{
	var_00 = getent("fin_balcony_elevator_door_01","targetname");
	var_00.animname = "elevator_doors";
	var_00 maps\_utility::assign_animtree();
	var_01 = common_scripts\utility::getstruct("se_balcony_finale","script_noteworthy");
	var_01 maps\_anim::anim_first_frame_solo(var_00,"balcony_finale_pt1_fail_elevator_close");
}

//Function Number: 99
se_bridge_takedown()
{
	common_scripts\utility::flag_wait("flag_irons_rooftop");
	var_00 = getent("org_bridge_takedown","targetname");
	var_01 = maps\_utility::spawn_targetname("guy_bridge_takedown",1);
	var_01.animname = "guy_bridge_takedown";
	var_01.ignoreme = 1;
	var_01.ignoreall = 1;
	self.allowdeath = 1;
	var_01 maps\_utility::place_weapon_on("iw5_hbra3_sp","right");
	var_01 laseroff();
	var_02 = maps\_utility::spawn_anim_model("world_body_damaged_no_exo");
	var_02 hide();
	var_03 = [var_02,var_01];
	var_00 thread maps\_anim::anim_first_frame(var_03,"bridge_takedown");
	common_scripts\utility::flag_wait("flag_se_bridge_takedown");
	soundscripts\_snd::snd_message("fin_skybridge_takedown_start");
	var_04 = getent("trig_irons_passed_final_run_start","targetname");
	var_04 common_scripts\utility::trigger_off();
	maps\finale_utility::chase_timer_cancel();
	var_05 = 0.31;
	level.player maps\_shg_utility::setup_player_for_scene(0);
	level.player playerlinktoblend(var_02,"tag_player",var_05);
	level.player common_scripts\utility::delaycall(var_05,::playerlinktodelta,var_02,"tag_player",1,0,0,0,0,1);
	var_02 common_scripts\utility::delaycall(var_05,::show);
	var_00 thread maps\_anim::anim_single(var_03,"bridge_takedown");
	wait(0.5);
	thread maps\finale_utility::enable_takedown_hint(var_01,175,1,"flag_se_bridge_takedown_success",2);
	common_scripts\utility::flag_wait("flag_bridge_takedown_jump_complete");
	if(common_scripts\utility::flag("flag_se_bridge_takedown_success"))
	{
		common_scripts\utility::flag_set("flag_disable_takedown_hint");
		if(isdefined(level.takedown_button))
		{
			level.takedown_button maps\_shg_utility::hint_button_clear();
		}

		level.player_knife = maps\_utility::spawn_anim_model("player_knife");
		level.player_knife hide();
		var_03 = common_scripts\utility::array_add(var_03,level.player_knife);
		var_00 thread maps\_anim::anim_single(var_03,"bridge_takedown_success");
		var_06 = var_02 maps\_utility::getanim("bridge_takedown_success");
		var_07 = getanimlength(var_06);
		var_08 = getnotetracktimes(var_06,"ease_out")[0] * var_07;
		var_09 = 0;
		while(var_09 < var_07)
		{
			if(var_09 >= var_08 && level.player getnormalizedmovement()[0] > 0.5)
			{
				break;
			}

			wait 0.05;
			var_09 = var_09 + 0.05;
		}

		level.player forcesprint();
		var_01 delete();
		level.player maps\_shg_utility::setup_player_for_gameplay();
		level.player disableoffhandweapons();
		level.player takeweapon("iw5_unarmedfinale_nullattach");
		level.player giveweapon("iw5_unarmedfinaleknife");
		level.player switchtoweapon("iw5_unarmedfinaleknife");
		level.player unlink();
		level.player show();
		var_02 delete();
		level.player_knife delete();
		thread rooftop_glass_explode();
		wait(0.5);
		common_scripts\utility::flag_clear("flag_player_speed_control_on");
		thread se_balcony_finale_player_speed();
		return;
	}

	common_scripts\utility::flag_set("flag_disable_takedown_hint");
	if(isdefined(level.takedown_button))
	{
		level.takedown_button maps\_shg_utility::hint_button_clear();
	}

	maps\_utility::delaythread(1,::maps\_utility::slowmo_lerp_out);
	soundscripts\_snd::snd_message("bridge_takedown_fail");
	var_00 maps\_anim::anim_single(var_03,"bridge_takedown_fail");
	setdvar("ui_deadquote","");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 100
rooftop_glass_explode()
{
	var_00 = getentarray("org_rooftop_glass_explode","targetname");
	wait(0.25);
	level notify("vfx_rooftop_glass_explode");
	soundscripts\_snd::snd_message("fin_skybridge_glass_explo");
	earthquake(0.4,1.5,level.player.origin,1000);
	foreach(var_02 in var_00)
	{
		glassradiusdamage(var_02.origin,256,110,25);
	}
}

//Function Number: 101
se_balcony_finale()
{
	thread se_balcony_finale_balcony();
	common_scripts\utility::flag_wait("flag_se_bridge_takedown");
	thread maps\finale_lighting::mb_surprise();
	if(!common_scripts\utility::flag("flag_irons_passed_final_run_start"))
	{
		thread se_balcony_finale_player();
		thread se_balcony_finale_irons();
	}
}

//Function Number: 102
se_link_player_to_rig(param_00,param_01)
{
	level.player playerlinktodelta(param_00,"tag_player",1,10,10,5,0,0,0);
	level.player springcamenabled(2.2,0.5);
	level.ground_ref = spawn("script_origin",(0,0,0));
	level.ground_ref.angles = level.player getplayerangles();
	level.ground_ref linkto(level.player_rig,"tag_player");
	level.player playersetgroundreferenceent(level.ground_ref);
	level.player enableslowaim(0.5,0.5);
}

//Function Number: 103
se_balcony_reveal_head_sway()
{
	level endon("dofpart5");
	level waittill("dofpart3");
	for(;;)
	{
		screenshake(level.player.origin,5,7,4,2,0.2,0.2,0,0.3,0.375,0.225);
		wait(1);
	}
}

//Function Number: 104
se_player_rig_move_to_irons(param_00,param_01)
{
	var_02 = self.origin;
	var_03 = param_00 - self.origin;
	var_04 = 0.05;
	while(var_04 < param_01)
	{
		self.origin = var_02 + level.irons.origin - param_00 + var_03 * var_04 / param_01;
		var_05 = level.irons.origin - self.origin;
		if(length2d(var_05) > 20)
		{
			var_06 = angleclamp360(var_05[1],var_05[0]);
			var_07 = var_06 - self.angles[1];
			var_08 = self.angles[1] + var_07 / 4;
			self.angles = (self.angles[0],var_08,self.angles[2]);
		}

		var_04 = var_04 + 0.05;
		wait 0.05;
	}
}

//Function Number: 105
se_balcony_finale_player()
{
	var_00 = 200;
	common_scripts\utility::flag_wait("flag_bridge_takedown_jump_complete");
	var_01 = common_scripts\utility::getstruct("se_balcony_finale","script_noteworthy");
	level.player_rig = maps\_utility::spawn_anim_model("world_body_damaged_no_exo");
	level.player_rig hide();
	soundscripts\_snd::snd_message("fin_skybridge_takedown_plr_attack");
	var_01 maps\_anim::anim_first_frame_solo(level.player_rig,"balcony_finale_pt2");
	common_scripts\utility::flag_wait("flag_balcony_tackle_fake_okay");
	while(distance(level.player.origin,level.irons.origin) > var_00 && !common_scripts\utility::flag("flag_balcony_tackle_too_late"))
	{
		wait 0.05;
	}

	var_02 = level.irons maps\_shg_utility::hint_button_tag("x","J_SpineUpper",72,1000,1);
	var_02.fontscale = 2;
	while(!level.player usebuttonpressed() && !common_scripts\utility::flag("flag_balcony_tackle_too_late"))
	{
		wait 0.05;
	}

	var_02 maps\_shg_utility::hint_button_clear();
	if(common_scripts\utility::flag("flag_balcony_tackle_too_late"))
	{
		var_03 = getent("fin_balcony_elevator_door_01","targetname");
		var_03.animname = "elevator_doors";
		var_03 maps\_utility::assign_animtree();
		var_04 = common_scripts\utility::getstruct("se_balcony_finale","script_noteworthy");
		var_04 thread maps\_anim::anim_single_solo(var_03,"balcony_finale_pt1_fail_elevator_close");
		setdvar("ui_deadquote",&"FINALE_FAILED_IRONS_CHASE");
		maps\_utility::missionfailedwrapper();
		return;
	}

	common_scripts\utility::flag_set("flag_balcony_tackle_started");
	soundscripts\_snd::snd_message("fin_irons_takedown_start");
	soundscripts\_snd::snd_music_message("irons_tackle");
	maps\_utility::delaythread(0.5,::maps\_utility::autosave_now);
	level.player_rig.origin = level.player.origin;
	level.player_rig.angles = level.player.angles;
	thread se_link_player_to_rig(level.player_rig,0.05);
	level.player_rig common_scripts\utility::delaycall(0.3,::show);
	level.player maps\_shg_utility::setup_player_for_scene(0);
	var_05 = level.scr_anim["world_body_damaged_no_exo"]["balcony_finale_pt1"];
	level.player_rig setanim(var_05);
	var_06 = getanimlength(var_05);
	var_07 = level.irons maps\_utility::getanim("balcony_finale_pt1");
	var_08 = getanimlength(var_07);
	var_09 = var_08 - level.irons getanimtime(var_07) * var_08 / 3;
	level.player_rig setanimrate(var_05,var_06 / var_09);
	var_06 = var_09;
	level.player_rig thread se_player_rig_move_to_irons(level.irons.origin,var_06);
	thread maps\_anim::start_notetrack_wait(level.player_rig,"single anim","balcony_finale_pt1","world_body_damaged_no_exo",var_05);
	thread maps\_anim::animscriptdonotetracksthread(level.player_rig,"single anim","balcony_finale_pt1");
	wait(var_06 - 0.1);
	level.player_rig notify("balcony_finale_pt1");
	level.player_rig unlink();
	common_scripts\utility::flag_set("flag_balcony_tackle_success");
	level.player lerpfov(55,2);
	level.player_rig attach("vm_mitchell_finale_knife","tag_weapon_left");
	level notify("dofpart2");
	soundscripts\_snd::snd_message("fin_irons_tackle");
	var_03 maps\_anim::anim_single_solo(level.player_rig,"balcony_finale_pt2");
	soundscripts\_snd::snd_message("finale_qte_show_knife");
	level.player_rig detach("vm_mitchell_finale_knife","tag_weapon_left");
	level.player_rig attach("vm_mitchell_finale_knife","tag_weapon_right");
	var_0A = getanimlength(level.player_rig maps\_utility::getanim("balcony_finale_pt2b_idle"));
	thread maps\finale_utility::process_stab_finale_scene(level.player_rig,"J_Wrist_RI",var_0A,0,var_03);
	var_03 maps\_anim::anim_single_solo(level.player_rig,"balcony_finale_pt2b_idle");
	common_scripts\utility::flag_set("flag_stop_display_melee_hint");
	if(common_scripts\utility::flag("flag_button_melee_success"))
	{
		var_03 maps\_anim::anim_single_solo(level.player_rig,"balcony_finale_pt2b_success");
	}

	level notify("dofpart3");
	level notify("dofpart4");
	maps\_utility::flagwaitthread("flag_xbutton_mash_start",::maps\finale_utility::process_buttonmash_finale_scene,level.player_rig,"J_Wrist_LE",8,var_03);
	maps\_utility::flagwaitthread("flag_stab_mash_button_start",::maps\finale_utility::process_stab_finale_scene,level.player_rig,"J_Wrist_LE",5,0);
	level notify("dof_look_down");
	var_0A = getanimlength(level.player_rig maps\_utility::getanim("balcony_finale_pt3_combined"));
	var_03 maps\_anim::anim_single_solo(level.player_rig,"balcony_finale_pt3_combined");
	level.player_rig detach("vm_mitchell_finale_knife","tag_weapon_right");
	level.player_rig attach("vm_mitchell_finale_knife","tag_weapon_left");
	common_scripts\utility::flag_set("flag_stop_display_melee_hint");
	if(!common_scripts\utility::flag("flag_button_melee_success") && common_scripts\utility::flag("flag_xbutton_mash_end"))
	{
		level.player lightsetforplayer("finale_hang_fail");
		level notify("audio_finale_qte_fail");
		maps\_utility::vision_set_fog_changes("finale_roof_hang_fail",1.5);
		var_03 maps\_anim::anim_single_solo(level.player_rig,"balcony_finale_pt4_fail");
		setdvar("ui_deadquote","");
		maps\_utility::missionfailedwrapper();
		return;
	}

	level notify("dofpart5");
	var_03 thread severed_arm_anim();
	var_03 maps\_anim::anim_single_solo(level.player_rig,"balcony_finale_pt5");
	common_scripts\utility::flag_set("flag_obj_irons_complete");
	level notify("irons_dead");
	level.gideon.ignoreall = 1;
	level.gideon maps\_utility::gun_remove();
	level.player_rig detach("vm_mitchell_finale_knife","tag_weapon_left",0);
	var_0B = [level.player_rig,level.gideon];
	var_0A = getanimlength(level.player_rig maps\_utility::getanim("balcony_finale_end"));
	level.player lerpviewangleclamp(1,0.25,0.5,0,5,5,0);
	level.player enableslowaim(0.2,0.2);
	var_03 thread maps\_anim::anim_single(var_0B,"balcony_finale_end");
	thread balcony_finale_end_camera_control(var_0A);
	maps\_utility::flagwaitthread("flag_ending_start_fade",::maps\finale_utility::screen_fade_out,5);
	wait(var_0A);
	level.gideon maps\_utility::stop_magic_bullet_shield();
	level.gideon delete();
	wait(2);
	common_scripts\utility::flag_set("flag_balcony_finale_success");
}

//Function Number: 106
severed_arm_anim()
{
	var_00 = maps\_utility::spawn_anim_model("severed_arm");
	var_00 hide();
	var_00 setcontents(0);
	thread maps\_anim::anim_single_solo(var_00,"balcony_finale_pt5");
	common_scripts\utility::flag_wait("flag_arm_severed");
	var_00 show();
	common_scripts\utility::flag_wait("flag_obj_irons_complete");
	var_00 delete();
}

//Function Number: 107
balcony_finale_end_camera_control(param_00)
{
	wait(15);
	level.player lerpviewangleclamp(1,0.25,0.5,15,15,15,15);
	wait(16);
	level.player lerpviewangleclamp(5,0.25,0.5,5,5,5,5);
}

//Function Number: 108
se_balcony_finale_player_speed()
{
	while(!common_scripts\utility::flag("flag_balcony_tackle_too_late"))
	{
		var_00 = level.irons.origin[0] - level.player.origin[0];
		if(level.player issprinting())
		{
			var_01 = maps\_shg_utility::linear_map_clamp(var_00,50,250,0.6,1.1);
		}
		else
		{
			var_01 = maps\_shg_utility::linear_map_clamp(var_00,50,250,0.6,1.2);
		}

		level.player setmovespeedscale(var_01);
		wait 0.05;
	}
}

//Function Number: 109
mash_x()
{
}

//Function Number: 110
se_balcony_part1_up_to_tackle(param_00)
{
	level endon("flag_balcony_tackle_started");
	param_00 maps\_anim::anim_single_solo(level.irons,"balcony_finale_pt1");
}

//Function Number: 111
set_when_time_flag_balcony_tackle_fake_okay()
{
	var_00 = getanimlength(level.irons maps\_utility::getanim("balcony_finale_pt1")) - 2.1;
	wait(var_00);
	common_scripts\utility::flag_set("flag_balcony_tackle_fake_okay");
}

//Function Number: 112
set_when_time_flag_balcony_tackle_okay()
{
	var_00 = getanimlength(level.irons maps\_utility::getanim("balcony_finale_pt1")) - 1.3;
	wait(var_00);
	common_scripts\utility::flag_set("flag_balcony_tackle_okay");
}

//Function Number: 113
set_when_time_flag_balcony_tackle_too_late()
{
	var_00 = getanimlength(level.irons maps\_utility::getanim("balcony_finale_pt1")) - 0.1;
	wait(var_00);
	common_scripts\utility::flag_set("flag_balcony_tackle_too_late");
}

//Function Number: 114
se_balcony_finale_irons()
{
	level waittill("noteworthy_start_window");
	if(!isdefined(level.irons))
	{
		level.irons = maps\_utility::spawn_targetname("irons",1);
		level.irons.animname = "irons";
		level.irons.name = "";
		level.irons maps\finale_utility::set_custom_patrol_anim_set("unaware");
		level.irons maps\_utility::gun_remove();
		level.irons thread maps\_utility::deletable_magic_bullet_shield();
		level.irons.ignoreall = 1;
	}

	var_00 = common_scripts\utility::getstruct("se_balcony_finale","script_noteworthy");
	var_00 maps\_anim::anim_first_frame_solo(level.irons,"balcony_finale_pt1");
	thread set_when_time_flag_balcony_tackle_fake_okay();
	thread set_when_time_flag_balcony_tackle_okay();
	thread set_when_time_flag_balcony_tackle_too_late();
	thread maps\finale_lighting::mb_tackle();
	se_balcony_part1_up_to_tackle(var_00);
	if(!common_scripts\utility::flag("flag_balcony_tackle_started"))
	{
		var_00 maps\_anim::anim_single_solo(level.irons,"balcony_finale_pt1_fail");
		level.irons delete();
		return;
	}
	else
	{
		common_scripts\utility::flag_wait("flag_balcony_tackle_success");
	}

	common_scripts\utility::flag_set("flag_balcony_pt2_start");
	var_00 maps\_anim::anim_single_solo(level.irons,"balcony_finale_pt2");
	var_00 maps\_anim::anim_first_frame_solo(level.irons,"balcony_finale_pt3_combined");
	level waittill("dofpart3");
	var_00 maps\_anim::anim_single_solo(level.irons,"balcony_finale_pt3_combined");
	if(!common_scripts\utility::flag("flag_button_melee_success"))
	{
		thread maps\finale_fx::vfx_irons_fail_fall();
		var_00 maps\_anim::anim_single_solo(level.irons,"balcony_finale_pt4_fail");
		level.player lightsetforplayer("finale_hang_fail");
		return;
	}

	var_00 maps\_anim::anim_single_solo(level.irons,"balcony_finale_pt5");
	level.irons delete();
}

//Function Number: 115
se_balcony_finale_balcony()
{
	var_00 = maps\_utility::spawn_anim_model("balcony");
	thread maps\finale_lighting::balcony_lighting(var_00);
	var_01 = common_scripts\utility::getstruct("se_balcony_finale","script_noteworthy");
	var_01 maps\_anim::anim_first_frame_solo(var_00,"balcony_finale_pt2");
	common_scripts\utility::flag_wait("flag_balcony_pt2_start");
	var_01 maps\_anim::anim_single_solo(var_00,"balcony_finale_pt2");
	var_01 maps\_anim::anim_last_frame_solo(var_00,"balcony_finale_pt2");
}

//Function Number: 116
se_irons_end_helo(param_00,param_01,param_02)
{
	param_00 maps\_anim::anim_single_solo(self,param_01);
	param_00 maps\_anim::anim_loop_solo(self,param_02);
}

//Function Number: 117
silo_catwalk_clip(param_00)
{
	var_01 = getentarray("silo_catwalk_blocker_02","targetname");
	foreach(var_03 in var_01)
	{
		var_03 connectpaths();
		var_03 delete();
	}

	var_01 = getentarray("silo_catwalk_blocker_02","targetname");
	foreach(var_03 in var_01)
	{
		var_03 connectpaths();
		var_03 delete();
	}

	var_07 = getnodearray("node_silo_01","targetname");
	foreach(var_09 in var_07)
	{
		var_09 connectnode();
	}

	param_00 common_scripts\utility::show_solid();
}

//Function Number: 118
set_blast_walk_anims()
{
	self.disableexits = 0;
	self.alwaysrunforward = undefined;
	var_00 = ["exposed","exposed_crouch"];
	var_01[1] = %fin_mech_blast_no_shield_react;
	var_01[2] = %fin_mech_blast_no_shield_react;
	var_01[3] = %fin_mech_blast_no_shield_react;
	var_01[4] = %fin_mech_blast_no_shield_react;
	var_01[6] = %fin_mech_blast_no_shield_react;
	var_01[7] = %fin_mech_blast_no_shield_react;
	var_01[8] = %fin_mech_blast_no_shield_react;
	var_01[9] = %fin_mech_blast_no_shield_react;
	var_02[1] = %fin_mech_blast_no_shield_react_idle_to_walk;
	var_02[2] = %fin_mech_blast_no_shield_react_idle_to_walk;
	var_02[3] = %fin_mech_blast_no_shield_react_idle_to_walk;
	var_02[4] = %fin_mech_blast_no_shield_react_idle_to_walk;
	var_02[6] = %fin_mech_blast_no_shield_react_idle_to_walk;
	var_02[7] = %fin_mech_blast_no_shield_react_idle_to_walk;
	var_02[8] = %fin_mech_blast_no_shield_react_idle_to_walk;
	var_02[9] = %fin_mech_blast_no_shield_react_idle_to_walk;
	var_03 = level.archetypes["mech"]["run_turn"];
	var_04["stairs_down"] = %mech_run_stairs_down;
	var_05 = level.archetypes[level.gideon.animarchetype]["start_stop"];
	maps\_utility::set_npc_anims("mech_blastwalk",%fin_mech_blast_no_shield_walk,%fin_mech_blast_no_shield_walk,[%fin_mech_blast_no_shield_react_idle],var_01,var_02,var_00,var_03,var_03,var_04);
	level.archetypes[level.gideon.animarchetype]["start_stop"] = var_05;
}

//Function Number: 119
clear_blast_walk_anims()
{
	maps\_utility::clear_npc_anims("mech_blastwalk");
	self.disableexits = 1;
}

//Function Number: 120
lobby_protect()
{
	if(level.currentgen)
	{
		common_scripts\utility::flag_wait("outro_loaded_successfully");
	}

	common_scripts\utility::flag_clear("first_half_lighting");
	common_scripts\utility::flag_set("second_half_lighting");
	level.player lightsetforplayer("finale_lobby_2");
	maps\_utility::vision_set_fog_changes("finale_lobby",0);
	maps\finale_utility::teleport_to_scriptstruct("checkpoint_lobby");
	thread player_blur_think("flag_lobby_clear");
	var_00 = getnode("node_gideon_lobby_01","targetname");
	level.gideon thread maps\finale_utility::goto_node(var_00,0);
	level.gideon maps\_utility::disable_ai_color();
	level.gideon maps\_utility::set_baseaccuracy(100);
	level.gideon maps\_utility::set_ignoresuppression(1);
	level.player giveweapon("iw5_titan45finalelobby_sp_xmags");
	level.player switchtoweapon("iw5_titan45finalelobby_sp_xmags");
	level.player givestartammo("iw5_titan45finalelobby_sp_xmags");
	level.player setweaponammostock("iw5_titan45finalelobby_sp_xmags",0);
	level.player disableweaponswitch();
	level.player setstance("prone");
	var_01 = getent("org_player_carried_lobby_01","targetname");
	var_02 = getent("org_player_carried_lobby_02","targetname");
	var_03 = getent("org_player_carried_lobby_03","targetname");
	thread maps\_utility::autosave_now();
	thread combat_lobby();
	thread player_accuracy_think();
	maps\_utility::delaythread(2,::common_scripts\utility::flag_set,"flag_lobby_combat_start");
	maps\_utility::delaythread(1,::common_scripts\utility::flag_set,"flag_dialogue_carry_scene_01");
	var_04 = undefined;
	var_05 = getent("org_run_and_putdown","targetname");
	var_06 = undefined;
	var_07 = 0.5;
	level.player thread maps\finale_utility::screen_fade(0,1,0.5);
	var_04 = maps\_utility::spawn_anim_model("world_body_damaged");
	maps\finale_drag::drag_player_from_start_to_end(var_01,var_02,level.gideon,var_04,"drag_run01",var_07);
	level.player thread maps\finale_utility::screen_fade(var_07,2,0.5);
	maps\finale_drag::drag_player_from_start_to_end(var_02,var_03,level.gideon,var_04,"drag_run02",var_07);
	level.player thread maps\finale_utility::screen_fade(var_07,1,0.5);
	wait(var_07);
	wait 0.05;
	level.player maps\_shg_utility::setup_player_for_scene();
	var_06 = [level.gideon,var_04];
	var_05 maps\_anim::anim_single(var_06,"drag_putdown");
	level.player playerlinktodelta(var_04,"TAG_PLAYER",1,40,45,30,10,1,0);
	level.player maps\_shg_utility::setup_player_for_gameplay();
	var_05 thread maps\_anim::anim_loop_solo(level.gideon,"drag_cover","gideon_ender");
	level.player enableweapons();
	level.player allowsprint(0);
	level.player allowprone(1);
	level.player allowcrouch(0);
	level.player allowstand(0);
	level.player allowmelee(0);
	level.player disableoffhandweapons();
	level.player disableoffhandsecondaryweapons();
	level.player disableweaponpickup();
	level.player thread maps\_player_exo::setoverdrive();
	common_scripts\utility::flag_set("flag_lobby_player_can_shoot");
	thread maps\finale_drag::shooting_head_sway();
	common_scripts\utility::flag_wait("flag_lobby_clear");
	level.player maps\_player_exo::unsetoverdrive();
	while(isdefined(level.gideon.pickup_allowed) && !level.gideon.pickup_allowed)
	{
		wait 0.05;
	}

	var_05 notify("gideon_ender");
	soundscripts\_snd::snd_message("fin_lobby_gun_limp");
	maps\finale_anim_vm::anim_single_solo_vm(level.player,"gun_limp");
	soundscripts\_snd::snd_music_message("dazed_and_confused2");
	level.player notify("end_head_sway");
	level.player playerlinktoblend(var_04,"TAG_PLAYER",1.2);
	level.player common_scripts\utility::delaycall(4,::playerlinktodelta,var_04,"TAG_PLAYER",1,10,10,10,10,1,0);
	level.player maps\_shg_utility::setup_player_for_scene();
	level.player giveweapon("iw5_unarmedfinale_nullattach");
	level.player takeweapon("iw5_titan45finalelobby_sp_xmags");
	var_08 = maps\_utility::spawn_anim_model("drag_pistol");
	var_06 = [level.gideon,var_04,var_08];
	var_05 maps\_anim::anim_single(var_06,"drag_pickup02");
	if(isdefined(var_04))
	{
		var_04 delete();
	}
}

//Function Number: 121
player_accuracy_think()
{
	level endon("flag_lobby_clear");
	for(;;)
	{
		var_00 = level.player getcurrentweapon();
		var_01 = level.player getammocount(var_00);
		if(var_01 <= 2 && var_00 != "none")
		{
			var_02 = getaiarray("axis");
			foreach(var_04 in var_02)
			{
				if(isdefined(var_04.script_noteworthy) && var_04.script_noteworthy == "enemy_lobby")
				{
					var_04 thread maps\finale_utility::murder_player_seek();
				}
			}
		}

		wait 0.05;
	}
}

//Function Number: 122
player_blur_think(param_00)
{
	if(isdefined(param_00))
	{
		level endon(param_00);
		thread player_blur_reset(param_00);
	}

	var_01 = randomfloatrange(2,4);
	var_02 = randomfloatrange(0.5,5);
	for(;;)
	{
		if(!level.player maps\_utility::isads())
		{
			thread player_blur_monitor_ads();
			player_blur_non_ads(var_01,var_02);
			continue;
		}

		thread player_blur_monitor_non_ads();
		player_blur_ads();
	}

	wait(0.05);
}

//Function Number: 123
player_blur_non_ads(param_00,param_01)
{
	level endon("player_ads");
	setblur(param_00,param_01);
	wait(param_01);
	setblur(0.5,param_01);
	wait(param_01);
}

//Function Number: 124
player_blur_ads()
{
	level endon("player_ads");
	setblur(0,0.75);
	wait(0.75);
}

//Function Number: 125
player_blur_monitor_non_ads()
{
	level notify("player_ads_end");
	level endon("player_ads_end");
	while(level.player maps\_utility::isads())
	{
		wait(0.05);
	}

	level notify("player_ads");
}

//Function Number: 126
player_blur_monitor_ads()
{
	level notify("player_ads_end");
	level endon("player_ads_end");
	while(!level.player maps\_utility::isads())
	{
		wait(0.05);
	}

	level notify("player_ads");
}

//Function Number: 127
player_blur_reset(param_00)
{
	common_scripts\utility::flag_wait(param_00);
	setblur(0,2);
}

//Function Number: 128
player_carried_skybridge()
{
	level.player lightsetforplayer("finale_lobby");
	maps\_utility::vision_set_fog_changes("finale_sky_bridge",0);
	thread maps\finale_lighting::sky_bridge_dof();
	common_scripts\utility::flag_set("second_half_lighting");
	level.player disableweapons();
	level.player setstance("prone");
	level.player allowstand(0);
	level.player allowcrouch(0);
	level.player takeweapon("iw5_titan45finalelobby_sp_xmags");
	level.player giveweapon("iw5_unarmedfinale_nullattach");
	level.player switchtoweapon("iw5_unarmedfinale_nullattach");
	maps\_utility::delaythread(2,::common_scripts\utility::flag_set,"flag_dialogue_carry_scene_02");
	level.gideon maps\_utility::enable_ai_color();
	level notify("sky_bridge_vfx");
	maps\finale_utility::teleport_to_scriptstruct("checkpoint_sky_bridge");
	var_00 = getent("org_player_carried_01","targetname");
	var_01 = getent("org_player_carried_02","targetname");
	var_02 = getent("org_player_carried_03","targetname");
	var_03 = getent("org_player_carried_04","targetname");
	var_04 = getent("org_player_carried_05","targetname");
	var_05 = getent("org_player_carried_06","targetname");
	thread maps\finale_utility::screen_fade_in(1);
	var_06 = 0.5;
	level.player thread maps\finale_utility::screen_fade(1,1,1);
	var_07 = maps\_utility::spawn_anim_model("world_body_damaged");
	maps\finale_drag::drag_player_from_start_to_end(var_00,var_01,level.gideon,var_07,"drag_run01",1);
	level.player maps\finale_utility::screen_fade(1,1,1);
	maps\finale_drag::drag_player_from_start_to_end(var_02,var_03,level.gideon,var_07,"drag_run01",2);
	level.player maps\finale_utility::screen_fade(2,0.5,2);
	maps\finale_drag::drag_player_from_start_to_end(var_00,var_01,level.gideon,var_07,"drag_run04",0.5);
	level.player maps\finale_utility::screen_fade(0.5,1,1);
	maps\finale_drag::drag_player_from_start_to_end(var_02,var_03,level.gideon,var_07,"drag_run02",2);
	level.player maps\finale_utility::screen_fade(2,1,4);
	maps\finale_drag::drag_player_from_start_to_end(var_02,var_03,level.gideon,var_07,"drag_run01",2);
	maps\finale_utility::screen_fade_out(2);
	var_07 delete();
}

//Function Number: 129
will_room_door_exit()
{
	var_00 = getent("org_irons_reveal_exit_door","targetname");
	var_01 = maps\_utility::spawn_anim_model("door");
	var_00 thread maps\_anim::anim_first_frame_solo(var_01,"irons_reveal_exit_door");
	common_scripts\utility::flag_wait("flag_will_room_door_exit_open");
	soundscripts\_snd::snd_message("irons_reveal_exit_door_open",var_01);
	var_00 thread maps\_anim::anim_single_solo(var_01,"irons_reveal_exit_door");
}

//Function Number: 130
irons_rooftop()
{
	common_scripts\utility::flag_wait("flag_irons_rooftop");
	level.irons = maps\_utility::spawn_targetname("irons",1);
	level.irons.animname = "irons";
	level.irons.name = "";
	level.irons maps\finale_utility::set_custom_patrol_anim_set("unaware");
	level.irons maps\_utility::gun_remove();
	level.irons thread maps\_utility::magic_bullet_shield();
	common_scripts\utility::flag_set("flag_se_irons_end");
}

//Function Number: 131
razorback_spotlight_init()
{
	maps\_vehicle::godon();
	maps\_vehicle::mgoff();
	maps\_utility::ent_flag_init("spotlight_on");
	self.spotlight = spawnturret("misc_turret",self gettagorigin("tag_flash"),"heli_spotlight_so_castle");
	self.spotlight setmode("manual");
	self.spotlight setmodel("com_blackhawk_spotlight_on_mg_setup");
	self.spotlight maketurretinoperable();
	self.spotlight makeunusable();
	self.spotlight.angles = self gettagangles("tag_flash");
	self.spotlight linkto(self,"tag_flash",(-16,-119,-28),(-45,0,0));
	thread spotlight_think();
	self setlookatent(level.irons);
	thread razorback_spotlight();
}

//Function Number: 132
razorback_spotlight()
{
	common_scripts\utility::flag_wait("flag_razorback_spotlight_on");
	maps\_utility::ent_flag_set("spotlight_on");
}

//Function Number: 133
spotlight_think()
{
	self endon("death");
	self notify("stop_helo_spotlight");
	self endon("stop_helo_spotlight");
	thread spotlight_light_motion();
	var_00 = 0;
	for(;;)
	{
		if(!maps\_utility::ent_flag("spotlight_on"))
		{
			if(var_00)
			{
				var_00 = 0;
				stopfxontag(common_scripts\utility::getfx("docks_heli_spotlight"),self.spotlight,"tag_flash");
				stopfxontag(common_scripts\utility::getfx("lab_heli_spot_flare"),self.spotlight,"tag_flash");
			}

			var_01 = level.player;
			if(isdefined(var_01))
			{
				self.spotlight settargetentity_smoothtracking(var_01);
			}

			wait(0.2);
			continue;
		}

		wait(0.5);
		if(!var_00)
		{
			var_00 = 1;
			playfxontag(common_scripts\utility::getfx("docks_heli_spotlight"),self.spotlight,"tag_flash");
			playfxontag(common_scripts\utility::getfx("lab_heli_spot_flare"),self.spotlight,"tag_flash");
		}
	}
}

//Function Number: 134
spotlight_light_motion()
{
	self endon("stop_helo_spotlight");
	self endon("death");
	for(;;)
	{
		var_00 = undefined;
		if(isdefined(self.override_target))
		{
			self.spotlight settargetentity_smoothtracking(self.override_target);
			while(isdefined(self.override_target))
			{
				wait(0.5);
			}

			continue;
		}
		else
		{
			var_01 = [level.player,level.irons];
			var_00 = level.irons;
			if(isdefined(var_00))
			{
				self.spotlight settargetentity_smoothtracking(var_00);
			}
		}

		if(isdefined(var_00) && isai(var_00))
		{
			if(!isdefined(var_00) || !isalive(var_00))
			{
				break;
			}

			wait(0.1);
			continue;
		}

		wait(randomfloatrange(3,5));
	}
}

//Function Number: 135
settargetentity_smoothtracking(param_00)
{
	self.real_target = param_00;
	if(isdefined(param_00))
	{
		if(!isdefined(self.spotlight_target))
		{
			self.spotlight_target = common_scripts\utility::spawn_tag_origin();
		}

		self.spotlight_target.origin = param_00.origin;
		self.spotlight_target linkto(self);
		self settargetentity(self.spotlight_target);
	}
}

//Function Number: 136
tff_cleanup_vehicle(param_00)
{
	var_01 = "";
	switch(param_00)
	{
		case "intro":
			var_01 = "load_middle_transient";
			break;

		case "middle":
			var_01 = "load_outro_transient";
			break;
	}

	if(var_01 == "")
	{
		return;
	}

	common_scripts\utility::flag_wait(var_01);
	if(!isdefined(self))
	{
		return;
	}

	if(isremovedentity(self))
	{
		return;
	}

	if(!common_scripts\utility::string_find(self.classname,"corpse"))
	{
		maps\_vehicle_code::_freevehicle();
	}

	self delete();
}

//Function Number: 137
silo_autosaves()
{
	level endon("flag_exhaust_hatch_open");
	level.stopwatch = 240;
	var_00 = level.stopwatch * 1000;
	var_01 = gettime();
	var_02 = gettime() - var_01 / 1000;
	var_03 = level.stopwatch - 180;
	thread silo_autosaves_safety(var_02,var_03);
	common_scripts\utility::flag_wait("flag_lower_missile_loader");
	var_02 = gettime() - var_01 / 1000;
	var_03 = level.stopwatch - 120;
	thread silo_autosaves_safety(var_02,var_03);
	common_scripts\utility::flag_wait("flag_se_door_kick_complete");
	var_02 = gettime() - var_01 / 1000;
	var_03 = level.stopwatch - 30;
	thread silo_autosaves_safety(var_02,var_03);
}

//Function Number: 138
silo_autosaves_safety(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(param_00 < param_01)
	{
		maps\_utility::autosave_or_timeout("silo_clear",param_01 - param_00);
		if(param_02)
		{
			wait(3);
		}
		else
		{
			wait(10);
		}

		common_scripts\utility::flag_clear("can_save");
		wait(2);
		common_scripts\utility::flag_set("can_save");
	}
}

//Function Number: 139
rope_link(param_00,param_01,param_02,param_03)
{
	var_04 = param_00 gettagorigin(param_01);
	var_05 = spawn("script_model",var_04);
	var_05 setmodel("rope1ft_2j");
	var_05 useanimtree(#animtree);
	var_05 setanim(%rope_base,1,0);
	var_05 setanim(%rope_length,1,0);
	var_05 linkto(param_00,param_01);
	var_05 setlookattarget(param_02,"bone",param_03);
	for(;;)
	{
		var_06 = param_00 gettagorigin(param_01);
		var_07 = param_02 gettagorigin(param_03);
		var_08 = var_07 - var_06;
		var_09 = length(var_08);
		var_0A = var_09 - 12 / 88;
		if(var_0A < 0)
		{
			var_0A = 0;
		}

		var_05 setanim(%rope_length_add,var_0A,0);
		if(level common_scripts\utility::flag("flag_intro_flyin_release"))
		{
			var_05 clearlookattarget();
			var_05 delete();
			return;
		}

		wait 0.05;
	}
}