/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_deployablebox_juicebox.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 4
 * Decompile Time: 78 ms
 * Timestamp: 10/27/2023 1:20:36 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	var_00 = spawnstruct();
	var_00.weaponinfo = "deployable_vest_marker_mp";
	var_00.modelbase = "afr_mortar_ammo_01";
	var_00.hintstring = &"KILLSTREAKS_HINTS_DEPLOYABLE_JUICEBOX_PICKUP";
	var_00.capturingstring = &"KILLSTREAKS_DEPLOYABLE_JUICEBOX_TAKING";
	var_00.event = "deployable_juicebox_taken";
	var_00.streakname = "deployable_juicebox";
	var_00.splashname = "used_deployable_juicebox";
	var_00.shadername = "compass_objpoint_deploy_juiced_friendly";
	var_00.headiconoffset = 25;
	var_00.lifespan = 90;
	var_00.usexp = 50;
	var_00.xppopup = "destroyed_vest";
	var_00.vodestroyed = "ballistic_vest_destroyed";
	var_00.deployedsfx = "mp_vest_deployed_ui";
	var_00.onusesfx = "ammo_crate_use";
	var_00.onusecallback = ::func_5987;
	var_00.canusecallback = ::canusedeployable;
	var_00.usetime = 500;
	var_00.maxhealth = 300;
	var_00.damagefeedback = "deployable_bag";
	var_00.deathweaponinfo = "deployable_ammo_mp";
	var_00.deathvfx = loadfx("vfx/gameplay/mp/killstreaks/vfx_ballistic_vest_death");
	var_00.allowmeleedamage = 1;
	var_00.allowgrenadedamage = 0;
	var_00.maxuses = 4;
	level.boxsettings["deployable_juicebox"] = var_00;
	level.killstreakfuncs["deployable_juicebox"] = ::func_8431;
	level.deployable_box["deployable_juicebox"] = [];
}

//Function Number: 2
func_8431(param_00,param_01)
{
	var_02 = maps\mp\killstreaks\_deployablebox::func_13F5(param_00,"deployable_juicebox");
	if(!isdefined(var_02) || !var_02)
	{
		return 0;
	}

	if(!maps\mp\_utility::func_47BB())
	{
		maps\mp\_matchdata::func_4F1D("deployable_juicebox",self.origin);
	}

	return 1;
}

//Function Number: 3
func_5987(param_00)
{
	if(maps\mp\_utility::func_47BB())
	{
		thread maps\mp\perks\_perkfunctions::func_705B(level.deployablebox_juicebox_rank[param_00.upgrade_rank]);
	}

	thread maps\mp\perks\_perkfunctions::func_705B(15);
}

//Function Number: 4
canusedeployable(param_00)
{
	if(maps\mp\_utility::func_47BB() && isdefined(param_00) && param_00.owner == self && !isdefined(param_00.air_dropped))
	{
		return 0;
	}

	return !maps\mp\_utility::isjuggernaut() && !maps\mp\perks\_perkfunctions::func_4016();
}