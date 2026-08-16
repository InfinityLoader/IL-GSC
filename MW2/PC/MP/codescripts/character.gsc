/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: codescripts\character.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: PC
*******************************************************************/

setmodelfromarray(a)
{
	self setmodel(a[randomint(a.size)]);
}

precachemodelarray(a)
{
	for(i = 0;i < a.size;i++)
	{
		precachemodel(a[i]);
	}
}

attachhead(headalias, headarray)
{
	if(!isdefined(level.character_head_index))
	{
		level.character_head_index = [];
	}

	if(!isdefined(level.character_head_index[headalias]))
	{
		level.character_head_index[headalias] = randomint(headarray.size);
	}

	index = level.character_head_index[headalias] + 1 % headarray.size;
	if(isdefined(self.script_char_index))
	{
		index = self.script_char_index % headarray.size;
	}

	level.character_head_index[headalias] = index;
	self attach(headarray[index], "", 1);
	self.headmodel = headarray[index];
}

new()
{
	self detachall();
	oldgunhand = self.anim_gunhand;
	if(!isdefined(oldgunhand))
	{
		return;
	}

	self.anim_gunhand = "none";
	self [[ level.putguninhand ]](oldgunhand);
}

save()
{
	info["gunHand"] = self.anim_gunhand;
	info["gunInHand"] = self.anim_guninhand;
	info["model"] = self.model;
	info["hatModel"] = self.hatmodel;
	if(isdefined(self.name))
	{
		info["name"] = self.name;
	}
	else
	{
	}

	attachsize = self getattachsize();
	for(i = 0;i < attachsize;i++)
	{
		info["attach"][i]["model"] = self getattachmodelname(i);
		info["attach"][i]["tag"] = self getattachtagname(i);
	}

	return info;
}

load(info)
{
	self detachall();
	self.anim_gunhand = info["gunHand"];
	self.anim_guninhand = info["gunInHand"];
	self setmodel(info["model"]);
	self.hatmodel = info["hatModel"];
	if(isdefined(info["name"]))
	{
		self.name = info["name"];
	}
	else
	{
	}

	attachinfo = info["attach"];
	attachsize = attachinfo.size;
	for(i = 0;i < attachsize;i++)
	{
		self attach(attachinfo[i]["model"], attachinfo[i]["tag"]);
	}
}

precache(info)
{
	if(isdefined(info["name"]))
	{
	}
	else
	{
	}

	precachemodel(info["model"]);
	attachinfo = info["attach"];
	attachsize = attachinfo.size;
	for(i = 0;i < attachsize;i++)
	{
		precachemodel(attachinfo[i]["model"]);
	}
}

get_random_character(amount)
{
	self_info = strtok(self.classname, "_");
	if(!common_scripts\utility::issp())
	{
		if(isdefined(self.pers["modelIndex"]) && self.pers["modelIndex"] < amount)
		{
			return self.pers["modelIndex"];
		}

		index = randomint(amount);
		self.pers["modelIndex"] = index;
		return index;
	}
	else if(self_info.size <= 2)
	{
		return randomint(amount);
	}

	group = "auto";
	index = undefined;
	prefix = self_info[2];
	if(isdefined(self.script_char_index))
	{
		index = self.script_char_index;
	}

	if(isdefined(self.script_char_group))
	{
		type = "grouped";
		group = "group_" + self.script_char_group;
	}

	if(!isdefined(level.character_index_cache))
	{
		level.character_index_cache = [];
	}

	if(!isdefined(level.character_index_cache[prefix]))
	{
		level.character_index_cache[prefix] = [];
	}

	if(!isdefined(level.character_index_cache[prefix][group]))
	{
		initialize_character_group(prefix, group, amount);
	}

	if(!isdefined(index))
	{
		index = get_least_used_index(prefix, group);
		if(!isdefined(index))
		{
			index = randomint(5000);
		}
	}

	while(index >= amount)
	{
		index = index - amount;
	}

	level.character_index_cache[prefix][group][index]++;
	return index;
}

get_least_used_index(prefix, group)
{
	lowest_indices = [];
	lowest_use = level.character_index_cache[prefix][group][0];
	lowest_indices[0] = 0;
	for(i = 1;i < level.character_index_cache[prefix][group].size;i++)
	{
		if(level.character_index_cache[prefix][group][i] > lowest_use)
		{
			continue;
		}

		if(level.character_index_cache[prefix][group][i] < lowest_use)
		{
			lowest_indices = [];
			lowest_use = level.character_index_cache[prefix][group][i];
		}

		lowest_indices[lowest_indices.size] = i;
	}

	return random(lowest_indices);
}

initialize_character_group(prefix, group, amount)
{
	for(i = 0;i < amount;i++)
	{
		level.character_index_cache[prefix][group][i] = 0;
	}
}

get_random_weapon(amount)
{
	return randomint(amount);
}

random(array)
{
	return array[randomint(array.size)];
}