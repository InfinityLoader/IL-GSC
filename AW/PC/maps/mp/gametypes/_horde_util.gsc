/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_horde_util.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 51
 * Decompile Time: 767 ms
 * Timestamp: 4/22/2024 2:09:44 AM
*******************************************************************/

//Function Number: 1
isplayerinlaststand(param_00)
{
	return isdefined(param_00.laststand) && param_00.laststand;
}

//Function Number: 2
isonhumanteam(param_00)
{
	if(isdefined(param_00.team))
	{
		return param_00.team == level.playerteam;
	}

	return 0;
}

//Function Number: 3
isonhumanteamorspectator(param_00)
{
	if(isdefined(param_00.team))
	{
		if(param_00.team == level.playerteam || param_00.team == "spectator")
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 4
getnumplayers()
{
	var_00 = 0;
	if(!isdefined(level.players))
	{
		return 0;
	}

	foreach(var_02 in level.players)
	{
		if(isonhumanteam(var_02))
		{
			var_00++;
		}
	}

	return var_00;
}

//Function Number: 5
showteamsplashhorde(param_00)
{
	foreach(var_02 in level.players)
	{
		if(isonhumanteam(var_02) && maps\mp\_utility::isreallyalive(var_02))
		{
			var_02 thread maps\mp\gametypes\_hud_message::splashnotify(param_00);
		}
	}
}

//Function Number: 6
hasagentsquadmember(param_00)
{
	var_01 = 0;
	if(isagent(param_00))
	{
		return var_01;
	}

	foreach(var_03 in param_00.pers["killstreaks"])
	{
		if(isdefined(var_03) && isdefined(var_03.streakname) && var_03.available && var_03.streakname == "agent")
		{
			var_01 = 1;
			break;
		}
	}

	return var_01;
}

//Function Number: 7
getplayerweaponhorde(param_00)
{
	var_01 = param_00 getcurrentprimaryweapon();
	if(isdefined(param_00.changingweapon))
	{
		var_01 = param_00.changingweapon;
	}

	if(!maps\mp\gametypes\_weapons::isprimaryweapon(var_01))
	{
		var_01 = param_00 common_scripts\utility::getlastweapon();
	}

	if(!param_00 hasweapon(var_01))
	{
		var_01 = param_00 maps\mp\killstreaks\_killstreaks::getfirstprimaryweapon();
	}

	return var_01;
}

//Function Number: 8
playsoundtoallplayers(param_00)
{
	level endon("game_ended");
	foreach(var_02 in level.players)
	{
		if(!maps\mp\_utility::isreallyalive(var_02))
		{
			continue;
		}

		if(!isonhumanteam(var_02))
		{
			continue;
		}

		var_02 playsoundtoplayer(param_00,var_02);
	}
}

//Function Number: 9
refillammohorde(param_00)
{
	var_01 = param_00 getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		if(issubstr(var_03,"iw5_microdronelaunchercoop_mp"))
		{
			var_04 = param_00 setweaponammostock(var_03);
			var_05 = weaponmaxammo(var_03);
			var_06 = var_04 / var_05 + 0.5;
			param_00 givemaxammo(var_03,var_06);
			continue;
		}

		if(!issubstr(var_03,"turrethead"))
		{
			param_00 givemaxammo(var_03);
		}
	}
}

//Function Number: 10
getslotnumber(param_00)
{
	var_01 = undefined;
	var_02 = 2;
	var_03 = 5;
	for(var_04 = var_02;var_04 < var_03;var_04++)
	{
		var_05 = param_00.pers["killstreaks"][var_04];
		if(!isdefined(var_05) || !isdefined(var_05.streakname) || var_05.available == 0)
		{
			var_01 = var_04;
			break;
		}
	}

	return var_01;
}

//Function Number: 11
hordeenableweapons(param_00)
{
	param_00 endon("death");
	level endon("game_ended");
	level endon("stop_enable_weapons");
	for(;;)
	{
		param_00 waittill("luinotifyserver",var_01,var_02);
		if(var_01 == "horde_close_armory")
		{
			param_00 enableweapons();
			level notify("stop_enable_weapons");
		}

		wait 0.05;
	}
}

//Function Number: 12
awardhordekill(param_00)
{
	if(param_00.killz < 65535)
	{
		param_00.killz++;
	}

	param_00 sethordeplayerdata("killsTotal",param_00.killz);
	if(param_00.killz > param_00 gethordeplayerdata("killsBest"))
	{
		param_00 sethordeplayerdata("killsBest",param_00.killz);
	}

	param_00.kills = param_00.killz;
	param_00 maps\mp\_utility::setpersstat("kills",param_00.kills);
	param_00.roundkills++;
}

//Function Number: 13
awardhordeheadshots(param_00,param_01)
{
	param_00.hordeheadshots = param_00.hordeheadshots + param_01;
	if(param_00.hordeheadshots > 65535)
	{
		param_00.hordeheadshots = 65535;
	}

	param_00 maps\mp\_utility::setpersstat("headshots",param_01);
}

//Function Number: 14
awardhordemeleekills(param_00)
{
	if(param_00.meleekills < 65535)
	{
		param_00.meleekills++;
	}

	param_00 sethordeplayerdata("meleeKillsTotal",param_00.meleekills);
	if(param_00.meleekills > param_00 gethordeplayerdata("meleeKillsBest"))
	{
		param_00 sethordeplayerdata("meleeKillsBest",param_00.meleekills);
	}
}

//Function Number: 15
awardhordeheadshotkills(param_00)
{
	if(param_00.headshotkills < 65535)
	{
		param_00.headshotkills++;
	}

	param_00 sethordeplayerdata("headshotKillsTotal",param_00.headshotkills);
	if(param_00.headshotkills > param_00 gethordeplayerdata("headshotKillsBest"))
	{
		param_00 sethordeplayerdata("headshotKillsBest",param_00.headshotkills);
	}
}

//Function Number: 16
awardhordeobjectivescompleted(param_00)
{
	if(param_00.objectivescompleted < 65535)
	{
		param_00.objectivescompleted++;
	}

	param_00 sethordeplayerdata("objectivesTotal",param_00.objectivescompleted);
	if(param_00.objectivescompleted > param_00 gethordeplayerdata("objectivesBest"))
	{
		param_00 sethordeplayerdata("objectivesBest",param_00.objectivescompleted);
	}
}

//Function Number: 17
awardhordesupportdrop(param_00)
{
	if(param_00.numcratesobtained < 65535)
	{
		param_00.numcratesobtained++;
	}

	param_00 sethordeplayerdata("cratesTotal",param_00.numcratesobtained);
	if(param_00.numcratesobtained > param_00 gethordeplayerdata("cratesBest"))
	{
		param_00 sethordeplayerdata("cratesBest",param_00.numcratesobtained);
	}

	param_00.extrascore0 = param_00.numcratesobtained;
	param_00 maps\mp\_utility::setpersstat("extrascore0",param_00.numcratesobtained);
}

//Function Number: 18
awardhorderevive(param_00)
{
	if(param_00.numrevives < 65535)
	{
		param_00.numrevives++;
	}

	param_00 sethordeplayerdata("revivesTotal",param_00.numrevives);
	if(param_00.numrevives > param_00 gethordeplayerdata("revivesBest"))
	{
		param_00 sethordeplayerdata("revivesBest",param_00.numrevives);
	}

	param_00.assists = int(param_00.numrevives / 128);
	param_00.extrascore1 = param_00.numrevives % 128;
	param_00 maps\mp\_utility::setpersstat("assists",param_00.assists);
	param_00 maps\mp\_utility::setpersstat("extrascore1",param_00.extrascore1);
}

//Function Number: 19
awardhorderoundnumber(param_00)
{
	if(param_00.roundsplayed < 65535)
	{
		param_00.roundsplayed++;
	}

	param_00 sethordeplayerdata("roundsTotal",param_00.roundsplayed);
	if(param_00.roundsplayed > param_00 gethordeplayerdata("roundsBest"))
	{
		param_00 sethordeplayerdata("roundsBest",param_00.roundsplayed);
	}

	var_01 = hordegetmapindex();
	if(var_01 == -1)
	{
		return;
	}

	var_02 = 0;
	if(var_01 < 4)
	{
		var_02 = 1;
	}
	else if(var_01 < 8)
	{
		var_03 = 0;
		for(var_04 = 0;var_04 < 4;var_04++)
		{
			var_03 = var_03 + param_00 gethordeplayerdata("numWavesCompleted",var_04);
		}

		if(var_03 >= 50)
		{
			var_02 = 1;
		}
	}
	else if(var_01 < 12)
	{
		var_03 = 0;
		for(var_04 = 4;var_04 < 8;var_04++)
		{
			var_03 = var_03 + param_00 gethordeplayerdata("numWavesCompleted",var_04);
		}

		if(var_03 >= 75)
		{
			var_02 = 1;
		}
	}
	else if(var_01 == 12)
	{
		var_03 = 0;
		for(var_04 = 8;var_04 < 12;var_04++)
		{
			var_03 = var_03 + param_00 gethordeplayerdata("numWavesCompleted",var_04);
		}

		if(var_03 >= 100)
		{
			var_02 = 1;
		}
	}

	if(var_02)
	{
		var_05 = param_00 gethordeplayerdata("numWavesCompleted",var_01);
		if(var_05 < 65535)
		{
			var_05++;
		}

		param_00 sethordeplayerdata("numWavesCompleted",var_01,var_05);
		if(param_00.roundsplayed > param_00 gethordeplayerdata("highestWave",var_01))
		{
			param_00 sethordeplayerdata("highestWave",var_01,param_00.roundsplayed);
		}
	}
}

//Function Number: 20
awardhordweaponlevel(param_00,param_01)
{
}

//Function Number: 21
hordeupdatescore(param_00,param_01)
{
	param_00.horde_score = param_00.horde_score + param_01;
	if(param_00.horde_score > 16777215)
	{
		param_00.horde_score = 16777215;
	}

	param_00 sethordeplayerdata("scoreTotal",param_00.horde_score);
	if(param_00.horde_score > param_00 gethordeplayerdata("scoreBest"))
	{
		param_00 sethordeplayerdata("scoreBest",param_00.horde_score);
	}

	var_02 = int(0);
	var_03 = int(0);
	var_02 = int(param_00.horde_score / 512);
	var_03 = 511 - param_00.horde_score % 512;
	param_00.score = var_02;
	param_00.deaths = var_03;
	param_00 maps\mp\_utility::setpersstat("score",param_00.score);
	param_00 maps\mp\_utility::setpersstat("deaths",param_00.deaths);
}

//Function Number: 22
hordetriggeroff()
{
	self.origin = self.origin - (0,0,9999);
}

//Function Number: 23
hordetriggeron()
{
	self.origin = self.origin + (0,0,9999);
}

//Function Number: 24
hordegetclosesthealthyplayer(param_00)
{
	if(level.players.size == 0)
	{
		return undefined;
	}

	var_01 = [];
	foreach(var_03 in level.players)
	{
		if(var_03.ignoreme == 1 || var_03.sessionstate == "spectator")
		{
			continue;
		}

		var_01 = common_scripts\utility::array_add(var_01,var_03);
	}

	if(var_01.size > 0)
	{
		var_03 = common_scripts\utility::getclosest(param_00,var_01);
		return var_03;
	}

	return undefined;
}

//Function Number: 25
hordegetclosesthealthyenemy(param_00)
{
	if(level.players.size == 0)
	{
		return undefined;
	}

	var_01 = [];
	foreach(var_03 in level.players)
	{
		if(!var_03.ignoreme && var_03.sessionstate != "spectator")
		{
			var_01[var_01.size] = var_03;
		}

		if(isdefined(var_03.turret) && !var_03.iscarrying && isdefined(var_03.turret.damagetaken) && var_03.turret.damagetaken < var_03.turret.maxhealth)
		{
			var_01[var_01.size] = var_03.turret;
		}

		if(isdefined(var_03.aerialassaultdrone))
		{
			var_01[var_01.size] = var_03.aerialassaultdrone;
		}
	}

	var_05 = 500000000;
	var_06 = undefined;
	foreach(var_08 in var_01)
	{
		var_09 = distancesquared(var_08.origin,param_00.origin);
		if(var_09 < var_05)
		{
			var_05 = var_09;
			var_06 = var_08;
		}
	}

	return var_06;
}

//Function Number: 26
hordegetclosehealthyenemyforturret(param_00)
{
	var_01 = (0,0,72);
	var_02 = (0,0,60);
	var_03 = (0,0,40);
	if(level.players.size == 0)
	{
		return undefined;
	}

	var_04 = [];
	var_05 = [];
	foreach(var_07 in level.players)
	{
		if(!var_07.ignoreme && var_07.sessionstate != "spectator")
		{
			var_05[var_05.size] = var_07;
		}

		if(isdefined(var_07.turret) && !var_07.iscarrying && isdefined(var_07.turret.damagetaken) && var_07.turret.damagetaken < var_07.turret.maxhealth)
		{
			var_04[var_04.size] = var_07.turret;
		}

		if(isdefined(var_07.aerialassaultdrone))
		{
			var_04[var_04.size] = var_07.aerialassaultdrone;
		}
	}

	var_09 = 500000000;
	var_0A = undefined;
	foreach(var_07 in var_05)
	{
		var_0C = distancesquared(var_07.origin,param_00.origin);
		if(var_0C < var_09)
		{
			if(sighttracepassed(var_07.origin + var_01,param_00.origin + var_02,0,undefined))
			{
				var_09 = var_0C;
				var_0A = var_07;
			}
		}
	}

	if(isdefined(var_0A))
	{
		return var_0A;
	}

	var_09 = 500000000;
	foreach(var_0F in var_04)
	{
		var_0C = distancesquared(var_0F.origin,param_00.origin);
		if(var_0C < var_09)
		{
			var_10 = var_0F.origin;
			if(isdefined(var_0F.issentry) && var_0F.issentry)
			{
				var_10 = var_10 + var_03;
			}

			if(sighttracepassed(var_10,param_00.origin + var_03,0,self,var_0F))
			{
				var_09 = var_0C;
				var_0A = var_0F;
			}
		}
	}

	return var_0A;
}

//Function Number: 27
hordescorestreaksplash(param_00,param_01,param_02,param_03)
{
	param_00 notify("horde_score_streak_splash_request");
	param_00 endon("horde_score_streak_splash_request");
	while(param_00 getclientomnvar("ui_horde_show_armory") != 0)
	{
		wait 0.05;
	}

	param_00 thread maps\mp\gametypes\_hud_message::splashnotify(param_02,undefined,param_03);
	param_00 maps\mp\_utility::leaderdialogonplayer(param_01,"horde",0);
}

//Function Number: 28
horderemoveksicon(param_00,param_01,param_02)
{
	if(param_02 != 1)
	{
		var_03 = "ks_icon" + common_scripts\utility::tostring(param_02);
		self setclientomnvar(var_03,0);
	}
}

//Function Number: 29
hordeallowallboost(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "default";
	}

	maps\mp\_utility::playerallowdodge(param_00,param_01);
	maps\mp\_utility::playerallowpowerslide(param_00,param_01);
	maps\mp\_utility::playerallowhighjump(param_00,param_01);
}

//Function Number: 30
trygivehordeweapon(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_00 playlocalsound("ammo_crate_use");
	var_06 = param_00 getclientomnvar("ui_horde_player_class");
	if(isdefined(param_04))
	{
		var_07 = param_04;
	}
	else
	{
		var_07 = "none";
	}

	var_08 = param_00 getweaponslistprimaries();
	var_09 = getweaponbasename(param_01);
	if(var_08.size > 1 && !isdefined(param_00.underwater))
	{
		var_0A = 1;
		if(!isdefined(var_07) || var_07 == "none")
		{
			var_07 = param_00 getcurrentprimaryweapon();
		}

		param_00 takeweapon(var_07);
	}

	var_0B = param_00.weaponproficiency > 0 && isdefined(param_02) && param_02;
	if(var_0B)
	{
		param_00.updatinglootweapon = 1;
		var_0C = getweaponbasename(param_01);
		var_0D = getsubstr(param_01,var_0C.size);
		param_01 = var_0C + var_0D;
	}

	var_0E = [];
	if(getweaponbasename(param_01) == "iw5_microdronelaunchercoop_mp")
	{
		var_0E[var_0E.size] = "iw5_microdronelauncher_mp";
	}

	var_0E[var_0E.size] = param_01;
	var_0F = !param_00 loadweapons(var_0E);
	param_00.classweaponswait = var_0F;
	while(var_0F)
	{
		wait 0.05;
		var_0F = !param_00 loadweapons(var_0E);
	}

	param_00 loadweapons(maps\mp\gametypes\_horde_laststand::hordelaststandweapon());
	param_00 loadweapons(["iw5_microdronelauncher_mp"]);
	if(issubstr(param_01,"camo"))
	{
		param_01 = getsubstr(param_01,0,param_01.size - 7);
	}

	var_10 = getcamostring(param_00);
	var_11 = getcamoindex(param_00);
	param_00 maps\mp\_utility::_giveweapon(param_01,var_11);
	param_00 givemaxammo(param_01 + var_10,1);
	if(var_0B)
	{
		param_00.updatinglootweapon = 0;
	}

	if(isdefined(param_03) && param_03)
	{
		param_00 switchtoweaponimmediate(param_01 + var_10);
	}

	if(isdefined(param_05))
	{
		param_00.hordeclassweapons[var_06][param_05] = param_01 + var_10;
		return;
	}

	if(var_07 == param_00.hordeclassweapons[var_06]["primary"])
	{
		param_00.hordeclassweapons[var_06]["primary"] = param_01 + var_10;
		return;
	}

	param_00.hordeclassweapons[var_06]["secondary"] = param_01 + var_10;
}

//Function Number: 31
getcamostring(param_00)
{
	var_01 = "";
	if(param_00.weaponproficiency > 0)
	{
		var_01 = "_camo" + level.weaponcamoorder[param_00.weaponproficiency];
	}

	return var_01;
}

//Function Number: 32
getcamoindex(param_00)
{
	var_01 = 0;
	var_02 = "";
	if(param_00.weaponproficiency > 0)
	{
		var_02 = level.weaponcamoorder[param_00.weaponproficiency];
		var_02 = strip_prefix(var_02,"0");
		var_01 = int(var_02);
	}

	return var_01;
}

//Function Number: 33
hordegetweaponupgrades(param_00,param_01)
{
	var_02 = [];
	var_03 = [];
	var_04 = getweaponbasename(param_00);
	if(var_04 == param_00)
	{
		return var_02;
	}

	var_05 = getsubstr(param_00,var_04.size);
	var_06 = strtok(var_05,"_");
	for(var_07 = 0;var_07 < var_06.size;var_07++)
	{
		if(!issubstr(var_06[var_07],"camo"))
		{
			var_03[var_03.size] = var_06[var_07];
		}
	}

	return var_03;
}

//Function Number: 34
hordegetattachmentstring(param_00,param_01)
{
	var_02 = "";
	if(param_00.size)
	{
		var_03 = param_00.size;
		for(var_04 = 0;var_04 < var_03;var_04++)
		{
			if((issubstr(param_00[var_04],"optics") || issubstr(param_00[var_04],"reddot") || issubstr(param_00[var_04],"scope")) && issubstr(param_01,"optics") || issubstr(param_01,"reddot") || issubstr(param_01,"scope"))
			{
				param_00[var_04] = param_01;
				continue;
			}

			param_00[param_00.size] = param_01;
		}
	}
	else
	{
		param_00[0] = param_01;
	}

	param_00 = common_scripts\utility::array_remove_duplicates(param_00);
	param_00 = common_scripts\utility::alphabetize(param_00);
	for(var_04 = 0;var_04 < param_00.size;var_04++)
	{
		var_02 = var_02 + "_" + param_00[var_04];
	}

	return var_02;
}

//Function Number: 35
hordegetweaponbasenamespecial(param_00)
{
	var_01 = getweaponbasename(param_00);
	if(issubstr(param_00,"exoxmg"))
	{
		var_01 = "iw5_exoxmg_mp_akimboxmg";
	}
	else if(issubstr(param_00,"sac3"))
	{
		var_01 = "iw5_sac3_mp_akimbosac3";
	}
	else if(issubstr(param_00,"mors"))
	{
		var_01 = "iw5_mors_mp_morsscope";
	}
	else if(issubstr(param_00,"gm6"))
	{
		var_01 = "iw5_gm6_mp_gm6scope";
	}
	else if(issubstr(param_00,"m990"))
	{
		var_01 = "iw5_m990_mp_m990scope";
	}
	else if(issubstr(param_00,"thor"))
	{
		var_01 = "iw5_thor_mp_thorscope";
	}

	return var_01;
}

//Function Number: 36
hordegetweaponsuffixspecial(param_00)
{
	var_01 = "_mp";
	if(issubstr(param_00,"exoxmg"))
	{
		var_01 = "_mp_akimboxmg";
	}
	else if(issubstr(param_00,"sac3"))
	{
		var_01 = "_mp_akimbosac3";
	}
	else if(issubstr(param_00,"mors"))
	{
		var_01 = "_mp_morsscope";
	}
	else if(issubstr(param_00,"gm6"))
	{
		var_01 = "_mp_gm6scope";
	}
	else if(issubstr(param_00,"m990"))
	{
		var_01 = "_mp_m990scope";
	}
	else if(issubstr(param_00,"thor"))
	{
		var_01 = "_mp_thorscope";
	}

	return var_01;
}

//Function Number: 37
cointossweighted(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 50;
	}

	return randomint(100) <= param_00;
}

//Function Number: 38
hordegetmapindex()
{
	var_00 = ["mp_lab2","mp_venus","mp_detroit","mp_refraction","mp_levity","mp_comeback","mp_terrace","mp_instinct","mp_greenband","mp_solar","mp_recovery","mp_laser2","mp_prison_z"];
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		if(maps\mp\_utility::getmapname() == var_00[var_01])
		{
			return var_01;
		}
	}

	return -1;
}

//Function Number: 39
hordecleardata(param_00)
{
	param_00 sethordeplayerdata("roundsTotal",0);
	param_00 sethordeplayerdata("matchesTotal",0);
	param_00 sethordeplayerdata("scoreTotal",0);
	param_00 sethordeplayerdata("killsTotal",0);
	param_00 sethordeplayerdata("cratesTotal",0);
	param_00 sethordeplayerdata("revivesTotal",0);
	param_00 sethordeplayerdata("objectivesTotal",0);
	param_00 sethordeplayerdata("meleeKillsTotal",0);
	param_00 sethordeplayerdata("headshotKillsTotal",0);
	param_00 sethordeplayerdata("timePlayedTotal",0);
}

//Function Number: 40
hordecompletetu1transition(param_00)
{
	for(var_01 = 0;var_01 < 13;var_01++)
	{
		var_02 = param_00 gethordeplayerdata("highestWave",var_01);
		var_03 = param_00 gethordeplayerdata("numWavesCompleted",var_01);
		if(var_02 > var_03)
		{
			param_00 sethordeplayerdata("numWavesCompleted",var_01,var_02);
		}
	}
}

//Function Number: 41
hordeupdatetimestats(param_00)
{
	var_01 = int(getomnvar("ui_game_duration") / 1000);
	param_00 sethordeplayerdata("timePlayedTotal",var_01);
	if(var_01 > param_00 gethordeplayerdata("timePlayedBest"))
	{
		param_00 sethordeplayerdata("timePlayedBest",var_01);
	}

	check_class_time(param_00);
}

//Function Number: 42
givegearforwavescompleted(param_00)
{
	var_01 = param_00 gethordeplayerdata("numWaves");
	if(var_01 < 32767)
	{
		var_01++;
		param_00 sethordeplayerdata("numWaves",var_01);
	}

	if(var_01 > 199 && !param_00 gethordeplayerdata("requirement_beat200Waves"))
	{
		param_00 sethordeplayerdata("requirement_beat200Waves",1);
		param_00 setclientomnvar("ui_horde_loot_unlocked",1);
		return;
	}

	if(var_01 > 99 && !param_00 gethordeplayerdata("requirement_beat100Waves"))
	{
		param_00 sethordeplayerdata("requirement_beat100Waves",1);
		param_00 setclientomnvar("ui_horde_loot_unlocked",1);
		return;
	}

	if(var_01 > 49 && !param_00 gethordeplayerdata("requirement_beat50Waves"))
	{
		param_00 sethordeplayerdata("requirement_beat50Waves",1);
		param_00 setclientomnvar("ui_horde_loot_unlocked",1);
		return;
	}
}

//Function Number: 43
givegearformapsplayed(param_00)
{
	var_01 = hordegetmapindex();
	if(var_01 == -1)
	{
		return;
	}

	if(!param_00 gethordeplayerdata("requirement_unlockedTier2"))
	{
		var_02 = 0;
		for(var_03 = 0;var_03 < 4;var_03++)
		{
			var_02 = var_02 + param_00 gethordeplayerdata("numWavesCompleted",var_03);
		}

		if(var_01 < 4)
		{
			var_02 = var_02 + param_00.roundsplayed;
		}

		if(var_02 >= 50)
		{
			param_00 sethordeplayerdata("requirement_unlockedTier2",1);
			param_00 setclientomnvar("ui_horde_loot_unlocked",1);
			return;
		}

		return;
	}

	if(!param_00 gethordeplayerdata("requirement_unlockedTier3"))
	{
		var_02 = 0;
		for(var_03 = 4;var_03 < 8;var_03++)
		{
			var_02 = var_02 + param_00 gethordeplayerdata("numWavesCompleted",var_03);
		}

		if(var_01 >= 4 && var_01 < 8)
		{
			var_02 = var_02 + param_00.roundsplayed;
		}

		if(var_02 >= 75)
		{
			param_00 sethordeplayerdata("requirement_unlockedTier3",1);
			param_00 setclientomnvar("ui_horde_loot_unlocked",1);
			return;
		}

		return;
	}

	if(!param_00 gethordeplayerdata("requirement_unlockedPrison"))
	{
		var_02 = 0;
		for(var_03 = 8;var_03 < 12;var_03++)
		{
			var_02 = var_02 + param_00 gethordeplayerdata("numWavesCompleted",var_03);
		}

		if(var_01 >= 8 && var_01 < 12)
		{
			var_02 = var_02 + param_00.roundsplayed;
		}

		if(var_02 >= 100)
		{
			param_00 sethordeplayerdata("requirement_unlockedPrison",1);
			param_00 setclientomnvar("ui_horde_loot_unlocked",1);
			return;
		}

		return;
	}

	if(!param_00 gethordeplayerdata("requirement_playedAllMaps"))
	{
		var_04 = 1;
		for(var_03 = 0;var_03 < 13;var_03++)
		{
			if(param_00 gethordeplayerdata("numWavesCompleted",var_03) == 0 && var_01 != var_03)
			{
				var_04 = 0;
				break;
			}
		}

		if(var_04)
		{
			param_00 sethordeplayerdata("requirement_playedAllMaps",1);
			param_00 setclientomnvar("ui_horde_loot_unlocked",1);
			return;
		}

		return;
	}
}

//Function Number: 44
givegearformaxweaponproficiency(param_00)
{
	if(!param_00 gethordeplayerdata("requirement_maxWeaponProficiency"))
	{
		if(param_00.weaponproficiency > 9)
		{
			param_00 sethordeplayerdata("requirement_maxWeaponProficiency",1);
			param_00 setclientomnvar("ui_horde_loot_unlocked",1);
		}
	}
}

//Function Number: 45
givegearformaxarmorproficiency(param_00)
{
	if(!param_00 gethordeplayerdata("requirement_maxArmorProficiency"))
	{
		if(param_00.hordearmor > 9)
		{
			param_00 sethordeplayerdata("requirement_maxArmorProficiency",1);
			param_00 setclientomnvar("ui_horde_loot_unlocked",1);
		}
	}
}

//Function Number: 46
strip_prefix(param_00,param_01)
{
	if(param_00.size <= param_01.size)
	{
		return param_00;
	}

	if(getsubstr(param_00,0,param_01.size) == param_01)
	{
		return getsubstr(param_00,param_01.size,param_00.size);
	}

	return param_00;
}

//Function Number: 47
hordeupdatenummatches(param_00)
{
	param_00.exosurvivalmatches = param_00 gethordeplayerdata("numMatches");
	if(param_00.exosurvivalmatches < 32767)
	{
		param_00.exosurvivalmatches = param_00.exosurvivalmatches + 1;
		param_00 sethordeplayerdata("numMatches",param_00.exosurvivalmatches);
	}

	if(param_00.exosurvivalmatches == 50)
	{
		param_00 giveachievement("COOP_VETERAN");
	}
}

//Function Number: 48
check_class_time(param_00)
{
	var_01 = param_00 getclientomnvar("ui_horde_player_class");
	param_00.hordeclassendtime = gettime();
	if(isdefined(param_00.hordeclassstarttime))
	{
		var_02 = int(param_00.hordeclassendtime - param_00.hordeclassstarttime / 100);
		var_03 = 0;
		switch(var_01)
		{
			case "light":
				var_03 = param_00 gethordeplayerdata("lightClassTime");
				if(isdefined(var_03))
				{
					var_03 = var_03 + int(var_02 / 10);
					if(var_03 <= 7200)
					{
						param_00 sethordeplayerdata("lightClassTime",var_03);
					}
				}
				break;

			case "heavy":
				var_03 = param_00 gethordeplayerdata("heavyClassTime");
				if(isdefined(var_03))
				{
					var_03 = var_03 + int(var_02 / 10);
					if(var_03 <= 7200)
					{
						param_00 sethordeplayerdata("heavyClassTime",var_03);
					}
				}
				break;

			case "support":
				var_03 = param_00 gethordeplayerdata("specialistClassTime");
				if(isdefined(var_03))
				{
					var_03 = var_03 + int(var_02 / 10);
					if(var_03 <= 7200)
					{
						param_00 sethordeplayerdata("specialistClassTime",var_03);
					}
				}
				break;
		}
	}

	var_04 = param_00 gethordeplayerdata("lightClassTime");
	var_05 = param_00 gethordeplayerdata("heavyClassTime");
	var_06 = param_00 gethordeplayerdata("specialistClassTime");
	if(isdefined(var_04) && isdefined(var_05) && isdefined(var_06))
	{
		if(var_04 >= 1800 && var_05 >= 1800 && var_06 >= 1800)
		{
			param_00 giveachievement("COOP_WARFARE");
		}
	}

	param_00.hordeclassstarttime = gettime();
}

//Function Number: 49
hordegivebackgoliath(param_00)
{
	if(param_00)
	{
		self notify("cancel_goliath_wait");
		self setclientomnvar("ks_count1",0);
		self setclientomnvar("ks_count_updated",1);
		self.classabilityready = 1;
		var_01 = maps\mp\killstreaks\_killstreaks::getnexthordekillstreakslotindex(1);
		thread maps\mp\killstreaks\_killstreaks::givehordekillstreak(self.currentkillstreaks[1],level.owner,self.hordekillstreakmodules,1,1);
		thread hordescorestreaksplash(self,self.currentkillstreaks[1],"horde_ss_splash_" + self.currentkillstreaks[1],var_01);
		self notify("ability_regenerated");
		return;
	}

	maps\mp\gametypes\_horde_armory::hordegivekillstreak("heavy_exosuit",1007);
}

//Function Number: 50
hordeonunderwater(param_00)
{
	if(isplayer(self))
	{
		if(isdefined(level.objuplink) && level.objuplink)
		{
			var_01 = 1;
			foreach(var_03 in level.balls)
			{
				if(isdefined(var_03.carrier) && var_03.carrier == self)
				{
					self.water_last_weapon = maps\mp\gametypes\_gameobjects::getcarrierweaponcurrent(var_03);
					var_03 thread maps\mp\gametypes\_gameobjects::setdropped();
					var_01 = 0;
				}
			}

			if(var_01)
			{
				if(self getcurrentweapon() == "iw5_carrydrone_mp" && isdefined(self.changingweapon))
				{
					self.water_last_weapon = self.changingweapon;
				}
				else if(isdefined(self.pass_or_throw_active) && self.pass_or_throw_active)
				{
					var_05 = self getweaponslistprimaries();
					self.water_last_weapon = common_scripts\utility::ter_op(var_05.size,var_05[0],undefined);
				}
			}
		}

		var_06 = "none";
		if(isdefined(self.water_last_weapon))
		{
			var_06 = self.water_last_weapon;
		}

		maps\mp\gametypes\_weapons::saveweapon("underwater",var_06,level.shallow_water_weapon);
	}
}

//Function Number: 51
hordedropandresetuplinkball()
{
	if(isdefined(self.ball_carried))
	{
		var_00 = self.ball_carried;
		var_00 maps\mp\gametypes\horde_ball::ball_set_dropped(1);
		var_00 maps\mp\gametypes\horde_ball::ball_return_home();
	}
}