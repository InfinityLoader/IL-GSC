/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\bots\_bots.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 107
 * Decompile Time: 1911 ms
 * Timestamp: 10/27/2023 3:09:11 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	if(isdefined(level.var_27F6) && level.var_27F6)
	{
		return;
	}

	if(getdvarint("4017") == 1)
	{
		return;
	}

	if(getdvarint("233") == 1)
	{
		return;
	}

	if(function_0367())
	{
		return;
	}

	if(isdefined(level.var_585D) && level.var_585D)
	{
		return;
	}

	func_87A7();
	maps/mp/bots/_bots_personality::func_897D();
	level.var_14F6 = ::badplace_cylinder;
	level.var_14F7 = ::badplace_delete;
	if(isdefined(level.var_1A4F))
	{
		[[ level.var_1A4F ]]();
	}
	else
	{
		maps/mp/bots/_bots_ks::func_1A4E();
	}

	maps/mp/bots/_bots_loadout::func_D5();
	level thread func_00D5();
}

//Function Number: 2
func_87A7()
{
	level.var_19D5 = [];
	level.var_19D5["bots_spawn"] = ::func_8F88;
	level.var_19D5["bots_add_scavenger_bag"] = ::func_192F;
	level.var_19D5["bots_add_to_level_targets"] = ::maps/mp/bots/_bots_util::func_1931;
	level.var_19D5["bots_remove_from_level_targets"] = ::maps/mp/bots/_bots_util::func_1AB4;
	level.var_19D5["bots_make_entity_sentient"] = ::func_1A70;
	level.var_19D5["bots_free_entity_sentient"] = ::bot_free_entity_sentient;
	level.var_19D5["think"] = ::func_1AFD;
	level.var_19D5["on_killed"] = ::func_6A7A;
	level.var_19D5["should_do_killcam"] = ::func_1AE2;
	level.var_19D5["get_attacker_ent"] = ::maps/mp/bots/_bots_util::func_19F7;
	level.var_19D5["should_pickup_weapons"] = ::func_1AE3;
	level.var_19D5["on_damaged"] = ::func_1996;
	level.var_19D5["gametype_think"] = ::func_2B9C;
	level.var_19D5["leader_dialog"] = ::maps/mp/bots/_bots_util::func_1A59;
	level.var_19D5["player_spawned"] = ::func_1A9C;
	level.var_19D5["should_start_cautious_approach"] = ::maps/mp/bots/_bots_strategy::func_8B7A;
	level.var_19D5["know_enemies_on_start"] = ::func_1A52;
	level.var_19D5["bot_get_rank_xp_and_prestige"] = ::func_19FE;
	level.var_19D5["bot_set_rank_options"] = ::func_1AD6;
	level.var_19D5["ai_3d_sighting_model"] = ::func_192A;
	level.var_19D5["dropped_weapon_think"] = ::func_1B03;
	level.var_19D5["dropped_weapon_cancel"] = ::func_8B80;
	level.var_19D5["crate_can_use"] = ::func_2735;
	level.var_19D5["post_teleport"] = ::func_1A9E;
	level.var_19D5["bot_set_difficulty"] = ::maps/mp/bots/_bots_util::func_1AD3;
	level.var_19D5["bot_set_personality"] = ::maps/mp/bots/_bots_util::func_1AD5;
	level.var_19D5["bot_think_watch_enemy"] = ::func_1B06;
	level.var_19D5["bot_think_tactical_goals"] = ::maps/mp/bots/_bots_strategy::func_1B04;
	level.var_19D5["bot_bots_enabled_or_added"] = ::maps/mp/bots/_bots_util::func_194B;
	level.var_1AB0 = [];
	level.var_1AB0["allies"] = ::maps/mp/bots/_bots_personality::func_1AAF;
	level.var_1AB0["axis"] = ::maps/mp/bots/_bots_personality::func_1AAF;
	level.var_1AB0["hostile"] = ::maps/mp/bots/_bots_personality::func_1AAF;
	level.var_1AB0["neutral"] = ::maps/mp/bots/_bots_personality::func_1AAF;
	level.var_19CA["capture"] = ::maps/mp/bots/_bots_strategy::func_3B6F;
	level.var_19CA["capture_zone"] = ::maps/mp/bots/_bots_strategy::func_3B70;
	level.var_19CA["protect"] = ::maps/mp/bots/_bots_strategy::func_3B72;
	level.var_19CA["protect_zone"] = ::maps/mp/bots/_bots_strategy::func_3B73;
	level.var_19CA["bodyguard"] = ::maps/mp/bots/_bots_strategy::func_3B6E;
	level.var_19CA["patrol"] = ::maps/mp/bots/_bots_strategy::func_3B71;
	func_87BF();
	maps/mp/bots/_bots_gametype_war::func_87A7();
}

//Function Number: 3
func_87BF()
{
	level.var_19D5["crate_low_ammo_check"] = ::func_273D;
	level.var_19D5["crate_should_claim"] = ::func_2741;
	level.var_19D5["crate_wait_use"] = ::func_2743;
	level.var_19D5["crate_in_range"] = ::func_2739;
	level.var_1962["deployable_vest"] = ::func_1AE6;
	level.var_1962["deployable_ammo"] = ::func_1AE5;
	level.var_1962["scavenger_bag"] = ::func_1AE9;
	level.var_1962["deployable_grenades"] = ::func_1AE7;
	level.var_1962["deployable_juicebox"] = ::func_1AE8;
	level.var_1AA2["deployable_ammo"] = ::func_1AA1;
	level.var_1AA0["deployable_ammo"] = ::func_1A9F;
}

//Function Number: 4
archived(param_00,param_01)
{
	if(isdefined(level.var_19D5) && isdefined(level.var_19D5["leader_dialog"]))
	{
		self [[ level.var_19D5["leader_dialog"] ]](param_00,param_01);
	}
}

//Function Number: 5
func_00D5()
{
	thread func_6348();
	thread func_1B07();
	func_5299();
	if(!func_8BA9())
	{
		return;
	}

	func_7B8D();
	var_00 = botautoconnectenabled();
	if(var_00 == "enabled_fill_open" || var_00 == "enabled_fill_open_dev" || level.var_53C7)
	{
		setmatchdata("match_common","has_bots",1);
		level thread func_197E();
		return;
	}

	level thread func_1A81();
}

//Function Number: 6
func_5299()
{
	if(!isdefined(level.var_2751))
	{
		level.var_2751 = 500;
	}

	if(!isdefined(level.var_274E))
	{
		level.var_274E = 3000;
	}

	level.var_1A8C = 3000;
	level.var_1AB6["recruit"] = "iw5_maaws";
	level.var_1AB6["regular"] = "iw5_maaws";
	level.var_1AB6["hardened"] = "iw5_maaws";
	level.var_1AB6["veteran"] = "iw5_maaws";
	level.var_19C3 = "m1garand_mp";
	level.var_AC9C = getzonecount();
	func_529A();
}

//Function Number: 7
func_529A()
{
	if(isdefined(level.var_98C4))
	{
		var_00 = [[ level.var_98C4 ]]();
	}
	else
	{
		var_00 = getallnodes();
	}

	level.var_1A75 = 0;
	level.var_1A72 = 0;
	level.var_1A76 = 0;
	level.var_1A73 = 0;
	level.var_1A77 = 0;
	level.var_1A74 = 0;
	if(var_00.size > 1)
	{
		level.var_1A75 = var_00[0].var_116[0];
		level.var_1A72 = var_00[0].var_116[0];
		level.var_1A76 = var_00[0].var_116[1];
		level.var_1A73 = var_00[0].var_116[1];
		level.var_1A77 = var_00[0].var_116[2];
		level.var_1A74 = var_00[0].var_116[2];
		for(var_01 = 1;var_01 < var_00.size;var_01++)
		{
			var_02 = var_00[var_01].var_116;
			if(var_02[0] < level.var_1A75)
			{
				level.var_1A75 = var_02[0];
			}

			if(var_02[0] > level.var_1A72)
			{
				level.var_1A72 = var_02[0];
			}

			if(var_02[1] < level.var_1A76)
			{
				level.var_1A76 = var_02[1];
			}

			if(var_02[1] > level.var_1A73)
			{
				level.var_1A73 = var_02[1];
			}

			if(var_02[2] < level.var_1A77)
			{
				level.var_1A77 = var_02[2];
			}

			if(var_02[2] > level.var_1A74)
			{
				level.var_1A74 = var_02[2];
			}
		}
	}

	level.var_1A71 = (level.var_1A75 + level.var_1A72 / 2,level.var_1A76 + level.var_1A73 / 2,level.var_1A77 + level.var_1A74 / 2);
	level.var_1B1B = 1;
}

//Function Number: 8
func_1A9E()
{
	level.var_1B1B = undefined;
	level.var_1A22 = undefined;
	func_529A();
	maps/mp/bots/_bots_ks_remote_vehicle::func_7C63();
}

//Function Number: 9
func_8BA9()
{
	return 1;
}

//Function Number: 10
func_7B8D()
{
	wait(1);
	foreach(var_01 in level.var_744A)
	{
		if(isbot(var_01))
		{
			var_01.var_37F4 = 1;
			var_01.var_1AFA = var_01.var_1A7;
			var_01.var_1AEE = 1;
			var_01 thread [[ level.var_19D5["think"] ]]();
		}
	}
}

//Function Number: 11
func_1A9C()
{
	func_1AD4();
}

//Function Number: 12
func_1AD4()
{
	if(!isdefined(self.var_1976))
	{
		if(!func_19DC())
		{
			while(!isdefined(level.var_1A6E))
			{
				wait 0.05;
			}

			if(isdefined(self.var_6CB8))
			{
				self.var_1976 = [[ self.var_6CB8 ]]();
				return;
			}

			self.var_1976 = maps/mp/bots/_bots_personality::func_1ADD();
			return;
		}

		self.var_1976 = self.var_2319;
	}
}

//Function Number: 13
func_A8DE()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(!isai(var_00) && level.var_744A.size > 0)
		{
			level.var_744C = common_scripts\utility::func_F6F(level.var_744C,var_00);
			childthread func_1B41(var_00);
			childthread func_1B40(var_00);
			childthread func_1B42(var_00);
		}
	}
}

//Function Number: 14
func_1B41(param_00)
{
	param_00 endon("bots_human_disconnected");
	while(!common_scripts\utility::func_F79(level.var_744A,param_00))
	{
		wait 0.05;
	}

	param_00 notify("bots_human_spawned");
}

//Function Number: 15
func_1B40(param_00)
{
	param_00 endon("bots_human_spawned");
	param_00 waittill("disconnect");
	param_00 notify("bots_human_disconnected");
}

//Function Number: 16
func_1B42(param_00)
{
	param_00 common_scripts\utility::knock_off_battery("bots_human_spawned","bots_human_disconnected");
	level.var_744C = common_scripts\utility::func_F93(level.var_744C,param_00);
}

//Function Number: 17
func_632D()
{
	level.var_744C = [];
	childthread func_A8DE();
	for(;;)
	{
		if(level.var_744C.size > 0)
		{
			level.var_6F29 = 1;
		}
		else
		{
			level.var_6F29 = 0;
		}

		wait(0.5);
	}
}

//Function Number: 18
func_1958(param_00)
{
	if(maps\mp\_utility::func_602B())
	{
		return 1;
	}

	if(!level.var_984D)
	{
		return 1;
	}

	if(maps\mp\gametypes\_teams::func_452D(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 19
func_1935()
{
	if(isdefined(level.var_1B3B) && level.var_1B3B)
	{
		return 0;
	}

	if(isdefined(level.var_6034) && level.var_6034)
	{
		return 0;
	}

	return 1;
}

//Function Number: 20
func_197E()
{
	level endon("game_ended");
	self notify("bot_connect_monitor");
	self endon("bot_connect_monitor");
	level.var_6F29 = 0;
	childthread func_632D();
	maps\mp\gametypes\_hostmigration::func_A6F5(0.5);
	var_00 = 1.5;
	if(!isdefined(level.var_197A))
	{
		level.var_197A = 0;
	}

	if(!isdefined(level.var_197B))
	{
		level.var_197B = 0;
	}

	if(!isdefined(level.var_1979))
	{
		level.var_1979 = 0;
	}

	for(;;)
	{
		if(level.var_6F29)
		{
			maps\mp\gametypes\_hostmigration::func_A6F5(var_00);
			continue;
		}

		var_01 = isdefined(level.var_1B3F) || !level.var_984D;
		var_02 = botgetteamlimit(0);
		var_03 = botgetteamlimit(1);
		if(level.var_53C7)
		{
			var_02 = level.var_80BF;
			var_03 = level.var_80C0;
		}

		var_04 = botgetteamdifficulty(0);
		var_05 = botgetteamdifficulty(1);
		var_09 = "allies";
		if(isdefined(level.var_1A57))
		{
			var_09 = level.var_1A57;
		}

		var_0A = "axis";
		if(isdefined(level.var_1A58))
		{
			var_0A = level.var_1A58;
		}

		var_0B = func_1978();
		var_0C = func_2032(var_0B,"humans");
		if(var_0C > 1)
		{
			var_0D = func_19F5();
			if(!maps\mp\_utility::func_602B() && isdefined(var_0D) && var_0D != "spectator")
			{
				var_09 = var_0D;
				var_0A = maps\mp\_utility::func_45DE(var_0D);
			}
			else
			{
				var_0E = func_2032(var_0B,"humans_allies");
				var_0F = func_2032(var_0B,"humans_axis");
				if(var_0F > var_0E)
				{
					var_09 = "axis";
					var_0A = "allies";
				}
			}
		}
		else
		{
			var_10 = func_41D2();
			if(isdefined(var_10))
			{
				var_11 = var_10 func_19FD();
				if(isdefined(var_11) && var_11 != "spectator")
				{
					var_09 = var_11;
					var_0A = maps\mp\_utility::func_45DE(var_11);
				}
			}
		}

		level.var_1A57 = var_09;
		level.var_1A58 = var_0A;
		var_12 = maps/mp/bots/_bots_util::func_1A02();
		var_13 = maps/mp/bots/_bots_util::func_1A02();
		var_14 = maps/mp/bots/_bots_util::func_19EE();
		if(var_12 + var_13 < var_14)
		{
			if(var_12 < var_02)
			{
				var_12++;
			}
			else if(var_13 < var_03)
			{
				var_13++;
			}
		}

		var_15 = func_2032(var_0B,"humans_" + var_09);
		var_16 = func_2032(var_0B,"humans_" + var_0A);
		var_17 = var_15 + var_16;
		var_18 = func_2032(var_0B,"spectator");
		var_19 = 0;
		var_1A = 0;
		while(var_18 > 0)
		{
			var_1B = var_15 + var_19 + 1 <= var_12;
			var_1C = var_16 + var_1A + 1 <= var_13;
			if(var_1B && !var_1C)
			{
				var_19++;
				continue;
			}

			if(!var_1B && var_1C)
			{
				var_1A++;
				continue;
			}

			if(var_1B && var_1C)
			{
				if(var_18 % 2 == 1)
				{
					var_19++;
					continue;
				}

				var_1A++;
			}

			var_18--;
		}

		var_1D = func_2032(var_0B,"bots_" + var_09);
		var_1E = func_2032(var_0B,"bots_" + var_0A);
		var_1F = var_1D + var_1E;
		if(var_1F > 0)
		{
			level.var_197A = 1;
		}

		var_20 = 0;
		if(!level.var_1979)
		{
			var_20 = !func_19F6();
			if(!var_20)
			{
				level.var_1979 = 1;
			}
		}

		if(var_20)
		{
			var_21 = !function_02A3();
			var_22 = var_03 != var_02;
			var_23 = !func_19F6() && !var_01 && var_22 && !level.var_197A && level.var_197B < 10 || !maps\mp\_utility::func_3FA0("prematch_done");
			var_24 = 0;
			if(var_21 || var_23 || var_24)
			{
				level.var_197B = level.var_197B + var_00;
				maps\mp\gametypes\_hostmigration::func_A6F5(var_00);
				continue;
			}
		}

		var_25 = int(min(var_12 - var_15 - var_19,var_02));
		var_26 = int(min(var_13 - var_16 - var_1A,var_03));
		var_27 = 1;
		var_28 = var_25 + var_26 + var_0C;
		var_29 = var_02 + var_03 + var_0C;
		var_2A = [-1,-1];
		while(var_28 < var_14 && var_28 < var_29)
		{
			if(var_27 && var_25 < var_02 && func_1958(var_09))
			{
				var_25++;
			}
			else if(!var_27 && var_26 < var_03 && func_1958(var_0A))
			{
				var_26++;
			}

			var_28 = var_25 + var_26 + var_0C;
			if(var_2A[var_27] == var_28)
			{
				break;
			}

			var_2A[var_27] = var_28;
			var_27 = !var_27;
		}

		level.var_1A79[var_09] = int(var_25 + var_15 + var_19);
		level.var_1A79[var_0A] = int(var_26 + var_16 + var_1A);
		func_A0AF();
		if(var_02 == var_03 && !var_01 && var_19 == 1 && var_1A == 0 && var_26 > 0)
		{
			if(!isdefined(level.var_1AA3) && maps\mp\_utility::func_3FA0("prematch_done"))
			{
				level.var_1AA3 = gettime();
			}

			if(var_20 && !isdefined(level.var_1AA3) || gettime() - level.var_1AA3 < 10000)
			{
				var_26--;
			}
		}

		var_2C = var_25 - var_1D;
		var_2D = var_26 - var_1E;
		var_2E = 1;
		if(var_01)
		{
			var_2F = var_12 + var_13;
			var_30 = var_02 + var_03;
			var_31 = var_15 + var_16;
			var_32 = var_1D + var_1E;
			var_33 = int(min(var_2F - var_31,var_30));
			var_34 = var_33 - var_32;
			if(var_34 == 0)
			{
				var_2E = 0;
			}
			else if(var_34 > 0)
			{
				var_2C = int(var_34 / 2) + var_34 % 2;
				var_2D = int(var_34 / 2);
			}
			else if(var_34 < 0)
			{
				var_35 = var_34 * -1;
				var_2C = -1 * int(min(var_35,var_1D));
				var_2D = -1 * var_35 + var_2C;
			}
		}
		else if(!maps\mp\_utility::func_602B() && var_2C * var_2D < 0 && maps\mp\_utility::func_3FA0("prematch_done") && func_1935())
		{
			var_36 = int(min(abs(var_2C),abs(var_2D)));
			if(var_2C > 0)
			{
				func_6475(var_36,var_0A,var_09,var_04);
			}
			else if(var_2D > 0)
			{
				func_6475(var_36,var_09,var_0A,var_05);
			}

			var_2E = 0;
		}

		if(var_2E)
		{
			if(var_2D < 0)
			{
				func_3447(var_2D * -1,var_0A);
			}

			if(var_2C < 0)
			{
				func_3447(var_2C * -1,var_09);
			}

			if(var_2D > 0)
			{
				level thread func_8F88(var_2D,var_0A,undefined,undefined,"spawned_enemies",var_05);
			}

			if(var_2C > 0)
			{
				level thread func_8F88(var_2C,var_09,undefined,undefined,"spawned_allies",var_04);
			}

			if(var_2D > 0 && var_2C > 0)
			{
				level common_scripts\utility::func_A746("spawned_enemies","spawned_allies");
			}
			else if(var_2D > 0)
			{
				level waittill("spawned_enemies");
			}
			else if(var_2C > 0)
			{
				level waittill("spawned_allies");
			}
		}

		if(var_05 != var_04)
		{
			func_1B43(var_0A,var_05);
			func_1B43(var_09,var_04);
		}

		maps\mp\gametypes\_hostmigration::func_A6F5(var_00);
	}
}

//Function Number: 21
func_1A81()
{
	level endon("game_ended");
	self notify("bot_monitor_team_limits");
	self endon("bot_monitor_team_limits");
	maps\mp\gametypes\_hostmigration::func_A6F5(0.5);
	var_00 = 1.5;
	for(;;)
	{
		level.var_1A79["allies"] = 0;
		level.var_1A79["axis"] = 0;
		foreach(var_02 in level.var_744A)
		{
			if(isdefined(var_02.var_1A7) && var_02.var_1A7 == "allies" || var_02.var_1A7 == "axis")
			{
				level.var_1A79[var_02.var_1A7]++;
			}
		}

		func_A0AF();
		maps\mp\gametypes\_hostmigration::func_A6F5(var_00);
	}
}

//Function Number: 22
func_A0AF()
{
	if(isdefined(level.var_A4E))
	{
		foreach(var_01 in level.var_A4E)
		{
			if(isdefined(var_01.var_565F) && var_01.var_565F)
			{
				if(maps\mp\_utility::func_5800(var_01) && isdefined(var_01.var_1A7) && var_01.var_1A7 == "allies" || var_01.var_1A7 == "axis")
				{
					level.var_1A79[var_01.var_1A7]++;
				}
			}
		}
	}
}

//Function Number: 23
func_19FD()
{
	if(isdefined(self.var_1A7))
	{
		return self.var_1A7;
	}

	if(isdefined(self.var_12C["team"]))
	{
		return self.var_12C["team"];
	}

	return undefined;
}

//Function Number: 24
func_19F5()
{
	foreach(var_01 in level.var_744A)
	{
		if(!isai(var_01) && var_01 ishost())
		{
			return var_01 func_19FD();
		}
	}

	return "spectator";
}

//Function Number: 25
func_19F6()
{
	var_00 = 0;
	var_01 = 0;
	var_02 = 0;
	foreach(var_04 in level.var_744A)
	{
		if(!isai(var_04))
		{
			if(var_04 ishost())
			{
				var_00 = 1;
			}

			if(func_72FA(var_04))
			{
				var_01 = 1;
				if(var_04 ishost())
				{
					var_02 = 1;
				}
			}
		}
	}

	return var_02 || var_01 && !var_00;
}

//Function Number: 26
func_72FA(param_00)
{
	if(isdefined(param_00.var_1A7) && param_00.var_1A7 != "spectator")
	{
		return 1;
	}

	if(isdefined(param_00.var_90E3) && param_00.var_90E3)
	{
		return 1;
	}

	if(param_00 method_8436())
	{
		return 1;
	}

	return 0;
}

//Function Number: 27
bot_get_human_picked_class()
{
	var_00 = 0;
	var_01 = 0;
	var_02 = 0;
	foreach(var_04 in level.var_744A)
	{
		if(!isai(var_04))
		{
			if(var_04 ishost())
			{
				var_00 = 1;
			}

			if(isdefined(var_04.var_2319))
			{
				var_01 = 1;
				if(var_04 ishost())
				{
					var_02 = 1;
				}
			}
		}
	}

	return var_02 || var_01 && !var_00;
}

//Function Number: 28
func_1978()
{
	var_00 = [];
	for(var_01 = 0;var_01 < level.var_744A.size;var_01++)
	{
		var_02 = level.var_744A[var_01];
		if(isdefined(var_02) && isdefined(var_02.var_1A7))
		{
			var_00 = func_2031(var_00,"all");
			var_00 = func_2031(var_00,var_02.var_1A7);
			if(isbot(var_02))
			{
				var_00 = func_2031(var_00,"bots");
				var_00 = func_2031(var_00,"bots_" + var_02.var_1A7);
				continue;
			}

			var_00 = func_2031(var_00,"humans");
			var_00 = func_2031(var_00,"humans_" + var_02.var_1A7);
		}
	}

	return var_00;
}

//Function Number: 29
func_2031(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		param_00 = [];
	}

	if(!isdefined(param_00[param_01]))
	{
		param_00[param_01] = 0;
	}

	param_00[param_01] = param_00[param_01] + 1;
	return param_00;
}

//Function Number: 30
func_2032(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!isdefined(param_00[param_01]))
	{
		return 0;
	}

	return param_00[param_01];
}

//Function Number: 31
func_6475(param_00,param_01,param_02,param_03)
{
	foreach(var_05 in level.var_744A)
	{
		if(!isdefined(var_05.var_1A7))
		{
			continue;
		}

		if(isdefined(var_05.var_2582) && var_05.var_2582 && isbot(var_05) && var_05.var_1A7 == param_01)
		{
			var_05.var_1AFA = param_02;
			if(isdefined(param_03))
			{
				var_05 maps/mp/bots/_bots_util::func_1AD3(param_03);
			}

			var_05 notify("luinotifyserver","team_select",func_1A6F(param_02));
			wait 0.05;
			var_05 notify("luinotifyserver","class_select",var_05.var_1976);
			param_00--;
			if(param_00 <= 0)
			{
				break;
			}
			else
			{
				wait(0.1);
			}
		}
	}
}

//Function Number: 32
func_1B43(param_00,param_01)
{
	foreach(var_03 in level.var_744A)
	{
		if(!isdefined(var_03.var_1A7))
		{
			continue;
		}

		if(isdefined(var_03.var_2582) && var_03.var_2582 && isbot(var_03) && var_03.var_1A7 == param_00)
		{
			if(param_01 != var_03 botgetdifficulty())
			{
				var_03 maps/mp/bots/_bots_util::func_1AD3(param_01);
			}
		}
	}
}

//Function Number: 33
func_19BB()
{
	kick(self.var_37CD,"EXE_PLAYERKICKED_BOT_BALANCE");
	wait(0.1);
}

//Function Number: 34
func_3447(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in level.var_744A)
	{
		if(isdefined(var_04.var_2582) && var_04.var_2582 && isbot(var_04) && !isdefined(param_01) || isdefined(var_04.var_1A7) && var_04.var_1A7 == param_01)
		{
			var_02[var_02.size] = var_04;
		}
	}

	for(var_06 = var_02.size - 1;var_06 >= 0;var_06--)
	{
		if(param_00 <= 0)
		{
			break;
		}

		if(!maps\mp\_utility::func_57A0(var_02[var_06]))
		{
			var_02[var_06] func_19BB();
			var_02 = common_scripts\utility::func_F93(var_02,var_02[var_06]);
			param_00--;
		}
	}

	for(var_06 = var_02.size - 1;var_06 >= 0;var_06--)
	{
		if(param_00 <= 0)
		{
			break;
		}

		var_02[var_06] func_19BB();
		param_00--;
	}
}

//Function Number: 35
func_1A6F(param_00)
{
	if(param_00 == "axis")
	{
		return 0;
	}

	if(param_00 == "allies")
	{
		return 1;
	}

	if(param_00 == "autoassign" || param_00 == "random")
	{
		return 2;
	}

	return 3;
}

//Function Number: 36
func_8F87(param_00,param_01,param_02)
{
	var_03 = gettime() + -5536;
	while(!self canspawntestclient())
	{
		if(gettime() >= var_03)
		{
			kick(self.var_37CD,"EXE_PLAYERKICKED_BOT_BALANCE");
			param_02.var_843 = 1;
			return;
		}

		wait 0.05;
		if(!isdefined(self))
		{
			param_02.var_843 = 1;
			return;
		}
	}

	maps\mp\gametypes\_hostmigration::func_A6F5(randomfloatrange(0.25,2));
	if(!isdefined(self))
	{
		param_02.var_843 = 1;
		return;
	}

	self spawntestclient();
	self.var_37F4 = 1;
	self.var_1AFA = param_00;
	if(isdefined(param_02.var_2F05))
	{
		maps/mp/bots/_bots_util::func_1AD3(param_02.var_2F05);
	}

	if(isdefined(param_01))
	{
		self [[ param_01 ]]();
	}

	self thread [[ level.var_19D5["think"] ]]();
	param_02.var_7ABD = 1;
}

//Function Number: 37
func_8F88(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = gettime() + 10000;
	var_07 = [];
	var_08 = var_07.size;
	while(level.var_744A.size < maps/mp/bots/_bots_util::func_19EE() && var_07.size < param_00 && gettime() < var_06)
	{
		maps\mp\gametypes\_hostmigration::func_A6F5(0.05);
		var_09 = addbot("",param_01);
		if(!isdefined(var_09))
		{
			if(isdefined(param_03) && param_03)
			{
				if(isdefined(param_04))
				{
					self notify(param_04);
				}

				return;
			}

			maps\mp\gametypes\_hostmigration::func_A6F5(1);
			continue;
		}
		else
		{
			var_0A = spawnstruct();
			var_0A.var_1929 = var_09;
			var_0A.var_7ABD = 0;
			var_0A.var_843 = 0;
			var_0A.var_D4 = var_08;
			var_0A.var_2F05 = param_05;
			var_07[var_07.size] = var_0A;
			var_0A.var_1929 thread func_8F87(param_01,param_02,var_0A);
			var_08++;
		}
	}

	var_0B = 0;
	var_06 = gettime() + -5536;
	while(var_0B < var_07.size && gettime() < var_06)
	{
		var_0B = 0;
		foreach(var_0A in var_07)
		{
			if(var_0A.var_7ABD || var_0A.var_843)
			{
				var_0B++;
			}
		}

		wait 0.05;
	}

	if(isdefined(param_04))
	{
		self notify(param_04);
	}
}

//Function Number: 38
func_19DD()
{
	if(maps\mp\_utility::func_602B() && self.var_179 != "none")
	{
		var_00 = 0;
	}
	else if(!maps\mp\_utility::func_602B() && maps\mp\_utility::func_C2D())
	{
		var_00 = 1;
	}
	else
	{
		var_00 = 0;
	}

	return !var_00;
}

//Function Number: 39
func_19DC()
{
	return isdefined(level.var_1B3D) && level.var_1B3D;
}

//Function Number: 40
func_1AFD()
{
	self notify("bot_think");
	self endon("bot_think");
	self endon("disconnect");
	while(!isdefined(self.var_12C["team"]))
	{
		wait 0.05;
	}

	level.var_4B58 = 1;
	if(func_19DD())
	{
		self.var_1AFA = self.var_12C["team"];
	}

	var_00 = self.var_1AFA;
	if(!isdefined(var_00))
	{
		var_00 = self.var_12C["team"];
	}

	self.var_37CD = self getentitynumber();
	var_01 = 0;
	if(!isdefined(self.var_1AEE))
	{
		var_01 = 1;
		self.var_1AEE = 1;
		if(!func_19DD())
		{
			var_02 = self.var_12C["team"] != "spectator" && !isdefined(self.var_1AFA);
			if(!var_02)
			{
				self notify("luinotifyserver","team_select",func_1A6F(var_00));
				wait(0.5);
				if(self.var_12C["team"] == "spectator")
				{
					func_19BB();
					return;
				}
			}
		}
	}

	for(;;)
	{
		maps/mp/bots/_bots_util::func_1AD3(self botgetdifficulty());
		self.var_2F05 = self botgetdifficulty();
		var_03 = self botgetdifficultysetting("advancedPersonality");
		if(var_01 && isdefined(var_03) && var_03 != 0)
		{
			maps/mp/bots/_bots_personality::func_193F();
		}

		maps/mp/bots/_bots_personality::func_1939();
		if(var_01)
		{
			if(isdefined(level.var_19D5) && isdefined(level.var_19D5["class_select_override"]))
			{
				self [[ level.var_19D5["class_select_override"] ]]();
			}
			else
			{
				func_1AD4();
				if(!func_19DC())
				{
					if(isdefined(self.var_2589) && self.var_2589 == gettime())
					{
						waittillframeend;
						waittillframeend;
					}

					if(maps\mp\_utility::isprophuntgametype() && var_00 == game["attackers"] && game["roundsPlayed"] > 0)
					{
						wait(0.5);
					}

					self notify("luinotifyserver","class_select",self.var_1976);
				}
			}

			if(self.var_BC == 0)
			{
				self waittill("spawned_player");
			}

			if(isdefined(level.var_19D5) && isdefined(level.var_19D5["know_enemies_on_start"]))
			{
				self thread [[ level.var_19D5["know_enemies_on_start"] ]]();
			}

			var_01 = 0;
		}

		maps/mp/bots/_bots_loadout::func_1A7E();
		func_1A7F();
		func_1AB7();
		wait(0.1);
		self waittill("death");
		if(isdefined(level.var_19D5) && isdefined(level.var_19D5["post_death_func"]))
		{
			self [[ level.var_19D5["post_death_func"] ]]();
		}

		func_7DB1();
		self waittill("spawned_player");
	}
}

//Function Number: 41
func_1AD6()
{
}

//Function Number: 42
func_1A7F()
{
	if(maps\mp\gametypes\_tweakables::func_46F7("game","onlyheadshots"))
	{
		self botsetflag("only_headshots",1);
	}
}

//Function Number: 43
func_7DB1()
{
	self endon("started_spawnPlayer");
	while(!self.var_A6F0)
	{
		wait 0.05;
	}

	if(maps\mp\gametypes\_playerlogic::func_664E())
	{
		while(self.var_A6F0)
		{
			if(self.var_178 == "spectator")
			{
				if(getdvarint("numlives") == 0 || self.var_12C["lives"] > 0)
				{
					self botpressbutton("use",0.5);
				}
			}

			wait(1);
		}
	}
}

//Function Number: 44
func_1A39()
{
	return self method_837F();
}

//Function Number: 45
func_19FE()
{
	var_00 = spawnstruct();
	if(!func_1A39())
	{
		if(!isdefined(self.var_12C["rankxp"]))
		{
			self.var_12C["rankxp"] = 0;
		}

		if(!isdefined(self.var_12C["prestige"]))
		{
			self.var_12C["prestige"] = 0;
		}

		var_00.var_7A6D = self.var_12C["rankxp"];
		var_00.var_76B0 = self.var_12C["prestige"];
		return var_00;
	}

	var_01 = self botgetdifficulty();
	var_02 = "bot_rank_" + var_01;
	var_03 = "bot_prestige_" + var_01;
	var_04 = self.var_12C[var_02];
	var_05 = self.var_12C[var_03];
	var_06 = undefined;
	if(isdefined(var_04))
	{
		var_00.var_7A6D = var_04;
	}
	else
	{
		if(!isdefined(var_06))
		{
			var_06 = func_1AB1(var_01);
		}

		var_07 = var_06["rank"];
		var_08 = maps\mp\gametypes\_rank::func_4658(var_07);
		var_09 = maps\mp\gametypes\_rank::func_4657(var_07);
		var_0A = randomintrange(var_08,var_09);
		self.var_12C[var_02] = var_0A;
		var_00.var_7A6D = var_0A;
	}

	if(isdefined(var_05))
	{
		var_00.var_76B0 = var_05;
	}
	else
	{
		if(!isdefined(var_06))
		{
			var_06 = func_1AB1(var_01);
		}

		var_0B = var_06["prestige"];
		self.var_12C[var_03] = var_0B;
		var_00.var_76B0 = var_0B;
	}

	return var_00;
}

//Function Number: 46
func_192A(param_00)
{
	thread func_192B(param_00);
}

//Function Number: 47
func_192B(param_00)
{
	param_00 endon("disconnect");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		if(isalive(self) && !self method_8371(param_00) && common_scripts\utility::func_AA4A(self.var_116,self getangles(),param_00.var_116,self method_8375()))
		{
			self method_8379(param_00,param_00.var_116);
		}

		wait(0.1);
	}
}

//Function Number: 48
func_1AB1(param_00)
{
	var_01 = [];
	var_01["rank"] = 0;
	var_01["prestige"] = 0;
	if(param_00 == "default")
	{
		return var_01;
	}

	if(!isdefined(level.var_1ABA))
	{
		level.var_1ABA = [];
		level.var_1ABA["recruit"][0] = 0;
		level.var_1ABA["recruit"][1] = 1;
		level.var_1ABA["regular"][0] = 20;
		level.var_1ABA["regular"][1] = 28;
		level.var_1ABA["hardened"][0] = 40;
		level.var_1ABA["hardened"][1] = 48;
		level.var_1ABA["veteran"][0] = 50;
		level.var_1ABA["veteran"][1] = 54;
	}

	if(!isdefined(level.var_1AB9))
	{
		level.var_1AB9 = [];
		level.var_1AB9["recruit"][0] = 0;
		level.var_1AB9["recruit"][1] = 0;
		level.var_1AB9["regular"][0] = 0;
		level.var_1AB9["regular"][1] = 0;
		level.var_1AB9["hardened"][0] = 0;
		level.var_1AB9["hardened"][1] = 0;
		level.var_1AB9["veteran"][0] = 0;
		level.var_1AB9["veteran"][1] = 9;
	}

	var_01["rank"] = randomintrange(level.var_1ABA[param_00][0],level.var_1ABA[param_00][1] + 1);
	var_01["prestige"] = randomintrange(level.var_1AB9[param_00][0],level.var_1AB9[param_00][1] + 1);
	return var_01;
}

//Function Number: 49
func_2735(param_00)
{
	if(function_01EF(self) && !isdefined(param_00.var_1B7B))
	{
		return 0;
	}

	return 1;
}

//Function Number: 50
func_41D2()
{
	var_00 = undefined;
	var_01 = getentarray("player","classname");
	if(isdefined(var_01))
	{
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			if(isdefined(var_01[var_02]) && isdefined(var_01[var_02].var_2582) && var_01[var_02].var_2582 && !isai(var_01[var_02]) && !isdefined(var_00) || var_00.var_1A7 == "spectator")
			{
				var_00 = var_01[var_02];
			}
		}
	}

	return var_00;
}

//Function Number: 51
func_1996(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(self) || !isalive(self))
	{
		return;
	}

	if(param_02 == "MOD_FALLING" || param_02 == "MOD_SUICIDE")
	{
		return;
	}

	if(param_01 <= 0)
	{
		return;
	}

	if(!isdefined(param_04))
	{
		if(!isdefined(param_00))
		{
			return;
		}

		param_04 = param_00;
	}

	if(isdefined(param_04))
	{
		if(level.var_984D)
		{
			if(isdefined(param_04.var_1A7) && param_04.var_1A7 == self.var_1A7)
			{
				return;
			}
			else if(isdefined(param_00) && isdefined(param_00.var_1A7) && param_00.var_1A7 == self.var_1A7)
			{
				return;
			}
		}

		var_06 = maps/mp/bots/_bots_util::func_19F7(param_00,param_04);
		if(isdefined(var_06))
		{
			self method_835B(var_06);
		}
	}

	if(function_01EF(self))
	{
		self notify("agentDamage");
	}
}

//Function Number: 52
func_6A7A(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	self method_835A();
	self method_8358();
	var_0A = maps/mp/bots/_bots_util::func_19F7(param_01,param_00);
	if(isdefined(var_0A) && var_0A.var_3A == "misc_turret" && isdefined(var_0A.var_2210))
	{
		var_0A = var_0A.var_2210;
	}

	if(isdefined(var_0A) && (var_0A.var_3A == "script_vehicle" || var_0A.var_3A == "script_model") && isdefined(var_0A.var_4C9E))
	{
		var_0B = self botgetdifficultysetting("launcherRespawnChance");
		if(randomfloat(1) < var_0B)
		{
			self.var_7DB2 = 1;
		}
	}
}

//Function Number: 53
func_1AE2()
{
	var_05 = 0;
	var_06 = self botgetdifficulty();
	if(var_06 == "recruit")
	{
		var_05 = 0.1;
	}
	else if(var_06 == "regular")
	{
		var_05 = 0.4;
	}
	else if(var_06 == "hardened")
	{
		var_05 = 0.7;
	}
	else if(var_06 == "veteran")
	{
		var_05 = 1;
	}

	return randomfloat(1) < 1 - var_05;
}

//Function Number: 54
func_1AE3()
{
	return 1;
}

//Function Number: 55
func_1AB7()
{
	self thread [[ level.var_19D5["bot_think_watch_enemy"] ]]();
	self thread [[ level.var_19D5["bot_think_tactical_goals"] ]]();
	self thread [[ level.var_19D5["dropped_weapon_think"] ]]();
	if(!level.var_53C7)
	{
		thread func_1AFE();
		thread func_1AFF();
	}

	if(maps\mp\_utility::func_F5C())
	{
		thread maps/mp/bots/_bots_ks::func_1B01();
		thread maps/mp/bots/_bots_ks::func_1B05();
	}

	thread func_1B00();
}

//Function Number: 56
func_1B06(param_00)
{
	var_01 = "spawned_player";
	if(isdefined(param_00) && param_00)
	{
		var_01 = "death";
	}

	self notify("bot_think_watch_enemy");
	self endon("bot_think_watch_enemy");
	self endon(var_01);
	self endon("disconnect");
	level endon("game_ended");
	self.var_5B21 = 0;
	for(;;)
	{
		if(isdefined(self.var_88))
		{
			if(self method_8371(self.var_88))
			{
				self.var_5B21 = gettime();
			}
		}

		wait 0.05;
	}
}

//Function Number: 57
func_1B03()
{
	self notify("bot_think_seek_dropped_weapons");
	self endon("bot_think_seek_dropped_weapons");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		var_00 = 0;
		if(maps/mp/bots/_bots_util::func_1A8B())
		{
			if(self [[ level.var_19D5["should_pickup_weapons"] ]]() && !maps/mp/bots/_bots_util::func_1A36())
			{
				var_01 = getentarray("dropped_weapon","targetname");
				var_02 = common_scripts\utility::func_40B0(self.var_116,var_01);
				if(var_02.size > 0)
				{
					var_03 = var_02[0];
					func_1AC1(var_03);
				}
			}
		}

		wait(randomfloatrange(0.25,0.75));
	}
}

//Function Number: 58
func_1AC1(param_00)
{
	if(maps/mp/bots/_bots_strategy::func_1A14("seek_dropped_weapon",param_00) == 0)
	{
		var_01 = undefined;
		if(param_00.var_1A5 == "dropped_weapon")
		{
			var_02 = 1;
			var_03 = self getweaponslistprimaries();
			foreach(var_05 in var_03)
			{
				if(param_00.var_106 == getweaponmodel(var_05))
				{
					var_02 = 0;
				}
			}

			if(var_02)
			{
				var_01 = ::func_1A9B;
			}
		}

		var_07 = spawnstruct();
		var_07.var_68FB = param_00;
		var_07.var_81C8 = 12;
		var_07.var_8B3E = level.var_19D5["dropped_weapon_cancel"];
		var_07.var_87F = var_01;
		maps/mp/bots/_bots_strategy::func_1A85("seek_dropped_weapon",param_00.var_116,100,var_07);
	}
}

//Function Number: 59
func_1A9B(param_00)
{
	self botpressbutton("use",2);
	wait(2);
}

//Function Number: 60
func_8B80(param_00)
{
	if(!isdefined(param_00.var_68FB))
	{
		return 1;
	}

	if(param_00.var_68FB.var_1A5 == "dropped_weapon")
	{
		if(maps/mp/bots/_bots_util::func_1A07() > 0)
		{
			return 1;
		}
	}
	else if(param_00.var_68FB.var_1A5 == "dropped_knife")
	{
		if(maps/mp/bots/_bots_util::func_1A1C())
		{
			self.var_4813 = undefined;
			return 1;
		}
	}

	return 0;
}

//Function Number: 61
func_2739(param_00)
{
	if(!isdefined(param_00.var_117) || param_00.var_117 != self)
	{
		if(distancesquared(self.var_116,param_00.var_116) > 4194304)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 62
func_1982(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(!self [[ level.var_19D5["crate_can_use"] ]](param_00))
	{
		return 0;
	}

	if(!func_273B(param_00))
	{
		return 0;
	}

	if(level.var_984D && isdefined(param_00.var_18B3) && isdefined(param_00.var_1A7) && param_00.var_1A7 == self.var_1A7)
	{
		return 0;
	}

	if(!self [[ level.var_19D5["crate_in_range"] ]](param_00))
	{
		return 0;
	}

	if(isdefined(param_00.var_1B7B))
	{
		if(isdefined(level.var_1B79) && isdefined(level.var_1B79[param_00.var_1B7B]) && ![[ level.var_1B79[param_00.var_1B7B].var_1F7A ]]())
		{
			return 0;
		}

		if(isdefined(param_00.var_2F75) && isdefined(param_00.var_2F75[self getentitynumber()]) && param_00.var_2F75[self getentitynumber()])
		{
			return 0;
		}

		if(!self [[ level.var_1962[param_00.var_1B7B] ]](param_00))
		{
			return 0;
		}
	}
	else if(func_1A13(param_00))
	{
		return 0;
	}

	return isdefined(param_00);
}

//Function Number: 63
func_1A13(param_00)
{
	if(isdefined(param_00.var_944E) && isdefined(self.var_12C["killstreaks"]))
	{
		foreach(var_02 in self.var_12C["killstreaks"])
		{
			if(common_scripts\utility::func_562E(var_02.var_5703) && isdefined(var_02.var_944C) && var_02.var_944C == param_00.var_944E)
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 64
func_273B(param_00)
{
	if(!func_2738(param_00))
	{
		return 0;
	}

	if(!func_273A(param_00))
	{
		return 0;
	}

	return isdefined(param_00);
}

//Function Number: 65
func_2738(param_00)
{
	if(isdefined(param_00.var_1B7B))
	{
		return gettime() > param_00.alignx + 1000;
	}

	return isdefined(param_00.var_34A3) && !param_00.var_34A3;
}

//Function Number: 66
func_273A(param_00)
{
	if(!isdefined(param_00.var_6AA9))
	{
		func_2733(param_00);
	}

	return isdefined(param_00) && param_00.var_6AA9;
}

//Function Number: 67
func_6717(param_00,param_01)
{
	if(isdefined(param_01.var_1B7B) && param_01.var_1B7B == "scavenger_bag")
	{
		return abs(param_00.var_116[0] - param_01.var_116[0]) < 36 && abs(param_00.var_116[0] - param_01.var_116[0]) < 36 && abs(param_00.var_116[0] - param_01.var_116[0]) < 18;
	}

	var_02 = getdvarfloat("2098");
	var_03 = distancesquared(param_01.var_116,param_00.var_116 + (0,0,40));
	return var_03 <= var_02 * var_02;
}

//Function Number: 68
func_2733(param_00)
{
	param_00 thread func_273E();
	param_00.var_6AA9 = 0;
	var_01 = undefined;
	var_02 = undefined;
	if(isdefined(param_00.var_3E18))
	{
		var_01 = param_00.var_3E18;
		var_02 = gettime() + 30000;
		param_00.var_3E18 = var_02;
		param_00 notify("path_disconnect");
	}

	wait 0.05;
	if(!isdefined(param_00))
	{
		return;
	}

	var_03 = [];
	var_03 = func_2737(param_00);
	if(!isdefined(param_00))
	{
		return;
	}

	if(isdefined(var_03) && var_03.size > 0)
	{
		param_00.var_663A = var_03;
		param_00.var_6AA9 = 1;
	}
	else
	{
		var_04 = getdvarfloat("2098");
		var_05 = getnodesinradiussorted(param_00.var_116,var_04 * 2,0)[0];
		var_06 = param_00 method_8216(0,0,-1);
		var_07 = undefined;
		if(isdefined(param_00.var_1B7B) && param_00.var_1B7B == "scavenger_bag")
		{
			if(maps/mp/bots/_bots_util::func_1A9D(param_00.var_116))
			{
				var_07 = param_00.var_116;
			}
		}
		else
		{
			var_07 = botgetclosestnavigablepoint(param_00.var_116,var_04);
		}

		if(isdefined(var_05) && !var_05 method_8389() && isdefined(var_07) && abs(var_05.var_116[2] - var_06[2]) < 30)
		{
			param_00.var_663B = [var_07];
			param_00.var_663A = [var_05];
			param_00.var_6AA9 = 1;
		}
	}

	if(isdefined(param_00.var_3E18))
	{
		if(param_00.var_3E18 == var_02)
		{
			param_00.var_3E18 = var_01;
		}
	}
}

//Function Number: 69
func_2737(param_00)
{
	var_01 = getnodesinradiussorted(param_00.var_116,256,0);
	for(var_02 = var_01.size;var_02 > 0;var_02--)
	{
		var_01[var_02] = var_01[var_02 - 1];
	}

	var_01[0] = function_00BA(param_00.var_116);
	var_03 = undefined;
	if(isdefined(param_00.var_3E18))
	{
		var_03 = getallnodes();
	}

	var_04 = [];
	var_05 = 1;
	if(!isdefined(param_00.var_1B7B))
	{
		var_05 = 2;
	}

	for(var_02 = 0;var_02 < var_01.size;var_02++)
	{
		var_06 = var_01[var_02];
		if(!isdefined(var_06) || !isdefined(param_00))
		{
			continue;
		}

		if(var_06 method_8389())
		{
			continue;
		}

		if(!func_6717(var_06,param_00))
		{
			if(var_02 == 0)
			{
				continue;
			}
			else
			{
				break;
			}
		}

		wait 0.05;
		if(!isdefined(param_00))
		{
			break;
		}

		if(sighttracepassed(param_00.var_116,var_06.var_116 + (0,0,55),0,param_00))
		{
			wait 0.05;
			if(!isdefined(param_00))
			{
				break;
			}

			if(!isdefined(param_00.var_3E18))
			{
				var_04[var_04.size] = var_06;
				if(var_04.size == var_05)
				{
					return var_04;
				}
				else
				{
					continue;
				}
			}

			var_07 = undefined;
			var_08 = 0;
			while(!isdefined(var_07) && var_08 < 100)
			{
				var_08++;
				var_09 = common_scripts\utility::func_7A33(var_03);
				if(distancesquared(var_06.var_116,var_09.var_116) > 250000)
				{
					var_07 = var_09;
				}
			}

			if(isdefined(var_07))
			{
				var_0A = maps/mp/bots/_bots_util::func_1AA8("GetNodesOnPathCrate",::maps/mp/bots/_bots_util::func_3F07,var_06.var_116,var_07.var_116);
				if(isdefined(var_0A))
				{
					var_04[var_04.size] = var_06;
					if(var_04.size == var_05)
					{
						return var_04;
					}
					else
					{
						continue;
					}
				}
			}
		}
	}

	return undefined;
}

//Function Number: 70
func_2736(param_00)
{
	if(isdefined(param_00.var_663B))
	{
		return param_00.var_663B[0];
	}

	if(isdefined(param_00.var_663A) && param_00.var_663A.size > 0)
	{
		var_01 = common_scripts\utility::func_FA2(self method_8382(param_00.var_663A,"node_exposed"));
		return common_scripts\utility::func_7A46(var_01).var_116;
	}
}

//Function Number: 71
func_1AFE()
{
	self notify("bot_think_crate");
	self endon("bot_think_crate");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_00 = getdvarfloat("2098");
	for(;;)
	{
		var_01 = randomfloatrange(2,4);
		common_scripts\utility::func_A74B("new_crate_to_take",var_01);
		if(isdefined(self.var_1B75) && self.var_1B75.size == 0)
		{
			self.var_1B75 = undefined;
		}

		var_02 = level.var_1FFD;
		if(!maps/mp/bots/_bots_util::func_1A1C() && isdefined(self.var_1B75))
		{
			var_02 = common_scripts\utility::func_F73(var_02,self.var_1B75);
		}

		if(isdefined(level.var_1ABB) && maps\mp\_utility::func_649("specialty_scavenger"))
		{
			var_02 = common_scripts\utility::func_F73(var_02,level.var_1ABB);
		}

		var_02 = common_scripts\utility::func_FA0(var_02);
		if(var_02.size == 0)
		{
			continue;
		}

		if(maps/mp/bots/_bots_strategy::func_1A14("airdrop_crate") || self method_835F() == "tactical" || maps/mp/bots/_bots_util::func_1A36())
		{
			continue;
		}

		var_03 = [];
		foreach(var_05 in var_02)
		{
			if(func_1982(var_05))
			{
				var_03[var_03.size] = var_05;
			}
		}

		var_03 = common_scripts\utility::func_F97(var_03);
		if(var_03.size == 0)
		{
			continue;
		}

		var_03 = common_scripts\utility::func_40B0(self.var_116,var_03);
		var_07 = self getnearestnode();
		if(!isdefined(var_07))
		{
			continue;
		}

		var_08 = self [[ level.var_19D5["crate_low_ammo_check"] ]]();
		var_09 = (var_08 || randomint(100) < 50) && !maps\mp\_utility::func_56D7();
		var_0A = undefined;
		foreach(var_05 in var_03)
		{
			var_0C = 0;
			if((!isdefined(var_05.var_117) || var_05.var_117 != self) && !isdefined(var_05.var_1B7B))
			{
				var_0D = [];
				foreach(var_0F in level.var_744A)
				{
					if(!isdefined(var_0F.var_1A7))
					{
						continue;
					}

					if(!isai(var_0F) && level.var_984D && var_0F.var_1A7 == self.var_1A7)
					{
						if(distancesquared(var_0F.var_116,var_05.var_116) < 490000)
						{
							var_0D[var_0D.size] = var_0F;
						}
					}
				}

				if(var_0D.size > 0)
				{
					var_11 = var_0D[0] getnearestnode();
					if(isdefined(var_11))
					{
						var_0C = 0;
						foreach(var_13 in var_05.var_663A)
						{
							var_0C = var_0C | function_01F4(var_11,var_13,1);
						}
					}
				}
			}

			if(!var_0C)
			{
				var_15 = isdefined(var_05.var_1B39) && isdefined(var_05.var_1B39[self.var_1A7]) && var_05.var_1B39[self.var_1A7] > 0;
				var_16 = 0;
				foreach(var_13 in var_05.var_663A)
				{
					var_16 = var_16 | function_01F4(var_07,var_13,1);
				}

				if(var_16 || var_09 && !var_15)
				{
					var_0A = var_05;
					break;
				}
			}
		}

		if(isdefined(var_0A))
		{
			if(self [[ level.var_19D5["crate_should_claim"] ]]())
			{
				if(!isdefined(var_0A.var_1B7B))
				{
					if(!isdefined(var_0A.var_1B39))
					{
						var_0A.var_1B39 = [];
					}

					var_0A.var_1B39[self.var_1A7] = 1;
				}
			}

			var_1A = spawnstruct();
			var_1A.var_68FB = var_0A;
			var_1A.var_9296 = ::func_A87F;
			var_1A.var_8B3E = ::func_2740;
			var_1B = undefined;
			if(isdefined(var_0A.var_1B7B))
			{
				if(isdefined(var_0A.var_1B7A) && var_0A.var_1B7A)
				{
					var_1A.var_81C8 = 16;
					var_1A.var_87F = undefined;
					var_1B = var_0A.var_116;
				}
				else
				{
					var_1A.var_81C8 = 50;
					var_1A.var_87F = ::func_A1D8;
					var_1C = func_2736(var_0A) - var_0A.var_116;
					var_1D = length(var_1C) * randomfloat(1);
					var_1B = var_0A.var_116 + vectornormalize(var_1C) * var_1D + (0,0,12);
				}
			}
			else
			{
				var_1A.var_87F = ::func_A1DC;
				var_1A.var_36AC = ::func_93F1;
				var_1B = func_2736(var_0A);
				var_1A.var_81C8 = var_00 - distance(var_0A.var_116,var_1B + (0,0,40));
				var_1B = var_1B + (0,0,24);
			}

			if(isdefined(var_1A.var_81C8))
			{
			}

			var_0A notify("path_disconnect");
			wait 0.05;
			if(!isdefined(var_0A))
			{
				continue;
			}

			maps/mp/bots/_bots_strategy::func_1A85("airdrop_crate",var_1B,30,var_1A);
		}
	}
}

//Function Number: 72
func_1AE6(param_00)
{
	return 1;
}

//Function Number: 73
func_2741()
{
	return 1;
}

//Function Number: 74
func_273D()
{
	return 0;
}

//Function Number: 75
func_1AE5(param_00)
{
	if(self getcurrentweapon() == level.var_1B79[param_00.var_1B7B].var_6209)
	{
		return 0;
	}

	return 1;
}

//Function Number: 76
func_1AA1(param_00)
{
	self switchtoweapon(self.var_835A);
	wait(1);
}

//Function Number: 77
func_1A9F(param_00)
{
	self switchtoweapon("none");
	self.var_835A = self getcurrentweapon();
}

//Function Number: 78
func_1AE9(param_00)
{
	if(maps/mp/bots/_bots_util::func_19F8(0.66))
	{
		var_01 = self getnearestnode();
		if(isdefined(param_00.var_663A) && isdefined(param_00.var_663A[0]) && isdefined(var_01))
		{
			if(function_01F4(var_01,param_00.var_663A[0],1))
			{
				if(common_scripts\utility::func_AA4A(self.var_116,self getangles(),param_00.var_116,self method_8375()))
				{
					return 1;
				}
			}
		}
	}

	return 0;
}

//Function Number: 79
func_1AE7(param_00)
{
	var_01 = self getweaponslistoffhands();
	foreach(var_03 in var_01)
	{
		if(self getweaponammostock(var_03) == 0)
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 80
func_1AE8(param_00)
{
	return 1;
}

//Function Number: 81
func_273E()
{
	self notify("crate_monitor_position");
	self endon("crate_monitor_position");
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		var_00 = self.var_116;
		wait(0.5);
		if(!isdefined(self))
		{
			return;
		}

		if(!maps/mp/bots/_bots_util::func_1B1C(self.var_116,var_00))
		{
			self.var_6AA9 = undefined;
			self.var_663A = undefined;
			self.var_663B = undefined;
		}
	}
}

//Function Number: 82
func_2743()
{
}

//Function Number: 83
func_2740(param_00)
{
	if(!isdefined(param_00.var_68FB))
	{
		return 1;
	}

	return 0;
}

//Function Number: 84
func_A1DC(param_00)
{
	if(function_01EF(self))
	{
		common_scripts\utility::func_615();
		param_00.var_68FB enableplayeruse(self);
		wait 0.05;
	}

	self [[ level.var_19D5["crate_wait_use"] ]]();
	if(isdefined(param_00.var_68FB.var_117) && param_00.var_68FB.var_117 == self)
	{
		var_01 = level.var_2751 / 1000 + 0.5;
	}
	else
	{
		var_01 = level.var_274E / 1000 + 1;
	}

	self botpressbutton("use",var_01);
	while(var_01 > 0 && isdefined(param_00.var_68FB))
	{
		wait 0.05;
		var_01 = var_01 - 0.05;
	}

	if(var_01 > 0)
	{
		wait(randomfloatrange(0.05,0.5));
	}

	if(function_01EF(self))
	{
		common_scripts\utility::func_601();
		if(isdefined(param_00.var_68FB))
		{
			param_00.var_68FB disableplayeruse(self);
		}
	}

	if(isdefined(param_00.var_68FB))
	{
		if(!isdefined(param_00.var_68FB.var_1B44))
		{
			param_00.var_68FB.var_1B44 = [];
		}

		param_00.var_68FB.var_1B44[param_00.var_68FB.var_1B44.size] = self;
	}
}

//Function Number: 85
func_A1D8(param_00)
{
	if(function_01EF(self))
	{
		common_scripts\utility::func_615();
		param_00.var_68FB enableplayeruse(self);
		wait 0.05;
	}

	if(isdefined(param_00.var_68FB) && isdefined(param_00.var_68FB.var_1B7B))
	{
		var_01 = param_00.var_68FB.var_1B7B;
		if(isdefined(level.var_1AA2[var_01]))
		{
			self [[ level.var_1AA2[var_01] ]](param_00.var_68FB);
		}

		if(isdefined(param_00.var_68FB))
		{
			var_02 = level.var_1B79[param_00.var_68FB.var_1B7B].var_A23F / 1000 + 0.5;
			self botpressbutton("use",var_02);
			wait(var_02);
			if(isdefined(level.var_1AA0[var_01]))
			{
				self [[ level.var_1AA0[var_01] ]](param_00.var_68FB);
			}
		}
	}

	if(function_01EF(self))
	{
		common_scripts\utility::func_601();
		if(isdefined(param_00.var_68FB))
		{
			param_00.var_68FB disableplayeruse(self);
		}
	}
}

//Function Number: 86
func_A87F(param_00)
{
	thread func_1B28(param_00.var_68FB);
}

//Function Number: 87
func_93F1(param_00)
{
	if(isdefined(param_00.var_A861) && param_00.var_A861)
	{
		self botsetstance("none");
		self botlookatpoint(undefined);
	}

	if(isdefined(param_00.var_68FB))
	{
		param_00.var_68FB.var_1B39[self.var_1A7] = 0;
	}
}

//Function Number: 88
func_1B28(param_00)
{
	param_00 endon("death");
	param_00 endon("revived");
	param_00 endon("disconnect");
	level endon("game_ended");
	var_01 = self.var_1A7;
	common_scripts\utility::knock_off_battery("death","disconnect");
	if(isdefined(param_00))
	{
		param_00.var_1B39[var_01] = 0;
	}
}

//Function Number: 89
func_1AFF()
{
	self notify("bot_think_crate_blocking_path");
	self endon("bot_think_crate_blocking_path");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_00 = getdvarfloat("2098");
	for(;;)
	{
		wait(3);
		if(self usebuttonpressed())
		{
			continue;
		}

		if(maps\mp\_utility::func_581D())
		{
			continue;
		}

		var_01 = level.var_1FFD;
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			var_03 = var_01[var_02];
			if(!isdefined(var_03))
			{
				continue;
			}

			var_04 = self method_84D1();
			if(!isdefined(var_04) || var_04 != var_03)
			{
				continue;
			}

			if(distancesquared(self.var_116,var_03.var_116) < var_00 * var_00)
			{
				if(!func_1A13(var_03))
				{
					if(isdefined(var_03.var_117) && var_03.var_117 == self)
					{
						self botpressbutton("use",level.var_2751 / 1000 + 0.5);
						continue;
					}

					self botpressbutton("use",level.var_274E / 1000 + 0.5);
				}
			}
		}
	}
}

//Function Number: 90
func_1B02()
{
	self notify("bot_think_revive");
	self endon("bot_think_revive");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(!level.var_984D)
	{
		return;
	}

	for(;;)
	{
		var_00 = 2;
		var_01 = getentarray("revive_trigger","targetname");
		if(var_01.size > 0)
		{
			var_00 = 0.05;
		}

		level common_scripts\utility::func_A74B("player_last_stand",var_00);
		if(!func_1959())
		{
			continue;
		}

		var_01 = getentarray("revive_trigger","targetname");
		if(var_01.size > 1)
		{
			var_01 = function_01AC(var_01,self.var_116);
			if(isdefined(self.var_117))
			{
				for(var_02 = 0;var_02 < var_01.size;var_02++)
				{
					if(var_01[var_02].var_117 != self.var_117)
					{
						continue;
					}

					if(var_02 == 0)
					{
						break;
					}

					var_03 = var_01[var_02];
					var_01[var_02] = var_01[0];
					var_01[0] = var_03;
					break;
				}
			}
		}

		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			var_04 = var_01[var_02];
			var_05 = var_04.var_117;
			if(!isdefined(var_05))
			{
				continue;
			}

			if(var_05 == self)
			{
				continue;
			}

			if(!isalive(var_05))
			{
				continue;
			}

			if(var_05.var_1A7 != self.var_1A7)
			{
				continue;
			}

			if(!isdefined(var_05.var_5378) || !var_05.var_5378)
			{
				continue;
			}

			if(isdefined(var_05.var_1B39) && isdefined(var_05.var_1B39[self.var_1A7]) && var_05.var_1B39[self.var_1A7] > 0)
			{
				continue;
			}

			if(distancesquared(self.var_116,var_05.var_116) < 4194304)
			{
				var_06 = spawnstruct();
				var_06.var_68FB = var_04;
				var_06.var_81C8 = 64;
				if(isdefined(self.var_5B44) && gettime() - self.var_5B44 < 1000)
				{
					var_06.var_81C8 = 32;
				}

				var_06.var_9296 = ::func_A880;
				var_06.var_36AC = ::func_93E6;
				var_06.var_8B3E = ::func_7311;
				var_06.var_87F = ::func_7E52;
				maps/mp/bots/_bots_strategy::func_1A85("revive",var_05.var_116,60,var_06);
				break;
			}
		}
	}
}

//Function Number: 91
func_A880(param_00)
{
	thread func_1B28(param_00.var_68FB.var_117);
}

//Function Number: 92
func_93E6(param_00)
{
	if(isdefined(param_00.var_68FB.var_117))
	{
		param_00.var_68FB.var_117.var_1B39[self.var_1A7] = 0;
	}
}

//Function Number: 93
func_7311(param_00)
{
	if(!isdefined(param_00.var_68FB.var_117) || param_00.var_68FB.var_117.var_BC <= 0)
	{
		return 1;
	}

	if(!isdefined(param_00.var_68FB.var_117.var_5378) || !param_00.var_68FB.var_117.var_5378)
	{
		return 1;
	}

	return 0;
}

//Function Number: 94
func_7E52(param_00)
{
	if(distancesquared(self.var_116,param_00.var_68FB.var_117.var_116) > 4096)
	{
		self.var_5B44 = gettime();
		return;
	}

	if(function_01EF(self))
	{
		common_scripts\utility::func_615();
		param_00.var_68FB enableplayeruse(self);
		wait 0.05;
	}

	var_01 = self.var_1A7;
	self botpressbutton("use",level.var_5BFA / 1000 + 0.5);
	wait(level.var_5BFA / 1000 + 1.5);
	if(isdefined(param_00.var_68FB.var_117))
	{
		param_00.var_68FB.var_1B39[var_01] = 0;
	}

	if(function_01EF(self))
	{
		common_scripts\utility::func_601();
		if(isdefined(param_00.var_68FB))
		{
			param_00.var_68FB disableplayeruse(self);
		}
	}
}

//Function Number: 95
func_1959()
{
	if(isdefined(self.var_E8) && self.var_E8 == 1)
	{
		return 0;
	}

	if(maps/mp/bots/_bots_strategy::func_1A14("revive"))
	{
		return 0;
	}

	if(maps/mp/bots/_bots_util::func_1A36())
	{
		return 0;
	}

	if(maps/mp/bots/_bots_util::func_1A27())
	{
		return 1;
	}

	var_00 = self method_835F();
	if(var_00 == "none" || var_00 == "hunt" || var_00 == "guard")
	{
		return 1;
	}

	return 0;
}

//Function Number: 96
func_7E53(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("bad_path");
	self endon("goal");
	param_00 common_scripts\utility::knock_off_battery("death","revived");
	self notify("bad_path");
}

//Function Number: 97
func_1A52()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(gettime() > 15000)
	{
		return;
	}

	while(!maps\mp\_utility::func_3FA6() || !maps\mp\_utility::func_3FA0("prematch_done"))
	{
		wait 0.05;
	}

	var_00 = undefined;
	var_01 = undefined;
	for(var_02 = 0;var_02 < level.var_744A.size;var_02++)
	{
		var_03 = level.var_744A[var_02];
		if(isdefined(var_03) && isdefined(self.var_1A7) && isdefined(var_03.var_1A7) && !isalliedsentient(self,var_03))
		{
			if(!isdefined(var_03.var_1AF2))
			{
				var_00 = var_03;
			}

			if(isai(var_03) && !isdefined(var_03.var_1AF1))
			{
				var_01 = var_03;
			}
		}
	}

	if(isdefined(var_00))
	{
		self.var_1AF1 = 1;
		var_00.var_1AF2 = 1;
		self getenemyinfo(var_00);
	}

	if(isdefined(var_01))
	{
		var_01.var_1AF1 = 1;
		self.var_1AF2 = 1;
		var_01 getenemyinfo(self);
	}
}

//Function Number: 98
func_1A70(param_00,param_01,param_02,param_03,param_04)
{
	return self makeentitysentient(param_00,param_01,param_02,param_03,param_04);
}

//Function Number: 99
bot_free_entity_sentient()
{
	self freeentitysentient();
}

//Function Number: 100
func_1B00()
{
	self notify("bot_think_gametype");
	self endon("bot_think_gametype");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	maps\mp\_utility::func_3FA5("prematch_done");
	self thread [[ level.var_19D5["gametype_think"] ]]();
}

//Function Number: 101
func_2B9C()
{
}

//Function Number: 102
func_6348()
{
	maps/mp/bots/_bots_util::func_1B20();
	level.var_1AEC = getent("smoke_grenade_sight_clip_small","targetname");
	if(!isdefined(level.var_1AEC))
	{
		return;
	}

	level.var_1AEB = getent("smoke_grenade_sight_clip_medium","targetname");
	if(!isdefined(level.var_1AEB))
	{
		return;
	}

	level.var_1AEA = getent("smoke_grenade_sight_clip_large","targetname");
	if(!isdefined(level.var_1AEA))
	{
		return;
	}

	for(;;)
	{
		level waittill("smoke",var_00,var_01);
		var_02 = maps\mp\_utility::func_9472(var_01,"_lefthand");
		if(var_02 == "smoke_grenade_mp" || var_02 == "smoke_grenade_axis_mp" || var_02 == "smoke_grenade_expeditionary_mp" || var_02 == "smoke_grenade_axis_expeditionary_mp")
		{
			var_00 thread func_4A5C();
		}
	}
}

//Function Number: 103
func_4A5C()
{
	self waittill("explode",var_00);
	var_01 = common_scripts\utility::func_8FFC();
	var_01 method_805B();
	var_01 enableaiseethroughentatshortdistance(1);
	var_01.var_116 = var_00;
	var_02 = 0.3;
	wait(var_02);
	var_02 = 0.4;
	var_01 clonebrushmodeltoscriptmodel(level.var_1AEC);
	wait(var_02);
	var_02 = 0.45;
	var_01 clonebrushmodeltoscriptmodel(level.var_1AEB);
	wait(var_02);
	var_02 = 9.8;
	var_01 clonebrushmodeltoscriptmodel(level.var_1AEA);
	wait(var_02);
	var_02 = 1;
	var_01 clonebrushmodeltoscriptmodel(level.var_1AEB);
	wait(var_02);
	var_02 = 0.65;
	var_01 clonebrushmodeltoscriptmodel(level.var_1AEC);
	wait(var_02);
	var_01 delete();
}

//Function Number: 104
func_192F(param_00)
{
	var_01 = 0;
	param_00.var_1B7B = "scavenger_bag";
	param_00.var_1B7A = 1;
	if(!isdefined(level.var_1ABB))
	{
		level.var_1ABB = [];
	}

	foreach(var_04, var_03 in level.var_1ABB)
	{
		if(!isdefined(var_03))
		{
			var_01 = 1;
			level.var_1ABB[var_04] = param_00;
			break;
		}
	}

	if(!var_01)
	{
		level.var_1ABB[level.var_1ABB.size] = param_00;
	}

	foreach(var_06 in level.var_6E97)
	{
		if(isai(var_06) && var_06 maps\mp\_utility::func_649("specialty_scavenger"))
		{
			var_06 notify("new_crate_to_take");
		}
	}
}

//Function Number: 105
func_1B07()
{
	var_00 = getentarray("bot_flag_set","targetname");
	foreach(var_02 in var_00)
	{
		if(!isdefined(var_02.var_165))
		{
			continue;
		}

		var_02 thread func_19D2(var_02.var_165);
	}
}

//Function Number: 106
func_19D2(param_00)
{
	self endon("death");
	for(;;)
	{
		self waittill("trigger",var_01);
		if(maps\mp\_utility::func_5666(var_01))
		{
			var_01 notify("flag_trigger_set_" + param_00);
			var_01 botsetflag(param_00,1);
			var_01 thread func_19D3(param_00);
		}
	}
}

//Function Number: 107
func_19D3(param_00)
{
	self endon("flag_trigger_set_" + param_00);
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait 0.05;
	waittillframeend;
	self botsetflag(param_00,0);
}