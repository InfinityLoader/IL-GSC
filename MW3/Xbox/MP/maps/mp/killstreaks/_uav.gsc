/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_uav.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 38
 * Decompile Time: 683 ms
 * Timestamp: 10/27/2023 2:27:25 AM
*******************************************************************/

//Function Number: 1
init()
{
	precachestring(&"MP_WAR_RADAR_ACQUIRED");
	precachestring(&"MP_WAR_RADAR_ACQUIRED_ENEMY");
	precachestring(&"MP_WAR_RADAR_EXPIRED");
	precachestring(&"MP_WAR_RADAR_EXPIRED_ENEMY");
	precachestring(&"MP_WAR_COUNTER_RADAR_ACQUIRED");
	precachestring(&"MP_WAR_COUNTER_RADAR_ACQUIRED_ENEMY");
	precachestring(&"MP_WAR_COUNTER_RADAR_EXPIRED");
	precachestring(&"MP_WAR_COUNTER_RADAR_EXPIRED_ENEMY");
	precachestring(&"MP_LASE_TARGET_FOR_PREDATOR_STRIKE");
	precachemodel("vehicle_uav_static_mp");
	precachemodel("vehicle_phantom_ray");
	precacheitem("uav_strike_marker_mp");
	precacheitem("uav_strike_projectile_mp");
	level.radarviewtime = 30;
	level.uavblocktime = 30;
	level.uav_fx["explode"] = loadfx("explosions/uav_advanced_death");
	level.uav_fx["trail"] = loadfx("smoke/advanced_uav_contrail");
	level.killstreakfuncs["uav"] = ::func_308C;
	level.killstreakfuncs["uav_support"] = ::tryuseuavsupport;
	level.killstreakfuncs["uav_2"] = ::func_308C;
	level.killstreakfuncs["double_uav"] = ::tryusedoubleuav;
	level.killstreakfuncs["triple_uav"] = ::func_308F;
	level.killstreakfuncs["counter_uav"] = ::tryusecounteruav;
	level.killstreakfuncs["uav_strike"] = ::tryuseuavstrike;
	level.killstreaksetupfuncs["uav_strike"] = ::uavstrikesetup;
	level.killstreakfuncs["directional_uav"] = ::tryusedirectionaluav;
	level._effect["laserTarget"] = loadfx("misc/laser_glow");
	var_00 = getentarray("minimap_corner","targetname");
	if(var_00.size)
	{
		var_01 = maps\mp\gametypes\_spawnlogic::func_2FCD(var_00[0].origin,var_00[1].origin);
	}
	else
	{
		var_01 = (0,0,0);
	}

	level.uavrig = spawn("script_model",var_01);
	level.uavrig setmodel("c130_zoomrig");
	level.uavrig.angles = (0,115,0);
	level.uavrig hide();
	level.uavrig.targetname = "uavrig_script_model";
	level.uavrig thread rotateuavrig();
	if(level.teambased)
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
		level thread onplayerconnect();
	}

	level thread func_3096();
}

//Function Number: 2
onplayerconnect()
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
rotateuavrig()
{
	for(;;)
	{
		self rotateyaw(-360,60);
		wait 60;
	}
}

//Function Number: 4
launchuav(param_00,param_01,param_02,param_03)
{
	if(param_03 == "counter_uav")
	{
		var_04 = 1;
	}
	else
	{
		var_04 = 0;
	}

	var_05 = spawn("script_model",level.uavrig gettagorigin("tag_origin"));
	var_05.value = 1;
	if(param_03 == "double_uav")
	{
		var_05.value = 2;
	}
	else if(param_03 == "triple_uav")
	{
		var_05.value = 3;
	}

	if(var_05.value != 3)
	{
		var_05 setmodel("vehicle_uav_static_mp");
		var_05 thread damagetracker(var_04,0);
	}
	else
	{
		var_05 setmodel("vehicle_phantom_ray");
		var_05 thread func_3084(level.uav_fx["trail"],"tag_jet_trail");
		var_05 thread damagetracker(var_04,1);
	}

	var_05.team = param_01;
	var_05.owner = param_00;
	var_05.timetoadd = 0;
	var_05 thread handleincomingstinger();
	var_05 func_309E();
	var_06 = randomintrange(3000,5000);
	if(isdefined(level.spawnpoints))
	{
		var_07 = level.spawnpoints;
	}
	else
	{
		var_07 = level.startspawnpoints;
	}

	var_08 = var_07[0];
	foreach(var_0A in var_07)
	{
		if(var_0A.origin[2] < var_08.origin[2])
		{
			var_08 = var_0A;
		}
	}

	var_0C = var_08.origin[2];
	var_0D = level.uavrig.origin[2];
	if(var_0C < 0)
	{
		var_0D = var_0D + var_0C * -1;
		var_0C = 0;
	}

	var_0E = var_0D - var_0C;
	if(var_0E + var_06 > 8100)
	{
		var_06 = var_06 - var_0E + var_06 - 8100;
	}

	var_0F = randomint(360);
	var_10 = randomint(2000) + 5000;
	var_11 = cos(var_0F) * var_10;
	var_12 = sin(var_0F) * var_10;
	var_13 = vectornormalize((var_11,var_12,var_06));
	var_13 = var_13 * randomintrange(6000,7000);
	var_05 linkto(level.uavrig,"tag_origin",var_13,(0,var_0F - 90,0));
	var_05 thread func_308B();
	if(var_04)
	{
		var_05.uavtype = "counter";
		var_05 addactivecounteruav();
	}
	else
	{
		var_05 func_30A0();
		var_05.uavtype = "standard";
	}

	if(isdefined(level.activeuavs[param_01]))
	{
		foreach(var_15 in level.uavmodels[param_01])
		{
			if(var_15 == var_05)
			{
				continue;
			}

			if(var_15.uavtype == "counter" && var_04)
			{
				var_15.timetoadd = var_15.timetoadd + 5;
				continue;
			}

			if(var_15.uavtype == "standard" && !var_04)
			{
				var_15.timetoadd = var_15.timetoadd + 5;
			}
		}
	}

	level notify("uav_update");
	switch(param_03)
	{
		case "uav_strike":
			param_02 = 2;
			break;

		default:
			param_02 = param_02 - 7;
			break;
	}

	var_05 waittill_notify_or_timeout_hostmigration_pause("death",param_02);
	if(var_05.damagetaken < var_05.maxhealth)
	{
		var_05 unlink();
		var_17 = var_05.origin + anglestoforward(var_05.angles) * 20000;
		var_05 moveto(var_17,60);
		playfxontag(level._effect["ac130_engineeffect"],var_05,"tag_origin");
		var_05 waittill_notify_or_timeout_hostmigration_pause("death",3);
		if(var_05.damagetaken < var_05.maxhealth)
		{
			var_05 notify("leaving");
			var_05.isleaving = 1;
			var_05 moveto(var_17,4,4,0);
		}

		var_05 waittill_notify_or_timeout_hostmigration_pause("death",4 + var_05.timetoadd);
	}

	if(var_04)
	{
		var_05 func_30A3();
	}
	else
	{
		var_05 removeactiveuav();
	}

	var_05 delete();
	var_05 func_309F();
	if(param_03 == "directional_uav")
	{
		param_00.radarshowenemydirection = 0;
		if(level.teambased)
		{
			foreach(var_19 in level.players)
			{
				if(var_19.pers["team"] == param_01)
				{
					var_19.radarshowenemydirection = 0;
				}
			}
		}
	}

	level notify("uav_update");
}

//Function Number: 5
func_3084(param_00,param_01)
{
	self endon("death");
	level endon("game_ended");
	wait 0.5;
	playfxontag(param_00,self,param_01);
}

//Function Number: 6
func_3085()
{
	level endon("game_ended");
	for(;;)
	{
		var_00 = common_scripts\utility::waittill_any_return("death","uav_strike_cancel","uav_strike_successful");
		if(var_00 == "uav_strike_successful")
		{
			return 1;
		}
		else
		{
			return 0;
		}
	}
}

//Function Number: 7
func_3086()
{
	var_00 = maps\mp\gametypes\_hud_util::createfontstring("bigfixed",0.75);
	var_00 maps\mp\gametypes\_hud_util::setpoint("CENTER","CENTER",0,150);
	var_00 settext(&"MP_LASE_TARGET_FOR_PREDATOR_STRIKE");
	common_scripts\utility::waittill_any_timeout(4,"death","uav_strike_cancel","uav_strike_successful");
	var_00 maps\mp\gametypes\_hud_util::destroyelem();
}

//Function Number: 8
func_3087()
{
	level endon("game_ended");
	self endon("death");
	self endon("uav_strike_used");
	for(;;)
	{
		self waittill("weapon_change",var_00);
		if(var_00 != "uav_strike_marker_mp")
		{
			self notify("uav_strike_cancel");
			break;
		}
		else
		{
			wait 0.05;
		}
	}
}

//Function Number: 9
func_3088()
{
	level endon("game_ended");
	self endon("death");
	thread func_3086();
	thread func_3087();
	var_00 = common_scripts\utility::getlastweapon();
	var_01 = undefined;
	var_02 = self getweaponslistprimaries();
	foreach(var_04 in var_02)
	{
		if(var_04 != var_00)
		{
			var_01 = var_04;
			self takeweapon(var_01);
			break;
		}
	}

	maps\mp\_utility::_giveweapon("uav_strike_marker_mp");
	self switchtoweapon("uav_strike_marker_mp");
	var_06 = undefined;
	for(;;)
	{
		var_07 = common_scripts\utility::waittill_any_return("weapon_fired","uav_strike_cancel");
		if(var_07 == "uav_strike_cancel")
		{
			break;
		}

		var_08 = self geteye();
		var_09 = anglestoforward(self getplayerangles());
		var_0A = var_08 + var_09 * 15000;
		var_06 = bullettrace(var_08,var_0A,1,self);
		if(isdefined(var_06["position"]))
		{
			break;
		}
	}

	if(isdefined(var_06))
	{
		self notify("uav_strike_used");
		var_0B = var_06["position"];
		var_0C = spawnfx(level._effect["laserTarget"],var_0B);
		triggerfx(var_0C);
		var_0C thread func_3089();
		magicbullet("uav_strike_projectile_mp",var_0B + (0,0,4000),var_0B,self);
	}

	self takeweapon("uav_strike_marker_mp");
	if(var_07 != "uav_strike_cancel")
	{
		self switchtoweapon(var_00);
	}

	if(isdefined(var_01))
	{
		maps\mp\_utility::_giveweapon(var_01);
	}

	if(isdefined(var_06))
	{
		self notify("uav_strike_successful");
	}
}

//Function Number: 10
func_3089()
{
	wait 2;
	self delete();
}

//Function Number: 11
waittill_notify_or_timeout_hostmigration_pause(param_00,param_01)
{
	self endon(param_00);
	maps\mp\gametypes\_hostmigration::func_2740(param_01);
}

//Function Number: 12
func_308B()
{
	self endon("death");
	for(;;)
	{
		level common_scripts\utility::waittill_either("joined_team","uav_update");
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

//Function Number: 13
damagetracker(param_00,param_01)
{
	level endon("game_ended");
	self setcandamage(1);
	self.health = 999999;
	if(param_01)
	{
		self.maxhealth = 2000;
	}
	else
	{
		self.maxhealth = 1000;
	}

	self.damagetaken = 0;
	for(;;)
	{
		self waittill("damage",var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A,var_0B);
		if(!isplayer(var_03))
		{
			if(!isdefined(self))
			{
				return;
			}

			continue;
		}

		if(isdefined(var_0A) && var_0A & level.idflags_penetration)
		{
			self.wasdamagedfrombulletpenetration = 1;
		}

		self.wasdamaged = 1;
		var_0C = var_02;
		if(isplayer(var_03))
		{
			var_03 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("");
			if(var_06 == "MOD_RIFLE_BULLET" || var_06 == "MOD_PISTOL_BULLET")
			{
				if(var_03 maps\mp\_utility::func_27AF("specialty_armorpiercing"))
				{
					var_0C = var_0C + var_02 * level.armorpiercingmod;
				}
			}
		}

		if(isdefined(var_0B))
		{
			switch(var_0B)
			{
				case "javelin_mp":
				case "stinger_mp":
					self.largeprojectiledamage = 1;
					var_0C = self.maxhealth + 1;
					break;
	
				case "sam_projectile_mp":
					self.largeprojectiledamage = 1;
					var_0D = 0.25;
					if(param_01)
					{
						var_0D = 0.15;
					}
		
					var_0C = self.maxhealth * var_0D;
					break;
			}

			maps\mp\killstreaks\_killstreaks::killstreakhit(var_03,var_0B,self);
		}

		self.damagetaken = self.damagetaken + var_0C;
		if(self.damagetaken >= self.maxhealth)
		{
			if(isplayer(var_03) && !isdefined(self.owner) || var_03 != self.owner)
			{
				self hide();
				var_0E = anglestoright(self.angles) * 200;
				playfx(level.uav_fx["explode"],self.origin,var_0E);
				if(isdefined(self.uavtype) && self.uavtype == "remote_mortar")
				{
					thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_remote_mortar",var_03);
				}
				else if(param_00)
				{
					thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_counter_uav",var_03);
				}
				else
				{
					thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_uav",var_03);
				}

				thread maps\mp\gametypes\_missions::vehiclekilled(self.owner,self,undefined,var_03,var_02,var_06,var_0B);
				var_03 thread maps\mp\gametypes\_rank::func_2AB3("kill",50,var_0B,var_06);
				var_03 notify("destroyed_killstreak");
				if(isdefined(self.uavremotemarkedby) && self.uavremotemarkedby != var_03)
				{
					self.uavremotemarkedby thread maps\mp\killstreaks\_remoteuav::remoteuav_processtaggedassist();
				}
			}

			self notify("death");
			return;
		}
	}
}

//Function Number: 14
func_308C(param_00)
{
	return useuav("uav");
}

//Function Number: 15
tryuseuavsupport(param_00)
{
	return useuav("uav_support");
}

//Function Number: 16
tryusedoubleuav(param_00)
{
	return useuav("double_uav");
}

//Function Number: 17
func_308F(param_00)
{
	return useuav("triple_uav");
}

//Function Number: 18
tryusecounteruav(param_00)
{
	return useuav("counter_uav");
}

//Function Number: 19
uavstrikesetup()
{
	self.usedstrikeuav = 0;
}

//Function Number: 20
tryuseuavstrike(param_00)
{
	if(self.usedstrikeuav == 0)
	{
		self.usedstrikeuav = 1;
		useuav("uav_strike");
	}

	thread func_3088();
	return func_3085();
}

//Function Number: 21
tryusedirectionaluav(param_00)
{
	return useuav("directional_uav");
}

//Function Number: 22
useuav(param_00)
{
	if(!maps\mp\_utility::func_2DF3())
	{
		return 0;
	}

	maps\mp\_matchdata::logkillstreakevent(param_00,self.origin);
	var_01 = self.pers["team"];
	var_02 = level.radarviewtime;
	level thread launchuav(self,var_01,var_02,param_00);
	switch(param_00)
	{
		case "counter_uav":
			self notify("used_counter_uav");
			break;

		case "double_uav":
			self notify("used_double_uav");
			break;

		case "triple_uav":
			level thread maps\mp\_utility::teamplayercardsplash("used_triple_uav",self,var_01);
			self notify("used_triple_uav");
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
	
			level thread maps\mp\_utility::teamplayercardsplash("used_directional_uav",self,var_01);
			self notify("used_directional_uav");
			break;

		default:
			self notify("used_uav");
			break;
	}

	return 1;
}

//Function Number: 23
func_3096()
{
	level endon("game_ended");
	for(;;)
	{
		level waittill("uav_update");
		if(level.teambased)
		{
			func_3098("allies");
			func_3098("axis");
			continue;
		}

		updateplayersuavstatus();
	}
}

//Function Number: 24
func_3097(param_00)
{
	var_01 = 0;
	var_02 = 0;
	foreach(var_04 in level.uavmodels[param_00])
	{
		if(var_04.uavtype == "counter")
		{
			continue;
		}

		if(var_04.uavtype == "remote_mortar")
		{
			continue;
		}

		var_01 = var_01 + var_04.value;
	}

	foreach(var_04 in level.uavmodels[level.otherteam[param_00]])
	{
		if(var_04.uavtype != "counter")
		{
			continue;
		}

		var_02 = var_02 + var_04.value;
	}

	if(var_02 > 0)
	{
		var_08 = -3;
	}
	else
	{
		var_08 = var_02;
	}

	var_09 = getuavstrengthmin();
	var_0A = getuavstrengthmax();
	if(var_08 <= var_09)
	{
		var_08 = var_09;
	}
	else if(var_08 >= var_0A)
	{
		var_08 = var_0A;
	}

	return var_08;
}

//Function Number: 25
func_3098(param_00)
{
	var_01 = func_3097(param_00);
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
		setteamradarwrapper(param_00,0);
		func_309B(param_00);
		return;
	}

	if(var_01 >= getuavstrengthlevelshowenemyfastsweep())
	{
		level.radarmode[param_00] = "fast_radar";
	}
	else
	{
		level.radarmode[param_00] = "normal_radar";
	}

	func_309B(param_00);
	setteamradarwrapper(param_00,1);
}

//Function Number: 26
updateplayersuavstatus()
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

//Function Number: 27
blockplayeruav()
{
	self endon("disconnect");
	self notify("blockPlayerUAV");
	self endon("blockPlayerUAV");
	self.isradarblocked = 1;
	wait level.uavblocktime;
	self.isradarblocked = 0;
}

//Function Number: 28
func_309B(param_00)
{
	var_01 = func_3097(param_00) >= getuavstrengthlevelshowenemydirectional();
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

//Function Number: 29
useplayeruav(param_00,param_01)
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
	wait param_01;
	self.hasradar = 0;
}

//Function Number: 30
setteamradarwrapper(param_00,param_01)
{
	setteamradar(param_00,param_01);
	level notify("radar_status_change",param_00);
}

//Function Number: 31
handleincomingstinger()
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

		var_01 thread stingerproximitydetonate(var_02,var_00);
	}
}

//Function Number: 32
stingerproximitydetonate(param_00,param_01)
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
				return;
			}

			radiusdamage(self.origin,1536,600,600,param_01,"MOD_EXPLOSIVE","stinger_mp");
			playfx(level.stingerfxid,self.origin);
			self hide();
			self notify("deleted");
			wait 0.05;
			self delete();
			param_01 notify("killstreak_destroyed");
		}

		wait 0.05;
	}
}

//Function Number: 33
func_309E()
{
	if(level.teambased)
	{
		level.uavmodels[self.team][level.uavmodels[self.team].size] = self;
		return;
	}

	level.uavmodels[self.owner.guid + "_" + gettime()] = self;
}

//Function Number: 34
func_309F()
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
		return;
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

//Function Number: 35
func_30A0()
{
	if(level.teambased)
	{
		level.activeuavs[self.team]++;
		return;
	}

	level.activeuavs[self.owner.guid]++;
	level.activeuavs[self.owner.guid + "_radarStrength"] = level.activeuavs[self.owner.guid + "_radarStrength"] + self.value;
}

//Function Number: 36
addactivecounteruav()
{
	if(level.teambased)
	{
		level.activecounteruavs[self.team]++;
		return;
	}

	level.activecounteruavs[self.owner.guid]++;
}

//Function Number: 37
removeactiveuav()
{
	if(level.teambased)
	{
		level.activeuavs[self.team]--;
		if(!level.activeuavs[self.team])
		{
			return;
		}

		return;
	}

	if(isdefined(self.owner))
	{
		level.activeuavs[self.owner.guid]--;
		level.activeuavs[self.owner.guid + "_radarStrength"] = level.activeuavs[self.owner.guid + "_radarStrength"] - self.value;
	}
}

//Function Number: 38
func_30A3()
{
	if(level.teambased)
	{
		level.activecounteruavs[self.team]--;
		if(!level.activecounteruavs[self.team])
		{
			return;
		}

		return;
	}

	if(isdefined(self.owner))
	{
		level.activecounteruavs[self.owner.guid]--;
	}
}