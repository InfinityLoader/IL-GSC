/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\battlechatter_ai.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 58
 * Decompile Time: 994 ms
 * Timestamp: 10/27/2023 1:23:28 AM
*******************************************************************/

//Function Number: 1
func_099A(param_00)
{
	self endon("death");
	if(!animscripts/battlechatter::func_1351())
	{
		return;
	}

	if(self.var_1B40)
	{
		return;
	}

	if(!isdefined(self.squad.var_1B40) || !self.squad.var_1B40)
	{
		self.squad animscripts/battlechatter::init_squadbattlechatter();
	}

	self.var_2F12 = "infantry";
	self.var_195D = [];
	if(isplayer(self))
	{
		self.battlechatter = 0;
		self.var_341A = 0;
		self.type = "human";
		return;
	}

	if(self.type == "dog")
	{
		self.var_2F12 = undefined;
		self.battlechatter = 0;
		self.var_341A = 0;
		return;
	}

	if(self.team == "neutral")
	{
		self.var_2F12 = undefined;
		self.battlechatter = 0;
		self.var_341A = 0;
		return;
	}

	if(func_34D3())
	{
		if(self.team == "allies")
		{
			self.var_6B4F = 0;
		}
		else
		{
			self.voice = "american";
		}
	}

	self.var_1F85 = level.countryids[self.voice];
	assign_npcid();
	thread ainameandrankwaiter();
	func_44E5();
	thread aithreadthreader();
}

//Function Number: 2
assign_npcid()
{
	if(isdefined(self.var_6BD8))
	{
		var_00 = tolower(self.var_6BD8);
		if(issubstr(var_00,"hesh"))
		{
			self.npcid = "hsh";
		}

		if(issubstr(var_00,"keegan"))
		{
			self.npcid = "kgn";
		}

		if(issubstr(var_00,"merrick"))
		{
			self.npcid = "mrk";
		}

		if(issubstr(var_00,"elias"))
		{
			self.npcid = "els";
		}

		if(issubstr(var_00,"rorke"))
		{
			self.npcid = "rke";
		}

		if(issubstr(var_00,"ajax"))
		{
			self.npcid = "1";
		}

		if(issubstr(var_00,"kick"))
		{
			self.npcid = "0";
		}

		func_7080();
	}

	func_7080();
}

//Function Number: 3
func_34D3()
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

//Function Number: 4
aithreadthreader()
{
	self endon("death");
	self endon("removed from battleChatter");
	var_00 = 0.5;
	wait(var_00);
	thread aigrenadedangerwaiter();
	thread aifolloworderwaiter();
	if(self.team == "allies")
	{
		wait(var_00);
		thread aidisplacewaiter();
		if(self.var_1F85 == "CZ")
		{
			thread func_0A39();
		}
	}
	else if((self.team == "axis" || self.team == "team3") && !func_486F(self.var_1F85))
	{
		thread func_0A39();
	}

	if(self.team == level.player.team)
	{
		thread func_5E03();
	}

	wait(var_00);
	thread aibattlechatterloop();
}

//Function Number: 5
func_486F(param_00)
{
	if(param_00 == "UK" || param_00 == "US" || param_00 == "NS" || param_00 == "TF" || param_00 == "SS")
	{
		return 1;
	}

	return 0;
}

//Function Number: 6
func_7080()
{
	var_00 = level.var_87B2[self.voice];
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

	thread func_5740(var_03);
	self.npcid = var_00[var_03].npcid;
}

//Function Number: 7
func_5740(param_00)
{
	level.var_87B2[self.voice][param_00].count++;
	common_scripts\utility::func_8B4F("death","removed from battleChatter");
	if(!animscripts/battlechatter::func_1351())
	{
	}

	level.var_87B2[self.voice][param_00].count--;
}

//Function Number: 8
func_0A39()
{
	self endon("death");
	self endon("removed from battleChatter");
	wait(2);
	for(;;)
	{
		if(distancesquared(self.origin,level.player.origin) < 1048576)
		{
			if(isdefined(self.squad.var_51C0) && self.squad.var_51C0 > 1)
			{
				addreactionevent("taunt","hostileburst");
			}
		}

		wait(randomfloatrange(2,5));
	}
}

//Function Number: 9
aibattlechatterloop()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		animscripts/battlechatter::func_5D4E();
		wait(0.3 + randomfloat(0.2));
	}
}

//Function Number: 10
ainameandrankwaiter()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		self.bcname = animscripts/battlechatter::func_3B38();
		self.bcrank = animscripts/battlechatter::getrank();
		self waittill("set name and rank");
	}
}

//Function Number: 11
func_6594(param_00)
{
	if(!isalive(self) && animscripts/battlechatter::func_1351())
	{
		if(isdefined(self))
		{
			aideathfriendly();
			aideathenemy();
		}
	}

	if(isdefined(self))
	{
		self.battlechatter = 0;
		self.var_1B40 = 0;
	}

	self notify("removed from battleChatter");
	if(isdefined(self))
	{
		self.chatqueue = undefined;
		self.var_55FA = undefined;
		self.nextsaytimes = undefined;
		self.var_4968 = undefined;
		self.var_2F12 = undefined;
		self.var_195D = undefined;
		self.var_1F85 = undefined;
		self.npcid = undefined;
	}
}

//Function Number: 12
func_44E5()
{
	self.chatqueue = [];
	self.chatqueue["threat"] = spawnstruct();
	self.chatqueue["threat"].var_30A5 = 0;
	self.chatqueue["threat"].priority = 0;
	self.chatqueue["response"] = spawnstruct();
	self.chatqueue["response"].var_30A5 = 0;
	self.chatqueue["response"].priority = 0;
	self.chatqueue["reaction"] = spawnstruct();
	self.chatqueue["reaction"].var_30A5 = 0;
	self.chatqueue["reaction"].priority = 0;
	self.chatqueue["inform"] = spawnstruct();
	self.chatqueue["inform"].var_30A5 = 0;
	self.chatqueue["inform"].priority = 0;
	self.chatqueue["order"] = spawnstruct();
	self.chatqueue["order"].var_30A5 = 0;
	self.chatqueue["order"].priority = 0;
	self.chatqueue["custom"] = spawnstruct();
	self.chatqueue["custom"].var_30A5 = 0;
	self.chatqueue["custom"].priority = 0;
	self.var_55FA = gettime() + 50;
	self.nextsaytimes["threat"] = 0;
	self.nextsaytimes["reaction"] = 0;
	self.nextsaytimes["response"] = 0;
	self.nextsaytimes["inform"] = 0;
	self.nextsaytimes["order"] = 0;
	self.nextsaytimes["custom"] = 0;
	self.var_4968 = 0;
	self.bcs_minpriority = 0;
	self.allowedcallouts = [];
	if(common_scripts\utility::func_39CA() == "loki")
	{
		animscripts/battlechatter::addallowedthreatcallout("ai_contact_clock");
		animscripts/battlechatter::addallowedthreatcallout("ai_obvious");
	}
	else
	{
		animscripts/battlechatter::addallowedthreatcallout("rpg");
		animscripts/battlechatter::addallowedthreatcallout("exposed");
		animscripts/battlechatter::addallowedthreatcallout("ai_contact_clock");
		animscripts/battlechatter::addallowedthreatcallout("ai_target_clock");
		animscripts/battlechatter::addallowedthreatcallout("ai_cardinal");
		if(self.team == "allies")
		{
			if(common_scripts\utility::array_contains(level.var_5FCC,self.voice))
			{
				animscripts/battlechatter::addallowedthreatcallout("player_contact_clock");
				animscripts/battlechatter::addallowedthreatcallout("player_target_clock");
				animscripts/battlechatter::addallowedthreatcallout("player_cardinal");
				animscripts/battlechatter::addallowedthreatcallout("player_obvious");
				animscripts/battlechatter::addallowedthreatcallout("player_object_clock");
				animscripts/battlechatter::addallowedthreatcallout("player_location");
			}

			animscripts/battlechatter::addallowedthreatcallout("ai_location");
			animscripts/battlechatter::addallowedthreatcallout("generic_location");
			if(self.voice == "delta" || self.voice == "taskforce" || self.voice == "seal")
			{
				animscripts/battlechatter::addallowedthreatcallout("ai_obvious");
				animscripts/battlechatter::addallowedthreatcallout("ai_casual_clock");
				animscripts/battlechatter::addallowedthreatcallout("concat_location");
				animscripts/battlechatter::addallowedthreatcallout("concat_location");
				animscripts/battlechatter::addallowedthreatcallout("player_distance");
				animscripts/battlechatter::addallowedthreatcallout("player_target_clock_high");
				animscripts/battlechatter::addallowedthreatcallout("ai_distance");
				animscripts/battlechatter::addallowedthreatcallout("ai_target_clock_high");
			}
		}
	}

	if(isdefined(self.var_6B4F) && !self.var_6B4F)
	{
		self.battlechatter = 0;
	}
	else
	{
		self.battlechatter = level.battlechatter[self.team];
	}

	if(animscripts/battlechatter::voicecanburst())
	{
		self.var_341A = 1;
	}
	else
	{
		self.var_341A = 0;
	}

	if(level.var_357A)
	{
		maps\_utility::func_6EE8(1);
	}
	else
	{
		maps\_utility::func_6EE8(0);
	}

	self.var_1B40 = 1;
}

//Function Number: 13
addthreatevent(param_00,param_01,param_02)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::func_19F2("threat",param_00,param_02))
	{
	}

	if(animscripts/battlechatter::func_80A1(param_01) && !isplayer(param_01))
	{
	}

	var_03 = animscripts/battlechatter::func_20CE("threat",param_00,param_02);
	switch(param_00)
	{
		case "infantry":
			var_03.var_8093 = param_01;
			break;
	}

	if(isdefined(param_01.squad))
	{
		self.squad animscripts/battlechatter::func_86DE(param_01.squad.var_7998,self);
	}

	self.chatqueue["threat"] = undefined;
	self.chatqueue["threat"] = var_03;
}

//Function Number: 14
addresponseevent(param_00,param_01,param_02,param_03,param_04,param_05)
{
	thread addresponseevent_internal(param_00,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 15
addresponseevent_internal(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("death");
	self endon("removed from battleChatter");
	self endon("responseEvent_failsafe");
	thread func_663C(param_02);
	var_06 = param_02 common_scripts\utility::func_8B33("death","done speaking","cancel speaking");
	if(var_06 == "cancel speaking")
	{
	}

	if(!isalive(param_02))
	{
	}

	if(!animscripts/battlechatter::func_19F2("response",param_00,param_03,param_01))
	{
	}

	if(!isplayer(param_02))
	{
		if(animscripts/battlechatter::func_4996(param_02))
		{
		}
	}

	var_07 = animscripts/battlechatter::func_20CE("response",param_00,param_03);
	if(isdefined(param_04))
	{
		var_07.var_65C7 = param_04;
	}

	if(isdefined(param_05))
	{
		var_07.location = param_05;
	}

	var_07.respondto = param_02;
	var_07.var_531F = param_01;
	self.chatqueue["response"] = undefined;
	self.chatqueue["response"] = var_07;
}

//Function Number: 16
func_663C(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	param_00 endon("death");
	param_00 endon("done speaking");
	param_00 endon("cancel speaking");
	wait(25);
	self notify("responseEvent_failsafe");
}

//Function Number: 17
addinformevent(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::func_19F2("inform",param_00,param_03,param_01))
	{
	}

	var_04 = animscripts/battlechatter::func_20CE("inform",param_00,param_03);
	switch(param_00)
	{
		case "reloading":
			var_04.var_531F = param_01;
			var_04.var_44D8 = param_02;
			break;

		default:
			var_04.var_531F = param_01;
			break;
	}

	self.chatqueue["inform"] = undefined;
	self.chatqueue["inform"] = var_04;
}

//Function Number: 18
addreactionevent(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!isdefined(self.chatqueue))
	{
	}

	var_04 = animscripts/battlechatter::func_20CE("reaction",param_00,param_03);
	var_04.var_63C8 = param_02;
	var_04.var_531F = param_01;
	self.chatqueue["reaction"] = undefined;
	self.chatqueue["reaction"] = var_04;
}

//Function Number: 19
addorderevent(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::func_19F2("order",param_00,param_03,param_01))
	{
	}

	if(isdefined(param_02) && param_02.type == "dog")
	{
	}

	var_04 = animscripts/battlechatter::func_20CE("order",param_00,param_03);
	var_04.var_531F = param_01;
	var_04.var_59D9 = param_02;
	self.chatqueue["order"] = undefined;
	self.chatqueue["order"] = var_04;
}

//Function Number: 20
squadofficerwaiter()
{
	anim endon("battlechatter disabled");
	anim endon("squad deleted " + self.var_7998);
	for(;;)
	{
		var_00 = undefined;
		if(self.officers.size)
		{
			var_01 = self.officers;
		}
		else
		{
			var_01 = self.var_51C5;
		}

		var_02 = [];
		foreach(var_04 in var_01)
		{
			if(isalive(var_04))
			{
				var_02[var_02.size] = var_04;
			}
		}

		if(var_02.size)
		{
			var_00 = common_scripts\utility::func_3A56(level.player.origin,var_02);
			var_00 aiofficerorders();
			var_00 waittill("death");
		}

		wait(3);
	}
}

//Function Number: 21
getthreatsovertime(param_00,param_01)
{
	var_02 = param_00.size;
	if(var_02 == 0)
	{
		wait(param_01);
		return param_00;
	}

	var_03 = param_01 * 20;
	var_04 = var_02 / var_03;
	var_05 = [];
	for(var_06 = 0;var_06 < var_02;var_06++)
	{
		var_07 = param_00[var_06];
		if(!isdefined(var_07.var_2F12))
		{
			continue;
		}

		var_05[var_05.size] = param_00[var_06];
	}

	if(var_05.size == 0)
	{
		wait(param_01);
		return var_05;
	}

	var_05 = sortbydistance(var_05,level.player.origin);
	var_08 = [];
	var_09 = [];
	var_0A = 0;
	foreach(var_0C in var_05)
	{
		if(isdefined(var_0C) && func_809E(var_0C))
		{
			var_0D = var_0C animscripts/battlechatter::getlocation();
			if(isdefined(var_0D) && !animscripts/battlechatter::func_4EBD(var_0D))
			{
				var_08[var_08.size] = var_0C;
			}
			else
			{
				var_09[var_09.size] = var_0C;
			}
		}

		var_0A++;
		if(var_0A >= var_04)
		{
			wait(0.05);
			var_0A = 0;
		}
	}

	var_05 = [];
	foreach(var_10 in var_08)
	{
		var_05[var_05.size] = var_10;
	}

	foreach(var_10 in var_09)
	{
		var_05[var_05.size] = var_10;
	}

	return var_05;
}

//Function Number: 22
func_809E(param_00)
{
	if(distancesquared(level.player.origin,param_00.origin) > level.var_1345)
	{
		return 0;
	}

	if(!level.player animscripts/battlechatter::func_2F68(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 23
func_799E()
{
	anim endon("battlechatter disabled");
	anim endon("squad deleted " + self.var_7998);
	for(;;)
	{
		if(self.team == "allies")
		{
			var_00 = getthreatsovertime(getaiarray("axis","team3"),0.5);
		}
		else if(self.team == "team3")
		{
			var_00 = getthreatsovertime(getaiarray("allies","axis"),0.5);
		}
		else
		{
			wait(0.5);
			var_00 = getaiarray("allies","team3");
			var_00[var_00.size] = level.player;
		}

		if(!var_00.size)
		{
			continue;
		}

		var_01 = [];
		foreach(var_03 in self.var_51C5)
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

			foreach(var_0A, var_05 in var_00)
			{
				if(!isdefined(var_05))
				{
					if(var_0A == 0)
					{
						var_00 = [];
					}

					continue;
				}

				if(!isalive(var_05))
				{
					continue;
				}

				if(!isdefined(var_05.var_2F12))
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

					if(!maps\_utility::func_5D97(var_05,250))
					{
						continue;
					}
				}

				var_03 addthreatevent(var_05.var_2F12,var_05);
				var_01[var_01.size] = var_05;
				var_06 = [];
				foreach(var_08 in var_00)
				{
					if(var_08 != var_05)
					{
						var_06[var_06.size] = var_08;
					}
				}

				var_00 = var_06;
				break;
			}

			wait(0.05);
		}
	}
}

//Function Number: 24
aideathfriendly()
{
	var_00 = self.attacker;
	common_scripts\utility::func_F1B(self.squad.var_51C5,::aideatheventthread);
	if(isalive(var_00) && issentient(var_00) && isdefined(var_00.squad) && var_00.battlechatter)
	{
		if(isdefined(var_00.var_195D[var_00.squad.var_7998]))
		{
			var_00.var_195D[var_00.squad.var_7998] = undefined;
		}

		if(!isdefined(var_00.var_2F12))
		{
		}

		if(!var_00 animscripts/battlechatter::func_4804())
		{
		}

		foreach(var_02 in self.squad.var_51C5)
		{
			if(gettime() > var_02.var_4C5F + 2000)
			{
				continue;
			}

			var_02 addthreatevent(var_00.var_2F12,var_00);
		}
	}
}

//Function Number: 25
aideatheventthread()
{
	if(!isalive(self))
	{
	}

	self endon("death");
	self endon("removed from battleChatter");
	self notify("aiDeathEventThread");
	self endon("aiDeathEventThread");
	wait(1.5);
	addreactionevent("casualty","generic",self,0.9);
}

//Function Number: 26
aideathenemy()
{
	var_00 = self.attacker;
	if(!isalive(var_00) || !issentient(var_00) || !isdefined(var_00.squad))
	{
	}

	if(!isdefined(var_00.var_1F85))
	{
	}

	if(!isplayer(var_00))
	{
		if(var_00.var_1F85 == "GS" || var_00.var_1F85 == "GM" || var_00.var_1F85 == "GL")
		{
			var_00 thread aikilleventthread();
		}
	}
}

//Function Number: 27
aikilleventthread()
{
	self endon("death");
	self endon("removed from battleChatter");
	wait(1.5);
	addinformevent("killfirm","generic");
}

//Function Number: 28
aiofficerorders()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!isdefined(self.squad.var_1B40))
	{
		self.squad waittill("squad chat initialized");
	}

	for(;;)
	{
		if(getdvarint("bcs_enable") == 0)
		{
			wait(1);
			continue;
		}

		addsituationalorder();
		wait(randomfloatrange(3,6));
	}
}

//Function Number: 29
aigrenadedangerwaiter()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		self waittill("grenade danger",var_00);
		if(getdvarint("bcs_enable") == 0)
		{
			continue;
		}

		if(!isdefined(var_00) || var_00.model != "projectile_m67fraggrenade")
		{
			continue;
		}

		if(distancesquared(var_00.origin,level.player.origin) < 262144)
		{
			addinformevent("incoming","grenade");
		}
	}
}

//Function Number: 30
aidisplacewaiter()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		self waittill("trigger");
		if(getdvarint("bcs_enable") == 0)
		{
			continue;
		}

		if(gettime() < self.a.var_5AB7 + 4000)
		{
			continue;
		}

		addresponseevent("ack","yes",level.player,1);
	}
}

//Function Number: 31
func_2FE6(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::func_1351())
	{
	}

	if(!isdefined(self.node))
	{
	}

	if(distancesquared(self.origin,self.node.origin) < 262144)
	{
	}

	if(!animscripts/battlechatter::func_4919())
	{
	}

	if(!func_5576())
	{
	}

	var_01 = animscripts/battlechatter::func_3BD4(24,1024,"response");
	if(self.team != "axis" && self.team != "team3")
	{
		if(!isdefined(var_01))
		{
			var_01 = level.player;
		}
		else if(randomint(100) < level.eventchance["moveEvent"]["ordertoplayer"])
		{
			var_01 = level.player;
		}
	}

	if(self.combattime > 0)
	{
		if(randomint(100) < level.eventchance["moveEvent"]["coverme"])
		{
			addorderevent("action","coverme",var_01);
		}

		addorderevent("move","combat",var_01);
	}

	if(func_5577())
	{
		addorderevent("move","noncombat",var_01);
	}
}

//Function Number: 32
func_5576()
{
	if(self.var_1F85 == "SS")
	{
		return 0;
	}

	return 1;
}

//Function Number: 33
func_5577()
{
	if(self.var_1F85 == "US")
	{
		return 1;
	}

	return 0;
}

//Function Number: 34
aifolloworderwaiter()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		level waittill("follow order",var_00);
		if(!animscripts/battlechatter::func_1351())
		{
		}

		if(!isdefined(var_00))
		{
			continue;
		}

		if(!isalive(var_00) || var_00.team != self.team)
		{
			continue;
		}

		if(distancesquared(self.origin,var_00.origin) < 360000)
		{
			addresponseevent("ack","yes",var_00,0.9);
		}
	}
}

//Function Number: 35
func_5E03()
{
	self endon("death");
	self endon("removed from battleChatter");
	thread func_5E04();
	for(;;)
	{
		self waittill("bulletwhizby",var_00,var_01);
		if(!animscripts/battlechatter::func_1351())
		{
			continue;
		}

		if(!isplayer(var_00))
		{
			if(level.countryids[self.voice] == "GM" && animscripts/battlechatter::func_19F2("reaction","takingfire",1,undefined))
			{
				addreactionevent("takingfire",undefined,var_00,1);
			}

			continue;
		}

		if(friendlyfire_whizby_distances_valid(var_00,var_01))
		{
			func_5E02();
			wait(3);
		}
	}
}

//Function Number: 36
func_5E02()
{
	addreactionevent("friendlyfire",undefined,level.player,1);
}

//Function Number: 37
func_5E04()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04);
		if(isdefined(var_01) && isplayer(var_01))
		{
			if(damage_is_valid_for_friendlyfire_warning(var_04))
			{
				func_5E02();
			}
		}
	}
}

//Function Number: 38
damage_is_valid_for_friendlyfire_warning(param_00)
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

//Function Number: 39
friendlyfire_whizby_distances_valid(param_00,param_01)
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

//Function Number: 40
func_2FE7()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::func_1351())
	{
	}

	addinformevent("reloading","generic");
}

//Function Number: 41
evaluatemeleeevent()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::func_1351())
	{
		return 0;
	}

	if(!isdefined(self.enemy))
	{
		return 0;
	}

	return 0;
}

//Function Number: 42
evaluatefiringevent()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::func_1351())
	{
	}

	if(!isdefined(self.enemy))
	{
	}
}

//Function Number: 43
evaluatesuppressionevent()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::func_1351())
	{
	}

	if(!self.var_7D64)
	{
	}

	addinformevent("suppressed","generic");
}

//Function Number: 44
func_2FE3(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::func_1351())
	{
	}

	addinformevent("attack","grenade");
}

//Function Number: 45
addsituationalorder()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(self.squad.var_799D["combat"].isactive)
	{
		addsituationalcombatorder();
	}
}

//Function Number: 46
addsituationalcombatorder()
{
	self endon("death");
	self endon("removed from battleChatter");
	var_00 = self.squad;
	var_00 animscripts/squadmanager::func_8738();
	if(var_00.var_799D["suppressed"].isactive)
	{
		if(var_00.var_799D["cover"].isactive)
		{
			var_01 = animscripts/battlechatter::func_3BD4(96,512,"response");
			addorderevent("action","grenade",var_01);
		}
		else
		{
			addorderevent("displace","generic");
		}
	}
	else if(var_00.var_799D["combat"].isactive)
	{
		if(self.var_1F85 != "SS")
		{
			var_01 = animscripts/battlechatter::func_3BD4(24,1024,"response");
			addorderevent("action","suppress",var_01);
		}
	}
}

//Function Number: 47
custom_battlechatter_init_valid_phrases()
{
	var_00 = [];
	var_00[var_00.size] = "order_move_combat";
	var_00[var_00.size] = "order_move_noncombat";
	var_00[var_00.size] = "order_action_coverme";
	var_00[var_00.size] = "inform_reloading";
	level.custombcs_validphrases = var_00;
}

//Function Number: 48
func_221B(param_00)
{
	var_01 = 0;
	foreach(var_03 in level.custombcs_validphrases)
	{
		if(var_03 == param_00)
		{
			var_01 = 1;
			break;
		}
	}

	return var_01;
}

//Function Number: 49
get_phraseinvalidstr(param_00)
{
	return level.bcprintfailprefix + "custom battlechatter phrase \'" + param_00 + "\' isn\'t valid.  look at _utility::custom_battlechatter_init_valid_phrases(), or the util script documentation for custom_battlechatter(), for a list of valid phrases.";
}

//Function Number: 50
get_badcountryidstr(param_00)
{
	return level.bcprintfailprefix + "AI at origin " + self.origin + "wasn\'t able to play custom battlechatter because his nationality is \'" + self.var_1F85 + "\'.";
}

//Function Number: 51
func_221A(param_00)
{
	if(!isdefined(level.custombcs_validphrases))
	{
		custom_battlechatter_init_valid_phrases();
	}

	param_00 = tolower(param_00);
	if(!func_221B(param_00))
	{
		var_01 = get_phraseinvalidstr(param_00);
		return 0;
	}

	var_02 = animscripts/battlechatter::func_3BD4(24,512,"response");
	begincustomevent();
	switch(var_01)
	{
		case "order_move_combat":
			if(!func_5576())
			{
				return 0;
			}
	
			animscripts/battlechatter::tryorderto(self.var_2240,var_02);
			addmovecombataliasex();
			break;

		case "order_move_noncombat":
			if(!func_5577())
			{
				return 0;
			}
	
			addmovenoncombataliasex();
			break;

		case "order_action_coverme":
			animscripts/battlechatter::tryorderto(self.var_2240,var_02);
			addactioncovermealiasex();
			break;

		case "inform_reloading":
			addinformreloadingaliasex();
			break;

		default:
			var_01 = get_phraseinvalidstr(var_01);
			return 0;
	}

	endcustomevent(2000);
	return 1;
}

//Function Number: 52
begincustomevent()
{
	if(!animscripts/battlechatter::func_1351())
	{
	}

	self.var_2240 = animscripts/battlechatter::func_20CF();
}

//Function Number: 53
addactioncovermealiasex()
{
	self.var_2240 animscripts/battlechatter::addorderalias("action","coverme");
}

//Function Number: 54
addmovecombataliasex()
{
	self.var_2240 animscripts/battlechatter::addorderalias("move","combat");
}

//Function Number: 55
addmovenoncombataliasex()
{
	self.var_2240 animscripts/battlechatter::addorderalias("move","noncombat");
}

//Function Number: 56
addinformreloadingaliasex()
{
	self.var_2240 animscripts/battlechatter::addinformalias("reloading","generic");
}

//Function Number: 57
addnamealiasex(param_00)
{
	if(!animscripts/battlechatter::func_1351())
	{
	}

	self.var_2240 animscripts/battlechatter::addnamealias(param_00);
}

//Function Number: 58
endcustomevent(param_00,param_01)
{
	if(!animscripts/battlechatter::func_1351())
	{
	}

	var_02 = animscripts/battlechatter::func_20CE("custom","generic",1);
	if(isdefined(param_00))
	{
		var_02.var_30A5 = gettime() + param_00;
	}

	if(isdefined(param_01))
	{
		var_02.type = param_01;
	}
	else
	{
		var_02.type = "custom";
	}

	self.chatqueue["custom"] = undefined;
	self.chatqueue["custom"] = var_02;
}