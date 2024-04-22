/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\zombies\_zombies_audio_announcer.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 36
 * Decompile Time: 594 ms
 * Timestamp: 4/22/2024 2:14:27 AM
*******************************************************************/

//Function Number: 1
initannouncer()
{
	var_00 = spawn("script_model",(0,0,0));
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxinitspeaker("announcer","comp_",var_00,0);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","exo_suit_avail","exo_suit_avail",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","exo_online","exo_online","general,thanks");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","hyper_dmg","hyper_dmg","powerup,insta_kill");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","dna_bomb","dna_bomb","powerup,apocalypse");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","pow_surge","pow_surge","powerup,pow_surge");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","full_reload","full_reload","powerup,max_ammo");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","multiplier","multiplier","powerup,2x_pts");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","security","security","powerup,traps");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","zombie_dog","mongrel","general,dog_round");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","zombie_host","host","general,host_round");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global_priority","host_turn","host_turn",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global","door","door",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global","printer","printer_bk","general,printer_moved");
	if(maps\mp\zombies\_util::getzombieslevelnum() == 1)
	{
		level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global","power_labs_01","pow_mg","general,power_on");
		level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global","power_roundabout_01","pow_mh","general,power_on");
		level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global","power_barracks_01","pow_ha","general,power_on");
		level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","global","power_admin_01","pow_am","general,power_on");
	}

	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","machine_all_players","host_cure","cure","general,cured");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","machine_all_players","host_cure2","cure2",undefined,30);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","machine_all_players","laser_trap","trap","general,laser_traps",40);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","machine_all_players","jackpot","cash_ee",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","machine_per_player","specialty_fastreload","exo_reload",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","machine_per_player","exo_health","exo_health",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","machine_per_player","exo_revive","exo_medic",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","machine_per_player","exo_stabilizer","exo_soldier",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","machine_per_player","exo_slam","exo_slam",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","machine_per_player","wallbuy","wallbuy",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","machine_per_player","printer","printer",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","machine_per_player","weapon_upgrade","wpn_upgd",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","machine_per_player","power_switch","pwr_swtich",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","an_conv","an_conv_1","an_conv_1a","an_conv,an_conv_1b");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","an_conv","an_conv_1c","an_conv_1c","an_conv,an_conv_1d");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","an_conv","an_conv_2b","an_conv_2b",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","an_conv","an_conv_3b","an_conv_3b",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","an_conv","an_conv_4b","an_conv_4b","an_conv,an_conv_4c");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","an_conv","an_conv_4d","an_conv_4d",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","an_conv","an_conv_5b","an_conv_5b","an_conv,an_conv_5c");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","an_conv","an_conv_5d","an_conv_5d",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","an_conv","an_conv_6","an_conv_6a","an_conv,an_conv_6b");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","an_conv","an_conv_6c","an_conv_6c","an_conv,an_conv_6d");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","an_conv","an_conv_7b","an_conv_7b","an_conv,an_conv_7c");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","an_conv","an_conv_7d","an_conv_7d",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","an_conv","an_conv_8","an_conv_8a",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","an_conv","an_conv_9","an_conv_9a","an_conv,an_conv_9b");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","an_conv","an_conv_9c","an_conv_9c",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","an_conv","an_conv_10","an_conv_10a",undefined);
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","an_conv","an_conv_11","an_conv_11a","an_conv,an_conv_11b");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","an_conv_repeat","an_conv_12","an_conv_12a","an_conv_12b");
	level.vox maps\mp\zombies\_zombies_audio::zmbvoxadd("announcer","an_conv_repeat","an_conv_12b","an_conv_12b",undefined);
	level.allowzmbannouncer = 1;
	level thread terminalsactivatedmonitor();
	level thread terminalattractormonitor();
	level thread monitorkiting();
}

//Function Number: 2
isannouncer(param_00)
{
	return issubstr(param_00.zmbvoxid,"announcer");
}

//Function Number: 3
getannouncer()
{
	return level.vox.speaker["announcer"].ents[0];
}

//Function Number: 4
getannouncers(param_00)
{
	var_01 = [];
	var_02 = getarraykeys(level.vox.speaker);
	foreach(var_04 in var_02)
	{
		if(isdefined(param_00) && !issubstr(var_04,param_00))
		{
			continue;
		}

		if(issubstr(var_04,"announcer"))
		{
			var_01[var_01.size] = level.vox.speaker[var_04].ents[0];
		}
	}

	return var_01;
}

//Function Number: 5
isannouncerspeaking()
{
	var_00 = getannouncer();
	return maps\mp\zombies\_util::is_true(var_00.isspeaking);
}

//Function Number: 6
isannouncinground()
{
	var_00 = getannouncer();
	return maps\mp\zombies\_util::is_true(var_00.isspeaking) && isdefined(var_00.speakingline) && issubstr(var_00.speakingtype,"zombie_");
}

//Function Number: 7
waittillannouncerdonespeaking()
{
	if(isannouncerspeaking())
	{
		var_00 = getannouncer();
		var_00 waittill("done_speaking");
	}
}

//Function Number: 8
isanyannouncerspeaking()
{
	var_00 = getannouncers();
	foreach(var_02 in var_00)
	{
		if(maps\mp\zombies\_util::is_true(var_02.isspeaking))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 9
waittillallannouncersdonespeaking()
{
	var_00 = getannouncers();
	for(;;)
	{
		var_01 = 0;
		foreach(var_03 in var_00)
		{
			if(maps\mp\zombies\_util::is_true(var_03.isspeaking))
			{
				var_01 = 1;
				break;
			}
		}

		if(!var_01)
		{
			break;
		}

		wait 0.05;
	}
}

//Function Number: 10
announcerglobaldialogdelay(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	wait(param_02);
	return announcerglobaldialog(param_00,param_01,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 11
announcerglobaldialog(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = getannouncer();
	return var_07 maps\mp\zombies\_zombies_audio::create_and_play_dialog(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 12
announcerinworlddialogdelay(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	wait(param_03);
	return announcerinworlddialog(param_00,param_01,param_02,param_04,param_05,param_06,param_07,param_08);
}

//Function Number: 13
announcerinworlddialog(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = getannouncer();
	var_08.origin = param_02;
	return var_08 maps\mp\zombies\_zombies_audio::create_and_play_dialog(param_00,param_01,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 14
playannouncerdialog(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self endon("stopSpeaking");
	self endon("death");
	self.speakingline = param_02;
	self.speakingcategory = param_03;
	self.speakingtype = param_04;
	self.isspeaking = 1;
	self notify("speaking");
	playannouncementwaituntildone(param_02,param_03,param_08);
	if(param_00 == "beauford_" || param_00 == "zombie_")
	{
		wait(1);
	}

	self notify("done_speaking");
	level notify("done_speaking");
	if(isdefined(self.classname))
	{
		self stopsounds();
	}

	self.isspeaking = 0;
	if(maps\mp\zombies\_util::is_true(param_05))
	{
		return;
	}

	if(isdefined(level.vox.speaker[self.zmbvoxid].response) && isdefined(level.vox.speaker[self.zmbvoxid].response[param_03]) && isdefined(level.vox.speaker[self.zmbvoxid].response[param_03][param_04]))
	{
		level thread setup_response_line_to_announcer(self,param_06,param_03,param_04);
		return;
	}

	if(isdefined(level.zmbcustomresponsetoannouncer))
	{
		level thread [[ level.zmbcustomresponsetoannouncer ]](self,param_06,param_03,param_04,param_08);
	}
}

//Function Number: 15
announcercategoryisplaylocal(param_00)
{
	return param_00 == "global_priority" || issubstr(param_00,"an_conv") || param_00 == "global";
}

//Function Number: 16
playannouncementwaituntildone(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = level.players;
	}

	param_02 = common_scripts\utility::array_removeundefined(param_02);
	if(announcercategoryisplaylocal(param_01))
	{
		foreach(var_04 in param_02)
		{
			var_04 playlocalsound(param_00);
		}
	}
	else
	{
		if(param_02.size > 0 && param_02.size < level.players.size)
		{
			self hide();
			foreach(var_04 in param_02)
			{
				self showtoplayer(var_04);
			}
		}
		else
		{
			self show();
		}

		self playsoundonmovingent(param_00);
	}

	var_08 = maps\mp\zombies\_zombies_audio::volength(param_00,param_01);
	wait(var_08);
}

//Function Number: 17
setup_response_line_to_announcer(param_00,param_01,param_02,param_03)
{
	if(param_02 == "an_conv_repeat")
	{
		param_03 = level.vox.speaker[param_00.zmbvoxid].response[param_02][param_03];
		param_00 maps\mp\zombies\_zombies_audio::create_and_play_dialog(param_02,param_03,"");
		return;
	}

	if(!isdefined(param_01))
	{
		if(announcercategoryisplaylocal(param_02))
		{
			param_01 = level.players[randomintrange(0,level.players.size)];
		}
		else
		{
			param_01 = maps\mp\zombies\_zombies_audio::getrandomcharacterinrange(param_00);
		}
	}

	if(isdefined(level.zmbaudioresponsetoannounceroverridefunc) && [[ level.zmbaudioresponsetoannounceroverridefunc ]](param_00,param_01,param_02,param_03))
	{
		return;
	}

	if(isdefined(param_01))
	{
		var_04 = level.vox.speaker[param_00.zmbvoxid].response[param_02][param_03];
		var_05 = strtok(var_04,",");
		if(var_05.size == 2)
		{
			param_02 = var_05[0];
			param_03 = var_05[1];
			if(param_02 == "an_conv")
			{
				var_06 = common_scripts\utility::array_randomize(level.players);
				foreach(param_01 in var_06)
				{
					var_08 = param_01 maps\mp\zombies\_zombies_audio::create_and_play_dialog(param_02,param_03,"");
					if(var_08)
					{
						break;
					}
				}

				return;
			}

			param_01 maps\mp\zombies\_zombies_audio::create_and_play_dialog(param_02,param_03,"");
			return;
		}
	}
}

//Function Number: 18
announcerexoonlinedialog()
{
	thread announcerglobaldialog("global_priority","exo_online",undefined,undefined,undefined,undefined,level.players);
}

//Function Number: 19
announcerglobalattractordialog(param_00,param_01)
{
	thread announcerglobaldialog("global_priority",param_00,undefined,undefined,undefined,undefined,param_01);
}

//Function Number: 20
announcerpickupdialog(param_00,param_01)
{
	thread announcerglobaldialogdelay("global_priority",param_00,0.5,undefined,undefined,undefined,param_01,level.players);
}

//Function Number: 21
announcerrounddialog(param_00)
{
	thread announcerglobaldialogdelay("global_priority",param_00,0.5,undefined,undefined,undefined,undefined,level.players);
}

//Function Number: 22
announcerhostturndialog()
{
	thread announcerglobaldialogdelay("global_priority","host_turn",1,undefined,undefined,undefined,undefined,level.players);
}

//Function Number: 23
announcerdoordialog()
{
	thread announcerglobaldialogdelay("global","door",1,undefined,undefined,undefined,undefined,level.players);
}

//Function Number: 24
announcerprintermoveddialog()
{
	thread announcerglobaldialogdelay("global","printer",0.5,undefined,undefined,undefined,undefined,level.players);
}

//Function Number: 25
announcerpoweronlinedialog(param_00)
{
	thread announcerglobaldialogdelay("global",param_00,0.5,undefined,undefined,undefined,undefined,level.players);
}

//Function Number: 26
terminalsactivatedmonitor()
{
	level.zmannouncerhostcuredebounce = 0;
	for(;;)
	{
		var_00 = level common_scripts\utility::waittill_any_return_parms("terminal_player","terminal_complete");
		if(!isdefined(var_00) || var_00.size < 2)
		{
			continue;
		}

		var_01 = var_00[0];
		var_02 = var_00[1];
		var_03 = var_00[2];
		if(var_01 == "terminal_player")
		{
			var_04 = var_00[2];
			if(var_02 == "host_cure")
			{
				if(gettime() < level.zmannouncerhostcuredebounce)
				{
					continue;
				}

				var_05 = announcerinworlddialogdelay("machine_all_players",var_02,var_03,1.5);
				if(var_05)
				{
					level.zmannouncerhostcuredebounce = gettime() + 15000;
				}
			}

			continue;
		}

		if(var_01 == "terminal_complete")
		{
			if(var_02 == "host_cure")
			{
				if(gettime() < level.zmannouncerhostcuredebounce)
				{
					continue;
				}

				var_05 = announcerinworlddialogdelay("machine_all_players",var_02 + "2",var_03,1.5);
				if(var_05)
				{
					level.zmannouncerhostcuredebounce = gettime() + 15000;
				}
			}
		}
	}
}

//Function Number: 27
announcertrapstarteddialog(param_00)
{
	if(isdefined(level.zmannouncertrapdebounce) && gettime() < level.zmannouncertrapdebounce)
	{
		return;
	}

	var_01 = announcerinworlddialogdelay("machine_all_players","laser_trap",param_00,0.5);
	if(var_01)
	{
		level.zmannouncertrapdebounce = gettime() + 30000;
	}
}

//Function Number: 28
announcerjackpotdialog(param_00)
{
	thread announcerinworlddialogdelay("machine_all_players","jackpot",param_00,0.5);
}

//Function Number: 29
terminalattractormonitor()
{
	if(isdefined(level.zmbaudioattractorwait))
	{
		wait(level.zmbaudioattractorwait);
	}

	var_00 = getentarray("perk_terminal","targetname");
	foreach(var_02 in var_00)
	{
		var_02 thread _terminalattractormonitor(var_02.itemtype,300,80);
	}

	var_04 = getentarray("wallbuy","targetname");
	foreach(var_06 in var_04)
	{
		var_06 thread _terminalattractormonitor("wallbuy",150,80);
	}

	var_08 = getentarray("magic_box","targetname");
	foreach(var_06 in var_08)
	{
		var_06 thread _terminalattractormonitor("printer",250,80);
	}

	var_0B = getentarray("weapon_level_box","targetname");
	foreach(var_06 in var_0B)
	{
		var_06 thread _terminalattractormonitor("weapon_upgrade",300,80);
	}

	var_0E = common_scripts\utility::getstructarray("power_switch","targetname");
	foreach(var_10 in var_0E)
	{
		var_10 thread _terminalattractormonitor("power_switch",150,80);
	}
}

//Function Number: 30
_terminalattractormonitor(param_00,param_01,param_02)
{
	if(maps\mp\zombies\_util::is_true(self.noattract))
	{
		return;
	}

	var_03 = cos(param_02);
	var_04 = param_01 * param_01;
	if(param_00 == "host_cure")
	{
		return;
	}

	if(maps\mp\zombies\_util::getzombieslevelnum() == 3 && param_00 == "exo_tacticalArmor")
	{
		return;
	}

	level waittill("player_spawned");
	if(param_00 == "power_switch")
	{
		wait(8);
	}

	for(;;)
	{
		wait 0.05;
		if(isdefined(self.script_flag_true))
		{
			common_scripts\utility::flag_wait(self.script_flag_true);
			if(isdefined(self.postpowerattractorwait))
			{
				wait(self.postpowerattractorwait);
				self.postpowerattractorwait = undefined;
			}
		}

		if(maps\mp\zombies\_util::is_true(self.trigger_off))
		{
			if(isdefined(self.claimed) && !self.claimed)
			{
				self waittill("claimed");
			}

			continue;
		}

		if(param_00 == "printer" && !isdefined(self.active) || !self.active)
		{
			wait(1);
			continue;
		}

		if(isannouncerspeaking())
		{
			waittillannouncerdonespeaking();
			wait(1);
			continue;
		}

		var_05 = _getplayerlistforattractor(self,param_00);
		if(var_05.size == 0)
		{
			return;
		}

		var_06 = _getplayersinattractorrange(self,var_05,var_04,var_03);
		if(var_06.size == 0)
		{
			continue;
		}

		if(isdefined(self.firsttimeattractorwait))
		{
			wait(self.firsttimeattractorwait);
			self.firsttimeattractorwait = undefined;
		}

		var_07 = announcerinworlddialog("machine_per_player",param_00,self.origin,undefined,undefined,undefined,undefined,var_06);
		if(var_07)
		{
			foreach(var_09 in var_06)
			{
				var_09 _playersetattractor(param_00);
			}
		}
	}
}

//Function Number: 31
_getplayerlistforattractor(param_00,param_01)
{
	var_02 = [];
	if(isdefined(param_00.claimed))
	{
		if(param_00.claimed && isdefined(param_00.claimedby) && !param_00.claimedby _playerplayedattractor(param_01))
		{
			var_02[0] = param_00.claimedby;
		}
	}
	else
	{
		foreach(var_04 in level.players)
		{
			if(!var_04 _playerplayedattractor(param_01))
			{
				var_02[var_02.size] = var_04;
			}
		}
	}

	return var_02;
}

//Function Number: 32
_getplayersinattractorrange(param_00,param_01,param_02,param_03)
{
	var_04 = [];
	if(level.nextgen)
	{
	}
	else
	{
	}

	foreach(var_06 in param_01)
	{
		var_07 = abs(var_06.origin[2] - param_00.origin[2]);
		if(!maps\mp\zombies\_util::isplayerinfected(var_06) && var_07 < 100 && distancesquared(var_06.origin,param_00.origin) < param_02)
		{
			if(level.nextgen)
			{
				var_08 = anglestoforward(param_00.modelent.angles);
				var_09 = vectornormalize(var_06.origin - param_00.modelent.origin);
				var_0A = vectordot(var_08,var_09);
				if(var_0A > param_03)
				{
					var_04[var_04.size] = var_06;
				}

				continue;
			}

			var_04[var_04.size] = var_06;
		}
	}

	return var_04;
}

//Function Number: 33
_playersetattractor(param_00)
{
	if(!isdefined(self.attractorsvo))
	{
		self.attractorsvo = [];
	}

	self.attractorsvo[param_00] = 1;
}

//Function Number: 34
_playerplayedattractor(param_00)
{
	return isdefined(self.attractorsvo) && isdefined(self.attractorsvo[param_00]) && self.attractorsvo[param_00];
}

//Function Number: 35
monitorkiting()
{
	if(!isdefined(level.numkitingconversations))
	{
		level.numkitingconversations = 12;
	}

	if(level.numkitingconversations == 0)
	{
		return;
	}

	level.kitingconversations = [];
	for(var_00 = 1;var_00 <= level.numkitingconversations;var_00++)
	{
		level.kitingconversations[level.kitingconversations.size] = var_00;
	}

	if(!maps\mp\zombies\_util::is_true(level.zmbaudioskiprandomizingkitingvo))
	{
		level.kitingconversations = common_scripts\utility::array_randomize(level.kitingconversations);
	}

	if(!isdefined(level.zmbaudiokitingstartwave))
	{
		level.zmbaudiokitingstartwave = 4;
	}

	for(;;)
	{
		level waittill("zombie_wave_started");
		if(level.kitingconversations.size == 0)
		{
			return;
		}

		if(level.wavecounter < level.zmbaudiokitingstartwave)
		{
			continue;
		}

		wait 0.05;
		while(level.zombie_spawning_active)
		{
			wait(1);
		}

		var_01 = maps\mp\zombies\zombies_spawn_manager::getnumberofzombies();
		for(;;)
		{
			if(var_01 == 0)
			{
				break;
			}
			else if(var_01 == 1)
			{
				if(isdefined(level.zmbaudiokitingcustom))
				{
					thread [[ level.zmbaudiokitingcustom ]]();
				}
				else
				{
					thread _kitingplayrandomvo();
				}

				break;
			}

			var_01 = maps\mp\zombies\zombies_spawn_manager::getnumberofzombies();
			wait 0.05;
		}
	}
}

//Function Number: 36
_kitingplayrandomvo()
{
	level endon("zombie_wave_ended");
	wait(randomintrange(15,30));
	var_00 = level.kitingconversations.size - 1;
	var_01 = level.kitingconversations[var_00];
	var_02 = "an_conv";
	var_03 = "an_conv_" + var_01;
	var_04 = 0;
	if(isdefined(level.vox.speaker["player"].alias[var_02]) && isdefined(level.vox.speaker["player"].alias[var_02][var_03]))
	{
		var_05 = common_scripts\utility::array_randomize(level.players);
		foreach(var_07 in var_05)
		{
			maps\mp\zombies\_zombies_audio::waituntilquietnearby(var_07,var_02);
			var_08 = var_07 maps\mp\zombies\_zombies_audio::create_and_play_dialog(var_02,var_03);
			if(var_08)
			{
				break;
			}
		}
	}
	else if(isdefined(level.vox.speaker["announcer"].alias[var_02]) && isdefined(level.vox.speaker["announcer"].alias[var_02][var_03]))
	{
		var_0A = getannouncer();
		maps\mp\zombies\_zombies_audio::waituntilquietnearby(var_0A,var_02);
		var_0A maps\mp\zombies\_zombies_audio::create_and_play_dialog(var_02,var_03,undefined,undefined,undefined,level.player,level.players);
	}
	else
	{
	}

	level.kitingconversations[var_00] = undefined;
}