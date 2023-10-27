/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3159.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 41 ms
 * Timestamp: 10/27/2023 12:26:21 AM
*******************************************************************/

//Function Number: 1
func_2371()
{
	if(lib_0A1A::func_232E("shoot"))
	{
		return;
	}

	lib_0A1A::func_230B("shoot","shoot_start");
	lib_0A1A::func_2374("shoot_idle",::lib_0C56::func_FE75,undefined,undefined,::lib_0F3D::func_CEC1,undefined,::lib_0F3D::func_3E96,"shoot_idle",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("shoot_fire",undefined,::lib_0C56::func_FFC9,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2375("sniper_shoot_idle",undefined,::lib_0C56::func_10081,undefined);
	lib_0A1A::func_2374("shoot_single",::lib_0C56::func_FE61,undefined,undefined,::lib_0F3D::func_CEC0,undefined,::lib_0F3D::func_3E96,"single",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"shoot",undefined,undefined,undefined);
	lib_0A1A::func_2375("sniper_check",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2375("sniper_check",undefined,::lib_0C56::func_FECE,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("shoot_full",::lib_0C56::func_FE61,undefined,undefined,::lib_0F3D::func_CEC0,undefined,::scripts\asm\shared_utility::func_3E9A,"burst",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"shoot",undefined,undefined,undefined);
	lib_0A1A::func_2375("sniper_check",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2375("sniper_check",undefined,::lib_0C56::func_FECE,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("shoot_semi",::lib_0C56::func_FE61,undefined,undefined,::lib_0F3D::func_CEC0,undefined,::scripts\asm\shared_utility::func_3E9A,"semi",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"shoot",undefined,undefined,undefined);
	lib_0A1A::func_2375("sniper_check",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2375("sniper_check",undefined,::lib_0C56::func_FECE,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("shoot_start",::lib_0C56::func_98CC,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pistol_shoot_idle",undefined,::lib_0A1B::func_294D,"pistol");
	lib_0A1A::func_2375("rpg_shoot",undefined,::lib_0A1B::func_294D,"rocketlauncher");
	lib_0A1A::func_2375("mg_shoot_idle",undefined,::lib_0C56::func_10078,undefined);
	lib_0A1A::func_2375("crouch_shoot_idle_pass",undefined,::lib_0A1B::func_9DA4,"crouch");
	lib_0A1A::func_2375("prone_shoot_idle",undefined,::lib_0A1B::func_9DA4,"prone");
	lib_0A1A::func_2375("sniper_check",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pistol_shoot_idle",::lib_0C56::func_FE75,undefined,undefined,::lib_0F3D::func_CEC1,undefined,::lib_0F3D::func_3E96,"shoot_idle",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("pistol_shoot_fire",0,::lib_0C56::func_FFC9,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("pistol_shoot_single",::lib_0C56::func_FE61,undefined,undefined,::lib_0F3D::func_CEC0,undefined,::lib_0F3D::func_3E96,"single",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"shoot",undefined,undefined,undefined);
	lib_0A1A::func_2375("pistol_shoot_idle",0,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2375("pistol_shoot_idle",undefined,::lib_0C56::func_FECE,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("rpg_shoot_idle",::lib_0C56::func_FE75,undefined,undefined,::lib_0F3D::func_CEC1,undefined,::lib_0F3D::func_3E96,"shoot_idle",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("rpg_shoot_updateparams",undefined,::lib_0C56::func_FFC9,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("rpg_shoot_single",::lib_0C56::func_FE61,undefined,undefined,::lib_0F3D::func_CEC0,undefined,::lib_0F3D::func_3E96,"single",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"shoot",undefined,undefined,undefined);
	lib_0A1A::func_2375("rpg_shoot_idle",0,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2375("rpg_shoot_idle",undefined,::lib_0C56::func_FECE,undefined);
	lib_0A1A::func_2374("rpg_shoot_crouch_idle",::lib_0C56::func_FE75,undefined,undefined,::lib_0F3D::func_CEC1,undefined,::lib_0F3D::func_3E96,"shoot_idle",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("rpg_shoot_crouch_updateparams",undefined,::lib_0C56::func_FFC9,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("rpg_shoot_crouch_single",::lib_0C56::func_FE61,undefined,undefined,::lib_0F3D::func_CEC0,undefined,::lib_0F3D::func_3E96,"single",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"shoot",undefined,undefined,undefined);
	lib_0A1A::func_2375("rpg_shoot_crouch_idle",0,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2375("rpg_shoot_crouch_idle",undefined,::lib_0C56::func_FECE,undefined);
	lib_0A1A::func_2374("shoot_fire",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("shoot_updateparams",undefined,::lib_0C56::func_FE89,undefined);
	lib_0A1A::func_2374("rpg_shoot",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("rpg_shoot_crouch_idle",undefined,::lib_0A1B::func_9DA4,"crouch");
	lib_0A1A::func_2375("rpg_shoot_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("crouch_shoot_idle",::lib_0C56::func_FE75,undefined,undefined,::lib_0F3D::func_CEC1,undefined,::scripts\asm\shared_utility::func_3EB7,"shoot_idle",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("crouch_shoot_fire",undefined,::lib_0C56::func_FFC9,undefined);
	lib_0A1A::func_2375("shoot_start",undefined,::func_1204C,undefined);
	lib_0A1A::func_2375("crouch_sniper_shoot_idle",undefined,::lib_0C56::func_10081,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("crouch_shoot_full",::lib_0C56::func_FE61,undefined,undefined,::lib_0F3D::func_CEC0,undefined,::scripts\asm\shared_utility::func_3E9A,"burst",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"shoot",undefined,undefined,undefined);
	lib_0A1A::func_2375("crouch_shoot_idle_pass",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2375("crouch_shoot_idle_pass",undefined,::lib_0C56::func_FECE,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("crouch_shoot_semi",::lib_0C56::func_FE61,undefined,undefined,::lib_0F3D::func_CEC0,undefined,::scripts\asm\shared_utility::func_3E9A,"semi",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"shoot",undefined,undefined,undefined);
	lib_0A1A::func_2375("crouch_shoot_idle_pass",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2375("crouch_shoot_idle_pass",undefined,::lib_0C56::func_FECE,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("crouch_shoot_fire",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("crouch_shoot_updateparams",undefined,::lib_0C56::func_FE89,undefined);
	lib_0A1A::func_2374("crouch_shoot_single",::lib_0C56::func_FE61,undefined,undefined,::lib_0F3D::func_CEC0,undefined,::lib_0F3D::func_3E96,"single",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"shoot",undefined,undefined,undefined);
	lib_0A1A::func_2375("crouch_shoot_idle_pass",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2375("crouch_shoot_idle_pass",undefined,::lib_0C56::func_FECE,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("prone_shoot_idle",::lib_0C56::func_FE75,undefined,undefined,::lib_0F3D::func_CEC1,undefined,::lib_0F3D::func_3E96,"shoot_idle",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("prone_shoot_fire",undefined,::lib_0C56::func_FFC9,undefined);
	lib_0A1A::func_2375("shoot_start",undefined,::func_12413,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("prone_shoot_single",::lib_0C56::func_FE61,undefined,undefined,::lib_0F3D::func_CEC0,undefined,::lib_0F3D::func_3E96,"single",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"shoot",undefined,undefined,undefined);
	lib_0A1A::func_2375("prone_shoot_idle",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2375("prone_shoot_idle",undefined,::lib_0C56::func_FECE,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("prone_shoot_full",::lib_0C56::func_FE61,undefined,undefined,::lib_0F3D::func_CEC0,undefined,::scripts\asm\shared_utility::func_3E9A,"burst",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"shoot",undefined,undefined,undefined);
	lib_0A1A::func_2375("prone_shoot_idle",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2375("prone_shoot_idle",undefined,::lib_0C56::func_FECE,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("prone_shoot_semi",::lib_0C56::func_FE61,undefined,undefined,::lib_0F3D::func_CEC0,undefined,::scripts\asm\shared_utility::func_3E9A,"semi",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"shoot",undefined,undefined,undefined);
	lib_0A1A::func_2375("prone_shoot_idle",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2375("prone_shoot_idle",undefined,::lib_0C56::func_FECE,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("prone_shoot_fire",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("prone_shoot_updateparams",undefined,::lib_0C56::func_FE89,undefined);
	lib_0A1A::func_2374("WaitForNotetrackAim",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("shoot_start",undefined,::lib_0F3D::func_FE6B,undefined);
	lib_0A1A::func_2374("mg_shoot_idle",::lib_0C56::func_FE75,undefined,undefined,::lib_0F3D::func_CEC1,undefined,::lib_0F3D::func_3E96,"shoot_idle",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("shoot_start",undefined,::lib_0C56::func_C185,undefined);
	lib_0A1A::func_2375("mg_shoot_fire",undefined,::lib_0C56::func_FFC9,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("mg_shoot_suppress",::lib_0C56::func_FE70,undefined,undefined,::lib_0F3D::func_CEC0,undefined,::lib_0F3D::func_3E96,"single",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"shoot",undefined,undefined,undefined);
	lib_0A1A::func_2375("mg_shoot_idle",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2375("mg_shoot_idle",undefined,::lib_0C56::func_FECE,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("mg_shoot_fire",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("mg_shoot_suppress",undefined,::lib_0C56::func_FEDA,undefined);
	lib_0A1A::func_2374("shoot_updateparams",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("shoot_single",0,::lib_0C56::func_FEDC,undefined);
	lib_0A1A::func_2375("shoot_full",0,::lib_0C56::func_FED9,undefined);
	lib_0A1A::func_2375("shoot_semi",0,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("crouch_shoot_updateparams",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("crouch_shoot_single",0,::lib_0C56::func_FEDC,undefined);
	lib_0A1A::func_2375("crouch_shoot_full",0,::lib_0C56::func_FED9,undefined);
	lib_0A1A::func_2375("crouch_shoot_semi",0,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("prone_shoot_updateparams",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("prone_shoot_single",0,::lib_0C56::func_FEDC,undefined);
	lib_0A1A::func_2375("prone_shoot_full",0,::lib_0C56::func_FED9,undefined);
	lib_0A1A::func_2375("prone_shoot_semi",0,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("pistol_shoot_updateparams",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pistol_shoot_single",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("sniper_check",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("WaitForNotetrackAim",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2375("sniper_shoot_idle",undefined,::lib_0C56::func_10081,undefined);
	lib_0A1A::func_2375("shoot_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("sniper_shoot_idle",::lib_0C56::func_FE76,undefined,undefined,::lib_0F3D::func_CEC1,undefined,::lib_0F3D::func_3E96,"shoot_idle",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2375("shoot_fire",undefined,::lib_0C56::func_10080,undefined);
	lib_0A1A::func_2375("shoot_idle",undefined,::lib_0C56::func_10002,undefined);
	lib_0A1A::func_2374("pistol_shoot_fire",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("pistol_shoot_updateparams",undefined,::lib_0C56::func_FE89,undefined);
	lib_0A1A::func_2374("rpg_shoot_updateparams",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("rpg_shoot_single",undefined,::lib_0C56::func_FE89,undefined);
	lib_0A1A::func_2374("rpg_shoot_crouch_updateparams",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("rpg_shoot_crouch_single",undefined,::lib_0C56::func_FE89,undefined);
	lib_0A1A::func_2374("crouch_shoot_idle_pass",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("WaitForNotetrackAim",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2375("crouch_sniper_shoot_idle",undefined,::lib_0C56::func_10081,undefined);
	lib_0A1A::func_2375("crouch_shoot_idle",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("crouch_sniper_shoot_idle",::lib_0C56::func_FE76,undefined,undefined,::lib_0F3D::func_CEC1,undefined,::lib_0F3D::func_3E96,"shoot_idle",undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("crouch_shoot_idle",undefined,::lib_0C56::func_10002,undefined);
	lib_0A1A::func_2375("crouch_shoot_fire",undefined,::lib_0C56::func_10080,undefined);
	lib_0A1A::func_2375("shoot_start",undefined,::func_12053,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2327();
}

//Function Number: 2
func_1204C(param_00,param_01,param_02,param_03)
{
	return self.var_1491.var_D6A5 != "crouch";
}

//Function Number: 3
func_12413(param_00,param_01,param_02,param_03)
{
	return self.var_1491.var_D6A5 != "prone";
}

//Function Number: 4
func_12053(param_00,param_01,param_02,param_03)
{
	return self.var_1491.var_D6A5 != "crouch";
}