/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\battlechatter.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 157
 * Decompile Time: 2937 ms
 * Timestamp: 10/27/2023 2:17:48 AM
*******************************************************************/

//Function Number: 1
func_0B6B()
{
	if(isdefined(level.chatinitialized) && level.chatinitialized)
	{
		return;
	}

	setdvarifuninitialized("bcs_enable","on");
	if(getdvar("bcs_enable","on") == "off")
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
	anim.var_B6C = "^3***** BCS WARNING: ";
	func_0B8B();
	func_0B8C();
	level.var_AD0["american"] = "1";
	level.var_AD0["seal"] = "1";
	level.var_AD0["taskforce"] = "1";
	level.var_AD0["secretservice"] = "1";
	level.var_AD0["delta"] = "1";
	thread func_0B9F();
	anim.var_ABB = [];
	level.var_ABB["russian"] = [];
	level.var_ABB["russian"][0] = spawnstruct();
	level.var_ABB["russian"][0].count = 0;
	level.var_ABB["russian"][0].var_AB6 = "0";
	level.var_ABB["russian"][1] = spawnstruct();
	level.var_ABB["russian"][1].count = 0;
	level.var_ABB["russian"][1].var_AB6 = "1";
	level.var_ABB["russian"][2] = spawnstruct();
	level.var_ABB["russian"][2].count = 0;
	level.var_ABB["russian"][2].var_AB6 = "2";
	level.var_ABB["russian"][3] = spawnstruct();
	level.var_ABB["russian"][3].count = 0;
	level.var_ABB["russian"][3].var_AB6 = "3";
	level.var_ABB["russian"][4] = spawnstruct();
	level.var_ABB["russian"][4].count = 0;
	level.var_ABB["russian"][4].var_AB6 = "4";
	level.var_ABB["portuguese"] = [];
	level.var_ABB["portuguese"][0] = spawnstruct();
	level.var_ABB["portuguese"][0].count = 0;
	level.var_ABB["portuguese"][0].var_AB6 = "0";
	level.var_ABB["portuguese"][1] = spawnstruct();
	level.var_ABB["portuguese"][1].count = 0;
	level.var_ABB["portuguese"][1].var_AB6 = "1";
	level.var_ABB["portuguese"][2] = spawnstruct();
	level.var_ABB["portuguese"][2].count = 0;
	level.var_ABB["portuguese"][2].var_AB6 = "2";
	level.var_ABB["shadowcompany"] = [];
	level.var_ABB["shadowcompany"][0] = spawnstruct();
	level.var_ABB["shadowcompany"][0].count = 0;
	level.var_ABB["shadowcompany"][0].var_AB6 = "0";
	level.var_ABB["shadowcompany"][1] = spawnstruct();
	level.var_ABB["shadowcompany"][1].count = 0;
	level.var_ABB["shadowcompany"][1].var_AB6 = "1";
	level.var_ABB["shadowcompany"][2] = spawnstruct();
	level.var_ABB["shadowcompany"][2].count = 0;
	level.var_ABB["shadowcompany"][2].var_AB6 = "2";
	level.var_ABB["shadowcompany"][3] = spawnstruct();
	level.var_ABB["shadowcompany"][3].count = 0;
	level.var_ABB["shadowcompany"][3].var_AB6 = "3";
	level.var_ABB["british"] = [];
	level.var_ABB["british"][0] = spawnstruct();
	level.var_ABB["british"][0].count = 0;
	level.var_ABB["british"][0].var_AB6 = "0";
	level.var_ABB["british"][1] = spawnstruct();
	level.var_ABB["british"][1].count = 0;
	level.var_ABB["british"][1].var_AB6 = "1";
	level.var_ABB["american"] = [];
	level.var_ABB["american"][0] = spawnstruct();
	level.var_ABB["american"][0].count = 0;
	level.var_ABB["american"][0].var_AB6 = "0";
	level.var_ABB["american"][1] = spawnstruct();
	level.var_ABB["american"][1].count = 0;
	level.var_ABB["american"][1].var_AB6 = "1";
	level.var_ABB["american"][2] = spawnstruct();
	level.var_ABB["american"][2].count = 0;
	level.var_ABB["american"][2].var_AB6 = "2";
	level.var_ABB["seal"] = [];
	level.var_ABB["seal"][0] = spawnstruct();
	level.var_ABB["seal"][0].count = 0;
	level.var_ABB["seal"][0].var_AB6 = "0";
	level.var_ABB["seal"][1] = spawnstruct();
	level.var_ABB["seal"][1].count = 0;
	level.var_ABB["seal"][1].var_AB6 = "1";
	level.var_ABB["seal"][2] = spawnstruct();
	level.var_ABB["seal"][2].count = 0;
	level.var_ABB["seal"][2].var_AB6 = "2";
	level.var_ABB["seal"][3] = spawnstruct();
	level.var_ABB["seal"][3].count = 0;
	level.var_ABB["seal"][3].var_AB6 = "3";
	level.var_ABB["taskforce"] = [];
	level.var_ABB["taskforce"][0] = spawnstruct();
	level.var_ABB["taskforce"][0].count = 0;
	level.var_ABB["taskforce"][0].var_AB6 = "0";
	level.var_ABB["secretservice"] = [];
	level.var_ABB["secretservice"][0] = spawnstruct();
	level.var_ABB["secretservice"][0].count = 0;
	level.var_ABB["secretservice"][0].var_AB6 = "0";
	level.var_ABB["secretservice"][1] = spawnstruct();
	level.var_ABB["secretservice"][1].count = 0;
	level.var_ABB["secretservice"][1].var_AB6 = "1";
	level.var_ABB["secretservice"][2] = spawnstruct();
	level.var_ABB["secretservice"][2].count = 0;
	level.var_ABB["secretservice"][2].var_AB6 = "2";
	level.var_ABB["secretservice"][3] = spawnstruct();
	level.var_ABB["secretservice"][3].count = 0;
	level.var_ABB["secretservice"][3].var_AB6 = "3";
	level.var_ABB["arab"] = [];
	level.var_ABB["arab"][0] = spawnstruct();
	level.var_ABB["arab"][0].count = 0;
	level.var_ABB["arab"][0].var_AB6 = "0";
	level.var_ABB["arab"][1] = spawnstruct();
	level.var_ABB["arab"][1].count = 0;
	level.var_ABB["arab"][1].var_AB6 = "1";
	level.var_ABB["arab"][2] = spawnstruct();
	level.var_ABB["arab"][2].count = 0;
	level.var_ABB["arab"][2].var_AB6 = "2";
	level.var_ABB["delta"] = [];
	level.var_ABB["delta"][0] = spawnstruct();
	level.var_ABB["delta"][0].count = 0;
	level.var_ABB["delta"][0].var_AB6 = "0";
	level.var_ABB["delta"][1] = spawnstruct();
	level.var_ABB["delta"][1].count = 0;
	level.var_ABB["delta"][1].var_AB6 = "1";
	level.var_ABB["delta"][2] = spawnstruct();
	level.var_ABB["delta"][2].count = 0;
	level.var_ABB["delta"][2].var_AB6 = "2";
	level.var_ABB["french"] = [];
	level.var_ABB["french"][0] = spawnstruct();
	level.var_ABB["french"][0].count = 0;
	level.var_ABB["french"][0].var_AB6 = "0";
	level.var_ABB["african"] = [];
	level.var_ABB["african"][0] = spawnstruct();
	level.var_ABB["african"][0].count = 0;
	level.var_ABB["african"][0].var_AB6 = "0";
	level.var_ABB["african"][1] = spawnstruct();
	level.var_ABB["african"][1].count = 0;
	level.var_ABB["african"][1].var_AB6 = "1";
	level.var_ABB["african"][2] = spawnstruct();
	level.var_ABB["african"][2].count = 0;
	level.var_ABB["african"][2].var_AB6 = "2";
	level.var_ABB["czech"] = [];
	level.var_ABB["czech"][0] = spawnstruct();
	level.var_ABB["czech"][0].count = 0;
	level.var_ABB["czech"][0].var_AB6 = "0";
	level.var_ABB["czech"][1] = spawnstruct();
	level.var_ABB["czech"][1].count = 0;
	level.var_ABB["czech"][1].var_AB6 = "1";
	level.var_ABB["czech"][2] = spawnstruct();
	level.var_ABB["czech"][2].count = 0;
	level.var_ABB["czech"][2].var_AB6 = "2";
	level.var_ABB["pmc"] = [];
	level.var_ABB["pmc"][0] = spawnstruct();
	level.var_ABB["pmc"][0].count = 0;
	level.var_ABB["pmc"][0].var_AB6 = "0";
	level.var_ABB["pmc"][1] = spawnstruct();
	level.var_ABB["pmc"][1].count = 0;
	level.var_ABB["pmc"][1].var_AB6 = "1";
	level.var_ABB["pmc"][2] = spawnstruct();
	level.var_ABB["pmc"][2].count = 0;
	level.var_ABB["pmc"][2].var_AB6 = "2";
	func_0B90();
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
		level.var_B6F["threat"]["self"] = 20000;
		level.var_B6F["threat"]["squad"] = 30000;
	}
	else
	{
		level.var_B6F["threat"]["self"] = 12500;
		level.var_B6F["threat"]["squad"] = 7500;
	}

	level.var_B6F["threat"]["location_repeat"] = 5000;
	level.var_B6F["response"]["self"] = 1000;
	level.var_B6F["response"]["squad"] = 1000;
	level.var_B6F["reaction"]["self"] = 1000;
	level.var_B6F["reaction"]["squad"] = 1000;
	level.var_B6F["order"]["self"] = 8000;
	level.var_B6F["order"]["squad"] = 10000;
	level.var_B6F["inform"]["self"] = 6000;
	level.var_B6F["inform"]["squad"] = 8000;
	level.var_B6F["custom"]["self"] = 0;
	level.var_B6F["custom"]["squad"] = 0;
	level.eventtypeminwait["playername"] = -15536;
	level.eventtypeminwait["reaction"]["casualty"] = 14000;
	level.eventtypeminwait["reaction"]["friendlyfire"] = 5000;
	level.eventtypeminwait["reaction"]["taunt"] = 30000;
	level.eventtypeminwait["inform"]["reloading"] = 20000;
	level.eventtypeminwait["inform"]["killfirm"] = 15000;
	level.var_B70["threat"]["infantry"] = 0.5;
	level.var_B70["threat"]["vehicle"] = 0.7;
	level.var_B70["response"]["ack"] = 0.9;
	level.var_B70["response"]["exposed"] = 0.8;
	level.var_B70["response"]["callout"] = 0.9;
	level.var_B70["response"]["echo"] = 0.9;
	level.var_B70["reaction"]["casualty"] = 0.5;
	level.var_B70["reaction"]["friendlyfire"] = 1;
	level.var_B70["reaction"]["taunt"] = 0.9;
	level.var_B70["order"]["action"] = 0.3;
	level.var_B70["order"]["move"] = 0.3;
	level.var_B70["order"]["displace"] = 0.5;
	level.var_B70["inform"]["attack"] = 0.9;
	level.var_B70["inform"]["incoming"] = 0.9;
	level.var_B70["inform"]["reloading"] = 0.2;
	level.var_B70["inform"]["suppressed"] = 0.2;
	level.var_B70["inform"]["killfirm"] = 0.7;
	level.var_B70["custom"]["generic"] = 1;
	level.var_B71["threat"]["infantry"] = 1000;
	level.var_B71["threat"]["vehicle"] = 1000;
	level.var_B71["response"]["exposed"] = 2000;
	level.var_B71["response"]["callout"] = 2000;
	level.var_B71["response"]["echo"] = 2000;
	level.var_B71["response"]["ack"] = 1750;
	level.var_B71["reaction"]["casualty"] = 2000;
	level.var_B71["reaction"]["friendlyfire"] = 1000;
	level.var_B71["reaction"]["taunt"] = 2000;
	level.var_B71["order"]["action"] = 3000;
	level.var_B71["order"]["move"] = 3000;
	level.var_B71["order"]["displace"] = 3000;
	level.var_B71["inform"]["attack"] = 1000;
	level.var_B71["inform"]["incoming"] = 1500;
	level.var_B71["inform"]["reloading"] = 1000;
	level.var_B71["inform"]["suppressed"] = 2000;
	level.var_B71["inform"]["killfirm"] = 2000;
	level.var_B71["custom"]["generic"] = 1000;
	level.var_B2D["response"]["exposed"] = 75;
	level.var_B2D["response"]["reload"] = 65;
	level.var_B2D["response"]["callout"] = 75;
	level.var_B2D["response"]["callout_negative"] = 20;
	level.var_B2D["response"]["order"] = 40;
	level.var_B2D["moveEvent"]["coverme"] = 70;
	level.var_B2D["moveEvent"]["ordertoplayer"] = 10;
	anim.var_B72 = 620;
	anim.var_B73 = 12;
	anim.var_B74 = 24;
	anim.var_B75 = 2;
	anim.var_B76 = 5;
	anim.var_B77 = spawn("script_origin",(0,0,0));
	if(!isdefined(level.var_B78))
	{
		level.var_B78 = 1500;
	}

	if(!isdefined(level.var_B1D))
	{
		level.var_B1D = 2500;
	}

	level.var_B79 = 96;
	level.var_B7A = 8;
	level.var_B7B = 45;
	maps\_bcs_location_trigs::bcs_location_trigs_init();
	anim.var_B7C = [];
	anim.var_B7D = 4000;
	anim.var_B7E = 3000;
	level.var_A60[level.var_A60.size] = ::func_0AAC;
	level.var_A61[level.var_A61.size] = "::init_squadBattleChatter";
	foreach(var_01 in level.teams)
	{
		level.isteamspeaking[var_01] = 0;
		level.var_B81[var_01]["threat"] = 0;
		level.var_B81[var_01]["order"] = 0;
		level.var_B81[var_01]["reaction"] = 0;
		level.var_B81[var_01]["response"] = 0;
		level.var_B81[var_01]["inform"] = 0;
		level.var_B81[var_01]["custom"] = 0;
	}

	func_0B8D();
	if(!isdefined(level.var_B82))
	{
		anim.var_B82 = [];
		level.var_B82["american"] = 1;
		level.var_B82["delta"] = 0;
		level.var_B82["french"] = 0;
		level.var_B82["czech"] = 0;
		level.var_B82["pmc"] = 0;
		level.var_B82["african"] = 0;
		level.var_B82["shadowcompany"] = 1;
		level.var_B82["seal"] = 0;
		level.var_B82["taskforce"] = 0;
		level.var_B82["secretservice"] = 0;
		level.var_B82["british"] = 0;
	}

	func_0B8F();
	anim.lastteamspeaktime = [];
	anim.var_B84 = [];
	anim.var_B85 = [];
	foreach(var_01 in level.teams)
	{
		level.lastteamspeaktime[var_01] = --15536;
		level.var_B84[var_01] = "none";
		level.var_B85[var_01] = -100000;
	}

	anim.var_B86 = 120000;
	for(var_05 = 0;var_05 < level.var_A63.size;var_05++)
	{
		if(isdefined(level.var_A63[var_05].chatinitialized) && level.var_A63[var_05].chatinitialized)
		{
			continue;
		}

		level.var_A63[var_05] func_0AAC();
	}

	anim.var_B87 = [];
	level.var_B87["rpg"] = 100;
	level.var_B87["exposed"] = 25;
	level.var_B87["player_distance"] = 25;
	level.var_B87["player_obvious"] = 25;
	level.var_B87["player_contact_clock"] = 25;
	level.var_B87["player_target_clock"] = 25;
	level.var_B87["player_target_clock_high"] = 25;
	level.var_B87["player_cardinal"] = 20;
	level.var_B87["ai_distance"] = 25;
	level.var_B87["ai_obvious"] = 25;
	level.var_B87["ai_contact_clock"] = 20;
	level.var_B87["ai_target_clock"] = 20;
	level.var_B87["ai_target_clock_high"] = 75;
	level.var_B87["ai_cardinal"] = 10;
	level.var_B87["player_location"] = 95;
	level.var_B87["ai_location"] = 100;
	level.var_B87["generic_location"] = 90;
	anim.var_B88 = [];
	anim.var_B89 = [];
	foreach(var_01 in level.teams)
	{
		level.var_B88[var_01] = undefined;
		level.var_B89[var_01] = undefined;
	}

	anim.var_B8A = 120000;
	level notify("battlechatter initialized");
	anim notify("battlechatter initialized");
}

//Function Number: 2
func_0B8B()
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
func_0B8C()
{
	if(!isdefined(level.countryids))
	{
		level.countryids["british"] = "UK";
		level.countryids["american"] = "US";
		level.countryids["seal"] = "NS";
		level.countryids["taskforce"] = "TF";
		level.countryids["secretservice"] = "SS";
		level.countryids["russian"] = "RU";
		level.countryids["arab"] = "AB";
		level.countryids["portuguese"] = "PG";
		level.countryids["shadowcompany"] = "SC";
		level.countryids["delta"] = "DF";
		level.countryids["french"] = "FR";
		level.countryids["african"] = "AF";
		level.countryids["czech"] = "CZ";
		level.countryids["pmc"] = "PC";
	}
}

//Function Number: 4
func_0B8D()
{
	func_0B8B();
	if(!isdefined(level.battlechatter))
	{
		level.battlechatter = [];
		foreach(var_01 in level.teams)
		{
			maps\_utility::set_battlechatter_variable(var_01,1);
		}
	}
}

//Function Number: 5
func_0B8F()
{
	func_0B8B();
	if(!isdefined(level.flavorbursts))
	{
		level.flavorbursts = [];
		foreach(var_01 in level.teams)
		{
			level.flavorbursts[var_01] = 1;
		}
	}
}

//Function Number: 6
func_0B90()
{
	level.flavorbursts["american"] = [];
	var_00 = 41;
	var_01 = [];
	if(level.script == "roadkill" || level.script == "trainer")
	{
	}

	var_02 = 0;
	while(var_02 < var_01)
	{
		if(var_7B.size)
		{
			var_03 = 0;
			foreach(var_05 in var_7B)
			{
				if(var_05 == var_02)
				{
					var_03 = 1;
					break;
				}
			}

			if(var_03)
			{
				continue;
			}
		}

		level.flavorbursts["american"][var_02] = maps\_utility::string(var_02 + 1);
		var_02++ = var_7B[var_7B.size];
	}

	level.flavorbursts["shadowcompany"] = [];
	var_01 = 9;
	for(var_02 = 1;var_02 <= var_01;var_02++ = 38)
	{
		level.flavorbursts["shadowcompany"][var_02] = maps\_utility::string(var_02 + 1);
	}

	anim.var_B92 = [];
}

//Function Number: 7
func_0B93()
{
	anim.countryids = undefined;
	anim.eventtypeminwait = undefined;
	anim.var_B6F = undefined;
	anim.eventtypeminwait = undefined;
	anim.var_B70 = undefined;
	anim.var_B71 = undefined;
	anim.var_B77 = undefined;
	anim.var_B7D = undefined;
	anim.var_B7E = undefined;
	anim.var_B7C = undefined;
	anim.var_ABB = undefined;
	anim.var_B92 = undefined;
	anim.var_B88 = undefined;
	anim.var_B89 = undefined;
	anim.var_B86 = undefined;
	anim.var_B84 = undefined;
	anim.var_B85 = undefined;
	anim.chatinitialized = 0;
	level.player.chatinitialized = 0;
	level.battlechatter = undefined;
	for(var_00 = 0;var_00 < level.var_A60.size;var_00++)
	{
		if(level.var_A61[var_00] != "::init_squadBattleChatter")
		{
			continue;
		}

		if(var_00 != level.var_A60.size - 1)
		{
			level.var_A60[var_00] = level.var_A60[level.var_A60.size - 1];
			level.var_A61[var_00] = level.var_A61[level.var_A61.size - 1];
		}

		level.var_A60[level.var_A60.size - 1] = undefined;
		level.var_A61[level.var_A61.size - 1] = undefined;
	}

	level notify("battlechatter disabled");
	anim notify("battlechatter disabled");
}

//Function Number: 8
func_0AAC()
{
	var_00 = self;
	var_00.var_B94 = 0;
	var_00.var_B95 = 1;
	var_00.var_AC7 = gettime() + 50;
	var_00.var_AC8["threat"] = gettime() + 50;
	var_00.var_AC8["order"] = gettime() + 50;
	var_00.var_AC8["reaction"] = gettime() + 50;
	var_00.var_AC8["response"] = gettime() + 50;
	var_00.var_AC8["inform"] = gettime() + 50;
	var_00.var_AC8["custom"] = gettime() + 50;
	var_00.var_B96["threat"] = [];
	var_00.var_B96["order"] = [];
	var_00.var_B96["reaction"] = [];
	var_00.var_B96["response"] = [];
	var_00.var_B96["inform"] = [];
	var_00.var_B96["custom"] = [];
	var_00.var_B97["threat"] = 0;
	var_00.var_B97["order"] = 0;
	var_00.var_B97["reaction"] = 0;
	var_00.var_B97["response"] = 0;
	var_00.var_B97["inform"] = 0;
	var_00.var_B97["custom"] = 0;
	var_00.var_B98 = "";
	var_00.var_A6F[var_00.var_A6F.size] = ::animscripts/battlechatter_ai::func_AA9;
	var_00.var_A70[var_00.var_A70.size] = "::addToSystem";
	var_00.var_A71[var_00.var_A71.size] = ::animscripts/battlechatter_ai::func_AC5;
	var_00.var_A72[var_00.var_A72.size] = "::removeFromSystem";
	var_00.var_A73[var_00.var_A73.size] = ::func_0C1E;
	var_00.var_A74[var_00.var_A74.size] = "::initContact";
	var_00.var_B99 = 1;
	var_00.var_B9A = undefined;
	for(var_01 = 0;var_01 < level.var_A63.size;var_01++)
	{
		var_00 thread func_0C1E(level.var_A63[var_01].var_A66);
	}

	var_00 thread animscripts/battlechatter_ai::func_B1F();
	var_00 thread animscripts/battlechatter_ai::func_AE8();
	var_00 thread func_0C22();
	var_00.chatinitialized = 1;
	var_00 notify("squad chat initialized");
}

//Function Number: 9
func_0B9B()
{
	var_00 = self;
	var_00.var_B94 = undefined;
	var_00.var_B95 = undefined;
	var_00.var_AC7 = undefined;
	var_00.var_AC8 = undefined;
	var_00.var_B96 = undefined;
	var_00.var_B97 = undefined;
	var_00.var_B99 = undefined;
	var_00.var_B9A = undefined;
	for(var_01 = 0;var_01 < var_00.var_A6F.size;var_01++)
	{
		if(var_00.var_A70[var_01] != "::addToSystem")
		{
			continue;
		}

		if(var_01 != var_00.var_A6F.size - 1)
		{
			var_00.var_A6F[var_01] = var_00.var_A6F[var_00.var_A6F.size - 1];
			var_00.var_A70[var_01] = var_00.var_A70[var_00.var_A70.size - 1];
		}

		var_00.var_A6F[var_00.var_A6F.size - 1] = undefined;
		var_00.var_A70[var_00.var_A70.size - 1] = undefined;
	}

	for(var_01 = 0;var_01 < var_00.var_A71.size;var_01++)
	{
		if(var_00.var_A72[var_01] != "::removeFromSystem")
		{
			continue;
		}

		if(var_01 != var_00.var_A71.size - 1)
		{
			var_00.var_A71[var_01] = var_00.var_A71[var_00.var_A71.size - 1];
			var_00.var_A72[var_01] = var_00.var_A72[var_00.var_A72.size - 1];
		}

		var_00.var_A71[var_00.var_A71.size - 1] = undefined;
		var_00.var_A72[var_00.var_A72.size - 1] = undefined;
	}

	for(var_01 = 0;var_01 < var_00.var_A73.size;var_01++)
	{
		if(var_00.var_A74[var_01] != "::initContact")
		{
			continue;
		}

		if(var_01 != var_00.var_A73.size - 1)
		{
			var_00.var_A73[var_01] = var_00.var_A73[var_00.var_A73.size - 1];
			var_00.var_A74[var_01] = var_00.var_A74[var_00.var_A74.size - 1];
		}

		var_00.var_A73[var_00.var_A73.size - 1] = undefined;
		var_00.var_A74[var_00.var_A74.size - 1] = undefined;
	}

	for(var_01 = 0;var_01 < level.var_A63.size;var_01++)
	{
		var_00 func_0C1F(level.var_A63[var_01].var_A66);
	}

	var_00.chatinitialized = 0;
}

//Function Number: 10
func_0AAA()
{
	return level.chatinitialized;
}

//Function Number: 11
func_0B9C()
{
	var_00 = getdvar("bcs_enable","on");
	for(;;)
	{
		var_01 = getdvar("bcs_enable","on");
		if(var_01 != var_00)
		{
			switch(var_01)
			{
				case "on":
					if(!level.chatinitialized)
					{
						func_0B9D();
					}
					break;
	
				case "off":
					if(level.chatinitialized)
					{
						func_0B9E();
					}
					break;
			}

			var_00 = var_01;
		}

		wait 1;
	}
}

//Function Number: 12
func_0B9D()
{
	func_0B6B();
	level.player thread animscripts/battlechatter_ai::func_AA9();
	var_00 = getaiarray();
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] animscripts/battlechatter_ai::func_AA9();
	}
}

//Function Number: 13
func_0B9E()
{
	func_0B93();
	var_00 = getaiarray();
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(isdefined(var_00[var_01].var_A7A) && var_00[var_01].var_A7A.chatinitialized)
		{
			var_00[var_01].var_A7A func_0B9B();
		}

		var_00[var_01] animscripts/battlechatter_ai::func_AC5();
	}
}

//Function Number: 14
func_0B9F(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_01))
	{
		level.player.var_BA0 = param_00;
		level.player.var_BA1 = param_01;
		return;
	}

	while(!isdefined(level.campaign))
	{
		wait 0.1;
	}

	var_02 = level.campaign;
	var_03 = level.var_AD0[var_02];
	var_04 = level.countryids[var_02];
	if(isdefined(var_03))
	{
		level.player.var_BA0 = var_03;
	}

	if(isdefined(var_04))
	{
		level.player.var_BA1 = var_04;
	}
}

//Function Number: 15
func_0ABF()
{
	if(!isalive(self))
	{
		return;
	}

	if(!func_0AAA())
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
		if(level.scripteddialoguestarttime + level.var_B7D > gettime())
		{
			return;
		}
	}

	if(func_0C37())
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
	var_00 = func_0BE2();
	if(!isdefined(var_00))
	{
		return;
	}

	switch(var_00)
	{
		case "custom":
			thread func_0BD7();
			break;

		case "response":
			thread func_0BC9();
			break;

		case "order":
			thread func_0BCD();
			break;

		case "threat":
			thread func_0BA5();
			break;

		case "reaction":
			thread func_0BC5();
			break;

		case "inform":
			thread func_0BD1();
			break;
	}
}

//Function Number: 16
func_0BA5()
{
	self endon("death");
	self endon("removed from battleChatter");
	self endon("cancel speaking");
	self.var_BA6 = self.var_AC6["threat"];
	var_00 = self.var_AC6["threat"].var_AD9;
	if(!isalive(var_00))
	{
		return;
	}

	if(func_0AD7(var_00) && !isplayer(var_00))
	{
		return;
	}

	anim thread func_0BDF(self,"threat");
	var_01 = 0;
	switch(self.var_AC6["threat"].var_BA7)
	{
		case "infantry":
			if(isplayer(var_00) || !isdefined(var_00 getturret()))
			{
				var_01 = func_0BAA(var_00);
			}
			else
			{
			}
			break;

		case "dog":
			var_01 = func_0BC1(var_00);
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

	var_00.var_AAE[self.var_A7A.var_A66] = spawnstruct();
	var_00.var_AAE[self.var_A7A.var_A66].var_BA8 = self;
	var_00.var_AAE[self.var_A7A.var_A66].var_BA9 = self.var_AC6["threat"].var_BA7;
	var_00.var_AAE[self.var_A7A.var_A66].var_ACB = gettime() + level.var_B7E;
	if(isdefined(var_00.var_A7A))
	{
		self.var_A7A.var_A6E[var_00.var_A7A.var_A66].var_AAE = 1;
	}
}

//Function Number: 17
func_0AD7(param_00)
{
	if(isdefined(param_00.var_AAE) && isdefined(param_00.var_AAE[self.var_A7A.var_A66]))
	{
		if(param_00.var_AAE[self.var_A7A.var_A66].var_ACB < gettime())
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 18
func_0BAA(param_00,param_01)
{
	self endon("cancel speaking");
	var_02 = func_0B45();
	var_02.var_BAB = 1;
	var_02.var_BAC = param_00;
	var_03 = func_0BB4(param_00);
	if(!isdefined(var_03) || isdefined(var_03) && !isdefined(var_03.type))
	{
		return 0;
	}

	switch(var_03.type)
	{
		case "rpg":
			var_02 func_0BC4(param_00);
			break;

		case "exposed":
			var_04 = func_0BB1(var_03.var_BAD);
			if(var_04 && func_0C08(var_03.var_BAD))
			{
				var_02 func_0B4D(var_03.var_BAD.var_AC2);
				var_02.looktarget = var_03.var_BAD;
			}
	
			var_02 func_0BC2(param_00);
			if(var_04)
			{
				if(randomint(100) < level.var_B2D["response"]["callout_negative"])
				{
					var_03.var_BAD animscripts/battlechatter_ai::func_ADB("callout","neg",self,0.9);
				}
				else
				{
					var_03.var_BAD animscripts/battlechatter_ai::func_ADB("exposed","acquired",self,0.9);
				}
			}
			break;

		case "player_obvious":
			var_02 func_0C05();
			var_02 func_0C0E();
			break;

		case "player_distance":
			var_05 = func_0BFF(level.player.origin,param_00.origin);
			var_02 func_0C05();
			var_02 func_0C0F(var_05);
			break;

		case "player_contact_clock":
			var_02 func_0C05();
			var_02 func_0C15("contactclock",var_03.var_BAF);
			break;

		case "player_target_clock":
			var_02 func_0C05();
			var_02 func_0C15("targetclock",var_03.var_BAF);
			break;

		case "player_target_clock_high":
			var_02 func_0C05();
			var_06 = func_0C02(level.player.origin,param_00.origin);
			if(var_06 >= 20 && var_06 <= 50)
			{
				var_02 func_0C15("targetclock",var_03.var_BAF);
				var_02 func_0C10(var_06);
			}
			else
			{
				var_02 func_0C15("targetclock",var_03.var_BAF + "_high");
			}
			break;

		case "player_cardinal":
			var_02 func_0C05();
			var_07 = func_0BFD(level.player.origin,param_00.origin);
			var_08 = func_0BFC(var_07);
			if(var_08 == "impossible")
			{
				return 0;
			}
	
			var_02 func_0C15("cardinal",var_08);
			break;

		case "ai_obvious":
			if(isdefined(var_03.var_BAD) && func_0C08(var_03.var_BAD))
			{
				var_02 func_0B4D(var_03.var_BAD.var_AC2);
				var_02.looktarget = var_03.var_BAD;
			}
	
			var_02 func_0C0E();
			var_02 func_0BB3(self,var_03,param_00);
			break;

		case "ai_distance":
			var_09 = self;
			if(self.team == "allies")
			{
				var_09 = level.player;
			}
			else if(isdefined(var_03.var_BAD) && randomint(100) < level.var_B2D["response"]["callout"])
			{
				var_09 = var_03.var_BAD;
			}
	
			var_05 = func_0BFF(var_09.origin,param_00.origin);
			var_02 func_0C0F(var_05);
			var_02 func_0BB3(self,var_03,param_00);
			break;

		case "ai_contact_clock":
			var_09 = self;
			if(self.team == "allies")
			{
				var_09 = level.player;
			}
			else if(isdefined(var_03.var_BAD) && randomint(100) < level.var_B2D["response"]["callout"])
			{
				var_09 = var_03.var_BAD;
			}
	
			var_0A = func_0BF9(var_09);
			var_0B = func_0C01(var_0A,var_09.origin,param_00.origin);
			var_02 func_0C15("contactclock",var_0B);
			var_02 func_0BB3(self,var_03,param_00);
			break;

		case "ai_target_clock":
			var_09 = self;
			if(self.team == "allies")
			{
				var_09 = level.player;
			}
			else if(isdefined(var_03.var_BAD) && randomint(100) < level.var_B2D["response"]["callout"])
			{
				var_09 = var_03.var_BAD;
			}
	
			var_0A = func_0BF9(var_09);
			var_0B = func_0C01(var_0A,var_09.origin,param_00.origin);
			var_02 func_0C15("targetclock",var_0B);
			var_02 func_0BB3(self,var_03,param_00);
			break;

		case "ai_target_clock_high":
			var_09 = self;
			if(self.team == "allies")
			{
				var_09 = level.player;
			}
			else if(isdefined(var_03.var_BAD) && randomint(100) < level.var_B2D["response"]["callout"])
			{
				var_09 = var_03.var_BAD;
			}
	
			var_0A = func_0BF9(var_09);
			var_0B = func_0C01(var_0A,var_09.origin,param_00.origin);
			var_06 = func_0C02(var_09.origin,param_00.origin);
			if(var_06 >= 20 && var_06 <= 50)
			{
				var_02 func_0C15("targetclock",var_0B);
				var_02 func_0C10(var_06);
			}
			else
			{
				var_02 func_0C15("targetclock",var_0B + "_high");
			}
	
			var_02 func_0BB3(self,var_03,param_00);
			break;

		case "ai_cardinal":
			var_09 = self;
			if(self.team == "allies")
			{
				var_09 = level.player;
			}
	
			var_07 = func_0BFD(var_09.origin,param_00.origin);
			var_08 = func_0BFC(var_07);
			if(var_08 == "impossible")
			{
				return 0;
			}
	
			var_02 func_0C15("cardinal",var_08);
			break;

		case "generic_location":
			var_0C = var_02 func_0BB2(var_03);
			if(!var_0C)
			{
				return 0;
			}
			break;

		case "player_location":
			var_02 func_0C05();
			var_0C = var_02 func_0BB2(var_03);
			if(!var_0C)
			{
				return 0;
			}
			break;

		case "ai_location":
			if(func_0C08(var_03.var_BAD))
			{
				var_02 func_0B4D(var_03.var_BAD.var_AC2);
				var_02.looktarget = var_03.var_BAD;
			}
	
			var_0C = var_02 func_0BB2(var_03);
			if(!var_0C)
			{
				return 0;
			}
	
			var_0D = var_02.var_BB0.size - 1;
			var_0E = var_02.var_BB0[var_0D];
			if(func_0BBA(var_0E))
			{
				var_03.var_BAD animscripts/battlechatter_ai::func_ADB("callout","echo",self,0.9,var_0E);
			}
			else if(func_0BBB(var_0E,self))
			{
				var_03.var_BAD animscripts/battlechatter_ai::func_ADB("callout","QA",self,0.9,var_0E,var_03.location);
			}
			else if(randomint(100) < level.var_B2D["response"]["callout_negative"])
			{
				var_03.var_BAD animscripts/battlechatter_ai::func_ADB("callout","neg",self,0.9);
			}
			else
			{
				var_03.var_BAD animscripts/battlechatter_ai::func_ADB("exposed","acquired",self,0.9);
			}
			break;
	}

	func_0BBF(var_03.type);
	func_0BD9(var_02);
	return 1;
}

//Function Number: 19
func_0BB1(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00.var_AB4 != "US" && param_00.var_AB4 != "NS" && param_00.var_AB4 != "TF")
	{
		return 0;
	}

	if(randomint(100) > level.var_B2D["response"]["exposed"])
	{
		return 0;
	}

	return 1;
}

//Function Number: 20
func_0BB2(param_00)
{
	var_01 = func_0C18(param_00.location);
	return var_01;
}

//Function Number: 21
func_0BB3(param_00,param_01,param_02)
{
	if(!isdefined(param_01.var_BAD))
	{
		return;
	}

	if(randomint(100) > level.var_B2D["response"]["callout"])
	{
		return;
	}

	var_03 = "affirm";
	if(!param_01.var_BAD cansee(param_02) && randomint(100) < level.var_B2D["response"]["callout_negative"])
	{
		var_03 = "neg";
	}

	param_01.var_BAD animscripts/battlechatter_ai::func_ADB("callout",var_03,param_00,0.9);
}

//Function Number: 22
func_0BB4(param_00)
{
	var_01 = param_00 func_0AED();
	var_02 = func_0C01(self.angles,self.origin,param_00.origin);
	var_03 = func_0B2C(64,1024,"response");
	var_04 = undefined;
	if(isdefined(var_03))
	{
		var_04 = func_0C01(var_03.angles,var_03.origin,param_00.origin);
	}

	var_05 = func_0C01(level.player.angles,level.player.origin,param_00.origin);
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

	var_08 = func_0BFE(var_07.origin,param_00.origin);
	self.var_BB5 = [];
	if(!isplayer(param_00) && param_00 animscripts/utility::func_BB6())
	{
		func_0BBD("rpg");
	}

	if(param_00 func_0AA8())
	{
		func_0BBD("exposed");
	}

	if(self.team == "allies")
	{
		var_09 = 0;
		if(param_00.origin[2] - var_07.origin[2] >= level.var_B79)
		{
			if(func_0BBD("player_target_clock_high"))
			{
				var_09 = 1;
			}
		}

		if(!var_09)
		{
			if(var_06 == "12")
			{
				func_0BBD("player_obvious");
				if(var_08 > level.var_B7A && var_08 < level.var_B7B)
				{
					func_0BBD("player_distance");
				}
			}

			if(func_0C0A() && var_06 != "12")
			{
				func_0BBD("player_contact_clock");
				func_0BBD("player_target_clock");
				func_0BBD("player_cardinal");
			}
		}
	}

	var_09 = 0;
	if(param_00.origin[2] - var_07.origin[2] >= level.var_B79)
	{
		if(func_0BBD("ai_target_clock_high"))
		{
			var_09 = 1;
		}
	}

	if(!var_09)
	{
		if(var_06 == "12")
		{
			func_0BBD("ai_distance");
			if(var_08 > level.var_B7A && var_08 < level.var_B7B)
			{
				func_0BBD("ai_obvious");
			}
		}

		func_0BBD("ai_contact_clock");
		func_0BBD("ai_target_clock");
		func_0BBD("ai_cardinal");
	}

	if(isdefined(var_01))
	{
		var_0A = var_01 func_0BB8(self);
		if(isdefined(var_0A))
		{
			if(isdefined(var_03))
			{
				func_0BBD("ai_location");
			}
			else
			{
				if(func_0C0A())
				{
					func_0BBD("player_location");
				}

				func_0BBD("generic_location");
			}
		}
		else
		{
			if(isdefined(var_03))
			{
				func_0BBD("ai_location");
			}

			if(func_0C0A())
			{
				func_0BBD("player_location");
			}

			func_0BBD("generic_location");
		}
	}

	if(!self.var_BB5.size)
	{
		return undefined;
	}

	var_0C = getweightedchanceroll(self.var_BB5,level.var_B87);
	var_0D = spawnstruct();
	var_0D.type = var_0C;
	var_0D.var_BAD = var_03;
	var_0D.var_BB7 = var_04;
	var_0D.var_BAF = var_05;
	if(isdefined(var_01))
	{
		var_0D.location = var_01;
	}

	return var_0D;
}

//Function Number: 23
func_0BB8(param_00)
{
	var_01 = undefined;
	var_02 = self.locationaliases;
	foreach(var_04 in var_02)
	{
		if(func_0BBB(var_04,param_00) && !isdefined(self.var_BB9))
		{
			var_01 = var_04;
			break;
		}

		if(func_0BBA(var_04))
		{
			var_01 = var_04;
		}
	}

	return var_01;
}

//Function Number: 24
func_0BBA(param_00)
{
	return issubstr(param_00,"_report");
}

//Function Number: 25
func_0BBB(param_00,param_01)
{
	if(issubstr(param_00,"_qa") && soundexists(param_00))
	{
		return 1;
	}

	var_02 = param_01 func_0BBC(param_00,0);
	if(soundexists(var_02))
	{
		return 1;
	}

	return 0;
}

//Function Number: 26
func_0BBC(param_00,param_01)
{
	var_02 = self.var_AB4 + "_" + self.var_AB6 + "_co_";
	var_02 = var_02 + param_00;
	var_02 = var_02 + "_qa" + param_01;
	return var_02;
}

//Function Number: 27
func_0ACF(param_00)
{
	self.var_ACE[self.var_ACE.size] = param_00;
}

//Function Number: 28
func_0BBD(param_00)
{
	var_01 = 0;
	foreach(var_03 in self.var_ACE)
	{
		if(var_03 == param_00)
		{
			if(!func_0BBE(param_00))
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

	self.var_BB5[self.var_BB5.size] = param_00;
	return var_01;
}

//Function Number: 29
func_0BBE(param_00)
{
	if(!isdefined(level.var_B88[self.team]))
	{
		return 0;
	}

	if(!isdefined(level.var_B89[self.team]))
	{
		return 0;
	}

	var_01 = level.var_B88[self.team];
	var_02 = level.var_B89[self.team];
	var_03 = level.var_B8A;
	if(param_00 == var_01 && gettime() - var_02 < var_03)
	{
		return 1;
	}

	return 0;
}

//Function Number: 30
func_0BBF(param_00)
{
	level.var_B88[self.team] = param_00;
	level.var_B89[self.team] = gettime();
}

//Function Number: 31
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

//Function Number: 32
func_0BC1(param_00,param_01)
{
	self endon("cancel speaking");
	var_02 = func_0B45();
	var_02.var_BAB = 1;
	var_02.var_BAC = param_00;
	var_02 func_0C0C("dog","generic");
	func_0BD9(var_02);
	return 1;
}

//Function Number: 33
func_0BC2(param_00)
{
	var_01 = [];
	var_01 = maps\_utility::array_add(var_01,"open");
	var_01 = maps\_utility::array_add(var_01,"breaking");
	if(self.owner.team == "allies" && self.owner.var_AB4 != "RU")
	{
		var_01 = maps\_utility::array_add(var_01,"movement");
	}

	var_02 = var_01[randomint(var_01.size)];
	func_0C0D(var_02);
}

//Function Number: 34
func_0BC4(param_00)
{
	func_0C0C("rpg");
}

//Function Number: 35
func_0BC5()
{
	self endon("death");
	self endon("removed from battleChatter");
	self.var_BA6 = self.var_AC6["reaction"];
	var_00 = self.var_AC6["reaction"].var_AE5;
	var_01 = self.var_AC6["reaction"].var_AE0;
	anim thread func_0BDF(self,"reaction");
	switch(self.var_AC6["reaction"].var_BA7)
	{
		case "casualty":
			func_0BC6(var_00,var_01);
			break;

		case "taunt":
			func_0BC7(var_00,var_01);
			break;

		case "friendlyfire":
			func_0BC8(var_00,var_01);
			break;
	}

	self notify("done speaking");
}

//Function Number: 36
func_0BC6(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_02 = func_0B45();
	var_02 func_0C1A("casualty","generic");
	func_0BD9(var_02);
}

//Function Number: 37
func_0BC7(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_02 = func_0B45();
	if(isdefined(param_01) && param_01 == "hostileburst")
	{
		var_02 func_0C1D();
	}
	else
	{
		var_02 func_0C1C("taunt","generic");
	}

	func_0BD9(var_02);
}

//Function Number: 38
func_0BC8(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_02 = func_0B45();
	var_02 func_0C1B();
	func_0BD9(var_02);
}

//Function Number: 39
func_0BC9()
{
	self endon("death");
	self endon("removed from battleChatter");
	self.var_BA6 = self.var_AC6["response"];
	var_00 = self.var_AC6["response"].var_AE0;
	var_01 = self.var_AC6["response"].var_ADF;
	if(!isalive(var_01))
	{
		return;
	}

	if(self.var_AC6["response"].var_AE0 == "follow" && self.a.var_A98 != "move")
	{
		return;
	}

	anim thread func_0BDF(self,"response");
	switch(self.var_AC6["response"].var_BA7)
	{
		case "exposed":
			func_0BCA(var_01,var_00);
			break;

		case "callout":
			func_0BCB(var_01,var_00);
			break;

		case "ack":
			func_0BCC(var_01,var_00);
			break;
	}

	self notify("done speaking");
}

//Function Number: 40
func_0BCA(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!isalive(param_00))
	{
		return;
	}

	var_02 = func_0B45();
	var_02 func_0C0D(param_01);
	var_02.looktarget = param_00;
	var_02.var_BAB = 1;
	func_0BD9(var_02);
}

//Function Number: 41
func_0BCB(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!isalive(param_00))
	{
		return;
	}

	var_02 = func_0B45();
	var_03 = 0;
	if(param_01 == "echo")
	{
		var_03 = var_02 func_0C11(self.var_BA6.var_ADE,param_00);
	}
	else if(param_01 == "QA")
	{
		var_03 = var_02 func_0C13(param_00,self.var_BA6.var_ADE,self.var_BA6.location);
	}
	else
	{
		var_03 = var_02 func_0C12(param_01);
	}

	if(!var_03)
	{
		return;
	}

	var_02.looktarget = param_00;
	var_02.var_BAB = 1;
	func_0BD9(var_02);
}

//Function Number: 42
func_0BCC(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!isalive(param_00))
	{
		return;
	}

	var_02 = self.var_AC6["response"].var_BA7;
	var_03 = func_0B45();
	var_03 func_0C19(var_02,param_01);
	var_03.looktarget = param_00;
	var_03.var_BAB = 1;
	func_0BD9(var_03);
}

//Function Number: 43
func_0BCD()
{
	self endon("death");
	self endon("removed from battleChatter");
	self.var_BA6 = self.var_AC6["order"];
	var_00 = self.var_AC6["order"].var_AE0;
	var_01 = self.var_AC6["order"].var_AE7;
	anim thread func_0BDF(self,"order");
	switch(self.var_AC6["order"].var_BA7)
	{
		case "action":
			func_0BCE(var_00,var_01);
			break;

		case "move":
			func_0BCF(var_00,var_01);
			break;

		case "displace":
			func_0BD0(var_00);
			break;
	}

	self notify("done speaking");
}

//Function Number: 44
func_0BCE(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_02 = func_0B45();
	func_0B43(var_02,param_01);
	var_02 func_0B47("action",param_00);
	func_0BD9(var_02);
}

//Function Number: 45
func_0BCF(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_02 = func_0B45();
	func_0B43(var_02,param_01);
	var_02 func_0B47("move",param_00);
	func_0BD9(var_02);
}

//Function Number: 46
func_0BD0(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_01 = func_0B45();
	var_01 func_0B47("displace",param_00);
	func_0BD9(var_01,1);
}

//Function Number: 47
func_0B43(param_00,param_01)
{
	if(randomint(100) > level.var_B2D["response"]["order"])
	{
		if(!isdefined(param_01) || isdefined(param_01) && !isplayer(param_01))
		{
			return;
		}
	}

	if(isdefined(param_01) && isplayer(param_01) && isdefined(level.player.var_BA0))
	{
		param_00 func_0C05();
		param_00.looktarget = level.player;
		return;
	}

	if(isdefined(param_01) && func_0C08(param_01))
	{
		param_00 func_0B4D(param_01.var_AC2);
		param_00.looktarget = param_01;
		param_01 animscripts/battlechatter_ai::func_ADB("ack","yes",self,0.9);
		return;
	}

	level notify("follow order",self);
}

//Function Number: 48
func_0BD1()
{
	self endon("death");
	self endon("removed from battleChatter");
	self.var_BA6 = self.var_AC6["inform"];
	var_00 = self.var_AC6["inform"].var_AE0;
	anim thread func_0BDF(self,"inform");
	switch(self.var_AC6["inform"].var_BA7)
	{
		case "incoming":
			func_0BD4(var_00);
			break;

		case "attack":
			func_0BD5(var_00);
			break;

		case "reloading":
			func_0BD2(var_00);
			break;

		case "suppressed":
			func_0BD3(var_00);
			break;

		case "killfirm":
			func_0BD6(var_00);
			break;
	}

	self notify("done speaking");
}

//Function Number: 49
func_0BD2(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_01 = func_0B45();
	var_01 func_0B4B("reloading",param_00);
	func_0BD9(var_01);
}

//Function Number: 50
func_0BD3(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_01 = func_0B45();
	var_01 func_0B4B("suppressed",param_00);
	func_0BD9(var_01);
}

//Function Number: 51
func_0BD4(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_01 = func_0B45();
	if(param_00 == "grenade")
	{
		var_01.var_BAB = 1;
	}

	var_01 func_0B4B("incoming",param_00);
	func_0BD9(var_01);
}

//Function Number: 52
func_0BD5(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_01 = func_0B45();
	var_01 func_0B4B("attack",param_00);
	func_0BD9(var_01);
}

//Function Number: 53
func_0BD6(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_01 = func_0B45();
	var_01 func_0B4B("killfirm",param_00);
	func_0BD9(var_01);
}

//Function Number: 54
func_0BD7()
{
	self endon("death");
	self endon("removed from battleChatter");
	self.var_BA6 = self.var_AC6["custom"];
	anim thread func_0BDF(self,self.var_BA6.type,1);
	func_0BD9(self.var_B42);
	self notify("done speaking");
	self.var_BD8 = undefined;
	self.var_B42 = undefined;
}

//Function Number: 55
func_0BD9(param_00,param_01)
{
	anim endon("battlechatter disabled");
	self endon("death");
	if(isdefined(param_01))
	{
		return;
	}

	if(func_0C2C() || func_0C2D())
	{
		var_02 = [];
		foreach(var_04 in param_00.var_BB0)
		{
			var_02[var_02.size] = var_04;
		}

		if(func_0C2C())
		{
			func_0C2E(var_02);
		}

		if(func_0C2D())
		{
			var_06 = self.var_BA6.var_BDA + "_" + self.var_BA6.var_BA7;
			if(isdefined(self.var_BA6.var_AE0))
			{
				var_06 = var_06 + "_" + self.var_BA6.var_AE0;
			}

			thread func_0C2F(var_02,var_06);
		}
	}

	for(var_07 = 0;var_07 < param_00.var_BB0.size;var_07++)
	{
		if(!self.battlechatter)
		{
			if(!func_0BDC(self.var_BA6))
			{
			}
			else
			{
			}
			else if(!func_0C38(0))
			{
			}
			else if(self._animactive > 0)
			{
			}
			else if(func_0BE6(self.var_BA6.var_BDA))
			{
				wait 0.85;
			}
			else if(!soundexists(param_00.var_BB0[var_07]))
			{
			}
			else
			{
				var_08 = gettime();
				var_09 = spawn("script_origin",self gettagorigin("j_head"));
				var_09 linkto(self);
				if(param_00.var_BAB && self.team == "allies")
				{
					thread maps\_anim::anim_facialfiller(param_00.var_BB0[var_07],param_00.looktarget);
					var_09 playsoundasmaster(param_00.var_BB0[var_07],param_00.var_BB0[var_07],1);
					var_09 waittill(param_00.var_BB0[var_07]);
					self notify(param_00.var_BB0[var_07]);
				}
				else
				{
					thread maps\_anim::anim_facialfiller(param_00.var_BB0[var_07],param_00.looktarget);
					if(getdvarint("bcs_forceEnglish",0))
					{
						var_09 playsoundasmaster(param_00.var_BB0[var_07],param_00.var_BB0[var_07],1);
					}
					else
					{
						var_09 playsound(param_00.var_BB0[var_07],param_00.var_BB0[var_07],1);
					}

					var_09 waittill(param_00.var_BB0[var_07]);
					self notify(param_00.var_BB0[var_07]);
				}

				var_09 delete();
				if(gettime() < var_08 + 250)
				{
				}
			}
		}
	}

	self notify("playPhrase_done");
	func_0BE9(self.var_BA6.var_BDA,self.var_BA6.var_BA7);
}

//Function Number: 56
func_0BDC(param_00)
{
	if(!isdefined(param_00.var_BDA) || !isdefined(param_00.var_BA7))
	{
		return 0;
	}

	if(param_00.var_BDA == "reaction" && param_00.var_BA7 == "friendlyfire")
	{
		return 1;
	}

	return 0;
}

//Function Number: 57
func_0BDD(param_00)
{
	self endon("death");
	wait 25;
	func_0BDE(param_00);
}

//Function Number: 58
func_0BDE(param_00)
{
	self.isspeaking = 0;
	self.var_AC6[param_00].var_ACB = 0;
	self.var_AC6[param_00].priority = 0;
	self.var_AC8[param_00] = gettime() + level.var_B6F[param_00]["self"];
}

//Function Number: 59
func_0BDF(param_00,param_01,param_02)
{
	anim endon("battlechatter disabled");
	var_03 = param_00.var_A7A;
	var_04 = param_00.team;
	param_00.isspeaking = 1;
	param_00 thread func_0BDD(param_01);
	var_03.var_B97[param_01] = 1;
	var_03.var_B94++;
	level.isteamspeaking[var_04] = 1;
	level.var_B81[var_04][param_01] = 1;
	var_05 = param_00 common_scripts\utility::waittill_any_return("death","done speaking","cancel speaking");
	var_03.var_B97[param_01] = 0;
	var_03.var_B94--;
	level.isteamspeaking[var_04] = 0;
	level.var_B81[var_04][param_01] = 0;
	if(var_05 == "cancel speaking")
	{
		return;
	}

	level.lastteamspeaktime[var_04] = gettime();
	if(isalive(param_00))
	{
		param_00 func_0BDE(param_01);
	}

	var_03.var_AC8[param_01] = gettime() + level.var_B6F[param_01]["squad"];
}

//Function Number: 60
func_0ADA(param_00,param_01)
{
	if(gettime() - self.var_A6E[param_00].var_BE0 > 10000)
	{
		var_02 = 0;
		for(var_03 = 0;var_03 < self.members.size;var_03++)
		{
			if(self.members[var_03] != param_01 && isalive(self.members[var_03].enemy) && isdefined(self.members[var_03].enemy.var_A7A) && self.members[var_03].enemy.var_A7A.var_A66 == param_00)
			{
				var_02 = 1;
			}
		}

		if(!var_02)
		{
			self.var_A6E[param_00].var_BE1 = gettime();
			self.var_A6E[param_00].var_AAE = 0;
		}
	}

	self.var_A6E[param_00].var_BE0 = gettime();
}

//Function Number: 61
func_0AD6(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(isplayer(self))
	{
		return 0;
	}

	if(distance(level.player.origin,self.origin) > level.var_B78)
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

	if(gettime() + level.var_B6F[param_00]["self"] < self.var_AC8[param_00])
	{
		return 0;
	}

	if(gettime() + level.var_B6F[param_00]["squad"] < self.var_A7A.var_AC8[param_00])
	{
		return 0;
	}

	if(isdefined(param_01) && func_0BE8(param_00,param_01))
	{
		return 0;
	}

	if(isdefined(param_01) && level.var_B70[param_00][param_01] < self.var_ACD)
	{
		return 0;
	}

	return 1;
}

//Function Number: 62
func_0BE2()
{
	var_00 = undefined;
	var_01 = -999999999;
	foreach(var_04, var_03 in self.var_AC6)
	{
		if(func_0BE7(var_04))
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

//Function Number: 63
func_0BE3(param_00)
{
	var_01 = self.var_A7A;
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
		if(var_02[var_03] func_0AD6("response"))
		{
			return var_04;
		}
	}

	return maps\_utility::getclosest(self.origin,var_02);
}

//Function Number: 64
func_0BE4()
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
			if(self.var_AC6[var_00[var_03 - 1]].priority < self.var_AC6[var_00[var_03]].priority)
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
		var_06 = func_0BE5(var_00[var_02]);
		if(var_06 == " valid" && !var_05)
		{
			var_05 = 1;
			var_01[var_02] = "g " + var_00[var_02] + var_06 + " " + self.var_AC6[var_00[var_02]].priority;
			continue;
		}

		if(var_06 == " valid")
		{
			var_01[var_02] = "y " + var_00[var_02] + var_06 + " " + self.var_AC6[var_00[var_02]].priority;
			continue;
		}

		if(self.var_AC6[var_00[var_02]].var_ACB == 0)
		{
			var_01[var_02] = "b " + var_00[var_02] + var_06 + " " + self.var_AC6[var_00[var_02]].priority;
			continue;
		}

		var_01[var_02] = "r " + var_00[var_02] + var_06 + " " + self.var_AC6[var_00[var_02]].priority;
	}

	return var_01;
}

//Function Number: 65
func_0BE5(param_00)
{
	var_01 = "";
	if(self.var_A7A.var_B97[param_00])
	{
		var_01 = var_01 + " playing";
	}

	if(gettime() > self.var_AC6[param_00].var_ACB)
	{
		var_01 = var_01 + " expired";
	}

	if(gettime() < self.var_A7A.var_AC8[param_00])
	{
		var_01 = var_01 + " cantspeak";
	}

	if(var_01 == "")
	{
		var_01 = " valid";
	}

	return var_01;
}

//Function Number: 66
func_0BE6(param_00)
{
	if(getdvar("bcs_filter" + param_00,"off") == "on" || getdvar("bcs_filter" + param_00,"off") == "1")
	{
		return 1;
	}

	return 0;
}

//Function Number: 67
func_0BE7(param_00)
{
	if(!self.var_A7A.var_B97[param_00] && !level.var_B81[self.team][param_00] && gettime() < self.var_AC6[param_00].var_ACB && gettime() > self.var_A7A.var_AC8[param_00])
	{
		if(!func_0BE8(param_00,self.var_AC6[param_00].var_BA7))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 68
func_0BE8(param_00,param_01)
{
	if(!isdefined(level.eventtypeminwait[param_00][param_01]))
	{
		return 0;
	}

	if(!isdefined(self.var_A7A.var_B96[param_00][param_01]))
	{
		return 0;
	}

	if(gettime() > self.var_A7A.var_B96[param_00][param_01])
	{
		return 0;
	}

	return 1;
}

//Function Number: 69
func_0BE9(param_00,param_01)
{
	if(!isdefined(level.eventtypeminwait[param_00][param_01]))
	{
		return;
	}

	self.var_A7A.var_B96[param_00][param_01] = gettime() + level.eventtypeminwait[param_00][param_01];
}

//Function Number: 70
func_0BEA()
{
	if(isplayer(self))
	{
		return 0;
	}

	if(func_0AA8())
	{
		return 0;
	}

	return animscripts/utility::func_BEB(self.weapon);
}

//Function Number: 71
func_0AA8()
{
	if(distance(self.origin,level.player.origin) > 1500)
	{
		return 0;
	}

	if(isdefined(func_0AED()))
	{
		return 0;
	}

	var_00 = func_0BED();
	if(!isdefined(var_00))
	{
		return 1;
	}

	if(!func_0B2B())
	{
		return 0;
	}

	return 1;
}

//Function Number: 72
func_0B2B()
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

//Function Number: 73
func_0BEC(param_00)
{
	if(param_00.var_A6D > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 74
func_0A83()
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

//Function Number: 75
func_0BED()
{
	if(isplayer(self))
	{
		return self.node;
	}

	return animscripts/utility::func_BEE();
}

//Function Number: 76
func_0BEF()
{
	if(self isbadguy())
	{
		return 1;
	}

	return 0;
}

//Function Number: 77
func_0AC1()
{
	if(func_0BEF())
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

//Function Number: 78
getrank()
{
	return self.airank;
}

//Function Number: 79
func_0BF2(param_00)
{
	var_01 = func_0BF3(param_00,self.team);
	var_02 = maps\_utility::getclosest(self.origin,var_01);
	return var_02;
}

//Function Number: 80
func_0BF3(param_00,param_01)
{
	var_02 = [];
	var_03 = getaiarray(param_01);
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		if(var_03[var_04] == self)
		{
			continue;
		}

		if(!var_03[var_04] func_0AD6(param_00))
		{
			continue;
		}

		var_02[var_02.size] = var_03[var_04];
	}

	return var_02;
}

//Function Number: 81
func_0B2C(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(!isdefined(param_02))
	{
		param_02 = "response";
	}

	var_04 = maps\_utility::array_randomize(self.var_A7A.members);
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

		if(func_0ADD(var_04[var_05]))
		{
			continue;
		}

		if(!var_04[var_05] func_0AD6(param_02))
		{
			continue;
		}

		var_03 = var_04[var_05];
		if(func_0C08(var_03))
		{
			break;
		}
	}

	return var_03;
}

//Function Number: 82
func_0AED()
{
	var_00 = func_0BF4();
	var_00 = maps\_utility::array_randomize(var_00);
	if(var_00.size)
	{
		foreach(var_02 in var_00)
		{
			if(!func_0BF6(var_02))
			{
				return var_02;
			}
		}

		foreach(var_02 in var_00)
		{
			if(!func_0AEE(var_02))
			{
				return var_02;
			}
		}
	}

	return undefined;
}

//Function Number: 83
func_0BF4()
{
	var_00 = level.bcs_locations;
	var_01 = [];
	foreach(var_03 in var_00)
	{
		if(self istouching(var_03) && isdefined(var_03.locationaliases))
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 84
func_0BF5()
{
	if(isdefined(level.bcs_locations))
	{
		anim.bcs_locations = common_scripts\utility::array_removeundefined(level.bcs_locations);
	}
}

//Function Number: 85
func_0B22()
{
	var_00 = func_0BF4();
	foreach(var_02 in var_00)
	{
		if(!func_0AEE(var_02))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 86
func_0BF6(param_00)
{
	var_01 = func_0BF8(param_00);
	if(!isdefined(var_01))
	{
		return 0;
	}

	return 1;
}

//Function Number: 87
func_0AEE(param_00)
{
	var_01 = func_0BF8(param_00);
	if(!isdefined(var_01))
	{
		return 0;
	}

	var_02 = var_01 + level.var_B6F["threat"]["location_repeat"];
	if(gettime() < var_02)
	{
		return 1;
	}

	return 0;
}

//Function Number: 88
func_0BF7(param_00)
{
	level.var_B7C[param_00.classname] = gettime();
}

//Function Number: 89
func_0BF8(param_00)
{
	if(isdefined(level.var_B7C[param_00.classname]))
	{
		return level.var_B7C[param_00.classname];
	}

	return undefined;
}

//Function Number: 90
func_0BF9(param_00)
{
	var_01 = param_00.angles;
	if(!isplayer(param_00))
	{
		var_02 = param_00 func_0BED();
		if(isdefined(var_02))
		{
			var_01 = var_02.angles;
		}
	}

	return var_01;
}

//Function Number: 91
func_0BFA(param_00)
{
	if(param_00 == "left" || param_00 == "right")
	{
		return 1;
	}

	return 0;
}

//Function Number: 92
func_0BFB(param_00,param_01,param_02)
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

//Function Number: 93
func_0BFC(param_00)
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

//Function Number: 94
func_0BFD(param_00,param_01)
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

//Function Number: 95
func_0BFE(param_00,param_01)
{
	var_02 = distance2d(param_00,param_01);
	var_03 = 0.0254 * var_02;
	return var_03;
}

//Function Number: 96
func_0BFF(param_00,param_01)
{
	var_02 = func_0BFE(param_00,param_01);
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

//Function Number: 97
func_0C00(param_00)
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

//Function Number: 98
func_0C01(param_00,param_01,param_02)
{
	var_03 = anglestoforward(param_00);
	var_04 = vectornormalize(var_03);
	var_05 = vectortoangles(var_04);
	var_06 = vectortoangles(param_02 - param_01);
	var_07 = var_05[1] - var_06[1];
	var_07 = var_07 + 360;
	var_07 = int(var_07) % 360;
	if(var_07 > 345 || var_07 < 15)
	{
		var_08 = "12";
	}
	else if(var_08 < 45)
	{
		var_08 = "1";
	}
	else if(var_08 < 75)
	{
		var_08 = "2";
	}
	else if(var_08 < 105)
	{
		var_08 = "3";
	}
	else if(var_08 < 135)
	{
		var_08 = "4";
	}
	else if(var_08 < 165)
	{
		var_08 = "5";
	}
	else if(var_08 < 195)
	{
		var_08 = "6";
	}
	else if(var_08 < 225)
	{
		var_08 = "7";
	}
	else if(var_08 < 255)
	{
		var_08 = "8";
	}
	else if(var_08 < 285)
	{
		var_08 = "9";
	}
	else if(var_08 < 315)
	{
		var_08 = "10";
	}
	else
	{
		var_08 = "11";
	}

	return var_08;
}

//Function Number: 99
func_0C02(param_00,param_01)
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

//Function Number: 100
getvectorrightangle(param_00)
{
	return (param_00[1],0 - param_00[0],param_00[2]);
}

//Function Number: 101
func_0C04(param_00)
{
	var_01 = (0,0,0);
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_01 = var_01 + param_00[var_02];
	}

	return (var_01[0] / param_00.size,var_01[1] / param_00.size,var_01[2] / param_00.size);
}

//Function Number: 102
func_0B4D(param_00)
{
	self.var_BB0[self.var_BB0.size] = self.owner.var_AB4 + "_" + self.owner.var_AB6 + "_name_" + param_00;
	level.var_B84[self.owner.team] = param_00;
	level.var_B85[self.owner.team] = gettime();
}

//Function Number: 103
func_0C05()
{
	if(!self.owner func_0C0A())
	{
		return;
	}

	anim.var_C06 = gettime();
	var_00 = self.owner.var_AB4 + "_" + self.owner.var_AB6 + "_name_player_" + level.player.var_BA1 + "_" + level.player.var_BA0;
	self.var_BB0[self.var_BB0.size] = var_00;
	self.looktarget = level.player;
}

//Function Number: 104
func_0C07(param_00)
{
	self.var_BB0[self.var_BB0.size] = self.owner.var_AB4 + "_" + self.owner.var_AB6 + "_rank_" + param_00;
}

//Function Number: 105
func_0C08(param_00)
{
	if(func_0BEF())
	{
		return 0;
	}

	if(!isdefined(param_00.var_AC2))
	{
		return 0;
	}

	if(param_00.battlechatter == 0)
	{
		return 0;
	}

	if(!isdefined(param_00.var_AB4))
	{
		return 0;
	}

	if(self.var_AB4 != param_00.var_AB4)
	{
		return 0;
	}

	if(func_0C09(param_00))
	{
		return 0;
	}

	var_01 = self.var_AB4 + "_" + self.var_AB6 + "_name_" + param_00.var_AC2;
	if(soundexists(var_01))
	{
		return 1;
	}

	return 0;
}

//Function Number: 106
func_0C09(param_00)
{
	if(level.var_B84[self.team] == param_00.var_AC2 || gettime() - level.var_B85[self.team] < level.var_B86)
	{
		return 1;
	}

	return 0;
}

//Function Number: 107
func_0C0A()
{
	if(func_0BEF())
	{
		return 0;
	}

	if(!isdefined(level.player.var_BA0) || !isdefined(level.player.var_BA1))
	{
		return 0;
	}

	if(func_0C0B())
	{
		return 0;
	}

	var_00 = self.var_AB4 + "_" + self.var_AB6 + "_name_player_" + level.player.var_BA1 + "_" + level.player.var_BA0;
	if(soundexists(var_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 108
func_0C0B()
{
	if(!isdefined(level.var_C06))
	{
		return 0;
	}

	if(gettime() - level.var_C06 >= level.eventtypeminwait["playername"])
	{
		return 0;
	}

	return 1;
}

//Function Number: 109
func_0ADD(param_00)
{
	if(isstring(self.var_AB6) && isstring(param_00.var_AB6) && self.var_AB6 == param_00.var_AB6)
	{
		return 1;
	}

	if(!isstring(self.var_AB6) && !isstring(param_00.var_AB6) && self.var_AB6 == param_00.var_AB6)
	{
		return 1;
	}

	return 0;
}

//Function Number: 110
func_0C0C(param_00,param_01)
{
	var_02 = self.owner.var_AB4 + "_" + self.owner.var_AB6 + "_threat_" + param_00;
	if(isdefined(param_01))
	{
		var_02 = var_02 + "_" + param_01;
	}

	self.var_BB0 = maps\_utility::array_add(self.var_BB0,var_02);
	return 1;
}

//Function Number: 111
func_0C0D(param_00)
{
	var_01 = self.owner.var_AB4 + "_" + self.owner.var_AB6 + "_exposed_" + param_00;
	self.var_BB0[self.var_BB0.size] = var_01;
	return 1;
}

//Function Number: 112
func_0C0E()
{
	var_00 = self.owner.var_AB4 + "_" + self.owner.var_AB6 + "_order_action_suppress";
	self.var_BB0[self.var_BB0.size] = var_00;
	return 1;
}

//Function Number: 113
func_0C0F(param_00)
{
	var_01 = self.owner.var_AB4 + "_" + self.owner.var_AB6 + "_co_dist_" + param_00;
	self.var_BB0[self.var_BB0.size] = var_01;
	return 1;
}

//Function Number: 114
func_0C10(param_00)
{
	var_01 = self.owner.var_AB4 + "_" + self.owner.var_AB6 + "_co_elev_" + param_00;
	self.var_BB0[self.var_BB0.size] = var_01;
	return 1;
}

//Function Number: 115
func_0C11(param_00,param_01)
{
	var_02 = func_0C14(param_00,param_01);
	if(!soundexists(var_02))
	{
		return 0;
	}

	self.var_BB0[self.var_BB0.size] = var_02;
	return 1;
}

//Function Number: 116
func_0C12(param_00)
{
	var_01 = self.owner.var_AB4 + "_" + self.owner.var_AB6 + "_resp_ack_co_gnrc_" + param_00;
	if(!soundexists(var_01))
	{
		return 0;
	}

	self.var_BB0[self.var_BB0.size] = var_01;
	return 1;
}

//Function Number: 117
func_0C13(param_00,param_01,param_02)
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

	var_07 = self.owner.var_AB4 + "_" + self.owner.var_AB6 + "_co_";
	var_08 = getsubstr(param_01,param_01.size - 1,param_01.size);
	var_09 = int(var_08) + 1;
	var_0A = var_07 + var_03 + "_qa" + var_09;
	if(!soundexists(var_0A))
	{
		if(randomint(100) < level.var_B2D["response"]["callout_negative"])
		{
			param_00 animscripts/battlechatter_ai::func_ADB("callout","neg",self.owner,0.9);
		}
		else
		{
			param_00 animscripts/battlechatter_ai::func_ADB("exposed","acquired",self.owner,0.9);
		}

		param_02.var_BB9 = 1;
		return 0;
	}

	param_00 animscripts/battlechatter_ai::func_ADB("callout","QA",self.owner,0.9,var_0A,param_02);
	self.var_BB0[self.var_BB0.size] = var_0A;
	return 1;
}

//Function Number: 118
func_0C14(param_00,param_01)
{
	var_02 = "_report";
	var_03 = "_echo";
	var_04 = self.owner.var_AB4 + "_" + self.owner.var_AB6 + "_";
	var_05 = param_00.size - var_02.size;
	var_06 = self.owner.var_AB4 + "_" + param_01.var_AB6 + "_";
	var_07 = var_06.size;
	var_08 = getsubstr(param_00,var_07,var_05);
	var_09 = var_04 + var_08 + var_03;
	return var_09;
}

//Function Number: 119
func_0C15(param_00,param_01)
{
	var_02 = self.owner.var_AB4 + "_" + self.owner.var_AB6 + "_callout_" + param_00 + "_" + param_01;
	self.var_BB0[self.var_BB0.size] = var_02;
	return 1;
}

//Function Number: 120
func_0C16(param_00,param_01,param_02)
{
	var_03 = param_00.var_C17;
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_04 = self.owner.var_AB4 + "_" + self.owner.var_AB6 + "_callout_obj_" + var_03;
	if(param_02)
	{
		var_04 = var_04 + "_y";
	}

	var_04 = var_04 + "_" + param_01;
	if(!soundexists(var_04))
	{
		return 0;
	}

	self.var_BB0[self.var_BB0.size] = var_04;
	return 1;
}

//Function Number: 121
func_0C18(param_00)
{
	var_01 = undefined;
	var_02 = param_00.locationaliases;
	var_03 = var_02[0];
	if(var_02.size > 1)
	{
		var_04 = undefined;
		var_04 = param_00 func_0BB8(self.owner);
		if(isdefined(var_04))
		{
			var_03 = var_04;
		}
		else
		{
			var_03 = common_scripts\utility::random(var_02);
		}
	}

	var_05 = undefined;
	if(!isdefined(param_00.var_BB9) && func_0BBB(var_03,self.owner))
	{
		var_05 = self.owner func_0BBC(var_03,0);
	}
	else
	{
		var_06 = self.owner.var_AB4 + "_" + self.owner.var_AB6 + "_";
		if(!issubstr(var_03,"callout"))
		{
			var_06 = var_06 + "co_";
		}

		var_05 = var_06 + var_03;
	}

	if(soundexists(var_05))
	{
		var_01 = var_05;
	}

	if(!isdefined(var_01))
	{
		return 0;
	}

	func_0BF7(param_00);
	self.var_BB0[self.var_BB0.size] = var_01;
	return 1;
}

//Function Number: 122
func_0B4B(param_00,param_01)
{
	var_02 = self.owner.var_AB4 + "_" + self.owner.var_AB6 + "_inform_" + param_00 + "_" + param_01;
	self.var_BB0[self.var_BB0.size] = var_02;
}

//Function Number: 123
func_0C19(param_00,param_01)
{
	var_02 = self.owner.var_AB4 + "_" + self.owner.var_AB6 + "_response_" + param_00 + "_" + param_01;
	self.var_BB0[self.var_BB0.size] = var_02;
	return 1;
}

//Function Number: 124
func_0C1A(param_00,param_01)
{
	var_02 = self.owner.var_AB4 + "_" + self.owner.var_AB6 + "_reaction_" + param_00 + "_" + param_01;
	self.var_BB0[self.var_BB0.size] = var_02;
	return 1;
}

//Function Number: 125
func_0C1B()
{
	var_00 = self.owner.var_AB4 + "_" + self.owner.var_AB6 + "_check_fire";
	self.var_BB0[self.var_BB0.size] = var_00;
	return 1;
}

//Function Number: 126
func_0C1C(param_00,param_01)
{
	var_02 = self.owner.var_AB4 + "_" + self.owner.var_AB6 + "_taunt";
	self.var_BB0[self.var_BB0.size] = var_02;
	return 1;
}

//Function Number: 127
func_0C1D()
{
	var_00 = self.owner.var_AB4 + "_" + self.owner.var_AB6 + "_hostile_burst";
	self.var_BB0[self.var_BB0.size] = var_00;
	return 1;
}

//Function Number: 128
func_0B47(param_00,param_01)
{
	var_02 = self.owner.var_AB4 + "_" + self.owner.var_AB6 + "_order_" + param_00 + "_" + param_01;
	self.var_BB0[self.var_BB0.size] = var_02;
	return 1;
}

//Function Number: 129
func_0C1E(param_00)
{
	if(!isdefined(self.var_A6E[param_00].var_AAE))
	{
		self.var_A6E[param_00].var_AAE = 0;
	}

	if(!isdefined(self.var_A6E[param_00].var_BE1))
	{
		self.var_A6E[param_00].var_BE1 = 2000000000;
	}

	if(!isdefined(self.var_A6E[param_00].var_BE0))
	{
		self.var_A6E[param_00].var_BE0 = 0;
	}
}

//Function Number: 130
func_0C1F(param_00)
{
	self.var_A6E[param_00].var_AAE = undefined;
	self.var_A6E[param_00].var_BE1 = undefined;
	self.var_A6E[param_00].var_BE0 = undefined;
}

//Function Number: 131
func_0AD8(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.owner = self;
	var_03.var_BA7 = param_01;
	var_03.var_BDA = param_00;
	if(isdefined(param_02))
	{
		var_03.priority = param_02;
	}
	else
	{
		var_03.priority = level.var_B70[param_00][param_01];
	}

	var_03.var_ACB = gettime() + level.var_B71[param_00][param_01];
	return var_03;
}

//Function Number: 132
func_0B45()
{
	var_00 = spawnstruct();
	var_00.owner = self;
	var_00.var_BB0 = [];
	var_00.var_BAB = 0;
	return var_00;
}

//Function Number: 133
func_0C20(param_00)
{
	return maps\_utility::within_fov(self.origin,self.angles,param_00,0.766);
}

//Function Number: 134
func_0B1E(param_00)
{
	return maps\_utility::within_fov(self.origin,self.angles,param_00.origin,0);
}

//Function Number: 135
func_0C22()
{
	anim endon("battlechatter disabled");
	self endon("squad_deleting");
	if(self.team != "allies")
	{
		if(level.script != "af_caves")
		{
			return;
		}
	}

	while(self.var_A6A <= 0)
	{
		wait 0.5;
	}

	var_00 = 0;
	while(isdefined(self))
	{
		if(!func_0C23(self))
		{
			var_00 = 1;
			wait 1;
			continue;
		}
		else if(self.var_B99)
		{
			if(!var_00)
			{
				wait randomfloat(level.var_B73);
			}

			if(var_00)
			{
				var_00 = 0;
			}

			self.var_B99 = 0;
		}
		else
		{
			if(!var_00)
			{
				wait randomfloatrange(level.var_B73,level.var_B74);
			}

			if(var_00)
			{
				var_00 = 0;
			}
		}

		var_01 = func_0C25(self);
		if(!isdefined(var_01))
		{
			continue;
		}

		var_02 = var_01.voice;
		var_03 = func_0C27(self,var_02);
		var_04 = func_0C29(var_02,var_03);
		foreach(var_08, var_06 in var_04)
		{
			if(!var_01 func_0C24() || distance(level.player.origin,var_01.origin) > level.var_B72)
			{
				for(var_07 = 0;var_07 < self.members.size;var_07++)
				{
					var_01 = func_0C25(self);
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

			thread func_0C2A(var_01,var_06);
			self waittill("burst_line_done");
			if(var_08 != var_04.size - 1)
			{
				wait randomfloatrange(level.var_B75,level.var_B76);
			}
		}
	}
}

//Function Number: 136
func_0C23(param_00)
{
	var_01 = 0;
	foreach(var_03 in param_00.members)
	{
		if(var_03 func_0C24())
		{
			var_01 = 1;
			break;
		}
	}

	return var_01;
}

//Function Number: 137
func_0C24()
{
	var_00 = 0;
	if(!isplayer(self) && isalive(self) && self.classname != "actor_enemy_dog" && level.flavorbursts[self.team] && func_0AD2() && self.flavorbursts)
	{
		var_00 = 1;
	}

	return var_00;
}

//Function Number: 138
func_0AD2()
{
	if(isdefined(level.var_B82[self.voice]) && level.var_B82[self.voice])
	{
		return 1;
	}

	return 0;
}

//Function Number: 139
func_0C25(param_00)
{
	var_01 = undefined;
	var_02 = maps\_utility::get_array_of_farthest(level.player.origin,param_00.members);
	foreach(var_04 in var_02)
	{
		if(var_04 func_0C24())
		{
			var_01 = var_04;
			if(!isdefined(param_00.var_B9A))
			{
				break;
			}

			if(isdefined(param_00.var_B9A) && param_00.var_B9A == var_01.unique_id)
			{
				continue;
			}
		}
	}

	if(isdefined(var_01))
	{
		param_00.var_B9A = var_01.unique_id;
	}

	return var_01;
}

//Function Number: 140
func_0C27(param_00,param_01)
{
	var_02 = maps\_utility::array_randomize(level.flavorbursts[param_01]);
	if(level.var_B92.size >= var_02.size)
	{
		anim.var_B92 = [];
	}

	var_03 = undefined;
	foreach(var_05 in var_02)
	{
		var_03 = var_05;
		if(!func_0C28(var_03))
		{
			break;
		}
	}

	level.var_B92[level.var_B92.size] = var_03;
	return var_03;
}

//Function Number: 141
func_0C28(param_00)
{
	if(!level.var_B92.size)
	{
		return 0;
	}

	var_01 = 0;
	foreach(var_03 in level.var_B92)
	{
		if(var_03 == param_00)
		{
			var_01 = 1;
			break;
		}
	}

	return var_01;
}

//Function Number: 142
func_0C29(param_00,param_01,param_02)
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

//Function Number: 143
func_0C2A(param_00,param_01)
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

//Function Number: 144
func_0C2B(param_00,param_01)
{
	self endon("burst_line_done");
	wait 0.05;
}

//Function Number: 145
func_0C2C()
{
	return 0;
}

//Function Number: 146
func_0C2D()
{
	return 0;
}

//Function Number: 147
func_0C2E(param_00)
{
	if(param_00.size <= 0)
	{
		return;
	}

	if(!func_0C2C())
	{
		return;
	}

	var_01 = "^5 ";
	if(func_0BEF())
	{
		var_01 = "^6 ";
	}

	foreach(var_03 in param_00)
	{
	}
}

//Function Number: 148
func_0C2F(param_00,param_01)
{
}

//Function Number: 149
func_0C30(param_00)
{
	var_01 = self.var_AB4 + "_" + self.var_AB6 + "_";
	var_02 = getsubstr(param_00,var_01.size,param_00.size);
	return var_02;
}

//Function Number: 150
func_0C31(param_00,param_01,param_02)
{
	if(common_scripts\utility::flag(param_02))
	{
		common_scripts\utility::flag_wait(param_02);
	}

	common_scripts\utility::flag_set(param_02);
	common_scripts\utility::flag_clear(param_02);
}

//Function Number: 151
func_0C32()
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

		thread func_0C33("Location: " + var_02,level.bcs_locations[var_00] getorigin(),(0,0,8),(1,1,1));
	}
}

//Function Number: 152
func_0C33(param_00,param_01,param_02,param_03)
{
	for(;;)
	{
		if(distance(level.player.origin,param_01) > 2048)
		{
			wait 0.1;
			continue;
		}

		wait 0.05;
	}
}

//Function Number: 153
func_0C34(param_00,param_01,param_02)
{
	var_03 = param_00 getorigin();
	for(;;)
	{
		if(distance(level.player.origin,var_03) > 2048)
		{
			wait 0.1;
			continue;
		}

		var_04 = func_0BFD(level.player.origin,var_03);
		var_04 = func_0BFC(var_04);
		var_05 = func_0C01(level.player.angles,level.player.origin,var_03);
		var_06 = var_04 + ", " + var_05 + ":00";
		wait 0.05;
	}
}

//Function Number: 154
func_0C35(param_00,param_01)
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

		var_04.var_AC8[param_01] = gettime() + 350;
		var_04.var_A7A.var_AC8[param_01] = gettime() + 350;
	}
}

//Function Number: 155
func_0C36()
{
	self endon("death");
	if(self.voice == "british")
	{
		return 1;
	}

	return 0;
}

//Function Number: 156
func_0C37()
{
	if(!func_0C38())
	{
		return 0;
	}

	func_0BE9("reaction","friendlyfire");
	thread func_0BC5();
	return 1;
}

//Function Number: 157
func_0C38(param_00)
{
	if(isdefined(self.friendlyfire_warnings_disable))
	{
		return 0;
	}

	if(!isdefined(self.var_AC6))
	{
		return 0;
	}

	if(!isdefined(self.var_AC6["reaction"]) || !isdefined(self.var_AC6["reaction"].var_BA7))
	{
		return 0;
	}

	if(self.var_AC6["reaction"].var_BA7 != "friendlyfire")
	{
		return 0;
	}

	if(gettime() > self.var_AC6["reaction"].var_ACB)
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(param_00)
	{
		if(isdefined(self.var_A7A.var_B96["reaction"]["friendlyfire"]))
		{
			if(gettime() < self.var_A7A.var_B96["reaction"]["friendlyfire"])
			{
				return 0;
			}
		}
	}

	return 1;
}