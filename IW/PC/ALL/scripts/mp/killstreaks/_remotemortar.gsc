/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_remotemortar.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 1245 ms
 * Timestamp: 10/27/2023 12:29:27 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_DF70["laserTarget"] = loadfx("vfx/misc/laser_glow");
	level.var_DF70["missileExplode"] = loadfx("vfx/core/expl/bouncing_betty_explosion");
	level.var_DF70["deathExplode"] = loadfx("vfx/core/expl/uav_advanced_death");
	scripts\mp\killstreaks\_killstreaks::func_DEFB("remote_mortar",::func_128FD);
	level.var_DF6F = undefined;
}

//Function Number: 2
func_128FD(param_00,param_01)
{
	if(isdefined(level.var_DF6F))
	{
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		return 0;
	}

	scripts\mp\_utility::func_FB09("remote_mortar");
	var_02 = scripts\mp\killstreaks\_killstreaks::func_98C2("remote_mortar");
	if(var_02 != "success")
	{
		if(var_02 != "disconnect")
		{
			scripts\mp\_utility::func_41E9();
		}

		return 0;
	}
	else if(isdefined(level.var_DF6F))
	{
		self iprintlnbold(&"KILLSTREAKS_AIR_SPACE_TOO_CROWDED");
		scripts\mp\_utility::func_41E9();
		return 0;
	}

	scripts\mp\_matchdata::func_AFC9("remote_mortar",self.origin);
	return func_10DE9(param_00);
}

//Function Number: 3
func_10DE9(param_00)
{
	var_01 = func_10906(param_00,self);
	if(!isdefined(var_01))
	{
		return 0;
	}

	level.var_DF6F = var_01;
	func_DF87(var_01);
	thread scripts\mp\_utility::func_115DE("used_remote_mortar",self);
	return 1;
}

//Function Number: 4
func_10906(param_00,param_01)
{
	var_02 = spawnplane(param_01,"script_model",level.var_12AF5 gettagorigin("tag_origin"),"compass_objpoint_reaper_friendly","compass_objpoint_reaper_enemy");
	if(!isdefined(var_02))
	{
		return undefined;
	}

	var_02 setmodel("vehicle_predator_b");
	var_02.var_AC68 = param_00;
	var_02.team = param_01.team;
	var_02.var_222 = param_01;
	var_02.var_C22B = 1;
	var_02 setcandamage(1);
	var_02 thread func_4D72();
	var_02.var_8DD9 = "remote_mortar";
	var_02.var_12AFA = "remote_mortar";
	var_02 scripts\mp\killstreaks\_uav::func_1867();
	var_03 = 6300;
	var_04 = randomint(360);
	var_05 = 6100;
	var_06 = cos(var_04) * var_05;
	var_07 = sin(var_04) * var_05;
	var_08 = vectornormalize((var_06,var_07,var_03));
	var_08 = var_08 * 6100;
	var_02 linkto(level.var_12AF5,"tag_origin",var_08,(0,var_04 - 90,10));
	param_01 setclientdvar("ui_reaper_targetDistance",-1);
	param_01 setclientdvar("ui_reaper_ammoCount",14);
	var_02 thread func_898E(param_01);
	var_02 thread func_89F3(param_01);
	var_02 thread func_89CE(param_01);
	var_02 thread func_89CF(param_01);
	var_02 thread func_89B7();
	var_02 thread func_89B6();
	return var_02;
}

//Function Number: 5
func_B011(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("death");
	wait(0.05);
	var_01 = vectortoangles(level.var_12AF5.origin - param_00 gettagorigin("tag_player"));
	self setplayerangles(var_01);
}

//Function Number: 6
func_DF87(param_00)
{
	scripts\mp\_utility::func_12C6("mortar_remote_mp");
	scripts\mp\_utility::_switchtoweapon("mortar_remote_mp");
	thread func_13714(1,param_00);
	thread scripts\mp\_utility::func_DF2E(param_00);
	if(getdvarint("camera_thirdPerson"))
	{
		scripts\mp\_utility::setthirdpersondof(0);
	}

	self playerlinkweaponviewtodelta(param_00,"tag_player",1,40,40,25,40);
	thread func_B011(param_00);
	scripts\common\utility::func_1C76(0);
	thread func_DF88(param_00);
	thread func_DF7A(param_00);
	thread func_DFB3(param_00);
}

//Function Number: 7
func_13714(param_00,param_01)
{
	self endon("disconnect");
	param_01 endon("death");
	wait(param_00);
	self visionsetthermalforplayer(level.var_1537.var_65D1,0);
	self.var_AA42 = level.var_1537.var_65D1;
	self thermalvisionfofoverlayon();
}

//Function Number: 8
func_DF88(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	param_00 endon("remote_done");
	param_00 endon("death");
	param_00.var_1155F = spawnfx(level.var_DF70["laserTarget"],(0,0,0));
	for(;;)
	{
		var_01 = self geteye();
		var_02 = anglestoforward(self getplayerangles());
		var_03 = var_01 + var_02 * 15000;
		var_04 = bullettrace(var_01,var_03,0,param_00.var_1155F);
		if(isdefined(var_04["position"]))
		{
			param_00.var_1155F.origin = var_04["position"];
			triggerfx(param_00.var_1155F);
		}

		wait(0.05);
	}
}

//Function Number: 9
func_DF7A(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	param_00 endon("remote_done");
	param_00 endon("death");
	var_01 = gettime();
	var_02 = var_01 - 2200;
	var_03 = 14;
	self.var_6DB6 = 0;
	for(;;)
	{
		var_01 = gettime();
		if(self attackbuttonpressed() && var_01 - var_02 > 3000)
		{
			var_03--;
			self setclientdvar("ui_reaper_ammoCount",var_03);
			var_02 = var_01;
			self.var_6DB6 = 1;
			self playlocalsound("reaper_fire");
			self playrumbleonentity("damage_heavy");
			var_04 = self geteye();
			var_05 = anglestoforward(self getplayerangles());
			var_06 = anglestoright(self getplayerangles());
			var_07 = var_04 + var_05 * 100 + var_06 * -100;
			var_08 = scripts\mp\_utility::func_1309("remote_mortar_missile_mp",var_07,param_00.var_1155F.origin,self);
			var_08.type = "remote_mortar";
			earthquake(0.3,0.5,var_04,256);
			var_08 missile_settargetent(param_00.var_1155F);
			var_08 missile_setflightmodedirect();
			var_08 thread func_DF7F(param_00);
			var_08 thread func_DF81(param_00);
			var_08 waittill("death");
			self setclientdvar("ui_reaper_targetDistance",-1);
			self.var_6DB6 = 0;
			if(var_03 == 0)
			{
				break;
			}

			continue;
		}

		wait(0.05);
	}

	self notify("removed_reaper_ammo");
	func_DF78(param_00);
	param_00 thread func_DF7C();
}

//Function Number: 10
func_89F4(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	param_00 endon("remote_done");
	param_00 endon("death");
	self notifyonplayercommand("remote_mortar_toggleZoom1","+ads_akimbo_accessible");
	if(!level.console)
	{
		self notifyonplayercommand("remote_mortar_toggleZoom1","+toggleads_throw");
	}

	for(;;)
	{
		var_01 = scripts\common\utility::func_13734("remote_mortar_toggleZoom1");
		if(!isdefined(self.var_DF71))
		{
			self.var_DF71 = 0;
		}

		self.var_DF71 = 1 - self.var_DF71;
	}
}

//Function Number: 11
func_DFB3(param_00)
{
	level endon("game_ended");
	self endon("disconnect");
	param_00 endon("remote_done");
	param_00 endon("death");
	self.var_DF71 = undefined;
	thread func_89F4(param_00);
	param_00.var_13FCA = 0;
	var_01 = 0;
	for(;;)
	{
		if(self adsbuttonpressed())
		{
			wait(0.05);
			if(isdefined(self.var_DF71))
			{
				var_01 = 1;
			}

			break;
		}

		wait(0.05);
	}

	for(;;)
	{
		if((!var_01 && self adsbuttonpressed()) || var_01 && self.var_DF71)
		{
			if(param_00.var_13FCA == 0)
			{
				scripts\mp\_utility::func_12C6("mortar_remote_zoom_mp");
				scripts\mp\_utility::_switchtoweapon("mortar_remote_zoom_mp");
				param_00.var_13FCA = 1;
			}
		}
		else if((!var_01 && !self adsbuttonpressed()) || var_01 && !self.var_DF71)
		{
			if(param_00.var_13FCA == 1)
			{
				scripts\mp\_utility::func_12C6("mortar_remote_mp");
				scripts\mp\_utility::_switchtoweapon("mortar_remote_mp");
				param_00.var_13FCA = 0;
			}
		}

		wait(0.05);
	}
}

//Function Number: 12
func_DF7F(param_00)
{
	level endon("game_ended");
	param_00 endon("death");
	param_00 endon("remote_done");
	self endon("death");
	for(;;)
	{
		var_01 = distance(self.origin,param_00.var_1155F.origin);
		param_00.var_222 setclientdvar("ui_reaper_targetDistance",int(var_01 / 12));
		wait(0.05);
	}
}

//Function Number: 13
func_DF81(param_00)
{
	self endon("death");
	scripts\mp\_hostmigration::func_13708(6);
	playfx(level.var_DF70["missileExplode"],self.origin);
	self delete();
}

//Function Number: 14
func_DF78(param_00)
{
	if(!scripts\mp\_utility::func_9FC6())
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
	scripts\mp\_utility::func_E2D8(0);
	self unlink();
	scripts\mp\_utility::func_41E9();
	if(getdvarint("camera_thirdPerson"))
	{
		scripts\mp\_utility::setthirdpersondof(1);
	}

	scripts\mp\_utility::_switchtoweapon(scripts\common\utility::getlastweapon());
	var_01 = scripts\mp\_utility::func_7F55("remote_mortar");
	scripts\mp\_utility::func_141E(var_01);
	scripts\mp\_utility::func_141E("mortar_remote_zoom_mp");
	scripts\mp\_utility::func_141E("mortar_remote_mp");
	scripts\common\utility::func_1C76(1);
}

//Function Number: 15
func_89F3(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("removed_reaper_ammo");
	self endon("death");
	var_01 = 40;
	scripts\mp\_hostmigration::func_13708(var_01);
	while(param_00.var_6DB6)
	{
		wait(0.05);
	}

	if(isdefined(param_00))
	{
		param_00 func_DF78(self);
	}

	thread func_DF7C();
}

//Function Number: 16
func_898E(param_00)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	self endon("remote_removed");
	self endon("remote_done");
	self waittill("death");
	if(isdefined(param_00))
	{
		param_00 func_DF78(self);
	}

	level thread func_E161(self,1);
}

//Function Number: 17
func_89CE(param_00)
{
	level endon("game_ended");
	self endon("remote_done");
	self endon("death");
	param_00 endon("disconnect");
	param_00 endon("removed_reaper_ammo");
	param_00 scripts\common\utility::waittill_any_3("joined_team","joined_spectators");
	if(isdefined(param_00))
	{
		param_00 func_DF78(self);
	}

	thread func_DF7C();
}

//Function Number: 18
func_89CF(param_00)
{
	level endon("game_ended");
	self endon("remote_done");
	self endon("death");
	param_00 endon("removed_reaper_ammo");
	param_00 waittill("disconnect");
	thread func_DF7C();
}

//Function Number: 19
func_E161(param_00,param_01)
{
	self notify("remote_removed");
	if(isdefined(param_00.var_1155F))
	{
		param_00.var_1155F delete();
	}

	if(isdefined(param_00))
	{
		param_00 delete();
		param_00 scripts\mp\killstreaks\_uav::func_E182();
	}

	if(!isdefined(param_01) || param_01 == 1)
	{
		level.var_DF6F = undefined;
	}
}

//Function Number: 20
func_DF7C()
{
	level.var_DF6F = undefined;
	level endon("game_ended");
	self endon("death");
	self notify("remote_done");
	self unlink();
	var_00 = self.origin + anglestoforward(self.angles) * 20000;
	self moveto(var_00,30);
	playfxontag(level._effect["ac130_engineeffect"],self,"tag_origin");
	scripts\mp\_hostmigration::func_13708(3);
	self moveto(var_00,4,4,0);
	scripts\mp\_hostmigration::func_13708(4);
	level thread func_E161(self,0);
}

//Function Number: 21
func_DF79()
{
	self notify("death");
	self hide();
	var_00 = anglestoright(self.angles) * 200;
	playfx(level.var_DF70["deathExplode"],self.origin,var_00);
}

//Function Number: 22
func_4D72()
{
	level endon("game_ended");
	self.var_222 endon("disconnect");
	self.health = 999999;
	self.maxhealth = 1500;
	self.var_E1 = 0;
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(!scripts\mp\_weapons::func_7415(self.var_222,var_01))
		{
			continue;
		}

		if(!isdefined(self))
		{
			return;
		}

		if(isdefined(var_08) && var_08 & level.var_92C4)
		{
			self.var_1390E = 1;
		}

		if(isdefined(var_08) && var_08 & level.var_92C6)
		{
			self.var_1390F = 1;
		}

		self.var_1390B = 1;
		var_0A = var_00;
		if(isplayer(var_01))
		{
			var_01 scripts\mp\_damagefeedback::func_12E84("");
			if(var_04 == "MOD_RIFLE_BULLET" || var_04 == "MOD_PISTOL_BULLET")
			{
				if(var_01 scripts\mp\_utility::_hasperk("specialty_armorpiercing"))
				{
					var_0A = var_0A + var_00 * level.var_218B;
				}
			}
		}

		if(isdefined(var_09))
		{
			switch(var_09)
			{
				case "javelin_mp":
				case "stinger_mp":
					self.var_A859 = 1;
					var_0A = self.maxhealth + 1;
					break;
	
				case "sam_projectile_mp":
					self.var_A859 = 1;
					break;
			}

			scripts\mp\killstreaks\_killstreaks::func_A6A0(var_01,var_09,self);
		}

		self.var_E1 = self.var_E1 + var_0A;
		if(isdefined(self.var_222))
		{
			self.var_222 playlocalsound("reaper_damaged");
		}

		if(self.var_E1 >= self.maxhealth)
		{
			if(isplayer(var_01) && !isdefined(self.var_222) || var_01 != self.var_222)
			{
				var_01 notify("destroyed_killstreak",var_09);
				thread scripts\mp\_utility::func_115DE("callout_destroyed_remote_mortar",var_01);
				var_01 thread scripts\mp\_utility::func_83B4("kill",var_09,50);
			}

			if(isdefined(self.var_222))
			{
				self.var_222 stoplocalsound("missile_incoming");
			}

			thread func_DF79();
			level.var_DF6F = undefined;
			return;
		}
	}
}

//Function Number: 23
func_89B7()
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

		var_01 thread func_10FA8(var_02,var_00);
	}
}

//Function Number: 24
func_10FA8(param_00,param_01)
{
	self endon("death");
	param_00 endon("death");
	if(isdefined(param_00.var_222))
	{
		param_00.var_222 playlocalsound("missile_incoming");
	}

	self missile_settargetent(param_00);
	var_02 = distance(self.origin,param_00 method_8159(0,0,0));
	var_03 = param_00 method_8159(0,0,0);
	for(;;)
	{
		if(!isdefined(param_00))
		{
			var_04 = var_03;
		}
		else
		{
			var_04 = param_00 method_8159(0,0,0);
		}

		var_03 = var_04;
		var_05 = distance(self.origin,var_04);
		if(var_05 < 3000 && param_00.var_C22B > 0)
		{
			param_00.var_C22B--;
			param_00 thread scripts\mp\killstreaks\_flares::func_6EAE();
			var_06 = param_00 scripts\mp\killstreaks\_flares::func_6EA0();
			self missile_settargetent(var_06);
			param_00 = var_06;
			if(isdefined(param_00.var_222))
			{
				param_00.var_222 stoplocalsound("missile_incoming");
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

			if(isdefined(param_01.var_222))
			{
				param_01.var_222 stoplocalsound("missile_incoming");
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

//Function Number: 25
func_89B6()
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

		level thread func_EB18(var_02,var_00,var_01);
	}
}

//Function Number: 26
func_EB18(param_00,param_01,param_02)
{
	param_00 endon("death");
	if(isdefined(param_00.var_222))
	{
		param_00.var_222 playlocalsound("missile_incoming");
	}

	var_03 = 150;
	var_04 = 1000;
	var_05 = [];
	for(var_06 = 0;var_06 < param_02.size;var_06++)
	{
		if(isdefined(param_02[var_06]))
		{
			var_05[var_06] = distance(param_02[var_06].origin,param_00 method_8159(0,0,0));
			continue;
		}

		var_05[var_06] = undefined;
	}

	for(;;)
	{
		var_07 = param_00 method_8159(0,0,0);
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
				if(var_08[var_06] < 3000 && param_00.var_C22B > 0)
				{
					param_00.var_C22B--;
					param_00 thread scripts\mp\killstreaks\_flares::func_6EAE();
					var_09 = param_00 scripts\mp\killstreaks\_flares::func_6EA0();
					for(var_0A = 0;var_0A < param_02.size;var_0A++)
					{
						if(isdefined(param_02[var_0A]))
						{
							param_02[var_0A] missile_settargetent(var_09);
						}
					}

					if(isdefined(param_00.var_222))
					{
						param_00.var_222 stoplocalsound("missile_incoming");
					}

					return;
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

					if(isdefined(param_02.var_222))
					{
						param_02.var_222 stoplocalsound("missile_incoming");
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