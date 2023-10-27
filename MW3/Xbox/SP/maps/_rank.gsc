/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_rank.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 40
 * Decompile Time: 716 ms
 * Timestamp: 10/27/2023 2:32:29 AM
*******************************************************************/

//Function Number: 1
init()
{
	maps\_hud::init();
	precachestring(&"RANK_PLAYER_WAS_PROMOTED_N");
	precachestring(&"RANK_PLAYER_WAS_PROMOTED");
	precachestring(&"RANK_PROMOTED");
	precachestring(&"RANK_ROMANI");
	precachestring(&"RANK_ROMANII");
	precachestring(&"RANK_ROMANIII");
	precachestring(&"SCRIPT_PLUS");
	precacheshader("line_horizontal");
	precacheshader("line_vertical");
	precacheshader("gradient_fadein");
	precacheshader("white");
	level.maxrank = int(tablelookup("sp/rankTable.csv",0,"maxrank",1));
	level.var_80DF = int(tablelookup("sp/rankTable.csv",0,level.maxrank,7));
	var_00 = 0;
	for(var_00 = 0;var_00 <= level.maxrank;var_00++)
	{
		precacheshader(tablelookup("sp/rankTable.csv",0,var_00,6));
	}

	var_01 = 0;
	var_02 = tablelookup("sp/ranktable.csv",0,var_01,1);
	while(isdefined(var_02) && var_02 != "")
	{
		level.ranktable[var_01][1] = tablelookup("sp/ranktable.csv",0,var_01,1);
		level.ranktable[var_01][2] = tablelookup("sp/ranktable.csv",0,var_01,2);
		level.ranktable[var_01][3] = tablelookup("sp/ranktable.csv",0,var_01,3);
		level.ranktable[var_01][7] = tablelookup("sp/ranktable.csv",0,var_01,7);
		precachestring(tablelookupistring("sp/ranktable.csv",0,var_01,10));
		var_01++;
		var_02 = tablelookup("sp/ranktable.csv",0,var_01,1);
	}

	maps\_missions::buildchallengeinfo();
}

//Function Number: 2
xp_init()
{
	xp_setup();
	foreach(var_01 in level.players)
	{
		var_01 thread xp_player_init();
		var_01 thread maps\_missions::updatechallenges();
	}
}

//Function Number: 3
xp_player_init()
{
	if(!isdefined(self.var_E96))
	{
		self.var_E96["rankxp"] = self getplayerdata("experience");
		self.var_E96["rank"] = getrankforxp(self.var_E96["rankxp"]);
	}

	self.rankupdatetotal = 0;
	self.hud_rankscroreupdate = newclienthudelem(self);
	self.hud_rankscroreupdate.horzalign = "center";
	self.hud_rankscroreupdate.vertalign = "middle";
	self.hud_rankscroreupdate.alignx = "center";
	self.hud_rankscroreupdate.aligny = "middle";
	self.hud_rankscroreupdate.x = 0;
	self.hud_rankscroreupdate.y = -60;
	self.hud_rankscroreupdate.font = "hudbig";
	self.hud_rankscroreupdate.fontscale = 0.75;
	self.hud_rankscroreupdate.archived = 0;
	self.hud_rankscroreupdate.color = (0.75,1,0.75);
	self.hud_rankscroreupdate fontpulseinit();
}

//Function Number: 4
xp_bar_client_elem(param_00)
{
	var_01 = newclienthudelem(param_00);
	var_01.x = func_0E9A() / 2 * -1;
	var_01.y = 0;
	var_01.sort = 5;
	var_01.horzalign = "center_adjustable";
	var_01.vertalign = "bottom_adjustable";
	var_01.alignx = "left";
	var_01.aligny = "bottom";
	var_01 setshader("gradient_fadein",get_xpbarwidth(),4);
	var_01.color = (1,0.8,0.4);
	var_01.alpha = 0.65;
	var_01.foreground = 1;
	return var_01;
}

//Function Number: 5
func_0E9A()
{
	if(issplitscreen())
	{
		return 726;
	}

	return 540;
}

//Function Number: 6
xpbar_update()
{
	if(!get_xpbarwidth())
	{
		self.hud_xpbar.alpha = 0;
	}
	else
	{
		self.hud_xpbar.alpha = 0.65;
	}

	self.hud_xpbar setshader("gradient_fadein",get_xpbarwidth(),4);
}

//Function Number: 7
get_xpbarwidth()
{
	var_00 = int(tablelookup("sp/rankTable.csv",0,self.var_E96["rank"],3));
	var_01 = int(self.var_E96["rankxp"] - int(tablelookup("sp/rankTable.csv",0,self.var_E96["rank"],2)));
	var_02 = func_0E9A();
	var_03 = int(var_02 * var_01 / var_00);
	return var_03;
}

//Function Number: 8
xp_setup()
{
	if(!isdefined(level.scoreinfo) || !isdefined(level.scoreinfo.size))
	{
		level.scoreinfo = [];
	}

	level.xpscale = 1;
	if(level.console)
	{
		level.xpscale = 1;
	}

	registerscoreinfo("kill",100);
	registerscoreinfo("headshot",100);
	registerscoreinfo("assist",20);
	registerscoreinfo("suicide",0);
	registerscoreinfo("teamkill",0);
	registerscoreinfo("completion_xp",5000);
	level notify("rank_score_info_defaults_set");
}

//Function Number: 9
givexp_think()
{
	self waittill("death",var_00,var_01,var_02);
	if(isdefined(var_00) && isdefined(var_00.classname) && var_00.classname == "worldspawn" && isdefined(self.last_dmg_player))
	{
		var_00 = self.last_dmg_player;
	}

	givexp_helper(var_00);
}

//Function Number: 10
givexp_helper(param_00)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(isai(param_00) && param_00 isbadguy())
	{
		return;
	}

	if(is_special_targetname_attacker(param_00))
	{
		if(isdefined(param_00.attacker))
		{
			thread givexp_helper(param_00.attacker);
			return;
		}

		if(isdefined(param_00.damageowner))
		{
			thread givexp_helper(param_00.damageowner);
			return;
		}
	}

	if(isplayer(param_00))
	{
		if(isdefined(level.givexp_kill_func))
		{
			param_00 thread [[ level.givexp_kill_func ]](self);
		}
		else
		{
			param_00 thread maps\_utility::func_E86("kill");
		}
	}

	if(maps\_utility::is_survival())
	{
		if(isai(param_00) && !param_00 isbadguy() && isdefined(param_00.owner) && isplayer(param_00.owner))
		{
			if(isdefined(level.givexp_kill_func))
			{
				param_00.owner thread [[ level.givexp_kill_func ]](self);
			}
			else
			{
				param_00.owner thread maps\_utility::func_E86("kill");
			}
		}
	}

	if(!isplayer(param_00) && !isai(param_00))
	{
		return;
	}

	if(!param_00 isbadguy() && isdefined(self.attacker_list) && self.attacker_list.size)
	{
		for(var_01 = 0;var_01 < self.attacker_list.size;var_01++)
		{
			if(isplayer(self.attacker_list[var_01]) && self.attacker_list[var_01] != param_00)
			{
				if(isdefined(self.var_EA6))
				{
					self.attacker_list[var_01] thread maps\_utility::func_E86("assist",self.var_EA6);
					continue;
				}

				self.attacker_list[var_01] thread maps\_utility::func_E86("assist");
			}
		}
	}
}

//Function Number: 11
is_special_targetname_attacker(param_00)
{
	if(!isdefined(param_00.targetname))
	{
		return 0;
	}

	if(issubstr(param_00.targetname,"destructible"))
	{
		return 1;
	}

	if(common_scripts\utility::string_starts_with(param_00.targetname,"sentry_"))
	{
		return 1;
	}

	return 0;
}

//Function Number: 12
ai_xp_init()
{
	thread givexp_think();
	self.attacker_list = [];
	self.last_attacked = 0;
	maps\_utility::add_damage_function(::xp_took_damage);
}

//Function Number: 13
xp_took_damage(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!isdefined(param_01))
	{
		return;
	}

	if(!isdefined(self))
	{
		return;
	}

	var_07 = gettime();
	var_08 = var_07 - self.last_attacked;
	if(var_08 <= 10000)
	{
		self.attacker_list = common_scripts\utility::array_remove(self.attacker_list,param_01);
		self.attacker_list[self.attacker_list.size] = param_01;
		self.last_attacked = gettime();
		return;
	}

	self.attacker_list = [];
	self.attacker_list[0] = param_01;
	self.last_attacked = gettime();
}

//Function Number: 14
updateplayerscore(param_00,param_01)
{
	if(!isdefined(level.xp_enable) || !level.xp_enable)
	{
		return;
	}

	if(!isdefined(param_01))
	{
		if(isdefined(level.scoreinfo[param_00]))
		{
			param_01 = getscoreinfovalue(param_00);
		}
		else
		{
			param_01 = getscoreinfovalue("kill");
		}
	}

	param_01 = int(param_01 * level.xpscale);
	if(param_00 == "assist")
	{
		if(param_01 > getscoreinfovalue("kill"))
		{
			param_01 = getscoreinfovalue("kill");
		}
	}

	thread print_score_increment(param_01);
	self.var_E96["rankxp"] = self.var_E96["rankxp"] + param_01;
	if(func_0EB5())
	{
		thread updaterankannouncehud();
	}

	if(self.var_E96["rankxp"] <= level.var_80DF)
	{
		self setplayerdata("experience",self.var_E96["rankxp"]);
	}

	if(self.var_E96["rankxp"] > level.var_80DF)
	{
		self setplayerdata("experience",level.var_80DF);
	}

	waittillframeend;
	self notify("xp_updated",param_00);
}

//Function Number: 15
print_score_increment(param_00)
{
	self notify("update_xp");
	self endon("update_xp");
	self.rankupdatetotal = self.rankupdatetotal + param_00;
	self.hud_rankscroreupdate.label = &"SCRIPT_PLUS";
	self.hud_rankscroreupdate setvalue(self.rankupdatetotal);
	self.hud_rankscroreupdate.alpha = 0.75;
	self.hud_rankscroreupdate thread fontpulse(self);
	self.hud_rankscroreupdate.x = 0;
	self.hud_rankscroreupdate.y = -60;
	wait 1;
	self.hud_rankscroreupdate fadeovertime(0.2);
	self.hud_rankscroreupdate.alpha = 0;
	self.hud_rankscroreupdate moveovertime(0.2);
	self.hud_rankscroreupdate.x = -240;
	self.hud_rankscroreupdate.y = 160;
	wait 0.5;
	self.hud_rankscroreupdate.x = 0;
	self.hud_rankscroreupdate.y = -60;
	self.rankupdatetotal = 0;
}

//Function Number: 16
fontpulseinit()
{
	self.basefontscale = self.fontscale;
	self.maxfontscale = self.fontscale * 2;
	self.inframes = 3;
	self.outframes = 5;
}

//Function Number: 17
fontpulse(param_00)
{
	self notify("fontPulse");
	self endon("fontPulse");
	var_01 = self.maxfontscale - self.basefontscale;
	while(self.fontscale < self.maxfontscale)
	{
		self.fontscale = min(self.maxfontscale,self.fontscale + var_01 / self.inframes);
		wait 0.05;
	}

	while(self.fontscale > self.basefontscale)
	{
		self.fontscale = max(self.basefontscale,self.fontscale - var_01 / self.outframes);
		wait 0.05;
	}
}

//Function Number: 18
func_0EB5()
{
	var_00 = getrank();
	if(var_00 == self.var_E96["rank"])
	{
		return 0;
	}

	var_01 = self.var_E96["rank"];
	var_02 = self.var_E96["rank"];
	self.var_E96["rank"] = var_00;
	while(var_02 <= var_00)
	{
		self.setpromotion = 1;
		var_02++;
	}

	return 1;
}

//Function Number: 19
updaterankannouncehud()
{
	self endon("disconnect");
	self notify("update_rank");
	self endon("update_rank");
	self notify("reset_outcome");
	var_00 = getrankinfofull(self.var_E96["rank"]);
	var_01 = spawnstruct();
	var_01.titletext = &"RANK_PROMOTED";
	var_01.iconname = getrankinfoicon(self.var_E96["rank"]);
	var_01.sound = "sp_level_up";
	var_01.duration = 4;
	var_02 = level.ranktable[self.var_E96["rank"]][1];
	var_03 = int(var_02[var_02.size - 1]);
	var_01.notifytext = var_00;
	if(common_scripts\utility::flag_exist("special_op_final_xp_given") && common_scripts\utility::flag("special_op_final_xp_given"))
	{
		level.eog_summary_delay = int(max(0,var_01.duration - 2));
	}

	thread func_0EBE(var_01);
	if(var_03 > 1)
	{
	}
}

//Function Number: 20
func_0EBE(param_00)
{
	self endon("death");
	self endon("disconnect");
	var_01 = 4;
	while(self.doingnotify && var_01 > 0)
	{
		var_01 = var_01 - 0.5;
		wait 0.5;
	}

	thread shownotifymessage(param_00);
}

//Function Number: 21
func_0EBF(param_00)
{
	var_01 = strtok(param_00,".");
	var_02 = int(var_01[0]);
	if(isdefined(var_01[1]))
	{
		var_03 = 1;
		for(var_04 = 0;var_04 < var_01[1].size;var_04++)
		{
			var_03 = var_03 * 0.1;
		}

		var_02 = var_02 + int(var_01[1]) * var_03;
	}

	return var_02;
}

//Function Number: 22
actionnotifymessage(param_00)
{
	self endon("death");
	self endon("disconnect");
	var_01 = param_00.slot;
	if(tablelookup("sp/splashTable.csv",0,param_00.name,0) != "")
	{
		if(isdefined(param_00.optionalnumber))
		{
			self showhudsplash(param_00.name,param_00.slot,param_00.optionalnumber);
		}
		else
		{
			self showhudsplash(param_00.name,param_00.slot);
		}

		self.doingsplash[var_01] = param_00;
		var_02 = func_0EBF(tablelookup("sp/splashTable.csv",0,param_00.name,4));
		if(isdefined(param_00.sound))
		{
			self playlocalsound(param_00.sound);
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

//Function Number: 23
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

//Function Number: 24
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

//Function Number: 25
shownotifymessage(param_00)
{
	self endon("disconnect");
	self.doingnotify = 1;
	func_0EC7(0);
	if(isdefined(param_00.duration))
	{
		var_01 = param_00.duration;
	}
	else
	{
		var_01 = 4;
	}

	thread func_0EC6();
	if(isdefined(param_00.sound))
	{
		self playlocalsound(param_00.sound);
	}

	if(isdefined(param_00.glowcolor))
	{
		var_02 = param_00.glowcolor;
	}
	else
	{
		var_02 = (0.3,0.6,0.3);
	}

	var_03 = self.notifytitle;
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

		self.notifytitle setpulsefx(100,int(var_01 * 1000),1000);
		self.notifytitle.glowcolor = var_02;
		self.notifytitle.alpha = 1;
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

		self.notifytext setpulsefx(100,int(var_01 * 1000),1000);
		self.notifytext.glowcolor = var_02;
		self.notifytext.alpha = 1;
		var_03 = self.notifytext;
	}

	if(isdefined(param_00.notifytext2))
	{
		self.notifytext2 maps\_hud_util::setparent(var_03);
		if(isdefined(param_00.text2label))
		{
			self.notifytext2.label = param_00.text2label;
		}
		else
		{
			self.notifytext2.label = &"";
		}

		self.notifytext2 settext(param_00.notifytext2);
		self.notifytext2 setpulsefx(100,int(var_01 * 1000),1000);
		self.notifytext2.glowcolor = var_02;
		self.notifytext2.alpha = 1;
		var_03 = self.notifytext2;
	}

	if(isdefined(param_00.iconname))
	{
		self.notifyicon maps\_hud_util::setparent(var_03);
		self.notifyicon setshader(param_00.iconname,60,60);
		self.notifyicon.alpha = 0;
		self.notifyicon fadeovertime(1);
		self.notifyicon.alpha = 1;
		func_0EC7(var_01);
		self.notifyicon fadeovertime(0.75);
		self.notifyicon.alpha = 0;
	}
	else
	{
		func_0EC7(var_01);
	}

	self notify("notifyMessageDone");
	self.doingnotify = 0;
}

//Function Number: 26
func_0EC6()
{
	self notify("resetOnCancel");
	self endon("resetOnCancel");
	self endon("notifyMessageDone");
	self endon("disconnect");
	level waittill("cancel_notify");
	self.notifytitle.alpha = 0;
	self.notifytext.alpha = 0;
	self.notifyicon.alpha = 0;
	self.doingnotify = 0;
}

//Function Number: 27
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

//Function Number: 28
canreadtext()
{
	if(isflashbanged())
	{
		return 0;
	}

	return 1;
}

//Function Number: 29
isflashbanged()
{
	return isdefined(self.flashendtime) && gettime() < self.flashendtime;
}

//Function Number: 30
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

//Function Number: 31
registerscoreinfo(param_00,param_01)
{
	level.scoreinfo[param_00]["value"] = param_01;
}

//Function Number: 32
getscoreinfovalue(param_00)
{
	return level.scoreinfo[param_00]["value"];
}

//Function Number: 33
getrankinfominxp(param_00)
{
	return int(level.ranktable[param_00][2]);
}

//Function Number: 34
func_0ECE(param_00)
{
	return int(level.ranktable[param_00][3]);
}

//Function Number: 35
getrankinfomaxxp(param_00)
{
	return int(level.ranktable[param_00][7]);
}

//Function Number: 36
getrankinfofull(param_00)
{
	return tablelookupistring("sp/ranktable.csv",0,param_00,5);
}

//Function Number: 37
getrankinfoicon(param_00)
{
	return tablelookup("sp/rankTable.csv",0,param_00,6);
}

//Function Number: 38
getrank()
{
	var_00 = self.var_E96["rankxp"];
	var_01 = self.var_E96["rank"];
	if(var_00 < getrankinfominxp(var_01) + func_0ECE(var_01))
	{
		return var_01;
	}

	return getrankforxp(var_00);
}

//Function Number: 39
getrankforxp(param_00)
{
	var_01 = 0;
	for(var_02 = level.ranktable[var_01][1];isdefined(var_02) && var_02 != "";var_02 = undefined)
	{
		if(param_00 < getrankinfominxp(var_01) + func_0ECE(var_01))
		{
			return var_01;
		}

		var_01++;
		if(isdefined(level.ranktable[var_01]))
		{
			var_02 = level.ranktable[var_01][1];
			continue;
		}
	}

	var_01--;
	return var_01;
}

//Function Number: 40
getrankxp()
{
	return self getplayerdata("experience");
}