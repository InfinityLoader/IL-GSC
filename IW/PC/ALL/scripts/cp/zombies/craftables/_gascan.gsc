/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\craftables\_gascan.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 26
 * Decompile Time: 939 ms
 * Timestamp: 10/27/2023 12:23:40 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["candypile_fire"] = loadfx("vfx/iw7/_requests/coop/zmb_candypile_fire.vfx");
	level._effect["candypile_idle"] = loadfx("vfx/iw7/_requests/coop/zmb_candypile_idle.vfx");
	level.var_47AF = [];
	level.var_47AF["crafted_gascan"] = spawnstruct();
	level.var_47AF["crafted_gascan"].var_11901 = 180;
	level.var_47AF["crafted_gascan"].var_B91A = "zmb_candybox_crafted_lod0";
	level.var_47AF["crafted_gascan"].var_B924 = "zmb_candybox_crafted_lod0";
	level.var_47AF["crafted_gascan"].var_B925 = "zmb_candybox_crafted_lod0";
	level.var_47AF["crafted_gascan"].var_CC12 = "zmb_candybox_crafted_lod0";
}

//Function Number: 2
func_82B6(param_00,param_01)
{
	param_01 thread func_13932();
	param_01 notify("new_power","crafted_gascan");
	param_01 setclientomnvar("zom_crafted_weapon",7);
	param_01 thread scripts\cp\_utility::func_1308C(param_01,"iw7_pickup_zm");
	scripts\cp\_utility::func_F313("crafted_gascan",::func_82B6,param_01);
}

//Function Number: 3
func_13932()
{
	self endon("disconnect");
	self notify("craft_dpad_watcher");
	self endon("craft_dpad_watcher");
	self endon("death");
	self notifyonplayercommand("pullout_gascan","+actionslot 3");
	for(;;)
	{
		self waittill("pullout_gascan");
		if(scripts\common\utility::istrue(self.var_9D81))
		{
			continue;
		}

		if(scripts\common\utility::istrue(self.var_AD2C))
		{
			continue;
		}

		if(isdefined(self.allow_carry) && self.allow_carry == 0)
		{
			continue;
		}

		if(scripts\cp\_utility::is_valid_player())
		{
			break;
		}
	}

	thread func_82D1(1);
}

//Function Number: 4
func_82D1(param_00,param_01)
{
	self endon("disconnect");
	scripts\cp\_utility::clearlowermessage("msg_power_hint");
	var_02 = func_49CD(self);
	self.var_A039 = var_02.name;
	func_E152();
	self.var_3AA5 = var_02;
	var_03 = func_F683(var_02,param_00,param_01);
	self.var_3AA5 = undefined;
	thread func_1370F();
	self.var_9D81 = 0;
	if(isdefined(var_02))
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
func_F683(param_00,param_01,param_02)
{
	self endon("disconnect");
	param_00 func_76CA(self,param_01);
	scripts\common\utility::allow_weapon(0);
	self notifyonplayercommand("place_gascan","+attack");
	self notifyonplayercommand("place_gascan","+attack_akimbo_accessible");
	self notifyonplayercommand("cancel_gascan","+actionslot 3");
	if(!level.console)
	{
		self notifyonplayercommand("cancel_gascan","+actionslot 5");
		self notifyonplayercommand("cancel_gascan","+actionslot 6");
		self notifyonplayercommand("cancel_gascan","+actionslot 7");
	}

	for(;;)
	{
		var_03 = scripts\common\utility::func_13734("place_gascan","cancel_gascan","force_cancel_placement");
		if(!isdefined(param_00))
		{
			scripts\common\utility::allow_weapon(1);
			return 1;
		}

		if(!isdefined(var_03))
		{
			var_03 = "force_cancel_placement";
		}

		if(var_03 == "cancel_gascan" || var_03 == "force_cancel_placement")
		{
			if(!param_01 && var_03 == "cancel_gascan")
			{
				continue;
			}

			scripts\common\utility::allow_weapon(1);
			param_00 func_76C9();
			if(var_03 != "force_cancel_placement")
			{
				thread func_13932();
			}
			else if(param_01)
			{
				scripts\cp\_utility::func_DFE0(self);
			}

			return 0;
		}

		if(!param_00.var_3872)
		{
			continue;
		}

		if(param_01)
		{
			scripts\cp\_utility::func_DFE0(self);
		}

		param_00 thread func_76C8(param_02,self);
		self waittill("gas_poured");
		scripts\common\utility::allow_weapon(1);
		return 1;
	}
}

//Function Number: 6
func_E18E()
{
	if(self.var_8C1E)
	{
		var_00 = scripts\cp\_utility::func_E55C();
		self.var_E2E6 = var_00;
		self.var_E556 = self method_80FB(var_00);
		self takeweapon(var_00);
	}
}

//Function Number: 7
func_E152()
{
	if(scripts\cp\_utility::_hasperk("specialty_explosivebullets"))
	{
		self.var_E2DF = "specialty_explosivebullets";
		scripts\cp\_utility::func_1430("specialty_explosivebullets");
	}
}

//Function Number: 8
func_E2E8()
{
	if(isdefined(self.var_E2E6))
	{
		scripts\cp\_utility::func_12C6(self.var_E2E6);
		if(self.var_8C1E)
		{
			var_00 = scripts\cp\_utility::func_E55C();
			self setweaponammoclip(var_00,self.var_E556);
		}
	}

	self.var_E2E6 = undefined;
}

//Function Number: 9
func_E2E0()
{
	if(isdefined(self.var_E2DF))
	{
		scripts\cp\_utility::func_8387(self.var_E2DF);
		self.var_E2DF = undefined;
	}
}

//Function Number: 10
func_1370F()
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	wait(0.05);
	func_E2E0();
}

//Function Number: 11
func_49CD(param_00)
{
	var_01 = spawnturret("misc_turret",param_00.origin + (0,0,25),"sentry_minigun_mp");
	var_01.angles = param_00.angles;
	var_01.var_222 = param_00;
	var_01.name = "crafted_gascan";
	var_01.var_3A9E = spawn("script_model",var_01.origin);
	var_01.var_3A9E.angles = param_00.angles;
	var_01 method_81F5();
	var_01 method_835B(1);
	var_01 method_830F("sentry_offline");
	var_01 makeunusable();
	var_01 method_8336(param_00);
	var_01 func_76C7(param_00);
	var_01 method_82C7(0);
	var_01.var_3A9E method_82C7(0);
	return var_01;
}

//Function Number: 12
func_76C7(param_00)
{
	self.var_3872 = 1;
}

//Function Number: 13
func_76C8(param_00,param_01)
{
	param_01 endon("disconnect");
	self.var_9F05 = 1;
	if(!isdefined(level.var_38B3))
	{
		level.var_38B3 = [];
	}

	for(;;)
	{
		for(var_02 = 0;param_01 attackbuttonpressed() && var_02 <= 4;var_02++)
		{
			if(!self.var_3872)
			{
				wait(0.05);
				continue;
			}

			if(!isdefined(self.var_8C16))
			{
				self.var_8C16 = 0;
			}

			param_01 playsound("trap_kindle_pops_pour");
			self.var_9F05 = 1;
			func_1070D(param_01,self);
			self.var_8C16++;
			self.var_BE9C = 1;
			wait(0.35);
		}

		if(var_02 > 4)
		{
			break;
		}

		self.var_9F05 = undefined;
		wait(0.05);
	}

	self.var_9F05 = undefined;
	param_01 notify("gas_poured");
	var_03 = spawn("script_model",self.var_3A9E.origin);
	var_03.angles = self.var_3A9E.angles;
	var_03 setmodel(level.var_47AF["crafted_gascan"].var_CC12);
	var_03 physicslaunchserver(var_03.origin + (randomfloatrange(-20,20),randomfloatrange(-20,20),0),(randomfloatrange(-20,20),randomfloatrange(-20,20),10));
	var_03 playsound("trap_kindle_pops_can_drop");
	self.var_3A9D method_80F3();
	self.var_3A9D = undefined;
	param_01.var_9D81 = 0;
	self notify("placed");
	self.var_3A9E delete();
	self delete();
	wait(1);
	param_01 scripts\cp\_utility::setlowermessage("candy_hint",&"ZOMBIE_CRAFTING_SOUVENIRS_SHOOT_TO_IGNITE",4);
	wait(15);
	var_03 delete();
}

//Function Number: 14
func_135B5(param_00)
{
	thread func_92DF();
	thread func_76C2();
	thread func_76C3(level.var_47AF["crafted_gascan"].var_11901);
	self waittill("gas_spot_damaged");
	self playsound("trap_kindle_pops_ignite");
	var_01 = gettime() + -25536;
	self notify("damage_monitor");
	thread func_76C0(var_01,param_00);
}

//Function Number: 15
func_92DF()
{
	self endon("gas_spot_damaged");
	self.var_7542 = spawnfx(level._effect["candypile_idle"],self.origin);
	scripts\common\utility::func_136F7();
	triggerfx(self.var_7542);
}

//Function Number: 16
func_76C3(param_00)
{
	self endon("gas_spot_damaged");
	wait(param_00);
	self notify("damage_monitor");
	level.var_38B3 = scripts\common\utility::func_22A9(level.var_38B3,self);
	self.var_7542 delete();
	scripts\cp\_utility::func_E11E();
	self delete();
}

//Function Number: 17
func_76C2()
{
	self endon("damage_monitor");
	var_00 = 9216;
	for(;;)
	{
		self waittill("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
		if(isplayer(var_02) && isdefined(var_0A) && var_05 != "MOD_MELEE")
		{
			self notify("gas_spot_damaged");
			foreach(var_0C in level.var_38B3)
			{
				if(var_0C == self)
				{
					continue;
				}

				if(distancesquared(var_0C.origin,self.origin) > var_00)
				{
					continue;
				}
				else
				{
					var_0C notify("damage",var_01,var_02,var_03,var_04,var_05,var_06,var_07,var_08,var_09,var_0A);
				}
			}

			return;
		}
	}
}

//Function Number: 18
func_76C0(param_00,param_01)
{
	self.var_7542 delete();
	scripts\common\utility::func_136F7();
	self playloopsound("trap_kindle_pops_fire_lp");
	self.var_7542 = spawnfx(level._effect["candypile_fire"],self.origin);
	scripts\common\utility::func_136F7();
	triggerfx(self.var_7542);
	self.var_4D27 = spawn("trigger_radius",self.origin,1,64,32);
	self.var_4D27.var_336 = "kindlepops_trig";
	self.var_4D27.var_222 = param_01;
	thread func_76C1();
	while(gettime() < param_00)
	{
		wait(0.1);
	}

	playsoundatpos(self.origin,"trap_kindle_pops_fire_end");
	self stoploopsound();
	self.var_4D27 delete();
	self.var_7542 delete();
	level.var_38B3 = scripts\common\utility::func_22A9(level.var_38B3,self);
	self delete();
}

//Function Number: 19
func_76C1()
{
	self.var_4D27 endon("death");
	for(;;)
	{
		self.var_4D27 waittill("trigger",var_00);
		if(isplayer(var_00) && isalive(var_00) && !scripts\cp\_laststand::player_in_laststand(var_00) && !isdefined(var_00.var_C85F))
		{
			var_00.var_C85F = 1;
			var_00 dodamage(15,var_00.origin);
			var_00 thread func_E069();
		}

		if(!scripts\cp\_utility::func_FF18(var_00))
		{
			continue;
		}

		var_00 func_3B25(2,var_00.health + 5,self.var_4D27);
	}
}

//Function Number: 20
func_E069()
{
	self endon("disconnect");
	wait(0.5);
	self.var_C85F = undefined;
}

//Function Number: 21
func_3B25(param_00,param_01,param_02)
{
	if(isalive(self) && !scripts\common\utility::istrue(self.var_B36E) && !scripts\common\utility::istrue(self.var_9B8A))
	{
		thread scripts\cp\_utility::func_4D0D(self,param_02,param_00,param_01,undefined,"iw7_kindlepops_zm",undefined,"chemBurn");
	}
}

//Function Number: 22
func_1070D(param_00,param_01)
{
	var_02 = ["zmb_candy_pile_01","zmb_candy_pile_02"];
	var_03 = spawn("script_model",param_01.origin + (0,0,5));
	var_03.angles = self.angles;
	var_03 setmodel(scripts\common\utility::random(var_02));
	var_04 = 100;
	var_05 = getgroundposition(param_01.origin,4);
	var_03 moveto(var_05 + (0,0,1),0.25);
	foreach(var_07 in level.var_38B3)
	{
		if(distancesquared(var_07.origin,var_03.origin) < 100)
		{
			var_03 delete();
			break;
		}
	}

	if(!isdefined(var_03))
	{
		return;
	}

	var_03 setcandamage(1);
	var_03.health = 10000;
	var_03.var_222 = param_00;
	var_03.name = "crafted_gascan";
	param_00.var_A039 = var_03.name;
	level.var_38B3[level.var_38B3.size] = var_03;
	var_03 scripts\cp\_utility::func_1861();
	var_03 thread func_135B5(param_00);
}

//Function Number: 23
func_76C9()
{
	self.var_3A9D method_80F3();
	if(isdefined(self.var_222))
	{
		self.var_222.var_9D81 = 0;
	}

	self.var_3A9E delete();
	self delete();
}

//Function Number: 24
func_76CA(param_00,param_01)
{
	if(isdefined(self.var_C731))
	{
	}
	else
	{
	}

	self setmodel(level.var_47AF["crafted_gascan"].var_B924);
	self hide();
	self method_8335(param_00);
	self setcandamage(0);
	self.var_3A9D = param_00;
	param_00.var_9D81 = 1;
	param_00 thread func_12EA0(self,param_01);
	thread scripts\cp\_utility::func_A025(param_00);
	thread scripts\cp\_utility::func_A026(param_00);
	thread scripts\cp\_utility::func_A027(param_00);
	self notify("carried");
}

//Function Number: 25
func_12EA0(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	param_00 endon("placed");
	param_00 endon("death");
	param_00.var_3872 = 1;
	var_02 = -1;
	param_00.var_BE9C = 0;
	for(;;)
	{
		param_00.var_3872 = func_3831(param_00);
		if(param_00.var_3872 != var_02 || param_00.var_BE9C)
		{
			param_00.var_BE9C = 0;
			if(param_00.var_3872)
			{
				param_00.var_3A9E setmodel(level.var_47AF["crafted_gascan"].var_B924);
				if(!isdefined(param_00.var_8C16))
				{
					self method_80F4(&"ZOMBIE_CRAFTING_SOUVENIRS_POUR_CANCELABLE");
				}
				else if(param_00.var_8C16 == 1)
				{
					self method_80F4(&"ZOMBIE_CRAFTING_SOUVENIRS_POUR_80");
				}
				else if(param_00.var_8C16 == 2)
				{
					self method_80F4(&"ZOMBIE_CRAFTING_SOUVENIRS_POUR_60");
				}
				else if(param_00.var_8C16 == 3)
				{
					self method_80F4(&"ZOMBIE_CRAFTING_SOUVENIRS_POUR_40");
				}
				else if(param_00.var_8C16 == 4)
				{
					self method_80F4(&"ZOMBIE_CRAFTING_SOUVENIRS_POUR_20");
				}
			}
			else
			{
				param_00.var_3A9E setmodel(level.var_47AF["crafted_gascan"].var_B925);
				self method_80F4(&"COOP_CRAFTABLES_CANNOT_PLACE");
			}
		}

		var_02 = param_00.var_3872;
		wait(0.05);
	}
}

//Function Number: 26
func_3831(param_00)
{
	var_01 = self canplayerplacesentry();
	param_00.origin = var_01["origin"];
	param_00.angles = var_01["angles"];
	param_00.var_3A9E.origin = var_01["origin"] + (0,0,35);
	param_00.name = "crafted_gascan";
	param_00.var_3A9E.name = "crafted_gascan";
	if(isdefined(param_00.var_9F05))
	{
		param_00.var_3A9E.angles = var_01["angles"] + (35,0,0);
	}
	else
	{
		param_00.var_3A9E.angles = var_01["angles"];
	}

	return self isonground() && var_01["result"] && abs(var_01["origin"][2] - self.origin[2]) < 30;
}