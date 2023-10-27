/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\cover_behavior.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 36
 * Decompile Time: 2120 ms
 * Timestamp: 10/27/2023 12:00:23 AM
*******************************************************************/

//Function Number: 1
main(param_00)
{
	self.var_46A6 = self.origin;
	var_01 = gettime();
	var_02 = spawnstruct();
	var_02.var_BF6E = var_01 - 1;
	var_02.var_BF6F = var_01 - 1;
	func_E257();
	func_E267();
	self.var_F17F = gettime();
	self.var_1491.var_A97A = var_01;
	self.var_1491.var_9302 = 0;
	self.var_1491.var_BCC8 = "stop";
	self.var_B600 = var_01 + 3000;
	thread func_13B72();
	var_03 = gettime() > 2500;
	for(;;)
	{
		if(isdefined(self.var_C2) && isdefined(self.var_C2.var_71C6))
		{
			var_04 = gettime();
			thread func_6335();
			[[ self.var_C2.var_71C6 ]]();
			if(gettime() == var_04)
			{
				self notify("dont_end_idle");
			}
		}

		if(scripts\anim\combat_utility::func_10026())
		{
			if(scripts\anim\combat_utility::func_128AA(1))
			{
				wait(0.05);
				continue;
			}
		}

		if(isdefined(param_00.var_B24A))
		{
			var_04 = gettime();
			thread func_6335();
			[[ param_00.var_B24A ]]();
			if(gettime() == var_04)
			{
				self notify("dont_end_idle");
			}
		}

		if(isdefined(param_00.var_BD1C))
		{
			if([[ param_00.var_BD1C ]]())
			{
				continue;
			}
		}

		if(scripts\common\utility::func_167E())
		{
			self method_8272(self.var_473C.origin);
		}
		else
		{
			self method_8272(self.var_473C.origin,func_7E3D());
		}

		if(!var_03)
		{
			func_92CC(param_00,0.05 + randomfloat(1.5));
			var_03 = 1;
			continue;
		}

		if(func_5927(param_00))
		{
			continue;
		}

		if(isdefined(level.var_11813) && isalive(level.player))
		{
			if(func_128AF(param_00,level.player))
			{
				continue;
			}
		}

		if(func_E29E())
		{
			return;
		}

		var_05 = 0;
		var_06 = 0;
		if(isalive(self.var_10C))
		{
			var_05 = func_9DDA();
			var_06 = scripts\anim\utility_common::func_3918();
		}

		if(var_05)
		{
			if(self.var_1491.var_7E0C < gettime())
			{
				if(scripts\anim\combat_utility::func_B019())
				{
					return;
				}
			}

			func_2538(param_00);
			continue;
		}

		if(isdefined(self.var_190C) || scripts\anim\utility_common::func_6561())
		{
			if(func_18D4())
			{
				return;
			}
		}

		if(var_06)
		{
			func_2533(param_00,var_02);
			continue;
		}

		if(func_252A(param_00,var_02))
		{
			return;
		}
	}
}

//Function Number: 2
func_010B(param_00)
{
	if(getdvarint("ai_iw7",0) == 1)
	{
		return;
	}

	self.var_129B3 = undefined;
	self.var_1491.var_D892 = undefined;
	if(isdefined(self.var_B600) && self.var_B600 <= gettime())
	{
		self.var_B5FF = gettime() + 5000;
		self.var_B600 = undefined;
	}

	self method_806F(%head,0.2);
	self.var_6A89 = undefined;
}

//Function Number: 3
func_7E3D()
{
	if(scripts\common\utility::func_167E())
	{
		return self.var_473C.angles;
	}

	var_00 = (self.var_473C.angles[0],scripts\asm\shared_utility::func_7FF7(self.var_473C),self.var_473C.angles[2]);
	return var_00;
}

//Function Number: 4
func_E29E()
{
	if(self method_801B() && self.var_1491.var_E29F < gettime())
	{
		if(scripts\anim\combat_utility::func_B019())
		{
			return 1;
		}

		self.var_1491.var_E29F = gettime() + 30000;
	}

	return 0;
}

//Function Number: 5
func_5927(param_00)
{
	if(func_112C9(param_00))
	{
		if(func_9DDA())
		{
			func_E26B();
		}

		self.var_1491.var_A97A = gettime();
		return 1;
	}

	if(func_4742(param_00,0))
	{
		return 1;
	}

	return 0;
}

//Function Number: 6
func_2538(param_00)
{
	if(distancesquared(self.origin,self.var_10C.origin) > 562500)
	{
		if(func_128AF(param_00,self.var_10C))
		{
			return;
		}
	}

	if(func_AB2D(param_00,"normal"))
	{
		func_E26B();
		self.var_1491.var_A97A = gettime();
		return;
	}

	func_92CC(param_00);
}

//Function Number: 7
func_2533(param_00,param_01)
{
	if(self.var_FC)
	{
		if(func_AB2D(param_00,"ambush"))
		{
			return;
		}
	}
	else if(self.var_251 || gettime() >= param_01.var_BF6F)
	{
		var_02 = "suppress";
		if(!self.var_251 && gettime() - self.var_AA22 > 5000 && randomint(3) < 2)
		{
			var_02 = "ambush";
		}
		else if(!scripts\anim\shoot_behavior::func_100A4())
		{
			var_02 = "ambush";
		}

		if(func_AB2D(param_00,var_02))
		{
			param_01.var_BF6F = gettime() + randomintrange(3000,20000);
			if(func_9DDA())
			{
				self.var_1491.var_A97A = gettime();
			}

			return;
		}
	}

	if(func_128AF(param_00,self.var_10C))
	{
		return;
	}

	func_92CC(param_00);
}

//Function Number: 8
func_252A(param_00,param_01)
{
	if(func_4742(param_00,0.1))
	{
		return 0;
	}

	if(isdefined(self.var_10C))
	{
		if(func_128AF(param_00,self.var_10C))
		{
			return 0;
		}
	}

	if(!self.var_FC && gettime() >= param_01.var_BF6E)
	{
		if(func_B01C(param_00))
		{
			param_01.var_BF6E = gettime() + randomintrange(4000,15000);
			return 0;
		}
	}

	if(gettime() > self.var_1491.var_7E0C)
	{
		if(func_3926())
		{
			return 1;
		}
	}

	if(self.var_FC || gettime() >= param_01.var_BF6F && isdefined(self.var_10C))
	{
		if(func_AB2D(param_00,"ambush"))
		{
			if(func_9DDA())
			{
				func_E26B();
			}

			self.var_1491.var_A97A = gettime();
			param_01.var_BF6F = gettime() + randomintrange(6000,20000);
			return 0;
		}
	}

	func_92CC(param_00);
	return 0;
}

//Function Number: 9
func_9DDA()
{
	if(!isdefined(self.var_10C))
	{
		return 0;
	}

	if(distancesquared(self.var_10C.origin,self.var_46A6) < 256)
	{
		return 0;
	}

	return scripts\anim\utility_common::func_3908();
}

//Function Number: 10
func_112C9(param_00)
{
	if(!scripts\anim\utility_common::func_9F8F())
	{
		return 0;
	}

	var_01 = gettime();
	var_02 = 1;
	while(scripts\anim\utility_common::func_9F8F())
	{
		var_02 = 0;
		self method_8272(self.var_473C.origin);
		var_03 = 1;
		if(isdefined(self.var_6BAB))
		{
			var_03 = scripts\common\utility::func_4347();
		}

		if(var_03)
		{
			if(func_128B1(param_00))
			{
				self notify("killanimscript");
				return 1;
			}
		}

		if(self.var_1491.var_2411 && scripts\anim\utility_common::func_3907())
		{
			return 0;
		}

		if(func_9DDA() || scripts\anim\utility_common::func_3918())
		{
			if(isdefined(level.var_11813) && isalive(level.player))
			{
				if(func_128AF(param_00,level.player))
				{
					continue;
				}
			}

			if(func_4742(param_00,0))
			{
				continue;
			}

			if(self.team != "allies" && gettime() >= var_01)
			{
				if(func_2B99(param_00))
				{
					var_01 = gettime();
					if(!isdefined(self.var_6BAB))
					{
						var_01 = var_01 + randomintrange(3000,12000);
					}

					continue;
				}
			}

			if(func_128AF(param_00,self.var_10C))
			{
				var_02 = 1;
				continue;
			}
		}

		if(func_4742(param_00,0.1))
		{
			continue;
		}

		func_92CC(param_00);
	}

	if(!var_02 && randomint(2) == 0)
	{
		func_B018(param_00);
	}

	return 1;
}

//Function Number: 11
func_805E(param_00)
{
	var_01 = [];
	if(param_00 == 1)
	{
		var_01[0] = 0;
	}
	else if(param_00 == 2)
	{
		var_01[0] = randomint(2);
		var_01[1] = 1 - var_01[0];
	}
	else
	{
		for(var_02 = 0;var_02 < param_00;var_02++)
		{
			var_01[var_02] = var_02;
		}

		for(var_02 = 0;var_02 < param_00;var_02++)
		{
			var_03 = var_02 + randomint(param_00 - var_02);
			var_04 = var_01[var_03];
			var_01[var_03] = var_01[var_02];
			var_01[var_02] = var_04;
		}
	}

	return var_01;
}

//Function Number: 12
func_3773(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	thread func_6335();
	var_04 = gettime();
	var_05 = undefined;
	if(isdefined(param_03))
	{
		var_05 = [[ param_00 ]](param_01,param_02,param_03);
	}
	else if(isdefined(param_02))
	{
		var_05 = [[ param_00 ]](param_01,param_02);
	}
	else if(isdefined(param_01))
	{
		var_05 = [[ param_00 ]](param_01);
	}
	else
	{
		var_05 = [[ param_00 ]]();
	}

	if(!var_05)
	{
		self notify("dont_end_idle");
	}

	return var_05;
}

//Function Number: 13
func_13B72()
{
	self endon("killanimscript");
	self.var_AA22 = gettime() - 100000;
	self.var_112CD = self.var_AA22;
	for(;;)
	{
		self waittill("suppression");
		var_00 = gettime();
		if(self.var_AA22 < var_00 - 700)
		{
			self.var_112CD = var_00;
		}

		self.var_AA22 = var_00;
	}
}

//Function Number: 14
func_4742(param_00,param_01)
{
	if(self.var_3250 > weaponclipsize(self.var_394) * param_01)
	{
		return 0;
	}

	self.var_9F21 = 1;
	var_02 = func_3773(param_00.var_260);
	self.var_9F21 = 0;
	return var_02;
}

//Function Number: 15
func_AB2D(param_00,param_01)
{
	thread scripts\anim\shoot_behavior::func_4F69(param_01);
	if(!self.var_132 && !self.var_FC)
	{
		thread func_2FBF();
	}

	var_02 = func_3773(param_00.var_AB2D);
	self notify("stop_deciding_how_to_shoot");
	return var_02;
}

//Function Number: 16
func_B01C(param_00)
{
	if(self.var_1491.var_2411 && scripts\anim\utility_common::func_3907())
	{
		return 0;
	}

	if(self.var_1491.var_A97A + 6000 > gettime())
	{
		return func_B018(param_00);
	}

	var_01 = func_3773(param_00.var_1BC,2 + randomfloat(2));
	if(var_01)
	{
		return 1;
	}

	return func_3773(param_00.var_6B9B);
}

//Function Number: 17
func_B018(param_00)
{
	var_01 = func_3773(param_00.var_6B9B);
	if(var_01)
	{
		return 1;
	}

	return func_3773(param_00.var_1BC,0);
}

//Function Number: 18
func_92CC(param_00,param_01)
{
	self.var_6F28 = 0;
	if(isdefined(param_00.var_6F27))
	{
		if(!self.var_1491.var_9302 && gettime() - self.var_112CD < 600)
		{
			if([[ param_00.var_6F27 ]]())
			{
				return 1;
			}
		}
		else
		{
			thread func_6F29(param_00);
		}
	}

	if(!self.var_1491.var_9302)
	{
		thread func_92FF(param_00.var_92CC);
		self.var_1491.var_9302 = 1;
	}

	if(isdefined(param_01))
	{
		func_9300(param_01);
	}
	else
	{
		func_9301();
	}

	if(self.var_6F28)
	{
		self waittill("flinch_done");
	}

	self notify("stop_waiting_to_flinch");
}

//Function Number: 19
func_9300(param_00)
{
	self endon("end_idle");
	wait(param_00);
}

//Function Number: 20
func_9301()
{
	self endon("end_idle");
	wait(0.3 + randomfloat(0.1));
	self waittill("do_slow_things");
}

//Function Number: 21
func_92FF(param_00)
{
	self endon("killanimscript");
	self [[ param_00 ]]();
}

//Function Number: 22
func_6F29(param_00)
{
	self endon("killanimscript");
	self endon("stop_waiting_to_flinch");
	var_01 = self.var_AA22;
	for(;;)
	{
		self waittill("suppression");
		var_02 = gettime();
		if(var_01 < var_02 - 2000)
		{
			break;
		}

		var_01 = var_02;
	}

	self.var_6F28 = 1;
	thread func_6335();
	var_03 = [[ param_00.var_6F27 ]]();
	if(!var_03)
	{
		self notify("dont_end_idle");
	}

	self.var_6F28 = 0;
	self notify("flinch_done");
}

//Function Number: 23
func_6335()
{
	self endon("killanimscript");
	self endon("dont_end_idle");
	waittillframeend;
	if(!isdefined(self))
	{
		return;
	}

	self notify("end_idle");
	self.var_1491.var_9302 = 0;
}

//Function Number: 24
func_128AF(param_00,param_01)
{
	var_02 = anglestoforward(self.angles);
	var_03 = vectornormalize(param_01.origin - self.origin);
	if(vectordot(var_02,var_03) < 0)
	{
		return 0;
	}

	if(self.var_FC && !scripts\anim\utility_common::func_DDC9())
	{
		return 0;
	}

	if(scripts\anim\utility::func_9ED4())
	{
		return func_3773(param_00.var_85BF,param_01);
	}

	return func_3773(param_00.var_15F,param_01);
}

//Function Number: 25
func_2B99(param_00)
{
	if(!scripts\anim\utility::func_3875())
	{
		return 0;
	}

	return func_3773(param_00.var_2B99);
}

//Function Number: 26
func_2FBF()
{
	self endon("killanimscript");
	self endon("stop_deciding_how_to_shoot");
	for(;;)
	{
		if(self.var_132 || self.var_FC)
		{
			return;
		}

		wait(0.5 + randomfloat(0.75));
		if(!isdefined(self.var_10C))
		{
			continue;
		}

		if(scripts\anim\utility_common::func_6561())
		{
			if(func_18D4())
			{
				return;
			}
		}

		if(!scripts\anim\utility_common::func_DDC9() && !scripts\anim\utility_common::func_3917())
		{
			if(gettime() > self.var_1491.var_7E0C)
			{
				if(func_3926())
				{
					return;
				}
			}
		}
	}
}

//Function Number: 27
func_E267()
{
	self.var_1491.var_E29F = 0;
}

//Function Number: 28
func_E257()
{
	var_00 = gettime();
	if(isdefined(self.var_54C3) && var_00 > self.var_1491.var_7E0C)
	{
		self.var_1491.var_7E0C = var_00 + randomintrange(2000,5000);
		return;
	}

	if(isdefined(self.var_10C))
	{
		var_01 = distance2d(self.origin,self.var_10C.origin);
		if(var_01 < self.var_112)
		{
			self.var_1491.var_7E0C = var_00 + randomintrange(5000,10000);
			return;
		}

		if(var_01 > self.var_110 && var_01 < self.var_15C)
		{
			self.var_1491.var_7E0C = var_00 + randomintrange(2000,5000);
			return;
		}

		self.var_1491.var_7E0C = var_00 + randomintrange(10000,15000);
		return;
	}

	self.var_1491.var_7E0C = var_00 + randomintrange(5000,15000);
}

//Function Number: 29
func_E26B()
{
	if(isdefined(self.var_190C))
	{
		self.var_F17F = gettime() + randomintrange(500,1000);
		return;
	}

	self.var_F17F = gettime() + randomintrange(3000,5000);
}

//Function Number: 30
func_3926()
{
	return func_18D4();
}

//Function Number: 31
func_18D4()
{
	if(self.var_132 || self.var_FC)
	{
		return 0;
	}

	if(isdefined(self.var_190C) && gettime() >= self.var_F17F)
	{
		return scripts\anim\combat_utility::func_128AA(0);
	}

	var_00 = 0;
	if(!isdefined(self.var_10C) || !self.var_10C scripts\common\utility::func_9DFB())
	{
		var_00 = scripts\anim\combat_utility::func_B019();
	}

	if(!var_00 && isdefined(self.var_10C) && !scripts\anim\utility_common::func_3908())
	{
		if(gettime() >= self.var_F17F)
		{
			return scripts\anim\combat_utility::func_128AA(0);
		}
	}

	return var_00;
}

//Function Number: 32
func_128B1(param_00)
{
	if(isdefined(param_00.var_BD1C))
	{
		if([[ param_00.var_BD1C ]]())
		{
			return 1;
		}
	}

	return scripts\anim\combat_utility::func_B019();
}

//Function Number: 33
func_F5AE()
{
	var_00 = scripts\anim\utility::func_B028("exposed_turn");
	foreach(var_03, var_02 in var_00)
	{
		self.var_1491.var_2274[var_03] = var_02;
	}
}

//Function Number: 34
func_F318()
{
	var_00 = scripts\anim\utility::func_B028("exposed_turn_crouch");
	foreach(var_03, var_02 in var_00)
	{
		self.var_1491.var_2274[var_03] = var_02;
	}
}

//Function Number: 35
func_129B4(param_00)
{
}

//Function Number: 36
func_BD1C()
{
	if(!isdefined(self.var_10C))
	{
		return 0;
	}

	if(isdefined(self.var_54C3))
	{
		self.var_54C3 = undefined;
		return 0;
	}

	if(!isdefined(self.var_205))
	{
		return 0;
	}

	if(scripts\common\utility::func_9EB2(self.var_205))
	{
		return 0;
	}

	if(randomint(3) == 0)
	{
		return 0;
	}

	if(self.var_132 || self.var_FC || self.var_1A3 || self.var_1A4)
	{
		return 0;
	}

	if(distancesquared(self.origin,self.var_205.origin) > 256)
	{
		return 0;
	}

	var_00 = self method_80E8();
	if(isdefined(var_00) && var_00 != self.var_205 && self method_83D4(var_00))
	{
		self.var_1016F = 1;
		self.var_10171 = var_00;
		self.var_54C3 = 1;
		wait(0.5);
		return 1;
	}

	return 0;
}