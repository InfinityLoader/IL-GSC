/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3348.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:26:37 AM
*******************************************************************/

//Function Number: 1
func_D687()
{
	level._effect["portal_open"] = loadfx("vfx/iw7/core/zombie/vfx_zmb_portal_generator.vfx");
}

//Function Number: 2
func_D68B(param_00)
{
	if(!isalive(self))
	{
		param_00 delete();
		return;
	}

	param_00 waittill("missile_stuck",var_01);
	if(scripts\common\utility::istrue(self.var_9C54))
	{
		thread func_CC21(param_00);
		return;
	}

	if(isdefined(var_01) && isdefined(var_01.var_222))
	{
		thread func_CC21(param_00);
		return;
	}

	if(scripts\common\utility::flag("disable_portals"))
	{
		thread func_CC21(param_00);
		return;
	}

	foreach(var_03 in level.players)
	{
		if(var_03 == self)
		{
			continue;
		}

		if(distance(var_03.origin,param_00.origin) < 50)
		{
			thread func_CC21(param_00);
			return;
		}
	}

	if(scripts\cp\_weapon::func_9E54(param_00.origin,level.var_9B0B,self,undefined,1,var_01))
	{
		var_05 = self canplayerplacesentry(1,12);
		var_06 = spawn("script_model",param_00.origin);
		var_06 setmodel("black_hole_projector_wm");
		var_06.angles = param_00.angles;
		var_06.team = self.team;
		var_06.var_222 = self;
		var_06 thread func_D68C();
		var_06 thread func_D685(self);
		var_06 thread func_D688(10);
		var_06 thread func_D683(self);
		var_06 method_831F(self);
		var_06 scripts\cp\_weapon::func_69FF(var_05["entity"],1);
		scripts\cp\_weapon::func_C5AC(var_06);
		self notify("powers_portalGenerator_used",1);
	}
	else
	{
		thread func_CC21(var_02);
		return;
	}

	scripts\common\utility::func_136F7();
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 3
func_CC21(param_00)
{
	self notify("powers_portalGenerator_used",0);
	scripts\cp\_weapon::func_CC16(param_00.var_13C2E,1,param_00.origin);
	param_00 delete();
}

//Function Number: 4
func_D684(param_00)
{
	scripts\cp\_weapon::func_B9C6(100,"trophy",::func_D686,::func_D689,0);
}

//Function Number: 5
func_D686(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_222) && param_00 != self.var_222)
	{
		param_00 notify("destroyed_equipment");
	}

	self notify("detonateExplosive");
}

//Function Number: 6
func_D689(param_00,param_01,param_02,param_03)
{
	var_04 = param_03;
	return var_04;
}

//Function Number: 7
func_D68C()
{
	level endon("game_ended");
	self waittill("detonateExplosive");
	self method_8292();
	self stoploopsound();
	self playsound("phase_portal_end");
	var_00 = self.origin;
	self notify("death");
	if(isdefined(self))
	{
		if(isdefined(self.var_A63A))
		{
			self.var_A63A delete();
		}

		scripts\cp\_weapon::func_66A8();
		scripts\cp\_weapon::func_51B5();
	}
}

//Function Number: 8
func_D685(param_00)
{
	self endon("death");
	param_00 waittill("disconnect");
	self notify("detonateExplosive");
}

//Function Number: 9
func_D68A(param_00)
{
	self endon("disconnect");
	self endon("death");
	param_00 waittill("spawned_player");
	self notify("detonateExplosive");
}

//Function Number: 10
func_D688(param_00)
{
	self endon("death");
	wait(param_00);
	self notify("detonateExplosive");
}

//Function Number: 11
func_D683(param_00)
{
	var_01 = spawn("trigger_rotatable_radius",self.origin,0,50,100);
	var_01.angles = self.angles;
	var_01.team = param_00.team;
	var_01 thread func_13B15(param_00);
	var_01 thread func_13B14(self,10);
	var_02 = 50;
	var_03 = anglestoup(self.angles);
	var_03 = var_02 * self.angles;
	var_04 = self.origin + var_03;
	var_01.var_D682 = spawnfx(scripts\common\utility::getfx("portal_open"),self.origin + (0,0,50),anglestoforward(self.angles),anglestoup(self.angles));
	triggerfx(var_01.var_D682);
	scripts\cp\_utility::func_D52A("phase_portal_start",var_04);
	scripts\common\utility::delaycall(1,::playloopsound,"phase_portal_energy_lp");
}

//Function Number: 12
func_13B15(param_00)
{
	self endon("death");
	var_01 = 10;
	var_02 = 1;
	for(;;)
	{
		self waittill("trigger",var_03);
		if(!isplayer(var_03))
		{
			wait(0.1);
			continue;
		}

		if(scripts\common\utility::istrue(var_03.isrewinding))
		{
			wait(0.1);
			continue;
		}

		if(scripts\common\utility::istrue(var_03.playing_game))
		{
			wait(0.1);
			continue;
		}

		if(scripts\cp\_utility::func_462B("portal"))
		{
			if(isdefined(level.var_5592))
			{
				var_03 thread [[ level.var_5592 ]](var_03,0.5,"fast_travel_complete");
			}

			if(isdefined(level.var_6B8D))
			{
				var_03 thread [[ level.var_6B8D ]](var_03,1);
			}

			continue;
		}

		if(isdefined(var_03.var_DDCA) && var_03.var_DDCA)
		{
			continue;
		}

		if(!lib_0D12::func_9DDF(var_03))
		{
			var_03 thread func_10DDD(var_01);
		}
		else
		{
			var_03 lib_0D12::func_6978(1);
		}

		var_03 thread func_10DDE(var_02);
	}
}

//Function Number: 13
func_10DDD(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("phase_shift_completed");
	lib_0D12::func_6626(1,param_00);
	wait(param_00);
	thread func_6979();
}

//Function Number: 14
func_10DDE(param_00)
{
	self endon("death");
	self endon("disconnect");
	self.var_DDCA = 1;
	wait(param_00);
	self.var_DDCA = undefined;
}

//Function Number: 15
func_6979()
{
	level endon("game_ended");
	lib_0D12::func_6978(1);
	var_00 = self gettagorigin("j_mainroot") + (0,0,10);
	var_01 = spawnfx(scripts\common\utility::getfx("portal_open"),var_00);
	triggerfx(var_01);
	wait(0.3);
	var_01 delete();
}

//Function Number: 16
func_13B14(param_00,param_01)
{
	param_00 scripts\common\utility::waittill_any_timeout_1(param_01,"death");
	if(isdefined(self.var_C2B5))
	{
		function_0154(self.var_C2B5);
	}

	if(isdefined(self.var_D682))
	{
		self.var_D682 delete();
	}

	self delete();
}