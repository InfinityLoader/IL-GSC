/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _microdronelauncher.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 122 ms
 * Timestamp: 4/22/2024 2:21:58 AM
*******************************************************************/

//Function Number: 1
init()
{
	precacheitem("iw5_microdronelauncher_sp");
	foreach(var_01 in level.players)
	{
		var_01 thread monitor_microdrone_launch();
	}
}

//Function Number: 2
monitor_microdrone_launch()
{
	self endon("death");
	for(;;)
	{
		self waittill("missile_fire",var_00,var_01);
		if(issubstr(var_01,"microdronelauncher"))
		{
			if(issubstr(var_01,"smartgrenade"))
			{
				var_00 thread maps\_variable_grenade::tracking_grenade_think(self);
				continue;
			}

			var_00 thread microdrone_think(self);
		}
	}
}

//Function Number: 3
microdrone_think(param_00)
{
	self endon("death");
	var_01 = self.origin;
	maps\_shg_utility::get_differentiated_velocity();
	wait(0.05);
	maps\_shg_utility::get_differentiated_velocity();
	wait(0.05);
	var_02 = 0.1;
	var_03 = maps\_shg_utility::get_differentiated_velocity();
	for(;;)
	{
		var_04 = maps\_shg_utility::get_differentiated_velocity();
		var_05 = 0;
		if(var_02 >= 0.35)
		{
			var_06 = microdrone_get_best_target(var_01,vectornormalize(var_03),var_04,param_00);
			if(isdefined(var_06))
			{
				self missile_settargetpos(microdrone_get_target_pos(var_06));
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

//Function Number: 4
microdrone_get_best_target(param_00,param_01,param_02,param_03)
{
	var_04 = cos(15);
	var_05 = undefined;
	var_06 = cos(15);
	foreach(var_08 in common_scripts\utility::array_combine(getaiarray("axis"),vehicle_getarray()))
	{
		if(is_enemy_target(var_08,param_03) && !isdefined(var_08.pretending_to_be_dead))
		{
			var_09 = microdrone_get_target_pos(var_08);
			var_0A = vectordot(vectornormalize(param_02),vectornormalize(var_09 - self.origin));
			if(var_0A > var_06)
			{
				if(bullettracepassed(self.origin,var_09,0,var_08))
				{
					var_05 = var_08;
					var_06 = var_0A;
				}
				else
				{
				}
			}
		}
	}

	return var_05;
}

//Function Number: 5
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

//Function Number: 6
microdrone_get_target_pos(param_00)
{
	return param_00 getshootatpos();
}