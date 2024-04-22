/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: sanfran_pitbull.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 45
 * Decompile Time: 646 ms
 * Timestamp: 4/22/2024 2:35:54 AM
*******************************************************************/

//Function Number: 1
player_pitbull_init(param_00)
{
	precachemodel("vehicle_vm_pitbull");
	precache_lui_event_strings();
	level._effect["ui_pitbulltur_target"] = loadfx("vfx/ui/ui_pitbulltur_target");
	if(isdefined(param_00))
	{
		level.scr_anim[param_00]["cockpit_idle"] = %pitbull_cockpit_idle_vm;
		level.scr_anim[param_00]["cockpit_shake_cam"] = %pitbull_cockpit_idle_vm_cam;
		level.scr_anim[param_00]["cockpit_static_idle"] = %pitbull_cockpit_static_idle_vm;
		level.scr_anim[param_00]["cockpit_static_idle_cam"] = %pitbull_cockpit_static_idle_vm_cam;
		level.scr_anim[param_00]["center2left"] = %pitbull_cockpit_turn_center_to_l_vm;
		level.scr_anim[param_00]["center2left_cam"] = %pitbull_cockpit_turn_center_to_l_vm_cam;
		level.scr_anim[param_00]["center2right"] = %pitbull_cockpit_turn_center_to_r_vm;
		level.scr_anim[param_00]["center2right_cam"] = %pitbull_cockpit_turn_center_to_r_vm_cam;
		level.scr_anim[param_00]["left2center"] = %pitbull_cockpit_turn_l_to_center_vm;
		level.scr_anim[param_00]["left2center_cam"] = %pitbull_cockpit_turn_l_to_center_vm_cam;
		level.scr_anim[param_00]["right2center"] = %pitbull_cockpit_turn_r_to_center_vm;
		level.scr_anim[param_00]["right2center_cam"] = %pitbull_cockpit_turn_r_to_center_vm_cam;
		level.scr_anim[param_00]["accelerate"] = %pitbull_cockpit_accelerate_vm;
		level.scr_anim[param_00]["decelerate"] = %pitbull_cockpit_decelerate_vm;
		level.scr_anim[param_00]["accelerate_cam"] = %pitbull_cockpit_accelerate_vm_cam;
		level.scr_anim[param_00]["accelerate2idle_cam"] = %pitbull_cockpit_accelerate_to_idle_vm_cam;
		level.scr_anim[param_00]["decelerate_cam"] = %pitbull_cockpit_decelerate_vm_cam;
		level.scr_anim[param_00]["gear_up"] = %pitbull_cockpit_gear_up_vm;
		level.scr_anim[param_00]["gear_down"] = %pitbull_cockpit_gear_down_vm;
	}

	thread load_pitbull_animations();
}

//Function Number: 2
load_pitbull_animations()
{
	level.scr_animtree["_pitbull"] = #animtree;
	level.scr_model["_pitbull"] = "vehicle_vm_pitbull";
	level.scr_anim["_pitbull"]["cockpit_idle"] = %pitbull_cockpit_idle;
	level.scr_anim["_pitbull"]["cockpit_static_idle"] = %pitbull_cockpit_static_idle;
	level.scr_anim["_pitbull"]["center2left"] = %pitbull_cockpit_turn_center_to_l;
	level.scr_anim["_pitbull"]["center2right"] = %pitbull_cockpit_turn_center_to_r;
	level.scr_anim["_pitbull"]["left2center"] = %pitbull_cockpit_turn_l_to_center;
	level.scr_anim["_pitbull"]["right2center"] = %pitbull_cockpit_turn_r_to_center;
	level.scr_anim["_pitbull"]["accelerate"] = %pitbull_cockpit_accelerate;
	level.scr_anim["_pitbull"]["decelerate"] = %pitbull_cockpit_decelerate;
	level.scr_anim["_pitbull"]["gear_up"] = %pitbull_cockpit_gear_up;
	level.scr_anim["_pitbull"]["gear_down"] = %pitbull_cockpit_gear_down;
}

//Function Number: 3
precache_lui_event_strings()
{
	precachestring(&"pitbull_update_speed");
	precachestring(&"pitbull_charge");
	precachestring(&"pitbull_safe");
	precachestring(&"pitbull_target_locked");
	precachestring(&"pitbull_warning");
	precachestring(&"pitbull_update_text");
	precachestring(&"pitbullHud");
	precachestring(&"pitbull_stop");
	precachestring(&"pitbull_stop_movie");
	precachestring(&"pitbull_ui_tap");
	precachestring(&"pitbull_fade_video");
}

//Function Number: 4
handle_player_pitbull(param_00)
{
	self endon("death");
	thread player_pitbull_physics_wake_up();
	thread handle_player_pitbull_autosave_checks();
	self.player_rig = undefined;
	if(isdefined(param_00))
	{
		self.player_rig = maps\_utility::spawn_anim_model(param_00);
		self.player_rig hide();
		thread common_scripts\utility::delete_on_death(self.player_rig);
	}

	if(!isdefined(self.fake_vehicle_model))
	{
		var_01 = maps\_utility::spawn_anim_model("_pitbull");
		var_01.origin = self.origin;
		var_01.angles = self.angles;
		var_01 hidepart("TAG_WINDSHIELD1");
		var_01 hidepart("TAG_WINDSHIELD2");
		var_01 hidepart("TAG_WINDSHIELD3");
		var_01 linkto(self);
		self.fake_vehicle_model = var_01;
		if(isdefined(self.player_rig))
		{
			self.player_rig linkto(self.fake_vehicle_model,"tag_player",(0,0,0),(0,0,0));
		}
	}

	self.fake_vehicle_model show();
	self hide();
	self.mgturret[0] hide();
	self makeunusable();
	maps\_utility::ent_flag_init("pitbull_disconnected");
	maps\_utility::ent_flag_init("pitbull_scripted_anim");
	maps\_utility::ent_flag_init("pitbull_allow_shooting");
	for(;;)
	{
		self waittill("mount_pitbull",var_02);
		mount_player_pitbull(var_02);
		thread maps\sanfran_pitbull_drive_anim::handle_player_pitbull_driving();
		thread handle_player_pitbull_turret();
		thread handle_player_pitbull_hud();
		thread handle_player_pitbull_damage();
		thread pitbull_rumble();
		self waittill("dismount_pitbull");
		dismount_player_pitbull(self.player_rig);
	}
}

//Function Number: 5
show_video_on_driverside()
{
	wait(0.1);
	setomnvar("ui_pitbull_video_state",1);
}

//Function Number: 6
mount_player_pitbull(param_00)
{
	setomnvar("ui_pitbull",1);
	level.player maps\_utility::player_mount_vehicle(self);
	level.player lerpfov(65,0.2);
	self.player_rig show();
	level.player maps\_shg_utility::setup_player_for_scene();
	level.player playerlinktodelta(self.player_rig,"tag_player",1,0,0,0,0,1);
	level.player playerlinkedvehicleanglesenable();
	level.player lerpviewangleclamp(0,0,0,0,0,0,0);
}

//Function Number: 7
dismount_player_pitbull(param_00)
{
	if(isdefined(param_00))
	{
		level.player unlink();
		level.player maps\_shg_utility::setup_player_for_gameplay();
		self notify("stop_loop");
		param_00 hide();
	}

	setomnvar("ui_pitbull",0);
	self.fake_vehicle_model hide();
	self show();
	if(!maps\_utility::ent_flag("pitbull_disconnected"))
	{
		level.player maps\_utility::player_dismount_vehicle();
	}

	level.player lerpfov(65,0.2);
	self notify("dismount_player_pitbull");
}

//Function Number: 8
disconnect_fake_pitbull()
{
	if(!maps\_utility::ent_flag("pitbull_disconnected"))
	{
		level.player maps\_utility::player_dismount_vehicle();
		self.fake_vehicle_model unlink();
		self.fake_vehicle_model notify("stop_loop");
		self.fake_vehicle_model maps\_utility::anim_stopanimscripted();
		level.player playerlinktodelta(self.player_rig,"tag_player",1,0,0,0,0,1);
		maps\_utility::ent_flag_set("pitbull_disconnected");
		thread fake_vehicle_fake_collision();
		self vehphys_disablecrashing();
	}

	return self.fake_vehicle_model;
}

//Function Number: 9
reconnect_fake_pitbull()
{
	if(maps\_utility::ent_flag("pitbull_disconnected"))
	{
		self vehicle_teleport(self.fake_vehicle_model.origin,self.fake_vehicle_model.angles,1);
		level.player maps\_utility::player_mount_vehicle(self);
		self.fake_vehicle_model dontinterpolate();
		self.fake_vehicle_model.origin = self.origin;
		self.fake_vehicle_model.angles = self.angles;
		self.fake_vehicle_model linkto(self);
		level.player playerlinktodelta(self.player_rig,"tag_player",1,0,0,0,0,1);
		level.player playerlinkedvehicleanglesenable();
		maps\_utility::ent_flag_clear("pitbull_disconnected");
		self vehphys_enablecrashing();
	}
}

//Function Number: 10
fake_vehicle_fake_collision()
{
	self endon("death");
	self endon("dismount_pitbull");
	while(maps\_utility::ent_flag("pitbull_disconnected"))
	{
		var_00 = self.fake_vehicle_model;
		var_01 = anglestoforward(var_00.angles);
		var_02 = var_00.origin + var_01 * 78;
		var_03 = 117;
		physicsexplosioncylinder(var_02,var_03,0,0.5);
		wait(0.05);
	}
}

//Function Number: 11
add_passenger_to_player_pitbull(param_00,param_01)
{
	if(!isdefined(self.fake_attachedguys))
	{
		self.fake_attachedguys = [];
	}

	if(!isdefined(self.fake_usedpositions))
	{
		self.fake_usedpositions = [];
	}

	self.fake_attachedguys[self.fake_attachedguys.size] = param_00;
	var_02 = set_pos(param_01);
	var_03 = maps\_vehicle_aianim::anim_pos(self,var_02);
	self.fake_usedpositions[var_02] = 1;
	var_04 = self.fake_vehicle_model gettagorigin(var_03.sittag);
	var_05 = self.fake_vehicle_model gettagangles(var_03.sittag);
	param_00.vehicle_pos = var_02;
	param_00.vehicle_idle = var_03.idle;
	self.fake_vehicle_model maps\_vehicle_aianim::link_to_sittag(param_00,var_03.sittag,var_03.sittag_offset,var_03.linktoblend);
	self.fake_vehicle_model thread passenger_idle(param_00,var_03);
}

//Function Number: 12
passenger_idle(param_00,param_01)
{
	param_00 endon("pitbull_get_out");
	maps\_vehicle_aianim::play_new_idle(param_00,param_01);
}

//Function Number: 13
set_pos(param_00)
{
	if(isdefined(param_00))
	{
		if(isdefined(self.fake_usedpositions[param_00]))
		{
		}

		return param_00;
	}

	for(var_01 = 1;var_01 < 4;var_01++)
	{
		if(self.fake_usedpositions[var_01])
		{
			continue;
		}

		return var_01;
	}
}

//Function Number: 14
remove_passenger_from_player_pitbull(param_00)
{
	for(var_01 = 0;var_01 < self.fake_attachedguys.size;var_01++)
	{
		if(self.fake_attachedguys[var_01] == param_00)
		{
			common_scripts\utility::array_remove(self.fake_attachedguys,param_00);
			self.fake_usedpositions[param_00.vehicle_pos] = 0;
			param_00 notify("pitbull_get_out");
			param_00 notify("newanim");
			param_00 stopanimscripted();
			param_00 unlink();
			param_00.vehicle_pos = undefined;
			param_00.vehicle_idle = undefined;
			return;
		}
	}
}

//Function Number: 15
handle_player_pitbull_turret()
{
	self endon("death");
	self endon("dismount_player_pitbull");
	if(!isdefined(self.mgturret[0]))
	{
		return;
	}

	for(;;)
	{
		maps\_utility::ent_flag_wait("pitbull_allow_shooting");
		thread pitbull_turret_aim();
		thread pitbull_turret_fire();
		maps\_utility::ent_flag_waitopen("pitbull_allow_shooting");
	}
}

//Function Number: 16
find_best_target(param_00,param_01,param_02)
{
	var_03 = undefined;
	var_04 = undefined;
	var_05 = getentarray("target_vehicle","script_noteworthy");
	foreach(var_07 in var_05)
	{
		if(!isdefined(var_07))
		{
			continue;
		}

		var_08 = var_07.origin - self.origin;
		var_09 = vectornormalize(var_08);
		var_0A = length(var_08);
		var_0B = vectordot(param_00,var_09);
		var_0B = acos(clamp(var_0B,-1,1));
		if(var_0B > param_01)
		{
			continue;
		}

		var_0C = abs(var_0A - param_02);
		var_0B = var_0B + var_0C + 50;
		if(!isdefined(var_03) || var_0B < var_03)
		{
			var_03 = var_0B;
			var_04 = var_07;
		}
	}

	return var_04;
}

//Function Number: 17
find_adjacent_target(param_00)
{
	if(!isdefined(self.current_turret_target))
	{
		return;
	}

	var_01 = anglestoforward(level.player getplayerangles());
	var_02 = anglestoright(level.player getplayerangles());
	var_03 = undefined;
	var_04 = undefined;
	var_05 = getentarray("target_vehicle","script_noteworthy");
	foreach(var_07 in var_05)
	{
		if(!isdefined(var_07))
		{
			continue;
		}

		if(var_07 == self.current_turret_target)
		{
			continue;
		}

		var_08 = var_07.origin - self.origin;
		var_09 = vectornormalize(var_08);
		var_0A = vectordot(var_01,var_09);
		if(var_0A < 0.423)
		{
			continue;
		}

		var_0B = var_07.origin - self.current_turret_target.origin;
		var_0C = vectordot(var_02,var_0B);
		if(!isdefined(var_04))
		{
			var_03 = var_0C;
			var_04 = var_07;
			continue;
		}

		if(param_00 == "left")
		{
			if(var_03 < 0)
			{
				if(var_0C < 0 && var_03 < var_0C)
				{
					var_03 = var_0C;
					var_04 = var_07;
				}
			}
			else if(var_0C < 0 || var_03 < var_0C)
			{
				var_03 = var_0C;
				var_04 = var_07;
			}

			continue;
		}

		if(var_03 > 0)
		{
			if(var_0C > 0 && var_03 > var_0C)
			{
				var_03 = var_0C;
				var_04 = var_07;
			}

			continue;
		}

		if(var_0C > 0 || var_03 > var_0C)
		{
			var_03 = var_0C;
			var_04 = var_07;
		}
	}

	return var_04;
}

//Function Number: 18
pitbull_turret_aim()
{
	self endon("death");
	self endon("dismount_player_pitbull");
	self endon("pitbull_allow_shooting");
	var_00 = common_scripts\utility::spawn_tag_origin();
	thread clean_up_hud_entity(var_00,"ui_pitbulltur_target");
	thread update_target_hud(var_00);
	thread pitbull_turret_targeting(var_00);
}

//Function Number: 19
update_target_hud(param_00)
{
	self endon("death");
	param_00 endon("death");
	for(;;)
	{
		if(!isalive(self.current_turret_target))
		{
			wait 0.05;
			if(!isalive(self.current_turret_target))
			{
				if(isdefined(param_00.fx_on) && param_00.fx_on)
				{
					param_00.fx_on = 0;
					killfxontag(common_scripts\utility::getfx("ui_pitbulltur_target"),param_00,"tag_origin");
				}

				continue;
			}
		}

		if(!isdefined(param_00.fx_on) || !param_00.fx_on)
		{
			playfxontag(common_scripts\utility::getfx("ui_pitbulltur_target"),param_00,"tag_origin");
			param_00.fx_on = 1;
		}

		var_01 = self.current_turret_target.origin + (0,0,50);
		var_02 = vectornormalize(var_01 - level.player geteye());
		param_00.origin = var_01;
		param_00.angles = vectortoangles(var_02 * -1);
		wait 0.05;
	}
}

//Function Number: 20
pitbull_turret_set_target(param_00,param_01,param_02)
{
	self notify("set_new_target");
	self endon("set_new_target");
	self endon("death");
	self endon("dismount_player_pitbull");
	self endon("pitbull_allow_shooting");
	var_03 = self.current_turret_target;
	self.mgturret[0] settargetentity(var_03,(0,0,50));
	self.mgturret[0] snaptotargetentity(var_03,(0,0,50));
	wait_until_new_target(var_03,param_01,param_02);
	self.current_turret_target = undefined;
}

//Function Number: 21
pitbull_turret_targeting(param_00)
{
	self endon("death");
	self endon("dismount_player_pitbull");
	self endon("pitbull_allow_shooting");
	for(;;)
	{
		var_01 = 0;
		var_02 = 90;
		if(!isdefined(self.current_turret_target))
		{
			var_03 = anglestoforward(level.player getplayerangles());
			var_04 = find_best_target(var_03,30,500);
			if(isdefined(var_04))
			{
				self.current_turret_target = var_04;
				var_01 = 5;
				var_02 = 30;
			}
		}

		if(isdefined(self.current_turret_target))
		{
			pitbull_turret_set_target(param_00,var_02,var_01);
			luinotifyevent(&"pitbull_target_locked",1,1);
		}
		else
		{
			luinotifyevent(&"pitbull_target_locked",1,0);
		}

		wait(0.05);
	}
}

//Function Number: 22
wait_until_new_target(param_00,param_01,param_02)
{
	param_00 endon("death");
	var_03 = cos(param_01);
	var_04 = 0;
	if(isdefined(param_02) && param_02 > 0)
	{
		var_04 = 1;
	}

	while(!var_04 || param_02 > 0)
	{
		var_05 = anglestoforward(level.player getplayerangles());
		if(!isdefined(param_00))
		{
			return;
		}

		var_06 = param_00.origin - self.origin;
		var_07 = vectornormalize(var_06);
		if(vectordot(var_05,var_07) < var_03)
		{
			return;
		}

		if(var_04)
		{
			param_02 = param_02 - 0.1;
		}

		wait(0.1);
	}
}

//Function Number: 23
pitbull_update_lui_charge(param_00)
{
	luinotifyevent(&"pitbull_charge",1,int(clamp(param_00,0,1) * 100));
}

//Function Number: 24
pitbull_turret_fire()
{
	self endon("death");
	self endon("dismount_player_pitbull");
	self endon("pitbull_allow_shooting");
	var_00 = 0.8;
	var_01 = var_00;
	pitbull_update_lui_charge(var_01);
	for(;;)
	{
		var_02 = 0;
		var_03 = level.player is_shoot_button_pressed();
		var_01 = var_01 + 0.05;
		var_01 = min(var_01,var_00);
		if(isdefined(var_03) && var_03)
		{
			if(var_01 >= var_00)
			{
				if(isdefined(self.current_turret_target))
				{
					var_02 = 1;
					soundscripts\_snd_playsound::snd_play("wpn_railgun_shot");
					self.mgturret[0] shootturret();
					level.player playrumbleonentity("heavygun_fire");
					var_01 = 0;
				}
				else if(common_scripts\utility::flag("flag_player_can_fire") == 1)
				{
				}
			}

			pitbull_update_lui_charge(1);
		}
		else
		{
			pitbull_update_lui_charge(0);
		}

		var_04 = var_01 / var_00;
		wait(0.05);
	}
}

//Function Number: 25
display_no_target_hint()
{
	thread maps\_utility::display_hint("no_target_hint");
	common_scripts\utility::waittill_notify_or_timeout("set_new_target",2);
	level.player.showhint = 0;
}

//Function Number: 26
is_shoot_button_pressed()
{
	if(!level.console && !level.player common_scripts\utility::is_player_gamepad_enabled())
	{
		return self attackbuttonpressed();
	}

	return self adsbuttonpressed();
}

//Function Number: 27
clean_up_hud_entity(param_00,param_01)
{
	common_scripts\utility::waittill_any("death","dismount_player_pitbull");
	if(isdefined(param_00))
	{
		stopfxontag(common_scripts\utility::getfx(param_01),param_00,"tag_origin");
		param_00 delete();
	}
}

//Function Number: 28
handle_player_pitbull_hud()
{
	self endon("death");
	self endon("dismount_player_pitbull");
	if(level.currentgen)
	{
		self endon("oncoming_scene_pitbull_monitor_start");
	}

	for(;;)
	{
		var_00 = self vehicle_getspeed();
		var_00 = int(var_00);
		if(var_00 > 0)
		{
			var_00 = var_00 + 1;
		}

		luinotifyevent(&"pitbull_update_speed",1,var_00);
		if(level.currentgen)
		{
			level.oncoming_pitbull_speed = var_00;
		}

		wait(0.05);
	}
}

//Function Number: 29
pitbull_rumble()
{
	level endon("flag_player_crashed");
	level.player endon("death");
	var_00 = 0;
	var_01 = 0.015;
	var_02 = var_01 - var_00;
	thread pitbull_rumble_stop();
	var_03 = maps\_utility::get_rumble_ent("steady_rumble");
	var_03.intensity = 0.04;
	var_04 = 1;
	thread pitbull_vehicle_collision_rumble(var_03);
	for(;;)
	{
		var_05 = get_pitbull_shake_value();
		var_03.intensity = var_00 + var_05 * var_02;
		wait(randomfloatrange(var_04 / 4,var_04 / 2));
	}
}

//Function Number: 30
pitbull_vehicle_collision_rumble(param_00)
{
	level endon("flag_player_crashed");
	level.player endon("death");
	var_01 = 0.02;
	var_02 = 0.1;
	var_03 = var_02 - var_01;
	for(;;)
	{
		self waittill("veh_contact");
		var_04 = get_pitbull_shake_value();
		param_00.intensity = var_01 + var_04 * var_03;
	}
}

//Function Number: 31
get_pitbull_shake_value()
{
	var_00 = 0;
	var_01 = 12;
	return self vehicle_getspeed() / var_01;
}

//Function Number: 32
pitbull_rumble_stop()
{
	level waittill("flag_player_crashed");
	stopallrumbles();
}

//Function Number: 33
handle_player_pitbull_damage()
{
	self endon("death");
	self endon("stop_player_pitbull_damage");
	childthread manage_windshield_states();
	var_00 = [];
	var_00[0] = [200,300];
	var_00[1] = [400,3000];
	var_01 = 0;
	var_02 = 0;
	for(;;)
	{
		self waittill("veh_contact",var_03,var_04,var_05,var_06,var_07);
		var_08 = (var_06[0],var_06[1],0);
		var_09 = length(var_08);
		if(var_09 < var_00[var_01][0])
		{
			continue;
		}

		var_02 = var_02 + var_09;
		if(var_02 < var_00[var_01][1])
		{
			continue;
		}

		var_01++;
		self notify("windshield_state",var_01);
		var_02 = 0;
		if(var_01 >= var_00.size)
		{
			return;
		}
	}
}

//Function Number: 34
manage_windshield_states()
{
	for(;;)
	{
		self waittill("windshield_state",var_00);
		pitbull_hide_part("TAG_WINDSHIELD");
		pitbull_hide_part("TAG_WINDSHIELD1");
		pitbull_hide_part("TAG_WINDSHIELD2");
		pitbull_hide_part("TAG_WINDSHIELD3");
		if(var_00 == 0)
		{
			pitbull_show_part("TAG_WINDSHIELD");
			continue;
		}

		if(var_00 == 1)
		{
			pitbull_show_part("TAG_WINDSHIELD1");
			continue;
		}

		if(var_00 == 2)
		{
			pitbull_show_part("TAG_WINDSHIELD2");
			continue;
		}

		if(var_00 == 3)
		{
			pitbull_show_part("TAG_WINDSHIELD3");
			continue;
		}

		if(var_00 > 3)
		{
			pitbull_show_part("TAG_WINDSHIELD3");
			return;
		}
	}
}

//Function Number: 35
pitbull_hide_part(param_00)
{
	self hidepart(param_00);
	if(isdefined(self.fake_vehicle_model))
	{
		self.fake_vehicle_model hidepart(param_00);
	}
}

//Function Number: 36
pitbull_show_part(param_00)
{
	self showpart(param_00);
	if(isdefined(self.fake_vehicle_model))
	{
		self.fake_vehicle_model showpart(param_00);
	}
}

//Function Number: 37
handle_friendly_pitbull_shooting()
{
	self endon("death");
	thread friendly_pitbull_aim();
	thread friendly_pitbull_fire();
}

//Function Number: 38
friendly_pitbull_aim()
{
	self endon("death");
	for(;;)
	{
		var_00 = anglestoforward(self.angles);
		var_01 = find_best_target(var_00,45,500);
		if(isdefined(var_01))
		{
			self.mgturret[0] settargetentity(var_01,(0,0,50));
			wait_until_new_target(var_01,45,5);
		}

		wait(0.05);
	}
}

//Function Number: 39
friendly_pitbull_fire()
{
	self endon("death");
	maps\_utility::ent_flag_init("pitbull_allow_shooting");
	for(;;)
	{
		wait(randomfloatrange(2,3));
		if(maps\_utility::ent_flag("pitbull_allow_shooting"))
		{
			var_00 = self.mgturret[0] getturrettarget(1);
			while(!isdefined(var_00))
			{
				wait(0.2);
				var_00 = self.mgturret[0] getturrettarget(1);
			}

			wait(randomfloatrange(2,5));
			self.mgturret[0] shootturret();
			self.mgturret[0] soundscripts\_snd::snd_message("npc_pitbull_shot");
			wait(0.5);
		}
	}
}

//Function Number: 40
player_pitbull_physics_wake_up()
{
	self endon("death");
	for(;;)
	{
		if(level.nextgen)
		{
			wakeupphysicssphere(self.origin,240);
		}
		else
		{
			physicsexplosionsphere(self.origin,240,200,0.15,0);
			physicsexplosionsphere(level.player.origin,160,140,2.5,0);
		}

		wait 0.05;
	}
}

//Function Number: 41
handle_player_pitbull_autosave_checks()
{
	self endon("death");
	maps\_utility::add_extra_autosave_check("pitbull_no_recent_accel",::autosave_check_pitbull_no_recent_accel,"pitbull recently accelerated");
	maps\_utility::add_extra_autosave_check("pitbull_upright",::autosave_check_pitbull_upright,"pitbull is not upright");
	maps\_utility::add_extra_autosave_check("pitbull_moving",::autosave_check_pitbull_moving,"pitbull is not moving");
	thread monitor_pitbull_recent_accel();
	common_scripts\utility::flag_wait("flag_player_crashed");
	maps\_utility::remove_extra_autosave_check("pitbull_no_recent_accel");
	maps\_utility::remove_extra_autosave_check("pitbull_upright");
	maps\_utility::remove_extra_autosave_check("pitbull_moving");
}

//Function Number: 42
monitor_pitbull_recent_accel()
{
	self endon("death");
	var_00 = 1544;
	var_01 = squared(var_00);
	for(;;)
	{
		if(lengthsquared(maps\_shg_utility::get_differentiated_acceleration()) > var_01)
		{
			self.last_big_acceleration_msec = gettime();
		}

		wait 0.05;
	}
}

//Function Number: 43
autosave_check_pitbull_no_recent_accel()
{
	var_00 = 2000;
	return !isdefined(level.player_pitbull.last_big_acceleration_msec) || gettime() - level.player_pitbull.last_big_acceleration_msec > var_00;
}

//Function Number: 44
autosave_check_pitbull_upright()
{
	var_00 = 0.5;
	return anglestoup(level.player_pitbull.angles)[2] > var_00;
}

//Function Number: 45
autosave_check_pitbull_moving()
{
	var_00 = 20;
	return !common_scripts\utility::flag("flag_intro_give_player_driving") || level.player_pitbull vehicle_getspeed() > var_00;
}