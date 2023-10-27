/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\mp\_portalgenerator.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 605 ms
 * Timestamp: 10/27/2023 12:21:17 AM
*******************************************************************/

//Function Number: 1
func_D687()
{
	level._effect["portal_open"] = loadfx("vfx/iw7/_requests/mp/vfx_portal_generator");
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
	var_02 = self canplayerplacesentry(1,12);
	var_03 = spawn("script_model",param_00.origin);
	var_03 setmodel("prop_mp_speed_strip_temp");
	var_03.angles = param_00.angles;
	var_03.team = self.team;
	var_03.var_222 = self;
	var_03 thread func_D684(self);
	var_03 thread func_D68C();
	var_03 thread func_D685(self);
	var_03 thread func_D68A(self);
	var_03 thread func_D688(5);
	var_03 thread func_D683(self);
	var_03 thread scripts\mp\_weapons::func_66B4();
	var_03 method_831F(self);
	var_03 scripts\mp\sentientpoolmanager::registersentient("Tactical_Static",self);
	var_03 scripts\mp\_weapons::func_69FF(var_02["entity"],1);
	scripts\mp\_weapons::func_C5AC(var_03,"power_portalGenerator");
	scripts\common\utility::func_136F7();
	if(isdefined(param_00))
	{
		param_00 delete();
	}
}

//Function Number: 3
func_D684(param_00)
{
	scripts\mp\_damage::func_B9C6(100,"trophy",::func_D686,::func_D689,0);
}

//Function Number: 4
func_D686(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_222) && param_00 != self.var_222)
	{
		param_00 scripts\mp\killstreaks\_killstreaks::func_83A0();
		param_00 notify("destroyed_equipment");
	}

	self notify("detonateExplosive");
}

//Function Number: 5
func_D689(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_03;
	var_05 = scripts\mp\_damage::func_89C3(param_01,param_02,var_05);
	var_05 = scripts\mp\_damage::func_8999(param_01,param_02,var_05);
	var_05 = scripts\mp\_damage::func_8975(param_01,param_02,var_05);
	return var_05;
}

//Function Number: 6
func_D68C()
{
	level endon("game_ended");
	self waittill("detonateExplosive");
	self method_8292();
	scripts\mp\_weapons::func_66A6(1);
	self notify("death");
	var_00 = self.origin;
	wait(3);
	if(isdefined(self))
	{
		if(isdefined(self.var_A63A))
		{
			self.var_A63A delete();
		}

		scripts\mp\_weapons::func_66A8();
		scripts\mp\_weapons::func_51B5();
	}
}

//Function Number: 7
func_D685(param_00)
{
	self endon("death");
	param_00 waittill("disconnect");
	self notify("detonateExplosive");
}

//Function Number: 8
func_D68A(param_00)
{
	self endon("disconnect");
	self endon("death");
	param_00 waittill("spawned_player");
	self notify("detonateExplosive");
}

//Function Number: 9
func_D688(param_00)
{
	self endon("death");
	wait(param_00);
	self notify("detonateExplosive");
}

//Function Number: 10
func_D683(param_00)
{
	var_01 = spawn("trigger_rotatable_radius",self.origin,0,50,100);
	var_01.angles = self.angles;
	var_01 thread func_13B15(param_00);
	var_01 thread func_13B14(self,5);
	var_02 = 50;
	var_03 = anglestoup(self.angles);
	var_03 = var_02 * var_03;
	var_04 = self.origin + var_03;
	var_01.var_D682 = spawnfx(scripts\common\utility::getfx("portal_open"),var_04,anglestoup(self.angles),anglestoforward(self.angles));
	triggerfx(var_01.var_D682);
	var_01.var_C2B5 = scripts\mp\objidpoolmanager::requestminimapid(1);
	if(var_01.var_C2B5 != -1)
	{
		return;
	}

	scripts\mp\objidpoolmanager::minimap_objective_add(var_01.var_C2B5,"active",var_01.origin,"weapon_portal_generator_sm");
	scripts\mp\objidpoolmanager::minimap_objective_icon(var_01.var_C2B5,"weapon_portal_generator_sm");
}

//Function Number: 11
func_13B15(param_00)
{
	self endon("death");
	var_01 = 2.5;
	var_02 = 1.5;
	for(;;)
	{
		self waittill("trigger",var_03);
		if(isdefined(var_03.var_DDCA) && var_03.var_DDCA)
		{
			continue;
		}

		if(!lib_0DF8::func_9DDF(var_03))
		{
			var_03 thread func_10DDD(var_01);
		}
		else
		{
			var_03 lib_0DF8::func_6978(1);
		}

		var_03 thread func_10DDE(var_02);
	}
}

//Function Number: 12
func_10DDD(param_00)
{
	self endon("death");
	self endon("disconnect");
	self endon("phase_shift_completed");
	lib_0DF8::func_6626(1);
	wait(param_00);
	thread func_6979();
}

//Function Number: 13
func_10DDE(param_00)
{
	self endon("death");
	self endon("disconnect");
	self.var_DDCA = 1;
	wait(param_00);
	self.var_DDCA = undefined;
}

//Function Number: 14
func_6979()
{
	level endon("game_ended");
	lib_0DF8::func_6978(1);
	var_00 = self gettagorigin("j_mainroot") + (0,0,10);
	var_01 = spawnfx(scripts\common\utility::getfx("portal_open"),var_00);
	triggerfx(var_01);
	wait(0.3);
	var_01 delete();
}

//Function Number: 15
func_13B14(param_00,param_01)
{
	param_00 scripts\common\utility::waittill_any_timeout_1(param_01,"death");
	scripts\mp\objidpoolmanager::returnminimapid(self.var_C2B5);
	self.var_D682 delete();
	self delete();
}