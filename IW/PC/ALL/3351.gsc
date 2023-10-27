/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3351.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 5
 * Decompile Time: 1 ms
 * Timestamp: 10/27/2023 12:26:44 AM
*******************************************************************/

//Function Number: 1
init()
{
	level._effect["repulsor_view"] = loadfx("vfx/iw7/_requests/coop/zmb_repulsor_wave_view.vfx");
}

//Function Number: 2
func_130CD()
{
	var_00 = self getplayerangles();
	var_01 = anglestoup(var_00);
	var_02 = anglestoforward(var_00);
	var_03 = spawnfx(level._effect["repulsor_view"],self gettagorigin("tag_eye"),anglestoforward(self.angles),anglestoup(self.angles));
	triggerfx(var_03);
	var_03 thread scripts\cp\_utility::func_5106(1);
	playrumbleonposition("slide_collision",self.origin);
	self earthquakeforplayer(0.5,0.5,self.origin,150);
	self playsoundonmovingent("equip_repulsor_wave");
	func_A65D();
}

//Function Number: 3
func_A65D()
{
	var_00 = cos(75);
	var_01 = 2000;
	var_02 = 300;
	var_03 = var_02 / 2;
	var_04 = vectornormalize(anglestoforward(self.angles));
	var_05 = var_04 * var_03;
	var_06 = self.origin + var_05;
	physicsexplosionsphere(var_06,var_03,1,2.5);
	var_07 = scripts\cp\_agent_utils::func_7DB0("axis");
	var_08 = scripts\common\utility::func_782F(self.origin,var_07,undefined,var_02);
	foreach(var_0A in var_08)
	{
		if(func_9C0D(var_0A))
		{
			continue;
		}

		var_0B = 0;
		var_0C = var_0A.origin;
		var_0D = scripts\common\utility::func_13D90(self geteye(),self.angles,var_0C + (0,0,30),var_00);
		if(var_0D)
		{
			var_0E = distance2d(self.origin,var_0C);
			if(var_0E < var_02)
			{
				var_0B = 1;
			}
		}

		if(var_0B)
		{
			var_01 = var_0A.maxhealth;
			var_04 = anglestoforward(self.angles);
			var_0F = vectornormalize(var_04) * -100;
			var_0A setvelocity(vectornormalize(var_0A.origin - self.origin + var_0F) * 800 + (0,0,300));
			var_0A func_A672(self,var_01,var_0C,self.origin);
		}
	}
}

//Function Number: 4
func_9C0D(param_00)
{
	if(scripts\common\utility::istrue(param_00.var_9342))
	{
		return 1;
	}

	return 0;
}

//Function Number: 5
func_A672(param_00,param_01,param_02,param_03)
{
	self.do_immediate_ragdoll = 1;
	if(param_01 >= self.health)
	{
		self.var_4C87 = 1;
	}

	self dodamage(param_01,param_02,param_00,param_00,"MOD_IMPACT","zom_repulsor_mp");
}