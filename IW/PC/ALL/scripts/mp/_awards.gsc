/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_awards.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 1048 ms
 * Timestamp: 10/27/2023 12:14:29 AM
*******************************************************************/

//Function Number: 1
init()
{
	func_97D5();
	level thread func_C56E();
	level.givemidmatchawardfunc = ::func_8380;
}

//Function Number: 2
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_C57B();
		var_00 thread initaarawardlist();
		var_00.var_26D7 = [];
	}
}

//Function Number: 3
func_C57B()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self.var_26D9 = [];
	}
}

//Function Number: 4
func_97D5()
{
	func_989C();
}

//Function Number: 5
func_97D7(param_00,param_01)
{
	level.var_26D8[param_00] = spawnstruct();
	level.var_26D8[param_00].type = param_01;
	var_02 = tablelookup("mp/awardtable.csv",1,param_00,10);
	if(isdefined(var_02) && var_02 != "")
	{
		level.var_26D8[param_00].var_13E28 = var_02;
	}

	var_03 = tablelookup("mp/awardtable.csv",1,param_00,11);
	if(isdefined(var_03) && var_03 != "")
	{
		level.var_26D8[param_00].var_7681 = var_03;
	}

	var_04 = tablelookup("mp/awardtable.csv",1,param_00,3);
	if(isdefined(var_04) && var_04 != "")
	{
		level.var_26D8[param_00].var_3B95 = var_04;
	}

	var_05 = tablelookup("mp/awardtable.csv",1,param_00,7);
	if(isdefined(var_05) && var_05 != "")
	{
		var_06 = randomfloat(1);
		level.var_26D8[param_00].aarpriority = float(var_05) + var_06;
	}
}

//Function Number: 6
func_97D8(param_00,param_01)
{
	func_97D7(param_00,param_01);
}

//Function Number: 7
func_989B(param_00)
{
	func_97D8(param_00,"midmatch");
}

//Function Number: 8
func_989C()
{
	var_00 = 0;
	for(;;)
	{
		var_01 = tablelookupbyrow("mp/awardtable.csv",var_00,1);
		if(!isdefined(var_01) || var_01 == "")
		{
			break;
		}

		var_02 = tablelookupbyrow("mp/awardtable.csv",var_00,9);
		if(isdefined(var_02) && var_02 != "")
		{
			func_989B(var_01);
		}

		level.var_26D8[var_01].var_92B8 = var_00;
		var_00++;
	}
}

//Function Number: 9
func_93E0(param_00)
{
	var_01 = self getplayerdata("common","awards",param_00);
	self setplayerdata("common","awards",param_00,var_01 + 1);
}

//Function Number: 10
func_8352(param_00,param_01,param_02)
{
	if(!isdefined(level.var_26D8[param_00]))
	{
		return;
	}

	if(!function_02D9("mp","Awards",param_00))
	{
		return;
	}

	func_93E0(param_00);
	addawardtoaarlist(param_00);
	var_03 = level.var_26D8[param_00].var_13E28;
	if(isdefined(var_03))
	{
		if(isdefined(param_02))
		{
			var_04 = param_02;
		}
		else
		{
			var_04 = scripts\mp\_rank::func_8104(var_04);
		}

		scripts\mp\_rank::func_839A(var_03,var_04);
	}

	var_05 = level.var_26D8[param_00].var_7681;
	if(isdefined(var_05))
	{
		scripts\mp\_utility::func_83B4(var_05,undefined,param_01,undefined,undefined,1);
	}

	scripts\mp\_utility::func_316C("earned_award_buffered",param_00);
	if(isdefined(self.var_26D9[param_00]))
	{
		self.var_26D9[param_00]++;
	}
	else
	{
		self.var_26D9[param_00] = 1;
	}

	scripts\mp\_matchdata::func_AF97(param_00);
	scripts\mp\_missions::func_D98F(param_00);
}

//Function Number: 11
func_DB92(param_00)
{
	self.var_26D7[self.var_26D7.size] = param_00;
	thread func_6F75();
}

//Function Number: 12
func_6F74()
{
	foreach(var_01 in self.var_26D7)
	{
		func_8380(var_01);
	}

	self.var_26D7 = [];
}

//Function Number: 13
func_6F75()
{
	self endon("disconnect");
	self notify("flushMidMatchAwardQueueWhenAble()");
	self endon("flushMidMatchAwardQueueWhenAble()");
	for(;;)
	{
		if(!func_10064())
		{
			break;
		}

		scripts\common\utility::func_136F7();
	}

	thread func_6F74();
}

//Function Number: 14
func_10064(param_00)
{
	if(level.var_7669)
	{
		return 0;
	}

	if(!scripts\mp\_utility::func_9F19(self))
	{
		if(!scripts\mp\_utility::func_9FB3(param_00) || scripts\mp\_utility::func_9E4A())
		{
			if(!scripts\mp\_utility::func_9FC6())
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 15
func_B8E6(param_00)
{
	if(!isdefined(param_00) || !isdefined(level.var_26D8) || !isdefined(level.var_26D8[param_00]))
	{
		return;
	}

	if(!isdefined(self.var_1097C) || !isdefined(self.var_D8B1))
	{
		self.var_1097C = 0;
		self.var_D8B1 = 0;
	}

	var_01 = level.var_26D8[param_00].var_92B8;
	if(var_01 > 255)
	{
		scripts\common\utility::func_66BD("awardID can\'t be larger than 255! Must increased bit size for award id stored in ui_spectating_award_event_bitfield");
	}

	var_02 = self.var_D8B1;
	var_03 = 8 * self.var_1097C % 4;
	var_04 = ~255 << var_03;
	var_02 = var_02 & var_04;
	var_05 = var_01 << var_03;
	var_02 = var_02 | var_05;
	self setclientomnvar("ui_spectating_award_event_bitfield",var_02);
	self setclientomnvar("ui_spectating_award_event_index",self.var_1097C);
	self.var_D8B1 = var_02;
	self.var_1097C++;
	if(self.var_1097C > 99)
	{
		self.var_1097C = 0;
	}
}

//Function Number: 16
func_8380(param_00,param_01,param_02,param_03)
{
	if(!isplayer(self))
	{
		return;
	}

	if(getdvarint("com_codcasterEnabled",0) == 1)
	{
		foreach(var_05 in level.players)
		{
			if(var_05 ismlgspectator())
			{
				var_06 = var_05 method_815D();
				if(isdefined(var_06))
				{
					var_07 = var_06 getentitynumber();
					var_08 = self getentitynumber();
					if(var_07 == var_08)
					{
						var_05 func_B8E6(param_00);
					}
				}
			}
		}
	}

	if(isai(self))
	{
		return;
	}

	if(func_10064(param_03))
	{
		func_DB92(param_00);
		return;
	}

	scripts\mp\_analyticslog::func_AF9D(param_00);
	func_8352(param_00,param_01,param_02);
}

//Function Number: 17
addawardtoaarlist(param_00)
{
	if(!isdefined(self.aarawards))
	{
		self.aarawards = [];
		self.aarawardcount = 0;
		for(var_01 = 0;var_01 < 10;var_01++)
		{
			var_02 = spawnstruct();
			self.aarawards[var_01] = var_02;
			var_02.var_DE3F = "none";
			var_02.var_C1 = 0;
		}
	}

	foreach(var_01, var_04 in self.aarawards)
	{
		if(var_04.var_DE3F == param_00)
		{
			var_04.var_C1++;
			self setplayerdata("common","round","awards",var_01,"value",var_04.var_C1);
			return;
		}
	}

	var_05 = level.var_26D8[param_00].aarpriority;
	for(var_06 = 0;var_06 < self.aarawards.size;var_06++)
	{
		var_04 = self.aarawards[var_06];
		if(var_04.var_DE3F == "none")
		{
			break;
		}

		var_07 = level.var_26D8[var_04.var_DE3F].aarpriority;
		if(var_05 > var_07)
		{
			break;
		}
	}

	if(var_06 >= self.aarawards.size)
	{
		return;
	}

	for(var_08 = self.aarawards.size - 2;var_08 >= var_06;var_08--)
	{
		var_09 = var_08 + 1;
		self.aarawards[var_09] = self.aarawards[var_08];
		var_04 = self.aarawards[var_09];
		if(var_04.var_DE3F != "none")
		{
			self setplayerdata("common","round","awards",var_09,"award",var_04.var_DE3F);
			self setplayerdata("common","round","awards",var_09,"value",var_04.var_C1);
		}
	}

	var_04 = spawnstruct();
	self.aarawards[var_06] = var_04;
	var_04.var_DE3F = param_00;
	var_04.var_C1 = 1;
	self setplayerdata("common","round","awards",var_06,"award",var_04.var_DE3F);
	self setplayerdata("common","round","awards",var_06,"value",var_04.var_C1);
	if(self.aarawardcount < 10)
	{
		self.aarawardcount++;
		self setplayerdata("common","round","awardCount",self.aarawardcount);
	}

	if(scripts\mp\_utility::func_9FB3(self.savedaarawards))
	{
		saveaarawards();
	}
}

//Function Number: 18
initaarawardlist()
{
	self.aarawards = self.pers["aarAwards"];
	self.aarawardcount = self.pers["aarAwardCount"];
	thread saveaarawardsonroundswitch();
	if(isdefined(self.aarawards))
	{
		return;
	}

	self setplayerdata("common","round","awardCount",0);
	for(var_00 = 0;var_00 < 10;var_00++)
	{
		self setplayerdata("common","round","awards",var_00,"award","none");
		self setplayerdata("common","round","awards",var_00,"value",0);
	}
}

//Function Number: 19
saveaarawardsonroundswitch()
{
	self endon("disconnect");
	level waittill("game_ended");
	saveaarawards();
}

//Function Number: 20
saveaarawards()
{
	self.pers["aarAwards"] = self.aarawards;
	self.pers["aarAwardCount"] = self.aarawardcount;
	self.savedaarawards = 1;
}