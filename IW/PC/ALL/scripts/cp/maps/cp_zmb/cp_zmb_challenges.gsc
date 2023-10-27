/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_zmb\cp_zmb_challenges.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 50
 * Decompile Time: 2488 ms
 * Timestamp: 10/27/2023 12:07:59 AM
*******************************************************************/

//Function Number: 1
register_default_challenges()
{
	level.var_3C1A = ::func_88C0;
	level.challenge_pause_func = ::pause_challenge_func;
	scripts\cp\_challenge::func_DEA1("long_shot",undefined,0,undefined,undefined,::func_15CC,::func_4DB0,undefined,::func_7779);
	scripts\cp\_challenge::func_DEA1("close_shot",undefined,0,undefined,undefined,::func_1597,::func_4DB0,undefined,::func_7779);
	scripts\cp\_challenge::func_DEA1("jump_shot",undefined,0,undefined,undefined,::func_7742,::scripts\cp\_challenge::func_5010,undefined,::func_7779);
	scripts\cp\_challenge::func_DEA1("kill_marked",undefined,0,undefined,undefined,::func_15C7,::func_4DC2,undefined,::func_7779);
	scripts\cp\_challenge::func_DEA1("kill_headshots",undefined,0,undefined,undefined,::func_7742,::scripts\cp\_challenge::func_5010,undefined,::func_7779);
	scripts\cp\_challenge::func_DEA1("kill_melee",undefined,0,undefined,undefined,::func_7742,::scripts\cp\_challenge::func_5010,undefined,::func_7779);
	scripts\cp\_challenge::func_DEA1("kill_crawlers",undefined,0,undefined,undefined,::func_7742,::scripts\cp\_challenge::func_5010,undefined,::func_7779);
	scripts\cp\_challenge::func_DEA1("kill_nodamage",undefined,0,undefined,undefined,::func_15C8,::scripts\cp\_challenge::func_5010,undefined,::func_12DD7);
	scripts\cp\_challenge::func_DEA1("protect_player",undefined,1,::scripts\cp\_challenge::func_5022,undefined,::func_15E1,::func_4DCC,undefined,::func_12E19);
	scripts\cp\_challenge::func_DEA1("no_laststand",undefined,1,::scripts\cp\_challenge::func_5022,undefined,::func_15DA,::scripts\cp\_challenge::func_5010,undefined,::func_12DF4);
	scripts\cp\_challenge::func_DEA1("no_bleedout",undefined,1,::scripts\cp\_challenge::func_5022,undefined,::func_15D9,::scripts\cp\_challenge::func_5010,undefined,::func_12DF3);
	scripts\cp\_challenge::func_DEA1("multikills",undefined,0,undefined,undefined,::func_7742,::scripts\cp\_challenge::func_5010,undefined,::func_7779);
	scripts\cp\_challenge::func_DEA1("area_kills",undefined,0,undefined,undefined,::func_158B,::func_4DA8,undefined,::func_7779);
	scripts\cp\_challenge::func_DEA1("window_boards",undefined,0,undefined,undefined,::func_15FE,::func_4DD6,undefined,::func_7779);
	scripts\cp\_challenge::func_DEA1("dismember_arm",undefined,0,undefined,undefined,::func_15A6,::func_4DAF,undefined,::func_7779);
	scripts\cp\_challenge::func_DEA1("dismember_leg",undefined,0,undefined,undefined,::func_15A7,::func_4DAF,undefined,::func_7779);
	scripts\cp\_challenge::func_DEA1("kill_zombiewhodamagedme",undefined,0,undefined,undefined,::func_15CB,::func_4DC3,undefined,::func_7779);
	scripts\cp\_challenge::func_DEA1("challenge_failed",undefined,0,undefined,undefined,::scripts\cp\_challenge::func_5010,::scripts\cp\_challenge::func_5010,undefined,undefined);
	scripts\cp\_challenge::func_DEA1("challenge_success",undefined,0,undefined,undefined,::scripts\cp\_challenge::func_5010,::scripts\cp\_challenge::func_5010,undefined,undefined);
	scripts\cp\_challenge::func_DEA1("next_challenge",undefined,0,undefined,undefined,::scripts\cp\_challenge::func_5010,::scripts\cp\_challenge::func_5010,undefined,undefined);
	level.var_B3D3 = ["jump_shot","long_shot","no_laststand","no_bleedout","protect_player","kill_marked","kill_nodamage","kill_headshots","kill_melee","kill_crawlers","dismember_arm","dismember_leg","window_boards","multikills","area_kills","close_shot","kill_zombiewhodamagedme"];
	level.var_118A4 = ["jump_shot","long_shot","multikills","kill_melee","no_laststand"];
	level.var_118A5 = ["window_boards","close_shot","kill_crawlers","dismember_leg","protect_player","kill_nodamage"];
	level.var_118A6 = ["area_kills","no_bleedout","kill_zombiewhodamagedme","dismember_arm","kill_marked","kill_headshots"];
	level.var_118A4 = scripts\common\utility::array_randomize(level.var_118A4);
	level.var_118A5 = scripts\common\utility::array_randomize(level.var_118A5);
	level.var_118A6 = scripts\common\utility::array_randomize(level.var_118A6);
}

//Function Number: 2
func_7742()
{
	scripts\cp\_challenge::func_5010();
	self.var_4BA0 = 0;
	scripts\cp\_challenge::func_12D9E(0,self.var_155);
	level thread func_7744(self);
}

//Function Number: 3
func_7779(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(scripts\common\utility::flag("pause_challenges"))
	{
		return;
	}

	self.var_4BA0 = self.var_4BA0 + param_00;
	if(self.var_4BA0 >= self.var_155)
	{
		self.var_111AE = 1;
	}

	scripts\cp\_challenge::func_12D9E(self.var_4BA0,self.var_155);
	if(self.var_111AE)
	{
		level notify("current_challenge_ended");
		scripts\cp\_challenge::func_4DAE();
		return;
	}

	if(scripts\common\utility::istrue(param_01))
	{
		level notify("current_challenge_ended");
		self.var_111AE = 0;
		scripts\cp\_challenge::func_4DAE();
	}
}

//Function Number: 4
func_7744(param_00,param_01)
{
	var_02 = int(level.var_3C17[param_00.var_DE3F].var_1649[level.players.size - 1]);
	var_03 = int(gettime() + var_02 * 1000);
	foreach(var_05 in level.players)
	{
		var_05 setclientomnvar("ui_intel_timer",var_03);
	}

	level.var_4B54 = var_02;
	level.var_110AD = var_02;
	level thread scripts\cp\_challenge::func_12DA5(param_01);
	param_00 thread scripts\cp\_challenge::func_5026(var_02);
}

//Function Number: 5
func_15FE()
{
	func_7742();
	level thread func_13D38();
}

//Function Number: 6
func_13D38()
{
	level endon("stop_windowboard_logic");
	level endon("challenge_deactivated");
	for(;;)
	{
		level waittill("reboard",var_00);
		scripts\cp\_challenge::func_12D9C("window_boards",var_00);
	}
}

//Function Number: 7
func_4DD6()
{
	level notify("stop_windowboard_logic");
	scripts\cp\_challenge::func_5010();
}

//Function Number: 8
add_to_dismember_queue(param_00)
{
	if(!isdefined(level.dismember_queue))
	{
		level.dismember_queue = [];
	}

	var_01 = spawnstruct();
	var_01.var_ACD9 = param_00;
	var_01.processed = 0;
	level.dismember_queue = scripts\common\utility::array_add_safe(level.dismember_queue,var_01);
}

//Function Number: 9
func_15A6()
{
	level.dismember_queue_func = ::add_to_dismember_queue;
	level.dismember_queue = [];
	func_7742();
	level thread func_565B("arm");
}

//Function Number: 10
func_15A7()
{
	level.dismember_queue_func = ::add_to_dismember_queue;
	level.dismember_queue = [];
	func_7742();
	level thread func_565B("leg");
}

//Function Number: 11
func_565B(param_00)
{
	level endon("stop_dismember_logic");
	level endon("challenge_deactivated");
	for(;;)
	{
		if(level.dismember_queue.size > 0)
		{
			foreach(var_02 in level.dismember_queue)
			{
				if(var_02.processed)
				{
					continue;
				}

				if(param_00 == "arm")
				{
					if(var_02.var_ACD9 == 1 || var_02.var_ACD9 == 2)
					{
						scripts\cp\_challenge::func_12D9C("dismember_arm",1);
					}
				}
				else if(param_00 == "leg")
				{
					if(var_02.var_ACD9 == 4 || var_02.var_ACD9 == 8)
					{
						scripts\cp\_challenge::func_12D9C("dismember_leg",1);
					}
				}

				var_02.processed = 1;
			}

			level.dismember_queue = [];
		}

		wait(0.1);
	}
}

//Function Number: 12
func_4DAF()
{
	level.dismember_queue_func = undefined;
	level.dismember_queue = undefined;
	level notify("stop_dismember_logic");
	scripts\cp\_challenge::func_5010();
}

//Function Number: 13
func_15CC()
{
	func_7742();
	level thread func_5700("long_shot");
}

//Function Number: 14
func_1597()
{
	func_7742();
	level thread func_5700("close_shot");
}

//Function Number: 15
func_5700(param_00)
{
	level endon("stop_distanceshot_logic");
	level endon("challenge_deactivated");
	for(;;)
	{
		if(scripts\common\utility::flag("pause_challenges"))
		{
			foreach(var_02 in scripts\mp\_mp_agent::func_7DB0("axis"))
			{
				if(scripts\common\utility::istrue(var_02.var_B36D))
				{
					foreach(var_04 in level.players)
					{
						scripts\cp\_outline::func_5561(var_02,var_04);
					}

					var_02.var_B36D = undefined;
				}
			}

			scripts\common\utility::func_6E5A("pause_challenges");
		}

		foreach(var_06, var_02 in scripts\mp\_mp_agent::func_7DB0("axis"))
		{
			if(!isdefined(var_02.agent_type))
			{
				continue;
			}

			if(!scripts\cp\_utility::func_FF18(var_02,1,1) && var_02.agent_type != "zombie_brute")
			{
				continue;
			}

			var_08 = undefined;
			foreach(var_04 in level.players)
			{
				if(func_9BBE(var_04,undefined,var_02,param_00))
				{
					var_08 = 1;
					scripts\cp\_outline::func_6220(var_02,var_04,0,1,0,"high");
					continue;
				}

				scripts\cp\_outline::func_5561(var_02,var_04);
			}

			var_02.var_B36D = var_08;
			if(var_06 % 2 == 0)
			{
				wait(0.05);
			}
		}

		wait(0.05);
	}
}

//Function Number: 16
func_4DB0()
{
	level notify("stop_distanceshot_logic");
	wait(1);
	foreach(var_01 in scripts\mp\_mp_agent::func_7DAF())
	{
		if(!isdefined(var_01.var_B36D))
		{
			continue;
		}

		var_01.var_B36D = undefined;
		foreach(var_03 in level.players)
		{
			scripts\cp\_outline::func_5561(var_01,var_03);
		}
	}

	scripts\cp\_challenge::func_5010();
}

//Function Number: 17
func_15C7()
{
	func_7742();
	level thread func_135EC(self);
}

//Function Number: 18
func_135EC(param_00)
{
	level endon("current_challenge_ended");
	level endon("challenge_deactivated");
	level.var_C20A = 0;
	level.var_C1EF = 0;
	for(;;)
	{
		if(scripts\common\utility::flag("pause_challenges"))
		{
			foreach(var_02 in scripts\mp\_mp_agent::func_7DB0("axis"))
			{
				if(scripts\common\utility::istrue(var_02.var_B36D))
				{
					foreach(var_04 in level.players)
					{
						scripts\cp\_outline::func_5561(var_02,var_04);
					}

					level.var_C20A--;
					var_02.var_B36D = undefined;
				}
			}

			scripts\common\utility::func_6E5A("pause_challenges");
		}

		var_07 = scripts\mp\_mp_agent::func_7DAF();
		foreach(var_02 in var_07)
		{
			if(!scripts\cp\_utility::func_FF18(var_02,1,1))
			{
				continue;
			}

			if(scripts\common\utility::istrue(var_02.var_B36D))
			{
				continue;
			}

			var_02.var_B36D = 1;
			scripts\cp\_outline::func_621F(var_02,0,1,0);
			var_02 thread func_E068();
			level.var_C20A++;
			while(level.var_C20A >= param_00.var_155)
			{
				if(scripts\common\utility::flag("pause_challenges"))
				{
					foreach(var_02 in scripts\mp\_mp_agent::func_7DB0("axis"))
					{
						if(scripts\common\utility::istrue(var_02.var_B36D))
						{
							foreach(var_04 in level.players)
							{
								scripts\cp\_outline::func_5561(var_02,var_04);
							}

							level.var_C20A--;
							var_02.var_B36D = undefined;
						}
					}

					scripts\common\utility::func_6E5A("pause_challenges");
				}

				wait(0.1);
			}
		}

		wait(0.05);
	}
}

//Function Number: 19
func_4DC2()
{
	foreach(var_01 in scripts\mp\_mp_agent::func_7DAF())
	{
		if(isdefined(var_01.var_B36D))
		{
			var_01.var_B36D = undefined;
			scripts\cp\_outline::func_5560(var_01);
		}
	}

	scripts\cp\_challenge::func_5010();
}

//Function Number: 20
func_158B()
{
	func_7742();
	level thread func_2134(self);
}

//Function Number: 21
func_2134(param_00)
{
	var_01 = scripts\cp\zombies\zombies_spawning::func_7C83(undefined,1);
	var_02 = scripts\common\utility::random(var_01);
	if(!isdefined(var_02))
	{
		var_02 = spawnstruct();
		var_02.var_28AB = "moon";
	}
	else if(var_02.var_28AB == "arcade_back" || var_02.var_28AB == "underground_route" || var_02.var_28AB == "hidden_room")
	{
		var_02 = spawnstruct();
		var_02.var_28AB = "moon";
	}

	var_03 = func_7A64(var_02);
	level.var_2132 = spawnfx(level._effect["challenge_ring"],var_03.origin + (0,0,-15),anglestoforward((0,0,0)),anglestoup((0,0,0)));
	level.var_3C11 = spawnstruct();
	level.var_3C11.origin = var_03.origin + (0,0,-20);
	level.var_3C11.var_257 = -27120;
	wait(0.1);
	triggerfx(level.var_2132);
	wait(0.1);
}

//Function Number: 22
func_7A64(param_00)
{
	var_01 = scripts\common\utility::getstructarray("area_kill_" + param_00.var_28AB,"targetname");
	return scripts\common\utility::random(var_01);
}

//Function Number: 23
func_4DA8(param_00)
{
	scripts\cp\_challenge::func_5010();
	level.var_2132 delete();
	level.var_3C11 = undefined;
}

//Function Number: 24
func_15CB()
{
	func_7742();
}

//Function Number: 25
func_4DC3(param_00)
{
	func_4DB0();
}

//Function Number: 26
func_15C8()
{
	func_7742();
	level thread func_6AC2(self);
	foreach(var_01 in level.players)
	{
		var_01 thread func_A5F8();
	}
}

//Function Number: 27
func_6AC2(param_00)
{
	level endon("kill_nodamage_complete");
	level endon("challenge_deactivated");
	level waittill("kill_nodamage_failed");
	param_00.var_111AE = 0;
	scripts\cp\_challenge::func_4DAE();
	level notify("kill_nodamage_complete");
}

//Function Number: 28
func_A5F8()
{
	level endon("kill_nodamage_complete");
	level endon("challenge_deactivated");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(scripts\common\utility::flag("pause_challenges"))
		{
			continue;
		}

		if(scripts\common\utility::istrue(self.ability_invulnerable))
		{
			continue;
		}

		if(isdefined(var_01) && isplayer(var_01) && scripts\cp\_utility::func_9BFB())
		{
			level notify("kill_nodamage_failed");
			return;
		}
		else if(isdefined(var_01) && isagent(var_01))
		{
			level notify("kill_nodamage_failed");
			return;
		}
	}
}

//Function Number: 29
func_12DD7(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(scripts\common\utility::flag("pause_challenges"))
	{
		return;
	}

	self.var_4BA0 = self.var_4BA0 + param_00;
	if(self.var_4BA0 >= self.var_155)
	{
		self.var_111AE = 1;
	}

	scripts\cp\_challenge::func_12D9E(self.var_4BA0,self.var_155);
	if(self.var_111AE)
	{
		level notify("kill_nodamage_complete");
		scripts\cp\_challenge::func_4DAE();
	}
}

//Function Number: 30
challenge_scalar_func(param_00)
{
	var_01 = func_7C28(param_00);
	switch(param_00)
	{
		case "kill_nodamage":
		case "kill_crawlers":
		case "kill_melee":
		case "kill_headshots":
		case "kill_marked":
		case "jump_shot":
		case "long_shot":
			if(var_01 >= level.var_5274)
			{
				var_01 = level.var_5274 - 2;
			}
	
			break;
	}

	return var_01;
}

//Function Number: 31
func_7C28(param_00)
{
	var_01 = level.var_13F16;
	var_02 = 0;
	var_03 = 1;
	var_04 = 99;
	var_05 = 1;
	var_06 = 9;
	for(var_07 = var_03;var_07 <= var_04;var_07++)
	{
		var_08 = tablelookup(var_01,var_02,var_07,var_05);
		if(var_08 == "")
		{
			return undefined;
		}

		if(var_08 != param_00)
		{
			continue;
		}

		var_09 = tablelookup(var_01,var_02,var_07,var_06);
		if(isdefined(var_09))
		{
			var_09 = strtok(var_09," ");
			if(var_09.size > 0)
			{
				return int(var_09[level.players.size - 1]);
			}
		}
	}
}

//Function Number: 32
default_playerdamage_challenge_func(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(level.var_4B4A))
	{
		return 0;
	}

	if(scripts\common\utility::flag("pause_challenges"))
	{
		return 0;
	}

	switch(level.var_4B4A)
	{
		case "kill_zombiewhodamagedme":
			if(!scripts\common\utility::istrue(param_01.var_B36D))
			{
				param_01 hudoutlineenableforclient(self,0,1,0);
				param_01.var_B36D = 1;
			}
	
			if(!scripts\common\utility::func_2286(param_01.var_4D3C,self))
			{
				param_01.var_4D3C[param_01.var_4D3C.size] = self;
			}
			return 0;
	}

	return 1;
}

//Function Number: 33
default_death_challenge_func(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(!isdefined(level.var_4B4A))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(self.var_54CB))
	{
		return 0;
	}

	if(scripts\common\utility::flag("pause_challenges"))
	{
		return 0;
	}

	switch(level.var_4B4A)
	{
		case "long_shot":
			if(func_9BBE(param_01,param_04,self,"long_shot"))
			{
				scripts\cp\_challenge::func_12D9C("long_shot",1);
			}
			return 0;

		case "close_shot":
			if(func_9BBE(param_01,param_04,self,"close_shot"))
			{
				scripts\cp\_challenge::func_12D9C("close_shot",1);
			}
			return 0;

		case "jump_shot":
			if(isdefined(param_01) && isplayer(param_01) && isdefined(param_04))
			{
				if(((isdefined(self.var_A64E) && param_01 == self.var_A64E) || param_04 == param_01 getcurrentweapon()) && !param_01 isonground())
				{
					scripts\cp\_challenge::func_12D9C("jump_shot",1);
				}
	
				return 0;
			}
	
			break;

		case "kill_marked":
			if(isdefined(self.var_B36D) && param_03 != "MOD_SUICIDE")
			{
				scripts\cp\_challenge::func_12D9C("kill_marked",1);
			}
			else if(param_03 != "MOD_SUICIDE" || isdefined(self.var_B36D) && param_03 == "MOD_SUICIDE")
			{
				scripts\cp\_challenge::func_12D9C("kill_marked",0,1);
			}
			return 0;

		case "kill_melee":
			if(isdefined(param_01) && isplayer(param_01) && param_03 == "MOD_MELEE" || param_04 == "iw7_axe_zm" || param_04 == "iw7_axe_zm_pap1" || param_04 == "iw7_axe_zm_pap2")
			{
				scripts\cp\_challenge::func_12D9C("kill_melee",1);
			}
			return 0;

		case "kill_nodamage":
			if(isdefined(param_01) && isplayer(param_01))
			{
				scripts\cp\_challenge::func_12D9C("kill_nodamage",1);
			}
			return 0;

		case "kill_headshots":
			if(scripts\cp\_utility::func_9E27(param_04,param_06,param_03,param_01) && !isdefined(self.var_B36E))
			{
				scripts\cp\_challenge::func_12D9C("kill_headshots",1);
			}
			return 0;

		case "kill_crawlers":
			if(scripts\cp\_utility::func_9D20() && self.var_9BAC)
			{
				scripts\cp\_challenge::func_12D9C("kill_crawlers",1);
			}
			return 0;

		case "kill_before_enter":
			if(scripts\cp\_utility::func_9D20() && !self.entered_playspace)
			{
				scripts\cp\_challenge::func_12D9C("kill_before_enter",1);
			}
			return 0;

		case "multikills":
			if(!isdefined(param_01))
			{
				return 0;
			}
	
			if(!isdefined(param_01.lastkilltime) || !isdefined(param_01.lastmultikilltime))
			{
				return 0;
			}
	
			if(gettime() != param_01.lastkilltime)
			{
				param_01.lastkilltime = gettime();
				return 0;
			}
			else if(gettime() == param_01.lastkilltime && param_01.lastmultikilltime != gettime())
			{
				scripts\cp\_challenge::func_12D9C("multikills",1);
				param_01.lastmultikilltime = gettime();
				param_01.lastkilltime = gettime() + 50;
				return 0;
			}
			return 0;

		case "area_kills":
			if(isdefined(level.var_3C11))
			{
				if(isdefined(param_01) && isplayer(param_01))
				{
					if(distancesquared(param_01.origin,level.var_3C11.origin) < level.var_3C11.var_257)
					{
						scripts\cp\_challenge::func_12D9C("area_kills",1);
					}
				}
			}
			return 0;

		case "kill_zombiewhodamagedme":
			if(!isplayer(param_01))
			{
				return 0;
			}
	
			if(scripts\common\utility::func_2286(self.var_4D3C,param_01))
			{
				scripts\cp\_challenge::func_12D9C("kill_zombiewhodamagedme",1);
			}
	
			break;
	}

	return 1;
}

//Function Number: 34
func_9BBE(param_00,param_01,param_02,param_03)
{
	if(isplayer(param_00) && isalive(param_00) && !param_00 scripts\cp\_utility::func_9FC6())
	{
		if(param_03 == "long_shot")
		{
			return distancesquared(param_00.origin,param_02.origin) >= 90000;
		}
		else if(param_03 == "close_shot")
		{
			return distancesquared(param_00.origin,param_02.origin) <= 90000;
		}
	}

	return 0;
}

//Function Number: 35
func_E068()
{
	level endon("game_ended");
	self waittill("death");
	if(isdefined(self.var_B36D))
	{
		scripts\cp\_outline::func_5560(self);
	}
}

//Function Number: 36
func_15D9()
{
	level thread func_7744(self,1);
}

//Function Number: 37
func_12DF3(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(scripts\common\utility::flag("pause_challenges"))
	{
		return;
	}

	self.var_111AE = 0;
	scripts\cp\_challenge::func_4DAE();
}

//Function Number: 38
func_15DA()
{
	level thread func_7744(self,1);
}

//Function Number: 39
func_12DF4(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	if(scripts\common\utility::flag("pause_challenges"))
	{
		return;
	}

	self.var_111AE = 0;
	scripts\cp\_challenge::func_4DAE();
}

//Function Number: 40
func_15E1()
{
	scripts\cp\_challenge::func_5010();
	var_00 = [];
	foreach(var_02 in level.players)
	{
		if(isalive(var_02) && !scripts\cp\_laststand::player_in_laststand(var_02))
		{
			var_00[var_00.size] = var_02;
		}
	}

	var_04 = scripts\common\utility::random(var_00);
	var_05 = getsubstr(var_04.var_134FD,1,2);
	var_05 = int(var_05) - 1;
	foreach(var_02 in level.players)
	{
		var_07 = var_04 getentitynumber();
		var_02 setclientomnvar("ui_intel_target_player",var_05);
	}

	level.var_4B53 = var_05;
	level thread func_7744(self,1);
	func_B280(var_04);
	level thread func_13981(var_04,self);
	level thread func_DAA0(var_04);
}

//Function Number: 41
func_13981(param_00,param_01)
{
	level endon("challenge_deactivated");
	param_00 scripts\common\utility::waittill_any_3("death","last_stand","disconnect");
	if(isdefined(param_00.var_6647))
	{
		param_00 func_E035();
	}

	param_01.var_111AE = 0;
	func_12E19();
}

//Function Number: 42
func_12E19()
{
	if(scripts\common\utility::flag("pause_challenges"))
	{
		return;
	}

	scripts\cp\_challenge::func_4DAE();
	foreach(var_01 in level.players)
	{
		var_01 setclientomnvar("ui_intel_target_player",-1);
	}

	level.var_4B53 = -1;
}

//Function Number: 43
func_E035()
{
	foreach(var_01 in self.var_6647)
	{
		if(!isdefined(var_01))
		{
			continue;
		}

		var_01 destroy();
	}

	foreach(var_01 in self.var_DAA2)
	{
		if(isdefined(var_01))
		{
			var_01 destroy();
			var_01 scripts\cp\zombies\zombie_afterlife_arcade::func_E01E(var_01.var_222,var_01);
		}
	}
}

//Function Number: 44
func_4DCC()
{
	level notify("deactivate_protect_player_challenge");
	scripts\cp\_challenge::func_5010();
	foreach(var_01 in level.players)
	{
		if(isdefined(var_01.var_6647))
		{
			var_01 func_E035();
		}
	}
}

//Function Number: 45
func_B280(param_00)
{
	var_01 = 0;
	if(param_00.var_134FD != "p5_")
	{
		return;
	}
	else
	{
		foreach(var_03 in level.players)
		{
			if(var_03 == param_00)
			{
				continue;
			}
			else if(var_03.var_134FD == "p5_")
			{
				var_01 = 1;
			}
		}
	}

	if(!var_01)
	{
		return;
	}

	param_00.var_DAA2 = [];
	foreach(var_03 in level.players)
	{
		func_B27F(var_03,param_00);
	}
}

//Function Number: 46
func_B27F(param_00,param_01)
{
	var_02 = param_01 scripts\cp\_utility::func_F73D(param_00,"cp_hud_song_widget",(0,0,72),4,4,undefined,undefined,undefined,1,undefined,0);
	var_02 scripts\cp\zombies\zombie_afterlife_arcade::func_1766(param_00,var_02);
	var_02.var_222 = param_00;
	param_01.var_DAA2[param_01.var_DAA2.size] = var_02;
	if(scripts\common\utility::istrue(param_00.in_afterlife_arcade))
	{
		var_02.alpha = 0;
	}
}

//Function Number: 47
func_DAA0(param_00)
{
	level endon("game_ended");
	level endon("deactivate_protect_player_challenge");
	for(;;)
	{
		level waittill("connected",var_01);
		var_01 thread func_50C2(var_01,param_00);
	}
}

//Function Number: 48
func_50C2(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_01 endon("disconnect");
	scripts\common\utility::func_136F7();
	if(scripts\cp\_challenge::func_4B4D("protect_player"))
	{
		param_00 func_B27F(param_00,param_01);
	}
}

//Function Number: 49
func_88C0()
{
	self endon("disconnect");
	wait(5);
	self setclientomnvar("ui_intel_prechallenge",level.var_4B4F);
	if(scripts\cp\_challenge::func_4B4B())
	{
		self setclientomnvar("ui_intel_active_index",int(level.var_4B4C));
		self setclientomnvar("ui_intel_progress_current",int(level.var_4B50));
		self setclientomnvar("ui_intel_progress_max",int(level.var_4B51));
		self setclientomnvar("ui_intel_percent",int(level.var_4B4E));
		self setclientomnvar("ui_intel_target_player",int(level.var_4B53));
		self setclientomnvar("ui_intel_title",int(level.var_4B55));
		if(level.var_4B54 > 0 && !scripts\common\utility::flag("pause_challenges"))
		{
			self setclientomnvar("ui_intel_timer",int(gettime() + level.var_4B54 * 1000));
		}

		self setclientomnvar("ui_intel_challenge_scalar",level.var_4B52);
		self setclientomnvar("ui_intel_active_index",int(level.var_4B4C));
		var_00 = level.var_4BD3;
		if(!scripts\common\utility::flag("pause_challenges"))
		{
			var_00 = 10;
		}

		self setclientomnvar("zm_show_challenge",var_00);
	}

	if(level.var_4B4A == "kill_nodamage")
	{
		thread func_A5F8();
	}
}

//Function Number: 50
pause_challenge_func()
{
	if(!isdefined(level.var_4B4A))
	{
		return;
	}

	if(level.var_4B4A == "area_kills")
	{
		level.var_2132 delete();
		scripts\common\utility::func_6E5A("pause_challenges");
		level.var_2132 = spawnfx(level._effect["challenge_ring"],level.var_3C11.origin + (0,0,5),anglestoforward((0,0,0)),anglestoup((0,0,0)));
		wait(0.25);
		triggerfx(level.var_2132);
		return;
	}

	if(level.var_4B4A == "kill_zombiewhodamagedme")
	{
		foreach(var_01 in scripts\mp\_mp_agent::func_7DB0("axis"))
		{
			if(scripts\common\utility::istrue(var_01.var_B36D))
			{
				if(isdefined(var_01.var_4D3C))
				{
					foreach(var_03 in var_01.var_4D3C)
					{
						scripts\cp\_outline::func_5561(var_01,var_03);
					}
				}

				var_01.var_4D3C = [];
				var_01.var_B36D = undefined;
			}
		}
	}
}