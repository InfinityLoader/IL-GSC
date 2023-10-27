/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_animatedmodels.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 258 ms
 * Timestamp: 10/27/2023 2:47:11 AM
*******************************************************************/

//Function Number: 1
main()
{
	waittillframeend;
	init_wind_if_uninitialized();
	thread heliwind_init_spawn_tracker();
	level.init_animatedmodels_dump = [];
	level.anim_prop_models_animtree = #animtree;
	if(!isdefined(level.anim_prop_models))
	{
		level.anim_prop_models = [];
	}

	if(!isdefined(level.anim_prop_init_threads))
	{
		level.anim_prop_init_threads = [];
	}

	var_00 = getentarray("animated_model","targetname");
	common_scripts\utility::array_thread(var_00,::model_init);
	if(isdefined(level.init_animatedmodels_dump) && level.init_animatedmodels_dump.size)
	{
		var_01 = " ";
		foreach(var_03 in level.init_animatedmodels_dump)
		{
			var_01 = var_01 + var_03 + " ";
		}
	}

	foreach(var_06 in var_00)
	{
		if(isdefined(level.anim_prop_init_threads[var_06.model]))
		{
			var_06 thread [[ level.anim_prop_init_threads[var_06.model] ]]();
			continue;
		}

		var_07 = getarraykeys(level.anim_prop_models[var_06.model]);
		var_08 = 0;
		foreach(var_0A in var_07)
		{
			if(var_0A == "still")
			{
				var_08 = 1;
				break;
			}
		}

		if(var_08)
		{
			var_06 thread animatetreewind();
		}
		else
		{
			var_06 thread animatemodel();
		}
	}
}

//Function Number: 2
init_wind_if_uninitialized()
{
	if(isdefined(level.wind))
	{
		return;
	}

	level.wind = spawnstruct();
	level.wind.rate = 0.4;
	level.wind.weight = 1;
	level.wind.variance = 0.2;
}

//Function Number: 3
model_init()
{
	if(!isdefined(level.anim_prop_models[self.model]))
	{
		if(!already_dumpped(level.init_animatedmodels_dump,self.model))
		{
			level.init_animatedmodels_dump[level.init_animatedmodels_dump.size] = self.model;
		}
	}
}

//Function Number: 4
already_dumpped(param_00,param_01)
{
	if(param_00.size <= 0)
	{
		return 0;
	}

	foreach(var_03 in param_00)
	{
		if(var_03 == param_01)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 5
animatemodel()
{
	self useanimtree(#animtree);
	var_00 = getarraykeys(level.anim_prop_models[self.model]);
	var_01 = var_00[randomint(var_00.size)];
	var_02 = level.anim_prop_models[self.model][var_01];
	self setanim(var_02,1,self getanimtime(var_02),1);
	self setanimtime(var_02,randomfloatrange(0,1));
}

//Function Number: 6
animatetreewind()
{
	thread heliwind_setup();
	self useanimtree(#animtree);
	var_00 = "strong";
	for(;;)
	{
		thread blendtreeanims(var_00);
		level waittill("windchange",var_00);
	}
}

//Function Number: 7
blendtreeanims(param_00)
{
	level endon("windchange");
	var_01 = level.wind.weight;
	var_02 = level.wind.rate + randomfloat(level.wind.variance);
	self setanim(level.anim_prop_models[self.model]["still"],1,self getanimtime(level.anim_prop_models[self.model]["still"]),var_02);
	self setanim(level.anim_prop_models[self.model][param_00],var_01,self getanimtime(level.anim_prop_models[self.model][param_00]),var_02);
}

//Function Number: 8
heliwind_check_should_track()
{
	var_00 = getarraykeys(level.anim_prop_models[self.model]);
	return common_scripts\utility::array_contains(var_00,"heli");
}

//Function Number: 9
heliwind_setup()
{
	if(!heliwind_check_should_track())
	{
		return;
	}

	self.heliwind_weight = 0;
	self.heliwind_max_delta = 0.025;
	self.heliwind_distance = 2000;
	self.heliwind_distance_sqr = self.heliwind_distance * self.heliwind_distance;
	thread heliwind_track();
	thread heliwind_animate_tree();
}

//Function Number: 10
heliwind_smoothstep(param_00,param_01,param_02)
{
	param_02 = param_02 - param_00 / param_01 - param_00;
	var_03 = clamp(param_02,0,1);
	return var_03 * var_03 * 3 - 2 * var_03;
}

//Function Number: 11
heliwind_get_closest_fraction(param_00)
{
	var_01 = distancesquared(param_00.origin,self.origin);
	self.closest_origin = param_00.origin;
	return 1 - clamp(var_01 / self.heliwind_distance_sqr,0,1);
}

//Function Number: 12
heliwind_get_closest_heli()
{
	var_00 = 1E+08;
	var_01 = 0;
	for(var_02 = 0;var_02 < level.anim_models_helis.size;var_02++)
	{
		var_03 = level.anim_models_helis[var_02];
		if(!isdefined(var_03))
		{
			continue;
		}

		var_04 = distancesquared(var_03.origin,self.origin);
		if(var_04 < var_00)
		{
			var_00 = var_04;
			var_01 = var_02;
		}
	}

	return level.anim_models_helis[var_01];
}

//Function Number: 13
heliwind_fadeoff()
{
	if(self.heliwind_weight > 0)
	{
		var_00 = clamp(self.heliwind_weight - self.heliwind_max_delta,0,1);
		var_01 = heliwind_smoothstep(0,1,var_00);
		self.heliwind_weight = var_01;
	}
}

//Function Number: 14
heliwind_track()
{
	for(;;)
	{
		var_00 = heliwind_get_closest_heli();
		if(isdefined(var_00))
		{
			var_01 = heliwind_get_closest_fraction(var_00);
			if(var_01 > 0)
			{
				var_02 = heliwind_smoothstep(0,1,var_01);
				self.heliwind_weight = var_02;
			}
			else
			{
				heliwind_fadeoff();
			}
		}
		else
		{
			heliwind_fadeoff();
		}

		wait(0.15);
	}
}

//Function Number: 15
heliwind_animate_tree()
{
	self useanimtree(#animtree);
	self setanim(level.anim_prop_models[self.model]["strong"],1,0.05,1);
	self setanim(level.anim_prop_models[self.model]["heli"],0,0.05,1);
	self clearanim(level.anim_prop_models[self.model]["still"],0);
	var_00 = 0.15;
	var_01 = 0;
	for(;;)
	{
		var_02 = self getanimweight(level.anim_prop_models[self.model]["heli"]);
		var_03 = self.heliwind_weight - var_02;
		var_04 = clamp(var_03,-1 * self.heliwind_max_delta,self.heliwind_max_delta);
		var_05 = var_02 + var_04;
		if(var_05 != var_01)
		{
			var_01 = var_05;
			self setanim(level.anim_prop_models[self.model]["strong"],1 - var_05,var_00,1);
			self setanim(level.anim_prop_models[self.model]["heli"],var_05,var_00,1);
			self setanim(level.anim_prop_models[self.model]["still"],0,0,1);
			wait(var_00);
			continue;
		}

		wait(0.5);
	}
}

//Function Number: 16
heliwind_init_spawn_tracker()
{
	level.anim_models_helis = [];
	var_00 = getentarray();
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.vehicletype))
		{
			if(var_02 maps\_vehicle::ishelicopter())
			{
				var_02 thread heliwind_track_heli_alive();
			}
		}
	}
}

//Function Number: 17
heliwind_track_heli_alive()
{
	if(isspawner(self))
	{
		self waittill("spawned",var_00);
	}
	else
	{
		var_00 = self;
	}

	level.anim_models_helis[level.anim_models_helis.size] = var_00;
	var_00 waittill("death",var_01);
	if(isdefined(var_01))
	{
		waittillframeend;
		if(isdefined(var_00.crashing) && var_00.crashing)
		{
			var_00 waittill("crash_done");
		}
	}

	level.anim_models_helis = common_scripts\utility::array_remove(level.anim_models_helis,var_00);
}