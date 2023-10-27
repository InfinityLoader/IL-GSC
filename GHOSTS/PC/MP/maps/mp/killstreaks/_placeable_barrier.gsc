/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\killstreaks\_placeable_barrier.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 10
 * Decompile Time: 173 ms
 * Timestamp: 10/27/2023 1:21:23 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	var_00 = spawnstruct();
	var_00.streakname = "placeable_barrier";
	var_00.weaponinfo = "ims_projectile_mp";
	var_00.modelbase = "placeable_barrier";
	var_00.modeldestroyed = "placeable_barrier_destroyed";
	var_00.modelplacement = "placeable_barrier_obj";
	var_00.modelplacementfailed = "placeable_barrier_obj_red";
	var_00.hintstring = &"KILLSTREAKS_HINTS_PLACEABLE_COVER_PICKUP";
	var_00.placestring = &"KILLSTREAKS_HINTS_PLACEABLE_COVER_PLACE";
	var_00.cannotplacestring = &"KILLSTREAKS_HINTS_PLACEABLE_COVER_CANNOT_PLACE";
	var_00.headiconheight = 75;
	var_00.splashname = "used_placeable_barrier";
	var_00.lifespan = 60;
	var_00.maxhealth = 500;
	var_00.allowmeleedamage = 0;
	var_00.damagefeedback = "ims";
	var_00.xppopup = "destroyed_ims";
	var_00.destroyedvo = "ims_destroyed";
	var_00.onplaceddelegate = ::func_595A;
	var_00.oncarrieddelegate = ::func_5902;
	var_00.placedsfx = "ims_plant";
	var_00.ondamageddelegate = ::ondamaged;
	var_00.ondeathdelegate = ::ondeath;
	var_00.deathvfx = loadfx("vfx/gameplay/mp/killstreaks/vfx_ballistic_vest_death");
	var_00.colradius = 72;
	var_00.colheight = 36;
	level.placeableconfigs["placeable_barrier"] = var_00;
	func_71ED();
	level.killstreakfuncs["placeable_barrier"] = ::func_8446;
}

//Function Number: 2
func_8446(param_00,param_01)
{
	var_02 = lib_0614::func_3CFF("placeable_barrier");
	if(var_02)
	{
		maps\mp\_matchdata::func_4F1D("placeable_barrier",self.origin);
	}

	self.iscarrying = undefined;
	return var_02;
}

//Function Number: 3
createobject(param_00)
{
}

//Function Number: 4
func_595A(param_00)
{
	var_01 = level.placeableconfigs[param_00];
	self setmodel(var_01.modelbase);
	var_02 = common_scripts\utility::func_7836();
	var_02 show();
	var_02.origin = self.origin;
	if(!isdefined(level.barriercollision))
	{
		func_71ED();
	}

	var_02 clonebrushmodeltoscriptmodel(level.barriercollision);
	var_03 = maps\mp\_utility::getotherteam(self.owner.team);
	badplace_cylinder(param_00 + self getentitynumber(),-1,self.origin,var_01.colradius,var_01.colheight,var_03);
	self.collision = var_02;
}

//Function Number: 5
func_5902(param_00)
{
	disablecollision(param_00);
}

//Function Number: 6
ondamaged(param_00,param_01,param_02,param_03)
{
	return param_03;
}

//Function Number: 7
func_5915(param_00,param_01,param_02,param_03)
{
}

//Function Number: 8
ondeath(param_00)
{
	disablecollision(param_00);
	var_01 = level.placeableconfigs[param_00];
	if(isdefined(var_01.deathsfx))
	{
		self playsound(var_01.deathsfx);
	}

	playfx(var_01.deathvfx,self.origin);
	wait(0.5);
}

//Function Number: 9
disablecollision(param_00)
{
	if(isdefined(self.collision))
	{
		badplace_delete(param_00 + self getentitynumber());
		self.collision delete();
		self.collision = undefined;
	}
}

//Function Number: 10
func_71ED()
{
	var_00 = getent("barrier_collision","targetname");
	if(isdefined(var_00))
	{
		level.barriercollision = getent(var_00.target,"targetname");
		var_00 delete();
	}

	if(!isdefined(level.barriercollision))
	{
		level.barriercollision = level.airdropcratecollision;
	}
}