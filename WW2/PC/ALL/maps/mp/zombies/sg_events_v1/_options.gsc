/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\sg_events_v1\_options.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 86 ms
 * Timestamp: 10/27/2023 3:12:16 AM
*******************************************************************/

//Function Number: 1
set_option(param_00,param_01)
{
	if(!isdefined(level.sg_event_options))
	{
		level.sg_event_options = [];
	}

	level.sg_event_options[param_00] = param_01;
}

//Function Number: 2
func_4265(param_00)
{
	if(!isdefined(level.sg_event_options))
	{
		return undefined;
	}

	return level.sg_event_options[param_00];
}

//Function Number: 3
create_option(param_00,param_01)
{
	if(!isdefined(level.sg_event_option_funcs))
	{
		level.sg_event_option_funcs = [];
	}

	level.sg_event_option_funcs[param_00] = param_01;
}

//Function Number: 4
apply_option(param_00)
{
	var_01 = func_4265(param_00);
	if(isdefined(var_01) && isdefined(level.sg_event_option_funcs[var_01]))
	{
		level thread [[ level.sg_event_option_funcs[var_01] ]]();
	}
}