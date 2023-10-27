/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: animscripts\door.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 206 ms
 * Timestamp: 10/27/2023 2:18:17 AM
*******************************************************************/

//Function Number: 1
func_1088()
{
	self endon("killanimscript");
	if(isdefined(self.var_1089))
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

		wait 0.2;
	}

	var_01 = var_00.type == "Door Interior" || self comparenodedirtopathdir(var_00);
	if(var_01)
	{
		func_10A1(var_00);
	}
	else
	{
		func_10A4(var_00);
	}

	for(;;)
	{
		var_02 = self getdoorpathnode();
		if(!isdefined(var_02) || var_02 != var_00)
		{
			break;
		}

		wait 0.2;
	}

	thread func_1088();
}

//Function Number: 2
func_108A()
{
	self endon("killanimscript");
	self.teamflashbangimmunity = 1;
	wait 5;
	self.teamflashbangimmunity = undefined;
}

//Function Number: 3
func_108C(param_00)
{
	thread func_108A();
	if(self.grenadeweapon == "flash_grenade")
	{
		self notify("flashbang_thrown");
	}

	self orientmode("face current");
	param_00.var_108D = gettime() + 5000;
	self.var_108E = gettime() + 100000;
	self notify("move_interrupt");
	self.var_FC9 = undefined;
	self clearanim(%combatrun,0.2);
	self.a.movement = "stop";
	self waittill("done_grenade_throw");
	self orientmode("face default");
	self.var_108E = gettime() + 5000;
	self.grenadeweapon = self.var_108F;
	self.var_108F = undefined;
	animscripts/run::func_FE2();
	thread animscripts/move::func_1090();
	thread animscripts/move::func_1091(1);
}

//Function Number: 4
func_1092(param_00,param_01,param_02,param_03,param_04)
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
		if(isdefined(self.var_73C) || !isdefined(self.enemy))
		{
			return;
		}

		if(func_10A0(param_00,var_08))
		{
			return;
		}

		if(!self seerecently(self.enemy,0.2) && self.a.pose == "stand" && func_109F(self.enemy.origin - param_00.origin,360000,16384))
		{
			if(isdefined(param_00.var_108D) && param_00.var_108D > gettime())
			{
				return;
			}

			if(self canshootenemy())
			{
				return;
			}

			var_0C = param_00.origin - self.origin;
			if(lengthsquared(var_0C) < param_03)
			{
				return;
			}

			if(vectordot(var_0C,var_08) < 0)
			{
				return;
			}

			self.var_108F = self.grenadeweapon;
			self.grenadeweapon = param_01;
			animscripts/combat_utility::func_1093(self.enemy);
			if(!var_05)
			{
				var_0E = var_09 + var_08 * 100;
				if(!self isgrenadepossafe(self.enemy,var_0E,128))
				{
					return;
				}
			}

			var_05 = 1;
			if(animscripts/combat_utility::func_1095(self.enemy,var_0A,var_07,animscripts/combat_utility::func_1094(var_07),1,0,1))
			{
				func_108C(param_00);
				return;
			}
		}

		var_06--;
		wait param_04;
		var_0F = self getdoorpathnode();
		if(!isdefined(var_0F) || var_0F != param_00)
		{
			return;
		}
	}
}

//Function Number: 5
func_1096()
{
	self endon("killanimscript");
	if(isdefined(self.var_1089))
	{
		return;
	}

	self.var_1097 = 0;
	for(;;)
	{
		if(self isindoor() && !self.var_748)
		{
			func_1098();
		}
		else if(!isdefined(self.var_108E) || self.var_108E < gettime())
		{
			self.var_108E = undefined;
			func_109C();
		}

		wait 0.2;
	}
}

//Function Number: 6
func_1098()
{
	if(!isdefined(self.neverenablecqb) && !self.var_748)
	{
		self.var_1097 = 1;
		if(!isdefined(self.cqbwalking) || !self.cqbwalking)
		{
			maps\_utility::enable_cqbwalk(1);
		}
	}
}

//Function Number: 7
func_109C()
{
	if(!isdefined(self.cqbenabled))
	{
		self.var_1097 = 0;
		if(isdefined(self.cqbwalking) && self.cqbwalking)
		{
			maps\_utility::disable_cqbwalk();
		}
	}
}

//Function Number: 8
func_109F(param_00,param_01,param_02)
{
	return param_00[0] * param_00[0] + param_00[1] * param_00[1] < param_01 && param_00[2] * param_00[2] < param_02;
}

//Function Number: 9
func_10A0(param_00,param_01)
{
	var_02 = param_00.origin - self.origin;
	var_03 = param_00.origin - self.enemy.origin;
	return vectordot(var_02,param_01) * vectordot(var_03,param_01) > 0;
}

//Function Number: 10
func_10A1(param_00)
{
	for(;;)
	{
		if(isdefined(self.var_10A2) && self.var_10A2 == 0 || self.var_10A2 < randomfloat(1))
		{
			break;
		}

		if(func_109F(self.origin - param_00.origin,562500,25600))
		{
			func_1092(param_00,"fraggrenade",0,302500,0.3);
			param_00 = self getdoorpathnode();
			if(!isdefined(param_00))
			{
				return;
			}

			break;
		}

		wait 0.1;
	}

	for(;;)
	{
		if(func_109F(self.origin - param_00.origin,-28672,6400))
		{
			func_1098();
			self.var_108E = gettime() + 6000;
			if(isdefined(self.doorflashchance) && self.doorflashchance == 0 || self.doorflashchance < randomfloat(1))
			{
				return;
			}

			func_1092(param_00,"flash_grenade",1,4096,0.2);
			return;
		}

		wait 0.1;
	}
}

//Function Number: 11
func_10A4(param_00)
{
	for(;;)
	{
		if(!self.var_1097 || distancesquared(self.origin,param_00.origin) < 1024)
		{
			return;
		}

		wait 0.1;
	}
}