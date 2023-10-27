/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_weaponrank.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 962 ms
 * Timestamp: 10/27/2023 12:22:16 AM
*******************************************************************/

//Function Number: 1
init()
{
	func_AEB1();
	var_00 = getdvarint("online_mp_weapon_xpscale",1);
	func_17CB(var_00,"online_mp_weapon_xpscale");
	level thread func_C56E();
}

//Function Number: 2
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(!isai(var_00))
		{
			if(var_00 scripts\mp\_utility::func_DCD5())
			{
				var_01 = getdvarint("online_mp_party_weapon_xpscale");
				var_02 = var_00 method_85BE() > 1;
				if(var_02)
				{
					var_00 func_186A(var_01,"online_mp_party_weapon_xpscale");
				}
			}
		}
	}
}

//Function Number: 3
func_AEB1()
{
	level.var_13CBD = spawnstruct();
	level.var_13CBD.var_DCD4 = [];
	var_00 = 0;
	for(;;)
	{
		var_01 = int(tablelookuprownum("mp/weaponRankTable.csv",0,var_00));
		if(!isdefined(var_01) || var_01 < 0)
		{
			break;
		}

		var_02 = spawnstruct();
		level.var_13CBD.var_DCD4[var_00] = var_02;
		var_02.var_B7CF = int(tablelookupbyrow("mp/weaponRankTable.csv",var_00,1));
		var_02.var_13E29 = int(tablelookupbyrow("mp/weaponRankTable.csv",var_00,2));
		var_02.var_B4D6 = int(tablelookupbyrow("mp/weaponRankTable.csv",var_00,3));
		var_00++;
	}

	level.var_13CBD.var_B4C0 = var_00 - 1;
	level.var_13CBD.var_B4D4 = [];
	var_03 = 1;
	for(;;)
	{
		var_01 = int(tablelookuprownum("mp/statstable.csv",0,var_03));
		if(!isdefined(var_01) || var_01 < 0)
		{
			break;
		}

		var_04 = tablelookupbyrow("mp/statstable.csv",var_01,4);
		var_05 = tablelookupbyrow("mp/statstable.csv",var_01,42);
		if(!isdefined(var_04) || var_04 == "" || !isdefined(var_05) || var_05 == "")
		{
		}
		else
		{
			var_05 = int(var_05);
			level.var_13CBD.var_B4D4[var_04] = var_05;
		}

		var_03++;
	}
}

//Function Number: 4
func_8085(param_00)
{
	var_01 = func_8086(param_00);
	var_02 = func_822C(var_01);
	return var_02;
}

//Function Number: 5
func_8086(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "all";
	}

	switch(param_01)
	{
		case "mp":
			var_02 = self getplayerdata("common","sharedProgression","weaponLevel",param_00,"mpXP");
			return var_02;

		case "cp":
			var_03 = self getplayerdata("common","sharedProgression","weaponLevel",param_01,"cpXP");
			return var_03;

		case "all":
			var_02 = self getplayerdata("common","sharedProgression","weaponLevel",var_02,"mpXP");
			var_03 = self getplayerdata("common","sharedProgression","weaponLevel",param_01,"cpXP");
			return var_02 + var_03;
	}
}

//Function Number: 6
func_9EFF(param_00)
{
	var_01 = func_8086(param_00);
	var_02 = func_8227(param_00);
	return var_01 >= var_02;
}

//Function Number: 7
func_13CCA(param_00)
{
	if(!self isitemunlocked("cac","feature"))
	{
		return 0;
	}

	var_01 = scripts\mp\_utility::func_8234(param_00);
	return func_13C97(var_01);
}

//Function Number: 8
func_13C97(param_00)
{
	if(!isdefined(level.var_13CBD.var_B4D4[param_00]))
	{
		return 0;
	}

	return level.var_13CBD.var_B4D4[param_00] > 0;
}

//Function Number: 9
func_8227(param_00)
{
	var_01 = func_7FA5(param_00);
	return func_822D(var_01);
}

//Function Number: 10
func_822C(param_00)
{
	if(param_00 == 0)
	{
		return 0;
	}

	for(var_01 = func_7FA4() - 1;var_01 >= 0;var_01--)
	{
		if(param_00 >= func_822E(var_01))
		{
			return var_01;
		}
	}

	return var_01;
}

//Function Number: 11
func_7FA6(param_00)
{
	var_01 = scripts\mp\_utility::func_8234(param_00);
	return func_7FA5(var_01);
}

//Function Number: 12
func_7FA5(param_00)
{
	return level.var_13CBD.var_B4D4[param_00];
}

//Function Number: 13
func_7FA4()
{
	return level.var_13CBD.var_B4C0;
}

//Function Number: 14
func_822E(param_00)
{
	return level.var_13CBD.var_DCD4[param_00].var_B7CF;
}

//Function Number: 15
func_8230(param_00)
{
	return level.var_13CBD.var_DCD4[param_00].var_13E29;
}

//Function Number: 16
func_822D(param_00)
{
	return level.var_13CBD.var_DCD4[param_00].var_B4D6;
}

//Function Number: 17
func_8394(param_00,param_01,param_02)
{
	if(isai(self) || !isplayer(self) || !isdefined(param_02) || param_02 == 0 || !scripts\mp\_utility::func_DCD5())
	{
		return;
	}

	var_03 = scripts\mp\_utility::func_8234(param_00);
	if(!self isitemunlocked(var_03,"weapon"))
	{
		return;
	}

	if(!func_13C97(var_03))
	{
		return;
	}

	var_04 = func_DF69(param_01);
	if(var_04 != param_01)
	{
		param_01 = var_04;
		param_02 = scripts\mp\_rank::func_8104(param_01);
	}

	if(param_02 < 0)
	{
		return;
	}

	var_05 = param_02;
	param_02 = param_02 * func_8233();
	param_02 = int(param_02);
	if(param_02 > func_8227(var_03))
	{
		return;
	}

	var_06 = func_8086(var_03,"mp");
	var_07 = func_8086(var_03,"cp");
	var_08 = var_06 + var_07;
	var_09 = func_822C(var_08);
	var_0A = func_8227(var_03);
	var_0B = var_0A - var_07;
	var_0C = var_06 + param_02;
	if(var_0C > var_0B)
	{
		var_0C = var_0B;
	}

	var_0D = var_0C + var_07;
	var_0E = func_7FA5(var_03);
	var_0F = self getplayerdata("common","sharedProgression","weaponLevel",var_03,"prestige");
	var_10 = int(min(func_822C(var_0D),var_0E));
	scripts\mp\_analyticslog::func_AFA1(param_00,var_0F,var_10,param_02,param_01);
	self setplayerdata("common","sharedProgression","weaponLevel",var_03,"mpXP",var_0C);
	var_11 = function_02C4(param_00);
	scripts\mp\_matchdata::func_AFDC(var_03,"xp",param_02,var_11);
	if(var_09 < var_10)
	{
		scripts\mp\_hud_message::func_10151("ranked_up_weapon_" + var_03,var_10 + 1);
		var_12 = "weapon_rank_up_0_4";
		if(var_10 >= 15)
		{
			var_12 = "weapon_rank_up_15_plus";
		}
		else if(var_10 >= 10)
		{
			var_12 = "weapon_rank_up_10_14";
		}
		else if(var_10 >= 5)
		{
			var_12 = "weapon_rank_up_5_9";
		}

		var_13 = scripts\mp\_rank::func_8104(var_12);
		scripts\mp\_rank::func_839A(var_12,var_13);
	}
}

//Function Number: 18
func_DF69(param_00)
{
	switch(param_00)
	{
		case "kill":
			param_00 = "kill_weapon";
			break;

		case "challenge":
			param_00 = "weapon_challenge";
			break;
	}

	return param_00;
}

//Function Number: 19
func_17CB(param_00,param_01)
{
	level func_186A(param_00,param_01);
}

//Function Number: 20
func_7EDB()
{
	return level func_8232();
}

//Function Number: 21
func_186A(param_00,param_01)
{
	if(!isdefined(self.var_13CBE))
	{
		self.var_13CBE = [];
	}

	if(isdefined(self.var_13CBE[param_01]))
	{
		self.var_13CBE[param_01] = max(self.var_13CBE[param_01],param_00);
		return;
	}

	self.var_13CBE[param_01] = param_00;
}

//Function Number: 22
func_8232()
{
	if(!isdefined(self.var_13CBE))
	{
		return 1;
	}

	var_00 = 1;
	foreach(var_02 in self.var_13CBE)
	{
		if(!isdefined(var_02))
		{
			continue;
		}

		var_00 = var_00 * var_02;
	}

	return var_00;
}

//Function Number: 23
func_E126(param_00)
{
	level func_E18D(param_00);
}

//Function Number: 24
func_E18D(param_00)
{
	if(!isdefined(self.var_13CBE))
	{
		return;
	}

	if(!isdefined(self.var_13CBE[param_00]))
	{
		return;
	}

	self.var_DCD7[param_00] = undefined;
}

//Function Number: 25
func_8233()
{
	var_00 = func_8232();
	var_01 = func_7EDB();
	return var_00 * var_01;
}