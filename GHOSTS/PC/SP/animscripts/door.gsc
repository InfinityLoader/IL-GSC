/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\door.gsc
 * Game: Call of Duty: Ghosts
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 184 ms
 * Timestamp: 10/27/2023 1:23:57 AM
*******************************************************************/

//Function Number: 1
func_29F0()
{
	self endon("killanimscript");
	if(isdefined(self.var_27A8))
	{
		return;
	}

	for(;;)
	{
		var_00 = self getdoorpathnode();
		if(isdefined(var_00))
		{
			break;
		}

		wait(0.2);
	}

	var_01 = var_00.type == "Door Interior" || self comparenodedirtopathdir(var_00);
	if(var_01)
	{
		func_29ED(var_00);
	}
	else
	{
		doorexit(var_00);
	}

	for(;;)
	{
		var_02 = self getdoorpathnode();
		if(!isdefined(var_02) || var_02 != var_00)
		{
			break;
		}

		wait(0.2);
	}

	thread func_29F0();
}

//Function Number: 2
func_7F92()
{
	self endon("killanimscript");
	self.teamflashbangimmunity = 1;
	wait(5);
	self.teamflashbangimmunity = undefined;
}

//Function Number: 3
func_286D(param_00)
{
	thread func_7F92();
	if(self.grenadeweapon == "flash_grenade")
	{
		self notify("flashbang_thrown");
	}

	self orientmode("face current");
	param_00.nextdoorgrenadetime = gettime() + 5000;
	self.var_5282 = gettime() + 100000;
	self notify("move_interrupt");
	self.var_868B = undefined;
	self clearanim(%combatrun,0.2);
	self.a.var_5486 = "stop";
	self waittill("done_grenade_throw");
	self orientmode("face default");
	self.var_5282 = gettime() + 5000;
	self.grenadeweapon = self.var_58C1;
	self.var_58C1 = undefined;
	animscripts/run::func_2D51();
	thread animscripts/move::func_5B30();
	thread animscripts/move::func_6645(1);
}

//Function Number: 4
func_29EF(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 0;
	var_06 = 3;
	var_07 = undefined;
	var_07 = %cqb_stand_grenade_throw;
	var_08 = anglestoforward(param_00.angles);
	if(param_00.type == "Door Interior" && !self comparenodedirtopathdir(param_00))
	{
		var_08 = -1 * var_08;
	}

	var_09 = (param_00.origin[0],param_00.origin[1],param_00.origin[2] + 64);
	var_0A = var_09;
	if(param_02)
	{
		var_0B = anglestoright(param_00.angles);
		var_0C = param_00.origin - self.origin;
		var_0D = vectordot(var_0B,var_0C);
		if(var_0D > 20)
		{
			var_0D = 20;
		}
		else if(var_0D < -20)
		{
			var_0D = -20;
		}

		var_0A = var_09 + var_0D * var_0B;
	}

	while(var_06 > 0)
	{
		if(isdefined(self.grenade) || !isdefined(self.enemy))
		{
		}

		if(func_5971(param_00,var_08))
		{
		}

		if(!self seerecently(self.enemy,0.2) && self.a.var_60B1 == "stand" && func_27FD(self.enemy.origin - param_00.origin,360000,16384))
		{
			if(isdefined(param_00.nextdoorgrenadetime) && param_00.nextdoorgrenadetime > gettime())
			{
			}

			if(self canshootenemy())
			{
			}

			var_0C = param_00.origin - self.origin;
			if(lengthsquared(var_0C) < param_03)
			{
			}

			if(vectordot(var_0C,var_08) < 0)
			{
			}

			self.var_58C1 = self.grenadeweapon;
			self.grenadeweapon = param_01;
			animscripts/combat_utility::setactivegrenadetimer(self.enemy);
			if(!var_05)
			{
				var_0E = var_09 + var_08 * 100;
				if(!self isgrenadepossafe(self.enemy,var_0E,128))
				{
				}
			}

			var_05 = 1;
			if(animscripts/combat_utility::func_8402(self.enemy,var_0A,var_07,animscripts/combat_utility::func_3AC0(var_07),1,0,1))
			{
				func_286D(param_00);
			}
		}

		var_06--;
		wait(param_04);
		var_0F = self getdoorpathnode();
		if(!isdefined(var_0F) || var_0F != param_00)
		{
		}
	}
}

//Function Number: 5
indoorcqbtogglecheck()
{
	self endon("killanimscript");
	if(isdefined(self.var_27A8))
	{
	}

	self.var_48E0 = 0;
	for(;;)
	{
		if(self isindoor() && !self.doingambush)
		{
			doorenter_enable_cqbwalk();
		}
		else if(!isdefined(self.var_5282) || self.var_5282 < gettime())
		{
			self.var_5282 = undefined;
			func_29F2();
		}

		wait(0.2);
	}
}

//Function Number: 6
doorenter_enable_cqbwalk()
{
	if(!isdefined(self.neverenablecqb) && !self.doingambush)
	{
		self.var_48E0 = 1;
		if(!isdefined(self.var_1FFA) || !self.var_1FFA)
		{
			maps\_utility::enable_cqbwalk(1);
		}
	}
}

//Function Number: 7
func_29F2()
{
	if(!isdefined(self.cqbenabled))
	{
		self.var_48E0 = 0;
		if(isdefined(self.var_1FFA) && self.var_1FFA)
		{
			maps\_utility::disable_cqbwalk();
		}
	}
}

//Function Number: 8
func_27FD(param_00,param_01,param_02)
{
	return param_00[0] * param_00[0] + param_00[1] * param_00[1] < param_01 && param_00[2] * param_00[2] < param_02;
}

//Function Number: 9
func_5971(param_00,param_01)
{
	var_02 = param_00.origin - self.origin;
	var_03 = param_00.origin - self.enemy.origin;
	return vectordot(var_02,param_01) * vectordot(var_03,param_01) > 0;
}

//Function Number: 10
func_29ED(param_00)
{
	for(;;)
	{
		if(isdefined(self.doorfragchance) && self.doorfragchance == 0 || self.doorfragchance < randomfloat(1))
		{
			break;
		}

		if(func_27FD(self.origin - param_00.origin,562500,25600))
		{
			func_29EF(param_00,"fraggrenade",0,302500,0.3);
			param_00 = self getdoorpathnode();
			if(!isdefined(param_00))
			{
			}

			break;
		}

		wait(0.1);
	}

	for(;;)
	{
		if(func_27FD(self.origin - param_00.origin,-28672,6400))
		{
			doorenter_enable_cqbwalk();
			self.var_5282 = gettime() + 6000;
			if(isdefined(self.var_29F3) && self.var_29F3 == 0 || self.var_29F3 < randomfloat(1))
			{
			}

			func_29EF(param_00,"flash_grenade",1,4096,0.2);
		}

		wait(0.1);
	}
}

//Function Number: 11
doorexit(param_00)
{
	for(;;)
	{
		if(!self.var_48E0 || distancesquared(self.origin,param_00.origin) < 1024)
		{
		}

		wait(0.1);
	}
}