/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\_awards.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 19
 * Decompile Time: 307 ms
 * Timestamp: 4/22/2024 2:15:24 AM
*******************************************************************/

//Function Number: 1
init()
{
	initawards();
	level thread onplayerconnect();
}

//Function Number: 2
onplayerconnect()
{
	for(;;)
	{
		level waittill("connected",var_00);
		if(!isdefined(var_00.pers["stats"]))
		{
			var_00.pers["stats"] = [];
		}

		var_00.stats = var_00.pers["stats"];
		if(!var_00.stats.size)
		{
			foreach(var_03, var_02 in level.awards)
			{
				var_00 maps\mp\_utility::initplayerstat(var_03,level.awards[var_03].defaultvalue);
			}
		}
	}
}

//Function Number: 3
initawards()
{
	initstataward("headshots",0,1,::highesetwinsupdateplayerdata);
	initstataward("multikill",0,1,::highesetwinsupdateplayerdata);
	initstataward("avengekills",0,1,::highesetwinsupdateplayerdata);
	initstataward("comebacks",0,1,::highesetwinsupdateplayerdata);
	initstataward("rescues",0,1,::highesetwinsupdateplayerdata);
	initstataward("longshots",0,1,::highesetwinsupdateplayerdata);
	initstataward("revengekills",0,1,::highesetwinsupdateplayerdata);
	initstataward("bulletpenkills",0,1,::highesetwinsupdateplayerdata);
	initstataward("throwback_kill",0,1,::highesetwinsupdateplayerdata);
	initstataward("firstblood",0,1,::highesetwinsupdateplayerdata);
	initstataward("posthumous",0,1,::highesetwinsupdateplayerdata);
	initstataward("assistedsuicide",0,1,::highesetwinsupdateplayerdata);
	initstataward("buzzkill",0,1,::highesetwinsupdateplayerdata);
	initstataward("oneshotkill",0,1,::highesetwinsupdateplayerdata);
	initstataward("air_to_air_kill",0,1,::highesetwinsupdateplayerdata);
	initstataward("air_to_ground_kill",0,1,::highesetwinsupdateplayerdata);
	initstataward("ground_to_air_kill",0,1,::highesetwinsupdateplayerdata);
	initstataward("doublekill",0,1,::highesetwinsupdateplayerdata);
	initstataward("triplekill",0,1,::highesetwinsupdateplayerdata);
	initstataward("fourkill",0,1,::highesetwinsupdateplayerdata);
	initstataward("fivekill",0,1,::highesetwinsupdateplayerdata);
	initstataward("sixkill",0,1,::highesetwinsupdateplayerdata);
	initstataward("sevenkill",0,1,::highesetwinsupdateplayerdata);
	initstataward("eightkill",0,1,::highesetwinsupdateplayerdata);
	initstataward("hijacker",0,1,::highesetwinsupdateplayerdata);
	initstataward("backstab",0,1,::highesetwinsupdateplayerdata);
	initstataward("5killstreak",0,1,::highesetwinsupdateplayerdata);
	initstataward("10killstreak",0,1,::highesetwinsupdateplayerdata);
	initstataward("15killstreak",0,1,::highesetwinsupdateplayerdata);
	initstataward("20killstreak",0,1,::highesetwinsupdateplayerdata);
	initstataward("25killstreak",0,1,::highesetwinsupdateplayerdata);
	initstataward("30killstreak",0,1,::highesetwinsupdateplayerdata);
	initstataward("30pluskillstreak",0,1,::highesetwinsupdateplayerdata);
	initstataward("pointblank",0,1,::highesetwinsupdateplayerdata);
	initstataward("firstplacekill",0,1,::highesetwinsupdateplayerdata);
	initstataward("boostslamkill",0,1,::highesetwinsupdateplayerdata);
	initstataward("assault",0,1,::highesetwinsupdateplayerdata);
	initstataward("defends",0,1,::highesetwinsupdateplayerdata);
	initstataward("exo_knife_kill",0,1,::highesetwinsupdateplayerdata);
	initstataward("exo_knife_recall_kill",0,1,::highesetwinsupdateplayerdata);
	initstataward("near_death_kill",0,1,::highesetwinsupdateplayerdata);
	initstataward("slide_kill",0,1,::highesetwinsupdateplayerdata);
	initstataward("flash_kill",0,1,::highesetwinsupdateplayerdata);
	initstataward("riot_kill",0,1,::highesetwinsupdateplayerdata);
	initstataward("melee_air_to_air",0,1,::highesetwinsupdateplayerdata);
	initstataward("assist_riot_shield",0,1,::highesetwinsupdateplayerdata);
	initstataward("semtex_stick",0,1,::highesetwinsupdateplayerdata);
	initstataward("stuck_with_explosive",0,1,::highesetwinsupdateplayerdata);
	initstataward("crossbow_stick",0,1,::highesetwinsupdateplayerdata);
	initstataward("multiKillOneBullet",0,1,::highesetwinsupdateplayerdata);
	initstataward("think_fast",0,1,::highesetwinsupdateplayerdata);
	initstataward("take_and_kill",0,1,::highesetwinsupdateplayerdata);
	initstataward("four_play",0,1,::highesetwinsupdateplayerdata);
	initstataward("sharepackage",0,1,::highesetwinsupdateplayerdata);
	initstataward("map_killstreak",0,1,::highesetwinsupdateplayerdata);
	initstataward("killstreak_tag",0,1,::highesetwinsupdateplayerdata);
	initstataward("killstreak_join",0,1,::highesetwinsupdateplayerdata);
	initstataward("kills",0,0,::highestwins);
	initstataward("longestkillstreak",0,0,::highestwins);
	initstataward("knifekills",0,0,::highestwins);
	initstataward("kdratio",0,0,::highestwins);
	initstataward("deaths",0,0,::lowestwithhalfplayedtime);
	initstataward("assists",0,0,::highestwins);
	initstataward("totalGameScore",0,0,::highestwins);
	initstataward("scorePerMinute",0,0,::highestwins);
	initstataward("mostScorePerLife",0,0,::highestwins);
	initstataward("killStreaksUsed",0,0,::highestwins);
	initstataward("humiliation",0,1,::highesetwinsupdateplayerdata);
	initstataward("regicide",0,1,::highesetwinsupdateplayerdata);
	initstataward("gunslinger",0,1,::highesetwinsupdateplayerdata);
	initstataward("dejavu",0,1,::highesetwinsupdateplayerdata);
	initstataward("levelup",0,1,::highesetwinsupdateplayerdata);
	initstataward("omegaman",0,1,::highesetwinsupdateplayerdata);
	initstataward("plague",0,1,::highesetwinsupdateplayerdata);
	initstataward("patientzero",0,1,::highesetwinsupdateplayerdata);
	initstataward("careless",0,1,::highesetwinsupdateplayerdata);
	initstataward("survivor",0,1,::highesetwinsupdateplayerdata);
	initstataward("contagious",0,1,::highesetwinsupdateplayerdata);
	initstataward("flagscaptured",0,1,::highesetwinsupdateplayerdata);
	initstataward("flagsreturned",0,1,::highesetwinsupdateplayerdata);
	initstataward("flagcarrierkills",0,1,::highesetwinsupdateplayerdata);
	initstataward("flagscarried",0,1,::highesetwinsupdateplayerdata);
	initstataward("killsasflagcarrier",0,1,::highesetwinsupdateplayerdata);
	initstataward("pointscaptured",0,1,::highesetwinsupdateplayerdata);
	initstataward("kill_while_capture",0,1,::highesetwinsupdateplayerdata);
	initstataward("opening_move",0,1,::highesetwinsupdateplayerdata);
	initstataward("hp_secure",0,1,::highesetwinsupdateplayerdata);
	initstataward("targetsdestroyed",0,1,::highesetwinsupdateplayerdata);
	initstataward("bombsplanted",0,1,::highesetwinsupdateplayerdata);
	initstataward("bombsdefused",0,1,::highesetwinsupdateplayerdata);
	initstataward("ninja_defuse",0,1,::highesetwinsupdateplayerdata);
	initstataward("last_man_defuse",0,1,::highesetwinsupdateplayerdata);
	initstataward("elimination",0,1,::highesetwinsupdateplayerdata);
	initstataward("last_man_standing",0,1,::highesetwinsupdateplayerdata);
	initstataward("sr_tag_elimination",0,1,::highesetwinsupdateplayerdata);
	initstataward("sr_tag_revive",0,1,::highesetwinsupdateplayerdata);
	initstataward("killsconfirmed",0,1,::highesetwinsupdateplayerdata);
	initstataward("killsdenied",0,1,::highesetwinsupdateplayerdata);
	initstataward("kill_denied_retrieved",0,1,::highesetwinsupdateplayerdata);
	initstataward("tag_collector",0,1,::highesetwinsupdateplayerdata);
	initstataward("touchdown",0,1,::highesetwinsupdateplayerdata);
	initstataward("fieldgoal",0,1,::highesetwinsupdateplayerdata);
	initstataward("interception",0,1,::highesetwinsupdateplayerdata);
	initstataward("kill_with_ball",0,1,::highesetwinsupdateplayerdata);
	initstataward("ball_score_assist",0,1,::highesetwinsupdateplayerdata);
	initstataward("pass_kill_pickup",0,1,::highesetwinsupdateplayerdata);
	initstataward("killedBallCarrier",0,1,::highesetwinsupdateplayerdata);
	initstataward("uav_destroyed",0,1,::highesetwinsupdateplayerdata);
	initstataward("warbird_destroyed",0,1,::highesetwinsupdateplayerdata);
	initstataward("paladin_destroyed",0,1,::highesetwinsupdateplayerdata);
	initstataward("vulcan_destroyed",0,1,::highesetwinsupdateplayerdata);
	initstataward("goliath_destroyed",0,1,::highesetwinsupdateplayerdata);
	initstataward("missile_strike_destroyed",0,1,::highesetwinsupdateplayerdata);
	initstataward("sentry_gun_destroyed",0,1,::highesetwinsupdateplayerdata);
	initstataward("strafing_run_destroyed",0,1,::highesetwinsupdateplayerdata);
	initstataward("assault_drone_destroyed",0,1,::highesetwinsupdateplayerdata);
	initstataward("recon_drone_destroyed",0,1,::highesetwinsupdateplayerdata);
	initstataward("map_killstreak_destroyed",0,1,::highesetwinsupdateplayerdata);
	initstataward("assist_killstreak_destroyed",0,1,::highesetwinsupdateplayerdata);
	initstataward("warbird_kill",0,1,::highesetwinsupdateplayerdata);
	initstataward("paladin_kill",0,1,::highesetwinsupdateplayerdata);
	initstataward("vulcan_kill",0,1,::highesetwinsupdateplayerdata);
	initstataward("goliath_kill",0,1,::highesetwinsupdateplayerdata);
	initstataward("airdrop_kill",0,1,::highesetwinsupdateplayerdata);
	initstataward("airdrop_trap_kill",0,1,::highesetwinsupdateplayerdata);
	initstataward("missile_strike_kill",0,1,::highesetwinsupdateplayerdata);
	initstataward("sentry_gun_kill",0,1,::highesetwinsupdateplayerdata);
	initstataward("strafing_run_kill",0,1,::highesetwinsupdateplayerdata);
	initstataward("assault_drone_kill",0,1,::highesetwinsupdateplayerdata);
	initstataward("map_killstreak_kill",0,1,::highesetwinsupdateplayerdata);
	initstataward("coop_killstreak_kill",0,1,::highesetwinsupdateplayerdata);
	initstataward("uav_earned",0,1,::highesetwinsupdateplayerdata);
	initstataward("warbird_earned",0,1,::highesetwinsupdateplayerdata);
	initstataward("orbitalsupport_earned",0,1,::highesetwinsupdateplayerdata);
	initstataward("orbital_strike_laser_earned",0,1,::highesetwinsupdateplayerdata);
	initstataward("orbital_carepackage_earned",0,1,::highesetwinsupdateplayerdata);
	initstataward("heavy_exosuit_earned",0,1,::highesetwinsupdateplayerdata);
	initstataward("missile_strike_earned",0,1,::highesetwinsupdateplayerdata);
	initstataward("remote_mg_sentry_turret_earned",0,1,::highesetwinsupdateplayerdata);
	initstataward("strafing_run_airstrike_earned",0,1,::highesetwinsupdateplayerdata);
	initstataward("assault_ugv_earned",0,1,::highesetwinsupdateplayerdata);
	initstataward("recon_ugv_earned",0,1,::highesetwinsupdateplayerdata);
	initstataward("emp_earned",0,1,::highesetwinsupdateplayerdata);
	initstataward("numMatchesRecorded",0,0,::highestwins);
}

//Function Number: 4
initstataward(param_00,param_01,param_02,param_03,param_04,param_05)
{
	level.awards[param_00] = spawnstruct();
	level.awards[param_00].defaultvalue = param_01;
	if(isdefined(param_03))
	{
		level.awards[param_00].process = param_03;
	}

	if(isdefined(param_02))
	{
		level.awards[param_00].saveonupdate = param_02;
	}

	if(isdefined(param_04))
	{
		level.awards[param_00].var1 = param_04;
	}

	if(isdefined(param_05))
	{
		level.awards[param_00].var2 = param_05;
	}
}

//Function Number: 5
setpersonalbestifgreater(param_00)
{
	var_01 = self getcommonplayerdata("bests",param_00);
	var_02 = maps\mp\_utility::getplayerstat(param_00);
	var_02 = getformattedvalue(param_00,var_02);
	if(var_01 == 0 || var_02 > var_01)
	{
		self setcommonplayerdata("bests",param_00,var_02);
	}
}

//Function Number: 6
setpersonalbestiflower(param_00)
{
	var_01 = self getcommonplayerdata("bests",param_00);
	var_02 = maps\mp\_utility::getplayerstat(param_00);
	var_02 = getformattedvalue(param_00,var_02);
	if(var_01 == 0 || var_02 < var_01)
	{
		self setcommonplayerdata("bests",param_00,var_02);
	}
}

//Function Number: 7
calculatekd(param_00)
{
	var_01 = param_00 maps\mp\_utility::getplayerstat("kills");
	var_02 = param_00 maps\mp\_utility::getplayerstat("deaths");
	if(var_02 == 0)
	{
		var_02 = 1;
	}

	param_00 maps\mp\_utility::setplayerstat("kdratio",var_01 / var_02);
}

//Function Number: 8
gettotalscore(param_00)
{
	var_01 = param_00.score;
	if(!level.teambased)
	{
		var_01 = param_00.extrascore0;
	}

	return var_01;
}

//Function Number: 9
calculatespm(param_00)
{
	if(param_00.timeplayed["total"] < 1)
	{
		return;
	}

	var_01 = gettotalscore(param_00);
	var_02 = param_00.timeplayed["total"];
	var_03 = var_01 / var_02 / 60;
	param_00 maps\mp\_utility::setplayerstat("totalGameScore",var_01);
	param_00 maps\mp\_utility::setplayerstat("scorePerMinute",var_03);
}

//Function Number: 10
assignawards()
{
	foreach(var_01 in level.players)
	{
		if(!var_01 maps\mp\_utility::rankingenabled())
		{
			return;
		}

		var_01 maps\mp\_utility::incplayerstat("numMatchesRecorded",1);
		calculatekd(var_01);
		calculatespm(var_01);
	}

	foreach(var_08, var_04 in level.awards)
	{
		if(!isdefined(level.awards[var_08].process) || isdefined(level.awards[var_08].saveonupdate) && level.awards[var_08].saveonupdate)
		{
			continue;
		}

		var_05 = level.awards[var_08].process;
		var_06 = level.awards[var_08].var1;
		var_07 = level.awards[var_08].var2;
		if(isdefined(var_06) && isdefined(var_07))
		{
			[[ var_05 ]](var_08,var_06,var_07);
			continue;
		}

		if(isdefined(var_06))
		{
			[[ var_05 ]](var_08,var_06);
			continue;
		}

		[[ var_05 ]](var_08);
	}
}

//Function Number: 11
giveaward(param_00,param_01)
{
	param_01 = getformattedvalue(param_00,param_01);
	var_02 = self getcommonplayerdata("round","awards",param_00);
	self setcommonplayerdata("round","awards",param_00,var_02 + param_01);
	if(maps\mp\_utility::practiceroundgame())
	{
		return;
	}

	if(shouldaveragetotal(param_00))
	{
		var_03 = self getcommonplayerdata("awards","numMatchesRecorded");
		var_04 = self getcommonplayerdata("awards",param_00);
		var_05 = var_04 * var_03;
		var_06 = int(var_05 + param_01 / var_03 + 1);
		self setcommonplayerdata("awards",param_00,var_06);
		return;
	}

	var_02 = self getcommonplayerdata("awards",param_00);
	self setcommonplayerdata("awards",param_00,var_02 + param_01);
}

//Function Number: 12
shouldaveragetotal(param_00)
{
	switch(param_00)
	{
		case "scorePerMinute":
		case "kdratio":
			return 1;
	}

	return 0;
}

//Function Number: 13
getformattedvalue(param_00,param_01)
{
	var_02 = tablelookup("mp/awardTable.csv",1,param_00,5);
	switch(var_02)
	{
		case "float":
			param_01 = maps\mp\_utility::limitdecimalplaces(param_01,2);
			param_01 = param_01 * 100;
			break;

		case "multi":
		case "ratio":
		case "time":
		case "count":
		case "distance":
		case "none":
		default:
			break;
	}

	param_01 = int(param_01);
	return param_01;
}

//Function Number: 14
highesetwinsupdateplayerdata(param_00,param_01)
{
	if(maps\mp\_utility::rankingenabled())
	{
		giveaward(param_00,param_01);
		setpersonalbestifgreater(param_00);
	}
}

//Function Number: 15
lowestwinsupdateplayerdata(param_00,param_01)
{
	if(maps\mp\_utility::rankingenabled())
	{
		giveaward(param_00,param_01);
		setpersonalbestiflower(param_00);
	}
}

//Function Number: 16
highestwins(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(var_03 maps\mp\_utility::rankingenabled() && var_03 statvaluechanged(param_00) && !isdefined(param_01) || var_03 maps\mp\_utility::getplayerstat(param_00) >= param_01)
		{
			var_04 = var_03 maps\mp\_utility::getplayerstat(param_00);
			var_03 highesetwinsupdateplayerdata(param_00,var_04);
		}
	}
}

//Function Number: 17
lowestwins(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(var_03 maps\mp\_utility::rankingenabled() && var_03 statvaluechanged(param_00) && !isdefined(param_01) || var_03 maps\mp\_utility::getplayerstat(param_00) <= param_01)
		{
			var_04 = var_03 maps\mp\_utility::getplayerstat(param_00);
			var_03 lowestwinsupdateplayerdata(param_00,var_04);
		}
	}
}

//Function Number: 18
lowestwithhalfplayedtime(param_00)
{
	var_01 = maps\mp\_utility::gettimepassed() / 1000;
	var_02 = var_01 * 0.5;
	foreach(var_04 in level.players)
	{
		if(var_04.hasspawned && var_04.timeplayed["total"] >= var_02)
		{
			var_05 = var_04 maps\mp\_utility::getplayerstat(param_00);
			var_04 lowestwinsupdateplayerdata(param_00,var_05);
		}
	}
}

//Function Number: 19
statvaluechanged(param_00)
{
	var_01 = maps\mp\_utility::getplayerstat(param_00);
	var_02 = level.awards[param_00].defaultvalue;
	if(var_01 == var_02)
	{
		return 0;
	}

	return 1;
}