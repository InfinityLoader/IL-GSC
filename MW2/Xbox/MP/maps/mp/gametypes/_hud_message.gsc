/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_hud_message.gsc
 * Game: Call of Duty: Modern Warfare 2
 * Platform: Xbox
*******************************************************************/

init()
{
	precachestring(&"MP_FIRSTPLACE_NAME");
	precachestring(&"MP_SECONDPLACE_NAME");
	precachestring(&"MP_THIRDPLACE_NAME");
	precachestring(&"MP_MATCH_BONUS_IS");
	precachemenu("splash");
	precachemenu("challenge");
	precachemenu("defcon");
	precachemenu("killstreak");
	precachemenu("perk_display");
	precachemenu("perk_hide");
	precachemenu("killedby_card_display");
	precachemenu("killedby_card_hide");
	precachemenu("youkilled_card_display");
	game["menu_endgameupdate"] = "endgameupdate";
	if(level.splitscreen)
	{
		game["menu_endgameupdate"] = game["menu_endgameupdate"] + "_splitscreen";
	}

	precachemenu(game["menu_endgameupdate"]);
	game["strings"]["draw"] = &"MP_DRAW";
	game["strings"]["round_draw"] = &"MP_ROUND_DRAW";
	game["strings"]["round_win"] = &"MP_ROUND_WIN";
	game["strings"]["round_loss"] = &"MP_ROUND_LOSS";
	game["strings"]["victory"] = &"MP_VICTORY";
	game["strings"]["defeat"] = &"MP_DEFEAT";
	game["strings"]["halftime"] = &"MP_HALFTIME";
	game["strings"]["overtime"] = &"MP_OVERTIME";
	game["strings"]["roundend"] = &"MP_ROUNDEND";
	game["strings"]["intermission"] = &"MP_INTERMISSION";
	game["strings"]["side_switch"] = &"MP_SWITCHING_SIDES";
	game["strings"]["match_bonus"] = &"MP_MATCH_BONUS_IS";
	level thread onplayerconnect();
}

onplayerconnect()
{
	for(;;)
	{
		level waittill("connected", player);
		player thread hintmessagedeaththink();
		player thread lowermessagethink();
		player thread initnotifymessage();
	}
}

hintmessage(hinttext)
{
	notifydata = spawnstruct();
	notifydata.notifytext = hinttext;
	notifydata.glowcolor = (0.3,0.6,0.3);
	notifymessage(notifydata);
}

initnotifymessage()
{
	if(level.splitscreen)
	{
		titlesize = 2;
		textsize = 1.5;
		iconsize = 24;
		font = "default";
		point = "TOP";
		relativepoint = "BOTTOM";
		yoffset = 30;
		xoffset = 0;
	}
	else
	{
		titlesize = 2.5;
		textsize = 1.75;
		iconsize = 30;
		font = "objective";
		point = "TOP";
		relativepoint = "BOTTOM";
		yoffset = 50;
		xoffset = 0;
	}

	self.notifytitle = maps\mp\gametypes\_hud_util::createfontstring(font, titlesize);
	self.notifytitle maps\mp\gametypes\_hud_util::setpoint(point, undefined, xoffset, yoffset);
	self.notifytitle.glowcolor = (0.2,0.3,0.7);
	self.notifytitle.glowalpha = 1;
	self.notifytitle.hidewheninmenu = 1;
	self.notifytitle.archived = 0;
	self.notifytitle.alpha = 0;
	self.notifytext = maps\mp\gametypes\_hud_util::createfontstring(font, textsize);
	self.notifytext maps\mp\gametypes\_hud_util::setparent(self.notifytitle);
	self.notifytext maps\mp\gametypes\_hud_util::setpoint(point, relativepoint, 0, 0);
	self.notifytext.glowcolor = (0.2,0.3,0.7);
	self.notifytext.glowalpha = 1;
	self.notifytext.hidewheninmenu = 1;
	self.notifytext.archived = 0;
	self.notifytext.alpha = 0;
	self.notifytext2 = maps\mp\gametypes\_hud_util::createfontstring(font, textsize);
	self.notifytext2 maps\mp\gametypes\_hud_util::setparent(self.notifytitle);
	self.notifytext2 maps\mp\gametypes\_hud_util::setpoint(point, relativepoint, 0, 0);
	self.notifytext2.glowcolor = (0.2,0.3,0.7);
	self.notifytext2.glowalpha = 1;
	self.notifytext2.hidewheninmenu = 1;
	self.notifytext2.archived = 0;
	self.notifytext2.alpha = 0;
	self.notifyicon = maps\mp\gametypes\_hud_util::createicon("white", iconsize, iconsize);
	self.notifyicon maps\mp\gametypes\_hud_util::setparent(self.notifytext2);
	self.notifyicon maps\mp\gametypes\_hud_util::setpoint(point, relativepoint, 0, 0);
	self.notifyicon.hidewheninmenu = 1;
	self.notifyicon.archived = 0;
	self.notifyicon.alpha = 0;
	self.notifyoverlay = maps\mp\gametypes\_hud_util::createicon("white", iconsize, iconsize);
	self.notifyoverlay maps\mp\gametypes\_hud_util::setparent(self.notifyicon);
	self.notifyoverlay maps\mp\gametypes\_hud_util::setpoint("CENTER", "CENTER", 0, 0);
	self.notifyoverlay.hidewheninmenu = 1;
	self.notifyoverlay.archived = 0;
	self.notifyoverlay.alpha = 0;
	self.doingsplash = [];
	self.doingsplash[0] = undefined;
	self.doingsplash[1] = undefined;
	self.doingsplash[2] = undefined;
	self.doingsplash[3] = undefined;
	self.splashqueue = [];
	self.splashqueue[0] = [];
	self.splashqueue[1] = [];
	self.splashqueue[2] = [];
	self.splashqueue[3] = [];
}

oldnotifymessage(titletext, notifytext, iconname, glowcolor, sound, duration)
{
	notifydata = spawnstruct();
	notifydata.titletext = titletext;
	notifydata.notifytext = notifytext;
	notifydata.iconname = iconname;
	notifydata.glowcolor = glowcolor;
	notifydata.sound = sound;
	notifydata.duration = duration;
	notifymessage(notifydata);
}

notifymessage(notifydata)
{
	self endon("death");
	self endon("disconnect");
	if(!isdefined(notifydata.slot))
	{
		notifydata.slot = 0;
	}

	slot = notifydata.slot;
	if(!isdefined(notifydata.type))
	{
		notifydata.type = "";
	}

	if(!isdefined(self.doingsplash[slot]))
	{
		thread shownotifymessage(notifydata);
		return;
	}

	self.splashqueue[slot][self.splashqueue[slot].size] = notifydata;
}

dispatchnotify(slot)
{
	nextnotifydata = self.splashqueue[slot][0];
	for(i = 1;i < self.splashqueue[slot].size;i++)
	{
		self.splashqueue[slot][i - 1] = self.splashqueue[slot][i];
	}

	self.splashqueue[slot][i - 1] = undefined;
	if(isdefined(nextnotifydata.name))
	{
		actionnotify(nextnotifydata);
		return;
	}

	shownotifymessage(nextnotifydata);
}

promotionsplashnotify()
{
	self endon("disconnect");
	actiondata = spawnstruct();
	actiondata.name = "promotion";
	actiondata.type = "rank";
	actiondata.sound = "mp_level_up";
	actiondata.slot = 0;
	thread actionnotify(actiondata);
}

shownotifymessage(notifydata)
{
	self endon("disconnect");
	slot = notifydata.slot;
	if(level.gameended)
	{
		if(isdefined(notifydata.type) && notifydata.type == "rank")
		{
			self setclientdvar("ui_promotion", 1);
			self.postgamepromotion = 1;
		}

		if(self.splashqueue[slot].size)
		{
			thread dispatchnotify(slot);
		}

		return;
	}

	self.doingsplash[slot] = notifydata;
	waitrequirevisibility(0);
	if(isdefined(notifydata.duration))
	{
		duration = notifydata.duration;
	}
	else if(level.gameended)
	{
		duration = 2;
	}
	else
	{
		duration = 4;
	}

	thread resetoncancel();
	if(isdefined(notifydata.sound))
	{
		self playlocalsound(notifydata.sound);
	}

	if(isdefined(notifydata.leadersound))
	{
		maps\mp\_utility::leaderdialogonplayer(notifydata.leadersound);
	}

	if(isdefined(notifydata.glowcolor))
	{
		glowcolor = notifydata.glowcolor;
	}
	else
	{
		glowcolor = (0.3,0.6,0.3);
	}

	anchorelem = self.notifytitle;
	if(isdefined(notifydata.titletext))
	{
		if(isdefined(notifydata.titlelabel))
		{
			self.notifytitle.label = notifydata.titlelabel;
		}
		else
		{
			self.notifytitle.label = &"";
		}

		if(isdefined(notifydata.titlelabel) && !isdefined(notifydata.titleisstring))
		{
			self.notifytitle setvalue(notifydata.titletext);
		}
		else
		{
			self.notifytitle settext(notifydata.titletext);
		}

		self.notifytitle setpulsefx(int(25 * duration), int(duration * 1000), 1000);
		self.notifytitle.glowcolor = glowcolor;
		self.notifytitle.alpha = 1;
	}

	if(isdefined(notifydata.textglowcolor))
	{
		glowcolor = notifydata.textglowcolor;
	}

	if(isdefined(notifydata.notifytext))
	{
		if(isdefined(notifydata.textlabel))
		{
			self.notifytext.label = notifydata.textlabel;
		}
		else
		{
			self.notifytext.label = &"";
		}

		if(isdefined(notifydata.textlabel) && !isdefined(notifydata.textisstring))
		{
			self.notifytext setvalue(notifydata.notifytext);
		}
		else
		{
			self.notifytext settext(notifydata.notifytext);
		}

		self.notifytext setpulsefx(100, int(duration * 1000), 1000);
		self.notifytext.glowcolor = glowcolor;
		self.notifytext.alpha = 1;
		anchorelem = self.notifytext;
	}

	if(isdefined(notifydata.notifytext2))
	{
		self.notifytext2 maps\mp\gametypes\_hud_util::setparent(anchorelem);
		if(isdefined(notifydata.text2label))
		{
			self.notifytext2.label = notifydata.text2label;
		}
		else
		{
			self.notifytext2.label = &"";
		}

		self.notifytext2 settext(notifydata.notifytext2);
		self.notifytext2 setpulsefx(100, int(duration * 1000), 1000);
		self.notifytext2.glowcolor = glowcolor;
		self.notifytext2.alpha = 1;
		anchorelem = self.notifytext2;
	}

	if(isdefined(notifydata.iconname))
	{
		self.notifyicon maps\mp\gametypes\_hud_util::setparent(anchorelem);
		self.notifyicon setshader(notifydata.iconname, 60, 60);
		self.notifyicon.alpha = 0;
		if(isdefined(notifydata.iconoverlay))
		{
			self.notifyicon fadeovertime(0.15);
			self.notifyicon.alpha = 1;
			notifydata.overlayoffsety = 0;
			self.notifyoverlay maps\mp\gametypes\_hud_util::setparent(self.notifyicon);
			self.notifyoverlay maps\mp\gametypes\_hud_util::setpoint("CENTER", "CENTER", 0, notifydata.overlayoffsety);
			self.notifyoverlay setshader(notifydata.iconoverlay, 512, 512);
			self.notifyoverlay.alpha = 0;
			self.notifyoverlay.color = (1,0,0);
			self.notifyoverlay fadeovertime(0.4);
			self.notifyoverlay.alpha = 0.85;
			self.notifyoverlay scaleovertime(0.4, 32, 32);
			waitrequirevisibility(duration);
			self.notifyicon fadeovertime(0.75);
			self.notifyicon.alpha = 0;
			self.notifyoverlay fadeovertime(0.75);
			self.notifyoverlay.alpha = 0;
		}
		else
		{
			self.notifyicon fadeovertime(1);
			self.notifyicon.alpha = 1;
			waitrequirevisibility(duration);
			self.notifyicon fadeovertime(0.75);
			self.notifyicon.alpha = 0;
		}
	}
	else
	{
		waitrequirevisibility(duration);
	}

	self notify("notifyMessageDone");
	self.doingsplash[slot] = undefined;
	if(self.splashqueue[slot].size)
	{
		thread dispatchnotify(slot);
		return;
	}
}

killstreaksplashnotify(streakname, streakval, param_560)
{
	self endon("disconnect");
	waittillframeend;
	if(level.gameended)
	{
		return;
	}

	actiondata = spawnstruct();
	if(isdefined(param_560))
	{
		actiondata.name = streakname + "_" + param_560;
	}
	else
	{
		actiondata.name = streakname;
	}

	actiondata.type = "killstreak";
	actiondata.optionalnumber = streakval;
	actiondata.sound = maps\mp\killstreaks\_killstreaks::getkillstreaksound(streakname);
	actiondata.leadersound = streakname;
	actiondata.leadersoundgroup = "killstreak_earned";
	actiondata.slot = 0;
	thread actionnotify(actiondata);
}

defconsplashnotify(param_563, param_564)
{
}

challengesplashnotify(challengeref)
{
	self endon("disconnect");
	waittillframeend;
	wait 0.05;
	challengestate = self getplayerdata("challengeState", challengeref) - 1;
	challengetarget = int(tablelookup("mp/allChallengesTable.csv", 0, challengeref, 6 + challengestate - 1 * 2));
	if(challengetarget == 0)
	{
		challengetarget = 1;
	}

	if(issubstr(challengeref, "marathon") || issubstr(challengeref, "lightweight"))
	{
		challengetarget = int(challengetarget / 5280);
	}

	actiondata = spawnstruct();
	actiondata.type = "challenge";
	actiondata.optionalnumber = challengetarget;
	actiondata.name = challengeref;
	actiondata.sound = tablelookup("mp/splashTable.csv", 0, actiondata.name, 9);
	actiondata.slot = 0;
	thread actionnotify(actiondata);
}

splashnotify(text, optionalnumber)
{
	self endon("disconnect");
	wait 0.05;
	actiondata = spawnstruct();
	actiondata.name = text;
	actiondata.optionalnumber = optionalnumber;
	actiondata.sound = tablelookup("mp/splashTable.csv", 0, actiondata.name, 9);
	actiondata.slot = 0;
	thread actionnotify(actiondata);
}

splashnotifydelayed(text, optionalnumber)
{
	if(level.hardcoremode)
	{
		return;
	}

	self endon("disconnect");
	waittillframeend;
	if(level.gameended)
	{
		return;
	}

	actiondata = spawnstruct();
	actiondata.name = text;
	actiondata.optionalnumber = optionalnumber;
	actiondata.sound = tablelookup("mp/splashTable.csv", 0, actiondata.name, 9);
	actiondata.slot = 0;
	thread actionnotify(actiondata);
}

playercardsplashnotify(splashref, player, optionalnumber)
{
	self endon("disconnect");
	waittillframeend;
	if(level.gameended)
	{
		return;
	}

	actiondata = spawnstruct();
	actiondata.name = splashref;
	actiondata.optionalnumber = optionalnumber;
	actiondata.sound = tablelookup("mp/splashTable.csv", 0, actiondata.name, 9);
	actiondata.playercardplayer = player;
	actiondata.slot = 1;
	thread actionnotify(actiondata);
}

actionnotify(actiondata)
{
	self endon("death");
	self endon("disconnect");
	slot = actiondata.slot;
	if(!isdefined(actiondata.type))
	{
		actiondata.type = "";
	}

	if(!isdefined(self.doingsplash[slot]))
	{
		thread actionnotifymessage(actiondata);
		return;
	}

	if(actiondata.type == "killstreak" && self.doingsplash[slot].type != "challenge" && self.doingsplash[slot].type != "rank")
	{
		self.notifytext.alpha = 0;
		self.notifytext2.alpha = 0;
		self.notifyicon.alpha = 0;
		thread actionnotifymessage(actiondata);
		return;
	}

	if(actiondata.type == "challenge" && self.doingsplash[slot].type != "killstreak" && self.doingsplash[slot].type != "challenge" && self.doingsplash[slot].type != "rank")
	{
		self.notifytext.alpha = 0;
		self.notifytext2.alpha = 0;
		self.notifyicon.alpha = 0;
		thread actionnotifymessage(actiondata);
		return;
	}

	if(actiondata.type == "challenge" || actiondata.type == "killstreak")
	{
		if(actiondata.type == "killstreak")
		{
			removetypefromqueue("killstreak", slot);
		}

		for(i = self.splashqueue[slot].size;i > 0;i--)
		{
			self.splashqueue[slot][i] = self.splashqueue[slot][i - 1];
		}

		self.splashqueue[slot][0] = actiondata;
		return;
	}

	self.splashqueue[slot][self.splashqueue[slot].size] = actiondata;
}

removetypefromqueue(actiontype, slot)
{
	newqueue = [];
	for(i = 0;i < self.splashqueue[slot].size;i++)
	{
		if(self.splashqueue[slot][i].type != "killstreak")
		{
			newqueue[newqueue.size] = self.splashqueue[slot][i];
		}
	}

	self.splashqueue[slot] = newqueue;
}

actionnotifymessage(actiondata)
{
	self endon("disconnect");
	slot = actiondata.slot;
	if(level.gameended)
	{
		wait 0;
		if(isdefined(actiondata.type) && actiondata.type == "rank")
		{
			self setclientdvar("ui_promotion", 1);
			self.postgamepromotion = 1;
		}
		else if(isdefined(actiondata.type) && actiondata.type == "challenge")
		{
			self.pers["postGameChallenges"]++;
			self setclientdvar("ui_challenge_" + self.pers["postGameChallenges"] + "_ref", actiondata.name);
		}

		if(self.splashqueue[slot].size)
		{
			thread dispatchnotify(slot);
		}

		return;
	}

	if(tablelookup("mp/splashTable.csv", 0, actiondata.name, 0) != "")
	{
		if(isdefined(actiondata.playercardplayer))
		{
			self setcarddisplayslot(actiondata.playercardplayer, 5);
		}

		if(isdefined(actiondata.optionalnumber))
		{
			self showhudsplash(actiondata.name, actiondata.slot, actiondata.optionalnumber);
		}
		else
		{
			self showhudsplash(actiondata.name, actiondata.slot);
		}

		self.doingsplash[slot] = actiondata;
		duration = maps\mp\_utility::stringtofloat(tablelookup("mp/splashTable.csv", 0, actiondata.name, 4));
		if(isdefined(actiondata.sound))
		{
			self playlocalsound(actiondata.sound);
		}

		if(isdefined(actiondata.leadersound))
		{
			if(isdefined(actiondata.leadersoundgroup))
			{
				maps\mp\_utility::leaderdialogonplayer(actiondata.leadersound, actiondata.leadersoundgroup, 1);
			}
			else
			{
				maps\mp\_utility::leaderdialogonplayer(actiondata.leadersound);
			}
		}

		self notify("actionNotifyMessage" + slot);
		self endon("actionNotifyMessage" + slot);
		wait duration - 0.05;
		self.doingsplash[slot] = undefined;
	}

	if(self.splashqueue[slot].size)
	{
		thread dispatchnotify(slot);
		return;
	}
}

waitrequirevisibility(waittime)
{
	interval = 0.05;
	while(!canreadtext())
	{
		wait interval;
	}

	while(waittime > 0)
	{
		wait interval;
		if(canreadtext())
		{
			waittime = waittime - interval;
		}
	}
}

canreadtext()
{
	if(maps\mp\_flashgrenades::isflashbanged())
	{
		return 0;
	}

	return 1;
}

resetondeath()
{
	self endon("notifyMessageDone");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("death");
	resetnotify();
}

resetoncancel()
{
	self notify("resetOnCancel");
	self endon("resetOnCancel");
	self endon("notifyMessageDone");
	self endon("disconnect");
	level waittill("cancel_notify");
	resetnotify();
}

resetnotify()
{
	self.notifytitle.alpha = 0;
	self.notifytext.alpha = 0;
	self.notifyicon.alpha = 0;
	self.notifyoverlay.alpha = 0;
	self.doingsplash[0] = undefined;
	self.doingsplash[1] = undefined;
	self.doingsplash[2] = undefined;
	self.doingsplash[3] = undefined;
}

hintmessagedeaththink()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("death");
		if(isdefined(self.hintmessage))
		{
			self.hintmessage maps\mp\gametypes\_hud_util::destroyelem();
		}
	}
}

lowermessagethink()
{
	self endon("disconnect");
	self.lowermessages = [];
	self.lowermessage = maps\mp\gametypes\_hud_util::createfontstring("default", level.lowertextfontsize);
	self.lowermessage maps\mp\gametypes\_hud_util::setpoint("CENTER", level.lowertextyalign, 0, level.lowertexty);
	self.lowermessage settext("");
	self.lowermessage.archived = 0;
	self.lowermessage.sort = 10;
	timerfontsize = 0.75;
	if(level.splitscreen)
	{
		timerfontsize = 0.5;
	}

	self.lowertimer = maps\mp\gametypes\_hud_util::createfontstring("hudbig", timerfontsize);
	self.lowertimer maps\mp\gametypes\_hud_util::setparent(self.lowermessage);
	self.lowertimer maps\mp\gametypes\_hud_util::setpoint("TOP", "BOTTOM", 0, 0);
	self.lowertimer settext("");
	self.lowertimer.archived = 0;
	self.lowertimer.sort = 10;
}

outcomeoverlay(winner)
{
	if(level.teambased)
	{
		if(winner == "tie")
		{
			matchoutcomenotify("draw");
			return;
		}

		if(winner == self.team)
		{
			matchoutcomenotify("victory");
			return;
		}

		matchoutcomenotify("defeat");
		return;
	}

	if(winner == self)
	{
		matchoutcomenotify("victory");
		return;
	}

	matchoutcomenotify("defeat");
}

matchoutcomenotify(param_56F)
{
	team = self.team;
	outcometitle = maps\mp\gametypes\_hud_util::createfontstring("bigfixed", 1);
	outcometitle maps\mp\gametypes\_hud_util::setpoint("TOP", undefined, 0, 50);
	outcometitle.foreground = 1;
	outcometitle.glowalpha = 1;
	outcometitle.hidewheninmenu = 0;
	outcometitle.archived = 0;
	outcometitle settext(game["strings"][param_56F]);
	outcometitle.alpha = 0;
	outcometitle fadeovertime(0.5);
	outcometitle.alpha = 1;
	switch(param_56F)
	{
		case "victory":
			outcometitle.glowcolor = (0.6,0.9,0.6);
			break;

		default:
			outcometitle.glowcolor = (0.9,0.6,0.6);
			break;
	}

	centericon = maps\mp\gametypes\_hud_util::createicon(game["icons"][team], 64, 64);
	centericon maps\mp\gametypes\_hud_util::setparent(outcometitle);
	centericon maps\mp\gametypes\_hud_util::setpoint("TOP", "BOTTOM", 0, 30);
	centericon.foreground = 1;
	centericon.hidewheninmenu = 0;
	centericon.archived = 0;
	centericon.alpha = 0;
	centericon fadeovertime(0.5);
	centericon.alpha = 1;
	wait 3;
	outcometitle maps\mp\gametypes\_hud_util::destroyelem();
	centericon maps\mp\gametypes\_hud_util::destroyelem();
}

isdoingsplash()
{
	if(isdefined(self.doingsplash[0]))
	{
		return 1;
	}

	if(isdefined(self.doingsplash[1]))
	{
		return 1;
	}

	if(isdefined(self.doingsplash[2]))
	{
		return 1;
	}

	if(isdefined(self.doingsplash[3]))
	{
		return 1;
	}

	return 0;
}

teamoutcomenotify(winner, param_572, param_573)
{
	self endon("disconnect");
	self notify("reset_outcome");
	wait 0.5;
	team = self.pers["team"];
	if(!isdefined(team) || team != "allies" && team != "axis")
	{
		team = "allies";
	}

	while(isdoingsplash())
	{
		wait 0.05;
	}

	self endon("reset_outcome");
	if(level.splitscreen)
	{
		titlesize = 1;
		titleoffset = -76;
		textsize = 0.667;
		textoffset = 12;
		numbersize = 0.833;
		iconsize = 46;
		iconspacingh = 40;
		iconspacing = 30;
		scorespacing = 0;
		bonusspacing = 60;
		font = "hudbig";
	}
	else
	{
		titlesize = 1.5;
		titleoffset = -134;
		textsize = 1;
		textoffset = 18;
		numbersize = 1.25;
		iconsize = 70;
		iconspacingh = 60;
		iconspacing = 45;
		scorespacing = 0;
		bonusspacing = 90;
		font = "hudbig";
	}

	duration = -5536;
	outcometitle = maps\mp\gametypes\_hud_util::createfontstring(font, titlesize);
	outcometitle maps\mp\gametypes\_hud_util::setpoint("CENTER", undefined, 0, titleoffset);
	outcometitle.foreground = 1;
	outcometitle.glowalpha = 1;
	outcometitle.hidewheninmenu = 0;
	outcometitle.archived = 0;
	outcometext = maps\mp\gametypes\_hud_util::createfontstring(font, textsize);
	outcometext maps\mp\gametypes\_hud_util::setparent(outcometitle);
	outcometext.foreground = 1;
	outcometext maps\mp\gametypes\_hud_util::setpoint("TOP", "BOTTOM", 0, textoffset);
	outcometext.glowalpha = 1;
	outcometext.hidewheninmenu = 0;
	outcometext.archived = 0;
	if(winner == "halftime")
	{
		outcometitle.glowcolor = (0.2,0.3,0.7);
		outcometitle settext(game["strings"]["halftime"]);
		outcometitle.color = (1,1,1);
		winner = "allies";
	}
	else if(winner == "intermission")
	{
		outcometitle.glowcolor = (0.2,0.3,0.7);
		outcometitle settext(game["strings"]["intermission"]);
		outcometitle.color = (1,1,1);
		winner = "allies";
	}
	else if(winner == "roundend")
	{
		outcometitle.glowcolor = (0.2,0.3,0.7);
		outcometitle settext(game["strings"]["roundend"]);
		outcometitle.color = (1,1,1);
		winner = "allies";
	}
	else if(winner == "overtime")
	{
		outcometitle.glowcolor = (0.2,0.3,0.7);
		outcometitle settext(game["strings"]["overtime"]);
		outcometitle.color = (1,1,1);
		winner = "allies";
	}
	else if(winner == "tie")
	{
		outcometitle.glowcolor = (0.2,0.3,0.7);
		if(param_572)
		{
			outcometitle settext(game["strings"]["round_draw"]);
		}
		else
		{
			outcometitle settext(game["strings"]["draw"]);
		}

		outcometitle.color = (1,1,1);
		winner = "allies";
	}
	else if(isdefined(self.pers["team"]) && winner == team)
	{
		outcometitle.glowcolor = (0,0,0);
		if(param_572)
		{
			outcometitle settext(game["strings"]["round_win"]);
		}
		else
		{
			outcometitle settext(game["strings"]["victory"]);
		}

		outcometitle.color = (0.6,0.9,0.6);
	}
	else
	{
		outcometitle.glowcolor = (0,0,0);
		if(param_572)
		{
			outcometitle settext(game["strings"]["round_loss"]);
		}
		else
		{
			outcometitle settext(game["strings"]["defeat"]);
		}

		outcometitle.color = (0.7,0.3,0.2);
	}

	outcometext.glowcolor = (0.2,0.3,0.7);
	outcometext settext(param_573);
	outcometitle setpulsefx(100, duration, 1000);
	outcometext setpulsefx(100, duration, 1000);
	if(maps\mp\_utility::getintproperty("useRelativeTeamColors", 0))
	{
		lefticon = maps\mp\gametypes\_hud_util::createicon(game["icons"][team] + "_blue", iconsize, iconsize);
	}
	else
	{
		lefticon = maps\mp\gametypes\_hud_util::createicon(game["icons"][team], iconsize, iconsize);
	}

	lefticon maps\mp\gametypes\_hud_util::setparent(outcometext);
	lefticon maps\mp\gametypes\_hud_util::setpoint("TOP", "BOTTOM", iconspacingh * -1, iconspacing);
	lefticon.foreground = 1;
	lefticon.hidewheninmenu = 0;
	lefticon.archived = 0;
	lefticon.alpha = 0;
	lefticon fadeovertime(0.5);
	lefticon.alpha = 1;
	if(maps\mp\_utility::getintproperty("useRelativeTeamColors", 0))
	{
		righticon = maps\mp\gametypes\_hud_util::createicon(game["icons"][level.otherteam[team]] + "_red", iconsize, iconsize);
	}
	else
	{
		righticon = maps\mp\gametypes\_hud_util::createicon(game["icons"][level.otherteam[team]], iconsize, iconsize);
	}

	righticon maps\mp\gametypes\_hud_util::setparent(outcometext);
	righticon maps\mp\gametypes\_hud_util::setpoint("TOP", "BOTTOM", iconspacingh, iconspacing);
	righticon.foreground = 1;
	righticon.hidewheninmenu = 0;
	righticon.archived = 0;
	righticon.alpha = 0;
	righticon fadeovertime(0.5);
	righticon.alpha = 1;
	leftscore = maps\mp\gametypes\_hud_util::createfontstring(font, numbersize);
	leftscore maps\mp\gametypes\_hud_util::setparent(lefticon);
	leftscore maps\mp\gametypes\_hud_util::setpoint("TOP", "BOTTOM", 0, scorespacing);
	if(maps\mp\_utility::getintproperty("useRelativeTeamColors", 0))
	{
		leftscore.glowcolor = game["colors"]["blue"];
	}
	else
	{
		leftscore.glowcolor = game["colors"][team];
	}

	leftscore.glowalpha = 1;
	if(!maps\mp\_utility::isroundbased() || !maps\mp\_utility::isobjectivebased())
	{
		leftscore setvalue(maps\mp\gametypes\_gamescore::_getteamscore(team));
	}
	else
	{
		leftscore setvalue(game["roundsWon"][team]);
	}

	leftscore.foreground = 1;
	leftscore.hidewheninmenu = 0;
	leftscore.archived = 0;
	leftscore setpulsefx(100, duration, 1000);
	rightscore = maps\mp\gametypes\_hud_util::createfontstring(font, numbersize);
	rightscore maps\mp\gametypes\_hud_util::setparent(righticon);
	rightscore maps\mp\gametypes\_hud_util::setpoint("TOP", "BOTTOM", 0, scorespacing);
	if(maps\mp\_utility::getintproperty("useRelativeTeamColors", 0))
	{
		rightscore.glowcolor = game["colors"]["red"];
	}
	else
	{
		rightscore.glowcolor = game["colors"][level.otherteam[team]];
	}

	rightscore.glowalpha = 1;
	if(!maps\mp\_utility::isroundbased() || !maps\mp\_utility::isobjectivebased())
	{
		rightscore setvalue(maps\mp\gametypes\_gamescore::_getteamscore(level.otherteam[team]));
	}
	else
	{
		rightscore setvalue(game["roundsWon"][level.otherteam[team]]);
	}

	rightscore.foreground = 1;
	rightscore.hidewheninmenu = 0;
	rightscore.archived = 0;
	rightscore setpulsefx(100, duration, 1000);
	matchbonus = undefined;
	if(isdefined(self.matchbonus))
	{
		matchbonus = maps\mp\gametypes\_hud_util::createfontstring(font, textsize);
		matchbonus maps\mp\gametypes\_hud_util::setparent(outcometext);
		matchbonus maps\mp\gametypes\_hud_util::setpoint("TOP", "BOTTOM", 0, iconsize + bonusspacing + leftscore.height);
		matchbonus.glowalpha = 1;
		matchbonus.foreground = 1;
		matchbonus.hidewheninmenu = 0;
		matchbonus.color = (1,1,0.5);
		matchbonus.archived = 0;
		matchbonus.label = game["strings"]["match_bonus"];
		matchbonus setvalue(self.matchbonus);
	}

	thread resetteamoutcomenotify(outcometitle, outcometext, lefticon, righticon, leftscore, rightscore, matchbonus);
}

outcomenotify(winner, param_573)
{
	self endon("disconnect");
	self notify("reset_outcome");
	while(isdoingsplash())
	{
		wait 0.05;
	}

	self endon("reset_outcome");
	if(level.splitscreen)
	{
		titlesize = 2;
		winnersize = 1.5;
		othersize = 1.5;
		iconsize = 30;
		spacing = 2;
		font = "default";
	}
	else
	{
		titlesize = 3;
		winnersize = 2;
		othersize = 1.5;
		iconsize = 30;
		spacing = 20;
		font = "objective";
	}

	duration = -5536;
	players = level.placement["all"];
	outcometitle = maps\mp\gametypes\_hud_util::createfontstring(font, titlesize);
	outcometitle maps\mp\gametypes\_hud_util::setpoint("TOP", undefined, 0, spacing);
	if(isdefined(players[1]) && players[0].score == players[1].score && players[0].deaths == players[1].deaths && self == players[0] || self == players[1])
	{
		outcometitle settext(game["strings"]["tie"]);
		outcometitle.glowcolor = (0.2,0.3,0.7);
	}
	else if(isdefined(players[2]) && players[0].score == players[2].score && players[0].deaths == players[2].deaths && self == players[2])
	{
		outcometitle settext(game["strings"]["tie"]);
		outcometitle.glowcolor = (0.2,0.3,0.7);
	}
	else if(isdefined(players[0]) && self == players[0])
	{
		outcometitle settext(game["strings"]["victory"]);
		outcometitle.glowcolor = (0.2,0.3,0.7);
	}
	else
	{
		outcometitle settext(game["strings"]["defeat"]);
		outcometitle.glowcolor = (0.7,0.3,0.2);
	}

	outcometitle.glowalpha = 1;
	outcometitle.foreground = 1;
	outcometitle.hidewheninmenu = 0;
	outcometitle.archived = 0;
	outcometitle setpulsefx(100, duration, 1000);
	outcometext = maps\mp\gametypes\_hud_util::createfontstring(font, 2);
	outcometext maps\mp\gametypes\_hud_util::setparent(outcometitle);
	outcometext maps\mp\gametypes\_hud_util::setpoint("TOP", "BOTTOM", 0, 0);
	outcometext.glowalpha = 1;
	outcometext.foreground = 1;
	outcometext.hidewheninmenu = 0;
	outcometext.archived = 0;
	outcometext.glowcolor = (0.2,0.3,0.7);
	outcometext settext(param_573);
	firsttitle = maps\mp\gametypes\_hud_util::createfontstring(font, winnersize);
	firsttitle maps\mp\gametypes\_hud_util::setparent(outcometext);
	firsttitle maps\mp\gametypes\_hud_util::setpoint("TOP", "BOTTOM", 0, spacing);
	firsttitle.glowcolor = (0.3,0.7,0.2);
	firsttitle.glowalpha = 1;
	firsttitle.foreground = 1;
	firsttitle.hidewheninmenu = 0;
	firsttitle.archived = 0;
	if(isdefined(players[0]))
	{
		firsttitle.label = &"MP_FIRSTPLACE_NAME";
		firsttitle setplayernamestring(players[0]);
		firsttitle setpulsefx(100, duration, 1000);
	}

	secondtitle = maps\mp\gametypes\_hud_util::createfontstring(font, othersize);
	secondtitle maps\mp\gametypes\_hud_util::setparent(firsttitle);
	secondtitle maps\mp\gametypes\_hud_util::setpoint("TOP", "BOTTOM", 0, spacing);
	secondtitle.glowcolor = (0.2,0.3,0.7);
	secondtitle.glowalpha = 1;
	secondtitle.foreground = 1;
	secondtitle.hidewheninmenu = 0;
	secondtitle.archived = 0;
	if(isdefined(players[1]))
	{
		secondtitle.label = &"MP_SECONDPLACE_NAME";
		secondtitle setplayernamestring(players[1]);
		secondtitle setpulsefx(100, duration, 1000);
	}

	thirdtitle = maps\mp\gametypes\_hud_util::createfontstring(font, othersize);
	thirdtitle maps\mp\gametypes\_hud_util::setparent(secondtitle);
	thirdtitle maps\mp\gametypes\_hud_util::setpoint("TOP", "BOTTOM", 0, spacing);
	thirdtitle maps\mp\gametypes\_hud_util::setparent(secondtitle);
	thirdtitle.glowcolor = (0.2,0.3,0.7);
	thirdtitle.glowalpha = 1;
	thirdtitle.foreground = 1;
	thirdtitle.hidewheninmenu = 0;
	thirdtitle.archived = 0;
	if(isdefined(players[2]))
	{
		thirdtitle.label = &"MP_THIRDPLACE_NAME";
		thirdtitle setplayernamestring(players[2]);
		thirdtitle setpulsefx(100, duration, 1000);
	}

	matchbonus = maps\mp\gametypes\_hud_util::createfontstring(font, 2);
	matchbonus maps\mp\gametypes\_hud_util::setparent(thirdtitle);
	matchbonus maps\mp\gametypes\_hud_util::setpoint("TOP", "BOTTOM", 0, spacing);
	matchbonus.glowalpha = 1;
	matchbonus.foreground = 1;
	matchbonus.hidewheninmenu = 0;
	matchbonus.archived = 0;
	if(isdefined(self.matchbonus))
	{
		matchbonus.label = game["strings"]["match_bonus"];
		matchbonus setvalue(self.matchbonus);
	}

	thread updateoutcome(firsttitle, secondtitle, thirdtitle);
	thread resetoutcomenotify(outcometitle, outcometext, firsttitle, secondtitle, thirdtitle, matchbonus);
}

resetoutcomenotify(outcometitle, outcometext, firsttitle, secondtitle, thirdtitle, matchbonus)
{
	self endon("disconnect");
	self waittill("reset_outcome");
	if(isdefined(outcometitle))
	{
		outcometitle maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(outcometext))
	{
		outcometext maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(firsttitle))
	{
		firsttitle maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(secondtitle))
	{
		secondtitle maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(thirdtitle))
	{
		thirdtitle maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(matchbonus))
	{
		matchbonus maps\mp\gametypes\_hud_util::destroyelem();
		return;
	}
}

resetteamoutcomenotify(outcometitle, outcometext, lefticon, righticon, leftscore, rightscore, matchbonus)
{
	self endon("disconnect");
	self waittill("reset_outcome");
	if(isdefined(outcometitle))
	{
		outcometitle maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(outcometext))
	{
		outcometext maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(lefticon))
	{
		lefticon maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(righticon))
	{
		righticon maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(leftscore))
	{
		leftscore maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(rightscore))
	{
		rightscore maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(matchbonus))
	{
		matchbonus maps\mp\gametypes\_hud_util::destroyelem();
		return;
	}
}

updateoutcome(firsttitle, secondtitle, thirdtitle)
{
	self endon("disconnect");
	self endon("reset_outcome");
	for(;;)
	{
		self waittill("update_outcome");
		players = level.placement["all"];
		if(isdefined(firsttitle) && isdefined(players[0]))
		{
			firsttitle setplayernamestring(players[0]);
		}
		else if(isdefined(firsttitle))
		{
			firsttitle.alpha = 0;
		}

		if(isdefined(secondtitle) && isdefined(players[1]))
		{
			secondtitle setplayernamestring(players[1]);
		}
		else if(isdefined(secondtitle))
		{
			secondtitle.alpha = 0;
		}

		if(isdefined(thirdtitle) && isdefined(players[2]))
		{
			thirdtitle setplayernamestring(players[2]);
			continue;
		}

		if(isdefined(thirdtitle))
		{
			thirdtitle.alpha = 0;
		}
	}
}

canshowsplash(type)
{
}