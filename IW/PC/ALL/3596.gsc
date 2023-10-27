/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3596.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 8 ms
 * Timestamp: 10/27/2023 12:30:51 AM
*******************************************************************/

//Function Number: 1
func_14FB()
{
	level thread func_14FD();
}

//Function Number: 2
func_14FD()
{
	for(;;)
	{
		level waittill("player_spawned",var_00);
		if(isai(var_00))
		{
			continue;
		}
	}
}

//Function Number: 3
func_14FC()
{
}

//Function Number: 4
func_14F9()
{
	self.var_14F6 = 1;
	self iprintlnbold("Anti-Air Blaster");
	if(!self isonground() || self isjumping() || self method_8446())
	{
		thread func_2B64();
	}
	else
	{
		thread func_2B62();
	}

	thread func_14FA();
	thread func_14F8();
	return 1;
}

//Function Number: 5
func_2B64()
{
	self endon("death");
	self endon("disconnect");
	var_00 = 262144;
	var_01 = 0;
	foreach(var_03 in level.var_C928)
	{
		if(!scripts\mp\_utility::func_9F19(var_03))
		{
			continue;
		}

		if(!scripts\mp\_utility::func_9DD6(var_03))
		{
			continue;
		}

		if(var_03.origin[2] > self.origin[2])
		{
			continue;
		}

		var_04 = var_03.origin - self.origin;
		var_05 = length2dsquared(var_04);
		if(var_05 > var_00)
		{
			continue;
		}

		thread func_2B63(var_03,distance2d(var_03.origin,self.origin));
		var_01 = 1;
	}

	if(!var_01)
	{
		wait(0.5);
		self iprintlnbold(".No Targets.");
	}
}

//Function Number: 6
func_2B62()
{
	self endon("death");
	self endon("disconnect");
	var_00 = 262144;
	var_01 = 0;
	foreach(var_03 in level.var_C928)
	{
		if(!scripts\mp\_utility::func_9F19(var_03))
		{
			continue;
		}

		if(!scripts\mp\_utility::func_9DD6(var_03))
		{
			continue;
		}

		if(!var_03 isjumping() && !var_03 method_8446())
		{
			continue;
		}

		if(var_03.origin[2] < self.origin[2])
		{
			continue;
		}

		var_04 = var_03.origin - self.origin;
		var_05 = length2dsquared(var_04);
		if(var_05 > var_00)
		{
			continue;
		}

		thread func_2B63(var_03,distance2d(var_03.origin,self.origin));
		var_01 = 1;
	}

	if(!var_01)
	{
		wait(0.5);
		self iprintlnbold(".No Targets.");
	}
}

//Function Number: 7
func_2B63(param_00,param_01)
{
	self endon("death");
	var_02 = scripts\mp\_utility::func_C794(param_00,"orange",self,0,1,"level_script");
	var_03 = param_01 * 0.0001;
	wait(0.1 * var_03);
	if(!scripts\mp\_utility::func_9F19(param_00))
	{
		return;
	}

	self earthquakeforplayer(0.2,0.5,self.origin,64);
	var_04 = param_00 gettagorigin("j_mainroot");
	var_05 = self gettagorigin("j_shouldertwist_le");
	var_06 = scripts\mp\_utility::func_1309("iw7_chargeshot_mp",var_05,var_04,self);
	if(isdefined(param_00))
	{
		scripts\mp\_utility::func_C78F(var_02,param_00);
	}
}

//Function Number: 8
func_7E1C()
{
	var_00 = ["physicscontents_solid","physicscontents_glass","physicscontents_item","physicscontents_clipshot","physicscontents_actor","physicscontents_playerclip","physicscontents_fakeactor","physicscontents_vehicle","physicscontents_structural"];
	var_01 = physics_createcontents(var_00);
	return var_01;
}

//Function Number: 9
func_14F7()
{
	wait(0.5);
	if(!isdefined(self))
	{
		return;
	}

	self.var_14F6 = 0;
	self setscriptablepartstate("aaGun","aaGunOff",0);
	self notify("aaGun_end");
}

//Function Number: 10
func_14FA()
{
	self endon("aaGun_end");
	scripts\common\utility::waittill_any_3("death","disconnect","game_ended");
	thread func_14F7();
}

//Function Number: 11
func_9D23()
{
	if(!isdefined(self.var_14F6))
	{
		return 0;
	}

	return self.var_14F6;
}

//Function Number: 12
func_14F8()
{
	self endon("disconnect");
	self endon("aaGun_end");
	self method_846F("ges_hold");
	self setscriptablepartstate("aaGun","aaGunOn",0);
}