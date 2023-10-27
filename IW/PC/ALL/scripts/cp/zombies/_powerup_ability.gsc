/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\zombies\_powerup_ability.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 560 ms
 * Timestamp: 10/27/2023 12:23:45 AM
*******************************************************************/

//Function Number: 1
func_D790()
{
	var_00 = spawnstruct();
	level.var_D73A = var_00;
	var_00.var_C4A3 = ["primary","secondary"];
	var_00.var_C4A3["primary"][0] = "ui_power_num_charges";
	var_00.var_C4A3["primary"][1] = "ui_power_max_charges";
	var_00.var_C4A3["primary"][2] = "ui_power_recharge";
	var_00.var_C4A3["primary"][3] = "ui_power_id";
	var_00.var_C4A3["primary"][4] = "ui_power_consume";
	var_00.var_C4A3["primary"][5] = "ui_power_disabled";
	var_00.var_C4A3["primary"][6] = "ui_power_state";
	var_00.var_C4A3["secondary"][0] = "ui_power_secondary_num_charges";
	var_00.var_C4A3["secondary"][1] = "ui_power_secondary_max_charges";
	var_00.var_C4A3["secondary"][2] = "ui_power_secondary_recharge";
	var_00.var_C4A3["secondary"][3] = "ui_power_id_secondary";
	var_00.var_C4A3["secondary"][4] = "ui_power_secondary_consume";
	var_00.var_C4A3["secondary"][5] = "ui_power_secondary_disabled";
	var_00.var_C4A3["secondary"][6] = "ui_power_secondary_state";
}

//Function Number: 2
func_D789(param_00,param_01,param_02,param_03)
{
	if(param_00 == "scripted")
	{
		return;
	}

	self setclientomnvar(func_D78F(param_00,3),param_01);
	var_04 = scripts\common\utility::func_116D7(param_02,1000,0);
	self setclientomnvar(func_D78F(param_00,2),var_04);
	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	self setclientomnvar(func_D78F(param_00,0),param_03);
	self setclientomnvar(func_D78F(param_00,4),0);
}

//Function Number: 3
func_D78C(param_00)
{
	if(param_00 == "scripted")
	{
		return;
	}

	self setclientomnvar(func_D78F(param_00,3),-1);
	self setclientomnvar(func_D78F(param_00,2),-1);
	self setclientomnvar(func_D78F(param_00,0),0);
	self setclientomnvar(func_D78F(param_00,4),-1);
}

//Function Number: 4
func_D791(param_00,param_01)
{
	self setclientomnvar(func_D78F(param_00,0),int(param_01));
}

//Function Number: 5
func_D796(param_00,param_01)
{
	self setclientomnvar(func_D78F(param_00,1),int(param_01));
}

//Function Number: 6
func_D794(param_00,param_01)
{
	self setclientomnvar(func_D78F(param_00,4),param_01);
}

//Function Number: 7
func_D797(param_00,param_01)
{
	self setclientomnvar(func_D78F(param_00,2),int(param_01));
}

//Function Number: 8
func_D793(param_00,param_01)
{
	self setclientomnvar(func_D78F(param_00,5),param_01);
}

//Function Number: 9
powershud_updatepoweroffcooldown(param_00,param_01)
{
	var_02 = scripts\common\utility::func_116D7(param_01,1,0);
	self setclientomnvar(func_D78F(param_00,6),var_02);
}

//Function Number: 10
func_D798(param_00,param_01)
{
	self setclientomnvar(func_D78F(param_00,6),param_01);
}

//Function Number: 11
func_D78B(param_00)
{
	func_D794(param_00,1);
}

//Function Number: 12
func_D78D(param_00)
{
	func_D794(param_00,0);
}

//Function Number: 13
func_D78A(param_00,param_01)
{
	func_D797(param_00,0);
	if(isdefined(param_01) && param_01)
	{
		func_D793(param_00,1);
	}

	func_D798(param_00,1);
}

//Function Number: 14
func_D78E(param_00,param_01)
{
	func_D797(param_00,1000);
	if(isdefined(param_01) && param_01)
	{
		func_D793(param_00,0);
	}

	if(param_00 == "primary")
	{
		self playlocalsound("mp_ability_ready_L1");
	}
	else
	{
		self playlocalsound("mp_ability_ready_R1");
	}

	func_D798(param_00,0);
}

//Function Number: 15
func_D792(param_00,param_01)
{
	func_D797(param_00,1000 * param_01);
}

//Function Number: 16
func_D795(param_00,param_01)
{
	func_D797(param_00,1000 * param_01);
}

//Function Number: 17
func_D78F(param_00,param_01)
{
	if(param_00 == "scripted")
	{
		return;
	}

	return level.var_D73A.var_C4A3[param_00][param_01];
}