/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _player_land_assist.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 42
 * Decompile Time: 618 ms
 * Timestamp: 4/22/2024 2:22:18 AM
*******************************************************************/

//Function Number: 1
land_assist_init()
{
	common_scripts\utility::flag_init("boost_added");
	common_scripts\utility::flag_init("no_land_assist_hint");
	common_scripts\utility::flag_init("no_land_assist_force_hint");
	level.player.land_assist["current_height"] = 0;
	level.player.land_assist["player_vel"] = (0,0,0);
	level.player.land_assist["stick_input"] = (0,0,0);
	level.player.land_assist["boost_fuel"] = 1000;
	setdvar("landassist_step1_goal_velocity",20);
	setdvar("landassist_step1_duration",0.25);
	setdvar("landassist_step2_gravity",20);
	setdvar("landassist_step2_duration",0.25);
	setdvar("landassist_step3_gravity",level.player getgravity() * 0.15);
	setdvar("landassist_do_reduced_damage",1);
	setomnvar("ui_meterhud_enable",1);
	setomnvar("ui_meterhud_ar_and_2d",0);
	setomnvar("ui_meterhud_text",2);
	setomnvar("ui_meterhud_level",1);
	setomnvar("ui_meterhud_toggle",0);
	if(1)
	{
		setdvar("landassist_step1_goal_velocity",10);
		setdvar("landassist_step1_duration",1);
		setdvar("landassist_step2_duration",0.5);
		setdvar("landassist_step2_gravity",100);
	}

	level.player.land_assist_activated = 0;
	level.player.show_land_assist_help = 1;
	level.player.land_assist["elevation"] = 0;
	level.player thread precache_player_land_assist();
	level.player thread setup_reminder_volumes();
	maps\_utility::add_hint_string("player_land_assist_hint",&"SEOUL_LANDASSIST_HINT",::land_assist_hint_breakout);
	maps\_utility::add_hint_string("player_land_assist_hint_force",&"SEOUL_LANDASSIST_HINT",::land_assist_hint_force_breakout);
}

//Function Number: 2
force_play_land_assist_hint()
{
	thread maps\_utility::display_hint("player_land_assist_hint_force");
}

//Function Number: 3
land_assist_hint_force_breakout()
{
	if(!level.player.is_in_force_vol)
	{
		return 1;
	}

	if(level.player.land_assist_activated)
	{
		return 1;
	}

	return 0;
}

//Function Number: 4
setup_reminder_volumes()
{
	var_00 = getentarray("vol_land_assist_reminder","targetname");
	if(var_00.size <= 0)
	{
		return;
	}

	level endon("e3_presentation");
	for(;;)
	{
		foreach(var_02 in var_00)
		{
			if(level.player istouching(var_02) & !level.player.land_assist_activated & level.player.show_land_assist_help)
			{
				thread maps\_utility::display_hint("player_land_assist_hint");
				level.land_assist_current_vol = var_02;
				while(!level.player.land_assist_activated && level.player istouching(var_02))
				{
					wait 0.05;
				}
			}

			if(level.player istouching(var_02) && level.player.land_assist_activated && level.player.show_land_assist_help)
			{
				level notify("land_assist_reminder",var_02);
			}

			wait 0.05;
		}
	}
}

//Function Number: 5
land_assist_hint_breakout()
{
	if(!isdefined(level.land_assist_current_vol))
	{
		return 0;
	}

	if(!level.player.land_assist_activated && level.player istouching(level.land_assist_current_vol))
	{
		return 0;
	}

	return 1;
}

//Function Number: 6
clear_land_assist()
{
	self waittill("clear_land_assist_process");
	self notify("end_jump_assist");
	level.player resetgravityoverride();
	self notify("kill_land_assist_process");
	self.land_assist_activated = 0;
	level.player setcandamage(1);
	level.player enablereload(1);
	disable_boost_hud();
}

//Function Number: 7
monitor_land_assist_think()
{
	self notify("kill_land_assist_process");
	self endon("kill_land_assist_process");
	self endon("clear_land_assist_process");
	self endon("death");
	self.land_assist_activated = 1;
	self.last_exo_movement_time = 0;
	thread clear_land_assist();
	thread handle_hover_hud();
	thread handle_fuel_usage();
	thread handle_fuel_refill();
	thread monitor_player_input();
	thread monitor_on_ground();
	thread monitor_player_boost();
	thread track_player_velocity();
	thread track_player_height();
	thread track_player_movement();
	for(;;)
	{
		waittill_player_fall();
		handle_land_assist();
		wait 0.05;
	}
}

//Function Number: 8
handle_land_assist()
{
	self endon("end_jump_assist");
	thread cleanup_land_assist();
	player_soft_land_alt();
}

//Function Number: 9
cleanup_land_assist()
{
}

//Function Number: 10
waittill_land_assist_ended()
{
}

//Function Number: 11
waittill_player_fall()
{
	level.player endon("death");
	self.old_z = self.origin[2];
	var_00 = undefined;
	var_01 = undefined;
	while(level.player isonground())
	{
		var_00 = level.player.origin;
		wait 0.05;
	}

	while(level.player getvelocity()[2] >= -26.6)
	{
		wait 0.05;
	}
}

//Function Number: 12
init_land_assist_player_rig()
{
	self endon("death");
	self endon("end_jump_assist");
	if(isdefined(level.player.land_assist_rig))
	{
		level.player.land_assist_rig delete();
	}

	waittillframeend;
	if(isdefined(level.scr_anim["player_rig"]) && isdefined(level.scr_anim["player_rig"]["land_assist_legs"]))
	{
		level.player.land_assist_rig = maps\_utility::spawn_anim_model("player_rig");
		level.player.land_assist_rig hide();
		level.player.land_assist_rig.angles = level.player getgunangles();
		level.player.land_assist_rig linktoplayerview(level.player,"tag_origin",(32,0,0),(-90,0,0),1);
	}

	for(;;)
	{
		level.player waittill("landassist_button");
		level.player.land_assist_rig show();
		level.player maps\_anim::anim_single_solo(level.player.land_assist_rig,"land_assist_legs");
		level.player.land_assist_rig hide();
	}
}

//Function Number: 13
player_soft_land_alt()
{
	self endon("death");
	self endon("end_jump_assist");
	level.player enablereload(0);
	var_00 = (0,0,0);
	level.player playersetgroundreferenceent(undefined);
	if(!isdefined(self.land_assist_light))
	{
		self.land_assist_light = common_scripts\utility::spawn_tag_origin();
	}

	var_01 = getdvarfloat("landassist_step3_gravity");
	level.player.land_assist_available_startime = 0;
	thread process_screen_shake();
	while(!level.player isonground())
	{
		level.player setcandamage(0);
		var_00 = level.player getvelocity();
		var_02 = 0;
		if(level.player.land_assist_available_startime == 0)
		{
			level.player.land_assist_available_startime = gettime();
		}

		if(is_land_assist_activated())
		{
			var_03 = 1;
			level.player notify("landassist_button");
			if(var_03)
			{
				var_04 = getdvarfloat("landassist_step1_goal_velocity");
				var_05 = getdvarfloat("landassist_step1_duration");
				var_06 = getdvarfloat("landassist_step2_duration");
				var_07 = getdvarfloat("landassist_step2_gravity");
				var_08 = gettime() + var_05 * 1000;
				var_09 = gettime() + var_05 + var_06 * 1000;
				var_00 = level.player getvelocity();
				var_04 = max(var_04,var_00[2] + 20);
				var_0A = var_04 - var_00[2] / var_05;
				level.player setgravityoverride(-1 * int(var_0A));
				while(is_land_assist_activated())
				{
					var_00 = level.player getvelocity();
					if(gettime() > var_08)
					{
						level.player setgravityoverride(int(var_07));
						if(gettime() > var_09)
						{
							break;
						}
					}

					do_rumble();
					do_exhaust_fx();
					level.player notify("use_fuel");
					wait 0.05;
					var_02 = 1;
				}
			}

			if(level.player isonground())
			{
				break;
			}

			level.player setgravityoverride(int(var_01));
			while(is_land_assist_activated())
			{
				var_00 = level.player getvelocity();
				var_0B = perlinnoise2d(0,gettime() * 0.001 * 0.5,2,2,0.5) * 75;
				var_0C = perlinnoise2d(1,gettime() * 0.001 * 0.5,2,2,0.5) * 10;
				var_0D = perlinnoise2d(2,gettime() * 0.001 * 0.5,2,2,0.5) * 10;
				var_0E = self getnormalizedmovement();
				if(length(var_0E) <= 0.01)
				{
					self setvelocity((var_00[0] * 0.3,var_00[1] * 0.3,var_00[2] + var_0B));
				}
				else
				{
					self setvelocity((var_00[0],var_00[1],var_00[2] + var_0B));
				}

				self.land_assist_light.origin = self.origin;
				do_exhaust_fx();
				level.player notify("use_fuel");
				wait 0.05;
				var_02 = 1;
			}
		}

		if(!is_land_assist_activated())
		{
			level.player resetgravityoverride();
			level notify("snd_boost_land_lp_stop_notify");
		}

		if(!var_02)
		{
			wait 0.05;
		}
	}

	level.player setcandamage(1);
	level.player enablereload(1);
	level.player resetgravityoverride();
	level.player do_custom_fall_damage(var_00[2]);
	thread delayed_delete_light(1);
	level notify("snd_boost_land_lp_stop_notify");
	self notify("end_jump_hud");
}

//Function Number: 14
restore_reload()
{
	common_scripts\utility::waittill_either("end_jump_assist");
}

//Function Number: 15
do_custom_fall_damage(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_02 = 0;
	var_03 = get_fall_damage_from_speed(param_00);
	if(var_03 > 0)
	{
		var_04 = level.player.health;
		var_02 = level.player dodamage(var_03,self.origin,self,level.player,"MOD_FALLING");
	}

	if(param_01)
	{
		return var_02;
	}

	return var_03;
}

//Function Number: 16
process_screen_shake()
{
	self endon("death");
	self endon("end_jump_assist");
	self endon("end_jump_hud");
	var_00 = 1;
	var_01 = 1;
	while(!level.player isonground())
	{
		if(is_land_assist_activated())
		{
			screenshake(self.origin,2,0.5,0.5,var_00,0.01,0.2,1000,5,3.175,3.125);
			wait(var_00);
			while(is_land_assist_activated())
			{
				screenshake(self.origin,0.5,0.25,0.25,var_01,0.01,0.2,1000,5,1.175,1.125);
				wait(var_01);
			}

			continue;
		}

		wait 0.05;
	}
}

//Function Number: 17
do_rumble()
{
	level.player playrumbleonentity("damage_light");
}

//Function Number: 18
do_exhaust_fx()
{
	level.player soundscripts\_snd::snd_message("boost_land_use_fuel","snd_boost_land_lp_stop_notify");
	if(!isdefined(level.player.landassist_fx_counter))
	{
		level.player.landassist_fx_counter = 0;
	}

	level.player.landassist_fx_counter++;
	var_00 = anglestoforward(level.player getplayerangles());
	if(level.player.landassist_fx_counter % 5 == 0)
	{
		playfx(common_scripts\utility::getfx("landass_impact_smk_vm"),self.land_assist["ground_location"],var_00);
	}

	if(common_scripts\utility::cointoss())
	{
		var_01 = (self.origin[0],self.origin[1],self.origin[2]);
		playfx(common_scripts\utility::getfx("landass_exhaust_smk_vm"),var_01,var_00);
	}
}

//Function Number: 19
is_land_assist_activated()
{
	return self usebuttonpressed() && !level.player isonground() && level.player.land_assist["boost_fuel"] > 0 && level.player getvelocity()[2] < -26.6 && gettime() - level.player.last_exo_movement_time > 1500;
}

//Function Number: 20
delayed_delete_light(param_00)
{
	level.aud.boost_land_first_shot = 1;
	self.land_assist_light endon("cancel_delete");
	self.land_assist_light delete();
}

//Function Number: 21
handle_hover_hud()
{
	thread enable_boost_hud();
}

//Function Number: 22
get_perlin_noise_position(param_00,param_01,param_02)
{
	return (perlinnoise2d(gettime() * 0.001 * 0.05,10,param_00,param_01,param_02),perlinnoise2d(gettime() * 0.001 * 0.05,20,param_00,param_01,param_02),perlinnoise2d(gettime() * 0.001 * 0.05,30,param_00,param_01,param_02));
}

//Function Number: 23
track_player_velocity()
{
	self endon("death");
	self endon("end_jump_assist");
	self endon("clear_land_assist_process");
	for(;;)
	{
		self.land_assist["player_vel"] = self getvelocity();
		wait 0.05;
	}
}

//Function Number: 24
track_player_height()
{
	self endon("death");
	self endon("end_jump_assist");
	self endon("clear_land_assist_process");
	for(;;)
	{
		var_00 = playerphysicstrace(self.origin,self.origin - (0,0,10000),self);
		var_01 = var_00[2];
		self.land_assist["current_height"] = self.origin[2] - var_01;
		self.land_assist["ground_location"] = var_00;
		luinotifyevent(&"update_landassist_elevation",1,int(self.land_assist["current_height"]));
		wait 0.05;
	}
}

//Function Number: 25
monitor_on_ground()
{
	self endon("death");
	self endon("end_jump_assist");
	self endon("clear_land_assist_process");
	var_00 = 0;
	var_01 = 1;
	var_02 = 2;
	var_03 = 0;
	for(;;)
	{
		var_04 = var_03;
		if(self isonground())
		{
			var_03 = var_00;
			self notify("player_is_on_ground");
		}
		else if(bullettracepassed(self.origin,self.origin - (0,0,39.56),0,self))
		{
			var_03 = var_02;
		}
		else if(var_04 == var_00)
		{
			var_03 = var_01;
		}

		if(var_04 != var_03)
		{
			if(var_03 == var_02)
			{
				self notify("full_fall");
			}
			else if(var_03 == var_00 && var_04 == var_02)
			{
				self notify("land_after_full_fall");
			}
		}

		wait 0.05;
	}
}

//Function Number: 26
monitor_player_boost()
{
	for(;;)
	{
		var_00 = level.player common_scripts\utility::waittill_any_return("exo_slide","exo_dodge","ground_slam");
		self.last_exo_movement_time = gettime();
	}
}

//Function Number: 27
precache_player_land_assist()
{
	precacheshader("white");
	precacherumble("heavy_1s");
	precacherumble("heavy_2s");
	precachestring(&"update_landassist_fuel_level");
	precachestring(&"update_landassist_elevation");
	precache_boost_fx_player();
	level.hud_params = spawnstruct();
}

//Function Number: 28
monitor_player_input()
{
	level.player notifyonplayercommand("dpad_down","+actionslot 2");
	level.player notifyonplayercommand("dpad_left","+actionslot 3");
	level.player notifyonplayercommand("dpad_right","+actionslot 4");
	level.player notifyonplayercommand("dpad_up","+actionslot 1");
	level.player notifyonplayercommand("a_pressed","+gostand");
	level.player notifyonplayercommand("b_pressed","+stance");
	level.player notifyonplayercommand("y_pressed","weapnext");
	level.player notifyonplayercommand("x_pressed","+usereload");
	level.player notifyonplayercommand("attack_pressed","+attack");
}

//Function Number: 29
enable_boost_hud()
{
	var_00 = level.player.land_assist["boost_fuel"] / 1000;
	level.player setclientomnvar("ui_meterhud_toggle",1);
	level.player setclientomnvar("ui_meterhud_level",var_00);
	level.player soundscripts\_snd::snd_message("boost_land_hud_enable");
}

//Function Number: 30
disable_boost_hud()
{
	level.player setclientomnvar("ui_meterhud_toggle",0);
	level.player soundscripts\_snd::snd_message("boost_land_hud_disable");
}

//Function Number: 31
fuel_update_hud()
{
	var_00 = level.player.land_assist["boost_fuel"] / 1000;
	level.player setclientomnvar("ui_meterhud_level",var_00);
}

//Function Number: 32
int_clamp(param_00,param_01,param_02)
{
	if(param_00 < param_01)
	{
		return param_01;
	}

	if(param_00 > param_02)
	{
		return param_02;
	}

	return param_00;
}

//Function Number: 33
handle_fuel_usage()
{
	self endon("end_jump_assist");
	self endon("clear_land_assist_process");
	for(;;)
	{
		var_00 = level.player common_scripts\utility::waittill_any_return("use_fuel","player_is_on_ground","death");
		if(!isdefined(var_00) || var_00 == "death")
		{
			return;
		}

		if(var_00 == "player_is_on_ground")
		{
			continue;
		}

		level.player.land_assist["boost_fuel"] = int_clamp(level.player.land_assist["boost_fuel"] - 5,0,1000);
		fuel_update_hud();
	}

	level.player notify("out_of_boost");
}

//Function Number: 34
handle_fuel_refill()
{
	level.player endon("end_jump_assist");
	level.player endon("clear_land_assist_process");
	level.player waittill("use_fuel");
	for(;;)
	{
		thread fuel_refresh_time();
		level.player common_scripts\utility::waittill_any("fuel_refresh_time_done","use_fuel");
	}
}

//Function Number: 35
fuel_refresh_time(param_00)
{
	level.player endon("use_fuel");
	wait(5);
	while(level.player.land_assist["boost_fuel"] < 1000)
	{
		level.player.land_assist["boost_fuel"] = int_clamp(level.player.land_assist["boost_fuel"] + 5,0,1000);
		fuel_update_hud();
		wait 0.05;
	}

	level.player notify("fuel_refresh_time_done");
}

//Function Number: 36
player_check_distance_to_ground()
{
	var_00 = playerphysicstrace(self.origin,self.origin - (0,0,5000));
	return var_00[2];
}

//Function Number: 37
player_check_distance_to_ceiling()
{
	var_00 = playerphysicstrace(self.origin,self.origin + (0,0,5000));
	return var_00[2];
}

//Function Number: 38
precache_boost_fx_player()
{
	level._effect["landass_exhaust_smk_vm"] = loadfx("vfx/smoke/landass_exhaust_smk_vm");
	level._effect["landass_impact_smk_vm"] = loadfx("vfx/smoke/landass_impact_smk_vm");
}

//Function Number: 39
track_player_movement()
{
	self endon("death");
	self endon("clear_land_assist_process");
	for(;;)
	{
		var_00 = self getnormalizedmovement();
		var_00 = (var_00[0],var_00[1] * -1,0);
		var_01 = self.angles;
		var_02 = vectortoangles(var_00);
		var_03 = common_scripts\utility::flat_angle(combineangles(var_01,var_02));
		var_04 = anglestoforward(var_03) * length(var_00);
		self.land_assist["stick_input"] = var_04;
		wait(0.05);
	}
}

//Function Number: 40
debug_hudinfo_landassist()
{
	level.jump_reach_status = newhudelem();
	level.jump_reach_status.x = 300;
	level.jump_reach_status.y = 0;
	level.jump_reach_status.fontscale = 1;
	level.jump_reach_status.alignx = "left";
	level.jump_reach_status.aligny = "top";
	level.jump_reach_status.horzalign = "left";
	level.jump_reach_status.vertalign = "top";
	level.jump_reach_status.sort = 1;
	level.jump_reach_status thread destroy_hud_elem_landassist();
	level.fall_speed_status = newhudelem();
	level.fall_speed_status.x = 300;
	level.fall_speed_status.y = 10;
	level.fall_speed_status.fontscale = 1;
	level.fall_speed_status.alignx = "left";
	level.fall_speed_status.aligny = "top";
	level.fall_speed_status.horzalign = "left";
	level.fall_speed_status.vertalign = "top";
	level.fall_speed_status.sort = 1;
	level.fall_speed_status thread destroy_hud_elem_landassist();
	level.current_elevation = newhudelem();
	level.current_elevation.x = 300;
	level.current_elevation.y = 20;
	level.current_elevation.fontscale = 1;
	level.current_elevation.alignx = "left";
	level.current_elevation.aligny = "top";
	level.current_elevation.horzalign = "left";
	level.current_elevation.vertalign = "top";
	level.current_elevation.sort = 1;
	level.current_elevation thread destroy_hud_elem_landassist();
	level.elevation_to_target = newhudelem();
	level.elevation_to_target.x = 300;
	level.elevation_to_target.y = 30;
	level.elevation_to_target.fontscale = 1;
	level.elevation_to_target.alignx = "left";
	level.elevation_to_target.aligny = "top";
	level.elevation_to_target.horzalign = "left";
	level.elevation_to_target.vertalign = "top";
	level.elevation_to_target.sort = 1;
	level.elevation_to_target thread destroy_hud_elem_landassist();
	level.height_warning = newhudelem();
	level.height_warning.x = 300;
	level.height_warning.y = 40;
	level.height_warning.fontscale = 1;
	level.height_warning.alignx = "left";
	level.height_warning.aligny = "top";
	level.height_warning.horzalign = "left";
	level.height_warning.vertalign = "top";
	level.height_warning.sort = 1;
	level.height_warning thread destroy_hud_elem_landassist();
}

//Function Number: 41
destroy_hud_elem_landassist()
{
	level.player common_scripts\utility::waittill_any("death","end_jump_assist","clear_land_assist_process");
	self destroy();
}

//Function Number: 42
get_fall_damage_from_speed(param_00,param_01)
{
	var_02 = param_00;
	var_03 = undefined;
	var_04 = param_00 * param_00 / 2 * getdvarfloat("g_gravity");
	var_05 = getdvarfloat("bg_fallDamageMinHeight");
	var_06 = getdvarfloat("bg_fallDamageMaxHeight");
	var_07 = 100;
	var_08 = var_04 - var_05 / var_06 - var_05;
	if(var_04 >= var_06)
	{
		var_03 = var_07;
	}
	else if(var_08 < 0)
	{
		var_03 = 0;
	}
	else
	{
		var_03 = var_08 * var_07;
	}

	if(getdvarint("landassist_do_reduced_damage"))
	{
		if(var_03 > level.player.health - 1 && param_00 > -850)
		{
			var_03 = level.player.health - 1;
		}
	}

	return var_03;
}