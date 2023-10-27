/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_deployablebox_vest.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 244 ms
 * Timestamp: 10/27/2023 12:28:24 AM
*******************************************************************/

//Function Number: 1
init()
{
	var_00 = spawnstruct();
	var_00.var_92B8 = "deployable_vest";
	var_00.var_39B = "deployable_vest_marker_mp";
	var_00.var_B91A = "prop_ballistic_vest_iw6";
	var_00.var_B91C = "prop_ballistic_vest_iw6_bombsquad";
	var_00.var_17B = &"KILLSTREAKS_HINTS_LIGHT_ARMOR_PICKUP";
	var_00.var_3A41 = &"KILLSTREAKS_BOX_GETTING_VEST";
	var_00.var_67E5 = "deployable_vest_taken";
	var_00.var_110EA = "deployable_vest";
	var_00.var_10A38 = "used_deployable_vest";
	var_00.var_FC47 = "compass_objpoint_deploy_friendly";
	var_00.var_8C7A = 20;
	var_00.var_AC71 = 90;
	var_00.var_130FC = 50;
	var_00.var_EC44 = "destroyed_vest";
	var_00.var_13523 = "ballistic_vest_destroyed";
	var_00.var_5230 = "mp_vest_deployed_ui";
	var_00.var_C5C7 = "ammo_crate_use";
	var_00.var_C5BC = ::func_C5BE;
	var_00.var_3936 = ::func_3937;
	var_00.var_130EE = 1000;
	var_00.maxhealth = 220;
	var_00.var_4D4A = "deployable_bag";
	var_00.var_4E74 = loadfx("vfx/core/mp/killstreaks/vfx_ballistic_vest_death");
	var_00.var_1C9D = 1;
	var_00.var_1C96 = 0;
	var_00.var_B4D1 = 4;
	var_00.var_393B = 0;
	level.var_2F30["deployable_vest"] = var_00;
	scripts\mp\killstreaks\_killstreaks::func_DEFB("deployable_vest",::func_128E1);
	level.var_5212["deployable_vest"] = [];
}

//Function Number: 2
func_128E1(param_00,param_01)
{
	var_02 = scripts\mp\killstreaks\_deployablebox::func_2A63(param_00,"deployable_vest");
	if(!isdefined(var_02) || !var_02)
	{
		return 0;
	}

	scripts\mp\_matchdata::func_AFC9("deployable_vest",self.origin);
	return 1;
}

//Function Number: 3
func_3937(param_00)
{
	return !scripts\mp\_lightarmor::func_8C07(self) && !scripts\mp\_utility::func_9E59();
	if(isdefined(param_00) && param_00.var_222 == self && !isdefined(param_00.var_1A64))
	{
		return 0;
	}

	return !scripts\mp\_utility::func_9E59();
}

//Function Number: 4
func_C5BE(param_00)
{
	scripts\mp\perks\_perkfunctions::func_F785();
}

//Function Number: 5
func_77D4(param_00,param_01)
{
	if(param_00 + level.var_5221[param_01] > level.var_5220)
	{
		return level.var_5220;
	}

	return param_00 + level.var_5221[param_01];
}