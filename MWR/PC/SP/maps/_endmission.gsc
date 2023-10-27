/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_endmission.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 42
 * Decompile Time: 784 ms
 * Timestamp: 10/27/2023 2:47:44 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = [];
	var_00 = createmission("DEEP_AND_HARD");
	var_00 addlevel("killhouse",0,"EARN_A_WINGED_DAGGER",1,undefined,undefined);
	var_00 addlevel("cargoship",0,"MAKE_THE_JUMP",1,"THE_PACKAGE",undefined);
	var_00 addlevel("coup",0,undefined,1,undefined,undefined);
	var_00 addlevel("blackout",0,"DANCING_IN_THE_DARK",1,"THE_RESCUE",undefined);
	var_00 addlevel("armada",0,undefined,1,"THE_SEARCH",undefined);
	var_00 addlevel("bog_a",0,"SAVE_THE_BACON",1,"THE_BOG",undefined);
	var_00 addlevel("hunted",0,undefined,1,"THE_ESCAPE",undefined);
	var_00 addlevel("ac130",0,"DEATH_FROM_ABOVE",1,"THE_ESCAPE",undefined);
	var_00 addlevel("bog_b",0,undefined,1,"THE_BOG",undefined);
	var_00 addlevel("airlift",0,undefined,1,"THE_FIRST_HORSEMAN",undefined);
	var_00 addlevel("aftermath",0,undefined,1,undefined,undefined);
	var_00 addlevel("village_assault",0,"WRONG_NUMBER",1,"THE_SECOND_HORSEMAN",undefined);
	var_00 addlevel("scoutsniper",1,undefined,1,"THE_SHOT",undefined);
	var_00 addlevel("sniperescape",0,"PIGGYBACK_RIDE",1,"THE_SHOT",undefined);
	var_00 addlevel("village_defend",0,undefined,1,"THE_THIRD_HORSEMAN",undefined);
	var_00 addlevel("ambush",0,"DESPERATE_MEASURES",1,"THE_THIRD_HORSEMAN",undefined);
	var_00 addlevel("icbm",1,undefined,1,"THE_ULTIMATUM",undefined);
	var_00 addlevel("launchfacility_a",1,undefined,1,"THE_ULTIMATUM",undefined);
	var_00 addlevel("launchfacility_b",1,undefined,1,"THE_ULTIMATUM",undefined);
	var_00 addlevel("jeepride",0,undefined,1,"THE_FOURTH_HORSEMAN",undefined);
	var_00 addlevel("airplane",0,undefined,1,"MILE_HIGH_CLUB",undefined);
	if(isdefined(level.endmission_main_func))
	{
		[[ level.endmission_main_func ]]();
		level.endmission_main_func = undefined;
	}

	precachestring(&"campaign_completed_popup");
	level.missionsettings = var_00;
}

//Function Number: 2
debug_test_next_mission()
{
	wait(10);
	while(getdvarint("test_next_mission") < 1)
	{
		wait(3);
	}

	_nextmission();
}

//Function Number: 3
_setmissiondvar(param_00,param_01)
{
	if(maps\_cheat::is_cheating() || common_scripts\utility::flag("has_cheated"))
	{
		return;
	}

	if(getdvar("mis_cheat") == "1")
	{
	}
}

//Function Number: 4
_nextmission()
{
	level notify("achievements_level_complete");
	level.nextmission = 1;
	level.player enableinvulnerability();
	if(maps\_utility::arcademode())
	{
		level.arcademode_success = 1;
		thread maps\_arcademode::arcademode_ends();
		common_scripts\utility::flag_wait("arcademode_ending_complete");
	}

	var_00 = undefined;
	setsaveddvar("ui_nextMission","1");
	setdvar("ui_showPopup","0");
	setdvar("ui_popupString","");
	game["previous_map"] = level.script;
	maps\_gameskill::auto_adust_zone_complete("aa_main_" + level.script);
	var_00 = level.missionsettings getlevelindex(level.script);
	if(!isdefined(var_00))
	{
		return;
	}

	if(level.script != "jeepride" && level.script != "airplane")
	{
		thread maps\_hud_util::fade_out(1,undefined);
		soundscripts\_snd::snd_message("end_mission_fade_to_black");
		wait(2);
		maps\_utility::level_end_save();
	}

	var_01 = level.missionsettings isallmisioncompleted();
	level.missionsettings setlevelcompleted(var_00);
	updategamerprofile();
	if(level.missionsettings hasachievement(var_00))
	{
		maps\_utility::giveachievement_wrapper(level.missionsettings getachievement(var_00));
	}

	if(level.missionsettings haslevelveteranaward(var_00) && getlevelcompleted(var_00) == 4 && level.missionsettings check_other_haslevelveteranachievement(var_00))
	{
		maps\_utility::giveachievement_wrapper(level.missionsettings getlevelveteranaward(var_00));
	}

	if(level.missionsettings hasmissionhardenedaward() && level.missionsettings getlowestskill() > 2)
	{
		maps\_utility::giveachievement_wrapper(level.missionsettings gethardenedaward());
	}

	level.missionsettings checkcampaigncompleted();
	var_02 = level.missionsettings.levels.size;
	if(level.script == "airplane")
	{
		if(getdvarint("arcademode_full"))
		{
			level.player method_84ED(&"AIRPLANE_CAMPAIGN_COMPLETED");
			level.player waittill("menuresponse");
		}

		setsaveddvar("ui_nextMission","0");
		changelevel("");
		return;
	}
	else
	{
		if(var_01 != level.missionsettings isallmisioncompleted())
		{
			level.player method_84ED(&"campaign_completed_popup");
			level.player waittill("menuresponse",var_03,var_04);
			if(var_04 == "quit")
			{
				setsaveddvar("ui_nextMission","0");
				changelevel("");
				return;
			}
		}

		var_02 = var_00 + 1;
	}

	if(getdvarint("limited_mode"))
	{
		setsaveddvar("ui_nextMission","0");
		changelevel("");
		return;
	}

	if(maps\_utility::arcademode())
	{
		if(!getdvarint("arcademode_full"))
		{
			setsaveddvar("ui_nextMission","0");
			changelevel("");
			return;
		}

		if(level.script == "cargoship")
		{
			changelevel("blackout",level.missionsettings getkeepweapons(var_00));
			return;
		}
		else if(level.script == "airlift")
		{
			changelevel("village_assault",level.missionsettings getkeepweapons(var_00));
			return;
		}
		else if(level.script == "jeepride")
		{
			changelevel("airplane",level.missionsettings getkeepweapons(var_00));
			return;
		}
	}

	if(level.script == "jeepride")
	{
		setdvar("credits_load","1");
		changelevel("simplecredits",level.missionsettings getkeepweapons(var_00));
		return;
	}

	if(level.missionsettings skipssuccess(var_00))
	{
		changelevel(level.missionsettings getlevelname(var_02),level.missionsettings getkeepweapons(var_00));
		return;
	}

	missionsuccess(level.missionsettings getlevelname(var_02),level.missionsettings getkeepweapons(var_00));
}

//Function Number: 5
updatesppercent()
{
	var_00 = int(gettotalpercentcompletesp() * 100);
	if(getdvarint("mis_cheat") == 0)
	{
		level.player setlocalplayerprofiledata("percentCompleteSP",var_00);
	}

	return var_00;
}

//Function Number: 6
gettotalpercentcompletesp()
{
	var_00 = max(getstat_easy(),getstat_regular());
	var_01 = 0.5;
	var_02 = getstat_hardened();
	var_03 = 0.25;
	var_04 = getstat_veteran();
	var_05 = 0.1;
	var_06 = getstat_intel();
	var_07 = 0.15;
	var_08 = 0;
	var_08 = var_08 + var_01 * var_00;
	var_08 = var_08 + var_03 * var_02;
	var_08 = var_08 + var_05 * var_04;
	var_08 = var_08 + var_07 * var_06;
	return var_08;
}

//Function Number: 7
getstat_progression(param_00)
{
	var_01 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
	var_02 = 0;
	var_03 = [];
	var_04 = 0;
	for(var_05 = 0;var_05 < level.missionsettings.levels.size;var_05++)
	{
		if(int(var_01[var_05]) >= param_00)
		{
			var_02++;
		}
	}

	var_06 = var_02 / level.missionsettings.levels.size * 100;
	return var_06;
}

//Function Number: 8
getstat_easy()
{
	var_00 = 1;
	return getstat_progression(var_00);
}

//Function Number: 9
getstat_regular()
{
	var_00 = 2;
	return getstat_progression(var_00);
}

//Function Number: 10
getstat_hardened()
{
	var_00 = 3;
	return getstat_progression(var_00);
}

//Function Number: 11
getstat_veteran()
{
	var_00 = 4;
	return getstat_progression(var_00);
}

//Function Number: 12
getstat_intel()
{
	var_00 = 45;
	var_01 = level.player getlocalplayerprofiledata("cheatPoints") / var_00 * 100;
	return var_01;
}

//Function Number: 13
getlevelcompleted(param_00)
{
	return int(level.player getlocalplayerprofiledata("missionHighestDifficulty")[param_00]);
}

//Function Number: 14
getsolevelcompleted(param_00)
{
	return int(level.player getlocalplayerprofiledata("missionSOHighestDifficulty")[param_00]);
}

//Function Number: 15
setlevelcompleted(param_00)
{
	var_01 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
	var_02 = "";
	var_03 = level.gameskill;
	if(level.script == "killhouse" || level.script == "coup" || level.script == "aftermath")
	{
		var_03 = 3;
	}

	for(var_04 = 0;var_04 < var_01.size;var_04++)
	{
		if(var_04 != param_00)
		{
			var_02 = var_02 + var_01[var_04];
			continue;
		}

		if(var_03 + 1 > int(var_01[param_00]))
		{
			var_02 = var_02 + var_03 + 1;
			continue;
		}

		var_02 = var_02 + var_01[var_04];
	}

	var_05 = 0;
	for(var_06 = 0;var_06 < var_02.size;var_06++)
	{
		if(int(var_02[var_06]) > 0)
		{
			var_05 = var_06;
		}
	}

	_sethighestmissionifnotcheating(var_05);
	_setmissiondiffstringifnotcheating(var_02);
}

//Function Number: 16
_sethighestmissionifnotcheating(param_00)
{
	if(maps\_cheat::is_cheating() || common_scripts\utility::flag("has_cheated"))
	{
		return;
	}

	if(getdvar("mis_cheat") == "1")
	{
		return;
	}

	level.player setlocalplayerprofiledata("highestMission",param_00);
}

//Function Number: 17
_setmissiondiffstringifnotcheating(param_00)
{
	if(maps\_cheat::is_cheating() || common_scripts\utility::flag("has_cheated"))
	{
		return;
	}

	if(getdvar("mis_cheat") == "1")
	{
		return;
	}

	level.player setlocalplayerprofiledata("missionHighestDifficulty",param_00);
}

//Function Number: 18
getlevelskill(param_00)
{
	var_01 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
	return int(var_01[param_00]);
}

//Function Number: 19
getmissiondvarstring(param_00)
{
	if(param_00 < 9)
	{
		return "mis_0" + param_00 + 1;
	}

	return "mis_" + param_00 + 1;
}

//Function Number: 20
getlowestskill()
{
	var_00 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
	var_01 = 4;
	for(var_02 = 0;var_02 < self.levels.size;var_02++)
	{
		if(int(var_00[var_02]) < var_01)
		{
			var_01 = int(var_00[var_02]);
		}
	}

	return var_01;
}

//Function Number: 21
isallmisioncompleted()
{
	var_00 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
	for(var_01 = 0;var_01 < self.levels.size;var_01++)
	{
		if(int(var_00[var_01]) == 0)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 22
checkcampaigncompleted()
{
	var_00 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
	var_01 = 1;
	var_02 = 1;
	for(var_03 = 0;var_03 < self.levels.size - 1;var_03++)
	{
		if(int(var_00[var_03]) == 0)
		{
			var_01 = 0;
		}

		if(int(var_00[var_03]) < 3)
		{
			var_02 = 0;
		}
	}

	if(var_01)
	{
		maps\_utility::giveachievement_wrapper("CAMPAIGN_COMPLETE");
	}

	if(var_02)
	{
		maps\_utility::giveachievement_wrapper("DEEP_AND_HARD");
	}
}

//Function Number: 23
createmission(param_00)
{
	var_01 = spawnstruct();
	var_01.levels = [];
	var_01.prereqs = [];
	var_01.hardenedaward = param_00;
	return var_01;
}

//Function Number: 24
addlevel(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = self.levels.size;
	self.levels[var_07] = spawnstruct();
	self.levels[var_07].name = param_00;
	self.levels[var_07].keepweapons = param_01;
	self.levels[var_07].achievement = param_02;
	self.levels[var_07].skipssuccess = param_03;
	self.levels[var_07].veteran_achievement = param_04;
	if(isdefined(param_05))
	{
		self.levels[var_07].fade_time = param_05;
	}
}

//Function Number: 25
addprereq(param_00)
{
	var_01 = self.prereqs.size;
	self.prereqs[var_01] = param_00;
}

//Function Number: 26
getlevelindex(param_00)
{
	foreach(var_03, var_02 in self.levels)
	{
		if(var_02.name == param_00)
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 27
getlevelname(param_00)
{
	return self.levels[param_00].name;
}

//Function Number: 28
getkeepweapons(param_00)
{
	return self.levels[param_00].keepweapons;
}

//Function Number: 29
getachievement(param_00)
{
	return self.levels[param_00].achievement;
}

//Function Number: 30
getlevelveteranaward(param_00)
{
	return self.levels[param_00].veteran_achievement;
}

//Function Number: 31
getfadetime(param_00)
{
	if(!isdefined(self.levels[param_00].fade_time))
	{
		return undefined;
	}

	return self.levels[param_00].fade_time;
}

//Function Number: 32
haslevelveteranaward(param_00)
{
	if(isdefined(self.levels[param_00].veteran_achievement))
	{
		return 1;
	}

	return 0;
}

//Function Number: 33
hasachievement(param_00)
{
	if(isdefined(self.levels[param_00].achievement))
	{
		return 1;
	}

	return 0;
}

//Function Number: 34
check_other_haslevelveteranachievement(param_00)
{
	for(var_01 = 0;var_01 < self.levels.size;var_01++)
	{
		if(var_01 == param_00)
		{
			continue;
		}

		if(!haslevelveteranaward(var_01))
		{
			continue;
		}

		if(self.levels[var_01].veteran_achievement == self.levels[param_00].veteran_achievement)
		{
			if(getlevelcompleted(var_01) < 4)
			{
				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 35
skipssuccess(param_00)
{
	if(!isdefined(self.levels[param_00].skipssuccess))
	{
		return 0;
	}

	return self.levels[param_00].skipssuccess;
}

//Function Number: 36
gethardenedaward()
{
	return self.hardenedaward;
}

//Function Number: 37
hasmissionhardenedaward()
{
	if(isdefined(self.hardenedaward))
	{
		return 1;
	}

	return 0;
}

//Function Number: 38
getnextlevelindex()
{
	for(var_00 = 0;var_00 < self.levels.size;var_00++)
	{
		if(!getlevelskill(var_00))
		{
			return var_00;
		}
	}

	return 0;
}

//Function Number: 39
force_all_complete()
{
	var_00 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
	var_01 = "";
	for(var_02 = 0;var_02 < var_00.size;var_02++)
	{
		if(var_02 < 20)
		{
			var_01 = var_01 + 2;
			continue;
		}

		var_01 = var_01 + 0;
	}

	level.player setlocalplayerprofiledata("missionHighestDifficulty",var_01);
	level.player setlocalplayerprofiledata("highestMission",20);
}

//Function Number: 40
clearall()
{
	level.player setlocalplayerprofiledata("missionHighestDifficulty","00000000000000000000000000000000000000000000000000");
	level.player setlocalplayerprofiledata("highestMission",1);
}

//Function Number: 41
credits_end()
{
	changelevel("airplane",0);
}

//Function Number: 42
end_mission_fade_audio_and_video(param_00)
{
	if(!isdefined(param_00) || param_00 == 0)
	{
		return;
	}

	soundscripts\_snd::snd_message("finish_mission_fade",param_00);
	var_01 = maps\_hud_util::create_client_overlay("black",0,level.player);
	var_01.sort = 100;
	var_01 fadeovertime(param_00);
	var_01.alpha = 1;
	wait(param_00);
}