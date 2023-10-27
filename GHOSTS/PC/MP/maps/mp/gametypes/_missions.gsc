/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_missions.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 128
 * Decompile Time: 2551 ms
 * Timestamp: 10/27/2023 1:18:48 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	precachestring(&"MP_CHALLENGE_COMPLETED");
	if(!func_5126())
	{
		return;
	}

	level.missioncallbacks = [];
	func_646E("playerKilled",::func_1AA4);
	func_646E("playerKilled",::ch_killstreak_kills);
	func_646E("playerHardpoint",::func_1AA2);
	func_646E("playerAssist",::ch_assists);
	func_646E("roundEnd",::ch_roundwin);
	func_646E("roundEnd",::ch_roundplayed);
	func_646E("vehicleKilled",::ch_vehicle_killed);
	level thread func_595D();
}

//Function Number: 2
func_5126()
{
	if(issquadsmode())
	{
		return 0;
	}

	return level.rankedmatch;
}

//Function Number: 3
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(!isdefined(var_00.pers["postGameChallenges"]))
		{
			var_00.pers["postGameChallenges"] = 0;
		}

		var_00 thread func_4635();
		if(isai(var_00))
		{
			continue;
		}

		var_00 thread onplayerspawned();
		var_00 thread func_5374();
		var_00 thread func_5387();
		var_00 thread monitorlivetime();
		var_00 thread func_53CA();
		var_00 thread func_53C9();
		var_00 thread func_53BC();
		var_00 thread func_5373();
		var_00 thread monitorprocesschallenge();
		var_00 thread func_539F();
		var_00 thread func_539D();
		var_00 thread func_536D();
		var_00 thread func_53DA();
		var_00 thread func_538D();
		var_00 thread monitorconcussion();
		var_00 thread monitorreload();
		var_00 thread monitorsprintslide();
		var_00 notifyonplayercommand("hold_breath","+breath_sprint");
		var_00 notifyonplayercommand("hold_breath","+melee_breath");
		var_00 notifyonplayercommand("release_breath","-breath_sprint");
		var_00 notifyonplayercommand("release_breath","-melee_breath");
		var_00 thread func_539B();
		var_00 notifyonplayercommand("jumped","+goStand");
		var_00 thread func_53A7();
		if(isdefined(level.patientzeroname) && issubstr(var_00.name,level.patientzeroname))
		{
			var_00 setrankedplayerdata("challengeState","ch_infected",2);
			var_00 setrankedplayerdata("challengeProgress","ch_infected",1);
			var_00 setrankedplayerdata("challengeState","ch_plague",2);
			var_00 setrankedplayerdata("challengeProgress","ch_plague",1);
		}

		var_00 setcommonplayerdata("round","weaponsUsed",0,"none");
		var_00 setcommonplayerdata("round","weaponsUsed",1,"none");
		var_00 setcommonplayerdata("round","weaponsUsed",2,"none");
		var_00 setcommonplayerdata("round","weaponXpEarned",0,0);
		var_00 setcommonplayerdata("round","weaponXpEarned",1,0);
		var_00 setcommonplayerdata("round","weaponXpEarned",2,0);
		var_01 = var_00 getcommonplayerdata("cardTitle");
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

//Function Number: 4
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		self.killsthismag = [];
		thread func_53C4();
	}
}

//Function Number: 5
func_53BC()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("scavenger_pickup");
		if(self isitemunlocked("specialty_scavenger") && maps\mp\_utility::_hasperk("specialty_scavenger") && !maps\mp\_utility::isjuggernaut())
		{
			func_61CE("ch_scavenger_pro");
		}

		wait(0.05);
	}
}

//Function Number: 6
func_53C9()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("received_earned_killstreak");
		if(self isitemunlocked("specialty_hardline") && maps\mp\_utility::_hasperk("specialty_hardline"))
		{
			func_61CE("ch_hardline_pro");
		}

		wait(0.05);
	}
}

//Function Number: 7
func_5373()
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
			func_61CE("ch_blastshield_pro");
		}

		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 8
func_53D0()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("destroyed_insertion",var_00);
		if(self == var_00)
		{
		}

		func_61CE("ch_darkbringer");
		maps\mp\_utility::func_447B("mosttacprevented",1);
		thread maps\mp\gametypes\_hud_message::func_794C("denied",20);
		var_00 maps\mp\gametypes\_hud_message::func_5F9A("destroyed_insertion",self);
		common_scripts\utility::func_8AFE();
	}
}

//Function Number: 9
func_4635()
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

//Function Number: 10
func_646E(param_00,param_01)
{
	if(!isdefined(level.missioncallbacks[param_00]))
	{
		level.missioncallbacks[param_00] = [];
	}

	level.missioncallbacks[param_00][level.missioncallbacks[param_00].size] = param_01;
}

//Function Number: 11
getchallengestatus(param_00)
{
	if(isdefined(self.challengedata[param_00]))
	{
		return self.challengedata[param_00];
	}

	return 0;
}

//Function Number: 12
ch_assists(param_00)
{
	var_01 = param_00.player;
	var_01 func_61CE("ch_assists");
	if(isdefined(var_01.isjuggernautrecon) && var_01.isjuggernautrecon)
	{
		var_01 func_61CE("ch_assisted_firepower");
	}

	if(isdefined(param_00.sweapon))
	{
		var_02 = maps\mp\_utility::getweaponclass(param_00.sweapon);
		var_03 = maps\mp\_utility::func_3A37(param_00.sweapon);
		switch(var_02)
		{
			case "weapon_lmg":
			case "weapon_dmr":
			case "weapon_assault":
			case "weapon_smg":
				func_61CE("ch_" + var_03 + "_assists");
				break;

			case "weapon_shotgun":
				func_61CE("ch_" + var_03 + "_assist");
				break;

			default:
				if(maps\mp\gametypes\_weapons::func_494E(param_00.sweapon))
				{
					func_61CE("ch_iw6_riotshield_assist");
				}
				break;
		}
	}
}

//Function Number: 13
func_1AA2(param_00)
{
	var_01 = param_00.player;
	var_01.pers[param_00.hardpointtype]++;
	switch(param_00.hardpointtype)
	{
		case "uplink":
			var_01 func_61CE("ch_uplink");
			var_01 func_61CE("ch_assault_streaks");
			if(var_01 checknumusesofpersistentdata("uplink",3))
			{
				var_01 func_61CE("ch_nosecrets");
			}
			break;

		case "guard_dog":
			var_01 func_61CE("ch_guard_dog");
			var_01 func_61CE("ch_assault_streaks");
			break;

		case "airdrop_juggernaut_maniac":
			var_01 func_61CE("ch_airdrop_juggernaut_maniac");
			var_01 func_61CE("ch_assault_streaks");
			break;

		case "ims":
			var_01 func_61CE("ch_assault_streaks");
			break;

		case "helicopter":
			var_01 func_61CE("ch_assault_streaks");
			if(var_01 checknumusesofpersistentdata("helicopter",2))
			{
				var_01 func_61CE("ch_airsuperiority");
			}
			break;

		case "airdrop_juggernaut":
		case "ball_drone_backup":
		case "odin_assault":
		case "drone_hive":
		case "heli_pilot":
		case "vanguard":
		case "sentry":
			var_01 func_61CE("ch_assault_streaks");
			break;

		case "uplink_support":
			var_01 func_61CE("ch_uplink_support");
			var_01 func_61CE("ch_support_streaks");
			break;

		case "deployable_vest":
			var_01 func_61CE("ch_deployable_vest");
			var_01 func_61CE("ch_support_streaks");
			break;

		case "deployable_ammo":
			var_01 func_61CE("ch_deployable_ammo");
			var_01 func_61CE("ch_support_streaks");
			break;

		case "ball_drone_radar":
			var_01 func_61CE("ch_ball_drone_radar");
			var_01 func_61CE("ch_support_streaks");
			break;

		case "aa_launcher":
			var_01 func_61CE("ch_support_streaks");
			break;

		case "jammer":
			var_01 func_61CE("ch_jammer");
			var_01 func_61CE("ch_support_streaks");
			break;

		case "air_superiority":
			var_01 func_61CE("ch_support_streaks");
			break;

		case "recon_agent":
			var_01 func_61CE("ch_recon_agent");
			var_01 func_61CE("ch_support_streaks");
			break;

		case "heli_sniper":
			var_01 func_61CE("ch_heli_sniper");
			var_01 func_61CE("ch_support_streaks");
			break;

		case "uav_3dping":
			var_01 func_61CE("ch_uav_3dping");
			var_01 func_61CE("ch_support_streaks");
			break;

		case "airdrop_juggernaut_recon":
			var_01 func_61CE("ch_support_streaks");
			break;

		case "odin_support":
			var_01 func_61CE("ch_odin_support");
			var_01 func_61CE("ch_support_streaks");
			break;

		case "all_perks_bonus":
			var_01 func_61CE("ch_all_perks_bonus");
			break;

		case "nuke":
			var_01 func_61CE("ch_nuke");
			break;
	}
}

//Function Number: 14
ch_killstreak_kills(param_00)
{
	if(!isdefined(param_00.attacker) || !isplayer(param_00.attacker))
	{
	}

	if(!maps\mp\_utility::func_48F7(param_00.sweapon))
	{
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
		case "sentry_minigun_mp":
			var_01 func_61CE("ch_looknohands");
			break;

		case "remote_tank_projectile_mp":
			var_01 func_61CE("ch_incoming");
			break;

		case "heli_pilot_turret_mp":
			var_01 func_61CE("ch_helo_pilot");
			break;

		case "iw6_gm6helisnipe_mp_gm6scope":
			var_01 func_61CE("ch_long_distance_shooter");
			break;

		case "switch_blade_child_mp":
		case "drone_hive_projectile_mp":
			var_01 func_61CE("ch_clusterfunk");
			var_02 = var_01.killsthislifeperweapon["drone_hive_projectile_mp"] + var_01.killsthislifeperweapon["switch_blade_child_mp"];
			if(isnumbermultipleof(var_02,4))
			{
				var_01 func_61CE("ch_bullseye");
			}
			break;

		case "ball_drone_gun_mp":
			var_01 func_61CE("ch_vulture");
			break;

		case "odin_projectile_small_rod_mp":
		case "odin_projectile_large_rod_mp":
			var_01 func_61CE("ch_overlord");
			break;

		case "hind_missile_mp":
		case "hind_bomb_mp":
		case "cobra_20mm_mp":
			var_01 func_61CE("ch_choppervet");
			break;

		case "guard_dog_mp":
			var_01 func_61CE("ch_downboy");
			break;

		case "ims_projectile_mp":
			var_01 func_61CE("ch_outsmarted");
			break;

		case "iw6_p226jugg_mp":
		case "iw6_minigunjugg_mp":
		case "mortar_shelljugg_mp":
			var_01 func_61CE("ch_painless");
			break;

		case "nuke_mp":
			param_00.victim func_61CE("ch_radiationsickness");
			break;

		case "iw6_knifeonlyjugg_mp":
		case "throwingknifejugg_mp":
			break;

		case "agent_support_mp":
			break;

		default:
			break;
	}
}

//Function Number: 15
ch_vehicle_killed(param_00)
{
	if(!isdefined(param_00.attacker) || !isplayer(param_00.attacker))
	{
	}

	var_01 = param_00.attacker;
}

//Function Number: 16
clearidshortly(param_00)
{
	self endon("disconnect");
	self notify("clearing_expID_" + param_00);
	self endon("clearing_expID_" + param_00);
	wait(3);
	self.explosivekills[param_00] = undefined;
}

//Function Number: 17
func_5207()
{
	var_00 = self;
	if(!isdefined(var_00.pers["MGStreak"]))
	{
		var_00.pers["MGStreak"] = 0;
		var_00 thread endmgstreakwhenleavemg();
		if(!isdefined(var_00.pers["MGStreak"]))
		{
		}
	}

	var_00.pers["MGStreak"]++;
	if(var_00.pers["MGStreak"] >= 5)
	{
		var_00 func_61CE("ch_mgmaster");
	}
}

//Function Number: 18
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

//Function Number: 19
func_2DD9()
{
	self.pers["MGStreak"] = undefined;
}

//Function Number: 20
killedbestenemyplayer(param_00)
{
	if(!isdefined(self.pers["countermvp_streak"]) || !param_00)
	{
		self.pers["countermvp_streak"] = 0;
	}

	self.pers["countermvp_streak"]++;
	if(self.pers["countermvp_streak"] == 3)
	{
		func_61CE("ch_thebiggertheyare");
	}

	if(self.pers["countermvp_streak"] == 5)
	{
		func_61CE("ch_thehardertheyfall");
	}
}

//Function Number: 21
func_48D6(param_00)
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

//Function Number: 22
func_1AA4(param_00,param_01)
{
	var_02 = param_00.attacker;
	var_03 = param_00.victim;
	var_03 func_5FA0();
	if(!isdefined(var_02) || !isplayer(var_02))
	{
	}

	param_01 = param_00.time;
	if(var_02.pers["cur_kill_streak"] == 10)
	{
		var_02 func_61CE("ch_fearless");
	}

	if(level.teambased)
	{
		if(level.teamcount[param_00.victim.pers["team"]] > 3 && var_02.killedplayers.size == 4 && var_02.ch_tangodowncomplete == 0)
		{
			var_02 func_61CE("ch_tangodown");
			var_02.ch_tangodowncomplete = 1;
		}

		if(level.teamcount[param_00.victim.pers["team"]] > 3 && var_02.killedplayerscurrent.size == 4 && var_02.ch_extremecrueltycomplete == 0)
		{
			var_02 func_61CE("ch_extremecruelty");
			var_02.ch_extremecrueltycomplete = 1;
		}
	}

	if(isdefined(var_03.inplayersmokescreen) && var_03.inplayersmokescreen == var_02)
	{
		var_02 func_61CE("ch_smokeemifyougotem");
	}

	if(isdefined(var_02.killedplayers[param_00.victim.guid]) && var_02.killedplayers[param_00.victim.guid] == 5)
	{
		var_02 func_61CE("ch_rival");
	}

	if(isdefined(var_02.tookweaponfrom[param_00.sweapon]))
	{
		if(var_02.tookweaponfrom[param_00.sweapon] == param_00.victim && param_00.smeansofdeath != "MOD_MELEE" || maps\mp\gametypes\_weapons::func_494E(param_00.sweapon) || maps\mp\gametypes\_weapons::isknifeonly(param_00.sweapon))
		{
			var_02 func_61CE("ch_cruelty");
		}
	}

	var_04 = 0;
	var_05 = 0;
	var_06 = 0;
	var_07 = 1;
	var_08 = 0;
	var_09 = 0;
	var_0A[param_00.victim.name] = param_00.victim.name;
	var_0B[param_00.sweapon] = param_00.sweapon;
	var_0C = 1;
	var_0D = [];
	foreach(var_0F in var_02.var_4B2E)
	{
		if(maps\mp\_utility::func_4890(var_0F.sweapon) && var_0F.smeansofdeath != "MOD_MELEE")
		{
			var_05++;
		}

		if(var_0F.sweapon == var_02.primaryweapon)
		{
			var_08++;
		}
		else if(var_0F.sweapon == var_02.secondaryweapon)
		{
			var_09++;
		}

		if(isdefined(var_0F.modifiers["longshot"]))
		{
			var_06++;
		}

		if(param_01 - var_0F.time < 10000)
		{
			var_07++;
		}

		if(maps\mp\_utility::func_48F7(var_0F.sweapon))
		{
			if(!isdefined(var_0D[var_0F.sweapon]))
			{
				var_0D[var_0F.sweapon] = 0;
			}

			var_0D[var_0F.sweapon]++;
			continue;
		}

		if(isdefined(level.onelefttime[var_02.team]) && var_0F.time > level.onelefttime[var_02.team])
		{
			var_04++;
		}

		if(isdefined(var_0F.victim))
		{
			if(!isdefined(var_0A[var_0F.victim.name]) && !isdefined(var_0B[var_0F.sweapon]))
			{
				var_0C++;
			}

			var_0A[var_0F.victim.name] = var_0F.victim.name;
		}

		var_0B[var_0F.sweapon] = var_0F.sweapon;
	}

	foreach(var_12 in var_0D)
	{
		if(var_12 >= 10)
		{
			var_02 func_61CE("ch_crabmeat");
		}
	}

	if(var_0C == 3)
	{
		var_02 func_61CE("ch_renaissance");
	}

	if(var_07 > 3 && level.teamcount[param_00.victim.team] <= var_07)
	{
		var_02 func_61CE("ch_omnicide");
	}

	if(maps\mp\_utility::func_4890(param_00.sweapon) && var_05 == 2)
	{
		var_02 func_61CE("ch_sidekick");
	}

	if(isdefined(param_00.modifiers["longshot"]) && var_06 == 2)
	{
		var_02 func_61CE("ch_nbk");
	}

	if(isdefined(level.onelefttime[var_02.team]) && var_04 == 2)
	{
		var_02 func_61CE("ch_enemyofthestate");
	}

	if(param_00.sweapon == "iw6_knifeonlyjugg_mp")
	{
		var_14[param_00.victim.name] = 1;
		foreach(var_0F in var_02.var_4B2E)
		{
			if(var_0F.sweapon == "iw6_knifeonlyjugg_mp")
			{
				if(isdefined(var_0F.victim) && !isdefined(var_14[var_0F.victim.name]))
				{
					var_14[var_0F.victim.name] = 1;
				}
			}
		}

		if(var_14.size >= 6)
		{
			var_02 func_61CE("ch_noplacetohide");
		}
	}

	if(param_00.smeansofdeath != "MOD_MELEE")
	{
		if((param_00.sweapon == var_02.primaryweapon && var_08 < var_09) || param_00.sweapon == var_02.secondaryweapon && var_09 < var_08)
		{
			var_02 func_61CE("ch_always_deadly");
		}

		if(var_02 func_74BC("specialty_twoprimaries") && var_02.secondaryweapon == param_00.sweapon)
		{
			var_02 func_61CE("ch_twoprimaries_pro");
		}
	}

	if(param_00.victim.score > 0)
	{
		if(level.teambased)
		{
			var_17 = param_00.victim.pers["team"];
			if(isdefined(var_17) && var_17 != var_02.pers["team"])
			{
				if(func_48D6(param_00.victim) && level.players.size >= 6)
				{
					var_02 killedbestenemyplayer(1);
				}
				else
				{
					var_02 killedbestenemyplayer(0);
				}
			}
		}
		else if(func_48D6(param_00.victim) && level.players.size >= 4)
		{
			var_02 killedbestenemyplayer(1);
		}
		else
		{
			var_02 killedbestenemyplayer(0);
		}
	}

	if(isdefined(param_00.modifiers["avenger"]))
	{
		var_02 func_61CE("ch_avenger");
	}

	if(isdefined(param_00.modifiers["buzzkill"]) && param_00.modifiers["buzzkill"] >= 9)
	{
		var_02 func_61CE("ch_thedenier");
	}

	if(maps\mp\_utility::func_4945(var_02) && param_00.sweapon != "none")
	{
		if(isdefined(var_02.killsthislifeperweapon[param_00.sweapon]))
		{
			var_02.killsthislifeperweapon[param_00.sweapon]++;
		}
		else
		{
			var_02.killsthislifeperweapon[param_00.sweapon] = 1;
		}
	}

	if(maps\mp\_utility::func_48F7(param_00.sweapon) && !allowkillchallengeforkillstreak(var_02,param_00.sweapon))
	{
	}

	if(isdefined(param_00.modifiers["jackintheboxkill"]))
	{
		var_02 func_61CE("ch_jackinthebox");
	}

	if(isdefined(param_00.modifiers["cooking"]))
	{
		var_02 func_61CE("ch_no");
	}

	if(var_02 func_4879())
	{
		var_02.brinkofdeathkillstreak++;
		if(isnumbermultipleof(var_02.brinkofdeathkillstreak,3))
		{
			var_02 func_61CE("ch_thebrink");
		}
	}

	if(var_02 func_74BC("specialty_gpsjammer"))
	{
		var_18 = 0;
		if(level.teambased)
		{
			var_19 = level.comexpfuncs["getRadarStrengthForTeam"];
			var_18 = [[ var_19 ]](maps\mp\_utility::getotherteam(var_02.team));
		}
		else
		{
			foreach(var_1B in level.uplinks)
			{
				if(isdefined(var_1B) && var_1B.owner.guid != var_02.guid)
				{
					var_18++;
					break;
				}
			}
		}

		if(var_18 > 0)
		{
			var_02 func_61CE("ch_offthegrid");
		}
	}

	if(var_02 func_74BC("specialty_deadeye"))
	{
		var_02 func_61CE("ch_deadeye");
	}

	if(var_02 func_74BC("specialty_lightweight"))
	{
		var_02 func_61CE("ch_lightweight");
	}

	if(var_02 func_74BC("specialty_extra_attachment") && param_00.sweapon != "none")
	{
		var_1D = maps\mp\_utility::weapongetnumattachments(param_00.sweapon);
		var_1E = 2;
		if(maps\mp\gametypes\_weapons::issidearm(param_00.sweapon))
		{
			var_1E = 1;
		}

		if(var_1D > var_1E)
		{
			var_02 func_61CE("ch_extra_attachment");
		}
	}

	if(var_02 func_74BC("specialty_gambler"))
	{
		var_02 func_61CE("ch_gambler");
	}

	if(var_02 func_74BC("specialty_regenfaster") && var_02.health < var_02.maxhealth)
	{
		var_02 func_61CE("ch_regenfaster");
	}

	if(var_02 func_74BC("specialty_sprintreload") && isdefined(var_02.sprintreloadtimestamp) && gettime() <= var_02.sprintreloadtimestamp && var_02.lastreloadedweapon == param_00.sweapon && param_00.smeansofdeath != "MOD_MELEE")
	{
		var_02 func_61CE("ch_onthego");
	}

	if(var_02 func_74BC("specialty_pitcher") && maps\mp\gametypes\_weapons::isoffhandweapon(param_00.sweapon))
	{
		var_02 func_61CE("ch_pitcher");
	}

	if(var_02 func_74BC("specialty_silentkill"))
	{
		var_02 func_61CE("ch_silentkill");
	}

	if(var_02 func_74BC("specialty_comexp") && level.uplinks.size > 0)
	{
		var_02 func_61CE("ch_comexp");
	}

	if(var_02 func_74BC("specialty_boom"))
	{
		var_1F = var_02 maps\mp\_utility::getuniqueid();
		if(isdefined(var_03.markedbyboomperk) && isdefined(var_03.markedbyboomperk[var_1F]) && gettime() <= var_03.markedbyboomperk[var_1F])
		{
			var_02 func_61CE("ch_boom");
			var_03.markedbyboomperk = undefined;
		}
	}

	if(!maps\mp\gametypes\_weapons::isoffhandweapon(param_00.sweapon) && param_00.sweapon != var_02.pers["primaryWeapon"] && param_00.sweapon != var_02.pers["secondaryWeapon"])
	{
		var_02 func_61CE("ch_wiseguy");
	}

	if(!maps\mp\gametypes\_weapons::isoffhandweapon(param_00.sweapon) && param_00.smeansofdeath != "MOD_MELEE")
	{
		if(!isdefined(var_02.killsthismag))
		{
			var_02.killsthismag = [];
		}

		if(isdefined(var_02.killsthismag[param_00.sweapon]))
		{
			var_02.killsthismag[param_00.sweapon]++;
			if(isnumbermultipleof(var_02.killsthismag[param_00.sweapon],4))
			{
				var_02 func_61CE("ch_meticulous");
			}
		}
		else
		{
			var_02.killsthismag[param_00.sweapon] = 1;
		}
	}

	var_20 = 0;
	if(level.teambased)
	{
		var_20 = level.activeuavs[maps\mp\_utility::getotherteam(var_02.team)] > 0;
	}
	else
	{
		var_20 = level.activeuavs[var_03.guid] > 0;
	}

	if(var_20)
	{
		var_02 func_61CE("ch_youcantseeme");
	}

	if(var_02 func_74BC("specialty_incog"))
	{
		var_02 func_61CE("ch_incog");
	}

	if(isdefined(level.lbsniper) && isdefined(level.lbsniper.owner) && level.lbsniper.owner == var_03 && func_74BC("specialty_blindeye"))
	{
		func_61CE("ch_blindeye_pro");
	}

	if(param_00.sweapon == "none")
	{
		if(isdefined(param_00.victim.explosiveinfo) && isdefined(param_00.victim.explosiveinfo["weapon"]))
		{
			param_00.sweapon = param_00.victim.explosiveinfo["weapon"];
		}
		else
		{
		}
	}

	var_21 = maps\mp\_utility::func_3A37(param_00.sweapon);
	var_22 = maps\mp\_utility::getweaponclass(param_00.sweapon);
	if(param_00.smeansofdeath == "MOD_PISTOL_BULLET" || param_00.smeansofdeath == "MOD_RIFLE_BULLET" || param_00.smeansofdeath == "MOD_HEAD_SHOT")
	{
		ch_bulletdamagecommon(param_00,var_02,param_01,var_22);
		if(var_22 == "weapon_mg")
		{
			var_02 func_5207();
		}
		else
		{
			switch(var_22)
			{
				case "weapon_smg":
					var_02 processweaponclasschallenge_smg(var_21,param_00);
					break;

				case "weapon_assault":
					var_02 processweaponclasschallenge_ar(var_21,param_00);
					break;

				case "weapon_shotgun":
					var_02 processweaponclasschallenge_shotgun(var_21,param_00);
					break;

				case "weapon_dmr":
					var_02 processweaponclasschallenge_dmr(var_21,param_00);
					break;

				case "weapon_sniper":
					var_02 processweaponclasschallenge_sniper(var_21,param_00);
					break;

				case "weapon_pistol":
					var_02 func_61CE("ch_handgun_kill");
					if(var_21 == "iw6_magnum")
					{
						var_23 = maps\mp\_utility::func_3C72(param_00.sweapon);
						var_24 = 0;
						foreach(var_26 in var_23)
						{
							if(var_26 == "acog")
							{
								var_24++;
								continue;
							}
	
							if(var_26 == "akimbo")
							{
								var_24++;
							}
						}
	
						if(var_23.size == 2 && var_24 == 2)
						{
							var_02 func_61CE("ch_noidea");
						}
					}
	
					if(var_02 checkwaslastweaponriotshield() && isdefined(var_02.lastprimaryweaponswaptime) && gettime() - var_02.lastprimaryweaponswaptime < 2000)
					{
						var_02 func_61CE("ch_iw6_riotshield_pistol");
					}
					break;

				case "weapon_lmg":
					var_02 processweaponclasschallenge_lmg(var_21,param_00);
					break;

				default:
					break;
			}

			if(param_00.smeansofdeath == "MOD_HEAD_SHOT")
			{
				if(isdefined(param_00.modifiers["revenge"]))
				{
					var_02 func_61CE("ch_colorofmoney");
				}

				if(maps\mp\_utility::func_4971(param_00.sweapon,"frag_"))
				{
					var_02 func_61CE("ch_thinkfast");
				}
				else if(maps\mp\_utility::func_4971(param_00.sweapon,"concussion_"))
				{
					var_02 func_61CE("ch_thinkfastconcussion");
				}
				else if(maps\mp\_utility::func_4971(param_00.sweapon,"flash_"))
				{
					var_02 func_61CE("ch_thinkfastflash");
				}
			}
		}
	}
	else if(issubstr(param_00.smeansofdeath,"MOD_GRENADE") || issubstr(param_00.smeansofdeath,"MOD_EXPLOSIVE") || issubstr(param_00.smeansofdeath,"MOD_PROJECTILE"))
	{
		if(maps\mp\_utility::func_4971(param_00.sweapon,"frag_grenade_short") && !isdefined(param_00.victim.explosiveinfo["throwbackKill"]) || !param_00.victim.explosiveinfo["throwbackKill"])
		{
			var_02 func_61CE("ch_martyr");
		}

		if(isdefined(param_00.victim.explosiveinfo["damageTime"]) && param_00.victim.explosiveinfo["damageTime"] == param_01)
		{
			var_28 = param_01 + "_" + param_00.victim.explosiveinfo["damageId"];
			if(!isdefined(var_02.explosivekills[var_28]))
			{
				var_02.explosivekills[var_28] = 0;
			}

			var_02 thread clearidshortly(var_28);
			var_02.explosivekills[var_28]++;
			var_23 = maps\mp\_utility::func_3C72(param_00.sweapon);
			foreach(var_2A in var_23)
			{
				switch(var_2A)
				{
					case "gl":
						if(maps\mp\_utility::func_4971(param_00.sweapon,"alt_"))
						{
							var_02 processweaponattachmentchallenge(var_21,var_2A);
						}
						break;
				}
			}

			if(isdefined(param_00.victim.explosiveinfo["stickKill"]) && param_00.victim.explosiveinfo["stickKill"])
			{
				if(isdefined(param_00.modifiers["revenge"]))
				{
					var_02 func_61CE("ch_overdraft");
				}

				if(var_02.explosivekills[var_28] > 1)
				{
					var_02 func_61CE("ch_grouphug");
				}
			}

			if(isdefined(param_00.victim.explosiveinfo["stickFriendlyKill"]) && param_00.victim.explosiveinfo["stickFriendlyKill"])
			{
				var_02 func_61CE("ch_resourceful");
			}

			if(param_00.victim.explosiveinfo["throwbackKill"])
			{
				var_02 func_61CE("ch_throwaway");
			}

			if(maps\mp\_utility::func_4971(param_00.sweapon,"frag_"))
			{
				if(var_02.explosivekills[var_28] > 1)
				{
					var_02 func_61CE("ch_multifrag");
				}

				if(isdefined(param_00.modifiers["revenge"]))
				{
					var_02 func_61CE("ch_bangforbuck");
				}

				var_02 func_61CE("ch_grenadekill");
				if(param_00.victim.explosiveinfo["cookedKill"])
				{
					var_02 func_61CE("ch_masterchef");
				}

				if(param_00.victim.explosiveinfo["suicideGrenadeKill"])
				{
					var_02 func_61CE("ch_miserylovescompany");
				}

				if(param_00.victim.explosiveinfo["throwbackKill"])
				{
					var_02 func_61CE("ch_hotpotato");
				}
			}
			else if(maps\mp\_utility::func_4971(param_00.sweapon,"semtex") || param_00.sweapon == "iw6_mk32_mp")
			{
				if(isdefined(param_00.modifiers["revenge"]))
				{
					var_02 func_61CE("ch_timeismoney");
				}

				if(isdefined(param_00.victim.explosiveinfo["stickKill"]) && param_00.victim.explosiveinfo["stickKill"])
				{
					var_02 func_61CE("ch_plastered");
				}

				param_00.victim.stuckbygrenade = undefined;
			}
			else if(maps\mp\_utility::func_4971(param_00.sweapon,"c4_"))
			{
				if(isdefined(param_00.modifiers["revenge"]))
				{
					var_02 func_61CE("ch_iamrich");
				}

				if(var_02.explosivekills[var_28] > 1)
				{
					var_02 func_61CE("ch_multic4");
				}

				if(param_00.victim.explosiveinfo["returnToSender"])
				{
					var_02 func_61CE("ch_returntosender");
				}

				if(param_00.victim.explosiveinfo["counterKill"])
				{
					var_02 func_61CE("ch_counterc4");
				}

				if(isdefined(param_00.victim.explosiveinfo["bulletPenetrationKill"]) && param_00.victim.explosiveinfo["bulletPenetrationKill"])
				{
					var_02 func_61CE("ch_howthe");
				}

				if(param_00.victim.explosiveinfo["chainKill"])
				{
					var_02 func_61CE("ch_dominos");
				}

				var_02 func_61CE("ch_c4shot");
				if(var_02 checkwaslastweaponriotshield())
				{
					var_02 func_61CE("ch_iw6_riotshield_c4");
				}
			}
			else if(maps\mp\_utility::func_4971(param_00.sweapon,"proximity_explosive_"))
			{
				var_02 func_61CE("ch_proximityexplosive");
				if(isdefined(param_00.modifiers["revenge"]))
				{
					var_02 func_61CE("ch_breakbank");
				}

				if(param_00.victim.explosiveinfo["chainKill"])
				{
					var_02 func_61CE("ch_dominos");
				}
			}
			else if(maps\mp\_utility::func_4971(param_00.sweapon,"mortar_shell_"))
			{
				var_02 func_61CE("ch_mortarshell");
			}
			else if(param_00.sweapon == "explodable_barrel")
			{
			}
			else if(param_00.sweapon == "destructible_car")
			{
				var_02 func_61CE("ch_carbomb");
			}
			else if(maps\mp\gametypes\_weapons::isrocketlauncher(param_00.sweapon))
			{
				var_2C = var_02.explosivekills[var_28];
				if(isnumbermultipleof(var_2C,2))
				{
					var_02 func_61CE("ch_multirpg");
				}
			}

			if(var_02 func_74BC("specialty_explosivedamage"))
			{
				var_02 func_61CE("ch_explosivedamage");
			}

			var_02 checkchallengeextradeadly(param_00.sweapon);
		}
	}
	else if(issubstr(param_00.smeansofdeath,"MOD_MELEE") && !maps\mp\gametypes\_weapons::func_494E(param_00.sweapon))
	{
		var_02 func_2DD9();
		var_02 func_61CE("ch_knifevet");
		var_02.pers["meleeKillStreak"]++;
		if(var_02.pers["meleeKillStreak"] == 3)
		{
			var_02 func_61CE("ch_slasher");
		}

		if(var_02 isitemunlocked("specialty_quieter") && var_02 maps\mp\_utility::_hasperk("specialty_quieter"))
		{
			var_02 func_61CE("ch_deadsilence_pro");
		}

		var_2D = param_00.victim.anglesondeath[1];
		var_2E = var_02.anglesonkill[1];
		var_2F = angleclamp180(var_2D - var_2E);
		if(abs(var_2F) < 30)
		{
			var_02 func_61CE("ch_backstabber");
			if(isdefined(var_02.attackers))
			{
				foreach(var_31 in var_02.attackers)
				{
					if(!isdefined(maps\mp\_utility::_validateattacker(var_31)))
					{
						continue;
					}

					if(var_31 != param_00.victim)
					{
						continue;
					}

					var_02 func_61CE("ch_neverforget");
					break;
				}
			}
		}

		if(!var_02 func_5FB0() && var_21 != "iw6_knifeonly" && var_21 != "iw6_knifeonlyfast" && var_21 != "iw6_knifeonlyjugg")
		{
			var_02 func_61CE("ch_survivor");
		}

		if(isdefined(var_02.infected))
		{
			param_00.victim func_61CE("ch_infected");
		}

		if(isdefined(param_00.victim.plague))
		{
			var_02 func_61CE("ch_plague");
		}

		if(var_02 playerissprintsliding())
		{
			var_02 func_61CE("ch_smooth_moves");
		}

		var_23 = maps\mp\_utility::func_3C72(param_00.sweapon);
		foreach(var_2A in var_23)
		{
			switch(var_2A)
			{
				case "tactical":
						var_02 processweaponattachmentchallenge(var_21,var_2A);
						break;
			}
		}

		if(var_02.weaponlist.size == 1 && var_02.weaponlist[0] == "iw6_knifeonly_mp" || var_02.weaponlist[0] == "iw6_knifeonlyfast_mp")
		{
			var_02 func_61CE("ch_ballsofsteel");
		}

		if(checkcostumechallenge(var_03,"mp_fullbody_sniper_ab"))
		{
			var_02 func_61CE("ch_bigfoot");
		}
	}
	else if(maps\mp\gametypes\_weapons::func_494E(param_00.sweapon))
	{
		if(issubstr(param_00.smeansofdeath,"MOD_MELEE"))
		{
			var_02 func_2DD9();
			var_02 func_61CE("ch_shieldvet");
			var_02.pers["shieldKillStreak"]++;
			var_02 func_61CE("ch_riot_kill");
			var_2D = param_00.victim.anglesondeath[1];
			var_2E = var_02.anglesonkill[1];
			var_2F = angleclamp180(var_2D - var_2E);
			if(abs(var_2F) < 30)
			{
				var_02 func_61CE("ch_iw6_riotshield_backsmasher");
			}

			if(!var_02 func_5FB0())
			{
				var_02 func_61CE("ch_survivor");
			}

			var_02 processweaponclasschallenge_riotshield(var_21,param_00);
		}

		var_23 = maps\mp\_utility::func_3C72(param_00.sweapon);
		foreach(var_2A in var_23)
		{
			switch(var_2A)
			{
				case "rshieldspikes":
				case "rshieldscrambler":
				case "rshieldradar":
							var_02 processweaponattachmentchallenge(var_21,var_2A);
							break;
			}
		}
	}
	else if(issubstr(param_00.smeansofdeath,"MOD_IMPACT"))
	{
		if(maps\mp\_utility::func_4971(param_00.sweapon,"frag_"))
		{
			var_02 func_61CE("ch_thinkfast");
		}
		else if(maps\mp\_utility::func_4971(param_00.sweapon,"concussion_"))
		{
			var_02 func_61CE("ch_thinkfastconcussion");
		}
		else if(maps\mp\_utility::func_4971(param_00.sweapon,"flash_"))
		{
			var_02 func_61CE("ch_thinkfastflash");
		}

		if(maps\mp\gametypes\_weapons::isthrowingknife(param_00.sweapon))
		{
			if(isdefined(param_00.modifiers["revenge"]))
			{
				var_02 func_61CE("ch_atm");
			}

			var_02 func_61CE("ch_carnie");
			if(isdefined(param_00.victim.attackerdata[var_02.guid]))
			{
				var_02 func_61CE("ch_its_personal");
			}

			if(var_02 isitemunlocked("specialty_fastoffhand") && var_02 maps\mp\_utility::_hasperk("specialty_fastoffhand"))
			{
				var_02 func_61CE("ch_fastoffhand");
			}

			if(var_02 checkwaslastweaponriotshield())
			{
				var_02 func_61CE("ch_iw6_riotshield_throwingknife");
			}

			var_02 checkchallengeextradeadly(param_00.sweapon);
		}

		var_23 = maps\mp\_utility::func_3C72(param_00.sweapon);
		foreach(var_2A in var_23)
		{
			switch(var_2A)
			{
				case "gl":
								if(maps\mp\_utility::func_4971(param_00.sweapon,"alt_"))
								{
									var_02 processweaponattachmentchallenge(var_21,var_2A);
									var_02 func_61CE("ch_ouch");
								}
								break;
			}
		}
	}

	if((param_00.smeansofdeath == "MOD_PISTOL_BULLET" || param_00.smeansofdeath == "MOD_RIFLE_BULLET" || param_00.smeansofdeath == "MOD_HEAD_SHOT") && !maps\mp\_utility::func_48F7(param_00.sweapon) && !maps\mp\_utility::func_48B7(param_00.sweapon))
	{
		var_23 = maps\mp\_utility::func_3C72(param_00.sweapon);
		foreach(var_2A in var_23)
		{
			switch(var_2A)
			{
				case "acog":
					var_02 processweaponattachmentchallenge_acog(var_21,var_2A,param_00);
					break;

				case "eotech":
					var_02 processweaponattachmentchallenge_eotech(var_21,var_2A,param_00);
					break;

				case "hybrid":
					var_02 processweaponattachmentchallenge_hybrid(var_21,var_2A,param_00);
					break;

				case "reflex":
					var_02 processweaponattachmentchallenge_reflex(var_21,var_2A,param_00);
					break;

				case "vzscope":
				case "tracker":
				case "thermal":
				case "ironsight":
				case "scope":
					if(var_02 maps\mp\_utility::isplayerads())
					{
						var_02 processweaponattachmentchallenge(var_21,var_2A);
					}
					break;

				case "xmags":
				case "silencer":
				case "rof":
				case "grip":
				case "flashsuppress":
				case "barrelrange":
				case "barrelbored":
				case "ammoslug":
				case "firetypesingle":
				case "firetypeauto":
				case "firetypeburst":
				case "akimbo":
					var_02 processweaponattachmentchallenge(var_21,var_2A);
					break;

				case "gl":
				case "shotgun":
					if(maps\mp\_utility::func_4971(param_00.sweapon,"alt_"))
					{
						var_02 processweaponattachmentchallenge(var_21,var_2A);
					}
					break;

				case "fmj":
					var_02 func_61CE("ch_armorpiercing");
					break;

				default:
					break;
			}
		}

		if(maps\mp\_utility::weaponhasintegratedfiretypeburst(param_00.sweapon))
		{
			var_02 processweaponattachmentchallenge(var_21,"firetypeburst");
		}

		if(maps\mp\_utility::weaponhasintegratedsilencer(var_21))
		{
			var_02 processweaponattachmentchallenge(var_21,"silencer");
		}

		if(maps\mp\_utility::weaponhasintegratedgrip(var_21))
		{
			var_02 processweaponattachmentchallenge(var_21,"grip");
		}

		if(maps\mp\_utility::weaponhasintegratedfmj(var_21))
		{
			var_02 processweaponattachmentchallenge(var_21,"fmj");
		}

		if(var_02 maps\mp\_utility::isplayerads() && maps\mp\_utility::weaponhasintegratedtrackerscope(param_00.sweapon))
		{
			var_02 processweaponattachmentchallenge(var_21,"tracker");
		}

		var_3B = maps\mp\_utility::getnumdefaultattachments(param_00.sweapon);
		if(var_23.size == var_3B)
		{
			var_02 func_61CE("ch_noattachments");
		}

		if(var_02 func_74BC("specialty_bulletaccuracy") && !var_02 maps\mp\_utility::isplayerads())
		{
			var_02 func_61CE("ch_bulletaccuracy_pro");
		}

		if(var_02 func_74BC("specialty_stalker") && var_02 maps\mp\_utility::isplayerads())
		{
			var_02 func_61CE("ch_stalker_pro");
		}

		if(distancesquared(var_02.origin,param_00.victim.origin) < 65536)
		{
			if(var_02 func_74BC("specialty_quieter"))
			{
				var_02 func_61CE("ch_deadsilence_pro");
			}
		}

		if(var_02 func_74BC("specialty_fastreload") && var_02 hasreloadedrecently())
		{
			var_02 func_61CE("ch_sleightofhand_pro");
		}

		if(var_02 func_74BC("specialty_sharp_focus"))
		{
			if(isdefined(var_02.attackers) && var_02.attackers.size > 0)
			{
				var_02 func_61CE("ch_sharp_focus");
			}
		}
	}

	if(var_02 isitemunlocked("specialty_quickdraw") && var_02 maps\mp\_utility::_hasperk("specialty_quickdraw") && var_02.adstime > 0 && var_02.adstime < 3)
	{
		var_02 func_61CE("ch_quickdraw_pro");
	}

	if(var_02 isitemunlocked("specialty_empimmune") && var_02 maps\mp\_utility::_hasperk("specialty_empimmune"))
	{
		if(level.teambased)
		{
			var_3C = 0;
			foreach(var_3E in level.uavmodels[maps\mp\_utility::getotherteam(var_02.team)])
			{
				if(var_3E.uavtype != "counter")
				{
					continue;
				}

				var_3C = 1;
				break;
			}

			if(var_3C || var_02 maps\mp\_utility::func_48B2())
			{
				var_02 func_61CE("ch_spygame");
			}
		}
		else if(var_02.isradarblocked || var_02 maps\mp\_utility::func_48B2())
		{
			var_02 func_61CE("ch_spygame");
		}
	}

	if(isdefined(param_00.victim.isplanting) && param_00.victim.isplanting)
	{
		var_02 func_61CE("ch_bombplanter");
	}

	if(isdefined(param_00.victim.isdefusing) && param_00.victim.isdefusing)
	{
		var_02 func_61CE("ch_bombdefender");
	}

	if(isdefined(param_00.victim.isbombcarrier) && param_00.victim.isbombcarrier && !isdefined(level.dd) || !level.dd)
	{
		var_02 func_61CE("ch_bombdown");
	}

	if(isdefined(param_00.victim.var_8C4D) && param_00.victim.var_8C4D)
	{
		var_02 func_61CE("ch_tacticaldeletion");
	}

	if(var_02 isitemunlocked("specialty_quickswap") && var_02 maps\mp\_utility::_hasperk("specialty_quickswap"))
	{
		if(isdefined(var_02.lastprimaryweaponswaptime) && gettime() - var_02.lastprimaryweaponswaptime < 3000)
		{
			var_02 func_61CE("ch_quickswap");
		}
	}

	if(var_02 isitemunlocked("specialty_extraammo") && var_02 maps\mp\_utility::_hasperk("specialty_extraammo"))
	{
		var_02 func_61CE("ch_extraammo");
	}

	if(isexplosivedamagemod(param_00.smeansofdeath))
	{
		switch(param_00.sweapon)
		{
			case "semtex_mp":
			case "concussion_grenade_mp":
			case "thermobaric_grenade_mp":
			case "emp_grenade_mp":
			case "flash_grenade_mp":
			case "mortar_shell_mp":
			case "frag_grenade_mp":
				if(var_02 isitemunlocked("specialty_fastoffhand") && var_02 maps\mp\_utility::_hasperk("specialty_fastoffhand"))
				{
					var_02 func_61CE("ch_fastoffhand");
				}
				break;
		}

		if(isdefined(var_03.thermodebuffed) && var_03.thermodebuffed)
		{
			var_02 func_61CE("ch_thermobaric");
		}
	}

	if(var_02 isitemunlocked("specialty_overkillpro") && var_02 maps\mp\_utility::_hasperk("specialty_overkillpro"))
	{
		if(var_02.secondaryweapon == param_00.sweapon)
		{
			var_23 = getweaponattachments(param_00.sweapon);
			if(var_23.size > 0)
			{
				var_02 func_61CE("ch_secondprimary");
			}
		}
	}

	if(var_02 isitemunlocked("specialty_stun_resistance") && var_02 maps\mp\_utility::_hasperk("specialty_stun_resistance"))
	{
		if(isdefined(var_02.lastflashedtime) && gettime() - var_02.lastflashedtime < 5000)
		{
			var_02 func_61CE("ch_stunresistance");
		}
		else if(isdefined(var_02.lastconcussedtime) && gettime() - var_02.lastconcussedtime < 5000)
		{
			var_02 func_61CE("ch_stunresistance");
		}
	}

	if(var_02 isitemunlocked("specialty_selectivehearing") && var_02 maps\mp\_utility::_hasperk("specialty_selectivehearing"))
	{
		var_02 func_61CE("ch_selectivehearing");
	}

	if(var_02 isitemunlocked("specialty_fastsprintrecovery") && var_02 maps\mp\_utility::_hasperk("specialty_fastsprintrecovery"))
	{
		if(isdefined(var_02.lastsprintendtime) && gettime() - var_02.lastsprintendtime < 3000)
		{
			var_02 func_61CE("ch_fastsprintrecovery");
		}
	}
}

//Function Number: 23
ch_bulletdamagecommon(param_00,param_01,param_02,param_03)
{
	if(!maps\mp\_utility::func_48B7(param_00.sweapon))
	{
		param_01 func_2DD9();
	}

	if(maps\mp\_utility::func_48F7(param_00.sweapon))
	{
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
		param_01 func_61CE("ch_hardlanding");
	}

	if(!param_00.attackeronground)
	{
		param_01.pers["midairStreak"]++;
	}

	if(param_01.pers["midairStreak"] == 2)
	{
		param_01 func_61CE("ch_airborne");
	}

	if(param_02 < param_00.victim.flashendtime)
	{
		param_01 func_61CE("ch_flashbangvet");
	}

	if(param_02 < param_01.flashendtime)
	{
		param_01 func_61CE("ch_blindfire");
	}

	if(param_02 < param_00.victim.concussionendtime)
	{
		param_01 func_61CE("ch_concussionvet");
	}

	if(param_02 < param_01.concussionendtime)
	{
		param_01 func_61CE("ch_slowbutsure");
	}

	if(param_01.pers["bulletStreak"] == 2)
	{
		if(isdefined(param_00.modifiers["headshot"]))
		{
			foreach(var_05 in param_01.var_4B2E)
			{
				if(var_05.time != param_02)
				{
					continue;
				}

				if(!isdefined(param_00.modifiers["headshot"]))
				{
					continue;
				}

				param_01 func_61CE("ch_allpro");
			}
		}

		if(param_03 == "weapon_sniper")
		{
			param_01 func_61CE("ch_collateraldamage");
		}
	}

	if(param_03 == "weapon_pistol")
	{
		if(isdefined(param_00.victim.attackerdata) && isdefined(param_00.victim.attackerdata[param_01.guid]))
		{
			if(isdefined(param_00.victim.attackerdata[param_01.guid].isprimary))
			{
				param_01 func_61CE("ch_fastswap");
			}
		}
	}

	if(!isdefined(param_01.var_44CB) || !param_01.var_44CB)
	{
		if(param_00.attackerstance == "crouch")
		{
			param_01 func_61CE("ch_crouchshot");
		}
		else if(param_00.attackerstance == "prone")
		{
			param_01 func_61CE("ch_proneshot");
			if(param_03 == "weapon_sniper")
			{
				param_01 func_61CE("ch_invisible");
			}
		}
	}

	if(issubstr(param_00.sweapon,"silencer"))
	{
		param_01 func_61CE("ch_stealthvet");
	}
}

//Function Number: 24
ch_roundplayed(param_00)
{
	var_01 = param_00.player;
	if(var_01.var_8C3F)
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
			var_01 func_61CE("ch_starplayer");
		}

		if(var_02 == 0 && maps\mp\_utility::func_3C4B() > 300000)
		{
			var_01 func_61CE("ch_flawless");
		}

		if(level.placement["all"].size < 3)
		{
		}

		if(var_01.score > 0)
		{
			switch(level.gametype)
			{
				case "dm":
				case "gun":
					if(param_00.place < 3)
					{
						var_01 func_61CE("ch_victor_dm");
						var_01 func_61CE("ch_hunted_victor");
					}
					break;

				case "sotf_ffa":
					if(param_00.place < 3)
					{
						var_01 func_61CE("ch_hunted_victor");
					}
					break;
			}
		}
	}
}

//Function Number: 25
ch_roundwin(param_00)
{
	if(!param_00.winner)
	{
	}

	var_01 = param_00.player;
	if(var_01.var_8C3F)
	{
		switch(level.gametype)
		{
			case "war":
				if(level.hardcoremode)
				{
					var_01 func_61CE("ch_teamplayer_hc");
					if(param_00.place == 0)
					{
						var_01 func_61CE("ch_mvp_thc");
					}
				}
				else
				{
					var_01 func_61CE("ch_teamplayer");
					if(param_00.place <= 2)
					{
						var_01 func_61CE("ch_tdmskills");
						if(param_00.place == 0)
						{
							var_01 func_61CE("ch_mvp_tdm");
						}
					}
				}
				break;

			case "blitz":
				var_01 func_61CE("ch_blitz_victor");
				break;

			case "cranked":
				var_01 func_61CE("ch_crank_victor");
				break;

			case "dom":
				var_01 func_61CE("ch_dom_victor");
				break;

			case "grind":
				var_01 func_61CE("ch_grind_victor");
				break;

			case "infect":
				if(var_01.team == "allies")
				{
					var_01 func_61CE("ch_alive");
				}
	
				var_01 func_61CE("ch_infected");
				break;

			case "sd":
				var_01 func_61CE("ch_victor_sd");
				break;

			case "sr":
				var_01 func_61CE("ch_sr_victor");
				break;

			case "conf":
				var_01 func_61CE("ch_conf_victor");
				break;

			case "koth":
			case "dm":
			case "gun":
			case "sotf_ffa":
				break;

			default:
				break;
		}

		var_02 = getdvarint("scr_playlist_type",0);
		if(var_02 == 1)
		{
			var_01 func_61CE("ch_bromance");
			if(!level.console)
			{
				var_01 func_61CE("ch_tactician");
			}
		}
		else if(var_02 == 2)
		{
			var_01 func_61CE("ch_tactician");
		}

		if(level.hardcoremode)
		{
			var_01 func_61CE("ch_hardcore_extreme");
		}
	}
}

//Function Number: 26
func_5F9D(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(maps\mp\_utility::func_47BB())
	{
	}

	func_5F9E(param_00,param_01,param_02,param_03,param_04,param_05);
}

//Function Number: 27
func_5F9E(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isplayer(self))
	{
	}

	self endon("disconnect");
	if(isdefined(param_01))
	{
		param_01 endon("disconnect");
	}

	wait(0.05);
	maps\mp\_utility::func_8BC1();
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

//Function Number: 28
func_5FC1(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(maps\mp\_utility::func_47BB())
	{
	}

	playerkilled_regularmp(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07);
}

//Function Number: 29
playerkilled_regularmp(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07)
{
	if(maps\mp\_utility::func_4995())
	{
		self.anglesondeath = self.angles;
	}
	else
	{
		self.anglesondeath = self getplayerangles();
	}

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
	if(isdefined(param_04) && issubstr(param_04,"_hybrid"))
	{
		if(param_01 getcurrentweapon() == param_04)
		{
			var_08.hybridscopestate = param_01 gethybridscopestate(param_04);
		}
		else
		{
			var_08.hybridscopestate = 0;
		}
	}

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

	func_8ACF(var_08);
	if(isdefined(param_01) && maps\mp\_utility::func_4945(param_01))
	{
		param_01.var_4B2E[param_01.var_4B2E.size] = var_08;
	}

	var_08.attacker notify("playerKilledChallengesProcessed");
}

//Function Number: 30
vehiclekilled(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!maps\mp\_utility::func_47BB())
	{
		func_4B3D(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
	}
}

//Function Number: 31
func_4B3C(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(!maps\mp\_utility::func_47BB())
	{
		func_4B3D(param_00,param_01,param_02,param_03,param_04,param_05,param_06);
	}
}

//Function Number: 32
func_4B3D(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(isdefined(param_03) && isplayer(param_03) && !isdefined(param_00) || param_03 != param_00 && param_03 maps\mp\_utility::func_4B2A(param_06))
	{
		param_03 maps\mp\killstreaks\_killstreaks::func_3CDB("vehicleDestroyed");
	}
}

//Function Number: 33
func_8ACF(param_00)
{
	if(isdefined(param_00.attacker))
	{
		param_00.attacker endon("disconnect");
	}

	self.processingkilledchallenges = 1;
	wait(0.05);
	maps\mp\_utility::func_8BC1();
	domissioncallback("playerKilled",param_00);
	self.processingkilledchallenges = undefined;
}

//Function Number: 34
func_5F95(param_00)
{
	var_01 = spawnstruct();
	var_01.player = self;
	var_01.victim = param_00;
	var_02 = param_00.attackerdata[self.guid];
	if(isdefined(var_02))
	{
		var_01.sweapon = var_02.weapon;
	}

	domissioncallback("playerAssist",var_01);
}

//Function Number: 35
func_87BA(param_00)
{
	if(maps\mp\_utility::func_47BB())
	{
	}

	usehardpoint_regularmp(param_00);
}

//Function Number: 36
usehardpoint_regularmp(param_00)
{
	self endon("disconnect");
	wait(0.05);
	maps\mp\_utility::func_8BC1();
	var_01 = spawnstruct();
	var_01.player = self;
	var_01.hardpointtype = param_00;
	domissioncallback("playerHardpoint",var_01);
}

//Function Number: 37
roundbegin()
{
	domissioncallback("roundBegin");
}

//Function Number: 38
func_6894(param_00)
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
	}

	for(var_03 = 0;var_03 < level.placement["all"].size;var_03++)
	{
		var_01.player = level.placement["all"][var_03];
		var_01.winner = isdefined(param_00) && isplayer(param_00) && var_01.player == param_00;
		var_01.place = var_03;
		domissioncallback("roundEnd",var_01);
	}
}

//Function Number: 39
domissioncallback(param_00,param_01)
{
	if(!func_5126())
	{
	}

	if(isdefined(param_01))
	{
		var_02 = param_01.player;
		if(!isdefined(var_02))
		{
			var_02 = param_01.attacker;
		}

		if(isdefined(var_02) && isai(var_02))
		{
		}
	}

	if(getdvarint("disable_challenges") > 0)
	{
	}

	if(!isdefined(level.missioncallbacks[param_00]))
	{
	}

	if(isdefined(param_01))
	{
		for(var_03 = 0;var_03 < level.missioncallbacks[param_00].size;var_03++)
		{
			thread [[ level.missioncallbacks[param_00][var_03] ]](param_01);
		}
	}

	for(var_03 = 0;var_03 < level.missioncallbacks[param_00].size;var_03++)
	{
		thread [[ level.missioncallbacks[param_00][var_03] ]]();
	}
}

//Function Number: 40
func_53C4()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	self.sprintdistthissprint = 0;
	for(;;)
	{
		self waittill("sprint_begin");
		thread func_53C6();
		if(maps\mp\_utility::_hasperk("specialty_marathon"))
		{
			monitorsinglesprintdistance();
			var_00 = int(self.sprintdistthissprint / 120);
			self.sprintdistthissprint = self.sprintdistthissprint - var_00 * 120;
			func_61CE("ch_longersprint_pro",var_00);
		}
	}
}

//Function Number: 41
monitorsinglesprintdistance()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	self endon("sprint_end");
	self endon("heli_sniper_enter");
	var_00 = self.origin;
	for(;;)
	{
		wait(0.1);
		var_01 = distance(self.origin,var_00);
		self.sprintdistthissprint = self.sprintdistthissprint + clamp(var_01,0,40);
		var_00 = self.origin;
	}
}

//Function Number: 42
func_53C6()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	var_00 = gettime();
	self waittill("sprint_end");
	var_01 = int(gettime() - var_00);
	maps\mp\_utility::func_447B("sprinttime",var_01);
	self.lastsprintendtime = gettime();
}

//Function Number: 43
func_5387()
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

				wait(0.05);
			}

			self.pers["midairStreak"] = 0;
			var_01 = var_00 - self.origin[2];
			if(var_01 < 0)
			{
				var_01 = 0;
			}

			if(var_01 / 12 > 15 && isalive(self))
			{
				func_61CE("ch_basejump");
			}

			if(var_01 / 12 > 30 && !isalive(self))
			{
				func_61CE("ch_goodbye");
			}
		}

		wait(0.05);
	}
}

//Function Number: 44
lastmansd()
{
	if(!func_5126())
	{
	}

	if(!self.var_8C3F)
	{
	}

	if(self.teamkillsthisround > 0)
	{
	}

	func_61CE("ch_lastmanstanding");
}

//Function Number: 45
func_5374()
{
	self endon("disconnect");
	for(;;)
	{
		var_00 = common_scripts\utility::func_8B33("bomb_planted","bomb_defused");
		if(!isdefined(var_00))
		{
			continue;
		}

		if(var_00 == "bomb_planted")
		{
			func_61CE("ch_saboteur");
			continue;
		}

		if(var_00 == "bomb_defused")
		{
			func_61CE("ch_hero");
		}
	}
}

//Function Number: 46
monitorlivetime()
{
	for(;;)
	{
		self waittill("spawned_player");
		thread func_7D77();
	}
}

//Function Number: 47
func_7D77()
{
	self endon("death");
	self endon("disconnect");
	wait(300);
	if(isdefined(self))
	{
		func_61CE("ch_survivalist");
	}
}

//Function Number: 48
func_53CA()
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

//Function Number: 49
monitormisc()
{
	thread func_53AC("destroyed_equipment");
	thread func_53AC("begin_airstrike");
	thread func_53AC("destroyed_car");
	thread func_53AC("destroyed_helicopter");
	thread func_53AC("used_airdrop");
	thread func_53AC("used_emp");
	thread func_53AC("used_nuke");
	thread func_53AC("crushed_enemy");
	self waittill("disconnect");
	self notify("destroyed_equipment");
	self notify("begin_airstrike");
	self notify("destroyed_car");
	self notify("destroyed_helicopter");
}

//Function Number: 50
func_53AC(param_00)
{
	for(;;)
	{
		self waittill(param_00);
		if(!isdefined(self))
		{
		}

		func_53AB(param_00);
	}
}

//Function Number: 51
func_53AB(param_00)
{
	switch(param_00)
	{
		case "begin_airstrike":
			self.pers["airstrikeStreak"] = 0;
			break;

		case "destroyed_equipment":
			if(self isitemunlocked("specialty_detectexplosive") && maps\mp\_utility::_hasperk("specialty_detectexplosive"))
			{
				func_61CE("ch_detectexplosives_pro");
			}
	
			func_61CE("ch_backdraft");
			break;

		case "destroyed_helicopter":
			func_61CE("ch_flyswatter");
			break;

		case "destroyed_car":
			func_61CE("ch_vandalism");
			break;

		case "crushed_enemy":
			func_61CE("ch_heads_up");
			if(isdefined(self.finalkill))
			{
				func_61CE("ch_droppincrates");
			}
			break;
	}
}

//Function Number: 52
func_405B()
{
	if(maps\mp\_utility::func_47BB())
	{
	}

	healthregenerated_regularmp();
}

//Function Number: 53
healthregenerated_regularmp()
{
	if(!isalive(self))
	{
	}

	if(!func_5126())
	{
	}

	if(!maps\mp\_utility::func_634C())
	{
	}

	thread resetbrinkofdeathkillstreakshortly();
	self notify("healed");
	if(isdefined(self.lastdamagewasfromenemy) && self.lastdamagewasfromenemy)
	{
		self.healthregenerationstreak++;
		if(self.healthregenerationstreak >= 5)
		{
			func_61CE("ch_invincible");
		}
	}
}

//Function Number: 54
resetbrinkofdeathkillstreakshortly()
{
	self endon("disconnect");
	self endon("death");
	self endon("damage");
	wait(1);
	self.brinkofdeathkillstreak = 0;
}

//Function Number: 55
func_5FD9()
{
	if(maps\mp\_utility::func_47BB())
	{
	}

	func_5FDA();
}

//Function Number: 56
func_5FDA()
{
	self.brinkofdeathkillstreak = 0;
	self.healthregenerationstreak = 0;
	self.pers["MGStreak"] = 0;
}

//Function Number: 57
func_5FA0()
{
	self.brinkofdeathkillstreak = 0;
	self.healthregenerationstreak = 0;
	self.pers["MGStreak"] = 0;
}

//Function Number: 58
func_4879()
{
	if(isalive(self))
	{
		var_00 = self.health / self.maxhealth;
		return var_00 <= level.healthoverlaycutoff;
	}

	return 0;
}

//Function Number: 59
func_61CE(param_00,param_01,param_02)
{
	if(maps\mp\_utility::func_47BB())
	{
	}

	func_61CF(param_00,param_01,param_02);
}

//Function Number: 60
func_61CF(param_00,param_01,param_02)
{
	if(!func_5126())
	{
	}

	if(level.players.size < 2)
	{
	}

	if(!maps\mp\_utility::func_634C())
	{
	}

	if(!isplayer(self) || isai(self))
	{
	}

	if(!isdefined(param_01))
	{
		param_01 = 1;
	}

	var_03 = getchallengestatus(param_00);
	if(var_03 == 0)
	{
	}

	var_04 = isdefined(level.challengeinfo[param_00]["operation"]);
	if(var_03 > level.challengeinfo[param_00]["targetval"].size)
	{
		var_05 = var_04 && var_03 == level.challengeinfo[param_00]["targetval"].size + 1;
		var_06 = isdefined(self.operationsmaxed) && isdefined(self.operationsmaxed[param_00]);
		if(var_05 && !var_06)
		{
			var_03 = level.challengeinfo[param_00]["targetval"].size;
		}
		else
		{
		}
	}

	var_07 = maps\mp\gametypes\_hud_util::func_1A9F(param_00);
	var_08 = level.challengeinfo[param_00]["targetval"][var_03];
	if(isdefined(param_02) && param_02)
	{
		var_09 = param_01;
	}
	else
	{
		var_09 = var_08 + param_02;
	}

	var_0A = 0;
	if(var_09 >= var_08)
	{
		var_0B = 1;
		var_0A = var_09 - var_08;
		var_09 = var_08;
	}
	else
	{
		var_0B = 0;
	}

	if(var_07 < var_09)
	{
		maps\mp\gametypes\_hud_util::ch_setprogress(param_00,var_09);
	}

	if(var_0B)
	{
		thread func_3D08(param_00,var_03);
		maps\mp\_matchdata::func_4F15(param_00,var_03);
		if(var_04)
		{
			func_7C80(param_00);
		}
		else
		{
			storecompletedchallenge(param_00);
		}

		if(var_04)
		{
			if(!isdefined(level.challengeinfo[param_00]["weapon"]) || var_03 >= 4)
			{
				maps\mp\gametypes\_rank::giveunlockpoints(1,0);
			}
		}

		var_03++;
		maps\mp\gametypes\_hud_util::func_1AA8(param_00,var_03);
		self.challengedata[param_00] = var_03;
		if(var_04)
		{
			if(var_03 > level.challengeinfo[param_00]["targetval"].size)
			{
				if(!isdefined(self.operationsmaxed))
				{
					self.operationsmaxed = [];
				}

				self.operationsmaxed[param_00] = 1;
				if(isdefined(level.challengeinfo[param_00]["weapon"]))
				{
					maps\mp\gametypes\_hud_util::ch_setprogress(param_00,var_0A);
				}
			}

			if(!isdefined(level.challengeinfo[param_00]["weapon"]))
			{
				maps\mp\gametypes\_hud_util::ch_setprogress(param_00,var_0A);
			}

			var_0C = self getrankedplayerdata("challengeState","ch_weekly_2");
			self setrankedplayerdata("challengeState","ch_weekly_2",var_0C + 1);
		}

		thread maps\mp\gametypes\_hud_message::func_1ACA(param_00);
	}
}

//Function Number: 61
storecompletedchallenge(param_00)
{
	if(!isdefined(self.challengescompleted))
	{
		self.challengescompleted = [];
	}

	var_01 = 0;
	foreach(var_03 in self.challengescompleted)
	{
		if(var_03 == param_00)
		{
			var_01 = 1;
		}
	}

	if(!var_01)
	{
		self.challengescompleted[self.challengescompleted.size] = param_00;
	}
}

//Function Number: 62
func_7C80(param_00)
{
	if(!isdefined(self.operationscompleted))
	{
		self.operationscompleted = [];
	}

	var_01 = 0;
	foreach(var_03 in self.operationscompleted)
	{
		if(var_03 == param_00)
		{
			var_01 = 1;
			break;
		}
	}

	if(!var_01)
	{
		self.operationscompleted[self.operationscompleted.size] = param_00;
	}
}

//Function Number: 63
func_3D08(param_00,param_01)
{
	self endon("disconnect");
	wait(0.25);
	var_02 = "challenge";
	if(func_4923(param_00))
	{
		var_02 = "operation";
	}

	maps\mp\gametypes\_rank::giverankxp(var_02,level.challengeinfo[param_00]["reward"][param_01],undefined,undefined,param_00);
}

//Function Number: 64
func_86D5()
{
	self.challengedata = [];
	self endon("disconnect");
	if(!func_5126())
	{
	}

	var_00 = 0;
	foreach(var_05, var_02 in level.challengeinfo)
	{
		var_00++;
		if(var_00 % 20 == 0)
		{
			wait(0.05);
		}

		self.challengedata[var_05] = 0;
		var_03 = var_02["index"];
		var_04 = maps\mp\gametypes\_hud_util::ch_getstate(var_05);
		if(var_04 == 0)
		{
			maps\mp\gametypes\_hud_util::func_1AA8(var_05,1);
			var_04 = 1;
		}

		self.challengedata[var_05] = var_04;
	}

	func_915F();
}

//Function Number: 65
func_48E6(param_00)
{
	return tablelookup("mp/unlockTable.csv",0,param_00,0) != "";
}

//Function Number: 66
func_3A4E(param_00)
{
	return tablelookup("mp/allChallengesTable.csv",0,param_00,5);
}

//Function Number: 67
func_3A50(param_00)
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

	var_01 = func_3A4E(param_00);
	if(isdefined(var_01))
	{
		if(maps\mp\gametypes\_class::func_49A6(var_01,0) || maps\mp\gametypes\_class::isvalidsecondary(var_01,0))
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 70
getweaponfromchallenge(param_00)
{
	return func_3A4E(param_00);
}

//Function Number: 71
isreticlechallenge(param_00)
{
	var_01 = func_3A4E(param_00);
	return var_01 == "acog" || var_01 == "eotech" || var_01 == "hybrid" || var_01 == "reflex";
}

//Function Number: 72
getsightfromreticlechallenge(param_00)
{
	return func_3A4E(param_00);
}

//Function Number: 73
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
	var_03 = strtok(var_02,"_");
	var_04 = undefined;
	if(isdefined(var_03[2]) && maps\mp\_utility::isattachment(var_03[2]))
	{
		var_04 = var_03[2];
	}

	return var_04;
}

//Function Number: 74
iskillstreakchallenge(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = func_3A4E(param_00);
	if(isdefined(var_01) && var_01 == "killstreaks_assault" || var_01 == "killstreaks_support")
	{
		return 1;
	}

	return 0;
}

//Function Number: 75
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

//Function Number: 76
func_4923(param_00)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	var_01 = func_3A4E(param_00);
	if(isdefined(var_01))
	{
		if(var_01 == "perk_slot_0" || var_01 == "perk_slot_1" || var_01 == "perk_slot_2" || var_01 == "proficiency" || var_01 == "equipment" || var_01 == "special_equipment" || var_01 == "attachment" || var_01 == "prestige" || var_01 == "final_killcam" || var_01 == "basic" || var_01 == "humiliation" || var_01 == "precision" || var_01 == "revenge" || var_01 == "elite" || var_01 == "intimidation" || var_01 == "operations" || maps\mp\_utility::func_4971(var_01,"killstreaks_"))
		{
			return 1;
		}
	}

	if(isweaponchallenge(param_00))
	{
		return 1;
	}

	return 0;
}

//Function Number: 77
func_1AC3(param_00,param_01,param_02)
{
	var_03 = tablelookup(param_00,0,param_01,9 + param_02 - 1 * 2);
	return int(var_03);
}

//Function Number: 78
challenge_rewardval(param_00,param_01,param_02)
{
	var_03 = tablelookup(param_00,0,param_01,10 + param_02 - 1 * 2);
	return int(var_03);
}

//Function Number: 79
challenge_sprewardval(param_00,param_01,param_02)
{
	var_03 = tablelookup(param_00,0,param_01,27 + param_02 - 1);
	return int(var_03);
}

//Function Number: 80
buildchallengetableinfo(param_00,param_01)
{
	var_02 = 0;
	var_03 = 0;
	var_04 = tablelookupbyrow(param_00,0,0);
	for(var_02 = 1;var_04 != "";var_02++)
	{
		level.challengeinfo[var_04] = [];
		level.challengeinfo[var_04]["index"] = var_02 - 1;
		level.challengeinfo[var_04]["type"] = param_01;
		level.challengeinfo[var_04]["targetval"] = [];
		level.challengeinfo[var_04]["reward"] = [];
		if(isreticlechallenge(var_04))
		{
			var_05 = getsightfromreticlechallenge(var_04);
			if(isdefined(var_05))
			{
				level.challengeinfo[var_04]["sight"] = var_05;
			}
		}
		else if(func_4923(var_04))
		{
			level.challengeinfo[var_04]["operation"] = 1;
			level.challengeinfo[var_04]["spReward"] = [];
			if(iskillstreakchallenge(var_04))
			{
				var_06 = getkillstreakfromchallenge(var_04);
				if(isdefined(var_06))
				{
					level.challengeinfo[var_04]["killstreak"] = var_06;
				}
			}

			if(isweaponchallenge(var_04))
			{
				var_07 = getweaponfromchallenge(var_04);
				if(isdefined(var_07))
				{
					level.challengeinfo[var_04]["weapon"] = var_07;
				}
			}
		}

		for(var_08 = 1;var_08 < 11;var_08++)
		{
			var_09 = func_1AC3(param_00,var_04,var_08);
			var_0A = challenge_rewardval(param_00,var_04,var_08);
			if(var_09 == 0)
			{
				break;
			}

			level.challengeinfo[var_04]["targetval"][var_08] = var_09;
			level.challengeinfo[var_04]["reward"][var_08] = var_0A;
			if(isdefined(level.challengeinfo[var_04]["spReward"]))
			{
				var_0B = challenge_sprewardval(param_00,var_04,var_08);
				level.challengeinfo[var_04]["spReward"][var_08] = var_0B;
			}

			var_03 = var_03 + var_0A;
		}

		var_04 = tablelookupbyrow(param_00,var_02,0);
	}

	return int(var_03);
}

//Function Number: 81
func_1857()
{
	level.challengeinfo = [];
	var_00 = 0;
	var_00 = var_00 + buildchallengetableinfo("mp/allChallengesTable.csv",0);
}

//Function Number: 82
monitorprocesschallenge()
{
	self endon("disconnect");
	level endon("game_end");
	for(;;)
	{
		if(!func_5126())
		{
		}

		self waittill("process",var_00);
		func_61CE(var_00);
	}
}

//Function Number: 83
func_539F()
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
				maps\mp\killstreaks\_killstreaks::func_3CDB("3streak");
				break;
	
			case 4:
				maps\mp\killstreaks\_killstreaks::func_3CDB("4streak");
				break;
	
			case 5:
				maps\mp\killstreaks\_killstreaks::func_3CDB("5streak");
				break;
	
			case 6:
				maps\mp\killstreaks\_killstreaks::func_3CDB("6streak");
				break;
	
			case 7:
				maps\mp\killstreaks\_killstreaks::func_3CDB("7streak");
				break;
	
			case 8:
				maps\mp\killstreaks\_killstreaks::func_3CDB("8streak");
				break;
	
			case 9:
				maps\mp\killstreaks\_killstreaks::func_3CDB("9streak");
				break;
	
			case 10:
				maps\mp\killstreaks\_killstreaks::func_3CDB("10streak");
				break;
	
			default:
				break;
		}

		if(var_00 == 10 && self.killstreaks.size == 0)
		{
			func_61CE("ch_theloner");
			continue;
		}

		if(var_00 == 9)
		{
			if(isdefined(self.killstreaks[7]) && isdefined(self.killstreaks[8]) && isdefined(self.killstreaks[9]))
			{
				func_61CE("ch_6fears7");
			}
		}
	}
}

//Function Number: 84
func_539D()
{
	self endon("disconnect");
	level endon("game_end");
	for(;;)
	{
		self waittill("destroyed_killstreak",var_00);
		if(self isitemunlocked("specialty_blindeye") && maps\mp\_utility::_hasperk("specialty_blindeye"))
		{
			func_61CE("ch_blindeye_pro");
		}
	}
}

//Function Number: 85
func_37A9(param_00,param_01)
{
	switch(param_00)
	{
		case "hijacker_airdrop":
			func_61CE("ch_smoothcriminal");
			break;

		case "hijacker_airdrop_mega":
			func_61CE("ch_poolshark");
			break;

		case "wargasm":
			func_61CE("ch_wargasm");
			break;

		case "weapon_assault":
			func_61CE("ch_surgical_assault");
			break;

		case "weapon_smg":
			func_61CE("ch_surgical_smg");
			break;

		case "weapon_lmg":
			func_61CE("ch_surgical_lmg");
			break;

		case "weapon_dmr":
			func_61CE("ch_surgical_dmr");
			break;

		case "weapon_sniper":
			func_61CE("ch_surgical_sniper");
			break;

		case "weapon_shotgun":
			func_61CE("ch_surgical_shotgun");
			break;

		case "shield_damage":
			if(!maps\mp\_utility::isjuggernaut())
			{
				func_61CE("ch_iw6_riotshield_damage",param_01);
			}
			break;

		case "shield_bullet_hits":
			if(!maps\mp\_utility::isjuggernaut())
			{
				func_61CE("ch_shield_bullet",param_01);
			}
			break;

		case "shield_explosive_hits":
			if(!maps\mp\_utility::isjuggernaut())
			{
				func_61CE("ch_iw6_riotshield_explosive",param_01);
			}
			break;
	}
}

//Function Number: 86
func_5FB0()
{
	var_00 = self getweaponslistprimaries();
	foreach(var_02 in var_00)
	{
		if(self getweaponammoclip(var_02))
		{
			if(!maps\mp\gametypes\_weapons::func_494E(var_02) && !maps\mp\gametypes\_weapons::isknifeonly(var_02))
			{
				return 1;
			}
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

//Function Number: 87
func_536D()
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

//Function Number: 88
func_539B()
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

//Function Number: 89
func_53A7()
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
				func_61CE("ch_fastmantle");
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

//Function Number: 90
func_53DA()
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

		if(maps\mp\_utility::func_48F7(var_01))
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

//Function Number: 91
func_538D()
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

//Function Number: 92
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

//Function Number: 93
func_53A9()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("triggeredExpl",var_00);
		thread func_8AD3();
	}
}

//Function Number: 94
func_8AD3()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(level.delayminetime + 2);
	func_61CE("ch_delaymine");
}

//Function Number: 95
monitorreload()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("reload");
		if(self issprinting())
		{
			self.sprintreloadtimestamp = gettime() + 3000;
		}

		var_00 = self getcurrentweapon();
		self.lastreloadedweapon = var_00;
		switch(weaponclass(var_00))
		{
			case "sniper":
				self.reloadtimestamp = gettime() + 5000;
				break;
	
			default:
				self.reloadtimestamp = gettime() + 3000;
				break;
		}

		self.killsthismag[var_00] = 0;
	}
}

//Function Number: 96
monitorsprintslide()
{
	self endon("disconnect");
	for(;;)
	{
		var_00 = common_scripts\utility::func_8B33("sprint_slide_begin","sprint_slide_end","death");
		if(!isalive(self))
		{
			self.issliding = undefined;
			self.isslidinggraceperiod = gettime() - 1;
			continue;
		}

		if(var_00 == "sprint_slide_end")
		{
			self.issliding = undefined;
			self.isslidinggraceperiod = gettime() + 1000;
			continue;
		}

		if(var_00 == "sprint_slide_begin")
		{
			self.issliding = 1;
		}
	}
}

//Function Number: 97
playerissprintsliding()
{
	return isdefined(self.issliding) || isdefined(self.isslidinggraceperiod) && gettime() <= self.isslidinggraceperiod;
}

//Function Number: 98
func_93AD()
{
	return isdefined(self.issliding) || isdefined(self.isslidinggraceperiod) && gettime() <= self.isslidinggraceperiod + 1000;
}

//Function Number: 99
func_74BC(param_00)
{
	return self isitemunlocked(param_00) && maps\mp\_utility::_hasperk(param_00);
}

//Function Number: 100
processweaponattachmentchallenge(param_00,param_01)
{
	func_61CE("ch_" + param_01);
}

//Function Number: 101
processfinalkillchallenges(param_00,param_01)
{
	if(!func_5126() || isai(param_00))
	{
	}

	param_00 func_61CE("ch_theedge");
	if(!isai(param_01))
	{
		param_01 func_61CE("ch_starryeyed");
	}

	if(isdefined(param_00.modifiers["revenge"]))
	{
		param_00 func_61CE("ch_moneyshot");
	}

	if(isdefined(param_01) && isdefined(param_01.explosiveinfo) && isdefined(param_01.explosiveinfo["stickKill"]) && param_01.explosiveinfo["stickKill"])
	{
		param_00 func_61CE("ch_stickman");
	}

	if(isdefined(param_01.attackerdata[param_00.guid]) && isdefined(param_01.attackerdata[param_00.guid].smeansofdeath) && isdefined(param_01.attackerdata[param_00.guid].weapon) && issubstr(param_01.attackerdata[param_00.guid].smeansofdeath,"MOD_MELEE") && maps\mp\gametypes\_weapons::func_494E(param_01.attackerdata[param_00.guid].weapon))
	{
		param_00 func_61CE("ch_owned");
	}

	var_02 = param_00.team;
	if(!level.teambased)
	{
		var_02 = "none";
	}

	switch(level.finalkillcam_sweapon[var_02])
	{
		case "sentry_minigun_mp":
			param_00 func_61CE("ch_absentee");
			break;

		case "remote_tank_projectile_mp":
			param_00 func_61CE("ch_gryphonattack");
			break;

		case "heli_pilot_turret_mp":
			param_00 func_61CE("ch_hotshot");
			break;

		case "iw6_gm6helisnipe_mp_gm6scope":
			param_00 func_61CE("ch_heli_sniper_finalkill");
			break;

		case "switch_blade_child_mp":
		case "drone_hive_projectile_mp":
			param_00 func_61CE("ch_noescape");
			break;

		case "ball_drone_gun_mp":
			param_00 func_61CE("ch_thanksbuddy");
			break;

		case "odin_projectile_small_rod_mp":
		case "odin_projectile_large_rod_mp":
			param_00 func_61CE("ch_lokikiller");
			break;

		case "hind_missile_mp":
		case "hind_bomb_mp":
		case "cobra_20mm_mp":
			param_00 func_61CE("ch_og");
			break;

		case "guard_dog_mp":
			param_00 func_61CE("ch_bestinshow");
			break;

		case "ims_projectile_mp":
			param_00 func_61CE("ch_outsmarted");
			break;

		case "iw6_p226jugg_mp":
		case "iw6_minigunjugg_mp":
		case "mortar_shelljugg_mp":
			param_00 func_61CE("ch_painless");
			break;

		case "iw6_knifeonlyjugg_mp":
		case "throwingknifejugg_mp":
			param_00 func_61CE("ch_untouchable");
			break;

		case "agent_support_mp":
			param_00 func_61CE("ch_bestmates");
			break;

		default:
			break;
	}
}

//Function Number: 102
processweaponattachmentchallenge_acog(param_00,param_01,param_02)
{
	if(maps\mp\_utility::isplayerads())
	{
		func_61CE("ch_" + param_01);
		if(self getstance() == "prone")
		{
			func_61CE("ch_" + param_01 + "_prone");
		}

		checkchallengekillmodifier(param_02,"longshot",param_01);
		checkchallengekillmodifier(param_02,"headshot",param_01);
		if(self.recentkillcount == 2)
		{
			func_61CE("ch_" + param_01 + "_double");
		}

		if(isdefined(param_02.modifiers["oneshotkill"]))
		{
			func_61CE("ch_acog_oneshot");
		}
	}
}

//Function Number: 103
processweaponattachmentchallenge_eotech(param_00,param_01,param_02)
{
	if(maps\mp\_utility::isplayerads())
	{
		func_61CE("ch_" + param_01);
		if(maps\mp\_utility::weaponisfiretypeburst(param_02.sweapon))
		{
			func_61CE("ch_" + param_01 + "_burst");
		}

		if(self isleaning())
		{
			func_61CE("ch_" + param_01 + "_lean");
		}

		checkchallengekillmodifier(param_02,"headshot",param_01);
		if(self.recentkillcount == 2)
		{
			func_61CE("ch_" + param_01 + "_double");
		}

		checkconsecutivechallenge(param_02.sweapon,param_01);
	}
}

//Function Number: 104
processweaponattachmentchallenge_hybrid(param_00,param_01,param_02)
{
	if(maps\mp\_utility::isplayerads())
	{
		func_61CE("ch_" + param_01);
		if(param_02.hybridscopestate)
		{
			func_61CE("ch_hybrid_zoomout");
			checkchallengekillmodifier(param_02,"headshot",param_01);
		}
		else
		{
			func_61CE("ch_hybrid_zoomin");
			checkchallengekillmodifier(param_02,"longshot",param_01);
		}

		checkpenetrationchallenge(param_02.victim,param_01);
	}
}

//Function Number: 105
processweaponattachmentchallenge_reflex(param_00,param_01,param_02)
{
	if(maps\mp\_utility::isplayerads())
	{
		func_61CE("ch_" + param_01);
		if(self getstance() == "crouch")
		{
			func_61CE("ch_" + param_01 + "_crouch");
		}

		var_03 = self getvelocity();
		if(lengthsquared(var_03) > 16)
		{
			func_61CE("ch_reflex_moving");
		}

		if(maps\mp\_utility::weaponhasattachment(param_02.sweapon,"ammoslug"))
		{
			func_61CE("ch_" + param_01 + "_ammoslug");
		}

		checkchallengekillmodifier(param_02,"headshot",param_01);
		if(maps\mp\_utility::func_4971(param_02.sweapon,"alt_") && maps\mp\_utility::weaponhasattachment(param_02.sweapon,"shotgun"))
		{
			func_61CE("ch_" + param_01 + "_altshotgun");
		}
	}
}

//Function Number: 106
processweaponclasschallenge_ar(param_00,param_01)
{
	func_61CE("ch_" + param_00);
	if(self getstance() == "crouch")
	{
		func_61CE("ch_" + param_00 + "_crouch");
	}

	checkchallengekillmodifier(param_01,"defender",param_00);
	if(maps\mp\_utility::weapongetnumattachments(param_01.sweapon) == 0)
	{
		func_61CE("ch_" + param_00 + "_noattach");
	}

	checkchallengekillmodifier(param_01,"longshot",param_00);
	checkconsecutivechallenge(param_01.sweapon,param_00);
	checkchallengekillmodifier(param_01,"pointblank",param_00);
	if(hasreloadedrecently())
	{
		func_61CE("ch_" + param_00 + "_reload");
	}

	if(func_93AD())
	{
		func_61CE("ch_" + param_00 + "_sliding");
	}

	checkchallengeisleaning(param_00);
}

//Function Number: 107
processweaponclasschallenge_smg(param_00,param_01)
{
	func_61CE("ch_" + param_00);
	if(self getstance() == "crouch")
	{
		func_61CE("ch_" + param_00 + "_crouch");
	}

	checkchallengekillmodifier(param_01,"defender",param_00);
	if(maps\mp\_utility::weapongetnumattachments(param_01.sweapon) == 0)
	{
		func_61CE("ch_" + param_00 + "_noattach");
	}

	if(!maps\mp\_utility::isplayerads())
	{
		func_61CE("ch_" + param_00 + "_hipfire");
	}

	checkconsecutivechallenge(param_01.sweapon,param_00);
	checkchallengekillmodifier(param_01,"pointblank",param_00);
	if(hasreloadedrecently())
	{
		func_61CE("ch_" + param_00 + "_reload");
	}

	if(func_93AD())
	{
		func_61CE("ch_" + param_00 + "_sliding");
	}

	checkchallengeisleaning(param_00);
}

//Function Number: 108
processweaponclasschallenge_lmg(param_00,param_01)
{
	func_61CE("ch_" + param_00);
	if(self getstance() == "crouch")
	{
		func_61CE("ch_" + param_00 + "_crouch");
	}

	checkchallengekillmodifier(param_01,"defender",param_00);
	if(maps\mp\_utility::weapongetnumattachments(param_01.sweapon) == 0)
	{
		func_61CE("ch_" + param_00 + "_noattach");
	}

	if(!maps\mp\_utility::isplayerads())
	{
		func_61CE("ch_" + param_00 + "_hipfire");
	}

	checkconsecutivechallenge(param_01.sweapon,param_00);
	checkchallengekillmodifier(param_01,"pointblank",param_00);
	checkpenetrationchallenge(param_01.victim,param_00);
	if(func_93AD())
	{
		func_61CE("ch_" + param_00 + "_sliding");
	}

	if(param_01.smeansofdeath == "MOD_HEAD_SHOT" && checkcostumechallenge(param_01.victim,"mp_body_elite_pmc_lmg_b"))
	{
		func_61CE("ch_ghostbusted");
	}

	checkchallengeisleaning(param_00);
}

//Function Number: 109
processweaponclasschallenge_dmr(param_00,param_01)
{
	func_61CE("ch_" + param_00);
	if(self getstance() == "crouch")
	{
		func_61CE("ch_" + param_00 + "_crouch");
	}

	checkchallengekillmodifier(param_01,"defender",param_00);
	checkchallengekillmodifier(param_01,"longshot",param_00);
	checkchallengekillmodifier(param_01,"headshot",param_00);
	checkchallengekillmodifier(param_01,"pointblank",param_00);
	checkconsecutivechallenge(param_01.sweapon,param_00);
	if(maps\mp\_utility::weapongetnumattachments(param_01.sweapon) == 0)
	{
		func_61CE("ch_" + param_00 + "_noattach");
	}

	if(hasreloadedrecently())
	{
		func_61CE("ch_" + param_00 + "_reload");
	}

	checkchallengeisleaning(param_00);
}

//Function Number: 110
processweaponclasschallenge_sniper(param_00,param_01)
{
	func_61CE("ch_sniper_kill");
	func_61CE("ch_" + param_00);
	if(self getstance() == "crouch")
	{
		func_61CE("ch_" + param_00 + "_crouch");
	}

	if(maps\mp\_utility::weapongetnumattachments(param_01.sweapon) == 0)
	{
		func_61CE("ch_" + param_00 + "_noattach");
	}

	checkchallengekillmodifier(param_01,"defender",param_00);
	if(self getstance() == "prone")
	{
		func_61CE("ch_" + param_00 + "_prone");
	}

	checkchallengekillmodifier(param_01,"oneshotkill",param_00);
	checkconsecutivechallenge(param_01.sweapon,param_00);
	checkchallengekillmodifier(param_01,"pointblank",param_00);
	if(hasreloadedrecently())
	{
		func_61CE("ch_" + param_00 + "_reload");
	}

	checkpenetrationchallenge(param_01.victim,param_00);
	checkchallengeisleaning(param_00);
}

//Function Number: 111
processweaponclasschallenge_shotgun(param_00,param_01)
{
	func_61CE("ch_" + param_00);
	if(self getstance() == "crouch")
	{
		func_61CE("ch_" + param_00 + "_crouch");
	}

	checkchallengekillmodifier(param_01,"defender",param_00);
	if(maps\mp\_utility::weapongetnumattachments(param_01.sweapon) == 0)
	{
		func_61CE("ch_" + param_00 + "_noattach");
	}

	if(!maps\mp\_utility::isplayerads())
	{
		func_61CE("ch_" + param_00 + "_hipfire");
	}

	checkconsecutivechallenge(param_01.sweapon,param_00);
	checkchallengekillmodifier(param_01,"pointblank",param_00);
	if(hasreloadedrecently())
	{
		func_61CE("ch_" + param_00 + "_reload");
	}

	if(func_93AD())
	{
		func_61CE("ch_" + param_00 + "_sliding");
	}

	checkchallengekillmodifier(param_01,"headshot",param_00);
}

//Function Number: 112
processweaponclasschallenge_riotshield(param_00,param_01)
{
	func_61CE("ch_" + param_00);
	if(self getstance() == "crouch")
	{
		func_61CE("ch_" + param_00 + "_crouch");
	}

	if(checknumusesofpersistentdata("shieldKillStreak",3))
	{
		func_61CE("ch_" + param_00 + "_consecutive");
	}

	if(hasnoperks())
	{
		func_61CE("ch_" + param_00 + "_noperks");
	}
}

//Function Number: 113
checkchallengekillmodifier(param_00,param_01,param_02)
{
	if(isdefined(param_00.modifiers[param_01]))
	{
		func_61CE("ch_" + param_02 + "_" + param_01);
	}
}

//Function Number: 114
checkchallengeisleaning(param_00)
{
	if(self isleaning())
	{
		func_61CE("ch_" + param_00 + "_leaning");
	}
}

//Function Number: 115
checkpenetrationchallenge(param_00,param_01)
{
	if(param_00.idflags & level.idflags_penetration)
	{
		func_61CE("ch_" + param_01 + "_penetrate");
	}
}

//Function Number: 116
checkconsecutivechallenge(param_00,param_01)
{
	var_02 = self.killsthislifeperweapon[param_00];
	if(isdefined(var_02) && isnumbermultipleof(var_02,3))
	{
		func_61CE("ch_" + param_01 + "_consecutive");
	}
}

//Function Number: 117
checkwaslastweaponriotshield()
{
	var_00 = self getcurrentweapon();
	if(maps\mp\gametypes\_weapons::func_494E(var_00))
	{
		return 1;
	}

	var_01 = common_scripts\utility::func_3B0A();
	return maps\mp\gametypes\_weapons::func_494E(var_01);
}

//Function Number: 118
checkaachallenges(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		if(isdefined(level.odinsettings) && isdefined(level.odinsettings["odin_assault"]) && param_02 == level.odinsettings["odin_assault"].weapon["large_rod"].projectile || param_02 == level.odinsettings["odin_assault"].weapon["small_rod"].projectile)
		{
			param_00 func_61CE("ch_shooting_star");
			return 1;
		}
		else if(maps\mp\_utility::func_8DAC(param_02) == "iw6_maaws_mp")
		{
			param_00 func_61CE("ch_aa_launcher");
		}
		else if(param_02 == "aamissile_projectile_mp")
		{
			param_00 func_61CE("ch_air_superiority");
		}
	}

	param_00 func_61CE("ch_clearskies");
	return 0;
}

//Function Number: 119
checkchallengeextradeadly(param_00)
{
	if(func_74BC("specialty_extra_deadly"))
	{
		if(param_00 == self.loadoutperkequipment)
		{
			func_61CE("ch_extra_deadly");
		}
	}
}

//Function Number: 120
checkcostumechallenge(param_00,param_01)
{
	if(!isai(param_00))
	{
		var_02 = param_00 maps\mp\gametypes\_teams::getplayermodelindex();
		var_03 = param_00 maps\mp\gametypes\_teams::getplayermodelname(var_02);
		return var_03 == param_01;
	}

	return 0;
}

//Function Number: 121
hasreloadedrecently()
{
	return isdefined(self.reloadtimestamp) && gettime() < self.reloadtimestamp;
}

//Function Number: 122
processchallengeforteam(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(var_03.team == param_01)
		{
			var_03 func_61CE(param_00);
		}
	}
}

//Function Number: 123
allowkillchallengeforkillstreak(param_00,param_01)
{
	if(param_00 maps\mp\_utility::isjuggernaut())
	{
		return 1;
	}
	else if(param_01 == "ims_projectile_mp")
	{
		return 1;
	}

	return 0;
}

//Function Number: 124
checknumusesofpersistentdata(param_00,param_01)
{
	var_02 = self.pers[param_00];
	return isnumbermultipleof(var_02,param_01);
}

//Function Number: 125
isnumbermultipleof(param_00,param_01)
{
	return param_00 > 0 && param_00 % param_01 == 0;
}

//Function Number: 126
hasnoperks()
{
	if(isdefined(self.pers["loadoutPerks"]))
	{
		return self.pers["loadoutPerks"].size == 0;
	}

	return 1;
}

//Function Number: 127
func_9160(param_00)
{
	var_01 = level.challengeinfo[param_00]["targetval"].size;
	var_02 = maps\mp\gametypes\_hud_util::ch_getstate(param_00);
	if(var_02 > var_01 + 1)
	{
		maps\mp\gametypes\_hud_util::func_1AA8(param_00,var_01);
		maps\mp\gametypes\_hud_util::ch_setprogress(param_00,0);
	}
}

//Function Number: 128
func_915F()
{
	func_9160("ch_atm");
	func_9160("ch_breakbank");
}