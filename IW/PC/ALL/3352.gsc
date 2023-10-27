/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3352.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:26:44 AM
*******************************************************************/

//Function Number: 1
func_F81E()
{
	thread func_13A62();
}

//Function Number: 2
func_12D1B()
{
	self notify("rewindUnset");
	self setscriptablepartstate("rewind","neutral",0);
	thread func_E163();
}

//Function Number: 3
func_10DEB()
{
	self endon("disconnect");
	self setscriptablepartstate("rewind","activeStart",0);
	self.ability_invulnerable = 1;
	scripts\common\utility::func_1C6E(0);
	self limitedmovement(0);
	self notify("cancel_sentry");
	self notify("cancel_medusa");
	self notify("cancel_trap");
	self notify("cancel_boombox");
	self notify("cancel_revocator");
	self notify("cancel_ims");
	self notify("cancel_gascan");
	scripts\common\utility::func_136F7();
	foreach(var_01 in level.players)
	{
		if(var_01 == self)
		{
			continue;
		}

		self method_8429(var_01);
	}

	self.isrewinding = 1;
	scripts\cp\_utility::func_17C0("rewind",0,0);
	self motionblurhqenable();
	func_E2EB();
}

//Function Number: 4
delayed_unset_damage_modifier()
{
	self endon("disconnect");
	wait(2);
	self.ability_invulnerable = undefined;
	scripts\cp\_utility::func_E0E6("rewind",0);
}

//Function Number: 5
func_637E()
{
	self setscriptablepartstate("rewind","activeEnd",0);
	scripts\common\utility::func_136F7();
	if(!self isonground())
	{
		self.flung = 1;
		self limitedmovement(1);
		thread func_12CE7();
	}

	thread delayed_unset_damage_modifier();
	func_E4D5();
	func_E4C7();
	func_E163();
}

//Function Number: 6
func_12CE7()
{
	self endon("disconnect");
	while(!self isonground() && isalive(self))
	{
		wait(0.05);
	}

	self.flung = undefined;
	self limitedmovement(0);
}

//Function Number: 7
func_E163()
{
	self.isrewinding = undefined;
	self.ability_invulnerable = undefined;
	scripts\cp\_utility::func_E0E6("rewind",0);
	if(!scripts\common\utility::func_9FBE())
	{
		scripts\common\utility::func_1C6E(1);
	}

	self playanimscriptevent("power_exit","rewind");
	foreach(var_01 in level.players)
	{
		if(var_01 == self)
		{
			continue;
		}

		self showtoplayer(var_01);
	}

	self method_8208();
	func_E2DC();
}

//Function Number: 8
func_13A62()
{
	self endon("disconnect");
	self endon("rewindUnset");
	self notify("watchForRewind");
	self endon("watchForRewind");
	for(;;)
	{
		var_00 = spawnstruct();
		childthread func_13A66(var_00);
		childthread func_13A64(var_00);
		childthread func_13A63(var_00);
		childthread func_13A65(var_00);
		self waittill("rewindBeginRace");
		waittillframeend;
		if(isdefined(var_00.var_6ACF))
		{
			scripts\cp\powers\coop_powers::func_D71A(1,"secondary");
		}
		else if(isdefined(var_00.var_10DE6) && isdefined(var_00.var_4E59))
		{
			scripts\cp\powers\coop_powers::func_D71A(1,"secondary");
		}
		else if(isdefined(var_00.var_637B))
		{
			func_637E();
		}
		else if(isdefined(var_00.var_10DE6))
		{
			func_10DEB();
		}

		self notify("rewindEndRace");
	}
}

//Function Number: 9
func_13A66(param_00)
{
	self endon("rewindEndRace");
	self waittill("rewindStart");
	param_00.var_10DE6 = 1;
	self notify("rewindBeginRace");
}

//Function Number: 10
func_13A64(param_00)
{
	self endon("rewindEndRace");
	self waittill("rewindEnd");
	param_00.var_637B = 1;
	self notify("rewindBeginRace");
	self notify("powers_rewind_used",1);
}

//Function Number: 11
func_13A63(param_00)
{
	self endon("rewindEndRace");
	self waittill("death");
	param_00.var_4E59 = 1;
	self notify("rewindBeginRace");
}

//Function Number: 12
func_13A65(param_00)
{
	self endon("rewindEndRace");
	self waittill("rewindFailed");
	param_00.var_6ACF = 1;
	self notify("rewindBeginRace");
	self notify("powers_rewind_used",0);
}

//Function Number: 13
func_E4D5()
{
	var_00 = self.maxhealth - self.health;
	self.health = self.maxhealth;
}

//Function Number: 14
func_E4C7()
{
	var_00 = self getweaponslistprimaries();
	foreach(var_02 in var_00)
	{
		if(scripts\cp\_utility::func_9C42(var_02))
		{
			continue;
		}

		var_03 = function_024B(var_02);
		var_04 = self getweaponammoclip(var_02) + self getweaponammostock(var_02);
		var_05 = scripts\common\utility::func_116D7(var_03 > var_04,var_03,var_04);
		var_06 = int(min(weaponclipsize(var_02),var_05));
		var_07 = var_05 - var_06;
		self setweaponammoclip(var_02,var_06);
		self setweaponammostock(var_02,var_07);
	}
}

//Function Number: 15
func_E2EB()
{
	if(scripts\common\utility::istrue(self.var_E4D9))
	{
		return;
	}

	self.var_E4D9 = 1;
	scripts\common\utility::func_1C76(0);
	scripts\common\utility::func_1C6E(0);
	scripts\cp\_utility::allow_player_teleport(0);
	thread func_E2EC();
}

//Function Number: 16
func_E2DC()
{
	if(!scripts\common\utility::istrue(self.var_E4D9))
	{
		return;
	}

	self.var_E4D9 = undefined;
	if(!scripts\common\utility::func_A009())
	{
		scripts\common\utility::func_1C76(1);
	}

	if(!scripts\common\utility::func_9FBE())
	{
		scripts\common\utility::func_1C6E(1);
	}

	if(!scripts\cp\_utility::isteleportenabled())
	{
		scripts\cp\_utility::allow_player_teleport(1);
	}
}

//Function Number: 17
func_E2EC()
{
	self endon("disconnect");
	self endon("rewindUnset");
	self notify("rewindRestrictFunctionalityCleanup");
	self endon("rewindRestrictFunctionalityCleanup");
	self waittill("death");
	self.var_E4D9 = undefined;
}