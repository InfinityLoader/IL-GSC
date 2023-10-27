/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3904.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 6 ms
 * Timestamp: 10/27/2023 12:31:11 AM
*******************************************************************/

//Function Number: 1
func_2371()
{
	if(lib_0A1A::func_232E("shoot_mp"))
	{
		return;
	}

	lib_0A1A::func_230B("shoot_mp","shoot_start");
	lib_0A1A::func_2374("shoot_idle",::lib_0F3E::func_FE75,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,"shoot_idle",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("shoot_fire",undefined,::lib_0F3C::func_10076,undefined);
	lib_0A1A::func_2374("shoot_single",::lib_0F3E::func_FE61,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,"single",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("shoot_idle",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2374("shoot_full",::lib_0F3E::func_FE61,undefined,undefined,undefined,undefined,::scripts\asm\shared_utility::func_3E9A,"burst",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("shoot_idle",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2374("shoot_semi",::lib_0F3E::func_FE61,undefined,undefined,undefined,undefined,::scripts\asm\shared_utility::func_3E9A,"semi",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("shoot_idle",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2374("shoot_start",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pistol_shoot_idle",undefined,::lib_0A1B::func_294D,"pistol");
	lib_0A1A::func_2375("rpg_shoot",undefined,::lib_0A1B::func_294D,"rocketlauncher");
	lib_0A1A::func_2375("crouch_shoot_idle",undefined,::func_124BC,undefined);
	lib_0A1A::func_2375("shoot_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pistol_shoot_idle",::lib_0F3E::func_FE75,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,"shoot_idle",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pistol_shoot_single",0,::func_123FD,undefined);
	lib_0A1A::func_2374("pistol_shoot_single",::lib_0F3E::func_FE61,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,"single",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pistol_shoot_idle",0,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2374("rpg_shoot_idle",::lib_0F3E::func_FE75,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,"shoot_idle",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("rpg_shoot_single",undefined,::func_12421,undefined);
	lib_0A1A::func_2374("rpg_shoot_single",::lib_0F3E::func_FE61,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,"single",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("rpg_shoot_idle",0,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2374("rpg_shoot_crouch_idle",::lib_0F3C::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,"shoot_idle",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("rpg_shoot_crouch_single",undefined,::func_1241D,undefined);
	lib_0A1A::func_2374("rpg_shoot_crouch_single",::lib_0F3E::func_FE61,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,"single",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("rpg_shoot_crouch_idle",0,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2374("shoot_fire",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("shoot_single",undefined,::func_124A9,undefined);
	lib_0A1A::func_2375("shoot_full",undefined,::func_124A1,undefined);
	lib_0A1A::func_2375("shoot_semi",undefined,::func_124A5,undefined);
	lib_0A1A::func_2374("rpg_shoot",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("rpg_shoot_crouch_idle",undefined,::func_12425,undefined);
	lib_0A1A::func_2375("rpg_shoot_idle",undefined,::func_12428,undefined);
	lib_0A1A::func_2374("crouch_shoot_idle",::lib_0F3E::func_FE75,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,"shoot_idle",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("crouch_shoot_fire",undefined,::func_12047,undefined);
	lib_0A1A::func_2375("shoot_start",undefined,::func_1204C,undefined);
	lib_0A1A::func_2374("crouch_shoot_full",::lib_0F3E::func_FE61,undefined,undefined,undefined,undefined,::scripts\asm\shared_utility::func_3E9A,"burst",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("crouch_shoot_idle",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2374("crouch_shoot_semi",::lib_0F3E::func_FE61,undefined,undefined,undefined,undefined,::scripts\asm\shared_utility::func_3E9A,"semi",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("crouch_shoot_idle",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2374("crouch_shoot_fire",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("crouch_shoot_single",undefined,::func_1203F,undefined);
	lib_0A1A::func_2375("crouch_shoot_full",undefined,::func_12037,undefined);
	lib_0A1A::func_2375("crouch_shoot_semi",undefined,::func_1203B,undefined);
	lib_0A1A::func_2374("crouch_shoot_single",::lib_0F3E::func_FE61,undefined,undefined,undefined,undefined,::lib_0F3C::func_3E96,"single",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("crouch_shoot_idle",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2327();
}

//Function Number: 2
func_124BC(param_00,param_01,param_02,param_03)
{
	return lib_0F3C::func_138E2();
}

//Function Number: 3
func_123FD(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_291C();
}

//Function Number: 4
func_12421(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_291C();
}

//Function Number: 5
func_1241D(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_291C();
}

//Function Number: 6
func_124A9(param_00,param_01,param_02,param_03)
{
	return self.var_1198.var_FECD.var_FF0B == 1;
}

//Function Number: 7
func_124A1(param_00,param_01,param_02,param_03)
{
	return self.var_1198.var_FECD.var_1119D == "full";
}

//Function Number: 8
func_124A5(param_00,param_01,param_02,param_03)
{
	return 1;
}

//Function Number: 9
func_12425(param_00,param_01,param_02,param_03)
{
	return self.var_1491.var_D6A5 == "crouch";
}

//Function Number: 10
func_12428(param_00,param_01,param_02,param_03)
{
	return 1;
}

//Function Number: 11
func_12047(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_291C();
}

//Function Number: 12
func_1204C(param_00,param_01,param_02,param_03)
{
	return !lib_0F3C::func_138E2();
}

//Function Number: 13
func_1203F(param_00,param_01,param_02,param_03)
{
	return self.var_1198.var_FECD.var_FF0B == 1;
}

//Function Number: 14
func_12037(param_00,param_01,param_02,param_03)
{
	return self.var_1198.var_FECD.var_1119D == "full";
}

//Function Number: 15
func_1203B(param_00,param_01,param_02,param_03)
{
	return 1;
}