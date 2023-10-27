/*******************************************************************
 * Decompiled By: Bog
 * Decompiled File: maps\_lights.gsc
 * Game: Call of Duty: Ghosts
 * Platform: Console
 * Function Count: 39
 * Decompile Time: 500 ms
 * Timestamp: 10/27/2023 1:37:12 AM
*******************************************************************/

//Function Number: 1
func_44DF()
{
	var_00 = getentarray("generic_flickering","targetname");
	var_01 = getentarray("generic_pulsing","targetname");
	var_02 = getentarray("generic_double_strobe","targetname");
	var_03 = getentarray("burning_trash_fire","targetname");
	var_04 = getentarray("scripted_light","targetname");
	common_scripts\utility::func_F1B(var_00,::func_378C);
	common_scripts\utility::func_F1B(var_01,::func_379B);
	common_scripts\utility::func_F1B(var_02,::generic_double_strobe);
	common_scripts\utility::func_F1B(var_03,::func_18AD);
	common_scripts\utility::func_F1B(var_04,::init_scripted_light);
}

//Function Number: 2
func_480E(param_00)
{
	return param_00.classname == "light_spot" || param_00.classname == "light_omni" || param_00.classname == "light";
}

//Function Number: 3
func_3424(param_00,param_01,param_02,param_03)
{
	self endon("kill_flicker");
	var_04 = param_00;
	var_05 = 0;
	maps\_utility::func_2F47("stop_flicker");
	for(;;)
	{
		if(maps\_utility::ent_flag("stop_flicker"))
		{
			wait(0.05);
			continue;
		}

		var_06 = var_04;
		var_04 = param_00 + param_01 - param_00 * randomfloat(1);
		if(param_02 != param_03)
		{
			var_05 = var_05 + randomfloatrange(param_02,param_03);
		}
		else
		{
			var_05 = var_05 + param_02;
		}

		if(var_05 == 0)
		{
			var_05 = var_05 + 1E-07;
		}

		var_07 = var_06 - var_04 * 1 / var_05;
		while(var_05 > 0 && !maps\_utility::ent_flag("stop_flicker"))
		{
			self method_8313(var_04 + var_07 * var_05);
			wait(0.05);
			var_05 = var_05 - 0.05;
		}
	}
}

//Function Number: 4
func_4AD5(param_00)
{
	var_01 = getentarray(param_00,"script_noteworthy");
	var_02 = undefined;
	var_03 = 1E+08;
	foreach(var_05 in var_01)
	{
		var_06 = distance(self.origin,var_05.origin);
		if(var_06 < var_03)
		{
			var_02 = var_05;
			var_03 = var_06;
		}
	}

	if(isdefined(var_02))
	{
		var_02 waittill("damage",var_08,var_09,var_0A,var_0B,var_0C,var_0D,var_0E);
		self notify("kill_flicker");
		wait(0.05);
		self method_8313((0,0,0));
	}
}

//Function Number: 5
func_379B()
{
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		self setlightintensity(0);
	}

	var_00 = self getlightintensity();
	var_01 = 0.05;
	var_02 = var_00;
	var_03 = 0.3;
	var_04 = 0.6;
	var_05 = var_00 - var_01 / var_03 / 0.05;
	var_06 = var_00 - var_01 / var_04 / 0.05;
	for(;;)
	{
		var_07 = 0;
		while(var_07 < var_04)
		{
			var_02 = var_02 - var_06;
			var_02 = clamp(var_02,0,100);
			self setlightintensity(var_02);
			var_07 = var_07 + 0.05;
			wait(0.05);
		}

		wait(1);
		var_07 = 0;
		while(var_07 < var_03)
		{
			var_02 = var_02 + var_05;
			var_02 = clamp(var_02,0,100);
			self setlightintensity(var_02);
			var_07 = var_07 + 0.05;
			wait(0.05);
		}

		wait(0.5);
	}
}

//Function Number: 6
generic_double_strobe()
{
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		self setlightintensity(0);
	}

	var_00 = self getlightintensity();
	var_01 = 0.05;
	var_02 = 0;
	var_03 = undefined;
	var_04 = undefined;
	var_05 = 0;
	var_06 = [];
	if(isdefined(self.script_noteworthy))
	{
		var_07 = getentarray(self.script_noteworthy,"targetname");
		for(var_08 = 0;var_08 < var_07.size;var_08++)
		{
			if(func_480E(var_07[var_08]))
			{
				var_05 = 1;
				var_06[var_06.size] = var_07[var_08];
			}

			if(var_07[var_08].classname == "script_model")
			{
				var_03 = var_07[var_08];
				var_04 = getent(var_03.target,"targetname");
				var_02 = 1;
			}
		}
	}

	for(;;)
	{
		self setlightintensity(var_01);
		if(var_02)
		{
			var_03 hide();
			var_04 show();
		}

		wait(0.8);
		self setlightintensity(var_00);
		if(var_02)
		{
			var_03 show();
			var_04 hide();
		}

		wait(0.1);
		self setlightintensity(var_01);
		if(var_02)
		{
			var_03 hide();
			var_04 show();
		}

		wait(0.12);
		self setlightintensity(var_00);
		if(var_02)
		{
			var_03 show();
			var_04 hide();
		}

		wait(0.1);
	}
}

//Function Number: 7
getclosests_flickering_model(param_00)
{
	var_01 = getentarray("light_flicker_model","targetname");
	var_02 = [];
	var_03 = common_scripts\utility::func_3A56(param_00,var_01);
	if(isdefined(var_03))
	{
		var_02[0] = var_03;
	}

	return var_02;
}

//Function Number: 8
func_378C()
{
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		self setlightintensity(0);
	}

	self endon("stop_dynamic_light_behavior");
	self endon("death");
	self.var_4E38 = 0;
	self.lit_models = undefined;
	self.var_85B0 = undefined;
	self.var_4E37 = 0;
	self.var_4E36 = [];
	self.linked_prefab_ents = undefined;
	self.var_4E3A = [];
	if(isdefined(self.script_linkto))
	{
		self.linked_prefab_ents = common_scripts\utility::get_linked_ents();
		foreach(var_01 in self.linked_prefab_ents)
		{
			if(isdefined(var_01.script_noteworthy) && var_01.script_noteworthy == "on")
			{
				if(!isdefined(self.lit_models))
				{
					self.lit_models[0] = var_01;
				}
				else
				{
					self.lit_models[self.lit_models.size] = var_01;
				}

				continue;
			}

			if(isdefined(var_01.script_noteworthy) && var_01.script_noteworthy == "off")
			{
				if(!isdefined(self.var_85B0))
				{
					self.var_85B0[0] = var_01;
				}
				else
				{
					self.var_85B0[self.var_85B0.size] = var_01;
				}

				self.var_85AF = var_01;
				continue;
			}

			if(func_480E(var_01))
			{
				self.var_4E37 = 1;
				self.var_4E36[self.var_4E36.size] = var_01;
			}
		}

		self.var_4E38 = 1;
	}

	if(isdefined(self.script_noteworthy))
	{
		self.var_4E3A = getentarray(self.script_noteworthy,"targetname");
	}

	if(!self.var_4E3A.size && !isdefined(self.linked_prefab_ents))
	{
		self.var_4E3A = getclosests_flickering_model(self.origin);
	}

	for(var_03 = 0;var_03 < self.var_4E3A.size;var_03++)
	{
		if(func_480E(self.var_4E3A[var_03]))
		{
			self.var_4E37 = 1;
			self.var_4E36[self.var_4E36.size] = self.var_4E3A[var_03];
		}

		if(self.var_4E3A[var_03].classname == "script_model")
		{
			var_04 = self.var_4E3A[var_03];
			if(!isdefined(self.lit_models))
			{
				self.lit_models[0] = var_04;
			}
			else
			{
				self.lit_models[self.lit_models.size] = var_04;
			}

			if(!isdefined(self.var_85B0))
			{
				self.var_85B0[0] = getent(var_04.target,"targetname");
			}
			else
			{
				self.var_85B0[self.var_85B0.size] = getent(var_04.target,"targetname");
			}

			self.var_4E38 = 1;
		}
	}

	if(isdefined(self.lit_models))
	{
		foreach(var_04 in self.lit_models)
		{
			if(isdefined(var_04) && isdefined(var_04.script_fxid))
			{
				var_04.effect = common_scripts\utility::createoneshoteffect(var_04.script_fxid);
				var_06 = (0,0,0);
				var_07 = (0,0,0);
				if(isdefined(var_04.script_parameters))
				{
					var_08 = strtok(var_04.script_parameters,", ");
					if(var_08.size < 3)
					{
					}
					else if(var_08.size == 6)
					{
						var_09 = castfloat(var_08[0]);
						var_0A = castfloat(var_08[1]);
						var_0B = castfloat(var_08[2]);
						var_06 = (var_09,var_0A,var_0B);
						var_09 = castfloat(var_08[3]);
						var_0A = castfloat(var_08[4]);
						var_0B = castfloat(var_08[5]);
						var_07 = (var_09,var_0A,var_0B);
					}
					else
					{
						var_09 = castfloat(var_0B[0]);
						var_0A = castfloat(var_0A[1]);
						var_0B = castfloat(var_09[2]);
						var_06 = (var_09,var_0A,var_0B);
					}
				}

				var_04.effect.var_880E["origin"] = var_04.origin + var_06;
				var_04.effect.var_880E["angles"] = var_04.angles + var_07;
			}
		}
	}

	thread func_378A();
	thread generic_flicker();
}

//Function Number: 9
func_378A()
{
	maps\_utility::func_2F47("flicker_on");
	if(isdefined(self.var_6C0F) && self.var_6C0F != "nil")
	{
		for(;;)
		{
			level waittill(self.var_6C0F);
			maps\_utility::func_2F48("flicker_on");
			if(isdefined(self.var_6C10) && self.var_6C10 != "nil")
			{
				level waittill(self.var_6C10);
				maps\_utility::func_2F44("flicker_on");
			}
		}
	}

	maps\_utility::func_2F48("flicker_on");
}

//Function Number: 10
func_378B()
{
	var_00 = self getlightintensity();
	if(!maps\_utility::ent_flag("flicker_on"))
	{
		if(self.var_4E38)
		{
			if(isdefined(self.lit_models))
			{
				foreach(var_02 in self.lit_models)
				{
					var_02 hide();
					if(isdefined(var_02.effect))
					{
						var_02.effect common_scripts\utility::func_5B59();
					}
				}
			}

			if(isdefined(self.var_85B0))
			{
				foreach(var_05 in self.var_85B0)
				{
					var_05 show();
				}
			}
		}

		self setlightintensity(0);
		if(self.var_4E37)
		{
			for(var_07 = 0;var_07 < self.var_4E36.size;var_07++)
			{
				self.var_4E36[var_07] setlightintensity(0);
			}
		}

		maps\_utility::ent_flag_wait("flicker_on");
		self setlightintensity(var_00);
		if(self.var_4E37)
		{
			for(var_07 = 0;var_07 < self.var_4E36.size;var_07++)
			{
				self.var_4E36[var_07] setlightintensity(var_00);
			}
		}

		if(self.var_4E38)
		{
			if(isdefined(self.lit_models))
			{
				foreach(var_02 in self.lit_models)
				{
					var_02 show();
					if(isdefined(var_02.effect))
					{
						var_02.effect maps\_utility::func_6643();
					}
				}
			}

			if(isdefined(self.var_85B0))
			{
				foreach(var_05 in self.var_85B0)
				{
					var_05 hide();
				}
			}
		}
	}
}

//Function Number: 11
generic_flicker()
{
	self endon("stop_dynamic_light_behavior");
	self endon("death");
	var_00 = 0.2;
	var_01 = 1.5;
	var_02 = self getlightintensity();
	var_03 = 0;
	var_04 = var_02;
	var_05 = 0;
	while(isdefined(self))
	{
		func_378B();
		for(var_05 = randomintrange(1,10);var_05;var_05--)
		{
			func_378B();
			wait(randomfloatrange(0.05,0.1));
			if(var_04 > 0.2)
			{
				var_04 = randomfloatrange(0,0.3);
				if(self.var_4E38)
				{
					foreach(var_07 in self.lit_models)
					{
						var_07 hide();
						if(isdefined(var_07.effect))
						{
							var_07.effect common_scripts\utility::func_5B59();
						}
					}
				}

				if(isdefined(self.var_85B0))
				{
					foreach(var_0A in self.var_85B0)
					{
						var_0A show();
					}
				}
			}
			else
			{
				var_04 = var_02;
				if(self.var_4E38)
				{
					if(isdefined(self.lit_models))
					{
						foreach(var_07 in self.lit_models)
						{
							var_07 show();
							if(isdefined(var_07.effect))
							{
								var_07.effect maps\_utility::func_6643();
							}
						}
					}

					if(isdefined(self.var_85B0))
					{
						foreach(var_0A in self.var_85B0)
						{
							var_0A hide();
						}
					}
				}
			}

			self setlightintensity(var_04);
			if(self.var_4E37)
			{
				for(var_10 = 0;var_10 < self.var_4E36.size;var_10++)
				{
					self.var_4E36[var_10] setlightintensity(var_04);
				}
			}
		}

		func_378B();
		self setlightintensity(var_02);
		if(self.var_4E37)
		{
			for(var_10 = 0;var_10 < self.var_4E36.size;var_10++)
			{
				self.var_4E36[var_10] setlightintensity(var_02);
			}
		}

		if(self.var_4E38)
		{
			if(isdefined(self.lit_models))
			{
				foreach(var_07 in self.lit_models)
				{
					var_07 show();
					if(isdefined(var_07.effect))
					{
						var_07.effect maps\_utility::func_6643();
					}
				}
			}

			if(isdefined(self.var_85B0))
			{
				foreach(var_0A in self.var_85B0)
				{
					var_0A hide();
				}
			}
		}

		wait(randomfloatrange(var_00,var_01));
	}
}

//Function Number: 12
func_379F()
{
	level common_scripts\utility::func_8AFE();
}

//Function Number: 13
func_3425(param_00,param_01)
{
	var_02 = self getlightintensity();
	var_03 = 0;
	var_04 = var_02;
	var_05 = 0;
	for(;;)
	{
		for(var_05 = randomintrange(1,10);var_05;var_05--)
		{
			wait(randomfloatrange(0.05,0.1));
			if(var_04 > 0.2)
			{
				var_04 = randomfloatrange(0,0.3);
			}
			else
			{
				var_04 = var_02;
			}

			self setlightintensity(var_04);
		}

		self setlightintensity(var_02);
		wait(randomfloatrange(param_00,param_01));
	}
}

//Function Number: 14
func_18AD()
{
	if(getdvar("r_reflectionProbeGenerate") == "1")
	{
		self setlightintensity(0);
	}

	var_00 = self getlightintensity();
	var_01 = var_00;
	for(;;)
	{
		var_02 = randomfloatrange(var_00 * 0.7,var_00 * 1.2);
		var_03 = randomfloatrange(0.3,0.6);
		var_03 = var_03 * 20;
		for(var_04 = 0;var_04 < var_03;var_04++)
		{
			var_05 = var_02 * var_04 / var_03 + var_01 * var_03 - var_04 / var_03;
			self setlightintensity(var_05);
			wait(0.05);
		}

		var_01 = var_02;
	}
}

//Function Number: 15
strobelight(param_00,param_01,param_02,param_03)
{
	var_04 = 360 / param_02;
	var_05 = 0;
	for(;;)
	{
		var_06 = sin(var_05 * var_04) * 0.5 + 0.5;
		self setlightintensity(param_00 + param_01 - param_00 * var_06);
		wait(0.05);
		var_05 = var_05 + 0.05;
		if(var_05 > param_02)
		{
			var_05 = var_05 - param_02;
		}

		if(isdefined(param_03))
		{
			if(common_scripts\utility::flag(param_03))
			{
			}
		}
	}
}

//Function Number: 16
func_1ADD(param_00,param_01,param_02,param_03)
{
	if(!isdefined(param_02))
	{
		param_02 = 0;
	}

	if(!isdefined(param_03))
	{
		param_03 = 0;
	}

	thread changelightcolortoworkerthread(param_00,param_01,param_02,param_03);
}

//Function Number: 17
changelightcolortoworkerthread(param_00,param_01,param_02,param_03)
{
	var_04 = self method_8312();
	var_05 = 1 / param_01 * 2 - param_02 + param_03;
	var_06 = 0;
	if(var_06 < param_02)
	{
		var_07 = var_05 / param_02;
		while(var_06 < param_02)
		{
			var_08 = var_07 * var_06 * var_06;
			self method_8313(vectorlerp(var_04,param_00,var_08));
			wait(0.05);
			var_06 = var_06 + 0.05;
		}
	}

	while(var_06 < param_01 - param_03)
	{
		var_08 = var_05 * 2 * var_06 - param_02;
		self method_8313(vectorlerp(var_04,param_00,var_08));
		wait(0.05);
		var_06 = var_06 + 0.05;
	}

	var_06 = param_01 - var_06;
	if(var_06 > 0)
	{
		var_07 = var_05 / param_03;
		while(var_06 > 0)
		{
			var_08 = 1 - var_07 * var_06 * var_06;
			self method_8313(vectorlerp(var_04,param_00,var_08));
			wait(0.05);
			var_06 = var_06 - 0.05;
		}
	}

	self method_8313(param_00);
}

//Function Number: 18
func_8025()
{
	thread tv_changes_intensity();
	thread func_853E();
}

//Function Number: 19
tv_changes_intensity()
{
	self endon("light_off");
	var_00 = self getlightintensity();
	var_01 = var_00;
	for(;;)
	{
		var_02 = randomfloatrange(var_00 * 0.7,var_00 * 1.2);
		var_03 = randomfloatrange(0.3,1.2);
		var_03 = var_03 * 20;
		for(var_04 = 0;var_04 < var_03;var_04++)
		{
			var_05 = var_02 * var_04 / var_03 + var_01 * var_03 - var_04 / var_03;
			self setlightintensity(var_05);
			wait(0.05);
		}

		var_01 = var_02;
	}
}

//Function Number: 20
func_853E()
{
	self endon("light_off");
	var_00 = 0.5;
	var_01 = 0.5;
	var_02 = [];
	var_03 = [];
	for(var_04 = 0;var_04 < 3;var_04++)
	{
		var_02[var_04] = 0;
		var_03[var_04] = 0;
	}

	for(;;)
	{
		for(var_04 = 0;var_04 < var_02.size;var_04++)
		{
			var_03[var_04] = var_02[var_04];
			var_02[var_04] = randomfloat(var_00) + var_01;
		}

		var_05 = randomfloatrange(0.3,1.2);
		var_05 = var_05 * 20;
		for(var_04 = 0;var_04 < var_05;var_04++)
		{
			var_06 = [];
			for(var_07 = 0;var_07 < var_02.size;var_07++)
			{
				var_06[var_07] = var_02[var_07] * var_04 / var_05 + var_03[var_07] * var_05 - var_04 / var_05;
			}

			self method_8313((var_06[0],var_06[1],var_06[2]));
			wait(0.05);
		}
	}
}

//Function Number: 21
func_7D3D(param_00)
{
	var_01 = 1;
	if(isdefined(param_00.var_6B9E))
	{
		var_01 = param_00.var_6B9E;
	}

	for(;;)
	{
		param_00 waittill("trigger",var_02);
		param_00 func_6FA1(var_01);
	}
}

//Function Number: 22
func_6FA1(param_00)
{
	var_01 = getdvarint("sm_sunenable",1);
	var_02 = getdvarfloat("sm_sunshadowscale",1);
	var_03 = getdvarint("sm_spotlimit",4);
	var_04 = getdvarfloat("sm_sunsamplesizenear",0.25);
	var_05 = getdvarfloat("sm_qualityspotshadow",1);
	if(isdefined(self.var_6CCA))
	{
		var_01 = self.var_6CCA;
	}

	if(isdefined(self.var_6CCC))
	{
		var_02 = self.var_6CCC;
	}

	if(isdefined(self.var_6CB6))
	{
		var_03 = self.var_6CB6;
	}

	if(isdefined(self.var_6CCB))
	{
		var_04 = self.var_6CCB;
	}

	var_04 = min(max(0.016,var_04),32);
	if(isdefined(self.var_6C86))
	{
		var_05 = self.var_6C86;
	}

	var_06 = getdvarint("sm_sunenable",1);
	var_07 = getdvarfloat("sm_sunshadowscale",1);
	var_08 = getdvarint("sm_spotlimit",4);
	var_09 = getdvarint("sm_qualityspotshadow",1);
	function_0168("sm_sunenable",var_01);
	function_0168("sm_sunshadowscale",var_02);
	function_0168("sm_spotlimit",var_03);
	function_0168("sm_qualityspotshadow",var_05);
	func_4D92(var_04,param_00);
}

//Function Number: 23
func_4D92(param_00,param_01)
{
	level notify("changing_sunsamplesizenear");
	level endon("changing_sunsamplesizenear");
	var_02 = getdvarfloat("sm_sunSampleSizeNear",0.25);
	if(param_00 == var_02)
	{
	}

	var_03 = param_00 - var_02;
	var_04 = param_01 / 0.05;
	if(var_04 > 0)
	{
		var_05 = var_03 / var_04;
		var_06 = var_02;
		for(var_07 = 0;var_07 < var_04;var_07++)
		{
			var_06 = var_06 + var_05;
			function_0168("sm_sunSampleSizeNear",var_06);
			wait(0.05);
		}
	}

	function_0168("sm_sunSampleSizeNear",param_00);
}

//Function Number: 24
init_scripted_light()
{
	func_4566();
	init_light_def();
}

//Function Number: 25
func_4566()
{
	self.lit_models = [];
	self.var_85B0 = [];
	self.var_4E37 = [];
	if(isdefined(self.target))
	{
		var_00 = getentarray(self.target,"targetname");
		if(var_00.size == 0)
		{
		}

		foreach(var_02 in var_00)
		{
			if(func_480E(var_02))
			{
				self.var_4E37[self.var_4E37.size] = var_02;
				var_02 func_4566();
				continue;
			}

			var_03 = 1;
			if(isdefined(var_02.script_noteworthy))
			{
				if(var_02.script_noteworthy == "on")
				{
					var_03 = 0;
					init_lit_model(var_02);
				}
				else if(var_02.script_noteworthy == "off")
				{
					var_03 = 0;
					self.var_85B0[self.var_85B0.size] = var_02;
				}
			}

			if(var_03)
			{
				init_lit_model(var_02);
				var_04 = getentarray(var_02.target,"targetname");
				foreach(var_06 in var_04)
				{
					self.var_85B0[self.var_85B0.size] = var_06;
				}
			}
		}

		foreach(var_02 in self.lit_models)
		{
			var_02.var_89F4 = 1;
		}

		foreach(var_02 in self.var_85B0)
		{
			var_02.var_89F4 = 0;
			var_02 hide();
		}
	}
}

//Function Number: 26
init_lit_model(param_00)
{
	self.lit_models[self.lit_models.size] = param_00;
	var_01 = undefined;
	var_02 = undefined;
	var_03 = undefined;
	if(isdefined(param_00.script_fxid))
	{
		var_01 = self.script_fxid;
		var_02 = param_00.origin;
		var_03 = param_00.angles;
	}
	else if(isdefined(param_00.target))
	{
		var_04 = common_scripts\utility::func_3C18(param_00.target,"targetname");
		if(isdefined(var_04) && isdefined(var_04.script_fxid))
		{
			var_01 = var_04.script_fxid;
			var_02 = var_04.origin;
			var_03 = (0,0,0);
			if(isdefined(var_04.angles))
			{
				var_03 = var_04.angles;
			}
		}
	}

	if(isdefined(var_01))
	{
		param_00.effect = common_scripts\utility::createoneshoteffect(var_01);
		param_00.effect.var_880E["origin"] = var_02;
		param_00.effect.var_880E["angles"] = var_03;
	}
}

//Function Number: 27
func_623C()
{
	self endon("stop_scripted_light");
	self endon("death");
	for(;;)
	{
		maps\_utility::func_6D02();
		var_00 = self.var_6C05;
		var_01 = self.var_6C05 + self.var_6C04 - self.var_6C05 * 0.4;
		var_02 = self.var_6C04 - self.var_6C04 - self.var_6C05 * 0.4;
		var_03 = self.var_6C04;
		var_04 = randomintrange(self.var_6B6F,self.script_count_max);
		for(var_05 = 0;var_05 < var_04;var_05++)
		{
			var_06 = randomfloatrange(var_00,var_01);
			lerp_intensity(var_06,get_delay());
			maps\_utility::script_delay();
			var_06 = randomfloatrange(var_02,var_03);
			lerp_intensity(var_06,get_delay());
		}

		lerp_intensity(self.var_6C04,get_delay());
	}
}

//Function Number: 28
lerp_intensity(param_00,param_01)
{
	var_02 = castint(param_01 * 20);
	var_03 = self getlightintensity();
	var_04 = param_00 - var_03 / var_02;
	for(var_05 = 0;var_05 < var_02;var_05++)
	{
		thread func_3F17(param_00);
		self setlightintensity(var_03 + var_05 * var_04);
		wait(0.05);
	}

	var_06[0] = self;
	if(isdefined(self.var_4E37))
	{
		var_06 = common_scripts\utility::array_combine(var_06,self.var_4E37);
	}

	foreach(var_08 in var_06)
	{
		var_08 thread func_3F17(param_00);
		var_08 setlightintensity(param_00);
	}
}

//Function Number: 29
func_3F17(param_00)
{
	var_01 = param_00 > self.script_threshold;
	foreach(var_03 in self.lit_models)
	{
		if(var_01 && !var_03.var_89F4)
		{
			var_03.var_89F4 = var_01;
			var_03 show();
			if(isdefined(var_03.effect))
			{
				var_03.effect thread maps\_utility::func_6643();
			}

			continue;
		}

		if(!var_01 && var_03.var_89F4)
		{
			var_03.var_89F4 = var_01;
			var_03 hide();
			if(isdefined(var_03.effect))
			{
				var_03.effect thread common_scripts\utility::func_5B59();
			}
		}
	}

	foreach(var_03 in self.var_85B0)
	{
		if(!var_01 && !var_03.var_89F4)
		{
			var_03.var_89F4 = 1;
			var_03 show();
			continue;
		}

		if(var_01 && var_03.var_89F4)
		{
			var_03.var_89F4 = 0;
			var_03 hide();
		}
	}
}

//Function Number: 30
get_delay()
{
	return randomfloatrange(self.script_delay_min,self.script_delay_max);
}

//Function Number: 31
init_light_def()
{
	var_00["pulse"] = ::func_2488;
	var_00["neon"] = ::func_2487;
	var_00["fire"] = ::def_fire;
	[[ var_00[self.script_light] ]]();
}

//Function Number: 32
func_2488()
{
	func_6E86(0.1,0.2);
	func_6FC6(1,4);
	func_6E68(3,6);
	func_6FAB(0.5);
	var_00 = self getlightintensity();
	func_6F16(var_00 * 0.25,var_00);
	thread func_623C();
}

//Function Number: 33
func_2487()
{
	func_6E86(0.05,0.1);
	func_6FC6(2,5);
	func_6E68(1,3);
	func_6FAB(0.5);
	var_00 = self getlightintensity();
	func_6F16(var_00 * 0.1,var_00);
	thread func_623C();
}

//Function Number: 34
def_fire()
{
	func_6E86(0.05,0.1);
	func_6FC6(0.05,0.1);
	func_6E68(1,2);
	func_6FAB(0.5);
	var_00 = self getlightintensity();
	func_6F16(var_00 * 0.75,var_00);
	thread func_623C();
}

//Function Number: 35
func_6FAB(param_00)
{
	if(!isdefined(self.script_threshold))
	{
		self.script_threshold = param_00;
	}

	foreach(var_02 in self.var_4E37)
	{
		if(!isdefined(var_02.script_threshold))
		{
			var_02.script_threshold = self.script_threshold;
		}
	}
}

//Function Number: 36
func_6E86(param_00,param_01)
{
	if(!isdefined(self.script_delay_min))
	{
		self.script_delay_min = param_00;
	}

	if(!isdefined(self.script_delay_max))
	{
		self.script_delay_max = param_01;
	}
}

//Function Number: 37
func_6FC6(param_00,param_01)
{
	if(!isdefined(self.var_6D05))
	{
		self.var_6D05 = param_00;
	}

	if(!isdefined(self.var_6D04))
	{
		self.var_6D04 = param_01;
	}
}

//Function Number: 38
func_6E68(param_00,param_01)
{
	if(!isdefined(self.var_6B6F))
	{
		self.var_6B6F = param_00;
	}

	if(!isdefined(self.script_count_max))
	{
		self.script_count_max = param_01;
	}
}

//Function Number: 39
func_6F16(param_00,param_01)
{
	if(!isdefined(self.var_6C05))
	{
		self.var_6C05 = param_00;
	}

	if(!isdefined(self.var_6C04))
	{
		self.var_6C04 = param_01;
	}
}