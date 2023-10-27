/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_awards.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 58
 * Decompile Time: 1011 ms
 * Timestamp: 10/27/2023 2:14:55 AM
*******************************************************************/

//Function Number: 1
init()
{
	initawards();
	level thread onplayerconnect();
	level thread monitormovementdistance();
	level thread monitorenemydistance();
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
		var_00 thread monitorpositioncamping();
	}
}

//Function Number: 3
onplayerspawned()
{
	self endon("disconnect");
	for(;;)
	{
		self waittill("spawned_player");
		thread monitorreloads();
		thread monitorshotsfired();
		thread monitorswaps();
		thread monitorexplosionssurvived();
		thread monitorshieldblocks();
		thread monitorflashhits();
		thread monitorstunhits();
		thread monitorstancetime();
	}
}

//Function Number: 4
initawards()
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
	initstataward("kdratio",0,::highestwins);
	initstataward("kills",0,::highestwins);
	initstataward("higherrankkills",0,::highestwins);
	initstataward("deaths",0,::lowestwithhalfplayedtime);
	initstataward("killstreak",0,::highestwins);
	initstataward("headshots",0,::highestwins);
	initstataward("closertoenemies",0,::highestwins);
	initstataward("throwingknifekills",0,::highestwins);
	initstataward("grenadekills",0,::highestwins);
	initstataward("helicopters",0,::highestwins);
	initstataward("airstrikes",0,::highestwins);
	initstataward("uavs",0,::highestwins);
	initstataward("mostmultikills",0,::highestwins);
	initstataward("multikill",0,::highestwins);
	initstataward("knifekills",0,::highestwins);
	initstataward("flankkills",0,::highestwins);
	initstataward("bulletpenkills",0,::highestwins);
	initstataward("laststandkills",0,::highestwins);
	initstataward("laststanderkills",0,::highestwins);
	initstataward("assists",0,::highestwins);
	initstataward("c4kills",0,::highestwins);
	initstataward("claymorekills",0,::highestwins);
	initstataward("fragkills",0,::highestwins);
	initstataward("semtexkills",0,::highestwins);
	initstataward("explosionssurvived",0,::highestwins);
	initstataward("mosttacprevented",0,::highestwins);
	initstataward("avengekills",0,::highestwins);
	initstataward("rescues",0,::highestwins);
	initstataward("longshots",0,::highestwins);
	initstataward("adskills",0,::highestwins);
	initstataward("hipfirekills",0,::highestwins);
	initstataward("revengekills",0,::highestwins);
	initstataward("longestlife",0,::highestwins);
	initstataward("throwbacks",0,::highestwins);
	initstataward("otherweaponkills",0,::highestwins);
	initstataward("killedsameplayer",0,::highestwins,2);
	initstataward("mostweaponsused",0,::highestwins,3);
	initstataward("distancetraveled",0,::highestwins);
	initstataward("mostreloads",0,::highestwins);
	initstataward("mostswaps",0,::highestwins);
	initstat("flankdeaths",0);
	initstataward("thermalkills",0,::highestwins);
	initstataward("mostcamperkills",0,::highestwins);
	initstataward("fbhits",0,::highestwins);
	initstataward("stunhits",0,::highestwins);
	initstataward("scopedkills",0,::highestwins);
	initstataward("arkills",0,::highestwins);
	initstataward("arheadshots",0,::highestwins);
	initstataward("lmgkills",0,::highestwins);
	initstataward("lmgheadshots",0,::highestwins);
	initstataward("sniperkills",0,::highestwins);
	initstataward("sniperheadshots",0,::highestwins);
	initstataward("shieldblocks",0,::highestwins);
	initstataward("shieldkills",0,::highestwins);
	initstataward("smgkills",0,::highestwins);
	initstataward("smgheadshots",0,::highestwins);
	initstataward("shotgunkills",0,::highestwins);
	initstataward("shotgunheadshots",0,::highestwins);
	initstataward("pistolkills",0,::highestwins);
	initstataward("pistolheadshots",0,::highestwins);
	initstataward("rocketkills",0,::highestwins);
	initstataward("equipmentkills",0,::highestwins);
	initstataward("mostclasseschanged",0,::highestwins);
	initstataward("lowerrankkills",0,::highestwins);
	initstataward("sprinttime",0,::highestwins,1);
	initstataward("crouchtime",0,::highestwins);
	initstataward("pronetime",0,::highestwins);
	initstataward("comebacks",0,::highestwins);
	initstataward("mostshotsfired",0,::highestwins);
	initstataward("timeinspot",0,::highestwins);
	initstataward("killcamtimewatched",0,::highestwins);
	initstataward("greatestavgalt",0,::highestwins);
	initstataward("leastavgalt",9999999,::lowestwins);
	initstataward("weaponxpearned",0,::highestwins);
	initstataward("assaultkillstreaksused",0,::highestwins);
	initstataward("supportkillstreaksused",0,::highestwins);
	initstataward("specialistkillstreaksearned",0,::highestwins);
	initstataward("killsconfirmed",0,::highestwins);
	initstataward("killsdenied",0,::highestwins);
	initstataward("holdingteamdefenderflag",0,::highestwins);
	initstataward("damagedone",0,::highestwins);
	initstataward("damagetaken",0,::lowestwins);
	if(!maps\mp\_utility::matchmakinggame())
	{
		initstataward("killcamskipped",0,::highestwins);
		initstataward("killsteals",0,::highestwins);
		if(!maps\mp\_utility::getgametypenumlives())
		{
			initstataward("deathstreak",0,::highestwins);
		}

		initstataward("shortestlife",9999999,::lowestwins);
		initstataward("suicides",0,::highestwins);
		initstataward("mostff",0,::highestwins);
		initstataward("shotgundeaths",0,::highestwins);
		initstataward("shielddeaths",0,::highestwins);
		initstataward("flankdeaths",0,::highestwins);
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
initawardprocess(param_00,param_01,param_02,param_03)
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
initstat(param_00,param_01)
{
	initbaseaward(param_00);
	level.awards[param_00].defaultvalue = param_01;
	level.awards[param_00].type = "stat";
}

//Function Number: 8
initstataward(param_00,param_01,param_02,param_03,param_04)
{
	initbaseaward(param_00);
	initawardprocess(param_00,param_02,param_03,param_04);
	level.awards[param_00].defaultvalue = param_01;
	level.awards[param_00].type = "stat";
}

//Function Number: 9
initderivedaward(param_00,param_01,param_02,param_03)
{
	initbaseaward(param_00);
	initawardprocess(param_00,param_01,param_02,param_03);
	level.awards[param_00].type = "derived";
}

//Function Number: 10
initawardflag(param_00,param_01,param_02,param_03)
{
	initbaseaward(param_00);
	initawardprocess(param_00,param_01,param_02,param_03);
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
	initawardprocess(param_00,param_01,param_02,param_03);
	level.awards[param_00].type = "threshold";
}

//Function Number: 13
setmatchrecordifgreater(param_00)
{
	var_01 = maps\mp\_utility::getplayerstat(param_00);
	var_02 = maps\mp\_utility::getplayerstattime(param_00);
	var_03 = getawardrecord(param_00);
	var_04 = getawardrecordtime(param_00);
	if(!isdefined(var_03) || var_01 > var_03)
	{
		clearawardwinners(param_00);
		addawardwinner(param_00,self.clientid);
		setawardrecord(param_00,var_01,var_02);
		return;
	}

	if(var_01 == var_03)
	{
		if(isawardexclusive(param_00))
		{
			if(!isdefined(var_04) || var_02 < var_04)
			{
				clearawardwinners(param_00);
				addawardwinner(param_00,self.clientid);
				setawardrecord(param_00,var_01,var_02);
				return;
			}

			return;
		}

		addawardwinner(param_00,self.clientid);
		return;
	}
}

//Function Number: 14
setmatchrecordiflower(param_00)
{
	var_01 = maps\mp\_utility::getplayerstat(param_00);
	var_02 = maps\mp\_utility::getplayerstattime(param_00);
	var_03 = getawardrecord(param_00);
	var_04 = getawardrecordtime(param_00);
	if(!isdefined(var_03) || var_01 < var_03)
	{
		clearawardwinners(param_00);
		addawardwinner(param_00,self.clientid);
		setawardrecord(param_00,var_01,var_02);
		return;
	}

	if(var_01 == var_03)
	{
		if(isawardexclusive(param_00))
		{
			if(!isdefined(var_04) || var_02 < var_04)
			{
				clearawardwinners(param_00);
				addawardwinner(param_00,self.clientid);
				setawardrecord(param_00,var_01,var_02);
				return;
			}

			return;
		}

		addawardwinner(param_00,self.clientid);
		return;
	}
}

//Function Number: 15
getdecodedratio(param_00)
{
	var_01 = getratioloval(param_00);
	var_02 = getratiohival(param_00);
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
	var_02 = maps\mp\_utility::getplayerstat(param_00);
	if(var_01 == 0 || var_02 > var_01)
	{
		var_02 = getformattedvalue(param_00,var_02);
		self setplayerdata("bests",param_00,var_02);
	}
}

//Function Number: 17
setpersonalbestiflower(param_00)
{
	var_01 = self getplayerdata("bests",param_00);
	var_02 = maps\mp\_utility::getplayerstat(param_00);
	if(var_01 == 0 || var_02 < var_01)
	{
		var_02 = getformattedvalue(param_00,var_02);
		self setplayerdata("bests",param_00,var_02);
	}
}

//Function Number: 18
incplayerrecord(param_00)
{
	var_01 = self getplayerdata("awards",param_00);
	self setplayerdata("awards",param_00,var_01 + 1);
}

//Function Number: 19
addawardwinner(param_00,param_01)
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
clearawardwinners(param_00)
{
	level.awards[param_00].winners = [];
}

//Function Number: 22
setawardrecord(param_00,param_01,param_02)
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
getawardrecordtime(param_00)
{
	return level.awards[param_00].time;
}

//Function Number: 25
assignawards()
{
	foreach(var_01 in level.players)
	{
		if(!var_01 maps\mp\_utility::rankingenabled())
		{
			return;
		}

		var_02 = var_01 maps\mp\_utility::getplayerstat("kills");
		var_03 = var_01 maps\mp\_utility::getplayerstat("deaths");
		if(var_03 == 0)
		{
			var_03 = 1;
		}

		var_01 maps\mp\_utility::setplayerstat("kdratio",var_02 / var_03);
		if(isalive(var_01))
		{
			var_04 = gettime() - var_01.spawntime;
			var_01 maps\mp\_utility::setplayerstatifgreater("longestlife",var_04);
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
		if(!ismultiaward(var_0B))
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
					addawardwinner(var_0B,var_12);
					var_01 = maps\mp\_utility::playerforclientid(var_12);
					var_15 = var_01 maps\mp\_utility::getplayerstat(var_0D);
					var_16 = var_01 maps\mp\_utility::getplayerstat(var_0E);
					var_01 maps\mp\_utility::setplayerstat(var_0B,encoderatio(var_15,var_16));
				}
			}
		}
	}

	foreach(var_0B, var_07 in level.awards)
	{
		if(!isawardflag(var_0B))
		{
			assignaward(var_0B);
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
assignaward(param_00)
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
getawardtype(param_00)
{
	if(isdefined(level.awards[param_00].type))
	{
		return level.awards[param_00].type;
	}

	return "none";
}

//Function Number: 28
ismultiaward(param_00)
{
	return getawardtype(param_00) == "multi";
}

//Function Number: 29
isstataward(param_00)
{
	return getawardtype(param_00) == "stat";
}

//Function Number: 30
isthresholdaward(param_00)
{
	return getawardtype(param_00) == "threshold";
}

//Function Number: 31
isawardflag(param_00)
{
	return getawardtype(param_00) == "flag";
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
	var_01 = getawardtype(param_00);
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
	incplayerrecord(param_00);
	if(hasdisplayvalue(param_00))
	{
		if(isstataward(param_00))
		{
		}

		var_02 = maps\mp\_utility::getplayerstat(param_00);
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
		maps\mp\_highlights::givehighlight(param_00,var_02);
	}
}

//Function Number: 35
getformattedvalue(param_00,param_01)
{
	var_02 = tablelookup("mp/awardTable.csv",1,param_00,7);
	switch(var_02)
	{
		case "float":
			param_01 = maps\mp\_utility::limitdecimalplaces(param_01,2);
			param_01 = param_01 * 100;
			break;

		case "ratio":
		case "multi":
		case "time":
		case "count":
		case "none":
		case "distance":
		default:
			break;
	}

	param_01 = int(param_01);
	return param_01;
}

//Function Number: 36
highestwins(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(var_03 maps\mp\_utility::rankingenabled() && var_03 statvaluechanged(param_00) && !isdefined(param_01) || var_03 maps\mp\_utility::getplayerstat(param_00) >= param_01)
		{
			var_03 setmatchrecordifgreater(param_00);
			if(!isawardflag(param_00))
			{
				var_03 setpersonalbestifgreater(param_00);
			}
		}
	}
}

//Function Number: 37
lowestwins(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(var_03 maps\mp\_utility::rankingenabled() && var_03 statvaluechanged(param_00) && !isdefined(param_01) || var_03 maps\mp\_utility::getplayerstat(param_00) <= param_01)
		{
			var_03 setmatchrecordiflower(param_00);
			if(!isawardflag(param_00))
			{
				var_03 setpersonalbestiflower(param_00);
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
			var_04 setmatchrecordiflower(param_00);
			if(!isawardflag(param_00))
			{
				var_04 setpersonalbestiflower(param_00);
			}
		}
	}
}

//Function Number: 39
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

//Function Number: 40
isatleast(param_00,param_01,param_02)
{
	foreach(var_04 in level.players)
	{
		var_05 = var_04 maps\mp\_utility::getplayerstat(param_02);
		var_06 = var_05;
		if(var_06 >= param_01)
		{
			addawardwinner(param_00,var_04.clientid);
		}

		if(isthresholdaward(param_00) || isawardflag(param_00))
		{
			var_04 maps\mp\_utility::setplayerstat(param_00,var_05);
		}
	}
}

//Function Number: 41
isatmost(param_00,param_01,param_02)
{
	foreach(var_04 in level.players)
	{
		var_05 = var_04 maps\mp\_utility::getplayerstat(param_02);
		if(var_05 <= param_01)
		{
			addawardwinner(param_00,var_04.clientid);
		}
	}
}

//Function Number: 42
isatmostwithhalfplayedtime(param_00,param_01,param_02)
{
	var_03 = maps\mp\_utility::gettimepassed() / 1000;
	var_04 = var_03 * 0.5;
	foreach(var_06 in level.players)
	{
		if(var_06.hasspawned && var_06.timeplayed["total"] >= var_04)
		{
			var_07 = var_06 maps\mp\_utility::getplayerstat(param_02);
			if(var_07 <= param_01)
			{
				addawardwinner(param_00,var_06.clientid);
			}
		}
	}
}

//Function Number: 43
setratio(param_00,param_01,param_02)
{
	foreach(var_04 in level.players)
	{
		var_05 = var_04 maps\mp\_utility::getplayerstat(param_01);
		var_06 = var_04 maps\mp\_utility::getplayerstat(param_02);
		if(var_06 == 0)
		{
			var_04 maps\mp\_utility::setplayerstat(param_00,var_05);
			continue;
		}

		var_07 = var_05 / var_06;
		var_04 maps\mp\_utility::setplayerstat(param_00,var_07);
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
		case "littlebird_flock":
		case "helicopter_flares":
		case "helicopter":
			return "helicopters";

		default:
			return undefined;
	}
}

//Function Number: 45
monitorreloads()
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
monitorshotsfired()
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
			var_01 maps\mp\_utility::setplayerstat("leastavgalt",var_03);
			var_01 maps\mp\_utility::setplayerstat("greatestavgalt",var_03);
			wait 0.05;
		}

		wait 0.05;
	}
}

//Function Number: 49
monitorpositioncamping()
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
encoderatio(param_00,param_01)
{
	return param_00 + param_01 << 16;
}

//Function Number: 51
getratiohival(param_00)
{
	return param_00 & -1;
}

//Function Number: 52
getratioloval(param_00)
{
	return param_00 >> 16;
}

//Function Number: 53
monitorenemydistance()
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
monitorexplosionssurvived()
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
monitorstancetime()
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