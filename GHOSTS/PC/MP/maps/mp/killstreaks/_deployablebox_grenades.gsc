/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_deployablebox_grenades.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 94 ms
 * Timestamp: 10/27/2023 1:20:35 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	var_00 = spawnstruct();
	var_00.weaponinfo = "deployable_vest_marker_mp";
	var_00.modelbase = "afr_mortar_ammo_01";
	var_00.hintstring = &"KILLSTREAKS_HINTS_DEPLOYABLE_GRENADES_PICKUP";
	var_00.capturingstring = &"KILLSTREAKS_DEPLOYABLE_GRENADES_TAKING";
	var_00.event = "deployable_grenades_taken";
	var_00.streakname = "deployable_grenades";
	var_00.splashname = "used_deployable_grenades";
	var_00.shadername = "compass_objpoint_deploy_grenades_friendly";
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
	var_00.maxhealth = 150;
	var_00.damagefeedback = "deployable_bag";
	var_00.deathweaponinfo = "deployable_grenades_mp";
	var_00.deathvfx = loadfx("fx/explosions/grenadeexp_default");
	var_00.deathdamageradius = 256;
	var_00.deathdamagemax = 150;
	var_00.deathdamagemin = 50;
	var_00.allowmeleedamage = 1;
	var_00.allowgrenadedamage = 1;
	var_00.maxuses = 3;
	level.boxsettings["deployable_grenades"] = var_00;
	level.killstreakfuncs["deployable_grenades"] = ::func_8430;
	level.deployable_box["deployable_grenades"] = [];
}

//Function Number: 2
func_8430(param_00,param_01)
{
	var_02 = maps\mp\killstreaks\_deployablebox::func_13F5(param_00,"deployable_grenades");
	if(!isdefined(var_02) || !var_02)
	{
		return 0;
	}

	maps\mp\_matchdata::func_4F1D("deployable_grenades",self.origin);
	return 1;
}

//Function Number: 3
func_5987(param_00)
{
	refillexplosiveweapons();
}

//Function Number: 4
refillexplosiveweapons()
{
	var_00 = self getweaponslistall();
	if(isdefined(var_00))
	{
		foreach(var_02 in var_00)
		{
			if(maps\mp\gametypes\_weapons::func_48D0(var_02) || maps\mp\gametypes\_weapons::isoffhandweapon(var_02))
			{
				self givestartammo(var_02);
			}
		}
	}

	if(maps\mp\_utility::_hasperk("specialty_tacticalinsertion") && self getammocount("flare_mp") < 1)
	{
		maps\mp\_utility::func_3CFD("specialty_tacticalinsertion",0);
	}
}

//Function Number: 5
canusedeployable(param_00)
{
	if(maps\mp\_utility::func_47BB() && isdefined(param_00) && param_00.owner == self && !isdefined(param_00.air_dropped))
	{
		return 0;
	}

	return !maps\mp\_utility::isjuggernaut();
}