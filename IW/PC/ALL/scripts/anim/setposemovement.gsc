/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\setposemovement.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 55
 * Decompile Time: 2909 ms
 * Timestamp: 10/27/2023 12:00:57 AM
*******************************************************************/

//Function Number: 1
func_F804(param_00,param_01)
{
	if(param_00 == "")
	{
		if(self.var_1491.var_D6A5 == "prone" && param_01 == "walk" || param_01 == "run")
		{
			param_00 = "crouch";
		}
		else
		{
			param_00 = self.var_1491.var_D6A5;
		}
	}

	if(!isdefined(param_01) || param_01 == "")
	{
		param_01 = self.var_1491.var_BCC8;
	}

	[[ level.var_F805[param_00][param_01] ]]();
}

//Function Number: 2
func_98BF()
{
	level.var_F805["stand"]["stop"] = ::func_10B7E;
	level.var_F805["stand"]["walk"] = ::func_10B84;
	level.var_F805["stand"]["run"] = ::func_10B76;
	level.var_F805["crouch"]["stop"] = ::func_4AA7;
	level.var_F805["crouch"]["walk"] = ::func_4AB1;
	level.var_F805["crouch"]["run"] = ::func_4A9E;
	level.var_F805["prone"]["stop"] = ::func_DA86;
	level.var_F805["prone"]["walk"] = ::func_DA91;
	level.var_F805["prone"]["run"] = ::func_DA84;
}

//Function Number: 3
func_10B7E()
{
	switch(self.var_1491.var_D6A5)
	{
		case "stand":
			switch(self.var_1491.var_BCC8)
			{
				case "stop":
					return 0;
	
				case "walk":
					func_10B86();
					break;
	
				default:
					func_10B7D();
					break;
			}
			break;

		case "crouch":
			switch(self.var_1491.var_BCC8)
			{
				case "stop":
					func_4AAD();
					break;
	
				case "walk":
					func_4AB3();
					break;
	
				default:
					func_4AA6();
					break;
			}
			break;

		default:
			switch(self.var_1491.var_BCC8)
			{
				case "stop":
					func_DA8D();
					break;
	
				default:
					func_DA8D();
					break;
			}
			break;
	}

	return 1;
}

//Function Number: 4
func_10B84()
{
	switch(self.var_1491.var_D6A5)
	{
		case "stand":
			switch(self.var_1491.var_BCC8)
			{
				case "stop":
					func_2B92();
					break;
	
				case "walk":
					return 0;
	
				default:
					func_2B92();
					break;
			}
			break;

		case "crouch":
			switch(self.var_1491.var_BCC8)
			{
				case "stop":
					func_4AAF();
					break;
	
				case "walk":
					func_2B92();
					break;
	
				default:
					func_2B92();
					break;
			}
			break;

		default:
			func_DA8F();
			break;
	}

	return 1;
}

//Function Number: 5
func_10B76()
{
	switch(self.var_1491.var_D6A5)
	{
		case "stand":
			switch(self.var_1491.var_BCC8)
			{
				case "walk":
				case "stop":
					return func_2B91();
	
				default:
					return 0;
			}
			break;

		case "crouch":
			switch(self.var_1491.var_BCC8)
			{
				case "stop":
					return func_4AAE();
	
				default:
					return func_2B91();
			}
			break;

		default:
			func_DA8E();
			break;
	}

	return 1;
}

//Function Number: 6
func_4AA7()
{
	switch(self.var_1491.var_D6A5)
	{
		case "stand":
			switch(self.var_1491.var_BCC8)
			{
				case "stop":
					func_10B7F();
					break;
	
				case "walk":
					func_10B85();
					break;
	
				case "run":
					func_10B7C();
					break;
	
				default:
					break;
			}
			break;

		case "crouch":
			switch(self.var_1491.var_BCC8)
			{
				case "stop":
					break;
	
				case "walk":
					func_4AB2();
					break;
	
				case "run":
					func_4AA2();
					break;
	
				default:
					break;
			}
			break;

		case "prone":
			func_DA88();
			break;

		default:
			break;
	}
}

//Function Number: 7
func_4AB1()
{
	switch(self.var_1491.var_D6A5)
	{
		case "stand":
			switch(self.var_1491.var_BCC8)
			{
				case "stop":
					func_2B90();
					break;
	
				case "walk":
					func_2B90();
					break;
	
				default:
					func_2B90();
					break;
			}
			break;

		case "crouch":
			switch(self.var_1491.var_BCC8)
			{
				case "stop":
					func_4AA9();
					break;
	
				case "walk":
					return 0;
	
				default:
					func_2B90();
					break;
			}
			break;

		default:
			func_DA8A();
			break;
	}

	return 1;
}

//Function Number: 8
func_4A9E()
{
	switch(self.var_1491.var_D6A5)
	{
		case "stand":
			switch(self.var_1491.var_BCC8)
			{
				case "stop":
					func_2B8F();
					break;
	
				default:
					func_2B8F();
					break;
			}
			break;

		case "crouch":
			switch(self.var_1491.var_BCC8)
			{
				case "stop":
					func_4AA8();
					break;
	
				case "walk":
					func_2B8F();
					break;
	
				default:
					return 0;
			}
			break;

		default:
			func_DA89();
			break;
	}

	return 1;
}

//Function Number: 9
func_DA86()
{
	switch(self.var_1491.var_D6A5)
	{
		case "stand":
			switch(self.var_1491.var_BCC8)
			{
				case "stop":
					func_10B80();
					break;
	
				case "walk":
					func_10B80();
					break;
	
				case "run":
					func_4AA3();
					break;
	
				default:
					break;
			}
			break;

		case "crouch":
			switch(self.var_1491.var_BCC8)
			{
				case "stop":
					func_4AAA();
					break;
	
				case "walk":
					func_4AAA();
					break;
	
				case "run":
					func_4AA3();
					break;
	
				default:
					break;
			}
			break;

		case "prone":
			switch(self.var_1491.var_BCC8)
			{
				case "stop":
					break;
	
				case "run":
				case "walk":
					func_DA80();
					break;
	
				default:
					break;
			}
			break;

		default:
			break;
	}
}

//Function Number: 10
func_DA91()
{
	switch(self.var_1491.var_D6A5)
	{
		case "stand":
			switch(self.var_1491.var_BCC8)
			{
				case "stop":
					func_10B82();
					break;
	
				default:
					func_4AA5();
					break;
			}
			break;

		case "crouch":
			switch(self.var_1491.var_BCC8)
			{
				case "stop":
					func_4AAC();
					break;
	
				default:
					func_4AA5();
					break;
			}
			break;

		default:
			switch(self.var_1491.var_BCC8)
			{
				case "stop":
					func_DA8C();
					break;
	
				default:
					self.var_1491.var_BCC8 = "walk";
					return 0;
			}
			break;
	}

	return 1;
}

//Function Number: 11
func_DA84()
{
	switch(self.var_1491.var_D6A5)
	{
		case "stand":
			switch(self.var_1491.var_BCC8)
			{
				case "stop":
					func_10B81();
					break;
	
				default:
					func_4AA4();
					break;
			}
			break;

		case "crouch":
			switch(self.var_1491.var_BCC8)
			{
				case "stop":
					func_4AAB();
					break;
	
				default:
					func_4AA4();
					break;
			}
			break;

		default:
			switch(self.var_1491.var_BCC8)
			{
				case "stop":
					func_DA8C();
					break;
	
				default:
					self.var_1491.var_BCC8 = "run";
					return 0;
			}
			break;
	}

	return 1;
}

//Function Number: 12
func_CEED(param_00,param_01,param_02,param_03)
{
	var_04 = gettime() + param_01 * 1000;
	if(isarray(param_00))
	{
		param_00 = param_00[randomint(param_00.size)];
	}

	self method_82E3("blendTransition",param_00,%body,1,param_01,1);
	scripts\anim\notetracks::func_5931(param_01 / 2,"blendTransition");
	self.var_1491.var_D6A5 = param_02;
	self.var_1491.var_BCC8 = param_03;
	var_05 = var_04 - gettime() / 1000;
	if(var_05 < 0.05)
	{
		var_05 = 0.05;
	}

	scripts\anim\notetracks::func_5931(var_05,"blendTransition");
}

//Function Number: 13
func_D557(param_00,param_01)
{
	func_D554(param_00,"stand","walk",param_01);
}

//Function Number: 14
func_10B86()
{
	self.var_1491.var_BCC8 = "stop";
}

//Function Number: 15
func_10B85()
{
	func_10B86();
	func_10B7F();
}

//Function Number: 16
func_10B7D()
{
	self.var_1491.var_BCC8 = "stop";
}

//Function Number: 17
func_10B7C()
{
	self.var_1491.var_BCC8 = "stop";
	self.var_1491.var_D6A5 = "crouch";
}

//Function Number: 18
func_CEEE(param_00)
{
	var_01 = 0.3;
	if(self.var_1491.var_BCC8 != "stop")
	{
		self endon("movemode");
		var_01 = 1;
	}

	func_CEED(param_00,var_01,"stand","run");
}

//Function Number: 19
func_2B91()
{
	if(!self.var_12A)
	{
		self.var_1491.var_BCC8 = "run";
		self.var_1491.var_D6A5 = "stand";
		return 0;
	}

	if(isdefined(self.var_E80C))
	{
		func_CEEE(self.var_E80C);
		return 1;
	}

	var_00 = 0.1;
	if(self.var_1491.var_BCC8 != "stop" && self.var_2C0 == "none")
	{
		var_00 = 0.5;
	}

	if(isdefined(self.var_10AB7))
	{
		self method_82A9(scripts\anim\utility::func_7FCC("sprint"),1,var_00,1);
	}
	else
	{
		self method_82A9(scripts\anim\run::func_80FB(),1,var_00,1);
	}

	scripts\anim\run::func_F7A9(scripts\anim\utility::func_7FCC("move_b"),scripts\anim\utility::func_7FCC("move_l"),scripts\anim\utility::func_7FCC("move_r"),self.var_101BB);
	thread scripts\anim\run::func_F69A("run");
	wait(0.05);
	func_CEEE(%combatrun);
	return 1;
}

//Function Number: 20
func_2B92()
{
	if(self.var_1491.var_BCC8 != "stop")
	{
		self endon("movemode");
	}

	if(!isdefined(self.var_1D64) && self.var_1491.var_D6A5 != "prone")
	{
		scripts\anim\run::func_F7A9(scripts\anim\utility::func_7FCC("move_b"),scripts\anim\utility::func_7FCC("move_l"),scripts\anim\utility::func_7FCC("move_r"));
	}

	self.var_1491.var_D6A5 = "stand";
	self.var_1491.var_BCC8 = "walk";
}

//Function Number: 21
func_4AAD()
{
	var_00 = 1;
	if(isdefined(self.var_6B9F))
	{
		var_00 = 1.8;
		self.var_6B9F = undefined;
	}

	if(scripts\anim\utility_common::func_9FCA())
	{
		return;
	}

	scripts\anim\utility::func_DCB7();
}

//Function Number: 22
func_4AA9()
{
	func_2B90();
}

//Function Number: 23
func_4AAF()
{
	func_4AA9();
	func_2B92();
}

//Function Number: 24
func_4AB2()
{
	self.var_1491.var_BCC8 = "stop";
}

//Function Number: 25
func_4AB3()
{
	func_4AB2();
	func_4AAD();
}

//Function Number: 26
func_4AA2()
{
	self.var_1491.var_BCC8 = "stop";
}

//Function Number: 27
func_4AA6()
{
	func_4AA2();
	func_4AAD();
}

//Function Number: 28
func_4AA8()
{
	func_2B8F();
}

//Function Number: 29
func_4AAE()
{
	return func_2B91();
}

//Function Number: 30
func_2B8F()
{
	if(isdefined(self.var_4A9F))
	{
		func_CEED(self.var_4A9F,0.6,"crouch","run");
		return;
	}

	self method_82A4(%crouchrun,1,0.4,self.var_BCD6);
	thread scripts\anim\run::func_12ED3("crouchrun",scripts\anim\utility::func_7FCC("crouch"),scripts\anim\utility::func_7FCC("crouch_b"),scripts\anim\utility::func_7FCC("crouch_l"),scripts\anim\utility::func_7FCC("crouch_r"));
	wait(0.05);
}

//Function Number: 31
func_DA89()
{
	self method_8221("face current");
	scripts\anim\utility::func_697B(1);
	func_DA81(0.2);
	scripts\anim\cover_prone::func_12EF6(0.1);
}

//Function Number: 32
func_DA8E()
{
	func_DA89();
	func_2B91();
}

//Function Number: 33
func_DA8A()
{
	func_DA89();
	func_2B90();
}

//Function Number: 34
func_2B90()
{
	if(isdefined(self.var_4A9F))
	{
		self method_82A5(self.var_4A9F,%body,1,0.4);
		func_CEED(self.var_4A9F,0.6,"crouch","walk");
		self notify("BlendIntoCrouchWalk");
		return;
	}

	self method_82A4(%crouchrun,1,0.4,self.var_BCD6);
	thread scripts\anim\run::func_12ED3("crouchrun",scripts\anim\utility::func_7FCC("crouch"),scripts\anim\utility::func_7FCC("crouch_b"),scripts\anim\utility::func_7FCC("crouch_l"),scripts\anim\utility::func_7FCC("crouch_r"));
	wait(0.05);
}

//Function Number: 35
func_10B7F()
{
	scripts\anim\utility::func_DCB7();
	var_00 = 1;
	if(isdefined(self.var_6B99))
	{
		var_00 = 1.8;
		self.var_6B99 = undefined;
	}
}

//Function Number: 36
func_DA88()
{
	scripts\anim\utility::func_DCB7();
	self method_8221("face current");
	scripts\anim\utility::func_697B(1);
	func_DA81(0.1);
	scripts\anim\cover_prone::func_12EF6(0.1);
}

//Function Number: 37
func_DA8D()
{
	self method_8221("face current");
	scripts\anim\utility::func_697B(1);
	func_DA81(0.1);
	scripts\anim\cover_prone::func_12EF6(0.1);
}

//Function Number: 38
func_DA8F()
{
	func_DA88();
	func_4AA9();
	func_2B92();
}

//Function Number: 39
func_DA8B(param_00)
{
	func_DA81(0.1);
	scripts\anim\cover_prone::func_12EF6(0.1);
}

//Function Number: 40
func_DA8C()
{
	func_DA8B("run");
}

//Function Number: 41
func_DA80()
{
	func_DA81(0.1);
	scripts\anim\cover_prone::func_12EF6(0.1);
}

//Function Number: 42
func_4AAA()
{
}

//Function Number: 43
func_4AAC()
{
	func_4AAA();
	func_DA8C();
}

//Function Number: 44
func_4AAB()
{
	func_4AAA();
	func_DA8C();
}

//Function Number: 45
func_10B80()
{
}

//Function Number: 46
func_10B82()
{
	func_10B80();
	func_DA8C();
}

//Function Number: 47
func_10B81()
{
	func_10B80();
	func_DA8C();
}

//Function Number: 48
func_4AA3()
{
}

//Function Number: 49
func_4AA5()
{
	func_4AA3();
	func_DA8C();
}

//Function Number: 50
func_4AA4()
{
	func_4AA3();
	func_DA8C();
}

//Function Number: 51
func_D556(param_00,param_01,param_02,param_03,param_04)
{
	self endon("killanimscript");
	self endon("entered_pose" + param_01);
	func_D555(param_00,param_01,param_02,param_03,param_04,0);
}

//Function Number: 52
func_D554(param_00,param_01,param_02,param_03,param_04)
{
	func_D555(param_00,param_01,param_02,param_03,param_04,1);
}

//Function Number: 53
func_D555(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(!isdefined(param_04))
	{
		param_04 = 1;
	}

	if(param_05)
	{
		thread func_13712(getanimlength(param_00) / 2,"killtimerscript",param_01);
	}

	self method_82E4("transAnimDone2",param_00,%body,1,0.2,param_04);
	if(!isdefined(self.var_1491.var_D6A5))
	{
		self.var_D6A5 = "undefined";
	}

	if(!isdefined(self.var_1491.var_BCC8))
	{
		self.var_BCC8 = "undefined";
	}

	var_06 = "";
	scripts\anim\shared::func_592B("transAnimDone2",undefined,var_06);
	self notify("killtimerscript");
	self.var_1491.var_D6A5 = param_01;
	self notify("entered_pose" + param_01);
	self.var_1491.var_BCC8 = param_02;
	if(isdefined(param_03))
	{
		self method_82A5(param_03,%body,1,0.3,param_04);
	}
}

//Function Number: 54
func_13712(param_00,param_01,param_02)
{
	self endon("killanimscript");
	self endon("death");
	self endon(param_01);
	var_03 = self.var_1491.var_D6A5;
	wait(param_00);
	if(var_03 != "prone" && param_02 == "prone")
	{
		scripts\anim\cover_prone::func_12EF6(0.1);
		scripts\anim\utility::func_662A(1);
		return;
	}

	if(var_03 == "prone" && param_02 != "prone")
	{
		scripts\anim\utility::func_697B(1);
		self method_8221("face default");
	}
}

//Function Number: 55
func_DA81(param_00)
{
}