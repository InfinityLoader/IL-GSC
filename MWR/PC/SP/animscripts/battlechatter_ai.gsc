/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\battlechatter_ai.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 43
 * Decompile Time: 760 ms
 * Timestamp: 10/27/2023 2:43:34 AM
*******************************************************************/

//Function Number: 1
addtosystem(param_00)
{
	self endon("death");
	if(!animscripts\battlechatter::bcsenabled())
	{
		return;
	}

	if(self.chatinitialized)
	{
		return;
	}

	if(!isdefined(self.squad.chatinitialized) || !self.squad.chatinitialized)
	{
		self.squad animscripts\battlechatter::init_squadbattlechatter();
	}

	self.enemyclass = "infantry";
	self.calledout = [];
	if(isplayer(self))
	{
		self.battlechatter = 0;
		self.type = "human";
		return;
	}

	if(self.type == "dog")
	{
		self.enemyclass = undefined;
		self.battlechatter = 0;
		return;
	}

	self.countryid = level.countryids[self.voice];
	if(isdefined(self.script_friendname))
	{
		var_01 = tolower(self.script_friendname);
		if(issubstr(var_01,"grigsby"))
		{
			self.npcid = "grg";
		}
		else if(issubstr(var_01,"griggs"))
		{
			self.npcid = "grg";
		}
		else if(issubstr(var_01,"price"))
		{
			self.npcid = "pri";
		}
		else if(issubstr(var_01,"gaz"))
		{
			self.npcid = "gaz";
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
		thread aiflankerwaiter();
		thread aidisplacewaiter();
	}

	wait(var_00);
	thread aibattlechatterloop();
}

//Function Number: 3
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

//Function Number: 4
npcidtracker(param_00)
{
	level.usedids[self.voice][param_00].count++;
	self waittill("death");
	if(!animscripts\battlechatter::bcsenabled())
	{
		return;
	}

	level.usedids[self.voice][param_00].count--;
}

//Function Number: 5
aibattlechatterloop()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		animscripts\battlechatter::playbattlechatter();
		wait(0.3 + randomfloat(0.2));
	}
}

//Function Number: 6
ainameandrankwaiter()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		self.bcname = animscripts\battlechatter::getname();
		self.bcrank = animscripts\battlechatter::getrank();
		self waittill("set name and rank");
	}
}

//Function Number: 7
removefromsystem(param_00)
{
	if(!isalive(self) && animscripts\battlechatter::bcsenabled())
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

//Function Number: 8
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
	if(isdefined(self.script_battlechatter) && !self.script_battlechatter)
	{
		self.battlechatter = 0;
	}
	else
	{
		self.battlechatter = level.battlechatter[self.team];
	}

	self.chatinitialized = 1;
}

//Function Number: 9
addthreatevent(param_00,param_01,param_02)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts\battlechatter::cansay("threat",param_00,param_02))
	{
		return;
	}

	if(isdefined(param_01.calledout) && isdefined(param_01.calledout[self.squad.squadname]))
	{
		return;
	}

	var_03 = animscripts\battlechatter::createchatevent("threat",param_00,param_02);
	switch(param_00)
	{
		case "infantry":
			break;

		case "vehicle":
			break;
	}
}

//Function Number: 10
addresponseevent(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts\battlechatter::cansay("response",param_00,param_03,param_01))
	{
		return;
	}

	if(param_02 != level.player)
	{
		if(isstring(param_02.npcid) && isstring(self.npcid) && param_02.npcid == self.npcid)
		{
			return;
		}
		else if(!isstring(param_02.npcid) && !isstring(self.npcid) && param_02.npcid == self.npcid)
		{
			return;
		}
	}

	var_04 = animscripts\battlechatter::createchatevent("response",param_00,param_03);
	switch(param_00)
	{
		case "killfirm":
			break;

		case "ack":
			break;
	}
}

//Function Number: 11
addinformevent(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts\battlechatter::cansay("inform",param_00,param_03,param_01))
	{
		return;
	}

	var_04 = animscripts\battlechatter::createchatevent("inform",param_00,param_03);
	switch(param_00)
	{
		case "reloading":
			break;

		default:
			break;
	}
}

//Function Number: 12
addreactionevent(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts\battlechatter::cansay("reaction",param_00,param_03,param_01))
	{
		return;
	}

	var_04 = animscripts\battlechatter::createchatevent("reaction",param_00,param_03);
	switch(param_00)
	{
		case "casualty":
			break;

		case "taunt":
			break;
	}
}

//Function Number: 13
addorderevent(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts\battlechatter::cansay("order",param_00,param_03,param_01))
	{
		return;
	}

	if(isdefined(param_02) && param_02.type == "dog")
	{
		return;
	}

	var_04 = animscripts\battlechatter::createchatevent("order",param_00,param_03);
	var_04.modifier = param_01;
	var_04.orderto = param_02;
	switch(param_00)
	{
	}

	self.chatqueue["order"] = undefined;
	self.chatqueue["order"] = var_04;
}

//Function Number: 14
squadofficerwaiter()
{
	anim endon("battlechatter disabled");
	anim endon("squad deleted " + self.squadname);
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
			var_00 = common_scripts\utility::getclosest(level.player.origin,var_02);
			var_00 aiofficerorders();
			var_00 waittill("death");
		}

		wait(3);
	}
}

//Function Number: 15
getthreats(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		if(!isdefined(param_00[var_02].enemyclass))
		{
			continue;
		}

		if(!level.player animscripts\battlechatter::pointinfov(param_00[var_02].origin))
		{
			continue;
		}

		param_00[var_02].threatid = var_01.size;
		var_01[var_01.size] = param_00[var_02];
	}

	return var_01;
}

//Function Number: 16
squadthreatwaiter()
{
	anim endon("battlechatter disabled");
	anim endon("squad deleted " + self.squadname);
	for(;;)
	{
		wait(randomfloatrange(0.25,0.75));
		var_00 = getthreats(getaiarray("axis"));
		if(!var_00.size)
		{
			continue;
		}

		var_01 = [];
		for(var_02 = 0;var_02 < self.members.size;var_02++)
		{
			if(!isalive(self.members[var_02]))
			{
				continue;
			}

			if(!var_00.size)
			{
				var_00 = var_01;
				var_01 = [];
			}

			for(var_03 = 0;var_03 < var_00.size;var_03++)
			{
				if(!isdefined(var_00[var_03]))
				{
					if(var_03 == 0)
					{
						var_00 = [];
					}

					continue;
				}

				if(!isalive(var_00[var_03]))
				{
					continue;
				}

				if(!self.members[var_02] cansee(var_00[var_03]))
				{
					continue;
				}

				self.members[var_02] addthreatevent(var_00[var_03].enemyclass,var_00[var_03]);
				var_01[var_01.size] = var_00[var_03];
				var_00[var_03] = undefined;
				var_00[var_03] = var_00[var_00.size - 1];
				var_00[var_00.size - 1] = undefined;
				if(!isdefined(var_00[0]))
				{
					var_00 = [];
				}

				break;
			}

			wait(0.05);
		}
	}
}

//Function Number: 17
flexiblethreatwaiter()
{
	anim endon("battlechatter disabled");
	anim endon("squad deleted " + self.squadname);
	for(;;)
	{
		wait(0.5);
		var_00 = filterthreats(getaiarray("axis"));
		if(!var_00.size)
		{
			continue;
		}

		var_01 = [];
		for(var_02 = 0;var_02 < self.members.size;var_02++)
		{
			if(!var_00.size)
			{
				var_00 = var_01;
				var_01 = [];
			}

			for(var_03 = 0;var_03 < var_00.size;var_03++)
			{
				if(!isdefined(var_00[var_03]))
				{
					if(var_03 == 0)
					{
						var_00 = [];
					}

					continue;
				}

				if(getdvar("bcs_threatLimitTargettedBySelf") == "on")
				{
					if(!isdefined(self.members[var_02].enemy) || var_00[var_03] != self.members[var_02].enemy)
					{
						continue;
					}

					if(gettime() > self.members[var_02].lastenemysighttime + 2000)
					{
						continue;
					}
				}
				else if(!self.members[var_02] cansee(var_00[var_03]))
				{
					continue;
				}

				if(getdvar("bcs_threatLimitSpeakerDist") != "off")
				{
					var_04 = int(getdvar("bcs_threatLimitSpeakerDist"));
					if(distance(level.player.origin,self.members[var_02].origin) > var_04)
					{
						continue;
					}
				}

				self.members[var_02] addthreatevent(var_00[var_03].enemyclass,var_00[var_03]);
				var_01[var_01.size] = var_00[var_03];
				var_00[var_03] = undefined;
				var_00[var_03] = var_00[var_00.size - 1];
				var_00[var_00.size - 1] = undefined;
				if(!isdefined(var_00[0]))
				{
					var_00 = [];
				}

				break;
			}
		}
	}
}

//Function Number: 18
filterthreats(param_00)
{
	var_01 = [];
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		if(!param_00[var_02].battlechatter)
		{
			continue;
		}

		if(getdvar("bcs_threatLimitTargetingPlayer") == "on")
		{
			if(!isdefined(param_00[var_02].enemy) || param_00[var_02].enemy != level.player)
			{
				continue;
			}
		}

		if(getdvar("bcs_threatLimitInPlayerFOV") == "on")
		{
			if(!level.player animscripts\battlechatter::pointinfov(param_00[var_02].origin))
			{
				continue;
			}
		}

		if(getdvar("bcs_threatLimitThreatDist") != "off")
		{
			var_03 = int(getdvar("bcs_threatLimitThreatDist"));
			if(distance(level.player.origin,param_00[var_02].origin) > var_03)
			{
				continue;
			}
		}

		if(getdvar("bcs_threatLimitInLocation") == "on")
		{
			if(!isdefined(param_00[var_02] animscripts\battlechatter::getlocation()) && !isdefined(param_00[var_02] animscripts\battlechatter::getlandmark()))
			{
				continue;
			}
		}

		param_00[var_02].threatid = var_01.size;
		var_01[var_01.size] = param_00[var_02];
	}

	return var_01;
}

//Function Number: 19
randomthreatwaiter()
{
	self endon("death");
	self endon("removed from battleChatter");
	anim endon("squad deleted " + self.squadname);
	for(;;)
	{
		if(getdvar("bcs_enable") == "off")
		{
			wait(1);
			continue;
		}

		var_00 = gettime();
		for(var_01 = 0;var_01 < self.members.size;var_01++)
		{
			if(!isdefined(self.members[var_01].enemy))
			{
				continue;
			}

			var_02 = self.members[var_01].enemy;
			if(!var_02.battlechatter)
			{
				continue;
			}

			if(!isdefined(var_02 animscripts\battlechatter::getlocation()) && !isdefined(var_02 animscripts\battlechatter::getlandmark()))
			{
				continue;
			}

			if(var_00 > self.members[var_01].lastenemysighttime + 2000)
			{
				continue;
			}

			self.squadlist[var_02.squad.squadname].calledout = 1;
			self.members[var_01] addthreatevent(var_02.enemyclass,var_02);
		}

		wait(1);
	}
}

//Function Number: 20
aithreatwaiter()
{
	self endon("death");
	self endon("removed from battleChatter");
}

//Function Number: 21
aideathfriendly()
{
	var_00 = self.attacker;
	if(isdefined(self))
	{
		for(var_01 = 0;var_01 < self.squad.members.size;var_01++)
		{
			if(isalive(self.squad.members[var_01]))
			{
				self.squad.members[var_01] thread aideatheventthread();
			}
		}
	}

	if(isalive(var_00) && issentient(var_00) && isdefined(var_00.squad) && var_00.battlechatter)
	{
		if(isdefined(var_00.calledout[var_00.squad.squadname]))
		{
			var_00.calledout[var_00.squad.squadname] = undefined;
		}

		for(var_01 = 0;var_01 < self.squad.members.size;var_01++)
		{
			if(!isdefined(var_00.enemyclass))
			{
				return;
			}

			if(!isdefined(var_00 animscripts\battlechatter::getlocation()) && !isdefined(var_00 animscripts\battlechatter::getlandmark()))
			{
				continue;
			}

			if(gettime() > self.squad.members[var_01].lastenemysighttime + 2000)
			{
				continue;
			}

			self.squad.members[var_01] addthreatevent(var_00.enemyclass,var_00);
		}
	}
}

//Function Number: 22
aideatheventthread()
{
	self endon("death");
	self endon("removed from battleChatter");
	wait(1.5);
	addreactionevent("casualty","generic",self,0.9);
}

//Function Number: 23
aideathenemy()
{
	var_00 = self.attacker;
	if(!isalive(var_00) || !issentient(var_00) || !isdefined(var_00.squad))
	{
		return;
	}

	if(isdefined(self.calledout[var_00.squad.squadname]) && isalive(self.calledout[var_00.squad.squadname].spotter) && self.calledout[var_00.squad.squadname].spotter != var_00 && gettime() < self.calledout[var_00.squad.squadname].expiretime)
	{
		if(var_00 == level.player)
		{
			return;
		}

		return;
	}

	if(var_00 != level.player)
	{
		var_00 thread aikilleventthread();
	}
}

//Function Number: 24
aikilleventthread()
{
	self endon("death");
	self endon("removed from battleChatter");
	wait(1.5);
	addinformevent("killfirm","infantry");
}

//Function Number: 25
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
		if(getdvar("bcs_enable") == "off")
		{
			wait(1);
			continue;
		}

		addsituationalorder();
		wait(randomfloatrange(3,6));
	}
}

//Function Number: 26
aigrenadedangerwaiter()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		self waittill("grenade danger",var_00);
		if(getdvar("bcs_enable") == "off")
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

//Function Number: 27
aiflankerwaiter()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		level waittill("flanker",var_00);
		if(getdvar("bcs_enable") == "off")
		{
			continue;
		}

		if(isdefined(self.customchatevent))
		{
			return;
		}

		begincustomevent();
		addthreataliasex("infantry","generic");
		addgenericaliasex("direction","relative",var_00);
		endcustomevent(2000);
	}
}

//Function Number: 28
aiflankerorderwaiter()
{
}

//Function Number: 29
aidisplacewaiter()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		self waittill("trigger");
		if(getdvar("bcs_enable") == "off")
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
	if(!animscripts\battlechatter::bcsenabled())
	{
		return;
	}

	if(!isdefined(self.node))
	{
		return;
	}

	var_01 = distance(self.origin,self.node.origin);
	if(var_01 < 250)
	{
		return;
	}

	if(!animscripts\battlechatter::isnodecover())
	{
		return;
	}

	var_02 = animscripts\battlechatter::getclosestspeaker("order",0);
	if(!isdefined(var_02) || distance(self.origin,var_02.origin) > 800)
	{
		var_02 = animscripts\battlechatter::getclosestspeaker("order");
	}

	if(isdefined(var_02) && distance(self.origin,var_02.origin) < 800 && self.combattime > 0)
	{
		level.moveorigin.origin = self.node.origin;
		var_03 = level.moveorigin animscripts\battlechatter::getlandmark();
		self.squad animscripts\squadmanager::updatestates();
		if(isdefined(var_03) && soundexists(var_02.countryid + "_" + var_02.npcid + "_order_cover_" + var_03.script_landmark))
		{
			var_02 addorderevent("cover",var_03.script_landmark,self);
			return;
		}

		if(self.squad.squadstates["move"].isactive)
		{
			var_02 addorderevent("move","forward",self);
			return;
		}

		var_02 addorderevent("cover","generic",self);
		return;
	}

	if(isdefined(var_02) && distance(self.origin,var_02.origin) < 600)
	{
		if(animscripts\battlechatter::isofficer())
		{
			addorderevent("move","follow",var_02);
			return;
		}

		if(self.combattime < 0)
		{
			return;
		}

		addorderevent("action","coverme",var_02);
		return;
	}

	if(distance(self.origin,level.player.origin) < 500)
	{
		if(self.combattime < 0)
		{
			return;
		}

		addorderevent("action","coverme",level.player);
		return;
	}
}

//Function Number: 31
aifolloworderwaiter()
{
	self endon("death");
	self endon("removed from battleChatter");
	for(;;)
	{
		level waittill("follow order",var_00);
		if(!animscripts\battlechatter::bcsenabled())
		{
			return;
		}

		if(var_00.team != self.team)
		{
			continue;
		}

		wait(1.5);
		if(!isalive(var_00))
		{
			continue;
		}

		if(!animscripts\battlechatter::cansay("response"))
		{
			continue;
		}

		if(distance(self.origin,var_00.origin) < 600)
		{
			addresponseevent("ack","follow",var_00);
		}
	}
}

//Function Number: 32
evaluatereloadevent()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts\battlechatter::bcsenabled())
	{
		return;
	}

	var_00 = animscripts\battlechatter::getclosestspeaker("response");
	if(isdefined(var_00) && isdefined(var_00.a.personimmeleeing))
	{
		var_00 = undefined;
	}

	addinformevent("reloading","generic");
}

//Function Number: 33
evaluatemeleeevent()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts\battlechatter::bcsenabled())
	{
		return 0;
	}

	if(!isdefined(self.enemy))
	{
		return 0;
	}

	return 0;
}

//Function Number: 34
evaluatefiringevent()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts\battlechatter::bcsenabled())
	{
		return;
	}

	if(!isdefined(self.enemy))
	{
	}
}

//Function Number: 35
evaluatesuppressionevent()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts\battlechatter::bcsenabled())
	{
		return;
	}

	if(!self.suppressed)
	{
		return;
	}

	addinformevent("suppressed","generic");
}

//Function Number: 36
evaluateattackevent(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!animscripts\battlechatter::bcsenabled())
	{
		return;
	}

	switch(param_00)
	{
		case "grenade":
			break;
	}
}

//Function Number: 37
addsituationalorder()
{
	self endon("death");
	self endon("removed from battleChatter");
	if(self.squad.squadstates["combat"].isactive)
	{
		addsituationalcombatorder();
		return;
	}

	addsituationalidleorder();
}

//Function Number: 38
addsituationalidleorder()
{
	self endon("death");
	self endon("removed from battleChatter");
	var_00 = self.squad;
	var_00 animscripts\squadmanager::updatestates();
	if(var_00.squadstates["move"].isactive)
	{
		addorderevent("move","generic");
	}
}

//Function Number: 39
addsituationalcombatorder()
{
	self endon("death");
	self endon("removed from battleChatter");
	var_00 = self.squad;
	var_00 animscripts\squadmanager::updatestates();
	if(var_00.squadstates["suppressed"].isactive)
	{
		if(var_00.squadstates["move"].isactive)
		{
			addorderevent("cover","generic");
			return;
		}

		if(var_00.squadstates["cover"].isactive)
		{
			addorderevent("action","grenade");
			return;
		}

		if(randomfloat(1) > 0.5)
		{
			addorderevent("displace","generic");
			return;
		}

		addorderevent("cover","generic");
		return;
	}

	if(self.team == "allies")
	{
		var_01 = getaiarray("axis");
	}
	else
	{
		var_01 = getaiarray("allies");
	}

	if(var_00.squadstates["attacking"].isactive)
	{
		var_02 = 0;
		for(var_03 = 0;var_03 < var_01.size;var_03++)
		{
			if(var_01[var_03] animscripts\battlechatter::isclaimednodewindow())
			{
				var_02 = 1;
			}
		}

		if(var_02)
		{
			addorderevent("attack","window");
			return;
		}

		addorderevent("action","boost");
		return;
	}

	if(var_00.squadstates["combat"].isactive)
	{
		var_02 = 0;
		for(var_03 = 0;var_03 < var_01.size;var_03++)
		{
			if(var_01[var_03] animscripts\battlechatter::isclaimednodewindow())
			{
				var_02 = 1;
			}
		}

		if(var_02)
		{
			addorderevent("attack","window");
			return;
		}

		addorderevent("action","suppress");
		return;
	}
}

//Function Number: 40
begincustomevent()
{
	if(!animscripts\battlechatter::bcsenabled())
	{
		return;
	}

	self.customchatphrase = animscripts\battlechatter::createchatphrase();
}

//Function Number: 41
addthreataliasex(param_00,param_01)
{
	if(!animscripts\battlechatter::bcsenabled())
	{
		return;
	}

	self.customchatphrase animscripts\battlechatter::addthreatalias(1,param_00,param_01);
}

//Function Number: 42
addgenericaliasex(param_00,param_01,param_02)
{
	if(!animscripts\battlechatter::bcsenabled())
	{
		return;
	}

	self.customchatphrase animscripts\battlechatter::addgenericalias(1,param_00,param_01,param_02);
}

//Function Number: 43
endcustomevent(param_00,param_01)
{
	if(!animscripts\battlechatter::bcsenabled())
	{
		return;
	}

	var_02 = animscripts\battlechatter::createchatevent("custom","generic",1);
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