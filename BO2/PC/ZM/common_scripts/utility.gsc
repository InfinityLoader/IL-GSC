/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: common_scripts\utility.gsc
 * Game: Call of Duty: Black Ops 2
 * Platform: PC
 * Function Count: 124
 * Decompile Time: 197 ms
 * Timestamp: 10/27/2023 3:02:00 AM
*******************************************************************/

//Function Number: 1
init_session_mode_flags()
{
	level.gamemode_public_match = 0;
	level.gamemode_private_match = 1;
	level.gamemode_local_splitscreen = 2;
	level.gamemode_wager_match = 3;
	level.gamemode_theater = 5;
	level.gamemode_league_match = 6;
	level.gamemode_rts = 7;
	level.language = GetDvar(#"5A6B41C9");
}

//Function Number: 2
empty(a,b,c,d,e)
{
}

//Function Number: 3
add_to_array(array,item,allow_dupes)
{
	if(!(IsDefined(item)))
	{
		return array;
	}

	if(!(IsDefined(allow_dupes)))
	{
		allow_dupes = 1;
	}

	if(!(IsDefined(array)))
	{
		array[0] = item;
	}
	else if(allow_dupes || !isinarray(array,item))
	{
		array[array.size] = item;
	}

	return array;
}

//Function Number: 4
array_copy(array)
{
	a_copy = [];
	foreach(elem in array)
	{
		a_copy[a_copy.size] = elem;
	}

	return a_copy;
}

//Function Number: 5
array_delete(array,is_struct)
{
	foreach(ent in array)
	{
		if(IsDefined(is_struct) && is_struct)
		{
			ent structdelete();
			ent = undefined;
		}
		else if(IsDefined(ent))
		{
			ent delete();
		}
	}
}

//Function Number: 6
array_randomize(array)
{
	for(i = 0;i < array.size;i++)
	{
		j = randomint(array.size);
		temp = array[i];
		array[i] = array[j];
		array[j] = temp;
	}

	return array;
}

//Function Number: 7
array_reverse(array)
{
	array2 = [];
	for(i = array.size - 1;i >= 0;i--)
	{
		array2[array2.size] = array[i];
	}

	return array2;
}

//Function Number: 8
array_exclude(array,arrayexclude)
{
	newarray = array;
	if(isarray(arrayexclude))
	{
		for(i = 0;i < arrayexclude.size;i++)
		{
			arrayremovevalue(newarray,arrayexclude[i]);
		}
	}
	else
	{
		arrayremovevalue(newarray,arrayexclude);
	}

	return newarray;
}

//Function Number: 9
array_notify(ents,notifier)
{
	for(i = 0;i < ents.size;i++)
	{
		ents[i] notify(notifier);
	}
}

//Function Number: 10
array_wait(array,msg,timeout)
{
	keys = getarraykeys(array);
	structs = [];
	for(i = 0;i < keys.size;i++)
	{
		key = keys[i];
		structs[key] = spawnstruct();
		structs[key]._array_wait = 1;
		structs[key] thread array_waitlogic1(array[key],msg,timeout);
	}

	for(i = 0;i < keys.size;i++)
	{
		key = keys[i];
		if(IsDefined(array[key]) && structs[key]._array_wait)
		{
			structs[key] waittill("_array_wait");
		}
	}
}

//Function Number: 11
array_wait_any(array,msg,timeout)
{
	if(array.size == 0)
	{
		return undefined;
	}

	keys = getarraykeys(array);
	structs = [];
	internal_msg = msg + "array_wait";
	for(i = 0;i < keys.size;i++)
	{
		key = keys[i];
		structs[key] = spawnstruct();
		structs[key]._array_wait = 1;
		structs[key] thread array_waitlogic3(array[key],msg,internal_msg,timeout);
	}

	level waittill(internal_msg,ent);
	return ent;
}

//Function Number: 12
array_waitlogic1(ent,msg,timeout)
{
	self array_waitlogic2(ent,msg,timeout);
	self._array_wait = 0;
	self notify("_array_wait");
}

//Function Number: 13
array_waitlogic2(ent,msg,timeout)
{
	ent endon(msg);
	ent endon("death");
	if(IsDefined(timeout))
	{
		wait(timeout);
	}
	else
	{
		ent waittill(msg);
	}
}

//Function Number: 14
array_waitlogic3(ent,msg,internal_msg,timeout)
{
	if(msg != "death")
	{
		ent endon("death");
	}

	level endon(internal_msg);
	self array_waitlogic2(ent,msg,timeout);
	level notify(internal_msg,ent);
}

//Function Number: 15
array_check_for_dupes(array,single)
{
	for(i = 0;i < array.size;i++)
	{
		if(array[i] == single)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 16
array_swap(array,index1,index2)
{
/#
	assert(index1 < array.size,"index1 to swap out of range");
#/
/#
	assert(index2 < array.size,"index2 to swap out of range");
#/
	temp = array[index1];
	array[index1] = array[index2];
	array[index2] = temp;
	return array;
}

//Function Number: 17
array_average(array)
{
/#
	assert(isarray(array));
#/
/#
	assert(array.size > 0);
#/
	total = 0;
	for(i = 0;i < array.size;i++)
	{
		total = total + array[i];
	}

	return total / array.size;
}

//Function Number: 18
array_std_deviation(array,mean)
{
/#
	assert(isarray(array));
#/
/#
	assert(array.size > 0);
#/
	tmp = [];
	for(i = 0;i < array.size;i++)
	{
		tmp[i] = array[i] - mean * array[i] - mean;
	}

	total = 0;
	for(i = 0;i < tmp.size;i++)
	{
		total = total + tmp[i];
	}

	return sqrt(total / array.size);
}

//Function Number: 19
random_normal_distribution(mean,std_deviation,lower_bound,upper_bound)
{
	x1 = 0;
	x2 = 0;
	w = 1;
	y1 = 0;
	while(w >= 1)
	{
		x1 = 2 * randomfloatrange(0,1) - 1;
		x2 = 2 * randomfloatrange(0,1) - 1;
		w = x1 * x1 + x2 * x2;
	}

	w = sqrt(-2 * log(w) / w);
	y1 = x1 * w;
	number = mean + y1 * std_deviation;
	if(IsDefined(lower_bound) && number < lower_bound)
	{
		number = lower_bound;
	}

	if(IsDefined(upper_bound) && number > upper_bound)
	{
		number = upper_bound;
	}

	return number;
}

//Function Number: 20
random(array)
{
	keys = getarraykeys(array);
	return array[keys[randomint(keys.size)]];
}

//Function Number: 21
get_players(str_team)
{
	if(IsDefined(str_team))
	{
		return getplayers(str_team);
	}
	else
	{
		return getplayers();
	}
}

//Function Number: 22
is_prefix(msg,prefix)
{
	if(prefix.size > msg.size)
	{
		return 0;
	}

	for(i = 0;i < prefix.size;i++)
	{
		if(msg[i] != prefix[i])
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 23
is_suffix(msg,suffix)
{
	if(suffix.size > msg.size)
	{
		return 0;
	}

	for(i = 0;i < suffix.size;i++)
	{
		if(msg[msg.size - 1 - i] != suffix[suffix.size - 1 - i])
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 24
vector_compare(vec1,vec2)
{
	return Abs(vec1[0] - vec2[0]) < 0.001 && Abs(vec1[1] - vec2[1]) < 0.001 && Abs(vec1[2] - vec2[2]) < 0.001;
}

//Function Number: 25
draw_debug_line(start,end,timer)
{
/#
	i = 0;
	for(;;)
	{
		line(start,end,(1,1,0.5));
		wait(0.05);
		i++;
	}
i < timer * 20
#/
}

//Function Number: 26
waittillend(msg)
{
	self waittillmatch
	return msg;
}

//Function Number: 27
random_vector(max_length)
{
	return (randomfloatrange(-1 * max_length,max_length),randomfloatrange(-1 * max_length,max_length),randomfloatrange(-1 * max_length,max_length));
}

//Function Number: 28
angle_dif(oldangle,newangle)
{
	outvalue = oldangle - newangle % 360;
	if(outvalue < 0)
	{
		outvalue = outvalue + 360;
	}

	if(outvalue > 180)
	{
		outvalue = outvalue - 360 * -1;
	}

	return outvalue;
}

//Function Number: 29
sign(x)
{
	if(x >= 0)
	{
		return 1;
	}

	return -1;
}

//Function Number: 30
track(spot_to_track)
{
	if(IsDefined(self.current_target))
	{
		if(spot_to_track == self.current_target)
		{
			return;
		}
	}

	self.current_target = spot_to_track;
}

//Function Number: 31
clear_exception(type)
{
/#
	assert(IsDefined(self.exception[type]));
#/
	self.exception[type] = anim.defaultexception;
}

//Function Number: 32
set_exception(type,func)
{
/#
	assert(IsDefined(self.exception[type]));
#/
	self.exception[type] = func;
}

//Function Number: 33
set_all_exceptions(exceptionfunc)
{
	keys = getarraykeys(self.exception);
	for(i = 0;i < keys.size;i++)
	{
		self.exception[keys[i]] = exceptionfunc;
	}
}

//Function Number: 34
cointoss()
{
	return randomint(100) >= 50;
}

//Function Number: 35
waittill_string(msg,ent)
{
	if(msg != "death")
	{
		self endon("death");
	}

	ent endon("die");
	self waittill(msg);
	ent notify("returned",msg);
}

//Function Number: 36
waittill_multiple(string1,string2,string3,string4,string5)
{
	self endon("death");
	ent = spawnstruct();
	ent.threads = 0;
	if(IsDefined(string1))
	{
		self thread waittill_string(string1,ent);
		ent.threads++;
	}

	if(IsDefined(string2))
	{
		self thread waittill_string(string2,ent);
		ent.threads++;
	}

	if(IsDefined(string3))
	{
		self thread waittill_string(string3,ent);
		ent.threads++;
	}

	if(IsDefined(string4))
	{
		self thread waittill_string(string4,ent);
		ent.threads++;
	}

	if(IsDefined(string5))
	{
		self thread waittill_string(string5,ent);
		ent.threads++;
	}

	while(ent.threads)
	{
		ent waittill("returned");
		ent.threads--;
	}

	ent notify("die");
}

//Function Number: 37
waittill_multiple_ents(ent1,string1,ent2,string2,ent3,string3,ent4,string4)
{
	self endon("death");
	ent = spawnstruct();
	ent.threads = 0;
	if(IsDefined(ent1))
	{
/#
		assert(IsDefined(string1));
#/
		ent1 thread waittill_string(string1,ent);
		ent.threads++;
	}

	if(IsDefined(ent2))
	{
/#
		assert(IsDefined(string2));
#/
		ent2 thread waittill_string(string2,ent);
		ent.threads++;
	}

	if(IsDefined(ent3))
	{
/#
		assert(IsDefined(string3));
#/
		ent3 thread waittill_string(string3,ent);
		ent.threads++;
	}

	if(IsDefined(ent4))
	{
/#
		assert(IsDefined(string4));
#/
		ent4 thread waittill_string(string4,ent);
		ent.threads++;
	}

	while(ent.threads)
	{
		ent waittill("returned");
		ent.threads--;
	}

	ent notify("die");
}

//Function Number: 38
waittill_any_return(string1,string2,string3,string4,string5,string6,string7)
{
	if((!IsDefined(string1) || string1 != "death") && (!IsDefined(string2) || string2 != "death") && (!IsDefined(string3) || string3 != "death") && (!IsDefined(string4) || string4 != "death") && (!IsDefined(string5) || string5 != "death") && (!IsDefined(string6) || string6 != "death") && !IsDefined(string7) || string7 != "death")
	{
		self endon("death");
	}

	ent = spawnstruct();
	if(IsDefined(string1))
	{
		self thread waittill_string(string1,ent);
	}

	if(IsDefined(string2))
	{
		self thread waittill_string(string2,ent);
	}

	if(IsDefined(string3))
	{
		self thread waittill_string(string3,ent);
	}

	if(IsDefined(string4))
	{
		self thread waittill_string(string4,ent);
	}

	if(IsDefined(string5))
	{
		self thread waittill_string(string5,ent);
	}

	if(IsDefined(string6))
	{
		self thread waittill_string(string6,ent);
	}

	if(IsDefined(string7))
	{
		self thread waittill_string(string7,ent);
	}

	ent waittill("returned",msg);
	ent notify("die");
	return msg;
}

//Function Number: 39
waittill_any_array_return(a_notifies)
{
	if(isinarray(a_notifies,"death"))
	{
		self endon("death");
	}

	s_tracker = spawnstruct();
	foreach(str_notify in a_notifies)
	{
		if(IsDefined(str_notify))
		{
			self thread waittill_string(str_notify,s_tracker);
		}
	}

	s_tracker waittill(_k825,"returned",msg);
	s_tracker notify("die");
	return msg;
}

//Function Number: 40
waittill_any(str_notify1,str_notify2,str_notify3,str_notify4,str_notify5)
{
/#
	assert(IsDefined(str_notify1));
#/
	waittill_any_array(array(str_notify1,str_notify2,str_notify3,str_notify4,str_notify5));
}

//Function Number: 41
waittill_any_array(a_notifies)
{
/#
	assert(IsDefined(a_notifies[0]),"At least the first element has to be defined for waittill_any_array.");
#/
	for(i = 1;i < a_notifies.size;i++)
	{
		if(IsDefined(a_notifies[i]))
		{
			self endon(a_notifies[i]);
		}
	}

	self waittill(a_notifies[0]);
}

//Function Number: 42
waittill_any_timeout(n_timeout,string1,string2,string3,string4,string5)
{
	if((!IsDefined(string1) || string1 != "death") && (!IsDefined(string2) || string2 != "death") && (!IsDefined(string3) || string3 != "death") && (!IsDefined(string4) || string4 != "death") && !IsDefined(string5) || string5 != "death")
	{
		self endon("death");
	}

	ent = spawnstruct();
	if(IsDefined(string1))
	{
		self thread waittill_string(string1,ent);
	}

	if(IsDefined(string2))
	{
		self thread waittill_string(string2,ent);
	}

	if(IsDefined(string3))
	{
		self thread waittill_string(string3,ent);
	}

	if(IsDefined(string4))
	{
		self thread waittill_string(string4,ent);
	}

	if(IsDefined(string5))
	{
		self thread waittill_string(string5,ent);
	}

	ent thread _timeout(n_timeout);
	ent waittill("returned",msg);
	ent notify("die");
	return msg;
}

//Function Number: 43
_timeout(delay)
{
	self endon("die");
	wait(delay);
	self notify("returned","timeout");
}

//Function Number: 44
waittill_any_ents(ent1,string1,ent2,string2,ent3,string3,ent4,string4,ent5,string5,ent6,string6,ent7,string7)
{
/#
	assert(IsDefined(ent1));
#/
/#
	assert(IsDefined(string1));
#/
	if(IsDefined(ent2) && IsDefined(string2))
	{
		ent2 endon(string2);
	}

	if(IsDefined(ent3) && IsDefined(string3))
	{
		ent3 endon(string3);
	}

	if(IsDefined(ent4) && IsDefined(string4))
	{
		ent4 endon(string4);
	}

	if(IsDefined(ent5) && IsDefined(string5))
	{
		ent5 endon(string5);
	}

	if(IsDefined(ent6) && IsDefined(string6))
	{
		ent6 endon(string6);
	}

	if(IsDefined(ent7) && IsDefined(string7))
	{
		ent7 endon(string7);
	}

	ent1 waittill(string1);
}

//Function Number: 45
waittill_any_ents_two(ent1,string1,ent2,string2)
{
/#
	assert(IsDefined(ent1));
#/
/#
	assert(IsDefined(string1));
#/
	if(IsDefined(ent2) && IsDefined(string2))
	{
		ent2 endon(string2);
	}

	ent1 waittill(string1);
}

//Function Number: 46
waittill_flag_exists(msg)
{
	while(!(flag_exists(msg)))
	{
		waittillframeend;
		if(flag_exists(msg))
		{
			break;
		}

		wait(0.05);
	}
}

//Function Number: 47
isflashed()
{
	if(!(IsDefined(self.flashendtime)))
	{
		return 0;
	}

	return GetTime() < self.flashendtime;
}

//Function Number: 48
isstunned()
{
	if(!(IsDefined(self.flashendtime)))
	{
		return 0;
	}

	return GetTime() < self.flashendtime;
}

//Function Number: 49
flag(flagname)
{
/#
	assert(IsDefined(flagname),"Tried to check flag but the flag was not defined.");
#/
/#
	assert(IsDefined(level.flag[flagname]),"Tried to check flag " + flagname + " but the flag was not initialized.");
#/
	if(!(level.flag[flagname]))
	{
		return 0;
	}

	return 1;
}

//Function Number: 50
flag_delete(flagname)
{
	if(IsDefined(level.flag[flagname]))
	{
		level.flag[flagname] = undefined;
	}
	else
	{
/#
		println("flag_delete() called on flag that does not exist: " + flagname);
#/
	}
}

//Function Number: 51
flag_init(flagname,val,b_is_trigger)
{
	if(!(IsDefined(b_is_trigger)))
	{
		b_is_trigger = 0;
	}

	if(!(IsDefined(level.flag)))
	{
		level.flag = [];
	}

	if(!(IsDefined(level.sp_stat_tracking_func)))
	{
		level.sp_stat_tracking_func = ::empty;
	}

	if(!(IsDefined(level.first_frame)))
	{
/#
		assert(!IsDefined(level.flag[flagname]),"Attempt to reinitialize existing flag: " + flagname);
#/
	}

	if(IsDefined(val) && val)
	{
		level.flag[flagname] = 1;
	}
	else
	{
		level.flag[flagname] = 0;
	}

	if(b_is_trigger)
	{
		if(!(IsDefined(level.trigger_flags)))
		{
			init_trigger_flags();
			level.trigger_flags[flagname] = [];
		}
		else if(!(IsDefined(level.trigger_flags[flagname])))
		{
			level.trigger_flags[flagname] = [];
		}
	}

	if(is_suffix(flagname,"aa_"))
	{
		thread [[ level.sp_stat_tracking_func ]](flagname);
	}
}

//Function Number: 52
flag_set(flagname)
{
/#
/#
	assert(IsDefined(level.flag[flagname]),"Attempt to set a flag before calling flag_init: " + flagname);
#/
#/
	level.flag[flagname] = 1;
	level notify(flagname);
	set_trigger_flag_permissions(flagname);
}

//Function Number: 53
flag_set_for_time(n_time,str_flag)
{
	level notify("set_flag_for_time:" + str_flag);
	flag_set(str_flag);
	level endon("set_flag_for_time:" + str_flag);
	wait(n_time);
	flag_clear(str_flag);
}

//Function Number: 54
flag_toggle(flagname)
{
	if(flag(flagname))
	{
		flag_clear(flagname);
	}
	else
	{
		flag_set(flagname);
	}
}

//Function Number: 55
flag_wait(flagname)
{
	level waittill_flag_exists(flagname);
	while(!(level.flag[flagname]))
	{
		level waittill(flagname);
	}
}

//Function Number: 56
flag_wait_any(str_flag1,str_flag2,str_flag3,str_flag4,str_flag5)
{
	level flag_wait_any_array(array(str_flag1,str_flag2,str_flag3,str_flag4,str_flag5));
}

//Function Number: 57
flag_wait_any_array(a_flags)
{
	while(1)
	{
		for(i = 0;i < a_flags.size;i++)
		{
			if(flag(a_flags[i]))
			{
				return a_flags[i];
			}
		}

		level waittill_any_array(a_flags);
	}
}

//Function Number: 58
flag_clear(flagname)
{
/#
/#
	assert(IsDefined(level.flag[flagname]),"Attempt to set a flag before calling flag_init: " + flagname);
#/
#/
	if(level.flag[flagname])
	{
		level.flag[flagname] = 0;
		level notify(flagname);
		set_trigger_flag_permissions(flagname);
	}
}

//Function Number: 59
flag_waitopen(flagname)
{
	while(level.flag[flagname])
	{
		level waittill(flagname);
	}
}

//Function Number: 60
flag_waitopen_array(a_flags)
{
	foreach(str_flag in a_flags)
	{
		if(flag(str_flag))
		{
			flag_waitopen(str_flag);
		}
		else
		{
		}
	}
}

//Function Number: 61
flag_exists(flagname)
{
	if(self == level)
	{
		if(!(IsDefined(level.flag)))
		{
			return 0;
		}

		if(IsDefined(level.flag[flagname]))
		{
			return 1;
		}
	}
	else
	{
		if(!(IsDefined(self.ent_flag)))
		{
			return 0;
		}

		if(IsDefined(self.ent_flag[flagname]))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 62
script_gen_dump_addline(string,signature)
{
	if(!(IsDefined(string)))
	{
		string = "nowrite";
	}

	if(!(IsDefined(level._loadstarted)))
	{
		if(!(IsDefined(level.script_gen_dump_preload)))
		{
			level.script_gen_dump_preload = [];
		}

		struct = spawnstruct();
		struct.string = string;
		struct.signature = signature;
		level.script_gen_dump_preload[level.script_gen_dump_preload.size] = struct;
		return;
	}

	if(!(IsDefined(level.script_gen_dump[signature])))
	{
		level.script_gen_dump_reasons[level.script_gen_dump_reasons.size] = "Added: " + string;
	}

	level.script_gen_dump[signature] = string;
	level.script_gen_dump2[signature] = string;
}

//Function Number: 63
array_func(entities,func,arg1,arg2,arg3,arg4,arg5,arg6)
{
	if(!(IsDefined(entities)))
	{
		return;
	}

	if(isarray(entities))
	{
		if(entities.size)
		{
			keys = getarraykeys(entities);
			for(i = 0;i < keys.size;i++)
			{
				single_func(entities[keys[i]],func,arg1,arg2,arg3,arg4,arg5,arg6);
			}
		}
	}
	else
	{
		single_func(entities,func,arg1,arg2,arg3,arg4,arg5,arg6);
	}
}

//Function Number: 64
single_func(entity,func,arg1,arg2,arg3,arg4,arg5,arg6)
{
	if(!(IsDefined(entity)))
	{
		entity = level;
	}

	if(IsDefined(arg6))
	{
		return entity [[ func ]](arg1,arg2,arg3,arg4,arg5,arg6);
	}
	else if(IsDefined(arg5))
	{
		return entity [[ func ]](arg1,arg2,arg3,arg4,arg5);
	}
	else if(IsDefined(arg4))
	{
		return entity [[ func ]](arg1,arg2,arg3,arg4);
	}
	else if(IsDefined(arg3))
	{
		return entity [[ func ]](arg1,arg2,arg3);
	}
	else if(IsDefined(arg2))
	{
		return entity [[ func ]](arg1,arg2);
	}
	else if(IsDefined(arg1))
	{
		return entity [[ func ]](arg1);
	}
	else
	{
		return entity [[ func ]]();
	}
}

//Function Number: 65
new_func(func,arg1,arg2,arg3,arg4,arg5,arg6)
{
	s_func = spawnstruct();
	s_func.func = func;
	s_func.arg1 = arg1;
	s_func.arg2 = arg2;
	s_func.arg3 = arg3;
	s_func.arg4 = arg4;
	s_func.arg5 = arg5;
	s_func.arg6 = arg6;
	return s_func;
}

//Function Number: 66
call_func(s_func)
{
	return single_func(self,s_func.func,s_func.arg1,s_func.arg2,s_func.arg3,s_func.arg4,s_func.arg5,s_func.arg6);
}

//Function Number: 67
array_thread(entities,func,arg1,arg2,arg3,arg4,arg5,arg6)
{
/#
	assert(IsDefined(entities),"Undefined entity array passed to common_scriptsutility::array_thread");
#/
/#
	assert(IsDefined(func),"Undefined function passed to common_scriptsutility::array_thread");
#/
	if(isarray(entities))
	{
		if(IsDefined(arg6))
		{
			foreach(ent in entities)
			{
				ent thread [[ func ]](arg1,arg2,arg3,arg4,arg5,arg6);
			}
		}
		else if(IsDefined(arg5))
		{
			foreach(ent in entities)
			{
				ent thread [[ func ]](arg1,arg2,arg3,arg4,arg5);
			}
		}
		else if(IsDefined(arg4))
		{
			foreach(ent in entities)
			{
				ent thread [[ func ]](arg1,arg2,arg3,arg4);
			}
		}
		else if(IsDefined(arg3))
		{
			foreach(ent in entities)
			{
				ent thread [[ func ]](arg1,arg2,arg3);
			}
		}
		else if(IsDefined(arg2))
		{
			foreach(ent in entities)
			{
				ent thread [[ func ]](arg1,arg2);
			}
		}
		else if(IsDefined(arg1))
		{
			foreach(ent in entities)
			{
				ent thread [[ func ]](arg1);
			}
		}
		else
		{
			foreach(ent in entities)
			{
				ent thread [[ func ]]();
			}
		}
	}
	else
	{
		single_thread(entities,func,arg1,arg2,arg3,arg4,arg5,arg6);
	}
}

//Function Number: 68
array_ent_thread(entities,func,arg1,arg2,arg3,arg4,arg5)
{
/#
	assert(IsDefined(entities),"Undefined entity array passed to common_scriptsutility::array_ent_thread");
#/
/#
	assert(IsDefined(func),"Undefined function passed to common_scriptsutility::array_ent_thread");
#/
	if(isarray(entities))
	{
		if(entities.size)
		{
			keys = getarraykeys(entities);
			for(i = 0;i < keys.size;i++)
			{
				single_thread(self,func,entities[keys[i]],arg1,arg2,arg3,arg4,arg5);
			}
		}
	}
	else
	{
		single_thread(self,func,entities,arg1,arg2,arg3,arg4,arg5);
	}
}

//Function Number: 69
single_thread(entity,func,arg1,arg2,arg3,arg4,arg5,arg6)
{
/#
	assert(IsDefined(entity),"Undefined entity passed to common_scriptsutility::single_thread()");
#/
	if(IsDefined(arg6))
	{
		entity thread [[ func ]](arg1,arg2,arg3,arg4,arg5,arg6);
	}
	else if(IsDefined(arg5))
	{
		entity thread [[ func ]](arg1,arg2,arg3,arg4,arg5);
	}
	else if(IsDefined(arg4))
	{
		entity thread [[ func ]](arg1,arg2,arg3,arg4);
	}
	else if(IsDefined(arg3))
	{
		entity thread [[ func ]](arg1,arg2,arg3);
	}
	else if(IsDefined(arg2))
	{
		entity thread [[ func ]](arg1,arg2);
	}
	else if(IsDefined(arg1))
	{
		entity thread [[ func ]](arg1);
	}
	else
	{
		entity thread [[ func ]]();
	}
}

//Function Number: 70
remove_undefined_from_array(array)
{
	newarray = [];
	for(i = 0;i < array.size;i++)
	{
		if(!(IsDefined(array[i])))
		{
		}
		else
		{
			newarray[newarray.size] = array[i];
		}
	}

	return newarray;
}

//Function Number: 71
trigger_on(name,type)
{
	if(IsDefined(name))
	{
		if(!(IsDefined(type)))
		{
			type = "targetname";
		}

		ents = getentarray(name,type);
		array_thread(ents,::trigger_on_proc);
	}
	else
	{
		self trigger_on_proc();
	}
}

//Function Number: 72
trigger_on_proc()
{
	if(IsDefined(self.realorigin))
	{
		self.origin = self.realorigin;
	}

	self.trigger_off = undefined;
}

//Function Number: 73
trigger_off(name,type)
{
	if(IsDefined(name))
	{
		if(!(IsDefined(type)))
		{
			type = "targetname";
		}

		ents = getentarray(name,type);
		array_thread(ents,::trigger_off_proc);
	}
	else
	{
		self trigger_off_proc();
	}
}

//Function Number: 74
trigger_off_proc()
{
	if(!IsDefined(self.trigger_off) || !self.trigger_off)
	{
		self.realorigin = self.origin;
		self.origin = 10000 + VectorScale((0,0,-1));
		self.trigger_off = 1;
	}
}

//Function Number: 75
trigger_wait(str_name,str_key,e_entity)
{
	if(!(IsDefined(str_key)))
	{
		str_key = "targetname";
	}

	if(IsDefined(str_name))
	{
		triggers = getentarray(str_name,str_key);
/#
		assert(triggers.size > 0,"trigger not found: " + str_name + " key: " + str_key);
#/
		if(triggers.size == 1)
		{
			trigger_hit = triggers[0];
			trigger_hit _trigger_wait(e_entity);
		}
		else
		{
			s_tracker = spawnstruct();
			array_thread(triggers,::_trigger_wait_think,s_tracker,e_entity);
			s_tracker waittill("trigger",e_other,trigger_hit);
			trigger_hit.who = e_other;
		}

		level notify(str_name,trigger_hit.who);
		return trigger_hit;
	}
	else
	{
		return _trigger_wait(e_entity);
	}
}

//Function Number: 76
_trigger_wait(e_entity)
{
	if(is_look_trigger(self))
	{
		self waittill("trigger_look",e_other);
	}
	else
	{
		self waittill("trigger",e_other);
	}

	if(!(IsDefined(e_entity) && e_other != e_entity))
	{
	}

	self.who = e_other;
	return self;
}

//Function Number: 77
_trigger_wait_think(s_tracker,e_entity)
{
	self endon("death");
	s_tracker endon("trigger");
	e_other = _trigger_wait(e_entity);
	s_tracker notify("trigger",e_other,self);
}

//Function Number: 78
trigger_use(str_name,str_key,ent,b_assert)
{
	if(!(IsDefined(str_key)))
	{
		str_key = "targetname";
	}

	if(!(IsDefined(b_assert)))
	{
		b_assert = 1;
	}

	if(!(IsDefined(ent)))
	{
		ent = get_players()[0];
	}

	if(IsDefined(str_name))
	{
		e_trig = getent(str_name,str_key);
		if(!(IsDefined(e_trig)))
		{
			if(b_assert)
			{
/#
				assertmsg("trigger not found: " + str_name + " key: " + str_key);
#/
				return;
			}
		}
	}
	else
	{
		e_trig = self;
		str_name = self.targetname;
	}

	e_trig useby(ent);
	level notify(str_name,ent);
	if(is_look_trigger(e_trig))
	{
		e_trig notify("trigger_look");
	}

	return e_trig;
}

//Function Number: 79
set_trigger_flag_permissions(msg)
{
	if(!IsDefined(level.trigger_flags) || !IsDefined(level.trigger_flags[msg]))
	{
		return;
	}

	level.trigger_flags[msg] = remove_undefined_from_array(level.trigger_flags[msg]);
	array_thread(level.trigger_flags[msg],::update_trigger_based_on_flags);
}

//Function Number: 80
update_trigger_based_on_flags()
{
	true_on = 1;
	if(IsDefined(self.script_flag_true))
	{
		true_on = 0;
		tokens = create_flags_and_return_tokens(self.script_flag_true);
		for(i = 0;i < tokens.size;i++)
		{
			if(flag(tokens[i]))
			{
				true_on = 1;
				break;
			}
		}
	}

	false_on = 1;
	if(IsDefined(self.script_flag_false))
	{
		tokens = create_flags_and_return_tokens(self.script_flag_false);
		for(i = 0;i < tokens.size;i++)
		{
			if(flag(tokens[i]))
			{
				false_on = 0;
				break;
			}
		}
	}

	[[ level.trigger_func[true_on && false_on] ]]();
}

//Function Number: 81
create_flags_and_return_tokens(flags)
{
	tokens = strtok(flags," ");
	for(i = 0;i < tokens.size;i++)
	{
		if(!(IsDefined(level.flag[tokens[i]])))
		{
			flag_init(tokens[i],undefined,1);
		}
	}

	return tokens;
}

//Function Number: 82
init_trigger_flags()
{
	level.trigger_flags = [];
	level.trigger_func[1] = ::trigger_on;
	level.trigger_func[0] = ::trigger_off;
}

//Function Number: 83
is_look_trigger(trig)
{
	return IsDefined(trig) ? trig has_spawnflag(256) && !(!IsDefined(trig.classname) && !IsDefined("trigger_damage")) || IsDefined(trig.classname) && IsDefined("trigger_damage") && trig.classname == "trigger_damage" : 0;
}

//Function Number: 84
is_trigger_once(trig)
{
	return IsDefined(trig) ? trig has_spawnflag(1024) || (!IsDefined(self.classname) && !IsDefined("trigger_once")) || IsDefined(self.classname) && IsDefined("trigger_once") && self.classname == "trigger_once" : 0;
}

//Function Number: 85
getstruct(name,type)
{
	if(!(IsDefined(type)))
	{
		type = "targetname";
	}

/#
	assert(IsDefined(level.struct_class_names),"Tried to getstruct before the structs were init");
#/
	array = level.struct_class_names[type][name];
	if(!(IsDefined(array)))
	{
		return undefined;
	}

	if(array.size > 1)
	{
/#
		assertmsg("getstruct used for more than one struct of type " + type + " called " + name + ".");
#/
		return undefined;
	}

	return array[0];
}

//Function Number: 86
getstructarray(name,type)
{
	if(!(IsDefined(type)))
	{
		type = "targetname";
	}

/#
	assert(IsDefined(level.struct_class_names),"Tried to getstruct before the structs were init");
#/
	array = level.struct_class_names[type][name];
	if(!(IsDefined(array)))
	{
		return [];
	}
}

//Function Number: 87
structdelete()
{
	if(IsDefined(self.target) && IsDefined(level.struct_class_names["target"][self.target]))
	{
		level.struct_class_names["target"][self.target] = undefined;
	}

	if(IsDefined(self.targetname) && IsDefined(level.struct_class_names["targetname"][self.targetname]))
	{
		level.struct_class_names["targetname"][self.targetname] = undefined;
	}

	if(IsDefined(self.script_noteworthy) && IsDefined(level.struct_class_names["script_noteworthy"][self.script_noteworthy]))
	{
		level.struct_class_names["script_noteworthy"][self.script_noteworthy] = undefined;
	}

	if(IsDefined(self.script_linkname) && IsDefined(level.struct_class_names["script_linkname"][self.script_linkname]))
	{
		level.struct_class_names["script_linkname"][self.script_linkname] = undefined;
	}
}

//Function Number: 88
struct_class_init()
{
/#
	assert(!IsDefined(level.struct_class_names),"level.struct_class_names is being initialized in the wrong place! It shouldn\'t be initialized yet.");
#/
	level.struct_class_names = [];
	level.struct_class_names["target"] = [];
	level.struct_class_names["targetname"] = [];
	level.struct_class_names["script_noteworthy"] = [];
	level.struct_class_names["script_linkname"] = [];
	level.struct_class_names["script_unitrigger_type"] = [];
	foreach(s_struct in level.struct)
	{
		if(IsDefined(s_struct.targetname))
		{
			if(!(IsDefined(level.struct_class_names["targetname"][s_struct.targetname])))
			{
				level.struct_class_names["targetname"][s_struct.targetname] = [];
			}

			size = level.struct_class_names["targetname"][s_struct.targetname].size;
			level.struct_class_names["targetname"][s_struct.targetname][size] = s_struct;
		}

		if(IsDefined(s_struct.target))
		{
			if(!(IsDefined(level.struct_class_names["target"][s_struct.target])))
			{
				level.struct_class_names["target"][s_struct.target] = [];
			}

			size = level.struct_class_names["target"][s_struct.target].size;
			level.struct_class_names["target"][s_struct.target][size] = s_struct;
		}

		if(IsDefined(s_struct.script_noteworthy))
		{
			if(!(IsDefined(level.struct_class_names["script_noteworthy"][s_struct.script_noteworthy])))
			{
				level.struct_class_names["script_noteworthy"][s_struct.script_noteworthy] = [];
			}

			size = level.struct_class_names["script_noteworthy"][s_struct.script_noteworthy].size;
			level.struct_class_names["script_noteworthy"][s_struct.script_noteworthy][size] = s_struct;
		}

		if(IsDefined(s_struct.script_linkname))
		{
/#
			assert(!IsDefined(level.struct_class_names["script_linkname"][s_struct.script_linkname]),"Two structs have the same linkname");
#/
			level.struct_class_names["script_linkname"][s_struct.script_linkname][0] = s_struct;
		}

		if(IsDefined(s_struct.script_unitrigger_type))
		{
			if(!(IsDefined(level.struct_class_names["script_unitrigger_type"][s_struct.script_unitrigger_type])))
			{
				level.struct_class_names["script_unitrigger_type"][s_struct.script_unitrigger_type] = [];
			}

			size = level.struct_class_names["script_unitrigger_type"][s_struct.script_unitrigger_type].size;
			level.struct_class_names["script_unitrigger_type"][s_struct.script_unitrigger_type][size] = s_struct;
		}
	}
}

//Function Number: 89
fileprint_start(file)
{
/#
	filename = file;
	file = openfile(filename,"write");
	level.fileprint = file;
	level.fileprintlinecount = 0;
	level.fileprint_filename = filename;
#/
}

//Function Number: 90
fileprint_map_start(file)
{
/#
	file = "map_source/" + file + ".map";
	fileprint_start(file);
	level.fileprint_mapentcount = 0;
	fileprint_map_header(1);
#/
}

//Function Number: 91
fileprint_chk(file,str)
{
/#
	level.fileprintlinecount++;
	wait(0.05);
	level.fileprintlinecount++;
	level.fileprintlinecount = 0;
	fprintln(file,str);
level.fileprintlinecount > 400
#/
}

//Function Number: 92
fileprint_map_header(binclude_blank_worldspawn)
{
	if(!(IsDefined(binclude_blank_worldspawn)))
	{
		binclude_blank_worldspawn = 0;
	}

/#
	assert(IsDefined(level.fileprint));
#/
/#
	fileprint_chk(level.fileprint,"iwmap 4");
	fileprint_chk(level.fileprint,"\"000_Global\" flags  active");
	fileprint_chk(level.fileprint,"\"The Map\" flags");
	return;
	fileprint_map_entity_start();
	fileprint_map_keypairprint("classname","worldspawn");
	fileprint_map_entity_end();
binclude_blank_worldspawn
#/
}

//Function Number: 93
fileprint_map_keypairprint(key1,key2)
{
/#
/#
	assert(IsDefined(level.fileprint));
#/
	fileprint_chk(level.fileprint,"\" + key1 + "\" \" + key2 + "\");
#/
}

//Function Number: 94
fileprint_map_entity_start()
{
/#
/#
	assert(!IsDefined(level.fileprint_entitystart));
#/
	level.fileprint_entitystart = 1;
/#
	assert(IsDefined(level.fileprint));
#/
	fileprint_chk(level.fileprint,"// entity " + level.fileprint_mapentcount);
	fileprint_chk(level.fileprint,"{");
	level.fileprint_mapentcount++;
#/
}

//Function Number: 95
fileprint_map_entity_end()
{
/#
/#
	assert(IsDefined(level.fileprint_entitystart));
#/
/#
	assert(IsDefined(level.fileprint));
#/
	level.fileprint_entitystart = undefined;
	fileprint_chk(level.fileprint,"}");
#/
}

//Function Number: 96
fileprint_end()
{
/#
/#
	assert(!IsDefined(level.fileprint_entitystart));
#/
	saved = closefile(level.fileprint);
	println("-----------------------------------");
	println(" ");
	println("file write failure");
	println("file with name: " + level.fileprint_filename);
	println("make sure you checkout the file you are trying to save");
	println("note: USE P4 Search to find the file and check that one out");
	println("      Do not checkin files in from the xenonoutput folder, ");
	println("      this is junctioned to the proper directory where you need to go");
	println("junctions looks like this");
	println(" ");
	println("..\\xenonOutput\\scriptdata\\createfx      ..\\share\\raw\\maps\\createfx");
	println("..\\xenonOutput\\scriptdata\\createart     ..\\share\\raw\\maps\\createart");
	println("..\\xenonOutput\\scriptdata\\vision        ..\\share\\raw\\vision");
	println("..\\xenonOutput\\scriptdata\\scriptgen     ..\\share\\raw\\maps\\scriptgen");
	println("..\\xenonOutput\\scriptdata\\zone_source   ..\\xenon\\zone_source");
	println("..\\xenonOutput\\accuracy                  ..\\share\\raw\\accuracy");
	println("..\\xenonOutput\\scriptdata\\map_source    ..\\map_source\\xenon_export");
	println(" ");
	println("-----------------------------------");
	println("File not saved( see console.log for info ) ");
	level.fileprint = undefined;
	level.fileprint_filename = undefined;
saved != 1
#/
}

//Function Number: 97
fileprint_radiant_vec(vector)
{
/#
	string = "" + vector[0] + " " + vector[1] + " " + vector[2] + "";
	return string;
#/
}

//Function Number: 98
is_mature()
{
	if(level.onlinegame)
	{
		return 1;
	}

	return getlocalprofileint("cg_mature");
}

//Function Number: 99
is_german_build()
{
	if(level.language == "german")
	{
		return 1;
	}
}

//Function Number: 100
is_gib_restricted_build()
{
	if(GetDvar(#"5A6B41C9") == "japanese")
	{
		return 1;
	}

	return 0;
}

//Function Number: 101
is_true(check)
{
	return IsDefined(check) && check;
}

//Function Number: 102
is_false(check)
{
	return IsDefined(check) && !check;
}

//Function Number: 103
has_spawnflag(spawnflags)
{
	if(IsDefined(self.spawnflags))
	{
		return self.spawnflags & spawnflags == spawnflags;
	}

	return 0;
}

//Function Number: 104
clamp(val,val_min,val_max)
{
	if(val < val_min)
	{
		val = val_min;
	}
	else if(val > val_max)
	{
		val = val_max;
	}

	return val;
}

//Function Number: 105
linear_map(num,min_a,max_a,min_b,max_b)
{
	return clamp(num - min_a / max_a - min_a * max_b - min_b + min_b,min_b,max_b);
}

//Function Number: 106
lag(desired,curr,k,dt)
{
	r = 0;
	if(k * dt >= 1 || k <= 0)
	{
		r = desired;
	}
	else
	{
		err = desired - curr;
		r = curr + k * err * dt;
	}

	return r;
}

//Function Number: 107
death_notify_wrapper(attacker,damagetype)
{
	level notify("face","death",self);
	self notify("death",attacker,damagetype);
}

//Function Number: 108
damage_notify_wrapper(damage,attacker,direction_vec,point,type,modelname,tagname,partname,idflags)
{
	level notify("face","damage",self);
	self notify("damage",damage,attacker,direction_vec,point,type,modelname,tagname,partname,idflags);
}

//Function Number: 109
explode_notify_wrapper()
{
	level notify("face","explode",self);
	self notify("explode");
}

//Function Number: 110
alert_notify_wrapper()
{
	level notify("face","alert",self);
	self notify("alert");
}

//Function Number: 111
shoot_notify_wrapper()
{
	level notify("face","shoot",self);
	self notify("shoot");
}

//Function Number: 112
melee_notify_wrapper()
{
	level notify("face","melee",self);
	self notify("melee");
}

//Function Number: 113
isusabilityenabled()
{
	return !self.disabledusability;
}

//Function Number: 114
_disableusability()
{
	self.disabledusability++;
	self disableusability();
}

//Function Number: 115
_enableusability()
{
	self.disabledusability--;
/#
	assert(self.disabledusability >= 0);
#/
	if(!(self.disabledusability))
	{
		self enableusability();
	}
}

//Function Number: 116
resetusability()
{
	self.disabledusability = 0;
	self enableusability();
}

//Function Number: 117
_disableweapon()
{
	if(!(IsDefined(self.disabledweapon)))
	{
		self.disabledweapon = 0;
	}

	self.disabledweapon++;
	self disableweapons();
}

//Function Number: 118
_enableweapon()
{
	self.disabledweapon--;
/#
	assert(self.disabledweapon >= 0);
#/
	if(!(self.disabledweapon))
	{
		self enableweapons();
	}
}

//Function Number: 119
isweaponenabled()
{
	return !self.disabledweapon;
}

//Function Number: 120
delay_thread(timer,func,param1,param2,param3,param4,param5,param6)
{
	self thread _delay_thread_proc(func,timer,param1,param2,param3,param4,param5,param6);
}

//Function Number: 121
_delay_thread_proc(func,timer,param1,param2,param3,param4,param5,param6)
{
	self endon("death");
	self endon("disconnect");
	wait(timer);
	single_thread(self,func,param1,param2,param3,param4,param5,param6);
}

//Function Number: 122
delay_notify(str_notify,n_delay,str_endon)
{
/#
	assert(IsDefined(str_notify));
#/
/#
	assert(IsDefined(n_delay));
#/
	self thread _delay_notify_proc(str_notify,n_delay,str_endon);
}

//Function Number: 123
_delay_notify_proc(str_notify,n_delay,str_endon)
{
	self endon("death");
	if(IsDefined(str_endon))
	{
		self endon(str_endon);
	}

	if(n_delay > 0)
	{
		wait(n_delay);
	}

	self notify(str_notify);
}

//Function Number: 124
notify_delay_with_ender(snotifystring,fdelay,ender)
{
	if(IsDefined(ender))
	{
		level endon(ender);
	}

/#
	assert(IsDefined(self));
#/
/#
	assert(IsDefined(snotifystring));
#/
/#
	assert(IsDefined(fdelay));
#/
	self endon("death");
	if(fdelay > 0)
	{
		wait(fdelay);
	}

	if(!(IsDefined(self)))
	{
		return;
	}

	self notify(snotifystring);
}