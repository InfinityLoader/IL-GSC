/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_missions.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 85
 * Decompile Time: 1257 ms
 * Timestamp: 10/27/2023 2:25:40 AM
*******************************************************************/

//Function Number: 1
init()
{
	precachestring(&"MP_CHALLENGE_COMPLETED");
	if(!func_3223())
	{
		return;
	}

	level.missioncallbacks = [];
	registermissioncallback("playerKilled",::ch_kills);
	registermissioncallback("playerKilled",::ch_vehicle_kills);
	registermissioncallback("playerHardpoint",::ch_hardpoints);
	registermissioncallback("playerAssist",::ch_assists);
	registermissioncallback("roundEnd",::func_3253);
	registermissioncallback("roundEnd",::ch_roundplayed);
	registermissioncallback("vehicleKilled",::ch_vehicle_killed);
	level thread func_3221();
	level thread onplayerconnect();
}

//Function Number: 2
func_3221()
{
	level.perkmap = [];
	level.perkmap["specialty_bulletdamage"] = "specialty_stoppingpower";
	level.perkmap["specialty_quieter"] = "specialty_deadsilence";
	level.perkmap["specialty_localjammer"] = "specialty_scrambler";
	level.perkmap["specialty_fastreload"] = "specialty_sleightofhand";
	level.perkmap["specialty_pistoldeath"] = "specialty_laststand";
}

//Function Number: 3
func_3223()
{
	return level.rankedmatch;
}

//Function Number: 4
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(!isdefined(var_00.pers["postGameChallenges"]))
		{
			var_00.pers["postGameChallenges"] = 0;
		}

		var_00 thread onplayerspawned();
		var_00 thread initmissiondata();
		var_00 thread func_325E();
		var_00 thread func_325C();
		var_00 thread func_325F();
		var_00 thread monitorstreaks();
		var_00 thread func_3228();
		var_00 thread monitorscavengerpickup();
		var_00 thread func_3229();
		var_00 thread monitortacinsertionsdestroyed();
		var_00 thread monitorprocesschallenge();
		var_00 thread func_326F();
		var_00 thread func_322B();
		var_00 thread monitoradstime();
		var_00 thread func_3276();
		var_00 thread monitorflashbang();
		var_00 thread monitorconcussion();
		var_00 thread func_3279();
		var_00 notifyonplayercommand("hold_breath","+breath_sprint");
		var_00 notifyonplayercommand("hold_breath","+melee_breath");
		var_00 notifyonplayercommand("release_breath","-breath_sprint");
		var_00 notifyonplayercommand("release_breath","-melee_breath");
		var_00 thread func_3273();
		var_00 notifyonplayercommand("jumped","+goStand");
		var_00 thread func_3274();
		if(isdefined(level.patientzeroname) && issubstr(var_00.name,level.patientzeroname))
		{
			var_00 setplayerdata("challengeState","ch_infected",2);
			var_00 setplayerdata("challengeProgress","ch_infected",1);
			var_00 setplayerdata("challengeState","ch_plague",2);
			var_00 setplayerdata("challengeProgress","ch_plague",1);
		}

		var_00 setplayerdata("round","weaponsUsed",0,"none");
		var_00 setplayerdata("round","weaponsUsed",1,"none");
		var_00 setplayerdata("round","weaponsUsed",2,"none");
		var_00 setplayerdata("round","weaponXpEarned",0,0);
		var_00 setplayerdata("round","weaponXpEarned",1,0);
		var_00 setplayerdata("round","weaponXpEarned",2,0);
		var_01 = var_00 getplayerdata("cardTitle");
		var_02 = tablelookupbyrow("mp/cardTitleTable.csv",var_01,0);
		if(var_02 == "cardtitle_infected")
		{
			var_00.infected = 1;
			continue;
		}

		if(var_02 == "cardtitle_plague")
		{
			var_00.plague = 1;
		}
	}
}

//Function Number: 5
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		thread monitorsprintdistance();
	}
}

//Function Number: 6
monitorscavengerpickup()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("scavenger_pickup");
		if(self isitemunlocked("specialty_scavenger") && maps\mp\_utility::func_27AF("specialty_scavenger") && !maps\mp\_utility::isjuggernaut())
		{
			processchallenge("ch_scavenger_pro");
		}

		wait 0.05;
	}
}

//Function Number: 7
func_3228()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("received_earned_killstreak");
		if(self isitemunlocked("specialty_hardline") && maps\mp\_utility::func_27AF("specialty_hardline"))
		{
			processchallenge("ch_hardline_pro");
		}

		wait 0.05;
	}
}

//Function Number: 8
func_3229()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("survived_explosion",var_00);
		if(isdefined(var_00) && isplayer(var_00) && self == var_00)
		{
			continue;
		}

		if(self isitemunlocked("_specialty_blastshield") && maps\mp\_utility::func_27AF("_specialty_blastshield"))
		{
			processchallenge("ch_blastshield_pro");
		}

		common_scripts\utility::waitframe();
	}
}

//Function Number: 9
monitortacinsertionsdestroyed()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("destroyed_insertion",var_00);
		if(self == var_00)
		{
			return;
		}

		processchallenge("ch_darkbringer");
		maps\mp\_utility::incplayerstat("mosttacprevented",1);
		thread maps\mp\gametypes\_hud_message::func_2892("denied",20);
		var_00 maps\mp\gametypes\_hud_message::playercardsplashnotify("destroyed_insertion",self);
		common_scripts\utility::waitframe();
	}
}

//Function Number: 10
func_322B()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("revive");
		processchallenge("ch_livingdead");
		common_scripts\utility::waitframe();
	}
}

//Function Number: 11
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

//Function Number: 12
registermissioncallback(param_00,param_01)
{
	if(!isdefined(level.missioncallbacks[param_00]))
	{
		level.missioncallbacks[param_00] = [];
	}

	level.missioncallbacks[param_00][level.missioncallbacks[param_00].size] = param_01;
}

//Function Number: 13
getchallengestatus(param_00)
{
	if(isdefined(self.challengedata[param_00]))
	{
		return self.challengedata[param_00];
	}

	return 0;
}

//Function Number: 14
ch_assists(param_00)
{
	var_01 = param_00.player;
	var_01 processchallenge("ch_assists");
}

//Function Number: 15
ch_hardpoints(param_00)
{
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

		case "predator_missile":
			var_01 processchallenge("ch_predator_missile");
			var_01 processchallenge("ch_assault_streaks");
			break;

		case "ims":
			var_01 processchallenge("ch_ims");
			var_01 processchallenge("ch_assault_streaks");
			break;

		case "airdrop_sentry_minigun":
			var_01 processchallenge("ch_airdrop_sentry_minigun");
			var_01 processchallenge("ch_assault_streaks");
			break;

		case "precision_airstrike":
			var_01 processchallenge("ch_precision_airstrike");
			var_01 processchallenge("ch_assault_streaks");
			if(var_01.pers["precision_airstrike"] >= 2)
			{
				var_01 processchallenge("ch_afterburner");
			}
			break;

		case "helicopter":
			var_01 processchallenge("ch_helicopter");
			var_01 processchallenge("ch_assault_streaks");
			if(var_01.pers["helicopter"] >= 2)
			{
				var_01 processchallenge("ch_airsuperiority");
			}
			break;

		case "littlebird_flock":
			var_01 processchallenge("ch_littlebird_flock");
			var_01 processchallenge("ch_assault_streaks");
			break;

		case "littlebird_support":
			var_01 processchallenge("ch_littlebird_support");
			var_01 processchallenge("ch_assault_streaks");
			break;

		case "remote_mortar":
			var_01 processchallenge("ch_remote_mortar");
			var_01 processchallenge("ch_assault_streaks");
			break;

		case "airdrop_remote_tank":
			var_01 processchallenge("ch_airdrop_remote_tank");
			var_01 processchallenge("ch_assault_streaks");
			break;

		case "helicopter_flares":
			var_01 processchallenge("ch_helicopter_flares");
			var_01 processchallenge("ch_assault_streaks");
			break;

		case "ac130":
			var_01 processchallenge("ch_ac130");
			var_01 processchallenge("ch_assault_streaks");
			break;

		case "airdrop_juggernaut":
			var_01 processchallenge("ch_airdrop_juggernaut");
			var_01 processchallenge("ch_assault_streaks");
			break;

		case "osprey_gunner":
			var_01 processchallenge("ch_osprey_gunner");
			var_01 processchallenge("ch_assault_streaks");
			break;

		case "uav_support":
			var_01 processchallenge("ch_uav_support");
			var_01 processchallenge("ch_support_streaks");
			if(var_01.pers["uav"] >= 3)
			{
				var_01 processchallenge("ch_nosecrets");
			}
			break;

		case "counter_uav":
			var_01 processchallenge("ch_counter_uav");
			var_01 processchallenge("ch_support_streaks");
			if(var_01.pers["counter_uav"] >= 3)
			{
				var_01 processchallenge("ch_sunblock");
			}
			break;

		case "deployable_vest":
			var_01 processchallenge("ch_deployable_vest");
			var_01 processchallenge("ch_support_streaks");
			break;

		case "airdrop_trap":
			var_01 processchallenge("ch_airdrop_trap");
			var_01 processchallenge("ch_support_streaks");
			break;

		case "sam_turret":
			var_01 processchallenge("ch_sam_turret");
			var_01 processchallenge("ch_support_streaks");
			break;

		case "remote_uav":
			var_01 processchallenge("ch_remote_uav");
			var_01 processchallenge("ch_support_streaks");
			break;

		case "triple_uav":
			var_01 processchallenge("ch_triple_uav");
			var_01 processchallenge("ch_support_streaks");
			break;

		case "remote_mg_turret":
			var_01 processchallenge("ch_remote_mg_turret");
			var_01 processchallenge("ch_support_streaks");
			break;

		case "stealth_airstrike":
			var_01 processchallenge("ch_stealth_airstrike");
			var_01 processchallenge("ch_support_streaks");
			break;

		case "emp":
			var_01 processchallenge("ch_emp");
			var_01 processchallenge("ch_support_streaks");
			break;

		case "airdrop_juggernaut_recon":
			var_01 processchallenge("ch_airdrop_juggernaut_recon");
			var_01 processchallenge("ch_support_streaks");
			break;

		case "escort_airdrop":
			var_01 processchallenge("ch_escort_airdrop");
			var_01 processchallenge("ch_support_streaks");
			break;

		case "specialty_longersprint_ks_pro":
		case "specialty_longersprint_ks":
			var_01 processchallenge("ch_longersprint_ks");
			var_01 processchallenge("ch_specialist_streaks");
			break;

		case "specialty_fastreload_ks_pro":
		case "specialty_fastreload_ks":
			var_01 processchallenge("ch_fastreload_ks");
			var_01 processchallenge("ch_specialist_streaks");
			break;

		case "specialty_scavenger_ks_pro":
		case "specialty_scavenger_ks":
			var_01 processchallenge("ch_scavenger_ks");
			var_01 processchallenge("ch_specialist_streaks");
			break;

		case "specialty_blindeye_ks_pro":
		case "specialty_blindeye_ks":
			var_01 processchallenge("ch_blindeye_ks");
			var_01 processchallenge("ch_specialist_streaks");
			break;

		case "specialty_paint_ks_pro":
		case "specialty_paint_ks":
			var_01 processchallenge("ch_paint_ks");
			var_01 processchallenge("ch_specialist_streaks");
			break;

		case "specialty_hardline_ks_pro":
		case "specialty_hardline_ks":
			var_01 processchallenge("ch_hardline_ks");
			var_01 processchallenge("ch_specialist_streaks");
			break;

		case "specialty_coldblooded_ks_pro":
		case "specialty_coldblooded_ks":
			var_01 processchallenge("ch_coldblooded_ks");
			var_01 processchallenge("ch_specialist_streaks");
			break;

		case "specialty_quickdraw_ks_pro":
		case "specialty_quickdraw_ks":
			var_01 processchallenge("ch_quickdraw_ks");
			var_01 processchallenge("ch_specialist_streaks");
			break;

		case "_specialty_blastshield_ks_pro":
		case "_specialty_blastshield_ks":
			var_01 processchallenge("ch_blastshield_ks");
			var_01 processchallenge("ch_specialist_streaks");
			break;

		case "specialty_detectexplosive_ks_pro":
		case "specialty_detectexplosive_ks":
			var_01 processchallenge("ch_detectexplosive_ks");
			var_01 processchallenge("ch_specialist_streaks");
			break;

		case "specialty_autospot_ks_pro":
		case "specialty_autospot_ks":
			var_01 processchallenge("ch_autospot_ks");
			var_01 processchallenge("ch_specialist_streaks");
			break;

		case "specialty_bulletaccuracy_ks_pro":
		case "specialty_bulletaccuracy_ks":
			var_01 processchallenge("ch_bulletaccuracy_ks");
			var_01 processchallenge("ch_specialist_streaks");
			break;

		case "specialty_quieter_ks_pro":
		case "specialty_quieter_ks":
			var_01 processchallenge("ch_quieter_ks");
			var_01 processchallenge("ch_specialist_streaks");
			break;

		case "specialty_stalker_ks_pro":
		case "specialty_stalker_ks":
			var_01 processchallenge("ch_stalker_ks");
			var_01 processchallenge("ch_specialist_streaks");
			break;

		case "all_perks_bonus":
			var_01 processchallenge("ch_all_perks_bonus");
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

	if(!maps\mp\_utility::func_2829(param_00.sweapon))
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

		case "pavelow_minigun_mp":
			var_01 processchallenge("ch_jollygreengiant");
			if(isdefined(var_01.finalkill))
			{
				var_01 processchallenge("ch_transformer");
			}
			break;

		case "sentry_minigun_mp":
			var_01 processchallenge("ch_looknohands");
			if(isdefined(var_01.finalkill))
			{
				var_01 processchallenge("ch_absentee");
			}
			break;

		case "ac130_25mm_mp":
		case "ac130_40mm_mp":
		case "ac130_105mm_mp":
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

		case "cobra_20mm_mp":
			var_01 processchallenge("ch_choppervet");
			if(isdefined(var_01.finalkill))
			{
				var_01 processchallenge("ch_og");
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
}

//Function Number: 18
clearidshortly(param_00)
{
	self endon("disconnect");
	self notify("clearing_expID_" + param_00);
	self endon("clearing_expID_" + param_00);
	wait 3;
	self.explosivekills[param_00] = undefined;
}

//Function Number: 19
func_3236()
{
	var_00 = self;
	if(!isdefined(var_00.pers["MGStreak"]))
	{
		var_00.pers["MGStreak"] = 0;
		var_00 thread func_3237();
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
func_3237()
{
	self endon("disconnect");
	for(;;)
	{
		if(!isalive(self) || self usebuttonpressed())
		{
			self.pers["MGStreak"] = undefined;
			break;
		}

		wait 0.05;
	}
}

//Function Number: 21
func_3238()
{
	self.pers["MGStreak"] = undefined;
}

//Function Number: 22
func_3239(param_00)
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
ch_kills(param_00,param_01)
{
	param_00.victim playerdied();
	if(!isdefined(param_00.attacker) || !isplayer(param_00.attacker))
	{
		return;
	}

	var_02 = param_00.attacker;
	param_01 = param_00.time;
	if(var_02.pers["cur_kill_streak"] == 10)
	{
		var_02 processchallenge("ch_fearless");
	}

	if(level.teambased)
	{
		if(level.teamcount[param_00.victim.pers["team"]] > 3 && var_02.killedplayers.size >= level.teamcount[param_00.victim.pers["team"]])
		{
			var_02 processchallenge("ch_tangodown");
		}

		if(level.teamcount[param_00.victim.pers["team"]] > 3 && var_02.killedplayerscurrent.size >= level.teamcount[param_00.victim.pers["team"]])
		{
			var_02 processchallenge("ch_extremecruelty");
		}
	}

	if(isdefined(param_00.victim.inplayersmokescreen) && param_00.victim.inplayersmokescreen == var_02)
	{
		var_02 processchallenge("ch_smokeemifyougotem");
	}

	if(isdefined(param_00.victim.inplayerscrambler) && param_00.victim.inplayerscrambler == var_02)
	{
		var_02 processchallenge("ch_scram");
	}

	if(isdefined(param_00.victim.inplayerportableradar) && param_00.victim.inplayerportableradar == var_02)
	{
		var_02 processchallenge("ch_zerolatency");
	}

	if(isdefined(var_02.killedplayers[param_00.victim.guid]) && var_02.killedplayers[param_00.victim.guid] == 5)
	{
		var_02 processchallenge("ch_rival");
	}

	if(isdefined(var_02.tookweaponfrom[param_00.sweapon]))
	{
		if(var_02.tookweaponfrom[param_00.sweapon] == param_00.victim && param_00.smeansofdeath != "MOD_MELEE")
		{
			var_02 processchallenge("ch_cruelty");
		}
	}

	var_03 = 0;
	var_04 = 0;
	var_05 = 0;
	var_06 = 1;
	var_07[param_00.victim.name] = param_00.victim.name;
	var_08[param_00.sweapon] = param_00.sweapon;
	var_09 = 1;
	var_0A = [];
	foreach(var_0C in var_02.killsthislife)
	{
		if(maps\mp\_utility::iscacsecondaryweapon(var_0C.sweapon) && var_0C.smeansofdeath != "MOD_MELEE")
		{
			var_04++;
		}

		if(isdefined(var_0C.modifiers["longshot"]))
		{
			var_05++;
		}

		if(param_01 - var_0C.time < 10000)
		{
			var_06++;
		}

		if(maps\mp\_utility::func_2829(var_0C.sweapon))
		{
			if(!isdefined(var_0A[var_0C.sweapon]))
			{
				var_0A[var_0C.sweapon] = 0;
			}

			var_0A[var_0C.sweapon]++;
			continue;
		}

		if(isdefined(level.onelefttime[var_02.team]) && var_0C.time > level.onelefttime[var_02.team])
		{
			var_03++;
		}

		if(isdefined(var_0C.victim))
		{
			if(!isdefined(var_07[var_0C.victim.name]) && !isdefined(var_08[var_0C.sweapon]) && !maps\mp\_utility::func_2829(var_0C.sweapon))
			{
				var_09++;
			}

			var_07[var_0C.victim.name] = var_0C.victim.name;
		}

		var_08[var_0C.sweapon] = var_0C.sweapon;
	}

	foreach(var_0F in var_0A)
	{
		if(var_0F >= 10)
		{
			var_02 processchallenge("ch_crabmeat");
		}
	}

	if(var_09 == 3)
	{
		var_02 processchallenge("ch_renaissance");
	}

	if(var_06 > 3 && level.teamcount[param_00.victim.team] <= var_06)
	{
		var_02 processchallenge("ch_omnicide");
	}

	if(maps\mp\_utility::iscacsecondaryweapon(param_00.sweapon) && var_04 == 2)
	{
		var_02 processchallenge("ch_sidekick");
	}

	if(isdefined(param_00.modifiers["longshot"]) && var_05 == 2)
	{
		var_02 processchallenge("ch_nbk");
	}

	if(isdefined(level.onelefttime[var_02.team]) && var_03 == 2)
	{
		var_02 processchallenge("ch_enemyofthestate");
	}

	if(var_02 isitemunlocked("specialty_twoprimaries") && var_02 maps\mp\_utility::func_27AF("specialty_twoprimaries") && var_02.secondaryweapon == param_00.sweapon)
	{
		var_02 processchallenge("ch_twoprimaries_pro");
	}

	if(param_00.victim.score > 0)
	{
		if(level.teambased)
		{
			var_11 = param_00.victim.pers["team"];
			if(isdefined(var_11) && var_11 != var_02.pers["team"])
			{
				if(ishighestscoringplayer(param_00.victim) && level.players.size >= 6)
				{
					var_02 func_3239(1);
				}
				else
				{
					var_02 func_3239(0);
				}
			}
		}
		else if(ishighestscoringplayer(param_00.victim) && level.players.size >= 4)
		{
			var_02 func_3239(1);
		}
		else
		{
			var_02 func_3239(0);
		}
	}

	if(isdefined(param_00.modifiers["avenger"]))
	{
		var_02 processchallenge("ch_avenger");
	}

	if(isdefined(param_00.modifiers["buzzkill"]) && param_00.modifiers["buzzkill"] >= 9)
	{
		var_02 processchallenge("ch_thedenier");
	}

	if(isdefined(var_02.finalkill))
	{
		var_02 processchallenge("ch_theedge");
	}

	if(maps\mp\_utility::func_2829(param_00.sweapon))
	{
		return;
	}

	if(isdefined(param_00.modifiers["jackintheboxkill"]))
	{
		var_02 processchallenge("ch_jackinthebox");
	}

	if(isdefined(param_00.modifiers["cooking"]))
	{
		var_02 processchallenge("ch_no");
	}

	if(isdefined(var_02.finalkill))
	{
		if(isdefined(param_00.modifiers["revenge"]))
		{
			var_02 processchallenge("ch_moneyshot");
		}
	}

	if(var_02 func_3268())
	{
		var_02.brinkofdeathkillstreak++;
		if(var_02.brinkofdeathkillstreak >= 3)
		{
			var_02 processchallenge("ch_thebrink");
		}
	}

	if(isdefined(var_02.infinalstand) && var_02.infinalstand)
	{
		if(isdefined(param_00.modifiers["revenge"]))
		{
			var_02 processchallenge("ch_robinhood");
		}

		if(isdefined(var_02.finalkill))
		{
			var_02 processchallenge("ch_lastresort");
		}

		if(maps\mp\_utility::func_323E(param_00.sweapon,"c4_"))
		{
			var_02 processchallenge("ch_clickclickboom");
		}

		var_02 processchallenge("ch_laststandvet");
	}

	if(param_00.smeansofdeath == "MOD_PISTOL_BULLET" || param_00.smeansofdeath == "MOD_RIFLE_BULLET")
	{
		var_12 = maps\mp\_utility::getweaponclass(param_00.sweapon);
		func_324D(param_00,var_02,param_01,var_12);
		if(maps\mp\_utility::func_2CC3(param_00.sweapon))
		{
			var_02 func_3236();
		}
		else
		{
			var_13 = maps\mp\_utility::getbaseweaponname(param_00.sweapon);
			if(isdefined(level.challengeinfo["ch_marksman_" + var_13]))
			{
				var_02 processchallenge("ch_marksman_" + var_13);
			}

			if(isdefined(level.challengeinfo["pr_marksman_" + var_13]))
			{
				var_02 processchallenge("pr_marksman_" + var_13);
			}

			var_12 = tablelookup("mp/statstable.csv",4,var_13,2);
			switch(var_12)
			{
				case "weapon_smg":
					var_02 processchallenge("ch_smg_kill");
					break;

				case "weapon_assault":
					var_02 processchallenge("ch_ar_kill");
					break;

				case "weapon_shotgun":
					var_02 processchallenge("ch_shotgun_kill");
					break;

				case "weapon_sniper":
					var_02 processchallenge("ch_sniper_kill");
					break;

				case "weapon_pistol":
					var_02 processchallenge("ch_handgun_kill");
					break;

				case "weapon_machine_pistol":
					var_02 processchallenge("ch_machine_pistols_kill");
					break;

				case "weapon_lmg":
					var_02 processchallenge("ch_lmg_kill");
					break;

				default:
					break;
			}
		}
	}
	else if(issubstr(param_00.smeansofdeath,"MOD_GRENADE") || issubstr(param_00.smeansofdeath,"MOD_EXPLOSIVE") || issubstr(param_00.smeansofdeath,"MOD_PROJECTILE"))
	{
		if(maps\mp\_utility::func_323E(param_00.sweapon,"frag_grenade_short") && !isdefined(param_00.victim.explosiveinfo["throwbackKill"]) || !param_00.victim.explosiveinfo["throwbackKill"])
		{
			var_02 processchallenge("ch_martyr");
		}

		if(isdefined(param_00.victim.explosiveinfo["damageTime"]) && param_00.victim.explosiveinfo["damageTime"] == param_01)
		{
			if(param_00.sweapon == "none")
			{
				param_00.sweapon = param_00.victim.explosiveinfo["weapon"];
			}

			var_14 = param_01 + "_" + param_00.victim.explosiveinfo["damageId"];
			if(!isdefined(var_02.explosivekills[var_14]))
			{
				var_02.explosivekills[var_14] = 0;
			}

			var_02 thread clearidshortly(var_14);
			var_02.explosivekills[var_14]++;
			var_13 = maps\mp\_utility::getbaseweaponname(param_00.sweapon);
			if(var_13 == "javelin" || var_13 == "m79" || var_13 == "at4" || var_13 == "rpg" || var_13 == "iw5_smaw")
			{
				var_02 processchallenge("ch_launcher_kill");
				if(var_02.explosivekills[var_14] > 1)
				{
					var_02 processchallenge("pr_expert_" + var_13);
				}
			}

			var_15 = maps\mp\_utility::getweaponattachments(param_00.sweapon);
			foreach(var_17 in var_15)
			{
				switch(var_17)
				{
					case "gl":
					case "m320":
					case "gp25":
						if(maps\mp\_utility::func_323E(param_00.sweapon,"alt_"))
						{
							var_02 processchallenge("ch_" + var_13 + "_" + var_17);
						}
						break;
				}
			}

			if(isdefined(param_00.victim.explosiveinfo["stickKill"]) && param_00.victim.explosiveinfo["stickKill"])
			{
				if(isdefined(param_00.modifiers["revenge"]))
				{
					var_02 processchallenge("ch_overdraft");
				}

				if(isdefined(var_02.finalkill))
				{
					var_02 processchallenge("ch_stickman");
				}

				if(var_02.explosivekills[var_14] > 1)
				{
					var_02 processchallenge("ch_grouphug");
				}
			}

			if(isdefined(param_00.victim.explosiveinfo["stickFriendlyKill"]) && param_00.victim.explosiveinfo["stickFriendlyKill"])
			{
				var_02 processchallenge("ch_resourceful");
			}

			if(!issubstr(var_13,"stinger"))
			{
				if(isdefined(level.challengeinfo["ch_marksman_" + var_13]))
				{
					var_02 processchallenge("ch_marksman_" + var_13);
				}

				if(isdefined(level.challengeinfo["pr_marksman_" + var_13]))
				{
					var_02 processchallenge("pr_marksman_" + var_13);
				}
			}

			if(maps\mp\_utility::func_323E(param_00.sweapon,"frag_"))
			{
				if(var_02.explosivekills[var_14] > 1)
				{
					var_02 processchallenge("ch_multifrag");
				}

				if(isdefined(param_00.modifiers["revenge"]))
				{
					var_02 processchallenge("ch_bangforbuck");
				}

				var_02 processchallenge("ch_grenadekill");
				if(param_00.victim.explosiveinfo["cookedKill"])
				{
					var_02 processchallenge("ch_masterchef");
				}

				if(param_00.victim.explosiveinfo["suicideGrenadeKill"])
				{
					var_02 processchallenge("ch_miserylovescompany");
				}

				if(param_00.victim.explosiveinfo["throwbackKill"])
				{
					var_02 processchallenge("ch_hotpotato");
				}
			}
			else if(maps\mp\_utility::func_323E(param_00.sweapon,"semtex_"))
			{
				if(isdefined(param_00.modifiers["revenge"]))
				{
					var_02 processchallenge("ch_timeismoney");
				}
			}
			else if(maps\mp\_utility::func_323E(param_00.sweapon,"c4_"))
			{
				if(isdefined(param_00.modifiers["revenge"]))
				{
					var_02 processchallenge("ch_iamrich");
				}

				if(var_02.explosivekills[var_14] > 1)
				{
					var_02 processchallenge("ch_multic4");
				}

				if(param_00.victim.explosiveinfo["returnToSender"])
				{
					var_02 processchallenge("ch_returntosender");
				}

				if(param_00.victim.explosiveinfo["counterKill"])
				{
					var_02 processchallenge("ch_counterc4");
				}

				if(param_00.victim.explosiveinfo["bulletPenetrationKill"])
				{
					var_02 processchallenge("ch_howthe");
				}

				if(param_00.victim.explosiveinfo["chainKill"])
				{
					var_02 processchallenge("ch_dominos");
				}

				var_02 processchallenge("ch_c4shot");
			}
			else if(maps\mp\_utility::func_323E(param_00.sweapon,"claymore_"))
			{
				if(isdefined(param_00.modifiers["revenge"]))
				{
					var_02 processchallenge("ch_breakbank");
				}

				var_02 processchallenge("ch_claymoreshot");
				if(var_02.explosivekills[var_14] > 1)
				{
					var_02 processchallenge("ch_multiclaymore");
				}

				if(param_00.victim.explosiveinfo["returnToSender"])
				{
					var_02 processchallenge("ch_returntosender");
				}

				if(param_00.victim.explosiveinfo["counterKill"])
				{
					var_02 processchallenge("ch_counterclaymore");
				}

				if(param_00.victim.explosiveinfo["bulletPenetrationKill"])
				{
					var_02 processchallenge("ch_howthe");
				}

				if(param_00.victim.explosiveinfo["chainKill"])
				{
					var_02 processchallenge("ch_dominos");
				}
			}
			else if(maps\mp\_utility::func_323E(param_00.sweapon,"bouncingbetty_"))
			{
				var_02 processchallenge("ch_bouncingbetty");
			}
			else if(param_00.sweapon == "explodable_barrel")
			{
			}
			else if(param_00.sweapon == "destructible_car")
			{
				var_02 processchallenge("ch_carbomb");
			}
			else if(maps\mp\_utility::func_323E(param_00.sweapon,"rpg_") || maps\mp\_utility::func_323E(param_00.sweapon,"at4_") || maps\mp\_utility::func_323E(param_00.sweapon,"iw5_smaw_"))
			{
				if(var_02.explosivekills[var_14] > 1)
				{
					var_02 processchallenge("ch_multirpg");
				}
			}
		}
	}
	else if(issubstr(param_00.smeansofdeath,"MOD_MELEE") && !issubstr(param_00.sweapon,"riotshield_mp"))
	{
		var_02 func_3238();
		var_02 processchallenge("ch_knifevet");
		var_02.pers["meleeKillStreak"]++;
		if(var_02.pers["meleeKillStreak"] == 3)
		{
			var_02 processchallenge("ch_slasher");
		}

		if(var_02 isitemunlocked("specialty_quieter") && var_02 maps\mp\_utility::func_27AF("specialty_quieter"))
		{
			var_02 processchallenge("ch_deadsilence_pro");
		}

		var_19 = param_00.victim.anglesondeath[1];
		var_1A = var_02.anglesonkill[1];
		var_1B = angleclamp180(var_19 - var_1A);
		if(abs(var_1B) < 30)
		{
			var_02 processchallenge("ch_backstabber");
			if(isdefined(var_02.attackers))
			{
				foreach(var_1D in var_02.attackers)
				{
					if(var_1D != param_00.victim)
					{
						continue;
					}

					var_02 processchallenge("ch_neverforget");
					break;
				}
			}
		}

		if(!var_02 func_3271())
		{
			var_02 processchallenge("ch_survivor");
		}

		if(isdefined(var_02.infected))
		{
			param_00.victim processchallenge("ch_infected");
		}

		if(isdefined(param_00.victim.plague))
		{
			var_02 processchallenge("ch_plague");
		}

		var_13 = maps\mp\_utility::getbaseweaponname(param_00.sweapon);
		var_15 = maps\mp\_utility::getweaponattachments(param_00.sweapon);
		foreach(var_17 in var_15)
		{
			switch(var_17)
			{
				case "tactical":
						var_02 processchallenge("ch_" + var_13 + "_" + var_17);
						if(isdefined(level.challengeinfo["ch_marksman_" + var_13]))
						{
							var_02 processchallenge("ch_marksman_" + var_13);
						}

						if(isdefined(level.challengeinfo["pr_marksman_" + var_13]))
						{
							var_02 processchallenge("pr_marksman_" + var_13);
						}
						break;
			}
		}
	}
	else if(issubstr(param_00.smeansofdeath,"MOD_MELEE") && issubstr(param_00.sweapon,"riotshield_mp"))
	{
		var_02 func_3238();
		var_02 processchallenge("ch_shieldvet");
		var_02.pers["shieldKillStreak"]++;
		if(var_02.pers["shieldKillStreak"] == 3)
		{
			var_02 processchallenge("ch_smasher");
		}

		if(isdefined(var_02.finalkill))
		{
			var_02 processchallenge("ch_owned");
		}

		var_02 processchallenge("ch_riot_kill");
		var_19 = param_00.victim.anglesondeath[1];
		var_1A = var_02.anglesonkill[1];
		var_1B = angleclamp180(var_19 - var_1A);
		if(abs(var_1B) < 30)
		{
			var_02 processchallenge("ch_backsmasher");
		}

		if(!var_02 func_3271())
		{
			var_02 processchallenge("ch_survivor");
		}
	}
	else if(issubstr(param_00.smeansofdeath,"MOD_IMPACT"))
	{
		if(maps\mp\_utility::func_323E(param_00.sweapon,"frag_"))
		{
			var_02 processchallenge("ch_thinkfast");
		}
		else if(maps\mp\_utility::func_323E(param_00.sweapon,"concussion_"))
		{
			var_02 processchallenge("ch_thinkfastconcussion");
		}
		else if(maps\mp\_utility::func_323E(param_00.sweapon,"flash_"))
		{
			var_02 processchallenge("ch_thinkfastflash");
		}

		if(param_00.sweapon == "throwingknife_mp")
		{
			if(isdefined(param_00.modifiers["revenge"]))
			{
				var_02 processchallenge("ch_atm");
			}

			if(param_01 < var_02.flashendtime || param_01 < var_02.concussionendtime)
			{
				var_02 processchallenge("ch_didyouseethat");
			}

			if(isdefined(var_02.finalkill))
			{
				var_02 processchallenge("ch_unbelievable");
			}

			var_02 processchallenge("ch_carnie");
			if(isdefined(param_00.victim.attackerdata[var_02.guid].isprimary))
			{
				var_02 processchallenge("ch_its_personal");
			}

			if(var_02 isitemunlocked("specialty_fastoffhand") && var_02 maps\mp\_utility::func_27AF("specialty_fastoffhand"))
			{
				var_02 processchallenge("ch_fastoffhand");
			}
		}

		var_15 = maps\mp\_utility::getweaponattachments(param_00.sweapon);
		var_13 = maps\mp\_utility::getbaseweaponname(param_00.sweapon);
		foreach(var_17 in var_15)
		{
			switch(var_17)
			{
				case "gl":
				case "m320":
				case "gp25":
								if(maps\mp\_utility::func_323E(param_00.sweapon,"alt_"))
								{
									var_02 processchallenge("ch_" + var_13 + "_" + var_17);
									if(isdefined(level.challengeinfo["ch_marksman_" + var_13]))
									{
										var_02 processchallenge("ch_marksman_" + var_13);
									}

									if(isdefined(level.challengeinfo["pr_marksman_" + var_13]))
									{
										var_02 processchallenge("pr_marksman_" + var_13);
									}

									var_02 processchallenge("ch_ouch");
								}
								break;
			}
		}
	}
	else if(param_00.smeansofdeath == "MOD_HEAD_SHOT")
	{
		var_12 = maps\mp\_utility::getweaponclass(param_00.sweapon);
		func_324D(param_00,var_02,param_01,var_12);
		switch(var_12)
		{
			case "weapon_smg":
								var_02 processchallenge("ch_smg_kill");
								var_02 processchallenge("ch_expert_smg");
								break;

			case "weapon_assault":
								var_02 processchallenge("ch_ar_kill");
								var_02 processchallenge("ch_expert_assault");
								break;

			case "weapon_shotgun":
								var_02 processchallenge("ch_shotgun_kill");
								break;

			case "weapon_sniper":
								var_02 processchallenge("ch_sniper_kill");
								break;

			case "weapon_pistol":
								var_02 processchallenge("ch_handgun_kill");
								break;

			case "weapon_machine_pistol":
								var_02 processchallenge("ch_machine_pistols_kill");
								break;

			case "weapon_lmg":
								var_02 processchallenge("ch_lmg_kill");
								var_02 processchallenge("ch_expert_lmg");
								break;

			default:
				break;
		}

		if(isdefined(param_00.modifiers["revenge"]))
		{
			var_02 processchallenge("ch_colorofmoney");
		}

		if(maps\mp\_utility::func_2CC3(param_00.sweapon))
		{
			var_02 func_3236();
		}
		else if(maps\mp\_utility::func_323E(param_00.sweapon,"frag_"))
		{
			var_02 processchallenge("ch_thinkfast");
		}
		else if(maps\mp\_utility::func_323E(param_00.sweapon,"concussion_"))
		{
			var_02 processchallenge("ch_thinkfastconcussion");
		}
		else if(maps\mp\_utility::func_323E(param_00.sweapon,"flash_"))
		{
			var_02 processchallenge("ch_thinkfastflash");
		}
		else
		{
			var_13 = maps\mp\_utility::getbaseweaponname(param_00.sweapon);
			if(isdefined(level.challengeinfo["ch_expert_" + var_13]))
			{
				var_02 processchallenge("ch_expert_" + var_13);
			}

			if(isdefined(level.challengeinfo["pr_expert_" + var_13]))
			{
				var_02 processchallenge("pr_expert_" + var_13);
			}

			if(isdefined(level.challengeinfo["ch_marksman_" + var_13]))
			{
				var_02 processchallenge("ch_marksman_" + var_13);
			}

			if(isdefined(level.challengeinfo["pr_marksman_" + var_13]))
			{
				var_02 processchallenge("pr_marksman_" + var_13);
			}
		}
	}

	if((param_00.smeansofdeath == "MOD_PISTOL_BULLET" || param_00.smeansofdeath == "MOD_RIFLE_BULLET" || param_00.smeansofdeath == "MOD_HEAD_SHOT") && !maps\mp\_utility::func_2829(param_00.sweapon) && !maps\mp\_utility::func_2CC3(param_00.sweapon))
	{
		var_15 = maps\mp\_utility::getweaponattachments(param_00.sweapon);
		var_13 = maps\mp\_utility::getbaseweaponname(param_00.sweapon);
		foreach(var_17 in var_15)
		{
			switch(var_17)
			{
				case "acogsmg":
				case "acog":
					var_17 = "acog";
					if(var_02 playerads())
					{
						var_02 processchallenge("ch_" + var_13 + "_" + var_17);
					}
					break;

				case "akimbo":
					var_02 processchallenge("ch_" + var_13 + "_" + var_17);
					break;

				case "eotechlmg":
				case "eotechsmg":
				case "eotech":
					var_17 = "eotech";
					if(var_02 playerads())
					{
						var_02 processchallenge("ch_" + var_13 + "_" + var_17);
					}
					break;

				case "grip":
					var_02 processchallenge("ch_" + var_13 + "_" + var_17);
					break;

				case "heartbeat":
					var_02 processchallenge("ch_" + var_13 + "_" + var_17);
					break;

				case "hamrhybrid":
					if(var_02 playerads())
					{
						var_02 processchallenge("ch_" + var_13 + "_" + var_17);
					}
					break;

				case "hybrid":
					if(var_02 playerads())
					{
						var_02 processchallenge("ch_" + var_13 + "_" + var_17);
					}
					break;

				case "reflexlmg":
				case "reflexsmg":
				case "reflex":
					var_17 = "reflex";
					if(var_02 playerads())
					{
						var_02 processchallenge("ch_" + var_13 + "_" + var_17);
					}
					break;

				case "rof":
					var_02 processchallenge("ch_" + var_13 + "_" + var_17);
					break;

				case "shotgun":
					if(maps\mp\_utility::func_323E(param_00.sweapon,"alt_"))
					{
						var_02 processchallenge("ch_" + var_13 + "_" + var_17);
					}
					break;

				case "silencer01":
				case "silencer":
				case "silencer03":
				case "silencer02":
					var_02 processchallenge("ch_" + var_13 + "_" + var_17);
					break;

				case "thermalsmg":
				case "thermal":
					var_17 = "thermal";
					if(var_02 playerads())
					{
						var_02 processchallenge("ch_" + var_13 + "_" + var_17);
					}
					break;

				case "vzscope":
					if(var_02 playerads())
					{
						var_02 processchallenge("ch_" + var_13 + "_" + var_17);
					}
					break;

				case "xmags":
					var_02 processchallenge("ch_" + var_13 + "_" + var_17);
					break;

				default:
					break;
			}
		}

		if(var_02 isitemunlocked("specialty_autospot") && var_02 maps\mp\_utility::func_27AF("specialty_autospot") && var_02.holdingbreath && var_02 playerads())
		{
			var_02 processchallenge("ch_autospot_pro");
		}

		if(var_02 isitemunlocked("specialty_bulletaccuracy") && var_02 maps\mp\_utility::func_27AF("specialty_bulletaccuracy") && !var_02 playerads())
		{
			var_02 processchallenge("ch_bulletaccuracy_pro");
		}

		if(var_02 isitemunlocked("specialty_stalker") && var_02 maps\mp\_utility::func_27AF("specialty_stalker") && var_02 playerads())
		{
			var_02 processchallenge("ch_stalker_pro");
		}

		if(distancesquared(var_02.origin,param_00.victim.origin) < 65536)
		{
			if(var_02 isitemunlocked("specialty_quieter") && var_02 maps\mp\_utility::func_27AF("specialty_quieter"))
			{
				var_02 processchallenge("ch_deadsilence_pro");
			}
		}

		if(var_02 isitemunlocked("specialty_fastreload") && var_02 maps\mp\_utility::func_27AF("specialty_fastreload"))
		{
			var_02 processchallenge("ch_sleightofhand_pro");
		}

		if(var_02 maps\mp\_utility::func_3242("specialty_marksman",var_13) && var_02 maps\mp\_utility::func_822B("specialty_marksman",var_13) && var_02 maps\mp\_utility::func_27AF("specialty_marksman") && var_02 playerads())
		{
			var_02 processchallenge("ch_kickstop");
		}

		if(param_00.victim.idflagstime == param_01)
		{
			if(param_00.victim.idflags & level.idflags_penetration)
			{
				if(var_02 maps\mp\_utility::func_3242("specialty_bulletpenetration",var_13) && var_02 maps\mp\_utility::func_822B("specialty_bulletpenetration",var_13) && var_02 maps\mp\_utility::func_27AF("specialty_bulletpenetration"))
				{
					var_02 processchallenge("ch_xrayvision");
				}
			}
		}

		if(var_02 maps\mp\_utility::func_3242("specialty_bling",var_13) && var_02 maps\mp\_utility::func_822B("specialty_bling",var_13) && var_02 maps\mp\_utility::func_27AF("specialty_bling") && var_15.size > 1)
		{
			var_02 processchallenge("ch_blingbling");
		}

		if(var_02 maps\mp\_utility::func_3242("specialty_sharp_focus",var_13) && var_02 maps\mp\_utility::func_822B("specialty_sharp_focus",var_13) && var_02 maps\mp\_utility::func_27AF("specialty_sharp_focus") && var_02.health < var_02.maxhealth && isdefined(var_02.attackers))
		{
			foreach(var_1D in var_02.attackers)
			{
				if(var_1D == param_00.victim)
				{
					var_02 processchallenge("ch_unshakeable");
					break;
				}
			}
		}

		if(var_02 maps\mp\_utility::func_3242("specialty_holdbreathwhileads",var_13) && var_02 maps\mp\_utility::func_822B("specialty_holdbreathwhileads",var_13) && var_02 maps\mp\_utility::func_27AF("specialty_holdbreathwhileads") && var_02.holdingbreath && var_02 playerads())
		{
			var_02 processchallenge("ch_holditrightthere");
		}

		if(var_02 maps\mp\_utility::func_3242("specialty_reducedsway",var_13) && var_02 maps\mp\_utility::func_822B("specialty_reducedsway",var_13) && var_02 maps\mp\_utility::func_27AF("specialty_reducedsway") && var_02 playerads())
		{
			var_02 processchallenge("ch_swayless");
		}

		if(var_02 maps\mp\_utility::func_3242("specialty_longerrange",var_13) && var_02 maps\mp\_utility::func_822B("specialty_longerrange",var_13) && var_02 maps\mp\_utility::func_27AF("specialty_longerrange"))
		{
			var_02 processchallenge("ch_longishshot");
		}

		if(var_02 maps\mp\_utility::func_3242("specialty_lightweight",var_13) && var_02 maps\mp\_utility::func_822B("specialty_lightweight",var_13) && var_02 maps\mp\_utility::func_27AF("specialty_lightweight"))
		{
			var_02 processchallenge("ch_lightweight");
		}

		if(var_02 maps\mp\_utility::func_3242("specialty_moredamage",var_13) && var_02 maps\mp\_utility::func_822B("specialty_moredamage",var_13) && var_02 maps\mp\_utility::func_27AF("specialty_moredamage"))
		{
			var_02 processchallenge("ch_moredamage");
		}
	}

	if(param_00.smeansofdeath == "MOD_MELEE")
	{
		var_13 = maps\mp\_utility::getbaseweaponname(param_00.sweapon);
		if(var_02 maps\mp\_utility::func_3242("specialty_fastermelee",var_13) && var_02 maps\mp\_utility::func_822B("specialty_fastermelee",var_13) && var_02 maps\mp\_utility::func_27AF("specialty_fastermelee"))
		{
			var_02 processchallenge("ch_coldsteel");
		}
	}

	if(var_02 isitemunlocked("specialty_quickdraw") && var_02 maps\mp\_utility::func_27AF("specialty_quickdraw") && var_02.adstime > 0 && var_02.adstime < 3)
	{
		var_02 processchallenge("ch_quickdraw_pro");
	}

	if(var_02 isitemunlocked("specialty_coldblooded") && var_02 maps\mp\_utility::func_27AF("specialty_coldblooded"))
	{
		if(level.teambased)
		{
			var_27 = 0;
			foreach(var_29 in level.uavmodels[maps\mp\_utility::getotherteam(var_02.team)])
			{
				switch(var_29.uavtype)
				{
					case "counter":
					case "remote_mortar":
						break;
				}

				var_27 = 1;
				break;
			}

			if(var_27)
			{
				var_02 processchallenge("ch_coldblooded_pro");
			}
		}
		else
		{
			var_2B = 0;
			foreach(var_2D in level.players)
			{
				if(var_2D == var_02)
				{
					continue;
				}

				var_2B = var_2B + level.activeuavs[var_2D.guid];
			}

			if(var_2B > 0)
			{
				var_02 processchallenge("ch_coldblooded_pro");
			}
		}
	}

	if(var_02 isitemunlocked("specialty_empimmune") && var_02 maps\mp\_utility::func_27AF("specialty_empimmune"))
	{
		if(level.teambased)
		{
			var_2F = 0;
			foreach(var_31 in level.uavmodels[maps\mp\_utility::getotherteam(var_02.team)])
			{
				if(var_31.uavtype != "counter")
				{
					continue;
				}

				var_2F = 1;
				break;
			}

			if(var_2F || var_02 maps\mp\_utility::func_27E5())
			{
				var_02 processchallenge("ch_spygame");
			}
		}
		else if(var_02.isradarblocked || var_02 maps\mp\_utility::func_27E5())
		{
			var_02 processchallenge("ch_spygame");
		}
	}

	if(isdefined(param_00.victim.isplanting) && param_00.victim.isplanting)
	{
		var_02 processchallenge("ch_bombplanter");
	}

	if(isdefined(param_00.victim.isdefusing) && param_00.victim.isdefusing)
	{
		var_02 processchallenge("ch_bombdefender");
	}

	if(isdefined(param_00.victim.isbombcarrier) && param_00.victim.isbombcarrier && !isdefined(level.dd) || !level.dd)
	{
		var_02 processchallenge("ch_bombdown");
	}

	if(isdefined(param_00.victim.wasti) && param_00.victim.wasti)
	{
		var_02 processchallenge("ch_tacticaldeletion");
	}

	if(var_02 isitemunlocked("specialty_quickswap") && var_02 maps\mp\_utility::func_27AF("specialty_quickswap"))
	{
		if(isdefined(var_02.lastprimaryweaponswaptime) && gettime() - var_02.lastprimaryweaponswaptime < 3000)
		{
			var_02 processchallenge("ch_quickswap");
		}
	}

	if(var_02 isitemunlocked("specialty_extraammo") && var_02 maps\mp\_utility::func_27AF("specialty_extraammo"))
	{
		var_02 processchallenge("ch_extraammo");
	}

	if(isexplosivedamagemod(param_00.smeansofdeath))
	{
		switch(param_00.sweapon)
		{
			case "emp_grenade_mp":
			case "semtex_mp":
			case "concussion_grenade_mp":
			case "flash_grenade_mp":
			case "frag_grenade_mp":
				if(var_02 isitemunlocked("specialty_fastoffhand") && var_02 maps\mp\_utility::func_27AF("specialty_fastoffhand"))
				{
					var_02 processchallenge("ch_fastoffhand");
				}
				break;
		}
	}

	if(var_02 isitemunlocked("specialty_overkillpro") && var_02 maps\mp\_utility::func_27AF("specialty_overkillpro"))
	{
		if(var_02.secondaryweapon == param_00.sweapon)
		{
			var_15 = maps\mp\_utility::getweaponattachments(param_00.sweapon);
			if(var_15.size > 0)
			{
				var_02 processchallenge("ch_secondprimary");
			}
		}
	}

	if(var_02 isitemunlocked("specialty_stun_resistance") && var_02 maps\mp\_utility::func_27AF("specialty_stun_resistance"))
	{
		if(isdefined(var_02.lastflashedtime) && gettime() - var_02.lastflashedtime < 5000)
		{
			var_02 processchallenge("ch_stunresistance");
		}
		else if(isdefined(var_02.lastconcussedtime) && gettime() - var_02.lastconcussedtime < 5000)
		{
			var_02 processchallenge("ch_stunresistance");
		}
	}

	if(var_02 isitemunlocked("specialty_selectivehearing") && var_02 maps\mp\_utility::func_27AF("specialty_selectivehearing"))
	{
		var_02 processchallenge("ch_selectivehearing");
	}

	if(var_02 isitemunlocked("specialty_fastsprintrecovery") && var_02 maps\mp\_utility::func_27AF("specialty_fastsprintrecovery"))
	{
		if(isdefined(var_02.lastsprintendtime) && gettime() - var_02.lastsprintendtime < 3000)
		{
			var_02 processchallenge("ch_fastsprintrecovery");
		}
	}
}

//Function Number: 25
func_324D(param_00,param_01,param_02,param_03)
{
	if(!maps\mp\_utility::func_2CC3(param_00.sweapon))
	{
		param_01 func_3238();
	}

	if(maps\mp\_utility::func_2829(param_00.sweapon))
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

//Function Number: 26
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
			}
		}
	}
}

//Function Number: 27
func_3253(param_00)
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
			case "ctf":
			case "dom":
			case "koth":
			case "dm":
				break;

			default:
				break;
		}
	}
}

//Function Number: 28
playerdamaged(param_00,param_01,param_02,param_03,param_04,param_05)
{
	self endon("disconnect");
	if(isdefined(param_01))
	{
		param_01 endon("disconnect");
	}

	wait 0.05;
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

	domissioncallback("playerDamaged",var_06);
}

//Function Number: 29
func_2CE6(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
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

	func_3255(var_08);
	if(isdefined(param_01) && maps\mp\_utility::isreallyalive(param_01))
	{
		param_01.killsthislife[param_01.killsthislife.size] = var_08;
	}

	var_08.attacker notify("playerKilledChallengesProcessed");
}

//Function Number: 30
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
	if(isdefined(param_03) && isplayer(param_03) && !isdefined(param_00) || param_03 != param_00 && !maps\mp\_utility::func_2829(param_06))
	{
		param_03 maps\mp\killstreaks\_killstreaks::giveadrenaline("vehicleDestroyed");
		switch(param_06)
		{
			case "stinger_mp":
				if(isdefined(param_01.helitype) && param_01.helitype == "flares" || param_01.helitype == "littlebird" || param_01.helitype == "helicopter" || param_01.helitype == "airdrop")
				{
					param_03 processchallenge("pr_expert_stinger");
				}
	
				param_03 processchallenge("ch_marksman_stinger");
				param_03 processchallenge("pr_marksman_stinger");
				break;

			default:
				var_08 = maps\mp\_utility::getbaseweaponname(param_06);
				if(isdefined(level.challengeinfo["ch_marksman_" + var_08]))
				{
					param_03 processchallenge("ch_marksman_" + var_08);
				}
	
				if(isdefined(level.challengeinfo["pr_marksman_" + var_08]))
				{
					param_03 processchallenge("pr_marksman_" + var_08);
				}
				break;
		}

		switch(param_06)
		{
			case "javelin_mp":
			case "iw5_smaw_mp":
			case "stinger_mp":
				if(param_03 isitemunlocked("specialty_fasterlockon") && param_03 maps\mp\_utility::func_27AF("specialty_fasterlockon"))
				{
					param_03 processchallenge("ch_fasterlockon");
				}
				break;
		}

		if(param_03 isitemunlocked("specialty_blindeye") && param_03 maps\mp\_utility::func_27AF("specialty_blindeye"))
		{
			var_09 = 1;
			if(isdefined(param_03.scramproxyperk) && param_03.scramproxyperk)
			{
				var_09 = 0;
			}

			if(isdefined(param_03.spawnperk) && param_03.spawnperk)
			{
				var_09 = 0;
			}

			if(var_09)
			{
				param_03 processchallenge("ch_blindeye_pro");
				return;
			}
		}
	}
}

//Function Number: 31
func_3255(param_00)
{
	if(isdefined(param_00.attacker))
	{
		param_00.attacker endon("disconnect");
	}

	self.processingkilledchallenges = 1;
	wait 0.05;
	maps\mp\_utility::waittillslowprocessallowed();
	domissioncallback("playerKilled",param_00);
	self.processingkilledchallenges = undefined;
}

//Function Number: 32
func_26FF()
{
	var_00 = spawnstruct();
	var_00.player = self;
	domissioncallback("playerAssist",var_00);
}

//Function Number: 33
usehardpoint(param_00)
{
	self endon("disconnect");
	wait 0.05;
	maps\mp\_utility::waittillslowprocessallowed();
	var_01 = spawnstruct();
	var_01.player = self;
	var_01.hardpointtype = param_00;
	domissioncallback("playerHardpoint",var_01);
}

//Function Number: 34
roundbegin()
{
	domissioncallback("roundBegin");
}

//Function Number: 35
func_2F4B(param_00)
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

//Function Number: 36
domissioncallback(param_00,param_01)
{
	if(!func_3223())
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

//Function Number: 37
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
		thread func_325B();
		monitorsinglesprintdistance();
		if(self isitemunlocked("specialty_longersprint") && maps\mp\_utility::func_27AF("specialty_longersprint"))
		{
			processchallenge("ch_longersprint_pro",int(self.sprintdistthissprint / 12));
		}
	}
}

//Function Number: 38
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
		wait 0.1;
		self.sprintdistthissprint = self.sprintdistthissprint + distance(self.origin,var_00);
		var_00 = self.origin;
	}
}

//Function Number: 39
func_325B()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	var_00 = gettime();
	self waittill("sprint_end");
	var_01 = int(gettime() - var_00);
	maps\mp\_utility::incplayerstat("sprinttime",var_01);
	self.lastsprintendtime = gettime();
}

//Function Number: 40
func_325C()
{
	self endon("disconnect");
	self.pers["midairStreak"] = 0;
	for(;;)
	{
		if(!isalive(self))
		{
			self waittill("spawned_player");
			continue;
		}

		if(!self isonground())
		{
			self.pers["midairStreak"] = 0;
			var_00 = self.origin[2];
			while(!self isonground() && isalive(self))
			{
				if(self.origin[2] > var_00)
				{
					var_00 = self.origin[2];
				}

				wait 0.05;
			}

			self.pers["midairStreak"] = 0;
			var_01 = var_00 - self.origin[2];
			if(var_01 < 0)
			{
				var_01 = 0;
			}

			if(var_01 / 12 > 15 && isalive(self))
			{
				processchallenge("ch_basejump");
			}

			if(var_01 / 12 > 30 && !isalive(self))
			{
				processchallenge("ch_goodbye");
			}
		}

		wait 0.05;
	}
}

//Function Number: 41
func_325D()
{
	if(!func_3223())
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

//Function Number: 42
func_325E()
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

//Function Number: 43
func_325F()
{
	for(;;)
	{
		self waittill("spawned_player");
		thread survivalistchallenge();
	}
}

//Function Number: 44
survivalistchallenge()
{
	self endon("death");
	self endon("disconnect");
	wait 300;
	if(isdefined(self))
	{
		processchallenge("ch_survivalist");
	}
}

//Function Number: 45
monitorstreaks()
{
	self endon("disconnect");
	self.pers["airstrikeStreak"] = 0;
	self.pers["meleeKillStreak"] = 0;
	self.pers["shieldKillStreak"] = 0;
	thread func_3262();
	for(;;)
	{
		self waittill("death");
		self.pers["airstrikeStreak"] = 0;
		self.pers["meleeKillStreak"] = 0;
		self.pers["shieldKillStreak"] = 0;
	}
}

//Function Number: 46
func_3262()
{
	thread monitormiscsingle("destroyed_explosive");
	thread monitormiscsingle("begin_airstrike");
	thread monitormiscsingle("destroyed_car");
	thread monitormiscsingle("destroyed_helicopter");
	thread monitormiscsingle("used_uav");
	thread monitormiscsingle("used_double_uav");
	thread monitormiscsingle("used_triple_uav");
	thread monitormiscsingle("used_counter_uav");
	thread monitormiscsingle("used_directional_uav");
	thread monitormiscsingle("used_airdrop");
	thread monitormiscsingle("used_emp");
	thread monitormiscsingle("used_nuke");
	thread monitormiscsingle("crushed_enemy");
	self waittill("disconnect");
	self notify("destroyed_explosive");
	self notify("begin_airstrike");
	self notify("destroyed_car");
	self notify("destroyed_helicopter");
}

//Function Number: 47
monitormiscsingle(param_00)
{
	for(;;)
	{
		self waittill(param_00);
		if(!isdefined(self))
		{
			return;
		}

		monitormisccallback(param_00);
	}
}

//Function Number: 48
monitormisccallback(param_00)
{
	switch(param_00)
	{
		case "begin_airstrike":
			self.pers["airstrikeStreak"] = 0;
			break;

		case "destroyed_explosive":
			if(self isitemunlocked("specialty_detectexplosive") && maps\mp\_utility::func_27AF("specialty_detectexplosive"))
			{
				processchallenge("ch_detectexplosives_pro");
			}
	
			processchallenge("ch_backdraft");
			break;

		case "destroyed_helicopter":
			processchallenge("ch_flyswatter");
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

//Function Number: 49
func_2D61()
{
	if(!isalive(self))
	{
		return;
	}

	if(!func_3223())
	{
		return;
	}

	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	thread resetbrinkofdeathkillstreakshortly();
	self notify("healed");
	if(isdefined(self.lastdamagewasfromenemy) && self.lastdamagewasfromenemy)
	{
		self.healthregenerationstreak++;
		if(self.healthregenerationstreak >= 5)
		{
			processchallenge("ch_invincible");
		}
	}
}

//Function Number: 50
resetbrinkofdeathkillstreakshortly()
{
	self endon("disconnect");
	self endon("death");
	self endon("damage");
	wait 1;
	self.brinkofdeathkillstreak = 0;
}

//Function Number: 51
playerspawned()
{
	self.brinkofdeathkillstreak = 0;
	self.healthregenerationstreak = 0;
	self.pers["MGStreak"] = 0;
}

//Function Number: 52
playerdied()
{
	self.brinkofdeathkillstreak = 0;
	self.healthregenerationstreak = 0;
	self.pers["MGStreak"] = 0;
}

//Function Number: 53
func_3268()
{
	var_00 = self.health / self.maxhealth;
	return var_00 <= level.healthoverlaycutoff;
}

//Function Number: 54
processchallenge(param_00,param_01,param_02)
{
	if(!func_3223())
	{
		return;
	}

	if(level.players.size < 2)
	{
		return;
	}

	if(!maps\mp\_utility::rankingenabled())
	{
		return;
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	if(!issubstr(param_00,"_daily") && !issubstr(param_00,"_weekly") && self isitemunlocked("tier_90"))
	{
		thread processchallenge(param_00 + "_daily",param_01,param_02);
		thread processchallenge(param_00 + "_weekly",param_01,param_02);
	}

	var_03 = getchallengestatus(param_00);
	if(var_03 == 0)
	{
		return;
	}

	if(var_03 > level.challengeinfo[param_00]["targetval"].size)
	{
		return;
	}

	var_04 = maps\mp\gametypes\_hud_util::ch_getprogress(param_00);
	if(isdefined(param_02) && param_02)
	{
		var_05 = param_01;
	}
	else
	{
		var_05 = var_05 + param_02;
	}

	var_06 = level.challengeinfo[param_00]["targetval"][var_03];
	if(var_05 >= var_06)
	{
		var_07 = 1;
		var_05 = var_06;
	}
	else
	{
		var_07 = 0;
	}

	if(var_04 < var_05)
	{
		maps\mp\gametypes\_hud_util::ch_setprogress(param_00,var_05);
	}

	if(var_07)
	{
		thread giverankxpafterwait(param_00,var_03);
		maps\mp\_matchdata::func_28E0(param_00,var_03);
		if(!isdefined(self.challengescompleted))
		{
			self.challengescompleted = [];
		}

		var_08 = 0;
		foreach(var_0A in self.challengescompleted)
		{
			if(var_0A == param_00)
			{
				var_08 = 1;
			}
		}

		if(!var_08)
		{
			self.challengescompleted[self.challengescompleted.size] = param_00;
		}

		var_03++;
		maps\mp\gametypes\_hud_util::ch_setstate(param_00,var_03);
		self.challengedata[param_00] = var_03;
		thread maps\mp\gametypes\_hud_message::challengesplashnotify(param_00);
	}
}

//Function Number: 55
giverankxpafterwait(param_00,param_01)
{
	self endon("disconnect");
	wait 0.25;
	maps\mp\gametypes\_rank::func_2AB3("challenge",level.challengeinfo[param_00]["reward"][param_01],undefined,undefined,param_00);
}

//Function Number: 56
func_3269(param_00,param_01)
{
	return tablelookup("mp/unlockTable.csv",0,param_00,4 + param_01);
}

//Function Number: 57
getweaponattachment(param_00,param_01)
{
	return tablelookup("mp/statsTable.csv",4,param_00,11 + param_01);
}

//Function Number: 58
func_326B(param_00)
{
	if(tablelookup("mp/allChallengesTable.csv",0,"ch_" + param_00 + "_mastery",1) == "")
	{
		return;
	}

	var_01 = 0;
	for(var_02 = 0;var_02 <= 10;var_02++)
	{
		var_03 = getweaponattachment(param_00,var_02);
		if(var_03 == "")
		{
			continue;
		}

		if(maps\mp\gametypes\_class::isattachmentunlocked(param_00,var_03))
		{
			var_01++;
		}
	}

	processchallenge("ch_" + param_00 + "_mastery",var_01,1);
}

//Function Number: 59
updatechallenges()
{
	self.challengedata = [];
	self endon("disconnect");
	if(!func_3223())
	{
		return;
	}

	if(!self isitemunlocked("challenges"))
	{
		return;
	}

	var_00 = 0;
	foreach(var_0D, var_02 in level.challengeinfo)
	{
		var_00++;
		if(var_00 % 40 == 0)
		{
			wait 0.05;
		}

		self.challengedata[var_0D] = 0;
		if(isweaponchallenge(var_0D))
		{
			if(!self isitemunlocked(var_0D))
			{
				continue;
			}

			var_03 = func_8105(var_0D);
			if(!self isitemunlocked(var_03))
			{
				continue;
			}

			var_04 = func_8106(var_0D);
			if(isdefined(var_04))
			{
				if(!maps\mp\gametypes\_class::isattachmentunlocked(var_03,var_04))
				{
					continue;
				}
			}
		}
		else if(func_8107(var_0D))
		{
			if(!self isitemunlocked(var_0D))
			{
				continue;
			}

			var_05 = func_8108(var_0D);
			if(isdefined(var_05))
			{
				if(!self getplayerdata("killstreakUnlocked",var_05))
				{
					continue;
				}
			}
		}
		else
		{
			var_06 = self isitemunlocked(var_0D);
			if(var_06 == 0)
			{
				continue;
			}
			else if(var_06 == 2)
			{
				var_07 = func_8102(var_0D);
				if(var_07 != "")
				{
					var_08 = func_8103(var_07);
					if(var_08 != "")
					{
						var_09 = func_8104(var_08,var_0D);
						if(var_09 != "")
						{
							if(!self isitemunlocked(var_09))
							{
								continue;
							}
						}
					}
				}
			}
		}

		if(isdefined(var_02["requirement"]) && !self isitemunlocked(var_02["requirement"]))
		{
			continue;
		}

		if(var_02["type"] == 1)
		{
			var_0A = maps\mp\gametypes\_hud_util::getdailyref(var_0D);
			if(var_0A == "")
			{
				continue;
			}
		}
		else if(var_02["type"] == 2)
		{
			var_0B = maps\mp\gametypes\_hud_util::func_26C9(var_0D);
			if(var_0B == "")
			{
				continue;
			}
		}

		var_0C = maps\mp\gametypes\_hud_util::ch_getstate(var_0D);
		if(var_0C == 0)
		{
			maps\mp\gametypes\_hud_util::ch_setstate(var_0D,1);
			var_0C = 1;
		}

		self.challengedata[var_0D] = var_0C;
	}
}

//Function Number: 60
func_8101(param_00)
{
	return tablelookup("mp/unlockTable.csv",0,param_00,0) != "";
}

//Function Number: 61
func_8102(param_00)
{
	return tablelookup("mp/allChallengesTable.csv",0,param_00,5);
}

//Function Number: 62
func_8103(param_00)
{
	return tablelookup("mp/challengeTable.csv",8,param_00,4);
}

//Function Number: 63
func_8104(param_00,param_01)
{
	return tablelookup(param_00,0,param_01,1);
}

//Function Number: 64
isweaponchallenge(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = func_8102(param_00);
	if(isdefined(var_01) && var_01 == "riotshield")
	{
		return 1;
	}

	var_02 = strtok(param_00,"_");
	for(var_03 = 0;var_03 < var_02.size;var_03++)
	{
		var_04 = var_02[var_03];
		if(var_04 == "iw5")
		{
			var_04 = var_02[var_03] + "_" + var_02[var_03 + 1];
		}

		if(maps\mp\gametypes\_class::func_32A0(var_04,0) || maps\mp\gametypes\_class::func_32A1(var_04,"specialty_null","specialty_null",0))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 65
func_8105(param_00)
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
	var_03 = strtok(var_02,"_");
	var_02 = undefined;
	if(var_03[0] == "iw5")
	{
		var_02 = var_03[0] + "_" + var_03[1];
	}
	else
	{
		var_02 = var_03[0];
	}

	return var_02;
}

//Function Number: 66
func_8106(param_00)
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
	var_03 = strtok(var_02,"_");
	var_04 = undefined;
	if(isdefined(var_03[2]) && maps\mp\_utility::isattachment(var_03[2]))
	{
		var_04 = var_03[2];
	}

	return var_04;
}

//Function Number: 67
func_8107(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = func_8102(param_00);
	if(isdefined(var_01) && var_01 == "killstreaks_assault" || var_01 == "killstreaks_support")
	{
		return 1;
	}

	return 0;
}

//Function Number: 68
func_8108(param_00)
{
	var_01 = "ch_";
	var_02 = getsubstr(param_00,var_01.size,param_00.size);
	if(var_02 == "assault_streaks" || var_02 == "support_streaks")
	{
		var_02 = undefined;
	}

	return var_02;
}

//Function Number: 69
challenge_targetval(param_00,param_01,param_02)
{
	var_03 = tablelookup(param_00,0,param_01,6 + param_02 - 1 * 2);
	return int(var_03);
}

//Function Number: 70
challenge_rewardval(param_00,param_01,param_02)
{
	var_03 = tablelookup(param_00,0,param_01,7 + param_02 - 1 * 2);
	return int(var_03);
}

//Function Number: 71
func_0E7B(param_00,param_01)
{
	var_02 = 0;
	var_03 = 0;
	var_04 = tablelookupbyrow(param_00,0,0);
	for(var_02 = 1;var_04 != "";var_02++)
	{
		level.challengeinfo[var_04] = [];
		level.challengeinfo[var_04]["type"] = param_01;
		level.challengeinfo[var_04]["targetval"] = [];
		level.challengeinfo[var_04]["reward"] = [];
		for(var_05 = 1;var_05 < 11;var_05++)
		{
			var_06 = challenge_targetval(param_00,var_04,var_05);
			var_07 = challenge_rewardval(param_00,var_04,var_05);
			if(var_06 == 0)
			{
				break;
			}

			level.challengeinfo[var_04]["targetval"][var_05] = var_06;
			level.challengeinfo[var_04]["reward"][var_05] = var_07;
			var_03 = var_03 + var_07;
		}

		var_04 = tablelookupbyrow(param_00,var_02,0);
	}

	return int(var_03);
}

//Function Number: 72
buildchallegeinfo()
{
	level.challengeinfo = [];
	var_00 = 0;
	var_00 = var_00 + func_0E7B("mp/allChallengesTable.csv",0);
	var_00 = var_00 + func_0E7B("mp/dailychallengesTable.csv",1);
	var_00 = var_00 + func_0E7B("mp/weeklychallengesTable.csv",2);
	var_01 = tablelookupbyrow("mp/challengeTable.csv",0,4);
	for(var_02 = 1;var_01 != "";var_02++)
	{
		var_03 = tablelookupbyrow(var_01,0,0);
		for(var_04 = 1;var_03 != "";var_04++)
		{
			var_05 = tablelookup(var_01,0,var_03,1);
			if(var_05 != "")
			{
				level.challengeinfo[var_03]["requirement"] = var_05;
			}

			var_03 = tablelookupbyrow(var_01,var_04,0);
		}

		var_01 = tablelookupbyrow("mp/challengeTable.csv",var_02,4);
	}
}

//Function Number: 73
monitorprocesschallenge()
{
	self endon("disconnect");
	level endon("game_end");
	for(;;)
	{
		if(!func_3223())
		{
			return;
		}

		self waittill("process",var_00);
		processchallenge(var_00);
	}
}

//Function Number: 74
func_326F()
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

		switch(var_00)
		{
			case 3:
				maps\mp\killstreaks\_killstreaks::giveadrenaline("3streak");
				break;
	
			case 4:
				maps\mp\killstreaks\_killstreaks::giveadrenaline("4streak");
				break;
	
			case 5:
				maps\mp\killstreaks\_killstreaks::giveadrenaline("5streak");
				break;
	
			case 6:
				maps\mp\killstreaks\_killstreaks::giveadrenaline("6streak");
				break;
	
			case 7:
				maps\mp\killstreaks\_killstreaks::giveadrenaline("7streak");
				break;
	
			case 8:
				maps\mp\killstreaks\_killstreaks::giveadrenaline("8streak");
				break;
	
			case 9:
				maps\mp\killstreaks\_killstreaks::giveadrenaline("9streak");
				break;
	
			case 10:
				maps\mp\killstreaks\_killstreaks::giveadrenaline("10streak");
				break;
	
			default:
				break;
		}

		if(var_00 == 10 && self.killstreaks.size == 0)
		{
			processchallenge("ch_theloner");
			continue;
		}

		if(var_00 == 9)
		{
			if(isdefined(self.killstreaks[7]) && isdefined(self.killstreaks[8]) && isdefined(self.killstreaks[9]))
			{
				processchallenge("ch_6fears7");
			}
		}
	}
}

//Function Number: 75
func_3270()
{
	self endon("disconnect");
	level endon("game_end");
	for(;;)
	{
		self waittill("destroyed_killstreak",var_00);
		if(self isitemunlocked("specialty_blindeye") && maps\mp\_utility::func_27AF("specialty_blindeye"))
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

//Function Number: 76
genericchallenge(param_00,param_01)
{
	switch(param_00)
	{
		case "hijacker_airdrop":
			processchallenge("ch_smoothcriminal");
			break;

		case "hijacker_airdrop_mega":
			processchallenge("ch_poolshark");
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

//Function Number: 77
func_3271()
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

//Function Number: 78
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

		wait 0.05;
	}
}

//Function Number: 79
func_3273()
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

//Function Number: 80
func_3274()
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
			if(self isitemunlocked("specialty_fastmantle") && maps\mp\_utility::func_27AF("specialty_fastmantle"))
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

//Function Number: 81
func_3276()
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

		if(maps\mp\_utility::func_2829(var_01) || maps\mp\_utility::isdeathstreakweapon(var_01))
		{
			continue;
		}

		if(var_01 == "briefcase_bomb_mp" || var_01 == "briefcase_bomb_defuse_mp")
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

//Function Number: 82
monitorflashbang()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("flashbang",var_00,var_01,var_02,var_03);
		if(self == var_03)
		{
			continue;
		}

		self.lastflashedtime = gettime();
	}
}

//Function Number: 83
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

//Function Number: 84
func_3279()
{
	self endon("disconnect");
	for(;;)
	{
		common_scripts\utility::waittill_any("triggered_mine","triggered_claymore","triggered_ims");
		thread waitdelayminetime();
	}
}

//Function Number: 85
waitdelayminetime()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait level.delayminetime + 2;
	processchallenge("ch_delaymine");
}