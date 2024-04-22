/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _vehicle_multiweapon_util.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 154 ms
 * Timestamp: 4/22/2024 2:05:37 AM
*******************************************************************/

//Function Number: 1
turret_to_missile_index(param_00)
{
	return -2 - param_00;
}

//Function Number: 2
set_forced_target(param_00,param_01)
{
	if(!vehicle_scripts\_vehicle_turret_ai::is_valid_target(param_00))
	{
		return;
	}

	if(!isdefined(param_01))
	{
		thread vehicle_scripts\_vehicle_turret_ai::vehicle_set_forced_target(param_00);
		if(isdefined(self.mgturret))
		{
			foreach(var_03 in self.mgturret)
			{
				self notify("mgturret_acquire_new_target");
				var_03.ai_target_force = param_00;
			}

			return;
		}

		return;
	}

	if(var_04 == -1)
	{
		thread vehicle_scripts\_vehicle_turret_ai::vehicle_set_forced_target(var_03);
		return;
	}

	if(var_04 <= -2)
	{
		thread vehicle_scripts\_vehicle_turret_ai::vehicle_set_forced_target(var_03);
		return;
	}

	if(isdefined(self.mgturret))
	{
		self notify("mgturret_acquire_new_target");
		self.mgturret[var_04].ai_target_force = var_03;
		return;
	}
}

//Function Number: 3
disable_firing(param_00)
{
	set_firing_disabled(1,param_00);
}

//Function Number: 4
enable_firing(param_00)
{
	set_firing_disabled(0,param_00);
}

//Function Number: 5
set_firing_disabled(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		thread vehicle_scripts\_vehicle_turret_ai::vehicle_set_firing_disabled(param_00);
		if(isdefined(self.mgturret))
		{
			foreach(var_03 in self.mgturret)
			{
				var_03.disable_firing = param_00;
			}

			return;
		}

		return;
	}

	if(var_04 == -1)
	{
		thread vehicle_scripts\_vehicle_turret_ai::vehicle_set_firing_disabled(var_03);
		return;
	}

	if(var_04 <= -2)
	{
		thread vehicle_scripts\_vehicle_turret_ai::vehicle_set_firing_disabled(var_03);
		return;
	}

	if(isdefined(self.mgturret))
	{
		self.mgturret[var_04].disable_firing = var_03;
		return;
	}
}

//Function Number: 6
disable_tracking(param_00)
{
	set_target_tracking_disabled(1,param_00);
}

//Function Number: 7
enable_tracking(param_00)
{
	set_target_tracking_disabled(0,param_00);
}

//Function Number: 8
set_target_tracking_disabled(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		thread vehicle_scripts\_vehicle_turret_ai::vehicle_set_target_tracking_disabled(param_00);
		if(isdefined(self.mgturret))
		{
			foreach(var_03 in self.mgturret)
			{
				var_03.disable_target_tracking = param_00;
				if(0 && param_00)
				{
					var_03.ai_target_force = undefined;
				}
			}

			return;
		}

		return;
	}

	if(var_04 == -1)
	{
		thread vehicle_scripts\_vehicle_turret_ai::vehicle_set_target_tracking_disabled(var_03);
		return;
	}

	if(var_04 <= -2)
	{
		thread vehicle_scripts\_vehicle_turret_ai::vehicle_set_target_tracking_disabled(var_03);
		return;
	}

	if(isdefined(self.mgturret))
	{
		self.mgturret[var_04].disable_target_tracking = var_03;
		if(0 && var_03)
		{
			self.mgturret[var_04].ai_target_force = undefined;
			return;
		}

		return;
	}
}

//Function Number: 9
set_threat_grenade_response(param_00,param_01)
{
	if(!isdefined(self.threat_grenade_response_is_on))
	{
		self.threat_grenade_response_is_on = [];
	}

	var_02 = get_turret_iteration_helper(param_01);
	var_03 = var_02[0];
	var_04 = var_02[1];
	for(var_05 = var_03;var_05 <= var_04;var_05++)
	{
		if(var_05 <= -2)
		{
			self.threat_grenade_response_is_on[var_05] = param_00;
			if(param_00)
			{
				self notify("stop_missle_handle_thread_grenade");
				thread vehicle_scripts\_vehicle_missile_launcher_ai::missile_handle_threat_grenade();
			}
			else
			{
				self notify("stop_missle_handle_thread_grenade");
			}

			continue;
		}

		thread vehicle_scripts\_vehicle_turret_ai::vehicle_set_threat_grenade_response(param_00);
		self.threat_grenade_response_is_on[var_05] = param_00;
	}
}

//Function Number: 10
get_turret_iteration_helper(param_00)
{
	var_01 = param_00;
	var_02 = param_00;
	if(!isdefined(param_00))
	{
		var_01 = -3;
		var_02 = 3;
	}

	return [var_01,var_02];
}