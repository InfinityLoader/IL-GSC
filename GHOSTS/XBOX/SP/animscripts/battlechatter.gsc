/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\battlechatter.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 169
 * Decompile Time: 2284 ms
 * Timestamp: 10/27/2023 1:36:08 AM
*******************************************************************/

//Function Number: 1
func_4519()
{
	if(isdefined(level.var_1B40) && level.var_1B40)
	{
		return;
	}

	setdvarifuninitialized("bcs_enable",1);
	if(getdvarint("bcs_enable") == 0)
	{
		anim.var_1B40 = 0;
		level.player.var_1B40 = 0;
		return;
	}

	anim.var_1B40 = 1;
	level.player.var_1B40 = 0;
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
	anim.var_133C = "^3***** BCS WARNING: ";
	bcs_setup_teams_array();
	func_134A();
	level.var_5FCC["american"] = "1";
	level.var_5FCC["seal"] = "1";
	level.var_5FCC["taskforce"] = "1";
	level.var_5FCC["secretservice"] = "1";
	level.var_5FCC["delta"] = "1";
	thread func_7098();
	func_454A();
	if(!isdefined(level.var_357A))
	{
		level.var_357A = 0;
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

	level.eventactionminwait["threat"]["location_repeat"] = 15000;
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
	level.eventtypeminwait["playername"] = -15536;
	level.eventtypeminwait["reaction"]["casualty"] = 14000;
	level.eventtypeminwait["reaction"]["friendlyfire"] = 5000;
	level.eventtypeminwait["reaction"]["takingfire"] = -25536;
	level.eventtypeminwait["reaction"]["ask_ok"] = 15000;
	level.eventtypeminwait["reaction"]["taunt"] = 30000;
	level.eventtypeminwait["inform"]["reloading"] = 20000;
	level.eventtypeminwait["inform"]["killfirm"] = 15000;
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
	level.eventchance["response"]["exposed"] = 75;
	level.eventchance["response"]["reload"] = 65;
	level.eventchance["response"]["callout"] = 75;
	level.eventchance["response"]["callout_negative"] = 20;
	level.eventchance["response"]["order"] = 40;
	level.eventchance["moveEvent"]["coverme"] = 70;
	level.eventchance["moveEvent"]["ordertoplayer"] = 10;
	anim.var_31FC = 620;
	anim.var_3202 = 12;
	anim.var_3201 = 24;
	anim.var_3200 = 2;
	anim.var_31FF = 5;
	anim.var_548D = spawn("script_origin",(0,0,0));
	if(!isdefined(level.bcs_maxtalkingdistsqrdfromplayer))
	{
		level.bcs_maxtalkingdistsqrdfromplayer = squared(1500);
	}

	if(!isdefined(level.var_1345))
	{
		level.var_1345 = squared(2500);
	}

	level.heightforhighcallout = 96;
	level.mindistancecallout = 8;
	level.var_50FB = 45;
	common_scripts\_bcs_location_trigs::bcs_location_trigs_init();
	anim.var_6D14 = 4000;
	anim.bcs_threatresettime = 3000;
	level.var_798F[level.var_798F.size] = ::init_squadbattlechatter;
	level.var_7990[level.var_7990.size] = "::init_squadBattleChatter";
	foreach(var_01 in level.teams)
	{
		level.isteamspeaking[var_01] = 0;
		level.var_4985[var_01]["threat"] = 0;
		level.var_4985[var_01]["order"] = 0;
		level.var_4985[var_01]["reaction"] = 0;
		level.var_4985[var_01]["response"] = 0;
		level.var_4985[var_01]["inform"] = 0;
		level.var_4985[var_01]["custom"] = 0;
	}

	bcs_setup_chatter_toggle_array();
	bcs_setup_flavorburst_toggle_array();
	anim.var_4CC7 = [];
	anim.var_4C81 = [];
	anim.var_4C82 = [];
	foreach(var_01 in level.teams)
	{
		level.var_4CC7[var_01] = --15536;
		level.var_4C81[var_01] = "none";
		level.var_4C82[var_01] = -100000;
	}

	anim.var_4C83 = 120000;
	for(var_05 = 0;var_05 < level.var_7994.size;var_05++)
	{
		if(isdefined(level.var_7994[var_05].var_1B40) && level.var_7994[var_05].var_1B40)
		{
			continue;
		}

		level.var_7994[var_05] init_squadbattlechatter();
	}

	anim.var_8096 = [];
	level.var_8096["rpg"] = 80;
	level.var_8096["exposed"] = 25;
	level.var_8096["player_distance"] = 25;
	level.var_8096["player_obvious"] = 25;
	level.var_8096["player_contact_clock"] = 25;
	level.var_8096["player_target_clock"] = 25;
	level.var_8096["player_target_clock_high"] = 25;
	level.var_8096["player_cardinal"] = 20;
	level.var_8096["ai_distance"] = 25;
	level.var_8096["ai_obvious"] = 25;
	level.var_8096["ai_contact_clock"] = 20;
	level.var_8096["ai_casual_clock"] = 20;
	level.var_8096["ai_target_clock"] = 20;
	level.var_8096["ai_target_clock_high"] = 25;
	level.var_8096["ai_cardinal"] = 10;
	level.var_8096["concat_location"] = 90;
	level.var_8096["player_location"] = 90;
	level.var_8096["ai_location"] = 100;
	level.var_8096["generic_location"] = 95;
	anim.var_4CC8 = [];
	anim.lastteamthreatcallouttime = [];
	foreach(var_01 in level.teams)
	{
		level.var_4CC8[var_01] = undefined;
		level.lastteamthreatcallouttime[var_01] = undefined;
	}

	anim.var_7FA9 = 120000;
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
func_134A()
{
	if(!isdefined(level.var_87B2))
	{
		anim.var_87B2 = [];
		anim.var_341E = [];
		anim.countryids = [];
		bcs_setup_voice("british","UK",2);
		bcs_setup_voice("secretservice","SS",4);
		bcs_setup_voice("french","FR",3);
		bcs_setup_voice("czech","CZ",3);
		bcs_setup_voice("pmc","PC",3);
		bcs_setup_voice("arab","AB",3);
		bcs_setup_voice("portugese","PG",3);
		bcs_setup_voice("african","AF",3);
		bcs_setup_voice("american","US",3,1);
		bcs_setup_voice("delta","GL",1);
		bcs_setup_voice("taskforce","GM",1);
		bcs_setup_voice("seal","GS",1);
		bcs_setup_voice("shadowcompany","SP",6);
		bcs_setup_voice("russian","SP",6);
	}
}

//Function Number: 4
bcs_setup_voice(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	level.var_87B2[param_00] = [];
	for(var_04 = 0;var_04 < param_02;var_04++)
	{
		level.var_87B2[param_00][var_04] = addstruct();
		level.var_87B2[param_00][var_04].count = 0;
		level.var_87B2[param_00][var_04].npcid = "" + var_04;
	}

	level.countryids[param_00] = param_01;
	level.var_341E[param_00] = param_03;
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
			maps\_utility::func_6E55(var_01,1);
		}
	}
}

//Function Number: 6
bcs_setup_flavorburst_toggle_array()
{
	bcs_setup_teams_array();
	if(!isdefined(level.var_341A))
	{
		level.var_341A = [];
		foreach(var_01 in level.teams)
		{
			level.var_341A[var_01] = 1;
		}
	}
}

//Function Number: 7
func_454A()
{
	level.var_341A["american"] = [];
	var_00 = 41;
	for(var_01 = 0;var_01 < var_00;var_01++)
	{
		level.var_341A["american"][var_01] = maps\_utility::func_7CDD(var_01 + 1);
	}

	level.var_341A["shadowcompany"] = [];
	var_00 = 9;
	for(var_01 = 1;var_01 <= var_00;var_01++)
	{
		level.var_341A["shadowcompany"][var_01] = maps\_utility::func_7CDD(var_01 + 1);
	}

	anim.var_341D = [];
}

//Function Number: 8
func_7533()
{
	anim.countryids = undefined;
	anim.eventtypeminwait = undefined;
	anim.eventactionminwait = undefined;
	anim.eventtypeminwait = undefined;
	anim.eventpriority = undefined;
	anim.eventduration = undefined;
	anim.var_548D = undefined;
	anim.var_6D14 = undefined;
	anim.bcs_threatresettime = undefined;
	anim.locationlastcallouttimes = undefined;
	anim.var_87B2 = undefined;
	anim.var_341D = undefined;
	anim.var_4CC8 = undefined;
	anim.lastteamthreatcallouttime = undefined;
	anim.var_4C83 = undefined;
	anim.var_4C81 = undefined;
	anim.var_4C82 = undefined;
	anim.var_1B40 = 0;
	level.player.var_1B40 = 0;
	level.battlechatter = undefined;
	anim.bcs_locations = undefined;
	for(var_00 = 0;var_00 < level.var_798F.size;var_00++)
	{
		if(level.var_7990[var_00] != "::init_squadBattleChatter")
		{
			continue;
		}

		if(var_00 != level.var_798F.size - 1)
		{
			level.var_798F[var_00] = level.var_798F[level.var_798F.size - 1];
			level.var_7990[var_00] = level.var_7990[level.var_7990.size - 1];
		}

		level.var_798F[level.var_798F.size - 1] = undefined;
		level.var_7990[level.var_7990.size - 1] = undefined;
	}

	level notify("battlechatter disabled");
	anim notify("battlechatter disabled");
}

//Function Number: 9
init_squadbattlechatter()
{
	var_00 = self;
	var_00.numspeakers = 0;
	var_00.var_5119 = 1;
	var_00.var_55FA = gettime() + 50;
	var_00.nextsaytimes["threat"] = gettime() + 50;
	var_00.nextsaytimes["order"] = gettime() + 50;
	var_00.nextsaytimes["reaction"] = gettime() + 50;
	var_00.nextsaytimes["response"] = gettime() + 50;
	var_00.nextsaytimes["inform"] = gettime() + 50;
	var_00.nextsaytimes["custom"] = gettime() + 50;
	var_00.var_55FE["threat"] = [];
	var_00.var_55FE["order"] = [];
	var_00.var_55FE["reaction"] = [];
	var_00.var_55FE["response"] = [];
	var_00.var_55FE["inform"] = [];
	var_00.var_55FE["custom"] = [];
	var_00.ismembersaying["threat"] = 0;
	var_00.ismembersaying["order"] = 0;
	var_00.ismembersaying["reaction"] = 0;
	var_00.ismembersaying["response"] = 0;
	var_00.ismembersaying["inform"] = 0;
	var_00.ismembersaying["custom"] = 0;
	var_00.var_4C56 = "";
	var_00.var_51BD[var_00.var_51BD.size] = ::animscripts/battlechatter_ai::func_99A;
	var_00.var_51BE[var_00.var_51BE.size] = "::addToSystem";
	var_00.var_51C3[var_00.var_51C3.size] = ::animscripts/battlechatter_ai::func_6594;
	var_00.memberremovestrings[var_00.memberremovestrings.size] = "::removeFromSystem";
	var_00.squadupdatefuncs[var_00.squadupdatefuncs.size] = ::initcontact;
	var_00.var_79A1[var_00.var_79A1.size] = "::initContact";
	var_00.fbt_firstburst = 1;
	var_00.var_31FE = undefined;
	for(var_01 = 0;var_01 < level.var_7994.size;var_01++)
	{
		var_00 thread initcontact(level.var_7994[var_01].var_7998);
	}

	var_00 thread animscripts/battlechatter_ai::func_799E();
	var_00 thread animscripts/battlechatter_ai::squadofficerwaiter();
	var_00 thread squadflavorbursttransmissions();
	var_00.var_1B40 = 1;
	var_00 notify("squad chat initialized");
}

//Function Number: 10
func_7534()
{
	var_00 = self;
	var_00.numspeakers = undefined;
	var_00.var_5119 = undefined;
	var_00.var_55FA = undefined;
	var_00.nextsaytimes = undefined;
	var_00.var_55FE = undefined;
	var_00.ismembersaying = undefined;
	var_00.fbt_firstburst = undefined;
	var_00.var_31FE = undefined;
	for(var_01 = 0;var_01 < var_00.var_51BD.size;var_01++)
	{
		if(var_00.var_51BE[var_01] != "::addToSystem")
		{
			continue;
		}

		if(var_01 != var_00.var_51BD.size - 1)
		{
			var_00.var_51BD[var_01] = var_00.var_51BD[var_00.var_51BD.size - 1];
			var_00.var_51BE[var_01] = var_00.var_51BE[var_00.var_51BE.size - 1];
		}

		var_00.var_51BD[var_00.var_51BD.size - 1] = undefined;
		var_00.var_51BE[var_00.var_51BE.size - 1] = undefined;
	}

	for(var_01 = 0;var_01 < var_00.var_51C3.size;var_01++)
	{
		if(var_00.memberremovestrings[var_01] != "::removeFromSystem")
		{
			continue;
		}

		if(var_01 != var_00.var_51C3.size - 1)
		{
			var_00.var_51C3[var_01] = var_00.var_51C3[var_00.var_51C3.size - 1];
			var_00.memberremovestrings[var_01] = var_00.memberremovestrings[var_00.memberremovestrings.size - 1];
		}

		var_00.var_51C3[var_00.var_51C3.size - 1] = undefined;
		var_00.memberremovestrings[var_00.memberremovestrings.size - 1] = undefined;
	}

	for(var_01 = 0;var_01 < var_00.squadupdatefuncs.size;var_01++)
	{
		if(var_00.var_79A1[var_01] != "::initContact")
		{
			continue;
		}

		if(var_01 != var_00.squadupdatefuncs.size - 1)
		{
			var_00.squadupdatefuncs[var_01] = var_00.squadupdatefuncs[var_00.squadupdatefuncs.size - 1];
			var_00.var_79A1[var_01] = var_00.var_79A1[var_00.var_79A1.size - 1];
		}

		var_00.squadupdatefuncs[var_00.squadupdatefuncs.size - 1] = undefined;
		var_00.var_79A1[var_00.var_79A1.size - 1] = undefined;
	}

	for(var_01 = 0;var_01 < level.var_7994.size;var_01++)
	{
		var_00 func_7535(level.var_7994[var_01].var_7998);
	}

	var_00.var_1B40 = 0;
}

//Function Number: 11
func_1351()
{
	return level.var_1B40;
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
					if(!level.var_1B40)
					{
						func_2CE1();
					}
					break;
	
				case 0:
					if(level.var_1B40)
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
func_2CE1()
{
	func_4519();
	level.player thread animscripts/battlechatter_ai::func_99A();
	var_00 = function_016B();
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] animscripts/battlechatter_ai::func_99A();
	}
}

//Function Number: 14
disablebattlechatter()
{
	if(!isdefined(level.var_1B40))
	{
	}

	func_7533();
	var_00 = function_016B();
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(isdefined(var_00[var_01].squad) && var_00[var_01].squad.var_1B40)
		{
			var_00[var_01].squad func_7534();
		}

		var_00[var_01] animscripts/battlechatter_ai::func_6594();
	}
}

//Function Number: 15
func_7098(param_00,param_01)
{
	if(isdefined(param_00) && isdefined(param_01))
	{
		level.player.var_133A = param_00;
		level.player.bccountryid = param_01;
	}

	while(!isdefined(level.var_1973))
	{
		wait(0.1);
	}

	var_02 = level.var_1973;
	var_03 = level.var_5FCC[var_02];
	var_04 = level.countryids[var_02];
	if(isdefined(var_03))
	{
		level.player.var_133A = var_03;
	}

	if(isdefined(var_04))
	{
		level.player.bccountryid = var_04;
	}
}

//Function Number: 16
func_5D4E()
{
	if(!isalive(self))
	{
	}

	if(!func_1351())
	{
	}

	if(self._animactive > 0)
	{
	}

	if(isdefined(self.var_4968) && self.var_4968)
	{
	}

	if(self.team == "allies" && isdefined(level.var_6D15))
	{
		if(level.var_6D15 + level.var_6D14 > gettime())
		{
		}
	}

	if(friendlyfire_warning())
	{
	}

	if(!isdefined(self.battlechatter) || !self.battlechatter)
	{
	}

	if(self.team == "allies" && getdvarint("bcs_forceEnglish",0))
	{
	}

	if(level.isteamspeaking[self.team])
	{
	}

	self endon("death");
	var_00 = func_3ACA();
	if(!isdefined(var_00))
	{
	}

	switch(var_00)
	{
		case "custom":
			thread func_5D57();
			break;

		case "response":
			thread func_603A();
			break;

		case "order":
			thread func_602F();
			break;

		case "threat":
			thread func_604B();
			break;

		case "reaction":
			thread playreactionevent();
			break;

		case "inform":
			thread func_601B();
			break;
	}
}

//Function Number: 17
func_604B()
{
	self endon("death");
	self endon("removed from battleChatter");
	self endon("cancel speaking");
	self.var_219C = self.chatqueue["threat"];
	var_00 = self.chatqueue["threat"].var_8093;
	if(!isalive(var_00))
	{
	}

	if(func_80A1(var_00) && !isplayer(var_00))
	{
	}

	anim thread func_4ED4(self,"threat");
	var_01 = 0;
	switch(self.chatqueue["threat"].eventtype)
	{
		case "infantry":
			if(isplayer(var_00) || !isdefined(var_00 method_8213()))
			{
				var_01 = func_809A(var_00);
			}
			else
			{
			}
			break;

		case "dog":
			var_01 = func_8098(var_00);
			break;

		case "vehicle":
			break;
	}

	self notify("done speaking");
	if(!var_01)
	{
	}

	if(!isalive(var_00))
	{
	}

	var_00.var_195D[self.squad.var_7998] = addstruct();
	var_00.var_195D[self.squad.var_7998].var_7976 = self;
	var_00.var_195D[self.squad.var_7998].var_80A0 = self.chatqueue["threat"].eventtype;
	var_00.var_195D[self.squad.var_7998].var_30A5 = gettime() + level.bcs_threatresettime;
	if(isdefined(var_00.squad))
	{
		self.squad.var_7996[var_00.squad.var_7998].var_195D = 1;
	}
}

//Function Number: 18
func_80A1(param_00)
{
	if(isdefined(param_00.var_195D) && isdefined(param_00.var_195D[self.squad.var_7998]))
	{
		if(param_00.var_195D[self.squad.var_7998].var_30A5 < gettime())
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 19
func_809A(param_00,param_01)
{
	self endon("cancel speaking");
	var_02 = func_20CF();
	var_02.var_50B4 = 1;
	var_02.var_8099 = param_00;
	var_03 = func_3C46(param_00);
	if(!isdefined(var_03) || isdefined(var_03) && !isdefined(var_03.type))
	{
		return 0;
	}

	switch(var_03.type)
	{
		case "rpg":
			var_02 func_809D(param_00);
			break;

		case "exposed":
			var_04 = doexposedcalloutresponse(var_03.var_6637);
			if(var_04 && func_19F3(var_03.var_6637))
			{
				var_02 addnamealias(var_03.var_6637.bcname);
				var_02.looktarget = var_03.var_6637;
			}
	
			var_02 func_809C(param_00);
			if(var_04)
			{
				if(randomint(100) < level.eventchance["response"]["callout_negative"])
				{
					var_03.var_6637 animscripts/battlechatter_ai::addresponseevent("callout","neg",self,0.9);
				}
				else
				{
					var_03.var_6637 animscripts/battlechatter_ai::addresponseevent("exposed","acquired",self,0.9);
				}
			}
			break;

		case "player_obvious":
			var_02 addplayernamealias();
			var_02 addthreatobviousalias();
			break;

		case "player_distance":
			var_05 = func_3A86(level.player.origin,param_00.origin);
			var_02 addplayernamealias();
			var_02 addthreatdistancealias(var_05);
			break;

		case "player_contact_clock":
			var_02 addplayernamealias();
			var_02 addthreatcalloutalias("contactclock",var_03.var_5F9B);
			break;

		case "player_target_clock":
			var_02 addplayernamealias();
			var_02 addthreatcalloutalias("targetclock",var_03.var_5F9B);
			break;

		case "player_target_clock_high":
			var_02 addplayernamealias();
			var_06 = getdegreeselevation(level.player.origin,param_00.origin);
			if(var_06 >= 20 && var_06 <= 50)
			{
				var_02 addthreatcalloutalias("targetclock",var_03.var_5F9B);
				var_02 addthreatelevationalias(var_06);
			}
			else
			{
				var_02 addthreatcalloutalias("targetclock",var_03.var_5F9B + "_high");
			}
			break;

		case "player_cardinal":
			var_02 addplayernamealias();
			var_07 = getdirectioncompass(level.player.origin,param_00.origin);
			var_08 = func_567E(var_07);
			if(var_08 == "impossible")
			{
				return 0;
			}
	
			var_02 addthreatcalloutalias("cardinal",var_08);
			break;

		case "ai_obvious":
			if(isdefined(var_03.var_6637) && func_19F3(var_03.var_6637))
			{
				var_02 addnamealias(var_03.var_6637.bcname);
				var_02.looktarget = var_03.var_6637;
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
			else if(isdefined(var_03.var_6637) && randomint(100) < level.eventchance["response"]["callout"])
			{
				var_09 = var_03.var_6637;
			}
	
			var_05 = func_3A86(var_09.origin,param_00.origin);
			var_02 addthreatdistancealias(var_05);
			var_02 addcalloutresponseevent(self,var_03,param_00);
			break;

		case "ai_contact_clock":
			var_09 = self;
			if(self.team == "allies")
			{
				var_09 = level.player;
			}
			else if(isdefined(var_03.var_6637) && randomint(100) < level.eventchance["response"]["callout"])
			{
				var_09 = var_03.var_6637;
			}
	
			var_0A = func_3BD0(var_09);
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
			else if(isdefined(var_03.var_6637) && randomint(100) < level.eventchance["response"]["callout"])
			{
				var_09 = var_03.var_6637;
			}
	
			var_0A = func_3BD0(var_09);
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
			else if(isdefined(var_03.var_6637) && randomint(100) < level.eventchance["response"]["callout"])
			{
				var_09 = var_03.var_6637;
			}
	
			var_0A = func_3BD0(var_09);
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
			else if(isdefined(var_03.var_6637) && randomint(100) < level.eventchance["response"]["callout"])
			{
				var_09 = var_03.var_6637;
			}
	
			var_0A = func_3BD0(var_09);
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
			var_08 = func_567E(var_07);
			if(var_08 == "impossible")
			{
				return 0;
			}
	
			var_02 addthreatcalloutalias("cardinal",var_08);
			break;

		case "generic_location":
			var_0C = var_02 func_809B(var_03);
			if(!var_0C)
			{
				return 0;
			}
			break;

		case "player_location":
			var_02 addplayernamealias();
			var_0C = var_02 func_809B(var_03);
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
	
			var_0C = var_02 func_809B(var_03,1);
			if(!var_0C)
			{
				return 0;
			}
	
			var_02 addconcatdirectionalias(var_09,param_00);
			var_02 addcalloutresponseevent(self,var_03,param_00);
			break;

		case "ai_location":
			if(func_19F3(var_03.var_6637))
			{
				var_02 addnamealias(var_03.var_6637.bcname);
				var_02.looktarget = var_03.var_6637;
			}
	
			var_0C = var_02 func_809B(var_03);
			if(!var_0C)
			{
				return 0;
			}
	
			var_0D = var_02.var_771D.size - 1;
			var_0E = var_02.var_771D[var_0D];
			if(iscallouttypereport(var_0E))
			{
				var_03.var_6637 animscripts/battlechatter_ai::addresponseevent("callout","echo",self,0.9,var_0E);
			}
			else if(func_4892(var_0E,self))
			{
				var_03.var_6637 animscripts/battlechatter_ai::addresponseevent("callout","QA",self,0.9,var_0E,var_03.location);
			}
			else if(randomint(100) < level.eventchance["response"]["callout_negative"])
			{
				var_03.var_6637 animscripts/battlechatter_ai::addresponseevent("callout","neg",self,0.9);
			}
			else
			{
				var_03.var_6637 animscripts/battlechatter_ai::addresponseevent("exposed","acquired",self,0.9);
			}
			break;
	}

	func_7060(var_03.type);
	func_6033(var_02);
	return 1;
}

//Function Number: 20
doexposedcalloutresponse(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00.var_1F85 != "US" && param_00.var_1F85 != "NS" && param_00.var_1F85 != "TF")
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
func_809B(param_00,param_01)
{
	var_02 = addthreatcalloutlocationalias(param_00.location,param_01);
	return var_02;
}

//Function Number: 22
addcalloutresponseevent(param_00,param_01,param_02)
{
	if(!isdefined(param_01.var_6637))
	{
	}

	if(randomint(100) > level.eventchance["response"]["callout"])
	{
	}

	var_03 = "affirm";
	if(!param_01.var_6637 method_81F2(param_02) && randomint(100) < level.eventchance["response"]["callout_negative"])
	{
		var_03 = "neg";
	}

	param_01.var_6637 animscripts/battlechatter_ai::addresponseevent("callout",var_03,param_00,0.9);
}

//Function Number: 23
func_3C46(param_00)
{
	var_01 = param_00 func_3C62(self);
	var_02 = getdirectionfacingclock(self.angles,self.origin,param_00.origin);
	var_03 = func_3BD4(64,1024,"response");
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

	var_08 = func_3A85(var_07.origin,param_00.origin);
	self.var_60B7 = [];
	if(!isplayer(param_00) && param_00 animscripts/utility::func_87FA())
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
				if(var_08 > level.mindistancecallout && var_08 < level.var_50FB)
				{
					addpossiblethreatcallout("player_distance");
				}
			}

			if(func_19F4() && var_06 != "12")
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
			if(var_08 > level.mindistancecallout && var_08 < level.var_50FB)
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
		if(func_19AF(var_01))
		{
			addpossiblethreatcallout("concat_location");
		}
		else if(isdefined(var_01 func_3A49(self)))
		{
			if(isdefined(var_03))
			{
				addpossiblethreatcallout("ai_location");
			}
			else
			{
				if(func_19F4())
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

			if(func_19F4())
			{
				addpossiblethreatcallout("player_location");
			}

			addpossiblethreatcallout("generic_location");
		}
	}

	if(!self.var_60B7.size)
	{
		return undefined;
	}

	var_0B = func_3C85(self.var_60B7,level.var_8096);
	var_0C = addstruct();
	var_0C.type = var_0B;
	var_0C.var_6637 = var_03;
	var_0C.var_6638 = var_04;
	var_0C.var_5F9B = var_05;
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
		var_04 = func_3BAB(var_02,0);
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
func_19AF(param_00)
{
	var_01 = param_00.locationaliases;
	foreach(var_03 in var_01)
	{
		if(func_4891(var_03,self))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 26
func_3A49(param_00)
{
	var_01 = undefined;
	var_02 = self.locationaliases;
	foreach(var_04 in var_02)
	{
		if(func_4892(var_04,param_00) && !isdefined(self.qafinished))
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
func_4891(param_00,param_01)
{
	var_02 = param_01 getloccalloutalias("concat_loc_" + param_00);
	if(soundexists(var_02))
	{
		return 1;
	}

	return 0;
}

//Function Number: 29
func_4892(param_00,param_01)
{
	if(issubstr(param_00,"_qa") && soundexists(param_00))
	{
		return 1;
	}

	var_02 = param_01 func_3BAB(param_00,0);
	if(soundexists(var_02))
	{
		return 1;
	}

	return 0;
}

//Function Number: 30
getloccalloutalias(param_00)
{
	var_01 = self.var_1F85 + "_" + self.npcid + "_";
	var_01 = var_01 + param_00;
	return var_01;
}

//Function Number: 31
func_3BAB(param_00,param_01)
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

	self.var_60B7[self.var_60B7.size] = param_00;
	return var_01;
}

//Function Number: 34
callouttypewillrepeat(param_00)
{
	if(!isdefined(level.var_4CC8[self.team]))
	{
		return 0;
	}

	if(!isdefined(level.lastteamthreatcallouttime[self.team]))
	{
		return 0;
	}

	var_01 = level.var_4CC8[self.team];
	var_02 = level.lastteamthreatcallouttime[self.team];
	var_03 = level.var_7FA9;
	if(param_00 == var_01 && gettime() - var_02 < var_03)
	{
		return 1;
	}

	return 0;
}

//Function Number: 35
func_7060(param_00)
{
	level.var_4CC8[self.team] = param_00;
	level.lastteamthreatcallouttime[self.team] = gettime();
}

//Function Number: 36
func_3C85(param_00,param_01)
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
func_8098(param_00,param_01)
{
	self endon("cancel speaking");
	var_02 = func_20CF();
	var_02.var_50B4 = 1;
	var_02.var_8099 = param_00;
	var_02 addthreatalias("dog","generic");
	func_6033(var_02);
	return 1;
}

//Function Number: 38
func_809C(param_00)
{
	var_01 = [];
	var_01 = common_scripts\utility::array_add(var_01,"open");
	if(self.owner.var_1F85 != "GS")
	{
		var_01 = common_scripts\utility::array_add(var_01,"breaking");
	}

	if(self.owner.team == "allies" && self.owner.var_1F85 != "RU")
	{
		var_01 = common_scripts\utility::array_add(var_01,"movement");
	}

	var_02 = var_01[randomint(var_01.size)];
	addthreatexposedalias(var_02);
}

//Function Number: 39
func_809D(param_00)
{
	addthreatalias("rpg");
}

//Function Number: 40
playreactionevent()
{
	self endon("death");
	self endon("removed from battleChatter");
	self.var_219C = self.chatqueue["reaction"];
	var_00 = self.chatqueue["reaction"].var_63C8;
	var_01 = self.chatqueue["reaction"].var_531F;
	anim thread func_4ED4(self,"reaction");
	switch(self.chatqueue["reaction"].eventtype)
	{
		case "casualty":
			func_63BD(var_00,var_01);
			break;

		case "taunt":
			func_63C1(var_00,var_01);
			break;

		case "friendlyfire":
			func_63BE(var_00,var_01);
			break;

		case "takingfire":
			func_63C0(var_00,var_01);
			if(common_scripts\utility::func_1DE9())
			{
				var_02 = func_3BD4(64,1024,"response");
				if(isdefined(var_02))
				{
					if(common_scripts\utility::func_1DE9())
					{
						if(var_02 func_19F2("reaction","ask_ok",1,undefined))
						{
							var_02 animscripts/battlechatter_ai::addreactionevent("ask_ok",undefined,self,1);
						}
					}
					else
					{
						var_02 animscripts/battlechatter_ai::addresponseevent("covering","fire",self,1);
					}
				}
			}
			break;

		case "ask_ok":
			func_663E(var_00,"ask","ok");
			var_02 = func_3BD4(64,1024,"response");
			if(isdefined(var_02))
			{
				var_02 animscripts/battlechatter_ai::addresponseevent("im","ok",self,1);
			}
			break;
	}

	self notify("done speaking");
}

//Function Number: 41
func_63BD(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_02 = func_20CF();
	var_02 addreactionalias("casualty","generic");
	func_6033(var_02);
}

//Function Number: 42
func_63C1(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_02 = func_20CF();
	if(isdefined(param_01) && param_01 == "hostileburst")
	{
		var_02 addhostileburstalias();
	}
	else
	{
		var_02 addtauntalias("taunt","generic");
	}

	func_6033(var_02);
}

//Function Number: 43
func_63BE(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_02 = func_20CF();
	var_02 addcheckfirealias();
	func_6033(var_02);
}

//Function Number: 44
func_63C0(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_02 = func_20CF();
	var_02 addtakingfirealias();
	func_6033(var_02);
}

//Function Number: 45
func_663E(param_00,param_01,param_02)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_03 = func_20CF();
	var_03 addresponsealias(param_01,param_02);
	func_6033(var_03);
}

//Function Number: 46
func_603A()
{
	self endon("death");
	self endon("removed from battleChatter");
	self.var_219C = self.chatqueue["response"];
	var_00 = self.chatqueue["response"].var_531F;
	var_01 = self.chatqueue["response"].respondto;
	if(!isalive(var_01))
	{
	}

	if(self.chatqueue["response"].var_531F == "follow" && self.a.state != "move")
	{
	}

	anim thread func_4ED4(self,"response");
	switch(self.chatqueue["response"].eventtype)
	{
		case "exposed":
			responsethreatexposed(var_01,var_00);
			break;

		case "callout":
			func_663F(var_01,var_00);
			break;

		case "ack":
			func_663D(var_01,var_00);
			break;

		default:
			func_663D(var_01,var_00);
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
	}

	var_02 = func_20CF();
	var_02 addthreatexposedalias(param_01);
	var_02.looktarget = param_00;
	var_02.var_50B4 = 1;
	func_6033(var_02);
}

//Function Number: 48
func_663F(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!isalive(param_00))
	{
	}

	var_02 = func_20CF();
	var_03 = 0;
	if(param_01 == "echo")
	{
		var_03 = var_02 addthreatcalloutecho(self.var_219C.var_65C7,param_00);
	}
	else if(param_01 == "QA")
	{
		var_03 = var_02 addthreatcalloutqa_nextline(param_00,self.var_219C.var_65C7,self.var_219C.location);
	}
	else
	{
		var_03 = var_02 addthreatcalloutresponsealias(param_01);
	}

	if(!var_03)
	{
	}

	var_02.looktarget = param_00;
	var_02.var_50B4 = 1;
	func_6033(var_02);
}

//Function Number: 49
func_663D(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	if(!isalive(param_00))
	{
	}

	var_02 = self.chatqueue["response"].eventtype;
	var_03 = func_20CF();
	var_03 addresponsealias(var_02,param_01);
	var_03.looktarget = param_00;
	var_03.var_50B4 = 1;
	func_6033(var_03);
}

//Function Number: 50
func_602F()
{
	self endon("death");
	self endon("removed from battleChatter");
	self.var_219C = self.chatqueue["order"];
	var_00 = self.chatqueue["order"].var_531F;
	var_01 = self.chatqueue["order"].var_59D9;
	anim thread func_4ED4(self,"order");
	switch(self.chatqueue["order"].eventtype)
	{
		case "action":
			func_59D5(var_00,var_01);
			break;

		case "move":
			func_59D7(var_00,var_01);
			break;

		case "displace":
			func_59D6(var_00);
			break;
	}

	self notify("done speaking");
}

//Function Number: 51
func_59D5(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_02 = func_20CF();
	tryorderto(var_02,param_01);
	var_02 addorderalias("action",param_00);
	func_6033(var_02);
}

//Function Number: 52
func_59D7(param_00,param_01)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_02 = func_20CF();
	tryorderto(var_02,param_01);
	var_02 addorderalias("move",param_00);
	func_6033(var_02);
}

//Function Number: 53
func_59D6(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_01 = func_20CF();
	var_01 addorderalias("displace",param_00);
	func_6033(var_01,1);
}

//Function Number: 54
tryorderto(param_00,param_01)
{
	if(randomint(100) > level.eventchance["response"]["order"])
	{
		if(!isdefined(param_01) || isdefined(param_01) && !isplayer(param_01))
		{
		}
	}

	if(isdefined(param_01) && isplayer(param_01) && isdefined(level.player.var_133A))
	{
		param_00 addplayernamealias();
		param_00.looktarget = level.player;
	}

	if(isdefined(param_01) && func_19F3(param_01))
	{
		param_00 addnamealias(param_01.bcname);
		param_00.looktarget = param_01;
		param_01 animscripts/battlechatter_ai::addresponseevent("ack","yes",self,0.9);
	}

	level notify("follow order",self);
}

//Function Number: 55
func_601B()
{
	self endon("death");
	self endon("removed from battleChatter");
	self.var_219C = self.chatqueue["inform"];
	var_00 = self.chatqueue["inform"].var_531F;
	anim thread func_4ED4(self,"inform");
	switch(self.chatqueue["inform"].eventtype)
	{
		case "incoming":
			func_44D4(var_00);
			break;

		case "attack":
			informattacking(var_00);
			break;

		case "reloading":
			informreloading(var_00);
			break;

		case "suppressed":
			func_44D7(var_00);
			break;

		case "killfirm":
			func_44D5(var_00);
			break;
	}

	self notify("done speaking");
}

//Function Number: 56
informreloading(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_01 = func_20CF();
	var_01 addinformalias("reloading",param_00);
	func_6033(var_01);
}

//Function Number: 57
func_44D7(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_01 = func_20CF();
	var_01 addinformalias("suppressed",param_00);
	func_6033(var_01);
}

//Function Number: 58
func_44D4(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_01 = func_20CF();
	if(param_00 == "grenade")
	{
		var_01.var_50B4 = 1;
	}

	var_01 addinformalias("incoming",param_00);
	func_6033(var_01);
}

//Function Number: 59
informattacking(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_01 = func_20CF();
	var_01 addinformalias("attack",param_00);
	func_6033(var_01);
}

//Function Number: 60
func_44D5(param_00)
{
	self endon("death");
	self endon("removed from battleChatter");
	var_01 = func_20CF();
	var_01 addinformalias("killfirm",param_00);
	func_6033(var_01);
}

//Function Number: 61
func_5D57()
{
	self endon("death");
	self endon("removed from battleChatter");
	self.var_219C = self.chatqueue["custom"];
	anim thread func_4ED4(self,self.var_219C.type,1);
	func_6033(self.var_2240);
	self notify("done speaking");
	self.customchatevent = undefined;
	self.var_2240 = undefined;
}

//Function Number: 62
func_6033(param_00,param_01)
{
	anim endon("battlechatter disabled");
	self endon("dog_attacks_ai");
	self endon("death");
	if(isdefined(param_01))
	{
	}

	if(battlechatter_canprint() || func_130C())
	{
		var_02 = [];
		foreach(var_04 in param_00.var_771D)
		{
			var_02[var_02.size] = var_04;
		}

		if(battlechatter_canprint())
		{
			battlechatter_print(var_02);
		}

		if(func_130C())
		{
			var_06 = self.var_219C.var_3034 + "_" + self.var_219C.eventtype;
			if(isdefined(self.var_219C.var_531F))
			{
				var_06 = var_06 + "_" + self.var_219C.var_531F;
			}

			thread func_1313(var_02,var_06);
		}
	}

	for(var_07 = 0;var_07 < param_00.var_771D.size;var_07++)
	{
		if(!self.battlechatter)
		{
			if(!func_47F4(self.var_219C))
			{
			}
			else
			{
			}
			else if(!func_198A(0))
			{
			}
			else if(self._animactive > 0)
			{
			}
			else if(func_48BE(self.var_219C.var_3034))
			{
				wait(0.85);
			}
			else if(!soundexists(param_00.var_771D[var_07]))
			{
			}
			else
			{
				var_08 = gettime();
				var_09 = spawn("script_origin",self gettagorigin("j_head"));
				var_09 linkto(self);
				thread func_7C4E(param_00.var_771D[var_07],var_09);
				if(param_00.var_50B4 && self.team == "allies")
				{
					thread maps\_anim::func_D5E(param_00.var_771D[var_07],param_00.looktarget);
					var_09 playsound(param_00.var_771D[var_07],param_00.var_771D[var_07],1);
					var_09 waittill(param_00.var_771D[var_07]);
					self notify(param_00.var_771D[var_07]);
				}
				else
				{
					thread maps\_anim::func_D5E(param_00.var_771D[var_07],param_00.looktarget);
					if(getdvarint("bcs_forceEnglish",0))
					{
						var_09 playsound(param_00.var_771D[var_07],param_00.var_771D[var_07],1);
					}
					else
					{
						var_09 playsound(param_00.var_771D[var_07],param_00.var_771D[var_07],1);
					}

					var_09 waittill(param_00.var_771D[var_07]);
					self notify(param_00.var_771D[var_07]);
				}

				var_09 delete();
				if(gettime() < var_08 + 250)
				{
				}
			}
		}
	}

	self notify("playPhrase_done");
	dotypelimit(self.var_219C.var_3034,self.var_219C.eventtype);
}

//Function Number: 63
func_7C4E(param_00,param_01)
{
	param_01 endon("death");
	common_scripts\utility::func_8B4F("death","dog_attacks_ai");
	param_01 stopsounds();
	common_scripts\utility::func_8AFE();
	param_01 notify(param_00);
	param_01 delete();
}

//Function Number: 64
func_47F4(param_00)
{
	if(!isdefined(param_00.var_3034) || !isdefined(param_00.eventtype))
	{
		return 0;
	}

	if(param_00.var_3034 == "reaction" && param_00.eventtype == "friendlyfire")
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
	func_1D43(param_00);
}

//Function Number: 66
func_1D43(param_00)
{
	self.var_4968 = 0;
	self.chatqueue[param_00].var_30A5 = 0;
	self.chatqueue[param_00].priority = 0;
	self.nextsaytimes[param_00] = gettime() + level.eventactionminwait[param_00]["self"];
}

//Function Number: 67
func_4ED4(param_00,param_01,param_02)
{
	anim endon("battlechatter disabled");
	var_03 = param_00.squad;
	var_04 = param_00.team;
	param_00.var_4968 = 1;
	param_00 thread isspeakingfailsafe(param_01);
	var_03.ismembersaying[param_01] = 1;
	var_03.numspeakers++;
	level.isteamspeaking[var_04] = 1;
	level.var_4985[var_04][param_01] = 1;
	var_05 = param_00 common_scripts\utility::func_8B33("death","done speaking","cancel speaking");
	var_03.ismembersaying[param_01] = 0;
	var_03.numspeakers--;
	level.isteamspeaking[var_04] = 0;
	level.var_4985[var_04][param_01] = 0;
	if(var_05 == "cancel speaking")
	{
	}

	level.var_4CC7[var_04] = gettime();
	if(isalive(param_00))
	{
		param_00 func_1D43(param_01);
	}

	var_03.nextsaytimes[param_01] = gettime() + level.eventactionminwait[param_01]["squad"];
}

//Function Number: 68
func_86DE(param_00,param_01)
{
	if(gettime() - self.var_7996[param_00].var_4C51 > 10000)
	{
		var_02 = 0;
		for(var_03 = 0;var_03 < self.var_51C5.size;var_03++)
		{
			if(self.var_51C5[var_03] != param_01 && isalive(self.var_51C5[var_03].enemy) && isdefined(self.var_51C5[var_03].enemy.squad) && self.var_51C5[var_03].enemy.squad.var_7998 == param_00)
			{
				var_02 = 1;
			}
		}

		if(!var_02)
		{
			self.var_7996[param_00].firstcontact = gettime();
			self.var_7996[param_00].var_195D = 0;
		}
	}

	self.var_7996[param_00].var_4C51 = gettime();
}

//Function Number: 69
func_19F2(param_00,param_01,param_02,param_03)
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

	if(isdefined(param_01) && func_855B(param_00,param_01))
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
func_3ACA()
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
func_3C27(param_00)
{
	var_01 = self.squad;
	var_02 = [];
	for(var_03 = 0;var_03 < var_01.var_51C5.size;var_03++)
	{
		if(isdefined(var_01.var_51C5[var_03].enemy) && var_01.var_51C5[var_03].enemy == param_00)
		{
			var_02[var_02.size] = var_01.var_51C5[var_03];
		}
	}

	if(!isdefined(var_02[0]))
	{
		return undefined;
	}

	var_04 = undefined;
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		if(var_02[var_03] func_19F2("response"))
		{
			return var_04;
		}
	}

	return common_scripts\utility::func_3A56(self.origin,var_02);
}

//Function Number: 72
func_3BAD()
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

		if(self.chatqueue[var_00[var_02]].var_30A5 == 0)
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

	if(gettime() > self.chatqueue[param_00].var_30A5)
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
func_48BE(param_00)
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
	if(!self.squad.ismembersaying[param_00] && !level.var_4985[self.team][param_00] && gettime() < self.chatqueue[param_00].var_30A5 && gettime() > self.squad.nextsaytimes[param_00])
	{
		if(!func_855B(param_00,self.chatqueue[param_00].eventtype))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 76
func_855B(param_00,param_01)
{
	if(!isdefined(level.eventtypeminwait[param_00][param_01]))
	{
		return 0;
	}

	if(!isdefined(self.squad.var_55FE[param_00][param_01]))
	{
		return 0;
	}

	if(gettime() > self.squad.var_55FE[param_00][param_01])
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
	}

	self.squad.var_55FE[param_00][param_01] = gettime() + level.eventtypeminwait[param_00][param_01];
}

//Function Number: 78
func_1337()
{
	if(isplayer(self))
	{
		return 0;
	}

	if(isexposed())
	{
		return 0;
	}

	return animscripts/utility::issniperrifle(self.weapon);
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

	if(!func_4919())
	{
		return 0;
	}

	return 1;
}

//Function Number: 80
func_4919()
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
func_7992(param_00)
{
	if(param_00.officercount > 0)
	{
		return 1;
	}

	return 0;
}

//Function Number: 82
func_4920()
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

	return animscripts/utility::func_3A52();
}

//Function Number: 84
enemy_team_name()
{
	if(self method_824E())
	{
		return 1;
	}

	return 0;
}

//Function Number: 85
func_3B38()
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
	var_02 = common_scripts\utility::func_3A56(self.origin,var_01);
	return var_02;
}

//Function Number: 88
getspeakers(param_00,param_01)
{
	var_02 = [];
	var_03 = function_016B(param_01);
	for(var_04 = 0;var_04 < var_03.size;var_04++)
	{
		if(var_03[var_04] == self)
		{
			continue;
		}

		if(!var_03[var_04] func_19F2(param_00))
		{
			continue;
		}

		var_02[var_02.size] = var_03[var_04];
	}

	return var_02;
}

//Function Number: 89
func_3BD4(param_00,param_01,param_02)
{
	var_03 = undefined;
	if(!isdefined(param_02))
	{
		param_02 = "response";
	}

	var_04 = common_scripts\utility::array_randomize(self.squad.var_51C5);
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

		if(func_4996(var_04[var_05]))
		{
			continue;
		}

		if(!var_04[var_05] func_19F2(param_02))
		{
			continue;
		}

		var_03 = var_04[var_05];
		if(func_19F3(var_03))
		{
			break;
		}
	}

	return var_03;
}

//Function Number: 90
getlocation()
{
	var_00 = func_37BF();
	var_00 = common_scripts\utility::array_randomize(var_00);
	if(var_00.size)
	{
		foreach(var_02 in var_00)
		{
			if(!func_4EBC(var_02))
			{
				return var_02;
			}
		}

		foreach(var_02 in var_00)
		{
			if(!func_4EBD(var_02))
			{
				return var_02;
			}
		}
	}

	return undefined;
}

//Function Number: 91
func_3C62(param_00)
{
	var_01 = func_37BF();
	var_01 = common_scripts\utility::array_randomize(var_01);
	if(var_01.size)
	{
		foreach(var_03 in var_01)
		{
			if(!func_4EBC(var_03) && param_00 cancalloutlocation(var_03))
			{
				return var_03;
			}
		}

		foreach(var_03 in var_01)
		{
			if(!func_4EBD(var_03) && param_00 cancalloutlocation(var_03))
			{
				return var_03;
			}
		}
	}

	return undefined;
}

//Function Number: 92
func_37BF()
{
	var_00 = level.bcs_locations;
	var_01 = self getistouchingentities(var_00);
	var_02 = [];
	foreach(var_04 in var_01)
	{
		if(isdefined(var_04.locationaliases))
		{
			var_02[var_02.size] = var_04;
		}
	}

	return var_02;
}

//Function Number: 93
func_8662()
{
	if(isdefined(level.bcs_locations))
	{
		anim.bcs_locations = common_scripts\utility::array_removeundefined(level.bcs_locations);
	}
}

//Function Number: 94
func_4804()
{
	var_00 = func_37BF();
	foreach(var_02 in var_00)
	{
		if(!func_4EBD(var_02))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 95
func_4EBC(param_00)
{
	var_01 = func_4EBF(param_00);
	if(!isdefined(var_01))
	{
		return 0;
	}

	return 1;
}

//Function Number: 96
func_4EBD(param_00)
{
	var_01 = func_4EBF(param_00);
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
func_4EBF(param_00)
{
	if(isdefined(level.locationlastcallouttimes[param_00.classname]))
	{
		return level.locationlastcallouttimes[param_00.classname];
	}

	return undefined;
}

//Function Number: 99
func_3BD0(param_00)
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
func_3A83(param_00,param_01,param_02)
{
	var_03 = vectortoangles(param_02);
	var_04 = vectortoangles(param_01 - param_00);
	var_05 = var_03[1] - var_04[1];
	var_05 = var_05 + 360;
	var_05 = castint(var_05) % 360;
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
func_567E(param_00)
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
func_3A85(param_00,param_01)
{
	var_02 = distance2d(param_00,param_01);
	var_03 = 0.0254 * var_02;
	return var_03;
}

//Function Number: 105
func_3A86(param_00,param_01)
{
	var_02 = func_3A85(param_00,param_01);
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
func_3AB8(param_00)
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
	var_03 = anglestoforward(param_00);
	var_04 = vectornormalize(var_03);
	var_05 = vectortoangles(var_04);
	var_06 = vectortoangles(param_02 - param_01);
	var_07 = var_05[1] - var_06[1];
	var_07 = var_07 + 360;
	var_07 = castint(var_07) % 360;
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

//Function Number: 108
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

//Function Number: 109
func_3C66(param_00)
{
	return (param_00[1],0 - param_00[0],param_00[2]);
}

//Function Number: 110
getvectorarrayaverage(param_00)
{
	var_01 = (0,0,0);
	for(var_02 = 0;var_02 < param_00.size;var_02++)
	{
		var_01 = var_01 + param_00[var_02];
	}

	return (var_01[0] / param_00.size,var_01[1] / param_00.size,var_01[2] / param_00.size);
}

//Function Number: 111
addconcattargetalias(param_00)
{
	var_01 = "";
	if(param_00 animscripts/utility::func_87FA())
	{
		var_01 = "_rpg";
	}
	else if(param_00 func_1337())
	{
		var_01 = "_sniper";
	}

	var_02 = self.owner.var_1F85 + "_" + self.owner.npcid + "_concat_target" + var_01;
	self.var_771D[self.var_771D.size] = var_02;
}

//Function Number: 112
addconcatdirectionalias(param_00,param_01)
{
	var_02 = common_scripts\utility::func_6306(["relative","absolute"]);
	switch(var_02)
	{
		case "absolute":
			var_03 = getdirectioncompass(level.player.origin,param_01.origin);
			var_04 = func_567E(var_03);
			if(var_04 != "impossible" && var_04.size != 2)
			{
				var_05 = self.owner.var_1F85 + "_" + self.owner.npcid + "_concat_dir_cmpss_" + var_04;
				self.var_771D[self.var_771D.size] = var_05;
				break;
			}
	
			break;

		case "relative":
			var_06 = func_3BD0(param_00);
			var_07 = getdirectionfacingclock(var_06,param_00.origin,param_01.origin);
			var_08 = castint(var_07);
			if(1 < var_08 && var_08 < 5 && common_scripts\utility::func_1DE9())
			{
				var_05 = self.owner.var_1F85 + "_" + self.owner.npcid + "_concat_dir_right";
				self.var_771D[self.var_771D.size] = var_05;
				break;
			}
			else if(7 < var_08 && var_08 < 11 && common_scripts\utility::func_1DE9())
			{
				var_05 = self.owner.var_1F85 + "_" + self.owner.npcid + "_concat_dir_left";
				self.var_771D[self.var_771D.size] = var_05;
				break;
			}
			else
			{
				var_05 = self.owner.var_1F85 + "_" + self.owner.npcid + "_concat_dir_clock_" + var_07;
				self.var_771D[self.var_771D.size] = var_05;
			}
			break;
	}
}

//Function Number: 113
addnamealias(param_00)
{
	self.var_771D[self.var_771D.size] = self.owner.var_1F85 + "_" + self.owner.npcid + "_name_" + param_00;
	level.var_4C81[self.owner.team] = param_00;
	level.var_4C82[self.owner.team] = gettime();
}

//Function Number: 114
addplayernamealias()
{
	if(!self.owner func_19F4())
	{
	}

	anim.var_4C89 = gettime();
	var_00 = self.owner.var_1F85 + "_" + self.owner.npcid + "_name_player_" + level.player.bccountryid + "_" + level.player.var_133A;
	self.var_771D[self.var_771D.size] = var_00;
	self.looktarget = level.player;
}

//Function Number: 115
addrankalias(param_00)
{
	self.var_771D[self.var_771D.size] = self.owner.var_1F85 + "_" + self.owner.npcid + "_rank_" + param_00;
}

//Function Number: 116
func_19F3(param_00)
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

	if(!isdefined(param_00.var_1F85))
	{
		return 0;
	}

	if(self.var_1F85 != param_00.var_1F85)
	{
		return 0;
	}

	if(func_5574(param_00))
	{
		return 0;
	}

	var_01 = self.var_1F85 + "_" + self.npcid + "_name_" + param_00.bcname;
	if(soundexists(var_01))
	{
		return 1;
	}

	return 0;
}

//Function Number: 117
func_5574(param_00)
{
	if(level.var_4C81[self.team] == param_00.bcname || gettime() - level.var_4C82[self.team] < level.var_4C83)
	{
		return 1;
	}

	return 0;
}

//Function Number: 118
func_19F4()
{
	if(enemy_team_name())
	{
		return 0;
	}

	if(!isdefined(level.player.var_133A) || !isdefined(level.player.bccountryid))
	{
		return 0;
	}

	if(player_name_called_recently())
	{
		return 0;
	}

	var_00 = self.var_1F85 + "_" + self.npcid + "_name_player_" + level.player.bccountryid + "_" + level.player.var_133A;
	if(soundexists(var_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 119
player_name_called_recently()
{
	if(!isdefined(level.var_4C89))
	{
		return 0;
	}

	if(gettime() - level.var_4C89 >= level.eventtypeminwait["playername"])
	{
		return 0;
	}

	return 1;
}

//Function Number: 120
func_4996(param_00)
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

//Function Number: 121
addthreatalias(param_00,param_01)
{
	var_02 = self.owner.var_1F85 + "_" + self.owner.npcid + "_threat_" + param_00;
	if(isdefined(param_01))
	{
		var_02 = var_02 + "_" + param_01;
	}

	self.var_771D = common_scripts\utility::array_add(self.var_771D,var_02);
	return 1;
}

//Function Number: 122
addthreatexposedalias(param_00)
{
	var_01 = self.owner.var_1F85 + "_" + self.owner.npcid + "_exposed_" + param_00;
	self.var_771D[self.var_771D.size] = var_01;
	return 1;
}

//Function Number: 123
addthreatobviousalias()
{
	var_00 = self.owner.var_1F85 + "_" + self.owner.npcid + "_order_action_suppress";
	self.var_771D[self.var_771D.size] = var_00;
	return 1;
}

//Function Number: 124
addthreatdistancealias(param_00)
{
	var_01 = self.owner.var_1F85 + "_" + self.owner.npcid + "_co_dist_" + param_00;
	self.var_771D[self.var_771D.size] = var_01;
	return 1;
}

//Function Number: 125
addthreatelevationalias(param_00)
{
	var_01 = self.owner.var_1F85 + "_" + self.owner.npcid + "_co_elev_" + param_00;
	self.var_771D[self.var_771D.size] = var_01;
	return 1;
}

//Function Number: 126
addthreatcalloutecho(param_00,param_01)
{
	var_02 = createechoalias(param_00,param_01);
	if(!soundexists(var_02))
	{
		return 0;
	}

	self.var_771D[self.var_771D.size] = var_02;
	return 1;
}

//Function Number: 127
addthreatcalloutresponsealias(param_00)
{
	var_01 = self.owner.var_1F85 + "_" + self.owner.npcid + "_resp_ack_co_gnrc_" + param_00;
	if(!soundexists(var_01))
	{
		return 0;
	}

	self.var_771D[self.var_771D.size] = var_01;
	return 1;
}

//Function Number: 128
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

	var_07 = self.owner.var_1F85 + "_" + self.owner.npcid + "_";
	var_08 = getsubstr(param_01,param_01.size - 1,param_01.size);
	var_09 = castint(var_08) + 1;
	var_0A = var_07 + "co_loc_" + var_03 + "_qa" + var_09;
	if(!soundexists(var_0A))
	{
		if(randomint(100) < level.eventchance["response"]["callout_negative"])
		{
			param_00 animscripts/battlechatter_ai::addresponseevent("callout","neg",self.owner,0.9);
		}
		else
		{
			param_00 animscripts/battlechatter_ai::addresponseevent("exposed","acquired",self.owner,0.9);
		}

		param_02.qafinished = 1;
		return 0;
	}

	param_00 animscripts/battlechatter_ai::addresponseevent("callout","QA",self.owner,0.9,var_0A,param_02);
	self.var_771D[self.var_771D.size] = var_0A;
	return 1;
}

//Function Number: 129
createechoalias(param_00,param_01)
{
	var_02 = "_report";
	var_03 = "_echo";
	var_04 = self.owner.var_1F85 + "_" + self.owner.npcid + "_";
	var_05 = param_00.size - var_02.size;
	var_06 = self.owner.var_1F85 + "_" + param_01.npcid + "_";
	var_07 = var_06.size;
	var_08 = getsubstr(param_00,var_07,var_05);
	var_09 = var_04 + var_08 + var_03;
	return var_09;
}

//Function Number: 130
addthreatcalloutalias(param_00,param_01)
{
	var_02 = self.owner.var_1F85 + "_" + self.owner.npcid + "_callout_" + param_00 + "_" + param_01;
	self.var_771D[self.var_771D.size] = var_02;
	return 1;
}

//Function Number: 131
addthreatcalloutlandmarkalias(param_00,param_01,param_02)
{
	var_03 = param_00.var_6C0C;
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	var_04 = self.owner.var_1F85 + "_" + self.owner.npcid + "_callout_obj_" + var_03;
	if(param_02)
	{
		var_04 = var_04 + "_y";
	}

	var_04 = var_04 + "_" + param_01;
	if(!soundexists(var_04))
	{
		return 0;
	}

	self.var_771D[self.var_771D.size] = var_04;
	return 1;
}

//Function Number: 132
addthreatcalloutlocationalias(param_00,param_01)
{
	var_02 = undefined;
	var_03 = param_00.locationaliases;
	var_04 = var_03[0];
	if(var_03.size > 1)
	{
		var_05 = undefined;
		var_05 = param_00 func_3A49(self.owner);
		if(isdefined(var_05))
		{
			var_04 = var_05;
		}
		else
		{
			var_04 = common_scripts\utility::func_6306(var_03);
		}
	}

	var_06 = undefined;
	if(isdefined(param_01) && param_01)
	{
		var_06 = self.owner getloccalloutalias("concat_loc_" + var_04);
	}
	else if(!isdefined(param_00.qafinished) && func_4892(var_04,self.owner))
	{
		var_06 = self.owner func_3BAB(var_04,0);
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
	self.var_771D[self.var_771D.size] = var_02;
	return 1;
}

//Function Number: 133
addinformalias(param_00,param_01)
{
	var_02 = self.owner.var_1F85 + "_" + self.owner.npcid + "_inform_" + param_00 + "_" + param_01;
	self.var_771D[self.var_771D.size] = var_02;
}

//Function Number: 134
addresponsealias(param_00,param_01)
{
	var_02 = self.owner.var_1F85 + "_" + self.owner.npcid + "_response_" + param_00 + "_" + param_01;
	self.var_771D[self.var_771D.size] = var_02;
	return 1;
}

//Function Number: 135
addreactionalias(param_00,param_01)
{
	var_02 = self.owner.var_1F85 + "_" + self.owner.npcid + "_reaction_" + param_00 + "_" + param_01;
	self.var_771D[self.var_771D.size] = var_02;
	return 1;
}

//Function Number: 136
addcheckfirealias()
{
	var_00 = self.owner.var_1F85 + "_" + self.owner.npcid + "_check_fire";
	self.var_771D[self.var_771D.size] = var_00;
	return 1;
}

//Function Number: 137
addtakingfirealias()
{
	var_00 = self.owner.var_1F85 + "_" + self.owner.npcid + "_inform_taking_fire";
	self.var_771D[self.var_771D.size] = var_00;
	return 1;
}

//Function Number: 138
addtauntalias(param_00,param_01)
{
	var_02 = self.owner.var_1F85 + "_" + self.owner.npcid + "_taunt";
	self.var_771D[self.var_771D.size] = var_02;
	return 1;
}

//Function Number: 139
addhostileburstalias()
{
	var_00 = self.owner.var_1F85 + "_" + self.owner.npcid + "_hostile_burst";
	self.var_771D[self.var_771D.size] = var_00;
	return 1;
}

//Function Number: 140
addorderalias(param_00,param_01)
{
	var_02 = self.owner.var_1F85 + "_" + self.owner.npcid + "_order_" + param_00 + "_" + param_01;
	self.var_771D[self.var_771D.size] = var_02;
	return 1;
}

//Function Number: 141
initcontact(param_00)
{
	if(!isdefined(self.var_7996[param_00].var_195D))
	{
		self.var_7996[param_00].var_195D = 0;
	}

	if(!isdefined(self.var_7996[param_00].firstcontact))
	{
		self.var_7996[param_00].firstcontact = 2000000000;
	}

	if(!isdefined(self.var_7996[param_00].var_4C51))
	{
		self.var_7996[param_00].var_4C51 = 0;
	}
}

//Function Number: 142
func_7535(param_00)
{
	self.var_7996[param_00].var_195D = undefined;
	self.var_7996[param_00].firstcontact = undefined;
	self.var_7996[param_00].var_4C51 = undefined;
}

//Function Number: 143
func_20CE(param_00,param_01,param_02)
{
	var_03 = addstruct();
	var_03.owner = self;
	var_03.eventtype = param_01;
	var_03.var_3034 = param_00;
	if(isdefined(param_02))
	{
		var_03.priority = param_02;
	}
	else
	{
		var_03.priority = level.eventpriority[param_00][param_01];
	}

	var_03.var_30A5 = gettime() + level.eventduration[param_00][param_01];
	return var_03;
}

//Function Number: 144
func_20CF()
{
	var_00 = addstruct();
	var_00.owner = self;
	var_00.var_771D = [];
	var_00.var_50B4 = 0;
	return var_00;
}

//Function Number: 145
func_608B(param_00)
{
	return common_scripts\utility::func_8E18(self.origin,self.angles,param_00,0.766);
}

//Function Number: 146
func_2F68(param_00)
{
	return common_scripts\utility::func_8E18(self.origin,self.angles,param_00.origin,0);
}

//Function Number: 147
squadflavorbursttransmissions()
{
	anim endon("battlechatter disabled");
	self endon("squad_deleting");
	if(self.team != "allies")
	{
	}

	while(self.var_51C0 <= 0)
	{
		wait(0.5);
	}

	wait(0.5);
	var_00 = 0;
	while(isdefined(self))
	{
		if(!func_798D(self))
		{
			var_00 = 1;
			wait(1);
			continue;
		}
		else if(self.fbt_firstburst)
		{
			if(!var_00)
			{
				wait(randomfloat(level.var_3202));
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
				wait(randomfloatrange(level.var_3202,level.var_3201));
			}

			if(var_00)
			{
				var_00 = 0;
			}
		}

		var_01 = func_3A47(self);
		if(!isdefined(var_01))
		{
			continue;
		}

		var_02 = var_01.voice;
		var_03 = getflavorburstid(self,var_02);
		var_04 = getflavorburstaliases(var_02,var_03);
		foreach(var_08, var_06 in var_04)
		{
			if(!var_01 candoflavorburst() || distance(level.player.origin,var_01.origin) > level.var_31FC)
			{
				for(var_07 = 0;var_07 < self.var_51C5.size;var_07++)
				{
					var_01 = func_3A47(self);
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

			thread func_6007(var_01,var_06);
			self waittill("burst_line_done");
			if(var_08 != var_04.size - 1)
			{
				wait(randomfloatrange(level.var_3200,level.var_31FF));
			}
		}
	}
}

//Function Number: 148
func_798D(param_00)
{
	var_01 = 0;
	foreach(var_03 in param_00.var_51C5)
	{
		if(var_03 candoflavorburst())
		{
			var_01 = 1;
			break;
		}
	}

	return var_01;
}

//Function Number: 149
candoflavorburst()
{
	var_00 = 0;
	if(!isplayer(self) && isalive(self) && self.classname != "actor_enemy_dog" && level.var_341A[self.team] && voicecanburst() && self.var_341A)
	{
		var_00 = 1;
	}

	return var_00;
}

//Function Number: 150
voicecanburst()
{
	if(isdefined(level.var_341E[self.voice]) && level.var_341E[self.voice])
	{
		return 1;
	}

	return 0;
}

//Function Number: 151
func_3A47(param_00)
{
	var_01 = undefined;
	var_02 = common_scripts\utility::get_array_of_farthest(level.player.origin,param_00.var_51C5);
	foreach(var_04 in var_02)
	{
		if(var_04 candoflavorburst())
		{
			var_01 = var_04;
			if(!isdefined(param_00.var_31FE))
			{
				break;
			}

			if(isdefined(param_00.var_31FE) && param_00.var_31FE == var_01.unique_id)
			{
				continue;
			}
		}
	}

	if(isdefined(var_01))
	{
		param_00.var_31FE = var_01.unique_id;
	}

	return var_01;
}

//Function Number: 152
getflavorburstid(param_00,param_01)
{
	var_02 = common_scripts\utility::array_randomize(level.var_341A[param_01]);
	if(level.var_341D.size >= var_02.size)
	{
		anim.var_341D = [];
	}

	var_03 = undefined;
	foreach(var_05 in var_02)
	{
		var_03 = var_05;
		if(!func_341F(var_03))
		{
			break;
		}
	}

	level.var_341D[level.var_341D.size] = var_03;
	return var_03;
}

//Function Number: 153
func_341F(param_00)
{
	if(!level.var_341D.size)
	{
		return 0;
	}

	var_01 = 0;
	foreach(var_03 in level.var_341D)
	{
		if(var_03 == param_00)
		{
			var_01 = 1;
			break;
		}
	}

	return var_01;
}

//Function Number: 154
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

//Function Number: 155
func_6007(param_00,param_01)
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

//Function Number: 156
func_3419(param_00,param_01)
{
	self endon("burst_line_done");
	wait(0.05);
}

//Function Number: 157
battlechatter_canprint()
{
	return 0;
}

//Function Number: 158
func_130C()
{
	return 0;
}

//Function Number: 159
battlechatter_print(param_00)
{
	if(param_00.size <= 0)
	{
	}

	if(!battlechatter_canprint())
	{
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

//Function Number: 160
func_1313(param_00,param_01)
{
}

//Function Number: 161
getaliastypefromsoundalias(param_00)
{
	var_01 = self.var_1F85 + "_" + self.npcid + "_";
	var_02 = getsubstr(param_00,var_01.size,param_00.size);
	return var_02;
}

//Function Number: 162
battlechatter_printdumpline(param_00,param_01,param_02)
{
	if(common_scripts\utility::flag(param_02))
	{
		common_scripts\utility::flag_wait(param_02);
	}

	common_scripts\utility::flag_set(param_02);
	common_scripts\utility::func_337C(param_02);
}

//Function Number: 163
func_1334()
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

		thread func_2A74("Location: " + var_02,level.bcs_locations[var_00] getorigin(),(0,0,8),(1,1,1));
	}
}

//Function Number: 164
func_2A74(param_00,param_01,param_02,param_03)
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

//Function Number: 165
func_2A73(param_00,param_01,param_02)
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
		var_04 = func_567E(var_04);
		var_05 = getdirectionfacingclock(level.player.angles,level.player.origin,var_03);
		var_06 = var_04 + ", " + var_05 + ":00";
		wait(0.05);
	}
}

//Function Number: 166
func_6610(param_00,param_01)
{
	var_02 = function_016B(param_00);
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

//Function Number: 167
voice_is_british_based()
{
	self endon("death");
	if(self.voice == "british")
	{
		return 1;
	}

	return 0;
}

//Function Number: 168
friendlyfire_warning()
{
	if(!func_198A())
	{
		return 0;
	}

	dotypelimit("reaction","friendlyfire");
	thread playreactionevent();
	return 1;
}

//Function Number: 169
func_198A(param_00)
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

	if(gettime() > self.chatqueue["reaction"].var_30A5)
	{
		return 0;
	}

	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(param_00)
	{
		if(isdefined(self.squad.var_55FE["reaction"]["friendlyfire"]))
		{
			if(gettime() < self.squad.var_55FE["reaction"]["friendlyfire"])
			{
				return 0;
			}
		}
	}

	return 1;
}