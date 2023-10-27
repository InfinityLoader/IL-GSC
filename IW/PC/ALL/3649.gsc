/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3649.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 48
 * Decompile Time: 5 ms
 * Timestamp: 10/27/2023 12:30:58 AM
*******************************************************************/

//Function Number: 1
func_F701()
{
	level.player method_8320("specialty_fastreload",1);
}

//Function Number: 2
func_12CBC()
{
	level.player method_83CC("specialty_fastreload",1);
}

//Function Number: 3
func_F85F()
{
	level.player method_8320("specialty_bulletaccuracy",1);
}

//Function Number: 4
func_12D36()
{
	level.player method_83CC("specialty_bulletaccuracy",1);
}

//Function Number: 5
func_F810()
{
	level.player method_8320("specialty_quickswap",1);
}

//Function Number: 6
func_12D13()
{
	level.player method_83CC("specialty_quickswap",1);
}

//Function Number: 7
func_F712()
{
	level.player method_8320("specialty_reducedsway",1);
	level.player setviewkickscale(0.35);
}

//Function Number: 8
func_12CBE()
{
	level.player method_83CC("specialty_reducedsway",1);
	level.player setviewkickscale(1);
}

//Function Number: 9
func_F80F()
{
	level.player method_8320("specialty_quickdraw",1);
}

//Function Number: 10
func_12D12()
{
	level.player method_83CC("specialty_quickdraw",1);
}

//Function Number: 11
func_F636()
{
	level.player method_8320("specialty_sprintfire",1);
}

//Function Number: 12
func_12C6F()
{
	level.player method_83CC("specialty_sprintfire",1);
}

//Function Number: 13
func_F6F8()
{
	lib_0B2A::func_6240(1);
}

//Function Number: 14
func_12CB7()
{
	lib_0B2A::func_6240(0);
}

//Function Number: 15
func_F667()
{
	level.player method_8320("specialty_explosivearmor",1);
}

//Function Number: 16
func_12C82()
{
	level.player method_83CC("specialty_explosivearmor",1);
}

//Function Number: 17
func_F700()
{
	scripts\sp\_gameskill::func_F52D(0.85,0.75);
	scripts\sp\_gameskill::func_12E5A();
}

//Function Number: 18
func_12CBB()
{
	scripts\sp\_gameskill::func_F52D(1,1);
	scripts\sp\_gameskill::func_12E5A();
}

//Function Number: 19
func_F849()
{
	if(isdefined(self.var_CA5B) && isdefined(self.var_CA5B["specialty_shocker"]))
	{
		self.var_CA5B["specialty_shocker"] = undefined;
	}

	scripts\sp\_utility::func_13705();
	scripts\sp\_utility::func_12641("weapon_iw7_knife_perk_tr");
	scripts\sp\_utility::func_82EA("iw7_knife_perk");
}

//Function Number: 20
func_12D2F()
{
	scripts\sp\_utility::func_1143E();
}

//Function Number: 21
func_F83E()
{
	if(isdefined(self.var_CA5B) && isdefined(self.var_CA5B["specialty_slasher"]))
	{
		self.var_CA5B["specialty_slasher"] = undefined;
	}

	scripts\sp\_utility::func_13705();
	scripts\sp\_utility::func_12641("weapon_iw7_knife_upgrade1_tr");
	scripts\sp\_utility::func_82EA("iw7_knife_upgrade1");
}

//Function Number: 22
func_12D2A()
{
	scripts\sp\_utility::func_1143E();
}

//Function Number: 23
func_11314(param_00,param_01,param_02)
{
	level.player endon("death");
	level.player endon(param_02);
	var_03 = level.player getweaponslistoffhands();
	if(scripts\common\utility::func_2286(var_03,param_00))
	{
		level.player takeweapon(param_00);
		level.player giveweapon(param_01);
	}

	for(;;)
	{
		level.player waittill("equipment_change");
		var_03 = level.player getweaponslistoffhands();
		if(scripts\common\utility::func_2286(var_03,param_00))
		{
			level.player takeweapon(param_00);
			level.player giveweapon(param_01);
		}
	}
}

//Function Number: 24
func_E0A3(param_00,param_01)
{
	var_02 = level.player getweaponslistoffhands();
	if(scripts\common\utility::func_2286(var_02,param_01))
	{
		level.player takeweapon(param_01);
		level.player giveweapon(param_00);
	}
}

//Function Number: 25
func_FAB8()
{
	thread func_11314("frag","frag_up1","unsetUpgradeFrag1");
}

//Function Number: 26
func_12D5A()
{
	level.player notify("unsetUpgradeFrag1");
	thread func_E0A3("frag","frag_up1");
}

//Function Number: 27
func_FAB9()
{
	func_FAB8();
	level.player.var_735A = 1;
}

//Function Number: 28
func_12D5B()
{
	func_12D5A();
	level.player.var_735A = undefined;
}

//Function Number: 29
func_FAC0()
{
	level.player.var_612D.var_4A6D = 0.5;
	level.player.var_612D.var_4A6C = 0.75;
	level.player.var_612D.var_4A6E = 0.1;
	level.player.var_612D.var_12F6D = 1;
}

//Function Number: 30
func_12D62()
{
	level.player.var_612D.var_4A6D = 0.35;
	level.player.var_612D.var_4A6C = 0.6;
	level.player.var_612D.var_4A6E = 0.2;
	level.player.var_612D.var_12F6D = 0;
}

//Function Number: 31
func_FAC1()
{
	level.player.var_612D.var_12F6D = 2;
}

//Function Number: 32
func_12D63()
{
	level.player.var_612D.var_12F6D = 0;
}

//Function Number: 33
func_FAB2()
{
	level.player.var_202A = 1;
}

//Function Number: 34
func_12D54()
{
	level.player.var_202A = undefined;
}

//Function Number: 35
func_FAB3()
{
	func_FAB2();
	level.player.var_202B = 1;
}

//Function Number: 36
func_12D55()
{
	func_12D54();
	level.player.var_202B = undefined;
}

//Function Number: 37
func_FABC()
{
	level.player.var_F179.var_45BF = 1;
}

//Function Number: 38
func_12D5E()
{
	level.player.var_F179.var_45BF = 0;
}

//Function Number: 39
func_FABD()
{
	func_FABC();
	level.player.var_F179.var_9076 = 1;
}

//Function Number: 40
func_12D5F()
{
	func_12D5E();
	level.player.var_F179.var_9076 = 0;
}

//Function Number: 41
func_FABA()
{
	level.player.var_885E = 1;
	level.player.var_885D = 1;
}

//Function Number: 42
func_12D5C()
{
	level.player.var_885E = undefined;
	level.player.var_885D = undefined;
}

//Function Number: 43
func_FABE()
{
	level.player notify("unsetUpgradeShield1");
	thread func_11314("offhandshield","offhandshield_up1","unsetUpgradeShield1");
	level.player.var_C337.var_9936 = 1;
}

//Function Number: 44
func_12D60()
{
	level.player notify("unsetUpgradeShield1");
	thread func_E0A3("offhandshield","offhandshield_up1");
	level.player.var_C337.var_9936 = 0;
}

//Function Number: 45
func_FAB6()
{
	level.player.var_5CB3 = 1;
	thread func_11314("supportdrone","supportdrone_up2","unsetUpgradeDrone1");
}

//Function Number: 46
func_12D58()
{
	level.player.var_5CB3 = undefined;
	level.player notify("unsetUpgradeDrone1");
	thread func_E0A3("supportdrone","supportdrone_up2");
}

//Function Number: 47
func_FAB4()
{
	level.player.var_4759.var_389C = 1;
}

//Function Number: 48
func_12D56()
{
	level.player.var_4759.var_389C = 0;
}