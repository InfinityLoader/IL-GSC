/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: vehicle_scripts/_pdrone_threat_sensor.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 118 ms
 * Timestamp: 10/27/2023 2:06:37 AM
*******************************************************************/

//Function Number: 1
build_threat_data()
{
	var_00 = spawnstruct();
	var_00.threat = undefined;
	var_00.threat_visible_time = 0;
	self.drone_threat_data = var_00;
}

//Function Number: 2
pdrone_update_threat_sensor()
{
	self notify("pdrone_update_threat_sensor");
	self endon("pdrone_update_threat_sensor");
	self endon("death");
	self endon("emp_death");
	var_00 = "allies";
	if(self.script_team == "allies")
	{
		var_00 = "axis";
	}

	for(;;)
	{
		wait(0.05);
		if(maps\_utility::ent_flag("fire_disabled") || isdefined(self.pacifist) && self.pacifist || isdefined(self.ignoreall) && self.ignoreall)
		{
			self.drone_threat_data.threat = undefined;
			continue;
		}

		if(isdefined(self.favoriteenemy))
		{
			self.drone_threat_data.threat = self.favoriteenemy;
			continue;
		}

		var_01 = getaiarray(var_00);
		if(self.script_team == "axis")
		{
			var_01 = common_scripts\utility::array_add(var_01,level.player);
		}

		var_02 = undefined;
		var_03 = -1;
		foreach(var_05 in var_01)
		{
			wait(0.05);
			var_06 = calculate_threat_level(self.drone_threat_data,var_05);
			if(var_06 > var_03)
			{
				var_03 = var_06;
				var_02 = var_05;
			}
		}

		self.drone_threat_data.threat = var_02;
	}
}

//Function Number: 3
calculate_threat_level(param_00,param_01)
{
	var_02 = 0;
	var_03[0] = ::evaluate_threat_valid_threat;
	var_03[1] = ::evaluate_threat_range;
	var_03[2] = ::evaluate_threat_player;
	var_03[3] = ::evaluate_threat_avoid_friendly_fire;
	var_03[4] = ::evaluate_threat_los;
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		var_05 = self [[ var_03[var_04] ]](param_01);
		if(var_05 < 0)
		{
			return -1;
		}

		var_02 = var_02 + var_05;
	}

	return var_02 / var_03.size;
}

//Function Number: 4
evaluate_threat_valid_threat(param_00)
{
	if(!isdefined(param_00) || !isalive(param_00))
	{
		return -1;
	}

	if(isdefined(param_00.ignoreme) && param_00.ignoreme == 1)
	{
		return -1;
	}

	return 1;
}

//Function Number: 5
evaluate_threat_los(param_00)
{
	if(self.script_team == "allies")
	{
		return 1;
	}

	var_01 = self.origin;
	if(self gettagindex("tag_flash") != -1)
	{
		var_01 = self gettagorigin("tag_flash");
	}

	if(trace_to_enemy(var_01,param_00,undefined))
	{
		if(param_00 == level.player)
		{
			self.drone_threat_data.threat_visible_time = self.drone_threat_data.threat_visible_time + 0.05;
		}

		return 1;
	}

	if(param_00 == level.player)
	{
		self.drone_threat_data.threat_visible_time = 0;
	}

	return -1;
}

//Function Number: 6
evaluate_threat_range(param_00)
{
	var_01 = length(param_00.origin - self.origin);
	var_02 = max(1 - var_01 / 3000,0);
	return var_02;
}

//Function Number: 7
evaluate_threat_player(param_00)
{
	if(!isplayer(param_00))
	{
		return 0.8;
	}

	return 1;
}

//Function Number: 8
evaluate_threat_avoid_friendly_fire(param_00)
{
	if(self.script_team == "axis")
	{
		return 1;
	}

	if(maps\_utility::shot_endangers_any_player(self.origin,param_00.origin))
	{
		return -1;
	}

	return 1;
}

//Function Number: 9
trace_to_enemy(param_00,param_01,param_02)
{
	var_03 = bullettrace(param_00,param_01 geteye(),0,param_02,0,0,0,0,0);
	if(isdefined(var_03["entity"]) && var_03["entity"] maps\_vehicle::isvehicle())
	{
		if(isdefined(var_03["entity"].vehicletype) && var_03["entity"].vehicletype == "pdrone")
		{
			return 1;
		}

		var_04 = var_03["entity"] getvehicleowner();
		if(isdefined(var_04) && var_04 == param_01)
		{
			return 1;
		}
	}

	return var_03["fraction"] == 1;
}