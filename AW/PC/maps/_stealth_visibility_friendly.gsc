/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _stealth_visibility_friendly.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 263 ms
 * Timestamp: 4/22/2024 2:23:19 AM
*******************************************************************/

//Function Number: 1
stealth_visibility_friendly_main()
{
	friendly_init();
	thread friendly_visibility_logic();
}

//Function Number: 2
friendly_visibility_logic()
{
	self endon("death");
	self endon("pain_death");
	var_00 = self._stealth.logic.current_stance_func;
	if(isplayer(self))
	{
		thread player_movespeed_calc_loop();
	}

	for(;;)
	{
		maps\_utility::ent_flag_wait("_stealth_enabled");
		self [[ var_00 ]]();
		self.maxvisibledist = friendly_compute_score();
		wait(0.05);
	}
}

//Function Number: 3
friendly_getvelocity()
{
	return length(self getvelocity());
}

//Function Number: 4
friendly_getinshadow()
{
	return maps\_utility::ent_flag_exist("_stealth_in_shadow") && maps\_utility::ent_flag("_stealth_in_shadow");
}

//Function Number: 5
player_getvelocity_pc()
{
	var_00 = length(self getvelocity());
	var_01 = self._stealth.logic.stance;
	var_02 = [];
	var_02["stand"] = 30;
	var_02["crouch"] = 15;
	var_02["prone"] = 4;
	var_03 = [];
	var_03["stand"] = 40;
	var_03["crouch"] = 25;
	var_03["prone"] = 10;
	if(!var_00)
	{
		self._stealth.logic.player_pc_velocity = 0;
	}
	else if(var_00 > self._stealth.logic.player_pc_velocity)
	{
		self._stealth.logic.player_pc_velocity = self._stealth.logic.player_pc_velocity + var_02[var_01];
		if(self._stealth.logic.player_pc_velocity > var_00)
		{
			self._stealth.logic.player_pc_velocity = var_00;
		}
	}
	else if(var_00 < self._stealth.logic.player_pc_velocity)
	{
		self._stealth.logic.player_pc_velocity = self._stealth.logic.player_pc_velocity - var_03[var_01];
		if(self._stealth.logic.player_pc_velocity < 0)
		{
			self._stealth.logic.player_pc_velocity = 0;
		}
	}

	return self._stealth.logic.player_pc_velocity;
}

//Function Number: 6
friendly_get_stance(param_00)
{
	if(!isdefined(param_00))
	{
		if(isdefined(self._stealth))
		{
			param_00 = self._stealth.logic.stance;
		}
		else
		{
			param_00 = self.a.stance;
		}
	}

	if(isdefined(param_00) && param_00 == "back")
	{
		param_00 = "prone";
	}

	if(isdefined(self.type) && self.type == "dog")
	{
		if(isdefined(self.sprint) && self.sprint)
		{
			param_00 = "crouch";
		}
		else
		{
			param_00 = "prone";
		}
	}

	return param_00;
}

//Function Number: 7
friendly_compute_score(param_00)
{
	if(!isdefined(self._stealth))
	{
		return;
	}

	param_00 = friendly_get_stance(param_00);
	var_01 = level._stealth.logic.detection_level;
	var_02 = level._stealth.logic.detect_range[var_01][param_00];
	if(self [[ self._stealth.logic.getinshadow_func ]]())
	{
		var_02 = var_02 * 0.5;
		if(var_02 < level._stealth.logic.detect_range["hidden"]["prone"])
		{
			var_02 = level._stealth.logic.detect_range["hidden"]["prone"];
		}
	}

	var_03 = self._stealth.logic.movespeed_multiplier[var_01][param_00];
	if(isdefined(self._stealth_move_detection_cap) && var_03 > self._stealth_move_detection_cap)
	{
		var_03 = self._stealth_move_detection_cap;
	}

	return var_02 + var_03;
}

//Function Number: 8
friendly_getstance_ai()
{
	return self.a.pose;
}

//Function Number: 9
friendly_getangles_ai()
{
	return self.angles;
}

//Function Number: 10
friendly_compute_stances_ai()
{
	self._stealth.logic.stance = self [[ self._stealth.logic.getstance_func ]]();
	self._stealth.logic.oldstance = self._stealth.logic.stance;
}

//Function Number: 11
player_movespeed_calc_loop()
{
	self endon("death");
	self endon("pain_death");
	var_00 = self._stealth.logic.getangles_func;
	var_01 = self._stealth.logic.getvelocity_func;
	var_02 = self [[ var_00 ]]();
	for(;;)
	{
		maps\_utility::ent_flag_wait("_stealth_enabled");
		var_03 = undefined;
		if(self [[ self._stealth.logic.getinshadow_func ]]())
		{
			var_03 = 0;
		}
		else
		{
			var_03 = self [[ var_01 ]]();
		}

		foreach(var_09, var_05 in self._stealth.logic.movespeed_multiplier)
		{
			foreach(var_08, var_07 in var_05)
			{
				var_07 = var_03 * self._stealth.logic.movespeed_scale[var_09][var_08];
			}
		}

		var_02 = self [[ var_00 ]]();
		wait(0.1);
	}
}

//Function Number: 12
friendly_getstance_player()
{
	return self getstance();
}

//Function Number: 13
friendly_getangles_player()
{
	return self getplayerangles();
}

//Function Number: 14
friendly_compute_stances_player()
{
	var_00 = self [[ self._stealth.logic.getstance_func ]]();
	if(!self._stealth.logic.stance_change)
	{
		switch(var_00)
		{
			case "prone":
				if(self._stealth.logic.oldstance != "prone")
				{
					self._stealth.logic.stance_change = self._stealth.logic.stance_change_time;
				}
				break;

			case "crouch":
				if(self._stealth.logic.oldstance == "stand")
				{
					self._stealth.logic.stance_change = self._stealth.logic.stance_change_time;
				}
				break;
		}
	}

	if(self._stealth.logic.stance_change)
	{
		self._stealth.logic.stance = self._stealth.logic.oldstance;
		if(self._stealth.logic.stance_change > 0.05)
		{
			self._stealth.logic.stance_change = self._stealth.logic.stance_change - 0.05;
			return;
		}

		self._stealth.logic.stance_change = 0;
		self._stealth.logic.stance = var_00;
		self._stealth.logic.oldstance = var_00;
		return;
	}

	self._stealth.logic.stance = var_00;
	self._stealth.logic.oldstance = var_00;
}

//Function Number: 15
friendly_init()
{
	maps\_utility::ent_flag_init("_stealth_in_shadow");
	maps\_utility::ent_flag_init("_stealth_enabled");
	maps\_utility::ent_flag_set("_stealth_enabled");
	self._stealth = spawnstruct();
	self._stealth.logic = spawnstruct();
	if(isplayer(self))
	{
		self._stealth.logic.getstance_func = ::friendly_getstance_player;
		self._stealth.logic.getangles_func = ::friendly_getangles_player;
		if(level.console)
		{
			self._stealth.logic.getvelocity_func = ::friendly_getvelocity;
		}
		else
		{
			self._stealth.logic.getvelocity_func = ::player_getvelocity_pc;
			self._stealth.logic.player_pc_velocity = 0;
		}

		self._stealth.logic.current_stance_func = ::friendly_compute_stances_player;
	}
	else
	{
		self._stealth.logic.getstance_func = ::friendly_getstance_ai;
		self._stealth.logic.getangles_func = ::friendly_getangles_ai;
		self._stealth.logic.getvelocity_func = ::friendly_getvelocity;
		self._stealth.logic.current_stance_func = ::friendly_compute_stances_ai;
	}

	self._stealth.logic.getinshadow_func = ::friendly_getinshadow;
	self._stealth.logic.stance_change_time = 0.2;
	self._stealth.logic.stance_change = 0;
	self._stealth.logic.oldstance = self [[ self._stealth.logic.getstance_func ]]();
	self._stealth.logic.stance = self [[ self._stealth.logic.getstance_func ]]();
	self._stealth.logic.spotted_list = [];
	self._stealth.logic.movespeed_multiplier = [];
	self._stealth.logic.movespeed_scale = [];
	self._stealth.logic.movespeed_multiplier["hidden"] = [];
	self._stealth.logic.movespeed_multiplier["hidden"]["prone"] = 0;
	self._stealth.logic.movespeed_multiplier["hidden"]["crouch"] = 0;
	self._stealth.logic.movespeed_multiplier["hidden"]["stand"] = 0;
	self._stealth.logic.movespeed_multiplier["spotted"] = [];
	self._stealth.logic.movespeed_multiplier["spotted"]["prone"] = 0;
	self._stealth.logic.movespeed_multiplier["spotted"]["crouch"] = 0;
	self._stealth.logic.movespeed_multiplier["spotted"]["stand"] = 0;
	friendly_default_movespeed_scale();
}

//Function Number: 16
friendly_default_movespeed_scale()
{
	var_00 = [];
	var_00["prone"] = 3;
	var_00["crouch"] = 2;
	var_00["stand"] = 2;
	var_01 = [];
	var_01["prone"] = 2;
	var_01["crouch"] = 2;
	var_01["stand"] = 2;
	friendly_set_movespeed_scale(var_00,var_01);
}

//Function Number: 17
friendly_set_movespeed_scale(param_00,param_01)
{
	if(isdefined(param_00))
	{
		self._stealth.logic.movespeed_scale["hidden"]["prone"] = param_00["prone"];
		self._stealth.logic.movespeed_scale["hidden"]["crouch"] = param_00["crouch"];
		self._stealth.logic.movespeed_scale["hidden"]["stand"] = param_00["stand"];
	}

	if(isdefined(param_01))
	{
		self._stealth.logic.movespeed_scale["spotted"]["prone"] = param_01["prone"];
		self._stealth.logic.movespeed_scale["spotted"]["crouch"] = param_01["crouch"];
		self._stealth.logic.movespeed_scale["spotted"]["stand"] = param_01["stand"];
	}
}