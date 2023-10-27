/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_deployablebox_gun.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 184 ms
 * Timestamp: 10/27/2023 1:20:36 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	var_00 = spawnstruct();
	var_00.id = "deployable_weapon_crate";
	var_00.weaponinfo = "deployable_weapon_crate_marker_mp";
	var_00.modelbase = "mp_weapon_crate";
	var_00.modelbombsquad = "mp_weapon_crate_bombsquad";
	var_00.hintstring = &"KILLSTREAKS_HINTS_DEPLOYABLE_AMMO_USE";
	var_00.capturingstring = &"KILLSTREAKS_DEPLOYABLE_AMMO_TAKING";
	var_00.event = "deployable_ammo_taken";
	var_00.streakname = "deployable_ammo";
	var_00.splashname = "used_deployable_ammo";
	var_00.shadername = "compass_objpoint_deploy_ammo_friendly";
	var_00.headiconoffset = 20;
	var_00.lifespan = 90;
	var_00.vogone = "ammocrate_gone";
	var_00.usexp = 50;
	var_00.xppopup = "destroyed_ammo";
	var_00.vodestroyed = "ammocrate_destroyed";
	var_00.deployedsfx = "mp_vest_deployed_ui";
	var_00.onusesfx = "ammo_crate_use";
	var_00.onusecallback = ::func_5987;
	var_00.canusecallback = ::canusedeployable;
	var_00.nousekillstreak = 1;
	var_00.usetime = 1000;
	var_00.maxhealth = 150;
	var_00.damagefeedback = "deployable_bag";
	var_00.deathvfx = loadfx("vfx/gameplay/mp/killstreaks/vfx_ballistic_vest_death");
	var_00.allowmeleedamage = 1;
	var_00.allowgrenadedamage = 0;
	var_00.maxuses = 4;
	var_00.minigunchance = 20;
	var_00.minigunweapon = "iw6_minigun_mp";
	var_00.ammorestockcheckfreq = 0.5;
	var_00.ammorestocktime = 10;
	var_00.triggerradius = 200;
	var_00.triggerheight = 64;
	var_00.ondeploycallback = ::func_58FE;
	var_00.canuseotherboxes = 0;
	level.boxsettings["deployable_ammo"] = var_00;
	level.killstreakfuncs["deployable_ammo"] = ::func_842D;
	level.deployablegunbox_bonusinxuses = randomintrange(1,var_00.minigunchance + 1);
	level.deployable_box["deployable_ammo"] = [];
	maps/mp/gametypes/sotf::definechestweapons();
}

//Function Number: 2
func_842D(param_00,param_01)
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
	level.deployablegunbox_bonusinxuses--;
	if(level.deployablegunbox_bonusinxuses == 0)
	{
		var_01 = level.boxsettings[param_00.boxtype];
		if(isdefined(level.deployableboxgiveweaponfunc))
		{
			[[ level.deployableboxgiveweaponfunc ]](1);
		}
		else
		{
			func_3CEC(self,var_01.minigunweapon);
		}

		maps\mp\gametypes\_missions::func_61CE("ch_guninabox");
		level.deployablegunbox_bonusinxuses = randomintrange(var_01.minigunchance,var_01.minigunchance + 1);
	}

	giverandomgun(self);
}

//Function Number: 4
func_58FE(param_00)
{
	thread restockammoaura(param_00);
}

//Function Number: 5
giverandomgun(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00 getweaponslistprimaries())
	{
		var_01[var_01.size] = getweaponbasename(var_03);
	}

	var_05 = undefined;
	for(;;)
	{
		var_05 = maps/mp/gametypes/sotf::func_3BBF(level.weaponarray);
		var_06 = var_05["name"];
		if(!common_scripts\utility::array_contains(var_01,var_06))
		{
			break;
		}
	}

	var_05 = maps/mp/gametypes/sotf::getrandomattachments(var_05);
	func_3CEC(param_00,var_05);
}

//Function Number: 6
func_3CEC(param_00,param_01)
{
	var_02 = param_00 getweaponslistprimaries();
	var_03 = 0;
	foreach(var_05 in var_02)
	{
		if(!maps\mp\gametypes\_weapons::func_4871(var_05))
		{
			var_03++;
		}
	}

	if(var_03 > 1)
	{
		var_07 = param_00.lastdroppableweapon;
		if(isdefined(var_07) && var_07 != "none")
		{
			param_00 dropitem(var_07);
		}
	}

	param_00 maps\mp\_utility::_giveweapon(param_01);
	param_00 switchtoweapon(param_01);
	param_00 givestartammo(param_01);
}

//Function Number: 7
restockammoaura(param_00)
{
	self endon("death");
	level endon("game_eneded");
	var_01 = spawn("trigger_radius",self.origin,0,param_00.triggerradius,param_00.triggerheight);
	var_01.owner = self;
	thread maps\mp\gametypes\_weapons::deleteondeath(var_01);
	if(isdefined(self.moving_platform))
	{
		var_01 enablelinkto();
		var_01 linkto(self.moving_platform);
	}

	var_02 = param_00.triggerradius * param_00.triggerradius;
	var_03 = undefined;
	for(;;)
	{
		var_04 = var_01 getistouchingentities(level.players);
		foreach(var_03 in var_04)
		{
			if(isdefined(var_03) && !self.owner maps\mp\_utility::isenemy(var_03) && func_749B(var_03))
			{
				addammo(var_03,param_00.ammorestocktime);
			}
		}

		wait(param_00.ammorestockcheckfreq);
	}
}

//Function Number: 8
func_749B(param_00)
{
	return !isdefined(param_00.deployablegunnextammotime) || gettime() >= param_00.deployablegunnextammotime;
}

//Function Number: 9
addammo(param_00,param_01)
{
	param_00.deployablegunnextammotime = gettime() + param_01 * 1000;
	maps\mp\gametypes\_weapons::func_6AC6(param_00);
	param_00 maps\mp\gametypes\_damagefeedback::hudicontype("boxofguns");
}

//Function Number: 10
addammoovertime(param_00,param_01,param_02)
{
	self endon("death");
	param_00 endon("death");
	param_00 endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		addammo(param_00);
		wait(param_02);
		if(distancesquared(param_00.origin,self.origin) > param_01)
		{
			break;
		}
	}
}

//Function Number: 11
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