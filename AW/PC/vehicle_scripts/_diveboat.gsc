/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _diveboat.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 36
 * Decompile Time: 580 ms
 * Timestamp: 4/22/2024 2:04:48 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	setup_fx();
	maps\_vehicle::build_template("diveboat",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::init_local);
	maps\_vehicle::build_deathmodel("vehicle_mil_atlas_speedboat_ai","vehicle_mil_atlas_speedboat_dstrypv",0);
	maps\_vehicle::build_deathfx("vfx/explosion/vehicle_diveboat_explosion",undefined,"fin_npc_boat_exp");
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_aianims(::setanims,::set_vehicle_anims);
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_death_jolt_delay(9999);
	if(!isdefined(level.diveboat_anims_initialized))
	{
		setup_worldhands_anims();
		setup_player_driving_anims();
		level.diveboat_anims_initialized = 1;
	}

	precachemodel("vehicle_mil_hoverbike_vm");
	precachemodel("vehicle_mil_hoverbike_ai");
	precachemodel("vehicle_mil_atlas_speedboat_ai");
	precacherumble("steady_rumble");
	init_diveboat_weapon();
	init_diveboat_weapon_gauge();
	maps\_vehicle::build_missile_launcher("diveboat_missile_launcher","hatchL","projectile_rpg7","rpg_guided",::missile_door_open,::missile_door_close,0.2,0.2,0.75,3,5,1);
	maps\_vehicle::build_missile_launcher("diveboat_missile_launcher","hatchR","projectile_rpg7","rpg_guided",::missile_door_open,::missile_door_close,0.2,0.2,0.75,3,5,1);
}

//Function Number: 2
setup_fx()
{
	level._effect["boat_wake_diveboat_splash_fast"] = loadfx("vfx/treadfx/boat_wake_diveboat_splash_fast");
	level._effect["boat_wake_diveboat_splash_slow"] = loadfx("vfx/treadfx/boat_wake_diveboat_splash_slow");
	level._effect["diveboat_submerge_splash"] = loadfx("vfx/water/diveboat_submerge_splash");
	level._effect["diveboat_submerge_trail"] = loadfx("vfx/water/diveboat_submerge_trail");
	level._effect["diveboat_emerge_splash"] = loadfx("vfx/water/diveboat_emerge_splash");
	level._effect["boat_wake_diveboat_foam_trail"] = loadfx("vfx/treadfx/boat_wake_diveboat_foam_trail");
	level._effect["vehicle_diveboat_death_water_ring"] = loadfx("vfx/explosion/vehicle_diveboat_death_water_ring");
}

//Function Number: 3
init_local()
{
	if(self.vehicletype != "diveboat_player")
	{
		self.playermech_rocket_targeting_allowed = 1;
		self enableaimassist();
		thread modifydamage();
		thread vehicle_death_add();
		thread ai_diveboats_chase_trail();
		soundscripts\_snd::snd_message("find_npc_dive_boat_handler");
		self.script_crashtypeoverride = "diveboat";
	}
}

//Function Number: 4
setanims()
{
	var_00[0] = spawnstruct();
	var_00[0].sittag = "tag_driver";
	var_00[0].getin = %hoverbike_mount_driver_dir1;
	var_00[0].getout = %hoverbike_dismount_driver;
	var_00[0].idle = %hoverbike_driving_idle_guy1;
	var_00[0].aianim_simple["hoverbike_driving_flashlight_left_guy1"] = %hoverbike_driving_flashlight_left_guy1;
	var_00[0].aianim_simple["hoverbike_driving_flashlight_right_guy1"] = %hoverbike_driving_flashlight_right_guy1;
	var_00[0].aianim_simple["hoverbike_driving_gesture_lft_guy1"] = %hoverbike_driving_gesture_lft_guy1;
	var_00[0].aianim_simple["hoverbike_driving_gesture_rt_guy1"] = %hoverbike_driving_gesture_rt_guy1;
	var_00[0].aianim_simple["hoverbike_driving_idle_guy1"] = %hoverbike_driving_idle_guy1;
	var_00[0].aianim_simple["hoverbike_driving_lean_left_idle_guy1"] = %hoverbike_driving_lean_left_idle_guy1;
	var_00[0].aianim_simple["hoverbike_driving_lean_left_into_guy1"] = %hoverbike_driving_lean_left_into_guy1;
	var_00[0].aianim_simple["hoverbike_driving_lean_left_out_guy1"] = %hoverbike_driving_lean_left_out_guy1;
	var_00[0].aianim_simple["hoverbike_driving_lean_right_idle_guy1"] = %hoverbike_driving_lean_right_idle_guy1;
	var_00[0].aianim_simple["hoverbike_driving_lean_right_into_guy1"] = %hoverbike_driving_lean_right_into_guy1;
	var_00[0].aianim_simple["hoverbike_driving_lean_right_out_guy1"] = %hoverbike_driving_lean_right_out_guy1;
	var_00[0].aianim_simple["hoverbike_driving_look_over_lft_shoulder_guy1"] = %hoverbike_driving_look_over_lft_shoulder_guy1;
	var_00[0].aianim_simple["hoverbike_driving_look_over_rt_shoulder_guy1"] = %hoverbike_driving_look_over_rt_shoulder_guy1;
	return var_00;
}

//Function Number: 5
set_vehicle_anims(param_00)
{
	param_00[0].vehicle_idle = %hoverbike_driving_idle_vehicle1;
	return param_00;
}

//Function Number: 6
setup_worldhands_anims()
{
	level.scr_anim["world_body"]["jetbike_drive_idle"] = %hoverbike_drive_idle_vm;
	level.scr_anim["world_body"]["jetbike_casual_drive_idle"] = %hoverbike_casual_vm;
	level.scr_anim["world_body"]["mount_jetbike"] = %det_exfil_droponbike_drop_vm;
	maps\_anim::addnotetrack_customfunction("world_body","bike_swap",::level_diveboat_to_vm_model,"mount_jetbike");
	maps\_anim::addnotetrack_notify("world_body","fov_start","exit_drive_FOV_start","mount_jetbike");
	maps\_anim::addnotetrack_notify("world_body","fov_end","exit_drive_FOV_end","mount_jetbike");
}

//Function Number: 7
setup_player_driving_anims()
{
	level.scr_anim["frankenbike_jetbike"]["jetbike_casual_drive_idle"] = %hoverbike_casual_vehicle;
	level.scr_anim["frankenbike_worldbody"]["jetbike_casual_drive_idle"] = %hoverbike_casual_vm;
	level.scr_anim["frankenbike_jetbike"]["idle_branch"] = %hoverbike_vehicle_idle_branch;
	level.scr_anim["frankenbike_jetbike"]["idle_slow_branch"] = %hoverbike_vehicle_idle_slow_branch;
	level.scr_anim["frankenbike_jetbike"]["idle_slow"] = %hoverbike_drive_idle_vehicle;
	level.scr_anim["frankenbike_jetbike"]["idle_slow_lt"] = %hoverbike_drive_idle_lt_vehicle;
	level.scr_anim["frankenbike_jetbike"]["idle_slow_rt"] = %hoverbike_drive_idle_rt_vehicle;
	level.scr_anim["frankenbike_jetbike"]["idle_fast_branch"] = %hoverbike_vehicle_idle_fast_branch;
	level.scr_anim["frankenbike_jetbike"]["idle_fast_throttle"] = %hoverbike_drive_idle_throttle_vehicle;
	level.scr_anim["frankenbike_jetbike"]["idle_fast_direction_branch"] = %hoverbike_vehicle_idle_fast_direction_branch;
	level.scr_anim["frankenbike_jetbike"]["idle_fast"] = %hoverbike_drive_fast_idle_vehicle;
	level.scr_anim["frankenbike_jetbike"]["idle_fast_lt"] = %hoverbike_drive_fast_idle_lt_vehicle;
	level.scr_anim["frankenbike_jetbike"]["idle_fast_rt"] = %hoverbike_drive_fast_idle_rt_vehicle;
	level.scr_anim["frankenbike_jetbike"]["jump_st"] = %hoverbike_drive_jump_st_vehicle;
	level.scr_anim["frankenbike_jetbike"]["jump_loop"] = %hoverbike_drive_jump_loop_vehicle;
	level.scr_anim["frankenbike_jetbike"]["jump_end"] = %hoverbike_drive_jump_end_vehicle;
	level.scr_anim["frankenbike_worldbody"]["idle_branch"] = %hoverbike_vm_idle_branch;
	level.scr_anim["frankenbike_worldbody"]["idle_slow_branch"] = %hoverbike_vm_idle_slow_branch;
	level.scr_anim["frankenbike_worldbody"]["idle_slow"] = %hoverbike_drive_idle_vm;
	level.scr_anim["frankenbike_worldbody"]["idle_slow_lt"] = %hoverbike_drive_idle_lt_vm;
	level.scr_anim["frankenbike_worldbody"]["idle_slow_rt"] = %hoverbike_drive_idle_rt_vm;
	level.scr_anim["frankenbike_worldbody"]["idle_fast_branch"] = %hoverbike_vm_idle_fast_branch;
	level.scr_anim["frankenbike_worldbody"]["idle_fast_throttle"] = %hoverbike_drive_idle_throttle_vm;
	level.scr_anim["frankenbike_worldbody"]["idle_fast_direction_branch"] = %hoverbike_vm_idle_fast_direction_branch;
	level.scr_anim["frankenbike_worldbody"]["idle_fast"] = %hoverbike_drive_fast_idle_vm;
	level.scr_anim["frankenbike_worldbody"]["idle_fast_lt"] = %hoverbike_drive_fast_idle_lt_vm;
	level.scr_anim["frankenbike_worldbody"]["idle_fast_rt"] = %hoverbike_drive_fast_idle_rt_vm;
	level.scr_anim["frankenbike_worldbody"]["jump_st"] = %hoverbike_drive_jump_st_vm;
	level.scr_anim["frankenbike_worldbody"]["jump_loop"] = %hoverbike_drive_jump_loop_vm;
	level.scr_anim["frankenbike_worldbody"]["jump_end"] = %hoverbike_drive_jump_end_vm;
	level.scr_anim["player_bike"]["jetbike_drive_idle"] = %hoverbike_drive_idle_vehicle;
	level.scr_anim["player_bike"]["jetbike_casual_drive_idle"] = %hoverbike_casual_vehicle;
	level.scr_anim["player_bike"]["mount_jetbike"] = %det_exfil_droponbike_drop_vmbike;
}

//Function Number: 8
modifydamage()
{
	self endon("death");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(var_04 == "MOD_PROJECTILE")
		{
			var_00 = self.maxhealth * 0.5;
			self dodamage(var_00,var_03,var_01,var_01,var_04);
		}
	}
}

//Function Number: 9
level_diveboat_to_vm_model(param_00)
{
	level.diveboat setmodel("vehicle_mil_hoverbike_vm");
}

//Function Number: 10
do_diveboat_threads()
{
	thread rumble_thread();
	thread handle_diveboat_collisions();
}

//Function Number: 11
stop_diveboat_threads()
{
	self notify("stop_diveboat_thread");
	self.rumble_entity.intensity = 0;
}

//Function Number: 12
handle_diveboat_collisions()
{
	self endon("death");
	self endon("stop_diveboat_thread");
	for(;;)
	{
		self waittill("veh_contact",var_00,var_01,var_02,var_03,var_04);
		if(isdefined(self.last_collision_time) && self.last_collision_time == gettime())
		{
			continue;
		}

		self.last_collision_time = gettime();
		var_05 = [];
		var_05["vehicle"] = self;
		var_05["hit_entity"] = var_00;
		var_05["pos"] = var_01;
		var_05["impulse"] = var_02;
		var_05["relativeVel"] = var_03;
		var_05["surface"] = var_04;
		soundscripts\_snd::snd_message("aud_impact_system_diveboat",var_05);
	}
}

//Function Number: 13
rumble_thread()
{
	level.player endon("death");
	self endon("stop_diveboat_thread");
	var_00 = 40;
	var_01 = 0.1;
	var_02 = 0.001;
	var_03 = 8;
	var_04 = 0.1;
	var_05 = 0;
	self.rumble_entity = maps\_utility::get_rumble_ent("steady_rumble");
	self.rumble_entity.intensity = 0;
	for(;;)
	{
		var_06 = var_05;
		var_05 = self vehicle_getspeed();
		if(self vehicle_diveboatissubmerged())
		{
			self.rumble_entity.intensity = 0;
		}
		else
		{
			var_07 = var_01 * clamp(var_05 / var_00,0,1);
			var_07 = var_07 * randomfloat(1);
			var_08 = 0;
			if(level.player attackbuttonpressed())
			{
				var_09 = var_05 - var_06;
				if(var_09 > 0)
				{
					var_08 = var_03 * clamp(1 - var_06 / var_05,var_02,1) - var_02;
				}
			}

			var_0A = 0;
			var_0B = abs(level.player getnormalizedmovement()[1]);
			if(var_0B > 0.3)
			{
				var_0A = var_0B * var_04;
			}

			self.rumble_entity.intensity = clamp(var_07 + var_08 + var_0A,0,1);
		}

		wait(0.1);
	}
}

//Function Number: 14
init_diveboat_weapon()
{
	precacheitem("diveboat_missile");
	precacheshader("veh_hud_friendly");
	precacheshader("uav_vehicle_target");
	precacheshader("hud_fofbox_hostile");
	level.diveboat_weapon_ammo_count = 4;
}

//Function Number: 15
diveboat_weapon_auto_targetting()
{
	self.team = "allies";
	if(isdefined(level.diveboat_weapon_target))
	{
		if(isai(level.diveboat_weapon_target))
		{
			self missile_settargetent(level.diveboat_weapon_target,(0,0,45));
		}
		else
		{
			self missile_settargetent(level.diveboat_weapon_target);
		}

		target_setshader(level.diveboat_weapon_target,"hud_fofbox_hostile");
		var_00 = level.diveboat_weapon_target;
		level.diveboat_weapon_target.diveboat_weapon_attacked = 1;
		level.diveboat_weapon_target = undefined;
		var_00 endon("death");
		var_00 common_scripts\utility::waittill_notify_or_timeout("damage",2.5);
		var_00.diveboat_weapon_attacked = undefined;
		target_setshader(var_00,"veh_hud_friendly");
	}
}

//Function Number: 16
get_npc_center_offset()
{
	if(isai(self) && isalive(self))
	{
		var_00 = self geteye()[2];
		var_01 = self.origin[2];
		var_02 = var_00 - var_01 / 2;
		return (0,0,var_02);
	}

	return (0,0,0);
}

//Function Number: 17
set_up_target()
{
	if(isdefined(self) && isdefined(self.script_parameters) && self.script_parameters == "diveboat_weapon_target")
	{
		target_set(self,get_npc_center_offset());
	}
}

//Function Number: 18
give_diveboat_weapons()
{
	maps\_utility::add_global_spawn_function("axis",::set_up_target);
	thread diveboat_weapon_targetting_system();
	thread diveboat_weapon_reloading_system();
	thread diveboat_weapon_fire_notify();
	thread diveboat_weapon_fire_system();
}

//Function Number: 19
remove_diveboat_weapons()
{
	maps\_utility::remove_global_spawn_function("axis",::set_up_target);
	level notify("remove_diveboat_weapon");
}

//Function Number: 20
diveboat_weapon_targetting_system()
{
	level endon("remove_diveboat_weapon");
	for(;;)
	{
		var_00 = target_getarray();
		var_01 = [];
		foreach(var_03 in var_00)
		{
			if(isdefined(var_03.ignore_target))
			{
				target_hidefromplayer(var_03,level.player);
				var_03.is_shown_to_player = undefined;
				continue;
			}

			if(isdefined(var_03.diveboat_weapon_attacked))
			{
				if(sighttracepassed(level.player.origin,var_03.origin,0,var_03,self))
				{
					if(!isdefined(var_03.is_shown_to_player))
					{
						target_showtoplayer(var_03,level.player);
						var_03.is_shown_to_player = 1;
					}

					target_setshader(var_03,"hud_fofbox_hostile");
				}
				else if(isdefined(var_03.is_shown_to_player))
				{
					target_hidefromplayer(var_03,level.player);
					var_03.is_shown_to_player = undefined;
				}

				continue;
			}

			if(target_isincircle(var_03,level.player,75,360) && sighttracepassed(level.player.origin,var_03.origin,0,var_03,self))
			{
				var_01[var_01.size] = var_03;
				if(!isdefined(var_03.is_shown_to_player))
				{
					target_showtoplayer(var_03,level.player);
					var_03.is_shown_to_player = 1;
				}

				target_setshader(var_03,"veh_hud_friendly");
				continue;
			}

			if(isdefined(var_03.is_shown_to_player))
			{
				target_hidefromplayer(var_03,level.player);
				var_03.is_shown_to_player = undefined;
			}
		}

		if(var_01.size > 0)
		{
			var_05 = var_01[0];
			var_06 = distance2dsquared(level.player.origin,var_05.origin);
			for(var_07 = 1;var_07 < var_01.size;var_07++)
			{
				var_08 = distance2dsquared(level.player.origin,var_01[var_07].origin);
				if(var_08 < var_06)
				{
					var_06 = var_08;
					var_05 = var_01[var_07];
				}
			}

			level.diveboat_weapon_target = var_05;
			target_setshader(var_05,"uav_vehicle_target");
		}

		wait(0.05);
	}
}

//Function Number: 21
diveboat_weapon_reloading_system()
{
	level endon("remove_diveboat_weapon");
	for(;;)
	{
		if(!isdefined(level.diveboat_weapon_firing) && level.diveboat_weapon_ammo_count < 4)
		{
			level.diveboat_weapon_ammo_count++;
			var_00 = level.diveboat_weapon_ammo_count / 4;
			level.diveboat_weapon_gauge_level = clamp(var_00,0.04,1);
		}

		wait(0.5);
	}
}

//Function Number: 22
diveboat_attack_button_pressed()
{
	var_00 = getdvarint("vehDiveboatControlScheme");
	if(var_00 == 1)
	{
		return self buttonpressed("BUTTON_LTRIG");
	}

	if(var_00 == 2)
	{
		return self buttonpressed("BUTTON_A");
	}

	return self buttonpressed("BUTTON_RTRIG");
}

//Function Number: 23
diveboat_weapon_fire_notify()
{
	level endon("remove_diveboat_weapon");
	for(;;)
	{
		if(level.player diveboat_attack_button_pressed() && level.diveboat_weapon_ammo_count > 0 && !self vehicle_diveboatissubmerged())
		{
			level.diveboat_weapon_firing = 1;
			level.player notify("LISTEN_attack_button_pressed");
			var_00 = 0;
			var_01 = 0;
			while(var_00 < 0.1)
			{
				if(!level.player diveboat_attack_button_pressed())
				{
					var_01 = 1;
				}

				var_00 = var_00 + 0.05;
				wait(0.05);
			}

			level.diveboat_weapon_firing = undefined;
			if(!var_01)
			{
				while(level.player diveboat_attack_button_pressed())
				{
					wait(0.05);
				}
			}

			continue;
		}

		wait(0.05);
	}
}

//Function Number: 24
diveboat_weapon_fire_system()
{
	level endon("remove_diveboat_weapon");
	for(;;)
	{
		level.player waittill("LISTEN_attack_button_pressed");
		level.diveboat_weapon_ammo_count--;
		var_00 = level.diveboat_weapon_ammo_count / 4;
		level.diveboat_weapon_gauge_level = clamp(var_00,0.04,1);
		var_01 = level.player getplayerangles();
		var_02 = level.player geteye() + 50 * anglestoup(var_01);
		var_03 = level.player geteye() + 500 * anglestoforward(var_01) + 80 * anglestoup(var_01);
		var_04 = magicbullet("diveboat_missile",var_02,var_03,level.player);
		var_04 thread diveboat_weapon_auto_targetting();
	}
}

//Function Number: 25
init_diveboat_weapon_gauge()
{
	level.diveboat_weapon_gauge_level = 1;
	if(isdefined(0) && 0)
	{
		precacheshader("hud_temperature_gauge");
		thread temp_diveboat_weapon_gauge();
	}
}

//Function Number: 26
setup_missile_launchers()
{
	self.missiletags = [];
	self.missiletagsready = [];
	self.missiletags[0] = "TAG_MISSILE1";
	self.missiletags[1] = "TAG_MISSILE2";
	self.missiletags[2] = "TAG_MISSILE3";
	self.missiletags[3] = "TAG_MISSILE4";
	self.missiletags[4] = "TAG_MISSILE5";
	self.missiletags[5] = "TAG_MISSILE6";
	self.missiledooropen = 0;
	thread vehicle_scripts\_vehicle_missile_launcher_ai::reload_launchers();
}

//Function Number: 27
missile_door_open()
{
	self setanimknobrestart(%atlas_speedboat_hatch_l_open,0.9,0);
	self setanimlimited(%atlas_speedboat_hatch_l_root,1,0);
	self setanimknobrestart(%atlas_speedboat_hatch_r_open,0.9,0);
	self setanimlimited(%atlas_speedboat_hatch_r_root,1,0);
	wait(getanimlength(%atlas_speedboat_hatch_l_open));
}

//Function Number: 28
missile_door_close()
{
	self setanimlimited(%atlas_speedboat_hatch_l_root,0.01,0.5);
	self setanimlimited(%atlas_speedboat_hatch_r_root,0.01,0.5);
	wait(getanimlength(%atlas_speedboat_hatch_l_open));
}

//Function Number: 29
fire_missles_at_target_array(param_00,param_01,param_02)
{
	vehicle_scripts\_vehicle_missile_launcher_ai::fire_missles_at_target_array(param_00,param_01,undefined,param_02);
}

//Function Number: 30
setup_and_fire_missles_at_guys_repeated(param_00,param_01)
{
	self endon("death");
	if(self.vehicletype != "diveboat_player")
	{
		setup_missile_launchers();
		self.missile_auto_reload = 1;
		self useanimtree(#animtree);
		self setanim(%atlas_speedboat_idle,1,0,1);
	}

	if(!isdefined(param_01))
	{
		param_01 = 2;
	}

	vehicle_scripts\_vehicle_missile_launcher_ai::fire_missles_at_target_array_repeated(param_00,::missile_door_open,1,1,1,"diveboats",1,param_01);
}

//Function Number: 31
temp_diveboat_weapon_gauge()
{
	var_00 = 610;
	var_01 = 250;
	var_02 = 156;
	var_03 = int(15);
	var_04 = newhudelem();
	var_04.x = var_00 - 0.5 * 30 - var_03;
	var_04.y = var_01 - int(40);
	var_04.alignx = "right";
	var_04.aligny = "bottom";
	var_04.horzalign = "fullscreen";
	var_04.vertalign = "fullscreen";
	var_04.color = (0.1,0.6,0.1);
	var_04 setshader("white",var_03,int(var_02 * level.diveboat_weapon_gauge_level));
	var_05 = newhudelem();
	var_05.x = var_00;
	var_05.y = var_01;
	var_05.alignx = var_04.alignx;
	var_05.aligny = var_04.aligny;
	var_05.horzalign = var_04.horzalign;
	var_05.vertalign = var_04.vertalign;
	var_05.color = (1,1,1);
	var_05 setshader("hud_temperature_gauge",30,200);
	var_06 = 0.05;
	for(;;)
	{
		if(isdefined(level.player.drivingvehicle))
		{
			var_04.alpha = 1;
			var_05.alpha = 1;
			var_07 = level.diveboat_weapon_gauge_level;
			var_04 scaleovertime(var_06,var_03,int(var_02 * var_07));
			if(var_07 > 0.5)
			{
				var_04.color = (0.1,0.6,0.1);
			}
			else if(var_07 > 0.2)
			{
				var_04.color = (1,1,0.1);
			}
			else
			{
				var_04.color = (1,0.1,0.1);
			}
		}
		else
		{
			var_04.alpha = 0;
			var_05.alpha = 0;
		}

		wait(var_06);
	}
}

//Function Number: 32
vehicle_death_add()
{
	var_00 = undefined;
	var_01 = undefined;
	while(isalive(self) && !issubstr(self.model,"dstrypv"))
	{
		var_00 = self.origin;
		wait 0.05;
	}

	thread vehicle_death_add_remove_carcass();
	var_02 = bullettrace(var_00 + (0,0,500),var_00 + (0,0,-100),0,self,0,0,0,0,0);
	if(isdefined(var_02["surfacetype"]) && issubstr(var_02["surfacetype"],"water"))
	{
		var_03 = var_02["position"];
	}
	else
	{
		return;
	}

	var_04 = common_scripts\utility::spawn_tag_origin();
	var_04.origin = (var_00[0],var_00[1],var_03[2]);
	var_04.angles = (270,0,0);
	playfxontag(common_scripts\utility::getfx("vehicle_diveboat_death_water_ring"),var_04,"tag_origin");
	wait(3);
	stopfxontag(common_scripts\utility::getfx("vehicle_diveboat_death_water_ring"),var_04,"tag_origin");
	var_04 delete();
}

//Function Number: 33
vehicle_death_add_remove_carcass()
{
	wait(0.25);
	if(isremovedentity(self))
	{
		return;
	}

	if(isdefined(level.player.underwater) && level.player.underwater)
	{
		var_00 = getdvarint("cg_fov");
		while(level.player worldpointinreticle_circle(self.origin,var_00,350))
		{
			wait 0.05;
			if(isremovedentity(self))
			{
				return;
			}
		}

		self delete();
		return;
	}

	self delete();
}

//Function Number: 34
ai_diveboats_chase_trail()
{
	self endon("death");
	var_00 = bullettrace(self.origin + (0,0,500),self.origin + (0,0,-100),0,self,0,0,0,0,0);
	if(isdefined(var_00["surfacetype"]) && issubstr(var_00["surfacetype"],"water"))
	{
		var_01 = var_00["position"];
	}
	else
	{
		var_01 = self.origin;
	}

	thread ai_diveboat_foam_trail(var_01[2]);
	while(isdefined(self) && isalive(self) && !issubstr(self.model,"dstrypv"))
	{
		var_02 = self vehicle_getspeed();
		if(self vehicle_diveboatissubmerged())
		{
			continue;
		}

		var_03 = self.origin[2] - var_01[2];
		if(var_03 <= 15)
		{
			if(var_02 > 35)
			{
				playfxontag(common_scripts\utility::getfx("boat_wake_diveboat_splash_fast"),self,"tag_origin");
			}
			else if(var_02 <= 35 && var_02 >= 10)
			{
				playfxontag(common_scripts\utility::getfx("boat_wake_diveboat_splash_slow"),self,"tag_origin");
			}
			else if(var_02 < 10)
			{
			}
		}

		wait(0.3);
	}

	self notify("boat_dead");
}

//Function Number: 35
ai_diveboat_foam_trail(param_00)
{
	self endon("boat_dead");
	var_01 = self vehicle_diveboatissubmerged();
	var_02 = 0;
	var_03 = common_scripts\utility::spawn_tag_origin();
	playfxontag(common_scripts\utility::getfx("boat_wake_diveboat_foam_trail"),var_03,"tag_origin");
	while(isdefined(self) && isalive(self) && !issubstr(self.model,"dstrypv"))
	{
		var_03.origin = (self.origin[0],self.origin[1],param_00);
		var_03.angles = (0,self.angles[1],0);
		if(isdefined(self))
		{
			var_01 = self vehicle_diveboatissubmerged();
			if(var_01 != var_02)
			{
				if(var_01)
				{
					playfxontag(common_scripts\utility::getfx("diveboat_submerge_splash"),var_03,"tag_origin");
					playfxontag(common_scripts\utility::getfx("diveboat_submerge_trail"),self,"tag_origin");
					stopfxontag(common_scripts\utility::getfx("boat_wake_diveboat_foam_trail"),var_03,"tag_origin");
				}
				else
				{
					playfxontag(common_scripts\utility::getfx("diveboat_emerge_splash"),var_03,"tag_origin");
					playfxontag(common_scripts\utility::getfx("boat_wake_diveboat_foam_trail"),var_03,"tag_origin");
					stopfxontag(common_scripts\utility::getfx("diveboat_submerge_splash"),var_03,"tag_origin");
				}

				var_02 = var_01;
				wait(0.05);
			}
		}

		wait(0.05);
	}

	wait(0.05);
	stopfxontag(common_scripts\utility::getfx("boat_wake_diveboat_foam_trail"),var_03,"tag_origin");
	var_03 delete();
}

//Function Number: 36
diveboat_audio()
{
	self endon("death");
	var_00 = spawnstruct();
	var_00.player_mode = 1;
	var_00.preset_name = "diveboat";
	var_01 = ::vehicle_scripts\_diveboat_aud::diveboat_constructor;
	soundscripts\_snd::snd_message("snd_register_vehicle",var_00.preset_name,var_01);
	if(var_00.player_mode == 1)
	{
		soundscripts\_snd::snd_message("snd_start_vehicle",var_00);
	}

	common_scripts\utility::flag_wait("flag_objective_boat_chase_complete");
	maps\_utility::delaythread(5,::soundscripts\_snd::snd_message,"snd_stop_vehicle");
}