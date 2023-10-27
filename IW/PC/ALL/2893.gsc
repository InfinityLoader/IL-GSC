/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 2893.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 43
 * Decompile Time: 11 ms
 * Timestamp: 10/27/2023 12:24:43 AM
*******************************************************************/

//Function Number: 1
func_AB6F(param_00,param_01,param_02)
{
	return param_00 + param_01 - param_00 * param_02;
}

//Function Number: 2
func_AB7D(param_00,param_01,param_02)
{
	return param_02 - param_00 / param_01 - param_00;
}

//Function Number: 3
func_13198(param_00,param_01)
{
	return vectornormalize(param_00 - vectordot(param_01,param_00) * param_01);
}

//Function Number: 4
func_13199(param_00,param_01)
{
	return vectornormalize(2 * func_13198(param_00,param_01) - param_00);
}

//Function Number: 5
func_7BC5(param_00,param_01,param_02,param_03)
{
	var_04 = param_03 * 2 - 1;
	var_05 = param_01 - param_00;
	var_06 = (0,0,1);
	var_07 = param_00 + param_03 * var_05;
	var_07 = var_07 + var_04 * var_04 * -1 + 1 * param_02 * var_06;
	return var_07;
}

//Function Number: 6
func_DF68(param_00,param_01,param_02,param_03,param_04)
{
	return param_03 + param_00 - param_01 * param_04 - param_03 / param_02 - param_01;
}

//Function Number: 7
func_C097(param_00,param_01,param_02)
{
	if(param_00 > param_01)
	{
		var_03 = param_00;
		param_00 = param_01;
		param_01 = var_03;
	}

	if(param_02 > param_01)
	{
		return 1;
	}
	else if(param_02 < param_00)
	{
		return 0;
	}
	else if(param_00 == param_01)
	{
	}

	return param_02 - param_00 / param_01 - param_00;
}

//Function Number: 8
func_6A8E(param_00,param_01,param_02)
{
	return param_01 * param_02 + param_00 * 1 - param_02;
}

//Function Number: 9
func_C09C(param_00)
{
	if(param_00 < 0.5)
	{
		param_00 = param_00 * 2;
		param_00 = func_C09A(param_00);
		param_00 = param_00 * 0.5;
	}
	else
	{
		param_00 = param_00 - 0.5 * 2;
		param_00 = func_C09B(param_00);
		param_00 = param_00 * 0.5 + 0.5;
	}

	return param_00;
}

//Function Number: 10
func_C09A(param_00)
{
	return param_00 * param_00;
}

//Function Number: 11
func_C09B(param_00)
{
	param_00 = 1 - param_00;
	param_00 = param_00 * param_00;
	param_00 = 1 - param_00;
	return param_00;
}

//Function Number: 12
func_ACE9(param_00,param_01,param_02,param_03)
{
	var_04 = vectordot(param_03,param_02);
	var_05 = param_01 - param_00;
	var_06 = vectordot(param_03,var_05);
	if(var_06 == 0)
	{
		return undefined;
	}

	var_07 = var_04 - vectordot(param_03,param_00) / var_06;
	var_08 = param_00 + var_05 * var_07;
	return var_08;
}

//Function Number: 13
func_13DE5(param_00,param_01,param_02)
{
	while(param_02 > param_01)
	{
		param_02 = param_02 - param_01 - param_00 + 1;
	}

	return param_02;
}

//Function Number: 14
func_6B04(param_00,param_01,param_02)
{
	return (func_1E78(param_00[0],param_01[0],param_02),func_1E78(param_00[1],param_01[1],param_02),func_1E78(param_00[2],param_01[2],param_02));
}

//Function Number: 15
func_1E78(param_00,param_01,param_02)
{
	return angleclamp(param_00 + angleclamp180(param_01 - param_00) * param_02);
}

//Function Number: 16
func_9C85(param_00)
{
	var_01 = 0;
	if(isplayer(self))
	{
		var_02 = param_00 - self getorigin();
		var_03 = anglestoforward(self getplayerangles(1));
		var_01 = vectordot(var_02,var_03);
	}
	else
	{
		var_02 = var_02 - self.origin;
		var_03 = anglestoforward(self.angles);
		var_01 = vectordot(var_02,var_03);
	}

	return var_01 > 0;
}

//Function Number: 17
func_9C86(param_00)
{
	var_01 = 0;
	if(isplayer(self))
	{
		var_02 = param_00 - self getorigin();
		var_03 = anglestoright(self getplayerangles(1));
		var_01 = vectordot(var_02,var_03);
	}
	else
	{
		var_02 = var_02 - self.origin;
		var_03 = anglestoright(self.angles);
		var_01 = vectordot(var_02,var_03);
	}

	return var_01 > 0;
}

//Function Number: 18
func_7ADE(param_00,param_01)
{
	return (param_00[0] + param_01[0] * 0.5,param_00[1] + param_01[1] * 0.5,param_00[2] + param_01[2] * 0.5);
}

//Function Number: 19
func_F47E(param_00)
{
	var_01 = anglestoforward(self.angles);
	var_02 = vectorcross(var_01,param_00);
	var_03 = vectorcross(param_00,var_02);
	self.angles = axistoangles(var_03,var_02,param_00);
}

//Function Number: 20
func_DCA0()
{
	var_00 = randomfloat(360);
	return (cos(var_00),sin(var_00),0);
}

//Function Number: 21
func_F47F(param_00,param_01)
{
	if(!isdefined(param_01))
	{
		param_01 = self.angles;
	}

	self.angles = func_31AB(param_00,param_01);
}

//Function Number: 22
func_31AB(param_00,param_01)
{
	var_02 = acos(-1 * vectordot(anglestoforward(param_01),param_00));
	var_03 = anglestoup(param_01 + (var_02,0,0));
	var_04 = vectorcross(var_03,param_00);
	var_03 = vectorcross(param_00,var_04);
	return axistoangles(var_03,var_04,param_00);
}

//Function Number: 23
func_4A7B(param_00,param_01,param_02)
{
	thread func_4A7C(param_00,param_01,param_02);
}

//Function Number: 24
func_4A7C(param_00,param_01,param_02)
{
	self endon("death");
	self endon("stop_spring");
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_03 = func_10AAE(param_01,self.origin,anglestoforward(self.angles) * param_02);
	while(distancesquared(self.origin,param_00) > squared(0.1))
	{
		self.origin = func_10AB4(var_03,param_00);
		wait(0.05);
	}

	self notify("movedone");
	func_10AAA(var_03);
}

//Function Number: 25
func_4A79(param_00,param_01,param_02)
{
	thread func_4A7A(param_00,param_01,param_02);
}

//Function Number: 26
func_4A7A(param_00,param_01,param_02)
{
	self endon("death");
	self endon("stop_spring");
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	var_03 = func_10AAE(param_01,self.origin,anglestoforward(self.angles) * param_02);
	while(distancesquared(self.origin,param_00) > squared(0.1))
	{
		self.origin = func_10AB4(var_03,param_00);
		self.angles = vectortoangles(func_10AAC(var_03));
		wait(0.05);
	}

	self notify("movedone");
	func_10AAA(var_03);
}

//Function Number: 27
func_C7E2(param_00,param_01,param_02,param_03)
{
	thread func_C7E3(param_00,param_01,param_02,param_03);
}

//Function Number: 28
func_C7E3(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("stop_spring");
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	var_04 = func_10AAF(param_01,param_02,self.origin,anglestoforward(self.angles) * param_03);
	while(distancesquared(self.origin,param_00) > squared(0.1))
	{
		self.origin = func_10AB4(var_04,param_00);
		wait(0.05);
	}

	self notify("movedone");
	func_10AAA(var_04);
}

//Function Number: 29
func_12B88(param_00,param_01,param_02,param_03)
{
	thread func_12B89(param_00,param_01,param_02,param_03);
}

//Function Number: 30
func_12B89(param_00,param_01,param_02,param_03)
{
	self endon("death");
	self endon("stop_spring");
	if(!isdefined(param_03))
	{
		param_03 = 1;
	}

	var_04 = func_10AB0(param_01,param_02,self.origin,anglestoforward(self.angles) * param_03);
	while(distancesquared(self.origin,param_00) > squared(0.1) || length(func_10AAC(var_04)) < squared(0.1))
	{
		self.origin = func_10AB4(var_04,param_00);
		wait(0.05);
	}

	self notify("movedone");
	func_10AAA(var_04);
}

//Function Number: 31
func_10AAE(param_00,param_01,param_02)
{
	var_03 = func_10AA8(param_01,param_02);
	var_04 = param_00 * 0.05;
	var_05 = exp(-1 * var_04);
	level.var_10AB5[var_03].var_332A = var_04 + 1 * var_05;
	level.var_10AB5[var_03].var_332B = var_05;
	level.var_10AB5[var_03].var_332C = -1 * var_04 * var_04 * var_05;
	level.var_10AB5[var_03].var_332D = 1 - var_04 * var_05;
	func_10AB2(var_03,param_01);
	func_10AB3(var_03,param_02);
	return var_03;
}

//Function Number: 32
func_10AAF(param_00,param_01,param_02,param_03)
{
	var_04 = func_10AA8(param_02,param_03);
	var_05 = param_00 * param_00;
	var_06 = -1 * sqrt(param_01 * param_01 + 4 * var_05);
	var_07 = 0.5 * var_06 + param_01;
	var_08 = 0.5 * var_06 - param_01;
	var_09 = var_08 - var_07;
	var_0A = 1 / var_09;
	var_0B = exp(var_07 * 0.05);
	var_0C = exp(var_08 * 0.05);
	var_0D = var_0C - var_0B;
	level.var_10AB5[var_04].var_332B = var_0D * var_0A;
	level.var_10AB5[var_04].var_332A = var_0B - var_07 * level.var_10AB5[var_04].var_332B;
	level.var_10AB5[var_04].var_332D = var_08 * var_0C - var_07 * var_0B * var_0A;
	level.var_10AB5[var_04].var_332C = var_07 * var_0B - level.var_10AB5[var_04].var_332D;
	func_10AB2(var_04,param_02);
	func_10AB3(var_04,param_03);
	return var_04;
}

//Function Number: 33
func_10AB0(param_00,param_01,param_02,param_03)
{
	var_04 = func_10AA8(param_02,param_03);
	var_05 = -0.5 * param_01;
	var_06 = param_00;
	var_07 = exp(var_05 * 0.05) / var_06;
	var_08 = angleclamp(var_06 * 0.05);
	var_09 = sin(var_08);
	var_0A = cos(var_08);
	var_0B = var_06 * var_0A;
	var_0C = var_05 * var_09;
	level.var_10AB5[var_04].var_332A = var_07 * var_0B - var_0C;
	level.var_10AB5[var_04].var_332B = var_07 * var_09;
	level.var_10AB5[var_04].var_332C = var_07 * -1 * var_09 * var_05 * var_05 + var_06 * var_06;
	level.var_10AB5[var_04].var_332D = var_07 * var_0B + var_0C;
	func_10AB2(var_04,param_02);
	func_10AB3(var_04,param_03);
	return var_04;
}

//Function Number: 34
func_10AB4(param_00,param_01,param_02,param_03)
{
	if(isdefined(param_02))
	{
		func_10AB2(param_00,param_02);
	}

	if(isdefined(param_03))
	{
		func_10AB3(param_00,param_03);
	}

	var_04 = level.var_10AB5[param_00].var_D699 - param_01;
	var_05 = level.var_10AB5[param_00].var_332A * var_04 + level.var_10AB5[param_00].var_332B * level.var_10AB5[param_00].var_1326C;
	var_06 = level.var_10AB5[param_00].var_332C * var_04 + level.var_10AB5[param_00].var_332D * level.var_10AB5[param_00].var_1326C;
	level.var_10AB5[param_00].var_D699 = var_05 + param_01;
	level.var_10AB5[param_00].var_1326C = var_06;
	return level.var_10AB5[param_00].var_D699;
}

//Function Number: 35
func_10AAA(param_00)
{
	level.var_10AB5[param_00] = undefined;
}

//Function Number: 36
func_10AAB(param_00)
{
	return level.var_10AB5[param_00].var_D699;
}

//Function Number: 37
func_10AAC(param_00)
{
	return level.var_10AB5[param_00].var_1326C;
}

//Function Number: 38
func_10AAD()
{
	if(!isdefined(level.var_10AB5))
	{
		level.var_10AB5 = [];
		level.var_10AA9 = 0;
	}
}

//Function Number: 39
func_10AA8(param_00,param_01)
{
	func_10AAD();
	var_02 = level.var_10AA9;
	level.var_10AA9++;
	level.var_10AB5[var_02] = spawnstruct();
	level.var_10AB5[var_02].var_D699 = param_00;
	level.var_10AB5[var_02].var_1326C = param_01;
	level.var_10AB5[var_02].var_332A = 0;
	level.var_10AB5[var_02].var_332B = 0;
	level.var_10AB5[var_02].var_332C = 0;
	level.var_10AB5[var_02].var_332D = 0;
	return var_02;
}

//Function Number: 40
func_10AB2(param_00,param_01)
{
	level.var_10AB5[param_00].var_D699 = param_01;
}

//Function Number: 41
func_10AB3(param_00,param_01)
{
	level.var_10AB5[param_00].var_1326C = param_01;
}

//Function Number: 42
func_D638(param_00,param_01,param_02,param_03)
{
	return squared(param_00[0] - param_01[0]) / squared(param_02) + squared(param_00[1] - param_01[1]) / squared(param_03) <= 1;
}

//Function Number: 43
func_EB9B(param_00,param_01)
{
	return vectordot(vectornormalize(param_00),param_01);
}