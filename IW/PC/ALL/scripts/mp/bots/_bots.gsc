/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\bots\_bots.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 111
 * Decompile Time: 5745 ms
 * Timestamp: 10/27/2023 12:11:46 AM
*******************************************************************/

//Function Number: 1
main()
{
	if(isdefined(level.createfx_enabled) && level.createfx_enabled)
	{
		return;
	}

	func_F8F4();
	scripts\mp\bots\_bots_personality::func_F9FD();
	level.var_274F = ::badplace_cylinder;
	level.var_2750 = ::badplace_delete;
	scripts\mp\bots\_bots_killstreaks::func_2DF3();
	scripts\mp\bots\_bots_powers::func_2E53();
	scripts\mp\bots\_bots_loadout::init();
	level thread init();
}

//Function Number: 2
func_F8F4()
{
	level.var_2D9E = [];
	level.var_2D9E["bots_spawn"] = ::func_10656;
	level.var_2D9E["bots_add_scavenger_bag"] = ::func_2D04;
	level.var_2D9E["bots_add_to_level_targets"] = ::scripts\mp\bots\_bots_util::func_2D06;
	level.var_2D9E["bots_remove_from_level_targets"] = ::scripts\mp\bots\_bots_util::func_2E64;
	level.var_2D9E["bots_make_entity_sentient"] = ::func_2E16;
	level.var_2D9E["think"] = ::func_2EAE;
	level.var_2D9E["on_killed"] = ::func_C4AC;
	level.var_2D9E["should_do_killcam"] = ::func_2E8E;
	level.var_2D9E["get_attacker_ent"] = ::scripts\mp\bots\_bots_util::func_2DAF;
	level.var_2D9E["should_pickup_weapons"] = ::func_2E90;
	level.var_2D9E["on_damaged"] = ::func_2D47;
	level.var_2D9E["gametype_think"] = ::func_4FF3;
	level.var_2D9E["leader_dialog"] = ::scripts\mp\bots\_bots_util::func_2DFB;
	level.var_2D9E["player_spawned"] = ::func_2E4D;
	level.var_2D9E["should_start_cautious_approach"] = ::scripts\mp\bots\_bots_strategy::func_FF9A;
	level.var_2D9E["know_enemies_on_start"] = ::func_2DF8;
	level.var_2D9E["bot_get_rank_xp"] = ::func_2DB3;
	level.var_2D9E["ai_3d_sighting_model"] = ::func_2D00;
	level.var_2D9E["dropped_weapon_think"] = ::func_2EB6;
	level.var_2D9E["dropped_weapon_cancel"] = ::func_FFA0;
	level.var_2D9E["crate_can_use"] = ::func_4831;
	level.var_2D9E["crate_low_ammo_check"] = ::func_483E;
	level.var_2D9E["crate_should_claim"] = ::func_484B;
	level.var_2D9E["crate_wait_use"] = ::func_484D;
	level.var_2D9E["crate_in_range"] = ::func_483B;
	level.var_2D9E["post_teleport"] = ::func_2E50;
	level.var_2E5E = [];
	level.var_2E5E["allies"] = ::scripts\mp\bots\_bots_personality::func_2E5D;
	level.var_2E5E["axis"] = ::scripts\mp\bots\_bots_personality::func_2E5D;
	level.var_2D27["deployable_vest"] = ::func_2E93;
	level.var_2D27["deployable_ammo"] = ::func_2E92;
	level.var_2D27["scavenger_bag"] = ::func_2E96;
	level.var_2D27["deployable_grenades"] = ::func_2E94;
	level.var_2D27["deployable_juicebox"] = ::func_2E95;
	level.var_2E55["deployable_ammo"] = ::func_2E54;
	level.var_2E52["deployable_ammo"] = ::func_2E51;
	level.var_2D76["capture"] = ::scripts\mp\bots\_bots_strategy::func_6C87;
	level.var_2D76["capture_zone"] = ::scripts\mp\bots\_bots_strategy::func_6C88;
	level.var_2D76["protect"] = ::scripts\mp\bots\_bots_strategy::func_6C8A;
	level.var_2D76["bodyguard"] = ::scripts\mp\bots\_bots_strategy::func_6C86;
	level.var_2D76["patrol"] = ::scripts\mp\bots\_bots_strategy::func_6C89;
	scripts\mp\bots\gametype_war::func_F8F4();
	if(scripts\mp\_utility::func_2DD9())
	{
		scripts\mp\bots\_bots_fireteam::func_2D92();
	}
}

//Function Number: 3
func_00AC(param_00,param_01)
{
	if(isdefined(level.var_2D9E) && isdefined(level.var_2D9E["leader_dialog"]))
	{
		self [[ level.var_2D9E["leader_dialog"] ]](param_00,param_01);
	}
}

//Function Number: 4
init()
{
	thread func_B9A3();
	thread func_2EBB();
	func_97DE();
	if(!func_10082())
	{
		return;
	}

	func_DE6C();
	var_00 = function_001F();
	if(var_00 > 0)
	{
		setmatchdata("hasBots",1);
		if(scripts\mp\_utility::func_2DD9())
		{
			level thread scripts\mp\bots\_bots_fireteam::func_2D8E();
			level thread scripts\mp\bots\_bots_fireteam_commander::init();
			return;
		}

		level thread func_2D3A();
	}
}

//Function Number: 5
func_97DE()
{
	if(!isdefined(level.var_485C))
	{
		level.var_485C = 500;
	}

	if(!isdefined(level.var_4859))
	{
		level.var_4859 = 3000;
	}

	level.var_2E3C = 3000;
	level.var_2E66 = "iw6_panzerfaust3";
	level.var_2D70 = "iw7_knife";
	level.var_13FBD = function_00EC();
	level.var_2413 = undefined;
	func_97DF();
}

//Function Number: 6
func_97DF()
{
	if(isdefined(level.var_1165C))
	{
		var_00 = [[ level.var_1165C ]]();
	}
	else
	{
		var_00 = function_0076();
	}

	level.var_2E1B = 0;
	level.var_2E18 = 0;
	level.var_2E1C = 0;
	level.var_2E19 = 0;
	level.var_2E1D = 0;
	level.var_2E1A = 0;
	if(var_00.size > 1)
	{
		level.var_2E1B = var_00[0].origin[0];
		level.var_2E18 = var_00[0].origin[0];
		level.var_2E1C = var_00[0].origin[1];
		level.var_2E19 = var_00[0].origin[1];
		level.var_2E1D = var_00[0].origin[2];
		level.var_2E1A = var_00[0].origin[2];
		for(var_01 = 1;var_01 < var_00.size;var_01++)
		{
			var_02 = var_00[var_01].origin;
			if(var_02[0] < level.var_2E1B)
			{
				level.var_2E1B = var_02[0];
			}

			if(var_02[0] > level.var_2E18)
			{
				level.var_2E18 = var_02[0];
			}

			if(var_02[1] < level.var_2E1C)
			{
				level.var_2E1C = var_02[1];
			}

			if(var_02[1] > level.var_2E19)
			{
				level.var_2E19 = var_02[1];
			}

			if(var_02[2] < level.var_2E1D)
			{
				level.var_2E1D = var_02[2];
			}

			if(var_02[2] > level.var_2E1A)
			{
				level.var_2E1A = var_02[2];
			}
		}
	}

	level.var_2E17 = (level.var_2E1B + level.var_2E18 / 2,level.var_2E1C + level.var_2E19 / 2,level.var_2E1D + level.var_2E1A / 2);
	level.var_2EC5 = 1;
}

//Function Number: 7
func_2E50()
{
	level.var_2EC5 = undefined;
	level.var_2DD0 = undefined;
	func_97DF();
	scripts\mp\bots\_bots_killstreaks_remote_vehicle::func_DF76();
}

//Function Number: 8
func_10082()
{
	return 1;
}

//Function Number: 9
func_DE6C()
{
	wait(1);
	foreach(var_01 in level.players)
	{
		if(isbot(var_01))
		{
			if(isalive(var_01))
			{
				var_01.var_6695 = 1;
				var_01.var_2EAC = var_01.team;
				var_01.var_2E99 = 1;
				var_01 thread [[ level.var_2D9E["think"] ]]();
				continue;
			}
		}
	}
}

//Function Number: 10
func_2E4D()
{
	func_2E82();
	if(isdefined(self.var_D88E))
	{
		scripts\mp\bots\_bots_util::func_2E83(self.var_D88E);
		self.var_D88E = undefined;
	}
}

//Function Number: 11
func_2E82()
{
	if(!isdefined(self.var_2D33))
	{
		if(!func_2D9F())
		{
			while(!isdefined(level.var_2E14))
			{
				wait(0.05);
			}

			if(isdefined(self.var_C80E))
			{
				self.var_2D33 = [[ self.var_C80E ]]();
				return;
			}

			self.var_2D33 = scripts\mp\bots\_bots_personality::func_2E88();
			return;
		}

		self.var_2D33 = self.var_4004;
	}
}

//Function Number: 12
func_13968()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(!isai(var_00) && level.players.size > 0)
		{
			level.var_D40C = scripts\common\utility::array_add(level.var_D40C,var_00);
			childthread func_2EF7(var_00);
			childthread func_2EF6(var_00);
			childthread func_2EF8(var_00);
		}
	}
}

//Function Number: 13
func_2EF7(param_00)
{
	param_00 endon("bots_human_disconnected");
	while(!scripts\common\utility::func_2286(level.players,param_00))
	{
		wait(0.05);
	}

	param_00 notify("bots_human_spawned");
}

//Function Number: 14
func_2EF6(param_00)
{
	param_00 endon("bots_human_spawned");
	param_00 waittill("disconnect");
	param_00 notify("bots_human_disconnected");
}

//Function Number: 15
func_2EF8(param_00)
{
	param_00 scripts\common\utility::waittill_any_3("bots_human_spawned","bots_human_disconnected");
	level.var_D40C = scripts\common\utility::func_22A9(level.var_D40C,param_00);
}

//Function Number: 16
func_B985()
{
	level.var_D40C = [];
	childthread func_13968();
	for(;;)
	{
		if(level.var_D40C.size > 0)
		{
			level.var_C9D7 = 1;
		}
		else
		{
			level.var_C9D7 = 0;
		}

		wait(0.5);
	}
}

//Function Number: 17
func_2D22(param_00)
{
	if(scripts\mp\_utility::func_B3EC())
	{
		return 1;
	}

	if(!level.teambased)
	{
		return 1;
	}

	if(scripts\mp\_teams::func_7F24(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 18
func_2D3A(param_00,param_01)
{
	level endon("game_ended");
	self notify("bot_connect_monitor");
	self endon("bot_connect_monitor");
	level.var_C9D7 = 0;
	childthread func_B985();
	scripts\mp\_hostmigration::func_13708(0.5);
	var_02 = 1.5;
	if(!isdefined(level.var_2D36))
	{
		level.var_2D36 = 0;
	}

	if(!isdefined(level.var_2D37))
	{
		level.var_2D37 = 0;
	}

	if(!isdefined(level.var_2D35))
	{
		level.var_2D35 = 0;
	}

	for(;;)
	{
		if(level.var_C9D7)
		{
			scripts\mp\_hostmigration::func_13708(var_02);
			continue;
		}

		var_03 = isdefined(level.var_2EF5) || !level.teambased;
		var_04 = function_0025(0);
		var_05 = function_0025(1);
		if(level.rankedmatch)
		{
			var_06 = "default";
			var_07 = "default";
		}
		else
		{
			var_06 = function_0024(0);
			var_07 = function_0024(1);
		}

		var_08 = "allies";
		var_09 = "axis";
		var_0A = func_2D34();
		var_0B = func_3B22(var_0A,"humans");
		if(var_0B > 1)
		{
			var_0C = func_2DAD();
			if(!scripts\mp\_utility::func_B3EC() && isdefined(var_0C) && var_0C != "spectator")
			{
				var_08 = var_0C;
				var_09 = scripts\mp\_utility::getotherteam(var_0C);
			}
			else
			{
				var_0D = func_3B22(var_0A,"humans_allies");
				var_0E = func_3B22(var_0A,"humans_axis");
				if(var_0E > var_0D)
				{
					var_08 = "axis";
					var_09 = "allies";
				}
			}
		}
		else
		{
			var_0F = func_7A21();
			if(isdefined(var_0F))
			{
				var_10 = var_0F func_2DB2();
				if(isdefined(var_10) && var_10 != "spectator")
				{
					var_08 = var_10;
					var_09 = scripts\mp\_utility::getotherteam(var_10);
				}
			}
		}

		var_11 = scripts\mp\bots\_bots_util::func_2DB5();
		var_12 = scripts\mp\bots\_bots_util::func_2DB5();
		if(var_11 + var_12 < scripts\mp\bots\_bots_util::func_2DA6())
		{
			if(var_11 < var_04)
			{
				var_11++;
			}
			else if(var_12 < var_05)
			{
				var_12++;
			}
		}

		var_13 = func_3B22(var_0A,"humans_" + var_08);
		var_14 = func_3B22(var_0A,"humans_" + var_09);
		var_15 = var_13 + var_14;
		var_16 = func_3B22(var_0A,"spectator");
		var_17 = 0;
		var_18 = 0;
		while(var_16 > 0)
		{
			var_19 = var_13 + var_17 + 1 <= var_11;
			var_1A = var_14 + var_18 + 1 <= var_12;
			if(var_19 && !var_1A)
			{
				var_17++;
				continue;
			}

			if(!var_19 && var_1A)
			{
				var_18++;
				continue;
			}

			if(var_19 && var_1A)
			{
				if(var_16 % 2 == 1)
				{
					var_17++;
					continue;
				}

				var_18++;
			}

			var_16--;
		}

		var_1B = func_3B22(var_0A,"bots_" + var_08);
		var_1C = func_3B22(var_0A,"bots_" + var_09);
		var_1D = var_1B + var_1C;
		if(var_1D > 0)
		{
			level.var_2D36 = 1;
		}

		var_1E = 0;
		if(!level.var_2D35)
		{
			var_1E = !func_2DAE();
			if(!var_1E)
			{
				level.var_2D35 = 1;
			}
		}

		if(var_1E)
		{
			var_1F = !getdvarint("systemlink") && !getdvarint("onlinegame");
			var_20 = !var_03 && var_05 != var_04 && !level.var_2D36 && level.var_2D37 < 10 || !scripts\mp\_utility::func_766C("prematch_done");
			if(var_1F || var_20)
			{
				level.var_2D37 = level.var_2D37 + var_02;
				scripts\mp\_hostmigration::func_13708(var_02);
				continue;
			}
		}

		var_21 = int(min(var_11 - var_13 - var_17,var_04));
		var_22 = int(min(var_12 - var_14 - var_18,var_05));
		var_23 = 1;
		var_24 = var_21 + var_22 + var_0B;
		var_25 = var_04 + var_05 + var_0B;
		var_26 = [-1,-1];
		while(var_24 < scripts\mp\bots\_bots_util::func_2DA6() && var_24 < var_25)
		{
			if(var_23 && var_21 < var_04 && func_2D22(var_08))
			{
				var_21++;
			}
			else if(!var_23 && var_22 < var_05 && func_2D22(var_09))
			{
				var_22++;
			}

			var_24 = var_21 + var_22 + var_0B;
			if(var_26[var_23] == var_24)
			{
				break;
			}

			var_26[var_23] = var_24;
			var_23 = !var_23;
		}

		if(var_04 == var_05 && !var_03 && var_17 == 1 && var_18 == 0 && var_22 > 0)
		{
			if(!isdefined(level.var_2E56) && scripts\mp\_utility::func_766C("prematch_done"))
			{
				level.var_2E56 = gettime();
			}

			if(var_1E && !isdefined(level.var_2E56) || gettime() - level.var_2E56 < 10000)
			{
				var_22--;
			}
		}

		var_27 = var_21 - var_1B;
		var_28 = var_22 - var_1C;
		var_29 = 1;
		if(var_03)
		{
			var_2A = var_11 + var_12;
			var_2B = var_04 + var_05;
			var_2C = var_13 + var_14;
			var_2D = var_1B + var_1C;
			var_2E = int(min(var_2A - var_2C,var_2B));
			var_2F = var_2E - var_2D;
			if(var_2F == 0)
			{
				var_29 = 0;
			}
			else if(var_2F > 0)
			{
				var_27 = int(var_2F / 2) + var_2F % 2;
				var_28 = int(var_2F / 2);
			}
			else if(var_2F < 0)
			{
				var_30 = var_2F * -1;
				var_27 = -1 * int(min(var_30,var_1B));
				var_28 = -1 * var_30 + var_27;
			}
		}
		else if(!scripts\mp\_utility::func_B3EC() && var_27 * var_28 < 0 && scripts\mp\_utility::func_766C("prematch_done") && !isdefined(level.var_2EEE))
		{
			var_31 = int(min(abs(var_27),abs(var_28)));
			if(var_27 > 0)
			{
				func_BC13(var_31,var_09,var_08,var_06);
			}
			else if(var_28 > 0)
			{
				func_BC13(var_31,var_08,var_09,var_07);
			}

			var_29 = 0;
		}

		if(var_29)
		{
			if(var_28 < 0)
			{
				func_5CE4(var_28 * -1,var_09);
			}

			if(var_27 < 0)
			{
				func_5CE4(var_27 * -1,var_08);
			}

			if(var_28 > 0)
			{
				level thread func_10656(var_28,var_09,undefined,undefined,"spawned_enemies",var_07);
			}

			if(var_27 > 0)
			{
				level thread func_10656(var_27,var_08,undefined,undefined,"spawned_allies",var_06);
			}

			if(var_28 > 0 && var_27 > 0)
			{
				level scripts\common\utility::func_137AC("spawned_enemies","spawned_allies");
			}
			else if(var_28 > 0)
			{
				level waittill("spawned_enemies");
			}
			else if(var_27 > 0)
			{
				level waittill("spawned_allies");
			}
		}

		if(var_07 != var_06)
		{
			func_2EF9(var_09,var_07);
			func_2EF9(var_08,var_06);
		}

		scripts\mp\_hostmigration::func_13708(var_02);
	}
}

//Function Number: 19
func_2DB2()
{
	if(isdefined(self.team))
	{
		return self.team;
	}

	if(isdefined(self.pers["team"]))
	{
		return self.pers["team"];
	}

	return undefined;
}

//Function Number: 20
func_2DAD()
{
	foreach(var_01 in level.players)
	{
		if(!isai(var_01) && var_01 ishost())
		{
			return var_01 func_2DB2();
		}
	}

	return "spectator";
}

//Function Number: 21
func_2DAE()
{
	var_00 = 0;
	var_01 = 0;
	var_02 = 0;
	foreach(var_04 in level.players)
	{
		if(!isai(var_04))
		{
			if(var_04 ishost())
			{
				var_00 = 1;
			}

			if(func_D229(var_04))
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

//Function Number: 22
func_D229(param_00)
{
	if(isdefined(param_00.team) && param_00.team != "spectator")
	{
		return 1;
	}

	if(isdefined(param_00.var_1097B) && param_00.var_1097B)
	{
		return 1;
	}

	if(param_00 ismlgspectator() && isdefined(param_00.team) && param_00.team == "spectator")
	{
		return 1;
	}

	return 0;
}

//Function Number: 23
func_2D34()
{
	var_00 = [];
	for(var_01 = 0;var_01 < level.players.size;var_01++)
	{
		var_02 = level.players[var_01];
		if(isdefined(var_02) && isdefined(var_02.team))
		{
			var_00 = func_3B21(var_00,"all");
			var_00 = func_3B21(var_00,var_02.team);
			if(isbot(var_02))
			{
				var_00 = func_3B21(var_00,"bots");
				var_00 = func_3B21(var_00,"bots_" + var_02.team);
				continue;
			}

			var_00 = func_3B21(var_00,"humans");
			var_00 = func_3B21(var_00,"humans_" + var_02.team);
		}
	}

	return var_00;
}

//Function Number: 24
func_3B21(param_00,param_01)
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

//Function Number: 25
func_3B22(param_00,param_01)
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

//Function Number: 26
func_BC13(param_00,param_01,param_02,param_03)
{
	foreach(var_05 in level.players)
	{
		if(!isdefined(var_05.team))
		{
			continue;
		}

		if(isdefined(var_05.var_452B) && var_05.var_452B && isbot(var_05) && var_05.team == param_01)
		{
			var_05.var_2EAC = param_02;
			if(isdefined(param_03))
			{
				var_05 scripts\mp\bots\_bots_util::func_2E81(param_03);
			}

			var_05 notify("luinotifyserver","team_select",func_2E15(param_02));
			wait(0.05);
			var_05 notify("luinotifyserver","class_select",var_05.var_2D33);
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

//Function Number: 27
func_2EF9(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(!isdefined(var_03.team))
		{
			continue;
		}

		if(isdefined(var_03.var_452B) && var_03.var_452B && isbot(var_03) && var_03.team == param_00)
		{
			if(param_01 != var_03 botgetdifficulty())
			{
				var_03 scripts\mp\bots\_bots_util::func_2E81(param_01);
			}
		}
	}
}

//Function Number: 28
func_2D68()
{
	kick(self.var_6640,"EXE_PLAYERKICKED_BOT_BALANCE");
	wait(0.1);
}

//Function Number: 29
func_5CE4(param_00,param_01)
{
	var_02 = [];
	foreach(var_04 in level.players)
	{
		if(isdefined(var_04.var_452B) && var_04.var_452B && isbot(var_04) && !isdefined(param_01) || isdefined(var_04.team) && var_04.team == param_01)
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

		if(!scripts\mp\_utility::func_9F19(var_02[var_06]))
		{
			var_02[var_06] func_2D68();
			var_02 = scripts\common\utility::func_22A9(var_02,var_02[var_06]);
			param_00--;
		}
	}

	for(var_06 = var_02.size - 1;var_06 >= 0;var_06--)
	{
		if(param_00 <= 0)
		{
			break;
		}

		var_02[var_06] func_2D68();
		param_00--;
	}
}

//Function Number: 30
func_2E15(param_00)
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

//Function Number: 31
func_10655(param_00,param_01,param_02)
{
	var_03 = gettime() + -5536;
	while(!self method_8062())
	{
		if(gettime() >= var_03)
		{
			kick(self.var_6640,"EXE_PLAYERKICKED_BOT_BALANCE");
			param_02.var_151D = 1;
			return;
		}

		wait(0.05);
		if(!isdefined(self))
		{
			param_02.var_151D = 1;
			return;
		}
	}

	scripts\mp\_hostmigration::func_13708(randomfloatrange(0.25,2));
	if(!isdefined(self))
	{
		param_02.var_151D = 1;
		return;
	}

	self method_8390();
	self.pers["isBot"] = 1;
	self.var_6695 = 1;
	self.var_2EAC = param_00;
	if(isdefined(param_02.var_54CF))
	{
		scripts\mp\bots\_bots_util::func_2E81(param_02.var_54CF);
	}

	if(isdefined(param_01))
	{
		self [[ param_01 ]]();
	}

	self thread [[ level.var_2D9E["think"] ]]();
	param_02.var_DD6B = 1;
}

//Function Number: 32
func_6CA1(param_00,param_01)
{
	var_02 = 0;
	var_03 = 0;
	for(var_04 = 0;var_04 < 10;var_04++)
	{
		var_03 = 0;
		var_05 = param_00 getplayerdata("mp","squadHQ","aiSquadMembers",var_04);
		if(var_05 == var_02)
		{
			var_04++;
			continue;
		}

		if(!isdefined(level.var_91D3) || !isdefined(level.var_91D3[var_05]) || level.var_91D3[var_05] == 0)
		{
			return var_05;
		}
	}

	return -1;
}

//Function Number: 33
func_10656(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = gettime() + 10000;
	var_07 = [];
	var_08 = var_07.size;
	while(level.players.size < scripts\mp\bots\_bots_util::func_2DA6() && var_07.size < param_00 && gettime() < var_06)
	{
		scripts\mp\_hostmigration::func_13708(0.05);
		var_09 = undefined;
		if(function_0280())
		{
			if(level.teambased)
			{
				var_09 = function_0281(param_01);
			}
			else
			{
				var_09 = function_0281("none");
			}
		}
		else
		{
			var_09 = function_0005("",0,0,0);
		}

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

			scripts\mp\_hostmigration::func_13708(1);
			continue;
		}
		else
		{
			var_0A = spawnstruct();
			var_0A.var_2CFF = var_09;
			var_0A.var_DD6B = 0;
			var_0A.var_151D = 0;
			var_0A.index = var_08;
			var_0A.var_54CF = param_05;
			var_07[var_07.size] = var_0A;
			var_0A.var_2CFF thread func_10655(param_01,param_02,var_0A);
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
			if(var_0A.var_DD6B || var_0A.var_151D)
			{
				var_0B++;
			}
		}

		wait(0.05);
	}

	if(isdefined(param_04))
	{
		self notify(param_04);
	}
}

//Function Number: 34
func_2DA0()
{
	if(!level.teambased)
	{
		return 1;
	}

	if(isdefined(level.var_2EF3) && level.var_2EF3)
	{
		return 1;
	}

	return 0;
}

//Function Number: 35
func_2D9F()
{
	return isdefined(level.var_2EF2) && level.var_2EF2;
}

//Function Number: 36
func_2DDF()
{
	if(!isdefined(self.var_4009))
	{
		return 0;
	}

	return 1;
}

//Function Number: 37
func_2EAE()
{
	self notify("bot_think");
	self endon("bot_think");
	self endon("disconnect");
	while(!isdefined(self.pers["team"]))
	{
		wait(0.05);
	}

	level.var_8BD8 = 1;
	if(func_2DA0())
	{
		self.var_2EAC = self.pers["team"];
	}

	var_00 = self.var_2EAC;
	if(!isdefined(var_00))
	{
		var_00 = self.pers["team"];
	}

	scripts\mp\bots\_bots_killstreaks::func_2DF3();
	self.var_6640 = self getentitynumber();
	var_01 = 0;
	if(!isdefined(self.var_2E99))
	{
		var_01 = 1;
		self.var_2E99 = 1;
		if(!func_2DA0())
		{
			self notify("luinotifyserver","team_select",func_2E15(var_00));
			wait(0.5);
			if(self.pers["team"] == "spectator")
			{
				func_2D68();
				return;
			}
		}
	}

	for(;;)
	{
		scripts\mp\bots\_bots_util::func_2E81(self botgetdifficulty());
		var_02 = self botgetdifficultysetting("advancedPersonality");
		if(var_01 && isdefined(var_02) && var_02 != 0)
		{
			scripts\mp\bots\_bots_personality::func_2D10();
		}

		scripts\mp\bots\_bots_personality::func_2D0C();
		if(var_01)
		{
			func_2E82();
			if(!func_2D9F())
			{
				self notify("luinotifyserver","class_select",self.var_2D33);
			}

			if(self.health == 0)
			{
				self.var_331E = 1;
				self notify("bot_ready_to_spawn");
				self waittill("spawned_player");
				self.var_331E = undefined;
				self.var_2EAC = var_00;
			}

			if(isdefined(level.var_2D9E) && isdefined(level.var_2D9E["know_enemies_on_start"]))
			{
				self thread [[ level.var_2D9E["know_enemies_on_start"] ]]();
			}

			var_01 = 0;
		}

		func_2E67();
		wait(0.1);
		self waittill("death");
		func_E292();
		self waittill("spawned_player");
	}
}

//Function Number: 38
func_E292()
{
	self endon("started_spawnPlayer");
	while(!self.var_136FF)
	{
		wait(0.05);
	}

	if(scripts\mp\_playerlogic::func_BE8F())
	{
		while(self.var_136FF)
		{
			if(self.sessionstate == "spectator")
			{
				if(getdvarint("numlives") == 0 || self.pers["lives"] > 0)
				{
					self botpressbutton("use",0.5);
				}
			}

			wait(1);
		}
	}
}

//Function Number: 39
func_2DB3()
{
	if(scripts\mp\_utility::func_2DE2() == 0)
	{
		if(!isdefined(self.pers["rankxp"]))
		{
			self.pers["rankxp"] = 0;
		}

		return self.pers["rankxp"];
	}

	var_00 = self botgetdifficulty();
	var_01 = "bot_rank_" + var_00;
	if(isdefined(self.pers[var_01]) && self.pers[var_01] > 0)
	{
		return self.pers[var_01];
	}

	var_02 = func_2E5F(var_00);
	var_03 = var_02["rank"];
	var_04 = var_02["prestige"];
	var_05 = scripts\mp\_rank::func_80CF(var_03);
	var_06 = var_05 + scripts\mp\_rank::func_80D1(var_03);
	var_07 = randomintrange(var_05,var_06 + 1);
	self.pers[var_01] = var_07;
	return var_07;
}

//Function Number: 40
func_2D00(param_00)
{
	thread func_2D01(param_00);
}

//Function Number: 41
func_2D01(param_00)
{
	param_00 endon("disconnect");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		if(isalive(self) && !self botcanseeentity(param_00) && scripts\common\utility::func_13D90(self.origin,self.angles,param_00.origin,self botgetfovdot()))
		{
			self botgetimperfectenemyinfo(param_00,param_00.origin);
		}

		wait(0.1);
	}
}

//Function Number: 42
func_2E5F(param_00)
{
	var_01 = [];
	var_01["rank"] = 0;
	var_01["prestige"] = 0;
	if(param_00 == "default")
	{
		return var_01;
	}

	if(!isdefined(level.var_2E69))
	{
		level.var_2E69 = [];
		level.var_2E69["recruit"][0] = 0;
		level.var_2E69["recruit"][1] = 5;
		level.var_2E69["regular"][0] = 6;
		level.var_2E69["regular"][1] = 9;
		level.var_2E69["hardened"][0] = 10;
		level.var_2E69["hardened"][1] = 19;
		level.var_2E69["veteran"][0] = 20;
		level.var_2E69["veteran"][1] = 29;
	}

	if(!isdefined(level.var_2E68))
	{
		level.var_2E68 = [];
		level.var_2E68["recruit"][0] = 0;
		level.var_2E68["recruit"][1] = 0;
		level.var_2E68["regular"][0] = 0;
		level.var_2E68["regular"][1] = 0;
		level.var_2E68["hardened"][0] = 0;
		level.var_2E68["hardened"][1] = 0;
		level.var_2E68["veteran"][0] = 0;
		level.var_2E68["veteran"][1] = 9;
	}

	if(isdefined(level.var_2E69[param_00][0]) && isdefined(level.var_2E69[param_00][1]))
	{
		var_01["rank"] = randomintrange(level.var_2E69[param_00][0],level.var_2E69[param_00][1] + 1);
	}

	if(isdefined(level.var_2E68[param_00][0]) && isdefined(level.var_2E68[param_00][1]))
	{
		var_01["prestige"] = randomintrange(level.var_2E68[param_00][0],level.var_2E68[param_00][1] + 1);
	}

	return var_01;
}

//Function Number: 43
func_4831(param_00)
{
	if(isagent(self) && !isdefined(param_00.var_2F33))
	{
		return 0;
	}

	if(isdefined(param_00.var_485F) && !scripts\mp\bots\_bots_killstreaks::func_2DDB(param_00.var_485F))
	{
		return 0;
	}

	return 1;
}

//Function Number: 44
func_7A21()
{
	var_00 = undefined;
	var_01 = getentarray("player","classname");
	if(isdefined(var_01))
	{
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			if(isdefined(var_01[var_02]) && isdefined(var_01[var_02].var_452B) && var_01[var_02].var_452B && !isai(var_01[var_02]) && !isdefined(var_00) || var_00.team == "spectator")
			{
				var_00 = var_01[var_02];
			}
		}
	}

	return var_00;
}

//Function Number: 45
func_2D47(param_00,param_01,param_02,param_03,param_04,param_05)
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
		if(isdefined(self.var_7197))
		{
			self [[ self.var_7197 ]](param_00,param_01,param_02,param_03,param_04,param_05);
		}

		if(level.teambased)
		{
			if(isdefined(param_04.team) && param_04.team == self.team)
			{
				return;
			}
			else if(isdefined(param_00) && isdefined(param_00.team) && param_00.team == self.team)
			{
				return;
			}
		}

		var_06 = scripts\mp\bots\_bots_util::func_2DAF(param_00,param_04);
		if(isdefined(var_06))
		{
			self method_804A(var_06);
		}
	}
}

//Function Number: 46
func_C4AC(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	self method_8027();
	self botclearscriptgoal();
	var_0A = scripts\mp\bots\_bots_util::func_2DAF(param_01,param_00);
	if(!scripts\mp\_utility::func_2DD9() && isdefined(var_0A) && var_0A.classname == "script_vehicle" && isdefined(var_0A.var_8DD9))
	{
		var_0B = self botgetdifficultysetting("launcherRespawnChance");
		if(randomfloat(1) < var_0B)
		{
			self.var_E293 = 1;
		}
	}
}

//Function Number: 47
func_2E8E()
{
	if(scripts\mp\_utility::func_2DD9())
	{
		return 0;
	}

	var_00 = 0;
	var_01 = self botgetdifficulty();
	if(var_01 == "recruit")
	{
		var_00 = 0.1;
	}
	else if(var_01 == "regular")
	{
		var_00 = 0.4;
	}
	else if(var_01 == "hardened")
	{
		var_00 = 0.7;
	}
	else if(var_01 == "veteran")
	{
		var_00 = 1;
	}

	return randomfloat(1) < 1 - var_00;
}

//Function Number: 48
func_2E90()
{
	if(scripts\mp\_utility::func_9E59())
	{
		return 0;
	}

	return 1;
}

//Function Number: 49
func_2E67()
{
	thread func_2EBA();
	thread scripts\mp\bots\_bots_strategy::func_2EB8();
	self thread [[ level.var_2D9E["dropped_weapon_think"] ]]();
	thread func_2EB3();
	thread func_2EAF();
	thread scripts\mp\bots\_bots_supers::func_2EB7();
	thread scripts\mp\bots\_bots_powers::func_2EB4();
	thread func_2EB0();
	thread scripts\mp\bots\_bots_killstreaks::func_2EB2();
	thread scripts\mp\bots\_bots_killstreaks::func_2EB9();
	thread func_2EB1();
}

//Function Number: 50
func_2EBA(param_00)
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
	self.last_enemy_sight_time = gettime();
	for(;;)
	{
		if(isdefined(self.var_10C))
		{
			if(self botcanseeentity(self.var_10C))
			{
				self.last_enemy_sight_time = gettime();
			}
		}

		wait(0.05);
	}
}

//Function Number: 51
func_2EB6()
{
	self notify("bot_think_seek_dropped_weapons");
	self endon("bot_think_seek_dropped_weapons");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_00 = "throwingknife_mp";
	for(;;)
	{
		var_01 = 0;
		if(scripts\mp\bots\_bots_util::func_2E3B() && self [[ level.var_2D9E["should_pickup_weapons"] ]]() && !scripts\mp\bots\_bots_util::func_2DE0())
		{
			var_02 = getentarray("dropped_weapon","targetname");
			var_03 = scripts\common\utility::func_782F(self.origin,var_02);
			if(var_03.size > 0)
			{
				var_04 = var_03[0];
				func_2E6F(var_04);
			}
		}

		if(!scripts\mp\bots\_bots_util::func_2DCA() && !scripts\mp\bots\_bots_util::func_2DE0() && self botgetdifficultysetting("strategyLevel") > 0)
		{
			var_05 = self hasweapon(var_00);
			var_06 = var_05 && self method_80FB(var_00) == 0;
			if(var_06)
			{
				if(isdefined(self.var_8444))
				{
					wait(5);
					continue;
				}

				var_07 = getentarray("dropped_knife","targetname");
				var_08 = scripts\common\utility::func_782F(self.origin,var_07);
				foreach(var_0A in var_08)
				{
					if(!isdefined(var_0A))
					{
						continue;
					}

					if(!isdefined(var_0A.var_370D))
					{
						var_0B = scripts\mp\bots\_bots_util::func_2E58("BotGetClosestNavigablePoint",::scripts\mp\bots\_bots_util::func_74C3,var_0A.origin,32,self);
						if(isdefined(var_0A))
						{
							var_0A.var_429A = var_0B;
							var_0A.var_370D = 1;
						}
						else
						{
							continue;
						}
					}

					if(isdefined(var_0A.var_429A))
					{
						self.var_8444 = 1;
						func_2E6F(var_0A);
					}
				}
			}
			else if(var_05)
			{
				self.var_8444 = undefined;
			}
		}

		wait(randomfloatrange(0.25,0.75));
	}
}

//Function Number: 52
func_2E6F(param_00)
{
	if(scripts\mp\bots\_bots_strategy::func_2DC5("seek_dropped_weapon",param_00) == 0)
	{
		var_01 = undefined;
		if(param_00.var_336 == "dropped_weapon")
		{
			var_02 = 1;
			var_03 = self getweaponslistprimaries();
			foreach(var_05 in var_03)
			{
				if(param_00.model == function_00EA(var_05))
				{
					var_02 = 0;
				}
			}

			if(var_02)
			{
				var_01 = ::func_2E4C;
			}
		}

		var_07 = spawnstruct();
		var_07.var_C270 = param_00;
		var_07.var_EDC9 = 12;
		var_07.var_FF0D = level.var_2D9E["dropped_weapon_cancel"];
		var_07.var_157C = var_01;
		scripts\mp\bots\_bots_strategy::func_2E27("seek_dropped_weapon",param_00.origin,100,var_07);
	}
}

//Function Number: 53
func_2E4C(param_00)
{
	self botpressbutton("use",2);
	wait(2);
}

//Function Number: 54
func_FFA0(param_00)
{
	if(!isdefined(param_00.var_C270))
	{
		return 1;
	}

	if(param_00.var_C270.var_336 == "dropped_weapon")
	{
		if(scripts\mp\bots\_bots_util::func_2DB8() > 0)
		{
			return 1;
		}
	}
	else if(param_00.var_C270.var_336 == "dropped_knife")
	{
		if(scripts\mp\bots\_bots_util::func_2DCA())
		{
			self.var_8444 = undefined;
			return 1;
		}
	}

	return 0;
}

//Function Number: 55
func_2EB3(param_00)
{
	self notify("bot_think_level_actions");
	self endon("bot_think_level_actions");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		scripts\common\utility::waittill_notify_or_timeout("calculate_new_level_targets",randomfloatrange(2,10));
		if(!isdefined(level.var_ABE5) || level.var_ABE5.size == 0)
		{
			continue;
		}

		if(scripts\mp\bots\_bots_strategy::func_2DC5("map_interactive_object"))
		{
			continue;
		}

		if(scripts\mp\bots\_bots_util::func_2DCA() || scripts\mp\bots\_bots_util::func_2DE0())
		{
			continue;
		}

		var_01 = undefined;
		foreach(var_03 in level.var_ABE5)
		{
			if(scripts\common\utility::func_2286(var_03.var_8EE3,self))
			{
				var_01 = var_03;
				break;
			}
		}

		if(!isdefined(var_01))
		{
			if(randomint(100) > 25)
			{
				continue;
			}

			var_05 = scripts\common\utility::func_782F(self.origin,level.var_ABE5);
			var_06 = 256;
			if(isdefined(param_00))
			{
				var_06 = param_00;
			}
			else if(self botgetscriptgoaltype() == "hunt" && self botpursuingscriptgoal())
			{
				var_06 = 512;
			}

			if(distancesquared(self.origin,var_05[0].origin) > var_06 * var_06)
			{
				continue;
			}

			var_01 = var_05[0];
		}

		var_07 = 0;
		if(var_01.var_2DD1 == "damage")
		{
			var_07 = func_2E8F(var_01);
			if(var_07)
			{
				var_08 = var_01.origin[2] - var_01.var_2EAA[0].origin[2] + 55;
				var_09 = var_01.origin[2] - var_01.var_2EAA[1].origin[2] + 55;
				if(var_08 > 55 && var_09 > 55)
				{
					if(scripts\common\utility::func_2286(var_01.var_8EE3,self))
					{
						var_01.var_8EE3 = scripts\common\utility::func_22A9(var_01.var_8EE3,self);
					}

					continue;
				}
			}

			var_0A = weaponclass(self getcurrentweapon());
			if(var_0A == "spread")
			{
				var_0B = var_01.var_2EAA[0].origin - var_01.origin;
				var_0C = var_01.var_2EAA[1].origin - var_01.origin;
				var_0D = lengthsquared(var_0B);
				var_0E = lengthsquared(var_0C);
				if(var_0D > 22500 && var_0E > 22500)
				{
					if(scripts\common\utility::func_2286(var_01.var_8EE3,self))
					{
						var_01.var_8EE3 = scripts\common\utility::func_22A9(var_01.var_8EE3,self);
					}

					continue;
				}
			}
		}

		var_0F = spawnstruct();
		var_0F.var_C270 = var_01;
		if(var_01.var_2DD1 == "damage")
		{
			if(var_07)
			{
				var_0F.var_FF0D = ::func_ABEC;
			}
			else
			{
				var_0F.var_FF0D = ::func_ABED;
			}
		}

		if(var_01.var_2DD1 == "use")
		{
			var_0F.var_157C = ::func_13036;
			var_0F.var_FF0D = ::func_ABEB;
			var_0F.var_EDCC = vectortoangles(var_01.origin - var_01.var_2EA8.origin)[1];
			scripts\mp\bots\_bots_strategy::func_2E27("map_interactive_object",var_01.var_2EA8.origin,10,var_0F);
			continue;
		}

		if(var_01.var_2DD1 == "damage")
		{
			if(var_07)
			{
				var_0F.var_157C = ::func_B57B;
				var_0F.var_EDC9 = 20;
			}
			else
			{
				var_0F.var_157C = ::func_24B3;
				var_0F.var_EDC9 = 50;
			}

			var_10 = undefined;
			var_11 = scripts\mp\bots\_bots_util::func_2E58("GetPathDistLevelAction",::scripts\mp\bots\_bots_util::func_74C9,self.origin,var_01.var_2EAA[0].origin);
			var_12 = scripts\mp\bots\_bots_util::func_2E58("GetPathDistLevelAction",::scripts\mp\bots\_bots_util::func_74C9,self.origin,var_01.var_2EAA[1].origin);
			if(!isdefined(var_01))
			{
				continue;
			}

			if(var_11 <= 0 && var_12 <= 0)
			{
				continue;
			}

			if(var_11 > 0)
			{
				if(var_12 < 0 || var_11 <= var_12)
				{
					var_10 = var_01.var_2EAA[0];
				}
			}

			if(var_12 > 0)
			{
				if(var_11 < 0 || var_12 <= var_11)
				{
					var_10 = var_01.var_2EAA[1];
				}
			}

			if(!var_07)
			{
				childthread func_B981(var_10);
			}

			scripts\mp\bots\_bots_strategy::func_2E27("map_interactive_object",var_10.origin,10,var_0F);
		}
	}
}

//Function Number: 56
func_2E8F(param_00)
{
	var_01 = self getcurrentweapon();
	var_02 = scripts\mp\bots\_bots_util::func_2E3B() || self.var_8C1F || isdefined(self.var_9E5D) && self.var_9E5D == 1 || weaponclass(var_01) == "grenade" || scripts\mp\_weapons::func_9E6D(var_01);
	return var_02;
}

//Function Number: 57
func_B981(param_00)
{
	self endon("goal");
	wait(0.1);
	for(;;)
	{
		if(weaponclass(self getcurrentweapon()) == "spread")
		{
			if(distancesquared(self.origin,param_00.origin) > 90000)
			{
				wait(0.05);
				continue;
			}
		}

		var_01 = self getnearestnode();
		if(isdefined(var_01))
		{
			if(nodesvisible(var_01,param_00))
			{
				if(sighttracepassed(self.origin + (0,0,55),param_00.origin + (0,0,55),0,self))
				{
					self notify("goal");
				}
			}
		}

		wait(0.05);
	}
}

//Function Number: 58
func_24B3(param_00)
{
	if(param_00.var_C270.origin[2] - self geteye()[2] > 55)
	{
		if(distance2dsquared(param_00.var_C270.origin,self.origin) < 225)
		{
			return;
		}
	}

	self botsetflag("disable_movement",1);
	func_AFF0(param_00.var_C270,0.3);
	self botpressbutton("ads",0.3);
	wait(0.25);
	var_01 = gettime();
	while(isdefined(param_00.var_C270) && !isdefined(param_00.var_C270.var_1D3F) && gettime() - var_01 < 5000)
	{
		func_AFF0(param_00.var_C270,0.15);
		self botpressbutton("ads",0.15);
		self botpressbutton("attack");
		wait(0.1);
	}

	self botsetflag("disable_movement",0);
}

//Function Number: 59
func_B57B(param_00)
{
	self botsetflag("disable_movement",1);
	func_AFF0(param_00.var_C270,0.3);
	wait(0.25);
	var_01 = gettime();
	while(isdefined(param_00.var_C270) && !isdefined(param_00.var_C270.var_1D3F) && gettime() - var_01 < 5000)
	{
		func_AFF0(param_00.var_C270,0.15);
		self botpressbutton("melee");
		wait(0.1);
	}

	self botsetflag("disable_movement",0);
}

//Function Number: 60
func_AFF0(param_00,param_01)
{
	var_02 = param_00.origin;
	if(distance2dsquared(self.origin,var_02) < 100)
	{
		var_02 = (var_02[0],var_02[1],self geteye()[2]);
	}

	self botlookatpoint(var_02,param_01,"script_forced");
}

//Function Number: 61
func_13036(param_00)
{
	if(isagent(self))
	{
		scripts\common\utility::func_1C6E(1);
		param_00.var_C270 enableplayeruse(self);
		wait(0.05);
	}

	var_01 = param_00.var_C270.var_13031;
	self botpressbutton("use",var_01);
	wait(var_01);
	if(isagent(self))
	{
		scripts\common\utility::func_1C6E(0);
		if(isdefined(param_00.var_C270))
		{
			param_00.var_C270 disableplayeruse(self);
		}
	}
}

//Function Number: 62
func_ABEC(param_00)
{
	if(func_ABEB(param_00))
	{
		return 1;
	}

	if(!func_2E8F(param_00.var_C270))
	{
		return 1;
	}

	return 0;
}

//Function Number: 63
func_ABED(param_00)
{
	if(func_ABEB(param_00))
	{
		return 1;
	}

	if(func_2E8F(param_00.var_C270))
	{
		return 1;
	}

	return 0;
}

//Function Number: 64
func_ABEB(param_00)
{
	if(!isdefined(param_00.var_C270))
	{
		return 1;
	}

	if(isdefined(param_00.var_C270.var_1D3F))
	{
		return 1;
	}

	if(scripts\mp\bots\_bots_util::func_2DCA())
	{
		return 1;
	}

	return 0;
}

//Function Number: 65
func_483B(param_00)
{
	if(!isdefined(param_00.var_222) || param_00.var_222 != self)
	{
		if(distancesquared(self.origin,param_00.origin) > 4194304)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 66
func_2D45(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = self [[ level.var_2D9E["crate_can_use"] ]](param_00);
	if(!var_01)
	{
		if(level.gametype == "grnd")
		{
			var_01 = 1;
		}
	}

	if(!var_01)
	{
		return 0;
	}

	if(!func_483D(param_00))
	{
		return 0;
	}

	if(level.teambased && isdefined(param_00.var_2C43) && isdefined(param_00.team) && param_00.team == self.team)
	{
		return 0;
	}

	if(!self [[ level.var_2D9E["crate_in_range"] ]](param_00))
	{
		return 0;
	}

	if(isdefined(param_00.var_2F33))
	{
		if(isdefined(level.var_2F30[param_00.var_2F33]) && ![[ level.var_2F30[param_00.var_2F33].var_3936 ]]())
		{
			return 0;
		}

		if(isdefined(param_00.var_55BC) && isdefined(param_00.var_55BC[self getentitynumber()]) && param_00.var_55BC[self getentitynumber()])
		{
			return 0;
		}

		if(!self [[ level.var_2D27[param_00.var_2F33] ]](param_00))
		{
			return 0;
		}
	}

	return isdefined(param_00);
}

//Function Number: 67
func_483D(param_00)
{
	if(!func_483A(param_00))
	{
		return 0;
	}

	if(!func_483C(param_00))
	{
		return 0;
	}

	return isdefined(param_00);
}

//Function Number: 68
func_483A(param_00)
{
	if(isdefined(param_00.var_2F33))
	{
		return gettime() > param_00.var_64 + 1000;
	}

	return isdefined(param_00.var_5D44) && !param_00.var_5D44;
}

//Function Number: 69
func_483C(param_00)
{
	if(!isdefined(param_00.on_path_grid))
	{
		func_482F(param_00);
	}

	return isdefined(param_00) && param_00.on_path_grid;
}

//Function Number: 70
func_C042(param_00,param_01)
{
	if(isdefined(param_01.var_2F33) && param_01.var_2F33 == "scavenger_bag")
	{
		return abs(param_00.origin[0] - param_01.origin[0]) < 36 && abs(param_00.origin[0] - param_01.origin[0]) < 36 && abs(param_00.origin[0] - param_01.origin[0]) < 18;
	}

	var_02 = getdvarfloat("player_useRadius");
	var_03 = distancesquared(param_01.origin,param_00.origin + (0,0,40));
	return var_03 <= var_02 * var_02;
}

//Function Number: 71
func_482F(param_00)
{
	param_00 thread func_483F();
	param_00.on_path_grid = 0;
	var_01 = undefined;
	var_02 = undefined;
	if(isdefined(param_00.var_72B6))
	{
		var_01 = param_00.var_72B6;
		var_02 = gettime() + 30000;
		param_00.var_72B6 = var_02;
		param_00 notify("path_disconnect");
	}

	wait(0.05);
	if(!isdefined(param_00))
	{
		return;
	}

	var_03 = func_4839(param_00);
	if(!isdefined(param_00))
	{
		return;
	}

	if(isdefined(var_03) && var_03.size > 0)
	{
		param_00.var_BE7E = var_03;
		param_00.on_path_grid = 1;
	}
	else
	{
		var_04 = getdvarfloat("player_useRadius");
		var_05 = getnodesinradiussorted(param_00.origin,var_04 * 2,0)[0];
		var_06 = param_00 method_8159(0,0,-1);
		var_07 = undefined;
		if(isdefined(param_00.var_2F33) && param_00.var_2F33 == "scavenger_bag")
		{
			if(scripts\mp\bots\_bots_util::func_2E4E(param_00.origin))
			{
				var_07 = param_00.origin;
			}
		}
		else
		{
			var_07 = function_0022(param_00.origin,var_04);
		}

		if(isdefined(var_05) && !var_05 method_821B() && isdefined(var_07) && abs(var_05.origin[2] - var_06[2]) < 30)
		{
			param_00.var_BE80 = [var_07];
			param_00.var_BE7E = [var_05];
			param_00.on_path_grid = 1;
		}
	}

	if(isdefined(param_00.var_72B6))
	{
		if(param_00.var_72B6 == var_02)
		{
			param_00.var_72B6 = var_01;
		}
	}
}

//Function Number: 72
func_4839(param_00)
{
	var_01 = getnodesinradiussorted(param_00.origin,256,0);
	for(var_02 = var_01.size;var_02 > 0;var_02--)
	{
		var_01[var_02] = var_01[var_02 - 1];
	}

	var_01[0] = getclosestnodeinsight(param_00.origin);
	var_03 = undefined;
	if(isdefined(param_00.var_72B6))
	{
		var_03 = function_0076();
	}

	var_04 = [];
	var_05 = 1;
	if(!isdefined(param_00.var_2F33))
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

		if(var_06 method_821B())
		{
			continue;
		}

		if(!func_C042(var_06,param_00))
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

		wait(0.05);
		if(!isdefined(param_00))
		{
			break;
		}

		if(sighttracepassed(param_00.origin,var_06.origin + (0,0,55),0,param_00))
		{
			wait(0.05);
			if(!isdefined(param_00))
			{
				break;
			}

			if(!isdefined(param_00.var_72B6))
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
				var_09 = scripts\common\utility::random(var_03);
				if(distancesquared(var_06.origin,var_09.origin) > 250000)
				{
					var_07 = var_09;
				}
			}

			if(isdefined(var_07))
			{
				var_0A = scripts\mp\bots\_bots_util::func_2E58("GetNodesOnPathCrate",::scripts\mp\bots\_bots_util::func_74C8,var_06.origin,var_07.origin);
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

//Function Number: 73
func_4837(param_00)
{
	if(isdefined(param_00.var_BE80))
	{
		return param_00.var_BE80[0];
	}

	if(isdefined(param_00.var_BE7E))
	{
		if(param_00.var_BE7E.size > 1)
		{
			var_01 = scripts\common\utility::func_22BD(self method_8045(param_00.var_BE7E,"node_exposed"));
			return scripts\common\utility::func_DCA4(var_01).origin;
		}
		else
		{
			return var_01.var_BE7E[0].origin;
		}
	}
}

//Function Number: 74
func_4838(param_00,param_01)
{
	var_02 = func_4837(param_00);
	var_02 = getclosestpointonnavmesh(var_02,self);
	var_03 = param_01 * 0.9;
	var_03 = var_03 * var_03;
	if(distancesquared(param_00.origin,var_02) <= var_03)
	{
		return var_02;
	}

	return undefined;
}

//Function Number: 75
func_2EAF()
{
	self notify("bot_think_crate");
	self endon("bot_think_crate");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_00 = getdvarfloat("player_useRadius");
	for(;;)
	{
		var_01 = randomfloatrange(2,4);
		scripts\common\utility::waittill_notify_or_timeout("new_crate_to_take",var_01);
		if(isdefined(self.var_2F2B) && self.var_2F2B.size == 0)
		{
			self.var_2F2B = undefined;
		}

		var_02 = level.var_3A59;
		if(!scripts\mp\bots\_bots_util::func_2DCA() && isdefined(self.var_2F2B))
		{
			var_02 = scripts\common\utility::array_combine(var_02,self.var_2F2B);
		}

		if(isdefined(level.var_2E6A) && scripts\mp\_utility::_hasperk("specialty_scavenger"))
		{
			var_02 = scripts\common\utility::array_combine(var_02,level.var_2E6A);
		}

		var_02 = scripts\common\utility::func_22BC(var_02);
		if(var_02.size == 0)
		{
			continue;
		}

		if(scripts\mp\bots\_bots_strategy::func_2DC5("airdrop_crate") || self botgetscriptgoaltype() == "tactical" || scripts\mp\bots\_bots_util::func_2DE0())
		{
			continue;
		}

		var_03 = [];
		foreach(var_05 in var_02)
		{
			if(func_2D45(var_05))
			{
				var_03[var_03.size] = var_05;
			}
		}

		var_03 = scripts\common\utility::func_22AF(var_03);
		if(var_03.size == 0)
		{
			continue;
		}

		var_03 = scripts\common\utility::func_782F(self.origin,var_03);
		var_07 = self getnearestnode();
		if(!isdefined(var_07))
		{
			continue;
		}

		var_08 = self [[ level.var_2D9E["crate_low_ammo_check"] ]]();
		var_09 = (var_08 || randomint(100) < 50) && !scripts\mp\killstreaks\_emp_common::isemped();
		var_0A = undefined;
		foreach(var_05 in var_03)
		{
			var_0C = 0;
			if((!isdefined(var_05.var_222) || var_05.var_222 != self) && !isdefined(var_05.var_2F33))
			{
				var_0D = [];
				foreach(var_0F in level.players)
				{
					if(!isdefined(var_0F.team))
					{
						continue;
					}

					if(!isai(var_0F) && level.teambased && var_0F.team == self.team)
					{
						if(distancesquared(var_0F.origin,var_05.origin) < 490000)
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
						foreach(var_13 in var_05.var_BE7E)
						{
							var_0C = var_0C | nodesvisible(var_11,var_13,1);
						}
					}
				}
			}

			if(!var_0C)
			{
				var_15 = isdefined(var_05.var_2EEB) && isdefined(var_05.var_2EEB[self.team]) && var_05.var_2EEB[self.team] > 0;
				var_16 = 0;
				foreach(var_13 in var_05.var_BE7E)
				{
					var_16 = var_16 | nodesvisible(var_07,var_13,1);
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
			if(self [[ level.var_2D9E["crate_should_claim"] ]]())
			{
				if(!isdefined(var_0A.var_2F33))
				{
					if(!isdefined(var_0A.var_2EEB))
					{
						var_0A.var_2EEB = [];
					}

					var_0A.var_2EEB[self.team] = 1;
				}
			}

			var_1A = spawnstruct();
			var_1A.var_C270 = var_0A;
			var_1A.var_10D46 = ::func_1392B;
			var_1A.var_FF0D = ::func_4841;
			var_1B = undefined;
			if(isdefined(var_0A.var_2F33))
			{
				if(isdefined(var_0A.var_2F32) && var_0A.var_2F32)
				{
					var_1A.var_EDC9 = 16;
					var_1A.var_157C = undefined;
					var_1B = var_0A.origin;
				}
				else
				{
					var_1A.var_EDC9 = 50;
					var_1A.var_157C = ::func_12FAF;
					var_1C = func_4838(var_0A,var_00);
					if(!isdefined(var_1C))
					{
						continue;
					}

					var_1C = var_1C - var_0A.origin;
					var_1D = length(var_1C) * randomfloat(1);
					var_1B = var_0A.origin + vectornormalize(var_1C) * var_1D + (0,0,12);
				}
			}
			else
			{
				var_1A.var_157C = ::func_12FBF;
				var_1A.var_6302 = ::func_11052;
				var_1B = func_4838(var_0A,var_00);
				if(!isdefined(var_1B))
				{
					continue;
				}

				var_1A.var_EDC9 = var_00 - distance(var_0A.origin,var_1B + (0,0,40));
				var_1B = var_1B + (0,0,24);
			}

			if(isdefined(var_1A.var_EDC9))
			{
			}

			var_0A notify("path_disconnect");
			wait(0.05);
			if(!isdefined(var_0A))
			{
				continue;
			}

			scripts\mp\bots\_bots_strategy::func_2E27("airdrop_crate",var_1B,30,var_1A);
		}
	}
}

//Function Number: 76
func_2E93(param_00)
{
	return 1;
}

//Function Number: 77
func_484B()
{
	return 1;
}

//Function Number: 78
func_483E()
{
	return 0;
}

//Function Number: 79
func_2E92(param_00)
{
	if(self getcurrentweapon() == level.var_2F30[param_00.var_2F33].var_B7A8)
	{
		return 0;
	}

	return 1;
}

//Function Number: 80
func_2E54(param_00)
{
	scripts\mp\_utility::_switchtoweapon(self.var_F0C4);
	wait(1);
}

//Function Number: 81
func_2E51(param_00)
{
	scripts\mp\_utility::_switchtoweapon("none");
	self.var_F0C4 = self getcurrentweapon();
}

//Function Number: 82
func_2E96(param_00)
{
	if(scripts\mp\bots\_bots_util::func_2DB0(0.66))
	{
		var_01 = self getnearestnode();
		if(isdefined(param_00.var_BE7E) && isdefined(param_00.var_BE7E[0]) && isdefined(var_01))
		{
			if(nodesvisible(var_01,param_00.var_BE7E[0],1))
			{
				if(scripts\common\utility::func_13D90(self.origin,self.angles,param_00.origin,self botgetfovdot()))
				{
					return 1;
				}
			}
		}
	}

	return 0;
}

//Function Number: 83
func_2E94(param_00)
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

//Function Number: 84
func_2E95(param_00)
{
	return 1;
}

//Function Number: 85
func_483F()
{
	self notify("crate_monitor_position");
	self endon("crate_monitor_position");
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		var_00 = self.origin;
		wait(0.5);
		if(!isalive(self))
		{
			return;
		}

		if(!scripts\mp\bots\_bots_util::func_2EC6(self.origin,var_00))
		{
			self.on_path_grid = undefined;
			self.var_BE7E = undefined;
			self.var_BE80 = undefined;
		}
	}
}

//Function Number: 86
func_484D()
{
}

//Function Number: 87
func_4841(param_00)
{
	if(!isdefined(param_00.var_C270))
	{
		return 1;
	}

	return 0;
}

//Function Number: 88
func_12FBF(param_00)
{
	if(isagent(self))
	{
		scripts\common\utility::func_1C6E(1);
		param_00.var_C270 enableplayeruse(self);
		wait(0.05);
	}

	self [[ level.var_2D9E["crate_wait_use"] ]]();
	if(isdefined(param_00.var_C270.var_222) && param_00.var_C270.var_222 == self)
	{
		var_01 = level.var_485C / 1000 + 0.5;
	}
	else
	{
		var_01 = level.var_4859 / 1000 + 1;
	}

	self botpressbutton("use",var_01);
	wait(var_01);
	if(isagent(self))
	{
		scripts\common\utility::func_1C6E(0);
		if(isdefined(param_00.var_C270))
		{
			param_00.var_C270 disableplayeruse(self);
		}
	}

	if(isdefined(param_00.var_C270))
	{
		if(!isdefined(param_00.var_C270.var_2EFA))
		{
			param_00.var_C270.var_2EFA = [];
		}

		param_00.var_C270.var_2EFA[param_00.var_C270.var_2EFA.size] = self;
	}
}

//Function Number: 89
func_12FAF(param_00)
{
	if(isagent(self))
	{
		scripts\common\utility::func_1C6E(1);
		param_00.var_C270 enableplayeruse(self);
		wait(0.05);
	}

	if(isdefined(param_00.var_C270) && isdefined(param_00.var_C270.var_2F33))
	{
		var_01 = param_00.var_C270.var_2F33;
		if(isdefined(level.var_2E55[var_01]))
		{
			self [[ level.var_2E55[var_01] ]](param_00.var_C270);
		}

		if(isdefined(param_00.var_C270))
		{
			var_02 = level.var_2F30[param_00.var_C270.var_2F33].var_130EE / 1000 + 0.5;
			self botpressbutton("use",var_02);
			wait(var_02);
			if(isdefined(level.var_2E52[var_01]))
			{
				self [[ level.var_2E52[var_01] ]](param_00.var_C270);
			}
		}
	}

	if(isagent(self))
	{
		scripts\common\utility::func_1C6E(0);
		if(isdefined(param_00.var_C270))
		{
			param_00.var_C270 disableplayeruse(self);
		}
	}
}

//Function Number: 90
func_1392B(param_00)
{
	thread func_2ED0(param_00.var_C270);
}

//Function Number: 91
func_11052(param_00)
{
	if(isdefined(param_00.var_C270))
	{
		param_00.var_C270.var_2EEB[self.team] = 0;
	}
}

//Function Number: 92
func_2ED0(param_00)
{
	param_00 endon("death");
	param_00 endon("revived");
	param_00 endon("disconnect");
	level endon("game_ended");
	var_01 = self.team;
	scripts\common\utility::waittill_any_3("death","disconnect");
	if(isdefined(param_00))
	{
		param_00.var_2EEB[var_01] = 0;
	}
}

//Function Number: 93
func_2EB0()
{
	self notify("bot_think_crate_blocking_path");
	self endon("bot_think_crate_blocking_path");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_00 = getdvarfloat("player_useRadius");
	for(;;)
	{
		wait(3);
		if(self usebuttonpressed())
		{
			continue;
		}

		if(scripts\mp\_utility::func_9FC6())
		{
			continue;
		}

		var_01 = level.var_3A59;
		for(var_02 = 0;var_02 < var_01.size;var_02++)
		{
			var_03 = var_01[var_02];
			if(!isdefined(var_03))
			{
				continue;
			}

			if(distancesquared(self.origin,var_03.origin) < var_00 * var_00)
			{
				if(var_03.var_222 == self)
				{
					self botpressbutton("use",level.var_485C / 1000 + 0.5);
					continue;
				}

				self botpressbutton("use",level.var_4859 / 1000 + 0.5);
			}
		}
	}
}

//Function Number: 94
func_2EB5()
{
	self notify("bot_think_revive");
	self endon("bot_think_revive");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(!level.teambased)
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

		level scripts\common\utility::waittill_notify_or_timeout("player_last_stand",var_00);
		if(!func_2D23())
		{
			continue;
		}

		var_01 = getentarray("revive_trigger","targetname");
		if(var_01.size > 1)
		{
			var_01 = sortbydistance(var_01,self.origin);
			if(isdefined(self.var_222))
			{
				for(var_02 = 0;var_02 < var_01.size;var_02++)
				{
					if(var_01[var_02].var_222 != self.var_222)
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
			var_05 = var_04.var_222;
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

			if(var_05.team != self.team)
			{
				continue;
			}

			if(!isdefined(var_05.inlaststand) || !var_05.inlaststand)
			{
				continue;
			}

			if(isdefined(var_05.var_2EEB) && isdefined(var_05.var_2EEB[self.team]) && var_05.var_2EEB[self.team] > 0)
			{
				continue;
			}

			if(distancesquared(self.origin,var_05.origin) < 4194304)
			{
				var_06 = spawnstruct();
				var_06.var_C270 = var_04;
				var_06.var_EDC9 = 64;
				if(isdefined(self.var_A8FB) && gettime() - self.var_A8FB < 1000)
				{
					var_06.var_EDC9 = 32;
				}

				var_06.var_10D46 = ::func_1392C;
				var_06.var_6302 = ::func_11039;
				var_06.var_FF0D = ::func_D261;
				var_06.var_157C = ::func_E4A0;
				scripts\mp\bots\_bots_strategy::func_2E27("revive",var_05.origin,60,var_06);
				break;
			}
		}
	}
}

//Function Number: 95
func_1392C(param_00)
{
	thread func_2ED0(param_00.var_C270.var_222);
}

//Function Number: 96
func_11039(param_00)
{
	if(isdefined(param_00.var_C270.var_222))
	{
		param_00.var_C270.var_222.var_2EEB[self.team] = 0;
	}
}

//Function Number: 97
func_D261(param_00)
{
	if(!isdefined(param_00.var_C270.var_222) || param_00.var_C270.var_222.health <= 0)
	{
		return 1;
	}

	if(!isdefined(param_00.var_C270.var_222.inlaststand) || !param_00.var_C270.var_222.inlaststand)
	{
		return 1;
	}

	return 0;
}

//Function Number: 98
func_E4A0(param_00)
{
	if(distancesquared(self.origin,param_00.var_C270.var_222.origin) > 4096)
	{
		self.var_A8FB = gettime();
		return;
	}

	if(isagent(self))
	{
		scripts\common\utility::func_1C6E(1);
		param_00.var_C270 enableplayeruse(self);
		wait(0.05);
	}

	var_01 = self.team;
	self botpressbutton("use",level.var_AA15 / 1000 + 0.5);
	wait(level.var_AA15 / 1000 + 1.5);
	if(isdefined(param_00.var_C270.var_222))
	{
		param_00.var_C270.var_2EEB[var_01] = 0;
	}

	if(isagent(self))
	{
		scripts\common\utility::func_1C6E(0);
		if(isdefined(param_00.var_C270))
		{
			param_00.var_C270 disableplayeruse(self);
		}
	}
}

//Function Number: 99
func_2D23()
{
	if(isdefined(self.var_1B3) && self.var_1B3 == 1)
	{
		return 0;
	}

	if(scripts\mp\bots\_bots_strategy::func_2DC5("revive"))
	{
		return 0;
	}

	if(scripts\mp\bots\_bots_util::func_2DE0())
	{
		return 0;
	}

	if(scripts\mp\bots\_bots_util::func_2DD4())
	{
		return 1;
	}

	var_00 = self botgetscriptgoaltype();
	if(var_00 == "none" || var_00 == "hunt" || var_00 == "guard")
	{
		return 1;
	}

	return 0;
}

//Function Number: 100
func_E4A7(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("bad_path");
	self endon("goal");
	param_00 scripts\common\utility::waittill_any_3("death","revived");
	self notify("bad_path");
}

//Function Number: 101
func_2DF8()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(gettime() > 15000)
	{
		return;
	}

	while(!scripts\mp\_utility::func_7672() || !scripts\mp\_utility::func_766C("prematch_done"))
	{
		wait(0.05);
	}

	var_00 = undefined;
	var_01 = undefined;
	for(var_02 = 0;var_02 < level.players.size;var_02++)
	{
		var_03 = level.players[var_02];
		if(isdefined(var_03) && isdefined(self.team) && isdefined(var_03.team) && function_0106(self.team,var_03.team))
		{
			if(!isdefined(var_03.var_2EA2))
			{
				var_00 = var_03;
			}

			if(isai(var_03) && !isdefined(var_03.var_2EA1))
			{
				var_01 = var_03;
			}
		}
	}

	if(isdefined(var_00))
	{
		self.var_2EA1 = 1;
		var_00.var_2EA2 = 1;
		self getenemyinfo(var_00);
	}

	if(isdefined(var_01))
	{
		var_01.var_2EA1 = 1;
		self.var_2EA2 = 1;
		var_01 getenemyinfo(self);
	}
}

//Function Number: 102
func_2E16(param_00,param_01)
{
	if(isdefined(param_01))
	{
		return self method_81F1(param_00,param_01);
	}

	return self method_81F1(param_00);
}

//Function Number: 103
func_2EB1()
{
	self notify("bot_think_gametype");
	self endon("bot_think_gametype");
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	scripts\mp\_utility::func_7670("prematch_done");
	self thread [[ level.var_2D9E["gametype_think"] ]]();
}

//Function Number: 104
func_4FF3()
{
}

//Function Number: 105
func_B9A3()
{
	for(;;)
	{
		level waittill("smoke",var_00,var_01);
		if(var_01 == "smoke_grenade_mp")
		{
			var_00 thread func_B9A2();
		}
	}
}

//Function Number: 106
func_B9A2()
{
	self endon("late_death");
	thread func_1036D();
	self waittill("explode",var_00);
	wait(1);
	var_01 = spawn("script_model",var_00);
	var_01 show();
	var_02 = getent("smoke_grenade_sight_clip_256","targetname");
	if(isdefined(var_02))
	{
		var_01 clonebrushmodeltoscriptmodel(var_02);
	}

	wait(9.25);
	var_01 delete();
}

//Function Number: 107
func_1036D()
{
	self endon("explode");
	self waittill("death");
	waittillframeend;
	self notify("late_death");
}

//Function Number: 108
func_2D04(param_00)
{
	var_01 = 0;
	param_00.var_2F33 = "scavenger_bag";
	param_00.var_2F32 = 1;
	if(!isdefined(level.var_2E6A))
	{
		level.var_2E6A = [];
	}

	foreach(var_04, var_03 in level.var_2E6A)
	{
		if(!isdefined(var_03))
		{
			var_01 = 1;
			level.var_2E6A[var_04] = param_00;
			break;
		}
	}

	if(!var_01)
	{
		level.var_2E6A[level.var_2E6A.size] = param_00;
	}

	foreach(var_06 in level.var_C928)
	{
		if(isai(var_06) && var_06 scripts\mp\_utility::_hasperk("specialty_scavenger"))
		{
			var_06 notify("new_crate_to_take");
		}
	}
}

//Function Number: 109
func_2EBB()
{
	var_00 = getentarray("bot_flag_set","targetname");
	foreach(var_02 in var_00)
	{
		if(!isdefined(var_02.script_noteworthy))
		{
			continue;
		}

		var_02 thread func_2D94(var_02.script_noteworthy);
	}
}

//Function Number: 110
func_2D94(param_00)
{
	self endon("death");
	for(;;)
	{
		self waittill("trigger",var_01);
		if(scripts\mp\_utility::func_9D2D(var_01))
		{
			var_01 notify("flag_trigger_set_" + param_00);
			var_01 botsetflag(param_00,1);
			var_01 thread func_2D95(param_00);
		}
	}
}

//Function Number: 111
func_2D95(param_00)
{
	self endon("flag_trigger_set_" + param_00);
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	scripts\common\utility::func_136F7();
	waittillframeend;
	self botsetflag(param_00,0);
}