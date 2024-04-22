/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: character.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 167 ms
 * Timestamp: 4/22/2024 2:02:45 AM
*******************************************************************/

//Function Number: 1
setmodelfromarray(param_00)
{
	self setmodel(param_00[randomint(param_00.size)]);
}

//Function Number: 2
precachemodelarray(param_00)
{
	for(var_01 = 0;var_01 < param_00.size;var_01++)
	{
		precachemodel(param_00[var_01]);
	}
}

//Function Number: 3
attachhead(param_00,param_01)
{
	if(!isdefined(level.character_head_index))
	{
		level.character_head_index = [];
	}

	if(!isdefined(level.character_head_index[param_00]))
	{
		level.character_head_index[param_00] = randomint(param_01.size);
	}

	var_02 = level.character_head_index[param_00] + 1 % param_01.size;
	if(isdefined(self.script_char_index))
	{
		var_02 = self.script_char_index % param_01.size;
	}

	level.character_head_index[param_00] = var_02;
	setheadmodel(param_01[var_02]);
}

//Function Number: 4
setheadmodel(param_00)
{
	if(isdefined(self.headmodel))
	{
		self detach(self.headmodel);
	}

	self attach(param_00,"",1);
	self.headmodel = param_00;
}

//Function Number: 5
attachhat(param_00,param_01)
{
	if(!isdefined(level.character_hat_index))
	{
		level.character_hat_index = [];
	}

	if(!isdefined(level.character_hat_index[param_00]))
	{
		level.character_hat_index[param_00] = randomint(param_01.size);
	}

	var_02 = level.character_hat_index[param_00] + 1 % param_01.size;
	level.character_hat_index[param_00] = var_02;
	self attach(param_01[var_02]);
	self.hatmodel = param_01[var_02];
}

//Function Number: 6
new()
{
	self detachall();
	var_00 = self.anim_gunhand;
	if(!isdefined(var_00))
	{
		return;
	}

	self.anim_gunhand = "none";
	self [[ level.putguninhand ]](var_00);
}

//Function Number: 7
save()
{
	var_00["gunHand"] = self.anim_gunhand;
	var_00["gunInHand"] = self.anim_guninhand;
	var_00["model"] = self.model;
	var_00["hatModel"] = self.hatmodel;
	if(isdefined(self.name))
	{
		var_00["name"] = self.name;
	}
	else
	{
	}

	var_01 = self getattachsize();
	for(var_02 = 0;var_02 < var_01;var_02++)
	{
		var_00["attach"][var_02]["model"] = self getattachmodelname(var_02);
		var_00["attach"][var_02]["tag"] = self getattachtagname(var_02);
	}

	return var_00;
}

//Function Number: 8
load(param_00)
{
	self detachall();
	self.anim_gunhand = param_00["gunHand"];
	self.anim_guninhand = param_00["gunInHand"];
	self setmodel(param_00["model"]);
	self.hatmodel = param_00["hatModel"];
	if(isdefined(param_00["name"]))
	{
		self.name = param_00["name"];
	}
	else
	{
	}

	var_01 = param_00["attach"];
	var_02 = var_01.size;
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		self attach(var_01[var_03]["model"],var_01[var_03]["tag"]);
	}
}

//Function Number: 9
precache(param_00)
{
	if(isdefined(param_00["name"]))
	{
	}
	else
	{
	}

	precachemodel(param_00["model"]);
	var_01 = param_00["attach"];
	var_02 = var_01.size;
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		precachemodel(var_01[var_03]["model"]);
	}
}

//Function Number: 10
get_random_character(param_00)
{
	if(isdefined(self.classname))
	{
		var_01 = strtok(self.classname,"_");
	}
	else
	{
		var_01 = [];
	}

	if(!common_scripts\utility::issp())
	{
		if(isdefined(self.pers["modelIndex"]) && self.pers["modelIndex"] < param_00)
		{
			return self.pers["modelIndex"];
		}

		var_02 = randomint(param_00);
		self.pers["modelIndex"] = var_02;
		return var_02;
	}
	else if(var_02.size <= 2)
	{
		return randomint(var_01);
	}

	var_03 = "auto";
	var_02 = undefined;
	var_04 = var_01[2];
	if(isdefined(self.script_char_index))
	{
		var_03 = self.script_char_index;
	}

	if(isdefined(self.script_char_group))
	{
		var_05 = "grouped";
		var_02 = "group_" + self.script_char_group;
	}

	if(!isdefined(level.character_index_cache))
	{
		level.character_index_cache = [];
	}

	if(!isdefined(level.character_index_cache[var_04]))
	{
		level.character_index_cache[var_04] = [];
	}

	if(!isdefined(level.character_index_cache[var_04][var_02]))
	{
		initialize_character_group(var_04,var_02,param_00);
	}

	if(!isdefined(var_03))
	{
		var_03 = get_least_used_index(var_04,var_02);
		if(!isdefined(var_03))
		{
			var_03 = randomint(5000);
		}
	}

	while(var_03 >= param_00)
	{
		var_03 = var_03 - param_00;
	}

	level.character_index_cache[var_04][var_02][var_03]++;
	return var_03;
}

//Function Number: 11
get_least_used_index(param_00,param_01)
{
	var_02 = [];
	var_03 = level.character_index_cache[param_00][param_01][0];
	var_02[0] = 0;
	for(var_04 = 1;var_04 < level.character_index_cache[param_00][param_01].size;var_04++)
	{
		if(level.character_index_cache[param_00][param_01][var_04] > var_03)
		{
			continue;
		}

		if(level.character_index_cache[param_00][param_01][var_04] < var_03)
		{
			var_02 = [];
			var_03 = level.character_index_cache[param_00][param_01][var_04];
		}

		var_02[var_02.size] = var_04;
	}

	return random(var_02);
}

//Function Number: 12
initialize_character_group(param_00,param_01,param_02)
{
	for(var_03 = 0;var_03 < param_02;var_03++)
	{
		level.character_index_cache[param_00][param_01][var_03] = 0;
	}
}

//Function Number: 13
get_random_weapon(param_00)
{
	return randomint(param_00);
}

//Function Number: 14
random(param_00)
{
	return param_00[randomint(param_00.size)];
}