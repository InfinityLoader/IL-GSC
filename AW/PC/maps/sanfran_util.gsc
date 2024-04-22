/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: sanfran_util.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 168
 * Decompile Time: 2430 ms
 * Timestamp: 4/22/2024 2:36:03 AM
*******************************************************************/

//Function Number: 1
spawn_squad(param_00)
{
	level.burke = getent("spawner_burke_bridge","targetname") maps\_utility::spawn_ai(1);
	level.saint = getent("spawner_saint_bridge","targetname") maps\_utility::spawn_ai(1);
	level.burke setup_hero("Burke");
	level.saint setup_hero("Saint");
	if(isdefined(param_00))
	{
		var_01 = getent(param_00 + "_burke","targetname");
		level.burke teleport(var_01.origin,var_01.angles);
		level.burke setgoalpos(level.burke.origin);
		var_02 = getent(param_00 + "_saint","targetname");
		level.saint teleport(var_02.origin,var_02.angles);
		level.saint setgoalpos(level.saint.origin);
	}

	level.player setthreatbiasgroup("sentinel");
}

//Function Number: 2
setup_hero(param_00)
{
	maps\_utility::magic_bullet_shield();
	self.animname = param_00;
	if(!isdefined(level.heroes))
	{
		level.heroes = [];
	}

	level.heroes[level.heroes.size] = self;
	maps\_utility::make_hero();
	self setthreatbiasgroup("sentinel");
}

//Function Number: 3
set_player_start(param_00)
{
	var_01 = getent(param_00,"targetname");
	level.player maps\_utility::teleport_player(var_01);
}

//Function Number: 4
give_boost_jump()
{
	maps\_player_exo::player_exo_add_single("high_jump");
}

//Function Number: 5
remove_boost_jump()
{
	maps\_player_exo::player_exo_remove_single("high_jump");
}

//Function Number: 6
squad_ignore_all_start()
{
	foreach(var_01 in level.heroes)
	{
		var_01.ignoreall = 1;
	}
}

//Function Number: 7
squad_ignore_all_stop()
{
	foreach(var_01 in level.heroes)
	{
		var_01.ignoreall = 0;
	}
}

//Function Number: 8
setup_squad_for_scene()
{
	foreach(var_01 in level.heroes)
	{
		var_01.old_name = var_01.name;
		var_01.name = " ";
	}
}

//Function Number: 9
setup_squad_for_gameplay()
{
	foreach(var_01 in level.heroes)
	{
		var_01.name = var_01.old_name;
	}
}

//Function Number: 10
squad_careful_all_start()
{
	foreach(var_01 in level.heroes)
	{
		var_01 maps\_utility::enable_careful();
	}
}

//Function Number: 11
squad_careful_all_stop()
{
	foreach(var_01 in level.heroes)
	{
		var_01 maps\_utility::disable_careful();
	}
}

//Function Number: 12
show_ents_by_targetname(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	foreach(var_03 in var_01)
	{
		var_03 show();
	}
}

//Function Number: 13
hide_ents_by_targetname(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	foreach(var_03 in var_01)
	{
		var_03 hide();
	}
}

//Function Number: 14
solid_ents_by_targetname(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	foreach(var_03 in var_01)
	{
		var_03 solid();
	}
}

//Function Number: 15
notsolid_ents_by_targetname(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	foreach(var_03 in var_01)
	{
		var_03 notsolid();
	}
}

//Function Number: 16
connectpaths_ents_by_targetname(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	foreach(var_03 in var_01)
	{
		if(var_03.classname == "script_brushmodel")
		{
			var_03 connectpaths();
		}
	}
}

//Function Number: 17
disconnectpaths_ents_by_targetname(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	foreach(var_03 in var_01)
	{
		if(var_03.classname == "script_brushmodel")
		{
			var_03 disconnectpaths();
		}
	}
}

//Function Number: 18
delete_ents_by_targetname(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	foreach(var_03 in var_01)
	{
		var_03 delete();
	}
}

//Function Number: 19
hide_fallen_bridge()
{
	hide_ents_by_targetname("bridge_section_fallen");
	hide_ents_by_targetname("bridge_section_far");
}

//Function Number: 20
show_fallen_bridge()
{
	show_ents_by_targetname("bridge_section_fallen");
}

//Function Number: 21
show_far_bridge()
{
	show_ents_by_targetname("bridge_section_far");
}

//Function Number: 22
hide_intact_bridge()
{
	hide_ents_by_targetname("bridge_section_remove");
}

//Function Number: 23
remove_intact_bridge()
{
	connectpaths_ents_by_targetname("bridge_section_remove");
	delete_ents_by_targetname("bridge_section_remove");
}

//Function Number: 24
hide_crash_traffic()
{
	notsolid_ents_by_targetname("after_crash_traffic");
	hide_ents_by_targetname("after_crash_traffic");
}

//Function Number: 25
show_crash_traffic()
{
	solid_ents_by_targetname("after_crash_traffic");
	show_ents_by_targetname("after_crash_traffic");
}

//Function Number: 26
hide_chase_scene()
{
	hide_ents_by_targetname("bus_crash_final_pos_col");
	notsolid_ents_by_targetname("bus_crash_final_pos_col");
	hide_ents_by_targetname("pitbull_crash_collision");
	notsolid_ents_by_targetname("pitbull_crash_collision");
}

//Function Number: 27
put_bridge_in_proper_place()
{
	var_00 = getentarray("bridge_section_remove","targetname");
	foreach(var_02 in var_00)
	{
		var_02.origin = var_02.origin + (0,-9216,0);
		if(var_02.classname == "script_brushmodel")
		{
			var_02 disconnectpaths();
		}
	}
}

//Function Number: 28
put_roadsurface_in_proper_place()
{
	var_00 = getentarray("bridge_roadsurface_intro","targetname");
	foreach(var_02 in var_00)
	{
		var_02.origin = var_02.origin + (0,-5120,5);
	}
}

//Function Number: 29
delete_roadsurface_bridge()
{
	delete_ents_by_targetname("bridge_roadsurface_intro");
}

//Function Number: 30
setup_intro()
{
	hide_fallen_bridge();
	hide_crash_traffic();
	hide_chase_scene();
	make_bridge_normal();
	put_bridge_in_proper_place();
	put_roadsurface_in_proper_place();
	thread maps\sanfran_fx::traffic_fx_init();
	thread maps\_vehicle_traffic::traffic_init(::maps\sanfran_fx::traffic_collision_hit_func);
}

//Function Number: 31
trigger_bridge_small()
{
	self waittill("trigger");
	make_bridge_normal();
}

//Function Number: 32
make_bridge_big()
{
	hide_ents_by_targetname("bridge_tower_small");
	show_ents_by_targetname("bridge_tower_big");
}

//Function Number: 33
make_bridge_normal()
{
	show_ents_by_targetname("bridge_tower_small");
	hide_ents_by_targetname("bridge_tower_big");
}

//Function Number: 34
toggle_off_real_mob()
{
	hide_ents_by_targetname("mob_brushmodel");
	hide_ents_by_targetname("mob_models");
}

//Function Number: 35
toggle_on_real_mob()
{
	hide_ents_by_targetname("fake_mob");
	show_ents_by_targetname("mob_brushmodel");
	show_ents_by_targetname("mob_models");
}

//Function Number: 36
toggle_all_boats_on_trigger()
{
	self waittill("trigger");
	toggle_all_boats_on();
}

//Function Number: 37
toggle_all_boats_on()
{
	var_00 = [];
	var_00[var_00.size] = getent("cargo_ship_2","targetname");
	var_00[var_00.size] = getent("cargo_ship","targetname");
	var_01 = getentarray("navy_ship_right","targetname");
	var_00 = common_scripts\utility::array_combine(var_00,var_01);
	var_01 = getentarray("navy_ship","targetname");
	var_00 = common_scripts\utility::array_combine(var_00,var_01);
	var_00[var_00.size] = getent("fake_mob","targetname");
	foreach(var_03 in var_00)
	{
		var_03 show();
	}
}

//Function Number: 38
toggle_all_boats_off()
{
	var_00 = [];
	var_00[var_00.size] = getent("cargo_ship_2","targetname");
	var_00[var_00.size] = getent("cargo_ship","targetname");
	var_01 = getentarray("navy_ship_right","targetname");
	var_00 = common_scripts\utility::array_combine(var_00,var_01);
	var_01 = getentarray("navy_ship","targetname");
	var_00 = common_scripts\utility::array_combine(var_00,var_01);
	var_00[var_00.size] = getent("fake_mob","targetname");
	foreach(var_03 in var_00)
	{
		var_03 hide();
	}
}

//Function Number: 39
toggle_boat_visibility()
{
	level thread toggle_boat_visibility_group("right");
	level thread toggle_boat_visibility_group("left");
}

//Function Number: 40
toggle_boat_visibility_group(param_00)
{
	level endon("stop_toggle_boat_visibility");
	var_01 = [];
	if(param_00 == "right")
	{
		var_02 = getentarray("trigger_toggle_cant_see_ships_right","targetname");
		var_01[var_01.size] = getent("cargo_ship_2","targetname");
		var_03 = getentarray("navy_ship_right","targetname");
		var_01 = common_scripts\utility::array_combine(var_01,var_03);
	}
	else if(var_02 == "left")
	{
		var_02 = getentarray("trigger_toggle_cant_see_ships_left","targetname");
		var_02[var_02.size] = getent("cargo_ship","targetname");
		var_03 = getentarray("navy_ship","targetname");
		var_01 = common_scripts\utility::array_combine(var_01,var_03);
	}
	else
	{
		return;
	}

	thread make_all_boats_visible(var_01);
	for(;;)
	{
		for(;;)
		{
			var_04 = 0;
			foreach(var_06 in var_02)
			{
				if(level.player istouching(var_06))
				{
					var_04 = 1;
					break;
				}
			}

			if(var_04 == 1)
			{
				break;
			}

			wait(0.05);
		}

		foreach(var_09 in var_01)
		{
			var_09 hide();
		}

		for(;;)
		{
			var_04 = 0;
			foreach(var_06 in var_02)
			{
				if(level.player istouching(var_06))
				{
					var_04 = 1;
					break;
				}
			}

			if(var_04 == 0)
			{
				break;
			}

			wait(0.05);
		}

		foreach(var_09 in var_01)
		{
			var_09 show();
		}

		wait(0.05);
	}
}

//Function Number: 41
make_all_boats_visible(param_00)
{
	level waittill("stop_toggle_boat_visibility");
	foreach(var_02 in param_00)
	{
		var_02 show();
	}
}

//Function Number: 42
show_water_intro()
{
	show_ents_by_targetname("ship_water_intro");
	hide_ents_by_targetname("ship_water_waves");
}

//Function Number: 43
show_water_final()
{
	hide_ents_by_targetname("ship_water_intro");
	show_ents_by_targetname("ship_water_waves");
}

//Function Number: 44
drone_lookat_ent(param_00,param_01,param_02,param_03)
{
	self notify("start_new_drone_lookat");
	self endon("start_new_drone_lookat");
	if(!isdefined(param_03))
	{
		param_03 = (0,0,0);
	}

	var_04 = getent(param_00,"targetname");
	var_05 = vectortoangles(var_04.origin - self.origin);
	if(!isdefined(param_01) || param_01 == 0)
	{
		self.angles = var_05;
	}
	else
	{
		self rotateto(var_05 + param_03,param_01,param_01 / 5,param_01 / 5);
		self waittill("rotatedone");
		self notify("drone_lookat_done");
	}

	if(isdefined(param_02) && param_02)
	{
		for(;;)
		{
			var_05 = vectortoangles(var_04.origin - self.origin) + param_03;
			self rotateto(var_05,0.05,0,0);
			wait(0.05);
		}
	}
}

//Function Number: 45
drone_moveto_ent(param_00,param_01)
{
	var_02 = getent(param_00,"targetname");
	self moveto(var_02.origin,param_01,param_01 / 5,param_01 / 5);
	self waittill("movedone");
	self notify("drone_moveto_done");
}

//Function Number: 46
drone_view_shake(param_00)
{
	self notify("start_new_intro_shake");
	self endon("start_new_intro_shake");
	for(;;)
	{
		if(common_scripts\utility::flag("flag_intro_transition_to_driving"))
		{
			break;
		}

		earthquake(param_00,0.1,level.player.origin,200);
		wait(0.1);
	}
}

//Function Number: 47
setup_move_player_pitbull(param_00)
{
	level.player_pitbull = maps\_vehicle::spawn_vehicle_from_targetname("player_pitbull");
	thread maps\_vehicle_traffic::add_script_car(level.player_pitbull);
	var_01 = getent(param_00,"targetname");
	level.player_pitbull vehicle_teleport(var_01.origin,var_01.angles);
}

//Function Number: 48
setup_move_friendly_pitbull(param_00)
{
	level.friendly_pitbull = maps\_vehicle::spawn_vehicle_from_targetname("friendly_pitbull");
	thread maps\_vehicle_traffic::add_script_car(level.friendly_pitbull);
	level.friendly_pitbull setup_start_vehicle_on_path(param_00);
}

//Function Number: 49
setup_move_chase_van(param_00)
{
	level.chase_van = maps\_vehicle::spawn_vehicle_from_targetname("chase_van");
	thread maps\_vehicle_traffic::add_script_car(level.chase_van);
	level.chase_van setup_start_vehicle_on_path(param_00);
}

//Function Number: 50
setup_start_vehicle_on_path(param_00)
{
	var_01 = getent(param_00,"targetname");
	self vehicle_teleport(var_01.origin,var_01.angles);
	var_02 = getvehiclenode(var_01.target,"targetname");
	thread maps\_vehicle_code::_vehicle_paths(var_02);
	self startpath(var_02);
}

//Function Number: 51
enable_pitbull_shooting()
{
	level.player_pitbull maps\_utility::ent_flag_set("pitbull_allow_shooting");
	level.friendly_pitbull maps\_utility::ent_flag_set("pitbull_allow_shooting");
}

//Function Number: 52
chase_van_set_close()
{
	self waittill("trigger");
	level.chase_van.lead_pos = "close";
}

//Function Number: 53
chase_van_set_medium()
{
	self waittill("trigger");
	level.chase_van.lead_pos = "medium";
}

//Function Number: 54
chase_van_set_far()
{
	self waittill("trigger");
	level.chase_van.lead_pos = "far";
}

//Function Number: 55
friendly_pitbull_shadow_chase_van()
{
	self waittill("trigger");
	level.friendly_pitbull.shadow_pos = "van";
}

//Function Number: 56
friendly_pitbull_shadow_player()
{
	self waittill("trigger");
	level.friendly_pitbull.shadow_pos = "player";
}

//Function Number: 57
wait_for_crash_at_end()
{
	self waittill("reached_end_node");
	self dodamage(1000000000,self.origin);
	playfxontag(level._effect["tanker_explosion"],self,"tag_origin");
	soundscripts\_snd::snd_message("car_chase_crash");
	wait(4);
	stopfxontag(level._effect["tanker_explosion"],self,"tag_origin");
}

//Function Number: 58
get_dist_to_end_in_miles(param_00)
{
	if(!isdefined(self.currentnode.target))
	{
		return 0;
	}

	var_01 = getvehiclenode(self.currentnode.target,"targetname");
	if(!isdefined(var_01))
	{
		return 0;
	}

	var_02 = 0;
	var_03 = self;
	for(;;)
	{
		var_02 = var_02 + distance(var_03.origin,var_01.origin);
		if(!isdefined(var_01.target))
		{
			if(isdefined(param_00))
			{
				return 0;
			}

			break;
		}

		if(isdefined(param_00) && isdefined(var_01.script_noteworthy) && var_01.script_noteworthy == param_00)
		{
			break;
		}

		var_03 = var_01;
		var_01 = getvehiclenode(var_01.target,"targetname");
		if(!isdefined(var_01))
		{
			break;
		}
	}

	return var_02 / 63360;
}

//Function Number: 59
get_vehicles_to_point_at_same_time(param_00,param_01,param_02,param_03,param_04)
{
	param_00 endon("death");
	param_02 endon("death");
	if(isdefined(param_04))
	{
		level endon(param_04);
	}

	for(;;)
	{
		var_05 = param_00 get_dist_to_end_in_miles(param_01);
		var_06 = param_02 get_dist_to_end_in_miles(param_03);
		var_07 = param_00 vehicle_getspeed();
		if(var_07 > 0)
		{
			var_08 = var_05 / var_07;
			if(var_08 > 0)
			{
				var_09 = var_06 / var_08;
			}
			else
			{
				var_09 = 50;
			}

			param_02 vehicle_setspeed(var_09,100,5);
		}

		wait(0.05);
	}
}

//Function Number: 60
vehicle_chase_target(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	self notify("one_vehicle_chase_target");
	self endon("one_vehicle_chase_target");
	level endon("flag_player_crashed");
	self endon("stop_chase_target");
	self endon("death");
	thread chase_cleanup_after_player_crash();
	self.oscillate_speed = 0;
	if(param_03 >= 0 && param_04 > 0)
	{
		thread vehicle_oscillate_location(param_03,param_04);
	}

	for(;;)
	{
		var_0A = param_00 vehicle_getspeed();
		var_0B = vectornormalize(anglestoforward(param_00.angles));
		var_0C = self.origin - param_00.origin;
		var_0D = vectordot(var_0B,var_0C) * var_0B;
		var_0E = length(var_0D);
		var_0F = vectornormalize(var_0C);
		var_10 = vectordot(var_0B,var_0F);
		if(var_10 < 0)
		{
			if(param_05)
			{
				var_0A = var_0A * 1.5;
			}
			else if(var_0E < param_01)
			{
				var_0A = var_0A * 0.8;
			}
			else if(var_0E > param_02 * 1.5)
			{
				var_0A = var_0A * 1.35;
			}
			else if(var_0E > param_02 * 1.2)
			{
				var_0A = var_0A * 1.2;
			}
			else if(var_0E > param_02)
			{
				var_0A = var_0A * 1.1;
			}
			else
			{
				var_0A = var_0A + self.oscillate_speed;
			}
		}
		else if(param_06)
		{
			var_0A = var_0A * 0.5;
		}
		else if(var_0E < param_01)
		{
			var_0A = var_0A * 1.2;
		}
		else if(var_0E > param_02 * 1.5)
		{
			var_0A = var_0A * 0.7;
		}
		else if(var_0E > param_02 * 1.2)
		{
			var_0A = var_0A * 0.85;
		}
		else if(var_0E > param_02)
		{
			var_0A = var_0A * 0.95;
		}
		else
		{
			var_0A = var_0A + self.oscillate_speed;
		}

		if(param_07 && isdefined(level.player_pitbull))
		{
			if(vectordot(level.player_pitbull.origin - self.origin,anglestoforward(self.angles)) > 0)
			{
				var_11 = maps\_vehicle_traffic::time_and_distance_of_closest_approach(self.origin,self vehicle_getvelocity(),level.player_pitbull.origin,level.player_pitbull vehicle_getvelocity(),0.1,234,0);
				var_12 = var_11[0];
				var_13 = var_11[1];
				if(var_12 < 2 && var_13 < 234)
				{
					var_0A = level.player_pitbull vehicle_getspeed() * 0.6;
				}
			}
		}

		if(param_08)
		{
			var_0A = clamp(var_0A,0,200);
		}
		else if(isdefined(param_09))
		{
			var_0A = clamp(var_0A,param_09,200);
		}
		else
		{
			var_0A = clamp(var_0A,20,200);
		}

		self vehicle_setspeed(var_0A,100,100);
		wait(0.05);
	}
}

//Function Number: 61
chase_cleanup_after_player_crash()
{
	self notify("one_chase_cleanup_after_player_crash");
	self endon("one_chase_cleanup_after_player_crash");
	self endon("stop_chase_target");
	self endon("death");
	common_scripts\utility::flag_wait("flag_player_crashed");
	wait(0.5);
	self resumespeed(100);
}

//Function Number: 62
vehicle_oscillate_location(param_00,param_01)
{
	self notify("one_vehicle_oscillate_location");
	self endon("one_vehicle_oscillate_location");
	level endon("flag_player_crashed");
	self endon("stop_chase_target");
	self endon("death");
	var_02 = gettime();
	param_01 = param_01 * 1000;
	for(;;)
	{
		var_03 = gettime() - var_02;
		var_04 = var_03 % param_01;
		var_04 = var_04 / param_01;
		var_04 = var_04 * 365;
		var_05 = param_00 * sin(var_04);
		self.oscillate_speed = var_05;
		wait(0.05);
	}
}

//Function Number: 63
jumping_take_down(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	var_01 = common_scripts\utility::array_randomize(var_01);
	var_02 = undefined;
	var_03 = undefined;
	var_04 = undefined;
	var_05 = [];
	foreach(var_07 in var_01)
	{
		var_03 = undefined;
		var_04 = undefined;
		var_08 = vectornormalize(anglestoforward(var_07.angles));
		var_09 = vectornormalize(-1 * anglestoright(var_07.angles));
		var_03 = get_closest_ai_to_origin(var_07.origin,"axis",0,150);
		if(!isdefined(var_03))
		{
			continue;
		}

		var_04 = get_closest_ai_to_origin(var_07.origin,"allies",350,800,0,20,var_09);
		if(isdefined(var_03) && isdefined(var_04))
		{
			var_02 = var_07;
			break;
		}
	}

	if(!isdefined(var_03) || !isdefined(var_04))
	{
		return 0;
	}

	var_05[0] = var_04;
	var_05[0].ignoreme = 1;
	var_05[0].ignoreall = 1;
	var_05[1] = var_03;
	var_05[1].ignoreme = 1;
	var_05[1].ignoreall = 1;
	var_0B[0] = "boost_jump_kick_02_atk";
	var_0B[1] = "boost_jump_kick_02_def";
	var_02 anim_reach_together_with_overrides(var_05,"boost_jump_kick_02",var_0B);
	if(isalive(var_05[0]) && isalive(var_05[1]))
	{
		var_02 thread maps\_anim::anim_single_solo(var_05[0],"boost_jump_kick_02",undefined,undefined,var_0B[0]);
		var_02 thread maps\_anim::anim_single_solo(var_05[1],"boost_jump_kick_02",undefined,undefined,var_0B[1]);
		var_02 waittill("boost_jump_kick_02");
		var_02 waittill("boost_jump_kick_02");
		var_03 kill_no_react();
		var_04 maps\_utility::enable_ai_color_dontmove();
	}

	var_05[0].ignoreme = 0;
	var_05[0].ignoreall = 0;
	return 1;
}

//Function Number: 64
lunging_take_down(param_00,param_01,param_02)
{
	var_03 = getnodearray(param_00,"targetname");
	var_03 = common_scripts\utility::array_randomize(var_03);
	var_04 = undefined;
	var_05 = undefined;
	var_06 = undefined;
	var_07 = [];
	foreach(var_09 in var_03)
	{
		var_05 = undefined;
		var_06 = undefined;
		var_0A = vectornormalize(anglestoforward(var_09.angles));
		var_0B = vectornormalize(-1 * anglestoright(var_09.angles));
		var_05 = get_closest_ai_to_origin(var_09.origin,"axis",0,150);
		if(!isdefined(var_05))
		{
			continue;
		}

		var_06 = get_closest_ai_to_origin(var_09.origin,"allies",450,900,0,20,var_0B);
		if(isdefined(var_05) && isdefined(var_06))
		{
			var_04 = var_09;
			break;
		}
	}

	if(isdefined(param_01))
	{
		var_06 = param_01;
	}

	if(isdefined(param_02))
	{
		var_05 = param_02;
	}

	if(!isdefined(var_05) || !isdefined(var_06))
	{
		return 0;
	}

	if(!isdefined(var_04))
	{
		var_04 = var_03[0];
	}

	var_07[0] = var_06;
	var_07[0].ignoreme = 1;
	var_07[0].ignoreall = 1;
	var_07[1] = var_05;
	var_07[1].ignoreme = 1;
	var_07[1].ignoreall = 1;
	var_0D[0] = "boost_jump_kick_01_atk";
	var_0D[1] = "boost_jump_kick_01_def";
	var_04 anim_reach_together_with_overrides(var_07,"boost_jump_kick_01",var_0D);
	if(isalive(var_07[0]) && isalive(var_07[1]))
	{
		var_04 thread maps\_anim::anim_single_solo(var_07[0],"boost_jump_kick_01",undefined,0.25,var_0D[0]);
		var_04 thread maps\_anim::anim_single_solo(var_07[1],"boost_jump_kick_01",undefined,undefined,var_0D[1]);
		var_04 waittill("boost_jump_kick_01");
		var_04 waittill("boost_jump_kick_01");
		var_05 kill_no_react();
		var_06 maps\_utility::enable_ai_color_dontmove();
	}

	var_07[0].ignoreme = 0;
	var_07[0].ignoreall = 0;
	return 1;
}

//Function Number: 65
get_closest_ai_to_origin(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	param_02 = validate_min_value(param_02,0);
	param_03 = validate_max_value(param_03,param_02,999999);
	param_04 = validate_min_value(param_04,0);
	param_05 = validate_max_value(param_05,param_04,180);
	var_07 = cos(param_04);
	var_08 = cos(param_05);
	var_09 = [];
	if(isdefined(param_01))
	{
		var_09 = getaiarray(param_01);
	}
	else
	{
		var_09 = getaiarray();
	}

	var_0A = undefined;
	var_0B = 99999;
	foreach(var_0D in var_09)
	{
		var_0E = distance(var_0D.origin,param_00);
		if(var_0E < param_02 || var_0E > param_03)
		{
			continue;
		}

		if(isdefined(param_06))
		{
			var_0F = vectornormalize(var_0D.origin - param_00);
			var_10 = vectordot(var_0F,param_06);
			if(var_10 < var_08 || var_10 > var_07)
			{
				continue;
			}
		}

		if(var_0E < var_0B)
		{
			var_0B = var_0E;
			var_0A = var_0D;
		}
	}

	return var_0A;
}

//Function Number: 66
validate_min_value(param_00,param_01)
{
	if(!isdefined(param_00) || param_00 < param_01)
	{
		return param_01;
	}

	return param_00;
}

//Function Number: 67
validate_max_value(param_00,param_01,param_02)
{
	if(isdefined(param_00) && param_00 < param_01)
	{
		return param_01;
	}
	else if(!isdefined(param_00))
	{
		return param_02;
	}

	return param_00;
}

//Function Number: 68
kill_no_react()
{
	if(!isalive(self))
	{
		return;
	}

	self.allowdeath = 1;
	self.a.nodeath = 1;
	thread maps\_utility::set_battlechatter(0);
	self kill();
}

//Function Number: 69
anim_reach_together_with_overrides(param_00,param_01,param_02)
{
	thread maps\_anim::modify_moveplaybackrate_together(param_00);
	var_03 = self.origin;
	var_04 = self.angles;
	var_05 = spawnstruct();
	var_06 = 0;
	for(var_07 = 0;var_07 < param_00.size;var_07++)
	{
		if(isdefined(level.scr_anim[param_02[var_07]][param_01]))
		{
			if(isarray(level.scr_anim[param_02[var_07]][param_01]))
			{
				var_08 = getstartorigin(var_03,var_04,level.scr_anim[param_02[var_07]][param_01][0]);
			}
			else
			{
				var_08 = getstartorigin(var_03,var_04,level.scr_anim[param_02[var_07]][param_01]);
			}
		}
		else
		{
			var_08 = var_03;
		}

		var_06++;
		param_00[var_07] thread maps\_anim::begin_anim_reach(var_05,var_08,::maps\_anim::reach_with_standard_adjustments_begin,::maps\_anim::reach_with_standard_adjustments_end);
	}

	while(var_06)
	{
		var_05 waittill("reach_notify");
		var_06--;
	}

	foreach(var_0A in param_00)
	{
		if(!isalive(var_0A))
		{
			continue;
		}

		var_0A.goalradius = var_0A.oldgoalradius;
		var_0A.scriptedarrivalent = undefined;
		var_0A.stopanimdistsq = 0;
	}
}

//Function Number: 70
open_car_doors()
{
	common_scripts\utility::run_thread_on_noteworthy("door_open_compact_both",::open_car_door,"compact","open_door_both");
	common_scripts\utility::run_thread_on_noteworthy("door_open_compact_left",::open_car_door,"compact","open_door_left");
	common_scripts\utility::run_thread_on_noteworthy("door_open_compact_right",::open_car_door,"compact","open_door_right");
	common_scripts\utility::run_thread_on_noteworthy("door_open_truck_both",::open_car_door,"truck","open_door_both");
	common_scripts\utility::run_thread_on_noteworthy("door_open_truck_left",::open_car_door,"truck","open_door_left");
	common_scripts\utility::run_thread_on_noteworthy("door_open_truck_right",::open_car_door,"truck","open_door_right");
	common_scripts\utility::run_thread_on_noteworthy("door_open_atlas_suv_both",::open_car_door,"atlas_suv","open_door_both");
	common_scripts\utility::run_thread_on_noteworthy("door_open_atlas_suv_left",::open_car_door,"atlas_suv","open_door_left");
	common_scripts\utility::run_thread_on_noteworthy("door_open_atlas_suv_right",::open_car_door,"atlas_suv","open_door_right");
	common_scripts\utility::run_thread_on_noteworthy("door_open_sedan_both",::open_car_door,"sedan","open_door_both");
	common_scripts\utility::run_thread_on_noteworthy("door_open_sedan_left",::open_car_door,"sedan","open_door_left");
	common_scripts\utility::run_thread_on_noteworthy("door_open_sedan_right",::open_car_door,"sedan","open_door_right");
}

//Function Number: 71
open_car_door(param_00,param_01)
{
	if(self.classname != "script_model")
	{
		return;
	}

	self.animname = param_00;
	self useanimtree(#animtree);
	self setanim(maps\_utility::getanim(param_01));
}

//Function Number: 72
container_death_anims()
{
	self.specialdeathfunc = ::use_container_death;
}

//Function Number: 73
use_container_death()
{
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "container_death")
	{
		self.deathanim = maps\_utility::getgenericanim("container_death");
		animscripts\death::playdeathanim(self.deathanim);
		return 1;
	}

	return 0;
}

//Function Number: 74
balcony_death_anims()
{
	self.animname = "generic";
	self.deathfunction = ::try_balcony_death;
}

//Function Number: 75
try_balcony_death()
{
	if(!isdefined(self))
	{
		return 0;
	}

	if(self.a.pose == "prone")
	{
		return 0;
	}

	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "container_death")
	{
		self.deathanim = maps\_utility::getgenericanim("container_death");
		return 0;
	}

	if(isdefined(self.prevnode))
	{
		if(isdefined(self.prevnode.script_balcony))
		{
			var_00 = self.angles[1];
			if(var_00 > 180)
			{
				var_00 = var_00 - 360;
			}

			var_01 = self.prevnode.angles[1];
			if(var_01 > 180)
			{
				var_01 = var_01 - 360;
			}

			var_02 = abs(var_00 - var_01);
			if(var_02 > 90)
			{
				return 0;
			}

			var_03 = distance(self.origin,self.prevnode.origin);
			if(var_03 > 92)
			{
				return 0;
			}
		}
		else
		{
			return 0;
		}
	}
	else
	{
		return 0;
	}

	if(!isdefined(level.last_balcony_death))
	{
		level.last_balcony_death = -4000;
	}

	var_04 = gettime() - level.last_balcony_death;
	if(var_04 < 2000)
	{
		return 0;
	}

	var_05 = maps\_utility::getgenericanim("balcony_death");
	self.deathanim = var_05[randomint(var_05.size)];
	return 0;
}

//Function Number: 76
temp_subtitle(param_00,param_01,param_02)
{
	var_03 = newhudelem();
	var_03.x = 0;
	var_03.y = -42;
	var_03 settext(param_00);
	var_03.fontscale = 1.46;
	var_03.alignx = "center";
	var_03.aligny = "middle";
	var_03.horzalign = "center";
	var_03.vertalign = "bottom";
	var_03.sort = 1;
	wait(param_01);
	var_03 destroy();
}

//Function Number: 77
init_bobbing_boats()
{
	level.bobbing_objects = [];
	var_00 = maps\_bobbing_boats::createdefaultbobsettings();
	var_01 = getentarray("bobbing_ship","script_noteworthy");
	maps\_bobbing_boats::prep_bobbing(var_01,::maps\_bobbing_boats::bobbingobject,var_00,0);
	level.bobbing_objects = maps\_shg_utility::array_combine_unique(level.bobbing_objects,var_01);
	var_02 = maps\_bobbing_boats::createdefaultbobsettings();
	var_02.max_pitch = 1;
	var_03 = getentarray("bobbing_ship_big","script_noteworthy");
	maps\_bobbing_boats::prep_bobbing(var_03,::maps\_bobbing_boats::bobbingobject,var_02,0);
	level.bobbing_objects = maps\_shg_utility::array_combine_unique(level.bobbing_objects,var_03);
	maps\_bobbing_boats::start_bobbing(level.bobbing_objects);
}

//Function Number: 78
intro_drive_hint()
{
	common_scripts\utility::flag_wait("flag_intro_give_player_driving");
	maps\_utility::hintdisplayhandler("drive_hint");
	var_00 = gettime();
	while(gettime() < var_00 + 4000)
	{
		if(level.player_pitbull.veh_speed > 5)
		{
			break;
		}

		if(level.player buttonpressed("BUTTON_B"))
		{
			break;
		}

		level.player_pitbull vehphys_setspeed(35);
		wait(0.05);
	}
}

//Function Number: 79
player_is_driving()
{
	if(common_scripts\utility::flag("missionfailed"))
	{
		return 1;
	}

	if(level.player_pitbull.veh_speed > 50)
	{
		return 1;
	}

	return 0;
}

//Function Number: 80
intro_shoot_hint()
{
	maps\_utility::hintdisplayhandler("shoot_hint");
}

//Function Number: 81
player_is_shooting()
{
	if(common_scripts\utility::flag("missionfailed"))
	{
		return 1;
	}

	if(common_scripts\utility::flag("flag_final_crash_scene_playing"))
	{
		return 1;
	}

	if(common_scripts\utility::flag("flag_reverse_hint_displayed"))
	{
		return 1;
	}

	if(!level.console && !level.player common_scripts\utility::is_player_gamepad_enabled() && level.player attackbuttonpressed())
	{
		common_scripts\utility::flag_set("flag_player_has_shot_pitbull");
		return 1;
	}
	else if(level.player common_scripts\utility::is_player_gamepad_enabled() && level.player adsbuttonpressed())
	{
		common_scripts\utility::flag_set("flag_player_has_shot_pitbull");
		return 1;
	}

	return 0;
}

//Function Number: 82
boost_jump_hint()
{
	maps\_utility::display_hint("boost_hint");
}

//Function Number: 83
player_has_jumped()
{
	if(common_scripts\utility::flag("missionfailed"))
	{
		return 1;
	}

	if(level.player jumpbuttonpressed())
	{
		return 1;
	}

	return 0;
}

//Function Number: 84
player_too_far_hint()
{
	if(common_scripts\utility::flag("flag_hint_player_too_far"))
	{
		return;
	}

	common_scripts\utility::flag_set("flag_hint_player_too_far");
	maps\_utility::hintdisplayhandler("too_far_hint");
}

//Function Number: 85
player_has_caught_up()
{
	if(common_scripts\utility::flag("missionfailed"))
	{
		return 1;
	}

	if(common_scripts\utility::flag("flag_hint_player_too_far"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 86
player_left_road_hint()
{
	if(common_scripts\utility::flag("flag_hint_player_left_road"))
	{
		return;
	}

	common_scripts\utility::flag_set("flag_hint_player_left_road");
	maps\_utility::hintdisplayhandler("left_road_hint");
}

//Function Number: 87
player_has_returned_to_road()
{
	if(common_scripts\utility::flag("missionfailed"))
	{
		return 1;
	}

	if(common_scripts\utility::flag("flag_hint_player_left_road"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 88
player_left_squad_hint()
{
	if(common_scripts\utility::flag("flag_hint_player_left_squad"))
	{
		return;
	}

	common_scripts\utility::flag_set("flag_hint_player_left_squad");
	maps\_utility::display_hint("left_squad_hint");
}

//Function Number: 89
player_has_returned_to_squad()
{
	if(common_scripts\utility::flag("missionfailed"))
	{
		return 1;
	}

	if(common_scripts\utility::flag("flag_hint_player_left_squad"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 90
start_civilian_group(param_00,param_01)
{
	if(isdefined(param_01))
	{
		wait(param_01);
	}

	if(!isdefined(level.civilian_group))
	{
		level.civilian_group = [];
	}

	var_02 = getentarray(param_00,"targetname");
	maps\_utility::array_spawn_function_targetname(param_00,::civilian_drone_setup);
	level.aud.bridge_civs = [];
	common_scripts\utility::array_thread(var_02,::maps\_utility::spawn_ai);
	soundscripts\_snd::snd_message("panic_walla",param_00);
}

//Function Number: 91
civilian_drone_setup()
{
	self endon("death");
	self endon("delete");
	level.aud.bridge_civs[level.aud.bridge_civs.size] = self;
	self.goalradius = 32;
	self.ignoreall = 1;
	self.ignoreme = 1;
	self.animname = "drone";
	self.drone_move_callback = ::civilian_drone_run_override;
	level.civilian_group[level.civilian_group.size] = self;
	thread civilian_drone_runner_collision();
	soundscripts\_snd::snd_message("panic_walla_oneshots",self);
	self waittill("goal");
	self stopanimscripted();
	self notify("drone_stop");
	self notify("stop_loop");
	self notify("single anim","end");
	self notify("looping anim","end");
	thread maps\_anim::anim_loop_solo(self,"civilian_cower");
	for(;;)
	{
		wait(0.5);
		if(distance(level.player.origin,self.origin) > 1000)
		{
			if(!maps\_utility::player_looking_at(self.origin,undefined,1))
			{
				break;
			}
		}
	}

	self delete();
}

//Function Number: 92
street_civilian_clean_up()
{
	if(isdefined(level.civilian_group))
	{
		maps\_utility::ai_delete_when_out_of_sight(level.civilian_group,200);
		level.civilian_group = common_scripts\utility::array_removeundefined(level.civilian_group);
	}
}

//Function Number: 93
civilian_drone_run_override()
{
	var_00 = undefined;
	if(!isdefined(self.drone_run_number))
	{
		self.drone_run_number = randomintrange(1,8);
	}

	if(!isdefined(self.drone_move_time))
	{
		self.drone_move_time = -1000;
	}

	if(gettime() > self.drone_move_time)
	{
		var_00 = spawnstruct();
		var_01 = level.scr_anim["drone"]["run_0" + self.drone_run_number];
		if(isarray(var_01))
		{
			var_01 = common_scripts\utility::array_randomize(var_01);
			var_00.runanim = var_01[0];
		}
		else
		{
			var_00.runanim = var_01;
		}

		var_02 = maps\_drone::get_anim_data(var_00.runanim);
		var_00.anim_relative = var_02.anim_relative;
		var_00.run_speed = var_02.run_speed;
		self.drone_move_time = gettime() + var_02.anim_time / self.moveplaybackrate * 1000;
	}

	return var_00;
}

//Function Number: 94
civilian_drone_runner_collision()
{
	self endon("goal");
	self endon("death");
	while(isdefined(self))
	{
		while(distance(self.origin,level.player.origin) > 100)
		{
			wait(0.1);
		}

		var_00 = self setcontents(0);
		while(distance(self.origin,level.player.origin) <= 100)
		{
			wait(0.1);
		}

		self setcontents(var_00);
	}
}

//Function Number: 95
civilian_get_out_of_car_setup(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = get_civilian_car(param_00);
	var_06 = get_civilian(param_01,var_05["model"].animname);
	level thread civilian_in_car_get_out(var_05,var_06,param_02,param_03,param_04);
}

//Function Number: 96
get_civilian_car(param_00)
{
	var_01 = getentarray(param_00,"targetname");
	var_02 = [];
	foreach(var_04 in var_01)
	{
		if(var_04.classname == "script_model")
		{
			var_02["model"] = var_04;
			continue;
		}

		if(var_04.classname == "script_brushmodel")
		{
			if(isdefined(var_04.script_noteworthy) && var_04.script_noteworthy == "door_open_col")
			{
				var_02["door"] = var_04;
				var_02["door"] notsolid();
				var_02["door"] connectpaths();
			}
			else
			{
				var_02["col"] = var_04;
			}

			continue;
		}
	}

	if(issubstr(var_02["model"].model,"sedan"))
	{
		var_02["model"].animname = "sedan";
		var_02["model"] useanimtree(#animtree);
	}
	else if(issubstr(var_02["model"].model,"compact") || issubstr(var_02["model"].model,"economy"))
	{
		var_02["model"].animname = "compact";
		var_02["model"] useanimtree(#animtree);
	}
	else if(issubstr(var_02["model"].model,"truck"))
	{
		var_02["model"].animname = "truck";
		var_02["model"] useanimtree(#animtree);
	}

	return var_02;
}

//Function Number: 97
get_civilian(param_00,param_01)
{
	var_02 = [];
	var_03 = getent(param_00,"targetname");
	var_02["ai"] = var_03 maps\_utility::spawn_ai(1,0);
	var_02["ai"].ignoresonicaoe = 1;
	level.civilian_group[level.civilian_group.size] = var_02["ai"];
	var_02["ai"].ignoreall = 1;
	var_02["ai"].animname = param_01 + "_driver";
	if(isdefined(var_03.target))
	{
		var_02["goal"] = getnode(var_03.target,"targetname");
	}

	return var_02;
}

//Function Number: 98
civilian_in_car_get_out(param_00,param_01,param_02,param_03,param_04)
{
	level.player endon("death");
	if(!isdefined(level.last_car_exit_index))
	{
		level.last_car_exit_index = -1;
	}

	var_05 = undefined;
	if(isdefined(param_04))
	{
		var_05 = param_04;
		level.last_car_exit_index = var_05;
	}
	else
	{
		for(;;)
		{
			if(isdefined(param_03) && param_03 == 1)
			{
				var_05 = randomintrange(4,8);
			}
			else
			{
				var_05 = randomintrange(1,4);
			}

			if(var_05 != level.last_car_exit_index)
			{
				level.last_car_exit_index = var_05;
				break;
			}
		}
	}

	param_00["model"] thread maps\_anim::anim_loop_solo(param_01["ai"],"loop_0" + var_05,"stop_driver_loop","tag_driver");
	level waittill(param_02);
	wait(randomfloatrange(0,2));
	param_01["ai"] maps\_utility::set_run_anim("run_0" + var_05,1);
	param_01["ai"].run_override_weights = undefined;
	param_00["model"] notify("stop_driver_loop");
	param_00["model"] thread maps\_anim::anim_single_solo(param_00["model"],"get_out_0" + var_05);
	param_00["model"] maps\_anim::anim_single_solo_run(param_01["ai"],"get_out_0" + var_05,"tag_driver");
	param_01["ai"].ignoresonicaoe = 0;
	param_01["ai"] thread maps\_spawner::go_to_node(param_01["goal"]);
	soundscripts\_snd::snd_message("panic_walla_oneshots",param_01["ai"]);
	param_01["ai"] thread cower_cleanup_civs_on_goal();
	for(;;)
	{
		var_06 = 0;
		if(level.player istouching(param_00["door"]))
		{
			var_06 = 1;
		}

		var_07 = getaiarray();
		foreach(param_01 in var_07)
		{
			if(isalive(param_01) && param_01 istouching(param_00["door"]))
			{
				var_06 = 1;
			}
		}

		if(!var_06)
		{
			break;
		}

		wait(1);
	}

	param_00["door"] disconnectpaths();
	param_00["door"] solid();
}

//Function Number: 99
cleanup_on_goal()
{
	self waittill("goal");
	self delete();
}

//Function Number: 100
cower_cleanup_civs_on_goal()
{
	self waittill("goal");
	self stopanimscripted();
	self notify("drone_stop");
	self notify("stop_loop");
	self notify("single anim","end");
	self notify("looping anim","end");
	thread maps\_anim::anim_loop_solo(self,"civilian_cower");
	for(;;)
	{
		wait(0.5);
		if(distance(level.player.origin,self.origin) > 1000)
		{
			if(!maps\_utility::player_looking_at(self.origin,undefined,1))
			{
				break;
			}
		}
	}

	self delete();
}

//Function Number: 101
civilian_loop_setup(param_00,param_01,param_02)
{
	var_03 = [];
	var_04 = getent(param_00,"targetname");
	var_03[0] = var_04 maps\_utility::spawn_ai(1,0);
	if(!isdefined(var_03[0]))
	{
		return;
	}

	var_03[0].animname = "civilian";
	var_03[0].ignoreall = 1;
	if(isdefined(param_01))
	{
		var_05 = getent(param_01,"targetname");
		var_03[1] = var_05 maps\_utility::spawn_ai(1,0);
		if(!isdefined(var_03[1]))
		{
			var_03[0].script_noteworthy = "seated";
		}
		else
		{
			var_03[1].animname = "civilian_b";
			var_03[1].ignoreall = 1;
		}
	}

	level thread start_civilian_loop_anims(var_03,param_02);
	if(isdefined(var_04.target))
	{
		var_03[0] thread civilian_loop_vo_trigger(var_04);
	}

	foreach(var_07 in var_03)
	{
		var_07 thread no_civilian_friendly_fire_until_seen();
	}
}

//Function Number: 102
no_civilian_friendly_fire_until_seen()
{
	self endon("death");
	self.no_friendly_fire_penalty = 1;
	var_00 = 0.05;
	if(level.currentgen)
	{
		var_00 = 1;
	}

	for(;;)
	{
		if(maps\_utility::player_can_see_ai(self))
		{
			break;
		}

		if(player_can_see_civ(self))
		{
			break;
		}

		wait(var_00);
	}

	self.no_friendly_fire_penalty = undefined;
}

//Function Number: 103
player_can_see_civ(param_00)
{
	if(!common_scripts\utility::within_fov(level.player.origin,level.player.angles,param_00.origin,0.743))
	{
		return 0;
	}

	var_01 = level.player geteye();
	var_02 = undefined;
	for(var_03 = 0;var_03 < 2;var_03++)
	{
		var_04 = param_00.origin;
		var_05 = param_00 geteye();
		var_06 = var_05 + var_04 * 0.5;
		var_07 = bullettrace(var_01,var_06,0,var_02);
		if(var_07["fraction"] < 0.99)
		{
			if(isdefined(var_07["entity"]) && isai(var_07["entity"]) && var_07["entity"] != param_00)
			{
				var_02 = var_07["entity"];
			}
		}
		else
		{
			return 1;
		}

		if(!isdefined(var_02))
		{
			break;
		}
	}

	return 0;
}

//Function Number: 104
start_civilian_loop_anims(param_00,param_01)
{
	wait(randomfloatrange(0,1));
	if(isalive(param_00[0]))
	{
		param_00[0] maps\_utility::magic_bullet_shield();
		param_00[0] thread civ_damage_check();
	}

	if(isalive(param_00[1]))
	{
		param_00[1] maps\_utility::magic_bullet_shield();
		param_00[1] thread civ_damage_check();
	}

	if(isalive(param_00[0]) && !isalive(param_00[1]))
	{
		if(param_00[0].script_noteworthy == "paired")
		{
			param_00[0].script_noteworthy = "seated";
		}
	}
	else if(!isalive(param_00[0]) && isalive(param_00[1]))
	{
		param_00[0] = param_00[1];
		param_00[1] = undefined;
		param_00[0].script_noteworthy = "seated";
	}
	else if(!isalive(param_00[0]) && !isalive(param_00[1]))
	{
		return;
	}

	if(!isdefined(param_00[0].script_noteworthy))
	{
		return;
	}

	if(param_00[0].script_noteworthy == "laying")
	{
		if(randomint(100) < 50)
		{
			var_02 = "laying_1";
		}
		else
		{
			var_02 = "laying_2";
		}

		param_00[0] thread maps\_anim::anim_loop_solo(param_00[0],var_02,param_01);
	}
	else if(param_00[0].script_noteworthy == "seated")
	{
		var_03 = randomint(100);
		if(var_03 < 33)
		{
			var_02 = "seated_1";
		}
		else if(var_02 < 66)
		{
			var_02 = "seated_2";
		}
		else
		{
			var_02 = "seated_3";
		}

		param_00[0] thread maps\_anim::anim_loop_solo(param_00[0],var_02,param_01);
	}
	else if(param_00[0].script_noteworthy == "paired")
	{
		if(randomint(100) < 50)
		{
			var_02 = "paired_1";
		}
		else
		{
			var_02 = "paired_2";
		}

		param_00[0] thread maps\_anim::anim_loop(param_00,var_02,param_01);
	}
	else
	{
	}

	level thread civilian_clean_up(param_00,param_01);
}

//Function Number: 105
civ_damage_check()
{
	self endon("death");
	self waittill("damage",var_00,var_01,var_02,var_03,var_04);
	if(isplayer(var_01))
	{
		if(isdefined(self.magic_bullet_shield))
		{
			maps\_utility::stop_magic_bullet_shield();
		}

		self startragdoll();
	}
}

//Function Number: 106
civilian_loop_vo_trigger(param_00)
{
	self endon("death");
	var_01 = getent(param_00.target,"targetname");
	var_01 endon("death");
	if(isdefined(var_01))
	{
		for(;;)
		{
			var_01 waittill("trigger",var_02);
			if(var_02 == level.player)
			{
				maps\sanfran_vo::play_civilian_dialog(self);
				return;
			}
		}
	}
}

//Function Number: 107
civilian_clean_up(param_00,param_01)
{
	level waittill(param_01);
	wait(1);
	foreach(var_03 in param_00)
	{
		if(isalive(var_03))
		{
			if(isdefined(var_03.magic_bullet_shield))
			{
				var_03 maps\_utility::stop_magic_bullet_shield();
				var_03 notify(param_01);
				var_03 delete();
				continue;
			}

			var_03 notify(param_01);
			var_03 delete();
		}
	}
}

//Function Number: 108
add_spawn_behavior(param_00,param_01,param_02,param_03,param_04,param_05)
{
	foreach(var_07 in self.spawn_functions)
	{
		var_08 = 1;
		if(var_07["function"] != param_00)
		{
			var_08 = 0;
		}
		else
		{
			if(isdefined(var_07["param1"]))
			{
				if(!isdefined(param_01))
				{
					var_08 = 0;
				}
				else if(var_07["param1"] != param_01)
				{
					var_08 = 0;
				}
			}
			else if(isdefined(param_01))
			{
				var_08 = 0;
			}

			if(isdefined(var_07["param2"]))
			{
				if(!isdefined(param_02))
				{
					var_08 = 0;
				}
				else if(var_07["param2"] != param_02)
				{
					var_08 = 0;
				}
			}
			else if(isdefined(param_02))
			{
				var_08 = 0;
			}

			if(isdefined(var_07["param3"]))
			{
				if(!isdefined(param_03))
				{
					var_08 = 0;
				}
				else if(var_07["param3"] != param_03)
				{
					var_08 = 0;
				}
			}
			else if(isdefined(param_03))
			{
				var_08 = 0;
			}

			if(isdefined(var_07["param4"]))
			{
				if(!isdefined(param_04))
				{
					var_08 = 0;
				}
				else if(var_07["param4"] != param_04)
				{
					var_08 = 0;
				}
			}
			else if(isdefined(param_04))
			{
				var_08 = 0;
			}

			if(isdefined(var_07["param5"]))
			{
				if(!isdefined(param_05))
				{
					var_08 = 0;
				}
				else if(var_07["param5"] != param_05)
				{
					var_08 = 0;
				}
			}
			else if(isdefined(param_05))
			{
				var_08 = 0;
			}
		}

		if(var_08 == 1)
		{
			return;
		}
	}

	var_0A = [];
	var_0A["function"] = param_00;
	var_0A["param1"] = param_01;
	var_0A["param2"] = param_02;
	var_0A["param3"] = param_03;
	var_0A["param4"] = param_04;
	var_0A["param5"] = param_05;
	self.spawn_functions[self.spawn_functions.size] = var_0A;
}

//Function Number: 109
ai_run_behavior_until_condition(param_00,param_01,param_02)
{
	self endon("death");
	if(isdefined(param_00))
	{
		[[ param_00 ]](self);
	}

	if(isdefined(param_02))
	{
		[[ param_02 ]](self);
	}

	if(isdefined(param_01))
	{
		[[ param_01 ]](self);
	}
}

//Function Number: 110
ai_cond_reached_goal(param_00)
{
	param_00 endon("death");
	param_00 waittill("goal");
}

//Function Number: 111
ai_cond_reached_path_end(param_00)
{
	param_00 endon("death");
	param_00 waittill("reached_path_end");
}

//Function Number: 112
ai_cond_player_at_police_battle(param_00)
{
	param_00 endon("death");
	common_scripts\utility::flag_wait("flag_player_at_police_battle");
}

//Function Number: 113
ai_cond_player_at_tanker_battle(param_00)
{
	param_00 endon("death");
	common_scripts\utility::flag_wait("flag_player_at_tanker_battle");
}

//Function Number: 114
ai_cond_player_at_ambient_battle(param_00)
{
	param_00 endon("death");
	common_scripts\utility::flag_wait("flag_player_at_ambient_battle");
}

//Function Number: 115
ai_cond_player_at_pitbull_battle(param_00)
{
	param_00 endon("death");
	common_scripts\utility::flag_wait("flag_player_at_pitbull_battle");
	if(param_00 == level.bravo)
	{
		param_00 waittill("dialog_done");
	}
}

//Function Number: 116
ai_cond_player_at_escape_battle(param_00)
{
	param_00 endon("death");
	common_scripts\utility::flag_wait("flag_player_at_escape_battle");
}

//Function Number: 117
ai_cond_player_at_standoff_battle(param_00)
{
	param_00 endon("death");
	common_scripts\utility::flag_wait("flag_player_at_standoff_battle");
}

//Function Number: 118
ai_cond_player_at_standoff_battle_or_danger_zone(param_00)
{
	param_00 endon("death");
	common_scripts\utility::flag_wait_either("flag_player_at_standoff_battle","railing_danger_zone_touching");
}

//Function Number: 119
ai_cond_player_at_van(param_00)
{
	param_00 endon("death");
	common_scripts\utility::flag_wait("flag_van_explosion_deploy");
}

//Function Number: 120
ai_empty(param_00)
{
}

//Function Number: 121
ai_start_magic_bullet_shield(param_00)
{
	param_00 maps\_utility::magic_bullet_shield();
}

//Function Number: 122
ai_end_magic_bullet_shield(param_00)
{
	if(isdefined(param_00.magic_bullet_shield) && param_00.magic_bullet_shield == 1)
	{
		param_00 maps\_utility::stop_magic_bullet_shield();
	}
}

//Function Number: 123
ai_start_ignore_all(param_00)
{
	param_00.ignoreall = 1;
}

//Function Number: 124
ai_end_ignore_all(param_00)
{
	param_00.ignoreall = 0;
}

//Function Number: 125
ai_start_ignore_me(param_00)
{
	param_00.ignoreme = 1;
}

//Function Number: 126
ai_end_ignore_me(param_00)
{
	param_00.ignoreme = 0;
}

//Function Number: 127
ai_start_pacifist(param_00)
{
	param_00.pacifist = 1;
}

//Function Number: 128
ai_end_fixed_node(param_00)
{
	param_00.fixednode = 0;
}

//Function Number: 129
ai_delete_self(param_00)
{
	if(isdefined(param_00.magic_bullet_shield) && param_00.magic_bullet_shield == 1)
	{
		param_00 maps\_utility::stop_magic_bullet_shield();
	}

	wait(0.1);
	param_00 delete();
}

//Function Number: 130
ai_shot_by_player_team_notify()
{
	self endon("death");
	level endon("ai_shot_by_player_team");
	for(;;)
	{
		self waittill("damage",var_00,var_01);
		if(var_01 == level.player)
		{
			break;
		}

		if(common_scripts\utility::array_contains(level.heroes,var_01))
		{
			break;
		}
	}

	level notify("ai_shot_by_player_team");
}

//Function Number: 131
get_single_living_ent(param_00,param_01)
{
	var_02 = getentarray(param_00,param_01);
	if(!isdefined(var_02))
	{
		return undefined;
	}

	var_03 = undefined;
	foreach(var_05 in var_02)
	{
		if(!isalive(var_05))
		{
			continue;
		}

		var_03 = var_05;
	}

	return var_03;
}

//Function Number: 132
ai_start_balcony_death(param_00)
{
	param_00 notify("stop_death_function");
	param_00 balcony_death_anims();
}

//Function Number: 133
ai_start_respawn_death(param_00)
{
	param_00 notify("stop_death_function");
	if(!isdefined(param_00.spawner))
	{
		return;
	}

	param_00.respawn_spawner = param_00.spawner;
	if(!weaponclass(param_00.weapon) == "rocketlauncher")
	{
		param_00.deathfunction = ::try_respawn_death;
		return;
	}

	param_00 thread wait_till_death_try_respawn_death();
}

//Function Number: 134
ai_stop_death_function(param_00)
{
	param_00.deathfunction = undefined;
	param_00 notify("stop_death_function");
}

//Function Number: 135
wait_till_death_try_respawn_death()
{
	self endon("stop_death_function");
	self waittill("death");
	try_respawn_death();
}

//Function Number: 136
try_respawn_death()
{
	if(!isdefined(self.respawn_spawner))
	{
		return;
	}

	self.respawn_spawner.count++;
	if(isdefined(self.respawn_spawner.script_aigroup))
	{
		self.respawn_spawner thread maps\_spawner::aigroup_spawnerthink(level._ai_group[self.respawn_spawner.script_aigroup]);
	}

	level thread respawn_death_spawn(self.respawn_spawner);
	return 0;
}

//Function Number: 137
respawn_death_spawn(param_00)
{
	wait(randomfloatrange(2,6));
	param_00 maps\_utility::spawn_ai(1,0);
}

//Function Number: 138
ai_add_player_only_damage(param_00)
{
	param_00 maps\_utility::add_damage_function(::ai_player_only_damage_func);
}

//Function Number: 139
ai_remove_player_only_damage(param_00)
{
	param_00 maps\_utility::remove_damage_function(::ai_player_only_damage_func);
}

//Function Number: 140
ai_player_only_damage_func(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isplayer(param_01))
	{
		if(isdefined(param_01) && param_01.classname == "trigger_hurt")
		{
			return;
		}

		self.health = self.health + param_00;
	}
}

//Function Number: 141
ai_add_twenty_percent_damage(param_00)
{
	param_00 maps\_utility::add_damage_function(::ai_twenty_percent_damage_func);
}

//Function Number: 142
ai_remove_twenty_percent_damage(param_00)
{
	param_00 maps\_utility::remove_damage_function(::ai_twenty_percent_damage_func);
}

//Function Number: 143
ai_twenty_percent_damage_func(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isplayer(param_01))
	{
		if(isdefined(param_01) && param_01.classname == "trigger_hurt")
		{
			return;
		}

		var_07 = int(param_00 * 0.8);
		if(self.health + var_07 > 0)
		{
			self.health = self.health + var_07;
		}
	}
}

//Function Number: 144
notify_drones_all_dead(param_00,param_01)
{
	for(;;)
	{
		var_02 = 0;
		foreach(var_04 in param_00)
		{
			if(isalive(var_04))
			{
				var_02 = 1;
			}
		}

		if(!var_02)
		{
			break;
		}

		wait(0.05);
	}

	common_scripts\utility::flag_set(param_01);
}

//Function Number: 145
heli_shoot_enemies()
{
	self endon("death");
	var_00 = heli_get_shooters();
	foreach(var_02 in var_00)
	{
		var_03 = spawn("script_model",(0,0,0));
		var_03 setmodel("tag_laser");
		var_03.origin = var_02 gettagorigin("tag_flash");
		var_03.angles = var_02 gettagangles("tag_flash");
		var_03 laseron();
		var_02.fake_laser = var_03;
		var_02 thread delete_laser_on_death();
		var_02 thread force_fake_laser_origin_link();
		thread heli_shoot_enemy_trace_then_fire(var_02);
	}
}

//Function Number: 146
force_fake_laser_origin_link()
{
	self endon("death");
	for(;;)
	{
		self.fake_laser.origin = self gettagorigin("tag_flash");
		wait(0.05);
	}
}

//Function Number: 147
delete_laser_on_death()
{
	self waittill("death");
	self.fake_laser delete();
}

//Function Number: 148
heli_shoot_enemy_trace_then_fire(param_00)
{
	self endon("death");
	for(;;)
	{
		wait(0.05);
		var_01 = getaiarray("axis");
		if(var_01.size <= 0)
		{
			continue;
		}

		var_01 = common_scripts\utility::array_randomize(var_01);
		var_02 = 0;
		if(randomint(100) < 25)
		{
			var_02 = 1;
		}

		var_03 = undefined;
		if(var_02)
		{
			var_03 = get_accurate_target(var_01,param_00);
			if(!isdefined(var_03))
			{
				var_03 = var_01[0];
			}
		}
		else
		{
			var_03 = var_01[0];
		}

		var_04 = gettime() + randomfloatrange(8,12) * 1000;
		while(gettime() < var_04 && isalive(var_03))
		{
			if(var_03.a.pose == "stand")
			{
				var_05 = var_03.origin + (0,0,64) - param_00.fake_laser.origin;
			}
			else
			{
				var_05 = var_03.origin + (0,0,32) - param_00.fake_laser.origin;
			}

			var_06 = vectortoangles(var_05);
			param_00.fake_laser rotateto(var_06,0.25);
			wait(0.25);
		}

		if(maps\_utility::ent_flag("heli_can_shoot") && isalive(var_03))
		{
			var_07 = param_00 gettagorigin("tag_flash");
			if(var_03.a.pose == "stand" || var_02 == 0)
			{
				var_08 = var_03.origin + (0,0,64);
			}
			else
			{
				var_08 = var_04.origin + (0,0,32);
			}

			var_09 = bullettrace(var_07,var_08,1);
			magicbullet("iw5_mors_sp",var_07,var_08);
			bullettracer(var_07,var_08);
		}
	}
}

//Function Number: 149
get_accurate_target(param_00,param_01)
{
	var_02 = param_01 gettagorigin("tag_flash");
	foreach(var_04 in param_00)
	{
		var_05 = var_04.origin + (0,0,64);
		var_06 = bullettrace(var_02,var_05,1);
		if(isdefined(var_06["entity"]) && var_06["entity"] == var_04)
		{
			return var_04;
		}
	}

	return undefined;
}

//Function Number: 150
heli_get_shooters()
{
	var_00 = [];
	foreach(var_02 in self.riders)
	{
		if(var_02.vehicle_position == 0 || var_02.vehicle_position == 1)
		{
			continue;
		}

		var_00[var_00.size] = var_02;
	}

	return var_00;
}

//Function Number: 151
heli_toggle_shoot()
{
	self endon("death");
	for(;;)
	{
		self waittill("allow_heli_shoot");
		maps\_utility::ent_flag_set("heli_can_shoot");
		common_scripts\utility::flag_set("flag_dialog_street_helo_onsite");
	}
}

//Function Number: 152
riders_no_damage()
{
	foreach(var_01 in self.riders)
	{
		var_01 maps\_utility::deletable_magic_bullet_shield();
	}
}

//Function Number: 153
player_can_see(param_00,param_01)
{
	var_02 = anglestoforward(level.player.angles);
	var_03 = vectornormalize(param_00 - level.player.origin);
	var_04 = vectordot(var_02,var_03);
	if(var_04 > cos(param_01))
	{
		return 1;
	}

	return 0;
}

//Function Number: 154
get_black_overlay()
{
	if(!isdefined(level.black_overlay))
	{
		level.black_overlay = maps\_hud_util::create_client_overlay("black",0,level.player);
	}

	level.black_overlay.sort = -1;
	level.black_overlay.foreground = 1;
	return level.black_overlay;
}

//Function Number: 155
get_white_overlay()
{
	if(!isdefined(level.white_overlay))
	{
		level.white_overlay = maps\_hud_util::create_client_overlay("white",0,level.player);
	}

	level.white_overlay.sort = -1;
	level.white_overlay.foreground = 1;
	return level.white_overlay;
}

//Function Number: 156
blackout(param_00,param_01)
{
	fadeoverlay(param_00,1,param_01);
}

//Function Number: 157
restorevision(param_00,param_01)
{
	fadeoverlay(param_00,0,param_01);
}

//Function Number: 158
fadeoverlay(param_00,param_01,param_02)
{
	self fadeovertime(param_00);
	self.alpha = param_01;
	setblur(param_02,param_00);
	wait(param_00);
}

//Function Number: 159
setup_dont_leave_hint()
{
	level endon("mission failed");
	for(;;)
	{
		common_scripts\utility::flag_wait("player_leaving_map");
		maps\_utility::display_hint("hint_dont_leave_mission");
		common_scripts\utility::flag_wait_either("player_leaving_map","player_returning_to_map");
		wait 0.05;
	}
}

//Function Number: 160
should_break_dont_leave()
{
	if(common_scripts\utility::flag("missionfailed"))
	{
		return 1;
	}

	if(common_scripts\utility::flag("player_returning_to_map"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 161
setup_dont_leave_failure()
{
	common_scripts\utility::flag_wait("player_left_map");
	level notify("mission failed");
	setdvar("ui_deadquote",&"SANFRAN_FAIL_SKIP_OBJECTIVE");
	maps\_utility::missionfailedwrapper();
}

//Function Number: 162
fall_fail()
{
	self endon("death");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(var_00 == level.player)
		{
			setblur(5,0.5);
			thread player_falling_kill_logic(1.5);
			level.player disableweapons();
			var_01 = spawn("script_origin",level.player.origin);
			var_01.angles = (-90,360,0);
			var_01 movegravity(level.player getvelocity(),15);
			level.player playerlinktoblend(var_01,undefined,1.2);
			setdvar("ui_deadquote",&"SANFRAN_FAIL_SKIP_OBJECTIVE");
			thread introscreen_generic_fade_out("black",999,0,1);
			maps\_utility::missionfailedwrapper();
			break;
		}
	}
}

//Function Number: 163
fail_player_for_abandon()
{
	for(;;)
	{
		var_00 = -1;
		foreach(var_02 in level.heroes)
		{
			if(var_02.origin[0] > level.player.origin[0])
			{
				var_00 = -1;
				break;
			}

			var_03 = level.player.origin[0] - var_02.origin[0];
			if(var_03 < var_00 || var_00 == -1)
			{
				var_00 = var_03;
			}
		}

		if(var_00 != -1)
		{
			if(var_00 > 3000)
			{
				setdvar("ui_deadquote",&"SANFRAN_FAIL_LEAVING_SQUAD");
				maps\_utility::missionfailedwrapper();
			}
			else if(var_00 > 2500)
			{
				player_left_squad_hint();
			}
			else
			{
				common_scripts\utility::flag_clear("flag_hint_player_left_squad");
			}
		}
		else
		{
			common_scripts\utility::flag_clear("flag_hint_player_left_squad");
		}

		wait(0.15);
	}
}

//Function Number: 164
player_abandon_squad_distance_think()
{
	level endon("gg_start_bridge_collapse");
	level.axis_global_accuracy_mod = 0;
	var_00 = 1200;
	var_01 = undefined;
	var_02 = -1;
	for(;;)
	{
		if(level.burke.origin[0] < level.player.origin[0])
		{
			wait(1);
			var_01 = undefined;
			continue;
		}

		var_03 = level.burke.origin[0] - level.player.origin[0];
		if(var_03 < var_02 || var_02 == -1)
		{
			var_02 = var_03;
		}

		if(isdefined(var_01) && var_03 < var_00)
		{
			var_01 = undefined;
			level.axis_global_accuracy_mod = 0;
			level notify("global_accuracy_mod_event");
		}

		if(var_03 > var_00)
		{
			var_01 = var_03 - var_00;
			var_04 = var_01 / 100;
			if(var_04 > 10)
			{
				var_04 = 10;
			}

			level.axis_global_accuracy_mod = var_04;
			level notify("global_accuracy_mod_event");
		}

		wait(1);
	}
}

//Function Number: 165
player_falling_kill_logic(param_00)
{
	var_01 = int(tablelookup("sp/deathQuoteTable.csv",1,"size",0));
	var_02 = randomint(var_01);
	var_03 = "player_falling_kill_in_progress";
	if(common_scripts\utility::flag(var_03))
	{
		return;
	}
	else
	{
		common_scripts\utility::flag_set(var_03);
	}

	if(!isdefined(param_00))
	{
		param_00 = 3;
	}

	common_scripts\utility::flag_clear("can_save");
	var_04 = gettime() + param_00 * 1000;
	while(!level.player isonground() && gettime() < var_04)
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

//Function Number: 166
introscreen_generic_fade_out(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 1.5;
	}

	var_04 = newhudelem();
	var_04.x = 0;
	var_04.y = 0;
	var_04.horzalign = "fullscreen";
	var_04.vertalign = "fullscreen";
	var_04.foreground = 0;
	var_04 setshader(param_00,640,480);
	if(isdefined(param_03) && param_03 > 0)
	{
		var_04.alpha = 0;
		var_04 fadeovertime(param_03);
		var_04.alpha = 1;
		wait(param_03);
	}

	wait(param_01);
	if(isdefined(param_02) && param_02 > 0)
	{
		var_04.alpha = 1;
		var_04 fadeovertime(param_02);
		var_04.alpha = 0;
	}

	var_04 destroy();
}

//Function Number: 167
player_damage_atlas_flag_set(param_00)
{
	self endon("death");
	self endon("flag_already_set");
	var_01 = undefined;
	var_02 = undefined;
	for(;;)
	{
		self waittill("damage",var_02,var_01);
		if(isdefined(var_01) && var_01 == level.player)
		{
			if(common_scripts\utility::flag(param_00))
			{
				self notify("flag_already_set");
				waittillframeend;
			}

			break;
		}
	}

	common_scripts\utility::flag_set(param_00);
}

//Function Number: 168
waittill_aigroupcount_or_flag(param_00,param_01,param_02)
{
	level endon(param_02);
	if(!common_scripts\utility::flag(param_02))
	{
		maps\_utility::waittill_aigroupcount(param_00,param_01);
	}
}