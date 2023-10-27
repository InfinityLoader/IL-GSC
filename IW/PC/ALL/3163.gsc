/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3163.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 14 ms
 * Timestamp: 10/27/2023 12:26:22 AM
*******************************************************************/

//Function Number: 1
func_2371()
{
	if(lib_0A1A::func_232E("shoot_cover_A"))
	{
		return;
	}

	lib_0A1A::func_230B("shoot_cover_A","shoot_start_A");
	lib_0A1A::func_2374("shoot_idle_right_A",::lib_0C56::func_FE75,undefined,undefined,::lib_0F3D::func_CEC1,undefined,::lib_0F3D::func_3E96,"shoot_idle",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("shoot_fire_right_A",undefined,::func_124AF,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim_A",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("shoot_single_right_A",::lib_0C56::func_FE61,undefined,undefined,::lib_0F3D::func_CEC0,undefined,::lib_0F3D::func_3E96,"single",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"shoot",undefined,undefined,undefined);
	lib_0A1A::func_2375("shoot_idle_right_A",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2375("shoot_idle_right_A",undefined,::lib_0C56::func_FECE,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim_A",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("shoot_full_right_A",::lib_0C56::func_FE61,undefined,undefined,::lib_0F3D::func_CEC0,undefined,::scripts\asm\shared_utility::func_3E9A,"burst",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"shoot",undefined,undefined,undefined);
	lib_0A1A::func_2375("shoot_idle_right_A",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2375("shoot_idle_right_A",undefined,::lib_0C56::func_FECE,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim_A",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("shoot_semi_right_A",::lib_0C56::func_FE61,undefined,undefined,::lib_0F3D::func_CEC0,undefined,::scripts\asm\shared_utility::func_3E9A,"semi",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"shoot",undefined,undefined,undefined);
	lib_0A1A::func_2375("shoot_idle_right_A",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2375("shoot_idle_right_A",undefined,::lib_0C56::func_FECE,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim_A",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("shoot_start_A",::lib_0C56::func_98CC,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("shoot_cover_right_A",undefined,::func_124B7,undefined);
	lib_0A1A::func_2375("shoot_cover_left_right_A",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("shoot_fire_right_A",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("shoot_right_A_updateparams",undefined,::lib_0C56::func_FE89,undefined);
	lib_0A1A::func_2374("crouch_shoot_idle_right_A",::lib_0C56::func_FE75,undefined,undefined,::lib_0F3D::func_CEC1,undefined,::scripts\asm\shared_utility::func_3EB7,"shoot_idle",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("crouch_shoot_fire_right_A",undefined,::func_12045,undefined);
	lib_0A1A::func_2375("shoot_start_A",undefined,::func_12046,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim_A",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("crouch_shoot_full_right_A",::lib_0C56::func_FE61,undefined,undefined,::lib_0F3D::func_CEC0,undefined,::scripts\asm\shared_utility::func_3E9A,"burst",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"shoot",undefined,undefined,undefined);
	lib_0A1A::func_2375("crouch_shoot_idle_right_A",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2375("crouch_shoot_idle_right_A",undefined,::lib_0C56::func_FECE,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim_A",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("crouch_shoot_semi_right_A",::lib_0C56::func_FE61,undefined,undefined,::lib_0F3D::func_CEC0,undefined,::scripts\asm\shared_utility::func_3E9A,"semi",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"shoot",undefined,undefined,undefined);
	lib_0A1A::func_2375("crouch_shoot_idle_right_A",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2375("crouch_shoot_idle_right_A",undefined,::lib_0C56::func_FECE,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim_A",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("crouch_shoot_fire_right_A",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("crouch_shoot_right_A_updateparams",undefined,::lib_0C56::func_FE89,undefined);
	lib_0A1A::func_2374("crouch_shoot_single_right_A",::lib_0C56::func_FE61,undefined,undefined,::lib_0F3D::func_CEC0,undefined,::lib_0F3D::func_3E96,"single",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"shoot",undefined,undefined,undefined);
	lib_0A1A::func_2375("crouch_shoot_idle_right_A",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2375("crouch_shoot_idle_right_A",undefined,::lib_0C56::func_FECE,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim_A",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("WaitForNotetrackAim_A",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("shoot_start_A",undefined,::lib_0F3D::func_FE6B,undefined);
	lib_0A1A::func_2374("shoot_idle_left_A",::lib_0C56::func_FE75,undefined,undefined,::lib_0F3D::func_CEC1,undefined,::lib_0F3D::func_3E96,"shoot_idle",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("shoot_fire_left_A",undefined,::func_124AE,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim_A",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("shoot_single_left_A",::lib_0C56::func_FE61,undefined,undefined,::lib_0F3D::func_CEC0,undefined,::lib_0F3D::func_3E96,"single",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"shoot",undefined,undefined,undefined);
	lib_0A1A::func_2375("shoot_idle_left_A",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2375("shoot_idle_left_A",undefined,::lib_0C56::func_FECE,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim_A",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("shoot_full_left_A",::lib_0C56::func_FE61,undefined,undefined,::lib_0F3D::func_CEC0,undefined,::scripts\asm\shared_utility::func_3E9A,"burst",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"shoot",undefined,undefined,undefined);
	lib_0A1A::func_2375("shoot_idle_left_A",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2375("shoot_idle_left_A",undefined,::lib_0C56::func_FECE,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim_A",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("shoot_semi_left_A",::lib_0C56::func_FE61,undefined,undefined,::lib_0F3D::func_CEC0,undefined,::scripts\asm\shared_utility::func_3E9A,"semi",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"shoot",undefined,undefined,undefined);
	lib_0A1A::func_2375("shoot_idle_left_A",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2375("shoot_idle_left_A",undefined,::lib_0C56::func_FECE,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim_A",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("shoot_fire_left_A",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("shoot_left_A_updateparams",undefined,::lib_0C56::func_FE89,undefined);
	lib_0A1A::func_2374("crouch_shoot_idle_left_A",::lib_0C56::func_FE75,undefined,undefined,::lib_0F3D::func_CEC1,undefined,::scripts\asm\shared_utility::func_3EB7,"shoot_idle",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,undefined);
	lib_0A1A::func_2375("crouch_shoot_fire_left_A",undefined,::func_12044,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim_A",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("crouch_shoot_full_left_A",::lib_0C56::func_FE61,undefined,undefined,::lib_0F3D::func_CEC0,undefined,::scripts\asm\shared_utility::func_3E9A,"burst",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"shoot",undefined,undefined,undefined);
	lib_0A1A::func_2375("crouch_shoot_idle_left_A",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2375("crouch_shoot_idle_left_A",undefined,::lib_0C56::func_FECE,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim_A",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("crouch_shoot_semi_left_A",::lib_0C56::func_FE61,undefined,undefined,::lib_0F3D::func_CEC0,undefined,::scripts\asm\shared_utility::func_3E9A,"semi",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"shoot",undefined,undefined,undefined);
	lib_0A1A::func_2375("crouch_shoot_idle_left_A",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2375("crouch_shoot_idle_left_A",undefined,::lib_0C56::func_FECE,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim_A",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("crouch_shoot_fire_left_A",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("crouch_shoot_left_A_updateparams",undefined,::lib_0C56::func_FE89,undefined);
	lib_0A1A::func_2374("crouch_shoot_single_left_A",::lib_0C56::func_FE61,undefined,undefined,::lib_0F3D::func_CEC0,undefined,::lib_0F3D::func_3E96,"single",undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,"shoot",undefined,undefined,undefined);
	lib_0A1A::func_2375("crouch_shoot_idle_left_A",undefined,::lib_0A1A::func_68B0,"shoot_finished");
	lib_0A1A::func_2375("crouch_shoot_idle_left_A",undefined,::lib_0C56::func_FECE,undefined);
	lib_0A1A::func_2375("WaitForNotetrackAim_A",undefined,::lib_0F3D::func_FE7E,undefined);
	lib_0A1A::func_2374("shoot_cover_right_A",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("crouch_shoot_idle_right_A",undefined,::func_124A0,undefined);
	lib_0A1A::func_2375("shoot_idle_right_A",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("shoot_cover_left_right_A",::lib_0F3D::func_CEA8,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("crouch_shoot_idle_left_A",undefined,::func_1249F,undefined);
	lib_0A1A::func_2375("shoot_idle_left_A",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("crouch_shoot_right_A_updateparams",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("crouch_shoot_single_right_A",undefined,::func_12052,undefined);
	lib_0A1A::func_2375("crouch_shoot_full_right_A",undefined,::lib_0C56::func_FED9,undefined);
	lib_0A1A::func_2375("crouch_shoot_semi_right_A",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("crouch_shoot_left_A_updateparams",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("crouch_shoot_single_left_A",undefined,::func_12051,undefined);
	lib_0A1A::func_2375("crouch_shoot_full_left_A",undefined,::lib_0C56::func_FED9,undefined);
	lib_0A1A::func_2375("crouch_shoot_semi_left_A",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("shoot_left_A_updateparams",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("shoot_single_left_A",undefined,::func_124B5,undefined);
	lib_0A1A::func_2375("shoot_full_left_A",undefined,::lib_0C56::func_FED9,undefined);
	lib_0A1A::func_2375("shoot_semi_left_A",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2374("shoot_right_A_updateparams",::scripts\asm\shared_utility::func_2B58,undefined,undefined,undefined,undefined,::lib_0F3D::func_3E96,undefined,undefined,undefined,undefined,undefined,undefined,undefined,"death_generic",undefined,undefined,undefined,undefined,undefined,undefined,1);
	lib_0A1A::func_2375("shoot_single_right_A",undefined,::func_124B6,undefined);
	lib_0A1A::func_2375("shoot_full_right_A",undefined,::lib_0C56::func_FED9,undefined);
	lib_0A1A::func_2375("shoot_semi_right_A",undefined,::scripts\asm\shared_utility::func_12668,undefined);
	lib_0A1A::func_2327();
}

//Function Number: 2
func_124AF(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_291C();
}

//Function Number: 3
func_124B7(param_00,param_01,param_02,param_03)
{
	return isdefined(self.var_205) && self.var_205.type == "Cover Right";
}

//Function Number: 4
func_12045(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_291C();
}

//Function Number: 5
func_12046(param_00,param_01,param_02,param_03)
{
	return self.var_1491.var_D6A5 != "crouch";
}

//Function Number: 6
func_124AE(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_291C();
}

//Function Number: 7
func_12044(param_00,param_01,param_02,param_03)
{
	return lib_0A1B::func_291C();
}

//Function Number: 8
func_124A0(param_00,param_01,param_02,param_03)
{
	return self.var_1491.var_D6A5 == "crouch";
}

//Function Number: 9
func_1249F(param_00,param_01,param_02,param_03)
{
	return self.var_1491.var_D6A5 == "crouch";
}

//Function Number: 10
func_12052(param_00,param_01,param_02,param_03)
{
	return self.var_1198.var_FECD.var_FF0B == 1;
}

//Function Number: 11
func_12051(param_00,param_01,param_02,param_03)
{
	return self.var_1198.var_FECD.var_FF0B == 1;
}

//Function Number: 12
func_124B5(param_00,param_01,param_02,param_03)
{
	return self.var_1198.var_FECD.var_FF0B == 1;
}

//Function Number: 13
func_124B6(param_00,param_01,param_02,param_03)
{
	return self.var_1198.var_FECD.var_FF0B == 1;
}