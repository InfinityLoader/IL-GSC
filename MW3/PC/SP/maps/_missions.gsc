/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_missions.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 258 ms
 * Timestamp: 10/27/2023 2:19:15 AM
*******************************************************************/

//Function Number: 1
init()
{
	foreach(var_01 in level.players)
	{
		var_01 initnotifymessage();
	}
}

//Function Number: 2
monitor_challenges()
{
}

//Function Number: 3
challenge_targetval(param_00,param_01,param_02)
{
	var_03 = tablelookup(param_00,0,param_01,6 + param_02 - 1 * 2);
	return int(var_03);
}

//Function Number: 4
challenge_rewardval(param_00,param_01,param_02)
{
	var_03 = tablelookup(param_00,0,param_01,7 + param_02 - 1 * 2);
	return int(var_03);
}

//Function Number: 5
getchallengestatus(param_00)
{
	if(isdefined(self.challengedata[param_00]))
	{
		return self.challengedata[param_00];
	}

	return 0;
}

//Function Number: 6
ch_getprogress(param_00)
{
	return self getplayerdata("challengeProgress",param_00);
}

//Function Number: 7
ch_getstate(param_00)
{
	return self getplayerdata("challengeState",param_00);
}

//Function Number: 8
ch_setprogress(param_00,param_01)
{
	return self setplayerdata("challengeProgress",param_00,param_01);
}

//Function Number: 9
ch_setstate(param_00,param_01)
{
	return self setplayerdata("challengeState",param_00,param_01);
}

//Function Number: 10
ch_gettarget(param_00,param_01)
{
	return int(tablelookup("sp/allChallengesTable.csv",0,param_00,6 + param_01 - 1 * 2));
}

//Function Number: 11
buildchallengetableinfo(param_00,param_01)
{
	var_02 = 0;
	var_03 = tablelookupbyrow(param_00,0,0);
	for(var_04 = 1;var_03 != "";var_04++)
	{
		level.challengeinfo[var_03] = [];
		level.challengeinfo[var_03]["targetval"] = [];
		level.challengeinfo[var_03]["reward"] = [];
		level.challengeinfo[var_03]["type"] = param_01;
		for(var_05 = 1;var_05 < 11;var_05++)
		{
			var_06 = challenge_targetval(param_00,var_03,var_05);
			var_07 = challenge_rewardval(param_00,var_03,var_05);
			if(var_06 == 0)
			{
				break;
			}

			level.challengeinfo[var_03]["targetval"][var_05] = var_06;
			level.challengeinfo[var_03]["reward"][var_05] = var_07;
			var_02 = var_02 + var_07;
		}

		var_03 = tablelookupbyrow(param_00,var_04,0);
	}

	return int(var_02);
}

//Function Number: 12
buildchallengeinfo()
{
	level.challengeinfo = [];
	var_00 = 0;
	var_00 = var_00 + buildchallengetableinfo("sp/allchallengesTable.csv",0);
	var_01 = tablelookupbyrow("sp/challengeTable.csv",0,4);
	for(var_02 = 1;var_01 != "";var_02++)
	{
		var_03 = tablelookupbyrow(var_01,0,0);
		for(var_04 = 1;var_03 != "";var_04++)
		{
			var_05 = tablelookup(var_01,0,var_03,1);
			if(var_05 != "")
			{
				level.challengeinfo[var_03]["requirement"] = var_05;
			}

			var_03 = tablelookupbyrow(var_01,var_04,0);
		}

		var_01 = tablelookupbyrow("sp/challengeTable.csv",var_02,4);
	}
}

//Function Number: 13
challengesplashnotify(param_00)
{
	self endon("disconnect");
	waittillframeend;
	wait 0.05;
	var_01 = ch_getstate(param_00) - 1;
	var_02 = ch_gettarget(param_00,var_01);
	if(var_02 == 0)
	{
		var_02 = 1;
	}

	var_03 = spawnstruct();
	var_03.type = "challenge";
	var_03.optionalnumber = var_02;
	var_03.name = param_00;
	var_03.sound = tablelookup("sp/splashTable.csv",0,var_03.name,9);
	var_03.slot = 0;
	thread maps\_rank::actionnotify(var_03);
}

//Function Number: 14
updatechallenges()
{
	self.challengedata = [];
	wait 0.05;
	foreach(var_04, var_01 in level.challengeinfo)
	{
		self.challengedata[var_04] = 0;
		if(!self isitemunlocked(var_04))
		{
			continue;
		}

		if(isdefined(var_01["requirement"]) && !self isitemunlocked(var_01["requirement"]))
		{
			continue;
		}

		var_02 = 0;
		var_03 = var_04;
		var_02 = ch_getstate(var_04);
		if(var_02 == 0)
		{
			ch_setstate(var_04,1);
			var_02 = 1;
		}

		self.challengedata[var_04] = var_02;
	}
}

//Function Number: 15
giverankxpafterwait(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	wait 0.25;
	maps\_utility::givexp("challenge",level.challengeinfo[param_00]["reward"][param_01]);
}

//Function Number: 16
processchallenge(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_03 = getchallengestatus(param_00);
	if(var_03 == 0)
	{
		return;
	}

	if(var_03 > level.challengeinfo[param_00]["targetval"].size)
	{
		return;
	}

	var_04 = ch_getprogress(param_00);
	if(isdefined(param_02) && param_02)
	{
		var_05 = param_01;
	}
	else
	{
		var_05 = var_05 + param_02;
	}

	var_06 = level.challengeinfo[param_00]["targetval"][var_03];
	if(var_05 >= var_06)
	{
		var_07 = 1;
		var_05 = var_06;
	}
	else
	{
		var_07 = 0;
	}

	if(var_04 < var_05)
	{
		ch_setprogress(param_00,var_05);
	}

	if(var_07)
	{
		thread giverankxpafterwait(param_00,var_03);
		var_03++;
		ch_setstate(param_00,var_03);
		self.challengedata[param_00] = var_03;
		thread challengesplashnotify(param_00);
	}
}

//Function Number: 17
initnotifymessage()
{
	if(maps\_utility::is_coop())
	{
		var_00 = 2.5;
		var_01 = 1.75;
		var_02 = 24;
		var_03 = "objective";
		var_04 = "TOP";
		var_05 = "BOTTOM";
		var_06 = 30;
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
		var_06 = 30;
		var_07 = 0;
	}

	self.notifytitle = maps\_hud_util::createclientfontstring(var_03,var_00);
	self.notifytitle maps\_hud_util::setpoint(var_04,undefined,var_07,var_06);
	self.notifytitle.glowcolor = (0.2,0.3,0.7);
	self.notifytitle.glowalpha = 1;
	self.notifytitle.hidewheninmenu = 1;
	self.notifytitle.archived = 0;
	self.notifytitle.alpha = 0;
	self.notifytext = maps\_hud_util::createclientfontstring(var_03,var_01);
	self.notifytext maps\_hud_util::setparent(self.notifytitle);
	self.notifytext maps\_hud_util::setpoint(var_04,var_05,0,0);
	self.notifytext.glowcolor = (0.2,0.3,0.7);
	self.notifytext.glowalpha = 1;
	self.notifytext.hidewheninmenu = 1;
	self.notifytext.archived = 0;
	self.notifytext.alpha = 0;
	self.notifytext2 = maps\_hud_util::createclientfontstring(var_03,var_01);
	self.notifytext2 maps\_hud_util::setparent(self.notifytitle);
	self.notifytext2 maps\_hud_util::setpoint(var_04,var_05,0,0);
	self.notifytext2.glowcolor = (0.2,0.3,0.7);
	self.notifytext2.glowalpha = 1;
	self.notifytext2.hidewheninmenu = 1;
	self.notifytext2.archived = 0;
	self.notifytext2.alpha = 0;
	self.notifyicon = maps\_hud_util::createclienticon("white",var_02,var_02);
	self.notifyicon maps\_hud_util::setparent(self.notifytext2);
	self.notifyicon maps\_hud_util::setpoint(var_04,var_05,0,0);
	self.notifyicon.hidewheninmenu = 1;
	self.notifyicon.archived = 0;
	self.notifyicon.alpha = 0;
	self.doingnotify = 0;
	self.notifyqueue = [];
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