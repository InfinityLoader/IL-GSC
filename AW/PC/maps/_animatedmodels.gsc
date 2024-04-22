/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _animatedmodels.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 108 ms
 * Timestamp: 4/22/2024 2:20:02 AM
*******************************************************************/

//Function Number: 1
main()
{
	waittillframeend;
	init_wind_if_uninitialized();
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