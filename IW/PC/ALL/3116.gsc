/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3116.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 21
 * Decompile Time: 11 ms
 * Timestamp: 10/27/2023 12:26:09 AM
*******************************************************************/

//Function Number: 1
func_98E6(param_00)
{
	self.var_BCE4 = 1;
	self.var_2B0D = 1;
	self.var_BF86 = gettime() + 10000;
	return level.var_111AE;
}

//Function Number: 2
func_9FEC(param_00,param_01)
{
	if(!isalive(param_00))
	{
		return 0;
	}

	if(isdefined(param_00.var_B36D))
	{
		return 0;
	}

	if(param_00.team != self.team)
	{
		if(!scripts\common\utility::istrue(param_00.var_9CEF))
		{
			return 0;
		}
	}

	if(isdefined(param_00.agent_type))
	{
		switch(param_00.agent_type)
		{
			case "zombie_grey":
			case "zombie_brute":
				return 0;
		}
	}

	if(scripts\common\utility::istrue(param_00.var_9CEC))
	{
		return 0;
	}

	if(scripts\common\utility::istrue(param_00.var_EF64))
	{
		return 0;
	}

	var_02 = param_00.origin - self.origin;
	var_02 = (var_02[0],var_02[1],0);
	var_03 = vectordot(var_02,param_01);
	if(var_03 < 0.5)
	{
		return 0;
	}

	var_04 = distancesquared(param_00.origin,self.origin);
	if(var_04 > 10000)
	{
		return 0;
	}

	return 1;
}

//Function Number: 3
func_531B(param_00)
{
	var_01 = anglestoforward(self.angles);
	var_02 = scripts\mp\_mp_agent::func_7D95("all");
	self.var_2997 = undefined;
	var_03 = [];
	foreach(var_05 in var_02)
	{
		if(var_05 == self)
		{
			continue;
		}

		if(!func_9FEC(var_05,var_01))
		{
			continue;
		}

		if(!scripts\common\utility::istrue(var_05.var_9E0C))
		{
			continue;
		}

		var_03[var_03.size] = var_05;
		if(var_03.size >= 3)
		{
			self.var_2997 = 1;
			return level.var_6AD5;
		}
	}

	foreach(var_05 in var_03)
	{
		var_05 dodamage(var_05.health + 1000,self.origin,undefined,undefined,"MOD_IMPACT");
	}

	return level.var_6AD5;
}

//Function Number: 4
func_12F69(param_00)
{
	if(isdefined(self.var_13F9D))
	{
		return level.var_6AD5;
	}

	var_01 = anglestoforward(self.angles);
	if(isdefined(self.var_13F9E) && func_9FEC(self.var_13F9E,var_01))
	{
		return level.var_6AD5;
	}

	self.var_13F9E = undefined;
	var_02 = scripts\mp\_mp_agent::func_7D95("all");
	foreach(var_04 in var_02)
	{
		if(var_04 == self)
		{
			continue;
		}

		if(!func_9FEC(var_04,var_01))
		{
			continue;
		}

		if(scripts\common\utility::istrue(var_04.var_9E0C))
		{
			continue;
		}

		self.var_13F9E = var_04;
		break;
	}

	return level.var_6AD5;
}

//Function Number: 5
func_12EA6(param_00)
{
	if(!isdefined(self.var_527A) || !isdefined(self.var_8E14))
	{
		return level.var_6AD5;
	}

	if(self.var_8E14 != self.var_527A)
	{
		self method_841F();
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 6
func_38AF(param_00)
{
	if(!isdefined(self.var_13F9D))
	{
		return level.var_6AD5;
	}

	if(!isdefined(self.var_10C))
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_BFB2))
	{
		if(gettime() < self.var_BFB2)
		{
			return level.var_6AD5;
		}
	}

	var_01 = anglestoforward(self.angles);
	var_02 = self.var_10C.origin - self.origin;
	var_02 = (var_02[0],var_02[1],0);
	var_02 = vectornormalize(var_02);
	if(vectordot(var_01,var_02) < 0)
	{
		return level.var_6AD5;
	}

	if(!self method_805F(self.var_10C))
	{
		return level.var_6AD5;
	}

	return level.var_111AE;
}

//Function Number: 7
func_38BE(param_00)
{
	if(!isdefined(self.var_8E14) || self.var_8E14 == "hand")
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_13F9D))
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_13F9E))
	{
		return level.var_111AE;
	}

	return level.var_6AD5;
}

//Function Number: 8
func_9609(param_00)
{
	self.var_3324 = 1;
}

//Function Number: 9
func_D979(param_00)
{
	if(!isdefined(self.var_13F9E))
	{
		return level.var_6AD5;
	}

	if(!isdefined(self.var_13FAB))
	{
		var_01 = anglestoforward(self.angles);
		if(isdefined(self.var_13F9E) && !func_9FEC(self.var_13F9E,var_01))
		{
			return level.var_6AD5;
		}
	}

	if(!scripts\common\utility::istrue(self.var_3324))
	{
		return level.var_6AD5;
	}

	return level.var_E87A;
}

//Function Number: 10
func_116EA(param_00)
{
	self.var_3324 = undefined;
}

//Function Number: 11
func_9704(param_00)
{
	self.var_3322 = 1;
}

//Function Number: 12
func_D983(param_00)
{
	if(self.var_8E14 == "hand")
	{
		if(isdefined(self.var_13F9D))
		{
			self.var_13F9D delete();
		}

		self.var_13F9D = undefined;
		return level.var_6AD5;
	}

	if(!isdefined(self.var_10C))
	{
		return level.var_111AE;
	}

	if(!scripts\common\utility::istrue(self.var_3322))
	{
		return level.var_111AE;
	}

	if(scripts\common\utility::istrue(self.var_29D1))
	{
		return level.var_E87A;
	}

	var_01 = anglestoforward(self.angles);
	var_02 = self.var_10C.origin - self.origin;
	var_02 = (var_02[0],var_02[1],0);
	var_02 = vectornormalize(var_02);
	if(vectordot(var_01,var_02) < 0)
	{
		return level.var_6AD5;
	}

	if(!self method_805F(self.var_10C))
	{
		return level.var_6AD5;
	}

	return level.var_E87A;
}

//Function Number: 13
func_116EE(param_00)
{
	self.var_3322 = undefined;
	self.var_BFB2 = gettime() + randomintrange(5000,6000);
}

//Function Number: 14
func_390C(param_00)
{
	if(!isdefined(self.var_8E14) && self.var_8E14 == "head")
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_BF73))
	{
		if(gettime() < self.var_BF73)
		{
			return level.var_6AD5;
		}
	}

	if(!isdefined(self.var_10C))
	{
		return level.var_6AD5;
	}

	if(isdefined(self.var_BF86))
	{
		if(gettime() < self.var_BF86)
		{
			return level.var_6AD5;
		}
	}

	if(isdefined(level.gator_mouth_trig) && self istouching(level.gator_mouth_trig))
	{
		return level.var_6AD5;
	}

	var_01 = 10000;
	if(isdefined(self.var_A8AF) && distancesquared(self.var_A8AF,self.origin) < var_01)
	{
		return level.var_6AD5;
	}

	var_02 = distancesquared(self.var_10C.origin,self.origin);
	if(var_02 > 562500)
	{
		return level.var_6AD5;
	}

	if(var_02 < -25536)
	{
		return level.var_6AD5;
	}

	if(!self method_805F(self.var_10C))
	{
		self.var_A8B8 = undefined;
		return level.var_6AD5;
	}

	var_03 = gettime();
	if(!isdefined(self.var_A8B8) || !isdefined(self.var_A8B7) || self.var_A8B7 != self.var_10C)
	{
		self.var_A8B8 = var_03;
		self.var_A8B7 = self.var_10C;
		return level.var_6AD5;
	}

	if(var_03 - self.var_A8B8 < 1500)
	{
		return level.var_6AD5;
	}

	var_04 = scripts\common\trace::func_48BC(1,1,1,0,1,0,0);
	self.var_BF73 = var_03 + 250;
	var_05 = 0;
	var_06 = [];
	foreach(var_08 in level.var_1900)
	{
		if(isalive(var_08))
		{
			var_06[var_05] = var_08;
			var_05++;
		}
	}

	if(isdefined(self.var_8DDA))
	{
		var_06[var_06.size] = self.var_8DDA;
	}

	var_0A = self.var_10C method_810C();
	var_0B = function_0288(self gettagorigin("tag_eye"),var_0A,10,var_04,var_06,"physicsquery_closest");
	if(isdefined(var_0B) && var_0B.size > 0)
	{
		if(isdefined(var_0B[0]["hittype"]) && var_0B[0]["hittype"] == "hittype_entity")
		{
			if(var_0B[0]["entity"] == self.var_10C)
			{
				return level.var_111AE;
			}
		}
	}

	self.var_A8B8 = var_03;
	return level.var_6AD5;
}

//Function Number: 15
func_9652(param_00)
{
	self.var_2B5A = 1;
	self.var_A872 = undefined;
	self.var_A873 = self.var_10C;
	self.laserfailsafetime = gettime() + 3000;
}

//Function Number: 16
func_D97F(param_00)
{
	if(!isdefined(self.var_A873) || !isdefined(self.var_10C) || self.var_10C != self.var_A873)
	{
		return level.var_6AD5;
	}

	if(!scripts\common\utility::istrue(self.var_2B5B))
	{
		if(gettime() > self.laserfailsafetime)
		{
			return level.var_6AD5;
		}

		return level.var_E87A;
	}

	if(!isdefined(self.var_A872))
	{
		self.var_A872 = gettime();
	}

	if(scripts\common\utility::istrue(self.var_2B5A))
	{
		if(gettime() < self.var_A872 + 6000)
		{
			return level.var_E87A;
		}
	}

	return level.var_6AD5;
}

//Function Number: 17
func_116ED(param_00)
{
	self.var_2B5A = 0;
	self.var_A873 = undefined;
	self.var_BF86 = gettime() + randomintrange(5000,10000);
	self.var_A8B8 = undefined;
	self.var_A8B7 = undefined;
	self.laserfailsafetime = undefined;
}

//Function Number: 18
func_FFED(param_00)
{
	return level.var_6AD5;
}

//Function Number: 19
func_95C5(param_00)
{
}

//Function Number: 20
func_D971(param_00)
{
	return level.var_6AD5;
}

//Function Number: 21
func_116E9(param_00)
{
}