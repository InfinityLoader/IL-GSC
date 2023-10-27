/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_lasedstrike.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 29
 * Decompile Time: 531 ms
 * Timestamp: 10/27/2023 1:21:13 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	level.killstreakfuncs["lasedStrike"] = ::func_843E;
	level.numberofsoflamammo = 2;
	level.lasedstrikeglow = loadfx("fx/misc/laser_glow");
	level.lasedstrikeexplode = loadfx("fx/explosions/uav_advanced_death");
	var_00 = getentarray("remoteMissileSpawn","targetname");
	foreach(var_02 in var_00)
	{
		if(isdefined(var_02.target))
		{
			var_02.targetent = getent(var_02.target,"targetname");
		}
	}

	level.lasedstrikeents = var_00;
	thread func_595D();
}

//Function Number: 2
func_595D()
{
	for(;;)
	{
		level waittill("connected",var_00);
		var_00 thread onplayerspawned();
		var_00.soflamammoused = 0;
		var_00.hassoflam = 0;
	}
}

//Function Number: 3
onplayerspawned()
{
	self endon("disconnect");
	self waittill("spawned_player");
}

//Function Number: 4
func_843E(param_00,param_01)
{
	return func_87C2();
}

//Function Number: 5
func_87C2()
{
	var_00 = func_8D23();
	if(isdefined(var_00) && var_00)
	{
		self.hassoflam = 0;
		return 1;
	}

	return 0;
}

//Function Number: 6
givemarker()
{
	maps\mp\killstreaks\_killstreaks::givekillstreakweapon("iw5_soflam_mp");
	self.hassoflam = 1;
	thread func_8D23();
}

//Function Number: 7
func_8D23()
{
	self notify("watchSoflamUsage");
	self endon("watchSoflamUsage");
	level endon("game_ended");
	self endon("disconnect");
	self endon("death");
	while(maps\mp\_utility::func_4899())
	{
		wait(0.05);
	}

	for(;;)
	{
		if(self attackbuttonpressed() && self getcurrentweapon() == "iw5_soflam_mp" && self adsbuttonpressed())
		{
			self weaponlocktargettooclose(0);
			self weaponlockfree();
			var_00 = func_3C24();
			if(!isdefined(var_00))
			{
				wait(0.05);
				continue;
			}

			if(!isdefined(var_00[0]))
			{
				wait(0.05);
				continue;
			}

			var_01 = var_00[0];
			var_02 = func_1015(var_01);
			if(var_02)
			{
				self.soflamammoused++;
			}

			if(self.soflamammoused >= level.numberofsoflamammo)
			{
				return 1;
			}
		}

		if(maps\mp\_utility::func_4899())
		{
			return 0;
		}

		wait(0.05);
	}
}

//Function Number: 8
playlocksound()
{
	if(isdefined(self.playinglocksound) && self.playinglocksound)
	{
	}

	self playlocalsound("javelin_clu_lock");
	self.playinglocksound = 1;
	wait(0.75);
	self stoplocalsound("javelin_clu_lock");
	self.playinglocksound = 0;
}

//Function Number: 9
func_6024()
{
	if(isdefined(self.playinglocksound) && self.playinglocksound)
	{
	}

	self playlocalsound("javelin_clu_aquiring_lock");
	self.playinglocksound = 1;
	wait(0.75);
	self stoplocalsound("javelin_clu_aquiring_lock");
	self.playinglocksound = 0;
}

//Function Number: 10
func_1015(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	var_03 = 6000;
	var_04 = (0,0,var_03);
	var_05 = 3000;
	var_06 = anglestoforward(self.angles);
	var_07 = self.origin;
	var_08 = var_07 + var_04 + var_06 * var_05 * -1;
	var_09 = 0;
	var_0A = bullettrace(param_00 + (0,0,var_03),param_00,0);
	if(var_0A["fraction"] > 0.99)
	{
		var_09 = 1;
		var_08 = param_00 + (0,0,var_03);
	}

	if(!var_09)
	{
		var_0A = bullettrace(param_00 + (300,0,var_03),param_00,0);
		if(var_0A["fraction"] > 0.99)
		{
			var_09 = 1;
			var_08 = param_00 + (300,0,var_03);
		}
	}

	if(!var_09)
	{
		var_0A = bullettrace(param_00 + (0,300,var_03),param_00,0);
		if(var_0A["fraction"] > 0.99)
		{
			var_09 = 1;
			var_08 = param_00 + (0,300,var_03);
		}
	}

	if(!var_09)
	{
		var_0A = bullettrace(param_00 + (0,-300,var_03),param_00,0);
		if(var_0A["fraction"] > 0.99)
		{
			var_09 = 1;
			var_08 = param_00 + (0,-300,var_03);
		}
	}

	if(!var_09)
	{
		var_0A = bullettrace(param_00 + (300,300,var_03),param_00,0);
		if(var_0A["fraction"] > 0.99)
		{
			var_09 = 1;
			var_08 = param_00 + (300,300,var_03);
		}
	}

	if(!var_09)
	{
		var_0A = bullettrace(param_00 + (-300,0,var_03),param_00,0);
		if(var_0A["fraction"] > 0.99)
		{
			var_09 = 1;
			var_08 = param_00 + (-300,0,var_03);
		}
	}

	if(!var_09)
	{
		var_0A = bullettrace(param_00 + (-300,-300,var_03),param_00,0);
		if(var_0A["fraction"] > 0.99)
		{
			var_09 = 1;
			var_08 = param_00 + (-300,-300,var_03);
		}
	}

	if(!var_09)
	{
		var_0A = bullettrace(param_00 + (300,-300,var_03),param_00,0);
		if(var_0A["fraction"] > 0.99)
		{
			var_09 = 1;
			var_08 = param_00 + (300,-300,var_03);
		}
	}

	if(!var_09)
	{
		for(var_0B = 0;var_0B < 5;var_0B++)
		{
			var_03 = var_03 / 2;
			var_04 = (0,0,var_03);
			var_08 = self.origin + var_04 + var_06 * var_05 * -1;
			var_0C = bullettrace(param_00,var_08,0);
			if(var_0C["fraction"] > 0.99)
			{
				var_09 = 1;
				break;
			}

			wait(0.05);
		}
	}

	if(!var_09)
	{
		for(var_0B = 0;var_0B < 5;var_0B++)
		{
			var_03 = var_03 * 2.5;
			var_04 = (0,0,var_03);
			var_08 = self.origin + var_04 + var_06 * var_05 * -1;
			var_0C = bullettrace(param_00,var_08,0);
			if(var_0C["fraction"] > 0.99)
			{
				var_09 = 1;
				break;
			}

			wait(0.05);
		}
	}

	if(!var_09)
	{
		thread canthittarget();
		return 0;
	}

	var_01 = spawnfx(level.lasedstrikeglow,param_00);
	thread playlocksound();
	self weaponlockfinalize(param_00,(0,0,0),0);
	var_0D = magicbullet("lasedStrike_missile_mp",var_08,param_00,self);
	var_0D missile_settargetent(var_01);
	thread func_4F89(var_01,var_0D);
	var_0D waittill("death");
	if(isdefined(var_01))
	{
		var_01 delete();
	}

	self weaponlockfree();
	return 1;
}

//Function Number: 11
func_4F89(param_00,param_01)
{
	param_01 endon("death");
	level endon("game_ended");
	for(;;)
	{
		triggerfx(param_00);
		wait(0.05);
	}
}

//Function Number: 12
func_4BC4(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	param_00 endon("remote_done");
	self endon("death");
	for(;;)
	{
		var_01 = distance(self.origin,param_00.targetent.origin);
		param_00.owner setclientdvar("ui_reaper_targetDistance",int(var_01 / 12));
		wait(0.05);
	}
}

//Function Number: 13
canthittarget()
{
	thread func_6024();
	self weaponlocktargettooclose(1);
}

//Function Number: 14
func_1B95(param_00,param_01)
{
	foreach(var_03 in level.lasedstrikeents)
	{
		var_04 = bullettrace(var_03.origin,param_01,0,param_00);
		if(var_04["fraction"] >= 0.98)
		{
			return var_03;
		}

		wait(0.05);
	}
}

//Function Number: 15
func_3C24()
{
	var_00 = self geteye();
	var_01 = self getplayerangles();
	var_02 = anglestoforward(var_01);
	var_03 = var_00 + var_02 * 15000;
	var_04 = bullettrace(var_00,var_03,0,undefined);
	if(var_04["surfacetype"] == "none")
	{
		return undefined;
	}

	if(var_04["surfacetype"] == "default")
	{
		return undefined;
	}

	var_05 = var_04["entity"];
	if(isdefined(var_05))
	{
		if(var_05 == level.ac130.planemodel)
		{
			return undefined;
		}
	}

	var_06 = [];
	var_06[0] = var_04["position"];
	var_06[1] = var_04["normal"];
	return var_06;
}

//Function Number: 16
func_78BD(param_00)
{
	var_01 = spawnplane(param_00,"script_model",level.uavrig gettagorigin("tag_origin"),"compass_objpoint_reaper_friendly","compass_objpoint_reaper_enemy");
	if(!isdefined(var_01))
	{
		return undefined;
	}

	var_01 setmodel("vehicle_predator_b");
	var_01.team = param_00.team;
	var_01.owner = param_00;
	var_01.numflares = 2;
	var_01 setcandamage(1);
	var_01 thread func_2319();
	var_01.helitype = "remote_mortar";
	var_01.uavtype = "remote_mortar";
	var_01 maps\mp\killstreaks\_uav::adduavmodel();
	var_02 = 6300;
	var_03 = randomint(360);
	var_04 = 6100;
	var_05 = cos(var_03) * var_04;
	var_06 = sin(var_03) * var_04;
	var_07 = vectornormalize((var_05,var_06,var_02));
	var_07 = var_07 * 6100;
	var_01 linkto(level.uavrig,"tag_origin",var_07,(0,var_03 - 90,10));
	var_01 thread func_3F75(param_00);
	var_01 thread func_3F8D(param_00);
	var_01 thread func_3F8E(param_00);
	var_01 thread func_3F9D();
	var_01 thread func_3F83();
	var_01 thread func_3F82();
	return var_01;
}

//Function Number: 17
func_3F75(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	self endon("remote_removed");
	self endon("remote_done");
	self waittill("death");
	level thread func_65AB(self,1);
}

//Function Number: 18
func_3F8D(param_00)
{
	level endon("game_ended");
	self endon("remote_done");
	self endon("death");
	param_00 endon("disconnect");
	param_00 endon("removed_reaper_ammo");
	param_00 common_scripts\utility::func_8B2A("joined_team","joined_spectators");
	thread func_64D9();
}

//Function Number: 19
func_3F8E(param_00)
{
	level endon("game_ended");
	self endon("remote_done");
	self endon("death");
	param_00 endon("removed_reaper_ammo");
	param_00 waittill("disconnect");
	thread func_64D9();
}

//Function Number: 20
func_745A()
{
	level endon("game_ended");
	self endon("death");
	self endon("remote_done");
	var_00 = 0;
	for(;;)
	{
		self waittill("lasedTargetShotFired");
		var_00++;
		if(var_00 >= 5)
		{
			break;
		}
	}

	thread func_64D9();
}

//Function Number: 21
func_3F9D()
{
	level endon("game_ended");
	self endon("death");
	self endon("remote_done");
	wait(120);
	thread func_64D9();
}

//Function Number: 22
func_65AB(param_00,param_01)
{
	self notify("remote_removed");
	if(isdefined(param_00.targetent))
	{
		param_00.targetent delete();
	}

	level.lasedstrikeactive = 0;
	level.lasedstrikecrateactive = 0;
	if(isdefined(param_00))
	{
		param_00 delete();
		param_00 maps\mp\killstreaks\_uav::func_65B7();
	}

	if(!isdefined(param_01) || param_01 == 1)
	{
		level.remote_mortar = undefined;
	}
}

//Function Number: 23
func_64D9()
{
	level.remote_mortar = undefined;
	level endon("game_ended");
	self endon("death");
	self notify("remote_done");
	var_00 = self.origin + anglestoforward(self.angles) * 20000;
	self moveto(var_00,30);
	playfxontag(level._effect["ac130_engineeffect"],self,"tag_origin");
	maps\mp\gametypes\_hostmigration::func_8B0D(3);
	self moveto(var_00,4,4,0);
	maps\mp\gametypes\_hostmigration::func_8B0D(4);
	level thread func_65AB(self,0);
}

//Function Number: 24
func_64D6()
{
	self notify("death");
	self hide();
	var_00 = anglestoright(self.angles) * 200;
	playfx(level.lasedstrikeexplode,self.origin,var_00);
	level.lasedstrikeactive = 0;
	level.lasedstrikecrateactive = 0;
}

//Function Number: 25
func_2319()
{
	level endon("game_ended");
	self.owner endon("disconnect");
	self.health = 999999;
	self.maxhealth = 1500;
	self.damagetaken = 0;
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(!maps\mp\gametypes\_weapons::func_357F(self.owner,var_01))
		{
			continue;
		}

		if(!isdefined(self))
		{
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
					break;
			}

			maps\mp\killstreaks\_killstreaks::func_4B39(var_01,var_09,self);
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
				thread maps\mp\_utility::func_7FA0("callout_destroyed_remote_mortar",var_01);
				var_01 thread maps\mp\gametypes\_rank::giverankxp("kill",50,var_09,var_04);
				var_01 thread maps\mp\gametypes\_rank::func_8E6E("destroyed_remote_mortar");
				thread maps\mp\gametypes\_missions::vehiclekilled(self.owner,self,undefined,var_01,var_00,var_04,var_09);
			}

			if(isdefined(self.owner))
			{
				self.owner stoplocalsound("missile_incoming");
			}

			thread func_64D6();
			level.remote_mortar = undefined;
		}
	}
}

//Function Number: 26
func_3F83()
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

		var_01 thread func_7BFE(var_02,var_00);
	}
}

//Function Number: 27
func_7BFE(param_00,param_01)
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
			param_00 thread maps\mp\killstreaks\_flares::flares_playfx();
			var_06 = param_00 maps\mp\killstreaks\_flares::func_33D1();
			self missile_settargetent(var_06);
			param_00 = var_06;
			if(isdefined(param_00.owner))
			{
				param_00.owner stoplocalsound("missile_incoming");
			}
		}

		if(var_06 < var_03)
		{
			var_03 = var_06;
		}

		if(var_06 > var_03)
		{
			if(var_06 > 1536)
			{
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
			wait(0.05);
			self delete();
		}

		wait(0.05);
	}
}

//Function Number: 28
func_3F82()
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

//Function Number: 29
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
		for(var_06 = 0;var_06 < param_02.size;var_06++)
		{
			if(isdefined(param_02[var_06]))
			{
				var_08[var_06] = distance(param_02[var_06].origin,var_07);
			}
		}

		var_06 = 0;
		while(var_06 < var_08.size)
		{
			if(isdefined(var_08[var_06]))
			{
				if(var_08[var_06] < 3000 && param_00.numflares > 0)
				{
					param_00.numflares--;
					param_00 thread maps\mp\killstreaks\_flares::flares_playfx();
					var_09 = param_00 maps\mp\killstreaks\_flares::func_33D1();
					for(var_0A = 0;var_0A < param_02.size;var_0A++)
					{
						if(isdefined(param_02[var_0A]))
						{
							param_02[var_0A] missile_settargetent(var_09);
						}
					}

					if(isdefined(param_00.owner))
					{
						param_00.owner stoplocalsound("missile_incoming");
					}
				}

				if(var_0A[var_08] < var_07[var_08])
				{
					var_07[var_08] = var_0A[var_08];
				}

				if(var_0A[var_08] > var_07[var_08])
				{
					if(var_0A[var_08] > 1536)
					{
						continue;
					}

					if(isdefined(param_02.owner))
					{
						param_02.owner stoplocalsound("missile_incoming");
						if(level.teambased)
						{
							if(param_02.team != var_03.team)
							{
								radiusdamage(var_04[var_08].origin,var_06,var_05,var_05,var_03,"MOD_EXPLOSIVE","sam_projectile_mp");
							}
						}
						else
						{
							radiusdamage(var_04[var_08].origin,var_06,var_05,var_05,var_03,"MOD_EXPLOSIVE","sam_projectile_mp");
						}
					}

					var_04[var_08] hide();
					wait(0.05);
					var_04[var_08] delete();
				}
			}

			var_08++;
		}

		wait(0.05);
	}
}