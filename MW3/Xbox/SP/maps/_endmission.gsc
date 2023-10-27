/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_endmission.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 52
 * Decompile Time: 839 ms
 * Timestamp: 10/27/2023 2:33:35 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = [];
	var_00 = createmission("THE_BEST_OF_THE_BEST");
	var_00 addlevel("sp_intro",0,"BACK_IN_THE_FIGHT",1,"THE_BIG_APPLE",0.1);
	var_00 addlevel("sp_ny_manhattan",0,"TOO_BIG_TO_FAIL",1,"THE_BIG_APPLE",undefined);
	var_00 addlevel("sp_ny_harbor",0,"WET_WORK",1,"THE_BIG_APPLE",undefined);
	var_00 addlevel("sp_intro",0,"CARPE_DIEM",1,"OUT_OF_THE_FRYING_PAN",undefined);
	var_00 addlevel("hijack",0,"FREQUENT_FLIER",1,"OUT_OF_THE_FRYING_PAN",undefined);
	var_00 addlevel("sp_warlord",0,"UP_TO_NO_GOOD",1,"OUT_OF_THE_FRYING_PAN",undefined);
	var_00 addlevel("london",1,undefined,1,"EUROPEAN_VACATION",1);
	var_00 addlevel("innocent",0,"ONE_WAY_TICKET",1,"EUROPEAN_VACATION",0.1);
	var_00 addlevel("hamburg",0,"WELCOME_TO_WW3",1,"EUROPEAN_VACATION",undefined);
	var_00 addlevel("sp_payback",0,"SANDSTORM",1,"EUROPEAN_VACATION",undefined);
	var_00 addlevel("sp_paris_a",1,undefined,1,"CITY_OF_LIGHTS",undefined);
	var_00 addlevel("sp_paris_b",0,"BACK_SEAT_DRIVER",1,"CITY_OF_LIGHTS",undefined);
	var_00 addlevel("paris_ac130",0,"WELL_ALWAYS_HAVE_PARIS",1,"CITY_OF_LIGHTS",undefined);
	var_00 addlevel("sp_prague",0,"VIVE_LA_REVOLUTION",1,"THE_DARKEST_HOUR",undefined);
	var_00 addlevel("prague_escape",0,"REQUIEM",1,"THE_DARKEST_HOUR",undefined);
	var_00 addlevel("castle",0,"STORM_THE_CASTLE",1,"THE_DARKEST_HOUR",undefined);
	var_00 addlevel("sp_berlin",0,"BAD_FIRST_DATE",1,"THIS_IS_THE_END",undefined);
	var_00 addlevel("rescue_2",0,"DIAMOND_IN_THE_ROUGH",1,"THIS_IS_THE_END",undefined);
	var_00 addlevel("sp_dubai",0,"WHO_DARES_WINS",1,"THIS_IS_THE_END",undefined);
	if(maps\_utility::is_specialop())
	{
		level.specopsgroups = [];
		for(var_01 = 0;var_01 < 100;var_01++)
		{
			var_02 = tablelookup("sp/specopstable.csv",0,var_01,1);
			if(var_02 != "")
			{
				setupsogroup(var_02);
				continue;
			}

			break;
		}

		var_03 = createmission("SPECIAL_OPS");
		var_04 = int(tablelookup("sp/specopstable.csv",0,"survival_count",1));
		for(var_01 = 100;var_01 < 200;var_01++)
		{
			var_05 = var_01 - 100;
			var_02 = tablelookup("sp/specopstable.csv",0,var_01,1);
			if(var_02 != "")
			{
				var_03 addspecoplevel(var_02,var_05);
				continue;
			}

			break;
		}

		for(var_01 = 200;var_01 < 300;var_01++)
		{
			var_05 = var_01 - 200 + var_04;
			var_02 = tablelookup("sp/specopstable.csv",0,var_01,1);
			if(var_02 != "")
			{
				var_03 addspecoplevel(var_02,var_05);
				continue;
			}

			break;
		}

		level.specopssettings = var_03;
	}

	level.missionsettings = var_00;
}

//Function Number: 2
debug_test_next_mission()
{
	wait 10;
	while(getdvarint("test_next_mission") < 1)
	{
		wait 3;
	}

	_nextmission();
}

//Function Number: 3
setupsogroup(param_00)
{
	level.specopsgroups[param_00] = spawnstruct();
	level.specopsgroups[param_00].ref = param_00;
	level.specopsgroups[param_00].unlock = int(tablelookup("sp/specopstable.csv",1,param_00,5));
}

//Function Number: 4
_nextmission()
{
	if(maps\_utility::func_14F5())
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
	if(level.script == "london")
	{
		game["previous_map"] = "london";
	}
	else
	{
		game["previous_map"] = undefined;
	}

	var_00 = level.missionsettings func_1452(level.script);
	if(level.script == "sp_intro" && !getdvarint("prologue_select"))
	{
		for(var_01 = var_00 + 1;var_01 < level.missionsettings.var_14AA.size - 1;var_01++)
		{
			if(level.missionsettings.var_14AA[var_01].name == "sp_intro")
			{
				var_00 = var_01;
				break;
			}
		}
	}

	setdvar("prologue_select","0");
	maps\_gameskill::auto_adust_zone_complete("aa_main_" + level.script);
	if(!isdefined(var_00))
	{
		missionsuccess(level.script);
		return;
	}

	if(level.script != "sp_dubai")
	{
		maps\_utility::level_end_save();
	}

	level.missionsettings setlevelcompleted(var_00);
	if(level.player getlocalplayerprofiledata("highestMission") < var_00 + 1 && level.script == "sp_dubai" && getdvarint("mis_cheat") == 0)
	{
		setdvar("ui_sp_unlock","0");
		setdvar("ui_sp_unlock","1");
	}

	var_02 = updatesppercent();
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

	if(level.script == "sp_dubai")
	{
		return;
	}

	var_03 = var_00 + 1;
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
			changelevel(level.missionsettings func_151F(var_03),level.missionsettings getkeepweapons(var_00),level.missionsettings getfadetime(var_00));
			return;
		}

		changelevel(level.missionsettings func_151F(var_03),level.missionsettings getkeepweapons(var_00));
		return;
	}

	missionsuccess(level.missionsettings func_151F(var_03),level.missionsettings getkeepweapons(var_00));
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
	for(var_05 = 0;var_05 < level.missionsettings.var_14AA.size - 1;var_05++)
	{
		if(int(var_01[var_05]) >= param_00)
		{
			var_02++;
		}
	}

	var_06 = var_02 / level.missionsettings.var_14AA.size - 1 * 100;
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
func_14B1(param_00)
{
	foreach(var_02 in level.players)
	{
		if(isdefined(var_02.var_14AC) && var_02.var_14AC)
		{
			continue;
		}

		var_03 = var_02 getlocalplayerprofiledata("missionSOHighestDifficulty");
		if(!isdefined(var_03))
		{
			continue;
		}

		if(isdefined(var_02.award_no_stars))
		{
			continue;
		}

		var_04 = 0;
		for(var_05 = 0;var_05 < var_03.size;var_05++)
		{
			var_04 = var_04 + max(0,int(var_03[var_05]) - 1);
		}

		if(var_03.size == 0)
		{
			var_03 = "00000000000000000000000000000000000000000000000000";
		}

		while(param_00 >= var_03.size)
		{
			var_03 = var_03 + "0";
		}

		var_06 = 0;
		if(maps\_utility::is_survival())
		{
			var_06 = 0;
		}
		else
		{
			var_06 = level.specops_reward_gameskill;
			if(isdefined(var_02.var_1507))
			{
				var_06 = var_02.var_1507;
			}
		}

		if(int(var_03[param_00]) > var_06)
		{
			continue;
		}

		var_07 = "";
		for(var_08 = 0;var_08 < var_03.size;var_08++)
		{
			if(var_08 != param_00)
			{
				var_07 = var_07 + var_03[var_08];
				continue;
			}

			var_07 = var_07 + var_06 + 1;
		}

		var_09 = 0;
		for(var_05 = 0;var_05 < var_07.size;var_05++)
		{
			var_09 = var_09 + max(0,int(var_07[var_05]) - 1);
		}

		var_0A = var_09 - var_04;
		if(var_0A > 0)
		{
			var_02.var_1508 = func_150D(var_07);
			var_02.eog_newstar = 1;
			var_02.eog_newstar_value = var_0A;
			foreach(var_0C in level.specopsgroups)
			{
				if(var_0C.unlock == 0)
				{
					continue;
				}

				if(level.ps3 && issplitscreen() && isdefined(level.player2) && var_02 == level.player2)
				{
					continue;
				}

				if(var_04 < var_0C.unlock && var_09 >= var_0C.unlock)
				{
					var_02.eog_unlock = 1;
					var_02.eog_unlock_value = var_0C.ref;
				}
			}

			if(var_09 >= 48)
			{
				var_02.eog_unlock = 1;
				var_02.eog_unlock_value = "so_completed";
				maps\_utility::music_stop(1);
			}
		}

		if(var_02 maps\_specialops_code::func_14A6() || issplitscreen() && level.ps3 && isdefined(level.player2) && var_02 == level.player2)
		{
			var_02 setlocalplayerprofiledata("missionSOHighestDifficulty",var_07);
		}
	}
}

//Function Number: 16
func_150D(param_00)
{
	if(!maps\_utility::is_survival())
	{
		if(int(tablelookup("sp/specOpsTable.csv",1,level.script,14)) == 0)
		{
			return 0;
		}
	}

	var_01 = int(tablelookup("sp/specopstable.csv",0,"survival_count",1));
	var_02 = int(tablelookup("sp/specopstable.csv",0,"mission_count",1));
	var_03 = var_01 + var_02;
	var_04 = 0;
	if(maps\_utility::is_survival())
	{
		for(var_05 = 0;var_05 < var_01;var_05++)
		{
			var_04 = var_04 + int(max(0,int(param_00[var_05]) - 1));
		}
	}
	else
	{
		for(var_05 = var_02;var_05 < var_03;var_05++)
		{
			var_04 = var_04 + int(max(0,int(param_00[var_05]) - 1));
		}
	}

	return var_04 == 1;
}

//Function Number: 17
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
	func_1510(var_04);
}

//Function Number: 18
_sethighestmissionifnotcheating(param_00)
{
	if(getdvar("mis_cheat") == "1")
	{
		return;
	}

	level.player setlocalplayerprofiledata("highestMission",param_00);
}

//Function Number: 19
func_1510(param_00)
{
	if(getdvar("mis_cheat") == "1")
	{
		return;
	}

	level.player setlocalplayerprofiledata("missionHighestDifficulty",param_00);
}

//Function Number: 20
func_1511(param_00)
{
	var_01 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
	return int(var_01[param_00]);
}

//Function Number: 21
getmissiondvarstring(param_00)
{
	if(param_00 < 9)
	{
		return "mis_0" + param_00 + 1;
	}

	return "mis_" + param_00 + 1;
}

//Function Number: 22
getlowestskill()
{
	var_00 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
	var_01 = 4;
	for(var_02 = 0;var_02 < self.var_14AA.size;var_02++)
	{
		if(int(var_00[var_02]) < var_01)
		{
			var_01 = int(var_00[var_02]);
		}
	}

	return var_01;
}

//Function Number: 23
createmission(param_00)
{
	var_01 = spawnstruct();
	var_01.var_14AA = [];
	var_01.var_1515 = [];
	var_01.hardenedaward = param_00;
	return var_01;
}

//Function Number: 24
addlevel(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = self.var_14AA.size;
	self.var_14AA[var_07] = spawnstruct();
	self.var_14AA[var_07].name = param_00;
	self.var_14AA[var_07].keepweapons = param_01;
	self.var_14AA[var_07].achievement = param_02;
	self.var_14AA[var_07].skipssuccess = param_03;
	self.var_14AA[var_07].veteran_achievement = param_04;
	if(isdefined(param_05))
	{
		self.var_14AA[var_07].fade_time = param_05;
	}
}

//Function Number: 25
addspecoplevel(param_00,param_01)
{
	if(isdefined(param_01))
	{
		var_02 = param_01;
	}
	else
	{
		var_02 = self.var_14AA.size;
	}

	self.var_14AA[var_02] = spawnstruct();
	self.var_14AA[var_02].name = param_00;
	var_03 = tablelookup("sp/specopstable.csv",1,param_00,13);
	if(var_03 == "")
	{
		return;
	}

	if(!isdefined(level.specopsgroups[var_03].group_members))
	{
		level.specopsgroups[var_03].group_members = [];
	}

	var_04 = level.specopsgroups[var_03].group_members.size;
	level.specopsgroups[var_03].group_members[var_04] = param_00;
}

//Function Number: 26
addprereq(param_00)
{
	var_01 = self.var_1515.size;
	self.var_1515[var_01] = param_00;
}

//Function Number: 27
func_1452(param_00)
{
	foreach(var_03, var_02 in self.var_14AA)
	{
		if(var_02.name == param_00)
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 28
func_151F(param_00)
{
	return self.var_14AA[param_00].name;
}

//Function Number: 29
getkeepweapons(param_00)
{
	return self.var_14AA[param_00].keepweapons;
}

//Function Number: 30
getachievement(param_00)
{
	return self.var_14AA[param_00].achievement;
}

//Function Number: 31
getlevelveteranaward(param_00)
{
	return self.var_14AA[param_00].veteran_achievement;
}

//Function Number: 32
getfadetime(param_00)
{
	if(!isdefined(self.var_14AA[param_00].fade_time))
	{
		return undefined;
	}

	return self.var_14AA[param_00].fade_time;
}

//Function Number: 33
haslevelveteranaward(param_00)
{
	if(isdefined(self.var_14AA[param_00].veteran_achievement))
	{
		return 1;
	}

	return 0;
}

//Function Number: 34
hasachievement(param_00)
{
	if(isdefined(self.var_14AA[param_00].achievement))
	{
		return 1;
	}

	return 0;
}

//Function Number: 35
check_other_haslevelveteranachievement(param_00)
{
	for(var_01 = 0;var_01 < self.var_14AA.size;var_01++)
	{
		if(var_01 == param_00)
		{
			continue;
		}

		if(!haslevelveteranaward(var_01))
		{
			continue;
		}

		if(self.var_14AA[var_01].veteran_achievement == self.var_14AA[param_00].veteran_achievement)
		{
			if(getlevelcompleted(var_01) < 4)
			{
				return 0;
			}
		}
	}

	return 1;
}

//Function Number: 36
skipssuccess(param_00)
{
	if(!isdefined(self.var_14AA[param_00].skipssuccess))
	{
		return 0;
	}

	return 1;
}

//Function Number: 37
gethardenedaward()
{
	return self.hardenedaward;
}

//Function Number: 38
hasmissionhardenedaward()
{
	if(isdefined(self.hardenedaward))
	{
		return 1;
	}

	return 0;
}

//Function Number: 39
getnextlevelindex()
{
	for(var_00 = 0;var_00 < self.var_14AA.size;var_00++)
	{
		if(!func_1511(var_00))
		{
			return var_00;
		}
	}

	return 0;
}

//Function Number: 40
func_152A()
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

//Function Number: 41
func_152B()
{
	level.player setlocalplayerprofiledata("missionHighestDifficulty","00000000000000000000000000000000000000000000000000");
	level.player setlocalplayerprofiledata("highestMission",1);
}

//Function Number: 42
credits_end()
{
	changelevel("airplane",0);
}

//Function Number: 43
so_eog_summary_calculate(param_00)
{
	if(!isdefined(self.var_128E))
	{
		self.var_128E = [];
	}

	if(!isdefined(level.challenge_start_time))
	{
		level.challenge_start_time = 0;
		level.challenge_end_time = 0;
	}

	var_01 = min(level.challenge_end_time - level.challenge_start_time,86400000);
	var_01 = maps\_utility::round_millisec_on_sec(var_01,1,0);
	foreach(var_03 in level.players)
	{
		var_03.var_128E["time"] = var_01;
		var_03.var_128E["name"] = var_03.playername;
		var_03.var_128E["difficulty"] = var_03 maps\_utility::func_152D();
		if(isdefined(var_03.var_1507))
		{
			var_03.var_128E["difficulty"] = var_03.var_1507;
		}
	}

	level.session_score = 0;
	if(maps\_utility::is_survival())
	{
		foreach(var_03 in level.players)
		{
			var_03.var_128E["score"] = [[ level.so_survival_score_func ]]();
			var_03.var_128E["wave"] = [[ level.so_survival_wave_func ]]();
			var_03.var_128E["kills"] = var_03.game_performance["kill"];
		}

		level.session_score = [[ level.so_survival_score_func ]]();
	}
	else
	{
		var_07 = 300000;
		if(isdefined(level.so_mission_worst_time))
		{
			var_07 = level.so_mission_worst_time;
		}

		var_08 = 0;
		if(var_01 < var_07)
		{
			var_08 = int(var_07 - var_01 / var_07 * 10000);
		}

		level.session_score = int(level.specops_reward_gameskill * 10000) + var_08;
		foreach(var_03 in level.players)
		{
			var_03.var_128E["kills"] = var_03.stats["kills"];
			var_03.var_128E["score"] = level.session_score;
		}
	}

	if(!isdefined(level.custom_eog_no_defaults) || !level.custom_eog_no_defaults)
	{
		foreach(var_03 in level.players)
		{
			if(maps\_utility::func_E89())
			{
				var_03.eog_line = 4;
				continue;
			}

			var_03.eog_line = 3;
		}
	}

	if(isdefined(level.eog_summary_callback))
	{
		[[ level.eog_summary_callback ]]();
	}

	if(param_00)
	{
		common_scripts\utility::flag_set("special_op_final_xp_given");
		foreach(var_03 in level.players)
		{
			var_0E = func_80E0(var_03.var_128E["score"]);
			var_0F = 0;
			if(isdefined(level.var_14AE) && level.var_14AE)
			{
				var_03 thread maps\_utility::func_E86("completion_xp");
				var_0F = maps\_rank::getscoreinfovalue("completion_xp");
			}
			else
			{
				var_10 = undefined;
				var_11 = tablelookup("sp/specOpsTable.csv",1,level.script,9);
				if(isdefined(var_11) && var_11 != "")
				{
					var_10 = var_03 getlocalplayerprofiledata(var_11);
				}

				if(isdefined(var_10) && var_10 == 0 && !maps\_utility::is_survival())
				{
					var_03 thread maps\_utility::func_E86("completion_xp");
					var_0F = maps\_rank::getscoreinfovalue("completion_xp");
				}
			}

			if(!maps\_utility::is_survival())
			{
				var_12 = var_0F + var_0E;
				if(var_03.var_E96["rankxp"] < level.var_80DF)
				{
					if(var_0F != 0)
					{
						var_03 thread maps\_utility::func_128F("@SPECIAL_OPS_UI_XP_COMPLETION_FRIST_TIME","^8+" + var_0F,"@SPECIAL_OPS_UI_XP_COMPLETION","^8+" + var_12);
					}
					else
					{
						var_03 thread maps\_utility::func_128F("@SPECIAL_OPS_UI_XP_COMPLETION","","^8+" + var_12);
					}
				}

				var_03 thread maps\_utility::func_E86("final_score_xp",var_0E);
			}
		}
	}

	if(!isdefined(level.custom_eog_no_defaults) || !level.custom_eog_no_defaults)
	{
		add_eog_default_stats();
	}
}

//Function Number: 44
func_80E0(param_00)
{
	return int(param_00 / 10);
}

//Function Number: 45
so_eog_summary_display()
{
	if(isdefined(level.eog_summary_delay) && level.eog_summary_delay > 0)
	{
		wait level.eog_summary_delay;
	}

	thread maps\_ambient::use_eq_settings("specialop_fadeout",level.eq_mix_track);
	thread maps\_ambient::blend_to_eq_track(level.eq_mix_track,10);
	reset_eog_popup_dvars();
	if(isdefined(level.player.var_1508) && level.player.var_1508)
	{
		setdvar("ui_first_star_player1",level.player.var_1508);
	}

	if(isdefined(level.player.eog_newstar) && level.player.eog_newstar)
	{
		setdvar("ui_eog_player1_stars",level.player.eog_newstar_value);
	}

	if(isdefined(level.player.eog_unlock) && level.player.eog_unlock)
	{
		setdvar("ui_eog_player1_unlock",level.player.eog_unlock_value);
	}

	if(isdefined(level.player.eog_bestscore) && level.player.eog_bestscore)
	{
		setdvar("ui_eog_player1_bestscore",level.player.eog_bestscore_value);
	}

	if(maps\_utility::func_E89())
	{
		if(isdefined(level.player.var_14AC) && level.player.var_14AC)
		{
			setdvar("ui_eog_player1_noreward",level.player.var_14AC);
		}

		if(isdefined(level.player2.var_1508) && level.player2.var_1508)
		{
			setdvar("ui_first_star_player2",level.player2.var_1508);
		}

		if(isdefined(level.player2.eog_newstar) && level.player2.eog_newstar)
		{
			setdvar("ui_eog_player2_stars",level.player2.eog_newstar_value);
		}

		if(isdefined(level.player2.eog_unlock) && level.player2.eog_unlock)
		{
			setdvar("ui_eog_player2_unlock",level.player2.eog_unlock_value);
		}

		if(isdefined(level.player2.var_14AC) && level.player2.var_14AC)
		{
			setdvar("ui_eog_player2_noreward",level.player2.var_14AC);
		}

		if(isdefined(level.player2.eog_bestscore) && level.player2.eog_bestscore)
		{
			setdvar("ui_eog_player2_bestscore",level.player2.eog_bestscore_value);
		}

		wait 0.05;
		level.player openpopupmenu("coop_eog_summary");
		level.player2 openpopupmenu("coop_eog_summary2");
		return;
	}

	wait 0.05;
	level.player openpopupmenu("sp_eog_summary");
}

//Function Number: 46
reset_eog_popup_dvars()
{
	setdvar("ui_eog_player1_stars","");
	setdvar("ui_eog_player1_unlock","");
	setdvar("ui_eog_player1_besttime","");
	setdvar("ui_eog_player1_bestscore","");
	setdvar("ui_eog_player1_noreward","");
	setdvar("ui_eog_player2_stars","");
	setdvar("ui_eog_player2_unlock","");
	setdvar("ui_eog_player2_besttime","");
	setdvar("ui_eog_player2_bestscore","");
	setdvar("ui_eog_player2_noreward","");
}

//Function Number: 47
add_eog_default_stats()
{
	foreach(var_01 in level.players)
	{
		var_01 so_eog_default_playerlabel();
		var_01 func_1534();
		var_01 so_eog_default_time();
		var_01 func_1535();
		if(!level.var_1291)
		{
			var_01 so_eog_default_score();
		}
	}
}

//Function Number: 48
so_eog_default_playerlabel()
{
	if(maps\_utility::func_E89())
	{
		maps\_utility::func_128F("","@SPECIAL_OPS_PERFORMANCE_YOU","@SPECIAL_OPS_PERFORMANCE_PARTNER",undefined,1);
	}
}

//Function Number: 49
func_1534()
{
	var_00 = self.var_128E["kills"];
	if(maps\_utility::func_E89())
	{
		var_01 = maps\_utility::get_other_player(self).var_128E["kills"];
		maps\_utility::func_128F("@SPECIAL_OPS_UI_KILLS",var_00,var_01,undefined,2);
		return;
	}

	maps\_utility::func_128F("@SPECIAL_OPS_UI_KILLS",var_00,undefined,undefined,1);
}

//Function Number: 50
func_1535()
{
	var_00[0] = "@MENU_RECRUIT";
	var_01 = maps\_utility::func_152D();
	maps\_utility::func_128F("@SPECIAL_OPS_UI_DIFFICULTY",var_01,undefined,undefined,2 + int(maps\_utility::func_E89()));
}

//Function Number: 51
so_eog_default_time()
{
	var_00 = self.var_128E["time"] * 0.001;
	var_01 = maps\_utility::convert_to_time_string(var_00,1);
	maps\_utility::func_128F("@SPECIAL_OPS_UI_TIME",var_01,undefined,undefined,3 + int(maps\_utility::func_E89()));
}

//Function Number: 52
so_eog_default_score()
{
	if(maps\_utility::func_E89())
	{
		var_00 = "@SPECIAL_OPS_UI_TEAM_SCORE";
	}
	else
	{
		var_00 = "@SPECIAL_OPS_UI_SCORE";
	}

	var_01 = self.var_128E["score"];
	maps\_utility::func_128F(var_00,var_01);
}