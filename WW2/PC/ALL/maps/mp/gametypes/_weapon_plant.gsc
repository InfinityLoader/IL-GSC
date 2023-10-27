/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\gametypes\_weapon_plant.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 23
 * Decompile Time: 339 ms
 * Timestamp: 10/27/2023 3:24:33 AM
*******************************************************************/

//Function Number: 1
func_5285()
{
	setdvarifuninitialized("weapon_plant_stand_upper_limit",4);
	setdvarifuninitialized("weapon_plant_crouch_lower_limit",4);
	if(!isdefined(level.var_A9B1))
	{
		level.var_A9B1 = spawnstruct();
		level.var_A9B1.var_4295 = ::func_4295;
		level.var_A9B1.var_707B = ::func_707B;
		level.var_A9B1.var_2FEE = ::func_2FEE;
		level.var_A9B1.var_3A66 = ::func_3A66;
		level.var_A9B1.var_6518 = ::func_6518;
		level.var_A9B1.var_8B6B = ::func_8B6B;
		level.var_A9B1.var_43DE = ::func_43DE;
		level.var_A9B1.var_43DA = ::func_43DA;
		level.var_A9B1.var_941B = ::func_941B;
		level.var_A9B1.var_4355 = ::func_4355;
		level.var_A9B1.var_2373 = ::func_2373;
		level.var_A9B1.var_4074 = ::func_4074;
		level.var_A9B1.var_43DC = ::func_43DC;
		level.var_A9B1.var_8B53 = ::func_8B53;
		level.var_A9B1.var_439E = ::func_439E;
		level.var_A9B1.var_41C4 = ::func_41C4;
		level.var_A9B1.var_41B5 = ::func_41B5;
		level.var_A9B1.var_43D9 = ::func_43D9;
		level.var_A9B1.var_5778 = ::func_5778;
		level.var_A9B1.var_8BAF = ::func_8BAF;
		level.var_A9B1.get_weapon_paintjobid = ::get_weapon_paintjobid;
		level.var_A9B1.get_weapon_charmguid = ::get_weapon_charmguid;
	}
}

//Function Number: 2
func_6518(param_00)
{
	self method_85BF(param_00);
}

//Function Number: 3
func_43DC(param_00)
{
	return "SCRIPTED_SWAP";
}

//Function Number: 4
func_4295(param_00)
{
	var_01 = maps\mp\gametypes\_division_change::func_995(self,2,param_00,1,0);
	return var_01;
}

//Function Number: 5
func_707B(param_00,param_01,param_02)
{
	lib_0380::func_288B("mg_deploy_mount",self,self);
	lib_0380::func_288B("mg_deploy_rattle",self,self);
}

//Function Number: 6
func_2FEE()
{
	lib_0380::func_288B("mg_deploy_release",self,self);
	lib_0380::func_288B("mg_deploy_rattle",self,self);
}

//Function Number: 7
func_3A66()
{
	self iclientprintlnbold(&"WEAPON_PLANT_BLOCKED");
}

//Function Number: 8
func_8B6B()
{
	return 1;
}

//Function Number: 9
func_43DE()
{
	return getdvarfloat("weapon_plant_stand_upper_limit",4);
}

//Function Number: 10
func_43DA()
{
	return getdvarfloat("weapon_plant_crouch_lower_limit",4);
}

//Function Number: 11
func_941B(param_00,param_01,param_02,param_03)
{
}

//Function Number: 12
func_2373()
{
}

//Function Number: 13
get_weapon_paintjobid()
{
	return self method_86CE();
}

//Function Number: 14
get_weapon_charmguid()
{
	return self method_86CF();
}

//Function Number: 15
func_4355(param_00)
{
	var_01 = undefined;
	var_02 = undefined;
	var_03 = 15;
	var_04 = 15;
	if(param_00 == "prone")
	{
		var_01 = 40;
		var_02 = 40;
	}
	else
	{
		var_01 = 45;
		var_02 = 45;
	}

	return [var_01,var_02,var_03,var_04];
}

//Function Number: 16
func_8B53()
{
	return 1;
}

//Function Number: 17
func_4074()
{
	return getdvarfloat("5099",-14.03);
}

//Function Number: 18
func_439E(param_00)
{
	return undefined;
}

//Function Number: 19
func_41C4()
{
	return 0;
}

//Function Number: 20
func_41B5()
{
	return 10;
}

//Function Number: 21
func_43D9()
{
	return getdvarfloat("4485",32.98);
}

//Function Number: 22
func_5778(param_00)
{
	return 0;
}

//Function Number: 23
func_8BAF()
{
	return 0;
}