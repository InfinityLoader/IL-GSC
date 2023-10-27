/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_air_support_strobe.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 32
 * Decompile Time: 515 ms
 * Timestamp: 10/27/2023 2:21:19 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(level.cheap_air_strobe_fx))
	{
		level._effect["air_support_marker"] = loadfx("smoke/signal_smoke_air_support_paris_ac130");
	}
	else
	{
		level._effect["air_support_marker"] = loadfx("smoke/signal_smoke_air_support");
	}

	level._effect["air_support_trail"] = loadfx("smoke/smoke_geotrail_air_support");
	if(isdefined(level.air_support_sticky_marker_fx))
	{
		level._effect["air_support_sticky_marker"] = level.air_support_sticky_marker_fx;
	}

	if(isdefined(level.enemy_air_support_marker_fx))
	{
		level._effect["air_support_marker_enemy"] = level.enemy_air_support_marker_fx;
	}

	if(isdefined(level.enemy_air_support_trail_fx))
	{
		level._effect["air_support_trail_enemy"] = level.enemy_air_support_trail_fx;
	}

	level.air_support_weapon = "ac130_40mm_air_support_strobe";
	precacheitem(level.air_support_weapon);
	precacheitem("air_support_strobe");
	precacherumble("ac130_artillery_rumble");
	common_scripts\utility::flag_init("flag_strobes_in_use");
	level.air_support_strobes = [];
	level.air_support_strobe_count = 0;
	thread air_support_loop();
	foreach(var_01 in level.players)
	{
		var_01 maps\_utility::ent_flag_init("flag_strobe_ready");
		var_01 thread monitor_last_weapon();
	}

	maps\_utility::add_extra_autosave_check("autosave_check_air_support_strobe_not_in_use",::autosave_check_air_support_strobe_not_in_use,"Can\'t save because an air support strobe is in use");
}

//Function Number: 2
autosave_check_air_support_strobe_not_in_use()
{
	return level.air_support_strobe_count == 0;
}

//Function Number: 3
fake_strobe(param_00)
{
	var_01 = common_scripts\utility::spawn_tag_origin();
	var_01.origin = param_00;
	thread notify_strobe_thrown(var_01);
	air_support_enqueue(var_01);
}

//Function Number: 4
strobe_tracking()
{
	self notify("stop_strobe_tracking");
	self endon("stop_strobe_tracking");
	self giveweapon("air_support_strobe");
	self setweaponammoclip("air_support_strobe",99);
	self setactionslot(4,"weapon","air_support_strobe");
	maps\_utility::ent_flag_set("flag_strobe_ready");
	var_00 = 18;
	if(isdefined(level.strobe_cooldown_override))
	{
		var_00 = level.strobe_cooldown_override;
	}

	var_01 = weaponfiretime("air_support_strobe") - 0.05;
	for(;;)
	{
		self waittill("grenade_fire",var_02,var_03);
		var_02.owner = self;
		if(var_03 == "air_support_strobe")
		{
			var_02 thread strobe_think();
			wait var_01;
			maps\_utility::ent_flag_clear("flag_strobe_ready");
			self takeweapon("air_support_strobe");
			ensure_player_has_weapon_selected();
			wait var_00 - var_01;
			self giveweapon("air_support_strobe");
			self setweaponammoclip("air_support_strobe",99);
			self setactionslot(4,"weapon","air_support_strobe");
			refreshhudammocounter();
			maps\_utility::ent_flag_set("flag_strobe_ready");
			level notify("air_support_strobe_ready");
		}
	}
}

//Function Number: 5
disable_strobes_for_player()
{
	self takeweapon("air_support_strobe");
	ensure_player_has_weapon_selected();
	self notify("stop_strobe_tracking");
	maps\_utility::ent_flag_clear("flag_strobe_ready");
}

//Function Number: 6
enable_strobes_for_player()
{
	thread strobe_tracking();
}

//Function Number: 7
air_support_loop()
{
	var_00 = 2.5;
	if(isdefined(level.strobe_firedelay_override))
	{
		var_00 = level.strobe_firedelay_override;
	}

	for(;;)
	{
		var_01 = air_support_dequeue();
		if(var_01 strobe_can_see_targets() || isdefined(level.strobe_no_vis_check) && level.strobe_no_vis_check)
		{
			level notify("air_suport_strobe_fired_upon",var_01);
			thread count_strobe_kills(8);
			if(!isdefined(level.strobe_no_badplace) || !level.strobe_no_badplace)
			{
				var_01 thread strobe_enemy_badplace();
			}

			wait var_00;
			var_01 strobe_fire();
			continue;
		}

		level notify("air_support_strobe_no_targets");
		wait 1;
	}
}

//Function Number: 8
notify_strobe_thrown(param_00)
{
	level notify("air_support_strobe_thrown",param_00);
	level endon("air_support_strobe_thrown");
	common_scripts\utility::flag_set("flag_strobes_in_use");
	wait 5;
	for(;;)
	{
		while(!air_support_queue_empty())
		{
			wait 1;
		}

		wait 10;
		if(air_support_queue_empty())
		{
			break;
		}
	}

	common_scripts\utility::flag_clear("flag_strobes_in_use");
}

//Function Number: 9
strobe_enemy_badplace()
{
	self endon("death");
	var_00 = 5.8;
	if(isdefined(level.strobe_used_once))
	{
		var_00 = 3;
	}

	wait var_00;
	var_01 = 512;
	var_02 = 400;
	var_03 = 11 - var_00;
	badplace_cylinder("",var_03,self.origin - (0,0,var_01 / 2),var_02,var_01,"axis");
	level.strobe_used_once = 1;
}

//Function Number: 10
strobe_think(param_00)
{
	self endon("death");
	thread monitor_strobe_count();
	thread notify_strobe_thrown(self);
	self.fx_origin = common_scripts\utility::spawn_tag_origin();
	self.fx_origin linkto(self);
	wait 0.1;
	if(isdefined(param_00) && param_00)
	{
		playfxontag(common_scripts\utility::getfx("air_support_trail_enemy"),self.fx_origin,"tag_origin");
		self.isenemystrobe = 1;
	}
	else
	{
		playfxontag(common_scripts\utility::getfx("air_support_trail"),self.fx_origin,"tag_origin");
	}

	wait 2.35;
	var_01 = 0.5;
	var_02 = gettime() + var_01 * 1000;
	var_03 = self.origin;
	while(gettime() < var_02)
	{
		common_scripts\utility::waitframe();
		var_04 = self.origin - var_03 * 20;
		var_03 = self.origin;
		if(var_04[2] >= 0)
		{
			break;
		}
	}

	var_05 = bullettrace(self.origin,self.origin + (0,0,-1024),1,undefined,1);
	if(isdefined(var_05["position"]))
	{
		self.origin = var_05["position"];
	}

	if(isdefined(self.sticky) && self.sticky)
	{
		thread marker_pulse();
	}
	else if(isdefined(param_00) && param_00)
	{
		playfx(common_scripts\utility::getfx("air_support_marker_enemy"),self.origin);
	}
	else
	{
		playfx(common_scripts\utility::getfx("air_support_marker"),self.origin);
	}

	air_support_enqueue(self);
	var_06 = 512;
	var_07 = 650;
	badplace_cylinder("",9.5,self.origin - (0,0,var_06 / 2),var_07,var_06,"allies");
	wait 15;
	if(isdefined(self.fx_origin))
	{
		if(isdefined(param_00) && param_00)
		{
			stopfxontag(common_scripts\utility::getfx("air_support_marker_enemy"),self.fx_origin,"tag_origin");
		}
		else
		{
			stopfxontag(common_scripts\utility::getfx("air_support_marker"),self.fx_origin,"tag_origin");
		}

		self.fx_origin delete();
	}

	self delete();
}

//Function Number: 11
monitor_strobe_count()
{
	if(!isdefined(self))
	{
		return;
	}

	level.air_support_strobe_count++;
	self waittill("death");
	wait 4;
	level.air_support_strobe_count--;
}

//Function Number: 12
marker_pulse()
{
	self endon("death");
	var_00 = 5;
	var_01 = 0.3;
	for(var_02 = 0;var_02 <= var_00 / var_01;var_02++)
	{
		if(isdefined(self.fx_origin))
		{
			playfxontag(common_scripts\utility::getfx("air_support_sticky_marker"),self.fx_origin,"tag_origin");
			wait var_01;
			continue;
		}

		break;
	}

	wait 1;
	stopfxontag(common_scripts\utility::getfx("air_support_sticky_marker"),self.fx_origin,"tag_origin");
}

//Function Number: 13
linkto_without_angles(param_00)
{
	self endon("death");
	self unlink();
	self rotateto((0,0,90),0.05);
	while(isdefined(param_00) && isdefined(param_00.origin))
	{
		self moveto(param_00.origin,0.05);
		common_scripts\utility::waitframe();
	}
}

//Function Number: 14
air_support_enqueue(param_00)
{
	level.air_support_strobes[level.air_support_strobes.size] = param_00;
	level notify("air_support_strobe_popped",param_00);
}

//Function Number: 15
air_support_dequeue()
{
	level.air_support_strobes = common_scripts\utility::array_removeundefined(level.air_support_strobes);
	while(level.air_support_strobes.size == 0)
	{
		level waittill("air_support_strobe_popped",var_00);
		level.air_support_strobes = common_scripts\utility::array_removeundefined(level.air_support_strobes);
	}

	return level.air_support_strobes[0];
}

//Function Number: 16
air_support_queue_empty()
{
	return level.air_support_strobes.size == 0;
}

//Function Number: 17
set_aircraft(param_00,param_01,param_02)
{
	if(isdefined(param_01))
	{
		level.air_support_fake_altitude_inches = param_01;
	}

	if(isdefined(param_02))
	{
		level.air_support_aircraft_guntag = param_02;
	}

	level.air_support_aircraft = param_00;
}

//Function Number: 18
get_gun_pos()
{
	if(isdefined(level.air_support_aircraft) && isalive(level.air_support_aircraft))
	{
		var_00 = level.air_support_aircraft.origin;
		if(isdefined(level.air_support_aircraft_guntag))
		{
			var_00 = level.air_support_aircraft gettagorigin(level.air_support_aircraft_guntag);
		}

		if(isdefined(level.air_support_fake_altitude_inches))
		{
			var_01 = level.player geteye();
			if(var_00[2] > level.air_support_fake_altitude_inches && var_01[2] < level.air_support_fake_altitude_inches)
			{
				var_02 = level.air_support_fake_altitude_inches - var_01[2] / var_00[2] - var_01[2];
				var_00 = maps\_utility::linear_interpolate(var_02,level.player.origin,var_00);
			}
		}

		return var_00;
	}

	return self.origin + (30,15,12000);
}

//Function Number: 19
get_gun_test_pos()
{
	return get_gun_pos();
}

//Function Number: 20
strobe_can_see_targets()
{
	var_00 = compute_targets(self.origin,get_gun_pos());
	var_00 = filter_visible_targets(var_00,get_gun_test_pos());
	return var_00.size > 0;
}

//Function Number: 21
strobe_fire()
{
	self endon("death");
	if(!isdefined(self))
	{
		return;
	}

	var_00 = 10;
	var_01 = 200;
	var_02 = 60 / var_01;
	maps\_audio::aud_send_msg("ac130_prepare_inc");
	for(var_03 = 0;var_03 < var_00;var_03++)
	{
		var_04 = get_gun_pos();
		var_05 = get_gun_test_pos();
		var_06 = compute_targets(self.origin,var_04);
		var_06 = filter_visible_targets(var_06,var_05);
		var_07 = get_best_target(var_06,var_03,var_00);
		if(!isdefined(var_07))
		{
			var_07 = self.origin + noise_vector(32);
		}

		if(isdefined(self.isenemystrobe))
		{
			var_08 = magicbullet(level.air_support_weapon,var_04,var_07);
		}
		else
		{
			var_08 = magicbullet(level.air_support_weapon,var_04,var_07,self.owner);
		}

		var_08 thread projectile_impact_earthquake(0.3,0.5,1200);
		var_09 = spawnstruct();
		var_09.target_pos = var_07;
		var_09.fire_delay = var_02;
		var_09.bullet = var_08;
		maps\_audio::aud_send_msg("aud_ac130_bullet",var_09);
		wait var_02;
	}

	if(isdefined(self.fx_origin))
	{
		stopfxontag(common_scripts\utility::getfx("air_support_marker"),self.fx_origin,"tag_origin");
		self.fx_origin delete();
	}

	self delete();
}

//Function Number: 22
projectile_impact_earthquake(param_00,param_01,param_02)
{
	var_03 = self.origin;
	while(isdefined(self))
	{
		var_03 = self.origin;
		wait 0.1;
	}

	earthquake(param_00,param_01,var_03,param_02);
	playrumbleonposition("ac130_artillery_rumble",var_03);
}

//Function Number: 23
compute_targets(param_00,param_01)
{
	var_02 = 512;
	var_03 = 32;
	var_04 = 64;
	var_05 = 7500;
	var_06 = 1.1;
	var_07 = distance(param_00,param_01) / var_05 * var_06;
	var_08 = [];
	foreach(var_0A in vehicle_getarray())
	{
		if(!isdefined(var_0A.air_support_strobe_ignore) && distance2d(var_0A.origin,param_01) < var_03)
		{
			var_7B[var_7B.size] = var_0A.origin + var_0A vehicle_getvelocity() * var_08 + noise_vector(var_04);
		}
	}

	foreach(var_0D in getaiarray("axis","neutral"))
	{
		if(isalive(var_0D) && !isdefined(var_0D.air_support_strobe_ignore) && distance(var_0D.origin,param_01) < var_03)
		{
			var_7B[var_7B.size] = var_0D.origin + noise_vector(var_04);
		}
	}

	return var_7B;
}

//Function Number: 24
get_best_target(param_00,param_01,param_02)
{
	var_03 = 512;
	var_04 = self.origin + vectornormalize(self.origin - level.player.origin) * var_03;
	var_05 = self.origin + vectornormalize(level.player.origin - self.origin) * var_03;
	var_06 = vectorlerp(var_04,var_05,param_01 / param_02);
	var_07 = 9999999;
	var_08 = undefined;
	foreach(var_0A in param_00)
	{
		var_0B = distance2d(var_06,var_0A);
		if(var_0B < var_07)
		{
			var_07 = var_0B;
			var_08 = var_0A;
		}
	}

	return var_08;
}

//Function Number: 25
filter_visible_targets(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in param_00)
	{
		if(visibility_check(param_01,var_04))
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 26
noise_vector(param_00)
{
	return common_scripts\utility::randomvectorrange(0,param_00) * (1,1,0);
}

//Function Number: 27
visibility_check(param_00,param_01)
{
	return bullettracepassed(param_00,param_01 + (0,0,128),0,undefined);
}

//Function Number: 28
count_strobe_kills(param_00)
{
	level notify("air_support_strobe_stop_damage_watcher");
	level.air_support_strobe_num_killed = 0;
	level.air_support_strobe_btr_killed = 0;
	foreach(var_02 in getaiarray("axis"))
	{
		var_02 thread damage_watcher();
	}

	foreach(var_05 in vehicle_getarray())
	{
		if(isdefined(var_05.script_team) && var_05.script_team == "axis")
		{
			var_05 thread damage_watcher();
		}
	}

	wait param_00;
	level notify("air_support_strobe_stop_damage_watcher");
	level notify("air_support_strobe_killed",level.air_support_strobe_num_killed);
}

//Function Number: 29
get_num_kills()
{
	return level.air_support_strobe_num_killed;
}

//Function Number: 30
damage_watcher()
{
	level endon("air_support_strobe_stop_damage_watcher");
	if(self.health <= 0)
	{
		return;
	}

	while(isdefined(self))
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		var_0A = 0;
		if(isdefined(self.healthbuffer))
		{
			var_0A = self.healthbuffer;
		}

		if(isdefined(var_09) && var_09 == level.air_support_weapon && isdefined(self) && isdefined(self.health) && self.health <= var_0A && self.health + var_00 > var_0A && !maps\_vehicle::is_godmode())
		{
			level.air_support_strobe_num_killed++;
			if(isdefined(level.btr_courtyard) && self == level.btr_courtyard)
			{
				level.air_support_strobe_btr_killed = 1;
			}

			return;
		}
		else if(!isdefined(self) || !isdefined(self.health) || self.health <= var_0A)
		{
			return;
		}
	}
}

//Function Number: 31
monitor_last_weapon()
{
	self endon("death");
	var_00 = self getcurrentweapon();
	self.last_weapon = var_00;
	for(;;)
	{
		var_00 = self getcurrentweapon();
		self waittill("weapon_change",var_01);
		self.last_weapon = var_00;
		var_00 = var_01;
	}
}

//Function Number: 32
ensure_player_has_weapon_selected()
{
	if(self getcurrentweapon() == "none")
	{
		var_00 = 0;
		if(isdefined(self.last_weapon) && self.last_weapon != "none" && self hasweapon(self.last_weapon))
		{
			var_00 = self switchtoweapon(self.last_weapon);
		}
		else
		{
			var_01 = self getweaponslistprimaries();
			if(var_01.size > 0)
			{
				var_00 = self switchtoweapon(var_01[0]);
			}
		}
	}
}