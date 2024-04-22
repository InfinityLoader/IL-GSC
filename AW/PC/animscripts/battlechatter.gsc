/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: battlechatter.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 174
 * Decompile Time: 2485 ms
 * Timestamp: 4/22/2024 1:59:58 AM
*******************************************************************/

//Function Number: 1
init_battlechatter()
{
	if(isdefined(level.chatinitialized) && level.chatinitialized)
	{
		return;
	}

	setdvar("bcs_logErrorsAndRequests",0);
	setdvarifuninitialized("bcs_enable",1);
	if(getdvarint("bcs_enable") == 0)
	{
		anim.chatinitialized = 0;
		level.player.chatinitialized = 0;
		return;
	}

	anim.chatinitialized = 1;
	level.player.chatinitialized = 0;
	setdvarifuninitialized("bcs_filterThreat","off");
	setdvarifuninitialized("bcs_filterInform","off");
	setdvarifuninitialized("bcs_filterOrder","off");
	setdvarifuninitialized("bcs_filterReaction","off");
	setdvarifuninitialized("bcs_filterResponse","off");
	setdvarifuninitialized("bcs_forceEnglish","0");
	setdvarifuninitialized("bcs_allowsamevoiceresponse","off");
	setdvarifuninitialized("debug_bcprint","off");
	setdvarifuninitialized("debug_bcprintdump","off");
	setdvarifuninitialized("debug_bcprintdumptype","csv");
	setdvarifuninitialized("debug_bcshowqueue","off");
	anim.bcprintfailprefix = "^3***** BCS FAILURE: ";
	anim.bcprintwarnprefix = "^3***** BCS WARNING: ";
	bcs_setup_teams_array();
	bcs_setup_countryids();
	level.playernameids["american"] = "1";
	level.playernameids["seal"] = "1";
	level.playernameids["taskforce"] = "1";
	level.playernameids["secretservice"] = "1";
	level.playernameids["delta"] = "1";
	level.playernameids["xslice"] = "1";
	thread setplayerbcnameid();
	init_flavorbursts();
	if(!isdefined(level.friendlyfire_warnings))
	{
		level.friendlyfire_warnings = 0;
	}

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
		level.eventactionminwait["threat"]["self"] = 12500;
		level.eventactionminwait["threat"]["squad"] = 7500;
	}

	if(is_xslice())
	{
		level.eventactionminwait["threat"]["location_repeat"] = 3000;
	}
	else
	{
		level.eventactionminwait["threat"]["location_repeat"] = 15000;
	}

	level.eventactionminwait["response"]["self"] = 1000;
	level.eventactionminwait["response"]["squad"] = 1000;
	level.eventactionminwait["reaction"]["self"] = 1000;
	level.eventactionminwait["reaction"]["squad"] = 1000;
	level.eventactionminwait["order"]["self"] = 8000;
	level.eventactionminwait["order"]["squad"] = 10000;
	level.eventactionminwait["inform"]["self"] = 6000;
	level.eventactionminwait["inform"]["squad"] = 8000;
	level.eventactionminwait["custom"]["self"] = 0;
	level.eventactionminwait["custom"]["squad"] = 0;
	if(is_xslice())
	{
		level.eventtypeminwait["playername"] = 7000;
	}
	else
	{
		level.eventtypeminwait["playername"] = 50000;
	}

	level.eventtypeminwait["reaction"]["casualty"] = 14000;
	level.eventtypeminwait["reaction"]["friendlyfire"] = 5000;
	level.eventtypeminwait["reaction"]["takingfire"] = 40000;
	level.eventtypeminwait["reaction"]["ask_ok"] = 15000;
	level.eventtypeminwait["reaction"]["taunt"] = 30000;
	level.eventtypeminwait["inform"]["reloading"] = 20000;
	level.eventtypeminwait["inform"]["killfirm"] = 15000;
	if(is_xslice())
	{
		level.eventpriority["threat"]["infantry"] = 1;
		level.eventpriority["threat"]["vehicle"] = 0.7;
		level.eventpriority["response"]["ack"] = 0;
		level.eventpriority["response"]["exposed"] = 0.8;
		level.eventpriority["response"]["callout"] = 1;
		level.eventpriority["response"]["echo"] = 0.9;
		level.eventpriority["reaction"]["casualty"] = 0.6;
		level.eventpriority["reaction"]["friendlyfire"] = 1;
		level.eventpriority["reaction"]["taunt"] = 0.2;
		level.eventpriority["order"]["action"] = 0;
		level.eventpriority["order"]["move"] = 0;
		level.eventpriority["order"]["displace"] = 0;
		level.eventpriority["inform"]["attack"] = 0.9;
		level.eventpriority["inform"]["incoming"] = 0.9;
		level.eventpriority["inform"]["reloading"] = 0.2;
		level.eventpriority["inform"]["suppressed"] = 0;
		level.eventpriority["inform"]["killfirm"] = 0.9;
		level.eventpriority["custom"]["generic"] = 0;
	}
	else
	{
		level.eventpriority["threat"]["infantry"] = 0.5;
		level.eventpriority["threat"]["vehicle"] = 0.7;
		level.eventpriority["response"]["ack"] = 0.9;
		level.eventpriority["response"]["exposed"] = 0.8;
		level.eventpriority["response"]["callout"] = 0.9;
		level.eventpriority["response"]["echo"] = 0.9;
		level.eventpriority["response"]["covering"] = 0.9;
		level.eventpriority["response"]["im"] = 0.9;
		level.eventpriority["reaction"]["casualty"] = 0.5;
		level.eventpriority["reaction"]["friendlyfire"] = 1;
		level.eventpriority["reaction"]["takingfire"] = 1;
		level.eventpriority["reaction"]["ask_ok"] = 1;
		level.eventpriority["reaction"]["taunt"] = 0.9;
		level.eventpriority["order"]["action"] = 0.3;
		level.eventpriority["order"]["move"] = 0.3;
		level.eventpriority["order"]["displace"] = 0.5;
		level.eventpriority["inform"]["attack"] = 0.9;
		level.eventpriority["inform"]["incoming"] = 0.9;
		level.eventpriority["inform"]["reloading"] = 0.2;
		level.eventpriority["inform"]["suppressed"] = 0.2;
		level.eventpriority["inform"]["killfirm"] = 0.7;
		level.eventpriority["custom"]["generic"] = 1;
	}

	level.eventduration["threat"]["infantry"] = 1000;
	level.eventduration["threat"]["vehicle"] = 1000;
	level.eventduration["response"]["exposed"] = 2000;
	level.eventduration["response"]["callout"] = 2000;
	level.eventduration["response"]["echo"] = 2000;
	level.eventduration["response"]["ack"] = 1750;
	level.eventduration["response"]["covering"] = 1500;
	level.eventduration["response"]["im"] = 1500;
	level.eventduration["reaction"]["casualty"] = 2000;
	level.eventduration["reaction"]["friendlyfire"] = 1000;
	level.eventduration["reaction"]["takingfire"] = 1500;
	level.eventduration["reaction"]["ask_ok"] = 1500;
	level.eventduration["reaction"]["taunt"] = 2000;
	level.eventduration["order"]["action"] = 3000;
	level.eventduration["order"]["move"] = 3000;
	level.eventduration["order"]["displace"] = 3000;
	level.eventduration["inform"]["attack"] = 1000;
	level.eventduration["inform"]["incoming"] = 1500;
	level.eventduration["inform"]["reloading"] = 1000;
	level.eventduration["inform"]["suppressed"] = 2000;
	level.eventduration["inform"]["killfirm"] = 2000;
	level.eventduration["custom"]["generic"] = 1000;
	if(is_xslice())
	{
		level.eventchance["response"]["exposed"] = 65;
		level.eventchance["response"]["reload"] = 55;
		level.eventchance["response"]["callout"] = 99;
		level.eventchance["response"]["callout_negative"] = 10;
		level.eventchance["response"]["order"] = 0;
		level.eventchance["moveEvent"]["coverme"] = 0;
		level.eventchance["moveEvent"]["ordertoplayer"] = 0;
	}
	else
	{
		level.eventchance["response"]["exposed"] = 75;
		level.eventchance["response"]["reload"] = 65;
		level.eventchance["response"]["callout"] = 75;
		level.eventchance["response"]["callout_negative"] = 20;
		level.eventchance["response"]["order"] = 40;
		level.eventchance["moveEvent"]["coverme"] = 70;
		level.eventchance["moveEvent"]["ordertoplayer"] = 10;
	}

	anim.fbt_desireddistmax = 620;
	anim.fbt_waitmin = 12;
	anim.fbt_waitmax = 24;
	anim.fbt_linebreakmin = 2;
	anim.fbt_linebreakmax = 5;
	anim.moveorigin = spawn("script_origin",(0,0,0));
	if(is_xslice())
	{
		if(!isdefined(level.bcs_maxtalkingdistsqrdfromplayer))
		{
			level.bcs_maxtalkingdistsqrdfromplayer = squared(3500);
		}

		if(!isdefined(level.bcs_maxthreatdistsqrdfromplayer))
		{
			level.bcs_maxthreatdistsqrdfromplayer = squared(4500);
		}
	}
	else
	{
		if(!isdefined(level.bcs_maxtalkingdistsqrdfromplayer))
		{
			level.bcs_maxtalkingdistsqrdfromplayer = squared(1500);
		}

		if(!isdefined(level.bcs_maxthreatdistsqrdfromplayer))
		{
			level.bcs_maxthreatdistsqrdfromplayer = squared(2500);
		}
	}

	level.heightforhighcallout = 96;
	level.mindistancecallout = 8;
	level.maxdistancecallout = 45;
	common_scripts\_bcs_location_trigs::bcs_location_trigs_init();
	if(is_xslice())
	{
		anim.scripteddialoguebuffertime = 2000;
	}
	else
	{
		anim.scripteddialoguebuffertime = 4000;
	}

	anim.bcs_threatresettime = 3000;
	level.squadcreatefuncs[level.squadcreatefuncs.size] = ::init_squadbattlechatter;
	level.squadcreatestrings[level.squadcreatestrings.size] = "::init_squadBattleChatter";
	foreach(var_01 in level.teams)
	{
		level.isteamspeaking[var_01] = 0;
		level.isteamsaying[var_01]["threat"] = 0;
		level.isteamsaying[var_01]["order"] = 0;
		level.isteamsaying[var_01]["reaction"] = 0;
		level.isteamsaying[var_01]["response"] = 0;
		level.isteamsaying[var_01]["inform"] = 0;
		level.isteamsaying[var_01]["custom"] = 0;
	}

	bcs_setup_chatter_toggle_array();
	bcs_setup_flavorburst_toggle_array();
	anim.lastteamspeaktime = [];
	anim.lastnamesaid = [];
	anim.lastnamesaidtime = [];
	foreach(var_01 in level.teams)
	{
		level.lastteamspeaktime[var_01] = -50000;
		level.lastnamesaid[var_01] = "none";
		level.lastnamesaidtime[var_01] = -100000;
	}

	if(is_xslice())
	{
		anim.lastnamesaidtimeout = 1000;
	}
	else
	{
		anim.lastnamesaidtimeout = 120000;
	}

	for(var_05 = 0;var_05 < level.squadindex.size;var_05++)
	{
		if(isdefined(level.squadindex[var_05].chatinitialized) && level.squadindex[var_05].chatinitialized)
		{
			continue;
		}

		level.squadindex[var_05] init_squadbattlechatter();
	}

	anim.threatcallouts = [];
	if(is_xslice())
	{
		level.threatcallouts["rpg"] = 0;
		level.threatcallouts["exposed"] = 25;
		level.threatcallouts["player_distance"] = 0;
		level.threatcallouts["player_obvious"] = 0;
		level.threatcallouts["player_contact_clock"] = 65;
		level.threatcallouts["player_target_clock"] = 0;
		level.threatcallouts["player_target_clock_high"] = 40;
		level.threatcallouts["player_cardinal"] = 0;
		level.threatcallouts["ai_distance"] = 0;
		level.threatcallouts["ai_obvious"] = 0;
		level.threatcallouts["ai_contact_clock"] = 65;
		level.threatcallouts["ai_target_clock"] = 0;
		level.threatcallouts["ai_target_clock_high"] = 40;
		level.threatcallouts["ai_cardinal"] = 0;
		level.threatcallouts["concat_location"] = 100;
		level.threatcallouts["player_location"] = 100;
		level.threatcallouts["ai_location"] = 100;
		level.threatcallouts["generic_location"] = 100;
	}
	else
	{
		level.threatcallouts["rpg"] = 80;
		level.threatcallouts["exposed"] = 25;
		level.threatcallouts["player_distance"] = 25;
		level.threatcallouts["player_obvious"] = 25;
		level.threatcallouts["player_contact_clock"] = 25;
		level.threatcallouts["player_target_clock"] = 25;
		level.threatcallouts["player_target_clock_high"] = 25;
		level.threatcallouts["player_cardinal"] = 20;
		level.threatcallouts["ai_distance"] = 25;
		level.threatcallouts["ai_obvious"] = 25;
		level.threatcallouts["ai_contact_clock"] = 20;
		level.threatcallouts["ai_casual_clock"] = 20;
		level.threatcallouts["ai_target_clock"] = 20;
		level.threatcallouts["ai_target_clock_high"] = 25;
		level.threatcallouts["ai_cardinal"] = 10;
		level.threatcallouts["concat_location"] = 90;
		level.threatcallouts["player_location"] = 90;
		level.threatcallouts["ai_location"] = 100;
		level.threatcallouts["generic_location"] = 95;
	}

	anim.lastteamthreatcallout = [];
	anim.lastteamthreatcallouttime = [];
	foreach(var_01 in level.teams)
	{
		level.lastteamthreatcallout[var_01] = undefined;
		level.lastteamthreatcallouttime[var_01] = undefined;
	}

	if(is_xslice())
	{
		anim.teamthreatcalloutlimittimeout = 5000;
	}
	else
	{
		anim.teamthreatcalloutlimittimeout = 120000;
	}

	level notify("battlechatter initialized");
	anim notify("battlechatter initialized");
}

//Function Number: 2
bcs_setup_teams_array()
{
	if(!isdefined(level.teams))
	{
		anim.teams = [];
		level.teams[level.teams.size] = "axis";
		level.teams[level.teams.size] = "allies";
		level.teams[level.teams.size] = "team3";
		level.teams[level.teams.size] = "neutral";
	}
}

//Function Number: 3
bcs_setup_countryids()
{
	if(!isdefined(level.usedids))
	{
		anim.usedids = [];
		anim.flavorburstvoices = [];
		anim.countryids = [];
		bcs_setup_voice("british","UK",2);
		bcs_setup_voice("secretservice","SS",4);
		bcs_setup_voice("french","FR",3);
		bcs_setup_voice("czech","CZ",3);
		bcs_setup_voice("pmc","PC",3);
		bcs_setup_voice("russian","RU",3);
		bcs_setup_voice("arab","AB",3);
		bcs_setup_voice("portugese","PG",3);
		bcs_setup_voice("african","AF",3);
		bcs_setup_voice("american","US",3,1);
		bcs_setup_voice("delta","GL",1);
		bcs_setup_voice("taskforce","GM",1);
		bcs_setup_voice("seal","GS",1);
		bcs_setup_voice("shadowcompany","SP",6);
		bcs_setup_voice("russian","SP",6);
		bcs_setup_voice("xslice","XS",3);
	}
}

//Function Number: 4
bcs_setup_voice(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	level.usedids[param_00] = [];
	for(var_04 = 0;var_04 < param_02;var_04++)
	{
		level.usedids[param_00][var_04] = spawnstruct();
		level.usedids[param_00][var_04].count = 0;
		level.usedids[param_00][var_04].npcid = "" + var_04;
	}

	level.countryids[param_00] = param_01;
	level.flavorburstvoices[param_00] = param_03;
}

//Function Number: 5
bcs_setup_chatter_toggle_array()
{
	bcs_setup_teams_array();
	if(!isdefined(level.battlechatter))
	{
		level.battlechatter = [];
		foreach(var_01 in level.teams)
		{
			maps\_utility::set_battlechatter_variable(var_01,1);
		}
	}
}

//Function Number: 6
bcs_setup_flavorburst_toggle_array()
{
	bcs_setup_teams_array();
	if(!isdefined(level.flavorbursts))
	{
		level.flavorbursts = [];
		foreach(var_01 in level.teams)
		{
			level.flavorbursts[var_01] = 1;
		}
	}
}

//Function Number: 7
init_flavorbursts()
{
	level.flavorbursts["american"] = [];
	var_00 = 41;
	for(var_01 = 0;var_01 < var_00;var_01++)
	{
		level.flavorbursts["american"][var_01] = maps\_utility::string(var_01 + 1);
	}

	level.flavorbursts["shadowcompany"] = [];
	var_00 = 9;
	for(var_01 = 1;var_01 <= var_00;var_01++)
	{
		level.flavorbursts["shadowcompany"][var_01] = maps\_utility::string(var_01 + 1);
	}

	anim.flavorburstsused = [];
}

//Function Number: 8
shutdown_battlechatter()
{
	anim.countryids = undefined;
	anim.eventtypeminwait = undefined;
	anim.eventactionminwait = undefined;
	anim.eventtypeminwait = undefined;
	anim.eventpriority = undefined;
	anim.eventduration = undefined;
	anim.moveorigin = undefined;
	anim.scripteddialoguebuffertime = undefined;
	anim.bcs_threatresettime = undefined;
	anim.locationlastcallouttimes = undefined;
	anim.usedids = undefined;
	anim.flavorburstsused = undefined;
	anim.lastteamthreatcallout = undefined;
	anim.lastteamthreatcallouttime = undefined;
	anim.lastnamesaidtimeout = undefined;
	anim.lastnamesaid = undefined;
	anim.lastnamesaidtime = undefined;
	anim.chatinitialized = 0;
	level.player.chatinitialized = 0;
	level.battlechatter = undefined;
	anim.bcs_locations = undefined;
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

//Function Number: 9
init_squadbattlechatter()
{
	var_00 = self;
	if(is_xslice())
	{
		var_00.numspeakers = 0;
		var_00.maxspeakers = 2;
	}
	else
	{
		var_00.numspeakers = 0;
		var_00.maxspeakers = 1;
	}

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
	var_00.fbt_firstburst = 1;
	var_00.fbt_lastbursterid = undefined;
	for(var_01 = 0;var_01 < level.squadindex.size;var_01++)
	{
		var_00 thread initcontact(level.squadindex[var_01].squadname);
	}

	var_00 thread animscripts\battlechatter_ai::squadthreatwaiter();
	var_00 thread animscripts\battlechatter_ai::squadofficerwaiter();
	var_00 thread squadflavorbursttransmissions();
	var_00.chatinitialized = 1;
	var_00 notify("squad chat initialized");
}

//Function Number: 10
shutdown_squadbattlechatter()
{
	var_00 = self;
	var_00.numspeakers = undefined;
	var_00.maxspeakers = undefined;
	var_00.nextsaytime = undefined;
	var_00.nextsaytimes = undefined;
	var_00.nexttypesaytimes = undefined;
	var_00.ismembersaying = undefined;
	var_00.fbt_firstburst = undefined;
	var_00.fbt_lastbursterid = undefined;
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

//Function Number: 11
bcsenabled()
{
	if(isdefined(level.chatinitialized))
	{
		return level.chatinitialized;
	}

	return 0;
}

//Function Number: 12
bcsdebugwaiter()
{
	var_00 = getdvarint("bcs_enable");
	for(;;)
	{
		var_01 = getdvarint("bcs_enable");
		if(var_01 != var_00)
		{
			switch(var_01)
			{
				case 1:
					if(!level.chatinitialized)
					{
						enablebattlechatter();
					}
					break;
	
				case 0:
					if(level.chatinitialized)
					{
						disablebattlechatter();
					}
					break;
			}

			var_00 = var_01;
		}

		wait(1);
	}
}

//Function Number: 13
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

//Function Number: 14
disablebattlechatter()
{
	if(!isdefined(level.chatinitialized))
	{
		return;
	}

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

//Function Number: 15
setplayerbcnameid(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_01))
	{
		level.player.bcnameid = param_00;
		level.player.countryid = param_01;
		return;
	}

	while(!isdefined(level.campaign))
	{
		wait(0.1);
	}

	var_02 = level.campaign;
	var_03 = level.playernameids[var_02];
	var_04 = level.countryids[var_02];
	if(isdefined(var_03))
	{
		level.player.bcnameid = var_03;
	}

	if(isdefined(var_04))
	{
		level.player.countryid = var_04;
	}
}

//Function Number: 16
playbattlechatter()
{
	if(!isalive(self))
	{
		return;
	}

	if(!bcsenabled())
	{
		return;
	}

	if(self._animactive > 0)
	{
		return;
	}

	if(isdefined(self.isspeaking) && self.isspeaking)
	{
		return;
	}

	if(self.team == "allies" && isdefined(level.scripteddialoguestarttime))
	{
		if(level.scripteddialoguestarttime + level.scripteddialoguebuffertime > gettime())
		{
			return;
		}
	}

	if(friendlyfire_warning())
	{
		return;
	}

	if(!isdefined(self.battlechatter) || !self.battlechatter)
	{
		return;
	}

	if(self.team == "allies" && getdvarint("bcs_forceEnglish",0))
	{
		return;
	}

	if(level.isteamspeaking[self.team])
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
			thread playcustomevent();
			break;

		case "response":
			thread playresponseevent();
			break;

		case "order":
			thread playorderevent();
			break;

		case "threat":
			thread playthreatevent();
			break;

		case "reaction":
			thread playreactionevent();
			break;

		case "inform":
			thread playinformevent();
			break;
	}
}

//Function Number: 17
playthreatevent()
{
	self endon("death");
	self endon("removed from battleChatter");
	self endon("cancel speaking");
	self.curevent = self.chatqueue["threat"];
	var_00 = self.chatqueue["threat"].threat;
	if(!isalive(var_00))
	{
		return;
	}

	if(threatwasalreadycalledout(var_00) && !isplayer(var_00))
	{
		return;
	}

	anim thread lockaction(self,"threat");
	var_01 = 0;
	switch(self.chatqueue["threat"].eventtype)
	{
		case "infantry":
			if(isplayer(var_00) || !isdefined(var_00 getturret()))
			{
				var_01 = threatinfantry(var_00);
			}
			else
			{
			}
			break;

		case "dog":
			var_01 = threatdog(var_00);
			break;

		case "vehicle":
			break;
	}

	self notify("done speaking");
	if(!var_01)
	{
		return;
	}

	if(!isalive(var_00))
	{
		return;
	}

	var_00.calledout[self.squad.squadname] = spawnstruct();
	var_00.calledout[self.squad.squadname].spotter = self;
	var_00.calledout[self.squad.squadname].threattype = self.chatqueue["threat"].eventtype;
	var_00.calledout[self.squad.squadname].expiretime = gettime() + level.bcs_threatresettime;
	if(isdefined(var_00.squad))
	{
		self.squad.squadlist[var_00.squad.squadname].calledout = 1;
	}
}

//Function Number: 18
threatwasalreadycalledout(param_00)
{
	if(isdefined(param_00.calledout) && isdefined(param_00.calledout[self.squad.squadname]))
	{
		if(param_00.calledout[self.squad.squadname].expiretime < gettime())
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 19
threatinfantry(param_00,param_01)
{
	self endon("cancel speaking");
	var_02 = createchatphrase();
	var_02.master = 1;
	var_02.threatent = param_00;
	var_03 = getthreatinfantrycallouttype(param_00);
	if(!isdefined(var_03) || isdefined(var_03) && !isdefined(var_03.type))
	{
		return 0;
	}

	switch(var_03.type)
	{
		case "rpg":
			var_02 threatinfantryrpg(param_00);
			break;

		case "exposed":
			var_04 = doexposedcalloutresponse(var_03.responder);
			if(var_04 && cansayname(var_03.responder))
			{
				var_02 addnamealias(var_03.responder.bcname);
				var_02.looktarget = var_03.responder;
			}
	
			var_02 threatinfantryexposed(param_00);
			if(var_04)
			{
				if(randomint(100) < level.eventchance["response"]["callout_negative"])
				{
					var_03.responder animscripts\battlechatter_ai::addresponseevent("callout","neg",self,0.9);
				}
				else
				{
					var_03.responder animscripts\battlechatter_ai::addresponseevent("exposed","acquired",self,0.9);
				}
			}
			break;

		case "player_obvious":
			var_02 addplayernamealias();
			var_02 addthreatobviousalias();
			break;

		case "player_distance":
			var_05 = getdistanceyardsnormalized(level.player.origin,param_00.origin);
			var_02 addplayernamealias();
			var_02 addthreatdistancealias(var_05);
			break;

		case "player_contact_clock":
			var_02 addplayernamealias();
			var_02 addthreatcalloutalias("contactclock",var_03.playerclockdirection);
			break;

		case "player_target_clock":
			var_02 addplayernamealias();
			var_02 addthreatcalloutalias("targetclock",var_03.playerclockdirection);
			break;

		case "player_target_clock_high":
			var_02 addplayernamealias();
			var_06 = getdegreeselevation(level.player.origin,param_00.origin);
			if(var_06 >= 20 && var_06 <= 50)
			{
				var_02 addthreatcalloutalias("targetclock",var_03.playerclockdirection);
				var_02 addthreatelevationalias(var_06);
			}
			else
			{
				var_02 addthreatcalloutalias("targetclock",var_03.playerclockdirection + "_high");
			}
			break;

		case "player_cardinal":
			var_02 addplayernamealias();
			var_07 = getdirectioncompass(level.player.origin,param_00.origin);
			var_08 = normalizecompassdirection(var_07);
			if(var_08 == "impossible")
			{
				return 0;
			}
	
			var_02 addthreatcalloutalias("cardinal",var_08);
			break;

		case "ai_obvious":
			if(isdefined(var_03.responder) && cansayname(var_03.responder))
			{
				var_02 addnamealias(var_03.responder.bcname);
				var_02.looktarget = var_03.responder;
			}
	
			var_02 addthreatobviousalias();
			var_02 addcalloutresponseevent(self,var_03,param_00);
			break;

		case "ai_distance":
			var_09 = self;
			if(self.team == "allies")
			{
				var_09 = level.player;
			}
			else if(isdefined(var_03.responder) && randomint(100) < level.eventchance["response"]["callout"])
			{
				var_09 = var_03.responder;
			}
	
			var_05 = getdistanceyardsnormalized(var_09.origin,param_00.origin);
			var_02 addthreatdistancealias(var_05);
			var_02 addcalloutresponseevent(self,var_03,param_00);
			break;

		case "ai_contact_clock":
			var_09 = self;
			if(self.team == "allies")
			{
				var_09 = level.player;
			}
			else if(isdefined(var_03.responder) && randomint(100) < level.eventchance["response"]["callout"])
			{
				var_09 = var_03.responder;
			}
	
			var_0A = getrelativeangles(var_09);
			var_0B = getdirectionfacingclock(var_0A,var_09.origin,param_00.origin);
			var_02 addthreatcalloutalias("contactclock",var_0B);
			var_02 addcalloutresponseevent(self,var_03,param_00);
			break;

		case "ai_casual_clock":
			var_09 = self;
			if(self.team == "allies")
			{
				var_09 = level.player;
			}
			else if(isdefined(var_03.responder) && randomint(100) < level.eventchance["response"]["callout"])
			{
				var_09 = var_03.responder;
			}
	
			var_0A = getrelativeangles(var_09);
			var_0B = getdirectionfacingclock(var_0A,var_09.origin,param_00.origin);
			var_02 addthreatcalloutalias("casualclock",var_0B);
			var_02 addcalloutresponseevent(self,var_03,param_00);
			break;

		case "ai_target_clock":
			var_09 = self;
			if(self.team == "allies")
			{
				var_09 = level.player;
			}
			else if(isdefined(var_03.responder) && randomint(100) < level.eventchance["response"]["callout"])
			{
				var_09 = var_03.responder;
			}
	
			var_0A = getrelativeangles(var_09);
			var_0B = getdirectionfacingclock(var_0A,var_09.origin,param_00.origin);
			var_02 addthreatcalloutalias("targetclock",var_0B);
			var_02 addcalloutresponseevent(self,var_03,param_00);
			break;

		case "ai_target_clock_high":
			var_09 = self;
			if(self.team == "allies")
			{
				var_09 = level.player;
			}
			else if(isdefined(var_03.responder) && randomint(100) < level.eventchance["response"]["callout"])
			{
				var_09 = var_03.responder;
			}
	
			var_0A = getrelativeangles(var_09);
			var_0B = getdirectionfacingclock(var_0A,var_09.origin,param_00.origin);
			var_06 = getdegreeselevation(var_09.origin,param_00.origin);
			if(var_06 >= 20 && var_06 <= 50)
			{
				var_02 addthreatcalloutalias("targetclock",var_0B);
				var_02 addthreatelevationalias(var_06);
			}
			else
			{
				var_02 addthreatcalloutalias("targetclock",var_0B + "_high");
			}
	
			var_02 addcalloutresponseevent(self,var_03,param_00);
			break;

		case "ai_cardinal":
			var_09 = self;
			if(self.team == "allies")
			{
				var_09 = level.player;
			}
	
			var_07 = getdirectioncompass(var_09.origin,param_00.origin);
			var_08 = normalizecompassdirection(var_07);
			if(var_08 == "impossible")
			{
				return 0;
			}
	
			var_02 addthreatcalloutalias("cardinal",var_08);
			break;

		case "generic_location":
			var_0C = var_02 threatinfantry_docalloutlocation(var_03);
			if(!var_0C)
			{
				return 0;
			}
			break;

		case "player_location":
			var_02 addplayernamealias();
			var_0C = var_02 threatinfantry_docalloutlocation(var_03);
			if(!var_0C)
			{
				return 0;
			}
			break;

		case "concat_location":
			var_02 addconcattargetalias(param_00);
			var_09 = self;
			if(self.team == "allies")
			{
				var_09 = level.player;
			}
	
			var_0C = var_02 threatinfantry_docalloutlocation(var_03,1);
			if(!var_0C)
			{
				return 0;
			}
	
			var_02 addconcatdirectionalias(var_09,param_00);
			var_02 addcalloutresponseevent(self,var_03,param_00);
			break;

		case "ai_location":
			if(cansayname(var_03.responder))
			{
				var_02 addnamealias(var_03.responder.bcname);
				var_02.looktarget = var_03.responder;
			}
	
			var_0C = var_02 threatinfantry_docalloutlocation(var_03);
			if(!var_0C)
			{
				return 0;
			}
	
			var_0D = var_02.soundaliases.size - 1;
			var_0E = var_02.soundaliases[var_0D];
			if(iscallouttypereport(var_0E))
			{
				var_03.responder animscripts\battlechatter_ai::addresponseevent("callout","echo",self,0.9,var_0E);
			}
			else if(iscallouttypeqa(var_0E,self))
			{
				var_03.responder animscripts\battlechatter_ai::addresponseevent("callout","QA",self,0.9,var_0E,var_03.location);
			}
			else if(randomint(100) < level.eventchance["response"]["callout_negative"])
			{
				var_03.responder animscripts\battlechatter_ai::addresponseevent("callout","neg",self,0.9);
			}
			else
			{
				var_03.responder animscripts\battlechatter_ai::addresponseevent("exposed","acquired",self,0.9);
			}
			break;
	}

	setlastcallouttype(var_03.type);
	playphrase(var_02);
	return 1;
}

//Function Number: 20
doexposedcalloutresponse(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00.countryid != "US" && param_00.countryid != "NS" && param_00.countryid != "TF")
	{
		return 0;
	}

	if(randomint(100) > level.eventchance["response"]["exposed"])
	{
		return 0;
	}

	return 1;
}

//Function Number: 21
threatinfantry_docalloutlocation(param_00,param_01)
{
	var_02 = addthreatcalloutlocationalias(param_00.location,param_01);
	return var_02;
}

//Function Number: 22
addcalloutresponseevent(param_00,param_01,param_02)
{
	if(!isdefined(param_01.responder))
	{
		return;
	}

	if(randomint(100) > level.eventchance["response"]["callout"])
	{
		return;
	}

	var_03 = "affirm";
	if(!param_01.responder cansee(param_02) && randomint(100) < level.eventchance["response"]["callout_negative"])
	{
		var_03 = "neg";
	}

	param_01.responder animscripts\battlechatter_ai::addresponseevent("callout",var_03,param_00,0.9);
}

//Function Number: 23
getthreatinfantrycallouttype(param_00)
{
	var_01 = param_00 getvalidlocation(self);
	var_02 = getdirectionfacingclock(self.angles,self.origin,param_00.origin);
	var_03 = getresponder(64,1024,"response");
	var_04 = undefined;
	if(isdefined(var_03))
	{
		var_04 = getdirectionfacingclock(var_03.angles,var_03.origin,param_00.origin);
	}

	var_05 = getdirectionfacingclock(level.player.angles,level.player.origin,param_00.origin);
	if(self.team == "allies")
	{
		var_06 = var_05;
		var_07 = level.player;
	}
	else if(isdefined(var_05))
	{
		var_06 = var_06;
		var_07 = var_04;
	}
	else
	{
		var_06 = var_04;
		var_07 = self;
	}

	var_08 = getdistanceyards(var_07.origin,param_00.origin);
	self.possiblethreatcallouts = [];
	if(!isplayer(param_00) && param_00 animscripts\utility::usingrocketlauncher())
	{
		addpossiblethreatcallout("rpg");
	}

	if(!isdefined(var_01) && param_00 isexposed(0))
	{
		addpossiblethreatcallout("exposed");
	}

	if(self.team == "allies")
	{
		var_09 = 0;
		if(param_00.origin[2] - var_07.origin[2] >= level.heightforhighcallout)
		{
			if(addpossiblethreatcallout("player_target_clock_high"))
			{
				var_09 = 1;
			}
		}

		if(!var_09)
		{
			if(var_06 == "12")
			{
				addpossiblethreatcallout("player_obvious");
				if(var_08 > level.mindistancecallout && var_08 < level.maxdistancecallout)
				{
					addpossiblethreatcallout("player_distance");
				}
			}

			if(cansayplayername() && var_06 != "12")
			{
				addpossiblethreatcallout("player_contact_clock");
				addpossiblethreatcallout("player_target_clock");
				addpossiblethreatcallout("player_cardinal");
			}
		}
	}

	var_09 = 0;
	if(param_00.origin[2] - var_07.origin[2] >= level.heightforhighcallout)
	{
		if(addpossiblethreatcallout("ai_target_clock_high"))
		{
			var_09 = 1;
		}
	}

	addpossiblethreatcallout("ai_casual_clock");
	if(!var_09)
	{
		if(var_06 == "12")
		{
			addpossiblethreatcallout("ai_distance");
			if(var_08 > level.mindistancecallout && var_08 < level.maxdistancecallout)
			{
				addpossiblethreatcallout("ai_obvious");
			}
		}

		addpossiblethreatcallout("ai_contact_clock");
		addpossiblethreatcallout("ai_target_clock");
		addpossiblethreatcallout("ai_cardinal");
	}

	if(isdefined(var_01))
	{
		if(canconcat(var_01))
		{
			addpossiblethreatcallout("concat_location");
		}
		else if(isdefined(var_01 getcannedresponse(self)))
		{
			if(isdefined(var_03))
			{
				addpossiblethreatcallout("ai_location");
			}
			else
			{
				if(cansayplayername())
				{
					addpossiblethreatcallout("player_location");
				}

				addpossiblethreatcallout("generic_location");
			}
		}
		else
		{
			if(isdefined(var_03))
			{
				addpossiblethreatcallout("ai_location");
			}

			if(cansayplayername())
			{
				addpossiblethreatcallout("player_location");
			}

			addpossiblethreatcallout("generic_location");
		}
	}

	if(!self.possiblethreatcallouts.size)
	{
		return undefined;
	}

	var_0B = getweightedchanceroll(self.possiblethreatcallouts,level.threatcallouts);
	var_0C = spawnstruct();
	var_0C.type = var_0B;
	var_0C.responder = var_03;
	var_0C.responderclockdirection = var_04;
	var_0C.playerclockdirection = var_05;
	if(isdefined(var_01))
	{
		var_0C.location = var_01;
	}

	return var_0C;
}

//Function Number: 24
cancalloutlocation(param_00)
{
	foreach(var_02 in param_00.locationaliases)
	{
		var_03 = getloccalloutalias("co_loc_" + var_02);
		var_04 = getqacalloutalias(var_02,0);
		var_05 = getloccalloutalias("concat_loc_" + var_02);
		var_06 = soundexists(var_03) || soundexists(var_04) || soundexists(var_05);
		if(var_06)
		{
			return var_06;
		}
	}

	return 0;
}

//Function Number: 25
canconcat(param_00)
{
	var_01 = param_00.locationaliases;
	foreach(var_03 in var_01)
	{
		if(iscallouttypeconcat(var_03,self))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 26
getcannedresponse(param_00)
{
	var_01 = undefined;
	var_02 = self.locationaliases;
	foreach(var_04 in var_02)
	{
		if(iscallouttypeqa(var_04,param_00) && !isdefined(self.qafinished))
		{
			var_01 = var_04;
			break;
		}

		if(iscallouttypereport(var_04))
		{
			var_01 = var_04;
		}
	}

	return var_01;
}

//Function Number: 27
iscallouttypereport(param_00)
{
	return issubstr(param_00,"_report");
}

//Function Number: 28
iscallouttypeconcat(param_00,param_01)
{
	var_02 = param_01 getloccalloutalias("concat_loc_" + param_00);
	if(soundexists(var_02))
	{
		return 1;
	}

	return 0;
}

//Function Number: 29
iscallouttypeqa(param_00,param_01)
{
	if(issubstr(param_00,"_qa") && soundexists(param_00))
	{
		return 1;
	}

	var_02 = param_01 getqacalloutalias(param_00,0);
	if(soundexists(var_02))
	{
		return 1;
	}

	return 0;
}

//Function Number: 30
getloccalloutalias(param_00)
{
	var_01 = self.countryid + "_" + self.npcid + "_";
	var_01 = var_01 + param_00;
	return var_01;
}

//Function Number: 31
getqacalloutalias(param_00,param_01)
{
	var_02 = getloccalloutalias("co_loc_" + param_00);
	var_02 = var_02 + "_qa" + param_01;
	return var_02;
}

//Function Number: 32
addallowedthreatcallout(param_00)
{
	self.allowedcallouts[self.allowedcallouts.size] = param_00;
}

//Function Number: 33
addpossiblethreatcallout(param_00)
{
	var_01 = 0;
	foreach(var_03 in self.allowedcallouts)
	{
		if(var_03 == param_00)
		{
			if(!callouttypewillrepeat(param_00))
			{
				var_01 = 1;
			}

			break;
		}
	}

	if(!var_01)
	{
		return var_01;
	}

	self.possiblethreatcallouts[self.possiblethreatcallouts.size] = param_00;
	return var_01;
}

//Function Number: 34
callouttypewillrepeat(param_00)
{
	if(!isdefined(level.lastteamthreatcallout[self.team]))
	{
		return 0;
	}

	if(!isdefined(level.lastteamthreatcallouttime[self.team]))
	{
		return 0;
	}

	var_01 = level.lastteamthreatcallout[self.team];
	var_02 = level.lastteamthreatcallouttime[self.team];
	var_03 = level.teamthreatcalloutlimittimeout;
	if(param_00 == var_01 && gettime() - var_02 < var_03)
	{
		return 1;
	}

	return 0;
}

//Function Number: 35
setlastcallouttype(param_00)
{
	level.lastteamthreatcallout[self.team] = param_00;
	level.lastteamthreatcallouttime[self.team] = gettime();
}

//Function Number: 36
getweightedchanceroll(param_00,param_01)
{
	var_02 = undefined;
	var_03 = -1;
	foreach(var_05 in param_00)
	{
		if(param_01[var_05] <= 0)
		{
			continue;
		}

		var_06 = randomint(param_01[var_05]);
		if(isdefined(var_02) && param_01[var_02] >= 100)
		{
			if(param_01[var_05] < 100)
			{
				continue;
			}

			continue;
		}

		if(param_01[var_05] >= 100)
		{
			var_02 = var_05;
			var_03 = var_06;
			continue;
		}

		if(var_06 > var_03)
		{
			var_02 = var_05;
			var_03 = var_06;
		}
	}

	return var_02;
}

//Function Number: 37
threatdog(param_00,param_01)
{
	self endon("cancel speaking");
	var_02 = createchatphrase();
	var_02.master = 1;
	var_02.threatent = param_00;
	var_02 addthreatalias("dog","generic");
	playphrase(var_02);
	return 1;
}

//Function Number: 38
threatinfantryexposed(param_00)
{
	var_01 = [];
	var_01 = common_scripts\utility::array_add(var_01,"open");
	if(self.owner.countryid != "GS")
	{
		var_01 = common_scripts\utility::array_add(var_01,"breaking");
	}

	if(self.owner.team == "allies" && self.owner.countryid != "RU")
	{
		var_01 = common_scripts\utility::array_add(var_01,"movement");
	}

	var_02 = var_01[randomint(var_01.size)];
	addthreatexposedalias(var_02);
}

//Function Number: 39
threatinfantryrpg(param_00)
{
	addthreatalias("rpg");
}

//Function Number: 40
playreactionevent()
{
	self endon("death");
	self endon("removed from battleChatter");
	self.curevent = self.chatqueue["reaction"];
	var_00 = self.chatqueue["reaction"].reactto;
	var_01 = self.chatqueue["reaction"].modifier;
	anim thread lockaction(self,"reaction");
	switch(self.chatqueue["reaction"].eventtype)
	{
		case "casualty":
			reactioncasualty(var_00,var_01);
			break;

		case "taunt":
			reactiontaunt(var_00,var_01);
			break;

		case "friendlyfire":
			reactionfriendlyfire(var_00,var_01);
			break;

		case "takingfire":
			reactiontakingfire(var_00,var_01);
			if(common_scripts\utility::cointoss())
			{
				var_02 = getresponder(64,1024,"response");
				if(isdefined(var_02))
				{
					if(common_scripts\utility::cointoss())
					{
						if(var_02 cansay("reaction","ask_ok",1,undefined))
						{
							var_02 animscripts\battlechatter_ai::addreactionevent("ask_ok",undefined,self,1);
						}
					}
					else
					{
						var_02 animscripts\battlechatter_ai::addresponseevent("covering","fire",self,1);
					}
				}
			}
			break;

		case "ask_ok":
			responsetakingfire(var_00,"ask","ok");
			var_02 = getresponder(64,1024,"response");
			if(isdefined(var_02))
			{
				var_02 animscripts\battlechatter_ai::addresponseevent("im","ok",self,1);
			}
			break;
	}

	self notify("done speaking");
}

//Function Number: 41
reactioncasualty(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_02 = createchatphrase();
	var_02 addreactionalias("casualty","generic");
	playphrase(var_02);
}

//Function Number: 42
reactiontaunt(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_02 = createchatphrase();
	if(isdefined(param_01) && param_01 == "hostileburst")
	{
		var_02 addhostileburstalias();
	}
	else
	{
		var_02 addtauntalias("taunt","generic");
	}

	playphrase(var_02);
}

//Function Number: 43
reactionfriendlyfire(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_02 = createchatphrase();
	var_02 addcheckfirealias();
	playphrase(var_02);
}

//Function Number: 44
reactiontakingfire(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_02 = createchatphrase();
	var_02 addtakingfirealias();
	playphrase(var_02);
}

//Function Number: 45
responsetakingfire(param_00,param_01,param_02)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_03 = createchatphrase();
	var_03 addresponsealias(param_01,param_02);
	playphrase(var_03);
}

//Function Number: 46
playresponseevent()
{
	self endon("death");
	self endon("removed from battleChatter");
	self.curevent = self.chatqueue["response"];
	var_00 = self.chatqueue["response"].modifier;
	var_01 = self.chatqueue["response"].respondto;
	if(!isalive(var_01))
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
		case "exposed":
			responsethreatexposed(var_01,var_00);
			break;

		case "callout":
			responsethreatcallout(var_01,var_00);
			break;

		case "ack":
			responsegeneric(var_01,var_00);
			break;

		default:
			responsegeneric(var_01,var_00);
			break;
	}

	self notify("done speaking");
}

//Function Number: 47
responsethreatexposed(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!isalive(param_00))
	{
		return;
	}

	var_02 = createchatphrase();
	var_02 addthreatexposedalias(param_01);
	var_02.looktarget = param_00;
	var_02.master = 1;
	playphrase(var_02);
}

//Function Number: 48
responsethreatcallout(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!isalive(param_00))
	{
		return;
	}

	var_02 = createchatphrase();
	var_03 = 0;
	if(param_01 == "echo")
	{
		var_03 = var_02 addthreatcalloutecho(self.curevent.reportalias,param_00);
	}
	else if(param_01 == "QA")
	{
		var_03 = var_02 addthreatcalloutqa_nextline(param_00,self.curevent.reportalias,self.curevent.location);
	}
	else
	{
		var_03 = var_02 addthreatcalloutresponsealias(param_01);
	}

	if(!var_03)
	{
		return;
	}

	var_02.looktarget = param_00;
	var_02.master = 1;
	playphrase(var_02);
}

//Function Number: 49
responsegeneric(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!isalive(param_00))
	{
		return;
	}

	var_02 = self.chatqueue["response"].eventtype;
	var_03 = createchatphrase();
	var_03 addresponsealias(var_02,param_01);
	var_03.looktarget = param_00;
	var_03.master = 1;
	playphrase(var_03);
}

//Function Number: 50
playorderevent()
{
	self endon("death");
	self endon("removed from battleChatter");
	self.curevent = self.chatqueue["order"];
	var_00 = self.chatqueue["order"].modifier;
	var_01 = self.chatqueue["order"].orderto;
	anim thread lockaction(self,"order");
	switch(self.chatqueue["order"].eventtype)
	{
		case "action":
			orderaction(var_00,var_01);
			break;

		case "move":
			ordermove(var_00,var_01);
			break;

		case "displace":
			orderdisplace(var_00);
			break;
	}

	self notify("done speaking");
}

//Function Number: 51
orderaction(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_02 = createchatphrase();
	tryorderto(var_02,param_01);
	var_02 addorderalias("action",param_00);
	playphrase(var_02);
}

//Function Number: 52
ordermove(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_02 = createchatphrase();
	tryorderto(var_02,param_01);
	var_02 addorderalias("move",param_00);
	playphrase(var_02);
}

//Function Number: 53
orderdisplace(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_01 = createchatphrase();
	var_01 addorderalias("displace",param_00);
	playphrase(var_01,1);
}

//Function Number: 54
tryorderto(param_00,param_01)
{
	if(randomint(100) > level.eventchance["response"]["order"])
	{
		if(!isdefined(param_01) || isdefined(param_01) && !isplayer(param_01))
		{
			return;
		}
	}

	if(isdefined(param_01) && isplayer(param_01) && isdefined(level.player.bcnameid))
	{
		param_00 addplayernamealias();
		param_00.looktarget = level.player;
		return;
	}

	if(isdefined(param_01) && cansayname(param_01))
	{
		param_00 addnamealias(param_01.bcname);
		param_00.looktarget = param_01;
		param_01 animscripts\battlechatter_ai::addresponseevent("ack","yes",self,0.9);
		return;
	}

	level notify("follow order",self);
}

//Function Number: 55
playinformevent()
{
	self endon("death");
	self endon("removed from battleChatter");
	self.curevent = self.chatqueue["inform"];
	var_00 = self.chatqueue["inform"].modifier;
	anim thread lockaction(self,"inform");
	switch(self.chatqueue["inform"].eventtype)
	{
		case "incoming":
			informincoming(var_00);
			break;

		case "attack":
			informattacking(var_00);
			break;

		case "reloading":
			informreloading(var_00);
			break;

		case "suppressed":
			informsuppressed(var_00);
			break;

		case "killfirm":
			informkillfirm(var_00);
			break;
	}

	self notify("done speaking");
}

//Function Number: 56
informreloading(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_01 = createchatphrase();
	var_01 addinformalias("reloading",param_00);
	playphrase(var_01);
}

//Function Number: 57
informsuppressed(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_01 = createchatphrase();
	var_01 addinformalias("suppressed",param_00);
	playphrase(var_01);
}

//Function Number: 58
informincoming(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_01 = createchatphrase();
	if(param_00 == "grenade")
	{
		var_01.master = 1;
	}

	var_01 addinformalias("incoming",param_00);
	playphrase(var_01);
}

//Function Number: 59
informattacking(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_01 = createchatphrase();
	var_01 addinformalias("attack",param_00);
	playphrase(var_01);
}

//Function Number: 60
informkillfirm(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_01 = createchatphrase();
	var_01 addinformalias("killfirm",param_00);
	playphrase(var_01);
}

//Function Number: 61
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

//Function Number: 62
playphrase(param_00,param_01)
{
	anim endon("battlechatter disabled");
	self endon("dog_attacks_ai");
	self endon("death");
	if(isdefined(param_01))
	{
		return;
	}

	if(battlechatter_canprint() || battlechatter_canprintdump())
	{
		var_02 = [];
		foreach(var_04 in param_00.soundaliases)
		{
			var_02[var_02.size] = var_04;
		}

		if(battlechatter_canprint())
		{
			battlechatter_print(var_02);
		}

		if(battlechatter_canprintdump())
		{
			var_06 = self.curevent.eventaction + "_" + self.curevent.eventtype;
			if(isdefined(self.curevent.modifier))
			{
				var_06 = var_06 + "_" + self.curevent.modifier;
			}

			thread battlechatter_printdump(var_02,var_06);
		}
	}

	for(var_07 = 0;var_07 < param_00.soundaliases.size;var_07++)
	{
		if(!self.battlechatter)
		{
			if(!is_friendlyfire_event(self.curevent))
			{
			}
			else
			{
			}
			else if(!can_say_friendlyfire(0))
			{
			}
			else if(self._animactive > 0)
			{
			}
			else if(isfiltered(self.curevent.eventaction))
			{
				wait(0.85);
			}
			else if(!soundexists(param_00.soundaliases[var_07]))
			{
			}
			else
			{
				var_08 = gettime();
				var_09 = spawn("script_origin",self gettagorigin("j_head"));
				var_09 linkto(self);
				thread stop_speaking(param_00.soundaliases[var_07],var_09);
				if(param_00.master && self.team == "allies")
				{
					thread maps\_anim::anim_facialfiller(param_00.soundaliases[var_07],param_00.looktarget);
					var_09 playsound(param_00.soundaliases[var_07],param_00.soundaliases[var_07],1);
					var_09 waittill(param_00.soundaliases[var_07]);
					self notify(param_00.soundaliases[var_07]);
				}
				else
				{
					thread maps\_anim::anim_facialfiller(param_00.soundaliases[var_07],param_00.looktarget);
					if(getdvarint("bcs_forceEnglish",0))
					{
						var_09 playsound(param_00.soundaliases[var_07],param_00.soundaliases[var_07],1);
					}
					else
					{
						var_09 playsound(param_00.soundaliases[var_07],param_00.soundaliases[var_07],1);
					}

					var_09 waittill(param_00.soundaliases[var_07]);
					self notify(param_00.soundaliases[var_07]);
				}

				var_09 delete();
				if(gettime() < var_08 + 250)
				{
				}
			}
		}
	}

	self notify("playPhrase_done");
	dotypelimit(self.curevent.eventaction,self.curevent.eventtype);
}

//Function Number: 63
stop_speaking(param_00,param_01)
{
	param_01 endon("death");
	common_scripts\utility::waittill_either("death","dog_attacks_ai");
	param_01 stopsounds();
	wait 0.05;
	param_01 notify(param_00);
	param_01 delete();
}

//Function Number: 64
is_friendlyfire_event(param_00)
{
	if(!isdefined(param_00.eventaction) || !isdefined(param_00.eventtype))
	{
		return 0;
	}

	if(param_00.eventaction == "reaction" && param_00.eventtype == "friendlyfire")
	{
		return 1;
	}

	return 0;
}

//Function Number: 65
isspeakingfailsafe(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	wait(25);
	clearisspeaking(param_00);
}

//Function Number: 66
clearisspeaking(param_00)
{
	self.isspeaking = 0;
	self.chatqueue[param_00].expiretime = 0;
	self.chatqueue[param_00].priority = 0;
	self.nextsaytimes[param_00] = gettime() + level.eventactionminwait[param_00]["self"];
}

//Function Number: 67
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
	if(var_05 == "cancel speaking")
	{
		return;
	}

	level.lastteamspeaktime[var_04] = gettime();
	if(isalive(param_00))
	{
		param_00 clearisspeaking(param_01);
	}

	var_03.nextsaytimes[param_01] = gettime() + level.eventactionminwait[param_01]["squad"];
}

//Function Number: 68
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

//Function Number: 69
cansay(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(isplayer(self))
	{
		return 0;
	}

	if(distance(level.player.origin,self.origin) > level.bcs_maxtalkingdistsqrdfromplayer)
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

	return 1;
}

//Function Number: 70
gethighestpriorityevent()
{
	var_00 = undefined;
	var_01 = -999999999;
	foreach(var_04, var_03 in self.chatqueue)
	{
		if(isvalidevent(var_04))
		{
			if(var_03.priority > var_01)
			{
				var_00 = var_04;
				var_01 = var_03.priority;
			}
		}
	}

	return var_00;
}

//Function Number: 71
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

//Function Number: 72
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

//Function Number: 73
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

//Function Number: 74
isfiltered(param_00)
{
	if(getdvar("bcs_filter" + param_00,"off") == "on" || getdvar("bcs_filter" + param_00,"off") == "1")
	{
		return 1;
	}

	return 0;
}

//Function Number: 75
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

//Function Number: 76
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

//Function Number: 77
dotypelimit(param_00,param_01)
{
	if(!isdefined(level.eventtypeminwait[param_00][param_01]))
	{
		return;
	}

	self.squad.nexttypesaytimes[param_00][param_01] = gettime() + level.eventtypeminwait[param_00][param_01];
}

//Function Number: 78
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

//Function Number: 79
isexposed(param_00)
{
	if(distancesquared(self.origin,level.player.origin) > 2250000)
	{
		return 0;
	}

	if(isdefined(param_00) && param_00 && isdefined(getlocation()))
	{
		return 0;
	}

	var_01 = bcgetclaimednode();
	if(!isdefined(var_01))
	{
		return 1;
	}

	if(!isnodecoverorconceal())
	{
		return 0;
	}

	return 1;
}

//Function Number: 80
isnodecoverorconceal()
{
	var_00 = self.node;
	if(!isdefined(var_00))
	{
		return 0;
	}

	if(issubstr(var_00.type,"Cover") || issubstr(var_00.type,"Conceal"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 81
squadhasofficer(param_00)
{
	if(param_00.officercount > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 82
isofficer()
{
	var_00 = getrank();
	if(!isdefined(var_00))
	{
		return 0;
	}

	if(var_00 == "sergeant" || var_00 == "lieutenant" || var_00 == "captain" || var_00 == "sergeant")
	{
		return 1;
	}

	return 0;
}

//Function Number: 83
bcgetclaimednode()
{
	if(isplayer(self))
	{
		return self.node;
	}

	return animscripts\utility::getclaimednode();
}

//Function Number: 84
enemy_team_name()
{
	if(self isbadguy())
	{
		return 1;
	}

	return 0;
}

//Function Number: 85
getname()
{
	if(enemy_team_name())
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

	if(!isdefined(var_00))
	{
		return undefined;
	}

	var_01 = strtok(var_00," ");
	if(var_01.size < 2)
	{
		return var_00;
	}

	return var_01[1];
}

//Function Number: 86
getrank()
{
	return self.airank;
}

//Function Number: 87
getclosestfriendlyspeaker(param_00)
{
	var_01 = getspeakers(param_00,self.team);
	var_02 = common_scripts\utility::getclosest(self.origin,var_01);
	return var_02;
}

//Function Number: 88
getspeakers(param_00,param_01)
{
	var_02 = [];
	var_03 = getaiarray(param_01);
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		if(var_03[var_04] == self)
		{
			continue;
		}

		if(!var_03[var_04] cansay(param_00))
		{
			continue;
		}

		var_02[var_02.size] = var_03[var_04];
	}

	return var_02;
}

//Function Number: 89
getresponder(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(!isdefined(param_02))
	{
		param_02 = "response";
	}

	var_04 = common_scripts\utility::array_randomize(self.squad.members);
	param_00 = param_00 * param_00;
	param_01 = param_01 * param_01;
	for(var_05 = 0;var_05 < var_04.size;var_05++)
	{
		if(var_04[var_05] == self)
		{
			continue;
		}

		if(!isalive(var_04[var_05]))
		{
			continue;
		}

		var_06 = distancesquared(self.origin,var_04[var_05].origin);
		if(var_06 < param_00)
		{
			continue;
		}

		if(var_06 > param_01)
		{
			continue;
		}

		if(isusingsamevoice(var_04[var_05]))
		{
			continue;
		}

		if(!var_04[var_05] cansay(param_02))
		{
			continue;
		}

		var_03 = var_04[var_05];
		if(cansayname(var_03))
		{
			break;
		}
	}

	return var_03;
}

//Function Number: 90
getlocation()
{
	var_00 = get_all_my_locations();
	var_00 = common_scripts\utility::array_randomize(var_00);
	if(var_00.size)
	{
		foreach(var_02 in var_00)
		{
			if(!location_called_out_ever(var_02))
			{
				return var_02;
			}
		}

		foreach(var_02 in var_00)
		{
			if(!location_called_out_recently(var_02))
			{
				return var_02;
			}
		}
	}

	return undefined;
}

//Function Number: 91
getvalidlocation(param_00)
{
	var_01 = get_all_my_locations();
	var_01 = common_scripts\utility::array_randomize(var_01);
	if(var_01.size)
	{
		foreach(var_03 in var_01)
		{
			if(!location_called_out_ever(var_03) && param_00 cancalloutlocation(var_03))
			{
				return var_03;
			}
		}

		foreach(var_03 in var_01)
		{
			if(!location_called_out_recently(var_03) && param_00 cancalloutlocation(var_03))
			{
				return var_03;
			}
		}
	}

	return undefined;
}

//Function Number: 92
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

//Function Number: 93
update_bcs_locations()
{
	if(isdefined(level.bcs_locations))
	{
		anim.bcs_locations = common_scripts\utility::array_removeundefined(level.bcs_locations);
	}
}

//Function Number: 94
is_in_callable_location()
{
	var_00 = get_all_my_locations();
	foreach(var_02 in var_00)
	{
		if(!location_called_out_recently(var_02))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 95
location_called_out_ever(param_00)
{
	var_01 = location_get_last_callout_time(param_00);
	if(!isdefined(var_01))
	{
		return 0;
	}

	return 1;
}

//Function Number: 96
location_called_out_recently(param_00)
{
	var_01 = location_get_last_callout_time(param_00);
	if(!isdefined(var_01))
	{
		return 0;
	}

	var_02 = var_01 + level.eventactionminwait["threat"]["location_repeat"];
	if(gettime() < var_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 97
location_add_last_callout_time(param_00)
{
	level.locationlastcallouttimes[param_00.classname] = gettime();
}

//Function Number: 98
location_get_last_callout_time(param_00)
{
	if(isdefined(level.locationlastcallouttimes[param_00.classname]))
	{
		return level.locationlastcallouttimes[param_00.classname];
	}

	return undefined;
}

//Function Number: 99
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

//Function Number: 100
sideisleftright(param_00)
{
	if(param_00 == "left" || param_00 == "right")
	{
		return 1;
	}

	return 0;
}

//Function Number: 101
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

//Function Number: 102
normalizecompassdirection(param_00)
{
	var_01 = undefined;
	switch(param_00)
	{
		case "north":
			var_01 = "n";
			break;

		case "northwest":
			var_01 = "nw";
			break;

		case "west":
			var_01 = "w";
			break;

		case "southwest":
			var_01 = "sw";
			break;

		case "south":
			var_01 = "s";
			break;

		case "southeast":
			var_01 = "se";
			break;

		case "east":
			var_01 = "e";
			break;

		case "northeast":
			var_01 = "ne";
			break;

		case "impossible":
			var_01 = "impossible";
			break;

		default:
			break;
	}

	return var_01;
}

//Function Number: 103
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

//Function Number: 104
getdistanceyards(param_00,param_01)
{
	var_02 = distance2d(param_00,param_01);
	var_03 = 0.0254 * var_02;
	return var_03;
}

//Function Number: 105
getdistanceyardsnormalized(param_00,param_01)
{
	var_02 = getdistanceyards(param_00,param_01);
	if(var_02 < 15)
	{
		return "10";
	}

	if(var_02 < 25)
	{
		return "20";
	}

	if(var_02 < 35)
	{
		return "30";
	}

	return "40";
}

//Function Number: 106
getfrontarcclockdirection(param_00)
{
	var_01 = "undefined";
	if(param_00 == "10" || param_00 == "11")
	{
		var_01 = "10";
	}
	else if(param_00 == "12")
	{
		var_01 = param_00;
	}
	else if(param_00 == "1" || param_00 == "2")
	{
		var_01 = "2";
	}

	return var_01;
}

//Function Number: 107
getdirectionfacingclock(param_00,param_01,param_02)
{
	var_03 = getdirectionfacingangle(param_00,param_01,param_02);
	return getdirectionfacingclockgivenangle(var_03);
}

//Function Number: 108
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

//Function Number: 109
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

//Function Number: 110
getdegreeselevation(param_00,param_01)
{
	var_02 = param_01[2] - param_00[2];
	var_03 = distance2d(param_00,param_01);
	var_04 = atan(var_02 / var_03);
	if(var_04 < 15 || var_04 > 55)
	{
		return var_04;
	}

	if(var_04 < 25)
	{
		return 20;
	}

	if(var_04 < 35)
	{
		return 30;
	}

	if(var_04 < 45)
	{
		return 40;
	}

	if(var_04 < 55)
	{
		return 50;
	}
}

//Function Number: 111
getvectorrightangle(param_00)
{
	return (param_00[1],0 - param_00[0],param_00[2]);
}

//Function Number: 112
getvectorarrayaverage(param_00)
{
	var_01 = (0,0,0);
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_01 = var_01 + param_00[var_02];
	}

	return (var_01[0] / param_00.size,var_01[1] / param_00.size,var_01[2] / param_00.size);
}

//Function Number: 113
addconcattargetalias(param_00)
{
	var_01 = "";
	if(param_00 animscripts\utility::usingrocketlauncher())
	{
		var_01 = "_rpg";
	}
	else if(param_00 bcissniper())
	{
		var_01 = "_sniper";
	}

	var_02 = self.owner.countryid + "_" + self.owner.npcid + "_concat_target" + var_01;
	self.soundaliases[self.soundaliases.size] = var_02;
}

//Function Number: 114
addconcatdirectionalias(param_00,param_01)
{
	var_02 = common_scripts\utility::random(["relative","absolute"]);
	switch(var_02)
	{
		case "absolute":
			var_03 = getdirectioncompass(level.player.origin,param_01.origin);
			var_04 = normalizecompassdirection(var_03);
			if(var_04 != "impossible" && var_04.size != 2)
			{
				var_05 = self.owner.countryid + "_" + self.owner.npcid + "_concat_dir_cmpss_" + var_04;
				self.soundaliases[self.soundaliases.size] = var_05;
				break;
			}
	
			break;

		case "relative":
			var_06 = getrelativeangles(param_00);
			var_07 = getdirectionfacingclock(var_06,param_00.origin,param_01.origin);
			var_08 = int(var_07);
			if(1 < var_08 && var_08 < 5 && common_scripts\utility::cointoss())
			{
				var_05 = self.owner.countryid + "_" + self.owner.npcid + "_concat_dir_right";
				self.soundaliases[self.soundaliases.size] = var_05;
				break;
			}
			else if(7 < var_08 && var_08 < 11 && common_scripts\utility::cointoss())
			{
				var_05 = self.owner.countryid + "_" + self.owner.npcid + "_concat_dir_left";
				self.soundaliases[self.soundaliases.size] = var_05;
				break;
			}
			else
			{
				var_05 = self.owner.countryid + "_" + self.owner.npcid + "_concat_dir_clock_" + var_07;
				self.soundaliases[self.soundaliases.size] = var_05;
			}
			break;
	}
}

//Function Number: 115
addnamealias(param_00)
{
	self.soundaliases[self.soundaliases.size] = self.owner.countryid + "_" + self.owner.npcid + "_name_" + param_00;
	level.lastnamesaid[self.owner.team] = param_00;
	level.lastnamesaidtime[self.owner.team] = gettime();
}

//Function Number: 116
addplayernamealias()
{
	if(!self.owner cansayplayername())
	{
		return;
	}

	anim.lastplayernamecalltime = gettime();
	var_00 = self.owner.countryid + "_" + self.owner.npcid + "_name_player_" + level.player.countryid + "_" + level.player.bcnameid;
	self.soundaliases[self.soundaliases.size] = var_00;
	self.looktarget = level.player;
}

//Function Number: 117
addrankalias(param_00)
{
	self.soundaliases[self.soundaliases.size] = self.owner.countryid + "_" + self.owner.npcid + "_rank_" + param_00;
}

//Function Number: 118
cansayname(param_00)
{
	if(enemy_team_name())
	{
		return 0;
	}

	if(!isdefined(param_00.bcname))
	{
		return 0;
	}

	if(param_00.battlechatter == 0)
	{
		return 0;
	}

	if(!isdefined(param_00.countryid))
	{
		return 0;
	}

	if(self.countryid != param_00.countryid)
	{
		return 0;
	}

	if(namesaidrecently(param_00))
	{
		return 0;
	}

	var_01 = self.countryid + "_" + self.npcid + "_name_" + param_00.bcname;
	if(soundexists(var_01))
	{
		return 1;
	}

	return 0;
}

//Function Number: 119
namesaidrecently(param_00)
{
	if(level.lastnamesaid[self.team] == param_00.bcname || gettime() - level.lastnamesaidtime[self.team] < level.lastnamesaidtimeout)
	{
		return 1;
	}

	return 0;
}

//Function Number: 120
cansayplayername()
{
	if(enemy_team_name())
	{
		return 0;
	}

	if(!isdefined(level.player.bcnameid) || !isdefined(level.player.countryid))
	{
		return 0;
	}

	if(player_name_called_recently())
	{
		return 0;
	}

	var_00 = self.countryid + "_" + self.npcid + "_name_player_" + level.player.countryid + "_" + level.player.bcnameid;
	if(soundexists(var_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 121
player_name_called_recently()
{
	if(!isdefined(level.lastplayernamecalltime))
	{
		return 0;
	}

	if(gettime() - level.lastplayernamecalltime >= level.eventtypeminwait["playername"])
	{
		return 0;
	}

	return 1;
}

//Function Number: 122
isusingsamevoice(param_00)
{
	if(isstring(self.npcid) && isstring(param_00.npcid) && self.npcid == param_00.npcid)
	{
		return 1;
	}

	if(!isstring(self.npcid) && !isstring(param_00.npcid) && self.npcid == param_00.npcid)
	{
		return 1;
	}

	return 0;
}

//Function Number: 123
addthreatalias(param_00,param_01)
{
	var_02 = self.owner.countryid + "_" + self.owner.npcid + "_threat_" + param_00;
	if(isdefined(param_01))
	{
		var_02 = var_02 + "_" + param_01;
	}

	self.soundaliases = common_scripts\utility::array_add(self.soundaliases,var_02);
	return 1;
}

//Function Number: 124
addthreatexposedalias(param_00)
{
	var_01 = self.owner.countryid + "_" + self.owner.npcid + "_exposed_" + param_00;
	self.soundaliases[self.soundaliases.size] = var_01;
	return 1;
}

//Function Number: 125
addthreatobviousalias()
{
	var_00 = self.owner.countryid + "_" + self.owner.npcid + "_order_action_suppress";
	self.soundaliases[self.soundaliases.size] = var_00;
	return 1;
}

//Function Number: 126
addthreatdistancealias(param_00)
{
	var_01 = self.owner.countryid + "_" + self.owner.npcid + "_co_dist_" + param_00;
	self.soundaliases[self.soundaliases.size] = var_01;
	return 1;
}

//Function Number: 127
addthreatelevationalias(param_00)
{
	var_01 = self.owner.countryid + "_" + self.owner.npcid + "_co_elev_" + param_00;
	self.soundaliases[self.soundaliases.size] = var_01;
	return 1;
}

//Function Number: 128
addthreatcalloutecho(param_00,param_01)
{
	var_02 = createechoalias(param_00,param_01);
	if(!soundexists(var_02))
	{
		return 0;
	}

	self.soundaliases[self.soundaliases.size] = var_02;
	return 1;
}

//Function Number: 129
addthreatcalloutresponsealias(param_00)
{
	var_01 = self.owner.countryid + "_" + self.owner.npcid + "_resp_ack_co_gnrc_" + param_00;
	if(!soundexists(var_01))
	{
		return 0;
	}

	self.soundaliases[self.soundaliases.size] = var_01;
	return 1;
}

//Function Number: 130
addthreatcalloutqa_nextline(param_00,param_01,param_02)
{
	var_03 = undefined;
	foreach(var_05 in param_02.locationaliases)
	{
		if(issubstr(param_01,var_05))
		{
			var_03 = var_05;
			break;
		}
	}

	var_07 = self.owner.countryid + "_" + self.owner.npcid + "_";
	var_08 = getsubstr(param_01,param_01.size - 1,param_01.size);
	var_09 = int(var_08) + 1;
	var_0A = var_07 + "co_loc_" + var_03 + "_qa" + var_09;
	if(!soundexists(var_0A))
	{
		if(randomint(100) < level.eventchance["response"]["callout_negative"])
		{
			param_00 animscripts\battlechatter_ai::addresponseevent("callout","neg",self.owner,0.9);
		}
		else
		{
			param_00 animscripts\battlechatter_ai::addresponseevent("exposed","acquired",self.owner,0.9);
		}

		param_02.qafinished = 1;
		return 0;
	}

	param_00 animscripts\battlechatter_ai::addresponseevent("callout","QA",self.owner,0.9,var_0A,param_02);
	self.soundaliases[self.soundaliases.size] = var_0A;
	return 1;
}

//Function Number: 131
createechoalias(param_00,param_01)
{
	var_02 = "_report";
	var_03 = "_echo";
	var_04 = self.owner.countryid + "_" + self.owner.npcid + "_";
	var_05 = param_00.size - var_02.size;
	var_06 = self.owner.countryid + "_" + param_01.npcid + "_";
	var_07 = var_06.size;
	var_08 = getsubstr(param_00,var_07,var_05);
	var_09 = var_04 + var_08 + var_03;
	return var_09;
}

//Function Number: 132
addthreatcalloutalias(param_00,param_01)
{
	var_02 = self.owner.countryid + "_" + self.owner.npcid + "_callout_" + param_00 + "_" + param_01;
	self.soundaliases[self.soundaliases.size] = var_02;
	return 1;
}

//Function Number: 133
addthreatcalloutlandmarkalias(param_00,param_01,param_02)
{
	var_03 = param_00.script_landmark;
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_04 = self.owner.countryid + "_" + self.owner.npcid + "_callout_obj_" + var_03;
	if(param_02)
	{
		var_04 = var_04 + "_y";
	}

	var_04 = var_04 + "_" + param_01;
	if(!soundexists(var_04))
	{
		return 0;
	}

	self.soundaliases[self.soundaliases.size] = var_04;
	return 1;
}

//Function Number: 134
addthreatcalloutlocationalias(param_00,param_01)
{
	var_02 = undefined;
	var_03 = param_00.locationaliases;
	var_04 = var_03[0];
	if(var_03.size > 1)
	{
		var_05 = undefined;
		var_05 = param_00 getcannedresponse(self.owner);
		if(isdefined(var_05))
		{
			var_04 = var_05;
		}
		else
		{
			var_04 = common_scripts\utility::random(var_03);
		}
	}

	var_06 = undefined;
	if(isdefined(param_01) && param_01)
	{
		var_06 = self.owner getloccalloutalias("concat_loc_" + var_04);
	}
	else if(!isdefined(param_00.qafinished) && iscallouttypeqa(var_04,self.owner))
	{
		var_06 = self.owner getqacalloutalias(var_04,0);
	}
	else
	{
		var_06 = self.owner getloccalloutalias("co_loc_" + var_04);
	}

	if(soundexists(var_06))
	{
		var_02 = var_06;
	}

	if(!isdefined(var_02))
	{
		return 0;
	}

	location_add_last_callout_time(param_00);
	self.soundaliases[self.soundaliases.size] = var_02;
	return 1;
}

//Function Number: 135
addinformalias(param_00,param_01)
{
	var_02 = self.owner.countryid + "_" + self.owner.npcid + "_inform_" + param_00 + "_" + param_01;
	self.soundaliases[self.soundaliases.size] = var_02;
}

//Function Number: 136
addresponsealias(param_00,param_01)
{
	var_02 = self.owner.countryid + "_" + self.owner.npcid + "_response_" + param_00 + "_" + param_01;
	self.soundaliases[self.soundaliases.size] = var_02;
	return 1;
}

//Function Number: 137
addreactionalias(param_00,param_01)
{
	var_02 = self.owner.countryid + "_" + self.owner.npcid + "_reaction_" + param_00 + "_" + param_01;
	self.soundaliases[self.soundaliases.size] = var_02;
	return 1;
}

//Function Number: 138
addcheckfirealias()
{
	var_00 = self.owner.countryid + "_" + self.owner.npcid + "_check_fire";
	self.soundaliases[self.soundaliases.size] = var_00;
	return 1;
}

//Function Number: 139
addtakingfirealias()
{
	var_00 = self.owner.countryid + "_" + self.owner.npcid + "_inform_taking_fire";
	self.soundaliases[self.soundaliases.size] = var_00;
	return 1;
}

//Function Number: 140
addtauntalias(param_00,param_01)
{
	var_02 = self.owner.countryid + "_" + self.owner.npcid + "_taunt";
	self.soundaliases[self.soundaliases.size] = var_02;
	return 1;
}

//Function Number: 141
addhostileburstalias()
{
	var_00 = self.owner.countryid + "_" + self.owner.npcid + "_hostile_burst";
	self.soundaliases[self.soundaliases.size] = var_00;
	return 1;
}

//Function Number: 142
addorderalias(param_00,param_01)
{
	var_02 = self.owner.countryid + "_" + self.owner.npcid + "_order_" + param_00 + "_" + param_01;
	self.soundaliases[self.soundaliases.size] = var_02;
	return 1;
}

//Function Number: 143
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

//Function Number: 144
shutdowncontact(param_00)
{
	self.squadlist[param_00].calledout = undefined;
	self.squadlist[param_00].firstcontact = undefined;
	self.squadlist[param_00].lastcontact = undefined;
}

//Function Number: 145
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

//Function Number: 146
createchatphrase()
{
	var_00 = spawnstruct();
	var_00.owner = self;
	var_00.soundaliases = [];
	var_00.master = 0;
	return var_00;
}

//Function Number: 147
pointinfov(param_00)
{
	return common_scripts\utility::within_fov(self.origin,self.angles,param_00,0.766);
}

//Function Number: 148
entinfrontarc(param_00)
{
	return common_scripts\utility::within_fov(self.origin,self.angles,param_00.origin,0);
}

//Function Number: 149
squadflavorbursttransmissions()
{
	anim endon("battlechatter disabled");
	self endon("squad_deleting");
	if(self.team != "allies")
	{
		return;
	}

	while(self.membercount <= 0)
	{
		wait(0.5);
	}

	wait(0.5);
	var_00 = 0;
	while(isdefined(self))
	{
		if(!squadcanburst(self))
		{
			var_00 = 1;
			wait(1);
			continue;
		}
		else if(self.fbt_firstburst)
		{
			if(!var_00)
			{
				wait(randomfloat(level.fbt_waitmin));
			}

			if(var_00)
			{
				var_00 = 0;
			}

			self.fbt_firstburst = 0;
		}
		else
		{
			if(!var_00)
			{
				wait(randomfloatrange(level.fbt_waitmin,level.fbt_waitmax));
			}

			if(var_00)
			{
				var_00 = 0;
			}
		}

		var_01 = getburster(self);
		if(!isdefined(var_01))
		{
			continue;
		}

		var_02 = var_01.voice;
		var_03 = getflavorburstid(self,var_02);
		var_04 = getflavorburstaliases(var_02,var_03);
		foreach(var_08, var_06 in var_04)
		{
			if(!var_01 candoflavorburst() || distance(level.player.origin,var_01.origin) > level.fbt_desireddistmax)
			{
				for(var_07 = 0;var_07 < self.members.size;var_07++)
				{
					var_01 = getburster(self);
					if(!isdefined(var_01))
					{
						continue;
					}

					if(var_01.voice == var_02)
					{
						break;
					}
				}

				if(!isdefined(var_01) || var_01.voice != var_02)
				{
					break;
				}
			}

			thread playflavorburstline(var_01,var_06);
			self waittill("burst_line_done");
			if(var_08 != var_04.size - 1)
			{
				wait(randomfloatrange(level.fbt_linebreakmin,level.fbt_linebreakmax));
			}
		}
	}
}

//Function Number: 150
squadcanburst(param_00)
{
	var_01 = 0;
	foreach(var_03 in param_00.members)
	{
		if(var_03 candoflavorburst())
		{
			var_01 = 1;
			break;
		}
	}

	return var_01;
}

//Function Number: 151
candoflavorburst()
{
	var_00 = 0;
	if(!isplayer(self) && isalive(self) && self.classname != "actor_enemy_dog" && level.flavorbursts[self.team] && voicecanburst() && self.flavorbursts)
	{
		var_00 = 1;
	}

	return var_00;
}

//Function Number: 152
voicecanburst()
{
	if(isdefined(level.flavorburstvoices[self.voice]) && level.flavorburstvoices[self.voice])
	{
		return 1;
	}

	return 0;
}

//Function Number: 153
getburster(param_00)
{
	var_01 = undefined;
	var_02 = common_scripts\utility::get_array_of_farthest(level.player.origin,param_00.members);
	foreach(var_04 in var_02)
	{
		if(var_04 candoflavorburst())
		{
			var_01 = var_04;
			if(!isdefined(param_00.fbt_lastbursterid))
			{
				break;
			}

			if(isdefined(param_00.fbt_lastbursterid) && param_00.fbt_lastbursterid == var_01.unique_id)
			{
				continue;
			}
		}
	}

	if(isdefined(var_01))
	{
		param_00.fbt_lastbursterid = var_01.unique_id;
	}

	return var_01;
}

//Function Number: 154
getflavorburstid(param_00,param_01)
{
	var_02 = common_scripts\utility::array_randomize(level.flavorbursts[param_01]);
	if(level.flavorburstsused.size >= var_02.size)
	{
		anim.flavorburstsused = [];
	}

	var_03 = undefined;
	foreach(var_05 in var_02)
	{
		var_03 = var_05;
		if(!flavorburstwouldrepeat(var_03))
		{
			break;
		}
	}

	level.flavorburstsused[level.flavorburstsused.size] = var_03;
	return var_03;
}

//Function Number: 155
flavorburstwouldrepeat(param_00)
{
	if(!level.flavorburstsused.size)
	{
		return 0;
	}

	var_01 = 0;
	foreach(var_03 in level.flavorburstsused)
	{
		if(var_03 == param_00)
		{
			var_01 = 1;
			break;
		}
	}

	return var_01;
}

//Function Number: 156
getflavorburstaliases(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_03 = param_02;
	var_04 = [];
	for(;;)
	{
		var_05 = "FB_" + level.countryids[param_00] + "_" + param_01 + "_" + var_03;
		var_03++;
		if(soundexists(var_05))
		{
			var_04[var_04.size] = var_05;
			continue;
		}

		break;
	}

	return var_04;
}

//Function Number: 157
playflavorburstline(param_00,param_01)
{
	anim endon("battlechatter disabled");
	var_02 = spawn("script_origin",param_00 gettagorigin("j_head"));
	var_02 linkto(param_00);
	var_02 playsound(param_01,param_01,1);
	var_02 waittill(param_01);
	var_02 delete();
	if(isdefined(self))
	{
		self notify("burst_line_done");
	}
}

//Function Number: 158
flavorburstlinedebug(param_00,param_01)
{
	self endon("burst_line_done");
	wait(0.05);
}

//Function Number: 159
battlechatter_canprint()
{
	return 0;
}

//Function Number: 160
battlechatter_canprintdump()
{
	return 0;
}

//Function Number: 161
battlechatter_print(param_00)
{
	if(param_00.size <= 0)
	{
		return;
	}

	if(!battlechatter_canprint())
	{
		return;
	}

	var_01 = "^5 ";
	if(enemy_team_name())
	{
		var_01 = "^6 ";
	}

	foreach(var_03 in param_00)
	{
	}
}

//Function Number: 162
battlechatter_printdump(param_00,param_01)
{
}

//Function Number: 163
getaliastypefromsoundalias(param_00)
{
	var_01 = self.countryid + "_" + self.npcid + "_";
	var_02 = getsubstr(param_00,var_01.size,param_00.size);
	return var_02;
}

//Function Number: 164
battlechatter_printdumpline(param_00,param_01,param_02)
{
	if(common_scripts\utility::flag(param_02))
	{
		common_scripts\utility::flag_wait(param_02);
	}

	common_scripts\utility::flag_set(param_02);
	common_scripts\utility::flag_clear(param_02);
}

//Function Number: 165
bcdrawobjects()
{
	for(var_00 = 0;var_00 < level.bcs_locations.size;var_00++)
	{
		var_01 = level.bcs_locations[var_00].locationaliases;
		if(!isdefined(var_01))
		{
			continue;
		}

		var_02 = "";
		foreach(var_04 in var_01)
		{
			var_02 = var_02 + var_04;
		}

		thread drawbcobject("Location: " + var_02,level.bcs_locations[var_00] getorigin(),(0,0,8),(1,1,1));
	}
}

//Function Number: 166
drawbcobject(param_00,param_01,param_02,param_03)
{
	for(;;)
	{
		if(distancesquared(level.player.origin,param_01) > 4194304)
		{
			wait(0.1);
			continue;
		}

		wait(0.05);
	}
}

//Function Number: 167
drawbcdirections(param_00,param_01,param_02)
{
	var_03 = param_00 getorigin();
	for(;;)
	{
		if(distancesquared(level.player.origin,var_03) > 4194304)
		{
			wait(0.1);
			continue;
		}

		var_04 = getdirectioncompass(level.player.origin,var_03);
		var_04 = normalizecompassdirection(var_04);
		var_05 = getdirectionfacingclock(level.player.angles,level.player.origin,var_03);
		var_06 = var_04 + ", " + var_05 + ":00";
		wait(0.05);
	}
}

//Function Number: 168
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

//Function Number: 169
voice_is_british_based()
{
	self endon("death");
	if(self.voice == "british")
	{
		return 1;
	}

	return 0;
}

//Function Number: 170
friendlyfire_warning()
{
	if(!can_say_friendlyfire())
	{
		return 0;
	}

	dotypelimit("reaction","friendlyfire");
	thread playreactionevent();
	return 1;
}

//Function Number: 171
can_say_friendlyfire(param_00)
{
	if(isdefined(self.friendlyfire_warnings_disable))
	{
		return 0;
	}

	if(!isdefined(self.chatqueue))
	{
		return 0;
	}

	if(!isdefined(self.chatqueue["reaction"]) || !isdefined(self.chatqueue["reaction"].eventtype))
	{
		return 0;
	}

	if(self.chatqueue["reaction"].eventtype != "friendlyfire")
	{
		return 0;
	}

	if(gettime() > self.chatqueue["reaction"].expiretime)
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(param_00)
	{
		if(isdefined(self.squad.nexttypesaytimes["reaction"]["friendlyfire"]))
		{
			if(gettime() < self.squad.nexttypesaytimes["reaction"]["friendlyfire"])
			{
				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 172
is_xslice()
{
	return isdefined(level.campaign) && level.campaign == "xslice";
}

//Function Number: 173
is_greece()
{
	return isdefined(level.script) && level.script == "greece";
}

//Function Number: 174
use_old_battlechatter()
{
	if(level.script == "sp_berlin" || level.script == "sp_ny_harbor")
	{
		return 1;
	}

	return 0;
}