/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_sentry.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 284 ms
 * Timestamp: 10/27/2023 3:09:58 AM
*******************************************************************/

//Function Number: 1
func_1A4D(param_00,param_01,param_02,param_03)
{
	self endon("bot_sentry_exited");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(randomintrange(3,5));
	while(isdefined(self.var_83E6) && gettime() < self.var_83E6)
	{
		wait(1);
	}

	if(isdefined(self.var_88) && self.var_88.var_BC > 0 && self method_8371(self.var_88))
	{
		return 1;
	}

	var_04 = self.var_116;
	if(param_03 != "hide_nonlethal")
	{
		var_04 = func_1ACA(param_03);
		if(!isdefined(var_04))
		{
			return 1;
		}
	}

	func_1AC5(param_00,var_04,param_03,param_01);
	while(maps/mp/bots/_bots_strategy::func_1A14("sentry_placement"))
	{
		wait(0.5);
	}

	return 1;
}

//Function Number: 2
func_1967(param_00)
{
	return 0;
}

//Function Number: 3
func_1AC5(param_00,param_01,param_02,param_03)
{
	var_04 = func_1AC9(param_00,param_01,param_02,param_03);
	if(isdefined(var_04))
	{
		maps/mp/bots/_bots_strategy::func_192C("sentry_placement");
		var_05 = spawnstruct();
		var_05.var_68FB = var_04;
		var_05.var_81CA = var_04.var_AAE8;
		var_05.var_81C8 = 10;
		var_05.var_9296 = ::func_1ACD;
		var_05.var_36AC = ::func_1AC6;
		var_05.var_8B3E = ::func_1ACF;
		var_05.var_87F = ::func_1AC4;
		self.var_7009 = param_00.var_944C;
		maps/mp/bots/_bots_strategy::func_1A85("sentry_placement",var_04.var_10D.var_116,0,var_05);
	}
}

//Function Number: 4
func_1ACF(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(isdefined(self.var_88) && self.var_88.var_BC > 0 && self method_8371(self.var_88))
	{
		return 1;
	}

	self.var_83E6 = gettime() + 1000;
	return 0;
}

//Function Number: 5
func_1AC7()
{
	self endon("death");
	self endon("disconnect");
	self endon("bot_sentry_canceled");
	self endon("bot_sentry_ensure_exit");
	level endon("game_ended");
	for(;;)
	{
		if(isdefined(self.var_88) && self.var_88.var_BC > 0 && self method_8371(self.var_88))
		{
			thread func_1AC6();
		}

		wait 0.05;
	}
}

//Function Number: 6
func_1ACD(param_00)
{
	thread func_1ACE(param_00);
}

//Function Number: 7
func_1ACE(param_00)
{
	self endon("stop_tactical_goal");
	self endon("stop_goal_aborted_watch");
	self endon("bot_sentry_canceled");
	self endon("bot_sentry_exited");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(isdefined(param_00.var_68FB) && isdefined(param_00.var_68FB.var_1D0))
	{
		if(distance2d(self.var_116,param_00.var_68FB.var_10D.var_116) < 400)
		{
			thread maps/mp/bots/_bots_util::func_19D4("stand",5);
			thread func_1AC7();
			maps/mp/bots/_bots_ks::func_1AF4(param_00.var_68FB.var_5A5C,param_00.var_68FB.var_5A72,param_00.var_68FB.var_1D0);
			return;
		}

		wait 0.05;
	}
}

//Function Number: 8
func_1ACA(param_00)
{
	var_01 = maps/mp/bots/_bots_util::func_2C6C();
	if(isdefined(var_01))
	{
		return var_01;
	}

	if(isdefined(self.var_6708))
	{
		return self.var_6708.var_116;
	}

	var_02 = getnodesinradius(self.var_116,1000,0,512);
	var_03 = 5;
	if(param_00 != "turret")
	{
		if(self botgetdifficultysetting("strategyLevel") == 1)
		{
			var_03 = 10;
		}
		else if(self botgetdifficultysetting("strategyLevel") == 0)
		{
			var_03 = 15;
		}
	}

	if(param_00 == "turret_air")
	{
		var_04 = self method_8366(var_02,var_03,"node_traffic","ignore_no_sky");
	}
	else
	{
		var_04 = self method_8366(var_03,var_04,"node_traffic");
	}

	if(isdefined(var_04))
	{
		return var_04.var_116;
	}
}

//Function Number: 9
func_1AC9(param_00,param_01,param_02,param_03)
{
	var_04 = undefined;
	var_05 = getnodesinradius(param_01,1000,0,512);
	var_06 = 5;
	if(param_02 != "turret")
	{
		if(self botgetdifficultysetting("strategyLevel") == 1)
		{
			var_06 = 10;
		}
		else if(self botgetdifficultysetting("strategyLevel") == 0)
		{
			var_06 = 15;
		}
	}

	if(param_02 == "turret_air")
	{
		var_07 = self method_8366(var_05,var_06,"node_sentry",param_01,"ignore_no_sky");
	}
	else if(param_03 == "trap")
	{
		var_07 = self method_8366(var_06,var_07,"node_traffic");
	}
	else if(param_03 == "hide_nonlethal")
	{
		var_07 = self method_8366(var_06,var_07,"node_hide");
	}
	else
	{
		var_07 = self method_8366(var_06,var_07,"node_sentry",param_02);
	}

	if(isdefined(var_07))
	{
		var_04 = spawnstruct();
		var_04.var_10D = var_07;
		if(param_01 != var_07.var_116 && param_02 != "hide_nonlethal")
		{
			var_04.var_AAE8 = vectortoyaw(param_01 - var_07.var_116);
		}
		else
		{
			var_04.var_AAE8 = undefined;
		}

		var_04.var_1D0 = param_00.var_1D0;
		var_04.var_5A5C = param_00;
		var_04.var_5A72 = param_03;
	}

	return var_04;
}

//Function Number: 10
func_1AC8()
{
	if(isdefined(self.var_2004))
	{
		return self.var_2004;
	}

	if(isdefined(self.var_2005))
	{
		return self.var_2005;
	}

	if(isdefined(self.var_2003))
	{
		return self.var_2003;
	}
}

//Function Number: 11
func_1AC4(param_00)
{
	var_01 = 0;
	var_02 = func_1AC8();
	if(isdefined(var_02))
	{
		var_03 = 0;
		if(!var_02.var_1F2F)
		{
			var_04 = 0.75;
			var_05 = gettime();
			var_06 = self getangles()[1];
			if(isdefined(param_00.var_68FB.var_AAE8))
			{
				var_06 = param_00.var_68FB.var_AAE8;
			}

			var_07 = [];
			var_07[0] = var_06 + 180;
			var_07[1] = var_06 + 135;
			var_07[2] = var_06 - 135;
			var_08 = 1000;
			foreach(var_0A in var_07)
			{
				var_0B = playerphysicstrace(param_00.var_68FB.var_10D.var_116,param_00.var_68FB.var_10D.var_116 + anglestoforward((0,var_0A + 180,0)) * 100);
				var_0C = distance2d(var_0B,param_00.var_68FB.var_10D.var_116);
				if(var_0C < var_08)
				{
					var_08 = var_0C;
					self botsetscriptmove(var_0A,var_04);
					self botlookatpoint(param_00.var_68FB.var_10D.var_116,var_04,"script_forced");
				}
			}

			while(!var_03 && isdefined(var_02) && !var_02.var_1F2F)
			{
				var_0E = float(gettime() - var_05) / 1000;
				if(!var_02.var_1F2F && var_0E > var_04)
				{
					var_03 = 1;
					self.var_83E6 = gettime() + 30000;
				}

				wait 0.05;
			}
		}

		if(isdefined(var_02) && var_02.var_1F2F)
		{
			func_1AC3();
			var_01 = 1;
		}
	}

	wait(0.25);
	func_1ACB();
	return var_01;
}

//Function Number: 12
func_1AC3()
{
	self notify("place_sentry");
	self notify("place_turret");
	self notify("placePlaceable");
}

//Function Number: 13
func_1AC2()
{
	self switchtoweapon("none");
	self method_8323();
	self method_8327();
	self notify("cancel_sentry");
	self notify("cancel_turret");
	self notify("cancelPlaceable");
}

//Function Number: 14
func_1AC6(param_00)
{
	self notify("bot_sentry_canceled");
	func_1AC2();
	func_1ACB();
}

//Function Number: 15
func_1ACB()
{
	self notify("bot_sentry_abort_goal_think");
	self notify("bot_sentry_ensure_exit");
	self endon("bot_sentry_ensure_exit");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self switchtoweapon("none");
	self method_8358();
	self botsetstance("none");
	self method_8323();
	self method_8327();
	wait(0.25);
	var_00 = 0;
	while(isdefined(func_1AC8()))
	{
		var_00++;
		func_1AC2();
		wait(0.25);
		if(var_00 > 2)
		{
			func_1ACC();
		}
	}

	self notify("bot_sentry_exited");
}

//Function Number: 16
func_1ACC()
{
	self.var_2004 = undefined;
	self.var_2005 = undefined;
	self.var_2003 = undefined;
	self switchtoweapon("none");
	self method_8323();
	self method_8327();
}