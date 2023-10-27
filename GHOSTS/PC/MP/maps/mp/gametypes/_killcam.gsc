/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_killcam.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 306 ms
 * Timestamp: 10/27/2023 1:18:39 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.killcam = maps\mp\gametypes\_tweakables::func_3C5B("game","allowkillcam");
}

//Function Number: 2
func_7001(param_00,param_01,param_02)
{
	self setclientomnvar("cam_scene_name",param_00);
	self setclientomnvar("cam_scene_lead",param_01);
	self setclientomnvar("cam_scene_support",param_02);
}

//Function Number: 3
func_705E(param_00,param_01,param_02,param_03,param_04,param_05)
{
	param_05.camerastyle = "unknown";
	if(isdefined(param_01) && isdefined(param_01.agent_type))
	{
		if(param_01.agent_type == "dog" || param_01.agent_type == "wolf")
		{
			func_7001("killcam_dog",param_00 getentitynumber(),param_03 getentitynumber());
			param_05.camerastyle = "killcam_dog";
		}
		else if(param_01.agent_type == "beastmen")
		{
			func_7001("killcam_agent_firstperson",param_00 getentitynumber(),param_03 getentitynumber());
			param_05.camerastyle = "killcam_agent_firstperson";
		}
		else
		{
			func_7001("killcam_agent",param_00 getentitynumber(),param_03 getentitynumber());
			param_05.camerastyle = "killcam_agent";
		}

		return 1;
	}
	else if(param_04 > 0)
	{
		func_7001("unknown",-1,-1);
		return 0;
	}
	else
	{
		func_7001("unknown",-1,-1);
		return 0;
	}

	return 0;
}

//Function Number: 4
func_83C2(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = param_05 + param_06;
	if(isdefined(param_08) && var_09 > param_08)
	{
		if(param_08 < 2)
		{
		}

		if(param_08 - param_05 >= 1)
		{
			param_06 = param_08 - param_05;
		}
		else
		{
			param_06 = 1;
			param_05 = param_08 - 1;
		}

		var_09 = param_05 + param_06;
	}

	var_0A = param_05 + param_07;
	if(isdefined(param_01) && isdefined(param_01.lastspawntime))
	{
		var_0B = param_01.lastspawntime;
	}
	else
	{
		var_0B = param_03.lastspawntime;
		if(isdefined(param_02.deathtime))
		{
			if(gettime() - param_02.deathtime < param_06 * 1000)
			{
				param_06 = 1;
				param_06 = param_06 - 0.05;
				var_09 = param_05 + param_06;
			}
		}
	}

	var_0C = gettime() - var_0B / 1000;
	if(var_0A > var_0C && var_0C > param_07)
	{
		var_0D = var_0C - param_07;
		if(param_05 > var_0D)
		{
			param_05 = var_0D;
			var_09 = param_05 + param_06;
			var_0A = param_05 + param_07;
		}
	}

	var_0E = spawnstruct();
	var_0E.camtime = param_05;
	var_0E.postdelay = param_06;
	var_0E.killcamlength = var_09;
	var_0E.killcamoffset = var_0A;
	return var_0E;
}

//Function Number: 5
prekillcamnotify(param_00,param_01)
{
	if(isdefined(param_01) && !isagent(param_01))
	{
		self loadcustomizationplayerview(param_01);
	}
}

//Function Number: 6
killcam(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B,param_0C)
{
	self endon("disconnect");
	self endon("spawned");
	level endon("game_ended");
	if(param_02 < 0 || !isdefined(param_0A))
	{
	}

	level.numplayerswaitingtoenterkillcam++;
	if(level.numplayerswaitingtoenterkillcam > 1)
	{
		wait(0.05 * level.numplayerswaitingtoenterkillcam - 1);
	}

	wait(0.05);
	level.numplayerswaitingtoenterkillcam--;
	if(getdvar("scr_killcam_time") == "")
	{
		if(param_05 == "artillery_mp" || param_05 == "stealth_bomb_mp" || param_05 == "warhawk_mortar_mp")
		{
			var_0D = gettime() - param_04 / 1000 - param_06 - 0.1;
		}
		else if(param_06 == "remote_mortar_missile_mp")
		{
			var_0D = 6.5;
		}
		else if(level.showingfinalkillcam)
		{
			var_0D = 4;
		}
		else if(param_06 == "apache_minigun_mp")
		{
			var_0D = 3;
		}
		else if(param_06 == "javelin_mp")
		{
			var_0D = 8;
		}
		else if(issubstr(param_06,"remotemissile_"))
		{
			var_0D = 5;
		}
		else if(isdefined(param_01.sentrytype) && param_01.sentrytype == "multiturret")
		{
			var_0D = 2;
		}
		else if(isdefined(param_01.carestrike))
		{
			var_0D = 2;
		}
		else if(!param_09 || param_09 > 5)
		{
			var_0D = 5;
		}
		else if(param_06 == "frag_grenade_mp" || param_06 == "frag_grenade_short_mp" || param_06 == "semtex_mp" || param_06 == "semtexproj_mp" || param_06 == "thermobaric_grenade_mp" || param_06 == "mortar_shell__mp")
		{
			var_0D = 4.25;
		}
		else
		{
			var_0D = 2.5;
		}
	}
	else
	{
		var_0D = getdvarfloat("scr_killcam_time");
	}

	if(isdefined(param_09))
	{
		if(var_0D > param_09)
		{
			var_0D = param_09;
		}

		if(var_0D < 0.05)
		{
			var_0D = 0.05;
		}
	}

	if(getdvar("scr_killcam_posttime") == "")
	{
		var_0E = 2;
	}
	else
	{
		var_0E = getdvarfloat("scr_killcam_posttime");
		if(var_0E < 0.05)
		{
			var_0E = 0.05;
		}
	}

	if(param_02 < 0 || !isdefined(param_0A))
	{
	}

	var_0F = func_83C2(param_00,param_01,param_0A,param_0B,param_03,var_0D,var_0E,param_06,param_09);
	if(!isdefined(var_0F))
	{
	}

	self setclientomnvar("ui_killcam_end_milliseconds",0);
	if(isplayer(param_0A))
	{
		self setclientomnvar("ui_killcam_killedby_id",param_0A getentitynumber());
		self setclientomnvar("ui_killcam_victim_id",param_0B getentitynumber());
		self loadcustomizationplayerview(param_0A);
	}

	if(maps\mp\_utility::func_48F7(param_05))
	{
		if(param_0C == "MOD_MELEE" && maps\mp\killstreaks\_killstreaks::isairdropmarker(param_05))
		{
			var_10 = tablelookuprownum("mp/statsTable.csv",4,"iw6_knifeonly");
			self setclientomnvar("ui_killcam_killedby_weapon",var_10);
			self setclientomnvar("ui_killcam_killedby_killstreak",-1);
		}
		else
		{
			var_11 = maps\mp\_utility::getkillstreakrownum(level.killstreakweildweapons[param_05]);
			self setclientomnvar("ui_killcam_killedby_killstreak",var_11);
			self setclientomnvar("ui_killcam_killedby_weapon",-1);
			self setclientomnvar("ui_killcam_killedby_attachment1",-1);
			self setclientomnvar("ui_killcam_killedby_attachment2",-1);
			self setclientomnvar("ui_killcam_killedby_attachment3",-1);
			self setclientomnvar("ui_killcam_killedby_attachment4",-1);
		}
	}
	else
	{
		var_12 = [];
		var_13 = getweaponbasename(param_05);
		if(isdefined(var_13))
		{
			if(param_0C == "MOD_MELEE" && !maps\mp\gametypes\_weapons::func_494E(param_05))
			{
				var_13 = "iw6_knifeonly";
			}
			else
			{
				var_13 = maps\mp\_utility::func_8DAC(var_13);
				var_13 = maps\mp\_utility::func_7CEA(var_13,"_mp");
			}

			var_10 = tablelookuprownum("mp/statsTable.csv",4,var_13);
			self setclientomnvar("ui_killcam_killedby_weapon",var_10);
			self setclientomnvar("ui_killcam_killedby_killstreak",-1);
			if(var_13 != "iw6_knifeonly")
			{
				var_12 = getweaponattachments(param_05);
			}
		}
		else
		{
			self setclientomnvar("ui_killcam_killedby_weapon",-1);
			self setclientomnvar("ui_killcam_killedby_killstreak",-1);
		}

		for(var_14 = 0;var_14 < 4;var_14++)
		{
			if(isdefined(var_12[var_14]))
			{
				var_15 = tablelookuprownum("mp/attachmentTable.csv",4,maps\mp\_utility::attachmentmap_tobase(var_12[var_14]));
				self setclientomnvar("ui_killcam_killedby_attachment" + var_14 + 1,var_15);
				continue;
			}

			self setclientomnvar("ui_killcam_killedby_attachment" + var_14 + 1,-1);
		}

		var_16 = [0,0];
		var_17 = param_0A.pers["loadoutPerks"];
		for(var_14 = 0;var_14 < var_17.size;var_14++)
		{
			var_18 = int(tablelookup("mp/killCamAbilitiesBitMaskTable.csv",1,var_17[var_14],0));
			if(var_18 == 0)
			{
				continue;
			}

			var_19 = int(var_18 - 1 / 24);
			var_1A = 1 << var_18 - 1 % 24;
			var_16[var_19] = var_16[var_19] | var_1A;
		}

		self setclientomnvar("ui_killcam_killedby_abilities1",var_16[0]);
		self setclientomnvar("ui_killcam_killedby_abilities2",var_16[1]);
	}

	var_1B = getdvarint("scr_player_forcerespawn");
	if((param_08 && !level.gameended) || isdefined(self) && isdefined(self.battlebuddy) && !level.gameended || var_1B == 0 && !level.gameended)
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

	var_1C = gettime();
	self notify("begin_killcam",var_1C);
	if(!isagent(param_0A) && isdefined(param_0A))
	{
		param_0A visionsyncwithplayer(param_0B);
	}

	maps\mp\_utility::func_8730("spectator","hud_status_dead");
	self.spectatekillcam = 1;
	if(isagent(param_0A) || isagent(param_00))
	{
		param_02 = param_0B getentitynumber();
		param_07 = param_07 - 25;
	}

	self.forcespectatorclient = param_02;
	self.killcamentity = -1;
	var_1D = func_705E(param_00,param_01,param_02,param_0B,param_03,var_0F);
	if(!var_1D)
	{
		thread func_705D(param_03,var_0F.killcamoffset,param_04);
	}

	self.archivetime = var_0F.killcamoffset;
	self.killcamlength = var_0F.killcamlength;
	self.psoffsettime = param_07;
	self allowspectateteam("allies",1);
	self allowspectateteam("axis",1);
	self allowspectateteam("freelook",1);
	self allowspectateteam("none",1);
	if(level.multiteambased)
	{
		foreach(var_1F in level.teamnamelist)
		{
			self allowspectateteam(var_1F,1);
		}
	}

	thread endedkillcamcleanup();
	wait(0.05);
	if(!isdefined(self))
	{
	}

	if(self.archivetime < var_0F.killcamoffset)
	{
		var_21 = var_0F.killcamoffset - self.archivetime;
		if(game["truncated_killcams"] < 32)
		{
			setmatchdata("killcam",game["truncated_killcams"],var_21);
			game["truncated_killcams"]++;
		}
	}

	var_0F.camtime = self.archivetime - 0.05 - param_06;
	var_0F.killcamlength = var_0F.camtime + var_0F.postdelay;
	self.killcamlength = var_0F.killcamlength;
	if(var_0F.camtime <= 0)
	{
		maps\mp\_utility::func_8730("dead");
		maps\mp\_utility::clearkillcamstate();
		self notify("killcam_ended");
	}

	var_22 = level.showingfinalkillcam;
	self setclientomnvar("ui_killcam_end_milliseconds",int(var_0F.killcamlength * 1000) + gettime());
	if(var_22)
	{
		self setclientomnvar("ui_killcam_victim_or_attacker",1);
	}

	if(var_22)
	{
		thread dofinalkillcamfx(var_0F,self.killcamentity,param_0A,param_0B,param_0C);
	}

	self.killcam = 1;
	if(isdefined(self.battlebuddy) && !level.gameended)
	{
		self.battlebuddyrespawntimestamp = gettime();
	}

	thread func_786C();
	if(!level.showingfinalkillcam)
	{
		thread waitskipkillcambutton(param_08);
	}
	else
	{
		self notify("showing_final_killcam");
	}

	thread endkillcamifnothingtoshow();
	func_8BBC();
	if(level.showingfinalkillcam)
	{
		thread maps\mp\gametypes\_playerlogic::spawnendofgame();
	}

	thread calculatekillcamtime(var_1C);
	thread killcamcleanup(1);
}

//Function Number: 7
dofinalkillcamfx(param_00,param_01,param_02,param_03,param_04)
{
	self endon("killcam_ended");
	if(isdefined(level.doingfinalkillcamfx))
	{
	}

	level.doingfinalkillcamfx = 1;
	var_05 = param_00.camtime;
	var_06 = 0;
	var_07 = param_03 getentitynumber();
	if(!isdefined(param_00.attackernum))
	{
		param_00.attackernum = param_02 getentitynumber();
	}

	var_08 = var_05;
	if(var_08 > 1)
	{
		var_08 = 1;
		var_06 = var_06 + 1;
		wait(var_05 - var_06);
	}

	setslowmotion(1,0.25,var_08);
	wait(var_08 + 0.5);
	setslowmotion(0.25,1,1);
	level.doingfinalkillcamfx = undefined;
}

//Function Number: 8
calculatekillcamtime(param_00)
{
	var_01 = int(gettime() - param_00);
	maps\mp\_utility::func_447B("killcamtimewatched",var_01);
}

//Function Number: 9
func_8BBC()
{
	self endon("abort_killcam");
	wait(self.killcamlength - 0.05);
}

//Function Number: 10
func_705D(param_00,param_01,param_02)
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

//Function Number: 11
waitskipkillcambutton(param_00)
{
	self endon("disconnect");
	self endon("killcam_ended");
	if(!isai(self))
	{
		self notifyonplayercommand("kc_respawn","+usereload");
		self notifyonplayercommand("kc_respawn","+activate");
		self waittill("kc_respawn");
		self.var_19A0 = 1;
		if(!maps\mp\_utility::func_50C1())
		{
			maps\mp\_utility::func_447B("killcamskipped",1);
		}

		if(param_00 <= 0)
		{
			maps\mp\_utility::func_1D47("kc_info");
		}

		self notify("abort_killcam");
	}
}

//Function Number: 12
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

//Function Number: 13
func_786C()
{
	self endon("disconnect");
	self endon("killcam_ended");
	self waittill("spawned");
	thread killcamcleanup(0);
}

//Function Number: 14
endedkillcamcleanup()
{
	self endon("disconnect");
	self endon("killcam_ended");
	level waittill("game_ended");
	thread killcamcleanup(1);
}

//Function Number: 15
killcamcleanup(param_00)
{
	self setclientomnvar("ui_killcam_end_milliseconds",0);
	self.killcam = undefined;
	var_01 = level.showingfinalkillcam;
	if(!var_01)
	{
		func_7001("unknown",-1,-1);
	}

	if(!level.gameended)
	{
		maps\mp\_utility::func_1D47("kc_info");
	}

	thread maps\mp\gametypes\_spectating::func_70D0();
	self notify("killcam_ended");
	if(!param_00)
	{
	}

	maps\mp\_utility::func_8730("dead");
	maps\mp\_utility::clearkillcamstate();
}