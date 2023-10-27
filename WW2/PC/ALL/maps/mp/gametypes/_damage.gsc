/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_damage.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 90
 * Decompile Time: 1697 ms
 * Timestamp: 10/27/2023 3:22:47 AM
*******************************************************************/

//Function Number: 1
func_57F3()
{
	if(isdefined(self.var_9566))
	{
		return 1;
	}

	return 0;
}

//Function Number: 2
func_5802()
{
	var_00 = maps\mp\gametypes\_teams::func_2697();
	var_00[self.var_5C62]--;
	var_00[self.var_596B]++;
	return var_00[self.var_596B] - var_00[self.var_5C62] < 2;
}

//Function Number: 3
func_56FA(param_00,param_01)
{
	if(!level.var_984D)
	{
		return 0;
	}

	if(!isdefined(param_01))
	{
		return 0;
	}

	if(!isplayer(param_01) && !isdefined(param_01.var_1A7))
	{
		return 0;
	}

	if(param_00.var_1A7 != param_01.var_1A7)
	{
		return 0;
	}

	if(param_00 == param_01)
	{
		return 0;
	}

	if(isdefined(param_00) && isdefined(param_01) && function_01EF(param_00) && isdefined(param_00.var_A4B) && param_00.var_A4B == "leprechauns")
	{
		return 0;
	}

	return 1;
}

//Function Number: 4
func_8B8B(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(common_scripts\utility::func_562E(param_00.var_3E24))
	{
		return 0;
	}

	if(param_00 method_801D() || param_00 method_82E4() || !param_00 isonground() || param_00 playerparachuteisactive())
	{
		return 0;
	}

	if(isdefined(param_00.var_6857))
	{
		return 0;
	}

	return 1;
}

//Function Number: 5
func_5A44(param_00)
{
	if(!isplayer(param_00))
	{
		return 0;
	}

	if(param_00 != self)
	{
		return 0;
	}

	return 1;
}

//Function Number: 6
func_4AFC()
{
	if(!level.var_984D)
	{
		return;
	}

	if(self.var_596B == "spectator" || !func_5802())
	{
		self thread [[ level.var_6BCE ]]("suicide");
		maps\mp\_utility::func_50E9("suicides",1);
		self.var_94DD = maps\mp\_utility::func_4607("suicides");
	}
}

//Function Number: 7
func_4B08(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_00))
	{
		return;
	}

	if(!isdefined(param_00.var_1A7))
	{
		func_4AF8(param_02,param_03);
		return;
	}

	if((level.var_984D && param_00.var_1A7 != self.var_1A7) || !level.var_984D)
	{
		if(isdefined(level.var_6B5C) && (isplayer(param_00) || function_01EF(param_00)) && param_00.var_1A7 != "spectator")
		{
			[[ level.var_6B5C ]](self,param_00,param_01);
		}
	}
}

//Function Number: 8
func_47B9(param_00)
{
	var_01 = int(max(0,maps\mp\gametypes\_gamescore::func_638(self) - param_00));
	maps\mp\gametypes\_gamescore::func_6D8(self,var_01);
}

//Function Number: 9
func_4AF8(param_00,param_01)
{
	self thread [[ level.var_6BCE ]]("suicide");
	maps\mp\_utility::func_50E9("suicides",1);
	self.var_94DD = maps\mp\_utility::func_4607("suicides");
	if(!maps\mp\_utility::func_773F() && self.var_94DD == 15)
	{
		thread func_2CDF();
	}

	var_02 = maps\mp\gametypes\_tweakables::func_46F7("game","suicidepointloss");
	func_47B9(var_02);
	if(param_00 == "MOD_SUICIDE" && param_01 == "none" && isdefined(self.var_99AC))
	{
		self.var_5BA1 = gettime();
	}

	if(isdefined(level.var_6BB2))
	{
		[[ level.var_6BB2 ]](self);
	}

	if(isdefined(self.var_3EC1))
	{
		self iclientprintlnbold(&"MP_FRIENDLY_FIRE_WILL_NOT");
	}

	self.var_12C["suicideSpawnDelay"] = maps\mp\gametypes\_tweakables::func_46F7("game","suicidespawndelay",1);
}

//Function Number: 10
func_2CDF()
{
	self endon("disconnect");
	level endon("game_ended");
	wait(randomintrange(1,60));
	kick(self getentitynumber());
}

//Function Number: 11
func_4AC3(param_00)
{
	if(function_0367())
	{
		return;
	}

	param_00 thread [[ level.var_6BCE ]]("teamkill");
	param_00.var_12C["teamkills"] = param_00.var_12C["teamkills"] + 1;
	param_00.var_12C["totalTeamKills"] = param_00.var_12C["totalTeamKills"] + 1;
	param_00.var_9857++;
	if(maps\mp\gametypes\_tweakables::func_46F7("team","teamkillpointloss"))
	{
		var_01 = maps\mp\gametypes\_rank::func_4671("kill");
		param_00 func_47B9(var_01);
	}

	var_02 = param_00 maps\mp\gametypes\_playerlogic::func_9856();
	if(var_02 > 0)
	{
		param_00.var_12C["teamKillPunish"] = 1;
		param_00 maps\mp\_utility::func_728();
	}

	var_03 = maps\mp\gametypes\_tweakables::func_46F7("team","teamkillkicklimit");
	if(var_03 > 0)
	{
		var_04 = param_00.var_12C["totalTeamKills"];
		if(var_04 >= var_03)
		{
			thread func_3ED0(param_00);
		}
	}
}

//Function Number: 12
func_3ED0(param_00)
{
	waittillframeend;
	if(!function_0279(param_00))
	{
		kick(param_00 getentitynumber(),"EXE_PLAYERKICKED_TEAMKILL");
	}

	level thread maps\mp\gametypes\_gamelogic::func_A11E();
}

//Function Number: 13
func_4AD8(param_00,param_01,param_02,param_03,param_04)
{
	param_01 thread maps\mp\_events::func_5A40(param_00,self,param_03,param_04,param_02);
	param_01 method_83CB();
	if(maps\mp\_utility::func_5694(param_04))
	{
		lib_0378::func_8D74("snd_mp_player_death");
	}

	if(param_04 == "MOD_HEAD_SHOT")
	{
		param_01 lib_0378::func_8D74("mp_headshot_killer");
		lib_0378::func_8D74("mp_headshot_killed");
	}

	param_01 thread maps\mp\_events::func_5A41(self,param_03,param_04,param_02);
	thread lib_0533::func_3F90();
	var_05 = param_01.var_12C["cur_kill_streak"];
	if(param_01 maps\mp\_utility::func_649("specialty_intelkillsandassists"))
	{
		function_0256(self.var_116,param_01,750);
	}

	if(isalive(param_01))
	{
		if(param_01 maps\mp\_utility::func_649("specialty_boostafterkill"))
		{
			param_01 thread maps\mp\perks\_perkfunctions::handleescalationboostafterkill();
		}

		if(param_01 maps\mp\_utility::func_649("specialty_multikillboost"))
		{
			param_01 thread maps\mp\perks\_perkfunctions::handleclassifiedboostaftermultikillorheadshot(param_04 == "MOD_HEAD_SHOT");
		}

		if(maps\mp\_utility::func_5755(param_04) || param_01 maps\mp\_utility::func_5A54(param_03))
		{
			param_01.var_12C["cur_kill_streak"]++;
			param_01.var_E4 = param_01.var_12C["cur_kill_streak"];
			param_01 notify("kill_streak_increased");
			if(maps\mp\_utility::func_5694(param_04) && param_01 maps\mp\_utility::func_649("specialty_deadeye"))
			{
				param_01.deadeyekillcount++;
			}

			if(maps\mp\_utility::func_F5C() && getdvarint("scorestreak_enabled_v2_rocket") == 1)
			{
				if(param_01 maps\mp\gametypes\_divisions::hasaccesstov2rocket())
				{
					if(!maps\mp\_utility::func_5740(param_03))
					{
						param_01.var_12C["cur_kill_streak_for_nuke"]++;
						var_06 = 25;
						if(param_01 maps\mp\_utility::func_649("specialty_hardline"))
						{
							var_06--;
						}

						if(param_01.var_12C["cur_kill_streak_for_nuke"] == var_06)
						{
							var_07 = param_01 maps\mp\killstreaks\_killstreaks::func_45A5("v2_rocket",0);
							param_01 thread maps\mp\killstreaks\_killstreaks::func_478D("v2_rocket",0,1,param_01);
							param_01 thread maps\mp\gametypes\_hud_message::func_5A78("v2_rocket",var_06,undefined,var_07);
						}
					}
				}
			}
		}

		param_01 maps\mp\_utility::func_8703("longestkillstreak",param_01.var_12C["cur_kill_streak"]);
		if(param_01.var_12C["cur_kill_streak"] > param_01 maps\mp\_utility::func_4607("longestStreak"))
		{
			param_01 maps\mp\_utility::func_86F5("longestStreak",param_01.var_12C["cur_kill_streak"]);
		}

		if(param_01 maps\mp\_utility::_hasexperimentalbtperk("specialty_fightorflight"))
		{
			param_01 thread maps\mp\perks\_perkfunctions::fightorflightregeneratehealth();
		}

		if(param_01 maps\mp\_utility::func_649("specialty_extrascorewhilehealing"))
		{
			param_01 thread maps\mp\perks\_perkfunctions::fasterhealthregenkilltrigger();
		}
	}

	param_01.var_12C["cur_death_streak"] = 0;
	if(param_01.var_12C["cur_kill_streak"] > param_01 maps\mp\gametypes\_persistence::func_9331("round","killStreak"))
	{
		param_01 maps\mp\gametypes\_persistence::func_933A("round","killStreak",param_01.var_12C["cur_kill_streak"]);
	}

	if(param_01 maps\mp\_utility::func_7A69())
	{
		if(param_01.var_12C["cur_kill_streak"] > param_01.var_5A1D)
		{
			param_01 maps\mp\gametypes\_persistence::func_9338("killStreak",param_01.var_12C["cur_kill_streak"]);
			param_01.var_5A1D = param_01.var_12C["cur_kill_streak"];
		}
	}

	var_08 = maps\mp\gametypes\_tweakables::func_46F7("game","deathpointloss");
	func_47B9(var_08);
	level notify("player_got_killstreak_" + param_01.var_12C["cur_kill_streak"],param_01);
	param_01 notify("got_killstreak",param_01.var_12C["cur_kill_streak"]);
	param_01 notify("killed_enemy");
	if(isdefined(level.var_6B5C) && param_01.var_12C["team"] != "spectator")
	{
		[[ level.var_6B5C ]](self,param_01,param_00);
	}

	if(isdefined(self.var_5B6F) && isdefined(self.var_5B70) && self.var_5B6F != param_01)
	{
		if(gettime() - self.var_5B70 < 5000)
		{
			if(level.var_984D)
			{
				self.var_5B6F thread maps\mp\_events::func_774E(self,"assist_riot_shield");
			}
			else
			{
				self.var_5B6F thread maps\mp\_events::func_7751(self,"crossfire_riot_shield");
			}

			if(!isdefined(level.disabledivisionchallenges) || !level.disabledivisionchallenges)
			{
				self.var_5B6F maps\mp\gametypes\_missions::func_7750("ch_grenadier_skill");
			}
		}
	}

	if(!level.var_984D)
	{
		if(isdefined(self.var_1189))
		{
			foreach(var_0A in self.var_1189)
			{
				if(!isdefined(maps\mp\_utility::func_73C(var_0A.var_118A)) || var_0A.var_118A == param_01 || self == var_0A.var_118A)
				{
					continue;
				}

				var_0B = "crossfire_low";
				var_0C = 0;
				foreach(var_0E in var_0A.var_A9DF)
				{
					if(maps\mp\gametypes\_weapons::func_57F6(var_0E))
					{
						var_0C = 1;
						break;
					}
				}

				var_10 = 0;
				if(var_0A.var_118A maps\mp\_utility::func_649("specialty_paint_pro") && isdefined(var_0A.var_118A.var_90DA) && isdefined(self.var_6DEC) && self.var_6DEC)
				{
					if(isdefined(self.paintedattackers) && isdefined(self.paintedattackers[var_0A.var_118A.var_48CA]) && self.paintedattackers[var_0A.var_118A.var_48CA] + var_0A.var_118A.var_90DA * 1000 >= gettime())
					{
						var_10 = 1;
					}
				}

				var_11 = 0;
				if(var_0A.var_118A maps\mp\_utility::func_649("specialty_paint") && isdefined(var_0A.var_118A.var_90DA) && isdefined(self.var_6DEC) && self.var_6DEC)
				{
					if(isdefined(self.paintedexpeditionaryattackers) && isdefined(self.paintedexpeditionaryattackers[var_0A.var_118A.var_48CA]) && self.paintedexpeditionaryattackers[var_0A.var_118A.var_48CA] + var_0A.var_118A.var_90DA * 1000 >= gettime())
					{
						var_11 = 1;
					}
				}

				if(var_11 && var_0A.var_2994 < 60)
				{
					var_0B = "crossfire_painted_expeditionary";
				}
				else if(var_10 && var_0A.var_2994 < 60)
				{
					var_0B = "crossfire_painted";
				}
				else if(var_0C && var_0A.var_2994 < 60)
				{
					var_0B = "crossfire_tactical";
				}
				else if(var_0A.var_2994 >= 40 && var_0A.var_2994 < 60)
				{
					var_0B = "crossfire_mid";
				}
				else if(var_0A.var_2994 >= 60 && var_0A.var_2994 < 80)
				{
					var_0B = "crossfire_high";
				}
				else if(var_0A.var_2994 >= 80)
				{
					var_0B = "crossfire_steal";
				}

				var_0A.var_118A thread maps\mp\_events::func_7751(self,var_0B,var_0A.var_1D0);
				if(var_0A.var_118A maps\mp\_utility::_hasexperimentalbtperk("specialty_fightorflight"))
				{
					var_0A.var_118A thread maps\mp\perks\_perkfunctions::fightorflightregeneratehealth();
				}
			}
		}

		return;
	}

	level thread maps\mp\gametypes\_battlechatter_mp::func_807A(param_01,"kill",0.75);
	if(!maps\mp\_utility::func_5740(param_03))
	{
		var_13["uav"] = [];
		var_13["counter_uav"] = [];
		var_13["advanced_uav"] = [];
		if(isdefined(level.var_9FDA))
		{
			foreach(var_15 in level.var_9FDA[param_01.var_1A7])
			{
				if(!isdefined(var_15.var_117))
				{
					continue;
				}

				if(common_scripts\utility::func_F79(var_13[var_15.var_1C8],var_15.var_117))
				{
					continue;
				}

				var_13[var_15.var_1C8][var_13[var_15.var_1C8].size] = var_15.var_117;
				if(var_15.var_1C8 == "counter_uav")
				{
					if(var_15.var_117 != param_01 && var_15.var_117 maps\mp\_utility::func_649("specialty_killstreaks"))
					{
						var_15.var_117 thread maps\mp\_events::func_774E(self,"assist_counter_uav");
						var_15.var_117 maps\mp\gametypes\_missions::func_7750("ch_career_killstreakassists",10);
					}

					continue;
				}

				if(var_15.var_117 == param_01)
				{
					var_15.var_117 maps\mp\gametypes\_missions::func_7750("ch_streak_actionableintel");
					continue;
				}

				var_15.var_117 thread maps\mp\_events::func_774E(self,"assist_uav");
				var_15.var_117 maps\mp\gametypes\_persistence::incrementscorestreakstat(var_15.var_1C8,"killsOrAssists",1);
				var_15.var_117 maps\mp\gametypes\_missions::func_7750("ch_career_killstreakassists",10);
				var_15.var_117 maps\mp\gametypes\_missions::func_7750("ch_streak_uav",10);
			}
		}

		var_17 = level.var_984D && isdefined(level.var_3CE0) && level.var_3CE0 != param_01 && level.var_3CE0 maps\mp\_utility::func_649("specialty_killstreaks");
		if(var_17)
		{
			level.var_3CE0 thread maps\mp\_events::func_774E(self,"assist_flak_guns");
			level.var_3CE0 maps\mp\gametypes\_missions::func_7750("ch_career_killstreakassists",10);
		}
	}

	if(isdefined(self.var_95B8))
	{
		self.var_95B8 = undefined;
	}

	if((level.var_984D && isdefined(level.var_9852) && level.var_9852[self.var_1A7]) || !level.var_984D && isdefined(level.var_35F6) && level.var_35F6 != self)
	{
		if(isdefined(level.var_35F5) && level.var_35ED && level.var_35F5 != param_01)
		{
			level.var_35F5 thread maps\mp\_events::func_774E(self,"assist_emp");
		}

		maps\mp\_matchdata::logkillstreakassist(level.var_35F5);
	}

	if(isdefined(self.var_1189))
	{
		foreach(var_0A in self.var_1189)
		{
			if(!isdefined(maps\mp\_utility::func_73C(var_0A.var_118A)))
			{
				continue;
			}

			if(var_0A.var_118A == param_01)
			{
				continue;
			}

			if(self == var_0A.var_118A)
			{
				continue;
			}

			if(maps\mp\_utility::func_5740(var_0A.var_1D0) && var_0A.var_1D0 != "killstreak_flak_gun_raids" && var_0A.var_1D0 != "agent_raid_fighters_mp")
			{
				var_0A.var_118A maps\mp\gametypes\_missions::func_7750("ch_career_killstreakassists");
				maps\mp\_matchdata::logkillstreakassist(var_0A.var_118A);
			}

			var_0B = "assist_low";
			var_19 = 0;
			foreach(var_0E in var_0A.var_A9DF)
			{
				if(maps\mp\gametypes\_weapons::func_57F6(var_0E))
				{
					var_19 = 1;
					break;
				}
			}

			var_1C = 0;
			if(var_0A.var_118A maps\mp\_utility::func_649("specialty_paint_pro") && isdefined(var_0A.var_118A.var_90DA) && isdefined(self.var_6DEC) && self.var_6DEC)
			{
				if(isdefined(self.paintedattackers) && isdefined(self.paintedattackers[var_0A.var_118A.var_48CA]) && self.paintedattackers[var_0A.var_118A.var_48CA] + var_0A.var_118A.var_90DA * 1000 >= gettime())
				{
					var_1C = 1;
				}
			}

			var_1D = 0;
			if(var_0A.var_118A maps\mp\_utility::func_649("specialty_paint") && isdefined(var_0A.var_118A.var_90DA) && isdefined(self.var_6DEC) && self.var_6DEC)
			{
				if(isdefined(self.paintedexpeditionaryattackers) && isdefined(self.paintedexpeditionaryattackers[var_0A.var_118A.var_48CA]) && self.paintedexpeditionaryattackers[var_0A.var_118A.var_48CA] + var_0A.var_118A.var_90DA * 1000 >= gettime())
				{
					var_1D = 1;
				}
			}

			if(var_1D && var_0A.var_2994 < 60)
			{
				var_0B = "assist_painted_expeditionary";
			}
			else if(var_1C && var_0A.var_2994 < 60)
			{
				var_0B = "assist_painted";
			}
			else if(var_19 && var_0A.var_2994 < 60)
			{
				var_0B = "assist_tactical";
			}
			else if(var_0A.var_2994 >= 40 && var_0A.var_2994 < 60)
			{
				var_0B = "assist_mid";
			}
			else if(var_0A.var_2994 >= 60 && var_0A.var_2994 < 80)
			{
				var_0B = "assist_high";
			}
			else if(var_0A.var_2994 >= 80)
			{
				var_0B = "assist_steal";
			}

			var_0A.var_118A thread maps\mp\_events::func_774E(self,var_0B,var_0A.var_1D0,var_0A.var_A9DF);
			if(var_0A.var_118A maps\mp\_utility::func_649("specialty_intelkillsandassists"))
			{
				function_0256(self.var_116,var_0A.var_118A,750);
			}

			if(var_0A.var_118A maps\mp\_utility::_hasexperimentalbtperk("specialty_fightorflight"))
			{
				var_0A.var_118A thread maps\mp\perks\_perkfunctions::fightorflightregeneratehealth();
			}
		}
	}
}

//Function Number: 14
func_5785(param_00)
{
	if(function_01AA(param_00) == "non-player")
	{
		return 0;
	}

	if(function_01AA(param_00) == "turret")
	{
		return 0;
	}

	if(function_01D4(param_00) == "primary" || function_01D4(param_00) == "altmode")
	{
		return 1;
	}

	return 0;
}

//Function Number: 15
func_1E6C(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	func_7418(param_00,param_01,self,param_02,param_03,param_04,param_05,param_06,param_07,param_08,0);
}

//Function Number: 16
func_1E6B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self.var_3961 = [];
	self.var_3961["damageTime"] = gettime();
	self.var_3961["damageId"] = param_00 getentitynumber();
	self.var_3961["returnToSender"] = 0;
	self.var_3961["counterKill"] = 0;
	self.var_3961["chainKill"] = 0;
	self.var_3961["cookedKill"] = 0;
	self.var_3961["throwbackKill"] = 0;
	self.var_3961["midAirDetonate"] = 0;
	self.var_3961["suicideGrenadeKill"] = self == param_00;
	self.var_3961["weapon"] = param_04;
}

//Function Number: 17
func_1E64()
{
	self delete();
}

//Function Number: 18
func_5C2D(param_00,param_01)
{
	self method_84D2("none",1);
	maps\mp\_riotshield::func_7E96();
}

//Function Number: 19
func_7418(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	var_0B = param_04;
	var_0C = gettime();
	param_02 endon("spawned");
	param_02 notify("killed_player");
	param_02.var_5D9F = 0;
	if(isdefined(param_04) && param_04 == "MOD_FALLING" && isdefined(param_02) && isdefined(param_02.var_5723) && param_02.var_5723 && isdefined(param_02.var_6E4B))
	{
		param_01 = param_02.var_6E4B;
	}

	if(isdefined(param_01) && isplayer(param_01) && isdefined(param_01.var_3903) && param_01.var_3903 == 1)
	{
		param_01 maps\mp\gametypes\_missions::func_7750("ch_exoability_ping");
	}

	if(isdefined(param_02.waterwakevfxdeletefunc))
	{
		param_02 [[ param_02.waterwakevfxdeletefunc ]]();
	}

	if(isdefined(param_02.var_7682))
	{
		param_02 [[ param_02.var_7682 ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
	}

	param_02 maps\mp\gametypes\_playerlogic::func_7D72();
	param_02.var_83E = 0;
	param_02.var_6F64 = 0;
	param_02.var_83E4 = 0;
	param_01 = maps\mp\_utility::func_73C(param_01);
	if(isdefined(param_01))
	{
		param_01.var_10E9 = undefined;
	}

	if(!isdefined(param_02.var_5033))
	{
		if(param_04 == "MOD_SUICIDE")
		{
			param_02.var_5033 = 0;
		}
		else if(param_04 == "MOD_GRENADE")
		{
			if((issubstr(param_05,"frag_grenade") || issubstr(param_05,"thermobaric_grenade")) && param_03 == 100000)
			{
				param_02.var_5033 = 0;
			}
			else if(param_05 == "v2_rocket_mp")
			{
				param_02.var_5033 = 0;
			}
			else if(level.var_3EC4 >= 2)
			{
				param_02.var_5033 = 0;
			}
			else
			{
			}
		}
	}

	if(param_02 maps\mp\_riotshield::func_4B8C())
	{
		param_02 func_5C2D(param_03,param_04);
	}

	if(!maps\mp\_utility::func_5697(param_04,param_05))
	{
	}

	if(!param_0A)
	{
		if(isdefined(param_02.var_36B9))
		{
			maps\mp\_utility::func_7E50(2);
		}
		else
		{
			maps\mp\_utility::func_7E50(0);
			param_02 thermalvisionoff();
		}
	}
	else
	{
		setfauxdead(param_02,1);
		self notify("death",param_01,param_04,param_05);
	}

	if(game["state"] == "postgame")
	{
		return;
	}

	var_0D = 0;
	if(!isplayer(param_00) && isdefined(param_00.var_7704))
	{
		var_0E = param_00.var_7704;
	}
	else if(isdefined(param_02) && isplayer(param_02) && param_02 getcurrentprimaryweapon() != "none")
	{
		var_0E = param_02 getcurrentprimaryweapon();
	}
	else if(issubstr(param_06,"alt_"))
	{
		var_0E = getsubstr(param_06,4,param_06.size);
	}
	else
	{
		var_0E = undefined;
	}

	if(isdefined(param_02.var_A219) || isdefined(param_02.var_5BEF) && param_04 == "MOD_SUICIDE")
	{
		param_02 func_378E();
		param_02.var_A219 = undefined;
		param_00 = param_02.var_5BEF.var_35A9;
		param_01 = maps\mp\_utility::func_73C(param_02.var_5BEF.var_1180);
		param_03 = param_02.var_5BEF.var_502C;
		param_04 = param_02.var_5BEF.var_8CD7;
		param_05 = param_02.var_5BEF.var_953E;
		var_0E = param_02.var_5BEF.var_912F;
		param_06 = param_02.var_5BEF.var_A2B1;
		param_07 = param_02.var_5BEF.var_8B0A;
		var_0D = gettime() - param_02.var_5BEF.var_5BF4 / 1000;
		param_02.var_5BEF = undefined;
	}

	if((!isdefined(param_01) || !isdefined(param_01.var_3A) || param_01.var_3A == "trigger_hurt" || param_01.var_3A == "worldspawn" || param_01 == param_02) && isdefined(self.var_1193))
	{
		var_0F = undefined;
		foreach(var_11 in self.var_1193)
		{
			if(!isdefined(maps\mp\_utility::func_73C(var_11)))
			{
				continue;
			}

			if(!isdefined(param_02.var_1189[var_11.var_48CA].var_2994))
			{
				continue;
			}

			if(var_11 == param_02 || level.var_984D && var_11.var_1A7 == param_02.var_1A7)
			{
				continue;
			}

			if(param_02.var_1189[var_11.var_48CA].var_5C08 + 2500 < gettime() && param_01 != param_02 && isdefined(param_02.var_E8) && param_02.var_E8)
			{
				continue;
			}

			if(param_02.var_1189[var_11.var_48CA].var_2994 > 1 && !isdefined(var_0F))
			{
				var_0F = var_11;
				continue;
			}

			if(isdefined(var_0F) && param_02.var_1189[var_11.var_48CA].var_2994 > param_02.var_1189[var_0F.var_48CA].var_2994)
			{
				var_0F = var_11;
			}
		}

		if(isdefined(var_0F))
		{
			param_01 = var_0F;
			if(!isdefined(self.var_6E6B) || !self.var_6E6B)
			{
				param_01.var_10E9 = 1;
			}

			param_05 = param_02.var_1189[var_0F.var_48CA].var_1D0;
			param_06 = param_02.var_1189[var_0F.var_48CA].var_A2B1;
			param_07 = param_02.var_1189[var_0F.var_48CA].var_8B0A;
			param_08 = param_02.var_1189[var_0F.var_48CA].var_14A;
			param_04 = param_02.var_1189[var_0F.var_48CA].var_8CD7;
			param_03 = param_02.var_1189[var_0F.var_48CA].var_2994;
			var_0E = param_02.var_1189[var_0F.var_48CA].var_912F;
			param_00 = param_01;
		}
	}
	else if(isdefined(param_01))
	{
		param_01.var_10E9 = undefined;
	}

	if(maps\mp\_utility::func_570A(param_05,param_07,param_04,param_01))
	{
		param_04 = "MOD_HEAD_SHOT";
	}

	if(param_04 == "MOD_HEAD_SHOT" && isdefined(param_06))
	{
	}

	var_13 = func_56FA(param_02,param_01);
	if(isdefined(param_01))
	{
		if(isdefined(param_01.var_3B))
		{
			if(param_01.var_3B == "script_vehicle" && isdefined(param_01.var_117))
			{
				param_01 = param_01.var_117;
			}

			if(param_01.var_3B == "misc_turret" && isdefined(param_01.var_117))
			{
				if(isdefined(param_01.var_A2C8))
				{
					param_01.var_A2C8 notify("killedPlayer",param_02);
				}

				param_01 = param_01.var_117;
			}
		}

		param_02.var_1187 = undefined;
		if(function_01EF(param_01) && isdefined(param_01.var_117))
		{
			if(isdefined(param_01.var_A4B))
			{
				param_02.var_1187 = param_01.var_A4B;
			}

			param_02.var_1186 = param_01 getentitynumber();
			param_01 = param_01.var_117;
			param_05 = "agent_mp";
			param_04 = "MOD_RIFLE_BULLET";
			if(isdefined(param_02.var_1187) && param_02.var_1187 == "bomberEscortFighterAgents")
			{
				param_05 = "agent_raid_fighters_mp";
			}
		}

		if(isdefined(param_01.var_3B) && param_01.var_3B == "script_model" && isdefined(param_01.var_117))
		{
			param_01 = param_01.var_117;
			if(!func_56FA(param_02,param_01) && param_01 != param_02)
			{
				param_01 notify("crushed_enemy");
			}
		}
	}

	if(param_04 != "MOD_SUICIDE" && (maps\mp\_utility::func_5666(param_02) || maps\mp\_utility::func_5666(param_01)) && isdefined(level.var_19D5) && isdefined(level.var_19D5["get_attacker_ent"]))
	{
		var_14 = [[ level.var_19D5["get_attacker_ent"] ]](param_01,param_00);
		if(isdefined(var_14))
		{
			if(maps\mp\_utility::func_5666(param_02))
			{
				param_02 botmemoryevent("death",param_05,var_14.var_116,param_02.var_116,var_14);
			}

			if(maps\mp\_utility::func_5666(param_01))
			{
				var_15 = 1;
				if((var_14.var_3A == "script_vehicle" && isdefined(var_14.var_4C9E)) || var_14.var_3A == "rocket" || var_14.var_3A == "misc_turret")
				{
					var_15 = 0;
				}

				if(var_15)
				{
					param_01 botmemoryevent("kill",param_05,var_14.var_116,param_02.var_116,param_02);
				}
			}
		}
	}

	if(isdefined(param_02.grenadierfrenzy) && param_02.grenadierfrenzy == 1)
	{
		param_02 maps\mp\perks\_perkfunctions::togglegrenadierfrenzy(0);
	}

	var_16 = param_02 getcurrentweapon();
	param_02 thread maps\mp\gametypes\_weapons::func_34A9(param_01,param_04,param_05);
	if(!isdefined(param_02.var_A4F))
	{
		param_02 thread [[ level.var_A9C5 ]](param_01,param_04,param_05);
	}
	else
	{
		param_02.var_A4F thread [[ level.var_A9C5 ]](param_01,param_04,param_05);
	}

	if(!param_0A)
	{
		param_02 maps\mp\_utility::func_A165("dead");
	}

	var_17 = function_02D2(param_02) && isdefined(param_02.var_9566) && param_02.var_9566;
	if(!var_17)
	{
		param_02 maps\mp\gametypes\_playerlogic::func_7CDD();
	}

	if(!isdefined(param_02.var_9566) && !isdefined(level.var_585D) && level.var_585D && !func_56FA(param_02,param_01))
	{
		param_02 maps\mp\_utility::func_50E9("deaths",1);
		param_02 maps\mp\_utility::func_50EA("deaths",1);
		param_02.var_70 = param_02 maps\mp\_utility::func_4607("deaths");
		if(!function_03AF() && !isdefined(level.var_2F8B) && level.var_2F8B && !isdefined(level.disableallplayerstats) && level.disableallplayerstats)
		{
			param_02 maps\mp\_utility::func_A14B("kdRatio","kills","deaths");
			param_02 maps\mp\gametypes\_persistence::func_933A("round","deaths",param_02.var_70);
			param_02 maps\mp\gametypes\_divisions::func_50FC(param_02.var_79,1,"deaths");
		}
	}

	var_18 = maps\mp\_utility::func_5755(param_04) && issubstr(param_05,"bayonet");
	if(!maps\mp\_utility::func_761E() && !level.var_53C7 || !isbot(param_01))
	{
		obituary(param_02,param_01,param_05,param_04,var_18);
	}

	var_19 = 0;
	param_02 func_5EAB(self.var_5CC6,param_01,param_03,param_04,param_05,var_0E,param_07);
	param_02 maps\mp\_matchdata::func_5EA6(1);
	param_02 maps\mp\_matchdata::func_5EA5(self.var_5CC6,param_00,param_01,param_03,param_04,param_05,var_0E,param_07,var_16);
	if(maps\mp\_utility::func_5755(param_04) && isplayer(param_01) && !issubstr(param_05,"riotshield"))
	{
		param_01 maps\mp\_utility::func_50EA("knifekills",1);
	}

	var_1A = 0;
	if(param_02 func_57F3())
	{
		func_4AFC();
	}
	else if((!isplayer(param_01) || isplayer(param_01) && param_04 == "MOD_FALLING") && !isdefined(param_02.var_5723) || !param_02.var_5723)
	{
		func_4B08(param_01,self.var_5CC6,param_04,param_07);
		if(function_01EF(param_01))
		{
			var_19 = 1;
		}

		if(maps\mp\gametypes\_killcam::func_585A(param_00,param_01,param_05))
		{
			var_19 = 1;
		}
	}
	else if(param_01 == param_02 && isdefined(param_00) && !isdefined(param_00.var_576B) || param_00.var_576B == 0)
	{
		func_4AF8(param_04,param_07);
	}
	else if(var_13)
	{
		if(!isdefined(param_02.var_6857))
		{
			func_4AC3(param_01);
		}
	}
	else
	{
		var_19 = 1;
		if(isai(param_02))
		{
			if(isdefined(level.var_19D5) && isdefined(level.var_19D5["should_do_killcam"]))
			{
				var_19 = param_02 [[ level.var_19D5["should_do_killcam"] ]]();
			}
		}

		if(isdefined(param_02.var_1187) && param_02.var_1187 == "bomberEscortFighterAgents")
		{
			var_19 = 0;
		}

		if(isdefined(param_00) && !isdefined(param_00.var_576B) || param_00.var_576B == 0)
		{
			func_4AD8(self.var_5CC6,param_01,param_00,param_05,param_04);
			var_1A = 1;
		}

		param_02.var_12C["cur_death_streak"]++;
		param_01 thread maps\mp\gametypes\_killcam_nemesis::func_A128(param_01,param_02);
		param_02 thread maps\mp\gametypes\_killcam_nemesis::func_A128(param_01,param_02);
	}

	if(isdefined(param_01) && isdefined(param_01.var_10E9) && param_01.var_10E9)
	{
		var_19 = 0;
	}

	param_02 func_A106(self.var_1193,self.var_1189);
	if(!level.var_984D)
	{
		self.var_1193 = [];
	}

	var_1B = 0;
	var_1C = undefined;
	if(isdefined(self.var_76DD))
	{
		var_1B = 1;
		var_1C = self.var_76DD;
		self.var_76DD = undefined;
	}

	if(isplayer(param_01) && param_01 != self && !level.var_984D || level.var_984D && self.var_1A7 != param_01.var_1A7)
	{
		if(var_1B && isdefined(var_1C))
		{
			var_1D = var_1C;
		}
		else
		{
			var_1D = self.var_5B94;
		}

		thread maps\mp\gametypes\_gamelogic::func_9BC0(var_1D,param_04);
		param_01 thread maps\mp\gametypes\_gamelogic::func_9BA0(param_05,param_04,param_00);
	}

	param_02.var_A878 = undefined;
	if(isdefined(param_02.var_9566))
	{
		param_02.var_A878 = 1;
	}

	param_02 func_7D6A();
	param_02.var_E6 = param_01;
	param_02.var_5BAE = param_00;
	if(!isdefined(param_02.var_A4F))
	{
		param_02.var_5B90 = param_02.var_116;
	}
	else
	{
		param_02.var_5B90 = param_02.var_A4F.var_116;
	}

	param_02.var_2AB8 = gettime();
	if(isplayer(param_01) && param_02 != param_01 && (!level.var_984D || level.var_984D && param_02.var_1A7 != param_01.var_1A7) && !isdefined(level.var_5A7D) || !isdefined(level.var_5A7D[param_05]) || param_05 == "flamethrower_mp" || param_05 == "flamethrower_german_mp" || param_05 == "flamethrower_grenadier_mp" || param_05 == "flamethrower_german_grenadier_mp" || param_05 == "killstreak_molotov_cocktail_mp" || param_05 == "killstreak_molotov_cocktail_grenadier_mp")
	{
		var_1E["position"] = param_02.var_5B90;
		var_1E["time"] = param_02.var_2AB8;
		if(level.var_984D)
		{
			level.var_7AD1[param_02.var_1A7][level.var_7AD1[param_02.var_1A7].size] = var_1E;
		}
		else
		{
			var_1E["player"] = self.var_48CA;
			level.var_7AD1["all"][level.var_7AD1["all"].size] = var_1E;
		}
	}

	param_02.var_A7F5 = 0;
	param_02.var_7E54 = 0;
	param_02.var_803E = 0;
	param_02 maps\mp\killstreaks\_killstreaks::func_7D50(0);
	param_02 maps\mp\perks\_perkfunctions::resetspecialistperkstreak();
	var_1F = maps\mp\_awards::func_46EB(param_02) - param_02.var_80A7;
	param_02 maps\mp\_utility::func_8703("mostScorePerLife",var_1F);
	var_20 = undefined;
	if(maps\mp\_utility::func_57B0())
	{
		var_19 = 1;
		param_0A = 0;
		var_20 = self.var_5A2C;
		self waittill("final_rocket_corpse_death");
	}
	else
	{
		if(param_0A)
		{
			var_19 = 0;
			if(!isdefined(param_02.var_A4F))
			{
				param_09 = param_02 playerforcedeathanim(param_00,param_04,param_05,param_07,param_06);
			}
		}

		if(isdefined(param_02.var_4D13) && param_02.var_4D13)
		{
			param_02 method_8003();
			thread maps\mp\gametypes\_deathicons::func_9AA(param_02,param_02,param_02.var_1A7,5,param_01,param_04,param_05);
		}
		else if(param_02 maps/mp/perks/_medic::canspawnmedicpatienttrigger())
		{
			param_02 thread maps/mp/perks/_medic::ondeath_handlemedic();
		}
		else if(!isdefined(param_02.var_A4F))
		{
			param_02.var_18A8 = param_02 method_826D(param_09);
			param_02.var_18A8.var_2685 = param_02.var_2685;
			if(isdefined(param_02.var_5DA9))
			{
				param_02.var_18A8 enablelinkto();
				if(isdefined(param_02.var_5DAA))
				{
					param_02.var_18A8 linkto(param_02.var_5DA9,param_02.var_5DAA);
				}
				else
				{
					param_02.var_18A8 linkto(param_02.var_5DA9);
				}
			}

			var_21 = common_scripts\utility::func_562E(param_02.var_3E19);
			if((var_21 || issubstr(var_0B,"MOD_GRENADE") || issubstr(var_0B,"MOD_EXPLOSIVE") || issubstr(var_0B,"MOD_PROJECTILE")) && isdefined(param_00) && isdefined(param_01))
			{
				if(getdvarint("scr_dismemberment_style",0) == 0 && !function_0367() && getdvarint("isEsportsMatch",0) == 0 && level.var_3FDC != "infect" && maps\mp\_utility::func_4571() != "mp_sandbox_01")
				{
					if(isdefined(param_05) && param_05 != "smoke_grenade_mp" && param_05 != "stun_grenade_mp" && param_05 != "signal_flare_mp" && param_05 != "signal_flare_expeditionary_mp" && param_05 != "tabun_grenade_mp" && param_05 != "carepackage_crate_mp")
					{
						param_02 maps\mp\gametypes\_model_dismemberment::func_4AAB(var_21);
						if(isdefined(param_02.var_65D2) && isdefined(param_02.var_65D1))
						{
							playfxontag(common_scripts\utility::func_44F5(param_02.var_65D2),param_02.var_18A8,param_02.var_65D1);
						}
					}
				}
			}

			if(param_0A)
			{
				param_02 method_8003();
			}

			if(!func_8B8B(param_02))
			{
				param_02.var_18A8 startragdoll();
			}

			if(!isdefined(param_02.var_9566))
			{
				thread maps\mp\gametypes\_deathicons::func_9AA(param_02.var_18A8,param_02,param_02.var_1A7,5,param_01,param_04,param_05);
			}

			thread func_2CEC(param_02.var_18A8,param_07,param_06,param_05,param_00,param_04);
			param_02 notify("corpse_created");
		}
		else if(!isdefined(param_02.var_9566))
		{
			thread maps\mp\gametypes\_deathicons::func_9AA(param_02.var_A4F,param_02,param_02.var_1A7,5,param_01,param_04,param_05);
		}
	}

	if(!maps\mp\_utility::func_570A(param_05,param_07,var_0B,param_01) && !isdefined(param_02.var_6857))
	{
		param_02 maps\mp\_utility::func_7210(var_0B,param_05);
	}

	param_02 thread [[ level.var_6B7B ]](param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,self.var_5CC6);
	if(var_1A)
	{
		param_02 thread maps\mp\gametypes\_missions::func_7417(param_00,param_01,param_03,param_04,param_05,var_0E,param_07,param_01.var_62A1);
	}

	if(isai(param_02) && isdefined(level.var_19D5) && isdefined(level.var_19D5["on_killed"]))
	{
		param_02 thread [[ level.var_19D5["on_killed"] ]](param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,self.var_5CC6);
	}

	if(maps\mp\_utility::func_56FF(param_01))
	{
		var_22 = param_01 getentitynumber();
	}
	else
	{
		var_22 = -1;
	}

	if(isdefined(level.var_585D) && level.var_585D)
	{
		var_22 = -1;
	}

	if(!isdefined(var_20) && isdefined(param_01))
	{
		var_20 = param_02 func_452F(param_01,param_00,param_05);
	}

	var_23 = -1;
	var_24 = 0;
	var_25 = 0;
	if(isdefined(var_20))
	{
		var_23 = var_20 getentitynumber();
		var_24 = var_20.alignx;
		if(isdefined(var_20.var_5A32))
		{
			var_24 = var_20.var_5A32;
			var_25 = 1;
		}

		if(!isdefined(var_24))
		{
			var_24 = 0;
		}
	}
	else if(param_05 == "orbital_laser_fov_mp" && isdefined(param_00) && isdefined(param_00.var_5A32))
	{
		var_24 = param_00.var_5A32;
		var_25 = 1;
	}

	if(common_scripts\utility::func_562E(level.forcenokillcam))
	{
		var_19 = 0;
	}

	if(isdefined(param_01) && isdefined(param_01.var_5BE2))
	{
		var_26 = gettime() - param_01.var_5BE2 / 1000;
	}
	else
	{
		var_26 = 0;
	}

	if(param_04 != "MOD_SUICIDE" && !!isdefined(param_01) || param_01.var_3A == "trigger_hurt" || param_01.var_3A == "worldspawn" || param_01 == param_02 && !common_scripts\utility::func_562E(level.forcenokillcam))
	{
		maps\mp\gametypes\_final_killcam::func_7B32(5,param_02,param_01,var_22,var_23,var_24,param_05,var_0D,param_08,param_04,"normal",var_25);
	}

	if(maps\mp\gametypes\_killcam::func_5A34(param_02,var_19))
	{
		var_27 = maps\mp\gametypes\_playerlogic::func_9A1C(1);
		var_28 = maps\mp\gametypes\_gamelogic::func_9A1B();
		var_29 = maps\mp\gametypes\_killcam::func_5A33(var_24,param_05,0,var_27,var_28,var_25,0);
		var_2A = maps\mp\gametypes\_killcam::func_5A2A(var_29,var_26,var_0D,param_08 / 1000);
		param_02 maps\mp\gametypes\_killcam::func_7681(param_00,param_01,var_2A,var_16);
	}
	else if(maps\mp\_utility::func_5822(param_02.var_2319))
	{
		param_02 maps\mp\gametypes\_playerlogic::func_9455();
	}

	var_2B = gettime() + 5000;
	if(!param_0A)
	{
		wait(0.25);
		if(maps\mp\gametypes\_killcam::func_5A34(param_02,var_19))
		{
			param_02 thread maps\mp\gametypes\_killcam::func_1F41();
			param_02 setclientomnvar("ui_show_skip_killcam",1);
		}

		wait(0.25);
		self.var_7DB7 = gettime() + 1000;
		var_27 = maps\mp\gametypes\_playerlogic::func_9A1C(1);
		if(var_27 < 1)
		{
			var_27 = 1;
		}

		wait(1.5);
		if(isdefined(self.var_9459) && self.var_9459.size > 0)
		{
			while(maps\mp\gametypes\_killcam::func_5A34(param_02,var_19) && isplayer(self) && isplayer(param_01) && !self method_842C(param_01,self.var_9459) && gettime() < var_2B)
			{
				wait 0.05;
			}
		}

		if(common_scripts\utility::func_562E(param_02.onplayerkilledwaitfordeathduration))
		{
			var_2C = gettime() - param_02.var_2AB8;
			if(param_09 > var_2C)
			{
				var_2D = param_09 - var_2C / 1000;
				wait(var_2D);
			}

			param_02.onplayerkilledwaitfordeathduration = undefined;
		}

		var_2E = param_02 method_85E2();
		if(isdefined(var_2E))
		{
			param_02 method_80F4();
		}

		param_02 setclientomnvar("ui_show_skip_killcam",0);
		param_02 notify("death_delay_finished");
	}

	var_2F = gettime() - param_02.var_2AB8 / 1000;
	self.var_7DB7 = gettime();
	var_30 = gettime() >= var_2B;
	if(maps\mp\gametypes\_killcam::func_5A34(param_02,var_19) && !var_30)
	{
		var_31 = !maps\mp\_utility::func_44FC() && !param_02.var_12C["lives"];
		var_27 = maps\mp\gametypes\_playerlogic::func_9A1C(1);
		var_32 = var_31 && var_27 <= 0;
		if(!var_31)
		{
			var_27 = -1;
			level notify("player_eliminated",param_02);
		}

		param_02 maps\mp\gametypes\_killcam::func_5A29(param_00,var_22,var_23,var_24,param_05,var_2F + var_0D,param_08,var_27,maps\mp\gametypes\_gamelogic::func_9A1B(),param_01,param_02,param_04,"normal",var_26,var_25);
	}

	if(isdefined(param_02.var_1187))
	{
		param_02.var_1187 = undefined;
	}

	if(game["state"] != "playing")
	{
		if(!level.var_8C03)
		{
			param_02 maps\mp\_utility::func_A165("dead");
			param_02 maps\mp\_utility::func_23FF();
		}

		return;
	}

	var_33 = maps\mp\_utility::func_44FC();
	var_34 = self.var_12C["lives"];
	if(maps\mp\_utility::func_5822(param_02.var_2319))
	{
		param_02 thread maps\mp\gametypes\_playerlogic::func_9035();
	}
}

//Function Number: 20
func_A798()
{
	self endon("randomSpawnPressed");
	self.var_5998 settext(&"PLATFORM_PRESS_TO_TEAMSPAWN");
	self.var_5998.var_18 = 1;
	self.var_5997 settext(&"PLATFORM_PRESS_TO_RESPAWN");
	self.var_5997.var_18 = 1;
	thread func_A702();
	thread func_A6FD();
	if(isdefined(self.var_8C8A) && self.var_8C8A)
	{
		var_00 = 8;
	}
	else
	{
		var_00 = 9;
	}

	if(isdefined(self.var_9A19))
	{
		var_01 = int(ceil(var_00 - gettime() - self.var_9A19 / 1000));
	}
	else
	{
		var_01 = var_01;
	}

	self.var_6E9D = 0;
	wait(0.5);
	for(var_02 = var_01;var_02 > 0;var_02--)
	{
		maps\mp\_utility::func_86C3("kc_info",&"MP_TIME_TILL_SPAWN",var_01,1,1);
		wait(1);
	}

	self.var_5997.var_18 = 0;
	self.var_5998.var_18 = 0;
	maps\mp\_utility::func_2401("kc_info");
	self notify("abort_fireteam_spawn");
}

//Function Number: 21
func_A6FD()
{
	self endon("disconnect");
	self endon("abort_fireteam_spawn");
	while(self usebuttonpressed())
	{
		wait 0.05;
	}

	while(!self usebuttonpressed())
	{
		wait 0.05;
		if(!maps\mp\_utility::func_57A0(self.var_6E9C))
		{
			break;
		}
	}

	self.var_6E9D = 0;
	self notify("randomSpawnPressed");
	self.var_5997.var_18 = 0;
	self.var_5998.var_18 = 0;
	maps\mp\_utility::func_2401("kc_info");
	self notify("abort_fireteam_spawn");
}

//Function Number: 22
func_A702()
{
	self endon("disconnect");
	self endon("abort_fireteam_spawn");
	while(self attackbuttonpressed())
	{
		wait 0.05;
	}

	while(!self attackbuttonpressed())
	{
		wait 0.05;
	}

	self.var_6E9D = 1;
	self method_8615("copycat_steal_class");
	self notify("teamSpawnPressed");
	self.var_5997.var_18 = 0;
	self.var_5998.var_18 = 0;
}

//Function Number: 23
func_21B7()
{
	if(level.var_2EF3 != 1)
	{
		return 0;
	}

	if(!maps\mp\_utility::func_44FC())
	{
		return 0;
	}

	if(level.var_5DDB[self.var_1A7] > 0)
	{
		return 0;
	}

	foreach(var_01 in level.var_744A)
	{
		if(!isalive(var_01))
		{
			continue;
		}

		if(var_01.var_1A7 != self.var_1A7)
		{
			continue;
		}

		if(var_01 == self)
		{
			continue;
		}

		if(!var_01.var_5378)
		{
			return 0;
		}
	}

	foreach(var_01 in level.var_744A)
	{
		if(!isalive(var_01))
		{
			continue;
		}

		if(var_01.var_1A7 != self.var_1A7)
		{
			continue;
		}

		if(var_01.var_5378 && var_01 != self)
		{
			var_01 func_5BEA(0);
		}
	}

	return 1;
}

//Function Number: 24
func_7D6A()
{
	self.var_5A43 = [];
	self.var_9566 = undefined;
	self.var_596B = undefined;
	self.var_5C62 = undefined;
	self.var_12C["cur_kill_streak"] = 0;
	self.var_12C["cur_kill_streak_for_nuke"] = 0;
	self.var_E4 = 0;
	maps\mp\gametypes\_gameobjects::func_2E46();
}

//Function Number: 25
func_452F(param_00,param_01,param_02)
{
	if(isdefined(param_00.var_2EEC) && param_00.var_2EEC && isdefined(param_00.var_9EDD))
	{
		param_00.var_2EEC = undefined;
		return param_00.var_9EDD.var_5A2C;
	}

	switch(param_02)
	{
		case "war_tripwire_mp":
		case "fighter_strike_plane_grenadier_mp":
		case "fighter_strike_plane_mp":
		case "bouncingbetty_mp":
		case "c4_mp":
		case "flamethrower_german_grenadier_mp":
		case "flamethrower_grenadier_mp":
		case "flamethrower_german_mp":
		case "flamethrower_mp":
		case "azon_projectile_grenadier_mp":
		case "fritzx_projectile_grenadier_mp":
		case "azon_projectile_mp":
		case "fritzx_projectile_mp":
		case "carepackage_crate_mp":
		case "bomb_site_mp":
			if(isdefined(param_01))
			{
				return param_01.var_5A2C;
			}
			break;

		case "agent_raid_fighters_mp":
		case "agent_mp":
			return param_01;

		case "thermite_flames_mp":
		case "firebomb_flames_mp":
			self.var_5A32 = gettime() - 2000;
			return self;

		case "ww2_fighter_bullet_mp":
		case "fighter_strike_gun_mp":
			if(isdefined(param_01) && isdefined(param_01.var_700B))
			{
				return param_01.var_700B.var_5A2C;
			}
			break;

		case "ball_drone_projectile_mp":
		case "ball_drone_gun_mp":
			if(isplayer(param_00) && isdefined(param_00.var_1560) && isdefined(param_00.var_1560.var_9EDD) && isdefined(param_00.var_1560.var_9EDD.var_5A2C))
			{
				return param_00.var_1560.var_9EDD.var_5A2C;
			}
			break;

		case "none":
			if(isdefined(param_01) && isdefined(param_01.var_1A5) && param_01.var_1A5 == "care_package" || param_01.var_1A5 == "rocket_button")
			{
				return param_01.var_5A2C;
			}
			break;
	}

	if(maps\mp\_utility::func_56C4(param_02) || maps\mp\_utility::func_568F(param_02))
	{
		if(isdefined(param_01.var_5A2C) && !param_00 func_118C())
		{
			return param_01.var_5A2C;
		}
		else
		{
			return undefined;
		}
	}

	if(maps\mp\gametypes\_killcam::func_585A(param_01,param_00,param_02))
	{
		if(param_02 == "turretweapon_tank_panzer_cannon_mp_left" || param_02 == "turretweapon_tank_panzer_cannon_mp_right")
		{
			return param_01.var_5A2C;
		}

		return param_00.var_5A2C;
	}

	if(!isdefined(param_01) || param_00 == param_01 && !function_01EF(param_00))
	{
		return undefined;
	}

	return param_01;
}

//Function Number: 26
func_118C()
{
	if(!isdefined(self))
	{
		return 0;
	}

	if(isdefined(level.var_2210) && isdefined(level.var_2210.var_48EA) && self == level.var_2210.var_48EA)
	{
		return 1;
	}

	if(isdefined(self.var_A255) && self.var_A255)
	{
		return 1;
	}

	if(isdefined(self.var_A254) && self.var_A254)
	{
		return 1;
	}

	return 0;
}

//Function Number: 27
func_4DD9(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = [];
	var_05[0] = 2;
	var_05[1] = 3;
	var_05[2] = 5;
	var_05[3] = 7;
	if(!getdvarint("scr_hitloc_debug"))
	{
		return;
	}

	if(!isdefined(param_00.var_4DDA))
	{
		for(var_06 = 0;var_06 < 6;var_06++)
		{
			param_00 setclientdvar("ui_hitloc_" + var_06,"");
		}

		param_00.var_4DDA = 1;
	}

	if(level.var_910F || !isplayer(param_00))
	{
		return;
	}

	var_07 = 6;
	if(!isdefined(param_00.var_29CC))
	{
		param_00.var_29CC = [];
		for(var_06 = 0;var_06 < var_07;var_06++)
		{
			param_00.var_29CC[var_06] = spawnstruct();
			param_00.var_29CC[var_06].var_2994 = 0;
			param_00.var_29CC[var_06].var_4DD8 = "";
			param_00.var_29CC[var_06].var_1B7C = 0;
			param_00.var_29CC[var_06].var_24FB = 0;
		}

		param_00.var_29CD = 0;
		param_00.var_29CE = undefined;
	}

	for(var_06 = var_07 - 1;var_06 > 0;var_06--)
	{
		param_00.var_29CC[var_06].var_2994 = param_00.var_29CC[var_06 - 1].var_2994;
		param_00.var_29CC[var_06].var_4DD8 = param_00.var_29CC[var_06 - 1].var_4DD8;
		param_00.var_29CC[var_06].var_1B7C = param_00.var_29CC[var_06 - 1].var_1B7C;
		param_00.var_29CC[var_06].var_24FB = param_00.var_29CC[var_06 - 1].var_24FB;
	}

	param_00.var_29CC[0].var_2994 = param_02;
	param_00.var_29CC[0].var_4DD8 = param_03;
	param_00.var_29CC[0].var_1B7C = param_04 & level.var_5039;
	if(isdefined(param_00.var_29CE) && param_00.var_29CE != param_01)
	{
		param_00.var_29CD++;
		if(param_00.var_29CD == var_05.size)
		{
			param_00.var_29CD = 0;
		}
	}

	param_00.var_29CE = param_01;
	param_00.var_29CC[0].var_24FB = param_00.var_29CD;
	for(var_06 = 0;var_06 < var_07;var_06++)
	{
		var_08 = "^" + var_05[param_00.var_29CC[var_06].var_24FB];
		if(param_00.var_29CC[var_06].var_4DD8 != "")
		{
			var_09 = var_08 + param_00.var_29CC[var_06].var_4DD8;
			if(param_00.var_29CC[var_06].var_1B7C)
			{
				var_09 = var_09 + " (BP)";
			}

			param_00 setclientdvar("ui_hitloc_" + var_06,var_09);
		}

		param_00 setclientdvar("ui_hitloc_damage_" + var_06,var_08 + param_00.var_29CC[var_06].var_2994);
	}
}

//Function Number: 28
func_5709(param_00)
{
	if(!maps\mp\_utility::func_649("specialty_stun_resistance"))
	{
		return 0;
	}

	switch(param_00)
	{
		case "mp_lab_gas":
		case "killstreak_strike_missile_gas_mp":
			return 1;
	}

	return 0;
}

//Function Number: 29
func_1E69(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(isdefined(param_01) && param_01 != param_02 && isdefined(param_03) && param_03 > 0)
	{
		param_01 notify("has_recently_done_damage");
		if(isdefined(param_01.has_recently_done_damage))
		{
			param_01.has_recently_done_damage++;
		}
		else
		{
			param_01.has_recently_done_damage = 1;
		}
	}

	if(getdvarint("4017",0) && !function_0367())
	{
		return "4017";
	}

	if(function_0367() && isdefined(param_01) && isplayer(param_01) && !maps\mp\gametypes\_weapons::isonevonedamage(param_01,param_02))
	{
		return;
	}

	if(maps\mp\_utility::func_5697(param_05,param_06) && isdefined(param_02) && isdefined(param_02.var_A019) && param_02.var_A019)
	{
		return;
	}

	if(issubstr(param_06,"turretweapon_tank_panzer_cannon_mp") && maps\mp\_utility::func_4571() == "mp_raid_dlc3" && isdefined(param_02) && isdefined(param_02.var_1A7) && isdefined(game["defenders"]) && param_02.var_1A7 == game["defenders"])
	{
		return;
	}

	param_01 = maps\mp\_utility::func_73C(param_01);
	if(level.var_3FDC == "infect")
	{
		if(isdefined(param_01) && isdefined(param_02.var_12C["team"]) && param_02.var_12C["team"] == "allies" && isdefined(param_01.var_12C["team"]) && param_01.var_12C["team"] == "axis")
		{
			if(isdefined(param_01.var_984E) && param_01.var_984E)
			{
				return;
			}
		}
	}

	if(isdefined(param_05) && param_05 == "MOD_CRUSH" && isdefined(param_00) && isdefined(param_00.var_3A) && param_00.var_3A == "script_vehicle")
	{
		return "crushed";
	}

	if(!maps\mp\_utility::func_57A0(param_02) && !isdefined(param_02.var_5379))
	{
		return "!isReallyAlive( victim )";
	}

	if(isdefined(param_01) && isdefined(param_01.var_3A) && param_01.var_3A == "script_origin" && isdefined(param_01.var_1B9) && param_01.var_1B9 == "soft_landing")
	{
		return "soft_landing";
	}

	if(param_06 == "killstreak_emp_mp")
	{
		return "sWeapon == killstreak_emp_mp";
	}

	if(param_06 == "killstreak_air_strike_mp" || param_06 == "killstreak_uav_mp" || param_06 == "killstreak_uav_axis_mp")
	{
		if(isdefined(param_06) && isdefined(param_05) && isdefined(param_01) && isdefined(param_01.var_109) && isdefined(param_02) && isdefined(param_02.var_109))
		{
		}
	}

	if(!maps\mp\_utility::func_585F() && isdefined(param_01) && isdefined(param_01.var_3A) && issubstr(param_01.var_3A,"misc_turret"))
	{
		param_01 = param_01 method_80E2();
	}

	if(param_02 func_5709(param_06))
	{
		return "specialty_stun_resistance";
	}

	if((param_06 == "emp_grenade_mp" || param_06 == "emp_grenade_killstreak_mp") && param_05 != "MOD_IMPACT")
	{
		param_02 notify("emp_grenaded",param_01);
	}

	if(isdefined(level.var_4E09))
	{
		return "level.hostMigrationTimer";
	}

	var_0B = maps\mp\_utility::func_118D(param_02,param_01);
	if(param_05 == "MOD_FALLING")
	{
		param_02 setclientomnvar("ui_fullscreen_dirt_left",1);
	}

	if(param_05 == "MOD_EXPLOSIVE_BULLET" && param_03 != 1)
	{
		param_03 = param_03 * getdvarfloat("scr_explBulletMod");
		param_03 = int(param_03);
	}

	if(isdefined(param_01) && isdefined(param_01.var_3A) && param_01.var_3A == "worldspawn")
	{
		param_01 = undefined;
	}

	if(isdefined(param_01) && isdefined(param_01.var_48EA))
	{
		param_01 = param_01.var_48EA;
	}

	if(isdefined(param_01) && param_01 == param_02 && param_06 == "killstreak_strike_missile_gas_mp")
	{
		return "gasCloudOwner";
	}

	if(isdefined(param_01) && isplayer(param_01) && isexplosivedamagemod(param_05) && issubstr(param_06,"explosive_drone") && param_02 maps\mp\_utility::func_649("specialty_blastshield2") && maps\mp\_utility::func_57A0(param_02))
	{
		param_02.var_3959 = param_01;
	}

	var_0C = isdefined(param_01) && isdefined(param_00) && isdefined(param_02) && isplayer(param_01) && param_01 == param_00 && param_01 == param_02 && !isdefined(param_00.var_754A);
	var_0D = param_06 == "fighter_strike_gun_mp" || maps\mp\_utility::func_5697(param_05,param_06);
	if(var_0C && !var_0D)
	{
		return "attackerIsInflictorVictim";
	}

	var_0E = 0;
	var_0F = "MOD_RIFLE_BULLET MOD_PISTOL_BULLET MOD_HEAD_SHOT";
	if(!function_01EF(self))
	{
		if(isdefined(param_01) && issubstr(var_0F,param_05) && param_03 > 0)
		{
			if(!isdefined(self.var_29A2[param_01 getentitynumber()]))
			{
				self.var_29A2[param_01 getentitynumber()] = spawnstruct();
			}

			if(!isdefined(self.var_29A2[param_01 getentitynumber()].var_6875))
			{
				self.var_29A2[param_01 getentitynumber()].var_6875 = 0;
			}

			self.var_29A2[param_01 getentitynumber()].var_6875++;
		}
	}

	var_10 = undefined;
	if(level.var_3FDC == "onevone")
	{
		level.var_6B14 = gettime();
	}

	var_11 = 0;
	if(isdefined(param_02.var_5D2E))
	{
		var_11 = 1;
	}

	if(param_04 & level.var_5040)
	{
		var_0E = 0;
		param_03 = 0;
	}
	else if(param_09 == "shield")
	{
		var_10 = "hitriotshield";
		if(var_0B && level.var_3EC4 == 0)
		{
			return "attackerIsHittingTeammate";
		}

		if(!var_0B && isdefined(param_02) && isdefined(param_03) && function_02A2(param_03) && issubstr(param_02 getcurrentweapon(),"riotshield_mp"))
		{
			if(!isdefined(param_02.var_12C["riotshield_dmg_taken"]))
			{
				param_02.var_12C["riotshield_dmg_taken"] = 0;
			}

			param_02.var_12C["riotshield_dmg_taken"] = param_02.var_12C["riotshield_dmg_taken"] + param_03;
			if(param_02.var_12C["riotshield_dmg_taken"] > 400)
			{
				param_02 maps\mp\_events::riotshielddamagetakenevent();
				param_02.var_12C["riotshield_dmg_taken"] = 0;
			}
		}

		if(param_05 == "MOD_PISTOL_BULLET" || param_05 == "MOD_RIFLE_BULLET" || param_05 == "MOD_EXPLOSIVE_BULLET" && !var_0B)
		{
			if(isplayer(param_01) && isdefined(param_02) && issubstr(param_02 getcurrentweapon(),"riotshield_mp"))
			{
				param_01.var_5B6F = param_02;
				param_01.var_5B70 = gettime();
			}

			if(maps\mp\_utility::func_56DF(param_06))
			{
				var_12 = 25;
			}
			else
			{
				var_12 = maps\mp\perks\_perks::func_1E13(param_03,param_02,param_04,param_06,param_07,param_08,param_09,param_0A);
			}

			param_02.var_8AFE = param_02.var_8AFE + var_12;
			if(!maps\mp\_utility::func_56DF(param_06) || common_scripts\utility::func_24A6())
			{
				param_02.var_8AFD++;
				if(isdefined(param_02.var_12C["bulletsBlockedByShield"]))
				{
					param_02.var_12C["bulletsBlockedByShield"]++;
				}
			}

			if(param_02.var_8AFD >= level.var_7EA4)
			{
				param_02.var_8AFE = 0;
				param_02.var_8AFD = 0;
			}
		}

		if(param_04 & level.var_503D || param_05 == "MOD_IMPACT" && issubstr(param_06,"grenade_launcher") && issubstr(param_06,"alt+"))
		{
			param_09 = "none";
			if(!param_04 & level.var_503E)
			{
				if(getdvarint("spv_cavalryImpactExplosivesBlocked_enabled",0) == 1)
				{
					param_03 = 51;
				}
			}
		}
		else if(param_04 & level.var_503F)
		{
			if((isdefined(param_00) && isdefined(param_00.var_9488) && param_00.var_9488 == param_02) || issubstr(param_06,"explosive_tips_dp28"))
			{
				param_03 = 150;
			}

			param_09 = "none";
		}
		else
		{
			param_01 thread maps\mp\gametypes\_damagefeedback::func_A102("hitriotshield");
			return "hit shield";
		}
	}
	else if(maps\mp\_utility::func_5755(param_05))
	{
		if(!var_0B && level.var_3EC4 == 0)
		{
			if(issubstr(param_06,"riotshield"))
			{
				var_0E = 0;
				param_02 stunplayer(0);
			}
		}

		if(function_0367() && isdefined(param_01.var_572A) && param_01.var_572A && isdefined(param_01.current1v1weaponmode) && param_01.current1v1weaponmode == 1)
		{
			param_03 = 110;
		}

		if(function_0367() && isdefined(param_02) && isdefined(param_01) && isdefined(param_02.var_5692) && param_02.var_5692 && isdefined(param_01.var_5692) && param_01.var_5692 && isdefined(param_02.var_34D2) && isdefined(param_01.var_34D2) && param_02.var_34D2 == param_01 && param_01.var_34D2 == param_02)
		{
			if(param_02.var_BC - param_03 <= 0)
			{
				param_02 shellshock("frag_grenade_mp",2.5);
				param_02 playrumbleonentity("artillery_rumble");
			}
			else if(param_03 > 30)
			{
				param_02 shellshock("frag_grenade_mp",1.25);
				param_02 playrumbleonentity("heavygun_fire");
			}
			else
			{
				param_02 shellshock("frag_grenade_mp",0.75);
				param_02 playrumbleonentity("damage_heavy");
			}
		}
	}

	if(param_06 == "bouncingbetty_mp")
	{
		var_13 = param_02 getstance();
		switch(var_13)
		{
			case "prone":
				param_03 = param_03 * 0.25;
				break;

			case "crouch":
				param_03 = param_03 * 0.55;
				break;

			default:
				break;
		}
	}

	if(isdefined(param_01) && param_01 == param_02 && param_06 == "teslagunmtx_mp")
	{
		param_03 = param_03 * 0.5;
	}

	if(!var_0B)
	{
		param_03 = maps\mp\perks\_perks::func_1E13(param_02,param_01,param_03,param_05,param_06,param_07,param_08,param_09,param_00);
	}
	else if(isexplosivedamagemod(param_05) || param_05 == "MOD_GAS")
	{
		if(param_02 maps\mp\_utility::func_649("specialty_blastshield2") && isdefined(param_02.var_90D4) && !maps\mp\gametypes\_weapons::func_57F6(param_06) && !maps\mp\perks\_perks::func_3154(param_06))
		{
			param_03 = int(param_03 * param_02.var_90D4);
		}
	}
	else if(maps\mp\_utility::func_5697(param_05,param_06))
	{
		if(param_02 maps\mp\_utility::func_649("specialty_fireshield") && isdefined(param_02.var_90D8))
		{
			param_03 = int(param_03 * param_02.var_90D8);
		}
	}

	if(isdefined(level.var_62AD))
	{
		param_03 = [[ level.var_62AD ]](param_02,param_00,param_01,param_03,param_05,param_06,param_07,param_08,param_09,undefined);
	}

	var_14 = isdefined(param_01) && !isdefined(param_01.var_48EA) && isdefined(param_01.var_3A) && param_01.var_3A == "script_vehicle" || param_01.var_3A == "misc_turret" || param_01.var_3A == "script_model";
	var_0B = maps\mp\_utility::func_118D(param_02,param_01);
	if(!param_03)
	{
		return "!iDamage";
	}

	param_02.var_5033 = param_04;
	param_02.var_5041 = gettime();
	if(game["state"] == "postgame")
	{
		return "game[ state ] == postgame";
	}

	if(param_02.var_179 == "spectator")
	{
		return "victim.sessionteam == spectator";
	}

	if(isdefined(param_02.var_1F4D) && !param_02.var_1F4D)
	{
		return "!victim.canDoCombat";
	}

	if(isdefined(param_01) && isplayer(param_01) && isdefined(param_01.var_1F4D) && !param_01.var_1F4D)
	{
		return "!eAttacker.canDoCombat";
	}

	if(isdefined(param_01) && isalive(param_01) && !isdefined(param_01.var_6F64))
	{
		param_01.var_6F64 = 0;
	}

	if(var_14 && var_0B)
	{
		if(param_05 == "MOD_CRUSH")
		{
			param_02 maps\mp\_utility::func_728();
			return "suicide crush";
		}

		if(!level.var_3EC4)
		{
			return "!level.friendlyfire";
		}
	}

	if(isai(self))
	{
		self [[ level.var_19D5["on_damaged"] ]](param_01,param_03,param_05,param_06,param_00,param_09);
	}

	if(!isdefined(param_08))
	{
		param_04 = param_04 | level.var_5035;
	}

	var_15 = 0;
	if((param_02.var_BC == param_02.var_FB && !isdefined(param_02.var_E8) || !param_02.var_E8) || !isdefined(param_02.var_1193) && !isdefined(param_02.var_E8))
	{
		param_02.var_1193 = [];
		param_02.var_1189 = [];
	}

	if(maps\mp\_utility::func_570A(param_06,param_09,param_05,param_01))
	{
		param_05 = "MOD_HEAD_SHOT";
	}

	if(maps\mp\gametypes\_tweakables::func_46F7("game","onlyheadshots"))
	{
		if(param_05 == "MOD_PISTOL_BULLET" || param_05 == "MOD_RIFLE_BULLET" || param_05 == "MOD_EXPLOSIVE_BULLET")
		{
			return "getTweakableValue( game, onlyheadshots )";
		}
		else if(param_05 == "MOD_HEAD_SHOT")
		{
			param_03 = 150;
		}
	}

	if(maps\mp\_utility::func_5755(param_05) && isplayer(param_02) && param_02 getstance() == "prone")
	{
		param_03 = 150;
	}

	if(param_06 == "none" && isdefined(param_00))
	{
		if(isdefined(param_00.var_75) && issubstr(param_00.var_75,"vehicle_"))
		{
			param_06 = "destructible_car";
		}
	}

	if(isdefined(level.var_5CC7) && isdefined(level.var_5CC7[param_02.var_5CC6]) && gettime() < level.var_5CC7[param_02.var_5CC6] + level.var_5A77)
	{
		var_16 = int(max(param_02.var_BC / 4,1));
		if(param_03 >= var_16 && maps\mp\_utility::func_5740(param_06) && !maps\mp\_utility::func_5755(param_05))
		{
			param_03 = var_16;
			if(param_06 == "firebomb_flames_mp")
			{
				param_03 = 2;
			}
		}
	}

	if(!param_04 & level.var_5036)
	{
		if(!level.var_984D && var_14 && isdefined(param_01.var_117) && param_01.var_117 == param_02)
		{
			if(param_05 == "MOD_CRUSH")
			{
				param_02 maps\mp\_utility::func_728();
			}

			return "ffa suicide";
		}

		if((issubstr(param_05,"MOD_GRENADE") || issubstr(param_05,"MOD_EXPLOSIVE") || issubstr(param_05,"MOD_PROJECTILE")) && isdefined(param_00) && isdefined(param_01))
		{
			if(param_02 != param_01 && param_00.var_3A == "grenade" && param_02.var_5BE2 + 3500 > gettime() && isdefined(param_02.var_5BE0) && distance(param_00.var_116,param_02.var_5BE0.var_116) < 250)
			{
				return "spawnkill grenade protection";
			}

			param_02.var_3961 = [];
			param_02.var_3961["damageTime"] = gettime();
			param_02.var_3961["damageId"] = param_00 getentitynumber();
			param_02.var_3961["returnToSender"] = 0;
			param_02.var_3961["counterKill"] = 0;
			param_02.var_3961["chainKill"] = 0;
			param_02.var_3961["cookedKill"] = 0;
			param_02.var_3961["throwbackKill"] = 0;
			param_02.var_3961["suicideGrenadeKill"] = 0;
			param_02.var_3961["midAirDetonate"] = 0;
			param_02.var_3961["weapon"] = param_06;
			var_17 = issubstr(param_06,"frag_");
			if(param_01 != param_02)
			{
				if((issubstr(param_06,"c4_") || issubstr(param_06,"claymore_")) && isdefined(param_01) && isdefined(param_00.var_117))
				{
					param_02.var_3961["returnToSender"] = param_00.var_117 == param_02;
					param_02.var_3961["counterKill"] = isdefined(param_00.var_A86E);
					param_02.var_3961["chainKill"] = isdefined(param_00.var_A86B);
					param_02.var_3961["bulletPenetrationKill"] = isdefined(param_00.var_A86F);
					param_02.var_3961["cookedKill"] = 0;
				}

				if(isdefined(param_01.var_5BA1) && param_01.var_5BA1 >= gettime() - 50 && var_17)
				{
					param_02.var_3961["suicideGrenadeKill"] = 1;
				}

				if(var_17)
				{
					param_02.var_3961["cookedKill"] = isdefined(param_00.var_56B8);
					param_02.var_3961["throwbackKill"] = isdefined(param_00.var_999E);
				}
			}

			param_02.var_3961["stickKill"] = isdefined(param_00.var_57E6) && param_00.var_57E6 == "enemy";
			param_02.var_3961["stickFriendlyKill"] = isdefined(param_00.var_57E6) && param_00.var_57E6 == "friendly";
			if(isdefined(param_00) && param_00.var_3A == "grenade" && !isdefined(param_00.missile_stuck))
			{
				var_18 = bullettrace(param_00.var_116,param_00.var_116 - (0,0,100),0,param_00);
				if(param_00.var_116[2] > var_18["position"][2] + 5)
				{
					param_02.var_3961["midAirDetonate"] = 1;
				}
			}

			if(isplayer(param_01) && param_01 != self)
			{
				maps\mp\gametypes\_gamelogic::func_86B0(param_00,param_01,param_06);
			}
		}

		if(issubstr(param_05,"MOD_IMPACT") && issubstr(param_06,"gl"))
		{
			if(isplayer(param_01) && param_01 != self)
			{
				maps\mp\gametypes\_gamelogic::func_86B0(param_00,param_01,param_06);
			}
		}

		if(isplayer(param_01) && isdefined(param_01.var_12C["participation"]))
		{
			param_01.var_12C["participation"]++;
		}
		else if(isplayer(param_01))
		{
			param_01.var_12C["participation"] = 1;
		}

		if(var_0B)
		{
			if(function_0367())
			{
				if((isdefined(param_01.var_4E03) && isdefined(param_02.var_4E03) && common_scripts\utility::func_F79(param_01.var_4E03,param_02) && common_scripts\utility::func_F79(param_02.var_4E03,param_01)) || param_01 == param_02 && isdefined(param_01.var_5729) && param_01.var_5729)
				{
					if(param_03 < 1)
					{
						param_03 = 1;
					}

					if(isdefined(param_01.var_34D2) && param_01.var_34D2 == param_02)
					{
						if(param_02.var_BC - param_03 <= 0)
						{
							param_03 = param_02.var_BC - 1;
							param_02 notify("lostDuel");
						}
						else
						{
							param_02 notify("updateDuelHealthDisplay");
						}
					}

					param_02 func_3BAC(param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,var_0E);
					if(isdefined(param_01) && param_01 != param_02 && isdefined(param_09))
					{
						if(!maps\mp\_utility::func_57A0(param_02))
						{
							if(maps\mp\_utility::func_5755(param_05))
							{
								var_19 = "killshot_nosound";
							}
							else if(param_0A == "head")
							{
								var_19 = "killshot_headshot";
							}
							else
							{
								var_19 = "killshot";
							}
						}
						else if(isdefined(var_11))
						{
							var_19 = var_11;
						}
						else if(maps\mp\_utility::func_5755(param_06))
						{
							var_19 = "standard_nosound";
						}
						else if(param_0A == "head")
						{
							var_19 = "headshot";
						}
						else if(param_04 < function_02F9(maps\mp\_utility::func_4431(param_07)))
						{
							var_19 = "minor";
						}
						else if(!func_8BB3(param_07))
						{
							var_19 = "none";
						}
						else
						{
							var_19 = "standard";
						}

						param_01 thread maps\mp\gametypes\_damagefeedback::func_A102(var_19);
					}

					return;
				}
			}

			if(level.var_3EC4 == 0 || (!isplayer(param_01) && level.var_3EC4 != 1) || shouldignorefriendlyfireforhardcore(param_06,param_01))
			{
				if(param_06 == "artillery_mp" || param_06 == "airstrike_bomb_mp" || param_06 == "airstrike_bomb_axis_mp" || param_06 == "firebomb_bomb_mp" || param_06 == "firebomb_bomb_axis_mp" || param_06 == "firebomb_bomb_grenadier_mp" || param_06 == "firebomb_bomb_axis_grenadier_mp")
				{
					param_02 func_29DC(param_00,param_06,param_05,param_03,param_04,param_01);
				}

				return "friendly fire";
			}
			else if(level.var_3EC4 == 1)
			{
				if(param_03 < 1)
				{
					param_03 = 1;
				}

				param_02.var_5B8D = 0;
				param_02 func_3BAC(param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,var_0E);
			}
			else if(level.var_3EC4 == 2 && maps\mp\_utility::func_57A0(param_01))
			{
				param_03 = int(param_03 * 0.5);
				if(param_03 < 1)
				{
					param_03 = 1;
				}

				param_01.var_5B8D = 0;
				param_01.var_3EC1 = 1;
				param_01 func_3BAC(param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,var_0E);
				param_01.var_3EC1 = undefined;
			}
			else if(level.var_3EC4 == 3 && maps\mp\_utility::func_57A0(param_01))
			{
				param_03 = int(param_03 * 0.5);
				if(param_03 < 1)
				{
					param_03 = 1;
				}

				param_02.var_5B8D = 0;
				param_01.var_5B8D = 0;
				param_02 func_3BAC(param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,var_0E);
				if(maps\mp\_utility::func_57A0(param_01))
				{
					param_01.var_3EC1 = 1;
					param_01 func_3BAC(param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,var_0E);
					param_01.var_3EC1 = undefined;
				}
			}

			var_15 = 1;
		}
		else
		{
			if(param_03 < 1 && !function_0367())
			{
				param_03 = 1;
			}

			if(function_0367() && isdefined(param_01) && isdefined(param_02) && param_01 == param_02 && isdefined(param_01.var_5721) && param_01.var_5721)
			{
				param_03 = 0;
			}

			func_5E8A(param_02,param_01,param_00,param_06,param_03,param_07,param_08,param_09,param_0A,param_05);
			if(issubstr(param_05,"MOD_GRENADE") && isdefined(param_00) && isdefined(param_00.var_56B8))
			{
				param_02.var_A86D = gettime();
			}
			else
			{
				param_02.var_A86D = undefined;
			}

			if(issubstr(param_05,"MOD_IMPACT") && isdefined(param_00) && isdefined(param_00.var_7ACE) && param_00.var_7ACE)
			{
				param_02.var_A876 = 1;
			}
			else
			{
				param_02.var_A876 = 0;
			}

			param_02.var_5B8D = isdefined(param_01) && param_01 != param_02;
			if(param_02.var_5B8D)
			{
				var_1A = gettime();
				param_01.var_29BD[param_02.var_48CA] = var_1A;
				param_02.var_5B8A = var_1A;
			}

			param_02 func_3BAC(param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,var_0E);
			param_02 thread maps\mp\gametypes\_missions::func_73CC(param_00,param_01,param_03,param_05,param_06,param_09);
		}

		if(!maps\mp\_utility::func_57A0(param_02))
		{
			if((issubstr(param_05,"MOD_GRENADE") || issubstr(param_05,"MOD_EXPLOSIVE") || issubstr(param_05,"MOD_PROJECTILE")) && isdefined(param_00) && isdefined(param_01))
			{
				param_02 maps\mp\gametypes\_model_dismemberment::func_2E43(param_08);
			}

			if(isdefined(param_02.var_5B8D) && param_02.var_5B8D)
			{
				level notify("normal_enemy_kill");
			}
		}

		if(var_14 && isdefined(param_01.var_48EA))
		{
			var_1B = param_01.var_48EA;
		}
		else
		{
			var_1B = param_02;
		}

		var_1C = undefined;
		if(isdefined(var_1B))
		{
			var_1C = var_1B method_85E2();
		}

		if(isdefined(var_1B) && (var_1B != param_02 || maps\mp\_utility::func_5740(param_06)) && param_03 > 0 && !isdefined(param_09) || param_09 != "shield")
		{
			if(!maps\mp\_utility::func_57A0(param_02) || function_01EF(param_02) && isdefined(param_02.var_A4B) && param_02.var_A4B == "paratroopers" && param_02.var_BC - param_03 <= 0)
			{
				if(maps\mp\_utility::func_5755(param_05))
				{
					var_19 = "killshot_nosound";
				}
				else if(isdefined(param_07) && issubstr(param_07,"throwingknife_mp"))
				{
					var_19 = "throwingknife";
				}
				else if(param_0A == "head")
				{
					var_19 = "killshot_headshot";
				}
				else
				{
					var_19 = "killshot";
				}
			}
			else if(isdefined(var_11))
			{
				var_19 = var_11;
			}
			else if(level.var_3FDC == "br")
			{
				var_19 = "hitmorehealth";
			}
			else if(common_scripts\utility::func_562E(param_03.var_4B97))
			{
				var_19 = "hitlightarmor";
			}
			else if(maps\mp\_utility::func_5755(param_06))
			{
				var_19 = "standard_nosound";
			}
			else if(param_05 & level.var_5040)
			{
				var_19 = "stun";
			}
			else if(maps\mp\_utility::func_5694(param_06) && param_03 maps\mp\_utility::func_649("specialty_armorvest"))
			{
				var_19 = "hitjuggernaut";
			}
			else if(maps\mp\_utility::func_5694(param_06) && isdefined(param_03.var_4B9A) && param_03.var_4B9A)
			{
				var_19 = "hitjuggernaut";
			}
			else if(isexplosivedamagemod(param_06) && isdefined(param_03.var_4B64) && param_03.var_4B64)
			{
				var_19 = "hitlightarmor";
			}
			else if(maps\mp\gametypes\_weapons::func_57F6(param_07) && param_03 maps\mp\_utility::func_649("specialty_stun_resistance"))
			{
				var_19 = "hittacticalmask";
			}
			else if(isexplosivedamagemod(param_06) && param_03 maps\mp\_utility::func_649("specialty_blastshield2") && !maps\mp\gametypes\_weapons::func_57F6(param_07) && !maps\mp\perks\_perks::func_3154(param_07))
			{
				var_19 = "hitblastshield";
			}
			else if(maps\mp\_utility::func_5697(param_06) && param_03 maps\mp\_utility::func_649("specialty_fireshield"))
			{
				var_19 = "hitfireshield";
			}
			else if((isdefined(param_03.raidmaniac) && param_03.raidmaniac) || isdefined(param_03.raidcombatbuff) && param_03.raidcombatbuff)
			{
				var_19 = "hitlightarmor";
			}
			else if(param_0A == "head")
			{
				var_19 = "headshot";
			}
			else if(var_14 && param_06 != "MOD_HEAD_SHOT" && !maps\mp\_utility::func_56F8(param_07,param_06,param_02))
			{
				var_19 = "hitlightarmor";
			}
			else if(param_04 < function_02F9(maps\mp\_utility::func_4431(param_07)))
			{
				var_19 = "minor";
			}
			else if(!func_8BB3(param_07))
			{
				var_19 = "none";
			}
			else
			{
				var_19 = "standard";
			}

			if(!isdefined(var_1C) || isdefined(var_1C) && var_1C method_8564() != "plane")
			{
				var_1B thread maps\mp\gametypes\_damagefeedback::func_A102(var_19);
			}
		}

		maps\mp\gametypes\_gamelogic::func_869D(param_02,1);
	}

	if(isdefined(param_01) && param_01 != param_02 && !var_15)
	{
		level.var_A239 = 0;
	}

	var_1D = param_02 getentitynumber();
	var_1E = param_02.var_109;
	var_1F = param_02.var_12C["team"];
	var_20 = param_02.var_48CA;
	var_21 = "";
	if(isplayer(param_01))
	{
		var_22 = param_01 getentitynumber();
		var_23 = param_01.var_48CA;
		var_24 = param_01.var_109;
		var_21 = param_01.var_12C["team"];
	}
	else
	{
		var_22 = -1;
		var_23 = "";
		var_24 = "";
		var_21 = "world";
	}

	if(isplayer(param_01))
	{
		var_25 = param_01.var_109;
		var_26 = param_01.var_116;
		if(isdefined(param_00) && isdefined(param_00.var_5CC6) && param_00.var_5CC6 != -1)
		{
			var_27 = param_00.var_5CC6;
		}
		else
		{
			var_27 = param_02.var_5CC6;
		}
	}
	else
	{
		var_25 = "world";
		var_26 = param_04.var_116;
		var_27 = -1;
	}

	var_28 = gettime();
	if(param_02.var_178 != "dead")
	{
		if(!function_01EF(param_02) && param_05 != "MOD_FALLING" && param_05 != "MOD_SUICIDE" && !isdefined(param_01) || param_01 != param_02)
		{
			var_29 = var_28 - level.var_5CC7[param_02.var_5CC6] / 1000;
			if(param_02.var_90AE < 0)
			{
				param_02.var_90AE = var_29;
			}

			if(var_29 <= 3 && isdefined(param_02.var_9070) && param_02.var_9070.var_29D9 == 0)
			{
				if(isdefined(param_02.var_12C["immediateActionSpawnCount"]))
				{
					param_02.var_12C["immediateActionSpawnCount"]++;
				}

				if(isdefined(param_01) && isdefined(param_01.var_12C) && isdefined(param_01.var_12C["causedImmediateActionSpawnCount"]))
				{
					param_01.var_12C["causedImmediateActionSpawnCount"]++;
				}

				if(!isdefined(level.var_6026))
				{
					level.var_6026 = [];
				}

				if(!isdefined(game["trapSpawnDmgReceivedCount"]))
				{
					game["trapSpawnDmgReceivedCount"] = 1;
				}
				else
				{
					game["trapSpawnDmgReceivedCount"]++;
				}

				param_02.var_9070.var_29D9 = 1;
				if(param_02.var_9070.var_9CFD == 0)
				{
					if(!isdefined(game["trapSpawnByAnyMeansCount"]))
					{
						game["trapSpawnByAnyMeansCount"] = 1;
					}
					else
					{
						game["trapSpawnByAnyMeansCount"]++;
					}

					if(isdefined(param_02.var_12C["badSpawnByAnyMeansCount"]))
					{
						param_02.var_12C["badSpawnByAnyMeansCount"]++;
					}

					if(isdefined(param_01) && isdefined(param_01.var_12C) && isdefined(param_01.var_12C["causedBadSpawnByAnyMeansCount"]))
					{
						param_01.var_12C["causedBadSpawnByAnyMeansCount"]++;
					}

					param_02.var_9070.var_9CFD = 1;
				}
			}
		}
		else
		{
			var_29 = -1;
		}

		if(isdefined(param_01) && isplayer(param_01) && param_05 != "MOD_FALLING" && param_05 != "MOD_SUICIDE" && !isdefined(param_02) || param_01 != param_02)
		{
			var_2A = var_28 - level.var_5CC7[var_27] / 1000;
			if(param_01.var_90AD < 0)
			{
				param_01.var_90AD = var_2A;
			}

			if(var_2A <= 3 && param_01.var_9070.var_29BA == 0)
			{
				if(isdefined(param_01) && isdefined(param_01.var_12C["immediateActionSpawnCount"]))
				{
					param_01.var_12C["immediateActionSpawnCount"]++;
				}

				if(!isdefined(level.var_6026))
				{
					level.var_6026 = [];
				}

				if(!isdefined(game["trapSpawnDmgDealtCount"]))
				{
					game["trapSpawnDmgDealtCount"] = 1;
				}
				else
				{
					game["trapSpawnDmgDealtCount"]++;
				}

				param_01.var_9070.var_29BA = 1;
				if(param_01.var_9070.var_9CFD == 0)
				{
					if(!isdefined(game["trapSpawnByAnyMeansCount"]))
					{
						game["trapSpawnByAnyMeansCount"] = 1;
					}
					else
					{
						game["trapSpawnByAnyMeansCount"]++;
					}

					if(isdefined(param_01) && isdefined(param_01.var_12C["badSpawnByAnyMeansCount"]))
					{
						param_01.var_12C["badSpawnByAnyMeansCount"]++;
					}

					param_01.var_9070.var_9CFD = 1;
				}
			}
		}
		else
		{
			var_2A = -1;
		}

		if(!function_01EF(param_02))
		{
			function_00F6(param_02.var_116,"script_mp_damage: player_name %s, player_angles %v, hit_loc %s, attacker_name %s, attacker_pos %v, damage %d, weapon %s, damage_type %s, gameTime %d, life_id %d, attacker_life_id %d, spawnToDamageReceivedTime %f, spawnToDamageDealtTime %f",param_02.var_109,param_02.var_1D,param_09,var_25,var_26,param_03,param_06,param_05,var_28,param_02.var_5CC6,var_27,var_29,var_2A);
			if(isdefined(level.var_73CD))
			{
				[[ level.var_73CD ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
			}
		}

		function_015A("D;" + var_20 + ";" + var_1D + ";" + var_1F + ";" + var_1E + ";" + var_23 + ";" + var_22 + ";" + var_21 + ";" + var_24 + ";" + param_06 + ";" + param_03 + ";" + param_05 + ";" + param_09 + "\n");
	}
	else
	{
		if(!function_01EF(param_02) && param_02.var_90AE < 0)
		{
			if(isdefined(level.var_5CC7[param_02.var_5CC6]))
			{
				var_29 = var_28 - level.var_5CC7[param_02.var_5CC6] / 1000;
				param_02.var_90AE = var_29;
			}
		}

		if(isdefined(param_01) && isplayer(param_01) && param_01.var_90AD < 0)
		{
			if(isdefined(level.var_5CC7[var_27]))
			{
				var_2A = var_28 - level.var_5CC7[var_27] / 1000;
				param_01.var_90AD = var_2A;
			}
		}
	}

	func_4DD9(param_01,param_02,param_03,param_09,param_04);
	if(function_01EF(self))
	{
		self [[ maps/mp/agents/_agent_utility::func_A59("on_damaged_finished") ]](param_00,param_01,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,"");
	}

	return "finished";
}

//Function Number: 30
func_118E(param_00,param_01)
{
	var_02 = !isdefined(param_00) || param_00 getentitynumber() == worldentnumber();
	var_03 = maps\mp\_utility::func_5740(param_01);
	if(var_02 && var_03)
	{
		return 1;
	}

	return 0;
}

//Function Number: 31
func_8BB3(param_00)
{
	switch(param_00)
	{
		case "firebomb_bomb_axis_grenadier_mp":
		case "firebomb_bomb_grenadier_mp":
		case "firebomb_bomb_axis_mp":
		case "firebomb_bomb_mp":
		case "airstrike_bomb_axis_mp":
		case "airstrike_bomb_mp":
		case "artillery_mp":
			return 0;
	}

	return 1;
}

//Function Number: 32
shouldignorefriendlyfireforhardcore(param_00,param_01)
{
	if(!level.var_4B17)
	{
		return 0;
	}

	if(getdvarint("scr_hardcore_StreaksTeamKill",0) != 0)
	{
		return 0;
	}

	if(function_01EF(param_01) && isdefined(param_01.var_A4B) && param_01.var_A4B == "paratroopers")
	{
		return 1;
	}

	if(!isdefined(param_00) || !maps\mp\_utility::func_5740(param_00))
	{
		return 0;
	}

	switch(param_00)
	{
		case "firebomb_flames_mp":
		case "firebomb_bomb_axis_grenadier_mp":
		case "firebomb_bomb_grenadier_mp":
		case "firebomb_bomb_axis_mp":
		case "firebomb_bomb_mp":
		case "airstrike_bomb_axis_mp":
		case "airstrike_bomb_mp":
		case "missile_strike_projectile_axis_mp":
		case "missile_strike_projectile_mp":
		case "mortar_strike_projectile_axis_mp":
		case "mortar_strike_projectile_mp":
		case "azon_projectile_mp":
		case "fritzx_projectile_mp":
		case "artillery_mp":
			return 1;
	}

	return 0;
}

//Function Number: 33
func_099A(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(!isdefined(param_00.var_1189))
	{
		param_00.var_1189 = [];
	}

	if(!isdefined(param_00.var_1189[param_01.var_48CA]))
	{
		param_00.var_1193[param_01.var_48CA] = param_01;
		param_00.var_1189[param_01.var_48CA] = spawnstruct();
		param_00.var_1189[param_01.var_48CA].var_2994 = 0;
		param_00.var_1189[param_01.var_48CA].var_118A = param_01;
		param_00.var_1189[param_01.var_48CA].var_3C71 = gettime();
		param_00.var_1189[param_01.var_48CA].var_A9DF = [];
		param_00.var_1189[param_01.var_48CA].var_4DD5 = 1;
		param_00.var_1189[param_01.var_48CA].var_4DE6 = [];
		param_00.var_1189[param_01.var_48CA].var_4DD6 = [];
		var_0A = anglestoforward((0,param_00.var_1D[1],0));
		var_0B = param_00.var_116 - param_01.var_116;
		var_0B = vectornormalize((var_0B[0],var_0B[1],0));
		var_0C = vectordot(var_0A,var_0B);
		var_0D = var_0C * -1;
		var_0E = 0;
		if(var_0D >= cos(getdvarint("cg_fov",65)))
		{
			var_0E = 1;
		}

		if(param_09 == "MOD_EXPLOSIVE" || param_09 == "MOD_GRENADE" || param_09 == "MOD_GRENADE_SPLASH" || param_09 == "MOD_PROJECTILE_SPLASH" || param_09 == "MOD_PROJECTILE" || param_09 == "MOD_MELEE" || param_09 == "MOD_MELEE_ALT" || param_09 == "MOD_MELEE_DOG" || maps\mp\_utility::func_5697(param_09,param_03) || param_09 == "MOD_SUICIDE" || param_09 == "MOD_IMPACT" || param_09 == "MOD_TRIGGER_HURT" || param_09 == "MOD_FALLING" || param_09 == "MOD_CRUSH" || isdefined(level.var_5A7D) && isdefined(level.var_5A7D[param_03]))
		{
			var_0E = -1;
		}

		param_00.var_1189[param_01.var_48CA].var_3C67 = var_0E;
	}
	else
	{
		param_00.var_1189[param_01.var_48CA].var_4DD5++;
	}

	if(maps\mp\gametypes\_weapons::func_5795(param_03) && !maps\mp\gametypes\_weapons::func_57CD(param_03))
	{
		param_00.var_1189[param_01.var_48CA].var_5792 = 1;
	}

	if(!isdefined(param_00.var_1189[param_01.var_48CA].var_A9DF[param_03]))
	{
		param_00.var_1189[param_01.var_48CA].var_A9DF[param_03] = param_03;
	}

	var_0F = param_00.var_1189[param_01.var_48CA].var_4DD5;
	param_00.var_1189[param_01.var_48CA].var_2994 = param_00.var_1189[param_01.var_48CA].var_2994 + param_04;
	param_00.var_1189[param_01.var_48CA].var_1D0 = param_03;
	param_00.var_1189[param_01.var_48CA].var_A62D = param_05;
	param_00.var_1189[param_01.var_48CA].var_A2B1 = param_06;
	param_00.var_1189[param_01.var_48CA].var_8B0A = param_07;
	param_00.var_1189[param_01.var_48CA].var_14A = param_08;
	param_00.var_1189[param_01.var_48CA].var_8CD7 = param_09;
	param_00.var_1189[param_01.var_48CA].var_118A = param_01;
	param_00.var_1189[param_01.var_48CA].var_5C08 = gettime();
	param_00.var_1189[param_01.var_48CA].var_4DE6[var_0F - 1] = param_03;
	param_00.var_1189[param_01.var_48CA].var_4DD6[var_0F - 1] = param_04;
	if(isdefined(param_02) && !isplayer(param_02) && isdefined(param_02.var_7704))
	{
		param_00.var_1189[param_01.var_48CA].var_912F = param_02.var_7704;
	}
	else if(isdefined(param_01) && isplayer(param_01) && param_01 getcurrentprimaryweapon() != "none")
	{
		param_00.var_1189[param_01.var_48CA].var_912F = param_01 getcurrentprimaryweapon();
	}
	else
	{
		param_00.var_1189[param_01.var_48CA].var_912F = undefined;
	}

	if(!isdefined(param_01.var_A491))
	{
		param_01.var_A491 = [];
	}

	if(!isdefined(param_01.var_A491[param_00.var_48CA]))
	{
		param_01.var_A495[param_00.var_48CA] = param_00;
	}

	param_01.var_A491[param_00.var_48CA] = param_00.var_1189[param_01.var_48CA];
	param_01.var_A491[param_00.var_48CA].var_A492 = param_00;
	param_01.var_A491[param_00.var_48CA].var_A493 = param_00.var_5CC6;
	if(!isdefined(param_01.var_29B9))
	{
		param_01.var_29B9 = 0;
	}

	if(!isdefined(param_00.var_29DA))
	{
		param_00.var_29DA = 0;
	}

	param_01.var_29B9 = param_01.var_29B9 + param_04;
	param_00.var_29DA = param_00.var_29DA + param_04;
}

//Function Number: 34
func_7D51()
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	wait(1.75);
	self.var_1193 = [];
	self.var_1189 = [];
}

//Function Number: 35
func_5E8A(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(param_01) && isplayer(param_01))
	{
		func_099A(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
	}

	if(isdefined(param_01) && !isplayer(param_01) && isdefined(param_01.var_117) && !isdefined(param_01.var_80D7) || !param_01.var_80D7)
	{
		func_099A(param_00,param_01.var_117,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
	}
	else if(isdefined(param_01) && !isplayer(param_01) && isdefined(param_01.var_835E) && isdefined(param_01.var_80D7) && param_01.var_80D7)
	{
		func_099A(param_00,param_01.var_835E,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
	}

	if(isdefined(param_02) && isdefined(param_02.var_117) && isdefined(param_02.var_117.var_48CA))
	{
		var_0A = param_02.var_117.var_1A7 != param_00.var_1A7 || level.var_3EC4 == 1;
		if(var_0A && !isdefined(self.var_1189[param_02.var_117.var_48CA]))
		{
			func_099A(param_00,param_02.var_117,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
		}
	}

	if(isdefined(param_01))
	{
		level.var_5BB7 = param_01;
	}

	if(isdefined(param_01) && isplayer(param_01) && isdefined(param_03))
	{
		param_01 thread maps\mp\gametypes\_weapons::func_21C6(param_03,param_09,param_00);
	}

	if(isdefined(param_01) && isplayer(param_01) && isdefined(param_03) && param_01 != param_00)
	{
		param_00.var_1192 = param_01.var_116;
		return;
	}

	param_00.var_1192 = undefined;
}

//Function Number: 36
func_A106(param_00,param_01)
{
	var_02 = 0;
	if(isdefined(param_00) && isdefined(param_01))
	{
		foreach(var_06, var_04 in param_00)
		{
			if(!isplayer(var_04))
			{
				continue;
			}

			var_05 = var_04 getentitynumber();
			self setclientomnvar("ui_death_details_attacker_" + var_02,var_05);
			self setclientomnvar("ui_death_details_hits_" + var_02,int(min(param_01[var_06].var_4DD5,10)));
			var_02++;
			if(var_02 >= 4)
			{
				break;
			}
		}
	}

	for(var_07 = var_02;var_07 < 4;var_07++)
	{
		self setclientomnvar("ui_death_details_attacker_" + var_07,-1);
	}
}

//Function Number: 37
func_1E63(param_00,param_01)
{
	if(!isdefined(self) || !function_0388(self))
	{
		return;
	}

	if(!isdefined(param_00) || !function_0389(param_00))
	{
		return;
	}

	param_01 = maps\mp\_utility::func_73C(param_01);
	if(!isdefined(param_01))
	{
		return;
	}

	if(common_scripts\utility::func_562E(param_00.var_5D9F) && !self method_81E0())
	{
		if(isdefined(param_00.var_1A7) && isdefined(param_01.var_1A7) && param_00.var_1A7 != param_01.var_1A7)
		{
			self notify("force_start_ragdoll");
		}
	}
}

//Function Number: 38
func_1E68(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = func_1E69(param_00,param_01,self,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09);
}

//Function Number: 39
func_3BAC(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A)
{
	if(isdefined(level.var_6B77))
	{
		self [[ level.var_6B77 ]](param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
	}

	var_0B = 0;
	if(maps\mp\_utility::func_581D() && param_02 >= self.var_BC && !param_03 & level.var_5040 && !isdefined(self.var_5379) && !self method_8527())
	{
		var_0B = 1;
	}

	if(var_0B || maps\mp\_utility::func_57B0())
	{
		if(!isdefined(param_07))
		{
			param_07 = (0,0,0);
		}

		if(!isdefined(param_01) && !isdefined(param_00))
		{
			param_01 = self;
			param_00 = param_01;
		}

		func_7418(param_00,param_01,self,param_02,param_04,param_05,param_07,param_08,param_09,0,1);
	}
	else
	{
		if(!func_1E66(param_00,param_01,param_02 - param_02 * param_0A,param_03,param_04,param_05,param_06,param_07,param_08,param_09))
		{
			return;
		}

		if(!isalive(self))
		{
			return;
		}

		if(isplayer(self))
		{
			var_0C = self finishplayerdamage(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A);
			if(isdefined(var_0C))
			{
				if(param_04 != "MOD_FALLING")
				{
					self setclientomnvar("ui_damage_flash",1);
				}

				if(!common_scripts\utility::func_562E(level.disableplayerdamageimpactfx))
				{
					thread func_3BAB(var_0C[0],var_0C[1],var_0C[2],var_0C[3],var_0C[4],var_0C[5],var_0C[6]);
				}
			}
		}
	}

	if(param_04 == "MOD_EXPLOSIVE_BULLET")
	{
		self shellshock("damage_mp",getdvarfloat("scr_csmode"));
	}

	func_29DC(param_00,param_05,param_04,param_02,param_03,param_01);
}

//Function Number: 40
func_3BAB(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	waittillframeend;
	if(!isdefined(self) || !isdefined(param_00))
	{
		return;
	}

	self method_853A(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
}

//Function Number: 41
func_1E6D(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = spawnstruct();
	var_09.var_35A9 = param_00;
	var_09.var_1180 = param_01;
	var_09.var_502C = param_02;
	var_09.var_1192 = param_01.var_116;
	if(param_01 == self)
	{
		var_09.var_8CD7 = "MOD_SUICIDE";
	}
	else
	{
		var_09.var_8CD7 = param_03;
	}

	var_09.var_953E = param_04;
	if(isdefined(param_01) && isplayer(param_01) && param_01 getcurrentprimaryweapon() != "none")
	{
		var_09.var_912F = param_01 getcurrentprimaryweapon();
	}
	else
	{
		var_09.var_912F = undefined;
	}

	var_09.var_A2B1 = param_05;
	var_09.var_8B0A = param_06;
	var_09.var_5BF4 = gettime();
	var_0A = func_60AC(param_04,param_03,param_06);
	if(isdefined(self.var_36B9))
	{
		var_0A = 0;
	}

	if(level.var_984D && isdefined(param_01.var_1A7) && param_01.var_1A7 == self.var_1A7)
	{
		var_0A = 0;
	}

	if(level.var_2EF3)
	{
		if(level.var_984F[self.var_1A7] <= 1)
		{
			var_0A = 0;
		}
		else if(maps\mp\_utility::func_57FF())
		{
			var_0A = 0;
			maps\mp\_utility::func_5A7F(self.var_1A7);
		}
	}

	if(!var_0A)
	{
		self.var_5BEF = var_09;
		self.var_A219 = 1;
		maps\mp\_utility::func_728();
		return;
	}

	self.var_5378 = 1;
	var_0B = spawnstruct();
	if(maps\mp\_utility::func_649("specialty_finalstand"))
	{
		var_0B.var_9A2E = game["strings"]["final_stand"];
		var_0B.var_5019 = level.var_90D7;
	}
	else
	{
		var_0B.var_9A2E = game["strings"]["last_stand"];
		var_0B.var_5019 = level.var_90D7;
	}

	var_0B.var_AB = (1,0,0);
	var_0B.var_8F2C = "mp_last_stand";
	var_0B.var_3511 = 2;
	self.var_BC = 1;
	thread maps\mp\gametypes\_hud_message::func_680B(var_0B);
	var_0C = "frag_grenade_mp";
	if(maps\mp\_utility::func_649("specialty_finalstand"))
	{
		self.var_5BEF = var_09;
		self.var_5133 = 1;
		var_0D = self getweaponslistexclusives();
		foreach(var_0F in var_0D)
		{
			self takeweapon(var_0F);
		}

		common_scripts\utility::func_601();
		thread func_365B();
		thread func_5BF5(20,1);
		return;
	}

	if(level.var_2EF3)
	{
		param_01 thread maps\mp\_events::func_5A41(self,param_04,param_03);
		self.var_5BEF = var_09;
		common_scripts\utility::func_602();
		thread func_5BF5(20,0);
		common_scripts\utility::func_601();
		return;
	}

	self.var_5BEF = var_09;
	var_11 = undefined;
	var_12 = self getweaponslistprimaries();
	foreach(var_0F in var_12)
	{
		if(maps\mp\gametypes\_weapons::func_57CD(var_0F) && var_0F != "combatknife_mp")
		{
			var_11 = var_0F;
		}
	}

	if(!isdefined(var_11))
	{
		var_11 = "m1911_mp";
		maps\mp\_utility::func_642(var_11);
	}

	self givemaxammo(var_11);
	self method_8326();
	common_scripts\utility::func_601();
	if(!maps\mp\_utility::func_649("specialty_laststandoffhand"))
	{
		self method_8324();
	}

	self switchtoweapon(var_11);
	thread func_5BF5(10,0);
}

//Function Number: 42
func_2EEF(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	level endon("game_ended");
	wait(param_00);
	self.var_A219 = 1;
	maps\mp\_utility::func_728();
}

//Function Number: 43
func_2E69()
{
	self endon("death");
	self endon("disconnect");
	self endon("joined_team");
	level endon("game_ended");
	self waittill("detonate");
	self.var_A219 = 1;
	func_1DF2();
}

//Function Number: 44
func_2E68()
{
	self endon("detonate");
	self endon("disconnect");
	self endon("joined_team");
	level endon("game_ended");
	self waittill("death");
	func_1DF2();
}

//Function Number: 45
func_1DF2()
{
	self method_8617("detpack_explo_default");
	self.var_1DF3 = playfx(level.var_1DF1,self.var_116);
	radiusdamage(self.var_116,312,100,100,self);
	if(isalive(self))
	{
		maps\mp\_utility::func_728();
	}
}

//Function Number: 46
func_365B()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	maps\mp\_utility::func_3E8E(1);
	wait(0.3);
	maps\mp\_utility::func_3E8E(0);
}

//Function Number: 47
func_5BF5(param_00,param_01,param_02)
{
	self endon("death");
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	level notify("player_last_stand");
	self notify("player_last_stand");
	thread func_5BFB();
	self.var_E8 = 1;
	if(!param_01 && (!isdefined(self.var_50DC) || !self.var_50DC) && !isdefined(param_02) || !param_02)
	{
		thread func_5BE8();
		maps\mp\_utility::func_86C3("last_stand",&"PLATFORM_COWARDS_WAY_OUT",undefined,undefined,undefined,undefined,undefined,undefined,1);
		thread func_5BEC();
	}

	if(level.var_2EF3 == 1 && level.var_2EF3 != 2 && !isdefined(param_02) || !param_02)
	{
		var_03 = spawn("script_model",self.var_116);
		var_03 setmodel("tag_origin");
		var_03 setcursorhint("HINT_NOICON");
		var_03 sethintstring(&"PLATFORM_REVIVE");
		var_03 func_7E61(self);
		var_03 endon("death");
		var_04 = newteamhudelem(self.var_1A7);
		var_04 setshader("waypoint_revive",8,8);
		var_04 setwaypoint(1,1);
		var_04 settargetent(self);
		var_04 thread func_2DD6(var_03);
		var_04.var_56 = (0.33,0.75,0.24);
		maps\mp\_utility::func_7210();
		if(param_01)
		{
			wait(param_00);
			if(self.var_5133)
			{
				thread func_5BEA(param_01,var_03);
			}
		}

		return;
	}
	else if(level.var_2EF3 == 2 && !isdefined(var_04) || !var_04)
	{
		thread func_5BEC();
		var_03 = spawn("script_model",self.var_116);
		var_04 setmodel("tag_origin");
		var_04 setcursorhint("HINT_NOICON");
		var_04 sethintstring(&"PLATFORM_REVIVE");
		var_04 func_7E61(self);
		var_04 endon("death");
		var_04 = newteamhudelem(self.var_1A7);
		var_04 setshader("waypoint_revive",8,8);
		var_04 setwaypoint(1,1);
		var_04 settargetent(self);
		var_04 thread func_2DD6(var_03);
		var_04.var_56 = (0.33,0.75,0.24);
		maps\mp\_utility::func_7210();
		if(param_01)
		{
			wait(param_00);
			if(self.var_5133)
			{
				thread func_5BEA(param_01,var_03);
			}
		}

		wait(param_00 / 3);
		var_04.var_56 = (1,0.64,0);
		while(var_03.var_54F5)
		{
			wait 0.05;
		}

		maps\mp\_utility::func_7210();
		wait(param_00 / 3);
		var_04.var_56 = (1,0,0);
		while(var_03.var_54F5)
		{
			wait 0.05;
		}

		maps\mp\_utility::func_7210();
		wait(param_00 / 3);
		while(var_03.var_54F5)
		{
			wait 0.05;
		}

		wait 0.05;
		thread func_5BEA(param_01);
		return;
	}

	if(!isdefined(var_04) || !var_04)
	{
		thread func_5BEC();
	}

	wait(param_02);
	thread func_5BEA(var_03);
}

//Function Number: 48
func_6086(param_00,param_01)
{
	self endon("stop_maxHealthOverlay");
	self endon("revive");
	self endon("death");
	for(;;)
	{
		self.var_BC = self.var_BC - 1;
		self.var_FB = param_00;
		wait 0.05;
		self.var_FB = 50;
		self.var_BC = self.var_BC + 1;
		wait(0.5);
	}
}

//Function Number: 49
func_5BEA(param_00,param_01)
{
	if(param_00)
	{
		self.var_E8 = undefined;
		self.var_5133 = 0;
		self notify("revive");
		maps\mp\_utility::func_2401("last_stand");
		maps\mp\gametypes\_playerlogic::func_5BF0();
		if(isdefined(param_01))
		{
			param_01 delete();
			return;
		}

		return;
	}

	self.var_A219 = 1;
	self.var_172C = 0;
	maps\mp\_utility::func_728();
}

//Function Number: 50
func_5BE8()
{
	self endon("death");
	self endon("disconnect");
	self endon("game_ended");
	self endon("revive");
	for(;;)
	{
		if(self usebuttonpressed())
		{
			var_00 = gettime();
			while(self usebuttonpressed())
			{
				wait 0.05;
				if(gettime() - var_00 > 700)
				{
					break;
				}
			}

			if(gettime() - var_00 > 700)
			{
				break;
			}
		}

		wait 0.05;
	}

	thread func_5BEA(0);
}

//Function Number: 51
func_5BEC()
{
	level endon("game_ended");
	self endon("death");
	self endon("disconnect");
	self endon("revive");
	while(!level.var_3F9D)
	{
		self.var_BC = 2;
		wait 0.05;
		self.var_BC = 1;
		wait(0.5);
	}

	self.var_BC = self.var_FB;
}

//Function Number: 52
func_5BFB()
{
	self endon("disconnect");
	self endon("revive");
	level endon("game_ended");
	self waittill("death");
	maps\mp\_utility::func_2401("last_stand");
	self.var_E8 = undefined;
}

//Function Number: 53
func_60AC(param_00,param_01,param_02)
{
	if(param_01 == "MOD_TRIGGER_HURT")
	{
		return 0;
	}

	if(param_01 != "MOD_PISTOL_BULLET" && param_01 != "MOD_RIFLE_BULLET" && param_01 != "MOD_FALLING" && param_01 != "MOD_EXPLOSIVE_BULLET")
	{
		return 0;
	}

	if(param_01 == "MOD_IMPACT" && param_00 == "throwingknife_mp" || param_00 == "throwingknifejugg_mp")
	{
		return 0;
	}

	if(param_01 == "MOD_IMPACT" && param_00 == "m79_mp" || issubstr(param_00,"gl_"))
	{
		return 0;
	}

	if(maps\mp\_utility::func_570A(param_00,param_02,param_01))
	{
		return 0;
	}

	if(maps\mp\_utility::func_581D())
	{
		return 0;
	}

	return 1;
}

//Function Number: 54
func_378E()
{
	if(!isdefined(self.var_5BEF.var_1180))
	{
		self.var_5BEF.var_1180 = self;
	}
}

//Function Number: 55
func_450E(param_00)
{
	switch(param_00)
	{
		case "neck":
		case "helmet":
		case "head":
			return 60;

		case "torso_upper":
		case "left_hand":
		case "left_arm_lower":
		case "left_arm_upper":
		case "right_arm_lower":
		case "right_hand":
		case "right_arm_upper":
		case "gun":
			return 48;

		case "torso_lower":
			return 40;

		case "left_leg_upper":
		case "right_leg_upper":
			return 32;

		case "left_leg_lower":
		case "right_leg_lower":
			return 10;

		case "left_foot":
		case "right_foot":
			return 5;
	}

	return 48;
}

//Function Number: 56
func_450F(param_00)
{
	switch(param_00)
	{
		case "helmet":
			return "j_neck";

		case "head":
			return "j_neck";

		case "neck":
			return "j_neck";

		case "torso_upper":
			return "j_neck";

		case "right_arm_upper":
			return "J_Shoulder_RI";

		case "left_arm_upper":
			return "J_Shoulder_LE";

		case "right_arm_lower":
			return "J_Elbow_RI";

		case "left_arm_lower":
			return "J_Elbow_LE";

		case "right_hand":
			return "J_Wrist_RI";

		case "left_hand":
			return "J_Wrist_LE";

		case "gun":
			return "J_Wrist_RI";

		case "torso_lower":
			return "J_SpineLower";

		case "right_leg_upper":
			return "J_Hip_RI";

		case "left_leg_upper":
			return "J_Hip_LE";

		case "right_leg_lower":
			return "J_Knee_RI";

		case "left_leg_lower":
			return "J_Knee_LE";

		case "right_foot":
			return "J_Ankle_RI";

		case "left_foot":
			return "J_Ankle_LE";
	}

	return undefined;
}

//Function Number: 57
func_2CEC(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(param_00))
	{
		var_06 = param_00 getcorpseanim();
		if(animhasnotetrack(var_06,"ignore_ragdoll"))
		{
			return;
		}
	}

	if(isdefined(level.var_6738) && level.var_6738.size)
	{
		foreach(var_08 in level.var_6738)
		{
			if(distancesquared(param_00.var_116,var_08.var_116) < 65536)
			{
				return;
			}
		}
	}

	wait(0.2);
	if(!isdefined(param_00))
	{
		return;
	}

	if(param_00 method_81E0())
	{
		return;
	}

	var_06 = param_00 getcorpseanim();
	var_0A = 0.35;
	if(animhasnotetrack(var_06,"start_ragdoll"))
	{
		var_0B = getnotetracktimes(var_06,"start_ragdoll");
		if(isdefined(var_0B))
		{
			var_0A = var_0B[0];
		}
	}

	var_0C = param_00 method_801F();
	var_0D = clamp(var_0A - var_0C,0,1);
	var_0E = var_0D * getanimlength(var_06);
	if(var_0E > 0)
	{
		param_00 common_scripts\utility::func_A74B("force_start_ragdoll",var_0E);
	}

	if(isdefined(param_00))
	{
		param_00 startragdoll();
	}
}

//Function Number: 58
func_4594()
{
	var_00 = "";
	var_01 = 0;
	var_02 = getarraykeys(self.var_5A3C);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = var_02[var_03];
		if(self.var_5A3C[var_04] <= var_01)
		{
			continue;
		}

		var_01 = self.var_5A3C[var_04];
		var_05 = var_04;
	}

	return var_00;
}

//Function Number: 59
func_4593()
{
	var_00 = "";
	var_01 = 0;
	var_02 = getarraykeys(self.var_5A42);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = var_02[var_03];
		if(self.var_5A42[var_04] <= var_01)
		{
			continue;
		}

		var_01 = self.var_5A42[var_04];
		var_00 = var_04;
	}

	return var_00;
}

//Function Number: 60
func_29DC(param_00,param_01,param_02,param_03,param_04,param_05)
{
	thread maps\mp\gametypes\_weapons::func_6BCD(param_00,param_01,param_02,param_03,param_05);
	var_06 = gettime();
	if(!isdefined(self.var_5B8C) || var_06 > self.var_5B8C)
	{
		self.var_5B8C = var_06;
		self playrumbleonentity("damage_heavy");
	}
}

//Function Number: 61
func_7E61(param_00)
{
	var_01 = param_00.var_1A7;
	self linkto(param_00,"tag_origin");
	self.var_117 = param_00;
	self.var_54F5 = 0;
	self makeusable();
	func_A18E(var_01);
	thread func_9BCC(var_01);
	thread func_7E64(var_01);
	thread func_2D44();
}

//Function Number: 62
func_2D44()
{
	self endon("death");
	self.var_117 common_scripts\utility::knock_off_battery("death","disconnect");
	self delete();
}

//Function Number: 63
func_A18E(param_00)
{
	foreach(var_02 in level.var_744A)
	{
		if(param_00 == var_02.var_1A7 && var_02 != self.var_117)
		{
			self enableplayeruse(var_02);
			continue;
		}

		self disableplayeruse(var_02);
	}
}

//Function Number: 64
func_9BCC(param_00)
{
	self endon("death");
	for(;;)
	{
		level waittill("joined_team");
		func_A18E(param_00);
	}
}

//Function Number: 65
func_9BBF(param_00)
{
	self endon("death");
	for(;;)
	{
		level waittill("player_last_stand");
		func_A18E(param_00);
	}
}

//Function Number: 66
func_7E64(param_00)
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger",var_01);
		self.var_117.var_172C = 1;
		if(isdefined(var_01.var_172C) && var_01.var_172C)
		{
			self.var_117.var_172C = 0;
			continue;
		}

		self makeunusable();
		self.var_117 maps\mp\_utility::func_3E8E(1);
		var_02 = func_7E5A(var_01);
		self.var_117.var_172C = 0;
		if(!isalive(self.var_117))
		{
			self delete();
			return;
		}

		self.var_117 maps\mp\_utility::func_3E8E(0);
		if(var_02)
		{
			level thread maps\mp\gametypes\_rank::func_1457("reviver",var_01);
			self.var_117.var_E8 = undefined;
			self.var_117 maps\mp\_utility::func_2401("last_stand");
			self.var_117 common_scripts\utility::func_616();
			self.var_117.var_FB = 100;
			self.var_117 maps\mp\gametypes\_weapons::func_A13B();
			self.var_117 maps\mp\gametypes\_playerlogic::func_5BF0();
			self.var_117 maps\mp\_utility::func_47A2("specialty_pistoldeath");
			self.var_117.var_172C = 0;
			self delete();
			return;
		}

		self makeusable();
		func_A18E(param_00);
	}
}

//Function Number: 67
func_7E5A(param_00,param_01,param_02,param_03)
{
	var_04 = 3000;
	var_05 = spawn("script_origin",self.var_116);
	var_05 method_805C();
	if(isdefined(level.additional_revive_spot_handling_func))
	{
		var_05 = [[ level.additional_revive_spot_handling_func ]](var_05,param_00);
	}

	if(isplayer(param_00))
	{
		param_00 playerlinkto(var_05);
	}
	else
	{
		param_00 linkto(var_05);
	}

	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(param_02)
	{
		param_00 common_scripts\utility::func_602();
	}

	self.var_28D5 = 0;
	self.var_54F5 = 1;
	self.var_A22B = 0;
	if(isdefined(param_01))
	{
		self.var_A23F = param_01;
	}
	else
	{
		self.var_A23F = var_04;
	}

	param_00 thread func_6F82(self);
	thread func_7E5B(param_00,param_02,var_05);
	var_06 = func_7E5C(param_00);
	self.var_54F5 = 0;
	if(!common_scripts\utility::func_562E(var_05.dontdeleterevivespot))
	{
		var_05 delete();
	}

	if(isdefined(var_06) && var_06)
	{
		self.var_117 thread maps\mp\gametypes\_hud_message::func_73C2("revived",param_00);
		self.var_117.var_5378 = 0;
		return 1;
	}

	if(maps\mp\_utility::func_585F())
	{
		param_00.var_39E3++;
		if(isdefined(param_00.var_E8) && param_00.var_E8)
		{
			param_00.var_39E5++;
		}

		return 0;
	}
}

//Function Number: 68
func_7E5B(param_00,param_01,param_02)
{
	common_scripts\utility::func_A70C(self,"death",param_02,"death");
	if(isdefined(level.additional_on_revive_end_func))
	{
		[[ level.additional_on_revive_end_func ]](param_00,param_01,param_02);
		return;
	}

	if(!function_0279(param_02))
	{
		param_02 delete();
	}

	if(isdefined(param_00) && maps\mp\_utility::func_57A0(param_00))
	{
		param_00 unlink();
		if(param_01)
		{
			param_00 common_scripts\utility::func_616();
		}
	}
}

//Function Number: 69
func_6F82(param_00)
{
	self setclientomnvar("ui_use_bar_text",3);
	self setclientomnvar("ui_use_bar_start_time",int(gettime()));
	var_01 = undefined;
	if(isdefined(param_00) && isdefined(param_00.var_117))
	{
		var_01 = param_00.var_117;
		var_01 setclientomnvar("ui_use_bar_text",4);
		var_01 setclientomnvar("ui_use_bar_start_time",int(gettime()));
	}

	var_02 = -1;
	while(maps\mp\_utility::func_57A0(self) && isdefined(param_00) && param_00.var_54F5 && !level.var_3F9D && isdefined(self))
	{
		var_03 = int(gettime());
		self setclientomnvar("ui_use_bar_current_time",var_03);
		if(isdefined(var_01))
		{
			var_01 setclientomnvar("ui_use_bar_current_time",var_03);
		}

		if(var_02 != param_00.var_A22B)
		{
			if(param_00.var_28D5 > param_00.var_A23F)
			{
				param_00.var_28D5 = param_00.var_A23F;
			}

			if(param_00.var_A22B > 0)
			{
				var_04 = gettime();
				var_05 = param_00.var_28D5 / param_00.var_A23F;
				var_06 = var_04 + 1 - var_05 * param_00.var_A23F / param_00.var_A22B;
				self setclientomnvar("ui_use_bar_end_time",int(var_06));
				if(isdefined(var_01))
				{
					var_01 setclientomnvar("ui_use_bar_end_time",int(var_06));
				}
			}

			var_02 = param_00.var_A22B;
		}

		wait 0.05;
	}

	if(isdefined(self))
	{
		self setclientomnvar("ui_use_bar_end_time",0);
	}

	if(isdefined(var_01))
	{
		var_01 setclientomnvar("ui_use_bar_end_time",0);
	}
}

//Function Number: 70
func_6F83(param_00,param_01)
{
	var_02 = maps\mp\gametypes\_hud_util::func_2821();
	var_03 = maps\mp\gametypes\_hud_util::func_2822();
	var_03 settext(&"MPUI_REVIVING");
	if(isdefined(param_01))
	{
		var_03 settext(param_01);
	}

	var_04 = param_00.var_117 maps\mp\gametypes\_hud_util::func_2821();
	var_05 = param_00.var_117 maps\mp\gametypes\_hud_util::func_2822();
	var_05 settext(&"MPUI_BEING_REVIVED");
	var_06 = -1;
	while(maps\mp\_utility::func_57A0(self) && isdefined(param_00) && param_00.var_54F5 && !level.var_3F9D && isdefined(self))
	{
		if(var_06 != param_00.var_A22B)
		{
			if(param_00.var_28D5 > param_00.var_A23F)
			{
				param_00.var_28D5 = param_00.var_A23F;
			}

			var_02 maps\mp\gametypes\_hud_util::func_A0E3(param_00.var_28D5 / param_00.var_A23F,1000 / param_00.var_A23F * param_00.var_A22B);
			var_04 maps\mp\gametypes\_hud_util::func_A0E3(param_00.var_28D5 / param_00.var_A23F,1000 / param_00.var_A23F * param_00.var_A22B);
			if(!param_00.var_A22B)
			{
				var_02 maps\mp\gametypes\_hud_util::func_4D06();
				var_03 maps\mp\gametypes\_hud_util::func_4D06();
				var_04 maps\mp\gametypes\_hud_util::func_4D06();
				var_05 maps\mp\gametypes\_hud_util::func_4D06();
			}
			else
			{
				var_02 maps\mp\gametypes\_hud_util::func_8BF6();
				var_03 maps\mp\gametypes\_hud_util::func_8BF6();
				var_04 maps\mp\gametypes\_hud_util::func_8BF6();
				var_05 maps\mp\gametypes\_hud_util::func_8BF6();
			}
		}

		var_06 = param_00.var_A22B;
		wait 0.05;
	}

	if(isdefined(var_02))
	{
		var_02 maps\mp\gametypes\_hud_util::func_2DCC();
	}

	if(isdefined(var_03))
	{
		var_03 maps\mp\gametypes\_hud_util::func_2DCC();
	}

	if(isdefined(var_04))
	{
		var_04 maps\mp\gametypes\_hud_util::func_2DCC();
	}

	if(isdefined(var_05))
	{
		var_05 maps\mp\gametypes\_hud_util::func_2DCC();
	}
}

//Function Number: 71
func_7E5C(param_00)
{
	level endon("game_ended");
	self.var_117 endon("death");
	self.var_117 endon("disconnect");
	while(maps\mp\_utility::func_57A0(param_00) && param_00 usebuttonpressed() && self.var_28D5 < self.var_A23F && !isdefined(param_00.var_5378) && param_00.var_5378)
	{
		self.var_28D5 = self.var_28D5 + 50 * self.var_A22B;
		self.var_A22B = 1;
		if(self.var_28D5 >= self.var_A23F)
		{
			self.var_54F5 = 0;
			return maps\mp\_utility::func_57A0(param_00);
		}

		wait 0.05;
	}

	return 0;
}

//Function Number: 72
func_1E66(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(self.var_5B8D) && self.var_5B8D && param_02 >= self.var_BC && isdefined(self.var_252D) && self.var_252D == "specialty_endgame")
	{
		maps\mp\_utility::func_47A2("specialty_endgame");
		return 0;
	}

	return 1;
}

//Function Number: 73
func_35D9(param_00)
{
	physicsexplosionsphere(self.var_116,64,64,1);
	var_01 = [];
	for(var_02 = 0;var_02 < 360;var_02 = var_02 + 30)
	{
		var_03 = cos(var_02) * 16;
		var_04 = sin(var_02) * 16;
		var_05 = bullettrace(self.var_116 + (var_03,var_04,4),self.var_116 + (var_03,var_04,-6),1,self);
		if(isdefined(var_05["entity"]) && isdefined(var_05["entity"].var_1A5) && var_05["entity"].var_1A5 == "destructible_vehicle" || var_05["entity"].var_1A5 == "destructible_toy")
		{
			var_01[var_01.size] = var_05["entity"];
		}
	}

	if(var_01.size)
	{
		var_06 = spawn("script_origin",self.var_116);
		var_06 method_805C();
		var_06.var_1B9 = "soft_landing";
		var_06.var_2E27 = var_01;
		radiusdamage(self.var_116,64,100,100,var_06);
		wait(0.1);
		var_06 delete();
	}
}

//Function Number: 74
func_068A(param_00,param_01,param_02,param_03)
{
	var_04 = param_00.var_1A7;
	foreach(var_06 in level.var_744A)
	{
		var_07 = var_06.var_1A7;
		if(var_07 == "spectator")
		{
			var_06 iclientprintln(&"MP_OBITUARY_NEUTRAL",param_01.var_109,param_00.var_109);
			continue;
		}

		if(var_07 == var_04)
		{
			var_06 iclientprintln(&"MP_OBITUARY_ENEMY",param_01.var_109,param_00.var_109);
			continue;
		}

		var_06 iclientprintln(&"MP_OBITUARY_FRIENDLY",param_01.var_109,param_00.var_109);
	}
}

//Function Number: 75
func_5EAB(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = self getentitynumber();
	var_08 = self.var_109;
	var_09 = self.var_1A7;
	var_0A = self.var_48CA;
	if(isplayer(param_01))
	{
		var_0B = param_01.var_48CA;
		var_0C = param_01.var_109;
		var_0D = param_01.var_1A7;
		var_0E = param_01 getentitynumber();
		var_0F = param_01.var_1D6 + "(" + var_0C + ")";
	}
	else
	{
		var_0B = "";
		var_0C = "";
		var_0D = "world";
		var_0E = -1;
		var_0F = "none";
	}

	function_015A("K;" + var_0A + ";" + var_07 + ";" + var_09 + ";" + var_08 + ";" + var_0B + ";" + var_0E + ";" + var_0D + ";" + var_0C + ";" + param_04 + ";" + param_02 + ";" + param_03 + ";" + param_06 + "\n");
}

//Function Number: 76
func_2DD6(param_00)
{
	param_00 waittill("death");
	self destroy();
}

//Function Number: 77
func_3FC8(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(isdefined(param_02) && isplayer(param_02) && isalive(param_02))
	{
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

//Function Number: 78
func_8676(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(param_04))
	{
		param_04 = 0;
	}

	if(!isdefined(param_01))
	{
		param_01 = "normal";
	}

	if(!isdefined(param_03))
	{
		param_03 = ::func_62A6;
	}

	self setcandamage(1);
	if(isdefined(self.var_3A) && self.var_3A != "script_vehicle")
	{
		self setdamagecallbackon(1);
	}

	self.var_BC = 999999;
	self.var_FB = param_00;
	self.var_6A = 0;
	self.var_176C = param_04;
	self.var_29C1 = param_01;
	self.var_29B5 = ::func_7753;
	self.var_62A7 = param_03;
	self.var_6AE6 = param_02;
	self.var_118F = [];
}

//Function Number: 79
func_7753(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(level.var_5667) && level.var_5667 && !isdefined(level.var_585D) && level.var_585D && isdefined(param_01) && !maps\mp\_utility::func_56FF(param_01))
	{
		return;
	}

	if(isdefined(param_01) && !maps\mp\gametypes\_weapons::func_3ECD(self.var_117,param_01))
	{
		return;
	}

	param_01 playrumbleonentity("damage_light");
	if(isdefined(self.var_56BB) && self.var_56BB)
	{
		return;
	}

	if(isdefined(self.var_5745) && self.var_5745)
	{
		return;
	}

	if(isdefined(self.var_93FD) && self.var_93FD)
	{
		return;
	}

	var_0C = param_02;
	if(isdefined(param_05))
	{
		switch(param_05)
		{
			case "smoke_grenade_axis_expeditionary_mp":
			case "smoke_grenade_expeditionary_mp":
			case "paint_grenade_mp":
			case "smoke_grenade_axis_mp":
			case "smoke_grenade_mp":
				break;
		}

		var_0C = [[ self.var_62A7 ]](param_01,param_05,param_04,param_02);
	}

	if(var_0C <= 0)
	{
		return 1;
	}

	if(isdefined(param_03) && param_03 & level.var_5039)
	{
		self.var_A86F = 1;
	}

	self.var_A86E = 1;
	self.var_6A = self.var_6A + var_0C;
	maps\mp\killstreaks\_killstreaks::func_5A67(param_01,param_05,self);
	if(isdefined(param_01) && isplayer(param_01))
	{
		param_01 maps\mp\gametypes\_damagefeedback::func_A102(self.var_29C1);
		if(func_575B(param_01))
		{
			self.var_118F[self.var_118F.size] = param_01;
		}
	}

	if(self.var_6A >= self.var_FB)
	{
		if(self.var_176C && isplayer(param_01))
		{
			param_01 notify("destroyed_killstreak",param_05);
		}

		if(self.var_3A == "script_vehicle" || self.var_3A == "script_model")
		{
			var_0D = maps\mp\_utility::func_4431(param_05,1);
			if(maps\mp\_utility::func_5856(var_0D))
			{
				var_0D = maps\mp\gametypes\_class::func_4432(var_0D);
			}

			var_0E = maps\mp\gametypes\_missions::func_40EE(param_05,var_0D);
			if(isdefined(self.var_106) && var_0E == "weapon_launcher")
			{
				if(issubstr(self.var_106,"uav"))
				{
					if(isdefined(level.var_20AA["ch_uav_" + var_0D]))
					{
						param_01 maps\mp\gametypes\_missions::func_7750("ch_uav_" + var_0D);
					}
				}

				if(issubstr(self.var_106,"warbird"))
				{
					if(isdefined(level.var_20AA["ch_warbird_" + var_0D]))
					{
						param_01 maps\mp\gametypes\_missions::func_7750("ch_warbird_" + var_0D);
					}
				}

				if(issubstr(self.var_106,"orbital_platform"))
				{
					if(isdefined(level.var_20AA["ch_paladin_" + var_0D]))
					{
						param_01 maps\mp\gametypes\_missions::func_7750("ch_paladin_" + var_0D);
					}
				}

				if(issubstr(self.var_106,"drone") && !issubstr(self.var_106,"uav"))
				{
					if(isdefined(level.var_20AA["ch_drone_" + var_0D]))
					{
						param_01 maps\mp\gametypes\_missions::func_7750("ch_drone_" + var_0D);
					}
				}
			}
		}

		self.var_93FD = 1;
		self thread [[ self.var_6AE6 ]](param_01,param_05,param_04,param_02);
	}
}

//Function Number: 80
func_575B(param_00)
{
	foreach(var_02 in self.var_118F)
	{
		if(param_00 == var_02)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 81
func_62A6(param_00,param_01,param_02,param_03)
{
	var_04 = param_03;
	var_04 = func_4AD4(param_01,param_02,var_04);
	var_04 = func_4ABD(param_01,param_02,var_04,param_00);
	var_04 = func_4AD5(param_01,param_02,var_04);
	var_04 = func_4AC8(param_01,param_02,var_04);
	var_04 = func_4AB7(param_01,param_02,var_04,param_00);
	return var_04;
}

//Function Number: 82
func_4AD5(param_00,param_01,param_02)
{
	var_03 = param_02;
	switch(param_00)
	{
		case "airstrike_missile_mp":
		case "carepackage_crate_mp":
		case "stinger_mp":
		case "bomb_site_mp":
			self.var_5AFE = 1;
			var_03 = self.var_FB + 1;
			break;
	}

	return var_03;
}

//Function Number: 83
func_4AC8(param_00,param_01,param_02)
{
	if(param_00 == "stun_grenade_mp")
	{
		self notify("concussed");
		return 0;
	}
	else if(isexplosivedamagemod(param_01))
	{
		switch(param_00)
		{
			case "frag_grenade_german_mp":
			case "semtex_mp":
			case "frag_grenade_mp":
				param_02 = param_02 * 4;
				break;

			default:
				if(maps\mp\_utility::func_57E5(param_00,"alt_"))
				{
					param_02 = param_02 * 3;
				}
				break;
		}
	}

	return param_02;
}

//Function Number: 84
func_4AD4(param_00,param_01,param_02)
{
	if(maps\mp\_utility::func_5755(param_01))
	{
		var_03 = int(self.var_FB / 3) + 1;
		if(var_03 > param_02)
		{
			return var_03;
		}
	}

	return param_02;
}

//Function Number: 85
func_4ABD(param_00,param_01,param_02,param_03)
{
	if((param_00 == "emp_grenade_mp" || param_00 == "emp_grenade_killstreak_mp") && param_01 == "MOD_GRENADE_SPLASH" || param_01 == "MOD_GRENADE")
	{
		self notify("emp_damage",param_03,8);
		return 0;
	}

	return param_02;
}

//Function Number: 86
func_4AB7(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_00) && isplayer(param_03) && isdefined(self.var_117) && isdefined(self.var_117.var_1A7))
	{
		if(param_03 maps\mp\_utility::func_649("specialty_streakdamager"))
		{
			return param_02 * param_03.var_2998;
		}
	}

	return param_02;
}

//Function Number: 87
func_6B4B(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	var_08 = undefined;
	if(isdefined(param_00) && isdefined(self.var_117))
	{
		if(isdefined(param_00.var_117) && isplayer(param_00.var_117))
		{
			param_00 = param_00.var_117;
		}

		if(param_00 == self.var_117)
		{
			return;
		}

		if(issentient(self.var_117) && issentient(param_00))
		{
			if(!isalliedsentient(self.var_117,param_00))
			{
				var_08 = param_00;
			}
		}
		else if(level.var_984D)
		{
			if(self.var_117.var_1A7 != param_00.var_1A7)
			{
				var_08 = param_00;
			}
		}
		else if(self.var_117 != param_00)
		{
			var_08 = param_00;
		}
	}

	if(isdefined(var_08))
	{
		var_08 notify("destroyed_killstreak",param_01);
		var_08 maps\mp\_utility::func_50EA(param_04,1);
		level thread maps\mp\gametypes\_rank::func_1457(param_04,var_08,param_01,undefined,param_02);
		if(isdefined(level.var_5A7D) && isdefined(level.var_5A7D[param_01]))
		{
			var_09 = level.var_5A7D[param_01];
			if(var_09 == "counter_uav" || var_09 == "flak_gun")
			{
				var_08 maps\mp\gametypes\_persistence::incrementscorestreakstat(var_09,"killsOrAssists",1);
			}
		}

		var_0A = maps\mp\_events::func_43D6(param_01,param_02);
		if(var_0A == "fighter_strike_kill")
		{
			if(param_04 == "airstrike_destroyed" || param_04 == "fire_bombing_run_destroyed" || param_04 == "carepackage_plane_destroyed" || param_04 == "emergency_carepackage_plane_destroyed" || param_04 == "uav_destroyed" || param_04 == "counter_uav_destroyed" || param_04 == "plane_gunner_destroyed" || param_04 == "paratroopers_plane_destroyed")
			{
				var_08 maps\mp\gametypes\_missions::func_7750("ch_streak_interceptor");
			}
		}

		if(isdefined(self.var_6F2A) && !self.var_6F2A)
		{
			if(param_04 == "carepackage_plane_destroyed" || param_04 == "emergency_carepackage_plane_destroyed" || param_04 == "paratroopers_plane_destroyed")
			{
				var_08 maps\mp\gametypes\_missions::func_7750("ch_streak_denied");
			}
			else if(param_04 == "airstrike_destroyed" || param_04 == "fire_bombing_run_destroyed")
			{
				var_08 maps\mp\gametypes\_missions::func_7750("ch_streak_bomberdefense");
			}
		}

		if(param_04 == "plane_gunner_destroyed")
		{
			var_08 maps\mp\gametypes\_missions::func_7750("ch_streak_ballout");
		}

		if(param_04 == "paratroopers_destroyed")
		{
			var_08 maps\mp\gametypes\_missions::func_7750("ch_streak_rearguard");
		}

		if(param_04 == "fritzx_destroyed")
		{
			var_08 maps\mp\gametypes\_missions::func_7750("ch_streak_movingtarget");
		}

		var_0B = maps\mp\_utility::func_45B5(param_01);
		var_0C = maps\mp\gametypes\_missions::func_40EE(param_01,var_0B);
		if(var_0C == "weapon_projectile" && isdefined(self.var_1C8) && var_0B != "dp28_mp")
		{
			var_08 maps\mp\gametypes\_missions::func_7750("ch_camo_" + var_0B);
			var_08 notify("increment_camo_multidestroy",var_0B);
			var_0D = gettime();
			if(isdefined(self.var_5C2F) && var_0D - self.var_5C2F <= 20000)
			{
				var_08 maps\mp\gametypes\_missions::func_99C5(param_01,"ch_camoT2_quicklaunch_");
			}

			if(isdefined(var_08.streaksdestroyedthislife))
			{
				if(isdefined(var_08.streaksdestroyedthislife[var_0B]))
				{
					var_08.streaksdestroyedthislife[var_0B]++;
				}
				else
				{
					var_08.streaksdestroyedthislife[var_0B] = 1;
				}

				if(var_08.streaksdestroyedthislife[var_0B] == 2)
				{
					var_08 maps\mp\gametypes\_missions::func_99C5(param_01,"ch_camoT2_doubledestroy_");
				}
			}
		}

		if(isdefined(param_06))
		{
			level thread maps\mp\_utility::func_9863(param_06,var_08);
		}

		if(isdefined(param_07) && param_07)
		{
			if(param_01 == "counter_recon_gun_mp")
			{
				var_08 maps\mp\gametypes\_missions::func_7750("ch_streak_counteruav");
			}
			else if(param_01 == "killstreak_flak_gun_mp")
			{
				var_08 maps\mp\gametypes\_missions::func_7750("ch_streak_flakgun");
			}
			else
			{
				var_08 maps\mp\gametypes\_missions::func_7750("ch_streak_antiair");
			}

			level thread maps\mp\gametypes\_missions::func_A3F7(self.var_117,self,undefined,var_08,param_03,param_02,param_01);
		}
	}

	thread maps\mp\_events::func_21EF(var_08);
	if(isdefined(self.var_117) && isdefined(param_05))
	{
		self.var_117 thread maps\mp\_utility::func_5C43(param_05);
	}
}

//Function Number: 88
func_4CAB(param_00)
{
	level endon("game_ended");
	if(!isdefined(self))
	{
		return;
	}

	if(!isdefined(self.var_267E))
	{
		return;
	}

	if(function_01EF(self) && isdefined(self.var_A4B) && self.var_A4B == "paratroopers")
	{
		return;
	}

	if(self method_843D())
	{
		return;
	}

	if(self.var_267E[4] != 0)
	{
		func_4505();
	}

	if(!isdefined(self.var_4BA9))
	{
		return;
	}
	else
	{
		self.var_267E[4] = 0;
	}

	var_01 = spawn("script_model",self.var_116 + (0,0,20));
	var_01 setmodel(self.var_4BA9);
	var_01.var_116 = self gettagorigin("j_head") + (0,0,20);
	var_01.var_1D = self gettagangles("j_head");
	var_02 = spawn("script_model",var_01.var_116);
	var_02 setmodel("helmet_collision");
	var_02.var_1D = var_01.var_1D;
	if(function_01EF(self))
	{
		self method_8528(2);
	}
	else
	{
		self setcostumemodels(self.var_267E);
	}

	self.var_4BA9 = undefined;
	var_01 linkto(var_02);
	var_02.var_6292 = var_01;
	var_02 thread func_4CA9(param_00);
	var_02 hideallparts();
}

//Function Number: 89
func_4CA9(param_00)
{
	level endon("game_ended");
	setdvarifuninitialized("helmet_launch_vel",10000);
	setdvarifuninitialized("helmet_launch_z_force",6000);
	if(!isdefined(param_00))
	{
		param_00 = anglestoforward(self.var_1D);
	}

	var_01 = param_00;
	var_02 = var_01[0] * getdvarint("helmet_launch_vel");
	var_03 = var_01[1] * getdvarint("helmet_launch_vel");
	var_04 = var_01[2] * getdvarint("helmet_launch_z_force");
	var_05 = self.var_116 + param_00 * -5;
	self method_82C5(var_05,(var_02,var_03,var_04));
	wait(15);
	self.var_6292 delete();
	self delete();
}

//Function Number: 90
func_4505()
{
	var_00 = "hat";
	var_01 = level.var_2686[var_00];
	var_02 = self.var_267E[4];
	var_03 = undefined;
	var_04 = createcostumeguid(var_01,var_02);
	if(self.var_1A7 == "allies")
	{
		var_03 = "mp/costumeIdTable.csv";
	}
	else
	{
		var_03 = "mp/axisCostumeIdTable.csv";
	}

	var_05 = tablelookup(var_03,7,var_04,4);
	if(self.var_1A7 == "allies")
	{
		var_03 = "mp/costumeModelTable.csv";
	}
	else
	{
		var_03 = "mp/axisCostumeModelTable.csv";
	}

	var_06 = tablelookuprownum(var_03,1,"hat");
	self.var_4BA9 = undefined;
	while(isdefined(var_06) && var_06 >= 0)
	{
		var_07 = tablelookupbyrow(var_03,var_06,1);
		if(var_07 == "hat")
		{
			if(var_05 == tablelookupbyrow(var_03,var_06,3))
			{
				self.var_4BA9 = tablelookupbyrow(var_03,var_06,0);
				break;
			}
		}

		var_06 = var_06 - 1;
	}
}