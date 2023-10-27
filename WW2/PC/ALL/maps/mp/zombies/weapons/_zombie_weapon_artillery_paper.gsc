/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\zombies\weapons\_zombie_weapon_artillery_paper.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 104 ms
 * Timestamp: 10/27/2023 3:13:29 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
}

//Function Number: 2
flourish_map(param_00)
{
	thread preview_map(param_00);
}

//Function Number: 3
use_map()
{
	self allowjump(0);
	self method_8113(0);
	self method_8114(0);
	self method_81E1(0);
	var_00 = self getcurrentweapon();
	lib_0586::func_78C("papermap_zm");
	lib_0586::func_78E("papermap_zm");
	self method_8326();
	var_01 = wait_for_user_input();
	self method_8327();
	lib_0586::func_78E(var_00);
	wait(1);
	lib_0586::func_790("papermap_zm");
	self method_81E1(1);
	self allowjump(1);
	self method_8113(1);
	self method_8114(1);
	return var_01;
}

//Function Number: 4
wait_for_user_input()
{
	var_00 = 1;
	while(self usebuttonpressed())
	{
		wait 0.05;
	}

	wait(0.15);
	while(var_00)
	{
		if(self usebuttonpressed())
		{
			return "A";
		}

		if(self jumpbuttonpressed())
		{
			return "B";
		}

		if(self method_84F1())
		{
			return "C";
		}

		wait(0.15);
	}
}

//Function Number: 5
preview_map(param_00)
{
	var_01 = self getcurrentweapon();
	lib_0586::func_78C(param_00);
	lib_0586::func_78E(param_00);
	self method_8326();
	wait(1.5);
	iprintlnbold("DIALOG: We\'ll need to check out the sub pens first.");
	wait(1.5);
	self method_8327();
	lib_0586::func_78E(var_01);
	wait(1);
	lib_0586::func_790(param_00);
}