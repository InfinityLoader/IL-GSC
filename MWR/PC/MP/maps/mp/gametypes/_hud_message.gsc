/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_hud_message.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 35
 * Decompile Time: 649 ms
 * Timestamp: 10/27/2023 2:41:39 AM
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
	game["end_reason"]["score_limit_reached"] = 1;
	game["end_reason"]["time_limit_reached"] = 2;
	game["end_reason"]["players_forfeited"] = 3;
	game["end_reason"]["target_destroyed"] = 4;
	game["end_reason"]["bomb_defused"] = 5;
	game["end_reason"]["allies_eliminated"] = 6;
	game["end_reason"]["axis_eliminated"] = 7;
	game["end_reason"]["allies_forfeited"] = 8;
	game["end_reason"]["axis_forfeited"] = 9;
	game["end_reason"]["allies_mission_accomplished"] = 10;
	game["end_reason"]["axis_mission_accomplished"] = 11;
	game["end_reason"]["enemies_eliminated"] = 12;
	game["end_reason"]["tie"] = 13;
	game["end_reason"]["objective_completed"] = 14;
	game["end_reason"]["objective_failed"] = 15;
	game["end_reason"]["switching_sides"] = 16;
	game["end_reason"]["round_limit_reached"] = 17;
	game["end_reason"]["ended_game"] = 18;
	game["end_reason"]["host_ended_game"] = 19;
	game["end_reason"]["stat_loss_prevention"] = 20;
	game["end_reason"]["survivors_eliminated"] = 99;
	game["end_reason"]["zombies_completed"] = 99;
	game["end_reason"]["zombie_extraction_failed"] = 99;
	game["end_reason"]["survivors_eliminated"] = 99;
	game["end_reason"]["infected_eliminated"] = 99;
	game["end_reason"]["survivors_forfeited"] = 99;
	game["end_reason"]["infected_forfeited"] = 99;
	game["strings"]["overtime"] = &"MP_OVERTIME";
	level.lua_splash_type_none = 0;
	level.lua_splash_type_killstreak = 1;
	level.lua_splash_type_medal = 2;
	level.lua_splash_type_challenge = 3;
	level.lua_splash_type_rankup = 4;
	level.lua_splash_type_generic = 5;
	level thread onplayerconnect();
	setdvar("scr_lua_splashes","1");
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread lowermessagethink();
		var_00 thread initnotifymessage();
		var_00 thread manageluasplashtimers();
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
	if(level.splitscreen || self issplitscreenplayerprimary())
	{
		var_00 = 1.5;
		var_01 = 1.85;
		var_02 = 24;
		var_03 = "objective";
		var_04 = "TOP";
		var_05 = "BOTTOM";
		var_06 = 94;
		var_07 = 0;
	}
	else
	{
		var_00 = 2.5;
		var_01 = 1.35;
		var_02 = 30;
		var_03 = "objective";
		var_04 = "TOP";
		var_05 = "BOTTOM";
		var_06 = 94;
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
	if(!isdefined(var_01))
	{
		return;
	}

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
	if(maps\mp\_utility::is_true(param_00.resetondeath))
	{
		self endon("death");
	}

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
	if(maps\mp\_utility::is_true(param_00.resetondeath))
	{
		thread resetondeath();
	}

	thread resetoncancel();
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
		if(level.splitscreen || self issplitscreenplayerprimary())
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
	if(!isdefined(self))
	{
		return;
	}

	if(level.gameended)
	{
		return;
	}

	if(isdefined(param_02))
	{
		param_00 = param_00 + "_" + param_02;
	}

	if(!isdefined(param_04))
	{
		param_04 = -1;
	}

	if(getdvarint("scr_lua_splashes"))
	{
		var_05 = tablelookuprownum("mp/splashTable.csv",0,param_00);
		if(var_05 >= 0)
		{
			self method_8561(&"killstreak_splash",3,var_05,param_01,param_04);
			self method_8579(&"killstreak_splash",3,var_05,param_01,param_04);
			insertluasplash(level.lua_splash_type_killstreak,var_05);
		}

		return;
	}

	var_06 = spawnstruct();
	var_06.name = param_01;
	var_06.type = tablelookup(get_table_name(),0,param_01,11);
	var_06.optionalnumber = param_02;
	var_06.sound = maps\mp\_utility::getkillstreaksound(param_01);
	var_06.leadersound = param_01;
	var_06.leadersoundgroup = "killstreak_earned";
	var_06.slot = 0;
	var_06.killstreakslot = var_05;
	if(isdefined(param_04) && isarray(param_04))
	{
		if(param_04.size > 0)
		{
			var_06.module1idx = tablelookuprownum(level.ks_modules_table,level.ks_module_ref_column,param_04[0]);
		}

		if(param_04.size > 1)
		{
			var_06.module2idx = tablelookuprownum(level.ks_modules_table,level.ks_module_ref_column,param_04[1]);
		}

		if(param_04.size > 2)
		{
			var_06.module3idx = tablelookuprownum(level.ks_modules_table,level.ks_module_ref_column,param_04[2]);
		}
	}

	thread actionnotify(var_06);
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

		if(getdvarint("scr_lua_splashes"))
		{
			var_05 = tablelookup("mp/allChallengesTable.csv",0,param_00,28);
			if(var_05 != "")
			{
				var_06 = int(var_05);
				self method_8561(&"challenge_splash",3,var_06,var_03,var_04);
				self method_8579(&"challenge_splash",3,var_06,var_03,var_04);
				insertluasplash(level.lua_splash_type_challenge,var_06);
			}

			continue;
		}

		var_07 = spawnstruct();
		var_07.name = param_00;
		var_07.type = tablelookup(get_table_name(),0,param_00,11);
		var_07.challengetier = var_03;
		var_07.optionalnumber = var_04;
		var_07.sound = tablelookup(get_table_name(),0,param_00,9);
		var_07.slot = 0;
		thread actionnotify(var_07);
	}
}

//Function Number: 13
medalsplashnotify(param_00)
{
	if(getdvarint("scr_lua_splashes"))
	{
		var_01 = tablelookuprownum("mp/splashTable.csv",0,param_00);
		if(var_01 >= 0)
		{
			self method_8561(&"medal_splash",1,var_01);
			self method_8579(&"medal_splash",1,var_01);
			insertluasplash(level.lua_splash_type_medal,var_01);
			return;
		}

		return;
	}

	splashnotify(param_00);
}

//Function Number: 14
splashnotify(param_00,param_01,param_02)
{
	if(!isplayer(self))
	{
		return;
	}

	if(getdvarint("scr_lua_splashes"))
	{
		var_03 = tablelookuprownum("mp/splashTable.csv",0,param_00);
		if(var_03 >= 0)
		{
			if(isdefined(param_01))
			{
				self method_8561(&"generic_splash_number",2,var_03,param_01);
				self method_8562(&"generic_splash_number",2,var_03,param_01);
			}
			else
			{
				self method_8561(&"generic_splash",1,var_03);
				self method_8562(&"generic_splash",1,var_03);
			}

			insertluasplash(level.lua_splash_type_generic,var_03);
		}

		return;
	}

	self endon("disconnect");
	wait(0.05);
	var_04 = spawnstruct();
	var_04.name = param_01;
	var_04.type = tablelookup(get_table_name(),0,param_01,11);
	var_04.optionalnumber = param_02;
	var_04.sound = tablelookup(get_table_name(),0,var_04.name,9);
	if(!isdefined(var_03))
	{
		var_03 = -1;
	}

	var_04.killstreakslot = var_03;
	var_04.slot = 0;
	thread actionnotify(var_04);
}

//Function Number: 15
rankupsplashnotify(param_00,param_01,param_02)
{
	if(!isplayer(self))
	{
		return;
	}

	self endon("disconnect");
	waittillframeend;
	if(!isdefined(self))
	{
		return;
	}

	if(level.gameended)
	{
		return;
	}

	if(getdvarint("scr_lua_splashes"))
	{
		var_03 = tablelookuprownum("mp/splashTable.csv",0,param_00);
		if(var_03 >= 0)
		{
			self method_8561(&"rankup_splash",3,var_03,param_01,param_02);
			self method_8579(&"rankup_splash",3,var_03,param_01,param_02);
			insertluasplash(level.lua_splash_type_rankup,var_03);
		}

		return;
	}

	var_04 = spawnstruct();
	var_04.name = param_01;
	var_04.type = tablelookup(get_table_name(),0,param_01,11);
	var_04.sound = tablelookup(get_table_name(),0,param_01,9);
	var_04.rank = param_02;
	var_04.prestige = var_03;
	var_04.slot = 0;
	thread actionnotify(var_04);
}

//Function Number: 16
playercardsplashnotify(param_00,param_01,param_02)
{
	if(!isplayer(self))
	{
		return;
	}

	self endon("disconnect");
	waittillframeend;
	if(!isdefined(self))
	{
		return;
	}

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
	else
	{
		switch(param_00.type)
		{
			case "urgent_splash":
				break;

			case "killstreak_coop_splash":
			case "killstreak_splash":
			case "splash":
				break;
		}
	}
}

//Function Number: 18
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

	if(tablelookup(get_table_name(),0,param_00.name,0) != "")
	{
		var_02 = tablelookuprownum(get_table_name(),0,param_00.name);
		var_03 = maps\mp\_utility::stringtofloat(tablelookupbyrow(get_table_name(),var_02,4));
		switch(param_00.type)
		{
			case "killstreak_coop_splash":
			case "killstreak_splash":
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

//Function Number: 19
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

//Function Number: 20
canreadtext()
{
	if(maps\mp\_flashgrenades::isflashbanged())
	{
		return 0;
	}

	return 1;
}

//Function Number: 21
resetondeath()
{
	self endon("notifyMessageDone");
	self endon("disconnect");
	self waittill("death");
	resetnotify();
}

//Function Number: 22
resetoncancel()
{
	self notify("resetOnCancel");
	self endon("resetOnCancel");
	self endon("notifyMessageDone");
	self endon("disconnect");
	level waittill("cancel_notify");
	resetnotify();
}

//Function Number: 23
resetnotify()
{
	self.notifytitle fadeovertime(0.05);
	self.notifytitle.alpha = 0;
	self.notifytext.alpha = 0;
	self.notifyicon.alpha = 0;
	self.notifyoverlay.alpha = 0;
	self.doingsplash[0] = undefined;
	self.doingsplash[1] = undefined;
	self.doingsplash[2] = undefined;
	self.doingsplash[3] = undefined;
}

//Function Number: 24
lowermessagethink()
{
	self endon("disconnect");
	self.lowermessages = [];
	var_00 = "objective";
	if(isdefined(level.lowermessagefont))
	{
		var_00 = level.lowermessagefont;
	}

	var_01 = -140;
	var_02 = level.lowertextfontsize;
	var_03 = 1.25;
	if(level.splitscreen || self issplitscreenplayerprimary() && !isai(self))
	{
		var_02 = level.lowertextfontsize * 1.4;
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

//Function Number: 25
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

//Function Number: 26
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

//Function Number: 27
isdoingsplash()
{
	if(isdefined(self.doingsplash))
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
	}

	if(isdoingluasplash())
	{
		return 1;
	}

	return 0;
}

//Function Number: 28
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
	else if(self method_842D())
	{
		self setclientomnvar("ui_round_end_title",game["round_end"]["spectator"]);
	}
	else if(isdefined(self.pers["team"]) && param_00 == var_04)
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
	if(var_05 && !level.winbycaptures)
	{
		self setclientomnvar("ui_round_end_friendly_score",game["roundsWon"][var_04]);
		self setclientomnvar("ui_round_end_enemy_score",game["roundsWon"][level.otherteam[var_04]]);
	}
	else if(!maps\mp\_utility::isroundbased() || !maps\mp\_utility::isobjectivebased())
	{
		self setclientomnvar("ui_round_end_friendly_score",maps\mp\gametypes\_gamescores::_getteamscore(var_04));
		self setclientomnvar("ui_round_end_enemy_score",maps\mp\gametypes\_gamescores::_getteamscore(level.otherteam[var_04]));
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

//Function Number: 29
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

//Function Number: 30
canshowsplash(param_00)
{
}

//Function Number: 31
lerpscreenblurup(param_00,param_01)
{
	self setblurforplayer(param_00,param_01);
}

//Function Number: 32
get_table_name()
{
	return "mp/splashTable.csv";
}

//Function Number: 33
isdoingluasplash()
{
	return maps\mp\_utility::is_true(self.luasplashactive);
}

//Function Number: 34
manageluasplashtimers()
{
	self endon("disconnect");
	self.luasplashactive = 0;
	self.luasplashqueue = [];
	self.luasplashcurrenttype = level.lua_splash_type_none;
	self.luasplashnextintrocompletetime = 0;
	self.luasplashnextoutrocompletetime = 0;
	for(;;)
	{
		if(!self.luasplashqueue.size)
		{
			self waittill("luaSplashTimerUpdate");
		}

		if(!self.luasplashqueue.size)
		{
			continue;
		}

		var_00 = self.luasplashqueue[0];
		self.luasplashqueue = maps\mp\_utility::array_remove_index(self.luasplashqueue,0);
		self.luasplashcurrenttype = var_00.splashtype;
		if(var_00.splashtype == level.lua_splash_type_killstreak)
		{
			var_01 = int(1000 * float(tablelookupbyrow("mp/splashTable.csv",var_00.splashdata,4)));
			if(!var_01)
			{
				continue;
			}

			self.luasplashnextintrocompletetime = gettime() + var_01;
			self.luasplashnextoutrocompletetime = gettime() + var_01;
		}
		else if(var_00.splashtype == level.lua_splash_type_medal)
		{
			var_01 = int(1000 * float(tablelookupbyrow("mp/splashTable.csv",var_00.splashdata,4)));
			if(!var_01)
			{
				continue;
			}

			self.luasplashnextintrocompletetime = gettime() + 250;
			self.luasplashnextoutrocompletetime = gettime() + var_01;
		}
		else if(var_00.splashtype == level.lua_splash_type_challenge)
		{
			var_02 = tablelookup("mp/allchallengestable.csv",28,var_00.splashdata,0);
			if(var_02 == "")
			{
				continue;
			}

			var_01 = int(1000 * float(tablelookup("mp/splashTable.csv",0,var_02,4)));
			if(!var_01)
			{
				continue;
			}

			self.luasplashnextintrocompletetime = gettime() + var_01;
			self.luasplashnextoutrocompletetime = gettime() + var_01;
		}
		else if(var_00.splashtype == level.lua_splash_type_rankup)
		{
			var_01 = int(1000 * float(tablelookupbyrow("mp/splashTable.csv",var_00.splashdata,4)));
			if(!var_01)
			{
				continue;
			}

			self.luasplashnextintrocompletetime = gettime() + var_01;
			self.luasplashnextoutrocompletetime = gettime() + var_01;
		}
		else
		{
			var_01 = int(1000 * float(tablelookupbyrow("mp/splashTable.csv",var_00.splashdata,4)));
			if(!var_01)
			{
				continue;
			}

			self.luasplashnextintrocompletetime = gettime() + 250;
			self.luasplashnextoutrocompletetime = gettime() + var_01;
		}

		self.luasplashactive = 1;
		if(gettime() < self.luasplashnextintrocompletetime)
		{
			var_03 = self.luasplashnextintrocompletetime - gettime() * 0.001;
			wait(var_03);
		}

		while(gettime() < self.luasplashnextoutrocompletetime)
		{
			if(self.luasplashqueue.size > 0)
			{
				if(self.luasplashcurrenttype == level.lua_splash_type_none || self.luasplashqueue[0].splashtype == self.luasplashcurrenttype)
				{
					break;
				}
			}

			var_03 = self.luasplashnextoutrocompletetime - gettime() * 0.001;
			common_scripts\utility::waittill_notify_or_timeout("luaSplashTimerUpdate",var_03);
		}

		self.luasplashactive = 0;
	}
}

//Function Number: 35
insertluasplash(param_00,param_01)
{
	if(!isdefined(self.luasplashqueue))
	{
		return;
	}

	if(param_00 == level.lua_splash_type_medal)
	{
		for(var_02 = 0;var_02 < self.luasplashqueue.size;var_02++)
		{
			if(self.luasplashqueue[var_02].splashtype == param_00 && self.luasplashqueue[var_02].splashdata == param_01)
			{
				return;
			}
		}
	}

	var_03 = spawnstruct();
	var_03.splashtype = param_00;
	var_03.splashdata = param_01;
	if(param_00 == level.lua_splash_type_killstreak)
	{
		var_04 = undefined;
		for(var_02 = 0;var_02 < self.luasplashqueue.size;var_02++)
		{
			if(self.luasplashqueue[var_02].splashtype != level.lua_splash_type_killstreak)
			{
				var_04 = var_02;
				break;
			}
		}

		if(isdefined(var_04))
		{
			self.luasplashqueue = common_scripts\utility::array_insert(self.luasplashqueue,var_03,var_04);
			self notify("luaSplashTimerUpdate");
			return;
		}
	}

	self.luasplashqueue[self.luasplashqueue.size] = var_03;
	self notify("luaSplashTimerUpdate");
}