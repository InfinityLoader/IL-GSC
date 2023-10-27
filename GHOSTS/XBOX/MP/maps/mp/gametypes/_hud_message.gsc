/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_hud_message.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 34
 * Decompile Time: 607 ms
 * Timestamp: 10/27/2023 1:31:04 AM
*******************************************************************/

//Function Number: 1
func_44DF()
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
	game["round_end"]["spectator"] = 14;
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
	game["strings"]["overtime"] = &"MP_OVERTIME";
	level thread func_595D();
}

//Function Number: 2
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread func_4261();
		var_00 thread func_4FA4();
		var_00 thread func_463A();
	}
}

//Function Number: 3
hintmessage(param_00)
{
	var_01 = addstruct();
	var_01.notifytext = param_00;
	var_01.glowcolor = game["colors"]["cyan"];
	func_5729(var_01);
}

//Function Number: 4
func_463A()
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
	self.notifytitle maps\mp\gametypes\_hud_util::func_70A4(var_04,undefined,var_07,var_06);
	self.notifytitle.glowcolor = game["colors"]["blue"];
	self.notifytitle.glowalpha = 1;
	self.notifytitle.hidewheninmenu = 1;
	self.notifytitle.archived = 0;
	self.notifytitle.alpha = 0;
	self.notifytext = maps\mp\gametypes\_hud_util::createfontstring(var_03,var_01);
	self.notifytext maps\mp\gametypes\_hud_util::func_708F(self.notifytitle);
	self.notifytext maps\mp\gametypes\_hud_util::func_70A4(var_04,var_05,0,0);
	self.notifytext.glowcolor = game["colors"]["blue"];
	self.notifytext.glowalpha = 1;
	self.notifytext.hidewheninmenu = 1;
	self.notifytext.archived = 0;
	self.notifytext.alpha = 0;
	self.notifytext2 = maps\mp\gametypes\_hud_util::createfontstring(var_03,var_01);
	self.notifytext2 maps\mp\gametypes\_hud_util::func_708F(self.notifytitle);
	self.notifytext2 maps\mp\gametypes\_hud_util::func_70A4(var_04,var_05,0,0);
	self.notifytext2.glowcolor = game["colors"]["blue"];
	self.notifytext2.glowalpha = 1;
	self.notifytext2.hidewheninmenu = 1;
	self.notifytext2.archived = 0;
	self.notifytext2.alpha = 0;
	self.notifyicon = maps\mp\gametypes\_hud_util::func_20FC("white",var_02,var_02);
	self.notifyicon maps\mp\gametypes\_hud_util::func_708F(self.notifytext2);
	self.notifyicon maps\mp\gametypes\_hud_util::func_70A4(var_04,var_05,0,0);
	self.notifyicon.hidewheninmenu = 1;
	self.notifyicon.archived = 0;
	self.notifyicon.alpha = 0;
	self.notifyoverlay = maps\mp\gametypes\_hud_util::func_20FC("white",var_02,var_02);
	self.notifyoverlay maps\mp\gametypes\_hud_util::func_708F(self.notifyicon);
	self.notifyoverlay maps\mp\gametypes\_hud_util::func_70A4("CENTER","CENTER",0,0);
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
func_58CB(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = addstruct();
	var_06.titletext = param_00;
	var_06.notifytext = param_01;
	var_06.iconname = param_02;
	var_06.glowcolor = param_03;
	var_06.sound = param_04;
	var_06.duration = param_05;
	func_5729(var_06);
}

//Function Number: 6
func_5729(param_00)
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
		thread func_751F(param_00);
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
	}

	func_751F(var_01);
}

//Function Number: 8
func_61EF()
{
	if(!isplayer(self))
	{
	}

	self endon("disconnect");
	var_00 = addstruct();
	var_01 = "promotion";
	var_00.name = var_01;
	var_00.type = tablelookup(func_39BA(),0,var_01,11);
	var_00.sound = tablelookup(func_39BA(),0,var_01,9);
	var_00.slot = 0;
	thread actionnotify(var_00);
}

//Function Number: 9
func_8DB7()
{
	if(!isplayer(self))
	{
	}

	self endon("disconnect");
	var_00 = addstruct();
	var_01 = "promotion_weapon";
	var_00.name = var_01;
	var_00.type = tablelookup(func_39BA(),0,var_01,11);
	var_00.sound = tablelookup(func_39BA(),0,var_01,9);
	var_00.slot = 0;
	thread actionnotify(var_00);
}

//Function Number: 10
func_751F(param_00)
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
	}

	self.doingsplash[var_01] = param_00;
	func_8B10(0);
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
		maps\mp\_utility::func_4D35(param_00.leadersound);
	}

	if(isdefined(param_00.glowcolor))
	{
		var_03 = param_00.glowcolor;
	}
	else
	{
		var_03 = game["colors"]["cyan"];
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

		self.notifytitle setpulsefx(castint(25 * var_02),castint(var_02 * 1000),1000);
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

		self.notifytext setpulsefx(100,castint(var_02 * 1000),1000);
		self.notifytext.glowcolor = var_03;
		self.notifytext.alpha = 1;
		var_04 = self.notifytext;
	}

	if(isdefined(param_00.notifytext2))
	{
		self.notifytext2 maps\mp\gametypes\_hud_util::func_708F(var_04);
		if(isdefined(param_00.text2label))
		{
			self.notifytext2.label = param_00.text2label;
		}
		else
		{
			self.notifytext2.label = &"";
		}

		self.notifytext2 settext(param_00.notifytext2);
		self.notifytext2 setpulsefx(100,castint(var_02 * 1000),1000);
		self.notifytext2.glowcolor = var_03;
		self.notifytext2.alpha = 1;
		var_04 = self.notifytext2;
	}

	if(isdefined(param_00.iconname))
	{
		self.notifyicon maps\mp\gametypes\_hud_util::func_708F(var_04);
		if(level.splitscreen || self issplitscreenplayer())
		{
			self.notifyicon setmaterial(param_00.iconname,30,30);
		}
		else
		{
			self.notifyicon setmaterial(param_00.iconname,60,60);
		}

		self.notifyicon.alpha = 0;
		if(isdefined(param_00.iconoverlay))
		{
			self.notifyicon fadeovertime(0.15);
			self.notifyicon.alpha = 1;
			param_00.overlayoffsety = 0;
			self.notifyoverlay maps\mp\gametypes\_hud_util::func_708F(self.notifyicon);
			self.notifyoverlay maps\mp\gametypes\_hud_util::func_70A4("CENTER","CENTER",0,param_00.overlayoffsety);
			self.notifyoverlay setmaterial(param_00.iconoverlay,511,511);
			self.notifyoverlay.alpha = 0;
			self.notifyoverlay.color = game["colors"]["orange"];
			self.notifyoverlay fadeovertime(0.4);
			self.notifyoverlay.alpha = 0.85;
			self.notifyoverlay scaleovertime(0.4,32,32);
			func_8B10(var_02);
			self.notifyicon fadeovertime(0.75);
			self.notifyicon.alpha = 0;
			self.notifyoverlay fadeovertime(0.75);
			self.notifyoverlay.alpha = 0;
		}
		else
		{
			self.notifyicon fadeovertime(1);
			self.notifyicon.alpha = 1;
			func_8B10(var_02);
			self.notifyicon fadeovertime(0.75);
			self.notifyicon.alpha = 0;
		}
	}
	else
	{
		func_8B10(var_02);
	}

	self notify("notifyMessageDone");
	self.doingsplash[var_01] = undefined;
	if(self.splashqueue[var_01].size)
	{
		thread dispatchnotify(var_01);
	}
}

//Function Number: 11
func_4B46(param_00,param_01,param_02)
{
	if(!isplayer(self))
	{
	}

	self endon("disconnect");
	waittillframeend;
	if(level.gameended)
	{
	}

	var_03 = addstruct();
	if(isdefined(param_02))
	{
		param_00 = param_00 + "_" + param_02;
	}

	var_03.name = param_00;
	var_03.type = tablelookup(func_39BA(),0,param_00,11);
	var_03.optionalnumber = param_01;
	var_03.sound = maps\mp\_utility::func_3B02(param_00);
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
func_1ACA(param_00)
{
	if(!isplayer(self))
	{
	}

	self endon("disconnect");
	waittillframeend;
	wait(0.05);
	var_01 = maps\mp\gametypes\_hud_util::ch_getstate(param_00) - 1;
	var_02 = maps\mp\gametypes\_hud_util::ch_gettarget(param_00,var_01);
	if(var_02 == 0)
	{
		var_02 = 1;
	}

	if(param_00 == "ch_longersprint_pro" || param_00 == "ch_longersprint_pro_daily" || param_00 == "ch_longersprint_pro_weekly")
	{
		var_02 = castint(var_02 / 528);
	}

	var_03 = addstruct();
	var_03.name = param_00;
	var_03.type = tablelookup(func_39BA(),0,param_00,11);
	var_03.optionalnumber = var_02;
	var_03.sound = tablelookup(func_39BA(),0,param_00,9);
	var_03.slot = 1;
	thread actionnotify(var_03);
}

//Function Number: 14
func_794C(param_00,param_01)
{
	if(!isplayer(self))
	{
	}

	self endon("disconnect");
	wait(0.05);
	var_02 = addstruct();
	var_02.name = param_00;
	var_02.type = tablelookup(func_39BA(),0,param_00,11);
	var_02.optionalnumber = param_01;
	var_02.sound = tablelookup(func_39BA(),0,var_02.name,9);
	var_02.slot = 0;
	thread actionnotify(var_02);
}

//Function Number: 15
func_794E(param_00,param_01)
{
	if(!isplayer(self))
	{
	}

	self endon("disconnect");
	wait(0.05);
	var_02 = addstruct();
	var_02.name = param_00;
	var_02.type = tablelookup(func_39BA(),0,param_00,11);
	var_02.optionalnumber = param_01;
	var_02.sound = tablelookup(func_39BA(),0,param_00,9);
	var_02.slot = 0;
	thread actionnotify(var_02);
}

//Function Number: 16
func_794D(param_00,param_01)
{
	if(!isplayer(self))
	{
	}

	self endon("disconnect");
	waittillframeend;
	if(level.gameended)
	{
	}

	var_02 = addstruct();
	var_02.name = param_00;
	var_02.type = tablelookup(func_39BA(),0,param_00,11);
	var_02.optionalnumber = param_01;
	var_02.sound = tablelookup(func_39BA(),0,param_00,9);
	var_02.slot = 0;
	thread actionnotify(var_02);
}

//Function Number: 17
func_5F9A(param_00,param_01,param_02)
{
	if(!isplayer(self))
	{
	}

	self endon("disconnect");
	waittillframeend;
	if(level.gameended)
	{
	}

	var_03 = addstruct();
	var_03.name = param_00;
	var_03.type = tablelookup(func_39BA(),0,param_00,11);
	var_03.optionalnumber = param_02;
	var_03.sound = tablelookup(func_39BA(),0,param_00,9);
	var_03.playercardplayer = param_01;
	var_03.slot = 1;
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
	}
	else
	{
		switch(param_00.type)
		{
			case "urgent_splash":
			case "mp_dig_all_perks_splash":
				self.notifytext.alpha = 0;
				self.notifytext2.alpha = 0;
				self.notifyicon.alpha = 0;
				self setclientomnvar("ui_splash_idx",-1);
				self setclientomnvar("ui_splash_killstreak_idx",-1);
				self setclientomnvar("ui_dig_killstreak_show",-1);
				thread actionnotifymessage(param_00);
				break;

			case "killstreak_splash":
			case "splash":
				if(self.doingsplash[var_01].type != "splash" && self.doingsplash[var_01].type != "urgent_splash" && self.doingsplash[var_01].type != "killstreak_splash" && self.doingsplash[var_01].type != "challenge_splash" && self.doingsplash[var_01].type != "promotion_splash" && self.doingsplash[var_01].type != "intel_splash")
				{
					self.notifytext.alpha = 0;
					self.notifytext2.alpha = 0;
					self.notifyicon.alpha = 0;
					thread actionnotifymessage(param_00);
				}
				break;
		}
	}

	if(param_00.type == "challenge_splash" || param_00.type == "killstreak_splash")
	{
		if(param_00.type == "killstreak_splash")
		{
			removetypefromqueue("killstreak_splash",var_01);
		}

		for(var_02 = self.splashqueue[var_01].size;var_02 > 0;var_02--)
		{
			self.splashqueue[var_01][var_02] = self.splashqueue[var_01][var_02 - 1];
		}

		self.splashqueue[var_01][0] = param_00;
	}

	self.splashqueue[var_01][self.splashqueue[var_01].size] = param_00;
}

//Function Number: 19
removetypefromqueue(param_00,param_01)
{
	var_02 = [];
	for(var_03 = 0;var_03 < self.splashqueue[param_01].size;var_03++)
	{
		if(self.splashqueue[param_01][var_03].type != "killstreak_splash")
		{
			var_02[var_02.size] = self.splashqueue[param_01][var_03];
		}
	}

	self.splashqueue[param_01] = var_02;
}

//Function Number: 20
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
	}

	if(tablelookup(func_39BA(),0,param_00.name,0) != "")
	{
		var_02 = tablelookuprownum(func_39BA(),0,param_00.name);
		var_03 = maps\mp\_utility::func_7CE9(tablelookupbyrow(func_39BA(),var_02,4));
		switch(param_00.type)
		{
			case "killstreak_splash":
				self setclientomnvar("ui_splash_killstreak_idx",var_02);
				if(isdefined(param_00.playercardplayer) && param_00.playercardplayer != self)
				{
					self setclientomnvar("ui_splash_killstreak_clientnum",param_00.playercardplayer getentitynumber());
				}
				else
				{
					self setclientomnvar("ui_splash_killstreak_clientnum",-1);
				}
	
				if(isdefined(param_00.optionalnumber))
				{
					self setclientomnvar("ui_splash_killstreak_optional_number",param_00.optionalnumber);
				}
				else
				{
					self setclientomnvar("ui_splash_killstreak_optional_number",0);
				}
				break;

			case "playercard_splash":
				if(isdefined(param_00.playercardplayer))
				{
					self setclientomnvar("ui_splash_playercard_idx",var_02);
					self setclientomnvar("ui_splash_playercard_clientnum",param_00.playercardplayer getentitynumber());
					if(isdefined(param_00.optionalnumber))
					{
						self setclientomnvar("ui_splash_playercard_optional_number",param_00.optionalnumber);
					}
				}
				break;

			case "intel_splash":
			case "urgent_splash":
			case "splash":
				self setclientomnvar("ui_splash_idx",var_02);
				if(isdefined(param_00.optionalnumber))
				{
					self setclientomnvar("ui_splash_optional_number",param_00.optionalnumber);
				}
				break;

			case "perk_challenge_splash":
			case "challenge_splash":
				self setclientomnvar("ui_challenge_splash_idx",var_02);
				if(isdefined(param_00.optionalnumber))
				{
					self setclientomnvar("ui_challenge_splash_optional_number",param_00.optionalnumber);
				}
				break;

			case "mp_dig_all_perks_splash":
				self setclientomnvar("ui_dig_killstreak_show",1);
				break;

			default:
				break;
		}

		self.doingsplash[var_01] = param_00;
		if(isdefined(param_00.sound))
		{
			self playlocalsound(param_00.sound);
		}

		if(isdefined(param_00.leadersound))
		{
			if(isdefined(param_00.leadersoundgroup))
			{
				maps\mp\_utility::func_4D35(param_00.leadersound,param_00.leadersoundgroup,1);
			}
			else
			{
				maps\mp\_utility::func_4D35(param_00.leadersound);
			}
		}

		self notify("actionNotifyMessage" + var_01);
		self endon("actionNotifyMessage" + var_01);
		wait(var_03 + 0.5);
		self.doingsplash[var_01] = undefined;
	}

	if(self.splashqueue[var_01].size)
	{
		thread dispatchnotify(var_01);
	}
}

//Function Number: 21
func_8B10(param_00)
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

//Function Number: 22
canreadtext()
{
	if(maps\mp\_flashgrenades::func_48C3())
	{
		return 0;
	}

	return 1;
}

//Function Number: 23
func_6614()
{
	self endon("notifyMessageDone");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("death");
	func_6611();
}

//Function Number: 24
resetoncancel()
{
	self notify("resetOnCancel");
	self endon("resetOnCancel");
	self endon("notifyMessageDone");
	self endon("disconnect");
	level waittill("cancel_notify");
	func_6611();
}

//Function Number: 25
func_6611()
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

//Function Number: 26
func_4261()
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

//Function Number: 27
func_4FA4()
{
	self endon("disconnect");
	self.lowermessages = [];
	var_00 = "default";
	if(isdefined(level.lowermessagefont))
	{
		var_00 = level.lowermessagefont;
	}

	var_01 = level.lowertexty;
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
	self.lowermessage maps\mp\gametypes\_hud_util::func_70A4("CENTER",level.lowertextyalign,0,var_01);
	self.lowertimer = maps\mp\gametypes\_hud_util::createfontstring("default",var_03);
	self.lowertimer maps\mp\gametypes\_hud_util::func_708F(self.lowermessage);
	self.lowertimer maps\mp\gametypes\_hud_util::func_70A4("TOP","BOTTOM",0,0);
	self.lowertimer settext("");
	self.lowertimer.archived = 0;
	self.lowertimer.sort = 10;
	self.lowertimer.showinkillcam = 0;
}

//Function Number: 28
func_5A24(param_00)
{
	if(level.teambased)
	{
		if(param_00 == "tie")
		{
			matchoutcomenotify("draw");
		}

		if(param_00 == self.team)
		{
			matchoutcomenotify("victory");
		}

		matchoutcomenotify("defeat");
	}

	if(param_00 == self)
	{
		matchoutcomenotify("victory");
	}

	matchoutcomenotify("defeat");
}

//Function Number: 29
matchoutcomenotify(param_00)
{
	var_01 = self.team;
	var_02 = maps\mp\gametypes\_hud_util::createfontstring("bigfixed",1);
	var_02 maps\mp\gametypes\_hud_util::func_70A4("TOP",undefined,0,50);
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
			var_02.glowcolor = game["colors"]["cyan"];
			break;

		default:
			var_02.glowcolor = game["colors"]["orange"];
			break;
	}

	var_03 = maps\mp\gametypes\_hud_util::func_20FC(game["icons"][var_01],64,64);
	var_03 maps\mp\gametypes\_hud_util::func_708F(var_02);
	var_03 maps\mp\gametypes\_hud_util::func_70A4("TOP","BOTTOM",0,30);
	var_03.foreground = 1;
	var_03.hidewheninmenu = 0;
	var_03.archived = 0;
	var_03.alpha = 0;
	var_03 fadeovertime(0.5);
	var_03.alpha = 1;
	wait(3);
	var_02 maps\mp\gametypes\_hud_util::destroyelem();
	var_03 maps\mp\gametypes\_hud_util::destroyelem();
}

//Function Number: 30
func_48AF()
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

//Function Number: 31
func_7F9F(param_00,param_01,param_02)
{
	self endon("disconnect");
	self notify("reset_outcome");
	self setclientomnvar("ui_round_end_update_data",0);
	self setclientomnvar("ui_round_end",1);
	wait(0.5);
	var_03 = self.pers["team"];
	if(self setmlgcameradefaults())
	{
		var_03 = self setmlgspectator();
	}

	if(!isdefined(var_03) || var_03 != "allies" && var_03 != "axis")
	{
		var_03 = "allies";
	}

	while(func_48AF())
	{
		wait(0.05);
	}

	self endon("reset_outcome");
	if(param_00 == "halftime")
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["halftime"]);
		param_00 = "allies";
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
	else if(param_00 == "overtime")
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["overtime"]);
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
	else if(self setmlgcameradefaults())
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["spectator"]);
	}
	else if(isdefined(self.pers["team"]) && param_00 == var_03)
	{
		if(param_01)
		{
			self setclientomnvar("ui_round_end_title",game["round_end"]["round_win"]);
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
	if(!maps\mp\_utility::func_4950() || !maps\mp\_utility::func_491C() || level.gametype == "Blitz")
	{
		self setclientomnvar("ui_round_end_friendly_score",maps\mp\gametypes\_gamescore::func_6A3(var_03));
		self setclientomnvar("ui_round_end_enemy_score",maps\mp\gametypes\_gamescore::func_6A3(level.otherteam[var_03]));
	}
	else
	{
		self setclientomnvar("ui_round_end_friendly_score",game["roundsWon"][var_03]);
		self setclientomnvar("ui_round_end_enemy_score",game["roundsWon"][level.otherteam[var_03]]);
	}

	if(isdefined(self.matchbonus))
	{
		self setclientomnvar("ui_round_end_match_bonus",self.matchbonus);
	}

	self setclientomnvar("ui_round_end_update_data",1);
}

//Function Number: 32
func_5A23(param_00,param_01)
{
	self endon("disconnect");
	self notify("reset_outcome");
	self setclientomnvar("ui_round_end_update_data",0);
	self setclientomnvar("ui_round_end",1);
	wait(0.5);
	while(func_48AF())
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

	self setclientomnvar("ui_round_end_update_data",1);
	self waittill("update_outcome");
}

//Function Number: 33
func_19FD(param_00)
{
}

//Function Number: 34
func_39BA()
{
	if(maps\mp\_utility::func_47BB())
	{
		return "mp/alien/splashTable.csv";
	}

	return "mp/splashTable.csv";
}