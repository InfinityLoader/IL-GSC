/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_remotetank.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 46
 * Decompile Time: 2347 ms
 * Timestamp: 10/27/2023 12:29:30 AM
*******************************************************************/

//Function Number: 1
init()
{
	scripts\mp\killstreaks\_killstreaks::func_DEFB("remote_tank",::func_128FE);
	level.var_114E4 = [];
	level.var_114E4["remote_tank"] = spawnstruct();
	level.var_114E4["remote_tank"].var_11901 = 60;
	level.var_114E4["remote_tank"].health = 99999;
	level.var_114E4["remote_tank"].maxhealth = 1000;
	level.var_114E4["remote_tank"].var_110EA = "remote_tank";
	level.var_114E4["remote_tank"].var_B6BF = "ugv_turret_mp";
	level.var_114E4["remote_tank"].var_B88D = "remote_tank_projectile_mp";
	level.var_114E4["remote_tank"].var_F268 = "sentry_offline";
	level.var_114E4["remote_tank"].var_13260 = "remote_ugv_mp";
	level.var_114E4["remote_tank"].var_B91A = "vehicle_ugv_talon_mp";
	level.var_114E4["remote_tank"].var_B922 = "vehicle_ugv_talon_gun_mp";
	level.var_114E4["remote_tank"].var_B924 = "vehicle_ugv_talon_obj";
	level.var_114E4["remote_tank"].var_B925 = "vehicle_ugv_talon_obj_red";
	level.var_114E4["remote_tank"].var_B91D = "vehicle_ugv_talon_mp";
	level.var_114E4["remote_tank"].var_1114D = &"KILLSTREAKS_REMOTE_TANK_PLACE";
	level.var_114E4["remote_tank"].var_1114C = &"KILLSTREAKS_REMOTE_TANK_CANNOT_PLACE";
	level.var_114E4["remote_tank"].var_A84D = "killstreak_remote_tank_laptop_mp";
	level.var_114E4["remote_tank"].var_DF7B = "killstreak_remote_tank_remote_mp";
	level._effect["remote_tank_dying"] = loadfx("vfx/core/expl/killstreak_explosion_quick");
	level._effect["remote_tank_explode"] = loadfx("vfx/core/expl/bouncing_betty_explosion");
	level._effect["remote_tank_spark"] = loadfx("vfx/core/impacts/large_metal_painted_hit");
	level._effect["remote_tank_antenna_light_mp"] = loadfx("vfx/core/vehicles/aircraft_light_red_blink");
	level._effect["remote_tank_camera_light_mp"] = loadfx("vfx/core/vehicles/aircraft_light_wingtip_green");
	level.var_DF72 = 0.5;
}

//Function Number: 2
func_128FE(param_00,param_01)
{
	var_02 = 1;
	if(scripts\mp\_utility::func_4BD7() >= scripts\mp\_utility::func_B4D2() || level.var_6BAA + var_02 >= scripts\mp\_utility::func_B4D2())
	{
		self iprintlnbold(&"KILLSTREAKS_TOO_MANY_VEHICLES");
		return 0;
	}

	scripts\mp\_utility::func_93FA();
	var_03 = func_83AC(param_00,"remote_tank");
	if(var_03)
	{
		scripts\mp\_matchdata::func_AFC9("remote_tank",self.origin);
		thread scripts\mp\_utility::func_115DE("used_remote_tank",self);
		func_1146D("remote_tank");
	}
	else
	{
		scripts\mp\_utility::func_4FC1();
	}

	self.var_9D81 = 0;
	return var_03;
}

//Function Number: 3
func_1146D(param_00)
{
	var_01 = scripts\mp\_utility::func_7F55(level.var_114E4[param_00].var_110EA);
	scripts\mp\killstreaks\_killstreaks::func_1146C(var_01);
	scripts\mp\_utility::func_141E(level.var_114E4[param_00].var_A84D);
	scripts\mp\_utility::func_141E(level.var_114E4[param_00].var_DF7B);
}

//Function Number: 4
func_E152()
{
	if(scripts\mp\_utility::_hasperk("specialty_explosivebullets"))
	{
		self.var_E2DF = "specialty_explosivebullets";
		scripts\mp\_utility::func_E150("specialty_explosivebullets");
	}
}

//Function Number: 5
func_E2E0()
{
	if(isdefined(self.var_E2DF))
	{
		scripts\mp\_utility::func_8387(self.var_E2DF);
		self.var_E2DF = undefined;
	}
}

//Function Number: 6
func_1370F()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(0.05);
	func_E2E0();
}

//Function Number: 7
func_E18E()
{
	var_00 = self getweaponslistprimaries();
	foreach(var_02 in var_00)
	{
		var_03 = strtok(var_02,"_");
		if(var_03[0] == "alt")
		{
			self.var_E2E7[var_02] = self getweaponammoclip(var_02);
			self.var_E2E9[var_02] = self getweaponammostock(var_02);
			continue;
		}

		self.var_E2E7[var_02] = self getweaponammoclip(var_02);
		self.var_E2E9[var_02] = self getweaponammostock(var_02);
	}

	self.var_13CD2 = [];
	foreach(var_02 in var_00)
	{
		var_03 = strtok(var_02,"_");
		self.var_13CD2[self.var_13CD2.size] = var_02;
		if(var_03[0] == "alt")
		{
			continue;
		}

		scripts\mp\_utility::func_141E(var_02);
	}
}

//Function Number: 8
func_E2E8()
{
	if(!isdefined(self.var_E2E7) || !isdefined(self.var_E2E9) || !isdefined(self.var_13CD2))
	{
		return;
	}

	var_00 = [];
	foreach(var_02 in self.var_13CD2)
	{
		var_03 = strtok(var_02,"_");
		if(var_03[0] == "alt")
		{
			var_00[var_00.size] = var_02;
			continue;
		}

		scripts\mp\_utility::func_12C6(var_02);
		if(isdefined(self.var_E2E7[var_02]))
		{
			self setweaponammoclip(var_02,self.var_E2E7[var_02]);
		}

		if(isdefined(self.var_E2E9[var_02]))
		{
			self setweaponammostock(var_02,self.var_E2E9[var_02]);
		}
	}

	foreach(var_06 in var_00)
	{
		if(isdefined(self.var_E2E7[var_06]))
		{
			self setweaponammoclip(var_06,self.var_E2E7[var_06]);
		}

		if(isdefined(self.var_E2E9[var_06]))
		{
			self setweaponammostock(var_06,self.var_E2E9[var_06]);
		}
	}

	self.var_E2E7 = undefined;
	self.var_E2E9 = undefined;
}

//Function Number: 9
func_13710()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(0.05);
	func_E2E8();
}

//Function Number: 10
func_83AC(param_00,param_01)
{
	var_02 = func_4A20(param_01,self);
	var_02.var_AC68 = param_00;
	func_E152();
	func_E18E();
	var_03 = func_F689(var_02,1);
	thread func_E2E0();
	thread func_E2E8();
	if(!isdefined(var_03))
	{
		var_03 = 0;
	}

	return var_03;
}

//Function Number: 11
func_4A20(param_00,param_01)
{
	var_02 = spawnturret("misc_turret",param_01.origin + (0,0,25),level.var_114E4[param_00].var_B6BF);
	var_02.angles = param_01.angles;
	var_02.var_114E8 = param_00;
	var_02.var_222 = param_01;
	var_02 setmodel(level.var_114E4[param_00].var_B91A);
	var_02 method_81F5();
	var_02 method_835B(1);
	var_02 method_830F("sentry_offline");
	var_02 makeunusable();
	var_02 method_8336(param_01);
	return var_02;
}

//Function Number: 12
func_F689(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	param_00 thread func_114CE(self);
	scripts\common\utility::allow_weapon(0);
	self notifyonplayercommand("place_tank","+attack");
	self notifyonplayercommand("place_tank","+attack_akimbo_accessible");
	self notifyonplayercommand("cancel_tank","+actionslot 4");
	if(!level.console)
	{
		self notifyonplayercommand("cancel_tank","+actionslot 5");
		self notifyonplayercommand("cancel_tank","+actionslot 6");
		self notifyonplayercommand("cancel_tank","+actionslot 7");
	}

	for(;;)
	{
		var_02 = scripts\common\utility::func_13734("place_tank","cancel_tank","force_cancel_placement");
		if(var_02 == "cancel_tank" || var_02 == "force_cancel_placement")
		{
			if(!param_01 && var_02 == "cancel_tank")
			{
				continue;
			}

			if(level.console)
			{
				var_03 = scripts\mp\_utility::func_7F55(level.var_114E4[param_00.var_114E8].var_110EA);
				if(isdefined(self.var_A6A1) && var_03 == scripts\mp\_utility::func_7F55(self.pers["killstreaks"][self.var_A6A1].var_110EA) && !self getweaponslistitems().size)
				{
					scripts\mp\_utility::func_12C6(var_03,0);
					scripts\mp\_utility::_setactionslot(4,"weapon",var_03);
				}
			}

			param_00 func_114CD();
			scripts\common\utility::allow_weapon(1);
			return 0;
		}

		if(!param_00.var_3872)
		{
			continue;
		}

		param_00 thread func_114D0();
		scripts\common\utility::allow_weapon(1);
		return 1;
	}
}

//Function Number: 13
func_114CE(param_00)
{
	self setmodel(level.var_114E4[self.var_114E8].var_B924);
	self method_8335(param_00);
	self method_82C7(0);
	self setcandamage(0);
	self.var_3A9D = param_00;
	param_00.var_9D81 = 1;
	param_00 thread func_12F34(self);
	thread func_114C6(param_00);
	thread func_114C7(param_00);
	thread func_114C8();
	self notify("carried");
}

//Function Number: 14
func_12F34(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("placed");
	param_00 endon("death");
	param_00.var_3872 = 1;
	var_01 = -1;
	for(;;)
	{
		var_02 = self canplayerplacetank(25,25,50,40,80,0.7);
		param_00.origin = var_02["origin"];
		param_00.angles = var_02["angles"];
		param_00.var_3872 = self isonground() && var_02["result"] && abs(var_02["origin"][2] - self.origin[2]) < 20;
		if(param_00.var_3872 != var_01)
		{
			if(param_00.var_3872)
			{
				param_00 setmodel(level.var_114E4[param_00.var_114E8].var_B924);
				if(self.team != "spectator")
				{
					self method_80F4(level.var_114E4[param_00.var_114E8].var_1114D);
				}
			}
			else
			{
				param_00 setmodel(level.var_114E4[param_00.var_114E8].var_B925);
				if(self.team != "spectator")
				{
					self method_80F4(level.var_114E4[param_00.var_114E8].var_1114C);
				}
			}
		}

		var_01 = param_00.var_3872;
		wait(0.05);
	}
}

//Function Number: 15
func_114C6(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 waittill("death");
	func_114CD();
}

//Function Number: 16
func_114C7(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 waittill("disconnect");
	func_114CD();
}

//Function Number: 17
func_114C8(param_00)
{
	self endon("placed");
	self endon("death");
	level waittill("game_ended");
	func_114CD();
}

//Function Number: 18
func_114CD()
{
	if(isdefined(self.var_3A9D))
	{
		self.var_3A9D method_80F3();
	}

	if(isdefined(self.var_222))
	{
		self.var_222.var_9D81 = 0;
	}

	if(isdefined(self))
	{
		self delete();
	}
}

//Function Number: 19
func_114D0()
{
	self endon("death");
	level endon("game_ended");
	self notify("placed");
	self.var_3A9D method_80F3();
	self.var_3A9D = undefined;
	if(!isdefined(self.var_222))
	{
		return 0;
	}

	var_00 = self.var_222;
	var_00.var_9D81 = 0;
	var_01 = func_4A1F(self);
	if(!isdefined(var_01))
	{
		return 0;
	}

	var_01 playsound("sentry_gun_plant");
	var_01 notify("placed");
	var_01 thread func_114CC();
	self delete();
}

//Function Number: 20
func_114BB()
{
	self endon("death");
	level endon("game_ended");
	if(!isdefined(self.var_222))
	{
		return;
	}

	var_00 = self.var_222;
	var_00 endon("death");
	self waittill("placed");
	var_00 func_1146D(self.var_114E8);
	var_00 scripts\mp\_utility::func_12C6(level.var_114E4[self.var_114E8].var_A84D);
	var_00 scripts\mp\_utility::_switchtoweaponimmediate(level.var_114E4[self.var_114E8].var_A84D);
}

//Function Number: 21
func_4A1F(param_00)
{
	var_01 = param_00.var_222;
	var_02 = param_00.var_114E8;
	var_03 = param_00.var_AC68;
	var_04 = spawnvehicle(level.var_114E4[var_02].var_B91A,var_02,level.var_114E4[var_02].var_13260,param_00.origin,param_00.angles,var_01);
	if(!isdefined(var_04))
	{
		return undefined;
	}

	var_05 = var_04 gettagorigin("tag_turret_attach");
	var_06 = spawnturret("misc_turret",var_05,level.var_114E4[var_02].var_B6BF,0);
	var_06 linkto(var_04,"tag_turret_attach",(0,0,0),(0,0,0));
	var_06 setmodel(level.var_114E4[var_02].var_B922);
	var_06.health = level.var_114E4[var_02].health;
	var_06.var_222 = var_01;
	var_06.angles = var_01.angles;
	var_06.var_10955 = ::func_3758;
	var_06.var_114B1 = var_04;
	var_06 makeunusable();
	var_06 method_82D1(0);
	var_06 setcandamage(0);
	var_04.var_10955 = ::func_3758;
	var_04.var_AC68 = var_03;
	var_04.team = var_01.team;
	var_04.var_222 = var_01;
	var_04 method_831F(var_01);
	var_04.var_B6BD = var_06;
	var_04.health = level.var_114E4[var_02].health;
	var_04.maxhealth = level.var_114E4[var_02].maxhealth;
	var_04.var_E1 = 0;
	var_04.var_52D0 = 0;
	var_04 setcandamage(0);
	var_04.var_114E8 = var_02;
	var_04 scripts\mp\sentientpoolmanager::registersentient("Killstreak_Ground",var_01,1);
	var_06 method_835B(1);
	var_04 func_114CF();
	var_06 method_8336(var_01);
	var_01.var_13106 = 0;
	var_04.var_61A3 = 0;
	var_04.var_4D49 = 1;
	var_04 thread func_114C5();
	var_04 thread func_114D7();
	var_04 thread func_114BB();
	return var_04;
}

//Function Number: 22
func_114CC()
{
	self endon("death");
	self.var_222 endon("disconnect");
	level endon("game_ended");
	self makeunusable();
	self.var_B6BD method_81F7();
	self method_81FC(23,23,23);
	if(!isdefined(self.var_222))
	{
		return;
	}

	var_00 = self.var_222;
	var_01 = (0,0,20);
	if(level.teambased)
	{
		self.team = var_00.team;
		self.var_B6BD.team = var_00.team;
		self.var_B6BD method_835E(var_00.team);
		foreach(var_03 in level.players)
		{
			if(var_03 != var_00 && var_03.team == var_00.team)
			{
				var_04 = self.var_B6BD scripts\mp\_entityheadicons::func_F73D(var_03,scripts\mp\_teams::func_81B0(self.team),var_01,10,10,0,0.05,0,1,0,1);
				if(isdefined(var_04))
				{
					var_04 settargetent(self);
				}
			}
		}
	}

	thread func_114BF();
	thread func_114C0();
	thread func_114BC();
	thread func_114BE();
	thread func_114C1();
	thread func_114B2();
	thread func_114B3();
	func_10E09();
}

//Function Number: 23
func_10E09()
{
	var_00 = self.var_222;
	var_00 scripts\mp\_utility::func_FB09(self.var_114E8);
	if(getdvarint("camera_thirdPerson"))
	{
		var_00 scripts\mp\_utility::setthirdpersondof(0);
	}

	var_00.var_E2D7 = var_00.angles;
	var_00 scripts\mp\_utility::func_7385(1);
	var_01 = var_00 scripts\mp\killstreaks\_killstreaks::func_98C2("remote_tank");
	if(var_01 != "success")
	{
		if(var_01 != "disconnect")
		{
			var_00 scripts\mp\_utility::func_41E9();
		}

		if(isdefined(var_00.var_55E6) && var_00.var_55E6)
		{
			var_00 scripts\common\utility::allow_weapon(1);
		}

		self notify("death");
		return 0;
	}

	var_00 scripts\mp\_utility::func_7385(0);
	self.var_B6BD setcandamage(1);
	self setcandamage(1);
	var_02 = spawnstruct();
	var_02.var_CF14 = 1;
	var_02.var_4E53 = ::func_114C9;
	thread scripts\mp\_movers::func_892F(var_02);
	var_00 method_825C(self);
	var_00 method_825A(self.var_B6BD);
	var_00 thread func_114D6(self);
	var_00 thread func_114B9(self);
	thread func_114B7();
	thread func_114CA();
	var_00.var_13106 = 1;
	var_00 scripts\mp\_utility::func_12C6(level.var_114E4[self.var_114E8].var_DF7B);
	var_00 scripts\mp\_utility::_switchtoweaponimmediate(level.var_114E4[self.var_114E8].var_DF7B);
	thread func_114BD();
	self.var_B6BD thread func_114D5();
}

//Function Number: 24
func_114B2()
{
	self endon("death");
	for(;;)
	{
		playfxontag(scripts\common\utility::getfx("remote_tank_antenna_light_mp"),self.var_B6BD,"tag_headlight_right");
		wait(1);
		stopfxontag(scripts\common\utility::getfx("remote_tank_antenna_light_mp"),self.var_B6BD,"tag_headlight_right");
	}
}

//Function Number: 25
func_114B3()
{
	self endon("death");
	for(;;)
	{
		playfxontag(scripts\common\utility::getfx("remote_tank_camera_light_mp"),self.var_B6BD,"tag_tail_light_right");
		wait(2);
		stopfxontag(scripts\common\utility::getfx("remote_tank_camera_light_mp"),self.var_B6BD,"tag_tail_light_right");
	}
}

//Function Number: 26
func_114CF()
{
	self.var_B6BD method_830F(level.var_114E4[self.var_114E8].var_F268);
	if(level.teambased)
	{
		scripts\mp\_entityheadicons::func_F877("none",(0,0,0));
	}
	else if(isdefined(self.var_222))
	{
		scripts\mp\_entityheadicons::func_F7F2(undefined,(0,0,0));
	}

	if(!isdefined(self.var_222))
	{
		return;
	}

	var_00 = self.var_222;
	if(isdefined(var_00.var_13106) && var_00.var_13106)
	{
		var_00 notify("end_remote");
		var_00 method_825D(self);
		var_00 method_825B(self.var_B6BD);
		var_00 scripts\mp\_utility::_switchtoweapon(var_00 scripts\common\utility::getlastweapon());
		var_00 scripts\mp\_utility::func_41E9();
		var_00 setplayerangles(var_00.var_E2D7);
		if(getdvarint("camera_thirdPerson"))
		{
			var_00 scripts\mp\_utility::setthirdpersondof(1);
		}

		if(isdefined(var_00.var_55E4) && var_00.var_55E4)
		{
			var_00 scripts\common\utility::func_1C6E(1);
		}

		var_00 func_1146D(level.var_114E4[self.var_114E8].var_110EA);
		var_00.var_13106 = 0;
		var_00 thread func_114BA();
	}
}

//Function Number: 27
func_114BA()
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	scripts\mp\_utility::func_7385(1);
	wait(0.5);
	scripts\mp\_utility::func_7385(0);
}

//Function Number: 28
func_114BF()
{
	self endon("death");
	self.var_222 waittill("disconnect");
	if(isdefined(self.var_B6BD))
	{
		self.var_B6BD notify("death");
	}

	self notify("death");
}

//Function Number: 29
func_114C0()
{
	self endon("death");
	self.var_222 waittill("stop_using_remote");
	self notify("death");
}

//Function Number: 30
func_114BC()
{
	self endon("death");
	self.var_222 scripts\common\utility::waittill_any_3("joined_team","joined_spectators");
	self notify("death");
}

//Function Number: 31
func_114C1()
{
	self endon("death");
	var_00 = level.var_114E4[self.var_114E8].var_11901;
	scripts\mp\_hostmigration::func_13708(var_00);
	self notify("death");
}

//Function Number: 32
func_114C9(param_00)
{
	self notify("death");
}

//Function Number: 33
func_114BE()
{
	level endon("game_ended");
	var_00 = self getentitynumber();
	func_1864(var_00);
	self waittill("death");
	self playsound("talon_destroyed");
	func_E122(var_00);
	self setmodel(level.var_114E4[self.var_114E8].var_B91D);
	if(isdefined(self.var_222) && self.var_222.var_13106 || self.var_222 scripts\mp\_utility::func_9FC6())
	{
		func_114CF();
		self.var_222.var_13106 = 0;
	}

	self.var_B6BD method_82D1(40);
	self.var_B6BD method_8336(undefined);
	self playsound("sentry_explode");
	playfxontag(level._effect["remote_tank_dying"],self.var_B6BD,"tag_aim");
	wait(2);
	playfx(level._effect["remote_tank_explode"],self.origin);
	self.var_B6BD delete();
	scripts\mp\_utility::func_4FC1();
	self delete();
}

//Function Number: 34
func_3758(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09,param_0A,param_0B)
{
	var_0C = self;
	if(isdefined(self.var_114B1))
	{
		var_0C = self.var_114B1;
	}

	if(isdefined(var_0C.var_1D41) && var_0C.var_1D41)
	{
		return;
	}

	if(!scripts\mp\_weapons::func_7415(var_0C.var_222,param_01))
	{
		return;
	}

	if(isdefined(param_03) && param_03 & level.var_92C4)
	{
		var_0C.var_1390E = 1;
	}

	if(isdefined(param_03) && param_03 & level.var_92C6)
	{
		var_0C.var_1390F = 1;
	}

	var_0C.var_1390B = 1;
	var_0C.var_4D49 = 0;
	playfxontagforclients(level._effect["remote_tank_spark"],var_0C,"tag_player",var_0C.var_222);
	if(isdefined(param_05))
	{
		switch(param_05)
		{
			case "stealth_bomb_mp":
			case "artillery_mp":
				param_02 = param_02 * 4;
				break;
		}
	}

	if(param_04 == "MOD_MELEE")
	{
		param_02 = var_0C.maxhealth * 0.5;
	}

	var_0D = param_02;
	if(isplayer(param_01))
	{
		param_01 scripts\mp\_damagefeedback::func_12E84("remote_tank");
		if(param_04 == "MOD_RIFLE_BULLET" || param_04 == "MOD_PISTOL_BULLET")
		{
			if(param_01 scripts\mp\_utility::_hasperk("specialty_armorpiercing"))
			{
				var_0D = var_0D + param_02 * level.var_218B;
			}
		}

		if(function_0107(param_04))
		{
			var_0D = var_0D + param_02;
		}
	}

	if(function_0107(param_04) && isdefined(param_05) && param_05 == "destructible_car")
	{
		var_0D = var_0C.maxhealth;
	}

	if(isdefined(param_01.var_222) && isplayer(param_01.var_222))
	{
		param_01.var_222 scripts\mp\_damagefeedback::func_12E84("remote_tank");
	}

	if(isdefined(param_05))
	{
		switch(param_05)
		{
			case "remotemissile_projectile_mp":
			case "javelin_mp":
			case "remote_mortar_missile_mp":
			case "stinger_mp":
			case "ac130_40mm_mp":
			case "ac130_105mm_mp":
				var_0C.var_A859 = 1;
				var_0D = var_0C.maxhealth + 1;
				break;

			case "stealth_bomb_mp":
			case "artillery_mp":
				var_0C.var_A859 = 0;
				var_0D = var_0C.maxhealth * 0.5;
				break;

			case "bomb_site_mp":
				var_0C.var_A859 = 0;
				var_0D = var_0C.maxhealth + 1;
				break;

			case "emp_grenade_mp":
				var_0D = 0;
				var_0C thread func_114B8();
				break;

			case "ims_projectile_mp":
				var_0C.var_A859 = 1;
				var_0D = var_0C.maxhealth * 0.5;
				break;
		}

		scripts\mp\killstreaks\_killstreaks::func_A6A0(param_01,param_05,self);
	}

	var_0C.var_E1 = var_0C.var_E1 + var_0D;
	var_0C playsound("talon_damaged");
	if(var_0C.var_E1 >= var_0C.maxhealth)
	{
		if(isplayer(param_01) && !isdefined(var_0C.var_222) || param_01 != var_0C.var_222)
		{
			var_0C.var_1D41 = 1;
			param_01 notify("destroyed_killstreak",param_05);
			thread scripts\mp\_utility::func_115DE("callout_destroyed_remote_tank",param_01);
			param_01 thread scripts\mp\_utility::func_83B4("kill",param_05,300);
		}

		var_0C notify("death");
	}
}

//Function Number: 35
func_114B8()
{
	self notify("tank_EMPGrenaded");
	self endon("tank_EMPGrenaded");
	self endon("death");
	self.var_222 endon("disconnect");
	level endon("game_ended");
	self.var_61A3 = 1;
	self.var_B6BD method_83C6();
	wait(3.5);
	self.var_61A3 = 0;
	self.var_B6BD method_83C7();
}

//Function Number: 36
func_114C5()
{
	self endon("death");
	level endon("game_ended");
	var_00 = 0;
	for(;;)
	{
		if(!self.var_61A3)
		{
			if(self.var_4D49 < 1)
			{
				self.var_4D49 = self.var_4D49 + 0.1;
				var_00 = 1;
			}
			else if(var_00)
			{
				self.var_4D49 = 1;
				var_00 = 0;
			}
		}

		wait(0.1);
	}
}

//Function Number: 37
func_114D7()
{
	self endon("death");
	level endon("game_ended");
	var_00 = 0.1;
	var_01 = 1;
	var_02 = 1;
	for(;;)
	{
		if(var_02)
		{
			if(self.var_E1 > 0)
			{
				var_02 = 0;
				var_01++;
			}
		}
		else if(self.var_E1 >= self.maxhealth * var_00 * var_01)
		{
			var_01++;
		}

		wait(0.05);
	}
}

//Function Number: 38
func_114BD()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isdefined(self.var_10955))
		{
			self [[ self.var_10955 ]](undefined,var_01,var_00,var_08,var_04,var_09,var_03,var_02,undefined,undefined,var_05,var_07);
		}
	}
}

//Function Number: 39
func_114D5()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(isdefined(self.var_10955) && isdefined(self.var_114B1) && !function_0107(var_04) || isdefined(var_09) && function_0107(var_04) && var_09 == "stealth_bomb_mp" || var_09 == "artillery_mp")
		{
			self.var_114B1 [[ self.var_10955 ]](undefined,var_01,var_00,var_08,var_04,var_09,var_03,var_02,undefined,undefined,var_05,var_07);
		}
	}
}

//Function Number: 40
func_114D6(param_00)
{
	self endon("disconnect");
	self endon("end_remote");
	param_00 endon("death");
	var_01 = 50;
	var_02 = var_01;
	var_03 = function_0240(level.var_114E4[param_00.var_114E8].var_B6BF);
	for(;;)
	{
		if(param_00.var_B6BD method_81A1())
		{
			var_02--;
			if(var_02 <= 0)
			{
				param_00.var_B6BD method_83C6();
				wait(2.5);
				param_00 playsound("talon_reload");
				self playlocalsound("talon_reload_plr");
				var_02 = var_01;
				param_00.var_B6BD method_83C7();
			}
		}

		wait(var_03);
	}
}

//Function Number: 41
func_114B9(param_00)
{
	self endon("disconnect");
	self endon("end_remote");
	level endon("game_ended");
	param_00 endon("death");
	var_01 = 0;
	for(;;)
	{
		if(self fragbuttonpressed() && !param_00.var_61A3)
		{
			var_02 = param_00.var_B6BD.origin;
			var_03 = param_00.var_B6BD.angles;
			switch(var_01)
			{
				case 0:
					var_02 = param_00.var_B6BD gettagorigin("tag_missile1");
					var_03 = param_00.var_B6BD gettagangles("tag_player");
					break;
	
				case 1:
					var_02 = param_00.var_B6BD gettagorigin("tag_missile2");
					var_03 = param_00.var_B6BD gettagangles("tag_player");
					break;
			}

			param_00 playsound("talon_missile_fire");
			self playlocalsound("talon_missile_fire_plr");
			var_04 = var_02 + anglestoforward(var_03) * 100;
			var_05 = scripts\mp\_utility::func_1309(level.var_114E4[param_00.var_114E8].var_B88D,var_02,var_04,self);
			var_01 = var_01 + 1 % 2;
			wait(5);
			param_00 playsound("talon_rocket_reload");
			self playlocalsound("talon_rocket_reload_plr");
			continue;
		}

		wait(0.05);
	}
}

//Function Number: 42
func_114B6(param_00)
{
	self endon("disconnect");
	self endon("end_remote");
	level endon("game_ended");
	param_00 endon("death");
	for(;;)
	{
		if(self secondaryoffhandbuttonpressed())
		{
			var_01 = bullettrace(param_00.origin + (0,0,4),param_00.origin - (0,0,4),0,param_00);
			var_02 = vectornormalize(var_01["normal"]);
			var_03 = vectortoangles(var_02);
			var_03 = var_03 + (90,0,0);
			var_04 = scripts\mp\_weapons::func_108E3(param_00.origin,self,"equipment",var_03);
			param_00 playsound("item_blast_shield_on");
			wait(8);
			continue;
		}

		wait(0.05);
	}
}

//Function Number: 43
func_114B7()
{
	self endon("death");
	self.var_222 endon("end_remote");
	for(;;)
	{
		earthquake(0.1,0.25,self.var_B6BD gettagorigin("tag_player"),50);
		wait(0.25);
	}
}

//Function Number: 44
func_1864(param_00)
{
	level.var_12B14[param_00] = self;
}

//Function Number: 45
func_E122(param_00)
{
	level.var_12B14[param_00] = undefined;
}

//Function Number: 46
func_114CA()
{
	if(!isdefined(self.var_222))
	{
		return;
	}

	var_00 = self.var_222;
	level endon("game_ended");
	var_00 endon("disconnect");
	var_00 endon("end_remote");
	self endon("death");
	for(;;)
	{
		var_01 = 0;
		while(var_00 usebuttonpressed())
		{
			var_01 = var_01 + 0.05;
			if(var_01 > 0.75)
			{
				self notify("death");
				return;
			}

			wait(0.05);
		}

		wait(0.05);
	}
}