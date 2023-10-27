/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\gametype_tdef.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 291 ms
 * Timestamp: 10/27/2023 12:12:10 AM
*******************************************************************/

//Function Number: 1
main()
{
	scripts\mp\bots\gametype_ball::main();
}

//Function Number: 2
func_F8F4()
{
	level.var_2D9E["gametype_think"] = ::func_2ECE;
	level.var_2D9E["commander_gametype_tactics"] = ::func_2EAB;
}

//Function Number: 3
func_F8E2()
{
	if(scripts\mp\_utility::func_2DD9())
	{
		level.var_2EAD = "default";
		level.var_2D80 = 0;
	}
}

//Function Number: 4
func_2ECE()
{
	self notify("bot_war_think");
	self endon("bot_war_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("owner_disconnect");
	for(;;)
	{
		self [[ self.var_CA7B ]]();
		wait(0.05);
	}
}

//Function Number: 5
func_2EAB(param_00)
{
	var_01 = 0;
	var_02 = level.var_2D80;
	var_03 = 0;
	level.var_2D80 = 0;
	switch(param_00)
	{
		case "tactic_none":
			level.var_2EAD = "revert";
			var_01 = 1;
			break;

		case "tactic_war_hp":
			level.var_2EAD = "revert";
			level thread scripts\mp\bots\_bots_fireteam::func_6D91(self.team);
			var_03 = 1;
			var_01 = 1;
			break;

		case "tactic_war_buddy":
			level.var_2EAD = "revert";
			level.var_2D80 = 1;
			var_01 = 1;
			break;

		case "tactic_war_hyg":
			level.var_2EAD = "camper";
			var_01 = 1;
			break;
	}

	if(!var_03)
	{
		level scripts\mp\bots\_bots_fireteam::func_6D92(self.team);
	}

	if(var_01)
	{
		foreach(var_05 in level.players)
		{
			if(!isdefined(var_05.team))
			{
				continue;
			}

			if(isbot(var_05) && var_05.team == self.team)
			{
				var_05 botsetflag("force_sprint",0);
				if(level.var_2EAD == "revert")
				{
					if(isdefined(var_05.var_6D90))
					{
						var_05 notify("stop_camping_tag");
						var_05 scripts\mp\bots\_bots_personality::func_413A();
						var_05 scripts\mp\bots\_bots_util::func_2E83(var_05.var_6D90);
						var_05.var_3802 = undefined;
						var_05.var_37EF = undefined;
					}

					continue;
				}

				if(!isdefined(var_05.var_6D90))
				{
					var_05.var_6D90 = var_05 method_8035();
				}

				var_05 notify("stop_camping_tag");
				var_05 scripts\mp\bots\_bots_personality::func_413A();
				var_05 scripts\mp\bots\_bots_util::func_2E83(level.var_2EAD);
				if(level.var_2EAD == "camper")
				{
					var_05.var_3802 = 1;
					var_05.var_37EF = 1;
				}
			}
		}
	}

	if(level.var_2D80)
	{
		foreach(var_05 in level.players)
		{
			if(!isdefined(var_05.team))
			{
				continue;
			}

			if(var_05.team == self.team)
			{
				if(isbot(var_05))
				{
					var_05 thread scripts\mp\bots\_bots_fireteam::func_2D7E();
				}
			}
		}

		return;
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
				if(isbot(var_05))
				{
					var_05.var_222 = undefined;
					var_05.var_2D8C = undefined;
					var_05 notify("buddy_cancel");
					var_05 scripts\mp\bots\_bots_personality::func_2D0C();
				}
			}
		}
	}
}