/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_remotemortar.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 506 ms
 * Timestamp: 10/27/2023 2:14:27 AM
*******************************************************************/

//Function Number: 1
init()
{
	precachestring(&"MP_LASE_TARGET_FOR_GUIDED_MORTAR");
	precachestring(&"MP_WAIT_FOR_MORTAR_READY");
	precachestring(&"MP_MORTAR_ROUNDS_DEPLETED");
	precachestring(&"SPLASHES_DESTROYED_REMOTE_MORTAR");
	precachemodel("vehicle_predator_b");
	precacheitem("remote_mortar_missile_mp");
	precacheitem("mortar_remote_mp");
	precacheitem("mortar_remote_zoom_mp");
	precacheshader("compass_waypoint_bomb");
	precacheshader("viper_locked_box");
	precacheminimapicon("compass_objpoint_reaper_friendly");
	precacheminimapicon("compass_objpoint_reaper_enemy");
	level.remote_mortar_fx["laserTarget"] = loadfx("misc/laser_glow");
	level.remote_mortar_fx["missileExplode"] = loadfx("explosions/bouncing_betty_explosion");
	level.killstreakfuncs["remote_mortar"] = ::tryuseremotemortar;
	level.remote_mortar = undefined;
}

//Function Number: 2
tryuseremotemortar(param_00)
{
	if(isdefined(level.remote_mortar))
	{
		self iprintlnbold(&"MP_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	if(!maps\mp\_utility::validateusestreak())
	{
		return 0;
	}

	maps\mp\_utility::setusingremote("remote_mortar");
	var_01 = maps\mp\killstreaks\_killstreaks::initridekillstreak("remote_mortar");
	if(var_01 != "success")
	{
		if(var_01 != "disconnect")
		{
			maps\mp\_utility::clearusingremote();
		}

		return 0;
	}
	else if(isdefined(level.remote_mortar))
	{
		self iprintlnbold(&"MP_AIR_SPACE_TOO_CROWDED");
		maps\mp\_utility::clearusingremote();
		return 0;
	}

	maps\mp\_matchdata::logkillstreakevent("remote_mortar",self.origin);
	return startremotemortar(param_00);
}

//Function Number: 3
startremotemortar(param_00)
{
	var_01 = spawnremote(param_00,self);
	if(!isdefined(var_01))
	{
		return 0;
	}

	level.remote_mortar = var_01;
	remoteride(var_01);
	thread maps\mp\_utility::teamplayercardsplash("used_remote_mortar",self);
	return 1;
}

//Function Number: 4
spawnremote(param_00,param_01)
{
	var_02 = spawnplane(param_01,"script_model",level.uavrig gettagorigin("tag_origin"),"compass_objpoint_reaper_friendly","compass_objpoint_reaper_enemy");
	if(!isdefined(var_02))
	{
		return undefined;
	}

	var_02 setmodel("vehicle_predator_b");
	var_02.lifeid = param_00;
	var_02.team = param_01.team;
	var_02.owner = param_01;
	var_02.numflares = 1;
	var_02 setcandamage(1);
	var_02 thread damagetracker();
	var_02.helitype = "remote_mortar";
	var_02.uavtype = "remote_mortar";
	var_02 maps\mp\killstreaks\_uav::adduavmodel();
	var_03 = 6300;
	var_04 = randomint(360);
	var_05 = 6100;
	var_06 = cos(var_04) * var_05;
	var_07 = sin(var_04) * var_05;
	var_08 = vectornormalize((var_06,var_07,var_03));
	var_08 = var_08 * 6100;
	var_02 linkto(level.uavrig,"tag_origin",var_08,(0,var_04 - 90,10));
	param_01 setclientdvar("ui_reaper_targetDistance",-1);
	param_01 setclientdvar("ui_reaper_ammoCount",14);
	var_02 thread handledeath(param_01);
	var_02 thread handletimeout(param_01);
	var_02 thread handleownerchangeteam(param_01);
	var_02 thread handleownerdisconnect(param_01);
	var_02 thread handleincomingstinger();
	var_02 thread handleincomingsam();
	return var_02;
}

//Function Number: 5
lookcenter(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("death");
	wait 0.05;
	var_01 = vectortoangles(level.uavrig.origin - param_00 gettagorigin("tag_player"));
	self setplayerangles(var_01);
}

//Function Number: 6
remoteride(param_00)
{
	maps\mp\_utility::_giveweapon("mortar_remote_mp");
	self switchtoweapon("mortar_remote_mp");
	thread waitsetthermal(1,param_00);
	thread maps\mp\_utility::reinitializethermal(param_00);
	if(getdvarint("camera_thirdPerson"))
	{
		maps\mp\_utility::setthirdpersondof(0);
	}

	self playerlinkweaponviewtodelta(param_00,"tag_player",1,40,40,25,40);
	thread lookcenter(param_00);
	common_scripts\utility::_disableweaponswitch();
	thread remotetargeting(param_00);
	thread remotefiring(param_00);
	thread remotezoom(param_00);
}

//Function Number: 7
waitsetthermal(param_00,param_01)
{
	self endon("disconnect");
	param_01 endon("death");
	wait param_00;
	self visionsetthermalforplayer(level.ac130.enhanced_vision,0);
	self.lastvisionsetthermal = level.ac130.enhanced_vision;
	self thermalvisionfofoverlayon();
}

//Function Number: 8
remotetargeting(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	param_00 endon("remote_done");
	param_00 endon("death");
	param_00.targetent = spawnfx(level.remote_mortar_fx["laserTarget"],(0,0,0));
	for(;;)
	{
		var_01 = self geteye();
		var_02 = anglestoforward(self getplayerangles());
		var_03 = var_01 + var_02 * 15000;
		var_04 = bullettrace(var_01,var_03,0,param_00.targetent);
		if(isdefined(var_04["position"]))
		{
			param_00.targetent.origin = var_04["position"];
			triggerfx(param_00.targetent);
		}

		wait 0.05;
	}
}

//Function Number: 9
remotefiring(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	param_00 endon("remote_done");
	param_00 endon("death");
	var_01 = gettime();
	var_02 = var_01 - 2200;
	var_03 = 14;
	self.firingreaper = 0;
	for(;;)
	{
		var_01 = gettime();
		if(self attackbuttonpressed() && var_01 - var_02 > 3000)
		{
			var_03--;
			self setclientdvar("ui_reaper_ammoCount",var_03);
			var_02 = var_01;
			self.firingreaper = 1;
			self playlocalsound("reaper_fire");
			self playrumbleonentity("damage_heavy");
			var_04 = self geteye();
			var_05 = anglestoforward(self getplayerangles());
			var_06 = anglestoright(self getplayerangles());
			var_07 = var_04 + var_05 * 100 + var_06 * -100;
			var_08 = magicbullet("remote_mortar_missile_mp",var_07,param_00.targetent.origin,self);
			earthquake(0.3,0.5,var_04,256);
			var_08 missile_settargetent(param_00.targetent);
			var_08 missile_setflightmodedirect();
			var_08 thread remotemissiledistance(param_00);
			var_08 thread remotemissilelife(param_00);
			var_08 waittill("death");
			self setclientdvar("ui_reaper_targetDistance",-1);
			self.firingreaper = 0;
			if(var_03 == 0)
			{
				break;
			}

			continue;
		}

		wait 0.05;
	}

	self notify("removed_reaper_ammo");
	remoteendride(param_00);
	param_00 thread remoteleave();
}

//Function Number: 10
handletogglezoom(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	param_00 endon("remote_done");
	param_00 endon("death");
	self notifyonplayercommand("remote_mortar_toggleZoom1","+ads_akimbo_accessible");
	for(;;)
	{
		var_01 = common_scripts\utility::waittill_any_return("remote_mortar_toggleZoom1");
		if(!isdefined(self.remote_mortar_togglezoom))
		{
			self.remote_mortar_togglezoom = 0;
		}

		self.remote_mortar_togglezoom = 1 - self.remote_mortar_togglezoom;
	}
}

//Function Number: 11
remotezoom(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	param_00 endon("remote_done");
	param_00 endon("death");
	self.remote_mortar_togglezoom = undefined;
	thread handletogglezoom(param_00);
	param_00.var_35DF = 0;
	var_01 = 0;
	for(;;)
	{
		if(self adsbuttonpressed())
		{
			wait 0.05;
			if(isdefined(self.remote_mortar_togglezoom))
			{
				var_01 = 1;
			}

			break;
		}

		wait 0.05;
	}

	for(;;)
	{
		if((!var_01 && self adsbuttonpressed()) || var_01 && self.remote_mortar_togglezoom)
		{
			if(param_00.var_35DF == 0)
			{
				maps\mp\_utility::_giveweapon("mortar_remote_zoom_mp");
				self switchtoweapon("mortar_remote_zoom_mp");
				param_00.var_35DF = 1;
			}
		}
		else if((!var_01 && !self adsbuttonpressed()) || var_01 && !self.remote_mortar_togglezoom)
		{
			if(param_00.var_35DF == 1)
			{
				maps\mp\_utility::_giveweapon("mortar_remote_mp");
				self switchtoweapon("mortar_remote_mp");
				param_00.var_35DF = 0;
			}
		}

		wait 0.05;
	}
}

//Function Number: 12
remotemissiledistance(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	param_00 endon("remote_done");
	self endon("death");
	for(;;)
	{
		var_01 = distance(self.origin,param_00.targetent.origin);
		param_00.owner setclientdvar("ui_reaper_targetDistance",int(var_01 / 12));
		wait 0.05;
	}
}

//Function Number: 13
remotemissilelife(param_00)
{
	self endon("death");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(6);
	playfx(level.remote_mortar_fx["missileExplode"],self.origin);
	self delete();
}

//Function Number: 14
remoteendride(param_00)
{
	if(!maps\mp\_utility::isusingremote())
	{
		return;
	}

	if(isdefined(param_00))
	{
		param_00 notify("helicopter_done");
	}

	self thermalvisionoff();
	self thermalvisionfofoverlayoff();
	self visionsetthermalforplayer(game["thermal_vision"],0);
	if(isdefined(level.nukedetonated))
	{
		self visionsetnakedforplayer(level.nukevisionset,0);
	}
	else
	{
		self visionsetnakedforplayer("",0);
	}

	self unlink();
	maps\mp\_utility::clearusingremote();
	if(getdvarint("camera_thirdPerson"))
	{
		maps\mp\_utility::setthirdpersondof(1);
	}

	self switchtoweapon(common_scripts\utility::getlastweapon());
	var_01 = maps\mp\killstreaks\_killstreaks::getkillstreakweapon("remote_mortar");
	self takeweapon(var_01);
	self takeweapon("mortar_remote_zoom_mp");
	self takeweapon("mortar_remote_mp");
	common_scripts\utility::_enableweaponswitch();
}

//Function Number: 15
handletimeout(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("removed_reaper_ammo");
	self endon("death");
	var_01 = 40;
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(var_01);
	while(param_00.firingreaper)
	{
		wait 0.05;
	}

	if(isdefined(param_00))
	{
		param_00 remoteendride(self);
	}

	thread remoteleave();
}

//Function Number: 16
handledeath(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	self endon("remote_removed");
	self endon("remote_done");
	self waittill("death");
	if(isdefined(param_00))
	{
		param_00 remoteendride(self);
	}

	level thread removeremote(self);
}

//Function Number: 17
handleownerchangeteam(param_00)
{
	level endon("game_ended");
	self endon("remote_done");
	self endon("death");
	param_00 endon("disconnect");
	param_00 endon("removed_reaper_ammo");
	param_00 common_scripts\utility::waittill_any("joined_team","joined_spectators");
	if(isdefined(param_00))
	{
		param_00 remoteendride(self);
	}

	thread remoteleave();
}

//Function Number: 18
handleownerdisconnect(param_00)
{
	level endon("game_ended");
	self endon("remote_done");
	self endon("death");
	param_00 endon("removed_reaper_ammo");
	param_00 waittill("disconnect");
	thread remoteleave();
}

//Function Number: 19
removeremote(param_00)
{
	self notify("remote_removed");
	if(isdefined(param_00.targetent))
	{
		param_00.targetent delete();
	}

	if(isdefined(param_00))
	{
		param_00 delete();
		param_00 maps\mp\killstreaks\_uav::removeuavmodel();
	}

	level.remote_mortar = undefined;
}

//Function Number: 20
remoteleave()
{
	level endon("game_ended");
	self endon("death");
	self notify("remote_done");
	self unlink();
	var_00 = self.origin + anglestoforward(self.angles) * 20000;
	self moveto(var_00,30);
	playfxontag(level._effect["ac130_engineeffect"],self,"tag_origin");
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(3);
	self moveto(var_00,4,4,0);
	maps\mp\gametypes\_hostmigration::waitlongdurationwithhostmigrationpause(4);
	level thread removeremote(self);
}

//Function Number: 21
remoteexplode()
{
	self notify("death");
	self hide();
	var_00 = anglestoright(self.angles) * 200;
	playfx(level.uav_fx["explode"],self.origin,var_00);
}

//Function Number: 22
damagetracker()
{
	level endon("game_ended");
	self.owner endon("disconnect");
	self.health = 999999;
	self.maxhealth = 1500;
	self.damagetaken = 0;
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(!maps\mp\gametypes\_weapons::friendlyfirecheck(self.owner,var_01))
		{
			continue;
		}

		if(!isdefined(self))
		{
			return;
		}

		if(isdefined(var_08) && var_08 & level.idflags_penetration)
		{
			self.wasdamagedfrombulletpenetration = 1;
		}

		self.wasdamaged = 1;
		var_0A = var_00;
		if(isplayer(var_01))
		{
			var_01 maps\mp\gametypes\_damagefeedback::updatedamagefeedback("");
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
					self.var_30C8 = 1;
					var_0A = self.maxhealth + 1;
					break;
	
				case "sam_projectile_mp":
					self.var_30C8 = 1;
					break;
			}
		}

		self.damagetaken = self.damagetaken + var_0A;
		if(isdefined(self.owner))
		{
			self.owner playlocalsound("reaper_damaged");
		}

		if(self.damagetaken >= self.maxhealth)
		{
			if(isplayer(var_01) && !isdefined(self.owner) || var_01 != self.owner)
			{
				var_01 notify("destroyed_killstreak",var_09);
				thread maps\mp\_utility::teamplayercardsplash("callout_destroyed_remote_mortar",var_01);
				var_01 thread maps\mp\gametypes\_rank::giverankxp("kill",50,var_09,var_04);
				var_01 thread maps\mp\gametypes\_rank::func_2F45(&"SPLASHES_DESTROYED_REMOTE_MORTAR");
				thread maps\mp\gametypes\_missions::vehiclekilled(self.owner,self,undefined,var_01,var_00,var_04,var_09);
			}

			thread remoteexplode();
			return;
		}
	}
}

//Function Number: 23
handleincomingstinger()
{
	level endon("game_ended");
	self endon("death");
	self endon("remote_done");
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

//Function Number: 24
stingerproximitydetonate(param_00,param_01)
{
	self endon("death");
	param_00 endon("death");
	if(isdefined(param_00.owner))
	{
		param_00.owner playlocalsound("missile_incoming");
	}

	self missile_settargetent(param_00);
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
		if(var_05 < 3000 && param_00.numflares > 0)
		{
			param_00.numflares--;
			param_00 thread maps\mp\killstreaks\_helicopter::playflarefx();
			var_06 = param_00 maps\mp\killstreaks\_helicopter::deployflares();
			self missile_settargetent(var_06);
			param_00 = var_06;
			if(isdefined(param_00.owner))
			{
				param_00.owner stoplocalsound("missile_incoming");
			}

			return;
		}

		if(var_06 < var_03)
		{
			var_03 = var_06;
		}

		if(var_06 > var_03)
		{
			if(var_06 > 1536)
			{
				return;
			}

			if(isdefined(param_01.owner))
			{
				param_01.owner stoplocalsound("missile_incoming");
				if(level.teambased)
				{
					if(param_01.team != var_02.team)
					{
						radiusdamage(self.origin,1000,1000,1000,var_02,"MOD_EXPLOSIVE","stinger_mp");
					}
				}
				else
				{
					radiusdamage(self.origin,1000,1000,1000,var_02,"MOD_EXPLOSIVE","stinger_mp");
				}
			}

			self hide();
			wait 0.05;
			self delete();
		}

		wait 0.05;
	}
}

//Function Number: 25
handleincomingsam()
{
	level endon("game_ended");
	self endon("death");
	self endon("remote_done");
	for(;;)
	{
		level waittill("sam_fired",var_00,var_01,var_02);
		if(!isdefined(var_02) || var_02 != self)
		{
			continue;
		}

		level thread samproximitydetonate(var_02,var_00,var_01);
	}
}

//Function Number: 26
samproximitydetonate(param_00,param_01,param_02)
{
	param_00 endon("death");
	if(isdefined(param_00.owner))
	{
		param_00.owner playlocalsound("missile_incoming");
	}

	var_03 = 150;
	var_04 = 1000;
	var_05 = [];
	for(var_06 = 0;var_06 < param_02.size;var_06++)
	{
		if(isdefined(param_02[var_06]))
		{
			var_05[var_06] = distance(param_02[var_06].origin,param_00 getpointinbounds(0,0,0));
			continue;
		}

		var_05[var_06] = undefined;
	}

	for(;;)
	{
		var_07 = param_00 getpointinbounds(0,0,0);
		var_08 = [];
		var_06 = 0;
		while(var_06 < param_02.size)
		{
			if(isdefined(param_02[var_06]))
			{
			}

			var_07++ = var_7B[var_06];
		}

		var_07 = 0;
		while(var_07 < var_7B.size)
		{
			if(isdefined(var_7B[var_07]))
			{
				if(var_7B[var_07] < 3000 && param_01.numflares > 0)
				{
					param_01.numflares-- = distance(param_02[var_06].origin,var_07);
					param_01 thread maps\mp\killstreaks\_helicopter::playflarefx();
					var_09 = param_01 maps\mp\killstreaks\_helicopter::deployflares();
					for(var_0A = 0;var_0A < var_03.size;var_0A++)
					{
						if(isdefined(var_03[var_0A]))
						{
							var_03[var_0A] missile_settargetent(var_09);
						}
					}

					if(isdefined(param_01.owner))
					{
						param_01.owner stoplocalsound("missile_incoming");
					}

					return;
				}

				if(var_0A[var_7B] < var_08[var_7B])
				{
					var_08[var_7B] = var_0A[var_7B];
				}

				if(var_0A[var_7B] > var_08[var_7B])
				{
					if(var_0A[var_7B] > 1536)
					{
						continue;
					}

					if(isdefined(var_03.owner))
					{
						var_03.owner stoplocalsound("missile_incoming");
						if(level.teambased)
						{
							if(var_03.team != var_04.team)
							{
								radiusdamage(var_05[var_7B].origin,var_07,var_06,var_06,var_04,"MOD_EXPLOSIVE","sam_projectile_mp");
							}
						}
						else
						{
							radiusdamage(var_05[var_7B].origin,var_07,var_06,var_06,var_04,"MOD_EXPLOSIVE","sam_projectile_mp");
						}
					}

					var_05[var_7B] hide();
					wait 0.05;
					var_05[var_7B] delete();
				}
			}

			var_7B++;
		}

		wait 0.05;
	}
}