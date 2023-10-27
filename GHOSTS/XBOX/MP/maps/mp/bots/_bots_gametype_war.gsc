/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_war.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 5
 * Decompile Time: 94 ms
 * Timestamp: 10/27/2023 1:28:38 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	func_710C();
	func_7109();
}

//Function Number: 2
func_710C()
{
	level.bot_funcs["gametype_think"] = ::bot_war_think;
	level.bot_funcs["commander_gametype_tactics"] = ::bot_tdm_apply_commander_tactics;
}

//Function Number: 3
func_7109()
{
	if(maps\mp\_utility::bot_is_fireteam_mode())
	{
		level.bot_team_tdm_personality = "default";
		level.bot_fireteam_buddy_up = 0;
	}
}

//Function Number: 4
bot_war_think()
{
	self notify("bot_war_think");
	self endon("bot_war_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("owner_disconnect");
	for(;;)
	{
		self [[ self.personality_update_function ]]();
		wait(0.05);
	}
}

//Function Number: 5
bot_tdm_apply_commander_tactics(param_00)
{
	var_01 = 0;
	var_02 = level.bot_fireteam_buddy_up;
	var_03 = 0;
	level.bot_fireteam_buddy_up = 0;
	switch(param_00)
	{
		case "tactic_none":
			level.bot_team_tdm_personality = "revert";
			var_01 = 1;
			break;

		case "tactic_war_hp":
			level.bot_team_tdm_personality = "revert";
			level thread maps/mp/bots/_bots_fireteam::func_3320(self.team);
			var_03 = 1;
			var_01 = 1;
			break;

		case "tactic_war_buddy":
			level.bot_team_tdm_personality = "revert";
			level.bot_fireteam_buddy_up = 1;
			var_01 = 1;
			break;

		case "tactic_war_hyg":
			level.bot_team_tdm_personality = "camper";
			var_01 = 1;
			break;
	}

	if(!var_03)
	{
		level maps/mp/bots/_bots_fireteam::func_3321(self.team);
	}

	if(var_01)
	{
		foreach(var_05 in level.players)
		{
			if(!isdefined(var_05.team))
			{
				continue;
			}

			if(botsentientswap(var_05) && var_05.team == self.team)
			{
				var_05 botsetflag("force_sprint",0);
				if(level.bot_team_tdm_personality == "revert")
				{
					if(isdefined(var_05.fireteam_personality_original))
					{
						var_05 notify("stop_camping_tag");
						var_05 maps/mp/bots/_bots_personality::func_1D01();
						var_05 maps/mp/bots/_bots_util::bot_set_personality(var_05.fireteam_personality_original);
						var_05.can_camp_near_others = undefined;
						var_05.camping_needs_fallback_camp_location = undefined;
					}

					continue;
				}

				if(!isdefined(var_05.fireteam_personality_original))
				{
					var_05.fireteam_personality_original = var_05 botgetpersonality();
				}

				var_05 notify("stop_camping_tag");
				var_05 maps/mp/bots/_bots_personality::func_1D01();
				var_05 maps/mp/bots/_bots_util::bot_set_personality(level.bot_team_tdm_personality);
				if(level.bot_team_tdm_personality == "camper")
				{
					var_05.can_camp_near_others = 1;
					var_05.camping_needs_fallback_camp_location = 1;
				}
			}
		}
	}

	if(level.bot_fireteam_buddy_up)
	{
		foreach(var_05 in level.players)
		{
			if(!isdefined(var_05.team))
			{
				continue;
			}

			if(var_05.team == self.team)
			{
				if(botsentientswap(var_05))
				{
					var_05 thread maps/mp/bots/_bots_fireteam::bot_fireteam_buddy_search();
				}
			}
		}
	}

	if(var_02)
	{
		foreach(var_05 in level.players)
		{
			if(!isdefined(var_05.team))
			{
				continue;
			}

			if(var_05.team == self.team)
			{
				if(botsentientswap(var_05))
				{
					var_05.owner = undefined;
					var_05.bot_fireteam_follower = undefined;
					var_05 notify("buddy_cancel");
					var_05 maps/mp/bots/_bots_personality::func_157C();
				}
			}
		}
	}
}