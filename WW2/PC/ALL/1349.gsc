/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: 1349.gsc
 * Game: Call of Duty: WWII
 * Platform: PC
 * Function Count: 17
 * Decompile Time: 21 ms
 * Timestamp: 10/27/2023 3:25:30 AM
*******************************************************************/

//Function Number: 1
func_00D5()
{
	if(!isdefined(level.var_954F))
	{
		level.var_954F = [];
	}

	if(!isdefined(level.var_954E))
	{
		level.var_954E = [];
	}

	if(!isdefined(level.var_9550))
	{
		level.var_9550 = [];
	}

	var_00 = common_scripts\utility::func_46B7("switch","targetname");
	common_scripts\utility::func_FB2(var_00,::func_955B);
}

//Function Number: 2
func_9557(param_00,param_01)
{
	level.var_954F[param_00] = param_01;
}

//Function Number: 3
func_9556(param_00,param_01)
{
	level.var_954E[param_00] = param_01;
}

//Function Number: 4
func_9558(param_00,param_01)
{
	level.var_9550[param_00] = param_01;
}

//Function Number: 5
func_955B()
{
	self.var_8BC8 = [];
	self.var_4CE1 = [];
	self.var_8BCC = [];
	self.var_4CE5 = [];
	var_00 = getentarray(self.var_1A2,"targetname");
	foreach(var_02 in var_00)
	{
		func_954A(var_02);
	}

	var_04 = common_scripts\utility::func_46B7(self.var_1A2,"targetname");
	foreach(var_06 in var_04)
	{
		func_955A(var_06);
	}

	common_scripts\utility::func_3799("needs_update");
	if(!common_scripts\utility::func_3C83(self.var_819A))
	{
		common_scripts\utility::func_3C87(self.var_819A);
	}

	waittillframeend;
	thread init_bumper_cars(self.var_819A);
	if(isdefined(self.var_81A1))
	{
		self.var_81A2 = strtok(self.var_81A1," ");
		foreach(var_09 in self.var_81A2)
		{
			thread init_bumper_cars(var_09);
		}
	}

	if(isdefined(self.var_819E))
	{
		self.var_819F = strtok(self.var_819E," ");
		foreach(var_09 in self.var_819F)
		{
			thread init_bumper_cars(var_09);
		}
	}

	thread func_9561();
	common_scripts\utility::func_379A("needs_update");
	for(;;)
	{
		common_scripts\utility::func_379C("needs_update");
		func_955F();
	}
}

//Function Number: 6
func_954A(param_00)
{
	var_01 = param_00.var_165;
	if(!isdefined(var_01))
	{
		switch(param_00.var_3A)
		{
			case "script_model":
				var_01 = "anim_model";
				break;

			case "trigger_use":
			case "trigger_use_touch":
				var_01 = "trigger";
				break;

			default:
				var_01 = "undefined";
				break;
		}
	}

	switch(var_01)
	{
		case "trigger":
			self.var_9D65 = param_00;
			param_00.var_9555 = self;
			break;

		case "anim_model":
			self.var_6298 = param_00;
			if(isdefined(self.var_6298.var_8109))
			{
				var_02 = strtok(self.var_6298.var_8109,",");
				self.var_6298.var_504F = var_02[0];
				self.var_6298.var_9E90 = var_02[1];
				self.var_6298.var_5051 = var_02[2];
				self.var_6298.var_9E87 = var_02[3];
			}
			break;

		case "show":
			self.var_8BF7[self.var_8BF7.size] = param_00;
			break;

		case "hide":
			self.var_4D07[self.var_4D07.size] = param_00;
			break;

		default:
			break;
	}
}

//Function Number: 7
func_955A(param_00)
{
	var_01 = param_00.var_165;
	switch(var_01)
	{
		case "indicator_light_on_fx":
			self.var_8BCC[self.var_8BCC.size] = param_00;
			func_954C(param_00);
			break;

		case "indicator_light_off_fx":
			self.var_4CE5[self.var_4CE5.size] = param_00;
			func_954C(param_00);
			break;
	}
}

//Function Number: 8
func_9561()
{
	if(!isdefined(self.var_9D65))
	{
		return;
	}

	for(;;)
	{
		self.var_9D65 waittill("trigger",var_00);
		if(func_9551())
		{
			if(func_9552())
			{
				if(func_9547())
				{
					common_scripts\utility::func_3C7B(self.var_819A);
					common_scripts\utility::func_379A("needs_update");
				}

				continue;
			}

			common_scripts\utility::func_3C8F(self.var_819A);
			common_scripts\utility::func_379A("needs_update");
		}
	}
}

//Function Number: 9
init_bumper_cars(param_00)
{
	for(;;)
	{
		common_scripts\utility::func_3C9F(param_00);
		common_scripts\utility::func_379A("needs_update");
		common_scripts\utility::func_3CA9(param_00);
		common_scripts\utility::func_379A("needs_update");
	}
}

//Function Number: 10
func_9551()
{
	return !isdefined(func_7AC7());
}

//Function Number: 11
func_7AC7()
{
	if(isdefined(self.var_81A2))
	{
		foreach(var_01 in self.var_81A2)
		{
			if(!common_scripts\utility::func_3C77(var_01))
			{
				return var_01;
			}
		}
	}

	if(isdefined(self.var_819F))
	{
		foreach(var_01 in self.var_819F)
		{
			if(common_scripts\utility::func_3C77(var_01))
			{
				return var_01;
			}
		}
	}

	return undefined;
}

//Function Number: 12
func_9552()
{
	return common_scripts\utility::func_3C77(self.var_819A);
}

//Function Number: 13
func_9547()
{
	return func_9551() && func_9552() && isdefined(level.var_954E[self.var_819A]);
}

//Function Number: 14
func_955F()
{
	if(isdefined(self.var_9D65))
	{
		if(func_9551())
		{
			if(func_9552())
			{
				var_00 = level.var_954E[self.var_819A];
			}
			else
			{
				var_00 = level.var_954F[self.var_819A];
			}
		}
		else if(!func_9552() || func_9547())
		{
			var_00 = level.var_9550[func_7AC7()];
		}
		else
		{
			var_00 = undefined;
		}

		if(isdefined(var_00))
		{
			self.var_9D65 sethintstring(var_00);
			self.var_9D65 makeusable();
		}
		else
		{
			self.var_9D65 makeunusable();
		}
	}

	if(func_9552())
	{
		foreach(var_02 in self.var_8BCC)
		{
			func_954D(var_02);
		}

		foreach(var_05 in self.var_8BC8)
		{
			var_05 method_805B();
		}

		foreach(var_02 in self.var_4CE5)
		{
			thread func_954B(var_02);
		}

		foreach(var_05 in self.var_4CE1)
		{
			var_05 method_805C();
		}
	}
	else
	{
		foreach(var_02 in self.var_4CE5)
		{
			func_954D(var_02);
		}

		foreach(var_05 in self.var_4CE1)
		{
			var_05 method_805B();
		}

		foreach(var_02 in self.var_8BCC)
		{
			thread func_954B(var_02);
		}

		foreach(var_05 in self.var_8BC8)
		{
			var_05 method_805C();
		}
	}

	if(isdefined(self.var_6298))
	{
		if(isdefined(self.var_9546) && self.var_9546 != func_9552())
		{
			if(func_9552())
			{
				var_13 = self.var_6298.var_9E90;
			}
			else
			{
				var_13 = self.var_6298.var_9E87;
			}

			if(isdefined(var_13))
			{
				self.var_6298 scriptmodelplayanim(var_13,"switch_transition_anim");
				self.var_6298 waittillmatch("end","switch_transition_anim");
			}

			self.var_9546 = undefined;
		}

		if(!isdefined(self.var_9546) || self.var_9546 != func_9552())
		{
			if(func_9552())
			{
				var_13 = self.var_6298.var_5051;
			}
			else
			{
				var_13 = self.var_6298.var_504F;
			}

			self.var_6298 scriptmodelplayanim(var_13);
			self.var_9546 = func_9552();
		}
	}

	common_scripts\utility::func_3796("needs_update");
}

//Function Number: 15
func_954C(param_00)
{
	if(!isdefined(level.var_611[param_00.var_81BB]))
	{
		level.var_611[param_00.var_81BB] = loadfx(param_00.var_81BB);
	}
}

//Function Number: 16
func_954D(param_00)
{
	if(isdefined(param_00.var_3F3F))
	{
		return;
	}

	if(isdefined(param_00.var_81C7))
	{
		param_00.var_5DA5 = spawn("script_model",param_00.var_116);
		param_00.var_5DA5.var_1D = param_00.var_1D;
		param_00.var_5DA5 setmodel("tag_origin");
		param_00.var_5DA5 linkto(self.var_6298,param_00.var_81C7);
		param_00.var_3F3F = spawnlinkedfx(common_scripts\utility::func_44F5(param_00.var_81BB),param_00.var_5DA5,"tag_origin");
	}
	else
	{
		param_00.var_3F3F = spawnfx(common_scripts\utility::func_44F5(param_00.var_81BB),param_00.var_116,anglestoforward(param_00.var_1D),anglestoup(param_00.var_1D));
	}

	if(gettime() < 500)
	{
		triggerfx(param_00.var_3F3F,0.5);
		return;
	}

	triggerfx(param_00.var_3F3F);
}

//Function Number: 17
func_954B(param_00)
{
	wait 0.05;
	if(isdefined(param_00.var_5DA5))
	{
		param_00.var_5DA5 delete();
	}

	if(isdefined(param_00.var_3F3F))
	{
		param_00.var_3F3F delete();
	}
}