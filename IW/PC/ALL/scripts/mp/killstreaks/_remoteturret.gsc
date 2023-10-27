/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_remoteturret.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 36
 * Decompile Time: 1859 ms
 * Timestamp: 10/27/2023 12:29:32 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_12A9A = [];
	level.var_12A9A["mg_turret"] = "remote_mg_turret";
	scripts\mp\killstreaks\_killstreaks::func_DEFB("remote_mg_turret",::func_128FC);
	level.var_12A8D = [];
	level.var_12A8D["mg_turret"] = spawnstruct();
	level.var_12A8D["mg_turret"].var_F269 = "manual";
	level.var_12A8D["mg_turret"].var_F268 = "sentry_offline";
	level.var_12A8D["mg_turret"].var_11901 = 60;
	level.var_12A8D["mg_turret"].health = 999999;
	level.var_12A8D["mg_turret"].maxhealth = 1000;
	level.var_12A8D["mg_turret"].var_110EA = "remote_mg_turret";
	level.var_12A8D["mg_turret"].var_39B = "remote_turret_mp";
	level.var_12A8D["mg_turret"].var_B91A = "mp_remote_turret";
	level.var_12A8D["mg_turret"].var_B924 = "mp_remote_turret_placement";
	level.var_12A8D["mg_turret"].var_B925 = "mp_remote_turret_placement_failed";
	level.var_12A8D["mg_turret"].var_B91D = "mp_remote_turret";
	level.var_12A8D["mg_turret"].var_115EB = "used_remote_mg_turret";
	level.var_12A8D["mg_turret"].var_901A = &"KILLSTREAKS_ENTER_REMOTE_TURRET";
	level.var_12A8D["mg_turret"].var_901B = &"KILLSTREAKS_EARLY_EXIT";
	level.var_12A8D["mg_turret"].var_901F = &"KILLSTREAKS_DOUBLE_TAP_TO_CARRY";
	level.var_12A8D["mg_turret"].var_CC28 = &"KILLSTREAKS_TURRET_PLACE";
	level.var_12A8D["mg_turret"].var_38E3 = &"KILLSTREAKS_TURRET_CANNOT_PLACE";
	level.var_12A8D["mg_turret"].var_13523 = "remote_sentry_destroyed";
	level.var_12A8D["mg_turret"].var_A84D = "killstreak_remote_turret_laptop_mp";
	level.var_12A8D["mg_turret"].var_DF7B = "killstreak_remote_turret_remote_mp";
	level._effect["sentry_explode_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_sentry_gun_explosion");
	level._effect["sentry_smoke_mp"] = loadfx("vfx/core/mp/killstreaks/vfx_sg_damage_blacksmoke");
	level._effect["antenna_light_mp"] = loadfx("vfx/core/lights/light_detonator_blink");
}

//Function Number: 2
func_128FC(param_00,param_01)
{
	var_02 = func_128FF(param_00,"mg_turret");
	if(var_02)
	{
		scripts\mp\_matchdata::func_AFC9(level.var_12A8D["mg_turret"].var_110EA,self.origin);
	}

	self.var_9D81 = 0;
	return var_02;
}

//Function Number: 3
func_1146D(param_00)
{
	scripts\mp\_utility::func_141E(level.var_12A8D[param_00].var_A84D);
	scripts\mp\_utility::func_141E(level.var_12A8D[param_00].var_DF7B);
}

//Function Number: 4
func_128FF(param_00,param_01)
{
	if(scripts\mp\_utility::func_9FC6())
	{
		return 0;
	}

	var_02 = func_4A2C(param_01,self);
	func_E152();
	func_F68B(var_02,1);
	thread func_E2E0();
	if(isdefined(var_02))
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
func_F68B(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	param_00 func_12A2C(self);
	scripts\common\utility::allow_weapon(0);
	self notifyonplayercommand("place_turret","+attack");
	self notifyonplayercommand("place_turret","+attack_akimbo_accessible");
	self notifyonplayercommand("cancel_turret","+actionslot 4");
	if(!level.console)
	{
		self notifyonplayercommand("cancel_turret","+actionslot 5");
		self notifyonplayercommand("cancel_turret","+actionslot 6");
		self notifyonplayercommand("cancel_turret","+actionslot 7");
	}

	for(;;)
	{
		var_02 = scripts\common\utility::func_13734("place_turret","cancel_turret","force_cancel_placement");
		if(var_02 == "cancel_turret" || var_02 == "force_cancel_placement")
		{
			if(var_02 == "cancel_turret" && !param_01)
			{
				continue;
			}

			if(level.console)
			{
				var_03 = scripts\mp\_utility::func_7F55(level.var_12A8D[param_00.var_12A9A].var_110EA);
				if(isdefined(self.var_A6A1) && var_03 == scripts\mp\_utility::func_7F55(self.pers["killstreaks"][self.var_A6A1].var_110EA) && !self getweaponslistitems().size)
				{
					scripts\mp\_utility::func_12C6(var_03,0);
					scripts\mp\_utility::_setactionslot(4,"weapon",var_03);
				}
			}

			param_00 func_12A2B();
			scripts\common\utility::allow_weapon(1);
			return 0;
		}

		if(!param_00.var_3872)
		{
			continue;
		}

		param_00 func_12A2E();
		scripts\common\utility::allow_weapon(1);
		return 1;
	}
}

//Function Number: 6
func_E152()
{
	if(scripts\mp\_utility::_hasperk("specialty_explosivebullets"))
	{
		self.var_E2DF = "specialty_explosivebullets";
		scripts\mp\_utility::func_E150("specialty_explosivebullets");
	}
}

//Function Number: 7
func_E2E0()
{
	if(isdefined(self.var_E2DF))
	{
		scripts\mp\_utility::func_8387(self.var_E2DF);
		self.var_E2DF = undefined;
	}
}

//Function Number: 8
func_1370F()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(0.05);
	func_E2E0();
}

//Function Number: 9
func_E18E()
{
	foreach(var_01 in self.var_13CA0)
	{
		var_02 = strtok(var_01,"_");
		if(var_02[0] == "alt")
		{
			self.var_E2E7[var_01] = self getweaponammoclip(var_01);
			self.var_E2E9[var_01] = self getweaponammostock(var_01);
			continue;
		}

		self.var_E2E7[var_01] = self getweaponammoclip(var_01);
		self.var_E2E9[var_01] = self getweaponammostock(var_01);
	}

	self.var_13CD2 = [];
	foreach(var_01 in self.var_13CA0)
	{
		var_02 = strtok(var_01,"_");
		if(var_02[0] == "alt")
		{
			continue;
		}

		self.var_13CD2[self.var_13CD2.size] = var_01;
		scripts\mp\_utility::func_141E(var_01);
	}
}

//Function Number: 10
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

//Function Number: 11
func_13710()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(0.05);
	func_E2E8();
}

//Function Number: 12
func_12A2E()
{
	self setmodel(level.var_12A8D[self.var_12A9A].var_B91A);
	self method_8335(undefined);
	self setcandamage(1);
	self.var_3A9D method_80F3();
	self.var_3A9D = undefined;
	if(isdefined(self.var_222))
	{
		self.var_222.var_9D81 = 0;
		scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air",self.var_222);
	}

	self playsound("sentry_gun_plant");
	thread func_12A2A();
	self notify("placed");
}

//Function Number: 13
func_12A2B()
{
	self.var_3A9D method_80F3();
	if(isdefined(self.var_222))
	{
		self.var_222.var_9D81 = 0;
	}

	self delete();
}

//Function Number: 14
func_12A2C(param_00)
{
	self setmodel(level.var_12A8D[self.var_12A9A].var_B924);
	self setcandamage(0);
	self method_8335(param_00);
	self method_82C7(0);
	self.var_3A9D = param_00;
	param_00.var_9D81 = 1;
	param_00 thread func_12F4F(self);
	thread func_12A16(param_00);
	thread func_12A17(param_00);
	thread func_12A15(param_00);
	thread func_12A18();
	self method_82D1(-89);
	func_12A2D();
	self notify("carried");
}

//Function Number: 15
func_12F4F(param_00)
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
		var_02 = self canplayerplacesentry();
		param_00.origin = var_02["origin"];
		param_00.angles = var_02["angles"];
		param_00.var_3872 = self isonground() && var_02["result"] && abs(param_00.origin[2] - self.origin[2]) < 10;
		if(param_00.var_3872 != var_01)
		{
			if(param_00.var_3872)
			{
				param_00 setmodel(level.var_12A8D[param_00.var_12A9A].var_B924);
				self method_80F4(level.var_12A8D[param_00.var_12A9A].var_CC28);
			}
			else
			{
				param_00 setmodel(level.var_12A8D[param_00.var_12A9A].var_B925);
				self method_80F4(level.var_12A8D[param_00.var_12A9A].var_38E3);
			}
		}

		var_01 = param_00.var_3872;
		wait(0.05);
	}
}

//Function Number: 16
func_12A16(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 waittill("death");
	if(self.var_3872)
	{
		func_12A2E();
		return;
	}

	self delete();
}

//Function Number: 17
func_12A17(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 waittill("disconnect");
	self delete();
}

//Function Number: 18
func_12A15(param_00)
{
	self endon("placed");
	self endon("death");
	param_00 scripts\common\utility::waittill_any_3("joined_team","joined_spectators");
	self delete();
}

//Function Number: 19
func_12A18(param_00)
{
	self endon("placed");
	self endon("death");
	level waittill("game_ended");
	self delete();
}

//Function Number: 20
func_4A2C(param_00,param_01)
{
	var_02 = spawnturret("misc_turret",param_01.origin,level.var_12A8D[param_00].var_39B);
	var_02.angles = param_01.angles;
	var_02 setmodel(level.var_12A8D[param_00].var_B91A);
	var_02.var_222 = param_01;
	var_02.health = level.var_12A8D[param_00].health;
	var_02.maxhealth = level.var_12A8D[param_00].maxhealth;
	var_02.var_E1 = 0;
	var_02.var_12A9A = param_00;
	var_02.var_11196 = 0;
	var_02.var_11199 = 5;
	var_02 method_835B(1);
	var_02 func_12A2D();
	var_02 method_8336(param_01);
	var_02 method_835A(1,param_00);
	var_02 method_82D1(-89);
	var_02 thread func_129FC();
	var_02.var_4D49 = 1;
	var_02 thread func_12A03();
	var_02 thread func_12A50();
	return var_02;
}

//Function Number: 21
func_12A2A()
{
	self endon("death");
	self.var_222 endon("disconnect");
	self method_82D1(0);
	self makeunusable();
	self method_81F7();
	if(!isdefined(self.var_222))
	{
		return;
	}

	var_00 = self.var_222;
	if(isdefined(var_00.var_DF89))
	{
		foreach(var_02 in var_00.var_DF89)
		{
			var_02 notify("death");
		}
	}

	var_00.var_DF89 = [];
	var_00.var_DF89[0] = self;
	var_00.var_13107 = 0;
	var_00.var_CB39 = 0;
	var_00.var_6617 = 1;
	if(isalive(var_00))
	{
		var_00 scripts\mp\_utility::setlowermessage("pickup_remote_turret",level.var_12A8D[self.var_12A9A].var_901F,undefined,undefined,undefined,undefined,undefined,undefined,1);
	}

	var_00 thread func_13AE5(self);
	if(level.teambased)
	{
		self.team = var_00.team;
		self method_835E(var_00.team);
		scripts\mp\_entityheadicons::func_F877(self.team,(0,0,65));
	}
	else
	{
		scripts\mp\_entityheadicons::func_F7F2(self.var_222,(0,0,65));
	}

	self.var_C840 = spawn("trigger_radius",self.origin + (0,0,1),0,32,64);
	self.var_C840 enablelinkto();
	self.var_C840 linkto(self);
	var_00 thread func_129FD(self);
	thread func_13A1D();
	thread func_129FB();
	thread func_129FA();
	thread func_12A44();
	thread func_129CD();
}

//Function Number: 22
func_10E08()
{
	var_00 = self.var_222;
	var_00 scripts\mp\_utility::func_FB09(self.var_12A9A);
	var_00 scripts\mp\_utility::func_7385(1);
	var_01 = var_00 scripts\mp\killstreaks\_killstreaks::func_98C2();
	if(var_01 != "success")
	{
		if(var_01 != "disconnect")
		{
			var_00 scripts\mp\_utility::func_41E9();
		}

		return 0;
	}

	var_00 scripts\mp\_utility::func_12C6(level.var_12A8D[self.var_12A9A].var_DF7B);
	var_00 scripts\mp\_utility::_switchtoweaponimmediate(level.var_12A8D[self.var_12A9A].var_DF7B);
	var_00 scripts\mp\_utility::func_7385(0);
	var_00 thread func_13714(1,self);
	if(isdefined(level.var_9181["thermal_mode"]))
	{
		level.var_9181["thermal_mode"] settext("");
	}

	if(getdvarint("camera_thirdPerson"))
	{
		var_00 scripts\mp\_utility::setthirdpersondof(0);
	}

	var_00 playerlinkweaponviewtodelta(self,"tag_player",0,180,180,50,25,0);
	var_00 method_8236(0);
	var_00 method_8235(1);
	var_00 method_825A(self);
	var_00 scripts\mp\_utility::clearlowermessage("enter_remote_turret");
	var_00 scripts\mp\_utility::clearlowermessage("pickup_remote_turret");
	var_00 scripts\mp\_utility::setlowermessage("early_exit",level.var_12A8D[self.var_12A9A].var_901B,undefined,undefined,undefined,undefined,undefined,undefined,1);
}

//Function Number: 23
func_13714(param_00,param_01)
{
	self endon("disconnect");
	param_01 endon("death");
	wait(param_00);
	self visionsetthermalforplayer(game["thermal_vision"],1.5);
	self thermalvisionon();
	self thermalvisionfofoverlayon();
}

//Function Number: 24
func_1109C()
{
	var_00 = self.var_222;
	if(var_00 scripts\mp\_utility::func_9FC6())
	{
		var_00 thermalvisionoff();
		var_00 thermalvisionfofoverlayoff();
		var_00 method_825B(self);
		var_00 unlink();
		var_00 scripts\mp\_utility::_switchtoweapon(var_00 scripts\common\utility::getlastweapon());
		var_00 scripts\mp\_utility::func_41E9();
		if(getdvarint("camera_thirdPerson"))
		{
			var_00 scripts\mp\_utility::setthirdpersondof(1);
		}

		var_00 visionsetthermalforplayer(game["thermal_vision"],0);
		var_01 = scripts\mp\_utility::func_7F55(level.var_12A8D[self.var_12A9A].var_110EA);
		var_00 scripts\mp\killstreaks\_killstreaks::func_1146C(var_01);
	}

	if(self.var_11196)
	{
		var_00 stopshellshock();
	}

	var_00 scripts\mp\_utility::clearlowermessage("early_exit");
	if(!isdefined(var_00.var_13108) || !var_00.var_13108)
	{
		var_00 scripts\mp\_utility::setlowermessage("enter_remote_turret",level.var_12A8D[self.var_12A9A].var_901A,undefined,undefined,undefined,1,0.25,1.5,1);
	}

	self notify("exit");
}

//Function Number: 25
func_13AE5(param_00)
{
	self endon("disconnect");
	param_00 endon("death");
	self.var_13108 = 0;
	for(;;)
	{
		if(isalive(self))
		{
			self waittill("death");
		}

		scripts\mp\_utility::clearlowermessage("enter_remote_turret");
		scripts\mp\_utility::clearlowermessage("pickup_remote_turret");
		if(self.var_13107)
		{
			self.var_13108 = 1;
		}
		else
		{
			self.var_13108 = 0;
		}

		self waittill("spawned_player");
		if(!self.var_13108)
		{
			scripts\mp\_utility::setlowermessage("enter_remote_turret",level.var_12A8D[param_00.var_12A9A].var_901A,undefined,undefined,undefined,1,0.25,1.5,1);
			continue;
		}

		param_00 notify("death");
	}
}

//Function Number: 26
func_13A1D()
{
	self endon("death");
	self endon("carried");
	level endon("game_ended");
	var_00 = self.var_222;
	for(;;)
	{
		var_01 = var_00 getcurrentweapon();
		if(scripts\mp\_utility::func_9E6C(var_01) && var_01 != level.var_12A8D[self.var_12A9A].var_39B && var_01 != level.var_12A8D[self.var_12A9A].var_A84D && var_01 != level.var_12A8D[self.var_12A9A].var_DF7B && var_01 != "none" && !var_00 scripts\mp\_utility::func_9E59() || var_00 scripts\mp\_utility::func_9FC6())
		{
			if(!isdefined(var_00.var_6617) || !var_00.var_6617)
			{
				var_00.var_6617 = 1;
				var_00 scripts\mp\_utility::clearlowermessage("enter_remote_turret");
			}

			wait(0.05);
			continue;
		}

		if(var_00 istouching(self.var_C840))
		{
			if(!isdefined(var_00.var_6617) || !var_00.var_6617)
			{
				var_00.var_6617 = 1;
				var_00 scripts\mp\_utility::clearlowermessage("enter_remote_turret");
			}

			wait(0.05);
			continue;
		}

		if(isdefined(var_00.var_61A3) && var_00.var_61A3)
		{
			if(!isdefined(var_00.var_6617) || !var_00.var_6617)
			{
				var_00.var_6617 = 1;
				var_00 scripts\mp\_utility::clearlowermessage("enter_remote_turret");
			}

			wait(0.05);
			continue;
		}

		if(var_00 islinked() && !var_00.var_13107)
		{
			if(!isdefined(var_00.var_6617) || !var_00.var_6617)
			{
				var_00.var_6617 = 1;
				var_00 scripts\mp\_utility::clearlowermessage("enter_remote_turret");
			}

			wait(0.05);
			continue;
		}

		if(isdefined(var_00.var_6617) && var_00.var_6617 && var_01 != "none")
		{
			var_00 scripts\mp\_utility::setlowermessage("enter_remote_turret",level.var_12A8D[self.var_12A9A].var_901A,undefined,undefined,undefined,1,0.25,1.5,1);
			var_00.var_6617 = 0;
		}

		var_02 = 0;
		while(var_00 usebuttonpressed() && !var_00 fragbuttonpressed() && !var_00 scripts\mp\_utility::func_85C7() && !var_00 secondaryoffhandbuttonpressed() && !var_00 isusingturret() && var_00 isonground() && !var_00 istouching(self.var_C840) && !isdefined(var_00.var_61A3) || !var_00.var_61A3)
		{
			if(isdefined(var_00.var_9D81) && var_00.var_9D81)
			{
				break;
			}

			if(isdefined(var_00.var_9D7F) && var_00.var_9D7F)
			{
				break;
			}

			if(!isalive(var_00))
			{
				break;
			}

			if(!var_00.var_13107 && var_00 scripts\mp\_utility::func_9FC6())
			{
				break;
			}

			if(var_00 islinked() && !var_00.var_13107)
			{
				break;
			}

			var_02 = var_02 + 0.05;
			if(var_02 > 0.75)
			{
				var_00.var_13107 = !var_00.var_13107;
				if(var_00.var_13107)
				{
					var_00 func_E18E();
					var_00 func_1146D(self.var_12A9A);
					var_00 scripts\mp\_utility::func_12C6(level.var_12A8D[self.var_12A9A].var_A84D);
					var_00 scripts\mp\_utility::_switchtoweaponimmediate(level.var_12A8D[self.var_12A9A].var_A84D);
					func_10E08();
					var_00 func_E2E8();
				}
				else
				{
					var_00 func_1146D(self.var_12A9A);
					func_1109C();
				}

				wait(2);
				break;
			}

			wait(0.05);
		}

		wait(0.05);
	}
}

//Function Number: 27
func_129FD(param_00)
{
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("death");
	if(!isdefined(param_00.var_C840))
	{
		return;
	}

	if(isdefined(self.pers["isBot"]) && self.pers["isBot"])
	{
		return;
	}

	var_01 = 0;
	for(;;)
	{
		var_02 = self getcurrentweapon();
		if(scripts\mp\_utility::func_9E6C(var_02) && var_02 != "killstreak_remote_turret_mp" && var_02 != level.var_12A8D[param_00.var_12A9A].var_39B && var_02 != level.var_12A8D[param_00.var_12A9A].var_A84D && var_02 != level.var_12A8D[param_00.var_12A9A].var_DF7B && var_02 != "none" && !scripts\mp\_utility::func_9E59() || scripts\mp\_utility::func_9FC6())
		{
			if(!isdefined(self.var_CB39) || !self.var_CB39)
			{
				self.var_CB39 = 1;
				scripts\mp\_utility::clearlowermessage("pickup_remote_turret");
			}

			wait(0.05);
			continue;
		}

		if(!self istouching(param_00.var_C840))
		{
			if(!isdefined(self.var_CB39) || !self.var_CB39)
			{
				self.var_CB39 = 1;
				scripts\mp\_utility::clearlowermessage("pickup_remote_turret");
			}

			wait(0.05);
			continue;
		}

		if(scripts\mp\_utility::func_9F19(self) && self istouching(param_00.var_C840) && !isdefined(param_00.var_3A9D) && self isonground())
		{
			if(isdefined(self.var_CB39) && self.var_CB39 && var_02 != "none")
			{
				scripts\mp\_utility::setlowermessage("pickup_remote_turret",level.var_12A8D[param_00.var_12A9A].var_901F,undefined,undefined,undefined,undefined,undefined,undefined,1);
				self.var_CB39 = 0;
			}

			if(self usebuttonpressed())
			{
				if(isdefined(self.var_13107) && self.var_13107)
				{
					continue;
				}

				var_01 = 0;
				while(self usebuttonpressed())
				{
					var_01 = var_01 + 0.05;
					wait(0.05);
				}

				if(var_01 >= 0.5)
				{
					continue;
				}

				var_01 = 0;
				while(!self usebuttonpressed() && var_01 < 0.5)
				{
					var_01 = var_01 + 0.05;
					wait(0.05);
				}

				if(var_01 >= 0.5)
				{
					continue;
				}

				if(!scripts\mp\_utility::func_9F19(self))
				{
					continue;
				}

				if(isdefined(self.var_13107) && self.var_13107)
				{
					continue;
				}

				param_00 method_830F(level.var_12A8D[param_00.var_12A9A].var_F268);
				thread func_F68B(param_00,0);
				param_00.var_C840 delete();
				self.var_DF89 = undefined;
				scripts\mp\_utility::clearlowermessage("pickup_remote_turret");
				return;
			}
		}

		wait(0.05);
	}
}

//Function Number: 28
func_129CD()
{
	self endon("death");
	self endon("carried");
	for(;;)
	{
		playfxontag(scripts\common\utility::getfx("antenna_light_mp"),self,"tag_fx");
		wait(1);
		stopfxontag(scripts\common\utility::getfx("antenna_light_mp"),self,"tag_fx");
	}
}

//Function Number: 29
func_12A2D()
{
	self method_830F(level.var_12A8D[self.var_12A9A].var_F268);
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
	if(isdefined(var_00.var_13107) && var_00.var_13107)
	{
		var_00 thermalvisionoff();
		var_00 thermalvisionfofoverlayoff();
		var_00 method_825B(self);
		var_00 unlink();
		var_00 scripts\mp\_utility::_switchtoweapon(var_00 scripts\common\utility::getlastweapon());
		var_00 scripts\mp\_utility::func_41E9();
		if(getdvarint("camera_thirdPerson"))
		{
			var_00 scripts\mp\_utility::setthirdpersondof(1);
		}

		var_00 scripts\mp\killstreaks\_killstreaks::func_41D6();
		var_00 visionsetthermalforplayer(game["thermal_vision"],0);
		if(isdefined(var_00.var_55E4) && var_00.var_55E4)
		{
			var_00 scripts\common\utility::func_1C6E(1);
		}

		var_00 func_1146D(self.var_12A9A);
	}
}

//Function Number: 30
func_129FC()
{
	self endon("death");
	level endon("game_ended");
	self notify("turret_handleOwner");
	self endon("turret_handleOwner");
	self.var_222 scripts\common\utility::waittill_any_3("disconnect","joined_team","joined_spectators");
	self notify("death");
}

//Function Number: 31
func_12A44()
{
	self endon("death");
	level endon("game_ended");
	var_00 = level.var_12A8D[self.var_12A9A].var_11901;
	while(var_00)
	{
		wait(1);
		scripts\mp\_hostmigration::func_13834();
		if(!isdefined(self.var_3A9D))
		{
			var_00 = max(0,var_00 - 1);
		}
	}

	if(isdefined(self.var_222))
	{
		self.var_222 thread scripts\mp\_utility::func_AAEC("sentry_gone");
	}

	self notify("death");
}

//Function Number: 32
func_129FB()
{
	self endon("carried");
	var_00 = self getentitynumber();
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	self setmodel(level.var_12A8D[self.var_12A9A].var_B91D);
	func_12A2D();
	self method_82D1(40);
	self method_8336(undefined);
	self method_835A(0);
	if(isdefined(self.var_C840))
	{
		self.var_C840 delete();
	}

	var_01 = self.var_222;
	if(isdefined(var_01))
	{
		var_01.var_13107 = 0;
		var_01 scripts\mp\_utility::clearlowermessage("enter_remote_turret");
		var_01 scripts\mp\_utility::clearlowermessage("early_exit");
		var_01 scripts\mp\_utility::clearlowermessage("pickup_remote_turret");
		var_01 func_E2E0();
		var_01 func_E2E8();
		if(var_01 getcurrentweapon() == "none")
		{
			var_01 scripts\mp\_utility::_switchtoweapon(var_01 scripts\common\utility::getlastweapon());
		}

		if(self.var_11196)
		{
			var_01 stopshellshock();
		}
	}

	self playsound("sentry_explode");
	playfxontag(scripts\common\utility::getfx("sentry_explode_mp"),self,"tag_aim");
	wait(1.5);
	self playsound("sentry_explode_smoke");
	var_02 = 8;
	while(var_02 > 0)
	{
		playfxontag(scripts\common\utility::getfx("sentry_smoke_mp"),self,"tag_aim");
		wait(0.4);
		var_02 = var_02 - 0.4;
	}

	self notify("deleting");
	if(isdefined(self.var_11512))
	{
		self.var_11512 delete();
	}

	self delete();
}

//Function Number: 33
func_129FA()
{
	self endon("death");
	self endon("carried");
	self setcandamage(1);
	for(;;)
	{
		self waittill("damage",var_00,var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09);
		if(!scripts\mp\_weapons::func_7415(self.var_222,var_01))
		{
			continue;
		}

		if(isdefined(var_09))
		{
			switch(var_09)
			{
				case "sensor_grenade_mp":
				case "flash_grenade_mp":
				case "concussion_grenade_mp":
					if(var_04 == "MOD_GRENADE_SPLASH" && self.var_222.var_13107)
					{
						self.var_11196 = 1;
						thread func_12A35();
					}
		
					break;
	
				case "smoke_grenadejugg_mp":
				case "smoke_grenade_mp":
					break;
			}
		}

		if(!isdefined(self))
		{
			return;
		}

		if(var_04 == "MOD_MELEE")
		{
			self.var_E1 = self.var_E1 + self.maxhealth;
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
		self.var_4D49 = 0;
		var_0A = var_00;
		if(isplayer(var_01))
		{
			var_01 scripts\mp\_damagefeedback::func_12E84("remote_turret");
			if(var_01 scripts\mp\_utility::_hasperk("specialty_armorpiercing"))
			{
				var_0A = var_00 * level.var_218B;
			}
		}

		if(isdefined(var_01.var_222) && isplayer(var_01.var_222))
		{
			var_01.var_222 scripts\mp\_damagefeedback::func_12E84("remote_turret");
		}

		if(isdefined(var_09))
		{
			switch(var_09)
			{
				case "remotemissile_projectile_mp":
				case "javelin_mp":
				case "remote_mortar_missile_mp":
				case "stinger_mp":
				case "ac130_40mm_mp":
				case "ac130_105mm_mp":
					self.var_A859 = 1;
					var_0A = self.maxhealth + 1;
					break;
	
				case "stealth_bomb_mp":
				case "artillery_mp":
					self.var_A859 = 0;
					var_0A = var_0A + var_00 * 4;
					break;
	
				case "emp_grenade_mp":
				case "bomb_site_mp":
					self.var_A859 = 0;
					var_0A = self.maxhealth + 1;
					break;
			}

			scripts\mp\killstreaks\_killstreaks::func_A6A0(var_01,var_09,self,var_04);
		}

		self.var_E1 = self.var_E1 + var_0A;
		if(self.var_E1 >= self.maxhealth)
		{
			if(isplayer(var_01) && !isdefined(self.var_222) || var_01 != self.var_222)
			{
				var_01 thread scripts\mp\_utility::func_83B4("kill",var_09,100);
				var_01 notify("destroyed_killstreak");
			}

			if(isdefined(self.var_222))
			{
				self.var_222 thread scripts\mp\_utility::func_AAEC(level.var_12A8D[self.var_12A9A].var_13523,undefined,undefined,self.origin);
			}

			self notify("death");
			return;
		}
	}
}

//Function Number: 34
func_12A03()
{
	self endon("death");
	level endon("game_ended");
	var_00 = 0;
	for(;;)
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

		wait(0.1);
	}
}

//Function Number: 35
func_12A50()
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

//Function Number: 36
func_12A35()
{
	self notify("stunned");
	self endon("stunned");
	self endon("death");
	while(self.var_11196)
	{
		self.var_222 shellshock("concussion_grenade_mp",self.var_11199);
		playfxontag(scripts\common\utility::getfx("sentry_explode_mp"),self,"tag_origin");
		var_00 = 0;
		while(var_00 < self.var_11199)
		{
			var_00 = var_00 + 0.05;
			wait(0.05);
		}

		self.var_11196 = 0;
	}
}