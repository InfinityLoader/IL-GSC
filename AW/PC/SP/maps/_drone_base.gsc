/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/_drone_base.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 107 ms
 * Timestamp: 10/27/2023 1:58:45 AM
*******************************************************************/

//Function Number: 1
drone_give_soul()
{
	assign_drone_tree();
	self startusingheroonlylighting();
	if(isdefined(self.script_moveplaybackrate))
	{
		self.moveplaybackrate = self.script_moveplaybackrate;
	}
	else
	{
		self.moveplaybackrate = 1;
	}

	if(self.team == "allies")
	{
		maps\_names::get_name();
		if(isdefined(self.name))
		{
			self setlookattext(self.name,&"");
		}
	}

	if(isdefined(level.dronecallbackthread))
	{
		self thread [[ level.dronecallbackthread ]]();
	}

	if(!isdefined(self.script_friendly_fire_disable))
	{
		level thread maps\_friendlyfire::friendly_fire_think(self);
	}

	if(!isdefined(level.ai_dont_glow_in_thermal))
	{
		thermaldrawenabledrone();
	}
}

//Function Number: 2
thermaldrawenabledrone()
{
	if(!isdefined(level.dronesthermalteamselect))
	{
		level.dronesthermalteamselect = "all";
	}

	var_00 = 0;
	switch(level.dronesthermalteamselect)
	{
		case "all":
			break;

		case "axis":
			break;

		default:
			break;
	}
}

//Function Number: 3
drone_init_path()
{
	if(!isdefined(self.target))
	{
		return;
	}

	if(isdefined(level.drone_paths[self.target]))
	{
		return;
	}

	level.drone_paths[self.target] = 1;
	var_00 = self.target;
	var_01 = common_scripts\utility::getstruct(var_00,"targetname");
	if(!isdefined(var_01))
	{
		return;
	}

	var_02 = [];
	var_03 = [];
	var_04 = var_01;
	for(;;)
	{
		var_01 = var_04;
		var_05 = 0;
		for(;;)
		{
			if(!isdefined(var_01.target))
			{
				break;
			}

			var_06 = common_scripts\utility::getstructarray(var_01.target,"targetname");
			if(var_06.size)
			{
				break;
			}

			var_07 = undefined;
			foreach(var_09 in var_06)
			{
				if(isdefined(var_03[var_09.origin + ""]))
				{
					continue;
				}

				var_07 = var_09;
				break;
			}

			if(!isdefined(var_07))
			{
				break;
			}

			var_03[var_07.origin + ""] = 1;
			var_02[var_01.targetname] = var_07.origin - var_01.origin;
			var_01.angles = vectortoangles(var_02[var_01.targetname]);
			var_01 = var_07;
			var_05 = 1;
		}

		if(!var_05)
		{
			break;
		}
	}

	var_00 = self.target;
	var_01 = common_scripts\utility::getstruct(var_00,"targetname");
	var_0B = var_01;
	var_03 = [];
	for(;;)
	{
		var_01 = var_04;
		var_05 = 0;
		for(;;)
		{
			if(!isdefined(var_01.target))
			{
				return;
			}

			if(!isdefined(var_02[var_01.targetname]))
			{
				return;
			}

			var_06 = common_scripts\utility::getstructarray(var_01.target,"targetname");
			if(var_06.size)
			{
				break;
			}

			var_07 = undefined;
			foreach(var_09 in var_06)
			{
				if(isdefined(var_03[var_09.origin + ""]))
				{
					continue;
				}

				var_07 = var_09;
				break;
			}

			if(!isdefined(var_07))
			{
				break;
			}

			if(isdefined(var_01.radius))
			{
				var_0E = var_02[var_0B.targetname];
				var_0F = var_02[var_01.targetname];
				var_10 = var_0E + var_0F * 0.5;
				var_01.angles = vectortoangles(var_10);
			}

			var_05 = 1;
			var_0B = var_01;
			var_01 = var_07;
		}

		if(!var_05)
		{
			break;
		}
	}
}

//Function Number: 4
assign_drone_tree()
{
	if(isdefined(self.type))
	{
		if(self.type == "dog")
		{
			assign_animals_tree();
			return;
		}

		assign_generic_human_tree();
	}
}

//Function Number: 5
assign_generic_human_tree()
{
	self useanimtree(#animtree);
}

//Function Number: 6
assign_animals_tree()
{
	self useanimtree(#animtree);
}