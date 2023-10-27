/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/gametypes/_quickmessages.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 7
 * Decompile Time: 113 ms
 * Timestamp: 10/27/2023 1:50:54 AM
*******************************************************************/

//Function Number: 1
init()
{
	game["menu_quickcommands"] = "quickcommands";
	game["menu_quickstatements"] = "quickstatements";
	game["menu_quickresponses"] = "quickresponses";
	precacheheadicon("talkingicon");
	precachestring(&"QUICKMESSAGE_FOLLOW_ME");
	precachestring(&"QUICKMESSAGE_MOVE_IN");
	precachestring(&"QUICKMESSAGE_FALL_BACK");
	precachestring(&"QUICKMESSAGE_SUPPRESSING_FIRE");
	precachestring(&"QUICKMESSAGE_ATTACK_LEFT_FLANK");
	precachestring(&"QUICKMESSAGE_ATTACK_RIGHT_FLANK");
	precachestring(&"QUICKMESSAGE_HOLD_THIS_POSITION");
	precachestring(&"QUICKMESSAGE_REGROUP");
	precachestring(&"QUICKMESSAGE_ENEMY_SPOTTED");
	precachestring(&"QUICKMESSAGE_ENEMIES_SPOTTED");
	precachestring(&"QUICKMESSAGE_IM_IN_POSITION");
	precachestring(&"QUICKMESSAGE_AREA_SECURE");
	precachestring(&"QUICKMESSAGE_GRENADE");
	precachestring(&"QUICKMESSAGE_SNIPER");
	precachestring(&"QUICKMESSAGE_NEED_REINFORCEMENTS");
	precachestring(&"QUICKMESSAGE_HOLD_YOUR_FIRE");
	precachestring(&"QUICKMESSAGE_YES_SIR");
	precachestring(&"QUICKMESSAGE_NO_SIR");
	precachestring(&"QUICKMESSAGE_IM_ON_MY_WAY");
	precachestring(&"QUICKMESSAGE_SORRY");
	precachestring(&"QUICKMESSAGE_GREAT_SHOT");
	precachestring(&"QUICKMESSAGE_TOOK_LONG_ENOUGH");
	precachestring(&"QUICKMESSAGE_ARE_YOU_CRAZY");
	precachestring(&"QUICKMESSAGE_WATCH_SIX");
	precachestring(&"QUICKMESSAGE_COME_ON");
}

//Function Number: 2
quickcommands(param_00)
{
	self endon("disconnect");
	if(!isdefined(self.pers["team"]) || self.pers["team"] == "spectator" || isdefined(self.spamdelay))
	{
		return;
	}

	self.spamdelay = 1;
	switch(param_00)
	{
		case "1":
			break;

		case "2":
			break;

		case "3":
			break;

		case "4":
			break;

		case "5":
			break;

		case "6":
			break;

		case "7":
			break;

		default:
			break;
	}
}

//Function Number: 3
quickstatements(param_00)
{
	if(!isdefined(self.pers["team"]) || self.pers["team"] == "spectator" || isdefined(self.spamdelay))
	{
		return;
	}

	self.spamdelay = 1;
	switch(param_00)
	{
		case "1":
			break;

		case "2":
			break;

		case "3":
			break;

		case "4":
			break;

		case "5":
			break;

		case "6":
			break;

		default:
			break;
	}
}

//Function Number: 4
quickresponses(param_00)
{
	if(!isdefined(self.pers["team"]) || self.pers["team"] == "spectator" || isdefined(self.spamdelay))
	{
		return;
	}

	self.spamdelay = 1;
	switch(param_00)
	{
		case "1":
			break;

		case "2":
			break;

		case "3":
			break;

		case "4":
			break;

		case "5":
			break;

		default:
			break;
	}
}

//Function Number: 5
doquickmessage(param_00,param_01)
{
	if(self.sessionstate != "playing")
	{
		return;
	}

	var_02 = maps\mp\gametypes\_teams::getteamvoiceprefix(self.team);
	if(isdefined(level.quickmessagetoall) && level.quickmessagetoall)
	{
		self.headiconteam = "none";
		self.headicon = "talkingicon";
		self playsound(var_02 + param_00);
		self sayteam(param_01);
		return;
	}

	if(self.sessionteam == "allies")
	{
		self.headiconteam = "allies";
	}
	else if(self.sessionteam == "axis")
	{
		self.headiconteam = "axis";
	}

	self.headicon = "talkingicon";
	self playsound(var_02 + param_00);
	self sayall(param_01);
	self pingplayer();
}

//Function Number: 6
saveheadicon()
{
	if(isdefined(self.headicon))
	{
		self.oldheadicon = self.headicon;
	}

	if(isdefined(self.headiconteam))
	{
		self.oldheadiconteam = self.headiconteam;
	}
}

//Function Number: 7
restoreheadicon()
{
	if(isdefined(self.oldheadicon))
	{
		self.headicon = self.oldheadicon;
	}

	if(isdefined(self.oldheadiconteam))
	{
		self.headiconteam = self.oldheadiconteam;
	}
}