/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\killstreaks\_deployablebox_gun.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 14
 * Decompile Time: 610 ms
 * Timestamp: 10/27/2023 12:28:23 AM
*******************************************************************/

//Function Number: 1
init()
{
	var_00 = spawnstruct();
	var_00.var_92B8 = "deployable_weapon_crate";
	var_00.var_39B = "crate_marker_mp";
	var_00.var_B91A = "mp_weapon_crate";
	var_00.var_B91C = "mp_weapon_crate_bombsquad";
	var_00.var_17B = &"KILLSTREAKS_HINTS_DEPLOYABLE_AMMO_USE";
	var_00.var_3A41 = &"KILLSTREAKS_DEPLOYABLE_AMMO_TAKING";
	var_00.var_67E5 = "deployable_ammo_taken";
	var_00.var_110EA = "deployable_ammo";
	var_00.var_10A38 = "used_deployable_ammo";
	var_00.var_FC47 = "compass_objpoint_deploy_ammo_friendly";
	var_00.var_8C7A = 20;
	var_00.var_AC71 = 20;
	var_00.var_13524 = "ammocrate_gone";
	var_00.var_130FC = 0;
	var_00.var_EC44 = "destroyed_ammo";
	var_00.var_13523 = "ammocrate_destroyed";
	var_00.var_5230 = "mp_vest_deployed_ui";
	var_00.var_C5C7 = "ammo_crate_use";
	var_00.var_C5BC = ::func_C5BE;
	var_00.var_3936 = ::func_3937;
	var_00.var_C18C = 1;
	var_00.var_130EE = 1000;
	var_00.maxhealth = 128;
	var_00.var_4D4A = "deployable_bag";
	var_00.var_4E74 = loadfx("vfx/core/mp/killstreaks/vfx_ballistic_vest_death");
	var_00.var_1C9D = 1;
	var_00.var_1C96 = 0;
	var_00.var_B4D1 = 4;
	var_00.var_B7A5 = 20;
	var_00.var_B7A8 = "iw6_minigun_mp";
	var_00.var_1E4B = 0.5;
	var_00.var_1E4C = 10;
	var_00.var_127C8 = 200;
	var_00.var_127C5 = 64;
	var_00.var_C4F0 = ::func_C4CF;
	var_00.var_393B = 0;
	level.var_2F30["deployable_ammo"] = var_00;
	scripts\mp\killstreaks\_killstreaks::func_DEFB("deployable_ammo",undefined,::func_128DD);
	level.var_5226 = randomintrange(1,var_00.var_B7A5 + 1);
	level.var_5212["deployable_ammo"] = [];
}

//Function Number: 2
func_1E3C(param_00)
{
	func_128D7(1,param_00,"ammo_box_mp");
}

//Function Number: 3
func_128D7(param_00,param_01,param_02)
{
	var_03 = scripts\mp\killstreaks\_deployablebox::func_2A63(param_00,"deployable_ammo",param_01,param_02);
	if(!isdefined(var_03) || !var_03)
	{
		return 0;
	}

	return 1;
}

//Function Number: 4
func_128DD(param_00,param_01)
{
	var_02 = scripts\mp\killstreaks\_deployablebox::func_2A63(param_00.var_AC68,"deployable_ammo",param_01,param_00.var_394);
	if(!isdefined(var_02) || !var_02)
	{
		return 0;
	}

	scripts\mp\_matchdata::func_AFC9("deployable_ammo",self.origin);
	return 1;
}

//Function Number: 5
func_C5BE(param_00)
{
	level.var_5226--;
	if(level.var_5226 == 0)
	{
		var_01 = level.var_2F30[param_00.var_2F33];
		if(isdefined(level.var_5222))
		{
			[[ level.var_5222 ]](1);
		}
		else
		{
			func_836B(self,var_01.var_B7A8);
		}

		scripts\mp\_missions::func_D992("ch_guninabox");
		level.var_5226 = randomintrange(var_01.var_B7A5,var_01.var_B7A5 + 1);
		return;
	}

	func_8399(self);
}

//Function Number: 6
func_C4CF(param_00)
{
	thread func_E2B7(param_00);
}

//Function Number: 7
func_8399(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00 getweaponslistprimaries())
	{
		var_01[var_01.size] = getweaponbasename(var_03);
	}

	var_05 = undefined;
	for(;;)
	{
		var_05 = scripts\mp\gametypes\sotf::func_80C5(level.var_13C73);
		var_06 = var_05["name"];
		if(!scripts\common\utility::func_2286(var_01,var_06))
		{
			break;
		}
	}

	var_05 = scripts\mp\gametypes\sotf::func_80B1(var_05);
	func_836B(param_00,var_05);
}

//Function Number: 8
func_836B(param_00,param_01)
{
	var_02 = param_00 getweaponslistprimaries();
	var_03 = 0;
	foreach(var_05 in var_02)
	{
		if(!scripts\mp\_weapons::func_9D3E(var_05))
		{
			var_03++;
		}
	}

	if(var_03 > 1)
	{
		var_07 = param_00.var_A978;
		if(isdefined(var_07) && var_07 != "none")
		{
			param_00 method_80B8(var_07);
		}
	}

	param_00 scripts\mp\_utility::func_12C6(param_01);
	param_00 scripts\mp\_utility::_switchtoweapon(param_01);
	param_00 method_817C(param_01);
}

//Function Number: 9
func_E2B7(param_00)
{
	self endon("death");
	level endon("game_eneded");
	var_01 = spawn("trigger_radius",self.origin,0,param_00.var_127C8,param_00.var_127C5);
	var_01.var_222 = self;
	thread scripts\mp\_weapons::func_51BF(var_01);
	if(isdefined(self.var_BD3B))
	{
		var_01 enablelinkto();
		var_01 linkto(self.var_BD3B);
	}

	var_02 = param_00.var_127C8 * param_00.var_127C8;
	var_03 = undefined;
	for(;;)
	{
		var_04 = var_01 getistouchingentities(level.players);
		foreach(var_03 in var_04)
		{
			if(isdefined(var_03) && !self.var_222 scripts\mp\_utility::func_9DD6(var_03))
			{
				if(!isdefined(var_03.var_116D0) || !var_03.var_116D0)
				{
					var_03 thread func_93EF();
				}

				if(func_FFB8(var_03))
				{
					func_17A8(var_03,param_00.var_1E4C);
				}
			}
		}

		wait(param_00.var_1E4B);
	}
}

//Function Number: 10
func_93EF()
{
	self endon("death");
	self endon("disconnect");
	thread scripts\mp\_utility::func_F5C6(0,6000,2,0);
	thread scripts\mp\_utility::func_F5C5(0,1,2,0);
	scripts\mp\_powers::func_D740(1.1);
	wait(2);
	scripts\mp\_powers::func_D74E();
}

//Function Number: 11
func_FFB8(param_00)
{
	return !isdefined(param_00.var_5227) || gettime() >= param_00.var_5227;
}

//Function Number: 12
func_17A8(param_00,param_01)
{
	param_00.var_5227 = gettime() + param_01 * 1000;
	scripts\mp\_weapons::func_EBD2(param_00);
}

//Function Number: 13
func_17A9(param_00,param_01,param_02)
{
	self endon("death");
	param_00 endon("death");
	param_00 endon("disconnect");
	level endon("game_ended");
	for(;;)
	{
		func_17A8(param_00);
		wait(param_02);
		if(distancesquared(param_00.origin,self.origin) > param_01)
		{
			break;
		}
	}
}

//Function Number: 14
func_3937(param_00)
{
	return !scripts\mp\_utility::func_9E59();
}