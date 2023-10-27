/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\battlechatter.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 106
 * Decompile Time: 1769 ms
 * Timestamp: 10/27/2023 2:43:31 AM
*******************************************************************/

//Function Number: 1
init_battlechatter()
{
	if(isdefined(level.chatinitialized) && level.chatinitialized)
	{
		return;
	}

	if(getdvar("bcs_enable") == "")
	{
		setdvar("bcs_enable","on");
	}

	if(getdvar("bcs_enable") == "off")
	{
		anim.chatinitialized = 0;
		level.player.chatinitialized = 0;
		return;
	}

	anim.chatinitialized = 1;
	level.player.chatinitialized = 0;
	if(getdvar("bcs_filterThreat") == "")
	{
		setdvar("bcs_filterThreat","off");
	}

	if(getdvar("bcs_filterInform") == "")
	{
		setdvar("bcs_filterInform","off");
	}

	if(getdvar("bcs_filterOrder") == "")
	{
		setdvar("bcs_filterOrder","off");
	}

	if(getdvar("bcs_filterReaction") == "")
	{
		setdvar("bcs_filterReaction","off");
	}

	if(getdvar("bcs_filterResponse") == "")
	{
		setdvar("bcs_filterResponse","off");
	}

	if(getdvar("bcs_threatLimitTargettedBySelf") == "")
	{
		setdvar("bcs_threatLimitTargettedBySelf","off");
	}

	if(getdvar("bcs_threatLimitTargetingPlayer") == "")
	{
		setdvar("bcs_threatLimitTargetingPlayer","off");
	}

	if(getdvar("bcs_threatLimitInPlayerFOV") == "")
	{
		setdvar("bcs_threatLimitInPlayerFOV","on");
	}

	if(getdvar("bcs_threatLimitInLocation") == "")
	{
		setdvar("bcs_threatLimitInLocation","on");
	}

	if(getdvar("bcs_threatLimitSpeakerDist") == "")
	{
		setdvar("bcs_threatLimitSpeakerDist","512");
	}

	if(getdvar("bcs_threatLimitThreatDist") == "")
	{
		setdvar("bcs_threatLimitThreatDist","2048");
	}

	if(getdvar("bcs_threatPlayerRelative") == "")
	{
		setdvar("bcs_threatPlayerRelative","off");
	}

	if(getdvar("debug_bcprint") == "")
	{
		setdvar("debug_bcprint","off");
	}

	if(getdvar("debug_bcshowqueue") == "")
	{
		setdvar("debug_bcshowqueue","off");
	}

	if(getdvar("debug_bcprintdump") == "")
	{
		setdvar("debug_bcprintdump","off");
	}

	level.countryids["british"] = "UK";
	level.countryids["american"] = "US";
	level.countryids["russian"] = "RU";
	level.countryids["arab"] = "AB";
	anim.usedids = [];
	level.usedids["russian"] = [];
	level.usedids["russian"][0] = spawnstruct();
	level.usedids["russian"][0].count = 0;
	level.usedids["russian"][0].npcid = "0";
	level.usedids["russian"][1] = spawnstruct();
	level.usedids["russian"][1].count = 0;
	level.usedids["russian"][1].npcid = "1";
	level.usedids["russian"][2] = spawnstruct();
	level.usedids["russian"][2].count = 0;
	level.usedids["russian"][2].npcid = "3";
	level.usedids["british"] = [];
	level.usedids["british"][0] = spawnstruct();
	level.usedids["british"][0].count = 0;
	level.usedids["british"][0].npcid = "0";
	level.usedids["british"][1] = spawnstruct();
	level.usedids["british"][1].count = 0;
	level.usedids["british"][1].npcid = "1";
	level.usedids["british"][2] = spawnstruct();
	level.usedids["british"][2].count = 0;
	level.usedids["british"][2].npcid = "2";
	level.usedids["british"][3] = spawnstruct();
	level.usedids["british"][3].count = 0;
	level.usedids["british"][3].npcid = "3";
	level.usedids["american"] = [];
	level.usedids["american"][0] = spawnstruct();
	level.usedids["american"][0].count = 0;
	level.usedids["american"][0].npcid = "0";
	level.usedids["american"][1] = spawnstruct();
	level.usedids["american"][1].count = 0;
	level.usedids["american"][1].npcid = "1";
	level.usedids["american"][2] = spawnstruct();
	level.usedids["american"][2].count = 0;
	level.usedids["american"][2].npcid = "2";
	level.usedids["arab"] = [];
	level.usedids["arab"][0] = spawnstruct();
	level.usedids["arab"][0].count = 0;
	level.usedids["arab"][0].npcid = "0";
	level.usedids["arab"][1] = spawnstruct();
	level.usedids["arab"][1].count = 0;
	level.usedids["arab"][1].npcid = "1";
	level.usedids["arab"][2] = spawnstruct();
	level.usedids["arab"][2].count = 0;
	level.usedids["arab"][2].npcid = "2";
	level.usedids["arab"][3] = spawnstruct();
	level.usedids["arab"][3].count = 0;
	level.usedids["arab"][3].npcid = "3";
	anim.eventtypeminwait = [];
	level.eventtypeminwait["threat"] = [];
	level.eventtypeminwait["response"] = [];
	level.eventtypeminwait["reaction"] = [];
	level.eventtypeminwait["order"] = [];
	level.eventtypeminwait["inform"] = [];
	level.eventtypeminwait["custom"] = [];
	level.eventtypeminwait["direction"] = [];
	if(isdefined(level._stealth))
	{
		level.eventactionminwait["threat"]["self"] = 20000;
		level.eventactionminwait["threat"]["squad"] = 30000;
	}
	else
	{
		level.eventactionminwait["threat"]["self"] = 12000;
		level.eventactionminwait["threat"]["squad"] = 8000;
	}

	level.eventactionminwait["response"]["self"] = 1000;
	level.eventactionminwait["response"]["squad"] = 1000;
	level.eventactionminwait["reaction"]["self"] = 1000;
	level.eventactionminwait["reaction"]["squad"] = 1000;
	level.eventactionminwait["order"]["self"] = 8000;
	level.eventactionminwait["order"]["squad"] = 40000;
	level.eventactionminwait["inform"]["self"] = 6000;
	level.eventactionminwait["inform"]["squad"] = 8000;
	level.eventactionminwait["custom"]["self"] = 0;
	level.eventactionminwait["custom"]["squad"] = 5000;
	level.eventtypeminwait["reaction"]["casualty"] = 20000;
	level.eventtypeminwait["reaction"]["taunt"] = 200000;
	level.eventtypeminwait["inform"]["reloading"] = 20000;
	level.eventpriority["threat"]["infantry"] = 0.5;
	level.eventpriority["threat"]["vehicle"] = 0.7;
	level.eventpriority["response"]["killfirm"] = 0.8;
	level.eventpriority["response"]["ack"] = 0.9;
	level.eventpriority["reaction"]["casualty"] = 0.5;
	level.eventpriority["reaction"]["taunt"] = 0.9;
	level.eventpriority["order"]["cover"] = 0.9;
	level.eventpriority["order"]["action"] = 0.5;
	level.eventpriority["order"]["move"] = 0.9;
	level.eventpriority["order"]["displace"] = 0.5;
	level.eventpriority["inform"]["killfirm"] = 0.6;
	level.eventpriority["inform"]["attack"] = 0.9;
	level.eventpriority["inform"]["incoming"] = 0.8;
	level.eventpriority["inform"]["reloading"] = 0.2;
	level.eventpriority["inform"]["suppressed"] = 0.2;
	level.eventpriority["custom"]["generic"] = 1;
	level.eventduration["threat"]["infantry"] = 1000;
	level.eventduration["threat"]["vehicle"] = 1000;
	level.eventduration["response"]["killfirm"] = 3000;
	level.eventduration["response"]["ack"] = 2000;
	level.eventduration["reaction"]["casualty"] = 2000;
	level.eventduration["reaction"]["taunt"] = 2000;
	level.eventduration["order"]["cover"] = 3000;
	level.eventduration["order"]["action"] = 3000;
	level.eventduration["order"]["move"] = 3000;
	level.eventduration["order"]["displace"] = 3000;
	level.eventduration["inform"]["killfirm"] = 1000;
	level.eventduration["inform"]["attack"] = 1000;
	level.eventduration["inform"]["incoming"] = 1000;
	level.eventduration["inform"]["reloading"] = 1000;
	level.eventduration["inform"]["suppressed"] = 2000;
	level.eventduration["custom"]["generic"] = 1000;
	anim.chatcount = 0;
	anim.moveorigin = spawn("script_origin",(0,0,0));
	anim.areas = getentarray("trigger_location","targetname");
	anim.locations = getentarray("trigger_location","targetname");
	anim.landmarks = getentarray("trigger_landmark","targetname");
	level.squadcreatefuncs[level.squadcreatefuncs.size] = ::init_squadbattlechatter;
	level.squadcreatestrings[level.squadcreatestrings.size] = "::init_squadBattleChatter";
	level.isteamspeaking["allies"] = 0;
	level.isteamsaying["allies"]["threat"] = 0;
	level.isteamsaying["allies"]["order"] = 0;
	level.isteamsaying["allies"]["reaction"] = 0;
	level.isteamsaying["allies"]["response"] = 0;
	level.isteamsaying["allies"]["inform"] = 0;
	level.isteamsaying["allies"]["custom"] = 0;
	level.isteamspeaking["axis"] = 0;
	level.isteamsaying["axis"]["threat"] = 0;
	level.isteamsaying["axis"]["order"] = 0;
	level.isteamsaying["axis"]["reaction"] = 0;
	level.isteamsaying["axis"]["response"] = 0;
	level.isteamsaying["axis"]["inform"] = 0;
	level.isteamsaying["axis"]["custom"] = 0;
	level.isteamspeaking["neutral"] = 0;
	level.isteamsaying["neutral"]["threat"] = 0;
	level.isteamsaying["neutral"]["order"] = 0;
	level.isteamsaying["neutral"]["reaction"] = 0;
	level.isteamsaying["neutral"]["response"] = 0;
	level.isteamsaying["neutral"]["inform"] = 0;
	level.isteamsaying["neutral"]["custom"] = 0;
	if(!isdefined(level.battlechatter))
	{
		level.battlechatter = [];
		level.battlechatter["allies"] = 1;
		level.battlechatter["axis"] = 1;
		level.battlechatter["neutral"] = 1;
	}

	anim.lastteamspeaktime = [];
	level.lastteamspeaktime["allies"] = -5000;
	level.lastteamspeaktime["axis"] = -5000;
	for(var_00 = 0;var_00 < level.squadindex.size;var_00++)
	{
		if(isdefined(level.squadindex[var_00].chatinitialized) && level.squadindex[var_00].chatinitialized)
		{
			continue;
		}

		level.squadindex[var_00] init_squadbattlechatter();
	}

	level notify("battlechatter initialized");
	anim notify("battlechatter initialized");
}

//Function Number: 2
shutdown_battlechatter()
{
	anim.countryids = undefined;
	anim.eventtypeminwait = undefined;
	anim.eventactionminwait = undefined;
	anim.eventtypeminwait = undefined;
	anim.eventpriority = undefined;
	anim.eventduration = undefined;
	anim.chatcount = undefined;
	anim.moveorigin = undefined;
	anim.areas = undefined;
	anim.locations = undefined;
	anim.landmarks = undefined;
	anim.usedids = undefined;
	anim.chatinitialized = 0;
	level.player.chatinitialized = 0;
	level.battlechatter = undefined;
	for(var_00 = 0;var_00 < level.squadcreatefuncs.size;var_00++)
	{
		if(level.squadcreatestrings[var_00] != "::init_squadBattleChatter")
		{
			continue;
		}

		if(var_00 != level.squadcreatefuncs.size - 1)
		{
			level.squadcreatefuncs[var_00] = level.squadcreatefuncs[level.squadcreatefuncs.size - 1];
			level.squadcreatestrings[var_00] = level.squadcreatestrings[level.squadcreatestrings.size - 1];
		}

		level.squadcreatefuncs[level.squadcreatefuncs.size - 1] = undefined;
		level.squadcreatestrings[level.squadcreatestrings.size - 1] = undefined;
	}

	level notify("battlechatter disabled");
	anim notify("battlechatter disabled");
}

//Function Number: 3
init_squadbattlechatter()
{
	var_00 = self;
	var_00.numspeakers = 0;
	var_00.maxspeakers = 1;
	var_00.nextsaytime = gettime() + 50;
	var_00.nextsaytimes["threat"] = gettime() + 50;
	var_00.nextsaytimes["order"] = gettime() + 50;
	var_00.nextsaytimes["reaction"] = gettime() + 50;
	var_00.nextsaytimes["response"] = gettime() + 50;
	var_00.nextsaytimes["inform"] = gettime() + 50;
	var_00.nextsaytimes["custom"] = gettime() + 50;
	var_00.nexttypesaytimes["threat"] = [];
	var_00.nexttypesaytimes["order"] = [];
	var_00.nexttypesaytimes["reaction"] = [];
	var_00.nexttypesaytimes["response"] = [];
	var_00.nexttypesaytimes["inform"] = [];
	var_00.nexttypesaytimes["custom"] = [];
	var_00.ismembersaying["threat"] = 0;
	var_00.ismembersaying["order"] = 0;
	var_00.ismembersaying["reaction"] = 0;
	var_00.ismembersaying["response"] = 0;
	var_00.ismembersaying["inform"] = 0;
	var_00.ismembersaying["custom"] = 0;
	var_00.lastdirection = "";
	var_00.memberaddfuncs[var_00.memberaddfuncs.size] = ::animscripts\battlechatter_ai::addtosystem;
	var_00.memberaddstrings[var_00.memberaddstrings.size] = "::addToSystem";
	var_00.memberremovefuncs[var_00.memberremovefuncs.size] = ::animscripts\battlechatter_ai::removefromsystem;
	var_00.memberremovestrings[var_00.memberremovestrings.size] = "::removeFromSystem";
	var_00.squadupdatefuncs[var_00.squadupdatefuncs.size] = ::initcontact;
	var_00.squadupdatestrings[var_00.squadupdatestrings.size] = "::initContact";
	for(var_01 = 0;var_01 < level.squadindex.size;var_01++)
	{
		var_00 thread initcontact(level.squadindex[var_01].squadname);
	}

	var_00 thread animscripts\battlechatter_ai::squadthreatwaiter();
	var_00 thread animscripts\battlechatter_ai::squadofficerwaiter();
	var_00.chatinitialized = 1;
	var_00 notify("squad chat initialized");
}

//Function Number: 4
shutdown_squadbattlechatter()
{
	var_00 = self;
	var_00.numspeakers = undefined;
	var_00.maxspeakers = undefined;
	var_00.nextsaytime = undefined;
	var_00.nextsaytimes = undefined;
	var_00.nexttypesaytimes = undefined;
	var_00.ismembersaying = undefined;
	for(var_01 = 0;var_01 < var_00.memberaddfuncs.size;var_01++)
	{
		if(var_00.memberaddstrings[var_01] != "::addToSystem")
		{
			continue;
		}

		if(var_01 != var_00.memberaddfuncs.size - 1)
		{
			var_00.memberaddfuncs[var_01] = var_00.memberaddfuncs[var_00.memberaddfuncs.size - 1];
			var_00.memberaddstrings[var_01] = var_00.memberaddstrings[var_00.memberaddstrings.size - 1];
		}

		var_00.memberaddfuncs[var_00.memberaddfuncs.size - 1] = undefined;
		var_00.memberaddstrings[var_00.memberaddstrings.size - 1] = undefined;
	}

	for(var_01 = 0;var_01 < var_00.memberremovefuncs.size;var_01++)
	{
		if(var_00.memberremovestrings[var_01] != "::removeFromSystem")
		{
			continue;
		}

		if(var_01 != var_00.memberremovefuncs.size - 1)
		{
			var_00.memberremovefuncs[var_01] = var_00.memberremovefuncs[var_00.memberremovefuncs.size - 1];
			var_00.memberremovestrings[var_01] = var_00.memberremovestrings[var_00.memberremovestrings.size - 1];
		}

		var_00.memberremovefuncs[var_00.memberremovefuncs.size - 1] = undefined;
		var_00.memberremovestrings[var_00.memberremovestrings.size - 1] = undefined;
	}

	for(var_01 = 0;var_01 < var_00.squadupdatefuncs.size;var_01++)
	{
		if(var_00.squadupdatestrings[var_01] != "::initContact")
		{
			continue;
		}

		if(var_01 != var_00.squadupdatefuncs.size - 1)
		{
			var_00.squadupdatefuncs[var_01] = var_00.squadupdatefuncs[var_00.squadupdatefuncs.size - 1];
			var_00.squadupdatestrings[var_01] = var_00.squadupdatestrings[var_00.squadupdatestrings.size - 1];
		}

		var_00.squadupdatefuncs[var_00.squadupdatefuncs.size - 1] = undefined;
		var_00.squadupdatestrings[var_00.squadupdatestrings.size - 1] = undefined;
	}

	for(var_01 = 0;var_01 < level.squadindex.size;var_01++)
	{
		var_00 shutdowncontact(level.squadindex[var_01].squadname);
	}

	var_00.chatinitialized = 0;
}

//Function Number: 5
bcsenabled()
{
	return level.chatinitialized;
}

//Function Number: 6
bcsdebugwaiter()
{
	var_00 = getdvar("bcs_enable");
	var_01 = getdvar("bcs_enable");
	if(var_01 != var_00)
	{
		switch(var_01)
		{
			case "on":
				break;

			case "off":
				break;
		}
	}
}

//Function Number: 7
enablebattlechatter()
{
	init_battlechatter();
	level.player thread animscripts\battlechatter_ai::addtosystem();
	var_00 = getaiarray();
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] animscripts\battlechatter_ai::addtosystem();
	}
}

//Function Number: 8
disablebattlechatter()
{
	shutdown_battlechatter();
	var_00 = getaiarray();
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(isdefined(var_00[var_01].squad) && var_00[var_01].squad.chatinitialized)
		{
			var_00[var_01].squad shutdown_squadbattlechatter();
		}

		var_00[var_01] animscripts\battlechatter_ai::removefromsystem();
	}
}

//Function Number: 9
playbattlechatter()
{
	if(!bcsenabled())
	{
		return;
	}

	if(!self.battlechatter)
	{
		return;
	}

	if(self.isspeaking)
	{
		return;
	}

	if(self._animactive > 0)
	{
		return;
	}

	if(self.squad.numspeakers >= self.squad.maxspeakers)
	{
		return;
	}

	if(level.isteamspeaking[self.team])
	{
		return;
	}

	if(!isalive(self))
	{
		return;
	}

	self endon("death");
	var_00 = gethighestpriorityevent();
	if(!isdefined(var_00))
	{
		return;
	}

	switch(var_00)
	{
		case "custom":
			break;

		case "response":
			break;

		case "order":
			break;

		case "threat":
			break;

		case "reaction":
			break;

		case "inform":
			break;
	}
}

//Function Number: 10
playthreatevent()
{
	self endon("death");
	self endon("removed from battleChatter");
	self endon("cancel speaking");
	self.curevent = self.chatqueue["threat"];
	var_00 = self.chatqueue["threat"].threat;
	if(!isalive(var_00) || isdefined(var_00.calledout) && isdefined(var_00.calledout[self.squad.squadname]))
	{
		return;
	}

	anim thread lockaction(self,"threat");
	switch(self.chatqueue["threat"].eventtype)
	{
		case "infantry":
			break;

		case "dog":
			break;

		case "vehicle":
			break;
	}
}

//Function Number: 11
threatinfantry(param_00,param_01)
{
	self endon("cancel speaking");
	var_02 = createchatphrase();
	var_02.master = 1;
	if(!isdefined(param_01))
	{
		var_02.forcedetail = 0;
	}
	else
	{
		var_02.forcedetail = param_01;
	}

	var_02.threatent = param_00;
	if(self.voice == "british")
	{
		if(param_00 animscripts\pain::weaponanims() == "rocketlauncher")
		{
			var_02 threatinfantryrpg(param_00);
		}
		else
		{
			var_03 = getdirectioncompass(self.origin,param_00.origin);
			switch(var_03)
			{
				case "northwest":
					break;

				case "northeast":
					break;

				case "southwest":
					break;

				case "southeast":
					break;

				case "impossible":
					break;
			}
		}
	}
}

//Function Number: 12
threatdog(param_00,param_01)
{
	self endon("cancel speaking");
	var_02 = createchatphrase();
	var_02.master = 1;
	if(!isdefined(param_01))
	{
		var_02.forcedetail = 0;
	}
	else
	{
		var_02.forcedetail = param_01;
	}

	var_02.threatent = param_00;
	if(self.voice == "british")
	{
		var_03 = getdirectioncompass(self.origin,param_00.origin);
		switch(var_03)
		{
			case "northwest":
				break;

			case "northeast":
				break;

			case "southwest":
				break;

			case "southeast":
				break;

			case "impossible":
				break;
		}
	}
}

//Function Number: 13
threatinfantryexposed(param_00)
{
	if(!isdefined(param_00 getlandmark()))
	{
		addthreatalias(1,"infantry","exposed");
	}
	else
	{
		addthreatalias(1,"infantry","generic");
	}

	if(addlandmarkalias(1,param_00))
	{
		adddirectionalias(0.5,"relative",param_00);
		return;
	}

	adddirectionalias(1,"relative",param_00);
}

//Function Number: 14
threatinfantryrpg(param_00)
{
	addthreatalias(1,"rpg","generic");
	if(addareaalias(0.5,param_00) && self.areadetail)
	{
		return;
	}

	if(addlocationalias(0.5,param_00))
	{
		adddirectionalias(0.5,"side",param_00,self.locationent getorigin());
		return;
	}

	if(addlandmarkalias(0.5,param_00))
	{
		adddirectionalias(0.5,"relative",param_00);
	}
}

//Function Number: 15
threatinfantrymg(param_00)
{
	addthreatalias(1,"mg","generic");
	if(addareaalias(0.5,param_00) && self.areadetail)
	{
		return;
	}

	if(addlocationalias(0.5,param_00))
	{
		adddirectionalias(0.5,"side",param_00,self.locationent getorigin());
		return;
	}

	if(addlandmarkalias(0.5,param_00))
	{
		adddirectionalias(0.5,"relative",param_00);
	}
}

//Function Number: 16
playreactionevent()
{
	self endon("death");
	self endon("removed from battleChatter");
	self.curevent = self.chatqueue["reaction"];
	var_00 = self.chatqueue["reaction"].reactto;
	anim thread lockaction(self,"reaction");
	switch(self.chatqueue["reaction"].eventtype)
	{
		case "casualty":
			break;

		case "taunt":
			break;
	}
}

//Function Number: 17
reactioncasualty(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_02 = createchatphrase();
	var_02 addreactionalias(1,"casualty","generic");
	playphrase(var_02);
}

//Function Number: 18
reactiontaunt(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_02 = createchatphrase();
	var_02 addtauntalias(1,"taunt","generic");
	playphrase(var_02);
}

//Function Number: 19
playresponseevent()
{
	self endon("death");
	self endon("removed from battleChatter");
	self.curevent = self.chatqueue["response"];
	var_00 = self.chatqueue["response"].respondto;
	if(!isalive(var_00))
	{
		return;
	}

	if(self.chatqueue["response"].modifier == "follow" && self.a.state != "move")
	{
		return;
	}

	anim thread lockaction(self,"response");
	switch(self.chatqueue["response"].eventtype)
	{
		case "killfirm":
			break;

		case "ack":
			break;
	}
}

//Function Number: 20
responseacknowledge(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!isalive(param_00))
	{
		return;
	}

	var_02 = createchatphrase();
	var_02 addresponsealias(1,"ack",param_01);
	var_02.looktarget = param_00;
	playphrase(var_02);
}

//Function Number: 21
responsekillconfirm(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_02 = createchatphrase();
	var_02 addresponsealias(1,"killfirm","infantry");
	var_02.looktarget = param_00;
	playphrase(var_02);
}

//Function Number: 22
playorderevent()
{
	self endon("death");
	self endon("removed from battleChatter");
	self.curevent = self.chatqueue["order"];
	anim thread lockaction(self,"order");
	switch(self.chatqueue["order"].eventtype)
	{
		case "action":
			break;

		case "move":
			break;

		case "displace":
			break;

		case "cover":
			break;
	}
}

//Function Number: 23
ordermove(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_02 = createchatphrase();
	if(param_00 == "follow")
	{
		var_03 = getaiarray(self.team);
		param_01 = undefined;
		for(var_04 = 0;var_04 < var_03.size;var_04++)
		{
			if(var_03[var_04] == self)
			{
				continue;
			}

			if(distance(self.origin,var_03[var_04].origin) > 500 && var_03[var_04].a.state == "move" && var_03[var_04] cansay("response"))
			{
				param_01 = var_03[var_04];
			}
		}

		if(isdefined(param_01) && isdefined(param_01.bcname) && cansayname(param_01.bcname))
		{
			var_02 addnamealias(param_01.bcname);
			var_02.looktarget = param_01;
			param_01 animscripts\battlechatter_ai::addresponseevent("ack","follow",self,1);
		}
		else if(isdefined(param_01) && isdefined(param_01.bcrank))
		{
			var_02 addrankalias(param_01.bcrank);
			var_02.looktarget = param_01;
			param_01 animscripts\battlechatter_ai::addresponseevent("ack","follow",self,1);
		}
		else
		{
			level notify("follow order",self);
		}

		var_02 addorderalias(1,"move",param_00);
	}
	else
	{
		var_02 addorderalias(1,"move",param_00);
	}

	playphrase(var_02);
}

//Function Number: 24
orderdisplace(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_01 = createchatphrase();
	var_01 addorderalias(1,"displace",param_00);
	playphrase(var_01,1);
}

//Function Number: 25
orderaction(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_01 = createchatphrase();
	var_01 addorderalias(1,"action",param_00);
	playphrase(var_01);
}

//Function Number: 26
ordercover(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_02 = createchatphrase();
	if(randomfloat(1) < 0.5 && isofficer())
	{
		if(isdefined(param_01) && isdefined(param_01.bcrank))
		{
			var_02 addrankalias(param_01.bcrank);
			var_02.looktarget = param_01;
		}
	}
	else if(isdefined(param_01) && isdefined(param_01.bcname) && cansayname(param_01.bcname))
	{
		var_02 addnamealias(param_01.bcname);
		var_02.looktarget = param_01;
	}
	else if(isdefined(param_01) && isdefined(param_01.bcrank))
	{
		var_02 addrankalias(param_01.bcrank);
		var_02.looktarget = param_01;
	}

	var_02 addorderalias(1,"cover",param_00);
	playphrase(var_02);
}

//Function Number: 27
playinformevent()
{
	self endon("death");
	self endon("removed from battleChatter");
	self.curevent = self.chatqueue["inform"];
	anim thread lockaction(self,"inform");
	switch(self.chatqueue["inform"].eventtype)
	{
		case "killfirm":
			break;

		case "incoming":
			break;

		case "attack":
			break;

		case "reloading":
			break;

		case "suppressed":
			break;
	}
}

//Function Number: 28
informreloading(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_02 = createchatphrase();
	if(param_01 == "coverme" && isalive(param_00) && isdefined(param_00.bcname) && cansayname(param_00.bcname))
	{
		if(param_00 == level.player || self.countryid != "US")
		{
			param_01 = "generic";
		}
		else
		{
			param_01 = param_00.bcname;
			param_00 animscripts\battlechatter_ai::addresponseevent("ack","covering",self,0.9);
			var_02.looktarget = param_00;
		}
	}
	else
	{
		param_01 = "generic";
	}

	var_02 addinformalias(1,"reloading",param_01);
	playphrase(var_02);
}

//Function Number: 29
informsupressed(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_01 = createchatphrase();
	var_01 addinformalias(1,"suppressed",param_00);
	playphrase(var_01);
}

//Function Number: 30
informincoming(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_01 = createchatphrase();
	if(param_00 == "grenade")
	{
		var_01.master = 1;
	}

	var_01 addinformalias(1,"incoming",param_00);
	playphrase(var_01);
}

//Function Number: 31
informattacking(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_01 = createchatphrase();
	var_01 addinformalias(1,"attack",param_00);
	playphrase(var_01);
}

//Function Number: 32
informkillconfirm(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_01 = createchatphrase();
	var_01 addinformalias(1,"killfirm","infantry");
	playphrase(var_01);
}

//Function Number: 33
playcustomevent()
{
	self endon("death");
	self endon("removed from battleChatter");
	self.curevent = self.chatqueue["custom"];
	anim thread lockaction(self,self.curevent.type,1);
	playphrase(self.customchatphrase);
	self notify("done speaking");
	self.customchatevent = undefined;
	self.customchatphrase = undefined;
}

//Function Number: 34
playphrase(param_00,param_01)
{
	anim endon("battlechatter disabled");
	self endon("death");
	if(isdefined(param_01))
	{
		return;
	}

	if(isdefined(level._stealth) && self.voice == "british")
	{
		for(var_02 = 0;var_02 < param_00.soundaliases.size;var_02++)
		{
			param_00.soundaliases[var_02] = param_00.soundaliases[var_02] + "_s";
		}
	}

	if(battlechatter_canprint())
	{
		for(var_02 = 0;var_02 < param_00.soundaliases.size;var_02++)
		{
			battlechatter_print(param_00.soundaliases[var_02]);
		}

		battlechatter_println("");
	}

	thread battlechatter_printdump(param_00.soundaliases);
	for(var_02 = 0;var_02 < param_00.soundaliases.size;var_02++)
	{
		if(!self.battlechatter)
		{
			continue;
		}

		if(self._animactive > 0)
		{
			continue;
		}

		if(isfiltered(self.curevent.eventaction))
		{
			wait(0.85);
			continue;
		}

		var_03 = gettime();
		if(param_00.master && self.team == "allies")
		{
			if(getdvar("bcs_threatPlayerRelative") == "on")
			{
				if(strfind(param_00.soundaliases[var_02],"_direction_"))
				{
					if(isdefined(param_00.threatent))
					{
						param_00.soundaliases[var_02] = param_00 getdirectionaliasplayerrelative(param_00.threatent);
					}
				}
			}

			self playsoundasmaster(param_00.soundaliases[var_02],param_00.soundaliases[var_02],1);
			thread maps\_anim::anim_facialfiller(param_00.soundaliases[var_02],param_00.looktarget);
			self waittill(param_00.soundaliases[var_02]);
			continue;
		}

		self playsound(param_00.soundaliases[var_02],param_00.soundaliases[var_02],1);
		thread maps\_anim::anim_facialfiller(param_00.soundaliases[var_02],param_00.looktarget);
		self waittill(param_00.soundaliases[var_02]);
	}

	dotypelimit(self.curevent.eventaction,self.curevent.eventtype);
}

//Function Number: 35
isspeakingfailsafe(param_00)
{
	self endon("death");
	wait(45);
	clearisspeaking(param_00);
}

//Function Number: 36
clearisspeaking(param_00)
{
	self.isspeaking = 0;
	self.chatqueue[param_00].expiretime = 0;
	self.chatqueue[param_00].priority = 0;
	self.nextsaytimes[param_00] = gettime() + level.eventactionminwait[param_00]["self"];
}

//Function Number: 37
lockaction(param_00,param_01,param_02)
{
	anim endon("battlechatter disabled");
	var_03 = param_00.squad;
	var_04 = param_00.team;
	param_00.isspeaking = 1;
	param_00 thread isspeakingfailsafe(param_01);
	var_03.ismembersaying[param_01] = 1;
	var_03.numspeakers++;
	level.isteamspeaking[var_04] = 1;
	level.isteamsaying[var_04][param_01] = 1;
	var_05 = param_00 common_scripts\utility::waittill_any_return("death","done speaking","cancel speaking");
	var_03.ismembersaying[param_01] = 0;
	var_03.numspeakers--;
	level.isteamspeaking[var_04] = 0;
	level.isteamsaying[var_04][param_01] = 0;
	level.lastteamspeaktime[var_04] = gettime();
	if(var_05 == "cancel speaking")
	{
		return;
	}

	if(isalive(param_00))
	{
		param_00 clearisspeaking(param_01);
	}

	var_03.nextsaytimes[param_01] = gettime() + level.eventactionminwait[param_01]["squad"];
}

//Function Number: 38
updatecontact(param_00,param_01)
{
	if(gettime() - self.squadlist[param_00].lastcontact > 10000)
	{
		var_02 = 0;
		for(var_03 = 0;var_03 < self.members.size;var_03++)
		{
			if(self.members[var_03] != param_01 && isalive(self.members[var_03].enemy) && isdefined(self.members[var_03].enemy.squad) && self.members[var_03].enemy.squad.squadname == param_00)
			{
				var_02 = 1;
			}
		}

		if(!var_02)
		{
			self.squadlist[param_00].firstcontact = gettime();
			self.squadlist[param_00].calledout = 0;
		}
	}

	self.squadlist[param_00].lastcontact = gettime();
}

//Function Number: 39
cansay(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(self == level.player)
	{
		return 0;
	}

	if(!isdefined(self.battlechatter) || !self.battlechatter)
	{
		return 0;
	}

	if(isdefined(param_02) && param_02 >= 1)
	{
		return 1;
	}

	if(gettime() + level.eventactionminwait[param_00]["self"] < self.nextsaytimes[param_00])
	{
		return 0;
	}

	if(gettime() + level.eventactionminwait[param_00]["squad"] < self.squad.nextsaytimes[param_00])
	{
		return 0;
	}

	if(isdefined(param_01) && typelimited(param_00,param_01))
	{
		return 0;
	}

	if(isdefined(param_01) && level.eventpriority[param_00][param_01] < self.bcs_minpriority)
	{
		return 0;
	}

	if(self.voice == "british")
	{
		return britfilter(param_00,param_01,param_03);
	}

	return 1;
}

//Function Number: 40
britfilter(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = "";
	}

	if(!isdefined(param_01))
	{
		return 0;
	}

	switch(param_00)
	{
		case "order":
			break;

		case "threat":
			break;

		case "inform":
			break;

		case "reaction":
			break;

		default:
			break;
	}
}

//Function Number: 41
gethighestpriorityevent()
{
	var_00 = undefined;
	var_01 = -999999999;
	if(isvalidevent("custom"))
	{
		var_00 = "custom";
		var_01 = self.chatqueue["custom"].priority;
	}

	if(isvalidevent("response"))
	{
		if(self.chatqueue["response"].priority > var_01)
		{
			var_00 = "response";
			var_01 = self.chatqueue["response"].priority;
		}
	}

	if(isvalidevent("order"))
	{
		if(self.chatqueue["order"].priority > var_01)
		{
			var_00 = "order";
			var_01 = self.chatqueue["order"].priority;
		}
	}

	if(isvalidevent("threat"))
	{
		if(self.chatqueue["threat"].priority > var_01)
		{
			var_00 = "threat";
			var_01 = self.chatqueue["threat"].priority;
		}
	}

	if(isvalidevent("inform"))
	{
		if(self.chatqueue["inform"].priority > var_01)
		{
			var_00 = "inform";
			var_01 = self.chatqueue["inform"].priority;
		}
	}

	if(isvalidevent("reaction"))
	{
		if(self.chatqueue["reaction"].priority > var_01)
		{
			var_00 = "reaction";
			var_01 = self.chatqueue["reaction"].priority;
		}
	}

	return var_00;
}

//Function Number: 42
gettargettingai(param_00)
{
	var_01 = self.squad;
	var_02 = [];
	for(var_03 = 0;var_03 < var_01.members.size;var_03++)
	{
		if(isdefined(var_01.members[var_03].enemy) && var_01.members[var_03].enemy == param_00)
		{
			var_02[var_02.size] = var_01.members[var_03];
		}
	}

	if(!isdefined(var_02[0]))
	{
		return undefined;
	}

	var_04 = undefined;
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(var_02[var_03] cansay("response"))
		{
			return var_04;
		}
	}

	return common_scripts\utility::getclosest(self.origin,var_02);
}

//Function Number: 43
getqueueevents()
{
	var_00 = [];
	var_01 = [];
	var_00[0] = "custom";
	var_00[1] = "response";
	var_00[2] = "order";
	var_00[3] = "threat";
	var_00[4] = "inform";
	for(var_02 = var_00.size - 1;var_02 >= 0;var_02--)
	{
		for(var_03 = 1;var_03 <= var_02;var_03++)
		{
			if(self.chatqueue[var_00[var_03 - 1]].priority < self.chatqueue[var_00[var_03]].priority)
			{
				var_04 = var_00[var_03 - 1];
				var_00[var_03 - 1] = var_00[var_03];
				var_00[var_03] = var_04;
			}
		}
	}

	var_05 = 0;
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		var_06 = geteventstate(var_00[var_02]);
		if(var_06 == " valid" && !var_05)
		{
			var_05 = 1;
			var_01[var_02] = "g " + var_00[var_02] + var_06 + " " + self.chatqueue[var_00[var_02]].priority;
			continue;
		}

		if(var_06 == " valid")
		{
			var_01[var_02] = "y " + var_00[var_02] + var_06 + " " + self.chatqueue[var_00[var_02]].priority;
			continue;
		}

		if(self.chatqueue[var_00[var_02]].expiretime == 0)
		{
			var_01[var_02] = "b " + var_00[var_02] + var_06 + " " + self.chatqueue[var_00[var_02]].priority;
			continue;
		}

		var_01[var_02] = "r " + var_00[var_02] + var_06 + " " + self.chatqueue[var_00[var_02]].priority;
	}

	return var_01;
}

//Function Number: 44
geteventstate(param_00)
{
	var_01 = "";
	if(self.squad.ismembersaying[param_00])
	{
		var_01 = var_01 + " playing";
	}

	if(gettime() > self.chatqueue[param_00].expiretime)
	{
		var_01 = var_01 + " expired";
	}

	if(gettime() < self.squad.nextsaytimes[param_00])
	{
		var_01 = var_01 + " cantspeak";
	}

	if(var_01 == "")
	{
		var_01 = " valid";
	}

	return var_01;
}

//Function Number: 45
isfiltered(param_00)
{
	if(getdvar("bcs_filter" + param_00) == "on" || getdvar("bcs_filter" + param_00) == "1")
	{
		return 1;
	}

	return 0;
}

//Function Number: 46
isvalidevent(param_00)
{
	if(!self.squad.ismembersaying[param_00] && !level.isteamsaying[self.team][param_00] && gettime() < self.chatqueue[param_00].expiretime && gettime() > self.squad.nextsaytimes[param_00])
	{
		if(!typelimited(param_00,self.chatqueue[param_00].eventtype))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 47
typelimited(param_00,param_01)
{
	if(!isdefined(level.eventtypeminwait[param_00][param_01]))
	{
		return 0;
	}

	if(!isdefined(self.squad.nexttypesaytimes[param_00][param_01]))
	{
		return 0;
	}

	if(gettime() > self.squad.nexttypesaytimes[param_00][param_01])
	{
		return 0;
	}

	return 1;
}

//Function Number: 48
dotypelimit(param_00,param_01)
{
	if(!isdefined(level.eventtypeminwait[param_00][param_01]))
	{
		return;
	}

	self.squad.nexttypesaytimes[param_00][param_01] = gettime() + level.eventtypeminwait[param_00][param_01];
}

//Function Number: 49
bcissniper()
{
	if(isplayer(self))
	{
		return 0;
	}

	if(isexposed())
	{
		return 0;
	}

	return animscripts\utility::issniperrifle(self.weapon);
}

//Function Number: 50
isexposed()
{
	if(isdefined(getlocation()))
	{
		return 0;
	}

	var_00 = bcgetclaimednode();
	if(!isdefined(var_00))
	{
		return 1;
	}

	if(var_00.type[0] == "C" && var_00.type[1] == "o" && var_00.type[2] == "v")
	{
		return 0;
	}

	return 1;
}

//Function Number: 51
isclaimednodecover()
{
	var_00 = bcgetclaimednode();
	if(!isdefined(var_00))
	{
		return 0;
	}

	if(var_00.type[0] == "C" && var_00.type[1] == "o" && var_00.type[2] == "v")
	{
		return 1;
	}

	return 0;
}

//Function Number: 52
isclaimednodewindow()
{
	var_00 = bcgetclaimednode();
	if(!isdefined(var_00))
	{
		return 0;
	}

	if(!isdefined(var_00.script_location))
	{
		return 0;
	}

	if(var_00.script_location == "window")
	{
		return 1;
	}

	return 0;
}

//Function Number: 53
isnodecover()
{
	var_00 = self.node;
	if(!isdefined(var_00))
	{
		return 0;
	}

	if(var_00.type[0] == "C" && var_00.type[1] == "o" && var_00.type[2] == "v")
	{
		return 1;
	}

	return 0;
}

//Function Number: 54
isofficer()
{
	var_00 = getrank();
	if(var_00 == "sergeant" || var_00 == "lieutenant" || var_00 == "captain" || var_00 == "sergeant")
	{
		return 1;
	}

	return 0;
}

//Function Number: 55
bcgetclaimednode()
{
	if(isplayer(self))
	{
		var_00 = self.node;
		return;
	}

	var_00 = animscripts\utility::getclaimednode();
}

//Function Number: 56
getname()
{
	if(self.team == "axis")
	{
		var_00 = self.ainame;
	}
	else if(self.team == "allies")
	{
		var_00 = self.name;
	}
	else
	{
		var_00 = undefined;
	}

	if(!isdefined(var_00) || self.voice == "british")
	{
		return undefined;
	}

	var_01 = strtok(var_00," ");
	if(var_01.size < 2)
	{
		return undefined;
	}

	return var_01[1];
}

//Function Number: 57
getrank()
{
	return self.airank;
}

//Function Number: 58
getclosestspeaker(param_00,param_01)
{
	var_02 = getspeakers(param_00,param_01);
	var_03 = common_scripts\utility::getclosest(self.origin,var_02);
	return var_03;
}

//Function Number: 59
getspeakers(param_00,param_01)
{
	var_02 = [];
	var_03 = getaiarray(self.team);
	if(isdefined(param_01) && param_01)
	{
		var_04 = [];
		for(var_05 = 0;var_05 < var_03.size;var_05++)
		{
			if(var_03[var_05] isofficer())
			{
				var_04[var_04.size] = var_03[var_05];
			}
		}

		var_03 = var_04;
	}

	for(var_05 = 0;var_05 < var_03.size;var_05++)
	{
		if(var_03[var_05] == self)
		{
			continue;
		}

		if(!var_03[var_05] cansay(param_00))
		{
			continue;
		}

		var_02[var_02.size] = var_03[var_05];
	}

	return var_02;
}

//Function Number: 60
getarea()
{
	var_00 = level.areas;
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(self istouching(var_00[var_01]) && isdefined(var_00[var_01].script_area))
		{
			return var_00[var_01];
		}
	}

	return undefined;
}

//Function Number: 61
getlocation()
{
	var_00 = level.locations;
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(self istouching(var_00[var_01]) && isdefined(var_00[var_01].script_location))
		{
			return var_00[var_01];
		}
	}

	return undefined;
}

//Function Number: 62
getlandmark()
{
	var_00 = level.landmarks;
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(self istouching(var_00[var_01]) && isdefined(var_00[var_01].script_landmark))
		{
			return var_00[var_01];
		}
	}

	return undefined;
}

//Function Number: 63
getdirectioncompass(param_00,param_01)
{
	var_02 = vectortoangles(param_01 - param_00);
	var_03 = var_02[1];
	var_04 = getnorthyaw();
	var_03 = var_03 - var_04;
	if(var_03 < 0)
	{
		var_03 = var_03 + 360;
	}
	else if(var_03 > 360)
	{
		var_03 = var_03 - 360;
	}

	if(var_03 < 22.5 || var_03 > 337.5)
	{
		var_05 = "north";
	}
	else if(var_04 < 67.5)
	{
		var_05 = "northwest";
	}
	else if(var_04 < 112.5)
	{
		var_05 = "west";
	}
	else if(var_04 < 157.5)
	{
		var_05 = "southwest";
	}
	else if(var_04 < 202.5)
	{
		var_05 = "south";
	}
	else if(var_04 < 247.5)
	{
		var_05 = "southeast";
	}
	else if(var_04 < 292.5)
	{
		var_05 = "east";
	}
	else if(var_04 < 337.5)
	{
		var_05 = "northeast";
	}
	else
	{
		var_05 = "impossible";
	}

	return var_05;
}

//Function Number: 64
getdirectionreferenceside(param_00,param_01,param_02)
{
	var_03 = vectortoangles(param_02 - param_00);
	var_04 = vectortoangles(param_01 - param_00);
	var_05 = var_03[1] - var_04[1];
	var_05 = var_05 + 360;
	var_05 = int(var_05) % 360;
	if(var_05 > 180)
	{
		var_05 = var_05 - 360;
	}

	if(var_05 > 2 && var_05 < 45)
	{
		var_06 = "right";
	}
	else if(var_06 < -2 && var_06 > -45)
	{
		var_06 = "left";
	}
	else if(distance(param_01,param_02) < distance(param_01,var_03))
	{
		var_06 = "front";
	}
	else
	{
		var_06 = "rear";
	}

	return var_06;
}

//Function Number: 65
getdirectionfacingflank(param_00,param_01,param_02)
{
	var_03 = vectortoangles(param_02);
	var_04 = vectortoangles(param_01 - param_00);
	var_05 = var_03[1] - var_04[1];
	var_05 = var_05 + 360;
	var_05 = int(var_05) % 360;
	if(var_05 > 315 || var_05 < 45)
	{
		var_06 = "front";
	}
	else if(var_06 < 135)
	{
		var_06 = "right";
	}
	else if(var_06 < 225)
	{
		var_06 = "rear";
	}
	else
	{
		var_06 = "left";
	}

	return var_06;
}

//Function Number: 66
getvectorrightangle(param_00)
{
	return (param_00[1],0 - param_00[0],param_00[2]);
}

//Function Number: 67
getvectorarrayaverage(param_00)
{
	var_01 = (0,0,0);
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_01 = var_01 + param_00[var_02];
	}

	return (var_01[0] / param_00.size,var_01[1] / param_00.size,var_01[2] / param_00.size);
}

//Function Number: 68
addnamealias(param_00)
{
	self.soundaliases[self.soundaliases.size] = self.owner.countryid + "_" + self.owner.npcid + "_name_" + param_00;
}

//Function Number: 69
addrankalias(param_00)
{
	self.soundaliases[self.soundaliases.size] = self.owner.countryid + "_" + self.owner.npcid + "_rank_" + param_00;
}

//Function Number: 70
cansayname(param_00)
{
	var_01 = self.countryid + "_" + self.npcid + "_name_" + param_00;
	if(soundexists(var_01))
	{
		return 1;
	}

	return 0;
}

//Function Number: 71
addareaalias(param_00,param_01)
{
	if(randomfloat(1) > param_00)
	{
		return 0;
	}

	self.areaent = param_01 getarea();
	if(!isdefined(self.areaent))
	{
		return 0;
	}

	if(self.areaent.script_area == "window" || self.areaent.script_area == "doorway")
	{
	}

	var_02 = self.areaent.script_area;
	var_03 = param_01 bcgetclaimednode();
	if(isdefined(var_03) && isdefined(var_03.script_area))
	{
		var_02 = var_02 + var_03.script_area;
		self.areadetail = 1;
	}
	else
	{
		self.areadetail = 0;
		var_02 = var_02 + "_generic";
	}

	self.area = self.owner.countryid + "_" + self.owner.npcid + "_area_" + var_02;
	self.soundaliases[self.soundaliases.size] = self.area;
	return 1;
}

//Function Number: 72
addlocationalias(param_00,param_01)
{
	if(randomfloat(1) > param_00)
	{
		return 0;
	}

	self.locationent = param_01 getlocation();
	if(!isdefined(self.locationent))
	{
		return 0;
	}

	var_02 = self.locationent.script_location;
	var_03 = param_01 bcgetclaimednode();
	if(isdefined(var_03) && isdefined(var_03.script_location))
	{
		var_02 = var_02 + "_" + var_03.script_location;
	}
	else
	{
		var_02 = var_02 + "_generic";
	}

	self.location = self.owner.countryid + "_" + self.owner.npcid + "_location_" + var_02;
	self.soundaliases[self.soundaliases.size] = self.location;
	return 1;
}

//Function Number: 73
addlandmarkalias(param_00,param_01)
{
	if(randomfloat(1) > param_00)
	{
		return 0;
	}

	self.landmarkent = param_01 getlandmark();
	if(!isdefined(self.landmarkent))
	{
		return 0;
	}

	var_02 = self.landmarkent.script_landmark;
	var_03 = getdirectionreferenceside(self.owner.origin,param_01.origin,self.landmarkent.origin);
	if(var_03 == "rear" && soundexists(self.owner.countryid + "_" + self.owner.npcid + "_landmark_behind_" + var_02))
	{
		var_02 = "behind_" + var_02;
	}
	else if(soundexists(self.owner.countryid + "_" + self.owner.npcid + "_landmark_near_" + var_02))
	{
		var_02 = "near_" + var_02;
	}
	else
	{
		return 0;
	}

	self.landmark = self.owner.countryid + "_" + self.owner.npcid + "_landmark_" + var_02;
	self.soundaliases[self.soundaliases.size] = self.landmark;
	return 1;
}

//Function Number: 74
addgenericalias(param_00,param_01,param_02,param_03)
{
	self.soundaliases[self.soundaliases.size] = self.owner.countryid + "_" + self.owner.npcid + "_" + param_01 + "_" + param_02 + "_" + param_03;
	dotypelimit(param_01,param_02);
}

//Function Number: 75
adddirectionalias(param_00,param_01,param_02,param_03,param_04)
{
	if(randomfloat(1) > param_00)
	{
		return 0;
	}

	switch(param_01)
	{
		case "side":
			break;

		case "relative":
			break;

		default:
			break;
	}
}

//Function Number: 76
getdirectionaliasplayerrelative(param_00)
{
	var_01 = getdirectionreferenceside(level.player.origin,param_00.origin,anglestoforward(level.player.angles));
	var_01 = "relative_" + var_01;
	self.direction = self.owner.countryid + "_" + self.owner.npcid + "_direction_" + var_01;
	return self.direction;
}

//Function Number: 77
addthreatalias(param_00,param_01,param_02)
{
	self.threat = self.owner.countryid + "_" + self.owner.npcid + "_threat_" + param_01 + "_" + param_02;
	self.soundaliases[self.soundaliases.size] = self.threat;
	return 1;
}

//Function Number: 78
addinformalias(param_00,param_01,param_02)
{
	self.inform = self.owner.countryid + "_" + self.owner.npcid + "_inform_" + param_01 + "_" + param_02;
	self.soundaliases[self.soundaliases.size] = self.inform;
	return 1;
}

//Function Number: 79
addresponsealias(param_00,param_01,param_02)
{
	self.response = self.owner.countryid + "_" + self.owner.npcid + "_response_" + param_01 + "_" + param_02;
	self.soundaliases[self.soundaliases.size] = self.response;
	return 1;
}

//Function Number: 80
addreactionalias(param_00,param_01,param_02)
{
	self.reaction = self.owner.countryid + "_" + self.owner.npcid + "_reaction_" + param_01 + "_" + param_02;
	self.soundaliases[self.soundaliases.size] = self.reaction;
	return 1;
}

//Function Number: 81
addtauntalias(param_00,param_01,param_02)
{
	self.reaction = self.owner.countryid + "_" + self.owner.npcid + "_taunt";
	self.soundaliases[self.soundaliases.size] = self.reaction;
	return 1;
}

//Function Number: 82
addorderalias(param_00,param_01,param_02)
{
	self.order = self.owner.countryid + "_" + self.owner.npcid + "_order_" + param_01 + "_" + param_02;
	self.soundaliases[self.soundaliases.size] = self.order;
	return 1;
}

//Function Number: 83
initcontact(param_00)
{
	if(!isdefined(self.squadlist[param_00].calledout))
	{
		self.squadlist[param_00].calledout = 0;
	}

	if(!isdefined(self.squadlist[param_00].firstcontact))
	{
		self.squadlist[param_00].firstcontact = 2000000000;
	}

	if(!isdefined(self.squadlist[param_00].lastcontact))
	{
		self.squadlist[param_00].lastcontact = 0;
	}
}

//Function Number: 84
shutdowncontact(param_00)
{
	self.squadlist[param_00].calledout = undefined;
	self.squadlist[param_00].firstcontact = undefined;
	self.squadlist[param_00].lastcontact = undefined;
}

//Function Number: 85
createchatevent(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.owner = self;
	var_03.eventtype = param_01;
	var_03.eventaction = param_00;
	if(isdefined(param_02))
	{
		var_03.priority = param_02;
	}
	else
	{
		var_03.priority = level.eventpriority[param_00][param_01];
	}

	var_03.expiretime = gettime() + level.eventduration[param_00][param_01];
	return var_03;
}

//Function Number: 86
createchatphrase()
{
	var_00 = spawnstruct();
	var_00.owner = self;
	var_00.soundaliases = [];
	var_00.master = 0;
	return var_00;
}

//Function Number: 87
canseepoint(param_00)
{
	var_01 = anglestoforward(self.angles);
	return vectordot(var_01,param_00 - self.origin) > 0.766;
}

//Function Number: 88
pointinfov(param_00)
{
	var_01 = anglestoforward(self.angles);
	return vectordot(var_01,param_00 - self.origin) > 0.766;
}

//Function Number: 89
battlechatter_canprint()
{
	if(getdvar("debug_bcprint") == self.team || getdvar("debug_bcprint") == "all")
	{
		return 1;
	}

	return 0;
}

//Function Number: 90
battlechatter_print(param_00)
{
}

//Function Number: 91
battlechatter_println(param_00)
{
}

//Function Number: 92
battlechatter_print_internal(param_00,param_01)
{
	if(!battlechatter_canprint())
	{
		return;
	}

	var_02 = "";
	if(param_00 != "")
	{
		var_02 = common_scripts\utility::ter_op(self.team == "allies","^5","^6") + "BC: ";
	}

	[[ param_01 ]](var_02 + param_00);
}

//Function Number: 93
battlechatter_canprintdump()
{
	return getdvar("debug_bcprintdump") == "on";
}

//Function Number: 94
battlechatter_printdump(param_00)
{
}

//Function Number: 95
battlechatter_printdumpline(param_00,param_01,param_02)
{
}

//Function Number: 96
strfind(param_00,param_01)
{
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		if(param_00[var_02] != param_01[0])
		{
			continue;
		}

		if(param_01.size > param_00.size - var_02)
		{
			return 0;
		}

		for(var_03 = 0;var_03 < param_01.size;var_03++)
		{
			if(param_00[var_02 + var_03] != param_01[var_03])
			{
				break;
			}

			if(var_03 == param_01.size - 1)
			{
				return 1;
			}
		}
	}
}

//Function Number: 97
threattracker()
{
	for(;;)
	{
		var_00 = getaiarray("axis");
		var_01 = getaiarray("allies");
		var_02 = [];
		for(var_03 = 0;var_03 < var_00.size;var_03++)
		{
			if(!level.player pointinfov(var_00[var_03].origin))
			{
				continue;
			}

			if(distance(level.player.origin,var_00[var_03].origin) > 2048)
			{
				continue;
			}

			var_04 = "";
			var_05 = var_00[var_03] getlocation();
			if(!isdefined(var_05))
			{
				var_05 = var_00[var_03] getlandmark();
				if(!isdefined(var_05))
				{
					continue;
				}

				var_04 = var_05.script_landmark;
			}
			else
			{
				var_04 = var_05.script_location;
			}

			var_06 = 0;
			for(var_07 = 0;var_07 < var_01.size;var_07++)
			{
				if(isdefined(var_01[var_07].enemy) && var_01[var_07].enemy == var_00[var_03])
				{
					var_06 = 1;
				}
			}

			if(var_06)
			{
				var_02[var_02.size] = "^2" + var_04;
				continue;
			}

			var_02[var_02.size] = "^1" + var_04;
		}

		for(var_03 = 0;var_03 < var_02.size;var_03++)
		{
		}

		wait(0.5);
	}
}

//Function Number: 98
bcdrawobjects()
{
	for(var_00 = 0;var_00 < level.areas.size;var_00++)
	{
		if(!isdefined(level.areas[var_00].script_area))
		{
			continue;
		}

		thread drawbcobject("Area:     " + level.areas[var_00].script_area,level.areas[var_00] getorigin(),(0,0,16),(1,1,1));
	}

	for(var_00 = 0;var_00 < level.locations.size;var_00++)
	{
		if(!isdefined(level.locations[var_00].script_location))
		{
			continue;
		}

		thread drawbcobject("Location: " + level.locations[var_00].script_location,level.locations[var_00] getorigin(),(0,0,8),(1,1,1));
	}

	for(var_00 = 0;var_00 < level.landmarks.size;var_00++)
	{
		if(!isdefined(level.landmarks[var_00].script_landmark))
		{
			continue;
		}

		thread drawbcobject("Landmark: " + level.landmarks[var_00].script_landmark,level.landmarks[var_00] getorigin(),(0,0,0),(1,1,1));
		thread drawbcdirections(level.landmarks[var_00] getorigin(),(0,0,8),(1,1,0));
	}

	var_01 = getallnodes();
	for(var_00 = 0;var_00 < var_01.size;var_00++)
	{
		if(!isdefined(var_01[var_00].script_location))
		{
			continue;
		}

		level.moveorigin.origin = var_01[var_00].origin;
		level.moveorigin.origin = level.moveorigin.origin + (0,0,10);
		var_02 = level.moveorigin getlocation();
		if(isdefined(var_02))
		{
			thread drawbcobject(var_01[var_00].script_location + " @ " + var_02.script_location,var_01[var_00].origin,(0,0,0),(0,1,0));
			continue;
		}

		thread drawbcobject(var_01[var_00].script_location + " @ undefined",var_01[var_00].origin,(0,0,0),(1,0,0));
	}

	var_01 = undefined;
}

//Function Number: 99
drawbcobject(param_00,param_01,param_02,param_03)
{
	for(;;)
	{
		if(distance(level.player.origin,param_01) > 2048)
		{
			wait(0.1);
			continue;
		}

		wait(0.05);
	}
}

//Function Number: 100
drawbcdirections(param_00,param_01,param_02)
{
	for(;;)
	{
		if(distance(level.player.origin,param_00) > 2048)
		{
			wait(0.1);
			continue;
		}

		var_03 = getdirectioncompass(level.player.origin,param_00);
		wait(0.05);
	}
}

//Function Number: 101
resetnextsaytimes(param_00,param_01)
{
	var_02 = getaiarray(param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = var_02[var_03];
		if(!isalive(var_04))
		{
			continue;
		}

		if(!isdefined(var_04.battlechatter))
		{
			continue;
		}

		var_04.nextsaytimes[param_01] = gettime() + 350;
		var_04.squad.nextsaytimes[param_01] = gettime() + 350;
	}
}

//Function Number: 102
getdirectionfacingclockgivenangle(param_00)
{
	var_01 = undefined;
	if(param_00 > 345 || param_00 < 15)
	{
		var_01 = "12";
	}
	else if(param_00 < 45)
	{
		var_01 = "1";
	}
	else if(param_00 < 75)
	{
		var_01 = "2";
	}
	else if(param_00 < 105)
	{
		var_01 = "3";
	}
	else if(param_00 < 135)
	{
		var_01 = "4";
	}
	else if(param_00 < 165)
	{
		var_01 = "5";
	}
	else if(param_00 < 195)
	{
		var_01 = "6";
	}
	else if(param_00 < 225)
	{
		var_01 = "7";
	}
	else if(param_00 < 255)
	{
		var_01 = "8";
	}
	else if(param_00 < 285)
	{
		var_01 = "9";
	}
	else if(param_00 < 315)
	{
		var_01 = "10";
	}
	else
	{
		var_01 = "11";
	}

	return var_01;
}

//Function Number: 103
getdirectionfacingangle(param_00,param_01,param_02)
{
	var_03 = anglestoforward(param_00);
	var_04 = vectornormalize(var_03);
	var_05 = vectortoangles(var_04);
	var_06 = vectortoangles(param_02 - param_01);
	var_07 = var_05[1] - var_06[1];
	var_07 = var_07 + 360;
	var_07 = int(var_07) % 360;
	return var_07;
}

//Function Number: 104
getrelativeangles(param_00)
{
	var_01 = param_00.angles;
	if(!isplayer(param_00))
	{
		var_02 = param_00 bcgetclaimednode();
		if(isdefined(var_02))
		{
			var_01 = var_02.angles;
		}
	}

	return var_01;
}

//Function Number: 105
get_all_my_locations()
{
	var_00 = [];
	if(!isdefined(self))
	{
		return var_00;
	}

	var_01 = level.bcs_locations;
	var_02 = self getistouchingentities(var_01);
	if(!isdefined(var_02))
	{
		return var_00;
	}

	foreach(var_04 in var_02)
	{
		if(isdefined(var_04.locationaliases))
		{
			var_00[var_00.size] = var_04;
		}
	}

	return var_00;
}

//Function Number: 106
getclosestfriendlyspeaker(param_00)
{
	var_01 = getspeakers(param_00,0);
	var_02 = common_scripts\utility::getclosest(self.origin,var_01);
	return var_02;
}