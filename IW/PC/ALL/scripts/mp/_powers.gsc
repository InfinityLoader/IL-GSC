/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_powers.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 150
 * Decompile Time: 5841 ms
 * Timestamp: 10/27/2023 12:21:24 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_D782 = [];
	level.var_D786 = [];
	level.var_D79B = [];
	level.var_D7A4 = [];
	thread scripts\cp\zombies\_powerup_ability::func_D790();
	func_D77D();
	func_D780();
	func_D787("power_siegeMode",undefined,::func_12D2C,::func_130D5,"powers_siegemode_update",undefined,undefined);
	func_D787("power_dash",::func_F6B1,::func_12C9F,::func_13072,undefined,undefined,undefined);
	func_D787("power_opticWave",::func_F7C8,::func_12CFB,::func_130B4,undefined,undefined,undefined);
	func_D787("power_overCharge",::func_F7CC,::func_12CFD,::func_130B8,"power_overCharge_update",undefined,"removeOvercharge");
	func_D787("power_comlink",::func_F69C,::func_12C98,::func_13055,undefined,undefined,undefined);
	func_D787("power_c4",::func_F677,undefined,undefined,"c4_update",undefined,undefined);
	func_D787("power_bouncingBetty",undefined,undefined,undefined,"bouncing_betty_update",undefined,undefined);
	func_D787("power_throwingReap",::func_F7EB,::func_12D0D,undefined,undefined,undefined,undefined);
	func_D787("power_transponder",undefined,undefined,undefined,"transponder_update","powers_transponder_used",undefined);
	func_D787("power_sonicSensor",undefined,undefined,undefined,"sonic_sensor_update",undefined,undefined);
	func_D787("power_barrier",::func_F658,::func_12C78,::func_13049,undefined,"powers_barrier_used",undefined);
	func_D787("power_mortarMount",::func_F7A5,::func_12CF3,::func_130A5,undefined,"powers_mortarMount_used",undefined);
	func_D787("power_tripMine",undefined,undefined,undefined,"trip_mine_update",undefined,undefined);
	func_D787("power_adrenaline",::func_F62E,::func_12C67,::func_1303C,"power_adrenaline_update",undefined,"removeAdrenaline");
	func_D787("power_multiVisor",::func_F7AB,::func_12CF6,::func_130A7,"power_multi_visor_update",undefined,undefined);
	func_D787("power_trophy",::func_F899,::func_12D52,undefined,"trophy_update",undefined,undefined);
	func_D787("power_stealthMode",::func_F861,::func_12D38,::func_130E0,"powers_stealth_mode_update",undefined,undefined);
	func_D787("power_disruptor",undefined,undefined,undefined,undefined,undefined,undefined);
	func_D787("power_pulseGrenade",undefined,undefined,undefined,undefined,undefined,undefined);
	func_D787("power_niagara",::func_F7B5,::func_12CF7,::func_130AA,"powers_niagara_update",undefined,undefined);
	func_D787("power_distortionField",undefined,undefined,undefined,undefined,undefined,undefined);
	func_D787("power_fearGrenade",undefined,undefined,undefined,"restart_fear_grenade_cooldown",undefined,undefined);
	func_D787("power_explodingDrone",::func_F6EF,::func_12CAF,::func_13085,"exploding_drone_update",undefined,undefined);
	func_D787("power_cryoMine",undefined,undefined,undefined,"cryo_mine_update",undefined,undefined);
	func_D787("power_coneFlash",::func_F69E,::func_12C99,::func_13057,undefined,undefined,undefined);
	func_D787("power_blackhat",::func_F664,::func_12C80,::func_1304D,undefined,"powers_blackhat_used",undefined);
	func_D787("power_periphVis",undefined,::func_12D03,::func_130BB,"periphVis_update",undefined,undefined);
	func_D787("power_deployableCover",undefined,undefined,undefined,undefined,undefined,undefined);
	func_D787("power_blackholeGrenade",undefined,undefined,undefined,undefined,undefined,undefined);
	func_D787("power_shardBall",undefined,undefined,undefined,undefined,"powers_shardBall_used",undefined);
	func_D787("power_wristRocket",::func_FB22,::func_12D6A,undefined,undefined,undefined,undefined);
	thread lib_0DE9::init();
	thread lib_0DD5::init();
	thread lib_0DE6::func_69D5();
	thread lib_0DE5::func_5223();
	thread lib_0E0B::func_13DFB();
	thread scripts\mp\_blackholegrenade::func_2B3C();
	thread lib_0E06::init();
	thread lib_0E05::spidergrenade_init();
	thread scripts\mp\_trophy_system::func_12813();
	thread scripts\mp\_domeshield::domeshield_init();
	thread scripts\mp\powers\blink_knife::blinkknifeinit();
}

//Function Number: 2
func_D724(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	var_09 = spawnstruct();
	var_09.var_130F3 = param_01;
	var_09.var_13CE0 = param_02;
	var_09.var_461D = param_04;
	var_09.var_92B8 = param_03;
	var_09.var_B486 = param_05;
	var_09.var_4E5A = param_06;
	var_09.var_13058 = param_07;
	var_09.var_12B2B = param_08;
	if(var_09.var_12B2B == "interact")
	{
		var_09.var_12B2B = "charges";
	}

	level.var_D782[param_00] = var_09;
}

//Function Number: 3
func_D77D()
{
	var_00 = 1;
	for(;;)
	{
		var_01 = tablelookupbyrow("mp/powertable.csv",var_00,0);
		if(var_01 == "")
		{
			break;
		}

		var_02 = tablelookupbyrow("mp/powertable.csv",var_00,1);
		var_03 = tablelookupbyrow("mp/powertable.csv",var_00,6);
		var_04 = tablelookupbyrow("mp/powertable.csv",var_00,7);
		var_05 = tablelookupbyrow("mp/powertable.csv",var_00,8);
		var_06 = tablelookupbyrow("mp/powertable.csv",var_00,9);
		var_07 = tablelookupbyrow("mp/powertable.csv",var_00,10);
		var_08 = tablelookupbyrow("mp/powertable.csv",var_00,11);
		var_09 = tablelookupbyrow("mp/powertable.csv",var_00,15);
		func_D724(var_02,var_03,var_04,int(var_01),float(var_05),int(var_06),int(var_07),int(var_08),var_09);
		if(isdefined(level.var_D7A4[var_04]) && var_04 != "<power_script_generic_weapon>")
		{
			switch(var_04)
			{
				default:
					break;
			}
		}

		level.var_D7A4[var_04] = var_02;
		var_00++;
	}
}

//Function Number: 4
func_D780()
{
	if(!isdefined(level.var_D77F))
	{
		level.var_D77F = [];
	}

	var_00 = 0;
	for(;;)
	{
		var_01 = tablelookupbyrow("mp/powerpassivetable.csv",var_00,0);
		if(var_01 == "")
		{
			break;
		}

		var_02 = tablelookupbyrow("mp/powerpassivetable.csv",var_00,1);
		var_03 = tablelookupbyrow("mp/powerpassivetable.csv",var_00,2);
		var_04 = tablelookupbyrow("mp/powerpassivetable.csv",var_00,3);
		var_05 = spawnstruct();
		if(var_04 != "")
		{
			var_05.var_23B1 = var_04;
			level.var_D7A4[var_04] = var_02;
		}

		if(!isdefined(level.var_D77F[var_02]))
		{
			level.var_D77F[var_02] = [];
		}

		var_06 = level.var_D77F[var_02];
		if(!isdefined(var_06[var_03]))
		{
			var_06[var_03] = var_05;
			level.var_D77F[var_02] = var_06;
		}

		var_00++;
	}
}

//Function Number: 5
func_8091(param_00,param_01)
{
	if(!isdefined(level.var_D77F[param_00]))
	{
		return undefined;
	}

	var_02 = level.var_D77F[param_00];
	if(!isdefined(var_02[param_01]))
	{
		return undefined;
	}

	return var_02[param_01];
}

//Function Number: 6
func_8090(param_00)
{
	if(!isdefined(self.var_D782[param_00]))
	{
		return undefined;
	}

	var_01 = self.var_D782[param_00];
	var_02 = getdvar("scr_debug_power_passive");
	if(isdefined(var_02))
	{
		var_03 = func_8091(param_00,var_02);
		if(isdefined(var_03))
		{
			if(isdefined(var_03.var_23B1))
			{
				return var_03.var_23B1;
			}
		}
	}

	foreach(var_05 in var_01.var_C946)
	{
		var_03 = func_8091(param_00,var_05);
		if(!isdefined(var_03))
		{
			continue;
		}

		if(isdefined(var_03.var_23B1))
		{
			return var_03.var_23B1;
		}
	}

	return undefined;
}

//Function Number: 7
func_D787(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = level.var_D782[param_00];
	if(!isdefined(var_07))
	{
		scripts\common\utility::func_66BD("No configuration data for " + param_00 + " found! Is it in powertable.csv? Or make sure powerSetupFunctions is called after the table is initialized.");
	}

	level.var_D786[param_00] = param_01;
	level.var_D79B[param_00] = param_02;
	if(isdefined(param_03))
	{
		var_07.var_13089 = param_03;
	}

	if(isdefined(param_04))
	{
		var_07.var_12ED9 = param_04;
	}

	if(isdefined(param_05))
	{
		var_07.var_1307B = param_05;
	}

	if(isdefined(param_06))
	{
		var_07.var_9A90 = param_06;
	}
}

//Function Number: 8
func_D750(param_00,param_01)
{
	var_02 = func_808C(param_00);
	var_03 = self.var_D782[var_02];
	var_04 = level.var_D782[var_02];
	var_05 = var_03.var_91B1;
	var_06 = var_03.var_3D23;
	if(isdefined(var_05) && var_05 == param_01)
	{
		return;
	}

	if(isdefined(var_05))
	{
		func_D75E(param_00);
	}

	switch(param_01)
	{
		case 0:
			scripts\cp\zombies\_powerup_ability::func_D78B(param_00);
			scripts\cp\zombies\_powerup_ability::func_D797(param_00,1);
			scripts\cp\zombies\_powerup_ability::func_D791(param_00,var_06);
			thread func_D76E(var_02);
			break;

		case 1:
			scripts\cp\zombies\_powerup_ability::func_D78A(param_00,0);
			scripts\cp\zombies\_powerup_ability::func_D791(param_00,var_06);
			thread func_D76D(var_02);
			break;

		case 2:
			scripts\cp\zombies\_powerup_ability::func_D793(param_00,0);
			scripts\cp\zombies\_powerup_ability::func_D797(param_00,1);
			scripts\cp\zombies\_powerup_ability::func_D791(param_00,var_06);
			thread func_D76C(var_02);
			break;

		case 3:
			break;
	}

	var_03.var_91B1 = param_01;
	thread func_D75F(param_00);
}

//Function Number: 9
func_D75E(param_00)
{
	var_01 = func_808C(param_00);
	if(!isdefined(var_01))
	{
		return;
	}

	var_02 = self.var_D782[var_01];
	var_03 = var_02.var_91B1;
	if(!isdefined(var_03))
	{
		return;
	}

	switch(var_03)
	{
		case "unavailable":
			break;

		case 0:
			scripts\cp\zombies\_powerup_ability::func_D78D(param_00);
			break;

		case 2:
			break;

		case 1:
			scripts\cp\zombies\_powerup_ability::func_D78E(param_00,0);
			break;
	}

	var_02.var_91B1 = undefined;
}

//Function Number: 10
func_D75F(param_00)
{
	self endon("disconnect");
	self notify("power_unsetHudStateOnRemoved_" + param_00);
	self endon("power_unsetHudStateOnRemoved_" + param_00);
	var_01 = func_808C(param_00);
	self waittill("power_removed_" + var_01);
	func_D75E(param_00);
}

//Function Number: 11
func_8397(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 2;
	if(!isdefined(self.var_D782))
	{
		self.var_D782 = [];
	}

	if(param_00 == "none")
	{
		return;
	}

	if(param_01 == "scripted")
	{
		var_05++;
	}

	func_D725(param_00,param_01,param_04);
	var_06 = self.var_D782[param_00];
	var_07 = level.var_D782[param_00];
	scripts\cp\zombies\_powerup_ability::func_D796(var_06.var_10307,var_06.var_B486);
	if(isdefined(param_03))
	{
		var_06.var_C946 = param_03;
	}

	var_0B = 0;
	if(isdefined(self.var_D76F) && isdefined(self.var_D76F[param_00]))
	{
		var_0C = self.var_D76F[param_00];
		var_0D = func_D720(var_0C);
		if(var_0D > 0)
		{
			var_0E = var_06.var_3D23 * var_07.var_461D;
			var_06.var_3D23 = int(var_0E - var_0D / var_07.var_461D);
			if(var_06.var_3D23 < 0)
			{
				var_06.var_3D23 = 0;
			}

			var_0B = var_0D;
			while(var_0B > var_07.var_461D)
			{
				var_0B = var_0B - var_07.var_461D;
			}
		}
	}

	if(param_01 == "scripted")
	{
		return;
	}

	var_06.var_13CE0 = undefined;
	if(var_07.var_13CE0 == "<power_script_generic_weapon>")
	{
		var_06.var_13CE0 = scripts\common\utility::func_116D7(param_01 == "primary","power_script_generic_primary_mp","power_script_generic_secondary_mp");
	}
	else
	{
		var_06.var_13CE0 = var_07.var_13CE0;
	}

	var_0F = func_8090(param_00);
	var_10 = scripts\common\utility::func_116D7(isdefined(var_0F),var_0F,var_06.var_13CE0);
	var_06.var_13CE0 = var_10;
	scripts\mp\_utility::func_12C6(var_10,0);
	self setweaponammoclip(var_10,var_06.var_3D23);
	if(var_06.var_10307 == "primary")
	{
		self method_844B(var_10);
		self.var_D781 = var_10;
	}
	else if(var_06.var_10307 == "secondary")
	{
		self method_844C(var_10);
		self.var_D785 = var_10;
	}

	if(isdefined(level.var_D786[param_00]))
	{
		self [[ level.var_D786[param_00] ]](param_00);
	}

	thread func_D73D(param_00);
	thread func_B2F0(var_07,param_00,var_06.var_10307,var_07.var_461D,var_07.var_12ED9,var_07.var_1307B,var_10,var_0B,param_02);
}

//Function Number: 12
func_E15E(param_00)
{
	if(isdefined(level.var_D79B[param_00]))
	{
		self [[ level.var_D79B[param_00] ]]();
	}

	if(isdefined(self.var_D782[param_00].var_13CE0))
	{
		scripts\mp\_utility::func_141E(self.var_D782[param_00].var_13CE0);
	}

	if(self.var_D782[param_00].var_10307 == "primary")
	{
		self method_844D();
		self.var_D781 = undefined;
	}
	else if(self.var_D782[param_00].var_10307 == "secondary")
	{
		self method_844E();
		self.var_D785 = undefined;
	}

	self notify("power_removed_" + param_00);
	scripts\cp\zombies\_powerup_ability::func_D78C(self.var_D782[param_00].var_10307);
	self.var_D782[param_00] = undefined;
}

//Function Number: 13
func_110C2()
{
	if(isdefined(self.var_D782))
	{
		if(!isdefined(self.var_D76F))
		{
			self.var_D76F = [];
		}
		else
		{
			func_4042();
		}

		foreach(var_03, var_01 in self.var_D782)
		{
			if(isdefined(level.var_C81F) && level.var_C81F == 1)
			{
				continue;
			}
			else if(isdefined(level.var_C81F) && level.var_C81F != 0)
			{
				if(level.var_D782[var_03].var_4E5A == 1)
				{
					continue;
				}
			}
			else if(!isdefined(level.var_C81F))
			{
				if(level.var_D782[var_03].var_4E5A == 1)
				{
					continue;
				}
			}

			if(var_01.var_4619 > 0)
			{
				var_02 = spawnstruct();
				var_02.var_D719 = var_03;
				var_02.var_4619 = var_01.var_4619;
				var_02.var_3D23 = var_01.var_3D23;
				var_02.var_B486 = var_01.var_B486;
				var_02.var_4E5A = var_01.var_4E5A;
				var_02.var_11931 = gettime();
				self.var_D76F[var_03] = var_02;
			}
		}
	}
}

//Function Number: 14
func_4042()
{
	if(isdefined(self.var_D76F) && self.var_D76F.size > 0)
	{
		var_00 = self.var_D76F;
		foreach(var_03, var_02 in var_00)
		{
			if(func_D720(var_02) == 0)
			{
				self.var_D76F[var_03] = undefined;
			}
		}
	}
}

//Function Number: 15
func_D720(param_00)
{
	var_01 = level.var_D782[param_00.var_D719];
	var_02 = param_00.var_B486 - param_00.var_3D23 * var_01.var_461D - var_01.var_461D - param_00.var_4619;
	var_03 = gettime() - param_00.var_11931 / 1000;
	return max(0,var_02 - var_03);
}

//Function Number: 16
func_41D0()
{
	self notify("powers_cleanUp");
	if(isdefined(self.var_D782))
	{
		var_00 = self.var_D782;
		foreach(var_03, var_02 in var_00)
		{
			func_E15E(var_03);
		}

		self.var_D782 = [];
	}
}

//Function Number: 17
func_808C(param_00)
{
	if(!isdefined(self.var_D782))
	{
		return undefined;
	}

	foreach(var_03, var_02 in self.var_D782)
	{
		if(var_02.var_10307 == param_00)
		{
			return var_03;
		}
	}

	return undefined;
}

//Function Number: 18
func_E265()
{
	if(!isdefined(self) || !isdefined(self.var_D782))
	{
		return;
	}

	foreach(var_04, var_01 in self.var_D782)
	{
		var_02 = var_01.var_3D23;
		var_03 = var_01.var_B486;
		if(var_02 != var_03)
		{
			self.var_D782[var_04].var_3D23 = self.var_D782[var_04].var_B486;
			func_D765(var_04);
			self notify("power_charges_adjusted_" + var_04,self.var_D782[var_04].var_3D23);
		}
	}
}

//Function Number: 19
func_1813(param_00)
{
	if(!isdefined(self) || !isdefined(self.var_D782))
	{
		return;
	}

	foreach(var_07, var_02 in self.var_D782)
	{
		var_03 = var_02.var_3D23;
		var_04 = var_02.var_B486;
		var_05 = var_03 + param_00;
		if(var_05 > var_04)
		{
			var_05 = var_04;
		}

		var_06 = var_05 - var_03;
		if(var_06 > 0)
		{
			self.var_D782[var_07].var_3D23 = var_05;
			func_D765(var_07);
			self notify("power_charges_adjusted_" + var_07,self.var_D782[var_07].var_3D23);
		}
	}
}

//Function Number: 20
func_D735(param_00)
{
	return scripts\common\utility::func_116D7(self.var_D782[param_00].var_10307 == "primary","+frag","+smoke");
}

//Function Number: 21
func_D734(param_00)
{
	return self.var_D782[param_00].var_3D23;
}

//Function Number: 22
func_D736(param_00)
{
	return self.var_D782[param_00].var_B486;
}

//Function Number: 23
func_D737(param_00)
{
	return level.var_D7A4[param_00];
}

//Function Number: 24
func_D738(param_00)
{
	if(!isdefined(param_00) || !isdefined(level.var_D782[param_00]) || param_00 == "none")
	{
		return 0;
	}

	return level.var_D782[param_00].var_92B8;
}

//Function Number: 25
func_D725(param_00,param_01,param_02)
{
	var_03 = level.var_D782[param_00];
	var_04 = spawnstruct();
	var_04.var_10307 = param_01;
	var_04.var_3D23 = var_03.var_B486;
	if(scripts\mp\_utility::func_9FB3(param_02))
	{
		var_04.var_3D23++;
	}

	var_04.var_B486 = var_04.var_3D23;
	var_04.var_93DD = 0;
	var_04.var_19 = 0;
	var_04.var_4619 = 0;
	var_04.var_461B = 1;
	var_04.var_C946 = [];
	self.var_D782[param_00] = var_04;
}

//Function Number: 26
func_B2F0(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self endon("death");
	self endon("disconnect");
	self endon("powers_cleanUp");
	self endon("power_removed_" + param_01);
	if((isdefined(param_08) && param_08) || param_01 == "power_copycatGrenade")
	{
		self endon("start_copycat");
	}

	scripts\cp\zombies\_powerup_ability::func_D789(param_02,int(param_00.var_92B8),1,int(self.var_D782[param_01].var_3D23));
	scripts\mp\_utility::func_7670("prematch_done");
	param_03 = scripts\mp\_powerloot::func_7FBF(param_01,param_03);
	func_D750(param_02,2);
	scripts\cp\zombies\_powerup_ability::powershud_updatepoweroffcooldown(param_02,0);
	self notify("power_available",param_01,param_02);
	thread scripts\mp\_weapons::func_13AB5(self,param_01,param_02);
	for(;;)
	{
		func_D765(param_01);
		var_09 = param_06 + "_success";
		thread func_13A0E(param_03,param_01,var_09,param_02);
		var_0A = scripts\common\utility::func_116D7(param_00.var_130F3 == "weapon_hold","offhand_pullback","offhand_fired");
		if(param_00.var_130F3 == "weapon_hold")
		{
			self waittill(var_0A,var_0B);
			if(var_0B != param_06)
			{
				continue;
			}
		}
		else if(!func_D76B(param_06))
		{
			continue;
		}

		self notify("power_activated",param_01,param_02);
		scripts\mp\_utility::func_D915("power used - " + param_01,self);
		self notify(var_09);
		var_0C = undefined;
		if(isdefined(param_00.var_13089))
		{
			var_0C = self thread [[ param_00.var_13089 ]]();
			if(isdefined(var_0C) && var_0C == 0)
			{
				continue;
			}
		}

		if(isdefined(param_05))
		{
			self waittill(param_05,var_0C);
			if(isdefined(var_0C) && var_0C == 0)
			{
				continue;
			}
		}

		scripts\mp\_gamelogic::func_F73B(self,1);
		scripts\mp\_analyticslog::func_AFAC(param_01,"unused");
		func_D71A(-1,self.var_D782[param_01].var_10307);
		combatrecordpoweruse(param_01);
		if(isdefined(param_04) && level.var_D782[param_01].var_12B2B == "drain" && !scripts\mp\_utility::func_9FB3(self.var_D782[param_01].var_940B))
		{
			func_D72B(param_01);
		}

		thread func_D72A(param_01,param_03,param_08,param_02);
	}
}

//Function Number: 27
func_D73F(param_00)
{
	self endon("disconnect");
	self endon("powers_cleanUp");
	self endon("power_removed_" + param_00);
	var_01 = self.var_D782[param_00];
	var_02 = level.var_D782[param_00];
	for(;;)
	{
		self waittill("scavenged_ammo",var_03);
		if(var_01.var_13CE0 == var_03)
		{
			var_04 = var_02.var_461D;
			func_D74F(param_00,var_04);
		}
	}
}

//Function Number: 28
func_D74C(param_00)
{
	if(func_8C17(param_00))
	{
		var_01 = self.var_D782[param_00];
		func_D71B(1,param_00);
		func_D765(param_00);
		var_02 = var_01.var_91B1;
		if(isdefined(var_02) && var_02 == 1)
		{
			func_D750(var_01.var_10307,2);
		}
	}
}

//Function Number: 29
func_D73D(param_00)
{
	self endon("disconnect");
	self endon("powers_cleanUp");
	self endon("power_removed_" + param_00);
	var_01 = self.var_D782[param_00];
	var_02 = var_01.var_13CE0;
	var_03 = var_01.var_10307;
	for(;;)
	{
		self waittill("scavenged_ammo",var_04);
		if(var_04 == var_02)
		{
			func_D74C(param_00);
		}
	}
}

//Function Number: 30
func_EBD4(param_00)
{
	param_00 func_D74C("power_throwingKnife");
	param_00 func_D74C("power_blinkKnife");
	param_00 func_D74C("power_bioSpike");
}

//Function Number: 31
func_D74F(param_00,param_01)
{
	var_02 = self.var_D782[param_00];
	var_03 = level.var_D782[param_00];
	var_02.var_4617 = min(param_01,var_03.var_461D);
	var_02.var_4619 = var_03.var_461D - param_01;
	if(var_02.var_4619 <= 0)
	{
		self notify("finish_power_cooldown_" + param_00);
	}
}

//Function Number: 32
func_D752(param_00,param_01)
{
	if(param_01 scripts\mp\_utility::_hasperk("specialty_powercell"))
	{
		return 1;
	}

	if(level.var_D782[param_00].var_13058)
	{
		return 1;
	}

	return 0;
}

//Function Number: 33
func_D72A(param_00,param_01,param_02,param_03)
{
	self endon("disconnect");
	self endon("powers_cleanUp");
	self endon("power_removed_" + param_00);
	self endon("power_cooldown_ended" + param_00);
	if((isdefined(param_02) && param_02) || param_00 == "power_copycatGrenade")
	{
		self endon("start_copycat");
	}

	self notify("power_cooldown_begin_" + param_00);
	self endon("power_cooldown_begin_" + param_00);
	var_04 = level.var_D782[param_00];
	var_05 = self.var_D782[param_00];
	param_03 = var_05.var_10307;
	var_06 = param_00 + "_cooldown_update";
	var_05.var_93DD = 1;
	if(!isdefined(var_05.var_461C))
	{
		var_05.var_461C = 0;
	}

	var_05.var_461C++;
	if(!isdefined(var_05.var_4617))
	{
		var_05.var_4617 = 0;
	}

	if(!isdefined(var_05.var_4619))
	{
		var_05.var_4619 = 0;
	}

	var_05.var_4619 = var_05.var_4619 + param_01;
	var_07 = var_05.var_91B1;
	if(isdefined(var_07) && var_07 != 0 && var_05.var_3D23 == 0)
	{
		func_D750(param_03,1);
		self notify("power_unavailable",param_00,param_03);
	}

	while(var_05.var_3D23 < var_05.var_B486)
	{
		if(func_D752(param_00,self))
		{
			wait(0.1);
		}
		else
		{
			self waittill("power_charges_adjusted_" + param_00);
		}

		if(var_05.var_4617 > param_01)
		{
			func_D71A(1,param_03);
			func_D765(param_00);
			if(var_05.var_3D23 == var_05.var_B486)
			{
				thread func_D730(param_00,param_02);
			}

			var_05.var_4617 = var_05.var_4617 - param_01;
			var_05.var_4619 = var_05.var_4619 - param_01;
			var_05.var_461C--;
			if(isdefined(var_07) && var_07 != 0)
			{
				func_D750(param_03,2);
			}
		}
		else
		{
			var_05.var_4617 = var_05.var_4617 + 0.1;
			var_05.var_4619 = var_05.var_4619 - 0.1;
		}

		var_08 = min(1,var_05.var_4617 / param_01);
		self notify(var_06,var_08);
	}

	thread func_D730(param_00,param_02);
}

//Function Number: 34
func_D730(param_00,param_01)
{
	self notify("power_cooldown_ended" + param_00);
	var_02 = self.var_D782[param_00];
	var_02.var_93DD = 0;
	var_02.var_4617 = 0;
	var_02.var_4619 = 0;
	var_02.var_461C = 0;
	if(isdefined(param_01) && param_01)
	{
		self notify("copycat_reset");
	}

	var_03 = var_02.var_91B1;
	var_04 = var_02.var_10307;
	if(var_03 == 0)
	{
		return;
	}

	func_D750(var_04,2);
}

//Function Number: 35
func_D72B(param_00)
{
	self endon("death");
	self endon("power_drain_ended_" + param_00);
	self notify("power_cooldown_ended_" + param_00);
	var_01 = level.var_D782[param_00];
	var_02 = self.var_D782[param_00];
	var_03 = var_01.var_12ED9;
	var_04 = var_01.var_9A90;
	var_05 = var_02.var_10307;
	var_02.var_940B = 1;
	func_D727(param_00);
	func_D750(var_05,0);
	if(isdefined(var_04))
	{
		thread func_D732(param_00,var_05,var_04);
	}

	for(;;)
	{
		self waittill(var_03,var_06);
		if(var_06 == 0)
		{
			break;
		}
	}

	thread func_D731(param_00);
}

//Function Number: 36
func_D732(param_00,param_01,param_02)
{
	self endon("disconnect");
	self endon("powers_cleanUp");
	self endon("power_removed_" + param_00);
	self endon("power_drain_ended_" + param_00);
	self waittill(param_02);
	thread func_D731(param_00);
}

//Function Number: 37
func_D731(param_00)
{
	self notify("power_drain_ended_" + param_00);
	var_01 = self.var_D782[param_00];
	var_02 = var_01.var_10307;
	var_01.var_940B = 0;
	func_D72D(param_00);
	if(var_01.var_3D23 > 0)
	{
		func_D750(var_02,2);
		return;
	}

	func_D750(var_02,1);
}

//Function Number: 38
func_12D2C()
{
}

//Function Number: 39
func_130D5()
{
}

//Function Number: 40
func_F676(param_00)
{
	level.var_D782[param_00].var_4620 = "multi_use";
}

//Function Number: 41
func_12C89()
{
}

//Function Number: 42
func_13051()
{
	scripts\mp\_bulletstorm::func_10D76();
}

//Function Number: 43
func_F6B1(param_00)
{
}

//Function Number: 44
func_12C9F()
{
	lib_0DE4::func_E0E9();
}

//Function Number: 45
func_13072()
{
	return lib_0DE4::func_4D90();
}

//Function Number: 46
func_F7C8(param_00)
{
}

//Function Number: 47
func_12CFB()
{
	lib_0DF5::func_E145();
}

//Function Number: 48
func_130B4()
{
	lib_0DF5::func_C6AF();
}

//Function Number: 49
func_F7E7(param_00)
{
}

//Function Number: 50
func_12D0B()
{
	lib_0DF9::func_CABB();
}

//Function Number: 51
func_130BD()
{
	return lib_0DF9::func_CAC2();
}

//Function Number: 52
func_F6EF(param_00)
{
	lib_0DE6::func_69D0(param_00);
}

//Function Number: 53
func_12CAF()
{
	lib_0DE6::func_69D3();
}

//Function Number: 54
func_13085()
{
}

//Function Number: 55
func_F7CC(param_00)
{
}

//Function Number: 56
func_12CFD()
{
	lib_0DF6::func_E14C();
}

//Function Number: 57
func_130B8()
{
	lib_0DF6::func_130B8();
}

//Function Number: 58
func_F84A(param_00)
{
}

//Function Number: 59
func_12D30()
{
	lib_0E02::func_E16E();
}

//Function Number: 60
func_130D7()
{
	lib_0E02::func_1037D();
}

//Function Number: 61
func_F69C(param_00)
{
}

//Function Number: 62
func_12C98(param_00)
{
	lib_0DE0::func_E0E0();
}

//Function Number: 63
func_13055()
{
	lib_0DE0::func_835C();
}

//Function Number: 64
func_F87F(param_00)
{
	lib_0E07::func_83B2();
}

//Function Number: 65
func_12D45()
{
	lib_0E07::func_E17E();
}

//Function Number: 66
func_130E8()
{
	var_00 = lib_0E07::func_130E8();
	return var_00;
}

//Function Number: 67
func_F844(param_00)
{
}

//Function Number: 68
func_12D2B()
{
	scripts\mp\_phaseshift::func_E169();
}

//Function Number: 69
func_130D4()
{
	scripts\mp\_phaseshift::func_D41C();
}

//Function Number: 70
func_F896(param_00)
{
	lib_0E08::func_F5D3();
}

//Function Number: 71
func_12D50()
{
	lib_0E08::func_E180();
}

//Function Number: 72
func_130F0()
{
	lib_0E08::func_1268F();
}

//Function Number: 73
func_F7EB(param_00)
{
	lib_0DFA::func_838F();
}

//Function Number: 74
func_12D0D()
{
	lib_0DFA::func_E158();
}

//Function Number: 75
func_F73C(param_00)
{
	level.var_D782[param_00].var_5FF3 = 30;
	level.var_8C74 = 0.8;
}

//Function Number: 76
func_12CCD()
{
}

//Function Number: 77
func_1308F()
{
	lib_0DEB::func_E855();
}

//Function Number: 78
func_F658(param_00)
{
	level.var_D782[param_00].var_5FF3 = 30;
}

//Function Number: 79
func_12C78()
{
}

//Function Number: 80
func_13049()
{
	lib_0DD7::func_E83A();
}

//Function Number: 81
func_F659(param_00)
{
}

//Function Number: 82
func_12C79()
{
}

//Function Number: 83
func_1304B()
{
	lib_0DD8::func_E83B();
}

//Function Number: 84
func_F7A5(param_00)
{
	lib_0DF1::func_BB90();
}

//Function Number: 85
func_12CF3()
{
	lib_0DF1::func_BB93();
}

//Function Number: 86
func_130A5()
{
	lib_0DF1::func_BB94();
}

//Function Number: 87
func_F62E(param_00)
{
}

//Function Number: 88
func_12C67()
{
	lib_0DD5::func_E0C2();
}

//Function Number: 89
func_1303C()
{
	thread lib_0DD5::func_1303C();
}

//Function Number: 90
func_F7AB(param_00)
{
	lib_0DF2::func_F7AB();
}

//Function Number: 91
func_12CF6()
{
	lib_0DF2::func_E13F();
}

//Function Number: 92
func_130A7()
{
	lib_0DF2::func_130A7();
}

//Function Number: 93
func_F861(param_00)
{
	lib_0D6F::func_F861();
}

//Function Number: 94
func_12D38()
{
	lib_0D6F::func_E175();
}

//Function Number: 95
func_130E0()
{
	lib_0D6F::func_130E0();
}

//Function Number: 96
func_F7B5(param_00)
{
	lib_0DF3::func_BFC9();
}

//Function Number: 97
func_12CF7()
{
	lib_0DF3::func_BFCA();
}

//Function Number: 98
func_130AA()
{
	lib_0DF3::func_BFCB();
}

//Function Number: 99
func_12D03()
{
	lib_0DF7::func_CA2B();
}

//Function Number: 100
func_130BB()
{
	lib_0DF7::func_CA2C();
}

//Function Number: 101
func_F899(param_00)
{
	scripts\mp\_trophy_system::func_12820();
}

//Function Number: 102
func_12D52()
{
	scripts\mp\_trophy_system::func_12825();
}

//Function Number: 103
func_F677(param_00)
{
	lib_0DDD::func_333D();
}

//Function Number: 104
func_F69E(param_00)
{
	lib_0DE1::func_44FB();
}

//Function Number: 105
func_12C99()
{
	lib_0DE1::func_44FD();
}

//Function Number: 106
func_13057()
{
	lib_0DE1::func_44FF();
}

//Function Number: 107
func_F664(param_00)
{
}

//Function Number: 108
func_12C80()
{
	lib_0DDA::func_E0D4();
}

//Function Number: 109
func_1304D()
{
	lib_0DDA::func_13073();
}

//Function Number: 110
func_FB22(param_00)
{
	lib_0E0B::func_13DF4();
}

//Function Number: 111
func_12D6A()
{
	lib_0E0B::func_13DF5();
}

//Function Number: 112
func_8C17(param_00)
{
	if(!isdefined(self.var_D782[param_00]))
	{
		return 0;
	}

	return 1;
}

//Function Number: 113
func_13709(param_00)
{
	self endon("death");
	self endon("disconnect");
	if(param_00 == "primary")
	{
		var_01 = "power_primary_used";
	}
	else
	{
		var_01 = "power_secondary_used";
	}

	for(;;)
	{
		if(!isdefined(self))
		{
			wait(1);
			break;
		}

		self waittill(var_01);
		break;
	}
}

//Function Number: 114
func_D740(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "all";
	}

	var_02 = func_D739();
	foreach(var_04 in var_02)
	{
		if(self.var_D782[var_04].var_10307 == param_01 || param_01 == "all")
		{
			self.var_D782[var_04].var_461B = param_00;
		}
	}
}

//Function Number: 115
func_D74E(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = "all";
	}

	var_01 = func_D739();
	foreach(var_03 in var_01)
	{
		if(self.var_D782[var_03].var_10307 == param_00 || param_00 == "all")
		{
			self.var_D782[var_03].var_461B = 1;
		}
	}
}

//Function Number: 116
func_D71A(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "all";
	}

	var_02 = func_D739();
	foreach(var_04 in var_02)
	{
		if(self.var_D782[var_04].var_10307 == param_01 || param_01 == "all")
		{
			var_05 = self.var_D782[var_04].var_3D23;
			var_06 = self.var_D782[var_04].var_B486;
			var_07 = max(min(var_06,var_05 + param_00),0);
			self.var_D782[var_04].var_3D23 = var_07;
			if(var_05 != var_07)
			{
				self notify("power_charges_adjusted_" + var_04,self.var_D782[var_04].var_3D23);
			}
		}
	}
}

//Function Number: 117
func_D71B(param_00,param_01)
{
	func_D71A(param_00,self.var_D782[param_01].var_10307);
}

//Function Number: 118
func_D739()
{
	var_00 = getarraykeys(level.var_D782);
	var_01 = getarraykeys(self.var_D782);
	var_02 = [];
	var_03 = 0;
	foreach(var_05 in var_01)
	{
		foreach(var_07 in var_00)
		{
			if(var_05 == var_07)
			{
				var_02[var_03] = var_05;
				var_03 = var_03 + 1;
				break;
			}
		}
	}

	return var_02;
}

//Function Number: 119
func_D729()
{
	scripts\common\utility::func_1C58(0);
}

//Function Number: 120
func_D72F()
{
	scripts\common\utility::func_1C58(1);
}

//Function Number: 121
func_130C3(param_00)
{
	scripts\mp\_utility::func_12C6(param_00);
	scripts\mp\_utility::_switchtoweapon(param_00);
	wait(1);
	scripts\mp\_utility::_switchtoweapon(param_00);
	scripts\mp\_utility::func_141E(param_00);
}

//Function Number: 122
func_50A4(param_00)
{
	if(!isdefined(self.var_D775))
	{
		self.var_D775 = [];
	}

	if(!isdefined(self.var_D775[param_00]))
	{
		self.var_D775[param_00] = 0;
	}
}

//Function Number: 123
func_808F(param_00)
{
	func_50A4(param_00);
	return self.var_D775[param_00];
}

//Function Number: 124
func_F809(param_00,param_01)
{
	func_50A4(param_00);
	self.var_D775[param_00] = param_01;
}

//Function Number: 125
func_4575(param_00,param_01,param_02)
{
	self endon("death");
	self endon("disconnect");
	self endon("cancel_" + param_01);
	if(isdefined(param_02))
	{
		self endon(param_02);
	}

	param_00 = param_00 * 1000;
	var_03 = 1 / param_00;
	var_04 = gettime();
	func_F809(param_01,param_00);
	var_05 = func_808F(param_01);
	while(var_05 > 0)
	{
		func_C170(param_01,var_05 * var_03);
		wait(0.1);
		var_05 = func_808F(param_01);
		var_06 = gettime();
		var_05 = var_05 - var_06 - var_04;
		var_04 = var_06;
		func_F809(param_01,var_05);
	}

	func_C170(param_01,0);
}

//Function Number: 126
func_3885(param_00)
{
	func_F809(param_00,0);
	self notify("cancel_" + param_00);
	func_C170(param_00,0);
}

//Function Number: 127
func_C170(param_00,param_01)
{
	self notify(param_00,param_01);
}

//Function Number: 128
func_13A0E(param_00,param_01,param_02,param_03)
{
	self endon("disconnect");
	self endon("powers_cleanUp");
	self endon("power_removed_" + param_01);
	self endon(param_02);
	level endon("game_ended");
	self waittill("offhand_fired",var_04);
	var_05 = self.var_D782[param_01];
	if(isdefined(var_04) && var_04 == var_05.var_13CE0)
	{
		if(!isalive(self))
		{
			if(var_05.var_3D23 > 0)
			{
				scripts\mp\_analyticslog::func_AFAC(param_01,"unused");
				func_D71A(-1,var_05.var_10307);
			}

			if(!var_05.var_93DD)
			{
				var_05.var_4619 = level.var_D782[param_01].var_461D;
				thread func_D72A(param_01,param_00,undefined,param_03);
				return;
			}
		}
	}
}

//Function Number: 129
func_136DD(param_00,param_01,param_02)
{
	if(isdefined(param_02))
	{
		thread func_13A68(param_00,param_02);
	}

	thread func_13A7D(param_00,param_01);
	self waittill("power_use_update_" + param_00,var_03);
	return var_03;
}

//Function Number: 130
func_13A68(param_00,param_01)
{
	self endon("power_use_update_" + param_00);
	for(;;)
	{
		self waittill("scavenged_ammo",var_02);
		if(var_02 == param_01)
		{
			self notify("power_use_update_" + param_00);
			return;
		}
	}
}

//Function Number: 131
func_13A7D(param_00,param_01)
{
	self endon("power_use_update_" + param_00);
	self waittill(param_01,var_02);
	self notify("power_use_update_" + param_00,var_02);
}

//Function Number: 132
func_D767(param_00,param_01,param_02,param_03)
{
	var_04 = 0;
	param_02 = param_02 - 1;
	var_05 = 0;
	var_06 = 0.05;
	var_07 = func_D735(param_00);
	var_08 = undefined;
	var_09 = param_03;
	for(;;)
	{
		if(!func_9F09(var_07))
		{
			break;
		}

		if(func_9F09(var_07))
		{
			while(func_9F09(var_07))
			{
				if(self usebuttonpressed())
				{
					if(var_05 == 0)
					{
						var_06 = 0.05;
					}

					var_0A = 0;
					while(self usebuttonpressed())
					{
						var_0A = var_0A + 0.05;
						if(var_0A >= var_06)
						{
							param_01 = func_93FD(param_01,param_02,param_03);
							var_05 = 1;
							var_0A = 0;
							var_06 = 0.7;
							var_04 = 1;
							self [[ var_09 ]](param_01);
							break;
						}

						wait(0.05);
					}
				}

				wait(0.05);
				if(self usebuttonpressed() == 0)
				{
					var_05 = 0;
					break;
				}
			}
		}

		wait(0.05);
	}

	if(!var_04)
	{
		if(param_01 == param_02)
		{
			param_01 = 0;
		}
		else
		{
			param_01++;
		}

		self [[ var_09 ]](param_01);
	}

	return param_01;
}

//Function Number: 133
func_9F09(param_00)
{
	if((param_00 == "+frag" && self fragbuttonpressed()) || param_00 == "+smoke" && self secondaryoffhandbuttonpressed())
	{
		return 1;
	}

	return 0;
}

//Function Number: 134
func_D769(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	if(!isdefined(param_01))
	{
		param_01 = 2000;
	}
	else
	{
		param_01 = param_01 * 1000;
	}

	var_02 = func_D735(param_00);
	var_03 = gettime();
	var_04 = var_03 + param_01;
	while(func_9F09(var_02) && gettime() < var_04)
	{
		wait(0.05);
	}

	return gettime() - var_03 / 1000;
}

//Function Number: 135
func_93FD(param_00,param_01,param_02)
{
	if(param_00 < param_01)
	{
		param_00++;
	}
	else
	{
		param_00 = 0;
	}

	return param_00;
}

//Function Number: 136
func_C179()
{
	if(!isdefined(self.var_13C2E))
	{
		return;
	}

	switch(self.var_13C2E)
	{
		case "bouncingbetty_mp":
			self.var_222 notify("bouncing_betty_update",0);
			break;

		case "transponder_mp":
			self.var_222 notify("transponder_update",0);
			break;

		case "trip_mine_mp":
			self.var_222 notify("trip_mine_update",0);
			break;

		case "sonic_sensor_mp":
			self.var_222 notify("sonic_sensor_update",0);
			break;

		case "trophy_mp":
			self.var_222 notify("trophy_update",0);
			break;

		case "fear_grenade_mp":
			self.var_222 notify("restart_fear_grenade_cooldown",0);
			break;

		case "cryo_mine":
			self.var_222 notify("cryo_mine_update",0);
			break;

		case "micro_turret_mp":
			self.var_222 notify("microTurret_update",0);
			break;

		default:
			break;
	}
}

//Function Number: 137
func_9F0A(param_00)
{
	switch(param_00)
	{
		case "iw6_minigunsiege_mp":
		case "iw7_niagara_mp":
		case "armorup_mp":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 138
func_F808(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = 0;
	}

	if(param_01 > 0)
	{
		func_4575(param_01,param_00);
		return;
	}

	func_3885(param_00);
}

//Function Number: 139
func_D76C(param_00)
{
	self endon("death");
	self endon("power_available_ended_" + param_00);
	var_01 = self.var_D782[param_00];
	var_02 = var_01.var_10307;
	for(;;)
	{
		self waittill("power_charges_adjusted_" + param_00,var_03);
		scripts\cp\zombies\_powerup_ability::func_D791(var_02,var_03);
	}
}

//Function Number: 140
func_D76E(param_00)
{
	self endon("disconnect");
	self endon("power_removed_" + param_00);
	self endon("power_drain_ended_" + param_00);
	var_01 = self.var_D782[param_00];
	var_02 = level.var_D782[param_00];
	var_03 = var_01.var_10307;
	var_04 = var_02.var_12ED9;
	if(!isdefined(var_04))
	{
		var_04 = param_00 + "_update";
	}

	for(;;)
	{
		self waittill(var_04,var_05);
		var_05 = max(0,min(1,var_05));
		scripts\cp\zombies\_powerup_ability::func_D795(var_03,var_05);
	}
}

//Function Number: 141
func_D76D(param_00)
{
	self endon("disconnect");
	self endon("power_removed_" + param_00);
	self endon("power_cooldown_ended" + param_00);
	var_01 = self.var_D782[param_00];
	var_02 = level.var_D782[param_00];
	var_03 = var_01.var_10307;
	var_04 = param_00 + "_cooldown_update";
	for(;;)
	{
		self waittill(var_04,var_05);
		scripts\cp\zombies\_powerup_ability::func_D792(var_03,var_05);
	}
}

//Function Number: 142
func_D76B(param_00)
{
	var_01 = spawnstruct();
	childthread func_13A2C(param_00,var_01);
	childthread func_13A2D(param_00,var_01);
	self waittill("grenadeOffhandFiredRace_" + param_00 + "_begin");
	waittillframeend;
	self notify("grenadeOffhandFiredRace_" + param_00 + "_end");
	if(isdefined(var_01.var_85BD) && var_01.var_85BD == param_00)
	{
		return !isdefined(var_01.var_85BC);
	}

	if(isdefined(var_01.var_C336) && var_01.var_C336 == param_00)
	{
		return 1;
	}

	return 0;
}

//Function Number: 143
func_13A2C(param_00,param_01)
{
	self endon("grenadeOffhandFiredRace_" + param_00 + "_end");
	for(;;)
	{
		self waittill("grenade_fire",var_02,var_03,var_04,var_05);
		if(!scripts\mp\_utility::func_85E0(var_02))
		{
			continue;
		}

		param_01.var_85BD = var_03;
		param_01.var_85BC = var_05;
		break;
	}

	self notify("grenadeOffhandFiredRace_" + param_00 + "_begin");
}

//Function Number: 144
func_13A2D(param_00,param_01)
{
	self endon("grenadeOffhandFiredRace_" + param_00 + "_end");
	self waittill("offhand_fired",var_02);
	param_01.var_C336 = var_02;
	self notify("grenadeOffhandFiredRace_" + param_00 + "_begin");
}

//Function Number: 145
func_D727(param_00)
{
	var_01 = self.var_D782[param_00];
	if(!isdefined(var_01.var_55AB))
	{
		var_01.var_55AB = 0;
	}

	var_01.var_55AB++;
	if(var_01.var_55AB == 1)
	{
		func_D765(param_00);
	}
}

//Function Number: 146
func_D72D(param_00)
{
	var_01 = self.var_D782[param_00];
	var_01.var_55AB--;
	if(var_01.var_55AB == 0)
	{
		func_D765(param_00);
	}
}

//Function Number: 147
func_D71E(param_00)
{
	var_01 = self.var_D782[param_00];
	return !isdefined(var_01.var_55AB) || var_01.var_55AB == 0;
}

//Function Number: 148
func_D765(param_00)
{
	var_01 = self.var_D782[param_00];
	var_02 = isdefined(var_01.var_55AB) && var_01.var_55AB;
	var_03 = var_01.var_3D23 > 0;
	if(!var_02 && var_03)
	{
		self setweaponammoclip(var_01.var_13CE0,1);
		return;
	}

	self setweaponammoclip(var_01.var_13CE0,0);
}

//Function Number: 149
combatrecordpoweruse(param_00)
{
	if(!scripts\mp\_utility::canrecordcombatrecordstats())
	{
		return;
	}

	var_01 = undefined;
	if(function_02D9("mp","LethalStatItems",param_00))
	{
		var_01 = "lethalStats";
	}
	else if(function_02D9("mp","TacticalStatItems",param_00))
	{
		var_01 = "tacticalStats";
	}
	else
	{
		return;
	}

	var_03 = self getplayerdata("mp",var_01,param_00,"uses");
	self setplayerdata("mp",var_01,param_00,"uses",var_03 + 1);
}

//Function Number: 150
equipmenthit(param_00,param_01,param_02,param_03)
{
	if(scripts\mp\_utility::playersareenemies(param_01,param_00))
	{
		if(scripts\mp\_utility::func_9E6C(param_02))
		{
			return;
		}

		if(!isdefined(param_01.var_A99F[param_02]))
		{
			param_01.var_A99F[param_02] = 0;
		}

		if(param_01.var_A99F[param_02] == gettime())
		{
			return;
		}

		param_01.var_A99F[param_02] = gettime();
		param_01 thread scripts\mp\_gamelogic::func_117B7(param_02,1,"hits");
		var_04 = param_01 scripts\mp\_persistence::func_10E34("totalShots");
		var_05 = param_01 scripts\mp\_persistence::func_10E34("hits") + 1;
		if(var_05 <= var_04)
		{
			param_01 scripts\mp\_persistence::func_10E55("hits",var_05);
			param_01 scripts\mp\_persistence::func_10E55("misses",int(var_04 - var_05));
			param_01 scripts\mp\_persistence::func_10E55("accuracy",int(var_05 * 10000 / var_04));
		}

		if((isdefined(param_03) && scripts\common\utility::func_9D74(param_03)) || scripts\mp\_utility::isprojectiledamage(param_03))
		{
			param_01 thread scripts\mp\contractchallenges::contractshotslanded(param_02);
			param_01.var_A96A = gettime();
			var_06 = scripts\mp\_utility::func_8225(param_02);
			if(var_06 == "weapon_lmg")
			{
				if(!isdefined(param_01.shotslandedlmg))
				{
					param_01.shotslandedlmg = 1;
					return;
				}

				param_01.shotslandedlmg++;
				return;
			}
		}
	}
}