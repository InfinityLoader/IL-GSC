/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\contractchallenges.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 24
 * Decompile Time: 924 ms
 * Timestamp: 10/27/2023 12:22:34 AM
*******************************************************************/

//Function Number: 1
registercontractchallenges()
{
	level.contractchallenges = [];
	registercontractchallenge("con_test",::contracttestchallenge);
	registercontractchallenge("con_kills",::contractkills);
	registercontractchallenge("con_kills_ads",::contractkills);
	registercontractchallenge("con_kills_modified",::contractkills);
	registercontractchallenge("con_kills_headshot",::contractkills);
	registercontractchallenge("con_kills_AR",::contractkills);
	registercontractchallenge("con_kills_LMG",::contractkills);
	registercontractchallenge("con_kills_SG",::contractkills);
	registercontractchallenge("con_kills_Sniper",::contractkills);
	registercontractchallenge("con_kills_SMG",::contractkills);
	registercontractchallenge("con_kills_rig_jtf",::contractkills);
	registercontractchallenge("con_kills_rig_orion",::contractkills);
	registercontractchallenge("con_kills_rig_sabre7",::contractkills);
	registercontractchallenge("con_kills_rig_wraith",::contractkills);
	registercontractchallenge("con_kills_rig_bloodanvil",::contractkills);
	registercontractchallenge("con_battle_buddy",::contractkills);
	registercontractchallenge("con_kills_variant",::contractkills);
	registercontractchallenge("con_kills_oneshot",::contractkills);
	registercontractchallenge("con_kills_double",::contractkillsrapid);
	registercontractchallenge("con_kills_payload",::contractkillspayload);
	registercontractchallenge("con_kills_rig_jtf_payload",::contractkillspayload);
	registercontractchallenge("con_kills_rig_orion_payload",::contractkillspayload);
	registercontractchallenge("con_kills_rig_sabre7_payload",::contractkillspayload);
	registercontractchallenge("con_kills_rig_wraith_payload",::contractkillspayload);
	registercontractchallenge("con_kills_rig_bloodanvil_payload",::contractkillspayload);
	registercontractchallenge("con_kills_gesture",::contractkillsgesture);
	registercontractchallenge("con_scorestreak_support",::contractscorestreaksupport);
	registercontractchallenge("con_scorestreak_air",::contractscorestreakair);
	registercontractchallenge("con_scorestreak_ground",::contractscorestreakground);
	registercontractchallenge("con_scorestreak_destroy",::contractscorestreakdestroy);
	registercontractchallenge("con_scorestreak_count",::contractscorestreakcount);
	registercontractchallenge("con_medals_objective",::contractmedalsobjective);
	registercontractchallenge("con_wins",::contractempty);
	registercontractchallenge("con_wins_top3",::contractempty);
	registercontractchallenge("con_kdr",::contractempty);
	registercontractchallenge("con_wins_objective",::contractempty);
	registercontractchallenge("con_wins_slayer",::contractempty);
	registercontractchallenge("con_wins_hardcore",::contractempty);
	registercontractchallenge("con_damage",::contractempty);
	registercontractchallenge("con_shots_landed",::contractempty);
	registercontractchallenge("con_equipment_hits",::contractempty);
	registercontractchallenge("con_kills_streak",::contractempty);
}

//Function Number: 2
registercontractchallenge(param_00,param_01)
{
	level.contractchallenges[param_00] = param_01;
}

//Function Number: 3
contractempty(param_00)
{
}

//Function Number: 4
contracttestchallenge(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		wait(1);
		scripts\mp\contracts::updatecontractprogress(param_00);
	}
}

//Function Number: 5
contractkillsimmediate(param_00,param_01,param_02,param_03,param_04)
{
	if(!isdefined(self.contracts))
	{
		return;
	}

	foreach(var_06 in self.contracts)
	{
		var_07 = 0;
		switch(var_06.var_DE3F)
		{
			case "con_kills_streak":
				var_08 = self.pers["cur_kill_streak"];
				if(isdefined(var_08))
				{
					if(var_08 % 5 == 0)
					{
						var_07 = 1;
					}
				}
				break;

			case "con_kills_gesture":
				if(isdefined(self.var_A960))
				{
					var_09 = gettime();
					if(abs(self.var_A960 - var_09) < 3000)
					{
						var_0A = param_00 getentitynumber();
						thread stampkillgesture(var_0A);
						var_07 = 1;
					}
				}
				break;
		}

		if(var_07)
		{
			scripts\mp\contracts::updatecontractprogress(var_06);
		}
	}
}

//Function Number: 6
contractkills(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	if(param_00.var_DE3F == "con_battle_buddy")
	{
		thread contractassists(param_00);
	}

	for(;;)
	{
		self waittill("kill_event_buffered",var_01,var_02,var_03,var_04);
		var_05 = 0;
		switch(param_00.var_DE3F)
		{
			case "con_kills":
				var_05 = 1;
				break;
	
			case "con_kills_ads":
				if(scripts\mp\_utility::func_9FB3(var_04["ads"]))
				{
					var_05 = 1;
				}
				break;
	
			case "con_kills_modified":
				if(scripts\mp\_utility::func_9FB3(var_04["sliding"]) || scripts\mp\_utility::func_9FB3(var_04["hipfire"]) || scripts\mp\_utility::func_9FB3(var_04["airborne"]) || scripts\mp\_utility::func_9FB3(var_04["wallkill"]))
				{
					var_05 = 1;
				}
				break;
	
			case "con_kills_headshot":
				if(scripts\mp\_utility::func_9FB3(var_04["headshot"]))
				{
					var_05 = 1;
				}
				break;
	
			case "con_kills_AR":
				var_02 = scripts\mp\_utility::func_13CA1(var_02);
				if(var_03 != "MOD_MELEE" && !scripts\mp\_utility::func_9E6C(var_02) && scripts\mp\_utility::func_8225(var_02) == "weapon_assault")
				{
					var_05 = 1;
				}
				break;
	
			case "con_kills_LMG":
				var_02 = scripts\mp\_utility::func_13CA1(var_02);
				if(var_03 != "MOD_MELEE" && !scripts\mp\_utility::func_9E6C(var_02) && scripts\mp\_utility::func_8225(var_02) == "weapon_lmg")
				{
					var_05 = 1;
				}
				break;
	
			case "con_kills_SG":
				var_02 = scripts\mp\_utility::func_13CA1(var_02);
				if(var_03 != "MOD_MELEE" && !scripts\mp\_utility::func_9E6C(var_02) && scripts\mp\_utility::func_8225(var_02) == "weapon_shotgun")
				{
					var_05 = 1;
				}
		
				if(self method_8519(var_02))
				{
					var_06 = scripts\mp\_utility::func_8234(var_02);
					var_07 = function_02C4(var_02);
					if(var_06 == "iw7_longshot")
					{
						var_05 = 1;
					}
		
					if(var_06 == "iw7_erad" && isdefined(var_07) && var_07 == 3 || var_07 == 35)
					{
						var_05 = 1;
					}
				}
				break;
	
			case "con_kills_Sniper":
				var_02 = scripts\mp\_utility::func_13CA1(var_02);
				if(var_03 != "MOD_MELEE" && !scripts\mp\_utility::func_9E6C(var_02) && scripts\mp\_utility::func_8225(var_02) == "weapon_sniper")
				{
					var_05 = 1;
				}
				break;
	
			case "con_kills_SMG":
				var_02 = scripts\mp\_utility::func_13CA1(var_02);
				if(var_03 != "MOD_MELEE" && !scripts\mp\_utility::func_9E6C(var_02) && scripts\mp\_utility::func_8225(var_02) == "weapon_smg")
				{
					var_05 = 1;
				}
				break;
	
			case "con_battle_buddy":
				if(scripts\mp\_utility::func_9FB3(var_04["buddy_kill"]))
				{
					var_05 = 1;
				}
				break;
	
			case "con_kills_rig_jtf":
				var_08 = ["archetype_assault","archetype_heavy","archetype_scout"];
				var_05 = archtypecheck(var_08);
				break;
	
			case "con_kills_rig_orion":
				var_08 = ["archetype_assault","archetype_heavy","archetype_engineer"];
				var_05 = archtypecheck(var_08);
				break;
	
			case "con_kills_rig_sabre7":
				var_08 = ["archetype_engineer","archetype_assassin"];
				var_05 = archtypecheck(var_08);
				break;
	
			case "con_kills_rig_wraith":
				var_08 = ["archetype_sniper","archetype_scout"];
				var_05 = archtypecheck(var_08);
				break;
	
			case "con_kills_rig_bloodanvil":
				var_08 = ["archetype_heavy","archetype_assassin"];
				var_05 = archtypecheck(var_08);
				break;
	
			case "con_kills_variant":
				var_05 = isdefined(function_02C4(var_02));
				break;
	
			case "con_kills_oneshot":
				if(scripts\mp\_utility::func_9FB3(var_04["oneshotkill"]) || scripts\mp\_utility::func_9FB3(var_04["oneshotkill_shotgun"]))
				{
					var_05 = 1;
				}
				break;
		}

		if(var_05)
		{
			scripts\mp\contracts::updatecontractprogress(param_00);
		}
	}
}

//Function Number: 7
contractassists(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		self waittill("assist_buffered",var_01);
		var_02 = 0;
		switch(param_00.var_DE3F)
		{
			case "con_battle_buddy":
				if(isdefined(var_01) && scripts\mp\_utility::func_9FB3(var_01["buddy_kill"]))
				{
					var_02 = 1;
				}
				break;
		}

		if(var_02)
		{
			scripts\mp\contracts::updatecontractprogress(param_00);
		}
	}
}

//Function Number: 8
contractkillsrapid(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		self waittill("update_rapid_kill_buffered",var_01);
		var_02 = 0;
		switch(param_00.var_DE3F)
		{
			case "con_kills_double":
				if(var_01 % 2 == 0)
				{
					var_02 = 1;
				}
				break;
		}

		if(var_02)
		{
			scripts\mp\contracts::updatecontractprogress(param_00);
		}
	}
}

//Function Number: 9
contractkillspayload(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		self waittill("super_kill_buffered");
		var_01 = 0;
		switch(param_00.var_DE3F)
		{
			case "con_kills_payload":
				var_01 = 1;
				break;
	
			case "con_kills_rig_jtf_payload":
				var_02 = ["archetype_assault","archetype_heavy","archetype_scout"];
				var_01 = archtypecheck(var_02);
				break;
	
			case "con_kills_rig_orion_payload":
				var_02 = ["archetype_assault","archetype_heavy","archetype_engineer"];
				var_01 = archtypecheck(var_02);
				break;
	
			case "con_kills_rig_sabre7_payload":
				var_02 = ["archetype_engineer","archetype_assassin"];
				var_01 = archtypecheck(var_02);
				break;
	
			case "con_kills_rig_wraith_payload":
				var_02 = ["archetype_sniper","archetype_scout"];
				var_01 = archtypecheck(var_02);
				break;
	
			case "con_kills_rig_bloodanvil_payload":
				var_02 = ["archetype_heavy","archetype_assassin"];
				var_01 = archtypecheck(var_02);
				break;
		}

		if(var_01)
		{
			scripts\mp\contracts::updatecontractprogress(param_00);
		}
	}
}

//Function Number: 10
archtypecheck(param_00)
{
	foreach(var_02 in param_00)
	{
		if(scripts\mp\_utility::func_9D48(var_02))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 11
contractscorestreaksupport(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		self waittill("killstreak_used",var_01);
		var_02 = 0;
		switch(var_01)
		{
			case "dronedrop":
			case "directional_uav":
			case "counter_uav":
			case "uav":
				var_02 = 1;
				break;
		}

		if(var_02)
		{
			scripts\mp\contracts::updatecontractprogress(param_00);
		}
	}
}

//Function Number: 12
contractscorestreakair(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		self waittill("kill_event_buffered",var_01,var_02);
		var_03 = 0;
		if(scripts\mp\_utility::func_9E6C(var_02))
		{
			var_04 = scripts\mp\_missions::func_7F48(var_02);
			switch(var_04)
			{
				case "jackal":
				case "bombardment":
				case "precision_airstrike":
				case "thor":
				case "minijackal":
				case "drone_hive":
					var_03 = 1;
					break;
			}

			if(var_03)
			{
				scripts\mp\contracts::updatecontractprogress(param_00);
			}
		}
	}
}

//Function Number: 13
contractscorestreakground(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		self waittill("kill_event_buffered",var_01,var_02);
		var_03 = 0;
		if(scripts\mp\_utility::func_9E6C(var_02))
		{
			var_04 = scripts\mp\_missions::func_7F48(var_02);
			switch(var_04)
			{
				case "ball_drone_backup":
				case "remote_c8":
				case "venom":
				case "sentry_shock":
					var_03 = 1;
					break;
			}

			if(var_03)
			{
				scripts\mp\contracts::updatecontractprogress(param_00);
			}
		}
	}
}

//Function Number: 14
contractscorestreakdestroy(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		self waittill("earned_award_buffered",var_01);
		if(issubstr(var_01,"kill_ss_"))
		{
			scripts\mp\contracts::updatecontractprogress(param_00);
		}
	}
}

//Function Number: 15
contractscorestreakcount(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		self waittill("killstreak_used",var_01);
		if(!isdefined(self.pers["con_scorestreak_count"]))
		{
			self.pers["con_scorestreak_count"] = 1;
		}
		else
		{
			self.pers["con_scorestreak_count"]++;
		}

		if(self.pers["con_scorestreak_count"] % 2 == 0)
		{
			scripts\mp\contracts::updatecontractprogress(param_00);
		}
	}
}

//Function Number: 16
contractmatchend(param_00)
{
	if(!isdefined(self.contracts))
	{
		return;
	}

	foreach(var_02 in self.contracts)
	{
		var_03 = 0;
		switch(var_02.var_DE3F)
		{
			case "con_wins":
				if(param_00.var_13D8A)
				{
					var_03 = 1;
				}
				break;

			case "con_wins_top3":
				if(param_00.var_13D8A && param_00.var_CBFC < 3)
				{
					var_03 = 1;
				}
				break;

			case "con_kdr":
				if(self.pers["kdratio"] >= 2)
				{
					var_03 = 1;
				}
				break;

			case "con_wins_objective":
				if(param_00.var_13D8A)
				{
					switch(level.gametype)
					{
						case "tdef":
						case "koth":
						case "grind":
						case "dom":
						case "conf":
						case "dd":
						case "ball":
						case "ctf":
						case "siege":
						case "sd":
						case "sr":
							var_03 = 1;
							break;
					}
				}
				break;

			case "con_wins_slayer":
				if(param_00.var_13D8A)
				{
					switch(level.gametype)
					{
						case "conf":
						case "front":
						case "dm":
						case "war":
							var_03 = 1;
							break;
					}
				}
				break;

			case "con_wins_hardcore":
				if(param_00.var_13D8A && level.var_8B38)
				{
					var_03 = 1;
				}
				break;
		}

		if(var_03)
		{
			scripts\mp\contracts::updatecontractprogress(var_02);
		}
	}
}

//Function Number: 17
contractmedalsobjective(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	for(;;)
	{
		thread contractnotifylistener("earned_award_buffered","update_objective_medal");
		thread contractnotifylistener("bomb_planted","update_objective_medal");
		self waittill("update_objective_medal",var_01);
		if(isdefined(var_01))
		{
			if(var_01 == "mode_x_assault" || var_01 == "mode_sd_defuse_save" || var_01 == "mode_uplink_kill_with_ball" || var_01 == "mode_ctf_kill_with_flag" || var_01 == "mode_x_defend" || var_01 == "mode_sd_plant_save" || var_01 == "mode_uplink_kill_carrier" || var_01 == "mode_ctf_kill_carrier" || var_01 == "mode_dom_secure_b" || var_01 == "mode_dom_secure_neutral" || var_01 == "mode_dom_secure" || var_01 == "mode_hp_secure" || var_01 == "mode_sd_last_defuse" || var_01 == "mode_sd_defuse" || var_01 == "mode_uplink_dunk" || var_01 == "mode_uplink_fieldgoal" || var_01 == "mode_ctf_cap" || var_01 == "mode_siege_secure")
			{
				scripts\mp\contracts::updatecontractprogress(param_00);
			}

			continue;
		}

		scripts\mp\contracts::updatecontractprogress(param_00);
	}
}

//Function Number: 18
contractnotifylistener(param_00,param_01)
{
	self waittill(param_00,var_02);
	self notify(param_01,var_02);
}

//Function Number: 19
contractplayerdamaged(param_00)
{
	if(!isdefined(self.contracts))
	{
		return;
	}

	foreach(var_02 in self.contracts)
	{
		if(var_02.var_DE3F == "con_damage")
		{
			scripts\mp\contracts::updatecontractprogress(var_02,param_00);
		}
	}
}

//Function Number: 20
contractshotslanded(param_00)
{
	if(!isdefined(self.contracts))
	{
		return;
	}

	foreach(var_02 in self.contracts)
	{
		if(var_02.var_DE3F == "con_shots_landed")
		{
			scripts\mp\contracts::updatecontractprogress(var_02);
		}
	}
}

//Function Number: 21
contractkillsgesture(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	self.contractkillgesture = [];
	for(;;)
	{
		self waittill("used_cosmetic_gesture");
		var_01 = gettime();
		foreach(var_03 in self.var_A684)
		{
			if(abs(var_03.time - var_01) < 3000)
			{
				if(!isdefined(self.contractkillgesture[var_03.victimid]))
				{
					thread stampkillgesture(var_03.victimid);
					scripts\mp\contracts::updatecontractprogress(param_00);
				}
			}
		}
	}
}

//Function Number: 22
stampkillgesture(param_00)
{
	self endon("disconnect");
	self endon("game_ended");
	self.contractkillgesture[param_00] = 1;
	wait(3);
	self.contractkillgesture[param_00] = undefined;
}

//Function Number: 23
contractequipmentdamagedplayer(param_00,param_01,param_02)
{
	if(!isdefined(self.contracts))
	{
		return;
	}

	foreach(var_04 in self.contracts)
	{
		if(var_04.var_DE3F == "con_equipment_hits")
		{
			if(!isdefined(self.equipmentdamageinflictors))
			{
				self.equipmentdamageinflictors = [];
			}

			if(!isdefined(self.equipmentdamageinflictors[param_00.var_86BD]))
			{
				self.equipmentdamageinflictors[param_00.var_86BD] = [];
			}

			if(isdefined(param_02.parentinflictor))
			{
				var_05 = param_02.parentinflictor;
			}
			else
			{
				var_05 = var_03 getentitynumber();
			}

			var_06 = var_05 + "_" + scripts\mp\_utility::func_13CA1(param_01);
			if(param_00 != self && !isdefined(self.equipmentdamageinflictors[param_00.var_86BD][var_06]))
			{
				thread stampinflictordamage(param_00.var_86BD,var_06);
				scripts\mp\contracts::updatecontractprogress(var_04);
			}
		}
	}
}

//Function Number: 24
stampinflictordamage(param_00,param_01)
{
	self endon("disconnect");
	self endon("game_ended");
	self.equipmentdamageinflictors[param_00][param_01] = 1;
	wait(5);
	self.equipmentdamageinflictors[param_00][param_01] = undefined;
}