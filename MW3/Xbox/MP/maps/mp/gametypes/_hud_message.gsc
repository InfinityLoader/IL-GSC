/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_hud_message.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 35
 * Decompile Time: 534 ms
 * Timestamp: 10/27/2023 2:25:32 AM
*******************************************************************/

//Function Number: 1
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

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread hintmessagedeaththink();
		var_00 thread lowermessagethink();
		var_00 thread initnotifymessage();
	}
}

//Function Number: 3
hintmessage(param_00)
{
	var_01 = spawnstruct();
	var_01.notifytext = param_00;
	var_01.glowcolor = (0.3,0.6,0.3);
	func_0EBE(var_01);
}

//Function Number: 4
initnotifymessage()
{
	if(level.splitscreen || self issplitscreenplayer())
	{
		var_00 = 1.5;
		var_01 = 1.25;
		var_02 = 24;
		var_03 = "default";
		var_04 = "TOP";
		var_05 = "BOTTOM";
		var_06 = 0;
		var_07 = 0;
	}
	else
	{
		var_00 = 2.5;
		var_01 = 1.75;
		var_02 = 30;
		var_03 = "objective";
		var_04 = "TOP";
		var_05 = "BOTTOM";
		var_06 = 50;
		var_07 = 0;
	}

	self.notifytitle = maps\mp\gametypes\_hud_util::createfontstring(var_03,var_00);
	self.notifytitle maps\mp\gametypes\_hud_util::setpoint(var_04,undefined,var_07,var_06);
	self.notifytitle.glowcolor = (0.2,0.3,0.7);
	self.notifytitle.glowalpha = 1;
	self.notifytitle.hidewheninmenu = 1;
	self.notifytitle.archived = 0;
	self.notifytitle.alpha = 0;
	self.notifytext = maps\mp\gametypes\_hud_util::createfontstring(var_03,var_01);
	self.notifytext maps\mp\gametypes\_hud_util::setparent(self.notifytitle);
	self.notifytext maps\mp\gametypes\_hud_util::setpoint(var_04,var_05,0,0);
	self.notifytext.glowcolor = (0.2,0.3,0.7);
	self.notifytext.glowalpha = 1;
	self.notifytext.hidewheninmenu = 1;
	self.notifytext.archived = 0;
	self.notifytext.alpha = 0;
	self.notifytext2 = maps\mp\gametypes\_hud_util::createfontstring(var_03,var_01);
	self.notifytext2 maps\mp\gametypes\_hud_util::setparent(self.notifytitle);
	self.notifytext2 maps\mp\gametypes\_hud_util::setpoint(var_04,var_05,0,0);
	self.notifytext2.glowcolor = (0.2,0.3,0.7);
	self.notifytext2.glowalpha = 1;
	self.notifytext2.hidewheninmenu = 1;
	self.notifytext2.archived = 0;
	self.notifytext2.alpha = 0;
	self.notifyicon = maps\mp\gametypes\_hud_util::createicon("white",var_02,var_02);
	self.notifyicon maps\mp\gametypes\_hud_util::setparent(self.notifytext2);
	self.notifyicon maps\mp\gametypes\_hud_util::setpoint(var_04,var_05,0,0);
	self.notifyicon.hidewheninmenu = 1;
	self.notifyicon.archived = 0;
	self.notifyicon.alpha = 0;
	self.notifyoverlay = maps\mp\gametypes\_hud_util::createicon("white",var_02,var_02);
	self.notifyoverlay maps\mp\gametypes\_hud_util::setparent(self.notifyicon);
	self.notifyoverlay maps\mp\gametypes\_hud_util::setpoint("CENTER","CENTER",0,0);
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

//Function Number: 5
oldnotifymessage(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = spawnstruct();
	var_06.titletext = param_00;
	var_06.notifytext = param_01;
	var_06.iconname = param_02;
	var_06.glowcolor = param_03;
	var_06.sound = param_04;
	var_06.duration = param_05;
	func_0EBE(var_06);
}

//Function Number: 6
func_0EBE(param_00)
{
	self endon("death");
	self endon("disconnect");
	if(!isdefined(param_00.slot))
	{
		param_00.slot = 0;
	}

	var_01 = param_00.slot;
	if(!isdefined(param_00.type))
	{
		param_00.type = "";
	}

	if(!isdefined(self.doingsplash[var_01]))
	{
		thread shownotifymessage(param_00);
		return;
	}

	self.splashqueue[var_01][self.splashqueue[var_01].size] = param_00;
}

//Function Number: 7
dispatchnotify(param_00)
{
	var_01 = self.splashqueue[param_00][0];
	for(var_02 = 1;var_02 < self.splashqueue[param_00].size;var_02++)
	{
		self.splashqueue[param_00][var_02 - 1] = self.splashqueue[param_00][var_02];
	}

	self.splashqueue[param_00][var_02 - 1] = undefined;
	if(isdefined(var_01.name))
	{
		actionnotify(var_01);
		return;
	}

	shownotifymessage(var_01);
}

//Function Number: 8
func_320F()
{
	self endon("disconnect");
	var_00 = spawnstruct();
	var_00.name = "promotion";
	var_00.type = "rank";
	var_00.sound = "mp_level_up";
	var_00.slot = 0;
	thread actionnotify(var_00);
}

//Function Number: 9
weaponpromotionsplashnotify()
{
	self endon("disconnect");
	var_00 = spawnstruct();
	var_00.name = "promotion_weapon";
	var_00.type = "weaponRank";
	var_00.sound = "mp_level_up";
	var_00.slot = 0;
	thread actionnotify(var_00);
}

//Function Number: 10
shownotifymessage(param_00)
{
	self endon("disconnect");
	var_01 = param_00.slot;
	if(level.gameended)
	{
		if(isdefined(param_00.type) && param_00.type == "rank")
		{
			self setclientdvar("ui_promotion",1);
			self.postgamepromotion = 1;
		}

		if(self.splashqueue[var_01].size)
		{
			thread dispatchnotify(var_01);
		}

		return;
	}

	self.doingsplash[var_01] = param_00;
	func_0EC7(0);
	if(isdefined(param_00.duration))
	{
		var_02 = param_00.duration;
	}
	else if(level.gameended)
	{
		var_02 = 2;
	}
	else
	{
		var_02 = 4;
	}

	thread func_0EC6();
	if(isdefined(param_00.sound))
	{
		self playlocalsound(param_00.sound);
	}

	if(isdefined(param_00.leadersound))
	{
		maps\mp\_utility::func_2A60(param_00.leadersound);
	}

	if(isdefined(param_00.glowcolor))
	{
		var_03 = param_00.glowcolor;
	}
	else
	{
		var_03 = (0.3,0.6,0.3);
	}

	var_04 = self.notifytitle;
	if(isdefined(param_00.titletext))
	{
		if(isdefined(param_00.titlelabel))
		{
			self.notifytitle.label = param_00.titlelabel;
		}
		else
		{
			self.notifytitle.label = &"";
		}

		if(isdefined(param_00.titlelabel) && !isdefined(param_00.titleisstring))
		{
			self.notifytitle setvalue(param_00.titletext);
		}
		else
		{
			self.notifytitle settext(param_00.titletext);
		}

		self.notifytitle setpulsefx(int(25 * var_02),int(var_02 * 1000),1000);
		self.notifytitle.glowcolor = var_03;
		self.notifytitle.alpha = 1;
	}

	if(isdefined(param_00.textglowcolor))
	{
		var_03 = param_00.textglowcolor;
	}

	if(isdefined(param_00.notifytext))
	{
		if(isdefined(param_00.textlabel))
		{
			self.notifytext.label = param_00.textlabel;
		}
		else
		{
			self.notifytext.label = &"";
		}

		if(isdefined(param_00.textlabel) && !isdefined(param_00.textisstring))
		{
			self.notifytext setvalue(param_00.notifytext);
		}
		else
		{
			self.notifytext settext(param_00.notifytext);
		}

		self.notifytext setpulsefx(100,int(var_02 * 1000),1000);
		self.notifytext.glowcolor = var_03;
		self.notifytext.alpha = 1;
		var_04 = self.notifytext;
	}

	if(isdefined(param_00.notifytext2))
	{
		self.notifytext2 maps\mp\gametypes\_hud_util::setparent(var_04);
		if(isdefined(param_00.text2label))
		{
			self.notifytext2.label = param_00.text2label;
		}
		else
		{
			self.notifytext2.label = &"";
		}

		self.notifytext2 settext(param_00.notifytext2);
		self.notifytext2 setpulsefx(100,int(var_02 * 1000),1000);
		self.notifytext2.glowcolor = var_03;
		self.notifytext2.alpha = 1;
		var_04 = self.notifytext2;
	}

	if(isdefined(param_00.iconname))
	{
		self.notifyicon maps\mp\gametypes\_hud_util::setparent(var_04);
		if(level.splitscreen || self issplitscreenplayer())
		{
			self.notifyicon setshader(param_00.iconname,30,30);
		}
		else
		{
			self.notifyicon setshader(param_00.iconname,60,60);
		}

		self.notifyicon.alpha = 0;
		if(isdefined(param_00.iconoverlay))
		{
			self.notifyicon fadeovertime(0.15);
			self.notifyicon.alpha = 1;
			param_00.overlayoffsety = 0;
			self.notifyoverlay maps\mp\gametypes\_hud_util::setparent(self.notifyicon);
			self.notifyoverlay maps\mp\gametypes\_hud_util::setpoint("CENTER","CENTER",0,param_00.overlayoffsety);
			self.notifyoverlay setshader(param_00.iconoverlay,512,512);
			self.notifyoverlay.alpha = 0;
			self.notifyoverlay.color = (1,0,0);
			self.notifyoverlay fadeovertime(0.4);
			self.notifyoverlay.alpha = 0.85;
			self.notifyoverlay scaleovertime(0.4,32,32);
			func_0EC7(var_02);
			self.notifyicon fadeovertime(0.75);
			self.notifyicon.alpha = 0;
			self.notifyoverlay fadeovertime(0.75);
			self.notifyoverlay.alpha = 0;
		}
		else
		{
			self.notifyicon fadeovertime(1);
			self.notifyicon.alpha = 1;
			func_0EC7(var_02);
			self.notifyicon fadeovertime(0.75);
			self.notifyicon.alpha = 0;
		}
	}
	else
	{
		func_0EC7(var_02);
	}

	self notify("notifyMessageDone");
	self.doingsplash[var_01] = undefined;
	if(self.splashqueue[var_01].size)
	{
		thread dispatchnotify(var_01);
	}
}

//Function Number: 11
killstreaksplashnotify(param_00,param_01,param_02)
{
	self endon("disconnect");
	waittillframeend;
	if(level.gameended)
	{
		return;
	}

	var_03 = spawnstruct();
	if(isdefined(param_02))
	{
		var_03.name = param_00 + "_" + param_02;
	}
	else
	{
		var_03.name = param_00;
	}

	var_03.type = "killstreak";
	var_03.optionalnumber = param_01;
	var_03.sound = maps\mp\killstreaks\_killstreaks::func_31F9(param_00);
	var_03.leadersound = param_00;
	var_03.leadersoundgroup = "killstreak_earned";
	var_03.slot = 0;
	thread actionnotify(var_03);
}

//Function Number: 12
defconsplashnotify(param_00,param_01)
{
}

//Function Number: 13
challengesplashnotify(param_00)
{
	self endon("disconnect");
	waittillframeend;
	wait 0.05;
	var_01 = maps\mp\gametypes\_hud_util::ch_getstate(param_00) - 1;
	var_02 = maps\mp\gametypes\_hud_util::ch_gettarget(param_00,var_01);
	if(var_02 == 0)
	{
		var_02 = 1;
	}

	if(param_00 == "ch_longersprint_pro" || param_00 == "ch_longersprint_pro_daily" || param_00 == "ch_longersprint_pro_weekly")
	{
		var_02 = int(var_02 / 5280);
	}

	var_03 = spawnstruct();
	var_03.type = "challenge";
	var_03.optionalnumber = var_02;
	var_03.name = param_00;
	var_03.sound = tablelookup("mp/splashTable.csv",0,var_03.name,9);
	var_03.slot = 0;
	thread actionnotify(var_03);
}

//Function Number: 14
func_2892(param_00,param_01)
{
	self endon("disconnect");
	wait 0.05;
	var_02 = spawnstruct();
	var_02.name = param_00;
	var_02.optionalnumber = param_01;
	var_02.sound = tablelookup("mp/splashTable.csv",0,var_02.name,9);
	var_02.slot = 0;
	thread actionnotify(var_02);
}

//Function Number: 15
func_2701(param_00,param_01)
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

	var_02 = spawnstruct();
	var_02.name = param_00;
	var_02.optionalnumber = param_01;
	var_02.sound = tablelookup("mp/splashTable.csv",0,var_02.name,9);
	var_02.slot = 0;
	thread actionnotify(var_02);
}

//Function Number: 16
playercardsplashnotify(param_00,param_01,param_02)
{
	self endon("disconnect");
	waittillframeend;
	if(level.gameended)
	{
		return;
	}

	var_03 = spawnstruct();
	var_03.name = param_00;
	var_03.optionalnumber = param_02;
	var_03.sound = tablelookup("mp/splashTable.csv",0,var_03.name,9);
	var_03.playercardplayer = param_01;
	var_03.slot = 1;
	thread actionnotify(var_03);
}

//Function Number: 17
actionnotify(param_00)
{
	self endon("death");
	self endon("disconnect");
	var_01 = param_00.slot;
	if(!isdefined(param_00.type))
	{
		param_00.type = "";
	}

	if(!isdefined(self.doingsplash[var_01]))
	{
		thread actionnotifymessage(param_00);
		return;
	}
	else if(param_00.type == "killstreak" && self.doingsplash[var_01].type != "challenge" && self.doingsplash[var_01].type != "rank")
	{
		self.notifytext.alpha = 0;
		self.notifytext2.alpha = 0;
		self.notifyicon.alpha = 0;
		thread actionnotifymessage(param_00);
		return;
	}
	else if(param_00.type == "challenge" && self.doingsplash[var_01].type != "killstreak" && self.doingsplash[var_01].type != "challenge" && self.doingsplash[var_01].type != "rank")
	{
		self.notifytext.alpha = 0;
		self.notifytext2.alpha = 0;
		self.notifyicon.alpha = 0;
		thread actionnotifymessage(param_00);
		return;
	}

	if(param_00.type == "challenge" || param_00.type == "killstreak")
	{
		if(param_00.type == "killstreak")
		{
			removetypefromqueue("killstreak",var_01);
		}

		for(var_02 = self.splashqueue[var_01].size;var_02 > 0;var_02--)
		{
			self.splashqueue[var_01][var_02] = self.splashqueue[var_01][var_02 - 1];
		}

		self.splashqueue[var_01][0] = param_00;
		return;
	}

	self.splashqueue[var_01][self.splashqueue[var_01].size] = param_00;
}

//Function Number: 18
removetypefromqueue(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < self.splashqueue[param_01].size;var_03++)
	{
		if(self.splashqueue[param_01][var_03].type != "killstreak")
		{
			var_02[var_02.size] = self.splashqueue[param_01][var_03];
		}
	}

	self.splashqueue[param_01] = var_02;
}

//Function Number: 19
actionnotifymessage(param_00)
{
	self endon("disconnect");
	var_01 = param_00.slot;
	if(level.gameended)
	{
		wait 0;
		if(isdefined(param_00.type) && param_00.type == "rank" || param_00.type == "weaponRank")
		{
			self setclientdvar("ui_promotion",1);
			self.postgamepromotion = 1;
		}
		else if(isdefined(param_00.type) && param_00.type == "challenge")
		{
			self.pers["postGameChallenges"]++;
			self setclientdvar("ui_challenge_" + self.pers["postGameChallenges"] + "_ref",param_00.name);
		}

		if(self.splashqueue[var_01].size)
		{
			thread dispatchnotify(var_01);
		}

		return;
	}

	if(tablelookup("mp/splashTable.csv",0,param_00.name,0) != "")
	{
		if(isdefined(param_00.playercardplayer))
		{
			self setcarddisplayslot(param_00.playercardplayer,5);
		}

		if(isdefined(param_00.optionalnumber))
		{
			self showhudsplash(param_00.name,param_00.slot,param_00.optionalnumber);
		}
		else
		{
			self showhudsplash(param_00.name,param_00.slot);
		}

		self.doingsplash[var_01] = param_00;
		var_02 = maps\mp\_utility::func_EBF(tablelookup("mp/splashTable.csv",0,param_00.name,4));
		if(isdefined(param_00.sound))
		{
			self playlocalsound(param_00.sound);
		}

		if(isdefined(param_00.leadersound))
		{
			if(isdefined(param_00.leadersoundgroup))
			{
				maps\mp\_utility::func_2A60(param_00.leadersound,param_00.leadersoundgroup,1);
			}
			else
			{
				maps\mp\_utility::func_2A60(param_00.leadersound);
			}
		}

		self notify("actionNotifyMessage" + var_01);
		self endon("actionNotifyMessage" + var_01);
		wait var_02 - 0.05;
		self.doingsplash[var_01] = undefined;
	}

	if(self.splashqueue[var_01].size)
	{
		thread dispatchnotify(var_01);
	}
}

//Function Number: 20
func_0EC7(param_00)
{
	var_01 = 0.05;
	while(!canreadtext())
	{
		wait var_01;
	}

	while(param_00 > 0)
	{
		wait var_01;
		if(canreadtext())
		{
			param_00 = param_00 - var_01;
		}
	}
}

//Function Number: 21
canreadtext()
{
	if(maps\mp\_flashgrenades::isflashbanged())
	{
		return 0;
	}

	return 1;
}

//Function Number: 22
func_3215()
{
	self endon("notifyMessageDone");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("death");
	func_3216();
}

//Function Number: 23
func_0EC6()
{
	self notify("resetOnCancel");
	self endon("resetOnCancel");
	self endon("notifyMessageDone");
	self endon("disconnect");
	level waittill("cancel_notify");
	func_3216();
}

//Function Number: 24
func_3216()
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

//Function Number: 25
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

//Function Number: 26
lowermessagethink()
{
	self endon("disconnect");
	self.lowermessages = [];
	self.lowermessage = maps\mp\gametypes\_hud_util::createfontstring("default",level.lowertextfontsize);
	self.lowermessage settext("");
	self.lowermessage.archived = 0;
	self.lowermessage.sort = 10;
	if(level.splitscreen || self issplitscreenplayer())
	{
		self.lowermessage maps\mp\gametypes\_hud_util::setpoint("CENTER",level.lowertextyalign,0,level.lowertexty);
		var_00 = 0.5;
	}
	else
	{
		self.lowermessage maps\mp\gametypes\_hud_util::setpoint("CENTER",level.lowertextyalign,0,level.lowertexty - 40);
		var_00 = 0.75;
	}

	self.lowertimer = maps\mp\gametypes\_hud_util::createfontstring("hudbig",var_00);
	self.lowertimer maps\mp\gametypes\_hud_util::setparent(self.lowermessage);
	self.lowertimer maps\mp\gametypes\_hud_util::setpoint("TOP","BOTTOM",0,0);
	self.lowertimer settext("");
	self.lowertimer.archived = 0;
	self.lowertimer.sort = 10;
}

//Function Number: 27
func_321A(param_00)
{
	if(level.teambased)
	{
		if(param_00 == "tie")
		{
			func_321B("draw");
			return;
		}

		if(param_00 == self.team)
		{
			func_321B("victory");
			return;
		}

		func_321B("defeat");
		return;
	}

	if(param_00 == self)
	{
		func_321B("victory");
		return;
	}

	func_321B("defeat");
}

//Function Number: 28
func_321B(param_00)
{
	var_01 = self.team;
	var_02 = maps\mp\gametypes\_hud_util::createfontstring("bigfixed",1);
	var_02 maps\mp\gametypes\_hud_util::setpoint("TOP",undefined,0,50);
	var_02.foreground = 1;
	var_02.glowalpha = 1;
	var_02.hidewheninmenu = 0;
	var_02.archived = 0;
	var_02 settext(game["strings"][param_00]);
	var_02.alpha = 0;
	var_02 fadeovertime(0.5);
	var_02.alpha = 1;
	switch(param_00)
	{
		case "victory":
			var_02.glowcolor = (0.6,0.9,0.6);
			break;

		default:
			var_02.glowcolor = (0.9,0.6,0.6);
			break;
	}

	var_03 = maps\mp\gametypes\_hud_util::createicon(game["icons"][var_01],64,64);
	var_03 maps\mp\gametypes\_hud_util::setparent(var_02);
	var_03 maps\mp\gametypes\_hud_util::setpoint("TOP","BOTTOM",0,30);
	var_03.foreground = 1;
	var_03.hidewheninmenu = 0;
	var_03.archived = 0;
	var_03.alpha = 0;
	var_03 fadeovertime(0.5);
	var_03.alpha = 1;
	wait 3;
	var_02 maps\mp\gametypes\_hud_util::destroyelem();
	var_03 maps\mp\gametypes\_hud_util::destroyelem();
}

//Function Number: 29
func_2F20()
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

//Function Number: 30
teamoutcomenotify(param_00,param_01,param_02)
{
	self endon("disconnect");
	self notify("reset_outcome");
	wait 0.5;
	var_03 = self.pers["team"];
	if(!isdefined(var_03) || var_03 != "allies" && var_03 != "axis")
	{
		var_03 = "allies";
	}

	while(func_2F20())
	{
		wait 0.05;
	}

	self endon("reset_outcome");
	if(level.splitscreen || self issplitscreenplayer())
	{
		var_04 = 1;
		var_05 = -76;
		var_06 = 0.667;
		var_07 = 12;
		var_08 = 0.833;
		var_09 = 46;
		var_0A = 40;
		var_0B = 30;
		var_0C = 0;
		var_0D = 60;
		var_0E = "hudbig";
	}
	else
	{
		var_04 = 1.5;
		var_05 = -134;
		var_06 = 1;
		var_07 = 18;
		var_08 = 1.25;
		var_09 = 70;
		var_0A = 60;
		var_0B = 45;
		var_0C = 0;
		var_0D = 90;
		var_0E = "hudbig";
	}

	var_0F = -5536;
	var_10 = maps\mp\gametypes\_hud_util::createfontstring(var_0E,var_04);
	var_10 maps\mp\gametypes\_hud_util::setpoint("CENTER",undefined,0,var_05);
	var_10.foreground = 1;
	var_10.glowalpha = 1;
	var_10.hidewheninmenu = 0;
	var_10.archived = 0;
	var_11 = maps\mp\gametypes\_hud_util::createfontstring(var_0E,var_06);
	var_11 maps\mp\gametypes\_hud_util::setparent(var_10);
	var_11.foreground = 1;
	var_11 maps\mp\gametypes\_hud_util::setpoint("TOP","BOTTOM",0,var_07);
	var_11.glowalpha = 1;
	var_11.hidewheninmenu = 0;
	var_11.archived = 0;
	if(param_00 == "halftime")
	{
		var_10.glowcolor = (0.2,0.3,0.7);
		var_10 settext(game["strings"]["halftime"]);
		var_10.color = (1,1,1);
		param_00 = "allies";
	}
	else if(param_00 == "intermission")
	{
		var_10.glowcolor = (0.2,0.3,0.7);
		var_10 settext(game["strings"]["intermission"]);
		var_10.color = (1,1,1);
		param_00 = "allies";
	}
	else if(param_00 == "roundend")
	{
		var_10.glowcolor = (0.2,0.3,0.7);
		var_10 settext(game["strings"]["roundend"]);
		var_10.color = (1,1,1);
		param_00 = "allies";
	}
	else if(param_00 == "overtime")
	{
		var_10.glowcolor = (0.2,0.3,0.7);
		var_10 settext(game["strings"]["overtime"]);
		var_10.color = (1,1,1);
		param_00 = "allies";
	}
	else if(param_00 == "tie")
	{
		var_10.glowcolor = (0.2,0.3,0.7);
		if(param_01)
		{
			var_10 settext(game["strings"]["round_draw"]);
		}
		else
		{
			var_10 settext(game["strings"]["draw"]);
		}

		var_10.color = (1,1,1);
		param_00 = "allies";
	}
	else if(isdefined(self.pers["team"]) && param_00 == var_03)
	{
		var_10.glowcolor = (0,0,0);
		if(param_01)
		{
			var_10 settext(game["strings"]["round_win"]);
		}
		else
		{
			var_10 settext(game["strings"]["victory"]);
		}

		var_10.color = (0.6,0.9,0.6);
	}
	else
	{
		var_10.glowcolor = (0,0,0);
		if(param_01)
		{
			var_10 settext(game["strings"]["round_loss"]);
		}
		else
		{
			var_10 settext(game["strings"]["defeat"]);
		}

		var_10.color = (0.7,0.3,0.2);
	}

	var_11.glowcolor = (0.2,0.3,0.7);
	var_11 settext(param_02);
	var_10 setpulsefx(100,var_0F,1000);
	var_11 setpulsefx(100,var_0F,1000);
	if(maps\mp\_utility::getintproperty("useRelativeTeamColors",0))
	{
		var_12 = maps\mp\gametypes\_hud_util::createicon(game["icons"][var_03] + "_blue",var_09,var_09);
	}
	else
	{
		var_12 = maps\mp\gametypes\_hud_util::createicon(game["icons"][var_04],var_0A,var_0A);
	}

	var_12 maps\mp\gametypes\_hud_util::setparent(var_11);
	var_12 maps\mp\gametypes\_hud_util::setpoint("TOP","BOTTOM",var_0A * -1,var_0B);
	var_12.foreground = 1;
	var_12.hidewheninmenu = 0;
	var_12.archived = 0;
	var_12.alpha = 0;
	var_12 fadeovertime(0.5);
	var_12.alpha = 1;
	if(maps\mp\_utility::getintproperty("useRelativeTeamColors",0))
	{
		var_13 = maps\mp\gametypes\_hud_util::createicon(game["icons"][level.otherteam[var_03]] + "_red",var_09,var_09);
	}
	else
	{
		var_13 = maps\mp\gametypes\_hud_util::createicon(game["icons"][level.otherteam[var_04]],var_0A,var_0A);
	}

	var_13 maps\mp\gametypes\_hud_util::setparent(var_11);
	var_13 maps\mp\gametypes\_hud_util::setpoint("TOP","BOTTOM",var_0A,var_0B);
	var_13.foreground = 1;
	var_13.hidewheninmenu = 0;
	var_13.archived = 0;
	var_13.alpha = 0;
	var_13 fadeovertime(0.5);
	var_13.alpha = 1;
	var_14 = maps\mp\gametypes\_hud_util::createfontstring(var_0E,var_08);
	var_14 maps\mp\gametypes\_hud_util::setparent(var_12);
	var_14 maps\mp\gametypes\_hud_util::setpoint("TOP","BOTTOM",0,var_0C);
	if(maps\mp\_utility::getintproperty("useRelativeTeamColors",0))
	{
		var_14.glowcolor = game["colors"]["blue"];
	}
	else
	{
		var_14.glowcolor = game["colors"][var_03];
	}

	var_14.glowalpha = 1;
	if(!maps\mp\_utility::func_26EC() || !maps\mp\_utility::isobjectivebased())
	{
		var_14 setvalue(maps\mp\gametypes\_gamescore::func_26EE(var_03));
	}
	else
	{
		var_14 setvalue(game["roundsWon"][var_03]);
	}

	var_14.foreground = 1;
	var_14.hidewheninmenu = 0;
	var_14.archived = 0;
	var_14 setpulsefx(100,var_0F,1000);
	var_15 = maps\mp\gametypes\_hud_util::createfontstring(var_0E,var_08);
	var_15 maps\mp\gametypes\_hud_util::setparent(var_13);
	var_15 maps\mp\gametypes\_hud_util::setpoint("TOP","BOTTOM",0,var_0C);
	if(maps\mp\_utility::getintproperty("useRelativeTeamColors",0))
	{
		var_15.glowcolor = game["colors"]["red"];
	}
	else
	{
		var_15.glowcolor = game["colors"][level.otherteam[var_03]];
	}

	var_15.glowalpha = 1;
	if(!maps\mp\_utility::func_26EC() || !maps\mp\_utility::isobjectivebased())
	{
		var_15 setvalue(maps\mp\gametypes\_gamescore::func_26EE(level.otherteam[var_03]));
	}
	else
	{
		var_15 setvalue(game["roundsWon"][level.otherteam[var_03]]);
	}

	var_15.foreground = 1;
	var_15.hidewheninmenu = 0;
	var_15.archived = 0;
	var_15 setpulsefx(100,var_0F,1000);
	var_16 = undefined;
	if(isdefined(self.matchbonus))
	{
		var_16 = maps\mp\gametypes\_hud_util::createfontstring(var_0E,var_06);
		var_16 maps\mp\gametypes\_hud_util::setparent(var_11);
		var_16 maps\mp\gametypes\_hud_util::setpoint("TOP","BOTTOM",0,var_09 + var_0D + var_14.height);
		var_16.glowalpha = 1;
		var_16.foreground = 1;
		var_16.hidewheninmenu = 0;
		var_16.color = (1,1,0.5);
		var_16.archived = 0;
		var_16.label = game["strings"]["match_bonus"];
		var_16 setvalue(self.matchbonus);
	}

	thread func_321D(var_10,var_11,var_12,var_13,var_14,var_15,var_16);
}

//Function Number: 31
outcomenotify(param_00,param_01)
{
	self endon("disconnect");
	self notify("reset_outcome");
	while(func_2F20())
	{
		wait 0.05;
	}

	self endon("reset_outcome");
	if(level.splitscreen || self issplitscreenplayer())
	{
		var_02 = 2;
		var_03 = 1.5;
		var_04 = 1.5;
		var_05 = 30;
		var_06 = 2;
		var_07 = "default";
	}
	else
	{
		var_02 = 3;
		var_03 = 2;
		var_04 = 1.5;
		var_05 = 30;
		var_06 = 20;
		var_07 = "objective";
	}

	var_08 = -5536;
	var_09 = level.placement["all"];
	var_0A = var_09[0];
	var_0B = var_09[1];
	var_0C = var_09[2];
	var_0D = maps\mp\gametypes\_hud_util::createfontstring(var_07,var_02);
	var_0D maps\mp\gametypes\_hud_util::setpoint("TOP",undefined,0,var_06);
	var_0E = 0;
	if(isdefined(var_0A) && self.score == var_0A.score && self.deaths == var_0A.deaths)
	{
		if(self != var_0A)
		{
			var_0E = 1;
		}
		else if(isdefined(var_0B) && var_0B.score == var_0A.score && var_0B.deaths == var_0A.deaths)
		{
			var_0E = 1;
		}
	}

	if(var_0E)
	{
		var_0D settext(game["strings"]["tie"]);
		var_0D.glowcolor = (0.2,0.3,0.7);
	}
	else if(isdefined(var_0A) && self == var_0A)
	{
		var_0D settext(game["strings"]["victory"]);
		var_0D.glowcolor = (0.2,0.3,0.7);
	}
	else
	{
		var_0D settext(game["strings"]["defeat"]);
		var_0D.glowcolor = (0.7,0.3,0.2);
	}

	var_0D.glowalpha = 1;
	var_0D.foreground = 1;
	var_0D.hidewheninmenu = 0;
	var_0D.archived = 0;
	var_0D setpulsefx(100,var_08,1000);
	var_0F = maps\mp\gametypes\_hud_util::createfontstring(var_07,2);
	var_0F maps\mp\gametypes\_hud_util::setparent(var_0D);
	var_0F maps\mp\gametypes\_hud_util::setpoint("TOP","BOTTOM",0,0);
	var_0F.glowalpha = 1;
	var_0F.foreground = 1;
	var_0F.hidewheninmenu = 0;
	var_0F.archived = 0;
	var_0F.glowcolor = (0.2,0.3,0.7);
	var_0F settext(param_01);
	var_10 = maps\mp\gametypes\_hud_util::createfontstring(var_07,var_03);
	var_10 maps\mp\gametypes\_hud_util::setparent(var_0F);
	var_10 maps\mp\gametypes\_hud_util::setpoint("TOP","BOTTOM",0,var_06);
	var_10.glowcolor = (0.3,0.7,0.2);
	var_10.glowalpha = 1;
	var_10.foreground = 1;
	var_10.hidewheninmenu = 0;
	var_10.archived = 0;
	if(isdefined(var_0A))
	{
		var_10.label = &"MP_FIRSTPLACE_NAME";
		var_10 setplayernamestring(var_0A);
		var_10 setpulsefx(100,var_08,1000);
	}

	var_11 = maps\mp\gametypes\_hud_util::createfontstring(var_07,var_04);
	var_11 maps\mp\gametypes\_hud_util::setparent(var_10);
	var_11 maps\mp\gametypes\_hud_util::setpoint("TOP","BOTTOM",0,var_06);
	var_11.glowcolor = (0.2,0.3,0.7);
	var_11.glowalpha = 1;
	var_11.foreground = 1;
	var_11.hidewheninmenu = 0;
	var_11.archived = 0;
	if(isdefined(var_0B))
	{
		var_11.label = &"MP_SECONDPLACE_NAME";
		var_11 setplayernamestring(var_0B);
		var_11 setpulsefx(100,var_08,1000);
	}

	var_12 = maps\mp\gametypes\_hud_util::createfontstring(var_07,var_04);
	var_12 maps\mp\gametypes\_hud_util::setparent(var_11);
	var_12 maps\mp\gametypes\_hud_util::setpoint("TOP","BOTTOM",0,var_06);
	var_12 maps\mp\gametypes\_hud_util::setparent(var_11);
	var_12.glowcolor = (0.2,0.3,0.7);
	var_12.glowalpha = 1;
	var_12.foreground = 1;
	var_12.hidewheninmenu = 0;
	var_12.archived = 0;
	if(isdefined(var_0C))
	{
		var_12.label = &"MP_THIRDPLACE_NAME";
		var_12 setplayernamestring(var_0C);
		var_12 setpulsefx(100,var_08,1000);
	}

	var_13 = maps\mp\gametypes\_hud_util::createfontstring(var_07,2);
	var_13 maps\mp\gametypes\_hud_util::setparent(var_12);
	var_13 maps\mp\gametypes\_hud_util::setpoint("TOP","BOTTOM",0,var_06);
	var_13.glowalpha = 1;
	var_13.foreground = 1;
	var_13.hidewheninmenu = 0;
	var_13.archived = 0;
	if(isdefined(self.matchbonus))
	{
		var_13.label = game["strings"]["match_bonus"];
		var_13 setvalue(self.matchbonus);
	}

	thread func_321E(var_10,var_11,var_12);
	thread func_321C(var_0D,var_0F,var_10,var_11,var_12,var_13);
}

//Function Number: 32
func_321C(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("disconnect");
	self waittill("reset_outcome");
	if(isdefined(param_00))
	{
		param_00 maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(param_01))
	{
		param_01 maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(param_02))
	{
		param_02 maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(param_03))
	{
		param_03 maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(param_04))
	{
		param_04 maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(param_05))
	{
		param_05 maps\mp\gametypes\_hud_util::destroyelem();
	}
}

//Function Number: 33
func_321D(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	self endon("disconnect");
	self waittill("reset_outcome");
	if(isdefined(param_00))
	{
		param_00 maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(param_01))
	{
		param_01 maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(param_02))
	{
		param_02 maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(param_03))
	{
		param_03 maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(param_04))
	{
		param_04 maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(param_05))
	{
		param_05 maps\mp\gametypes\_hud_util::destroyelem();
	}

	if(isdefined(param_06))
	{
		param_06 maps\mp\gametypes\_hud_util::destroyelem();
	}
}

//Function Number: 34
func_321E(param_00,param_01,param_02)
{
	self endon("disconnect");
	self endon("reset_outcome");
	for(;;)
	{
		self waittill("update_outcome");
		var_03 = level.placement["all"];
		var_04 = var_03[0];
		var_05 = var_03[1];
		var_06 = var_03[2];
		if(isdefined(param_00) && isdefined(var_04))
		{
			param_00 setplayernamestring(var_04);
		}
		else if(isdefined(param_00))
		{
			param_00.alpha = 0;
		}

		if(isdefined(param_01) && isdefined(var_05))
		{
			param_01 setplayernamestring(var_05);
		}
		else if(isdefined(param_01))
		{
			param_01.alpha = 0;
		}

		if(isdefined(param_02) && isdefined(var_06))
		{
			param_02 setplayernamestring(var_06);
			continue;
		}

		if(isdefined(param_02))
		{
			param_02.alpha = 0;
		}
	}
}

//Function Number: 35
func_321F(param_00)
{
}