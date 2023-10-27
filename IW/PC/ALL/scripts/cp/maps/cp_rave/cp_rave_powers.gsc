/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\maps\cp_rave\cp_rave_powers.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 289 ms
 * Timestamp: 10/27/2023 12:06:34 AM
*******************************************************************/

//Function Number: 1
init()
{
	scripts\cp\powers\coop_powers::func_D787("power_transponder",::scripts\cp\powers\coop_powers::func_F896,::scripts\cp\powers\coop_powers::func_12D50,undefined,"transponder_update","powers_transponder_used",undefined);
	scripts\cp\powers\coop_powers::func_D787("power_armageddon",undefined,undefined,::scripts\cp\powers\coop_powers::func_13043,undefined,undefined,undefined);
	scripts\cp\powers\coop_powers::func_D787("power_microTurret",undefined,undefined,undefined,"microTurret_update","powers_microTurret_used",undefined);
	scripts\cp\powers\coop_powers::func_D787("power_rewind",::scripts\cp\powers\coop_powers::func_F81E,::scripts\cp\powers\coop_powers::func_12D1B,::scripts\cp\powers\coop_powers::func_130CE,undefined,"powers_rewind_used",undefined);
	scripts\cp\powers\coop_powers::func_D787("power_repulsor",undefined,undefined,::scripts\cp\powers\coop_powers::func_130CD,undefined,undefined,undefined);
	scripts\cp\powers\coop_powers::func_D787("power_blackholeGrenade",undefined,undefined,undefined,undefined,"powers_blackholeGrenade_used",undefined);
	scripts\cp\powers\coop_powers::func_D787("power_tripMine",undefined,undefined,undefined,"trip_mine_update",undefined,undefined);
	scripts\cp\powers\coop_powers::func_D787("power_portalGenerator",undefined,undefined,undefined,undefined,"powers_portalGenerator_used",undefined);
	scripts\cp\powers\coop_powers::func_D787("power_c4",undefined,undefined,undefined,"c4_update",undefined,undefined);
	scripts\cp\powers\coop_powers::func_D787("power_bait",::setbait,::unsetbait,undefined,undefined,undefined,undefined);
	thread lib_0D17::init();
	thread lib_0D1E::init();
	thread lib_0D0F::init();
	thread lib_0D1F::func_127E3();
	thread lib_0D04::func_2B3C();
}

//Function Number: 2
listen_for_bait_throw()
{
	self endon("disconnect");
	self endon("stop_bait_listen");
	for(;;)
	{
		self waittill("grenade_fire",var_00,var_01);
		if(isdefined(var_00) && isdefined(var_01))
		{
			var_00 thread func_135DE(var_01,self);
		}
	}
}

//Function Number: 3
func_135DE(param_00,param_01)
{
	self endon("disconnect");
	self endon("stop_bait_listen");
	if(!isdefined(self.var_13C2E) || self.var_13C2E != "iw7_bait_zm")
	{
		return;
	}

	self waittill("explode",var_02);
	var_03 = getentarray("bait_head","targetname");
	var_04 = scripts\common\utility::getclosest(var_02,var_03,500);
	if(isdefined(var_04))
	{
		if(isdefined(var_04.bait))
		{
			var_04.bait delete();
		}

		var_04.bait = spawn("script_origin",var_02);
		var_04.bait_time = gettime();
	}
}

//Function Number: 4
setbait(param_00)
{
	self notify("stop_bait_listen");
	thread listen_for_bait_throw();
}

//Function Number: 5
unsetbait()
{
	self notify("stop_bait_listen");
}