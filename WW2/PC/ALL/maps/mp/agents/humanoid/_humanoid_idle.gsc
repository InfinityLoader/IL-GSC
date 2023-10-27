/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\mp\agents\humanoid\_humanoid_idle.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 12
 * Decompile Time: 211 ms
 * Timestamp: 10/27/2023 3:08:38 AM
*******************************************************************/

//Function Number: 1
func_00F9()
{
	self.var_EEA = "none";
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
	self endon("UpdateState");
	wait(0);
	for(;;)
	{
		var_00 = func_2E61();
		if(var_00 != self.var_EEA)
		{
			func_38F6(self.var_EEA);
			func_37BF(var_00);
		}

		func_A0DE();
		switch(self.var_EEA)
		{
			case "idle_combat":
				wait(0.2);
				break;
	
			case "idle_noncombat":
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
	if(isdefined(self.var_505A))
	{
		return [[ self.var_505A ]]();
	}

	if(func_8B86())
	{
		return "idle_combat";
	}

	return "idle_noncombat";
}

//Function Number: 5
func_37BF(param_00)
{
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
	maps/mp/agents/_scripted_agent_anim_util::func_8410(self.var_EEA);
}

//Function Number: 8
func_A0DE()
{
	var_00 = undefined;
	if(isdefined(self.var_9831) && distancesquared(self.var_9831.var_116,self.var_116) < 262144)
	{
		var_00 = self.var_9831;
	}
	else if(isdefined(self.var_3043) && distancesquared(self.var_3043.var_4883,self.var_116) < 16384)
	{
		var_00 = self.var_3043;
	}
	else if(isdefined(self.var_88) && distancesquared(self.var_88.var_116,self.var_116) < 1048576)
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
	if(!isdefined(self.var_88))
	{
		return 0;
	}

	if(!maps\mp\_utility::func_57A0(self.var_88))
	{
		return 0;
	}

	if(distancesquared(self.var_116,self.var_88.var_116) >= 1000000)
	{
		return 0;
	}

	return 1;
}

//Function Number: 10
func_46F0(param_00)
{
	var_01 = "idle_noncombat_turn";
	if(func_8B86())
	{
		var_01 = "idle_combat_turn";
	}

	var_02 = maps/mp/agents/_scripted_agent_anim_util::func_434D(var_01);
	var_03 = self method_83DB(var_02);
	var_04 = 0;
	if(var_03 == 3)
	{
		if(param_00 < -135 || param_00 > 135)
		{
			var_04 = 0;
		}
		else if(param_00 < 0)
		{
			var_04 = 1;
		}
		else
		{
			var_04 = 2;
		}
	}

	return [var_02,var_04];
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
	var_04 = var_03[0];
	var_05 = var_03[1];
	var_06 = self method_83D8(var_04,var_05);
	var_07 = getanimlength(var_06);
	var_08 = getangledelta3d(var_06);
	self method_839C("anim angle delta");
	if(animhasnotetrack(var_06,"turn_begin") && animhasnotetrack(var_06,"turn_end"))
	{
		maps/mp/agents/_scripted_agent_anim_util::func_71FA(var_04,var_05,self.var_4013,"turn_in_place");
		var_09 = getnotetracktimes(var_06,"turn_begin");
		var_0A = getnotetracktimes(var_06,"turn_end");
		var_0B = var_0A[0] - var_09[0] * var_07;
		var_0C = angleclamp180(var_02 - var_08[1]);
		var_0D = abs(var_0C) / var_0B / 20;
		var_0D = var_0D * 3.14159 / 180;
		var_0E = (0,angleclamp180(self.var_1D[1] + var_0C),0);
		self.var_76EA = self method_83A0();
		self method_839F(var_0D);
		self scragentsetorientmode("face angle abs",var_0E);
		var_07 = getanimlength(self method_83D8(var_04,var_05));
		maps/mp/agents/_scripted_agent_anim_util::func_A79F("turn_in_place","turn_end",var_07);
		self method_839F(self.var_76EA);
		self.var_76EA = undefined;
		maps/mp/agents/_scripted_agent_anim_util::func_A79F("turn_in_place","end",var_07);
	}
	else
	{
		self.var_76EA = self method_83A0();
		var_0D = abs(angleclamp180(var_04 - var_0E[1])) / var_0D / 20;
		var_0E = var_0E * 3.14159 / 180;
		self method_839F(var_0E);
		var_0E = (0,angleclamp180(var_01 - var_0D[1]),0);
		self scragentsetorientmode("face angle abs",var_0E);
		maps/mp/agents/_scripted_agent_anim_util::func_71FA(var_04,var_05,self.var_4013,"turn_in_place");
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