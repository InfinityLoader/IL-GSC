/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\powers\coop_powers.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 146
 * Decompile Time: 6784 ms
 * Timestamp: 10/27/2023 12:26:44 AM
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
	if(isdefined(level.var_D751))
	{
		level [[ level.var_D751 ]]();
	}
	else
	{
		func_D787("power_phaseShift",::func_F7E2,::func_12D07,::func_130BC,"powers_phase_shift_update",undefined,"phaseshift_interrupted");
		func_D787("power_kineticPulse",::func_F776,::func_12CE0,::func_1309C,undefined,undefined,undefined);
		func_D787("power_transponder",::func_F896,::func_12D50,undefined,"transponder_update","powers_transponder_used",undefined);
		func_D787("power_armageddon",undefined,undefined,::func_13043,undefined,undefined,undefined);
		func_D787("power_microTurret",undefined,undefined,undefined,"microTurret_update","powers_microTurret_used",undefined);
		func_D787("power_rewind",::func_F81E,::func_12D1B,::func_130CE,undefined,"powers_rewind_used",undefined);
		func_D787("power_repulsor",undefined,undefined,::func_130CD,undefined,undefined,undefined);
		func_D787("power_blackholeGrenade",undefined,undefined,undefined,undefined,"powers_blackholeGrenade_used",undefined);
		func_D787("power_tripMine",undefined,undefined,undefined,"trip_mine_update",undefined,undefined);
		func_D787("power_portalGenerator",undefined,undefined,undefined,undefined,"powers_portalGenerator_used",undefined);
		func_D787("power_c4",undefined,undefined,undefined,"c4_update",undefined,undefined);
		func_D787("power_holyWater",::giveholywater,::takeholywater,undefined,undefined,undefined,undefined);
		thread lib_0D12::init();
		thread lib_0D0E::init();
		thread lib_0D17::init();
		thread lib_0D1E::init();
		thread lib_0D0F::init();
		thread lib_0D1F::func_127E3();
		thread lib_0D04::func_2B3C();
		thread scripts\cp\powers\coop_holywater::init();
	}

	if(!isdefined(level.var_46A1))
	{
		level.var_46A1 = [];
		level.var_46A1["90"] = cos(90);
		level.var_46A1["89"] = cos(89);
		level.var_46A1["45"] = cos(45);
		level.var_46A1["25"] = cos(25);
		level.var_46A1["15"] = cos(15);
		level.var_46A1["10"] = cos(10);
		level.var_46A1["5"] = cos(5);
	}

	level func_FAD7();
	scripts\common\utility::flag_init("powers_init_done");
	scripts\common\utility::flag_set("powers_init_done");
}

//Function Number: 2
func_FAD7()
{
	level.var_C7E9["cluster_grenade_zm"] = ::func_42DD;
	level.var_C7E9["frag_grenade_zm"] = ::func_7358;
}

//Function Number: 3
func_42DD(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	param_00 endon("power_removed_power_clusterGrenade");
	if(!isdefined(param_01) || param_01 != "cluster_grenade_zm")
	{
		return;
	}

	if(!param_00 func_8C17("power_clusterGrenade"))
	{
		return;
	}

	var_02 = spawn("script_model",param_00.origin);
	var_03 = "power_clusterGrenade";
	thread scripts\cp\_weapon::func_42DA(param_00.origin,scripts\common\utility::array_randomize([0.2,0.25,0.25,0.3]),param_00,var_02);
	param_00 func_D71A(param_00.var_D782[var_03].var_3D23 - 1,param_00.var_D782[var_03].var_10307,1);
	param_00 func_D765(var_03);
	param_00 thread func_E1F1();
	param_00 thread func_5166(var_03);
}

//Function Number: 4
func_7358(param_00,param_01)
{
	level endon("game_ended");
	param_00 endon("disconnect");
	var_02 = "power_frag";
	param_00 endon("power_removed_" + var_02);
	if(!isdefined(param_01) || param_01 != "frag_grenade_zm")
	{
		return;
	}

	if(!param_00 func_8C17(var_02))
	{
		return;
	}

	var_03 = param_00.origin;
	playfx(scripts\common\utility::getfx("clusterGrenade_explode"),var_03);
	playsoundatpos(var_03,"grenade_explode");
	if(!isdefined(param_00.var_D782[var_02]))
	{
		return;
	}

	param_00 func_D71A(param_00.var_D782[var_02].var_3D23 - 1,param_00.var_D782[var_02].var_10307,1);
	param_00 func_D765(var_02);
	param_00 radiusdamage(var_03,256,150,100,param_00,"MOD_GRENADE","frag_grenade_zm");
	playrumbleonposition("grenade_rumble",var_03);
	earthquake(0.5,0.75,var_03,800);
	foreach(var_05 in level.players)
	{
		if(var_05 scripts\cp\_utility::func_9FC6())
		{
			continue;
		}

		if(distancesquared(var_03,var_05.origin) > 360000)
		{
			continue;
		}

		if(var_05 method_808F(var_03))
		{
			var_05 thread scripts\cp\_weapon::func_54F0(var_03);
		}

		var_05 setclientomnvar("ui_hud_shake",1);
	}

	param_00 thread func_E1F1();
	param_00 thread func_5166(var_02);
}

//Function Number: 5
func_E1F1()
{
	self endon("death");
	self method_80A4();
	while(self fragbuttonpressed())
	{
		wait(0.1);
	}

	wait(0.1);
	self method_80D6();
}

//Function Number: 6
func_5166(param_00)
{
	self endon("death");
	self endon("end_last_second_throw_func");
	self notify("starting_delay_last_second_grenade_throws");
	thread func_62CD(0.25);
	self waittill("grenade_fire",var_01,var_02,var_03,var_04);
	if(isdefined(var_01) && var_01.classname == "grenade")
	{
		var_01 delete();
		func_D71A(self.var_D782[param_00].var_3D23 + 1,self.var_D782[param_00].var_10307,1);
	}
}

//Function Number: 7
func_62CD(param_00)
{
	self endon("death");
	wait(param_00);
	self notify("end_last_second_throw_func");
}

//Function Number: 8
func_D724(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	var_0A = spawnstruct();
	var_0A.var_130F3 = param_01;
	var_0A.var_13CE0 = param_02;
	var_0A.var_461D = param_04;
	var_0A.var_92B8 = param_03;
	var_0A.var_B486 = param_05;
	var_0A.var_4E5A = param_06;
	var_0A.var_13058 = param_07;
	var_0A.var_12B2B = param_08;
	var_0A.var_504B = param_09;
	level.var_D782[param_00] = var_0A;
}

//Function Number: 9
func_D77D()
{
	var_00 = 1;
	if(isdefined(level.var_D75C))
	{
		var_01 = level.var_D75C;
	}
	else
	{
		var_01 = "cp/cp_powertable.csv";
	}

	for(;;)
	{
		var_02 = tablelookupbyrow(var_01,var_00,0);
		if(var_02 == "")
		{
			break;
		}

		var_03 = tablelookupbyrow(var_01,var_00,1);
		var_04 = tablelookupbyrow(var_01,var_00,6);
		var_05 = tablelookupbyrow(var_01,var_00,7);
		var_06 = tablelookupbyrow(var_01,var_00,8);
		var_07 = tablelookupbyrow(var_01,var_00,9);
		var_08 = tablelookupbyrow(var_01,var_00,10);
		var_09 = tablelookupbyrow(var_01,var_00,11);
		var_0A = tablelookupbyrow(var_01,var_00,16);
		var_0B = tablelookupbyrow(var_01,var_00,13);
		func_D724(var_03,var_04,var_05,int(var_02),float(var_06),int(var_07),int(var_08),int(var_09),var_0A,var_0B);
		if(isdefined(level.var_D7A4[var_05]) && var_05 != "<power_script_generic_weapon>")
		{
			switch(var_05)
			{
				case "power_rewind":
					if(var_03 == "power_rewinder")
					{
						break;
					}
		
					break;
	
				default:
					break;
			}
		}

		level.var_D7A4[var_05] = var_03;
		var_00++;
	}
}

//Function Number: 10
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

//Function Number: 11
func_8091(param_00,param_01)
{
	if(!isdefined(level.var_D77F))
	{
		return undefined;
	}

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

//Function Number: 12
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

//Function Number: 13
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

//Function Number: 14
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

//Function Number: 15
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

//Function Number: 16
func_D75F(param_00)
{
	self endon("disconnect");
	self notify("power_unsetHudStateOnRemoved_" + param_00);
	self endon("power_unsetHudStateOnRemoved_" + param_00);
	var_01 = func_808C(param_00);
	self waittill("power_removed_" + var_01);
	func_D75E(param_00);
}

//Function Number: 17
func_8397(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	var_07 = 2;
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
		var_07++;
	}

	for(var_08 = self method_854D();var_08 != "none";var_08 = self method_854D())
	{
		scripts\common\utility::func_136F7();
	}

	var_09 = getarraykeys(self.var_D782);
	foreach(var_0B in var_09)
	{
		if(self.var_D782[var_0B].var_10307 == param_01)
		{
			self.var_A037 = var_0B;
			func_E15E(var_0B);
			scripts\cp\zombies\zombie_analytics::func_AF76(self.var_A037,level.var_12631);
			break;
		}
	}

	func_D725(param_00,param_01,param_04,param_05,param_06);
	var_0D = self.var_D782[param_00];
	var_0E = level.var_D782[param_00];
	self notify("delete_equipment " + param_01);
	if(isdefined(param_03))
	{
		var_0D.var_C946 = param_03;
	}

	var_0F = 0;
	if(isdefined(self.var_D76F) && isdefined(self.var_D76F[param_00]))
	{
		var_10 = self.var_D76F[param_00];
		var_11 = func_D720(var_10);
		if(var_11 > 0)
		{
			var_12 = var_0D.var_3D23 * var_0E.var_461D;
			var_0D.var_3D23 = int(var_12 - var_11 / var_0E.var_461D);
			if(var_0D.var_3D23 < 0)
			{
				var_0D.var_3D23 = 0;
			}

			var_0F = var_11;
			while(var_0F > var_0E.var_461D)
			{
				var_0F = var_0F - var_0E.var_461D;
			}
		}
	}

	if(param_01 == "scripted")
	{
		return;
	}

	var_0D.var_13CE0 = undefined;
	if(var_0E.var_13CE0 == "<power_script_generic_weapon>")
	{
		var_0D.var_13CE0 = scripts\common\utility::func_116D7(param_01 == "primary","power_script_generic_primary_mp","power_script_generic_secondary_mp");
	}
	else
	{
		var_0D.var_13CE0 = var_0E.var_13CE0;
	}

	var_13 = func_8090(param_00);
	var_14 = scripts\common\utility::func_116D7(isdefined(var_13),var_13,var_0D.var_13CE0);
	var_0D.var_13CE0 = var_14;
	self giveweapon(var_14,0);
	self setweaponammoclip(var_14,var_0D.var_3D23);
	if(var_0D.var_10307 == "primary")
	{
		self method_844B(var_14);
		self.var_D781 = var_14;
	}
	else if(var_0D.var_10307 == "secondary")
	{
		self method_844C(var_14);
		self.var_D785 = var_14;
	}

	if(isdefined(level.var_D786[param_00]))
	{
		self [[ level.var_D786[param_00] ]](param_00);
	}

	if(isdefined(param_06) && !param_06)
	{
		thread func_E0AD(param_00);
	}

	if(!isai(self))
	{
		thread func_D73D(param_00);
		thread func_B2F0(var_0E,param_00,var_0D.var_10307,var_0E.var_461D,var_0E.var_12ED9,var_0E.var_1307B,var_14,var_0F,param_02);
	}
}

//Function Number: 18
func_E15E(param_00)
{
	if(isdefined(level.var_D79B[param_00]))
	{
		self [[ level.var_D79B[param_00] ]]();
	}

	if(isdefined(self.var_D782[param_00].var_13CE0))
	{
		self takeweapon(self.var_D782[param_00].var_13CE0);
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
	func_13F00(self.var_D782[param_00].var_10307);
	self.var_D782[param_00] = undefined;
}

//Function Number: 19
func_13F00(param_00)
{
	if(param_00 == "scripted")
	{
		return;
	}

	self setclientomnvar(scripts\cp\zombies\_powerup_ability::func_D78F(param_00,2),0);
	self setclientomnvar(scripts\cp\zombies\_powerup_ability::func_D78F(param_00,1),0);
	self setclientomnvar(scripts\cp\zombies\_powerup_ability::func_D78F(param_00,0),-1);
	self setclientomnvar(scripts\cp\zombies\_powerup_ability::func_D78F(param_00,3),0);
}

//Function Number: 20
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

//Function Number: 21
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

//Function Number: 22
func_D720(param_00)
{
	var_01 = level.var_D782[param_00.var_D719];
	var_02 = param_00.var_B486 - param_00.var_3D23 * var_01.var_461D - var_01.var_461D - param_00.var_4619;
	var_03 = gettime() - param_00.var_11931 / 1000;
	return max(0,var_02 - var_03);
}

//Function Number: 23
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

//Function Number: 24
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

//Function Number: 25
func_4171(param_00)
{
	var_01 = self.var_D782;
	var_02 = func_D739();
	foreach(var_04 in var_02)
	{
		if(var_01[var_04].var_10307 == param_00)
		{
			self.var_D782[var_04] = undefined;
			self notify("clear_power_slot" + var_04);
			func_E15E(var_04);
		}
	}

	func_13F00(param_00);
}

//Function Number: 26
func_13CFC(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	var_03 = getarraykeys(self.var_D782);
	foreach(var_05 in var_03)
	{
		if(isdefined(self.var_D782[var_05].var_10307) && self.var_D782[var_05].var_10307 == param_00)
		{
			var_02 = var_05;
			return var_02;
		}
	}

	return undefined;
}

//Function Number: 27
func_D735(param_00)
{
	return scripts\common\utility::func_116D7(self.var_D782[param_00].var_10307 == "primary","+frag","+smoke");
}

//Function Number: 28
func_D725(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = level.var_D782[param_00];
	var_06 = spawnstruct();
	var_06.var_10307 = param_01;
	var_06.var_3D23 = var_05.var_B486;
	if(scripts\common\utility::istrue(param_02))
	{
		var_06.var_3D23++;
	}

	var_06.var_B486 = var_06.var_3D23;
	var_06.var_93DD = 0;
	var_06.var_19 = 0;
	var_06.var_4619 = 0;
	var_06.var_461B = 1;
	var_06.var_4613 = param_03;
	var_06.permanent = param_04;
	var_06.var_C946 = [];
	self.var_D782[param_00] = var_06;
}

//Function Number: 29
func_B2F0(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08)
{
	self endon("death");
	self endon("disconnect");
	self endon("powers_cleanUp");
	self endon("power_removed_" + param_01);
	level endon("game_ended");
	if((isdefined(param_08) && param_08) || param_01 == "power_copycatGrenade")
	{
		self endon("start_copycat");
	}

	self endon("clear_power_slot" + param_01);
	scripts\cp\zombies\_powerup_ability::func_D789(param_02,int(param_00.var_92B8),1,int(self.var_D782[param_01].var_3D23));
	scripts\cp\_utility::func_7670("prematch_done");
	func_D750(param_02,2);
	for(;;)
	{
		if(scripts\cp\_laststand::player_in_laststand(self))
		{
			scripts\common\utility::waittill_any_3("revive","revive_success","challenge_complete_revive");
		}

		func_D765(param_01);
		var_09 = param_06 + "_success";
		thread func_13A0E(param_03,param_01,var_09);
		var_0A = scripts\common\utility::func_116D7(param_00.var_130F3 == "weapon_hold","offhand_pullback","offhand_fired");
		self waittill(var_0A,var_0B);
		if(var_0B != param_06)
		{
			continue;
		}

		param_03 = func_808D(param_00);
		self notify(var_09);
		if(self.var_D782[param_01].var_3D23 != 0 && !self.var_D782[param_01].var_19)
		{
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

			if(!isdefined(self.var_594F) || self.var_594F != param_01)
			{
				if(!func_9EE3(param_01) && !isdefined(self.var_11817))
				{
					func_D71A(-1,self.var_D782[param_01].var_10307);
				}
			}
		}

		if(isdefined(param_04) && level.var_D782[param_01].var_12B2B == "drain" && !scripts\common\utility::istrue(self.var_D782[param_01].var_940B))
		{
			func_D72B(param_01);
		}

		thread func_D72A(param_01,param_03,param_08);
	}
}

//Function Number: 30
func_9EE3(param_00)
{
	switch(param_00)
	{
		case "power_clusterGrenade":
		case "power_frag":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 31
func_808D(param_00)
{
	if(scripts\common\utility::istrue(level.var_D788))
	{
		return 0.1;
	}

	if(scripts\common\utility::istrue(level.var_94A8))
	{
		return 2.5;
	}

	if(scripts\cp\_utility::func_9BA0("grenade_cooldown"))
	{
		return param_00.var_461D;
	}

	return param_00.var_461D;
}

//Function Number: 32
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

//Function Number: 33
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
			func_D71A(1,var_03);
		}

		var_05 = var_01.var_91B1;
		if(var_05 == 1)
		{
			func_D750(var_03,2);
		}
	}
}

//Function Number: 34
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

//Function Number: 35
func_E0AD(param_00)
{
	self endon("disconnect");
	self endon("power_removed_" + param_00);
	level endon("game_ended");
	var_01 = self.var_D782[param_00];
	while(isdefined(self.var_D782[param_00]))
	{
		self waittill("power_used " + param_00);
		if(scripts\common\utility::istrue(level.var_D788))
		{
			continue;
		}

		if(var_01.var_3D23 < 1)
		{
			while(self method_81C2() || scripts\common\utility::func_2286(self.var_D783,param_00))
			{
				wait(0.25);
			}

			wait(0.25);
			thread func_E15E(param_00);
		}
	}
}

//Function Number: 36
func_D752(param_00)
{
	if(!isdefined(self.var_D782[param_00]))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(self.var_D782[param_00].var_4613))
	{
		return 1;
	}

	if(scripts\common\utility::istrue(level.var_D788))
	{
		return 1;
	}

	if(level.var_D782[param_00].var_13058)
	{
		return 1;
	}

	if(isdefined(self.var_D782[param_00].var_10307) && self.var_D782[param_00].var_10307 != "primary")
	{
		return 0;
	}

	if(scripts\cp\_utility::func_9BA0("grenade_cooldown") && level.var_D782[param_00].var_504B != "secondary")
	{
		return 1;
	}

	if(scripts\common\utility::istrue(level.var_94A8))
	{
		return 1;
	}

	return 0;
}

//Function Number: 37
func_160E(param_00)
{
	self.var_D783[self.var_D783.size] = param_00;
}

//Function Number: 38
func_4DE0(param_00)
{
	if(scripts\common\utility::func_2286(self.var_D783,param_00))
	{
		self.var_D783 = scripts\common\utility::func_22A9(self.var_D783,param_00);
	}
}

//Function Number: 39
func_D72A(param_00,param_01,param_02)
{
	self endon("death");
	self endon("disconnect");
	self endon("powers_cleanUp");
	self endon("power_removed_" + param_00);
	self endon("power_cooldown_ended" + param_00);
	if((isdefined(param_02) && param_02) || param_00 == "power_copycatGrenade")
	{
		self endon("start_copycat");
	}

	self endon("clear_power_slot" + param_00);
	self notify("power_cooldown_begin_" + param_00);
	self endon("power_cooldown_begin_" + param_00);
	level endon("game_ended");
	var_03 = level.var_D782[param_00];
	var_04 = self.var_D782[param_00];
	var_05 = var_04.var_10307;
	var_06 = param_00 + "_cooldown_update";
	var_04.var_93DD = 1;
	if(!isdefined(var_04.var_461C))
	{
		var_04.var_461C = 0;
	}

	var_04.var_461C++;
	if(!isdefined(var_04.var_4617))
	{
		var_04.var_4617 = 0;
	}

	if(!isdefined(var_04.var_4619))
	{
		var_04.var_4619 = 0;
	}

	var_04.var_4619 = var_04.var_4619 + param_01;
	var_07 = var_04.var_91B1;
	if(isdefined(var_07) && var_07 != 0 && var_04.var_3D23 == 0)
	{
		func_D750(var_05,1);
	}

	while(var_04.var_3D23 < var_04.var_B486)
	{
		if(func_D752(param_00))
		{
			wait(0.1);
		}
		else
		{
			level scripts\common\utility::waittill_any_3("grenade_cooldown activated","infinite_grenade_active","start_power_cooldown");
			param_01 = func_808D(var_03);
		}

		if(var_04.var_4617 > param_01)
		{
			func_D71A(1,var_05);
			func_D765(param_00);
			if(var_04.var_3D23 == var_04.var_B486)
			{
				thread func_D730(param_00,param_02);
			}

			var_04.var_4617 = var_04.var_4617 - param_01;
			var_04.var_4619 = var_04.var_4619 - param_01;
			var_04.var_461C--;
			if(isdefined(var_07) && var_07 != 0)
			{
				func_D750(var_05,2);
			}
		}
		else
		{
			var_04.var_4617 = var_04.var_4617 + 0.1;
			var_04.var_4619 = var_04.var_4619 - 0.1;
		}

		var_08 = min(1,var_04.var_4617 / param_01);
		self notify(var_06,var_08);
	}

	thread func_D730(param_00,param_02);
}

//Function Number: 40
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

//Function Number: 41
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

//Function Number: 42
func_D732(param_00,param_01,param_02)
{
	self endon("disconnect");
	self endon("powers_cleanUp");
	self endon("power_removed_" + param_00);
	self endon("power_drain_ended_" + param_00);
	self waittill(param_02);
	thread func_D731(param_00);
}

//Function Number: 43
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

//Function Number: 44
func_F85A(param_00)
{
	self.var_D782[param_00].var_13153 = 0;
}

//Function Number: 45
func_12D35()
{
}

//Function Number: 46
func_130DA()
{
}

//Function Number: 47
func_F7E2(param_00)
{
}

//Function Number: 48
func_12D07()
{
	lib_0D12::func_E154();
}

//Function Number: 49
func_130BC()
{
	lib_0D12::func_E88D();
}

//Function Number: 50
func_12D2C()
{
}

//Function Number: 51
func_130D5()
{
}

//Function Number: 52
func_F676(param_00)
{
}

//Function Number: 53
func_12C89()
{
}

//Function Number: 54
func_13051()
{
}

//Function Number: 55
func_F896(param_00)
{
}

//Function Number: 56
func_12D50()
{
	self notify("detonate_transponder");
}

//Function Number: 57
func_F776(param_00)
{
	level.var_D782[param_00].var_5FF3 = 3;
}

//Function Number: 58
func_12CE0()
{
}

//Function Number: 59
func_1309C()
{
	lib_0D0E::func_E85E();
}

//Function Number: 60
func_F6B1(param_00)
{
	self method_8412(1);
	self.var_38A1 = 1;
	self method_8454(3);
}

//Function Number: 61
func_12C9F()
{
	self method_8412(0);
	self.var_38A1 = 0;
}

//Function Number: 62
func_13072()
{
}

//Function Number: 63
func_F7C8(param_00)
{
}

//Function Number: 64
func_12CFB()
{
}

//Function Number: 65
func_130B4()
{
}

//Function Number: 66
func_F7E7(param_00)
{
}

//Function Number: 67
func_12D0B()
{
}

//Function Number: 68
func_130BD()
{
}

//Function Number: 69
func_F693(param_00)
{
}

//Function Number: 70
func_12C90()
{
}

//Function Number: 71
func_13054()
{
}

//Function Number: 72
func_F87E(param_00)
{
}

//Function Number: 73
func_12D44()
{
}

//Function Number: 74
func_130E7()
{
}

//Function Number: 75
func_F7CC(param_00)
{
}

//Function Number: 76
func_12CFD()
{
}

//Function Number: 77
func_130B8()
{
}

//Function Number: 78
func_F84A(param_00)
{
}

//Function Number: 79
func_12D30()
{
}

//Function Number: 80
func_130D7()
{
}

//Function Number: 81
func_F69C(param_00)
{
}

//Function Number: 82
func_12C98(param_00)
{
}

//Function Number: 83
func_13055()
{
}

//Function Number: 84
func_F84C(param_00)
{
}

//Function Number: 85
func_12D31()
{
}

//Function Number: 86
func_130D8()
{
}

//Function Number: 87
func_F87F(param_00)
{
}

//Function Number: 88
func_12D45()
{
}

//Function Number: 89
func_130E8()
{
}

//Function Number: 90
func_F777(param_00)
{
}

//Function Number: 91
func_12CE1()
{
}

//Function Number: 92
func_1309D()
{
}

//Function Number: 93
func_F81A(param_00)
{
}

//Function Number: 94
func_12D18()
{
}

//Function Number: 95
func_130CB()
{
}

//Function Number: 96
func_F658(param_00)
{
	level.var_D782[param_00].var_5FF3 = 30;
}

//Function Number: 97
func_12C78()
{
}

//Function Number: 98
func_13049()
{
}

//Function Number: 99
func_F7A5(param_00)
{
}

//Function Number: 100
func_12CF3()
{
}

//Function Number: 101
func_130A5()
{
}

//Function Number: 102
func_13043()
{
	scripts\cp\powers\coop_armageddon::func_2179();
}

//Function Number: 103
func_F81E(param_00)
{
	lib_0D18::func_F81E();
}

//Function Number: 104
func_12D1B()
{
	lib_0D18::func_12D1B();
}

//Function Number: 105
func_130CE()
{
}

//Function Number: 106
func_130CD()
{
	lib_0D17::func_130CD();
}

//Function Number: 107
func_8C17(param_00)
{
	if(!isdefined(self.var_D782[param_00]))
	{
		return 0;
	}

	return 1;
}

//Function Number: 108
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

//Function Number: 109
func_D740(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = "all";
	}

	var_02 = func_D739();
	foreach(var_04 in var_02)
	{
		if((isdefined(self.var_D782[var_04].var_10307) && self.var_D782[var_04].var_10307 == param_01) || param_01 == "all")
		{
			self.var_D782[var_04].var_461B = param_00;
		}
	}
}

//Function Number: 110
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

//Function Number: 111
func_D71A(param_00,param_01,param_02)
{
	if(!isdefined(param_01))
	{
		param_01 = "all";
	}

	var_03 = func_D739();
	var_04 = param_00;
	foreach(var_06 in var_03)
	{
		if(!isdefined(param_00))
		{
			var_04 = level.var_D782[var_06].var_B486;
		}

		if(self.var_D782[var_06].var_10307 == param_01 || param_01 == "all")
		{
			if(isdefined(param_02))
			{
				self.var_D782[var_06].var_3D23 = int(min(var_04,level.var_D782[var_06].var_B486));
			}
			else if(self.var_D782[var_06].var_3D23 + var_04 >= 0)
			{
				self.var_D782[var_06].var_3D23 = self.var_D782[var_06].var_3D23 + var_04;
			}
			else
			{
				self.var_D782[var_06].var_3D23 = 0;
			}

			self.var_D782[var_06].var_3D23 = int(clamp(self.var_D782[var_06].var_3D23,0,level.var_D782[var_06].var_B486));
			self setweaponammoclip(self.var_D782[var_06].var_13CE0,self.var_D782[var_06].var_3D23);
			self notify("power_used " + var_06);
			scripts\cp\zombies\_powerup_ability::func_D791(self.var_D782[var_06].var_10307,self.var_D782[var_06].var_3D23);
		}
	}
}

//Function Number: 112
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

//Function Number: 113
func_D728(param_00)
{
	if(scripts\common\utility::func_9EC1())
	{
		scripts\common\utility::func_1C58(0);
	}
}

//Function Number: 114
func_D72E(param_00)
{
	if(!scripts\common\utility::func_9EC1())
	{
		scripts\common\utility::func_1C58(1);
	}
}

//Function Number: 115
func_130C3(param_00)
{
	scripts\cp\_utility::func_12C6(param_00);
	self switchtoweapon(param_00);
	wait(1);
	self switchtoweapon(param_00);
	self takeweapon(param_00);
}

//Function Number: 116
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

//Function Number: 117
func_808F(param_00)
{
	func_50A4(param_00);
	return self.var_D775[param_00];
}

//Function Number: 118
func_F809(param_00,param_01)
{
	func_50A4(param_00);
	self.var_D775[param_00] = param_01;
}

//Function Number: 119
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

//Function Number: 120
func_3885(param_00)
{
	func_F809(param_00,0);
	self notify("cancel_" + param_00);
	func_C170(param_00,0);
}

//Function Number: 121
func_C170(param_00,param_01)
{
	self notify(param_00,param_01);
}

//Function Number: 122
func_13A0E(param_00,param_01,param_02)
{
	self endon("disconnect");
	self endon("powers_cleanUp");
	self endon("power_removed_" + param_01);
	self endon(param_02);
	level endon("game_ended");
	self waittill("offhand_fired",var_03);
	var_04 = self.var_D782[param_01];
	if(isdefined(var_03) && var_03 == var_04.var_13CE0)
	{
		if(!isalive(self))
		{
			if(var_04.var_3D23 > 0)
			{
				func_D71A(-1,var_04.var_10307);
			}

			if(!var_04.var_93DD)
			{
				var_04.var_4619 = level.var_D782[param_01].var_461D;
				thread func_D72A(param_01,param_00);
				return;
			}
		}
	}
}

//Function Number: 123
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

//Function Number: 124
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

//Function Number: 125
func_13A7D(param_00,param_01)
{
	self endon("power_use_update_" + param_00);
	self waittill(param_01,var_02);
	self notify("power_use_update_" + param_00,var_02);
}

//Function Number: 126
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

//Function Number: 127
func_9F09(param_00)
{
	if((param_00 == "+frag" && self fragbuttonpressed()) || param_00 == "+smoke" && self secondaryoffhandbuttonpressed())
	{
		return 1;
	}

	return 0;
}

//Function Number: 128
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

//Function Number: 129
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

//Function Number: 130
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

		case "ztransponder_mp":
		case "transponder_mp":
			self.var_222 notify("transponder_update",0);
			break;

		case "sticky_mine_mp":
			self.var_222 notify("sticky_mine_update",0);
			break;

		case "sonic_sensor_mp":
			self.var_222 notify("sonic_sensor_update",0);
			break;

		case "trophy_mp":
			self.var_222 notify("trophy_update",0);
			break;

		case "cryo_grenade_mp":
			self.var_222 notify("restart_cryo_grenade_cooldown",0);
			break;

		case "micro_turret_zm":
		case "micro_turret_mp":
			self.var_222 notify("microTurret_update",0);
			break;

		default:
			break;
	}
}

//Function Number: 131
func_9F0A(param_00)
{
	switch(param_00)
	{
		case "armorup_mp":
		case "iw7_niagara_mp":
			return 1;

		default:
			return 0;
	}
}

//Function Number: 132
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

//Function Number: 133
func_D76C(param_00)
{
	self endon("power_available_ended_" + param_00);
	var_01 = self.var_D782[param_00];
	var_02 = var_01.var_10307;
	for(;;)
	{
		self waittill("power_charges_adjusted_" + param_00,var_03);
		scripts\cp\zombies\_powerup_ability::func_D791(var_02,var_03);
	}
}

//Function Number: 134
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

//Function Number: 135
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

//Function Number: 136
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

//Function Number: 137
func_D72D(param_00)
{
	var_01 = self.var_D782[param_00];
	var_01.var_55AB--;
	if(var_01.var_55AB == 0)
	{
		func_D765(param_00);
	}
}

//Function Number: 138
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

//Function Number: 139
func_7952(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_02.origin;
	if(!isdefined(var_05))
	{
		return 0;
	}

	var_06 = vectornormalize(var_05 - param_00);
	if(!isdefined(param_04) || param_04 == "forward")
	{
		var_07 = anglestoforward(param_01);
	}
	else
	{
		var_07 = anglestoright(param_02);
	}

	var_08 = vectordot(var_07,var_06);
	return var_08 >= param_03;
}

//Function Number: 140
func_82F7(param_00,param_01)
{
	var_02 = param_00.var_D742;
	var_03 = level.var_D782[var_02].var_504B;
	param_01 thread func_8397(var_02,var_03,undefined,undefined,undefined,0,0);
	param_01 playlocalsound("grenade_pickup");
	param_01 notify("new_power",var_02);
}

//Function Number: 141
func_8319(param_00,param_01)
{
	var_02 = param_00.var_D742;
	var_03 = level.var_D782[var_02].var_504B;
	param_01 thread func_8397(var_02,var_03,undefined,undefined,undefined,0,1);
	param_01 playlocalsound("grenade_pickup");
	param_01 notify("new_power",var_02);
}

//Function Number: 142
power_watch_hint(param_00)
{
	self endon("disconnect");
	self endon("death");
	level endon("game_ended");
	self.var_1268B = 0;
	self.var_B702 = 0;
	self.var_E4C6 = 0;
	self.var_F18D = 0;
	self.var_CAAB = 0;
	self.var_3CE6 = 0;
	self.var_2176 = 0;
	self.var_A6D6 = 0;
	self.var_A871 = 0;
	self.var_2690 = 0;
	self.var_936B = 0;
	self.var_B53E = 0;
	self.var_6018 = 0;
	self.var_2C9F = 0;
	self.var_E4B3 = 0;
	self.var_76C6 = 0;
	self.var_10487 = 0;
	self.mower_hint_displayed = 0;
	self.balloon_hint_displayed = 0;
	self.robot_hint_displayed = 0;
	self.lavalamp_hint_displayed = 0;
	self.zombgone_hint_displayed = 0;
	self.rad_extractor_hint_displayed = 0;
	param_00 = scripts\common\utility::istrue(param_00);
	for(;;)
	{
		self waittill("new_power",var_01);
		wait(1);
		switch(var_01)
		{
			case "power_transponder":
				if(self.var_1268B < 3 && !param_00)
				{
					scripts\cp\_utility::setlowermessage("msg_power_hint",&"CP_ZMB_INTERACTIONS_HINT_TRANSPONDER",4);
					self.var_1268B = self.var_1268B + 1;
				}
				break;
	
			case "power_rewind":
				if(self.var_E4C6 < 3 && !param_00)
				{
					scripts\cp\_utility::setlowermessage("msg_power_hint",&"CP_ZMB_INTERACTIONS_HINT_REWIND",4);
					self.var_E4C6 = self.var_E4C6 + 1;
				}
				break;
	
			case "power_microTurret":
				if(self.var_B702 < 3 && !param_00)
				{
					scripts\cp\_utility::setlowermessage("msg_power_hint",&"CP_ZMB_INTERACTIONS_HINT_MICROTURRET",4);
					self.var_B702 = self.var_B702 + 1;
				}
				break;
	
			case "power_siegeMode":
				if(self.var_F18D < 3 && !param_00)
				{
					scripts\cp\_utility::setlowermessage("msg_power_hint",&"CP_ZMB_INTERACTIONS_HINT_SIEGEMODE",4);
					self.var_F18D = self.var_F18D + 1;
				}
				break;
	
			case "power_phaseShift":
				if(self.var_CAAB < 3 && !param_00)
				{
					scripts\cp\_utility::setlowermessage("msg_power_hint",&"CP_ZMB_INTERACTIONS_HINT_PHASESHIFT",4);
					self.var_CAAB = self.var_CAAB + 1;
				}
				break;
	
			case "power_chargeMode":
				if(self.var_3CE6 < 3 && !param_00)
				{
					scripts\cp\_utility::setlowermessage("msg_power_hint",&"CP_ZMB_INTERACTIONS_HINT_CHARGEMODE",4);
					self.var_3CE6 = self.var_3CE6 + 1;
				}
				break;
	
			case "power_armageddon":
				if(self.var_2176 < 3 && !param_00)
				{
					scripts\cp\_utility::setlowermessage("msg_power_hint",&"CP_ZMB_INTERACTIONS_HINT_ARMAGEDDON",4);
					self.var_2176 = self.var_2176 + 1;
				}
				break;
	
			case "power_kineticPulse":
				if(self.var_A6D6 < 3 && !param_00)
				{
					scripts\cp\_utility::setlowermessage("msg_power_hint",&"CP_ZMB_INTERACTIONS_HINT_KINETICPULSE",4);
					self.var_A6D6 = self.var_A6D6 + 1;
				}
				break;
	
			case "crafted_windowtrap":
				if(self.var_A871 < 3)
				{
					scripts\cp\_utility::setlowermessage("msg_power_hint",&"ZOMBIE_CRAFTING_SOUVENIRS_HINT_LASER_WINDOW_TRAP",4);
					self.var_A871 = self.var_A871 + 1;
				}
				break;
	
			case "crafted_autosentry":
				if(self.var_2690 < 3)
				{
					scripts\cp\_utility::setlowermessage("msg_power_hint",&"ZOMBIE_CRAFTING_SOUVENIRS_HINT_AUTOSENTRY",4);
					self.var_2690 = self.var_2690 + 1;
				}
				break;
	
			case "crafted_ims":
				if(self.var_936B < 3)
				{
					scripts\cp\_utility::setlowermessage("msg_power_hint",&"ZOMBIE_CRAFTING_SOUVENIRS_HINT_IMS",4);
					self.var_936B = self.var_936B + 1;
				}
				break;
	
			case "crafted_medusa":
				if(self.var_B53E < 3)
				{
					scripts\cp\_utility::setlowermessage("msg_power_hint",&"ZOMBIE_CRAFTING_SOUVENIRS_HINT_MEDUSA",4);
					self.var_B53E = self.var_B53E + 1;
				}
				break;
	
			case "crafted_electric_trap":
				if(self.var_6018 < 3)
				{
					scripts\cp\_utility::setlowermessage("msg_power_hint",&"ZOMBIE_CRAFTING_SOUVENIRS_HINT_ELECTRICTRAP",4);
					self.var_6018 = self.var_6018 + 1;
				}
				break;
	
			case "crafted_boombox":
				if(self.var_2C9F < 3)
				{
					scripts\cp\_utility::setlowermessage("msg_power_hint",&"ZOMBIE_CRAFTING_SOUVENIRS_HINT_BOOMBOX",4);
					self.var_6018 = self.var_6018 + 1;
				}
				break;
	
			case "crafted_revocator":
				if(self.var_E4B3 < 3)
				{
					scripts\cp\_utility::setlowermessage("msg_power_hint",&"ZOMBIE_CRAFTING_SOUVENIRS_HINT_REVOCATOR",4);
					self.var_E4B3 = self.var_E4B3 + 1;
				}
				break;
	
			case "crafted_gascan":
				if(self.var_76C6 < 3)
				{
					scripts\cp\_utility::setlowermessage("msg_power_hint",&"ZOMBIE_CRAFTING_SOUVENIRS_HINT_GASCAN",4);
					self.var_76C6 = self.var_76C6 + 1;
				}
				break;
	
			case "crafted_trap_mower":
				if(self.mower_hint_displayed < 2)
				{
					scripts\cp\_utility::setlowermessage("msg_power_hint",&"CP_RAVE_HINT_MOWER",4);
					self.mower_hint_displayed = self.mower_hint_displayed + 1;
				}
				break;
	
			case "crafted_trap_balloon":
				if(self.balloon_hint_displayed < 2)
				{
					scripts\cp\_utility::setlowermessage("msg_power_hint",&"CP_RAVE_HINT_BALLOONS",4);
					self.balloon_hint_displayed = self.balloon_hint_displayed + 1;
				}
				break;
	
			case "crafted_robot":
				if(self.robot_hint_displayed < 2)
				{
					scripts\cp\_utility::setlowermessage("msg_power_hint",&"CP_DISCO_USE_ROBOT",4);
					self.robot_hint_displayed = self.robot_hint_displayed + 1;
				}
				break;
	
			case "crafted_lavalamp":
				if(self.lavalamp_hint_displayed < 2)
				{
					scripts\cp\_utility::setlowermessage("msg_power_hint",&"CP_DISCO_USE_LAVA_LAMP",4);
					self.lavalamp_hint_displayed = self.lavalamp_hint_displayed + 1;
				}
				break;
	
			case "crafted_rad_extractor":
				if(self.rad_extractor_hint_displayed < 2)
				{
					scripts\cp\_utility::setlowermessage("msg_power_hint",&"CP_DISCO_USE_LAVA_LAMP",4);
					self.rad_extractor_hint_displayed = self.rad_extractor_hint_displayed + 1;
				}
				break;
	
			case "crafted_zombgone":
				if(self.zombgone_hint_displayed < 2)
				{
					scripts\cp\_utility::setlowermessage("msg_power_hint",&"CP_DISCO_USE_ZOMBGONE",4);
					self.zombgone_hint_displayed = self.zombgone_hint_displayed + 1;
				}
				break;
		}
	}
}

//Function Number: 143
func_7A3C(param_00)
{
	var_01 = [];
	foreach(var_03 in getarraykeys(param_00.var_D782))
	{
		var_04 = spawnstruct();
		var_04.var_10307 = param_00.var_D782[var_03].var_10307;
		var_04.var_3D23 = param_00.var_D782[var_03].var_3D23;
		var_04.var_4613 = param_00.var_D782[var_03].var_4613;
		var_04.permanent = param_00.var_D782[var_03].permanent;
		var_01[var_03] = var_04;
	}

	return var_01;
}

//Function Number: 144
func_E2D1(param_00,param_01)
{
	foreach(var_06, var_03 in param_01)
	{
		var_04 = undefined;
		var_05 = 0;
		if(scripts\common\utility::istrue(var_03.var_4613))
		{
			var_04 = 1;
		}

		if(scripts\common\utility::istrue(var_03.permanent))
		{
			var_05 = 1;
		}

		if(var_03.var_10307 == "secondary")
		{
			if(var_06 == "power_bait")
			{
				param_00 func_8397(var_06,var_03.var_10307,undefined,undefined,undefined,1,1);
			}
			else
			{
				param_00 func_8397(var_06,var_03.var_10307,undefined,undefined,undefined,var_04,var_05);
			}

			param_00 func_D71A(var_03.var_3D23,var_03.var_10307,1);
			continue;
		}

		param_00 func_8397(var_06,var_03.var_10307,undefined,undefined,undefined,undefined,1);
		param_00 func_D71A(var_03.var_3D23,var_03.var_10307,1);
	}
}

//Function Number: 145
giveholywater(param_00)
{
	scripts\cp\powers\coop_holywater::giveholywater();
}

//Function Number: 146
takeholywater(param_00)
{
	scripts\cp\powers\coop_holywater::takeholywater();
}