/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3580.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:30:47 AM
*******************************************************************/

//Function Number: 1
func_DAF5(param_00)
{
	thread func_13A55(param_00);
	thread func_13A6E(param_00);
}

//Function Number: 2
func_13A55(param_00)
{
	param_00 endon("death");
	self waittill("disconnect");
	param_00 delete();
}

//Function Number: 3
func_13A6E(param_00)
{
	self endon("disconnect");
	param_00 endon("death");
	param_00 waittill("missile_stuck");
	var_01 = anglestoup(param_00.angles);
	var_02 = func_10856(param_00);
	var_02 lib_0DDA::func_2B2A();
	var_02 thread func_13A3B();
	thread func_13B19(var_02);
}

//Function Number: 4
func_13B19(param_00)
{
	self endon("disconnect");
	param_00 endon("death");
	var_01 = param_00.var_15F;
	var_01 endon("death");
	param_00 setscriptablepartstate("effects","warmUp",0);
	wait(1);
	param_00 setscriptablepartstate("effects","explode_01",0);
	var_01 thread scripts\mp\_shellshock::func_DAF3();
	param_00 radiusdamage(var_01.origin,256,100,50,var_01.var_222,"MOD_EXPLOSIVE",var_01.var_13C2E);
	var_02 = var_01.var_118A2;
	for(var_03 = 0;var_03 < var_02;var_03++)
	{
		wait(0.5);
		switch(var_03)
		{
			case 0:
				param_00 setscriptablepartstate("effects","explode_02",0);
				break;

			case 1:
				param_00 setscriptablepartstate("effects","explode_03",0);
				break;

			case 2:
				param_00 setscriptablepartstate("effects","explode_04",0);
				break;

			case 3:
				param_00 setscriptablepartstate("effects","explode_05",0);
				break;
		}

		var_01 thread scripts\mp\_shellshock::func_DAF3();
		param_00 radiusdamage(var_01.origin,256,40,20,var_01.var_222,"MOD_EXPLOSIVE",var_01.var_13C2E);
	}

	wait(1);
	var_01 delete();
}

//Function Number: 5
func_10856(param_00)
{
	var_01 = spawn("script_model",param_00.origin);
	var_01 setmodel("prop_mp_pulse_grenade_temp");
	var_01.angles = param_00.angles;
	var_01 linkto(param_00);
	var_01.var_15F = param_00;
	var_01.var_222 = param_00.var_222;
	var_01 method_831F(param_00.var_222);
	var_01 thread func_40F3(param_00);
	param_00 hide();
	return var_01;
}

//Function Number: 6
func_13A3B()
{
	scripts\mp\_damage::func_B9C6(50,"pulseGrenade",::func_612B,::func_612C,0);
}

//Function Number: 7
func_612B(param_00,param_01,param_02,param_03)
{
	if(isdefined(self.var_222) && param_00 != self.var_222)
	{
		param_00 scripts\mp\killstreaks\_killstreaks::func_83A0();
		param_00 notify("destroyed_equipment");
	}

	lib_0DDA::func_2B2C();
	self.var_15F delete();
	self notify("detonateExplosive");
}

//Function Number: 8
func_612C(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = param_03;
	var_05 = scripts\mp\_damage::func_89C3(param_01,param_02,var_05);
	var_05 = scripts\mp\_damage::func_8999(param_01,param_02,var_05);
	var_05 = scripts\mp\_damage::func_8975(param_01,param_02,var_05);
	return var_05;
}

//Function Number: 9
func_40F3(param_00)
{
	param_00 waittill("death");
	self delete();
}

//Function Number: 10
func_A63A()
{
	if(isdefined(self))
	{
		return self.var_15F;
	}
}

//Function Number: 11
func_DAF4()
{
	self shellshock("pulse_grenade_mp",0.3);
}