/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\mp_zombie_nest_trap_med.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 117 ms
 * Timestamp: 10/27/2023 3:20:06 AM
*******************************************************************/

//Function Number: 1
func_9CB8(param_00)
{
	param_00.var_9CB9 = getent("electric_trap_origin","targetname");
	level.var_9CB8 = param_00.var_9CB9;
	level.var_9CB8.var_9C92 = param_00;
	level.var_9CB8.var_9CBB = param_00.var_165;
	param_00 thread func_8B0D();
}

//Function Number: 2
func_8B0D()
{
	self.var_9CB9.var_565F = 1;
	var_00 = common_scripts\utility::func_46B5("med_trap_fx_point","targetname");
	var_01 = spawnfx(level.var_611["zmb_med_spike_trap_on"],var_00.var_116,anglestoforward(var_00.var_1D));
	triggerfx(var_01);
	thread func_30E4(var_00);
	thread func_30E3(var_00);
	lib_0378::func_8D74("aud_trap_spikes",self.var_9CB9.var_116);
	common_scripts\utility::knock_off_battery("cooldown","no_power","ready","deactivate");
	var_01 delete();
	self.var_9CB9.var_565F = 0;
}

//Function Number: 3
func_2FF4()
{
	self endon("med_trap_stop_fx");
	self.var_16F7 = spawn("script_model",self.var_116);
	self.var_16F7 setmodel("tag_origin");
	self.var_16F2 = spawn("script_model",self.var_116);
	self.var_16F2 setmodel("tag_origin");
	for(;;)
	{
		for(var_00 = 0;var_00 < 2;var_00++)
		{
			self.var_16F7.var_116 = self.var_116;
			self.var_16F2.var_116 = self gettagorigin("TAG_Chains_0" + var_00 + 1);
			var_01 = launchbeam("zmb_electricity_reg_beam_med",self.var_16F7,"tag_origin",self.var_16F2,"tag_origin");
			self.var_16F7 moveto(self.var_16F2.var_116,1);
			wait(1);
			var_01 delete();
		}
	}
}

//Function Number: 4
func_93C3()
{
	self notify("med_trap_stop_fx");
	wait 0.05;
	self.var_16F7 delete();
	self.var_16F2 delete();
}

//Function Number: 5
func_30E4(param_00)
{
	while(self.var_9CB9.var_565F)
	{
		var_01 = lib_0547::func_408F();
		foreach(var_03 in var_01)
		{
			if(distance2d(var_03.var_116,param_00.var_116) < 135 && var_03.var_116[2] < self.var_9CB9.var_116[2])
			{
				playfx(level.var_611["zmb_med_trap_gib"],var_03.var_116 + (0,0,50),anglestoforward(var_03.var_1D));
				wait 0.05;
				var_04 = gettime();
				if(isalive(var_03) && var_03.var_BA4 != "traverse")
				{
					if(!isdefined(var_03.var_A874) || isdefined(var_03.var_A874) && var_04 > var_03.var_A874 + 1000)
					{
						if(var_03 lib_0547::func_580A())
						{
							var_03 dodamage(var_03.var_BC * 0.1,self.var_9CB9.var_116,level.var_9CB8,level.var_9CB8,"MOD_EXPLOSIVE","trap_zm_mp");
						}
						else
						{
							maps/mp/mp_zombie_nest_ee_hc_raven_weapon_upgrades::func_6FEE(var_03);
							var_03 dodamage(var_03.var_BC + 666,self.var_9CB9.var_116,level.var_9CB8,level.var_9CB8,"MOD_EXPLOSIVE","trap_zm_mp");
							if(!isdefined(self.hitbytrap))
							{
								foreach(var_06 in level.var_744A)
								{
									var_06 maps/mp/gametypes/zombies::func_47C7("kill_trap");
									self.hitbytrap = 1;
								}
							}
						}

						if(isalive(var_03))
						{
							var_03.var_A874 = gettime();
						}
					}

					wait 0.05;
				}
			}
		}

		wait(0.15);
	}
}

//Function Number: 6
func_30E3(param_00)
{
	while(self.var_9CB9.var_565F)
	{
		var_01 = level.var_744A;
		foreach(var_03 in var_01)
		{
			if(!isalive(var_03))
			{
				continue;
			}

			if(lib_0547::func_577E(var_03))
			{
				continue;
			}

			if(distance2d(var_03.var_116,param_00.var_116) < 135 && var_03.var_116[2] < self.var_9CB9.var_116[2])
			{
				wait 0.05;
				var_04 = gettime();
				if(!isdefined(var_03.var_A874))
				{
					var_03.var_A874 = gettime();
				}

				if(isalive(var_03) && var_04 > var_03.var_A874 + 500 && !lib_0547::func_577E(var_03))
				{
					var_03 dodamage(5,self.var_9CB9.var_116,undefined,undefined,"MOD_CRUSH");
					var_03.var_A874 = gettime();
					wait 0.05;
				}
			}
		}

		wait(0.15);
	}
}