/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _stingerm7.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 268 ms
 * Timestamp: 4/22/2024 2:23:21 AM
*******************************************************************/

//Function Number: 1
init(param_00)
{
	level.stingerm7_lock_los = 1;
	level.stingerm7_lock_range = -1;
	if(isdefined(param_00))
	{
		level.stinger_weapon = param_00;
	}
	else
	{
		level.stinger_weapon = "iw5_stingerm7_sp";
	}

	precacheitem(level.stinger_weapon);
	precacheshader("bls_ui_turret_targetacquired");
	precacheshader("bls_ui_turret_targetacquired_range");
	precacheshader("bls_ui_turret_targetlock_white");
	foreach(var_02 in level.players)
	{
		var_02 thread stingerm7_targeting();
		var_02 thread stingerm7_monitor_fire();
	}
}

//Function Number: 2
stingerm7_targeting_remove_dead(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(isdefined(var_03) && isdefined(var_03.ent) && isalive(var_03.ent) && !stingerm7_get_target_ignore(var_03))
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 3
stingerm7_targeting_contains(param_00,param_01,param_02)
{
	foreach(var_04 in param_00)
	{
		if(var_04.ent == param_01)
		{
			if(isdefined(var_04.tag) && isdefined(param_02) && var_04.tag == param_02)
			{
				return 1;
			}

			if(!isdefined(var_04.tag) && !isdefined(param_02))
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 4
stingerm7_targeting()
{
	self endon("death");
	self.stingerm7_info = spawnstruct();
	self.stingerm7_info.locked_targets = [];
	self.stingerm7_info.possible_targets = [];
	self.stingerm7_info.locking_time = 0;
	for(;;)
	{
		var_00 = self.stingerm7_info.locking_target;
		var_01 = level.stingerm7_lock_range;
		if(self getcurrentweapon() == level.stinger_weapon && self playerads() > 0.99)
		{
			self.stingerm7_info.locked_targets = stingerm7_targeting_remove_dead(self.stingerm7_info.locked_targets);
			if(isdefined(var_00))
			{
				if(!target_still_valid(var_00))
				{
					target_remove(var_00.trackent);
					var_00.trackent delete();
					var_00.trackent = undefined;
					self.stingerm7_info.locking_target = undefined;
				}
			}

			if(!isdefined(var_00))
			{
				self.stingerm7_info.locking_time = 0;
				if(self.stingerm7_info.locked_targets.size < 4)
				{
					self.stingerm7_info.locking_target = get_best_locking_target();
					var_00 = self.stingerm7_info.locking_target;
					if(isdefined(var_00))
					{
						if(!isdefined(var_00.trackent))
						{
							var_02 = stingerm7_get_target_tag(var_00);
							var_00.trackent = common_scripts\utility::spawn_tag_origin();
							if(isdefined(var_02))
							{
								var_00.trackent linkto(var_00.ent,var_02,(0,0,0),(0,0,0));
							}
							else
							{
								var_00.trackent.origin = stingerm7_get_target_pos(var_00);
								var_00.trackent linkto(var_00.ent);
							}

							var_00.trackent thread stinger_track_ent_cleanup(var_00.ent);
						}

						target_set(var_00.trackent);
					}
				}
			}

			var_03 = 0;
			if(isdefined(var_00))
			{
				var_03 = var_01 < 0 || distancesquared(stingerm7_get_target_pos(var_00),level.player geteye()) < var_01 * var_01;
				if(!var_03)
				{
					if(isdefined(var_00.trackent))
					{
						target_setshader(var_00.trackent,"bls_ui_turret_targetacquired_range");
					}

					self.stingerm7_info.locking_time = 0;
				}
				else
				{
					if(isdefined(var_00.trackent))
					{
						if(!isdefined(var_00.trackent.sound_played))
						{
							soundscripts\_snd_playsound::snd_play_2d("wpn_stingerm7_locking");
							var_00.trackent.sound_played = 1;
						}

						target_setshader(var_00.trackent,"bls_ui_turret_targetacquired");
					}

					self.stingerm7_info.locking_time = self.stingerm7_info.locking_time + 0.05;
				}
			}

			if(self.stingerm7_info.locking_time >= 0.5 && isdefined(var_00) && isdefined(var_00.trackent) && self.stingerm7_info.locked_targets.size < 4)
			{
				self.stingerm7_info.locked_targets[self.stingerm7_info.locked_targets.size] = var_00;
				soundscripts\_snd_playsound::snd_play_2d("wpn_stingerm7_locked");
				target_setshader(var_00.trackent,"bls_ui_turret_targetlock_white");
				self.stingerm7_info.locking_target = undefined;
			}

			if(self.stingerm7_info.locked_targets.size > 0)
			{
				self weaponlockfinalize(self.stingerm7_info.locked_targets[0].ent);
			}
			else
			{
				self weaponlockfree();
			}
		}
		else
		{
			foreach(var_05 in self.stingerm7_info.locked_targets)
			{
				if(isdefined(var_05.trackent))
				{
					target_remove(var_05.trackent);
					var_05.trackent delete();
					var_05.trackent = undefined;
				}
			}

			foreach(var_05 in self.stingerm7_info.possible_targets)
			{
				if(isdefined(var_05.trackent))
				{
					target_remove(var_05.trackent);
					var_05.trackent delete();
					var_05.trackent = undefined;
				}
			}

			self.stingerm7_info.locked_targets = [];
			self.stingerm7_info.possible_targets = [];
			self.stingerm7_info.locking_target = undefined;
			self.stingerm7_info.locking_time = 0;
		}

		wait 0.05;
	}
}

//Function Number: 5
stinger_ignore()
{
	self.stinger_ignore = 1;
	self notify("stinger_ignore");
}

//Function Number: 6
stinger_track_ent_cleanup(param_00)
{
	self notify("stinger_track_ent_cleanup");
	self endon("stinger_track_ent_cleanup");
	self endon("death");
	param_00 common_scripts\utility::waittill_any("death","stinger_ignore");
	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 7
stingerm7_monitor_fire()
{
	self endon("death");
	for(;;)
	{
		self waittill("missile_fire",var_00,var_01);
		if(var_01 == level.stinger_weapon)
		{
			stinger_fire(self,var_00);
		}
	}
}

//Function Number: 8
stinger_fire(param_00,param_01)
{
	param_01 delete();
	var_02 = [];
	param_00.stingerm7_info.locked_targets = stingerm7_targeting_remove_dead(self.stingerm7_info.locked_targets);
	var_03 = (5,-8,5);
	if(param_00.stingerm7_info.locked_targets.size > 0)
	{
		var_04 = param_00.stingerm7_info.locked_targets;
		for(var_05 = 0;var_05 < 4;var_05++)
		{
			if(var_05 < var_04.size)
			{
				var_06 = var_04[var_05];
			}
			else
			{
				var_06 = common_scripts\utility::random(var_04);
			}

			var_07 = param_00 getplayerangles();
			var_08 = param_00 geteye();
			var_09 = anglestoforward(var_07);
			var_09 = rotatevector(var_09,(randomfloatrange(-10,10),randomfloatrange(-10,10),0));
			var_0A = var_08 + rotatevector(var_03,var_07) + var_09 * 10;
			var_0B = magicbullet(level.stinger_weapon,var_0A,var_0A + var_09 * 1000,param_00);
			soundscripts\_snd_playsound::snd_play_2d("wpn_stingerm7_plr");
			param_00 playrumbleonentity("heavy_1s");
			if(isdefined(var_0B))
			{
				var_0B thread stinger_delayed_lock(randomfloatrange(0.25,1),var_06);
				var_0B.lockedstingertarget = var_06.ent;
				var_02[var_02.size] = var_0B;
			}

			wait(0.15);
		}

		level notify("stinger_fired",param_00,var_02);
		param_00 setweaponammoclip(level.stinger_weapon,0);
		return;
	}

	param_00 setweaponammoclip(level.stinger_weapon,4);
}

//Function Number: 9
stinger_delayed_lock(param_00,param_01)
{
	self endon("death");
	param_01.ent endon("death");
	self.delayedlocktargetent = param_01.ent;
	self.delayedlocktargettag = param_01.tag;
	wait(param_00);
	if(isdefined(self.delayedlocktargetent))
	{
		self missile_settargetent(self.delayedlocktargetent,stingerm7_get_target_offset(undefined,self.delayedlocktargetent,self.delayedlocktargettag));
	}

	self.delayedlocktargetent = undefined;
	self.delayedlocktargettag = undefined;
}

//Function Number: 10
anystingermissilelockedon(param_00,param_01)
{
	foreach(var_03 in param_00)
	{
		if(isdefined(var_03.lockedstingertarget) && var_03.lockedstingertarget == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 11
get_best_locking_target()
{
	if(isdefined(level.stinger_no_ai) && level.stinger_no_ai)
	{
		var_00 = vehicle_getarray();
	}
	else
	{
		var_00 = common_scripts\utility::array_combine(getaiarray("axis"),vehicle_getarray());
	}

	if(isdefined(level.scripttargets))
	{
		level.stinger_targets = common_scripts\utility::array_combine(var_00,level.scripttargets);
	}
	else
	{
		level.stinger_targets = var_00;
	}

	var_01 = self geteye();
	var_02 = anglestoforward(self getgunangles());
	var_03 = undefined;
	var_04 = cos(3);
	foreach(var_06 in level.stinger_targets)
	{
		if(!is_enemy_target(var_06,self))
		{
			continue;
		}

		if(isdefined(var_06.stinger_override_tags))
		{
			foreach(var_08 in var_06.stinger_override_tags)
			{
				if(!stingerm7_targeting_contains(self.stingerm7_info.possible_targets,var_06,var_08))
				{
					var_09 = spawnstruct();
					var_09.ent = var_06;
					var_09.tag = var_08;
					self.stingerm7_info.possible_targets[self.stingerm7_info.possible_targets.size] = var_09;
				}
			}

			continue;
		}

		if(!stingerm7_targeting_contains(self.stingerm7_info.possible_targets,var_06))
		{
			var_09 = spawnstruct();
			var_09.ent = var_06;
			self.stingerm7_info.possible_targets[self.stingerm7_info.possible_targets.size] = var_09;
		}
	}

	self.stingerm7_info.possible_targets = stingerm7_targeting_remove_dead(self.stingerm7_info.possible_targets);
	foreach(var_0D in self.stingerm7_info.possible_targets)
	{
		if(!stingerm7_targeting_contains(self.stingerm7_info.locked_targets,var_0D.ent,var_0D.tag))
		{
			var_0E = stingerm7_get_target_pos(var_0D);
			var_0F = vectordot(vectornormalize(var_0E - var_01),var_02);
			if(var_0F > var_04)
			{
				if(!level.stingerm7_lock_los || bullettracepassed(var_01,var_0E,0,var_0D))
				{
					var_03 = var_0D;
					var_04 = var_0F;
				}
				else
				{
					foreach(var_11 in level.stinger_targets)
					{
						if(!level.stingerm7_lock_los || bullettracepassed(var_01,var_0E,0,var_11))
						{
							var_03 = var_0D;
							var_04 = var_0F;
						}
					}
				}
			}
		}
	}

	return var_03;
}

//Function Number: 12
target_still_valid(param_00)
{
	if(stingerm7_get_target_ignore(param_00))
	{
		return 0;
	}

	var_01 = self geteye();
	var_02 = anglestoforward(self getgunangles());
	var_03 = stingerm7_get_target_pos(param_00);
	if(vectordot(vectornormalize(var_03 - var_01),var_02) > cos(3))
	{
		if(!level.stingerm7_lock_los || bullettracepassed(var_01,var_03,0,param_00))
		{
			return 1;
		}
		else
		{
			foreach(var_05 in level.stinger_targets)
			{
				if(!level.stingerm7_lock_los || bullettracepassed(var_01,var_03,0,var_05))
				{
					return 1;
				}
			}
		}
	}

	return 0;
}

//Function Number: 13
is_enemy_target(param_00,param_01)
{
	var_02 = undefined;
	if(isdefined(param_00.stinger_ignore) && param_00.stinger_ignore)
	{
		return 0;
	}

	if(!isdefined(param_00.team) && !isdefined(param_00.script_team))
	{
		return 0;
	}

	if(isai(param_00))
	{
		var_02 = param_00.team;
	}
	else if(isdefined(param_00.script_team))
	{
		var_02 = param_00.script_team;
	}

	return isenemyteam(var_02,param_01.team);
}

//Function Number: 14
stingerm7_get_target_tag(param_00)
{
	if(!isdefined(param_00))
	{
		return undefined;
	}

	if(isdefined(param_00.tag))
	{
		return param_00.tag;
	}

	if(isai(param_00.ent))
	{
		return "tag_eye";
	}

	return undefined;
}

//Function Number: 15
stingerm7_get_target_pos(param_00,param_01,param_02)
{
	var_03 = param_01;
	var_04 = param_02;
	if(!isdefined(var_03))
	{
		var_03 = param_00.ent;
	}

	if(!isdefined(var_04))
	{
		var_04 = stingerm7_get_target_tag(param_00);
	}

	if(isdefined(var_04))
	{
		return var_03 gettagorigin(var_04);
	}

	return var_03 getpointinbounds(0,0,0);
}

//Function Number: 16
stingerm7_get_target_offset(param_00,param_01,param_02)
{
	var_03 = param_01;
	if(!isdefined(var_03))
	{
		var_03 = param_00.ent;
	}

	return stingerm7_get_target_pos(param_00,param_01,param_02) - var_03.origin;
}

//Function Number: 17
stingerm7_get_target_ignore(param_00,param_01)
{
	var_02 = param_01;
	if(!isdefined(var_02))
	{
		var_02 = param_00.ent;
	}

	return isdefined(var_02) && isdefined(var_02.stinger_ignore) && var_02.stinger_ignore;
}