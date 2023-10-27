/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\battlechatter_ai.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 55
 * Decompile Time: 899 ms
 * Timestamp: 10/27/2023 2:29:56 AM
*******************************************************************/

//Function Number: 1
addtosystem(param_00)
{
	self endon("death");
	if(!animscripts/battlechatter::bcsenabled())
	{
		return;
	}

	if(self.chatinitialized)
	{
		return;
	}

	if(!isdefined(self.squad.chatinitialized) || !self.squad.chatinitialized)
	{
		self.squad animscripts/battlechatter::func_6C4();
	}

	self.enemyclass = "infantry";
	self.calledout = [];
	if(isplayer(self))
	{
		self.battlechatter = 0;
		self.flavorbursts = 0;
		self.type = "human";
		return;
	}

	if(self.type == "dog")
	{
		self.enemyclass = undefined;
		self.battlechatter = 0;
		self.flavorbursts = 0;
		return;
	}

	if(self.team == "neutral")
	{
		self.enemyclass = undefined;
		self.battlechatter = 0;
		self.flavorbursts = 0;
		return;
	}

	if(forceenglish())
	{
		if(self.team == "allies")
		{
			self.script_battlechatter = 0;
		}
		else
		{
			self.voice = "american";
		}
	}

	self.countryid = level.countryids[self.voice];
	if(isdefined(self.script_friendname))
	{
		var_01 = tolower(self.script_friendname);
		if(issubstr(var_01,"price"))
		{
			self.npcid = "pri";
		}
		else if(issubstr(var_01,"mactavish") || issubstr(var_01,"soap"))
		{
			self.npcid = "mct";
		}
		else if(issubstr(var_01,"wallcroft"))
		{
			self.npcid = "wcf";
		}
		else if(issubstr(var_01,"griffin"))
		{
			self.npcid = "grf";
		}
		else if(issubstr(var_01,"grinch"))
		{
			self.npcid = "grn";
		}
		else if(issubstr(var_01,"truck"))
		{
			self.npcid = "trk";
		}
		else if(issubstr(var_01,"sandman"))
		{
			self.npcid = "snd";
		}
		else if(issubstr(var_01,"yuri"))
		{
			self.npcid = "yri";
		}
		else
		{
			setnpcid();
		}
	}
	else
	{
		setnpcid();
	}

	thread ainameandrankwaiter();
	init_aibattlechatter();
	thread aithreadthreader();
}

//Function Number: 2
forceenglish()
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
aithreadthreader()
{
	self endon("death");
	self endon("removed from battleChatter");
	var_00 = 0.5;
	wait var_00;
	thread aigrenadedangerwaiter();
	thread aifolloworderwaiter();
	if(self.team == "allies")
	{
		wait var_00;
		thread aidisplacewaiter();
		if(self.countryid == "CZ")
		{
			thread aihostileburstloop();
		}
	}
	else if((self.team == "axis" || self.team == "team3") && !isalliedcountryid(self.countryid))
	{
		thread aihostileburstloop();
	}

	if(self.team == level.player.team)
	{
		thread player_friendlyfire_waiter();
	}

	wait var_00;
	thread func_06D6();
}

//Function Number: 4
isalliedcountryid(param_00)
{
	if(param_00 == "UK" || param_00 == "US" || param_00 == "NS" || param_00 == "TF" || param_00 == "SS")
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
setnpcid()
{
	var_00 = level.usedids[self.voice];
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

	thread npcidtracker(var_03);
	self.npcid = var_00[var_03].npcid;
}

//Function Number: 6
npcidtracker(param_00)
{
	level.usedids[self.voice][param_00].count++;
	common_scripts\utility::waittill_either("death","removed from battleChatter");
	if(!animscripts/battlechatter::bcsenabled())
	{
		return;
	}

	level.usedids[self.voice][param_00].count--;
}

//Function Number: 7
aihostileburstloop()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		if(distance(self.origin,level.player.origin) < 1024)
		{
			if(isdefined(self.squad.membercount) && self.squad.membercount > 1)
			{
				addreactionevent("taunt","hostileburst");
			}
		}

		wait randomfloatrange(2,5);
	}
}

//Function Number: 8
func_06D6()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		animscripts/battlechatter::playbattlechatter();
		wait 0.3 + randomfloat(0.2);
	}
}

//Function Number: 9
ainameandrankwaiter()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		self.bcname = animscripts/battlechatter::getname();
		self.bcrank = animscripts/battlechatter::getrank();
		self waittill("set name and rank");
	}
}

//Function Number: 10
removefromsystem(param_00)
{
	if(!isalive(self) && animscripts/battlechatter::bcsenabled())
	{
		aideathfriendly();
		aideathenemy();
	}

	if(isdefined(self))
	{
		self.battlechatter = 0;
		self.chatinitialized = 0;
	}

	self notify("removed from battleChatter");
	if(isdefined(self))
	{
		self.chatqueue = undefined;
		self.nextsaytime = undefined;
		self.nextsaytimes = undefined;
		self.isspeaking = undefined;
		self.enemyclass = undefined;
		self.calledout = undefined;
		self.countryid = undefined;
		self.npcid = undefined;
	}
}

//Function Number: 11
init_aibattlechatter()
{
	self.chatqueue = [];
	self.chatqueue["threat"] = spawnstruct();
	self.chatqueue["threat"].expiretime = 0;
	self.chatqueue["threat"].priority = 0;
	self.chatqueue["response"] = spawnstruct();
	self.chatqueue["response"].expiretime = 0;
	self.chatqueue["response"].priority = 0;
	self.chatqueue["reaction"] = spawnstruct();
	self.chatqueue["reaction"].expiretime = 0;
	self.chatqueue["reaction"].priority = 0;
	self.chatqueue["inform"] = spawnstruct();
	self.chatqueue["inform"].expiretime = 0;
	self.chatqueue["inform"].priority = 0;
	self.chatqueue["order"] = spawnstruct();
	self.chatqueue["order"].expiretime = 0;
	self.chatqueue["order"].priority = 0;
	self.chatqueue["custom"] = spawnstruct();
	self.chatqueue["custom"].expiretime = 0;
	self.chatqueue["custom"].priority = 0;
	self.nextsaytime = gettime() + 50;
	self.nextsaytimes["threat"] = 0;
	self.nextsaytimes["reaction"] = 0;
	self.nextsaytimes["response"] = 0;
	self.nextsaytimes["inform"] = 0;
	self.nextsaytimes["order"] = 0;
	self.nextsaytimes["custom"] = 0;
	self.isspeaking = 0;
	self.bcs_minpriority = 0;
	self.allowedcallouts = [];
	animscripts/battlechatter::addallowedthreatcallout("rpg");
	animscripts/battlechatter::addallowedthreatcallout("exposed");
	if(self.voice != "shadowcompany")
	{
		if(self.voice != "british" && self.voice != "pmc")
		{
			animscripts/battlechatter::addallowedthreatcallout("ai_obvious");
		}

		animscripts/battlechatter::addallowedthreatcallout("ai_contact_clock");
		animscripts/battlechatter::addallowedthreatcallout("ai_target_clock");
		animscripts/battlechatter::addallowedthreatcallout("ai_cardinal");
	}

	if(self.voice == "delta")
	{
		animscripts/battlechatter::addallowedthreatcallout("player_distance");
		animscripts/battlechatter::addallowedthreatcallout("player_target_clock_high");
		animscripts/battlechatter::addallowedthreatcallout("ai_distance");
		animscripts/battlechatter::addallowedthreatcallout("ai_target_clock_high");
	}

	if(self.team == "allies")
	{
		if(maps\_utility::func_6E9(level.playernameids,self.voice))
		{
			animscripts/battlechatter::addallowedthreatcallout("player_contact_clock");
			animscripts/battlechatter::addallowedthreatcallout("player_target_clock");
			animscripts/battlechatter::addallowedthreatcallout("player_cardinal");
			if(self.voice != "british" && self.voice != "pmc")
			{
				animscripts/battlechatter::addallowedthreatcallout("player_obvious");
			}

			animscripts/battlechatter::addallowedthreatcallout("player_object_clock");
			if(self.voice != "french")
			{
				animscripts/battlechatter::addallowedthreatcallout("player_location");
			}
		}

		if(self.voice != "french")
		{
			animscripts/battlechatter::addallowedthreatcallout("ai_location");
			animscripts/battlechatter::addallowedthreatcallout("generic_location");
		}
	}

	if(isdefined(self.script_battlechatter) && !self.script_battlechatter)
	{
		self.battlechatter = 0;
	}
	else
	{
		self.battlechatter = level.battlechatter[self.team];
	}

	if(animscripts/battlechatter::voicecanburst())
	{
		self.flavorbursts = 1;
	}
	else
	{
		self.flavorbursts = 0;
	}

	if(level.friendlyfire_warnings)
	{
		maps\_utility::func_6EC(1);
	}
	else
	{
		maps\_utility::func_6EC(0);
	}

	self.chatinitialized = 1;
}

//Function Number: 12
addthreatevent(param_00,param_01,param_02)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::cansay("threat",param_00,param_02))
	{
		return;
	}

	if(animscripts/battlechatter::threatwasalreadycalledout(param_01) && !isplayer(param_01))
	{
		return;
	}

	var_03 = animscripts/battlechatter::createchatevent("threat",param_00,param_02);
	switch(param_00)
	{
		case "infantry":
			var_03.threat = param_01;
			break;
	}

	if(isdefined(param_01.squad))
	{
		self.squad animscripts/battlechatter::func_6F2(param_01.squad.var_67E,self);
	}

	self.chatqueue["threat"] = undefined;
	self.chatqueue["threat"] = var_03;
}

//Function Number: 13
addresponseevent(param_00,param_01,param_02,param_03,param_04,param_05)
{
	thread addresponseevent_internal(param_00,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 14
addresponseevent_internal(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("death");
	self endon("removed from battleChatter");
	self endon("responseEvent_failsafe");
	thread responseevent_failsafe(param_02);
	var_06 = param_02 common_scripts\utility::waittill_any_return("death","done speaking","cancel speaking");
	if(var_06 == "cancel speaking")
	{
		return;
	}

	if(!isalive(param_02))
	{
		return;
	}

	if(!animscripts/battlechatter::cansay("response",param_00,param_03,param_01))
	{
		return;
	}

	if(!isplayer(param_02))
	{
		if(animscripts/battlechatter::isusingsamevoice(param_02))
		{
			return;
		}
	}

	var_07 = animscripts/battlechatter::createchatevent("response",param_00,param_03);
	if(isdefined(param_04))
	{
		var_07.reportalias = param_04;
	}

	if(isdefined(param_05))
	{
		var_07.location = param_05;
	}

	var_07.respondto = param_02;
	var_07.var_6F8 = param_01;
	self.chatqueue["response"] = undefined;
	self.chatqueue["response"] = var_07;
}

//Function Number: 15
responseevent_failsafe(param_00)
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
addinformevent(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::cansay("inform",param_00,param_03,param_01))
	{
		return;
	}

	var_04 = animscripts/battlechatter::createchatevent("inform",param_00,param_03);
	switch(param_00)
	{
		case "reloading":
			var_04.var_6F8 = param_01;
			var_04.var_6FB = param_02;
			break;

		default:
			var_04.var_6F8 = param_01;
			break;
	}

	self.chatqueue["inform"] = undefined;
	self.chatqueue["inform"] = var_04;
}

//Function Number: 17
addreactionevent(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!isdefined(self.chatqueue))
	{
		return;
	}

	var_04 = animscripts/battlechatter::createchatevent("reaction",param_00,param_03);
	var_04.reactto = param_02;
	var_04.var_6F8 = param_01;
	self.chatqueue["reaction"] = undefined;
	self.chatqueue["reaction"] = var_04;
}

//Function Number: 18
addorderevent(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::cansay("order",param_00,param_03,param_01))
	{
		return;
	}

	if(isdefined(param_02) && param_02.type == "dog")
	{
		return;
	}

	var_04 = animscripts/battlechatter::createchatevent("order",param_00,param_03);
	var_04.var_6F8 = param_01;
	var_04.orderto = param_02;
	self.chatqueue["order"] = undefined;
	self.chatqueue["order"] = var_04;
}

//Function Number: 19
func_0700()
{
	anim endon("battlechatter disabled");
	anim endon("squad deleted " + self.var_67E);
	for(;;)
	{
		var_00 = undefined;
		if(self.officers.size)
		{
			var_01 = self.officers;
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
			var_00 aiofficerorders();
			var_00 waittill("death");
		}

		wait 3;
	}
}

//Function Number: 20
getthreats(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		if(!isdefined(param_00[var_02].enemyclass))
		{
			continue;
		}

		if(!threatisviable(param_00[var_02]))
		{
			continue;
		}

		param_00[var_02].threatid = var_01.size;
		var_01[var_01.size] = param_00[var_02];
	}

	var_01 = maps\_utility::get_array_of_closest(level.player.origin,var_01);
	var_03 = [];
	var_04 = [];
	foreach(var_06 in var_01)
	{
		var_07 = var_06 animscripts/battlechatter::getlocation();
		if(isdefined(var_07) && !animscripts/battlechatter::location_called_out_recently(var_07))
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
threatisviable(param_00)
{
	var_01 = level.bcs_maxthreatdistfromplayer * level.bcs_maxthreatdistfromplayer;
	if(distancesquared(level.player.origin,param_00.origin) > var_01)
	{
		return 0;
	}

	if(!level.player animscripts/battlechatter::entinfrontarc(param_00))
	{
		return 0;
	}

	return 1;
}

//Function Number: 22
squadthreatwaiter()
{
	anim endon("battlechatter disabled");
	anim endon("squad deleted " + self.var_67E);
	for(;;)
	{
		wait randomfloatrange(0.25,0.75);
		if(self.team == "allies")
		{
			var_00 = getthreats(getaiarray("axis","team3"));
		}
		else if(self.team == "team3")
		{
			var_00 = getthreats(getaiarray("allies","axis"));
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

				if(!isdefined(var_05.enemyclass))
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

				var_03 addthreatevent(var_05.enemyclass,var_05);
				var_01[var_01.size] = var_05;
				var_00 = common_scripts\utility::array_remove(var_00,var_05);
				break;
			}

			wait 0.05;
		}
	}
}

//Function Number: 23
aideathfriendly()
{
	var_00 = self.attacker;
	common_scripts\utility::array_thread(self.squad.members,::aideatheventthread);
	if(isalive(var_00) && issentient(var_00) && isdefined(var_00.squad) && var_00.battlechatter)
	{
		if(isdefined(var_00.calledout[var_00.squad.var_67E]))
		{
			var_00.calledout[var_00.squad.var_67E] = undefined;
		}

		if(!isdefined(var_00.enemyclass))
		{
			return;
		}

		if(!var_00 animscripts/battlechatter::is_in_callable_location())
		{
			return;
		}

		foreach(var_02 in self.squad.members)
		{
			if(gettime() > var_02.lastenemysighttime + 2000)
			{
				continue;
			}

			var_02 addthreatevent(var_00.enemyclass,var_00);
		}
	}
}

//Function Number: 24
aideatheventthread()
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
	addreactionevent("casualty","generic",self,0.9);
}

//Function Number: 25
aideathenemy()
{
	var_00 = self.attacker;
	if(!isalive(var_00) || !issentient(var_00) || !isdefined(var_00.squad))
	{
		return;
	}

	if(!isdefined(var_00.countryid) || var_00.countryid != "NS")
	{
		return;
	}

	if(!isplayer(var_00))
	{
		var_00 thread aikilleventthread();
	}
}

//Function Number: 26
aikilleventthread()
{
	self endon("death");
	self endon("removed from battleChatter");
	wait 1.5;
	addinformevent("killfirm","generic");
}

//Function Number: 27
aiofficerorders()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!isdefined(self.squad.chatinitialized))
	{
		self.squad waittill("squad chat initialized");
	}

	for(;;)
	{
		if(getdvar("bcs_enable","on") == "off")
		{
			wait 1;
			continue;
		}

		func_0726();
		wait randomfloatrange(3,6);
	}
}

//Function Number: 28
aigrenadedangerwaiter()
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
			addinformevent("incoming","grenade");
		}
	}
}

//Function Number: 29
aidisplacewaiter()
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

		if(gettime() < self.a.paintime + 4000)
		{
			continue;
		}

		addresponseevent("ack","yes",level.player,1);
	}
}

//Function Number: 30
evaluatemoveevent(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::bcsenabled())
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

	if(!animscripts/battlechatter::isnodecoverorconceal())
	{
		return;
	}

	if(!nationalityokformoveorder())
	{
		return;
	}

	var_02 = animscripts/battlechatter::getresponder(24,1024,"response");
	if(self.team != "axis" && self.team != "team3")
	{
		if(!isdefined(var_02))
		{
			var_02 = level.player;
		}
		else if(randomint(100) < level.eventchance["moveEvent"]["ordertoplayer"])
		{
			var_02 = level.player;
		}
	}

	if(self.combattime > 0)
	{
		if(randomint(100) < level.eventchance["moveEvent"]["coverme"])
		{
			addorderevent("action","coverme",var_02);
			return;
		}

		addorderevent("move","combat",var_02);
		return;
	}

	if(nationalityokformoveordernoncombat())
	{
		addorderevent("move","noncombat",var_02);
	}
}

//Function Number: 31
nationalityokformoveorder()
{
	if(self.countryid == "SS")
	{
		return 0;
	}

	return 1;
}

//Function Number: 32
nationalityokformoveordernoncombat()
{
	if(self.countryid == "US")
	{
		return 1;
	}

	return 0;
}

//Function Number: 33
aifolloworderwaiter()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		level waittill("follow order",var_00);
		if(!animscripts/battlechatter::bcsenabled())
		{
			return;
		}

		if(var_00.team != self.team)
		{
			continue;
		}

		if(distance(self.origin,var_00.origin) < 600)
		{
			addresponseevent("ack","yes",var_00,0.9);
		}
	}
}

//Function Number: 34
player_friendlyfire_waiter()
{
	self endon("death");
	self endon("removed from battleChatter");
	thread func_071E();
	for(;;)
	{
		self waittill("bulletwhizby",var_00,var_01);
		if(!animscripts/battlechatter::bcsenabled())
		{
			continue;
		}

		if(!isplayer(var_00))
		{
			continue;
		}

		if(friendlyfire_whizby_distances_valid(var_00,var_01))
		{
			player_friendlyfire_addreactionevent();
			wait 3;
		}
	}
}

//Function Number: 35
player_friendlyfire_addreactionevent()
{
	addreactionevent("friendlyfire",undefined,level.player,1);
}

//Function Number: 36
func_071E()
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
				player_friendlyfire_addreactionevent();
			}
		}
	}
}

//Function Number: 37
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

//Function Number: 38
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

//Function Number: 39
evaluatereloadevent()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::bcsenabled())
	{
		return;
	}

	addinformevent("reloading","generic");
}

//Function Number: 40
evaluatemeleeevent()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::bcsenabled())
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
evaluatefiringevent()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::bcsenabled())
	{
		return;
	}

	if(!isdefined(self.enemy))
	{
	}
}

//Function Number: 42
evaluatesuppressionevent()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::bcsenabled())
	{
		return;
	}

	if(!self.suppressed)
	{
		return;
	}

	addinformevent("suppressed","generic");
}

//Function Number: 43
evaluateattackevent(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts/battlechatter::bcsenabled())
	{
		return;
	}

	addinformevent("attack","grenade");
}

//Function Number: 44
func_0726()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(self.squad.squadstates["combat"].isactive)
	{
		addsituationalcombatorder();
	}
}

//Function Number: 45
addsituationalcombatorder()
{
	self endon("death");
	self endon("removed from battleChatter");
	var_00 = self.squad;
	var_00 animscripts/squadmanager::updatestates();
	if(var_00.squadstates["suppressed"].isactive)
	{
		if(var_00.squadstates["cover"].isactive)
		{
			var_01 = animscripts/battlechatter::getresponder(96,512,"response");
			addorderevent("action","grenade",var_01);
		}
		else
		{
			addorderevent("displace","generic");
		}
	}
	else if(var_00.squadstates["combat"].isactive)
	{
		if(self.countryid != "SS")
		{
			var_01 = animscripts/battlechatter::getresponder(24,1024,"response");
			addorderevent("action","suppress",var_01);
		}
	}
}

//Function Number: 46
custom_battlechatter_init_valid_phrases()
{
	var_00 = [];
	level.custombcs_validphrases = var_41;
}

//Function Number: 47
custom_battlechatter_validate_phrase(param_00)
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

//Function Number: 48
custom_battlechatter_internal(param_00)
{
	if(!isdefined(level.custombcs_validphrases))
	{
		custom_battlechatter_init_valid_phrases();
	}

	param_00 = tolower(param_00);
	var_01 = level.bcprintfailprefix + "custom battlechatter phrase \'" + param_00 + "\' isn\'t valid.  look at _utility::custom_battlechatter_init_valid_phrases(), or the util script documentation for custom_battlechatter(), for a list of valid phrases.";
	var_02 = level.bcprintfailprefix + "AI at origin " + self.origin + "wasn\'t able to play custom battlechatter because his nationality is \'" + self.countryid + "\'.";
	if(!custom_battlechatter_validate_phrase(param_00))
	{
		return 0;
	}

	var_03 = animscripts/battlechatter::getresponder(24,512,"response");
	begincustomevent();
	switch(param_00)
	{
		case "order_move_combat":
			if(!nationalityokformoveorder())
			{
				return 0;
			}
	
			animscripts/battlechatter::tryorderto(self.customchatphrase,var_03);
			addmovecombataliasex();
			break;

		case "order_move_noncombat":
			if(!nationalityokformoveordernoncombat())
			{
				return 0;
			}
	
			addmovenoncombataliasex();
			break;

		case "order_action_coverme":
			animscripts/battlechatter::tryorderto(self.customchatphrase,var_03);
			addactioncovermealiasex();
			break;

		case "inform_reloading":
			addinformreloadingaliasex();
			break;

		default:
			return 0;
	}

	endcustomevent(2000);
	return 1;
}

//Function Number: 49
begincustomevent()
{
	if(!animscripts/battlechatter::bcsenabled())
	{
		return;
	}

	self.customchatphrase = animscripts/battlechatter::createchatphrase();
}

//Function Number: 50
addactioncovermealiasex()
{
	self.customchatphrase animscripts/battlechatter::addorderalias("action","coverme");
}

//Function Number: 51
addmovecombataliasex()
{
	self.customchatphrase animscripts/battlechatter::addorderalias("move","combat");
}

//Function Number: 52
addmovenoncombataliasex()
{
	self.customchatphrase animscripts/battlechatter::addorderalias("move","noncombat");
}

//Function Number: 53
addinformreloadingaliasex()
{
	self.customchatphrase animscripts/battlechatter::addinformalias("reloading","generic");
}

//Function Number: 54
addnamealiasex(param_00)
{
	if(!animscripts/battlechatter::bcsenabled())
	{
		return;
	}

	self.customchatphrase animscripts/battlechatter::func_738(param_00);
}

//Function Number: 55
endcustomevent(param_00,param_01)
{
	if(!animscripts/battlechatter::bcsenabled())
	{
		return;
	}

	var_02 = animscripts/battlechatter::createchatevent("custom","generic",1);
	if(isdefined(param_00))
	{
		var_02.expiretime = gettime() + param_00;
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