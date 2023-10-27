/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\cp_reward.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 252 ms
 * Timestamp: 10/27/2023 12:09:59 AM
*******************************************************************/

//Function Number: 1
func_82A2(param_00,param_01)
{
	if(self.team == "allies")
	{
		return;
	}

	if(scripts\common\utility::istrue(self.var_54CB))
	{
		return;
	}

	if(scripts\cp\_agent_utils::func_77D7(self) == "elite" || scripts\cp\_agent_utils::func_77D7(self) == "mammoth")
	{
		var_02 = func_7C13();
		foreach(var_04 in level.players)
		{
			func_8373(var_04,var_02,"large");
		}

		return;
	}

	if(isdefined(self.var_24DA) || isdefined(self.var_B36A))
	{
		if(isdefined(self.var_B36A))
		{
			foreach(var_06 in level.players)
			{
				if(isdefined(self.var_D354) && self.var_D354 == var_06 && var_06 != var_03)
				{
					var_07 = func_7DDB();
					if(isdefined(level.var_3B0F))
					{
						var_07 = var_07 * level.var_3B0F;
					}

					func_8373(var_06,var_07 * 2);
					var_06 scripts\cp\_persistence::func_666A("assists",1);
					self.var_926B = 1;
				}
			}
		}

		if(!isdefined(self.var_926B))
		{
			var_09 = 0.1;
			var_0A = self.maxhealth * var_09;
			var_07 = func_7DDB();
			if(isdefined(level.var_3B0F))
			{
				var_07 = var_07 * level.var_3B0F;
			}

			foreach(var_0C in self.var_24DA)
			{
				if(var_0C.player == var_04 || isdefined(var_04.var_222) && var_0C.player == var_04.var_222)
				{
					continue;
				}

				if(var_0C.var_DA >= var_0A)
				{
					if(isdefined(var_0C.player) && var_0C.player != var_04)
					{
						var_0C.player scripts\cp\_persistence::func_666A("assists",1);
						func_8373(var_0C.player,var_07);
					}
				}
			}
		}
	}

	if(!isdefined(var_04))
	{
		return;
	}

	if(!isplayer(var_04) && !isdefined(var_04.var_222) || !isplayer(var_04.var_222))
	{
		return;
	}

	var_0E = 0;
	if(isdefined(var_04.var_222))
	{
		var_04 = var_04.var_222;
		var_0E = 1;
	}

	var_02 = func_7C13();
	if(isdefined(var_04) && var_04 == "soft" && !var_05)
	{
		var_0E = int(var_0E * 1.5);
	}

	func_8373(var_03,var_0E,"large",var_04);
}

//Function Number: 2
func_7DDB()
{
	return level.agent_definition[scripts\cp\_agent_utils::func_77D7(self)]["reward"] * 0.5;
}

//Function Number: 3
func_7C13()
{
	return level.agent_definition[scripts\cp\_agent_utils::func_77D7(self)]["reward"];
}

//Function Number: 4
func_8373(param_00,param_01,param_02,param_03)
{
	var_04 = param_01 * level.var_4CC4;
	if(isdefined(level.var_3B0F))
	{
		var_04 = var_04 * level.var_3B0F;
	}

	param_00 scripts\cp\_persistence::func_82F9(var_04,param_02,param_03);
	if(isdefined(level.var_13F56))
	{
		param_00 scripts\cp\_persistence::give_player_xp(int(var_04));
	}

	if(scripts\common\utility::func_6E34("cortex_started") && scripts\common\utility::flag("cortex_started"))
	{
		if(isdefined(level.var_16B4))
		{
			[[ level.var_16B4 ]](param_01);
		}
	}
}