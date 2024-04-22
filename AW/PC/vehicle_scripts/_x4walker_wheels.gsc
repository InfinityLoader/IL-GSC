/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _x4walker_wheels.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 32
 * Decompile Time: 466 ms
 * Timestamp: 4/22/2024 2:05:41 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02)
{
	precachemodel("vehicle_vm_x4walker_wheels");
	precachemodel("projectile_rpg7");
	precacheshader("hud_exo_poly_cool");
	precacheshader("hud_exo_circle_hot");
	precacheitem("mobile_turret_missile");
	maps\_utility::set_console_status();
	maps\_vehicle::build_template("x4walker_wheels",param_00,param_01,param_02);
	maps\_vehicle::build_localinit(::local_init);
	maps\_vehicle::build_life(999,500,1500);
	maps\_vehicle::build_team("allies");
	maps\_vehicle::build_mainturret();
	maps\_vehicle::build_shoot_shock("mobile_turret_shoot");
	maps\_vehicle::build_aianims(::set_ai_anims);
	maps\_vehicle::build_drive(%x4walker_wheels_drive_idle,%x4walker_wheels_drive_idle,3.36);
	maps\_vehicle::build_treadfx();
	build_walker_death(param_02);
	register_vehicle_anims(param_02);
	register_player_anims();
	register_fx();
}

//Function Number: 2
build_walker_death(param_00)
{
	level._effect["walkerexplode"] = loadfx("vfx/explosion/vehicle_x4walker_explosion");
	maps\_vehicle::build_deathmodel("vehicle_x4walker_wheels","vehicle_x4walker_wheels_dstrypv");
	maps\_vehicle::build_deathfx("vfx/explosion/vehicle_x4walker_explosion","TAG_DEATH_FX");
	maps\_vehicle::build_deathquake(1,1.6,625);
	maps\_vehicle::build_radiusdamage((0,0,32),300,200,0,0);
}

//Function Number: 3
register_vehicle_anims(param_00)
{
	maps\_vehicle_shg::add_vehicle_anim(param_00,"idle",%x4walker_wheels_idle);
	maps\_vehicle_shg::add_vehicle_anim(param_00,"cockpit_idle",%x4walker_wheels_cockpit_idle);
}

//Function Number: 4
register_fx()
{
	level._effect["x4walker_wheels_rpg_fv"] = loadfx("vfx/muzzleflash/x4walker_wheels_rpg_fv");
}

//Function Number: 5
local_init()
{
	self useanimtree(#animtree);
	thread vehicle_scripts\_x4walker_wheels_aud::snd_init_x4_walker_wheels();
	thread monitor_vehicle_mount();
	thread animation_think();
	thread monitor_wheel_movements();
	thread monitor_walker_death_stop_sounds();
	waittillframeend;
	self notify("stop_vehicle_shoot_shock");
}

//Function Number: 6
set_ai_anims()
{
	var_00 = [];
	var_00[0] = spawnstruct();
	var_00[0].sittag = "tag_guy";
	var_00[0].idle = %x4walker_wheels_idle_npc;
	return var_00;
}

//Function Number: 7
register_player_anims()
{
	level.scr_anim["_vehicle_player_rig"]["enter_left"] = %x4walker_wheels_cockpit_in_l_vm;
	level.scr_anim["_vehicle_player_rig"]["enter_right"] = %x4walker_wheels_cockpit_in_r_vm;
	level.scr_anim["_vehicle_player_rig"]["enter_back"] = %x4walker_wheels_cockpit_in_b_vm;
	level.scr_anim["_vehicle_player_rig"]["exit_left"] = %x4walker_wheels_cockpit_out_l_vm;
	level.scr_anim["_vehicle_player_rig"]["exit_right"] = %x4walker_wheels_cockpit_out_r_vm;
	level.scr_anim["_vehicle_player_rig"]["exit_back"] = %x4walker_wheels_cockpit_out_b_vm;
	maps\_anim::addnotetrack_customfunction("_vehicle_player_rig","cockpit_swap",::swap_cockpit_model,"enter_left");
	maps\_anim::addnotetrack_customfunction("_vehicle_player_rig","cockpit_swap",::swap_cockpit_model,"enter_right");
	maps\_anim::addnotetrack_customfunction("_vehicle_player_rig","cockpit_swap",::swap_cockpit_model,"enter_back");
	maps\_anim::addnotetrack_customfunction("_vehicle_player_rig","cockpit_swap",::swap_world_model,"exit_left");
	maps\_anim::addnotetrack_customfunction("_vehicle_player_rig","cockpit_swap",::swap_world_model,"exit_right");
	maps\_anim::addnotetrack_customfunction("_vehicle_player_rig","cockpit_swap",::swap_world_model,"exit_back");
}

//Function Number: 8
make_mobile_turret_usable()
{
	self endon("death");
	thread handle_vehicle_dof();
	self.enter_use_tags = [];
	for(var_00 = 0;var_00 < 3;var_00++)
	{
		var_01 = spawn("script_model",(0,0,0));
		var_01 setmodel("tag_origin");
		var_01 hide();
		self.enter_use_tags[var_00] = var_01;
	}

	var_02 = self gettagorigin("tag_body");
	var_03 = self gettagorigin("tag_wheel_front_left");
	var_04 = self gettagorigin("tag_wheel_front_right");
	var_05 = self gettagorigin("tag_wheel_back_left");
	var_06 = self gettagorigin("tag_wheel_back_right");
	self.enter_use_tags[0].origin = (var_03[0] + var_05[0] * 0.5,var_03[1] + var_05[1] * 0.5,var_02[2]);
	self.enter_use_tags[1].origin = (var_04[0] + var_06[0] * 0.5,var_04[1] + var_06[1] * 0.5,var_02[2]);
	self.enter_use_tags[2].origin = (var_05[0] + var_06[0] * 0.5,var_05[1] + var_06[1] * 0.5,var_02[2]);
	foreach(var_01 in self.enter_use_tags)
	{
		var_01 linkto(self);
		var_01 sethintstring("Press ^3 &&1 ^7to Enter the Mobile Turret.");
		var_01 makeusable();
	}

	for(;;)
	{
		self makeunusable();
		wait_for_any_trigger_hit(self.enter_use_tags);
		if(isdefined(level.player.linked_to_cover))
		{
			continue;
		}

		foreach(var_01 in self.enter_use_tags)
		{
			var_01 makeunusable();
		}

		level.player maps\_shg_utility::setup_player_for_scene();
		maps\_player_exo::player_exo_deactivate();
		var_0B = maps\_vehicle_shg::spawn_player_rig();
		var_0B hide();
		var_0C = distancesquared(level.player.origin,self.enter_use_tags[0].origin);
		var_0D = distancesquared(level.player.origin,self.enter_use_tags[1].origin);
		var_0E = distancesquared(level.player.origin,self.enter_use_tags[2].origin);
		var_0F = var_0C;
		var_10 = "enter_left";
		var_11 = "exit_left";
		if(var_0D < var_0F)
		{
			var_0F = var_0D;
			var_10 = "enter_right";
			var_11 = "exit_right";
		}

		if(var_0E < var_0F)
		{
			var_0F = var_0E;
			var_10 = "enter_back";
			var_11 = "exit_back";
		}

		maps\_anim::anim_first_frame_solo(var_0B,var_10,"tag_body");
		level.player playerlinktoblend(var_0B,"tag_player",0.2,0.1,0.1);
		wait(0.2);
		var_0B show();
		var_0B.vehicle_to_swap = self;
		maps\_anim::anim_single_solo(var_0B,var_10,"tag_body");
		level.player unlink();
		var_0B delete();
		level.player maps\_shg_utility::setup_player_for_gameplay();
		level.player maps\_utility::player_mount_vehicle(self);
		wait_for_exit_message();
		if(isdefined(level.player.drivingvehicle))
		{
			level.player maps\_shg_utility::setup_player_for_scene();
			var_0B = maps\_vehicle_shg::spawn_player_rig();
			var_0B hide();
			maps\_anim::anim_first_frame_solo(var_0B,var_11,"tag_body");
			level.player playerlinktoblend(var_0B,"tag_player",0.2,0.1,0.1);
			wait(0.2);
			var_0B show();
			var_0B.vehicle_to_swap = self;
			level.player maps\_utility::player_dismount_vehicle();
			level.player playerlinktodelta(var_0B,"tag_player",1,0,0,0,0,1);
			maps\_anim::anim_single_solo(var_0B,var_11,"tag_body");
			level.player unlink();
			var_0B delete();
			level.player maps\_shg_utility::setup_player_for_gameplay();
			maps\_player_exo::player_exo_activate();
			foreach(var_01 in self.enter_use_tags)
			{
				var_01 makeusable();
			}
		}
	}
}

//Function Number: 9
handle_vehicle_dof()
{
	self endon("death");
	for(;;)
	{
		self waittill("enter_vehicle_dof");
		maps\_art::dof_enable_script(10,70,4,9500,10000,0,0.5);
		self waittill("exit_vehicle_dof");
		maps\_art::dof_disable_script(0.25);
	}
}

//Function Number: 10
wait_for_exit_message()
{
	self endon("vehicle_dismount");
	var_00 = "exit_message";
	notifyoncommand(var_00,"+activate");
	notifyoncommand(var_00,"+usereload");
	level.player waittill(var_00);
}

//Function Number: 11
wait_for_any_trigger_hit(param_00)
{
	if(param_00.size > 1)
	{
		for(var_01 = 1;var_01 < param_00.size;var_01++)
		{
			param_00[var_01] endon("trigger");
		}
	}

	if(param_00.size > 0)
	{
		param_00[0] waittill("trigger");
	}
}

//Function Number: 12
make_mobile_turret_unusable()
{
	self makeunusable();
	if(isdefined(self.enter_use_tags))
	{
		foreach(var_01 in self.enter_use_tags)
		{
			var_01 makeunusable();
		}
	}
}

//Function Number: 13
monitor_vehicle_mount()
{
	self endon("death");
	self setanim(maps\_vehicle_shg::get_vehicle_anim("idle"));
	thread calculate_base_target_offset();
	for(;;)
	{
		maps\_vehicle_shg::wait_for_vehicle_mount();
		thread turret_think();
		if(!isdefined(self.player_driver))
		{
			thread handle_vehicle_ai();
			thread rocket_ai();
			make_mobile_turret_unusable();
			thread vehicle_scripts\_x4walker_wheels_aud::snd_start_x4_walker_wheels("npc");
		}
		else
		{
			thread rocket_think();
		}

		maps\_vehicle_shg::wait_for_vehicle_dismount();
		reset_turret();
	}
}

//Function Number: 14
monitor_walker_death_stop_sounds()
{
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	var_00 = 1;
	soundscripts\_snd::snd_message("snd_stop_vehicle",var_00);
}

//Function Number: 15
animation_think()
{
	self endon("death");
	for(;;)
	{
		self waittill("play_anim",var_00);
		clear_anims();
		self setanim(maps\_vehicle_shg::get_vehicle_anim(var_00),1,0.2,1);
	}
}

//Function Number: 16
clear_anims()
{
	self clearanim(%walker_wheels,0.2);
}

//Function Number: 17
turret_think()
{
	self endon("death");
	self endon("vehicle_dismount");
	if(isdefined(self.player_driver))
	{
		level.player shellshock("mobile_turret_shoot",0.1);
	}

	for(;;)
	{
		self waittill("turret_fire");
		self fireweapon();
	}
}

//Function Number: 18
reset_turret()
{
	self notify("stop_vehicle_shoot_shock");
	if(isdefined(self.base_target_offset_angles) && isdefined(self.base_target_offset_length))
	{
		var_00 = anglestoforward(self.angles);
		var_01 = self gettagorigin("tag_body");
		var_01 = var_01 + var_00 * 100;
		var_02 = anglestoforward(self.base_target_offset_angles + self gettagangles("tag_body"));
		var_02 = var_02 * self.base_target_offset_length;
		self setturrettargetvec(var_01 + var_02);
	}
}

//Function Number: 19
rocket_think()
{
	self endon("death");
	self endon("vehicle_dismount");
	thread monitor_missile_input();
	for(;;)
	{
		self waittill("target_missile_system");
		thread rocket_target_think();
		self waittill("fire_missile_system");
		thread fire_rockets();
		wait(2);
	}
}

//Function Number: 20
rocket_target_think()
{
	self endon("death");
	self endon("vehicle_dismount");
	self endon("fire_missile_system");
	if(!isdefined(self.rocket_targets))
	{
		self.rocket_targets = [];
	}

	var_00 = 4;
	for(;;)
	{
		if(self.rocket_targets.size < var_00)
		{
			var_01 = anglestoforward(self.player_driver getplayerangles());
			var_01 = vectornormalize(var_01);
			var_02 = self.player_driver geteye();
			var_03 = bullettrace(var_02,var_02 + var_01 * 2048,1,self);
			var_04 = var_03["entity"];
			if(isdefined(var_04) && isai(var_04) && isalive(var_04) && !maps\_vehicle_code::attacker_isonmyteam(var_04) && !maps\_vehicle_code::attacker_troop_isonmyteam(var_04))
			{
				if(!isdefined(var_04.target_marked) || !var_04.target_marked)
				{
					var_04.target_marked = 1;
					target_set(var_04,(0,0,20));
					target_setshader(var_04,"hud_exo_poly_cool");
					thread remove_target(var_04);
					self.rocket_targets[self.rocket_targets.size] = var_04;
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 21
remove_target(param_00)
{
	wait_to_remove_target(param_00);
	if(isdefined(param_00))
	{
		param_00.target_marked = undefined;
		target_remove(param_00);
	}

	if(isdefined(self) && isdefined(self.rocket_targets))
	{
		var_01 = [];
		foreach(var_03 in self.rocket_targets)
		{
			if(isdefined(var_03))
			{
				if(isdefined(param_00) && var_03 == param_00)
				{
					continue;
				}

				var_01[var_01.size] = var_03;
			}
		}

		self.rocket_targets = var_01;
	}
}

//Function Number: 22
wait_to_remove_target(param_00)
{
	self endon("death");
	self endon("vehicle_dismount");
	param_00 endon("death");
	param_00 waittill("remove_target");
}

//Function Number: 23
monitor_missile_input()
{
	self endon("death");
	self endon("vehicle_dismount");
	var_00 = 0;
	for(;;)
	{
		var_01 = self.player_driver fragbuttonpressed();
		if(var_01 && !var_00)
		{
			var_00 = 1;
			self notify("target_missile_system");
		}
		else if(!var_01 && var_00)
		{
			var_00 = 0;
			self notify("fire_missile_system");
		}

		wait(0.05);
	}
}

//Function Number: 24
fire_rockets()
{
	var_00 = 0;
	foreach(var_02 in self.rocket_targets)
	{
		if(!isdefined(var_02))
		{
			continue;
		}

		self.player_driver playrumbleonentity("heavygun_fire");
		target_setshader(var_02,"hud_exo_circle_hot");
		thread fire_rocket_at(var_02,var_00);
		var_00++;
		wait(0.35);
	}
}

//Function Number: 25
fire_rocket_at(param_00,param_01)
{
	if(!isdefined(self.launcher_index))
	{
		self.launcher_index = 0;
	}
	else
	{
		self.launcher_index++;
		self.launcher_index = self.launcher_index % 4;
	}

	var_02 = param_00.origin;
	var_03 = "TAG_LAUNCHER" + self.launcher_index + 1;
	var_04 = self gettagorigin(var_03);
	var_05 = self gettagangles(var_03);
	var_06 = var_04 + anglestoforward(var_05) * 512;
	playfxontag(common_scripts\utility::getfx("x4walker_wheels_rpg_fv"),self,var_03);
	if(isdefined(self.player_driver))
	{
		var_07 = magicbullet("mobile_turret_missile",var_04,var_06);
	}
	else
	{
		var_07 = magicbullet("mobile_turret_missile",var_05,var_07);
	}

	var_07 missile_settargetent(param_00);
	var_07 missile_setflightmodedirect();
	var_07 soundscripts\_snd::snd_message("mobile_turret_missile");
}

//Function Number: 26
handle_vehicle_ai()
{
	if(isdefined(self.ai_func_override))
	{
		self thread [[ self.ai_func_override ]]();
		return;
	}

	thread vehicle_scripts\_vehicle_turret_ai::vehicle_turret_settings_target(10);
	thread vehicle_scripts\_vehicle_turret_ai::vehicle_turret_settings_shoot(2,4,0.1,0.3,1);
	thread vehicle_scripts\_vehicle_turret_ai::vehicle_turret_default_ai();
}

//Function Number: 27
rocket_ai()
{
	self endon("death");
	self endon("vehicle_dismount");
	var_00 = 128;
	wait(randomintrange(1,10));
	for(;;)
	{
		wait(randomfloatrange(12,20));
		var_01 = 0;
		while(!var_01)
		{
			var_02 = [];
			if(isdefined(self.script_team))
			{
				var_03 = common_scripts\utility::get_enemy_team(self.script_team);
				var_04 = getaiarray(var_03);
			}
			else
			{
				var_04 = getaiarray("axis");
			}

			foreach(var_06 in var_04)
			{
				var_07 = var_06.origin - self.origin;
				var_08 = length(var_07);
				if(var_08 < 1024)
				{
					continue;
				}

				var_07 = vectornormalize(var_07);
				var_09 = self gettagangles("tag_flash");
				var_0A = anglestoforward(var_09);
				var_0B = vectordot(var_07,var_0A);
				if(var_0B < 0.5)
				{
					continue;
				}

				var_0C = self gettagorigin("tag_flash");
				var_0D = var_06.origin + (0,0,32);
				var_0E = sighttracepassed(var_0C,var_0D,0,self);
				if(!var_0E)
				{
					continue;
				}

				var_0F = vectorfromlinetopoint(var_0C,var_0D,level.player.origin + (0,0,32));
				if(length(var_0F) < var_00)
				{
					continue;
				}

				var_02[var_02.size] = var_06;
			}

			var_11 = [];
			if(var_02.size > 0)
			{
				var_12 = randomint(var_02.size);
				for(var_13 = 0;var_13 < var_02.size;var_13++)
				{
					var_14 = var_12 + var_13 % var_02.size;
					var_15 = var_02[var_14];
					var_11[var_11.size] = var_15;
					if(var_11.size > 1)
					{
						var_16 = var_11.size / 4;
						if(var_16 > randomfloatrange(0,1))
						{
							break;
						}
					}
				}
			}

			var_17 = 0;
			foreach(var_19 in var_11)
			{
				if(!isdefined(var_19))
				{
					continue;
				}

				var_01 = 1;
				thread fire_rocket_at(var_19,var_17);
				var_17++;
				wait(0.35);
			}

			if(!var_01)
			{
				wait(0.5);
			}
		}
	}
}

//Function Number: 28
calculate_base_target_offset()
{
	var_00 = anglestoforward(self.angles);
	var_01 = self gettagorigin("tag_body");
	var_02 = var_01 + var_00 * 100;
	var_03 = self gettagorigin("tag_flash");
	var_04 = anglestoforward(self gettagangles("tag_flash"));
	var_05 = var_03 + var_04 * 100;
	var_06 = var_05 - var_02;
	var_07 = self gettagangles("tag_body");
	self.base_target_offset_length = length(var_06);
	var_08 = vectortoangles(var_06);
	self.base_target_offset_angles = var_08 - var_07;
}

//Function Number: 29
swap_cockpit_model(param_00)
{
	if(isdefined(param_00) && isdefined(param_00.vehicle_to_swap))
	{
		param_00.vehicle_to_swap notify("enter_vehicle_dof");
		param_00.vehicle_to_swap setmodel("vehicle_vm_x4walker_wheels");
		param_00.vehicle_to_swap notify("play_anim","cockpit_idle");
	}
}

//Function Number: 30
swap_world_model(param_00)
{
	if(isdefined(param_00) && isdefined(param_00.vehicle_to_swap))
	{
		param_00.vehicle_to_swap notify("exit_vehicle_dof");
		param_00.vehicle_to_swap setmodel("vehicle_x4walker_wheels");
		param_00.vehicle_to_swap notify("play_anim","idle");
	}
}

//Function Number: 31
monitor_wheel_movements()
{
	self endon("death");
	var_00 = ["tag_wheel_back_left","tag_wheel_back_right","tag_wheel_front_left","tag_wheel_front_right"];
	self.last_wheel_pos = [];
	self.current_wheel_pos = [];
	var_01 = 0.05;
	if(level.currentgen)
	{
		var_01 = 0.5;
	}

	for(;;)
	{
		foreach(var_03 in var_00)
		{
			self.current_wheel_pos[var_03] = self gettagorigin(var_03);
		}

		wait(var_01);
		foreach(var_03 in var_00)
		{
			self.last_wheel_pos[var_03] = self.current_wheel_pos[var_03];
		}
	}
}

//Function Number: 32
get_wheel_velocity(param_00)
{
	if(isdefined(self.current_wheel_pos[param_00]) && isdefined(self.last_wheel_pos[param_00]))
	{
		var_01 = self.current_wheel_pos[param_00] - self.last_wheel_pos[param_00];
		return var_01 * 20;
	}

	return (0,0,0);
}