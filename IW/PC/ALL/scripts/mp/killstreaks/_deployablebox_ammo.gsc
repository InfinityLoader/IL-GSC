/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_deployablebox_ammo.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 8
 * Decompile Time: 387 ms
 * Timestamp: 10/27/2023 12:28:21 AM
*******************************************************************/

//Function Number: 1
init()
{
	var_00 = spawnstruct();
	var_00.var_39B = "deployable_vest_marker_mp";
	var_00.var_B91A = "mil_ammo_case_1_open";
	var_00.var_17B = &"KILLSTREAKS_HINTS_DEPLOYABLE_AMMO_USE";
	var_00.var_3A41 = &"KILLSTREAKS_DEPLOYABLE_AMMO_TAKING";
	var_00.var_67E5 = "deployable_ammo_taken";
	var_00.var_110EA = "deployable_ammo";
	var_00.var_10A38 = "used_deployable_ammo";
	var_00.var_FC47 = "compass_objpoint_deploy_ammo_friendly";
	var_00.var_8C7A = 25;
	var_00.var_AC71 = 90;
	var_00.var_130FC = 50;
	var_00.var_EC44 = "destroyed_vest";
	var_00.var_13523 = "ballistic_vest_destroyed";
	var_00.var_5230 = "mp_vest_deployed_ui";
	var_00.var_C5C7 = "ammo_crate_use";
	var_00.var_C5BC = ::func_C5BE;
	var_00.var_3936 = ::func_3937;
	var_00.var_130EE = 500;
	var_00.maxhealth = 150;
	var_00.var_4D4A = "deployable_bag";
	var_00.var_4E76 = "deployable_ammo_mp";
	var_00.var_4E74 = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
	var_00.var_4E3C = 256;
	var_00.var_4E3A = 130;
	var_00.var_4E3B = 50;
	var_00.var_1C9D = 1;
	var_00.var_1C96 = 1;
	var_00.var_B4D1 = 4;
	level.var_2F30["deployable_ammo"] = var_00;
	scripts\mp\killstreaks\_killstreaks::func_DEFB("deployable_ammo",::func_128DE);
	level.var_5212["deployable_ammo"] = [];
}

//Function Number: 2
func_128DE(param_00,param_01)
{
	var_02 = scripts\mp\killstreaks\_deployablebox::func_2A63(param_00,"deployable_ammo");
	if(!isdefined(var_02) || !var_02)
	{
		return 0;
	}

	scripts\mp\_matchdata::func_AFC9("deployable_ammo",self.origin);
	return 1;
}

//Function Number: 3
func_C5BE(param_00)
{
	func_17A6();
}

//Function Number: 4
func_17A6()
{
	var_00 = self getweaponslistall();
	if(isdefined(var_00))
	{
		foreach(var_02 in var_00)
		{
			if(scripts\mp\_weapons::func_9D75(var_02))
			{
				func_1805(var_02,2);
				continue;
			}

			if(weaponclass(var_02) == "rocketlauncher")
			{
				func_1805(var_02,1);
			}
		}
	}
}

//Function Number: 5
func_1805(param_00,param_01)
{
	var_02 = weaponclipsize(param_00);
	var_03 = self getweaponammostock(param_00);
	self setweaponammostock(param_00,var_03 + param_01 * var_02);
}

//Function Number: 6
func_1819(param_00)
{
	var_01 = self getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		if(scripts\mp\_weapons::func_9D75(var_03))
		{
			if(var_03 != "iw6_alienminigun_mp")
			{
				var_04 = self getweaponammostock(var_03);
				var_05 = function_0249(var_03);
				var_06 = var_04 + var_05 * param_00;
				self setweaponammostock(var_03,int(min(var_06,var_05)));
			}
		}
	}
}

//Function Number: 7
func_17C6()
{
	var_00 = self getweaponslistprimaries();
	foreach(var_02 in var_00)
	{
		var_03 = weaponclipsize(var_02);
		self setweaponammoclip(var_02,var_03);
	}
}

//Function Number: 8
func_3937(param_00)
{
	return !scripts\mp\_utility::func_9E59();
}