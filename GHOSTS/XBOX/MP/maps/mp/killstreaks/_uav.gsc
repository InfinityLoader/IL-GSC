/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_uav.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 32
 * Decompile Time: 537 ms
 * Timestamp: 10/27/2023 1:33:22 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.radarviewtime = 23;
	level.uavblocktime = 23;
	level.killstreakfuncs["uav_3dping"] = ::func_840A;
	level.uavsettings = [];
	level.uavsettings["uav_3dping"] = addstruct();
	level.uavsettings["uav_3dping"].timeout = 63;
	level.uavsettings["uav_3dping"].streakname = "uav_3dping";
	level.uavsettings["uav_3dping"].highlightfadetime = 1.5;
	level.uavsettings["uav_3dping"].pingtime = 10;
	level.uavsettings["uav_3dping"].fxid_ping = loadfx("vfx/gameplay/mp/killstreaks/vfx_3d_world_ping");
	level.uavsettings["uav_3dping"].sound_ping_plr = "oracle_radar_pulse_plr";
	level.uavsettings["uav_3dping"].sound_ping_npc = "oracle_radar_pulse_npc";
	level.uavsettings["uav_3dping"].votimeout = "oracle_gone";
	level.uavsettings["uav_3dping"].teamsplash = "used_uav_3dping";
	var_00 = getentarray("minimap_corner","targetname");
	if(var_00.size)
	{
		var_01 = maps\mp\gametypes\_spawnlogic::findboxcenter(var_00[0].origin,var_00[1].origin);
	}
	else
	{
		var_01 = (0,0,0);
	}

	level.uavrig = spawn("script_model",var_01);
	level.uavrig.angles = (0,115,0);
	level.uavrig hide();
	level.uavrig.targetname = "uavrig_script_model";
	level.uavrig thread func_687D();
	if(level.multiteambased)
	{
		for(var_02 = 0;var_02 < level.teamnamelist.size;var_02++)
		{
			level.radarmode[level.teamnamelist[var_02]] = "normal_radar";
			level.activeuavs[level.teamnamelist[var_02]] = 0;
			level.activecounteruavs[level.teamnamelist[var_02]] = 0;
			level.uavmodels[level.teamnamelist[var_02]] = [];
		}
	}
	else if(level.teambased)
	{
		level.radarmode["allies"] = "normal_radar";
		level.radarmode["axis"] = "normal_radar";
		level.activeuavs["allies"] = 0;
		level.activeuavs["axis"] = 0;
		level.activecounteruavs["allies"] = 0;
		level.activecounteruavs["axis"] = 0;
		level.uavmodels["allies"] = [];
		level.uavmodels["axis"] = [];
	}
	else
	{
		level.radarmode = [];
		level.activeuavs = [];
		level.activecounteruavs = [];
		level.uavmodels = [];
		level thread func_595D();
	}

	level thread func_8579();
}

//Function Number: 2
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		level.activeuavs[var_00.guid] = 0;
		level.activeuavs[var_00.guid + "_radarStrength"] = 0;
		level.activecounteruavs[var_00.guid] = 0;
		level.radarmode[var_00.guid] = "normal_radar";
	}
}

//Function Number: 3
func_687D(param_00,param_01)
{
	if(isdefined(param_01))
	{
		self endon(param_01);
	}

	if(!isdefined(param_00))
	{
		param_00 = 60;
	}

	for(;;)
	{
		self rotateyaw(-360,param_00);
		wait(param_00);
	}
}

//Function Number: 4
func_845A(param_00,param_01)
{
	return func_87DE(param_01);
}

//Function Number: 5
func_840A(param_00,param_01)
{
	var_02 = "uav_3dping";
	thread func_8C4F(var_02);
	thread func_8C50(var_02);
	level thread maps\mp\_utility::func_7FA0(level.uavsettings[var_02].teamsplash,self);
	return 1;
}

//Function Number: 6
func_87DE(param_00)
{
	maps\mp\_matchdata::func_4F1D(param_00,self.origin);
	var_01 = self.pers["team"];
	var_02 = level.uavsettings[param_00].timeout;
	level thread launchuav(self,var_02,param_00);
	switch(param_00)
	{
		case "counter_uav":
			self notify("used_counter_uav");
			break;

		case "directional_uav":
			self.radarshowenemydirection = 1;
			if(level.teambased)
			{
				foreach(var_04 in level.players)
				{
					if(var_04.pers["team"] == var_01)
					{
						var_04.radarshowenemydirection = 1;
					}
				}
			}
	
			level thread maps\mp\_utility::func_7FA0(level.uavsettings[param_00].teamsplash,self,var_01);
			self notify("used_directional_uav");
			break;

		default:
			self notify("used_uav");
			break;
	}

	return 1;
}

//Function Number: 7
launchuav(param_00,param_01,param_02)
{
	var_03 = param_00.team;
	var_04 = spawn("script_model",level.uavrig gettagorigin("tag_origin"));
	var_04 setmodel(level.uavsettings[param_02].modelbase);
	var_04.team = var_03;
	var_04.owner = param_00;
	var_04.timetoadd = 0;
	var_04.uavtype = param_02;
	var_04.health = level.uavsettings[param_02].health;
	var_04.maxhealth = level.uavsettings[param_02].maxhealth;
	if(param_02 == "directional_uav")
	{
		var_04 thread func_78A3(level.uavsettings[param_02].fxid_contrail,level.uavsettings[param_02].fx_contrail_tag);
	}

	var_04 adduavmodel();
	var_04 thread func_2319();
	var_04 thread func_3F83();
	var_04 thread removeuavmodelondeath();
	var_05 = randomintrange(3000,5000);
	if(isdefined(level.spawnpoints))
	{
		var_06 = level.spawnpoints;
	}
	else
	{
		var_06 = level.startspawnpoints;
	}

	var_07 = var_06[0];
	foreach(var_09 in var_06)
	{
		if(var_09.origin[2] < var_07.origin[2])
		{
			var_07 = var_09;
		}
	}

	var_0B = var_07.origin[2];
	var_0C = level.uavrig.origin[2];
	if(var_0B < 0)
	{
		var_0C = var_0C + var_0B * -1;
		var_0B = 0;
	}

	var_0D = var_0C - var_0B;
	if(var_0D + var_05 > 8100)
	{
		var_05 = var_05 - var_0D + var_05 - 8100;
	}

	var_0E = randomint(360);
	var_0F = randomint(2000) + 5000;
	var_10 = cos(var_0E) * var_0F;
	var_11 = sin(var_0E) * var_0F;
	var_12 = vectornormalize((var_10,var_11,var_05));
	var_12 = var_12 * randomintrange(6000,7000);
	var_04 linkto(level.uavrig,"tag_origin",var_12,(0,var_0E - 90,0));
	var_04 thread func_874D();
	var_04 [[ level.uavsettings[param_02].addfunc ]]();
	if(isdefined(level.activeuavs[var_03]))
	{
		foreach(var_14 in level.uavmodels[var_03])
		{
			if(var_14 == var_04)
			{
				continue;
			}

			var_14.timetoadd = var_14.timetoadd + 5;
		}
	}

	level notify("uav_update");
	var_04 maps\mp\gametypes\_hostmigration::func_8B7D("death",param_01);
	if(var_04.damagetaken < var_04.maxhealth)
	{
		var_04 unlink();
		var_16 = var_04.origin + anglestoforward(var_04.angles) * 20000;
		var_04 moveto(var_16,60);
		if(isdefined(level.uavsettings[param_02].fxid_leave) && isdefined(level.uavsettings[param_02].fx_leave_tag))
		{
			playfxontag(level.uavsettings[param_02].fxid_leave,var_04,level.uavsettings[param_02].fx_leave_tag);
		}

		var_04 maps\mp\gametypes\_hostmigration::func_8B7D("death",3);
		if(var_04.damagetaken < var_04.maxhealth)
		{
			var_04 notify("leaving");
			var_04.isleaving = 1;
			var_04 moveto(var_16,4,4,0);
		}

		var_04 maps\mp\gametypes\_hostmigration::func_8B7D("death",4 + var_04.timetoadd);
	}

	var_04 [[ level.uavsettings[param_02].removefunc ]]();
	var_04 delete();
	var_04 func_65B7();
	if(param_02 == "directional_uav")
	{
		param_00.radarshowenemydirection = 0;
		if(level.teambased)
		{
			foreach(var_18 in level.players)
			{
				if(var_18.pers["team"] == var_03)
				{
					var_18.radarshowenemydirection = 0;
				}
			}
		}
	}

	level notify("uav_update");
}

//Function Number: 8
func_874D()
{
	self endon("death");
	for(;;)
	{
		level common_scripts\utility::func_8B4F("joined_team","uav_update");
		self hide();
		foreach(var_01 in level.players)
		{
			if(level.teambased)
			{
				if(var_01.team != self.team)
				{
					self showtoplayer(var_01);
				}

				continue;
			}

			if(isdefined(self.owner) && var_01 == self.owner)
			{
				continue;
			}

			self showtoplayer(var_01);
		}
	}
}

//Function Number: 9
func_2319()
{
	level endon("game_ended");
	self setcandamage(1);
	self.damagetaken = 0;
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(!isplayer(var_01))
		{
			if(!isdefined(self))
			{
			}

			continue;
		}

		if(isdefined(var_08) && var_08 & level.idflags_penetration)
		{
			self.wasdamagedfrombulletpenetration = 1;
		}

		self.wasdamaged = 1;
		var_0A = var_00;
		if(isplayer(var_01))
		{
			var_01 maps\mp\gametypes\_damagefeedback::func_86E0("");
			if(var_04 == "MOD_RIFLE_BULLET" || var_04 == "MOD_PISTOL_BULLET")
			{
				if(var_01 maps\mp\_utility::_hasperk("specialty_armorpiercing"))
				{
					var_0A = var_0A + var_00 * level.armorpiercingmod;
				}
			}
		}

		if(isdefined(var_09))
		{
			switch(var_09)
			{
				case "javelin_mp":
				case "stinger_mp":
					self.largeprojectiledamage = 1;
					var_0A = self.maxhealth + 1;
					break;
	
				case "sam_projectile_mp":
					self.largeprojectiledamage = 1;
					var_0B = 0.25;
					if(self.uavtype == "directional_uav")
					{
						var_0B = 0.15;
					}
		
					var_0A = self.maxhealth * var_0B;
					break;
			}

			maps\mp\killstreaks\_killstreaks::func_4B39(var_01,var_09,self);
		}

		self.damagetaken = self.damagetaken + var_0A;
		if(self.damagetaken >= self.maxhealth)
		{
			if(isplayer(var_01) && !isdefined(self.owner) || var_01 != self.owner)
			{
				thread maps\mp\_utility::func_7FA0(level.uavsettings[self.uavtype].calloutdestroyed,var_01);
				thread maps\mp\gametypes\_missions::vehiclekilled(self.owner,self,undefined,var_01,var_00,var_04,var_09);
				var_01 thread maps\mp\gametypes\_rank::giverankxp("kill",50,var_09,var_04);
				var_01 notify("destroyed_killstreak");
				if(isdefined(self.uavremotemarkedby) && self.uavremotemarkedby != var_01)
				{
					self.uavremotemarkedby thread maps\mp\killstreaks\_remoteuav::func_64FE();
				}
			}

			self hide();
			var_0C = anglestoright(self.angles) * 200;
			playfx(level.uavsettings[self.uavtype].fxid_explode,self.origin,var_0C);
			self notify("death");
		}
	}
}

//Function Number: 10
func_8579()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("uav_update");
		if(level.multiteambased)
		{
			for(var_00 = 0;var_00 < level.teamnamelist.size;var_00++)
			{
				func_8743(level.teamnamelist[var_00]);
			}

			continue;
		}

		if(level.teambased)
		{
			func_8743("allies");
			func_8743("axis");
			continue;
		}

		func_8712();
	}
}

//Function Number: 11
_getradarstrength(param_00)
{
	var_01 = 0;
	var_02 = 0;
	foreach(var_04 in level.uavmodels[param_00])
	{
		if(var_04.uavtype == "counter_uav")
		{
			continue;
		}

		if(var_04.uavtype == "remote_mortar")
		{
			continue;
		}

		var_01++;
	}

	if(level.multiteambased)
	{
		foreach(var_07 in level.teamnamelist)
		{
			foreach(var_04 in level.uavmodels[var_07])
			{
				if(var_07 == param_00)
				{
					continue;
				}

				if(var_04.uavtype != "counter_uav")
				{
					continue;
				}

				var_02++;
			}
		}
	}
	else
	{
		foreach(var_04 in level.uavmodels[level.otherteam[param_00]])
		{
			if(var_04.uavtype != "counter_uav")
			{
				continue;
			}

			var_02++;
		}
	}

	if(var_02 > 0)
	{
		var_0D = -3;
	}
	else
	{
		var_0D = var_02;
	}

	var_0E = getuavstrengthmin();
	var_0F = getuavstrengthmax();
	if(var_0D <= var_0E)
	{
		var_0D = var_0E;
	}
	else if(var_0D >= var_0F)
	{
		var_0D = var_0F;
	}

	return var_0D;
}

//Function Number: 12
func_8743(param_00)
{
	var_01 = _getradarstrength(param_00);
	setteamradarstrength(param_00,var_01);
	if(var_01 >= getuavstrengthlevelneutral())
	{
		unblockteamradar(param_00);
	}
	else
	{
		blockteamradar(param_00);
	}

	if(var_01 <= getuavstrengthlevelneutral())
	{
		func_70E1(param_00,0);
		func_8744(param_00);
	}

	if(var_01 >= getuavstrengthlevelshowenemyfastsweep())
	{
		level.radarmode[param_00] = "fast_radar";
	}
	else
	{
		level.radarmode[param_00] = "normal_radar";
	}

	func_8744(param_00);
	func_70E1(param_00,1);
}

//Function Number: 13
func_8712()
{
	var_00 = getuavstrengthmin();
	var_01 = getuavstrengthmax();
	var_02 = getuavstrengthlevelshowenemydirectional();
	foreach(var_04 in level.players)
	{
		var_05 = level.activeuavs[var_04.guid + "_radarStrength"];
		foreach(var_07 in level.players)
		{
			if(var_07 == var_04)
			{
				continue;
			}

			var_08 = level.activecounteruavs[var_07.guid];
			if(var_08 > 0)
			{
				var_05 = -3;
				break;
			}
		}

		if(var_05 <= var_00)
		{
			var_05 = var_00;
		}
		else if(var_05 >= var_01)
		{
			var_05 = var_01;
		}

		var_04.radarstrength = var_05;
		if(var_05 >= getuavstrengthlevelneutral())
		{
			var_04.isradarblocked = 0;
		}
		else
		{
			var_04.isradarblocked = 1;
		}

		if(var_05 <= getuavstrengthlevelneutral())
		{
			var_04.hasradar = 0;
			var_04.radarshowenemydirection = 0;
			continue;
		}

		if(var_05 >= getuavstrengthlevelshowenemyfastsweep())
		{
			var_04.radarmode = "fast_radar";
		}
		else
		{
			var_04.radarmode = "normal_radar";
		}

		var_04.radarshowenemydirection = var_05 >= var_02;
		var_04.hasradar = 1;
	}
}

//Function Number: 14
blockplayeruav()
{
	self endon("disconnect");
	self notify("blockPlayerUAV");
	self endon("blockPlayerUAV");
	self.isradarblocked = 1;
	wait(level.uavblocktime);
	self.isradarblocked = 0;
}

//Function Number: 15
func_8744(param_00)
{
	var_01 = _getradarstrength(param_00) >= getuavstrengthlevelshowenemydirectional();
	foreach(var_03 in level.players)
	{
		if(var_03.team == "spectator")
		{
			continue;
		}

		var_03.radarmode = level.radarmode[var_03.team];
		if(var_03.team == param_00)
		{
			var_03.radarshowenemydirection = var_01;
		}
	}
}

//Function Number: 16
func_87CB(param_00,param_01)
{
	level endon("game_ended");
	self endon("disconnect");
	self notify("usePlayerUAV");
	self endon("usePlayerUAV");
	if(param_00)
	{
		self.radarmode = "fast_radar";
	}
	else
	{
		self.radarmode = "normal_radar";
	}

	self.hasradar = 1;
	wait(param_01);
	self.hasradar = 0;
}

//Function Number: 17
func_70E1(param_00,param_01)
{
	setteamradar(param_00,param_01);
	level notify("radar_status_change",param_00);
}

//Function Number: 18
func_3F83()
{
	level endon("game_ended");
	self endon("death");
	for(;;)
	{
		level waittill("stinger_fired",var_00,var_01,var_02);
		if(!isdefined(var_02) || var_02 != self)
		{
			continue;
		}

		var_01 thread func_7BFE(var_02,var_00);
	}
}

//Function Number: 19
func_7BFE(param_00,param_01)
{
	self endon("death");
	var_02 = distance(self.origin,param_00 getpointinbounds(0,0,0));
	var_03 = param_00 getpointinbounds(0,0,0);
	for(;;)
	{
		if(!isdefined(param_00))
		{
			var_04 = var_03;
		}
		else
		{
			var_04 = param_00 getpointinbounds(0,0,0);
		}

		var_03 = var_04;
		var_05 = distance(self.origin,var_04);
		if(var_05 < var_02)
		{
			var_02 = var_05;
		}

		if(var_05 > var_02)
		{
			if(var_05 > 1536)
			{
			}

			radiusdamage(self.origin,1536,600,600,param_01,"MOD_EXPLOSIVE","stinger_mp");
			playfx(level.stingerfxid,self.origin);
			self hide();
			self notify("deleted");
			wait(0.05);
			self delete();
			param_01 notify("killstreak_destroyed");
		}

		wait(0.05);
	}
}

//Function Number: 20
adduavmodel()
{
	if(level.teambased)
	{
		level.uavmodels[self.team][level.uavmodels[self.team].size] = self;
	}

	level.uavmodels[self.owner.guid + "_" + gettime()] = self;
}

//Function Number: 21
removeuavmodelondeath()
{
	self waittill("death");
	if(isdefined(self.uavrig))
	{
		self.uavrig delete();
	}

	if(isdefined(self))
	{
		self delete();
	}

	func_65B7();
}

//Function Number: 22
func_65B7()
{
	var_00 = [];
	if(level.teambased)
	{
		var_01 = self.team;
		foreach(var_03 in level.uavmodels[var_01])
		{
			if(!isdefined(var_03))
			{
				continue;
			}

			var_00[var_00.size] = var_03;
		}

		level.uavmodels[var_01] = var_00;
	}

	foreach(var_03 in level.uavmodels)
	{
		if(!isdefined(var_03))
		{
			continue;
		}

		var_00[var_00.size] = var_03;
	}

	level.uavmodels = var_00;
}

//Function Number: 23
addactiveuav()
{
	if(level.teambased)
	{
		level.activeuavs[self.team]++;
	}

	level.activeuavs[self.owner.guid]++;
	level.activeuavs[self.owner.guid + "_radarStrength"]++;
}

//Function Number: 24
addactivecounteruav()
{
	if(level.teambased)
	{
		level.activecounteruavs[self.team]++;
	}

	level.activecounteruavs[self.owner.guid]++;
}

//Function Number: 25
func_6576()
{
	if(level.teambased)
	{
		level.activeuavs[self.team]--;
	}

	if(isdefined(self.owner))
	{
		level.activeuavs[self.owner.guid]--;
		level.activeuavs[self.owner.guid + "_radarStrength"]--;
	}
}

//Function Number: 26
func_6574()
{
	if(level.teambased)
	{
		level.activecounteruavs[self.team]--;
	}

	if(isdefined(self.owner))
	{
		level.activecounteruavs[self.owner.guid]--;
	}
}

//Function Number: 27
func_78A3(param_00,param_01)
{
	self endon("death");
	level endon("game_ended");
	wait(0.5);
	playfxontag(param_00,self,param_01);
}

//Function Number: 28
func_8C4F(param_00,param_01)
{
	if(isdefined(param_01))
	{
		param_01 endon("death");
	}

	self endon("leave");
	self endon("killstreak_disowned");
	level endon("game_ended");
	var_02 = level.uavsettings[param_00];
	var_03 = var_02.pingtime;
	if(level.teambased)
	{
		level.activeuavs[self.team]++;
	}
	else
	{
		level.activeuavs[self.guid]++;
	}

	for(;;)
	{
		playfx(var_02.fxid_ping,self.origin);
		self playlocalsound(var_02.sound_ping_plr);
		playsoundatpos(self.origin + (0,0,5),var_02.sound_ping_npc);
		foreach(var_05 in level.participants)
		{
			if(!maps\mp\_utility::func_4945(var_05))
			{
				continue;
			}

			if(!maps\mp\_utility::isenemy(var_05))
			{
				continue;
			}

			if(var_05 maps\mp\_utility::_hasperk("specialty_noplayertarget"))
			{
				continue;
			}

			var_05 maps\mp\gametypes\_damagefeedback::hudicontype("oracle");
			foreach(var_07 in level.participants)
			{
				if(!maps\mp\_utility::func_4945(var_07))
				{
					continue;
				}

				if(maps\mp\_utility::isenemy(var_07))
				{
					continue;
				}

				if(isai(var_07))
				{
					var_07 common_scripts\utility::ai_3d_sighting_model(var_05);
					continue;
				}

				var_08 = maps\mp\_utility::func_5A44(var_05,"orange",var_07,0,"killstreak");
				var_09 = var_02.highlightfadetime;
				var_07 thread func_8CF8(var_08,var_05,var_09,param_01);
			}
		}

		maps\mp\gametypes\_hostmigration::func_8B0D(var_03);
	}
}

//Function Number: 29
func_8C50(param_00)
{
	self endon("killstreak_disowned");
	level endon("game_ended");
	var_01 = level.uavsettings[param_00];
	var_02 = var_01.timeout;
	var_03 = self.guid;
	if(level.teambased)
	{
		var_03 = self.team;
	}

	thread watch_3dping_killstreakdisowned(var_03);
	maps\mp\gametypes\_hostmigration::func_8B0D(var_02);
	maps\mp\_utility::func_4D35(var_01.votimeout);
	self notify("leave");
	cleanup3dping(var_03);
}

//Function Number: 30
watch_3dping_killstreakdisowned(param_00)
{
	self endon("leave");
	self waittill("killstreak_disowned");
	cleanup3dping(param_00);
}

//Function Number: 31
cleanup3dping(param_00)
{
	level.activeuavs[param_00]--;
	if(level.activeuavs[param_00] < 0)
	{
		level.activeuavs[param_00] = 0;
	}
}

//Function Number: 32
func_8CF8(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_03))
	{
		param_03 endon("death");
	}

	self endon("disconnect");
	level endon("game_ended");
	common_scripts\utility::func_8B36(param_02,"leave");
	if(isdefined(param_01))
	{
		maps\mp\_utility::func_5A40(param_00,param_01);
	}
}