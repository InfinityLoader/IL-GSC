/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\_awards.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 58
 * Decompile Time: 1032 ms
 * Timestamp: 10/27/2023 1:22:08 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	func_45F0();
	level thread func_595D();
	level thread monitormovementdistance();
}

//Function Number: 2
func_595D()
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
			var_00 setcommonplayerdata("round","awardCount",0);
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
		thread func_53B7();
		thread func_53C0();
		thread func_53CF();
		thread func_5386();
		thread func_53BF();
		thread func_538E();
		thread func_53CC();
		thread func_53C7();
	}
}

//Function Number: 4
func_45F0()
{
	if(isdefined(level.initgametypeawards))
	{
		[[ level.initgametypeawards ]]();
	}

	func_45EE("10kills",::func_487A,10,"kills");
	func_45EE("1death",::func_487A,1,"deaths");
	func_45EE("nodeaths",::isatmost,0,"deaths");
	func_45EE("nokills",::isatmost,0,"kills");
	func_4638("mvp","kills","deaths");
	func_4638("punisher","kills","killstreak");
	func_4638("overkill","kills","headshots");
	func_4652("kdratio",0,::highestwins);
	func_4652("kills",0,::highestwins);
	func_4652("higherrankkills",0,::highestwins);
	func_4652("deaths",0,::func_4FAA);
	func_4652("killstreak",0,::highestwins);
	func_4652("headshots",0,::highestwins);
	func_4652("closertoenemies",0,::highestwins);
	func_4652("throwingknifekills",0,::highestwins);
	func_4652("grenadekills",0,::highestwins);
	func_4652("helicopters",0,::highestwins);
	func_4652("airstrikes",0,::highestwins);
	func_4652("uavs",0,::highestwins);
	func_4652("mostmultikills",0,::highestwins);
	func_4652("multikill",0,::highestwins);
	func_4652("knifekills",0,::highestwins);
	func_4652("flankkills",0,::highestwins);
	func_4652("bulletpenkills",0,::highestwins);
	func_4652("laststandkills",0,::highestwins);
	func_4652("laststanderkills",0,::highestwins);
	func_4652("assists",0,::highestwins);
	func_4652("c4kills",0,::highestwins);
	func_4652("claymorekills",0,::highestwins);
	func_4652("fragkills",0,::highestwins);
	func_4652("semtexkills",0,::highestwins);
	func_4652("explosionssurvived",0,::highestwins);
	func_4652("mosttacprevented",0,::highestwins);
	func_4652("avengekills",0,::highestwins);
	func_4652("rescues",0,::highestwins);
	func_4652("longshots",0,::highestwins);
	func_4652("adskills",0,::highestwins);
	func_4652("hipfirekills",0,::highestwins);
	func_4652("revengekills",0,::highestwins);
	func_4652("longestlife",0,::highestwins);
	func_4652("throwbacks",0,::highestwins);
	func_4652("otherweaponkills",0,::highestwins);
	func_4652("killedsameplayer",0,::highestwins,2);
	func_4652("mostweaponsused",0,::highestwins,3);
	func_4652("distancetraveled",0,::highestwins);
	func_4652("mostreloads",0,::highestwins);
	func_4652("mostswaps",0,::highestwins);
	initstat("flankdeaths",0);
	func_4652("thermalkills",0,::highestwins);
	func_4652("mostcamperkills",0,::highestwins);
	func_4652("fbhits",0,::highestwins);
	func_4652("stunhits",0,::highestwins);
	func_4652("scopedkills",0,::highestwins);
	func_4652("arkills",0,::highestwins);
	func_4652("arheadshots",0,::highestwins);
	func_4652("lmgkills",0,::highestwins);
	func_4652("lmgheadshots",0,::highestwins);
	func_4652("dmrkills",0,::highestwins);
	func_4652("sniperkills",0,::highestwins);
	func_4652("dmrheadshots",0,::highestwins);
	func_4652("sniperheadshots",0,::highestwins);
	func_4652("shieldblocks",0,::highestwins);
	func_4652("shieldkills",0,::highestwins);
	func_4652("smgkills",0,::highestwins);
	func_4652("smgheadshots",0,::highestwins);
	func_4652("shotgunkills",0,::highestwins);
	func_4652("shotgunheadshots",0,::highestwins);
	func_4652("pistolkills",0,::highestwins);
	func_4652("pistolheadshots",0,::highestwins);
	func_4652("rocketkills",0,::highestwins);
	func_4652("equipmentkills",0,::highestwins);
	func_4652("mostclasseschanged",0,::highestwins);
	func_4652("lowerrankkills",0,::highestwins);
	func_4652("sprinttime",0,::highestwins,1);
	func_4652("crouchtime",0,::highestwins);
	func_4652("pronetime",0,::highestwins);
	func_4652("comebacks",0,::highestwins);
	func_4652("mostshotsfired",0,::highestwins);
	func_4652("timeinspot",0,::highestwins);
	func_4652("killcamtimewatched",0,::highestwins);
	func_4652("greatestavgalt",0,::highestwins);
	func_4652("leastavgalt",9999999,::func_4FA9);
	func_4652("weaponxpearned",0,::highestwins);
	func_4652("assaultkillstreaksused",0,::highestwins);
	func_4652("supportkillstreaksused",0,::highestwins);
	func_4652("specialistkillstreaksearned",0,::highestwins);
	func_4652("killsconfirmed",0,::highestwins);
	func_4652("killsdenied",0,::highestwins);
	func_4652("holdingteamdefenderflag",0,::highestwins);
	func_4652("damagedone",0,::highestwins);
	func_4652("damagetaken",0,::func_4FA9);
	if(!maps\mp\_utility::func_50C1())
	{
		func_4652("killcamskipped",0,::highestwins);
		func_4652("killsteals",0,::highestwins);
		func_4652("shortestlife",9999999,::func_4FA9);
		func_4652("suicides",0,::highestwins);
		func_4652("mostff",0,::highestwins);
		func_4652("shotgundeaths",0,::highestwins);
		func_4652("shielddeaths",0,::highestwins);
		func_4652("flankdeaths",0,::highestwins);
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
func_45EF(param_00,param_01,param_02,param_03)
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
func_4652(param_00,param_01,param_02,param_03,param_04)
{
	initbaseaward(param_00);
	func_45EF(param_00,param_02,param_03,param_04);
	level.awards[param_00].defaultvalue = param_01;
	level.awards[param_00].type = "stat";
}

//Function Number: 9
func_45FF(param_00,param_01,param_02,param_03)
{
	initbaseaward(param_00);
	func_45EF(param_00,param_01,param_02,param_03);
	level.awards[param_00].type = "derived";
}

//Function Number: 10
func_45EE(param_00,param_01,param_02,param_03)
{
	initbaseaward(param_00);
	func_45EF(param_00,param_01,param_02,param_03);
	level.awards[param_00].type = "flag";
}

//Function Number: 11
func_4638(param_00,param_01,param_02)
{
	initbaseaward(param_00);
	level.awards[param_00].award1_ref = param_01;
	level.awards[param_00].award2_ref = param_02;
	level.awards[param_00].type = "multi";
}

//Function Number: 12
func_4658(param_00,param_01,param_02,param_03)
{
	initbaseaward(param_00);
	func_45EF(param_00,param_01,param_02,param_03);
	level.awards[param_00].type = "threshold";
}

//Function Number: 13
func_706A(param_00)
{
	var_01 = maps\mp\_utility::getplayerstat(param_00);
	var_02 = maps\mp\_utility::func_3B9C(param_00);
	var_03 = getawardrecord(param_00);
	var_04 = func_3A33(param_00);
	if(!isdefined(var_03) || var_01 > var_03)
	{
		clearawardwinners(param_00);
		addawardwinner(param_00,self.clientid);
		func_6FE8(param_00,var_01,var_02);
	}

	if(var_01 == var_03)
	{
		if(isawardexclusive(param_00))
		{
			if(!isdefined(var_04) || var_02 < var_04)
			{
				clearawardwinners(param_00);
				addawardwinner(param_00,self.clientid);
				func_6FE8(param_00,var_01,var_02);
			}
		}

		addawardwinner(param_00,self.clientid);
	}
}

//Function Number: 14
setmatchrecordiflower(param_00)
{
	var_01 = maps\mp\_utility::getplayerstat(param_00);
	var_02 = maps\mp\_utility::func_3B9C(param_00);
	var_03 = getawardrecord(param_00);
	var_04 = func_3A33(param_00);
	if(!isdefined(var_03) || var_01 < var_03)
	{
		clearawardwinners(param_00);
		addawardwinner(param_00,self.clientid);
		func_6FE8(param_00,var_01,var_02);
	}

	if(var_01 == var_03)
	{
		if(isawardexclusive(param_00))
		{
			if(!isdefined(var_04) || var_02 < var_04)
			{
				clearawardwinners(param_00);
				addawardwinner(param_00,self.clientid);
				func_6FE8(param_00,var_01,var_02);
			}
		}

		addawardwinner(param_00,self.clientid);
	}
}

//Function Number: 15
func_3A78(param_00)
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
func_7091(param_00)
{
	var_01 = self getcommonplayerdata("bests",param_00);
	var_02 = maps\mp\_utility::getplayerstat(param_00);
	if(var_01 == 0 || var_02 > var_01)
	{
		var_02 = func_3AB2(param_00,var_02);
		self setcommonplayerdata("bests",param_00,var_02);
	}
}

//Function Number: 17
func_7092(param_00)
{
	var_01 = self getcommonplayerdata("bests",param_00);
	var_02 = maps\mp\_utility::getplayerstat(param_00);
	if(var_01 == 0 || var_02 < var_01)
	{
		var_02 = func_3AB2(param_00,var_02);
		self setcommonplayerdata("bests",param_00,var_02);
	}
}

//Function Number: 18
func_447A(param_00)
{
	var_01 = self getcommonplayerdata("awards",param_00);
	self setcommonplayerdata("awards",param_00,var_01 + 1);
}

//Function Number: 19
addawardwinner(param_00,param_01)
{
	foreach(var_03 in level.awards[param_00].winners)
	{
		if(var_03 == param_01)
		{
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
func_6FE8(param_00,param_01,param_02)
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
func_3A33(param_00)
{
	return level.awards[param_00].time;
}

//Function Number: 25
assignawards()
{
	foreach(var_01 in level.players)
	{
		if(!var_01 maps\mp\_utility::func_634C())
		{
		}

		var_02 = var_01 maps\mp\_utility::getplayerstat("kills");
		var_03 = var_01 maps\mp\_utility::getplayerstat("deaths");
		if(var_03 == 0)
		{
			var_03 = 1;
		}

		var_01 maps\mp\_utility::func_70A0("kdratio",var_02 / var_03);
		if(isalive(var_01))
		{
			var_04 = gettime() - var_01.var_78C4;
			var_01 maps\mp\_utility::func_70A1("longestlife",var_04);
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
		if(!func_4914(var_0B))
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
					var_01 = maps\mp\_utility::func_5FAB(var_12);
					var_15 = var_01 maps\mp\_utility::getplayerstat(var_0D);
					var_16 = var_01 maps\mp\_utility::getplayerstat(var_0E);
					var_01 maps\mp\_utility::func_70A0(var_0B,encoderatio(var_15,var_16));
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
		var_1B = var_01 getcommonplayerdata("round","awardCount");
		for(var_1C = 0;var_1C < var_1B && var_1C < 3;var_1C++)
		{
			var_07 = var_01 getcommonplayerdata("round","awards",var_1C,"award");
			var_1D = var_01 getcommonplayerdata("round","awards",var_1C,"value");
		}
	}
}

//Function Number: 26
assignaward(param_00)
{
	var_01 = getawardwinners(param_00);
	if(!isdefined(var_01))
	{
	}

	foreach(var_03 in var_01)
	{
		foreach(var_05 in level.players)
		{
			if(var_05.clientid == var_03)
			{
				var_05 func_3CDD(param_00);
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
func_4914(param_00)
{
	return getawardtype(param_00) == "multi";
}

//Function Number: 29
func_496F(param_00)
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

		case "multi":
		case "stat":
		default:
			var_02 = 1;
			break;
	}

	return var_02;
}

//Function Number: 34
func_3CDD(param_00)
{
	var_01 = self getcommonplayerdata("round","awardCount");
	func_447A(param_00);
	if(hasdisplayvalue(param_00))
	{
		if(func_496F(param_00))
		{
		}

		var_02 = maps\mp\_utility::getplayerstat(param_00);
	}
	else
	{
		var_02 = 1;
	}

	var_02 = func_3AB2(param_00,var_02);
	if(var_01 < 5)
	{
		self setcommonplayerdata("round","awards",var_01,"award",param_00);
		self setcommonplayerdata("round","awards",var_01,"value",var_02);
	}

	var_01++;
	self setcommonplayerdata("round","awardCount",var_01);
	maps\mp\_matchdata::logaward(param_00);
	if(var_01 == 1)
	{
		maps\mp\_highlights::givehighlight(param_00,var_02);
	}
}

//Function Number: 35
func_3AB2(param_00,param_01)
{
	var_02 = tablelookup("mp/awardTable.csv",1,param_00,7);
	switch(var_02)
	{
		case "float":
			param_01 = maps\mp\_utility::func_4E13(param_01,2);
			param_01 = param_01 * 100;
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

	param_01 = int(param_01);
	return param_01;
}

//Function Number: 36
highestwins(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(var_03 maps\mp\_utility::func_634C() && var_03 func_7B2C(param_00) && !isdefined(param_01) || var_03 maps\mp\_utility::getplayerstat(param_00) >= param_01)
		{
			var_03 func_706A(param_00);
			if(!isawardflag(param_00))
			{
				var_03 func_7091(param_00);
			}
		}
	}
}

//Function Number: 37
func_4FA9(param_00,param_01)
{
	foreach(var_03 in level.players)
	{
		if(var_03 maps\mp\_utility::func_634C() && var_03 func_7B2C(param_00) && !isdefined(param_01) || var_03 maps\mp\_utility::getplayerstat(param_00) <= param_01)
		{
			var_03 setmatchrecordiflower(param_00);
			if(!isawardflag(param_00))
			{
				var_03 func_7092(param_00);
			}
		}
	}
}

//Function Number: 38
func_4FAA(param_00)
{
	var_01 = maps\mp\_utility::func_3C4B() / 1000;
	var_02 = var_01 * 0.5;
	foreach(var_04 in level.players)
	{
		if(var_04.hasspawned && var_04.timeplayed["total"] >= var_02)
		{
			var_04 setmatchrecordiflower(param_00);
			if(!isawardflag(param_00))
			{
				var_04 func_7092(param_00);
			}
		}
	}
}

//Function Number: 39
func_7B2C(param_00)
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
func_487A(param_00,param_01,param_02)
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
			var_04 maps\mp\_utility::func_70A0(param_00,var_05);
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
func_487C(param_00,param_01,param_02)
{
	var_03 = maps\mp\_utility::func_3C4B() / 1000;
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
func_70AE(param_00,param_01,param_02)
{
	foreach(var_04 in level.players)
	{
		var_05 = var_04 maps\mp\_utility::getplayerstat(param_01);
		var_06 = var_04 maps\mp\_utility::getplayerstat(param_02);
		if(var_06 == 0)
		{
			var_04 maps\mp\_utility::func_70A0(param_00,var_05);
			continue;
		}

		var_07 = var_05 / var_06;
		var_04 maps\mp\_utility::func_70A0(param_00,var_07);
	}
}

//Function Number: 44
getkillstreakawardref(param_00)
{
	switch(param_00)
	{
		case "counter_uav":
		case "directional_uav":
		case "uav_support":
		case "uav":
			return "uavs";

		case "super_airstrike":
		case "harrier_airstrike":
		case "stealth_airstrike":
		case "airstrike":
		case "precision_airstrike":
			return "airstrikes";

		case "littlebird_flock":
		case "helicopter_flares":
		case "helicopter_blackbox":
		case "helicopter_mk19":
		case "littlebird_support":
		case "helicopter_minigun":
		case "helicopter":
			return "helicopters";

		default:
			return undefined;
	}
}

//Function Number: 45
func_53B7()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("reload");
		maps\mp\_utility::func_447B("mostreloads",1);
	}
}

//Function Number: 46
func_53C0()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("weapon_fired");
		maps\mp\_utility::func_447B("mostshotsfired",1);
	}
}

//Function Number: 47
func_53CF()
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
		maps\mp\_utility::func_447B("mostswaps",1);
		if(!isdefined(self.usedweapons[var_01]))
		{
			self.usedweapons[var_01] = 1;
			maps\mp\_utility::func_447B("mostweaponsused",1);
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
			var_01 maps\mp\_utility::func_447B("distancetraveled",var_02);
			var_01.prevpos = var_01.origin;
			var_01.altitudepolls++;
			var_01.totalaltitudesum = var_01.totalaltitudesum + var_01.origin[2];
			var_03 = var_01.totalaltitudesum / var_01.altitudepolls;
			var_01 maps\mp\_utility::func_70A0("leastavgalt",var_03);
			var_01 maps\mp\_utility::func_70A0("greatestavgalt",var_03);
			wait(0.05);
		}

		wait(0.05);
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
	var_01 = squared(var_00);
	for(;;)
	{
		if(!isalive(self))
		{
			wait(0.5);
			self.lastcampchecked = gettime();
			self.positionarray = [];
			continue;
		}

		self.positionarray[self.positionarray.size] = self.origin;
		if(gettime() - self.lastcampchecked >= 15000)
		{
			if(distancesquared(self.positionarray[0],self.origin) < var_01 && distancesquared(self.positionarray[1],self.positionarray[0]) < var_01)
			{
				var_02 = gettime() - self.lastcampchecked;
				maps\mp\_utility::func_447B("timeinspot",var_02);
			}

			self.positionarray = [];
			self.lastcampchecked = gettime();
		}

		wait(5);
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
func_5383()
{
	level endon("game_ended");
	self endon("disconnect");
	while(level.players.size < 3)
	{
		wait(1);
	}

	for(;;)
	{
		if(level.players.size < 2)
		{
			wait(0.05);
			continue;
		}

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
			if(var_02[1].team != var_01.team)
			{
				var_01 maps\mp\_utility::func_447B("closertoenemies",0.05);
			}

			wait(0.05);
		}

		wait(0.05);
	}
}

//Function Number: 54
func_5386()
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

		maps\mp\_utility::func_447B("explosionssurvived",1);
		wait(0.05);
	}
}

//Function Number: 55
func_53BF()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("shield_blocked");
		maps\mp\_utility::func_447B("shieldblocks",1);
		wait(0.05);
	}
}

//Function Number: 56
func_538E()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("flash_hit");
		maps\mp\_utility::func_447B("fbhits",1);
		wait(0.05);
	}
}

//Function Number: 57
func_53CC()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		self waittill("stun_hit");
		maps\mp\_utility::func_447B("stunhits",1);
		wait(0.05);
	}
}

//Function Number: 58
func_53C7()
{
	level endon("game_ended");
	self endon("spawned_player");
	self endon("death");
	self endon("disconnect");
	for(;;)
	{
		if(self getstance() == "crouch")
		{
			maps\mp\_utility::func_447B("crouchtime",500);
		}
		else if(self getstance() == "prone")
		{
			maps\mp\_utility::func_447B("pronetime",500);
		}

		wait(0.5);
	}
}