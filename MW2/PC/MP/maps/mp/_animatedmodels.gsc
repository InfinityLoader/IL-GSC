/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_animatedmodels.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

main()
{
	if(!isdefined(level.anim_prop_models))
	{
		level.anim_prop_models = [];
	}

	model_keys = getarraykeys(level.anim_prop_models);
	foreach(model_key in model_keys)
	{
		anim_keys = getarraykeys(level.anim_prop_models[model_key]);
		foreach(anim_key in anim_keys)
		{
			precachempanim(level.anim_prop_models[model_key][anim_key]);
		}
	}

	waittillframeend;
	level.init_animatedmodels = [];
	animated_models = getentarray("animated_model", "targetname");
	common_scripts\utility::array_thread(animated_models, ::model_init);
	level.init_animatedmodels = undefined;
}

model_init()
{
	if(isdefined(self.animation))
	{
		animation = self.animation;
	}
	else
	{
		keys = getarraykeys(level.anim_prop_models[self.model]);
		animkey = keys[randomint(keys.size)];
		animation = level.anim_prop_models[self.model][animkey];
	}

	self scriptmodelplayanim(animation);
	self willneverchange();
}