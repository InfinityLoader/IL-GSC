/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\prop.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 106
 * Decompile Time: 1853 ms
 * Timestamp: 10/27/2023 3:11:34 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	if(getdvar("1673") == "mp_background")
	{
		return;
	}

	maps\mp\gametypes\_globallogic::func_D5();
	lib_01DD::func_8A0C();
	maps\mp\gametypes\_globallogic::func_8A0C();
	if(isusingmatchrulesdata())
	{
		level.var_5300 = ::func_5300;
		[[ level.var_5300 ]]();
		level thread maps\mp\_utility::func_7C13();
	}
	else
	{
		maps\mp\_utility::func_7BF8(level.var_3FDC,1,0,9);
		maps\mp\_utility::func_7BFA(level.var_3FDC,4);
		maps\mp\_utility::func_7BF9(level.var_3FDC,0);
		maps\mp\_utility::func_7BF7(level.var_3FDC,4);
		maps\mp\_utility::func_7C04(level.var_3FDC,3);
		maps\mp\_utility::func_7BF1(level.var_3FDC,1);
		maps\mp\_utility::func_7BE5(level.var_3FDC,0);
		level.phsettings = spawnstruct();
		level.phsettings.prophidetime = 30;
		level.phsettings.propwhistletime = 30;
		level.phsettings.propchangecount = 2;
		level.phsettings.propnumflashes = 1;
		level.phsettings.propnumclones = 3;
		level.phsettings.propspeedscale = 1.4;
		level.phsettings.allowloadouts = 0;
		setdynamicdvar("scr_player_healthregentime",0);
		level.var_6031 = 0;
		level.var_6035 = 0;
	}

	level.isprophunt = 1;
	level.var_6933 = 1;
	level.blockteamchange = 0;
	level.var_C25 = 1;
	level.startcheck = 0;
	level.var_5A74 = 1;
	level.var_5A6F = 0;
	maps\mp\_utility::func_873B(1);
	level.var_6BAF = ::func_6BAF;
	level.var_6B5C = ::func_6B5C;
	level.var_6BB2 = ::func_6BB2;
	level.var_6BA7 = ::func_6BA7;
	level.var_6B5E = ::func_6B5E;
	level.var_6BB6 = ::func_6BB6;
	level.var_6B7B = ::func_6B7B;
	level.var_6AE2 = ::func_6AE2;
	level.checkforovertime = ::ph_checkforovertime;
	level.var_297F = ::playdamagesoundph;
	level.var_2980 = ::playdeathsoundph;
	level.var_62AD = ::func_3FC8;
	level.var_1DEA = ::phclass;
	level.var_3FDD = ::applyprophuntperks;
	level.getgamewinnerfunc = ::getgamewinnerprop;
	level.gametyperoundendscoresetomnvar = ::gametyperoundendscoresetomnvar;
	level.checkunscoredspawnpoint = ::checkunscoredspawnpoint;
	level.gametypemovespeedscalefunc = ::propmovespeedscale;
	level.var_2FA0 = ::disablespawningforplayer;
	level.var_2FAB = 1;
	level.disabledivisionstats = 1;
	level.var_2F8B = 1;
	level.disableallplayerstats = 1;
	level.disableweaponchallenges = 1;
	level.disabledivisionchallenges = 1;
	level.disablewinlossstats = 1;
	level thread removeairbornedivisionsuppressorability();
	if(level.var_6031 || level.var_6035)
	{
		level.var_62AD = ::maps\mp\gametypes\_damage::func_3FC8;
	}

	level.proplist = [];
	level.propindex = [];
	level.spawnproplist = [];
	level.var_83B = ["FLASH","CLONE"];
	populateproplist();
	if(getdvarint("2043"))
	{
		game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
	}

	game["dialog"]["defense_obj"] = "gbl_start";
	game["dialog"]["offense_obj"] = "gbl_start";
	level.var_483A = int(level.phsettings.prophidetime + 0.5);
	level thread func_6B6C();
	level thread overridecountdownmusic();
}

//Function Number: 2
overridecountdownmusic()
{
	while(!isdefined(game["music"]) || !isdefined(game["music"]["match_ending_soon"]))
	{
		wait 0.05;
	}

	game["music"]["match_ending_soon"] = "prop_countdown";
}

//Function Number: 3
removeairbornedivisionsuppressorability()
{
	for(;;)
	{
		var_00 = maps\mp\gametypes\_divisions::func_44A1(1,"airborne") != "skill_level0";
		var_01 = maps\mp\gametypes\_divisions::func_44A1(1,"airborne") != "skill_level0";
		var_02 = maps\mp\gametypes\_divisions::func_44A1(1,"airborne") != "skill_level0";
		if(var_00 && var_01 && var_02)
		{
			break;
		}

		wait 0.05;
	}

	maps\mp\gametypes\_divisions::removedivisionprogressionskillunlock(1,"airborne");
	maps\mp\gametypes\_divisions::removedivisionprogressionskillunlock(1,"airborne");
	maps\mp\gametypes\_divisions::removedivisionprogressionskillunlock(1,"airborne");
}

//Function Number: 4
func_6B6C()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread attackerswaittime();
		var_00 thread playerwatchspectate();
		if(!isdefined(var_00.var_12C["propSeconds"]))
		{
			var_00.var_12C["propSeconds"] = 0;
		}

		var_00 maps\mp\_utility::func_867B(var_00.var_12C["propSeconds"]);
	}
}

//Function Number: 5
func_1786()
{
}

//Function Number: 6
propmovespeedscale()
{
	if(self.var_1A7 == game["defenders"])
	{
		return level.phsettings.propspeedscale;
	}

	return 1;
}

//Function Number: 7
func_5300()
{
	maps\mp\_utility::func_8653();
	setdynamicdvar("scr_prop_roundswitch",1);
	maps\mp\_utility::func_7BF8("prop",1,0,9);
	var_00 = getmatchrulesdata("commonOption","scoreLimit");
	setdynamicdvar("scr_prop_roundlimit",var_00);
	maps\mp\_utility::func_7BF7("prop",var_00);
	var_01 = int(var_00 / 2 + 1);
	if(var_00 == 0)
	{
		var_01 = 0;
	}

	setdynamicdvar("scr_prop_winlimit",var_01);
	maps\mp\_utility::func_7C04("prop",var_01);
	setdynamicdvar("scr_prop_halftime",0);
	maps\mp\_utility::func_7BE5("prop",0);
	setdynamicdvar("scr_prop_scorelimit",0);
	maps\mp\_utility::func_7BF9("scorelimit",0);
	level.phsettings = spawnstruct();
	level.phsettings.prophidetime = getmatchrulesdata("propData","propHideTime");
	level.phsettings.propwhistletime = getmatchrulesdata("propData","propWhistleTime");
	level.phsettings.propchangecount = getmatchrulesdata("propData","numChanges");
	level.phsettings.propnumflashes = getmatchrulesdata("propData","numFlashes");
	level.phsettings.propnumclones = getmatchrulesdata("propData","numClones");
	level.phsettings.propspeedscale = getmatchrulesdata("propData","propSpeedScale");
	level.phsettings.allowloadouts = getmatchrulesdata("propData","allowLoadouts") > 0;
}

//Function Number: 8
func_6BAF()
{
	if([[ level.checkforovertime ]]())
	{
		game["status"] = "overtime";
		setdvar("ui_overtime",1);
		setdvar("overtimeTimeLimit",3.5);
	}

	if(!isdefined(game["switchedsides"]))
	{
		game["switchedsides"] = 0;
	}

	if(game["switchedsides"])
	{
		var_00 = game["attackers"];
		var_01 = game["defenders"];
		game["attackers"] = var_01;
		game["defenders"] = var_00;
	}
	else
	{
		level.var_7691 = 30;
	}

	func_872E();
	setclientnamemode("manual_change");
	maps\mp\_utility::func_86DC(game["attackers"],&"OBJECTIVES_PH_ATTACKER");
	maps\mp\_utility::func_86DC(game["defenders"],&"OBJECTIVES_PH_DEFENDER");
	maps\mp\_utility::func_86DB(game["attackers"],&"OBJECTIVES_PH_ATTACKER_SCORE");
	maps\mp\_utility::func_86DB(game["defenders"],&"OBJECTIVES_PH_DEFENDER_SCORE");
	maps\mp\_utility::func_86D8(game["attackers"],&"OBJECTIVES_PH_ATTACKER_HINT");
	maps\mp\_utility::func_86D8(game["defenders"],&"OBJECTIVES_PH_DEFENDER_HINT");
	var_02 = game["roundsPlayed"] % 4 == 2 || game["roundsPlayed"] % 4 == 3;
	if(var_02)
	{
		game["switchedsides"] = !game["switchedsides"];
		lib_050D::func_10E4();
		game["switchedsides"] = !game["switchedsides"];
	}
	else
	{
		lib_050D::func_10E4();
	}

	var_03[0] = level.var_3FDC;
	maps\mp\gametypes\_gameobjects::func_F9(var_03);
	level.var_611["propFlash"] = loadfx("vfx/explosion/stun");
	level.var_611["propDeathFX"] = loadfx("vfx/explosion/prop_explosion");
	if(!isdefined(game["propScore"]))
	{
		game["propScore"] = [];
		game["propScore"]["allies"] = 0;
		game["propScore"]["axis"] = 0;
	}

	if(!isdefined(game["propSurvivalTime"]))
	{
		game["propSurvivalTime"] = [];
		game["propSurvivalTime"]["allies"] = 0;
		game["propSurvivalTime"]["axis"] = 0;
	}

	if(!isdefined(game["hunterKillTime"]))
	{
		game["hunterKillTime"] = [];
		game["hunterKillTime"]["allies"] = 0;
		game["hunterKillTime"]["axis"] = 0;
	}

	maps\mp\_utility::func_3FA3("props_hide_over",0);
	level thread setuproundstarthud();
	if(level.phsettings.propwhistletime > 0)
	{
		level thread propwhistle();
	}

	level thread propspectating();
	level thread maps/mp/gametypes/_prop_controls::hidehudintermission();
	level thread monitortimers();
	level thread deleteallglass();
	level thread setphteamscores();
	level thread stillalivexp();
	level thread tracktimealive();
}

//Function Number: 9
func_6B5C(param_00,param_01,param_02)
{
	propgiveteamscore(param_01.var_12C["team"]);
	if(game["state"] == "postgame" && game["teamScores"][param_01.var_1A7] > game["teamScores"][level.var_6C63[param_01.var_1A7]])
	{
		param_01.var_3B4B = 1;
	}
}

//Function Number: 10
func_6BB2(param_00)
{
	if(param_00 maps\mp\gametypes\_playerlogic::func_60B2())
	{
		return;
	}

	var_01 = maps\mp\_utility::func_45DE(param_00.var_12C["team"]);
	propgiveteamscore(var_01);
}

//Function Number: 11
propgiveteamscore(param_00)
{
	if(param_00 != game["attackers"])
	{
		return;
	}

	level maps\mp\gametypes\_gamescore::func_47BD(param_00,1,1);
	game["propScore"][param_00] = game["propScore"][param_00] + 1;
}

//Function Number: 12
getgamewinnerprop(param_00,param_01)
{
	if(!isstring(param_00))
	{
		return param_00;
	}

	var_02 = param_00;
	if(level.var_3F9D)
	{
		var_03 = "roundsWon";
		if(isdefined(level.var_AA24) && level.var_AA24)
		{
			var_03 = "teamScores";
		}

		level.proptiebreaker = "none";
		if(game[var_03]["allies"] == game[var_03]["axis"])
		{
			level.proptiebreaker = "kills";
			if(game["propScore"]["axis"] == game["propScore"]["allies"])
			{
				level.proptiebreaker = "time";
				if(game["hunterKillTime"]["axis"] == game["hunterKillTime"]["allies"])
				{
					level.proptiebreaker = "tie";
					var_02 = "tie";
				}
				else if(game["hunterKillTime"]["axis"] < game["hunterKillTime"]["allies"])
				{
					var_02 = "axis";
				}
				else
				{
					var_02 = "allies";
				}
			}
			else if(game["propScore"]["axis"] > game["propScore"]["allies"])
			{
				var_02 = "axis";
			}
			else
			{
				var_02 = "allies";
			}

			if(var_02 != "tie")
			{
				level thread givephteamscore(var_02);
			}
		}
		else if(game[var_03]["axis"] > game[var_03]["allies"])
		{
			var_02 = "axis";
		}
		else
		{
			var_02 = "allies";
		}
	}

	if(param_01 && var_02 == "allies" || var_02 == "axis")
	{
		ph_setfinalkillcamwinner(var_02);
	}

	return var_02;
}

//Function Number: 13
func_872E()
{
	var_00 = game["defenders"];
	level.ph_loadouts[var_00] = maps\mp\gametypes\_class::func_44B4();
	level.ph_loadouts[var_00]["loadoutDivision"] = 1;
	level.ph_loadouts[var_00]["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::func_473C(17125376,0);
	level.ph_loadouts[var_00]["ignoreMeleeSlotWeapon"] = 1;
	var_01 = game["attackers"];
	level.ph_loadouts[var_01] = maps\mp\gametypes\_class::func_44B4();
	level.ph_loadouts[var_01]["loadoutDivision"] = 1;
	level.ph_loadouts[var_01]["loadoutSecondaryWeaponStruct"] = maps\mp\_utility::func_473C(16859136,0);
	level.ph_loadouts[var_01]["loadoutPrimaryWeaponStruct"] = maps\mp\_utility::func_473C(16953344,0);
	level.ph_loadouts[var_01]["loadoutPrimaryAttachmentsGUID"][0] = 50331888;
	level.ph_loadouts[var_01]["loadoutPrimaryAttachmentsGUID"][1] = 50332528;
	level.ph_loadouts[var_01]["loadoutOffhandStruct"] = maps\mp\_utility::func_473C(16785408,0);
	level.ph_loadouts[var_01]["ignoreMeleeSlotWeapon"] = 1;
}

//Function Number: 14
phclass()
{
	self.var_12C["class"] = "gamemode";
	self.var_12C["lastClass"] = "";
	self.var_12C["gamemodeLoadout"] = level.ph_loadouts[self.var_12C["team"]];
	self.var_2319 = self.var_12C["class"];
	self.var_5B84 = self.var_12C["lastClass"];
}

//Function Number: 15
applyprophuntperks()
{
	if(self.var_1A7 == game["attackers"])
	{
		maps\mp\_utility::func_47A2("specialty_extratactical");
		maps\mp\_utility::func_47A2("specialty_lightweight");
		maps\mp\_utility::func_47A2("specialty_fastclimb");
		maps\mp\_utility::func_47A2("specialty_fastmantle");
		maps\mp\_utility::func_47A2("specialty_longersprint");
		return;
	}

	if(self.var_1A7 == game["defenders"])
	{
		maps\mp\_utility::func_47A2("specialty_quieter");
		maps\mp\_utility::func_47A2("specialty_fastclimb");
		maps\mp\_utility::func_47A2("specialty_fastmantle");
	}
}

//Function Number: 16
propspectating()
{
	level endon("game_ended");
	maps\mp\gametypes\_spectating::func_A16A();
}

//Function Number: 17
addupperrighthudelem(param_00,param_01,param_02,param_03)
{
	var_04 = maps\mp\gametypes\_hud_util::func_27ED("default",0.9);
	var_04.maxsightdistsqrd = -15;
	var_04.var_1D7 = self.currenthudy;
	var_04.accuracy = "right";
	var_04.var_11 = "top";
	var_04.var_C6 = "right_adjustable";
	var_04.var_1CA = "top_adjustable";
	var_04.var_1F = 1;
	var_04.var_9B = 1;
	var_04.var_18 = 1;
	var_04.var_AA = 0;
	var_04.var_C2 = 0;
	if(isdefined(param_00) && isdefined(param_03))
	{
		if(common_scripts\utility::func_55E0())
		{
			var_04.var_E5 = param_00;
		}
		else
		{
			var_04.var_E5 = param_03;
		}
	}
	else if(isdefined(param_00))
	{
		var_04.var_E5 = param_00;
	}
	else if(isdefined(param_02))
	{
		var_04 settext(param_02);
	}

	if(isdefined(param_01))
	{
		var_04 setvalue(0);
	}

	self.currenthudy = self.currenthudy + 18;
	return var_04;
}

//Function Number: 18
whistlestarttimer(param_00)
{
	level notify("whistle_start_timer_beginning");
	var_01 = int(param_00);
	if(var_01 >= 0)
	{
		thread whistlestarttimer_internal(var_01);
	}
}

//Function Number: 19
whistlestarttimer_internal(param_00)
{
	level endon("whistle_start_timer_beginning");
	waittillframeend;
	while(param_00 > 0 && !level.var_3F9D)
	{
		setomnvar("ui_ph_whistle_countdown",param_00);
		param_00--;
		wait(1);
	}

	setomnvar("ui_ph_whistle_countdown",param_00);
}

//Function Number: 20
useprophudserver()
{
	return 0;
}

//Function Number: 21
setuproundstarthud()
{
	function_0226(&"ui_init_round",0);
	level.phcountdowntimer = maps\mp\gametypes\_hud_util::func_282B("default",1.4);
	level.phcountdowntimer maps\mp\gametypes\_hud_util::func_8707("CENTER",undefined,0,50);
	level.phcountdowntimer.var_E5 = &"MP_PH_STARTS_IN";
	level.phcountdowntimer.var_18 = 0;
	level.phcountdowntimer.var_1F = 0;
	level.phcountdowntimer.var_C2 = 1;
	level.phcountdowntimer.ignoreme = 1;
	if(useprophudserver())
	{
		level.phwhistletimer = maps\mp\gametypes\_hud_util::func_282B("default",0.9);
		level.phwhistletimer.maxsightdistsqrd = -6;
		level.phwhistletimer.var_1D7 = 2;
		level.phwhistletimer.accuracy = "right";
		level.phwhistletimer.var_11 = "top";
		level.phwhistletimer.var_C6 = "right_adjustable";
		level.phwhistletimer.var_1CA = "top_adjustable";
		level.phwhistletimer.var_E5 = &"MP_PH_WHISTLE_IN";
		level.phwhistletimer.var_18 = 0;
		level.phwhistletimer.var_1F = 0;
		level.phwhistletimer.var_C2 = 1;
		level.phwhistletimer settimer(120);
	}

	whistlestarttimer(120);
	if(useprophudserver())
	{
		level.whistling = maps\mp\gametypes\_hud_util::func_2829("default",1);
		level.whistling.var_E5 = &"MP_PH_WHISTLING";
		level.whistling.maxsightdistsqrd = -5;
		level.whistling.var_1D7 = 2;
		level.whistling.accuracy = "right";
		level.whistling.var_11 = "top";
		level.whistling.var_C6 = "right_adjustable";
		level.whistling.var_1CA = "top_adjustable";
		level.whistling.var_1F = 1;
		level.whistling.var_18 = 0;
		level.whistling.var_AA = 0.2;
		level.whistling.var_C2 = 0;
	}

	if(useprophudserver())
	{
		if(!isdefined(level.elim_hud))
		{
			level.elim_hud = [];
		}

		level.elim_hud = maps\mp\gametypes\_hud_util::func_2829("default",0.9);
		level.elim_hud.var_E5 = &"MP_PH_ALIVE";
		level.elim_hud setvalue(0);
		level.elim_hud.maxsightdistsqrd = -5;
		level.elim_hud.var_1D7 = 14;
		level.elim_hud.accuracy = "right";
		level.elim_hud.var_11 = "top";
		level.elim_hud.var_C6 = "right_adjustable";
		level.elim_hud.var_1CA = "top_adjustable";
		level.elim_hud.var_1F = 1;
		level.elim_hud.var_9B = 1;
		level.elim_hud.var_18 = 1;
		level.elim_hud.var_AA = 0;
		level.elim_hud.var_C2 = 0;
		level thread eliminatedhudmonitor();
	}
}

//Function Number: 22
eliminatedhudmonitor()
{
	level endon("game_ended");
	for(;;)
	{
		var_00 = get_alive_nonspecating_players(game["defenders"]);
		level.elim_hud setvalue(var_00.size);
		level common_scripts\utility::knock_off_battery("player_spawned","player_killed","player_eliminated","playerCountChanged","propCountChanged");
	}
}

//Function Number: 23
get_alive_nonspecating_players(param_00)
{
	var_01 = [];
	foreach(var_03 in level.var_744A)
	{
		if(isdefined(var_03) && isalive(var_03) && !isdefined(var_03.var_178) || var_03.var_178 == "playing")
		{
			if(!isdefined(param_00) || var_03.var_1A7 == param_00)
			{
				var_01[var_01.size] = var_03;
			}
		}
	}

	return var_01;
}

//Function Number: 24
kickplayer(param_00,param_01)
{
	if(isbot(param_00))
	{
		return;
	}

	kick(param_00 getentitynumber(),param_01);
}

//Function Number: 25
weaponusagecheck()
{
	var_00 = common_scripts\utility::func_A715("weapon_fired","sprint_begin","specialGrenade","end_weapon_check_usage");
	if(var_00 == "end_weapon_check_usage")
	{
		if(common_scripts\utility::func_562E(self.hashitplayer))
		{
			return 1;
		}

		kickplayer(self,"EXE_PLAYERKICKED_INACTIVE");
		return 0;
	}

	return 1;
}

//Function Number: 26
positioncheck(param_00,param_01)
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	if(!isdefined(param_00))
	{
		param_00 = 45;
	}

	if(!isdefined(param_01))
	{
		param_01 = 300;
	}

	var_02 = self.var_116;
	var_03 = squared(param_01);
	var_04 = 0;
	for(var_05 = 0;var_05 < param_00;var_05++)
	{
		if(!var_04)
		{
			var_06 = distancesquared(var_02,self.var_116);
			if(var_06 >= var_03)
			{
				var_04 = 1;
			}
		}

		maps\mp\gametypes\_hostmigration::func_A6F5(1);
	}

	if(var_04)
	{
		return 1;
	}

	return 0;
}

//Function Number: 27
startcheck()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self.doingcheck = 1;
	maps\mp\_utility::func_3FA5("prematch_done");
	while(!level.startcheck)
	{
		wait(1);
	}

	childthread weaponusagecheck();
	if(!positioncheck(45,300))
	{
		if(common_scripts\utility::func_562E(self.hashitplayer))
		{
			return;
		}

		kickplayer(self,"EXE_PLAYERKICKED_INACTIVE");
		return;
	}

	if(!positioncheck(75,150))
	{
		if(common_scripts\utility::func_562E(self.hashitplayer))
		{
			return;
		}

		kickplayer(self,"EXE_PLAYERKICKED_INACTIVE");
		return;
	}

	maps\mp\gametypes\_hostmigration::func_A6F5(30);
	self notify("end_weapon_check_usage");
}

//Function Number: 28
func_6BA7()
{
	self.var_1BC1 = 0;
	self.abilityleft = 0;
	self.clonesleft = 0;
	setomnvar("ui_war_attacker_team",maps\mp\_utility::func_46D4(game["attackers"]));
	self luinotifyevent(&"ui_player_spawned",0);
	self setclientomnvar("ui_disable_team_change",1);
	if(self.var_1A7 == game["defenders"])
	{
		if(!isdefined(self.var_12C["ability"]))
		{
			self.var_12C["ability"] = 0;
		}

		self.currentability = level.var_83B[self.var_12C["ability"]];
		if(useprophudserver())
		{
			thread maps/mp/gametypes/_prop_controls::propcontrolshud();
		}

		self.isangleoffset = 0;
		maps/mp/gametypes/_prop_controls::propsetchangesleft(int(level.phsettings.propchangecount));
		maps/mp/gametypes/_prop_controls::setnewabilitycount(self.currentability);
		maps/mp/gametypes/_prop_controls::setnewabilitycount("CLONE");
		thread maps/mp/gametypes/_prop_controls::cleanuppropcontrolshudondeath();
		thread handleprop();
		return;
	}

	if(!isdefined(self.thrownspecialcount))
	{
		self.thrownspecialcount = 0;
	}

	thread givecustomloadout();
	var_00 = 1;
	if(var_00 && !isdefined(self.doingcheck))
	{
		thread startcheck();
	}
}

//Function Number: 29
monitortimers()
{
	level endon("game_ended");
	maps\mp\_utility::func_3FA5("prematch_done");
	level.blockteamchange = 1;
	level thread pausephtimerformigration();
	if(level.phsettings.prophidetime > 0)
	{
		level.phcountdowntimer settimer(level.phsettings.prophidetime);
		level.phcountdowntimer.var_18 = 1;
	}

	if(useprophudserver())
	{
		level.phwhistletimer settimer(level.phsettings.propwhistletime + level.phsettings.prophidetime);
		level.phwhistletimer.var_18 = 1;
	}

	if(level.phsettings.prophidetime > 0 || level.phsettings.propwhistletime > 0)
	{
		whistlestarttimer(level.phsettings.propwhistletime + level.phsettings.prophidetime);
	}

	if(level.phsettings.prophidetime > 0)
	{
		maps\mp\gametypes\_hostmigration::func_A6F5(level.phsettings.prophidetime);
	}

	maps\mp\_utility::func_3FA4("props_hide_over");
	if(useprophudserver())
	{
		level.phwhistletimer.var_18 = 1;
	}

	level.phcountdowntimer.var_18 = 0;
	foreach(var_01 in level.var_744A)
	{
		var_01 setclientomnvar("ui_hide_hud",0);
	}
}

//Function Number: 30
pausephtimerformigration()
{
	level endon("game_ended");
	level endon("props_hide_over");
	var_00 = int(level.phsettings.prophidetime + gettime() / 1000);
	var_01 = 0;
	for(;;)
	{
		level waittill("host_migration_begin");
		level.phcountdowntimer.var_18 = 0;
		if(useprophudserver())
		{
			level.phwhistletimer.var_18 = 0;
		}

		var_02 = int(maps\mp\gametypes\_hostmigration::func_A782() / 1000);
		var_01 = var_01 + var_02;
		var_02 = var_01;
		var_03 = var_00 + var_02 - int(gettime() / 1000);
		level.phcountdowntimer settimer(var_03);
		if(useprophudserver())
		{
			level.phwhistletimer settimer(level.phsettings.propwhistletime + var_03);
		}

		whistlestarttimer(level.phsettings.propwhistletime + var_03);
		level.phcountdowntimer.var_18 = 1;
		if(useprophudserver())
		{
			level.phwhistletimer.var_18 = 1;
		}
	}
}

//Function Number: 31
handleprop()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	self waittill("applyLoadout");
	self method_8114(0);
	self method_8308(0);
	maps\mp\gametypes\_weapons::func_A13B();
	self method_86BB();
	self method_82CD();
	self takeallweapons();
	self allowspectateteam(game["attackers"],1);
	self method_8003();
	thread setupprop();
	thread maps/mp/gametypes/_prop_controls::setupkeybindings();
	thread setupdamage();
	thread maps/mp/gametypes/_prop_controls::propinputwatch();
	thread propwatchdeath();
	thread propwatchdeletedisconnect();
	thread propwatchdeleteclonesondisconnect();
	thread propwatchdeleteroundend();
	thread propwatchprematchsettings();
	self.var_777D thread highlighttoteam(game["defenders"],2,self);
}

//Function Number: 32
getthirdpersonrangeforpropinfo(param_00)
{
	switch(param_00.propsize)
	{
		case 50:
			return 120;

		case 100:
			return 150;

		case 250:
			return 180;

		case 450:
			return 260;

		case 550:
			return 320;

		default:
			break;
	}

	return 120;
}

//Function Number: 33
getthirdpersonheightoffsetforpropinfo(param_00)
{
	switch(param_00.propsize)
	{
		case 50:
			return -30;

		case 100:
			return -20;

		case 250:
			return 0;

		case 450:
			return 20;

		case 550:
			return 40;

		default:
			break;
	}

	return 0;
}

//Function Number: 34
applyxyzoffset()
{
	if(!isdefined(self.var_777D.xyzoffset))
	{
		return;
	}

	self.var_777D.var_1D = self.var_1D;
	var_00 = anglestoforward(self.var_777D.var_1D) * self.var_777D.xyzoffset[0];
	var_01 = anglestoright(self.var_777D.var_1D) * self.var_777D.xyzoffset[1];
	var_02 = anglestoup(self.var_777D.var_1D) * self.var_777D.xyzoffset[2];
	self.var_777D.var_116 = self.var_777D.var_116 + var_00;
	self.var_777D.var_116 = self.var_777D.var_116 + var_01;
	self.var_777D.var_116 = self.var_777D.var_116 + var_02;
}

//Function Number: 35
applyanglesoffset()
{
	if(!isdefined(self.var_777D.anglesoffset))
	{
		return;
	}

	self.var_777D.var_1D = self.var_1D;
	self.var_777D.var_1D = self.var_777D.var_1D + self.var_777D.anglesoffset;
	self.isangleoffset = 1;
}

//Function Number: 36
propwhistle()
{
	level endon("game_ended");
	maps\mp\_utility::func_3FA5("prematch_done");
	var_00 = gettime();
	var_01 = level.phsettings.propwhistletime * 1000;
	var_02 = 20000;
	var_03 = var_02;
	var_04 = 500;
	var_05 = 5000;
	var_06 = 0;
	var_07 = getentarray("minimap_corner","targetname")[0].var_116;
	maps\mp\gametypes\_hostmigration::func_A6F5(level.phsettings.prophidetime + level.phsettings.propwhistletime);
	setomnvar("ui_war_active_sector",0);
	for(;;)
	{
		if(var_00 + var_01 - var_04 < gettime())
		{
			var_06++;
			var_08 = function_01AC(level.var_744A,var_07);
			foreach(var_0A in var_08)
			{
				if(!isdefined(var_0A))
				{
					continue;
				}

				if(useprophudserver())
				{
					level.phwhistletimer.var_18 = 0;
					level.whistling.var_18 = 0.6;
				}

				if(var_0A.var_1A7 == game["defenders"] && isalive(var_0A))
				{
					if(useprophudserver())
					{
						level.whistling.var_18 = 1;
						level.whistling fadeovertime(0.75);
						level.whistling.var_18 = 0.6;
					}

					playsoundatpos(var_0A.var_116 + (0,0,60),"prop_whistle");
					maps\mp\gametypes\_hostmigration::func_A6F5(1.5);
				}
			}

			setomnvar("ui_war_active_sector",2);
			var_00 = gettime();
			if(var_06 % 2 == 0)
			{
				var_01 = max(var_01 - 5000,var_02);
			}

			if(var_03 >= maps\mp\gametypes\_gamelogic::func_46E5() - var_05)
			{
				if(useprophudserver())
				{
					level.whistling.var_18 = 0;
				}

				return;
			}
			else
			{
				if(var_03 * 2 + getteamplayersalive(game["defenders"]) * 2500 >= maps\mp\gametypes\_gamelogic::func_46E5() - var_05)
				{
					if(useprophudserver())
					{
						level.phwhistletimer.var_E5 = &"MP_PH_FINAL_WHISTLE";
					}

					setomnvar("ui_war_active_sector",1);
					var_03 = var_03 + getteamplayersalive(game["defenders"]) * 2500;
				}

				if(useprophudserver())
				{
					level.phwhistletimer settimer(int(var_01 / 1000));
				}

				whistlestarttimer(int(var_01 / 1000));
				if(useprophudserver())
				{
					level.whistling.var_18 = 0;
					level.phwhistletimer.var_18 = 1;
				}
			}
		}

		maps\mp\gametypes\_hostmigration::func_A6F5(0.5);
	}
}

//Function Number: 37
getlivingplayersonteam(param_00)
{
	var_01 = [];
	foreach(var_03 in level.var_6E97)
	{
		if(!isdefined(var_03.var_1A7))
		{
			continue;
		}

		if(maps\mp\_utility::func_57A0(var_03) && maps\mp\_utility::func_5800(var_03) && var_03.var_1A7 == param_00)
		{
			var_01[var_01.size] = var_03;
		}
	}

	return var_01;
}

//Function Number: 38
createpropspeclist()
{
	self.spectatableprops = getlivingplayersonteam(game["defenders"]);
}

//Function Number: 39
setupdamage()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	maps\mp\gametypes\_hostmigration::func_A6F5(0.5);
	self.var_777D.var_29B5 = ::damagewatch;
}

//Function Number: 40
damagewatch(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(!isdefined(param_01))
	{
		return;
	}

	if(!isdefined(self.var_117))
	{
		return;
	}

	if(isplayer(param_01))
	{
		if(param_01.var_12C["team"] == self.var_117.var_12C["team"])
		{
			return;
		}

		param_01 thread maps\mp\gametypes\_damagefeedback::func_A102("standard",self);
	}

	self.var_117 dodamage(param_02,param_06,param_01,param_00,param_04,param_05,param_08);
}

//Function Number: 41
propcleanup()
{
	thread propcleanupdelayed([self.var_777D,self.propanchor,self.propent]);
}

//Function Number: 42
propcleanupdelayed(param_00)
{
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02))
		{
			var_02 unlink();
		}
	}

	wait 0.05;
	foreach(var_02 in param_00)
	{
		if(isdefined(var_02))
		{
			var_02 delete();
		}
	}
}

//Function Number: 43
propwatchdeath()
{
	level endon("game_ended");
	self endon("disconnect");
	self.deathnoise = "prop_death";
	self.propdeathfx = "propDeathFX";
	self waittill("death");
	var_00 = self.var_18A8;
	playsoundatpos(self.var_777D.var_116 + (0,0,4),self.deathnoise);
	playfx(common_scripts\utility::func_44F5(self.propdeathfx),self.var_777D.var_116 + (0,0,4));
	if(isdefined(var_00))
	{
		var_00 delete();
	}

	propcleanup();
	self method_86BD(0,0);
}

//Function Number: 44
propwatchdeletedisconnect()
{
	self endon("death");
	level endon("round_end_finished");
	self waittill("disconnect");
	foreach(var_01 in level.var_744A)
	{
		if(common_scripts\utility::func_562E(var_01.propspectating) && isdefined(var_01.spectatingthisplayer) && self == var_01.spectatingthisplayer)
		{
			var_01 notify("endPropSpectate");
		}
	}

	propcleanup();
}

//Function Number: 45
propwatchdeleteclonesondisconnect()
{
	level endon("round_end_finished");
	self waittill("disconnect");
	if(isdefined(self.propclones))
	{
		foreach(var_01 in self.propclones)
		{
			var_01 delete();
		}
	}
}

//Function Number: 46
propwatchdeleteroundend()
{
	self endon("death");
	self endon("disconnect");
	level waittill("round_end_finished");
	propcleanup();
}

//Function Number: 47
propwatchprematchsettings()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	self endon("joined_spectators");
	maps\mp\_utility::func_3FA5("prematch_done");
	self method_8114(0);
	self method_8308(0);
}

//Function Number: 48
deleteallglass()
{
	level endon("game_ended");
	level waittill("prematch_over");
	var_00 = function_032F();
	for(var_01 = 0;var_01 < var_00;var_01++)
	{
		deleteglass(var_01);
	}
}

//Function Number: 49
organizeproplist(param_00)
{
	return common_scripts\utility::func_F92(param_00);
}

//Function Number: 50
randgetpropsizetoallocate()
{
	var_00 = 10 * isdefined(level.proplist[50]);
	var_01 = 30 * isdefined(level.proplist[100]);
	var_02 = 40 * isdefined(level.proplist[250]);
	var_03 = 20 * isdefined(level.proplist[450]);
	var_04 = 10 * isdefined(level.proplist[550]);
	var_05 = var_00 + var_01 + var_02 + var_03 + var_04;
	var_06 = randomint(var_05);
	if(var_06 < var_00)
	{
		return 50;
	}

	var_06 = var_06 - var_00;
	if(var_06 < var_01)
	{
		return 100;
	}

	var_06 = var_06 - var_01;
	if(var_06 < var_02)
	{
		return 250;
	}

	var_06 = var_06 - var_02;
	if(var_06 < var_03)
	{
		return 450;
	}

	var_06 = var_06 - var_03;
	return 550;
}

//Function Number: 51
getnextprop(param_00)
{
	var_01 = randgetpropsizetoallocate();
	var_02 = getarraykeys(level.proplist);
	var_02 = common_scripts\utility::func_F92(var_02);
	var_03 = [var_01];
	foreach(var_05 in var_02)
	{
		if(var_05 != var_01)
		{
			var_03[var_03.size] = var_05;
		}
	}

	var_07 = undefined;
	for(var_08 = 0;var_08 < var_03.size;var_08++)
	{
		var_05 = var_03[var_08];
		if(!isdefined(level.proplist[var_05]) || !level.proplist[var_05].size)
		{
			continue;
		}

		var_09 = common_scripts\utility::func_F92(level.proplist[var_05]);
		for(var_0A = 0;var_0A < var_09.size;var_0A++)
		{
			var_07 = var_09[var_0A];
			var_0B = 0;
			if(isdefined(param_00.usedprops) && param_00.usedprops.size)
			{
				for(var_0C = 0;var_0C < param_00.usedprops.size;var_0C++)
				{
					if(var_07.modelname == param_00.usedprops[var_0C].modelname)
					{
						var_0B = 1;
						break;
					}
				}
			}

			if(!var_0B)
			{
				return var_07;
			}
		}
	}

	return var_07;
}

//Function Number: 52
populateproplist()
{
	var_00 = maps\mp\_utility::func_4571();
	var_01 = "mp/ph_props_" + var_00 + ".csv";
	var_02 = function_027A(var_01);
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		var_04 = tablelookupbyrow(var_01,var_03,0);
		var_05 = tablelookupbyrow(var_01,var_03,1);
		var_06 = int(tablelookupbyrow(var_01,var_03,2));
		var_07 = int(tablelookupbyrow(var_01,var_03,3));
		var_08 = int(tablelookupbyrow(var_01,var_03,4));
		var_09 = int(tablelookupbyrow(var_01,var_03,5));
		var_0A = int(tablelookupbyrow(var_01,var_03,6));
		var_0B = int(tablelookupbyrow(var_01,var_03,7));
		var_0C = undefined;
		if(isdefined(var_06) && isdefined(var_07) && isdefined(var_08))
		{
			var_0C = (var_06,var_07,var_08);
		}

		var_0D = undefined;
		if(isdefined(var_09) && isdefined(var_0A) && isdefined(var_0B))
		{
			var_0D = (var_09,var_0A,var_0B);
		}

		var_0E = getpropsize(var_05);
		addproptolist(var_04,var_0E,var_0C,var_0D,var_05);
	}

	if(var_02 == 0)
	{
		addproptolist("tag_origin",250,(0,0,0),(0,0,0),"medium");
	}

	level.proplist = organizeproplist(level.proplist);
}

//Function Number: 53
setupprop()
{
	var_00 = getnextprop(self);
	self.propanchor = spawn("script_model",self.var_116);
	self.propanchor.var_1A5 = "propAnchor";
	self.propanchor method_8449(self);
	self.propanchor method_86BA();
	self.propanchor method_80B0(0);
	self.propent = spawn("script_model",self.var_116);
	self.propent setmodel("s2_generic_prop_raven_x3");
	self.propent.var_1A5 = "propEnt";
	self.propent method_8449(self.propanchor);
	self.propent method_86BA();
	self.propent method_80B0(0);
	self.var_777D = spawn("script_model",self.propent.var_116);
	self.var_777D.var_1A5 = "prop";
	self.var_777D setmodel(var_00.modelname);
	self.var_777D setcandamage(1);
	self.var_777D.xyzoffset = var_00.xyzoffset;
	self.var_777D.anglesoffset = var_00.anglesoffset;
	self.var_777D.var_1D = self.var_1D;
	applyxyzoffset();
	applyanglesoffset();
	self.var_777D method_8449(self.propent,"J_prop_1");
	self.var_777D method_86BA();
	self.var_777D.var_117 = self;
	self.var_777D.var_BC = 10000;
	self.var_777D setdamagecallbackon(1);
	self.var_777D setclientowner(self);
	self.propent scriptmodelplayanim("prop_hunt_prop_spin","propSpinAnim",undefined,1.5);
	self.propent scriptmodelpauseanim(1);
	self.thirdpersonrange = getthirdpersonrangeforpropinfo(var_00);
	self.thirdpersonheightoffset = getthirdpersonheightoffsetforpropinfo(var_00);
	self method_86BD(1,self.thirdpersonrange,self.thirdpersonheightoffset);
	self.var_777D.var_5135 = var_00;
	self.usedprops = [];
	self.var_BC = getprophealth(var_00);
	self.var_FB = self.var_BC;
}

//Function Number: 54
getprophealth(param_00)
{
	var_01 = maps\mp\gametypes\_tweakables::func_46F7("player","maxhealth");
	var_02 = var_01 / 100;
	return int(param_00.propsize * var_02);
}

//Function Number: 55
getpropsize(param_00)
{
	var_01 = 0;
	switch(param_00)
	{
		case "xsmall":
			var_01 = 50;
			break;

		case "small":
			var_01 = 100;
			break;

		case "medium":
			var_01 = 250;
			break;

		case "large":
			var_01 = 450;
			break;

		case "xlarge":
			var_01 = 550;
			break;

		default:
			var_02 = maps\mp\_utility::func_4571();
			var_03 = "mp/ph_props_" + var_02 + ".csv";
			var_01 = 100;
			break;
	}

	return var_01;
}

//Function Number: 56
addproptolist(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(level.proplist))
	{
		level.proplist = [];
	}

	if(!isdefined(level.propindex))
	{
		level.propindex = [];
	}

	if(!isdefined(level.proplist[param_01]))
	{
		level.proplist[param_01] = [];
	}

	var_05 = spawnstruct();
	var_05.modelname = param_00;
	var_05.propsize = int(param_01);
	var_05.propsizetext = param_04;
	if(isdefined(param_02))
	{
		var_05.xyzoffset = param_02;
	}

	if(isdefined(param_03))
	{
		var_05.anglesoffset = param_03;
	}

	level.propindex[level.propindex.size] = [param_01,level.proplist[param_01].size];
	level.proplist[param_01][level.proplist[param_01].size] = var_05;
}

//Function Number: 57
ph_endgame(param_00,param_01)
{
	if(common_scripts\utility::func_562E(level.endingph))
	{
		return;
	}

	level.endingph = 1;
	ph_setfinalkillcamwinner(param_00);
	thread maps\mp\gametypes\_gamelogic::func_36B9(param_00,param_01);
	level thread givephteamscore(param_00);
	if(param_00 == game["defenders"])
	{
		thread sendachievementengineinfo(param_00);
	}
}

//Function Number: 58
ph_setfinalkillcamwinner(param_00)
{
	level.var_3B5C = param_00;
	if(level.var_3B5C == game["defenders"])
	{
		level.skipfinalkillcamfx = 1;
	}
}

//Function Number: 59
givephteamscore(param_00)
{
	level endon("game_ended");
	var_01 = game["roundsWon"][param_00] + 1;
	setteamscore(param_00,var_01);
}

//Function Number: 60
sendachievementengineinfo(param_00)
{
	var_01 = getlivingplayersonteam(param_00);
	foreach(var_03 in var_01)
	{
		var_03 lib_0468::func_A22("propRoundSurvivor");
		if(isdefined(var_03.changesleft) && var_03.changesleft == int(level.phsettings.propchangecount))
		{
			var_03 lib_0468::func_A22("propChangelessSurvivor");
		}
	}
}

//Function Number: 61
setphteamscores()
{
	level endon("game_ended");
	var_00 = game["roundsWon"][game["defenders"]];
	var_01 = game["roundsWon"][game["attackers"]];
	setteamscore(game["defenders"],var_00);
	setteamscore(game["attackers"],var_01);
}

//Function Number: 62
func_6B5E(param_00)
{
	if(common_scripts\utility::func_562E(level.var_3F9D))
	{
		return;
	}

	if(param_00 == game["attackers"])
	{
		return;
	}

	var_01 = undefined;
	foreach(var_03 in level.var_744A)
	{
		if(isdefined(param_00) && var_03.var_1A7 != param_00)
		{
			continue;
		}

		if(!maps\mp\_utility::func_57A0(var_03) && !var_03 maps\mp\gametypes\_playerlogic::func_60B2())
		{
			continue;
		}

		if(isdefined(var_01))
		{
			return;
		}

		var_01 = var_03;
	}

	if(!isdefined(var_01))
	{
		return;
	}

	var_01 thread func_478F();
}

//Function Number: 63
func_478F()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	maps\mp\_utility::func_A78E(3);
	var_00 = maps\mp\_utility::func_45DE(self.var_12C["team"]);
	level thread maps\mp\_utility::func_9863("callout_lastteammemberalive",self,self.var_12C["team"]);
	level thread maps\mp\_utility::func_9863("callout_lastenemyalive",self,var_00);
	if(self.var_1A7 == game["defenders"])
	{
		level notify("noPropsToSpectate");
		level.nopropsspectate = 1;
	}

	level notify("last_alive",self);
}

//Function Number: 64
func_6BB6()
{
	if(!common_scripts\utility::func_562E(level.gameending))
	{
		var_00 = maps\mp\_utility::func_46E3();
		game["propSurvivalTime"][game["defenders"]] = game["propSurvivalTime"][game["defenders"]] + var_00;
		game["hunterKillTime"][game["attackers"]] = game["hunterKillTime"][game["attackers"]] + var_00;
		choosefinalkillcam();
		ph_endgame(game["defenders"],game["end_reason"]["time_limit_reached"]);
	}
}

//Function Number: 65
choosefinalkillcam()
{
	var_00 = getlivingplayersonteam(game["defenders"]);
	if(var_00.size < 1)
	{
		return;
	}

	var_01 = getlivingplayersonteam(game["attackers"]);
	if(var_01.size < 1)
	{
		return;
	}

	var_02 = choosebestpropforkillcam(var_00,var_01);
	if(maps\mp\_utility::func_56FF(var_02))
	{
		var_03 = var_02 getentitynumber();
	}
	else
	{
		var_03 = -1;
	}

	var_04 = var_01[0];
	var_04.var_2AB8 = gettime() - 1000;
	maps\mp\gametypes\_final_killcam::func_7B32(5,var_04,var_02,var_03,-1,0,"none",0,0,"none","normal",0);
}

//Function Number: 66
choosebestpropforkillcam(param_00,param_01)
{
	var_02 = undefined;
	var_03 = 1073741824;
	foreach(var_05 in param_00)
	{
		var_06 = undefined;
		var_07 = 1073741824;
		foreach(var_09 in param_01)
		{
			var_0A = getpathdist(var_05.var_116,var_09.var_116,999999);
			if(var_0A < var_07)
			{
				var_07 = var_0A;
				var_06 = var_09;
			}
		}

		if(var_07 < var_03)
		{
			var_03 = var_07;
			var_02 = var_05;
		}
	}

	if(!isdefined(var_02))
	{
		var_02 = common_scripts\utility::func_7A33(param_00);
	}

	return var_02;
}

//Function Number: 67
ph_checkforovertime()
{
	if(game["roundsWon"]["allies"] == maps\mp\_utility::func_471A("winlimit") - 1 && game["roundsWon"]["axis"] == maps\mp\_utility::func_471A("winlimit") - 1)
	{
		return 1;
	}

	return 0;
}

//Function Number: 68
givecustomloadout()
{
	self endon("disconnect");
	level endon("game_ended");
	self endon("death");
	self waittill("applyLoadout");
	self.thirdpersonrange = undefined;
	self method_86BD(0,0);
	self method_8114(1);
	self method_8308(1);
	maps\mp\gametypes\_weapons::func_A13B();
	self method_86BC();
	self method_82CE();
	self method_8004();
	self.concussionimmune = 1;
	attackerinitammo();
	thread attackerregenammo();
}

//Function Number: 69
stillalivexp()
{
	level endon("game_ended");
	level.var_AAD1["kill"]["value"] = 300;
	level waittill("props_hide_over");
	for(;;)
	{
		maps\mp\gametypes\_hostmigration::func_A6F5(10);
		foreach(var_01 in level.var_744A)
		{
			if(!isdefined(var_01.var_1A7))
			{
				continue;
			}

			if(var_01.var_1A7 == game["attackers"])
			{
				continue;
			}

			if(!maps\mp\_utility::func_57A0(var_01))
			{
				continue;
			}

			level thread maps\mp\gametypes\_rank::func_1457("still_alive",var_01);
			switch(var_01.var_777D.var_5135.propsize)
			{
				case 250:
					level thread maps\mp\gametypes\_rank::func_1457("still_alive_medium_bonus",var_01);
					break;
	
				case 450:
					level thread maps\mp\gametypes\_rank::func_1457("still_alive_large_bonus",var_01);
					break;
	
				case 550:
					level thread maps\mp\gametypes\_rank::func_1457("still_alive_extra_large_bonus",var_01);
					break;
	
				default:
					break;
			}
		}
	}
}

//Function Number: 70
tracktimealive()
{
	level endon("game_ended");
	maps\mp\_utility::func_3FA5("prematch_done");
	for(;;)
	{
		foreach(var_01 in level.var_744A)
		{
			if(!isdefined(var_01.var_1A7))
			{
				continue;
			}

			if(var_01.var_1A7 == game["attackers"])
			{
				continue;
			}

			if(!maps\mp\_utility::func_57A0(var_01))
			{
				continue;
			}

			var_01.var_12C["propSeconds"]++;
			var_01 maps\mp\_utility::func_867B(var_01.var_12C["propSeconds"]);
		}

		maps\mp\gametypes\_hostmigration::func_A6F5(1);
	}
}

//Function Number: 71
func_3FC8(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(common_scripts\utility::func_562E(self.propspectating))
	{
		self notify("endPropSpectate");
		if(param_04 == "MOD_TRIGGER_HURT")
		{
			return 0;
		}
	}

	if(isdefined(param_00.var_1A7))
	{
		if(param_00.var_1A7 == game["attackers"])
		{
			param_03 = modifydamagetohunter(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
		}
		else if(param_00.var_1A7 == game["defenders"])
		{
			param_03 = modifydamagetoprop(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
		}

		if(param_03 == 0)
		{
			return 0;
		}
	}

	if(isdefined(param_02) && isplayer(param_02) && isalive(param_02))
	{
		if(!isdefined(param_02.hashitplayer))
		{
			param_02.hashitplayer = 1;
		}

		if(level.var_6031)
		{
			param_03 = param_03 * level.var_6031;
		}

		if(level.var_6035)
		{
			param_02.var_BC = int(min(float(param_02.var_FB),float(param_02.var_BC + 20)));
		}
	}

	return param_03;
}

//Function Number: 72
modifydamagetoprop(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(param_04) && param_04 == "MOD_FALLING")
	{
		return 0;
	}

	return param_03;
}

//Function Number: 73
modifydamagetohunter(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(param_04) && param_04 == "MOD_FALLING")
	{
		return 0;
	}

	if(param_05 == "stun_grenade_mp")
	{
		return 0;
	}

	if(issubstr(param_05,"destructible"))
	{
		return 0;
	}

	return param_03;
}

//Function Number: 74
attackerswaittime()
{
	level endon("game_ended");
	self endon("disconnect");
	self waittill("spawned_player");
	if(self.var_1A7 == game["defenders"])
	{
		return;
	}

	maps\mp\_utility::func_3FA5("prematch_done");
	while(!isdefined(level.var_9309))
	{
		wait 0.05;
	}

	while(isdefined(self.var_260C) && self.var_260C)
	{
		wait 0.05;
	}

	var_00 = gettime() - level.var_9309 / 1000;
	var_01 = level.phsettings.prophidetime - var_00;
	if(var_01 > 0)
	{
		maps\mp\_utility::func_3E8E(1);
		self.phfrozen = 1;
		if(int(var_00) > 0)
		{
			var_02 = 0;
		}
		else
		{
			var_02 = 1;
		}

		var_03 = 1;
		if(var_02 + var_03 > var_01)
		{
			var_02 = 0;
			var_03 = 0;
		}

		thread maps/mp/gametypes/_prop_controls::fadetoblackforxsec(var_01,var_02,var_03);
		if(getdvarint("scr_prop_minigame",0))
		{
			thread propwaitminigameinit();
		}

		maps\mp\gametypes\_hostmigration::func_A6F5(var_01);
	}

	self.phfrozen = undefined;
	level.startcheck = 1;
	maps\mp\_utility::func_3E8E(0);
}

//Function Number: 75
propminigamesetting(param_00,param_01,param_02,param_03)
{
	var_04 = spawnstruct();
	var_04.var_56 = param_00;
	var_04.var_E5 = param_01;
	var_04.winfontscale = param_03;
	var_04.winyoffset = param_02;
	return var_04;
}

//Function Number: 76
propwaitminigameinit()
{
	if(!isdefined(level.minigameinfo))
	{
		level.minigamefinishcount = 0;
		level.minigamewinnersettings = [];
		level.minigamewinnersettings[0] = propminigamesetting((1,0.843,0),&"MP_PH_MINIGAME_FIRST",-80,2);
		level.minigamewinnersettings[1] = propminigamesetting((0.3,0.3,0.3),&"MP_PH_MINIGAME_SECOND",-50,1.75);
		level.minigamewinnersettings[2] = propminigamesetting((0.804,0.498,0.196),&"MP_PH_MINIGAME_THIRD",-20,1.5);
		level.minigamelosersettings = propminigamesetting((1,1,1),&"MP_PH_EMPTY");
		level.minigameinfo = [];
		level thread propminigameupdates();
	}

	var_00 = spawnstruct();
	var_00.var_721C = self;
	var_00.var_48CA = self.var_48CA;
	var_00.finish = 0;
	var_00.var_1DC7 = "+weapnext";
	var_00.buttonnotify = "miniGameButtonPress";
	level thread propwaitminigamecleanuponplayernotify("disconnect",var_00);
	level propwaitminigamerun(var_00);
}

//Function Number: 77
propwaitminigamecleanuponplayernotify(param_00,param_01)
{
	level endon("game_ended");
	level endon("props_hide_over");
	level endon("mini_game_end");
	param_01.var_721C waittill(param_00);
	propwaitminigamecleanup(param_01);
}

//Function Number: 78
propwaitminigamecleanup(param_00)
{
	if(isdefined(param_00.var_4F52))
	{
		param_00.var_4F52 destroy();
	}

	if(isdefined(param_00.var_721C) && !isbot(param_00.var_721C))
	{
		param_00.var_721C notifyonplayercommandremove(param_00.buttonnotify,param_00.var_1DC7);
	}

	level.minigameinfo[param_00.var_48CA] = undefined;
}

//Function Number: 79
propwaitminigamerun(param_00)
{
	level endon("game_ended");
	level endon("props_hide_over");
	level endon("mini_game_end");
	param_00.var_721C endon("disconnect");
	if(!isbot(param_00.var_721C))
	{
		param_00.var_721C notifyonplayercommand(param_00.buttonnotify,param_00.var_1DC7);
	}

	if(isbot(param_00.var_721C))
	{
		while(!level.minigameinfo.size)
		{
			wait 0.05;
		}

		wait(randomfloatrange(0,1));
	}
	else
	{
		param_00.var_721C waittill(param_00.buttonnotify);
	}

	param_00.var_721C setclientomnvar("ui_hide_hud",1);
	level.minigameinfo[param_00.var_48CA] = param_00;
	propwaitminigamehudinit(param_00);
	propwaitminigamehudsetpoint(param_00);
	childthread propwaitminigamebuttonwatch(param_00);
	childthread propwaitminigamefalltimer(param_00);
}

//Function Number: 80
propwaitminigamebuttonwatch(param_00)
{
	param_00 endon("finished");
	var_01 = randomfloatrange(0.2,0.4);
	for(;;)
	{
		if(isbot(param_00.var_721C))
		{
			wait(randomfloatrange(0.05,var_01));
		}
		else
		{
			param_00.var_721C waittill(param_00.buttonnotify);
		}

		param_00.hud_y_offset = param_00.hud_y_offset - 4;
	}
}

//Function Number: 81
propwaitminigamefalltimer(param_00)
{
	param_00 endon("finished");
	for(;;)
	{
		param_00.hud_y_offset = param_00.hud_y_offset + 0.5;
		if(param_00.hud_y_offset > -18)
		{
			param_00.hud_y_offset = -18;
		}

		wait 0.05;
	}
}

//Function Number: 82
propwaitminigamehudsetpoint(param_00)
{
	param_00.var_4F52 maps\mp\gametypes\_hud_util::func_8707("BOTTOM","BOTTOM",param_00.hud_x_offset,param_00.hud_y_offset);
}

//Function Number: 83
propwaitminigamehudinit(param_00)
{
	var_01 = maps\mp\gametypes\_hud_util::func_2829("default",1.5,param_00.var_721C.var_1A7);
	var_01 setplayernamestring(param_00.var_721C);
	var_01.ignoreme = 1;
	param_00.hud_x_offset = 0;
	param_00.hud_y_offset = -18;
	param_00.var_4F52 = var_01;
}

//Function Number: 84
propminigamescore_compare(param_00,param_01)
{
	var_02 = level.minigameinfo[param_00];
	var_03 = level.minigameinfo[param_01];
	if(var_02.finish && var_03.finish)
	{
		return var_02.finish <= var_03.finish;
	}

	if(var_02.finish)
	{
		return 1;
	}

	if(var_03.finish)
	{
		return 0;
	}

	return var_02.hud_y_offset <= var_03.hud_y_offset;
}

//Function Number: 85
propminigameupdates()
{
	propminigameupdateui();
	wait(0.2);
	minigameapplyplayernamesettings(1);
	if(!level.minigameinfo.size)
	{
		return;
	}

	var_00 = common_scripts\utility::func_7897(getarraykeys(level.minigameinfo),::propminigamescore_compare);
	foreach(var_07, var_02 in level.minigameinfo)
	{
		var_03 = 0;
		if(var_02.hud_y_offset < -18 && var_02.finish)
		{
			foreach(var_06, var_05 in level.minigamewinnersettings)
			{
				if(isdefined(var_00[var_06]) && var_07 == var_00[var_06])
				{
					var_03 = 1;
					level thread propminigameupdateshowwinner(var_02,var_05);
					break;
				}
			}
		}

		if(!var_03)
		{
			level thread propminigameupdateshowloser(var_02);
		}
	}
}

//Function Number: 86
propminigameupdateshowloser(param_00)
{
	param_00.var_4F52 endon("death");
	var_01 = abs(param_00.hud_y_offset);
	var_02 = clamp(var_01 / 500,0.05,1);
	param_00.var_4F52 maps\mp\gametypes\_hud_util::func_8707("BOTTOM","BOTTOM",param_00.hud_x_offset,0,var_02);
	param_00.var_4F52 fadeovertime(var_02);
	param_00.var_18 = 0;
	wait(var_02);
	propwaitminigamecleanup(param_00);
}

//Function Number: 87
propminigameupdateshowwinner(param_00,param_01)
{
	param_00.var_4F52 endon("death");
	var_02 = 0.5;
	var_03 = 2.5;
	var_04 = 0.5;
	param_00.var_4F52 maps\mp\gametypes\_hud_util::func_8707("BOTTOM","CENTER",0,param_01.winyoffset,var_02);
	param_00.var_4F52 changefontscaleovertime(var_02);
	param_00.var_4F52.var_9B = param_01.winfontscale;
	param_00.var_4F52.var_E5 = &"MP_PH_EMPTY";
	wait(var_02 + var_03);
	param_00.var_4F52.var_18 = 0;
	param_00.var_4F52 fadeovertime(var_04);
	propwaitminigamecleanup(param_00);
}

//Function Number: 88
propminigamefinish(param_00)
{
	if(param_00.finish > 0)
	{
		return;
	}

	if(level.minigamefinishcount >= level.minigamewinnersettings.size)
	{
		return;
	}

	param_00 notify("finished");
	level.minigamefinishcount++;
	param_00.finish = level.minigamefinishcount;
	param_00.hud_y_offset = -258;
	propwaitminigamehudsetpoint(param_00);
}

//Function Number: 89
propminigameupdateui()
{
	level endon("props_hide_over");
	level endon("mini_game_end");
	var_00 = 480;
	var_01 = -1 * var_00;
	var_02 = var_00 - var_01;
	for(;;)
	{
		waittillframeend;
		var_03 = level.minigameinfo.size;
		var_04 = var_02 / var_03 + 1;
		var_05 = 0;
		foreach(var_07 in level.minigameinfo)
		{
			var_05++;
			var_07.hud_x_offset = var_04 * var_05 + var_01;
			propwaitminigamehudsetpoint(var_07);
		}

		foreach(var_07 in level.minigameinfo)
		{
			if(var_07.hud_y_offset <= -258)
			{
				thread propminigamefinish(var_07);
			}
		}

		minigameapplyplayernamesettings(0);
		if(level.minigamefinishcount >= level.minigamewinnersettings.size)
		{
			level notify("mini_game_end");
		}

		wait 0.05;
	}
}

//Function Number: 90
minigameapplyplayernamesettings(param_00)
{
	if(!level.minigameinfo.size)
	{
		return;
	}

	var_01 = common_scripts\utility::func_7897(getarraykeys(level.minigameinfo),::propminigamescore_compare);
	foreach(var_09, var_03 in level.minigameinfo)
	{
		var_04 = level.minigamelosersettings.var_56;
		var_05 = level.minigamelosersettings.var_E5;
		if(var_03.hud_y_offset < -18)
		{
			foreach(var_08, var_07 in level.minigamewinnersettings)
			{
				if(param_00 && !var_03.finish)
				{
					continue;
				}

				if(isdefined(var_01[var_08]) && var_09 == var_01[var_08])
				{
					var_04 = var_07.var_56;
					if(var_03.finish != 0)
					{
						var_05 = var_07.var_E5;
					}

					break;
				}
			}
		}

		var_03.var_4F52.var_56 = var_04;
		var_03.var_4F52.var_E5 = var_05;
	}
}

//Function Number: 91
attackerinitammo()
{
	var_00 = self getweaponslistprimaries();
	foreach(var_02 in var_00)
	{
		self givemaxammo(var_02);
	}

	var_04 = self getweaponammostock("stun_grenade_mp");
	var_04 = var_04 - self.thrownspecialcount;
	var_04 = int(max(var_04,0));
	self setweaponammostock("stun_grenade_mp",var_04);
	if(var_04 > 0)
	{
		thread maps/mp/gametypes/_prop_controls::watchspecialgrenadethrow();
	}
}

//Function Number: 92
attackerregenammo()
{
	self endon("death");
	self endon("disconnect");
	self notify("attackerRegenAmmo");
	self endon("attackerRegenAmmo");
	level endon("game_ended");
	for(;;)
	{
		self waittill("reload");
		var_00 = self getcurrentprimaryweapon();
		var_01 = weaponmaxammo(var_00);
		if(self getweaponammostock(var_00) < var_01)
		{
			self setweaponammostock(var_00,var_01);
		}
	}
}

//Function Number: 93
checkkillrespawn()
{
	self endon("disconnect");
	level endon("game_ended");
	maps\mp\gametypes\_hostmigration::func_A6F5(0.1);
	if(self.var_12C["lives"] == 1)
	{
		self.var_12C["lives"]--;
		level.var_5DDB[self.var_1A7]--;
		maps\mp\gametypes\_gamelogic::func_A11E();
		level notify("propCountChanged");
	}
}

//Function Number: 94
func_6B7B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = self;
	var_0B = 0;
	level notify("playerCountChanged");
	if(var_0A.var_1A7 == game["attackers"])
	{
		thread respawnattacker();
	}
	else
	{
		thread maps\mp\gametypes\_deathicons::func_9AA(var_0A.var_18A8,var_0A,var_0A.var_1A7,5,param_01);
	}

	if(isdefined(param_01) && isplayer(param_01) && param_01 != var_0A && var_0A.var_1A7 != param_01.var_1A7)
	{
		var_0B = 1;
	}

	if(var_0B)
	{
		param_01 thread maps\mp\gametypes\_hud_message::func_9102("prop_finalblow");
		foreach(var_0D in var_0A.var_1193)
		{
			if(var_0D == param_01)
			{
				var_0D method_860F("mp_hit_kill_headshot",var_0D);
				continue;
			}

			var_0D method_860F("repulsor_fire",var_0D);
		}
	}

	function_0226(&"update_sector_stats");
	foreach(var_10 in level.var_744A)
	{
		if(common_scripts\utility::func_562E(var_10.propspectating) && isdefined(var_10.spectatingthisplayer) && var_0A == var_10.spectatingthisplayer)
		{
			var_10 notify("endPropSpectate");
		}

		if(var_10 != param_01 && var_10.var_1A7 == game["defenders"] && isalive(var_10) && var_0A.var_1A7 == game["defenders"])
		{
			var_10 thread maps\mp\gametypes\_hud_message::func_9102("prop_survived");
		}
	}
}

//Function Number: 95
respawnattacker()
{
	maps\mp\gametypes\_playerlogic::func_50F8(self.var_1A7);
	self.var_CA4 = 1;
	thread func_A6E1();
}

//Function Number: 96
func_A6E1()
{
	self endon("started_spawnPlayer");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		wait 0.05;
		if(isdefined(self) && self.var_178 == "spectator" || !maps\mp\_utility::func_57A0(self))
		{
			self.var_12C["lives"] = 1;
			maps\mp\gametypes\_playerlogic::func_9035();
			continue;
		}
	}
}

//Function Number: 97
func_6AE2(param_00)
{
	if(param_00 == game["defenders"])
	{
		level thread propkilledend();
	}
}

//Function Number: 98
propkilledend()
{
	if(common_scripts\utility::func_562E(level.hunterswonending))
	{
		return;
	}

	if(common_scripts\utility::func_562E(level.gameending))
	{
		return;
	}

	level.hunterswonending = 1;
	var_00 = maps\mp\_utility::func_46E3();
	game["propSurvivalTime"][game["defenders"]] = game["propSurvivalTime"][game["defenders"]] + var_00;
	game["hunterKillTime"][game["attackers"]] = game["hunterKillTime"][game["attackers"]] + var_00;
	level.gameending = 1;
	maps\mp\gametypes\_hostmigration::func_A6F5(3);
	thread ph_endgame(game["attackers"],game["end_reason"][game["defenders"] + "_eliminated"]);
}

//Function Number: 99
playdamagesoundph(param_00)
{
	if(self.var_1A7 == game["defenders"])
	{
		return;
	}

	if(isdefined(self.var_29AB) && self.var_29AB + 5000 > param_00)
	{
		return;
	}

	self.var_29AB = param_00;
	var_01 = randomintrange(1,8);
	if(self.var_1A7 == "axis")
	{
		if(self method_843D())
		{
			self method_8617("generic_pain_enemy_fm_" + var_01);
			return;
		}

		self method_8617("generic_pain_enemy_" + var_01);
		return;
	}

	if(self method_843D())
	{
		self method_8617("generic_pain_friendly_fm_" + var_01);
		return;
	}

	self method_8617("generic_pain_friendly_" + var_01);
}

//Function Number: 100
playdeathsoundph()
{
	var_00 = randomintrange(1,8);
	if(self.var_1A7 == game["attackers"] && isdefined(self.var_18A8))
	{
		if(self.var_1A7 == "axis")
		{
			if(self method_843D())
			{
				var_00 = randomintrange(1,4);
				var_01 = lib_0380::func_6842("generic_death_enemy_fm_" + var_00,undefined,self.var_18A8.var_116);
				return;
			}

			var_01 = randomintrange(1,7);
			var_01 = lib_0380::func_6842("generic_death_enemy_" + var_01,undefined,self.var_18A8.var_116);
			return;
		}

		if(self method_843D())
		{
			var_01 = randomintrange(1,4);
			var_01 = lib_0380::func_6842("generic_death_friendly_fm_" + var_01,undefined,self.var_18A8.var_116);
			return;
		}

		var_01 = randomintrange(1,7);
		var_01 = lib_0380::func_6842("generic_death_friendly_" + var_01,undefined,self.var_18A8.var_116);
		return;
	}
}

//Function Number: 101
gametyperoundendscoresetomnvar(param_00,param_01,param_02,param_03,param_04)
{
	if(common_scripts\utility::func_562E(param_03) && isdefined(level.proptiebreaker))
	{
		if(level.proptiebreaker == "kills")
		{
			self setclientomnvar("ui_round_end_reason",game["end_reason"]["prop_tiebreaker_kills"]);
			self setclientomnvar("ui_round_end_friendly_score",game["propScore"][param_04]);
			self setclientomnvar("ui_round_end_enemy_score",game["propScore"][level.var_6C63[param_04]]);
		}
		else if(level.proptiebreaker == "time")
		{
			var_05 = game["hunterKillTime"][param_04] / 1000;
			var_06 = game["hunterKillTime"][level.var_6C63[param_04]] / 1000;
			var_07 = int(exp(var_05));
			var_08 = int(exp(var_06));
			if(var_07 == var_08)
			{
				if(var_05 > var_06)
				{
					var_07++;
				}
				else
				{
					var_08++;
				}
			}

			self setclientomnvar("ui_round_end_reason",game["end_reason"]["prop_tiebreaker_time"]);
			self setclientomnvar("ui_round_end_friendly_score",var_07);
			self setclientomnvar("ui_round_end_enemy_score",var_08);
		}

		return 1;
	}

	return 0;
}

//Function Number: 102
playerwatchspectate()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		var_00 = common_scripts\utility::func_A715("joined_spectators","spectating_cycle","death");
		if(var_00 == "death")
		{
			continue;
		}

		if(var_00 == "joined_spectators" && maps\mp\_utility::func_602B())
		{
			thread maps\mp\gametypes\_playerlogic::func_8753(0);
		}

		waittillframeend;
		var_01 = self getspectatingplayer();
		if(!isdefined(var_01))
		{
			continue;
		}

		if(var_01.var_1A7 == game["attackers"])
		{
			self method_8350();
			continue;
		}

		if(var_01.var_1A7 == game["defenders"])
		{
			self method_834F();
		}
	}
}

//Function Number: 103
highlighttoteamonce(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	self hudoutlinedisable();
	foreach(var_05 in level.var_744A)
	{
		if(isdefined(param_02) && param_02 == var_05)
		{
			continue;
		}

		var_06 = var_05.var_178 == "spectator";
		if(var_05.var_1A7 == param_00 && !var_06)
		{
			self hudoutlineenableforclient(var_05,param_01,1);
		}

		if(param_03 && var_05.var_1A7 == "spectator" || var_06)
		{
			self hudoutlineenableforclient(var_05,param_01,1);
		}
	}
}

//Function Number: 104
highlighttoteam(param_00,param_01,param_02,param_03)
{
	self notify("showToTeam");
	self endon("showToTeam");
	self endon("clear");
	self endon("death");
	self endon("maxDelete");
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	highlighttoteamonce(param_00,param_01,param_02,param_03);
	for(;;)
	{
		level common_scripts\utility::knock_off_battery("joined_team","joined_spectators","spawn_after_spectator","class_select_cancel_spectator");
		highlighttoteamonce(param_00,param_01,param_02,param_03);
	}
}

//Function Number: 105
checkunscoredspawnpoint(param_00)
{
	foreach(var_02 in level.var_744A)
	{
		if(isdefined(var_02.var_1A7) && var_02.var_1A7 == game["defenders"])
		{
			if(isdefined(var_02.var_9070) && isdefined(var_02.var_9070.var_9087) && var_02.var_9070.var_9087 == param_00)
			{
				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 106
disablespawningforplayer(param_00)
{
	if(!maps\mp\_utility::func_3FA6())
	{
		return 0;
	}

	if(param_00.var_1A7 == game["attackers"])
	{
		return 0;
	}
	else if(param_00.var_1A7 == game["defenders"])
	{
		return !level.var_5139;
	}

	return 0;
}