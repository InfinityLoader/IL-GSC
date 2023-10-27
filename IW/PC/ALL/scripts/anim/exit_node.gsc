/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\exit_node.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 15
 * Decompile Time: 747 ms
 * Timestamp: 10/27/2023 12:00:34 AM
*******************************************************************/

//Function Number: 1
func_10DCA()
{
	if(isdefined(self.var_4C90))
	{
		func_4C90();
		return;
	}

	self endon("killanimscript");
	if(!func_3E57())
	{
		return;
	}

	var_00 = self.origin;
	var_01 = self.angles[1];
	var_02 = "exposed";
	var_03 = 0;
	var_04 = func_7EA3();
	if(isdefined(var_04))
	{
		var_05 = func_53C7(var_04);
		if(isdefined(var_05))
		{
			var_02 = var_05;
			var_03 = 1;
			if(isdefined(self.var_8CD0))
			{
				var_02 = func_53C5(var_04,var_02);
			}

			if(!isdefined(level.var_6A1B[var_02]) && var_02 != "stand_saw" && var_02 != "crouch_saw")
			{
				var_06 = scripts\common\utility::func_152F(self.angles[1] - scripts\asm\shared_utility::func_7FF7(var_04));
				if(var_06 < 5)
				{
					if(!isdefined(self.var_8CD0))
					{
						var_00 = var_04.origin;
					}

					var_01 = scripts\asm\shared_utility::func_7FF7(var_04);
				}
			}
		}
	}

	if(!func_3E56(var_02,var_04))
	{
		return;
	}

	var_07 = isdefined(level.var_6A1B[var_02]);
	if(!var_03)
	{
		var_02 = func_53C8();
	}

	var_08 = (-1 * self.var_1BE[0],-1 * self.var_1BE[1],0);
	var_09 = func_7F97(var_04);
	var_0A = var_09.var_B490;
	var_0B = var_09.var_68CA;
	var_0C = spawnstruct();
	func_371A(var_0C,var_02,0,var_01,var_08,var_0A,var_0B);
	func_1043F(var_0C,var_0A);
	var_0D = -1;
	var_0E = 3;
	if(var_07)
	{
		var_0E = 1;
	}

	for(var_0F = 1;var_0F <= var_0E;var_0F++)
	{
		var_0D = var_0C.var_12654[var_0F];
		if(func_3E2C(var_00,var_01,var_02,var_07,var_0D))
		{
			break;
		}
	}

	if(var_0F > var_0E)
	{
		return;
	}

	var_10 = distancesquared(self.origin,self.var_471C) * 1.25 * 1.25;
	if(distancesquared(self.origin,self.var_233) < var_10)
	{
		return;
	}

	func_5926(var_02,var_0D);
}

//Function Number: 2
func_53C7(param_00)
{
	if(scripts\anim\cover_arrival::func_393C(param_00))
	{
		if(param_00.type == "Cover Stand")
		{
			return "stand_saw";
		}

		if(param_00.type == "Cover Crouch")
		{
			return "crouch_saw";
		}
		else if(param_00.type == "Cover Prone")
		{
			return "prone_saw";
		}
	}

	if(!isdefined(level.var_20EB[param_00.type]))
	{
		return;
	}

	if(isdefined(level.var_E1B7[param_00.type]) && level.var_E1B7[param_00.type] != self.var_1491.var_D6A5)
	{
		return;
	}

	var_01 = self.var_1491.var_D6A5;
	if(var_01 == "prone")
	{
		var_01 = "crouch";
	}

	var_02 = level.var_20EB[param_00.type][var_01];
	if(scripts\anim\cover_arrival::func_130C9() && var_02 == "exposed")
	{
		var_02 = "exposed_ready";
	}

	if(scripts\anim\utility::func_FFDB())
	{
		var_03 = var_02 + "_cqb";
		if(isdefined(level.var_2128["soldier"]["cover_exit"][var_03]))
		{
			var_02 = var_03;
		}
	}

	return var_02;
}

//Function Number: 3
func_3E57()
{
	if(!isdefined(self.var_233))
	{
		return 0;
	}

	if(!self method_8380())
	{
		return 0;
	}

	if(self.var_1491.var_D6A5 == "prone")
	{
		return 0;
	}

	if(isdefined(self.var_55ED) && self.var_55ED)
	{
		return 0;
	}

	if(self.var_2C0 != "none")
	{
		return 0;
	}

	if(!self method_81BF("stand") && !isdefined(self.var_8CD0))
	{
		return 0;
	}

	if(distancesquared(self.origin,self.var_233) < 10000)
	{
		return 0;
	}

	return 1;
}

//Function Number: 4
func_3E56(param_00,param_01)
{
	if(!isdefined(param_00))
	{
		return 0;
	}

	if(param_00 == "exposed" || isdefined(self.var_8CD0))
	{
		if(self.var_1491.var_D6A5 != "stand" && self.var_1491.var_D6A5 != "crouch")
		{
			return 0;
		}

		if(self.var_1491.var_BCC8 != "stop")
		{
			return 0;
		}
	}

	if(!isdefined(self.var_8CD0) && isdefined(self.var_10C) && vectordot(self.var_1BE,self.var_10C.origin - self.origin) < 0)
	{
		if(scripts\anim\utility_common::func_3908() && distancesquared(self.origin,self.var_10C.origin) < 90000)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 5
func_53C8(param_00)
{
	if(self.var_1491.var_D6A5 == "stand")
	{
		param_00 = "exposed";
	}
	else
	{
		param_00 = "exposed_crouch";
	}

	if(scripts\anim\cover_arrival::func_130C9())
	{
		param_00 = "exposed_ready";
	}

	if(scripts\anim\utility::func_FFDB())
	{
		param_00 = param_00 + "_cqb";
	}
	else if(isdefined(self.var_8CD0))
	{
		param_00 = "heat";
	}

	return param_00;
}

//Function Number: 6
func_7F97(param_00)
{
	var_01 = spawnstruct();
	if(isdefined(param_00) && isdefined(level.var_B490[param_00.type]))
	{
		var_01.var_B490 = level.var_B490[param_00.type];
		var_01.var_68CA = level.var_68CA[param_00.type];
	}
	else
	{
		var_01.var_B490 = 9;
		var_01.var_68CA = -1;
	}

	return var_01;
}

//Function Number: 7
func_371A(param_00,param_01,param_02,param_03,param_04,param_05,param_06)
{
	param_00.var_1267B = [];
	param_00.var_12654 = [];
	var_07 = undefined;
	var_08 = 1;
	var_09 = 0;
	if(param_02)
	{
		var_07 = scripts\anim\utility::func_B027("cover_trans_angles",param_01);
		var_08 = -1;
		var_09 = 0;
	}
	else
	{
		var_07 = scripts\anim\utility::func_B027("cover_exit_angles",param_01);
		var_08 = 1;
		var_09 = 180;
	}

	for(var_0A = 1;var_0A <= param_05;var_0A++)
	{
		param_00.var_12654[var_0A] = var_0A;
		if(var_0A == 5 || var_0A == param_06 || !isdefined(var_07[var_0A]))
		{
			param_00.var_1267B[var_0A] = -1.0003;
			continue;
		}

		var_0B = (0,param_03 + var_08 * var_07[var_0A] + var_09,0);
		var_0C = vectornormalize(anglestoforward(var_0B));
		param_00.var_1267B[var_0A] = vectordot(param_04,var_0C);
	}
}

//Function Number: 8
func_1043F(param_00,param_01)
{
	for(var_02 = 2;var_02 <= param_01;var_02++)
	{
		var_03 = param_00.var_1267B[param_00.var_12654[var_02]];
		var_04 = param_00.var_12654[var_02];
		for(var_05 = var_02 - 1;var_05 >= 1;var_05--)
		{
			if(var_03 < param_00.var_1267B[param_00.var_12654[var_05]])
			{
				break;
			}

			param_00.var_12654[var_05 + 1] = param_00.var_12654[var_05];
		}

		param_00.var_12654[var_05 + 1] = var_04;
	}
}

//Function Number: 9
func_3E2C(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = (0,param_01,0);
	var_06 = anglestoforward(var_05);
	var_07 = anglestoright(var_05);
	var_08 = scripts\anim\utility::func_B031("cover_exit_dist",param_02,param_04);
	var_09 = var_06 * var_08[0];
	var_0A = var_07 * var_08[1];
	var_0B = param_00 + var_09 - var_0A;
	self.var_471C = var_0B;
	if(!param_03 && !self method_8068(var_0B))
	{
		return 0;
	}

	if(!self method_81FF(self.origin,var_0B))
	{
		return 0;
	}

	if(param_04 <= 6 || param_03)
	{
		return 1;
	}

	var_0C = scripts\anim\utility::func_B031("cover_exit_postdist",param_02,param_04);
	var_09 = var_06 * var_0C[0];
	var_0A = var_07 * var_0C[1];
	var_0D = var_0B + var_09 - var_0A;
	self.var_471C = var_0D;
	return self method_81FF(var_0B,var_0D);
}

//Function Number: 10
func_5926(param_00,param_01)
{
	var_02 = scripts\anim\utility::func_B031("cover_exit",param_00,param_01);
	var_03 = vectortoangles(self.var_1BE);
	if(self.var_1491.var_D6A5 == "prone")
	{
		return;
	}

	var_05 = 0.2;
	if(scripts\common\utility::func_167E())
	{
		self method_8016("nogravity",0);
	}
	else
	{
		self method_8016("zonly_physics",0);
	}

	self method_8221("face angle",self.angles[1]);
	self method_82E4("coverexit",var_02,%body,1,var_05,self.var_BD22);
	scripts\anim\shared::func_592B("coverexit");
	self.var_1491.var_D6A5 = "stand";
	self.var_1491.var_BCC8 = "run";
	self.var_932E = undefined;
	self method_8221("face motion");
	self method_8016("none",0);
	func_6CD5("coverexit");
	self method_806F(%root,0.2);
	self method_8221("face default");
	self method_8016("normal",0);
}

//Function Number: 11
func_6CD5(param_00)
{
	self endon("move_loop_restart");
	scripts\anim\shared::func_592B(param_00);
}

//Function Number: 12
func_53C5(param_00,param_01)
{
	if(param_00.type == "Cover Right")
	{
		param_01 = "heat_right";
	}
	else if(param_00.type == "Cover Left")
	{
		param_01 = "heat_left";
	}

	return param_01;
}

//Function Number: 13
func_7EA3()
{
	var_00 = undefined;
	var_01 = 400;
	if(scripts\common\utility::func_167E())
	{
		var_01 = 1024;
	}
	else if(isdefined(self.var_8CD0))
	{
		var_01 = 4096;
	}

	if(isdefined(self.var_205) && distancesquared(self.origin,self.var_205.origin) < var_01)
	{
		var_00 = self.var_205;
	}
	else if(isdefined(self.var_24A) && distancesquared(self.origin,self.var_24A.origin) < var_01)
	{
		var_00 = self.var_24A;
	}

	if(isdefined(self.var_8CD0) && !scripts\common\utility::func_167E())
	{
		if(isdefined(var_00) && scripts\common\utility::func_152F(self.angles[1] - var_00.angles[1]) > 30)
		{
			return undefined;
		}
	}

	return var_00;
}

//Function Number: 14
func_4C90()
{
	var_00 = self.var_4C90;
	if(!isdefined(self.var_CA6B))
	{
		self.var_4C90 = undefined;
	}

	var_01 = [[ var_00 ]]();
	if(!isdefined(self.var_CA6B))
	{
		self.var_10DCB = undefined;
	}

	if(!isdefined(var_01))
	{
		var_01 = 0.2;
	}

	self method_806F(%root,var_01);
	self method_8221("face default");
	self method_8016("none",0);
}

//Function Number: 15
func_4EAB(param_00)
{
	if(!scripts\anim\cover_arrival::func_4EAC())
	{
	}
}