/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: _endmission.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 40
 * Decompile Time: 584 ms
 * Timestamp: 4/22/2024 2:20:50 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = [];
	var_00 = createmission("THE_BEST_OF_THE_BEST");
	var_00 addlevel("seoul",0,"LEVEL_1",0,undefined,2);
	var_00 addlevel("recovery",0,"LEVEL_2",0,undefined,2);
	var_00 addlevel("lagos",0,"LEVEL_3",0,undefined,2);
	var_00 addlevel("fusion",0,"LEVEL_4",0,undefined,2);
	var_00 addlevel("detroit",0,"LEVEL_5",0,undefined,2);
	var_00 addlevel("greece",0,"LEVEL_6",0,undefined,2);
	var_00 addlevel("betrayal",0,"LEVEL_7",0,undefined,2);
	var_00 addlevel("irons_estate",0,"LEVEL_8",0,undefined,2);
	var_00 addlevel("crash",0,"LEVEL_9",0,undefined,3);
	var_00 addlevel("lab",0,"LEVEL_10",0,undefined,2);
	var_00 addlevel("sanfran",1,"LEVEL_11",0,undefined,3);
	var_00 addlevel("sanfran_b",0,"LEVEL_12",0,undefined,2);
	var_00 addlevel("df_fly",0,undefined,1,undefined,undefined);
	var_00 addlevel("df_baghdad",0,"LEVEL_13",0,undefined,2);
	var_00 addlevel("captured",0,"LEVEL_14",0,undefined,2);
	var_00 addlevel("finale",0,undefined,0,undefined,2);
	if(isdefined(level.endmission_main_func))
	{
		[[ level.endmission_main_func ]]();
		level.endmission_main_func = undefined;
	}

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
_nextmission()
{
	if(maps\_utility::is_demo())
	{
		setsaveddvar("ui_nextMission","0");
		if(isdefined(level.nextmission_exit_time))
		{
			changelevel("",0,level.nextmission_exit_time);
		}
		else
		{
			changelevel("",0);
		}

		return;
	}

	level notify("nextmission");
	level.nextmission = 1;
	level.player enableinvulnerability();
	var_00 = undefined;
	setsaveddvar("ui_nextMission","1");
	setdvar("ui_showPopup","0");
	setdvar("ui_popupString","");
	setdvar("ui_prev_map",level.script);
	game["previous_map"] = level.script;
	var_00 = level.missionsettings getlevelindex(level.script);
	if(level.script == "sp_intro" && !getdvarint("prologue_select"))
	{
		for(var_01 = var_00 + 1;var_01 < level.missionsettings.levels.size - 1;var_01++)
		{
			if(level.missionsettings.levels[var_01].name == "sp_intro")
			{
				var_00 = var_01;
				break;
			}
		}
	}

	setdvar("prologue_select","0");
	if(level.missionsettings hasachievement(var_00))
	{
		maps\_utility::giveachievement_wrapper(level.missionsettings getachievement(var_00));
	}

	maps\_gameskill::auto_adust_zone_complete("aa_main_" + level.script);
	if(!isdefined(var_00))
	{
		missionsuccess(level.script);
		return;
	}

	end_mission_fade_audio_and_video(level.missionsettings getfadetime(var_00));
	if(level.script != "finale")
	{
		maps\_utility::level_end_save();
	}

	level.missionsettings setlevelcompleted(var_00);
	var_02 = level.player getplayersetting("gameskill");
	maps\_player_stats::register_difficulty(level.difficultytype[int(var_02)],0);
	maps\_sp_matchdata::level_complete(level.script);
	var_03 = updatesppercent();
	maps\_upgrade_challenge::commit_exo_awards_upon_mission_success();
	updategamerprofile();
	check_campaign_completion();
	if(level.script == "finale")
	{
		missionsuccess("",0);
		return;
	}

	var_04 = var_00 + 1;
	if(maps\_utility::arcademode())
	{
		if(!getdvarint("arcademode_full"))
		{
			setsaveddvar("ui_nextMission","0");
			missionsuccess(level.script);
			return;
		}
	}

	if(level.missionsettings skipssuccess(var_00))
	{
		if(isdefined(level.missionsettings getfadetime(var_00)))
		{
			changelevel(level.missionsettings getlevelname(var_04),level.missionsettings getkeepweapons(var_00),level.missionsettings getfadetime(var_00));
			return;
		}

		changelevel(level.missionsettings getlevelname(var_04),level.missionsettings getkeepweapons(var_00));
		return;
	}

	missionsuccess(level.missionsettings getlevelname(var_04),level.missionsettings getkeepweapons(var_00));
}

//Function Number: 4
updatesppercent()
{
	var_00 = int(gettotalpercentcompletesp() * 100);
	if(getdvarint("mis_cheat") == 0)
	{
		level.player setlocalplayerprofiledata("percentCompleteSP",var_00);
	}

	return var_00;
}

//Function Number: 5
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

//Function Number: 6
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

//Function Number: 7
getstat_easy()
{
	var_00 = 1;
	return getstat_progression(var_00);
}

//Function Number: 8
getstat_regular()
{
	var_00 = 2;
	return getstat_progression(var_00);
}

//Function Number: 9
getstat_hardened()
{
	var_00 = 3;
	return getstat_progression(var_00);
}

//Function Number: 10
getstat_veteran()
{
	var_00 = 4;
	return getstat_progression(var_00);
}

//Function Number: 11
getstat_intel()
{
	var_00 = 45;
	var_01 = level.player getlocalplayerprofiledata("cheatPoints") / var_00 * 100;
	return var_01;
}

//Function Number: 12
getlevelcompleted(param_00)
{
	return int(level.player getlocalplayerprofiledata("missionHighestDifficulty")[param_00]);
}

//Function Number: 13
getsolevelcompleted(param_00)
{
	return int(level.player getlocalplayerprofiledata("missionSOHighestDifficulty")[param_00]);
}

//Function Number: 14
setlevelcompleted(param_00)
{
	var_01 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
	var_02 = "";
	for(var_03 = 0;var_03 < var_01.size;var_03++)
	{
		if(var_03 != param_00)
		{
			var_02 = var_02 + var_01[var_03];
			continue;
		}

		if(level.gameskill + 1 > int(var_01[param_00]))
		{
			var_02 = var_02 + level.gameskill + 1;
			continue;
		}

		var_02 = var_02 + var_01[var_03];
	}

	var_04 = "";
	var_05 = 0;
	var_06 = 0;
	for(var_07 = 0;var_07 < var_02.size;var_07++)
	{
		if(int(var_02[var_07]) == 0 || var_05)
		{
			var_04 = var_04 + "0";
			var_05 = 1;
			continue;
		}

		var_04 = var_04 + var_02[var_07];
		var_06++;
	}

	_sethighestmissionifnotcheating(var_06);
	_setmissiondiffstringifnotcheating(var_04);
}

//Function Number: 15
_sethighestmissionifnotcheating(param_00)
{
	if(getdvar("mis_cheat") == "1")
	{
		return;
	}

	level.player setlocalplayerprofiledata("highestMission",param_00);
}

//Function Number: 16
_setmissiondiffstringifnotcheating(param_00)
{
	if(getdvar("mis_cheat") == "1")
	{
		return;
	}

	level.player setlocalplayerprofiledata("missionHighestDifficulty",param_00);
}

//Function Number: 17
getlevelskill(param_00)
{
	var_01 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
	return int(var_01[param_00]);
}

//Function Number: 18
getmissiondvarstring(param_00)
{
	if(param_00 < 9)
	{
		return "mis_0" + param_00 + 1;
	}

	return "mis_" + param_00 + 1;
}

//Function Number: 19
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

//Function Number: 20
createmission(param_00)
{
	var_01 = spawnstruct();
	var_01.levels = [];
	var_01.prereqs = [];
	var_01.hardenedaward = param_00;
	return var_01;
}

//Function Number: 21
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

//Function Number: 22
addprereq(param_00)
{
	var_01 = self.prereqs.size;
	self.prereqs[var_01] = param_00;
}

//Function Number: 23
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

//Function Number: 24
getlevelname(param_00)
{
	return self.levels[param_00].name;
}

//Function Number: 25
getkeepweapons(param_00)
{
	return self.levels[param_00].keepweapons;
}

//Function Number: 26
getachievement(param_00)
{
	return self.levels[param_00].achievement;
}

//Function Number: 27
getlevelveteranaward(param_00)
{
	return self.levels[param_00].veteran_achievement;
}

//Function Number: 28
getfadetime(param_00)
{
	if(!isdefined(self.levels[param_00].fade_time))
	{
		return undefined;
	}

	return self.levels[param_00].fade_time;
}

//Function Number: 29
haslevelveteranaward(param_00)
{
	if(isdefined(self.levels[param_00].veteran_achievement))
	{
		return 1;
	}

	return 0;
}

//Function Number: 30
hasachievement(param_00)
{
	if(isdefined(self.levels[param_00].achievement))
	{
		return 1;
	}

	return 0;
}

//Function Number: 31
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

//Function Number: 32
check_campaign_completion()
{
	var_00 = 0;
	var_01 = 0;
	if(getstat_veteran() >= 100)
	{
		maps\_utility::giveachievement_wrapper("CAMPAIGN_VETERAN");
		var_00 = 1;
		level.player setlocalplayerprofiledata("sp_mpGearUnlocks",0,"1");
	}

	if(getstat_hardened() >= 100 || var_00)
	{
		maps\_utility::giveachievement_wrapper("CAMPAIGN_HARDENED");
		var_01 = 1;
	}

	if(getstat_easy() >= 100 || getstat_regular() >= 100 || var_01)
	{
		maps\_utility::giveachievement_wrapper("CAMPAIGN_COMPLETE");
	}
}

//Function Number: 33
skipssuccess(param_00)
{
	if(!isdefined(self.levels[param_00].skipssuccess))
	{
		return 0;
	}

	return self.levels[param_00].skipssuccess;
}

//Function Number: 34
gethardenedaward()
{
	return self.hardenedaward;
}

//Function Number: 35
hasmissionhardenedaward()
{
	if(isdefined(self.hardenedaward))
	{
		return 1;
	}

	return 0;
}

//Function Number: 36
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

//Function Number: 37
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

//Function Number: 38
clearall()
{
	level.player setlocalplayerprofiledata("missionHighestDifficulty","00000000000000000000000000000000000000000000000000");
	level.player setlocalplayerprofiledata("highestMission",1);
}

//Function Number: 39
credits_end()
{
	changelevel("airplane",0);
}

//Function Number: 40
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