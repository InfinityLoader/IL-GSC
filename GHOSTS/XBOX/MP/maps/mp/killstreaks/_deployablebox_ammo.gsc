/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_deployablebox_ammo.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 9
 * Decompile Time: 132 ms
 * Timestamp: 10/27/2023 1:32:20 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	var_00 = addstruct();
	var_00.weaponinfo = "deployable_vest_marker_mp";
	var_00.modelbase = "mil_ammo_case_1_open";
	var_00.hintstring = &"KILLSTREAKS_HINTS_DEPLOYABLE_AMMO_USE";
	var_00.capturingstring = &"KILLSTREAKS_DEPLOYABLE_AMMO_TAKING";
	var_00.event = "deployable_ammo_taken";
	var_00.streakname = "deployable_ammo";
	var_00.splashname = "used_deployable_ammo";
	var_00.shadername = "compass_objpoint_deploy_ammo_friendly";
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
	var_00.deathweaponinfo = "deployable_ammo_mp";
	var_00.deathvfx = loadfx("fx/explosions/clusterbomb_exp_direct_runner");
	var_00.deathdamageradius = 256;
	var_00.deathdamagemax = 130;
	var_00.deathdamagemin = 50;
	var_00.allowmeleedamage = 1;
	var_00.allowgrenadedamage = 1;
	var_00.maxuses = 4;
	level.boxsettings["deployable_ammo"] = var_00;
	level.killstreakfuncs["deployable_ammo"] = ::tryusedeployableammo;
	level.deployable_box["deployable_ammo"] = [];
}

//Function Number: 2
tryusedeployableammo(param_00,param_01)
{
	var_02 = maps\mp\killstreaks\_deployablebox::func_13F5(param_00,"deployable_ammo");
	if(!isdefined(var_02) || !var_02)
	{
		return 0;
	}

	if(!maps\mp\_utility::func_47BB())
	{
		maps\mp\_matchdata::func_4F1D("deployable_ammo",self.origin);
	}

	return 1;
}

//Function Number: 3
func_5987(param_00)
{
	if(maps\mp\_utility::func_47BB())
	{
		addalienweaponammo(param_00);
	}

	addallweaponammo();
}

//Function Number: 4
addallweaponammo()
{
	var_00 = self getweaponslistall();
	if(isdefined(var_00))
	{
		foreach(var_02 in var_00)
		{
			if(maps\mp\gametypes\_weapons::isbulletweapon(var_02))
			{
				func_0951(var_02,2);
				continue;
			}

			if(weaponclass(var_02) == "rocketlauncher")
			{
				func_0951(var_02,1);
			}
		}
	}
}

//Function Number: 5
func_0951(param_00,param_01)
{
	var_02 = weaponclipsize(param_00);
	var_03 = self getweaponammostock(param_00);
	self setweaponammostock(param_00,var_03 + param_01 * var_02);
}

//Function Number: 6
addratiomaxstocktoallweapons(param_00)
{
	var_01 = self getweaponslistprimaries();
	foreach(var_03 in var_01)
	{
		if(maps\mp\gametypes\_weapons::isbulletweapon(var_03))
		{
			if(var_03 != "iw6_alienminigun_mp")
			{
				var_04 = self getweaponammostock(var_03);
				var_05 = weaponmaxammo(var_03);
				var_06 = var_04 + var_05 * param_00;
				self setweaponammostock(var_03,castint(min(var_06,var_05)));
			}
		}
	}
}

//Function Number: 7
addfullcliptoallweapons()
{
	var_00 = self getweaponslistprimaries();
	foreach(var_02 in var_00)
	{
		var_03 = weaponclipsize(var_02);
		self setweaponammoclip(var_02,var_03);
	}
}

//Function Number: 8
addalienweaponammo(param_00)
{
	var_01 = self getweaponslistprimaries();
	switch(param_00.upgrade_rank)
	{
		case 0:
			addratiomaxstocktoallweapons(0.4);
			break;

		case 1:
			addratiomaxstocktoallweapons(0.7);
			break;

		case 2:
			addratiomaxstocktoallweapons(1);
			break;

		case 3:
			addratiomaxstocktoallweapons(1);
			addfullcliptoallweapons();
			break;

		case 4:
			addratiomaxstocktoallweapons(1);
			addfullcliptoallweapons();
			break;
	}
}

//Function Number: 9
canusedeployable(param_00)
{
	if(maps\mp\_utility::func_47BB() && isdefined(param_00) && param_00.owner == self && !isdefined(param_00.air_dropped))
	{
		return 0;
	}

	if(!maps\mp\_utility::func_47BB())
	{
		return !maps\mp\_utility::isjuggernaut();
	}

	return 1;
}