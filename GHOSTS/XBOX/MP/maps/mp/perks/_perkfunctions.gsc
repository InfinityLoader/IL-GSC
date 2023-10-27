/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\perks\_perkfunctions.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 214
 * Decompile Time: 3452 ms
 * Timestamp: 10/27/2023 1:33:37 AM
*******************************************************************/

//Function Number: 1
func_7089()
{
}

//Function Number: 2
func_8631()
{
}

//Function Number: 3
func_7027()
{
}

//Function Number: 4
func_861B()
{
}

//Function Number: 5
func_6FE7()
{
	if(!isplayer(self))
	{
	}

	autospotadswatcher();
	autospotdeathwatcher();
}

//Function Number: 6
autospotdeathwatcher()
{
	self waittill("death");
	self endon("disconnect");
	self endon("endAutoSpotAdsWatcher");
	level endon("game_ended");
	self autospotoverlayoff();
}

//Function Number: 7
func_8604()
{
	if(!isplayer(self))
	{
	}

	self notify("endAutoSpotAdsWatcher");
	self autospotoverlayoff();
}

//Function Number: 8
autospotadswatcher()
{
	self endon("death");
	self endon("disconnect");
	self endon("endAutoSpotAdsWatcher");
	level endon("game_ended");
	var_00 = 0;
	for(;;)
	{
		wait(0.05);
		if(self isusingturret())
		{
			self autospotoverlayoff();
			continue;
		}

		var_01 = self playerads();
		if(var_01 < 1 && var_00)
		{
			var_00 = 0;
			self autospotoverlayoff();
		}

		if(var_01 < 1 && !var_00)
		{
			continue;
		}

		if(var_01 == 1 && !var_00)
		{
			var_00 = 1;
			self autospotoverlayon();
		}
	}
}

//Function Number: 9
func_70B4()
{
}

//Function Number: 10
func_863A()
{
}

//Function Number: 11
timeoutregenfaster()
{
	self.hasregenfaster = undefined;
	maps\mp\_utility::_unsetperk("specialty_regenfaster");
	self setclientdvar("ui_regen_faster_end_milliseconds",0);
	self notify("timeOutRegenFaster");
}

//Function Number: 12
sethardshell()
{
	self.shellshockreduction = 0.25;
}

//Function Number: 13
func_8624()
{
	self.shellshockreduction = 0;
}

//Function Number: 14
func_70C1()
{
	thread func_9348();
}

//Function Number: 15
func_9348()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("stop_monitorSharpFocus");
	if(!isdefined(level.snipers))
	{
		level.snipers = [];
		level.snipers["iw6_gm6_mp"] = 1;
		level.snipers["iw6_l115a3_mp"] = 1;
		level.snipers["iw6_usr_mp"] = 1;
		level.snipers["iw6_vks_mp"] = 1;
		level.snipers["iw6_dlcweap03_mp"] = 1;
	}

	var_00 = self getcurrentweapon();
	for(;;)
	{
		var_01 = undefined;
		if(isdefined(var_00) && var_00 != "none")
		{
			var_01 = getweaponbasename(var_00);
		}

		if(isdefined(var_01) && isdefined(level.snipers[var_01]))
		{
			self setviewkickscale(0.5);
		}
		else
		{
			self setviewkickscale(0.25);
		}

		self waittill("weapon_change",var_00);
	}
}

//Function Number: 16
func_8640()
{
	self notify("stop_monitorSharpFocus");
	self setviewkickscale(1);
}

//Function Number: 17
func_7023()
{
	self endon("death");
	self endon("disconnect");
	self endon("endDoubleLoad");
	level endon("game_ended");
	for(;;)
	{
		self waittill("reload");
		var_00 = self getweaponslist("primary");
		foreach(var_02 in var_00)
		{
			var_03 = self getweaponammoclip(var_02);
			var_04 = weaponclipsize(var_02);
			var_05 = var_04 - var_03;
			var_06 = self getweaponammostock(var_02);
			if(var_03 != var_04 && var_06 > 0)
			{
				if(var_03 + var_06 >= var_04)
				{
					self setweaponammoclip(var_02,var_04);
					self setweaponammostock(var_02,var_06 - var_05);
					continue;
				}

				self setweaponammoclip(var_02,var_03 + var_06);
				if(var_06 - var_05 > 0)
				{
					self setweaponammostock(var_02,var_06 - var_05);
					continue;
				}

				self setweaponammostock(var_02,0);
			}
		}
	}
}

//Function Number: 18
func_861A()
{
	self notify("endDoubleLoad");
}

//Function Number: 19
func_7069(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 10;
	}
	else
	{
		param_00 = castint(param_00) * 2;
	}

	maps\mp\_utility::func_70B1(param_00);
	self.recoilscale = param_00;
}

//Function Number: 20
func_862F()
{
	maps\mp\_utility::func_70B1(0);
	self.recoilscale = 0;
}

//Function Number: 21
func_70B8()
{
	self endon("unsetRShieldRadar");
	wait(0.75);
	self makeportableradar();
	thread func_70B9();
}

//Function Number: 22
func_70B9()
{
	self endon("unsetRShieldRadar");
	common_scripts\utility::func_8B2A("disconnect","death");
	if(isdefined(self))
	{
		func_863C();
	}
}

//Function Number: 23
func_863C()
{
	self clearportableradar();
	self notify("unsetRShieldRadar");
}

//Function Number: 24
func_70BA()
{
	self makescrambler();
	thread func_70BB();
}

//Function Number: 25
func_70BB()
{
	self endon("unsetRShieldScrambler");
	common_scripts\utility::func_8B2A("disconnect","death");
	if(isdefined(self))
	{
		func_863D();
	}
}

//Function Number: 26
func_863D()
{
	self clearscrambler();
	self notify("unsetRShieldScrambler");
}

//Function Number: 27
func_70D8(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 10;
	}

	param_00 = castint(param_00);
	if(param_00 == 10)
	{
		self.stunscaler = 0;
	}

	self.stunscaler = param_00 / 10;
}

//Function Number: 28
func_8645()
{
	self.stunscaler = 1;
}

//Function Number: 29
applystunresistence(param_00)
{
	if(isdefined(self.stunscaler))
	{
		return self.stunscaler * param_00;
	}

	return param_00;
}

//Function Number: 30
func_7216()
{
	if(isbot(self))
	{
	}

	self endon("unsetWeaponLaser");
	wait(0.5);
	thread func_7217();
}

//Function Number: 31
func_864D()
{
	self notify("unsetWeaponLaser");
	if(isdefined(self.perkweaponlaseron) && self.perkweaponlaseron)
	{
		maps\mp\_utility::func_27C1();
	}

	self.perkweaponlaseron = undefined;
	self.perkweaponlaseroffforswitchstart = undefined;
}

//Function Number: 32
setweaponlaser_waitforlaserweapon(param_00)
{
	for(;;)
	{
		param_00 = getweaponbasename(param_00);
		if(isdefined(param_00) && param_00 == "iw6_kac_mp" || param_00 == "iw6_arx160_mp")
		{
			break;
		}

		self waittill("weapon_change",param_00);
	}
}

//Function Number: 33
func_7217()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetWeaponLaser");
	self.perkweaponlaseron = 0;
	var_00 = self getcurrentweapon();
	for(;;)
	{
		setweaponlaser_waitforlaserweapon(var_00);
		if(self.perkweaponlaseron == 0)
		{
			self.perkweaponlaseron = 1;
			maps\mp\_utility::enableweaponlaser();
		}

		childthread func_7218();
		childthread setweaponlaser_monitorweaponswitchstart(1);
		self.perkweaponlaseroffforswitchstart = undefined;
		self waittill("weapon_change",var_00);
		if(self.perkweaponlaseron == 1)
		{
			self.perkweaponlaseron = 0;
			maps\mp\_utility::func_27C1();
		}
	}
}

//Function Number: 34
setweaponlaser_monitorweaponswitchstart(param_00)
{
	self endon("weapon_change");
	for(;;)
	{
		self waittill("weapon_switch_started");
		childthread setweaponlaser_onweaponswitchstart(param_00);
	}
}

//Function Number: 35
setweaponlaser_onweaponswitchstart(param_00)
{
	self notify("setWeaponLaser_onWeaponSwitchStart");
	self endon("setWeaponLaser_onWeaponSwitchStart");
	if(self.perkweaponlaseron == 1)
	{
		self.perkweaponlaseroffforswitchstart = 1;
		self.perkweaponlaseron = 0;
		maps\mp\_utility::func_27C1();
	}

	wait(param_00);
	self.perkweaponlaseroffforswitchstart = undefined;
	if(self.perkweaponlaseron == 0 && self playerads() <= 0.6)
	{
		self.perkweaponlaseron = 1;
		maps\mp\_utility::enableweaponlaser();
	}
}

//Function Number: 36
func_7218()
{
	self endon("weapon_change");
	for(;;)
	{
		if(!isdefined(self.perkweaponlaseroffforswitchstart) || self.perkweaponlaseroffforswitchstart == 0)
		{
			if(self playerads() > 0.6)
			{
				if(self.perkweaponlaseron == 1)
				{
					self.perkweaponlaseron = 0;
					maps\mp\_utility::func_27C1();
				}
			}
			else if(self.perkweaponlaseron == 0)
			{
				self.perkweaponlaseron = 1;
				maps\mp\_utility::enableweaponlaser();
			}
		}

		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 37
func_70D3()
{
	self setaimspreadmovementscale(0.5);
}

//Function Number: 38
func_8642()
{
	self notify("end_SteadyAimPro");
	self setaimspreadmovementscale(1);
}

//Function Number: 39
blastshieldusetracker(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	self endon("end_perkUseTracker");
	level endon("game_ended");
	for(;;)
	{
		self waittill("empty_offhand");
		if(!common_scripts\utility::isoffhandweaponenabled())
		{
			continue;
		}

		self [[ param_01 ]](maps\mp\_utility::_hasperk("_specialty_blastshield"));
	}
}

//Function Number: 40
func_5BA4()
{
	self endon("disconnect");
	self waittill("death");
	self._useperkenabled = undefined;
}

//Function Number: 41
func_70B0()
{
}

//Function Number: 42
func_8637()
{
	self notify("end_perkUseTracker");
}

//Function Number: 43
func_7029()
{
	if(isdefined(self.endgame))
	{
	}

	self.maxhealth = maps\mp\gametypes\_tweakables::func_3C5B("player","maxhealth") * 4;
	self.health = self.maxhealth;
	self.endgame = 1;
	self.attackertable[0] = "";
	self visionsetnakedforplayer("end_game",5);
	thread func_2D57(7);
	maps\mp\gametypes\_gamelogic::func_7049(self,1);
}

//Function Number: 44
func_861C()
{
	self notify("stopEndGame");
	self.endgame = undefined;
	maps\mp\_utility::func_6659(1);
	if(!isdefined(self.endgametimer))
	{
	}

	self.endgametimer maps\mp\gametypes\_hud_util::destroyelem();
	self.endgameicon maps\mp\gametypes\_hud_util::destroyelem();
}

//Function Number: 45
func_2D57(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	level endon("game_ended");
	self endon("stopEndGame");
	wait(param_00 + 1);
	maps\mp\_utility::_suicide();
}

//Function Number: 46
func_6FFF()
{
	if(!level.hardcoremode)
	{
		self.maxhealth = maps\mp\gametypes\_tweakables::func_3C5B("player","maxhealth");
		if(isdefined(self.var_8E7B) && self.var_8E7B == 1 && self.maxhealth > 30)
		{
			self.var_8E7B = 2;
		}
	}
}

//Function Number: 47
func_860D()
{
	self.var_8E7B = 1;
}

//Function Number: 48
func_70BC()
{
	self.objectivescaler = 1.2;
}

//Function Number: 49
func_863E()
{
	self.objectivescaler = 1;
}

//Function Number: 50
func_7006()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetCombatSpeed");
	self.incombatspeed = 0;
	func_8612();
	for(;;)
	{
		self waittill("damage",var_00,var_01);
		if(!isdefined(var_01.team))
		{
			continue;
		}

		if(level.teambased && var_01.team == self.team)
		{
			continue;
		}

		if(self.incombatspeed)
		{
			continue;
		}

		func_7007();
		self.incombatspeed = 1;
		thread endofspeedwatcher();
	}
}

//Function Number: 51
endofspeedwatcher()
{
	self notify("endOfSpeedWatcher");
	self endon("endOfSpeedWatcher");
	self endon("death");
	self endon("disconnect");
	self waittill("healed");
	func_8612();
	self.incombatspeed = 0;
}

//Function Number: 52
func_7007()
{
	if(isdefined(self.isjuggernaut) && self.isjuggernaut)
	{
	}

	if(self.weaponspeed <= 0.8)
	{
		self.combatspeedscalar = 1.4;
	}
	else if(self.weaponspeed <= 0.9)
	{
		self.combatspeedscalar = 1.3;
	}
	else
	{
		self.combatspeedscalar = 1.2;
	}

	maps\mp\gametypes\_weapons::func_8707();
}

//Function Number: 53
func_8612()
{
	self.combatspeedscalar = 1;
	maps\mp\gametypes\_weapons::func_8707();
}

//Function Number: 54
func_8611()
{
	func_8612();
	self notify("unsetCombatSpeed");
}

//Function Number: 55
setlightweight()
{
	if(!isdefined(self.cranked))
	{
		self.movespeedscaler = maps\mp\_utility::func_4E12();
		maps\mp\gametypes\_weapons::func_8707();
	}
}

//Function Number: 56
func_862C()
{
	self.movespeedscaler = 1;
	maps\mp\gametypes\_weapons::func_8707();
}

//Function Number: 57
func_6FE9()
{
	self.var_4B42 = 1.5;
}

//Function Number: 58
func_8605()
{
	self.var_4B42 = 1;
}

//Function Number: 59
func_70D4()
{
	maps\mp\_utility::func_3CFB("specialty_bulletaccuracy",1);
	maps\mp\_utility::func_3CFB("specialty_holdbreath",0);
}

//Function Number: 60
func_8643()
{
	maps\mp\_utility::_unsetperk("specialty_bulletaccuracy");
	maps\mp\_utility::_unsetperk("specialty_holdbreath");
}

//Function Number: 61
setdelaymine()
{
}

//Function Number: 62
func_8619()
{
}

//Function Number: 63
func_7066()
{
	if(!maps\mp\_utility::func_48B2())
	{
		self makescrambler();
	}
}

//Function Number: 64
func_862E()
{
	self clearscrambler();
}

//Function Number: 65
setac130()
{
	thread killstreakthink("ac130",7,"end_ac130Think");
}

//Function Number: 66
func_8602()
{
	self notify("end_ac130Think");
}

//Function Number: 67
func_70C0()
{
	thread killstreakthink("airdrop_sentry_minigun",2,"end_sentry_minigunThink");
}

//Function Number: 68
func_863F()
{
	self notify("end_sentry_minigunThink");
}

//Function Number: 69
func_70DE()
{
	thread killstreakthink("tank",6,"end_tankThink");
}

//Function Number: 70
func_8648()
{
	self notify("end_tankThink");
}

//Function Number: 71
func_70AA()
{
	thread killstreakthink("precision_airstrike",6,"end_precision_airstrike");
}

//Function Number: 72
func_8634()
{
	self notify("end_precision_airstrike");
}

//Function Number: 73
func_70AB()
{
	thread killstreakthink("predator_missile",4,"end_predator_missileThink");
}

//Function Number: 74
func_8635()
{
	self notify("end_predator_missileThink");
}

//Function Number: 75
func_704D()
{
	thread killstreakthink("helicopter_minigun",5,"end_helicopter_minigunThink");
}

//Function Number: 76
func_8625()
{
	self notify("end_helicopter_minigunThink");
}

//Function Number: 77
killstreakthink(param_00,param_01,param_02)
{
	self endon("death");
	self endon("disconnect");
	self endon(param_02);
	for(;;)
	{
		self waittill("killed_enemy");
		if(self.pers["cur_kill_streak"] != param_01)
		{
			continue;
		}

		thread maps\mp\killstreaks\_killstreaks::func_3CF2(param_00);
		thread maps\mp\gametypes\_hud_message::func_4B46(param_00,param_01);
	}
}

//Function Number: 78
func_70E5()
{
	self thermalvisionon();
}

//Function Number: 79
func_8649()
{
	self thermalvisionoff();
}

//Function Number: 80
func_7087()
{
	thread onemanarmyweaponchangetracker();
}

//Function Number: 81
func_8630()
{
	self notify("stop_oneManArmyTracker");
}

//Function Number: 82
onemanarmyweaponchangetracker()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("stop_oneManArmyTracker");
	for(;;)
	{
		self waittill("weapon_change",var_00);
		if(var_00 != "onemanarmy_mp")
		{
			continue;
		}

		thread func_6D83();
	}
}

//Function Number: 83
isonemanarmymenu(param_00)
{
	if(param_00 == game["menu_onemanarmy"])
	{
		return 1;
	}

	if(isdefined(game["menu_onemanarmy_defaults_splitscreen"]) && param_00 == game["menu_onemanarmy_defaults_splitscreen"])
	{
		return 1;
	}

	if(isdefined(game["menu_onemanarmy_custom_splitscreen"]) && param_00 == game["menu_onemanarmy_custom_splitscreen"])
	{
		return 1;
	}

	return 0;
}

//Function Number: 84
func_6D83()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	common_scripts\utility::_disableweaponswitch();
	common_scripts\utility::_disableoffhandweapons();
	common_scripts\utility::_disableusability();
	self openpopupmenu(game["menu_onemanarmy"]);
	thread closeomamenuondeath();
	self waittill("menuresponse",var_00,var_01);
	common_scripts\utility::_enableweaponswitch();
	common_scripts\utility::func_66F();
	common_scripts\utility::_enableusability();
	if(var_01 == "back" || !isonemanarmymenu(var_00) || maps\mp\_utility::func_4995())
	{
		if(self getcurrentweapon() == "onemanarmy_mp")
		{
			common_scripts\utility::_disableweaponswitch();
			common_scripts\utility::_disableoffhandweapons();
			common_scripts\utility::_disableusability();
			self switchtoweapon(common_scripts\utility::func_3B0A());
			self waittill("weapon_change");
			common_scripts\utility::_enableweaponswitch();
			common_scripts\utility::func_66F();
			common_scripts\utility::_enableusability();
		}
	}

	thread func_3CF9(var_01);
}

//Function Number: 85
closeomamenuondeath()
{
	self endon("menuresponse");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("death");
	common_scripts\utility::_enableweaponswitch();
	common_scripts\utility::func_66F();
	common_scripts\utility::_enableusability();
}

//Function Number: 86
func_3CF9(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(maps\mp\_utility::_hasperk("specialty_omaquickchange"))
	{
		var_01 = 3;
		maps\mp\_utility::playplayerandnpcsounds(self,"foly_onemanarmy_bag3_plr","foly_onemanarmy_bag3_npc");
	}
	else
	{
		var_01 = 6;
		maps\mp\_utility::playplayerandnpcsounds(self,"foly_onemanarmy_bag6_plr","foly_onemanarmy_bag6_npc");
	}

	thread func_58D4(var_01);
	common_scripts\utility::_disableweapon();
	common_scripts\utility::_disableoffhandweapons();
	common_scripts\utility::_disableusability();
	wait(var_01);
	common_scripts\utility::_enableweapon();
	common_scripts\utility::func_66F();
	common_scripts\utility::_enableusability();
	self.omaclasschanged = 1;
	maps\mp\gametypes\_class::giveloadout(self.pers["team"],param_00);
	if(isdefined(self.carryflag))
	{
		self attach(self.carryflag,"J_spine4",1);
	}

	self notify("changed_kit");
	level notify("changed_kit");
}

//Function Number: 87
func_58D4(param_00)
{
	self endon("disconnect");
	var_01 = maps\mp\gametypes\_hud_util::createprimaryprogressbar();
	var_02 = maps\mp\gametypes\_hud_util::createprimaryprogressbartext();
	var_02 settext(&"MPUI_CHANGING_KIT");
	var_01 maps\mp\gametypes\_hud_util::func_86CD(0,1 / param_00);
	var_03 = 0;
	while(var_03 < param_00 && isalive(self) && !level.gameended)
	{
		wait(0.05);
		var_03 = var_03 + 0.05;
	}

	var_01 maps\mp\gametypes\_hud_util::destroyelem();
	var_02 maps\mp\gametypes\_hud_util::destroyelem();
}

//Function Number: 88
func_6FEB()
{
	self setweaponhudiconoverride("primaryoffhand","specialty_blastshield");
}

//Function Number: 89
func_8606()
{
	self setweaponhudiconoverride("primaryoffhand","none");
}

//Function Number: 90
func_703B()
{
}

//Function Number: 91
func_8620()
{
}

//Function Number: 92
func_70DA()
{
	self setoffhandsecondaryclass("flash");
	maps\mp\_utility::_giveweapon("flare_mp",0);
	self givestartammo("flare_mp");
	thread func_53D3();
}

//Function Number: 93
func_8646()
{
	self notify("end_monitorTIUse");
}

//Function Number: 94
clearprevioustispawnpoint()
{
	common_scripts\utility::func_8B2A("disconnect","joined_team","joined_spectators");
	if(isdefined(self.setspawnpoint))
	{
		deleteti(self.setspawnpoint);
	}
}

//Function Number: 95
func_8749()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("end_monitorTIUse");
	while(maps\mp\_utility::func_4945(self))
	{
		if(func_49AC())
		{
			self.tispawnposition = self.origin;
		}

		wait(0.05);
	}
}

//Function Number: 96
func_49AC()
{
	if(canspawn(self.origin) && self isonground())
	{
		return 1;
	}

	return 0;
}

//Function Number: 97
func_80CC(param_00)
{
	if(maps\mp\_utility::func_4945(param_00.owner))
	{
		param_00.owner deleteti(self);
	}
}

//Function Number: 98
func_53D3()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self endon("end_monitorTIUse");
	thread func_8749();
	thread clearprevioustispawnpoint();
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(var_01 != "flare_mp")
		{
			continue;
		}

		if(isdefined(self.setspawnpoint))
		{
			deleteti(self.setspawnpoint);
		}

		if(!isdefined(self.tispawnposition))
		{
			continue;
		}

		if(maps\mp\_utility::func_818D())
		{
			continue;
		}

		var_02 = self.tispawnposition + (0,0,16);
		var_03 = self.tispawnposition - (0,0,2048);
		var_04 = playerphysicstrace(var_02,var_03) + (0,0,1);
		var_05 = bullettrace(var_02,var_03,0);
		var_06 = spawn("script_model",var_04);
		var_06.angles = self.angles;
		var_06.team = self.team;
		var_06.owner = self;
		var_06.enemytrigger = spawn("script_origin",var_04);
		var_06 thread func_3D49(self);
		var_06.playerspawnpos = self.tispawnposition;
		var_06 setotherent(self);
		var_06 common_scripts\utility::func_5009(self.team,1);
		var_06 thread maps\mp\gametypes\_weapons::createbombsquadmodel("weapon_light_stick_tactical_bombsquad","tag_fire_fx",self);
		var_06 maps\mp\gametypes\_weapons::explosivehandlemovers(var_05["entity"]);
		maps\mp\gametypes\_weapons::func_597C(var_06);
		self.setspawnpoint = var_06;
	}
}

//Function Number: 99
func_3D49(param_00)
{
	self setmodel(level.spawnglowmodel["enemy"]);
	if(level.teambased)
	{
		maps\mp\_entityheadicons::func_70E0(self.team,(0,0,20));
	}
	else
	{
		maps\mp\_entityheadicons::func_7099(param_00,(0,0,20));
	}

	thread func_3D44(param_00);
	thread glowstickenemyuselistener(param_00);
	thread glowstickuselistener(param_00);
	thread glowstickwaitforownerdisconnect(param_00);
	var_01 = spawn("script_model",self.origin + (0,0,0));
	var_01.angles = self.angles;
	var_01 setmodel(level.spawnglowmodel["friendly"]);
	var_01 setcontents(0);
	var_01 linkto(self);
	var_01 playloopsound("emt_road_flare_burn");
	thread func_3D4A(self,var_01,param_00);
	self waittill("death");
	var_01 stoploopsound();
	var_01 delete();
}

//Function Number: 100
func_3D4A(param_00,param_01,param_02)
{
	param_00 endon("death");
	wait(0.05);
	var_03 = [];
	var_03["enemy"] = param_00;
	var_03["friendly"] = param_01;
	for(;;)
	{
		foreach(var_05 in var_03)
		{
			var_05 hide();
		}

		foreach(var_08 in level.players)
		{
			var_09 = "friendly";
			if(param_02 maps\mp\_utility::isenemy(var_08))
			{
				var_09 = "enemy";
			}

			var_05 = var_03[var_09];
			var_05 show();
			playfxontagforclients(level.spawnglow[var_09],var_05,"tag_fire_fx",var_08);
			common_scripts\utility::func_8AFE();
		}

		level waittill("joined_team");
		foreach(var_09, var_05 in var_03)
		{
			stopfxontag(level.spawnglow[var_09],var_05,"tag_fire_fx");
		}

		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 101
deleteondeath(param_00)
{
	self waittill("death");
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 102
func_3D44(param_00)
{
	maps\mp\gametypes\_damage::func_537B(100,"tactical_insertion",::func_3D47,::glowstickhandledeathdamage,1);
}

//Function Number: 103
func_3D47(param_00,param_01,param_02,param_03)
{
	return maps\mp\gametypes\_damage::handlemeleedamage(param_01,param_02);
}

//Function Number: 104
glowstickhandledeathdamage(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.owner) && param_00 != self.owner)
	{
		param_00 notify("destroyed_insertion",self.owner);
		param_00 notify("destroyed_equipment");
		self.owner thread maps\mp\_utility::func_4D35("ti_destroyed",undefined,undefined,self.origin);
	}

	param_00 thread deleteti(self);
}

//Function Number: 105
glowstickuselistener(param_00)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	self setcursorhint("HINT_NOICON");
	self sethintstring(&"MP_PATCH_PICKUP_TI");
	thread updateenemyuse(param_00);
	for(;;)
	{
		self waittill("trigger",var_01);
		var_01 playsound("tactical_insert_flare_pu");
		if(!var_01 maps\mp\_utility::isjuggernaut())
		{
			var_01 thread func_70DA();
		}

		var_01 thread deleteti(self);
	}
}

//Function Number: 106
updateenemyuse(param_00)
{
	self endon("death");
	for(;;)
	{
		maps\mp\_utility::func_70BF(param_00);
		level common_scripts\utility::func_8B4F("joined_team","player_spawned");
	}
}

//Function Number: 107
glowstickwaitforownerdisconnect(param_00)
{
	self endon("death");
	param_00 waittill("disconnect");
	thread deleteti(self);
}

//Function Number: 108
deleteti(param_00)
{
	if(isdefined(param_00.enemytrigger))
	{
		param_00.enemytrigger delete();
	}

	var_01 = param_00.origin;
	var_02 = param_00.angles;
	var_03 = param_00 getlinkedparent();
	param_00 delete();
	var_04 = spawn("script_model",var_01);
	var_04.angles = var_02;
	var_04 setmodel(level.spawnglowmodel["friendly"]);
	var_04 setcontents(0);
	if(isdefined(var_03))
	{
		var_04 linkto(var_03);
	}

	thread func_2B8E(var_04);
}

//Function Number: 109
func_2B8E(param_00)
{
	wait(2.5);
	param_00 delete();
}

//Function Number: 110
glowstickenemyuselistener(param_00)
{
	self endon("death");
	level endon("game_ended");
	param_00 endon("disconnect");
	self.enemytrigger setcursorhint("HINT_NOICON");
	self.enemytrigger sethintstring(&"MP_PATCH_DESTROY_TI");
	self.enemytrigger maps\mp\_utility::func_5013(param_00);
	for(;;)
	{
		self.enemytrigger waittill("trigger",var_01);
		var_01 notify("destroyed_insertion",param_00);
		var_01 notify("destroyed_equipment");
		if(isdefined(param_00) && var_01 != param_00)
		{
			param_00 thread maps\mp\_utility::func_4D35("ti_destroyed",undefined,undefined,self.origin);
		}

		var_01 thread deleteti(self);
	}
}

//Function Number: 111
func_7065()
{
	thread killstreakthink("littlebird_support",2,"end_littlebird_support_think");
}

//Function Number: 112
func_862D()
{
	self notify("end_littlebird_support_think");
}

//Function Number: 113
func_708E(param_00)
{
	if(isplayer(self))
	{
		var_01 = 1;
		if(!maps\mp\_utility::_hasperk("specialty_incog"))
		{
			self.painted = 1;
			if(level.teambased)
			{
				var_02 = maps\mp\_utility::func_5A45(self,"orange",param_00.team,0,"perk");
				thread watchpainted(var_02,var_01);
				thread watchpaintedagain(var_02);
			}

			var_02 = maps\mp\_utility::func_5A44(self,"orange",var_01,0,"perk");
			thread watchpainted(var_02,var_01);
			thread watchpaintedagain(var_02);
		}
	}
}

//Function Number: 114
watchpainted(param_00,param_01)
{
	self notify("painted_again");
	self endon("painted_again");
	self endon("disconnect");
	level endon("game_ended");
	common_scripts\utility::func_8B35(param_01,"death");
	self.painted = 0;
	maps\mp\_utility::func_5A40(param_00,self);
	self notify("painted_end");
}

//Function Number: 115
watchpaintedagain(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	common_scripts\utility::func_8B2A("painted_again","painted_end");
	maps\mp\_utility::func_5A40(param_00,self);
}

//Function Number: 116
ispainted()
{
	return isdefined(self.painted) && self.painted;
}

//Function Number: 117
func_6FE6()
{
}

//Function Number: 118
func_8603()
{
}

//Function Number: 119
func_70B3()
{
	if(isdefined(self.primarygrenade))
	{
		self givemaxammo(self.primarygrenade);
	}

	if(isdefined(self.secondarygrenade))
	{
		self givemaxammo(self.secondarygrenade);
	}
}

//Function Number: 120
unsetrefillgrenades()
{
}

//Function Number: 121
func_70B2()
{
	if(isdefined(self.primaryweapon))
	{
		self givemaxammo(self.primaryweapon);
	}

	if(isdefined(self.secondaryweapon))
	{
		self givemaxammo(self.secondaryweapon);
	}
}

//Function Number: 122
func_8638()
{
}

//Function Number: 123
func_7045()
{
	thread setgunsmithinternal();
}

//Function Number: 124
setgunsmithinternal()
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	self endon("unsetGunsmith");
	self waittill("giveLoadout");
	if(self.loadoutprimaryattachments.size == 0 && self.loadoutsecondaryattachments.size == 0)
	{
	}

	for(;;)
	{
		self waittill("weapon_change",var_00);
		if(var_00 == "none")
		{
			continue;
		}

		if(maps\mp\_utility::func_48F7(var_00))
		{
			continue;
		}

		if(!maps\mp\_utility::func_4971(var_00,"iw5_") && !maps\mp\_utility::func_4971(var_00,"iw6_"))
		{
			continue;
		}

		var_01 = undefined;
		if(maps\mp\_utility::getweaponclass(var_00) == "weapon_pistol")
		{
			if(self.loadoutsecondaryattachments.size > 0)
			{
				var_01 = self.loadoutsecondaryattachments;
			}
		}
		else if(self.loadoutprimaryattachments.size > 0)
		{
			var_01 = self.loadoutprimaryattachments;
		}

		if(!isdefined(var_01))
		{
			continue;
		}

		var_02 = 0;
		var_03 = maps\mp\_utility::func_3C72(var_00);
		if(var_03.size == 0)
		{
			var_02 = 1;
		}
		else
		{
			foreach(var_05 in var_01)
			{
				if(!common_scripts\utility::array_contains(var_03,var_05))
				{
					var_02 = 1;
					break;
				}
			}
		}

		if(!var_02)
		{
			continue;
		}

		var_07 = [];
		var_08 = maps\mp\_utility::func_3C6F(var_00);
		foreach(var_05 in var_01)
		{
			if(common_scripts\utility::array_contains(var_08,var_05))
			{
				var_07[var_07.size] = var_05;
			}
		}

		var_01 = var_07;
		var_0B = [];
		foreach(var_0D in var_03)
		{
			var_0E = 1;
			foreach(var_10 in var_01)
			{
				if(!maps\mp\_utility::attachmentscompatible(var_10,var_0D))
				{
					var_0E = 0;
					break;
				}
			}

			if(var_0E)
			{
				var_0B[var_0B.size] = var_0D;
			}
		}

		var_03 = var_0B;
		var_13 = var_01.size + var_03.size;
		if(var_13 > 4)
		{
			var_03 = common_scripts\utility::array_randomize(var_03);
		}

		for(var_14 = 0;var_01.size < 4 && var_14 < var_03.size;var_14++)
		{
			var_01[var_01.size] = var_03[var_14];
		}

		var_15 = getweaponbasename(var_00);
		var_16 = var_15;
		foreach(var_14, var_05 in var_01)
		{
			var_18 = maps\mp\_utility::attachmentmap_tounique(var_05,var_00);
			var_01[var_14] = var_18;
		}

		var_01 = common_scripts\utility::alphabetize(var_01);
		foreach(var_05 in var_01)
		{
			var_16 = var_16 + "_" + var_05;
		}

		if(var_16 != var_15)
		{
			var_1B = self getweaponammoclip(var_00);
			var_1C = self getweaponammostock(var_00);
			self takeweapon(var_00);
			self giveweapon(var_16);
			self setweaponammoclip(var_16,var_1B);
			self setweaponammostock(var_16,var_1C);
			self switchtoweapon(var_16);
		}
	}
}

//Function Number: 125
func_8623()
{
	self notify("unsetGunsmith");
}

//Function Number: 126
func_703E()
{
	self setclientomnvar("ui_gambler_show",-1);
	setgamblerinternal();
}

//Function Number: 127
setgamblerinternal()
{
	level.abilitymaxval = [];
	var_00 = maps\mp\gametypes\_class::getnumabilitycategories();
	var_01 = maps\mp\gametypes\_class::getnumsubability();
	var_02 = [];
	var_03 = 0;
	var_04 = undefined;
	if(isai(self))
	{
		var_04 = self.pers["loadoutPerks"];
	}

	if(!isdefined(level.perknamesforgambler))
	{
		level.perknamesforgambler = [];
		level.perkcostsforgambler = [];
		level.perkrowsforgambler = [];
		for(var_05 = 0;var_05 < var_00;var_05++)
		{
			for(var_06 = 0;var_06 < var_01;var_06++)
			{
				var_07 = tablelookup("mp/cacAbilityTable.csv",0,var_05 + 1,4 + var_06);
				level.perknamesforgambler[var_05][var_06] = var_07;
				for(var_08 = 0;tablelookupbyrow("mp/perktable.csv",var_08,0) != "";var_08++)
				{
					if(var_07 == tablelookupbyrow("mp/perktable.csv",var_08,1))
					{
						level.perkcostsforgambler[var_05][var_06] = castint(tablelookupbyrow("mp/perktable.csv",var_08,10));
						level.perkrowsforgambler[var_05][var_06] = var_08;
						break;
					}
				}
			}
		}
	}

	var_09 = gamblercommonchecker();
	var_0A = 0;
	if(level.gametype == "infect")
	{
		var_09 = 0;
	}

	if(isdefined(self.teamname))
	{
		var_0A = getmatchrulesdata("defaultClasses",self.teamname,self.class_num,"class","abilitiesPicked",6,0);
	}

	for(var_05 = 0;var_05 < var_00;var_05++)
	{
		for(var_06 = 0;var_06 < var_01;var_06++)
		{
			var_0B = level.perknamesforgambler[var_05][var_06];
			var_0C = perkpickedchecker(var_0B,var_05,var_06);
			if(var_0C && self.streaktype == "specialist" || !self.perkpickedspecialist)
			{
				continue;
			}

			if(!isdefined(var_0B))
			{
				continue;
			}

			if(var_0B == "")
			{
				continue;
			}

			if(var_0B == "specialty_extra_attachment" || var_0B == "specialty_twoprimaries")
			{
				continue;
			}

			if(isdefined(var_09) && !var_09 && !var_0A)
			{
				if(var_0B == "specialty_extraammo" || var_0B == "specialty_extra_equipment" || var_0B == "specialty_extra_deadly")
				{
					continue;
				}
			}

			if(self.streaktype == "support")
			{
				if(var_0B == "specialty_hardline")
				{
					continue;
				}
			}

			if(isai(self) && isdefined(var_04) && common_scripts\utility::array_contains(var_04,var_0B))
			{
				continue;
			}

			var_0D = level.perkcostsforgambler[var_05][var_06];
			var_08 = level.perkrowsforgambler[var_05][var_06];
			switch(var_0D)
			{
				case 1:
					var_03 = 150;
					break;

				case 2:
					var_03 = 40;
					break;

				case 3:
					var_03 = 60;
					break;

				case 4:
					var_03 = 20;
					break;

				case 5:
					var_03 = 20;
					break;

				default:
					break;
			}

			var_02[var_02.size] = addstruct();
			var_02[var_02.size - 1].row = var_08;
			var_02[var_02.size - 1].id = var_0B;
			var_02[var_02.size - 1].weight = var_03;
		}
	}

	self.perkpickedspecialist = undefined;
	if(var_02.size > 0)
	{
		thread func_3CEB(var_02);
	}
}

//Function Number: 128
gamblercommonchecker()
{
	if(!isai(self))
	{
		return self getcacplayerdata("loadouts",self.class_num,"abilitiesPicked",6,0);
	}
	else
	{
		var_00 = [];
		if(isdefined(self.pers["loadoutPerks"]))
		{
			var_00 = common_scripts\utility::array_combine(var_00,self.pers["loadoutPerks"]);
		}

		foreach(var_02 in var_00)
		{
			if(maps\mp\_utility::getbaseperkname(var_02) == "specialty_gambler")
			{
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 129
perkpickedchecker(param_00,param_01,param_02)
{
	self.perkpickedspecialist = 0;
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00 == "")
	{
		return 0;
	}

	if(!isai(self))
	{
		var_03 = maps\mp\gametypes\_class::getnumabilitycategories();
		var_04 = maps\mp\gametypes\_class::getnumsubability();
		if(self getcacplayerdata("loadouts",self.class_num,"abilitiesPicked",param_01,param_02))
		{
			return 1;
		}

		for(var_05 = 0;var_05 < 3;var_05++)
		{
			var_06 = self getcacplayerdata("loadouts",self.class_num,"specialistStreaks",var_05);
			if(isdefined(var_06) && var_06 != "none")
			{
				var_07 = maps\mp\_utility::getbaseperkname(var_06);
				if(var_07 == param_00)
				{
					self.perkpickedspecialist = 1;
					return 1;
				}
			}
		}

		var_08 = self getcacplayerdata("loadouts",self.class_num,"specialistBonusStreaks",param_01,param_02);
		if(isdefined(var_08) && var_08)
		{
			var_09 = level.perknamesforgambler[param_01][param_02];
			if(var_09 == param_00)
			{
				self.perkpickedspecialist = 1;
				return 1;
			}
		}
	}
	else
	{
		var_0A = [];
		if(isdefined(self.pers["loadoutPerks"]))
		{
			var_0A = common_scripts\utility::array_combine(var_0A,self.pers["loadoutPerks"]);
		}

		foreach(var_0C in var_0A)
		{
			if(maps\mp\_utility::getbaseperkname(var_0C) == param_00)
			{
				return 1;
			}
		}

		var_0A = [];
		if(isdefined(self.pers["specialistStreaks"]))
		{
			var_0A = common_scripts\utility::array_combine(var_0A,self.pers["specialistStreaks"]);
		}

		if(isdefined(self.pers["specialistBonusStreaks"]))
		{
			var_0A = common_scripts\utility::array_combine(var_0A,self.pers["specialistBonusStreaks"]);
		}

		foreach(var_0C in var_0A)
		{
			if(maps\mp\_utility::getbaseperkname(var_0C) == param_00)
			{
				self.perkpickedspecialist = 1;
				return 1;
			}
		}
	}

	return 0;
}

//Function Number: 130
func_3CEB(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetGambler");
	level endon("game_ended");
	if(!maps\mp\_utility::func_36F1("prematch_done"))
	{
		maps\mp\_utility::gameflagwait("prematch_done");
	}
	else if(maps\mp\_utility::func_36F1("prematch_done") && self.streaktype != "specialist")
	{
		self waittill("giveLoadout");
	}

	if(!isdefined(self.abilitychosen))
	{
		self.abilitychosen = 0;
	}

	if(!self.abilitychosen)
	{
		var_01 = getrandomability(param_00);
		self.gamblerability = var_01;
	}
	else
	{
		var_01 = self.gamblerability;
	}

	maps\mp\_utility::func_3CFB(var_01.id,0);
	if(var_01.id == "specialty_hardline")
	{
		maps\mp\killstreaks\_killstreaks::setstreakcounttonext();
	}

	if(showgambler())
	{
		self playlocalsound("mp_suitcase_pickup");
		self setclientomnvar("ui_gambler_show",var_01.row);
		thread gambleranimwatcher();
	}

	if(level.gametype != "infect")
	{
		self.abilitychosen = 1;
	}
}

//Function Number: 131
showgambler()
{
	var_00 = 1;
	if(!level.ingraceperiod && self.abilitychosen)
	{
		var_00 = 0;
	}

	if(!maps\mp\_utility::allowclasschoice() && level.gametype != "infect")
	{
		var_00 = 0;
	}

	return var_00;
}

//Function Number: 132
gambleranimwatcher()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetGambler");
	level endon("game_ended");
	self waittill("luinotifyserver",var_00,var_01);
	if(var_00 == "gambler_anim_complete")
	{
		self setclientomnvar("ui_gambler_show",-1);
	}
}

//Function Number: 133
getrandomability(param_00)
{
	var_01 = [];
	var_01 = thread func_76F7(param_00);
	var_01 = thread func_6FF3(var_01);
	var_02 = randomint(level.abilitymaxval["sum"]);
	var_03 = undefined;
	foreach(var_05 in var_01)
	{
		if(!var_05.weight || var_05.id == "specialty_gambler")
		{
			continue;
		}

		if(var_05.weight > var_02)
		{
			var_03 = var_05;
			break;
		}
	}

	return var_03;
}

//Function Number: 134
func_76F7(param_00)
{
	var_01 = [];
	var_02 = [];
	for(var_03 = 1;var_03 < param_00.size;var_03++)
	{
		var_04 = param_00[var_03].weight;
		var_01 = param_00[var_03];
		for(var_05 = var_03 - 1;var_05 >= 0 && func_485F(param_00[var_05].weight,var_04);var_05--)
		{
			var_02 = param_00[var_05];
			param_00[var_05] = var_01;
			param_00[var_05 + 1] = var_02;
		}
	}

	return param_00;
}

//Function Number: 135
func_485F(param_00,param_01)
{
	return param_00 < param_01;
}

//Function Number: 136
func_6FF3(param_00)
{
	level.abilitymaxval["sum"] = 0;
	foreach(var_02 in param_00)
	{
		if(!var_02.weight)
		{
			continue;
		}

		level.abilitymaxval["sum"] = level.abilitymaxval["sum"] + var_02.weight;
		var_02.weight = level.abilitymaxval["sum"];
	}

	return param_00;
}

//Function Number: 137
func_8622()
{
	self notify("unsetGambler");
}

//Function Number: 138
setcomexp()
{
	var_00 = level.comexpfuncs["giveComExpBenefits"];
	self [[ var_00 ]]();
}

//Function Number: 139
func_8613()
{
	var_00 = level.comexpfuncs["removeComExpBenefits"];
	self [[ var_00 ]]();
}

//Function Number: 140
func_70DB()
{
	thread func_70DC();
}

//Function Number: 141
func_70DC()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetTagger");
	level endon("game_ended");
	for(;;)
	{
		self waittill("eyesOn");
		var_00 = self getplayerssightingme();
		foreach(var_02 in var_00)
		{
			if(level.teambased && var_02.team == self.team)
			{
				continue;
			}

			if(isalive(var_02) && var_02.sessionstate == "playing")
			{
				if(!isdefined(var_02.perkoutlined))
				{
					var_02.perkoutlined = 0;
				}

				if(!var_02.perkoutlined)
				{
					var_02.perkoutlined = 1;
				}

				var_02 thread func_5A54(self);
			}
		}
	}
}

//Function Number: 142
func_5A54(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("eyesOff");
	level endon("game_ended");
	for(;;)
	{
		var_01 = 1;
		var_02 = param_00 getplayerssightingme();
		foreach(var_04 in var_02)
		{
			if(var_04 == self)
			{
				var_01 = 0;
				break;
			}
		}

		if(var_01)
		{
			self.perkoutlined = 0;
			self notify("eyesOff");
		}

		wait(0.5);
	}
}

//Function Number: 143
func_8647()
{
	self notify("unsetTagger");
}

//Function Number: 144
func_7095()
{
	thread func_7096();
}

//Function Number: 145
func_7096()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetPitcher");
	level endon("game_ended");
	maps\mp\_utility::_setperk("specialty_throwback",0);
	self setgrenadethrowscale(1.5);
	for(;;)
	{
		self loadcustomizationplayerview(1.25);
		self waittill("grenade_pullback",var_00);
		if(var_00 == "airdrop_marker_mp" || var_00 == "killstreak_uplink_mp" || var_00 == "deployable_vest_marker_mp" || var_00 == "deployable_weapon_crate_marker_mp" || var_00 == "airdrop_juggernaut_mp")
		{
			self loadcustomizationplayerview(1);
		}

		self waittill("grenade_fire",var_01,var_02);
	}
}

//Function Number: 146
func_8633()
{
	self setgrenadethrowscale(1);
	self loadcustomizationplayerview(1);
	maps\mp\_utility::_unsetperk("specialty_throwback");
	self notify("unsetPitcher");
}

//Function Number: 147
func_6FF1()
{
}

//Function Number: 148
func_6FF2(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetBoom");
	level endon("game_ended");
	param_00 endon("death");
	param_00 endon("disconnect");
	common_scripts\utility::func_8AFE();
	livestreamingsetbitrate(self.origin,param_00);
	param_00 boomtrackplayers(self.origin);
}

//Function Number: 149
boomtrackplayers(param_00)
{
	foreach(var_02 in level.players)
	{
		if(maps\mp\_utility::isenemy(var_02) && isalive(var_02) && !var_02 maps\mp\_utility::_hasperk("specialty_gpsjammer") && distancesquared(param_00,var_02.origin) <= 490000)
		{
			var_02.markedbyboomperk[maps\mp\_utility::getuniqueid()] = gettime() + 2000;
		}
	}
}

//Function Number: 150
func_860A()
{
	self notify("unsetBoom");
}

//Function Number: 151
func_70C7()
{
}

//Function Number: 152
func_8641()
{
}

//Function Number: 153
func_6FED()
{
	self.bloodrushregenspeedmod = 1;
	self.bloodrushregenhealthmod = 1;
}

//Function Number: 154
setbloodrushinternal()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetBloodrush");
	level endon("game_ended");
	if(!isdefined(self.isjuiced) || !self.isjuiced)
	{
		self.rushtime = 5;
		thread customjuiced(self.rushtime);
		self.bloodrushregenspeedmod = 0.25;
		self.bloodrushregenhealthmod = 5;
		self notify("bloodrush_active");
	}

	self waittill("unset_custom_juiced");
	func_8608();
}

//Function Number: 155
customjuiced(param_00)
{
	self endon("death");
	self endon("faux_spawn");
	self endon("disconnect");
	self endon("unset_custom_juiced");
	level endon("game_ended");
	self.isjuiced = 1;
	self.movespeedscaler = 1.1;
	maps\mp\gametypes\_weapons::func_8707();
	maps\mp\_utility::func_3CFB("specialty_fastreload",0);
	maps\mp\_utility::func_3CFB("specialty_quickdraw",0);
	maps\mp\_utility::func_3CFB("specialty_stalker",0);
	maps\mp\_utility::func_3CFB("specialty_fastoffhand",0);
	maps\mp\_utility::func_3CFB("specialty_fastsprintrecovery",0);
	maps\mp\_utility::func_3CFB("specialty_quickswap",0);
	thread func_8615();
	thread func_8617();
	thread func_8616();
	var_01 = param_00 * 1000 + gettime();
	if(!isai(self))
	{
		self setclientdvar("ui_juiced_end_milliseconds",var_01);
	}

	wait(param_00);
	func_8614();
}

//Function Number: 156
func_8614(param_00)
{
	if(!isdefined(param_00))
	{
		if(maps\mp\_utility::isjuggernaut())
		{
			if(isdefined(self.juggmovespeedscaler))
			{
				self.movespeedscaler = self.juggmovespeedscaler;
			}
			else
			{
				self.movespeedscaler = 0.7;
			}
		}
		else
		{
			self.movespeedscaler = 1;
			if(maps\mp\_utility::_hasperk("specialty_lightweight"))
			{
				self.movespeedscaler = maps\mp\_utility::func_4E12();
			}
		}

		maps\mp\gametypes\_weapons::func_8707();
	}

	maps\mp\_utility::_unsetperk("specialty_fastreload");
	maps\mp\_utility::_unsetperk("specialty_quickdraw");
	maps\mp\_utility::_unsetperk("specialty_stalker");
	maps\mp\_utility::_unsetperk("specialty_fastoffhand");
	maps\mp\_utility::_unsetperk("specialty_fastsprintrecovery");
	maps\mp\_utility::_unsetperk("specialty_quickswap");
	if(isdefined(self.pers["loadoutPerks"]))
	{
		maps\mp\perks\_abilities::func_3CFE(self.pers["loadoutPerks"]);
	}

	self.isjuiced = undefined;
	if(!isai(self))
	{
		self setclientdvar("ui_juiced_end_milliseconds",0);
	}

	self notify("unset_custom_juiced");
}

//Function Number: 157
func_8617()
{
	self endon("disconnect");
	self endon("unset_custom_juiced");
	for(;;)
	{
		wait(0.05);
		if(maps\mp\_utility::func_4995())
		{
			thread func_8614();
			break;
		}
	}
}

//Function Number: 158
func_8615()
{
	self endon("disconnect");
	self endon("unset_custom_juiced");
	common_scripts\utility::func_8B2A("death","faux_spawn");
	thread func_8614(1);
}

//Function Number: 159
func_8616()
{
	self endon("disconnect");
	self endon("unset_custom_juiced");
	level common_scripts\utility::func_8B2A("round_end_finished","game_ended");
	thread func_8614();
}

//Function Number: 160
regenspeedwatcher()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetBloodrush");
	level endon("game_ended");
	for(;;)
	{
		self waittill("bloodrush_active");
		self.regenspeed = self.bloodrushregenspeedmod;
		break;
	}
}

//Function Number: 161
func_8608()
{
	self.bloodrushregenspeedmod = 1;
	self.regenspeed = 1;
	self notify("unsetBloodrush");
}

//Function Number: 162
func_70E8()
{
}

//Function Number: 163
func_70E9()
{
	self endon("death");
	self endon("disconnect");
	self endon("unsetTriggerHappy");
	level endon("game_ended");
	var_00 = self.lastdroppableweapon;
	var_01 = self getweaponammostock(var_00);
	var_02 = self getweaponammoclip(var_00);
	self givestartammo(var_00);
	var_03 = self getweaponammoclip(var_00);
	var_04 = var_03 - var_02;
	var_05 = var_01 - var_04;
	if(var_04 > var_01)
	{
		self setweaponammoclip(var_00,var_02 + var_01);
		var_05 = 0;
	}

	self setweaponammostock(var_00,var_05);
	self playlocalsound("ammo_crate_use");
	self setclientomnvar("ui_trigger_happy",1);
	wait(0.2);
	self setclientomnvar("ui_trigger_happy",0);
}

//Function Number: 164
func_864A()
{
	self setclientomnvar("ui_trigger_happy",0);
	self notify("unsetTriggerHappy");
}

//Function Number: 165
func_7012()
{
	self.critchance = 10;
	self.deadeyekillcount = 0;
}

//Function Number: 166
func_7013()
{
	if(self.critchance < 50)
	{
		self.critchance = self.deadeyekillcount + 1 * 10;
	}
	else
	{
		self.critchance = 50;
	}

	var_00 = randomint(100);
	if(var_00 <= self.critchance)
	{
		maps\mp\_utility::func_3CFB("specialty_moredamage",0);
	}
}

//Function Number: 167
func_8618()
{
	if(maps\mp\_utility::_hasperk("specialty_moredamage"))
	{
		maps\mp\_utility::_unsetperk("specialty_moredamage");
	}
}

//Function Number: 168
func_7054()
{
}

//Function Number: 169
func_8626()
{
}

//Function Number: 170
func_6FEC()
{
}

//Function Number: 171
func_8607()
{
	maps\mp\_utility::_unsetperk("specialty_noplayertarget");
	self notify("removed_specialty_noplayertarget");
}

//Function Number: 172
func_70AC()
{
}

//Function Number: 173
func_8636()
{
	maps\mp\_utility::_unsetperk("specialty_fastoffhand");
}

//Function Number: 174
setextraammo()
{
	self endon("death");
	self endon("disconnect");
	self endon("unset_extraammo");
	level endon("game_ended");
	if(self.gettingloadout)
	{
		self waittill("giveLoadout");
	}

	var_00 = maps\mp\_utility::getvalidextraammoweapons();
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02) && var_02 != "none")
		{
			self givemaxammo(var_02);
		}
	}
}

//Function Number: 175
unsetextraammo()
{
	self notify("unset_extraammo");
}

//Function Number: 176
setextraequipment()
{
	self endon("death");
	self endon("disconnect");
	self endon("unset_extraequipment");
	level endon("game_ended");
	if(self.gettingloadout)
	{
		self waittill("giveLoadout");
	}

	var_00 = self.loadoutperkoffhand;
	if(isdefined(var_00) && var_00 != "specialty_null")
	{
		if(var_00 != "specialty_tacticalinsertion")
		{
			self setweaponammoclip(var_00,2);
		}
	}
}

//Function Number: 177
unsetextraequipment()
{
	self notify("unset_extraequipment");
}

//Function Number: 178
setextradeadly()
{
	self endon("death");
	self endon("disconnect");
	self endon("unset_extradeadly");
	level endon("game_ended");
	if(self.gettingloadout)
	{
		self waittill("giveLoadout");
	}

	var_00 = self.loadoutperkequipment;
	if(isdefined(var_00) && var_00 != "specialty_null")
	{
		self setweaponammoclip(var_00,2);
	}
}

//Function Number: 179
unsetextradeadly()
{
	self notify("unset_extradeadly");
}

//Function Number: 180
func_7031()
{
	maps\mp\_utility::func_3CFB("specialty_pistoldeath",0);
}

//Function Number: 181
func_861D()
{
	maps\mp\_utility::_unsetperk("specialty_pistoldeath");
}

//Function Number: 182
func_6FF6()
{
	thread maps\mp\killstreaks\_killstreaks::func_3CF2("airdrop_assault",0,0,self);
}

//Function Number: 183
func_860C()
{
}

//Function Number: 184
func_70EE()
{
	thread maps\mp\killstreaks\_killstreaks::func_3CF2("uav",0,0,self);
}

//Function Number: 185
func_864B()
{
}

//Function Number: 186
func_70D5()
{
	maps\mp\_utility::func_3CFB("specialty_bulletdamage",0);
	thread func_8D27();
}

//Function Number: 187
func_8D27()
{
	self notify("watchStoppingPowerKill");
	self endon("watchStoppingPowerKill");
	self endon("disconnect");
	level endon("game_ended");
	self waittill("killed_enemy");
	func_8644();
}

//Function Number: 188
func_8644()
{
	maps\mp\_utility::_unsetperk("specialty_bulletdamage");
	self notify("watchStoppingPowerKill");
}

//Function Number: 189
func_6FF4()
{
	if(!maps\mp\_utility::_hasperk("specialty_pistoldeath"))
	{
		maps\mp\_utility::func_3CFB("specialty_pistoldeath",0);
	}
}

//Function Number: 190
func_860B()
{
	if(maps\mp\_utility::_hasperk("specialty_pistoldeath"))
	{
		maps\mp\_utility::_unsetperk("specialty_pistoldeath");
	}
}

//Function Number: 191
func_705B(param_00)
{
	self endon("death");
	self endon("faux_spawn");
	self endon("disconnect");
	self endon("unset_juiced");
	level endon("game_ended");
	self.isjuiced = 1;
	self.movespeedscaler = 1.25;
	maps\mp\gametypes\_weapons::func_8707();
	maps\mp\_utility::func_3CFB("specialty_fastreload",0);
	maps\mp\_utility::func_3CFB("specialty_quickdraw",0);
	maps\mp\_utility::func_3CFB("specialty_stalker",0);
	maps\mp\_utility::func_3CFB("specialty_fastoffhand",0);
	maps\mp\_utility::func_3CFB("specialty_fastsprintrecovery",0);
	maps\mp\_utility::func_3CFB("specialty_quickswap",0);
	thread func_8628();
	thread func_862A();
	thread func_8629();
	if(!isdefined(param_00))
	{
		param_00 = 10;
	}

	var_01 = param_00 * 1000 + gettime();
	if(!isai(self))
	{
		self setclientdvar("ui_juiced_end_milliseconds",var_01);
	}

	wait(param_00);
	func_8627();
}

//Function Number: 192
func_8627(param_00)
{
	if(!isdefined(param_00))
	{
		if(!maps\mp\_utility::func_47BB())
		{
		}

		if(maps\mp\_utility::isjuggernaut())
		{
			if(isdefined(self.juggmovespeedscaler))
			{
				self.movespeedscaler = self.juggmovespeedscaler;
			}
			else
			{
				self.movespeedscaler = 0.7;
			}
		}
		else
		{
			self.movespeedscaler = 1;
			if(maps\mp\_utility::_hasperk("specialty_lightweight"))
			{
				self.movespeedscaler = maps\mp\_utility::func_4E12();
			}
		}

		maps\mp\gametypes\_weapons::func_8707();
	}

	maps\mp\_utility::_unsetperk("specialty_fastreload");
	maps\mp\_utility::_unsetperk("specialty_quickdraw");
	maps\mp\_utility::_unsetperk("specialty_stalker");
	maps\mp\_utility::_unsetperk("specialty_fastoffhand");
	maps\mp\_utility::_unsetperk("specialty_fastsprintrecovery");
	maps\mp\_utility::_unsetperk("specialty_quickswap");
	if(isdefined(self.pers["loadoutPerks"]))
	{
		maps\mp\perks\_abilities::func_3CFE(self.pers["loadoutPerks"]);
	}

	self.isjuiced = undefined;
	if(!isai(self))
	{
		self setclientdvar("ui_juiced_end_milliseconds",0);
	}

	self notify("unset_juiced");
}

//Function Number: 193
func_862A()
{
	self endon("disconnect");
	self endon("unset_juiced");
	for(;;)
	{
		wait(0.05);
		if(maps\mp\_utility::func_4995())
		{
			thread func_8627();
			break;
		}
	}
}

//Function Number: 194
func_8628()
{
	self endon("disconnect");
	self endon("unset_juiced");
	common_scripts\utility::func_8B2A("death","faux_spawn");
	thread func_8627(1);
}

//Function Number: 195
func_8629()
{
	self endon("disconnect");
	self endon("unset_juiced");
	level common_scripts\utility::func_8B2A("round_end_finished","game_ended");
	thread func_8627();
}

//Function Number: 196
func_4016()
{
	return isdefined(self.isjuiced);
}

//Function Number: 197
func_7005()
{
	self endon("death");
	self endon("disconnect");
	self endon("unset_combathigh");
	level endon("end_game");
	self.damageblockedtotal = 0;
	if(level.splitscreen)
	{
		var_00 = 56;
		var_01 = 21;
	}
	else
	{
		var_00 = 112;
		var_01 = 32;
	}

	if(isdefined(self.juicedtimer))
	{
		self.juicedtimer destroy();
	}

	if(isdefined(self.juicedicon))
	{
		self.juicedicon destroy();
	}

	self.combathighoverlay = newclienthudelem(self);
	self.combathighoverlay.x = 0;
	self.combathighoverlay.y = 0;
	self.combathighoverlay.alignx = "left";
	self.combathighoverlay.aligny = "top";
	self.combathighoverlay.horzalign = "fullscreen";
	self.combathighoverlay.vertalign = "fullscreen";
	self.combathighoverlay setmaterial("combathigh_overlay",640,480);
	self.combathighoverlay.sort = -10;
	self.combathighoverlay.archived = 1;
	self.combathightimer = maps\mp\gametypes\_hud_util::createtimer("hudsmall",1);
	self.combathightimer maps\mp\gametypes\_hud_util::func_70A4("CENTER","CENTER",0,var_00);
	self.combathightimer settimer(10);
	self.combathightimer.color = (0.8,0.8,0);
	self.combathightimer.archived = 0;
	self.combathightimer.foreground = 1;
	self.combathighicon = maps\mp\gametypes\_hud_util::func_20FC("specialty_painkiller",var_01,var_01);
	self.combathighicon.alpha = 0;
	self.combathighicon maps\mp\gametypes\_hud_util::func_708F(self.combathightimer);
	self.combathighicon maps\mp\gametypes\_hud_util::func_70A4("BOTTOM","TOP");
	self.combathighicon.archived = 1;
	self.combathighicon.sort = 1;
	self.combathighicon.foreground = 1;
	self.combathighoverlay.alpha = 0;
	self.combathighoverlay fadeovertime(1);
	self.combathighicon fadeovertime(1);
	self.combathighoverlay.alpha = 1;
	self.combathighicon.alpha = 0.85;
	thread func_860F();
	thread func_8610();
	wait(8);
	self.combathighicon fadeovertime(2);
	self.combathighicon.alpha = 0;
	self.combathighoverlay fadeovertime(2);
	self.combathighoverlay.alpha = 0;
	self.combathightimer fadeovertime(2);
	self.combathightimer.alpha = 0;
	wait(2);
	self.damageblockedtotal = undefined;
	maps\mp\_utility::_unsetperk("specialty_combathigh");
}

//Function Number: 198
func_860F()
{
	self endon("disconnect");
	self endon("unset_combathigh");
	self waittill("death");
	thread maps\mp\_utility::_unsetperk("specialty_combathigh");
}

//Function Number: 199
func_8610()
{
	self endon("disconnect");
	self endon("unset_combathigh");
	for(;;)
	{
		wait(0.05);
		if(maps\mp\_utility::func_4995())
		{
			thread maps\mp\_utility::_unsetperk("specialty_combathigh");
			break;
		}
	}
}

//Function Number: 200
func_860E()
{
	self notify("unset_combathigh");
	self.combathighoverlay destroy();
	self.combathighicon destroy();
	self.combathightimer destroy();
}

//Function Number: 201
func_7063(param_00)
{
	self notify("give_light_armor");
	if(isdefined(self.lightarmorhp))
	{
		unsetlightarmor();
	}

	thread func_659C();
	thread func_659D();
	self.lightarmorhp = 150;
	if(isdefined(param_00))
	{
		self.lightarmorhp = param_00;
	}

	if(isplayer(self))
	{
		self setclientomnvar("ui_light_armor",1);
		maps\mp\_utility::_setnameplatematerial("player_name_bg_green_vest","player_name_bg_red_vest");
	}
}

//Function Number: 202
func_659C()
{
	self endon("disconnect");
	self endon("give_light_armor");
	self endon("remove_light_armor");
	self waittill("death");
	unsetlightarmor();
}

//Function Number: 203
unsetlightarmor()
{
	self.lightarmorhp = undefined;
	if(isplayer(self))
	{
		self setclientomnvar("ui_light_armor",0);
		maps\mp\_utility::_restorepreviousnameplatematerial();
	}

	self notify("remove_light_armor");
}

//Function Number: 204
func_659D()
{
	self endon("disconnect");
	self endon("remove_light_armor");
	level common_scripts\utility::func_8B2A("round_end_finished","game_ended");
	thread unsetlightarmor();
}

//Function Number: 205
haslightarmor()
{
	return isdefined(self.lightarmorhp) && self.lightarmorhp > 0;
}

//Function Number: 206
func_400D(param_00)
{
	return isdefined(param_00.heavyarmorhp) && param_00.heavyarmorhp > 0;
}

//Function Number: 207
func_704B(param_00)
{
	if(isdefined(param_00))
	{
		self.heavyarmorhp = param_00;
	}
}

//Function Number: 208
func_70B6()
{
	self notify("stopRevenge");
	wait(0.05);
	if(!isdefined(self.lastkilledby))
	{
	}

	if(level.teambased && self.team == self.lastkilledby.team)
	{
	}

	var_00 = addstruct();
	var_00.showto = self;
	var_00.icon = "compassping_revenge";
	var_00.offset = (0,0,64);
	var_00.width = 10;
	var_00.height = 10;
	var_00.archived = 0;
	var_00.delay = 1.5;
	var_00.constantsize = 0;
	var_00.pintoscreenedge = 1;
	var_00.fadeoutpinnedicon = 0;
	var_00.is3d = 0;
	self.revengeparams = var_00;
	self.lastkilledby maps\mp\_entityheadicons::setheadicon(var_00.showto,var_00.icon,var_00.offset,var_00.width,var_00.height,var_00.archived,var_00.delay,var_00.constantsize,var_00.pintoscreenedge,var_00.fadeoutpinnedicon,var_00.is3d);
	thread func_8D15();
	thread func_8D17();
	thread func_8D16();
	thread func_8D18();
	thread watchstoprevenge();
}

//Function Number: 209
func_8D15()
{
	self endon("stopRevenge");
	self endon("disconnect");
	var_00 = self.lastkilledby;
	for(;;)
	{
		var_00 waittill("spawned_player");
		var_00 maps\mp\_entityheadicons::setheadicon(self.revengeparams.showto,self.revengeparams.icon,self.revengeparams.offset,self.revengeparams.width,self.revengeparams.height,self.revengeparams.archived,self.revengeparams.delay,self.revengeparams.constantsize,self.revengeparams.pintoscreenedge,self.revengeparams.fadeoutpinnedicon,self.revengeparams.is3d);
	}
}

//Function Number: 210
func_8D17()
{
	self endon("stopRevenge");
	self waittill("killed_enemy");
	self notify("stopRevenge");
}

//Function Number: 211
func_8D16()
{
	self endon("stopRevenge");
	self.lastkilledby waittill("disconnect");
	self notify("stopRevenge");
}

//Function Number: 212
watchstoprevenge()
{
	var_00 = self.lastkilledby;
	self waittill("stopRevenge");
	if(!isdefined(var_00))
	{
	}

	foreach(var_02 in var_00.entityheadicons)
	{
		if(!isdefined(var_02))
		{
			continue;
		}

		var_02 destroy();
	}
}

//Function Number: 213
func_8D18()
{
	var_00 = self.objidfriendly;
	var_01 = self.lastkilledby;
	var_01 endon("disconnect");
	level endon("game_ended");
	self endon("stopRevenge");
	self waittill("disconnect");
	if(!isdefined(var_01))
	{
	}

	foreach(var_03 in var_01.entityheadicons)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		var_03 destroy();
	}
}

//Function Number: 214
func_863B()
{
	self notify("stopRevenge");
}