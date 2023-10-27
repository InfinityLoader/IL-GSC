/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\cp\_blackholegun.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 20
 * Decompile Time: 672 ms
 * Timestamp: 10/27/2023 12:23:28 AM
*******************************************************************/

//Function Number: 1
init()
{
	level.var_2ABE = [];
}

//Function Number: 2
func_2A7B()
{
	return 1;
}

//Function Number: 3
func_1109A()
{
}

//Function Number: 4
func_B8B1(param_00,param_01)
{
	self endon("disconnect");
	var_02 = scripts\common\trace::func_48BC(0,1,1,1,1,0,0);
	var_03 = param_01.origin;
	var_04 = anglestoforward(param_01.angles);
	var_05 = var_03 + var_04 * 1920;
	var_06 = function_0287(var_03,var_05,var_02,param_01,1,"physicsquery_closest");
	var_07 = isdefined(var_06) && var_06.size > 0;
	if(var_07)
	{
		var_08 = var_06[0]["position"];
		var_09 = distance(var_08,var_03);
		var_0A = vectornormalize(var_03 - var_08);
		var_0B = var_08 + var_0A * 80;
	}
	else
	{
		var_09 = 1920;
		var_0A = anglestoforward(var_03.angles);
		var_0B = var_06;
		var_08 = undefined;
	}

	var_0C = distance(var_0B,var_03);
	if(var_0C < 90)
	{
		var_0D = 1;
		wait(0.3);
		if(isdefined(param_01))
		{
			param_01 delete();
			return;
		}

		return;
	}

	var_0E = max(var_0C / 980,1.05);
	var_0F = spawn("script_model",var_03);
	var_0F setmodel("prop_mp_super_blackholegun_projectile");
	var_0F method_831F(self);
	var_0F moveto(var_0B,var_0E,0.1,0.95);
	var_0F.var_222 = param_01.var_222;
	var_0F setscriptmoverkillcam("rocket");
	var_10 = var_0F.var_222 scripts\cp\_utility::func_1302("blackholegun_indicator_zm",self.origin,(0,0,0));
	var_10.var_13C2E = "blackholegun_indicator_zm";
	var_10 linkto(var_0F);
	var_0F thread func_BA0A(var_0E,self,var_10,var_02);
	param_01.var_222 thread lib_0D04::grabclosestzombies(var_0F,1);
	var_0F setscriptablepartstate("projectile","on",0);
	waittillframeend;
	param_01 delete();
}

//Function Number: 5
func_BA0A(param_00,param_01,param_02,param_03)
{
	self endon("blackhole_projectile_impact");
	self endon("death");
	thread func_DA5F(param_01,param_02);
	wait(param_00);
	self notify("blackhole_projectile_arrive");
	thread func_DA5E(param_02,param_03);
}

//Function Number: 6
func_DA5E(param_00,param_01)
{
	self endon("death");
	self notify("projectile_arrived");
	func_410E();
	var_02 = function_0287(self.origin,self.origin - (0,0,42),param_01,undefined,1,"physicsquery_closest");
	var_03 = isdefined(var_02) && var_02.size > 0;
	if(var_03)
	{
		var_04 = var_02[0]["position"];
		self.origin = var_04 + (0,0,42);
	}

	var_05 = undefined;
	var_06 = undefined;
	self setscriptablepartstate("singularity","singularity",0);
	thread func_13A45(var_05);
	thread func_10213();
	wait(3);
	thread func_10212(self.var_222,var_05,var_06,param_00);
}

//Function Number: 7
func_C836(param_00)
{
	self endon("death");
	param_00 waittill("disconnect");
	self delete();
}

//Function Number: 8
func_B29C(param_00)
{
	var_01 = function_02AF(self.var_222,"bhgunfield_mp",self.origin);
	var_01 linkto(self);
	return var_01;
}

//Function Number: 9
func_10213()
{
	self endon("death");
	var_00 = 0.6;
	var_01 = 0.0466;
	for(var_02 = 0;var_02 < 5;var_02++)
	{
		earthquake(var_02 + 1 * var_01,var_00 * 2,self.origin,800);
		wait(var_00);
	}
}

//Function Number: 10
func_12896(param_00,param_01,param_02,param_03)
{
	var_04 = function_0287(self.origin,param_01,param_03,self,0,"physicsquery_closest");
	var_05 = !isdefined(var_04) && var_04.size > 0;
	if(var_05)
	{
		param_00 dodamage(param_02,self.origin,self.var_222,self,"MOD_EXPLOSIVE","iw7_blackholegun_mp");
	}
}

//Function Number: 11
func_13A45(param_00)
{
	self endon("death");
	self endon("blackhole_die");
	self.var_222 endon("disconnect");
	var_01 = scripts\common\trace::func_48BC(0,1,1,0,1,0);
	var_02 = 5898.24;
	for(;;)
	{
		foreach(var_04 in scripts\cp\_agent_utils::func_7DB0("axis"))
		{
			if(!isdefined(var_04))
			{
				continue;
			}

			if(!scripts\cp\_utility::func_9F19(var_04))
			{
				continue;
			}

			if(!lib_0D12::func_213D(self,var_04))
			{
				continue;
			}

			if(!level.var_740A && var_04 != self.var_222 && var_04.team != self.var_222.team)
			{
				continue;
			}

			if(distancesquared(var_04 geteye(),self.origin) > var_02)
			{
				continue;
			}

			func_12896(var_04,var_04 geteye(),1200,var_01);
		}

		wait(0.2);
	}
}

//Function Number: 12
func_13A38(param_00,param_01)
{
	self endon("death");
	self endon("blackhole_projectile_arrive");
	self.var_222 endon("disconnect");
	wait(0.1);
	var_02 = spawn("trigger_radius",self.origin - (0,0,32),0,24,64);
	var_02 enablelinkto();
	var_02 linkto(self);
	var_02 thread func_411E(self);
	for(;;)
	{
		var_02 waittill("trigger",var_03);
		if(var_03 == self.var_222)
		{
			continue;
		}

		if(!isplayer(var_03) && !isagent(var_03))
		{
			continue;
		}

		if(!scripts\cp\_utility::func_9F19(var_03))
		{
			continue;
		}

		if(!lib_0D12::func_213D(self,var_03))
		{
			continue;
		}

		var_04 = var_03;
		if(!level.var_740A && var_04 != self.var_222 && var_04.team != self.var_222.team)
		{
			continue;
		}

		self notify("blackhole_projectile_impact");
		var_03 dodamage(var_03.maxhealth,self.origin,self.var_222,self,"MOD_EXPLOSIVE","iw7_blackholegun_mp");
		self moveto(self.origin,0.05,0,0);
		thread func_DA5E(param_00,param_01);
		break;
	}
}

//Function Number: 13
func_10212(param_00,param_01,param_02,param_03)
{
	self setscriptablepartstate("singularity","explosion",0);
	self radiusdamage(self.origin,150,2000,500,self.var_222,"MOD_EXPLOSIVE","iw7_blackholegun_mp");
	self notify("singularity_explode");
	self notify("blackhole_die");
	thread func_4118(param_01,param_02,param_03);
}

//Function Number: 14
func_10833(param_00)
{
	var_01 = physics_volumecreate(self.origin,384);
	var_01 method_852C(1,self.origin,param_00);
	var_01 method_8526(1);
	var_01.time = gettime();
	level.var_2ABE scripts\common\utility::func_22BC(level.var_2ABE);
	var_02 = undefined;
	var_03 = 0;
	for(var_04 = 0;var_04 < 3;var_04++)
	{
		var_05 = level.var_2ABE[var_04];
		if(!isdefined(var_05))
		{
			var_03 = var_04;
			break;
		}
		else if(!isdefined(var_02) || isdefined(var_02) && var_02.time > var_05.time)
		{
			var_02 = var_05;
			var_03 = var_04;
		}
	}

	if(isdefined(var_02))
	{
		var_02 delete();
	}

	level.var_2ABE[var_03] = var_01;
	var_01 thread func_2B42();
	return var_01;
}

//Function Number: 15
func_2B42()
{
	self endon("death");
	self method_8529(1);
	scripts\common\utility::func_136F7();
	self method_8529(0);
}

//Function Number: 16
func_411E(param_00)
{
	param_00 scripts\common\utility::waittill_any_3("death","blackhole_projectile_arrive","blackhole_projectile_impact");
	self delete();
}

//Function Number: 17
func_4118(param_00,param_01,param_02)
{
	if(isdefined(param_01))
	{
		param_01 delete();
	}

	if(isdefined(param_00))
	{
		param_00 delete();
	}

	if(isdefined(param_02))
	{
		param_02 delete();
	}

	self setscriptablepartstate("singularity","off",0);
	self delete();
}

//Function Number: 18
func_DA5F(param_00,param_01)
{
	self endon("death");
	self endon("projectile_arrived");
	param_00 waittill("disconnect");
	func_410E();
	if(isdefined(param_01))
	{
		param_01 delete();
	}

	self delete();
}

//Function Number: 19
func_410E()
{
	self setscriptablepartstate("projectile","off",0);
}

//Function Number: 20
func_10211(param_00,param_01,param_02,param_03)
{
	self endon("death");
	param_01 waittill("disconnect");
	thread func_4118(param_00,param_02,param_03);
}