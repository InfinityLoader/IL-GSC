/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_deployablebox_grenades.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 210 ms
 * Timestamp: 10/27/2023 12:28:22 AM
*******************************************************************/

//Function Number: 1
init()
{
	var_00 = spawnstruct();
	var_00.var_39B = "deployable_vest_marker_mp";
	var_00.var_B91A = "afr_mortar_ammo_01";
	var_00.var_17B = &"KILLSTREAKS_HINTS_DEPLOYABLE_GRENADES_PICKUP";
	var_00.var_3A41 = &"KILLSTREAKS_DEPLOYABLE_GRENADES_TAKING";
	var_00.var_67E5 = "deployable_grenades_taken";
	var_00.var_110EA = "deployable_grenades";
	var_00.var_10A38 = "used_deployable_grenades";
	var_00.var_FC47 = "compass_objpoint_deploy_grenades_friendly";
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
	var_00.var_4E76 = "deployable_grenades_mp";
	var_00.var_4E74 = loadfx("vfx/core/expl/grenadeexp_default");
	var_00.var_4E3C = 256;
	var_00.var_4E3A = 150;
	var_00.var_4E3B = 50;
	var_00.var_1C9D = 1;
	var_00.var_1C96 = 1;
	var_00.var_B4D1 = 3;
	level.var_2F30["deployable_grenades"] = var_00;
	scripts\mp\killstreaks\_killstreaks::func_DEFB("deployable_grenades",::func_128DF);
	level.var_5212["deployable_grenades"] = [];
}

//Function Number: 2
func_128DF(param_00,param_01)
{
	var_02 = scripts\mp\killstreaks\_deployablebox::func_2A63(param_00,"deployable_grenades");
	if(!isdefined(var_02) || !var_02)
	{
		return 0;
	}

	scripts\mp\_matchdata::func_AFC9("deployable_grenades",self.origin);
	return 1;
}

//Function Number: 3
func_C5BE(param_00)
{
	func_DE4E();
}

//Function Number: 4
func_DE4E()
{
	var_00 = self getweaponslistall();
	if(isdefined(var_00))
	{
		foreach(var_02 in var_00)
		{
			if(scripts\mp\_weapons::func_9E18(var_02) || scripts\mp\_weapons::func_9EC0(var_02))
			{
				self method_817C(var_02);
			}
		}
	}
}

//Function Number: 5
func_3937(param_00)
{
	return !scripts\mp\_utility::func_9E59();
}