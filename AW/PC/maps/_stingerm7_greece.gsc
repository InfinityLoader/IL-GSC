/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _stingerm7_greece.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 281 ms
 * Timestamp: 4/22/2024 2:23:22 AM
*******************************************************************/

//Function Number: 1
init()
{
	precacheitem("iw5_stingerm7greece_sp");
	precacheshader("bls_ui_turret_targetacquired");
	precacheshader("bls_ui_turret_targetlock_white");
	foreach(var_01 in level.players)
	{
		var_01 thread stingerm7_targeting();
		var_01 thread stingerm7_monitor_fire();
	}
}

//Function Number: 2
remove_bad_locked_targets()
{
	var_00 = [];
	foreach(var_02 in level.player.stingerm7_info.locked_targets)
	{
		if(!isdefined(var_02))
		{
			continue;
		}

		if(var_02 != level.player.stingerm7_info.level_stinger_lock_target && !isalive(var_02))
		{
			continue;
		}

		var_00[var_00.size] = var_02;
	}

	return var_00;
}

//Function Number: 3
stingerm7_targeting()
{
	self endon("death");
	self.stingerm7_info = spawnstruct();
	self.stingerm7_info.locked_targets = [];
	self.stingerm7_info.locking_time = 0;
	wait 0.05;
	self.stingerm7_info.level_stinger_lock_target = getent("stinger_lock_target","targetname");
	self.stingerm7_info.level_stinger_missile_targets = getentarray("stinger_missile_target","targetname");
	for(;;)
	{
		if(self getcurrentweapon() == "iw5_stingerm7greece_sp" && self playerads() > 0.99)
		{
			self.stingerm7_info.locked_targets = remove_bad_locked_targets();
			if(isdefined(self.stingerm7_info.locking_target))
			{
				if(!target_still_valid(self.stingerm7_info.locking_target))
				{
					target_remove(self.stingerm7_info.locking_target);
					self.stingerm7_info.locking_target = undefined;
				}
			}

			if(isdefined(self.stingerm7_info.locking_target))
			{
				self.stingerm7_info.locking_time = self.stingerm7_info.locking_time + 0.05;
			}
			else
			{
				self.stingerm7_info.locking_time = 0;
				if(self.stingerm7_info.locked_targets.size < 4)
				{
					self.stingerm7_info.locking_target = get_best_locking_target();
					if(isdefined(self.stingerm7_info.locking_target))
					{
						var_00 = self.stingerm7_info.locking_target.origin;
						target_set(self.stingerm7_info.locking_target,var_00);
						target_setshader(self.stingerm7_info.locking_target,"bls_ui_turret_targetacquired");
					}
				}
			}

			if(self.stingerm7_info.locking_time >= 0.5 && isdefined(self.stingerm7_info.locking_target) && self.stingerm7_info.locked_targets.size < 4)
			{
				self.stingerm7_info.locked_targets[self.stingerm7_info.locked_targets.size] = self.stingerm7_info.locking_target;
				self.stingerm7_info.locking_target thread locked_target_think(self);
				self.stingerm7_info.locking_target = undefined;
			}

			if(self.stingerm7_info.locked_targets.size > 0)
			{
				self weaponlockfinalize(self.stingerm7_info.locked_targets[0]);
			}
			else
			{
				self weaponlockfree();
			}
		}
		else
		{
			foreach(var_02 in self.stingerm7_info.locked_targets)
			{
				target_remove(var_02);
			}

			self.stingerm7_info.locked_targets = [];
			if(isdefined(self.stingerm7_info.locking_target))
			{
				target_remove(self.stingerm7_info.locking_target);
				self.stingerm7_info.locking_target = undefined;
			}

			self.stingerm7_info.locking_time = 0;
			self weaponlockfree();
		}

		wait 0.05;
	}
}

//Function Number: 4
stingerm7_monitor_fire()
{
	self endon("death");
	for(;;)
	{
		self waittill("missile_fire",var_00,var_01);
		if(var_01 == "iw5_stingerm7greece_sp")
		{
			stinger_fire(self,var_00);
		}
	}
}

//Function Number: 5
stinger_fire(param_00,param_01)
{
	var_02 = param_01.origin;
	var_03 = param_01.angles;
	param_01 delete();
	var_04 = remove_bad_locked_targets();
	if(var_04.size > 0)
	{
		var_04 = common_scripts\utility::array_combine(var_04,param_00.stingerm7_info.level_stinger_missile_targets);
		firemangarockets(var_04[0]);
		soundscripts\_snd::snd_message("stingerm7_shoot_tower");
		param_00 setweaponammoclip("iw5_stingerm7greece_sp",0);
	}
	else
	{
		param_00 setweaponammoclip("iw5_stingerm7greece_sp",4);
	}

	swaptolastweapon();
}

//Function Number: 6
firemangarockets(param_00)
{
	var_01 = 10;
	var_02 = 1;
	var_03 = 500;
	var_04 = 450;
	for(var_05 = 0;var_05 < 7;var_05++)
	{
		var_06 = common_scripts\utility::mod(var_05 * 360 / var_01 + randomint(30),360);
		var_07 = randomfloatrange(2.5,3.5);
		var_08 = randomfloatrange(3.6,6);
		var_09 = randomfloatrange(49,50);
		var_0A = 0;
		if(var_05 == 0)
		{
			var_07 = 3;
			var_0A = 1;
		}

		thread mangarocketparentupdate(param_00,var_02,var_03,var_04,var_0A,var_07,var_06,var_08,var_09);
	}
}

//Function Number: 7
mangarocketparentupdate(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = param_00.origin - level.player geteye();
	var_0A = vectornormalize(var_09);
	var_0B = vectorcross(var_0A,(0,0,1));
	if(param_01)
	{
		var_0B = var_0B * -1;
	}

	var_0C = level.player geteye();
	var_0D = level.player geteye() + var_09 * 0.5 + var_0B * param_02 + (0,0,param_03);
	var_0E = param_00.origin;
	var_0F = level.player common_scripts\utility::spawn_tag_origin();
	var_0F.parentorigin = level.player geteye();
	playfxontag(common_scripts\utility::getfx("manga_rocket_trail"),var_0F,"tag_origin");
	soundscripts\_snd::snd_message("manga_rocket_trail",var_0F);
	thread mangarocketupdate(param_00,var_0F,param_06,param_07,param_08);
	var_10 = 0;
	var_11 = 1 / param_05 * 20;
	var_12 = 0;
	while(var_12 <= 1)
	{
		wait(0.05);
		var_13 = squared(1 - var_10) * var_0C + 2 * var_10 * 1 - var_10 * var_0D + squared(var_10) * var_0E;
		var_0F.parentorigin = var_13;
		var_12 = var_12 + var_11;
		if(param_04)
		{
			var_10 = pow(var_12,3);
			continue;
		}

		var_10 = squared(var_12);
	}

	stopfxontag(common_scripts\utility::getfx("manga_rocket_trail"),var_0F,"tag_origin");
	playfx(common_scripts\utility::getfx("manga_rocket_explosion"),var_0F.origin,(1,0,0),(0,0,1));
	soundscripts\_snd::snd_message("manga_rocket_explosion",var_0F);
	var_0F notify("MangaRocketUpdate");
	var_0F delete();
	wait(0.3);
	maps\greece_sniper_scramble::sniperdeathinternal();
}

//Function Number: 8
mangarocketupdate(param_00,param_01,param_02,param_03,param_04)
{
	param_01 endon("MangaRocketUpdate");
	var_05 = vectornormalize(param_00.origin - level.player geteye());
	var_06 = vectortoangles(var_05);
	var_07 = param_02;
	var_08 = (0,0,0);
	if(common_scripts\utility::cointoss())
	{
		param_03 = param_03 * -1;
	}

	var_09 = param_04 / 5;
	var_0A = 0;
	for(;;)
	{
		wait(0.05);
		var_07 = var_07 + param_03;
		var_08 = (1,0,0) * var_0A;
		var_0B = transformmove(param_01.parentorigin,combineangles(var_06,(90,0,0)),(0,0,0),(0,var_07,0),var_08,(0,0,0));
		var_08 = var_0B["origin"];
		param_01.origin = vectorlerp(param_01.origin,var_08,0.5);
		var_0A = var_0A + var_09;
		var_0A = clamp(var_0A,0,param_04);
	}
}

//Function Number: 9
swaptolastweapon()
{
	var_00 = level.player common_scripts\utility::getlastweapon();
	level.player disableweapons();
	wait(5);
	level.player takeweapon("iw5_stingerm7greece_sp");
	level.player giveweapon(var_00);
	level.player switchtoweapon(var_00);
	level.player givemaxammo(var_00);
	level.player enableweapons();
	level.player allowprone(1);
}

//Function Number: 10
_randommissilemovement(param_00)
{
	self endon("death");
	self endon("within_closing_distance");
	var_01 = 0;
	var_02 = 0.25;
	for(;;)
	{
		var_03 = distance(self.origin,param_00.origin);
		var_04 = maps\_utility::linear_interpolate(clamp(var_03 / 2000,0,1),0,1);
		var_05 = randomintrange(-2500,2500) * var_04;
		var_06 = randomintrange(-500,500) * var_04;
		var_07 = randomintrange(-500,500) * var_04;
		self missile_settargetent(param_00,(var_05,0,var_07));
		wait(var_02);
	}
}

//Function Number: 11
_closingdistancecheck(param_00)
{
	self endon("death");
	for(;;)
	{
		var_01 = distance(self.origin,param_00.origin);
		if(var_01 < 500)
		{
			self notify("within_closing_distance");
			self missile_settargetent(param_00);
			break;
		}

		wait 0.05;
	}
}

//Function Number: 12
_missilemissedtargetcheck(param_00,param_01)
{
	self endon("death");
	var_02 = param_00 - param_01.origin;
	var_02 = vectornormalize(var_02);
	for(;;)
	{
		wait 0.05;
		var_03 = self.origin - param_01.origin;
		var_04 = vectordot(var_03,var_02);
		if(var_04 < -10)
		{
			self delete();
		}
	}
}

//Function Number: 13
locked_target_think(param_00)
{
	self endon("death");
	target_setshader(self,"bls_ui_turret_targetlock_white");
}

//Function Number: 14
get_best_locking_target()
{
	var_00 = [];
	if(isdefined(self.stingerm7_info.level_stinger_lock_target))
	{
		var_00[var_00.size] = self.stingerm7_info.level_stinger_lock_target;
	}

	var_01 = self geteye();
	var_02 = anglestoforward(self getgunangles());
	var_03 = undefined;
	var_04 = cos(6);
	foreach(var_06 in var_00)
	{
		if(!common_scripts\utility::array_contains(self.stingerm7_info.locked_targets,var_06) && is_enemy_target(var_06,self))
		{
			var_07 = stingerm7_get_target_pos(var_06);
			var_08 = vectordot(vectornormalize(var_07 - var_01),var_02);
			if(var_08 > var_04)
			{
				if(!1 || bullettracepassed(var_01,var_07,0,undefined))
				{
					var_03 = var_06;
					var_04 = var_08;
				}
			}
		}
	}

	return var_03;
}

//Function Number: 15
target_still_valid(param_00)
{
	var_01 = self geteye();
	var_02 = anglestoforward(self getgunangles());
	var_03 = stingerm7_get_target_pos(param_00);
	if(vectordot(vectornormalize(var_03 - var_01),var_02) > cos(6))
	{
		if(!1 || bullettracepassed(var_01,var_03,0,undefined))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 16
is_enemy_target(param_00,param_01)
{
	var_02 = undefined;
	if(isai(param_00))
	{
		var_02 = param_00.team;
	}
	else if(isdefined(param_00.script_team))
	{
		var_02 = param_00.script_team;
	}
	else if(param_00 == param_01.stingerm7_info.level_stinger_lock_target)
	{
		return 1;
	}

	return isenemyteam(var_02,param_01.team);
}

//Function Number: 17
stingerm7_get_target_pos(param_00)
{
	if(isai(param_00))
	{
		return param_00 geteye();
	}

	return param_00 getpointinbounds(0,0,0);
}

//Function Number: 18
stingerm7_get_target_offset(param_00)
{
	return stingerm7_get_target_pos(param_00) - param_00.origin;
}