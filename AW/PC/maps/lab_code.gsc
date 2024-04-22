/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: lab_code.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 388
 * Decompile Time: 5692 ms
 * Timestamp: 4/22/2024 2:32:54 AM
*******************************************************************/

//Function Number: 1
setup_spawn_functions()
{
	maps\_utility::array_spawn_function_noteworthy("enemy_research_building_wave_01",::research_building_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_research_building_wave_02",::research_building_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_pool_building_wave_01",::pool_building_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_research_bridge_wave_01",::facility_bridge_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_pool_building_walkway_wave_01",::pool_building_walkway_01_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_pool_building_walkway_wave_02",::pool_building_walkway_01_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_research_left_01",::research_left_01_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_research_left_lower_01",::research_left_lower_01_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_research_right_lower_01",::research_right_lower_01_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_platform_01",::research_platform_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_research_right_01",::research_right_01_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_pool_building_wave_02",::pool_building_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_courtyard_initial",::courtyard_enemy_initial_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_courtyard_jammer",::courtyard_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_courtyard_jammer_complete",::courtyard_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_courtyard_jammer_ladder",::courtyard_jammer_ladder_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_courtyard_sniper_fodder",::courtyard_enemy_sniper_fodder_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_foam_corridor_b",::foam_corridor_enemy_think);
	maps\_utility::array_spawn_function_targetname("combat_courtyard_general_01",::combat_courtyard_general_01_think);
	maps\_utility::array_spawn_function_targetname("combat_courtyard_path_left_00",::combat_courtyard_path_left_00_think);
	maps\_utility::array_spawn_function_targetname("combat_courtyard_path_left_01",::combat_courtyard_path_left_01_think);
	maps\_utility::array_spawn_function_targetname("combat_courtyard_path_left_02",::combat_courtyard_path_left_02_think);
	maps\_utility::array_spawn_function_targetname("combat_courtyard_path_left_03",::combat_courtyard_path_left_03_think);
	maps\_utility::array_spawn_function_targetname("combat_courtyard_path_middle_01",::combat_courtyard_path_middle_01_think);
	maps\_utility::array_spawn_function_targetname("combat_courtyard_path_middle_02",::combat_courtyard_path_middle_02_think);
	maps\_utility::array_spawn_function_targetname("combat_courtyard_path_middle_03",::combat_courtyard_path_middle_03_think);
	maps\_utility::array_spawn_function_targetname("combat_courtyard_path_right_01",::combat_courtyard_path_right_01_think);
	maps\_utility::array_spawn_function_targetname("combat_courtyard_path_right_02",::combat_courtyard_path_right_02_think);
	maps\_utility::array_spawn_function_targetname("combat_courtyard_path_right_03",::combat_courtyard_path_right_03_think);
	maps\_utility::array_spawn_function_noteworthy("guy_01_seeker",::patrol_01_unload_spawn_func);
	maps\_utility::array_spawn_function_noteworthy("guy_02_seeker",::patrol_02_unload_spawn_func);
	maps\_utility::array_spawn_function_noteworthy("guy_03_seeker",::patrol_03_unload_spawn_func);
	maps\_utility::array_spawn_function_noteworthy("guy_04_seeker",::patrol_04_unload_spawn_func);
	maps\_utility::array_spawn_function_noteworthy("enemy_stealth_patrol_01",::set_flag_on_death,"flag_patroler_01_clear_a","flag_patroler_takedown_02_follow_a","flag_patroler_takedown_02_follow_b","flag_patroler_takedown_02_ready");
	maps\_utility::array_spawn_function_noteworthy("enemy_stealth_patrol_02",::set_flag_on_death,"flag_patroler_01_clear_b","flag_patrol_02_clear_for_vehicle_takedown");
	maps\_utility::array_spawn_function_noteworthy("combat_mech_march_05",::set_flag_on_death,"flag_mech_march_hide_right_complete","flag_mech_march_hide_right");
	maps\_utility::array_spawn_function_noteworthy("enemy_post_breach_patrol_01",::set_flag_on_death,"flag_breach_patrol_01_clear","flag_breach_patrol_01_dead");
	maps\_utility::array_spawn_function_noteworthy("enemy_post_breach_patrol_02",::set_flag_on_death,"flag_breach_patrol_02_dead");
	maps\_utility::array_spawn_function_noteworthy("combat_mech_march_follower",::mech_march_follower_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("combat_mech_march_runner",::mech_march_runner_enemy_think);
	common_scripts\utility::array_thread(getentarray("trigger_set_and_clear_flag","script_noteworthy"),::maps\lab_utility::trigger_set_and_clear_flag_think);
	maps\_utility::add_global_spawn_function("axis",::add_drone_to_squad);
	common_scripts\utility::array_thread(getentarray("helo_spotlight_shoot_trigger","script_noteworthy"),::helo_spotlight_shoot_trigger_think);
	common_scripts\utility::array_thread(getentarray("camera_scanner_interior_trigger","script_noteworthy"),::maps\lab_vo::camera_scanner_interior_trigger_think);
}

//Function Number: 2
player_damage_check()
{
	for(;;)
	{
		level.player waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08);
		iprintlnbold("Damage Type: " + var_04);
		wait 0.05;
	}
}

//Function Number: 3
spawn_ai_flashlight()
{
	maps\_flashlight_cheap::add_cheap_flashlight();
}

//Function Number: 4
equip_player()
{
	setsaveddvar("bg_viewBobAmplitudeStanding","0.007 0.007");
	maps\_variable_grenade::give_player_variable_grenade();
	maps\_player_exo::player_exo_add_single("exo_melee");
	if(common_scripts\utility::flag("flag_obj_bio_weapons_hack"))
	{
		thread maps\_cloak::disable_cloak_system();
	}
}

//Function Number: 5
debug_start_equip_player()
{
	level.player takeweapon("iw5_unarmed_nullattach");
	level.player giveweapon("iw5_hbra3_sp_silencer01_variablereddot");
	level.player givemaxammo("iw5_hbra3_sp_silencer01_variablereddot");
	level.player switchtoweapon("iw5_hbra3_sp_silencer01_variablereddot");
}

//Function Number: 6
equip_player_smg()
{
	setsaveddvar("bg_viewBobAmplitudeStanding","0.007 0.007");
	level.player takeweapon("iw5_unarmed_nullattach");
	level.player giveweapon("iw5_hbra3_sp");
	level.player switchtoweapon("iw5_hbra3_sp");
}

//Function Number: 7
lab_intro_screen()
{
	level.player disableweapons();
	level.player freezecontrols(1);
	var_00 = 8.4;
	thread maps\_shg_utility::play_chyron_video("chyron_text_biolab",8.4);
	common_scripts\utility::flag_wait("chyron_video_done");
	soundscripts\_snd::snd_message("aud_lab_intro_screen");
	wait(var_00);
	common_scripts\utility::flag_set("flag_escape_the_sniper_obj_give");
	common_scripts\utility::flag_set("lab_intro_screen_complete");
	soundscripts\_snd::snd_message("hud_malfunction");
}

//Function Number: 8
startcloakingbinksequence()
{
	common_scripts\utility::flag_wait("lab_intro_screen_complete");
	setsaveddvar("cg_cinematicfullscreen","0");
	common_scripts\utility::flag_wait("flag_burke_dive_over_log");
	common_scripts\utility::flag_wait("flag_player_enters_forest");
	stopcinematicingame();
	cinematicingame("cloaking_hud_reboot");
	common_scripts\utility::flag_wait("flag_player_cloak_on");
	stopcinematicingame();
	cinematicingame("cloaking_hud_ready");
	common_scripts\utility::flag_wait("flag_player_cloak_on_pressed");
	stopcinematicingame();
}

//Function Number: 9
startcloakingbinksequence_debug()
{
	setsaveddvar("cg_cinematicfullscreen","0");
	common_scripts\utility::flag_wait("flag_player_enters_forest");
	stopcinematicingame();
	cinematicingame("cloaking_hud_reboot");
	common_scripts\utility::flag_wait("flag_player_cloak_on");
	stopcinematicingame();
	cinematicingame("cloaking_hud_ready");
	common_scripts\utility::flag_wait("flag_player_cloak_on_pressed");
	stopcinematicingame();
}

//Function Number: 10
player_movement_tweaks()
{
	maps\_utility::player_speed_percent(80,1);
	level.player takeweapon("fraggrenade");
	level.player takeweapon("flash_grenade");
	setsaveddvar("bg_viewbobamplitudestanding","0.03 0.02");
	setsaveddvar("player_sprintunlimited","1");
	common_scripts\utility::flag_wait("flag_player_enters_forest");
	setsaveddvar("player_sprintunlimited","0");
	common_scripts\utility::flag_wait("flag_forest_climb_wall_complete");
	maps\_utility::player_speed_percent(100,1);
}

//Function Number: 11
helo_spotlight_init()
{
	if(isdefined(level.start_point) && level.start_point == "forest_start")
	{
		var_00 = getent("helo_spotlight","targetname");
		var_00.origin = common_scripts\utility::getstruct("path_helo_river_path_start","targetname").origin;
	}

	level.helo_spotlight = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("helo_spotlight");
	level.helo_spotlight maps\_vehicle::godon();
	level.helo_spotlight maps\_utility::ent_flag_init("spotlight_on");
	level.helo_spotlight soundscripts\_snd::snd_message("aud_helo_spotlight_spawn");
	level.helo_spotlight.spotlight = spawnturret("misc_turret",level.helo_spotlight gettagorigin("tag_flash"),"heli_spotlight_so_castle");
	level.helo_spotlight.spotlight setmode("manual");
	level.helo_spotlight.spotlight setmodel("com_blackhawk_spotlight_on_mg_setup");
	level.helo_spotlight.spotlight maketurretinoperable();
	level.helo_spotlight.spotlight makeunusable();
	level.helo_spotlight.spotlight.angles = level.helo_spotlight gettagangles("tag_flash");
	level.helo_spotlight.spotlight linkto(level.helo_spotlight,"tag_flash",(0,2,-6),(0,90,-20));
	level.helo_spotlight thread helo_spotlight_think();
	level.helo_spotlight setlookatent(level.burke);
	level.helo_spotlight maps\_vehicle::mgoff();
	common_scripts\utility::flag_wait("flag_helo_spotlight_on");
	level.helo_spotlight maps\_utility::ent_flag_set("spotlight_on");
}

//Function Number: 12
helo_spotlight_handle_intro_rumbles()
{
	maps\lab_utility::setup_level_rumble_ent();
	wait(0.9);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.6,0.2);
	wait(1.3);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.4,0.2);
	wait(3);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.2,0.2);
	wait(3);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.4,0.2);
	wait(4.3);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.4,1.75);
}

//Function Number: 13
helo_spotlight_movement()
{
	common_scripts\utility::flag_wait("flag_helo_spotlight_path_02");
	level.helo_spotlight maps\_utility::vehicle_detachfrompath();
	var_00 = common_scripts\utility::getstruct("path_helo_spotlight_02_start","targetname");
	level.helo_spotlight thread maps\_utility::vehicle_dynamicpath(var_00,0);
	common_scripts\utility::flag_wait("flag_helo_spotlight_path_03");
	level.helo_spotlight maps\_utility::vehicle_detachfrompath();
	level.helo_spotlight vehicle_setspeed(60,30,25);
	var_00 = common_scripts\utility::getstruct("path_helo_spotlight_03_start","targetname");
	level.helo_spotlight thread maps\_utility::vehicle_dynamicpath(var_00,0);
	common_scripts\utility::flag_wait("flag_player_enters_forest");
	level.helo_spotlight thread helo_spotlight_forest_think();
	level.helo_spotlight maps\_utility::vehicle_detachfrompath();
	var_00 = common_scripts\utility::getstruct("path_helo_river_path_start","targetname");
	level.helo_spotlight thread maps\_utility::vehicle_dynamicpath(var_00,0);
	common_scripts\utility::flag_wait("flag_helo_arrived_at_crash");
	level.helo_spotlight maps\_utility::vehicle_land();
	level.helo_spotlight.spotlight delete();
	level.helo_spotlight delete();
}

//Function Number: 14
helo_spotlight_think(param_00)
{
	self endon("death");
	self notify("stop_helo_spotlight");
	self endon("stop_helo_spotlight");
	thread helo_spotlight_light_motion();
	var_01 = 0;
	var_02 = "docks_heli_spotlight";
	if(isdefined(param_00))
	{
		var_02 = param_00;
	}

	for(;;)
	{
		if(!maps\_utility::ent_flag("spotlight_on"))
		{
			if(var_01)
			{
				var_01 = 0;
				stopfxontag(common_scripts\utility::getfx(var_02),self.spotlight,"tag_flash");
				stopfxontag(common_scripts\utility::getfx("lab_heli_spot_flare"),self.spotlight,"tag_flash");
			}

			var_03 = level.player;
			if(isdefined(var_03))
			{
				self.spotlight settargetentity_smoothtracking(var_03);
			}

			wait(0.2);
			continue;
		}

		wait(0.5);
		if(!var_01)
		{
			var_01 = 1;
			playfxontag(common_scripts\utility::getfx(var_02),self.spotlight,"tag_flash");
			playfxontag(common_scripts\utility::getfx("lab_heli_spot_flare"),self.spotlight,"tag_flash");
		}
	}
}

//Function Number: 15
helo_spotlight_light_motion()
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
			var_01 = [level.player,level.burke];
			var_00 = level.burke;
			if(isdefined(var_00) && !common_scripts\utility::flag("flag_player_enters_forest"))
			{
				self.spotlight settargetentity_smoothtracking(var_00);
			}
			else
			{
			}
		}

		if(isdefined(var_00) && isai(var_00))
		{
			var_02 = randomfloatrange(1,2.5) * 1000;
			var_03 = gettime() + var_02;
			while(gettime() < var_03)
			{
				if(!isdefined(var_00) || !isalive(var_00))
				{
					break;
				}

				wait(0.1);
			}

			continue;
		}

		wait(randomfloatrange(3,5));
	}
}

//Function Number: 16
helo_spotlight_climbing_moment(param_00,param_01)
{
	var_02 = gettime() / 1000;
	var_03 = 100;
	while(!common_scripts\utility::flag("flag_player_wall_look_right"))
	{
		var_04 = 1 - gettime() / 1000 - var_02 / param_00;
		param_01.origin = level.player.origin + (1000 * var_04 + var_03,0,0);
		wait(0.05);
	}

	while(common_scripts\utility::flag("flag_player_wall_look_right"))
	{
		var_04 = 1 - gettime() / 1000 - var_02 / param_00;
		param_01.origin = level.player.origin + (500 * var_04 + var_03,0,0);
		wait(0.05);
	}

	while(!common_scripts\utility::flag("flag_player_cloak_on_pressed"))
	{
		var_04 = 1 - gettime() / 1000 - var_02 / param_00;
		param_01.origin = level.player.origin + (1000 * var_04 + var_03,0,0);
		wait(0.05);
	}
}

//Function Number: 17
helo_spotlight_forest_think()
{
	level endon("helo_spotlight_point_of_no_return");
	self clearlookatent();
	self.spotlight settargetentity_smoothtracking(undefined);
	self.spotlight noisy_turret_clear_default_angles();
	var_00 = 20;
	var_01 = gettime() / 1000;
	thread helo_spotlight_kill_player_unless_notify(var_00,"player_climbing_wall");
	var_02 = spawn("script_origin",level.player.origin);
	self.override_target = var_02;
	level thread maps\_utility::notify_delay("helo_spotlight_stop_search",15);
	helo_spotlight_search_for_player(var_02);
	var_03 = 200;
	var_02.origin = level.player.origin + (1500 + var_03,0,0);
	while(!common_scripts\utility::flag("player_climbing_wall"))
	{
		var_04 = 1 - gettime() / 1000 - var_01 / var_00;
		var_02.origin = level.player.origin + (1500 * var_04 + var_03,0,0);
		wait(0.05);
	}

	var_00 = 20;
	thread helo_spotlight_kill_player_unless_notify(var_00,"flag_player_climb_succeeded");
	thread helo_spotlight_climbing_moment(var_00,var_02);
	common_scripts\utility::flag_wait("flag_player_climb_succeeded");
	var_00 = 15;
	thread helo_spotlight_kill_player_unless_notify(var_00,"flag_player_cloak_on_pressed");
	common_scripts\utility::flag_wait("flag_player_cloak_on_pressed");
	var_04 = 0;
	var_01 = gettime() / 1000;
	var_00 = 20;
	var_03 = 215;
	while(var_04 < 1)
	{
		var_04 = gettime() / 1000 - var_01 / var_00;
		var_02.origin = level.player.origin + (-1000 * var_04 + var_03,0,0);
		wait(0.05);
	}

	self.override_target = undefined;
	self notify("stop_helo_spotlight");
	self.spotlight.real_target = undefined;
	self.spotlight noisy_turret_set_default_angles((25,-90,-20));
}

//Function Number: 18
helo_spotlight_search_for_player(param_00)
{
	level endon("helo_spotlight_stop_search");
	level endon("player_climbing_wall");
	var_01 = 0.5;
	var_02 = 1;
	var_03 = common_scripts\utility::getstructarray("helo_spotlight_search_loc","targetname");
	for(;;)
	{
		param_00.origin = var_03[randomint(var_03.size)].origin;
		self.spotlight common_scripts\utility::waittill_notify_or_timeout("turret_on_target",1);
		wait(randomfloatrange(var_01,var_02));
	}
}

//Function Number: 19
helo_spotlight_kill_player_unless_notify(param_00,param_01)
{
	level endon(param_01);
	wait(param_00);
	level notify("helo_spotlight_point_of_no_return");
	self.override_target.origin = level.player geteye();
	var_02 = getent("climb_wall_use_trigger","targetname");
	if(isdefined(var_02))
	{
		var_02 delete();
	}

	level.player endon("death");
	level.player enablehealthshield(0);
	if(common_scripts\utility::flag("player_climbing_wall"))
	{
		thread knock_player_off_wall();
	}

	for(;;)
	{
		helo_spotlight_shoot_location(level.player geteye() + (randomintrange(-10,10),randomintrange(-10,10),randomintrange(-10,10)));
		level.player dodamage(level.player.maxhealth / 3,level.helo_spotlight.origin,level.helo_spotlight);
		wait(randomfloatrange(0.5,1));
	}
}

//Function Number: 20
knock_player_off_wall()
{
	common_scripts\utility::flag_set("flag_cloak_fail_kill_player");
	level.player waittill("death");
	level notify("player_falling_to_death");
	earthquake(0.2,3,level.player.origin,8000);
	var_00 = 0.4;
	var_01 = spawn("script_origin",level.player.origin);
	var_01.angles = level.player getgunangles();
	var_01 moveto(common_scripts\utility::getstruct("obj_forest_climb_wall_fall_loc","targetname").origin,var_00,var_00);
	level.player playerlinktoblend(var_01,undefined,var_00);
	level.player_rig delete();
	wait(var_00);
	level.player unlink();
}

//Function Number: 21
player_falling_kill_logic(param_00)
{
	var_01 = int(tablelookup("sp/deathquotetable.csv",1,"size",0));
	var_02 = randomint(var_01);
	if(!isdefined(param_00))
	{
		param_00 = 3;
	}

	common_scripts\utility::flag_clear("can_save");
	var_03 = gettime() + param_00 * 1000;
	while(!level.player isonground() && gettime() < var_03)
	{
		wait(0.05);
	}

	if(level.player isonground())
	{
		level.player kill();
		return;
	}

	maps\_utility::missionfailedwrapper();
}

//Function Number: 22
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
		thread noisy_turret_think();
	}
}

//Function Number: 23
noisy_turret_set_default_angles(param_00)
{
	self.no_target_local_spotlight_angles = param_00;
}

//Function Number: 24
noisy_turret_clear_default_angles()
{
	self.no_target_local_spotlight_angles = undefined;
}

//Function Number: 25
noisy_turret_think()
{
	self notify("stop_noisy_turret_think");
	self endon("stop_noisy_turret_think");
	self endon("death");
	if(!isdefined(self.cur_local_angles))
	{
		self.cur_local_angles = (0,0,0);
		self.self_to_target_local_angles = (0,0,0);
		self.pitch_rate = 0;
		self.yaw_rate = 0;
		self.last_pitch_noise = 0;
		self.last_yaw_noise = 0;
	}

	var_00 = 0.05;
	for(;;)
	{
		waittillframeend;
		waittillframeend;
		if(isdefined(self.real_target) && isdefined(self.real_target.origin))
		{
			var_01 = self.real_target.origin;
			if(isai(self.real_target))
			{
				var_01 = var_01 + (0,0,32);
			}

			if(isplayer(self.real_target))
			{
				var_01 = var_01 + (0,0,32);
			}

			var_02 = transformmove((0,0,0),(0,0,0),self.origin,self.angles,var_01,(0,0,0))["origin"];
			var_03 = vectornormalize(var_02);
			self.self_to_target_local_angles = vectortoangles(var_03);
		}
		else if(isdefined(self.no_target_local_spotlight_angles))
		{
			self.self_to_target_local_angles = self.no_target_local_spotlight_angles;
		}

		var_05 = angleclamp180(self.self_to_target_local_angles[0] - self.cur_local_angles[0]);
		var_06 = angleclamp180(self.self_to_target_local_angles[1] - self.cur_local_angles[1]);
		var_07 = 180;
		var_08 = 180;
		var_09 = length((var_05,var_06,0));
		if(var_09 < 10)
		{
			var_0A = max(var_09 / 10,0.7);
			var_07 = var_07 * var_0A;
			var_08 = var_08 * var_0A;
		}

		if(abs(angleclamp180(self.cur_local_angles[0])) < 89)
		{
			var_0A = min(1 / cos(self.cur_local_angles[0]),3);
			var_08 = var_08 * var_0A;
		}

		var_05 = clamp(var_05,-1 * var_07 * var_00,var_07 * var_00);
		var_06 = clamp(var_06,-1 * var_08 * var_00,var_08 * var_00);
		var_05 = maps\_utility::linear_interpolate(0.8,var_05,self.pitch_rate * var_00 * 0.8);
		var_06 = maps\_utility::linear_interpolate(0.8,var_06,self.yaw_rate * var_00 * 0.8);
		self.pitch_rate = var_05 / var_00;
		self.yaw_rate = var_06 / var_00;
		var_0B = gettime() * 0.001 * 1.5;
		var_0C = perlinnoise2d(0,var_0B,2,2,1) * 0.5;
		var_0D = perlinnoise2d(1.5,var_0B,2,2,1) * 1.5;
		var_05 = var_05 + var_0C - self.last_pitch_noise;
		var_06 = var_06 + var_0D - self.last_yaw_noise;
		self.last_pitch_noise = var_0C;
		self.last_yaw_noise = var_0D;
		self.cur_local_angles = self.cur_local_angles + (var_05,var_06,0);
		var_0E = anglestoforward(self.cur_local_angles);
		var_0F = var_0E * 1000;
		var_10 = transformmove(self.origin,self.angles,(0,0,0),(0,0,0),var_0F,(0,0,0))["origin"];
		self.spotlight_target unlink();
		self.spotlight_target.origin = var_10;
		self.spotlight_target linkto(self);
		wait(var_00);
	}
}

//Function Number: 26
se_intro()
{
	thread lab_intro_screen();
	common_scripts\utility::flag_wait("chyron_video_done");
	thread helo_spotlight_handle_intro_rumbles();
	thread helo_spotlight_init();
	thread helo_spotlight_movement();
	common_scripts\utility::flag_wait("lab_intro_screen_complete");
	setsaveddvar("ammoCounterHide","1");
	level.player maps\_shg_utility::setup_player_for_scene(1);
	level.player thread player_run_rumble();
	var_00 = maps\_utility::spawn_anim_model("player_rig_intro");
	var_00.weapon = "none";
	var_00 dontcastshadows();
	var_01 = spawn("script_origin",(0,0,0));
	var_02 = common_scripts\utility::getstruct("intro_anim_org","targetname");
	var_01.origin = var_02.origin;
	if(isdefined(var_02.angles))
	{
		var_01.angles = var_02.angles;
	}

	level.player playerlinktodelta(var_00,"tag_player",1,0,0,0,0,1);
	var_01 maps\_anim::anim_first_frame_solo(var_00,"intro_recover");
	var_01 maps\_anim::anim_first_frame_solo(level.burke,"intro_recover");
	maps\_utility::delaythread(0.5,::helo_spotlight_shoot_struct,"intro_anim_bullet_dest");
	var_01 thread burke_intro_anim(level.burke,"intro_recover");
	var_01 thread maps\_anim::anim_single_solo(var_00,"intro_recover");
	var_03 = getanimlength(var_00 maps\_utility::getanim("intro_recover"));
	var_04 = gettime();
	for(;;)
	{
		if(gettime() - var_04 >= var_03 * 1000)
		{
			break;
		}

		common_scripts\utility::waittill_any_ents(level,"allow_player_control",var_01,"intro_recover");
		if(level.player getnormalizedmovement()[0] > 0.5)
		{
			break;
		}

		if(gettime() - var_04 >= var_03 * 1000)
		{
			break;
		}

		wait(0.05);
	}

	level.player unlink();
	var_00 delete();
	level.player enableweapons();
	setsaveddvar("player_sprintunlimited","1");
	level.player forcesprint();
	var_01 delete();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	thread helo_sniper_threaten_player();
	common_scripts\utility::array_thread(getentarray("player_run_progress_trigger","script_noteworthy"),::player_run_progress_trigger_think);
}

//Function Number: 27
player_run_rumble()
{
	var_00 = maps\_utility::get_rumble_ent("steady_rumble");
	var_01 = 0.05;
	var_02 = 0.25;
	while(!common_scripts\utility::flag("flag_player_enters_forest"))
	{
		var_03 = length(level.player getvelocity());
		var_04 = var_03 / 320;
		var_00.intensity = var_04 * var_02;
		if(var_00.intensity > 1)
		{
			var_00.intensity = 1;
		}

		wait(0.1);
		var_00.intensity = var_04 * var_01;
		if(var_00.intensity > 1)
		{
			var_00.intensity = 1;
		}

		if(var_03 > 0)
		{
			var_05 = 0.3 * 1 - var_03 / 194;
		}
		else
		{
			var_05 = 0;
		}

		var_06 = 0.3 + var_05;
		if(var_06 > 0)
		{
			wait(var_06);
		}
	}

	var_00 delete();
	stopallrumbles();
}

//Function Number: 28
burke_intro_anim(param_00,param_01)
{
	level.burke maps\_utility::gun_remove();
	level.burke maps\_utility::disable_pain();
	level.burke maps\_utility::disable_ai_color();
	soundscripts\_snd::snd_message("aud_burke_intro_anim");
	maps\_anim::anim_single_solo_run(param_00,param_01);
	common_scripts\utility::flag_set("flag_burke_intro_react_se_start");
}

//Function Number: 29
se_intro_burke_react()
{
	common_scripts\utility::flag_wait("flag_burke_intro_react_se_start");
	var_00 = common_scripts\utility::getstruct("burke_intro_react_anim_org","targetname");
	var_00 maps\_anim::anim_reach_solo(level.burke,"burke_intro_react");
	maps\_utility::delaythread(0.05,::helo_spotlight_shoot_struct,"burke_intro_react_bullet_dest");
	var_00 maps\_anim::anim_single_solo_run(level.burke,"burke_intro_react");
	common_scripts\utility::flag_set("flag_burke_shack_se_start");
}

//Function Number: 30
se_intro_shack()
{
	common_scripts\utility::flag_wait("flag_burke_shack_se_start");
	var_00 = common_scripts\utility::getstruct("burke_intro_shack_org","targetname");
	var_00 maps\_anim::anim_reach_solo(level.burke,"lab_shack_enter");
	var_00 maps\_anim::anim_single_solo(level.burke,"lab_shack_enter");
	var_00 thread maps\_anim::anim_loop_solo(level.burke,"lab_shack_idle","ender");
	common_scripts\utility::flag_wait("flag_burke_dive_over_log");
	soundscripts\_snd::snd_message("aud_shack_explode_whizby");
	wait(0.25);
	var_00 notify("ender");
	level.burke maps\_utility::anim_stopanimscripted();
	helo_spotlight_shoot_struct("intro_shack_bullet_dest");
	thread maps\lab_fx::shack_roof_damage_fx();
	thread shack_explode();
	var_01 = distance(level.player.origin,level.burke.origin);
	if(var_01 < 200)
	{
		thread maps\lab_utility::rumble_heavy_1();
	}
	else if(var_01 < 500)
	{
		thread maps\lab_utility::rumble_light();
	}

	var_00 maps\_anim::anim_single_run_solo(level.burke,"lab_shack_exit");
}

//Function Number: 31
shack_explode()
{
	maps\_utility::activate_trigger_with_targetname("shack_explode");
	soundscripts\_snd::snd_message("player_reaches_shack");
}

//Function Number: 32
se_check_player_too_far_from_burke()
{
	while(!common_scripts\utility::flag("flag_helo_spotlight_path_02"))
	{
		if(!maps\_utility::players_within_distance(300,level.burke.origin))
		{
			magicbullet("s1_lab_heli_railgun_sp",level.helo_spotlight.origin,level.player);
		}

		wait(randomfloatrange(1,2));
	}
}

//Function Number: 33
se_slow_player_if_too_far_ahead()
{
	var_00 = common_scripts\utility::getstruct("intro_shack_bullet_dest","targetname");
	var_01 = getent("obj_forest_climb_wall","targetname");
	var_02 = 1;
	var_03 = 0.7;
	var_04 = 0.5;
	while(!common_scripts\utility::flag("flag_burke_dive_over_log"))
	{
		if(distance2dsquared(level.player.origin,var_00.origin) < distance2dsquared(level.burke.origin,var_00.origin))
		{
			while(var_02 >= var_03 && distance2dsquared(level.player.origin,var_00.origin) < distance2dsquared(level.burke.origin,var_00.origin))
			{
				var_02 = var_02 - 0.1;
				level.player setmovespeedscale(var_02);
				wait(var_04);
			}

			while(distance2dsquared(level.player.origin,var_00.origin) < distance2dsquared(level.burke.origin,var_00.origin))
			{
				wait 0.05;
			}

			while(var_02 < 1)
			{
				var_02 = var_02 + 0.1;
				level.player setmovespeedscale(var_02);
				wait 0.05;
			}

			var_02 = 1;
			level.player setmovespeedscale(var_02);
		}

		wait 0.05;
	}

	while(!common_scripts\utility::flag("flag_player_slide_start"))
	{
		if(distance2dsquared(level.player.origin,var_01.origin) < distance2dsquared(level.burke.origin,var_01.origin))
		{
			while(var_02 >= var_03 && distance2dsquared(level.player.origin,var_01.origin) < distance2dsquared(level.burke.origin,var_01.origin))
			{
				var_02 = var_02 - 0.1;
				level.player setmovespeedscale(var_02);
				wait(var_04);
			}

			while(distance2dsquared(level.player.origin,var_01.origin) < distance2dsquared(level.burke.origin,var_01.origin))
			{
				wait 0.05;
			}

			while(var_02 < 1)
			{
				var_02 = var_02 + 0.1;
				level.player setmovespeedscale(var_02);
				wait 0.05;
			}

			var_02 = 1;
			level.player setmovespeedscale(var_02);
		}

		wait 0.05;
	}
}

//Function Number: 34
se_burke_stumble_run()
{
	var_00 = common_scripts\utility::getstruct("burke_stumble_run_anim_org","targetname");
	if(!common_scripts\utility::flag("flag_helo_spotlight_path_02"))
	{
		var_00 maps\_anim::anim_reach_solo(level.burke,"burke_stumble_run");
		maps\_utility::delaythread(0.15,::helo_spotlight_shoot_struct,"burke_stumble_run_bullet_dest");
		level.burke soundscripts\_snd::snd_message("aud_burke_stumble_run");
		var_00 maps\_anim::anim_single_solo_run(level.burke,"burke_stumble_run");
	}

	common_scripts\utility::flag_set("flag_emp_cocked_exo_dialogue");
}

//Function Number: 35
se_burke_dive_over_log()
{
	var_00 = common_scripts\utility::getstruct("burke_dive_over_log_anim_org","targetname");
	var_00 maps\_anim::anim_reach_solo(level.burke,"burke_dive_over_log");
	maps\_utility::delaythread(1.1,::helo_spotlight_shoot_struct,"burke_dive_over_log_bullet_dest");
	level.burke soundscripts\_snd::snd_message("aud_burke_step_over_log");
	var_00 maps\_anim::anim_single_solo_run(level.burke,"burke_dive_over_log");
	if(maps\_utility::players_within_distance(350,level.burke.origin))
	{
		se_burke_stumble_knee();
		return;
	}

	se_burke_tree_cover_01();
}

//Function Number: 36
se_burke_tree_cover_01()
{
	var_00 = common_scripts\utility::getstruct("burke_tree_cover_01_anim_org","targetname");
	var_00 maps\_anim::anim_reach_solo(level.burke,"burke_tree_cover_01");
	maps\_utility::delaythread(0.6,::helo_spotlight_shoot_struct,"burke_tree_cover_01_bullet_dest_1");
	level.burke soundscripts\_snd::snd_message("aud_burke_tree_cover_01");
	var_00 maps\_anim::anim_single_solo(level.burke,"burke_tree_cover_01");
	var_00 thread maps\_anim::anim_loop_solo(level.burke,"burke_tree_cover_01_idle","ender");
	common_scripts\utility::flag_wait("flag_helo_spotlight_path_02");
	var_00 notify("ender");
	level.burke maps\_utility::anim_stopanimscripted();
	common_scripts\utility::flag_set("flag_gogogo_dialogue_start");
	var_00 maps\_anim::anim_single_solo_run(level.burke,"burke_tree_cover_01_exit");
}

//Function Number: 37
se_burke_stumble_knee()
{
	maps\_utility::delaythread(3,::common_scripts\utility::flag_set,"flag_gogogo_dialogue_start");
}

//Function Number: 38
se_burke_hill_slide()
{
	var_00 = common_scripts\utility::getstruct("hill_slide_anim_org","targetname");
	var_00 maps\_anim::anim_reach_solo(level.burke,"burke_hill_slide");
	maps\_utility::delaythread(2.6,::helo_spotlight_shoot_struct,"hill_slide_bullet_dest_2");
	if(maps\_utility::players_within_distance(400,level.burke.origin))
	{
		maps\_utility::delaythread(0.25,::se_player_hill_slide);
		common_scripts\utility::flag_set("flag_burke_hill_slide_start");
		level.burke soundscripts\_snd::snd_message("burke_hill_slide","anim_02");
		var_00 maps\_anim::anim_single_solo_run(level.burke,"burke_hill_slide_alt");
	}
	else
	{
		maps\_utility::delaythread(2,::se_player_hill_slide);
		common_scripts\utility::flag_set("flag_burke_hill_slide_start");
		level.burke soundscripts\_snd::snd_message("burke_hill_slide","anim_01");
		var_00 maps\_anim::anim_single_solo_run(level.burke,"burke_hill_slide");
	}

	if(maps\_utility::players_within_distance(400,level.burke.origin))
	{
		common_scripts\utility::flag_set("flag_run_dialogue_start");
		se_burke_river_over_log();
		return;
	}

	se_burke_tree_stump();
	se_burke_river_over_log();
}

//Function Number: 39
se_player_hill_slide()
{
	common_scripts\utility::flag_wait("flag_player_slide_start");
	var_00 = common_scripts\utility::getstruct("hill_slide_anim_org","targetname");
	soundscripts\_snd::snd_message("aud_player_hill_slide");
	level.player_rig = maps\lab_utility::spawn_player_rig();
	level.player_rig dontcastshadows();
	level.player_rig hide();
	level.player freezecontrols(1);
	level.player maps\_shg_utility::setup_player_for_scene(0);
	level.player setstance("stand");
	var_00 maps\_anim::anim_first_frame_solo(level.player_rig,"player_hill_slide");
	level.player playerlinktoblend(level.player_rig,"tag_player",0.2);
	wait(0.2);
	level.player playerlinktodelta(level.player_rig,"tag_player",1,20,20,20,0);
	level.player_rig common_scripts\utility::delaycall(0.1,::show);
	maps\_utility::delaythread(2.85,::helo_spotlight_shoot_struct,"hill_slide_bullet_dest_4");
	var_00 thread maps\_anim::anim_single_solo(level.player_rig,"player_hill_slide");
	thread handle_player_slide_rumbles();
	var_01 = getanimlength(level.player_rig maps\_utility::getanim("player_hill_slide"));
	var_02 = gettime();
	for(;;)
	{
		if(gettime() - var_02 >= var_01 * 1000)
		{
			break;
		}

		common_scripts\utility::waittill_any_ents(level,"allow_player_control",var_00,"player_hill_slide");
		if(level.player getnormalizedmovement()[0] > 0.5)
		{
			break;
		}

		if(gettime() - var_02 >= var_01 * 1000)
		{
			break;
		}

		wait(0.05);
	}

	level.player unlink();
	level.player freezecontrols(0);
	level.player enableweapons();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	level.player forcesprint();
	setsaveddvar("player_sprintunlimited","1");
	level.player_rig delete();
	level.player thread river_slow_movement_ai_think();
}

//Function Number: 40
handle_player_slide_rumbles()
{
	maps\lab_utility::setup_level_rumble_ent();
	wait(1.35);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.75,0.5);
	wait(0.6);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.3,2);
	wait(2.1);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.5,0.3);
}

//Function Number: 41
se_burke_tree_stump()
{
	var_00 = common_scripts\utility::getstruct("burke_tree_stump_org","targetname");
	var_00 maps\_anim::anim_reach_solo(level.burke,"burke_hill_slide_stump");
	maps\_utility::delaythread(0.4,::helo_spotlight_shoot_struct,"burke_tree_stump_bullet_dest");
	level.burke soundscripts\_snd::snd_message("aud_burke_hill_slide_stump");
	var_00 maps\_anim::anim_single_solo(level.burke,"burke_hill_slide_stump");
	var_00 thread maps\_anim::anim_loop_solo(level.burke,"burke_hill_slide_stump_idle","ender");
	common_scripts\utility::flag_wait("flag_burke_cross_river");
	var_00 notify("ender");
	level.burke maps\_utility::anim_stopanimscripted();
	common_scripts\utility::flag_set("flag_run_dialogue_start");
	if(level.nextgen)
	{
		var_00 maps\_anim::anim_single_solo_run(level.burke,"burke_hill_slide_stump_exit");
	}
}

//Function Number: 42
se_burke_river_over_log()
{
	var_00 = common_scripts\utility::getstruct("burke_river_over_log_org","targetname");
	var_00 maps\_anim::anim_reach_solo(level.burke,"burke_river_over_log");
	level.burke soundscripts\_snd::snd_message("aud_burke_river_over_log");
	var_00 maps\_anim::anim_single_solo_run(level.burke,"burke_river_over_log");
}

//Function Number: 43
se_burke_river_cross()
{
	thread se_wall_climb_roots();
	var_00 = common_scripts\utility::getstruct("forest_climb_anim_org","targetname");
	var_00 maps\_anim::anim_reach_solo(level.burke,"burke_river_cross");
	maps\_utility::delaythread(0.6,::helo_spotlight_shoot_struct,"river_cross_bullet_dest_1");
	maps\_utility::delaythread(5.05,::helo_spotlight_shoot_struct,"river_cross_bullet_dest_3");
	maps\_utility::delaythread(10.35,::helo_spotlight_shoot_struct,"river_cross_bullet_dest_5");
	maps\_utility::delaythread(12.6,::helo_spotlight_shoot_struct,"river_cross_bullet_dest_6");
	var_00 maps\_anim::anim_single_solo_run(level.burke,"burke_river_cross");
	if(maps\_utility::players_within_distance(400,level.burke.origin))
	{
		se_burke_river_to_wall(var_00);
		return;
	}

	se_burke_cover_tree_wave(var_00);
	se_burke_tree_to_wall(var_00);
}

//Function Number: 44
se_burke_river_to_wall(param_00)
{
	param_00 maps\_anim::anim_single_solo(level.burke,"burke_river_to_wall");
}

//Function Number: 45
se_burke_cover_tree_wave(param_00)
{
	var_01 = common_scripts\utility::getstruct("forest_take_cover_wave_anim_org","targetname");
	param_00 maps\_anim::anim_single_solo(level.burke,"burke_river_to_tree");
	var_01 thread maps\_anim::anim_loop_solo(level.burke,"burke_forest_cover_tree_wave","ender");
	common_scripts\utility::flag_wait("flag_player_enters_forest");
	var_01 notify("ender");
}

//Function Number: 46
se_burke_tree_to_wall(param_00)
{
	param_00 maps\_anim::anim_single_solo(level.burke,"burke_tree_to_wall");
}

//Function Number: 47
helo_spotlight_shoot_struct(param_00)
{
	var_01 = common_scripts\utility::getstruct(param_00,"targetname");
	if(!isdefined(var_01))
	{
		return;
	}

	helo_spotlight_shoot_location(var_01.origin);
}

//Function Number: 48
helo_spotlight_shoot_location(param_00)
{
	if(!isdefined(level.helo_spotlight))
	{
		return;
	}

	var_01 = get_helo_spotlight_bullet_origin(param_00);
	magicbullet("s1_lab_heli_railgun_sp",var_01,param_00);
	playfx(common_scripts\utility::getfx("heli_railgun_muzzleflash"),var_01,param_00 - var_01);
	soundscripts\_snd::snd_message("chopper_sniper_shot",var_01,param_00);
	if(distancesquared(param_00,level.player.origin) < 40000)
	{
		common_scripts\utility::noself_delaycall(0.1,::earthquake,0.5,0.5,param_00,200);
		level.player common_scripts\utility::delaycall(0.1,::playrumbleonentity,"damage_light");
	}
}

//Function Number: 49
helo_spotlight_shoot_trigger_think()
{
	level endon("flag_player_enters_forest");
	self waittill("trigger");
	var_00 = 0;
	for(;;)
	{
		var_01 = level.player getgunangles();
		var_02 = level.player geteye();
		var_03 = var_02 + anglestoforward(var_01) * 150 + anglestoright(var_01) * randomintrange(-40,40);
		var_04 = bullettrace(var_02,var_03,0);
		var_05 = get_helo_spotlight_bullet_origin(var_04["position"]);
		if(!maps\_utility::shot_endangers_any_player(var_05,var_04["position"]))
		{
			helo_spotlight_shoot_location(var_04["position"]);
			return;
		}

		wait(0.05);
	}
}

//Function Number: 50
se_wall_climb_roots()
{
	var_00 = common_scripts\utility::getstruct("forest_climb_anim_org","targetname");
	var_01 = spawn("script_origin",var_00.origin);
	if(isdefined(var_00.angles))
	{
		var_01.angles = var_00.angles;
	}

	level.wallclimb_roots = getent("wallclimb_roots","targetname");
	level.wallclimb_roots.animname = "wallclimb_roots";
	level.wallclimb_roots maps\_utility::assign_animtree();
	var_01 maps\_anim::anim_first_frame_solo(level.wallclimb_roots,"burke_wall_climb");
}

//Function Number: 51
se_burke_forest_wall_climb()
{
	var_00 = common_scripts\utility::getstruct("forest_climb_anim_org","targetname");
	var_01 = spawn("script_origin",var_00.origin);
	if(isdefined(var_00.angles))
	{
		var_01.angles = var_00.angles;
	}

	level.burke maps\_utility::enable_pain();
	level.burke thread maps\lab_utility::cloak_off();
	var_02 = [level.burke,level.wallclimb_roots];
	var_01 maps\_anim::anim_first_frame_solo(level.wallclimb_roots,"burke_wall_climb");
	level.burke soundscripts\_snd::snd_message("aud_burke_wall_climb");
	level.burke maps\lab_utility::clear_additive_helmet_anim(0);
	var_01 thread maps\_anim::anim_single(var_02,"burke_wall_climb");
	maps\_utility::delaythread(8,::player_climb_wall);
	maps\_utility::delaythread(1,::maps\lab_fx::wall_climb_dust_fx);
	thread helo_wall_climb(var_01);
	thread maps\lab_lighting::enter_forest();
	var_01 waittill("burke_wall_climb");
	var_03 = "burke_wall_climb_loop_end";
	var_01 thread maps\_anim::anim_loop_solo(level.burke,"burke_wall_climb_loop",var_03);
	common_scripts\utility::flag_wait("flag_burke_says_exo_is_on");
	var_01 notify(var_03);
	var_01 maps\_anim::anim_single_solo(level.burke,"burke_says_exo_is_on");
	common_scripts\utility::flag_wait("flag_forest_climb_wall_complete");
	thread spawn_takedown_01_guys();
}

//Function Number: 52
burke_wall_climb_teleport(param_00)
{
	var_01 = common_scripts\utility::getstruct("forest_search_drone_anim_org","targetname");
	level.burke stopanimscripted();
	var_01 thread maps\_anim::anim_loop_solo(level.burke,"burke_search_drone_idle","ender");
}

//Function Number: 53
player_climb_wall_head_sway()
{
	level endon("player_falling_to_death");
	level.player endon("stop_head_sway");
	for(;;)
	{
		screenshake(level.player.origin,7,9,4,2,0.2,0.2,0,0.3,0.375,0.225);
		wait(1);
	}
}

//Function Number: 54
player_climb_wall()
{
	level endon("player_falling_to_death");
	level endon("flag_cloak_fail_kill_player");
	common_scripts\utility::flag_set("flag_forest_climb_wall_start");
	soundscripts\_snd::snd_message("forest_climb_wall_start");
	thread show_exo_cloak_hint();
	var_00 = common_scripts\utility::getstruct("forest_climb_anim_org","targetname");
	var_01 = getent("climb_wall_use_trigger","targetname");
	var_01 thread maps\_utility::addhinttrigger(&"LAB_CLIMB_WALL_HINT",&"LAB_CLIMB_WALL_HINT_PC");
	var_02 = var_01 maps\_shg_utility::hint_button_trigger("x");
	var_01 waittill("trigger");
	var_01 delete();
	var_02 maps\_shg_utility::hint_button_clear();
	common_scripts\utility::flag_set("player_climbing_wall");
	common_scripts\utility::flag_set("player_climbing_wall_lighting");
	level.player setstance("stand");
	var_03 = getentarray("tree_wall_climb","targetname");
	foreach(var_05 in var_03)
	{
		var_05 hide();
	}

	level.player_rig = maps\lab_utility::spawn_player_rig();
	level.player_rig hide();
	level.player freezecontrols(1);
	level.player maps\_shg_utility::setup_player_for_scene(0);
	var_07 = 0.5;
	level.player playerlinktoblend(level.player_rig,"tag_player",var_07);
	var_08 = [level.player_rig,level.wallclimb_roots];
	level.player_rig common_scripts\utility::delaycall(var_07,::show);
	soundscripts\_snd::snd_message("aud_player_wall_climb_01");
	level notify("player_wall_climb_01");
	level.player thread player_climb_wall_head_sway();
	thread handle_player_wall_climb_rumbles();
	var_00 maps\_anim::anim_single(var_08,"player_wall_climb_1");
	maps\lab_utility::wait_until_left_swing_pressed(level.wallclimb_roots gettagorigin("jnt_root03") + (0,0,10));
	level.player thread maps\lab_utility::monitor_right_swing_released();
	soundscripts\_snd::snd_message("aud_player_wall_climb_02");
	level notify("player_wall_climb_02");
	var_00 maps\_anim::anim_single(var_08,"player_wall_climb_2");
	maps\lab_utility::wait_until_next_right_swing(level.wallclimb_roots gettagorigin("jnt_root05") + (0,0,0));
	thread maps\lab_utility::monitor_left_swing_released();
	soundscripts\_snd::snd_message("aud_player_wall_climb_03");
	level notify("player_wall_climb_03");
	var_00 maps\_anim::anim_single(var_08,"player_wall_climb_3");
	maps\lab_utility::wait_until_next_left_swing(level.wallclimb_roots gettagorigin("jnt_root07") + (0,0,0));
	var_09 = level.burke gettagorigin("tag_origin");
	thread maps\lab_utility::monitor_right_swing_released();
	soundscripts\_snd::snd_message("aud_player_wall_climb_04");
	level notify("player_wall_climb_04");
	var_00 maps\_anim::anim_single(var_08,"player_wall_climb_4");
	level.burke overridelightingorigin(var_09);
	if(level.nextgen)
	{
		setsaveddvar("r_adaptivesubdiv",0);
	}

	maps\lab_utility::wait_until_next_right_swing(level.wallclimb_roots gettagorigin("jnt_breakoff03") + (0,0,0));
	common_scripts\utility::flag_set("flag_player_climb_succeeded");
	level.nextgrenadedrop = 1000000;
	soundscripts\_snd::snd_message("aud_player_wall_climb_05");
	level notify("player_wall_climb_05");
	var_00 maps\_anim::anim_single(var_08,"player_wall_climb_5");
	common_scripts\utility::flag_set("flag_player_cloak_enabled");
	if(!common_scripts\utility::flag("flag_player_cloak_on_pressed"))
	{
		var_00 thread maps\_anim::anim_loop(var_08,"player_wall_climb_loop","player_wall_climb_loop_end");
		common_scripts\utility::flag_wait("flag_player_cloak_on_pressed");
		var_00 notify("player_wall_climb_loop_end");
	}

	soundscripts\_snd::snd_message("wall_climb_cloak_activate");
	level notify("aud_wall_climb_done");
	level notify("wall_cloak_on");
	level.burke defaultlightingorigin();
	var_00 maps\_anim::anim_single(var_08,"player_wall_climb_lastjump");
	maps\lab_utility::wait_until_both_swings_pressed();
	level.player notify("stop_head_sway");
	level notify("last_jump_made");
	soundscripts\_snd::snd_message("wall_climb_last_jump");
	var_00 maps\_anim::anim_single(var_08,"player_wall_climb_end");
	if(level.nextgen)
	{
		setsaveddvar("r_adaptivesubdiv",1);
	}

	level.player unlink();
	level.player freezecontrols(0);
	level.player enableweapons();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	common_scripts\utility::flag_set("flag_player_exo_enabled");
	setsaveddvar("player_sprintunlimited","1");
	level.player_rig delete();
	maps\_cloak::turn_on_the_cloak_effect();
	common_scripts\utility::flag_set("flag_forest_climb_wall_complete");
	common_scripts\utility::flag_set("flag_forest_climb_wall_complete_lighting");
	foreach(var_05 in var_03)
	{
		var_05 show();
	}

	soundscripts\_snd::snd_message("random_dog_barks");
}

//Function Number: 55
handle_player_wall_climb_rumbles()
{
	wait(0.5);
	thread maps\lab_utility::rumble_heavy();
	wait(0.5);
	thread maps\lab_utility::rumble_light_1();
	level waittill("player_wall_climb_02");
	wait(0.75);
	thread maps\lab_utility::rumble_light();
	level waittill("player_wall_climb_03");
	wait(0.5);
	thread maps\lab_utility::rumble_light();
	level waittill("player_wall_climb_04");
	wait(1);
	thread maps\lab_utility::rumble_light();
	level waittill("player_wall_climb_05");
	wait(2.15);
	thread maps\lab_utility::rumble_heavy();
	maps\lab_utility::setup_level_rumble_ent();
	level waittill("wall_cloak_on");
	wait(1);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.3,0.15);
	wait(0.16);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.3,0.2);
	wait(3.5);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.4,0.2);
	level waittill("last_jump_made");
	wait(0.6);
	maps\lab_utility::rumble_light();
	wait(0.85);
	maps\lab_utility::rumble_heavy();
}

//Function Number: 56
helo_wall_climb(param_00)
{
	common_scripts\utility::flag_wait("player_climbing_wall");
	common_scripts\utility::flag_set("flag_helo_low_pass_claok_start");
	level.helo_spotlight.animname = "spotlight_helo";
	param_00 maps\_anim::anim_single_solo(level.helo_spotlight,"player_wall_climb");
	param_00 thread maps\_anim::anim_loop_solo(level.helo_spotlight,"player_wall_climb_loop","ender");
	common_scripts\utility::flag_wait("flag_player_cloak_on_pressed");
	param_00 notify("ender");
	param_00 maps\_anim::anim_single_solo(level.helo_spotlight,"player_wall_climb_end");
	common_scripts\utility::flag_set("flag_helo_low_pass_complete");
	level.helo_spotlight notify("stop_helo_spotlight");
	level.helo_spotlight.override_target linkto(level.helo_spotlight);
	level.helo_spotlight maps\_utility::vehicle_detachfrompath();
	level.helo_spotlight vehicle_setspeed(20,15,5);
	var_01 = common_scripts\utility::getstruct("path_helo_goto_crash_site_start","targetname");
	level.helo_spotlight thread maps\_utility::vehicle_dynamicpath(var_01,0);
	level.helo_spotlight.script_vehicle_selfremove = 1;
}

//Function Number: 57
player_stealth_cloak_think()
{
	if(!common_scripts\utility::flag("flag_player_cloak_on"))
	{
		maps\_cloak::cloaked_stealth_enable_lab_hud_cinematic();
	}

	common_scripts\utility::flag_wait("flag_player_cloak_on");
	level.player maps\_cloak::cloaked_stealth_player_setup();
	maps\_cloak::cloaked_stealth_disable_lab_hud_cinematic();
	maps\_cloak::cloaked_stealth_enable_battery_hud();
	common_scripts\utility::flag_wait("flag_player_cloak_off");
	maps\_cloak::cloaked_stealth_disable_battery_hud();
}

//Function Number: 58
show_exo_cloak_hint()
{
	common_scripts\utility::flag_wait("flag_player_cloak_on");
	maps\_utility::display_hint_timeout("exo_toggle_hint",10);
}

//Function Number: 59
break_exo_cloak_hint()
{
	if(common_scripts\utility::flag("flag_player_cloak_on_pressed"))
	{
		return 1;
	}

	if(common_scripts\utility::flag("flag_cloak_fail_kill_player"))
	{
		return 1;
	}

	if(level.player buttonpressed("dpad_right"))
	{
		common_scripts\utility::flag_set("flag_player_cloak_on_pressed");
		return 1;
	}

	return 0;
}

//Function Number: 60
break_prone_hint()
{
	if(level.player getstance() == "prone")
	{
		return 1;
	}

	if(!common_scripts\utility::flag("player_near_logging_road_end_log"))
	{
		return 1;
	}

	if(common_scripts\utility::flag("flag_seeker_clear"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 61
break_detonate_frb_hint()
{
	if(common_scripts\utility::flag("flag_obj_neutralize_bio_weapons_complete"))
	{
		return 1;
	}

	if(!common_scripts\utility::flag("flag_foam_room_clear"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 62
se_search_drones_01()
{
	common_scripts\utility::flag_wait("flag_forest_climb_wall_complete");
	var_00 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("drones_search");
	var_01 = common_scripts\utility::getstruct("forest_search_drone_anim_org","targetname");
	foreach(var_03 in var_00)
	{
		var_03 maps\_utility::ent_flag_set("fire_disabled");
		var_03.ignoreme = 1;
		var_03 maps\_utility::delaythread(randomfloatrange(0.05,1),::maps\lab_fx::drone_search_light_fx);
	}

	level.burke maps\_utility::set_grenadeammo(0);
	thread se_search_drone_backup();
	thread se_search_drone_vehicle(var_01);
	thread se_search_drone_deer(var_01);
	level.burke soundscripts\_snd::snd_message("burke_run_slide");
	common_scripts\utility::flag_wait("flag_search_drone_burke_anim_start");
	var_05 = getnodearray("node_search_drone","targetname");
	foreach(var_07 in var_05)
	{
		var_07 disconnectnode();
	}

	maps\_utility::delaythread(32.5,::common_scripts\utility::flag_set,"flag_search_drone_complete_dialogue_start");
	maps\_utility::delaythread(32.5,::common_scripts\utility::flag_set,"flag_search_drone_complete_dialogue_start");
	level thread maps\_utility::notify_delay("se_search_drone_backup_progress",32);
	var_01 notify("ender");
	level.burke maps\_utility::anim_stopanimscripted();
	var_01 maps\_anim::anim_single_solo_run(level.burke,"burke_search_drone");
	maps\_utility::autosave_by_name();
	level.burke maps\_utility::set_moveplaybackrate(0.8);
	common_scripts\utility::flag_set("flag_search_drone_se_complete");
}

//Function Number: 63
se_search_drone_backup()
{
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname("se_search_drone_backup");
	var_00 endon("death");
	var_00 endon("drone_spotted_player");
	thread search_drone_behavior(var_00,undefined,1);
	var_00 sethoverparams(16,5,5);
	var_00 thread search_drone_random_turns();
	var_00 maps\_utility::delaythread(0.25,::maps\lab_fx::drone_search_light_fx);
	level waittill("se_search_drone_backup_progress");
	var_00 maps\_vehicle::gopath();
}

//Function Number: 64
search_drone_random_turns()
{
	self endon("weapon_fired");
	self endon("start_vehiclepath");
	self endon("drone_spotted_player");
	self setvehgoalpos(self.origin,1);
	self notify("goal");
	self.pacifist = 1;
	maps\_utility::ent_flag_set("fire_disabled");
	for(;;)
	{
		var_00 = randomint(360);
		self setgoalyaw(var_00);
		wait(randomfloatrange(2,5));
	}
}

//Function Number: 65
search_drone_behavior(param_00,param_01,param_02)
{
	param_00 endon("death");
	param_00 setcontents(8192);
	param_00 makevehiclenotcollidewithplayers(1);
	var_03 = 40;
	var_04 = 512;
	var_05 = 256;
	var_06 = 100;
	if(isdefined(param_02) && param_02)
	{
		var_06 = 1;
	}

	if(isdefined(param_01) && param_01)
	{
		var_06 = 32;
	}

	var_07 = var_03 * var_03;
	var_08 = var_04 * var_04;
	var_09 = var_05 * var_05;
	param_00.alerted_amount = 0;
	var_0A = 2;
	if(isdefined(param_02) && param_02)
	{
		var_0A = 0.1;
	}

	var_0B = 0.05;
	param_00 thread search_drone_alert_monitor();
	param_00 thread search_drone_damage_detection();
	for(;;)
	{
		var_0C = length(level.player getvelocity());
		var_0D = level._cloaked_stealth_settings.cloak_on;
		var_0E = level.player geteye();
		if(param_00.alerted_amount >= var_0A)
		{
			if((isdefined(param_01) && param_01) || isdefined(param_02) && param_02)
			{
				param_00 se_search_drone_spotted_player();
			}
			else
			{
				param_00 search_drone_spotted_player();
			}

			param_00.alerted_amount = 0;
		}

		var_0F = 0;
		if(var_0D)
		{
			if(distancesquared(var_0E,param_00.origin) < var_07)
			{
				if(!param_00.alerted_amount)
				{
				}

				param_00.alerted_amount = param_00.alerted_amount + var_0B * 2;
				var_0F = 1;
			}
		}
		else if(distancesquared(var_0E,param_00.origin) < var_08 && sighttracepassed(param_00.origin,var_0E,0,param_00))
		{
			if(!param_00.alerted_amount)
			{
			}

			param_00.alerted_amount = param_00.alerted_amount + var_0B;
			var_0F = 1;
		}

		if(distancesquared(var_0E,param_00.origin) < var_09)
		{
			if(var_0C > var_06)
			{
				if(!param_00.alerted_amount)
				{
					thread maps\lab_vo::search_drone_warning_dialogue();
				}

				param_00.alerted_amount = param_00.alerted_amount + var_0B;
				var_0F = 1;
			}
		}

		if(var_0F)
		{
			param_00 notify("alerted");
		}
		else
		{
			param_00 notify("not_alerted");
		}

		wait(var_0B);
	}
}

//Function Number: 66
search_drone_damage_detection()
{
	self endon("death");
	for(;;)
	{
		self waittill("damage",var_00,var_01);
		if(isdefined(var_01) && isdefined(var_01.team))
		{
			if(isenemyteam(self.team,var_01.team))
			{
				self.alerted_amount = 100;
				self notify("alerted");
			}
		}
	}
}

//Function Number: 67
search_drone_alert_monitor()
{
	self endon("drone_spotted_player");
	self endon("death");
	for(;;)
	{
		self waittill("alerted");
		if(!common_scripts\utility::flag("flag_forest_takedown_01"))
		{
			self playsound("atlasdrn_angry");
		}

		self waittill("not_alerted");
		self stoploopsound("seeker_alarm_lp");
	}
}

//Function Number: 68
se_search_drone_spotted_player()
{
	self laseron();
	self playloopsound("atlasdrn_detection_lp");
	thread maps\lab_vo::search_drone_alerted_dialogue();
	wait(1);
	self.pacifist = 0;
	maps\_utility::ent_flag_clear("fire_disabled");
	self stopanimscripted();
	self setvehgoalpos(level.player.origin + (0,0,90),1);
	level.player enablehealthshield(0);
	maps\_utility::vehicle_detachfrompath();
	thread vehicle_scripts\_pdrone::flying_attack_drone_logic();
	level.player enablehealthshield(0);
	for(;;)
	{
		level notify("player_failed_drone_scene");
		self waittill("weapon_fired");
		level.player dodamage(34 / level.player.damagemultiplier,self.origin,self);
	}
}

//Function Number: 69
search_drone_spotted_player()
{
	self notify("search_drone_spotted_player");
	self endon("search_drone_spotted_player");
	self endon("death");
	self laseron();
	maps\_utility::ent_flag_clear("fire_disabled");
	self.pacifist = 0;
	self.ignoreme = 0;
	maps\_utility::set_favoriteenemy(level.player);
	var_00 = level.player.origin;
	maps\_cloak::cloak_device_hit_by_electro_magnetic_pulse();
	maps\_utility::vehicle_detachfrompath();
	while(sighttracepassed(self.origin,level.player geteye(),0,self))
	{
		if(isdefined(self.script_stealthgroup) && isdefined(level._stealth.group.groups[maps\_utility::string(self.script_stealthgroup)]))
		{
			var_01 = maps\_stealth_shared_utilities::group_get_ai_in_group(maps\_utility::string(self.script_stealthgroup));
			foreach(var_03 in var_01)
			{
				if(var_03 == self)
				{
					continue;
				}

				if(isdefined(var_03.enemy) || isdefined(var_03.favoriteenemy))
				{
					continue;
				}

				var_03 notify("heard_alarm",var_00);
			}
		}

		self waittill("new_target");
		maps\_utility::set_favoriteenemy(undefined);
		if(isdefined(self.enemy))
		{
			self.enemy common_scripts\utility::waittill_notify_or_timeout("target_lost",10);
		}

		wait(3);
	}

	maps\_utility::ent_flag_set("fire_disabled");
	self laseroff();
	self.pacifist = 1;
	self.ignoreme = 1;
}

//Function Number: 70
se_search_drone_vehicle(param_00)
{
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("se_search_drone");
	var_01.animname = "search_drone";
	var_01 endon("drone_spotted_player");
	thread search_drone_behavior(var_01,1);
	var_01 maps\_utility::ent_flag_set("fire_disabled");
	var_01 maps\_vehicle::godon();
	var_01.ignoreme = 1;
	var_01 thread maps\lab_fx::drone_search_light_fx();
	param_00 maps\_anim::anim_first_frame_solo(var_01,"search_drone");
	common_scripts\utility::flag_wait("flag_search_drone_burke_anim_start");
	param_00 maps\_anim::anim_single_solo(var_01,"search_drone");
	var_02 = common_scripts\utility::getstruct("path_search_drone_end","targetname");
	var_01 thread maps\_utility::vehicle_dynamicpath(var_02,0);
	var_01.script_vehicle_selfremove = 1;
}

//Function Number: 71
se_search_drone_deer(param_00)
{
	var_01 = spawn("script_model",param_00.origin);
	var_01 setmodel("fullbody_deer_c");
	var_01.animname = "deer";
	var_01 maps\_anim::setanimtree();
	param_00 maps\_anim::anim_first_frame_solo(var_01,"search_drone");
	maps\_utility::delaythread(31,::maps\lab_fx::deer_leaves_fx);
	common_scripts\utility::flag_wait("flag_search_drone_burke_anim_start");
	var_01 soundscripts\_snd::snd_message("deer_foliage_rustle");
	param_00 maps\_anim::anim_single_solo(var_01,"search_drone");
	var_01 delete();
}

//Function Number: 72
force_patrol_anim_set(param_00,param_01,param_02)
{
	maps\_patrol_extended::force_patrol_anim_set(param_00,param_01,0,param_02);
}

//Function Number: 73
spawn_takedown_01_guys()
{
	common_scripts\utility::flag_wait("flag_forest_climb_wall_complete");
	level endon("flag_se_takedown_01_started");
	level.guy_1 = getent("enemy_takedown_player_01","targetname") maps\_utility::spawn_ai(1);
	level.guy_2 = getent("enemy_takedown_burke_01","targetname") maps\_utility::spawn_ai(1);
	level.guy_1 maps\_utility::set_ignoreme(1);
	level.guy_2 maps\_utility::set_ignoreme(1);
	level.guy_1 maps\_utility::set_ignoreall(1);
	level.guy_2 maps\_utility::set_ignoreall(1);
	level waittill("player_failed_drone_scene");
	common_scripts\utility::flag_set("forest_player_passed_takedown");
}

//Function Number: 74
se_forest_takedown_01()
{
	var_00 = common_scripts\utility::getstruct("forest_takedown_01_org","targetname");
	thread burke_se_forest_takedown_01(var_00);
	common_scripts\utility::flag_wait("flag_forest_takedown_01");
	level.player allowmelee(0);
	level.player.disable_melee = 1;
	var_01 = getnodearray("node_search_drone","targetname");
	foreach(var_03 in var_01)
	{
		var_03 connectnode();
	}

	thread se_forest_takedown_01_fail_conditions(level.guy_1,level.guy_2);
	thread se_forest_takedown_01_distance_think();
	var_00 = common_scripts\utility::getstruct("forest_takedown_01_org","targetname");
	level.guy_1 force_patrol_anim_set("active_forward");
	level.guy_1 common_scripts\utility::delay_script_call(3,::maps\_flashlight_cheap::add_cheap_flashlight,"flashlight",0,"flashlight_spotlight");
	level.guy_2 force_patrol_anim_set("gundown");
	level.guy_1.nodrop = 1;
	level.guy_2.nodrop = 1;
	level.guy_1.diequietly = 1;
	level.guy_2.diequietly = 1;
	level.guy_1 maps\_utility::disable_surprise();
	level.guy_2 maps\_utility::disable_surprise();
	level.guy_1.animname = "disarm_guy_1";
	level.guy_2.animname = "disarm_guy_2";
	common_scripts\utility::flag_set("flag_forest_takedown_01_dialogue_start");
	thread maps\lab_utility::enable_takedown_hint(level.guy_1,101,1);
	level.guy_1 thread maps\lab_utility::display_takedown_world_prompt_on_enemy(self);
	self waittill("player_completed_takedown");
	common_scripts\utility::flag_set("flag_se_takedown_01_started");
	level.burke maps\_utility::anim_stopanimscripted();
	var_00 notify("ender");
	level.guy_1 notify("enemy");
	level.guy_2 notify("enemy");
	if(isdefined(level.guy_1.function_stack))
	{
		level.guy_1 maps\_utility::function_stack_clear();
	}

	level.guy_1 stopsounds();
	if(isdefined(level.burke.function_stack))
	{
		level.burke maps\_utility::function_stack_clear();
	}

	level.burke stopsounds();
	var_05 = [level.burke,level.guy_1,level.guy_2];
	level.player setstance("stand");
	level.guy_1 notify("flashlight_off");
	level.player_rig = maps\lab_utility::spawn_player_rig();
	level.player_rig hide();
	level.player freezecontrols(1);
	level.player maps\_shg_utility::setup_player_for_scene(0);
	maps\_player_exo::player_exo_deactivate();
	soundscripts\_snd::snd_message("player_forest_takedown",level.guy_1);
	soundscripts\_snd::snd_message("burke_forest_takedown",level.guy_2);
	var_06 = 0.5;
	level.player playerlinktoblend(level.player_rig,"tag_player",var_06);
	var_07 = [level.guy_1,level.player_rig];
	var_08 = [level.burke,level.guy_2];
	level.player_rig common_scripts\utility::delaycall(var_06,::show);
	thread se_burke_takedown_01(var_00);
	level.guy_1 notify("takedown_01_start");
	thread maps\lab_fx::forest_takedown_fx();
	thread forest_takedown_01_rumbles();
	thread forest_takedown_handle_gideon_weapon();
	thread award_player_exo_challenge_kill_for_scene();
	var_00 maps\_anim::anim_single(var_07,"forest_disarm");
	setsaveddvar("ammoCounterHide","0");
	level.guy_1 maps\_utility::pretend_to_be_dead();
	level.guy_2 maps\_utility::pretend_to_be_dead();
	level.player unlink();
	level.player freezecontrols(0);
	level.player enableweapons();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	maps\_player_exo::player_exo_activate();
	maps\_player_exo::player_exo_remove_single("exo_melee");
	setsaveddvar("player_sprintunlimited","1");
	level.player_rig delete();
	level.guy_1 kill();
	level.player thread equip_player_smg();
	if(level._cloaked_stealth_settings.cloak_on == 1)
	{
		level.player maps\_cloak::turn_off_the_cloak_effect();
		wait(0.05);
		level.player maps\_cloak::turn_on_the_cloak_effect();
	}

	common_scripts\utility::flag_set("flag_se_takedown_01_complete");
	soundscripts\_snd::snd_message("takedown_01_complete");
	maps\_utility::autosave_by_name();
	level.player allowmelee(1);
	level.player.disable_melee = undefined;
	thread maps\lab_lighting::logging_road();
}

//Function Number: 75
award_player_exo_challenge_kill_for_scene()
{
	wait(2.5);
	level.player maps\_upgrade_challenge::give_player_challenge_kill(1);
}

//Function Number: 76
forest_takedown_01_rumbles()
{
	maps\lab_utility::setup_level_rumble_ent();
	wait(0.75);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.6,0.3);
	wait(1);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.2,0.5);
	wait(0.65);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.8,0.2);
}

//Function Number: 77
forest_takedown_handle_gideon_weapon()
{
	wait(5);
	level.guy_2 maps\_utility::gun_remove();
	var_00 = spawn("script_model",level.burke.origin);
	var_01 = "npc_hbra3_nocamo";
	if(isdefined(level.burke.free_running_hidden_weapon))
	{
		var_01 = getweaponmodel(level.burke.free_running_hidden_weapon);
	}

	var_00 setmodel(var_01);
	var_00 maps\_utility::teleport_to_ent_tag(level.burke,"tag_weapon_right");
	wait(8.25);
	var_00 delete();
	level.burke animscripts\free_run::disable_free_running();
}

//Function Number: 78
burke_se_forest_takedown_01(param_00)
{
	level endon("flag_logging_road_loud_combat");
	param_00 maps\_anim::anim_reach_solo(level.burke,"forest_disarm_arrive",undefined,1);
	maps\_utility::delaythread(0.5,::maps\lab_fx::burke_tree_slide_fx);
	level.burke soundscripts\_snd::snd_message("burke_slide_02");
	param_00 maps\_anim::anim_single_solo(level.burke,"forest_disarm_arrive");
	level.burke maps\_utility::set_moveplaybackrate(1);
	param_00 thread maps\_anim::anim_loop_solo(level.burke,"forest_disarm_idle","ender");
	common_scripts\utility::flag_wait("flag_se_takedown_01_started");
	level.burke maps\_utility::anim_stopanimscripted();
	param_00 notify("ender");
}

//Function Number: 79
se_forest_takedown_01_fail_conditions(param_00,param_01)
{
	self endon("player_completed_takedown");
	var_02 = 36;
	var_03 = 1024;
	var_04 = 184;
	var_05 = 300;
	var_06 = var_02 * var_02;
	var_07 = var_03 * var_03;
	var_08 = var_04 * var_04;
	var_09 = 0.05;
	while(!common_scripts\utility::flag("flag_se_takedown_01_complete") && !common_scripts\utility::flag("forest_player_passed_takedown"))
	{
		var_0A = length(level.player getvelocity());
		var_0B = level._cloaked_stealth_settings.cloak_on;
		var_0C = level.player.origin;
		if(var_0B)
		{
			if(distancesquared(var_0C,param_00.origin) < var_06 || distancesquared(var_0C,param_01.origin) < var_06)
			{
				break;
			}
		}
		else if(distancesquared(var_0C,param_00.origin) < var_07 || distancesquared(var_0C,param_01.origin) < var_07)
		{
			if(param_00 cansee(level.player) || param_01 cansee(level.player))
			{
				break;
			}
		}

		if(distancesquared(var_0C,param_00.origin) < var_08 || distancesquared(var_0C,param_01.origin) < var_08)
		{
			if(var_0A > var_05)
			{
				break;
			}
		}

		wait(var_09);
	}

	wait(0.05);
	if(!common_scripts\utility::flag("flag_se_takedown_01_started") || common_scripts\utility::flag("forest_player_passed_takedown"))
	{
		self notify("takedown_failed");
		level notify("se_takedown_01_failed");
		common_scripts\utility::flag_set("flag_disable_takedown_hint");
		level.should_display_melee_hint = 0;
		common_scripts\utility::flag_clear("can_save");
		param_00 maps\_utility::set_ignoreall(0);
		param_01 maps\_utility::set_ignoreall(0);
		level._cloaked_stealth_settings.cloak_disabled = 1;
		param_00.favoriteenemy = level.player;
		param_01.favoriteenemy = level.player;
		param_00 maps\_utility::set_baseaccuracy(999);
		param_01 maps\_utility::set_baseaccuracy(999);
		param_00 maps\_utility::magic_bullet_shield();
		param_01 maps\_utility::magic_bullet_shield();
		param_00 setgoalentity(level.player);
		param_01 setgoalentity(level.player);
		param_00.goalradius = 20;
		param_01.goalradius = 20;
		param_00.combatmode = "no_cover";
		param_01.combatmode = "no_cover";
		param_00 notify("end_patrol");
		param_01 notify("end_patrol");
		param_00 notify("enemy");
		param_01 notify("enemy");
		level notify("patrol_alerted");
		common_scripts\utility::flag_set("_stealth_spotted");
		maps\_cloak::cloak_device_hit_by_electro_magnetic_pulse();
		level.player enablehealthshield(0);
		for(;;)
		{
			param_00 waittill("shooting");
			level.player dodamage(level.player.maxhealth / 3,param_00 gettagorigin("tag_flash"),param_00);
		}
	}
}

//Function Number: 80
se_forest_takedown_01_distance_think()
{
	level endon("flag_slowly_dialogue_start");
	level endon("se_takedown_01_failed");
	for(;;)
	{
		if(maps\_utility::players_within_distance(300,level.guy_1.origin))
		{
			common_scripts\utility::flag_set("flag_slowly_dialogue_start");
		}

		wait(0.1);
	}
}

//Function Number: 81
se_burke_takedown_01(param_00)
{
	var_01 = [level.burke,level.guy_2];
	level.guy_2.allowdeath = 1;
	level.guy_2.a.nodeath = 1;
	level.guy_2 maps\_utility::set_battlechatter(0);
	level.guy_2 setcontents(0);
	level.guy_2 common_scripts\utility::delaycall(14,::setanimrate,level.guy_2 maps\_utility::getanim("forest_disarm"),0);
	thread maps\lab_utility::ai_kill_when_out_of_sight(level.guy_2,1024);
	param_00 maps\_anim::anim_single_run(var_01,"forest_disarm");
	level.burke maps\_utility::set_moveplaybackrate(0.8);
	level.burke maps\_utility::enable_cqbwalk();
}

//Function Number: 82
se_vehicle_takedown_01()
{
	self endon("takedown_failed");
	level endon("flag_se_vehicle_takedown_01_failed");
	thread maps\lab_lighting::vrap_takedown_lights_on();
	thread maps\lab_lighting::lighting_vehicle_takedown_01_on();
	var_00 = common_scripts\utility::getstruct("vrap_takedown_org","targetname");
	var_01 = spawn("script_origin",var_00.origin);
	var_02 = spawn("script_origin",var_00.origin);
	if(isdefined(var_00.angles))
	{
		var_01.angles = var_00.angles;
		var_02.angles = var_00.angles;
	}

	var_03 = getent("blocker_vrap_takedown_door","targetname");
	var_03.origin = var_03.origin + (0,0,10000);
	var_03 disconnectpaths();
	var_04 = getent("vrap_01","targetname") maps\_utility::spawn_vehicle();
	var_05 = maps\_utility::spawn_targetname("enemy_vrap_01");
	var_06 = maps\_utility::spawn_targetname("enemy_vrap_02");
	var_04.animname = "vrap";
	var_05.animname = "vrap_guy_1";
	var_06.animname = "vrap_guy_2";
	var_05.allowdeath = 1;
	var_05.diequietly = 1;
	var_06.diequietly = 1;
	var_05.health = 1;
	var_06.health = 1;
	var_05.found = 1;
	var_06.found = 1;
	var_07 = [var_04,var_05];
	var_08 = [var_06];
	var_06.vehicle_idle_override = var_06 maps\_utility::getanim("vrap_takedown_idle");
	var_06 notify("enteredvehicle");
	var_04 thread maps\_utility::guy_enter_vehicle(var_06);
	var_06.allowdeath = 1;
	var_09 = "vrap_takedown_ender";
	var_01 thread maps\_anim::anim_loop(var_07,"vrap_takedown_idle",var_09);
	thread se_vehicle_takedown_fail_conditions(var_05,var_06,var_01,var_02,var_09,var_04);
	thread se_vehicle_takedown_stealth_alert_check(var_05,1);
	thread se_vehicle_takedown_stealth_alert_check(var_06,0);
	common_scripts\utility::flag_wait("flag_vehicle_takedown_01");
	soundscripts\_snd::snd_message("truck_takedown_radio",var_05);
	if(!common_scripts\utility::flag("flag_forest_player_alt_path_01"))
	{
		se_vehicle_mute_charge(var_01);
		thread maps\lab_utility::enable_takedown_hint(var_05,101);
		var_0A = common_scripts\utility::spawn_tag_origin();
		var_0A.origin = var_05.origin + (0,0,52);
		var_0A linkto(var_05,"j_neck");
		var_05 thread maps\lab_utility::activate_takedown_world_prompt_on_truck_enemy(self);
		self waittill("player_completed_takedown");
		level.player setstance("stand");
		common_scripts\utility::flag_set("flag_vehicle_takedown_01_start");
		thread maps\lab_lighting::lighting_vehicle_takedown_01(var_05);
		var_05 maps\_stealth_utility::disable_stealth_for_ai();
		var_06 maps\_stealth_utility::disable_stealth_for_ai();
		level.player maps\_shg_utility::setup_player_for_scene(1);
		maps\_player_exo::player_exo_deactivate();
		level.player maps\_utility::set_ignoreme(1);
		var_06 = maps\_vehicle_aianim::convert_guy_to_drone(var_06);
		var_06.animname = "vrap_guy_2";
		var_01 notify(var_09);
		var_02 notify(var_09);
		level.player_rig = maps\lab_utility::spawn_player_rig();
		level.player_rig.animname = "player_rig";
		level.player_rig hide();
		level.player playerlinktoblend(level.player_rig,"tag_player",0.2);
		level.player_rig common_scripts\utility::delaycall(0.2,::show);
		var_0B = [var_04,var_05,var_06,level.burke,level.player_rig];
		soundscripts\_snd::snd_message("truck_takedown");
		thread vehicle_takedown_rumbles();
		thread award_player_exo_challenge_kill_for_scene();
		var_01 maps\_anim::anim_single(var_0B,"vrap_takedown");
		var_05 maps\_utility::pretend_to_be_dead();
		level.player unlink();
		level.player freezecontrols(0);
		level.player enableweapons();
		level.player maps\_shg_utility::setup_player_for_gameplay();
		maps\_player_exo::player_exo_activate();
		level.player_rig delete();
		level.player maps\_utility::set_ignoreme(0);
		var_03 connectpaths();
		var_03 delete();
		var_01 notify(var_09);
		var_02 notify(var_09);
		var_01 delete();
		var_02 delete();
	}

	common_scripts\utility::flag_set("flag_se_vehicle_takedown_01_complete");
	thread maps\_utility::autosave_stealth();
}

//Function Number: 83
se_vehicle_mute_charge(param_00)
{
	self endon("takedown_failed");
	var_01 = maps\_utility::spawn_anim_model("vrap_mute");
	var_01 hide();
	var_02 = getent("vrap_mute_hint","targetname");
	level.vrap_mute_obj = spawn("script_model",(0,0,0));
	level.vrap_mute_obj setmodel("mutecharge_obj");
	level.vrap_mute_obj.angles = var_02.angles;
	level.vrap_mute_obj.origin = var_02.origin;
	level.vrap_mute_trig = getent("trig_vrap_mute","targetname");
	level.vrap_mute_trig thread maps\_utility::addhinttrigger(&"LAB_PLANT_MUTE_HINT",&"LAB_PLANT_MUTE_HINT_PC");
	level.vrap_mute_trig.button = level.vrap_mute_trig maps\_shg_utility::hint_button_trigger("x");
	thread vehicle_mute_charge_failed();
	common_scripts\utility::flag_wait("flag_vrap_mute_start");
	while(isdefined(level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim) && level._cloaked_stealth_settings.playing_view_model_cloak_toggle_anim == 1)
	{
		wait(0.05);
	}

	level.player_rig = maps\lab_utility::spawn_player_rig();
	level.player_rig hide();
	var_03 = [level.player_rig,var_01];
	param_00 thread maps\_anim::anim_first_frame(var_03,"vrap_mute");
	level.vrap_mute_trig thread maps\_utility::addhinttrigger("","");
	level.vrap_mute_trig.button maps\_shg_utility::hint_button_clear();
	soundscripts\_snd::snd_message("lab_mute_gun_holster");
	level.player maps\_shg_utility::setup_player_for_scene(1);
	maps\_player_exo::player_exo_deactivate();
	level.player playerlinktoblend(level.player_rig,"tag_player",0.5);
	wait(0.5);
	var_01 thread maps\_cloak::activate_mute_volume(350,20);
	var_01 soundscripts\_snd::snd_message("aud_vrap_mute_start",350,20);
	level.vrap_mute_obj hide();
	level.player_rig show();
	var_01 show();
	thread mute_charge_01_rumbles();
	param_00 maps\_anim::anim_single(var_03,"vrap_mute");
	level.player unlink();
	level.player enableweapons();
	level.player freezecontrols(0);
	level.player maps\_shg_utility::setup_player_for_gameplay();
	maps\_player_exo::player_exo_activate();
	level.player_rig delete();
}

//Function Number: 84
mute_charge_01_rumbles()
{
	maps\lab_utility::setup_level_rumble_ent();
	wait(0.65);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.4,0.2);
	wait(0.5);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.3,0.75);
}

//Function Number: 85
vehicle_takedown_rumbles()
{
	wait(0.93);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.7,0.2);
	wait(1);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.7,0.2);
}

//Function Number: 86
vehicle_mute_charge_failed()
{
	self endon("player_completed_takedown");
	level endon("flag_vrap_mute_start");
	common_scripts\utility::waittill_any_ents(self,"takedown_failed",level,"flag_se_vehicle_takedown_01_failed");
	thread vehicle_mute_charge_cleanup();
}

//Function Number: 87
vehicle_mute_charge_cleanup()
{
	if(isdefined(level.vrap_mute_obj))
	{
		level.vrap_mute_obj delete();
	}

	if(isdefined(level.vrap_mute_trig))
	{
		if(isdefined(level.vrap_mute_trig.button))
		{
			level.vrap_mute_trig.button maps\_shg_utility::hint_button_clear();
		}

		level.vrap_mute_trig delete();
	}
}

//Function Number: 88
se_vehicle_takedown_fail_conditions(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("player_completed_takedown");
	thread se_vehicle_takedown_fail_condition_guy(param_00,param_02,param_04,1,param_05);
	thread se_vehicle_takedown_fail_condition_guy(param_01,param_03,param_04,0,param_05);
	common_scripts\utility::waittill_any_ents(param_00,"death",param_01,"death");
	if(level.player maps\_utility::ent_flag_exist("_stealth_in_mute_radius") && level.player maps\_utility::ent_flag("_stealth_in_mute_radius"))
	{
		if(isdefined(param_00))
		{
			param_00 maps\_stealth_utility::disable_stealth_for_ai();
		}

		if(isdefined(param_01))
		{
			param_01 maps\_stealth_utility::disable_stealth_for_ai();
			param_01 = maps\_vehicle_aianim::convert_guy_to_drone(param_01);
			param_01.animname = "vrap_guy_2";
			param_03 thread maps\_anim::anim_single_solo(param_01,"vrap_takedown");
			param_03 maps\_utility::delaythread(0.05,::maps\_anim::anim_set_time,[param_01],"vrap_takedown",1);
			param_01 setanimrate(param_01 maps\_utility::getanim("vrap_takedown"),0);
			param_01 kill(level.burke.origin,level.burke);
		}

		if(!isdefined(param_00) || !isalive(param_00))
		{
			if(isdefined(param_01) && isalive(param_01))
			{
				param_01 kill(level.burke.origin,level.burke);
			}
		}

		if(!isdefined(param_01) || !isalive(param_01))
		{
			if(isdefined(param_00) && isalive(param_00))
			{
				param_00 kill(level.burke.origin,level.burke);
			}
		}
	}
	else
	{
		common_scripts\utility::flag_set("_stealth_spotted");
		maps\_cloak::cloak_device_hit_by_electro_magnetic_pulse();
	}

	self notify("takedown_failed");
	common_scripts\utility::flag_set("flag_disable_takedown_hint");
	common_scripts\utility::flag_set("flag_se_vehicle_takedown_01_failed");
	common_scripts\utility::flag_set("flag_se_vehicle_takedown_01_complete");
	level.should_display_melee_hint = 0;
}

//Function Number: 89
se_vehicle_takedown_stealth_alert_check(param_00,param_01)
{
	param_00 endon("death");
	if(param_01)
	{
		common_scripts\utility::waittill_any_ents(param_00,"patrol_alerted",param_00,"_stealth_spotted",param_00,"stealth_event",param_00,"_stealth_found_corpse",param_00,"alerted",param_00,"enemy",param_00,"touch");
	}
	else
	{
		common_scripts\utility::waittill_any_ents(param_00,"patrol_alerted",param_00,"_stealth_spotted",param_00,"stealth_event",param_00,"_stealth_found_corpse",param_00,"alerted",param_00,"enemy");
	}

	param_00 notify("alerted");
}

//Function Number: 90
se_vehicle_takedown_fail_condition_guy(param_00,param_01,param_02,param_03,param_04)
{
	self endon("player_completed_takedown");
	param_00 endon("death");
	var_05 = param_00 maps\_stealth_shared_utilities::ai_get_behavior_function("animation","wrapper");
	param_00 maps\_stealth_shared_utilities::ai_create_behavior_function("animation","wrapper",::se_vehicle_takedown_dummyfunc);
	param_00 maps\_utility::ent_flag_set("_stealth_behavior_reaction_anim");
	param_00._stealth.debug_state = "hanging around";
	param_00 waittill("alerted");
	param_01 notify(param_02);
	self notify("takedown_failed");
	common_scripts\utility::flag_set("flag_disable_takedown_hint");
	common_scripts\utility::flag_set("flag_se_vehicle_takedown_01_failed");
	common_scripts\utility::flag_set("flag_se_vehicle_takedown_01_complete");
	level.should_display_melee_hint = 0;
	if(param_03)
	{
		waittillframeend;
		param_01 maps\_anim::anim_single_solo(param_00,"vrap_takedown_fail");
		param_00 maps\_stealth_shared_utilities::ai_create_behavior_function("animation","wrapper",var_05);
	}
	else
	{
		param_04 maps\_vehicle::vehicle_unload();
		param_00 waittill("jumpedout");
		param_00 maps\_stealth_shared_utilities::ai_create_behavior_function("animation","wrapper",var_05);
	}

	param_00 maps\_utility::ent_flag_clear("_stealth_behavior_reaction_anim");
}

//Function Number: 91
se_vehicle_takedown_dummyfunc(param_00)
{
}

//Function Number: 92
drones_logging_road()
{
	var_00 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("drones_logging_road_wave_1");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::ent_flag_set("fire_disabled");
		var_02.ignoreme = 1;
		var_02 thread maps\lab_fx::drone_search_light_fx();
		thread search_drone_behavior(var_02);
	}

	common_scripts\utility::flag_wait("flag_se_vehicle_takedown_01_complete");
	wait(0.1);
	var_00 = maps\_vehicle::spawn_vehicles_from_targetname_and_drive("drones_logging_road_wave_1");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::ent_flag_set("fire_disabled");
		var_02.ignoreme = 1;
		var_02 thread maps\lab_fx::drone_search_light_fx();
		thread search_drone_behavior(var_02);
	}
}

//Function Number: 93
se_mech_march()
{
	if(common_scripts\utility::flag("flag_logging_road_loud_combat"))
	{
		return;
	}

	level endon("flag_logging_road_loud_combat");
	common_scripts\utility::flag_wait("flag_se_mech_march_start");
	if(!common_scripts\utility::flag("flag_se_vehicle_takedown_01_complete"))
	{
		common_scripts\utility::flag_set("flag_se_vehicle_takedown_01_failed");
		common_scripts\utility::flag_set("flag_se_vehicle_takedown_01_complete");
	}

	level notify("dog_barks_stop");
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("gaz_mech_march_02");
	var_00 soundscripts\_snd::snd_message("gaz_04_slow_by");
	var_00 maps\_vehicle::vehicle_lights_on();
	var_00 thread maps\lab_fx::logging_road_mud_tracks_2();
	var_00 thread forest_stealth_gaz_think();
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("brt_mech_march_01");
	var_01 soundscripts\_snd::snd_message("gaz_05_slow_by");
	var_01 thread maps\lab_fx::logging_road_mud_tracks_2();
	var_01 thread forest_stealth_gaz_think();
	var_00 thread maps\lab_lighting::logging_road_gaz_headlight_moment();
	var_02 = getentarray("combat_mech_march_runner","script_noteworthy");
	foreach(var_04 in var_02)
	{
		var_04 maps\_utility::spawn_ai(1,0);
		wait(randomfloatrange(0.1,0.25));
	}

	var_02 = getentarray("combat_mech_march","script_noteworthy");
	foreach(var_04 in var_02)
	{
		var_07 = var_04 maps\_utility::spawn_ai(1,0);
		var_07 thread mech_march_footstep_rumbles();
	}

	var_09 = getent("combat_mech_march_05","script_noteworthy");
	var_0A = var_09 maps\_utility::spawn_ai(1,0);
	var_0A thread mech_march_footstep_rumbles();
	var_02 = getentarray("combat_mech_march_follower","script_noteworthy");
	foreach(var_04 in var_02)
	{
		var_04 maps\_utility::spawn_ai(1,0);
	}
}

//Function Number: 94
mech_march_footstep_rumbles()
{
	level endon("flag_logging_road_loud_combat");
	self endon("death");
	for(;;)
	{
		self waittill("moveanim",var_00);
		if(var_00 == "footstep_rumble")
		{
			var_01 = 300;
			var_02 = distance(self.origin,level.player.origin);
			if(var_02 < var_01)
			{
				maps\lab_utility::setup_level_rumble_ent();
				var_03 = var_01 - var_02 / var_01;
				thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,var_03,0.25);
				wait(0.25);
			}
			else
			{
				wait 0.05;
			}

			continue;
		}

		wait 0.05;
	}
}

//Function Number: 95
mech_march_follower_enemy_think()
{
	self endon("death");
	force_patrol_anim_set("gundown",0);
	maps\_utility::set_moveplaybackrate(0.9);
}

//Function Number: 96
mech_march_runner_enemy_think()
{
	self endon("death");
	force_patrol_anim_set("patroljog",0);
	maps\_utility::set_moveplaybackrate(1.1);
}

//Function Number: 97
disable_rappel_trigger_monitor()
{
	level endon("flag_rappel_start");
	var_00 = getent("rappel_cancel_trigger","targetname");
	var_01 = getent("rappel_use_trigger","targetname");
	var_00 waittill("trigger");
	var_01 common_scripts\utility::trigger_off();
}

//Function Number: 98
se_cormack_meet()
{
	thread disable_rappel_trigger_monitor();
	common_scripts\utility::flag_wait("flag_logging_road_complete");
	level.nextgrenadedrop = -1;
	if(common_scripts\utility::flag("flag_logging_road_loud_combat"))
	{
		common_scripts\utility::flag_set("flag_vo_stealth_recovered");
	}

	level notify("patrol_radios_stop");
	level notify("aud_start_clearing_damb");
	common_scripts\utility::flag_wait("flag_cormack_meet_init");
	common_scripts\utility::flag_set("flag_obj_crawl_under_log");
	thread maps\lab_lighting::cliff_rappel_lighting_setup();
	thread maps\lab_lighting::cliff_rappel();
	var_00 = common_scripts\utility::getstruct("cliff_rappel_org","targetname");
	se_cormack_meet_init();
	level.burke thread burke_disable_cqb();
	level.knox.ignoreme = 1;
	var_01 = getnode("node_burke_cover_rappel","targetname");
	level.burke thread maps\lab_utility::goto_node(var_01,0);
	var_02 = [level.cormack,level.knox];
	var_00 thread maps\_anim::anim_loop(var_02,"cliff_meetup_idle","ender");
	var_03 = spawn("script_model",var_00.origin);
	var_03 setmodel("rope_carabiner");
	var_03.animname = "carabiner_burke";
	var_03 maps\_anim::setanimtree();
	var_04 = spawn("script_model",var_00.origin);
	var_04 setmodel("rope_carabiner");
	var_04.animname = "carabiner_cormack";
	var_04 maps\_anim::setanimtree();
	var_05 = spawn("script_model",var_00.origin);
	var_05 setmodel("rope_carabiner");
	var_05.animname = "carabiner_knox";
	var_05 maps\_anim::setanimtree();
	var_05 overridematerial("mtl_rope_carabiner","mtl_rope_carabiner_cloak");
	level.carabiner_knox = var_05;
	var_06 = spawn("script_model",var_00.origin);
	var_06 setmodel("lab_anchor_system");
	var_06.animname = "anchor_system_burke";
	var_06 maps\_anim::setanimtree();
	var_07 = spawn("script_model",var_00.origin);
	var_07 setmodel("lab_anchor_system");
	var_07.animname = "anchor_system_cormack";
	var_07 maps\_anim::setanimtree();
	var_08 = spawn("script_model",var_00.origin);
	var_08 setmodel("lab_anchor_system");
	var_08.animname = "anchor_system_knox";
	var_08 maps\_anim::setanimtree();
	var_09 = spawn("script_model",var_00.origin);
	var_09 setmodel("rope30ft_120j");
	var_09.animname = "rope_30_burke";
	var_09 maps\_anim::setanimtree();
	var_0A = spawn("script_model",var_00.origin);
	var_0A setmodel("rope30ft_120j");
	var_0A.animname = "rope_30_cormack";
	var_0A maps\_anim::setanimtree();
	var_0B = spawn("script_model",var_00.origin);
	var_0B setmodel("rope30ft_120j");
	var_0B.animname = "rope_30_knox";
	var_0B maps\_anim::setanimtree();
	var_0B overridematerial("mtl_rope_blk","mtl_rope_blk_cloak");
	level.rope_knox = var_0B;
	var_0C = [var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B];
	var_00 thread maps\_anim::anim_first_frame(var_0C,"cliff_meetup");
	common_scripts\utility::flag_wait("flag_cormack_meet_start");
	soundscripts\_snd::snd_message("aud_burke_nearing_cliff");
	var_00 maps\_anim::anim_reach_solo(level.burke,"cliff_meetup");
	level.burke thread maps\lab_utility::cloak_off();
	level.cormack maps\_utility::anim_stopanimscripted();
	level.knox maps\_utility::anim_stopanimscripted();
	common_scripts\utility::flag_set("flag_cliff_rappel_dialogue_start");
	level.burke pushplayer(0);
	level.burke.dontavoidplayer = 0;
	level.burke.dontchangepushplayer = undefined;
	var_00 notify("ender");
	var_02 = [level.cormack,level.knox,level.burke,var_06,var_07,var_08,var_09,var_0A,var_0B,var_03,var_04,var_05];
	maps\_utility::delaythread(12,::equip_player);
	var_00 maps\_anim::anim_single(var_02,"cliff_meetup");
	var_0D = [level.burke,var_09];
	var_00 thread maps\_anim::anim_loop(var_0D,"cliff_meetup_rappel_idle","ender");
	var_0E = getnode("node_knox_rappel_1","targetname");
	var_0F = getnode("node_cormack_rappel_1","targetname");
	level.knox maps\lab_utility::goto_node(var_0E,0);
	level.cormack maps\lab_utility::goto_node(var_0F,0);
	level.cormack thread maps\lab_utility::cloak_on();
	level.knox thread maps\lab_utility::cloak_on();
	var_10 = getent("cliff_clip_cormack","targetname");
	var_10 delete();
	common_scripts\utility::flag_set("flag_player_ready_to_rappel");
	thread maps\lab_vo::cliff_rappel_dialogue_nag();
	var_11 = getent("rappel_use_trigger","targetname");
	var_11 thread maps\_utility::addhinttrigger(&"LAB_RAPPEL_HINT",&"LAB_RAPPEL_HINT_PC");
	var_12 = var_11 maps\_shg_utility::hint_button_trigger("x");
	var_11 thread maps\lab_utility::disable_trigger_while_player_animating("flag_rappel_start");
	common_scripts\utility::flag_wait("flag_rappel_start");
	common_scripts\utility::flag_clear("flag_player_cloak_enabled");
	thread cleanup_ai_logging_road();
	level.knox.ignoreme = 0;
	soundscripts\_snd::snd_message("aud_rappel_player_hookup");
	var_13 = [var_06,var_07,var_08,var_09,var_0A,var_0B,var_03,var_04,var_05];
	thread rope_end_rappel(var_00,var_13);
	thread courtyard_rappel_preview();
	common_scripts\utility::flag_set("flag_rappel_start_lighting");
	common_scripts\utility::flag_set("flag_cliff_rappeling_dialogue_start");
	var_11 thread maps\_utility::addhinttrigger("","");
	var_12 maps\_shg_utility::hint_button_clear();
	var_14 = spawn("script_model",var_00.origin);
	var_14 hide();
	var_14 setmodel("rope30ft_240j");
	var_14.animname = "rope_vm";
	var_14 maps\_anim::setanimtree();
	var_15 = spawn("script_model",var_00.origin);
	var_15 hide();
	var_15 setmodel("rope_carabiner");
	var_15.animname = "carabiner_vm";
	var_15 maps\_anim::setanimtree();
	var_16 = spawn("script_model",var_00.origin);
	var_16 hide();
	var_16 setmodel("lab_anchor_system");
	var_16.animname = "anchor_system";
	var_16 maps\_anim::setanimtree();
	level.player maps\_shg_utility::setup_player_for_scene(1);
	maps\_player_exo::player_exo_deactivate();
	level.player_rig = maps\lab_utility::spawn_player_rig();
	level.player_rig hide();
	var_17 = 1;
	level.player playerlinktoblend(level.player_rig,"tag_player",var_17);
	level.player common_scripts\utility::delaycall(2,::playerlinktodelta,level.player_rig,"tag_player",1,0,0,0,0,1);
	level.player enableslowaim(0.4,0.25);
	level.player_rig common_scripts\utility::delaycall(var_17,::show);
	var_16 common_scripts\utility::delaycall(var_17,::show);
	var_18 = getent("cliff_clip_gideon","targetname");
	var_18 delete();
	thread player_rappel(var_00,var_14,var_15,var_16);
	level.burke maps\_utility::anim_stopanimscripted();
	var_00 notify("ender");
	thread burke_rappel(var_00,var_09);
}

//Function Number: 99
burke_disable_cqb()
{
	common_scripts\utility::flag_wait("flag_seeker_clear");
	maps\_utility::disable_cqbwalk();
}

//Function Number: 100
burke_rappel(param_00,param_01)
{
	var_02 = spawn("script_model",param_00.origin);
	var_02 hide();
	var_02 setmodel("rope150ft_240j");
	var_02.animname = "rope_150_burke";
	var_02 maps\_anim::setanimtree();
	level.burke_rope_long = var_02;
	level.burke_rope = param_01;
	var_03 = [level.burke,param_01,var_02];
	param_00 maps\_anim::anim_single(var_03,"cliff_jump");
	level.burke thread maps\lab_utility::cloak_on();
	level.burke maps\_utility::place_weapon_on("iw5_hbra3_sp_silencer01_variablereddot","right");
	var_02 delete();
}

//Function Number: 101
player_rappel(param_00,param_01,param_02,param_03)
{
	level notify("aud_stop_clearing_damb");
	param_01 common_scripts\utility::delaycall(1,::show);
	param_02 common_scripts\utility::delaycall(1,::show);
	var_04 = spawn("script_model",param_00.origin);
	var_04 hide();
	var_04 setmodel("weapon_rappel_rope_long");
	var_04.animname = "rope_vm_long";
	var_04 maps\_anim::setanimtree();
	level.player_rope_long = var_04;
	level.player_rope = param_01;
	var_05 = [level.player_rig,param_01,var_04,param_02,param_03];
	thread play_cliff_rappel_animation(param_00,level.player_rig,var_05);
	thread player_rappel_control(param_00,level.player_rig,var_05);
	level.player_rig waittill("cliff_jump");
	level notify("cliff_rappel_landing");
	level.player unlink();
	level.player freezecontrols(0);
	level.player enableweapons();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	maps\_player_exo::player_exo_activate();
	level.player_rig delete();
	level.player disableslowaim();
	common_scripts\utility::flag_set("flag_player_cloak_enabled");
	soundscripts\_snd::snd_message("player_rappel_complete");
	var_04 delete();
	maps\_utility::autosave_by_name();
	if(level.currentgen)
	{
		level notify("tff_pre_intro_to_middle");
		unloadtransient("lab_intro_tr");
		loadtransient("lab_middle_tr");
		while(!istransientloaded("lab_middle_tr"))
		{
			wait(0.05);
		}

		level notify("tff_post_intro_to_middle");
	}
}

//Function Number: 102
rope_end_rappel(param_00,param_01)
{
	level waittill("cliff_rappel_landing");
	foreach(var_03 in param_01)
	{
		var_03 delete();
	}

	var_05 = spawn("script_model",param_00.origin);
	var_05 setmodel("rope150ft_240j");
	var_05.animname = "rope_150_knox_end";
	var_05 maps\_anim::setanimtree();
	var_06 = spawn("script_model",param_00.origin);
	var_06 setmodel("rope150ft_240j");
	var_06.animname = "rope_150_cormack_end";
	var_06 maps\_anim::setanimtree();
	var_07 = spawn("script_model",param_00.origin);
	var_07 setmodel("rope150ft_240j");
	var_07.animname = "rope_150_burke_end";
	var_07 maps\_anim::setanimtree();
	var_08 = spawn("script_model",param_00.origin);
	var_08 setmodel("rope150ft_240j");
	var_08.animname = "rope_150_player_end";
	var_08 maps\_anim::setanimtree();
	var_09 = [var_05,var_06,var_07,var_08];
	param_00 maps\_anim::anim_loop(var_09,"cliff_jump_end");
}

//Function Number: 103
player_input_rappel_hint_off()
{
	return level.player getnormalizedmovement()[0] < -0.1;
}

//Function Number: 104
player_rappel_control(param_00,param_01,param_02)
{
	param_01 endon("cliff_jump");
	var_03 = 1;
	var_04 = 1;
	var_05 = 1;
	var_06 = 1;
	var_07 = 0.1;
	common_scripts\utility::flag_wait("flag_rappel_player_input_start");
	thread rappel_control_hint();
	level.player lerpviewangleclamp(1,0.5,0,10,20,20,30);
	if(0)
	{
		thread camera_view_tuning(param_01);
	}

	if(0)
	{
		thread camera_sway_tuning();
	}

	thread player_rappel_camera_sway(param_01,1);
	for(;;)
	{
		if(common_scripts\utility::flag("flag_rappel_player_input_stop"))
		{
			maps\_anim::anim_set_rate(param_02,"cliff_jump",1);
			thread player_rappel_camera_sway(param_01,0);
			return;
		}

		var_08 = level.player getnormalizedmovement();
		if(var_08[0] < 0)
		{
			var_06 = var_08[0] * -1;
		}
		else
		{
			var_06 = 0;
		}

		if(var_06 > 0)
		{
			soundscripts\_snd::snd_message("aud_rappel_player_movement_start",param_01);
			level.player_is_rappelling = 1;
		}
		else
		{
			soundscripts\_snd::snd_message("aud_rappel_player_movement_stop",param_01);
		}

		var_09 = abs(var_06 - var_04);
		if(var_09 > 0.01)
		{
			if(var_09 > 0.5)
			{
				var_07 = 0.1;
			}
			else
			{
				var_07 = 0.03;
			}

			if(var_06 > var_04)
			{
				var_04 = var_04 + var_07;
				if(var_04 > 1)
				{
					var_04 = 1;
				}
			}
			else
			{
				var_04 = var_04 - var_07;
				if(var_04 < 0)
				{
					var_04 = 0;
					level.player_is_rappelling = 0;
				}
			}

			maps\_anim::anim_set_rate(param_02,"cliff_jump",var_04);
		}

		wait 0.05;
	}
}

//Function Number: 105
rappel_control_hint()
{
	wait(1.5);
	maps\_utility::hintdisplayhandler("player_input_rappel_hint");
}

//Function Number: 106
play_cliff_rappel_animation(param_00,param_01,param_02)
{
	thread rappel_animation_rumbles();
	param_00 maps\_anim::anim_single(param_02,"cliff_jump");
	param_01 notify("cliff_jump");
}

//Function Number: 107
rappel_animation_rumbles()
{
	maps\lab_utility::setup_level_rumble_ent();
	wait(1.15);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.8,0.4);
	wait(2.4);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.3,0.3);
	wait(7.4);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.4,0.5);
	wait(3.75);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.1,3.75);
	thread rappel_rumbles();
}

//Function Number: 108
rappel_rumbles()
{
	level endon("cliff_rappel_landing");
	while(!isdefined(level.player_is_rappelling))
	{
		wait(0.5);
	}

	maps\lab_utility::setup_level_rumble_ent();
	for(;;)
	{
		if(level.player_is_rappelling == 1)
		{
			thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.1,0.4);
		}

		wait(0.5);
	}
}

//Function Number: 109
player_rappel_camera_sway(param_00,param_01)
{
	param_00 endon("cliff_jump");
	param_00 notify("killduplicatethread");
	param_00 endon("killduplicatethread");
	if(!param_01)
	{
		return;
	}

	for(;;)
	{
		if(0)
		{
			screenshake(level.player.origin,level.values[0],level.values[1],level.values[2],level.values[3],level.values[4],level.values[5],level.values[6],level.values[7],level.values[8],level.values[9]);
		}
		else
		{
			screenshake(level.player.origin,0.2,4.1,0.56,2,0.95,0,0,0.4,0.1,0.1);
		}

		wait(1);
	}
}

//Function Number: 110
camera_sway_tuning()
{
	level.values[0] = 0.2;
	level.values[1] = 4.1;
	level.values[2] = 0.56;
	level.values[3] = 2;
	level.values[4] = 0.95;
	level.values[5] = 0;
	level.values[6] = 0;
	level.values[7] = 0.4;
	level.values[8] = 0.1;
	level.values[9] = 0.1;
	var_00[0] = "scalePitch";
	var_00[1] = "scaleyaw";
	var_00[2] = "scaleroll";
	var_00[3] = "duration";
	var_00[4] = "durationfadeup";
	var_00[5] = "durationfadedown";
	var_00[6] = "radius";
	var_00[7] = "frequencypitch";
	var_00[8] = "frequencyyaw";
	var_00[9] = "frequencyroll";
	var_01 = 0;
	var_02 = 0;
	for(;;)
	{
		if(level.player buttonpressed("DPAD_LEFT"))
		{
			var_01++;
			if(var_01 >= var_00.size)
			{
				var_01 = 0;
			}

			var_02 = 1;
			wait(0.5);
		}
		else if(level.player buttonpressed("DPAD_RIGHT"))
		{
			var_01--;
			if(var_01 < 0)
			{
				var_01 = var_00.size - 1;
			}

			var_02 = 1;
			wait(0.5);
		}
		else if(level.player buttonpressed("DPAD_UP"))
		{
			level.values[var_01] = level.values[var_01] + 0.05;
			var_02 = 1;
		}
		else if(level.player buttonpressed("DPAD_DOWN"))
		{
			level.values[var_01] = level.values[var_01] - 0.05;
			var_02 = 1;
		}

		if(var_02)
		{
			var_03 = "selected(" + var_00[var_01] + ") ";
			for(var_04 = 0;var_04 < var_00.size;var_04++)
			{
				var_03 = var_03 + var_00[var_04] + "(" + level.values[var_04] + ") ";
			}

			iprintln(var_03);
			var_02 = 0;
		}

		wait 0.05;
	}
}

//Function Number: 111
camera_view_tuning(param_00)
{
	param_00 endon("cliff_jump");
	level.values[0] = 10;
	level.values[1] = 30;
	level.values[2] = 30;
	level.values[3] = 45;
	var_01[0] = "right";
	var_01[1] = "left";
	var_01[2] = "top";
	var_01[3] = "bottom";
	var_02 = 0;
	var_03 = 0;
	for(;;)
	{
		if(level.player buttonpressed("DPAD_LEFT"))
		{
			var_02++;
			if(var_02 >= var_01.size)
			{
				var_02 = 0;
			}

			var_03 = 1;
			wait(0.5);
		}
		else if(level.player buttonpressed("DPAD_RIGHT"))
		{
			var_02--;
			if(var_02 < 0)
			{
				var_02 = var_01.size - 1;
			}

			var_03 = 1;
			wait(0.5);
		}
		else if(level.player buttonpressed("DPAD_UP"))
		{
			level.values[var_02] = level.values[var_02] + 0.05;
			var_03 = 1;
		}
		else if(level.player buttonpressed("DPAD_DOWN"))
		{
			level.values[var_02] = level.values[var_02] - 0.05;
			var_03 = 1;
		}

		if(var_03)
		{
			var_04 = "selected(" + var_01[var_02] + ") ";
			for(var_05 = 0;var_05 < var_01.size;var_05++)
			{
				var_04 = var_04 + var_01[var_05] + "(" + level.values[var_05] + ") ";
			}

			iprintln(var_04);
			var_03 = 0;
			level.player lerpviewangleclamp(0.2,0.1,0.1,level.values[0],level.values[1],level.values[2],level.values[3]);
		}

		wait 0.05;
	}
}

//Function Number: 112
player_rappel_rope_swap(param_00)
{
	level.player_rope_long show();
	level.player_rope hide();
}

//Function Number: 113
burke_rappel_rope_swap(param_00)
{
	level.burke_rope_long show();
	level.burke_rope hide();
}

//Function Number: 114
se_cormack_meet_init()
{
	maps\lab::spawn_cormack_common();
	level.cormack thread maps\lab_utility::cloak_on();
	maps\lab::spawn_knox_common();
	level.knox thread maps\lab_utility::cloak_on();
}

//Function Number: 115
play_rappel_pip(param_00)
{
	wait(1);
	maps\_shg_utility::play_videolog("lab_videolog_01","screen_add");
}

//Function Number: 116
se_breach_guards()
{
	maps\_utility::battlechatter_off("axis");
	level.burke maps\_utility::enable_cqbwalk();
	level.cormack maps\_utility::enable_cqbwalk();
	level.knox maps\_utility::enable_cqbwalk();
	setsaveddvar("ai_friendlyFireBlockDuration",0);
	thread maps\lab_utility::enable_all_fixed_scanners();
	var_00 = common_scripts\utility::getstruct("breach_guards_org","targetname");
	var_01 = getent("camera_breach","script_noteworthy");
	var_02 = maps\_utility::spawn_targetname("breach_guard_01",1);
	var_03 = maps\_utility::spawn_targetname("breach_guard_02",1);
	var_02.ignoreme = 1;
	var_03.ignoreme = 1;
	var_01.ignoreme = 1;
	var_02.animname = "guy_1";
	var_03.animname = "guy_2";
	var_04 = [var_02,var_03];
	var_00 thread maps\_anim::anim_loop(var_04,"breach_duards_idle","ender");
	common_scripts\utility::flag_wait("flag_facility_breach_start");
	var_05 = getnode("node_burke_shoot_camera","targetname");
	level.burke maps\_utility::disable_ai_color();
	level.burke.ignoreme = 1;
	level.burke thread maps\lab_utility::goto_node(var_05,0);
	var_06 = getnode("node_cormack_shoot_camera","targetname");
	level.cormack maps\_utility::disable_ai_color();
	level.cormack.ignoreme = 1;
	level.cormack thread maps\lab_utility::goto_node(var_06,0);
	var_07 = getnode("node_knox_shoot_camera","targetname");
	level.knox maps\_utility::disable_ai_color();
	level.knox.ignoreme = 1;
	level.knox thread maps\lab_utility::goto_node(var_07,0);
	if(isdefined(var_01.destructible_parts) && var_01.destructible_parts[0].v["health"] > 0)
	{
		var_04 = [var_01,var_02,var_03];
	}
	else
	{
		var_04 = [var_02,var_03];
	}

	common_scripts\utility::array_thread(var_04,::breach_guy_think);
	level waittill("breach_guard_damaged");
	level.burke.ignoreme = 0;
	level.cormack.ignoreme = 0;
	level.knox.ignoreme = 0;
	common_scripts\utility::flag_set("flag_breach_guards_alerted");
	var_00 notify("ender");
	wait(0.5);
	foreach(var_09 in var_04)
	{
		var_09.ignoreall = 0;
		var_09.ignoreme = 0;
		var_09.dontattackme = undefined;
		var_09.dontevershoot = undefined;
		var_09 maps\_utility::anim_stopanimscripted();
	}

	level.burke maps\_utility::set_baseaccuracy(999);
	level.cormack maps\_utility::set_baseaccuracy(999);
	level.knox maps\_utility::set_baseaccuracy(999);
	while((isdefined(var_01.destructible_parts) && var_01.destructible_parts[0].v["health"] > 0) || isdefined(var_02) && var_02.health > 0 || isdefined(var_03) && var_03.health > 0)
	{
		wait(0.05);
	}

	common_scripts\utility::flag_set("flag_breach_guards_clear");
	maps\_utility::autosave_by_name();
	common_scripts\utility::flag_wait("flag_facility_security_camera");
	common_scripts\utility::flag_set("flag_light_security_camera_off");
	var_01 notify("stop_fixed_scanner_audio");
	level.burke maps\_utility::set_baseaccuracy(0.2);
	level.cormack maps\_utility::set_baseaccuracy(0.2);
	level.knox maps\_utility::set_baseaccuracy(0.2);
	level.burke maps\_utility::disable_cqbwalk();
	level.cormack maps\_utility::disable_cqbwalk();
	level.knox maps\_utility::disable_cqbwalk();
	setsaveddvar("ai_friendlyFireBlockDuration",2000);
	level.knox maps\_utility::delaythread(2,::maps\lab_utility::cloak_off);
	level.burke maps\_utility::delaythread(3.25,::maps\lab_utility::cloak_off);
	level.cormack maps\_utility::delaythread(4.5,::maps\lab_utility::cloak_off);
}

//Function Number: 117
breach_guy_think()
{
	self.health = 1;
	self.allowdeath = 1;
	if(isai(self))
	{
		thread maps\lab_utility::disable_grenades();
		common_scripts\utility::waittill_any_ents(self,"damage",self,"_stealth_spotted",self,"stealth_event",self,"enemy",self,"weapon_fired");
	}
	else
	{
		while(self.destructible_parts[0].v["health"] > 0)
		{
			wait(0.05);
		}
	}

	level notify("breach_guard_damaged",self);
}

//Function Number: 118
se_facility_breach()
{
	common_scripts\utility::flag_wait_all("flag_facility_breach_start","flag_breach_guards_clear");
	thread maps\lab_lighting::facility_breach();
	thread maps\lab_breach::facility_breach();
	thread maps\lab_breach::facility_breach_get_burke_into_position();
	var_00 = getnode("node_cormack_facility_breach","targetname");
	level.cormack thread maps\lab_utility::goto_node(var_00,0);
	var_00 = getnode("node_knox_facility_breach","targetname");
	level.knox thread maps\lab_utility::goto_node(var_00,0);
	level waittill("breaching");
	thread facility_breach_rumbles();
	level.knox thread knox_move_to_breach_door();
	common_scripts\utility::flag_wait_any("flag_facility_breach_complete","flag_burke_kills_guy");
	var_01 = getnode("node_burke_breach_01","targetname");
	var_02 = getnode("node_cormack_breach_00","targetname");
	var_03 = getnode("node_knox_breach_01","targetname");
	level.burke maps\lab_utility::goto_node(var_01,0);
	level.cormack maps\lab_utility::goto_node(var_02,0);
	level.knox maps\lab_utility::goto_node(var_03,0);
	level.cormack thread maps\lab_utility::prevent_friendly_from_shooting_during_stealth();
	level.knox thread maps\lab_utility::prevent_friendly_from_shooting_during_stealth();
	soundscripts\_snd::snd_message("aud_lab_ambient_emitters");
	if(level.currentgen)
	{
		level notify("tff_pre_intro_audio_to_middle");
		unloadtransient("lab_intro_audio_tr");
	}
}

//Function Number: 119
facility_breach_rumbles()
{
	maps\lab_utility::setup_level_rumble_ent();
	wait(1.6);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,1,0.2);
	wait(0.65);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.3,0.75);
	wait(8.5);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.6,0.75);
}

//Function Number: 120
se_server_room_entrance()
{
	common_scripts\utility::flag_wait("flag_obj_bio_weapons_04");
	maps\_stealth_utility::disable_stealth_system();
	var_00 = common_scripts\utility::getstruct("server_room_entrance_org","targetname");
	level.monitor = spawn("script_model",var_00.origin);
	level.monitor setmodel("lab_server_monitor_01_opc");
	level.monitor.animname = "server_monitor";
	level.monitor maps\_anim::setanimtree();
	level.cormack notify("anim_reach_server_room_started");
	level.burke notify("anim_reach_server_room_started");
	level.knox notify("anim_reach_server_room_started");
	if(isdefined(level.cormack.cloak) && level.cormack.cloak == "on")
	{
		level.cormack maps\lab_utility::cloak_off();
	}

	if(isdefined(level.burke.cloak) && level.burke.cloak == "on")
	{
		level.burke maps\lab_utility::cloak_off();
	}

	if(isdefined(level.knox.cloak) && level.knox.cloak == "on")
	{
		level.knox maps\lab_utility::cloak_off();
	}

	thread burke_server_room_se(var_00);
	thread cormack_server_room_se(var_00);
	thread knox_server_room_se(var_00);
	thread enemy_server_room_se(var_00);
	level.monitor thread monitor_server_room_se(var_00);
	var_01 = getent("security_door_right_model","targetname");
	var_02 = getent("security_door_right_clip","targetname");
	var_02 linkto(var_01);
	var_02 disconnectpaths();
	var_01.orig_origin = var_01.origin;
	var_01.orig_angles = var_01.angles;
	var_03 = maps\_utility::spawn_anim_model("security_door_right",var_01.origin);
	var_00 maps\_anim::anim_first_frame_solo(var_03,"server_room_peek");
	var_01 linkto(var_03,"tag_origin_animated");
	common_scripts\utility::flag_wait_all("flag_obj_bio_weapons_05","flag_burke_server_room_ready","flag_knox_server_room_ready");
	thread play_monitor_cinematic();
	common_scripts\utility::flag_set("flag_se_server_room_start");
	common_scripts\utility::flag_set("flag_server_room_start_lighting");
	soundscripts\_snd::snd_message("aud_server_room_door_crack");
	var_00 thread maps\_anim::anim_single_solo(var_03,"server_room_peek");
	maps\_utility::add_wait(::common_scripts\utility::flag_wait,"flag_server_room_enemy_killed_by_player");
	maps\_utility::add_wait(::common_scripts\utility::flag_wait,"player_entered_server_room");
	maps\_utility::add_wait(::maps\_utility::_wait,8);
	maps\_utility::add_wait(::se_server_room_player_misses,level.player);
	maps\_utility::do_wait_any();
	var_04 = "server_room_enter";
	soundscripts\_snd::snd_message("aud_server_room_door_enter");
	common_scripts\utility::flag_set("flag_sever_room_guy_kill");
	var_02 connectpaths();
	var_05 = getent("dsm_usetrigger","targetname");
	var_05 thread maps\lab_utility::disable_trigger_while_player_animating("flag_se_server_room_exit_start");
	common_scripts\utility::flag_wait("flag_se_server_room_exit_start");
	common_scripts\utility::flag_wait("monitor_finished_animating");
	soundscripts\_snd::snd_message("aud_player_computer_gl_timing_fix");
	maps\_utility::delaythread(0.5,::common_scripts\utility::flag_set,"flag_obj_bio_weapons_hack");
	maps\_utility::delaythread(0.5,::common_scripts\utility::flag_set,"bio_weapons_hack_lighting");
	level.knox maps\_utility::anim_stopanimscripted();
	var_00 notify("ender");
	var_01 unlink();
	var_01.origin = var_01.orig_origin;
	var_01.angles = var_01.orig_angles;
	var_02 disconnectpaths();
	var_06 = spawn("script_model",var_00.origin);
	var_06 setmodel("npc_variable_grenade_lethal");
	var_06.animname = "grenade1";
	var_06 maps\_anim::setanimtree();
	var_07 = spawn("script_model",var_00.origin);
	var_07 setmodel("npc_variable_grenade_lethal");
	var_07.animname = "grenade2";
	var_07 maps\_anim::setanimtree();
	var_08 = spawn("script_model",var_00.origin);
	var_08 setmodel("npc_variable_grenade_lethal");
	var_08.animname = "grenade3";
	var_08 maps\_anim::setanimtree();
	level.player maps\_shg_utility::setup_player_for_scene(0);
	maps\_player_exo::player_exo_deactivate();
	level.player_rig = maps\lab_utility::spawn_player_rig();
	level.player_rig hide();
	var_09 = 0.5;
	maps\_utility::delaythread(var_09,::maps\_cloak::disable_cloak_system);
	level.player playerlinktoblend(level.player_rig,"tag_player",var_09);
	level.player common_scripts\utility::delaycall(var_09,::playerlinktodelta,level.player_rig,"tag_player",1,15,15,10,10);
	level.player enableslowaim(0.3,0.15);
	level.player_rig common_scripts\utility::delaycall(var_09,::show);
	var_0A = [level.knox,var_06,var_07,var_08];
	level.player_rig thread player_server_room_se_end(var_00);
	level.burke thread server_room_se_end(var_00);
	level.cormack thread server_room_se_end(var_00);
	maps\_utility::activate_trigger_with_targetname("trig_color_server_room");
	if(!common_scripts\utility::flag("flag_server_room_promo"))
	{
		var_00 maps\_utility::delaythread(0.5,::maps\_anim::anim_single_run,var_0A,"server_room_exit");
	}
	else
	{
		var_00 maps\_utility::delaythread(0.5,::maps\_anim::anim_single_run,var_0A,"server_room_exit_promo");
	}

	common_scripts\utility::flag_wait("flag_combat_research_start");
	level thread maps\lab_fx::thermite_servers_explosion();
	common_scripts\utility::flag_wait("flag_post_server_room_dialogue_complete");
	maps\_utility::autosave_by_name();
	thread open_server_room_door();
	common_scripts\utility::flag_set("flag_enable_battle_chatter");
	maps\_utility::activate_trigger_with_targetname("trig_color_research_facility_01");
}

//Function Number: 121
se_server_room_player_misses(param_00)
{
	level endon("flag_enemy_server_room_se_dead");
	param_00 common_scripts\utility::waittill_any("weapon_fired","grenade_fire");
	wait(0.1);
}

//Function Number: 122
se_server_room_player_close(param_00)
{
	level endon("flag_enemy_server_room_se_dead");
	var_01 = common_scripts\utility::getstruct("server_room_entrance_org","targetname");
	var_02 = 62500;
	while(distancesquared(param_00.origin,var_01.origin) > var_02)
	{
		wait(0.05);
	}
}

//Function Number: 123
play_monitor_cinematic()
{
	setsaveddvar("cg_cinematicfullscreen","0");
	cinematicingame("lab_uploadscreen");
	while(!iscinematicplaying())
	{
		wait(0.1);
	}

	pausecinematicingame(1);
	common_scripts\utility::flag_wait("flag_obj_bio_weapons_hack");
	pausecinematicingame(0);
	common_scripts\utility::flag_wait("flag_obj_bio_weapons_complete");
	stopcinematicingame();
	cinematicingame("lab_uploadscreen_end");
}

//Function Number: 124
monitor_interaction_rumbles()
{
	maps\lab_utility::setup_level_rumble_ent();
	wait(3.8);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.18,0.15);
	wait(0.25);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.18,0.15);
	wait(0.75);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.1,0.5);
	wait(4.3);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.18,0.15);
	wait(0.4);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.18,0.15);
	wait(0.3);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.18,0.15);
	wait(0.3);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.18,0.15);
}

//Function Number: 125
stop_monitor_cinematic()
{
	stopcinematicingame();
}

//Function Number: 126
player_server_room_se_end(param_00)
{
	if(!common_scripts\utility::flag("flag_server_room_promo"))
	{
		param_00 maps\_anim::anim_first_frame_solo(self,"server_room_exit");
	}
	else
	{
		param_00 maps\_anim::anim_first_frame_solo(self,"server_room_exit_promo");
	}

	common_scripts\utility::flag_wait("flag_obj_bio_weapons_hack");
	thread monitor_interaction_rumbles();
	if(!common_scripts\utility::flag("flag_server_room_promo"))
	{
		param_00 maps\_anim::anim_single_solo(self,"server_room_exit");
	}
	else if(!common_scripts\utility::flag("flag_demo_itiot"))
	{
		var_01 = getdvarint("g_friendlyNameDist");
		setsaveddvar("g_friendlyNameDist",0);
		param_00 maps\_anim::anim_single_solo(self,"server_room_exit_promo");
		setsaveddvar("g_friendlyNameDist",var_01);
	}

	level.player unlink();
	level.player_rig delete();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	maps\_player_exo::player_exo_activate();
	level.player disableslowaim();
	common_scripts\utility::flag_set("flag_obj_bio_weapons_complete");
	maps\_utility::autosave_by_name();
}

//Function Number: 127
open_server_room_door()
{
	soundscripts\_snd::snd_message("open_server_room_door");
	common_scripts\utility::flag_set("open_server_room_door_lighting");
	var_00 = getent("door_server_room_left","targetname");
	var_01 = getent("door_server_room_right","targetname");
	var_02 = getent("clip_door_server_room_left","targetname");
	var_03 = getent("clip_door_server_room_right","targetname");
	var_02 linkto(var_00);
	var_03 linkto(var_01);
	var_04 = common_scripts\utility::getstruct("struct_door_server_room_left","targetname");
	var_05 = common_scripts\utility::getstruct("struct_door_server_room_right","targetname");
	var_00 moveto(var_04.origin,1,0.5,0.5);
	var_01 moveto(var_05.origin,1,0.5,0.5);
	wait(0.5);
	var_02 connectpaths();
	var_03 connectpaths();
}

//Function Number: 128
se_server_room_player_kills_guy(param_00)
{
	level endon("end_enemy_server_room_se_dead");
	self endon("death");
	self waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
	if(var_02 == level.player)
	{
		common_scripts\utility::flag_set("flag_server_room_enemy_killed_by_player");
	}

	if(self.damagelocation == "head")
	{
		level.player maps\_upgrade_challenge::give_player_challenge_headshot(1);
		return;
	}

	level.player maps\_upgrade_challenge::give_player_challenge_kill(1);
}

//Function Number: 129
burke_server_room_se(param_00)
{
	wait(2);
	param_00 maps\_anim::anim_reach_solo(level.burke,"server_room_entry_intro");
	param_00 maps\_anim::anim_single_solo(level.burke,"server_room_entry_intro");
	common_scripts\utility::flag_set("flag_burke_server_room_ready");
	param_00 thread maps\_anim::anim_loop_solo(level.burke,"server_room_door_idle","ender");
	common_scripts\utility::flag_wait("flag_se_server_room_start");
	param_00 notify("ender");
	level.burke maps\_utility::anim_stopanimscripted();
	param_00 maps\_anim::anim_single_solo(level.burke,"server_room_peek");
	param_00 thread maps\_anim::anim_loop_solo(level.burke,"server_room_door_idle","ender");
	common_scripts\utility::flag_wait_any("flag_server_room_enemy_killed_by_player","flag_server_room_enemy_killed_by_knox");
	if(common_scripts\utility::flag("flag_server_room_enemy_killed_by_player"))
	{
		wait(2);
	}
	else
	{
		wait(4);
	}

	param_00 notify("ender");
	level.burke maps\_utility::anim_stopanimscripted();
	param_00 maps\_anim::anim_single_solo(level.burke,"server_room_enter");
	param_00 thread maps\_anim::anim_loop_solo(level.burke,"server_room_enter_idle","ender");
	param_00 thread maps\lab_utility::notify_on_flag("flag_obj_bio_weapons_hack","ender");
	common_scripts\utility::flag_wait("flag_se_server_room_exit_start");
	level.burke maps\_utility::anim_stopanimscripted();
	param_00 notify("ender");
}

//Function Number: 130
cormack_server_room_se(param_00)
{
	param_00 maps\_anim::anim_reach_solo(level.cormack,"server_room_entry_intro");
	param_00 maps\_anim::anim_single_solo(level.cormack,"server_room_entry_intro");
	common_scripts\utility::flag_set("flag_cormack_server_room_ready");
	if(!common_scripts\utility::flag("flag_se_server_room_start"))
	{
		param_00 thread maps\_anim::anim_loop_solo(level.cormack,"server_room_door_idle","ender");
	}

	common_scripts\utility::flag_wait("flag_se_server_room_start");
	param_00 notify("ender");
	level.cormack maps\_utility::anim_stopanimscripted();
	param_00 maps\_anim::anim_single_solo(level.cormack,"server_room_peek");
	param_00 maps\_anim::anim_single_solo(level.cormack,"server_room_enter");
	param_00 thread maps\_anim::anim_loop_solo(level.cormack,"server_room_door_idle","ender");
	param_00 thread maps\lab_utility::notify_on_flag("flag_obj_bio_weapons_hack","ender");
	common_scripts\utility::flag_wait("flag_se_server_room_exit_start");
	level.cormack maps\_utility::anim_stopanimscripted();
	param_00 notify("ender");
}

//Function Number: 131
knox_server_room_se(param_00)
{
	param_00 maps\_anim::anim_reach_solo(level.knox,"server_room_entry_intro");
	param_00 maps\_anim::anim_single_solo(level.knox,"server_room_entry_intro");
	common_scripts\utility::flag_set("flag_knox_server_room_ready");
	if(!common_scripts\utility::flag("flag_se_server_room_start"))
	{
		param_00 thread maps\_anim::anim_loop_solo(level.knox,"server_room_door_idle","ender");
		common_scripts\utility::flag_wait("flag_se_server_room_start");
		param_00 notify("ender");
	}

	param_00 thread knox_server_room_se_peek("server_room_peek","server_room_door_idle","ender");
	common_scripts\utility::flag_wait("flag_sever_room_guy_kill");
	param_00 notify("ender");
	level.knox maps\_utility::anim_stopanimscripted();
	if(!common_scripts\utility::flag("flag_server_room_enemy_killed_by_player"))
	{
		soundscripts\_snd::snd_message("aud_server_room_door_kick");
		param_00 maps\_anim::anim_single_solo(level.knox,"server_room_enter_fail");
	}

	param_00 thread maps\_anim::anim_loop_solo(level.knox,"server_room_door_idle","ender");
	param_00 thread maps\lab_utility::notify_on_flag("flag_obj_bio_weapons_hack","ender");
	common_scripts\utility::flag_wait("flag_se_server_room_exit_start");
	level.knox maps\_utility::anim_stopanimscripted();
	param_00 notify("ender");
}

//Function Number: 132
knox_server_room_se_peek(param_00,param_01,param_02)
{
	level endon("flag_sever_room_guy_kill");
	maps\_anim::anim_single_solo(level.knox,param_00);
	thread maps\_anim::anim_loop_solo(level.knox,param_01,param_02);
}

//Function Number: 133
server_room_fire_knox_gun(param_00)
{
	if(!common_scripts\utility::flag("flag_server_room_enemy_killed_by_player"))
	{
		magicbullet(level.knox.weapon,level.knox gettagorigin("tag_flash"),level.console_guy geteye());
	}
}

//Function Number: 134
server_room_se_end(param_00)
{
	common_scripts\utility::flag_wait("flag_obj_bio_weapons_hack");
	if(!common_scripts\utility::flag("flag_server_room_promo"))
	{
		param_00 maps\_anim::anim_single_solo_run(self,"server_room_exit");
		return;
	}

	param_00 maps\_anim::anim_single_solo_run(self,"server_room_exit_promo");
}

//Function Number: 135
enemy_server_room_se(param_00)
{
	level endon("flag_enemy_server_room_se_dead");
	common_scripts\utility::flag_wait("flag_se_server_room_start");
	level.console_guy = getent("guy_se_server_room","targetname") maps\_utility::spawn_ai(1);
	level.console_guy.animname = "guy_01_server_room";
	level.console_guy.ignoresonicaoe = 1;
	level.console_guy thread se_server_room_player_kills_guy(param_00);
	param_00 thread maps\_anim::anim_loop_solo(level.console_guy,"server_room_door_idle","ender");
	level.console_guy.allowdeath = 0;
	common_scripts\utility::flag_wait("flag_sever_room_guy_kill");
	common_scripts\utility::flag_set("flag_server_room_enemy_killed_by_knox");
	param_00 notify("ender");
	if(isalive(level.console_guy) && common_scripts\utility::flag("flag_server_room_enemy_killed_by_player"))
	{
		param_00 maps\_anim::anim_single_solo(level.console_guy,"server_room_enter");
		return;
	}

	if(isalive(level.console_guy))
	{
		param_00 maps\_anim::anim_single_solo(level.console_guy,"server_room_enter_fail");
	}
}

//Function Number: 136
monitor_server_room_se(param_00)
{
	param_00 thread maps\_anim::anim_loop_solo(self,"server_room_door_idle","ender");
	level.monitor setmodel("lab_server_monitor_01_opc");
	common_scripts\utility::flag_wait_any("flag_server_room_enemy_killed_by_player","flag_server_room_enemy_killed_by_knox");
	self stopanimscripted();
	param_00 notify("ender");
	if(common_scripts\utility::flag("flag_server_room_enemy_killed_by_player"))
	{
		param_00 maps\_anim::anim_single_solo(self,"server_room_enter");
	}
	else
	{
		param_00 maps\_anim::anim_single_solo(self,"server_room_enter_fail");
	}

	level.monitor setmodel("lab_server_monitor_01_obj");
	common_scripts\utility::flag_set("monitor_finished_animating");
	common_scripts\utility::flag_wait("flag_obj_bio_weapons_hack");
	level.monitor setmodel("lab_server_monitor_01_opc");
	if(!common_scripts\utility::flag("flag_server_room_promo"))
	{
		param_00 maps\_anim::anim_single_solo(self,"server_room_exit");
		return;
	}

	param_00 maps\_anim::anim_single_solo(self,"server_room_exit_promo");
}

//Function Number: 137
se_foam_room_player()
{
	var_00 = getent("org_foam_room","targetname");
	common_scripts\utility::flag_wait("flag_obj_neutralize_bio_weapons_planted");
	thread foam_room_door_01_close();
	thread foam_room_door_03_close();
	var_01 = "foam_room";
	var_02 = spawn("script_model",var_00.origin);
	var_02 setmodel("npc_foam_grenade");
	var_02.animname = "foam_bomb";
	var_02 maps\_anim::setanimtree();
	level.player enableinvulnerability();
	thread maps\lab_lighting::foam_plant_dof();
	var_03 = maps\_utility::spawn_anim_model("player_rig_intro");
	var_03 hide();
	var_00 maps\_anim::anim_first_frame_solo(var_03,var_01);
	soundscripts\_snd::snd_message("player_plant_frb");
	level.player maps\_shg_utility::setup_player_for_scene(1);
	maps\_player_exo::player_exo_deactivate();
	var_04 = [var_03,var_02];
	level.player playerlinktoblend(var_03,"tag_player",0.2);
	wait(0.5);
	var_03 show();
	thread frb_plant_rumbles();
	var_00 maps\_anim::anim_single(var_04,var_01);
	level.player disableinvulnerability();
	level notify("reset_plant_dof");
	level.player maps\_shg_utility::setup_player_for_gameplay();
	maps\_player_exo::player_exo_activate();
	var_02 hidepart("root_pin");
	var_02 hidepart("flipper");
	var_03 delete();
	level.player unlink();
}

//Function Number: 138
frb_plant_rumbles()
{
	maps\lab_utility::setup_level_rumble_ent();
	wait(1.3);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.3,0.4);
	wait(0.5);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.8,0.3);
	wait(0.75);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.7,0.2);
	level.player waittill("detonate");
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.2,0.4);
}

//Function Number: 139
se_foam_room()
{
	common_scripts\utility::flag_wait("flag_obj_neutralize_bio_weapons_planted");
	thread foam_room_clear_think();
	var_00 = getent("org_foam_warp1","targetname");
	var_01 = getent("org_foam_warp2","targetname");
	var_02 = getent("org_foam_warp3","targetname");
	level.cormack forceteleport(var_00.origin,var_00.angles);
	level.knox forceteleport(var_01.origin,var_01.angles);
	level.burke forceteleport(var_02.origin,var_02.angles);
	level.cormack.goalradius = 64;
	level.knox.goalradius = 64;
	level.burke.goalradius = 64;
	if(!common_scripts\utility::flag("flag_obj_courtyard_jammer_start"))
	{
		waittillframeend;
		wait(3);
		maps\_utility::activate_trigger_with_targetname("trig_color_foam_planted");
		level.burke maps\_utility::delaythread(0.05,::maps\_utility::disable_ai_color);
		level.cormack maps\_utility::delaythread(0.05,::maps\_utility::disable_ai_color);
		level.knox maps\_utility::delaythread(0.05,::maps\_utility::disable_ai_color);
	}

	common_scripts\utility::flag_wait("flag_foam_room_complete_dialogue");
	common_scripts\utility::flag_set("flag_enable_battle_chatter");
	level.burke maps\_utility::enable_ai_color();
	level.cormack maps\_utility::enable_ai_color();
	level.knox maps\_utility::enable_ai_color();
	level.burke.ignoreall = 0;
	level.cormack.ignoreall = 0;
	level.knox.ignoreall = 0;
	level.cormack notify("goal_changed");
	level.knox notify("goal_changed");
	level.burke notify("goal_changed");
	if(!common_scripts\utility::flag("flag_obj_courtyard_jammer_start"))
	{
		waittillframeend;
		wait(0.75);
		level.cormack.goalradius = 2048;
		level.knox.goalradius = 2048;
		level.burke.goalradius = 2048;
		maps\_utility::activate_trigger_with_targetname("trig_color_foam_room_exit");
	}

	wait(2.5);
	thread maps\_utility::autosave_by_name("courtyard_start");
}

//Function Number: 140
foam_room_clear_think()
{
	var_00 = getent("vol_foam_room_clear","targetname");
	while(!common_scripts\utility::flag("flag_foam_room_clear"))
	{
		if(level.player istouching(var_00) && level.burke istouching(var_00) && level.knox istouching(var_00) && level.cormack istouching(var_00))
		{
			common_scripts\utility::flag_set("flag_foam_room_clear");
			thread foam_room_door_02_close();
			continue;
		}

		wait(0.1);
	}
}

//Function Number: 141
se_knox_courtyard_hangar_door_hack_open()
{
	common_scripts\utility::flag_wait("flag_hangar_mech_01_dead");
	var_00 = common_scripts\utility::getstruct("knox_courtyard_hangar_door_hack_open_org","targetname");
	var_00 maps\_anim::anim_reach_solo(level.knox,"courtyard_hangar_door_hack_enter");
	common_scripts\utility::flag_set("flag_courtyard_door_hack_dialogue");
	soundscripts\_snd::snd_message("aud_courtyard_hangar_door_hack",level.scr_anim["knox"]["courtyard_hangar_door_hack_enter"],level.knox);
	var_00 maps\_anim::anim_single_solo(level.knox,"courtyard_hangar_door_hack_enter");
	soundscripts\_snd::snd_message("aud_courtyard_hangar_door_hack_idle",level.scr_anim["knox"]["courtyard_hangar_door_hack_idle"][0],level.knox);
	var_00 thread maps\_anim::anim_loop_solo(level.knox,"courtyard_hangar_door_hack_idle","ender");
	common_scripts\utility::flag_wait("flag_courtyard_hangar_door_hack_success");
	var_00 notify("ender");
	level.knox maps\_utility::anim_stopanimscripted();
	level notify("hack_success");
	soundscripts\_snd::snd_message("aud_courtyard_hangar_door_open");
	var_00 maps\_anim::anim_single_solo(level.knox,"courtyard_hangar_door_hack_exit");
}

//Function Number: 142
se_foam_room_bomb()
{
	level.player thread handle_foam_detonator();
	level.player waittill("detonate");
	var_00 = getent("org_foam_research","targetname");
	level notify("vfx_foam_room_explode_start");
}

//Function Number: 143
handle_foam_detonator()
{
	level.player endon("detonate");
	for(;;)
	{
		common_scripts\utility::flag_wait("flag_foam_room_clear");
		maps\_utility::display_hint("detonate_frb");
		level.player thread maps\_foam_bomb::handle_detonator();
		common_scripts\utility::flag_waitopen("flag_foam_room_clear");
		self switchtoweapon(self.old_weapon);
		self takeweapon(level.c4_weaponname);
	}
}

//Function Number: 144
se_foam_corridor_bomb(param_00)
{
	var_01 = maps\_utility::spawn_anim_model("foam_bomb");
	thread maps\_anim::anim_single_solo(var_01,"foam_corridor_exit");
	soundscripts\_snd::snd_message("foam_grenade",level.burke);
	level waittill("foam_grenade_detonate");
	var_01 delete();
	level notify("vfx_foam_corridor_explode_start");
	var_02 = getent("blocker_foam_corridor","targetname");
	var_02 solid();
	var_02 disconnectpaths();
	var_02 moveto(var_02.origin + (0,156,0),5,0.25,0.25);
	wait(3);
	thread tank_hangar_door_open();
	common_scripts\utility::flag_set("flag_foam_corridor_exit_door_open_dialogue");
	wait(3);
	cleanup_foam_corridor_enemies();
}

//Function Number: 145
se_foam_corridor_grenade()
{
	level.burke waittillmatch("burke_grenade_hold","single anim");
	var_00 = spawn("script_model",level.burke gettagorigin("tag_inhand"));
	var_00 setmodel("projectile_m67fraggrenade");
	var_00 linkto(level.burke,"tag_inhand");
	var_01 = common_scripts\utility::getstruct("struct_foam_corridor_grenade_dest","targetname");
	level.burke waittillmatch("burke_grenade_release","single anim");
	var_00 delete();
	var_02 = level.burke gettagorigin("tag_inhand");
	var_03 = magicgrenade("fraggrenade",var_02,var_01.origin,2);
	var_03 waittill("death");
	foreach(var_05 in getaiarray("axis"))
	{
		if(isdefined(var_05.magic_bullet_shield) && var_05.magic_bullet_shield == 1)
		{
			var_05 maps\_utility::stop_magic_bullet_shield();
		}
	}

	radiusdamage(var_01.origin,300,99999,99999);
	common_scripts\utility::flag_wait("foam_corridor_end");
	thread tank_hangar_door_open();
	wait(0.5);
	common_scripts\utility::flag_set("flag_foam_corridor_exit_door_open_dialogue");
}

//Function Number: 146
debug_track(param_00)
{
	wait(0.05);
}

//Function Number: 147
se_foam_corridor_guy_4()
{
}

//Function Number: 148
se_foam_corridor()
{
	level.burke.dontmelee = 1;
	level.knox.dontmelee = 1;
	level.cormack.dontmelee = 1;
	level.burke maps\_utility::disable_ai_color();
	level.knox maps\_utility::disable_ai_color();
	level.cormack maps\_utility::disable_ai_color();
	var_00 = getent("blocker_foam_corridor","targetname");
	var_00 notsolid();
	var_00 connectpaths();
	var_01 = common_scripts\utility::getstruct("foam_corridor_anim_node","targetname");
	var_02 = spawn("script_origin",var_01.origin);
	if(isdefined(var_01.angles))
	{
		var_02.angles = var_01.angles;
	}

	var_03 = "foam_corridor_in";
	var_04 = "foam_corridor_idle";
	var_05 = "foam_corridor_grenade_throw";
	var_06 = "foam_corridor_idle_2";
	var_07 = "foam_corridor_exit";
	var_08 = "foam_corridor_idle_end";
	var_09 = "foam_corridor_idle2_end";
	var_0A = [];
	var_0A[var_0A.size] = level.burke;
	var_0A[var_0A.size] = level.knox;
	var_0A[var_0A.size] = level.cormack;
	common_scripts\utility::trigger_off("trigger_foam_corridor_end","targetname");
	common_scripts\utility::array_thread(var_0A,::se_foam_corridor_approach,var_02,var_03,var_04,var_08);
	common_scripts\utility::flag_set("flag_foam_corridor_another_door_dialogue");
	level waittill("foam_corridor_squadmate_ready");
	level waittill("foam_corridor_squadmate_ready");
	level waittill("foam_corridor_squadmate_ready");
	common_scripts\utility::flag_wait("foam_corridor_start");
	common_scripts\utility::flag_waitopen("flag_player_inside_foam_corridor");
	common_scripts\utility::flag_set("flag_foam_corridor_improvise_dialogue");
	var_0B = common_scripts\utility::getstruct("hovertank_reveal_org","targetname");
	var_0C = maps\_utility::spawn_anim_model("hovertank",level.hovertank.origin);
	level.hovertank hide();
	thread se_hovertank_reveal_actor(var_0C,var_0B);
	var_02 notify(var_08);
	thread se_foam_corridor_grenade();
	var_02 maps\_anim::anim_single(var_0A,var_05);
	var_02 thread maps\_anim::anim_loop(var_0A,var_06,var_09);
	common_scripts\utility::trigger_on("trigger_foam_corridor_end","targetname");
	common_scripts\utility::flag_wait("foam_corridor_end");
	var_02 notify(var_09);
	foreach(var_0E in var_0A)
	{
		var_0F = spawnstruct();
		var_0F thread maps\_utility::function_stack(::foam_room_end_animation,var_0E,var_01,var_07);
		var_0F thread maps\_utility::function_stack(::se_hovertank_reveal_actor,var_0E,var_0B);
	}

	common_scripts\utility::flag_set("flag_foam_corridor_exit");
	level.burke.dontmelee = 0;
	level.knox.dontmelee = 0;
	level.cormack.dontmelee = 0;
	level.burke maps\_utility::enable_ai_color_dontmove();
	level.knox maps\_utility::enable_ai_color_dontmove();
	level.cormack maps\_utility::enable_ai_color_dontmove();
	var_02 delete();
}

//Function Number: 149
foam_room_end_animation(param_00,param_01,param_02)
{
	param_01 maps\_anim::anim_single_solo_run(param_00,param_02);
}

//Function Number: 150
se_foam_corridor_approach(param_00,param_01,param_02,param_03)
{
	param_00 maps\_anim::anim_reach_solo(self,param_01);
	param_00 maps\_anim::anim_single_solo(self,param_01);
	param_00 thread maps\_anim::anim_loop_solo(self,param_02,param_03);
	level notify("foam_corridor_squadmate_ready");
}

//Function Number: 151
se_exfil()
{
	common_scripts\utility::flag_wait("flag_exfil_start");
	common_scripts\utility::flag_set("flag_exfil_start_dialogue");
	var_00 = common_scripts\utility::getstruct("org_se_exfil","targetname");
	thread maps\lab_lighting::exfil();
	var_01 = common_scripts\utility::getstruct("hovertank_exit_burke_position","targetname");
	level.burke maps\_utility::anim_stopanimscripted();
	level.burke forceteleport(var_01.origin,var_01.angles,1000);
	var_02 = common_scripts\utility::getstruct("hovertank_exit_knox_position","targetname");
	level.knox maps\_utility::anim_stopanimscripted();
	level.knox forceteleport(var_02.origin,var_02.angles,1000);
	level.knox setgoalnode(getnode("knox_exfil_node","targetname"));
	level.burke pushplayer(1);
	level.cormack pushplayer(1);
	level.burke.moveplaybackrate = 0.9;
	level.knox.moveplaybackrate = 0.9;
	level.player maps\_utility::blend_movespeedscale_percent(80);
	thread cormack_exfil_approach(var_00);
	level.burke thread burke_exfil_approach(var_00,"exfil_burke_enter");
	var_03 = [level.burke];
	common_scripts\utility::flag_wait("flag_burke_ready_for_exfil");
	var_00 notify("fly_in_idle_stop");
	var_00 thread maps\_anim::anim_single(var_03,"exfil_burke_enter");
	var_00 maps\_anim::anim_single(var_03,"exfil_burke_enter");
	var_00 thread maps\_anim::anim_loop(var_03,"exfil_hover_idle","exfil_hover_idle_stop");
	common_scripts\utility::flag_set("flag_player_exfil_enter_ready");
	thread se_player_exfil_out_of_bounds_check();
	common_scripts\utility::flag_wait("flag_player_exfil_enter");
	maps\_utility::autosave_by_name();
	common_scripts\utility::flag_set("flag_exfil_dialogue");
	thread maps\lab_lighting::exfil_dof();
	var_00 notify("exfil_hover_idle_stop");
	var_00 notify("exfil_hover_idle_stop");
	waittillframeend;
	maps\_player_exo::player_exo_deactivate();
	maps\_player_exo::player_exo_add_single("exo_melee");
	var_04 = maps\_utility::spawn_anim_model("player_rig_intro");
	var_04.animname = "player_rig_intro";
	var_04.weapon = "none";
	var_04 hide();
	level.razorback maps\_anim::anim_first_frame_solo(var_04,"exfil_enter","tag_guy1");
	level notify("player_enters_razorback");
	var_05 = 0.5;
	level.player playerlinktoblend(var_04,"tag_player",var_05);
	level.player maps\_utility::add_wait(::maps\_shg_utility::setup_player_for_scene,1);
	var_04 maps\_utility::add_call(::show);
	thread maps\_utility::do_wait();
	var_03 = [level.cormack,level.burke,level.knox,var_04];
	foreach(var_07 in var_03)
	{
		var_07 linkto(level.razorback,"tag_guy1");
	}

	level.razorback thread maps\_anim::anim_single(var_03,"exfil_enter","tag_guy1");
	maps\_utility::delaythread(4,::common_scripts\utility::flag_set,"flag_obj_battle_exfil_complete");
	maps\_utility::delaythread(12,::common_scripts\utility::flag_set,"flag_burke_destroy_tank");
	maps\_utility::delaythread(30,::common_scripts\utility::flag_set,"flag_mission_complete");
	level waittill("level_fade_out");
	var_09 = 3;
	maps\lab_utility::ending_fade_out(var_09);
	wait(var_09);
	maps\_utility::nextmission();
}

//Function Number: 152
se_player_exfil_out_of_bounds_check()
{
	var_00 = getent("obj_battle_exfil_04","targetname");
	while(!common_scripts\utility::flag("flag_player_exfil_enter"))
	{
		if(distance(level.player.origin,var_00.origin) > 2000)
		{
			common_scripts\utility::flag_clear("flag_player_close_to_exfil");
			maps\_utility::display_hint_timeout("hint_dont_leave_mission",5);
			if(distance(level.player.origin,var_00.origin) > 3000)
			{
				common_scripts\utility::flag_set("flag_player_close_to_exfil");
				level notify("mission failed");
				setdvar("ui_deadquote",&"LAB_MISSION_FAILED_LEFT_MISSION");
				maps\_utility::missionfailedwrapper();
			}

			continue;
		}

		common_scripts\utility::flag_set("flag_player_close_to_exfil");
		wait(0.3);
	}

	common_scripts\utility::flag_set("flag_player_close_to_exfil");
}

//Function Number: 153
break_exfil_out_bounds()
{
	if(common_scripts\utility::flag("flag_player_close_to_exfil"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 154
se_exfil_razorback(param_00)
{
	common_scripts\utility::flag_set("flag_obj_show_razorback_marker");
	var_01 = common_scripts\utility::getstruct("org_se_exfil","targetname");
	level.razorback = maps\_vehicle::spawn_vehicle_from_targetname("helo_exfil");
	soundscripts\_snd::snd_message("razorback_land");
	level.razorback.animname = "razorback";
	level.razorback maps\_anim::setanimtree();
	level.razorback thread maps\lab_fx::se_exfil_fx();
	thread maps\lab_lighting::razorback_lighting(level.razorback);
	thread maps\lab_lighting::burke_exfil_lighting();
	param_00 = maps\_utility::spawn_targetname("guy_helo_exfil");
	param_00.animname = "guy_exfil";
	var_02 = maps\_utility::spawn_targetname("guy_helo_exfil_pilot");
	var_02.animname = "guy_exfil_pilot";
	var_02 maps\_utility::gun_remove();
	var_02 linkto(level.razorback,"tag_guy1");
	level.razorback thread maps\_anim::anim_loop_solo(var_02,"exfil_pilot_idle","ender","tag_guy1");
	var_03 = [param_00,level.razorback];
	var_01 thread maps\_anim::anim_single(var_03,"exfil_fly_in");
	thread handle_player_close_to_aircraft_rumbles();
	common_scripts\utility::waittill_any_ents(level,"flag_burke_ready_for_exfil",var_01,"exfil_fly_in");
	if(!common_scripts\utility::flag("flag_burke_ready_for_exfil"))
	{
		var_01 thread maps\_anim::anim_loop(var_03,"exfil_fly_in_idle","fly_in_idle_stop");
	}

	common_scripts\utility::flag_wait("flag_burke_ready_for_exfil");
	level notify("thruster_front_off");
	var_01 notify("fly_in_idle_stop");
	param_00 maps\_utility::anim_stopanimscripted();
	var_01 thread maps\_anim::anim_single(var_03,"exfil_burke_enter");
	var_01 maps\_anim::anim_single(var_03,"exfil_burke_enter");
	var_01 thread maps\_anim::anim_loop(var_03,"exfil_hover_idle","exfil_hover_idle_stop");
	common_scripts\utility::flag_wait("flag_player_exfil_enter");
	var_01 notify("exfil_hover_idle_stop");
	waittillframeend;
	var_03 = [param_00];
	param_00 maps\_utility::anim_stopanimscripted();
	var_01 thread maps\_anim::anim_single_solo(level.razorback,"exfil_enter");
	foreach(param_00 in var_03)
	{
		param_00 linkto(level.razorback,"tag_guy1");
	}

	level.razorback thread maps\_anim::anim_single(var_03,"exfil_enter","tag_guy1");
}

//Function Number: 155
burke_exfil_approach(param_00,param_01)
{
	param_00 maps\_anim::anim_reach_solo(self,param_01);
	common_scripts\utility::flag_set("flag_burke_ready_for_exfil");
}

//Function Number: 156
cormack_exfil_approach(param_00)
{
	param_00 maps\_anim::anim_reach_solo(level.cormack,"exfil_cormack_approach");
	maps\_utility::delaythread(2,::common_scripts\utility::flag_set,"flag_exfil_loadup_dialogue");
	param_00 maps\_anim::anim_single_solo(level.cormack,"exfil_cormack_approach");
	param_00 thread maps\_anim::anim_loop_solo(level.cormack,"exfil_cormack_approach_idle","ender");
	common_scripts\utility::flag_wait("flag_player_exfil_enter");
	level.cormack stopanimscripted();
	param_00 notify("ender");
}

//Function Number: 157
setup_combat()
{
	setup_spawn_functions();
	setup_hovertank();
	thread player_stealth_cloak_think();
	thread setup_clip();
	thread setup_triggers();
	thread combat_gaz_bridge();
	thread forest_ambient_enemy_se();
	thread foreat_stealth_ambient_vehicle_drive_by();
	thread combat_forest_patrols_start();
	thread logging_road_loud_combat();
	thread combat_logging_road_end();
	thread combat_research_building();
	thread combat_research_building_bridge();
	thread combat_research_pool_walkway_01();
	thread combat_research_left_01();
	thread combat_research_right_01();
	thread combat_research_pool_room();
	thread combat_research_platform_01();
	thread combat_courtyard_path_general();
	thread combat_courtyard_jammer();
	thread combat_courtyard_jammer_complete();
	thread skip_foam_corridor();
	thread cleanup_courtyard_enemies();
	thread open_hangar_doors();
	thread combat_tank_road();
	thread courtyard_gate_think(1);
	thread courtyard_gate_think(2);
}

//Function Number: 158
combat_gaz_bridge()
{
	common_scripts\utility::flag_wait("flag_increase_sinper_shots_01");
	wait(3);
	var_00 = getent("gaz_bridge_02","targetname");
}

//Function Number: 159
helo_spotlight_logging_road()
{
	if(!isdefined(level.start_point) || level.start_point != "logging_road")
	{
		common_scripts\utility::flag_wait("flag_se_takedown_01_complete");
	}

	level.helo_spotlight_logging_road = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("helo_spotlight_logging_road");
	level.helo_spotlight_logging_road soundscripts\_snd::snd_message("aud_patrol_helo_debris_sfx");
	level.helo_spotlight_logging_road maps\_vehicle::godon();
	level.helo_spotlight_logging_road maps\_utility::ent_flag_init("spotlight_on");
	level.helo_spotlight_logging_road.spotlight = spawnturret("misc_turret",level.helo_spotlight_logging_road gettagorigin("tag_flash"),"heli_spotlight_so_castle");
	level.helo_spotlight_logging_road.spotlight setmode("manual");
	level.helo_spotlight_logging_road.spotlight setmodel("com_blackhawk_spotlight_on_mg_setup");
	level.helo_spotlight_logging_road.spotlight maketurretinoperable();
	level.helo_spotlight_logging_road.spotlight makeunusable();
	level.helo_spotlight_logging_road.spotlight.angles = level.helo_spotlight_logging_road gettagangles("tag_flash");
	level.helo_spotlight_logging_road.spotlight linkto(level.helo_spotlight_logging_road,"tag_flash",(0,2,-6),(0,90,-20));
	level.helo_spotlight_logging_road thread helo_spotlight_think("docks_heli_spotlight_cheap");
	level.helo_spotlight_logging_road thread helo_spotlight_point_of_interest_tracking();
	level.helo_spotlight_logging_road maps\_utility::ent_flag_set("spotlight_on");
	level.helo_spotlight_logging_road maps\_vehicle::mgoff();
	level.helo_spotlight_logging_road thread helo_spotlight_logging_road_break_off();
	common_scripts\utility::flag_wait("flag_helo_logging_road_end");
	level.helo_spotlight_logging_road.spotlight delete();
}

//Function Number: 160
helo_spotlight_logging_road_break_off()
{
	self endon("death");
	common_scripts\utility::flag_wait("flag_logging_road_loud_combat");
	self notify("newpath");
	maps\_utility::vehicle_liftoff(512);
	maps\_utility::vehicle_dynamicpath(common_scripts\utility::getstruct("logging_road_chopper_detour","targetname"));
}

//Function Number: 161
combat_forest_patrols_start()
{
	if(!isdefined(level.start_point) || level.start_point != "logging_road")
	{
		common_scripts\utility::flag_wait("flag_se_takedown_01_complete");
	}

	level.patrol_01 = maps\_utility::spawn_targetname("enemy_stealth_patrol_01",1);
	level.patrol_01 force_patrol_anim_set("active_right",1);
	level.patrol_01 thread guy_patrol_takedown_02();
	var_00 = maps\_utility::spawn_targetname("enemy_stealth_patrol_02",1);
	var_00 force_patrol_anim_set("active_left",1);
	var_01 = maps\_utility::spawn_targetname("enemy_stealth_patrol_03",1);
	var_01 force_patrol_anim_set("gundown");
	var_02 = maps\_utility::spawn_targetname("enemy_stealth_patrol_04",1);
	var_02 force_patrol_anim_set("active",1);
	var_03 = maps\_utility::spawn_targetname("enemy_stealth_patrol_06",1);
	var_03 force_patrol_anim_set("creepwalk");
	var_04 = maps\_utility::spawn_targetname("enemy_stealth_patrol_07",1);
	var_04 force_patrol_anim_set("creepwalk");
	var_05 = [level.patrol_01,var_00,var_01,var_02,var_03,var_04];
	soundscripts\_snd::snd_message("combat_forest_patrols_start",var_05);
	thread helo_spotlight_logging_road();
	foreach(var_07 in var_05)
	{
		if(isdefined(var_07.pdroneactive) && var_07.pdroneactive)
		{
			var_07 thread start_search_drone_behavior_when_pdrone_follower_spawned();
		}
	}

	common_scripts\utility::flag_wait("flag_forest_drive_by_01");
	var_09 = maps\_utility::spawn_targetname("enemy_stealth_patrol_08",1);
	var_09 force_patrol_anim_set("casualkiller");
	var_0A = maps\_utility::spawn_targetname("enemy_stealth_patrol_09",1);
	var_0A force_patrol_anim_set("casualkiller");
}

//Function Number: 162
start_search_drone_behavior_when_pdrone_follower_spawned()
{
	self endon("death");
	while(!isdefined(self.pdrone))
	{
		wait(0.5);
	}

	if(isdefined(self.script_stealthgroup))
	{
		self.pdrone.script_stealthgroup = self.script_stealthgroup;
	}

	thread search_drone_behavior(self.pdrone);
}

//Function Number: 163
set_flag_on_death(param_00,param_01,param_02,param_03)
{
	self waittill("death");
	if(isdefined(param_00))
	{
		common_scripts\utility::flag_set(param_00);
	}

	if(isdefined(param_01))
	{
		common_scripts\utility::flag_set(param_01);
	}

	if(isdefined(param_02))
	{
		common_scripts\utility::flag_set(param_02);
	}

	if(isdefined(param_03))
	{
		common_scripts\utility::flag_set(param_03);
	}
}

//Function Number: 164
patrol_03_idle_think()
{
	common_scripts\utility::flag_wait("flag_patrol_03_idle");
	var_00 = common_scripts\utility::getstruct("forest_stealth_ambiant_01_org","targetname");
	var_00 maps\_anim::anim_loop_solo(self,"patrol_sit_idle","ender");
}

//Function Number: 165
forest_ambient_enemy_se()
{
	common_scripts\utility::flag_wait("flag_forest_climb_wall_complete");
	var_00 = maps\_utility::spawn_targetname("enemy_stealth_ambient_02",1);
	var_00 maps\_flashlight_cheap::add_cheap_flashlight("flashlight");
	var_01 = maps\_utility::spawn_targetname("enemy_stealth_ambient_04",1);
	var_01 maps\_flashlight_cheap::add_cheap_flashlight("flashlight");
	var_02 = maps\_utility::spawn_targetname("enemy_stealth_ambient_05",1);
	var_02 maps\_flashlight_cheap::add_cheap_flashlight("flashlight");
	soundscripts\_snd::snd_message("combat_forest_patrols_start",[var_00,var_01,var_02]);
}

//Function Number: 166
flag_wait_both_or_timeout(param_00,param_01,param_02)
{
	var_03 = param_02 * 1000;
	var_04 = gettime();
	for(;;)
	{
		if(common_scripts\utility::flag(param_00) && common_scripts\utility::flag(param_01))
		{
			break;
		}

		if(gettime() >= var_04 + var_03)
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 167
burke_forest_stealth_movement()
{
	level.burke pushplayer(1);
	level.burke.dontavoidplayer = 1;
	level.burke.dontchangepushplayer = 1;
	level endon("flag_ready_burke_for_mech_march");
	if(common_scripts\utility::flag("flag_logging_road_loud_combat"))
	{
		return;
	}

	level endon("flag_logging_road_loud_combat");
	var_00 = getnode("node_burke_forest_stealth_01","targetname");
	level.burke maps\lab_utility::goto_node(var_00,1);
	common_scripts\utility::flag_wait_all("flag_patroler_takedown_02_follow_a","flag_forest_drive_by_01","flag_burke_forest_01_moveup");
	var_00 = getnode("node_burke_takedown_02_follow","targetname");
	level.burke maps\lab_utility::goto_node(var_00,1);
	common_scripts\utility::flag_wait_all("flag_patroler_takedown_02_follow_b","flag_forest_drive_by_02");
	if(!common_scripts\utility::flag("flag_patroler_takedown_02_ready"))
	{
		var_00 = getnode("node_burke_takedown_02","targetname");
		level.burke maps\lab_utility::goto_node(var_00,1);
		level.burke maps\_utility::set_moveplaybackrate(0.7);
	}
	else
	{
		level.burke maps\_utility::set_moveplaybackrate(1);
	}

	if(isdefined(level.patrol_01) && isalive(level.patrol_01))
	{
		thread burke_patrol_takedown_02(level.patrol_01);
	}
	else
	{
		common_scripts\utility::flag_set("flag_se_takedown_02_complete");
		var_00 = getnode("node_burke_takedown_02","targetname");
		level.burke maps\lab_utility::goto_node(var_00,1);
	}

	common_scripts\utility::flag_wait_all("flag_se_takedown_02_complete","flag_patroler_06_clear","flag_patroler_07_clear","flag_patroler_03_clear");
	var_00 = getnode("node_burke_forest_stealth_02","targetname");
	level.burke maps\lab_utility::goto_node(var_00,1);
	level.burke maps\_utility::set_moveplaybackrate(1);
	var_01 = getnodearray("node_logging_road","targetname");
	foreach(var_03 in var_01)
	{
		var_03 disconnectnode();
	}

	wait(1);
	common_scripts\utility::flag_set("flag_recharge_cloak_01");
	maps\_utility::display_hint_timeout("exo_toggle_hint",5);
	level.burke maps\lab_utility::ai_toggle_cloak_animate(2,0,"right");
	if(common_scripts\utility::flag("flag_forest_player_alt_path_01"))
	{
		common_scripts\utility::flag_set("flag_move_to_vehicle_takedown_01");
		common_scripts\utility::flag_set("flag_move_to_vrap_takedown");
	}

	flag_wait_both_or_timeout("flag_move_to_vrap_takedown","flag_aproach_vehicle_dialogue_complete",12);
	common_scripts\utility::flag_set("flag_move_to_vehicle_takedown_01");
	var_00 = getnode("node_burke_forest_stealth_03","targetname");
	level.burke maps\lab_utility::goto_node(var_00,1);
	foreach(var_03 in var_01)
	{
		var_03 connectnode();
	}

	common_scripts\utility::flag_wait_any("flag_se_vehicle_takedown_01_complete","flag_forest_player_alt_path_01");
	if(!common_scripts\utility::flag("flag_se_vehicle_takedown_01_failed") && !common_scripts\utility::flag("flag_forest_player_alt_path_01"))
	{
		var_00 = getnode("node_burke_forest_stealth_04","targetname");
		level.burke maps\lab_utility::goto_node(var_00,1);
	}
	else
	{
		common_scripts\utility::flag_set("flag_se_vehicle_takedown_01_complete");
		common_scripts\utility::flag_set("flag_se_vehicle_takedown_01_failed");
	}

	wait(2);
	common_scripts\utility::flag_wait("flag_drone_pass_02");
	var_00 = getnode("node_burke_forest_stealth_05","targetname");
	level.burke maps\lab_utility::goto_node(var_00,1);
	common_scripts\utility::flag_wait("flag_recharge_cloak_trench");
	level.burke maps\lab_utility::ai_toggle_cloak_animate(-1,-1);
	var_00 = getnode("node_burke_forest_stealth_06","targetname");
	level.burke maps\lab_utility::goto_node(var_00,0);
	common_scripts\utility::flag_wait("flag_trench_complete");
	var_00 = getnode("node_burke_forest_stealth_14","targetname");
	level.burke maps\lab_utility::goto_node(var_00,0);
	level.burke maps\_utility::enable_cqbwalk();
}

//Function Number: 168
burke_mech_march_movement()
{
	if(common_scripts\utility::flag("flag_logging_road_loud_combat"))
	{
		return;
	}

	level endon("flag_logging_road_loud_combat");
	level endon("flag_cormack_meet_init");
	common_scripts\utility::flag_wait("flag_ready_burke_for_mech_march");
	level.burke pushplayer(1);
	level.burke.dontavoidplayer = 1;
	level.burke.dontchangepushplayer = 1;
	level.burke maps\_utility::set_moveplaybackrate(1);
	if(!isdefined(level.start_point) || level.start_point != "mech_march")
	{
		maps\_utility::autosave_stealth();
	}

	var_00 = getnode("node_burke_forest_stealth_07","targetname");
	level.burke maps\lab_utility::goto_node(var_00,1);
	wait(0.5);
	level.burke maps\lab_utility::ai_toggle_cloak_animate(1,0);
	level notify("burke_recharge_mech_done");
	common_scripts\utility::flag_wait("flag_mech_march_hide_right");
	var_00 = getnode("node_burke_forest_stealth_08","targetname");
	level.burke maps\lab_utility::goto_node(var_00,1);
	common_scripts\utility::flag_wait("flag_mech_march_hide_right_complete");
	var_00 = getnode("node_burke_forest_stealth_09","targetname");
	level.burke maps\lab_utility::goto_node(var_00,1);
	common_scripts\utility::flag_wait_any("flag_logging_road_seeker_01","flag_gaz_01_scanner_on");
	var_00 = getnode("node_burke_forest_stealth_10","targetname");
	level.burke maps\lab_utility::goto_node(var_00,1);
	level.burke maps\_utility::disable_cqbwalk();
	level.burke maps\_utility::delaythread(5,::maps\_utility::enable_sprint);
	common_scripts\utility::flag_wait_all("flag_seeker_patrol_01_clear","flag_seeker_patrol_02_clear","flag_seeker_patrol_03_clear","flag_seeker_patrol_04_clear");
	common_scripts\utility::flag_set("flag_seeker_patrol_01_clear");
	thread advance_gideon_if_player_ahead();
	common_scripts\utility::flag_wait_all("flag_move_up_seeker_01","flag_seeker_cone_safe_right");
	var_00 = getnode("node_burke_forest_stealth_11","targetname");
	level.burke maps\lab_utility::goto_node(var_00,1);
	common_scripts\utility::flag_wait_all("flag_move_up_seeker_02","flag_seeker_cone_safe_left");
	var_00 = getnode("node_burke_forest_stealth_12","targetname");
	level.burke maps\lab_utility::goto_node(var_00,1);
	level.burke maps\_utility::enable_cqbwalk();
	level.burke maps\_utility::disable_sprint();
	common_scripts\utility::flag_wait("flag_move_up_seeker_03");
	var_00 = getnode("node_burke_forest_stealth_13","targetname");
	level.burke maps\lab_utility::goto_node(var_00,1);
	level.burke maps\_utility::enable_cqbwalk();
	common_scripts\utility::flag_wait("flag_exit_seeker_area");
	common_scripts\utility::flag_set("flag_obj_crawl_under_log");
	var_00 = getnode("node_burke_forest_stealth_15","targetname");
	level.burke maps\lab_utility::goto_node(var_00,0);
	level.burke maps\_utility::enable_cqbwalk();
}

//Function Number: 169
advance_gideon_if_player_ahead()
{
	common_scripts\utility::flag_wait("flag_move_up_seeker_03");
	common_scripts\utility::flag_set("flag_move_up_seeker_01");
	common_scripts\utility::flag_set("flag_move_up_seeker_02");
}

//Function Number: 170
burke_patrol_takedown_02(param_00)
{
	param_00 endon("death");
	param_00 endon("stealth_enemy_endon_alert");
	param_00.animname = "guy";
	var_01 = common_scripts\utility::getstruct("forest_takedown_02_org","targetname");
	param_00 thread maps\_stealth_utility::stealth_enemy_endon_alert();
	thread burke_patrol_takedown_02_cleanup(param_00,"death",param_00,"stealth_enemy_endon_alert",var_01,"forest_takedown_02");
	common_scripts\utility::flag_wait_all("flag_patroler_03_clear","flag_patroler_06_clear","flag_patroler_07_clear","flag_patroler_takedown_02_ready");
	if(isalive(param_00))
	{
		level.burke notify("stop_goto_node");
		var_01 maps\_anim::anim_reach_solo(level.burke,"forest_takedown_02",undefined,1);
		level notify("patrol_takedown_02_start");
		var_01 thread maps\_anim::anim_single_solo(level.burke,"forest_takedown_02");
		level.burke soundscripts\_snd::snd_message("burke_solo_takedown",param_00);
	}
}

//Function Number: 171
guy_patrol_takedown_02()
{
	self endon("death");
	self endon("stealth_enemy_endon_alert");
	self endon("alerted");
	self.animname = "guy";
	var_00 = common_scripts\utility::getstruct("forest_takedown_02_org","targetname");
	common_scripts\utility::flag_wait("flag_patroler_takedown_02_reach_start");
	var_00 maps\_anim::anim_reach_solo(self,"forest_takedown_02_loser_enter");
	var_00 maps\_anim::anim_single_solo(self,"forest_takedown_02_loser_enter");
	var_00 thread maps\_anim::anim_loop_solo(self,"forest_takedown_02_loser_idle","ender");
	thread guy_patrol_takedown_02_alert_check(var_00);
	common_scripts\utility::flag_set("flag_patroler_takedown_02_ready");
	level waittill("patrol_takedown_02_start");
	var_00 notify("ender");
	maps\_utility::anim_stopanimscripted();
	self.ignoresonicaoe = 1;
	var_00 thread maps\_anim::anim_single_solo(self,"forest_takedown_02_loser");
	level waittill("forest_takedown_02_guy_stabbed");
	thread forest_takedown_02_ai_kill(self);
	var_00 waittill("forest_takedown_02");
	self kill();
}

//Function Number: 172
guy_patrol_takedown_02_alert_check(param_00)
{
	self endon("death");
	level endon("forest_takedown_02_guy_stabbed");
	common_scripts\utility::waittill_any_ents(self,"patrol_alerted",self,"_stealth_spotted",self,"stealth_event",self,"_stealth_found_corpse",self,"alerted",self,"enemy",self,"touch");
	self notify("alerted");
	param_00 notify("ender");
	maps\_utility::anim_stopanimscripted();
	if(isdefined(self.flashlight))
	{
		self.flashlight delete();
	}
}

//Function Number: 173
forest_takedown_02_ai_kill(param_00)
{
	if(!isalive(param_00))
	{
		return;
	}

	param_00.allowdeath = 1;
	param_00.a.nodeath = 1;
	param_00 maps\_utility::set_battlechatter(0);
	param_00.ignoreall = 1;
}

//Function Number: 174
burke_patrol_takedown_02_cleanup(param_00,param_01,param_02,param_03,param_04,param_05)
{
	common_scripts\utility::waittill_any_ents(param_00,param_01,param_02,param_03,param_04,param_05);
	common_scripts\utility::flag_set("flag_se_takedown_02_complete");
	level.burke maps\_utility::anim_stopanimscripted();
	if(isalive(param_00))
	{
		param_00 maps\_utility::anim_stopanimscripted();
	}
}

//Function Number: 175
foreat_stealth_ambient_vehicle_drive_by()
{
	common_scripts\utility::flag_wait("flag_forest_drive_by_01");
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("gaz_raod_drive_by_01");
	var_00 maps\_vehicle::vehicle_lights_on();
	var_00 soundscripts\_snd::snd_message("gaz_01_dist_by");
	var_00 thread forest_stealth_gaz_think();
	var_00 thread maps\lab_fx::logging_road_mud_tracks();
	wait(1.5);
	var_01 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("gaz_raod_drive_by_02");
	var_01 maps\_vehicle::vehicle_lights_on();
	var_01 soundscripts\_snd::snd_message("gaz_02_dist_by");
	var_01 thread forest_stealth_gaz_think();
	var_01 thread maps\lab_fx::logging_road_mud_tracks();
	wait(0.5);
	common_scripts\utility::flag_wait("flag_forest_drive_by_02");
	var_02 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("gaz_raod_drive_by_03");
	var_02 maps\_vehicle::vehicle_lights_on();
	var_02 soundscripts\_snd::snd_message("gaz_03_close_by");
	var_02 thread forest_stealth_gaz_think();
	var_02 thread maps\lab_fx::logging_road_mud_tracks();
	common_scripts\utility::flag_wait_all("flag_se_takedown_02_complete","flag_move_to_vehicle_takedown_01");
	common_scripts\utility::flag_set("flag_move_to_vrap_takedown");
	thread drones_logging_road();
}

//Function Number: 176
forest_stealth_gaz_think(param_00)
{
	self endon("death");
	common_scripts\utility::flag_wait("_stealth_spotted");
	if(!isdefined(param_00) || !param_00)
	{
		wait(randomfloat(0.5));
	}
	else
	{
		while(length(self vehicle_getvelocity()) > 0)
		{
			wait(0.5);
		}

		common_scripts\utility::flag_set("flag_gaz_01_scanner_on");
	}

	self vehicle_setspeed(0,10,10);
	self notify("vehicle_stopping");
	var_01 = maps\_vehicle::vehicle_unload();
	foreach(var_03 in var_01)
	{
		var_03 thread maps\_utility::player_seek();
	}
}

//Function Number: 177
helo_spotlight_point_of_interest_tracking()
{
	self endon("death");
	var_00 = 1000;
	var_01 = 500;
	var_02 = 3;
	var_03 = 10;
	var_04 = spawnstruct();
	var_04.origin = (0,0,0);
	self.override_target = var_04;
	var_05 = common_scripts\utility::getstructarray("spotlight_point_of_interest","targetname");
	for(;;)
	{
		var_06 = self.origin + anglestoforward(self.angles) * var_00;
		var_07 = [];
		foreach(var_09 in var_05)
		{
			if(distance2d(var_06,var_09.origin) < var_01)
			{
				var_07[var_07.size] = var_09;
			}
		}

		if(var_07.size > 0)
		{
			var_04.origin = var_07[randomint(var_07.size)].origin;
			self.spotlight common_scripts\utility::waittill_notify_or_timeout("turret_on_target",10);
			wait(randomfloatrange(var_02,var_03));
			continue;
		}

		wait(1);
	}
}

//Function Number: 178
combat_logging_road_end()
{
	common_scripts\utility::flag_wait("flag_logging_road_end_combat");
	thread logging_road_seeker_save();
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("gaz_logging_road_01");
	var_00 maps\_vehicle::vehicle_lights_on();
	var_00 soundscripts\_snd::snd_message("skr_distant_pull_up_and_scan");
	var_00 thread forest_stealth_gaz_think(1);
	level endon("flag_logging_road_loud_combat");
	common_scripts\utility::flag_wait("flag_seeker_patrol_spawn");
	common_scripts\utility::flag_set("flag_helo_logging_road_end");
	maps\_utility::spawn_script_noteworthy("guy_01_seeker",1);
	maps\_utility::spawn_script_noteworthy("guy_02_seeker",1);
	maps\_utility::spawn_script_noteworthy("guy_03_seeker",1);
	maps\_utility::spawn_script_noteworthy("guy_04_seeker",1);
	var_01 = maps\_utility::array_spawn_noteworthy("seeker_guards",1);
	var_00 thread maps\lab_utility::attach_scanner_turret();
	if(common_scripts\utility::flag("flag_logging_road_loud_combat"))
	{
		if(isdefined(var_01[0]) && isalive(var_01[0]))
		{
			var_01[0] notify("ai_event","gunshot");
			var_01[0] maps\_utility::set_favoriteenemy(level.player);
		}
	}

	common_scripts\utility::flag_wait("flag_gaz_01_scanner_on");
	var_00 thread seeker_think();
	var_00 thread maps\lab_utility::attach_scanner(1500,15,15,-5,50,10,200,50,0.35,-12,5,"veh_turret_scanner_search_red","veh_turret_scanner_search");
}

//Function Number: 179
logging_road_seeker_save()
{
	level endon("flag_logging_road_loud_combat");
	common_scripts\utility::flag_wait("flag_seeker_checkpoint");
	thread maps\_utility::autosave_stealth();
}

//Function Number: 180
seeker_think()
{
	self waittill("reached_dynamic_path_end");
	level waittill("_stealth_spotted");
	maps\_vehicle::vehicle_unload();
}

//Function Number: 181
patrol_creepwalk_unload_spawn_func()
{
	self waittill("jumpedout");
}

//Function Number: 182
patrol_01_unload_spawn_func()
{
	force_patrol_anim_set("casualkiller");
}

//Function Number: 183
patrol_02_unload_spawn_func()
{
	force_patrol_anim_set("patroljog");
}

//Function Number: 184
patrol_03_unload_spawn_func()
{
	force_patrol_anim_set("casualkiller");
}

//Function Number: 185
patrol_04_unload_spawn_func()
{
	force_patrol_anim_set("casualkiller");
}

//Function Number: 186
logging_road_loud_combat()
{
	level endon("flag_cormack_meet_init");
	common_scripts\utility::flag_wait("_stealth_spotted");
	common_scripts\utility::flag_set("flag_logging_road_loud_combat");
	common_scripts\utility::flag_set("flag_vo_stealth_broken");
	if(isdefined(level.burke.function_stack))
	{
		level.burke maps\_utility::function_stack_clear();
	}

	level.burke stopsounds();
	level.burke.alwaysrunforward = undefined;
	maps\_utility::radio_dialogue_stop();
	level.burke maps\_utility::enable_ai_color();
	level.burke maps\_utility::enable_careful();
	level.burke maps\_utility::disable_cqbwalk();
	level.burke maps\lab_utility::cloak_off(1);
	level.burke maps\_utility::set_moveplaybackrate(1);
	maps\_utility::array_spawn_function_noteworthy("logging_road_loud_combat_enemy",::logging_road_loud_combat_enemy_think);
	if(!common_scripts\utility::flag("flag_logging_road_field_passed"))
	{
		thread logging_road_loud_combat_field();
	}

	if(!common_scripts\utility::flag("flag_logging_road_trench_passed"))
	{
		thread logging_road_loud_combat_trench();
	}

	if(!common_scripts\utility::flag("flag_se_mech_march_start"))
	{
		thread logging_road_loud_combat_mech_march();
	}

	if(!common_scripts\utility::flag("flag_logging_road_end_combat"))
	{
		thread logging_road_loud_combat_end();
	}

	common_scripts\utility::flag_set("flag_move_up_seeker_03");
	maps\_player_exo::player_exo_add_single("exo_melee");
	common_scripts\utility::flag_wait("flag_exit_seeker_area");
	var_00 = getnode("node_burke_forest_stealth_15","targetname");
	level.burke maps\lab_utility::goto_node(var_00,0);
	level.burke maps\_utility::enable_cqbwalk();
}

//Function Number: 187
logging_road_loud_combat_enemy_think()
{
	self endon("death");
	thread maps\_utility::player_seek();
	self.pathrandompercent = 300;
}

//Function Number: 188
logging_road_loud_combat_field()
{
	var_00 = maps\_utility::array_spawn_targetname("logging_road_loud_combat_field_enemy");
}

//Function Number: 189
logging_road_loud_combat_trench()
{
	var_00 = maps\_utility::array_spawn_targetname("logging_road_loud_combat_trench_enemy");
}

//Function Number: 190
logging_road_loud_combat_mech_march()
{
	var_00 = maps\_utility::array_spawn_targetname("logging_road_loud_combat_mechmarch_enemy");
}

//Function Number: 191
logging_road_loud_combat_end()
{
	var_00 = maps\_utility::array_spawn_targetname("logging_road_loud_combat_end_enemy");
}

//Function Number: 192
logging_road_end_drop_logic()
{
	var_00 = getent("forest_drop_clip","targetname");
	var_00 notsolid();
	common_scripts\utility::flag_wait("flag_logging_road_complete");
	thread player_near_logging_road_end_log();
	thread player_under_logging_road_end_log();
	common_scripts\utility::flag_wait("flag_seeker_clear");
	thread cleanup_ai_logging_road();
	if(isdefined(level.player.old_weapon))
	{
		level.player takeweapon("iw5_unarmed_nullattach");
		level.player switchtoweapon(level.player.old_weapon);
		level.player enableweaponswitch();
		level.player.old_weapon = undefined;
	}

	var_00 solid();
}

//Function Number: 193
player_near_logging_road_end_log()
{
	level endon("flag_seeker_clear");
	for(;;)
	{
		common_scripts\utility::flag_wait("player_near_logging_road_end_log");
		maps\_utility::hintdisplayhandler("prone_hint");
		common_scripts\utility::flag_waitopen("player_near_logging_road_end_log");
	}
}

//Function Number: 194
player_under_logging_road_end_log()
{
	level endon("flag_seeker_clear");
	var_00 = getent("player_under_logging_road_end_log","targetname");
	for(;;)
	{
		while(!level.player istouching(var_00))
		{
			wait 0.05;
		}

		while(level.player istouching(var_00))
		{
			if(common_scripts\utility::flag("flag_logging_road_loud_combat"))
			{
				wait(randomfloatrange(1,2.5));
				thread kill_player_under_log_test();
			}

			wait 0.05;
		}
	}
}

//Function Number: 195
kill_player_under_log_test()
{
	level notify("kill_player_under_log_test");
	level endon("kill_player_under_log_test");
	level.player endon("death");
	level endon("flag_seeker_clear");
	for(;;)
	{
		if(level.burke getclosestenemysqdist(level.player.origin) < 1048576)
		{
			break;
		}

		wait(0.1);
	}

	thread kill_player_under_log_execution();
}

//Function Number: 196
kill_player_under_log_execution()
{
	var_00 = common_scripts\utility::array_randomize(common_scripts\utility::getstructarray("kill_player_under_log_bullet_soruce","targetname"));
	var_01 = var_00[0];
	foreach(var_03 in var_00)
	{
		if(bullettracepassed(var_03.origin,level.player geteye(),0,level.player))
		{
			var_01 = var_03;
			break;
		}
	}

	for(;;)
	{
		magicbullet("iw5_bal27_sp",var_01.origin,level.player geteye());
		level.player enabledeathshield(0);
		level.player dodamage(level.player.health / 10,var_01.origin);
		wait(0.05);
	}
}

//Function Number: 197
cleanup_ai_logging_road()
{
	common_scripts\utility::array_call(getaiarray("axis"),::delete);
}

//Function Number: 198
combat_post_breach_patrol()
{
	common_scripts\utility::flag_wait("flag_post_breach_patrol");
	var_00 = common_scripts\utility::getstruct("org_post_breach_patrol","targetname");
	level.burke thread maps\lab_utility::prevent_friendly_from_shooting_during_stealth();
	level.cormack thread maps\lab_utility::prevent_friendly_from_shooting_during_stealth();
	level.knox thread maps\lab_utility::prevent_friendly_from_shooting_during_stealth();
	level.burke maps\lab_utility::disable_grenades();
	level.cormack maps\lab_utility::disable_grenades();
	level.knox maps\lab_utility::disable_grenades();
	level.burke.ignoreme = 1;
	level.cormack.ignoreme = 1;
	level.knox.ignoreme = 1;
	var_01 = 21.5;
	level.burke maps\_utility::delaythread(var_01,::maps\_stealth_utility::disable_stealth_for_ai);
	level.cormack maps\_utility::delaythread(var_01,::maps\_stealth_utility::disable_stealth_for_ai);
	level.knox maps\_utility::delaythread(var_01,::maps\_stealth_utility::disable_stealth_for_ai);
	level.burke maps\_utility::set_baseaccuracy(999);
	level.cormack maps\_utility::set_baseaccuracy(999);
	level.knox maps\_utility::set_baseaccuracy(999);
	var_02 = maps\_utility::spawn_script_noteworthy("enemy_post_breach_patrol_01",1);
	var_03 = maps\_utility::spawn_script_noteworthy("enemy_post_breach_patrol_02",1);
	var_02 thread se_breach_patrol_guy_01(var_00);
	var_03 thread se_breach_patrol_guy_02(var_00);
	var_02.fovcosine = cos(35);
	var_03.fovcosine = cos(35);
	maps\_utility::delaythread(3,::common_scripts\utility::flag_set,"flag_breach_patrol_01_clear");
	maps\_utility::delaythread(14,::common_scripts\utility::flag_set,"flag_breach_patrol_02_reached_end");
	level.burke thread burke_post_breach_move();
	level.cormack thread cormack_post_breach_move();
	level.knox thread knox_post_breach_move(var_02,var_03);
	var_04 = [var_02,var_03];
	foreach(var_06 in var_04)
	{
		var_06 thread patrol_post_breach_think(var_01);
	}

	common_scripts\utility::flag_wait_all("flag_breach_patrol_01_dead","flag_breach_patrol_02_dead");
	level.burke.ignoreme = 0;
	level.cormack.ignoreme = 0;
	level.knox.ignoreme = 0;
	level.burke maps\lab_utility::enable_grenades();
	level.cormack maps\lab_utility::enable_grenades();
	level.knox maps\lab_utility::enable_grenades();
	level.burke maps\_utility::set_baseaccuracy(0.2);
	level.cormack maps\_utility::set_baseaccuracy(0.2);
	level.knox maps\_utility::set_baseaccuracy(0.2);
	level.burke maps\_utility::enable_ai_color_dontmove();
	level.cormack maps\_utility::enable_ai_color_dontmove();
	level.knox maps\_utility::enable_ai_color_dontmove();
	if(!common_scripts\utility::flag("flag_obj_bio_weapons_04"))
	{
		maps\_utility::activate_trigger_with_targetname("trig_color_facility_clear");
	}
}

//Function Number: 199
se_breach_patrol_guy_01(param_00)
{
	self endon("death");
	self endon("damage");
	self.animname = "guy_1";
	self.allowdeath = 1;
	param_00 maps\_anim::anim_single_solo(self,"se_breach_patrol_guy_01");
}

//Function Number: 200
se_breach_patrol_guy_02(param_00)
{
	self endon("death");
	self endon("damage");
	self.animname = "guy_2";
	self.allowdeath = 1;
	param_00 maps\_anim::anim_single_solo(self,"se_breach_patrol_guy_02");
}

//Function Number: 201
patrol_post_breach_think(param_00)
{
	self endon("death");
	maps\lab_utility::disable_grenades();
	thread force_alert_patrol(param_00);
	common_scripts\utility::waittill_any_ents(self,"damage",self,"patrol_alerted",self,"_stealth_spotted",self,"stealth_event",self,"weapon_fired");
	maps\_utility::ent_flag_clear("_stealth_enabled");
	level notify("patrol_alerted");
	common_scripts\utility::flag_set("_stealth_spotted");
	common_scripts\utility::flag_set("flag_post_breach_patrol_alerted");
}

//Function Number: 202
force_alert_patrol(param_00)
{
	level endon("patrol_alerted");
	self.dontattackme = undefined;
	self.dontevershoot = undefined;
	level thread maps\_utility::notify_delay("patrol_alerted",param_00);
	maps\_utility::delaythread(param_00,::common_scripts\utility::flag_set,"_stealth_spotted");
	maps\_utility::delaythread(param_00,::common_scripts\utility::flag_set,"flag_post_breach_patrol_alerted");
}

//Function Number: 203
knox_move_to_breach_door()
{
	wait(10);
	var_00 = getnode("node_knox_breach_door","targetname");
	level.knox thread maps\lab_utility::goto_node(var_00,0);
}

//Function Number: 204
burke_post_breach_move()
{
	level.burke endon("anim_reach_server_room_started");
	thread cloak_off_server_room(2);
	var_00 = getnode("node_burke_breach_02","targetname");
	var_01 = getnode("node_burke_breach_03","targetname");
	common_scripts\utility::flag_wait("breach_done");
	maps\_utility::delaythread(2,::maps\lab_utility::cloak_on);
	common_scripts\utility::flag_wait("flag_breach_patrol_01_clear");
	maps\lab_utility::goto_node(var_01,0);
}

//Function Number: 205
cormack_post_breach_move()
{
	level.cormack endon("anim_reach_server_room_started");
	thread cloak_off_server_room(1.75);
	var_00 = getnode("node_cormack_breach_02","targetname");
	var_01 = getnode("node_knox_breach_02","targetname");
	common_scripts\utility::flag_wait("lab_breach_all_guys_dead");
	maps\_utility::delaythread(3.75,::maps\lab_utility::cloak_on);
	common_scripts\utility::flag_wait_all("flag_breach_patrol_01_clear","flag_burke_exit_breach_room");
	maps\lab_utility::goto_node(var_00,0);
	common_scripts\utility::flag_wait_any("flag_breach_patrol_01_dead","flag_breach_patrol_02_dead","flag_breach_patrol_02_reached_end");
	maps\lab_utility::goto_node(var_01,0);
}

//Function Number: 206
knox_post_breach_move(param_00,param_01)
{
	level.knox endon("anim_reach_server_room_started");
	thread cloak_off_server_room(1.5,0.2);
	var_02 = getnode("node_knox_breach_02","targetname");
	var_03 = getnode("node_knox_breach_03","targetname");
	var_04 = getnode("node_knox_breach_04","targetname");
	common_scripts\utility::flag_wait("lab_breach_all_guys_dead");
	maps\_utility::set_baseaccuracy(999);
	maps\lab_utility::any_enemy_is_able_to_attack();
	maps\_utility::delaythread(3,::maps\lab_utility::cloak_on);
	common_scripts\utility::flag_wait_all("flag_breach_patrol_01_clear","flag_burke_exit_breach_room");
	maps\lab_utility::goto_node(var_02,0);
	common_scripts\utility::flag_wait_any("flag_breach_patrol_01_dead","flag_breach_patrol_02_dead","flag_breach_patrol_02_reached_end");
	maps\lab_utility::goto_node(var_03,0);
	if(common_scripts\utility::flag("flag_breach_patrol_01_dead") && common_scripts\utility::flag("flag_breach_patrol_02_reached_end"))
	{
	}
	else if(common_scripts\utility::flag("flag_breach_patrol_01_dead") && !common_scripts\utility::flag("flag_breach_patrol_02_reached_end"))
	{
		maps\lab_utility::goto_node(var_04,0);
	}

	common_scripts\utility::flag_wait_all("flag_breach_patrol_01_dead","flag_breach_patrol_02_dead");
	maps\lab_utility::goto_node(var_04,0);
}

//Function Number: 207
cloak_off_server_room(param_00,param_01)
{
	common_scripts\utility::flag_wait_all("flag_breach_patrol_01_dead","flag_breach_patrol_02_dead");
	wait(param_00);
	maps\lab_utility::cloak_off();
	maps\_utility::enable_cqbwalk();
	if(isdefined(param_01))
	{
		maps\_utility::set_baseaccuracy(param_01);
	}
}

//Function Number: 208
combat_research_building()
{
	common_scripts\utility::flag_wait("flag_research_facility_combat_dialogue_complete");
	var_00 = getentarray("enemy_research_building_wave_01","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::spawn_ai(1);
	}

	var_00 = getentarray("enemy_research_wave_01","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::spawn_ai(1);
	}

	maps\lab_utility::spawn_metrics_waittill_count_reaches(4,["enemy_research_building_wave_01","enemy_research_wave_01"],0);
	var_00 = getentarray("enemy_research_building_wave_02","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::spawn_ai(1);
	}
}

//Function Number: 209
combat_research_building_bridge()
{
	common_scripts\utility::flag_wait("flag_combat_research_02");
	var_00 = getentarray("enemy_research_bridge_wave_01","script_noteworthy");
	if(var_00.size > 0 && !common_scripts\utility::flag("flag_obj_neutralize_bio_weapons_complete"))
	{
		maps\_spawner::flood_spawner_scripted(var_00);
	}

	common_scripts\utility::flag_wait("flag_combat_research_bridge_01");
	var_00 = getentarray("enemy_research_bridge_wave_02","script_noteworthy");
	if(var_00.size > 0 && !common_scripts\utility::flag("flag_obj_neutralize_bio_weapons_complete"))
	{
		maps\_spawner::flood_spawner_scripted(var_00);
	}

	maps\lab_utility::spawn_metrics_waittill_count_reaches(1,["enemy_research_bridge_wave_01","enemy_research_bridge_wave_02"],0);
	var_00 = ["enemy_research_bridge_wave_01","enemy_research_bridge_wave_02"];
	maps\lab_utility::delete_spawners(var_00);
	maps\_utility::activate_trigger_with_targetname("trig_color_research_facility_bridge");
	common_scripts\utility::flag_set("flag_combat_facility_bridge_seek_player");
}

//Function Number: 210
combat_research_pool_walkway_01()
{
	common_scripts\utility::flag_wait("flag_combat_research_03");
	var_00 = getentarray("enemy_pool_building_walkway_wave_01","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::spawn_ai(1);
	}

	maps\lab_utility::spawn_metrics_waittill_count_reaches(3,["enemy_pool_building_walkway_wave_01"],0);
	var_00 = getentarray("enemy_pool_building_walkway_wave_02","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::spawn_ai(1);
	}

	maps\lab_utility::spawn_metrics_waittill_count_reaches(2,["enemy_pool_building_walkway_wave_01","enemy_pool_building_walkway_wave_02"],0);
	var_00 = ["enemy_pool_building_walkway_wave_01","enemy_pool_building_walkway_wave_02"];
	maps\lab_utility::delete_spawners(var_00);
	common_scripts\utility::flag_set("flag_guys_pool_bldg_01_seek_player");
}

//Function Number: 211
combat_research_left_01()
{
	level endon("flag_combat_research_right_01");
	common_scripts\utility::flag_wait("flag_combat_research_left_01");
	var_00 = getentarray("enemy_research_left_01","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::spawn_ai(1);
	}

	var_00 = getentarray("enemy_research_left_lower_01","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::spawn_ai(1);
	}

	maps\lab_utility::spawn_metrics_waittill_count_reaches(3,["enemy_research_left_01","enemy_research_left_lower_01"],0);
	common_scripts\utility::flag_set("flag_guys_research_left_01_seek_player");
}

//Function Number: 212
combat_research_right_01()
{
	level endon("flag_combat_research_left_01");
	common_scripts\utility::flag_wait("flag_combat_research_right_01");
	var_00 = getentarray("enemy_research_right_flank_01","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::spawn_ai(1);
	}

	var_00 = getentarray("enemy_research_right_01","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::spawn_ai(1);
	}

	var_00 = getentarray("enemy_research_right_lower_01","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::spawn_ai(1);
	}

	thread combat_spawn_research_right_flank_02();
	maps\lab_utility::spawn_metrics_waittill_count_reaches(3,["enemy_research_right_01","enemy_research_right_lower_01"],0);
	common_scripts\utility::flag_set("flag_guys_research_right_01_seek_player");
}

//Function Number: 213
combat_spawn_research_right_flank_02()
{
	common_scripts\utility::flag_wait_any("flag_combat_research_04","flag_right_flank_01_dead");
	var_00 = getentarray("enemy_research_right_flank_02","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 maps\_utility::spawn_ai(1);
	}
}

//Function Number: 214
combat_research_platform_01()
{
	common_scripts\utility::flag_wait_any("flag_guys_research_right_01_seek_player","flag_guys_research_left_01_seek_player");
	var_00 = getentarray("enemy_platform_01","script_noteworthy");
	if(!common_scripts\utility::flag("flag_combat_research_05"))
	{
		foreach(var_02 in var_00)
		{
			var_02 maps\_utility::spawn_ai(1);
		}
	}
}

//Function Number: 215
combat_research_pool_room()
{
	common_scripts\utility::flag_set("flag_bomb_plant_trigger_on");
	thread control_foam_room_door02_clip();
	thread foam_planted_kill_enemies();
	common_scripts\utility::flag_wait("flag_combat_research_03");
	var_00 = ["enemy_research_building_wave_01"];
	maps\lab_utility::delete_spawners(var_00);
	common_scripts\utility::flag_wait_any("flag_combat_research_04","flag_combat_research_04_bottom");
	var_00 = ["enemy_pool_building_wave_01"];
	maps\lab_utility::delete_spawners(var_00);
	var_00 = getentarray("enemy_pool_building_wave_02","script_noteworthy");
	if(var_00.size > 0)
	{
		maps\_spawner::flood_spawner_scripted(var_00);
	}

	thread maps\_utility::autosave_by_name("pool_room");
	common_scripts\utility::flag_wait("flag_combat_research_05");
	soundscripts\_snd::snd_message("aud_foam_room_emitters");
	var_00 = ["enemy_pool_building_wave_02"];
	maps\lab_utility::delete_spawners(var_00);
	var_01 = ["enemy_research_building_wave_01","enemy_research_building_wave_02","enemy_pool_building_wave_01","enemy_pool_building_wave_02"];
	maps\lab_utility::spawn_metrics_waittill_count_reaches(5,["enemy_research_building_wave_01","enemy_research_building_wave_02","enemy_pool_building_wave_01","enemy_pool_building_wave_02"],0);
	common_scripts\utility::flag_set("flag_combat_research_retreat_foam_room");
	maps\_utility::activate_trigger_with_targetname("trig_color_foam_room_combat");
	maps\lab_utility::spawn_metrics_waittill_count_reaches(3,["enemy_research_building_wave_01","enemy_research_building_wave_02","enemy_pool_building_wave_01","enemy_pool_building_wave_02"],0);
	common_scripts\utility::flag_set("flag_foam_room_combat_clear_out");
	maps\lab_utility::spawn_metrics_waittill_count_reaches(0,["enemy_research_building_wave_01","enemy_research_building_wave_02","enemy_pool_building_wave_01","enemy_pool_building_wave_02"],0);
	common_scripts\utility::flag_set("flag_research_building_combat_complete");
	common_scripts\utility::flag_clear("flag_enable_battle_chatter");
	soundscripts\_snd::snd_message("research_building_combat_complete");
	var_02 = getaiarray("axis");
	foreach(var_04 in var_02)
	{
		var_05 = randomfloatrange(0.5,2);
		var_04 thread maps\lab_utility::bloody_death(var_05);
		wait(0.3);
	}

	common_scripts\utility::flag_wait_all("flag_research_building_combat_complete","flag_player_inside_foam_room");
	level.burke.ignoreall = 1;
	level.cormack.ignoreall = 1;
	level.knox.ignoreall = 1;
	var_07 = getentarray("c_trigger_researh","script_noteworthy");
	foreach(var_09 in var_07)
	{
		var_09 common_scripts\utility::trigger_off();
	}
}

//Function Number: 216
foam_planted_kill_enemies()
{
	common_scripts\utility::flag_wait("flag_obj_neutralize_bio_weapons_planted");
	var_00 = getaiarray("axis");
	foreach(var_02 in var_00)
	{
		var_03 = randomfloatrange(0.5,1);
		var_02 thread maps\lab_utility::bloody_death(var_03);
	}
}

//Function Number: 217
foam_room_door_think()
{
	var_00 = 0.75;
	var_01 = getent("door_foam_room_l","targetname");
	var_02 = getent("door_foam_room_r","targetname");
	var_03 = var_01 common_scripts\utility::get_target_ent();
	var_04 = var_02 common_scripts\utility::get_target_ent();
	var_03 linkto(var_01);
	var_04 linkto(var_02);
	var_05 = common_scripts\utility::getstruct("org_door_foam_room_open_l","targetname");
	var_06 = common_scripts\utility::getstruct("org_door_foam_room_open_r","targetname");
	var_07 = common_scripts\utility::getstruct("org_door_foam_room_close_l","targetname");
	var_08 = common_scripts\utility::getstruct("org_door_foam_room_close_r","targetname");
	var_01 moveto(var_05.origin,var_00,0.25,0.25);
	var_02 moveto(var_06.origin,var_00,0.25,0.25);
	wait(var_00);
	var_03 connectpaths();
	var_04 connectpaths();
	common_scripts\utility::flag_wait("flag_combat_research_05");
	var_01 moveto(var_07.origin,var_00,0.25,0.25);
	var_02 moveto(var_08.origin,var_00,0.25,0.25);
	wait(var_00);
	var_03 disconnectpaths();
	var_04 disconnectpaths();
	common_scripts\utility::flag_wait("flag_foam_room_complete_dialogue");
	var_01 moveto(var_05.origin,var_00,0.25,0.25);
	var_02 moveto(var_06.origin,var_00,0.25,0.25);
	wait(var_00);
	var_03 connectpaths();
	var_04 connectpaths();
}

//Function Number: 218
foam_room_door_01_close()
{
	var_00 = 0.75;
	var_01 = getent("door_01_foam_room_l","targetname");
	var_02 = getent("door_01_foam_room_r","targetname");
	var_03 = var_01 common_scripts\utility::get_target_ent();
	var_04 = var_02 common_scripts\utility::get_target_ent();
	var_03 linkto(var_01);
	var_04 linkto(var_02);
	var_05 = common_scripts\utility::getstruct("org_door_01_foam_room_close_l","targetname");
	var_06 = common_scripts\utility::getstruct("org_door_01_foam_room_close_r","targetname");
	var_01 moveto(var_05.origin,var_00,0.25,0.25);
	var_02 moveto(var_06.origin,var_00,0.25,0.25);
	wait(var_00);
	var_03 disconnectpaths();
	var_04 disconnectpaths();
}

//Function Number: 219
foam_room_door_03_close()
{
	var_00 = 0.75;
	var_01 = getent("door_03_foam_room_l","targetname");
	var_02 = getent("door_03_foam_room_r","targetname");
	var_03 = var_01 common_scripts\utility::get_target_ent();
	var_04 = var_02 common_scripts\utility::get_target_ent();
	var_03 linkto(var_01);
	var_04 linkto(var_02);
	var_05 = common_scripts\utility::getstruct("org_door_03_foam_room_close_l","targetname");
	var_06 = common_scripts\utility::getstruct("org_door_03_foam_room_close_r","targetname");
	var_01 moveto(var_05.origin,var_00,0.25,0.25);
	var_02 moveto(var_06.origin,var_00,0.25,0.25);
	wait(var_00);
	var_03 disconnectpaths();
	var_04 disconnectpaths();
}

//Function Number: 220
foam_room_door_02_close()
{
	var_00 = 0.75;
	var_01 = getent("door_02_foam_room_l","targetname");
	var_02 = getent("door_02_foam_room_r","targetname");
	soundscripts\_snd::snd_message("foam_room_door_close",var_01,var_02);
	var_03 = var_01 common_scripts\utility::get_target_ent();
	var_04 = var_02 common_scripts\utility::get_target_ent();
	var_03 linkto(var_01);
	var_04 linkto(var_02);
	var_05 = common_scripts\utility::getstruct("org_door_02_foam_room_close_l","targetname");
	var_06 = common_scripts\utility::getstruct("org_door_02_foam_room_close_r","targetname");
	common_scripts\utility::flag_wait("flag_combat_research_05");
	var_01 moveto(var_05.origin,var_00,0.25,0.25);
	var_02 moveto(var_06.origin,var_00,0.25,0.25);
	wait(var_00);
	var_03 disconnectpaths();
	var_04 disconnectpaths();
}

//Function Number: 221
control_foam_room_door02_clip()
{
	var_00 = getent("foam_room_instant_door02_clip","targetname");
	var_00 notsolid();
	var_00 connectpaths();
	common_scripts\utility::flag_wait("flag_foam_room_clear");
	var_00 solid();
}

//Function Number: 222
courtyard_scrambler_rotate()
{
	var_00 = getent("scrambler_top","targetname");
	var_00.point_tag = common_scripts\utility::spawn_tag_origin();
	var_01 = var_00.point_tag;
	var_01 linkto(var_00,"lab_comm_satellite_top_lod0_comb",(15,15,220),(0,0,0),0);
	playfxontag(common_scripts\utility::getfx("light_glow_red_steady"),var_01,"tag_origin");
	while(!common_scripts\utility::flag("flag_obj_jammer_complete"))
	{
		var_00 addyaw(2.5);
		wait(0.05);
	}

	var_02 = 2.5;
	for(var_03 = 0;var_03 < 25;var_03++)
	{
		var_02 = var_02 - 0.1;
		var_00 addyaw(var_02);
		wait(0.05);
	}
}

//Function Number: 223
platform_door_think()
{
	var_00 = 0.75;
	var_01 = getent("door_platform_l","targetname");
	var_02 = getent("door_platform_r","targetname");
	soundscripts\_snd::snd_message("door2courtyard_open");
	var_03 = var_01 common_scripts\utility::get_target_ent();
	var_04 = var_02 common_scripts\utility::get_target_ent();
	var_03 linkto(var_01);
	var_04 linkto(var_02);
	var_05 = common_scripts\utility::getstruct("org_door_platform_open_l","targetname");
	var_06 = common_scripts\utility::getstruct("org_door_platform_open_r","targetname");
	var_07 = common_scripts\utility::getstruct("org_door_platform_close_l","targetname");
	var_08 = common_scripts\utility::getstruct("org_door_platform_close_r","targetname");
	var_01 moveto(var_05.origin,var_00,0.25,0.25);
	var_02 moveto(var_06.origin,var_00,0.25,0.25);
	wait(var_00);
	var_03 connectpaths();
	var_04 connectpaths();
	common_scripts\utility::flag_wait("flag_combat_research_05");
	var_01 moveto(var_07.origin,var_00,0.25,0.25);
	var_02 moveto(var_08.origin,var_00,0.25,0.25);
	wait(var_00);
	var_03 disconnectpaths();
	var_04 disconnectpaths();
}

//Function Number: 224
combat_courtyard_mech()
{
	common_scripts\utility::flag_wait("flag_courtyard_hangar_door_block");
	level.cormack maps\_utility::disable_ai_color();
	level.knox maps\_utility::disable_ai_color();
	var_00 = getnode("cormack_mech_sneak","script_noteworthy");
	var_01 = getnode("knox_mech_sneak","script_noteworthy");
	level.cormack setgoalnode(var_00);
	level.knox setgoalnode(var_01);
	level.hangar_mech_01 = getent("enemy_hangar_mech_01","targetname") maps\_utility::spawn_ai(1);
	level.hangar_mech_01 maps\_mech::mech_start_reduced_nonplayer_damage();
	level.hangar_mech_01 maps\_utility::magic_bullet_shield();
	soundscripts\_snd::snd_message("courtyard_hangar_mech_01_spawned",level.hangar_mech_01);
	level.knox.ignoreme = 1;
	level.cormack.ignoreme = 1;
	level.burke.ignoreme = 1;
	level.burke.ignoreall = 1;
	level.knox.ignoreall = 1;
	level.cormack.ignoreall = 1;
	level.hangar_mech_01.ignoreall = 1;
	maps\_utility::delaythread(2,::courtyard_hangar_door_close);
	level.hangar_mech_01.animname = "mech";
	var_02 = common_scripts\utility::getstruct("courtyard_mech_reveal","targetname");
	var_02 maps\_anim::anim_single_solo(level.hangar_mech_01,"courtyard_mech_intro",undefined,0.55);
	level.hangar_mech_01 maps\_utility::stop_magic_bullet_shield();
	maps\lab_utility::cleanup_ai_with_script_noteworthy("enemy_courtyard_initial",128);
	maps\lab_utility::cleanup_ai_with_script_noteworthy("enemy_hangar_building_01",128);
	level notify("remove_doormen");
	level.burke.ignoreall = 0;
	level.hangar_mech_01.ignoreall = 0;
	level.hangar_mech_01 setgoalentity(level.player);
	level.hangar_mech_01.favoriteenemy = level.player;
	createthreatbiasgroup("player");
	createthreatbiasgroup("mech");
	level.player setthreatbiasgroup("player");
	level.hangar_mech_01 setthreatbiasgroup("mech");
	setthreatbias("player","mech",900000);
	level.hangar_mech_01 maps\_mech::mech_start_rockets();
	level.hangar_mech_01 maps\_mech::mech_start_hunting();
	level.hangar_mech_01 maps\_mech::mech_start_badplace_behavior();
	wait_for_mech_distance();
	level.hangar_mech_01.walkdist = 200;
	level.hangar_mech_01.walkdistfacingmotion = level.hangar_mech_01.walkdist;
	level.knox.ignoreall = 0;
	level.cormack.ignoreall = 0;
	common_scripts\utility::flag_set("flag_combat_courtyard_jammer");
	common_scripts\utility::flag_set("flag_courtyard_hangar_door_hack");
}

//Function Number: 225
wait_for_mech_distance()
{
	if(isdefined(level.hangar_mech_01) && isalive(level.hangar_mech_01))
	{
		level.hangar_mech_01 endon("death");
		var_00 = getent("obj_defend_01","targetname");
		var_01 = 600;
		var_02 = var_01 * var_01;
		while(distancesquared(level.hangar_mech_01.origin,var_00.origin) < var_02)
		{
			wait(0.1);
		}
	}
}

//Function Number: 226
courtyard_gates_think()
{
	common_scripts\utility::flag_wait("flag_foam_room_complete_dialogue");
	var_00 = getentarray("courtyard_perimeter_gate_instance_02","script_noteworthy");
	var_01 = undefined;
	foreach(var_03 in var_00)
	{
		if(var_03.classname == "script_model")
		{
			var_01 = var_03;
			break;
		}
	}

	var_05 = getent(var_01.target,"targetname");
	var_01 maps\_anim::anim_first_frame_solo(var_01,"opened");
	var_05 notsolid();
	common_scripts\utility::flag_wait("flag_combat_courtyard_general_01");
	var_05 common_scripts\utility::delaycall(1,::solid);
	var_01 maps\_anim::anim_single_solo(var_01,"close");
	var_01 maps\_anim::anim_first_frame_solo(var_01,"closed");
}

//Function Number: 227
courtyard_rappel_preview()
{
	level.burke.ignoreme = 1;
	level.cormack.ignoreme = 1;
	level.knox.ignoreme = 1;
	level.player.ignoreme = 1;
	var_00 = getentarray("courtyard_perimeter_gate_instance_01","script_noteworthy");
	var_01 = undefined;
	foreach(var_03 in var_00)
	{
		if(var_03.classname == "script_model")
		{
			var_01 = var_03;
			break;
		}
	}

	var_05 = getent(var_01.target,"targetname");
	var_01 maps\_anim::anim_first_frame_solo(var_01,"opened");
	var_05 notsolid();
	var_05 connectpaths();
	thread courtyard_rappel_preview_guys();
	thread courtyard_rappel_preview_vehicles();
	level waittill("cliff_rappel_landing");
	level.player.ignoreme = 0;
	var_01 maps\_anim::anim_single_solo(var_01,"close");
	var_01 maps\_anim::anim_first_frame_solo(var_01,"closed");
	wait(3);
	var_05 solid();
	var_05 disconnectpaths();
}

//Function Number: 228
courtyard_rappel_preview_guys()
{
	level endon("cliff_rappel_landing");
	var_00 = getent("enemy_courtyard_rappel_preview_01","script_noteworthy");
	var_01 = getent("enemy_courtyard_rappel_preview_02","script_noteworthy");
	var_02 = getent("enemy_courtyard_rappel_preview_03","script_noteworthy");
	var_03 = getent("enemy_courtyard_rappel_preview_04","script_noteworthy");
	maps\_utility::array_spawn_function_noteworthy("enemy_courtyard_rappel_preview_01",::courtyard_rappel_preview_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_courtyard_rappel_preview_02",::courtyard_rappel_preview_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_courtyard_rappel_preview_03",::courtyard_rappel_preview_think);
	maps\_utility::array_spawn_function_noteworthy("enemy_courtyard_rappel_preview_04",::courtyard_rappel_preview_think);
	wait(21);
	for(;;)
	{
		var_04 = randomintrange(1,2);
		for(var_05 = 0;var_05 < var_04;var_05++)
		{
			var_00 maps\_utility::spawn_ai();
			var_01 maps\_utility::spawn_ai();
			var_02 maps\_utility::spawn_ai();
			var_03 maps\_utility::spawn_ai();
			var_00.count++;
			var_01.count++;
			var_02.count++;
			var_03.count++;
			wait(randomfloatrange(0.8,1.2));
		}

		wait(randomfloatrange(2,3));
	}
}

//Function Number: 229
courtyard_rappel_preview_vehicles()
{
	wait(19);
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("courtyard_vrap_preview");
	var_00 maps\_vehicle::vehicle_lights_on();
	level waittill("cliff_rappel_landing");
	var_00 delete();
}

//Function Number: 230
courtyard_rappel_preview_think()
{
	self.goalradius = 8;
	self.ignoreme = 1;
	self waittill("goal");
	self delete();
}

//Function Number: 231
courtyard_rpg_drop()
{
	self.dropweapon = 0;
}

//Function Number: 232
combat_courtyard_path_general()
{
	level.courtyard_goal_volume = getent("courtyard_combat_volume_initial","script_noteworthy");
	common_scripts\utility::array_thread(getentarray("courtyard_goal_volume_trigger","targetname"),::courtyard_goal_volume_trigger_think);
	thread combat_courtyard_path_jammer_building();
	thread combat_courtyard_path_left_00();
	thread combat_courtyard_path_left_01();
	thread combat_courtyard_path_left_02();
	thread combat_courtyard_path_left_03();
	thread combat_courtyard_path_middle_01();
	thread combat_courtyard_path_middle_02();
	thread combat_courtyard_path_middle_03();
	thread combat_courtyard_path_right_01();
	thread combat_courtyard_path_right_02();
	thread combat_courtyard_path_right_03();
	thread courtyard_gates_think();
	thread courtyard_scrambler_rotate();
	soundscripts\_snd::snd_message("courtyard_start_dish");
	common_scripts\utility::flag_wait("flag_combat_courtyard_general_01");
	var_00 = getentarray("combat_courtyard_general_01","targetname");
	if(var_00.size > 0)
	{
		foreach(var_02 in var_00)
		{
			var_02 maps\_utility::spawn_ai(1);
		}
	}

	thread maps\lab_lighting::courtyard_sun_off();
	thread courtyard_traversal_initial();
	thread courtyard_hangar_door_open();
	thread courtyard_hangar_door_hack();
	level.courtyard_vrap04 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("courtyard_vrap04");
	level.courtyard_vrap04 maps\_vehicle::vehicle_lights_on();
	soundscripts\_snd::snd_message("aud_ctyard_vrap04");
	wait(1);
	level.courtyard_vrap05 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("courtyard_vrap05");
	level.courtyard_vrap05 maps\_vehicle::vehicle_lights_on();
	soundscripts\_snd::snd_message("aud_ctyard_vrap05");
	common_scripts\utility::flag_wait_either("flag_combat_courtyard_vehicle01_a","flag_combat_courtyard_vehicle01_b");
	thread maps\_utility::autosave_by_name("courtyard_midpoint");
	thread combat_courtyard_mech();
	var_00 = getentarray("enemy_hangar_building_01","script_noteworthy");
	maps\_utility::array_spawn_function(var_00,::courtyard_rpg_drop);
	if(var_00.size > 0)
	{
		maps\_spawner::flood_spawner_scripted(var_00);
	}

	level.courtyard_vrap01 = maps\_vehicle::spawn_vehicle_from_targetname("courtyard_vrap01");
	var_04 = undefined;
	var_05 = level.courtyard_vrap01.riders[0];
	var_06 = level.courtyard_vrap01.riders[1];
	if(common_scripts\utility::flag("flag_combat_courtyard_vehicle01_a"))
	{
		var_04 = getvehiclenode("courtyard_vehicle01_a","targetname");
	}

	if(common_scripts\utility::flag("flag_combat_courtyard_vehicle01_b"))
	{
		var_04 = getvehiclenode("courtyard_vehicle01_b","targetname");
	}

	level.courtyard_vrap01 thread maps\_vehicle_code::_vehicle_paths(var_04);
	level.courtyard_vrap01 startpath(var_04);
	level.courtyard_vrap01 maps\_vehicle::vehicle_lights_on();
	soundscripts\_snd::snd_message("aud_ctyard_vrap01");
	level.courtyard_vrap01 waittill("unloaded");
	if(common_scripts\utility::flag("flag_combat_courtyard_vehicle01_a"))
	{
		var_05 setgoalnode(getnode("vrap01_startingposition0_node_a","targetname"));
		var_06 setgoalnode(getnode("vrap01_startingposition1_node_a","targetname"));
	}

	if(common_scripts\utility::flag("flag_combat_courtyard_vehicle01_b"))
	{
		var_05 setgoalnode(getnode("vrap01_startingposition0_node_b","targetname"));
		var_06 setgoalnode(getnode("vrap01_startingposition1_node_b","targetname"));
	}

	var_05.fixednode = 1;
	var_06.fixednode = 1;
}

//Function Number: 233
combat_courtyard_path_jammer_building()
{
	common_scripts\utility::flag_wait_either("flag_combat_courtyard_path_jammer_building_lower","flag_combat_courtyard_path_jammer_building_upper");
	var_00 = undefined;
	if(common_scripts\utility::flag("flag_combat_courtyard_path_jammer_building_lower"))
	{
		var_00 = getentarray("combat_courtyard_path_jammer_building_lower","targetname");
	}
	else if(common_scripts\utility::flag("flag_combat_courtyard_path_jammer_building_upper"))
	{
		var_00 = getentarray("combat_courtyard_path_jammer_building_upper","targetname");
	}

	if(var_00.size > 0)
	{
		maps\_utility::array_spawn(var_00);
	}
}

//Function Number: 234
combat_courtyard_path_left_00()
{
	common_scripts\utility::flag_wait("flag_combat_courtyard_path_left_00");
	var_00 = getentarray("combat_courtyard_path_left_00","targetname");
	if(var_00.size > 0)
	{
		maps\_utility::array_spawn(var_00);
	}
}

//Function Number: 235
combat_courtyard_path_left_01()
{
	level endon("flag_combat_courtyard_path_right_01");
	level endon("flag_combat_courtyard_path_right_02");
	level endon("flag_combat_courtyard_path_right_03");
	level endon("flag_combat_courtyard_path_middle_01");
	level endon("flag_combat_courtyard_path_middle_02");
	level endon("flag_combat_courtyard_path_middle_03");
	common_scripts\utility::flag_wait("flag_combat_courtyard_path_left_01");
	var_00 = getentarray("combat_courtyard_path_left_01","targetname");
	if(var_00.size > 0)
	{
		maps\_utility::array_spawn(var_00);
	}
}

//Function Number: 236
combat_courtyard_path_left_02()
{
	level endon("flag_combat_courtyard_path_right_01");
	level endon("flag_combat_courtyard_path_right_02");
	level endon("flag_combat_courtyard_path_right_03");
	level endon("flag_combat_courtyard_path_middle_01");
	level endon("flag_combat_courtyard_path_middle_02");
	level endon("flag_combat_courtyard_path_middle_03");
	common_scripts\utility::flag_wait("flag_combat_courtyard_path_left_02");
	var_00 = getentarray("combat_courtyard_path_left_02","targetname");
	if(var_00.size > 0)
	{
		maps\_utility::array_spawn(var_00);
	}
}

//Function Number: 237
combat_courtyard_path_left_03()
{
	level endon("flag_combat_courtyard_path_right_01");
	level endon("flag_combat_courtyard_path_right_02");
	level endon("flag_combat_courtyard_path_right_03");
	level endon("flag_combat_courtyard_path_middle_01");
	level endon("flag_combat_courtyard_path_middle_02");
	level endon("flag_combat_courtyard_path_middle_03");
	common_scripts\utility::flag_wait("flag_combat_courtyard_path_left_03");
	var_00 = getentarray("combat_courtyard_path_left_03","targetname");
	if(var_00.size > 0)
	{
		maps\_utility::array_spawn(var_00);
	}
}

//Function Number: 238
combat_courtyard_path_middle_01()
{
	level endon("flag_combat_courtyard_path_right_01");
	level endon("flag_combat_courtyard_path_right_02");
	level endon("flag_combat_courtyard_path_right_03");
	level endon("flag_combat_courtyard_path_left_01");
	level endon("flag_combat_courtyard_path_left_02");
	level endon("flag_combat_courtyard_path_left_03");
	common_scripts\utility::flag_wait("flag_combat_courtyard_path_middle_01");
	var_00 = getentarray("combat_courtyard_path_middle_01","targetname");
	if(var_00.size > 0)
	{
		maps\_utility::array_spawn(var_00);
	}

	var_01 = getent("combat_courtyard_path_middle_01_rpg","targetname");
	var_01 maps\_utility::add_spawn_function(::courtyard_rpg_drop);
	var_02 = getent("combat_courtyard_path_middle_01_ar","targetname");
	var_03 = var_01 maps\_utility::spawn_ai();
	var_03.baseaccuracy = 0.2;
	var_04 = var_02 maps\_utility::spawn_ai();
	common_scripts\utility::flag_wait_either("flag_combat_courtyard_path_left_02","flag_combat_courtyard_path_right_02");
	maps\_utility::ai_delete_when_out_of_sight([var_03],64);
	maps\_utility::ai_delete_when_out_of_sight([var_04],64);
}

//Function Number: 239
combat_courtyard_path_middle_02()
{
	level endon("flag_combat_courtyard_path_right_01");
	level endon("flag_combat_courtyard_path_right_02");
	level endon("flag_combat_courtyard_path_right_03");
	level endon("flag_combat_courtyard_path_left_01");
	level endon("flag_combat_courtyard_path_left_02");
	level endon("flag_combat_courtyard_path_left_03");
	common_scripts\utility::flag_wait("flag_combat_courtyard_path_middle_02");
	var_00 = getentarray("combat_courtyard_path_middle_02","targetname");
	if(var_00.size > 0)
	{
		maps\_utility::array_spawn(var_00);
	}
}

//Function Number: 240
combat_courtyard_path_middle_03()
{
	level endon("flag_combat_courtyard_path_right_01");
	level endon("flag_combat_courtyard_path_right_02");
	level endon("flag_combat_courtyard_path_right_03");
	level endon("flag_combat_courtyard_path_left_01");
	level endon("flag_combat_courtyard_path_left_02");
	level endon("flag_combat_courtyard_path_left_03");
	common_scripts\utility::flag_wait("flag_combat_courtyard_path_middle_03");
	var_00 = getentarray("combat_courtyard_path_middle_03","targetname");
	if(var_00.size > 0)
	{
		maps\_utility::array_spawn(var_00);
	}
}

//Function Number: 241
combat_courtyard_path_right_01()
{
	level endon("flag_combat_courtyard_path_left_01");
	level endon("flag_combat_courtyard_path_left_02");
	level endon("flag_combat_courtyard_path_left_03");
	level endon("flag_combat_courtyard_path_middle_01");
	level endon("flag_combat_courtyard_path_middle_02");
	level endon("flag_combat_courtyard_path_middle_03");
	common_scripts\utility::flag_wait("flag_combat_courtyard_path_right_01");
	var_00 = getentarray("combat_courtyard_path_right_01","targetname");
	if(var_00.size > 0)
	{
		maps\_utility::array_spawn(var_00);
	}
}

//Function Number: 242
combat_courtyard_path_right_02()
{
	level endon("flag_combat_courtyard_path_left_01");
	level endon("flag_combat_courtyard_path_left_02");
	level endon("flag_combat_courtyard_path_left_03");
	level endon("flag_combat_courtyard_path_middle_01");
	level endon("flag_combat_courtyard_path_middle_02");
	level endon("flag_combat_courtyard_path_middle_03");
	common_scripts\utility::flag_wait("flag_combat_courtyard_path_right_02");
	var_00 = getentarray("combat_courtyard_path_right_02","targetname");
	if(var_00.size > 0)
	{
		maps\_utility::array_spawn(var_00);
	}
}

//Function Number: 243
combat_courtyard_path_right_03()
{
	level endon("flag_combat_courtyard_path_left_01");
	level endon("flag_combat_courtyard_path_left_02");
	level endon("flag_combat_courtyard_path_left_03");
	level endon("flag_combat_courtyard_path_middle_01");
	level endon("flag_combat_courtyard_path_middle_02");
	level endon("flag_combat_courtyard_path_middle_03");
	common_scripts\utility::flag_wait("flag_combat_courtyard_path_right_03");
	var_00 = getentarray("combat_courtyard_path_right_03","targetname");
	if(var_00.size > 0)
	{
		maps\_utility::array_spawn(var_00);
	}
}

//Function Number: 244
combat_courtyard_jammer()
{
	level endon("flag_obj_jammer_interact");
	common_scripts\utility::flag_wait("flag_combat_courtyard_jammer");
	common_scripts\utility::array_thread(getentarray("courtyard_goal_volume_trigger_b","targetname"),::courtyard_goal_volume_trigger_b_think);
	level.courtyard_vrap02 = maps\_vehicle::spawn_vehicle_from_targetname("courtyard_vrap02");
	var_00 = getvehiclenode("courtyard_vrap02_go","targetname");
	common_scripts\utility::flag_wait("flag_courtyard_hangar_door_block");
	if(isdefined(level.hangar_mech_01))
	{
		level.hangar_mech_01 waittill("death");
		common_scripts\utility::flag_set("flag_hangar_mech_01_dead");
	}

	level.burke.ignoreme = 0;
	level.cormack.ignoreme = 0;
	maps\lab_utility::cleanup_ai_with_script_noteworthy("enemy_courtyard_initial",128);
	level.courtyard_vrap02 thread maps\_vehicle_code::_vehicle_paths(var_00);
	level.courtyard_vrap02 startpath(var_00);
	level.courtyard_vrap02 maps\_vehicle::vehicle_lights_on();
	soundscripts\_snd::snd_message("aud_ctyard_vrap02");
	thread combat_courtyard_jammer_ladder_left();
	thread combat_courtyard_jammer_ladder_right();
	var_01 = getentarray("enemy_courtyard_jammer","targetname");
	common_scripts\utility::flag_wait_either("flag_jammer_combat_ladder_left","flag_jammer_combat_ladder_right");
	wait(15);
	if(var_01.size > 0)
	{
		maps\_spawner::flood_spawner_scripted(var_01);
	}
}

//Function Number: 245
combat_courtyard_jammer_ladder_left()
{
	common_scripts\utility::flag_wait("flag_jammer_combat_ladder_left");
	var_00 = getentarray("enemy_courtyard_jammer_ladder_left","targetname");
	if(var_00.size > 0)
	{
		foreach(var_02 in var_00)
		{
			var_02 maps\_utility::spawn_ai(1);
		}
	}
}

//Function Number: 246
combat_courtyard_jammer_ladder_right()
{
	common_scripts\utility::flag_wait("flag_jammer_combat_ladder_right");
	var_00 = getentarray("enemy_courtyard_jammer_ladder_right","targetname");
	if(var_00.size > 0)
	{
		foreach(var_02 in var_00)
		{
			var_02 maps\_utility::spawn_ai(1);
		}
	}
}

//Function Number: 247
combat_courtyard_jammer_complete()
{
	common_scripts\utility::flag_wait("flag_combat_courtyard_jammer_complete");
	maps\lab_utility::cleanup_ai_with_script_noteworthy("enemy_courtyard_jammer",128);
	wait(2);
	var_00 = getentarray("enemy_courtyard_sniper_fodder","script_noteworthy");
	if(var_00.size > 0)
	{
		foreach(var_02 in var_00)
		{
			var_02 maps\_utility::spawn_ai(1);
		}
	}

	thread courtyard_enemy_sniper_fodder_count();
	level.player.ignoreme = 1;
	maps\_utility::wait_for_notify_or_timeout("flag_courtyard_sniper_sequence_complete",28);
	maps\lab_utility::cleanup_ai_with_script_noteworthy("enemy_courtyard_sniper_fodder",128);
	level.player.ignoreme = 0;
	common_scripts\utility::flag_set("flag_courtyard_sniper_sequence_complete");
	var_00 = getentarray("enemy_courtyard_jammer_complete","targetname");
	if(var_00.size > 0)
	{
		maps\_spawner::flood_spawner_scripted(var_00);
	}

	var_00 = getentarray("enemy_courtyard_jammer_complete_perimeter","targetname");
	maps\_utility::array_spawn_function(var_00,::courtyard_rpg_drop);
	if(var_00.size > 0)
	{
		maps\_spawner::flood_spawner_scripted(var_00);
	}

	wait(5);
	var_04 = getent("enemy_courtyard_mech_02","targetname");
	if(isdefined(var_04))
	{
		var_04 = getent("enemy_courtyard_mech_03","targetname");
	}

	if(isdefined(var_04))
	{
		var_04 = getent("enemy_courtyard_mech_04","targetname");
	}

	if(isdefined(var_04))
	{
		var_04 maps\_utility::spawn_ai(1);
	}
}

//Function Number: 248
cleanup_courtyard_enemies()
{
	common_scripts\utility::flag_wait("flag_obj_tank_02");
	maps\lab_utility::cleanup_ai_with_script_noteworthy("enemy_courtyard_initial",128);
	maps\lab_utility::cleanup_ai_with_script_noteworthy("enemy_hangar_building_01",128);
	maps\lab_utility::cleanup_ai_with_script_noteworthy("enemy_courtyard_jammer",128);
	maps\lab_utility::cleanup_ai_with_script_noteworthy("enemy_courtyard_jammer_complete",128);
	maps\lab_utility::cleanup_ai_with_script_noteworthy("enemy_courtyard_jammer_complete_perimeter",128);
	maps\lab_utility::cleanup_ai_with_script_noteworthy("enemy_courtyard_flood",128);
	maps\lab_utility::cleanup_ai_with_script_noteworthy("enemy_courtyard_sniper_fodder",128);
	if(isdefined(level.hangar_mech_01))
	{
		level.hangar_mech_01 delete();
	}

	if(isdefined(level.courtyard_mech_01))
	{
		level.courtyard_mech_01 delete();
	}

	if(isdefined(level.courtyard_mech_02))
	{
		level.courtyard_mech_02 delete();
	}

	if(isdefined(level.courtyard_mech_03))
	{
		level.courtyard_mech_03 delete();
	}

	if(isdefined(level.courtyard_mech_04))
	{
		level.courtyard_mech_04 delete();
	}

	if(isdefined(level.courtyard_vrap01))
	{
		level.courtyard_vrap01 delete();
	}

	if(isdefined(level.courtyard_vrap02))
	{
		level.courtyard_vrap02 delete();
	}

	if(isdefined(level.courtyard_vrap03))
	{
		level.courtyard_vrap03 delete();
	}

	if(isdefined(level.courtyard_vrap04))
	{
		level.courtyard_vrap04 delete();
	}

	if(isdefined(level.courtyard_vrap05))
	{
		level.courtyard_vrap05 delete();
	}

	maps\_utility::delaythread(0.05,::maps\_utility::array_delete,getentarray("script_vehicle_cover_drone","classname"));
}

//Function Number: 249
vrap_sonic_blast_immunity_toggle()
{
	self endon("death");
	wait(0.5);
	if(isdefined(self.riders))
	{
		var_00 = self.riders;
		foreach(var_02 in var_00)
		{
			if(isalive(var_02) && isai(var_02))
			{
				var_02.ignoresonicaoe = 1;
			}
		}

		wait(0.5);
		while(self.riders.size > 0)
		{
			wait 0.05;
		}

		foreach(var_02 in var_00)
		{
			var_02.ignoresonicaoe = 0;
		}
	}
}

//Function Number: 250
cleanup_foam_corridor_enemies()
{
	maps\lab_utility::cleanup_ai_with_script_noteworthy("enemy_foam_corridor_b",128);
}

//Function Number: 251
skip_foam_corridor()
{
	common_scripts\utility::flag_wait("flag_combat_foam_corridor");
	thread tank_hangar_door_open();
	level.burke maps\_utility::disable_ai_color();
	level.knox maps\_utility::disable_ai_color();
	level.cormack maps\_utility::disable_ai_color();
	var_00 = common_scripts\utility::getstruct("foam_corridor_anim_node","targetname");
	var_01 = "foam_corridor_exit";
	var_02 = [];
	var_02[var_02.size] = level.burke;
	var_02[var_02.size] = level.knox;
	var_02[var_02.size] = level.cormack;
	var_03 = common_scripts\utility::getstruct("hovertank_reveal_org","targetname");
	var_04 = maps\_utility::spawn_anim_model("hovertank",level.hovertank.origin);
	level.hovertank hide();
	thread se_hovertank_reveal_actor(var_04,var_03);
	foreach(var_06 in var_02)
	{
		thread se_hovertank_reveal_actor(var_06,var_03);
	}

	common_scripts\utility::flag_set("flag_foam_corridor_exit");
}

//Function Number: 252
combat_foam_corridor()
{
	common_scripts\utility::flag_wait("flag_combat_foam_corridor");
	createthreatbiasgroup("player");
	createthreatbiasgroup("foam_corridor_axis");
	level.player setthreatbiasgroup("player");
	var_00 = getentarray("enemy_foam_corridor_b","script_noteworthy");
	if(var_00.size > 0)
	{
		foreach(var_02 in var_00)
		{
			var_03 = var_02 maps\_utility::spawn_ai(1);
			var_03.grenadeawareness = 0;
		}
	}

	thread se_foam_corridor();
}

//Function Number: 253
foam_corridor_enemy_think()
{
	self endon("death");
	self setthreatbiasgroup("foam_corridor_axis");
	maps\_utility::magic_bullet_shield(1);
	while(!common_scripts\utility::flag("flag_foam_corridor_exit"))
	{
		common_scripts\utility::flag_wait("flag_player_inside_foam_corridor");
		setthreatbias("foam_corridor_axis","player",9999999);
		self.baseaccuracy = 999999;
		common_scripts\utility::flag_waitopen("flag_player_inside_foam_corridor");
		setthreatbias("foam_corridor_axis","player",1);
		self.baseaccuracy = 1;
	}

	maps\_utility::set_battlechatter(0);
}

//Function Number: 254
combat_tank_courtyard()
{
	common_scripts\utility::flag_wait("player_in_hovertank");
	common_scripts\utility::array_thread(getentarray("gate_1_react_guys","targetname"),::combat_tank_courtyard_gate_1_guys_think);
	maps\_utility::array_spawn_targetname("tank_courtyard_guys_1",1);
	common_scripts\utility::flag_wait("flag_courtyard_gate_01_explode");
	var_00 = maps\_utility::array_spawn_targetname("courtyard_tank_vrap_1",1);
	thread maps\lab_aud::aud_tank_section_vehicles_spawned(var_00);
	common_scripts\utility::flag_wait("flag_courtyard_gate_02_explode");
}

//Function Number: 255
combat_tank_courtyard_gate_1_guys_think()
{
	var_00 = common_scripts\utility::getstruct(self.target,"targetname");
	var_01 = maps\_utility::spawn_ai(1);
	var_01.ignoreall = 1;
	var_02 = common_scripts\utility::getstruct("courtyard_tank_flee_point","targetname");
	var_01.animname = "generic";
	var_01.goalradius = var_02.radius;
	var_01 setgoalpos(var_02.origin);
	var_03 = var_00.animation;
	var_04 = 0;
	var_05 = 0;
	if(isdefined(var_00.script_parameters))
	{
		if(var_00.script_parameters == "scripted_death")
		{
			var_05 = 1;
		}
		else
		{
			var_04 = float(var_00.script_parameters);
		}
	}

	var_00 thread maps\_anim::anim_generic_run(var_01,var_03);
	var_06 = getanimlength(var_01 maps\_utility::getanim(var_03));
	if(var_04 > 0)
	{
		wait(0.05);
		var_07 = var_06 - var_04 / var_06;
		var_01 setanimtime(var_01 maps\_utility::getanim(var_03),var_07);
	}

	if(var_05)
	{
		wait(var_06 - 0.3);
		var_01 startragdoll();
		maps\lab_anim::ai_kill(var_01);
		return;
	}

	if(isdefined(var_01) && isalive(var_01))
	{
		var_01.goalradius = var_02.radius;
		var_01 setgoalpos(var_02.origin);
		thread maps\_utility::ai_delete_when_out_of_sight([var_01],5000);
	}
}

//Function Number: 256
combat_tank_field_flee_guys_think()
{
	self endon("death");
	self.ignoreall = 1;
	var_00 = common_scripts\utility::getstruct("tank_field_flee_point","targetname");
	if(isdefined(self.ridingvehicle))
	{
		self waittill("jumpedout");
	}

	self.goalradius = 256;
	self setgoalpos(var_00.origin);
	thread maps\_utility::ai_delete_when_out_of_sight([self],512);
}

//Function Number: 257
combat_tank_road()
{
}

//Function Number: 258
setup_clip()
{
	var_00 = getent("blocker_vrap_takedown_door","targetname");
	var_00.origin = var_00.origin - (0,0,10000);
	var_00 connectpaths();
	thread takedown_trunk();
	thread foam_room_door_think();
	thread platform_door_think();
}

//Function Number: 259
takedown_trunk()
{
	var_00 = getent("takedown_stump","targetname");
	var_01 = getent("takedown_stump_damaged","targetname");
	var_01 hide();
	if(common_scripts\utility::flag("flag_se_takedown_01_complete"))
	{
		var_00 hide();
		var_01 show();
	}
}

//Function Number: 260
tank_hangar_door_open()
{
	var_00 = getent("tank_hangar_door_l","targetname");
	var_01 = getent("tank_hangar_door_r","targetname");
	var_02 = var_00 common_scripts\utility::get_target_ent();
	var_03 = var_01 common_scripts\utility::get_target_ent();
	var_02 linkto(var_00);
	var_03 linkto(var_01);
	var_04 = common_scripts\utility::getstruct("tank_hanger_door_l_opened","targetname");
	var_05 = common_scripts\utility::getstruct("tank_hanger_door_r_opened","targetname");
	var_06 = 0.75;
	var_00 moveto(var_04.origin,var_06,0.25,0.25);
	var_01 moveto(var_05.origin,var_06,0.25,0.25);
	wait(var_06);
	var_02 connectpaths();
	var_03 connectpaths();
}

//Function Number: 261
tank_hangar_door_close()
{
	var_00 = getent("tank_hangar_door_l","targetname");
	var_01 = getent("tank_hangar_door_r","targetname");
	var_02 = var_00 common_scripts\utility::get_target_ent();
	var_03 = var_01 common_scripts\utility::get_target_ent();
	var_02 linkto(var_00);
	var_03 linkto(var_01);
	var_04 = common_scripts\utility::getstruct("tank_hanger_door_l_opened","targetname");
	var_05 = common_scripts\utility::getstruct("tank_hanger_door_r_opened","targetname");
	var_06 = common_scripts\utility::getstruct("tank_hanger_door_closed","targetname");
	var_07 = 0.75;
	var_00 moveto(var_06.origin,var_07,0.25,0.25);
	var_01 moveto(var_06.origin,var_07,0.25,0.25);
	wait(var_07);
	var_02 disconnectpaths();
	var_03 disconnectpaths();
}

//Function Number: 262
helo_sniper_bullet_impacts()
{
	while(!common_scripts\utility::flag("flag_player_enters_forest"))
	{
		var_00 = 3;
		var_01 = 6;
		if(common_scripts\utility::flag("flag_increase_sinper_shots_01"))
		{
			var_00 = 2;
			var_01 = 4;
		}

		if(common_scripts\utility::flag("flag_hill_slide_complete"))
		{
			var_00 = 1;
			var_01 = 3;
		}

		wait(randomfloatrange(var_00,var_01));
		var_02 = vectornormalize(anglestoforward(level.player.angles));
		var_03 = vectornormalize(anglestoright(level.player.angles));
		var_04 = spawn("script_origin",(0,0,0));
		var_02 = var_02 * randomintrange(128,512);
		var_03 = var_03 * randomintrange(-96,96);
		var_05 = randomint(360);
		var_04.angles = (0,var_05,0);
		var_06 = get_helo_spotlight_bullet_origin();
		var_07 = 0;
		var_08 = level.player.origin + var_02 + var_03;
		var_09 = randomintrange(64,256);
		var_0A = randomintrange(1,2);
		var_0B = var_08 + vectornormalize(anglestoforward(var_04.angles)) * var_09;
		var_0C = var_0B - var_08;
		var_0D = var_0A * 0.05;
		while(var_07 < var_0D)
		{
			var_0E = randomfloat(1);
			if(var_0E < 0.8)
			{
				var_04.origin = var_08 + var_0C * var_07 / var_0D;
				var_0F = randomintrange(-40,40);
				var_10 = randomintrange(-40,40);
				var_11 = randomintrange(-5,5);
				var_04.origin = var_04.origin + (var_0F,var_10,var_11);
				if(!maps\_utility::shot_endangers_any_player(var_06,var_04.origin))
				{
					helo_spotlight_shoot_location(var_04.origin);
				}
			}

			var_07 = var_07 + 0.05;
			wait(0.05);
		}

		var_04 delete();
	}
}

//Function Number: 263
helo_sniper_threaten_player()
{
	level notify("player_run_progress_trigger_hit");
	level endon("player_run_progress_trigger_hit");
	var_00 = randomfloatrange(5,8);
	var_01 = 2;
	var_02 = 4;
	wait(var_00);
	while(!common_scripts\utility::flag("flag_player_enters_forest"))
	{
		helo_spotlight_shoot_location(level.player geteye() + (randomintrange(-10,10),randomintrange(-10,10),randomintrange(-10,10)));
		wait(randomfloatrange(var_01,var_02));
	}
}

//Function Number: 264
player_run_progress_trigger_think()
{
	level endon("flag_player_enters_forest");
	self waittill("trigger");
	helo_sniper_threaten_player();
}

//Function Number: 265
get_helo_spotlight_bullet_origin(param_00)
{
	if(!isdefined(param_00))
	{
		return level.helo_spotlight gettagorigin("tag_guy1") + (0,0,28);
	}

	var_01 = 88;
	var_02 = level.helo_spotlight gettagorigin("tag_deathfx");
	var_02 = var_02 + vectornormalize(param_00 - var_02) * var_01;
	return var_02;
}

//Function Number: 266
river_slow_movement_ai_think()
{
	level endon("player_climbing_wall");
	for(;;)
	{
		common_scripts\utility::flag_wait("flag_player_in_river");
		if(isplayer(self))
		{
			self setmovespeedscale(0.4);
			self allowjump(0);
			self takeweapon("iw5_unarmed_nullattach");
			self giveweapon("s1_unarmed_water");
			self switchtoweapon("s1_unarmed_water");
			self allowcrouch(0);
			self allowprone(0);
			if(!isdefined(level.rumble_ent))
			{
				level.rumble_ent = maps\_utility::get_rumble_ent("steady_rumble");
			}

			level.rumble_ent.intensity = 0.08;
		}

		common_scripts\utility::flag_waitopen("flag_player_in_river");
		if(isplayer(self))
		{
			self setmovespeedscale(0.8);
			self allowjump(1);
			self takeweapon("s1_unarmed_water");
			self giveweapon("iw5_unarmed_nullattach");
			self switchtoweapon("iw5_unarmed_nullattach");
			self allowsprint(1);
			self allowcrouch(1);
			self allowprone(1);
			if(isdefined(level.rumble_ent))
			{
				level.rumble_ent delete();
				level.rumble_ent = undefined;
				stopallrumbles();
			}
		}
	}
}

//Function Number: 267
lerp_move_speed_scale(param_00,param_01,param_02)
{
	self notify("lerp_move_speed_scale");
	self endon("lerp_move_speed_scale");
	var_03 = gettime() * 0.001;
	for(;;)
	{
		var_04 = gettime() * 0.001 - var_03;
		if(var_04 >= param_02)
		{
			break;
		}

		self setmovespeedscale(maps\_utility::linear_interpolate(var_04 / param_02,param_00,param_01));
		wait 0.05;
	}

	self setmovespeedscale(param_01);
}

//Function Number: 268
open_hangar_doors()
{
	common_scripts\utility::flag_wait("player_in_hovertank");
	var_00 = getent("tank_hangar_garage_door_clip","targetname");
	var_00 delete();
	var_01 = getent("tank_hangar_garage_door","targetname");
	var_01.animname = "tank_hangar_garage_door";
	var_01 maps\_utility::assign_animtree();
	var_01 maps\_anim::anim_single_solo(var_01,"lab_tank_hanger_door_open");
}

//Function Number: 269
courtyard_gate_think(param_00)
{
	var_01 = getentarray("courtyard_perimeter_gate_instance_0" + param_00,"script_noteworthy");
	var_02 = undefined;
	foreach(var_04 in var_01)
	{
		if(var_04.classname == "script_model")
		{
			var_02 = var_04;
			break;
		}
	}

	var_06 = spawnstruct();
	var_06.origin = var_02.origin;
	if(isdefined(var_02.angles))
	{
		var_06.angles = var_02.angles;
	}

	var_02.animname = "perimeter_gate";
	var_02 maps\_utility::assign_animtree();
	var_07 = getent(var_02.target,"targetname");
	var_08 = getent(var_07.target,"targetname");
	var_07 disconnectpaths();
	var_08 connectpaths();
	var_08 notsolid();
	common_scripts\utility::flag_wait("player_in_hovertank");
	var_02 maps\_anim::anim_first_frame_solo(var_02,"opened");
	var_08 disconnectpaths();
	var_08 solid();
	var_07 connectpaths();
	var_07 delete();
	maps\_utility::deletestruct_ref(var_06);
}

//Function Number: 270
courtyard_gate_take_damage(param_00)
{
	common_scripts\utility::flag_wait("player_in_hovertank");
	var_01 = "flag_courtyard_gate_0" + param_00 + "_explode";
	level endon(var_01);
	self setcandamage(1);
	var_02 = 500;
	var_03 = 1000;
	self.health = var_02 + var_03;
	for(;;)
	{
		self waittill("damage",var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D);
		if(var_05 != level.player)
		{
			self.health = self.health + var_04;
			continue;
		}

		if(self.health <= var_03)
		{
			common_scripts\utility::flag_set(var_01);
		}
	}
}

//Function Number: 271
setup_triggers()
{
	var_00 = getentarray("trigs_tank_combat","targetname");
	foreach(var_02 in var_00)
	{
		var_02 common_scripts\utility::trigger_off();
	}

	common_scripts\utility::flag_wait("flag_obj_tank_complete");
	foreach(var_02 in var_00)
	{
		var_02 common_scripts\utility::trigger_on();
	}
}

//Function Number: 272
research_building_enemy_think()
{
	self endon("death");
	self setgoalvolumeauto(getent("info_v_combat_research_01","targetname"));
	common_scripts\utility::flag_wait("flag_combat_research_02");
	self cleargoalvolume();
	self setgoalvolumeauto(getent("info_v_combat_pool_room_01","targetname"));
	common_scripts\utility::flag_wait("flag_combat_research_03");
	while(!common_scripts\utility::flag("flag_player_inside_foam_room"))
	{
		common_scripts\utility::flag_wait_any("flag_combat_research_04","flag_combat_research_04_bottom");
		if(common_scripts\utility::flag("flag_combat_research_04"))
		{
			self cleargoalvolume();
			self setgoalvolumeauto(getent("info_v_combat_pool_room_03","targetname"));
			continue;
		}

		if(common_scripts\utility::flag("flag_combat_research_04_bottom"))
		{
			self cleargoalvolume();
			self setgoalvolumeauto(getent("info_v_combat_pool_room_bottom","targetname"));
		}

		wait 0.05;
	}

	self cleargoalvolume();
	maps\_utility::player_seek();
}

//Function Number: 273
facility_bridge_enemy_think()
{
	self endon("death");
	self setgoalvolumeauto(getent("info_v_combat_facility_bridge_01","targetname"));
	common_scripts\utility::flag_wait("flag_combat_facility_bridge_seek_player");
	self cleargoalvolume();
	maps\_utility::player_seek();
}

//Function Number: 274
pool_building_walkway_01_enemy_think()
{
	self endon("death");
	self setgoalvolumeauto(getent("info_v_combat_pool_room_walkway_02","targetname"));
	common_scripts\utility::flag_wait("flag_guys_pool_bldg_01_seek_player");
	self cleargoalvolume();
	maps\_utility::player_seek();
}

//Function Number: 275
research_right_01_enemy_think()
{
	self endon("death");
	self setgoalvolumeauto(getent("info_v_combat_pool_room_walkway_03","targetname"));
	common_scripts\utility::flag_wait("flag_guys_research_right_01_seek_player");
	self cleargoalvolume();
	maps\_utility::player_seek();
}

//Function Number: 276
research_left_01_enemy_think()
{
	self endon("death");
	if(randomint(2) == 0)
	{
		self setgoalvolumeauto(getent("info_v_combat_pool_room_walkway_04","targetname"));
	}
	else
	{
		self setgoalvolumeauto(getent("info_v_combat_pool_room_walkway_05","targetname"));
	}

	common_scripts\utility::flag_wait("flag_guys_research_left_01_seek_player");
	self cleargoalvolume();
	maps\_utility::player_seek();
}

//Function Number: 277
research_left_lower_01_enemy_think()
{
	self endon("death");
	self cleargoalvolume();
	self setgoalvolumeauto(getent("info_v_combat_pool_room_platform","targetname"));
	while(!common_scripts\utility::flag("flag_player_inside_foam_room"))
	{
		common_scripts\utility::flag_wait_any("flag_combat_research_04","flag_combat_research_04_bottom");
		if(common_scripts\utility::flag("flag_combat_research_04"))
		{
			self cleargoalvolume();
			self setgoalvolumeauto(getent("info_v_combat_pool_room_03","targetname"));
			continue;
		}

		if(common_scripts\utility::flag("flag_combat_research_04_bottom"))
		{
			self cleargoalvolume();
			self setgoalvolumeauto(getent("info_v_combat_pool_room_bottom","targetname"));
		}

		wait 0.05;
	}

	self cleargoalvolume();
	maps\_utility::player_seek();
}

//Function Number: 278
research_right_lower_01_enemy_think()
{
	self endon("death");
	self setgoalvolumeauto(getent("info_v_combat_pool_room_bottom_03","targetname"));
	while(!common_scripts\utility::flag("flag_player_inside_foam_room"))
	{
		common_scripts\utility::flag_wait_any("flag_combat_research_04","flag_combat_research_04_bottom");
		if(common_scripts\utility::flag("flag_combat_research_04"))
		{
			self cleargoalvolume();
			self setgoalvolumeauto(getent("info_v_combat_pool_room_03","targetname"));
			continue;
		}

		if(common_scripts\utility::flag("flag_combat_research_04_bottom"))
		{
			self cleargoalvolume();
			self setgoalvolumeauto(getent("info_v_combat_pool_room_bottom","targetname"));
		}

		wait 0.05;
	}

	self cleargoalvolume();
	maps\_utility::player_seek();
}

//Function Number: 279
research_platform_enemy_think()
{
	self endon("death");
	self setgoalvolumeauto(getent("info_v_combat_pool_room_platform","targetname"));
	common_scripts\utility::flag_wait("flag_combat_research_05");
	common_scripts\utility::flag_wait("flag_foam_room_combat_clear_out");
	self cleargoalvolume();
	maps\_utility::player_seek();
}

//Function Number: 280
pool_building_enemy_think()
{
	self endon("death");
	self cleargoalvolume();
	self setgoalvolumeauto(getent("info_v_combat_pool_room_03","targetname"));
	while(!common_scripts\utility::flag("flag_player_inside_foam_room"))
	{
		common_scripts\utility::flag_wait_any("flag_combat_research_04","flag_combat_research_04_bottom");
		if(common_scripts\utility::flag("flag_combat_research_04"))
		{
			self cleargoalvolume();
			self setgoalvolumeauto(getent("info_v_combat_pool_room_03","targetname"));
			continue;
		}

		if(common_scripts\utility::flag("flag_combat_research_04_bottom"))
		{
			self cleargoalvolume();
			self setgoalvolumeauto(getent("info_v_combat_pool_room_bottom","targetname"));
		}

		wait 0.05;
	}

	self cleargoalvolume();
	maps\_utility::player_seek();
}

//Function Number: 281
courtyard_goal_volume_trigger_think()
{
	var_00 = common_scripts\utility::get_target_ent();
	level endon("flag_obj_courtyard_jammer_start");
	for(;;)
	{
		self waittill("trigger");
		if(var_00 != level.courtyard_goal_volume)
		{
			level.courtyard_goal_volume = var_00;
			level notify("courtyard_enemy_update_goal");
		}

		wait(0.5);
	}
}

//Function Number: 282
courtyard_goal_volume_trigger_b_think()
{
	var_00 = common_scripts\utility::get_target_ent();
	level endon("flag_obj_tank_02");
	for(;;)
	{
		self waittill("trigger");
		if(var_00 != level.courtyard_goal_volume)
		{
			level.courtyard_goal_volume = var_00;
			level notify("courtyard_enemy_update_goal");
		}

		wait(0.5);
	}
}

//Function Number: 283
combat_courtyard_general_01_think()
{
	self endon("death");
	common_scripts\utility::flag_wait_any("flag_combat_courtyard_path_left_01","flag_combat_courtyard_path_left_02","flag_combat_courtyard_path_right_02");
	maps\_utility::ai_delete_when_out_of_sight([self],512);
}

//Function Number: 284
combat_courtyard_path_left_00_think()
{
	self endon("death");
	common_scripts\utility::flag_wait_any("flag_combat_courtyard_path_middle_02","flag_combat_courtyard_path_right_01");
	maps\_utility::ai_delete_when_out_of_sight([self],640);
}

//Function Number: 285
combat_courtyard_path_left_01_think()
{
	self endon("death");
	common_scripts\utility::flag_wait_any("flag_combat_courtyard_path_middle_01","flag_combat_courtyard_path_middle_02","flag_combat_courtyard_path_right_01","flag_combat_courtyard_path_right_01");
	maps\_utility::ai_delete_when_out_of_sight([self],640);
}

//Function Number: 286
combat_courtyard_path_left_02_think()
{
	self endon("death");
	common_scripts\utility::flag_wait_any("flag_combat_courtyard_path_middle_02","flag_combat_courtyard_path_middle_03","flag_combat_courtyard_path_right_02","flag_combat_courtyard_path_right_02");
	maps\_utility::ai_delete_when_out_of_sight([self],640);
}

//Function Number: 287
combat_courtyard_path_left_03_think()
{
	self endon("death");
	common_scripts\utility::flag_wait_any("flag_combat_courtyard_path_middle_03","flag_combat_courtyard_path_right_03");
	maps\_utility::ai_delete_when_out_of_sight([self],640);
}

//Function Number: 288
combat_courtyard_path_middle_01_think()
{
	self endon("death");
	maps\lab_utility::equip_microwave_grenade();
	common_scripts\utility::flag_wait_any("flag_combat_courtyard_path_left_01","flag_combat_courtyard_path_right_01","flag_combat_courtyard_path_right_02");
	maps\_utility::ai_delete_when_out_of_sight([self],640);
}

//Function Number: 289
combat_courtyard_path_middle_02_think()
{
	self endon("death");
	maps\lab_utility::equip_microwave_grenade();
	common_scripts\utility::flag_wait_any("flag_combat_courtyard_path_left_01","flag_combat_courtyard_path_left_02","flag_combat_courtyard_path_right_01","flag_combat_courtyard_path_right_02");
	maps\_utility::ai_delete_when_out_of_sight([self],640);
}

//Function Number: 290
combat_courtyard_path_middle_03_think()
{
	self endon("death");
	maps\lab_utility::equip_microwave_grenade();
	common_scripts\utility::flag_wait_any("flag_combat_courtyard_path_left_02","flag_combat_courtyard_path_left_03","flag_combat_courtyard_path_right_02","flag_combat_courtyard_path_right_02");
	maps\_utility::ai_delete_when_out_of_sight([self],640);
}

//Function Number: 291
combat_courtyard_path_right_01_think()
{
	self endon("death");
	maps\lab_utility::equip_microwave_grenade();
	common_scripts\utility::flag_wait_any("flag_combat_courtyard_path_left_00","flag_combat_courtyard_path_left_01","flag_combat_courtyard_path_middle_02");
	maps\_utility::ai_delete_when_out_of_sight([self],640);
}

//Function Number: 292
combat_courtyard_path_right_02_think()
{
	self endon("death");
	maps\lab_utility::equip_microwave_grenade();
	common_scripts\utility::flag_wait_any("flag_combat_courtyard_path_left_01","flag_combat_courtyard_path_left_02","flag_combat_courtyard_path_middle_02","flag_combat_courtyard_path_middle_03");
	maps\_utility::ai_delete_when_out_of_sight([self],640);
}

//Function Number: 293
combat_courtyard_path_right_03_think()
{
	self endon("death");
	maps\lab_utility::equip_microwave_grenade();
	common_scripts\utility::flag_wait_any("flag_combat_courtyard_path_left_02","flag_combat_courtyard_path_left_03","flag_combat_courtyard_path_middle_02","flag_combat_courtyard_path_middle_02");
	maps\_utility::ai_delete_when_out_of_sight([self],640);
}

//Function Number: 294
courtyard_enemy_initial_think()
{
	self endon("death");
	self.fixednode = 1;
	wait(randomfloatrange(30,40));
	self.fixednode = 0;
	while(!isdefined(level.courtyard_goal_volume))
	{
		wait(1);
	}

	for(;;)
	{
		level waittill("courtyard_enemy_update_goal");
		self setgoalvolumeauto(level.courtyard_goal_volume);
		wait(1);
	}
}

//Function Number: 295
courtyard_enemy_think()
{
	self endon("death");
	while(!isdefined(level.courtyard_goal_volume))
	{
		wait(1);
	}

	for(;;)
	{
		level waittill("courtyard_enemy_update_goal");
		self setgoalvolumeauto(level.courtyard_goal_volume);
		wait(1);
	}
}

//Function Number: 296
courtyard_jammer_ladder_enemy_think()
{
	self endon("death");
	wait(randomfloatrange(20,25));
	while(!isdefined(level.courtyard_goal_volume))
	{
		wait(1);
	}

	for(;;)
	{
		level waittill("courtyard_enemy_update_goal");
		self setgoalvolumeauto(level.courtyard_goal_volume);
		wait(1);
	}
}

//Function Number: 297
courtyard_enemy_sniper_fodder_think()
{
	self endon("death");
	maps\_utility::add_damage_function(::courtyard_enemy_sniper_fodder_damage_function);
	thread courtyard_enemy_sniper_fodder_track();
	self.fixednode = 1;
	common_scripts\utility::flag_wait("flag_courtyard_sniper_sequence_complete");
	maps\_utility::remove_damage_function(::courtyard_enemy_sniper_fodder_damage_function);
	self.fixednode = 0;
	while(!isdefined(level.courtyard_goal_volume))
	{
		wait(1);
	}

	for(;;)
	{
		level waittill("courtyard_enemy_update_goal");
		self setgoalvolumeauto(level.courtyard_goal_volume);
		wait(1);
	}
}

//Function Number: 298
courtyard_enemy_sniper_fodder_track()
{
	level endon("flag_courtyard_sniper_sequence_complete");
	self waittill("death",var_00);
	if(var_00 == level.player)
	{
		level notify("courtyard_enemy_sniped");
	}
}

//Function Number: 299
courtyard_enemy_sniper_fodder_count()
{
	level endon("flag_courtyard_sniper_sequence_complete");
	level waittill("courtyard_enemy_sniped");
	level waittill("courtyard_enemy_sniped");
	level waittill("courtyard_enemy_sniped");
	level waittill("courtyard_enemy_sniped");
	common_scripts\utility::flag_set("flag_courtyard_sniper_sequence_complete");
}

//Function Number: 300
courtyard_enemy_sniper_fodder_damage_function(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(param_01 == level.burke || param_01 == level.cormack)
	{
		if(self.health > 0)
		{
			self.health = self.health + param_00;
		}
	}
}

//Function Number: 301
courtyard_doormen_enemy_think()
{
	self endon("death");
	level waittill("remove_doormen");
	self delete();
}

//Function Number: 302
courtyard_burke_defend_squad()
{
	var_00 = getnode("burke_defend_exterior","script_noteworthy");
	level.burke maps\_utility::disable_ai_color();
	level.burke.ignoreme = 1;
	level.burke.ignoreall = 1;
	level.burke.ignoresuppression = 1;
	level.burke.goalradius = 32;
	level.burke setgoalnode(var_00);
	level.burke waittill("goal");
	level.burke.ignoreme = 0;
	level.burke.ignoreall = 0;
	level.burke.ignoresuppression = 0;
}

//Function Number: 303
courtyard_hangar_door_hack()
{
	common_scripts\utility::flag_wait("flag_courtyard_hangar_door_hack");
	maps\lab_utility::disable_all_fixed_scanners();
	var_00 = getent("bad_place_courtyard_stairs","targetname");
	badplace_brush("courtyard_stairs",-1,var_00,"axis");
	var_01 = getnode("burke_escort_exterior","script_noteworthy");
	var_02 = getnode("cormack_defend_exterior","script_noteworthy");
	level.knox.ignoreme = 1;
	thread se_knox_courtyard_hangar_door_hack_open();
	level.burke setgoalnode(var_01);
	level.cormack setgoalnode(var_02);
	thread courtyard_traversal_jammer();
	var_03 = getent("bad_place_courtyard_roof","targetname");
	badplace_brush("courtyard_roof",-1,var_03,"axis");
	common_scripts\utility::flag_wait("flag_obj_jammer_complete");
	soundscripts\_snd::snd_message("aud_post_courtyard_emitters");
	thread courtyard_traversal_hangar();
	common_scripts\utility::flag_wait("flag_courtyard_sniper_sequence_complete");
	badplace_delete("courtyard_roof");
	thread courtyard_burke_defend_squad();
	common_scripts\utility::flag_set("flag_courtyard_hangar_door_hack_success");
	thread courtyard_hangar_door_open();
	var_04 = getent("trig_dmg_player_hangar","targetname");
	var_04 common_scripts\utility::trigger_off();
	thread courtyard_burke_enter_hangar_logic();
	thread courtyard_cormack_enter_hangar_logic();
	level.knox.ignoreme = 0;
	common_scripts\utility::array_thread(getentarray("courtyard_traversal_forward01","script_noteworthy"),::common_scripts\utility::trigger_off);
	common_scripts\utility::array_thread(getentarray("courtyard_traversal_backward01","script_noteworthy"),::common_scripts\utility::trigger_off);
	common_scripts\utility::array_thread(getentarray("courtyard_traversal_forward02","script_noteworthy"),::common_scripts\utility::trigger_off);
	var_05 = getnode("knox_defend_interior_02","script_noteworthy");
	var_06 = getnode("cormack_defend_interior_02","script_noteworthy");
	var_07 = getnode("knox_hack_interior","script_noteworthy");
	level.burke.goalradius = 32;
	level.cormack.goalradius = 32;
	level.knox.goalradius = 32;
	level.burke setgoalnode(var_05);
	level.cormack setgoalnode(var_06);
	level.knox setgoalnode(var_07);
	level.burke.ignoreall = 1;
	level.burke.ignoresuppression = 1;
	level.cormack.ignoreall = 1;
	level.cormack.ignoresuppression = 1;
	level.burke maps\_utility::enable_ai_color_dontmove();
	level.cormack maps\_utility::enable_ai_color_dontmove();
	level.knox maps\_utility::enable_ai_color_dontmove();
	common_scripts\utility::flag_wait("flag_obj_tank_02");
	badplace_delete("courtyard_stairs");
}

//Function Number: 304
courtyard_hangar_door_logic()
{
	var_00 = getent("hangar_interior_volume","targetname");
	while(!common_scripts\utility::flag("hangar_door_closing"))
	{
		common_scripts\utility::flag_wait("flag_player_inside_hangar");
		if(level.burke istouching(var_00) && level.knox istouching(var_00) && level.cormack istouching(var_00))
		{
			var_01 = getent("bad_place_courtyard_exit_platform","targetname");
			badplace_brush("courtyard_exit_platform",-1,var_01,"allies");
			common_scripts\utility::flag_set("hangar_door_closing");
			var_02 = common_scripts\utility::getstruct("knox_courtyard_hangar_door_hack_close_org","targetname");
			var_02.origin = level.knox.origin;
			var_02.angles = level.knox.angles;
			common_scripts\utility::flag_set("flag_obj_tank_02");
			thread courtyard_hangar_door_close();
			var_03 = common_scripts\utility::getstruct("org_courtyard_rpg_02","targetname");
			var_04 = undefined;
			switch(randomintrange(0,3))
			{
				case 0:
					var_04 = common_scripts\utility::getstruct("dest_courtyard_rpg_02_a","targetname");
					break;

				case 1:
					var_04 = common_scripts\utility::getstruct("dest_courtyard_rpg_02_b","targetname");
					break;

				case 2:
					var_04 = common_scripts\utility::getstruct("dest_courtyard_rpg_02_c","targetname");
					break;
			}

			var_05 = magicbullet("rpg_straight",var_03.origin,var_04.origin);
			var_06 = 0.6;
			var_05 soundscripts\_snd::snd_message("courtyard_hangar_door_close_rpg",var_04.origin,var_06);
			wait(var_06);
			var_07 = distance(level.player.origin,var_04.origin);
			if(var_07 < 200)
			{
				thread maps\lab_utility::rumble_heavy_1();
			}
			else if(var_07 < 500)
			{
				thread maps\lab_utility::rumble_heavy();
			}

			var_05 delete();
			badplace_delete("courtyard_exit_platform");
			var_08 = getent("courtyard_hangar_door_l","targetname");
			var_08 playsound("detpack_explo_metal");
			earthquake(0.5,0.5,var_08.origin,3000);
			level.player playrumbleonentity("damage_heavy");
			continue;
		}

		wait(0.1);
	}

	var_09 = getent("courtyard_door_clip","targetname");
	var_09 solid();
	var_09 disconnectpaths();
	thread maps\_utility::autosave_by_name("courtyard_exited");
}

//Function Number: 305
courtyard_glowing_ladders()
{
	common_scripts\utility::flag_wait("flag_obj_courtyard_jammer_start");
	var_00 = getent("jammer_ladder_interior","targetname");
	var_01 = getent("jammer_ladder_exterior","targetname");
	var_00 setmodel("safety_ladder_196_obj");
	var_01 setmodel("safety_ladder_196_obj");
	common_scripts\utility::flag_wait_either("flag_courtyard_ladder_touching","flag_obj_jammer_complete");
	var_00 setmodel("safety_ladder_196");
	var_01 setmodel("safety_ladder_196");
}

//Function Number: 306
courtyard_jammer_scene()
{
	common_scripts\utility::flag_wait("flag_obj_courtyard_jammer_start");
	thread courtyard_glowing_ladders();
	common_scripts\utility::flag_set("aud_start_jammer");
	var_00 = common_scripts\utility::getstruct("org_jammer_1","targetname");
	var_01 = "jammerplant_1";
	var_02 = maps\_utility::spawn_anim_model("jammer");
	var_00 thread maps\_anim::anim_single_solo(var_02,var_01);
	maps\_utility::delaythread(0.05,::maps\_anim::anim_set_time,[var_02],var_01,1);
	maps\_anim::anim_set_rate_single(var_02,var_01,0);
	var_02 setmodel("vm_jamming_device_obj");
	common_scripts\utility::flag_wait("flag_obj_jammer_interact");
	common_scripts\utility::flag_set("flag_combat_courtyard_jammer_complete");
	thread maps\lab_lighting::courtyard_jammer_plant_dof();
	soundscripts\_snd::snd_message("courtyard_end_jammer");
	level.player enableinvulnerability();
	var_03 = maps\_utility::spawn_anim_model("player_rig_intro");
	var_03 hide();
	maps\_utility::delaythread(1.15,::player_jammer_movie);
	var_00 maps\_anim::anim_first_frame_solo(var_03,var_01);
	level.player maps\_shg_utility::setup_player_for_scene(1);
	maps\_player_exo::player_exo_deactivate();
	var_02 common_scripts\utility::delaycall(0.9,::delete);
	var_04 = maps\_utility::spawn_anim_model("jammer");
	var_05 = [var_03,var_04];
	level.player playerlinktoblend(var_03,"tag_player",0.4);
	var_04 setmodel("vm_jamming_device");
	wait(0.5);
	var_03 show();
	thread courtyard_jammer_rumbles();
	var_00 maps\_anim::anim_single(var_05,var_01);
	level.player disableinvulnerability();
	level notify("reset_jammer_plant_dof");
	level.player maps\_shg_utility::setup_player_for_gameplay();
	maps\_player_exo::player_exo_activate();
	var_03 delete();
	level.player unlink();
	common_scripts\utility::flag_set("flag_obj_jammer_complete");
}

//Function Number: 307
courtyard_jammer_rumbles()
{
	maps\lab_utility::setup_level_rumble_ent();
	wait(0.5);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.2,0.2);
	wait(0.5);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.2,0.3);
	wait(0.5);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.5,0.2);
}

//Function Number: 308
player_jammer_movie()
{
	setsaveddvar("cg_cinematicfullscreen","0");
	cinematicingame("jammer_ui_loop");
	thread stop_jammer_movie();
}

//Function Number: 309
stop_jammer_movie()
{
	level waittill("flag_obj_tank_02");
	stopcinematicingame();
}

//Function Number: 310
courtyard_burke_enter_hangar_logic()
{
	var_00 = getent("hangar_interior_volume","targetname");
	common_scripts\utility::flag_wait("flag_player_inside_hangar");
	level.burke.ignoreall = 1;
	level.burke.ignoresuppression = 1;
	while(!level.burke istouching(var_00))
	{
		wait(0.1);
	}

	level.burke.ignoreall = 0;
	level.burke.ignoresuppression = 0;
}

//Function Number: 311
courtyard_cormack_enter_hangar_logic()
{
	var_00 = getent("hangar_interior_volume","targetname");
	common_scripts\utility::flag_wait("flag_player_inside_hangar");
	level.cormack.ignoreall = 1;
	level.cormack.ignoresuppression = 1;
	while(!level.burke istouching(var_00))
	{
		wait(0.1);
	}

	level.cormack.ignoreall = 0;
	level.cormack.ignoresuppression = 0;
}

//Function Number: 312
courtyard_hangar_door_open()
{
	var_00 = getent("courtyard_hangar_door_l","targetname");
	var_01 = getent("courtyard_hangar_door_r","targetname");
	var_02 = var_00 common_scripts\utility::get_target_ent();
	var_03 = var_01 common_scripts\utility::get_target_ent();
	var_02 linkto(var_00);
	var_03 linkto(var_01);
	var_04 = common_scripts\utility::getstruct("courtyard_hanger_door_l_opened","targetname");
	var_05 = common_scripts\utility::getstruct("courtyard_hanger_door_r_opened","targetname");
	var_06 = 0.75;
	var_00 moveto(var_04.origin,var_06,0.25,0.25);
	var_01 moveto(var_05.origin,var_06,0.25,0.25);
	wait(var_06);
	var_02 connectpaths();
	var_03 connectpaths();
}

//Function Number: 313
courtyard_hangar_door_close()
{
	soundscripts\_snd::snd_message("aud_courtyard_hangar_door_close");
	var_00 = getent("courtyard_hangar_door_l","targetname");
	var_01 = getent("courtyard_hangar_door_r","targetname");
	var_02 = var_00 common_scripts\utility::get_target_ent();
	var_03 = var_01 common_scripts\utility::get_target_ent();
	var_02 linkto(var_00);
	var_03 linkto(var_01);
	var_04 = common_scripts\utility::getstruct("courtyard_hanger_door_closed","targetname");
	var_05 = 0.5;
	var_00 moveto(var_04.origin,var_05,0.25,0.25);
	var_01 moveto(var_04.origin,var_05,0.25,0.25);
	wait(var_05);
	var_02 disconnectpaths();
	var_03 disconnectpaths();
}

//Function Number: 314
courtyard_intro_magic_bullets()
{
	var_00 = common_scripts\utility::getstruct("org_courtyard_magicbullet_01","targetname");
	var_01 = common_scripts\utility::getstruct("org_courtyard_magicbullet_02","targetname");
	var_02 = common_scripts\utility::getstruct("org_courtyard_magicbullet_03","targetname");
	var_03 = common_scripts\utility::getstruct("dest_courtyard_magicbullet_01","targetname");
	var_04 = common_scripts\utility::getstruct("dest_courtyard_magicbullet_02","targetname");
	var_05 = common_scripts\utility::getstruct("dest_courtyard_magicbullet_03","targetname");
	common_scripts\utility::flag_wait("courtyard_intro_magic_bullets");
	magicbullet("iw5_bal27_sp",var_00.origin,var_03.origin);
	wait(0.2);
	for(var_06 = 0;var_06 < 5;var_06++)
	{
		magicbullet("iw5_bal27_sp",var_01.origin,var_04.origin);
		wait(0.1);
	}

	wait(0.2);
	for(var_06 = 0;var_06 < 4;var_06++)
	{
		magicbullet("iw5_bal27_sp",var_02.origin,var_05.origin);
		wait(0.1);
	}
}

//Function Number: 315
courtyard_traversal_initial()
{
	var_00 = getent("courtyard_door_clip","targetname");
	var_00 notsolid();
	var_00 connectpaths();
	common_scripts\utility::array_thread(getentarray("courtyard_traversal_forward01","script_noteworthy"),::common_scripts\utility::trigger_on);
	common_scripts\utility::array_thread(getentarray("courtyard_traversal_backward01","script_noteworthy"),::common_scripts\utility::trigger_off);
	common_scripts\utility::array_thread(getentarray("courtyard_traversal_forward02","script_noteworthy"),::common_scripts\utility::trigger_off);
}

//Function Number: 316
courtyard_traversal_jammer()
{
	var_00 = getent("courtyard_door_clip","targetname");
	var_00 solid();
	var_00 disconnectpaths();
	common_scripts\utility::array_thread(getentarray("courtyard_traversal_forward01","script_noteworthy"),::common_scripts\utility::trigger_off);
	common_scripts\utility::array_thread(getentarray("courtyard_traversal_backward01","script_noteworthy"),::common_scripts\utility::trigger_on);
	common_scripts\utility::array_thread(getentarray("courtyard_traversal_forward02","script_noteworthy"),::common_scripts\utility::trigger_off);
}

//Function Number: 317
courtyard_traversal_hangar()
{
	var_00 = getent("courtyard_door_clip","targetname");
	var_00 notsolid();
	var_00 connectpaths();
	common_scripts\utility::array_thread(getentarray("courtyard_traversal_forward01","script_noteworthy"),::common_scripts\utility::trigger_off);
	common_scripts\utility::array_thread(getentarray("courtyard_traversal_backward01","script_noteworthy"),::common_scripts\utility::trigger_off);
	common_scripts\utility::array_thread(getentarray("courtyard_traversal_forward02","script_noteworthy"),::common_scripts\utility::trigger_on);
}

//Function Number: 318
courtyard_traversal_tank()
{
	common_scripts\utility::array_thread(getentarray("courtyard_traversal_forward01","script_noteworthy"),::common_scripts\utility::trigger_off);
	common_scripts\utility::array_thread(getentarray("courtyard_traversal_backward01","script_noteworthy"),::common_scripts\utility::trigger_off);
	common_scripts\utility::array_thread(getentarray("courtyard_traversal_forward02","script_noteworthy"),::common_scripts\utility::trigger_off);
}

//Function Number: 319
se_hovertank_reveal()
{
	var_00 = common_scripts\utility::getstruct("hovertank_reveal_org","targetname");
	common_scripts\utility::flag_wait("flag_foam_corridor_exit");
	for(var_01 = 1;var_01 <= 4;var_01++)
	{
		getent("lab_tank_lift_0" + var_01,"script_noteworthy") thread se_hovertank_reveal_lift_think(var_01);
	}

	common_scripts\utility::flag_set("flag_obj_tank_04");
	common_scripts\utility::flag_wait("flag_hovertank_reveal_scene");
	common_scripts\utility::flag_set("flag_obj_tank_05");
	common_scripts\utility::flag_wait("flag_hovertank_reveal_scene_started");
	maps\_utility::autosave_by_name();
	common_scripts\utility::flag_set("flag_tank_hangar_reveal_dialogue");
	soundscripts\_snd::snd_message("hover_tank_startup_sequence");
	thread maps\lab_lighting::stair_wait();
	maps\_utility::delaythread(37,::allow_player_hovertank_mount,var_00);
}

//Function Number: 320
se_hovertank_reveal_actor(param_00,param_01)
{
	var_02 = "hovertank_reveal_approach";
	var_03 = "hovertank_reveal_loop";
	var_04 = "hovertank_reveal";
	var_05 = "hovertank_reveal_loop_ender";
	var_06 = "hovertank_static_ender";
	var_07 = spawn("script_origin",param_01.origin);
	if(isdefined(param_01.angles))
	{
		var_07.angles = param_01.angles;
	}

	if(param_00.animname != "hovertank")
	{
		if(param_00 == level.knox)
		{
			level.knox.goalradius = 16;
			level.knox setgoalnode(getnode("tank_hangar_knox_node","targetname"));
			common_scripts\utility::flag_wait("flag_move_knox_to_console");
		}

		var_07 maps\_anim::anim_reach_solo(param_00,var_02);
		if(param_00 == level.burke)
		{
			common_scripts\utility::flag_set("flag_tank_hangar_sweep_dialogue");
		}

		param_00 common_scripts\utility::delaycall(0.05,::setanimrate,param_00 maps\_utility::getanim(var_02),1.05);
		var_07 maps\_anim::anim_single_solo(param_00,var_02);
		var_07 thread maps\_anim::anim_loop_solo(param_00,var_03,var_05);
	}
	else
	{
		var_07 thread maps\_anim::anim_loop_solo(param_00,"hovertank_reveal_static",var_06);
	}

	param_00.ready_for_reveal = 1;
	common_scripts\utility::flag_wait("flag_hovertank_reveal_scene");
	var_08 = 1;
	while(var_08)
	{
		var_08 = 0;
		if(!isdefined(level.burke.ready_for_reveal) || !isdefined(level.cormack.ready_for_reveal))
		{
			var_08 = 1;
		}

		wait(0.05);
	}

	var_07 notify(var_06);
	common_scripts\utility::flag_set("flag_hovertank_reveal_scene_started");
	if(param_00 != level.knox)
	{
		var_07 notify(var_05);
		if(param_00.animname == "hovertank")
		{
			var_07 thread maps\_anim::anim_single_solo(param_00,var_04);
			param_00 thread maps\lab_utility::delete_on_notify(level,"hovertank_hide_exterior");
			common_scripts\utility::waittill_any_ents(var_07,var_04,level,"player_in_hovertank");
			if(!common_scripts\utility::flag("player_in_hovertank"))
			{
				if(isdefined(param_00))
				{
					var_07 thread maps\_anim::anim_loop_solo(param_00,var_03,var_05);
				}
			}
		}
		else
		{
			param_00 common_scripts\utility::delaycall(0.05,::setanimrate,param_00 maps\_utility::getanim(var_04),1.05);
			var_07 maps\_anim::anim_single_solo(param_00,var_04);
			if(!common_scripts\utility::flag("player_in_hovertank"))
			{
				var_07 thread maps\_anim::anim_loop_solo(param_00,"hovertank_idle",var_05);
			}
		}
	}

	common_scripts\utility::flag_wait("player_in_hovertank");
	if(isdefined(param_00))
	{
		param_00 maps\_utility::anim_stopanimscripted();
		param_00.ready_for_reveal = undefined;
	}

	var_07 notify(var_05);
	wait 0.05;
	var_07 delete();
	maps\_utility::deletestruct_ref(self);
}

//Function Number: 321
se_hovertank_reveal_lift_think(param_00)
{
	var_01 = "hovertank_reveal";
	self.animname = "htank_reveal_lift_0" + param_00;
	maps\_utility::assign_animtree();
	maps\_anim::anim_first_frame_solo(self,var_01);
	common_scripts\utility::flag_wait("flag_hovertank_reveal_scene_started");
	maps\_anim::anim_single_solo(self,var_01);
}

//Function Number: 322
allow_player_hovertank_mount(param_00)
{
	common_scripts\utility::flag_set("flag_obj_tank_06");
	var_01 = getent("hovertank_enter_trigger","targetname");
	var_01 waittill("trigger");
	if(!isdefined(param_00))
	{
		param_00 = common_scripts\utility::getstruct("hovertank_reveal_org","targetname");
	}

	thread maps\lab_lighting::tank_board_enter();
	thread maps\lab_lighting::tank_board_enter_top_lights();
	common_scripts\utility::flag_set("player_entering_hovertank");
	common_scripts\utility::flag_set("flag_tank_board_dialogue");
	var_02 = level.hovertank.angles;
	var_03 = level.hovertank.origin;
	se_hovertank_mount(param_00);
	level.hovertank vehicle_teleport(var_03,var_02,0,0);
	level.player maps\_player_stats::toggle_register_kills_for_vehicle_occupants(0);
	level.player thread mount_hovertank(1);
	common_scripts\utility::flag_set("player_in_hovertank");
	common_scripts\utility::flag_set("flag_player_in_hovertank_dialogue");
	soundscripts\_snd::snd_message("aud_player_gets_in_tank");
	wait(0.5);
	thread maps\_utility::autosave_by_name("tank_hangar");
	thread combat_tank_courtyard();
}

//Function Number: 323
se_hovertank_mount(param_00)
{
	var_01 = spawn("script_origin",param_00.origin);
	if(isdefined(param_00.angles))
	{
		var_01.angles = param_00.angles;
	}

	level.player_rig = maps\lab_utility::spawn_player_rig();
	level.player_rig hide();
	level.player_rig dontcastshadows();
	level.player maps\_shg_utility::setup_player_for_scene(0);
	maps\_player_exo::player_exo_deactivate();
	var_02 = 0.5;
	level.player playerlinktoblend(level.player_rig,"tag_player",var_02);
	level.player_rig common_scripts\utility::delaycall(var_02,::show);
	level notify("msg_vfx_player_in_tank");
	thread tank_hangar_door_close();
	var_03 = maps\_utility::spawn_anim_model("hovertank_interior",level.hovertank.origin);
	var_03.angles = level.hovertank.angles;
	var_03 setmaterialscriptparam(1,0);
	var_03 hidepart("TAG_SHADOW_HIDE");
	var_04 = [level.player_rig,level.hovertank,var_03];
	var_05 = "hovertank_enter";
	var_01 thread maps\_anim::anim_single(var_04,var_05);
	soundscripts\_snd::snd_message("hovertank_enter");
	level waittill("hovertank_enter_start_npcs");
	var_06 = [level.burke,level.cormack,level.knox];
	var_01 thread maps\_anim::anim_single(var_06,var_05);
	thread maps\lab_lighting::tank_turrent_reflection(var_03,var_06);
	level waittill("hovertank_show_interior");
	maps\_cloak::cloaked_stealth_disable_battery_hud();
	var_03 show();
	level waittill("hovertank_hide_exterior");
	level.hovertank hide();
	level.hovertank clearanim(level.scr_anim["hovertank"]["hovertank_enter"],0.2);
	var_01 waittill(var_05);
	var_03 delete();
	level.player unlink();
	level.player_rig delete();
}

//Function Number: 324
mount_hovertank(param_00)
{
	setup_hovertank_combat();
	level notify("tank_switch");
	var_01 = vehicle_scripts\_hovertank::add_hovertank_turret(level.hovertank);
	var_01 hidepart("TAG_BOOT");
	thread maps\lab_lighting::hovertank_turrent_light(var_01);
	thread maps\lab_lighting::hovertank_turrent_reflection(var_01);
	maps\_player_exo::player_exo_deactivate();
	level.player vehicle_scripts\_hovertank::hovertank_ride(level.hovertank,level.hovertank_turret);
	level.use_hovertank_chromatic_aberration = 1;
	if(isdefined(param_00) && param_00 == 1)
	{
		level.hovertank_turret thread vehicle_scripts\_hovertank::hoverscreen_reveal(3);
	}
	else
	{
		level.hovertank_turret thread vehicle_scripts\_hovertank::hoverscreen_reveal(1.5);
	}

	level.burke thread ride_hovertank_ai();
	level.cormack thread ride_hovertank_ai();
	level.knox thread ride_hovertank_ai();
	var_01 setmodel("vehicle_mil_hovertank_simple_vm");
}

//Function Number: 325
hoverscreen_damage_fx(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = 0.25;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	level.hovertank_turret setmaterialscriptparam(1,0.1);
	wait(param_00);
	level.hovertank_turret setmaterialscriptparam(0,0.1);
}

//Function Number: 326
hoverscreen_restore(param_00)
{
	level.hovertank_turret setmaterialscriptparam(0,param_00);
}

//Function Number: 327
setup_hovertank_combat()
{
	setsaveddvar("r_hudoutlinewidth",1);
	setsaveddvar("r_hudoutlinepostmode",2);
	setsaveddvar("r_hudoutlinehalolumscale",0.75);
	setsaveddvar("r_hudoutlinehaloblurradius",0.35);
	maps\_utility::battlechatter_off("allies");
	maps\_utility::battlechatter_off("axis");
	maps\_utility::delaythread(0.05,::delete_mobile_cover);
	maps\lab_utility::hovertank_setup_hint_data();
	maps\_utility::array_spawn_function_noteworthy("tank_courtyard_enemy",::tank_battle_rpg_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("tank_combat_warbird",::tank_combat_warbird_think);
	maps\_utility::array_spawn_function_noteworthy("tank_combat_vrap",::tank_combat_vrap);
	var_00 = getentarray("vrap_placed","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 thread tank_combat_vrap();
	}

	maps\_utility::array_spawn_function_noteworthy("tank_combat_littlebird",::tank_combat_littlebird_think);
	maps\_utility::array_spawn_function_noteworthy("tank_battle_enemy_tank",::enemy_tank_ai_think);
	maps\_utility::array_spawn_function_noteworthy("tank_road_enemy",::tank_road_enemy_think);
	maps\_utility::add_global_spawn_function("axis",::hovertank_combat_global_enemy_think);
	maps\_utility::array_spawn_function_noteworthy("tank_combat_field_flee_guy",::combat_tank_field_flee_guys_think);
	common_scripts\utility::array_thread(getentarray("destructible_trailer_collision","script_noteworthy"),::maps\lab_utility::destructible_trailer_collision_think);
	common_scripts\utility::array_thread(getentarray("can_tip","script_noteworthy"),::maps\lab_utility::can_tip_think);
	common_scripts\utility::array_thread(getentarray("log_pile_scripted","script_noteworthy"),::maps\lab_utility::log_pile_scripted_think);
	common_scripts\utility::array_thread(getentarray("trigger_spawn_and_set_flag","script_noteworthy"),::maps\lab_utility::trigger_spawn_and_set_flag_think);
	maps\_utility::array_spawn_function_noteworthy("tank_battle_rpg_enemy",::tank_battle_rpg_enemy_think);
	level.vehiclespawncallbackthread = ::lab_vehicle_callback;
	thread courtyard_scripted_props_staged_wakeup();
	thread hovertank_combat_road_log_scene();
	thread hovertank_combat_clearing_choppers_1();
	thread hovertank_combat_clearing_choppers_3();
	thread hovertank_ascent_final_enemies();
	thread hovertank_combat_cleanup();
	level.hovertank thread hovertank_monitor_status();
	thread hovertank_checkpoint_logic();
	common_scripts\utility::array_thread(getentarray("destructible_boxtruck","script_noteworthy"),::maps\lab_utility::destructible_boxtruck_think);
	level maps\_utility::waittillthread("hovertank_end",::cleanup_hovertank_combat);
}

//Function Number: 328
disable_static_mobile_cover()
{
	var_00 = getentarray("static_mobile_cover","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 vehicle_scripts\_cover_drone::cover_drone_disable();
	}
}

//Function Number: 329
delete_mobile_cover()
{
	var_00 = getentarray("script_vehicle_cover_drone","classname");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02))
		{
			var_02 delete();
		}
	}
}

//Function Number: 330
cleanup_hovertank_combat()
{
	maps\_utility::remove_global_spawn_function("axis",::hovertank_combat_global_enemy_think);
}

//Function Number: 331
hovertank_checkpoint_logic()
{
	level.hovertank endon("hovertank_done");
	var_00 = 0;
	for(;;)
	{
		if(issaverecentlyloaded() && !var_00)
		{
			var_00 = 1;
			if(common_scripts\utility::flag("hovertank_clearing_reached"))
			{
				if(level.hovertank vehicle_scripts\_hovertank::get_trophy_ammo() < 60)
				{
					level.hovertank vehicle_scripts\_hovertank::set_trophy_ammo(60);
				}
			}
			else if(common_scripts\utility::flag("hovertank_road_reached"))
			{
				if(level.hovertank vehicle_scripts\_hovertank::get_trophy_ammo() < 80)
				{
					level.hovertank vehicle_scripts\_hovertank::set_trophy_ammo(80);
				}
			}
			else
			{
			}
		}
		else if(!issaverecentlyloaded())
		{
			var_00 = 0;
		}

		wait(0.1);
	}
}

//Function Number: 332
courtyard_scripted_props_staged_wakeup()
{
	var_00 = getentarray("courtyard_scripted_props","script_noteworthy");
	foreach(var_02 in var_00)
	{
		var_02 courtyard_scripted_props_think();
		wait(0.05);
	}
}

//Function Number: 333
courtyard_scripted_props_think()
{
	if(self.classname == "script_brushmodel")
	{
		self delete();
		return;
	}

	if(self.classname == "script_model")
	{
		self physicslaunchclient(self.origin,(0,0,0));
	}
}

//Function Number: 334
hovertank_combat_global_enemy_think()
{
	maps\_utility::disable_long_death();
	self.dropweapon = 0;
	self.grenadeammo = 0;
	thread maps\lab_utility::hovertank_enemy_outline(4);
	thread maps\lab_utility::hovertank_aimed_enemy_ai_weapon_hint(1,"missile");
	self endon("death");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isdefined(var_09))
		{
			if(var_09 == "hovertank_antiair")
			{
				self.health = self.health + var_00;
				continue;
			}

			if(var_09 == "hovertank_missile_small")
			{
				self kill(var_03,var_01);
			}
		}
	}
}

//Function Number: 335
lab_vehicle_callback(param_00)
{
	if(issubstr(param_00.classname,"low"))
	{
		param_00 maps\_utility::ent_flag_init("no_riders_until_unload");
	}
}

//Function Number: 336
hovertank_combat_road_log_scene()
{
	common_scripts\utility::flag_wait("hovertank_combat_road_log_scene");
	maps\_utility::delaythread(5,::common_scripts\utility::flag_set,"flag_tank_road_log_enemies_dialogue");
	if(!common_scripts\utility::flag("flag_log_pile_scripted_destroyed"))
	{
		maps\_utility::array_spawn_targetname("tank_road_log_enemy");
	}
}

//Function Number: 337
hovertank_combat_clearing_choppers_1()
{
	common_scripts\utility::flag_wait("flag_hovertank_combat_clearing_choppers_1");
	common_scripts\utility::flag_set("flag_tank_field_lz_over_ridge_dialogue");
}

//Function Number: 338
hovertank_combat_clearing_choppers_3()
{
	common_scripts\utility::flag_wait("flag_hovertank_combat_clearing_choppers_3");
	common_scripts\utility::flag_set("flag_tank_clearing_infantry_dialogue");
}

//Function Number: 339
hovertank_ascent_final_enemies()
{
	common_scripts\utility::flag_wait("flag_hovertank_ascent_final_enemies");
	common_scripts\utility::flag_set("flag_tank_ascent_dialogue");
}

//Function Number: 340
hovertank_monitor_status()
{
	level endon("hovertank_end");
	var_00 = self.trophyammomax;
	self.last_hit_callout_time = gettime();
	var_01 = 100;
	for(;;)
	{
		self waittill("trophy_deployed",var_02);
		if(self.trophyammo / self.trophyammomax < 0.75 && var_01 > 75)
		{
			level maps\_utility::dialogue_queue("lab_sir_trophysystemat75");
			var_01 = 75;
		}
		else if(self.trophyammo / self.trophyammomax < 0.5 && var_01 > 50)
		{
			level maps\_utility::dialogue_queue("lab_sir_trophysystemat50");
			var_01 = 50;
		}
		else if(self.trophyammo / self.trophyammomax < 0.25 && var_01 > 25)
		{
			level maps\_utility::dialogue_queue("lab_sir_trophysystemat25");
			var_01 = 25;
		}
		else if(self.trophyammo / self.trophyammomax <= 0.05 && var_01 > 0.05)
		{
			level maps\_utility::dialogue_queue("lab_sir_trophysystemcritical");
			var_01 = 0.05;
		}

		if(self.trophyammo / self.trophyammomax < 0.8 && !isdefined(self.trophy80))
		{
			self.trophy80 = 1;
			level.burke maps\_utility::dialogue_queue("lab_gdn_weregettingbeatenup");
			continue;
		}

		if(self.trophyammo / self.trophyammomax < 0.6 && !isdefined(self.trophy60))
		{
			self.trophy60 = 1;
			level.burke maps\_utility::dialogue_queue("lab_gdn_wecanttakeanotherhit");
			continue;
		}

		if(self.trophyammo / self.trophyammomax == 0 && !isdefined(self.health0))
		{
			self.trophy0 = 1;
			level.burke maps\_utility::dialogue_queue("lab_gdn_ourtrophysystemisempty");
			return;
		}
		else if(gettime() - self.last_hit_callout_time > 10000)
		{
			if(randomfloat(1) < 0.25)
			{
				if(isdefined(var_02))
				{
					var_03 = vectortoangles(var_02 - level.hovertank.turret.origin);
					var_04 = vectornormalize(var_02 - level.hovertank.turret.origin);
					var_05 = anglestoright(level.hovertank.turret gettagangles("tag_aim_animated"));
					var_06 = vectordot(var_05,var_04);
					if(var_06 > 0.5)
					{
						var_07 = common_scripts\utility::cointoss();
						if(var_07)
						{
							level.burke maps\lab_vo::important_dialogue_queue("lab_gdn_firefromtheright");
						}
						else
						{
							level.cormack maps\lab_vo::important_dialogue_queue("lab_crk_takingfirefromtheright");
						}
					}
					else if(var_06 < -0.5)
					{
						var_07 = common_scripts\utility::cointoss();
						if(var_07)
						{
							level.burke maps\lab_vo::important_dialogue_queue("lab_gdn_firefromtheleft");
						}
						else
						{
							level.cormack maps\lab_vo::important_dialogue_queue("lab_crk_takingfirefromtheleft");
						}
					}
				}
			}
		}
	}
}

//Function Number: 341
hovertank_combat_cleanup()
{
	level waittill("hovertank_end");
}

//Function Number: 342
ride_hovertank_ai()
{
	self.no_friendly_fire_penalty = 1;
	self forceteleport(level.hovertank.origin,level.hovertank.angles);
	self linkto(level.hovertank);
	self.ignoreall = 1;
	self hideallparts();
	common_scripts\utility::flag_wait("flag_se_hovertank_exit");
	self showallparts();
	self.ignoreall = 0;
	self unlink();
	self.no_friendly_fire_penalty = undefined;
}

//Function Number: 343
setup_hovertank()
{
	var_00 = getent("hovertank","targetname");
	level.hovertank = var_00 maps\_utility::spawn_vehicle();
	level.hovertank thread monitor_mobile_turret_health();
	level.hovertank makeunusable();
	level.hovertank.animname = "hovertank";
	if(isdefined(level.start_point))
	{
		switch(level.start_point)
		{
			case "tank_ascent":
			case "tank_field_right_fork":
			case "tank_field_left_fork":
			case "tank_field":
			case "tank_road":
				level.player maps\_player_stats::toggle_register_kills_for_vehicle_occupants(0);
				thread mount_hovertank();
				break;

			default:
				level.player maps\_player_stats::toggle_register_kills_for_vehicle_occupants(1);
				break;
		}
	}
}

//Function Number: 344
tank_combat_vehicle_damage_feedback()
{
	self endon("death");
	thread maps\_utility::add_damagefeedback();
	common_scripts\utility::waittill_any("end_damage_feedback","hovertank_end");
	maps\_utility::remove_damagefeedback();
}

//Function Number: 345
tank_combat_vrap()
{
	thread maps\lab_utility::destroy_self_when_nuked();
	thread maps\lab_utility::hovertank_enemy_outline(4);
	thread tank_combat_vehicle_damage_feedback();
	if(!isdefined(self.damage_functions))
	{
		self.damage_functions = [];
	}

	maps\_utility::add_damage_function(::enemy_vrap_damage_function);
	thread tank_combat_vrap_deactivate_on_unload();
	maps\_vehicle::vehicle_set_health(2000);
	self waittill("death",var_00,var_01,var_02);
	var_03 = maps\lab_utility::hovertank_enemy_outline_offset() + self.origin;
	radiusdamage(var_03,400,150,150,level.player,"MOD_EXPLOSIVE");
	physicsexplosionsphere(var_03,400,150,2,0);
}

//Function Number: 346
tank_combat_vrap_deactivate_on_unload()
{
	self endon("death");
	self endon("hovertank_end");
	self waittill("unloaded");
	self notify("end_damage_feedback");
	self notify("end_highlight");
}

//Function Number: 347
tank_combat_warbird_think()
{
	self endon("death");
	thread maps\_shg_utility::make_emp_vulnerable();
	thread tank_combat_vehicle_damage_feedback();
	maps\_utility::add_damage_function(::tank_combat_warbird_damage_function);
	thread warbird_death_function();
	thread maps\lab_utility::warbird_heavy_shooting_think(1);
	thread maps\lab_utility::destroy_self_when_nuked();
	thread maps\lab_utility::hovertank_enemy_outline(4);
	thread maps\lab_utility::hovertank_aimed_enemy_vehicle_weapon_hint(2,"emp");
	maps\_vehicle::vehicle_set_health(1200);
	self sethoverparams(360,50);
	if(!isdefined(self.ent_flag["warbird_open_fire"]))
	{
		maps\_utility::ent_flag_init("warbird_open_fire");
	}

	maps\_utility::ent_flag_wait("warbird_open_fire");
	self notify("warbird_fire");
	maps\_utility::ent_flag_waitopen("warbird_open_fire");
	self notify("warbird_stop_firing");
}

//Function Number: 348
tank_combat_warbird_damage_function(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(param_01 == level.player && param_04 != "MOD_ENERGY" && param_00 > 499)
	{
		if(!isdefined(level.hovertank.choppersniped))
		{
			level.burke maps\_utility::delaythread(0.5,::maps\lab_vo::important_dialogue_queue,"lab_gdn_niceshot");
			level.hovertank.choppersniped = 1;
			self.sniped = 1;
		}
		else if(randomfloat(1) < 0.5)
		{
			level.burke maps\_utility::delaythread(0.5,::maps\lab_vo::important_dialogue_queue,"lab_gdn_niceshot");
			self.sniped = 1;
		}

		self kill(param_03,param_01);
		wait(0.05);
		if(isdefined(self))
		{
			self notify("crash_done");
			self notify("in_air_explosion");
			return;
		}

		return;
	}

	if(param_01 == level.player && param_04 == "MOD_ENERGY")
	{
		self endon("death");
		self endon("emp_death");
		wait(0.5);
		if(isdefined(self.emp_crash) && self.emp_crash == 1)
		{
			return;
		}

		if(!isdefined(level.hovertank.empedwarbird))
		{
			level.burke maps\lab_vo::important_dialogue_queue("lab_gdn_fireagain");
			level.hovertank.empedwarbird = 1;
			return;
		}

		if(randomfloat(1) < 0.5)
		{
			if(common_scripts\utility::cointoss())
			{
				level.burke maps\lab_vo::important_dialogue_queue("lab_gdn_hithimagain");
				return;
			}

			level.burke maps\lab_vo::important_dialogue_queue("lab_gdn_fireagain");
			return;
		}

		return;
	}
}

//Function Number: 349
warbird_death_function()
{
	level.hovertank endon("death");
	self waittill("death");
	if(isdefined(self) && isdefined(self.sniped))
	{
		return;
	}

	wait(0.5);
	check_restricted_airspace_achievement();
	if(!isdefined(level.hovertank.warbirdkilled))
	{
		level.burke maps\lab_vo::important_dialogue_queue("lab_gdn_warbirdsdown");
		level.hovertank.warbirdkilled = 1;
		return;
	}

	if(randomfloat(1) < 0.25)
	{
		level.burke maps\lab_vo::important_dialogue_queue("lab_gdn_warbirdsdown");
	}
}

//Function Number: 350
check_restricted_airspace_achievement()
{
	if(!isdefined(level.restricted_airspace))
	{
		level.restricted_airspace = 0;
	}

	level.restricted_airspace++;
	if(level.restricted_airspace >= 10)
	{
		maps\_utility::giveachievement_wrapper("LEVEL_10A");
	}
}

//Function Number: 351
tank_combat_littlebird_damage_function(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(param_01 == level.player && param_04 != "MOD_ENERGY" && param_00 > 499)
	{
		self kill(self.origin,param_01);
		wait(0.05);
		if(isdefined(self))
		{
			self notify("crash_done");
			self notify("in_air_explosion");
		}
	}
}

//Function Number: 352
notify_warbird_when_killed(param_00)
{
	param_00 endon("death");
	self waittill("death");
	param_00 notify("rpg_guy_killed");
}

//Function Number: 353
tank_combat_warbird_kill_is_crew_killed(param_00)
{
	self endon("death");
	for(;;)
	{
		self waittill("rpg_guy_killed");
		if(self.rpg_guys.size < 1)
		{
			self kill();
		}
	}
}

//Function Number: 354
tank_combat_warbird_orient_to_open_fire()
{
	level.hovertank endon("death");
	if(!isdefined(self.lookatent))
	{
		self.lookatent = spawn("script_origin",self.origin);
		thread common_scripts\utility::delete_on_death(self.lookatent);
		if(common_scripts\utility::cointoss())
		{
			self.lookatent.origin = anglestoright(vectortoangles(self.origin - level.hovertank.origin)) * 1000 + self.origin;
		}
		else
		{
			self.lookatent.origin = anglestoright(vectortoangles(self.origin - level.hovertank.origin)) * -1000 + self.origin;
		}

		self setlookatent(self.lookatent);
		maps\_utility::ent_flag_waitopen("warbird_open_fire");
		self.lookatent delete();
	}
}

//Function Number: 355
tank_combat_warbird_liftoff_think()
{
	self endon("death");
	self vehicle_setspeed(15,60);
	maps\_utility::ent_flag_init("warbird_open_fire");
	thread tank_combat_warbird_think();
	maps\_utility::delaythread(3,::maps\_utility::ent_flag_set,"warbird_open_fire");
	var_00 = common_scripts\utility::getstruct("warbird_liftoff_start_node","targetname");
	self setlookatent(level.hovertank);
	maps\_utility::vehicle_liftoff(700);
	self clearlookatent();
	thread maps\_vehicle::vehicle_paths(var_00);
}

//Function Number: 356
tank_combat_littlebird_think()
{
	self endon("death");
	thread maps\_shg_utility::make_emp_vulnerable();
	thread maps\lab_utility::destroy_self_when_nuked();
	thread maps\lab_utility::hovertank_enemy_outline(4);
	thread tank_combat_vehicle_damage_feedback();
	thread maps\lab_utility::hovertank_aimed_enemy_vehicle_weapon_hint(2,"emp");
	maps\_utility::add_damage_function(::tank_combat_littlebird_damage_function);
	self sethoverparams(360,50);
	if(!isdefined(self.ent_flag["littlebird_open_fire"]))
	{
		maps\_utility::ent_flag_init("littlebird_open_fire");
	}

	maps\_utility::ent_flag_wait("littlebird_open_fire");
	foreach(var_01 in self.riders)
	{
		if(isalive(var_01) && isdefined(var_01.script_startingposition) && var_01.script_startingposition > 1)
		{
			var_01 thread littlebird_rpg_rider_think("littlebird_open_fire");
		}
	}
}

//Function Number: 357
littlebird_rpg_rider_think(param_00)
{
	self endon("death");
	self.ridingvehicle endon("emp_death");
	if(isdefined(param_00))
	{
		self.ridingvehicle endon(param_00);
	}

	if(isdefined(level.hovertank))
	{
		level.hovertank endon("death");
		self setentitytarget(level.hovertank.turret);
	}

	wait(randomfloatrange(1,5));
	var_01 = 0.4;
	for(;;)
	{
		if(!isdefined(self.enemy) || !self.ridingvehicle maps\_utility::ent_flag("littlebird_open_fire"))
		{
			wait(0.5);
			continue;
		}

		if(!self canshoot(level.player.origin + (0,0,64)))
		{
			wait(0.5);
			continue;
		}

		var_02 = vectornormalize(self.enemy.origin - self.origin);
		var_03 = anglestoforward(self.angles);
		var_04 = vectordot(var_03,var_02);
		if(var_04 >= var_01)
		{
			playfxontag(common_scripts\utility::getfx("rpg_muzzle_flash"),self,"tag_flash");
			magicbullet("rpg_straight",self gettagorigin("tag_flash") + anglestoforward(self gettagangles("tag_flash")) * 20,self.enemy.origin);
			wait(randomfloatrange(4,8));
			continue;
		}

		wait(randomfloatrange(0.5,1.5));
	}
}

//Function Number: 358
tank_battle_rpg_enemy_think()
{
	level endon("hovertank_end");
	self endon("death");
	level.hovertank endon("death");
	self.dropweapon = 0;
	self setentitytarget(level.hovertank);
}

//Function Number: 359
btr_turret_think()
{
	self endon("death");
	self endon("kill_btr_turret_think");
	thread maps\_vehicle::vehicle_turret_scan_on();
	for(;;)
	{
		wait(randomfloatrange(0.3,0.8));
		var_00 = btr_get_target();
		if(isdefined(var_00))
		{
			btr_fire_at_target(var_00);
			wait(0.3);
		}
	}
}

//Function Number: 360
btr_fire_at_target(param_00)
{
	param_00 endon("death");
	self setturrettargetent(param_00,(0,0,32));
	if(common_scripts\utility::cointoss())
	{
		if(isdefined(self.mgturret))
		{
			foreach(var_02 in self.mgturret)
			{
				if(isdefined(var_02))
				{
					var_02 setturretteam("axis");
					var_02 setmode("manual");
					var_02 settargetentity(param_00);
					var_02 startfiring();
				}
			}
		}

		wait(randomfloatrange(3,5));
		if(isdefined(self.mgturret))
		{
			foreach(var_02 in self.mgturret)
			{
				if(isdefined(var_02))
				{
					var_02 cleartargetentity();
					var_02 stopfiring();
				}
			}

			return;
		}

		return;
	}

	for(var_06 = 0;var_06 < randomintrange(1,3);var_06++)
	{
		burst_fire_weapon();
		wait(0.5);
	}
}

//Function Number: 361
burst_fire_weapon()
{
	for(var_00 = 0;var_00 < randomintrange(2,4);var_00++)
	{
		self fireweapon();
		wait(0.2);
	}
}

//Function Number: 362
btr_get_target()
{
	var_00 = 4;
	var_01 = getaiarray("allies");
	for(var_02 = 0;var_02 < var_00;var_02++)
	{
		var_01[var_01.size] = level.player;
	}

	return common_scripts\utility::random(var_01);
}

//Function Number: 363
enemy_tank_ai_think()
{
	self endon("death");
	level.hovertank endon("death");
	thread maps\lab_utility::destroy_self_when_nuked();
	thread maps\lab_utility::hovertank_enemy_outline(4);
	thread maps\lab_utility::hovertank_aimed_enemy_vehicle_weapon_hint(3,"cannon");
	var_00 = 100;
	var_01 = 40;
	maps\_vehicle::vehicle_set_health(1000);
	maps\_utility::add_damage_function(::enemy_tank_damage_function);
	thread enemy_tank_death_function();
	while(isdefined(self) && isalive(self))
	{
		if(sighttracepassed(self.origin + (0,0,100),level.hovertank.origin + (0,0,var_00),0,self,level.hovertank))
		{
			self.cur_tank_target = level.hovertank;
			enemy_tank_aim(var_00,1);
			if(isdefined(self.godmode) && self.godmode == 1)
			{
				maps\_vehicle::godoff();
			}

			continue;
		}

		wait(0.1);
	}
}

//Function Number: 364
enemy_tank_damage_function(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	self endon("death");
	level.hovertank endon("death");
	if(param_01 == level.player && param_00 < 500)
	{
		self.health = self.currenthealth;
		if(param_00 < 50)
		{
			var_0A = 0;
			if(isdefined(level.emp_vulnerable_list))
			{
				foreach(var_0C in level.emp_vulnerable_list)
				{
					if(distance(var_0C.origin,self.origin) < 1024)
					{
						var_0A = 1;
					}
				}
			}

			if(!var_0A)
			{
				if(!isdefined(level.hovertank.empedtank))
				{
					level.burke maps\lab_vo::important_dialogue_queue("lab_gdn_empsuselessagainstthosetanks");
					level.hovertank.empedtank = 1;
					return;
				}

				return;
			}

			return;
		}

		return;
	}

	maps\_damagefeedback::damagefeedback_took_damage(param_01,param_02,param_03,param_04,param_05,param_06,param_07);
	wait(0.5);
	if(!isdefined(level.hovertank.hittankagain))
	{
		level.burke maps\lab_vo::important_dialogue_queue("lab_gdn_hithimagain");
		level.hovertank.hittankagain = 1;
		return;
	}

	if(randomfloat(1) < 0.5)
	{
		if(common_scripts\utility::cointoss())
		{
			level.burke maps\lab_vo::important_dialogue_queue("lab_gdn_hithimagain");
			return;
		}

		level.burke maps\lab_vo::important_dialogue_queue("lab_gdn_fireagain");
		return;
	}
}

//Function Number: 365
enemy_tank_aim(param_00,param_01)
{
	self endon("death");
	level endon("missionfailed");
	var_02 = 100;
	var_03 = 100;
	var_04 = 100;
	self setturrettargetent(self.cur_tank_target,(randomintrange(-1 * var_02,var_02),randomintrange(-1 * var_03,var_03),randomintrange(-1 * var_04,var_04)));
	self waittill("turret_on_target");
	wait(2);
	if(sighttracepassed(self.origin + (0,0,100),self.cur_tank_target.origin + (0,0,param_00),0,self,level.hovertank))
	{
		if(param_01)
		{
			self fireweapon();
			soundscripts\_audio::deprecated_aud_play_sound_at("ht_exfil_ft101_fire",self.origin);
		}

		wait(randomintrange(5,8));
		return;
	}

	wait(1);
}

//Function Number: 366
enemy_tank_death_function()
{
	level.hovertank endon("death");
	self waittill("death");
	wait(1);
	if(!isdefined(level.hovertank.tankkilled))
	{
		level.burke maps\lab_vo::important_dialogue_queue("lab_gdn_tanksdown");
		level.hovertank.tankkilled = 1;
		return;
	}

	if(level.hovertank.tankkilled == 1)
	{
		level.burke maps\lab_vo::important_dialogue_queue("lab_gdn_gothim");
	}
	else if(level.hovertank.tankkilled == 2)
	{
		level.burke maps\lab_vo::important_dialogue_queue("lab_gdn_niceshot");
	}
	else
	{
		level.burke maps\lab_vo::important_dialogue_queue("lab_gdn_tanksdown");
	}

	level.hovertank.tankkilled++;
	if(level.hovertank.tankkilled > 3)
	{
		level.hovertank.tankkilled = 1;
	}
}

//Function Number: 367
enemy_vrap_damage_function(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(param_01 == level.player && param_00 >= 500)
	{
		self kill();
	}
}

//Function Number: 368
tank_road_enemy_think()
{
	self endon("death");
	self.ignoreall = 1;
	self waittill("goal");
	self.allowdeath = 1;
	maps\_anim::anim_generic_custom_animmode(self,"gravity","prone_dive");
	thread maps\_anim::anim_generic_loop(self,"prone_idle","stop_loop");
	self allowedstances("prone");
	thread maps\_utility::ai_delete_when_out_of_sight([self],512);
}

//Function Number: 369
monitor_mobile_turret_health()
{
	level.player endon("death");
	var_00 = getent("trig_hover_tank_immobilize","targetname");
	var_00 mobile_turret_health_think(self,::se_hovertank_exit);
}

//Function Number: 370
hover_tank_immobilize()
{
	var_00 = maps\_vehicle::spawn_vehicle_from_targetname_and_drive("tank_immobilize_littlebird");
	var_00 maps\_vehicle::godon();
	var_00 hover_tank_immobilize_rockets();
	var_00 maps\_vehicle::godoff();
	playfxontag(common_scripts\utility::getfx("tank_immobilized"),level.hovertank.turret,"tag_light_main");
	level.hovertank_turret notify("large_hit_react");
	var_01 = 1;
	var_02 = common_scripts\utility::getstruct("hovertank_defend_loc","targetname");
	level.hovertank vehicle_hovertanksethoverforcescale(0,0);
	var_03 = 0.5;
	maps\_utility::delaythread(var_03,::hovertank_defend_setup);
	thread vehicle_scripts\_hovertank::hoverscreen_turnoff(var_03);
	var_04 = maps\_utility::spawn_anim_model("hovertank_interior",level.hovertank.origin);
	var_04.angles = level.hovertank.turret.angles;
	var_04 linkto(level.hovertank);
	var_05 = [level.burke,level.knox,level.cormack,var_04];
	level.hovertank common_scripts\utility::delaycall(var_03,::vehicle_teleport,var_02.origin,var_02.angles);
	wait(var_01);
	stopfxontag(common_scripts\utility::getfx("tank_immobilized"),level.hovertank.turret,"tag_light_main");
	var_04 delete();
	thread hoverscreen_restore(0.5);
	iprintln("defend starts");
	thread hovertank_defend_combat();
	level.hovertank.turret setbottomarc(25);
	common_scripts\utility::flag_wait("hovertank_defend_complete");
	wait(5);
	se_hovertank_exit();
}

//Function Number: 371
hover_tank_immobilize_rockets()
{
	level.hovertank endon("damage");
	level.hovertank endon("trophy_deployed");
	var_00 = common_scripts\utility::getstruct("hovertank_immobilize_rocket_1","targetname");
	var_01 = common_scripts\utility::getstruct("hovertank_immobilize_rocket_2","targetname");
	var_02 = magicbullet("rpg_straight",var_00.origin,level.hovertank.origin + (0,0,64));
	wait(0.5);
	var_03 = magicbullet("rpg_straight",var_01.origin,level.hovertank.origin + (0,0,64));
	var_04 = 0;
	var_05 = "tag_guy1";
	for(;;)
	{
		if(var_04)
		{
			var_05 = "tag_guy1";
		}
		else
		{
			var_05 = "tag_guy3";
		}

		var_04 = !var_04;
		var_06 = self gettagorigin(var_05) + anglestoup(self.angles) * 30 + anglestoforward(self.angles) * 30;
		magicbullet("rpg_straight",var_06,level.hovertank.origin + (0,0,64));
		wait(randomfloatrange(0.25,0.75));
	}
}

//Function Number: 372
hovertank_defend_setup()
{
	foreach(var_01 in getentarray("script_vehicle","code_classname"))
	{
		if(var_01.health < 0)
		{
			var_01 delete();
		}
	}

	var_03 = [getvehiclenode("ascent_tank_1_end_point","targetname"),getvehiclenode("ascent_tank_2_end_point","targetname")];
	foreach(var_05 in var_03)
	{
		var_06 = spawn("script_model",var_05.origin);
		if(isdefined(var_05.angles))
		{
			var_06.angles = var_05.angles;
		}

		var_06 setmodel("vehicle_ft101_tank_destroy");
	}
}

//Function Number: 373
hovertank_defend_combat()
{
	maps\_utility::array_spawn_targetname("tank_defend_wave_1");
	maps\_utility::delaythread(30,::maps\_utility::array_spawn_targetname,"tank_defend_wave_2");
	wait(60);
	common_scripts\utility::flag_set("hovertank_defend_complete");
}

//Function Number: 374
se_hovertank_exit()
{
	soundscripts\_snd::snd_message("tank_disabled");
	level.hovertank vehicle_hovertanksethoverforcescale(0,0);
	common_scripts\utility::flag_set("flag_obj_hide_marker_during_tank_exit");
	level.hovertank.godmode = 1;
	var_00 = 1.5;
	thread vehicle_scripts\_hovertank::hoverscreen_turnoff(var_00,1);
	wait(1);
	var_01 = getentarray("script_vehicle_vrap_physics","classname");
	var_02 = getentarray("script_vehicle_littlebird_atlas_bench","classname");
	var_03 = getentarray("script_vehicle_xh9_warbird_low_heavy_turret","classname");
	var_04 = getentarray("script_vehicle_ft101_tank_physics","classname");
	var_05 = getent("vol_exfil_cleanup_check","targetname");
	var_06 = common_scripts\utility::getstruct("org_se_exfil","targetname");
	var_07 = common_scripts\utility::array_combine(var_01,var_02);
	var_07 = common_scripts\utility::array_combine(var_07,var_03);
	var_07 = common_scripts\utility::array_combine(var_07,var_04);
	foreach(var_09 in var_07)
	{
		if(distancesquared(var_09.origin,level.player.origin) < 250000 || distancesquared(var_09.origin,var_06.origin) < 250000)
		{
			var_09 delete();
			continue;
		}

		if(var_09.health > 0)
		{
			var_09 kill();
		}
	}

	foreach(var_0C in getaiarray("axis"))
	{
		var_0C kill();
	}

	level.player painvisionoff();
	level.player maps\_utility::ent_flag_clear("player_has_red_flashing_overlay");
	level.player.health = level.player.maxhealth;
	level.player maps\_utility::lerpfov_saved(65,0.1);
	thread maps\lab_lighting::tank_exit_dof_reset();
	var_0E = common_scripts\utility::getstruct("hovertank_exit_org","targetname");
	var_0F = spawnstruct();
	var_0F.origin = var_0E.origin;
	if(isdefined(var_0E.angles))
	{
		var_0F.angles = var_0E.angles;
	}

	level.player_rig = maps\lab_utility::spawn_player_rig(undefined,var_0E.origin);
	level.hovertank_exterior_model = maps\_utility::spawn_anim_model("hovertank",var_0E.origin);
	var_10 = maps\_utility::spawn_anim_model("hovertank_interior",var_0E.origin);
	var_10 hidepart("TAG_AIM_UNHIDE");
	var_11 = "hovertank_exit";
	var_0F maps\_anim::anim_first_frame_solo(level.player_rig,var_11);
	var_12 = level.player_rig gettagorigin("tag_player");
	var_13 = level.player_rig gettagangles("tag_player");
	level.hovertank_turret setturretdismountorg(var_12);
	var_14 = getent("tank_exit_viewmodel_origin","targetname");
	var_15 = var_14 getorigin();
	level.player_rig overridelightingorigin(var_15);
	if(level.nextgen)
	{
		setsaveddvar("r_subdiv","1");
	}

	level.cormack dontcastshadows();
	level.cormack thread se_hovertank_exit_cormack_shadow();
	level.hovertank notify("hovertank_done");
	common_scripts\utility::flag_set("flag_se_hovertank_exit");
	common_scripts\utility::flag_set("flag_tank_exit_dialogue");
	level maps\_utility::delaythread(9.25,::common_scripts\utility::flag_set,"flag_exfil_start_dialogue");
	soundscripts\_snd::snd_message("tank_exit");
	level.player_rig dontcastshadows();
	level.player_rig defaultlightingorigin();
	level.hovertank_exterior_model hide();
	level.hovertank_turret hide();
	level.player maps\_shg_utility::setup_player_for_scene(0);
	maps\_player_exo::player_exo_deactivate();
	level.player setorigin(var_12);
	level.player setplayerangles(var_13);
	level.player playerlinktoabsolute(level.player_rig,"tag_player");
	var_16 = [level.hovertank_exterior_model,var_10,level.burke,level.cormack,level.knox];
	var_0E thread maps\_anim::anim_single_run(var_16,var_11);
	var_0F thread maps\_anim::anim_single_solo(level.player_rig,var_11);
	thread exit_hovertank_rumbles();
	thread se_hovertank_exit_cover_fire();
	level waittill("hovertank_show_exterior");
	foreach(var_09 in var_07)
	{
		if(!isdefined(var_09))
		{
			continue;
		}

		if(distancesquared(var_09.origin,level.player.origin) < 250000)
		{
			var_09 delete();
			continue;
		}
	}

	level.hovertank_exterior_model show();
	level waittill("hovertank_hide_interior");
	var_10 hide();
	level.player_rig waittillmatch("end","single anim");
	thread se_hovertank_exit_cover_fire_cleanup();
	level.player unlink();
	maps\_player_exo::player_exo_activate();
	level.player maps\_shg_utility::setup_player_for_gameplay();
	common_scripts\utility::flag_set("flag_exfil_start");
	level.hovertank delete();
	level.player_rig delete();
	var_10 delete();
	maps\_utility::deletestruct_ref(var_0F);
	maps\_utility::autosave_by_name();
}

//Function Number: 375
exit_hovertank_rumbles()
{
	maps\lab_utility::setup_level_rumble_ent();
	wait(7.25);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.9,0.2);
	wait(0.3);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.7,0.2);
	wait(0.4);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.9,0.1);
	wait(0.2);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.8,0.1);
	wait(0.2);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.6,0.1);
	wait(0.8);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.4,0.1);
	wait(0.2);
	thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.3,0.3);
	wait(2);
	maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,0.7,1);
	level notify("exfil_helo_overhead_rumble_complete");
}

//Function Number: 376
handle_player_close_to_aircraft_rumbles()
{
	level waittill("exfil_helo_overhead_rumble_complete");
	maps\lab_utility::setup_level_rumble_ent();
	for(;;)
	{
		var_00 = distance(level.player.origin,level.razorback.origin);
		var_01 = 1000 - var_00 / 4000;
		thread maps\lab_utility::rumble_set_ent_rumble_intensity_for_time(level.rumble_ent,var_01,0.2);
		wait(0.25);
	}
}

//Function Number: 377
se_hovertank_exit_cormack_shadow()
{
	self waittillmatch("start_shadow","single anim");
	self castshadows();
}

//Function Number: 378
mobile_turret_health_think(param_00,param_01)
{
	level.player endon("death");
	param_00 endon("death");
	for(;;)
	{
		self waittill("trigger",var_02);
		if(var_02 == level.player)
		{
			param_00 thread [[ param_01 ]]();
			break;
		}
	}
}

//Function Number: 379
mobile_turret_burning()
{
	thread destroy_turret_when_player_leaves();
	level.player endon("death");
	self endon("dismount_vehicle_and_turret");
	self notify("play_damage_warning");
}

//Function Number: 380
destroy_turret_when_player_leaves()
{
	level.player endon("death");
	self waittill("player_exited_mobile_turret");
	destroy_mobile_turret();
}

//Function Number: 381
destroy_mobile_turret()
{
	level.player endon("death");
	common_scripts\utility::flag_wait("flag_burke_destroy_tank");
	var_00 = 256;
	var_01 = 20;
	while(distance(self.origin,level.player.origin) < var_00 && var_01 >= 0)
	{
		var_01 = var_01 - 0.05;
		wait(0.05);
	}

	self.mgturret[0] hide();
	self setmodel("vehicle_x4walker_wheels_dstrypv");
	playfxontag(common_scripts\utility::getfx("mobile_turret_explosion"),self,"tag_death_fx");
	earthquake(1,1.6,self.origin,625);
	soundscripts\_snd::snd_message("player_mobile_turret_explo");
	self notify("stop_mobile_turret_health_1");
	self notify("stop_mobile_turret_health_2");
	self notify("stop_mobile_turret_health_3");
	self notify("stop_mobile_turret_health_4");
	wait(0.5);
	playfxontag(common_scripts\utility::getfx("mobile_turret_ground_smoke"),self,"tag_death_fx");
}

//Function Number: 382
play_and_store_fx_on_tag(param_00,param_01,param_02)
{
	playfxontag(common_scripts\utility::getfx(param_00),param_01.mgturret[0],param_02);
	var_03 = spawnstruct();
	var_03.name = param_00;
	var_03.tag = param_02;
	if(!isdefined(param_01.damage_fx))
	{
		param_01.damage_fx = [];
	}

	param_01.damage_fx[self.damage_fx.size] = var_03;
}

//Function Number: 383
add_drone_to_squad()
{
	if(isdefined(self.script_parameters) && self.script_parameters == "personal_drone")
	{
		var_00 = getent("squad_drone_spawner","targetname");
		maps\_weapon_pdrone::pdrone_launch(var_00);
		if(isdefined(self.pdrone))
		{
			self.pdrone.pacifist = 1;
			self.pdrone.ignoreme = 1;
		}
	}
}

//Function Number: 384
cleanup_squad_drone()
{
	if(level.nextgen)
	{
		level waittill("street_cleanup");
	}
	else
	{
		level waittill("tff_transition_intro_to_middle");
	}

	self delete();
}

//Function Number: 385
se_hovertank_exit_cover_fire()
{
	var_00 = 0;
	if(!var_00)
	{
		level.player common_scripts\utility::delaycall(1,::enableinvulnerability);
	}

	var_01 = maps\_utility::getent_or_struct("checkpoint_exfil_start","script_noteworthy");
	level.cover_fire_missile_repulsor = missile_createrepulsororigin(var_01.origin,10000,300);
	thread spawn_exfil_enemies();
	if(!var_00)
	{
		wait(6.5);
	}
	else
	{
		wait(0.1);
	}

	thread maps\lab_utility::named_magic_bullet_strafe("exfil_cover_fire_0",5,2,60,0.35,"rpg");
	thread maps\lab_utility::named_magic_bullet_strafe("exfil_cover_fire_1",7,2,240,0.35,"rpg");
}

//Function Number: 386
se_hovertank_exit_cover_fire_cleanup()
{
	level.player disableinvulnerability();
	missile_deleteattractor(level.cover_fire_missile_repulsor);
}

//Function Number: 387
spawn_exfil_enemies()
{
	var_00 = 0;
	if(!var_00)
	{
		wait(6.4);
	}

	var_01 = [];
	var_02 = 2;
	var_03 = maps\_utility::getent_or_struct("exfil_cover_fire_0_source_start","targetname");
	for(var_04 = 0;var_04 < var_02;var_04++)
	{
		var_01[var_04] = [];
		var_05 = getentarray("tank_exfil_enemy_" + var_04,"targetname");
		foreach(var_07 in var_05)
		{
			var_01[var_04][var_01[var_04].size] = var_07 maps\_utility::spawn_ai(1,0);
		}

		var_09 = maps\_utility::getent_or_struct("tank_exfil_target_" + var_04,"targetname");
		var_0A = var_09.origin;
		var_0A = (var_0A[0],var_0A[1],var_0A[2] + 240);
		var_0B = 0.1 + var_04 * 0.25;
		common_scripts\utility::delay_script_call(var_0B,::exfil_enemy_missile,var_03,var_09.origin,var_01[var_04]);
	}
}

//Function Number: 388
exfil_enemy_missile(param_00,param_01,param_02)
{
	foreach(var_04 in param_02)
	{
		var_04.health = 1;
	}

	var_06 = magicbullet("rpg",param_00.origin,param_01);
	var_07 = missile_createattractororigin(param_01,50000,900,var_06,1);
	var_06 waittill("death");
	wait 0.05;
	foreach(var_04 in param_02)
	{
		if(isdefined(var_04) && isai(var_04) && isalive(var_04))
		{
			var_04 dodamage(var_04.health,param_01);
		}
	}

	missile_deleteattractor(var_07);
}