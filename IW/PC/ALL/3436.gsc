/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3436.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 6 ms
 * Timestamp: 10/27/2023 12:27:27 AM
*******************************************************************/

//Function Number: 1
func_97D0()
{
}

//Function Number: 2
func_20BB()
{
}

//Function Number: 3
func_E0D0()
{
	self notify("removeArchetype");
}

//Function Number: 4
func_98AD()
{
	level._effect["adrenaline_worldFX"] = loadfx("vfx/iw7/_requests/mp/vfx_adrenaline_world_view");
}

//Function Number: 5
func_261D()
{
	self endon("death");
	self endon("disconnect");
	self endon("removeArchetype");
	self setclientomnvar("ui_aura_regen",0);
	for(;;)
	{
		self waittill("got_a_kill");
		foreach(var_01 in level.players)
		{
			if(var_01 != self)
			{
				if(!level.teambased)
				{
					continue;
				}

				if(var_01.team != self.team)
				{
					continue;
				}

				if(distance2dsquared(var_01.origin,self.origin) > 147456)
				{
					continue;
				}
			}

			var_01 thread func_2617(self);
		}
	}
}

//Function Number: 6
func_2617(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	if(self != param_00)
	{
		param_00 thread scripts\mp\_utility::func_83B4("buff_teammate");
	}

	self playlocalsound("mp_overcharge_on");
	self setclientomnvar("ui_aura_regen",1);
	thread func_261A(2);
	var_01 = gettime();
	thread func_261B(var_01,0.6);
	wait(0.6);
	var_01 = gettime();
	thread func_261C(var_01,1.4);
}

//Function Number: 7
func_261B(param_00,param_01)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self notify("force_regeneration");
	scripts\mp\_utility::func_8387("specialty_adrenaline");
	var_02 = anglestoup(self.angles);
	var_03 = anglestoforward(self.angles);
	var_04 = param_00 + param_01 * 1000;
	while(gettime() < var_04)
	{
		playfx(scripts\common\utility::getfx("adrenaline_worldFX"),self.origin + (0,0,25),var_03,var_02);
		wait(0.1);
	}

	scripts\mp\_utility::func_E150("specialty_adrenaline");
}

//Function Number: 8
func_261C(param_00,param_01)
{
	self endon("death");
	self endon("damage");
	self endon("disconnect");
	level endon("game_ended");
	scripts\mp\_utility::func_8387("specialty_adrenaline_lite");
	thread func_2618(param_01);
	thread func_2619(param_01);
	var_02 = anglestoup(self.angles);
	var_03 = anglestoforward(self.angles);
	var_04 = param_00 + param_01 * 1000;
	while(gettime() < var_04)
	{
		var_05 = playfx(scripts\common\utility::getfx("adrenaline_worldFX"),self.origin + (0,0,25),var_03,var_02);
		var_05 method_8429(self);
		wait(0.1);
	}

	scripts\mp\_utility::func_E150("specialty_adrenaline_lite");
}

//Function Number: 9
func_2618(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	var_01 = scripts\common\utility::waittill_any_timeout_1(param_00,"damage");
	if(isdefined(var_01) && var_01 == "damage")
	{
		scripts\mp\_utility::func_E150("specialty_adrenaline_lite");
	}
}

//Function Number: 10
func_2619(param_00)
{
	self endon("death");
	self endon("disconnect");
	level endon("game_ended");
	self notify("auraRegen_cleanupLuaDamagePublic");
	self endon("auraRegen_cleanupLuaDamagePublic");
	var_01 = scripts\common\utility::waittill_any_timeout_1(param_00,"damage");
	self setclientomnvar("ui_aura_regen",0);
	self notify("auraRegen_cleanupLuaDeathPublic");
}

//Function Number: 11
func_261A(param_00)
{
	self endon("disconnect");
	self notify("auraRegen_cleanupLuaDeathPublic");
	self endon("auraRegen_cleanupLuaDeathPublic");
	var_01 = scripts\common\utility::waittill_any_timeout_1(param_00,"death");
	self setclientomnvar("ui_aura_regen",0);
	self notify("auraRegen_cleanupLuaDamagePublic");
}

//Function Number: 12
func_56E7()
{
	self endon("death");
	self endon("disconnect");
	self endon("game_ended");
	self endon("removeArchetype");
	for(;;)
	{
		self waittill("melee_fired");
		var_00 = anglestoforward(self getplayerangles());
		playfx(scripts\common\utility::getfx("disruptor_punch"),self gettagorigin("tag_eye"),var_00);
		self playlocalsound("kinetic_pulse");
		foreach(var_02 in level.players)
		{
			if(var_02.team != self.team && distance2d(self.origin,var_02.origin) < 512 && func_9F98(var_02) && scripts\common\trace::func_DCF1(self geteye(),var_02 geteye(),undefined,scripts\common\trace::func_48BC(0,1,1,1,0,1,0)))
			{
				if(lib_0DF8::func_9DDF(var_02))
				{
					var_02 notify("phaseshift_interrupted");
					var_02 scripts\mp\_powers::func_C170("powers_phase_shift_update",0);
				}

				var_03 = anglestoright(self getplayerangles());
				var_04 = rotatepointaroundvector(var_03,var_00,20);
				var_02 method_84DC(var_04,512);
				var_02 shellshock("concussion_grenade_mp",2.5,0,1);
				var_02 notify("flashbang",var_02.origin,1,30,self,1);
				playfx(scripts\common\utility::getfx("disruptor_impact"),var_02.origin + (0,0,36));
			}
		}
	}
}

//Function Number: 13
func_9F98(param_00)
{
	var_01 = self getplayerangles();
	var_02 = anglestoforward(var_01);
	var_03 = anglestoup(var_01);
	var_04 = anglestoright(var_01);
	var_05 = self geteye() - var_02 * 128;
	if(!scripts\mp\_utility::func_D64B(param_00 gettagorigin("tag_eye"),var_05,var_02,var_03,512,128,20))
	{
		if(!scripts\mp\_utility::func_D64B(param_00 gettagorigin("tag_origin"),var_05,var_02,var_03,512,128,20))
		{
			if(!scripts\mp\_utility::func_D64B(param_00 gettagorigin("j_mainroot"),var_05,var_02,var_03,512,128,20))
			{
				return 0;
			}
		}
	}

	return 1;
}