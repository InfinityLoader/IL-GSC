/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_endmission.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 38
 * Decompile Time: 590 ms
 * Timestamp: 10/27/2023 1:39:43 AM
*******************************************************************/

//Function Number: 1
func_4FDD()
{
	var_00 = [];
	var_00 = func_2106();
	var_00 addlevel("prologue",0,"LEVEL_1",1,"EXTRA2",undefined);
	var_00 addlevel("deer_hunt",0,"LEVEL_2",1,"EXTRA2",undefined);
	var_00 addlevel("nml",0,"LEVEL_3",1,"EXTRA2",undefined);
	var_00 addlevel("enemyhq",0,"LEVEL_4",1,"EXTRA2",undefined);
	var_00 addlevel("homecoming",0,"LEVEL_5",1,"EXTRA2",undefined);
	var_00 addlevel("flood",0,"LEVEL_6",1,"EXTRA2",undefined);
	var_00 addlevel("cornered",0,"LEVEL_7",1,"EXTRA2",undefined);
	var_00 addlevel("oilrocks",0,"LEVEL_8",1,"EXTRA2",undefined);
	var_00 addlevel("jungle_ghosts",0,"LEVEL_9",1,"EXTRA2",undefined);
	var_00 addlevel("clockwork",0,"LEVEL_10",1,"EXTRA2",undefined);
	var_00 addlevel("black_ice",0,"LEVEL_11",1,"EXTRA2",undefined);
	var_00 addlevel("ship_graveyard",0,"LEVEL_12",1,"EXTRA2",undefined);
	var_00 addlevel("factory",0,"LEVEL_13",1,"EXTRA2",undefined);
	var_00 addlevel("las_vegas",0,"LEVEL_14",1,"EXTRA2",undefined);
	var_00 addlevel("carrier",0,"LEVEL_15",1,"EXTRA2",undefined);
	var_00 addlevel("satfarm",1,undefined,1,"EXTRA2",undefined);
	var_00 addlevel("satfarm_b",0,"LEVEL_16",1,"EXTRA2",undefined);
	var_00 addlevel("loki",0,"LEVEL_17",1,"EXTRA2",undefined);
	var_00 addlevel("skyway",0,"LEVEL_18",1,"EXTRA2",undefined);
	if(isdefined(level.var_2DDB))
	{
		[[ level.var_2DDB ]]();
		level.var_2DDB = undefined;
	}

	level.var_52F3 = var_00;
}

//Function Number: 2
func_240D()
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
	if(maps\_utility::func_47DC())
	{
		function_0168("ui_nextMission","0");
		if(isdefined(level.var_55F7))
		{
			function_01B9("",0,level.var_55F7);
		}
		else
		{
			function_01B9("",0);
		}
	}

	level notify("nextmission");
	level.var_55F6 = 1;
	level.player method_8291();
	var_00 = undefined;
	function_0168("ui_nextMission","1");
	setdvar("ui_showPopup","0");
	setdvar("ui_popupString","");
	setdvar("ui_prev_map",level.script);
	if(level.script == "prologue")
	{
		level.player setlocalplayerprofiledata("unlockedAliens",1);
	}

	game["previous_map"] = undefined;
	var_00 = level.var_52F3 func_3B0F(level.script);
	if(level.script == "sp_intro" && !getdvarint("prologue_select"))
	{
		for(var_01 = var_00 + 1;var_01 < level.var_52F3.var_4DBC.size - 1;var_01++)
		{
			if(level.var_52F3.var_4DBC[var_01].name == "sp_intro")
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
		function_01BA(level.script);
	}

	if(level.script != "skyway")
	{
		maps\_utility::func_4DA3();
	}

	level.var_52F3 func_7062(var_00);
	var_02 = updatesppercent();
	function_01D2();
	if(level.var_52F3 func_3FF8(var_00))
	{
		maps\_utility::func_3CDA(level.var_52F3 func_3A09(var_00));
	}

	if(level.var_52F3 func_4018(var_00) && getlevelcompleted(var_00) == 4 && level.var_52F3 check_other_haslevelveteranachievement(var_00))
	{
		maps\_utility::func_3CDA(level.var_52F3 func_3B12(var_00));
	}

	if(level.var_52F3 hasmissionhardenedaward() && level.var_52F3 func_3B20() > 2)
	{
		maps\_utility::func_3CDA(level.var_52F3 func_3AC6());
	}

	if(level.script == "skyway")
	{
	}

	var_03 = var_00 + 1;
	if(maps\_utility::func_EBE())
	{
		if(!getdvarint("arcademode_full"))
		{
			function_0168("ui_nextMission","0");
			function_01BA(level.script);
		}
	}

	if(level.var_52F3 func_7585(var_00))
	{
		if(isdefined(level.var_52F3 func_3AA7(var_00)))
		{
			function_01B9(level.var_52F3 func_3B10(var_03),level.var_52F3 func_3AED(var_00),level.var_52F3 func_3AA7(var_00));
		}

		function_01B9(level.var_52F3 func_3B10(var_03),level.var_52F3 func_3AED(var_00));
	}

	function_01BA(level.var_52F3 func_3B10(var_03),level.var_52F3 func_3AED(var_00));
}

//Function Number: 4
updatesppercent()
{
	var_00 = castint(func_3C50() * 100);
	if(getdvarint("mis_cheat") == 0)
	{
		level.player setlocalplayerprofiledata("percentCompleteSP",var_00);
	}

	return var_00;
}

//Function Number: 5
func_3C50()
{
	var_00 = max(getstat_easy(),func_3C10());
	var_01 = 0.5;
	var_02 = func_3C0D();
	var_03 = 0.25;
	var_04 = getstat_veteran();
	var_05 = 0.1;
	var_06 = func_3C0E();
	var_07 = 0.15;
	var_08 = 0;
	var_08 = var_08 + var_01 * var_00;
	var_08 = var_08 + var_03 * var_02;
	var_08 = var_08 + var_05 * var_04;
	var_08 = var_08 + var_07 * var_06;
	return var_08;
}

//Function Number: 6
func_3C0F(param_00)
{
	var_01 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
	var_02 = 0;
	var_03 = [];
	var_04 = 0;
	for(var_05 = 0;var_05 < level.var_52F3.var_4DBC.size - 1;var_05++)
	{
		if(castint(var_01[var_05]) >= param_00)
		{
			var_02++;
		}
	}

	var_06 = var_02 / level.var_52F3.var_4DBC.size - 1 * 100;
	return var_06;
}

//Function Number: 7
getstat_easy()
{
	var_00 = 1;
	return func_3C0F(var_00);
}

//Function Number: 8
func_3C10()
{
	var_00 = 2;
	return func_3C0F(var_00);
}

//Function Number: 9
func_3C0D()
{
	var_00 = 3;
	return func_3C0F(var_00);
}

//Function Number: 10
getstat_veteran()
{
	var_00 = 4;
	return func_3C0F(var_00);
}

//Function Number: 11
func_3C0E()
{
	var_00 = 45;
	var_01 = level.player getlocalplayerprofiledata("cheatPoints") / var_00 * 100;
	return var_01;
}

//Function Number: 12
getlevelcompleted(param_00)
{
	return castint(level.player getlocalplayerprofiledata("missionHighestDifficulty")[param_00]);
}

//Function Number: 13
func_3BEB(param_00)
{
	return castint(level.player getlocalplayerprofiledata("missionSOHighestDifficulty")[param_00]);
}

//Function Number: 14
func_7062(param_00)
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

		if(level.gameskill + 1 > castint(var_01[param_00]))
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
		if(castint(var_02[var_07]) == 0 || var_05)
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
	}

	level.player setlocalplayerprofiledata("highestMission",param_00);
}

//Function Number: 16
_setmissiondiffstringifnotcheating(param_00)
{
	if(getdvar("mis_cheat") == "1")
	{
	}

	level.player setlocalplayerprofiledata("missionHighestDifficulty",param_00);
}

//Function Number: 17
func_3B11(param_00)
{
	var_01 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
	return castint(var_01[param_00]);
}

//Function Number: 18
func_3B2F(param_00)
{
	if(param_00 < 9)
	{
		return "mis_0" + param_00 + 1;
	}

	return "mis_" + param_00 + 1;
}

//Function Number: 19
func_3B20()
{
	var_00 = level.player getlocalplayerprofiledata("missionHighestDifficulty");
	var_01 = 4;
	for(var_02 = 0;var_02 < self.var_4DBC.size;var_02++)
	{
		if(castint(var_00[var_02]) < var_01)
		{
			var_01 = castint(var_00[var_02]);
		}
	}

	return var_01;
}

//Function Number: 20
func_2106(param_00)
{
	var_01 = addstruct();
	var_01.var_4DBC = [];
	var_01.prereqs = [];
	var_01.var_3FBC = param_00;
	return var_01;
}

//Function Number: 21
addlevel(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = self.var_4DBC.size;
	self.var_4DBC[var_07] = addstruct();
	self.var_4DBC[var_07].name = param_00;
	self.var_4DBC[var_07].keepweapons = param_01;
	self.var_4DBC[var_07].achievement = param_02;
	self.var_4DBC[var_07].var_7585 = param_03;
	self.var_4DBC[var_07].var_896F = param_04;
	if(isdefined(param_05))
	{
		self.var_4DBC[var_07].var_314A = param_05;
	}
}

//Function Number: 22
addprereq(param_00)
{
	var_01 = self.prereqs.size;
	self.prereqs[var_01] = param_00;
}

//Function Number: 23
func_3B0F(param_00)
{
	foreach(var_03, var_02 in self.var_4DBC)
	{
		if(var_02.name == param_00)
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 24
func_3B10(param_00)
{
	return self.var_4DBC[param_00].name;
}

//Function Number: 25
func_3AED(param_00)
{
	return self.var_4DBC[param_00].keepweapons;
}

//Function Number: 26
func_3A09(param_00)
{
	return self.var_4DBC[param_00].achievement;
}

//Function Number: 27
func_3B12(param_00)
{
	return self.var_4DBC[param_00].var_896F;
}

//Function Number: 28
func_3AA7(param_00)
{
	if(!isdefined(self.var_4DBC[param_00].var_314A))
	{
		return undefined;
	}

	return self.var_4DBC[param_00].var_314A;
}

//Function Number: 29
func_4018(param_00)
{
	if(isdefined(self.var_4DBC[param_00].var_896F))
	{
		return 1;
	}

	return 0;
}

//Function Number: 30
func_3FF8(param_00)
{
	if(isdefined(self.var_4DBC[param_00].achievement))
	{
		return 1;
	}

	return 0;
}

//Function Number: 31
check_other_haslevelveteranachievement(param_00)
{
	for(var_01 = 0;var_01 < self.var_4DBC.size;var_01++)
	{
		if(var_01 == param_00)
		{
			continue;
		}

		if(!func_4018(var_01))
		{
			continue;
		}

		if(self.var_4DBC[var_01].var_896F == self.var_4DBC[param_00].var_896F)
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
func_7585(param_00)
{
	if(!isdefined(self.var_4DBC[param_00].var_7585))
	{
		return 0;
	}

	return 1;
}

//Function Number: 33
func_3AC6()
{
	return self.var_3FBC;
}

//Function Number: 34
hasmissionhardenedaward()
{
	if(isdefined(self.var_3FBC))
	{
		return 1;
	}

	return 0;
}

//Function Number: 35
getnextlevelindex()
{
	for(var_00 = 0;var_00 < self.var_4DBC.size;var_00++)
	{
		if(!func_3B11(var_00))
		{
			return var_00;
		}
	}

	return 0;
}

//Function Number: 36
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

//Function Number: 37
clearall()
{
	level.player setlocalplayerprofiledata("missionHighestDifficulty","00000000000000000000000000000000000000000000000000");
	level.player setlocalplayerprofiledata("highestMission",1);
}

//Function Number: 38
func_2132()
{
	function_01B9("airplane",0);
}