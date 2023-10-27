/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_treeburst.gsc
 * Game: Call of Duty: Modern Warfare 3
 * Platform: Console
 * Function Count: 4
 * Decompile Time: 73 ms
 * Timestamp: 10/27/2023 2:34:40 AM
*******************************************************************/

//Function Number: 1
main()
{
	var_00 = getentarray("treeburst","script_noteworthy");
	for(var_01 = 0;var_01 < var_00.size;var_01++)
	{
		var_00[var_01] thread func_3E63();
	}
}

//Function Number: 2
func_3E63()
{
	self waittill("treeburst");
	if(isdefined(self.var_3E64))
	{
		var_00 = self.var_3E64;
	}
	else
	{
		var_00 = randomint(360);
	}

	var_01 = (self.angles[0],var_00,self.angles[2]);
	var_02 = anglestoforward(var_01);
	var_02 = var_02 * 100;
	var_03 = self.origin + var_02 + (0,0,512);
	var_04 = var_03 + (0,0,-1024);
	var_05 = bullettrace(var_03,var_04,0,self);
	var_06 = self.origin + var_02 - var_05["position"];
	var_07 = var_06[2];
	var_08 = 0;
	var_09 = 0;
	var_0A = var_09;
	var_0B = 0;
	var_0C = var_0B;
	while(var_09 < var_07)
	{
		var_08 = var_08 + 340;
		var_0A = var_09;
		var_09 = var_09 + var_08;
		var_0C = var_0B;
		var_0B++;
	}

	var_0D = var_0A - var_07;
	if(var_0D < 0)
	{
		var_0D = var_0D * -1;
	}

	var_0E = var_0C + var_0D / var_08;
	self movegravity(var_02,var_0E);
	self waittill("movedone");
	var_0F = vectornormalize(var_02);
	var_0F = var_0F * 320;
	var_03 = self.origin + var_0F + (0,0,512);
	var_04 = var_03 + (0,0,-1024);
	var_05 = bullettrace(var_03,var_04,0,self);
	var_10 = var_05["position"];
	var_11 = anglestoup(self.angles);
	var_12 = vectortoangles(var_11);
	var_13 = var_10 - self.origin;
	var_14 = vectortoangles(var_13);
	var_15 = spawn("script_origin",self.origin);
	var_15.origin = self.origin;
	var_15.angles = (var_12[0],var_14[1],var_14[2]);
	self linkto(var_15);
	var_15 rotateto(var_14,1.15,0.5,0);
	var_15 waittill("rotatedone");
	var_15 rotatepitch(-2.5,0.21,0.05,0.15);
	var_15 waittill("rotatedone");
	var_15 rotatepitch(2.5,0.26,0.15,0.1);
	var_15 waittill("rotatedone");
	self unlink();
	var_15 delete();
}

//Function Number: 3
drawline(param_00,param_01,param_02,param_03)
{
	wait 0.05;
}

//Function Number: 4
draworigin(param_00,param_01,param_02)
{
	if(!isdefined(param_02))
	{
		param_02 = 1;
	}

	if(isdefined(param_01))
	{
		wait 0.05;
		return;
	}

	for(;;)
	{
		var_03 = (1,0,0);
		var_04 = (0,1,0);
		var_05 = (0,0,1);
		wait 0.05;
	}
}