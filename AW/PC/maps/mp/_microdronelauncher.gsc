/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\_microdronelauncher.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 279 ms
 * Timestamp: 4/22/2024 2:16:02 AM
*******************************************************************/

//Function Number: 1
monitor_microdrone_launch()
{
	level._effect["mdl_sticky_explosion"] = loadfx("vfx/explosion/frag_grenade_default");
	level._effect["mdl_sticky_blinking"] = loadfx("vfx/lights/light_semtex_blinking");
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	for(;;)
	{
		self waittill("missile_fire",var_00,var_01);
		if(issubstr(var_01,"iw5_microdronelauncher_mp"))
		{
			var_00 setotherent(self);
		}
	}
}

//Function Number: 2
determine_projectile_position(param_00)
{
	self endon("death");
	for(;;)
	{
		if(!isdefined(self.previous_position))
		{
			self.previous_position = self.origin;
		}

		wait(0.05);
		self.previous_position = self.origin;
	}
}

//Function Number: 3
determine_sticky_position(param_00)
{
	param_00 endon("spawned_player");
	if(!isdefined(self.previous_position))
	{
		return;
	}

	if(!isdefined(self))
	{
		return;
	}

	var_01 = self.origin - self.previous_position;
	var_02 = vectortoangles(var_01);
	var_03 = anglestoforward(var_02) * 8000;
	var_04 = self.origin + var_03;
	var_05 = bullettrace(self.previous_position,var_04,1,param_00,1,1);
	if(var_05["fraction"] < 1 && isdefined(var_05["position"]))
	{
		var_06 = spawn("script_model",var_05["position"]);
		var_06 setmodel("projectile_semtex_grenade");
		if(isdefined(var_05["entity"]))
		{
			if(isplayer(var_05["entity"]))
			{
				param_00 thread show_stuck_fanfare();
				var_05["entity"] thread show_stuck_fanfare();
			}

			var_06 linkto(var_05["entity"]);
		}

		var_06 thread sticky_timer(param_00);
		var_06 thread sticky_fx(param_00);
		var_06 thread remove_sticky(param_00);
	}
}

//Function Number: 4
microdronelauncher_cleanup()
{
	common_scripts\utility::waittill_any("death","disconnect","faux_spawn");
	if(isdefined(self.huditem))
	{
		foreach(var_01 in self.huditem)
		{
			var_01 destroy();
		}

		self.huditem = undefined;
	}
}

//Function Number: 5
show_stuck_fanfare()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	if(!isdefined(self.huditem))
	{
		self.huditem = [];
	}

	if(isdefined(self.huditem) && !isdefined(self.huditem["mdlStuckText"]))
	{
		self.huditem["mdlStuckText"] = newclienthudelem(self);
		self.huditem["mdlStuckText"].x = 0;
		self.huditem["mdlStuckText"].y = -170;
		self.huditem["mdlStuckText"].alignx = "center";
		self.huditem["mdlStuckText"].aligny = "middle";
		self.huditem["mdlStuckText"].horzalign = "center";
		self.huditem["mdlStuckText"].vertalign = "middle";
		self.huditem["mdlStuckText"].fontscale = 3;
		self.huditem["mdlStuckText"].alpha = 0;
		self.huditem["mdlStuckText"] settext("STUCK!");
		thread microdronelauncher_cleanup();
	}

	if(isdefined(self.huditem["mdlStuckText"]))
	{
		self.huditem["mdlStuckText"].alpha = 1;
		wait(2);
		self.huditem["mdlStuckText"].alpha = 0;
	}
}

//Function Number: 6
sticky_timer(param_00)
{
	param_00 endon("spawned_player");
	wait(3);
	playfx(common_scripts\utility::getfx("mdl_sticky_explosion"),self.origin);
	physicsexplosionsphere(self.origin,256,32,1);
	radiusdamage(self.origin,256,130,15,param_00,"MOD_EXPLOSIVE","iw5_microdronelauncher_mp");
	self notify("exploded");
}

//Function Number: 7
sticky_fx(param_00)
{
	param_00 endon("spawned_player");
	self endon("exploded");
	self.fx_origin = common_scripts\utility::spawn_tag_origin();
	self.fx_origin.origin = self.origin;
	self.fx_origin show();
	wait(0.1);
	playfxontag(common_scripts\utility::getfx("mdl_sticky_blinking"),self.fx_origin,"tag_origin");
}

//Function Number: 8
remove_sticky(param_00)
{
	thread remove_sticky_on_explosion(param_00);
	thread remove_sticky_on_respawn(param_00);
}

//Function Number: 9
remove_sticky_on_explosion(param_00)
{
	param_00 endon("spawned_player");
	self waittill("exploded");
	if(isdefined(self))
	{
		cleanup_sticky();
	}
}

//Function Number: 10
remove_sticky_on_respawn(param_00)
{
	self endon("exploded");
	param_00 waittill("spawned_player");
	if(isdefined(self))
	{
		cleanup_sticky();
	}
}

//Function Number: 11
cleanup_sticky()
{
	stopfxontag(common_scripts\utility::getfx("mdl_sticky_blinking"),self.fx_origin,"tag_origin");
	self delete();
}

//Function Number: 12
microdrone_think(param_00)
{
	self endon("death");
	param_00 endon("death");
	param_00 endon("disconnect");
	param_00 endon("faux_spawn");
	var_01 = self.origin;
	get_differentiated_velocity();
	wait(0.05);
	get_differentiated_velocity();
	wait(0.05);
	var_02 = 0.1;
	var_03 = get_differentiated_velocity();
	for(;;)
	{
		var_04 = get_differentiated_velocity();
		var_05 = 0;
		if(var_02 >= 0.35)
		{
			var_06 = microdrone_get_best_target(var_01,vectornormalize(var_03),var_04,param_00);
			if(isdefined(var_06))
			{
				self missile_settargetent(var_06,microdrone_get_target_offset(var_06));
				var_05 = 1;
				var_03 = var_04;
			}
		}
		else
		{
		}

		if(!var_05)
		{
			var_07 = vectornormalize(var_03 + (0,0,-400 * squared(var_02)));
			self missile_settargetpos(self.origin + var_07 * 10000);
		}

		wait(0.05);
		var_02 = var_02 + 0.05;
	}
}

//Function Number: 13
microdrone_get_best_target(param_00,param_01,param_02,param_03)
{
	var_04 = cos(15);
	var_05 = undefined;
	var_06 = cos(15);
	foreach(var_08 in level.players)
	{
		if(var_08 == param_03)
		{
			continue;
		}

		if(var_08.team == param_03.team)
		{
			continue;
		}

		var_09 = microdrone_get_target_pos(var_08);
		var_0A = vectordot(vectornormalize(param_02),vectornormalize(var_09 - self.origin));
		if(var_0A > var_06)
		{
			if(bullettracepassed(self.origin,var_09,0,var_08))
			{
				var_05 = var_08;
				var_06 = var_0A;
				continue;
			}
		}
	}

	return var_05;
}

//Function Number: 14
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

	return isenemyteam(var_02,param_01.team);
}

//Function Number: 15
microdrone_get_target_pos(param_00)
{
	return param_00 getpointinbounds(0,0,0);
}

//Function Number: 16
microdrone_get_target_offset(param_00)
{
	return microdrone_get_target_pos(param_00) - param_00.origin;
}

//Function Number: 17
get_differentiated_velocity()
{
	differentiate_motion();
	return self.differentiated_velocity;
}

//Function Number: 18
differentiate_motion()
{
	var_00 = gettime() * 0.001;
	if(!isdefined(self.differentiated_last_update))
	{
		self.differentiated_last_update = var_00;
		self.differentiated_last_origin = self.origin;
		self.differentiated_last_velocity = (0,0,0);
		self.differentiated_last_acceleration = (0,0,0);
		self.differentiated_jerk = (0,0,0);
		self.differentiated_acceleration = (0,0,0);
		self.differentiated_velocity = (0,0,0);
		self.differentiated_speed = 0;
		return;
	}

	if(self.differentiated_last_update != var_00)
	{
		var_01 = var_00 - self.differentiated_last_update;
		self.differentiated_last_update = var_00;
		self.differentiated_jerk = self.differentiated_acceleration - self.differentiated_last_acceleration / var_01;
		self.differentiated_last_acceleration = self.differentiated_acceleration;
		self.differentiated_acceleration = self.differentiated_velocity - self.differentiated_last_velocity / var_01;
		self.differentiated_last_velocity = self.differentiated_velocity;
		self.differentiated_velocity = self.origin - self.differentiated_last_origin / var_01;
		self.differentiated_last_origin = self.origin;
		self.differentiated_speed = length(self.differentiated_velocity);
	}
}