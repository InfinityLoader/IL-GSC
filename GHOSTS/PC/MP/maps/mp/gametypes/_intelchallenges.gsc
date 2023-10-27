/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_intelchallenges.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 38
 * Decompile Time: 793 ms
 * Timestamp: 10/27/2023 1:18:37 AM
*******************************************************************/

//Function Number: 1
func_3CE3(param_00)
{
	thread deathwatcher();
	var_01 = tablelookuprownum("mp/intelChallenges.csv",0,param_00);
	self setclientomnvar("ui_intel_active_index",var_01);
	switch(param_00)
	{
		case "ch_intel_headshots":
			thread intelheadshotchallenge(param_00);
			break;

		case "ch_intel_kills":
			thread func_4688(param_00);
			break;

		case "ch_intel_knifekill":
			thread intelknifekillchallenge(param_00);
			break;

		case "ch_intel_explosivekill":
			thread func_467C(param_00);
			break;

		case "ch_intel_crouchkills":
			thread intelcrouchkillschallenge(param_00);
			break;

		case "ch_intel_pronekills":
			thread func_468B(param_00);
			break;

		case "ch_intel_backshots":
			thread func_467B(param_00);
			break;

		case "ch_intel_jumpshot":
			thread func_4687(param_00);
			break;

		case "ch_intel_secondarykills":
			thread func_468C(param_00);
			break;

		case "ch_intel_foundshot":
			thread intelfoundshotkillschallenge(param_00);
			break;

		case "ch_intel_tbag":
			thread func_468F(param_00);
			break;

		default:
			break;
	}
}

//Function Number: 2
func_3D12(param_00,param_01)
{
	switch(param_00)
	{
		case "ch_team_intel_melee":
			level thread intelteammelee(param_00,param_01);
			break;

		case "ch_team_intel_headshot":
			level thread func_4691(param_00,param_01);
			break;

		case "ch_team_intel_killstreak":
			level thread func_4692(param_00,param_01);
			break;

		case "ch_team_intel_equipment":
			level thread func_4690(param_00,param_01);
			break;

		default:
			break;
	}
}

//Function Number: 3
intelteammelee(param_00,param_01)
{
	level endon("game_ended");
	level endon("giveTeamIntel");
	level endon("teamIntelFail");
	level.nummeleekillsintel = 0;
	var_02 = level.intelchallengearray[param_00].challengetarget;
	var_03 = tablelookuprownum("mp/intelChallenges.csv",0,param_00);
	level thread func_7F96(param_00,param_01,var_03,var_02);
	while(level.nummeleekillsintel < var_02)
	{
		level waittill("enemy_death");
		func_9457(var_02 - level.nummeleekillsintel);
	}

	func_7F95(param_00,param_01);
	level thread intelteamreward(param_01);
}

//Function Number: 4
func_9457(param_00)
{
	level.updateintelprogress = int(max(param_00,0));
	func_873E(level.updateintelprogress);
}

//Function Number: 5
func_873E(param_00)
{
	level.currentteamintelprogress = param_00;
	foreach(var_02 in level.players)
	{
		var_02 playerupdateteamintelprogress();
	}
}

//Function Number: 6
playerupdateteamintelprogress()
{
	self setclientomnvar("ui_intel_progress_current",level.currentteamintelprogress);
}

//Function Number: 7
playerupdateintelprogress(param_00)
{
	self setclientomnvar("ui_intel_progress_current",param_00);
}

//Function Number: 8
func_4691(param_00,param_01)
{
	level endon("game_ended");
	level endon("giveTeamIntel");
	level endon("teamIntelFail");
	level.numheadshotsintel = 0;
	var_02 = level.intelchallengearray[param_00].challengetarget;
	var_03 = tablelookuprownum("mp/intelChallenges.csv",0,param_00);
	level thread func_7F96(param_00,param_01,var_03,var_02);
	while(level.numheadshotsintel < var_02)
	{
		level waittill("enemy_death");
		func_9457(var_02 - level.numheadshotsintel);
	}

	func_7F95(param_00,param_01);
	level thread intelteamreward(param_01);
}

//Function Number: 9
func_4692(param_00,param_01)
{
	level endon("game_ended");
	level endon("giveTeamIntel");
	level endon("teamIntelFail");
	level.numkillstreakkillsintel = 0;
	var_02 = level.intelchallengearray[param_00].challengetarget;
	var_03 = tablelookuprownum("mp/intelChallenges.csv",0,param_00);
	level thread func_7F96(param_00,param_01,var_03,var_02);
	while(level.numkillstreakkillsintel < var_02)
	{
		level waittill("enemy_death");
		func_9457(var_02 - level.numkillstreakkillsintel);
	}

	func_7F95(param_00,param_01);
	level thread intelteamreward(param_01);
}

//Function Number: 10
func_4690(param_00,param_01)
{
	level endon("game_ended");
	level endon("giveTeamIntel");
	level endon("teamIntelFail");
	level.numequipmentkillsintel = 0;
	var_02 = level.intelchallengearray[param_00].challengetarget;
	var_03 = tablelookuprownum("mp/intelChallenges.csv",0,param_00);
	level thread func_7F96(param_00,param_01,var_03,var_02);
	while(level.numequipmentkillsintel < var_02)
	{
		level waittill("enemy_death");
		func_9457(var_02 - level.numequipmentkillsintel);
	}

	func_7F95(param_00,param_01);
	level thread intelteamreward(param_01);
}

//Function Number: 11
func_7F96(param_00,param_01,param_02,param_03)
{
	level endon("game_ended");
	level endon("giveTeamIntel");
	level endon("teamIntelFail");
	level endon("teamIntelComplete");
	level.isteamintelcomplete = 0;
	level.currentteamintelname = param_00;
	level.currentteamintelprogress = param_03;
	foreach(var_05 in level.players)
	{
		var_05 playerteamintelstarthud(param_00,param_01,param_02,param_03);
	}

	for(;;)
	{
		level waittill("player_spawned",var_05);
		var_05 playerteamintelstarthud(param_00,param_01,param_02,param_03);
	}
}

//Function Number: 12
playerteamintelstarthud(param_00,param_01,param_02,param_03)
{
	if(self.team != param_01)
	{
	}

	self setclientomnvar("ui_intel_active_index",param_02);
	playerupdateteamintelprogress();
	if(maps\mp\_utility::func_4945(self))
	{
		thread maps\mp\gametypes\_hud_message::func_794C(param_00 + "_received");
	}
}

//Function Number: 13
func_7F95(param_00,param_01)
{
	level notify("teamIntelComplete");
	foreach(var_03 in level.players)
	{
		if(var_03.team != param_01)
		{
			continue;
		}

		var_03 setclientomnvar("ui_intel_active_index",-1);
		var_03 setclientomnvar("ui_intel_progress_current",-1);
		if(maps\mp\_utility::func_4945(var_03))
		{
			var_03 thread maps\mp\gametypes\_hud_message::func_794C(param_00);
		}
	}
}

//Function Number: 14
intelteamreward(param_00)
{
	level endon("game_ended");
	level notify("intelTeamReward");
	foreach(var_02 in level.players)
	{
		if(var_02.team != param_00)
		{
			continue;
		}

		if(!maps\mp\_utility::func_4945(var_02))
		{
			continue;
		}

		var_02 thread intelteamrewardplayer();
	}

	level.isteamintelcomplete = 1;
}

//Function Number: 15
intelteamrewardplayerwaittillcomplete(param_00)
{
	level endon("intelTeamReward");
	while(param_00)
	{
		wait(1);
		maps\mp\gametypes\_hostmigration::func_8BBA();
		if((!isdefined(self.iscarrying) || self.iscarrying == 0) && !isdefined(self.ui_securing))
		{
			param_00 = max(0,param_00 - 1);
		}

		if(param_00 == 8)
		{
			childthread func_3406();
		}
	}
}

//Function Number: 16
intelteamrewardplayer()
{
	level endon("game_ended");
	var_00 = self;
	var_00 maps\mp\_utility::func_3CFB("specialty_explosivebullets",0);
	var_00 setclientomnvar("ui_horde_update_explosive",1);
	var_00 maps\mp\_utility::_giveweapon(level.intelminigun);
	var_00 givestartammo(level.intelminigun);
	if(var_00 common_scripts\utility::func_49B6() && var_00 common_scripts\utility::func_4992() && !var_00 maps\mp\_utility::func_4995() && !var_00 maps\mp\killstreaks\_killstreaks::func_4994())
	{
		var_00 switchtoweaponimmediate(level.intelminigun);
	}

	var_00 intelteamrewardplayerwaittillcomplete(60);
	var_00 maps\mp\_utility::_unsetperk("specialty_explosivebullets");
	var_00 setclientomnvar("ui_horde_update_explosive",0);
	var_01 = var_00 getcurrentprimaryweapon();
	var_00 takeweapon(level.intelminigun);
	if(var_01 == level.intelminigun)
	{
		var_02 = var_00 maps\mp\killstreaks\_killstreaks::func_3AAA();
		var_00 switchtoweaponimmediate(var_02);
	}
}

//Function Number: 17
func_3406()
{
	self endon("death");
	self endon("disconnect");
	self setclientomnvar("ui_horde_update_explosive",1);
	wait(8);
	self setclientomnvar("ui_horde_update_explosive",0);
}

//Function Number: 18
func_468D()
{
}

//Function Number: 19
deathwatcher()
{
	self endon("disconnect");
	self endon("intel_cleanup");
	self waittill("death");
	self setclientomnvar("ui_intel_active_index",-1);
	thread maps\mp\gametypes\_hud_message::func_794D("ch_intel_failed");
}

//Function Number: 20
intelheadshotchallenge(param_00)
{
	self endon("disconnect");
	self endon("death");
	self endon("intel_cleanup");
	var_01 = 0;
	var_02 = level.intelchallengearray[param_00].challengetarget;
	thread maps\mp\gametypes\_hud_message::func_794D(param_00 + "_received",var_02);
	playerupdateintelprogress(var_02);
	while(var_01 < var_02)
	{
		self waittill("got_a_kill",var_03,var_04,var_05);
		if(maps\mp\_utility::func_48F7(var_04))
		{
			continue;
		}

		if(var_05 == "MOD_HEAD_SHOT")
		{
			var_01++;
			var_06 = var_02 - var_01;
			playerupdateintelprogress(var_06);
		}
	}

	maps\mp\gametypes\_intel::func_11F5(param_00);
}

//Function Number: 21
func_4688(param_00)
{
	self endon("disconnect");
	self endon("death");
	self endon("intel_cleanup");
	var_01 = 0;
	var_02 = level.intelchallengearray[param_00].challengetarget;
	thread maps\mp\gametypes\_hud_message::func_794D(param_00 + "_received",var_02);
	playerupdateintelprogress(var_02);
	while(var_01 < var_02)
	{
		self waittill("got_a_kill",var_03,var_04);
		if(maps\mp\_utility::func_48F7(var_04))
		{
			continue;
		}

		var_01++;
		var_05 = var_02 - var_01;
		playerupdateintelprogress(var_05);
	}

	maps\mp\gametypes\_intel::func_11F5(param_00);
}

//Function Number: 22
intelcrouchkillschallenge(param_00)
{
	self endon("disconnect");
	self endon("death");
	self endon("intel_cleanup");
	var_01 = 0;
	var_02 = level.intelchallengearray[param_00].challengetarget;
	playerupdateintelprogress(var_02);
	thread maps\mp\gametypes\_hud_message::func_794D(param_00 + "_received",var_02);
	while(var_01 < var_02)
	{
		self waittill("got_a_kill",var_03,var_04);
		if(self getstance() == "crouch")
		{
			if(maps\mp\_utility::func_48F7(var_04))
			{
				continue;
			}

			var_01++;
			var_05 = var_02 - var_01;
			playerupdateintelprogress(var_05);
		}
	}

	maps\mp\gametypes\_intel::func_11F5(param_00);
}

//Function Number: 23
intelfoundshotkillschallenge(param_00)
{
	self endon("disconnect");
	self endon("death");
	self endon("intel_cleanup");
	var_01 = 0;
	var_02 = level.intelchallengearray[param_00].challengetarget;
	thread maps\mp\gametypes\_hud_message::func_794D(param_00 + "_received",var_02);
	playerupdateintelprogress(var_02);
	while(var_01 < var_02)
	{
		self waittill("got_a_kill",var_03,var_04,var_05);
		if(var_05 == "MOD_MELEE" && !maps\mp\gametypes\_weapons::isknifeonly(var_04) && !maps\mp\gametypes\_weapons::func_494E(var_04))
		{
			continue;
		}

		if(maps\mp\gametypes\_weapons::isoffhandweapon(var_04) || maps\mp\_utility::func_48F7(var_04) || maps\mp\_utility::func_48B7(var_04))
		{
			continue;
		}

		var_04 = maps\mp\_utility::func_8DAC(var_04);
		if(var_04 != self.pers["primaryWeapon"] && var_04 != self.pers["secondaryWeapon"])
		{
			var_01++;
			var_06 = var_02 - var_01;
			playerupdateintelprogress(var_06);
		}
	}

	maps\mp\gametypes\_intel::func_11F5(param_00);
}

//Function Number: 24
func_468C(param_00)
{
	self endon("disconnect");
	self endon("death");
	self endon("intel_cleanup");
	var_01 = 0;
	var_02 = level.intelchallengearray[param_00].challengetarget;
	thread maps\mp\gametypes\_hud_message::func_794D(param_00 + "_received",var_02);
	playerupdateintelprogress(var_02);
	while(var_01 < var_02)
	{
		self waittill("got_a_kill",var_03,var_04,var_05);
		var_04 = maps\mp\_utility::func_8DAC(var_04);
		if(maps\mp\_utility::func_4890(var_04))
		{
			if(var_05 == "MOD_MELEE" && !issubstr(var_04,"tactical"))
			{
				continue;
			}

			var_01++;
			var_06 = var_02 - var_01;
			playerupdateintelprogress(var_06);
		}
	}

	maps\mp\gametypes\_intel::func_11F5(param_00);
}

//Function Number: 25
func_467B(param_00)
{
	self endon("disconnect");
	self endon("death");
	self endon("intel_cleanup");
	var_01 = 0;
	var_02 = level.intelchallengearray[param_00].challengetarget;
	thread maps\mp\gametypes\_hud_message::func_794D(param_00 + "_received",var_02);
	playerupdateintelprogress(var_02);
	while(var_01 < var_02)
	{
		self waittill("got_a_kill",var_03,var_04,var_05);
		if(maps\mp\_utility::func_48F7(var_04))
		{
			continue;
		}

		var_06 = var_03.anglesondeath[1];
		var_07 = self.anglesonkill[1];
		var_08 = angleclamp180(var_06 - var_07);
		if(abs(var_08) < 65)
		{
			var_01++;
			var_09 = var_02 - var_01;
			playerupdateintelprogress(var_09);
		}
	}

	maps\mp\gametypes\_intel::func_11F5(param_00);
}

//Function Number: 26
func_4687(param_00)
{
	self endon("disconnect");
	self endon("death");
	self endon("intel_cleanup");
	var_01 = 0;
	var_02 = int(level.intelchallengearray[param_00].challengetarget);
	thread maps\mp\gametypes\_hud_message::func_794D(param_00 + "_received",var_02);
	playerupdateintelprogress(var_02);
	while(var_01 < var_02)
	{
		self waittill("got_a_kill",var_03,var_04,var_05);
		if(maps\mp\_utility::func_48F7(var_04))
		{
			continue;
		}

		if(!self isonground())
		{
			var_01++;
			var_06 = var_02 - var_01;
			playerupdateintelprogress(var_06);
		}
	}

	maps\mp\gametypes\_intel::func_11F5(param_00);
}

//Function Number: 27
intelknifekillchallenge(param_00)
{
	self endon("disconnect");
	self endon("death");
	self endon("intel_cleanup");
	var_01 = 0;
	var_02 = level.intelchallengearray[param_00].challengetarget;
	thread maps\mp\gametypes\_hud_message::func_794D(param_00 + "_received",var_02);
	playerupdateintelprogress(var_02);
	while(var_01 < var_02)
	{
		self waittill("got_a_kill",var_03,var_04,var_05);
		if(var_05 == "MOD_MELEE")
		{
			var_01++;
			var_06 = var_02 - var_01;
			playerupdateintelprogress(var_06);
		}
	}

	maps\mp\gametypes\_intel::func_11F5(param_00);
}

//Function Number: 28
func_467C(param_00)
{
	self endon("disconnect");
	self endon("death");
	self endon("intel_cleanup");
	var_01 = 0;
	var_02 = level.intelchallengearray[param_00].challengetarget;
	thread maps\mp\gametypes\_hud_message::func_794D(param_00 + "_received",var_02);
	playerupdateintelprogress(var_02);
	while(var_01 < var_02)
	{
		self waittill("got_a_kill",var_03,var_04,var_05);
		if(maps\mp\_utility::func_48F7(var_04))
		{
			continue;
		}

		if(var_04 == "throwingknife_mp")
		{
			continue;
		}

		if(isexplosivedamagemod(var_05) || var_05 == "MOD_IMPACT")
		{
			var_01++;
			var_06 = var_02 - var_01;
			playerupdateintelprogress(var_06);
		}
	}

	maps\mp\gametypes\_intel::func_11F5(param_00);
}

//Function Number: 29
func_468B(param_00)
{
	self endon("disconnect");
	self endon("death");
	self endon("intel_cleanup");
	var_01 = 0;
	var_02 = int(level.intelchallengearray[param_00].challengetarget);
	thread maps\mp\gametypes\_hud_message::func_794D(param_00 + "_received",var_02);
	playerupdateintelprogress(var_02);
	while(var_01 < var_02)
	{
		self waittill("got_a_kill",var_03,var_04,var_05);
		if(maps\mp\_utility::func_48F7(var_04))
		{
			continue;
		}

		if(self getstance() == "prone")
		{
			var_01++;
			var_06 = var_02 - var_01;
			playerupdateintelprogress(var_06);
		}
	}

	maps\mp\gametypes\_intel::func_11F5(param_00);
}

//Function Number: 30
func_468F(param_00)
{
	self endon("disconnect");
	self endon("death");
	self endon("intel_cleanup");
	var_01 = level.intelchallengearray[param_00].challengetarget;
	thread maps\mp\gametypes\_hud_message::func_794D(param_00 + "_received");
	for(;;)
	{
		self waittill("got_a_kill",var_02,var_03,var_04);
		if(maps\mp\_utility::func_48F7(var_03))
		{
			continue;
		}

		thread func_8CEF(var_02.origin,param_00);
	}
}

//Function Number: 31
func_8CEF(param_00,param_01)
{
	self notify("watchForTbag");
	self endon("watchForTbag");
	self endon("death");
	self endon("disconnect");
	self endon("intel_cleanup");
	var_02 = 0;
	self notifyonplayercommand("Tbag_adjustedStance","+stance");
	self notifyonplayercommand("Tbag_adjustedStance","+goStand");
	if(!level.console && !isai(self))
	{
		self notifyonplayercommand("Tbag_adjustedStance","+togglecrouch");
		self notifyonplayercommand("Tbag_adjustedStance","+movedown");
	}

	for(;;)
	{
		while(self getstance() != "stand")
		{
			wait(0.05);
		}

		self waittill("Tbag_adjustedStance");
		while(self getstance() != "crouch")
		{
			wait(0.05);
		}

		if(distance2d(self.origin,param_00) < 128)
		{
			self waittill("Tbag_adjustedStance");
			while(self getstance() != "stand")
			{
				wait(0.05);
			}

			if(distance2d(self.origin,param_00) < 128)
			{
				var_02++;
			}
		}

		if(var_02)
		{
			thread maps\mp\gametypes\_intel::func_11F5(param_01);
		}
	}
}

//Function Number: 32
givejuggernautchallenge(param_00)
{
	thread deathwatcher();
	var_01 = tablelookuprownum("mp/intelChallenges.csv",0,param_00);
	self setclientomnvar("ui_intel_active_index",var_01);
	switch(param_00)
	{
		case "ch_intel_jugg_maniac_knife":
			thread inteljuggmaniacknifechallenge(param_00);
			break;

		case "ch_intel_jugg_maniac_throwingknife":
			thread inteljuggmaniacthrowingknifechallenge(param_00);
			break;

		case "ch_intel_jugg_maniac_backknife":
			thread inteljuggmaniacbackknifechallenge(param_00);
			break;

		case "ch_intel_jugg_assault_kills":
			thread inteljuggassaultkillschallenge(param_00);
			break;

		case "ch_intel_jugg_recon_shieldkills":
			thread inteljuggreconshieldkillschallenge(param_00);
			break;

		case "ch_intel_jugg_recon_pistolkills":
			thread inteljuggreconpistolkillschallenge(param_00);
			break;

		default:
			break;
	}
}

//Function Number: 33
inteljuggassaultkillschallenge(param_00)
{
	self endon("disconnect");
	self endon("death");
	self endon("intel_cleanup");
	var_01 = 0;
	var_02 = int(level.intelchallengearray[param_00].challengetarget);
	thread maps\mp\gametypes\_hud_message::func_794D(param_00 + "_received",var_02);
	playerupdateintelprogress(var_02);
	while(var_01 < var_02)
	{
		self waittill("got_a_kill",var_03,var_04,var_05);
		if(maps\mp\_utility::func_48EF(var_04))
		{
			var_01++;
			var_06 = var_02 - var_01;
			playerupdateintelprogress(var_06);
		}
	}

	maps\mp\gametypes\_intel::func_11F5(param_00);
}

//Function Number: 34
inteljuggmaniacknifechallenge(param_00)
{
	self endon("disconnect");
	self endon("death");
	self endon("intel_cleanup");
	var_01 = 0;
	var_02 = int(level.intelchallengearray[param_00].challengetarget);
	thread maps\mp\gametypes\_hud_message::func_794D(param_00 + "_received",var_02);
	playerupdateintelprogress(var_02);
	while(var_01 < var_02)
	{
		self waittill("got_a_kill",var_03,var_04,var_05);
		if(var_04 == "iw6_knifeonlyjugg_mp")
		{
			var_01++;
			var_06 = var_02 - var_01;
			playerupdateintelprogress(var_06);
		}
	}

	maps\mp\gametypes\_intel::func_11F5(param_00);
}

//Function Number: 35
inteljuggmaniacthrowingknifechallenge(param_00)
{
	self endon("disconnect");
	self endon("death");
	self endon("intel_cleanup");
	var_01 = 0;
	var_02 = int(level.intelchallengearray[param_00].challengetarget);
	thread maps\mp\gametypes\_hud_message::func_794D(param_00 + "_received",var_02);
	playerupdateintelprogress(var_02);
	while(var_01 < var_02)
	{
		self waittill("got_a_kill",var_03,var_04,var_05);
		if(var_04 == "throwingknifejugg_mp")
		{
			var_01++;
			var_06 = var_02 - var_01;
			playerupdateintelprogress(var_06);
		}
	}

	maps\mp\gametypes\_intel::func_11F5(param_00);
}

//Function Number: 36
inteljuggmaniacbackknifechallenge(param_00)
{
	self endon("disconnect");
	self endon("death");
	self endon("intel_cleanup");
	var_01 = 0;
	var_02 = level.intelchallengearray[param_00].challengetarget;
	thread maps\mp\gametypes\_hud_message::func_794D(param_00 + "_received",var_02);
	playerupdateintelprogress(var_02);
	while(var_01 < var_02)
	{
		self waittill("got_a_kill",var_03,var_04,var_05);
		if(maps\mp\_utility::func_48EF(var_04))
		{
			var_06 = var_03.anglesondeath[1];
			var_07 = self.anglesonkill[1];
			var_08 = angleclamp180(var_06 - var_07);
			if(abs(var_08) < 90)
			{
				var_01++;
				var_09 = var_02 - var_01;
				playerupdateintelprogress(var_09);
			}
		}
	}

	maps\mp\gametypes\_intel::func_11F5(param_00);
}

//Function Number: 37
inteljuggreconshieldkillschallenge(param_00)
{
	self endon("disconnect");
	self endon("death");
	self endon("intel_cleanup");
	var_01 = 0;
	var_02 = int(level.intelchallengearray[param_00].challengetarget);
	thread maps\mp\gametypes\_hud_message::func_794D(param_00 + "_received",var_02);
	playerupdateintelprogress(var_02);
	while(var_01 < var_02)
	{
		self waittill("got_a_kill",var_03,var_04,var_05);
		if(var_04 == "iw6_riotshieldjugg_mp")
		{
			var_01++;
			var_06 = var_02 - var_01;
			playerupdateintelprogress(var_06);
		}
	}

	maps\mp\gametypes\_intel::func_11F5(param_00);
}

//Function Number: 38
inteljuggreconpistolkillschallenge(param_00)
{
	self endon("disconnect");
	self endon("death");
	self endon("intel_cleanup");
	var_01 = 0;
	var_02 = int(level.intelchallengearray[param_00].challengetarget);
	thread maps\mp\gametypes\_hud_message::func_794D(param_00 + "_received",var_02);
	playerupdateintelprogress(var_02);
	while(var_01 < var_02)
	{
		self waittill("got_a_kill",var_03,var_04,var_05);
		if(var_04 == "iw6_magnumjugg_mp" && var_05 != "MOD_MELEE")
		{
			var_01++;
			var_06 = var_02 - var_01;
			playerupdateintelprogress(var_06);
		}
	}

	maps\mp\gametypes\_intel::func_11F5(param_00);
}