/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_float.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 5
 * Decompile Time: 78 ms
 * Timestamp: 10/27/2023 2:34:20 AM
*******************************************************************/

//Function Number: 1
main(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = getentarray("script_floater","targetname");
	if(!var_05.size)
	{
		return;
	}

	var_06 = 10;
	var_07 = 0.5;
	var_08 = 50;
	var_09 = (0,0,0);
	var_0A = 10;
	if(isdefined(param_00))
	{
		var_06 = param_00;
	}

	if(isdefined(param_01))
	{
		var_07 = param_01;
	}

	if(isdefined(param_02))
	{
		var_08 = param_02;
	}

	if(isdefined(param_04))
	{
		var_09 = param_04;
	}

	if(isdefined(param_03))
	{
		var_0A = param_03;
	}

	for(var_0B = 0;var_0B < var_05.size;var_0B++)
	{
		var_05[var_0B] thread func_3BA1(var_06,var_07,var_08,var_0A,var_09);
	}
}

//Function Number: 2
func_3BA1(param_00,param_01,param_02,param_03,param_04)
{
	self.range = param_00;
	self.time = 1 / param_01;
	self.var_3BA2 = self.time * 0.25;
	var_05 = self getorigin();
	var_06 = 360 / param_02;
	var_07 = distance(var_05,param_04);
	var_08 = var_07 * var_06;
	var_09 = sin(var_08);
	if(cos(var_08) < 0)
	{
		self.range = -1 * self.range;
	}

	var_0A = spawn("script_origin",var_05);
	self linkto(var_0A);
	var_0B = vectortoangles(var_05 - param_04);
	self.var_3BA3 = var_0A.angles;
	var_0A.angles = var_0A.angles + (param_03,param_03 * 0.25,var_0B[2]);
	self.var_3BA4 = var_0A.angles;
	thread func_3BA6(var_09,var_0A);
	thread func_3BA5(var_09,var_0A);
}

//Function Number: 3
func_3BA5(param_00,param_01)
{
	self endon("death");
	self endon("stop_float_script");
	wait func_3BA7(self.time * param_00);
	for(;;)
	{
		self.var_3BA4 = self.var_3BA4 * -1;
		param_01 rotateto(self.var_3BA4,self.time,self.var_3BA2,self.var_3BA2);
		param_01 waittill("rotatedone");
	}
}

//Function Number: 4
func_3BA6(param_00,param_01)
{
	self endon("death");
	self endon("stop_float_script");
	wait func_3BA7(self.time * param_00);
	param_01 movez(self.range * 0.5,self.time * 0.5,self.var_3BA2,self.var_3BA2);
	for(;;)
	{
		param_01 waittill("movedone");
		self.range = -1 * self.range;
		param_01 movez(self.range,self.time,self.var_3BA2,self.var_3BA2);
	}
}

//Function Number: 5
func_3BA7(param_00)
{
	if(param_00 < 0)
	{
		return -1 * param_00;
	}

	return param_00;
}