/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\cp_vo.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 55
 * Decompile Time: 2746 ms
 * Timestamp: 10/27/2023 12:10:02 AM
*******************************************************************/

//Function Number: 1
func_98EA()
{
	level.var_134FE = ["highest","high","medium","low"];
	level.var_134B4 = [];
	level.var_134BF = [];
	level.var_134C0 = [];
	level.var_134CA = [];
	level.var_13519 = "cp/" + getdvar("ui_mapname") + "_vo_table.csv";
	level thread func_C904();
	level thread func_BE3E();
}

//Function Number: 2
func_97CC()
{
	func_97A1();
	thread func_10D5B();
	level thread game_ended_vo_watcher();
}

//Function Number: 3
func_97A1()
{
	var_00 = spawnstruct();
	var_00.var_134C6 = undefined;
	var_00.var_9A89 = undefined;
	var_00.var_9C80 = 0;
	var_01 = [];
	foreach(var_03 in level.var_134FE)
	{
		var_01[var_03] = [];
	}

	var_00.var_134FF = var_01;
	self.var_13516 = var_00;
	scripts\common\utility::flag_init("vo_system_busy");
}

//Function Number: 4
func_C904()
{
	var_00 = level.var_13519;
	var_01 = 1;
	for(;;)
	{
		var_02 = tablelookupbyrow(var_00,var_01,0);
		if(var_02 == "")
		{
			break;
		}

		var_03 = tablelookupbyrow(var_00,var_01,1);
		var_04 = int(tablelookupbyrow(var_00,var_01,2));
		var_05 = int(tablelookupbyrow(var_00,var_01,3));
		var_06 = int(tablelookupbyrow(var_00,var_01,4));
		var_07 = tablelookupbyrow(var_00,var_01,5);
		var_08 = tablelookupbyrow(var_00,var_01,6);
		var_09 = tablelookupbyrow(var_00,var_01,7);
		var_0A = tablelookupbyrow(var_00,var_01,8);
		var_0B = tablelookupbyrow(var_00,var_01,9);
		var_0C = int(tablelookupbyrow(var_00,var_01,10));
		var_0D = int(tablelookupbyrow(var_00,var_01,11));
		var_0E = tablelookupbyrow(var_00,var_01,12);
		var_0F = int(tablelookupbyrow(var_00,var_01,13));
		var_10 = tablelookupbyrow(var_00,var_01,15);
		var_11 = int(tablelookupbyrow(var_00,var_01,16));
		var_12 = int(tablelookupbyrow(var_00,var_01,17));
		func_DEDE(var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E,var_0F,var_10,var_11,var_12);
		if(var_01 % 5 == 1)
		{
			wait(0.05);
		}

		var_01++;
	}
}

//Function Number: 5
func_DEDE(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D,param_0E,param_0F,param_10)
{
	var_11 = spawnstruct();
	if(isdefined(param_02) && param_02 > 0)
	{
		var_11.var_4613 = param_02;
		var_11.var_A9CE = 0;
	}

	if(isdefined(param_0D) && param_0D > 0)
	{
		var_11.var_C9CA = param_0D;
	}

	if(scripts\common\utility::istrue(param_0A))
	{
		var_11.var_C555 = 1;
	}
	else
	{
		var_11.var_C555 = 0;
	}

	if(isdefined(param_0B) && param_0B > 0)
	{
		var_11.var_32A0 = param_0B;
	}

	if(isdefined(param_0C))
	{
		var_11.priority = param_0C;
	}

	if(isdefined(param_04) && param_04 > 0)
	{
		var_11.var_B44F = param_04;
	}

	if(isdefined(param_03) && param_03 > 0)
	{
		var_11.var_3C39 = param_03;
	}

	if(isdefined(param_07) && param_07 != "")
	{
		var_11.var_1383B = param_07;
	}

	if(isdefined(param_05) && param_05 != "")
	{
		if(!isdefined(level.var_134BF[param_05]))
		{
			level.var_134BF[param_05] = [];
		}

		var_11.var_3B96 = param_05;
		level.var_134BF[param_05][level.var_134BF[param_05].size] = param_01;
		if(!isdefined(level.var_134C0[param_05]))
		{
			level.var_134C0[param_05] = 0;
		}
	}

	if(isdefined(param_06) && param_06 != "")
	{
		if(!isdefined(level.var_134BF[param_06]))
		{
			level.var_134BF[param_06] = [];
		}

		var_11.var_3B97 = param_06;
		level.var_134BF[param_06][level.var_134BF[param_06].size] = param_01;
		if(!isdefined(level.var_134C0[param_06]))
		{
			level.var_134C0[param_06] = 0;
		}
	}

	if(isdefined(param_08) && param_08 != "")
	{
		if(!isdefined(level.var_134CA[param_08]))
		{
			level.var_134CA[param_08] = [];
		}

		var_11.var_54AA = param_08;
		level.var_134CA[param_01] = param_08;
	}

	if(isdefined(param_09) && param_09 != "")
	{
		var_11.var_BF7B = param_09;
	}

	if(isdefined(param_0E))
	{
		var_11.var_18E3 = param_0E;
	}

	if(isdefined(param_0F))
	{
		var_11.pap_approval = param_0F;
	}

	if(isdefined(param_10))
	{
		var_11.rave_approval = param_10;
	}

	level.var_134B4[param_01] = var_11;
}

//Function Number: 6
func_10D5B()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		if(func_9D13())
		{
			if(scripts\common\utility::func_6E34("vo_system_busy"))
			{
				scripts\common\utility::func_6E5A("vo_system_busy");
			}
		}

		var_00 = func_7D4E();
		if(!isdefined(var_00))
		{
			func_F60D(0);
			self waittill("play_VO_system");
			if(func_9D14())
			{
				self waittill("unpause_VO_system");
			}

			continue;
		}

		func_CE8B(var_00);
	}
}

//Function Number: 7
func_CE8B(param_00,param_01)
{
	self endon("disconnect");
	func_F60D(1);
	func_F60B(param_00);
	func_CE77(param_00,param_01);
	func_C9B8(param_00);
	func_12C63();
}

//Function Number: 8
func_7D4E()
{
	var_00 = func_E409();
	if(isdefined(var_00))
	{
		return var_00;
	}

	foreach(var_02 in level.var_134FE)
	{
		var_00 = func_E40A(var_02);
		if(isdefined(var_00))
		{
			return var_00;
		}
	}

	return undefined;
}

//Function Number: 9
func_E409()
{
	var_00 = self.var_13516.var_9A89;
	func_E1F9();
	return var_00;
}

//Function Number: 10
func_E1F9()
{
	self.var_13516.var_9A89 = undefined;
}

//Function Number: 11
func_E40A(param_00)
{
	func_E009(param_00);
	return func_D659(param_00);
}

//Function Number: 12
func_D659(param_00)
{
	var_01 = self.var_13516.var_134FF[param_00][0];
	if(!isdefined(var_01))
	{
		return var_01;
	}

	var_02 = [];
	for(var_03 = 1;var_03 < self.var_13516.var_134FF[param_00].size;var_03++)
	{
		if(!isdefined(self.var_13516.var_134FF[param_00][var_03]))
		{
			break;
		}

		var_02[var_03 - 1] = self.var_13516.var_134FF[param_00][var_03];
	}

	self.var_13516.var_134FF[param_00] = var_02;
	return var_01;
}

//Function Number: 13
func_E009(param_00)
{
	var_01 = gettime();
	var_02 = [];
	foreach(var_05, var_04 in self.var_13516.var_134FF[param_00])
	{
		if(!func_134D5(var_04,var_01))
		{
			var_02[var_02.size] = self.var_13516.var_134FF[param_00][var_05];
			continue;
		}
	}

	self.var_13516.var_134FF[param_00] = var_02;
}

//Function Number: 14
func_134D5(param_00,param_01)
{
	return param_01 > param_00.var_698A;
}

//Function Number: 15
func_F60D(param_00)
{
	self.var_13516.var_9C80 = param_00;
}

//Function Number: 16
func_9D14()
{
	return scripts\common\utility::istrue(self.var_C9CB);
}

//Function Number: 17
func_9D13()
{
	return scripts\common\utility::flag("vo_system_busy");
}

//Function Number: 18
func_F60C(param_00)
{
	level.var_13517 = param_00;
	if(!param_00)
	{
		scripts\common\utility::func_6E2A("vo_system_busy");
		return;
	}

	scripts\common\utility::flag_set("vo_system_busy");
}

//Function Number: 19
func_F60B(param_00)
{
	self.var_13516.var_134C6 = param_00;
}

//Function Number: 20
game_ended_vo_watcher()
{
	var_00 = "";
	level scripts\common\utility::waittill_any_3("game_ended");
	foreach(var_02 in level.players)
	{
		foreach(var_04 in level.var_134FE)
		{
			if(isdefined(var_02.var_13516.var_134FF[var_04]) && var_02.var_13516.var_134FF[var_04].size > 0)
			{
				foreach(var_06 in var_02.var_13516.var_134FF[var_04])
				{
					if(isdefined(var_06))
					{
						if(soundexists(var_06.var_1B46))
						{
							var_02 stoplocalsound(var_06.var_1B46);
						}
					}
				}

				var_02.var_13516.var_134FF[var_04] = [];
			}
		}

		if(isdefined(level.var_540D) && level.var_540D.size > 0)
		{
			foreach(var_0A in level.var_540D)
			{
				if(issubstr(var_0A,"pg_"))
				{
					var_02 stoplocalsound(var_0A);
				}

				if(soundexists(var_02.var_134FD + var_0A))
				{
					var_02 stoplocalsound(var_02.var_134FD + var_0A);
				}

				if(soundexists(var_02.var_134FD + "plr_" + var_0A))
				{
					var_02 stoplocalsound(var_02.var_134FD + "plr_" + var_0A);
				}
			}
		}

		if(isdefined(var_02.current_vo_queue) && var_02.current_vo_queue.size > 0)
		{
			foreach(var_0D in var_02.current_vo_queue)
			{
				if(isdefined(var_0D))
				{
					if(soundexists(var_0D))
					{
						var_02 stoplocalsound(var_0D);
						continue;
					}

					if(soundexists(var_02.var_134FD + var_0D))
					{
						var_02 stoplocalsound(var_02.var_134FD + var_0D);
						continue;
					}

					if(soundexists(var_02.var_134FD + "plr_" + var_0D))
					{
						var_02 stoplocalsound(var_02.var_134FD + "plr_" + var_0D);
					}
				}
			}
		}

		if(!isdefined(var_02.var_134FD))
		{
			return;
		}

		switch(var_02.var_134FD)
		{
			case "p1_":
				var_00 = "_valley_girl";
				break;

			case "p2_":
				var_00 = "_nerd";
				break;

			case "p3_":
				var_00 = "_rapper";
				break;

			case "p4_":
				var_00 = "_jock";
				break;

			case "p5_":
				var_00 = "_jock";
				break;

			case "p6_":
				var_00 = "_jock";
				break;
		}

		if(soundexists("mus_zombies" + var_00))
		{
			var_02 stoplocalsound("mus_zombies" + var_00);
		}

		if(soundexists("mus_zombies" + var_00 + "_lsrs"))
		{
			var_02 stoplocalsound("mus_zombies" + var_00 + "_lsrs");
		}
	}
}

//Function Number: 21
func_CE77(param_00,param_01)
{
	self endon("interrupt_current_VO");
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	if(self.sessionstate != "playing")
	{
		return;
	}

	var_02 = param_00.var_1B46;
	if(!soundexists(var_02))
	{
		wait(0.1);
		return;
	}

	self.var_13518 = 1;
	if(scripts\cp\_utility::func_9C82(self))
	{
		var_03 = scripts\cp\_utility::func_7B64(self);
		if(isdefined(var_03))
		{
			self stoplocalsound(var_03);
		}
	}

	if(isdefined(param_00.var_2896))
	{
		var_04 = param_00.var_2896;
	}
	else
	{
		var_04 = var_04;
	}

	foreach(var_09, var_06 in level.players)
	{
		if(var_06 issplitscreenplayer() && !var_06 issplitscreenplayerprimary())
		{
			continue;
		}

		if(isdefined(var_06.current_vo_queue))
		{
			var_06.current_vo_queue = scripts\common\utility::array_add(var_06.current_vo_queue,var_04);
		}

		if(scripts\common\utility::istrue(var_06.playing_backstory))
		{
			continue;
		}

		if(var_06 == self)
		{
			if(isdefined(level.get_alias_2d_func))
			{
				var_07 = [[ level.get_alias_2d_func ]](var_06,var_02,var_04);
			}
			else
			{
				var_07 = func_77ED(var_09,var_04,var_05);
			}

			if(isdefined(var_07))
			{
				var_06 playlocalsound(var_07);
			}
			else
			{
				var_06 playlocalsound(var_02);
			}

			if(scripts\common\utility::istrue(param_01))
			{
				var_08 = var_07 + var_06.vo_suffix;
				var_06 thread alias_specific_vo(var_08);
			}

			continue;
		}

		if(!scripts\common\utility::istrue(param_00.var_C551))
		{
			self playsoundtoplayer(var_02,var_06);
		}
	}

	foreach(var_0B in param_00.var_3B94)
	{
		level.var_134C0[var_0B] = gettime();
	}

	if(!isdefined(self.var_C1F6[var_04]))
	{
		self.var_C1F6[var_04] = 1;
	}
	else
	{
		self.var_C1F6[var_04]++;
	}

	wait(func_7C76(var_02));
	self notify("play_char_specific_intro");
	self.var_13518 = 0;
}

//Function Number: 22
alias_specific_vo(param_00)
{
	self endon("disconnected");
	level endon("game_ended");
	self endon("death");
	self waittill("play_char_specific_intro");
	self playlocalsound(param_00);
}

//Function Number: 23
func_1B47(param_00,param_01)
{
	var_02 = func_77ED(param_00,param_01);
	return soundexists(var_02);
}

//Function Number: 24
func_77ED(param_00,param_01,param_02)
{
	var_03 = strtok(param_01,"_");
	if(issubstr(param_01,"shen") || issubstr(param_01,"adamson") || issubstr(param_01,"cross") || var_03[0] == "crew1" || var_03[0] == "crew3" || var_03[0] == "crew4")
	{
		return param_01;
	}

	if(var_03[0] == "ww" || var_03[0] == "dj" || var_03[0] == "ks" || var_03[0] == "el")
	{
		return param_01;
	}

	var_04 = param_00.var_134FD + "plr_" + param_02;
	if(soundexists(var_04))
	{
		return var_04;
	}

	return undefined;
}

//Function Number: 25
func_77EE(param_00,param_01)
{
	if(issubstr(param_01,"ww_") || issubstr(param_01,"dj_") || issubstr(param_01,"p1_") || issubstr(param_01,"p2_") || issubstr(param_01,"p3_") || issubstr(param_01,"p4_") || issubstr(param_01,"jaroslav_anc"))
	{
		return param_01;
	}

	var_02 = getsubstr(param_01,param_00.var_134FD.size);
	return param_00.var_134FD + var_02;
}

//Function Number: 26
func_7C76(param_00)
{
	return lookupsoundlength(param_00) / 1000;
}

//Function Number: 27
func_C9B8(param_00)
{
	if(func_9D14())
	{
		self waittill("unpause_VO_system");
	}

	if(param_00.var_C9CA > 0)
	{
		wait(param_00.var_C9CA);
	}
}

//Function Number: 28
func_12C63()
{
	self.var_13516.var_134C6 = undefined;
}

//Function Number: 29
try_to_play_vo_on_all_players(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(level.players))
	{
		return;
	}

	if(!scripts\common\utility::istrue(param_01))
	{
		foreach(var_03 in level.players)
		{
			var_03 thread try_to_play_vo(param_00,"zmb_comment_vo","highest",10,0,0,1,100);
		}

		return;
	}

	foreach(var_03 in level.players)
	{
		var_03 thread func_1769(param_00,"zmb_comment_vo",60,45,6,1);
	}
}

//Function Number: 30
try_to_play_vo(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	var_09 = isdefined(level.var_134B4[param_00]);
	if(var_09)
	{
		if(isdefined(level.var_134B4[param_00].var_3C39))
		{
			param_07 = level.var_134B4[param_00].var_3C39;
		}
	}

	if(!isdefined(param_07))
	{
		param_07 = 100;
	}

	if(randomint(100) > param_07)
	{
		return;
	}

	if(func_FF79(param_00,param_01,param_02,param_03,param_04,param_05,param_06))
	{
		if(var_09 && isdefined(level.var_134B4[param_00].var_C9CA))
		{
			param_05 = level.var_134B4[param_00].var_C9CA;
		}

		if(var_09 && isdefined(level.var_134B4[param_00].var_C555))
		{
			param_06 = level.var_134B4[param_00].var_C555;
		}

		var_0A = func_788D(param_00);
		foreach(var_0C in var_0A)
		{
			level.var_134C0[var_0C] = gettime();
		}

		if(var_09 && isdefined(level.var_134B4[param_00].var_32A0))
		{
			param_03 = level.var_134B4[param_00].var_32A0;
		}

		if(var_09 && isdefined(level.var_134B4[param_00].priority))
		{
			param_02 = level.var_134B4[param_00].priority;
		}

		if(var_09 && isdefined(level.var_134B4[param_00].var_A9CE))
		{
			level.var_134B4[param_00].var_A9CE = gettime();
		}

		thread func_1781(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_08);
	}
}

//Function Number: 31
func_FF79(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(scripts\common\utility::istrue(self.var_C9CB))
	{
		return 0;
	}

	if(!isdefined(level.var_134B4[param_00]))
	{
		return 1;
	}

	if(scripts\cp\zombies\zombie_afterlife_arcade::func_9C10(self))
	{
		if(isdefined(level.var_18E8))
		{
			if(![[ level.var_18E8 ]](param_00))
			{
				return 0;
			}
		}
	}

	if(scripts\common\utility::istrue(self.var_DCEB))
	{
		if(isdefined(level.rave_vo_approve_func))
		{
			if(isplayer(self))
			{
				if(!self [[ level.rave_vo_approve_func ]](param_00))
				{
					return 0;
				}
			}
		}
	}

	if(isdefined(level.pap_vo_approve_func))
	{
		if(isplayer(self))
		{
			if(!self [[ level.pap_vo_approve_func ]](param_00))
			{
				return 0;
			}
		}
	}

	var_07 = gettime();
	if(isdefined(level.var_134B4[param_00].var_4613) && isdefined(level.var_134B4[param_00].var_A9CE))
	{
		if(var_07 < level.var_134B4[param_00].var_A9CE + level.var_134B4[param_00].var_4613 * 1000)
		{
			return 0;
		}
	}

	var_08 = func_788D(param_00);
	foreach(var_0A in var_08)
	{
		var_0B = scripts\common\utility::func_116D7(isdefined(level.var_134B4[param_00].var_4613),level.var_134B4[param_00].var_4613,30);
		if(var_07 < level.var_134C0[var_0A] + var_0B * 1000)
		{
			return 0;
		}
	}

	if(isdefined(level.var_134B4[param_00].var_B44F))
	{
		if(!isdefined(self.var_C1F6))
		{
			self.var_C1F6 = [];
		}

		if(!isdefined(self.var_C1F6[param_00]))
		{
			self.var_C1F6[param_00] = 0;
		}

		if(self.var_C1F6[param_00] < level.var_134B4[param_00].var_B44F)
		{
			return 1;
		}

		return 0;
	}

	return 1;
}

//Function Number: 32
func_788D(param_00)
{
	if(!isdefined(level.var_134BF))
	{
		return [];
	}

	var_01 = getarraykeys(level.var_134BF);
	var_02 = [];
	foreach(var_04 in var_01)
	{
		if(scripts\common\utility::func_2286(level.var_134BF[var_04],param_00))
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 33
func_FF12(param_00)
{
	if(issubstr(param_00,"ww_") || issubstr(param_00,"dj_") || issubstr(param_00,"jaroslav_anc"))
	{
		return 0;
	}

	return 1;
}

//Function Number: 34
should_append_player_suffix(param_00,param_01)
{
	if(scripts\common\utility::istrue(param_01))
	{
		if(issubstr(param_00,"ww_") && issubstr(param_00,"_p"))
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}

	return 0;
}

//Function Number: 35
func_1781(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	if(isplayer(self))
	{
		if(isdefined(param_01) && isdefined(level.var_134DC[param_01]))
		{
			if(isdefined(param_07))
			{
				self thread [[ level.var_134DC[param_01] ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07);
			}
			else
			{
				self thread [[ level.var_134DC[param_01] ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06);
			}

			return;
		}

		var_08 = self.var_134FD + param_00;
		thread func_CE8A(var_08,param_02,param_03,param_04,param_05,param_06,param_00);
		return;
	}

	if(isdefined(param_02) && isdefined(level.var_134DC[param_02]))
	{
		if(isdefined(var_08))
		{
			self thread [[ level.var_134DC[param_02] ]](param_01,param_02,param_03,param_04,param_05,param_06,param_07,var_08);
		}
		else
		{
			self thread [[ level.var_134DC[param_02] ]](param_01,param_02,param_03,param_04,param_05,param_06,param_07);
		}

		return;
	}

	var_08 = param_01;
	level thread func_CE89(var_08,param_02,param_03,param_04,param_05,param_06,param_00);
}

//Function Number: 36
func_CE89(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	foreach(var_08 in level.players)
	{
		var_08 func_1782(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
	}
}

//Function Number: 37
func_CE8A(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	func_1782(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 38
func_1782(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(self.current_vo_queue))
	{
		self.current_vo_queue = [];
	}

	thread func_1783(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 39
func_1783(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	param_01 = func_7D3E(param_01);
	var_07 = func_4978(param_00,param_02,param_04,param_05,param_06);
	if(func_FF5B(param_03))
	{
		func_1767(var_07);
		if(func_9D15())
		{
			func_9A85();
		}
	}
	else
	{
		func_1777(var_07,param_01);
	}

	if(!func_9D15())
	{
		func_C14E();
	}
}

//Function Number: 40
func_7D3E(param_00)
{
	if(!isdefined(param_00))
	{
		return level.var_134FE[level.var_134FE.size - 1];
	}

	return param_00;
}

//Function Number: 41
func_4978(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 999;
	var_06 = 1.5;
	var_07 = 3;
	var_08 = spawnstruct();
	var_08.var_1B46 = param_00;
	var_08.var_3B94 = func_788D(param_00);
	var_08.var_2896 = param_04;
	if(!isdefined(param_01))
	{
		param_01 = var_05;
	}

	var_08.var_698A = gettime() + param_01 * 1000;
	if(!isdefined(param_02))
	{
		param_02 = randomfloatrange(var_06,var_07);
	}

	var_08.var_C9CA = param_02;
	if(scripts\common\utility::istrue(param_03))
	{
		var_08.var_C551 = 1;
	}
	else
	{
		var_08.var_C551 = 0;
	}

	return var_08;
}

//Function Number: 42
func_FF5B(param_00)
{
	return isdefined(param_00) && param_00;
}

//Function Number: 43
func_1767(param_00)
{
	self.var_13516.var_9A89 = param_00;
}

//Function Number: 44
func_9D15()
{
	return scripts\common\utility::istrue(self.var_13516.var_9C80);
}

//Function Number: 45
func_9A85()
{
	var_00 = func_790D();
	if(isdefined(var_00))
	{
		self stoplocalsound(var_00);
	}

	self notify("interrupt_current_VO");
}

//Function Number: 46
func_790D()
{
	if(isdefined(self.var_13516))
	{
		if(isdefined(self.var_13516.var_134C6))
		{
			if(isdefined(self.var_13516.var_134C6.var_1B46))
			{
				return self.var_13516.var_134C6.var_1B46;
			}
		}
	}

	return undefined;
}

//Function Number: 47
func_1777(param_00,param_01)
{
	self.var_13516.var_134FF[param_01][self.var_13516.var_134FF[param_01].size] = param_00;
}

//Function Number: 48
func_C14E()
{
	self notify("play_VO_system");
}

//Function Number: 49
func_E0A9(param_00,param_01)
{
	var_02 = [];
	foreach(var_05, var_04 in self.var_13516.var_134FF[param_01])
	{
		if(!var_04.var_1B46 == self.var_134FD + param_00 || var_04.var_1B46 == self.var_134FD + "plr_" + param_00)
		{
			var_02[var_02.size] = self.var_13516.var_134FF[param_01][var_05];
		}
	}

	self.var_13516.var_134FF[param_01] = var_02;
}

//Function Number: 50
func_C9CB(param_00)
{
	if(param_00.size == 1)
	{
		param_00[0].var_C9CB = 1;
		return;
	}

	foreach(var_02 in param_00)
	{
		var_02.var_C9CB = 1;
	}
}

//Function Number: 51
func_12BE3(param_00)
{
	foreach(var_02 in param_00)
	{
		var_02.var_C9CB = 0;
	}

	foreach(var_02 in param_00)
	{
		var_02 notify("unpause_VO_system");
	}
}

//Function Number: 52
func_BE3E()
{
	level endon("game_ended");
	if(!isdefined(level.var_BE3D))
	{
		level.var_BE3D = [];
		level.var_BE3F = [];
		level.var_C9C1 = 0;
	}

	var_00 = 60;
	for(;;)
	{
		while(level.var_C9C1)
		{
			wait(0.1);
		}

		var_01 = gettime();
		foreach(var_04, var_03 in level.var_BE3D)
		{
			if(var_01 > var_03.var_BF53)
			{
				if(isdefined(var_03.var_EC12))
				{
					var_03.var_EC12 try_to_play_vo(var_04,var_03.var_1351C,"low",3,0,0,var_03.var_C551);
				}
				else
				{
					level try_to_play_vo(var_04,var_03.var_1351C,"low",3,0,0,var_03.var_C551);
				}

				var_03.var_11923++;
				if(var_03.var_B468 != -1 && var_03.var_B468 <= var_03.var_11923)
				{
					func_E01F(var_04);
				}

				var_03.var_BF53 = var_01 + var_03.var_4613 * min(var_03.var_11923,3) * 1000;
				wait(var_00);
			}
		}

		wait(1);
	}
}

//Function Number: 53
func_1769(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(level.var_BE3D))
	{
		level.var_BE3D = [];
		level.var_BE3F = [];
		level.var_C9C1 = 0;
	}

	if(isdefined(level.var_BE3D[param_00]))
	{
		return;
	}

	if(isdefined(level.var_BE3F[param_00]))
	{
		return;
	}

	if(!isdefined(param_02))
	{
		param_02 = 60;
	}

	if(!isdefined(param_01))
	{
		param_01 = "zmb_comment_vo";
	}

	var_06 = undefined;
	if(isplayer(self))
	{
		var_06 = self;
	}

	var_07 = spawnstruct();
	var_07.var_11923 = 0;
	var_07.var_4613 = param_02;
	var_07.var_1351C = param_01;
	if(isdefined(var_06))
	{
		var_07.var_EC12 = var_06;
	}

	if(isdefined(param_05))
	{
		var_07.var_C551 = param_05;
	}
	else
	{
		var_07.var_C551 = 0;
	}

	if(isdefined(param_03))
	{
		var_07.var_BF53 = gettime() + param_03 * 1000;
	}
	else
	{
		var_07.var_BF53 = 0;
	}

	if(isdefined(param_04))
	{
		var_07.var_B468 = param_04;
	}
	else
	{
		var_07.var_B468 = -1;
	}

	level.var_BE3D[param_00] = var_07;
}

//Function Number: 54
func_E01F(param_00,param_01)
{
	level.var_BE3D = scripts\cp\_utility::func_22B0(level.var_BE3D,param_00,1);
	if(scripts\common\utility::istrue(param_01))
	{
		level.var_BE3F[param_00] = 1;
	}
}

//Function Number: 55
func_11908(param_00,param_01)
{
	level endon(param_00 + "_about_to_play");
	wait(param_01);
	level.var_2001 = 0;
	level notify(param_00 + "_timed_out");
}