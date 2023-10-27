/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_killcam.gsc
 * Game: Call of Duty: Modern Warfare Remastered
 * Platform: PC
 * Function Count: 22
 * Decompile Time: 344 ms
 * Timestamp: 10/27/2023 2:41:44 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.killcam = maps\mp\gametypes\_tweakables::gettweakablevalue("game","allowkillcam");
}

//Function Number: 2
setkillcamerastyle(param_00,param_01,param_02,param_03,param_04,param_05)
{
	return 0;
}

//Function Number: 3
prekillcamnotify(param_00,param_01,param_02,param_03)
{
	if(isplayer(self) && isdefined(param_01) && isplayer(param_01))
	{
		var_04 = gettime();
		waittillframeend;
		if(isplayer(self) && isdefined(param_01) && isplayer(param_01))
		{
			var_04 = gettime() - var_04 / 1000;
			var_05 = maps\mp\gametypes\_playerlogic::gatherclassweapons();
			var_06 = param_01 method_841F(param_02 + var_04,param_03,var_05);
			var_07 = spawnstruct();
			var_07.team = param_01.team;
			var_07.weapon = param_01.loadoutprimary;
			var_08 = spawnstruct();
			var_08.cust = var_07;
			var_08.weapons = var_06;
			self.killcamstream = var_08;
			self method_8420(var_07,var_06);
			self method_852C(param_03);
		}
	}
}

//Function Number: 4
killcamtime(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(getdvar("scr_killcam_time") == "")
	{
		var_07 = maps\mp\_utility::strip_suffix(param_01,"_lefthand");
		if(param_05 || param_01 == "artillery_mp")
		{
			var_08 = gettime() - param_00 / 1000 - param_02 - 0.1;
		}
		else if(param_06)
		{
			var_08 = 4;
		}
		else if(issubstr(param_01,"remotemissile_"))
		{
			var_08 = 5;
		}
		else if(!param_03)
		{
			var_08 = 5;
		}
		else if(var_07 == "h1_fraggrenade_mp" || var_07 == "h1_fraggrenadeshort_mp")
		{
			var_08 = 4.25;
		}
		else
		{
			var_08 = 2.5;
		}
	}
	else
	{
		var_08 = getdvarfloat("scr_killcam_time");
	}

	if(param_05 && var_08 > 5)
	{
		var_08 = 5;
	}

	if(isdefined(param_04))
	{
		if(var_08 > param_04)
		{
			var_08 = param_04;
		}

		if(var_08 < 0.05)
		{
			var_08 = 0.05;
		}
	}

	return var_08;
}

//Function Number: 5
killcamadjustalivetime(param_00,param_01,param_02)
{
	var_03 = 1000;
	if(isdefined(param_01) && isdefined(param_02) && param_01 != param_02)
	{
		return var_03;
	}

	return param_00;
}

//Function Number: 6
killcamarchivetime(param_00,param_01,param_02,param_03)
{
	if(param_00 > param_01)
	{
		param_00 = param_01;
	}

	var_04 = param_00 + param_02 + param_03;
	return var_04;
}

//Function Number: 7
killcamvalid(param_00,param_01)
{
	return param_01 && level.killcam && !isdefined(param_00.cancelkillcam) && param_00.cancelkillcam && game["state"] == "playing" && !param_00 maps\mp\_utility::isusingremote() && !level.showingfinalkillcam && !isagent(param_00);
}

//Function Number: 8
killcam(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D,param_0E,param_0F,param_10,param_11,param_12)
{
	self endon("disconnect");
	self endon("spawned");
	level endon("game_ended");
	if(param_01 < 0 || !isdefined(param_0D))
	{
		return;
	}

	level.numplayerswaitingtoenterkillcam++;
	var_13 = level.numplayerswaitingtoenterkillcam * 0.05;
	if(level.numplayerswaitingtoenterkillcam > 1)
	{
		wait(0.05 * level.numplayerswaitingtoenterkillcam - 1);
	}

	wait(0.05);
	level.numplayerswaitingtoenterkillcam--;
	var_14 = killcamtime(param_03,param_04,param_08,param_0B,param_0C,param_12,level.showingfinalkillcam);
	if(getdvar("scr_killcam_posttime") == "")
	{
		var_15 = 2;
	}
	else
	{
		var_15 = getdvarfloat("scr_killcam_posttime");
		if(var_15 < 0.05)
		{
			var_15 = 0.05;
		}
	}

	var_16 = var_14 + var_15;
	if(isdefined(param_0C) && var_16 > param_0C)
	{
		if(param_0C < 2)
		{
			return;
		}

		if(param_0C - var_14 >= 1)
		{
			var_15 = param_0C - var_14;
		}
		else
		{
			var_15 = 1;
			var_14 = param_0C - 1;
		}

		var_16 = var_14 + var_15;
	}

	self setclientomnvar("ui_killcam_end_milliseconds",0);
	if(isagent(param_0D) && !isdefined(param_0D.isactive))
	{
		return;
	}

	if(isplayer(param_0E))
	{
		self setclientomnvar("ui_killcam_victim_id",param_0E getentitynumber());
	}
	else
	{
		self setclientomnvar("ui_killcam_victim_id",-1);
	}

	if(isplayer(param_0D))
	{
		self setclientomnvar("ui_killcam_killedby_id",param_0D getentitynumber());
	}
	else if(isagent(param_0D))
	{
		self setclientomnvar("ui_killcam_killedby_id",-1);
	}

	if(maps\mp\_utility::iskillstreakweapon(param_04))
	{
		var_17 = maps\mp\_utility::getkillstreakrownum(level.killstreakwieldweapons[param_04]);
		self setclientomnvar("ui_killcam_killedby_killstreak",var_17);
		self setclientomnvar("ui_killcam_killedby_weapon",-1);
		self setclientomnvar("ui_killcam_killedby_weapon_custom",-1);
		self setclientomnvar("ui_killcam_killedby_weapon_alt",0);
		self setclientomnvar("ui_killcam_copycat",0);
	}
	else
	{
		var_18 = [];
		var_19 = getweaponbasename(param_04);
		if(isdefined(var_19))
		{
			if(maps\mp\_utility::ismeleemod(param_0F) && !maps\mp\gametypes\_weapons::isriotshield(param_04))
			{
				var_19 = "iw5_combatknife";
			}
			else
			{
				var_19 = maps\mp\_utility::strip_suffix(var_19,"_lefthand");
				var_19 = maps\mp\_utility::strip_suffix(var_19,"_mp");
			}

			self setclientomnvar("ui_killcam_killedby_weapon",param_05);
			self setclientomnvar("ui_killcam_killedby_weapon_custom",param_06);
			self setclientomnvar("ui_killcam_killedby_weapon_alt",param_07);
			self setclientomnvar("ui_killcam_killedby_killstreak",-1);
			if(var_19 != "iw5_combatknife")
			{
				var_18 = getweaponattachments(param_04);
			}

			self setclientomnvar("ui_killcam_copycat",0);
		}
		else
		{
			self setclientomnvar("ui_killcam_killedby_weapon",-1);
			self setclientomnvar("ui_killcam_killedby_weapon_custom",-1);
			self setclientomnvar("ui_killcam_killedby_weapon_alt",0);
			self setclientomnvar("ui_killcam_killedby_killstreak",-1);
			self setclientomnvar("ui_killcam_copycat",0);
		}
	}

	if(isplayer(param_0E) && param_0E.pers["nemesis_guid"] == param_0D.guid && param_0E.pers["nemesis_tracking"][param_0D.guid] >= 2)
	{
		self setclientomnvar("ui_killcam_killedby_nemesis",1);
	}
	else
	{
		self setclientomnvar("ui_killcam_killedby_nemesis",0);
	}

	if(!param_0B && !level.gameended)
	{
		self setclientomnvar("ui_killcam_text","skip");
	}
	else if(!level.gameended)
	{
		self setclientomnvar("ui_killcam_text","respawn");
	}
	else
	{
		self setclientomnvar("ui_killcam_text","none");
	}

	switch(param_10)
	{
		case "score":
			break;

		case "normal":
		default:
			break;
	}
}

//Function Number: 9
dofinalkillcamfx(param_00,param_01)
{
	if(isdefined(level.doingfinalkillcamfx))
	{
		return;
	}

	level.doingfinalkillcamfx = 1;
	var_02 = param_00;
	if(var_02 > 1)
	{
		var_02 = 1;
		wait(param_00 - 1);
	}

	setslowmotion(1,0.25,var_02);
	wait(var_02 + 0.5);
	setslowmotion(0.25,1,1);
	level.doingfinalkillcamfx = undefined;
}

//Function Number: 10
waittillkillcamover()
{
	self endon("abort_killcam");
	wait(self.killcamlength - 0.05);
}

//Function Number: 11
setkillcamentity(param_00,param_01,param_02)
{
	self endon("disconnect");
	self endon("killcam_ended");
	var_03 = gettime() - param_01 * 1000;
	if(param_02 > var_03)
	{
		wait(0.05);
		param_01 = self.archivetime;
		var_03 = gettime() - param_01 * 1000;
		if(param_02 > var_03)
		{
			wait(param_02 - var_03 / 1000);
		}
	}

	self.killcamentity = param_00;
}

//Function Number: 12
waitskipkillcambutton(param_00)
{
	self endon("disconnect");
	self endon("killcam_ended");
	while(self usebuttonpressed())
	{
		wait(0.05);
	}

	while(!self usebuttonpressed())
	{
		wait(0.05);
	}

	self.skippedkillcam = 1;
	if(isdefined(self.pers["totalKillcamsSkipped"]))
	{
		self.pers["totalKillcamsSkipped"]++;
	}

	if(param_00 <= 0)
	{
		maps\mp\_utility::clearlowermessage("kc_info");
	}

	self notify("abort_killcam");
}

//Function Number: 13
endkillcamifnothingtoshow()
{
	self endon("disconnect");
	self endon("killcam_ended");
	for(;;)
	{
		if(self.archivetime <= 0)
		{
			break;
		}

		wait(0.05);
	}

	self notify("abort_killcam");
}

//Function Number: 14
spawnedkillcamcleanup()
{
	self endon("disconnect");
	self endon("killcam_ended");
	self waittill("spawned");
	thread killcamcleanup(0);
}

//Function Number: 15
endedkillcamcleanup()
{
	self endon("disconnect");
	self endon("killcam_ended");
	level waittill("game_ended");
	thread killcamcleanup(1);
}

//Function Number: 16
killcamcleanup(param_00)
{
	self setclientomnvar("ui_killcam_end_milliseconds",0);
	self.killcam = undefined;
	if(isdefined(self.killcamstartedtimedeciseconds) && isplayer(self) && isdefined(self.lifeid) && maps\mp\_matchdata::canloglife(self.lifeid))
	{
		var_01 = maps\mp\_utility::gettimepasseddecisecondsincludingrounds();
		setmatchdata("lives",self.lifeid,"killcamWatchTimeDeciSeconds",maps\mp\_utility::clamptobyte(var_01 - self.killcamstartedtimedeciseconds));
	}

	if(!level.gameended)
	{
		maps\mp\_utility::clearlowermessage("kc_info");
	}

	thread maps\mp\gametypes\_spectating::setspectatepermissions();
	self notify("killcam_ended");
	if(!param_00)
	{
		return;
	}

	maps\mp\_utility::updatesessionstate("dead");
	maps\mp\_utility::clearkillcamstate();
}

//Function Number: 17
cancelkillcamonuse()
{
	self.cancelkillcam = 0;
	thread cancelkillcamonuse_specificbutton(::cancelkillcamusebutton,::cancelkillcamcallback);
}

//Function Number: 18
cancelkillcamusebutton()
{
	return self usebuttonpressed();
}

//Function Number: 19
cancelkillcamsafespawnbutton()
{
	return self fragbuttonpressed();
}

//Function Number: 20
cancelkillcamcallback()
{
	self.cancelkillcam = 1;
}

//Function Number: 21
cancelkillcamsafespawncallback()
{
	self.cancelkillcam = 1;
	self.wantsafespawn = 1;
}

//Function Number: 22
cancelkillcamonuse_specificbutton(param_00,param_01)
{
	self endon("death_delay_finished");
	self endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		if(!self [[ param_00 ]]())
		{
			wait(0.05);
			continue;
		}

		var_02 = 0;
		while(self [[ param_00 ]]())
		{
			var_02 = var_02 + 0.05;
			wait(0.05);
		}

		if(var_02 >= 0.5)
		{
			continue;
		}

		var_02 = 0;
		while(!self [[ param_00 ]]() && var_02 < 0.5)
		{
			var_02 = var_02 + 0.05;
			wait(0.05);
		}

		if(var_02 >= 0.5)
		{
			continue;
		}

		self [[ param_01 ]]();
	}
}