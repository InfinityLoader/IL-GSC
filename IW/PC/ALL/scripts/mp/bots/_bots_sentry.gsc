/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\_bots_sentry.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 683 ms
 * Timestamp: 10/27/2023 12:27:43 AM
*******************************************************************/

//Function Number: 1
func_2DF2(param_00,param_01,param_02,param_03)
{
	self endon("bot_sentry_exited");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(randomintrange(3,5));
	while(isdefined(self.var_F250) && gettime() < self.var_F250)
	{
		wait(1);
	}

	if(isdefined(self.var_10C) && self.var_10C.health > 0 && self botcanseeentity(self.var_10C))
	{
		return 1;
	}

	var_04 = self.origin;
	if(param_03 != "hide_nonlethal")
	{
		var_04 = func_2E78(param_03);
		if(!isdefined(var_04))
		{
			return 1;
		}
	}

	func_2E73(param_00,var_04,param_03,param_01);
	while(scripts\mp\bots\_bots_strategy::func_2DC5("sentry_placement"))
	{
		wait(0.5);
	}

	return 1;
}

//Function Number: 2
func_2E73(param_00,param_01,param_02,param_03)
{
	var_04 = func_2E77(param_00,param_01,param_02,param_03);
	if(isdefined(var_04))
	{
		scripts\mp\bots\_bots_strategy::func_2D02("sentry_placement");
		var_05 = spawnstruct();
		var_05.var_C270 = var_04;
		var_05.var_EDCC = var_04.var_13E48;
		var_05.var_EDC9 = 10;
		var_05.var_10D46 = ::func_2E7B;
		var_05.var_6302 = ::func_2E74;
		var_05.var_FF0D = ::func_2E7D;
		var_05.var_157C = ::func_2E72;
		self.var_CC2D = param_00.var_110EA;
		scripts\mp\bots\_bots_strategy::func_2E27("sentry_placement",var_04.var_205.origin,0,var_05);
	}
}

//Function Number: 3
func_2E7D(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(isdefined(self.var_10C) && self.var_10C.health > 0 && self botcanseeentity(self.var_10C))
	{
		return 1;
	}

	self.var_F250 = gettime() + 1000;
	return 0;
}

//Function Number: 4
func_2E75()
{
	self endon("death");
	self endon("disconnect");
	self endon("bot_sentry_canceled");
	self endon("bot_sentry_ensure_exit");
	level endon("game_ended");
	for(;;)
	{
		if(isdefined(self.var_10C) && self.var_10C.health > 0 && self botcanseeentity(self.var_10C))
		{
			thread func_2E74();
		}

		wait(0.05);
	}
}

//Function Number: 5
func_2E7B(param_00)
{
	thread func_2E7C(param_00);
}

//Function Number: 6
func_2E7C(param_00)
{
	self endon("stop_tactical_goal");
	self endon("stop_goal_aborted_watch");
	self endon("bot_sentry_canceled");
	self endon("bot_sentry_exited");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(isdefined(param_00.var_C270) && isdefined(param_00.var_C270.var_394))
	{
		if(distance2d(self.origin,param_00.var_C270.var_205.origin) < 400)
		{
			thread scripts\mp\bots\_bots_util::func_2D9C("stand",5);
			thread func_2E75();
			scripts\mp\bots\_bots_killstreaks::func_2EA5(param_00.var_C270.var_A690,param_00.var_C270.var_A6AC,param_00.var_C270.var_394);
			return;
		}

		wait(0.05);
	}
}

//Function Number: 7
func_2E78(param_00)
{
	var_01 = scripts\mp\bots\_bots_util::func_507A();
	if(isdefined(var_01))
	{
		return var_01;
	}

	if(isdefined(self.var_C02A))
	{
		return self.var_C02A.origin;
	}

	var_02 = getnodesinradius(self.origin,1000,0,512);
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
		var_04 = self botnodepick(var_02,var_03,"node_traffic","ignore_no_sky");
	}
	else
	{
		var_04 = self botnodepick(var_03,var_04,"node_traffic");
	}

	if(isdefined(var_04))
	{
		return var_04.origin;
	}
}

//Function Number: 8
func_2E77(param_00,param_01,param_02,param_03)
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
		var_07 = self botnodepick(var_05,var_06,"node_sentry",param_01,"ignore_no_sky");
	}
	else if(param_03 == "trap")
	{
		var_07 = self botnodepick(var_06,var_07,"node_traffic");
	}
	else if(param_03 == "hide_nonlethal")
	{
		var_07 = self botnodepick(var_06,var_07,"node_hide");
	}
	else
	{
		var_07 = self botnodepick(var_06,var_07,"node_sentry",param_02);
	}

	if(isdefined(var_07))
	{
		var_04 = spawnstruct();
		var_04.var_205 = var_07;
		if(param_01 != var_07.origin && param_02 != "hide_nonlethal")
		{
			var_04.var_13E48 = vectortoyaw(param_01 - var_07.origin);
		}
		else
		{
			var_04.var_13E48 = undefined;
		}

		var_04.var_394 = param_00.var_394;
		var_04.var_A690 = param_00;
		var_04.var_A6AC = param_03;
	}

	return var_04;
}

//Function Number: 9
func_2E76()
{
	if(isdefined(self.var_3AA5))
	{
		return self.var_3AA5;
	}

	if(isdefined(self.var_3A9F))
	{
		return self.var_3A9F;
	}

	if(isdefined(self.var_3AA0))
	{
		return self.var_3AA0;
	}
}

//Function Number: 10
func_2E72(param_00)
{
	var_01 = 0;
	var_02 = func_2E76();
	if(isdefined(var_02))
	{
		var_03 = 0;
		if(!var_02.var_3872)
		{
			var_04 = 0.75;
			var_05 = gettime();
			var_06 = self.angles[1];
			if(isdefined(param_00.var_C270.var_13E48))
			{
				var_06 = param_00.var_C270.var_13E48;
			}

			var_07 = [];
			var_07[0] = var_06 + 180;
			var_07[1] = var_06 + 135;
			var_07[2] = var_06 - 135;
			var_08 = 1000;
			foreach(var_0A in var_07)
			{
				var_0B = playerphysicstrace(param_00.var_C270.var_205.origin,param_00.var_C270.var_205.origin + anglestoforward((0,var_0A + 180,0)) * 100);
				var_0C = distance2d(var_0B,param_00.var_C270.var_205.origin);
				if(var_0C < var_08)
				{
					var_08 = var_0C;
					self botsetscriptmove(var_0A,var_04);
					self botlookatpoint(param_00.var_C270.var_205.origin,var_04,"script_forced");
				}
			}

			while(!var_03 && isdefined(var_02) && !var_02.var_3872)
			{
				var_0E = float(gettime() - var_05) / 1000;
				if(!var_02.var_3872 && var_0E > var_04)
				{
					var_03 = 1;
					self.var_F250 = gettime() + 30000;
				}

				wait(0.05);
			}
		}

		if(isdefined(var_02) && var_02.var_3872)
		{
			func_2E71();
			var_01 = 1;
		}
	}

	wait(0.25);
	func_2E79();
	return var_01;
}

//Function Number: 11
func_2E71()
{
	self notify("place_sentry");
	self notify("place_ims");
	self notify("placePlaceable");
}

//Function Number: 12
func_2E70()
{
	self switchtoweapon("none");
	self enableweapons();
	self enableweaponswitch();
	self notify("cancel_sentry");
	self notify("cancel_ims");
	self notify("cancelPlaceable");
}

//Function Number: 13
func_2E74(param_00)
{
	self notify("bot_sentry_canceled");
	func_2E70();
	func_2E79();
}

//Function Number: 14
func_2E79()
{
	self notify("bot_sentry_abort_goal_think");
	self notify("bot_sentry_ensure_exit");
	self endon("bot_sentry_ensure_exit");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self switchtoweapon("none");
	self botclearscriptgoal();
	self botsetstance("none");
	self enableweapons();
	self enableweaponswitch();
	wait(0.25);
	var_00 = 0;
	while(isdefined(func_2E76()))
	{
		var_00++;
		func_2E70();
		wait(0.25);
		if(var_00 > 2)
		{
			func_2E7A();
		}
	}

	self notify("bot_sentry_exited");
}

//Function Number: 15
func_2E7A()
{
	if(isdefined(self.var_3AA5))
	{
		self.var_3AA5 scripts\mp\killstreaks\_autosentry::func_F253();
	}

	if(isdefined(self.var_3A9F))
	{
		self.var_3A9F scripts\mp\killstreaks\_ims::func_9376();
	}

	if(isdefined(self.var_3AA0))
	{
		self.var_3AA0 scripts\mp\killstreaks\_placeable::func_C4D2(self.var_CC2D,0);
	}

	self.var_3AA5 = undefined;
	self.var_3A9F = undefined;
	self.var_3AA0 = undefined;
	self switchtoweapon("none");
	self enableweapons();
	self enableweaponswitch();
}