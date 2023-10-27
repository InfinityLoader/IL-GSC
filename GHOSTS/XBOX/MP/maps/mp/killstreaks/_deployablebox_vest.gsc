/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_deployablebox_vest.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 5
 * Decompile Time: 77 ms
 * Timestamp: 10/27/2023 1:32:22 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	var_00 = addstruct();
	var_00.id = "deployable_vest";
	var_00.weaponinfo = "deployable_vest_marker_mp";
	var_00.modelbase = "prop_ballistic_vest_iw6";
	var_00.modelbombsquad = "prop_ballistic_vest_iw6_bombsquad";
	var_00.hintstring = &"KILLSTREAKS_HINTS_LIGHT_ARMOR_PICKUP";
	var_00.capturingstring = &"KILLSTREAKS_BOX_GETTING_VEST";
	var_00.event = "deployable_vest_taken";
	var_00.streakname = "deployable_vest";
	var_00.splashname = "used_deployable_vest";
	var_00.shadername = "compass_objpoint_deploy_friendly";
	var_00.headiconoffset = 20;
	var_00.lifespan = 90;
	var_00.usexp = 50;
	var_00.xppopup = "destroyed_vest";
	var_00.vodestroyed = "ballistic_vest_destroyed";
	var_00.deployedsfx = "mp_vest_deployed_ui";
	var_00.onusesfx = "ammo_crate_use";
	var_00.onusecallback = ::func_5987;
	var_00.canusecallback = ::canusedeployable;
	var_00.usetime = 1000;
	var_00.maxhealth = 300;
	var_00.damagefeedback = "deployable_bag";
	var_00.deathvfx = loadfx("vfx/gameplay/mp/killstreaks/vfx_ballistic_vest_death");
	var_00.allowmeleedamage = 1;
	var_00.allowgrenadedamage = 0;
	var_00.maxuses = 4;
	var_00.canuseotherboxes = 0;
	level.boxsettings["deployable_vest"] = var_00;
	level.killstreakfuncs["deployable_vest"] = ::func_8434;
	level.deployable_box["deployable_vest"] = [];
}

//Function Number: 2
func_8434(param_00,param_01)
{
	var_02 = maps\mp\killstreaks\_deployablebox::func_13F5(param_00,"deployable_vest");
	if(!isdefined(var_02) || !var_02)
	{
		return 0;
	}

	if(!maps\mp\_utility::func_47BB())
	{
		maps\mp\_matchdata::func_4F1D("deployable_vest",self.origin);
	}

	return 1;
}

//Function Number: 3
canusedeployable(param_00)
{
	if(!maps\mp\_utility::func_47BB())
	{
		return !maps\mp\perks\_perkfunctions::haslightarmor() && !maps\mp\_utility::isjuggernaut();
	}

	if(isdefined(param_00) && param_00.owner == self && !isdefined(param_00.air_dropped))
	{
		return 0;
	}

	return !maps\mp\_utility::isjuggernaut();
}

//Function Number: 4
func_5987(param_00)
{
	if(maps\mp\_utility::func_47BB())
	{
		var_01 = 0;
		if(isdefined(self.lightarmorhp))
		{
			var_01 = self.lightarmorhp;
		}

		var_02 = get_adjusted_armor(var_01,param_00.upgrade_rank);
		maps\mp\perks\_perkfunctions::func_7063(var_02);
		self notify("enable_armor");
	}

	maps\mp\perks\_perkfunctions::func_7063();
}

//Function Number: 5
get_adjusted_armor(param_00,param_01)
{
	if(param_00 + level.deployablebox_vest_rank[param_01] > level.deployablebox_vest_max)
	{
		return level.deployablebox_vest_max;
	}

	return param_00 + level.deployablebox_vest_rank[param_01];
}