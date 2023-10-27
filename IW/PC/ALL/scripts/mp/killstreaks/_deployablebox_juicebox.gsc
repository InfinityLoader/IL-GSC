/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_deployablebox_juicebox.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 184 ms
 * Timestamp: 10/27/2023 12:28:23 AM
*******************************************************************/

//Function Number: 1
init()
{
	var_00 = spawnstruct();
	var_00.var_39B = "deployable_vest_marker_mp";
	var_00.var_B91A = "afr_mortar_ammo_01";
	var_00.var_17B = &"KILLSTREAKS_HINTS_DEPLOYABLE_JUICEBOX_PICKUP";
	var_00.var_3A41 = &"KILLSTREAKS_DEPLOYABLE_JUICEBOX_TAKING";
	var_00.var_67E5 = "deployable_juicebox_taken";
	var_00.var_110EA = "deployable_juicebox";
	var_00.var_10A38 = "used_deployable_juicebox";
	var_00.var_FC47 = "compass_objpoint_deploy_juiced_friendly";
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
	var_00.maxhealth = 300;
	var_00.var_4D4A = "deployable_bag";
	var_00.var_4E76 = "deployable_ammo_mp";
	var_00.var_4E74 = loadfx("vfx/core/mp/killstreaks/vfx_ballistic_vest_death");
	var_00.var_1C9D = 1;
	var_00.var_1C96 = 0;
	var_00.var_B4D1 = 4;
	level.var_2F30["deployable_juicebox"] = var_00;
	scripts\mp\killstreaks\_killstreaks::func_DEFB("deployable_juicebox",::func_128E0);
	level.var_5212["deployable_juicebox"] = [];
}

//Function Number: 2
func_128E0(param_00,param_01)
{
	var_02 = scripts\mp\killstreaks\_deployablebox::func_2A63(param_00,"deployable_juicebox");
	if(!isdefined(var_02) || !var_02)
	{
		return 0;
	}

	scripts\mp\_matchdata::func_AFC9("deployable_juicebox",self.origin);
	return 1;
}

//Function Number: 3
func_C5BE(param_00)
{
	thread scripts\mp\perks\_perkfunctions::func_F769(15);
}

//Function Number: 4
func_3937(param_00)
{
	return !scripts\mp\_utility::func_9E59() && !scripts\mp\perks\_perkfunctions::func_8C03();
}