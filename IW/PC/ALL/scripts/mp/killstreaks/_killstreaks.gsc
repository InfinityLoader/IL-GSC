/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_killstreaks.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 101
 * Decompile Time: 5065 ms
 * Timestamp: 10/27/2023 12:29:02 AM
*******************************************************************/

//Function Number: 1
func_9888()
{
	level.var_A697 = [];
	var_00 = 1;
	for(;;)
	{
		var_01 = scripts\mp\_utility::func_7F4B(var_00);
		if(!isdefined(var_01) || var_01 == "")
		{
			break;
		}

		var_02 = var_01;
		var_03 = scripts\mp\_utility::func_7F3C(var_02);
		var_04 = scripts\mp\_utility::func_7F3B(var_02);
		game["dialog"][var_02] = var_04;
		var_05 = scripts\mp\_utility::func_7F34(var_02);
		game["dialog"]["allies_friendly_" + var_02 + "_inbound"] = "friendly_" + var_05;
		game["dialog"]["allies_enemy_" + var_02 + "_inbound"] = "enemy_" + var_05;
		var_06 = scripts\mp\_utility::func_7F3E(var_02);
		game["dialog"]["axis_friendly_" + var_02 + "_inbound"] = "friendly_" + var_06;
		game["dialog"]["axis_enemy_" + var_02 + "_inbound"] = "enemy_" + var_06;
		var_07 = scripts\mp\_utility::func_7F4E(var_02);
		scripts\mp\_rank::func_DF0A("killstreak_" + var_02,"value",var_07);
		level.var_A697[level.var_A697.size] = var_02;
		var_00++;
	}
}

//Function Number: 2
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(!isdefined(var_00.pers["killstreaks"]))
		{
			var_00.pers["killstreaks"] = [];
		}

		if(!isdefined(var_00.pers["startedMapSelect"]))
		{
			var_00.pers["startedMapSelect"] = 0;
		}

		var_00 visionsetmissilecamforplayer(game["thermal_vision"]);
		var_00 thread func_C57B();
		var_00 thread func_B9CB();
		var_00 thread func_110C3();
		var_00 thread monitorrigswitch();
	}
}

//Function Number: 3
func_C57B()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self.var_13111 = undefined;
		func_F1C5();
		thread func_A6BA();
		thread func_A69C();
		thread func_A69B();
		thread func_A69D();
		thread func_A6B8();
		thread func_A6B0();
		thread func_FAC6();
		if(!isdefined(self.var_5FBE))
		{
			self.var_5FBE = 0;
		}

		if(!scripts\mp\_utility::func_9FB3(self.var_AE15))
		{
			scripts\mp\_utility::initpersstat("streakPoints");
			self.var_110EE = scripts\mp\_utility::getpersstat("streakPoints");
			self.var_AE15 = 1;
		}

		func_F866();
		func_12EBC();
		func_12F2E(self.var_110EE);
	}
}

//Function Number: 4
monitorrigswitch()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		self waittill("giveLoadout");
		if(scripts\mp\_utility::func_9FB3(level.var_3B1E))
		{
			continue;
		}

		if(isdefined(self.oldperks) && isdefined(self.var_CA5B) && self.oldperks.size > 0)
		{
			if(scripts\mp\_utility::func_2287(self.var_CA5B,"specialty_support_killstreaks") && scripts\mp\_utility::func_2287(self.oldperks,"specialty_support_killstreaks"))
			{
				continue;
			}
			else if(!scripts\mp\_utility::func_2287(self.oldperks,"specialty_support_killstreaks"))
			{
				continue;
			}
			else
			{
				func_E275();
				func_12EBC();
			}
		}
	}
}

//Function Number: 5
func_B9CB()
{
	while(isdefined(self))
	{
		if(scripts\mp\_utility::func_2DD9())
		{
			self waittill("disconnect");
			continue;
		}

		scripts\common\utility::waittill_any_3("disconnect","joined_team","joined_spectators");
		self notify("killstreak_disowned");
	}
}

//Function Number: 6
func_FAC6()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(isbot(self))
	{
		return;
	}

	scripts\mp\_utility::func_7670("prematch_done");
	self notifyonplayercommand("ks_select_up","+actionslot 1");
	self notifyonplayercommand("ks_select_down","+actionslot 2");
	self notifyonplayercommand("ks_action_3","+actionslot 3");
	self notifyonplayercommand("ks_action_4","+actionslot 4");
	self notifyonplayercommand("ks_action_5","+actionslot 5");
	self notifyonplayercommand("ks_action_6","+actionslot 6");
	scripts\mp\_utility::_setactionslot(4,"");
}

//Function Number: 7
func_12F2F()
{
	if(!isdefined(self.pers["killstreaks"]))
	{
		return;
	}

	if(self.var_110EE == self.var_D8B3)
	{
		return;
	}

	var_00 = self.var_110EE;
	self method_80BF(int(min(self.var_110EE,16384)));
	if(self.var_110EE >= self.var_BFB0)
	{
		func_F866();
	}
}

//Function Number: 8
func_E274()
{
	self method_80BF(0);
	self setclientomnvar("ui_score_streak_cost",0);
	self setclientomnvar("ui_score_streak_two_cost",0);
	self setclientomnvar("ui_score_streak_three_cost",0);
	func_F866();
}

//Function Number: 9
func_F866()
{
	if(!isdefined(self.var_110F4))
	{
		self.var_BFB0 = 0;
		self method_80C0(0);
		return;
	}

	if(func_7FA2() == 0)
	{
		self.var_BFB0 = 0;
		self method_80C0(0);
		return;
	}

	var_00 = self.var_BFB0;
	var_01 = func_7FEE();
	if(!isdefined(var_01))
	{
		return;
	}

	var_02 = func_817B(var_01);
	self.var_BFB0 = var_02;
	if(scripts\mp\_utility::_hasperk("specialty_support_killstreaks") && isdefined(self.pers["killstreaks"][1]) && !scripts\mp\_utility::func_9FB3(self.var_5FBD))
	{
		var_03 = 0;
		foreach(var_05 in self.pers["killstreaks"])
		{
			if(scripts\mp\_utility::func_9FB3(var_05.var_5FB9))
			{
				var_03 = 1;
				continue;
			}

			var_03 = 0;
		}

		if(var_03 && !isdefined(self.var_5FBD))
		{
			self.var_5FBD = 1;
			self.var_BFB0 = 0;
			self method_80C0(0);
			self method_80BF(0);
			self setclientomnvar("ui_score_streak_cost",0);
			self setclientomnvar("ui_score_streak_two_cost",0);
			self setclientomnvar("ui_score_streak_three_cost",0);
			scripts\mp\_hud_message::func_10122("KILLSTREAKS_SUPPORT_NO_WRAP");
			return;
		}
	}

	self method_80C0(var_02);
}

//Function Number: 10
func_7FEE()
{
	if(self.var_110EE == func_7FA2() && self.var_110F4 != "specialist")
	{
		var_00 = 0;
	}
	else
	{
		var_00 = self.var_110EE;
	}

	foreach(var_02 in self.var_A6AB)
	{
		var_03 = func_817B(var_02);
		if(var_03 > var_00)
		{
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 11
func_12F2E(param_00)
{
	if(scripts\mp\_utility::func_9FB3(self.var_5FBD) && scripts\mp\_utility::_hasperk("specialty_support_killstreaks"))
	{
		self setclientomnvar("ui_score_streak",0);
		self setclientomnvar("ui_score_streak_two",0);
		self setclientomnvar("ui_score_streak_three",0);
		self setclientomnvar("ui_score_streak_cost",0);
		self setclientomnvar("ui_score_streak_two_cost",0);
		self setclientomnvar("ui_score_streak_three_cost",0);
		self setclientomnvar("ui_score_streak",0);
		return;
	}

	var_01 = 0;
	if(isdefined(self.var_A6AB))
	{
		foreach(var_03 in self.var_A6AB)
		{
			if(var_01 == 0)
			{
				var_04 = func_817B(var_03);
				self setclientomnvar("ui_score_streak_cost",var_04);
				self setclientomnvar("ui_score_streak",param_00);
				var_01++;
				continue;
			}

			if(var_01 == 1)
			{
				var_04 = func_817B(var_03);
				self setclientomnvar("ui_score_streak_two_cost",var_04);
				self setclientomnvar("ui_score_streak_two",param_00);
				var_01++;
				continue;
			}

			var_04 = func_817B(var_03);
			self setclientomnvar("ui_score_streak_three_cost",var_04);
			self setclientomnvar("ui_score_streak_three",param_00);
		}
	}
}

//Function Number: 12
func_7FA2()
{
	var_00 = 0;
	foreach(var_02 in self.var_A6AB)
	{
		var_03 = func_817B(var_02);
		if(var_03 > var_00)
		{
			var_00 = var_03;
		}
	}

	return var_00;
}

//Function Number: 13
func_12EBC()
{
	if(!scripts\mp\_utility::func_9F19(self))
	{
		return;
	}

	var_00 = self.pers["killstreaks"];
	for(var_01 = 0;var_01 <= 3;var_01++)
	{
		var_02 = var_00[var_01];
		if(isdefined(var_02) && isdefined(var_02.var_110EA))
		{
			self setclientomnvar("ui_score_streak_index_" + var_01,scripts\mp\_utility::func_7F44(var_02.var_110EA));
			self setclientomnvar("ui_score_streak_available_" + var_01,var_00[var_01].var_269A);
			continue;
		}

		self setclientomnvar("ui_score_streak_index_" + var_01,0);
		self setclientomnvar("ui_score_streak_available_" + var_01,0);
	}

	var_03 = func_8111();
	if(isdefined(var_03))
	{
		self setclientomnvar("ui_score_streak_selected_slot",var_03);
		return;
	}

	self setclientomnvar("ui_score_streak_selected_slot",-1);
}

//Function Number: 14
func_A6B8()
{
	self endon("disconnect");
	self endon("faux_spawn");
	self notify("killstreakTeamChangeWatcher");
	self endon("killstreakTeamChangeWatcher");
	for(;;)
	{
		self waittill("joined_team");
		func_41C0();
	}
}

//Function Number: 15
func_A6BA()
{
	self endon("disconnect");
	self endon("death");
	self endon("joined_team");
	self endon("faux_spawn");
	self endon("spawned");
	level endon("game_ended");
	self notify("killstreakTriggeredWatcher");
	self endon("killstreakTriggeredWatcher");
	for(;;)
	{
		var_00 = scripts\common\utility::func_13734("ks_action_3","ks_action_4","ks_action_5","ks_action_6");
		var_01 = func_81D9(var_00);
		if(!isdefined(var_01))
		{
			continue;
		}

		var_02 = func_7F45(var_01);
		if(!isdefined(var_02) || !var_02.var_269A)
		{
			continue;
		}

		if(!scripts\common\utility::func_9FBE())
		{
			scripts\mp\_hud_message::func_10122("KILLSTREAKS_CANNOT_BE_USED",undefined);
			continue;
		}

		if(isdefined(var_02.var_394))
		{
			var_03 = func_392B(var_02.var_394,var_02);
			if(isdefined(var_03))
			{
				var_04 = undefined;
				if(var_03 == "KILLSTREAKS_UNAVAILABLE_FOR_N")
				{
					var_04 = level.var_A6AA - level.var_8487 - level.ingraceperiod;
				}

				scripts\mp\_hud_message::func_10122(var_03,var_04);
				continue;
			}
		}

		if(isdefined(self.var_13111))
		{
			self notify("killstreak_trigger_blocked",var_02);
			continue;
		}

		var_05 = var_02.var_110F1;
		if(isdefined(var_05.var_127BD))
		{
			if(!self [[ var_05.var_127BD ]](var_02))
			{
				continue;
			}
		}

		self.var_AA35 = var_02;
		if(!scripts\common\utility::func_9C70())
		{
			func_F837(var_01);
		}

		if(var_02.var_EF88 == "no_fire_weapon")
		{
			thread func_127C7(var_02.var_394,var_02,1);
		}
		else if(var_02.var_EF88 == "gesture_script_weapon")
		{
			self giveandfireoffhand(var_02.var_394);
		}
		else if(isdefined(var_02.var_394) && var_02.var_394 != "none")
		{
			thread func_127C7(var_02.var_394,var_02);
		}
		else
		{
			var_01 = func_8111();
			thread func_A69A(var_02);
		}

		var_06 = int(tablelookup("mp/killstreaktable.csv",1,var_02.var_110EA,4));
		if(var_06 >= 1000)
		{
			var_07 = tablelookup("mp/killstreaktable.csv",1,var_02.var_110EA,0);
			if(var_07 != "")
			{
				var_08 = int(var_07);
				scripts\mp\_utility::func_F79E(20,self.team,self getentitynumber(),var_08);
			}
		}
	}
}

//Function Number: 16
func_81D9(param_00)
{
	var_01 = undefined;
	if(!isai(self) && scripts\common\utility::func_9C70())
	{
		if(param_00 == "ks_action_4")
		{
			var_01 = func_8111();
		}
	}
	else if(level.gametype == "grnd" && !scripts\common\utility::func_9C70())
	{
		switch(param_00)
		{
			case "ks_action_3":
				var_01 = 0;
				break;

			case "ks_action_4":
				var_01 = 0;
				break;

			case "ks_action_5":
				var_01 = 0;
				break;

			case "ks_action_6":
				var_01 = 0;
				break;
		}
	}
	else
	{
		switch(param_00)
		{
			case "ks_action_3":
				var_01 = 1;
				break;

			case "ks_action_4":
				var_01 = 2;
				break;

			case "ks_action_5":
				var_01 = 3;
				break;

			case "ks_action_6":
				var_01 = 0;
				break;
		}
	}

	return var_01;
}

//Function Number: 17
func_392B(param_00,param_01)
{
	if(scripts\mp\_utility::func_10060(param_01.var_110EA))
	{
		if(isdefined(level.var_A6AA) && level.var_A6AA > 0)
		{
			if(level.var_8487 - level.ingraceperiod < level.var_A6AA)
			{
				return "KILLSTREAKS_UNAVAILABLE_FOR_N";
			}
		}
	}

	if(self hasweapon(param_00))
	{
		return "KILLSTREAKS_CANNOT_BE_USED";
	}

	if(self method_81B5())
	{
		return "KILLSTREAKS_CANNOT_BE_USED";
	}

	if(self ismantling())
	{
		return "KILLSTREAKS_CANNOT_BE_USED";
	}

	if(!scripts\common\utility::func_A009())
	{
		return "KILLSTREAKS_CANNOT_BE_USED";
	}

	if(scripts\mp\_utility::func_9FAE(self))
	{
		return "KILLSTREAKS_CANNOT_BE_USED";
	}

	if((scripts\mp\_utility::func_9F2C(param_01.var_110EA) || scripts\mp\_utility::func_9E90(param_01.var_110EA)) && !self isonground() || self method_8446())
	{
		return "KILLSTREAKS_CANNOT_BE_USED";
	}
}

//Function Number: 18
func_127C7(param_00,param_01,param_02)
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	if(self hasweapon(param_00))
	{
		return 0;
	}

	self.tryingtousekillstreak = 1;
	thread triggerkillstreakweaponwatchdeath();
	scripts\mp\_supers::func_1CAB();
	scripts\mp\_utility::func_12C6(param_00,0,0,1);
	var_03 = param_01.var_110F1;
	if(isdefined(var_03.var_13C8D))
	{
		var_04 = self [[ var_03.var_13C8D ]](param_01);
		if(isdefined(var_04) && var_04 == 0)
		{
			scripts\mp\_utility::func_141E(param_00);
			self.tryingtousekillstreak = undefined;
			self notify("stopTryingToUseKillstreak");
			return;
		}
	}

	var_05 = scripts\mp\_utility::func_11383(param_00);
	if(isdefined(var_03.var_13CD6))
	{
		self [[ var_03.var_13CD6 ]](param_01,var_05);
	}

	if(var_05)
	{
		if(scripts\mp\_utility::func_9FB3(param_02))
		{
			thread func_510E(0.05,param_01);
		}

		self waittill("killstreak_finished_with_weapon_" + param_00);
	}

	self.tryingtousekillstreak = undefined;
	self notify("stopTryingToUseKillstreak");
	if(self hasweapon(param_00))
	{
		scripts\mp\_supers::func_12D6C();
		scripts\mp\_utility::func_80F2(param_00);
		if(self getcurrentweapon() == "none")
		{
			scripts\mp\_utility::_switchtoweapon(self.var_A978);
		}
	}

	if(isdefined(var_03.var_13CDB))
	{
		self [[ var_03.var_13CDB ]](param_01);
	}
}

//Function Number: 19
triggerkillstreakweaponwatchdeath()
{
	self endon("disconnect");
	self endon("stopTryingToUseKillstreak");
	self waittill("death");
	self.tryingtousekillstreak = undefined;
}

//Function Number: 20
func_510E(param_00,param_01)
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	wait(param_00);
	thread func_A69A(param_01);
}

//Function Number: 21
func_13B96(param_00)
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	self endon("killstreak_finished_with_weapon");
	for(;;)
	{
		if(self getcurrentweapon() != param_00)
		{
			self notify("killstreak_finished_with_weapon_" + param_00);
			break;
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 22
func_A69C()
{
	self endon("disconnect");
	self endon("death");
	self endon("joined_team");
	self endon("faux_spawn");
	self endon("spawned");
	level endon("game_ended");
	self notify("killstreakFiredWatcher_offhand");
	self endon("killstreakFiredWatcher_offhand");
	for(;;)
	{
		self waittill("offhand_fired",var_00);
		thread func_128A4(var_00,"offhand_fired");
	}
}

//Function Number: 23
func_A69B()
{
	self endon("disconnect");
	self endon("death");
	self endon("joined_team");
	self endon("faux_spawn");
	self endon("spawned");
	level endon("game_ended");
	self notify("killstreakFiredWatcher_grenade");
	self endon("killstreakFiredWatcher_grenade");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		thread func_128A4(var_01,"grenade_fire",var_00);
	}
}

//Function Number: 24
func_A69D()
{
	self endon("disconnect");
	self endon("death");
	self endon("joined_team");
	self endon("faux_spawn");
	self endon("spawned");
	level endon("game_ended");
	self notify("killstreakFiredWatcher_weaponFired");
	self endon("killstreakFiredWatcher_weaponFired");
	for(;;)
	{
		self waittill("weapon_fired",var_00);
		thread func_128A4(var_00,"weapon_fired");
	}
}

//Function Number: 25
func_128A4(param_00,param_01,param_02)
{
	var_03 = func_7F61();
	if(!isdefined(var_03))
	{
		return;
	}

	if(var_03.var_394 != param_00)
	{
		return;
	}

	var_04 = self.pers["killstreaks"];
	var_05 = undefined;
	for(var_06 = 0;var_06 < 36;var_06++)
	{
		if(!isdefined(var_04[var_06]))
		{
			if(var_06 >= 4)
			{
				break;
			}
			else
			{
				continue;
			}
		}

		if(var_04[var_06] == var_03)
		{
			var_05 = var_06;
			break;
		}
	}

	if(!isdefined(var_05))
	{
		return;
	}

	if(var_03.var_6D6B == param_01)
	{
		thread func_A69A(var_03,param_02);
	}
}

//Function Number: 26
func_9E6B(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	switch(param_00)
	{
		case "jammer":
		case "dronedrop":
		case "directional_uav":
		case "counter_uav":
		case "uav":
			return 0;

		default:
			return 1;
	}
}

//Function Number: 27
func_A69A(param_00,param_01)
{
	self endon("disconnect");
	self endon("joined_team");
	level endon("game_ended");
	var_02 = param_00.var_110F1;
	if(!scripts\mp\_utility::validateusestreak(param_00.var_110EA))
	{
		if(isdefined(var_02.var_9B12))
		{
			self [[ var_02.var_9B12 ]](param_00);
		}

		if(isdefined(param_00.var_394) && param_00.var_394 != "none")
		{
			self notify("killstreak_finished_with_weapon_" + param_00.var_394);
		}

		return 0;
	}

	if(getdvarint("com_codcasterEnabled",0) == 1)
	{
		if(func_9E6B(param_00.var_110EA))
		{
			self method_80C3(1);
		}
	}

	self.var_13111 = param_00;
	var_03 = 1;
	if(isdefined(var_02.var_13089))
	{
		var_03 = self [[ var_02.var_13089 ]](param_00);
	}

	var_04 = 1;
	if(isdefined(var_02.var_130C4))
	{
		var_04 = self [[ var_02.var_130C4 ]](param_00,param_01);
	}

	self notify("killstreak_use_finished",param_00.var_110EA,var_03);
	self.var_13111 = undefined;
	if(getdvarint("com_codcasterEnabled",0) == 1)
	{
		self method_80C3(0);
	}

	if(!var_03 || !var_04)
	{
		return 0;
	}

	func_C5A9(param_00);
}

//Function Number: 28
func_729F(param_00,param_01)
{
	var_02 = func_4A1C(param_00,param_01);
	func_A69A(var_02);
}

//Function Number: 29
func_729E()
{
	var_00 = func_7F45(0);
	func_A69A(var_00,0);
}

//Function Number: 30
func_C5A9(param_00)
{
	var_01 = param_00.var_110EA;
	var_02 = func_6CBA(param_00);
	param_00.var_269A = 0;
	if(isdefined(var_02))
	{
		if(var_02 == 0 || var_02 >= 4)
		{
			func_E131(var_02);
		}

		func_F1CB();
	}
	else
	{
	}

	thread scripts\mp\_killstreak_loot::func_89BC(param_00);
	thread scripts\mp\_missions::func_13079(var_01);
	scripts\mp\_utility::func_D915("killstreak started - " + var_01,self);
	self notify("killstreak_used",var_01);
	scripts\mp\_utility::func_D4B7(var_01);
	var_06 = gettime() - param_00.var_B143;
	scripts\mp\_analyticslog::func_AFA3(var_01,var_06);
	combatrecordkillstreakuse(var_01);
}

//Function Number: 31
func_DDF0(param_00)
{
	if(isdefined(self.var_4006))
	{
		if(self getplayerdata(level.var_AEA6,"squadMembers","killstreakSetups",0,"killstreak") == param_00)
		{
			self.var_6DEB = gettime();
			return;
		}

		if(self getplayerdata(level.var_AEA6,"squadMembers","killstreakSetups",2,"killstreak") == param_00 && isdefined(self.var_6DEB))
		{
			if(gettime() - self.var_6DEB < 20000)
			{
				thread scripts\mp\_missions::func_D992("wargasm");
				return;
			}

			return;
		}
	}
}

//Function Number: 32
func_4A1C(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.var_269A = 0;
	var_03.var_110EA = param_00;
	var_03.var_9E0B = 0;
	var_03.var_FFC4 = 0;
	var_03.var_222 = param_01;
	var_03.var_A5B0 = func_81ED(self);
	var_03.var_AC68 = self.pers["deaths"];
	var_03.var_9E10 = 0;
	var_03.var_9F6E = 0;
	var_03.var_394 = scripts\mp\_utility::func_7F55(param_00);
	var_03.var_6D6B = func_7F41(param_00);
	var_03.var_110F1 = func_7F50(param_00);
	var_03.var_EF88 = scripts\mp\_utility::func_7F4F(param_00);
	var_03.var_B143 = -1;
	var_03.var_1318B = param_02;
	return var_03;
}

//Function Number: 33
func_81ED(param_00)
{
	if(!isdefined(param_00.pers["nextKillstreakID"]))
	{
		param_00.pers["nextKillstreakID"] = 0;
	}

	var_01 = param_00.pers["nextKillstreakID"];
	param_00.pers["nextKillstreakID"]++;
	return var_01;
}

//Function Number: 34
func_26D4(param_00,param_01,param_02,param_03)
{
	var_04 = func_4A1C(param_00,param_01,param_03);
	func_26D5(var_04,param_02);
}

//Function Number: 35
func_26D5(param_00,param_01)
{
	param_00.var_9E10 = 1;
	if(isdefined(param_01) && param_01.size > 0)
	{
		scripts\mp\_killstreak_loot::func_988A(param_00,param_01);
	}

	func_1030D(param_00,0);
	func_F837(0);
	func_B2A9(0);
}

//Function Number: 36
func_6693(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_00) || !isdefined(param_01))
	{
		return;
	}

	var_04 = func_4A1C(param_00,self,param_03);
	var_04.var_9E0B = 1;
	var_04.var_FFC4 = 1;
	if(isdefined(param_02) && param_02.size > 0)
	{
		scripts\mp\_killstreak_loot::func_988A(var_04,param_02);
	}

	func_1030D(var_04,param_01);
}

//Function Number: 37
func_66B9(param_00,param_01,param_02)
{
	func_6693(param_00,1,param_01,param_02);
}

//Function Number: 38
func_66BB(param_00,param_01,param_02)
{
	func_6693(param_00,2,param_01,param_02);
}

//Function Number: 39
func_66BA(param_00,param_01,param_02)
{
	func_6693(param_00,3,param_01,param_02);
}

//Function Number: 40
func_DB1C()
{
	var_00 = self.pers["killstreaks"];
	if(isdefined(var_00[35]))
	{
		return 0;
	}

	var_01 = var_00[0];
	if(!isdefined(var_01))
	{
		return 1;
	}

	for(var_02 = 4;var_02 < 36;var_02++)
	{
		if(!isdefined(var_00[var_02]))
		{
			var_00[var_02] = var_01;
			var_00[0] = undefined;
			break;
		}
	}

	self.pers["killstreaks"] = var_00;
	return 1;
}

//Function Number: 41
func_D65E()
{
	var_00 = self.pers["killstreaks"];
	var_01 = var_00[0];
	var_02 = undefined;
	var_03 = undefined;
	for(var_04 = 4;var_04 < 36;var_04++)
	{
		var_05 = var_00[var_04];
		if(isdefined(var_05))
		{
			var_02 = var_05;
			var_03 = var_04;
			continue;
		}

		break;
	}

	self.pers["killstreaks"][0] = var_02;
	if(isdefined(var_03))
	{
		self.pers["killstreaks"][var_03] = undefined;
	}
}

//Function Number: 42
func_51D3(param_00)
{
	if(param_00 == 35)
	{
		self.pers["killstreaks"][param_00] = undefined;
		return;
	}

	var_01 = self.pers["killstreaks"];
	for(var_02 = param_00;var_02 < 35;var_02++)
	{
		var_03 = var_01[var_02 + 1];
		if(!isdefined(var_03))
		{
			break;
		}

		var_01[param_00] = var_03;
	}

	self.pers["killstreaks"] = var_01;
}

//Function Number: 43
func_E131(param_00)
{
	self.pers["killstreaks"][param_00] = undefined;
	if(param_00 == 0)
	{
		func_D65E();
		return;
	}

	if(param_00 >= 4)
	{
		func_51D3(param_00);
	}
}

//Function Number: 44
func_41C0()
{
	self.pers["killstreaks"] = [];
	func_E275();
	func_41C1();
	func_12EBC();
}

//Function Number: 45
func_1030D(param_00,param_01)
{
	if(param_01 == 0)
	{
		if(!func_DB1C())
		{
			return;
		}
	}
	else
	{
	}

	self.pers["killstreaks"][param_01] = param_00;
	func_12EBC();
}

//Function Number: 46
func_5FBF(param_00,param_01)
{
	var_02 = func_7F45(param_00);
	var_03 = var_02.var_110EA;
	scripts\mp\_utility::func_316C("earned_killstreak_buffered",var_03);
	self.var_5FBE = param_01;
	if(scripts\mp\_utility::_hasperk("specialty_support_killstreaks"))
	{
		self.pers["killstreaks"][param_00].var_5FB9 = 1;
	}

	if(!level.var_7669)
	{
		var_04 = var_03;
		var_05 = scripts\mp\_killstreak_loot::getrarityforlootitem(var_02.var_1318B);
		if(var_05 != "")
		{
			var_04 = var_04 + "_" + var_05;
		}

		thread scripts\mp\_hud_message::func_10134(var_04,param_01);
	}

	if(scripts\mp\_utility::_hasperk("specialty_support_killstreaks"))
	{
		scripts\mp\_missions::func_D991("ch_trait_support");
	}

	func_DDF0(var_03);
	func_F866();
	func_B2A9(param_00);
}

//Function Number: 47
func_B2A9(param_00)
{
	var_01 = func_7F45(param_00);
	if(!isdefined(var_01))
	{
		return;
	}

	var_02 = var_01.var_110EA;
	var_03 = var_01.var_110F1;
	if(self.team == "spectator")
	{
		return;
	}

	var_01.var_269A = 1;
	if(param_00 >= 0 && param_00 <= 3)
	{
		func_F837(param_00);
	}

	func_12EBC();
	if(isdefined(var_03.var_26A2))
	{
		self [[ var_03.var_26A2 ]](var_01);
	}

	if(isdefined(var_01.var_9E0B) && var_01.var_9E0B && isdefined(var_01.var_FFC4) && var_01.var_FFC4)
	{
		self notify("received_earned_killstreak");
	}

	var_01.var_B143 = gettime();
	var_04 = scripts\mp\_utility::func_7F44(var_02);
	scripts\mp\_analyticslog::func_AFA4(var_04,var_01.var_B143);
	scripts\mp\_matchdata::func_AFC8(var_02);
}

//Function Number: 48
func_8374(param_00,param_01,param_02,param_03)
{
	func_26D4(param_00,param_03);
}

//Function Number: 49
func_817B(param_00)
{
	var_01 = int(scripts\mp\_utility::func_7F46(param_00));
	if(isdefined(self) && isplayer(self))
	{
		var_01 = scripts\mp\_killstreak_loot::modifycostforlootitem(self.streakvariantids[param_00],var_01);
		if(scripts\mp\_utility::func_9F6F(param_00))
		{
			if(isdefined(self.pers["gamemodeLoadout"]))
			{
				if(isdefined(self.pers["gamemodeLoadout"]["loadoutKillstreak1"]) && self.pers["gamemodeLoadout"]["loadoutKillstreak1"] == param_00)
				{
					var_01 = 2;
				}
				else if(isdefined(self.pers["gamemodeLoadout"]["loadoutKillstreak2"]) && self.pers["gamemodeLoadout"]["loadoutKillstreak2"] == param_00)
				{
					var_01 = 4;
				}
				else if(isdefined(self.pers["gamemodeLoadout"]["loadoutKillstreak3"]) && self.pers["gamemodeLoadout"]["loadoutKillstreak3"] == param_00)
				{
					var_01 = 6;
				}
				else
				{
				}
			}
			else if(issubstr(self.var_4B1C,"custom"))
			{
				for(var_02 = 0;var_02 < 3;var_02++)
				{
					var_03 = self getplayerdata(level.var_AEA6,"squadMembers","loadouts",self.var_4006,"specialistStreaks",var_02);
					if(var_03 == param_00)
					{
						break;
					}
				}

				if(var_02 == 1)
				{
					var_01 = 500;
				}
				else if(var_02 == 2)
				{
					var_01 = 800;
				}
			}
			else if(issubstr(self.var_4B1C,"callback"))
			{
				var_02 = 0;
				foreach(var_05 in self.pers["specialistStreaks"])
				{
					if(var_05 == param_00)
					{
						break;
					}
				}

				var_01 = self.pers["specialistStreakKills"][var_02];
			}
			else if(issubstr(self.var_4B1C,"axis") || issubstr(self.var_4B1C,"allies"))
			{
				var_02 = 0;
				var_06 = "none";
				if(issubstr(self.var_4B1C,"axis"))
				{
					var_06 = "axis";
				}
				else if(issubstr(self.var_4B1C,"allies"))
				{
					var_06 = "allies";
				}

				var_07 = scripts\mp\_utility::func_7E2B(self.var_4B1C);
				while(var_02 < 3)
				{
					var_03 = scripts\mp\_utility::func_7F91("defaultClasses",var_06,var_07,"class","specialistStreaks",var_02);
					if(var_03 == param_00)
					{
						break;
					}

					var_02++;
				}

				var_01 = scripts\mp\_utility::func_7F91("defaultClasses",var_06,var_07,"class","specialistStreakKills",var_02);
			}
		}
	}

	var_01 = int(clamp(var_01,0,7000));
	return var_01;
}

//Function Number: 50
func_8057(param_00,param_01)
{
	var_02 = 0;
	if(scripts\mp\_utility::_hasperk("specialty_support_killstreaks"))
	{
		var_03 = scripts\mp\_utility::func_7F44(param_00);
		var_02 = 175 * var_03;
	}

	return var_02;
}

//Function Number: 51
func_A6B0()
{
	self endon("death");
	self endon("disconnect");
	self endon("faux_spawn");
	level endon("game_ended");
	for(;;)
	{
		var_00 = scripts\common\utility::func_13734("ks_select_up","ks_select_down");
		if(!scripts\common\utility::func_9C70())
		{
			continue;
		}

		if(!scripts\mp\_utility::func_9E59() && !scripts\mp\_utility::func_9FB3(self.var_9D81) && !isdefined(self.var_13111))
		{
			var_01 = func_8111();
			if(!isdefined(var_01))
			{
				continue;
			}

			var_02 = var_01;
			if(var_00 == "ks_select_up")
			{
				var_02 = func_7FED(var_01);
			}
			else if(var_00 == "ks_select_down")
			{
				var_02 = func_8099(var_01);
			}
			else
			{
			}

			func_F837(var_02);
		}
	}
}

//Function Number: 52
func_F1C5()
{
	var_00 = self.pers["killstreaks"];
	for(var_01 = 3;var_01 >= 0;var_01--)
	{
		var_02 = var_00[var_01];
		if(isdefined(var_02) && var_02.var_269A)
		{
			func_F837(var_01);
			return;
		}
	}

	func_41C1();
}

//Function Number: 53
func_7FED(param_00)
{
	var_01 = self.pers["killstreaks"];
	var_02 = param_00;
	var_03 = scripts\common\utility::func_116D7(param_00 >= 3,0,param_00 + 1);
	var_04 = param_00;
	var_05 = var_03;
	while(var_05 != var_04)
	{
		var_06 = var_01[var_05];
		if(isdefined(var_06) && var_06.var_269A)
		{
			var_02 = var_05;
			break;
		}

		var_05++;
		if(var_05 > 3)
		{
			var_05 = 0;
		}
	}

	return var_02;
}

//Function Number: 54
func_8099(param_00)
{
	var_01 = self.pers["killstreaks"];
	var_02 = param_00;
	var_03 = scripts\common\utility::func_116D7(param_00 <= 0,3,param_00 - 1);
	var_04 = param_00;
	var_05 = var_03;
	while(var_05 != var_04)
	{
		var_06 = var_01[var_05];
		if(isdefined(var_06) && var_06.var_269A)
		{
			var_02 = var_05;
			break;
		}

		var_05--;
		if(var_05 < 0)
		{
			var_05 = 3;
		}
	}

	return var_02;
}

//Function Number: 55
func_F1CB()
{
	var_00 = self.pers["killstreaks"];
	var_01 = undefined;
	var_02 = -1;
	for(var_03 = 3;var_03 >= 0;var_03--)
	{
		var_04 = var_00[var_03];
		if(isdefined(var_04) && var_04.var_269A)
		{
			var_05 = func_817B(var_04.var_110EA);
			if(var_05 > var_02)
			{
				var_01 = var_03;
				var_02 = var_05;
			}
		}
	}

	if(!isdefined(var_01))
	{
		func_41C1();
		return;
	}

	func_F837(var_01);
}

//Function Number: 56
func_F837(param_00)
{
	var_01 = func_7F45(param_00);
	self.var_4C02 = param_00;
	func_12EBC();
}

//Function Number: 57
func_41C1()
{
	self.var_4C02 = undefined;
	func_12EBC();
}

//Function Number: 58
func_8110()
{
	var_00 = func_8111();
	if(!isdefined(var_00))
	{
		return undefined;
	}

	return self.pers["killstreaks"][var_00];
}

//Function Number: 59
func_8111()
{
	return self.var_4C02;
}

//Function Number: 60
func_7F45(param_00)
{
	return self.pers["killstreaks"][param_00];
}

//Function Number: 61
func_7E9E(param_00)
{
	var_01 = self.pers["killstreaks"];
	for(var_02 = 1;var_02 <= 3;var_02++)
	{
		var_03 = var_01[var_02];
		if(isdefined(var_03) && var_03.var_110EA == param_00)
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 62
func_7E9F(param_00)
{
	var_01 = self.pers["killstreaks"];
	for(var_02 = 1;var_02 <= 3;var_02++)
	{
		var_03 = var_01[var_02];
		if(isdefined(var_03) && var_03.var_110EA == param_00)
		{
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 63
func_8207(param_00)
{
	var_01 = self.pers["killstreaks"];
	for(var_02 = 0;var_02 <= 3;var_02++)
	{
		var_03 = var_01[var_02];
		if(isdefined(var_03) && var_03.var_110EA == param_00 && var_03.var_269A)
		{
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 64
func_7F54(param_00)
{
	var_01 = self.pers["killstreaks"];
	for(var_02 = 0;var_02 <= 3;var_02++)
	{
		var_03 = var_01[var_02];
		if(isdefined(var_03) && var_03.var_110EA == param_00)
		{
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 65
func_7ED6()
{
	var_00 = [];
	var_01 = self.pers["killstreaks"];
	var_02 = func_7F45(0);
	if(isdefined(var_02))
	{
		var_00[0] = var_02;
		for(var_03 = 4;var_03 < 36;var_03++)
		{
			var_04 = var_01[var_03];
			if(isdefined(var_04))
			{
				var_00[var_00.size] = var_04;
				continue;
			}

			break;
		}
	}

	return var_00;
}

//Function Number: 66
func_7DE7()
{
	var_00 = [];
	var_01 = self.pers["killstreaks"];
	if(var_01.size)
	{
		for(var_02 = 1;var_02 < 4;var_02++)
		{
			var_03 = var_01[var_02];
			if(isdefined(var_03) && isdefined(var_03.var_110EA) && var_03.var_269A)
			{
				var_00[var_00.size] = var_03;
			}
		}
	}

	return var_00;
}

//Function Number: 67
func_DEFB(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(level.var_A6B2))
	{
		level.var_A6B2 = [];
	}

	var_09 = spawnstruct();
	level.var_A6B2[param_00] = var_09;
	var_09.var_13089 = param_01;
	var_09.var_130C4 = param_02;
	var_09.var_26A2 = param_03;
	var_09.var_127BD = param_04;
	var_09.var_13C8D = param_05;
	var_09.var_13CDB = param_06;
	var_09.var_9B12 = param_07;
	var_09.var_13CD6 = param_08;
}

//Function Number: 68
func_7F50(param_00)
{
	var_01 = level.var_A6B2[param_00];
	return var_01;
}

//Function Number: 69
func_7F41(param_00)
{
	if(param_00 == "none")
	{
		return "";
	}

	var_01 = scripts\mp\_utility::func_7F4F(param_00);
	if(!isdefined(var_01) || var_01 == "")
	{
		return "";
	}

	switch(var_01)
	{
		case "script_weapon":
		case "gesture_script_weapon":
			return "offhand_fired";

		case "grenade_weapon":
			return "grenade_fire";

		case "normal_weapon":
			return "weapon_fired";

		case "no_weapon":
		case "no_fire_weapon":
			return "";

		default:
			return "";
	}

	return "";
}

//Function Number: 70
func_7F61()
{
	return self.var_AA35;
}

//Function Number: 71
func_3E4E(param_00)
{
	foreach(var_02 in self.var_A6AB)
	{
		var_03 = func_817B(var_02);
		var_04 = func_7E9F(var_02);
		var_05 = func_7F45(var_04);
		if(self.var_D8B3 < var_03 && param_00 >= var_03)
		{
			if(scripts\mp\_utility::_hasperk("specialty_support_killstreaks") && scripts\mp\_utility::func_9FB3(self.pers["killstreaks"][var_04].var_5FB9))
			{
				continue;
			}

			func_5FBF(var_04,var_03);
		}
	}
}

//Function Number: 72
func_213F(param_00)
{
	var_01 = self.pers["killstreaks"];
	if(!isdefined(var_01))
	{
		return 0;
	}

	foreach(var_03 in param_00)
	{
		var_04 = 0;
		for(var_05 = 1;var_05 <= 3;var_05++)
		{
			var_06 = var_01[var_05];
			if(isdefined(var_06))
			{
				if(isdefined(var_06.var_110EA))
				{
					if(var_06.var_110EA == var_03)
					{
						var_04 = 1;
						break;
					}
				}

				continue;
			}

			if(var_03 == "none")
			{
				var_04 = 1;
				break;
			}
		}

		if(!var_04)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 73
func_6CBA(param_00)
{
	var_01 = self.pers["killstreaks"];
	for(var_02 = 0;var_02 <= 36;var_02++)
	{
		var_03 = var_01[var_02];
		if(!isdefined(var_03))
		{
			if(var_02 >= 4)
			{
				break;
			}

			continue;
		}

		if(param_00 == var_03)
		{
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 74
func_83A7(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = scripts\mp\_rank::func_8104(param_00);
	}

	if(param_01 == 0)
	{
		return;
	}

	var_02 = self.var_110EE + param_01;
	var_03 = var_02;
	var_04 = func_7FA2();
	if(var_03 >= var_04)
	{
		var_03 = var_03 - var_04;
	}

	func_F867(var_03);
	func_3E4E(var_02);
	if(var_02 >= var_04)
	{
		func_F867(var_03);
	}

	func_12F2E(var_03);
	scripts\mp\_analyticslog::func_AFAE(param_01,gettime(),scripts\mp\_rank::func_8102(param_00,"eventID"));
}

//Function Number: 75
func_E275()
{
	self.var_5FBE = 0;
	func_F867(0);
	func_E274();
	func_12F2E(0);
}

//Function Number: 76
func_F867(param_00)
{
	if(param_00 < 0)
	{
		param_00 = 0;
	}

	if(isdefined(self.var_110EE))
	{
		self.var_D8B3 = self.var_110EE;
	}
	else
	{
		self.var_D8B3 = 0;
	}

	self.var_110EE = param_00;
	func_12F2F();
}

//Function Number: 77
func_110C3()
{
	self endon("disconnect");
	level waittill("game_ended");
	scripts\mp\_utility::setpersstat("streakPoints",scripts\common\utility::func_116D7(isdefined(self.var_110EE),self.var_110EE,0));
}

//Function Number: 78
func_6CCB(param_00,param_01,param_02,param_03)
{
	var_04 = rotatevector((0,0,1),(-1 * param_03,0,0));
	var_05 = vectortoangles(param_01 - param_00.origin);
	for(var_06 = 0;var_06 < 360;var_06 = var_06 + 30)
	{
		var_07 = param_02 * rotatevector(var_04,(0,var_06 + var_05[1],0));
		var_08 = param_01 + var_07;
		if(func_1281(param_00,var_08,param_01))
		{
			return var_08;
		}
	}

	return undefined;
}

//Function Number: 79
func_6CCA(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = vectortoangles(param_00.origin - param_01);
	for(var_07 = param_03;var_07 <= param_04;var_07 = var_07 + param_05)
	{
		var_08 = rotatevector((1,0,0),(var_07 - 90,0,0));
		var_09 = param_02 * rotatevector(var_08,(0,var_06[1],0));
		var_0A = param_01 + var_09;
		if(func_1281(param_00,var_0A,param_01))
		{
			return var_0A;
		}
	}

	return undefined;
}

//Function Number: 80
func_1281(param_00,param_01,param_02)
{
	var_03 = bullettrace(param_01,param_02,0);
	if(var_03["fraction"] > 0.99)
	{
		return 1;
	}

	return 0;
}

//Function Number: 81
func_6CC9(param_00,param_01,param_02)
{
	var_03 = func_6CCB(param_00,param_01,param_02,30);
	if(!isdefined(var_03))
	{
		var_03 = func_6CCA(param_00,param_01,param_02,15,75,15);
	}

	return var_03;
}

//Function Number: 82
func_9FC3()
{
	return isdefined(self.var_C53B) && self.var_C53B;
}

//Function Number: 83
func_9FC4()
{
	return isdefined(self.var_98FF) && self.var_98FF;
}

//Function Number: 84
func_532A(param_00,param_01,param_02,param_03)
{
	var_04 = "MOD_EXPLOSIVE";
	var_05 = 5000;
	var_06 = (0,0,0);
	var_07 = (0,0,0);
	var_08 = "";
	var_09 = "";
	var_0A = "";
	var_0B = undefined;
	if(!isdefined(param_03))
	{
		return;
	}

	if(level.teambased)
	{
		foreach(var_0D in param_03)
		{
			if(scripts\mp\_utility::func_9FE7(param_00,param_01,var_0D))
			{
				var_0D notify("damage",var_05,param_00,var_06,var_07,var_04,var_08,var_09,var_0A,var_0B,param_02);
				wait(0.05);
			}
		}

		return;
	}

	foreach(var_0D in var_04)
	{
		if(scripts\mp\_utility::func_9FD8(param_00,param_01,var_0D))
		{
			var_0D notify("damage",var_05,param_00,var_06,var_07,var_04,var_08,var_09,var_0A,var_0B,param_02);
			wait(0.05);
		}
	}
}

//Function Number: 85
func_A6A0(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_01) && isplayer(param_00) && isdefined(param_02.var_222) && isdefined(param_02.var_222.team))
	{
		if(scripts\mp\_utility::playersareenemies(param_00,param_02.var_222))
		{
			if(scripts\mp\_utility::func_9E6C(param_01))
			{
				return;
			}

			if(!isdefined(param_00.var_A99F[param_01]))
			{
				param_00.var_A99F[param_01] = 0;
			}

			if(param_00.var_A99F[param_01] == gettime())
			{
				return;
			}

			param_00.var_A99F[param_01] = gettime();
			param_00 thread scripts\mp\_gamelogic::func_117B7(param_01,1,"hits");
			var_04 = param_00 scripts\mp\_persistence::func_10E34("totalShots");
			var_05 = param_00 scripts\mp\_persistence::func_10E34("hits") + 1;
			if(var_05 <= var_04)
			{
				param_00 scripts\mp\_persistence::func_10E55("hits",var_05);
				param_00 scripts\mp\_persistence::func_10E55("misses",int(var_04 - var_05));
				param_00 scripts\mp\_persistence::func_10E55("accuracy",int(var_05 * 10000 / var_04));
			}

			if((isdefined(param_03) && scripts\common\utility::func_9D74(param_03)) || scripts\mp\_utility::isprojectiledamage(param_03))
			{
				param_00 thread scripts\mp\contractchallenges::contractshotslanded(param_01);
				param_00.var_A96A = gettime();
				var_06 = scripts\mp\_utility::func_8225(param_01);
				if(var_06 == "weapon_lmg")
				{
					if(!isdefined(param_00.shotslandedlmg))
					{
						param_00.shotslandedlmg = 1;
						return;
					}

					param_00.shotslandedlmg++;
					return;
				}

				return;
			}
		}
	}
}

//Function Number: 86
func_83A0()
{
	thread scripts\mp\_utility::func_83B4("destroyed_equipment");
}

//Function Number: 87
func_83A1()
{
	thread scripts\mp\_utility::func_83B4("trophy_defense");
}

//Function Number: 88
func_839F()
{
	thread scripts\mp\_utility::func_83B4("blackhat_hack");
}

//Function Number: 89
func_9E9F(param_00)
{
	return param_00 == "iw6_minigunjugg_mp";
}

//Function Number: 90
func_110F5(param_00)
{
	switch(param_00)
	{
		case "assault":
		case "specialist":
			return 1;

		case "resource":
		case "support":
			return 0;

		default:
			return 1;
	}
}

//Function Number: 91
func_98C2(param_00)
{
	scripts\common\utility::func_1C6E(0);
	var_01 = func_98C3(param_00);
	if(isdefined(self))
	{
		scripts\common\utility::func_1C6E(1);
	}

	return var_01;
}

//Function Number: 92
func_98C3(param_00)
{
	if(isdefined(param_00) && func_9E6F(param_00))
	{
		var_01 = "timeout";
	}
	else
	{
		var_01 = scripts\common\utility::waittill_any_timeout_1(1,"disconnect","death","weapon_switch_started");
	}

	scripts\mp\_hostmigration::func_13834();
	if(var_01 == "weapon_switch_started")
	{
		return "fail";
	}

	if(!isalive(self))
	{
		return "fail";
	}

	if(var_01 == "disconnect" || var_01 == "death")
	{
		if(var_01 == "disconnect")
		{
			return "disconnect";
		}

		if(self.team == "spectator")
		{
			return "fail";
		}

		return "success";
	}

	if(scripts\mp\_utility::func_9E68())
	{
		return "fail";
	}

	if(!isdefined(param_00) || !issubstr(param_00,"odin") || !issubstr(param_00,"pointSelect"))
	{
		if(param_00 == "orbital_deployment" || param_00 == "drone_hive")
		{
			self visionsetfadetoblackforplayer("black_bw",0);
			thread scripts\mp\_utility::func_F607("black_bw",0,1,undefined,1);
			var_02 = scripts\common\utility::waittill_any_timeout_1(0,"disconnect","death");
		}
		else
		{
			self visionsetfadetoblackforplayer("black_bw",0.75);
			thread scripts\mp\_utility::func_F607("black_bw",0.75,1,undefined,1);
			var_02 = scripts\common\utility::waittill_any_timeout_1(0.8,"disconnect","death");
		}
	}
	else
	{
		var_02 = scripts\common\utility::waittill_any_timeout_1(1,"disconnect","death");
	}

	self notify("black_out_done");
	scripts\mp\_hostmigration::func_13834();
	if(var_02 != "disconnect")
	{
		if(!isdefined(param_00) || !issubstr(param_00,"odin") || !issubstr(param_00,"pointSelect"))
		{
			thread func_41D6(1);
		}
		else
		{
			self notify("intro_cleared");
		}

		if(self.team == "spectator")
		{
			return "fail";
		}
	}

	if(self method_81B5())
	{
		return "fail";
	}

	if(!isalive(self))
	{
		return "fail";
	}

	if(scripts\mp\_utility::func_9E68())
	{
		return "fail";
	}

	if(var_02 == "disconnect")
	{
		return "disconnect";
	}

	return "success";
}

//Function Number: 93
func_9E6F(param_00)
{
	switch(param_00)
	{
		case "remote_tank":
		case "remote_uav":
		case "osprey_gunner":
		case "pointSelect":
		case "orbital_deployment":
		case "ac130":
		case "ca_a10_strafe":
		case "vanguard":
		case "odin_assault":
		case "odin_support":
		case "heli_pilot":
		case "fleet_swarm":
		case "remote_c8":
		case "spiderbot":
		case "precision_airstrike":
		case "thor":
		case "minijackal":
		case "drone_hive":
			return 1;
	}

	return 0;
}

//Function Number: 94
func_41D6(param_00,param_01)
{
	self endon("disconnect");
	if(isdefined(param_00))
	{
		wait(param_00);
	}

	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	self visionsetfadetoblackforplayer("",param_01);
	scripts\mp\_utility::func_F607("",param_01);
	self notify("intro_cleared");
}

//Function Number: 95
func_1CA5(param_00)
{
	if(isdefined(param_00))
	{
		self endon(param_00);
	}

	if(!isdefined(self.var_222))
	{
		return;
	}

	var_01 = self.var_222;
	level endon("game_ended");
	var_01 endon("disconnect");
	var_01 endon("end_remote");
	self endon("death");
	for(;;)
	{
		var_02 = 0;
		while(var_01 usebuttonpressed())
		{
			var_02 = var_02 + 0.05;
			if(var_02 > 0.75)
			{
				self notify("killstreakExit");
				return;
			}

			wait(0.05);
		}

		wait(0.05);
	}
}

//Function Number: 96
func_D507(param_00,param_01)
{
	self endon("disconnect");
	level endon("game_ended");
	if(scripts\mp\_utility::func_9FC6())
	{
		return 0;
	}

	if(!scripts\mp\_utility::func_9F19(self))
	{
		return 0;
	}

	self notify("play_remote_sequence");
	var_02 = undefined;
	if(scripts\mp\_utility::func_9FB3(param_01))
	{
		if(self method_81B5() || self ismantling() || !self isonground())
		{
			scripts\mp\_hud_message::func_10122("KILLSTREAKS_UNAVAILABLE");
			return 0;
		}

		var_02 = "ks_remote_device_mp";
		scripts\mp\_supers::func_1CAB();
		scripts\mp\_utility::func_12C6(var_02,0,0,1);
		self setclientomnvar("ui_remote_control_sequence",1);
		var_03 = scripts\mp\_utility::func_11383(var_02);
		if(scripts\mp\_utility::func_9FB3(var_03))
		{
			thread func_13A4C(var_02);
		}
		else
		{
			return 0;
		}
	}

	scripts\mp\_utility::func_FB09(param_00.var_110EA);
	scripts\mp\_utility::func_7385(1);
	thread func_12B9C();
	var_04 = scripts\common\utility::waittill_any_timeout_1(1,"death");
	self notify("ks_freeze_end");
	if(!isdefined(var_04) || var_04 != "timeout")
	{
		self setclientomnvar("ui_remote_control_sequence",0);
		scripts\mp\_utility::func_7385(0);
		scripts\mp\_utility::func_41E9();
		if(isdefined(var_02))
		{
			self notify("finished_with_manual_weapon_" + var_02);
		}

		return 0;
	}

	self setscriptablepartstate("killstreak","visor_active",0);
	thread func_13BA2();
	scripts\mp\_utility::func_7385(0);
	self setclientomnvar("ui_remote_control_sequence",0);
	return 1;
}

//Function Number: 97
func_12B9C()
{
	self endon("disconnect");
	self endon("ks_freeze_end");
	level waittill("round_switch");
	scripts\mp\_utility::func_7385(0);
}

//Function Number: 98
func_13A4C(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("finished_with_manual_weapon_" + param_00);
	if(self hasweapon(param_00))
	{
		scripts\mp\_supers::func_12D6C();
		scripts\mp\_utility::func_80F2(param_00);
		if(self getcurrentweapon() == "none")
		{
			scripts\mp\_utility::_switchtoweapon(self.var_A978);
		}
	}
}

//Function Number: 99
func_13BA2()
{
	self endon("stop_remote_sequence");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("death");
	self setscriptablepartstate("killstreak","neutral",0);
}

//Function Number: 100
func_11086(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	self notify("stop_remote_sequence");
	if(scripts\mp\_utility::func_9F19(self))
	{
		if(scripts\mp\_utility::func_9FB3(level.var_C1BB) && !scripts\mp\_utility::func_9FB3(level.var_C1B2))
		{
			thread scripts\mp\killstreaks\_nuke::func_FB0F(0.05);
		}

		self setclientomnvar("ui_remote_control_sequence",2);
		var_01 = "ks_remote_device_mp";
		if(scripts\mp\_utility::func_9FB3(param_00))
		{
			wait(0.1);
			self notify("finished_with_manual_weapon_" + var_01);
		}
		else
		{
			self notify("killstreak_finished_with_weapon_" + var_01);
		}
	}

	thread scripts\mp\_utility::delaysetclientomnvar(1.3,"ui_remote_control_sequence",0);
	self setscriptablepartstate("killstreak","neutral",0);
	scripts\mp\_utility::func_41E9();
}

//Function Number: 101
combatrecordkillstreakuse(param_00)
{
	if(!scripts\mp\_utility::canrecordcombatrecordstats())
	{
		return;
	}

	var_01 = scripts\mp\_utility::getstreakrecordtype(param_00);
	if(!isdefined(var_01))
	{
		if(param_00 != "nuke")
		{
		}

		return;
	}

	var_02 = self getplayerdata("mp",var_01,param_00,"uses");
	self setplayerdata("mp",var_01,param_00,"uses",var_02 + 1);
}