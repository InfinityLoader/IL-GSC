/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\utility.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

scriptprintln(param_12F, msg)
{
}

debugprintln(param_12F, msg)
{
}

draw_debug_line(start, end, timer)
{
	for(i = 0;i < timer * 20;i++)
	{
		wait 0.05;
	}
}

waittillend(msg)
{
	self waittillmatch("end", msg);
}

noself_func(func, parm1, parm2, parm3, parm4)
{
	if(!isdefined(level.func))
	{
		return;
	}

	if(!isdefined(level.func[func]))
	{
		return;
	}

	if(!isdefined(parm1))
	{
		[[ level.func[func] ]]();
		return;
	}

	if(!isdefined(parm2))
	{
		[[ level.func[func] ]](parm1);
		return;
	}

	if(!isdefined(parm3))
	{
		[[ level.func[func] ]](parm1, parm2);
		return;
	}

	if(!isdefined(parm4))
	{
		[[ level.func[func] ]](parm1, parm2, parm3);
		return;
	}

	[[ level.func[func] ]](parm1, parm2, parm3, parm4);
}

self_func(func, parm1, parm2, parm3, parm4)
{
	if(!isdefined(level.func[func]))
	{
		return;
	}

	if(!isdefined(parm1))
	{
		self [[ level.func[func] ]]();
		return;
	}

	if(!isdefined(parm2))
	{
		self [[ level.func[func] ]](parm1);
		return;
	}

	if(!isdefined(parm3))
	{
		self [[ level.func[func] ]](parm1, parm2);
		return;
	}

	if(!isdefined(parm4))
	{
		self [[ level.func[func] ]](parm1, parm2, parm3);
		return;
	}

	self [[ level.func[func] ]](parm1, parm2, parm3, parm4);
}

randomvector(num)
{
	return (randomfloat(num) - num * 0.5,randomfloat(num) - num * 0.5,randomfloat(num) - num * 0.5);
}

randomvectorrange(num_min, num_max)
{
	x = randomfloatrange(num_min, num_max);
	if(randomint(2) == 0)
	{
		x = x * -1;
	}

	y = randomfloatrange(num_min, num_max);
	if(randomint(2) == 0)
	{
		y = y * -1;
	}

	z = randomfloatrange(num_min, num_max);
	if(randomint(2) == 0)
	{
		z = z * -1;
	}

	return (x,y,z);
}

angle_dif(oldangle, newangle)
{
	if(oldangle == newangle)
	{
		return 0;
	}

	while(newangle > 360)
	{
		newangle = newangle - 360;
	}

	while(newangle < 0)
	{
		newangle = newangle + 360;
	}

	while(oldangle > 360)
	{
		oldangle = oldangle - 360;
	}

	while(oldangle < 0)
	{
		oldangle = oldangle + 360;
	}

	olddif = undefined;
	newdif = undefined;
	if(newangle > 180)
	{
		newdif = 360 - newangle;
	}
	else
	{
		newdif = newangle;
	}

	if(oldangle > 180)
	{
		olddif = 360 - oldangle;
	}
	else
	{
		olddif = oldangle;
	}

	outerdif = newdif + olddif;
	innerdif = 0;
	if(newangle > oldangle)
	{
		innerdif = newangle - oldangle;
	}
	else
	{
		innerdif = oldangle - newangle;
	}

	if(innerdif < outerdif)
	{
		return innerdif;
	}

	return outerdif;
}

sign(x)
{
	if(x >= 0)
	{
		return 1;
	}

	return -1;
}

track(spot_to_track)
{
	if(isdefined(self.current_target))
	{
		if(spot_to_track == self.current_target)
		{
			return;
		}
	}

	self.current_target = spot_to_track;
}

get_enemy_team(team)
{
	teams = [];
	teams["axis"] = "allies";
	teams["allies"] = "axis";
	return teams[team];
}

clear_exception(type)
{
	self.exception[type] = level.defaultexception;
}

set_exception(type, func)
{
	self.exception[type] = func;
}

set_all_exceptions(exceptionfunc)
{
	keys = getarraykeys(self.exception);
	for(i = 0;i < keys.size;i++)
	{
		self.exception[keys[i]] = exceptionfunc;
	}
}

cointoss()
{
	return randomint(100) >= 50;
}

choose_from_weighted_array(values, weights)
{
	randomval = randomint(weights[weights.size - 1] + 1);
	for(i = 0;i < weights.size;i++)
	{
		if(randomval <= weights[i])
		{
			return values[i];
		}
	}
}

get_cumulative_weights(weights)
{
	cumulative_weights = [];
	sum = 0;
	for(i = 0;i < weights.size;i++)
	{
		sum = sum + weights[i];
		cumulative_weights[i] = sum;
	}

	return cumulative_weights;
}

waittill_string(msg, ent)
{
	if(msg != "death")
	{
		self endon("death");
	}

	ent endon("die");
	self waittill(msg);
	ent notify("returned", msg);
}

waittill_multiple(string1, string2, string3, string4, string5)
{
	self endon("death");
	ent = spawnstruct();
	ent.threads = 0;
	if(isdefined(string1))
	{
		thread waittill_string(string1, ent);
		ent.threads++;
	}

	if(isdefined(string2))
	{
		thread waittill_string(string2, ent);
		ent.threads++;
	}

	if(isdefined(string3))
	{
		thread waittill_string(string3, ent);
		ent.threads++;
	}

	if(isdefined(string4))
	{
		thread waittill_string(string4, ent);
		ent.threads++;
	}

	if(isdefined(string5))
	{
		thread waittill_string(string5, ent);
		ent.threads++;
	}

	while(ent.threads)
	{
		ent waittill("returned");
		ent.threads--;
	}

	ent notify("die");
}

waittill_multiple_ents(ent1, string1, ent2, string2, ent3, string3, ent4, string4)
{
	self endon("death");
	ent = spawnstruct();
	ent.threads = 0;
	if(isdefined(ent1))
	{
		ent1 thread waittill_string(string1, ent);
		ent.threads++;
	}

	if(isdefined(ent2))
	{
		ent2 thread waittill_string(string2, ent);
		ent.threads++;
	}

	if(isdefined(ent3))
	{
		ent3 thread waittill_string(string3, ent);
		ent.threads++;
	}

	if(isdefined(ent4))
	{
		ent4 thread waittill_string(string4, ent);
		ent.threads++;
	}

	while(ent.threads)
	{
		ent waittill("returned");
		ent.threads--;
	}

	ent notify("die");
}

waittill_any_return(string1, string2, string3, string4, string5)
{
	if((!isdefined(string1) || string1 != "death") && !isdefined(string2) || string2 != "death" && !isdefined(string3) || string3 != "death" && !isdefined(string4) || string4 != "death" && !isdefined(string5) || string5 != "death")
	{
		self endon("death");
	}

	ent = spawnstruct();
	if(isdefined(string1))
	{
		thread waittill_string(string1, ent);
	}

	if(isdefined(string2))
	{
		thread waittill_string(string2, ent);
	}

	if(isdefined(string3))
	{
		thread waittill_string(string3, ent);
	}

	if(isdefined(string4))
	{
		thread waittill_string(string4, ent);
	}

	if(isdefined(string5))
	{
		thread waittill_string(string5, ent);
	}

	ent waittill("returned", msg);
	ent notify("die");
	return msg;
}

waittill_any_timeout(timeout, string1, string2, string3, string4, string5)
{
	if((!isdefined(string1) || string1 != "death") && !isdefined(string2) || string2 != "death" && !isdefined(string3) || string3 != "death" && !isdefined(string4) || string4 != "death" && !isdefined(string5) || string5 != "death")
	{
		self endon("death");
	}

	ent = spawnstruct();
	if(isdefined(string1))
	{
		thread waittill_string(string1, ent);
	}

	if(isdefined(string2))
	{
		thread waittill_string(string2, ent);
	}

	if(isdefined(string3))
	{
		thread waittill_string(string3, ent);
	}

	if(isdefined(string4))
	{
		thread waittill_string(string4, ent);
	}

	if(isdefined(string5))
	{
		thread waittill_string(string5, ent);
	}

	ent thread _timeout(timeout);
	ent waittill("returned", msg);
	ent notify("die");
	return msg;
}

_timeout(delay)
{
	self endon("die");
	wait delay;
	self notify("returned", "timeout");
}

waittill_any(string1, string2, string3, string4, string5, string6, string7, string8)
{
	if(isdefined(string2))
	{
		self endon(string2);
	}

	if(isdefined(string3))
	{
		self endon(string3);
	}

	if(isdefined(string4))
	{
		self endon(string4);
	}

	if(isdefined(string5))
	{
		self endon(string5);
	}

	if(isdefined(string6))
	{
		self endon(string6);
	}

	if(isdefined(string7))
	{
		self endon(string7);
	}

	if(isdefined(string8))
	{
		self endon(string8);
	}

	self waittill(string1);
}

waittill_any_ents(ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7)
{
	if(isdefined(ent2) && isdefined(string2))
	{
		ent2 endon(string2);
	}

	if(isdefined(ent3) && isdefined(string3))
	{
		ent3 endon(string3);
	}

	if(isdefined(ent4) && isdefined(string4))
	{
		ent4 endon(string4);
	}

	if(isdefined(ent5) && isdefined(string5))
	{
		ent5 endon(string5);
	}

	if(isdefined(ent6) && isdefined(string6))
	{
		ent6 endon(string6);
	}

	if(isdefined(ent7) && isdefined(string7))
	{
		ent7 endon(string7);
	}

	ent1 waittill(string1);
}

isflashed()
{
	if(!isdefined(self.flashendtime))
	{
		return 0;
	}

	return gettime() < self.flashendtime;
}

flag_exist(message)
{
	return isdefined(level.flag[message]);
}

flag(message)
{
	return level.flag[message];
}

init_flags()
{
	level.flag = [];
	level.flags_lock = [];
	level.generic_index = 0;
	if(!isdefined(level.sp_stat_tracking_func))
	{
		level.sp_stat_tracking_func = ::empty_init_func;
	}

	level.flag_struct = spawnstruct();
	level.flag_struct assign_unique_id();
}

flag_init(message)
{
	if(!isdefined(level.flag))
	{
		init_flags();
	}

	level.flag[message] = 0;
	if(!isdefined(level.trigger_flags))
	{
		init_trigger_flags();
		level.trigger_flags[message] = [];
	}
	else if(!isdefined(level.trigger_flags[message]))
	{
		level.trigger_flags[message] = [];
	}

	if(issuffix(message, "aa_"))
	{
		thread [[ level.sp_stat_tracking_func ]](message);
		return;
	}
}

empty_init_func(param_165)
{
}

issuffix(msg, suffix)
{
	if(suffix.size > msg.size)
	{
		return 0;
	}

	for(i = 0;i < suffix.size;i++)
	{
		if(msg[i] != suffix[i])
		{
			return 0;
		}
	}

	return 1;
}

flag_set(message, setter)
{
	level.flag[message] = 1;
	set_trigger_flag_permissions(message);
	if(isdefined(setter))
	{
		level notify(message, setter);
		return;
	}

	level notify(message);
}

assign_unique_id()
{
	self.unique_id = "generic" + level.generic_index;
	level.generic_index++;
}

flag_wait(msg, entity)
{
	other = undefined;
	while(!flag(msg))
	{
		other = undefined;
		level waittill(msg, other);
		if(isdefined(entity) && flag(msg, entity))
		{
			break;
		}
	}

	if(isdefined(other))
	{
		return other;
	}
}

flag_clear(message)
{
	if(!flag(message))
	{
		return;
	}

	level.flag[message] = 0;
	set_trigger_flag_permissions(message);
	level notify(message);
}

flag_waitopen(msg)
{
	while(flag(msg))
	{
		level waittill(msg);
	}
}

waittill_either(msg1, msg2)
{
	self endon(msg1);
	self waittill(msg2);
}

array_thread(entities, process, var1, var2, var3, var4, var5, param_172, param_173, param_174, param_175)
{
	if(!isdefined(var1))
	{
		foreach(ent in entities)
		{
			ent thread [[ process ]]();
		}

		return;
	}

	if(!isdefined(var2))
	{
		foreach(ent in entities)
		{
			ent thread [[ process ]](var1);
		}

		return;
	}

	if(!isdefined(var3))
	{
		foreach(ent in entities)
		{
			ent thread [[ process ]](var1, var2);
		}

		return;
	}

	if(!isdefined(var4))
	{
		foreach(ent in entities)
		{
			ent thread [[ process ]](var1, var2, var3);
		}

		return;
	}

	if(!isdefined(var5))
	{
		foreach(ent in entities)
		{
			ent thread [[ process ]](var1, var2, var3, var4);
		}

		return;
	}

	if(!isdefined(param_172))
	{
		foreach(ent in entities)
		{
			ent thread [[ process ]](var1, var2, var3, var4, var5);
		}

		return;
	}

	if(!isdefined(param_173))
	{
		foreach(ent in entities)
		{
			ent thread [[ process ]](var1, var2, var3, var4, var5, param_172);
		}

		return;
	}

	if(!isdefined(param_174))
	{
		foreach(ent in entities)
		{
			ent thread [[ process ]](var1, var2, var3, var4, var5, param_172, param_173);
		}

		return;
	}

	if(!isdefined(param_175))
	{
		foreach(ent in entities)
		{
			ent thread [[ process ]](var1, var2, var3, var4, var5, param_172, param_173, param_174);
		}

		return;
	}

	foreach(ent in entities)
	{
		ent thread [[ process ]](var1, var2, var3, var4, var5, param_172, param_173, param_174, param_175);
	}
}

array_call(entities, process, var1, var2, var3)
{
	if(isdefined(var3))
	{
		foreach(ent in entities)
		{
			ent [[ process ]](var1, var2, var3);
		}

		return;
	}

	if(isdefined(var2))
	{
		foreach(ent in entities)
		{
			ent [[ process ]](var1, var2);
		}

		return;
	}

	if(isdefined(var1))
	{
		foreach(ent in entities)
		{
			ent [[ process ]](var1);
		}

		return;
	}

	foreach(ent in entities)
	{
		ent [[ process ]]();
	}
}

array_thread4(entities, process, var1, var2, var3, var4)
{
	array_thread(entities, process, var1, var2, var3, var4);
}

array_thread5(entities, process, var1, var2, var3, var4, var5)
{
	array_thread(entities, process, var1, var2, var3, var4, var5);
}

remove_undefined_from_array(array)
{
	newarray = [];
	for(i = 0;i < array.size;i++)
	{
		if(!isdefined(array[i]))
		{
			continue;
		}

		newarray[newarray.size] = array[i];
	}

	return newarray;
}

trigger_on(name, type)
{
	if(isdefined(name) && isdefined(type))
	{
		ents = getentarray(name, type);
		array_thread(ents, ::trigger_on_proc);
		return;
	}

	trigger_on_proc();
}

trigger_on_proc()
{
	if(isdefined(self.realorigin))
	{
		self.origin = self.realorigin;
	}

	self.trigger_off = undefined;
}

trigger_off(name, type)
{
	if(isdefined(name) && isdefined(type))
	{
		ents = getentarray(name, type);
		array_thread(ents, ::trigger_off_proc);
		return;
	}

	trigger_off_proc();
}

trigger_off_proc()
{
	if(!isdefined(self.realorigin))
	{
		self.realorigin = self.origin;
	}

	if(self.origin == self.realorigin)
	{
		self.origin = self.origin + (0,0,-10000);
	}

	self.trigger_off = 1;
}

set_trigger_flag_permissions(msg)
{
	if(!isdefined(level.trigger_flags))
	{
		return;
	}

	level.trigger_flags[msg] = remove_undefined_from_array(level.trigger_flags[msg]);
	array_thread(level.trigger_flags[msg], ::update_trigger_based_on_flags);
}

update_trigger_based_on_flags()
{
	true_on = 1;
	if(isdefined(self.script_flag_true))
	{
		true_on = 0;
		tokens = create_flags_and_return_tokens(self.script_flag_true);
		foreach(token in tokens)
		{
			if(flag(token))
			{
				true_on = 1;
				break;
			}
		}
	}

	false_on = 1;
	if(isdefined(self.script_flag_false))
	{
		tokens = create_flags_and_return_tokens(self.script_flag_false);
		foreach(token in tokens)
		{
			if(flag(token))
			{
				false_on = 0;
				break;
			}
		}
	}

	[[ level.trigger_func[true_on && false_on] ]]();
}

create_flags_and_return_tokens(flags)
{
	tokens = strtok(flags, " ");
	for(i = 0;i < tokens.size;i++)
	{
		if(!isdefined(level.flag[tokens[i]]))
		{
			flag_init(tokens[i]);
		}
	}

	return tokens;
}

init_trigger_flags()
{
	level.trigger_flags = [];
	level.trigger_func[1] = ::trigger_on;
	level.trigger_func[0] = ::trigger_off;
}

getstruct(name, type)
{
	array = level.struct_class_names[type][name];
	if(!isdefined(array))
	{
		return undefined;
	}

	if(array.size > 1)
	{
		return undefined;
	}

	return array[0];
}

getstructarray(name, type)
{
	array = level.struct_class_names[type][name];
	if(!isdefined(array))
	{
		return [];
	}

	return array;
}

struct_class_init()
{
	level.struct_class_names = [];
	level.struct_class_names["target"] = [];
	level.struct_class_names["targetname"] = [];
	level.struct_class_names["script_noteworthy"] = [];
	level.struct_class_names["script_linkname"] = [];
	foreach(struct in level.struct)
	{
		if(isdefined(struct.targetname))
		{
			if(!isdefined(level.struct_class_names["targetname"][struct.targetname]))
			{
				level.struct_class_names["targetname"][struct.targetname] = [];
			}

			size = level.struct_class_names["targetname"][struct.targetname].size;
			level.struct_class_names["targetname"][struct.targetname][size] = struct;
		}

		if(isdefined(struct.target))
		{
			if(!isdefined(level.struct_class_names["target"][struct.target]))
			{
				level.struct_class_names["target"][struct.target] = [];
			}

			size = level.struct_class_names["target"][struct.target].size;
			level.struct_class_names["target"][struct.target][size] = struct;
		}

		if(isdefined(struct.script_noteworthy))
		{
			if(!isdefined(level.struct_class_names["script_noteworthy"][struct.script_noteworthy]))
			{
				level.struct_class_names["script_noteworthy"][struct.script_noteworthy] = [];
			}

			size = level.struct_class_names["script_noteworthy"][struct.script_noteworthy].size;
			level.struct_class_names["script_noteworthy"][struct.script_noteworthy][size] = struct;
		}

		if(isdefined(struct.script_linkname))
		{
			level.struct_class_names["script_linkname"][struct.script_linkname][0] = struct;
		}
	}
}

fileprint_start(param_18D)
{
}

fileprint_map_start()
{
}

fileprint_map_header(binclude_blank_worldspawn)
{
	if(!isdefined(binclude_blank_worldspawn))
	{
		binclude_blank_worldspawn = 0;
		return;
	}
}

fileprint_map_keypairprint(param_18F, param_190)
{
}

fileprint_map_entity_start()
{
}

fileprint_map_entity_end()
{
}

fileprint_radiant_vec(vector)
{
}

vector_multiply(vec, dif)
{
	vec = (vec[0] * dif,vec[1] * dif,vec[2] * dif);
	return vec;
}

array_remove(ents, remover)
{
	newents = [];
	foreach(index in ents)
	{
		if(index != remover)
		{
			newents[newents.size] = index;
		}
	}

	return newents;
}

array_remove_array(ents, remover_array)
{
	foreach(remover in remover_array)
	{
		ents = array_remove(ents, remover);
	}

	return ents;
}

array_removeundefined(array)
{
	newarray = [];
	for(i = 0;i < array.size;i++)
	{
		if(!isdefined(array[i]))
		{
			continue;
		}

		newarray[newarray.size] = array[i];
	}

	return newarray;
}

array_levelthread(array, process, var1, var2, var3)
{
	if(isdefined(var3))
	{
		foreach(ent in array)
		{
			thread [[ process ]](ent, var1, var2, var3);
		}

		return;
	}

	if(isdefined(var2))
	{
		foreach(ent in array)
		{
			thread [[ process ]](ent, var1, var2);
		}

		return;
	}

	if(isdefined(var1))
	{
		foreach(ent in array)
		{
			thread [[ process ]](ent, var1);
		}

		return;
	}

	foreach(ent in array)
	{
		thread [[ process ]](ent);
	}
}

array_levelcall(array, process, var1, var2, var3)
{
	if(isdefined(var3))
	{
		foreach(ent in array)
		{
			[[ process ]](ent, var1, var2, var3);
		}

		return;
	}

	if(isdefined(var2))
	{
		foreach(ent in array)
		{
			[[ process ]](ent, var1, var2);
		}

		return;
	}

	if(isdefined(var1))
	{
		foreach(ent in array)
		{
			[[ process ]](ent, var1);
		}

		return;
	}

	foreach(ent in array)
	{
		[[ process ]](ent);
	}
}

add_to_array(array, ent)
{
	if(!isdefined(ent))
	{
		return array;
	}

	if(!isdefined(array))
	{
		array[0] = ent;
	}
	else
	{
		array[array.size] = ent;
	}

	return array;
}

flag_assert(msg)
{
}

flag_wait_either(flag1, flag2)
{
	for(;;)
	{
		if(flag(flag1))
		{
			return;
		}

		if(flag(flag2))
		{
			return;
		}

		level waittill_either(flag1, flag2);
	}
}

flag_wait_either_return(flag1, flag2)
{
	for(;;)
	{
		if(flag(flag1))
		{
			return flag1;
		}

		if(flag(flag2))
		{
			return flag2;
		}

		msg = level waittill_any_return(flag1, flag2);
		return msg;
	}
}

flag_wait_any(flag1, flag2, flag3, flag4, flag5, flag6)
{
	array = [];
	if(isdefined(flag6))
	{
		array[array.size] = flag1;
		array[array.size] = flag2;
		array[array.size] = flag3;
		array[array.size] = flag4;
		array[array.size] = flag5;
		array[array.size] = flag6;
	}
	else if(isdefined(flag5))
	{
		array[array.size] = flag1;
		array[array.size] = flag2;
		array[array.size] = flag3;
		array[array.size] = flag4;
		array[array.size] = flag5;
	}
	else if(isdefined(flag4))
	{
		array[array.size] = flag1;
		array[array.size] = flag2;
		array[array.size] = flag3;
		array[array.size] = flag4;
	}
	else if(isdefined(flag3))
	{
		array[array.size] = flag1;
		array[array.size] = flag2;
		array[array.size] = flag3;
	}
	else if(isdefined(flag2))
	{
		flag_wait_either(flag1, flag2);
		return;
	}

	for(;;)
	{
		for(i = 0;i < array.size;i++)
		{
			if(flag(array[i]))
			{
				return;
			}
		}

		level waittill_any(flag1, flag2, flag3, flag4, flag5, flag6);
	}
}

flag_wait_any_return(flag1, flag2, flag3, flag4, flag5, flag6)
{
	array = [];
	if(isdefined(flag6))
	{
		array[array.size] = flag1;
		array[array.size] = flag2;
		array[array.size] = flag3;
		array[array.size] = flag4;
		array[array.size] = flag5;
		array[array.size] = flag6;
	}
	else if(isdefined(flag5))
	{
		array[array.size] = flag1;
		array[array.size] = flag2;
		array[array.size] = flag3;
		array[array.size] = flag4;
		array[array.size] = flag5;
	}
	else if(isdefined(flag4))
	{
		array[array.size] = flag1;
		array[array.size] = flag2;
		array[array.size] = flag3;
		array[array.size] = flag4;
	}
	else if(isdefined(flag3))
	{
		array[array.size] = flag1;
		array[array.size] = flag2;
		array[array.size] = flag3;
	}
	else if(isdefined(flag2))
	{
		msg = flag_wait_either_return(flag1, flag2);
		return msg;
	}
	else
	{
		return;
	}

	for(;;)
	{
		for(i = 0;i < array.size;i++)
		{
			if(flag(array[i]))
			{
				return array[i];
			}
		}

		msg = level waittill_any_return(flag1, flag2, flag3, flag4, flag5, flag6);
		return msg;
	}
}

flag_wait_all(flag1, flag2, flag3, flag4)
{
	if(isdefined(flag1))
	{
		flag_wait(flag1);
	}

	if(isdefined(flag2))
	{
		flag_wait(flag2);
	}

	if(isdefined(flag3))
	{
		flag_wait(flag3);
	}

	if(isdefined(flag4))
	{
		flag_wait(flag4);
		return;
	}
}

flag_wait_or_timeout(flagname, timer)
{
	timerms = timer * 1000;
	start_time = gettime();
	for(;;)
	{
		if(flag(flagname))
		{
			break;
		}

		if(gettime() >= start_time + timerms)
		{
			break;
		}

		timeremaining = timerms - gettime() - start_time;
		timeremainingsecs = timeremaining / 1000;
		wait_for_flag_or_time_elapses(flagname, timeremainingsecs);
	}
}

flag_waitopen_or_timeout(flagname, timer)
{
	start_time = gettime();
	for(;;)
	{
		if(!flag(flagname))
		{
			break;
		}

		if(gettime() >= start_time + timer * 1000)
		{
			break;
		}

		wait_for_flag_or_time_elapses(flagname, timer);
	}
}

wait_for_flag_or_time_elapses(flagname, timer)
{
	level endon(flagname);
	wait timer;
}

delaycall(timer, func, param1, param2, param3, param4)
{
	thread delaycall_proc(func, timer, param1, param2, param3, param4);
}

delaycall_proc(func, timer, param1, param2, param3, param4)
{
	if(issp())
	{
		self endon("death");
	}

	wait timer;
	if(isdefined(param4))
	{
		self [[ func ]](param1, param2, param3, param4);
		return;
	}

	if(isdefined(param3))
	{
		self [[ func ]](param1, param2, param3);
		return;
	}

	if(isdefined(param2))
	{
		self [[ func ]](param1, param2);
		return;
	}

	if(isdefined(param1))
	{
		self [[ func ]](param1);
		return;
	}

	self [[ func ]]();
}

noself_delaycall(timer, func, param1, param2, param3, param4)
{
	thread noself_delaycall_proc(func, timer, param1, param2, param3, param4);
}

noself_delaycall_proc(func, timer, param1, param2, param3, param4)
{
	wait timer;
	if(isdefined(param4))
	{
		[[ func ]](param1, param2, param3, param4);
		return;
	}

	if(isdefined(param3))
	{
		[[ func ]](param1, param2, param3);
		return;
	}

	if(isdefined(param2))
	{
		[[ func ]](param1, param2);
		return;
	}

	if(isdefined(param1))
	{
		[[ func ]](param1);
		return;
	}

	[[ func ]]();
}

issp()
{
	if(!isdefined(level.issp))
	{
		level.issp = !string_starts_with(getdvar("mapname"), "mp_");
	}

	return level.issp;
}

string_starts_with(string, start)
{
	if(string.size < start.size)
	{
		return 0;
	}

	for(i = 0;i < start.size;i++)
	{
		if(tolower(string[i]) != tolower(start[i]))
		{
			return 0;
		}
	}

	return 1;
}

plot_points(plotpoints, r, g, b, timer)
{
	lastpoint = plotpoints[0];
	if(!isdefined(r))
	{
		r = 1;
	}

	if(!isdefined(g))
	{
		g = 1;
	}

	if(!isdefined(b))
	{
		b = 1;
	}

	if(!isdefined(timer))
	{
		timer = 0.05;
	}

	for(i = 1;i < plotpoints.size;i++)
	{
		thread draw_line_for_time(lastpoint, plotpoints[i], r, g, b, timer);
		lastpoint = plotpoints[i];
	}
}

draw_line_for_time(org1, org2, r, g, b, timer)
{
	timer = gettime() + timer * 1000;
	while(gettime() < timer)
	{
		wait 0.05;
	}
}

array_combine(array1, array2)
{
	array3 = [];
	foreach(item in array1)
	{
		array3[array3.size] = item;
	}

	foreach(item in array2)
	{
		array3[array3.size] = item;
	}

	return array3;
}

flat_angle(angle)
{
	rangle = (0,angle[1],0);
	return rangle;
}

flat_origin(org)
{
	rorg = (org[0],org[1],0);
	return rorg;
}

draw_arrow_time(start, end, color, duration)
{
	level endon("newpath");
	pts = [];
	angles = vectortoangles(start - end);
	right = anglestoright(angles);
	forward = anglestoforward(angles);
	up = anglestoup(angles);
	dist = distance(start, end);
	arrow = [];
	range = 0.1;
	arrow[0] = start;
	arrow[1] = start + vector_multiply(right, dist * range) + vector_multiply(forward, dist * -0.1);
	arrow[2] = end;
	arrow[3] = start + vector_multiply(right, dist * -1 * range) + vector_multiply(forward, dist * -0.1);
	arrow[4] = start;
	arrow[5] = start + vector_multiply(up, dist * range) + vector_multiply(forward, dist * -0.1);
	arrow[6] = end;
	arrow[7] = start + vector_multiply(up, dist * -1 * range) + vector_multiply(forward, dist * -0.1);
	arrow[8] = start;
	r = color[0];
	g = color[1];
	b = color[2];
	plot_points(arrow, r, g, b, duration);
}

get_linked_ents()
{
	array = [];
	if(isdefined(self.script_linkto))
	{
		linknames = get_links();
		foreach(name in linknames)
		{
			entities = getentarray(name, "script_linkname");
			if(entities.size > 0)
			{
				array = array_combine(array, entities);
			}
		}
	}

	return array;
}

get_linked_ent()
{
	array = get_linked_ents();
	return array[0];
}

get_links()
{
	return strtok(self.script_linkto, " ");
}

run_thread_on_targetname(msg, func, param1, param2, param3)
{
	array = getentarray(msg, "targetname");
	array_thread(array, func, param1, param2, param3);
	array = getstructarray(msg, "targetname");
	array_thread(array, func, param1, param2, param3);
	array = [[ level.getnodearrayfunction ]](msg, "targetname");
	array_thread(array, func, param1, param2, param3);
	array = getvehiclenodearray(msg, "targetname");
	array_thread(array, func, param1, param2, param3);
}

run_thread_on_noteworthy(msg, func, param1, param2, param3)
{
	array = getentarray(msg, "script_noteworthy");
	array_thread(array, func, param1, param2, param3);
	array = getstructarray(msg, "script_noteworthy");
	array_thread(array, func, param1, param2, param3);
	array = [[ level.getnodearrayfunction ]](msg, "script_noteworthy");
	array_thread(array, func, param1, param2, param3);
	array = getvehiclenodearray(msg, "script_noteworthy");
	array_thread(array, func, param1, param2, param3);
}

draw_arrow(start, end, color)
{
	level endon("newpath");
	pts = [];
	angles = vectortoangles(start - end);
	right = anglestoright(angles);
	forward = anglestoforward(angles);
	dist = distance(start, end);
	arrow = [];
	range = 0.05;
	arrow[0] = start;
	arrow[1] = start + vector_multiply(right, dist * range) + vector_multiply(forward, dist * -0.2);
	arrow[2] = end;
	arrow[3] = start + vector_multiply(right, dist * -1 * range) + vector_multiply(forward, dist * -0.2);
	for(p = 0;p < 4;p++)
	{
		nextpoint = p + 1;
		if(nextpoint >= 4)
		{
			nextpoint = 0;
		}
	}
}

cap_value(value, minvalue, maxvalue)
{
	if(minvalue > maxvalue)
	{
		return cap_value(value, maxvalue, minvalue);
	}

	if(isdefined(minvalue) && value < minvalue)
	{
		return minvalue;
	}

	if(isdefined(maxvalue) && value > maxvalue)
	{
		return maxvalue;
	}

	return value;
}

getfx(fx)
{
	return level._effect[fx];
}

fxexists(fx)
{
	return isdefined(level._effect[fx]);
}

print_csv_asset(asset, type)
{
	fileline = type + "," + asset;
	if(isdefined(level.csv_lines[fileline]))
	{
		return;
	}

	level.csv_lines[fileline] = 1;
}

fileprint_csv_start(param_18D)
{
}

_loadfx(effect)
{
	return loadfx(effect);
}

getlastweapon()
{
	return self.saved_lastweapon;
}

playerunlimitedammothread()
{
}

isusabilityenabled()
{
	return !self.disabledusability;
}

_disableusability()
{
	self.disabledusability++;
	self disableusability();
}

_enableusability()
{
	self.disabledusability--;
	if(!self.disabledusability)
	{
		self enableusability();
		return;
	}
}

resetusability()
{
	self.disabledusability = 0;
	self enableusability();
}

_disableweapon()
{
	self.disabledweapon++;
	self disableweapons();
}

_enableweapon()
{
	self.disabledweapon--;
	if(!self.disabledweapon)
	{
		self enableweapons();
		return;
	}
}

isweaponenabled()
{
	return !self.disabledweapon;
}

_disableweaponswitch()
{
	self.disabledweaponswitch++;
	self disableweaponswitch();
}

_enableweaponswitch()
{
	self.disabledweaponswitch--;
	if(!self.disabledweaponswitch)
	{
		self enableweaponswitch();
		return;
	}
}

isweaponswitchenabled()
{
	return !self.disabledweaponswitch;
}

_disableoffhandweapons()
{
	self.disabledoffhandweapons++;
	self disableoffhandweapons();
}

_enableoffhandweapons()
{
	self.disabledoffhandweapons--;
	if(!self.disabledoffhandweapons)
	{
		self enableoffhandweapons();
		return;
	}
}

isoffhandweaponenabled()
{
	return !self.disabledoffhandweapons;
}

random(array)
{
	newarray = [];
	foreach(value in array)
	{
		newarray[newarray.size] = value;
	}

	if(!newarray.size)
	{
		return undefined;
	}

	return newarray[randomint(newarray.size)];
}

spawn_tag_origin()
{
	tag_origin = spawn("script_model", (0,0,0));
	tag_origin setmodel("tag_origin");
	tag_origin hide();
	if(isdefined(self.origin))
	{
		tag_origin.origin = self.origin;
	}

	if(isdefined(self.angles))
	{
		tag_origin.angles = self.angles;
	}

	return tag_origin;
}

waittill_notify_or_timeout(msg, timer)
{
	self endon(msg);
	wait timer;
}

fileprint_launcher_start_file()
{
	level.fileprintlauncher_linecount = 0;
	level.fileprint_launcher = 1;
	fileprint_launcher("GAMEPRINTSTARTFILE:");
}

fileprint_launcher(string)
{
	level.fileprintlauncher_linecount++;
	if(level.fileprintlauncher_linecount > 200)
	{
		wait 0.05;
		level.fileprintlauncher_linecount = 0;
	}
}

fileprint_launcher_end_file(file_relative_to_game, bisperforceenabled)
{
	if(!isdefined(bisperforceenabled))
	{
		bisperforceenabled = 0;
	}

	if(bisperforceenabled)
	{
		fileprint_launcher("GAMEPRINTENDFILE:GAMEPRINTP4ENABLED:" + file_relative_to_game);
	}
	else
	{
		fileprint_launcher("GAMEPRINTENDFILE:" + file_relative_to_game);
	}

	timeout = gettime() + 4000;
	while(getdvarint("LAUNCHER_PRINT_SUCCESS") == 0 && getdvar("LAUNCHER_PRINT_FAIL") == "0" && gettime() < timeout)
	{
		wait 0.05;
	}

	if(!gettime() < timeout)
	{
		iprintlnbold("LAUNCHER_PRINT_FAIL:( TIMEOUT ): launcherconflict? restart launcher and try again? ");
		level.fileprint_launcher = undefined;
		return 0;
	}

	failvar = getdvar("LAUNCHER_PRINT_FAIL");
	if(failvar != "0")
	{
		iprintlnbold("LAUNCHER_PRINT_FAIL:( " + failvar + " ): launcherconflict? restart launcher and try again? ");
		level.fileprint_launcher = undefined;
		return 0;
	}

	level.fileprint_launcher = undefined;
	return 1;
}

launcher_write_clipboard(str)
{
	level.fileprintlauncher_linecount = 0;
	fileprint_launcher("LAUNCHER_CLIP:" + str);
}

isdestructible()
{
	if(!isdefined(self))
	{
		return 0;
	}

	return isdefined(self.destructible_type);
}

pauseeffect()
{
	common_scripts\_createfx::stop_fx_looper();
}

activate_individual_exploder()
{
	if(isdefined(self.v["firefx"]))
	{
		thread fire_effect();
	}

	if(isdefined(self.v["fxid"]) && self.v["fxid"] != "No FX")
	{
		thread cannon_effect();
	}
	else if(isdefined(self.v["soundalias"]) && self.v["soundalias"] != "nil")
	{
		thread sound_effect();
	}

	if(isdefined(self.v["loopsound"]) && self.v["loopsound"] != "nil")
	{
		thread effect_loopsound();
	}

	if(isdefined(self.v["damage"]))
	{
		thread exploder_damage();
	}

	if(isdefined(self.v["earthquake"]))
	{
		thread exploder_earthquake();
	}

	if(isdefined(self.v["rumble"]))
	{
		thread exploder_rumble();
	}

	if(self.v["exploder_type"] == "exploder")
	{
		thread brush_show();
		return;
	}

	if(self.v["exploder_type"] == "exploderchunk" || self.v["exploder_type"] == "exploderchunk visible")
	{
		thread brush_throw();
		return;
	}

	thread brush_delete();
}

waitframe()
{
	wait 0.05;
}

brush_delete()
{
	num = self.v["exploder"];
	if(isdefined(self.v["delay"]))
	{
		wait self.v["delay"];
	}
	else
	{
		wait 0.05;
	}

	if(!isdefined(self.model))
	{
		return;
	}

	if(issp() && self.model.spawnflags & 1)
	{
		self.model [[ level.connectpathsfunction ]]();
	}

	if(level.createfx_enabled)
	{
		if(isdefined(self.exploded))
		{
			return;
		}

		self.exploded = 1;
		self.model hide();
		self.model notsolid();
		wait 3;
		self.exploded = undefined;
		self.model show();
		self.model solid();
		return;
	}

	if(!isdefined(self.v["fxid"]) || self.v["fxid"] == "No FX")
	{
		self.v["exploder"] = undefined;
	}

	waittillframeend;
	self.model delete();
}

brush_throw()
{
	if(isdefined(self.v["delay"]))
	{
		wait self.v["delay"];
	}

	ent = undefined;
	if(isdefined(self.v["target"]))
	{
		ent = get_target_ent(self.v["target"]);
	}

	if(!isdefined(ent))
	{
		self.model delete();
		return;
	}

	self.model show();
	if(isdefined(self.v["delay_post"]))
	{
		wait self.v["delay_post"];
	}

	startorg = self.v["origin"];
	startang = self.v["angles"];
	org = ent.origin;
	temp_vec = org - self.v["origin"];
	x = temp_vec[0];
	y = temp_vec[1];
	z = temp_vec[2];
	physics = isdefined(self.v["physics"]);
	if(physics)
	{
		target = undefined;
		if(isdefined(ent.target))
		{
			target = ent get_target_ent();
		}

		if(!isdefined(target))
		{
			contact_point = startorg;
			throw_vec = ent.origin;
		}
		else
		{
			contact_point = ent.origin;
			throw_vec = vector_multiply(target.origin - ent.origin, self.v["physics"]);
		}

		self.model physicslaunchclient(contact_point, throw_vec);
		return;
	}

	self.model rotatevelocity((x,y,z), 12);
	self.model movegravity((x,y,z), 12);
	if(level.createfx_enabled)
	{
		if(isdefined(self.exploded))
		{
			return;
		}

		self.exploded = 1;
		wait 3;
		self.exploded = undefined;
		self.v["origin"] = startorg;
		self.v["angles"] = startang;
		self.model hide();
		return;
	}

	self.v["exploder"] = undefined;
	wait 6;
	self.model delete();
}

get_target_ent(target)
{
	if(!isdefined(target))
	{
		target = self.target;
	}

	ent = getent(target, "targetname");
	if(isdefined(ent))
	{
		return ent;
	}

	if(issp())
	{
		ent = [[ level.getnodefunction ]](target, "targetname");
		if(isdefined(ent))
		{
			return ent;
		}
	}

	ent = getstruct(target, "targetname");
	if(isdefined(ent))
	{
		return ent;
	}

	ent = getvehiclenode(target, "targetname");
	if(isdefined(ent))
	{
		return ent;
	}
}

brush_show()
{
	if(isdefined(self.v["delay"]))
	{
		wait self.v["delay"];
	}

	self.model show();
	self.model solid();
	self.brush_shown = 1;
	if(issp() && self.model.spawnflags & 1)
	{
		if(!isdefined(self.model.disconnect_paths))
		{
			self.model [[ level.connectpathsfunction ]]();
		}
		else
		{
			self.model [[ level.disconnectpathsfunction ]]();
		}
	}

	if(level.createfx_enabled)
	{
		if(isdefined(self.exploded))
		{
			return;
		}

		self.exploded = 1;
		wait 3;
		self.exploded = undefined;
		self.model hide();
		self.model notsolid();
		return;
	}
}

exploder_earthquake()
{
	exploder_delay();
	eq = level.earthquake[self.v["earthquake"]];
	earthquake(eq["magnitude"], eq["duration"], self.v["origin"], eq["radius"]);
}

exploder_rumble()
{
	if(!issp())
	{
		return;
	}

	exploder_delay();
	level.player playrumbleonentity(self.v["rumble"]);
}

exploder_delay()
{
	if(!isdefined(self.v["delay"]))
	{
		self.v["delay"] = 0;
	}

	min_delay = self.v["delay"];
	max_delay = self.v["delay"] + 0.001;
	if(isdefined(self.v["delay_min"]))
	{
		min_delay = self.v["delay_min"];
	}

	if(isdefined(self.v["delay_max"]))
	{
		max_delay = self.v["delay_max"];
	}

	if(min_delay > 0)
	{
		wait randomfloatrange(min_delay, max_delay);
		return;
	}
}

exploder_damage()
{
	if(isdefined(self.v["delay"]))
	{
		delay = self.v["delay"];
	}
	else
	{
		delay = 0;
	}

	if(isdefined(self.v["damage_radius"]))
	{
		radius = self.v["damage_radius"];
	}
	else
	{
		radius = 128;
	}

	damage = self.v["damage"];
	origin = self.v["origin"];
	wait delay;
	radiusdamage(origin, radius, damage, damage);
}

effect_loopsound()
{
	if(isdefined(self.loopsound_ent))
	{
		self.loopsound_ent delete();
	}

	origin = self.v["origin"];
	alias = self.v["loopsound"];
	exploder_delay();
	self.loopsound_ent = play_loopsound_in_space(alias, origin);
}

play_loopsound_in_space(alias, origin)
{
	org = spawn("script_origin", (0,0,0));
	if(!isdefined(origin))
	{
		origin = self.origin;
	}

	org.origin = origin;
	org playloopsound(alias, "sounddone");
	return org;
}

sound_effect()
{
	effect_soundalias();
}

effect_soundalias()
{
	origin = self.v["origin"];
	alias = self.v["soundalias"];
	exploder_delay();
	play_sound_in_space(alias, origin);
}

play_sound_in_space(alias, origin, master)
{
	org = spawn("script_origin", (0,0,1));
	if(!isdefined(origin))
	{
		origin = self.origin;
	}

	org.origin = origin;
	if(issp())
	{
		if(isdefined(master) && master)
		{
			org playsoundasmaster(alias, "sounddone");
		}
		else
		{
			org playsound(alias, "sounddone");
		}
	}
	else if(isdefined(master) && master)
	{
		org playsoundasmaster(alias);
	}
	else
	{
		org playsound(alias);
	}

	org waittill("sounddone");
	org delete();
}

cannon_effect()
{
	if(isdefined(self.v["repeat"]))
	{
		thread exploder_playsound();
		for(i = 0;i < self.v["repeat"];i++)
		{
			playfx(level._effect[self.v["fxid"]], self.v["origin"], self.v["forward"], self.v["up"]);
			exploder_delay();
		}

		return;
	}

	exploder_delay();
	if(isdefined(self.looper))
	{
		self.looper delete();
	}

	self.looper = spawnfx(getfx(self.v["fxid"]), self.v["origin"], self.v["forward"], self.v["up"]);
	triggerfx(self.looper);
	exploder_playsound();
}

exploder_playsound()
{
	if(!isdefined(self.v["soundalias"]) || self.v["soundalias"] == "nil")
	{
		return;
	}

	play_sound_in_space(self.v["soundalias"], self.v["origin"]);
}

fire_effect()
{
	forward = self.v["forward"];
	up = self.v["up"];
	org = undefined;
	firefxsound = self.v["firefxsound"];
	origin = self.v["origin"];
	firefx = self.v["firefx"];
	ender = self.v["ender"];
	if(!isdefined(ender))
	{
		ender = "createfx_effectStopper";
	}

	timeout = self.v["firefxtimeout"];
	firefxdelay = 0.5;
	if(isdefined(self.v["firefxdelay"]))
	{
		firefxdelay = self.v["firefxdelay"];
	}

	exploder_delay();
	if(isdefined(firefxsound))
	{
		level thread loop_fx_sound(firefxsound, origin, ender, timeout);
	}

	playfx(level._effect[firefx], self.v["origin"], forward, up);
}

loop_fx_sound(alias, origin, ender, timeout)
{
	org = spawn("script_origin", (0,0,0));
	if(isdefined(ender))
	{
		thread loop_sound_delete(ender, org);
		self endon(ender);
	}

	org.origin = origin;
	org playloopsound(alias);
	if(!isdefined(timeout))
	{
		org willneverchange();
		return;
	}

	wait timeout;
}

loop_sound_delete(ender, ent)
{
	ent endon("death");
	self waittill(ender);
	ent delete();
}

exploder_before_load(num)
{
	waittillframeend;
	waittillframeend;
	activate_exploder(num);
}

exploder_after_load(num)
{
	activate_exploder(num);
}

activate_exploder(num)
{
	num = num + "";
	level notify("exploding_" + num);
	for(i = 0;i < level.createfxent.size;i++)
	{
		ent = level.createfxent[i];
		if(!isdefined(ent))
		{
			continue;
		}

		if(ent.v["type"] != "exploder")
		{
			continue;
		}

		if(!isdefined(ent.v["exploder"]))
		{
			continue;
		}

		if(ent.v["exploder"] + "" != num)
		{
			continue;
		}

		ent activate_individual_exploder();
	}
}

createloopeffect(fxid)
{
	ent = common_scripts\_createfx::createeffect("loopfx", fxid);
	ent.v["delay"] = 0.5;
	return ent;
}

createoneshoteffect(fxid)
{
	ent = common_scripts\_createfx::createeffect("oneshotfx", fxid);
	ent.v["delay"] = -15;
	return ent;
}

createexploder(fxid)
{
	ent = common_scripts\_createfx::createeffect("exploder", fxid);
	ent.v["delay"] = 0;
	ent.v["exploder_type"] = "normal";
	return ent;
}

alphabetize(array)
{
	if(array.size <= 1)
	{
		return array;
	}

	addwaits = 0;
	if(issp())
	{
		addwaits = 1;
	}

	count = 0;
	for(;;)
	{
		changed = 0;
		for(i = 0;i < array.size - 1;i++)
		{
			if(is_later_in_alphabet(array[i], array[i + 1]))
			{
				val = array[i];
				array[i] = array[i + 1];
				array[i + 1] = val;
				changed = 1;
				if(addwaits)
				{
					count++;
					if(count >= 10)
					{
						count = 0;
						waitframe();
					}
				}
			}
		}

		if(!changed)
		{
			return array;
		}
	}

	return array;
}

is_later_in_alphabet(string1, string2)
{
	count = string1.size;
	if(count >= string2.size)
	{
		count = string2.size;
	}

	for(i = 0;i < count;i++)
	{
		val = alphabet_compare(string1[i], string2[i]);
		if(val == "1st")
		{
			return 1;
		}

		if(val == "2nd")
		{
			return 0;
		}
	}

	return string1.size > string2.size;
}

alphabet_compare(a, b)
{
	list = [];
	val = 1;
	list["0"] = val;
	val++;
	list["1"] = val;
	val++;
	list["2"] = val;
	val++;
	list["3"] = val;
	val++;
	list["4"] = val;
	val++;
	list["5"] = val;
	val++;
	list["6"] = val;
	val++;
	list["7"] = val;
	val++;
	list["8"] = val;
	val++;
	list["9"] = val;
	val++;
	list["_"] = val;
	val++;
	list["a"] = val;
	val++;
	list["b"] = val;
	val++;
	list["c"] = val;
	val++;
	list["d"] = val;
	val++;
	list["e"] = val;
	val++;
	list["f"] = val;
	val++;
	list["g"] = val;
	val++;
	list["h"] = val;
	val++;
	list["i"] = val;
	val++;
	list["j"] = val;
	val++;
	list["k"] = val;
	val++;
	list["l"] = val;
	val++;
	list["m"] = val;
	val++;
	list["n"] = val;
	val++;
	list["o"] = val;
	val++;
	list["p"] = val;
	val++;
	list["q"] = val;
	val++;
	list["r"] = val;
	val++;
	list["s"] = val;
	val++;
	list["t"] = val;
	val++;
	list["u"] = val;
	val++;
	list["v"] = val;
	val++;
	list["w"] = val;
	val++;
	list["x"] = val;
	val++;
	list["y"] = val;
	val++;
	list["z"] = val;
	val++;
	a = tolower(a);
	b = tolower(b);
	val1 = 0;
	if(isdefined(list[a]))
	{
		val1 = list[a];
	}

	val2 = 0;
	if(isdefined(list[b]))
	{
		val2 = list[b];
	}

	if(val1 > val2)
	{
		return "1st";
	}

	if(val1 < val2)
	{
		return "2nd";
	}

	return "same";
}

play_loop_sound_on_entity(alias, offset)
{
	org = spawn("script_origin", (0,0,0));
	org endon("death");
	thread delete_on_death(org);
	if(isdefined(offset))
	{
		org.origin = self.origin + offset;
		org.angles = self.angles;
		org linkto(self);
	}
	else
	{
		org.origin = self.origin;
		org.angles = self.angles;
		org linkto(self);
	}

	org playloopsound(alias);
	self waittill("stop sound" + alias);
	org stoploopsound(alias);
	org delete();
}

stop_loop_sound_on_entity(alias)
{
	self notify("stop sound" + alias);
}

delete_on_death(ent)
{
	ent endon("death");
	self waittill("death");
	if(isdefined(ent))
	{
		ent delete();
		return;
	}
}

error(msg)
{
	waitframe();
}

exploder(num)
{
	[[ level.exploderfunction ]](num);
}

create_dvar(var, val)
{
	setdvarifuninitialized(var, val);
}

void()
{
}