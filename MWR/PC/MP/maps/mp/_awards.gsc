/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_awards.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 18
 * Decompile Time: 270 ms
 * Timestamp: 10/27/2023 2:40:11 AM
*******************************************************************/

//Function Number: 1
init()
{
	initawards();
	level thread onplayerconnect();
}

//Function Number: 2
checkforlevelprogressionchallenges()
{
	level endon("game_ended");
	self endon("disconnect");
	self waittill("spawned_player");
	maps\mp\_utility::gameflagwait("prematch_done");
	var_00 = undefined;
	while(!isdefined(var_00))
	{
		if(!isdefined(self))
		{
			return;
		}

		if(maps\mp\_utility::invirtuallobby())
		{
			return;
		}

		var_00 = self.pers["rank"];
		wait(0.2);
	}

	var_01 = int(var_00 + 1 / 50);
	if(var_01 > 1)
	{
		for(var_02 = var_01;var_02 > 1;var_02--)
		{
			var_03 = var_02 * 50;
			var_04 = "ch_" + var_03 + "_paragon";
			var_05 = self.challengedata[var_04];
			if(isdefined(var_05) && var_05 == 1)
			{
				maps\mp\gametypes\_misions::processchallenge(var_04);
			}
		}
	}
}

//Function Number: 3
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

		var_00.recentawards[0] = "none";
		var_00.recentawards[1] = "none";
		var_00.recentawards[2] = "none";
		if(!maps\mp\_utility::invirtuallobby())
		{
			var_00 thread checkforlevelprogressionchallenges();
		}
	}
}

//Function Number: 4
initawards()
{
	initstataward("headshots",0,::highestwins);
	initstataward("multikill",0,::highestwins);
	initstataward("avengekills",0,::highestwins);
	initstataward("comebacks",0,::highestwins);
	initstataward("rescues",0,::highestwins);
	initstataward("longshots",0,::highestwins);
	initstataward("revengekills",0,::highestwins);
	initstataward("bulletpenkills",0,::highestwins);
	initstataward("throwback_kill",0,::highestwins);
	initstataward("firstblood",0,::highestwins);
	initstataward("posthumous",0,::highestwins);
	initstataward("assistedsuicide",0,::highestwins);
	initstataward("buzzkill",0,::highestwins);
	initstataward("oneshotkill",0,::highestwins);
	initstataward("doublekill",0,::highestwins);
	initstataward("triplekill",0,::highestwins);
	initstataward("fourkill",0,::highestwins);
	initstataward("fivekill",0,::highestwins);
	initstataward("sixkill",0,::highestwins);
	initstataward("sevenkill",0,::highestwins);
	initstataward("eightkill",0,::highestwins);
	initstataward("backstab",0,::highestwins);
	initstataward("killstreak5",0,::highestwins);
	initstataward("killstreak10",0,::highestwins);
	initstataward("killstreak15",0,::highestwins);
	initstataward("killstreak20",0,::highestwins);
	initstataward("killstreak25",0,::highestwins);
	initstataward("killstreak30",0,::highestwins);
	initstataward("killstreak30plus",0,::highestwins);
	initstataward("pointblank",0,::highestwins);
	initstataward("firstplacekill",0,::highestwins);
	initstataward("assault",0,::highestwins);
	initstataward("defends",0,::highestwins);
	initstataward("near_death_kill",0,::highestwins);
	initstataward("flash_kill",0,::highestwins);
	initstataward("multiKillOneBullet",0,::highestwins);
	initstataward("think_fast",0,::highestwins);
	initstataward("take_and_kill",0,::highestwins);
	initstataward("kills",0,::highestwins);
	initstataward("longestkillstreak",0,::highestwins);
	initstataward("knifekills",0,::highestwins);
	initstataward("kdratio",0,::highestwins);
	initstataward("deaths",0,::lowestwithhalfplayedtime);
	initstataward("assists",0,::highestwins);
	initstataward("totalGameScore",0,::highestwins);
	initstataward("scorePerMinute",0,::highestwins);
	initstataward("mostScorePerLife",0,::highestwins);
	initstataward("killStreaksUsed",0,::highestwins);
	initstataward("airstrike_mp_kill",0,::highestwins);
	initstataward("helicopter_mp_kill",0,::highestwins);
	initstataward("humiliation",0,::highestwins);
	initstataward("regicide",0,::highestwins);
	initstataward("gunslinger",0,::highestwins);
	initstataward("dejavu",0,::highestwins);
	initstataward("levelup",0,::highestwins);
	initstataward("flagscaptured",0,::highestwins);
	initstataward("flagsreturned",0,::highestwins);
	initstataward("flagcarrierkills",0,::highestwins);
	initstataward("flagscarried",0,::highestwins);
	initstataward("killsasflagcarrier",0,::highestwins);
	initstataward("pointscaptured",0,::highestwins);
	initstataward("kill_while_capture",0,::highestwins);
	initstataward("opening_move",0,::highestwins);
	initstataward("hp_secure",0,::highestwins);
	initstataward("targetsdestroyed",0,::highestwins);
	initstataward("bombsplanted",0,::highestwins);
	initstataward("bombsdefused",0,::highestwins);
	initstataward("ninja_defuse",0,::highestwins);
	initstataward("last_man_defuse",0,::highestwins);
	initstataward("elimination",0,::highestwins);
	initstataward("last_man_standing",0,::highestwins);
	initstataward("killsconfirmed",0,::highestwins);
	initstataward("killsdenied",0,::highestwins);
	initstataward("kill_denied_retrieved",0,::highestwins);
	initstataward("tag_collector",0,::highestwins);
	initstataward("hqsdestroyed",0,::highestwins);
	initstataward("hqscaptured",0,::highestwins);
	initstataward("banked",0,::highestwins);
	initstataward("muggings",0,::highestwins);
	initstataward("helicopter_destroyed",0,::highestwins);
	initstataward("assist_killstreak_destroyed",0,::highestwins);
	initstataward("radar_mp_earned",0,::highestwins);
	initstataward("airstrike_mp_earned",0,::highestwins);
	initstataward("helicopter_mp_earned",0,::highestwins);
	initstataward("numMatchesRecorded",0,::highestwins);
}

//Function Number: 5
initstataward(param_00,param_01,param_02,param_03,param_04)
{
	level.awards[param_00] = spawnstruct();
	level.awards[param_00].defaultvalue = param_01;
	if(isdefined(param_02))
	{
		level.awards[param_00].process = param_02;
	}

	if(isdefined(param_03))
	{
		level.awards[param_00].var1 = param_03;
	}

	if(isdefined(param_04))
	{
		level.awards[param_00].var2 = param_04;
	}
}

//Function Number: 6
setpersonalbestifgreater(param_00)
{
	var_01 = self getplayerdata(common_scripts\utility::getstatsgroup_common(),"bests",param_00);
	var_02 = maps\mp\_utility::getplayerstat(param_00);
	var_02 = getformattedvalue(param_00,var_02);
	if(var_01 == 0 || var_02 > var_01)
	{
		self setplayerdata(common_scripts\utility::getstatsgroup_common(),"bests",param_00,var_02);
	}
}

//Function Number: 7
setpersonalbestiflower(param_00)
{
	var_01 = self getplayerdata(common_scripts\utility::getstatsgroup_common(),"bests",param_00);
	var_02 = maps\mp\_utility::getplayerstat(param_00);
	var_02 = getformattedvalue(param_00,var_02);
	if(var_01 == 0 || var_02 < var_01)
	{
		self setplayerdata(common_scripts\utility::getstatsgroup_common(),"bests",param_00,var_02);
	}
}

//Function Number: 8
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

//Function Number: 9
gettotalscore(param_00)
{
	var_01 = param_00.score;
	if(!level.teambased)
	{
		var_01 = param_00.extrascore0;
	}

	return var_01;
}

//Function Number: 10
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

//Function Number: 11
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
		if(!isdefined(level.awards[var_08].process))
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

//Function Number: 12
giveaward(param_00)
{
	var_01 = maps\mp\_utility::getplayerstat(param_00);
	var_01 = getformattedvalue(param_00,var_01);
	self setplayerdata(common_scripts\utility::getstatsgroup_common(),"round","awards",param_00,var_01);
	if(shouldaveragetotal(param_00))
	{
		var_02 = self getplayerdata(common_scripts\utility::getstatsgroup_common(),"awards","numMatchesRecorded");
		var_03 = self getplayerdata(common_scripts\utility::getstatsgroup_common(),"awards",param_00);
		var_04 = var_03 * var_02;
		var_05 = int(var_04 + var_01 / var_02 + 1);
		self setplayerdata(common_scripts\utility::getstatsgroup_common(),"awards",param_00,var_05);
	}
	else
	{
		var_06 = self getplayerdata(common_scripts\utility::getstatsgroup_common(),"awards",param_00);
		self setplayerdata(common_scripts\utility::getstatsgroup_common(),"awards",param_00,var_06 + var_01);
	}

	var_07 = 0;
	for(var_08 = 0;var_08 < 3;var_08++)
	{
		if(self.recentawards[var_08] == param_00)
		{
			var_07 = 1;
		}
	}

	var_09 = int(tablelookup("mp/awardTable.csv",1,param_00,0));
	if(var_07 == 0 && isdefined(var_09) && var_09 == 1 && var_01 != 0)
	{
		self.recentawards[2] = self.recentawards[1];
		self.recentawards[1] = self.recentawards[0];
		self.recentawards[0] = param_00;
		self setplayerdata(common_scripts\utility::getstatsgroup_common(),"recentAwards",0,self.recentawards[0]);
		self setplayerdata(common_scripts\utility::getstatsgroup_common(),"recentAwards",1,self.recentawards[1]);
		self setplayerdata(common_scripts\utility::getstatsgroup_common(),"recentAwards",2,self.recentawards[2]);
	}
}

//Function Number: 13
shouldaveragetotal(param_00)
{
	switch(param_00)
	{
		case "scorePerMinute":
		case "kdratio":
			break;
	}
}

//Function Number: 14
getformattedvalue(param_00,param_01)
{
	var_02 = tablelookup("mp/awardTable.csv",1,param_00,5);
	switch(var_02)
	{
		case "float":
			break;

		case "ratio":
		case "multi":
		case "time":
		case "count":
		case "distance":
		case "none":
		default:
			break;
	}
}

//Function Number: 15
highestwins(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(var_03 maps\mp\_utility::rankingenabled() && var_03 statvaluechanged(param_00) && !isdefined(param_01) || var_03 maps\mp\_utility::getplayerstat(param_00) >= param_01)
		{
			var_03 giveaward(param_00);
			var_03 setpersonalbestifgreater(param_00);
		}
	}
}

//Function Number: 16
lowestwins(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(var_03 maps\mp\_utility::rankingenabled() && var_03 statvaluechanged(param_00) && !isdefined(param_01) || var_03 maps\mp\_utility::getplayerstat(param_00) <= param_01)
		{
			var_03 giveaward(param_00);
			var_03 setpersonalbestiflower(param_00);
		}
	}
}

//Function Number: 17
lowestwithhalfplayedtime(param_00)
{
	var_01 = maps\mp\_utility::gettimepassed() / 1000;
	var_02 = var_01 * 0.5;
	foreach(var_04 in level.players)
	{
		if(var_04.hasspawned && var_04.timeplayed["total"] >= var_02)
		{
			var_04 giveaward(param_00);
			var_04 setpersonalbestiflower(param_00);
		}
	}
}

//Function Number: 18
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