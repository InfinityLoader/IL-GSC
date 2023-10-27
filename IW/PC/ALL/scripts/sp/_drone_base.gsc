/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: scripts\sp\_drone_base.gsc
 * Game: Call of Duty: Infinite Warfare
 * Platform: PC
 * Function Count: 6
 * Decompile Time: 254 ms
 * Timestamp: 10/27/2023 12:24:15 AM
*******************************************************************/

//Function Number: 1
func_5C21()
{
	func_23C7();
	self method_839E();
	if(isdefined(self.var_EE2C))
	{
		self.var_BCD6 = self.var_EE2C;
	}
	else
	{
		self.var_BCD6 = 1;
	}

	if(self.team == "allies")
	{
		scripts\sp\_names::func_7B05();
		self method_8307(self.name,&"");
	}

	if(isdefined(level.var_5CA7))
	{
		self thread [[ level.var_5CA7 ]]();
	}

	if(!isdefined(self.var_EDB7))
	{
		level thread scripts\sp\_friendlyfire::func_73B1(self);
	}

	if(!isdefined(level.var_193D))
	{
		func_1177B();
	}
}

//Function Number: 2
func_1177B()
{
	if(!isdefined(level.var_5CCB))
	{
		level.var_5CCB = "all";
	}

	var_00 = 0;
	switch(level.var_5CCB)
	{
		case "all":
			var_00 = 1;
			break;

		case "axis":
			var_00 = self.team == "axis";
			break;

		default:
			break;
	}

	if(var_00)
	{
		self method_83BC();
	}
}

//Function Number: 3
func_5C3A()
{
	if(!isdefined(self.target))
	{
		return;
	}

	if(isdefined(level.var_5C63[self.target]))
	{
		return;
	}

	level.var_5C63[self.target] = 1;
	var_00 = self.target;
	var_01 = scripts\common\utility::getstruct(var_00,"targetname");
	if(!isdefined(var_01))
	{
		return;
	}

	var_02 = [];
	var_03 = [];
	var_04 = var_01;
	for(;;)
	{
		var_01 = var_04;
		var_05 = 0;
		for(;;)
		{
			if(!isdefined(var_01.target))
			{
				break;
			}

			var_06 = scripts\common\utility::getstructarray(var_01.target,"targetname");
			if(var_06.size)
			{
				break;
			}

			var_07 = undefined;
			foreach(var_09 in var_06)
			{
				if(isdefined(var_03[var_09.origin + ""]))
				{
					continue;
				}

				var_07 = var_09;
				break;
			}

			if(!isdefined(var_07))
			{
				break;
			}

			var_03[var_07.origin + ""] = 1;
			var_02[var_01.var_336] = var_07.origin - var_01.origin;
			var_01.angles = vectortoangles(var_02[var_01.var_336]);
			var_01 = var_07;
			var_05 = 1;
		}

		if(!var_05)
		{
			break;
		}
	}

	var_00 = self.target;
	var_01 = scripts\common\utility::getstruct(var_00,"targetname");
	var_0B = var_01;
	var_03 = [];
	for(;;)
	{
		var_01 = var_04;
		var_05 = 0;
		for(;;)
		{
			if(!isdefined(var_01.target))
			{
				return;
			}

			if(!isdefined(var_02[var_01.var_336]))
			{
				return;
			}

			var_06 = scripts\common\utility::getstructarray(var_01.target,"targetname");
			if(var_06.size)
			{
				break;
			}

			var_07 = undefined;
			foreach(var_09 in var_06)
			{
				if(isdefined(var_03[var_09.origin + ""]))
				{
					continue;
				}

				var_07 = var_09;
				break;
			}

			if(!isdefined(var_07))
			{
				break;
			}

			if(isdefined(var_01.var_257))
			{
				var_0E = var_02[var_0B.var_336];
				var_0F = var_02[var_01.var_336];
				var_10 = var_0E + var_0F * 0.5;
				var_01.angles = vectortoangles(var_10);
			}

			var_05 = 1;
			var_0B = var_01;
			var_01 = var_07;
		}

		if(!var_05)
		{
			break;
		}
	}
}

//Function Number: 4
func_23C7()
{
	if(isdefined(self.type))
	{
		if(self.type == "dog")
		{
			func_23B5();
			return;
		}

		func_23C9();
	}
}

//Function Number: 5
func_23C9()
{
	self method_83D0(#animtree);
}

//Function Number: 6
func_23B5()
{
	self method_83D0(#animtree);
}