/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: vehicle_scripts/_attack_drone_controllable.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 54
 * Decompile Time: 646 ms
 * Timestamp: 10/27/2023 2:06:12 AM
*******************************************************************/

//Function Number: 1
controllable_drone_swarm_init()
{
	setsaveddvar("r_hudoutlineenable",1);
	setsaveddvar("r_hudoutlinewidth",20);
	setsaveddvar("r_hudoutlinecloakblurradius",0.35);
	if(!isdefined(level.boid_settings_presets))
	{
		level.boid_settings_presets = [];
	}

	level.boid_settings_presets["controllable_swarm"] = spawnstruct();
	level.boid_settings_presets["controllable_swarm"].neighborhood_radius = 78;
	level.boid_settings_presets["controllable_swarm"].separation_factor = 3000;
	level.boid_settings_presets["controllable_swarm"].alignment_factor = 0.02;
	level.boid_settings_presets["controllable_swarm"].cohesion_factor = 0.0001;
	level.boid_settings_presets["controllable_swarm"].queen_factor = 10;
	level.boid_settings_presets["controllable_swarm"].queen_deadzone = 64;
	level.boid_settings_presets["controllable_swarm"].random_factor = 50;
	level.boid_settings_presets["controllable_swarm"].max_accel = 2400;
	level.boid_settings_presets["controllable_swarm"].min_speed = 52.8;
	level.boid_settings_presets["controllable_swarm"].max_speed = 396;
	level.boid_settings_presets["controllable_swarm"].dodge_player_shots = 0;
	level.boid_settings_presets["controllable_swarm"].emp_mode = 0;
	level.boid_settings_presets["controllable_swarm"].queen_relative_speed = 1;
	level.boid_settings_presets["controllable_swarm"].queen_data_accel = 5;
	level.boid_settings_presets["controllable_swarm"].queen_data_decel = 5;
	level.boid_settings_presets["controllable_swarm"].queen_data_desired_speed = 15;
	level.boid_settings_presets["controllable_swarm"].queen_data_follow_radii = 75;
	level.fully_controllable_swarm = 0;
	level.swarm_spawned = 0;
	level.controllable_drone_hud = "drone_hud_controllable_overlay_2";
	level.controllable_drone_activated = "drone_hud_controllable_overlay_1";
	level.controllable_hud_target_shader = "jet_hud_hex_blue";
	level.controllable_drone_swarm_target = [];
	if(!common_scripts\utility::flag_exist("cloud_in_formation"))
	{
		common_scripts\utility::flag_init("cloud_in_formation");
	}

	maps\_utility::ent_flag_init("controllable_drones_go");
	common_scripts\utility::flag_init("controllable_swarm_activated");
	common_scripts\utility::flag_init("player_attack_think_running");
	common_scripts\utility::flag_init("controlling_drones");
	common_scripts\utility::flag_init("controlling_drones_first_time");
	level.controllable_drones = [];
	level.expected_drones = level.attack_drones_num_queens * level.attack_drones_num_drones_per_queen;
	precacheitem("iw5_attackdronemagicbullet");
	precacheshader(level.controllable_drone_hud);
	precacheshader(level.controllable_drone_activated);
	precacheshader(level.controllable_hud_target_shader);
	precacheshader("sat_hud_xray_blue");
	precacheshader("jet_hud_hex_orange");
	precacheshader("jet_hud_missile_circle");
	precacheitem("remote_missile_drone");
	precache_icons();
	vehicle_scripts\_attack_drone_common::drone_fx();
	level.scr_animtree["drone_control_view_model"] = #animtree;
	level.scr_model["drone_control_view_model"] = "viewhands_s1_pmc";
	level.scr_anim["drone_control_view_model"]["drone_control_on"] = %vm_turn_on_cloak;
}

//Function Number: 2
precache_icons()
{
	precacheshader("drone_hud_locking_on_1");
	precacheshader("drone_hud_locking_on_2");
	precacheshader("drone_hud_locking_on_3");
	precacheshader("drone_hud_locking_on_4");
	precacheshader("drone_hud_locking_on_5");
	precacheshader("drone_hud_locking_on_6");
	precacheshader("drone_hud_locking_on_7");
	precacheshader("drone_hud_locking_on_8");
	precacheshader("drone_hud_locking_on_9");
	precacheshader("drone_hud_locking_on_10");
	precacheshader("drone_hud_locking_on_11");
	precacheshader("drone_hud_locking_on_12");
	precacheshader("drone_hud_locking_on_13");
	precacheshader("drone_hud_locking_on_14");
	precacheshader("drone_hud_locking_on_15");
	precacheshader("drone_hud_locking_on_16");
	precacheshader("drone_hud_npc_lockon");
	precacheshader("drone_hud_veh_lockon");
	level.drone_lockon_icons = ["drone_hud_locking_on_2","drone_hud_locking_on_4","drone_hud_locking_on_6","drone_hud_locking_on_8","drone_hud_locking_on_10","drone_hud_locking_on_12","drone_hud_locking_on_14","drone_hud_locking_on_16"];
}

//Function Number: 3
kill_controllable_drone_swarm()
{
	level.controllable_cloud_queen notify("end_drone_swarm");
	level notify("delete_drone_cloud");
	common_scripts\utility::array_thread(level.controllable_drones,::maps\_shg_design_tools::delete_auto);
	common_scripts\utility::array_thread(level.drone_swarm_queens,::maps\_shg_design_tools::delete_auto);
	common_scripts\utility::array_removeundefined(level.controllable_drones);
	common_scripts\utility::array_removeundefined(level.drone_swarm_queens);
}

//Function Number: 4
ad_offset_position_from_tag(param_00,param_01,param_02)
{
	var_03 = self gettagangles(param_01);
	var_04 = self gettagorigin(param_01);
	if(param_00 == "up")
	{
		return var_04 + anglestoup(var_03) * param_02;
	}

	if(param_00 == "down")
	{
		return var_04 + anglestoup(var_03) * param_02 * -1;
	}

	if(param_00 == "right")
	{
		return var_04 + anglestoright(var_03) * param_02;
	}

	if(param_00 == "left")
	{
		return var_04 + anglestoright(var_03) * param_02 * -1;
	}

	if(param_00 == "forward")
	{
		return var_04 + anglestoforward(var_03) * param_02;
	}

	if(param_00 == "backward")
	{
		return var_04 + anglestoforward(var_03) * param_02 * -1;
	}

	if(param_00 == "backwardright")
	{
		var_04 = var_04 + anglestoright(var_03) * param_02;
		return var_04 + anglestoforward(var_03) * param_02 * -1;
	}

	if(param_00 == "backwardleft")
	{
		var_04 = var_04 + anglestoright(var_03) * param_02 * -1;
		return var_04 + anglestoforward(var_03) * param_02 * -1;
	}

	if(param_00 == "forwardright")
	{
		var_04 = var_04 + anglestoright(var_03) * param_02 * 1;
		return var_04 + anglestoforward(var_03) * param_02;
	}

	if(param_00 == "forwardleft")
	{
		var_04 = var_04 + anglestoright(var_03) * param_02 * -1;
		return var_04 + anglestoforward(var_03) * param_02;
	}
}

//Function Number: 5
setup_drone_swarm_crates()
{
	level.controllable_drone_spawners = getentarray("drone_crate_spawner","targetname");
	var_00 = getentarray("vol_drone_crate_reinforcements","targetname");
	foreach(var_02 in level.controllable_drone_spawners)
	{
		var_02 make_drone_crate(level.controllable_drone_spawners);
	}

	foreach(var_05 in var_00)
	{
		var_05 make_drone_crate_group(level.controllable_drone_spawners);
		var_05 thread waittill_crate_activated();
	}

	level notify("queen_drone_selected",self);
	level.player swarm_drone_hud_on(level.controllable_drone_activated);
}

//Function Number: 6
make_drone_crate_group(param_00)
{
	self.drone_spawners = [];
	self.path = undefined;
	foreach(var_02 in param_00)
	{
		if(var_02 istouching(self))
		{
			self.drone_spawners[self.drone_spawners.size] = var_02;
		}
	}

	var_04 = common_scripts\utility::getstructarray("struct_drone_crate_reinforcements","targetname");
	var_05 = common_scripts\utility::spawn_tag_origin();
	foreach(var_07 in var_04)
	{
		var_05.origin = var_07.origin;
		if(var_05 istouching(self))
		{
			self.path = var_07;
		}
	}
}

//Function Number: 7
make_drone_crate(param_00)
{
	var_01 = getentarray("drone_crate_trigger","targetname");
	self.trigger = getclosestdrone(self.origin,var_01,500);
	self.vols = getentarray("drone_crate_volume","targetname");
	var_02 = getentarray("drone_crate_drone","targetname");
	self.include = getent("vol_include_drones","targetname");
	self.my_vol = getclosestdrone(self.origin,self.vols,500);
	self.my_orgs = func_4137(var_02,self.my_vol);
	self.nodes = maps\_shg_design_tools::getthingarray("drone_crate_path","targetname");
	self.node = getclosestdrone(self.my_vol.origin,self.nodes,500);
}

//Function Number: 8
waittill_crate_activated()
{
	while(!level.player istouching(self))
	{
		wait 0.05;
	}

	drone_cloud_controllable();
}

//Function Number: 9
handle_controllable_cloud_queen_pathing()
{
	level.controllable_cloud_queen endon("death");
	var_00 = common_scripts\utility::getstructarray("struct_drone_crate_masterpath1","targetname");
	var_01 = level.player common_scripts\utility::spawn_tag_origin();
	for(;;)
	{
		if(!level.controllable_cloud_queen.is_player_controlled)
		{
			var_01.origin = level.player.origin;
			var_01.angles = level.player getgunangles();
			var_02 = var_01 maps\_shg_design_tools::offset_position_from_tag("forward","tag_origin",300);
			var_03 = maps\_shg_design_tools::getclosestauto(var_02,var_00,1000);
			if(isdefined(var_03))
			{
				thread queen_change_path(var_03,20);
			}
		}

		wait(2);
	}
}

//Function Number: 10
drone_cloud_controllable()
{
	var_00 = spawn_controllable_drone_cloud();
	if(!isdefined(level.controllable_cloud_queen))
	{
		level.controllable_cloud_queen = var_00[0];
		level.controllable_cloud_queen.is_player_controlled = 0;
		level.controllable_cloud_queen show();
		thread handle_controllable_cloud_queen_pathing();
	}

	if(!isdefined(level.drone_swarm_queens))
	{
		level.drone_swarm_queens = var_00;
	}
	else
	{
		level.drone_swarm_queens = common_scripts\utility::array_combine(level.drone_swarm_queens,var_00);
	}

	foreach(var_02 in var_00)
	{
		while(!isdefined(var_02.boid_cloud_spawned))
		{
			wait 0.05;
		}
	}

	wait(4);
	common_scripts\utility::array_thread(var_00,::controllable_fly_think,level.controllable_cloud_queen,level.boid_settings_presets["controllable_swarm"].queen_data_follow_radii);
	level.controllable_cloud_queen.drones = level.controllable_drones;
	level.player thread player_attack_think();
	level notify("drone_swarm_spawned");
	level.swarm_spawned = 1;
}

//Function Number: 11
queen_change_path(param_00,param_01)
{
	if(isdefined(level.controllable_cloud_queen))
	{
		if(!isdefined(param_01))
		{
			param_01 = 25;
		}

		level.controllable_cloud_queen notify("end_queen_think");
		level.controllable_cloud_queen.attachedpath = undefined;
		var_02 = level.player getgunangles()[1];
		level.controllable_cloud_queen vehicle_helisetai(param_00.origin,param_01,param_01 / 2,param_01 * 2,0,1,var_02,0,0,1,0,0,1);
	}
}

//Function Number: 12
getdroneperlinovertime(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	var_04 = (perlinnoise2d(gettime() * 0.001 * 0.05,10,param_00,param_01,param_02) * param_03,perlinnoise2d(gettime() * 0.001 * 0.05,20,param_00,param_01,param_02) * param_03,perlinnoise2d(gettime() * 0.001 * 0.05,30,param_00,param_01,param_02) * param_03);
	return var_04;
}

//Function Number: 13
spawn_controllable_drone_cloud()
{
	var_00 = self.drone_spawners;
	var_01 = self.drone_spawners.size;
	var_02 = [];
	for(var_03 = 0;var_03 < var_01;var_03++)
	{
		var_00[var_03].count = 1;
		var_04 = var_00[var_03] maps\_utility::spawn_vehicle();
		var_04.location = int(120 / var_01 * var_03);
		var_04.num_in_formation = var_01;
		var_04 thread make_crate_boidcloud(var_00[var_03].my_orgs);
		var_04 thread vehicle_scripts\_attack_drone_common::make_queen_invulnerable();
		var_04.can_be_damaged = 1;
		var_04.script_team = "allies";
		var_02[var_02.size] = var_04;
		var_04 hide();
		wait(0.1);
	}

	return var_02;
}

//Function Number: 14
func_4137(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(isdefined(param_02) && param_02)
	{
		var_03 = common_scripts\utility::spawn_tag_origin();
	}

	var_04 = [];
	foreach(var_06 in param_00)
	{
		if(isdefined(var_03))
		{
			var_03.origin = var_06.origin;
			var_07 = var_03;
		}
		else
		{
			var_07 = var_06;
		}

		if(var_07 istouching(param_01))
		{
			var_04[var_04.size] = var_06;
		}
	}

	if(isdefined(var_03))
	{
		var_03 delete();
	}

	return var_04;
}

//Function Number: 15
player_linkto_drone_missile(param_00)
{
	if(level.player.is_driving_pdrone)
	{
		level.player maps\_utility::player_dismount_vehicle();
		level.player.is_driving_pdrone = 0;
	}

	level.player maps\_shg_utility::setup_player_for_scene();
	level.player playerlinktoabsolute(param_00,"tag_origin");
}

//Function Number: 16
player_unlink_from_drone_missile()
{
	level.player unlink();
	level.player maps\_shg_utility::setup_player_for_gameplay();
}

//Function Number: 17
prep_user_for_dronecrate()
{
	self disableweapons();
	self.ignoreme = 1;
	self enableinvulnerability();
	var_00 = getaiarray("axis");
}

//Function Number: 18
remove_user_from_dronecrate()
{
	self enableweapons();
	self.ignoreme = 0;
	self disableinvulnerability();
}

//Function Number: 19
monitor_drone_depletion(param_00)
{
	param_00 endon("death");
	while(param_00.drones.size <= 0)
	{
		wait 0.05;
	}

	while(param_00.drones.size > 0)
	{
		param_00.drones = common_scripts\utility::array_removeundefined(param_00.drones);
		wait 0.05;
	}

	param_00 notify("end_drone_swarm");
}

//Function Number: 20
swarm_drone_hud_on(param_00)
{
	var_01 = 50000;
	var_02 = 60;
	self.dronecrate_hud["overlay1"] = newclienthudelem(self);
	self.dronecrate_hud["overlay1"] setshader(param_00,640,480);
	self.dronecrate_hud["overlay1"].alignx = "left";
	self.dronecrate_hud["overlay1"].aligny = "top";
	self.dronecrate_hud["overlay1"].x = 0;
	self.dronecrate_hud["overlay1"].y = 0;
	self.dronecrate_hud["overlay1"].horzalign = "fullscreen";
	self.dronecrate_hud["overlay1"].vertalign = "fullscreen";
	self.dronecrate_hud["overlay1"].alpha = 0.5;
	self.dronecrate_hud["num_drones"] = newclienthudelem(self);
	self.dronecrate_hud["num_drones"].alignx = "left";
	self.dronecrate_hud["num_drones"].aligny = "top";
	self.dronecrate_hud["num_drones"].x = 10;
	self.dronecrate_hud["num_drones"].y = 110;
	self.dronecrate_hud["num_drones"].fontscale = 2;
	thread monitor_num_activated_drones();
}

//Function Number: 21
monitor_num_activated_drones()
{
	for(;;)
	{
		self.dronecrate_hud["num_drones"] settext("Drones:  " + level.controllable_drones.size);
		wait 0.05;
	}
}

//Function Number: 22
swarm_drone_hud_change(param_00)
{
	self.dronecrate_hud["overlay1"] setshader(param_00,640,480);
}

//Function Number: 23
swarm_drone_hud_off(param_00)
{
	common_scripts\utility::array_call(self.dronecrate_hud,::destroy);
}

//Function Number: 24
get_drones_into_start_positions(param_00,param_01,param_02,param_03,param_04)
{
	wait(randomfloat(param_01 / 2));
	param_00 = self.origin + (randomintrange(-20,20),randomintrange(-20,20),20 + param_01 * 12);
	vehicle_scripts\_attack_drone_common::drone_lerp_to_position((self.origin[0],self.origin[1],param_00[2]),50);
	self rotateto(param_02.angles,1,0.1,0.5);
	wait(1);
	vehicle_scripts\_attack_drone_common::drone_lerp_to_position(param_00,50);
	param_03 vehicle_scripts\_attack_drone_common::add_to_flock(self);
}

//Function Number: 25
attack_hint_display()
{
	for(;;)
	{
		common_scripts\utility::flag_waitopen("controlling_drones");
		common_scripts\utility::flag_wait("controlling_drones");
		maps\_utility::hint("Press ^3[{+attack}]^7 to launch a drone at each locked on target");
		level.player common_scripts\utility::waittill_any("attack_pressed","dpad_down");
		maps\_utility::hint_fade();
	}
}

//Function Number: 26
drone_enabled_animation()
{
	level.player disableweapons();
	level.player waittill("weapon_change");
	var_00 = maps\_utility::spawn_anim_model("drone_control_view_model");
	var_00 linktoplayerview(level.player,"tag_origin",(0,0,0),(0,0,0),1);
	level.player maps\_anim::anim_single_solo(var_00,"drone_control_on");
	level.player enableweapons();
	var_00 unlink();
	var_00 delete();
}

//Function Number: 27
setup_drone_mode()
{
	foreach(var_01 in level.controllable_drones)
	{
		if(isdefined(var_01))
		{
			var_01 maps\_vehicle::godon();
			var_01 thermaldrawenable();
		}
	}

	foreach(var_04 in level.controllable_drone_swarm_target)
	{
		if(isdefined(var_04))
		{
			var_04 thermaldrawenable();
		}
	}

	wait 0.05;
	level.player thermalvisionon();
	level.player swarm_drone_hud_change(level.controllable_drone_hud);
}

//Function Number: 28
remove_drone_mode()
{
	var_00 = level.player.drone_locked_targets;
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02) && target_istarget(var_02))
		{
			target_remove(var_02);
		}
	}

	level.player.drone_locked_targets = [];
	level.player thermalvisionoff();
	level.player swarm_drone_hud_change(level.controllable_drone_activated);
}

//Function Number: 29
handle_drone_target_selection()
{
	var_00 = getaiarray("axis");
	level.controllable_drone_swarm_target = maps\_utility::array_removedead(level.controllable_drone_swarm_target);
	var_01 = common_scripts\utility::array_combine(level.controllable_drone_swarm_target,var_00);
	var_01 = common_scripts\utility::array_removeundefined(var_01);
	var_01 = common_scripts\utility::array_remove_duplicates(var_01);
	level.player.drone_locked_targets = [];
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03.ridingvehicle))
		{
			var_01 = common_scripts\utility::array_remove(var_01,var_03);
		}
	}

	handle_drone_target_selection_internal(var_01);
	foreach(var_03 in var_01)
	{
		if(isdefined(var_03) && target_istarget(var_03))
		{
			target_remove(var_03);
		}
	}

	if(common_scripts\utility::flag("drone_swarm_launched"))
	{
		level waittill("drone_swarm_launch_seq_complete");
	}
}

//Function Number: 30
handle_drone_target_selection_internal(param_00)
{
	level.player endon("dpad_down");
	level endon("drone_swarm_launched");
	level.player endon("drone_killed_by_death");
	var_01 = common_scripts\utility::spawn_tag_origin();
	target_set(var_01);
	target_hidefromplayer(var_01,level.player);
	foreach(var_03 in param_00)
	{
		var_03.lock_on_stage = 0;
	}

	for(;;)
	{
		foreach(var_03 in param_00)
		{
			if(!isdefined(var_03) || var_03.lock_on_stage == level.drone_lockon_icons.size)
			{
				continue;
			}

			var_01.origin = var_03.origin;
			var_06 = level.controllable_cloud_queen vehicle_scripts\_pdrone_player::pdrone_player_get_current_fov();
			var_07 = 60;
			var_08 = target_isincircle(var_01,level.player,var_06,var_07);
			var_08 = var_08 && level.player.drone_locked_targets.size < level.controllable_drones.size;
			if(var_08)
			{
				if(var_03.lock_on_stage == 0)
				{
					target_set(var_03,(0,0,32));
				}

				var_03.lock_on_stage++;
				if(var_03.lock_on_stage == level.drone_lockon_icons.size)
				{
					if(var_03 maps\_vehicle::isvehicle())
					{
						target_setshader(var_03,"drone_hud_veh_lockon");
					}
					else
					{
						target_setshader(var_03,"drone_hud_npc_lockon");
					}

					level.player.drone_locked_targets[level.player.drone_locked_targets.size] = var_03;
					level.player notify("drone_target_aquired");
				}
				else
				{
					target_setshader(var_03,level.drone_lockon_icons[var_03.lock_on_stage]);
				}

				continue;
			}

			if(target_istarget(var_03))
			{
				var_03.lock_on_stage = 0;
				target_remove(var_03);
			}
		}

		wait 0.05;
	}
}

//Function Number: 31
waittill_attack_and_launch_drones()
{
	common_scripts\utility::flag_clear("drone_swarm_launched");
	level.player waittill("attack_pressed");
	level.player.drone_locked_targets = common_scripts\utility::array_removeundefined(level.player.drone_locked_targets);
	level.player.drone_locked_heli_target = undefined;
	foreach(var_01 in level.player.drone_locked_targets)
	{
		if(var_01 maps\_vehicle::isvehicle() && var_01 maps\_vehicle::ishelicopter())
		{
			level.player.drone_locked_heli_target = var_01;
			level.player.drone_locked_targets = common_scripts\utility::array_remove(level.player.drone_locked_targets,var_01);
			break;
		}
	}

	if(level.player.drone_locked_targets.size > 0)
	{
		common_scripts\utility::flag_set("drone_swarm_launched");
		var_03 = level.player.drone_locked_targets.size - 1;
		level.player.drone_locked_special_target = level.player.drone_locked_targets[var_03];
		level.player.drone_locked_special_target.health = 1000;
		level.player.drone_locked_targets = maps\_utility::array_remove_index(level.player.drone_locked_targets,var_03);
		if(level.player.drone_locked_targets.size > 0)
		{
			launch_drone_missiles(level.player.drone_locked_targets);
		}

		level.player.drone_locked_special_target.health = 50;
		launch_drone_missile_special(level.player.drone_locked_special_target);
	}

	level notify("drone_swarm_launch_seq_complete");
	if(isdefined(level.player.drone_locked_heli_target))
	{
		level.player.drone_locked_heli_target thread helicopter_drone_attack(level.controllable_cloud_queen.origin);
	}
}

//Function Number: 32
player_attack_think()
{
	level.player endon("death");
	if(common_scripts\utility::flag("player_attack_think_running"))
	{
		return;
	}

	common_scripts\utility::flag_set("player_attack_think_running");
	var_00 = 1000;
	thread attack_hint_display();
	for(;;)
	{
		level.player waittill("dpad_down");
		if(level.controllable_drones.size == 0)
		{
			continue;
		}

		drone_enabled_animation();
		if(level.controllable_drones.size > 0)
		{
			common_scripts\utility::flag_set("controlling_drones");
			common_scripts\utility::flag_set("controlling_drones_first_time");
			var_01 = level.controllable_cloud_queen;
			var_01.is_player_controlled = 1;
			setup_drone_mode();
			vehicle_scripts\_pdrone_player::pdrone_player_use(var_01,undefined,0,undefined,undefined,"LT","ui_sniperdrone");
			thread maps\_introscreen::introscreen_generic_fade_in("black",0.5,0.5);
			var_01 vehicle_scripts\_pdrone_player::pdrone_player_enter();
			var_01 returnplayercontrol();
			thread waittill_attack_and_launch_drones();
			if(isdefined(level.controllable_drone_allowed_vols))
			{
			}

			var_01 thread vehicle_scripts\_pdrone_player::pdrone_player_loop();
			handle_drone_target_selection();
			var_01 vehicle_scripts\_pdrone_player::pdrone_player_exit();
			var_01.is_player_controlled = 0;
			thread maps\_introscreen::introscreen_generic_fade_in("black",0.5,0.5);
			remove_drone_mode();
			common_scripts\utility::flag_clear("controlling_drones");
		}

		wait 0.05;
	}
}

//Function Number: 33
drone_missile_make(param_00,param_01)
{
	var_02 = spawn("script_model",param_00);
	var_02 setmodel("vehicle_sentinel_survey_drone");
	var_02 drone_missile_init(param_00,param_01);
	return var_02;
}

//Function Number: 34
drone_missile_init(param_00,param_01)
{
	self.launch_org = param_00;
	self.target_org = param_01;
	self.direction = self.target_org - self.launch_org;
	var_02 = 500;
	self.total_time = length(self.target_org - self.launch_org) / var_02;
	self.vec_acceleration = (-1,-1,-150);
	self.vec_velocity = 2 * self.target_org - self.launch_org - self.vec_acceleration * self.total_time * self.total_time / 2 * self.total_time;
}

//Function Number: 35
drone_missile_loop()
{
	self.time_passed = 0;
	while(self.time_passed <= self.total_time)
	{
		var_00 = self.origin;
		self.origin = self.launch_org + self.time_passed * self.vec_velocity + 0.5 * self.vec_acceleration * self.time_passed * self.time_passed;
		self.angles = vectortoangles(self.target_org - self.origin);
		self.time_passed = self.time_passed + 0.05;
		wait(0.05);
	}

	magicgrenademanual("fraggrenade",self.origin,(0,0,0),0.05,level.player);
	self delete();
	level notify("drone_missile_loop_complete",self);
}

//Function Number: 36
launch_drone_missile_special(param_00)
{
	level.controllable_drones = common_scripts\utility::array_removeundefined(level.controllable_drones);
	var_01 = level.controllable_drones[0];
	level.controllable_drones = common_scripts\utility::array_remove(level.controllable_drones,var_01);
	var_01 delete();
	var_02 = drone_missile_make(level.player.origin,param_00.origin);
	player_linkto_drone_missile(var_02);
	var_02 drone_missile_loop();
	player_unlink_from_drone_missile();
}

//Function Number: 37
launch_drone_missiles(param_00)
{
	var_01 = level.player.origin;
	foreach(var_03 in param_00)
	{
		if(isdefined(var_03))
		{
			var_01 = var_03.origin;
			break;
		}
	}

	level.controllable_drones = common_scripts\utility::array_removeundefined(level.controllable_drones);
	var_05 = level.controllable_drones;
	var_05 = sortbydistance(var_05,var_01);
	var_06 = [];
	foreach(var_08 in param_00)
	{
		if(isdefined(var_08))
		{
			var_06[var_06.size] = var_08;
			if(target_istarget(var_08))
			{
				target_remove(var_08);
			}
		}
	}

	var_0A = 0;
	foreach(var_14, var_0C in param_00)
	{
		if(!isdefined(var_0C))
		{
			continue;
		}

		var_0D = var_05[var_14];
		if(!isdefined(var_0D))
		{
			foreach(var_03 in param_00)
			{
				if(isdefined(var_03))
				{
					var_0C = var_03;
				}
			}
		}

		if(!isdefined(var_0D))
		{
			return;
		}

		var_0D notify("im_attacking");
		var_0D.remove_from_flock = 1;
		var_10 = var_0D.origin;
		var_10 = level.player geteye();
		var_11 = level.player getplayerangles();
		var_0D delete();
		level.controllable_drones = common_scripts\utility::array_removeundefined(level.controllable_drones);
		var_12 = (randomintrange(-100,100),randomintrange(-100,100),0);
		var_13 = drone_missile_make(var_10,var_0C.origin);
		var_0A++;
		var_13 thermaldrawenable();
		var_13 thread drone_missile_loop();
	}

	while(var_0A > 0)
	{
		level waittill("drone_missile_loop_complete",var_15);
		var_0A--;
	}
}

//Function Number: 38
cleanup_missile(param_00,param_01)
{
	while(isdefined(param_00))
	{
		wait(0.05);
	}

	param_01 delete();
}

//Function Number: 39
drone_lockon_missile_fire(param_00,param_01)
{
	wait(randomfloatrange(0.1,0.35));
	var_02 = common_scripts\utility::spawn_tag_origin();
	if(issentient("target"))
	{
		var_02.origin = param_01 geteye();
	}
	else
	{
		var_02.origin = param_01.origin;
	}

	var_02 linkto(param_01);
	target_set(var_02);
	target_hidefromplayer(var_02,level.player);
	if(issentient("target"))
	{
		var_03 = magicbullet("remote_missile_drone_light",param_00,param_01 geteye() + (0,0,200),level.player);
	}
	else
	{
		var_03 = magicbullet("remote_missile_drone_light",param_01,var_02.origin + (0,0,200),level.player);
	}

	var_03 missile_settargetent(var_02);
	var_03 missile_setflightmodetop();
	thread cleanup_missile(var_03,var_02);
	return var_03;
}

//Function Number: 40
getclosestdrone(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 500000;
	}

	if(!isdefined(param_01))
	{
		return;
	}

	var_03 = undefined;
	foreach(var_05 in param_01)
	{
		if(!isdefined(var_05))
		{
			continue;
		}

		var_06 = distance(var_05.origin,param_00);
		if(var_06 >= param_02)
		{
			continue;
		}

		param_02 = var_06;
		var_03 = var_05;
	}

	return var_03;
}

//Function Number: 41
monitor_drone_missile_death()
{
	while(isdefined(self))
	{
		wait 0.05;
	}

	level.player notify("drone_missile_impact");
}

//Function Number: 42
helicopter_drone_attack(param_00)
{
	if(isdefined(level.drone_swarm_queens[1]))
	{
		var_01 = level.drone_swarm_queens[1];
	}
	else
	{
		var_01 = level.drone_swarm_queens[2];
	}

	var_02 = var_01.origin;
	foreach(var_04 in var_01.boids)
	{
		if(isdefined(var_04))
		{
			var_04 delete();
		}
	}

	var_01 delete();
	var_06 = undefined;
	var_07 = undefined;
	if(level.nextgen)
	{
		var_06 = 12;
		var_07 = 24;
	}
	else
	{
		var_06 = 6;
		var_07 = 12;
	}

	var_08 = vehicle_scripts\_attack_drone_common::spawn_snake_cloud("queen_drone_cloud_2",undefined,var_06,var_07,var_02);
	level notify("drone_attacked_chopper");
	var_08 vehicle_scripts\_attack_drone_common::snake_cloud_pester_helicopter(self);
}

//Function Number: 43
send_swarm_to_chopper(param_00)
{
	while(isdefined(param_00) && isdefined(self))
	{
		self setvehgoalpos(param_00.origin,1);
		wait(0.05);
	}
}

//Function Number: 44
create_drone_kamikazes(param_00)
{
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01.angles = self.angles;
	var_01.origin = var_01 vehicle_scripts\_attack_drone_common::offset_position_from_drone("forward","tag_origin",50);
	var_02[0] = var_01 vehicle_scripts\_attack_drone_common::offset_position_from_drone("right","tag_origin",60);
	var_02[1] = var_01 vehicle_scripts\_attack_drone_common::offset_position_from_drone("left","tag_origin",70);
	var_02[2] = var_01 vehicle_scripts\_attack_drone_common::offset_position_from_drone("up","tag_origin",40);
	var_02[3] = var_01 vehicle_scripts\_attack_drone_common::offset_position_from_drone("down","tag_origin",40);
	foreach(var_04 in var_02)
	{
		var_05 = spawn("script_model",var_04);
		var_05 setmodel("vehicle_sentinel_survey_drone");
		var_05.angles = var_01.angles;
		var_05 thread vehicle_scripts\_attack_drone_common::lerp_drone_to_position(param_00.origin,randomintrange(600,700));
		var_05 thread simple_drone_health();
	}
}

//Function Number: 45
clear_drone_cloud()
{
}

//Function Number: 46
monitor_drone_cloud_members()
{
	common_scripts\utility::waittill_any("im_dying","explode","death","im_attacking");
	level.controllable_drones = common_scripts\utility::array_remove(level.controllable_drones,self);
}

//Function Number: 47
controllable_fly_think(param_00,param_01)
{
	if(self != level.controllable_cloud_queen)
	{
		thread queen_drone_fly(param_00,param_01);
	}
}

//Function Number: 48
queen_drone_fly(param_00,param_01)
{
	level endon("delete_drone_cloud");
	self endon("death");
	self endon("end_queen_think");
	level.controllable_cloud_queen endon("end_drone_swarm");
	self.radii = param_01;
	self.accel = level.boid_settings_presets["controllable_swarm"].queen_data_accel;
	self.decel = level.boid_settings_presets["controllable_swarm"].queen_data_decel;
	self.desired_speed = level.boid_settings_presets["controllable_swarm"].queen_data_desired_speed;
	var_02 = (0,0,0);
	self notify("queen_set_fly_logic");
	for(;;)
	{
		var_03 = position_in_circle(param_00.origin,self.radii);
		var_02 = var_03;
		var_04 = param_00 vehicle_getspeed() * 1.75;
		if(var_04 <= 0)
		{
			var_04 = 1;
		}

		self vehicle_setspeed(var_04,var_04,var_04 * 1.5);
		self setvehgoalpos(var_03);
		if(!common_scripts\utility::flag("cloud_in_formation"))
		{
			if(self.location + 1 <= 120)
			{
				self.location++;
			}
			else
			{
				self.location = 0;
			}

			wait 0.05;
			continue;
		}

		wait(0.25);
	}
}

//Function Number: 49
position_in_circle(param_00,param_01)
{
	var_02 = param_01;
	var_03 = 1;
	var_04 = 120;
	var_05 = 3;
	var_06 = [];
	var_07 = [];
	for(var_08 = 0;var_08 < var_04;var_08++)
	{
		var_03 = var_05 * var_08;
		var_09 = 0;
		var_06[var_06.size] = param_00 + anglestoforward((var_09,var_03,0)) * var_02;
	}

	if(isdefined(var_06[self.location]))
	{
		return var_06[self.location];
	}

	return var_06[0];
}

//Function Number: 50
make_crate_boidcloud(param_00,param_01)
{
	var_02 = spawnstruct();
	var_02.boids = [];
	var_02.queen = self;
	var_02.queen.flock = var_02;
	if(isdefined(param_01))
	{
		var_02.boid_settings = param_01;
	}
	else
	{
		var_02.boid_settings = spawnstruct();
	}

	for(var_03 = 0;var_03 < param_00.size;var_03++)
	{
		var_04 = spawn("script_model",param_00[var_03].origin);
		var_04 setmodel("vehicle_mil_attack_drone_static");
		var_04.angles = param_00[var_03].angles;
		var_04 thread get_drones_into_start_positions(param_00[var_03],var_03,var_02.queen,var_02);
		param_00[var_03] hide();
		var_04 thread monitor_controllable_drone_cloud_health();
		thread monitor_drone_cloud_members();
		level.controllable_drones[level.controllable_drones.size] = var_04;
		wait 0.05;
	}

	self.boids = var_02.boids;
	var_02.queen.boid_cloud_spawned = 1;
	var_02 thread vehicle_scripts\_attack_drone_common::boid_flock_think();
	return var_02;
}

//Function Number: 51
will_boid_clip_camera(param_00)
{
	var_01 = 150;
	if(!isdefined(level.controllable_cloud_queen.camera_tag))
	{
		return 0;
	}

	if(distance(param_00,level.controllable_cloud_queen.camera_tag.origin) < var_01)
	{
		return 1;
	}

	return 0;
}

//Function Number: 52
simple_drone_health()
{
	self setcandamage(1);
	self.can_be_damaged = 1;
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(vehicle_scripts\_attack_drone_common::is_bullet_damage(var_04))
		{
			thread vehicle_scripts\_attack_drone_common::fake_drone_death();
		}
	}
}

//Function Number: 53
monitor_controllable_drone_cloud_health(param_00)
{
	self notify("kill_drone_cloud_health_process");
	self endon("kill_drone_cloud_health_process");
	if(isdefined(self))
	{
		self.can_be_damaged = 0;
	}

	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!param_00 && randomint(100) > 25)
	{
		return;
	}

	if(!param_00)
	{
		wait(randomfloat(1));
	}

	self setcandamage(1);
	self.can_be_damaged = 1;
	var_01 = 0;
	for(;;)
	{
		self waittill("damage",var_02,var_03,var_04,var_05,var_06);
		if(vehicle_scripts\_attack_drone_common::is_bullet_damage(var_06))
		{
			var_01++;
		}

		if(var_01 >= 2)
		{
			thread vehicle_scripts\_attack_drone_common::fake_drone_death();
			level notify("drone_killed_by_death");
			break;
		}
	}
}

//Function Number: 54
boid_add_vehicle_to_targets(param_00,param_01)
{
	param_00 notify("stop_friendlyfire_shield");
	level endon("end_drone_cloud");
	param_00 endon("death");
	if(!isdefined(param_01))
	{
		param_01 = 300;
	}

	while(!level.swarm_spawned)
	{
		wait 0.05;
	}

	while(distance(param_00.origin,level.cloud_queen.origin) > param_01)
	{
		var_02 = distance(param_00.origin,level.cloud_queen.origin);
		wait 0.05;
	}

	while(vehicle_scripts\_attack_drone_common::isdronevehiclealive(param_00))
	{
		var_03 = sortbydistance(level.controllable_drones,param_00.origin);
		for(var_04 = 0;var_04 < 5;var_04++)
		{
			var_03[var_04] thread vehicle_scripts\_attack_drone_common::boid_vehicle_targets(param_00,param_01);
			wait(0.1);
		}

		wait(2);
	}
}