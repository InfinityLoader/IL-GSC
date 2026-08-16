/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_destructible.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

init()
{
	level.destructiblespawnedentslimit = 50;
	level.destructiblespawnedents = [];
	level.currentcaralarms = 0;
	level.commonstarttime = gettime();
	if(!isdefined(level.func))
	{
		level.func = [];
	}

	destructibles_enabled = 1;
	if(destructibles_enabled)
	{
		find_destructibles();
	}

	deletables = getentarray("delete_on_load", "targetname");
	foreach(ent in deletables)
	{
		ent delete();
	}

	init_destroyed_count();
	init_destructible_frame_queue();
}

warn_about_old_destructible()
{
	wait 1;
	destructibles = getentarray("destructible", "targetname");
	if(destructibles.size != 0)
	{
		foreach(vehicle in destructibles)
		{
		}

		return;
	}
}

find_destructibles()
{
	vehicles = getentarray("destructible_vehicle", "targetname");
	foreach(vehicle in vehicles)
	{
		vehicle setup_destructibles();
	}

	destructible_toy = getentarray("destructible_toy", "targetname");
	foreach(toy in destructible_toy)
	{
		toy setup_destructibles();
	}
}

setup_destructibles(cached)
{
	if(!isdefined(cached))
	{
		cached = 0;
	}

	destuctableinfo = undefined;
	self.modeldummyon = 0;
	add_damage_owner_recorder();
	self.destuctableinfo = common_scripts\_destructible_types::maketype(self.destructible_type);
	if(self.destuctableinfo < 0)
	{
		return;
	}

	if(!cached)
	{
		precache_destructibles();
	}

	add_destructible_fx();
	if(isdefined(level.destructible_type[self.destuctableinfo].parts))
	{
		self.destructible_parts = [];
		for(i = 0;i < level.destructible_type[self.destuctableinfo].parts.size;i++)
		{
			self.destructible_parts[i] = spawnstruct();
			self.destructible_parts[i].v["currentState"] = 0;
			if(isdefined(level.destructible_type[self.destuctableinfo].parts[i][0].v["health"]))
			{
				self.destructible_parts[i].v["health"] = level.destructible_type[self.destuctableinfo].parts[i][0].v["health"];
			}

			if(isdefined(level.destructible_type[self.destuctableinfo].parts[i][0].v["random_dynamic_attachment_1"]))
			{
				randattachmentindex = randomint(level.destructible_type[self.destuctableinfo].parts[i][0].v["random_dynamic_attachment_1"].size);
				attachtag = level.destructible_type[self.destuctableinfo].parts[i][0].v["random_dynamic_attachment_tag"][randattachmentindex];
				attach_model_1 = level.destructible_type[self.destuctableinfo].parts[i][0].v["random_dynamic_attachment_1"][randattachmentindex];
				attach_model_2 = level.destructible_type[self.destuctableinfo].parts[i][0].v["random_dynamic_attachment_2"][randattachmentindex];
				cliptoremove = level.destructible_type[self.destuctableinfo].parts[i][0].v["clipToRemove"][randattachmentindex];
				thread do_random_dynamic_attachment(attachtag, attach_model_1, attach_model_2, cliptoremove);
			}

			if(i == 0)
			{
				continue;
			}

			modelname = level.destructible_type[self.destuctableinfo].parts[i][0].v["modelName"];
			tagname = level.destructible_type[self.destuctableinfo].parts[i][0].v["tagName"];
			for(stateindex = 1;isdefined(level.destructible_type[self.destuctableinfo].parts[i][stateindex]);stateindex++)
			{
				statetagname = level.destructible_type[self.destuctableinfo].parts[i][stateindex].v["tagName"];
				statemodelname = level.destructible_type[self.destuctableinfo].parts[i][stateindex].v["modelName"];
				if(isdefined(statetagname) && statetagname != tagname)
				{
					hideapart(statetagname);
					if(self.modeldummyon)
					{
						self.modeldummy hideapart(statetagname);
					}
				}
			}
		}
	}

	if(isdefined(self.target))
	{
		thread destructible_handles_collision_brushes();
	}

	if(self.code_classname != "script_vehicle")
	{
		self setcandamage(1);
	}

	if(common_scripts\utility::issp())
	{
		thread connectTraverses();
	}

	thread destructible_think();
}

destructible_create(type, tagname, health, validattackers, validdamagezone, validdamagecause)
{
	if(!isdefined(level.destructible_type))
	{
		level.destructible_type = [];
	}

	destructibleindex = level.destructible_type.size;
	destructibleindex = level.destructible_type.size;
	level.destructible_type[destructibleindex] = spawnstruct();
	level.destructible_type[destructibleindex].v["type"] = type;
	level.destructible_type[destructibleindex].parts = [];
	level.destructible_type[destructibleindex].parts[0][0] = spawnstruct();
	level.destructible_type[destructibleindex].parts[0][0].v["modelName"] = self.model;
	level.destructible_type[destructibleindex].parts[0][0].v["tagName"] = tagname;
	level.destructible_type[destructibleindex].parts[0][0].v["health"] = health;
	level.destructible_type[destructibleindex].parts[0][0].v["validAttackers"] = validattackers;
	level.destructible_type[destructibleindex].parts[0][0].v["validDamageZone"] = validdamagezone;
	level.destructible_type[destructibleindex].parts[0][0].v["validDamageCause"] = validdamagecause;
	level.destructible_type[destructibleindex].parts[0][0].v["godModeAllowed"] = 1;
	level.destructible_type[destructibleindex].parts[0][0].v["rotateTo"] = self.angles;
	level.destructible_type[destructibleindex].parts[0][0].v["vehicle_exclude_anim"] = 0;
}

destructible_part(tagname, modelname, health, validattackers, validdamagezone, validdamagecause, alsodamageparent, physicsonexplosion, grenadeimpactdeath, receivedamagefromparent)
{
	destructibleindex = level.destructible_type.size - 1;
	partindex = level.destructible_type[destructibleindex].parts.size;
	stateindex = 0;
	destructible_info(partindex, stateindex, tagname, modelname, health, validattackers, validdamagezone, validdamagecause, alsodamageparent, physicsonexplosion, grenadeimpactdeath, undefined, receivedamagefromparent);
}

destructible_state(tagname, modelname, health, validattackers, validdamagezone, validdamagecause, grenadeimpactdeath, splashrotation)
{
	destructibleindex = level.destructible_type.size - 1;
	partindex = level.destructible_type[destructibleindex].parts.size - 1;
	stateindex = level.destructible_type[destructibleindex].parts[partindex].size;
	if(!isdefined(tagname) && partindex == 0)
	{
		tagname = level.destructible_type[destructibleindex].parts[partindex][0].v["tagName"];
	}

	destructible_info(partindex, stateindex, tagname, modelname, health, validattackers, validdamagezone, validdamagecause, undefined, undefined, grenadeimpactdeath, splashrotation);
}

destructible_fx(tagname, fxname, usetagangles, damagetype, groupnum, fxcost)
{
	if(!isdefined(usetagangles))
	{
		usetagangles = 1;
	}

	if(!isdefined(groupnum))
	{
		groupnum = 0;
	}

	if(!isdefined(fxcost))
	{
		fxcost = 0;
	}

	destructibleindex = level.destructible_type.size - 1;
	partindex = level.destructible_type[destructibleindex].parts.size - 1;
	stateindex = level.destructible_type[destructibleindex].parts[partindex].size - 1;
	fx_size = 0;
	if(isdefined(level.destructible_type[destructibleindex].parts[partindex][stateindex].v["fx_filename"]))
	{
		if(isdefined(level.destructible_type[destructibleindex].parts[partindex][stateindex].v["fx_filename"][groupnum]))
		{
			fx_size = level.destructible_type[destructibleindex].parts[partindex][stateindex].v["fx_filename"][groupnum].size;
		}
	}

	if(isdefined(damagetype))
	{
		level.destructible_type[destructibleindex].parts[partindex][stateindex].v["fx_valid_damagetype"][groupnum][fx_size] = damagetype;
	}

	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["fx_filename"][groupnum][fx_size] = fxname;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["fx_tag"][groupnum][fx_size] = tagname;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["fx_useTagAngles"][groupnum][fx_size] = usetagangles;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["fx_cost"][groupnum][fx_size] = fxcost;
}

destructible_loopfx(tagname, fxname, looprate, fxcost)
{
	if(!isdefined(fxcost))
	{
		fxcost = 0;
	}

	destructibleindex = level.destructible_type.size - 1;
	partindex = level.destructible_type[destructibleindex].parts.size - 1;
	stateindex = level.destructible_type[destructibleindex].parts[partindex].size - 1;
	fx_size = 0;
	if(isdefined(level.destructible_type[destructibleindex].parts[partindex][stateindex].v["loopfx_filename"]))
	{
		fx_size = level.destructible_type[destructibleindex].parts[partindex][stateindex].v["loopfx_filename"].size;
	}

	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["loopfx_filename"][fx_size] = fxname;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["loopfx_tag"][fx_size] = tagname;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["loopfx_rate"][fx_size] = looprate;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["loopfx_cost"][fx_size] = fxcost;
}

destructible_healthdrain(amount, interval, badplaceradius, badplaceteam)
{
	destructibleindex = level.destructible_type.size - 1;
	partindex = level.destructible_type[destructibleindex].parts.size - 1;
	stateindex = level.destructible_type[destructibleindex].parts[partindex].size - 1;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["healthdrain_amount"] = amount;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["healthdrain_interval"] = interval;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["badplace_radius"] = badplaceradius;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["badplace_team"] = badplaceteam;
}

destructible_sound(soundalias, soundcause, groupnum)
{
	destructibleindex = level.destructible_type.size - 1;
	partindex = level.destructible_type[destructibleindex].parts.size - 1;
	stateindex = level.destructible_type[destructibleindex].parts[partindex].size - 1;
	if(!isdefined(groupnum))
	{
		groupnum = 0;
	}

	if(!isdefined(level.destructible_type[destructibleindex].parts[partindex][stateindex].v["sound"]))
	{
		level.destructible_type[destructibleindex].parts[partindex][stateindex].v["sound"] = [];
		level.destructible_type[destructibleindex].parts[partindex][stateindex].v["soundCause"] = [];
	}

	if(!isdefined(level.destructible_type[destructibleindex].parts[partindex][stateindex].v["sound"][groupnum]))
	{
		level.destructible_type[destructibleindex].parts[partindex][stateindex].v["sound"][groupnum] = [];
		level.destructible_type[destructibleindex].parts[partindex][stateindex].v["soundCause"][groupnum] = [];
	}

	index = level.destructible_type[destructibleindex].parts[partindex][stateindex].v["sound"][groupnum].size;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["sound"][groupnum][index] = soundalias;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["soundCause"][groupnum][index] = soundcause;
}

destructible_loopsound(soundalias, loopsoundcause)
{
	destructibleindex = level.destructible_type.size - 1;
	partindex = level.destructible_type[destructibleindex].parts.size - 1;
	stateindex = level.destructible_type[destructibleindex].parts[partindex].size - 1;
	if(!isdefined(level.destructible_type[destructibleindex].parts[partindex][stateindex].v["loopsound"]))
	{
		level.destructible_type[destructibleindex].parts[partindex][stateindex].v["loopsound"] = [];
		level.destructible_type[destructibleindex].parts[partindex][stateindex].v["loopsoundCause"] = [];
	}

	index = level.destructible_type[destructibleindex].parts[partindex][stateindex].v["loopsound"].size;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["loopsound"][index] = soundalias;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["loopsoundCause"][index] = loopsoundcause;
}

destructible_anim(animname, animtree, animtype, vehicle_exclude, groupnum, mpanim, maxstartdelay, animratemin, animratemax)
{
	if(!isdefined(vehicle_exclude))
	{
		vehicle_exclude = 0;
	}

	if(!isdefined(groupnum))
	{
		groupnum = 0;
	}

	array = [];
	array["anim"] = animname;
	array["animTree"] = animtree;
	array["animType"] = animtype;
	array["vehicle_exclude_anim"] = vehicle_exclude;
	array["groupNum"] = groupnum;
	array["mpAnim"] = mpanim;
	array["maxStartDelay"] = maxstartdelay;
	array["animRateMin"] = animratemin;
	array["animRateMax"] = animratemax;
	add_array_to_destructible("animation", array);
}

destructible_spotlight(tag)
{
	array = [];
	array["spotlight_tag"] = tag;
	array["spotlight_fx"] = "spotlight_fx";
	array["spotlight_brightness"] = 0.85;
	array["randomly_flip"] = 1;
	dvars = [];
	dvars["r_spotlightendradius"] = 1200;
	dvars["r_spotlightstartradius"] = 50;
	array["dvars"] = dvars;
	add_keypairs_to_destructible(array);
}

add_key_to_destructible(key, val)
{
	array = [];
	array[key] = val;
	add_keypairs_to_destructible(array);
}

add_keypairs_to_destructible(array)
{
	destructibleindex = level.destructible_type.size - 1;
	partindex = level.destructible_type[destructibleindex].parts.size - 1;
	stateindex = level.destructible_type[destructibleindex].parts[partindex].size - 1;
	foreach(key, val in array)
	{
		level.destructible_type[destructibleindex].parts[partindex][stateindex].v[key] = val;
	}
}

add_array_to_destructible(array_name, array)
{
	destructibleindex = level.destructible_type.size - 1;
	partindex = level.destructible_type[destructibleindex].parts.size - 1;
	stateindex = level.destructible_type[destructibleindex].parts[partindex].size - 1;
	v = level.destructible_type[destructibleindex].parts[partindex][stateindex].v;
	if(!isdefined(v[array_name]))
	{
		v[array_name] = [];
	}

	v[array_name][v[array_name].size] = array;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v = v;
}

destructible_car_alarm()
{
	destructibleindex = level.destructible_type.size - 1;
	partindex = level.destructible_type[destructibleindex].parts.size - 1;
	stateindex = level.destructible_type[destructibleindex].parts[partindex].size - 1;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["triggerCarAlarm"] = 1;
}

destructible_lights_out(range)
{
	if(!isdefined(range))
	{
		range = 256;
	}

	destructibleindex = level.destructible_type.size - 1;
	partindex = level.destructible_type[destructibleindex].parts.size - 1;
	stateindex = level.destructible_type[destructibleindex].parts[partindex].size - 1;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["break_nearby_lights"] = range;
}

random_dynamic_attachment(tagname, attachment_1, attachment_2, cliptoremove)
{
	if(!isdefined(attachment_2))
	{
		attachment_2 = "";
	}

	destructibleindex = level.destructible_type.size - 1;
	partindex = level.destructible_type[destructibleindex].parts.size - 1;
	stateindex = 0;
	if(!isdefined(level.destructible_type[destructibleindex].parts[partindex][stateindex].v["random_dynamic_attachment_1"]))
	{
		level.destructible_type[destructibleindex].parts[partindex][stateindex].v["random_dynamic_attachment_1"] = [];
		level.destructible_type[destructibleindex].parts[partindex][stateindex].v["random_dynamic_attachment_2"] = [];
		level.destructible_type[destructibleindex].parts[partindex][stateindex].v["random_dynamic_attachment_tag"] = [];
	}

	index = level.destructible_type[destructibleindex].parts[partindex][stateindex].v["random_dynamic_attachment_1"].size;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["random_dynamic_attachment_1"][index] = attachment_1;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["random_dynamic_attachment_2"][index] = attachment_2;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["random_dynamic_attachment_tag"][index] = tagname;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["clipToRemove"][index] = cliptoremove;
}

destructible_physics(phystagname, physvelocity)
{
	destructibleindex = level.destructible_type.size - 1;
	partindex = level.destructible_type[destructibleindex].parts.size - 1;
	stateindex = level.destructible_type[destructibleindex].parts[partindex].size - 1;
	if(!isdefined(level.destructible_type[destructibleindex].parts[partindex][stateindex].v["physics"]))
	{
		level.destructible_type[destructibleindex].parts[partindex][stateindex].v["physics"] = [];
		level.destructible_type[destructibleindex].parts[partindex][stateindex].v["physics_tagName"] = [];
		level.destructible_type[destructibleindex].parts[partindex][stateindex].v["physics_velocity"] = [];
	}

	index = level.destructible_type[destructibleindex].parts[partindex][stateindex].v["physics"].size;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["physics"][index] = 1;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["physics_tagName"][index] = phystagname;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["physics_velocity"][index] = physvelocity;
}

destructible_splash_damage_scaler(damage_multiplier)
{
	destructibleindex = level.destructible_type.size - 1;
	partindex = level.destructible_type[destructibleindex].parts.size - 1;
	stateindex = level.destructible_type[destructibleindex].parts[partindex].size - 1;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["splash_damage_scaler"] = damage_multiplier;
}

destructible_explode(force_min, force_max, rangesp, rangemp, mindamage, maxdamage, continuedamage, originoffset, earthquakescale, earthquakeradius)
{
	destructibleindex = level.destructible_type.size - 1;
	partindex = level.destructible_type[destructibleindex].parts.size - 1;
	stateindex = level.destructible_type[destructibleindex].parts[partindex].size - 1;
	if(common_scripts\utility::issp())
	{
		level.destructible_type[destructibleindex].parts[partindex][stateindex].v["explode_range"] = rangesp;
	}
	else
	{
		level.destructible_type[destructibleindex].parts[partindex][stateindex].v["explode_range"] = rangemp;
	}

	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["explode"] = 1;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["explode_force_min"] = force_min;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["explode_force_max"] = force_max;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["explode_mindamage"] = mindamage;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["explode_maxdamage"] = maxdamage;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["continueDamage"] = continuedamage;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["originOffset"] = originoffset;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["earthQuakeScale"] = earthquakescale;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["earthQuakeRadius"] = earthquakeradius;
}

destructible_info(partindex, stateindex, tagname, modelname, health, validattackers, validdamagezone, validdamagecause, alsodamageparent, physicsonexplosion, grenadeimpactdeath, splashrotation, receivedamagefromparent)
{
	if(isdefined(modelname))
	{
		modelname = tolower(modelname);
	}

	destructibleindex = level.destructible_type.size - 1;
	level.destructible_type[destructibleindex].parts[partindex][stateindex] = spawnstruct();
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["modelName"] = modelname;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["tagName"] = tagname;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["health"] = health;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["validAttackers"] = validattackers;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["validDamageZone"] = validdamagezone;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["validDamageCause"] = validdamagecause;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["alsoDamageParent"] = alsodamageparent;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["physicsOnExplosion"] = physicsonexplosion;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["grenadeImpactDeath"] = grenadeimpactdeath;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["godModeAllowed"] = 0;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["splashRotation"] = splashrotation;
	level.destructible_type[destructibleindex].parts[partindex][stateindex].v["receiveDamageFromParent"] = receivedamagefromparent;
}

precache_destructibles()
{
	if(!isdefined(level.destructible_type[self.destuctableinfo].parts))
	{
		return;
	}

	for(i = 0;i < level.destructible_type[self.destuctableinfo].parts.size;i++)
	{
		for(j = 0;j < level.destructible_type[self.destuctableinfo].parts[i].size;j++)
		{
			if(level.destructible_type[self.destuctableinfo].parts[i].size <= j)
			{
				continue;
			}

			if(isdefined(level.destructible_type[self.destuctableinfo].parts[i][j].v["modelName"]))
			{
				precachemodel(level.destructible_type[self.destuctableinfo].parts[i][j].v["modelName"]);
			}

			if(isdefined(level.destructible_type[self.destuctableinfo].parts[i][j].v["animation"]))
			{
				animgroups = level.destructible_type[self.destuctableinfo].parts[i][j].v["animation"];
				foreach(group in animgroups)
				{
					if(isdefined(group["mpAnim"]))
					{
						common_scripts\utility::noself_func("precacheMpAnim", group["mpAnim"]);
					}
				}
			}

			if(isdefined(level.destructible_type[self.destuctableinfo].parts[i][j].v["random_dynamic_attachment_1"]))
			{
				foreach(model in level.destructible_type[self.destuctableinfo].parts[i][j].v["random_dynamic_attachment_1"])
				{
					if(isdefined(model) && model != "")
					{
						precachemodel(model);
						precachemodel(model + "_destroy");
					}
				}

				foreach(model in level.destructible_type[self.destuctableinfo].parts[i][j].v["random_dynamic_attachment_2"])
				{
					if(isdefined(model) && model != "")
					{
						precachemodel(model);
						precachemodel(model + "_destroy");
					}
				}
			}
		}
	}
}

add_destructible_fx()
{
	if(!isdefined(level.destructible_type[self.destuctableinfo].parts))
	{
		return;
	}

	for(i = 0;i < level.destructible_type[self.destuctableinfo].parts.size;i++)
	{
		for(j = 0;j < level.destructible_type[self.destuctableinfo].parts[i].size;j++)
		{
			if(level.destructible_type[self.destuctableinfo].parts[i].size <= j)
			{
				continue;
			}

			part = level.destructible_type[self.destuctableinfo].parts[i][j];
			if(isdefined(part.v["fx_filename"]))
			{
				for(g = 0;g < part.v["fx_filename"].size;g++)
				{
					fx_filenames = part.v["fx_filename"][g];
					if(isdefined(fx_filenames))
					{
						if(isdefined(part.v["fx"]) && isdefined(part.v["fx"][g]) && part.v["fx"][g].size == fx_filenames.size)
						{
							continue;
						}

						foreach(idx, fx_filename in fx_filenames)
						{
							level.destructible_type[self.destuctableinfo].parts[i][j].v["fx"][g][idx] = common_scripts\utility::_loadfx(fx_filename);
						}
					}
				}
			}

			loopfx_filenames = level.destructible_type[self.destuctableinfo].parts[i][j].v["loopfx_filename"];
			if(isdefined(loopfx_filenames))
			{
				if(isdefined(part.v["loopfx"]) && part.v["loopfx"].size == loopfx_filenames.size)
				{
					continue;
				}

				foreach(idx, loopfx_filename in loopfx_filenames)
				{
					level.destructible_type[self.destuctableinfo].parts[i][j].v["loopfx"][idx] = common_scripts\utility::_loadfx(loopfx_filename);
				}
			}
		}
	}
}

canDamageDestructible(testdestructible)
{
	foreach(destructible in self.destructibles)
	{
		if(destructible == testdestructible)
		{
			return 1;
		}
	}

	return 0;
}

destructible_think()
{
	damage = 0;
	modelname = self.model;
	tagname = undefined;
	point = self.origin;
	direction_vec = undefined;
	attacker = undefined;
	damagetype = undefined;
	destructible_update_part(damage, modelname, tagname, point, direction_vec, attacker, damagetype);
	self endon("stop_taking_damage");
	for(;;)
	{
		damage = undefined;
		attacker = undefined;
		direction_vec = undefined;
		point = undefined;
		type = undefined;
		modelname = undefined;
		tagname = undefined;
		partname = undefined;
		dflags = undefined;
		self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, dflags);
		if(!isdefined(damage))
		{
			continue;
		}

		if(isdefined(attacker) && isdefined(attacker.type) && attacker.type == "soft_landing" && !attacker canDamageDestructible(self))
		{
			continue;
		}

		if(common_scripts\utility::issp())
		{
			damage = damage * 0.5;
		}
		else
		{
			damage = damage * 1;
		}

		if(damage <= 0)
		{
			continue;
		}

		if(isdefined(attacker) && isplayer(attacker))
		{
			self.damageowner = attacker;
		}

		type = getDamageType(type);
		if(is_shotgun_damage(attacker, type))
		{
			if(common_scripts\utility::issp())
			{
				damage = damage * 8;
			}
			else
			{
				damage = damage * 4;
			}
		}

		if(!isdefined(modelname) || modelname == "")
		{
			modelname = self.model;
		}

		if(isdefined(tagname) && tagname == "")
		{
			if(isdefined(partname) && partname != "" && partname != "tag_body" && partname != "body_animate_jnt")
			{
				tagname = partname;
			}
			else
			{
				tagname = undefined;
			}

			basemodeltag = level.destructible_type[self.destuctableinfo].parts[0][0].v["tagName"];
			if(isdefined(basemodeltag) && isdefined(partname) && basemodeltag == partname)
			{
				tagname = undefined;
			}
		}

		if(type == "splash")
		{
			if(isdefined(level.destructible_type[self.destuctableinfo].parts[0][0].v["splash_damage_scaler"]))
			{
				damage = damage * level.destructible_type[self.destuctableinfo].parts[0][0].v["splash_damage_scaler"];
			}
			else if(common_scripts\utility::issp())
			{
				damage = damage * 9;
			}
			else
			{
				damage = damage * 13;
			}

			destructible_splash_damage(int(damage), point, direction_vec, attacker, type);
			continue;
		}

		thread destructible_update_part(int(damage), modelname, tagname, point, direction_vec, attacker, type);
	}
}

is_shotgun_damage(attacker, type)
{
	if(type != "bullet")
	{
		return 0;
	}

	if(!isdefined(attacker))
	{
		return 0;
	}

	currentweapon = undefined;
	if(isplayer(attacker))
	{
		currentweapon = attacker getcurrentweapon();
	}

	if(!isdefined(currentweapon))
	{
		return 0;
	}

	class = weaponclass(currentweapon);
	if(isdefined(class) && class == "spread")
	{
		return 1;
	}

	return 0;
}

getPartAndStateIndex(modelname, tagname)
{
	info = spawnstruct();
	info.v = [];
	partindex = -1;
	stateindex = -1;
	if(tolower(modelname) == tolower(self.model) && !isdefined(tagname))
	{
		modelname = self.model;
		tagname = undefined;
		partindex = 0;
		stateindex = 0;
	}

	for(i = 0;i < level.destructible_type[self.destuctableinfo].parts.size;i++)
	{
		stateindex = self.destructible_parts[i].v["currentState"];
		if(level.destructible_type[self.destuctableinfo].parts[i].size <= stateindex)
		{
			continue;
		}

		if(!isdefined(tagname))
		{
			continue;
		}

		if(isdefined(level.destructible_type[self.destuctableinfo].parts[i][stateindex].v["tagName"]))
		{
			parttagname = level.destructible_type[self.destuctableinfo].parts[i][stateindex].v["tagName"];
			if(parttagname == tagname)
			{
				partindex = i;
				break;
			}
		}
	}

	info.v["stateIndex"] = stateindex;
	info.v["partIndex"] = partindex;
	return info;
}

destructible_update_part(damage, modelname, tagname, point, direction_vec, attacker, damagetype, partinfo)
{
	if(!isdefined(self.destructible_parts))
	{
		return;
	}

	if(self.destructible_parts.size == 0)
	{
		return;
	}

	info = getPartAndStateIndex(modelname, tagname);
	stateindex = info.v["stateIndex"];
	partindex = info.v["partIndex"];
	if(partindex < 0)
	{
		return;
	}

	state_before = stateindex;
	updatehealthvalue = 0;
	delaymodelswap = 0;
	for(;;)
	{
		stateindex = self.destructible_parts[partindex].v["currentState"];
		if(!isdefined(level.destructible_type[self.destuctableinfo].parts[partindex][stateindex]))
		{
			break;
		}

		if(isdefined(level.destructible_type[self.destuctableinfo].parts[partindex][0].v["alsoDamageParent"]))
		{
			if(getDamageType(damagetype) != "splash")
			{
				ratio = level.destructible_type[self.destuctableinfo].parts[partindex][0].v["alsoDamageParent"];
				parentdamage = int(damage * ratio);
				thread notifyDamageAfterFrame(parentdamage, attacker, direction_vec, point, damagetype, "", "");
			}
		}

		if(getDamageType(damagetype) != "splash")
		{
			foreach(part in level.destructible_type[self.destuctableinfo].parts)
			{
				if(!isdefined(part[0].v["receiveDamageFromParent"]))
				{
					continue;
				}

				if(!isdefined(part[0].v["tagName"]))
				{
					continue;
				}

				ratio = part[0].v["receiveDamageFromParent"];
				childdamage = int(damage * ratio);
				childtagname = part[0].v["tagName"];
				thread notifyDamageAfterFrame(childdamage, attacker, direction_vec, point, damagetype, "", childtagname);
			}
		}

		if(!isdefined(level.destructible_type[self.destuctableinfo].parts[partindex][stateindex].v["health"]))
		{
			break;
		}

		if(!isdefined(self.destructible_parts[partindex].v["health"]))
		{
			break;
		}

		if(updatehealthvalue)
		{
			self.destructible_parts[partindex].v["health"] = level.destructible_type[self.destuctableinfo].parts[partindex][stateindex].v["health"];
		}

		updatehealthvalue = 0;
		if(isdefined(level.destructible_type[self.destuctableinfo].parts[partindex][stateindex].v["grenadeImpactDeath"]) && damagetype == "impact")
		{
			damage = 100000000;
		}

		savedhealth = self.destructible_parts[partindex].v["health"];
		validattacker = isAttackerValid(partindex, stateindex, attacker);
		if(validattacker)
		{
			validdamagecause = isValidDamageCause(partindex, stateindex, damagetype);
			if(validdamagecause)
			{
				if(isdefined(attacker))
				{
					if(isplayer(attacker))
					{
						self.player_damage = self.player_damage + damage;
					}
					else if(attacker != self)
					{
						self.non_player_damage = self.non_player_damage + damage;
					}
				}

				if(isdefined(damagetype))
				{
					if(damagetype == "melee" || damagetype == "impact")
					{
						damage = 100000;
					}
				}

				self.destructible_parts[partindex].v["health"] = self.destructible_parts[partindex].v["health"] - damage;
			}
		}

		if(self.destructible_parts[partindex].v["health"] > 0)
		{
			return;
		}

		if(isdefined(partinfo))
		{
			partinfo.v["fxcost"] = get_part_FX_cost_for_action_state(partindex, self.destructible_parts[partindex].v["currentState"]);
			add_destructible_to_frame_queue(self, partinfo, damage);
			self.waiting_for_queue = 1;
			self waittill("queue_processed", success);
			self.waiting_for_queue = undefined;
			if(!success)
			{
				self.destructible_parts[partindex].v["health"] = savedhealth;
				return;
			}
		}

		damage = int(abs(self.destructible_parts[partindex].v["health"]));
		if(damage < 0)
		{
			return;
		}

		self.destructible_parts[partindex].v["currentState"]++;
		stateindex = self.destructible_parts[partindex].v["currentState"];
		actionstateindex = stateindex - 1;
		action_v = undefined;
		if(isdefined(level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex]))
		{
			action_v = level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v;
		}

		state_v = undefined;
		if(isdefined(level.destructible_type[self.destuctableinfo].parts[partindex][stateindex]))
		{
			state_v = level.destructible_type[self.destuctableinfo].parts[partindex][stateindex].v;
		}

		if(!isdefined(level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex]))
		{
			return;
		}

		if(isdefined(level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["explode"]))
		{
			self.exploding = 1;
		}

		if(isdefined(self.loopingsoundstopnotifies) && isdefined(self.loopingsoundstopnotifies[toString(partindex)]))
		{
			for(i = 0;i < self.loopingsoundstopnotifies[toString(partindex)].size;i++)
			{
				self notify(self.loopingsoundstopnotifies[toString(partindex)][i]);
				if(common_scripts\utility::issp() && self.modeldummyon)
				{
					self.modeldummy notify(self.loopingsoundstopnotifies[toString(partindex)][i]);
				}
			}

			self.loopingsoundstopnotifies[toString(partindex)] = undefined;
		}

		if(isdefined(action_v["break_nearby_lights"]))
		{
			destructible_get_my_breakable_light(action_v["break_nearby_lights"]);
		}

		if(isdefined(level.destructible_type[self.destuctableinfo].parts[partindex][stateindex]))
		{
			if(partindex == 0)
			{
				newmodel = state_v["modelName"];
				if(isdefined(newmodel) && newmodel != self.model)
				{
					self setmodel(newmodel);
					if(common_scripts\utility::issp() && self.modeldummyon)
					{
						self.modeldummy setmodel(newmodel);
					}

					destructible_splash_rotatation(state_v);
				}
			}
			else
			{
				hideapart(tagname);
				if(common_scripts\utility::issp() && self.modeldummyon)
				{
					self.modeldummy hideapart(tagname);
				}

				tagname = state_v["tagName"];
				if(isdefined(tagname))
				{
					showapart(tagname);
					if(common_scripts\utility::issp() && self.modeldummyon)
					{
						self.modeldummy showapart(tagname);
					}
				}
			}
		}

		emodel = get_dummy();
		if(isdefined(self.exploding))
		{
			clear_anims(emodel);
		}

		groupnumber = destructible_animation_think(action_v, emodel, damagetype, partindex);
		groupnumber = destructible_fx_think(action_v, emodel, damagetype, partindex, groupnumber);
		groupnumber = destructible_sound_think(action_v, emodel, damagetype, groupnumber);
		if(isdefined(level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["loopfx"]))
		{
			loopfx_size = level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["loopfx_filename"].size;
			if(loopfx_size > 0)
			{
				self notify("FX_State_Change" + partindex);
			}

			for(idx = 0;idx < loopfx_size;idx++)
			{
				loopfx = level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["loopfx"][idx];
				loopfx_tag = level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["loopfx_tag"][idx];
				looprate = level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["loopfx_rate"][idx];
				thread loopfx_onTag(loopfx, loopfx_tag, looprate, partindex);
			}
		}

		if(isdefined(level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["loopsound"]))
		{
			for(i = 0;i < level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["loopsound"].size;i++)
			{
				validsoundcause = isValidSoundCause("loopsoundCause", action_v, i, damagetype);
				if(validsoundcause)
				{
					loopsoundalias = level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["loopsound"][i];
					loopsoundtagname = level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["tagName"];
					thread play_loop_sound_on_destructible(loopsoundalias, loopsoundtagname);
					if(!isdefined(self.loopingsoundstopnotifies))
					{
						self.loopingsoundstopnotifies = [];
					}

					if(!isdefined(self.loopingsoundstopnotifies[toString(partindex)]))
					{
						self.loopingsoundstopnotifies[toString(partindex)] = [];
					}

					size = self.loopingsoundstopnotifies[toString(partindex)].size;
					self.loopingsoundstopnotifies[toString(partindex)][size] = "stop sound" + loopsoundalias;
				}
			}
		}

		if(isdefined(level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["triggerCarAlarm"]))
		{
			thread do_car_alarm();
		}

		if(isdefined(level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["break_nearby_lights"]))
		{
			thread break_nearest_light();
		}

		if(isdefined(level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["healthdrain_amount"]))
		{
			self notify("Health_Drain_State_Change" + partindex);
			healthdrain_amount = level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["healthdrain_amount"];
			healthdrain_interval = level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["healthdrain_interval"];
			healthdrain_modelname = level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["modelName"];
			healthdrain_tagname = level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["tagName"];
			badplaceradius = level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["badplace_radius"];
			badplaceteam = level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["badplace_team"];
			if(healthdrain_amount > 0)
			{
				thread health_drain(healthdrain_amount, healthdrain_interval, partindex, healthdrain_modelname, healthdrain_tagname, badplaceradius, badplaceteam);
			}
		}

		if(isdefined(level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["explode"]))
		{
			delaymodelswap = 1;
			force_min = level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["explode_force_min"];
			force_max = level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["explode_force_max"];
			range = level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["explode_range"];
			mindamage = level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["explode_mindamage"];
			maxdamage = level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["explode_maxdamage"];
			continuedamage = level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["continueDamage"];
			originoffset = level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["originOffset"];
			earthquakescale = level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["earthQuakeScale"];
			earthquakeradius = level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["earthQuakeRadius"];
			if(isdefined(attacker) && attacker != self)
			{
				self.attacker = attacker;
				if(self.code_classname == "script_vehicle")
				{
					self.damage_type = damagetype;
				}
			}

			thread explode(partindex, force_min, force_max, range, mindamage, maxdamage, continuedamage, originoffset, earthquakescale, earthquakeradius, attacker);
		}

		phystagorigin = undefined;
		if(isdefined(level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["physics"]))
		{
			for(i = 0;i < level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["physics"].size;i++)
			{
				phystagorigin = undefined;
				phystagname = level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["physics_tagName"][i];
				physvelocity = level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v["physics_velocity"][i];
				initial_velocity = undefined;
				if(isdefined(physvelocity))
				{
					phystagangles = undefined;
					if(isdefined(phystagname))
					{
						phystagangles = self gettagangles(phystagname);
					}
					else if(isdefined(tagname))
					{
						phystagangles = self gettagangles(tagname);
					}

					phystagorigin = undefined;
					if(isdefined(phystagname))
					{
						phystagorigin = self gettagorigin(phystagname);
					}
					else if(isdefined(tagname))
					{
						phystagorigin = self gettagorigin(tagname);
					}

					phys_x = physvelocity[0] - 5 + randomfloat(10);
					phys_y = physvelocity[1] - 5 + randomfloat(10);
					phys_z = physvelocity[2] - 5 + randomfloat(10);
					forward = anglestoforward(phystagangles) * phys_x * randomfloatrange(80, 110);
					right = anglestoright(phystagangles) * phys_y * randomfloatrange(80, 110);
					up = anglestoup(phystagangles) * phys_z * randomfloatrange(80, 110);
					initial_velocity = forward + right + up;
				}
				else
				{
					initial_velocity = point;
					impactdir = (0,0,0);
					if(isdefined(attacker))
					{
						impactdir = attacker.origin;
						initial_velocity = vectornormalize(point - impactdir);
						initial_velocity = common_scripts\utility::vector_multiply(initial_velocity, 200);
					}
				}

				if(isdefined(phystagname))
				{
					physpartindex = undefined;
					for(j = 0;j < level.destructible_type[self.destuctableinfo].parts.size;j++)
					{
						if(!isdefined(level.destructible_type[self.destuctableinfo].parts[j][0].v["tagName"]))
						{
							continue;
						}

						if(level.destructible_type[self.destuctableinfo].parts[j][0].v["tagName"] != phystagname)
						{
							continue;
						}

						physpartindex = j;
						break;
					}

					if(isdefined(phystagorigin))
					{
						thread physics_launch(physpartindex, 0, phystagorigin, initial_velocity);
					}
					else
					{
						thread physics_launch(physpartindex, 0, point, initial_velocity);
					}

					continue;
				}

				if(isdefined(phystagorigin))
				{
					thread physics_launch(partindex, actionstateindex, phystagorigin, initial_velocity);
				}
				else
				{
					thread physics_launch(partindex, actionstateindex, point, initial_velocity);
				}

				return;
			}
		}

		updatehealthvalue = 1;
	}
}

destructible_splash_rotatation(v)
{
	model_rotation = v["splashRotation"];
	model_rotate_to = v["rotateTo"];
	if(!isdefined(model_rotate_to))
	{
		return;
	}

	if(!isdefined(model_rotation))
	{
		return;
	}

	if(!model_rotation)
	{
		return;
	}

	self.angles = (self.angles[0],model_rotate_to[1],self.angles[2]);
}

damage_not(damagetype)
{
	toks = strtok(damagetype, " ");
	damages_tok = strtok("splash melee bullet splash impact unknown", " ");
	new_string = "";
	foreach(tok in toks)
	{
		damages_tok = common_scripts\utility::array_remove(damages_tok, tok);
	}

	foreach(damages in damages_tok)
	{
		new_string = new_string + damages + " ";
	}

	return new_string;
}

destructible_splash_damage(damage, point, direction_vec, attacker, damagetype)
{
	if(damage <= 0)
	{
		return;
	}

	if(isdefined(self.exploded))
	{
		return;
	}

	if(!isdefined(level.destructible_type[self.destuctableinfo].parts))
	{
		return;
	}

	damagedparts = getAllActiveParts(direction_vec);
	if(damagedparts.size <= 0)
	{
		return;
	}

	damagedparts = setDistanceOnParts(damagedparts, point);
	closestpartdist = getLowestPartDistance(damagedparts);
	foreach(part in damagedparts)
	{
		distancemod = part.v["distance"] * 1.4;
		damageamount = damage - distancemod - closestpartdist;
		if(damageamount <= 0)
		{
			continue;
		}

		if(isdefined(self.exploded))
		{
			continue;
		}

		thread destructible_update_part(damageamount, part.v["modelName"], part.v["tagName"], point, direction_vec, attacker, damagetype, part);
	}
}

getAllActiveParts(direction_vec)
{
	activeparts = [];
	if(!isdefined(level.destructible_type[self.destuctableinfo].parts))
	{
		return activeparts;
	}

	for(i = 0;i < level.destructible_type[self.destuctableinfo].parts.size;i++)
	{
		partindex = i;
		currentstate = self.destructible_parts[partindex].v["currentState"];
		for(j = 0;j < level.destructible_type[self.destuctableinfo].parts[partindex].size;j++)
		{
			splash_rotation = level.destructible_type[self.destuctableinfo].parts[partindex][j].v["splashRotation"];
			if(isdefined(splash_rotation) && splash_rotation)
			{
				rotate_to_angle = vectortoangles(direction_vec);
				rotate_to_angle_y = rotate_to_angle[1] - 90;
				level.destructible_type[self.destuctableinfo].parts[partindex][j].v["rotateTo"] = (0,rotate_to_angle_y,0);
			}
		}

		if(!isdefined(level.destructible_type[self.destuctableinfo].parts[partindex][currentstate]))
		{
			continue;
		}

		tagname = level.destructible_type[self.destuctableinfo].parts[partindex][currentstate].v["tagName"];
		if(!isdefined(tagname))
		{
			tagname = "";
		}

		if(tagname == "")
		{
			continue;
		}

		modelname = level.destructible_type[self.destuctableinfo].parts[partindex][currentstate].v["modelName"];
		if(!isdefined(modelname))
		{
			modelname = "";
		}

		activepartindex = activeparts.size;
		activeparts[activepartindex] = spawnstruct();
		activeparts[activepartindex].v["modelName"] = modelname;
		activeparts[activepartindex].v["tagName"] = tagname;
	}

	return activeparts;
}

setDistanceOnParts(partlist, point)
{
	for(i = 0;i < partlist.size;i++)
	{
		d = distance(point, self gettagorigin(partlist[i].v["tagName"]));
		partlist[i].v["distance"] = d;
	}

	return partlist;
}

getLowestPartDistance(partlist)
{
	closestdist = undefined;
	foreach(part in partlist)
	{
		d = part.v["distance"];
		if(!isdefined(closestdist))
		{
			closestdist = d;
		}

		if(d < closestdist)
		{
			closestdist = d;
		}
	}

	return closestdist;
}

isValidSoundCause(soundcausevar, action_v, soundindex, damagetype, groupnum)
{
	if(isdefined(groupnum))
	{
		soundcause = action_v[soundcausevar][groupnum][soundindex];
	}
	else
	{
		soundcause = action_v[soundcausevar][soundindex];
	}

	if(!isdefined(soundcause))
	{
		return 1;
	}

	if(soundcause == damagetype)
	{
		return 1;
	}

	return 0;
}

isAttackerValid(partindex, stateindex, attacker)
{
	if(isdefined(self.forceexploding))
	{
		return 1;
	}

	if(isdefined(level.destructible_type[self.destuctableinfo].parts[partindex][stateindex].v["explode"]))
	{
		if(isdefined(self.dontallowexplode))
		{
			return 0;
		}
	}

	if(!isdefined(attacker))
	{
		return 1;
	}

	if(attacker == self)
	{
		return 1;
	}

	stype = level.destructible_type[self.destuctableinfo].parts[partindex][stateindex].v["validAttackers"];
	if(!isdefined(stype))
	{
		return 1;
	}

	if(stype == "no_player")
	{
		if(!isplayer(attacker))
		{
			return 1;
		}

		if(!isdefined(attacker.damageisfromplayer))
		{
			return 1;
		}

		if(attacker.damageisfromplayer == 0)
		{
			return 1;
		}
	}
	else if(stype == "player_only")
	{
		if(isplayer(attacker))
		{
			return 1;
		}

		if(isdefined(attacker.damageisfromplayer) && attacker.damageisfromplayer)
		{
			return 1;
		}
	}
	else if(stype == "no_ai" && isdefined(level.isaifunc))
	{
		if(![[ level.isaifunc ]](attacker))
		{
			return 1;
		}
	}
	else if(stype == "ai_only" && isdefined(level.isaifunc))
	{
		if([[ level.isaifunc ]](attacker))
		{
			return 1;
		}
	}
	else
	{
	}

	return 0;
}

isValidDamageCause(partindex, stateindex, damagetype)
{
	if(!isdefined(damagetype))
	{
		return 1;
	}

	godmodeallowed = level.destructible_type[self.destuctableinfo].parts[partindex][stateindex].v["godModeAllowed"];
	if(godmodeallowed && (isdefined(self.godmode) && self.godmode) || isdefined(self.script_bulletshield) && self.script_bulletshield && damagetype == "bullet")
	{
		return 0;
	}

	validtype = level.destructible_type[self.destuctableinfo].parts[partindex][stateindex].v["validDamageCause"];
	if(!isdefined(validtype))
	{
		return 1;
	}

	if(validtype == "splash" && damagetype != "splash")
	{
		return 0;
	}

	if((validtype == "no_melee" && damagetype == "melee") || damagetype == "impact")
	{
		return 0;
	}

	return 1;
}

getDamageType(type)
{
	if(!isdefined(type))
	{
		return "unknown";
	}

	type = tolower(type);
	switch(type)
	{
		case "mod_crush":
		case "mod_melee":
		case "melee":
			return "melee";

		case "mod_rifle_bullet":
		case "mod_pistol_bullet":
		case "bullet":
			return "bullet";

		case "mod_projectile_splash":
		case "mod_projectile":
		case "mod_grenade_splash":
		case "mod_grenade":
		case "mod_explosive":
		case "splash":
			return "splash";

		case "mod_impact":
			return "impact";

		case "unknown":
			return "unknown";

		default:
			return "unknown";
	}
}

damage_mirror(parent, modelname, tagname)
{
	self notify("stop_damage_mirror");
	self endon("stop_damage_mirror");
	parent endon("stop_taking_damage");
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage", damage, attacker, direction_vec, point, type);
		parent notify("damage", damage, attacker, direction_vec, point, type, modelname, tagname);
		damage = undefined;
		attacker = undefined;
		direction_vec = undefined;
		point = undefined;
		type = undefined;
	}
}

add_damage_owner_recorder()
{
	self.player_damage = 0;
	self.non_player_damage = 0;
	self.car_damage_owner_recorder = 1;
}

loopfx_onTag(loopfx, loopfx_tag, looprate, partindex)
{
	self endon("FX_State_Change" + partindex);
	self endon("delete_destructible");
	level endon("putout_fires");
	while(isdefined(self))
	{
		emodel = get_dummy();
		playfxontag(loopfx, emodel, loopfx_tag);
		wait looprate;
	}
}

health_drain(amount, interval, partindex, modelname, tagname, badplaceradius, badplaceteam)
{
	self endon("Health_Drain_State_Change" + partindex);
	level endon("putout_fires");
	self endon("destroyed");
	if(isdefined(badplaceradius) && isdefined(level.destructible_badplace_radius_multiplier))
	{
		badplaceradius = badplaceradius * level.destructible_badplace_radius_multiplier;
	}

	if(isdefined(amount) && isdefined(level.destructible_health_drain_amount_multiplier))
	{
		amount = amount * level.destructible_health_drain_amount_multiplier;
	}

	wait interval;
	self.healthdrain = 1;
	uniquename = undefined;
	if(isdefined(level.disable_destructible_bad_places) && level.disable_destructible_bad_places)
	{
		badplaceradius = undefined;
	}

	if(isdefined(badplaceradius) && isdefined(badplaceteam) && common_scripts\utility::issp())
	{
		uniquename = "" + gettime();
		if(!isdefined(self.disablebadplace))
		{
			if(isdefined(self.script_radius))
			{
				badplaceradius = self.script_radius;
			}

			if(badplaceteam == "both")
			{
				[[ level.badplace_cylinder_func ]](uniquename, 0, self.origin, badplaceradius, 128, "allies", "bad_guys");
			}
			else
			{
				[[ level.badplace_cylinder_func ]](uniquename, 0, self.origin, badplaceradius, 128, badplaceteam);
			}

			thread badplace_remove(uniquename);
		}
	}

	while(isdefined(self) && self.destructible_parts[partindex].v["health"] > 0)
	{
		self notify("damage", amount, self, (0,0,0), (0,0,0), "MOD_UNKNOWN", modelname, tagname);
		wait interval;
	}

	self notify("remove_badplace");
}

badplace_remove(uniquename)
{
	common_scripts\utility::waittill_any("destroyed", "remove_badplace");
	[[ level.badplace_delete_func ]](uniquename);
}

physics_launch(partindex, stateindex, point, initial_velocity)
{
	modelname = level.destructible_type[self.destuctableinfo].parts[partindex][stateindex].v["modelName"];
	tagname = level.destructible_type[self.destuctableinfo].parts[partindex][stateindex].v["tagName"];
	hideapart(tagname);
	if(level.destructiblespawnedents.size >= level.destructiblespawnedentslimit)
	{
		physics_object_remove(level.destructiblespawnedents[0]);
	}

	physicsobject = spawn("script_model", self gettagorigin(tagname));
	physicsobject.angles = self gettagangles(tagname);
	physicsobject setmodel(modelname);
	level.destructiblespawnedents[level.destructiblespawnedents.size] = physicsobject;
	physicsobject physicslaunchclient(point, initial_velocity);
}

physics_object_remove(ent)
{
	newarray = [];
	for(i = 0;i < level.destructiblespawnedents.size;i++)
	{
		if(level.destructiblespawnedents[i] == ent)
		{
			continue;
		}

		newarray[newarray.size] = level.destructiblespawnedents[i];
	}

	level.destructiblespawnedents = newarray;
	if(isdefined(ent))
	{
		ent delete();
		return;
	}
}

explode(partindex, force_min, force_max, range, mindamage, maxdamage, continuedamage, originoffset, earthquakescale, earthquakeradius, attacker)
{
	if(isdefined(range) && isdefined(level.destructible_explosion_radius_multiplier))
	{
		range = range * level.destructible_explosion_radius_multiplier;
	}

	if(!isdefined(originoffset))
	{
		originoffset = 80;
	}

	if(!isdefined(continuedamage) || isdefined(continuedamage) && !continuedamage)
	{
		if(isdefined(self.exploded))
		{
			return;
		}

		self.exploded = 1;
	}

	self notify("exploded", attacker);
	level notify("destructible_exploded");
	if(self.code_classname == "script_vehicle")
	{
		self notify("death", attacker, self.damage_type);
	}

	if(common_scripts\utility::issp())
	{
		thread disconnectTraverses();
	}

	wait 0.05;
	currentstate = self.destructible_parts[partindex].v["currentState"];
	tagname = undefined;
	if(isdefined(level.destructible_type[self.destuctableinfo].parts[partindex][currentstate]))
	{
		tagname = level.destructible_type[self.destuctableinfo].parts[partindex][currentstate].v["tagName"];
	}

	if(isdefined(tagname))
	{
		explosionorigin = self gettagorigin(tagname);
	}
	else
	{
		explosionorigin = self.origin;
	}

	self notify("damage", maxdamage, self, (0,0,0), explosionorigin, "MOD_EXPLOSIVE", "", "");
	self notify("stop_car_alarm");
	waittillframeend;
	if(isdefined(level.destructible_type[self.destuctableinfo].parts))
	{
		for(i = level.destructible_type[self.destuctableinfo].parts.size - 1;i >= 0;i--)
		{
			if(i == partindex)
			{
				continue;
			}

			stateindex = self.destructible_parts[i].v["currentState"];
			if(stateindex >= level.destructible_type[self.destuctableinfo].parts[i].size)
			{
				stateindex = level.destructible_type[self.destuctableinfo].parts[i].size - 1;
			}

			modelname = level.destructible_type[self.destuctableinfo].parts[i][stateindex].v["modelName"];
			tagname = level.destructible_type[self.destuctableinfo].parts[i][stateindex].v["tagName"];
			if(!isdefined(modelname))
			{
				continue;
			}

			if(!isdefined(tagname))
			{
				continue;
			}

			if(isdefined(level.destructible_type[self.destuctableinfo].parts[i][0].v["physicsOnExplosion"]))
			{
				if(level.destructible_type[self.destuctableinfo].parts[i][0].v["physicsOnExplosion"] > 0)
				{
					velocityscaler = level.destructible_type[self.destuctableinfo].parts[i][0].v["physicsOnExplosion"];
					point = self gettagorigin(tagname);
					initial_velocity = vectornormalize(point - explosionorigin);
					initial_velocity = common_scripts\utility::vector_multiply(initial_velocity, randomfloatrange(force_min, force_max) * velocityscaler);
					thread physics_launch(i, stateindex, point, initial_velocity);
					continue;
				}
			}
		}
	}

	stoptakingdamage = !isdefined(continuedamage) || isdefined(continuedamage) && !continuedamage;
	if(stoptakingdamage)
	{
		self notify("stop_taking_damage");
	}

	wait 0.05;
	damagelocation = explosionorigin + (0,0,originoffset);
	isvehicle = getsubstr(level.destructible_type[self.destuctableinfo].v["type"], 0, 7) == "vehicle";
	if(isvehicle)
	{
		anim.lastcarexplosiontime = gettime();
		anim.lastcarexplosiondamagelocation = damagelocation;
		anim.lastcarexplosionlocation = explosionorigin;
		anim.lastcarexplosionrange = range;
	}

	level thread set_disable_friendlyfire_value_delayed(1);
	if(common_scripts\utility::issp())
	{
		if(level.gameskill == 0 && !player_touching_post_clip())
		{
			self radiusdamage(damagelocation, range, maxdamage, mindamage, self, "MOD_RIFLE_BULLET");
		}
		else
		{
			self radiusdamage(damagelocation, range, maxdamage, mindamage, self);
		}

		if(isdefined(self.damageowner) && isvehicle)
		{
			self.damageowner notify("destroyed_car");
			level notify("player_destroyed_car", self.damageowner, damagelocation);
		}
	}
	else if(!isdefined(self.damageowner))
	{
		self radiusdamage(damagelocation, range, maxdamage, mindamage, self);
	}
	else
	{
		self radiusdamage(damagelocation, range, maxdamage, mindamage, self.damageowner);
		if(isvehicle)
		{
			self.damageowner notify("destroyed_car");
			level notify("player_destroyed_car", self.damageowner, damagelocation);
		}
	}

	if(isdefined(earthquakescale) && isdefined(earthquakeradius))
	{
		earthquake(earthquakescale, 2, damagelocation, earthquakeradius);
	}

	level thread set_disable_friendlyfire_value_delayed(0, 0.05);
	magnitudescaler = 0.01;
	magnitude = range * magnitudescaler;
	range = range * 0.99;
	physicsexplosionsphere(damagelocation, range, 0, magnitude);
	if(stoptakingdamage)
	{
		self setcandamage(0);
		thread cleanupVars();
	}

	self notify("destroyed");
}

cleanupVars()
{
	wait 0.05;
	if(!isdefined(self))
	{
		return;
	}

	if(isdefined(self.waiting_for_queue))
	{
		self waittill("queue_processed");
	}

	if(!isdefined(self))
	{
		return;
	}

	self.animsapplied = undefined;
	self.attacker = undefined;
	self.car_damage_owner_recorder = undefined;
	self.caralarm = undefined;
	self.damageowner = undefined;
	self.destructible_parts = undefined;
	self.destructible_type = undefined;
	self.destuctableinfo = undefined;
	self.healthdrain = undefined;
	self.non_player_damage = undefined;
	self.player_damage = undefined;
}

set_disable_friendlyfire_value_delayed(value, delay)
{
	level notify("set_disable_friendlyfire_value_delayed");
	level endon("set_disable_friendlyfire_value_delayed");
	if(isdefined(delay))
	{
		wait delay;
	}

	level.friendlyfiredisabledfordestructible = value;
}

connectTraverses()
{
	clip = get_traverse_disconnect_brush();
	if(!isdefined(clip))
	{
		return;
	}

	clip [[ level.connectpathsfunction ]]();
	clip.origin = clip.origin - (0,0,10000);
}

disconnectTraverses()
{
	clip = get_traverse_disconnect_brush();
	if(!isdefined(clip))
	{
		return;
	}

	clip.origin = clip.origin + (0,0,10000);
	clip [[ level.disconnectpathsfunction ]]();
	clip.origin = clip.origin - (0,0,10000);
}

get_traverse_disconnect_brush()
{
	if(!isdefined(self.target))
	{
		return undefined;
	}

	targets = getentarray(self.target, "targetname");
	foreach(target in targets)
	{
		if(isspawner(target))
		{
			continue;
		}

		if(isdefined(target.script_destruct_collision))
		{
			continue;
		}

		if(target.code_classname == "light")
		{
			continue;
		}

		if(!target.spawnflags & 1)
		{
			continue;
		}

		return target;
	}
}

hideapart(tagname)
{
	self hidepart(tagname);
}

showapart(tagname)
{
	self showpart(tagname);
}

disable_explosion()
{
	self.dontallowexplode = 1;
}

force_explosion()
{
	self.dontallowexplode = undefined;
	self.forceexploding = 1;
	self notify("damage", 100000, self, self.origin, self.origin, "MOD_EXPLOSIVE", "", "");
}

get_dummy()
{
	if(!common_scripts\utility::issp())
	{
		return self;
	}

	if(self.modeldummyon)
	{
		emodel = self.modeldummy;
	}
	else
	{
		emodel = self;
	}

	return emodel;
}

play_loop_sound_on_destructible(alias, tag)
{
	emodel = get_dummy();
	org = spawn("script_origin", (0,0,0));
	if(isdefined(tag))
	{
		org.origin = emodel gettagorigin(tag);
	}
	else
	{
		org.origin = emodel.origin;
	}

	org playloopsound(alias);
	emodel thread force_stop_sound(alias);
	emodel waittill("stop sound" + alias);
	if(!isdefined(org))
	{
		return;
	}

	org stoploopsound(alias);
	org delete();
}

force_stop_sound(alias)
{
	self endon("stop sound" + alias);
	level waittill("putout_fires");
	self notify("stop sound" + alias);
}

notifyDamageAfterFrame(damage, attacker, direction_vec, point, damagetype, modelname, tagname)
{
	if(isdefined(level.notifydamageafterframe))
	{
		return;
	}

	level.notifydamageafterframe = 1;
	waittillframeend;
	if(isdefined(self.exploded))
	{
		level.notifydamageafterframe = undefined;
		return;
	}

	if(common_scripts\utility::issp())
	{
		damage = damage / 0.5;
	}
	else
	{
		damage = damage / 1;
	}

	self notify("damage", damage, attacker, direction_vec, point, damagetype, modelname, tagname);
	level.notifydamageafterframe = undefined;
}

play_sound(alias, tag)
{
	if(isdefined(tag))
	{
		org = spawn("script_origin", self gettagorigin(tag));
		org hide();
		org linkto(self, tag, (0,0,0), (0,0,0));
	}
	else
	{
		org = spawn("script_origin", (0,0,0));
		org hide();
		org.origin = self.origin;
		org.angles = self.angles;
		org linkto(self);
	}

	org playsound(alias);
	wait 5;
	if(isdefined(org))
	{
		org delete();
		return;
	}
}

toString(num)
{
	return "" + num;
}

do_car_alarm()
{
	if(isdefined(self.caralarm))
	{
		return;
	}

	self.caralarm = 1;
	if(!should_do_car_alarm())
	{
		return;
	}

	self.car_alarm_org = spawn("script_model", self.origin);
	self.car_alarm_org hide();
	self.car_alarm_org playloopsound("car_alarm");
	level.currentcaralarms++;
	thread car_alarm_timeout();
	self waittill("stop_car_alarm");
	level.lastcaralarmtime = gettime();
	level.currentcaralarms--;
	self.car_alarm_org stoploopsound("car_alarm");
	self.car_alarm_org delete();
}

car_alarm_timeout()
{
	self endon("stop_car_alarm");
	wait 25;
	if(!isdefined(self))
	{
		return;
	}

	thread play_sound("car_alarm_off");
	self notify("stop_car_alarm");
}

should_do_car_alarm()
{
	if(level.currentcaralarms >= 2)
	{
		return 0;
	}

	timeelapsed = undefined;
	if(!isdefined(level.lastcaralarmtime))
	{
		if(common_scripts\utility::cointoss())
		{
			return 1;
		}

		timeelapsed = gettime() - level.commonstarttime;
	}
	else
	{
		timeelapsed = gettime() - level.lastcaralarmtime;
	}

	if(level.currentcaralarms == 0 && timeelapsed >= 120)
	{
		return 1;
	}

	if(randomint(100) <= 33)
	{
		return 1;
	}

	return 0;
}

do_random_dynamic_attachment(tagname, attach_model_1, attach_model_2, cliptoremove)
{
	spawnedmodels = [];
	if(common_scripts\utility::issp())
	{
		self attach(attach_model_1, tagname, 0);
		if(isdefined(attach_model_2) && attach_model_2 != "")
		{
			self attach(attach_model_2, tagname, 0);
		}
	}
	else
	{
		spawnedmodels[0] = spawn("script_model", self gettagorigin(tagname));
		spawnedmodels[0].angles = self gettagangles(tagname);
		spawnedmodels[0] setmodel(attach_model_1);
		spawnedmodels[0] linkto(self, tagname);
		if(isdefined(attach_model_2) && attach_model_2 != "")
		{
			spawnedmodels[1] = spawn("script_model", self gettagorigin(tagname));
			spawnedmodels[1].angles = self gettagangles(tagname);
			spawnedmodels[1] setmodel(attach_model_2);
			spawnedmodels[1] linkto(self, tagname);
		}
	}

	if(isdefined(cliptoremove))
	{
		tagorg = self gettagorigin(tagname);
		clip = get_closest_with_targetname(tagorg, cliptoremove);
		if(isdefined(clip))
		{
			clip delete();
		}
	}

	self waittill("exploded");
	if(common_scripts\utility::issp())
	{
		self detach(attach_model_1, tagname);
		self attach(attach_model_1 + "_destroy", tagname, 0);
		if(isdefined(attach_model_2) && attach_model_2 != "")
		{
			self detach(attach_model_2, tagname);
			self attach(attach_model_2 + "_destroy", tagname, 0);
			return;
		}

		return;
	}

	spawnedmodels[0] setmodel(attach_model_1 + "_destroy");
	if(isdefined(attach_model_2) && attach_model_2 != "")
	{
		spawnedmodels[1] setmodel(attach_model_2 + "_destroy");
		return;
	}
}

get_closest_with_targetname(origin, targetname)
{
	closestdist = undefined;
	closestent = undefined;
	ents = getentarray(targetname, "targetname");
	foreach(ent in ents)
	{
		d = distancesquared(origin, ent.origin);
		if(!isdefined(closestdist) || d < closestdist)
		{
			closestdist = d;
			closestent = ent;
		}
	}

	return closestent;
}

player_touching_post_clip()
{
	post_clip = undefined;
	if(!isdefined(self.target))
	{
		return 0;
	}

	targets = getentarray(self.target, "targetname");
	foreach(target in targets)
	{
		if(isdefined(target.script_destruct_collision) && target.script_destruct_collision == "post")
		{
			post_clip = target;
			break;
		}
	}

	if(!isdefined(post_clip))
	{
		return 0;
	}

	player = get_player_touching(post_clip);
	if(isdefined(player))
	{
		return 1;
	}

	return 0;
}

get_player_touching(ent)
{
	foreach(player in level.players)
	{
		if(!isalive(player))
		{
			continue;
		}

		if(ent istouching(player))
		{
			return player;
		}
	}

	return undefined;
}

is_so()
{
	return getdvar("specialops") == "1";
}

destructible_handles_collision_brushes()
{
	targets = getentarray(self.target, "targetname");
	collision_funcs = [];
	collision_funcs["pre"] = ::collision_brush_pre_explosion;
	collision_funcs["post"] = ::collision_brush_post_explosion;
	foreach(target in targets)
	{
		if(!isdefined(target.script_destruct_collision))
		{
			continue;
		}

		self thread [[ collision_funcs[target.script_destruct_collision] ]](target);
	}
}

collision_brush_pre_explosion(clip)
{
	waittillframeend;
	if(common_scripts\utility::issp())
	{
		clip [[ level.disconnectpathsfunction ]]();
	}

	self waittill("exploded");
	if(common_scripts\utility::issp())
	{
		clip [[ level.connectpathsfunction ]]();
	}

	clip delete();
}

collision_brush_post_explosion(clip)
{
	clip notsolid();
	if(common_scripts\utility::issp())
	{
		clip [[ level.connectpathsfunction ]]();
	}

	self waittill("exploded");
	waittillframeend;
	if(common_scripts\utility::issp())
	{
		clip [[ level.disconnectpathsfunction ]]();
		if(is_so())
		{
			player = get_player_touching(clip);
			if(isdefined(player))
			{
				self thread [[ level.func_destructible_crush_player ]](player);
			}
		}
		else
		{
		}
	}

	clip solid();
}

debug_player_in_post_clip(clip)
{
}

destructible_get_my_breakable_light(range)
{
	lights = getentarray("light_destructible", "targetname");
	if(common_scripts\utility::issp())
	{
		lights2 = getentarray("light_destructible", "script_noteworthy");
		lights = common_scripts\utility::array_combine(lights, lights2);
	}

	if(!lights.size)
	{
		return;
	}

	shortest_distance = range * range;
	the_light = undefined;
	foreach(light in lights)
	{
		dist = distancesquared(self.origin, light.origin);
		if(dist < shortest_distance)
		{
			the_light = light;
			shortest_distance = dist;
		}
	}

	if(!isdefined(the_light))
	{
		return;
	}

	self.breakable_light = the_light;
}

break_nearest_light(range)
{
	if(!isdefined(self.breakable_light))
	{
		return;
	}

	self.breakable_light setlightintensity(0);
}

debug_radiusdamage_circle(center, radius, maxdamage, mindamage)
{
	circle_sides = 16;
	anglefrac = 360 / circle_sides;
	circlepoints = [];
	for(i = 0;i < circle_sides;i++)
	{
		angle = anglefrac * i;
		xadd = cos(angle) * radius;
		yadd = sin(angle) * radius;
		x = center[0] + xadd;
		y = center[1] + yadd;
		z = center[2];
		circlepoints[circlepoints.size] = (x,y,z);
	}

	thread debug_circle_drawlines(circlepoints, 5, (1,0,0), center);
	circlepoints = [];
	for(i = 0;i < circle_sides;i++)
	{
		angle = anglefrac * i;
		xadd = cos(angle) * radius;
		yadd = sin(angle) * radius;
		x = center[0];
		y = center[1] + xadd;
		z = center[2] + yadd;
		circlepoints[circlepoints.size] = (x,y,z);
	}

	thread debug_circle_drawlines(circlepoints, 5, (1,0,0), center);
	circlepoints = [];
	for(i = 0;i < circle_sides;i++)
	{
		angle = anglefrac * i;
		xadd = cos(angle) * radius;
		yadd = sin(angle) * radius;
		x = center[0] + yadd;
		y = center[1];
		z = center[2] + xadd;
		circlepoints[circlepoints.size] = (x,y,z);
	}

	thread debug_circle_drawlines(circlepoints, 5, (1,0,0), center);
}

debug_circle_drawlines(circlepoints, duration, color, center)
{
	for(i = 0;i < circlepoints.size;i++)
	{
		start = circlepoints[i];
		if(i + 1 >= circlepoints.size)
		{
			end = circlepoints[0];
		}
		else
		{
			end = circlepoints[i + 1];
		}

		thread debug_line(start, end, duration, color);
		thread debug_line(center, start, duration, color);
	}
}

debug_line(start, end, duration, color)
{
	if(!isdefined(color))
	{
		color = (1,1,1);
	}

	for(i = 0;i < duration * 20;i++)
	{
		wait 0.05;
	}
}

spotlight_tag_origin_cleanup(tag_origin)
{
	tag_origin endon("death");
	level waittill("new_destructible_spotlight");
	tag_origin delete();
}

spotlight_fizzles_out(action_v, emodel, damagetype, partindex, tag_origin)
{
	level endon("new_destructible_spotlight");
	thread spotlight_tag_origin_cleanup(tag_origin);
	maxval = action_v["spotlight_brightness"];
	common_scripts\utility::noself_func("setsaveddvar", "r_spotlightbrightness", maxval);
	wait randomfloatrange(2, 5);
	steps = randomintrange(5, 11);
	for(i = 0;i < steps;i++)
	{
		common_scripts\utility::noself_func("setsaveddvar", "r_spotlightbrightness", maxval * 0.65);
		wait 0.05;
		common_scripts\utility::noself_func("setsaveddvar", "r_spotlightbrightness", maxval);
		wait 0.05;
	}

	destructible_fx_think(action_v, emodel, damagetype, partindex);
	level.destructible_spotlight delete();
	tag_origin delete();
}

destructible_spotlight_think(action_v, emodel, damagetype, partindex)
{
	if(!common_scripts\utility::issp())
	{
		return;
	}

	if(!isdefined(self.breakable_light))
	{
		return;
	}

	emodel common_scripts\utility::self_func("startignoringspotLight");
	foreach(dvar, val in action_v["dvars"])
	{
		common_scripts\utility::noself_func("setsaveddvar", dvar, val);
	}

	if(!isdefined(level.destructible_spotlight))
	{
		level.destructible_spotlight = common_scripts\utility::spawn_tag_origin();
		fx = common_scripts\utility::getfx(action_v["spotlight_fx"]);
		playfxontag(fx, level.destructible_spotlight, "tag_origin");
	}

	level notify("new_destructible_spotlight");
	level.destructible_spotlight unlink();
	tag_origin = common_scripts\utility::spawn_tag_origin();
	tag_origin linkto(self, action_v["spotlight_tag"], (0,0,0), (0,0,0));
	level.destructible_spotlight.origin = self.breakable_light.origin;
	level.destructible_spotlight.angles = self.breakable_light.angles;
	level.destructible_spotlight thread spotlight_fizzles_out(action_v, emodel, damagetype, partindex, tag_origin);
	wait 0.05;
	if(isdefined(tag_origin))
	{
		level.destructible_spotlight linkto(tag_origin);
		return;
	}
}

is_valid_damagetype(damagetype, v, idx, groupnum)
{
	valid_damagetype = undefined;
	if(isdefined(v["fx_valid_damagetype"]))
	{
		valid_damagetype = v["fx_valid_damagetype"][groupnum][idx];
	}

	if(!isdefined(valid_damagetype))
	{
		return 1;
	}

	return issubstr(valid_damagetype, damagetype);
}

destructible_sound_think(action_v, emodel, damagetype, groupnum)
{
	if(isdefined(self.exploded))
	{
		return undefined;
	}

	if(!isdefined(action_v["sound"]))
	{
		return undefined;
	}

	if(!isdefined(groupnum))
	{
		groupnum = 0;
	}

	for(i = 0;i < action_v["sound"][groupnum].size;i++)
	{
		validsoundcause = isValidSoundCause("soundCause", action_v, i, damagetype, groupnum);
		if(!validsoundcause)
		{
			continue;
		}

		soundalias = action_v["sound"][groupnum][i];
		soundtagname = action_v["tagName"];
		emodel thread play_sound(soundalias, soundtagname);
	}

	return groupnum;
}

destructible_fx_think(action_v, emodel, damagetype, partindex, groupnum)
{
	if(!isdefined(action_v["fx"]))
	{
		return undefined;
	}

	if(!isdefined(groupnum))
	{
		groupnum = randomint(action_v["fx_filename"].size);
	}

	if(!isdefined(action_v["fx"][groupnum]))
	{
		groupnum = randomint(action_v["fx_filename"].size);
	}

	fx_size = action_v["fx_filename"][groupnum].size;
	for(idx = 0;idx < fx_size;idx++)
	{
		if(!is_valid_damagetype(damagetype, action_v, idx, groupnum))
		{
			continue;
		}

		fx = action_v["fx"][groupnum][idx];
		if(isdefined(action_v["fx_tag"][groupnum][idx]))
		{
			fx_tag = action_v["fx_tag"][groupnum][idx];
			self notify("FX_State_Change" + partindex);
			if(action_v["fx_useTagAngles"][groupnum][idx])
			{
				playfxontag(fx, emodel, fx_tag);
			}
			else
			{
				fxorigin = emodel gettagorigin(fx_tag);
				forward = fxorigin + (0,0,100) - fxorigin;
				playfx(fx, fxorigin, forward);
			}

			continue;
		}

		fxorigin = emodel.origin;
		forward = fxorigin + (0,0,100) - fxorigin;
		playfx(fx, fxorigin, forward);
	}

	return groupnum;
}

destructible_animation_think(action_v, emodel, damagetype, partindex)
{
	if(isdefined(self.exploded))
	{
		return undefined;
	}

	if(!isdefined(action_v["animation"]))
	{
		return undefined;
	}

	if(isdefined(action_v["randomly_flip"]) && !isdefined(self.script_noflip))
	{
		if(common_scripts\utility::cointoss())
		{
			self.angles = self.angles + (0,180,0);
		}
	}

	if(isdefined(action_v["spotlight_tag"]))
	{
		thread destructible_spotlight_think(action_v, emodel, damagetype, partindex);
		wait 0.05;
	}

	array = common_scripts\utility::random(action_v["animation"]);
	animname = array["anim"];
	animtree = array["animTree"];
	groupnum = array["groupNum"];
	mpanim = array["mpAnim"];
	maxstartdelay = array["maxStartDelay"];
	animratemin = array["animRateMin"];
	animratemax = array["animRateMax"];
	if(!isdefined(animratemin))
	{
		animratemin = 1;
	}

	if(!isdefined(animratemax))
	{
		animratemax = 1;
	}

	if(animratemin == animratemax)
	{
		animrate = animratemin;
	}
	else
	{
		animrate = randomfloatrange(animratemin, animratemax);
	}

	vehicle_dodge_part_animation = array["vehicle_exclude_anim"];
	if(self.code_classname == "script_vehicle" && vehicle_dodge_part_animation)
	{
		return undefined;
	}

	emodel common_scripts\utility::self_func("useanimtree", animtree);
	animtype = array["animType"];
	if(!isdefined(self.animsapplied))
	{
		self.animsapplied = [];
	}

	self.animsapplied[self.animsapplied.size] = animname;
	if(isdefined(self.exploding))
	{
		clear_anims(emodel);
	}

	if(isdefined(maxstartdelay) && maxstartdelay > 0)
	{
		wait randomfloat(maxstartdelay);
	}

	if(!common_scripts\utility::issp())
	{
		if(isdefined(mpanim))
		{
			common_scripts\utility::self_func("scriptModelPlayAnim", mpanim);
		}

		return groupnum;
	}

	if(animtype == "setanim")
	{
		emodel common_scripts\utility::self_func("setanim", animname, 1, 1, animrate);
		return groupnum;
	}

	if(animtype == "setanimknob")
	{
		emodel common_scripts\utility::self_func("setanimknob", animname, 1, 0, animrate);
		return groupnum;
	}

	return undefined;
}

clear_anims(emodel)
{
	if(isdefined(self.animsapplied))
	{
		foreach(animation in self.animsapplied)
		{
			if(common_scripts\utility::issp())
			{
				emodel common_scripts\utility::self_func("clearanim", animation, 0);
				continue;
			}

			emodel common_scripts\utility::self_func("scriptModelClearAnim");
		}

		return;
	}
}

init_destroyed_count()
{
	level.destroyedcount = 0;
	level.destroyedcounttimeout = 0.5;
	if(common_scripts\utility::issp())
	{
		level.maxdestructions = 20;
		return;
	}

	level.maxdestructions = 2;
}

add_to_destroyed_count()
{
	level.destroyedcount++;
	wait level.destroyedcounttimeout;
	level.destroyedcount--;
}

get_destroyed_count()
{
	return level.destroyedcount;
}

get_max_destroyed_count()
{
	return level.maxdestructions;
}

init_destructible_frame_queue()
{
	level.destructibleframequeue = [];
}

add_destructible_to_frame_queue(destructible, partinfo, damage)
{
	entnum = self getentitynumber();
	if(!isdefined(level.destructibleframequeue[entnum]))
	{
		level.destructibleframequeue[entnum] = spawnstruct();
		level.destructibleframequeue[entnum].entnum = entnum;
		level.destructibleframequeue[entnum].destructible = destructible;
		level.destructibleframequeue[entnum].totaldamage = 0;
		level.destructibleframequeue[entnum].neardistance = 9999999;
		level.destructibleframequeue[entnum].fxcost = 0;
	}

	level.destructibleframequeue[entnum].fxcost = level.destructibleframequeue[entnum].fxcost + partinfo.v["fxcost"];
	level.destructibleframequeue[entnum].totaldamage = level.destructibleframequeue[entnum].totaldamage + damage;
	if(partinfo.v["distance"] < level.destructibleframequeue[entnum].neardistance)
	{
		level.destructibleframequeue[entnum].neardistance = partinfo.v["distance"];
	}

	thread handle_destructible_frame_queue();
}

handle_destructible_frame_queue()
{
	level notify("handle_destructible_frame_queue");
	level endon("handle_destructible_frame_queue");
	wait 0.05;
	currentqueue = level.destructibleframequeue;
	level.destructibleframequeue = [];
	sortedqueue = sort_destructible_frame_queue(currentqueue);
	for(i = 0;i < sortedqueue.size;i++)
	{
		if(get_destroyed_count() < get_max_destroyed_count())
		{
			if(sortedqueue[i].fxcost)
			{
				thread add_to_destroyed_count();
			}

			sortedqueue[i].destructible notify("queue_processed", 1);
			continue;
		}

		sortedqueue[i].destructible notify("queue_processed", 0);
	}
}

sort_destructible_frame_queue(unsortedqueue)
{
	sortedqueue = [];
	foreach(destructibleinfo in unsortedqueue)
	{
		sortedqueue[sortedqueue.size] = destructibleinfo;
	}

	for(i = 1;i < sortedqueue.size;i++)
	{
		queuestruct = sortedqueue[i];
		for(j = i - 1;j >= 0 && get_better_destructible(queuestruct, sortedqueue[j]) == queuestruct;j--)
		{
			sortedqueue[j + 1] = sortedqueue[j];
		}

		sortedqueue[j + 1] = queuestruct;
	}

	return sortedqueue;
}

get_better_destructible(destructibleinfo1, destructibleinfo2)
{
	if(destructibleinfo1.totaldamage > destructibleinfo2.totaldamage)
	{
		return destructibleinfo1;
	}

	return destructibleinfo2;
}

get_part_FX_cost_for_action_state(partindex, actionstateindex)
{
	fxcost = 0;
	if(!isdefined(level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex]))
	{
		return fxcost;
	}

	action_v = level.destructible_type[self.destuctableinfo].parts[partindex][actionstateindex].v;
	if(isdefined(action_v["fx"]))
	{
		foreach(fxcostobj in action_v["fx_cost"])
		{
			foreach(fxcostval in fxcostobj)
			{
				fxcost = fxcost + fxcostval;
			}
		}
	}

	return fxcost;
}