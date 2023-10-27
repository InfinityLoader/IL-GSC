/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: vehicle_scripts/_vehicle_missile_launcher_ai.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 142 ms
 * Timestamp: 10/27/2023 2:06:43 AM
*******************************************************************/

//Function Number: 1
missile_handle_threat_grenade()
{
	self endon("death");
	self endon("stop_missle_handle_thread_grenade");
	self.targetlist = [];
	for(;;)
	{
		level.player waittill("threat_grenade_marking_started",var_00);
		var_01 = var_00.enemies;
		wait(3);
		fire_missles_at_target_array(var_01);
	}
}

//Function Number: 2
fire_missles_at_target_array_repeated(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self endon("death");
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	if(isdefined(param_05))
	{
		if(!isdefined(level.vehicle_missile_launcher_count))
		{
			level.vehicle_missile_launcher_count = [];
		}

		if(!isdefined(level.vehicle_missile_launcher_count[param_05]))
		{
			level.vehicle_missile_launcher_count[param_05] = 0;
		}
	}

	if(!isdefined(param_06))
	{
		param_06 = 2;
	}

	var_08 = 4;
	var_09 = 0;
	foreach(var_0B in param_00)
	{
		if(var_0B == level.player)
		{
			var_09 = 1;
			break;
		}
	}

	var_0D = 0;
	var_0E = level.vehicle_missile_launcher[self.classname][0];
	for(;;)
	{
		if(isdefined(param_01))
		{
			self [[ param_01 ]]();
		}

		for(;;)
		{
			var_0F = 1;
			if(var_0F && param_03)
			{
				var_10 = getdvarint("cg_fov");
				if(!level.player worldpointinreticle_circle(self.origin,var_10,250))
				{
					var_0F = 0;
				}
			}

			if(var_0F && param_04 && var_09)
			{
				var_11 = self gettagorigin(self.missiletags[0]);
				var_12 = level.player geteye() - var_11;
				var_12 = var_12 * 0.75;
				var_13 = bullettrace(var_11,var_11 + var_12,1,self,0,0,0);
				if(var_13["fraction"] < 1)
				{
					var_0F = 0;
				}
			}

			if(var_0F && param_02)
			{
				var_11 = self gettagorigin(self.missiletags[0]);
				var_12 = anglestoforward(self gettagangles(self.missiletags[0]));
				var_12 = var_12 * 100;
				var_13 = bullettrace(var_11,var_11 + var_12,1,self,0,0,0);
				if(var_13["fraction"] < 1)
				{
					var_0F = 0;
				}
			}

			if(var_0F)
			{
				if(isdefined(param_07) && !var_0D)
				{
					wait(param_07);
					var_0D = 1;
					var_0F = 0;
				}
			}

			if(var_0F && isdefined(param_05) && level.vehicle_missile_launcher_count[param_05] >= param_06)
			{
				var_0F = 0;
			}

			if(var_0F)
			{
				break;
			}

			wait(var_08 * 0.05);
			maps\_utility::array_removedead(param_00);
		}

		if(isdefined(param_05))
		{
			self.needs_to_decrement_launcher_count = 1;
			level.vehicle_missile_launcher_count[param_05]++;
			thread decrement_firing_count_if_died_while_firing(param_05,var_0E);
		}

		fire_missles_at_target_array(param_00,self.missiletags.size / param_00.size,undefined,1);
		if(isdefined(var_0E) && isdefined(var_0E.salvo_cooldown_min))
		{
			wait(randomfloatrange(var_0E.salvo_cooldown_min,var_0E.salvo_cooldown_max));
		}
		else
		{
			wait(randomfloatrange(0.5,1.5));
		}

		if(isdefined(param_05))
		{
			level.vehicle_missile_launcher_count[param_05]--;
			self.needs_to_decrement_launcher_count = 0;
			self notify("kill_decrement_firing_count_if_died_while_firing");
		}

		wait 0.05;
	}
}

//Function Number: 3
decrement_firing_count_if_died_while_firing(param_00,param_01)
{
	self notify("kill_decrement_firing_count_if_died_while_firing");
	self endon("kill_decrement_firing_count_if_died_while_firing");
	self waittill("death");
	if(isdefined(param_01) && isdefined(param_01.salvo_cooldown_min))
	{
		wait(randomfloatrange(param_01.salvo_cooldown_min,param_01.salvo_cooldown_max));
	}
	else
	{
		wait(randomfloatrange(0.5,1.5));
	}

	level.vehicle_missile_launcher_count[param_00]--;
}

//Function Number: 4
fire_missles_at_target_array(param_00,param_01,param_02,param_03)
{
	self endon("death");
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	var_04 = level.vehicle_missile_launcher[self.classname][param_02];
	var_05 = var_04.pre_fire_function;
	var_06 = var_04.post_fire_function;
	if(!param_03 && isdefined(var_05))
	{
		self [[ var_05 ]]();
	}

	if(isdefined(self.missile_target_onscreen_guys_first) && self.missile_target_onscreen_guys_first)
	{
		var_07 = getdvarint("cg_fov");
		var_08 = [];
		var_09 = [];
		foreach(var_0B in param_00)
		{
			if(!isdefined(var_0B))
			{
				continue;
			}

			if(!level.player worldpointinreticle_circle(var_0B.origin,var_07,500))
			{
				var_08[var_08.size] = var_0B;
				continue;
			}

			var_09[var_09.size] = var_0B;
		}

		foreach(var_0B in var_09)
		{
			walker_tank_handle_target(var_0B,param_01);
		}

		foreach(var_0B in var_08)
		{
			walker_tank_handle_target(var_0B,param_01);
		}
	}
	else
	{
		foreach(var_0B in param_01)
		{
			walker_tank_handle_target(var_0B,param_01);
		}
	}

	if(isdefined(var_06))
	{
		self [[ var_06 ]]();
	}

	if(isdefined(self.missile_auto_reload) && self.missile_auto_reload)
	{
		reload_launchers();
	}
}

//Function Number: 5
get_guy_or_backup_target_if_guy_died_or_dummy_target(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(isdefined(param_00) && param_02)
	{
		var_03 = common_scripts\utility::spawn_tag_origin();
		return var_03;
	}

	if(isdefined(param_01))
	{
		return param_01;
	}

	var_03 = common_scripts\utility::spawn_tag_origin();
	var_03.origin = param_01;
	return var_03;
}

//Function Number: 6
update_dummy_target_position(param_00,param_01,param_02)
{
	param_01 endon("death");
	param_02 endon("death");
	param_00 endon("death");
	if(!isdefined(param_02) || !isvalidmissile(param_00) || !isdefined(param_01))
	{
		return;
	}

	var_03 = 0;
	var_04 = 0;
	var_05 = undefined;
	if(isplayer(param_02))
	{
		var_03 = level.player geteye()[2] - param_02.origin[2];
	}

	if(randomfloat(100) > 50)
	{
		var_05 = randomfloatrange(30,40);
	}
	else
	{
		var_05 = -1 * randomfloatrange(30,40);
	}

	var_04 = randomfloatrange(-35,5);
	while(isvalidmissile(param_00))
	{
		var_06 = param_00 localtoworldcoords((0,var_05,0));
		var_07 = var_06 - param_00.origin;
		var_08 = param_02.origin + (var_07[0],var_07[1],var_03 + var_04);
		if(isplayer(param_02))
		{
			param_01.origin = var_08;
			continue;
		}

		param_01 unlink();
		param_01.origin = var_08;
		param_01 linkto(param_02);
		wait 0.05;
	}
}

//Function Number: 7
walker_tank_handle_target(param_00,param_01,param_02)
{
	self endon("death");
	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_03 = level.vehicle_missile_launcher[self.classname][param_02];
	var_04 = param_00.origin;
	var_05 = 0;
	if(!isdefined(param_01))
	{
		param_01 = randomintrange(2,4);
	}

	for(var_06 = 0;var_06 < param_01;var_06++)
	{
		if(self.missiles_loaded_count == 0)
		{
			continue;
		}

		var_07 = self.missiletags[self.missiles_loaded_count - 1];
		if(param_00 == level.player && var_06 != 0)
		{
			var_05 = 1;
		}

		thread walker_tank_missile_fire(var_07,var_04,param_02,param_00,var_05);
		if(isdefined(var_03.inter_salvo_delay))
		{
			wait(var_03.inter_salvo_delay);
			continue;
		}

		wait(0.1);
	}
}

//Function Number: 8
walker_tank_missile_fire(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	if(self.classname == "script_vehicle_corpse")
	{
		self notify("death");
	}

	if(!isdefined(level.walker_tank_reload_ok))
	{
		level.walker_tank_reload_ok = 1;
	}

	var_05 = 0;
	var_06 = 0;
	var_07 = _offset_position_from_tag("forward",param_00,20 + var_06);
	var_08 = _offset_position_from_tag("forward",param_00,200 + var_06);
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_09 = level.vehicle_missile_launcher[self.classname][param_02];
	var_0A = magicbullet(var_09.missile_object,var_07,var_08);
	if(isdefined(var_0A) && level.walker_tank_reload_ok)
	{
		self detach(var_09.missile_model,param_00);
		self.missiletagsready[self.missiles_loaded_count - 1] = 0;
		self.missiles_loaded_count--;
	}

	if(isdefined(var_09.homing_delay_min) && isdefined(var_09.homing_delay_max))
	{
		wait(randomfloatrange(var_09.homing_delay_min,var_09.homing_delay_max));
	}
	else
	{
		wait(randomfloatrange(0.5,0.85));
	}

	var_0B = get_guy_or_backup_target_if_guy_died_or_dummy_target(param_03,param_01,param_04);
	if(!isdefined(param_03) || var_0B != param_03)
	{
		var_05 = 1;
	}

	var_0C = undefined;
	if(isvalidmissile(var_0A) && !is_abort_missile(var_09,self))
	{
		var_0C = missile_createattractorent(var_0B,50000,2000,var_0A,1);
		if(param_04)
		{
			thread update_dummy_target_position(var_0A,var_0B,param_03);
		}

		if(isdefined(var_0A) && isvalidmissile(var_0A))
		{
			var_0A missile_settargetent(var_0B);
		}
	}

	while(isdefined(var_0A))
	{
		wait 0.05;
		if(isvalidmissile(var_0A) && is_abort_missile(var_09,self))
		{
			var_0A missile_cleartarget();
		}
	}

	if(var_05)
	{
		var_0B delete();
	}

	if(isdefined(var_0C))
	{
		missile_deleteattractor(var_0C);
	}
}

//Function Number: 9
is_abort_missile(param_00,param_01)
{
	if(isdefined(param_00.missile_abort_if_owner_destroyed) && param_00.missile_abort_if_owner_destroyed && !isdefined(param_01))
	{
		return 1;
	}

	return 0;
}

//Function Number: 10
_offset_position_from_tag(param_00,param_01,param_02)
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

//Function Number: 11
reload_launchers(param_00)
{
	if(isdefined(param_00))
	{
	}

	if(!isdefined(param_00))
	{
		param_00 = 0;
	}

	if(!isdefined(self.missiletagsready))
	{
		self.missiletagsready = [];
	}

	for(var_01 = 0;var_01 < self.missiletags.size;var_01++)
	{
		if(!isdefined(self.missiletagsready[var_01]) || self.missiletagsready[var_01] == 0)
		{
			self attach(level.vehicle_missile_launcher[self.classname][param_00].missile_model,self.missiletags[var_01],1);
			self.missiletagsready[var_01] = 1;
		}
	}

	self.missiles_loaded_count = self.missiletags.size;
}