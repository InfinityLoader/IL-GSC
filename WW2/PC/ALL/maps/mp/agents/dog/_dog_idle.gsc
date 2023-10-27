/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\dog\_dog_idle.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 16
 * Decompile Time: 294 ms
 * Timestamp: 10/27/2023 3:08:30 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	self.var_EEA = "none";
	func_8745();
	self.var_99FF = self.var_99FF + 2000;
	self.var_173F = 0;
	self method_8395(self.var_116);
	self scragentsetorientmode("face angle abs",self.var_1D);
	self method_839C("anim deltas");
	self method_839D("gravity");
	func_A16C();
}

//Function Number: 2
func_0085()
{
	if(isdefined(self.var_76EA))
	{
		self method_839F(self.var_76EA);
		self.var_76EA = undefined;
	}
}

//Function Number: 3
func_A16C()
{
	self endon("killanimscript");
	self endon("cancelidleloop");
	for(;;)
	{
		var_00 = self.var_EEA;
		var_01 = func_2E61();
		if(var_01 != self.var_EEA)
		{
			func_37BF(var_01);
		}

		func_A0DE();
		switch(self.var_EEA)
		{
			case "idle_combat":
				wait(0.2);
				break;
	
			case "idle_noncombat":
				if(var_00 == "none")
				{
				}
				else if(gettime() > self.var_99FF)
				{
					func_8745();
				}
		
				wait(0.5);
				break;
	
			default:
				wait(1);
				break;
		}
	}
}

//Function Number: 4
func_2E61()
{
	if(func_8B86())
	{
		return "idle_combat";
	}

	return "idle_noncombat";
}

//Function Number: 5
func_37BF(param_00)
{
	func_38F6(self.var_EEA);
	self.var_EEA = param_00;
	func_74A8();
}

//Function Number: 6
func_38F6(param_00)
{
	if(isdefined(self.var_76EA))
	{
		self method_839F(self.var_76EA);
		self.var_76EA = undefined;
	}
}

//Function Number: 7
func_74A8()
{
	if(self.var_EEA == "idle_combat")
	{
		self method_83D7("attack_idle");
		return;
	}

	self method_83D7("casual_idle");
}

//Function Number: 8
func_A0DE()
{
	var_00 = undefined;
	if(isdefined(self.var_88) && distancesquared(self.var_88.var_116,self.var_116) < 1048576)
	{
		var_00 = self.var_88;
	}
	else if(isdefined(self.var_117) && distancesquared(self.var_117.var_116,self.var_116) > 576)
	{
		var_00 = self.var_117;
	}

	if(isdefined(var_00))
	{
		var_01 = var_00.var_116 - self.var_116;
		var_02 = vectortoangles(var_01);
		if(abs(angleclamp180(var_02[1] - self.var_1D[1])) > 1)
		{
			func_9ED9(var_02[1]);
		}
	}
}

//Function Number: 9
func_8B86()
{
	return isdefined(self.var_88) && maps\mp\_utility::func_57A0(self.var_88) && distancesquared(self.var_116,self.var_88.var_116) < 1000000;
}

//Function Number: 10
func_46F0(param_00)
{
	if(func_8B86())
	{
		if(param_00 < -135 || param_00 > 135)
		{
			return "attack_turn_180";
		}

		if(param_00 < 0)
		{
			return "attack_turn_right_90";
		}

		return "attack_turn_left_90";
	}

	if(param_00 < -135 || param_00 > 135)
	{
		return "casual_turn_180";
	}

	if(param_00 < 0)
	{
		return "casual_turn_right_90";
	}

	return "casual_turn_left_90";
}

//Function Number: 11
func_9ED9(param_00)
{
	var_01 = self.var_1D[1];
	var_02 = angleclamp180(param_00 - var_01);
	if(-0.5 < var_02 && var_02 < 0.5)
	{
		return;
	}

	if(-10 < var_02 && var_02 < 10)
	{
		func_7EEF(param_00,2);
		return;
	}

	var_03 = func_46F0(var_02);
	var_04 = self method_83D8(var_03,0);
	var_05 = getanimlength(var_04);
	var_06 = getangledelta3d(var_04);
	self method_839C("anim angle delta");
	if(animhasnotetrack(var_04,"turn_begin") && animhasnotetrack(var_04,"turn_end"))
	{
		maps/mp/agents/_scriptedagents::func_71FC(var_03,0,"turn_in_place");
		var_07 = getnotetracktimes(var_04,"turn_begin");
		var_08 = getnotetracktimes(var_04,"turn_end");
		var_09 = var_08[0] - var_07[0] * var_05;
		var_0A = angleclamp180(var_02 - var_06[1]);
		var_0B = abs(var_0A) / var_09 / 20;
		var_0B = var_0B * 3.14159 / 180;
		var_0C = (0,angleclamp180(self.var_1D[1] + var_0A),0);
		self.var_76EA = self method_83A0();
		self method_839F(var_0B);
		self scragentsetorientmode("face angle abs",var_0C);
		maps/mp/agents/_scriptedagents::func_A79E("turn_in_place","turn_end");
		self method_839F(self.var_76EA);
		self.var_76EA = undefined;
		maps/mp/agents/_scriptedagents::func_A79E("turn_in_place","end");
	}
	else
	{
		self.var_76EA = self method_83A0();
		var_0B = abs(angleclamp180(var_04 - var_0C[1])) / var_0B / 20;
		var_0C = var_0C * 3.14159 / 180;
		self method_839F(var_0C);
		var_0C = (0,angleclamp180(var_01 - var_0B[1]),0);
		self scragentsetorientmode("face angle abs",var_0C);
		maps/mp/agents/_scriptedagents::func_71FC(var_03,0,"turn_in_place");
		self method_839F(self.var_76EA);
		self.var_76EA = undefined;
	}

	self method_839C("anim deltas");
	func_74A8();
}

//Function Number: 12
func_7EEF(param_00,param_01)
{
	if(abs(angleclamp180(param_00 - self.var_1D[1])) <= param_01)
	{
		return;
	}

	var_02 = (0,param_00,0);
	self scragentsetorientmode("face angle abs",var_02);
	while(angleclamp180(param_00 - self.var_1D[1]) > param_01)
	{
		wait(0.1);
	}
}

//Function Number: 13
func_8745()
{
	self.var_99FF = gettime() + 8000 + randomint(5000);
}

//Function Number: 14
func_31FC(param_00)
{
	self.var_17E8 = 1;
	self.var_18F = 1;
	self.var_173F = 1;
	var_01 = angleclamp180(param_00 - self.var_1D[1]);
	if(var_01 > 0)
	{
		var_02 = 1;
	}
	else
	{
		var_02 = 0;
	}

	self notify("cancelidleloop");
	self method_839C("anim deltas");
	self scragentsetorientmode("face angle abs",self.var_1D);
	maps/mp/agents/_scriptedagents::func_71FC("stand_pain",var_02,"stand_pain");
	self.var_17E8 = 0;
	self.var_18F = 0;
	self.var_173F = 0;
	self scragentsetorientmode("face angle abs",self.var_1D);
	self.var_EEA = "none";
	thread func_A16C();
}

//Function Number: 15
func_6ADB(param_00,param_01,param_02,param_03,param_04,param_05,param_06,param_07,param_08,param_09)
{
	if(self.var_173F)
	{
		return;
	}

	var_0A = vectortoangles(param_07);
	var_0B = var_0A[1] - 180;
	func_31FC(var_0B);
}

//Function Number: 16
func_6B3B(param_00,param_01,param_02,param_03,param_04,param_05)
{
	if(self.var_173F)
	{
		return;
	}

	func_31FC(self.var_1D[1] + 180);
}