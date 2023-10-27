/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\battlechatter_ai.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 55
 * Decompile Time: 963 ms
 * Timestamp: 10/27/2023 2:17:52 AM
*******************************************************************/

//Function Number: 1
func_0AA9(param_00)
{
	self endon("death");
	if(!animscripts/battlechatter::func_AAA())
	{
		return;
	}

	if(self.chatinitialized)
	{
		return;
	}

	if(!isdefined(self.var_A7A.chatinitialized) || !self.var_A7A.chatinitialized)
	{
		self.var_A7A animscripts/battlechatter::func_AAC();
	}

	self.var_AAD = "infantry";
	self.var_AAE = [];
	if(isplayer(self))
	{
		self.battlechatter = 0;
		self.flavorbursts = 0;
		self.type = "human";
		return;
	}

	if(self.type == "dog")
	{
		self.var_AAD = undefined;
		self.battlechatter = 0;
		self.flavorbursts = 0;
		return;
	}

	if(self.team == "neutral")
	{
		self.var_AAD = undefined;
		self.battlechatter = 0;
		self.flavorbursts = 0;
		return;
	}

	if(func_0AB7())
	{
		if(self.team == "allies")
		{
			self.var_AB1 = 0;
		}
		else
		{
			self.voice = "american";
		}
	}

	self.var_AB4 = level.countryids[self.voice];
	if(isdefined(self.script_friendname))
	{
		var_01 = tolower(self.script_friendname);
		if(issubstr(var_01,"price"))
		{
			self.var_AB6 = "pri";
		}
		else if(issubstr(var_01,"mactavish") || issubstr(var_01,"soap"))
		{
			self.var_AB6 = "mct";
		}
		else if(issubstr(var_01,"wallcroft"))
		{
			self.var_AB6 = "wcf";
		}
		else if(issubstr(var_01,"griffin"))
		{
			self.var_AB6 = "grf";
		}
		else if(issubstr(var_01,"grinch"))
		{
			self.var_AB6 = "grn";
		}
		else if(issubstr(var_01,"truck"))
		{
			self.var_AB6 = "trk";
		}
		else if(issubstr(var_01,"sandman"))
		{
			self.var_AB6 = "snd";
		}
		else if(issubstr(var_01,"yuri"))
		{
			self.var_AB6 = "yri";
		}
		else
		{
			func_0ABA();
		}
	}
	else
	{
		func_0ABA();
	}

	thread func_0AC0();
	func_0ACA();
	thread func_0AB8();
}

//Function Number: 2
func_0AB7()
{
	if(!getdvarint("bcs_forceEnglish",0))
	{
		return 0;
	}

	switch(level.script)
	{
		case "pmc_strike":
			return 1;
	}

	return 0;
}

//Function Number: 3
func_0AB8()
{
	self endon("death");
	self endon("removed from battleChatter");
	var_00 = 0.5;
	wait var_00;
	thread func_0B27();
	thread func_0B30();
	if(self.team == "allies")
	{
		wait var_00;
		thread func_0B28();
		if(self.var_AB4 == "CZ")
		{
			thread func_0ABD();
		}
	}
	else if((self.team == "axis" || self.team == "team3") && !func_0AB9(self.var_AB4))
	{
		thread func_0ABD();
	}

	if(self.team == level.player.team)
	{
		thread func_0B31();
	}

	wait var_00;
	thread func_0ABE();
}

//Function Number: 4
func_0AB9(param_00)
{
	if(param_00 == "UK" || param_00 == "US" || param_00 == "NS" || param_00 == "TF" || param_00 == "SS")
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
func_0ABA()
{
	var_00 = level.var_ABB[self.voice];
	var_01 = var_00.size;
	var_02 = randomintrange(0,var_01);
	var_03 = var_02;
	for(var_04 = 0;var_04 <= var_01;var_04++)
	{
		if(var_00[var_02 + var_04 % var_01].count < var_00[var_03].count)
		{
			var_03 = var_02 + var_04 % var_01;
		}
	}

	thread func_0ABC(var_03);
	self.var_AB6 = var_00[var_03].var_AB6;
}

//Function Number: 6
func_0ABC(param_00)
{
	level.var_ABB[self.voice][param_00].count++;
	common_scripts\utility::waittill_either("death","removed from battleChatter");
	if(!animscripts/battlechatter::func_AAA())
	{
		return;
	}

	level.var_ABB[self.voice][param_00].count--;
}

//Function Number: 7
func_0ABD()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		if(distance(self.origin,level.player.origin) < 1024)
		{
			if(isdefined(self.var_A7A.var_A6A) && self.var_A7A.var_A6A > 1)
			{
				func_0AE4("taunt","hostileburst");
			}
		}

		wait randomfloatrange(2,5);
	}
}

//Function Number: 8
func_0ABE()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		animscripts/battlechatter::func_ABF();
		wait 0.3 + randomfloat(0.2);
	}
}

//Function Number: 9
func_0AC0()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		self.var_AC2 = animscripts/battlechatter::func_AC1();
		self.var_AC4 = animscripts/battlechatter::getrank();
		self waittill("set name and rank");
	}
}

//Function Number: 10
func_0AC5(param_00)
{
	if(!isalive(self) && animscripts/battlechatter::func_AAA())
	{
		func_0B21();
		func_0B24();
	}

	if(isdefined(self))
	{
		self.battlechatter = 0;
		self.chatinitialized = 0;
	}

	self notify("removed from battleChatter");
	if(isdefined(self))
	{
		self.var_AC6 = undefined;
		self.var_AC7 = undefined;
		self.var_AC8 = undefined;
		self.isspeaking = undefined;
		self.var_AAD = undefined;
		self.var_AAE = undefined;
		self.var_AB4 = undefined;
		self.var_AB6 = undefined;
	}
}

//Function Number: 11
func_0ACA()
{
	self.var_AC6 = [];
	self.var_AC6["threat"] = spawnstruct();
	self.var_AC6["threat"].var_ACB = 0;
	self.var_AC6["threat"].priority = 0;
	self.var_AC6["response"] = spawnstruct();
	self.var_AC6["response"].var_ACB = 0;
	self.var_AC6["response"].priority = 0;
	self.var_AC6["reaction"] = spawnstruct();
	self.var_AC6["reaction"].var_ACB = 0;
	self.var_AC6["reaction"].priority = 0;
	self.var_AC6["inform"] = spawnstruct();
	self.var_AC6["inform"].var_ACB = 0;
	self.var_AC6["inform"].priority = 0;
	self.var_AC6["order"] = spawnstruct();
	self.var_AC6["order"].var_ACB = 0;
	self.var_AC6["order"].priority = 0;
	self.var_AC6["custom"] = spawnstruct();
	self.var_AC6["custom"].var_ACB = 0;
	self.var_AC6["custom"].priority = 0;
	self.var_AC7 = gettime() + 50;
	self.var_AC8["threat"] = 0;
	self.var_AC8["reaction"] = 0;
	self.var_AC8["response"] = 0;
	self.var_AC8["inform"] = 0;
	self.var_AC8["order"] = 0;
	self.var_AC8["custom"] = 0;
	self.isspeaking = 0;
	self.var_ACD = 0;
	self.var_ACE = [];
	animscripts/battlechatter::func_ACF("rpg");
	animscripts/battlechatter::func_ACF("exposed");
	if(self.voice != "shadowcompany")
	{
		if(self.voice != "british" && self.voice != "pmc")
		{
			animscripts/battlechatter::func_ACF("ai_obvious");
		}

		animscripts/battlechatter::func_ACF("ai_contact_clock");
		animscripts/battlechatter::func_ACF("ai_target_clock");
		animscripts/battlechatter::func_ACF("ai_cardinal");
	}

	if(self.voice == "delta")
	{
		animscripts/battlechatter::func_ACF("player_distance");
		animscripts/battlechatter::func_ACF("player_target_clock_high");
		animscripts/battlechatter::func_ACF("ai_distance");
		animscripts/battlechatter::func_ACF("ai_target_clock_high");
	}

	if(self.team == "allies")
	{
		if(maps\_utility::array_contains(level.var_AD0,self.voice))
		{
			animscripts/battlechatter::func_ACF("player_contact_clock");
			animscripts/battlechatter::func_ACF("player_target_clock");
			animscripts/battlechatter::func_ACF("player_cardinal");
			if(self.voice != "british" && self.voice != "pmc")
			{
				animscripts/battlechatter::func_ACF("player_obvious");
			}

			animscripts/battlechatter::func_ACF("player_object_clock");
			if(self.voice != "french")
			{
				animscripts/battlechatter::func_ACF("player_location");
			}
		}

		if(self.voice != "french")
		{
			animscripts/battlechatter::func_ACF("ai_location");
			animscripts/battlechatter::func_ACF("generic_location");
		}
	}

	if(isdefined(self.var_AB1) && !self.var_AB1)
	{
		self.battlechatter = 0;
	}
	else
	{
		self.battlechatter = level.battlechatter[self.team];
	}

	if(animscripts/battlechatter::func_AD2())
	{
		self.flavorbursts = 1;
	}
	else
	{
		self.flavorbursts = 0;
	}

	if(level.friendlyfire_warnings)
	{
		maps\_utility::set_friendlyfire_warnings(1);
	}
	else
	{
		maps\_utility::set_friendlyfire_warnings(0);
	}

	self.chatinitialized = 1;
}

//Function Number: 12
func_0AD5(param_00,param_01,param_02)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::func_AD6("threat",param_00,param_02))
	{
		return;
	}

	if(animscripts/battlechatter::func_AD7(param_01) && !isplayer(param_01))
	{
		return;
	}

	var_03 = animscripts/battlechatter::func_AD8("threat",param_00,param_02);
	switch(param_00)
	{
		case "infantry":
			var_03.var_AD9 = param_01;
			break;
	}

	if(isdefined(param_01.var_A7A))
	{
		self.var_A7A animscripts/battlechatter::func_ADA(param_01.var_A7A.var_A66,self);
	}

	self.var_AC6["threat"] = undefined;
	self.var_AC6["threat"] = var_03;
}

//Function Number: 13
func_0ADB(param_00,param_01,param_02,param_03,param_04,param_05)
{
	thread func_0ADC(param_00,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 14
func_0ADC(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("death");
	self endon("removed from battleChatter");
	self endon("responseEvent_failsafe");
	thread func_0AE1(param_02);
	var_06 = param_02 common_scripts\utility::waittill_any_return("death","done speaking","cancel speaking");
	if(var_06 == "cancel speaking")
	{
		return;
	}

	if(!isalive(param_02))
	{
		return;
	}

	if(!animscripts/battlechatter::func_AD6("response",param_00,param_03,param_01))
	{
		return;
	}

	if(!isplayer(param_02))
	{
		if(animscripts/battlechatter::func_ADD(param_02))
		{
			return;
		}
	}

	var_07 = animscripts/battlechatter::func_AD8("response",param_00,param_03);
	if(isdefined(param_04))
	{
		var_07.var_ADE = param_04;
	}

	if(isdefined(param_05))
	{
		var_07.location = param_05;
	}

	var_07.var_ADF = param_02;
	var_07.var_AE0 = param_01;
	self.var_AC6["response"] = undefined;
	self.var_AC6["response"] = var_07;
}

//Function Number: 15
func_0AE1(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	param_00 endon("death");
	param_00 endon("done speaking");
	param_00 endon("cancel speaking");
	wait 25;
	self notify("responseEvent_failsafe");
}

//Function Number: 16
func_0AE2(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::func_AD6("inform",param_00,param_03,param_01))
	{
		return;
	}

	var_04 = animscripts/battlechatter::func_AD8("inform",param_00,param_03);
	switch(param_00)
	{
		case "reloading":
			var_04.var_AE0 = param_01;
			var_04.var_AE3 = param_02;
			break;

		default:
			var_04.var_AE0 = param_01;
			break;
	}

	self.var_AC6["inform"] = undefined;
	self.var_AC6["inform"] = var_04;
}

//Function Number: 17
func_0AE4(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!isdefined(self.var_AC6))
	{
		return;
	}

	var_04 = animscripts/battlechatter::func_AD8("reaction",param_00,param_03);
	var_04.var_AE5 = param_02;
	var_04.var_AE0 = param_01;
	self.var_AC6["reaction"] = undefined;
	self.var_AC6["reaction"] = var_04;
}

//Function Number: 18
func_0AE6(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::func_AD6("order",param_00,param_03,param_01))
	{
		return;
	}

	if(isdefined(param_02) && param_02.type == "dog")
	{
		return;
	}

	var_04 = animscripts/battlechatter::func_AD8("order",param_00,param_03);
	var_04.var_AE0 = param_01;
	var_04.var_AE7 = param_02;
	self.var_AC6["order"] = undefined;
	self.var_AC6["order"] = var_04;
}

//Function Number: 19
func_0AE8()
{
	anim endon("battlechatter disabled");
	anim endon("squad deleted " + self.var_A66);
	for(;;)
	{
		var_00 = undefined;
		if(self.var_A6C.size)
		{
			var_01 = self.var_A6C;
		}
		else
		{
			var_01 = self.members;
		}

		var_02 = [];
		for(var_03 = 0;var_03 < var_01.size;var_03++)
		{
			if(isalive(var_01[var_03]))
			{
				var_02[var_02.size] = var_01[var_03];
			}
		}

		if(var_02.size)
		{
			var_00 = maps\_utility::getclosest(level.player.origin,var_02);
			var_00 func_0B26();
			var_00 waittill("death");
		}

		wait 3;
	}
}

//Function Number: 20
func_0AEA(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		if(!isdefined(param_00[var_02].var_AAD))
		{
			continue;
		}

		if(!func_0AEF(param_00[var_02]))
		{
			continue;
		}

		param_00[var_02].var_AEB = var_01.size;
		var_01[var_01.size] = param_00[var_02];
	}

	var_01 = maps\_utility::get_array_of_closest(level.player.origin,var_01);
	var_03 = [];
	var_04 = [];
	foreach(var_06 in var_01)
	{
		var_07 = var_06 animscripts/battlechatter::func_AED();
		if(isdefined(var_07) && !animscripts/battlechatter::func_AEE(var_07))
		{
			var_03[var_03.size] = var_06;
			continue;
		}

		var_04[var_04.size] = var_06;
	}

	var_01 = common_scripts\utility::array_combine(var_03,var_04);
	return var_01;
}

//Function Number: 21
func_0AEF(param_00)
{
	var_01 = level.var_B1D * level.var_B1D;
	if(distancesquared(level.player.origin,param_00.origin) > var_01)
	{
		return 0;
	}

	if(!level.player animscripts/battlechatter::func_B1E(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 22
func_0B1F()
{
	anim endon("battlechatter disabled");
	anim endon("squad deleted " + self.var_A66);
	for(;;)
	{
		wait randomfloatrange(0.25,0.75);
		if(self.team == "allies")
		{
			var_00 = func_0AEA(getaiarray("axis","team3"));
		}
		else if(self.team == "team3")
		{
			var_00 = func_0AEA(getaiarray("allies","axis"));
		}
		else
		{
			var_00 = getaiarray("allies","team3");
			var_00[var_00.size] = level.player;
		}

		if(!var_00.size)
		{
			continue;
		}

		var_01 = [];
		foreach(var_03 in self.members)
		{
			if(!isalive(var_03))
			{
				continue;
			}

			if(!var_00.size)
			{
				var_00 = var_01;
				var_01 = [];
			}

			foreach(var_06, var_05 in var_00)
			{
				if(!isdefined(var_05))
				{
					if(var_06 == 0)
					{
						var_00 = [];
					}

					continue;
				}

				if(!isalive(var_05))
				{
					continue;
				}

				if(!isdefined(var_05.var_AAD))
				{
					continue;
				}

				if(!var_03 cansee(var_05))
				{
					if(isplayer(var_05))
					{
						continue;
					}

					if(var_05.team == level.player.team)
					{
						continue;
					}

					if(!maps\_utility::player_can_see_ai(var_05,250))
					{
						continue;
					}
				}

				var_03 func_0AD5(var_05.var_AAD,var_05);
				var_01[var_01.size] = var_05;
				var_00 = common_scripts\utility::array_remove(var_00,var_05);
				break;
			}

			wait 0.05;
		}
	}
}

//Function Number: 23
func_0B21()
{
	var_00 = self.attacker;
	common_scripts\utility::array_thread(self.var_A7A.members,::func_0B23);
	if(isalive(var_00) && issentient(var_00) && isdefined(var_00.var_A7A) && var_00.battlechatter)
	{
		if(isdefined(var_00.var_AAE[var_00.var_A7A.var_A66]))
		{
			var_00.var_AAE[var_00.var_A7A.var_A66] = undefined;
		}

		if(!isdefined(var_00.var_AAD))
		{
			return;
		}

		if(!var_00 animscripts/battlechatter::func_B22())
		{
			return;
		}

		foreach(var_02 in self.var_A7A.members)
		{
			if(gettime() > var_02.var_A7F + 2000)
			{
				continue;
			}

			var_02 func_0AD5(var_00.var_AAD,var_00);
		}
	}
}

//Function Number: 24
func_0B23()
{
	if(!isalive(self))
	{
		return;
	}

	self endon("death");
	self endon("removed from battleChatter");
	self notify("aiDeathEventThread");
	self endon("aiDeathEventThread");
	wait 1.5;
	func_0AE4("casualty","generic",self,0.9);
}

//Function Number: 25
func_0B24()
{
	var_00 = self.attacker;
	if(!isalive(var_00) || !issentient(var_00) || !isdefined(var_00.var_A7A))
	{
		return;
	}

	if(!isdefined(var_00.var_AB4) || var_00.var_AB4 != "NS")
	{
		return;
	}

	if(!isplayer(var_00))
	{
		var_00 thread func_0B25();
	}
}

//Function Number: 26
func_0B25()
{
	self endon("death");
	self endon("removed from battleChatter");
	wait 1.5;
	func_0AE2("killfirm","generic");
}

//Function Number: 27
func_0B26()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!isdefined(self.var_A7A.chatinitialized))
	{
		self.var_A7A waittill("squad chat initialized");
	}

	for(;;)
	{
		if(getdvar("bcs_enable","on") == "off")
		{
			wait 1;
			continue;
		}

		func_0B3B();
		wait randomfloatrange(3,6);
	}
}

//Function Number: 28
func_0B27()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		self waittill("grenade danger",var_00);
		if(getdvar("bcs_enable","on") == "off")
		{
			continue;
		}

		if(!isdefined(var_00) || var_00.model != "projectile_m67fraggrenade")
		{
			continue;
		}

		if(distance(var_00.origin,level.player.origin) < 512)
		{
			func_0AE2("incoming","grenade");
		}
	}
}

//Function Number: 29
func_0B28()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		self waittill("trigger");
		if(getdvar("bcs_enable","on") == "off")
		{
			continue;
		}

		if(gettime() < self.a.var_B29 + 4000)
		{
			continue;
		}

		func_0ADB("ack","yes",level.player,1);
	}
}

//Function Number: 30
func_0B2A(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::func_AAA())
	{
		return;
	}

	if(!isdefined(self.node))
	{
		return;
	}

	var_01 = distance(self.origin,self.node.origin);
	if(var_01 < 512)
	{
		return;
	}

	if(!animscripts/battlechatter::func_B2B())
	{
		return;
	}

	if(!func_0B2E())
	{
		return;
	}

	var_02 = animscripts/battlechatter::func_B2C(24,1024,"response");
	if(self.team != "axis" && self.team != "team3")
	{
		if(!isdefined(var_02))
		{
			var_02 = level.player;
		}
		else if(randomint(100) < level.var_B2D["moveEvent"]["ordertoplayer"])
		{
			var_02 = level.player;
		}
	}

	if(self.var_A80 > 0)
	{
		if(randomint(100) < level.var_B2D["moveEvent"]["coverme"])
		{
			func_0AE6("action","coverme",var_02);
			return;
		}

		func_0AE6("move","combat",var_02);
		return;
	}

	if(func_0B2F())
	{
		func_0AE6("move","noncombat",var_02);
	}
}

//Function Number: 31
func_0B2E()
{
	if(self.var_AB4 == "SS")
	{
		return 0;
	}

	return 1;
}

//Function Number: 32
func_0B2F()
{
	if(self.var_AB4 == "US")
	{
		return 1;
	}

	return 0;
}

//Function Number: 33
func_0B30()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		level waittill("follow order",var_00);
		if(!animscripts/battlechatter::func_AAA())
		{
			return;
		}

		if(var_00.team != self.team)
		{
			continue;
		}

		if(distance(self.origin,var_00.origin) < 600)
		{
			func_0ADB("ack","yes",var_00,0.9);
		}
	}
}

//Function Number: 34
func_0B31()
{
	self endon("death");
	self endon("removed from battleChatter");
	thread func_0B33();
	for(;;)
	{
		self waittill("bulletwhizby",var_00,var_01);
		if(!animscripts/battlechatter::func_AAA())
		{
			continue;
		}

		if(!isplayer(var_00))
		{
			continue;
		}

		if(func_0B35(var_00,var_01))
		{
			func_0B32();
			wait 3;
		}
	}
}

//Function Number: 35
func_0B32()
{
	func_0AE4("friendlyfire",undefined,level.player,1);
}

//Function Number: 36
func_0B33()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(isdefined(var_01) && isplayer(var_01))
		{
			if(func_0B34(var_04))
			{
				func_0B32();
			}
		}
	}
}

//Function Number: 37
func_0B34(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	switch(param_00)
	{
		case "MOD_IMPACT":
		case "MOD_CRUSH":
		case "MOD_MELEE":
		case "MOD_GRENADE_SPLASH":
		case "MOD_GRENADE":
			return 0;
	}

	return 1;
}

//Function Number: 38
func_0B35(param_00,param_01)
{
	var_02 = 65536;
	var_03 = 42;
	if(distancesquared(param_00.origin,self.origin) < var_02)
	{
		return 0;
	}

	if(param_01 > var_03)
	{
		return 0;
	}

	return 1;
}

//Function Number: 39
func_0B36()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::func_AAA())
	{
		return;
	}

	func_0AE2("reloading","generic");
}

//Function Number: 40
func_0B37()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::func_AAA())
	{
		return 0;
	}

	if(!isdefined(self.enemy))
	{
		return 0;
	}

	return 0;
}

//Function Number: 41
func_0B38()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::func_AAA())
	{
		return;
	}

	if(!isdefined(self.enemy))
	{
	}
}

//Function Number: 42
func_0B39()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::func_AAA())
	{
		return;
	}

	if(!self.var_A9D)
	{
		return;
	}

	func_0AE2("suppressed","generic");
}

//Function Number: 43
func_0B3A(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::func_AAA())
	{
		return;
	}

	func_0AE2("attack","grenade");
}

//Function Number: 44
func_0B3B()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(self.var_A7A.var_AA0["combat"].var_AA2)
	{
		func_0B3C();
	}
}

//Function Number: 45
func_0B3C()
{
	self endon("death");
	self endon("removed from battleChatter");
	var_00 = self.var_A7A;
	var_00 animscripts/squadmanager::func_A99();
	if(var_00.var_AA0["suppressed"].var_AA2)
	{
		if(var_00.var_AA0["cover"].var_AA2)
		{
			var_01 = animscripts/battlechatter::func_B2C(96,512,"response");
			func_0AE6("action","grenade",var_01);
		}
		else
		{
			func_0AE6("displace","generic");
		}
	}
	else if(var_00.var_AA0["combat"].var_AA2)
	{
		if(self.var_AB4 != "SS")
		{
			var_01 = animscripts/battlechatter::func_B2C(24,1024,"response");
			func_0AE6("action","suppress",var_01);
		}
	}
}

//Function Number: 46
func_0B3D()
{
	var_00 = [];
	level.var_B3E = var_7B;
}

//Function Number: 47
func_0B3F(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.var_B3E)
	{
		if(var_03 == param_00)
		{
			var_01 = 1;
			break;
		}
	}

	return var_01;
}

//Function Number: 48
func_0B40(param_00)
{
	if(!isdefined(level.var_B3E))
	{
		func_0B3D();
	}

	param_00 = tolower(param_00);
	var_01 = level.bcprintfailprefix + "custom battlechatter phrase \'" + param_00 + "\' isn\'t valid.  look at _utility::custom_battlechatter_init_valid_phrases(), or the util script documentation for custom_battlechatter(), for a list of valid phrases.";
	var_02 = level.bcprintfailprefix + "AI at origin " + self.origin + "wasn\'t able to play custom battlechatter because his nationality is \'" + self.var_AB4 + "\'.";
	if(!func_0B3F(param_00))
	{
		return 0;
	}

	var_03 = animscripts/battlechatter::func_B2C(24,512,"response");
	func_0B44();
	switch(param_00)
	{
		case "order_move_combat":
			if(!func_0B2E())
			{
				return 0;
			}
	
			animscripts/battlechatter::func_B43(self.var_B42,var_03);
			func_0B48();
			break;

		case "order_move_noncombat":
			if(!func_0B2F())
			{
				return 0;
			}
	
			func_0B49();
			break;

		case "order_action_coverme":
			animscripts/battlechatter::func_B43(self.var_B42,var_03);
			func_0B46();
			break;

		case "inform_reloading":
			func_0B4A();
			break;

		default:
			return 0;
	}

	func_0B4E(2000);
	return 1;
}

//Function Number: 49
func_0B44()
{
	if(!animscripts/battlechatter::func_AAA())
	{
		return;
	}

	self.var_B42 = animscripts/battlechatter::func_B45();
}

//Function Number: 50
func_0B46()
{
	self.var_B42 animscripts/battlechatter::func_B47("action","coverme");
}

//Function Number: 51
func_0B48()
{
	self.var_B42 animscripts/battlechatter::func_B47("move","combat");
}

//Function Number: 52
func_0B49()
{
	self.var_B42 animscripts/battlechatter::func_B47("move","noncombat");
}

//Function Number: 53
func_0B4A()
{
	self.var_B42 animscripts/battlechatter::func_B4B("reloading","generic");
}

//Function Number: 54
func_0B4C(param_00)
{
	if(!animscripts/battlechatter::func_AAA())
	{
		return;
	}

	self.var_B42 animscripts/battlechatter::func_B4D(param_00);
}

//Function Number: 55
func_0B4E(param_00,param_01)
{
	if(!animscripts/battlechatter::func_AAA())
	{
		return;
	}

	var_02 = animscripts/battlechatter::func_AD8("custom","generic",1);
	if(isdefined(param_00))
	{
		var_02.var_ACB = gettime() + param_00;
	}

	if(isdefined(param_01))
	{
		var_02.type = param_01;
	}
	else
	{
		var_02.type = "custom";
	}

	self.var_AC6["custom"] = undefined;
	self.var_AC6["custom"] = var_02;
}