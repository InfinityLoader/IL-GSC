/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3594.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 9
 * Decompile Time: 4 ms
 * Timestamp: 10/27/2023 12:30:50 AM
*******************************************************************/

//Function Number: 1
func_1342F()
{
}

//Function Number: 2
func_13430()
{
	level endon("game_ended");
	self endon("end_explode");
	self.var_222 endon("disconnect");
	self waittill("explode",var_00);
	func_10E0B(var_00,self.var_222);
}

//Function Number: 3
func_10E0B(param_00,param_01)
{
	var_02 = [];
	var_03 = scripts\mp\_utility::getotherteam(param_01.team);
	var_02 = scripts\mp\_utility::func_807C(param_00,256);
	if(var_02.size > 0)
	{
		foreach(var_05 in var_02)
		{
			if(!isagent(var_05))
			{
				if(var_05.team == var_03 || var_05 == param_01)
				{
					var_06 = func_13431(var_02,var_05,self,param_00);
					if(!var_06)
					{
						continue;
					}

					var_05 thread func_5AE9(param_01,var_03);
				}
			}
		}
	}
}

//Function Number: 4
func_13431(param_00,param_01,param_02,param_03)
{
	var_04 = scripts\common\utility::array_add_safe(param_00,param_02);
	if(!scripts\common\trace::func_DCF1(param_03,param_01.origin + (0,0,32),var_04))
	{
		return 0;
	}

	return 1;
}

//Function Number: 5
func_5AE9(param_00,param_01)
{
	thread func_13BA1();
	if(isdefined(self.var_8C3B) && self.var_8C3B)
	{
		scripts\mp\_utility::func_E150("specialty_block_health_regen");
		self notify("force_regen");
		self notify("virus_complete");
	}

	self endon("death");
	self endon("disconnect");
	self endon("virus_complete");
	self.var_8C3B = 1;
	var_02 = 10;
	var_03 = 3;
	scripts\mp\_utility::func_8387("specialty_block_health_regen");
	self iprintlnbold("Systems infected by Virus!");
	thread func_D572();
	thread func_D573();
	self dodamage(50,self.origin,param_00,undefined,"MOD_EXPLOSIVE","virus_grenade_mp");
	while(var_03 > 0)
	{
		playfx(scripts\common\utility::getfx("vfx_virus_active_3rd_person"),self.origin + (0,0,32));
		wait(0.5);
		var_03 = var_03 - 0.5;
		func_10AA5(param_00,param_01);
	}

	wait(var_02);
	self iprintlnbold("Virus purged, rebooting systems...");
	self.var_8C3B = 0;
	scripts\mp\_utility::func_E150("specialty_block_health_regen");
	self notify("force_regen");
	self notify("virus_complete");
}

//Function Number: 6
func_D572()
{
	self endon("death");
	self endon("disconnect");
	self endon("virus_complete");
	var_00 = anglestoforward(self.angles);
	var_01 = anglestoup(self.angles);
	for(;;)
	{
		playfx(scripts\common\utility::getfx("vfx_virus_particles"),self.origin + (0,0,32),var_00,var_01);
		wait(0.1);
	}
}

//Function Number: 7
func_D573()
{
	self endon("death");
	self endon("disconnect");
	self endon("virus_complete");
	for(;;)
	{
		var_00 = function_01E1(scripts\common\utility::getfx("vfx_virus_particles_screen"),self geteye(),self);
		triggerfx(var_00);
		var_00 thread scripts\mp\_utility::func_51C7(self);
		wait(0.2);
		var_00 delete();
	}
}

//Function Number: 8
func_10AA5(param_00,param_01)
{
	var_02 = self.origin + (0,0,32);
	var_03 = scripts\mp\_utility::func_807C(var_02,256);
	if(var_03.size > 0)
	{
		foreach(var_05 in var_03)
		{
			if(!isagent(var_05))
			{
				if(var_05.team == param_01)
				{
					if((isdefined(var_05.var_8C3B) && !var_05.var_8C3B) || !isdefined(var_05.var_8C3B))
					{
						var_06 = func_13431(var_03,var_05,self,var_02);
						if(!var_06)
						{
							continue;
						}

						var_05 thread func_5AE9(param_00,param_01);
					}
				}
			}
		}
	}
}

//Function Number: 9
func_13BA1()
{
	level endon("game_ended");
	self endon("disconnect");
	self endon("player_spawned");
	self waittill("death");
	if(isdefined(self.var_8C3B))
	{
		self.var_8C3B = undefined;
	}
}