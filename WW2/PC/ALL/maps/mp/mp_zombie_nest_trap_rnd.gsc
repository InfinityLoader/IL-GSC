/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_zombie_nest_trap_rnd.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 170 ms
 * Timestamp: 10/27/2023 3:20:07 AM
*******************************************************************/

//Function Number: 1
func_9CC0(param_00)
{
	var_01 = getentarray(param_00.var_1A2,"targetname");
	level.var_9CC0 = var_01[0];
	level.var_9CC0.var_9C92 = param_00;
	level.var_9CC0.var_9CBB = param_00.var_165;
	thread lib_0378::func_8D74("aud_trap_elec_start");
	foreach(var_03 in var_01)
	{
		if(!isdefined(var_03.var_165))
		{
			continue;
		}

		if(var_03.var_165 == "damage_over_time")
		{
			param_00 thread is_slide_sfx_playing(var_03);
			param_00 thread func_9CC3(var_03);
			wait 0.05;
		}
	}

	thread is_slide_land_sfx_playing(param_00);
}

//Function Number: 2
is_slide_sfx_playing(param_00)
{
	self endon("cooldown");
	self endon("no_power");
	self endon("deactivate");
	self endon("ready");
	var_01 = 0;
	var_02 = 0.25;
	if(isdefined(self.var_817A))
	{
		var_03 = self.var_817A;
	}
	else
	{
		var_03 = 20;
	}

	while(var_01 < var_03)
	{
		wait(var_02);
		var_01 = var_01 + var_02;
		foreach(var_05 in level.var_744A)
		{
			if(!var_05 istouching(param_00))
			{
				continue;
			}

			var_05 thread func_35B1();
		}
	}
}

//Function Number: 3
func_9CC3(param_00)
{
	self endon("cooldown");
	self endon("no_power");
	self endon("deactivate");
	self endon("ready");
	var_01 = 0;
	var_02 = 0.15;
	if(isdefined(self.var_817A))
	{
		var_03 = self.var_817A;
	}
	else
	{
		var_03 = 20;
	}

	while(var_01 < var_03)
	{
		wait(var_02);
		var_01 = var_01 + var_02;
		var_04 = lib_0547::func_408F();
		foreach(var_06 in var_04)
		{
			if(!isdefined(var_06) || !isalive(var_06))
			{
				continue;
			}

			if(isplayer(var_06))
			{
				continue;
			}

			if(!var_06 istouching(param_00))
			{
				continue;
			}

			maps/mp/mp_zombie_nest_ee_hc_raven_weapon_upgrades::func_6FEE(var_06);
			var_06 lib_054D::func_99B("electroBuff",var_06 func_44B0(self.var_117));
		}
	}
}

//Function Number: 4
is_slide_land_sfx_playing(param_00)
{
	for(;;)
	{
		param_00 waittill("trap_state_change",var_01);
		if(var_01 == "cooldown" || var_01 == "no_power" || var_01 == "deactivate")
		{
		}
	}
}

//Function Number: 5
func_44B0(param_00)
{
	var_01 = lib_054D::func_443F("electroBuff");
	if(!isdefined(var_01))
	{
		var_01 = func_9048();
	}

	if(isdefined(self.var_A4B) && self.var_A4B == "zombie_heavy")
	{
		var_01.var_29D5 = 600 * lib_054D::func_4441();
	}

	var_01.var_5CC8 = 0.2;
	var_01.var_721C = param_00;
	return var_01;
}

//Function Number: 6
func_9048()
{
	var_00 = spawnstruct();
	var_00.var_1CF2 = ::func_A10B;
	var_00.var_1CF0 = ::func_7CD9;
	var_00.var_5CC8 = 0.2;
	var_00.var_29D5 = 60 * lib_054D::func_4441();
	var_00.var_90F0 = 0.6;
	self notify("speed_debuffs_changed");
	return var_00;
}

//Function Number: 7
func_A10B(param_00)
{
	if(lib_0547::func_580A())
	{
		self dodamage(param_00.var_29D5 * 0.25,self.var_116,level.var_9CC0,level.var_9CC0,"MOD_ENERGY","trap_zm_mp");
		return;
	}

	self dodamage(param_00.var_29D5,self.var_116,level.var_9CC0,level.var_9CC0,"MOD_ENERGY","trap_zm_mp");
	if(!isdefined(self.hitbytrap))
	{
		foreach(var_02 in level.var_744A)
		{
			var_02 maps/mp/gametypes/zombies::func_47C7("kill_trap");
			self.hitbytrap = 1;
		}
	}
}

//Function Number: 8
func_7CD9(param_00)
{
	self notify("speed_debuffs_changed");
}

//Function Number: 9
func_35B1()
{
}