/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_awards.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 58
 * Decompile Time: 1077 ms
 * Timestamp: 10/27/2023 2:27:39 AM
*******************************************************************/

//Function Number: 1
init()
{
	func_2D7B();
	level thread onplayerconnect();
	level thread monitormovementdistance();
	level thread func_2DBA();
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
			var_00 setplayerdata("round","awardCount",0);
			foreach(var_03, var_02 in level.awards)
			{
				if(isdefined(level.awards[var_03].defaultvalue))
				{
					var_00 maps\mp\_utility::initplayerstat(var_03,level.awards[var_03].defaultvalue);
					continue;
				}

				var_00 maps\mp\_utility::initplayerstat(var_03);
			}
		}

		var_00.prevpos = var_00.origin;
		var_00.previousdeaths = 0;
		var_00.altitudepolls = 0;
		var_00.totalaltitudesum = 0;
		var_00.usedweapons = [];
		var_00 thread onplayerspawned();
		var_00 thread func_2DB4();
	}
}

//Function Number: 3
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		thread func_2DB0();
		thread func_2DB1();
		thread monitorswaps();
		thread func_2DBC();
		thread monitorshieldblocks();
		thread monitorflashhits();
		thread monitorstunhits();
		thread func_2DC0();
	}
}

//Function Number: 4
func_2D7B()
{
	if(isdefined(level.initgametypeawards))
	{
		[[ level.initgametypeawards ]]();
	}

	initawardflag("10kills",::isatleast,10,"kills");
	initawardflag("1death",::isatleast,1,"deaths");
	initawardflag("nodeaths",::isatmost,0,"deaths");
	initawardflag("nokills",::isatmost,0,"kills");
	initmultiaward("mvp","kills","deaths");
	initmultiaward("punisher","kills","killstreak");
	initmultiaward("overkill","kills","headshots");
	func_2D85("kdratio",0,::func_2DA7);
	func_2D85("kills",0,::func_2DA7);
	func_2D85("higherrankkills",0,::func_2DA7);
	func_2D85("deaths",0,::lowestwithhalfplayedtime);
	func_2D85("killstreak",0,::func_2DA7);
	func_2D85("headshots",0,::func_2DA7);
	func_2D85("closertoenemies",0,::func_2DA7);
	func_2D85("throwingknifekills",0,::func_2DA7);
	func_2D85("grenadekills",0,::func_2DA7);
	func_2D85("helicopters",0,::func_2DA7);
	func_2D85("airstrikes",0,::func_2DA7);
	func_2D85("uavs",0,::func_2DA7);
	func_2D85("mostmultikills",0,::func_2DA7);
	func_2D85("multikill",0,::func_2DA7);
	func_2D85("knifekills",0,::func_2DA7);
	func_2D85("flankkills",0,::func_2DA7);
	func_2D85("bulletpenkills",0,::func_2DA7);
	func_2D85("laststandkills",0,::func_2DA7);
	func_2D85("laststanderkills",0,::func_2DA7);
	func_2D85("assists",0,::func_2DA7);
	func_2D85("c4kills",0,::func_2DA7);
	func_2D85("claymorekills",0,::func_2DA7);
	func_2D85("fragkills",0,::func_2DA7);
	func_2D85("semtexkills",0,::func_2DA7);
	func_2D85("explosionssurvived",0,::func_2DA7);
	func_2D85("mosttacprevented",0,::func_2DA7);
	func_2D85("avengekills",0,::func_2DA7);
	func_2D85("rescues",0,::func_2DA7);
	func_2D85("longshots",0,::func_2DA7);
	func_2D85("adskills",0,::func_2DA7);
	func_2D85("hipfirekills",0,::func_2DA7);
	func_2D85("revengekills",0,::func_2DA7);
	func_2D85("longestlife",0,::func_2DA7);
	func_2D85("throwbacks",0,::func_2DA7);
	func_2D85("otherweaponkills",0,::func_2DA7);
	func_2D85("killedsameplayer",0,::func_2DA7,2);
	func_2D85("mostweaponsused",0,::func_2DA7,3);
	func_2D85("distancetraveled",0,::func_2DA7);
	func_2D85("mostreloads",0,::func_2DA7);
	func_2D85("mostswaps",0,::func_2DA7);
	func_2D84("flankdeaths",0);
	func_2D85("thermalkills",0,::func_2DA7);
	func_2D85("mostcamperkills",0,::func_2DA7);
	func_2D85("fbhits",0,::func_2DA7);
	func_2D85("stunhits",0,::func_2DA7);
	func_2D85("scopedkills",0,::func_2DA7);
	func_2D85("arkills",0,::func_2DA7);
	func_2D85("arheadshots",0,::func_2DA7);
	func_2D85("lmgkills",0,::func_2DA7);
	func_2D85("lmgheadshots",0,::func_2DA7);
	func_2D85("sniperkills",0,::func_2DA7);
	func_2D85("sniperheadshots",0,::func_2DA7);
	func_2D85("shieldblocks",0,::func_2DA7);
	func_2D85("shieldkills",0,::func_2DA7);
	func_2D85("smgkills",0,::func_2DA7);
	func_2D85("smgheadshots",0,::func_2DA7);
	func_2D85("shotgunkills",0,::func_2DA7);
	func_2D85("shotgunheadshots",0,::func_2DA7);
	func_2D85("pistolkills",0,::func_2DA7);
	func_2D85("pistolheadshots",0,::func_2DA7);
	func_2D85("rocketkills",0,::func_2DA7);
	func_2D85("equipmentkills",0,::func_2DA7);
	func_2D85("mostclasseschanged",0,::func_2DA7);
	func_2D85("lowerrankkills",0,::func_2DA7);
	func_2D85("sprinttime",0,::func_2DA7,1);
	func_2D85("crouchtime",0,::func_2DA7);
	func_2D85("pronetime",0,::func_2DA7);
	func_2D85("comebacks",0,::func_2DA7);
	func_2D85("mostshotsfired",0,::func_2DA7);
	func_2D85("timeinspot",0,::func_2DA7);
	func_2D85("killcamtimewatched",0,::func_2DA7);
	func_2D85("greatestavgalt",0,::func_2DA7);
	func_2D85("leastavgalt",9999999,::func_2DA8);
	func_2D85("weaponxpearned",0,::func_2DA7);
	func_2D85("assaultkillstreaksused",0,::func_2DA7);
	func_2D85("supportkillstreaksused",0,::func_2DA7);
	func_2D85("specialistkillstreaksearned",0,::func_2DA7);
	func_2D85("killsconfirmed",0,::func_2DA7);
	func_2D85("killsdenied",0,::func_2DA7);
	func_2D85("holdingteamdefenderflag",0,::func_2DA7);
	func_2D85("damagedone",0,::func_2DA7);
	func_2D85("damagetaken",0,::func_2DA8);
	if(!maps\mp\_utility::matchmakinggame())
	{
		func_2D85("killcamskipped",0,::func_2DA7);
		func_2D85("killsteals",0,::func_2DA7);
		if(!maps\mp\_utility::getgametypenumlives())
		{
			func_2D85("deathstreak",0,::func_2DA7);
		}

		func_2D85("shortestlife",9999999,::func_2DA8);
		func_2D85("suicides",0,::func_2DA7);
		func_2D85("mostff",0,::func_2DA7);
		func_2D85("shotgundeaths",0,::func_2DA7);
		func_2D85("shielddeaths",0,::func_2DA7);
		func_2D85("flankdeaths",0,::func_2DA7);
	}
}

//Function Number: 5
initbaseaward(param_00)
{
	level.awards[param_00] = spawnstruct();
	level.awards[param_00].winners = [];
	level.awards[param_00].exclusive = 1;
}

//Function Number: 6
func_2D80(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_01))
	{
		level.awards[param_00].process = param_01;
	}

	if(isdefined(param_02))
	{
		level.awards[param_00].var1 = param_02;
	}

	if(isdefined(param_03))
	{
		level.awards[param_00].var2 = param_03;
	}
}

//Function Number: 7
func_2D84(param_00,param_01)
{
	initbaseaward(param_00);
	level.awards[param_00].defaultvalue = param_01;
	level.awards[param_00].type = "stat";
}

//Function Number: 8
func_2D85(param_00,param_01,param_02,param_03,param_04)
{
	initbaseaward(param_00);
	func_2D80(param_00,param_02,param_03,param_04);
	level.awards[param_00].defaultvalue = param_01;
	level.awards[param_00].type = "stat";
}

//Function Number: 9
initderivedaward(param_00,param_01,param_02,param_03)
{
	initbaseaward(param_00);
	func_2D80(param_00,param_01,param_02,param_03);
	level.awards[param_00].type = "derived";
}

//Function Number: 10
initawardflag(param_00,param_01,param_02,param_03)
{
	initbaseaward(param_00);
	func_2D80(param_00,param_01,param_02,param_03);
	level.awards[param_00].type = "flag";
}

//Function Number: 11
initmultiaward(param_00,param_01,param_02)
{
	initbaseaward(param_00);
	level.awards[param_00].award1_ref = param_01;
	level.awards[param_00].award2_ref = param_02;
	level.awards[param_00].type = "multi";
}

//Function Number: 12
initthresholdaward(param_00,param_01,param_02,param_03)
{
	initbaseaward(param_00);
	func_2D80(param_00,param_01,param_02,param_03);
	level.awards[param_00].type = "threshold";
}

//Function Number: 13
setmatchrecordifgreater(param_00)
{
	var_01 = maps\mp\_utility::func_2D8D(param_00);
	var_02 = maps\mp\_utility::getplayerstattime(param_00);
	var_03 = getawardrecord(param_00);
	var_04 = func_2D99(param_00);
	if(!isdefined(var_03) || var_01 > var_03)
	{
		func_2D96(param_00);
		func_2D94(param_00,self.clientid);
		func_2D97(param_00,var_01,var_02);
		return;
	}

	if(var_01 == var_03)
	{
		if(isawardexclusive(param_00))
		{
			if(!isdefined(var_04) || var_02 < var_04)
			{
				func_2D96(param_00);
				func_2D94(param_00,self.clientid);
				func_2D97(param_00,var_01,var_02);
				return;
			}

			return;
		}

		func_2D94(param_00,self.clientid);
		return;
	}
}

//Function Number: 14
func_2D8F(param_00)
{
	var_01 = maps\mp\_utility::func_2D8D(param_00);
	var_02 = maps\mp\_utility::getplayerstattime(param_00);
	var_03 = getawardrecord(param_00);
	var_04 = func_2D99(param_00);
	if(!isdefined(var_03) || var_01 < var_03)
	{
		func_2D96(param_00);
		func_2D94(param_00,self.clientid);
		func_2D97(param_00,var_01,var_02);
		return;
	}

	if(var_01 == var_03)
	{
		if(isawardexclusive(param_00))
		{
			if(!isdefined(var_04) || var_02 < var_04)
			{
				func_2D96(param_00);
				func_2D94(param_00,self.clientid);
				func_2D97(param_00,var_01,var_02);
				return;
			}

			return;
		}

		func_2D94(param_00,self.clientid);
		return;
	}
}

//Function Number: 15
func_2D90(param_00)
{
	var_01 = func_2DB9(param_00);
	var_02 = func_2DB8(param_00);
	if(!var_01)
	{
		return var_02 + 0.001;
	}

	return var_02 / var_01;
}

//Function Number: 16
setpersonalbestifgreater(param_00)
{
	var_01 = self getplayerdata("bests",param_00);
	var_02 = maps\mp\_utility::func_2D8D(param_00);
	if(var_01 == 0 || var_02 > var_01)
	{
		var_02 = getformattedvalue(param_00,var_02);
		self setplayerdata("bests",param_00,var_02);
	}
}

//Function Number: 17
func_2D92(param_00)
{
	var_01 = self getplayerdata("bests",param_00);
	var_02 = maps\mp\_utility::func_2D8D(param_00);
	if(var_01 == 0 || var_02 < var_01)
	{
		var_02 = getformattedvalue(param_00,var_02);
		self setplayerdata("bests",param_00,var_02);
	}
}

//Function Number: 18
func_2D93(param_00)
{
	var_01 = self getplayerdata("awards",param_00);
	self setplayerdata("awards",param_00,var_01 + 1);
}

//Function Number: 19
func_2D94(param_00,param_01)
{
	foreach(var_03 in level.awards[param_00].winners)
	{
		if(var_03 == param_01)
		{
			return;
		}
	}

	level.awards[param_00].winners[level.awards[param_00].winners.size] = param_01;
}

//Function Number: 20
getawardwinners(param_00)
{
	return level.awards[param_00].winners;
}

//Function Number: 21
func_2D96(param_00)
{
	level.awards[param_00].winners = [];
}

//Function Number: 22
func_2D97(param_00,param_01,param_02)
{
	level.awards[param_00].value = param_01;
	level.awards[param_00].time = param_02;
}

//Function Number: 23
getawardrecord(param_00)
{
	return level.awards[param_00].value;
}

//Function Number: 24
func_2D99(param_00)
{
	return level.awards[param_00].time;
}

//Function Number: 25
func_2D9A()
{
	foreach(var_01 in level.players)
	{
		if(!var_01 maps\mp\_utility::rankingenabled())
		{
			return;
		}

		var_02 = var_01 maps\mp\_utility::func_2D8D("kills");
		var_03 = var_01 maps\mp\_utility::func_2D8D("deaths");
		if(var_03 == 0)
		{
			var_03 = 1;
		}

		var_01 maps\mp\_utility::func_2AA1("kdratio",var_02 / var_03);
		if(isalive(var_01))
		{
			var_04 = gettime() - var_01.spawntime;
			var_01 maps\mp\_utility::func_2AAA("longestlife",var_04);
		}
	}

	foreach(var_0B, var_07 in level.awards)
	{
		if(!isdefined(level.awards[var_0B].process))
		{
			continue;
		}

		var_08 = level.awards[var_0B].process;
		var_09 = level.awards[var_0B].var1;
		var_0A = level.awards[var_0B].var2;
		if(isdefined(var_09) && isdefined(var_0A))
		{
			[[ var_08 ]](var_0B,var_09,var_0A);
			continue;
		}

		if(isdefined(var_09))
		{
			[[ var_08 ]](var_0B,var_09);
			continue;
		}

		[[ var_08 ]](var_0B);
	}

	foreach(var_0B, var_07 in level.awards)
	{
		if(!func_2D9E(var_0B))
		{
			continue;
		}

		var_0D = level.awards[var_0B].award1_ref;
		var_0E = level.awards[var_0B].award2_ref;
		var_0F = getawardwinners(var_0D);
		var_10 = getawardwinners(var_0E);
		if(!isdefined(var_0F) || !isdefined(var_10))
		{
			continue;
		}

		foreach(var_12 in var_0F)
		{
			foreach(var_14 in var_10)
			{
				if(var_12 == var_14)
				{
					func_2D94(var_0B,var_12);
					var_01 = maps\mp\_utility::func_2D9B(var_12);
					var_15 = var_01 maps\mp\_utility::func_2D8D(var_0D);
					var_16 = var_01 maps\mp\_utility::func_2D8D(var_0E);
					var_01 maps\mp\_utility::func_2AA1(var_0B,func_2DB7(var_15,var_16));
				}
			}
		}
	}

	foreach(var_0B, var_07 in level.awards)
	{
		if(!func_2DA1(var_0B))
		{
			func_2D9C(var_0B);
		}
	}

	foreach(var_01 in level.players)
	{
		var_1B = var_01 getplayerdata("round","awardCount");
		for(var_1C = 0;var_1C < var_1B && var_1C < 3;var_1C++)
		{
			var_07 = var_01 getplayerdata("round","awards",var_1C,"award");
			var_1D = var_01 getplayerdata("round","awards",var_1C,"value");
		}
	}
}

//Function Number: 26
func_2D9C(param_00)
{
	var_01 = getawardwinners(param_00);
	if(!isdefined(var_01))
	{
		return;
	}

	foreach(var_03 in var_01)
	{
		foreach(var_05 in level.players)
		{
			if(var_05.clientid == var_03)
			{
				var_05 giveaward(param_00);
			}
		}
	}
}

//Function Number: 27
func_2D9D(param_00)
{
	if(isdefined(level.awards[param_00].type))
	{
		return level.awards[param_00].type;
	}

	return "none";
}

//Function Number: 28
func_2D9E(param_00)
{
	return func_2D9D(param_00) == "multi";
}

//Function Number: 29
isstataward(param_00)
{
	return func_2D9D(param_00) == "stat";
}

//Function Number: 30
isthresholdaward(param_00)
{
	return func_2D9D(param_00) == "threshold";
}

//Function Number: 31
func_2DA1(param_00)
{
	return func_2D9D(param_00) == "flag";
}

//Function Number: 32
isawardexclusive(param_00)
{
	if(isdefined(level.awards[param_00].exclusive))
	{
		return level.awards[param_00].exclusive;
	}

	return 1;
}

//Function Number: 33
hasdisplayvalue(param_00)
{
	var_01 = func_2D9D(param_00);
	switch(var_01)
	{
		case "derived":
			var_02 = 0;
			break;

		case "stat":
		case "multi":
		default:
			var_02 = 1;
			break;
	}

	return var_02;
}

//Function Number: 34
giveaward(param_00)
{
	var_01 = self getplayerdata("round","awardCount");
	func_2D93(param_00);
	if(hasdisplayvalue(param_00))
	{
		if(isstataward(param_00))
		{
		}

		var_02 = maps\mp\_utility::func_2D8D(param_00);
	}
	else
	{
		var_02 = 1;
	}

	var_02 = getformattedvalue(param_00,var_02);
	if(var_01 < 5)
	{
		self setplayerdata("round","awards",var_01,"award",param_00);
		self setplayerdata("round","awards",var_01,"value",var_02);
	}

	var_01++;
	self setplayerdata("round","awardCount",var_01);
	maps\mp\_matchdata::logaward(param_00);
	if(var_01 == 1)
	{
		maps\mp\_highlights::func_2D71(param_00,var_02);
	}
}

//Function Number: 35
getformattedvalue(param_00,param_01)
{
	var_02 = tablelookup("mp/awardTable.csv",1,param_00,7);
	switch(var_02)
	{
		case "float":
			param_01 = maps\mp\_utility::func_2DA6(param_01,2);
			param_01 = param_01 * 100;
			break;

		case "ratio":
		case "time":
		case "multi":
		case "count":
		case "distance":
		case "none":
		default:
			break;
	}

	param_01 = int(param_01);
	return param_01;
}

//Function Number: 36
func_2DA7(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(var_03 maps\mp\_utility::rankingenabled() && var_03 func_2DAA(param_00) && !isdefined(param_01) || var_03 maps\mp\_utility::func_2D8D(param_00) >= param_01)
		{
			var_03 setmatchrecordifgreater(param_00);
			if(!func_2DA1(param_00))
			{
				var_03 setpersonalbestifgreater(param_00);
			}
		}
	}
}

//Function Number: 37
func_2DA8(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(var_03 maps\mp\_utility::rankingenabled() && var_03 func_2DAA(param_00) && !isdefined(param_01) || var_03 maps\mp\_utility::func_2D8D(param_00) <= param_01)
		{
			var_03 func_2D8F(param_00);
			if(!func_2DA1(param_00))
			{
				var_03 func_2D92(param_00);
			}
		}
	}
}

//Function Number: 38
lowestwithhalfplayedtime(param_00)
{
	var_01 = maps\mp\_utility::gettimepassed() / 1000;
	var_02 = var_01 * 0.5;
	foreach(var_04 in level.players)
	{
		if(var_04.hasspawned && var_04.timeplayed["total"] >= var_02)
		{
			var_04 func_2D8F(param_00);
			if(!func_2DA1(param_00))
			{
				var_04 func_2D92(param_00);
			}
		}
	}
}

//Function Number: 39
func_2DAA(param_00)
{
	var_01 = maps\mp\_utility::func_2D8D(param_00);
	var_02 = level.awards[param_00].defaultvalue;
	if(var_01 == var_02)
	{
		return 0;
	}

	return 1;
}

//Function Number: 40
isatleast(param_00,param_01,param_02)
{
	foreach(var_04 in level.players)
	{
		var_05 = var_04 maps\mp\_utility::func_2D8D(param_02);
		var_06 = var_05;
		if(var_06 >= param_01)
		{
			func_2D94(param_00,var_04.clientid);
		}

		if(isthresholdaward(param_00) || func_2DA1(param_00))
		{
			var_04 maps\mp\_utility::func_2AA1(param_00,var_05);
		}
	}
}

//Function Number: 41
isatmost(param_00,param_01,param_02)
{
	foreach(var_04 in level.players)
	{
		var_05 = var_04 maps\mp\_utility::func_2D8D(param_02);
		if(var_05 <= param_01)
		{
			func_2D94(param_00,var_04.clientid);
		}
	}
}

//Function Number: 42
func_2DAD(param_00,param_01,param_02)
{
	var_03 = maps\mp\_utility::gettimepassed() / 1000;
	var_04 = var_03 * 0.5;
	foreach(var_06 in level.players)
	{
		if(var_06.hasspawned && var_06.timeplayed["total"] >= var_04)
		{
			var_07 = var_06 maps\mp\_utility::func_2D8D(param_02);
			if(var_07 <= param_01)
			{
				func_2D94(param_00,var_06.clientid);
			}
		}
	}
}

//Function Number: 43
setratio(param_00,param_01,param_02)
{
	foreach(var_04 in level.players)
	{
		var_05 = var_04 maps\mp\_utility::func_2D8D(param_01);
		var_06 = var_04 maps\mp\_utility::func_2D8D(param_02);
		if(var_06 == 0)
		{
			var_04 maps\mp\_utility::func_2AA1(param_00,var_05);
			continue;
		}

		var_07 = var_05 / var_06;
		var_04 maps\mp\_utility::func_2AA1(param_00,var_07);
	}
}

//Function Number: 44
getkillstreakawardref(param_00)
{
	switch(param_00)
	{
		case "uav_support":
		case "counter_uav":
		case "triple_uav":
		case "double_uav":
		case "uav":
			return "uavs";

		case "super_airstrike":
		case "airstrike":
		case "harrier_airstrike":
		case "stealth_airstrike":
		case "precision_airstrike":
			return "airstrikes";

		case "helicopter_blackbox":
		case "helicopter_mk19":
		case "helicopter_minigun":
		case "littlebird_support":
		case "helicopter":
		case "littlebird_flock":
		case "helicopter_flares":
			return "helicopters";

		default:
			return undefined;
	}
}

//Function Number: 45
func_2DB0()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("reload");
		maps\mp\_utility::incplayerstat("mostreloads",1);
	}
}

//Function Number: 46
func_2DB1()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("weapon_fired");
		maps\mp\_utility::incplayerstat("mostshotsfired",1);
	}
}

//Function Number: 47
monitorswaps()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	var_00 = "none";
	for(;;)
	{
		self waittill("weapon_change",var_01);
		if(var_00 == var_01)
		{
			continue;
		}

		if(var_01 == "none")
		{
			continue;
		}

		if(!maps\mp\gametypes\_weapons::isprimaryweapon(var_01))
		{
			continue;
		}

		var_00 = var_01;
		maps\mp\_utility::incplayerstat("mostswaps",1);
		var_02 = 0;
		foreach(var_04 in self.usedweapons)
		{
			if(var_01 == var_04)
			{
				var_02 = 1;
				break;
			}
		}

		if(!var_02)
		{
			self.usedweapons[self.usedweapons.size] = var_01;
			maps\mp\_utility::incplayerstat("mostweaponsused",1);
		}
	}
}

//Function Number: 48
monitormovementdistance()
{
	level endon("game_ended");
	self endon("disconnect");
	for(;;)
	{
		foreach(var_01 in level.players)
		{
			if(!isalive(var_01))
			{
				continue;
			}

			if(var_01.deaths != var_01.previousdeaths)
			{
				var_01.prevpos = var_01.origin;
				var_01.previousdeaths = var_01.deaths;
			}

			var_02 = distance(var_01.origin,var_01.prevpos);
			var_01 maps\mp\_utility::incplayerstat("distancetraveled",var_02);
			var_01.prevpos = var_01.origin;
			var_01.altitudepolls++;
			var_01.totalaltitudesum = var_01.totalaltitudesum + var_01.origin[2];
			var_03 = var_01.totalaltitudesum / var_01.altitudepolls;
			var_01 maps\mp\_utility::func_2AA1("leastavgalt",var_03);
			var_01 maps\mp\_utility::func_2AA1("greatestavgalt",var_03);
			wait 0.05;
		}

		wait 0.05;
	}
}

//Function Number: 49
func_2DB4()
{
	level endon("game_ended");
	self endon("disconnect");
	self.lastcampchecked = gettime();
	self.positionarray = [];
	var_00 = 512;
	for(;;)
	{
		if(!isalive(self))
		{
			wait 0.5;
			self.lastcampchecked = gettime();
			self.positionarray = [];
			continue;
		}

		self.positionarray[self.positionarray.size] = self.origin;
		if(gettime() - self.lastcampchecked >= 15000)
		{
			if(distance(self.positionarray[0],self.origin) < var_00 && distance(self.positionarray[1],self.positionarray[0]) < var_00)
			{
				var_01 = gettime() - self.lastcampchecked;
				maps\mp\_utility::incplayerstat("timeinspot",var_01);
			}

			self.positionarray = [];
			self.lastcampchecked = gettime();
		}

		wait 5;
	}
}

//Function Number: 50
func_2DB7(param_00,param_01)
{
	return param_00 + param_01 << 16;
}

//Function Number: 51
func_2DB8(param_00)
{
	return param_00 & -1;
}

//Function Number: 52
func_2DB9(param_00)
{
	return param_00 >> 16;
}

//Function Number: 53
func_2DBA()
{
	level endon("game_ended");
	self endon("disconnect");
	while(level.players.size < 3)
	{
		wait 1;
	}

	for(;;)
	{
		foreach(var_01 in level.players)
		{
			if(!isdefined(var_01))
			{
				continue;
			}

			if(var_01.team == "spectator")
			{
				continue;
			}

			if(!isalive(var_01))
			{
				continue;
			}

			var_02 = sortbydistance(level.players,var_01.origin);
			if(!var_02.size)
			{
				wait 0.05;
				continue;
			}

			if(var_02.size < 2)
			{
				wait 0.05;
				continue;
			}

			if(var_02[1].team != var_01.team)
			{
				var_01 maps\mp\_utility::incplayerstat("closertoenemies",0.05);
			}

			wait 0.05;
		}

		wait 0.05;
	}
}

//Function Number: 54
func_2DBC()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("survived_explosion",var_00);
		if(isdefined(var_00) && isplayer(var_00) && self == var_00)
		{
			continue;
		}

		maps\mp\_utility::incplayerstat("explosionssurvived",1);
		wait 0.05;
	}
}

//Function Number: 55
monitorshieldblocks()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("shield_blocked");
		maps\mp\_utility::incplayerstat("shieldblocks",1);
		wait 0.05;
	}
}

//Function Number: 56
monitorflashhits()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("flash_hit");
		maps\mp\_utility::incplayerstat("fbhits",1);
		wait 0.05;
	}
}

//Function Number: 57
monitorstunhits()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("stun_hit");
		maps\mp\_utility::incplayerstat("stunhits",1);
		wait 0.05;
	}
}

//Function Number: 58
func_2DC0()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		if(self getstance() == "crouch")
		{
			maps\mp\_utility::incplayerstat("crouchtime",500);
		}
		else if(self getstance() == "prone")
		{
			maps\mp\_utility::incplayerstat("pronetime",500);
		}

		wait 0.5;
	}
}