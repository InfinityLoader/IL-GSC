/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3327.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 39
 * Decompile Time: 7 ms
 * Timestamp: 10/27/2023 12:26:33 AM
*******************************************************************/

//Function Number: 1
func_98C0()
{
	var_00 = [];
	var_00["none"] = ::func_0104;
	var_00["nerf_take_more_damage"] = ::func_93E5;
	var_00["nerf_higher_threatbias"] = ::func_93ED;
	var_00["nerf_smaller_wallet"] = ::func_DE36;
	var_00["nerf_lower_weapon_damage"] = ::func_B0DD;
	var_00["nerf_no_class"] = ::func_BFE2;
	var_00["nerf_pistols_only"] = ::func_CBE1;
	var_00["nerf_fragile"] = ::func_10315;
	var_00["nerf_move_slower"] = ::func_BC6D;
	var_00["nerf_no_abilities"] = ::func_BFD9;
	var_00["nerf_min_ammo"] = ::func_B73A;
	var_00["nerf_no_deployables"] = ::func_BFE8;
	level.var_D881 = var_00;
	var_01 = [];
	for(var_02 = 0;var_02 < 10;var_02++)
	{
		var_03 = tablelookupbyrow("cp/alien/prestige_nerf.csv",var_02,1);
		if(!isdefined(var_03) || var_03 == "")
		{
			break;
		}

		var_01[var_01.size] = var_03;
	}

	level.var_BEE8 = var_01;
}

//Function Number: 2
func_98BA()
{
	func_969A();
}

//Function Number: 3
func_969A()
{
	var_00 = [];
	var_00["nerf_take_more_damage"] = 1;
	var_00["nerf_higher_threatbias"] = 0;
	var_00["nerf_smaller_wallet"] = 1;
	var_00["nerf_earn_less_money"] = 1;
	var_00["nerf_lower_weapon_damage"] = 1;
	var_00["nerf_no_class"] = 0;
	var_00["nerf_pistols_only"] = 0;
	var_00["nerf_fragile"] = 1;
	var_00["nerf_move_slower"] = 1;
	var_00["nerf_no_abilities"] = 0;
	var_00["nerf_min_ammo"] = 1;
	var_00["nerf_no_deployables"] = 0;
	self.var_BEE9 = var_00;
	self.var_1606 = [];
}

//Function Number: 4
func_BEE7()
{
	for(var_00 = 0;var_00 < 10;var_00++)
	{
		var_01 = func_7C4A(var_00);
		func_15D6(var_01);
	}
}

//Function Number: 5
func_15D6(param_00)
{
	if(func_9C4C(param_00))
	{
		return;
	}

	if(func_BEE6(param_00))
	{
		return;
	}

	func_DEC4(param_00);
	[[ level.var_D881[param_00] ]]();
}

//Function Number: 6
func_BEE6(param_00)
{
	return scripts\common\utility::func_2286(self.var_1606,param_00);
}

//Function Number: 7
func_DEC4(param_00)
{
	self.var_1606[self.var_1606.size] = param_00;
}

//Function Number: 8
func_DE36()
{
	func_DE35();
	func_DE33();
}

//Function Number: 9
func_9C9E()
{
	return 1;
}

//Function Number: 10
func_9C4C(param_00)
{
	return param_00 == "none";
}

//Function Number: 11
func_7B33()
{
	return self.var_1606.size;
}

//Function Number: 12
func_0104()
{
}

//Function Number: 13
func_93E5()
{
	func_F494("nerf_take_more_damage",1.33);
}

//Function Number: 14
func_93ED()
{
	func_F494("nerf_higher_threatbias",500);
}

//Function Number: 15
func_DE35()
{
	func_F494("nerf_smaller_wallet",0.5);
}

//Function Number: 16
func_DE33()
{
	func_F494("nerf_earn_less_money",0.75);
}

//Function Number: 17
func_B0DD()
{
	func_F494("nerf_lower_weapon_damage",0.66);
}

//Function Number: 18
func_BFE2()
{
	func_F494("nerf_no_class",1);
}

//Function Number: 19
func_CBE1()
{
	func_F494("nerf_pistols_only",1);
}

//Function Number: 20
func_10315()
{
	func_F494("nerf_fragile",1.5);
}

//Function Number: 21
func_BC6D()
{
	func_F494("nerf_move_slower",0.7);
}

//Function Number: 22
func_BFD9()
{
	func_F494("nerf_no_abilities",1);
}

//Function Number: 23
func_B73A()
{
	func_F494("nerf_min_ammo",0.25);
}

//Function Number: 24
func_BFE8()
{
	func_F494("nerf_no_deployables",1);
}

//Function Number: 25
func_F494(param_00,param_01)
{
	self.var_BEE9[param_00] = param_01;
}

//Function Number: 26
func_7B0E(param_00)
{
	return self.var_BEE9[param_00];
}

//Function Number: 27
func_7C4A(param_00)
{
}

//Function Number: 28
func_D875()
{
	return func_7B0E("nerf_take_more_damage");
}

//Function Number: 29
func_D87E()
{
	return func_7B0E("nerf_higher_threatbias");
}

//Function Number: 30
func_D87F()
{
	return func_7B0E("nerf_smaller_wallet");
}

//Function Number: 31
func_D877()
{
	return func_7B0E("nerf_earn_less_money");
}

//Function Number: 32
func_D880()
{
	return func_7B0E("nerf_lower_weapon_damage");
}

//Function Number: 33
func_D87A()
{
	return func_7B0E("nerf_no_class");
}

//Function Number: 34
func_D87C()
{
	return func_7B0E("nerf_pistols_only");
}

//Function Number: 35
func_D87D()
{
	return func_7B0E("nerf_fragile");
}

//Function Number: 36
func_D878()
{
	return func_7B0E("nerf_move_slower");
}

//Function Number: 37
func_D879()
{
	return func_7B0E("nerf_no_abilities");
}

//Function Number: 38
func_D876()
{
	return func_7B0E("nerf_min_ammo");
}

//Function Number: 39
func_D87B()
{
	return func_7B0E("nerf_no_deployables");
}