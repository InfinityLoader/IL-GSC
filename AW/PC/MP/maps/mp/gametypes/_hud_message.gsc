/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps/mp/gametypes/_hud_message.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 33
 * Decompile Time: 523 ms
 * Timestamp: 10/27/2023 1:50:31 AM
*******************************************************************/

//Function Number: 1
init()
{
	game["round_end"]["draw"] = 1;
	game["round_end"]["round_draw"] = 2;
	game["round_end"]["round_win"] = 3;
	game["round_end"]["round_loss"] = 4;
	game["round_end"]["victory"] = 5;
	game["round_end"]["defeat"] = 6;
	game["round_end"]["halftime"] = 7;
	game["round_end"]["overtime"] = 8;
	game["round_end"]["roundend"] = 9;
	game["round_end"]["intermission"] = 10;
	game["round_end"]["side_switch"] = 11;
	game["round_end"]["match_bonus"] = 12;
	game["round_end"]["tie"] = 13;
	game["round_end"]["game_end"] = 14;
	game["round_end"]["spectator"] = 15;
	game["round_end"]["zombies_hard_mode"] = 16;
	game["end_reason"]["score_limit_reached"] = 1;
	game["end_reason"]["time_limit_reached"] = 2;
	game["end_reason"]["players_forfeited"] = 3;
	game["end_reason"]["target_destroyed"] = 4;
	game["end_reason"]["bomb_defused"] = 5;
	game["end_reason"]["allies_eliminated"] = 6;
	game["end_reason"]["axis_eliminated"] = 7;
	game["end_reason"]["allies_forfeited"] = 8;
	game["end_reason"]["axis_forfeited"] = 9;
	game["end_reason"]["enemies_eliminated"] = 10;
	game["end_reason"]["tie"] = 11;
	game["end_reason"]["objective_completed"] = 12;
	game["end_reason"]["objective_failed"] = 13;
	game["end_reason"]["switching_sides"] = 14;
	game["end_reason"]["round_limit_reached"] = 15;
	game["end_reason"]["ended_game"] = 16;
	game["end_reason"]["host_ended_game"] = 17;
	game["end_reason"]["survivors_eliminated"] = 18;
	game["end_reason"]["zombies_completed"] = 19;
	game["end_reason"]["zombie_extraction_failed"] = 20;
	game["end_reason"]["survivors_eliminated"] = 21;
	game["end_reason"]["infected_eliminated"] = 22;
	game["end_reason"]["survivors_forfeited"] = 23;
	game["end_reason"]["infected_forfeited"] = 24;
	game["end_reason"]["zombies_hard_mode"] = 25;
	game["strings"]["overtime"] = &"MP_OVERTIME";
	level thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread lowermessagethink();
		var_00 thread initnotifymessage();
	}
}

//Function Number: 3
hintmessage(param_00)
{
	var_01 = spawnstruct();
	var_01.notifytext = param_00;
	notifymessage(var_01);
}

//Function Number: 4
initnotifymessage()
{
	if(level.splitscreen || self issplitscreenplayer())
	{
		var_00 = 1.5;
		var_01 = 1.25;
		var_02 = 24;
		var_03 = "hudsmall";
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
		var_03 = "hudsmall";
		var_04 = "TOP";
		var_05 = "BOTTOM";
		var_06 = 50;
		var_07 = 0;
	}

	self.notifytitle = maps\mp\gametypes\_hud_util::createfontstring(var_03,var_00);
	self.notifytitle maps\mp\gametypes\_hud_util::setpoint(var_04,undefined,var_07,var_06);
	self.notifytitle.hidewheninmenu = 1;
	self.notifytitle.archived = 0;
	self.notifytitle.alpha = 0;
	self.notifytext = maps\mp\gametypes\_hud_util::createfontstring(var_03,var_01);
	self.notifytext maps\mp\gametypes\_hud_util::setparent(self.notifytitle);
	self.notifytext maps\mp\gametypes\_hud_util::setpoint(var_04,var_05,0,0);
	self.notifytext.hidewheninmenu = 1;
	self.notifytext.archived = 0;
	self.notifytext.alpha = 0;
	self.notifytext2 = maps\mp\gametypes\_hud_util::createfontstring(var_03,var_01);
	self.notifytext2 maps\mp\gametypes\_hud_util::setparent(self.notifytitle);
	self.notifytext2 maps\mp\gametypes\_hud_util::setpoint(var_04,var_05,0,0);
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
	notifymessage(var_06);
}

//Function Number: 6
notifymessage(param_00)
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
	waittillframeend;
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
promotionsplashnotify()
{
	if(!isplayer(self))
	{
		return;
	}

	self endon("disconnect");
	var_00 = spawnstruct();
	var_01 = "promotion";
	var_00.name = var_01;
	var_00.type = tablelookup(get_table_name(),0,var_01,11);
	var_00.sound = tablelookup(get_table_name(),0,var_01,9);
	var_00.slot = 0;
	thread actionnotify(var_00);
}

//Function Number: 9
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
	waitrequirevisibility(0);
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

	thread resetoncancel();
	if(isdefined(param_00.sound))
	{
		self playlocalsound(param_00.sound);
	}

	if(isdefined(param_00.leadersound))
	{
		maps\mp\_utility::leaderdialogonplayer(param_00.leadersound);
	}

	var_03 = param_00.glowcolor;
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

		if(isdefined(var_03))
		{
			self.notifytitle.glowcolor = var_03;
		}

		self.notifytitle.alpha = 1;
		self.notifytitle fadeovertime(var_02 * 1.25);
		self.notifytitle.alpha = 0;
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

		if(isdefined(var_03))
		{
			self.notifytext.glowcolor = var_03;
		}

		self.notifytext.alpha = 1;
		self.notifytext fadeovertime(var_02 * 1.25);
		self.notifytext.alpha = 0;
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
		if(isdefined(var_03))
		{
			self.notifytext2.glowcolor = var_03;
		}

		self.notifytext2.alpha = 1;
		self.notifytext2 fadeovertime(var_02 * 1.25);
		self.notifytext2.alpha = 0;
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
			self.notifyoverlay setshader(param_00.iconoverlay,511,511);
			self.notifyoverlay.alpha = 0;
			self.notifyoverlay.color = game["colors"]["orange"];
			self.notifyoverlay fadeovertime(0.4);
			self.notifyoverlay.alpha = 0.85;
			self.notifyoverlay scaleovertime(0.4,32,32);
			waitrequirevisibility(var_02);
			self.notifyicon fadeovertime(0.75);
			self.notifyicon.alpha = 0;
			self.notifyoverlay fadeovertime(0.75);
			self.notifyoverlay.alpha = 0;
		}
		else
		{
			self.notifyicon fadeovertime(1);
			self.notifyicon.alpha = 1;
			waitrequirevisibility(var_02);
			self.notifyicon fadeovertime(0.75);
			self.notifyicon.alpha = 0;
		}
	}
	else
	{
		waitrequirevisibility(var_02);
	}

	self notify("notifyMessageDone");
	self.doingsplash[var_01] = undefined;
	if(self.splashqueue[var_01].size)
	{
		thread dispatchnotify(var_01);
	}
}

//Function Number: 10
coopkillstreaksplashnotify(param_00,param_01)
{
	if(!isplayer(self))
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
	var_02.type = tablelookup(get_table_name(),0,param_00,11);
	var_02.optionalnumber = 0;
	var_02.sound = tablelookup(get_table_name(),0,param_00,9);
	var_02.leadersound = param_01;
	var_02.slot = 0;
	thread actionnotify(var_02);
}

//Function Number: 11
killstreaksplashnotify(param_00,param_01,param_02,param_03,param_04)
{
	if(!isplayer(self))
	{
		return;
	}

	self endon("disconnect");
	waittillframeend;
	if(level.gameended)
	{
		return;
	}

	var_05 = spawnstruct();
	if(isdefined(param_02))
	{
		param_00 = param_00 + "_" + param_02;
	}

	if(!isdefined(param_04))
	{
		param_04 = -1;
	}

	var_05.name = param_00;
	var_05.type = tablelookup(get_table_name(),0,param_00,11);
	var_05.optionalnumber = param_01;
	var_05.sound = maps\mp\_utility::getkillstreaksound(param_00);
	var_05.leadersound = param_00;
	var_05.leadersoundgroup = "killstreak_earned";
	var_05.slot = 0;
	var_05.killstreakslot = param_04;
	if(isdefined(param_03) && isarray(param_03))
	{
		if(param_03.size > 0)
		{
			var_05.module1idx = tablelookuprownum(level.ks_modules_table,level.ks_module_ref_column,param_03[0]);
		}

		if(param_03.size > 1)
		{
			var_05.module2idx = tablelookuprownum(level.ks_modules_table,level.ks_module_ref_column,param_03[1]);
		}

		if(param_03.size > 2)
		{
			var_05.module3idx = tablelookuprownum(level.ks_modules_table,level.ks_module_ref_column,param_03[2]);
		}
	}

	thread actionnotify(var_05);
}

//Function Number: 12
challengesplashnotify(param_00,param_01,param_02)
{
	if(!isplayer(self))
	{
		return;
	}

	self endon("disconnect");
	waittillframeend;
	wait(0.05);
	for(var_03 = param_02 - 1;var_03 >= param_01;var_03--)
	{
		var_04 = maps\mp\gametypes\_hud_util::ch_gettarget(param_00,var_03);
		if(var_04 == 0)
		{
			var_04 = 1;
		}

		if(param_00 == "ch_longersprint_pro" || param_00 == "ch_longersprint_pro_daily" || param_00 == "ch_longersprint_pro_weekly")
		{
			var_04 = int(var_04 / 528);
		}
		else if(param_00 == "ch_exomech_frontier")
		{
			var_04 = int(var_04 / 528);
		}

		var_05 = spawnstruct();
		var_05.name = param_00;
		var_05.type = tablelookup(get_table_name(),0,param_00,11);
		var_05.challengetier = var_03;
		var_05.optionalnumber = var_04;
		var_05.sound = tablelookup(get_table_name(),0,param_00,9);
		var_05.slot = 0;
		thread actionnotify(var_05);
	}
}

//Function Number: 13
splashnotify(param_00,param_01,param_02)
{
	if(!isplayer(self))
	{
		return;
	}

	self endon("disconnect");
	wait(0.05);
	var_03 = spawnstruct();
	var_03.name = param_00;
	var_03.type = tablelookup(get_table_name(),0,param_00,11);
	var_03.optionalnumber = param_01;
	var_03.sound = tablelookup(get_table_name(),0,var_03.name,9);
	if(!isdefined(param_02))
	{
		param_02 = -1;
	}

	var_03.killstreakslot = param_02;
	var_03.slot = 0;
	thread actionnotify(var_03);
}

//Function Number: 14
splashnotifyurgent(param_00,param_01)
{
	if(!isplayer(self))
	{
		return;
	}

	self endon("disconnect");
	wait(0.05);
	var_02 = spawnstruct();
	var_02.name = param_00;
	var_02.type = tablelookup(get_table_name(),0,param_00,11);
	var_02.optionalnumber = param_01;
	var_02.sound = tablelookup(get_table_name(),0,param_00,9);
	var_02.slot = 0;
	thread actionnotify(var_02);
}

//Function Number: 15
splashnotifydelayed(param_00,param_01)
{
	if(!isplayer(self))
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
	var_02.type = tablelookup(get_table_name(),0,param_00,11);
	var_02.optionalnumber = param_01;
	var_02.sound = tablelookup(get_table_name(),0,param_00,9);
	var_02.slot = 0;
	thread actionnotify(var_02);
}

//Function Number: 16
rankupsplashnotify(param_00,param_01,param_02)
{
	if(!isplayer(self))
	{
		return;
	}

	self endon("disconnect");
	waittillframeend;
	if(level.gameended)
	{
		return;
	}

	var_03 = spawnstruct();
	var_03.name = param_00;
	var_03.type = tablelookup(get_table_name(),0,param_00,11);
	var_03.sound = tablelookup(get_table_name(),0,param_00,9);
	var_03.rank = param_01;
	var_03.prestige = param_02;
	var_03.slot = 0;
	thread actionnotify(var_03);
}

//Function Number: 17
playercardsplashnotify(param_00,param_01,param_02)
{
	if(!isplayer(self))
	{
		return;
	}

	self endon("disconnect");
	waittillframeend;
	if(level.gameended)
	{
		return;
	}

	var_03 = spawnstruct();
	var_03.name = param_00;
	var_03.type = tablelookup(get_table_name(),0,param_00,11);
	var_03.optionalnumber = param_02;
	var_03.sound = tablelookup(get_table_name(),0,param_00,9);
	var_03.playercardplayer = param_01;
	var_03.slot = 0;
	if(var_03.type == "playercard_splash")
	{
		var_03.slot = 1;
	}

	thread actionnotify(var_03);
}

//Function Number: 18
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
	else
	{
		switch(param_00.type)
		{
			case "urgent_splash":
				break;

			case "killstreak_splash":
			case "killstreak_coop_splash":
			case "splash":
				break;
		}
	}
}

//Function Number: 19
actionnotifymessage(param_00)
{
	self endon("disconnect");
	var_01 = param_00.slot;
	if(level.gameended)
	{
		if(isdefined(param_00.type) && param_00.type == "promotion_splash" || param_00.type == "promotion_weapon_splash")
		{
			self setclientdvar("ui_promotion",1);
			self.postgamepromotion = 1;
		}
		else if(isdefined(param_00.type) && param_00.type == "challenge_splash")
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

	if(isdefined(param_00.name) && param_00.name == "horde_support_drop")
	{
		setomnvar("ui_horde_support_bar_highlight",1);
	}

	if(tablelookup(get_table_name(),0,param_00.name,0) != "")
	{
		var_02 = tablelookuprownum(get_table_name(),0,param_00.name);
		var_03 = maps\mp\_utility::stringtofloat(tablelookupbyrow(get_table_name(),var_02,4));
		switch(param_00.type)
		{
			case "killstreak_splash":
			case "killstreak_coop_splash":
				break;

			case "playercard_splash":
				break;

			case "intel_splash":
			case "urgent_splash":
			case "splash":
				break;

			case "rankup_splash":
				break;

			case "perk_challenge_splash":
			case "challenge_splash":
				break;

			default:
				break;
		}
	}
}

//Function Number: 20
waitrequirevisibility(param_00)
{
	var_01 = 0.05;
	while(!canreadtext())
	{
		wait(var_01);
	}

	while(param_00 > 0)
	{
		wait(var_01);
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
resetondeath()
{
	self endon("notifyMessageDone");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("death");
	resetnotify();
}

//Function Number: 23
resetoncancel()
{
	self notify("resetOnCancel");
	self endon("resetOnCancel");
	self endon("notifyMessageDone");
	self endon("disconnect");
	level waittill("cancel_notify");
	resetnotify();
}

//Function Number: 24
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

//Function Number: 25
lowermessagethink()
{
	self endon("disconnect");
	self.lowermessages = [];
	var_00 = "default";
	if(isdefined(level.lowermessagefont))
	{
		var_00 = level.lowermessagefont;
	}

	var_01 = -110;
	var_02 = level.lowertextfontsize;
	var_03 = 1.25;
	if(level.splitscreen || self issplitscreenplayer() && !isai(self))
	{
		var_01 = var_01 - 40;
		var_02 = level.lowertextfontsize * 1.3;
		var_03 = var_03 * 1.5;
	}

	self.lowermessage = maps\mp\gametypes\_hud_util::createfontstring(var_00,var_02);
	self.lowermessage settext("");
	self.lowermessage.archived = 0;
	self.lowermessage.sort = 10;
	self.lowermessage.showinkillcam = 0;
	self.lowermessage maps\mp\gametypes\_hud_util::setpoint("CENTER",level.lowertextyalign,0,var_01);
	self.lowertimer = maps\mp\gametypes\_hud_util::createfontstring("default",var_03);
	self.lowertimer maps\mp\gametypes\_hud_util::setparent(self.lowermessage);
	self.lowertimer maps\mp\gametypes\_hud_util::setpoint("TOP","BOTTOM",0,0);
	self.lowertimer settext("");
	self.lowertimer.archived = 0;
	self.lowertimer.sort = 10;
	self.lowertimer.showinkillcam = 0;
}

//Function Number: 26
outcomeoverlay(param_00)
{
	if(level.teambased)
	{
		if(param_00 == "tie")
		{
			matchoutcomenotify("draw");
			return;
		}

		if(param_00 == self.team)
		{
			matchoutcomenotify("victory");
			return;
		}

		matchoutcomenotify("defeat");
		return;
	}

	if(param_00 == self)
	{
		matchoutcomenotify("victory");
		return;
	}

	matchoutcomenotify("defeat");
}

//Function Number: 27
matchoutcomenotify(param_00)
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
			break;

		default:
			break;
	}
}

//Function Number: 28
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

//Function Number: 29
teamoutcomenotify(param_00,param_01,param_02,param_03)
{
	self endon("disconnect");
	self notify("reset_outcome");
	thread lerpscreenblurup(32,1);
	wait(0.5);
	var_04 = self.pers["team"];
	if(!isdefined(var_04) || var_04 != "allies" && var_04 != "axis")
	{
		var_04 = "allies";
	}

	while(isdoingsplash())
	{
		wait(0.05);
	}

	self endon("reset_outcome");
	var_05 = 0;
	if(level.gametype == "ctf" && isdefined(param_03) && param_03)
	{
		var_05 = 1;
	}

	if(param_00 == "halftime")
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["halftime"]);
		param_00 = "allies";
		if(level.gametype == "ctf")
		{
			var_05 = 1;
		}
	}
	else if(param_00 == "intermission")
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["intermission"]);
		param_00 = "allies";
	}
	else if(param_00 == "roundend")
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["roundend"]);
		param_00 = "allies";
	}
	else if(param_00 == "none" && maps\mp\_utility::practiceroundgame())
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["game_end"]);
	}
	else if(maps\mp\_utility::isovertimetext(param_00))
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["overtime"]);
		if(level.gametype == "ctf" && param_00 == "overtime")
		{
			var_05 = 1;
		}

		param_00 = "allies";
	}
	else if(param_00 == "tie")
	{
		if(param_01)
		{
			self setclientomnvar("ui_round_end_title",game["round_end"]["round_draw"]);
		}
		else
		{
			self setclientomnvar("ui_round_end_title",game["round_end"]["draw"]);
		}

		param_00 = "allies";
	}
	else if(self ismlgspectator())
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["spectator"]);
	}
	else if(isdefined(self.pers["team"]) && param_00 == var_04)
	{
		if(param_01)
		{
			self setclientomnvar("ui_round_end_title",game["round_end"]["round_win"]);
		}
		else if(isdefined(level.iszombiegame) && level.iszombiegame && isdefined(level.zmbtransitiontohardmode) && level.zmbtransitiontohardmode)
		{
			self setclientomnvar("ui_round_end_title",game["round_end"]["zombies_hard_mode"]);
		}
		else
		{
			self setclientomnvar("ui_round_end_title",game["round_end"]["victory"]);
		}
	}
	else if(param_01)
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["round_loss"]);
	}
	else
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["defeat"]);
	}

	self setclientomnvar("ui_round_end_reason",param_02);
	if(var_05 && !level.winbycaptures)
	{
		self setclientomnvar("ui_round_end_friendly_score",game["roundsWon"][var_04]);
		self setclientomnvar("ui_round_end_enemy_score",game["roundsWon"][level.otherteam[var_04]]);
	}
	else if(!maps\mp\_utility::isroundbased() || !maps\mp\_utility::isobjectivebased())
	{
		self setclientomnvar("ui_round_end_friendly_score",maps\mp\gametypes\_gamescore::_getteamscore(var_04));
		self setclientomnvar("ui_round_end_enemy_score",maps\mp\gametypes\_gamescore::_getteamscore(level.otherteam[var_04]));
	}
	else
	{
		self setclientomnvar("ui_round_end_friendly_score",game["roundsWon"][var_04]);
		self setclientomnvar("ui_round_end_enemy_score",game["roundsWon"][level.otherteam[var_04]]);
	}

	if(isdefined(self.matchbonus))
	{
		self setclientomnvar("ui_round_end_match_bonus",self.matchbonus);
	}

	if(isdefined(game["round_time_to_beat"]))
	{
		self setclientomnvar("ui_round_end_stopwatch",int(game["round_time_to_beat"] * 60));
	}

	self setclientomnvar("ui_round_end",1);
}

//Function Number: 30
outcomenotify(param_00,param_01)
{
	self endon("disconnect");
	self notify("reset_outcome");
	while(isdoingsplash())
	{
		wait(0.05);
	}

	self endon("reset_outcome");
	var_02 = level.placement["all"];
	var_03 = var_02[0];
	var_04 = var_02[1];
	var_05 = var_02[2];
	var_06 = 0;
	if(isdefined(var_03) && self.score == var_03.score && self.deaths == var_03.deaths)
	{
		if(self != var_03)
		{
			var_06 = 1;
		}
		else if(isdefined(var_04) && var_04.score == var_03.score && var_04.deaths == var_03.deaths)
		{
			var_06 = 1;
		}
	}

	if(var_06)
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["tie"]);
	}
	else if(isdefined(var_03) && self == var_03)
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["victory"]);
	}
	else
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["defeat"]);
	}

	self setclientomnvar("ui_round_end_reason",param_01);
	if(isdefined(self.matchbonus))
	{
		self setclientomnvar("ui_round_end_match_bonus",self.matchbonus);
	}

	self setclientomnvar("ui_round_end",1);
	self waittill("update_outcome");
}

//Function Number: 31
canshowsplash(param_00)
{
}

//Function Number: 32
lerpscreenblurup(param_00,param_01)
{
	self setblurforplayer(param_00,param_01);
}

//Function Number: 33
get_table_name()
{
	return "mp/splashTable.csv";
}