/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_animatedmodels.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 2
 * Decompile Time: 28 ms
 * Timestamp: 10/27/2023 1:29:40 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	if(!isdefined(level.anim_prop_models))
	{
		level.anim_prop_models = [];
	}

	var_00 = getarraykeys(level.anim_prop_models);
	foreach(var_02 in var_00)
	{
		var_03 = getarraykeys(level.anim_prop_models[var_02]);
		foreach(var_05 in var_03)
		{
			precachempanim(level.anim_prop_models[var_02][var_05]);
		}
	}

	waittillframeend;
	level.init_animatedmodels = [];
	var_08 = getentarray("animated_model","targetname");
	common_scripts\utility::array_thread_amortized(var_08,::animatemodel,0.05);
	level.init_animatedmodels = undefined;
}

//Function Number: 2
animatemodel()
{
	if(isdefined(self.animation))
	{
		var_00 = self.animation;
	}
	else
	{
		var_01 = getarraykeys(level.anim_prop_models[self.model]);
		var_02 = var_01[randomint(var_01.size)];
		var_00 = level.anim_prop_models[self.model][var_02];
	}

	self scriptmodelplayanim(var_00);
	self entitywillneverchange();
}