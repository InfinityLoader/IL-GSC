/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\bots\_bots_gametype_zombies.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 91 ms
 * Timestamp: 4/22/2024 2:08:47 AM
*******************************************************************/

//Function Number: 1
main()
{
	setup_callbacks();
	setup_bot_zombies();
}

//Function Number: 2
setup_callbacks()
{
	level.bot_funcs["gametype_think"] = ::bot_zombies_think;
}

//Function Number: 3
setup_bot_zombies()
{
	level.bots_gametype_handles_team_choice = 1;
	level.bots_ignore_team_balance = 1;
}

//Function Number: 4
bot_zombies_think()
{
	self notify("bot_zombies_think");
	self endon("bot_zombies_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		if(self botgetpersonality() != "run_and_gun")
		{
			maps\mp\bots\_bots_util::bot_set_personality("run_and_gun");
		}

		if(!isdefined(self.bot_defend_player_guarding))
		{
			var_00 = 9999;
			var_01 = undefined;
			foreach(var_03 in level.players)
			{
				if(isbot(var_03))
				{
					continue;
				}

				if(!isdefined(var_03.guardcount))
				{
					var_03.guardcount = 0;
				}

				if(var_03.guardcount < var_00)
				{
					var_00 = var_03.guardcount;
					var_01 = var_03;
				}
			}

			if(isdefined(var_01))
			{
				thread maps\mp\bots\_bots_strategy::bot_guard_player(var_01,800);
				var_01.guardcount++;
			}
		}

		self [[ self.personality_update_function ]]();
		wait(0.05);
	}
}