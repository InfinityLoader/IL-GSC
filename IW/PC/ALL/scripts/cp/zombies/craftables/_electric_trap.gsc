/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\craftables\_electric_trap.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 702 ms
 * Timestamp: 10/27/2023 12:23:37 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["electric_trap_idle"] = loadfx("vfx/iw7/_requests/coop/generator_idle.vfx");
	level._effect["electric_trap_attack"] = loadfx("vfx/iw7/core/zombie/vfx_electrap_shock_beam.vfx");
	level._effect["electric_trap_shock"] = loadfx("vfx/iw7/core/zombie/traps/electric_trap/vfx_zmb_hit_shock.vfx");
	var_00 = spawnstruct();
	var_00.var_11901 = 60;
	var_00.var_B91A = "zom_machinery_generator_portable_01";
	var_00.var_B924 = "zom_machinery_generator_portable_01";
	var_00.var_B925 = "zom_machinery_generator_portable_01_red";
	var_00.var_17B = &"COOP_CRAFTABLES_PICKUP";
	var_00.var_9F43 = 0;
	var_00.var_17B = &"COOP_CRAFTABLES_PICKUP";
	var_00.var_CC28 = &"COOP_CRAFTABLES_PLACE";
	var_00.var_38E3 = &"COOP_CRAFTABLES_CANNOT_PLACE";
	var_00.var_CC0A = &"COOP_CRAFTABLES_PLACE_CANCELABLE";
	var_00.var_CC22 = 30;
	var_00.var_CC25 = 32;
	var_00.var_3AA7 = (0,0,25);
	var_00.var_3AA6 = (0,0,0);
	if(!isdefined(level.var_47B3))
	{
		level.var_47B3 = [];
	}

	level.var_47B3["crafted_electric_trap"] = var_00;
}

//Function Number: 2
func_82BB(param_00,param_01)
{
	param_01 thread func_13932();
	param_01 notify("new_power","crafted_electric_trap");
	param_01 setclientomnvar("zom_crafted_weapon",4);
	param_01 thread scripts\cp\_utility::func_1308C(param_01,"iw7_pickup_zm");
	scripts\cp\_utility::func_F313("crafted_electric_trap",::func_82BB,param_01);
}

//Function Number: 3
func_13932()
{
	self endon("disconnect");
	self endon("death");
	self notify("craft_dpad_watcher");
	self endon("craft_dpad_watcher");
	self notifyonplayercommand("pullout_trap","+actionslot 3");
	for(;;)
	{
		self waittill("pullout_trap");
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

	thread func_8342(1);
}

//Function Number: 4
func_8342(param_00,param_01)
{
	self endon("disconnect");
	scripts\cp\_utility::clearlowermessage("msg_power_hint");
	var_02 = func_4A2A(self);
	self.var_A039 = var_02.name;
	func_E152();
	self.var_3AA5 = var_02;
	if(param_00)
	{
		var_02.var_6DEC = 1;
	}

	var_03 = func_F68A(var_02,param_00,param_01);
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
func_F68A(param_00,param_01,param_02)
{
	self endon("disconnect");
	param_00 func_126A8(self,param_01);
	scripts\common\utility::allow_weapon(0);
	self notifyonplayercommand("place_trap","+attack");
	self notifyonplayercommand("place_trap","+attack_akimbo_accessible");
	self notifyonplayercommand("cancel_trap","+actionslot 3");
	if(!level.console)
	{
		self notifyonplayercommand("cancel_trap","+actionslot 5");
		self notifyonplayercommand("cancel_trap","+actionslot 6");
		self notifyonplayercommand("cancel_trap","+actionslot 7");
	}

	for(;;)
	{
		var_03 = scripts\common\utility::func_13734("place_trap","cancel_trap","force_cancel_placement");
		if(!isdefined(param_00))
		{
			scripts\common\utility::allow_weapon(1);
			return 1;
		}

		if(!isdefined(var_03))
		{
			var_03 = "force_cancel_placement";
		}

		if(var_03 == "cancel_trap" || var_03 == "force_cancel_placement")
		{
			if(!param_01 && var_03 == "cancel_trap")
			{
				continue;
			}

			scripts\common\utility::allow_weapon(1);
			param_00 func_126A7();
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

		param_00 func_126AA(param_02,self);
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
func_4A2A(param_00)
{
	var_01 = spawnturret("misc_turret",param_00.origin + (0,0,40),"sentry_minigun_mp");
	var_01.angles = param_00.angles;
	var_01.var_222 = param_00;
	var_01.name = "crafted_electric_trap";
	var_01.var_3A9B = spawn("script_model",var_01.origin);
	var_01.var_3A9B.angles = param_00.angles;
	var_01 method_81F5();
	var_01 method_835B(1);
	var_01 method_830F("sentry_offline");
	var_01 makeunusable();
	var_01 method_8336(param_00);
	var_01 func_126A2(param_00);
	return var_01;
}

//Function Number: 12
func_126A2(param_00)
{
	self.var_3872 = 1;
}

//Function Number: 13
func_126A0(param_00)
{
	self waittill("death");
	if(!isdefined(self))
	{
		return;
	}

	func_126A9();
	self playsound("sentry_explode");
	scripts\cp\_utility::func_E11E();
	if(isdefined(self))
	{
		playfxontag(scripts\common\utility::getfx("sentry_explode_mp"),self,"tag_origin");
		self playsound("sentry_explode_smoke");
		wait(0.1);
		if(isdefined(self))
		{
			if(isdefined(self.var_3A9B))
			{
				self.var_3A9B delete();
			}

			self delete();
		}
	}
}

//Function Number: 14
func_126A1()
{
	self endon("death");
	level endon("game_ended");
	for(;;)
	{
		self waittill("trigger",var_00);
		if(!var_00 scripts\cp\_utility::is_valid_player())
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_00.var_9D81))
		{
			continue;
		}

		var_00 thread func_8342(0,self.var_AC71);
		if(isdefined(self.var_3CBF))
		{
			self.var_3CBF delete();
		}

		scripts\cp\_utility::func_E11E();
		self delete();
	}
}

//Function Number: 15
func_126AA(param_00,param_01)
{
	var_02 = spawn("script_model",self.origin + (0,0,1.5));
	var_02.angles = self.angles;
	var_02 solid();
	var_02 setmodel(level.var_47B3["crafted_electric_trap"].var_B91A);
	self.var_3A9D method_80F3();
	self.var_3A9D = undefined;
	param_01.var_9D81 = 0;
	var_02.var_222 = param_01;
	var_02.name = "crafted_electric_trap";
	var_02 thread func_126A6(param_00);
	var_02 playsound("sentry_gun_plant");
	self notify("placed");
	self.var_3A9B delete();
	self delete();
}

//Function Number: 16
func_126A7()
{
	self.var_3A9D method_80F3();
	if(isdefined(self.var_222))
	{
		self.var_222.var_9D81 = 0;
	}

	self.var_3A9B delete();
	self delete();
}

//Function Number: 17
func_126A8(param_00,param_01)
{
	self method_8335(param_00);
	self setcandamage(0);
	self stoploopsound();
	self.var_3A9D = param_00;
	param_00.var_9D81 = 1;
	param_00 thread scripts\cp\_utility::func_12E3F(self,self.var_3A9B,level.var_47B3["crafted_electric_trap"]);
	thread scripts\cp\_utility::func_A025(param_00);
	thread scripts\cp\_utility::func_A026(param_00);
	thread scripts\cp\_utility::func_A027(param_00);
	func_126A9();
	self notify("carried");
}

//Function Number: 18
func_126A6(param_00)
{
	self setscriptablepartstate("fx","on");
	self setcursorhint("HINT_NOICON");
	self sethintstring(level.var_47B3["crafted_electric_trap"].var_17B);
	self makeusable();
	self method_84A7("tag_fx");
	self method_84A5(120);
	self method_84A2(96);
	thread func_126A0(self.var_222);
	thread scripts\cp\_utility::func_A021("electrap_handleOwner");
	thread scripts\cp\_utility::func_A030(param_00,level.var_47B3["crafted_electric_trap"].var_11901);
	thread func_126A1();
	thread func_126AF();
	scripts\cp\_utility::func_1861();
}

//Function Number: 19
func_126A9()
{
	self makeunusable();
	scripts\cp\_utility::func_E11E();
}

//Function Number: 20
func_126AF()
{
	self endon("death");
	var_00 = -28672;
	wait(1);
	for(;;)
	{
		var_01 = scripts\cp\_agent_utils::func_7DAF();
		var_01 = scripts\common\utility::func_782F(self.origin,var_01);
		foreach(var_03 in var_01)
		{
			if(!scripts\cp\_utility::func_FF18(var_03,undefined,1) || scripts\common\utility::istrue(var_03.var_9BC9))
			{
				continue;
			}

			if(distancesquared(self.origin + (0,0,20),var_03.origin + (0,0,20)) < var_00)
			{
				self playsound("trap_electric_shock");
				thread func_601A(var_03);
				if(scripts\common\utility::istrue(var_03.var_565C))
				{
					var_03 thread scripts\cp\_utility::func_4D0D(var_03,self,1,var_03.health + 10,"MOD_RIFLE_BULLET","zmb_imsprojectile_mp",undefined,"electrified");
				}
				else
				{
					var_03 thread scripts\cp\_utility::func_4D0D(var_03,self,3,var_03.health + 10,"MOD_RIFLE_BULLET","zmb_imsprojectile_mp",undefined,"electrified");
				}

				wait(1.5);
			}
		}

		wait(0.1);
	}
}

//Function Number: 21
func_601A(param_00)
{
	param_00 endon("death");
	self endon("death");
	var_01 = ["J_Shoulder_LE","J_Shoulder_RI","J_Wrist_LE","J_Wrist_RI","J_Elbow_RI","J_Elbow_LE"];
	var_02 = ["J_Hip_RI","J_Hip_LE","J_Knee_LE","J_Ankle_LE","J_Knee_RI","J_Ankle_RI"];
	var_03 = ["J_SpineLower","J_Chest","J_Head","J_Neck","J_Crotch"];
	var_04 = [scripts\common\utility::random(var_01),scripts\common\utility::random(var_02),scripts\common\utility::random(var_03)];
	foreach(var_06 in var_04)
	{
		if(!scripts\cp\_utility::func_8BB1(param_00.model,var_06))
		{
			continue;
		}

		var_07 = param_00 gettagorigin(var_06);
		function_02E0(level._effect["electric_trap_attack"],self.origin + (0,0,24),vectortoangles(var_07 - self.origin + (0,0,24)),var_07);
		scripts\common\utility::func_136F7();
		playfxontag(level._effect["electric_trap_shock"],param_00,var_06);
		scripts\common\utility::func_136F7();
	}
}