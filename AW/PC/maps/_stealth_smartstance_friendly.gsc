/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _stealth_smartstance_friendly.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 223 ms
 * Timestamp: 4/22/2024 2:23:10 AM
*******************************************************************/

//Function Number: 1
stealth_smartstance_friendly_main()
{
	friendly_init();
	thread friendly_stance_handler();
}

//Function Number: 2
friendly_stance_handler()
{
	self endon("death");
	self endon("pain_death");
	self.old_fixednode = self.fixednode;
	self.old_fixednodesaferadius = self.fixednodesaferadius;
	for(;;)
	{
		maps\_utility::ent_flag_wait("_stealth_stance_handler");
		common_scripts\utility::flag_waitopen("_stealth_spotted");
		self.fixednode = 1;
		self.fixednodesaferadius = 10;
		while(maps\_utility::ent_flag("_stealth_stance_handler") && !common_scripts\utility::flag("_stealth_spotted"))
		{
			friendly_stance_handler_set_stance_up();
			var_00 = [];
			var_00 = friendly_stance_handler_check_mightbeseen(var_00);
			if(var_00[self._stealth.logic.stance])
			{
				thread friendly_stance_handler_change_stance_down();
				continue;
			}

			if(maps\_utility::ent_flag("_stealth_stay_still"))
			{
				thread friendly_stance_handler_resume_path();
				continue;
			}

			if(!var_00[self._stealth.behavior.stance_up] && self._stealth.behavior.stance_up != self._stealth.logic.stance)
			{
				thread friendly_stance_handler_change_stance_up();
				continue;
			}

			if(maps\_utility::ent_flag("_stealth_stance_change"))
			{
				self notify("_stealth_stance_dont_change");
			}

			wait(0.05);
		}

		self.fixednode = self.old_fixednode;
		self.fixednodesaferadius = self.old_fixednodesaferadius;
		self.moveplaybackrate = 1;
		self allowedstances("stand","crouch","prone");
		if(maps\_utility::ent_flag("_stealth_stay_still"))
		{
			thread friendly_stance_handler_resume_path(0);
		}
	}
}

//Function Number: 3
friendly_stance_handler_set_stance_up()
{
	switch(self._stealth.logic.stance)
	{
		case "prone":
			self._stealth.behavior.stance_up = "crouch";
			break;

		case "crouch":
			self._stealth.behavior.stance_up = "stand";
			break;

		case "stand":
			self._stealth.behavior.stance_up = "stand";
			break;
	}
}

//Function Number: 4
friendly_stance_handler_check_mightbeseen(param_00)
{
	var_01 = getaispeciesarray("bad_guys","all");
	param_00[self._stealth.logic.stance] = 0;
	param_00[self._stealth.behavior.stance_up] = 0;
	foreach(var_03 in var_01)
	{
		var_04 = friendly_stance_handler_return_ai_sight(var_03,self._stealth.logic.stance);
		var_05 = friendly_stance_handler_return_ai_sight(var_03,self._stealth.behavior.stance_up);
		var_06 = maps\_stealth_visibility_friendly::friendly_compute_score() + var_04;
		var_07 = maps\_stealth_visibility_friendly::friendly_compute_score(self._stealth.behavior.stance_up) + var_05;
		var_08 = distance(var_03.origin,self.origin);
		if(var_08 < var_06)
		{
			param_00[self._stealth.logic.stance] = var_06;
			break;
		}

		if(var_08 < var_07)
		{
			param_00[self._stealth.behavior.stance_up] = var_07;
		}
	}

	return param_00;
}

//Function Number: 5
friendly_stance_handler_return_ai_sight(param_00,param_01)
{
	var_02 = anglestoforward(param_00.angles);
	var_03 = vectornormalize(self.origin - param_00.origin);
	var_04 = vectordot(var_02,var_03);
	if(var_04 > 0.3)
	{
		return self._stealth.behavior.stance_handler["looking_towards"][param_01];
	}

	if(var_04 < -0.7)
	{
		return self._stealth.behavior.stance_handler["looking_away"][param_01];
	}

	return self._stealth.behavior.stance_handler["neutral"][param_01];
}

//Function Number: 6
friendly_stance_handler_change_stance_down()
{
	self.moveplaybackrate = 1;
	self notify("_stealth_stance_down");
	switch(self._stealth.logic.stance)
	{
		case "stand":
			self.moveplaybackrate = 0.7;
			self allowedstances("crouch");
			break;

		case "crouch":
			if(self._stealth.behavior.no_prone)
			{
				friendly_stance_handler_stay_still();
			}
			else
			{
				self allowedstances("prone");
			}
			break;

		case "prone":
			friendly_stance_handler_stay_still();
			break;
	}
}

//Function Number: 7
friendly_stance_handler_change_stance_up()
{
	self endon("_stealth_stance_down");
	self endon("_stealth_stance_dont_change");
	self endon("_stealth_stance_handler");
	if(maps\_utility::ent_flag("_stealth_stance_change"))
	{
		return;
	}

	var_00 = 4;
	maps\_utility::ent_flag_set("_stealth_stance_change");
	maps\_utility::add_wait(::maps\_utility::_wait,var_00);
	maps\_utility::add_wait(::maps\_utility::waittill_msg,"_stealth_stance_down");
	maps\_utility::add_wait(::maps\_utility::waittill_msg,"_stealth_stance_dont_change");
	maps\_utility::add_wait(::maps\_utility::waittill_msg,"_stealth_stance_handler");
	maps\_utility::add_func(::maps\_utility::ent_flag_clear,"_stealth_stance_change");
	thread maps\_utility::do_wait_any();
	wait(var_00);
	self.moveplaybackrate = 1;
	switch(self._stealth.logic.stance)
	{
		case "prone":
			self allowedstances("crouch");
			break;

		case "crouch":
			self allowedstances("stand");
			break;

		case "stand":
			break;
	}
}

//Function Number: 8
friendly_stance_handler_stay_still()
{
	self notify("friendly_stance_handler_stay_still");
	if(maps\_utility::ent_flag("_stealth_stay_still"))
	{
		return;
	}

	maps\_utility::ent_flag_set("_stealth_stay_still");
	badplace_cylinder("_stealth_" + self.unique_id + "_prone",0,self.origin,30,90,"bad_guys");
	self.fixednodesaferadius = 5000;
}

//Function Number: 9
friendly_stance_handler_resume_path(param_00)
{
	self endon("friendly_stance_handler_stay_still");
	if(!isdefined(param_00))
	{
		param_00 = self._stealth.behavior.wait_resume_path;
	}

	wait(param_00);
	if(!maps\_utility::ent_flag("_stealth_stay_still"))
	{
		return;
	}

	maps\_utility::ent_flag_clear("_stealth_stay_still");
	badplace_delete("_stealth_" + self.unique_id + "_prone");
	self.fixednodesaferadius = 10;
}

//Function Number: 10
friendly_init()
{
	maps\_utility::ent_flag_init("_stealth_stance_handler");
	maps\_utility::ent_flag_init("_stealth_stay_still");
	maps\_utility::ent_flag_init("_stealth_stance_change");
	self._stealth.behavior.stance_up = undefined;
	self._stealth.behavior.stance_handler = [];
	friendly_default_stance_handler_distances();
	self._stealth.behavior.no_prone = 0;
	self._stealth.behavior.wait_resume_path = 2;
	self._stealth.plugins.smartstance = 1;
}

//Function Number: 11
friendly_default_stance_handler_distances()
{
	var_00 = [];
	var_00["stand"] = 500;
	var_00["crouch"] = -400;
	var_00["prone"] = 0;
	var_01 = [];
	var_01["stand"] = 500;
	var_01["crouch"] = 200;
	var_01["prone"] = 50;
	var_02 = [];
	var_02["stand"] = 800;
	var_02["crouch"] = 400;
	var_02["prone"] = 100;
	friendly_set_stance_handler_distances(var_00,var_01,var_02);
}

//Function Number: 12
friendly_set_stance_handler_distances(param_00,param_01,param_02)
{
	if(isdefined(param_00))
	{
		foreach(var_05, var_04 in param_00)
		{
			self._stealth.behavior.stance_handler["looking_away"][var_05] = var_04;
		}
	}

	if(isdefined(param_01))
	{
		foreach(var_05, var_04 in param_01)
		{
			self._stealth.behavior.stance_handler["neutral"][var_05] = var_04;
		}
	}

	if(isdefined(param_02))
	{
		foreach(var_05, var_04 in param_02)
		{
			self._stealth.behavior.stance_handler["looking_towards"][var_05] = var_04;
		}
	}
}