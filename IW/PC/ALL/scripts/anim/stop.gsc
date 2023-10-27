/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\stop.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 11
 * Decompile Time: 558 ms
 * Timestamp: 10/27/2023 12:01:05 AM
*******************************************************************/

//Function Number: 1
func_9518()
{
}

//Function Number: 2
main()
{
	if(isdefined(self.var_BFDC))
	{
		return;
	}

	if(isdefined(self.var_4C37))
	{
		if(isdefined(self.var_4C37["stop"]))
		{
			[[ self.var_4C37["stop"] ]]();
			return;
		}
	}

	self notify("stopScript");
	self endon("killanimscript");
	[[ self.var_68C6["stop_immediate"] ]]();
	thread func_50FE();
	scripts\anim\utility::func_9832("stop");
	if(isdefined(self.var_1095A))
	{
		func_1095B();
	}

	scripts\anim\utility::func_DCB7();
	thread func_F77E();
	thread scripts\anim\reactions::func_DD51();
	var_00 = isdefined(self.var_4C8C);
	if(!var_00)
	{
		if(self.var_1491.var_13CBA["right"] == "none" && self.var_1491.var_13CBA["left"] == "none")
		{
			var_00 = 1;
		}
		else if(angleclamp180(self method_8141()[0]) > 20)
		{
			var_00 = 1;
		}
	}

	for(;;)
	{
		var_01 = func_7E6F();
		if(var_01 == "prone")
		{
			var_00 = 1;
			func_DA85();
			continue;
		}

		if(self.var_1491.var_D6A5 != var_01)
		{
			self method_806F(%root,0.3);
			var_00 = 0;
		}

		scripts\anim\setposemovement::func_F804(var_01,"stop");
		if(!var_00)
		{
			func_12681(var_01,self.var_1491.var_92F9);
			var_00 = 1;
			continue;
		}

		func_D49C(var_01,self.var_1491.var_92F9);
	}
}

//Function Number: 3
func_E732(param_00,param_01)
{
	self method_8221("face angle",param_00);
	while(angleclamp(param_00 - self.angles[1]) > param_01)
	{
		wait(0.1);
	}
}

//Function Number: 4
func_F77E()
{
	self endon("death");
	self waittill("killanimscript");
	self.var_AA1F = gettime();
}

//Function Number: 5
func_1095B()
{
	self endon("stop_specialidle");
	var_00 = self.var_1095A;
	self method_8016("gravity");
	self method_8221("face current");
	self method_806F(%root,0.2);
	for(;;)
	{
		self method_82EA("special_idle",var_00[randomint(var_00.size)],1,0.2,self.var_1FC6);
		self waittillmatch("end","special_idle");
	}
}

//Function Number: 6
func_7E6F()
{
	var_00 = scripts\anim\utility_common::func_7E28();
	if(isdefined(var_00))
	{
		var_01 = var_00.angles[1];
		var_02 = var_00.type;
	}
	else
	{
		var_01 = self.var_EC;
		var_02 = "node was undefined";
	}

	var_03 = scripts\anim\utility::func_3EF2();
	if(var_02 == "Cover Stand" || var_02 == "Conceal Stand")
	{
		var_03 = scripts\anim\utility::func_3EF2("stand");
	}
	else if(var_02 == "Cover Crouch" || var_02 == "Conceal Crouch")
	{
		var_03 = scripts\anim\utility::func_3EF2("crouch");
	}
	else if(var_02 == "Cover Prone" || var_02 == "Conceal Prone")
	{
		var_03 = scripts\anim\utility::func_3EF2("prone");
	}

	return var_03;
}

//Function Number: 7
func_12681(param_00,param_01)
{
	if(scripts\anim\utility::func_9D9B() && self.var_1491.var_D6A5 == "stand")
	{
		param_00 = "stand_cqb";
	}

	var_02 = scripts\anim\utility::func_B028("idle_transitions");
	if(isdefined(var_02[param_00]))
	{
		var_03 = var_02[param_00];
		self method_82E4("idle_transition",var_03,%body,1,0.2,self.var_1FC6);
		scripts\anim\shared::func_592B("idle_transition");
	}
}

//Function Number: 8
func_D49C(param_00,param_01)
{
	if(scripts\anim\utility::func_9D9B() && self.var_1491.var_D6A5 == "stand")
	{
		param_00 = "stand_cqb";
	}

	var_02 = undefined;
	if(isdefined(self.var_4C8C) && isdefined(self.var_4C8C[param_00]))
	{
		if(isarray(self.var_4C8C[param_00]))
		{
			var_03 = scripts\anim\utility::func_1E9D(self.var_4C8C[param_00],self.var_4C8D[param_00]);
		}
		else
		{
			var_03 = self.var_4C8C[param_01];
			var_04 = param_00 + "_add";
			if(isdefined(self.var_4C8C[var_04]))
			{
				var_02 = self.var_4C8C[var_04];
			}
		}
	}
	else if(isdefined(level.var_DD76) && param_01 == "stand" || param_01 == "stand_cqb" && isdefined(self.var_32D4) && self.var_32D4 == 1)
	{
		var_03 = scripts\anim\utility::func_1E9D(level.var_DD76["stand"][0],level.var_DD77["stand"][0]);
	}
	else
	{
		var_05 = scripts\anim\utility::func_B028("idle");
		var_06 = scripts\anim\utility::func_B028("idle_weights");
		param_01 = param_01 % var_05[param_00].size;
		var_03 = scripts\anim\utility::func_1E9D(var_05[param_00][param_01],var_06[param_00][param_01]);
	}

	var_07 = 0.2;
	if(gettime() == self.var_1491.var_EF87)
	{
		var_07 = 0.5;
	}

	if(isdefined(var_02))
	{
		self method_82A5(var_03,%body,1,var_07,1);
		self method_82A2(%add_idle);
		self method_82E4("idle",var_02,%add_idle,1,var_07,self.var_1FC6);
	}
	else
	{
		self method_82E4("idle",var_03,%body,1,var_07,self.var_1FC6);
	}

	scripts\anim\shared::func_592B("idle");
}

//Function Number: 9
func_DA85()
{
	if(self.var_1491.var_D6A5 != "prone")
	{
		return;
	}

	thread func_12EF5();
	if(randomint(10) < 3)
	{
		var_00 = scripts\anim\utility::func_B027("cover_prone","twitch");
		var_01 = var_00[randomint(var_00.size)];
		self method_82E3("prone_idle",var_01,%exposed_modern,1,0.2);
	}
	else
	{
		self method_82A5(scripts\anim\utility::func_B027("cover_prone","straight_level"),%exposed_modern,1,0.2);
		self method_82E2("prone_idle",scripts\anim\utility::func_B027("cover_prone","exposed_idle")[0],1,0.2);
	}

	self waittillmatch("end","prone_idle");
	self notify("kill UpdateProneThread");
}

//Function Number: 10
func_12EF5()
{
	self endon("killanimscript");
	self endon("kill UpdateProneThread");
	for(;;)
	{
		scripts\anim\cover_prone::func_12EF6(0.1);
		wait(0.1);
	}
}

//Function Number: 11
func_50FE()
{
	self endon("killanimscript");
	wait(0.05);
	[[ self.var_68C6["stop"] ]]();
}