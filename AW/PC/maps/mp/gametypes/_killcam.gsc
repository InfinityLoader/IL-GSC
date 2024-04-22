/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: mp\gametypes\_killcam.gsc
 * Game: Call of Duty: Advanced Warfare
 * Platform: PC
 * Function Count: 24
 * Decompile Time: 371 ms
 * Timestamp: 4/22/2024 2:09:55 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.killcam = maps\mp\gametypes\_tweakables::gettweakablevalue("game","allowkillcam");
}

//Function Number: 2
setcinematiccamerastyle(param_00,param_01,param_02,param_03,param_04)
{
	self setclientomnvar("cam_scene_name",param_00);
	self setclientomnvar("cam_scene_lead",param_01);
	self setclientomnvar("cam_scene_support",param_02);
	if(isdefined(param_03))
	{
		self setclientomnvar("cam_scene_lead_alt",param_03);
	}
	else
	{
		self setclientomnvar("cam_scene_lead_alt",param_01);
	}

	if(isdefined(param_04))
	{
		self setclientomnvar("cam_scene_support_alt",param_04);
		return;
	}

	self setclientomnvar("cam_scene_support_alt",param_02);
}

//Function Number: 3
setkillcamerastyle(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(isdefined(param_00) && isdefined(param_00.agent_type))
	{
		if(param_00.agent_type == "dog")
		{
			setcinematiccamerastyle("killcam_dog",param_00 getentitynumber(),self getentitynumber());
		}
		else
		{
			setcinematiccamerastyle("killcam_agent",param_00 getentitynumber(),self getentitynumber());
		}
	}
	else if(isdefined(param_04) && isdefined(param_03) && param_03 == "orbital_laser_fov_mp" && param_05 == 5)
	{
		var_06 = -1;
		if(isdefined(param_04.body))
		{
			var_06 = param_04.body getentitynumber();
		}

		thread setcinematiccamerastyle("orbital_laser_killcam",param_01,param_04 getentitynumber(),param_01,var_06);
	}
	else if(param_02 >= 0)
	{
		setcinematiccamerastyle("unknown",-1,-1);
		return 0;
	}
	else if(level.showingfinalkillcam)
	{
		setcinematiccamerastyle("unknown",param_01,self getentitynumber());
	}
	else
	{
		setcinematiccamerastyle("unknown",param_01,-1);
	}

	return 1;
}

//Function Number: 4
isworldkillcam(param_00,param_01)
{
	if(isdefined(param_00) && param_00 getentitynumber() == worldentnumber() && isdefined(param_01) && isdefined(param_01.killcament))
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
prekillcamnotify(param_00,param_01,param_02,param_03)
{
	if(isplayer(self) && isdefined(param_01) && isplayer(param_01))
	{
		var_04 = maps\mp\gametypes\_playerlogic::gatherclassweapons();
		var_05 = gettime();
		wait 0.05;
		if(isplayer(self) && isdefined(param_01) && isplayer(param_01))
		{
			var_05 = gettime() - var_05 / 1000;
			self.streamweapons = self loadcustomizationplayerview(param_01,param_02 + var_05,param_03,var_04);
			self precachekillcamiconforweapon(param_03);
		}
	}
}

//Function Number: 6
killcamtime(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	if(getdvar("scr_killcam_time") == "")
	{
		var_07 = maps\mp\_utility::strip_suffix(param_01,"_lefthand");
		if(param_05 || param_01 == "artillery_mp" || param_01 == "stealth_bomb_mp" || param_01 == "killstreakmahem_mp")
		{
			var_08 = gettime() - param_00 / 1000 - param_02 - 0.1;
		}
		else if(param_06 || param_01 == "agent_mp")
		{
			var_08 = 4;
		}
		else if(issubstr(param_01,"remotemissile_"))
		{
			var_08 = 5;
		}
		else if(!param_03 || param_03 > 5)
		{
			var_08 = 5;
		}
		else if(var_07 == "frag_grenade_mp" || var_07 == "frag_grenade_short_mp" || var_07 == "semtex_mp" || var_07 == "semtexproj_mp" || var_07 == "thermobaric_grenade_mp" || var_07 == "frag_grenade_var_mp" || var_07 == "contact_grenade_var_mp" || var_07 == "semtex_grenade_var_mp")
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

//Function Number: 7
killcamarchivetime(param_00,param_01,param_02,param_03)
{
	if(param_00 > param_01)
	{
		param_00 = param_01;
	}

	var_04 = param_00 + param_02 + param_03;
	return var_04;
}

//Function Number: 8
killcamvalid(param_00,param_01)
{
	return param_01 && level.killcam && !isdefined(param_00.cancelkillcam) && param_00.cancelkillcam && game["state"] == "playing" && !param_00 maps\mp\_utility::isusingremote() && !level.showingfinalkillcam && !isai(param_00);
}

//Function Number: 9
killcam(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C,param_0D,param_0E)
{
	self endon("disconnect");
	self endon("spawned");
	level endon("game_ended");
	var_0F = isworldkillcam(param_00,param_09);
	if((param_01 < 0 || !isdefined(param_09)) && !var_0F)
	{
		return;
	}

	level.numplayerswaitingtoenterkillcam++;
	var_10 = level.numplayerswaitingtoenterkillcam * 0.05;
	if(level.numplayerswaitingtoenterkillcam > 1)
	{
		wait(0.05 * level.numplayerswaitingtoenterkillcam - 1);
	}

	wait(0.05);
	level.numplayerswaitingtoenterkillcam--;
	var_11 = killcamtime(param_03,param_04,param_05,param_07,param_08,param_0E,level.showingfinalkillcam);
	if(getdvar("scr_killcam_posttime") == "")
	{
		var_12 = 2;
	}
	else
	{
		var_12 = getdvarfloat("scr_killcam_posttime");
		if(var_12 < 0.05)
		{
			var_12 = 0.05;
		}
	}

	var_13 = var_11 + var_12;
	if(isdefined(param_08) && var_13 > param_08)
	{
		if(param_08 < 2)
		{
			return;
		}

		if(param_08 - var_11 >= 1)
		{
			var_12 = param_08 - var_11;
		}
		else
		{
			var_12 = 1;
			var_11 = param_08 - 1;
		}

		var_13 = var_11 + var_12;
	}

	self setclientomnvar("ui_killcam_end_milliseconds",0);
	if(isagent(param_09) && !isdefined(param_09.isactive))
	{
		return;
	}

	if(isplayer(param_09))
	{
		self setclientomnvar("ui_killcam_killedby_id",param_09 getentitynumber());
	}
	else if(isagent(param_09))
	{
		self setclientomnvar("ui_killcam_killedby_id",-1);
	}

	if(maps\mp\_utility::iskillstreakweapon(param_04))
	{
		var_14 = maps\mp\_utility::getkillstreakrownum(level.killstreakwieldweapons[param_04]);
		self setclientomnvar("ui_killcam_killedby_killstreak",var_14);
		self setclientomnvar("ui_killcam_killedby_weapon",-1);
		self setclientomnvar("ui_killcam_killedby_attachment1",-1);
		self setclientomnvar("ui_killcam_killedby_attachment2",-1);
		self setclientomnvar("ui_killcam_killedby_attachment3",-1);
		self setclientomnvar("ui_killcam_copycat",0);
	}
	else
	{
		var_15 = [];
		var_16 = getweaponbasename(param_04);
		if(isdefined(var_16))
		{
			if(maps\mp\_utility::ismeleemod(param_0B) && !maps\mp\gametypes\_weapons::isriotshield(param_04))
			{
				var_16 = "iw5_combatknife";
			}
			else
			{
				var_16 = maps\mp\_utility::strip_suffix(var_16,"_lefthand");
				var_16 = maps\mp\_utility::strip_suffix(var_16,"_mp");
			}

			var_17 = tablelookuprownum("mp/statsTable.csv",4,var_16);
			self setclientomnvar("ui_killcam_killedby_weapon",var_17);
			self setclientomnvar("ui_killcam_killedby_killstreak",-1);
			if(var_16 != "iw5_combatknife")
			{
				var_15 = getweaponattachments(param_04);
			}

			if(!level.showingfinalkillcam && maps\mp\_utility::practiceroundgame() && isplayer(param_09) && !isbot(self) && !isagent(self) && maps\mp\gametypes\_class::loadoutvalidforcopycat(param_09))
			{
				self setclientomnvar("ui_killcam_copycat",1);
				thread waitcopycatkillcambutton(param_09);
			}
			else
			{
				self setclientomnvar("ui_killcam_copycat",0);
			}
		}
		else
		{
			self setclientomnvar("ui_killcam_killedby_weapon",-1);
			self setclientomnvar("ui_killcam_killedby_killstreak",-1);
			self setclientomnvar("ui_killcam_copycat",0);
		}

		for(var_18 = 0;var_18 < 3;var_18++)
		{
			if(isdefined(var_15[var_18]))
			{
				var_19 = tablelookuprownum("mp/attachmentTable.csv",3,maps\mp\_utility::attachmentmap_tobase(var_15[var_18]));
				self setclientomnvar("ui_killcam_killedby_attachment" + var_18 + 1,var_19);
				continue;
			}

			self setclientomnvar("ui_killcam_killedby_attachment" + var_18 + 1,-1);
		}
	}

	if((param_07 && !level.gameended) || isdefined(self) && isdefined(self.battlebuddy) && !level.gameended)
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

	switch(param_0C)
	{
		case "score":
			self setclientomnvar("ui_killcam_type",1);
			break;

		case "normal":
		default:
			self setclientomnvar("ui_killcam_type",0);
			break;
	}

	var_1A = var_11 + param_05 + var_10;
	var_1B = gettime();
	self notify("begin_killcam",var_1B);
	if(!var_0F && !isagent(param_09) && isdefined(param_09) && isplayer(param_0A))
	{
		param_09 visionsyncwithplayer(param_0A);
	}

	maps\mp\_utility::updatesessionstate("spectator");
	self.spectatekillcam = 1;
	if(isagent(param_09))
	{
		param_01 = param_0A getentitynumber();
	}

	self onlystreamactiveweapon(0);
	if(var_0F)
	{
		self.forcespectatorclient = param_0A getentitynumber();
	}
	else
	{
		self.forcespectatorclient = param_01;
	}

	self.killcamentity = -1;
	var_1C = setkillcamerastyle(param_00,param_01,param_02,param_04,param_0A,var_11);
	if(!var_1C)
	{
		thread setkillcamentity(param_02,var_1A,param_03);
	}

	if(var_0F)
	{
		if(var_1A > gettime() / 1000)
		{
			var_1A = gettime() / 1000;
		}
	}
	else if(var_1A > param_0D)
	{
		var_1A = param_0D;
	}

	self.archivetime = var_1A;
	self.killcamlength = var_13;
	self.psoffsettime = param_06;
	self allowspectateteam("allies",1);
	self allowspectateteam("axis",1);
	self allowspectateteam("freelook",1);
	self allowspectateteam("none",1);
	if(level.multiteambased)
	{
		foreach(var_1E in level.teamnamelist)
		{
			self allowspectateteam(var_1E,1);
		}
	}

	foreach(var_1E in level.teamnamelist)
	{
		self allowspectateteam(var_1E,1);
	}

	thread endedkillcamcleanup();
	wait(0.05);
	if(!isdefined(self))
	{
		return;
	}

	if(self.archivetime < var_1A)
	{
	}

	var_11 = self.archivetime - 0.05 - param_05;
	var_13 = var_11 + var_12;
	self.killcamlength = var_13;
	if(var_11 <= 0)
	{
		maps\mp\_utility::updatesessionstate("dead");
		maps\mp\_utility::clearkillcamstate();
		self notify("killcam_ended");
		return;
	}

	self setclientomnvar("ui_killcam_end_milliseconds",int(var_13 * 1000) + gettime());
	if(level.showingfinalkillcam)
	{
		thread dofinalkillcamfx(var_11,param_02);
	}

	self.killcam = 1;
	if(isdefined(self.battlebuddy) && !level.gameended)
	{
		self.battlebuddyrespawntimestamp = gettime();
	}

	thread spawnedkillcamcleanup();
	self.skippedkillcam = 0;
	self.killcamstartedtimedeciseconds = maps\mp\_utility::gettimepasseddecisecondsincludingrounds();
	if(!level.showingfinalkillcam)
	{
		thread waitskipkillcambutton(param_07);
	}
	else
	{
		self notify("showing_final_killcam");
	}

	thread endkillcamifnothingtoshow();
	waittillkillcamover();
	if(level.showingfinalkillcam)
	{
		if(self == param_09)
		{
			param_09 maps\mp\gametypes\_missions::processchallenge("ch_precision_moviestar");
		}

		thread maps\mp\gametypes\_playerlogic::spawnendofgame();
		return;
	}

	thread killcamcleanup(1);
}

//Function Number: 10
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

//Function Number: 11
waittillkillcamover()
{
	self endon("abort_killcam");
	wait(self.killcamlength - 0.05);
}

//Function Number: 12
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

//Function Number: 13
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

//Function Number: 14
waitcopycatkillcambutton(param_00)
{
	self endon("disconnect");
	self endon("killcam_ended");
	self notifyonplayercommand("KillCamCopyCat","weapnext");
	self waittill("KillCamCopyCat");
	self setclientomnvar("ui_killcam_copycat",0);
	self playsound("copycat_steal_class");
	maps\mp\gametypes\_class::setcopycatloadout(param_00);
}

//Function Number: 15
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

//Function Number: 16
spawnedkillcamcleanup()
{
	self endon("disconnect");
	self endon("killcam_ended");
	self waittill("spawned");
	thread killcamcleanup(0);
}

//Function Number: 17
endedkillcamcleanup()
{
	self endon("disconnect");
	self endon("killcam_ended");
	level waittill("game_ended");
	thread killcamcleanup(1);
}

//Function Number: 18
killcamcleanup(param_00)
{
	self setclientomnvar("ui_killcam_end_milliseconds",0);
	setcinematiccamerastyle("unknown",-1,-1);
	self.killcam = undefined;
	if(isdefined(self.killcamstartedtimedeciseconds) && isplayer(self) && maps\mp\_matchdata::canloglife(self.lifeid))
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

//Function Number: 19
cancelkillcamonuse()
{
	self.cancelkillcam = 0;
	thread cancelkillcamonuse_specificbutton(::cancelkillcamusebutton,::cancelkillcamcallback);
}

//Function Number: 20
cancelkillcamusebutton()
{
	return self usebuttonpressed();
}

//Function Number: 21
cancelkillcamsafespawnbutton()
{
	return self fragbuttonpressed();
}

//Function Number: 22
cancelkillcamcallback()
{
	self.cancelkillcam = 1;
}

//Function Number: 23
cancelkillcamsafespawncallback()
{
	self.cancelkillcam = 1;
	self.wantsafespawn = 1;
}

//Function Number: 24
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