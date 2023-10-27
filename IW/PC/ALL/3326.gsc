/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3326.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 25
 * Decompile Time: 10 ms
 * Timestamp: 10/27/2023 12:26:33 AM
*******************************************************************/

//Function Number: 1
func_98B1()
{
	func_958F();
}

//Function Number: 2
func_96CF()
{
	if(!isdefined(level.var_1B8F))
	{
		level.var_1B8F = "cp/alien/perks_tree.csv";
	}

	level.var_1B8E = [];
	func_12E03(0,"perk_0");
	func_12E03(100,"perk_1");
	func_12E03(200,"perk_2");
}

//Function Number: 3
func_976C()
{
	level.var_462C = [];
	func_DECD("perk_health",::lib_0CFD::func_F4DD,::lib_0CFD::func_12C21);
	func_DECD("perk_health_1",::lib_0CFD::func_F4DE,::lib_0CFD::func_12C22);
	func_DECD("perk_health_2",::lib_0CFD::func_F4DF,::lib_0CFD::func_12C23);
	func_DECD("perk_health_3",::lib_0CFD::func_F4E0,::lib_0CFD::func_12C24);
	func_DECD("perk_health_4",::lib_0CFD::func_F4E1,::lib_0CFD::func_12C25);
	func_DECD("perk_pistol_znrg",::lib_0CFD::func_F50B,::lib_0CFD::func_12C4F);
	func_DECD("perk_pistol_znrg_1",::lib_0CFD::func_F50C,::lib_0CFD::func_12C50);
	func_DECD("perk_pistol_znrg_2",::lib_0CFD::func_F50D,::lib_0CFD::func_12C51);
	func_DECD("perk_pistol_znrg_3",::lib_0CFD::func_F50E,::lib_0CFD::func_12C52);
	func_DECD("perk_pistol_znrg_4",::lib_0CFD::func_F50F,::lib_0CFD::func_12C53);
	func_DECD("perk_pistol_magnum",::lib_0CFD::func_F4F2,::lib_0CFD::func_12C36);
	func_DECD("perk_pistol_magnum_1",::lib_0CFD::func_F4F3,::lib_0CFD::func_12C37);
	func_DECD("perk_pistol_magnum_2",::lib_0CFD::func_F4F4,::lib_0CFD::func_12C38);
	func_DECD("perk_pistol_magnum_3",::lib_0CFD::func_F4F5,::lib_0CFD::func_12C39);
	func_DECD("perk_pistol_magnum_4",::lib_0CFD::func_F4F6,::lib_0CFD::func_12C3A);
	func_DECD("perk_pistol_zg18",::lib_0CFD::func_F506,::lib_0CFD::func_12C4A);
	func_DECD("perk_pistol_zg18_1",::lib_0CFD::func_F507,::lib_0CFD::func_12C4B);
	func_DECD("perk_pistol_zg18_2",::lib_0CFD::func_F508,::lib_0CFD::func_12C4C);
	func_DECD("perk_pistol_zg18_3",::lib_0CFD::func_F509,::lib_0CFD::func_12C4D);
	func_DECD("perk_pistol_zg18_4",::lib_0CFD::func_F50A,::lib_0CFD::func_12C4E);
	func_DECD("perk_pistol_zemc",::lib_0CFD::func_F501,::lib_0CFD::func_12C45);
	func_DECD("perk_pistol_zemc_1",::lib_0CFD::func_F502,::lib_0CFD::func_12C46);
	func_DECD("perk_pistol_zemc_2",::lib_0CFD::func_F503,::lib_0CFD::func_12C47);
	func_DECD("perk_pistol_zemc_3",::lib_0CFD::func_F504,::lib_0CFD::func_12C48);
	func_DECD("perk_pistol_zemc_4",::lib_0CFD::func_F505,::lib_0CFD::func_12C49);
	func_DECD("perk_bullet_damage",::lib_0CFD::func_F4CE,::lib_0CFD::func_12C12);
	func_DECD("perk_bullet_damage_1",::lib_0CFD::func_F4CF,::lib_0CFD::func_12C13);
	func_DECD("perk_bullet_damage_2",::lib_0CFD::func_F4D0,::lib_0CFD::func_12C14);
	func_DECD("perk_bullet_damage_3",::lib_0CFD::func_F4D1,::lib_0CFD::func_12C15);
	func_DECD("perk_bullet_damage_4",::lib_0CFD::func_F4D2,::lib_0CFD::func_12C16);
	func_DECD("perk_medic",::lib_0CFD::func_F4E7,::lib_0CFD::func_12C2B);
	func_DECD("perk_medic_1",::lib_0CFD::func_F4E8,::lib_0CFD::func_12C2C);
	func_DECD("perk_medic_2",::lib_0CFD::func_F4E9,::lib_0CFD::func_12C2D);
	func_DECD("perk_medic_3",::lib_0CFD::func_F4EA,::lib_0CFD::func_12C2E);
	func_DECD("perk_medic_4",::lib_0CFD::func_F4EB,::lib_0CFD::func_12C2F);
	func_DECD("perk_rigger",::lib_0CFD::func_F510,::lib_0CFD::func_12C54);
	func_DECD("perk_rigger_1",::lib_0CFD::func_F511,::lib_0CFD::func_12C55);
	func_DECD("perk_rigger_2",::lib_0CFD::func_F512,::lib_0CFD::func_12C56);
	func_DECD("perk_rigger_3",::lib_0CFD::func_F513,::lib_0CFD::func_12C57);
	func_DECD("perk_rigger_4",::lib_0CFD::func_F514,::lib_0CFD::func_12C58);
	func_DECD("perk_robotics",::lib_0CFD::func_F515,::lib_0CFD::func_12C59);
	func_DECD("perk_robotics_1",::lib_0CFD::func_F516,::lib_0CFD::func_12C5A);
	func_DECD("perk_robotics_2",::lib_0CFD::func_F517,::lib_0CFD::func_12C5B);
	func_DECD("perk_robotics_3",::lib_0CFD::func_F518,::lib_0CFD::func_12C5C);
	func_DECD("perk_robotics_4",::lib_0CFD::func_F519,::lib_0CFD::func_12C5D);
	func_DECD("perk_demolition",::lib_0CFD::func_F4D3,::lib_0CFD::func_12C17);
	func_DECD("perk_demolition_1",::lib_0CFD::func_F4D4,::lib_0CFD::func_12C18);
	func_DECD("perk_demolition_2",::lib_0CFD::func_F4D5,::lib_0CFD::func_12C19);
	func_DECD("perk_demolition_3",::lib_0CFD::func_F4D6,::lib_0CFD::func_12C1A);
	func_DECD("perk_demolition_4",::lib_0CFD::func_F4D7,::lib_0CFD::func_12C1B);
	func_DECD("perk_gunslinger",::lib_0CFD::func_F4D8,::lib_0CFD::func_12C1C);
	func_DECD("perk_gunslinger_1",::lib_0CFD::func_F4D9,::lib_0CFD::func_12C1D);
	func_DECD("perk_gunslinger_2",::lib_0CFD::func_F4DA,::lib_0CFD::func_12C1E);
	func_DECD("perk_gunslinger_3",::lib_0CFD::func_F4DB,::lib_0CFD::func_12C1F);
	func_DECD("perk_gunslinger_4",::lib_0CFD::func_F4DC,::lib_0CFD::func_12C20);
	func_DECD("perk_hybrid",::lib_0CFD::func_F4E2,::lib_0CFD::func_12C26);
	func_DECD("perk_hybrid_1",::lib_0CFD::func_F4E3,::lib_0CFD::func_12C27);
	func_DECD("perk_hybrid_2",::lib_0CFD::func_F4E4,::lib_0CFD::func_12C28);
	func_DECD("perk_hybrid_3",::lib_0CFD::func_F4E5,::lib_0CFD::func_12C29);
	func_DECD("perk_hybrid_4",::lib_0CFD::func_F4E6,::lib_0CFD::func_12C2A);
	func_DECD("perk_none",::lib_0CFD::func_F4EC,::lib_0CFD::func_12C30);
	func_DECD("perk_none_1",::lib_0CFD::func_F4EC,::lib_0CFD::func_12C30);
	func_DECD("perk_none_2",::lib_0CFD::func_F4EC,::lib_0CFD::func_12C30);
	func_DECD("perk_none_3",::lib_0CFD::func_F4EC,::lib_0CFD::func_12C30);
	func_DECD("perk_none_4",::lib_0CFD::func_F4EC,::lib_0CFD::func_12C30);
}

//Function Number: 4
func_97B6()
{
	level.var_462C = [];
	func_DECD("perk_health",::func_2B53,::func_2B53);
	func_DECD("perk_health_1",::func_2B53,::func_2B53);
	func_DECD("perk_health_2",::func_2B53,::func_2B53);
	func_DECD("perk_health_3",::func_2B53,::func_2B53);
	func_DECD("perk_health_4",::func_2B53,::func_2B53);
	func_DECD("perk_pistol_znrg",::func_2B53,::func_2B53);
	func_DECD("perk_pistol_znrg_1",::func_2B53,::func_2B53);
	func_DECD("perk_pistol_znrg_2",::func_2B53,::func_2B53);
	func_DECD("perk_pistol_znrg_3",::func_2B53,::func_2B53);
	func_DECD("perk_pistol_znrg_4",::func_2B53,::func_2B53);
	func_DECD("perk_pistol_magnum",::func_2B53,::func_2B53);
	func_DECD("perk_pistol_magnum_1",::func_2B53,::func_2B53);
	func_DECD("perk_pistol_magnum_2",::func_2B53,::func_2B53);
	func_DECD("perk_pistol_magnum_3",::func_2B53,::func_2B53);
	func_DECD("perk_pistol_magnum_4",::func_2B53,::func_2B53);
	func_DECD("perk_pistol_zg18",::func_2B53,::func_2B53);
	func_DECD("perk_pistol_zg18_1",::func_2B53,::func_2B53);
	func_DECD("perk_pistol_zg18_2",::func_2B53,::func_2B53);
	func_DECD("perk_pistol_zg18_3",::func_2B53,::func_2B53);
	func_DECD("perk_pistol_zg18_4",::func_2B53,::func_2B53);
	func_DECD("perk_pistol_zemc",::func_2B53,::func_2B53);
	func_DECD("perk_pistol_zemc_1",::func_2B53,::func_2B53);
	func_DECD("perk_pistol_zemc_2",::func_2B53,::func_2B53);
	func_DECD("perk_pistol_zemc_3",::func_2B53,::func_2B53);
	func_DECD("perk_pistol_zemc_4",::func_2B53,::func_2B53);
	func_DECD("perk_bullet_damage",::func_2B53,::func_2B53);
	func_DECD("perk_bullet_damage_1",::func_2B53,::func_2B53);
	func_DECD("perk_bullet_damage_2",::func_2B53,::func_2B53);
	func_DECD("perk_bullet_damage_3",::func_2B53,::func_2B53);
	func_DECD("perk_bullet_damage_4",::func_2B53,::func_2B53);
	func_DECD("perk_medic",::func_2B53,::func_2B53);
	func_DECD("perk_medic_1",::func_2B53,::func_2B53);
	func_DECD("perk_medic_2",::func_2B53,::func_2B53);
	func_DECD("perk_medic_3",::func_2B53,::func_2B53);
	func_DECD("perk_medic_4",::func_2B53,::func_2B53);
	func_DECD("perk_rigger",::func_2B53,::func_2B53);
	func_DECD("perk_rigger_1",::func_2B53,::func_2B53);
	func_DECD("perk_rigger_2",::func_2B53,::func_2B53);
	func_DECD("perk_rigger_3",::func_2B53,::func_2B53);
	func_DECD("perk_rigger_4",::func_2B53,::func_2B53);
	func_DECD("perk_robotics",::func_2B53,::func_2B53);
	func_DECD("perk_robotics_1",::func_2B53,::func_2B53);
	func_DECD("perk_robotics_2",::func_2B53,::func_2B53);
	func_DECD("perk_robotics_3",::func_2B53,::func_2B53);
	func_DECD("perk_robotics_4",::func_2B53,::func_2B53);
	func_DECD("perk_demolition",::func_2B53,::func_2B53);
	func_DECD("perk_demolition_1",::func_2B53,::func_2B53);
	func_DECD("perk_demolition_2",::func_2B53,::func_2B53);
	func_DECD("perk_demolition_3",::func_2B53,::func_2B53);
	func_DECD("perk_demolition_4",::func_2B53,::func_2B53);
	func_DECD("perk_gunslinger",::func_2B53,::func_2B53);
	func_DECD("perk_gunslinger_1",::func_2B53,::func_2B53);
	func_DECD("perk_gunslinger_2",::func_2B53,::func_2B53);
	func_DECD("perk_gunslinger_3",::func_2B53,::func_2B53);
	func_DECD("perk_gunslinger_4",::func_2B53,::func_2B53);
	func_DECD("perk_hybrid",::func_2B53,::func_2B53);
	func_DECD("perk_hybrid_1",::func_2B53,::func_2B53);
	func_DECD("perk_hybrid_2",::func_2B53,::func_2B53);
	func_DECD("perk_hybrid_3",::func_2B53,::func_2B53);
	func_DECD("perk_hybrid_4",::func_2B53,::func_2B53);
	func_DECD("perk_none",::func_2B53,::func_2B53);
	func_DECD("perk_none_1",::func_2B53,::func_2B53);
	func_DECD("perk_none_2",::func_2B53,::func_2B53);
	func_DECD("perk_none_3",::func_2B53,::func_2B53);
	func_DECD("perk_none_4",::func_2B53,::func_2B53);
	if(isdefined(level.var_7674))
	{
		[[ level.var_7674 ]]();
	}
}

//Function Number: 5
func_2B53()
{
}

//Function Number: 6
func_DECD(param_00,param_01,param_02)
{
	var_03 = spawnstruct();
	var_03.var_F286 = param_01;
	var_03.var_12BF4 = param_02;
	level.var_462C[param_00] = var_03;
}

//Function Number: 7
func_12E03(param_00,param_01)
{
	level.var_1B8E[param_01] = [];
	for(var_02 = param_00;var_02 <= param_00 + 100;var_02++)
	{
		var_03 = func_7B7A(var_02);
		if(var_03 == "")
		{
			break;
		}

		if(!isdefined(level.var_1B8E[var_03]))
		{
			var_04 = spawnstruct();
			var_04.var_12F7A = [];
			var_04.var_12BD1 = func_7D30(var_03);
			var_04.name = func_7B06(var_03);
			var_04.var_928E = func_7A26(var_03);
			var_04.var_DE3F = var_03;
			var_04.type = param_01;
			var_04.var_3767 = level.var_462C[var_03];
			var_04.var_28A3 = var_02;
			level.var_1B8E[param_01][var_03] = var_04;
		}

		for(var_05 = var_02;var_05 <= param_00 + 100;var_05++)
		{
			var_06 = func_7B7A(var_05);
			if(var_06 == "")
			{
				break;
			}

			if(var_06 == var_03 || func_9C63(var_03,var_06))
			{
				var_07 = spawnstruct();
				var_07.var_DE3F = var_06;
				var_07.var_525F = func_7936(var_06);
				var_07.var_D634 = func_7BC4(var_06);
				level.var_1B8E[param_01][var_03].var_12F7A[var_05 - var_02] = var_07;
				continue;
			}

			break;
		}

		var_02 = var_05 - 1;
	}
}

//Function Number: 8
func_9C63(param_00,param_01)
{
	if(param_00 == param_01)
	{
		return 0;
	}

	if(!issubstr(param_01,param_00))
	{
		return 0;
	}

	var_02 = strtok(param_00,"_");
	var_03 = strtok(param_01,"_");
	if(var_03.size - var_02.size != 1)
	{
		return 0;
	}

	for(var_04 = 0;var_04 < var_03.size - 1;var_04++)
	{
		if(var_03[var_04] != var_02[var_04])
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 9
func_7B7A(param_00)
{
	return tablelookup(level.var_1B8F,0,param_00,1);
}

//Function Number: 10
func_7B06(param_00)
{
	return tablelookup(level.var_1B8F,1,param_00,4);
}

//Function Number: 11
func_7A26(param_00)
{
	return tablelookup(level.var_1B8F,1,param_00,6);
}

//Function Number: 12
func_7936(param_00)
{
	return tablelookup(level.var_1B8F,1,param_00,5);
}

//Function Number: 13
func_7BC4(param_00)
{
	return int(tablelookup(level.var_1B8F,1,param_00,3));
}

//Function Number: 14
func_7D30(param_00)
{
	return int(tablelookup(level.var_1B8F,1,param_00,2));
}

//Function Number: 15
func_7A50(param_00)
{
	return int(tablelookup(level.var_1B8F,1,param_00,7));
}

//Function Number: 16
func_958F()
{
	level.var_CA60 = [];
	level.var_EF86 = [];
	level.var_CA60 = [];
	level.var_CA66 = [];
	level.var_EF86["specialty_falldamage"] = 1;
	level.var_EF86["specialty_armorpiercing"] = 1;
	level.var_EF86["specialty_gung_ho"] = 1;
	level.var_EF86["specialty_momentum"] = 1;
	level.var_CA60["specialty_momentum"] = ::func_F7A4;
	level.var_CA66["specialty_momentum"] = ::func_12CF2;
	level.var_CA60["specialty_falldamage"] = ::func_F719;
	level.var_CA66["specialty_falldamage"] = ::func_12CC1;
}

//Function Number: 17
func_F719()
{
}

//Function Number: 18
func_12CC1()
{
}

//Function Number: 19
func_F7A4()
{
	thread func_E863();
}

//Function Number: 20
func_E863()
{
	self endon("death");
	self endon("disconnect");
	self endon("momentum_unset");
	for(;;)
	{
		if(self method_81BD())
		{
			func_848B();
			self.var_BCF6 = 1;
			if(isdefined(level.var_BC70))
			{
				self [[ level.var_BC70 ]]();
			}
		}

		wait(0.1);
	}
}

//Function Number: 21
func_848B()
{
	self endon("death");
	self endon("disconnect");
	self endon("momentum_reset");
	self endon("momentum_unset");
	thread func_B944();
	thread func_B943();
	var_00 = 0;
	while(var_00 < 0.08)
	{
		self.var_BCF6 = self.var_BCF6 + 0.01;
		if(isdefined(level.var_BC70))
		{
			self [[ level.var_BC70 ]]();
		}

		wait(0.4375);
		var_00 = var_00 + 0.01;
	}

	self playlocalsound("ftl_phase_in");
	self notify("momentum_max_speed");
	thread momentum_endaftermax();
	self waittill("momentum_reset");
}

//Function Number: 22
momentum_endaftermax()
{
	self endon("momentum_unset");
	self waittill("momentum_reset");
	self playlocalsound("ftl_phase_out");
}

//Function Number: 23
func_B944()
{
	self endon("death");
	self endon("disconnect");
	self endon("momentum_unset");
	for(;;)
	{
		if(!self method_81BD() || self method_81BE() || !self isonground() || self method_8446())
		{
			wait(0.25);
			if(!self method_81BD() || self method_81BE() || !self isonground() || self method_8446())
			{
				self notify("momentum_reset");
				break;
			}
		}

		scripts\common\utility::func_136F7();
	}
}

//Function Number: 24
func_B943()
{
	self endon("death");
	self endon("disconnect");
	self waittill("damage");
	self notify("momentum_reset");
}

//Function Number: 25
func_12CF2()
{
	self notify("momentum_unset");
}