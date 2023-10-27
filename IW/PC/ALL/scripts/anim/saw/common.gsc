/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\anim\saw\common.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 13
 * Decompile Time: 584 ms
 * Timestamp: 10/26/2023 11:59:16 PM
*******************************************************************/

//Function Number: 1
main(param_00)
{
	self endon("killanimscript");
	if(!isdefined(param_00))
	{
		return;
	}

	self.var_1491.var_10930 = "saw";
	if(isdefined(param_00.var_ED50))
	{
		var_01 = param_00.var_ED50;
	}
	else
	{
		var_01 = scripts\sp\_mgturret::func_32B6("delay");
	}

	if(isdefined(param_00.var_ED4F))
	{
		var_02 = param_00.var_ED4F - var_01;
	}
	else
	{
		var_02 = scripts\sp\_mgturret::func_32B6("delay_range");
	}

	if(isdefined(param_00.var_ED26))
	{
		var_03 = param_00.var_ED26;
	}
	else
	{
		var_03 = scripts\sp\_mgturret::func_32B6("burst");
	}

	if(isdefined(param_00.var_ED25))
	{
		var_04 = param_00.var_ED25 - var_03;
	}
	else
	{
		var_04 = scripts\sp\_mgturret::func_32B6("burst_range");
	}

	var_05 = gettime();
	var_06 = "start";
	scripts\anim\shared::func_CC2C(self.var_394,"none");
	param_00 show();
	if(isdefined(param_00.var_1A56))
	{
		self.var_1491.var_D707 = ::func_D707;
		self.var_1491.var_13121 = param_00;
		param_00 notify("being_used");
		thread func_1109E();
	}
	else
	{
		self.var_1491.var_D707 = ::func_D860;
	}

	param_00.var_5855 = 0;
	thread func_6D63(param_00);
	self method_8355(self.var_D8E0);
	self method_82AB(self.var_D8E0,1,0.2,1);
	self method_82AA(self.var_17E3);
	self method_82AA(self.var_17E2);
	param_00 method_82AA(param_00.var_17E3);
	param_00 method_82AA(param_00.var_17E2);
	param_00 endon("death");
	for(;;)
	{
		if(param_00.var_5855)
		{
			thread func_5AAA(param_00);
			func_13848(randomfloatrange(var_03,var_03 + var_04),param_00);
			param_00 notify("turretstatechange");
			if(param_00.var_5855)
			{
				thread func_57DB(param_00);
				wait(randomfloatrange(var_01,var_01 + var_02));
			}

			continue;
		}

		thread func_57DB(param_00);
		param_00 waittill("turretstatechange");
	}
}

//Function Number: 2
func_13848(param_00,param_01)
{
	param_01 endon("turretstatechange");
	wait(param_00);
}

//Function Number: 3
func_6D63(param_00)
{
	self endon("killanimscript");
	var_01 = cos(15);
	for(;;)
	{
		while(isdefined(self.var_10C))
		{
			var_02 = self.var_10C.origin;
			var_03 = param_00 gettagangles("tag_aim");
			if(scripts\common\utility::func_13D90(param_00.origin,var_03,var_02,var_01) || distancesquared(param_00.origin,var_02) < -25536)
			{
				if(!param_00.var_5855)
				{
					param_00.var_5855 = 1;
					param_00 notify("turretstatechange");
				}
			}
			else if(param_00.var_5855)
			{
				param_00.var_5855 = 0;
				param_00 notify("turretstatechange");
			}

			wait(0.05);
		}

		if(param_00.var_5855)
		{
			param_00.var_5855 = 0;
			param_00 notify("turretstatechange");
		}

		wait(0.05);
	}
}

//Function Number: 4
func_12A99(param_00,param_01)
{
	if(param_00 <= 0)
	{
		return;
	}

	self endon("killanimscript");
	param_01 endon("turretstatechange");
	wait(param_00);
	param_01 notify("turretstatechange");
}

//Function Number: 5
func_1109E()
{
	self endon("killanimscript");
	for(;;)
	{
		if(!isdefined(self.var_205) || distancesquared(self.origin,self.var_205.origin) > 4096)
		{
			self method_83AF();
		}

		wait(0.25);
	}
}

//Function Number: 6
func_D707(param_00)
{
	if(param_00 == "pain")
	{
		if(isdefined(self.var_205) && distancesquared(self.origin,self.var_205.origin) < 4096)
		{
			self.var_1491.var_13121 hide();
			scripts\anim\shared::func_CC2C(self.var_394,"right");
			self.var_1491.var_D707 = ::func_D705;
			return;
		}
		else
		{
			self method_83AF();
		}
	}

	if(param_00 == "saw")
	{
		var_01 = self method_8164();
		return;
	}

	self.var_1491.var_13121 delete();
	self.var_1491.var_13121 = undefined;
	scripts\anim\shared::func_CC2C(self.var_394,"right");
}

//Function Number: 7
func_D705(param_00)
{
	if(!isdefined(self.var_205) || distancesquared(self.origin,self.var_205.origin) > 4096)
	{
		self method_83AF();
		self.var_1491.var_13121 delete();
		self.var_1491.var_13121 = undefined;
		if(isdefined(self.var_394) && self.var_394 != "none")
		{
			scripts\anim\shared::func_CC2C(self.var_394,"right");
			return;
		}

		return;
	}

	if(param_00 != "saw")
	{
		self.var_1491.var_13121 delete();
	}
}

//Function Number: 8
func_D860(param_00)
{
	scripts\anim\shared::func_CC2C(self.var_394,"right");
}

//Function Number: 9
func_5AAA(param_00)
{
}

//Function Number: 10
func_57DB(param_00)
{
}

//Function Number: 11
func_12A63(param_00)
{
}

//Function Number: 12
func_12A64()
{
}

//Function Number: 13
func_12A62()
{
}