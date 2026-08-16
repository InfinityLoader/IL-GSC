/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\_destructible_dlc.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

main()
{
	if(!isdefined(level.func))
	{
		level.func = [];
	}

	vehicles = getentarray("destructible_vehicle", "targetname");
	foreach(vehicle in vehicles)
	{
		vehicle setup_destructibles_dlc();
	}

	destructible_toy = getentarray("destructible_toy", "targetname");
	foreach(toy in destructible_toy)
	{
		toy setup_destructibles_dlc();
	}
}

setup_destructibles_dlc(param_8AE)
{
	if(!isdefined(param_8AE))
	{
		param_8AE = 0;
	}

	destuctableinfo = undefined;
	self.modeldummyon = 0;
	common_scripts\_destructible::add_damage_owner_recorder();
	self.destuctableinfo = common_scripts\_destructible_types_dlc::maketype_dlc(self.destructible_type);
	if(!isdefined(self.destuctableinfo))
	{
		return;
	}

	if(self.destuctableinfo < 0)
	{
		return;
	}

	self.targetname = self.targetname + "_dlc";
	if(!param_8AE)
	{
		common_scripts\_destructible::precache_destructibles();
	}

	common_scripts\_destructible::add_destructible_fx();
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
				thread common_scripts\_destructible::do_random_dynamic_attachment(attachtag, attach_model_1, attach_model_2, cliptoremove);
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
					common_scripts\_destructible::hideapart(statetagname);
					if(self.modeldummyon)
					{
						self.modeldummy common_scripts\_destructible::hideapart(statetagname);
					}
				}
			}
		}
	}

	if(isdefined(self.target))
	{
		thread common_scripts\_destructible::destructible_handles_collision_brushes();
	}

	if(self.code_classname != "script_vehicle")
	{
		self setcandamage(1);
	}

	if(common_scripts\utility::issp())
	{
		thread common_scripts\_destructible::connectTraverses();
	}

	thread common_scripts\_destructible::destructible_think();
}