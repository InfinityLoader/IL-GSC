/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_quickmessages.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

init()
{
	game["menu_quickcommands"] = "quickcommands";
	game["menu_quickstatements"] = "quickstatements";
	game["menu_quickresponses"] = "quickresponses";
	precachemenu(game["menu_quickcommands"]);
	precachemenu(game["menu_quickstatements"]);
	precachemenu(game["menu_quickresponses"]);
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

quickcommands(response)
{
	self endon("disconnect");
	if(!isdefined(self.pers["team"]) || self.pers["team"] == "spectator" || isdefined(self.spamdelay))
	{
		return;
	}

	self.spamdelay = 1;
	switch(response)
	{
		case "1":
			soundalias = "mp_cmd_followme";
			saytext = &"QUICKMESSAGE_FOLLOW_ME";
			break;

		case "2":
			soundalias = "mp_cmd_movein";
			saytext = &"QUICKMESSAGE_MOVE_IN";
			break;

		case "3":
			soundalias = "mp_cmd_fallback";
			saytext = &"QUICKMESSAGE_FALL_BACK";
			break;

		case "4":
			soundalias = "mp_cmd_suppressfire";
			saytext = &"QUICKMESSAGE_SUPPRESSING_FIRE";
			break;

		case "5":
			soundalias = "mp_cmd_attackleftflank";
			saytext = &"QUICKMESSAGE_ATTACK_LEFT_FLANK";
			break;

		case "6":
			soundalias = "mp_cmd_attackrightflank";
			saytext = &"QUICKMESSAGE_ATTACK_RIGHT_FLANK";
			break;

		case "7":
			soundalias = "mp_cmd_holdposition";
			saytext = &"QUICKMESSAGE_HOLD_THIS_POSITION";
			break;

		default:
			soundalias = "mp_cmd_regroup";
			saytext = &"QUICKMESSAGE_REGROUP";
			break;
	}

	saveheadicon();
	doquickmessage(soundalias, saytext);
	wait 2;
	self.spamdelay = undefined;
	restoreheadicon();
}

quickstatements(response)
{
	if(!isdefined(self.pers["team"]) || self.pers["team"] == "spectator" || isdefined(self.spamdelay))
	{
		return;
	}

	self.spamdelay = 1;
	switch(response)
	{
		case "1":
			soundalias = "mp_stm_enemyspotted";
			saytext = &"QUICKMESSAGE_ENEMY_SPOTTED";
			break;

		case "2":
			soundalias = "mp_stm_enemiesspotted";
			saytext = &"QUICKMESSAGE_ENEMIES_SPOTTED";
			break;

		case "3":
			soundalias = "mp_stm_iminposition";
			saytext = &"QUICKMESSAGE_IM_IN_POSITION";
			break;

		case "4":
			soundalias = "mp_stm_areasecure";
			saytext = &"QUICKMESSAGE_AREA_SECURE";
			break;

		case "5":
			soundalias = "mp_stm_watchsix";
			saytext = &"QUICKMESSAGE_WATCH_SIX";
			break;

		case "6":
			soundalias = "mp_stm_sniper";
			saytext = &"QUICKMESSAGE_SNIPER";
			break;

		default:
			soundalias = "mp_stm_needreinforcements";
			saytext = &"QUICKMESSAGE_NEED_REINFORCEMENTS";
			break;
	}

	saveheadicon();
	doquickmessage(soundalias, saytext);
	wait 2;
	self.spamdelay = undefined;
	restoreheadicon();
}

quickresponses(response)
{
	if(!isdefined(self.pers["team"]) || self.pers["team"] == "spectator" || isdefined(self.spamdelay))
	{
		return;
	}

	self.spamdelay = 1;
	switch(response)
	{
		case "1":
			soundalias = "mp_rsp_yessir";
			saytext = &"QUICKMESSAGE_YES_SIR";
			break;

		case "2":
			soundalias = "mp_rsp_nosir";
			saytext = &"QUICKMESSAGE_NO_SIR";
			break;

		case "3":
			soundalias = "mp_rsp_onmyway";
			saytext = &"QUICKMESSAGE_IM_ON_MY_WAY";
			break;

		case "4":
			soundalias = "mp_rsp_sorry";
			saytext = &"QUICKMESSAGE_SORRY";
			break;

		case "5":
			soundalias = "mp_rsp_greatshot";
			saytext = &"QUICKMESSAGE_GREAT_SHOT";
			break;

		default:
			soundalias = "mp_rsp_comeon";
			saytext = &"QUICKMESSAGE_COME_ON";
			break;
	}

	saveheadicon();
	doquickmessage(soundalias, saytext);
	wait 2;
	self.spamdelay = undefined;
	restoreheadicon();
}

doquickmessage(soundalias, saytext)
{
	if(self.sessionstate != "playing")
	{
		return;
	}

	prefix = maps\mp\gametypes\_teams::getteamvoiceprefix(self.team);
	if(isdefined(level.quickmessagetoall) && level.quickmessagetoall)
	{
		self.headiconteam = "none";
		self.headicon = "talkingicon";
		self playsound(prefix + soundalias);
		self sayall(saytext);
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
	self playsound(prefix + soundalias);
	self sayteam(saytext);
	self pingplayer();
}

saveheadicon()
{
	if(isdefined(self.headicon))
	{
		self.oldheadicon = self.headicon;
	}

	if(isdefined(self.headiconteam))
	{
		self.oldheadiconteam = self.headiconteam;
		return;
	}
}

restoreheadicon()
{
	if(isdefined(self.oldheadicon))
	{
		self.headicon = self.oldheadicon;
	}

	if(isdefined(self.oldheadiconteam))
	{
		self.headiconteam = self.oldheadiconteam;
		return;
	}
}