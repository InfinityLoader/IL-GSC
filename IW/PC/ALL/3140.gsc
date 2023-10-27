/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 3140.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 3 ms
 * Timestamp: 10/27/2023 12:26:14 AM
*******************************************************************/

//Function Number: 1
func_35BF(param_00,param_01,param_02,param_03)
{
	self endon(param_01 + "_finished");
	self.var_B55B.var_312F = 1;
	var_04 = "far";
	var_05 = lib_0A1B::func_2925();
	if(isdefined(var_05))
	{
		var_06 = var_05.origin - self.origin;
		if(lengthsquared(var_06) < 7744)
		{
			var_04 = "near";
		}

		self method_8221("face angle",vectortoyaw(var_06));
	}

	var_07 = lib_0A1E::func_2356(param_01,var_04);
	var_08 = 0.8;
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82EA(param_01,var_07,1,param_02,var_08);
	lib_0A1A::func_232F("melee_attack","begin");
	thread func_8482(param_01);
	lib_0A1E::func_231F(param_00,param_01,lib_0A1A::func_2341(param_00,param_01));
}

//Function Number: 2
func_35C0(param_00,param_01,param_02)
{
	if(func_35C2() || !isdefined(self.var_B55B.var_2AAE))
	{
		func_35BB();
	}
}

//Function Number: 3
func_3616(param_00,param_01,param_02,param_03)
{
	if(lib_0C64::func_B5B5(param_00,param_01,param_02,param_03))
	{
		return 0;
	}

	return isdefined(self.var_B55B.var_2AAE);
}

//Function Number: 4
func_35C3(param_00,param_01,param_02,param_03)
{
	var_04 = lib_0A1E::func_2336(param_00,param_01);
	self method_806F(lib_0A1E::func_2339(),param_02);
	self method_82EA(param_01,var_04,1,param_02,0.5);
	lib_0A1E::func_231F(param_00,param_01,lib_0A1A::func_2341(param_00,param_01));
}

//Function Number: 5
func_35C4(param_00,param_01,param_02)
{
	lib_0A1A::func_232F("melee_attack","end");
	func_35BB();
}

//Function Number: 6
func_35BB()
{
	if(isdefined(self.var_B55B) && isdefined(self.var_B55B.target))
	{
		self.var_B55B.target.var_B55B = undefined;
	}

	if(isdefined(self.var_B55B) && isdefined(self.var_B55B.var_1168C))
	{
		self.var_B55B.var_1168C delete();
	}

	lib_0C64::func_B58E();
}

//Function Number: 7
func_35C1(param_00)
{
	switch(param_00)
	{
		case "grab":
			break;

		case "lookat":
			if(isplayer(self.var_B55B.target))
			{
				thread func_B010();
			}
			break;

		case "throw":
			thread func_11831();
			break;
	}
}

//Function Number: 8
func_3584(param_00,param_01,param_02)
{
	var_03 = lib_0A1E::func_2356(param_01,self.var_B55B.var_1180D);
	return var_03;
}

//Function Number: 9
func_35C2()
{
	if(!isalive(self))
	{
		return 1;
	}

	if(!isdefined(self.var_B55B))
	{
		return 1;
	}

	if(isdefined(self.var_B55B.var_2720))
	{
		return 1;
	}

	if(!isdefined(self.var_B55B.target))
	{
		return 1;
	}

	if(!isalive(self.var_B55B.target))
	{
		return 1;
	}

	if(!isdefined(self.var_B55B.target.var_B55B))
	{
		return 1;
	}

	return 0;
}

//Function Number: 10
func_8482(param_00)
{
	self endon(param_00 + "_finished");
	for(;;)
	{
		if(func_35C2())
		{
			break;
		}

		if(isdefined(self.var_B55B.var_2720))
		{
			break;
		}

		var_01 = self gettagorigin("j_wrist_z_ri");
		var_02 = self.var_B55B.target.origin + rotatevector((34,3.4,43.752),self.var_B55B.target.angles);
		if(distancesquared(var_02,var_01) <= 1600)
		{
			func_8481();
			break;
		}

		wait(0.05);
	}
}

//Function Number: 11
func_8481()
{
	self.var_B55B.var_2AAE = 1;
	var_00 = self gettagorigin("j_wrist_z_ri");
	var_01 = self gettagangles("j_wrist_z_ri");
	var_02 = spawn("script_model",var_00);
	var_02 setmodel("tag_origin");
	self.var_B55B.var_1168C = var_02;
	var_03 = ["left","right","forward"];
	self.var_B55B.var_1180D = var_03[randomint(var_03.size)];
	var_04 = (0,229,180);
	if(isplayer(self.var_B55B.target))
	{
		switch(self.var_B55B.var_1180D)
		{
			case "left":
				var_04 = (15,229,180);
				break;

			case "right":
				var_04 = (30,229,180);
				break;

			case "forward":
				var_04 = (-5,290,180);
				break;
		}
	}

	var_02 linkto(self,"j_wrist_z_ri",(34,3.4,43.752),var_04);
	if(isplayer(self.var_B55B.target))
	{
		func_35DC();
		level.player dodamage(level.player.health * 0.6,self.origin,self);
		level.player.ignoreme = 1;
		var_05 = 0.15;
		level.player playerlinktoblend(var_02,"tag_origin",var_05);
		level.player method_8291(5,0,0,var_05);
		wait(var_05);
		level.player playerlinktodelta(var_02,"tag_origin",1,0,0,0,0,1);
		level.player method_81DF(0.4,0,0,60,60,80,15);
		return;
	}

	self.var_B55B.target linktoblendtotag(var_02,"tag_origin");
}

//Function Number: 12
func_35DC()
{
	level.player allowstand(1);
	level.player allowcrouch(0);
	level.player allowprone(0);
}

//Function Number: 13
func_35DD()
{
	level.player allowstand(1);
	level.player allowcrouch(1);
	level.player allowprone(1);
}

//Function Number: 14
func_B010()
{
	var_00 = lib_0A1E::func_2356("melee_throw",self.var_B55B.var_1180D);
	var_01 = self method_8104(var_00);
	self method_82B1(var_00,0);
	wait(0.5);
	self method_82B1(var_00,var_01);
}

//Function Number: 15
func_11831()
{
	self endon("death");
	var_00 = self gettagorigin("j_wrist_z_ri");
	wait(0.05);
	var_01 = self gettagorigin("j_wrist_z_ri") + (0,0,7) - var_00;
	var_02 = length(var_01);
	var_03 = vectornormalize(var_01);
	var_04 = var_02 * 30 * var_03;
	var_05 = self.var_B55B.target;
	if(!isalive(var_05))
	{
		return;
	}

	if(isplayer(var_05))
	{
		var_06 = var_05;
		var_07 = vectortoangles(-1 * var_03);
		switch(self.var_B55B.var_1180D)
		{
			case "left":
				var_07 = var_07 + (0,-30,0);
				break;

			case "right":
				var_07 = var_07 + (45,60,0);
				break;

			case "forward":
				var_07 = var_07 + (-10,190,0);
				break;
		}

		self.var_B55B.var_1168C unlink();
		var_07 = var_07 - self gettagangles("j_wrist_z_ri");
		self.var_B55B.var_1168C linkto(self,"j_wrist_z_ri",(34,3.4,43.752),var_07);
		var_08 = 0.15;
		var_05 method_81DF(var_08,0,0,0,0,0,0);
		var_05 method_8291(5,0,0,var_08);
		wait(var_08);
		func_35DD();
		var_05 unlink();
		var_05 setvelocity(var_04);
		var_05.ignoreme = 0;
		return;
	}

	var_05.var_2303.var_DC21 = var_04;
	var_05.var_2303.var_4E40 = ::func_1A3D;
	var_05 method_8016("nogravity");
	var_05 method_81D0(self gettagorigin("j_wrist_z_ri"));
}

//Function Number: 16
func_1A3D()
{
	self method_839B("torso_upper",self.var_2303.var_DC21 * 7,0);
	wait(0.05);
	self unlink();
}