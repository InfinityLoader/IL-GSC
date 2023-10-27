/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_intel.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 576 ms
 * Timestamp: 10/27/2023 12:20:37 AM
*******************************************************************/

//Function Number: 1
init()
{
	scripts\mp\_intelchallenges::func_DEF9();
	level thread func_C56E();
}

//Function Number: 2
func_C56E()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(!level.rankedmatch)
		{
			return;
		}

		if(!var_00 scripts\mp\_utility::func_DCD5())
		{
			return;
		}

		if(isai(var_00))
		{
			continue;
		}

		var_01 = var_00 getplayerdata("mp","activeMissionTeam");
		var_02 = var_00 getplayerdata("mp","missionTeams",var_01,"activeSlot");
		var_03 = var_00 getplayerdata("mp","missionTeams",var_01,"currentMission",var_02);
		setmatchdata("players",var_00.var_41F0,"activeMissionTeam",var_01);
		setmatchdata("players",var_00.var_41F0,"missionTeamData_activeSlot",var_02);
		setmatchdata("players",var_00.var_41F0,"missionTeamData_currentMission",var_03);
		for(var_04 = 0;var_04 < 5;var_04++)
		{
			var_05 = var_00 getplayerdata("mp","missionTeams",var_01,"currentMission",var_04);
			setmatchdata("players",var_00.var_41F0,"missionTeamData_availableMissions",var_04,var_05);
		}

		var_06 = var_00 getplayerdata("mp","missionTeams",var_01,"level");
		var_07 = var_00 getplayerdata("mp","missionTeams",var_01,"missionXP");
		setmatchdata("players",var_00.var_41F0,"missionTeamData_startLevel",var_06);
		setmatchdata("players",var_00.var_41F0,"missionTeamData_startMissionXP",var_07);
		setmatchdata("players",var_00.var_41F0,"tierComplete",-1);
		var_00.var_B8D4 = var_01;
		var_00 func_8370(var_03,var_01);
	}
}

//Function Number: 3
updatemissionteamperformancestats()
{
	foreach(var_01 in level.players)
	{
		if(!isdefined(var_01) || !var_01 scripts\mp\_utility::func_DCD5())
		{
			continue;
		}

		if(isai(var_01))
		{
			continue;
		}

		var_02 = var_01.var_B8D4;
		var_03 = var_01 getplayerdata("mp","missionTeamPerformanceData",var_02,"matchesPlayed");
		var_01 setplayerdata("mp","missionTeamPerformanceData",var_02,"matchesPlayed",var_03 + 1);
		if(isdefined(var_01.var_9978) && isdefined(var_01.var_9978.var_4C0D))
		{
			if(var_01.var_9978.var_4C0D > 0)
			{
				switch(var_01.var_9978.var_4C0D)
				{
					case 1:
						var_04 = var_01 getplayerdata("mp","missionTeamPerformanceData",var_02,"completed");
						var_01 setplayerdata("mp","missionTeamPerformanceData",var_02,"completed",var_04 + 1);
						break;

					case 2:
						var_05 = var_01 getplayerdata("mp","missionTeamPerformanceData",var_02,"bronze");
						var_01 setplayerdata("mp","missionTeamPerformanceData",var_02,"bronze",var_05 + 1);
						break;

					case 3:
						var_06 = var_01 getplayerdata("mp","missionTeamPerformanceData",var_02,"silver");
						var_01 setplayerdata("mp","missionTeamPerformanceData",var_02,"silver",var_06 + 1);
						break;

					case 4:
						var_07 = var_01 getplayerdata("mp","missionTeamPerformanceData",var_02,"gold");
						var_01 setplayerdata("mp","missionTeamPerformanceData",var_02,"gold",var_07 + 1);
						break;
				}

				continue;
			}

			var_08 = var_01 getplayerdata("mp","missionTeamPerformanceData",var_02,"failed");
			var_01 setplayerdata("mp","missionTeamPerformanceData",var_02,"failed",var_08 + 1);
		}
	}
}

//Function Number: 4
func_AE1D(param_00)
{
	var_01 = func_B02D(param_00);
	if(!isdefined(var_01))
	{
		return undefined;
	}

	var_02 = spawnstruct();
	var_02.var_DE3F = var_01;
	var_02.var_118A7 = [];
	for(var_03 = 0;var_03 < 4;var_03++)
	{
		var_04 = func_B02E(param_00,var_03);
		if(!isdefined(var_04))
		{
			break;
		}

		var_02.var_118A7[var_03]["target"] = var_04;
	}

	var_02.var_4C0D = 0;
	var_02.var_D9D9 = 0;
	return var_02;
}

//Function Number: 5
func_B02D(param_00)
{
	var_01 = tablelookup("mp/intelChallenges.csv",0,param_00,1);
	if(!isdefined(var_01) || var_01 == "")
	{
		return undefined;
	}

	return var_01;
}

//Function Number: 6
func_B02E(param_00,param_01)
{
	var_02 = tablelookup("mp/intelChallenges.csv",0,param_00,5 + param_01 * 2);
	if(!isdefined(var_02) || var_02 == "")
	{
		return undefined;
	}

	return int(var_02);
}

//Function Number: 7
func_8370(param_00,param_01)
{
	var_02 = self.pers["intelChallengeInfo"];
	if(isdefined(var_02))
	{
		var_03 = var_02;
	}
	else
	{
		var_03 = func_AE1D(param_01);
		self setplayerdata("mp","activeMissionComplete",-1);
		var_03.var_B8D4 = param_01;
	}

	if(!isdefined(var_03))
	{
		return;
	}

	self.var_9978 = var_03;
	self thread [[ level.var_9979[var_03.var_DE3F] ]](param_00);
	switch(var_03.var_DE3F)
	{
		case "ch_intel_multiple_weapon_one_life":
		case "ch_intel_kills_this_life":
			thread scripts\mp\_intelchallenges::func_99B9();
			break;
	}

	thread func_BA09();
	func_9884(param_00);
}

//Function Number: 8
func_F75C()
{
	var_00 = self.var_9978;
	if(!isdefined(var_00))
	{
		return;
	}

	self setplayerdata("mp","activeMissionComplete",var_00.var_4C0D);
	setmatchdata("players",self.var_41F0,"tierComplete",var_00.var_4C0D);
	if(var_00.var_4C0D == 0)
	{
		var_01 = self getplayerdata("mp","missionsCompleted");
		self setplayerdata("mp","missionsCompleted",var_01 + 1);
	}

	if(var_00.var_4C0D == var_00.var_118A7.size - 1)
	{
		self notify("intel_max_tier_complete");
	}

	thread scripts\mp\_hud_message::func_10151("intel_completed_" + var_00.var_4C0D + 1 + "_team_" + var_00.var_B8D4);
	var_00.var_4C0D++;
	func_12EB8(var_00.var_4C0D);
}

//Function Number: 9
func_9E94()
{
	if(!isdefined(self.var_9978))
	{
		return 0;
	}

	if(self.var_9978.var_4C0D < self.var_9978.var_118A7.size)
	{
		return 0;
	}

	return 1;
}

//Function Number: 10
func_BA09()
{
	level waittill("round_switch");
	if(isdefined(self.var_9978))
	{
		self.pers["intelChallengeInfo"] = self.var_9978;
	}
}

//Function Number: 11
func_9884(param_00)
{
	if(!func_9E94())
	{
		self setclientomnvar("ui_intel_active_index",param_00);
		self setclientomnvar("ui_intel_current_tier",self.var_9978.var_4C0D);
	}
	else
	{
		var_01 = self.var_9978.var_118A7.size;
		var_02 = self.var_9978.var_118A7[self.var_9978.var_118A7.size - 1]["target"];
		self setclientomnvar("ui_intel_active_index",param_00);
		self setclientomnvar("ui_intel_progress_current",int(var_02));
		self setclientomnvar("ui_intel_current_tier",var_01);
	}

	self setclientomnvar("ui_intel_progress_current",int(self.var_9978.var_D9D9));
}

//Function Number: 12
func_3934()
{
	return scripts\mp\_utility::func_9F19(self);
}

//Function Number: 13
func_12EB7(param_00)
{
	if(!func_3934())
	{
		self.var_9978.var_DB8F = param_00;
		thread func_12EF9();
		return;
	}

	self setclientomnvar("ui_intel_progress_current",int(param_00));
}

//Function Number: 14
func_12EB8(param_00)
{
	if(!func_3934())
	{
		self.var_9978.var_DB90 = param_00;
		thread func_12EF9();
		return;
	}

	self setclientomnvar("ui_intel_current_tier",param_00);
}

//Function Number: 15
func_12EF9()
{
	self endon("disconnect");
	self notify("updateQueuedUIInfoWhenAble()");
	self endon("updateQueuedUIInfoWhenAble()");
	for(;;)
	{
		if(func_3934())
		{
			break;
		}

		wait(0.25);
	}

	if(isdefined(self.var_9978.var_DB8F))
	{
		func_12EB7(self.var_9978.var_DB8F);
		self.var_9978.var_DB8F = undefined;
	}

	if(isdefined(self.var_9978.var_DB90))
	{
		func_12EB8(self.var_9978.var_DB90);
		self.var_9978.var_DB90 = undefined;
	}
}