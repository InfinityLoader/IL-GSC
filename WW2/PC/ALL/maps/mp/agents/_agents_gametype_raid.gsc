/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\_agents_gametype_raid.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 265 ms
 * Timestamp: 10/27/2023 3:08:58 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	func_87A7();
}

//Function Number: 2
func_87A7()
{
	level.var_A41["squadmate"]["spawn"] = ::func_90A6;
	level.var_A41["squadmate"]["think"] = ::func_0C6D;
	level.var_A41["squadmate"]["onAIConnect"] = ::func_6BAE;
	level.var_A41["squadmate"]["on_damaged_finished"] = ::maps/mp/agents/_agents::func_A40;
	level.var_A41["squadmate"]["on_damaged"] = ::maps/mp/agents/_agents::func_6A74;
	level.var_A41["squadmate"]["on_killed"] = ::maps/mp/agents/_agents::func_6A75;
	level.var_A41["minion"]["spawn"] = ::func_9079;
	level.var_A41["minion"]["think"] = ::func_621A;
	level.var_A41["minion"]["on_damaged_finished"] = ::maps/mp/agents/_agents::func_A40;
	level.var_A41["minion"]["on_damaged"] = ::maps/mp/agents/_agents::func_6A74;
	level.var_A41["minion"]["on_killed"] = ::maps/mp/agents/_agents::func_6A75;
	level.var_A41["beach_ally"]["spawn"] = ::func_9079;
	level.var_A41["beach_ally"]["think"] = ::func_621A;
	level.var_A41["beach_ally"]["on_damaged_finished"] = ::maps/mp/agents/_agents::func_A40;
	level.var_A41["beach_ally"]["on_damaged"] = ::maps/mp/agents/_agents::func_6A74;
	level.var_A41["beach_ally"]["on_killed"] = ::func_6A79;
	level.var_A41["player"]["think"] = ::agent_player_raid_think;
	level.var_17C8 = ::func_17C8;
}

//Function Number: 3
agent_player_raid_think()
{
	thread maps/mp/bots/_bots_gametype_raid::func_1AAD();
}

//Function Number: 4
func_9079(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(level.var_A41[self.var_A4B]["onAIConnect"]))
	{
		[[ maps/mp/agents/_agent_utility::func_A59("onAIConnect") ]]();
	}

	maps/mp/agents/_agents::func_8F70(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
	maps/mp/agents/_agent_utility::func_83FE(self.var_1A7);
	self.var_9 = &"RAIDS_SQUADMATE";
	self method_8528(1,self.var_1A7);
	self.var_2F05 = "veteran";
	func_8727();
	maps\mp\gametypes\_battlechatter_mp::func_2F72(self);
	self.var_6734 = 1;
	self.var_672C = 1;
	thread func_6BA4();
}

//Function Number: 5
func_621A()
{
}

//Function Number: 6
func_90A6(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(level.var_A41[self.var_A4B]["onAIConnect"]))
	{
		[[ maps/mp/agents/_agent_utility::func_A59("onAIConnect") ]]();
	}

	maps/mp/agents/_agents::func_8F70(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
	maps/mp/agents/_agent_utility::func_83FE(self.var_1A7);
	self.var_9 = &"RAIDS_SQUADMATE";
	self method_8528(1,self.var_1A7);
	self.var_2F05 = "veteran";
	func_8727();
	maps\mp\gametypes\_battlechatter_mp::func_2F72(self);
	self.var_6734 = 1;
	self.var_672C = 1;
	thread func_6BA4();
}

//Function Number: 7
func_6BAE()
{
}

//Function Number: 8
func_8727()
{
	maps/mp/bots/_bots_util::func_1AD5("run_and_gun");
	if(isdefined(self.var_2F05))
	{
		maps/mp/bots/_bots_util::func_1AD3(self.var_2F05);
	}
	else
	{
		maps/mp/bots/_bots_util::func_1AD3("regular");
	}

	self.var_2F05 = self botgetdifficulty();
}

//Function Number: 9
func_6BA4(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("applyLoadout");
	self method_8543(1);
	self botsetflag("no_enemy_search",1);
}

//Function Number: 10
func_0C6D()
{
	self endon("death");
	level endon("game_ended");
	self endon("owner_disconnect");
	self botsetflag("force_sprint",1);
	var_00 = 0;
	var_01 = 0;
	for(;;)
	{
		if(!isdefined(self.var_117))
		{
			maps\mp\_utility::func_728();
			return;
		}

		if(float(self.var_117.var_BC) / self.var_117.var_FB < 0.5 && gettime() > var_01)
		{
			var_02 = getnodesinradiussorted(self.var_117.var_116,256,0);
			if(var_02.size >= 2)
			{
				self.var_2C85 = var_02[1];
				self notify("defend_force_node_recalculation");
				var_01 = gettime() + 1000;
			}
		}
		else if(float(self.var_BC) / self.var_FB >= 0.6)
		{
			var_00 = 0;
		}
		else if(!var_00)
		{
			var_03 = maps/mp/bots/_bots_util::func_19CE(self.var_117.var_116,350,1);
			if(isdefined(var_03))
			{
				self.var_2C85 = var_03;
				self notify("defend_force_node_recalculation");
				var_00 = 1;
			}
		}

		if(!maps/mp/bots/_bots_util::func_1A30(self.var_117))
		{
			var_04["override_goal_type"] = "critical";
			var_04["min_goal_time"] = 20;
			var_04["max_goal_time"] = 30;
			maps/mp/bots/_bots_strategy::func_1A0C(self.var_117,350,var_04);
		}

		wait 0.05;
	}
}

//Function Number: 11
func_17C8(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(level.var_791B))
	{
		level.var_791B = [];
	}

	if(level.var_791B.size > 6)
	{
		level.var_791B[0] dodamage(level.var_791B[0].var_BC + 100,level.var_791B[0].var_116);
	}

	var_05 = [[ level.var_A4D ]]("minion",param_03,undefined,param_00,param_01,undefined,0,0,"recruit");
	level.var_791B[level.var_791B.size] = var_05;
	var_05 botsetstance(param_02);
	var_05 thread func_0A5F();
}

//Function Number: 12
func_0A5F()
{
	level endon("game_ended");
	self endon("death");
	func_0A5E();
	thread func_0A60();
	maps/mp/bots/_bots_strategy::func_1A8D(self.var_116,512,[]);
	wait(15);
	self dodamage(self.var_BC + 100,self.var_116);
}

//Function Number: 13
func_0A5E()
{
	var_00 = self getweaponslistprimaries();
	var_01 = self method_834A();
	var_02 = self method_831F();
	var_00[var_00.size] = var_01;
	var_00[var_00.size] = var_02;
	foreach(var_04 in var_00)
	{
		if(var_04 == "none")
		{
			continue;
		}

		self givestartammo(var_04);
		if(var_04 == var_01)
		{
			var_05 = 0;
		}
		else if(var_04 == var_02)
		{
			var_05 = 0;
		}
		else if(var_04 == "panzerschreck_mp")
		{
			var_05 = 0;
		}
		else if(var_04 == "bazooka_mp")
		{
			var_05 = 0;
		}
		else
		{
			var_05 = weaponclipsize(var_04,self);
		}

		self method_82FA(var_04,var_05);
	}

	self method_82AB();
}

//Function Number: 14
func_0A60()
{
	level endon("game_ended");
	self waittill("death");
	level.var_791B = common_scripts\utility::func_F93(level.var_791B,self);
}

//Function Number: 15
func_6A79(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self [[ level.var_A5D ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,0);
	level thread maps\mp\gametypes\_rank::func_1457("raids_npc_kill",param_01,param_04,self,param_03);
	if(isdefined(level.var_6A75))
	{
		[[ level.var_6A75 ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08);
	}

	if(self.var_565F)
	{
		self.var_4B60 = 1;
		if(maps\mp\_utility::func_44FC() != 1 && isdefined(self.var_7DAD) && self.var_7DAD)
		{
			self thread [[ maps/mp/agents/_agent_utility::func_A59("spawn") ]]();
			return;
		}

		maps/mp/agents/_agent_utility::func_2A73();
	}
}