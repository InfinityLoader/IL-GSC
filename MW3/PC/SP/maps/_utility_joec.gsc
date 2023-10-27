/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_utility_joec.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 2
 * Decompile Time: 28 ms
 * Timestamp: 10/27/2023 2:20:47 AM
*******************************************************************/

//Function Number: 1
exchange_sort_by_handler(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size - 1;var_02++)
	{
		var_03 = 0;
		for(var_04 = var_02 + 1;var_04 < param_00.size;var_04++)
		{
			if(param_00[var_04] [[ param_01 ]]() < param_00[var_02] [[ param_01 ]]())
			{
				var_05 = param_00[var_04];
				param_00[var_04] = param_00[var_02];
				param_00[var_02] = var_05;
			}
		}
	}

	return param_00;
}

//Function Number: 2
on_player_trig_record_and_notify(param_00,param_01)
{
	var_02 = getent(param_00,"script_noteworthy");
	for(;;)
	{
		var_02 waittill("trigger",var_03);
		if(isdefined(var_03) && var_03 == self)
		{
			self.stat_finish_time = gettime();
			if(isdefined(level.challenge_time_limit))
			{
				self.stat_finish_time_remaining = max(level.challenge_time_limit - self.stat_finish_time - level.challenge_start_time,0);
			}

			if(!maps\_utility::is_coop() || isdefined(maps\_utility::get_other_player(self).stat_finish_time))
			{
				common_scripts\utility::flag_set(param_01);
			}

			break;
		}
	}
}