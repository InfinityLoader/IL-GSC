/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_missions.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 94
 * Decompile Time: 1464 ms
 * Timestamp: 4/22/2024 2:10:01 AM
*******************************************************************/

//Function Number: 1
init()
{
	precachestring(&"MP_CHALLENGE_COMPLETED");
	if(!mayprocesschallenges())
	{
		return;
	}

	level.missioncallbacks = [];
	registermissioncallback("playerKilled",::ch_kills);
	registermissioncallback("playerKilled",::ch_vehicle_kills);
	registermissioncallback("playerHardpoint",::ch_hardpoints);
	registermissioncallback("playerAssist",::ch_assists);
	registermissioncallback("roundEnd",::ch_roundwin);
	registermissioncallback("roundEnd",::ch_roundplayed);
	registermissioncallback("vehicleKilled",::ch_vehicle_killed);
	level thread onplayerconnect();
}

//Function Number: 2
mayprocesschallenges()
{
	if(maps\mp\_utility::practiceroundgame())
	{
		return 0;
	}

	return level.rankedmatch;
}

//Function Number: 3
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(isbot(var_00))
		{
			continue;
		}

		if(!isdefined(var_00.pers["postGameChallenges"]))
		{
			var_00.pers["postGameChallenges"] = 0;
		}

		var_00 thread onplayerspawned();
		var_00 thread initmissiondata();
		var_00 thread monitorbombuse();
		var_00 thread monitorstreaks();
		var_00 thread monitorstreakreward();
		var_00 thread monitorscavengerpickup();
		var_00 thread monitorblastshieldsurvival();
		var_00 thread monitorprocesschallenge();
		var_00 thread monitorkillstreakprogress();
		var_00 thread monitorfinalstandsurvival();
		var_00 thread monitoradstime();
		var_00 thread monitorpronetime();
		var_00 thread monitorpowerslidetime();
		var_00 thread monitorweaponswap();
		var_00 thread monitorflashbang();
		var_00 thread monitorconcussion();
		var_00 thread monitorminetriggering();
		var_00 thread monitorboostjumpdistance();
		var_00 thread monitorplayermatchchallenges();
		var_00 notifyonplayercommand("hold_breath","+breath_sprint");
		var_00 notifyonplayercommand("hold_breath","+melee_breath");
		var_00 notifyonplayercommand("release_breath","-breath_sprint");
		var_00 notifyonplayercommand("release_breath","-melee_breath");
		var_00 thread monitorholdbreath();
		var_00 notifyonplayercommand("jumped","+goStand");
		var_00 thread monitormantle();
	}
}

//Function Number: 4
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		thread onplayerdeath();
		thread monitorsprintdistance();
	}
}

//Function Number: 5
onplayerdeath()
{
	self endon("disconnect");
	self waittill("death");
	if(isdefined(self.hasscavengedammothislife))
	{
		self.hasscavengedammothislife = 0;
	}
}

//Function Number: 6
monitorscavengerpickup()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("scavenger_pickup");
		if(self isitemunlocked("specialty_scavenger") && maps\mp\_utility::_hasperk("specialty_scavenger") && !maps\mp\_utility::isjuggernaut())
		{
			processchallenge("ch_scavenger_pro");
			self.hasscavengedammothislife = 1;
		}

		wait(0.05);
	}
}

//Function Number: 7
monitorstreakreward()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("received_earned_killstreak");
		if(self isitemunlocked("specialty_hardline") && maps\mp\_utility::_hasperk("specialty_hardline"))
		{
			processchallenge("ch_hardline_pro");
		}

		wait(0.05);
	}
}

//Function Number: 8
monitorblastshieldsurvival()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("survived_explosion",var_00);
		if(isdefined(var_00) && isplayer(var_00) && self == var_00)
		{
			continue;
		}

		if(self isitemunlocked("_specialty_blastshield") && maps\mp\_utility::_hasperk("_specialty_blastshield"))
		{
			processchallenge("ch_blastshield_pro");
		}

		wait 0.05;
	}
}

//Function Number: 9
monitorfinalstandsurvival()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("revive");
		processchallenge("ch_livingdead");
		wait 0.05;
	}
}

//Function Number: 10
initmissiondata()
{
	var_00 = getarraykeys(level.killstreakfuncs);
	foreach(var_02 in var_00)
	{
		self.pers[var_02] = 0;
	}

	self.pers["lastBulletKillTime"] = 0;
	self.pers["bulletStreak"] = 0;
	self.explosiveinfo = [];
}

//Function Number: 11
registermissioncallback(param_00,param_01)
{
	if(!isdefined(level.missioncallbacks[param_00]))
	{
		level.missioncallbacks[param_00] = [];
	}

	level.missioncallbacks[param_00][level.missioncallbacks[param_00].size] = param_01;
}

//Function Number: 12
getchallengestatus(param_00)
{
	if(isdefined(self.challengedata[param_00]))
	{
		return self.challengedata[param_00];
	}

	return 0;
}

//Function Number: 13
ch_assists(param_00)
{
	var_01 = param_00.player;
	var_01 processchallenge("ch_assists");
}

//Function Number: 14
ch_streak_kill(param_00)
{
	switch(param_00)
	{
		case "vulcan_kill":
			processchallenge("ch_streak_orbitallaser");
			break;

		case "warbird_kill":
			processchallenge("ch_streak_warbird");
			break;

		case "paladin_kill":
			processchallenge("ch_streak_paladin");
			break;

		case "missile_strike_kill":
			processchallenge("ch_streak_missle");
			break;

		case "sentry_gun_kill":
			processchallenge("ch_streak_sentry");
			break;

		case "strafing_run_kill":
			processchallenge("ch_streak_strafing");
			break;

		case "assault_drone_kill":
			processchallenge("ch_streak_assault");
			break;

		case "goliath_kill":
			processchallenge("ch_streak_goliath");
			break;

		default:
			break;
	}
}

//Function Number: 15
ch_hardpoints(param_00)
{
	if(isbot(param_00.player))
	{
		return;
	}

	var_01 = param_00.player;
	var_01.pers[param_00.hardpointtype]++;
	switch(param_00.hardpointtype)
	{
		case "uav":
			var_01 processchallenge("ch_uav");
			var_01 processchallenge("ch_assault_streaks");
			if(var_01.pers["uav"] >= 3)
			{
				var_01 processchallenge("ch_nosecrets");
			}
			break;

		case "airdrop_assault":
			var_01 processchallenge("ch_airdrop_assault");
			var_01 processchallenge("ch_assault_streaks");
			break;

		case "airdrop_sentry_minigun":
			var_01 processchallenge("ch_airdrop_sentry_minigun");
			var_01 processchallenge("ch_assault_streaks");
			break;

		case "nuke":
			var_01 processchallenge("ch_nuke");
			break;
	}
}

//Function Number: 16
ch_vehicle_kills(param_00)
{
	if(!isdefined(param_00.attacker) || !isplayer(param_00.attacker))
	{
		return;
	}

	if(!maps\mp\_utility::iskillstreakweapon(param_00.sweapon))
	{
		return;
	}

	var_01 = param_00.attacker;
	if(!isdefined(var_01.pers[param_00.sweapon + "_streak"]) || isdefined(var_01.pers[param_00.sweapon + "_streakTime"]) && gettime() - var_01.pers[param_00.sweapon + "_streakTime"] > 7000)
	{
		var_01.pers[param_00.sweapon + "_streak"] = 0;
		var_01.pers[param_00.sweapon + "_streakTime"] = gettime();
	}

	var_01.pers[param_00.sweapon + "_streak"]++;
	switch(param_00.sweapon)
	{
		case "artillery_mp":
			var_01 processchallenge("ch_carpetbomber");
			if(var_01.pers[param_00.sweapon + "_streak"] >= 5)
			{
				var_01 processchallenge("ch_carpetbomb");
			}
	
			if(isdefined(var_01.finalkill))
			{
				var_01 processchallenge("ch_finishingtouch");
			}
			break;

		case "stealth_bomb_mp":
			var_01 processchallenge("ch_thespirit");
			if(var_01.pers[param_00.sweapon + "_streak"] >= 6)
			{
				var_01 processchallenge("ch_redcarpet");
			}
	
			if(isdefined(var_01.finalkill))
			{
				var_01 processchallenge("ch_technokiller");
			}
			break;

		case "sentry_minigun_mp":
			var_01 processchallenge("ch_looknohands");
			if(isdefined(var_01.finalkill))
			{
				var_01 processchallenge("ch_absentee");
			}
			break;

		case "ac130_40mm_mp":
		case "ac130_105mm_mp":
		case "ac130_25mm_mp":
			var_01 processchallenge("ch_spectre");
			if(isdefined(var_01.finalkill))
			{
				var_01 processchallenge("ch_deathfromabove");
			}
			break;

		case "remotemissile_projectile_mp":
			var_01 processchallenge("ch_predator");
			if(var_01.pers[param_00.sweapon + "_streak"] >= 4)
			{
				var_01 processchallenge("ch_reaper");
			}
	
			if(isdefined(var_01.finalkill))
			{
				var_01 processchallenge("ch_dronekiller");
			}
			break;

		case "nuke_mp":
			param_00.victim processchallenge("ch_radiationsickness");
			break;

		default:
			break;
	}
}

//Function Number: 17
ch_vehicle_killed(param_00)
{
	if(!isdefined(param_00.attacker) || !isplayer(param_00.attacker))
	{
		return;
	}

	var_01 = param_00.attacker;
	var_02 = maps\mp\_utility::getbaseweaponname(param_00.sweapon,1);
	if(maps\mp\_utility::islootweapon(var_02))
	{
		var_02 = maps\mp\gametypes\_class::getbasefromlootversion(var_02);
	}

	var_03 = get_challenge_weapon_class(param_00.sweapon,var_02);
	if(var_03 == "weapon_launcher")
	{
		var_01 processchallenge("ch_launcher_kill");
		if(isdefined(level.challengeinfo["ch_vehicle_" + var_02]))
		{
			var_01 processchallenge("ch_vehicle_" + var_02);
		}

		if(isdefined(level.challengeinfo["ch_marksman_" + var_02]))
		{
			var_01 processchallenge("ch_marksman_" + var_02);
		}
	}

	if(var_01 maps\mp\_utility::_hasperk("specialty_coldblooded") && var_01 maps\mp\_utility::_hasperk("specialty_spygame") && var_01 maps\mp\_utility::_hasperk("specialty_heartbreaker"))
	{
		if(!isdefined(param_00.vehicle) || !isdefined(param_00.vehicle.sentrytype) || param_00.vehicle.sentrytype != "prison_turret")
		{
			var_01 processchallenge("ch_precision_airhunt");
		}
	}

	if(isdefined(param_00.vehicle) && isdefined(param_00.vehicle.vehicletype) && param_00.vehicle.vehicletype == "drone_recon" && issubstr(var_02,"exoknife"))
	{
		var_01 processchallenge("ch_precision_knife");
	}

	if(var_01 maps\mp\_utility::_hasperk("specialty_class_blindeye") && !isdefined(param_00.vehicle.vehicleinfo) || param_00.vehicle.vehicleinfo != "vehicle_tracking_drone_mp")
	{
		var_01 processchallenge("ch_perk_blindeye");
	}
}

//Function Number: 18
clearidshortly(param_00)
{
	self endon("disconnect");
	self notify("clearing_expID_" + param_00);
	self endon("clearing_expID_" + param_00);
	wait(3);
	self.explosivekills[param_00] = undefined;
}

//Function Number: 19
mgkill()
{
	var_00 = self;
	if(!isdefined(var_00.pers["MGStreak"]))
	{
		var_00.pers["MGStreak"] = 0;
		var_00 thread endmgstreakwhenleavemg();
		if(!isdefined(var_00.pers["MGStreak"]))
		{
			return;
		}
	}

	var_00.pers["MGStreak"]++;
	if(var_00.pers["MGStreak"] >= 5)
	{
		var_00 processchallenge("ch_mgmaster");
	}
}

//Function Number: 20
endmgstreakwhenleavemg()
{
	self endon("disconnect");
	for(;;)
	{
		if(!isalive(self) || self usebuttonpressed())
		{
			self.pers["MGStreak"] = undefined;
			break;
		}

		wait(0.05);
	}
}

//Function Number: 21
endmgstreak()
{
	self.pers["MGStreak"] = undefined;
}

//Function Number: 22
killedbestenemyplayer(param_00)
{
	if(!isdefined(self.pers["countermvp_streak"]) || !param_00)
	{
		self.pers["countermvp_streak"] = 0;
	}

	self.pers["countermvp_streak"]++;
	if(self.pers["countermvp_streak"] == 3)
	{
		processchallenge("ch_thebiggertheyare");
	}
	else if(self.pers["countermvp_streak"] == 5)
	{
		processchallenge("ch_thehardertheyfall");
	}

	if(self.pers["countermvp_streak"] >= 10)
	{
		processchallenge("ch_countermvp");
	}
}

//Function Number: 23
ishighestscoringplayer(param_00)
{
	if(!isdefined(param_00.score) || param_00.score < 1)
	{
		return 0;
	}

	var_01 = level.players;
	if(level.teambased)
	{
		var_02 = param_00.pers["team"];
	}
	else
	{
		var_02 = "all";
	}

	var_03 = param_00.score;
	for(var_04 = 0;var_04 < var_01.size;var_04++)
	{
		if(!isdefined(var_01[var_04].score))
		{
			continue;
		}

		if(var_01[var_04].score < 1)
		{
			continue;
		}

		if(var_02 != "all" && var_01[var_04].pers["team"] != var_02)
		{
			continue;
		}

		if(var_01[var_04].score > var_03)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 24
processchallengedaily(param_00,param_01,param_02)
{
	if(!maps\mp\_utility::rankingenabled() || maps\mp\_utility::privatematch())
	{
		return;
	}

	if(getdvarint("dailychallenge_killswitch",0) == 0 && getdvarint("dailychallenge_killswitch2",0) == 0)
	{
		return;
	}

	var_03 = self getplayerdata("dailyChallengeId",0);
	var_04 = getdvarint("scr_current_playlist",0);
	var_05 = getdvarint("scr_game_division",0);
	var_06 = 0;
	var_06 = var_04 == 1 || var_04 == 2 || var_04 == 3 || var_04 == 4;
	var_07 = 0;
	var_07 = var_04 == 3;
	if(!isdefined(var_03) || !isdefined(param_00) || var_03 != param_00)
	{
		return;
	}

	switch(var_03)
	{
		case 1:
			var_08 = param_01;
			if(isdefined(var_08) && level.gametype == "war" && var_08 == "weapon_shotgun")
			{
				processchallenge("ch_daily_01");
			}
			break;

		case 2:
			if(level.gametype == "war")
			{
				processchallenge("ch_daily_02");
			}
			break;

		case 3:
			var_08 = param_01;
			if(isdefined(var_08) && level.gametype == "conf" && var_08 == "weapon_sniper")
			{
				processchallenge("ch_daily_03");
			}
			break;

		case 4:
			if(level.gametype == "conf")
			{
				processchallenge("ch_daily_04");
			}
			break;

		case 5:
			var_08 = param_01;
			if(isdefined(var_08) && level.gametype == "dom" && var_08 == "weapon_heavy")
			{
				processchallenge("ch_daily_05");
			}
			break;

		case 6:
			if(level.gametype == "dom")
			{
				processchallenge("ch_daily_06");
			}
			break;

		case 7:
			var_08 = param_01;
			if(isdefined(var_08) && level.gametype == "dom" && var_08 == "weapon_smg")
			{
				processchallenge("ch_daily_07");
			}
			break;

		case 8:
			var_08 = param_01;
			if(isdefined(var_08) && var_06 == 1 && var_08 == "weapon_smg")
			{
				processchallenge("ch_daily_08");
			}
			break;

		case 9:
			var_08 = param_01;
			if(isdefined(var_08) && var_06 == 1 && var_08 == "weapon_heavy")
			{
				processchallenge("ch_daily_09");
			}
			break;

		case 10:
			var_08 = param_01;
			if(isdefined(var_08) && var_06 == 1 && var_08 == "weapon_launcher")
			{
				processchallenge("ch_daily_10");
			}
			break;

		case 11:
			var_09 = param_01;
			if(isdefined(var_09) && var_06 == 1 && maps\mp\_utility::iskillstreakweapon(var_09))
			{
				processchallenge("ch_daily_11");
			}
			break;

		case 12:
			var_08 = param_01;
			if(isdefined(var_08) && level.gametype == "ball" && var_08 == "weapon_shotgun")
			{
				processchallenge("ch_daily_12");
			}
			break;

		case 13:
			var_0A = param_01;
			if(isdefined(var_0A) && level.gametype == "ball")
			{
				processchallenge("ch_daily_13",var_0A);
			}
			break;

		case 14:
			var_08 = param_01;
			if(isdefined(var_08) && level.gametype == "hp" && var_08 == "weapon_smg")
			{
				processchallenge("ch_daily_14");
			}
			break;

		case 15:
			var_08 = param_01;
			if(isdefined(var_08) && level.gametype == "hp" && var_08 == "weapon_heavy")
			{
				processchallenge("ch_daily_15");
			}
			break;

		case 16:
			if(level.gametype == "ctf")
			{
				processchallenge("ch_daily_16");
			}
			break;

		case 17:
			if(level.gametype == "ctf")
			{
				processchallenge("ch_daily_17");
			}
			break;

		case 18:
			var_08 = param_01;
			if(isdefined(var_08) && level.gametype == "ctf" && var_08 == "weapon_smg")
			{
				processchallenge("ch_daily_18");
			}
			break;

		case 19:
			var_08 = param_01;
			if(isdefined(var_08) && level.gametype == "ctf" && var_08 == "weapon_heavy")
			{
				processchallenge("ch_daily_19");
			}
			break;

		case 20:
			var_09 = param_01;
			if(isdefined(var_09) && issubstr(var_09,"_lefthand"))
			{
				var_09 = maps\mp\_utility::strip_suffix(var_09,"_lefthand");
			}
	
			if(isdefined(var_09) && level.gametype == "hp" && is_lethal_equipment(var_09))
			{
				processchallenge("ch_daily_20");
			}
			break;

		case 21:
			if(level.gametype == "conf")
			{
				processchallenge("ch_daily_21");
			}
			break;

		case 22:
			var_0B = param_01;
			var_0C = 0;
			foreach(var_0E in self.ch_unique_earned_streaks)
			{
				if(var_0E == var_0B)
				{
					var_0C = 1;
					break;
				}
			}
	
			if(var_0C == 0)
			{
				self.ch_unique_earned_streaks[self.ch_unique_earned_streaks.size] = var_0B;
			}
	
			if(self.ch_unique_earned_streaks.size == 4)
			{
				processchallenge("ch_daily_22");
			}
			break;

		case 23:
			var_0B = param_01;
			if(isdefined(var_0B) && var_0B == "orbital_carepackage")
			{
				processchallenge("ch_daily_23");
			}
			break;

		case 24:
			var_09 = param_01;
			if(isdefined(var_09))
			{
				var_10 = getweaponattachments(var_09);
				if(level.gametype == "war" && maps\mp\_utility::iscacprimaryweapon(var_09) && var_10.size == 3)
				{
					processchallenge("ch_daily_24");
				}
			}
			break;

		case 25:
			if(level.gametype == "ctf")
			{
				processchallenge("ch_daily_25");
			}
			break;

		case 26:
			if(level.gametype == "dom")
			{
				processchallenge("ch_daily_26");
			}
			break;

		case 27:
			if(level.gametype == "conf")
			{
				processchallenge("ch_daily_27");
			}
			break;

		case 28:
			if(level.gametype == "ball")
			{
				processchallenge("ch_daily_28");
			}
			break;

		case 29:
			if(level.gametype == "twar")
			{
				processchallenge("ch_daily_29");
			}
			break;

		case 30:
			if(level.gametype == "hp")
			{
				processchallenge("ch_daily_30");
			}
			break;

		case 31:
			var_08 = param_01;
			if(isdefined(var_08) && level.gametype == "sd" && var_08 == "weapon_assault")
			{
				processchallenge("ch_daily_31");
			}
			break;

		case 32:
			var_0B = param_01;
			if(isdefined(var_0B) && var_0B == "orbital_strike_laser")
			{
				processchallenge("ch_daily_32");
			}
			break;

		case 33:
			if(var_07 == 1)
			{
				processchallenge("ch_daily_33");
			}
			break;

		case 34:
			processchallenge("ch_daily_34");
			break;

		case 35:
			var_0B = param_01;
			if(isdefined(var_0B) && var_0B == "missile_strike")
			{
				processchallenge("ch_daily_35");
			}
			break;

		case 36:
			if(var_06 == 1)
			{
				processchallenge("ch_daily_36");
			}
			break;

		case 37:
			if(var_05 == 1)
			{
				processchallenge("ch_daily_37");
			}
			break;

		case 38:
			processchallenge("ch_daily_38");
			break;

		case 39:
			var_08 = param_01;
			if(isdefined(var_08) && var_05 == 1 && var_08 == "weapon_smg")
			{
				processchallenge("ch_daily_39");
			}
			break;

		case 40:
			var_08 = param_01;
			if(isdefined(var_08) && var_05 == 1 && var_08 == "weapon_assault")
			{
				processchallenge("ch_daily_40");
			}
			break;

		case 41:
			var_11 = param_01;
			if(isdefined(var_11) && isdefined(self.lastslidetime) && var_11 - self.lastslidetime < 2000)
			{
				processchallenge("ch_daily_41");
			}
			break;

		case 42:
			if(level.gametype == "hp")
			{
				processchallenge("ch_daily_42");
			}
			break;

		case 43:
			var_09 = param_01;
			if(isdefined(var_09))
			{
				if(issubstr(var_09,"_lefthand"))
				{
					var_09 = maps\mp\_utility::strip_suffix(var_09,"_lefthand");
				}
	
				if(level.gametype == "twar" && is_lethal_equipment(var_09))
				{
					processchallenge("ch_daily_43");
				}
			}
			break;

		case 44:
			var_08 = param_01;
			if(isdefined(var_08) && level.gametype == "twar" && var_08 == "weapon_shotgun")
			{
				processchallenge("ch_daily_44");
			}
			break;

		case 45:
			var_09 = param_01;
			if(isdefined(var_09))
			{
				var_10 = getweaponattachments(var_09);
				if(level.gametype == "ball" && maps\mp\_utility::iscacprimaryweapon(var_09) && var_10.size == 3)
				{
					processchallenge("ch_daily_45");
				}
			}
			break;

		default:
			break;
	}
}

//Function Number: 25
ch_kills(param_00)
{
	param_00.victim playerdied();
	if(!isdefined(param_00.attacker) || !isplayer(param_00.attacker))
	{
		return;
	}
	else
	{
		var_01 = param_00.attacker;
	}

	if(isbot(var_01))
	{
		return;
	}

	var_02 = 0;
	var_03 = 0;
	var_04 = 1;
	var_05[param_00.victim.name] = param_00.victim.name;
	var_06[param_00.sweapon] = param_00.sweapon;
	var_07 = 1;
	var_08 = [];
	var_09 = param_00.smeansofdeath;
	var_0A = param_00.time;
	var_0B = getweaponattachments(param_00.sweapon);
	var_0C = 0;
	if(isdefined(var_01.pickedupweaponfrom[param_00.sweapon]) && !maps\mp\_utility::ismeleemod(var_09))
	{
		var_0C++;
	}

	var_0D = maps\mp\_utility::iskillstreakweapon(param_00.sweapon);
	var_0E = maps\mp\_utility::isenvironmentweapon(param_00.sweapon);
	var_0F = 0;
	if(var_09 == "MOD_HEAD_SHOT")
	{
		var_0F = 1;
	}

	var_10 = 0;
	var_11 = 0;
	if(isdefined(param_00.modifiers["longshot"]))
	{
		var_10 = 1;
		var_11++;
	}

	var_12 = param_00.was_ads;
	var_13 = 0;
	if(var_01.recentkillcount == 2)
	{
		var_13 = 1;
	}

	var_14 = 0;
	if(var_01.recentkillcount == 3)
	{
		var_14 = 1;
	}

	var_15 = "";
	if(isdefined(param_00.attackerstance))
	{
		var_15 = param_00.attackerstance;
	}

	var_16 = 0;
	var_17 = 0;
	var_18 = 0;
	var_19 = 0;
	var_1A = 0;
	var_1B = 0;
	switch(var_01.killsthislife.size + 1)
	{
		case 5:
			var_16 = 1;
			break;

		case 10:
			var_17 = 1;
			break;

		case 15:
			var_18 = 1;
			break;

		case 20:
			var_19 = 1;
			break;

		case 25:
			var_1A = 1;
			break;

		case 30:
			var_1B = 1;
			break;

		default:
			break;
	}

	foreach(var_1D in var_01.killsthislife)
	{
		if(maps\mp\_utility::iscacsecondaryweapon(var_1D.sweapon) && !maps\mp\_utility::ismeleemod(var_1D.smeansofdeath))
		{
			var_03++;
		}

		if(isdefined(var_1D.modifiers["longshot"]))
		{
			var_11++;
		}

		if(var_11 == 3)
		{
			var_01 processchallenge("ch_precision_farsight");
		}

		if(var_0A - var_1D.time < 10000)
		{
			var_04++;
		}

		if(isdefined(var_01.pickedupweaponfrom[var_1D.sweapon]) && !maps\mp\_utility::ismeleemod(var_1D.smeansofdeath))
		{
			var_0C++;
			if(var_0C == 5)
			{
				var_01 processchallenge("ch_humiliation_finders");
			}
		}

		if(maps\mp\_utility::iskillstreakweapon(var_1D.sweapon))
		{
			if(!isdefined(var_08[var_1D.sweapon]))
			{
				var_08[var_1D.sweapon] = 0;
			}

			var_08[var_1D.sweapon]++;
			continue;
		}

		if(isdefined(level.onelefttime[var_01.team]) && var_1D.time > level.onelefttime[var_01.team])
		{
			var_02++;
		}

		if(isdefined(var_1D.victim))
		{
			if(!isdefined(var_05[var_1D.victim.name]) && !isdefined(var_06[var_1D.sweapon]) && !maps\mp\_utility::iskillstreakweapon(var_1D.sweapon))
			{
				var_07++;
			}

			var_05[var_1D.victim.name] = var_1D.victim.name;
		}

		var_06[var_1D.sweapon] = var_1D.sweapon;
	}

	var_1F = maps\mp\_utility::getbaseweaponname(param_00.sweapon,1);
	if(maps\mp\_utility::islootweapon(var_1F))
	{
		var_1F = maps\mp\gametypes\_class::getbasefromlootversion(var_1F);
	}

	var_20 = var_1F;
	if(common_scripts\utility::string_starts_with(var_1F,"iw5_"))
	{
		var_20 = getsubstr(var_1F,4);
	}

	var_21 = get_challenge_weapon_class(param_00.sweapon,var_1F);
	if(level.teambased)
	{
		if(level.teamcount[param_00.victim.pers["team"]] > 3 && var_01.killedplayers.size >= level.teamcount[param_00.victim.pers["team"]])
		{
			var_01 processchallenge("ch_precision_cleanhouse");
		}
	}

	if(isdefined(var_01.explosive_drone_owner) && param_00.victim == var_01.explosive_drone_owner)
	{
		var_01 processchallenge("ch_precision_protected");
	}

	if(isdefined(var_01.powerslidetime) && var_0A - var_01.powerslidetime < 3000)
	{
		var_01 processchallenge("ch_boot_hero");
	}

	var_22 = undefined;
	if(maps\mp\_utility::isstrstart(param_00.sweapon,"alt_"))
	{
		var_22 = getsubstr(param_00.sweapon,4);
	}

	if(isdefined(var_01.pickedupweaponfrom[param_00.sweapon]) || isdefined(var_22) && isdefined(var_01.pickedupweaponfrom[var_22]))
	{
		if(!maps\mp\_utility::ismeleemod(var_09))
		{
			var_01 processchallenge("ch_boot_stolen");
		}
	}

	if(var_15 == "crouch")
	{
		var_01 processchallenge("ch_boot_crouch");
	}

	if(var_15 == "prone")
	{
		var_01 processchallenge("ch_boot_prone");
	}

	if(param_00.victim != param_00.attacker)
	{
		foreach(var_24 in var_01.loadoutwildcards)
		{
			var_25 = undefined;
			var_26 = 0;
			if(var_24 == "specialty_wildcard_perkslot1")
			{
				var_26 = 1;
				var_25 = ["specialty_extended_battery","specialty_class_lowprofile","specialty_class_flakjacket","specialty_class_lightweight","specialty_class_dangerclose"];
			}

			if(var_24 == "specialty_wildcard_perkslot2")
			{
				var_26 = 2;
				var_25 = ["specialty_class_blindeye","specialty_class_coldblooded","specialty_class_peripherals","specialty_class_fasthands","specialty_class_dexterity"];
			}

			if(var_24 == "specialty_wildcard_perkslot3")
			{
				var_26 = 3;
				var_25 = ["specialty_class_hardwired","specialty_class_toughness","specialty_class_scavenger","specialty_class_hardline","specialty_exo_blastsuppressor"];
			}

			if(isdefined(var_25) && var_26 > 0)
			{
				var_27 = 0;
				foreach(var_29 in var_01.loadoutperks)
				{
					if(common_scripts\utility::array_contains(var_25,var_29))
					{
						var_27++;
					}
				}

				if(var_27 >= 2 && var_26 == 1 && var_24 == "specialty_wildcard_perkslot1")
				{
					var_01 processchallenge("ch_wild_perk1");
				}

				if(var_27 >= 2 && var_26 == 2 && var_24 == "specialty_wildcard_perkslot2")
				{
					var_01 processchallenge("ch_wild_perk2");
				}

				if(var_27 >= 2 && var_26 == 3 && var_24 == "specialty_wildcard_perkslot3")
				{
					var_01 processchallenge("ch_wild_perk3");
				}
			}

			if(var_24 == "specialty_wildcard_primaryattachment" || var_24 == "specialty_wildcard_secondaryattachment")
			{
				if(var_24 == "specialty_wildcard_primaryattachment" && maps\mp\_utility::iscacprimaryweapon(param_00.sweapon) && var_0B.size >= 3)
				{
					var_01 processchallenge("ch_wild_primary");
				}

				if(var_24 == "specialty_wildcard_secondaryattachment" && maps\mp\_utility::iscacsecondaryweapon(param_00.sweapon) && var_0B.size >= 2)
				{
					var_01 processchallenge("ch_wild_secondary");
				}
			}

			if(var_24 == "specialty_wildcard_dualprimaries")
			{
				var_2B = var_01.loadoutprimary;
				var_2C = var_01.loadoutsecondary;
				if(!maps\mp\_utility::iscacprimaryweapon(var_2B) || !maps\mp\_utility::iscacprimaryweapon(var_2C))
				{
					continue;
				}

				var_2D = maps\mp\_utility::getbaseweaponname(param_00.sweapon);
				var_2E = undefined;
				if(var_2D == var_2B)
				{
					var_2E = var_2C;
				}
				else if(var_2D == var_2C)
				{
					var_2E = var_2B;
				}
				else
				{
					continue;
				}

				var_2F = var_01.killsthislife;
				var_30 = 0;
				var_31 = 0;
				foreach(var_33 in var_2F)
				{
					if(maps\mp\_utility::getbaseweaponname(var_33.sweapon) == var_2E)
					{
						var_30 = 1;
					}

					if(maps\mp\_utility::getbaseweaponname(var_33.sweapon) == var_2D)
					{
						var_31 = 1;
					}
				}

				if(var_30 && !var_31)
				{
					var_01 processchallenge("ch_wild_overkill");
					var_01 processchallengedaily(2,var_1F,var_21);
					var_01 processchallengedaily(42,var_1F,var_21);
				}
			}

			if(var_24 == "specialty_wildcard_dualtacticals")
			{
				if(maps\mp\_utility::is_exo_ability_weapon(var_01.loadoutequipment) && maps\mp\_utility::is_exo_ability_weapon(var_01.loadoutoffhand))
				{
					var_01 processchallenge("ch_wild_exotac");
				}
			}

			if(var_24 == "specialty_wildcard_duallethals" && !maps\mp\_utility::isgrapplinghookgamemode())
			{
				if(maps\mp\gametypes\_weapons::isgrenade(param_00.sweapon) && !issubstr(param_00.sweapon,"exoknife_mp"))
				{
					if(var_01.loadoutequipment != "specialty_null" && maps\mp\gametypes\_class::isvalidequipment(var_01.loadoutequipment,0) && var_01.loadoutoffhand != "specialty_null" && maps\mp\gametypes\_class::isvalidequipment(var_01.loadoutoffhand,0))
					{
						var_01 processchallenge("ch_wild_exobomb");
					}
				}
			}

			if(var_24 == "specialty_wildcard_extrastreak")
			{
				if(!var_0D)
				{
					continue;
				}

				if(var_01.killstreaks.size < 4)
				{
					continue;
				}

				var_01 processchallenge("ch_wild_fourthscore");
			}
		}
	}

	if(param_00.victim != param_00.attacker)
	{
		var_36 = !level.teambased || param_00.victim.team != param_00.attacker.team;
		if(var_36 && var_01 maps\mp\_utility::_hasperk("specialty_class_lowprofile"))
		{
			var_37 = 0;
			if(isdefined(level.uavmodels))
			{
				if(level.teambased)
				{
					var_37 = level.uavmodels[maps\mp\_utility::getotherteam(param_00.attacker.team)].size;
				}
				else if(level.uavmodels.size > 0)
				{
					var_38 = 0;
					foreach(var_3A in level.uavmodels)
					{
						if(var_3A.owner == var_01)
						{
							var_38++;
						}
					}

					if(var_38 > 0)
					{
						var_37 = level.uavmodels.size - var_38;
					}
					else
					{
						var_37 = level.uavmodels.size;
					}
				}
			}

			if(var_37 > 0)
			{
				var_01 processchallenge("ch_perk_lowprofile");
			}
		}

		if(var_36 && var_01 maps\mp\_utility::_hasperk("specialty_class_quickdraw") && var_01 adsbuttonpressed())
		{
			var_01 processchallenge("ch_perk_quickdraw");
		}

		if(var_36 && var_01 maps\mp\_utility::_hasperk("specialty_class_lightweight"))
		{
			var_01 processchallenge("ch_perk_lightweight");
		}

		if(var_36 && var_01 maps\mp\_utility::_hasperk("specialty_class_coldblooded"))
		{
			var_01 processchallenge("ch_perk_coldblood");
		}

		if(var_36 && var_01 maps\mp\_utility::_hasperk("specialty_class_peripherals"))
		{
			var_01 processchallenge("ch_perk_peripheral");
		}

		if(var_36 && var_01 maps\mp\_utility::_hasperk("specialty_class_dexterity") && var_01 issprinting() || var_01 ispowersliding())
		{
			var_01 processchallenge("ch_perk_gungho");
		}

		if(var_36 && var_01 maps\mp\_utility::_hasperk("specialty_exo_blastsuppressor"))
		{
			var_01 processchallenge("ch_perk_blast");
		}

		if(var_36 && var_01 maps\mp\_utility::_hasperk("specialty_class_hardwired"))
		{
			var_3C = 0;
			if(isdefined(level.uavmodels))
			{
				if(level.teambased)
				{
					foreach(var_3A in level.uavmodels[maps\mp\_utility::getotherteam(var_01.team)])
					{
						if(var_3A.uavtype == "counter")
						{
							var_3C = 1;
							break;
						}
					}

					if(isdefined(level.empowner) && level.empowner.team != var_01.team)
					{
						var_3C = 1;
					}
				}
				else
				{
					foreach(var_3A in level.uavmodels)
					{
						if(var_3A.uavtype == "counter" && !var_3A.owner == var_01)
						{
							var_3C = 1;
							break;
						}
					}
				}
			}

			if(var_3C)
			{
				var_01 processchallenge("ch_perk_hardwire");
			}
		}

		if(var_36 && var_01 maps\mp\_utility::_hasperk("specialty_class_fasthands"))
		{
			if(isdefined(var_01.lastprimaryweaponswaptime) && gettime() - var_01.lastprimaryweaponswaptime < 5000)
			{
				var_01 processchallenge("ch_perk_fasthand");
			}
		}

		if(var_36 && var_01 maps\mp\_utility::_hasperk("specialty_class_toughness"))
		{
			if(isdefined(var_01.lastdamagefromenemytargettime) && gettime() - var_01.lastdamagefromenemytargettime < 2000)
			{
				var_01 processchallenge("ch_perk_tough");
			}
		}

		if(var_36 && var_01 maps\mp\_utility::_hasperk("specialty_class_scavenger") && isdefined(var_01.hasscavengedammothislife) && var_01.hasscavengedammothislife == 1)
		{
			var_01 processchallenge("ch_perk_scavenge");
		}
	}

	if(var_0A < param_00.victim.concussionendtime)
	{
		var_01 processchallenge("ch_exolauncher_stun");
	}

	if(isdefined(param_00.victim.inplayersmokescreen))
	{
		var_01 processchallenge("ch_exolauncher_smoke");
	}

	foreach(var_42 in param_00.victim._threatdetection.showlist)
	{
		if(var_42.eventtype == "PAINT_GRENADE" && var_0A < var_42.endtime)
		{
			var_01 processchallenge("ch_exolauncher_threat");
			break;
		}
	}

	if(isdefined(param_00.victim.empgrenaded) && param_00.victim.empgrenaded == 1 || var_0A < param_00.victim.empendtime)
	{
		var_01 processchallenge("ch_exolauncher_emp");
	}

	if(isdefined(param_00.victim.died_being_tracked) && param_00.victim.died_being_tracked == 1)
	{
		param_00.victim.died_being_tracked = undefined;
		var_01 processchallenge("ch_exolauncher_tracking");
	}

	if((var_01.loadoutequipment == "adrenaline_mp" || var_01.loadoutoffhand == "adrenaline_mp") && var_01.overclock_on == 1)
	{
		var_01 processchallenge("ch_exoability_overclock");
	}

	if(var_01.loadoutequipment == "exocloak_equipment_mp" || var_01.loadoutoffhand == "exocloak_equipment_mp")
	{
		if(var_01.exo_cloak_on == 1 || isdefined(var_01.exo_cloak_off_time) && param_00.time < var_01.exo_cloak_off_time + 3000)
		{
			var_01 processchallenge("ch_exoability_cloak");
		}
	}

	if((var_01.loadoutequipment == "exohover_equipment_mp" || var_01.loadoutoffhand == "exohover_equipment_mp") && var_01.exo_hover_on == 1)
	{
		var_01 processchallenge("ch_exoability_hover");
	}

	if((var_01.loadoutequipment == "exomute_equipment_mp" || var_01.loadoutoffhand == "exomute_equipment_mp") && var_01.mute_on == 1)
	{
		var_01 processchallenge("ch_exoability_mute");
	}

	if((var_01.loadoutequipment == "extra_health_mp" || var_01.loadoutoffhand == "extra_health_mp") && var_01.exo_health_on == 1)
	{
		if(isdefined(param_00.attacker.lastdamagedtime) && param_00.time < param_00.attacker.lastdamagedtime + 4000)
		{
			var_01 processchallenge("ch_exoability_health");
		}
	}

	foreach(var_45 in var_0B)
	{
		switch(var_45)
		{
			case "opticsacog2ar":
			case "opticsacog2":
				if(var_12)
				{
					var_01 processchallenge("ch_attach_kill_opticsacog2");
				}
				break;

			case "opticstargetenhancer":
			case "variablereddot":
			case "opticseotech":
			case "opticsreddot":
			case "ironsights":
				if(var_12)
				{
					var_01 processchallenge("ch_attach_kill_" + var_45);
				}
				break;

			case "heatsink":
			case "trackrounds":
			case "lasersight":
			case "stock":
			case "quickdraw":
			case "longrange":
			case "firerate":
			case "foregrip":
			case "parabolicmicrophone":
			case "dualmag":
			case "xmags":
			case "akimbo":
				var_01 processchallenge("ch_attach_kill_" + var_45);
				break;

			case "opticsthermalar":
			case "opticsthermal":
				var_01 processchallenge("ch_attach_kill_opticsthermal");
				break;

			case "silencersniper":
			case "silencerpistol":
			case "silencer01":
				var_01 processchallenge("ch_attach_kill_silencer01");
				break;

			case "thorstabilizer":
			case "m990stabilizer":
			case "gm6stabilizer":
			case "morsstabilizer":
			case "stabilizer":
				var_01 processchallenge("ch_attach_kill_stabilizer");
				break;

			case "m990scopevz":
			case "thorscopevz":
			case "gm6scopevz":
			case "morsscopevz":
			case "scopevz":
				var_01 processchallenge("ch_attach_kill_scopevz");
				break;
		}
	}

	if((var_09 == "MOD_PISTOL_BULLET" || var_09 == "MOD_RIFLE_BULLET" || var_09 == "MOD_HEAD_SHOT" || var_1F == "iw5_m990") && !var_0E && !var_0D)
	{
		switch(var_21)
		{
			case "weapon_smg":
				var_01 processchallenge("ch_smg_kill");
				if(var_0F)
				{
					var_01 processchallenge("ch_smg_headshot");
				}
				break;

			case "weapon_assault":
				var_01 processchallenge("ch_ar_kill");
				if(var_0F)
				{
					var_01 processchallenge("ch_ar_headshot");
				}
				break;

			case "weapon_shotgun":
				var_01 processchallenge("ch_shotgun_kill");
				if(var_0F)
				{
					var_01 processchallenge("ch_shotgun_headshot");
				}
				break;

			case "weapon_sniper":
				var_01 processchallenge("ch_sniper_kill");
				if(var_0F)
				{
					var_01 processchallenge("ch_sniper_headshot");
				}
				break;

			case "weapon_pistol":
				var_01 processchallenge("ch_pistol_kill");
				if(var_0F)
				{
					var_01 processchallenge("ch_pistol_headshot");
				}
				break;

			case "weapon_heavy":
				var_01 processchallenge("ch_heavy_kill");
				if(var_0F)
				{
					var_01 processchallenge("ch_heavy_headshot");
				}
				break;

			case "weapon_special":
				var_01 processchallenge("ch_special_kill");
				break;

			default:
				break;
		}

		if(var_09 == "MOD_HEAD_SHOT")
		{
			if(var_21 == "weapon_pistol")
			{
				var_01 notify("increment_pistol_headshots");
			}
			else if(var_21 == "weapon_assault")
			{
				var_01 notify("increment_ar_headshots");
			}
		}

		switch(var_1F)
		{
			case "iw5_dlcgun6":
				var_01 processchallenge("ch_marksman_iw5_dlcgun5");
				break;

			case "iw5_dlcgun6loot5":
				var_01 processchallenge("ch_marksman_iw5_dlcgun6");
				break;

			case "iw5_dlcgun7loot0":
				var_01 processchallenge("ch_marksman_iw5_dlcgun7");
				break;

			case "iw5_dlcgun7loot6":
				var_01 processchallenge("ch_marksman_iw5_dlcgun8");
				break;

			case "iw5_dlcgun8loot1":
				var_01 processchallenge("ch_marksman_iw5_dlcgun9");
				break;

			case "iw5_dlcgun13":
				var_01 processchallenge("ch_marksman_iw5_dlcgun10");
				break;

			case "iw5_dlcgun18":
				var_01 processchallenge("ch_marksman_iw5_dlcgun11");
				break;

			case "iw5_dlcgun23":
				var_01 processchallenge("ch_marksman_iw5_dlcguna");
				break;

			case "iw5_dlcgun28":
				var_01 processchallenge("ch_marksman_iw5_dlcgunb");
				break;

			case "iw5_dlcgun33":
				var_01 processchallenge("ch_marksman_iw5_dlcgunc");
				break;

			case "iw5_dlcgun38":
				var_01 processchallenge("ch_marksman_iw5_dlcgund");
				break;

			default:
				var_01 processchallenge("ch_marksman_" + var_1F);
				break;
		}
	}
	else if(issubstr(var_1F,"microdronelauncher") && !maps\mp\_utility::ismeleemod(var_09))
	{
		var_01 processchallenge("ch_marksman_" + var_1F);
	}
	else if(issubstr(var_1F,"exocrossbow") && !maps\mp\_utility::ismeleemod(var_09))
	{
		var_01 processchallenge("ch_marksman_" + var_1F);
	}

	if(issubstr(param_00.sweapon,"iw5_dlcgun12loot7_mp"))
	{
		var_01 processchallenge("ch_tier2_1_iw5_dlcgun12");
	}

	if(isdefined(var_01.last_grapple_time))
	{
		var_47 = var_0A - var_01.last_grapple_time;
		var_48 = undefined;
		if(isdefined(var_01.last_grapple_time_prev))
		{
			var_48 = var_0A - var_01.last_grapple_time_prev;
		}

		if(var_47 < 0 && isdefined(var_48))
		{
			if(var_48 < 2000)
			{
				var_01 processchallenge("ch_tier2_3_iw5_dlcgun12");
			}
		}
		else if(var_47 < 2000 && var_47 > 0)
		{
			var_01 processchallenge("ch_tier2_3_iw5_dlcgun12");
		}
	}

	var_01 processchallengedaily(1,var_21,undefined);
	var_01 processchallengedaily(3,var_21,undefined);
	var_01 processchallengedaily(5,var_21,undefined);
	var_01 processchallengedaily(7,var_21,undefined);
	var_01 processchallengedaily(8,var_21,undefined);
	var_01 processchallengedaily(9,var_21,undefined);
	var_01 processchallengedaily(12,var_21,undefined);
	var_01 processchallengedaily(14,var_21,undefined);
	var_01 processchallengedaily(15,var_21,undefined);
	var_01 processchallengedaily(18,var_21,undefined);
	var_01 processchallengedaily(19,var_21,undefined);
	var_01 processchallengedaily(24,param_00.sweapon,undefined);
	var_01 processchallengedaily(31,var_21,undefined);
	var_01 processchallengedaily(33,undefined,undefined);
	var_01 processchallengedaily(39,var_21,undefined);
	var_01 processchallengedaily(40,var_21,undefined);
	var_01 processchallengedaily(41,var_0A,undefined);
	var_01 processchallengedaily(44,var_21,undefined);
	var_01 processchallengedaily(45,param_00.sweapon,undefined);
	var_01 processchallengedaily(20,param_00.sweapon,undefined);
	var_01 processchallengedaily(43,param_00.sweapon,undefined);
	var_01 processchallengedaily(11,param_00.sweapon,undefined);
	if((var_09 == "MOD_PISTOL_BULLET" || var_09 == "MOD_RIFLE_BULLET" || var_09 == "MOD_HEAD_SHOT" || var_1F == "iw5_m990") && !var_0E && !var_0D)
	{
		switch(var_21)
		{
			case "weapon_pistol":
			case "weapon_special":
			case "weapon_heavy":
			case "weapon_shotgun":
			case "weapon_sniper":
			case "weapon_assault":
			case "weapon_smg":
				switch(var_1F)
				{
					case "iw5_dlcgun4":
					case "iw5_dlcgun3":
					case "iw5_dlcgun1":
					case "iw5_dlcgun2":
						var_01 processchallenge("ch_attach_unlock_type1_" + var_20);
						break;
	
					case "iw5_dlcgun6":
						var_01 processchallenge("ch_attach_unlock_type1_dlcgun5");
						break;
	
					case "iw5_dlcgun6loot5":
						var_01 processchallenge("ch_attach_unlock_type1_dlcgun6");
						break;
	
					case "iw5_dlcgun7loot0":
						var_01 processchallenge("ch_attach_unlock_type1_dlcgun7");
						break;
	
					case "iw5_dlcgun7loot6":
						var_01 processchallenge("ch_attach_unlock_type1_dlcgun8");
						break;
	
					case "iw5_dlcgun8loot1":
						var_01 processchallenge("ch_attach_unlock_type1_dlcgun9");
						break;
	
					case "iw5_dlcgun13":
						var_01 processchallenge("ch_attach_unlock_type1_dlcgun10");
						break;
	
					case "iw5_dlcgun18":
						var_01 processchallenge("ch_attach_unlock_type1_dlcgun11");
						break;
	
					case "iw5_dlcgun23":
						var_01 processchallenge("ch_attach_unlock_type1_dlcguna");
						break;
	
					case "iw5_dlcgun28":
						var_01 processchallenge("ch_attach_unlock_type1_dlcgunb");
						break;
	
					case "iw5_dlcgun33":
						var_01 processchallenge("ch_attach_unlock_type1_dlcgunc");
						break;
	
					case "iw5_dlcgun38":
						var_01 processchallenge("ch_attach_unlock_type1_dlcgund");
						break;
	
					default:
						var_01 processchallenge("ch_attach_unlock_kills_" + var_20);
						break;
				}
	
				if(var_12)
				{
					switch(var_1F)
					{
						case "iw5_dlcgun4":
						case "iw5_dlcgun3":
						case "iw5_dlcgun1":
						case "iw5_dlcgun2":
							var_01 processchallenge("ch_attach_unlock_type3_" + var_20);
							break;
	
						case "iw5_dlcgun6":
							var_01 processchallenge("ch_attach_unlock_type3_dlcgun5");
							break;
	
						case "iw5_dlcgun6loot5":
							var_01 processchallenge("ch_attach_unlock_type3_dlcgun6");
							break;
	
						case "iw5_dlcgun7loot0":
							var_01 processchallenge("ch_attach_unlock_type3_dlcgun7");
							break;
	
						case "iw5_dlcgun7loot6":
							var_01 processchallenge("ch_attach_unlock_type3_dlcgun8");
							break;
	
						case "iw5_dlcgun8loot1":
							var_01 processchallenge("ch_attach_unlock_type3_dlcgun9");
							break;
	
						case "iw5_dlcgun13":
							var_01 processchallenge("ch_attach_unlock_type3_dlcgun10");
							break;
	
						case "iw5_dlcgun18":
							var_01 processchallenge("ch_attach_unlock_type3_dlcgun11");
							break;
	
						case "iw5_dlcgun23":
							var_01 processchallenge("ch_attach_unlock_type3_dlcguna");
							break;
	
						case "iw5_dlcgun28":
							var_01 processchallenge("ch_attach_unlock_type3_dlcgunb");
							break;
	
						case "iw5_dlcgun33":
							var_01 processchallenge("ch_attach_unlock_type3_dlcgunc");
							break;
	
						case "iw5_dlcgun38":
							var_01 processchallenge("ch_attach_unlock_type3_dlcgund");
							break;
	
						default:
							var_01 processchallenge("ch_attach_unlock_ads_" + var_20);
							break;
					}
				}
				else
				{
					switch(var_1F)
					{
						case "iw5_dlcgun4":
						case "iw5_dlcgun3":
						case "iw5_dlcgun1":
						case "iw5_dlcgun2":
							var_01 processchallenge("ch_attach_unlock_type2_" + var_20);
							break;
	
						case "iw5_dlcgun6":
							var_01 processchallenge("ch_attach_unlock_type2_dlcgun5");
							break;
	
						case "iw5_dlcgun7loot0":
							var_01 processchallenge("ch_attach_unlock_type2_dlcgun7");
							break;
	
						case "iw5_dlcgun7loot6":
							var_01 processchallenge("ch_attach_unlock_type2_dlcgun8");
							break;
	
						case "iw5_dlcgun13":
							var_01 processchallenge("ch_attach_unlock_type2_dlcgun10");
							break;
	
						case "iw5_dlcgun18":
							var_01 processchallenge("ch_attach_unlock_type2_dlcgun11");
							break;
	
						case "iw5_dlcgun23":
							var_01 processchallenge("ch_attach_unlock_type2_dlcguna");
							break;
	
						case "iw5_dlcgun28":
							var_01 processchallenge("ch_attach_unlock_type2_dlcgunb");
							break;
	
						case "iw5_dlcgun33":
							var_01 processchallenge("ch_attach_unlock_type2_dlcgunc");
							break;
	
						case "iw5_dlcgun38":
							var_01 processchallenge("ch_attach_unlock_type2_dlcgund");
							break;
	
						default:
							var_01 processchallenge("ch_attach_unlock_hipfirekills_" + var_20);
							break;
					}
				}
	
				break;

			default:
				break;
		}

		if(var_09 == "MOD_HEAD_SHOT")
		{
			switch(var_1F)
			{
				case "iw5_dlcgun6loot5":
					var_01 processchallenge("ch_attach_unlock_type2_dlcgun6");
					break;

				default:
					var_01 processchallenge("ch_attach_unlock_headShots_" + var_20);
					break;
			}
		}
	}

	if(isdefined(var_01.riotshieldentity))
	{
		if(var_0A - var_01.riotshieldentity.birthtime < 3000)
		{
			var_01 processchallenge("ch_attach_unlock_postplant_riotshieldt6");
		}
	}

	if(maps\mp\_utility::ismeleemod(var_09) && !var_0E && !var_0D)
	{
		if(!issubstr(var_1F,"riotshield"))
		{
			var_01.pers["meleeKillStreak"]++;
			foreach(var_45 in var_0B)
			{
				if(var_45 == "tactical")
				{
					var_01 processchallenge("ch_attach_kill_tactical");
				}
			}
		}
		else if(issubstr(var_1F,"riotshield"))
		{
			if(var_1F == "iw5_riotshieldt6")
			{
				var_01 processchallenge("ch_attach_unlock_meleekills_riotshieldt6");
				var_01 processchallenge("ch_marksman_iw5_riotshieldt6");
				var_01 processchallenge("ch_special_kill");
				var_01.pers["shieldKillStreak"]++;
			}
		}

		if(issubstr(var_1F,"exoshield"))
		{
			var_01 processchallenge("ch_exoability_shield");
		}

		if(issubstr(var_1F,"combatknife"))
		{
			var_01 notify("increment_knife_kill");
		}
	}

	if(issubstr(var_09,"MOD_IMPACT") && !var_0E && !var_0D)
	{
		if(issubstr(param_00.sweapon,"exoknife_mp"))
		{
			var_01 notify("increment_knife_kill");
			var_01 processchallenge("ch_exolauncher_knife");
			if(var_10)
			{
				var_01 processchallenge("ch_humiliation_hailmary");
			}

			foreach(var_24 in var_01.loadoutwildcards)
			{
				if(var_24 == "specialty_wildcard_duallethals" && !maps\mp\_utility::isgrapplinghookgamemode())
				{
					var_4C = maps\mp\_utility::strip_suffix(var_01.loadoutequipment,"_lefthand");
					var_4D = maps\mp\_utility::strip_suffix(var_01.loadoutoffhand,"_lefthand");
					if(is_lethal_equipment(var_4C) && is_lethal_equipment(var_4D))
					{
						var_01 notify("increment_duallethal_kills");
					}

					break;
				}
			}
		}

		if(var_1F == "iw5_microdronelauncher" && isdefined(level.challengeinfo["ch_impact_iw5_microdronelauncher"]))
		{
			var_01 processchallenge("ch_impact_iw5_microdronelauncher");
		}

		if(var_1F == "iw5_exocrossbow")
		{
			if(isdefined(level.challengeinfo["ch_attach_unlock_kills_" + var_20]))
			{
				var_01 processchallenge("ch_attach_unlock_kills_" + var_20);
			}

			if(var_12)
			{
				if(isdefined(level.challengeinfo["ch_attach_unlock_ads_" + var_20]))
				{
					var_01 processchallenge("ch_attach_unlock_ads_" + var_20);
				}
			}
		}
	}

	if(issubstr(var_09,"MOD_GRENADE") || issubstr(var_09,"MOD_PROJECTILE") || issubstr(var_09,"MOD_EXPLOSIVE") && !var_0E && !var_0D)
	{
		switch(var_21)
		{
			case "weapon_special":
				var_01 processchallenge("ch_special_kill");
				break;

			default:
				break;
		}

		if(var_1F == "iw5_exocrossbow")
		{
			if(isdefined(level.challengeinfo["ch_attach_unlock_kills_" + var_20]))
			{
				var_01 processchallenge("ch_attach_unlock_kills_" + var_20);
			}

			if(var_12)
			{
				if(isdefined(level.challengeinfo["ch_attach_unlock_ads_" + var_20]))
				{
					var_01 processchallenge("ch_attach_unlock_ads_" + var_20);
				}
			}
		}

		if(maps\mp\_utility::isstrstart(param_00.sweapon,"frag_"))
		{
			var_01 processchallenge("ch_exolauncher_frag");
			if(param_00.victim.explosiveinfo["cookedKill"])
			{
				var_01 processchallenge("ch_precision_masterchef");
			}

			if(param_00.victim.explosiveinfo["throwbackKill"])
			{
				var_01 processchallenge("ch_precision_return");
			}
		}

		if(maps\mp\_utility::isstrstart(param_00.sweapon,"semtex_"))
		{
			var_01 processchallenge("ch_exolauncher_semtex");
		}

		if(maps\mp\_utility::isstrstart(param_00.sweapon,"explosive_drone"))
		{
			var_01 processchallenge("ch_exolauncher_explosive_drone");
		}

		if(isdefined(param_00.einflictor.classname) && param_00.einflictor.classname == "scriptable")
		{
			var_01 processchallenge("ch_boot_vandalism");
			var_01 processchallenge("ch_precision_sitaware");
		}

		if(isdefined(param_00.sweapon) && param_00.sweapon == "mp_lab_gas_explosion")
		{
			var_01 processchallenge("ch_precision_sitaware");
		}

		if(issubstr(param_00.sweapon,"frag") || issubstr(param_00.sweapon,"semtex") || issubstr(param_00.sweapon,"explosive_drone"))
		{
			foreach(var_24 in var_01.loadoutwildcards)
			{
				if(var_24 == "specialty_wildcard_duallethals" && !maps\mp\_utility::isgrapplinghookgamemode())
				{
					var_4C = maps\mp\_utility::strip_suffix(var_01.loadoutequipment,"_lefthand");
					var_4D = maps\mp\_utility::strip_suffix(var_01.loadoutoffhand,"_lefthand");
					if(is_lethal_equipment(var_4C) && is_lethal_equipment(var_4D))
					{
						var_01 notify("increment_duallethal_kills");
					}

					break;
				}
			}
		}

		if(maps\mp\_utility::isplayeronenemyteam(var_01) && var_01 maps\mp\_utility::_hasperk("specialty_class_dangerclose"))
		{
			var_01 processchallenge("ch_perk_dangerclose");
		}
	}

	foreach(var_45 in var_0B)
	{
		switch(var_45)
		{
			case "gl":
				if(isdefined(level.challengeinfo["ch_attach_kill_" + var_45]))
				{
					var_01 processchallenge("ch_attach_kill_" + var_45);
				}
				break;
		}
	}

	if(issubstr(var_09,"MOD_EXPLOSIVE") && param_00.sweapon == "airdrop_trap_explosive_mp")
	{
		var_01 processchallenge("ch_precision_surprise");
	}

	if(!maps\mp\_utility::ismeleemod(var_09) && var_09 == "MOD_PISTOL_BULLET" || var_09 == "MOD_RIFLE_BULLET" || var_09 == "MOD_HEAD_SHOT" || var_1F == "iw5_microdronelauncher" || var_1F == "iw5_exocrossbow" || var_1F == "iw5_m990")
	{
		if(var_10)
		{
			if(var_21 == "weapon_assault" || var_21 == "weapon_sniper" || var_1F == "iw5_exocrossbow" || var_21 == "weapon_heavy")
			{
				switch(var_1F)
				{
					case "iw5_dlcgun1":
					case "iw5_dlcgun2":
						var_01 processchallenge("ch_tier1_1_" + var_1F);
						break;

					case "iw5_dlcgun6":
						var_01 processchallenge("ch_tier1_1_iw5_dlcgun5");
						break;

					case "iw5_dlcgun6loot5":
						var_01 processchallenge("ch_tier1_1_iw5_dlcgun6");
						break;

					case "iw5_dlcgun7loot0":
						var_01 processchallenge("ch_tier1_1_iw5_dlcgun7");
						break;

					case "iw5_dlcgun7loot6":
						var_01 processchallenge("ch_tier1_1_iw5_dlcgun8");
						break;

					case "iw5_dlcgun23":
						var_01 processchallenge("ch_tier1_1_iw5_dlcguna");
						break;

					case "iw5_dlcgun33":
						var_01 processchallenge("ch_tier1_1_iw5_dlcgunc");
						break;

					default:
						var_01 processchallenge("ch_longshot_" + var_1F);
						break;
				}
			}
		}

		if(!var_12)
		{
			if(var_21 == "weapon_shotgun" || var_21 == "weapon_smg" || var_21 == "weapon_heavy" || var_1F == "iw5_microdronelauncher")
			{
				switch(var_1F)
				{
					case "iw5_dlcgun4":
					case "iw5_dlcgun2":
						var_01 processchallenge("ch_tier1_2_" + var_1F);
						break;

					case "iw5_dlcgun8loot1":
						var_01 processchallenge("ch_tier1_2_iw5_dlcgun9");
						break;

					case "iw5_dlcgun18":
						var_01 processchallenge("ch_tier1_1_iw5_dlcgun11");
						break;

					case "iw5_dlcgun28":
						var_01 processchallenge("ch_tier1_1_iw5_dlcgunb");
						break;

					case "iw5_dlcgun38":
						var_01 processchallenge("ch_tier1_1_iw5_dlcgund");
						break;

					default:
						var_01 processchallenge("ch_hip_" + var_1F);
						break;
				}
			}
		}

		if(issubstr(var_1F,"iw5_exocrossbow"))
		{
			if(!var_12)
			{
				var_01 processchallenge("ch_hip_iw5_exocrossbow");
			}
		}

		if(var_0F)
		{
			switch(var_21)
			{
				case "weapon_pistol":
				case "weapon_special":
				case "weapon_shotgun":
				case "weapon_sniper":
				case "weapon_assault":
				case "weapon_smg":
					switch(var_1F)
					{
						case "iw5_dlcgun3":
						case "iw5_dlcgun1":
							var_01 processchallenge("ch_tier1_2_" + var_1F);
							break;
	
						case "iw5_dlcgun6":
							var_01 processchallenge("ch_tier1_2_iw5_dlcgun5");
							break;
	
						case "iw5_dlcgun6loot5":
							var_01 processchallenge("ch_tier1_2_iw5_dlcgun6");
							break;
	
						case "iw5_dlcgun7loot0":
							var_01 processchallenge("ch_tier1_2_iw5_dlcgun7");
							break;
	
						case "iw5_dlcgun7loot6":
							var_01 processchallenge("ch_tier1_2_iw5_dlcgun8");
							break;
	
						case "iw5_dlcgun13":
							var_01 processchallenge("ch_tier1_2_iw5_dlcgun10");
							break;
	
						case "iw5_dlcgun18":
							var_01 processchallenge("ch_tier1_2_iw5_dlcgun11");
							break;
	
						case "iw5_dlcgun23":
							var_01 processchallenge("ch_tier1_2_iw5_dlcguna");
							break;
	
						case "iw5_dlcgun28":
							var_01 processchallenge("ch_tier1_2_iw5_dlcgunb");
							break;
	
						case "iw5_dlcgun33":
							var_01 processchallenge("ch_tier1_2_iw5_dlcgunc");
							break;
	
						case "iw5_dlcgun38":
							var_01 processchallenge("ch_tier1_2_iw5_dlcgund");
							break;
	
						default:
							var_01 processchallenge("ch_headshot_" + var_1F);
							break;
					}
					break;
			}
		}

		if(var_1F == "iw5_microdronelauncher")
		{
			if(isdefined(level.challengeinfo["ch_kills_iw5_microdronelauncher"]))
			{
				var_01 processchallenge("ch_kills_iw5_microdronelauncher");
			}
		}
	}

	if(!maps\mp\_utility::ismeleemod(var_09) && var_21 == "weapon_launcher")
	{
		if(isdefined(level.challengeinfo["ch_kills_" + var_1F]))
		{
			var_01 processchallenge("ch_kills_" + var_1F);
		}

		var_01 processchallengedaily(10,var_21,undefined);
		if(issubstr(param_00.victim.model,"npc_exo_armor_mp_base"))
		{
			var_01 processchallenge("ch_launcher_kill");
			if(isdefined(level.challengeinfo["ch_vehicle_" + var_1F]))
			{
				var_01 processchallenge("ch_vehicle_" + var_1F);
			}

			if(isdefined(level.challengeinfo["ch_goliath_" + var_1F]))
			{
				var_01 processchallenge("ch_goliath_" + var_1F);
			}
		}
	}

	if(var_16 || var_17 || var_18 || var_19 || var_1A || var_1B)
	{
		if(var_21 == "weapon_sniper")
		{
			switch(var_1F)
			{
				case "iw5_dlcgun6loot5":
					var_01 processchallenge("ch_tier2_2_iw5_dlcgun6");
					break;

				default:
					var_01 processchallenge("ch_blood_" + var_1F);
					break;
			}
		}
		else if(var_21 == "weapon_assault" || var_21 == "weapon_heavy" || var_1F == "iw5_microdronelauncher")
		{
			switch(var_1F)
			{
				case "iw5_dlcgun1":
				case "iw5_dlcgun2":
					var_01 processchallenge("ch_tier2_2_" + var_1F);
					break;

				case "iw5_dlcgun6":
					var_01 processchallenge("ch_tier2_2_iw5_dlcgun5");
					break;

				case "iw5_dlcgun7loot0":
					var_01 processchallenge("ch_tier2_2_iw5_dlcgun7");
					break;

				case "iw5_dlcgun7loot6":
					var_01 processchallenge("ch_tier2_2_iw5_dlcgun8");
					break;

				case "iw5_dlcgun23":
					var_01 processchallenge("ch_tier2_2_iw5_dlcguna");
					break;

				case "iw5_dlcgun33":
					var_01 processchallenge("ch_tier2_2_iw5_dlcgunc");
					break;

				default:
					var_01 processchallenge("ch_triple_" + var_1F);
					break;
			}
		}
	}

	if(var_0B.size == 0)
	{
		if(!issubstr(var_09,"MOD_MELEE"))
		{
			switch(var_21)
			{
				case "weapon_pistol":
				case "weapon_special":
				case "weapon_heavy":
				case "weapon_shotgun":
				case "weapon_sniper":
				case "weapon_assault":
				case "weapon_smg":
					switch(var_1F)
					{
						case "iw5_dlcgun4":
						case "iw5_dlcgun3":
						case "iw5_dlcgun1":
						case "iw5_dlcgun2":
							var_01 processchallenge("ch_tier2_4_" + var_1F);
							break;
	
						case "iw5_dlcgun6":
							var_01 processchallenge("ch_tier2_4_iw5_dlcgun5");
							break;
	
						case "iw5_dlcgun6loot5":
							var_01 processchallenge("ch_tier2_4_iw5_dlcgun6");
							break;
	
						case "iw5_dlcgun7loot0":
							var_01 processchallenge("ch_tier2_4_iw5_dlcgun7");
							break;
	
						case "iw5_dlcgun7loot6":
							var_01 processchallenge("ch_tier2_4_iw5_dlcgun8");
							break;
	
						case "iw5_dlcgun8loot1":
							var_01 processchallenge("ch_tier2_4_iw5_dlcgun9");
							break;
	
						case "iw5_dlcgun13":
							var_01 processchallenge("ch_tier2_3_iw5_dlcgun10");
							break;
	
						case "iw5_dlcgun18":
							var_01 processchallenge("ch_tier2_4_iw5_dlcgun11");
							break;
	
						case "iw5_dlcgun23":
							var_01 processchallenge("ch_tier2_4_iw5_dlcguna");
							break;
	
						case "iw5_dlcgun28":
							var_01 processchallenge("ch_tier2_4_iw5_dlcgunb");
							break;
	
						case "iw5_dlcgun33":
							var_01 processchallenge("ch_tier2_4_iw5_dlcgunc");
							break;
	
						case "iw5_dlcgun38":
							var_01 processchallenge("ch_tier2_4_iw5_dlcgund");
							break;
	
						default:
							var_01 processchallenge("ch_barebone_" + var_1F);
							break;
					}
					break;
			}
		}
	}

	var_53 = 0;
	foreach(var_55 in var_01.loadoutperks)
	{
		if(var_55 == "specialty_null")
		{
			var_53++;
			continue;
		}

		break;
	}

	if(var_53 == 6 && !maps\mp\_utility::ismeleemod(var_09))
	{
		switch(var_21)
		{
			case "weapon_pistol":
			case "weapon_special":
			case "weapon_heavy":
			case "weapon_shotgun":
			case "weapon_sniper":
			case "weapon_assault":
			case "weapon_smg":
				switch(var_1F)
				{
					case "iw5_dlcgun4":
					case "iw5_dlcgun3":
					case "iw5_dlcgun1":
					case "iw5_dlcgun2":
						var_01 processchallenge("ch_tier2_5_" + var_1F);
						break;
	
					case "iw5_dlcgun6":
						var_01 processchallenge("ch_tier2_5_iw5_dlcgun5");
						break;
	
					case "iw5_dlcgun6loot5":
						var_01 processchallenge("ch_tier2_5_iw5_dlcgun6");
						break;
	
					case "iw5_dlcgun7loot0":
						var_01 processchallenge("ch_tier2_5_iw5_dlcgun7");
						break;
	
					case "iw5_dlcgun7loot6":
						var_01 processchallenge("ch_tier2_5_iw5_dlcgun8");
						break;
	
					case "iw5_dlcgun8loot1":
						var_01 processchallenge("ch_tier2_5_iw5_dlcgun9");
						break;
	
					case "iw5_dlcgun13":
						var_01 processchallenge("ch_tier2_4_iw5_dlcgun10");
						break;
	
					case "iw5_dlcgun18":
						var_01 processchallenge("ch_tier2_5_iw5_dlcgun11");
						break;
	
					case "iw5_dlcgun23":
						var_01 processchallenge("ch_tier2_5_iw5_dlcguna");
						break;
	
					case "iw5_dlcgun28":
						var_01 processchallenge("ch_tier2_5_iw5_dlcgunb");
						break;
	
					case "iw5_dlcgun33":
						var_01 processchallenge("ch_tier2_5_iw5_dlcgunc");
						break;
	
					case "iw5_dlcgun38":
						var_01 processchallenge("ch_tier2_5_iw5_dlcgund");
						break;
	
					default:
						var_01 processchallenge("ch_noperk_" + var_1F);
						break;
				}
				break;
		}
	}

	if(isdefined(var_01.patient_zero))
	{
		var_01.patient_zero++;
		if(var_01.patient_zero == 3)
		{
			var_01 processchallenge("ch_infect_patientzero");
		}
	}
}

//Function Number: 26
get_challenge_weapon_class(param_00,param_01)
{
	var_02 = maps\mp\_utility::getweaponclass(param_00);
	if(!isdefined(param_01))
	{
		param_01 = maps\mp\_utility::getbaseweaponname(param_00,1);
		if(maps\mp\_utility::islootweapon(param_01))
		{
			param_01 = maps\mp\gametypes\_class::getbasefromlootversion(param_01);
		}
	}

	if(param_01 == "iw5_exocrossbow" || param_01 == "iw5_exocrossbowblops2")
	{
		return "weapon_special";
	}

	if(param_01 == "iw5_maaws" || param_01 == "iw5_mahem" || param_01 == "iw5_stingerm7")
	{
		return "weapon_launcher";
	}

	return var_02;
}

//Function Number: 27
ch_bulletdamagecommon(param_00,param_01,param_02,param_03)
{
	if(!maps\mp\_utility::isenvironmentweapon(param_00.sweapon))
	{
		param_01 endmgstreak();
	}

	if(maps\mp\_utility::iskillstreakweapon(param_00.sweapon))
	{
		return;
	}

	if(isbot(param_01))
	{
		return;
	}

	if(param_01.pers["lastBulletKillTime"] == param_02)
	{
		param_01.pers["bulletStreak"]++;
	}
	else
	{
		param_01.pers["bulletStreak"] = 1;
	}

	param_01.pers["lastBulletKillTime"] = param_02;
	if(!param_00.victimonground)
	{
		param_01 processchallenge("ch_hardlanding");
	}

	if(!param_00.attackeronground)
	{
		param_01.pers["midairStreak"]++;
	}

	if(param_01.pers["midairStreak"] == 2)
	{
		param_01 processchallenge("ch_airborne");
	}

	if(param_02 < param_00.victim.flashendtime)
	{
		param_01 processchallenge("ch_flashbangvet");
	}

	if(param_02 < param_01.flashendtime)
	{
		param_01 processchallenge("ch_blindfire");
	}

	if(param_02 < param_00.victim.concussionendtime)
	{
		param_01 processchallenge("ch_concussionvet");
	}

	if(param_02 < param_01.concussionendtime)
	{
		param_01 processchallenge("ch_slowbutsure");
	}

	if(param_01.pers["bulletStreak"] == 2)
	{
		if(isdefined(param_00.modifiers["headshot"]))
		{
			foreach(var_05 in param_01.killsthislife)
			{
				if(var_05.time != param_02)
				{
					continue;
				}

				if(!isdefined(param_00.modifiers["headshot"]))
				{
					continue;
				}

				param_01 processchallenge("ch_allpro");
			}
		}

		if(param_03 == "weapon_sniper")
		{
			param_01 processchallenge("ch_collateraldamage");
		}
	}

	if(param_03 == "weapon_pistol")
	{
		if(isdefined(param_00.victim.attackerdata) && isdefined(param_00.victim.attackerdata[param_01.guid]))
		{
			if(isdefined(param_00.victim.attackerdata[param_01.guid].isprimary))
			{
				param_01 processchallenge("ch_fastswap");
			}
		}
	}

	if(!isdefined(param_01.infinalstand) || !param_01.infinalstand)
	{
		if(param_00.attackerstance == "crouch")
		{
			param_01 processchallenge("ch_crouchshot");
		}
		else if(param_00.attackerstance == "prone")
		{
			param_01 processchallenge("ch_proneshot");
			if(param_03 == "weapon_sniper")
			{
				param_01 processchallenge("ch_invisible");
			}
		}
	}

	if(param_03 == "weapon_sniper")
	{
		if(isdefined(param_00.modifiers["oneshotkill"]))
		{
			param_01 processchallenge("ch_ghillie");
		}
	}

	if(issubstr(param_00.sweapon,"silencer"))
	{
		param_01 processchallenge("ch_stealthvet");
	}
}

//Function Number: 28
ch_roundplayed(param_00)
{
	var_01 = param_00.player;
	if(var_01.wasaliveatmatchstart)
	{
		var_02 = var_01.pers["deaths"];
		var_03 = var_01.pers["kills"];
		var_04 = 1000000;
		if(var_02 > 0)
		{
			var_04 = var_03 / var_02;
		}

		if(var_04 >= 5 && var_03 >= 5)
		{
			var_01 processchallenge("ch_starplayer");
		}

		if(var_02 == 0 && maps\mp\_utility::gettimepassed() > 300000)
		{
			var_01 processchallenge("ch_flawless");
		}

		if(level.placement["all"].size < 3)
		{
			return;
		}

		if(var_01.score > 0)
		{
			switch(level.gametype)
			{
				case "dm":
					if(param_00.place < 3)
					{
						var_01 processchallenge("ch_victor_dm");
						var_01 processchallenge("ch_ffa_win");
					}
	
					var_01 processchallenge("ch_ffa_participate");
					break;

				case "war":
					if(param_00.winner)
					{
						var_01 processchallenge("ch_war_win");
					}
	
					var_01 processchallenge("ch_war_participate");
					break;

				case "kc":
					if(param_00.winner)
					{
						var_01 processchallenge("ch_kc_win");
					}
	
					var_01 processchallenge("ch_kc_participate");
					break;

				case "dd":
					if(param_00.winner)
					{
						var_01 processchallenge("ch_dd_win");
					}
	
					var_01 processchallenge("ch_dd_participate");
					break;

				case "koth":
					if(param_00.winner)
					{
						var_01 processchallenge("ch_koth_win");
					}
	
					var_01 processchallenge("ch_koth_participate");
					break;

				case "sab":
					if(param_00.winner)
					{
						var_01 processchallenge("ch_sab_win");
					}
	
					var_01 processchallenge("ch_sab_participate");
					break;

				case "sd":
					if(param_00.winner)
					{
						var_01 processchallenge("ch_sd_win");
					}
	
					var_01 processchallenge("ch_sd_participate");
					break;

				case "dom":
					if(param_00.winner)
					{
						var_01 processchallenge("ch_dom_win");
					}
	
					var_01 processchallenge("ch_dom_participate");
					break;

				case "ctf":
					if(param_00.winner)
					{
						var_01 processchallenge("ch_ctf_win");
					}
	
					var_01 processchallenge("ch_ctf_participate");
					break;

				case "tdef":
					if(param_00.winner)
					{
						var_01 processchallenge("ch_tdef_win");
					}
	
					var_01 processchallenge("ch_tdef_participate");
					break;

				case "hp":
					if(param_00.winner)
					{
						var_01 processchallenge("ch_hp_win");
					}
					var_01 processchallenge("ch_hp_participate");
					break;
			}
		}
	}
}

//Function Number: 29
ch_roundwin(param_00)
{
	if(!param_00.winner)
	{
		return;
	}

	var_01 = param_00.player;
	if(var_01.wasaliveatmatchstart)
	{
		switch(level.gametype)
		{
			case "war":
				if(level.hardcoremode)
				{
					var_01 processchallenge("ch_teamplayer_hc");
					if(param_00.place == 0)
					{
						var_01 processchallenge("ch_mvp_thc");
					}
				}
				else
				{
					var_01 processchallenge("ch_teamplayer");
					if(param_00.place == 0)
					{
						var_01 processchallenge("ch_mvp_tdm");
					}
				}
				break;

			case "sab":
				var_01 processchallenge("ch_victor_sab");
				break;

			case "sd":
				var_01 processchallenge("ch_victor_sd");
				break;

			case "hc":
			case "koth":
			case "dom":
			case "ctf":
			case "dm":
			case "hp":
				break;

			default:
				break;
		}
	}
}

//Function Number: 30
playerdamaged(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isplayer(self))
	{
		return;
	}

	self endon("disconnect");
	if(isdefined(param_01))
	{
		param_01 endon("disconnect");
	}

	wait(0.05);
	maps\mp\_utility::waittillslowprocessallowed();
	var_06 = spawnstruct();
	var_06.victim = self;
	var_06.einflictor = param_00;
	var_06.attacker = param_01;
	var_06.idamage = param_02;
	var_06.smeansofdeath = param_03;
	var_06.sweapon = param_04;
	var_06.shitloc = param_05;
	var_06.victimonground = var_06.victim isonground();
	if(isplayer(param_01))
	{
		var_06.attackerinlaststand = isdefined(var_06.attacker.laststand);
		var_06.attackeronground = var_06.attacker isonground();
		var_06.attackerstance = var_06.attacker getstance();
	}
	else
	{
		var_06.attackerinlaststand = 0;
		var_06.attackeronground = 0;
		var_06.attackerstance = "stand";
	}

	if(isdefined(self) && isdefined(param_01) && isdefined(self.team) && isdefined(param_01.team))
	{
		if(self.team != param_01.team && maps\mp\_utility::_hasperk("specialty_class_flakjacket") && isexplosivedamagemod(var_06.smeansofdeath) && maps\mp\_utility::isreallyalive(self) && param_04 != "killstreak_solar_mp")
		{
			processchallenge("ch_perk_flakjack");
		}

		if(self.team != param_01.team && maps\mp\_utility::_hasperk("specialty_class_toughness"))
		{
			self.lastdamagefromenemytargettime = gettime();
		}
	}

	domissioncallback("playerDamaged",var_06);
}

//Function Number: 31
playerkilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	self.anglesondeath = self getplayerangles();
	if(isdefined(param_01))
	{
		param_01.anglesonkill = param_01 getplayerangles();
	}

	self endon("disconnect");
	var_08 = spawnstruct();
	var_08.victim = self;
	var_08.einflictor = param_00;
	var_08.attacker = param_01;
	var_08.idamage = param_02;
	var_08.smeansofdeath = param_03;
	var_08.sweapon = param_04;
	var_08.sprimaryweapon = param_05;
	var_08.shitloc = param_06;
	var_08.time = gettime();
	var_08.modifiers = param_07;
	var_08.victimonground = var_08.victim isonground();
	if(isplayer(param_01))
	{
		var_08.attackerinlaststand = isdefined(var_08.attacker.laststand);
		var_08.attackeronground = var_08.attacker isonground();
		var_08.attackerstance = var_08.attacker getstance();
	}
	else
	{
		var_08.attackerinlaststand = 0;
		var_08.attackeronground = 0;
		var_08.attackerstance = "stand";
	}

	var_09 = 0;
	if(isdefined(var_08.einflictor) && isdefined(var_08.einflictor.firedads))
	{
		var_09 = var_08.einflictor.firedads;
	}
	else if(isdefined(param_01) && isplayer(param_01))
	{
		var_09 = param_01 playerads();
	}

	var_08.was_ads = 0;
	if(var_09 >= 0.2)
	{
		var_08.was_ads = 1;
	}

	waitandprocessplayerkilledcallback(var_08);
	if(isdefined(param_01) && maps\mp\_utility::isreallyalive(param_01))
	{
		param_01.killsthislife[param_01.killsthislife.size] = var_08;
	}

	var_08.attacker notify("playerKilledChallengesProcessed");
}

//Function Number: 32
vehiclekilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = spawnstruct();
	var_07.vehicle = param_01;
	var_07.victim = param_00;
	var_07.einflictor = param_02;
	var_07.attacker = param_03;
	var_07.idamage = param_04;
	var_07.smeansofdeath = param_05;
	var_07.sweapon = param_06;
	var_07.time = gettime();
	domissioncallback("vehicleKilled",var_07);
}

//Function Number: 33
waitandprocessplayerkilledcallback(param_00)
{
	if(isdefined(param_00.attacker))
	{
		param_00.attacker endon("disconnect");
	}

	self.processingkilledchallenges = 1;
	wait(0.05);
	maps\mp\_utility::waittillslowprocessallowed();
	domissioncallback("playerKilled",param_00);
	self.processingkilledchallenges = undefined;
}

//Function Number: 34
playerassist()
{
	var_00 = spawnstruct();
	var_00.player = self;
	domissioncallback("playerAssist",var_00);
}

//Function Number: 35
usehardpoint(param_00)
{
	self endon("disconnect");
	wait(0.05);
	maps\mp\_utility::waittillslowprocessallowed();
	var_01 = spawnstruct();
	var_01.player = self;
	var_01.hardpointtype = param_00;
	domissioncallback("playerHardpoint",var_01);
}

//Function Number: 36
roundbegin()
{
	domissioncallback("roundBegin");
}

//Function Number: 37
roundend(param_00)
{
	var_01 = spawnstruct();
	if(level.teambased)
	{
		var_02 = "allies";
		for(var_03 = 0;var_03 < level.placement[var_02].size;var_03++)
		{
			var_01.player = level.placement[var_02][var_03];
			var_01.winner = var_02 == param_00;
			var_01.place = var_03;
			domissioncallback("roundEnd",var_01);
		}

		var_02 = "axis";
		for(var_03 = 0;var_03 < level.placement[var_02].size;var_03++)
		{
			var_01.player = level.placement[var_02][var_03];
			var_01.winner = var_02 == param_00;
			var_01.place = var_03;
			domissioncallback("roundEnd",var_01);
		}

		return;
	}

	for(var_03 = 0;var_03 < level.placement["all"].size;var_03++)
	{
		var_01.player = level.placement["all"][var_03];
		var_01.winner = isdefined(param_00) && isplayer(param_00) && var_01.player == param_00;
		var_01.place = var_03;
		domissioncallback("roundEnd",var_01);
	}
}

//Function Number: 38
domissioncallback(param_00,param_01)
{
	if(!mayprocesschallenges())
	{
		return;
	}

	if(getdvarint("disable_challenges") > 0)
	{
		return;
	}

	if(!isdefined(level.missioncallbacks[param_00]))
	{
		return;
	}

	if(isdefined(param_01))
	{
		for(var_02 = 0;var_02 < level.missioncallbacks[param_00].size;var_02++)
		{
			thread [[ level.missioncallbacks[param_00][var_02] ]](param_01);
		}

		return;
	}

	for(var_02 = 0;var_02 < level.missioncallbacks[param_00].size;var_02++)
	{
		thread [[ level.missioncallbacks[param_00][var_02] ]]();
	}
}

//Function Number: 39
monitorsprintdistance()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("sprint_begin");
		self.sprintdistthissprint = 0;
		thread monitorsprinttime();
		monitorsinglesprintdistance();
		if(self isitemunlocked("specialty_longersprint") && maps\mp\_utility::_hasperk("specialty_longersprint"))
		{
			processchallenge("ch_longersprint_pro",int(self.sprintdistthissprint / 12));
		}
	}
}

//Function Number: 40
monitorsinglesprintdistance()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	self endon("sprint_end");
	var_00 = self.origin;
	for(;;)
	{
		wait(0.1);
		self.sprintdistthissprint = self.sprintdistthissprint + distance(self.origin,var_00);
		var_00 = self.origin;
	}
}

//Function Number: 41
monitorsprinttime()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	self waittill("sprint_end");
	self.lastsprintendtime = gettime();
}

//Function Number: 42
monitorfalldistance()
{
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		if(!isalive(self))
		{
			self waittill("spawned_player");
			continue;
		}

		if(!self isonground())
		{
			var_00 = self.origin[2];
			while(!self isonground() && isalive(self))
			{
				if(self.origin[2] > var_00)
				{
					var_00 = self.origin[2];
				}

				wait(0.05);
			}

			var_01 = var_00 - self.origin[2];
			if(var_01 < 0)
			{
				var_01 = 0;
			}

			if(var_01 / 12 > 15 && isalive(self) && maps\mp\_utility::isemped())
			{
				processchallenge("ch_boot_shortcut");
			}

			if(var_01 / 12 > 30 && !isalive(self) && maps\mp\_utility::isemped())
			{
				processchallenge("ch_boot_gravity");
			}
		}

		wait(0.05);
	}
}

//Function Number: 43
monitorboostjumpdistance()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		if(!isalive(self))
		{
			self waittill("spawned_player");
			continue;
		}

		self waittill("exo_boost");
		if(!self isonground())
		{
			var_00 = self.origin[2];
			var_01 = self.origin[2];
			while(!self isonground() && isalive(self))
			{
				if(self.origin[2] > var_00)
				{
					var_00 = self.origin[2];
				}

				wait(0.05);
			}

			var_02 = var_00 - var_01;
			if(var_02 < 0)
			{
				var_02 = 0;
			}

			processchallenge("ch_exomech_frontier",int(ceil(var_02 / 12 / 10)));
		}

		wait(0.05);
	}
}

//Function Number: 44
monitorplayermatchchallenges()
{
	thread monitormatchchallenges("increment_knife_kill",15,"ch_precision_slice");
	thread monitormatchchallenges("increment_stuck_kills",5,"ch_precision_ticktick");
	thread monitormatchchallenges("increment_pistol_headshots",10,"ch_precision_pistoleer");
	thread monitormatchchallenges("increment_ar_headshots",5,"ch_precision_headhunt");
	thread monitormatchchallenges("increment_sharpshooter_kills",10,"ch_precision_sharpshoot");
	thread monitormatchchallenges("increment_oneshotgun_kills",10,"ch_precision_cqexpert");
	thread monitormatchchallenges("increment_duallethal_kills",5,"ch_precision_dangerclose");
}

//Function Number: 45
monitormatchchallenges(param_00,param_01,param_02)
{
	level endon("game_ended");
	self endon("disconnect");
	if(!isdefined(game[param_02]))
	{
		game[param_02] = [];
	}

	if(!isdefined(game[param_02][self.guid]))
	{
		game[param_02][self.guid] = 0;
	}

	thread remove_tracking_on_disconnect(param_02);
	for(;;)
	{
		self waittill(param_00);
		var_03 = game[param_02][self.guid];
		var_03++;
		game[param_02][self.guid] = var_03;
		if(var_03 == param_01)
		{
			processchallenge(param_02);
		}
	}
}

//Function Number: 46
remove_tracking_on_disconnect(param_00)
{
	level endon("game_ended");
	self waittill("disconnect");
	if(isdefined(game[param_00][self.guid]))
	{
		game[param_00][self.guid] = undefined;
	}
}

//Function Number: 47
lastmansd()
{
	if(!mayprocesschallenges())
	{
		return;
	}

	if(!self.wasaliveatmatchstart)
	{
		return;
	}

	if(self.teamkillsthisround > 0)
	{
		return;
	}

	processchallenge("ch_lastmanstanding");
}

//Function Number: 48
monitorbombuse()
{
	self endon("disconnect");
	for(;;)
	{
		var_00 = common_scripts\utility::waittill_any_return("bomb_planted","bomb_defused");
		if(!isdefined(var_00))
		{
			continue;
		}

		if(var_00 == "bomb_planted")
		{
			processchallenge("ch_saboteur");
			continue;
		}

		if(var_00 == "bomb_defused")
		{
			processchallenge("ch_hero");
		}
	}
}

//Function Number: 49
monitorlivetime()
{
	for(;;)
	{
		self waittill("spawned_player");
		thread survivalistchallenge();
	}
}

//Function Number: 50
survivalistchallenge()
{
	self endon("death");
	self endon("disconnect");
	wait(300);
	if(isdefined(self))
	{
		processchallenge("ch_survivalist");
	}
}

//Function Number: 51
monitorstreaks()
{
	self endon("disconnect");
	self.pers["airstrikeStreak"] = 0;
	self.pers["meleeKillStreak"] = 0;
	self.pers["shieldKillStreak"] = 0;
	thread monitormisc();
	for(;;)
	{
		self waittill("death");
		self.pers["airstrikeStreak"] = 0;
		self.pers["meleeKillStreak"] = 0;
		self.pers["shieldKillStreak"] = 0;
	}
}

//Function Number: 52
monitormisc()
{
	self endon("disconnect");
	for(;;)
	{
		var_00 = common_scripts\utility::waittill_any_return_no_endon_death("destroyed_explosive","begin_airstrike","destroyed_car","destroyed_car");
		monitormisccallback(var_00);
	}
}

//Function Number: 53
monitormisccallback(param_00)
{
	switch(param_00)
	{
		case "begin_airstrike":
			self.pers["airstrikeStreak"] = 0;
			break;

		case "destroyed_explosive":
			processchallenge("ch_backdraft");
			if(self isitemunlocked("specialty_detectexplosive") && maps\mp\_utility::_hasperk("specialty_detectexplosive"))
			{
				processchallenge("ch_detectexplosives_pro");
			}
			break;

		case "destroyed_car":
			processchallenge("ch_vandalism");
			break;

		case "crushed_enemy":
			processchallenge("ch_heads_up");
			if(isdefined(self.finalkill))
			{
				processchallenge("ch_droppincrates");
			}
			break;
	}
}

//Function Number: 54
healthregenerated()
{
	if(!isalive(self))
	{
		return;
	}

	if(!mayprocesschallenges())
	{
		return;
	}

	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	thread resetbrinkofdeathkillstreakshortly();
	if(isdefined(self.lastdamagewasfromenemy) && self.lastdamagewasfromenemy)
	{
		self.healthregenerationstreak++;
		if(self.healthregenerationstreak >= 5)
		{
			processchallenge("ch_invincible");
		}
	}
}

//Function Number: 55
resetbrinkofdeathkillstreakshortly()
{
	self endon("disconnect");
	self endon("death");
	self endon("damage");
	wait(1);
	self.brinkofdeathkillstreak = 0;
}

//Function Number: 56
playerspawned()
{
	self.brinkofdeathkillstreak = 0;
	self.healthregenerationstreak = 0;
}

//Function Number: 57
playerdied()
{
	self.brinkofdeathkillstreak = 0;
	self.healthregenerationstreak = 0;
}

//Function Number: 58
isatbrinkofdeath()
{
	var_00 = self.health / self.maxhealth;
	return var_00 <= level.healthoverlaycutoff;
}

//Function Number: 59
processchallenge(param_00,param_01,param_02)
{
	if(!mayprocesschallenges())
	{
		return;
	}

	if(level.players.size < 2 && !getdvarint("force_ranking"))
	{
		var_03 = undefined;
		if(isdefined(var_03))
		{
			if(var_03 == 0)
			{
				return;
			}
		}
		else
		{
			return;
		}
	}

	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_04 = getchallengestatus(param_00);
	if(var_04 == 0)
	{
		return;
	}

	if(var_04 > level.challengeinfo[param_00]["targetval"].size)
	{
		return;
	}

	var_05 = maps\mp\gametypes\_hud_util::ch_getprogress(param_00);
	if(isdefined(param_02) && param_02)
	{
		var_06 = param_01;
	}
	else if(maps\mp\gametypes\_hud_util::isweaponclasschallenge(param_01))
	{
		var_06 = var_06;
	}
	else
	{
		var_06 = var_06 + param_02;
	}

	var_07 = 0;
	var_08 = level.challengeinfo[param_00]["targetval"][var_04];
	while(isdefined(var_08) && var_06 >= var_08)
	{
		var_07++;
		var_08 = level.challengeinfo[param_00]["targetval"][var_04 + var_07];
	}

	if(var_05 < var_06)
	{
		maps\mp\gametypes\_hud_util::ch_setprogress(param_00,var_06);
	}

	if(var_07 > 0)
	{
		var_09 = var_04;
		while(var_07)
		{
			thread giverankxpafterwait(param_00,var_04);
			var_0A = getchallengeid(param_00,var_04);
			self challengenotification(var_0A);
			var_0B = common_scripts\utility::tostring(var_0A);
			var_0C = int(getsubstr(var_0B,0,var_0B.size - 2));
			if(!isdefined(game["challengeStruct"]["challengesCompleted"][self.guid]))
			{
				game["challengeStruct"]["challengesCompleted"][self.guid] = [];
			}

			var_0D = 0;
			foreach(var_0F in game["challengeStruct"]["challengesCompleted"][self.guid])
			{
				if(var_0F == var_0C)
				{
					var_0D = 1;
				}
			}

			if(!var_0D)
			{
				game["challengeStruct"]["challengesCompleted"][self.guid][game["challengeStruct"]["challengesCompleted"][self.guid].size] = var_0C;
			}

			if(var_04 >= level.challengeinfo[param_00]["targetval"].size && level.challengeinfo[param_00]["parent_challenge"] != "")
			{
				processchallenge(level.challengeinfo[param_00]["parent_challenge"]);
			}

			var_04++;
			var_07--;
			var_11 = getchallengerewarditem(var_0A);
			if(var_11 != 0)
			{
				maps\mp\_matchdata::logcompletedchallenge(var_0A);
			}
		}

		if(!issubstr(param_00,"ch_limited_bloodshed"))
		{
			thread maps\mp\gametypes\_hud_message::challengesplashnotify(param_00,var_09,var_04);
		}

		maps\mp\gametypes\_hud_util::ch_setstate(param_00,var_04);
		self.challengedata[param_00] = var_04;
	}
}

//Function Number: 60
giverankxpafterwait(param_00,param_01)
{
	self endon("disconnect");
	wait(0.25);
	maps\mp\gametypes\_rank::giverankxp("challenge",level.challengeinfo[param_00]["reward"][param_01],undefined,undefined,param_00);
}

//Function Number: 61
getmarksmanunlockattachment(param_00,param_01)
{
	return tablelookup("mp/unlockTable.csv",0,param_00,4 + param_01);
}

//Function Number: 62
masterychallengeprocess(param_00)
{
	if(tablelookup("mp/allChallengesTable.csv",0,"ch_" + param_00 + "_mastery",1) == "")
	{
		return;
	}

	var_01 = 0;
	var_02 = maps\mp\_utility::getweaponattachmentfromstats(param_00);
	foreach(var_04 in var_02)
	{
		if(var_04 == "")
		{
			continue;
		}

		if(maps\mp\gametypes\_class::isattachmentunlocked(param_00,var_04))
		{
			var_01++;
		}
	}

	processchallenge("ch_" + param_00 + "_mastery",var_01,1);
}

//Function Number: 63
ischallengeunlocked(param_00,param_01)
{
	var_02 = tablelookupbyrow("mp/allChallengesTable.csv",param_01,8);
	if(var_02 != "")
	{
		var_03 = getchallengestatus(var_02);
		if(var_03 > 1)
		{
			return 1;
		}
	}

	var_04 = tablelookupbyrow("mp/allChallengesTable.csv",param_01,6);
	if(var_04 != "")
	{
		var_05 = maps\mp\gametypes\_rank::getrank();
		if(var_05 < int(var_04))
		{
			return 0;
		}
	}

	var_06 = tablelookupbyrow("mp/allChallengesTable.csv",param_01,7);
	if(var_06 != "")
	{
		var_07 = getchallengestatus(var_06);
		if(var_07 <= 1)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 64
updatechallenges()
{
	self.challengedata = [];
	if(!isdefined(self.ch_unique_earned_streaks))
	{
		self.ch_unique_earned_streaks = [];
	}

	if(!isdefined(game["challengeStruct"]))
	{
		game["challengeStruct"] = [];
	}

	if(!isdefined(game["challengeStruct"]["limitedChallengesReset"]))
	{
		game["challengeStruct"]["limitedChallengesReset"] = [];
	}

	if(!isdefined(game["challengeStruct"]["challengesCompleted"]))
	{
		game["challengeStruct"]["challengesCompleted"] = [];
	}

	self endon("disconnect");
	if(!mayprocesschallenges())
	{
		return;
	}

	if(!self isitemunlocked("challenges"))
	{
		return;
	}

	var_00 = 0;
	foreach(var_05, var_02 in level.challengeinfo)
	{
		var_00++;
		if(var_00 % 40 == 0)
		{
			wait(0.05);
		}

		self.challengedata[var_05] = 0;
		var_03 = var_02["index"];
		var_04 = maps\mp\gametypes\_hud_util::ch_getstate(var_05);
		if(maps\mp\gametypes\_hud_util::istimelimitedchallenge(var_05) && !isdefined(game["challengeStruct"]["limitedChallengesReset"][self.guid]))
		{
			maps\mp\gametypes\_hud_util::ch_setprogress(var_05,0);
			var_04 = 0;
		}

		if(var_04 == 0)
		{
			maps\mp\gametypes\_hud_util::ch_setstate(var_05,1);
			var_04 = 1;
		}

		self.challengedata[var_05] = var_04;
	}

	game["challengeStruct"]["limitedChallengesReset"][self.guid] = 1;
}

//Function Number: 65
isinunlocktable(param_00)
{
	return tablelookup("mp/unlockTable.csv",0,param_00,0) != "";
}

//Function Number: 66
getchallengefilter(param_00)
{
	return tablelookup("mp/allChallengesTable.csv",0,param_00,5);
}

//Function Number: 67
getchallengetable(param_00)
{
	return tablelookup("mp/challengeTable.csv",8,param_00,4);
}

//Function Number: 68
gettierfromtable(param_00,param_01)
{
	return tablelookup(param_00,0,param_01,1);
}

//Function Number: 69
isweaponchallenge(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = getchallengefilter(param_00);
	if(isdefined(var_01) && var_01 == "riotshield")
	{
		return 1;
	}

	var_02 = maps\mp\_utility::getweaponnametokens(param_00);
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = var_02[var_03];
		if(var_04 == "iw5" || var_04 == "iw6")
		{
			var_04 = var_02[var_03] + "_" + var_02[var_03 + 1];
		}

		if(maps\mp\gametypes\_class::isvalidprimary(var_04) || maps\mp\gametypes\_class::isvalidsecondary(var_04,0))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 70
getweaponfromchallenge(param_00)
{
	var_01 = "ch_";
	if(issubstr(param_00,"ch_marksman_"))
	{
		var_01 = "ch_marksman_";
	}
	else if(issubstr(param_00,"ch_expert_"))
	{
		var_01 = "ch_expert_";
	}
	else if(issubstr(param_00,"pr_marksman_"))
	{
		var_01 = "pr_marksman_";
	}
	else if(issubstr(param_00,"pr_expert_"))
	{
		var_01 = "pr_expert_";
	}

	var_02 = getsubstr(param_00,var_01.size,param_00.size);
	var_03 = maps\mp\_utility::getweaponnametokens(var_02);
	var_02 = undefined;
	if(var_03[0] == "iw5" || var_03[0] == "iw6")
	{
		var_02 = var_03[0] + "_" + var_03[1];
	}
	else
	{
		var_02 = var_03[0];
	}

	return var_02;
}

//Function Number: 71
getweaponattachmentfromchallenge(param_00)
{
	var_01 = "ch_";
	if(issubstr(param_00,"ch_marksman_"))
	{
		var_01 = "ch_marksman_";
	}
	else if(issubstr(param_00,"ch_expert_"))
	{
		var_01 = "ch_expert_";
	}
	else if(issubstr(param_00,"pr_marksman_"))
	{
		var_01 = "pr_marksman_";
	}
	else if(issubstr(param_00,"pr_expert_"))
	{
		var_01 = "pr_expert_";
	}

	var_02 = getsubstr(param_00,var_01.size,param_00.size);
	var_03 = maps\mp\_utility::getweaponnametokens(var_02);
	var_04 = undefined;
	if(isdefined(var_03[2]) && maps\mp\_utility::isattachment(var_03[2]))
	{
		var_04 = var_03[2];
	}

	return var_04;
}

//Function Number: 72
iskillstreakchallenge(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = getchallengefilter(param_00);
	if(isdefined(var_01) && var_01 == "killstreaks_assault" || var_01 == "killstreaks_support")
	{
		return 1;
	}

	return 0;
}

//Function Number: 73
getkillstreakfromchallenge(param_00)
{
	var_01 = "ch_";
	var_02 = getsubstr(param_00,var_01.size,param_00.size);
	if(var_02 == "assault_streaks" || var_02 == "support_streaks")
	{
		var_02 = undefined;
	}

	return var_02;
}

//Function Number: 74
challenge_targetval(param_00,param_01,param_02)
{
	var_03 = tablelookup(param_00,0,param_01,9 + param_02 - 1 * 2);
	return int(var_03);
}

//Function Number: 75
challenge_rewardval(param_00,param_01,param_02)
{
	var_03 = tablelookup(param_00,0,param_01,10 + param_02 - 1 * 2);
	return int(var_03);
}

//Function Number: 76
challenge_parentchallenge(param_00,param_01)
{
	var_02 = tablelookup(param_00,0,param_01,42);
	if(!isdefined(var_02))
	{
		var_02 = "";
	}

	return var_02;
}

//Function Number: 77
buildchallengetableinfo(param_00,param_01)
{
	var_02 = 0;
	var_03 = 0;
	for(;;)
	{
		var_03++;
		var_04 = tablelookupbyrow(param_00,var_03,0);
		if(var_04 == "")
		{
			break;
		}

		var_05 = tablelookupbyrow(param_00,var_03,43);
		if(var_05 == "1")
		{
			continue;
		}

		level.challengeinfo[var_04] = [];
		level.challengeinfo[var_04]["index"] = var_03;
		level.challengeinfo[var_04]["type"] = param_01;
		level.challengeinfo[var_04]["targetval"] = [];
		level.challengeinfo[var_04]["reward"] = [];
		level.challengeinfo[var_04]["parent_challenge"] = "";
		if(isweaponchallenge(var_04))
		{
			var_06 = getweaponfromchallenge(var_04);
			var_07 = getweaponattachmentfromchallenge(var_04);
			if(isdefined(var_06))
			{
				level.challengeinfo[var_04]["weapon"] = var_06;
			}

			if(isdefined(var_07))
			{
				level.challengeinfo[var_04]["attachment"] = var_07;
			}
		}
		else if(iskillstreakchallenge(var_04))
		{
			var_08 = getkillstreakfromchallenge(var_04);
			if(isdefined(var_08))
			{
				level.challengeinfo[var_04]["killstreak"] = var_08;
			}
		}

		for(var_09 = 1;var_09 < 11;var_09++)
		{
			var_0A = challenge_targetval(param_00,var_04,var_09);
			var_0B = challenge_rewardval(param_00,var_04,var_09);
			if(var_0A == 0)
			{
				break;
			}

			level.challengeinfo[var_04]["targetval"][var_09] = var_0A;
			level.challengeinfo[var_04]["reward"][var_09] = var_0B;
			var_02 = var_02 + var_0B;
		}

		level.challengeinfo[var_04]["parent_challenge"] = challenge_parentchallenge(param_00,var_04);
	}

	return int(var_02);
}

//Function Number: 78
buildchallegeinfo()
{
	level.challengeinfo = [];
	if(getdvar("virtualLobbyActive") == "1")
	{
		return;
	}

	var_00 = 0;
	var_00 = var_00 + buildchallengetableinfo("mp/allChallengesTable.csv",0);
}

//Function Number: 79
monitorprocesschallenge()
{
	self endon("disconnect");
	level endon("game_end");
	for(;;)
	{
		if(!mayprocesschallenges())
		{
			return;
		}

		self waittill("process",var_00);
		processchallenge(var_00);
	}
}

//Function Number: 80
monitorkillstreakprogress()
{
	self endon("disconnect");
	level endon("game_end");
	for(;;)
	{
		self waittill("got_killstreak",var_00);
		if(!isdefined(var_00))
		{
			continue;
		}

		if(var_00 == 9 && isdefined(self.killstreaks[7]) && isdefined(self.killstreaks[8]) && isdefined(self.killstreaks[9]))
		{
			processchallenge("ch_6fears7");
		}

		if(var_00 == 10 && self.killstreaks.size == 0)
		{
			processchallenge("ch_theloner");
		}
	}
}

//Function Number: 81
monitorkilledkillstreak()
{
	self endon("disconnect");
	level endon("game_end");
	for(;;)
	{
		self waittill("destroyed_killstreak",var_00);
		if(self isitemunlocked("specialty_blindeye") && maps\mp\_utility::_hasperk("specialty_blindeye"))
		{
			processchallenge("ch_blindeye_pro");
		}

		if(isdefined(var_00) && var_00 == "stinger_mp")
		{
			processchallenge("ch_marksman_stinger");
			processchallenge("pr_marksman_stinger");
		}
	}
}

//Function Number: 82
genericchallenge(param_00,param_01)
{
	switch(param_00)
	{
		case "hijacker_airdrop":
			processchallenge("ch_smoothcriminal");
			break;

		case "wargasm":
			processchallenge("ch_wargasm");
			break;

		case "weapon_assault":
			processchallenge("ch_surgical_assault");
			break;

		case "weapon_smg":
			processchallenge("ch_surgical_smg");
			break;

		case "weapon_lmg":
			processchallenge("ch_surgical_lmg");
			break;

		case "weapon_dmr":
			break;

		case "weapon_sniper":
			processchallenge("ch_surgical_sniper");
			break;

		case "shield_damage":
			if(!maps\mp\_utility::isjuggernaut())
			{
				processchallenge("ch_shield_damage",param_01);
			}
			break;

		case "shield_bullet_hits":
			if(!maps\mp\_utility::isjuggernaut())
			{
				processchallenge("ch_shield_bullet",param_01);
			}
			break;

		case "shield_explosive_hits":
			if(!maps\mp\_utility::isjuggernaut())
			{
				processchallenge("ch_shield_explosive",param_01);
			}
			break;
	}
}

//Function Number: 83
playerhasammo()
{
	var_00 = self getweaponslistprimaries();
	foreach(var_02 in var_00)
	{
		if(self getweaponammoclip(var_02))
		{
			return 1;
		}

		var_03 = weaponaltweaponname(var_02);
		if(!isdefined(var_03) || var_03 == "none")
		{
			continue;
		}

		if(self getweaponammoclip(var_03))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 84
monitoradstime()
{
	self endon("disconnect");
	self.adstime = 0;
	for(;;)
	{
		if(self playerads() == 1)
		{
			self.adstime = self.adstime + 0.05;
		}
		else
		{
			self.adstime = 0;
		}

		wait(0.05);
	}
}

//Function Number: 85
monitorpronetime()
{
	self endon("disconnect");
	level endon("game_ended");
	self.pronetime = undefined;
	var_00 = 0;
	for(;;)
	{
		var_01 = self getstance();
		if(var_01 == "prone" && var_00 == 0)
		{
			self.pronetime = gettime();
			var_00 = 1;
		}
		else if(var_01 != "prone")
		{
			self.pronetime = undefined;
			var_00 = 0;
		}

		wait(0.05);
	}
}

//Function Number: 86
monitorpowerslidetime()
{
	self endon("disconnect");
	level endon("game_ended");
	self.powerslidetime = undefined;
	for(;;)
	{
		while(!self ispowersliding())
		{
			wait(0.05);
		}

		self.powerslidetime = gettime();
		wait(0.05);
	}
}

//Function Number: 87
monitorholdbreath()
{
	self endon("disconnect");
	self.holdingbreath = 0;
	for(;;)
	{
		self waittill("hold_breath");
		self.holdingbreath = 1;
		self waittill("release_breath");
		self.holdingbreath = 0;
	}
}

//Function Number: 88
monitormantle()
{
	self endon("disconnect");
	self.mantling = 0;
	for(;;)
	{
		self waittill("jumped");
		var_00 = self getcurrentweapon();
		common_scripts\utility::waittill_notify_or_timeout("weapon_change",1);
		var_01 = self getcurrentweapon();
		if(var_01 == "none")
		{
			self.mantling = 1;
		}
		else
		{
			self.mantling = 0;
		}

		if(self.mantling)
		{
			if(self isitemunlocked("specialty_fastmantle") && maps\mp\_utility::_hasperk("specialty_fastmantle"))
			{
				processchallenge("ch_fastmantle");
			}

			common_scripts\utility::waittill_notify_or_timeout("weapon_change",1);
			var_01 = self getcurrentweapon();
			if(var_01 == var_00)
			{
				self.mantling = 0;
			}
		}
	}
}

//Function Number: 89
monitorweaponswap()
{
	self endon("disconnect");
	var_00 = self getcurrentweapon();
	for(;;)
	{
		self waittill("weapon_change",var_01);
		if(var_01 == "none")
		{
			continue;
		}

		if(var_01 == var_00)
		{
			continue;
		}

		if(maps\mp\_utility::iskillstreakweapon(var_01))
		{
			continue;
		}

		if(maps\mp\_utility::isbombsiteweapon(var_01))
		{
			continue;
		}

		var_02 = weaponinventorytype(var_01);
		if(var_02 != "primary")
		{
			continue;
		}

		self.lastprimaryweaponswaptime = gettime();
	}
}

//Function Number: 90
monitorflashbang()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("flashbang",var_00,var_01,var_02,var_03);
		if(isdefined(var_03) && self == var_03)
		{
			continue;
		}

		self.lastflashedtime = gettime();
	}
}

//Function Number: 91
monitorconcussion()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("concussed",var_00);
		if(self == var_00)
		{
			continue;
		}

		self.lastconcussedtime = gettime();
	}
}

//Function Number: 92
monitorminetriggering()
{
	self endon("disconnect");
	for(;;)
	{
		common_scripts\utility::waittill_any("triggered_mine","triggered_claymore");
		thread waitdelayminetime();
	}
}

//Function Number: 93
waitdelayminetime()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(level.delayminetime + 2);
	processchallenge("ch_delaymine");
}

//Function Number: 94
is_lethal_equipment(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	switch(param_00)
	{
		case "explosive_drone_mp":
		case "exoknife_mp":
		case "semtex_mp":
		case "frag_grenade_mp":
			return 1;

		default:
			return 0;
	}
}