/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_gametype_prop.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 103 ms
 * Timestamp: 10/27/2023 3:09:33 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	func_87A7();
}

//Function Number: 2
func_87A7()
{
	level.var_19D5["gametype_think"] = ::bot_prop_think;
	level.var_19D5["know_enemies_on_start"] = undefined;
}

//Function Number: 3
bot_prop_think()
{
	self notify("bot_prop_think");
	self endon("bot_prop_think");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("owner_disconnect");
	var_00 = 0;
	for(;;)
	{
		wait 0.05;
		if(self.var_BC <= 0)
		{
			continue;
		}

		if(self method_8368() != "run_and_gun")
		{
			maps/mp/bots/_bots_util::func_1AD5("run_and_gun");
		}

		if(bot_is_on_prop_team())
		{
			if(self method_835F() != "tactical")
			{
				var_01 = array_randomly_reduce_to_size(getallnodes(),512);
				var_02 = self method_8366(var_01,var_01.size * 0.15,"node_hide_anywhere");
				if(!isdefined(var_02))
				{
					var_02 = self getnearestnode();
				}

				var_03 = self botsetscriptgoalnode(var_02,"tactical");
				if(var_03)
				{
					var_04 = common_scripts\utility::func_A712(["goal","bad_path","no_path","node_relinquished","script_goal_changed"]);
					if(var_04 == "goal")
					{
						self botsetflag("disable_movement",1);
						self botsetflag("disable_rotation",1);
					}
					else
					{
						self method_8358();
					}
				}
			}

			continue;
		}

		if(!common_scripts\utility::func_562E(self.phfrozen))
		{
			if(!self method_86C2() && gettime() - var_00 > 10000)
			{
				var_05 = self.var_88;
				if(!isdefined(var_05))
				{
					foreach(var_07 in level.var_744A)
					{
						if(!isalliedsentient(self,var_07))
						{
							var_05 = var_07;
						}
					}
				}

				if(isdefined(var_05) && !self method_8371(var_05))
				{
					var_09 = common_scripts\utility::func_7A33(getallnodes());
					self method_8379(var_05,var_09.var_116);
					var_00 = gettime();
				}
				else
				{
					self [[ level.var_1A8F["default"] ]]();
				}
			}
		}
	}
}

//Function Number: 4
bot_is_on_prop_team()
{
	return self.var_1A7 == game["defenders"];
}

//Function Number: 5
array_randomly_reduce_to_size(param_00,param_01)
{
	while(param_00.size > param_01)
	{
		var_02 = randomint(param_00.size);
		param_00[var_02] = param_00[param_00.size - 1];
		param_00[param_00.size - 1] = undefined;
	}

	return param_00;
}