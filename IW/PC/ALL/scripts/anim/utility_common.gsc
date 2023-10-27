/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\utility_common.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 66
 * Decompile Time: 3355 ms
 * Timestamp: 10/27/2023 12:01:14 AM
*******************************************************************/

//Function Number: 1
func_D8F0(param_00,param_01,param_02,param_03,param_04,param_05)
{
	var_06 = param_00 / 0.05;
	for(var_07 = 0;var_07 < var_06;var_07++)
	{
		wait(0.05);
	}
}

//Function Number: 2
func_D8EF(param_00,param_01,param_02,param_03,param_04)
{
	var_05 = 100;
	var_06 = 0;
	param_00 = param_00 + scripts\common\utility::func_DCC8(30);
	for(var_07 = 0;var_07 < var_05;var_07++)
	{
		var_06 = var_06 + 0.5;
		wait(0.05);
	}
}

//Function Number: 3
func_4A99(param_00,param_01)
{
	return param_00[0] * param_01[1] - param_00[1] * param_01[0] > 0;
}

//Function Number: 4
func_EA26(param_00,param_01)
{
	var_02 = int(param_00) % param_01;
	var_02 = var_02 + param_01;
	return var_02 % param_01;
}

//Function Number: 5
func_DB51(param_00)
{
	var_01 = cos(param_00);
	var_02 = sin(param_00);
	var_03["front"] = 0;
	var_03["right"] = 0;
	var_03["back"] = 0;
	var_03["left"] = 0;
	if(isdefined(self.var_1D64))
	{
		var_03["front"] = 1;
		return var_03;
	}

	if(var_01 > 0)
	{
		if(var_02 > var_01)
		{
			var_03["left"] = 1;
		}
		else if(var_02 < -1 * var_01)
		{
			var_03["right"] = 1;
		}
		else
		{
			var_03["front"] = 1;
		}
	}
	else
	{
		var_04 = -1 * var_01;
		if(var_02 > var_04)
		{
			var_03["left"] = 1;
		}
		else if(var_02 < var_01)
		{
			var_03["right"] = 1;
		}
		else
		{
			var_03["back"] = 1;
		}
	}

	return var_03;
}

//Function Number: 6
func_80A4(param_00)
{
	param_00 = angleclamp(param_00);
	if(param_00 < 45 || param_00 > 315)
	{
		var_01 = "front";
	}
	else if(var_01 < 135)
	{
		var_01 = "left";
	}
	else if(var_01 < 225)
	{
		var_01 = "back";
	}
	else
	{
		var_01 = "right";
	}

	return var_01;
}

//Function Number: 7
func_9E50(param_00,param_01)
{
	for(var_02 = param_01.size - 1;var_02 >= 0;var_02--)
	{
		if(param_00 == param_01[var_02])
		{
			return 1;
		}
	}

	return 0;
}

//Function Number: 8
func_13C40()
{
	return self.var_394 != "none" && function_0246(self.var_394) && weaponclass(self.var_394) == "spread";
}

//Function Number: 9
func_9F4F(param_00)
{
	return weaponclass(param_00) == "spread";
}

//Function Number: 10
func_9F62(param_00)
{
	return weaponclass(param_00) == "sniper";
}

//Function Number: 11
func_9F50()
{
	return func_9F4F(self.var_D8E1);
}

//Function Number: 12
func_9D4D(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	if(!func_9F62(self.var_D8E1))
	{
		return 0;
	}

	if(param_00)
	{
		if(self.var_D8E1 != self.var_394)
		{
			return func_9F62(self.var_394);
		}
	}

	return 1;
}

//Function Number: 13
func_9E83()
{
	return func_9D4D() || func_1311B();
}

//Function Number: 14
func_13115()
{
	return weaponclass(self.var_394) == "pistol";
}

//Function Number: 15
func_1311B()
{
	return weaponclass(self.var_394) == "rocketlauncher";
}

//Function Number: 16
func_13112()
{
	return weaponclass(self.var_394) == "mg";
}

//Function Number: 17
func_9FC9()
{
	return weaponclass(self.var_394) == "spread";
}

//Function Number: 18
func_1311A()
{
	var_00 = weaponclass(self.var_394);
	switch(var_00)
	{
		case "sniper":
		case "mg":
		case "smg":
		case "rifle":
		case "spread":
			return 1;
	}

	return 0;
}

//Function Number: 19
func_E191(param_00,param_01,param_02)
{
	if(!isdefined(param_00) || !isdefined(param_01) || !isdefined(param_02))
	{
		return;
	}

	if(!isplayer(param_01))
	{
		return;
	}

	var_03 = getweaponbasename(param_00);
	if(!isdefined(var_03) || var_03 != "iw7_repeater")
	{
		return;
	}

	if(!isdefined(param_02.var_DD))
	{
		return;
	}

	if(param_02.var_DD != "head" && param_02.var_DD != "helmet")
	{
		return;
	}

	var_04 = weaponclipsize(param_00);
	var_05 = var_04 * 1;
	var_06 = param_01 getweaponammoclip(param_00);
	var_07 = min(var_06 + var_05,var_04);
	param_01 setweaponammoclip(param_00,int(var_07));
}

//Function Number: 20
func_BE9E(param_00)
{
	if(self.var_394 == "none")
	{
		return 0;
	}

	if(isdefined(self.var_C08B))
	{
		if(self.var_3250 < weaponclipsize(self.var_394) * 0.5)
		{
			self.var_3250 = int(weaponclipsize(self.var_394) * 0.5);
		}

		if(self.var_3250 <= 0)
		{
			self.var_3250 = 0;
		}

		return 0;
	}

	if(self.var_3250 <= weaponclipsize(self.var_394) * param_00)
	{
		if(param_00 == 0)
		{
			if(func_3D55())
			{
				return 0;
			}
		}

		return 1;
	}

	return 0;
}

//Function Number: 21
func_3D55()
{
	if(!isdefined(self.var_10C))
	{
		return 0;
	}

	if(self.team != "allies")
	{
		if(!isplayer(self.var_10C))
		{
			return 0;
		}
	}

	if(func_9FCA() || func_1311B())
	{
		return 0;
	}

	if(gettime() - self.var_1E3F < self.var_1E3E)
	{
		return 0;
	}

	if(!self method_805F(self.var_10C) && distancesquared(self.origin,self.var_10C.origin) > 65536)
	{
		return 0;
	}

	self.var_3250 = int(weaponclipsize(self.var_394) / 2);
	if(self.var_3250 > weaponclipsize(self.var_394))
	{
		self.var_3250 = weaponclipsize(self.var_394);
	}

	self.var_1E3F = gettime();
	return 1;
}

//Function Number: 22
func_9FC5()
{
	return self.var_394 == self.var_D8E1 && self.var_394 != "none";
}

//Function Number: 23
func_9FC8()
{
	return self.var_394 == self.var_F0C4 && self.var_394 != "none";
}

//Function Number: 24
func_9FCA()
{
	if(!isdefined(self.var_101B4))
	{
		return 0;
	}

	return self.var_394 == self.var_101B4 && self.var_394 != "none";
}

//Function Number: 25
func_7E28()
{
	var_00 = self.var_205;
	if(isdefined(var_00) && self method_8215(var_00) || isdefined(self.var_473C) && var_00 == self.var_473C)
	{
		return var_00;
	}

	return undefined;
}

//Function Number: 26
func_7FFE()
{
	var_00 = func_7E28();
	if(isdefined(var_00))
	{
		return var_00.type;
	}

	return "none";
}

//Function Number: 27
func_7FF4()
{
	var_00 = func_7E28();
	if(isdefined(var_00))
	{
		return var_00.angles[1];
	}

	return self.var_EC;
}

//Function Number: 28
func_7FF5()
{
	var_00 = func_7E28();
	if(isdefined(var_00))
	{
		return anglestoforward(var_00.angles);
	}

	return anglestoforward(self.angles);
}

//Function Number: 29
func_7FFD()
{
	var_00 = func_7E28();
	if(isdefined(var_00))
	{
		return var_00.origin;
	}

	return self.origin;
}

//Function Number: 30
func_FE9A(param_00)
{
	if(!isdefined(param_00))
	{
		param_00 = 1;
	}

	[[ level.var_FE9B ]](param_00);
}

//Function Number: 31
func_8003(param_00)
{
	if(isdefined(self.var_205))
	{
		var_01 = self.var_205.angles[1] - scripts\common\utility::func_8246(param_00);
	}
	else
	{
		var_01 = self.angles[1] - scripts\common\utility::func_8246(var_01);
	}

	var_01 = angleclamp180(var_01);
	return var_01;
}

//Function Number: 32
func_8002()
{
	var_00 = undefined;
	if(isdefined(self.var_10C))
	{
		var_00 = self.var_10C.origin;
	}
	else
	{
		if(isdefined(self.var_205))
		{
			var_01 = anglestoforward(self.var_205.angles);
		}
		else
		{
			var_01 = anglestoforward(self.angles);
		}

		var_01 = var_01 * 150;
		var_00 = self.origin + var_01;
	}

	if(isdefined(self.var_205))
	{
		var_02 = self.var_205.angles[1] - scripts\common\utility::func_8246(var_00);
	}
	else
	{
		var_02 = self.angles[1] - scripts\common\utility::func_8246(var_02);
	}

	var_02 = angleclamp180(var_02);
	return var_02;
}

//Function Number: 33
func_824A()
{
	var_00 = undefined;
	if(isdefined(self.var_10C))
	{
		var_00 = self.var_10C.origin;
	}
	else
	{
		var_01 = anglestoforward(self.angles);
		var_01 = var_01 * 150;
		var_00 = self.origin + var_01;
	}

	var_02 = self.angles[1] - scripts\common\utility::func_8246(var_00);
	var_02 = angleclamp180(var_02);
	return var_02;
}

//Function Number: 34
func_8245(param_00)
{
	var_01 = vectortoangles((param_00[0],param_00[1],0) - (self.origin[0],self.origin[1],0));
	return var_01[1];
}

//Function Number: 35
func_1535()
{
	var_00 = self.angles[1] - scripts\common\utility::func_8246(self.var_10C.origin);
	var_00 = angleclamp180(var_00);
	if(var_00 < 0)
	{
		var_00 = -1 * var_00;
	}

	return var_00;
}

//Function Number: 36
func_1534()
{
	var_00 = self.angles[1] - func_8245(self.var_10C.origin);
	var_00 = angleclamp180(var_00);
	if(var_00 < 0)
	{
		var_00 = -1 * var_00;
	}

	return var_00;
}

//Function Number: 37
func_1536(param_00)
{
	var_01 = self.angles[1] - scripts\common\utility::func_8246(param_00);
	var_01 = angleclamp180(var_01);
	if(var_01 < 0)
	{
		var_01 = -1 * var_01;
	}

	return var_01;
}

//Function Number: 38
func_1533(param_00)
{
	var_01 = self.angles[1] - param_00;
	var_01 = angleclamp180(var_01);
	if(var_01 < 0)
	{
		var_01 = -1 * var_01;
	}

	return var_01;
}

//Function Number: 39
func_8249(param_00,param_01)
{
	var_02 = vectortoangles(param_00 - param_01);
	return var_02[1];
}

//Function Number: 40
func_7EE7()
{
	return function_00EA(self.var_166);
}

//Function Number: 41
func_7E8D()
{
	if(isdefined(self.var_10C))
	{
		self.var_1491.var_A97C = self.var_10C method_815B();
		self.var_1491.var_A981 = gettime();
		return self.var_1491.var_A97C;
	}

	if(isdefined(self.var_1491.var_A981) && isdefined(self.var_1491.var_A97C) && self.var_1491.var_A981 + 3000 < gettime())
	{
		return self.var_1491.var_A97C;
	}

	var_00 = self method_815B();
	var_00 = var_00 + (196 * self.var_1C1[0],196 * self.var_1C1[1],196 * self.var_1C1[2]);
	return var_00;
}

//Function Number: 42
func_81DA(param_00)
{
	if(!isdefined(param_00))
	{
		return (0,0,0);
	}

	if(!isdefined(param_00.var_ECF3))
	{
		return param_00.angles;
	}

	var_01 = param_00.angles;
	var_02 = angleclamp180(var_01[0] + param_00.var_ECF3[0]);
	var_03 = var_01[1];
	var_04 = angleclamp180(var_01[2] + param_00.var_ECF3[2]);
	return (var_02,var_03,var_04);
}

//Function Number: 43
func_824B(param_00)
{
	if(isdefined(self.type) && scripts\common\utility::func_9EB1(self))
	{
		var_01 = func_81DA(self);
		var_02 = anglestoforward(var_01);
		var_03 = rotatepointaroundvector(var_02,param_00 - self.origin,var_01[2] * -1);
		var_03 = var_03 + self.origin;
		var_04 = scripts\common\utility::func_8246(var_03) - var_01[1];
		var_04 = angleclamp180(var_04);
		return var_04;
	}

	var_04 = scripts\common\utility::func_8246(var_04) - self.angles[1];
	var_04 = angleclamp180(var_04);
	return var_04;
}

//Function Number: 44
func_3909(param_00,param_01)
{
	var_02 = param_01 func_824B(param_00);
	if(var_02 > 60 || var_02 < -60)
	{
		return 0;
	}

	if(scripts\common\utility::func_9EB4(param_01) && var_02 < -14)
	{
		return 0;
	}

	if(scripts\common\utility::func_9EB7(param_01) && var_02 > 12)
	{
		return 0;
	}

	return 1;
}

//Function Number: 45
func_7FFC(param_00)
{
	if(isdefined(param_00.var_C364))
	{
		return param_00.var_C364;
	}

	var_01 = (-26,0.4,36);
	var_02 = (-32,7,63);
	var_03 = (43.5,11,36);
	var_04 = (36,8.3,63);
	var_05 = (3.5,-12.5,45);
	var_06 = (-3.7,-22,63);
	var_07 = 0;
	var_08 = (0,0,0);
	var_09 = anglestoright(param_00.angles);
	var_0A = anglestoforward(param_00.angles);
	var_0B = anglestoup(param_00.angles);
	var_0C = param_00.type;
	switch(var_0C)
	{
		case "Cover Left":
			if(param_00 method_812D() == "crouch")
			{
				var_08 = func_3718(var_09,var_0A,var_0B,var_01);
			}
			else
			{
				var_08 = func_3718(var_09,var_0A,var_0B,var_02);
			}
			break;

		case "Cover Right":
			if(param_00 method_812D() == "crouch")
			{
				var_08 = func_3718(var_09,var_0A,var_0B,var_03);
			}
			else
			{
				var_08 = func_3718(var_09,var_0A,var_0B,var_04);
			}
			break;

		case "Cover Stand":
		case "Conceal Stand":
		case "Turret":
		case "Cover Stand 3D":
			var_08 = func_3718(var_09,var_0A,var_0B,var_06);
			break;

		case "Conceal Crouch":
		case "Cover Crouch Window":
		case "Cover Crouch":
			var_08 = func_3718(var_09,var_0A,var_0B,var_05);
			break;

		case "Cover 3D":
			var_08 = func_7E3F(param_00);
			break;
	}

	param_00.var_C364 = var_08;
	return param_00.var_C364;
}

//Function Number: 46
func_7E3F(param_00,param_01)
{
	var_02 = (2,-10,35);
	var_03 = (-19,-10,32);
	var_04 = (16,-10,32);
	var_05 = anglestoright(param_00.angles);
	var_06 = anglestoforward(param_00.angles);
	var_07 = anglestoup(param_00.angles);
	var_08 = var_02;
	if(isdefined(param_01))
	{
		if(param_01 == "left")
		{
			var_08 = var_03;
		}
		else if(param_01 == "right")
		{
			var_08 = var_04;
		}
		else
		{
		}
	}

	return func_3718(var_05,var_06,var_07,var_08);
}

//Function Number: 47
func_3718(param_00,param_01,param_02,param_03)
{
	return param_00 * param_03[0] + param_01 * param_03[1] + param_02 * param_03[2];
}

//Function Number: 48
func_390A(param_00,param_01)
{
	if(scripts\common\utility::func_9EB4(param_01) || scripts\common\utility::func_9EB7(param_01))
	{
		if(!func_3909(param_00,param_01))
		{
			return 0;
		}
	}

	var_02 = func_7FFC(param_01);
	var_03 = param_01.origin + var_02;
	if(!func_3E33(var_03,param_00,param_01))
	{
		return 0;
	}

	if(!sighttracepassed(var_03,param_00,0,undefined))
	{
		if(scripts\common\utility::func_9EB3(param_01))
		{
			var_03 = (0,0,64) + param_01.origin;
			return sighttracepassed(var_03,param_00,0,undefined);
		}

		return 0;
	}

	return 1;
}

//Function Number: 49
func_CA71(param_00,param_01)
{
	self endon("death");
	level notify("newdebugline");
	level endon("newdebugline");
	wait(0.05);
}

//Function Number: 50
func_3908()
{
	if(!isdefined(self.var_10C))
	{
		self.var_8451 = undefined;
		return 0;
	}

	var_00 = func_7E8D();
	if(!isdefined(self.var_205))
	{
		var_01 = self method_805F(self.var_10C);
	}
	else if(scripts\common\utility::func_167E() && scripts\common\utility::func_9EB1(self.var_205))
	{
		var_01 = func_390A(var_01,self.var_205);
		if(!var_01)
		{
			var_00 = self.var_10C.origin + var_00 / 2;
			var_01 = func_390A(var_00,self.var_205);
		}
	}
	else
	{
		var_01 = func_390A(var_01,self.var_205);
	}

	if(var_01)
	{
		self.var_8451 = var_00;
		func_5962();
	}
	else
	{
	}

	return var_01;
}

//Function Number: 51
func_3E33(param_00,param_01,param_02)
{
	var_03 = self.var_368 - level.var_1A44;
	var_04 = self.var_100 + level.var_1A44;
	var_05 = param_01 - param_00;
	if(scripts\common\utility::func_167E())
	{
		if(isdefined(param_02) && scripts\common\utility::func_9EB1(param_02))
		{
			var_06 = param_02.angles;
		}
		else
		{
			var_06 = self.angles;
		}

		var_05 = rotatevectorinverted(var_05,var_06);
	}

	var_07 = angleclamp180(vectortoangles(var_05)[0]);
	if(var_07 < var_03)
	{
		return 0;
	}

	if(var_07 > var_04)
	{
		if(isdefined(param_02) && !scripts\common\utility::func_9EB3(param_02))
		{
			return 0;
		}

		if(var_07 > level.var_4717 + var_04)
		{
			return 0;
		}
	}

	return 1;
}

//Function Number: 52
func_5962()
{
	self.var_1491.var_1006B = 1;
}

//Function Number: 53
func_3917()
{
	if(!func_8C31())
	{
		self.var_8451 = undefined;
		return 0;
	}

	if(!isplayer(self.var_10C))
	{
		return func_1B05();
	}

	var_00 = self method_8142();
	if(!func_3E33(var_00,self.var_1B2))
	{
		return 0;
	}

	return func_6CB7(var_00);
}

//Function Number: 54
func_12EA2()
{
	if(!isdefined(self.var_1491.var_1006B))
	{
		self.var_1491.var_1006B = 1;
	}

	if(self.var_1491.var_1006B)
	{
		self.var_1491.var_83B8 = gettime() + randomintrange(15000,30000);
		self.var_1491.var_1006B = 0;
	}
}

//Function Number: 55
func_8C31()
{
	if(!isdefined(self.var_10C))
	{
		return 0;
	}

	if(!isdefined(self.var_1B2))
	{
		return 0;
	}

	func_12EA2();
	if(gettime() > self.var_1491.var_83B8)
	{
		return 0;
	}

	if(!isdefined(self.var_8451) && !func_BE8C())
	{
		return 0;
	}

	return 1;
}

//Function Number: 56
func_1B05()
{
	if(!self method_805A())
	{
		return 0;
	}

	var_00 = undefined;
	if(isdefined(self.var_10C.var_205))
	{
		var_01 = func_7FFC(self.var_10C.var_205);
		var_00 = self.var_10C.var_205.origin + var_01;
	}
	else
	{
		var_00 = self.var_10C method_815B();
	}

	if(!self method_8060(var_00))
	{
		return 0;
	}

	if(self.script == "combat")
	{
		if(!sighttracepassed(self geteye(),self method_8142(),0,undefined))
		{
			return 0;
		}
	}

	self.var_8451 = var_00;
	return 1;
}

//Function Number: 57
func_3905(param_00)
{
	if(!sighttracepassed(self method_815B(),param_00,0,undefined))
	{
		return 0;
	}

	if(self.var_1491.var_13CBA["right"] == "none")
	{
		return 0;
	}

	var_01 = self method_8142();
	return sighttracepassed(var_01,param_00,0,undefined);
}

//Function Number: 58
func_BE8C()
{
	if(isdefined(self.var_8451) && !func_3905(self.var_8451))
	{
		return 1;
	}

	return !isdefined(self.var_A97E) || self.var_A97E != self.var_1B2 || distancesquared(self.var_A97F,self.origin) > 1024;
}

//Function Number: 59
func_6CB7(param_00)
{
	if(isdefined(self.var_10C) && distancesquared(self.origin,self.var_10C.origin) > squared(self.var_10C.var_1D4))
	{
		self.var_8451 = undefined;
		return 0;
	}

	if(!sighttracepassed(self method_815B(),param_00,0,undefined))
	{
		self.var_8451 = undefined;
		return 0;
	}

	if(func_BE8C())
	{
		self.var_A97F = self.origin;
		self.var_A97E = self.var_1B2;
		var_01 = func_7E8D();
		var_02 = bullettrace(self.var_1B2,var_01,0,undefined);
		var_03 = var_02["position"];
		var_04 = self.var_1B2 - var_03;
		var_05 = vectornormalize(self.var_1B2 - param_00);
		var_04 = var_04 - var_05 * vectordot(var_04,var_05);
		var_06 = 20;
		var_07 = int(length(var_04) / var_06 + 0.5);
		if(var_07 < 1)
		{
			var_07 = 1;
		}

		if(var_07 > 4)
		{
			var_07 = 4;
		}

		var_08 = self.var_1B2 - var_03;
		var_08 = (var_08[0] / var_07,var_08[1] / var_07,var_08[2] / var_07);
		var_07++;
		var_09 = var_03;
		self.var_8451 = undefined;
		var_0A = 0;
		var_0B = 2;
		for(var_0C = 0;var_0C < var_07 + var_0B;var_0C++)
		{
			var_0D = sighttracepassed(param_00,var_09,0,undefined);
			var_0E = var_09;
			if(var_0C == var_07 - 1)
			{
				var_08 = var_08 - var_05 * vectordot(var_08,var_05);
			}

			var_09 = var_09 + var_08;
			if(var_0D)
			{
				var_0A++;
				self.var_8451 = var_0E;
				if(var_0C > 0 && var_0A < var_0B && var_0C < var_07 + var_0B - 1)
				{
					continue;
				}

				return 1;
			}
			else
			{
				var_0A = 0;
			}
		}
	}

	return isdefined(self.var_8451);
}

//Function Number: 60
func_3918()
{
	if(!func_8C31())
	{
		self.var_8451 = undefined;
		return 0;
	}

	if(!isplayer(self.var_10C))
	{
		return func_1B05();
	}

	if(isdefined(self.var_205))
	{
		if(scripts\common\utility::func_9EB4(self.var_205) || scripts\common\utility::func_9EB7(self.var_205))
		{
			if(!func_3909(func_7E8D(),self.var_205))
			{
				return 0;
			}
		}

		var_00 = func_7FFC(self.var_205);
		var_01 = self.var_205.origin + var_00;
	}
	else
	{
		var_01 = self method_8142();
	}

	if(!func_3E33(var_01,self.var_1B2))
	{
		return 0;
	}

	return func_6CB7(var_01);
}

//Function Number: 61
func_3907(param_00)
{
	if(!isdefined(self.var_10C))
	{
		return 0;
	}

	if((isdefined(param_00) && self method_805F(self.var_10C,param_00)) || self method_805F(self.var_10C))
	{
		if(!func_3E33(self geteye(),self.var_10C method_815B()))
		{
			return 0;
		}

		self.var_8451 = func_7E8D();
		func_5962();
		return 1;
	}

	return 0;
}

//Function Number: 62
func_DDC9()
{
	return isdefined(self.var_10C) && self method_8296(self.var_10C,5);
}

//Function Number: 63
func_9F8F()
{
	if(isdefined(self.var_72E7))
	{
		return self.var_72E7;
	}

	if(self.var_2D5 <= self.var_112CE)
	{
		return 0;
	}

	return self method_81C0();
}

//Function Number: 64
func_6561()
{
	if(!isdefined(self.var_10C))
	{
		return 0;
	}

	if(self.var_10C scripts\common\utility::func_9DFB())
	{
		return 1;
	}

	if(isplayer(self.var_10C))
	{
		if(isdefined(self.var_10C.health) && self.var_10C.health < self.var_10C.maxhealth)
		{
			return 1;
		}
	}
	else if(isai(self.var_10C) && self.var_10C func_9F8F())
	{
		return 1;
	}

	if(isdefined(self.var_10C.var_9F21) && self.var_10C.var_9F21)
	{
		return 1;
	}

	return 0;
}

//Function Number: 65
func_10077()
{
	if(!func_3907())
	{
		return 0;
	}

	if(!isdefined(self.var_473C) && !self method_8061())
	{
		return 0;
	}

	return 1;
}

//Function Number: 66
func_10434(param_00)
{
	var_01 = [];
	foreach(var_03 in param_00)
	{
		if(var_03.var_13CE8 <= 0)
		{
			continue;
		}

		for(var_04 = 0;var_04 < var_01.size;var_04++)
		{
			if(var_03.var_13CE8 < var_01[var_04].var_13CE8)
			{
				for(var_05 = var_01.size;var_05 > var_04;var_05--)
				{
					var_01[var_05] = var_01[var_05 - 1];
				}

				break;
			}
		}

		var_01[var_04] = var_03;
	}

	return var_01;
}