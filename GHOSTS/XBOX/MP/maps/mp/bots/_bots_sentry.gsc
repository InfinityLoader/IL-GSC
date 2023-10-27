/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots_sentry.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 15
 * Decompile Time: 301 ms
 * Timestamp: 10/27/2023 1:28:50 AM
*******************************************************************/

//Function Number: 1
bot_killstreak_sentry(param_00,param_01,param_02,param_03)
{
	self endon("bot_sentry_exited");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(randomintrange(3,5));
	while(isdefined(self.sentry_place_delay) && gettime() < self.sentry_place_delay)
	{
		wait(1);
	}

	if(isdefined(self.enemy) && self.enemy.health > 0 && self botcanseeentity(self.enemy))
	{
		return 1;
	}

	var_04 = self.origin;
	if(param_03 != "hide_nonlethal")
	{
		var_04 = bot_sentry_choose_target(param_03);
		if(!isdefined(var_04))
		{
			return 1;
		}
	}

	bot_sentry_add_goal(param_00,var_04,param_03,param_01);
	while(maps/mp/bots/_bots_strategy::bot_has_tactical_goal("sentry_placement"))
	{
		wait(0.5);
	}

	return 1;
}

//Function Number: 2
bot_sentry_add_goal(param_00,param_01,param_02,param_03)
{
	var_04 = bot_sentry_choose_placement(param_00,param_01,param_02,param_03);
	if(isdefined(var_04))
	{
		maps/mp/bots/_bots_strategy::bot_abort_tactical_goal("sentry_placement");
		var_05 = addstruct();
		var_05.object = var_04;
		var_05.script_goal_yaw = var_04.yaw;
		var_05.script_goal_radius = 10;
		var_05.start_thread = ::bot_sentry_path_start;
		var_05.end_thread = ::func_167F;
		var_05.should_abort = ::func_1687;
		var_05.action_thread = ::bot_sentry_activate;
		self.placingitemstreakname = param_00.streakname;
		maps/mp/bots/_bots_strategy::bot_new_tactical_goal("sentry_placement",var_04.node.origin,0,var_05);
	}
}

//Function Number: 3
func_1687(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(isdefined(self.enemy) && self.enemy.health > 0 && self botcanseeentity(self.enemy))
	{
		return 1;
	}

	self.sentry_place_delay = gettime() + 1000;
	return 0;
}

//Function Number: 4
bot_sentry_cancel_failsafe()
{
	self endon("death");
	self endon("disconnect");
	self endon("bot_sentry_canceled");
	self endon("bot_sentry_ensure_exit");
	level endon("game_ended");
	for(;;)
	{
		if(isdefined(self.enemy) && self.enemy.health > 0 && self botcanseeentity(self.enemy))
		{
			thread func_167F();
		}

		wait(0.05);
	}
}

//Function Number: 5
bot_sentry_path_start(param_00)
{
	thread bot_sentry_path_thread(param_00);
}

//Function Number: 6
bot_sentry_path_thread(param_00)
{
	self endon("stop_tactical_goal");
	self endon("stop_goal_aborted_watch");
	self endon("bot_sentry_canceled");
	self endon("bot_sentry_exited");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	while(isdefined(param_00.object) && isdefined(param_00.object.weapon))
	{
		if(distance2d(self.origin,param_00.object.node.origin) < 400)
		{
			thread maps/mp/bots/_bots_util::bot_force_stance_for_time("stand",5);
			thread bot_sentry_cancel_failsafe();
			maps/mp/bots/_bots_ks::bot_switch_to_killstreak_weapon(param_00.object.killstreak_info,param_00.object.killstreaks_array,param_00.object.weapon);
		}

		wait(0.05);
	}
}

//Function Number: 7
bot_sentry_choose_target(param_00)
{
	var_01 = maps/mp/bots/_bots_util::defend_valid_center();
	if(isdefined(var_01))
	{
		return var_01;
	}

	if(isdefined(self.node_ambushing_from))
	{
		return self.node_ambushing_from.origin;
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
bot_sentry_choose_placement(param_00,param_01,param_02,param_03)
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
		var_04 = addstruct();
		var_04.node = var_07;
		if(param_01 != var_07.origin && param_02 != "hide_nonlethal")
		{
			var_04.yaw = vectortoyaw(param_01 - var_07.origin);
		}
		else
		{
			var_04.yaw = undefined;
		}

		var_04.weapon = param_00.weapon;
		var_04.killstreak_info = param_00;
		var_04.killstreaks_array = param_03;
	}

	return var_04;
}

//Function Number: 9
bot_sentry_carried_obj()
{
	if(isdefined(self.carriedsentry))
	{
		return self.carriedsentry;
	}

	if(isdefined(self.carriedims))
	{
		return self.carriedims;
	}

	if(isdefined(self.carrieditem))
	{
		return self.carrieditem;
	}
}

//Function Number: 10
bot_sentry_activate(param_00)
{
	var_01 = 0;
	var_02 = bot_sentry_carried_obj();
	if(isdefined(var_02))
	{
		var_03 = 0;
		if(!var_02.canbeplaced)
		{
			var_04 = 0.75;
			var_05 = gettime();
			var_06 = self.angles[1];
			if(isdefined(param_00.object.yaw))
			{
				var_06 = param_00.object.yaw;
			}

			var_07 = [];
			var_07[0] = var_06 + 180;
			var_07[1] = var_06 + 135;
			var_07[2] = var_06 - 135;
			var_08 = 1000;
			foreach(var_0A in var_07)
			{
				var_0B = playerphysicstrace(param_00.object.node.origin,param_00.object.node.origin + anglestoforward((0,var_0A + 180,0)) * 100);
				var_0C = distance2d(var_0B,param_00.object.node.origin);
				if(var_0C < var_08)
				{
					var_08 = var_0C;
					self botsetscriptmove(var_0A,var_04);
					self botlookatpoint(param_00.object.node.origin,var_04,"script_forced");
				}
			}

			while(!var_03 && isdefined(var_02) && !var_02.canbeplaced)
			{
				var_0E = castfloat(gettime() - var_05) / 1000;
				if(!var_02.canbeplaced && var_0E > var_04)
				{
					var_03 = 1;
					self.sentry_place_delay = gettime() + 30000;
				}

				wait(0.05);
			}
		}

		if(isdefined(var_02) && var_02.canbeplaced)
		{
			func_167C();
			var_01 = 1;
		}
	}

	wait(0.25);
	bot_sentry_ensure_exit();
	return var_01;
}

//Function Number: 11
func_167C()
{
	self notify("place_sentry");
	self notify("place_ims");
	self notify("placePlaceable");
}

//Function Number: 12
bot_send_cancel_notify()
{
	self switchtoweapon("none");
	self enableweapons();
	self enableweaponswitch();
	self notify("cancel_sentry");
	self notify("cancel_ims");
	self notify("cancelPlaceable");
}

//Function Number: 13
func_167F(param_00)
{
	self notify("bot_sentry_canceled");
	bot_send_cancel_notify();
	bot_sentry_ensure_exit();
}

//Function Number: 14
bot_sentry_ensure_exit()
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
	while(isdefined(bot_sentry_carried_obj()))
	{
		var_00++;
		bot_send_cancel_notify();
		wait(0.25);
		if(var_00 > 2)
		{
			bot_sentry_force_cancel();
		}
	}

	self notify("bot_sentry_exited");
}

//Function Number: 15
bot_sentry_force_cancel()
{
	if(isdefined(self.carriedsentry))
	{
		self.carriedsentry maps\mp\killstreaks\_autosentry::func_6DEA();
	}

	if(isdefined(self.carriedims))
	{
		self.carriedims maps\mp\killstreaks\_ims::ims_setcancelled();
	}

	if(isdefined(self.carrieditem))
	{
		self.carrieditem lib_0614::func_58FF(self.placingitemstreakname,0);
	}

	self.carriedsentry = undefined;
	self.carriedims = undefined;
	self.carrieditem = undefined;
	self switchtoweapon("none");
	self enableweapons();
	self enableweaponswitch();
}