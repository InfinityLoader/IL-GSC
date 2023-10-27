/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_d_day_aud.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 3
 * Decompile Time: 61 ms
 * Timestamp: 10/27/2023 3:15:24 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	func_7BBE();
}

//Function Number: 2
func_7BBE()
{
	lib_0378::func_8DC7("mp_intro_dday_plane_flyover",::func_64FF);
}

//Function Number: 3
func_64FF(param_00,param_01)
{
	var_02 = self;
	var_02 endon("death");
	wait 0.05;
	if(param_01 == 11)
	{
		lib_0380::func_6844("mp_dday_intro_fly_bombers_01_allies","allies",var_02);
		wait(1.2);
		lib_0380::func_6844("mp_dday_intro_fly_bombers_01_axis","axis",var_02);
	}

	if(param_01 == 101)
	{
		lib_0380::func_6844("mp_dday_intro_fly_bombers_02_allies","allies",var_02);
		lib_0380::func_6844("mp_dday_intro_fly_bombers_02_axis","axis");
	}

	if(param_01 == 105)
	{
		lib_0380::func_6844("mp_dday_intro_fly_bombers_03_allies","allies",var_02);
	}

	if(param_01 == 104)
	{
		lib_0380::func_6844("mp_dday_intro_fly_bombers_03_axis","axis",var_02);
	}

	if(param_01 == 13)
	{
		lib_0380::func_6844("mp_dday_intro_fly_fighters_01_allies","allies",var_02);
		lib_0380::func_6844("mp_dday_intro_fly_fighters_01_axis","axis",var_02);
	}

	if(param_01 == 4)
	{
		lib_0380::func_6844("mp_dday_intro_fly_fighters_02_allies","allies",var_02);
		lib_0380::func_6844("mp_dday_intro_fly_fighters_02_axis","axis",var_02);
	}

	if(param_01 == 3)
	{
		lib_0380::func_6844("mp_dday_intro_fly_fighters_03_allies","allies",var_02);
	}

	if(param_01 == 5)
	{
		lib_0380::func_6844("mp_dday_intro_fly_fighters_04_axis","axis",var_02);
	}

	if(param_01 == 8)
	{
		lib_0380::func_6844("mp_dday_intro_fly_fighters_04_allies","allies",var_02);
		lib_0380::func_6844("mp_dday_intro_fly_fighters_05_axis","axis",var_02);
	}

	if(param_01 == 7)
	{
		lib_0380::func_6844("mp_dday_intro_fly_fighters_05_allies","allies",var_02);
		lib_0380::func_6844("mp_dday_intro_fly_fighters_03_axis","axis",var_02);
	}
}